Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF0E671177
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjARDFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjARDE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:04:58 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5D84FC3F;
        Tue, 17 Jan 2023 19:04:56 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hw16so68180687ejc.10;
        Tue, 17 Jan 2023 19:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MC6dKsWvLg5s18ciHdgNTii7U58PMTVdbUF07VlWry4=;
        b=RJO1VvDH+plMRGd85p0IyR4CKi1ysTABShqq6PVFfTXWLz9Sbs9tlbHH7GLWaWttXb
         55I6bKrDk/6iHEno2NwHZxJ689X3Td7B2rbPqZkkM+kCoeLgVFhZWKarkO6DLbiBqf88
         sW3EIhYkWk1cjYgP4lzgtRLDlyqgUxsafUQ1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MC6dKsWvLg5s18ciHdgNTii7U58PMTVdbUF07VlWry4=;
        b=MIRH2aRMZN5B5YU3Xx8usaY7zl41kASdLk896TZsOjoScLpQZ1tVPjVhinVMqzyq4W
         jGxxGzNUmPnl9DkQ4C3tfYBeTFTHn+ZIepRWO8YI75LaE6C+dHQNxvRaE7XrmdbSkzwu
         GzuVbY84+alE8IpdQiky4YhlG7QMgG6dyeiZ/jgL+vVGig4Vh/kuA21FxkS3CZQJVtus
         zZpoTaVg/gjvbiZuHsB0lo5r4yvzxqppm0U5S3urpoKGLFe13+xYJTyBv3seIcBxkz9t
         Y8qMvHb+KH1ZL+uBU/hOEhT1XUO/w1RLChL+mMwe0toLtDJgKWrRMFNLFWYPclGOdt+d
         frEA==
X-Gm-Message-State: AFqh2kqpWmKIrx53m8LZWF3SbfgGKGpoquQl7kJ3IXmiC8dWpo7pF5FE
        8m4AA/N0W32//iZdsQ60BxWRzkKduhCt0JxKzrib8YRD
X-Google-Smtp-Source: AMrXdXvJBiK3TuHV68yBM+CcDgve5etA6JUoAwX4XlU8mjdLj4Zs5Cw/SRDOdh0EVxK4wNh98BAHp8miuD9/paVVTuU=
X-Received: by 2002:a17:907:75e8:b0:872:1905:4185 with SMTP id
 jz8-20020a17090775e800b0087219054185mr360185ejc.651.1674011095502; Tue, 17
 Jan 2023 19:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20230111100105.707-1-aladyshev22@gmail.com>
In-Reply-To: <20230111100105.707-1-aladyshev22@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 18 Jan 2023 03:04:43 +0000
Message-ID: <CACPK8Xenc2E6-fe_mkoDOXXHim8ZUV9-h2vFpwUfvuen0M0aPQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: ethanolx: Add label for the master partition
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2023 at 10:01, Konstantin Aladyshev
<aladyshev22@gmail.com> wrote:
>
> Add label "bmc" for the flash master partition. The master partition
> is required for the firmware update in the OpenBMC ecosystem.
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

I've merged the 5 patches you sent for submission into v6.3.

If you have a set of device tree patches feel free to send them as a
series next time. I know they're unrelated, but by sending a series
they are easier for the maintainer tools to process as a group.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> index 6406a0f080ee..889b2fdd19cf 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -58,6 +58,7 @@ &fmc {
>         flash@0 {
>                 status = "okay";
>                 m25p,fast-read;
> +               label = "bmc";
>                 #include "openbmc-flash-layout.dtsi"
>         };
>  };
> --
> 2.25.1
>
