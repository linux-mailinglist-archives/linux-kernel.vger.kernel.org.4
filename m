Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745CF6BB5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjCOO1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjCOO1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:27:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCDA838A5;
        Wed, 15 Mar 2023 07:27:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id s22so24544733lfi.9;
        Wed, 15 Mar 2023 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678890429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBgrBuGZL9KCbbmPqMJHrSDvVkfUycBrmH8dtn8yKhY=;
        b=GdotJ7MiDP99F1Cz1UKMUdO3N8TFpm2wtCRSea2y/i+m9pFXr31B5RZSD/itKXAhey
         mzHywza+WpSPORvQoL64NkjlSU9EXRDr1nIlXeh/CACltup115FKOW7kgfcN4JYW6UXw
         SLcN6mF5JoniemlQh4kIXam1v24Hgn8Z701V/k0RZCUxnMrPmg+WHF1eJXaQEmH9SviY
         /CaT10BRVXkxL1rnlzLrWdhQtUxakFfJIlGMSEYbarWfMXQ3r6sr2Thq6VOUODWvAZwG
         b64OZ4OKoGnkOFzjuJx+xXrMuLI8pJQCcZqy92O+wU9TXrlgHqOKH9+QMyk7c8nBB5JV
         2Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678890429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBgrBuGZL9KCbbmPqMJHrSDvVkfUycBrmH8dtn8yKhY=;
        b=iOSw+GS8NM9B8LSWtGd58RKvZCMdyPE61eLqb4zaXL/vJQPbEYSrDM18QH+sE1YZYO
         Ifu0tt3tWjrDHD47baKgCEmf4JhYOKsO8jTqkTenP2wGQjBTOKIk0+LyE+Le56UVi3TP
         UZom/kmCPwbnM8mnCLEwBjFF5tpLdDQih8m5w9Ibw/GKvVoM2ktJ2ZId8ywOm2QtVxcU
         25XK0ijUnzUhs/WcUHhWAxrZughsQLS+mOHbiPicCsugp2MoYKa2N4kkGRRSDFlvjZjb
         PIvHj2+4Ek/5WntZFEtR+8JtaPVRFOlUWPNmJ02qD/e1fN/Dv5cOw3ldcFnxBqYMTfPO
         b20A==
X-Gm-Message-State: AO0yUKWoU1oS5O/wa4TE1fDZWgOH8a0YtLBMXGEqnUQnO8oK1uBApVmX
        +SiWhgqS0Q9LSECbQe91b0v2qaJX9TIrhfSX7fw=
X-Google-Smtp-Source: AK7set/6zVMm/cqEuez+4ncyX8m3G9+7/9uhgvfGp0tGa5hnRcMZwArkQ1eYC47JiM6DR25LXmu9oThTT69scA1KWWE=
X-Received: by 2002:ac2:4a9b:0:b0:4dc:807a:d140 with SMTP id
 l27-20020ac24a9b000000b004dc807ad140mr2027739lfp.10.1678890428567; Wed, 15
 Mar 2023 07:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220826022031.GA76590@inn2.lkp.intel.com> <c8310cba-36ef-2940-b2c2-07573e015185@intel.com>
 <95e604ff-516a-4f7c-7f2c-8ff3d2cc66fa@intel.com>
In-Reply-To: <95e604ff-516a-4f7c-7f2c-8ff3d2cc66fa@intel.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 15 Mar 2023 09:26:59 -0500
Message-ID: <CAH2r5msk7R4qZ-GQT2mKnCWzZ_MzYPUyJwWXuLRUMtt2XtApoA@mail.gmail.com>
Subject: Re: [smb3] 5efdd9122e: filebench.sum_operations/s -50.0% regression
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     kernel test robot <yujie.liu@intel.com>,
        Steve French <stfrench@microsoft.com>, lkp@lists.01.org,
        lkp@intel.com, Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        "Paulo Alcantara (SUSE)" <pc@cjr.nz>, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you verify what this perf looks like with "closetime=3D0" and "closetim=
e=3D1"

Are there differences in /proc/fs/cifs/Stats when you run the same
steps with "closetimeo=3D1" vs. the more recent default (5 seconds)?

