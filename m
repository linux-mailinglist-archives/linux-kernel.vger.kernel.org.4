Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D306CF6C6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC2XRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC2XRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:17:16 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C78B4C13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:17:14 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54606036bb3so157164287b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680131833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgH9mKJ5gBSV+mA+S1sr7AZY0jeZJ+IakqUNjPTRKSY=;
        b=dG8P5fvQu8Q8ZahpDMhQVTZKNXjVO9yiiFMiASUQHI3WOQCfIZDhvLin20Sx5Oyz8R
         SZK+9JQvd44EYxtNySj+djYvDLOC4t18NU4NoAbLqSZNkBowarYr4KkIsLk+VfnkrjLc
         hzZX/l0HbyuONypzzeOPNbOnw6ta8bOwQ3sTlRrXSaU/u/BbFDjxq69I+LM7wvk+GG71
         rLoUUY4MAVM7LI+8f+URd5OOWrWZDrNmyBbdQ4XL1As6mr6DYkIExKtBAVIGCacGLPE+
         zwYo0s17PaQAAFjg5nhba7muzJfipkqND0xbK8J7ajXxPESryNGgV4BgcS23MQ8XCB49
         HQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680131833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgH9mKJ5gBSV+mA+S1sr7AZY0jeZJ+IakqUNjPTRKSY=;
        b=REGz2gh9p8mhgIZB39JVEbf1yJC2+oWFs6wvbcLCnjaG/dn3QjoxKldPcmGwRZQ45d
         NRxKLSP36uwciPqfWIbhkCMwv5Uimq2wVAaGnR9qz5yRh/B5orZDLHL8eW2N+8rNTp64
         LomDdY3CAteiXfjlzqtnyi56Qtc8V5qNM1odHjqC6AGuID0is+AhXZA/oPD6dCUBmcVX
         ZzsvVqloSHwVuww//al4vksC/8H+HjTBuSglT57nsOZSSVAeihDJj6hM0WhXpNSH94EZ
         qiq+afVR3FkDtcpFRYxW66yzNQmwfDEUfqh6pU7kYAqD2TN17Eqe37Ste7b2tGJqekGq
         ZwOA==
X-Gm-Message-State: AAQBX9e49yL8AI6WNI0X3HCVTz/sYTLwn8N+N5YCTxuEQuICDkqwWha6
        +zvigK8RUhXk8pCu6WCuXeRzeImqFzIOv8zmPPwQfg==
X-Google-Smtp-Source: AKy350bOR/1/0fZReY1Io91NkJMPTUVQBD8PHVB4inFOb6+jmCb74yhpXKRWMSFEXSqgFEC2ehXh4iqO1uo6CjTFmu0=
X-Received: by 2002:a81:b617:0:b0:544:b864:5532 with SMTP id
 u23-20020a81b617000000b00544b8645532mr9840430ywh.3.1680131833327; Wed, 29 Mar
 2023 16:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230324094205.33266-1-angelogioacchino.delregno@collabora.com> <20230324094205.33266-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230324094205.33266-6-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 30 Mar 2023 01:17:01 +0200
Message-ID: <CAFGrd9qS4mzXWRftbR7dFqtvs9Uc4qzBQMAjRo3rAwN70jDoyA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] soc: mediatek: mtk-pmic-wrap: Add support for
 MT6331 w/ MT6332 companion
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, flora.fu@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Regards,
Alexandre

