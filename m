Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D02F72C289
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbjFLLJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbjFLLIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:08:49 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A87558D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:57:34 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-56d047c92a8so19197817b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686567454; x=1689159454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FweiWQAKeJ1qYvQwzXHdf5IwJMN0iNTbE1K9BK6H9xg=;
        b=WnDiBYhrr8ywVzCLEe4cmZxqw6YeuzJj5kGb3e9xBpYCsF4tbkjSAHM0lKnXCio0F5
         KozJRq3iCeWP1uGoP5A7lCdZm4YCww49oj1wCin/CkDPVGVjAYIH0Z+AIV/Af+hdZ21n
         qteRcYtgwDBdXRqRluQz4pcRpjDvVdsr4AsZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686567454; x=1689159454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FweiWQAKeJ1qYvQwzXHdf5IwJMN0iNTbE1K9BK6H9xg=;
        b=Eum0+Khs92RLQ+0uPJcObfpMCv9h1Qee7lHk7B2a+q/9lYs79zYf4MSeZau+EOJU9y
         IDoZP0m92rfYwjeSov0ym6S3dgwlC30kUA4izsvmPOFU35ufirEzvgelC9wOYG7CKjz1
         0MXu3YdUB5ikfCarjJWzD5SqOKXLOqYFTWt+mHvXfuylG91tuQ9kgSBUNH/3xk8Rwp/T
         gCaDncMZk2dQ2Z8KGBwcnnH2seGBx+T3UvyU9MpKUhChGvFnBi+/wjIp8tzxd1B+YvUX
         O5a/ECcuEUvVohsSuFP07zt6fMv7X2PeCuLIpMK1wnPV1z4i0KwVNyMQYvOcNgescXRH
         NJvg==
X-Gm-Message-State: AC+VfDyFg2TitlC7gb+RVJF2ZY65soF+p3mN3cTFIWtm32lMxjjsYkSp
        Svvcr92kEl5os6xdu5hXTkl9CBzr4aj63Bm/N/nseg==
X-Google-Smtp-Source: ACHHUZ5DiVPqDVDXyr1wW3qzzIDwHKIlLI2Yp2xZlxBWD7laHCQv1Vj9L02XabmKUv0TtDZGQLdqNKnCpn3hBA1KwtY=
X-Received: by 2002:a0d:cc56:0:b0:56c:fd58:ac27 with SMTP id
 o83-20020a0dcc56000000b0056cfd58ac27mr6184234ywd.8.1686567453877; Mon, 12 Jun
 2023 03:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230609083009.2822259-1-wenst@chromium.org> <20230609083009.2822259-4-wenst@chromium.org>
