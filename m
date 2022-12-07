Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3E36459EB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiLGMh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiLGMhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:37:52 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C3B286FD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 04:37:51 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id l17so3029037vkk.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 04:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=teTEDU5QtKj0Mfr2EVBu+S1YQD/f2Wbp5vvhIJeVf1U=;
        b=Jq9l8QUT3RmW8agCe3pj35jp6CDAu9QRV3Me52lzDEq6xGTJdTpJQnUa6FVprMKVYF
         1j/QPap2PSi+LTcn5LXngQ6BSj1ajRXBF+UEKCrsmmvsf9YOH2uYrxHe9TUCzNRS2dzW
         mCSjBh4GwFIr1sktccAiZiGMXYyZfhfe+l0hKFebmB9FDylbefeY5lFaJZ0bfJpvk2jq
         Zug0l6dh6b3UzGzzOwpYbr3AcB5kp9h6/NR5p5563q1ZrasUCIDNBFHk/oME7ut3JG7H
         LcLCyexwfNvXSNH779CRjecVSukD4SOWlKqEMC5XwaaQiAztoYTB1dkgytorOdX0uTEV
         A/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teTEDU5QtKj0Mfr2EVBu+S1YQD/f2Wbp5vvhIJeVf1U=;
        b=A2hL8wijwEQG/E8jNcO+/0pQvqVyorIDjwqobOjHxDuxHJVSpMCd2JOwHPtPV0HmFN
         g6Aw2fPJtsrXuWhQk0dxfiBFdEWc/w0jbDl+ZwvScwIWoU2cD8QNuFANPIO9mb1FnJ9m
         0OCtIYrhIKT6r4zdgy11zxH1Y5FrV+DH+iDKwpF8fPbIvo97V05YcPWErMDrC9G2/5JG
         Vuagh+Q38r4ea4tO1qCRg87D4qwnIs/7vlFW9/aM2zoiLjIEuMP0BNhwZ4E4QZB+Prvh
         DDFNFKd64gADLo9avqgE7dlrSIb4iPqQCgBBfA88mJBwkrDHVs5TMfprjeAdKnKcakt7
         ep5Q==
X-Gm-Message-State: ANoB5pl4r9kSe9RqnZ7Qr+D4iFCsIlt02PuBNLCZ9G7UJEG7WlK24hkf
        oFI7jcLui9f2MKEQoCofOyuF9hRhXd74Wv7BCu6NYg==
X-Google-Smtp-Source: AA0mqf5EouDbLcaUjLPD1/54NEmZJn57yjwMnxFOZ8DjaPlF3C1lSul0Ie2XnC3QvGA+28fynHBDLbuOjNBUXYE7+1I=
X-Received: by 2002:a1f:16ca:0:b0:3bd:8e1:26c4 with SMTP id
 193-20020a1f16ca000000b003bd08e126c4mr19034510vkw.3.1670416670412; Wed, 07
 Dec 2022 04:37:50 -0800 (PST)
MIME-Version: 1.0
References: <20221206211554.92005-1-robh@kernel.org>
In-Reply-To: <20221206211554.92005-1-robh@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 7 Dec 2022 13:37:39 +0100
Message-ID: <CAMRc=Mf0HdoH4Ca0o85j-4-beGGPFr+_bF2OGUP=Fc=tmNd5Og@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add missing 'unevaluatedProperties' to
 regulator nodes
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Gene Chen <gene_chen@richtek.com>,
        Daniel Mack <zonque@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 10:18 PM Rob Herring <robh@kernel.org> wrote:
>
> Several regulator schemas are missing 'unevaluatedProperties' constraint
> which means any extra properties are allowed. Upon adding the
> constraint, there's numerous warnings from using the deprecated
> 'regulator-compatible' property. Remove the usage as examples shouldn't
> be using long since deprecated properties.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I'd suggest that Mark take this if that's okay with Lee. Or I can take
> it.
>
>  Documentation/devicetree/bindings/mfd/max77650.yaml  |  2 --
>  .../devicetree/bindings/mfd/mediatek,mt6360.yaml     |  9 ---------
>  .../bindings/power/supply/mt6360_charger.yaml        |  2 +-
>  .../bindings/regulator/max77650-regulator.yaml       |  1 +
>  .../devicetree/bindings/regulator/max8660.yaml       |  6 +-----
>  .../bindings/regulator/mt6360-regulator.yaml         | 12 +++---------
>  6 files changed, 6 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/max77650.yaml b/Documentation/devicetree/bindings/mfd/max77650.yaml
> index b0a0f0d3d9d4..4181174fcf58 100644
> --- a/Documentation/devicetree/bindings/mfd/max77650.yaml
> +++ b/Documentation/devicetree/bindings/mfd/max77650.yaml
> @@ -100,14 +100,12 @@ examples:
>                  compatible = "maxim,max77650-regulator";
>
>                  max77650_ldo: regulator-ldo {
> -                    regulator-compatible = "ldo";
>                      regulator-name = "max77650-ldo";
>                      regulator-min-microvolt = <1350000>;
>                      regulator-max-microvolt = <2937500>;
>                  };
>
>                  max77650_sbb0: regulator-sbb0 {
> -                    regulator-compatible = "sbb0";
>                      regulator-name = "max77650-sbb0";
>                      regulator-min-microvolt = <800000>;
>                      regulator-max-microvolt = <1587500>;

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
