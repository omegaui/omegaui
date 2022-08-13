import Link from "next/link";
import { Tooltip, Whisper } from "rsuite";

export default function OrgButton({ tooltip, iconSrc, url, placement='bottom' }){
    return (
        <Whisper
            placement={placement}
            controlId="control-id-${placement}"
            speaker={ <Tooltip> {tooltip} </Tooltip> }
        >
            <button className='hover:shadow-yellow-500 hover:shadow-md hover:animate-pulse active:animate-ping m-auto p-5 rounded-xl hover:bg-zinc-900/50 hover:border-amber-500 border-2 border-transparent'>
                <Link href={ url }>
                    <img className='' src={ iconSrc } />
                </Link>
            </button>
        </Whisper>
    );
}




