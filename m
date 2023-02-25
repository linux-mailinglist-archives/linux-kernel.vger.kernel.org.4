Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC74C6A254C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 01:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjBYACI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 19:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBYAB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 19:01:59 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBFD6A7B0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 16:01:58 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-53852143afcso23797887b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 16:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YGce1k7vLcc005CSr+hSLKXBF5SLmaJtWY6pcwxKx0Q=;
        b=wmKV6llXzbyV9ZIrbyej2OunFiU741qhFzyT++YfHdH+wiBtK7OyXKguWCb/kxA5lR
         DgiV/yoxIJFHFT7HIAGeNE09zKS75YuufpetByYC+zQvHhisK1MF1WcBapNZQL2eZoTE
         QHiLj96u/q3tU+9/uJa4MeMk3UhGRkOxdXZPb8EDh1xZ3nxCyran5snsFAKmTd/5JtEu
         FzHlHgHlzZp3XLv5EM9LwJixEhKTFFF1gIvYyhd8N03lSvOiQxUSedhNiJdnX0om6B9S
         ntCGHIcAFPwdHLJL2q3LRLX9MSEOB3M4l/aQIIHL5vFmWJgiaeGOAcJ+ZKIBu2P0b/sx
         fnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGce1k7vLcc005CSr+hSLKXBF5SLmaJtWY6pcwxKx0Q=;
        b=1w+qIZMT8wvXGaSiujLCotnrQrL40yucc4SFQyeerO5/jPulHnbitd/obqsp1WhmxW
         z8l6JVd64klVKw1K0HqDRs9mM1/fv+KMMwuqi2itxTfM737PWPTBYZP0djKFd4miUW+V
         tg3Do4NOo+vsj0mWP35NcRUfcmMfIvtqfmxlO6xwfmpI1blc9tr/XYkZ/uDQrGeQBp4f
         9C4maXwhFeiE92R9s5NVfnVsi9RBXWejw/UEi1Ph008RHX86wBS0Xiqy4Muy561SC9B9
         Y2xhLAvXkb5MC4u4zTcuf461TBOTCJ27HFoQVnF2n9PrFXNcN2Nf2P/Gyi4wgrvAOc27
         Cr7Q==
X-Gm-Message-State: AO0yUKWY2ItCzZ7aDRmNP9hX9AzTzCnPSRCvUkg/TuW+3UCy0e3NIEAU
        ZSm0MtXxwp8GKc8Z34lGky0kCxDW+9y7sDQE7crloQ==
X-Google-Smtp-Source: AK7set99QV/uEaIf43VqawXg5tt6DNfPTfljZt6PYvMnndqiUknRY5fA1wfLo7lx9pLsVMLGPQvxOcTnIyR7ML4cJf4=
X-Received: by 2002:a81:af1b:0:b0:533:8080:16ee with SMTP id
 n27-20020a81af1b000000b00533808016eemr5627579ywh.10.1677283317533; Fri, 24
 Feb 2023 16:01:57 -0800 (PST)
MIME-Version: 1.0
References: <Y/cBB+q0Ono9j2Jy@gondor.apana.org.au> <20230224231430.2948-1-kunyu@nfschina.com>
 <Y/cy5wUtk10OahpO@gondor.apana.org.au> <CACRpkdYyB=-UnE1bmdVszSSB5ReECZ0fUoWJX6XtYbKHEe52tA@mail.gmail.com>
 <Y/c7iVW67Xhhdu8e@gondor.apana.org.au> <Y/hQdzsKMYgkIfMY@gondor.apana.org.au>
In-Reply-To: <Y/hQdzsKMYgkIfMY@gondor.apana.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 25 Feb 2023 01:01:46 +0100
Message-ID: <CACRpkdZe3cMMxJesD0mpqHTwvuWHjSGVHsiFUQQyuA+VWknMTQ@mail.gmail.com>
Subject: Re: [v2 PATCH] crypto: stm32 - Save and restore between each request
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

I tested this on the Ux500 and sadly this happens
already in probe():

[    2.802539] stm32-hash a03c2000.hash: dma-maxburst not specified, using 0
[    2.809342] stm32-hash a03c2000.hash: No IRQ, use polling mode
[    2.815226] stm32-hash a03c2000.hash: DMA mode not available
[    2.821140] stm32-hash a03c2000.hash: will run requests pump with
realtime priority
[    2.828815] stm32-hash a03c2000.hash: Algo 0 : 0 failed
[    2.834144] stm32-hash: probe of a03c2000.hash failed with error -22

I don't quite understand why, we never get to the tests...

On Fri, Feb 24, 2023 at 6:52 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:

> v2 fixes potential state clobbering from the disconnect between
> hdev->flags and rctx->flags.
>
> ---8<---
> The Crypto API hashing paradigm requires the hardware state to
> be exported between *each* request because multiple unrelated
> hashes may be processed concurrently.
>
> The stm32 hardware is capable of producing the hardware hashing
> state but it was only doing it in the export function.  This is
> not only broken for export as you can't export a kernel pointer
> and reimport it, but it also means that concurrent hashing was
> fundamentally broken.
>
> Fix this by moving the saving and restoring of hardware hash
> state between each and every hashing request.
>
> Fixes: 8a1012d3f2ab ("crypto: stm32 - Support for STM32 HASH module")
> Reported-by: Li kunyu <kunyu@nfschina.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

I think I understand the direction of the patch but it seems
the pm_runtime_* calls get unbalanced since now this is taken
in
stm32_hash_one_request
 -> stm32_hash_hw_init()
    -> pm_runtime_get_sync()

But no corresponding
pm_runtime_mark_last_busy(hdev->dev);
pm_runtime_put_autosuspend(hdev->dev);

Exist anymore? You know the semantics better than me,
I'm not sure where to put this, I guess where you save
the HW state in stm32_hash_update_cpu()?

I don't know about the DMA case then though.

Yours,
Linus Walleij