Le ven. 24 mars 2023 =C3=A0 10:42, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> a =C3=A9crit :
>
> Add support for the MT6331 PMIC and for its companion MT6332 PMIC.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 47 ++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/=
mtk-pmic-wrap.c
> index 366e40b802e4..ceeac43f7bd1 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -170,6 +170,40 @@ static const u32 mt6323_regs[] =3D {
>         [PWRAP_DEW_RDDMY_NO] =3D          0x01a4,
>  };
>
> +static const u32 mt6331_regs[] =3D {
> +       [PWRAP_DEW_DIO_EN] =3D            0x018c,
> +       [PWRAP_DEW_READ_TEST] =3D         0x018e,
> +       [PWRAP_DEW_WRITE_TEST] =3D        0x0190,
> +       [PWRAP_DEW_CRC_SWRST] =3D         0x0192,
> +       [PWRAP_DEW_CRC_EN] =3D            0x0194,
> +       [PWRAP_DEW_CRC_VAL] =3D           0x0196,
> +       [PWRAP_DEW_MON_GRP_SEL] =3D       0x0198,
> +       [PWRAP_DEW_CIPHER_KEY_SEL] =3D    0x019a,
> +       [PWRAP_DEW_CIPHER_IV_SEL] =3D     0x019c,
> +       [PWRAP_DEW_CIPHER_EN] =3D         0x019e,
> +       [PWRAP_DEW_CIPHER_RDY] =3D        0x01a0,
> +       [PWRAP_DEW_CIPHER_MODE] =3D       0x01a2,
> +       [PWRAP_DEW_CIPHER_SWRST] =3D      0x01a4,
> +       [PWRAP_DEW_RDDMY_NO] =3D          0x01a6,
> +};
> +
> +static const u32 mt6332_regs[] =3D {
> +       [PWRAP_DEW_DIO_EN] =3D            0x80f6,
> +       [PWRAP_DEW_READ_TEST] =3D         0x80f8,
> +       [PWRAP_DEW_WRITE_TEST] =3D        0x80fa,
> +       [PWRAP_DEW_CRC_SWRST] =3D         0x80fc,
> +       [PWRAP_DEW_CRC_EN] =3D            0x80fe,
> +       [PWRAP_DEW_CRC_VAL] =3D           0x8100,
> +       [PWRAP_DEW_MON_GRP_SEL] =3D       0x8102,
> +       [PWRAP_DEW_CIPHER_KEY_SEL] =3D    0x8104,
> +       [PWRAP_DEW_CIPHER_IV_SEL] =3D     0x8106,
> +       [PWRAP_DEW_CIPHER_EN] =3D         0x8108,
> +       [PWRAP_DEW_CIPHER_RDY] =3D        0x810a,
> +       [PWRAP_DEW_CIPHER_MODE] =3D       0x810c,
> +       [PWRAP_DEW_CIPHER_SWRST] =3D      0x810e,
> +       [PWRAP_DEW_RDDMY_NO] =3D          0x8110,
> +};
> +
>  static const u32 mt6351_regs[] =3D {
>         [PWRAP_DEW_DIO_EN] =3D            0x02F2,
>         [PWRAP_DEW_READ_TEST] =3D         0x02F4,
> @@ -1182,6 +1216,8 @@ static int mt8186_regs[] =3D {
>
>  enum pmic_type {
>         PMIC_MT6323,
> +       PMIC_MT6331,
> +       PMIC_MT6332,
>         PMIC_MT6351,
>         PMIC_MT6357,
>         PMIC_MT6358,
> @@ -2041,6 +2077,16 @@ static const struct pwrap_slv_type pmic_mt6323 =3D=
 {
>                 PWRAP_SLV_CAP_SECURITY,
>  };
>
> +static const struct pwrap_slv_type pmic_mt6331 =3D {
> +       .dew_regs =3D mt6331_regs,
> +       .type =3D PMIC_MT6331,
> +       .comp_dew_regs =3D mt6332_regs,
> +       .comp_type =3D PMIC_MT6332,
> +       .regops =3D &pwrap_regops16,
> +       .caps =3D PWRAP_SLV_CAP_SPI | PWRAP_SLV_CAP_DUALIO |
> +               PWRAP_SLV_CAP_SECURITY,
> +};
> +
>  static const struct pwrap_slv_type pmic_mt6351 =3D {
>         .dew_regs =3D mt6351_regs,
>         .type =3D PMIC_MT6351,
> @@ -2086,6 +2132,7 @@ static const struct pwrap_slv_type pmic_mt6397 =3D =
{
>
>  static const struct of_device_id of_slave_match_tbl[] =3D {
>         { .compatible =3D "mediatek,mt6323", .data =3D &pmic_mt6323 },
> +       { .compatible =3D "mediatek,mt6331", .data =3D &pmic_mt6331 },
>         { .compatible =3D "mediatek,mt6351", .data =3D &pmic_mt6351 },
>         { .compatible =3D "mediatek,mt6357", .data =3D &pmic_mt6357 },
>         { .compatible =3D "mediatek,mt6358", .data =3D &pmic_mt6358 },
> --
> 2.40.0
>
