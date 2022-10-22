Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589F4608C05
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiJVK4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiJVK4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:56:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F90A17E06;
        Sat, 22 Oct 2022 03:14:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m15so14393028edb.13;
        Sat, 22 Oct 2022 03:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QU5eKnCMasT6Q9fSCMOcqpffbD8d615reCYXwSO/gf4=;
        b=hGU6dc6xbDgw8swPGkLy3Yorq+CrOuuW/m//YQGpQSrTiLpoecj4A5xKOXogY7torv
         aNY/+de9gUXI2qoFVounok6PizOkGfHz29Mav3d6j0MajPeZuK6EhwcCadyETjDlMwV4
         LeHUwBwLqbrrsbQhlAslMjZXx/g68JIjtjF+CTFsyyaUX/aSr66Agqtkzgkrs5aM9kl4
         L0WkXZU+l+/TSMZrRQNr27oQ/fEOW+9E7N6jw+rgH7fL+Y/YYexvdaLYVrySPrDslQ/j
         /0/Gx/vALPRnTNtiVGn8tQDa29CKOozeeaiXRvoa+obLxRtAqWJ8rDbiiuJfdUTJhgDe
         k8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QU5eKnCMasT6Q9fSCMOcqpffbD8d615reCYXwSO/gf4=;
        b=cjigCWnyURG5FuLELuEHUnVnbIjpBibzRQvaVLtnANxpXEWTENZc03CsuE1nzfhP2i
         LbxSOBeg3WH/RILV/zqMyYVjFGjAW0GPe9sJrEuA/0xJ3kycf+6XXv4VLlFy4YS98dep
         bw7n+Cmezf2nA5gf8szhc1gs+6NXBhQ+EjkLiBFn02ySkvCbz5TBhAMy/vycRqPHKk5W
         QlvrPEInrKmB6g3aAPMT2HGukVaDfMzQNYslNHNW8W8e219faGhetTPlOhTQ30P75U8Y
         CYBsVZoYzWndVp+mTcSrt3z9OEQiiZGsRzSgvbPrX342fcWq/2rohTGYQ/0rQ31sJSze
         Olwg==
X-Gm-Message-State: ACrzQf2NG/w6iF4TSdunAXMqEA46ZUoluFjl246CKBc8qKXqno0OhQKj
        PXm2/9fO2h8/SrHsOxmVTMoxR9he5YmuueJERug=
X-Google-Smtp-Source: AMsMyM5pa070Y9cycfmF7F9UaRmgJ8sMMr0dewTd+9nBguRc1O4LCWhsfWTjqaFi9UqVjZl0uRdKCF+KcsOb793/C1g=
X-Received: by 2002:a17:907:3c81:b0:77a:327a:815f with SMTP id
 gl1-20020a1709073c8100b0077a327a815fmr19824207ejc.422.1666433660962; Sat, 22
 Oct 2022 03:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com> <20221004-up-aml-fix-spi-v4-3-0342d8e10c49@baylibre.com>
In-Reply-To: <20221004-up-aml-fix-spi-v4-3-0342d8e10c49@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 22 Oct 2022 12:14:09 +0200
Message-ID: <CAFBinCBwBz6AmxDDJPuww=WRG7Pc0xUWeH+DRXM6WcyctouFhw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] arm64: dts: meson-gxl: add SPI pinctrl nodes for CLK
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        linux-amlogic@lists.infradead.org, Da Xue <da@libre.computer>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Fri, Oct 21, 2022 at 3:31 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
> Add SPICC Controller pin nodes for CLK line when idle for Amlogic GXL
> SoCs.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
