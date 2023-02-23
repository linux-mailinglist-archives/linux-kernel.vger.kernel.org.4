Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6F26A0012
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjBWA35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjBWA3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:29:55 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FC43B67A;
        Wed, 22 Feb 2023 16:29:53 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so1634596wmb.3;
        Wed, 22 Feb 2023 16:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SHpIcdcfu2QwzrdJ1uxO4xocrtfBEjCJ4RxVjp9sgOU=;
        b=Yf87uJwGYliNd36S+sLgfWBAXTfQdhy1VzIRp0KbxYTA13uM2Vk4OWlfwfZ8E+sBw9
         rHf5SOJ5EFBzJFv3MrdQdMWxy7N+gTQMaeCms+aC8UnM5WpNHutGu+wxxa4g1UQkE0UJ
         GxAKSo9TTFoLNVici8/GAA152nmmzB67+508enIPb9kr/wuqWrwWk57PYWIB95w0r6jL
         kHqrqL0FiTh4Nna2PE029De37GGCBBmz6m/4WuLZQixpJxBhDSPCAwYUmn5IzmxJwdiI
         +wLbt0zc9XlQaGHE2rkNJHpS64o3L3karkRifDEBat9HU2Hfu++S6F1PJ3RG5AngjB2a
         riGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHpIcdcfu2QwzrdJ1uxO4xocrtfBEjCJ4RxVjp9sgOU=;
        b=sKIVjBtid7RBTkgiWaFIiI+fPgqR17a6lq2578YoTEDyXpnBue9tVQ5YxGWz6DRnvi
         97OoAGnPQyBuI0lZSxDhFp87xaBgpgUM13+oKNPMfEKwe0UIvNgGOcAQsDYiY69F9H5Z
         PeiUGT1Y94l96v5Ql8Wjxxr/u+XiQw7bEw0uS4JJnH+ggtNNSCSI0nJHfysoGZRKu2jc
         YPWlk78hlCCtDFJ/oxXd5oYY3V0LO2OAz74AR3B6HAfkL/M+HCrqcWMJuyKkYjYQ/lY6
         wIi7QH/fz4f3fWC1S/nmgRTGHU5kOpzjUYnT73+cvw/SHfp2QM1RBrVBwC7dMBmJ7/Fv
         HAeQ==
X-Gm-Message-State: AO0yUKWZPG54Vnjsy64HcFgt0r84PUP5X1PNhTx0aBuvge4dbfnJtg/X
        5KgQdzzPAMsAd2xqchtThux9AqezocN2sYq5AFo=
X-Google-Smtp-Source: AK7set9+nca08kKpI5Y0oddvQU4q0ca+jRk0wYzFD9uskGKw3ptLxN4A9hJufyTdsalyMjsQtHx1TFHNYxnv/hI5Q6Q=
X-Received: by 2002:a05:600c:34d2:b0:3df:f9e6:72d6 with SMTP id
 d18-20020a05600c34d200b003dff9e672d6mr432569wmq.102.1677112191500; Wed, 22
 Feb 2023 16:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20230215010914.104754-1-frattaroli.nicolas@gmail.com>
In-Reply-To: <20230215010914.104754-1-frattaroli.nicolas@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 22 Feb 2023 19:29:39 -0500
Message-ID: <CAMdYzYrZvHLFdhn_qYadYbDDnnC+16pkM_kWXiU16u_6XNHEMg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Always enable sd regulator on
 SOQuartz CM4IO
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Feb 14, 2023 at 8:09 PM Nicolas Frattaroli
<frattaroli.nicolas@gmail.com> wrote:
>
> The 3.3V line coming from the SDMMC regulator is required for USB
> on the CM4IO board. Without it, the USB mux (U13 in the CM4IO
> schematic[1]) that's used likely remains unpowered, and no USB
> devices show up.
>
> The consequence of this was the behaviour of an inserted SD card
> allowing USB to work, while pulling it out turned off all USB
> devices.
>
> [1]: https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf

I disagree with this. According to the datasheet u13 and half a dozen
other devices are powered by 3.3v sourced from the SOM. sdmmc_pwr
triggers SD_PWR_ON which serves only to provide an enable signal to
u18, the regulator that powers the sdmmc slot from the same 3.3v. If
you are having problems with USB working, you likely have something
else going wrong here.

Very Respectfully,
Peter Geis

>
> Fixes: 5859b5a9c3ac ("arm64: dts: rockchip: add SoQuartz CM4IO dts")
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> index 263ce40770dd..88a61fa8a95c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> @@ -135,6 +135,12 @@ &sdmmc0 {
>  };
>
>  &sdmmc_pwr {
> +       /*
> +        * USB also needs this regulator to work on this board, so just enable
> +        * it unconditionally.
> +        */
> +       regulator-always-on;
> +       regulator-boot-on;
>         regulator-min-microvolt = <3300000>;
>         regulator-max-microvolt = <3300000>;
>         status = "okay";
> --
> 2.39.1
>
