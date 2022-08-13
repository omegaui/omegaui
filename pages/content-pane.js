import 'tailwindcss/defaultTheme';
import { React } from 'react';
import PageButton from './components/page_button';
import OrgButton from './components/org_button';
import SkylineButton from './components/skyline_button';

export default function Home() {
  return (
    // https://skyline.github.com/omegaui/2022
    // 
    <div className='bg-zinc-900'>
      <div className='bg-zinc-900' align='center'>
        <img className='opacity-80' src='https://img.icons8.com/external-bearicons-gradient-bearicons/256/000000/external-Hi-miscellany-texts-and-badges-bearicons-gradient-bearicons.png'/>
        <h1 className='text-3xl font-sans text-gray-300'>I am Arham</h1>
        <h1 className='text-2xl font-sans text-gray-400'>A <strong>passionate</strong>, <strong>powerpacked</strong>, <strong>badass</strong>, self-made programmer and student from India</h1>

        <div className='flex mt-20 ml-10 mr-10 items-center justify-center'>
          <PageButton description="From Developing an entire IDE to writing command line tools, here's an entire play store waiting to be explored!" tooltip={ <p className='text-blue-500 font-sans font-bold text-sm'>My Awesome Projects 😼</p> } placement='left' title='Projects' iconSrc='https://img.icons8.com/color/96/000000/class-dojo.png' handleClick={() => {}}/>  
          <PageButton description='On my journey, I got many, from low level to high level, from web to traditional, I have it all!' tooltip={ <p className='text-blue-500 font-sans font-bold text-sm'>Programming Languages I depend on 🤖</p> } title='Languages' iconSrc='https://img.icons8.com/external-flaticons-lineal-color-flat-icons/96/000000/external-program-award-events-flaticons-lineal-color-flat-icons.png' handleClick={() => {}}/>  
          <PageButton description='I use so .... many tools you just name them, Hmmm... BTW, I use Linux 😉' tooltip={ <p className='text-blue-500 font-sans font-bold text-sm'>Development Tools I use 🐧</p> } title='Tools' iconSrc='https://img.icons8.com/external-basicons-color-edtgraphics/96/000000/external-weapon-weapons-armor-basicons-color-edtgraphics-9.png' handleClick={() => {}}/>  
          <PageButton description='From designing an UI Library to writing an integrated DBMS, From writing Mobile Apps to developing Development Tools for Desktop, till Infinity and Beyond!' tooltip={ <p className='text-blue-500 font-sans font-bold text-sm'>Things I do best ✨</p> } placement='right' title='Skills' iconSrc='https://img.icons8.com/fluency/96/000000/ninja-head.png' handleClick={() => {}}/>  
        </div>

        <div className='w-full mt-8' align='center'>
          <h1 className='text-xl text-white font-mono font-bold'>contributed to</h1>
          <div className='flex bg-zinc-800/20 w-1/4 h-40 mt-5 mb-5 rounded-xl p-2'>
            <OrgButton placement='left' tooltip={ <h1 className='text-white font-bold font-mono text-sm'>JetBrains <p className='text-blue-500 font-sans text-xs'>&rarr; JetBrains Open Source</p></h1> } iconSrc='https://img.icons8.com/color/96/000000/jetbrains.png' url='https://jetbrains.com'/>
            <OrgButton tooltip={ <h1 className='text-white font-bold font-mono text-sm'>AkiraUX <p className='text-blue-500 font-sans text-xs'>&rarr; Modern Resources for Linux Designers</p></h1> } iconSrc='https://avatars.githubusercontent.com/u/47548883?s=96&v=4' url=''/>
            <OrgButton tooltip={ <h1 className='text-white font-bold font-mono text-sm'>Spinlock Labs <p className='text-blue-500 font-sans text-xs'>&rarr; Open Source for Everyone</p></h1> } iconSrc='https://avatars.githubusercontent.com/u/26679435?s=96&v=4' url=''/>
            <OrgButton placement='right' tooltip={ <h1 className='text-white font-bold font-mono text-sm'>BatNoter <p className='text-blue-500 font-sans text-xs'>&rarr; BatNoter - a simple note taking webapp that uses your github repository to store markdown notes! </p></h1> } iconSrc='https://avatars.githubusercontent.com/u/106804252?s=96&v=4' url=''/>
          </div>
          <OrgButton placement='top' tooltip={ <h1 className='text-white font-bold font-mono text-sm'>My GitHub Profile <p className='text-blue-500 font-sans text-xs'>I'm uniquely unique 😎</p></h1> } iconSrc='https://img.icons8.com/fluency/48/000000/github.png' url='https://github.com/omegaui'/>
        </div>
      </div>
      <SkylineButton />
    </div>
  );
}
