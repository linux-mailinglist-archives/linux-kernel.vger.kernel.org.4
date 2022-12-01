Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8233E63F893
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiLATtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiLATta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:49:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907175ADD5;
        Thu,  1 Dec 2022 11:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669924168; x=1701460168;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xT/T8yXrpuxNMJJDFggaxlZlwhLz8Iw5BQUGuYbkXYc=;
  b=XxfD+DQP4E40FqaTDsifm130q3mYpEupozeHQyu1yEazQfkg7qlR1EHG
   y/zu2w7GBuc6n+rgsb6cnKWOMUYBzHnWqAkSK+imo7h1JppU7FBBa518R
   6dYCEbtS3uMgpe0S+zXPjZn+fhACO+uyl6rEAgCZQu6SBxMZe+j8GqrXM
   meEGtckOIJDAIS6vO1YvIdd6tqJsC1V0bRmMnSWNdMejdW2SlrfiT8xNM
   2VYzE2Wa/FWrrbwix2Ga5WupO+6ppBo54DMPwa77To3sMMmve4Qgdi0CC
   us3gT0yEdl2U7r6pa3DSSBidXnHRw4HKlO/vc8wRgpZ5szoNfGOfrQ8+y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="402064726"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="402064726"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 11:49:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="769355207"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="769355207"
Received: from vrielly-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.177.247])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 11:49:27 -0800
Message-ID: <f9759f538b7354d0e16af024f05159f4542d8cd3.camel@linux.intel.com>
Subject: Re: Using nr_cpus breaks no_turbo setting of pstate driver
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org
Cc:     surajjs@amazon.com
Date:   Thu, 01 Dec 2022 11:49:27 -0800
In-Reply-To: <9e888eea-4bb5-70e9-29ff-c955736c5ba8@amazon.com>
References: <9b23e9d4-7c7a-a74f-3a6b-939a4a469c2b@amazon.com>
         <2b3c7457d34f05ab42c7577bbda10033147d5f4b.camel@linux.intel.com>
         <8af0c78c-6017-bd99-a4e6-29295b8f646a@amazon.com>
         <84472a6904fa12ec1c51879eac11d4735c80936a.camel@linux.intel.com>
         <9e888eea-4bb5-70e9-29ff-c955736c5ba8@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-01 at 10:32 -0800, Bhatnagar, Rishabh wrote:
> 
> On 12/1/22 8:56 AM, srinivas pandruvada wrote:
> > 
> > *CAUTION*: This email originated from outside of the organization.
> > Do 
> > not click links or open attachments unless you can confirm the
> > sender 
> > and know the content is safe.
> > 
> > 
> > 
> > On Wed, 2022-11-30 at 17:03 -0800, Bhatnagar, Rishabh wrote:
> > > 
> > > On 11/30/22 8:40 AM, srinivas pandruvada wrote:
> > > > CAUTION: This email originated from outside of the
> > > > organization. Do 
> > > > not click links or open attachments unless you can confirm the 
> > > > sender and know the content is safe.
> > > > 
> > > > 
> > > > 
> > > > Hi Rishabh,
> > > > 
> > > > I think this is because of request of SMT and the the following
> > > > CPUID
> > > > flag is set to false.
> > > > # cpuid -1 -l 6 | grep ignoring
> > > > ignoring idle logical processor HWP req = false
> > > > 
> > > No this flag is not there in my cpuid output. here are the HWP
> > > flags i
> > > could see:
> > > 
> > >        HWP base registers                      = true
> > >        HWP notification                        = false
> > >        HWP activity window                     = true
> > >        HWP energy performance preference       = true
> > >        HWP package level request               = true
> > > 
> > > > The way CPUs are numbered, the SMT starts at number 24. So,
> > > > nr_cpus=24
> > > > didn't bring up any SMT for driver to control.
> > > 
> > > I tried experiment with nr_cpus=25. Seems like the core which has
> > > both
> > > cpus enabled follows the turbo limits and rest do not.
> > > Can you explain how SMT is related to cpus staying in turbo
> > > frequency?
> > The frequency controls happens at core level not at SMT level. The 
> > default  max powerup SMT HWP max request is 0xFF.
> > Since this is not controlled by the intel_pstate, the request from
> > SMT 
> > (which was not part of powerup CPUs) is higher.
> > The higher one wins.
> > 
> > Thanks,
> > Srinivas
> 
> So what i understand is that even though SMT is not enabled because
> of 
> reduced cpus it has a initial default vote of 255. (Does this vote
> show 
> up in any register in turbostat output?)
Turbostat reads MSRs and you need an online CPU to read.

