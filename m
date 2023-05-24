Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F270F49F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjEXK6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEXK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:58:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538C3A3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:58:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-25376483f66so78619a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684925893; x=1687517893;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtNtYGFCrVyZey4VNLOickd29YxbAE5d03gdnH81J+U=;
        b=l3Y8DRIQWeZSAkdFMfWSj0ifqiRCoUl+MxNzyGPTw4ZMaQ6QWphZ802TjCA9rSm9so
         WMG3R44sc0gr+xXBTBY7TCuICT3d45vwv+Fhc2Kif7HhDdftbNF0EkAGL8oVUJSe2Eay
         ZUaEtkJpPuwE8y8NK/iA7PUeSMknfa4tcoav5tGrXwUQFy8oRiNb9MqyPcTeGkb27rHp
         hMzPGBz5WgbeekaXTC+5mYde3P4XFoDPx30/BpGiJJRyymxVzStX6k13W/tbQ/2bM4zm
         Va38TCsEtvSD8nOdlVZbYfj30hYNmcztUhE7KWlVnuBOtz6HCt6W+ZPxpyac7saVfI9j
         9sDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684925893; x=1687517893;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EtNtYGFCrVyZey4VNLOickd29YxbAE5d03gdnH81J+U=;
        b=hgUnv3G5L7rzuO/hNyqaKTkLYQ3nBKDE+b91JMUsziHMv/oGHcHJ0uMKzkQQ9pGU2t
         mn45BGU2dqt7bSIqqS0n7mjS3T4Lnb3dOKqlyxp0eNEGPokG1TdoE/e7ZOU2VZKGVXnb
         D+BM2Rs8JenQBX3g3McFIliteP9//cz0YnMQ3hwpJmR4hQy67R5zXPb7gDVV3Z7wRflH
         sK9AhIneWuTfEOZG4t1Bv6ZZlJ/B7YLxe/y1pe/a+giCTw5I7IG5GWWcXX52/cGKQj8r
         6C7PYgmsszhSDKFzvRYNJRYI+6BFgLcF3NDxPHmuD6IKINizslpwZ/+i3m4H56kij2Fa
         h8iw==
X-Gm-Message-State: AC+VfDzo7sRnRZpZ4T7YBLx38tVraIojsNZhstzUdgmEdIAQ6VAthdlF
        DnVQDanlAzzETbs+edtIj3rW1UnZMHc=
X-Google-Smtp-Source: ACHHUZ4x3mbRZza/OnPc7Hf62AB/tvNESZBkKaby/M3eKCGQRKizRlGE/zRB69YbxrIb8Twc5v/liA==
X-Received: by 2002:a17:90a:bf8b:b0:253:727e:4b41 with SMTP id d11-20020a17090abf8b00b00253727e4b41mr15726441pjs.34.1684925893529;
        Wed, 24 May 2023 03:58:13 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-28.three.co.id. [180.214.232.28])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b0024de39e8746sm1110323pjt.11.2023.05.24.03.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 03:58:13 -0700 (PDT)
Message-ID: <2a1cd5e6-01f7-66f9-1f9d-c655cc3f919b@gmail.com>
Date:   Wed, 24 May 2023 17:58:07 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        doru iorgulescu <doru.iorgulescu1@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: ./include/linux/mmzone.h:1735:2: error: #error Allocator
 MAX_ORDER exceeds SECTION_SIZE (v6.4-rc3 build regression)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a powerpc[64?] build regression on Bugzilla [1]. Quoting from it:

>  CC      arch/powerpc/kernel/asm-offsets.s
> In file included from ./include/linux/gfp.h:7,
>                 from ./include/linux/xarray.h:15,
>                 from ./include/linux/list_lru.h:14,
>                 from ./include/linux/fs.h:13,
>                 from ./include/linux/compat.h:17,
>                 from arch/powerpc/kernel/asm-offsets.c:12:
> ./include/linux/mmzone.h:1735:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE
> 1735 | #error Allocator MAX_ORDER exceeds SECTION_SIZE
>      |  ^~~~~
> make[5]: *** [scripts/Makefile.build:114: arch/powerpc/kernel/asm-offsets.s] Error 1

Apparently removing the errored line solves the problem for the reporter
(the attached dmesg on [2] looks fine at a glance).

Anyway, I'm adding it to regzbot:

#regzbot introduced: 23baf831a32c04f https://bugzilla.kernel.org/show_bug.cgi?id=217477
#regzbot title: Allocator MAX_ORDER exceeds SECTION_SIZE caused by MAX_ORDER redefinition

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217477
[2]: https://bugzilla.kernel.org/show_bug.cgi?id=217477#c1

-- 
An old man doll... just what I always wanted! - Clara
