Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFB55F639F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiJFJ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJFJ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CD89A9C5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665048568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=94otJVoB9xy0ViFJOwAvWjX8yRWjZFY1HE2P23+kfyU=;
        b=H5CyvUu/+0jMbwiWPNYeFYJM3RooV5Vm4lr36IN4lFW0by+GjAnvmV9jmuZwWNJwf4fXjT
        rBFZaZPcTO5dzC64+y61DjJ89jn2InlNQfmscNczSsVhft8A4ZtYaiPll26tAMM0+/tcJa
        NcLFR9v7rmtoScstN1MoPVcrYf5UHzw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-153-We8hxxVFM1G4_84TWAvqOQ-1; Thu, 06 Oct 2022 05:29:27 -0400
X-MC-Unique: We8hxxVFM1G4_84TWAvqOQ-1
Received: by mail-lj1-f198.google.com with SMTP id h23-20020a05651c125700b0026e01b79d34so505579ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=94otJVoB9xy0ViFJOwAvWjX8yRWjZFY1HE2P23+kfyU=;
        b=OEpZxt9Mb8EXzI7/aVCg+hwNfF5Z5Kxg2/Fu+No30rVwKuia0AqK+Wb5FWJOPAy5Yx
         jpPTY4flNNQ6ad+rBlSEX3y76TeJRG4oSj3QcBbqgRDOGoN10/vFMWwqjzMBTb96ErL4
         kjNa94BpKSig1SNHNO5jHNjKk7gHegcU+Gyw0wrPzJIkp9NqD90jlrLIduc6lWOdYNHN
         mMQpVefACEpDLUqokWrv0b1G+1Ochz688CPs7ODp1Lat4TXT3/5oZBLRay46566CNgkK
         F3XmvZ1w5sAJolzbdkMp0A4pCXk+iKuJgAvDChPMaeVENna+uKcsXFeLMCUoF0f45PKt
         AD0A==
X-Gm-Message-State: ACrzQf1p2IzGVhJmdcSj9LHHjyNYDykHYkCzxhrXxQNUsRRFWnzd93x1
        OzZI4canQt4MUa5+Y6OF40pJAEPbLSgg1txICPmlAFY37Bk22fth8nDQmpemKAhwuo/vdUeRukP
        jztF4YJVat4VQ07z2x/ROM0MAsKv5669+InO0w1wC
X-Received: by 2002:a05:651c:1112:b0:26c:7323:3f2c with SMTP id e18-20020a05651c111200b0026c73233f2cmr1477861ljo.4.1665048565321;
        Thu, 06 Oct 2022 02:29:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6UJoKc02XtNecUPnA7hwOr88uQMBmFJGuPCSEx8nxrMg0anBOQcN6FiLNMw6zcXxWnx3GOjnt7dRn6tBrjbYU=
X-Received: by 2002:a05:651c:1112:b0:26c:7323:3f2c with SMTP id
 e18-20020a05651c111200b0026c73233f2cmr1477852ljo.4.1665048565071; Thu, 06 Oct
 2022 02:29:25 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Thu, 6 Oct 2022 11:29:13 +0200
Message-ID: <CA+QYu4pFecWRuGSsvNLq3YANPzO2Dz09X86WivbuzXfSNKTPuw@mail.gmail.com>
Subject: [aarch64] [ampere] [6.0.0] pc : kset_find_obj+0x38/0xb0 lr : kset_find_obj+0x48/0xb0
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are hitting a panic when booting on ampere, more specifically on
hr330a and hr350a machines.

