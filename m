Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AED76AD13E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCFWMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCFWML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:12:11 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EE63A86A;
        Mon,  6 Mar 2023 14:12:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i34so44942745eda.7;
        Mon, 06 Mar 2023 14:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678140725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqypu7u/BnVkPsWhKgSLQ0HSA3bK6nIuV9PU1Lpb2mg=;
        b=IOci51nlSXuzjieRaUOdqf7r8nrRzsLGJ/+PuVCPOHoreEgDEZb0OVUh/dmsKMFPaC
         4TTD9gY+iKeCKS/boVDNDnoFbXOVcJwNlu+vBC2kWyxnny2n9r9CJb+gFlyLt9+r81Gd
         tnkWyCq9c9Ed1PHIiDgickobAM8wLo8xnIze4aW2JzYLeSG1uCzdu1TUSqzdVrMw4Klr
         O0zBzMPlCcssafaAd2NQ/uJUnfrUel5mz8cPeWW9THB6ob4N0y5assV+n1BaGnHUdrd4
         C+mJ0DIuwBqcGNZdrrj/I14eA3fR1n4QHDqV87U4f4v0jVtndGo11O/b/in7Rl4/qpIj
         VbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678140725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqypu7u/BnVkPsWhKgSLQ0HSA3bK6nIuV9PU1Lpb2mg=;
        b=WJjIfdzTLoNSIjzzYFF0+A40Kl0maPH23e984RsuZNhg0pKnMuV43JjHmz0ZPMtjgG
         sfjTM9WpuW7UHZzaPnH/m4TmT9j0zxwtVy0r/Bah0Md30nU1qFULQE3wBljWrdB16l73
         +2Og7R4Gw4uJdqipVXvC6i4YPKxzMX1nemZ6qMKhqyTb0//LZ24dDRZZwk9nbrDGnhoV
         vAyBggXhg1yOi22LI+B+7ohWabpFXJ74lgvJTMcpXYYFt7G7pEqIG8ekS/vKLabZN8Bg
         WlfFKYjP7hkmwtgIaOq5AvfaXKpiRmnlJiabmTadvJu2JxoPeD9uDdWAnSUa/wSH/GQ4
         78IA==
X-Gm-Message-State: AO0yUKU+Rrd/utJX+/QlApQLJxiQnKBZOnz8LBsTIUy7G4VRnZR+HCY/
        4rC4cPrwuzxoP9MCYeksEJo0BiFRxpbFwv73nJQ=
X-Google-Smtp-Source: AK7set/gu/IdXxNN+vChaAZ724dQ1hXdRmX35ADEx87yTxXBbtfBRX0aQ7h1uHAQ4a7LHZMaz7nsO3/goggYA0FGMcM=
X-Received: by 2002:a17:906:3002:b0:8dc:6674:5bac with SMTP id
 2-20020a170906300200b008dc66745bacmr6146850ejz.4.1678140724700; Mon, 06 Mar
 2023 14:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20230303-topic-amlogic-upstream-bpi-cm4-v2-0-2ecfde76fc4d@linaro.org>
 <20230303-topic-amlogic-upstream-bpi-cm4-v2-2-2ecfde76fc4d@linaro.org>
In-Reply-To: <20230303-topic-amlogic-upstream-bpi-cm4-v2-2-2ecfde76fc4d@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 6 Mar 2023 23:11:53 +0100
Message-ID: <CAFBinCDSWHg1uc8+c_QwoQy2j8K5Ny6xfMfXm-zp67eYH_Zxdg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: amlogic: Add initial support for
 BPI-CM4 module with BPI-CM4IO baseboard
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Mar 6, 2023 at 9:31=E2=80=AFAM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> Add support for both the BananaPi BPI-CM4 module and the BananaPi
> baseboard which is comnpatible with the RaspberryPi CM4IO baseboard.
s/comnpatible/compatible/

>
> The BananaPi BPI-CM4 module follows the CM4 specifications at [1],
> but with a single HDMI port and a since DSI output.
s/since/single/

>
> The current CM4IO baseboard DT should work fine on the Raspberry CM4
> baseboard and other derivatives baseboards, but proper DT should
> be written for other baseboards.
>
> The split is done so it's easy to describe a new CM4 baseboard, enabling
> only the necessary HW used on the baseboard.
>
> [1] https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf
>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
With the typos above fixed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +&ext_mdio {
> +       external_phy: ethernet-phy@0 {
> +               /* Realtek RTL8211F (0x001cc916) */
> +               reg =3D <0>;
> +               max-speed =3D <1000>;
> +
> +               interrupt-parent =3D <&gpio_intc>;
> +               /* MAC_INTR on GPIOZ_14 */
> +               interrupts =3D <26 IRQ_TYPE_LEVEL_LOW>;
It would be great to have the reset GPIO (GPIOZ_15) described as well.
But this can be done in a follow-up patch.


Best regards,
Martin
