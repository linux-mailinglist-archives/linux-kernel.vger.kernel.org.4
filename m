Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9737724216
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjFFM3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbjFFM3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:29:05 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E13E10CE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:29:02 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-565a022ef06so73224137b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686054542; x=1688646542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mk6VGdgLvgd3dnlSaWFV9TAcgWL5rTNPzpUIBbZR2YA=;
        b=M8RUJ36fg7PtpBcSaGfx3HMeK+QQq3XC1y2VJ8qB2x8W/FPB7d56HZX/7v73YrxXdY
         NInLNXY12J46kIeWphLsjesqlU3lagfCxGOJ8rj+awg4fxm1K9oIADjVzUXsaJQwH4Bz
         nQ7D5bCztecXyvqeK2H7VQSy8KDfhT4ig+CpqV2g9lzNVXCblpukcEDvIwIHqrhaRiyQ
         SGShY1vwnZp96t5b69xF+u44Vc5HpvnFLcUIIWQUU8go9AAVrmA/nbSaOUPfLVyzG4HL
         CkKzlqSdm6fdvYk2yKt+zlamEJ/t4vibcimjsx4yary1ajRLNtFHwrsz+QdpjvPmbDyF
         MwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054542; x=1688646542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mk6VGdgLvgd3dnlSaWFV9TAcgWL5rTNPzpUIBbZR2YA=;
        b=DYoLu4Q6fmG8MbkmQeUcsZSbf12Sp+k3UDFFuOGkUVjSERv5yKnrMAFJPBCq+5rBz/
         UoWOKJTPFJasIed9/3KGYHms/21sH4Ac02WVn7AciY/gFHCDIVJ9zYt8knSG4yk38XCB
         OzQETeN/+MqN7tYPgGsyByi74JCXcKtKTJyoMV5OK3tvLTDV7COiNmFpC15mJEY1lYhw
         +KYc+vUG+7byIL+tnF6qJO8aUnIj21iWgj/Uqr03wRhTZ1XPaJ0U3BaSDWugyyexrzg2
         38NrM3BKvziwSlf4h9Isjvg5WpS+4y7Aw2iy/xYLqlANlNS5KkeMfzeKr9tzcKE/Y1Vk
         PsFQ==
X-Gm-Message-State: AC+VfDxLreOszflFDn/ODPfqPz8JLTe3dxBLiV8clIP4AiWUEjLVulNB
        nHDXUR4eGh3c201YsIo4OeSl98XNXZLJYJn6mOp5thFOfDzimQ==
X-Google-Smtp-Source: ACHHUZ623zeLVGrRPsoKOrQS4HD4zjI6lD/53HMKUU+6YgWa/w+vsdXKHDEdS3KL10fGUUO3iOXcQdZ12pOTgMmKHdI=
X-Received: by 2002:a0d:dbc5:0:b0:561:d1ef:3723 with SMTP id
 d188-20020a0ddbc5000000b00561d1ef3723mr2096179ywe.38.1686054541550; Tue, 06
 Jun 2023 05:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-bSRZuLhZQ4Kpb4NRF2yY6XifYpB3ei4=6oFDAaG+OmeGebQ@mail.gmail.com>
 <ZH8YS+LxMM1ZPpsc@feng-clx>
In-Reply-To: <ZH8YS+LxMM1ZPpsc@feng-clx>
From:   Chris Bainbridge <chris.bainbridge@gmail.com>
Date:   Tue, 6 Jun 2023 13:28:50 +0100
Message-ID: <CAP-bSRaNQj+fi1r0MZ64wB5_rfjHmEBFQ+QueiNQ9dnyJixG8A@mail.gmail.com>
Subject: Re: PROBLEM: skew message does not handle negative ns skew
To:     Feng Tang <feng.tang@intel.com>
Cc:     paulmck@kernel.org, tglx@linutronix.de, sboyd@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 at 12:35, Feng Tang <feng.tang@intel.com> wrote:
>
> Hi,
>
> Could you share more info about the hardware, like which generation,
> how many sockets or numa nodes (output of lscpu, 'numactl -h') ?
>
> Thanks,
> Feng

The hardware is a HP Pavilion Aero 13 laptop.

$ lscpu
Architecture:            x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Address sizes:         48 bits physical, 48 bits virtual
  Byte Order:            Little Endian
CPU(s):                  16
  On-line CPU(s) list:   0-15
Vendor ID:               AuthenticAMD
  Model name:            AMD Ryzen 7 5800U with Radeon Graphics
    CPU family:          25
    Model:               80
    Thread(s) per core:  2
    Core(s) per socket:  8
    Socket(s):           1
    Stepping:            0
    Frequency boost:     enabled
    CPU(s) scaling MHz:  35%
    CPU max MHz:         4505.0781
    CPU min MHz:         1600.0000
    BogoMIPS:            3792.93
    Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov
                         pat pse36 clflush mmx fxsr sse sse2 ht
syscall nx mmxext fxsr_
                         opt pdpe1gb rdtscp lm constant_tsc rep_good
nopl nonstop_tsc c
                         puid extd_apicid aperfmperf rapl pni
pclmulqdq monitor ssse3 f
                         ma cx16 sse4_1 sse4_2 movbe popcnt aes xsave
avx f16c rdrand l
                         ahf_lm cmp_legacy svm extapic cr8_legacy abm
sse4a misalignsse
                          3dnowprefetch osvw ibs skinit wdt tce
topoext perfctr_core pe
                         rfctr_nb bpext perfctr_llc mwaitx cpb cat_l3
cdp_l3 hw_pstate
                         ssbd mba ibrs ibpb stibp vmmcall fsgsbase
bmi1 avx2 smep bmi2
                         erms invpcid cqm rdt_a rdseed adx smap
clflushopt clwb sha_ni
                         xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_t
                         otal cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd cpp
                         c arat npt lbrv svm_lock nrip_save tsc_scale
vmcb_clean flushb
                         yasid decodeassists pausefilter pfthreshold
avic v_vmsave_vmlo
                         ad vgif v_spec_ctrl umip pku ospke vaes
vpclmulqdq rdpid overf
                         low_recov succor smca fsrm
Virtualization features:
  Virtualization:        AMD-V
Caches (sum of all):
  L1d:                   256 KiB (8 instances)
  L1i:                   256 KiB (8 instances)
  L2:                    4 MiB (8 instances)
  L3:                    16 MiB (1 instance)
NUMA:
  NUMA node(s):          1
  NUMA node0 CPU(s):     0-15
Vulnerabilities:
  Itlb multihit:         Not affected
  L1tf:                  Not affected
  Mds:                   Not affected
  Meltdown:              Not affected
  Mmio stale data:       Not affected
  Retbleed:              Not affected
  Spec store bypass:     Mitigation; Speculative Store Bypass disabled via prctl
  Spectre v1:            Mitigation; usercopy/swapgs barriers and
__user pointer saniti
                         zation
  Spectre v2:            Mitigation; Retpolines, IBPB conditional,
IBRS_FW, STIBP alway
                         s-on, RSB filling, PBRSB-eIBRS Not affected
  Srbds:                 Not affected
  Tsx async abort:       Not affected

$ numactl -H
available: 1 nodes (0)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
node 0 size: 15331 MB
node 0 free: 789 MB
node distances:
node   0
  0:  10
