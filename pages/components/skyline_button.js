import { Tooltip, Whisper } from "rsuite";


export default function SkylineButton(){
    return (
        <Whisper
            placement='right'
            controlId="control-id-right"
            speaker={ <Tooltip> <h1 className='text-white font-bold font-sans text-xs'>See My Contribution Skyline 2022 &rarr;</h1> </Tooltip> }
        >
            <button className="bg-zinc-700/50 w-20 h-20 rounded-full p-2 absolute left-10 top-10 hover:bg-zinc-700/25">
                <img className='m-auto' src='https://img.icons8.com/external-flat-land-kalash/128/000000/external-city-city-elements-flat-land-kalash-2.png' />
            </button>
        </Whisper>
    );
}


