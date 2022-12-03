Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC3D641597
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 11:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLCKNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 05:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLCKNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 05:13:48 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BF95C0C7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 02:13:45 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3a7081e3b95so72236977b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 02:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wBmOYpLKCwO+tluU+vXuBFaOvnYFkQdkgAkJOn+z3dE=;
        b=c01aXZEpL0lsGvIA8axQe+u0D5W+oSU3f2s1Gm1moPtzCMq7V6qhDKa5+E4TFaauDq
         y5xA8RXPhwRaBOegCIutXehvF46kxBJD1BNcjadTbJXheEVd0LwRK4WaW1Sf9Bir6mZS
         ZmXMcBLfkCr+mg4Z7117YwF2NtNZoYCTx6/FPH82bE8UUdJQe4ELS3ACKG1LxTxv9/C9
         6CQmkibSdtiwQOR3k1LtbtnL6VBl0rXeRcC/7JOr6pkVEyNaOcXdwwAJMelTT291IJih
         djL6g7YGLqDZWZLMNbg56JMRNYbcY82lbDhHtNzq7uyAq9TXMe1f+ucw4g7JUfhzsWh/
         NtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBmOYpLKCwO+tluU+vXuBFaOvnYFkQdkgAkJOn+z3dE=;
        b=2B++cE6SK2JG09yWd3GIUndpJpTTjd6q92gktGRO5oqW586uh4bGOPVwQKqzxFu3HV
         gkxGRgARtxhgIO8Mg2fraM6iGNwTg4K42uxlTcQRjK7R2cBRYanOTb96uL6N05w11xSC
         t+OXTLNBcs4oX2RaxJvMEua/KZI9LhT6SH92sV++wXloznLAeWM51xRODfwalMc0qeJh
         6nVWMjyyeJA80j8+2BxzyRHs99+2YxHciDy+VcHDDe+yrpHoHxz/vkFYm+q5NRVuYHvY
         ozst5RHPooZAeTDrjYzbMyd2pxsK4HLnETuiSzKFO9GE7uErN2czm0b88AkhOvyu+ghv
         2NqQ==
X-Gm-Message-State: ANoB5pmOaInlssQvPxPnTx0JFrnRd9SKWrkfIV9BPT90iX/SUY4js8Ls
        1/Z37eNbuAokdem1wDGpP1pxEdxktsb43APggn5Ubw==
X-Google-Smtp-Source: AA0mqf5P+F3W24LqvzZ/BBOs/LJ4Ngbv0DrAifTQsBQOZeF8RCBig/ivNxeXFYX51WC62r2ttDGLXvEgNy1hqn2K9hw=
X-Received: by 2002:a0d:e645:0:b0:3bb:6406:3df1 with SMTP id
 p66-20020a0de645000000b003bb64063df1mr35954717ywe.319.1670062424683; Sat, 03
 Dec 2022 02:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20211015164809.22009-1-asmaa@nvidia.com> <20211015164809.22009-3-asmaa@nvidia.com>
In-Reply-To: <20211015164809.22009-3-asmaa@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 3 Dec 2022 11:13:33 +0100
Message-ID: <CACRpkdagKTDgUYBkF3hdE69Zew22uOpN9Ojsqwc=BrKpFOehNA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] net: mellanox: mlxbf_gige: Replace non-standard
 interrupt handling
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org,
        bgolaszewski@baylibre.com, davem@davemloft.net, rjw@rjwysocki.net,
        davthompson@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 6:48 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

> Since the GPIO driver (gpio-mlxbf2.c) supports interrupt handling,
> replace the custom routine with simple IRQ request.
>
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>

Should this also be merged into the GPIO tree with patch 1?

Yours,
Linus Walleij
