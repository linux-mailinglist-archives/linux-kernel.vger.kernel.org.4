Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087F46BAC40
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCOJfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjCOJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:35:46 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C7C4C02
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:35:44 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id m5so12300392uae.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678872944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoJoVM6gqKLtFPF0ww73r0+4RF3tgtqyFHA91mNeIYw=;
        b=O/3bAdhUe48qZvpoZqx3Pw8s/FrAmjdjjZvfCijvjlKRWTfTMU5tbsDBOpA9hAWtav
         olHDQAPVeU2cT9iAE2UrJckxzDmE5feSD1yUT2sMv3tYGA621qiT9Na2Wrjctq6Wj9d0
         pfx393aeEDuroVK1kRbOaYs+2VR9JC3kFBqQY0v6Nql0ZoNri3YOcBDFhPm/CuYAvV4b
         jIIcftSsMTSVhpl6vG0wlIPKrPWs1NGP9r5ZwDYD53X+mWkY3+jYN9y6S+lwr+uAtmle
         jC2PasiDZWZbGEYzqwK4mX/PBFwu2Z13woTVIMdeniesXbI9J130hM0OkvRVSE7wMgOb
         1BYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678872944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoJoVM6gqKLtFPF0ww73r0+4RF3tgtqyFHA91mNeIYw=;
        b=g/3G/KHwAZxHM7E5czTOWIZbdJvAgtNe6ZcGBk+0rnaQfuXaBvrq1d3xSGjV5zAhmF
         A5aRuXoPqZhB1NqLXJPWtjeLDdQh2i0i3yvfLmI6lqXR0Zf8HNVsq9XBjije7PCSTeDB
         +uTiMsBBdtB3SE3SX1fLAEDR1i1Tf7GoeAc9CvpvtbuR5lmq4+mVNlJ1SW1sTB42uarP
         dnuLK+WktLxCtHvLK/XCzAu2KKWqcsEC5p1q1skDTHH/t/xfD7XdCQ8w7LTcOPZyJuDl
         SlOweJJv7j1q1EdlSxgfKz58GOMbjFy8eLojOYIgd07+yEFYF1WEIcYyChBHY8IDB5SH
         Ad4Q==
X-Gm-Message-State: AO0yUKVLQVPoYvP1kAa2478PrABZtQuj0TWBoOGqsqAPsoFg5OBI9qHs
        MOn+72NMxMLtoXhbnDEx+TzklNsS0C8q4a+0/BEiCQ==
X-Google-Smtp-Source: AK7set/4Zyg05tITWrNUvmSdP9y3Xvhk2X6MSf2OeQSj39yboR6W2vExsMy1xm9Kdcs4w91r7yjSNkITgNdTF+Uwuv4=
X-Received: by 2002:ab0:16c9:0:b0:755:9b3:fef8 with SMTP id
 g9-20020ab016c9000000b0075509b3fef8mr4116716uaf.2.1678872943875; Wed, 15 Mar
 2023 02:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230311112513.254095-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311112513.254095-1-krzysztof.kozlowski@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 15 Mar 2023 10:35:32 +0100
Message-ID: <CAMRc=MdDyT7yOyPihyZGe4u516WK+6w7mTA=JmYoHeUwGDS58g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: gpio: xra1403: drop Semi Malinen
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Nandor Han <nandor.han@ge.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:25=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Emails bounce: 550 5.1.1 No such user - pp
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5383af5d3b45..d73560738f46 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23084,7 +23084,6 @@ F:      drivers/i2c/busses/i2c-xlp9xx.c
>
>  XRA1403 GPIO EXPANDER
>  M:     Nandor Han <nandor.han@ge.com>
> -M:     Semi Malinen <semi.malinen@ge.com>
>  L:     linux-gpio@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/gpio/gpio-xra1403.txt
> --
> 2.34.1
>

Applied, thanks!

Bart
