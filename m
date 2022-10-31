Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FF4613559
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiJaMIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiJaMID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:08:03 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A9EF006
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:07:59 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-370547b8ca0so25967177b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uIgEds2lsUEazFDcLqiFcBouG6saS9AagLSYOnXJFgM=;
        b=pBJsJOAmF+05N3+3hZfjF1ZtP+2ryz6assxcuDYfI5liFd25pwJmh3ip1CYl0NQ5b7
         Q/R1ZzvhOAmZwRIKXL0/Rd3vJlSMqBQhKbXmeRKtrHVvCXgJCl68xaX2G9UwK4VfPkcr
         DbST64ziRaWJXYFPDvxm+67zOVzWRldT5mqtqIjB0pQbk0KOFdLZlVOkbQIgegc/M26f
         HCwZRlL2uhDTlN69oODCR8mTGCI+bqk6NyYip7jNywRSyby2dLOxUeqKKCeTF+bQdwb8
         uIj5xO9FWyVJFdKEt7rZYqlLXCtjHoHoxBURZ+9i2kIIC/npgwSi00nnFKPe6hjb2lW6
         BjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIgEds2lsUEazFDcLqiFcBouG6saS9AagLSYOnXJFgM=;
        b=Ts3Lj2BT/9FD1p96LK/br6ygobb2INvK7agP/VmOP+pc4lm60aZ7JwlYW6HE5gfyfR
         DWHyA+bgTMbNr6c5N4JetC2ULYNIJgtfFptazzcsglcgT8FM7X5lex6UmEjKqI1HiTH6
         Zf5nUcdvC2s0SSgTObvGCGDPj3yFrXO17iDp9X0Yo/VC8AUSMKHngzip+9j9RLwrETVt
         k4xInlBijDOH4HaUt266QnQHbl/NJREEOG6DYR/lNil6JQbBYxYZbkx490pBKFRZlZoF
         fpwL/nPh+t5R0kEwv1s5cFpE4YXzSnnrhZ7wvN5O4cQ4BI4sSmHLeFygHayQoewruMAO
         14nQ==
X-Gm-Message-State: ACrzQf112CrxiDZ7kfqVfQ1rbleCH50ApCSrYEvnh4KoEbtucLjBP4GB
        Hs+lE8iwzHJC9WGucN3OBdJK1hPsvN7gsN7NrLsSUMqo6pogBQ==
X-Google-Smtp-Source: AMsMyM6Rk+z9XSkM0gx0kUZjmUPDqfeBWgYp5+03gj8tpxxxciSK6Ab/X9mTjfczx5v4JFxVOh/jbjlcTd0zGQEaMuA=
X-Received: by 2002:a81:4f89:0:b0:36a:f09f:73fc with SMTP id
 d131-20020a814f89000000b0036af09f73fcmr12513606ywb.487.1667218078610; Mon, 31
 Oct 2022 05:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221030172609.1635096-1-ajye_huang@compal.corp-partner.google.com>
 <20221030172609.1635096-2-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20221030172609.1635096-2-ajye_huang@compal.corp-partner.google.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Mon, 31 Oct 2022 20:07:47 +0800
Message-ID: <CALprXBY3S5N-g6N=q4DgF3ngq-eTxc_+LjGJQp2QjVz+Fi4pRg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ASoC: mediatek: dt-bindings: modify machine
 bindings for two MICs case
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob Herring,


On Mon, Oct 31, 2022 at 1:26 AM Ajye Huang
<ajye_huang@compal.corp-partner.google.com> wrote:
>
> +
> +        dmic-gpios = <&pio 23 0>;
>
>          headset-codec {
>              sound-dai = <&rt5682s>;
> --
> 2.25.1
>

I think the modification will be better, I will send v5 again, thanks
@@ -63,14 +70,19 @@ required:

 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>

     sound: mt8186-sound {
         compatible = "mediatek,mt8186-mt6366-rt1019-rt5682s-sound";
         mediatek,platform = <&afe>;
         pinctrl-names = "aud_clk_mosi_off",
-                        "aud_clk_mosi_on";
+                        "aud_clk_mosi_on",
+                        "aud_gpio_dmic_sec";
         pinctrl-0 = <&aud_clk_mosi_off>;
         pinctrl-1 = <&aud_clk_mosi_on>;
+        pinctrl-2 = <&aud_gpio_dmic_sec>;
+
+        dmic-gpios = <&pio 23 GPIO_ACTIVE_HIGH>;

         headset-codec {
             sound-dai = <&rt5682s>;
