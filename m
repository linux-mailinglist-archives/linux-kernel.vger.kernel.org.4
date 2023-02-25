Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA846A2C8B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 00:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBYXPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 18:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBYXPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 18:15:40 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B9CF777
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 15:15:39 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-536cb25982eso78476057b3.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 15:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SJmSfEEN4ER+rrwr2AAo+0NwW5TiTbnjxiFoVH+2l9g=;
        b=lJuA91aU+Z6dTyfnGMZiVv3hrjIkUarjSMsX4//t7Svg2+BqrGDoGH0GjaPHAdBO4u
         G3blhCZrGSY7lPwfnaKaW39TqZjA/tz4w6Vv1c+0JaDZS2srvRmFlfxteeK3UpfVBreJ
         5F8qqdMVrlED+IGO+nY37MbRA7IKvEt4wWuVcgZAA84RtrzqTpYeSsqH2SMeL6gpX0lE
         +n9MzpJR4CBJEDStxxjecE5wzyZK8v8sgZwd7sYVY4RtLz7ZEul2g8HJPy7fggXDL3xB
         8gWG3WGEGYMnEs1sowTXxetmnWh9yN9AfLCCjOiKo0CniLKCUTCTXaz+sgbee/E0TQGH
         XHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJmSfEEN4ER+rrwr2AAo+0NwW5TiTbnjxiFoVH+2l9g=;
        b=s4sCo3DM7TrZ+f0N4r1auqVo9nlYUbUwkfj6xV8+UD8nRYOourHmQ4vXmpYCJ8LUA0
         CN561GHZ9oJvXaLpsWMztt2EEdIDcPLRY/68W6fEOLZaZ1DutnGL8XLIcmGunjmEB2tC
         Y52B9LQWppnme412h2GdrLqHJX2Rv1STF+Ky03faaQDZJj/rztMLG6eY/cWwRDEiav+R
         ISOqF4Kj05agwAPhjX0tTdnQPAw11rS7GaFQfewoqOaADni9ky4dxJl9aAiXsErKr9eY
         0YwWYwELsxMjL5W9s9csY7dA1f+xeYRYJcuxgbdgJtfubI0cB2GCs9TR18lknIHBR0R2
         tuJA==
X-Gm-Message-State: AO0yUKVyqyOc7wYmzsmOlgDrnL/WyOtO5Bdtha1BqHOBn4pwxOiFHj0F
        anBLrUMSbPE71Coo3L0V/qUJMhW8a3FmRPNlRJVrjg==
X-Google-Smtp-Source: AK7set81k6a7OARPbG8rGRSwKMm+X+pUCEQjYElVtITGMi8kMV0p1mfBo4QFoFXB6q5yGAxkalHBm6shkJcbwLjHKLw=
X-Received: by 2002:a81:af5d:0:b0:52e:cea7:f6e3 with SMTP id
 x29-20020a81af5d000000b0052ecea7f6e3mr7373343ywj.10.1677366938879; Sat, 25
 Feb 2023 15:15:38 -0800 (PST)
MIME-Version: 1.0
References: <Y/cBB+q0Ono9j2Jy@gondor.apana.org.au> <20230224231430.2948-1-kunyu@nfschina.com>
 <Y/cy5wUtk10OahpO@gondor.apana.org.au> <CACRpkdYyB=-UnE1bmdVszSSB5ReECZ0fUoWJX6XtYbKHEe52tA@mail.gmail.com>
 <Y/c7iVW67Xhhdu8e@gondor.apana.org.au> <Y/hQdzsKMYgkIfMY@gondor.apana.org.au> <CACRpkdZe3cMMxJesD0mpqHTwvuWHjSGVHsiFUQQyuA+VWknMTQ@mail.gmail.com>
In-Reply-To: <CACRpkdZe3cMMxJesD0mpqHTwvuWHjSGVHsiFUQQyuA+VWknMTQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Feb 2023 00:15:27 +0100
Message-ID: <CACRpkdY7V=x9+oWsbPtmjc-WBz6v2aSr9RVD1pJ4SGu+Dxejvw@mail.gmail.com>
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

On Sat, Feb 25, 2023 at 1:01 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> I tested this on the Ux500 and sadly this happens
> already in probe():
(...)
> [    2.828815] stm32-hash a03c2000.hash: Algo 0 : 0 failed
> [    2.834144] stm32-hash: probe of a03c2000.hash failed with error -22

It turns out that this is because this:

-       /* Export Context */
-       u32                     *hw_context;
+       /* hash state */
+       u32                     hw_context[3 + HASH_CSR_REGISTER_NUMBER];

Makes struct stm32_hash_request_ctx 580 bytes
and that fails sanity check in ahash.c because
HASH_MAX_STATESIZE is 512.

I don't know the story behind why HASH_MAX_STATESIZE
is 512, the stm32 hash state contains a buffer of 256 bytes
so I guess either that buffer is a bit big or
HASH_MAX_STATESIZE is a bit small?

I'm happy to try to change either to make this fit.

Yours,
Linus Walleij
