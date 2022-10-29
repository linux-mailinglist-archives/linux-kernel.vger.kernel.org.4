Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E843611FDB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 05:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJ2Doz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 23:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJ2Dov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 23:44:51 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D7C13DEF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 20:44:47 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id m125so8137871ybb.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 20:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gz8chRT8BgwvM1bBz/hqcVOXEH6efHhKugP2b6d/KNA=;
        b=g6MMhZCmMEfh5a1DNSkgtctHLoc0Zxx78dPchuD8LfuYJuM5a1iKBrVY3MzEJpWdSU
         St2AbaMMDtRXzuN7Q9fGU5SuwvRBV8GtPCtMKFew5Jgeo3SqAp3VI2Uff9lQ4/h7Xgjv
         e87BsOqWIITvxqZrgqybtQZCsPPTDd+GZ/aDgY1yOHLKqOuhxyFLlNxRFYJbUVplgX/b
         Nr1A7IKy/E9utSKzdSQGIo8zwRASo1XvlR14JZTP3iaAwE60u+5pauhotsJQew5rfIhz
         o07M4q7QLt1ZdhZ2j+qK4jcCgzprDxNjmdyBOeBCztLzR3zFNw+3a/w8RQH3ndmDNtaW
         h3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gz8chRT8BgwvM1bBz/hqcVOXEH6efHhKugP2b6d/KNA=;
        b=hnwMnLsjdtbQ5waJl2KfVh6ca9kQIZGCGVjIGq2EAkedr/aILOAtT1l+90XfwSLI7L
         7UwAiljEw2tKv4JN+fQI7szRHMawo1MHhB5IqsWvzqJkjB1RBU/UdZpxdagqwZeNnv8I
         sweYFQydGhFk8daEqPFndD+AIY+RXGA61Mk9kCcbdnOaXBiOJO/S4JRNzm2Jsa3Z4Ans
         odJbeX/pbP8acaIJH71VYq1JvuqrsxWqoKwDAA9r5V62B66seJ4W24FVWxDbXsbfm/tf
         DhDksqJo5jvINTUuY+UnK+cNjNzaSBy88jxYExbOK/lXf1yR9DcbrI1o2lvZucbil89w
         XYgw==
X-Gm-Message-State: ACrzQf17WFuirl4O/GyqWSwdc4aeKaQTsGzbi3LLces7I9c9gHzEJkww
        afrJSKqnX7l65JEJ1ZXDf95Q1Oc2YeL2uTgJI+VoFZfQa7/CUA==
X-Google-Smtp-Source: AMsMyM66Ody47i2fsJ1hG0H/GOy1qXYYvmBtbpesojjIICAXjadL3JpiUK2chgxERuVe2gXSvIE968uC4fCiiR0bu24=
X-Received: by 2002:a25:420e:0:b0:6ca:2d9b:bdcb with SMTP id
 p14-20020a25420e000000b006ca2d9bbdcbmr2339348yba.453.1667015086809; Fri, 28
 Oct 2022 20:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221028172215.1471235-1-ajye_huang@compal.corp-partner.google.com>
 <20221028172215.1471235-2-ajye_huang@compal.corp-partner.google.com>
 <628ac98c-0755-e6f6-e010-f1e772c4b71a@linaro.org> <CALprXBY8FUc_w=JO3bp9m1e=1d5Fcvrou_En1JG8Hx0BYuETKw@mail.gmail.com>
 <Y1wi+g9yVR+++iIg@sirena.org.uk>
In-Reply-To: <Y1wi+g9yVR+++iIg@sirena.org.uk>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Sat, 29 Oct 2022 11:44:41 +0800
Message-ID: <CALprXBZ0qTkd1UoJ-TNEA8Epp5nBJW1KYsBQz_Wtm4YnxewmrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: mediatek: dt-bindings: modify machine
 bindings for two MICs case
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
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

Hi Mark Brown,

On Sat, Oct 29, 2022 at 2:44 AM Mark Brown <broonie@kernel.org> wrote:
>
> There was my thing about putting the names in DT too.

> @@ -72,6 +76,8 @@ examples:
>          pinctrl-0 = <&aud_clk_mosi_off>;
>          pinctrl-1 = <&aud_clk_mosi_on>;
>
> +        dmic-gpios = <&pio 23 0>;

I think I added the pinctrl-name and pinctrl id in its example, to
make it easier for the user to understand , like below, what do you
think? thanks
examples:
  - |

    sound: mt8186-sound {
        compatible = "mediatek,mt8186-mt6366-rt1019-rt5682s-sound";
        mediatek,platform = <&afe>;
        pinctrl-names = "aud_clk_mosi_off",
                        "aud_clk_mosi_on";
+                       "aud_gpio_dmic_sec";
        pinctrl-0 = <&aud_clk_mosi_off>;
        pinctrl-1 = <&aud_clk_mosi_on>;
+       pinctrl-2 = <&aud_gpio_dmic_sec>;

+       dmic-gpios = <&pio 23 GPIO_ACTIVE_HIGH>;

        headset-codec {
            sound-dai = <&rt5682s>;
        };

        playback-codecs {
             sound-dai = <&it6505dptx>,
                         <&rt1019p>;
        };
    };
