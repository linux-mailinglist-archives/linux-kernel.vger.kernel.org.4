Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FDD6FCEE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjEIT6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjEIT6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:58:01 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288E74486;
        Tue,  9 May 2023 12:58:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64115e652eeso45243700b3a.0;
        Tue, 09 May 2023 12:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683662279; x=1686254279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtJaNCD7II6YcLTMy7Wvb7J7re+/dORtugyHESx6VTM=;
        b=GQHj4+4cUlJ1JDEwYT9r2QsdjmNu+SF0pfB0DgDL0qWKtsJikhx8Blc3KjUlcQKHSy
         q8i2pC5GN4/YZyk38sP1OOqAjm0aAQLODi1VoMIWOMKg+CgkcD9UWWnCkPeC3vh71lkZ
         7iCJCfHk1PSGk3O3rnSaWueBDagRw/cE47J4XoL0dQ92gC73E42aNwIrvRmaBN/eEA8G
         0R05dWR7yGqANQLU1lR9qhVidkLDH/5XyaQmcAZFQBPUpUQ0VwHJhKmI6E1znsIpmfRE
         HK/pfCZDUPkRoLq4/xDW7fx2cRDrg5JM0meOL5u0FWZcRYvpZIM/ICvZSciPNhsmQlRn
         SlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683662279; x=1686254279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtJaNCD7II6YcLTMy7Wvb7J7re+/dORtugyHESx6VTM=;
        b=MsIjjPLg4L9B7j9oxc0X+RFmvlPIaWkjdkdky6xVOVF3Oreq7Msl0pmzRM5DJ6y+Ra
         Puz4pGRGswnrApB9ao+Scqlp/CQ/dXiLhCKTMrZ0pR0nNkljgykiIrrIkuvW417AJs60
         9/l2x2dQQq+7b0akOFNo/t7LoExUPiDewSLVzS3XadeB2W4H3i9TjLAKf8FwCQzP7O+D
         G591sRur5QOhZ/zyRQceSGxmHZNz8LpHg4HEnK7XG2iVSD0dxb76VOFF195N7pZtFnzY
         k0BwzXN09/YJ3Pfv+rv60410Agkk9uEwN3wc66kJtj1BUj7gHyMtE23ZzqfzuVvdYLaM
         B2fQ==
X-Gm-Message-State: AC+VfDz7tQH7cxtaiqpK5Q58UgRBzfIt2yO7+wOH2sNsGM7W//2CX/Sr
        xshLDGi3H41fTDZb95xiXBE=
X-Google-Smtp-Source: ACHHUZ5xki0XCJPI0/6YSSDxUQs8NwGQv3oKkyh0lAZxTGz9uHDmoZ+PuG9fz6lhcU3Ehm+Uqpdueg==
X-Received: by 2002:a17:902:f804:b0:1a6:d9a6:a9b4 with SMTP id ix4-20020a170902f80400b001a6d9a6a9b4mr15659513plb.3.1683662279483;
        Tue, 09 May 2023 12:57:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001ac7ab3e97csm1976857plk.260.2023.05.09.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:57:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 May 2023 12:57:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/610] 6.1.28-rc2 review
Message-ID: <0837e157-8615-418a-a3d3-1c14af11aba5@roeck-us.net>
References: <20230509030653.039732630@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509030653.039732630@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 05:26:31AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.28 release.
> There are 610 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 519 pass: 519 fail: 0

New persistent runtime warning when booting riscv32/64 images:

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at arch/riscv/kernel/patch.c:73 patch_insn_write+0x1f0/0x202
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.28-rc2-00611-g2b7e1f92aa55 #1
[    0.000000] Hardware name: riscv-virtio,qemu (DT)
[    0.000000] epc : patch_insn_write+0x1f0/0x202
[    0.000000]  ra : patch_insn_write+0x1ec/0x202
[    0.000000] epc : c0005f80 ra : c0005f7c sp : c1c01ed0
[    0.000000]  gp : c1d97938 tp : c1c0c680 t0 : c1f2ca38
[    0.000000]  t1 : 00000018 t2 : 00001fff s0 : c1c01f00
[    0.000000]  s1 : c102d5b8 a0 : 00000000 a1 : ffffffff
[    0.000000]  a2 : 00000018 a3 : 00000000 a4 : c101c480
[    0.000000]  a5 : 00000000 a6 : 000094e4 a7 : 000096ba
[    0.000000]  s2 : c00094e4 s3 : 00000018 s4 : 000004fc
[    0.000000]  s5 : c00096ba s6 : c1010018 s7 : 000004e4
[    0.000000]  s8 : 08000200 s9 : 81000200 s10: c164d6b0
[    0.000000]  s11: c164d6bc t3 : 000000e4 t4 : 000000ba
[    0.000000]  t5 : 00000018 t6 : 00000023
[    0.000000] status: 00000100 badaddr: 00000000 cause: 00000003
[    0.000000] [<c0005f80>] patch_insn_write+0x1f0/0x202
[    0.000000] [<c000602a>] patch_text_nosync+0xa/0x28
[    0.000000] [<c00039a2>] riscv_cpufeature_patch_func+0x10e/0x118
[    0.000000] [<c000333e>] _apply_alternatives+0x3a/0x72
[    0.000000] [<c0c02c4e>] apply_boot_alternatives+0x2a/0x32
[    0.000000] [<c0c037c8>] setup_arch+0x43c/0x45a
[    0.000000] [<c0c00736>] start_kernel+0xa2/0x7b0
[    0.000000] irq event stamp: 0
[    0.000000] hardirqs last  enabled at (0): [<00000000>] 0x0
[    0.000000] hardirqs last disabled at (0): [<00000000>] 0x0
[    0.000000] softirqs last  enabled at (0): [<00000000>] 0x0
[    0.000000] softirqs last disabled at (0): [<00000000>] 0x0
[    0.000000] ---[ end trace 0000000000000000 ]---

I did not try to bisect.

Guenter
