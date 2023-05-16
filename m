Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5877049A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjEPJrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjEPJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:47:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8846A2D54
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:47:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f475366522so45446665e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684230467; x=1686822467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LuCmupldNDLkF77f3sCWGieBR1qjxcQ+SEaYQ4NIG+w=;
        b=1s2dNkcV3V2lTSZ/WA4ezzBe3qdAMQKTrwCCtYuBgbTDiR1MTtvugZZQiJnhXfrjiy
         gs+lKnogO8Q5FR+dx/8+lbsMPpp98l0kJu0iST6AYjmggHsL5Org/GRTjyjXGs8SSn4O
         kY7HaBmT67EZZmKKgya9XyeyfYeR2iT6k3nnmB3TjaTq5WSForGjfRsWqZswRlmJRXfc
         kYErI60hHfJzMtKZe3SqL3OMgxlVUmYKaU2lqtgYFmi56fmXkfX1ef6loXLH0xE+0P0v
         sK7MGi23MppsP0ZNRYnAij39FR3vgnadZqvUGK6exHJLaQheOO8oXxWR1+kQJcHOBkDB
         2kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684230467; x=1686822467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuCmupldNDLkF77f3sCWGieBR1qjxcQ+SEaYQ4NIG+w=;
        b=DExVhgMs3PXPiy1M42Bvk9nUk22+w373thWAbiJwVnYHmDuWmWpvwXainFu7DLzen+
         Zs/XeOBac1/bT3PCzruA5FnJfl4OI0n6p6QDGow3iizd43LG4XzSckdOvHGE1D704mIA
         HgRHMswZrvYMMq8g1X+wIh8hvgEsjfs8dqlmKcSbaHSINSSaVApQWIGAiJ2UKi5Nl+Xv
         HIDLQJd4nUfuOTKZXACK+2N6CyXSOhxRTqL++bs3PuptgFbeAo9dT6sykolo9Zxwg7MY
         uOd+YtSaZ512N7IWUc+GwS2fTRcw7chcYjHY5I34I5uDDzumFibEM4HLDqRmpOOXsCpe
         J+rA==
X-Gm-Message-State: AC+VfDw9cgO49HABX1GanCB2kSb8aSEBngaf6ZF4wCQTgggTOIX0Wjia
        QUGT3v7kr4LANHbcwJpcqL1LSg==
X-Google-Smtp-Source: ACHHUZ4+tzEo3gPqnbs2wABAQGZqLY1keg0SlW82sTVq9wrN09r0Vxrbws0a9FFnjZGPZ4qgLDqh0g==
X-Received: by 2002:a05:600c:22c8:b0:3f4:2328:b5c2 with SMTP id 8-20020a05600c22c800b003f42328b5c2mr21336732wmg.35.1684230466855;
        Tue, 16 May 2023 02:47:46 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1834:efa8:a69b:82c? ([2a02:578:8593:1200:1834:efa8:a69b:82c])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003f4069417absm1714542wmd.24.2023.05.16.02.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 02:47:46 -0700 (PDT)
Message-ID: <238b5d83-cfb1-ce99-8e1c-b69b8d65ed91@tessares.net>
Date:   Tue, 16 May 2023 11:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Reported-by checkpatch warning from v6.4-rc1
Content-Language: en-GB
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        linux-kernel@vger.kernel.org, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
References: <ZGKFV/FGu3oDNMV1@francesco-nb.int.toradex.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ZGKFV/FGu3oDNMV1@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco,

On 15/05/2023 21:17, Francesco Dolcini wrote:
> Hello,
> starting from commit d6ccdd678e45 ("checkpatch: check for misuse of the link tags")
> any Reported-by: tag not followed by a Closes trigger a warning, even if
> we have a Link: tag afterward.

The warning you are mentioning below is likely due to commit
44c31888098a ("checkpatch: allow Closes tags with links") instead I think.

This commit is linked to the modification of the documentation allowing
the Closes tag, see commit 0d828200ad56 ("docs: process: allow Closes
tags with links") for more details.

Initially, the intension was to allow using the Closes tags with links
to public bugs trackers because in 6.3, checkpatch was displaying
warnings when it was used while it was fine before. But it turned out
that this Closes tag can be useful for bots tracking bugs reported on
public mailing lists. As explained in [1] and [2], various bug trackers
can use this tag to trigger some actions. It is then helpful to use the
Closes tag each time a commit fixes a bug reported somewhere.

[1]
https://lore.kernel.org/all/20230314-doc-checkpatch-closes-tag-v4-0-d26d1fa66f9f@tessares.net/T/
[2] https://docs.kernel.org/process/submitting-patches.html

> Example:
> 
> WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> #8:
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202305152341.oiSjRpv6-lkp@intel.com/
> total: 0 errors, 1 warnings, 8 lines checked
The warning is saying to replace the "Link:" tag by a "Closes:" one
here. Is it an issue to do that here?

I guess it means that the kernel test robot should then suggest to use
the "Closes:" tag. I can report an issue on their bugs tracker.

> From what I can understand it was not in the intention of that patch,
> and Link: is still fine to be used.

Note that Checkpatch cannot cover all cases: it gives you
recommendations but they can be ignored (and documented in the commit
message) if they don't make sense in your case. Here, it looks like you
should use the Closes tag but it might be fine to use the Link tag if a
commit doesn't fully fix the reported issue for example.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
