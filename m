Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901F56933A7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBKUZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBKUZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:25:44 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931DE125BE;
        Sat, 11 Feb 2023 12:25:42 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qb15so21341380ejc.1;
        Sat, 11 Feb 2023 12:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lLacBBRlz93H3GiKKvSQD2qZJYcpqiTjyuyAIXkHfUk=;
        b=HnvlPd2wCVKP1vEA5oBzN09Hm7YBjsJX5upx2hujewee0OEBtMeFDjUN0pNfY1qNzj
         /6e+ChM9OpYSHEHTVo/d5JN4LCYMYeMvjzMpTmh5pZ+FbQjTSiarXOl3fsp3LN3r5lrU
         uVDbJHNlzEbGRXVmnwYdZ+4BdMeKqhSrmF7yAiLEgDHQOfQsGAU1ESNHG4p1GZ/FBk8C
         PYnUrj+WyW5jtbwdj9wyGMdBbTO10UXCDDg9EzsoEbicsFM6IuGG6OOIQre7nLz3vyNV
         Rx/nB7kR/S5q71duUSyDIiXocP70Q2eDFgGyiBMVG3XXFeN6BUnMsH1/O0MgRKRhZ9v1
         peQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLacBBRlz93H3GiKKvSQD2qZJYcpqiTjyuyAIXkHfUk=;
        b=fhCtsIjS0Fm7/2hQo9u6KS71nPy6U8935uc98VX26SOATUoPWtaJYh0OxxO0wD8lL8
         LVYISUqJRGkttHkgi+AqCLxx4Ud1DbqEKN2uYj7cxhs1dYk246DIlHgWbyEt7oxNl/GI
         hHNdGr6q3ll7MkaBp6SNzZxV6R/9wtKE0pMg44EIBXdTpHe+umlNyg1p/2BAKouUo8TA
         j0HsUOLt+KqfN9ub7OK1N9VUxEH3P8O0k4Rns+xwqAJMfgeinZSsM3UjmarDcVnLhFqa
         aB07YzhlLkkuNxp+6lBMo7JicLati4uD/cPHn0pEK0KVxCo4t0kgzIa1dK3dUGhE/BEI
         Fffw==
X-Gm-Message-State: AO0yUKWZItBUq8Ps+OmOAobMdtj3H5Pw68Msn+RxwKUyUxZNe+zBWm8i
        89MgpIYA2tNEAHDYQRG/qyv5MS1NXw/lEVj4lUM=
X-Google-Smtp-Source: AK7set+r8/isemvwKFykUdz65hr3VaRSbzbkw3mFuod0hK8/niYyuljq/yGDoa19MVZw3qAcXd7psXWFNbni52Mh3LI=
X-Received: by 2002:a17:906:c44e:b0:8af:341c:1f82 with SMTP id
 ck14-20020a170906c44e00b008af341c1f82mr2622125ejb.4.1676147141118; Sat, 11
 Feb 2023 12:25:41 -0800 (PST)
MIME-Version: 1.0
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
 <20230209-b4-amlogic-bindings-convert-take2-v1-3-c4fe9049def9@linaro.org>
In-Reply-To: <20230209-b4-amlogic-bindings-convert-take2-v1-3-c4fe9049def9@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 21:25:30 +0100
Message-ID: <CAFBinCCACzEDaa2Z+h5JzXRjEcQ9QH0R+=_UXOKHe7zX02im=Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: soc: amlogic: document System Control registers
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Feb 9, 2023 at 2:41 PM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Document the System Control registers regions found on all Amlogic
> SoC families and it's clock, power, pinctrl and phy subnodes.
I understand clock (main clock controller) power (power domain
controller) and PHY (HDMI and CVBS PHYs). Are you sure about pinctrl?

[...]
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - amlogic,meson-gx-hhi-sysctrl
> +          - amlogic,meson-gx-ao-sysctrl
> +          - amlogic,meson-axg-hhi-sysctrl
> +          - amlogic,meson-axg-ao-sysctrl
If you have to re-send this then it would be great if you could add:
          - amlogic,meson-hhi-sysctrl
because we already have that in arch/arm/boot/dts/meson.dtsi for the
32-bit SoCs.

[...]
> +        power-controller {
> +            compatible = "amlogic,meson-gxbb-pwrc";
> +            #power-domain-cells = <1>;
> +            amlogic,ao-sysctrl = <&sysctrl_AO>;
For this node (and similar ones) I have a question to the device-tree
maintainers:
The power controller has a dedicated sub-range of registers. This also
applies to the CVBS and HDMI PHYs.
But the clock controller does not (it has its registers all over the
place - unfortunately that's how the hardware is).
I have been asked to add a "reg" property to child nodes with a
sub-register space.
Does this mean we need to add a reg property here as well (regardless
of whether we're using it in the driver or not)? And what to do in
case of the clock controller though?


Best regards,
Martin
