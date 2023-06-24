Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C1E73C5F6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 03:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjFXBoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 21:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjFXBof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 21:44:35 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5E32738;
        Fri, 23 Jun 2023 18:44:34 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39ee19cfb77so1060304b6e.0;
        Fri, 23 Jun 2023 18:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687571073; x=1690163073;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnVE3e7VprhRGPi15l7LQGONQqGj0Q6nNTdPJOtqQbo=;
        b=kvzkcyhJbM0nREMhPOJRvwctQ6qdgX1pOw2/sxokIetkKFtZy2ZAszQvyaOUh4jY6e
         0//L7Ycwar7QkIPWhGJzoWZmyoyJx+GCjc8FFLytjLBAwLKexAIBGe8s4krFs9kcgo4r
         5eyPaAfi2hr318gydUSGc7vTlhiutWi66QjtMcdkLmG54oZajRNGl6A58jOkdksiizfI
         gtIEc5OQA0/HLocl5PTK5uK9byccmoRQzJr0elUvnmEN/vfvcYiI8Zwa2le0wmbj+Qbw
         rXCC+YFsTRLYRUZVINnrm9mkBalM+7LO3jidF7VXI6X59rdsg7JjYxpq00wE9pOBSQ7C
         28ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687571073; x=1690163073;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fnVE3e7VprhRGPi15l7LQGONQqGj0Q6nNTdPJOtqQbo=;
        b=engUgDIeSftvD6NJ5vCg4lkIR3+LVMZIDYyVg+Iq20gGzwOkyD0uVFX0lgKlEtOotX
         SM5MTTT/VVQrGojOhJTsyEZvsamqTQyb7BG/K7LDxf27YgVtFPcZlv9KAub2cJEZitQA
         neTUb+umzfbokP9mBtoscHWy2VspXDWWR/sPcmDx/3T151GMMtrWiK8L26FZro4k2cds
         ggnM4YARV2u3y14rqpDo/yJevjDPEn9z89fB66HVTgkz+SVMH5mW1kSkSd/Nqk8K85i4
         +vPkspXxLODniEWIQSqLU5UgcylLBQSZgm+m+GQBvTs5juR9gA1wkE4gmRqSKeEURmsv
         eKJg==
X-Gm-Message-State: AC+VfDwUZjAdFhsI84YpovlzWcaCGGvH4JogRMPLqUedyN2r/zy69EEI
        EkcQPCww3Rrepjvby5cRwjaPs3RwFVNhsA==
X-Google-Smtp-Source: ACHHUZ4pFCWhhOk7YUC51N0jfTbZ5Z66AN3uM1u47fjDBvIBVBp0WPXlFzFVVKVccAykpJVeNa1BNg==
X-Received: by 2002:a05:6808:1827:b0:3a0:5993:be86 with SMTP id bh39-20020a056808182700b003a05993be86mr10093464oib.3.1687571073050;
        Fri, 23 Jun 2023 18:44:33 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902b20c00b001a95f632340sm184560plr.46.2023.06.23.18.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 18:44:32 -0700 (PDT)