In-Reply-To: <20230609083009.2822259-4-wenst@chromium.org>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 12 Jun 2023 18:56:57 +0800
Message-ID: <CAJ66y9H91WaRxaZzXRYc5LN9t+M+ZpEy6nbgo=W1kOn_Yu_BCg@mail.gmail.com>
Subject: Re: [PATCH 3/9] regulator: mt6358: Merge VCN33_* regulators
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 4:30=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> The VCN33_BT and VCN33_WIFI regulators are actually the same regulator,
> having the same voltage setting and output pin. There are simply two
> enable bits that are ORed together to enable the regulator.
>
> Having two regulators representing the same output pin is misleading
> from a design matching standpoint, and also error-prone in driver
> implementations. If consumers try to set different voltages on either
> regulator, the one set later would override the one set before. There
> are ways around this, such as chaining them together and having the
> downstream one act as a switch. But given there's only one output pin,
> such a workaround doesn't match reality.
>
> Remove the VCN33_WIFI regulator. During the probe phase, have the driver
> sync the enable status of VCN33_WIFI to VCN33_BT. Also drop the suffix
> so that the regulator name matches the pin name in the datasheet.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/regulator/mt6358-regulator.c       | 65 +++++++++++++++++-----
>  include/linux/regulator/mt6358-regulator.h |  6 +-
>  2 files changed, 52 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6=
358-regulator.c
> index c9e16bd092f6..faf6b0757019 100644
> --- a/drivers/regulator/mt6358-regulator.c
> +++ b/drivers/regulator/mt6358-regulator.c
> @@ -277,7 +277,7 @@ static const unsigned int vcama_voltages[] =3D {
>         2800000, 2900000, 3000000,
>  };
>
> -static const unsigned int vcn33_bt_wifi_voltages[] =3D {
> +static const unsigned int vcn33_voltages[] =3D {
>         3300000, 3400000, 3500000,
>  };
>
> @@ -321,7 +321,7 @@ static const u32 vcama_idx[] =3D {
>         0, 7, 9, 10, 11, 12,
>  };
>
> -static const u32 vcn33_bt_wifi_idx[] =3D {
> +static const u32 vcn33_idx[] =3D {
>         1, 2, 3,
>  };
>
> @@ -566,12 +566,8 @@ static struct mt6358_regulator_info mt6358_regulator=
s[] =3D {
>                    MT6358_LDO_VCAMA1_CON0, 0, MT6358_VCAMA1_ANA_CON0, 0xf=
00),
>         MT6358_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
>                    MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
> -       MT6358_LDO("ldo_vcn33_bt", VCN33_BT, vcn33_bt_wifi_voltages,
> -                  vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_0,
> -                  0, MT6358_VCN33_ANA_CON0, 0x300),
> -       MT6358_LDO("ldo_vcn33_wifi", VCN33_WIFI, vcn33_bt_wifi_voltages,
> -                  vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_1,
> -                  0, MT6358_VCN33_ANA_CON0, 0x300),
> +       MT6358_LDO("ldo_vcn33", VCN33, vcn33_voltages, vcn33_idx,
> +                  MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x3=
00),
>         MT6358_LDO("ldo_vcama2", VCAMA2, vcama_voltages, vcama_idx,
>                    MT6358_LDO_VCAMA2_CON0, 0, MT6358_VCAMA2_ANA_CON0, 0xf=
00),
>         MT6358_LDO("ldo_vmc", VMC, vmc_voltages, vmc_idx,
> @@ -662,12 +658,8 @@ static struct mt6358_regulator_info mt6366_regulator=
s[] =3D {
>                    MT6358_LDO_VMCH_CON0, 0, MT6358_VMCH_ANA_CON0, 0x700),
>         MT6366_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
>                    MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
> -       MT6366_LDO("ldo_vcn33_bt", VCN33_BT, vcn33_bt_wifi_voltages,
> -                  vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_0,
> -                  0, MT6358_VCN33_ANA_CON0, 0x300),
> -       MT6366_LDO("ldo_vcn33_wifi", VCN33_WIFI, vcn33_bt_wifi_voltages,
> -                  vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_1,
> -                  0, MT6358_VCN33_ANA_CON0, 0x300),
> +       MT6366_LDO("ldo_vcn33", VCN33, vcn33_voltages, vcn33_idx,
> +                  MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x3=
00),
>         MT6366_LDO("ldo_vmc", VMC, vmc_voltages, vmc_idx,
>                    MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00),
>         MT6366_LDO("ldo_vsim2", VSIM2, vsim_voltages, vsim_idx,
> @@ -690,13 +682,56 @@ static struct mt6358_regulator_info mt6366_regulato=
rs[] =3D {
>                     MT6358_LDO_VSRAM_CON1, 0x7f),
>  };
>
> +static int mt6358_sync_vcn33_setting(struct device *dev)
> +{
> +       struct mt6397_chip *mt6397 =3D dev_get_drvdata(dev->parent);
> +       unsigned int val;
> +       int ret;
> +
> +       /*
> +        * VCN33_WIFI and VCN33_BT are two separate enable bits for the s=
ame
> +        * regulator. They share the same voltage setting and output pin.
> +        * Instead of having two potentially conflicting regulators, just=
 have
> +        * one VCN33 regulator. Sync the two enable bits and only use one=
 in
> +        * the regulator device.
> +        */
> +       ret =3D regmap_read(mt6397->regmap, MT6358_LDO_VCN33_CON0_1, &val=
);
> +       if (ret) {
> +               dev_err(dev, "Failed to read VCN33_WIFI setting\n");
> +               return ret;
> +       }
> +
> +       if (!(val & BIT(0)))
> +               return 0;
> +
> +       /* Sync VCN33_WIFI enable status to VCN33_BT */
> +       ret =3D regmap_update_bits(mt6397->regmap, MT6358_LDO_VCN33_CON0_=
0, BIT(0), BIT(0));
> +       if (ret) {
> +               dev_err(dev, "Failed to sync VCN33_WIFI setting to VCN33_=
BT\n");
> +               return ret;
> +       }
> +
> +       /* Disable VCN33_WIFI */
> +       ret =3D regmap_update_bits(mt6397->regmap, MT6358_LDO_VCN33_CON0_=
1, BIT(0), 0);
> +       if (ret) {
> +               dev_err(dev, "Failed to disable VCN33_BT\n");

I think it should be "VCN33_WIFI" in the error message?

Regards,
Fei
