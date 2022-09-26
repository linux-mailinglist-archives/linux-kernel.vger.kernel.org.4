Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966DB5EAE76
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiIZRq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIZRqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:46:37 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEAF7E31C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:17:00 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 126so9154650ybw.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=/h3BeLjdxneBW5Lpw3vPKkigHV9sjtKp4hks7QqaOYM=;
        b=MoY1PU4Bxd5/q9xm1A7lEAht4nTfj/Hi0ik6EBlcAAvf8G3devq5OwMmrLRwOg4fzV
         F7NOB0JkrSNt7MrwUtP8rWduRzVZDs/bxrikTqp/iGGo2Ei0INrCOyCR6kCwAWEA3HiK
         w56ndbmxEFAKXEMGfLboeeYY8gFQnn6BayoiuVOGMGggPbetnRAw9Z4lTPc5/4k6tB9/
         S879GtCc9g00YTR5F8MhSHNhwYRqI4XJD5Egv77cwwjfXgEYpzMb0lmQu+t7dcokxhS4
         rc/C5oqQVKmuBFsN70twXTkpwIMeGqrBHNyEIEdN4/2DjdX47EWBQaHTn0gNO1Ymyqzc
         17YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/h3BeLjdxneBW5Lpw3vPKkigHV9sjtKp4hks7QqaOYM=;
        b=2n+ChsPoK8CQfVQEIaRBbeBCHeZNlTzYxyNmHEAeVxklqmg5AKpnFdZTvvJEsnQ/rK
         cke2KYvXsTdSsZa2eGEYvjQnG1Qssc2VD0jsOfzOVDq3aVLy84xmJpeq+6iOw2X4GFfC
         kiSHGma5HSWIOGfJ5HtfIlzCuxVFKqGvThfVIT0CCWyxjuk5m1ixuIxwhAGFo7Av8cOG
         89SgMP/lLWD+9pZrLS0JFSLvIySfi3JBto1owJKnOCCvUZb6D74Im0cvDR9tfLmHVKFX
         W2YoLeq95Y44IPWo1oJ7eQNgUPym8YE54+wKq/begsG9T1qh45XuCxRdw6AdmBPOIuzi
         +Ccw==
X-Gm-Message-State: ACrzQf3sTiSwPteJ7jBi3lYpERJbffNRAVPW4gYmSmCx4BSgltg1fex9
        szfFjFd9g7BScJld84dR5vxn0+/RrnfrlZTE1fo=
X-Google-Smtp-Source: AMsMyM5AVTUQSwaa9z3PpO0XSQ+e/ECPveCvinPqCAczJA7ny/rugrv//pFweLOFvKS3yMfbd+D4aeKZAFiFI63aPwM=
X-Received: by 2002:a25:11c3:0:b0:6ba:51bf:5ce3 with SMTP id
 186-20020a2511c3000000b006ba51bf5ce3mr9126270ybr.494.1664212619281; Mon, 26
 Sep 2022 10:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAFcO6XNk5Wtjju=DBOcJr46miBbaWT7jL+zjhWMp+xnz7k5K9A@mail.gmail.com>
 <87v8pa306x.wl-tiwai@suse.de>
In-Reply-To: <87v8pa306x.wl-tiwai@suse.de>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Tue, 27 Sep 2022 01:16:48 +0800
Message-ID: <CAFcO6XP2MpiAsF7YXYjgh7FMq+hyzFJjK8iBf=ccZ2B6BpNvOg@mail.gmail.com>
Subject: Re: A divide error bug in snd_pcm_write
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest kernel upstream.
Yes, but using mmap, you can map the runtime->status page, and then
copy the data through memcpy to overwrite the status->state data, or
even more, which is incredible.
this is debug log:
````
gef=E2=9E=A4  c
Continuing.
Cannot remove breakpoints because program is no longer writable.
Further execution is probably impossible.

Thread 2 hit Hardware access (read/write) watchpoint 7: *0xffff88804c5cb000

