Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1176BEEB9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCQQpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCQQpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:45:03 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A414780A;
        Fri, 17 Mar 2023 09:45:02 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id qh28so3820005qvb.7;
        Fri, 17 Mar 2023 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679071501;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2s/D7bQFpiMDRnSyNsAoiUDdXDqGkZw69LrRr6p6cc=;
        b=VEiXF8YOS1+n4wi5rMGRFnxFe17wWUBUDD1UK2MXXZqiNZN8jH/Ty4EVyn394OKyW4
         hORYF+lwsZTHE7P5sjYEYSFqmYScYBaHZ0IPYkynuNljzl5f5x8zYWus2SoiS19tmYPU
         M9Tc+I0F3mv1OU3+QLvVvGet26j9RZFNFnbAeMgEmbRW9U2r+QWK2BFvrkdW88s8r9tp
         FuRcsMO98h4raBocfuFjrwCWleff2KXgspjbCBnz3Xr0mMqOwY/C6l6Ev+AtU02KsvKT
         bV0pmaN2RjImiegtVkLVnk/+Dhj+QyY6HiWHYrI0HvuadHNvsepbPNRPPKl/xpCgtvui
         jWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071501;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2s/D7bQFpiMDRnSyNsAoiUDdXDqGkZw69LrRr6p6cc=;
        b=OEqW+uVbMUQbldvmUL2G3R6mWUi54bB/PHG1963WPm87vPZbLpYwmtnev2WFDNUgmN
         SzN5t2dJa8MuFJLefXu/8bqnvVy87bRNBpBMc5INCQ4+u9aiPcBd3fgXtlZMFndOocn7
         qy6gpILutWYPoVnIe2GAxwzJaETQNwlD9oDHfy3NaRfIKCHrvmvq/k41Xn2BIhJqNcay
         1CLIOyaNovv9XmcPIIeaSvZwu/7IxHWSOV5O2fX+x67Z6fNzm3wd2i/DDYgf4qGqr1to
         ZhqGjDhrkkkEB9WHa039OREjdQ4Xl5XsIFGRckr03NrmIb6p6NA68ZBBmAAaGUEZt6yr
         EhSA==
X-Gm-Message-State: AO0yUKVTmTQCcMAlTnFHBI1g+K6JnVG7qaaWoUw/7hka7NAbptNYEv3J
        7eSD9qigWQLZSh5+leLRhQ0=
X-Google-Smtp-Source: AK7set/GU7dij/xTuZFS2QXstSfWOb1FcmYF+hDDRDXDCHU1G0OKWLJbn5nUHXS9mehy2TgWt4iDpQ==
X-Received: by 2002:ad4:5ae1:0:b0:56e:9317:eb9a with SMTP id c1-20020ad45ae1000000b0056e9317eb9amr49368163qvh.29.1679071501077;
        Fri, 17 Mar 2023 09:45:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 124-20020a370482000000b0073b929d0371sm1998004qke.4.2023.03.17.09.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 09:45:00 -0700 (PDT)
Message-ID: <73315370-f69c-5f21-bc68-ab48587f591c@gmail.com>
Date:   Fri, 17 Mar 2023 09:44:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] mips: bmips: BCM6358: disable RAC flush for TP1
Content-Language: en-US
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230316180518.783613-1-noltari@gmail.com>
 <20230317102004.235879-1-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230317102004.235879-1-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/23 03:20, Álvaro Fernández Rojas wrote:
> RAC flush causes kernel panics on BCM6358 with EHCI/OHCI when booting from TP1:
> [    3.881739] usb 1-1: new high-speed USB device number 2 using ehci-platform
> [    3.895011] Reserved instruction in kernel code[#1]:
> [    3.900113] CPU: 0 PID: 1 Comm: init Not tainted 5.10.16 #0
> [    3.905829] $ 0   : 00000000 10008700 00000000 77d94060
> [    3.911238] $ 4   : 7fd1f088 00000000 81431cac 81431ca0
> [    3.916641] $ 8   : 00000000 ffffefff 8075cd34 00000000
> [    3.922043] $12   : 806f8d40 f3e812b7 00000000 000d9aaa
> [    3.927446] $16   : 7fd1f068 7fd1f080 7ff559b8 81428470
> [    3.932848] $20   : 00000000 00000000 55590000 77d70000
> [    3.938251] $24   : 00000018 00000010
> [    3.943655] $28   : 81430000 81431e60 81431f28 800157fc
> [    3.949058] Hi    : 00000000
> [    3.952013] Lo    : 00000000
> [    3.955019] epc   : 80015808 setup_sigcontext+0x54/0x24c
> [    3.960464] ra    : 800157fc setup_sigcontext+0x48/0x24c
> [    3.965913] Status: 10008703	KERNEL EXL IE
> [    3.970216] Cause : 00800028 (ExcCode 0a)
> [    3.974340] PrId  : 0002a010 (Broadcom BMIPS4350)
> [    3.979170] Modules linked in: ohci_platform ohci_hcd fsl_mph_dr_of ehci_platform ehci_fsl ehci_hcd gpio_button_hotplug usbcore nls_base usb_common
> [    3.992907] Process init (pid: 1, threadinfo=(ptrval), task=(ptrval), tls=77e22ec8)
> [    4.000776] Stack : 81431ef4 7fd1f080 81431f28 81428470 7fd1f068 81431edc 7ff559b8 81428470
> [    4.009467]         81431f28 7fd1f080 55590000 77d70000 77d5498c 80015c70 806f0000 8063ae74
> [    4.018149]         08100002 81431f28 0000000a 08100002 81431f28 0000000a 77d6b418 00000003
> [    4.026831]         ffffffff 80016414 80080734 81431ecc 81431ecc 00000001 00000000 04000000
> [    4.035512]         77d54874 00000000 00000000 00000000 00000000 00000012 00000002 00000000
> [    4.044196]         ...
> [    4.046706] Call Trace:
> [    4.049238] [<80015808>] setup_sigcontext+0x54/0x24c
> [    4.054356] [<80015c70>] setup_frame+0xdc/0x124
> [    4.059015] [<80016414>] do_notify_resume+0x1dc/0x288
> [    4.064207] [<80011b50>] work_notifysig+0x10/0x18
> [    4.069036]
> [    4.070538] Code: 8fc300b4  00001025  26240008 <ac820000> ac830004  3c048063  0c0228aa  24846a00  26240010
> [    4.080686]
> [    4.082517] ---[ end trace 22a8edb41f5f983b ]---
> [    4.087374] Kernel panic - not syncing: Fatal exception
> [    4.092753] Rebooting in 1 seconds..
> 
> Because the bootloader (CFE) is not initializing the Read-ahead cache properly
> on the second thread (TP1). Since the RAC was not initialized properly, we
> should avoid flushing it at the risk of corrupting the instruction stream as
> seen in the trace above.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Third time is a charm, Thomas, I believe this deserves adding a:

Fixes: d59098a0e9cb ("MIPS: bmips: use generic dma noncoherent ops")

such that this backports cleanly. Thanks!
-- 
Florian