> 
> This default request always overpowers what we set in HWP_REQUEST.
> 
> Isn't this an issue with the implementation since if we boot with 
> reduced cpus they don't come down from turbo frequencies unless msr
> is 
> touched?
What can be done in the implementation, when you can't see a CPU?
CPU numbering should be friendly to boot reduced number of CPUs to
disable SMT.

You can always boot all CPUs and then offline unwanted CPUs.

>  Or this behavior desired?
> 
> Also one more observation i couldn't explain was if i manually set 
> smt/control off dynamically (nr_cpus=24) then also the cpus come down
> from turbo frequencies. How does disabling smt help here?
> 
Disabling from BIOS may do something differently.

Thanks,
Srinivas

> > 
> > > Also if i dynamically offline 24 cpus then i don't see this
> > > issue. It
> > > only appears when booted with 24 cpus.
> > > 
> > > ^CPackage       Core    CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz
> > > IRQ
> > > SMI     POLL    C1      POLL%   C1%     CPU%c1  CPU%c6 CoreTmp
> > > PkgTmp
> > > Pkg%pc2 Pkg%pc6 PkgWatt RAMWatt PKG_%   RAM_%
> > > -       -       -       4379    99.64   4395    3800 3780 0
> > > 0       0       0.00    0.00    0.36    0.00    88 88      0.00
> > > 0.00    479.85  66.88   0.00    0.00
> > > *0       0       0       3788    99.68   3800    3800 146 0
> > > 0       0       0.00    0.00    0.32    0.00    72 88      0.00
> > > 0.00    239.97  30.38   0.00    0.00**
> > > **0       0       24      3788    99.68   3800    3800 146     0
> > > 0       0       0.00    0.00    0.32*
> > > 0       1       1       4372    99.63   4388    3800 146 0
> > > 0       0       0.00    0.00    0.37    0.00    84
> > > 0       2       2       4372    99.63   4388    3800 146 0
> > > 0       0       0.00    0.00    0.37    0.00    88
> > > 0       4       3       4372    99.63   4388    3800 174 0
> > > 0       0       0.00    0.00    0.37    0.00    83
> > > 0       9       4       4372    99.63   4388    3800 146 0
> > > 0       0       0.00    0.00    0.37    0.00    86
> > > 0       10      5       4372    99.63   4388    3800 150 0
> > > 0       0       0.00    0.00    0.37    0.00    87
> > > 0       11      6       4372    99.63   4388    3800 146 0
> > > 0       0       0.00    0.00    0.37    0.00    87
> > > 0       16      7       4372    99.63   4388    3800 146 0
> > > 0       0       0.00    0.00    0.37    0.00    84
> > > 0       17      8       4372    99.64   4388    3800 146 0
> > > 0       0       0.00    0.00    0.36    0.00    86
> > > 0       18      9       4372    99.64   4388    3800 146 0
> > > 0       0       0.00    0.00    0.36    0.00    84
> > > 0       19      10      4372    99.63   4388    3800 146 0
> > > 0       0       0.00    0.00    0.37    0.00    84
> > > 0       27      11      4372    99.62   4388    3800 148 0
> > > 0       0       0.00    0.00    0.38    0.00    84
> > > 1       1       12      4484    99.64   4500    3800 147 0
> > > 0       0       0.00    0.00    0.36    0.00    69 73      0.00
> > > 0.00    239.83  36.49   0.00    0.00
> > > 1       2       13      4484    99.64   4500    3800 147 0
> > > 0       0       0.00    0.00    0.36    0.00    73
> > > 1       4       14      4484    99.64   4500    3800 146 0
> > > 0       0       0.00    0.00    0.36    0.00    67
> > > 1       8       15      4484    99.65   4500    3800 146 0
> > > 0       0       0.00    0.00    0.35    0.00    68
> > > 1       9       16      4484    99.64   4500    3800 146 0
> > > 0       0       0.00    0.00    0.36    0.00    70
> > > 1       10      17      4484    99.64   4500    3800 146 0
> > > 0       0       0.00    0.00    0.36    0.00    68
> > > 1       11      18      4484    99.64   4500    3800 146 0
> > > 0       0       0.00    0.00    0.36    0.00    72
> > > 1       16      19      4484    99.65   4500    3800 146 0
> > > 0       0       0.00    0.00    0.35    0.00    69
> > > 1       18      20      4484    99.65   4500    3800 146 0
> > > 0       0       0.00    0.00    0.35    0.00    64
> > > 1       19      21      4484    99.65   4500    3800 146 0
> > > 0       0       0.00    0.00    0.35    0.00    67
> > > 1       24      22      4484    99.64   4500    3800 146 0
> > > 0       0       0.00    0.00    0.36    0.00    72
> > > 1       27      23      4484    99.64   4500    3800 240 0
> > > 0       0       0.00    0.00    0.36    0.00    65
> > > 
> > > > The default power up MSR_HWP_REQ.max is 0xFF, this will also
> > > > play role
> > > > in resolving the max frequency. Here driver is disabling turbo
> > > > by
> > > > controlling MSR_HWP_REQ.max.
> > > > 
> > > > If you want to disable turbo here with reduced nr_cpus, you can
> > > > set bit
> > > > 38 of MSR 0x1a0 using msr tools.
> > > Trying to get more understanding on why does the default way of
> > > setting
> > > no_turbo not work with reduced cpus?
> > > I verified this works for nr_cpus=24/25.
> > > > 
> > > > Thanks,
> > > > Srinivas
> > > > 
> > > > 
> > > > On Wed, 2022-11-30 at 08:10 -0800, Bhatnagar, Rishabh wrote:
> > > > > "Having some issue with my mails failing to deliver. So
> > > > > trying once
> > > > > again after disabling HTML."
> > > > > 
> > > > > 
> > > > > Hi Srinivas/Len,
> > > > > 
> > > > > 
> > > > > I have been doing some testing on m5zn.metal AWS instances
> > > > > which
> > > > > provides 48 vcpus and 192GB memory.
> > > > > 
> > > > > Test includes loading all cpus with maximum capacity (using
> > > > > stress)
> > > > > and
> > > > > observing the frequency after enabling and disabling turbo
> > > > > frequencies.
> > > > > Intel_pstate is enabled with hwp.
> > > > > 
> > > > > 
> > > > > lscpu output for reference:
> > > > > 
> > > > > *# lscpu*
> > > > > Architecture:        x86_64
> > > > > CPU op-mode(s):      32-bit, 64-bit
> > > > > Byte Order:          Little Endian
> > > > > CPU(s):              48
> > > > > On-line CPU(s) list: 0-47
> > > > > Thread(s) per core:  2
> > > > > Core(s) per socket:  12
> > > > > Socket(s):           2
> > > > > NUMA node(s):        2
> > > > > Vendor ID:           GenuineIntel
> > > > > CPU family:          6
> > > > > Model:               85
> > > > > Model name:          Intel(R) Xeon(R) Platinum 8252C CPU @
> > > > > 3.80GHz
> > > > > Stepping:            7
> > > > > CPU MHz:             3800.000
> > > > > CPU max MHz:         4500.0000
> > > > > CPU min MHz:         1200.0000
> > > > > BogoMIPS:            7600.00
> > > > > Virtualization:      VT-x
> > > > > L1d cache:           32K
> > > > > L1i cache:           32K
> > > > > L2 cache:            1024K
> > > > > L3 cache:            25344K
> > > > > NUMA node0 CPU(s):   0-11,24-35
> > > > > NUMA node1 CPU(s):   12-23,36-47
> > > > > Flags:               fpu vme de pse tsc msr pae mce cx8 apic
> > > > > sep mtrr
> > > > > pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss
> > > > > ht tm
> > > > > pbe
> > > > > syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon
> > > > > pebs bts
> > > > > rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni
> > > > > pclmulqdq
> > > > > dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16
> > > > > xtpr pdcm
> > > > > pcid
> > > > > dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes
> > > > > xsave
> > > > > avx
> > > > > f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3
> > > > > cdp_l3
> > > > > invpcid_single intel_ppin ssbd mba ibrs ibpb stibp
> > > > > ibrs_enhanced
> > > > > tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase
> > > > > tsc_adjust bmi1
> > > > > avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq
> > > > > rdseed adx
> > > > > smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl
> > > > > xsaveopt
> > > > > xsavec
> > > > > xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total
> > > > > cqm_mbm_local
> > > > > dtherm
> > > > > ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req pku
> > > > > ospke
> > > > > avx512_vnni md_clear flush_l1d arch_capabilities
> > > > > 
> > > > > When testing with all cpus online I don't see any issue. CPUs
> > > > > reach
> > > > > turbo frequency when intel_pstate/no_turbo is disabled and
> > > > > stay below
> > > > > turbo frequencies when no_turbo is enabled as expected.
> > > > > 
> > > > > However, issue occurs when I boot with nr_cpus argument
> > > > > specifying
> > > > > less
> > > > > than 48 cpus. e.g. cmdline:
> > > > > 
> > > > > 
> > > > > */# cat /proc/cmdline/*/
> > > > > /mmio_stale_data=off mds=off tsx=off tsx_async_abort=off
> > > > > intel_idle.max_cstate=0
> > > > > BOOT_IMAGE=/boot/vmlinuz-5.10.154-119.671.amzn2.x86_64
> > > > > root=UUID=d8605abb-d6cd-4a46-a657-b6bd206da2ab ro
> > > > > console=tty0
> > > > > console=ttyS0,115200n8 net.ifnames=0 biosdevname=0
> > > > > nvme_core.io_timeout=4294967295 rd.emergency=poweroff
> > > > > rd.shell=0*nr_cpus=24 intel_idle.max_cstate=1
> > > > > processor.max_cstate=1*
> > > > > 
> > > > > # echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
> > > > > # turbostat
> > > > > 
> > > > > 
> > > > > ^CPackage       Core CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz
> > > > > IRQ
> > > > > SMI     POLL C1      POLL%   C1%     CPU%c1  CPU%c6 CoreTmp
> > > > > PkgTmp
> > > > > Pkg%pc2 Pkg%pc6 PkgWatt RAMWatt PKG_%   RAM_%
> > > > > -       -       -       4370    99.76   4381 3800    6374 0
> > > > > 0       0       0.00    0.00    0.24    0.00    96 96     
> > > > > 0.00
> > > > > 0.00    479.79  69.20   0.00    0.00
> > > > > 0       0       0       4292    99.93   4295 3800    266 0
> > > > > 0       0       0.00    0.00    0.07    0.00    88 96     
> > > > > 0.00
> > > > > 0.00    239.89  33.62   0.00    0.00
> > > > > 0       2       1       4292    99.92   4295 3800    270 0
> > > > > 0       0       0.00    0.00    0.08    0.00    92
> > > > > 0       4       2       4292    99.92   4295 3800    264 0
> > > > > 0       0       0.00    0.00    0.08    0.00    92
> > > > > 0       8       3       4292    99.93   4295 3800    268 0
> > > > > 0       0       0.00    0.00    0.07    0.00    90
> > > > > 0       9       4       4292    99.93   4295 3800    264 0
> > > > > 0       0       0.00    0.00    0.07    0.00    91
> > > > > 0       10      5       4292    99.92   4295 3800    264 0
> > > > > 0       0       0.00    0.00    0.08    0.00    92
> > > > > 0       11      6       4292    99.92   4295 3800    265 0
> > > > > 0       0       0.00    0.00    0.08    0.00    96
> > > > > 0       17      7       4292    99.93   4295 3800    266 0
> > > > > 0       0       0.00    0.00    0.07    0.00    91
> > > > > 0       19      8       4292    99.93   4295 3800    266 0
> > > > > 0       0       0.00    0.00    0.07    0.00    91
> > > > > 0       25      9       4292    99.92   4295 3800    264 0
> > > > > 0       0       0.00    0.00    0.08    0.00    91
> > > > > 0       26      10      4292    99.92   4295 3800    264 0
> > > > > 0       0       0.00    0.00    0.08    0.00    93
> > > > > 0       27      11      4292    99.92   4295 3800    264 0
> > > > > 0       0       0.00    0.00    0.08    0.00    94
> > > > > 1       1       12      4449    99.61   4466 3800    264 0
> > > > > 0       0       0.00    0.00    0.39    0.00    80 88     
> > > > > 0.00
> > > > > 0.00    239.90  35.58   0.00    0.00
> > > > > 1       2       13      4448    99.60   4466 3800    264 0
> > > > > 0       0       0.00    0.00    0.40    0.00    86
> > > > > 1       3       14      4449    99.61   4466 3800    267 0
> > > > > 0       0       0.00    0.00    0.39    0.00    81
> > > > > 1       8       15      4449    99.61   4466 3800    264 0
> > > > > 0       0       0.00    0.00    0.39    0.00    79
> > > > > 1       9       16      4448    99.60   4466 3800    264 0
> > > > > 0       0       0.00    0.00    0.40    0.00    79
> > > > > 1       10      17      4449    99.61   4466 3800    264 0
> > > > > 0       0       0.00    0.00    0.39    0.00    83
> > > > > 1       17      18      4448    99.60   4466 3800    264 0
> > > > > 0       0       0.00    0.00    0.40    0.00    82
> > > > > 1       18      19      4449    99.61   4466 3800    281 0
> > > > > 0       0       0.00    0.00    0.39    0.00    80
> > > > > 1       19      20      4449    99.61   4466 3800    264 0
> > > > > 0       0       0.00    0.00    0.39    0.00    83
> > > > > 1       20      21      4448    99.59   4466 3800    264 0
> > > > > 0       0       0.00    0.00    0.41    0.00    83
> > > > > 1       25      22      4448    99.60   4466 3800    264 0
> > > > > 0       0       0.00    0.00    0.40    0.00    81
> > > > > 1       27      23      4448    99.59   4466 3800    265 0
> > > > > 0       0       0.00    0.00    0.41    0.00    88
> > > > > 
> > > > > /
> > > > > /
> > > > > 
> > > > > As part of the turbostat output I could see that pstate
> > > > > driver is
> > > > > setting the hints correctly in MSR_HWP_REQUEST. But somehow
> > > > > these
> > > > > limits
> > > > > are not being honored by HWP logic.
> > > > > 
> > > > > 
> > > > > cpu0: MSR_PM_ENABLE: 0x00000001 (HWP)
> > > > > cpu0: MSR_HWP_CAPABILITIES: 0x070c262d (high 45 guar 38 eff
> > > > > 12 low 7)
> > > > > *cpu0: MSR_HWP_REQUEST: 0x00002626 (min 38 max 38 des 0 epp
> > > > > 0x0
> > > > > window
> > > > > 0x0 pkg 0x0)*
> > > > > cpu0: MSR_HWP_REQUEST_PKG: 0x8000ff00 (min 0 max 255 des 0
> > > > > epp 0x80
> > > > > window 0x0)
> > > > > cpu0: MSR_HWP_STATUS: 0x00000004 (No-Guaranteed_Perf_Change,
> > > > > No-Excursion_Min)
> > > > > 
> > > > > I tried the same experiment after disabling hwp by
> > > > > specifying*intel_pstate=no_hwp*in cmdline. In this case the
> > > > > pstate
> > > > > driver seems to be selecting pstates correctly.
> > > > > 
> > > > > ^CPackage       Core CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz
> > > > > IRQ
> > > > > SMI     POLL C1      POLL%   C1%     CPU%c1  CPU%c6 CoreTmp
> > > > > PkgTmp
> > > > > Pkg%pc2 Pkg%pc6 PkgWatt RAMWatt PKG_%   RAM_%
> > > > > -       -       -       3800    100.00  3800 3800    1646 0
> > > > > 0       0       0.00    0.00    0.00    0.00    85 85     
> > > > > 0.00
> > > > > 0.00    328.38  62.14   0.00    0.00
> > > > > 0       0       0       3800    100.00  3800 3800    66 0
> > > > > 0       0       0.00    0.00    0.00    0.00    85 85     
> > > > > 0.00
> > > > > 0.00    175.42  36.96   0.00    0.00
> > > > > 0       0       24      3800    100.00  3800 3800    70 0
> > > > > 0       0       0.00    0.00    0.00
> > > > > 0       1       1       3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    82
> > > > > 0       2       2       3800    100.00  3800 3800    67 0
> > > > > 0       0       0.00    0.00    0.00    0.00    84
> > > > > 0       3       3       3800    100.00  3800 3800    67 0
> > > > > 0       0       0.00    0.00    0.00    0.00    83
> > > > > 0       4       4       3800    100.00  3800 3800    68 0
> > > > > 0       0       0.00    0.00    0.00    0.00    85
> > > > > 0       8       5       3800    100.00  3800 3800    68 0
> > > > > 0       0       0.00    0.00    0.00    0.00    83
> > > > > 0       9       6       3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    85
> > > > > 0       10      7       3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    82
> > > > > 0       11      8       3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    84
> > > > > 0       17      9       3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    83
> > > > > 0       18      10      3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    83
> > > > > 0       27      11      3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    85
> > > > > 1       0       12      3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    66 68     
> > > > > 0.00
> > > > > 0.00    152.95  25.18   0.00    0.00
> > > > > 1       2       13      3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    65
> > > > > 1       4       14      3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    68
> > > > > 1       8       15      3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    63
> > > > > 1       9       16      3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    65
> > > > > 1       10      17      3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    64
> > > > > 1       17      18      3800    100.00  3800 3800    66 0
> > > > > 0       0       0.00    0.00    0.00    0.00    63
> > > > > 1       18      19      3800    100.00  3800 3800    66 0
> > > > > 0       0       0.00    0.00    0.00    0.00    63
> > > > > 1       19      20      3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    63
> > > > > 1       20      21      3800    100.00  3800 3800    66 0
> > > > > 0       0       0.00    0.00    0.00    0.00    66
> > > > > 1       25      22      3800    100.00  3800 3800    65 0
> > > > > 0       0       0.00    0.00    0.00    0.00    64
> > > > > 1       27      23      3800    100.00  3800 3800    67 0
> > > > > 0       0       0.00    0.00    0.00    0.00    67
> > > > > 
> > > > > [root@ip-172-31-36-94 ec2-user]# cat
> > > > > /sys/devices/system/cpu/intel_pstate/no_turbo
> > > > > 1
> > > > > 
> > > > > 
> > > > > Thanks,
> > > > > Rishabh
> > > > > 
> > 