[    3.803924] xor: measuring software checksum speed
[    3.809489]    8regs           : 12524 MB/sec
[    3.814622]    32regs          : 12512 MB/sec
[    3.820179]    arm64_neon      :  8109 MB/sec
[    3.824525] xor: using function: 8regs (12524 MB/sec)
[    3.829565] Key type asymmetric registered
[    3.833655] Asymmetric key parser 'x509' registered
[    4.072910] Freeing initrd memory: 20772K
[    4.083936] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    4.089699] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 244)
[    4.097203] io scheduler mq-deadline registered
[    4.101732] io scheduler kyber registered
[    4.105809] io scheduler bfq registered
[    4.112468] atomic64_test: passed
[    4.117903] Unable to handle kernel paging request at virtual
address fffffffffffffff8
[    4.125820] Mem abort info:
[    4.128600]   ESR = 0x0000000096000004
[    4.132339]   EC = 0x25: DABT (current EL), IL = 32 bits
[    4.137638]   SET = 0, FnV = 0
[    4.140680]   EA = 0, S1PTW = 0
[    4.143810]   FSC = 0x04: level 0 translation fault
[    4.148674] Data abort info:
[    4.151546]   ISV = 0, ISS = 0x00000004
[    4.155369]   CM = 0, WnR = 0
[    4.158324] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000009f81788000
[    4.165014] [fffffffffffffff8] pgd=0000000000000000, p4d=0000000000000000
[    4.171795] Internal error: Oops: 96000004 [#1] SMP
[    4.176661] Modules linked in:
[    4.179704] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.0.0 #1
[    4.185524] Hardware name: Lenovo HR330A            7X33CTO1WW
/FALCON     , BIOS hve104r-1.15 02/26/2021
[    4.195336] pstate: a0400005 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.202285] pc : kset_find_obj+0x38/0xb0
[    4.206200] lr : kset_find_obj+0x48/0xb0
[    4.210110] sp : ffff80000b80bcf0
[    4.213412] x29: ffff80000b80bcf0 x28: 0000000000000000 x27: ffff800009f9044c
[    4.220536] x26: ffff80000a046960 x25: 0000000000000006 x24: ffff80000a14520c
[    4.227660] x23: ffff8000099a3370 x22: ffff000801230d90 x21: ffff8000097bb348
[    4.234783] x20: ffff000801230d80 x19: fffffffffffffff8 x18: ffffffffffffffff
[    4.241907] x17: 0000000054138b3b x16: 00000000ba80c402 x15: ffff80000b80bb48
[    4.249030] x14: ffff000806403a1c x13: ffff000806403262 x12: 0000000000000001
[    4.256154] x11: 000000003985e44f x10: 0000000000011078 x9 : 0000000000000003
[    4.263277] x8 : 0101010101010101 x7 : 0000000000000000 x6 : 101100461d194e01
[    4.270401] x5 : 014e191d46001110 x4 : 0000000000000000 x3 : 1b2373996b831b48
[    4.277525] x2 : 0000000000000000 x1 : ffff8000097bb348 x0 : 0000000000000000
[    4.284648] Call trace:
[    4.287081]  kset_find_obj+0x38/0xb0
[    4.290645]  driver_register+0x64/0x13c
[    4.294471]  __platform_driver_register+0x30/0x3c
[    4.299162]  cdns_plat_pcie_driver_init+0x24/0x30
[    4.303856]  do_one_initcall+0x50/0x28c
[    4.307681]  do_initcalls+0x104/0x144
[    4.311332]  kernel_init_freeable+0x16c/0x1b8
[    4.315676]  kernel_init+0x2c/0x150
[    4.319154]  ret_from_fork+0x10/0x20
[    4.322719] Code: f9400280 eb00029f 54000160 d1002013 (f9400260)
[    4.328799] ---[ end trace 0000000000000000 ]---
[    4.333403] Kernel panic - not syncing: Oops: Fatal exception
[    4.339136] SMP: stopping secondary CPUs
[    4.343054] Kernel Offset: 0x40000 from 0xffff800008000000
[    4.348525] PHYS_OFFSET: 0x80000000
[    4.352000] CPU features: 0x0000,00045021,00001086
[    4.356778] Memory Limit: none
[    4.359820] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

full console log:
https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/10/05/redhat:659318872/build_aarch64_redhat:659318872_aarch64/tests/3/results_0001/console.log/console.log

more logs:https://datawarehouse.cki-project.org/kcidb/tests/5390369
cki issue tracker: https://datawarehouse.cki-project.org/issue/1637

kernel config: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/659318872/build%20aarch64/3132390378/artifacts/kernel-mainline.kernel.org-redhat_659318872_aarch64.config
kernel tarball:
https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/659318872/publish%20aarch64/3132390386/artifacts/kernel-mainline.kernel.org-redhat_659318872_aarch64.tar.gz

Thanks,
Bruno