Message-ID: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
Date:   Sat, 24 Jun 2023 08:44:15 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>, sardonimous@hotmail.com
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: After kernel 6.3.7 or 6.3.8 b43 driver fails
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> After upgrading to linux 6.3.8-arch1-1 from 6.3.6-arch1-1, b43 broadcom wireless driver fails.  downgrading back to 6.3.6-arch1-1 resolves.
> 
> Jun 16 20:56:37 askasleikir kernel: Hardware name: Apple Inc. MacBookPro7,1/Mac-F222BEC8, BIOS MBP71.88Z.0039.B15.1702241313 02/24/17
> Jun 16 20:56:37 askasleikir kernel: Workqueue: phy0 b43_tx_work [b43]
> Jun 16 20:56:37 askasleikir kernel: RIP: 0010:__ieee80211_stop_queue+0xcc/0xe0 [mac80211]
> Jun 16 20:56:37 askasleikir kernel: Code: 74 11 48 8b 78 08 0f b7 d6 89 e9 4c 89 e6 e8 5b eb 00 00 65 ff 0d 0c dd b5 3e 0f 85 55 ff ff ff e8 b9 f4 12 de e9 4b ff>
> Jun 16 20:56:37 askasleikir kernel: RSP: 0000:ffffc36b0013bdb8 EFLAGS: 00010097
> Jun 16 20:56:37 askasleikir kernel: RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000000
> Jun 16 20:56:37 askasleikir kernel: RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff9f85d1c108e0
> Jun 16 20:56:37 askasleikir kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: ffff9f85c0819674
> Jun 16 20:56:37 askasleikir kernel: R10: 0000000000000005 R11: 0000000000000181 R12: ffff9f85d1c108e0
> Jun 16 20:56:37 askasleikir kernel: R13: 0000000000000000 R14: ffff9f85d1c12238 R15: ffff9f85d1c12090
> Jun 16 20:56:37 askasleikir kernel: FS: 0000000000000000(0000) GS:ffff9f85fbe00000(0000) knlGS:0000000000000000
> Jun 16 20:56:37 askasleikir kernel: CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jun 16 20:56:37 askasleikir kernel: CR2: 000055b33bbd5d70 CR3: 0000000022620000 CR4: 00000000000406f0
> Jun 16 20:56:37 askasleikir kernel: Call Trace:
> Jun 16 20:56:37 askasleikir kernel: <TASK>
> Jun 16 20:56:37 askasleikir kernel: ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211 136d1d948548ad6cca697df0da0a13c0a2333310]
> Jun 16 20:56:37 askasleikir kernel: ? __warn+0x81/0x130
> Jun 16 20:56:37 askasleikir kernel: ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211 136d1d948548ad6cca697df0da0a13c0a2333310]
> Jun 16 20:56:37 askasleikir kernel: ? report_bug+0x171/0x1a0
> Jun 16 20:56:37 askasleikir kernel: ? handle_bug+0x3c/0x80
> Jun 16 20:56:37 askasleikir kernel: ? exc_invalid_op+0x17/0x70
> Jun 16 20:56:37 askasleikir kernel: ? asm_exc_invalid_op+0x1a/0x20
> Jun 16 20:56:37 askasleikir kernel: ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211 136d1d948548ad6cca697df0da0a13c0a2333310]
> Jun 16 20:56:37 askasleikir kernel: ieee80211_stop_queue+0x36/0x50 [mac80211 136d1d948548ad6cca697df0da0a13c0a2333310]
> Jun 16 20:56:37 askasleikir kernel: b43_pio_tx+0x373/0x390 [b43 0f6039cbd530df6f28ebbb52898f2f67b84598dd]
> Jun 16 20:56:37 askasleikir kernel: ? __schedule+0x44b/0x1400
> Jun 16 20:56:37 askasleikir kernel: b43_tx_work+0x57/0x130 [b43 0f6039cbd530df6f28ebbb52898f2f67b84598dd]
> Jun 16 20:56:37 askasleikir kernel: process_one_work+0x1c7/0x3d0
> Jun 16 20:56:37 askasleikir kernel: worker_thread+0x51/0x390
> Jun 16 20:56:37 askasleikir kernel: ? __pfx_worker_thread+0x10/0x10
> Jun 16 20:56:37 askasleikir kernel: kthread+0xde/0x110
> Jun 16 20:56:37 askasleikir kernel: ? __pfx_kthread+0x10/0x10
> Jun 16 20:56:37 askasleikir kernel: ret_from_fork+0x2c/0x50
> Jun 16 20:56:37 askasleikir kernel: </TASK>
> Jun 16 20:56:37 askasleikir kernel: ---[ end trace 0000000000000000 ]---
> 
> I suspect change introduced when addressing a compiler warning cased the error.
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20230516183442.536589-1-arnd%40kernel.org/
> 
> The is arch linux and they referred me here.

See Bugzilla for the full thread.

Unfortunately, the reporter can't perform bisection to confirm that
backport of 212457ccbd60db triggers this regression.

Anyway, I'm adding it to regzbot to be sure that it doesn't fall
through cracks unnoticed:

#regzbot introduced: 212457ccbd60db https://bugzilla.kernel.org/show_bug.cgi?id=217582
#regzbot title: fixing incorrect __packed annotation for Clang causes b43 driver fail to start

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