On Wed, Mar 15, 2023 at 2:46=E2=80=AFAM Yin, Fengwei <fengwei.yin@intel.com=
> wrote:
>
>
>
> On 8/26/2022 10:41 AM, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed a -50.0% regression of filebench.sum_operations/s due t=
o commit:
> >
> >
> > commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3 ("smb3: allow deferred=
 close timeout to be configurable")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: filebench
> > on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @=
 2.10GHz (Cascade Lake) with 128G memory
> > with following parameters:
> >
> >     disk: 1HDD
> >     fs: ext4
> >     fs2: cifs
> >     test: filemicro_delete.f
> >     cpufreq_governor: performance
> >     ucode: 0x5003302
> Please note, we still could see this regresion on v6.3-rc2. And the regre=
ssion is related with
> the commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3. This commit changed=
 the default timeout
> value from 1s to 5s. If change the timeout back to 1s as following:
>
> diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
> index 6d13f8207e96..6b930fb0c4bd 100644
> --- a/fs/cifs/fs_context.c
> +++ b/fs/cifs/fs_context.c
> @@ -1537,7 +1537,7 @@ int smb3_init_fs_context(struct fs_context *fc)
>
>         ctx->acregmax =3D CIFS_DEF_ACTIMEO;
>         ctx->acdirmax =3D CIFS_DEF_ACTIMEO;
> -       ctx->closetimeo =3D SMB3_DEF_DCLOSETIMEO;
> +       ctx->closetimeo =3D CIFS_DEF_ACTIMEO;
>
>         /* Most clients set timeout to 0, allows server to use its defaul=
t */
>         ctx->handle_timeout =3D 0; /* See MS-SMB2 spec section 2.2.14.2.1=
2 */
>
> The regression is gone:
> dcb45fd7f501f864                    v6.3-rc2 32715af441411a5a266606be08f
> ---------------- --------------------------- ---------------------------
>        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>            |             |             |             |             |
>            :25           0%            :3           33%           1:3    =
 last_state.booting
>            :25           0%            :3           33%           1:3    =
 last_state.is_incomplete_run
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>     515.95           -50.0%     257.98            -0.0%     515.92       =
 filebench.sum_operations/s
>       5.04 =C2=B1  7%    +833.7%      47.09 =C2=B1  2%      -2.9%       4=
.90 =C2=B1  2%  filebench.sum_time_ms/op
>      10438          -100.0%       0.33 =C2=B1141%    -100.0%       0.50 =
=C2=B1100%  filebench.time.major_page_faults
>     167575            -4.1%     160660            -4.4%     160140       =
 filebench.time.maximum_resident_set_size
>       7138 =C2=B1 11%    +141.4%      17235 =C2=B1  3%    +147.6%      17=
677        filebench.time.minor_page_faults
>      28.68 =C2=B1  9%    +199.9%      86.00 =C2=B1  7%      -2.4%      28=
.00        filebench.time.percent_of_cpu_this_job_got
>    2453485 =C2=B1 54%     -63.0%     907380           -66.2%     830273 =
=C2=B1  6%  cpuidle..usage
>       0.61 =C2=B1 38%      +0.8        1.41 =C2=B1  3%      +0.2        0=
.80 =C2=B1  4%  mpstat.cpu.all.sys%
>     142984 =C2=B1 13%     -45.6%      77725           -47.5%      75106  =
      vmstat.system.in
>      34.23 =C2=B1  7%     +27.9%      43.79           +27.8%      43.74  =
      boot-time.boot
>      17.09 =C2=B1 11%     +66.0%      28.38           +65.5%      28.28  =
      boot-time.dhcp
>       2661 =C2=B1  7%     +37.5%       3659           +37.2%       3651  =
      boot-time.idle
>     104737 =C2=B1185%     -87.8%      12762 =C2=B1 10%     -89.8%      10=
631 =C2=B1  4%  turbostat.C1
>
>
> 32715af441411a5a266606be08f is v6.3-rc2 with the change to restore the ti=
meout to 1s. Thanks.
>
> Regards
> Yin, Fengwei
>
>
> >
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/te=
stcase/ucode:
> >   gcc-11/performance/1HDD/cifs/ext4/x86_64-rhel-8.3/debian-11.1-x86_64-=
20220510.cgz/lkp-csl-2sp9/filemicro_delete.f/filebench/0x5003302
> >
> > commit:
> >   dcb45fd7f5 ("cifs: Do not use tcon->cfid directly, use the cfid we ge=
t from open_cached_dir")
> >   5efdd9122e ("smb3: allow deferred close timeout to be configurable")
> >
> > dcb45fd7f501f864 5efdd9122eff772eae2feae9f0f
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >     515.95           -50.0%     257.98        filebench.sum_operations/=
s
> >       4.81 =C2=B1  2%   +1038.4%      54.78 =C2=B1  6%  filebench.sum_t=
ime_ms/op
> >      29.00 =C2=B1  8%    +212.1%      90.50 =C2=B1  3%  filebench.time.=
percent_of_cpu_this_job_got
> >      24629            +2.7%      25297        filebench.time.voluntary_=
context_switches
> >  7.685e+08           +19.3%  9.169e+08 =C2=B1  4%  cpuidle..time
> >       2.53 =C2=B1  6%     -20.6%       2.00 =C2=B1  3%  iostat.cpu.iowa=
it
> >    1506141 =C2=B1  8%     +22.4%    1843256 =C2=B1  3%  turbostat.IRQ
> >       2.00           -50.0%       1.00        vmstat.procs.b
> >      21969 =C2=B1  2%      -9.5%      19885 =C2=B1  2%  vmstat.system.c=
s
> >       3.06 =C2=B1  7%      -0.7        2.35 =C2=B1  4%  mpstat.cpu.all.=
iowait%
> >       0.79 =C2=B1  5%      +0.5        1.27 =C2=B1  2%  mpstat.cpu.all.=
sys%
> >       0.89 =C2=B1  3%      -0.1        0.79 =C2=B1  3%  mpstat.cpu.all.=
usr%
> >      34.55 =C2=B1 14%     -34.8%      22.51 =C2=B1 27%  sched_debug.cfs=
_rq:/.removed.runnable_avg.avg
> >     119.64 =C2=B1  3%     -20.0%      95.69 =C2=B1 17%  sched_debug.cfs=
_rq:/.removed.runnable_avg.stddev
> >      34.55 =C2=B1 14%     -34.8%      22.51 =C2=B1 27%  sched_debug.cfs=
_rq:/.removed.util_avg.avg
> >     119.64 =C2=B1  3%     -20.0%      95.69 =C2=B1 17%  sched_debug.cfs=
_rq:/.removed.util_avg.stddev
> >       5249           +15.8%       6076        meminfo.Active
> >       3866 =C2=B1  2%     +17.7%       4552        meminfo.Active(anon)
> >       1382 =C2=B1  4%     +10.3%       1524 =C2=B1  4%  meminfo.Active(=
file)
> >      69791 =C2=B1 14%     +39.8%      97553 =C2=B1  6%  meminfo.AnonHug=
ePages
> >      72709 =C2=B1  2%     +12.5%      81779 =C2=B1  3%  meminfo.Inactiv=
e(file)
> >      23219           +13.5%      26352 =C2=B1  3%  meminfo.KernelStack
> >     966.50 =C2=B1  2%     +17.7%       1137        proc-vmstat.nr_activ=
e_anon
> >      74302            +6.3%      78977 =C2=B1  2%  proc-vmstat.nr_anon_=
pages
> >      81133            +6.0%      85973        proc-vmstat.nr_inactive_a=
non
> >      18172 =C2=B1  2%     +12.5%      20442 =C2=B1  3%  proc-vmstat.nr_=
inactive_file
> >      23213           +13.5%      26348 =C2=B1  3%  proc-vmstat.nr_kerne=
l_stack
> >      17983            +2.3%      18400        proc-vmstat.nr_mapped
> >       7446 =C2=B1  2%      +5.5%       7853 =C2=B1  3%  proc-vmstat.nr_=
shmem
> >      26888            +1.6%      27306        proc-vmstat.nr_slab_recla=
imable
> >      47220            +3.4%      48803        proc-vmstat.nr_slab_unrec=
laimable
> >     966.50 =C2=B1  2%     +17.7%       1137        proc-vmstat.nr_zone_=
active_anon
> >      81133            +6.0%      85973        proc-vmstat.nr_zone_inact=
ive_anon
> >      18172 =C2=B1  2%     +12.5%      20442 =C2=B1  3%  proc-vmstat.nr_=
zone_inactive_file
> >     361460            +2.5%     370454        proc-vmstat.numa_hit
> >     946.67           +18.6%       1122        proc-vmstat.pgactivate
> >     361562            +2.5%     370553        proc-vmstat.pgalloc_norma=
l
> >     187906            +4.7%     196761        proc-vmstat.pgfault
> >       8189            +2.5%       8395        proc-vmstat.pgreuse
> >  1.097e+09           +15.5%  1.267e+09 =C2=B1  7%  perf-stat.i.branch-i=
nstructions
> >   39079265 =C2=B1  6%     -20.9%   30915354 =C2=B1  4%  perf-stat.i.bra=
nch-misses
> >    5093263 =C2=B1  4%     -23.7%    3884752 =C2=B1  9%  perf-stat.i.cac=
he-misses
> >      29213           -18.7%      23764 =C2=B1  5%  perf-stat.i.context-=
switches
> >  7.666e+09 =C2=B1  4%      +5.7%  8.106e+09 =C2=B1  2%  perf-stat.i.cpu=
-cycles
> >       1877 =C2=B1 15%     +75.1%       3287 =C2=B1 12%  perf-stat.i.cyc=
les-between-cache-misses
> >    1735450 =C2=B1  3%     -12.9%    1512060 =C2=B1  3%  perf-stat.i.iTL=
B-load-misses
> >       2898 =C2=B1  3%     +34.4%       3895 =C2=B1  7%  perf-stat.i.ins=
tructions-per-iTLB-miss
> >       1493           -20.3%       1190 =C2=B1  7%  perf-stat.i.major-fa=
ults
> >       0.09 =C2=B1  3%      +5.8%       0.09 =C2=B1  2%  perf-stat.i.met=
ric.GHz
> >      48.47 =C2=B1 11%      +8.4       56.83 =C2=B1  7%  perf-stat.i.nod=
e-store-miss-rate%
> >     283426 =C2=B1  4%     -21.6%     222190 =C2=B1 10%  perf-stat.i.nod=
e-stores
> >       3.57 =C2=B1  7%      -1.1        2.44 =C2=B1  6%  perf-stat.overa=
ll.branch-miss-rate%
> >       1508 =C2=B1  3%     +39.8%       2108 =C2=B1  9%  perf-stat.overa=
ll.cycles-between-cache-misses
> >       3022 =C2=B1  3%     +23.6%       3736 =C2=B1  5%  perf-stat.overa=
ll.instructions-per-iTLB-miss
> >  9.585e+08           +18.8%  1.138e+09 =C2=B1  6%  perf-stat.ps.branch-=
instructions
> >   34151514 =C2=B1  6%     -18.8%   27725316 =C2=B1  4%  perf-stat.ps.br=
anch-misses
> >    4450329 =C2=B1  5%     -21.7%    3486409 =C2=B1  9%  perf-stat.ps.ca=
che-misses
> >      25524           -16.4%      21333 =C2=B1  4%  perf-stat.ps.context=
-switches
> >      77139            +2.5%      79105        perf-stat.ps.cpu-clock
> >  6.704e+09 =C2=B1  4%      +8.7%  7.287e+09        perf-stat.ps.cpu-cyc=
les
> >   1.06e+09           +11.3%   1.18e+09 =C2=B1  5%  perf-stat.ps.dTLB-lo=
ads
> >    1517349 =C2=B1  3%     -10.5%    1357716 =C2=B1  2%  perf-stat.ps.iT=
LB-load-misses
> >  4.582e+09           +10.8%  5.075e+09 =C2=B1  6%  perf-stat.ps.instruc=
tions
> >       1296           -18.1%       1061 =C2=B1  6%  perf-stat.ps.major-f=
aults
> >     247613 =C2=B1  4%     -19.5%     199283 =C2=B1  9%  perf-stat.ps.no=
de-stores
> >      77139            +2.5%      79105        perf-stat.ps.task-clock
> >  3.697e+10           +35.3%  5.003e+10        perf-stat.total.instructi=
ons
> >       8.51 =C2=B1 91%      -6.9        1.59 =C2=B1223%  perf-profile.ca=
lltrace.cycles-pp.getdents64
> >       8.34 =C2=B1 83%      -6.7        1.67 =C2=B1141%  perf-profile.ca=
lltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_=
exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       6.25 =C2=B1107%      -6.2        0.00        perf-profile.calltra=
ce.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
> >       6.25 =C2=B1107%      -6.2        0.00        perf-profile.calltra=
ce.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
> >       6.25 =C2=B1107%      -6.2        0.00        perf-profile.calltra=
ce.cycles-pp.open64
> >       7.63 =C2=B1 84%      -6.0        1.59 =C2=B1223%  perf-profile.ca=
lltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
> >       7.63 =C2=B1 84%      -6.0        1.59 =C2=B1223%  perf-profile.ca=
lltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
> >       7.63 =C2=B1 84%      -6.0        1.59 =C2=B1223%  perf-profile.ca=
lltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after=
_hwframe.getdents64
> >       7.63 =C2=B1 84%      -6.0        1.59 =C2=B1223%  perf-profile.ca=
lltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe.getdents64
> >       6.26 =C2=B1115%      -5.4        0.88 =C2=B1223%  perf-profile.ca=
lltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_=
after_hwframe
> >       6.26 =C2=B1115%      -5.4        0.88 =C2=B1223%  perf-profile.ca=
lltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_sy=
scall_64.entry_SYSCALL_64_after_hwframe
> >       6.26 =C2=B1115%      -4.6        1.67 =C2=B1141%  perf-profile.ca=
lltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_t=
o_user_mode_loop.exit_to_user_mode_prepare
> >       6.26 =C2=B1115%      -4.6        1.67 =C2=B1141%  perf-profile.ca=
lltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restar=
t.exit_to_user_mode_loop
> >       6.26 =C2=B1115%      -4.6        1.67 =C2=B1141%  perf-profile.ca=
lltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_=
user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
> >       6.26 =C2=B1115%      -4.6        1.67 =C2=B1141%  perf-profile.ca=
lltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_lo=
op.exit_to_user_mode_prepare.syscall_exit_to_user_mode
> >       4.57 =C2=B1 73%      -3.8        0.76 =C2=B1223%  perf-profile.ca=
lltrace.cycles-pp.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.r=
ecord__mmap_read_evlist.__cmd_record
> >       4.57 =C2=B1 73%      -3.8        0.76 =C2=B1223%  perf-profile.ca=
lltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.pe=
rf_mmap__push.record__mmap_read_evlist
> >       4.57 =C2=B1 73%      -3.8        0.76 =C2=B1223%  perf-profile.ca=
lltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.perf=
_mmap__read_head.perf_mmap__push
> >       4.57 =C2=B1 73%      -3.8        0.76 =C2=B1223%  perf-profile.ca=
lltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read_ev=
list.__cmd_record.cmd_record
> >       3.38 =C2=B1103%      -3.4        0.00        perf-profile.calltra=
ce.cycles-pp.unmap_vmas.exit_mmap.mmput.exit_mm.do_exit
> >       3.38 =C2=B1103%      -3.4        0.00        perf-profile.calltra=
ce.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.exit_mm
> >       3.38 =C2=B1103%      -3.4        0.00        perf-profile.calltra=
ce.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
> >       3.38 =C2=B1103%      -3.4        0.00        perf-profile.calltra=
ce.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_m=
map
> >       8.51 =C2=B1 91%      -6.9        1.59 =C2=B1223%  perf-profile.ch=
ildren.cycles-pp.getdents64
> >       8.34 =C2=B1 83%      -6.7        1.67 =C2=B1141%  perf-profile.ch=
ildren.cycles-pp.exit_to_user_mode_prepare
> >       8.34 =C2=B1 83%      -6.7        1.67 =C2=B1141%  perf-profile.ch=
ildren.cycles-pp.exit_to_user_mode_loop
> >       8.34 =C2=B1 83%      -6.7        1.67 =C2=B1141%  perf-profile.ch=
ildren.cycles-pp.syscall_exit_to_user_mode
> >       6.25 =C2=B1107%      -6.2        0.00        perf-profile.childre=
n.cycles-pp.open64
> >       7.63 =C2=B1 84%      -6.0        1.59 =C2=B1223%  perf-profile.ch=
ildren.cycles-pp.__x64_sys_getdents64
> >       7.63 =C2=B1 84%      -6.0        1.59 =C2=B1223%  perf-profile.ch=
ildren.cycles-pp.iterate_dir
> >       6.26 =C2=B1115%      -4.6        1.67 =C2=B1141%  perf-profile.ch=
ildren.cycles-pp.arch_do_signal_or_restart
> >       6.26 =C2=B1115%      -4.6        1.67 =C2=B1141%  perf-profile.ch=
ildren.cycles-pp.get_signal
> >       4.57 =C2=B1 73%      -3.8        0.76 =C2=B1223%  perf-profile.ch=
ildren.cycles-pp.perf_mmap__read_head
> >       3.38 =C2=B1103%      -3.4        0.00        perf-profile.childre=
n.cycles-pp.unmap_vmas
> >       3.38 =C2=B1103%      -3.4        0.00        perf-profile.childre=
n.cycles-pp.unmap_page_range
> >       3.38 =C2=B1103%      -3.4        0.00        perf-profile.childre=
n.cycles-pp.zap_pmd_range
> >       3.38 =C2=B1103%      -3.4        0.00        perf-profile.childre=
n.cycles-pp.zap_pte_range
> >       8.54 =C2=B1 43%      +8.6       17.19 =C2=B1 38%  perf-profile.ch=
ildren.cycles-pp.asm_exc_page_fault
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <yujie.liu@intel.com>
> >
> >
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         sudo bin/lkp install job.yaml           # job file is attached =
in this email
> >         bin/lkp split-job --compatible job.yaml # generate the yaml fil=
e for lkp run
> >         sudo bin/lkp run generated-yaml-file
> >
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> >
> >
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are pr=
ovided
> > for informational purposes only. Any difference in system hardware or s=
oftware
> > design or configuration may affect actual performance.
> >
> >
> > #regzbot introduced: 5efdd9122e
> >
> >



--=20
Thanks,

Steve
