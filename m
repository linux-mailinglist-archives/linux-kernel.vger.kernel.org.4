Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2885B64B336
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiLMK02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbiLMK0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:26:24 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F897F69
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:26:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso7487139wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pu08UoEEhSuGsocqugEAMUYroTyoru7RTTvNi/xK32k=;
        b=W7Kv1xxPNLKHCol5uXXZXqs10FnXSqA918evvqPBIJzIlE5ufkcnWz7pg6ggVrsDpy
         bNmxneJfw/4eZvq7QeR6zk9AGOroIUy5kJjWDcuqCngZQMHCr5NdJyUVKKbmH3Z3UGwV
         Fqd0GlugIQy/p9dFUBcfKTK9UKUw4jSCrgdyCmaC9DHdW7dzuxkkLem1VYWfn04PQLwD
         qluHFBzMPWH3B0uEp5TbCX37wS+FZ70bzuqDEh9YLnM9Th/Hw9ri4/Jb2tHN1C6trCTh
         2/NxGP7FZc2U6C4Z42UDjNnOd2SgfRP65BneQQeJGMZp6ndyvecNrfJgHMezGgLTkAmX
         BRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu08UoEEhSuGsocqugEAMUYroTyoru7RTTvNi/xK32k=;
        b=VRv0RNfmeNKUojF9NhG2f54kryJyk2Du1KdUOgyulzRmPqI7pNdXg+1/4/04GDQ00h
         6FS5y7FKMc4viVxC6qVgue15kQW75p+V7f3ZZe5263/qqAFKnSR1m/B5ZuKYhpdc723Y
         hZ4f+y+yWWIFetsIDlTSLK8TLAWNC+b0AF7dV8STmQARRJpc9zT3KcKxi6fysBpANbbR
         2zI7pi8TlXqODFzEPMxNjp0b31TZfm5SpP4xWSsU8XJN95p7P9iaV7Sg/7kdQYUGPBm2
         CHCi3j7yb3PH4qb8F5YtLRaVbPv4JlBowMKM+toduS419xncbsAn5taLvAGKaUCyNejR
         vgXg==
X-Gm-Message-State: ANoB5pli9c5biB+VJvbsFfh113HQXfV1q2puIGSoXg5B7nd3/3bcnyKV
        vmqXpY0CsqaQRRqQm+1qUjk=
X-Google-Smtp-Source: AA0mqf6duRCq/i6BoLiMV3zcIk9fw+gjkn/OlXHMw4B8m0NyP+mMBjQP5cpzXBo7sWfOYjGGLA8BeA==
X-Received: by 2002:a05:600c:4fc8:b0:3cf:b067:4142 with SMTP id o8-20020a05600c4fc800b003cfb0674142mr14942913wmq.4.1670927182014;
        Tue, 13 Dec 2022 02:26:22 -0800 (PST)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c511900b003c6f8d30e40sm13471412wms.31.2022.12.13.02.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 02:26:21 -0800 (PST)
Date:   Tue, 13 Dec 2022 10:26:20 +0000
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: mainline build failure due to e240e53ae0ab ("mm, slub: add
 CONFIG_SLUB_TINY")
Message-ID: <Y5hTTGf/RA2kpqOF@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build xtensa allmodconfig 
with gcc-11 with the error:

kernel/kcsan/kcsan_test.c: In function '__report_matches':
kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
  257 | }
      | ^

git bisect pointed to e240e53ae0ab ("mm, slub: add CONFIG_SLUB_TINY")


I will be happy to test any patch or provide any extra log if needed.

Note:
This is only seen with gcc-11, gcc-12 builds are ok.

-- 
Regards
Sudip
