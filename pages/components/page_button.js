import { Tooltip, Whisper } from "rsuite";

export default function PageButton({ title, iconSrc, handleClick, placement='top', tooltip, description='' }){
    return (
        <Whisper
            placement={placement}
            controlId="control-id-${placement}"
            speaker={ <Tooltip> {tooltip} </Tooltip> }
        >
            <button className='hover:shadow-indigo-500 hover:shadow-lg p-10 w-80 m-2 bg-zinc-800/25 hover:bg-zinc-800/30 rounded-3xl block hover:opacity-80 hover:animate-pulse border-2 border-zinc-900 hover:border-blue-600 active:motion-safe:animate-ping' onClick={() => handleClick()}>
                <div align='center'>
                    <img src={ iconSrc }/>
                    <h1 className='text-lg text-white font-bold font-sans'> { title } </h1>
                    <h1 className='text-sm text-gray-500 font-bold font-sans'> { description } </h1>
                </div>
            </button>
        </Whisper>
    );
}