Old value =3D 0x0
New value =3D 0x7665642f
0xffffffff828501a9 in snd_pcm_write (file=3D<optimized out>,
buf=3D0x20000000 "/dev/snd/pcmC#D#p", count=3D0x18,
offset=3D0xffffc9000a81bf08) at sound/core/pcm_native.c:3494
3494 if (runtime->status->state =3D=3D SNDRV_PCM_STATE_OPEN ||

   0xffffffff82850199 <snd_pcm_write+25> (bad)  [rsi+riz*2+0x48]
   0xffffffff8285019d <snd_pcm_write+29> mov    eax, DWORD PTR [rbx+0x100]
   0xffffffff828501a3 <snd_pcm_write+35> test   DWORD PTR [rax], 0xfffffff7
 =E2=86=92 0xffffffff828501a9 <snd_pcm_write+41> je     0xffffffff82850216
<snd_pcm_write+150> NOT taken [Reason: !(Z)]
   0xffffffff828501ab <snd_pcm_write+43> mov    rax, rdx
   0xffffffff828501ae <snd_pcm_write+46> mov    rcx, rdx
   0xffffffff828501b1 <snd_pcm_write+49> xor    edx, edx
   0xffffffff828501b3 <snd_pcm_write+51> div    QWORD PTR [rbx+0x90]
   0xffffffff828501ba <snd_pcm_write+58> test   rdx, rdx
[!] Command 'context' failed to execute properly, reason: argument of
type 'NoneType' is not iterable
gef=E2=9E=A4  p/x 0xffff88804c5cb000
$14 =3D 0xffff88804c5cb000
gef=E2=9E=A4  x/10gx  0xffff88804c5cb000
0xffff88804c5cb000: 0x646e732f7665642f 0x234423436d63702f
0xffff88804c5cb010: 0x0000000000000070 0x0000000000000000
0xffff88804c5cb020: 0x0000000000000000 0x0000000000000000
0xffff88804c5cb030: 0x0000000000000000 0x0000000000000000
0xffff88804c5cb040: 0x0000000000000000 0x0000000000000000
gef=E2=9E=A4  x/s  0xffff88804c5cb000
0xffff88804c5cb000: "/dev/snd/pcmC#D#p"
gef=E2=9E=A4  p/x *(struct snd_pcm_mmap_status *)0xffff88804c5cb000
$15 =3D {
  state =3D 0x7665642f,
  pad1 =3D 0x646e732f,
  __pad1 =3D 0xffff88804c5cb008,
  hw_ptr =3D 0x234423436d63702f,
  __pad2 =3D 0xffff88804c5cb010,
  tstamp =3D {
    tv_sec =3D 0x70,
    tv_nsec =3D 0x0
  },
  suspended_state =3D 0x0,
  pad3 =3D 0x0,
  audio_tstamp =3D {
    tv_sec =3D 0x0,
    tv_nsec =3D 0x0
  }
}
gef=E2=9E=A4
````

Regards,
 butt3rflyh4ck.




On Mon, Sep 26, 2022 at 6:21 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 26 Sep 2022 11:26:17 +0200,
> butt3rflyh4ck wrote:
> >
> > Hi, there is a divide error bug in snd_pcm_write in
> > sound/core/pcm_native.c in the latest kernel.
> >
> > ##Root Cause
> > When open the device of /dev/snd/pcmC#D#p, there would attach a
> > runtime to pcm->substream via snd_pcm_open_substream. see the code
> > below:
> > ```
> > int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
> >     struct file *file,
> >     struct snd_pcm_substream **rsubstream)
> > {
> > ......
> >
> >  runtime =3D kzalloc(sizeof(*runtime), GFP_KERNEL);
> > if (runtime =3D=3D NULL)
> > return -ENOMEM;
> >
> > size =3D PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status));
> > runtime->status =3D alloc_pages_exact(size, GFP_KERNEL);
> > if (runtime->status =3D=3D NULL) {
> > kfree(runtime);
> > return -ENOMEM;
> > }
> > memset(runtime->status, 0, size);
> >
> > size =3D PAGE_ALIGN(sizeof(struct snd_pcm_mmap_control));
> > runtime->control =3D alloc_pages_exact(size, GFP_KERNEL);
> > if (runtime->control =3D=3D NULL) {
> > free_pages_exact(runtime->status,
> >       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status)));
> > kfree(runtime);
> > return -ENOMEM;
> > }
> > memset(runtime->control, 0, size);
> >
> > init_waitqueue_head(&runtime->sleep);
> > init_waitqueue_head(&runtime->tsleep);
> >
> > runtime->status->state =3D SNDRV_PCM_STATE_OPEN;
> > mutex_init(&runtime->buffer_mutex);
> > atomic_set(&runtime->buffer_accessing, 0);
> >
> > substream->runtime =3D runtime;
> > substream->private_data =3D pcm->private_data;
> > substream->ref_count =3D 1;
> > substream->f_flags =3D file->f_flags;
> > substream->pid =3D get_pid(task_pid(current));
> > pstr->substream_opened++;
> > *rsubstream =3D substream;
> > return 0;
> > }
> > ```
> > It would kzmalloc a new runtime. And initialize runtime simply.
> > If we write some data to the device. it would call snd_pcm_write or
> > snd_pcm_writev. and read some date from the device, it would call
> > snd_pcm_read or snd_pcm_readv.
> > Anyway, the four function would use data of runtime, but some data of
> > runtime is NULL not be initialized, see the code below:
> > ```
> > static ssize_t snd_pcm_write(struct file *file, const char __user *buf,
> >     size_t count, loff_t * offset)
> > {
> > struct snd_pcm_file *pcm_file;
> > struct snd_pcm_substream *substream;
> > struct snd_pcm_runtime *runtime;
> > snd_pcm_sframes_t result;
> >
> > pcm_file =3D file->private_data;
> > substream =3D pcm_file->substream;
> > if (PCM_RUNTIME_CHECK(substream))
> > return -ENXIO;
> > runtime =3D substream->runtime;
> > if (runtime->status->state =3D=3D SNDRV_PCM_STATE_OPEN ||
> >    runtime->status->state =3D=3D SNDRV_PCM_STATE_DISCONNECTED)
> > return -EBADFD;
> > if (!frame_aligned(runtime, count))    ///////  [1]
> > return -EINVAL;
> > count =3D bytes_to_frames(runtime, count);    /////// [2]
> > result =3D snd_pcm_lib_write(substream, buf, count);
> > if (result > 0)
> > result =3D frames_to_bytes(runtime, result);
> > return result;
> > }
> > ```
> > [1] call frame_aligned to aligned.
> > ```
> > static inline int frame_aligned(struct snd_pcm_runtime *runtime, ssize_=
t bytes)
> > {
> > return bytes % runtime->byte_align =3D=3D 0;
> > }
> > ```
> > but runtime->byte_align is NULL.
> >
> > [2] call bytes_to_frames.
> > ```
> > static inline ssize_t frames_to_bytes(struct snd_pcm_runtime *runtime,
> > snd_pcm_sframes_t size)
> > {
> > return size * runtime->frame_bits / 8;
> > }
> > ```
> > but runtime->frame_bits is NULL.
> >
> > ##reproduce it
> > [ 1189.305083][ T4656] divide error: 0000 [#1] PREEMPT SMP
> > [ 1189.305600][ T4656] CPU: 1 PID: 4656 Comm: snd_pcm_write Not
> > tainted 6.0.0-rc7 #16
> > [ 1189.306157][ T4656] Hardware name: QEMU Standard PC (i440FX + PIIX,
> > 1996), BIOS 1.13.0-1ubuntu1 04/01/2014
> > [ 1189.306760][ T4656] RIP: 0010:snd_pcm_write+0x33/0xa0
> > [ 1189.307155][ T4656] Code: 8b 38 48 85 ff 74 72 48 8b 9f c0 00 00 00
> > 48 85 db 74 66 48 8b 83 00 01 00 00 f7 00 f7 ff ff ff 74 6b 48 89 d0
> > 48 89 d1 31 d2 <48> f7 b3 91
> > [ 1189.308553][ T4656] RSP: 0018:ffffc9000adc7e68 EFLAGS: 00010246
> > [ 1189.309034][ T4656] RAX: 0000000000000000 RBX: ffff888048ec2000
> > RCX: 0000000000000000
> > [ 1189.309583][ T4656] RDX: 0000000000000000 RSI: 0000000000000000
> > RDI: ffff888046fc9c00
> > [ 1189.310163][ T4656] RBP: 0000000000000000 R08: 0000000000000000
> > R09: 0000000000020026
> > [ 1189.310679][ T4656] R10: 0000000000000001 R11: 0000000000000000
> > R12: 0000000000000000
> > [ 1189.311226][ T4656] R13: ffffc9000adc7f08 R14: 0000000000000000
> > R15: 0000000000000000
> > [ 1189.311754][ T4656] FS:  00000000012d8880(0000)
> > GS:ffff88807ec00000(0000) knlGS:0000000000000000
> > [ 1189.312350][ T4656] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [ 1189.312780][ T4656] CR2: 0000000020000000 CR3: 000000004b496000
> > CR4: 00000000000006e0
> > [ 1189.313234][ T4656] Call Trace:
> > [ 1189.313424][ T4656]  <TASK>
> > [ 1189.313597][ T4656]  vfs_write+0xe6/0x4d0
> > [ 1189.313836][ T4656]  ksys_write+0x60/0xe0
> > [ 1189.314071][ T4656]  do_syscall_64+0x35/0xb0
> > [ 1189.314324][ T4656]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [ 1189.314734][ T4656] RIP: 0033:0x44dc3d
> > [ 1189.315007][ T4656] Code: 28 c3 e8 36 29 00 00 66 0f 1f 44 00 00 f3
> > 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
> > 4c 24 08 0f 05 <48> 3d 01 f8
> > [ 1189.316338][ T4656] RSP: 002b:00007ffcbdf5ef38 EFLAGS: 00000246
> > ORIG_RAX: 0000000000000001
> > [ 1189.317012][ T4656] RAX: ffffffffffffffda RBX: 0000000000400530
> > RCX: 000000000044dc3d
> > [ 1189.317693][ T4656] RDX: 0000000000000000 RSI: 0000000000000000
> > RDI: 0000000000000003
> > [ 1189.318172][ T4656] RBP: 00007ffcbdf5ef50 R08: 0000000082000000
> > R09: 0000000000000000
> > [ 1189.318648][ T4656] R10: 000000000000ffff R11: 0000000000000246
> > R12: 00000000004030a0
> > [ 1189.319182][ T4656] R13: 0000000000000000 R14: 00000000004c5018
> > R15: 0000000000000000
>
> The question is how the code passes the check before [1]:
>
>  if (runtime->status->state =3D=3D SNDRV_PCM_STATE_OPEN ||
>      runtime->status->state =3D=3D SNDRV_PCM_STATE_DISCONNECTED)
>         return -EBADFD;
>
> The uninitialized state should have been with SNDRV_PCM_STATE_OPEN,
> and runtime->byte_align is set up at snd_pcm_hw_params() followed by
> snd_pcm-set_state() to chage the state to SNDRV_PCM_STATE_SETUP.
>
> Which kernel version are you testing?
>
>
> Takashi



--
Active Defense Lab of Venustech
