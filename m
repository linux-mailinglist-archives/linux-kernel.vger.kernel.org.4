Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F6666608E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjAKQdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjAKQct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:32:49 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF26F5F4E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:32:24 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 27283588C1A89; Wed, 11 Jan 2023 17:32:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 2695B616497A7;
        Wed, 11 Jan 2023 17:32:23 +0100 (CET)
Date:   Wed, 11 Jan 2023 17:32:23 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Pavel Machek <pavel@ucw.cz>
cc:     Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Subject: Re: Dhrystone -- userland version
In-Reply-To: <Y77WEO43H8eIPA5U@duo.ucw.cz>
Message-ID: <28821r94-886p-5816-7s47-4s0q7p846qp@vanv.qr>
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz> <Y7pRw47hidw+s6+g@mit.edu> <Y7pzbnlXgv+asekg@amd.ucw.cz> <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com> <Y7sPq3Tmm6vI/RAJ@duo.ucw.cz> <Y7tjnhs77o4TL5ey@mit.edu> <614os9n2-2sq1-2qnr-56q6-1qq628271175@vanv.qr>
 <Y77WEO43H8eIPA5U@duo.ucw.cz>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday 2023-01-11 16:30, Pavel Machek wrote:
>
>> (All of) you could install boinc-client and just exercise
>> --run_cpu_benchmarks without (I think) attaching to any particular
>> computing project. The package should be in distros and you get
>> both Dhrystone and Whetstone.
>
>Hehe, nice trick, but it does not work for me:
>
>boinc --run_cpu_benchmarks
>
>does not actually seem to run the benchmarks.

Maybe I misread the manpage.

# runuser -u boinc -- /bin/bash --login
$ cd ~
$ boinccmd --get_messages
11: 11-Jan-2023 17:23:50 (low) [] Processor: 16 AuthenticAMD AMD Ryzen 7 3700X 8-Core Processor [Family 23 Model 113 Stepping 0]
12: 11-Jan-2023 17:23:50 (low) [] Processor features: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sev sev_es
13: 11-Jan-2023 17:23:50 (low) [] OS: Linux openSUSE: openSUSE Tumbleweed [6.1.3|libc 2.36]
...
$ boinccmd --run_benchmarks
...
$ boinccmd --get_messages
30: 11-Jan-2023 17:24:31 (low) [] Running CPU benchmarks
31: 11-Jan-2023 17:24:31 (low) [] Suspending computation - CPU benchmarks in progress
32: 11-Jan-2023 17:25:02 (low) [] Benchmark results:
33: 11-Jan-2023 17:25:02 (low) [] Number of CPUs: 16
34: 11-Jan-2023 17:25:02 (low) [] 7136 floating point MIPS (Whetstone) per CPU
35: 11-Jan-2023 17:25:02 (low) [] 124780 integer MIPS (Dhrystone) per CPU
36: 11-Jan-2023 17:25:03 (low) [] Resuming computation

(This is using the openSUSE boinc-client package. It's modeled as a
daemon/service, so runs without X11 or Wayland, since Geert was wondering.)

>Thanks, but I really want an in-kernel benchmark

Can't have everything :)
