Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A40656516
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 22:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiLZVK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 16:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLZVKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 16:10:55 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EEA2C9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 13:10:52 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-46198b81e5eso162000377b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 13:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J42NUGnXu0h1Bk+E7TEH0cHs4zW3jQgz63YOfaT6R4o=;
        b=fby4OLKH151VRJ789hGfQSzmSqrajYxiS1+T9qg9bHTp+RXOFP/V3aRAhFJUl5vWPZ
         1ykwsyhFC5LgVppphf7/qcAbKo2P6zoINlbpSWIy8K1tz2j0Rzqy6/J9ImNUMRBZ2uA0
         vmRJ82oh0K1rykgKC9Ha8M6/RD8vgkiP+QAKMPKjFX5W9OylsOYJuxJICNYwqasd/gOa
         dDZO/HNF6Bl0+U3M7+n+4gHQ8/5vJvlbLrh2OBmu9hU5gjuhAxjeG3uSbnqXFtuKfF6e
         FNA7ZSd3YeCbMaTXfahRF9AxA+smQVAKaH2f9TuNPYKJD3nlvleMCjKsK+KeoGWCPkZa
         A2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J42NUGnXu0h1Bk+E7TEH0cHs4zW3jQgz63YOfaT6R4o=;
        b=UxCvWS68h6rJ1BeIwM6WA4bIuP7+IGPP96h4BUT3QE3U1Sm1EEvWNz0NsXeHKQM7tK
         13pwQgTioobEtiRENccJXDrsbpBCTVQwCWNMXP7hrK/tpxJyvWU+yVo2osY8E7oBqD9E
         0oQWAa+mCRNCOuhjcVfAkBUQOX2/nLQay5FWDL1wSEoLbqQrYRbEdqdtyD/JtH6CVTgw
         km/qFAc4hsfjwNO82eBXcSsVfXamKxCKMJIxRWzxVJ4jbXtIiQQnZAHru5kxorQ+7X+9
         e9sVJ4JUMw1sW98AP7Twt1tLMaOis85mUzAWhM/wlBp2Q4ElAqBVwxGOMHxGSujLlw4q
         hcnA==
X-Gm-Message-State: AFqh2kp4G6Zk8lXq91E9wSuIqn6E/YiXY/4nurAL9wDDissAhCHy/Y9e
        z5jykNv7m8mykl5VQx4ceEw+4zG2pVpn/2gdAsw=
X-Google-Smtp-Source: AMrXdXuaO5nlhJdGAif73syg1E/b8OKy2N1GeWi2BHkG+X5AvoIJrKTqDG8y7z95SzhUZk0+NNnvIaLtU1OB++fu638=
X-Received: by 2002:a05:690c:444:b0:3b6:4fa2:1a10 with SMTP id
 bj4-20020a05690c044400b003b64fa21a10mr2295613ywb.48.1672089051413; Mon, 26
 Dec 2022 13:10:51 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221226195206.GA2626419@roeck-us.net>
In-Reply-To: <20221226195206.GA2626419@roeck-us.net>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 26 Dec 2022 13:10:40 -0800
Message-ID: <CAMo8BfKR2quFYBKmVdgmFfhP0y2jCTwKB7Det9o0a6PYuJkP3A@mail.gmail.com>
Subject: Re: Linux 6.2-rc1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 12:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
> xtensa:allmodconfig
>
> Building xtensa:allmodconfig ... failed
> --------------
> Error log:
> kernel/kcsan/kcsan_test.c: In function '__report_matches':
> kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes is larger than 1536 bytes
>
> Bisect for both points to commit e240e53ae0abb08 ("mm, slub: add
> CONFIG_SLUB_TINY").  Reverting it on its own is not possible, but
> reverting the following two patches fixes the problem.
>
> 149b6fa228ed mm, slob: rename CONFIG_SLOB to CONFIG_SLOB_DEPRECATED
> e240e53ae0ab mm, slub: add CONFIG_SLUB_TINY
>
> Context: CONFIG_SLUB_TINY is enabled with allmodconfig builds.
> This enables some previously disabled configurations and disables
> some previously enabled configurations. Not sure if that is a good
> thing or a bad thing, but it does result in the above errors.

For xtensa I've posted the following fix:
https://lore.kernel.org/lkml/20221223074238.4092772-1-jcmvbkbc@gmail.com/
I suspect that previously KCSAN was disabled in allmodconfig builds for xtensa.

-- 
Thanks.
-- Max
