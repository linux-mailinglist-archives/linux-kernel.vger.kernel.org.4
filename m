Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCECF6CF680
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjC2WlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjC2WlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:41:08 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CE55BA8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:41:00 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id k17so21335170ybm.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680129660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HP6j+DU+MoE9A0IYOuntBF31Ne44IF3oyP+KWeldQTc=;
        b=0B0q14oWCxtPwbWeDxp+M+ZsWj8UfgNmit5vebjz9hpyyAxEVueR0PbDGmwoMWUI9u
         Cfr12jqh2pAmn1lSPaH0DuOohUl8BUb+bklVg3pdVDnJiHgX8yj7pJEHAqUZOrMFph5p
         qzHpAdUk0RbvOFmQsTWqBEnqATlLGiLptmiMC2EkK5sl/Sd6+blsPG3M28Wj7AMfIWO5
         EPjOiu+iM3U+KQ7GAbE+c8ILElGBVlF7jYqzgmFWqtEpUIviZlfjFTBEwoprMkyHzz37
         u/bwomiqeJdsJOeV7kw8ejggyqNv1ILgmVRfhk0nTLxxpvcooR7McXpI//8FoWCRbES0
         Scsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680129660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HP6j+DU+MoE9A0IYOuntBF31Ne44IF3oyP+KWeldQTc=;
        b=I3ZbsuXTGyv0AojCNblY7HvEpyxBrkhNx4jvtSRXMYI8ORLd7FulIlHUMZ7uI+ybJi
         yVWK6egPExwvgg0yNSvWIlj/nCiyJU0TKD+adcV5umh8EsIOWQjav0v9lsUJsMGAZUrU
         SbyL18znmeoAnqAmaZoZ+1gQ4HrvTakcRPtj3schcHMF57ebYuCN5ayIs/Nlj6C3m8tF
         TmzLdPCarUhatdY5SYCDUptRWkrBQQppM67wIIyS2znrAB0CiuAbyMr1fBeNoCMthRn1
         aQj2xHZIuCwv+ifK06u5kjnGDFIwUEdupK1gXwYiAE6qfY5nDzAkvl44hAFMpQzETlvZ
         EouA==
X-Gm-Message-State: AAQBX9eIEIUL9fU57wM+DWBVA0aQWKl/kmaHYxESAPZ2RTUrefhJg2Mn
        tv1UIk4N0Qf+zuQCqHTdHQoK3Kytv0iRujKZ04G14A==
X-Google-Smtp-Source: AKy350auSkretDCKc3GwqJLWtBSKFs7m8qlQ5csPeo5vk/e6+ySCdpua771J676eyVzfkMOED+NXF4As/QobiYttluE=
X-Received: by 2002:a05:6902:1181:b0:b6c:2224:8a77 with SMTP id
 m1-20020a056902118100b00b6c22248a77mr14001376ybu.1.1680129660014; Wed, 29 Mar
 2023 15:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230324094205.33266-1-angelogioacchino.delregno@collabora.com> <20230324094205.33266-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230324094205.33266-5-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 30 Mar 2023 00:40:48 +0200
Message-ID: <CAFGrd9qNzza+EW5ARqbSGFjnCvuxn5De=dLSCGh26z2Kqd8_yw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] soc: mediatek: mtk-pmic-wrap: Add support for
 companion PMICs
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

Le ven. 24 mars 2023 =C3=A0 10:42, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> a =C3=A9crit :
>
> Some PMICs are designed to work with a companion part, which provides
> more regulators and/or companion devices such as LED controllers,
> display backlight controllers, battery charging, fuel gauge, etc:
> this kind of PMICs are usually present in smartphone platforms, where
> tight integration is required.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 73 ++++++++++++++++++++++------
>  1 file changed, 59 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/=
mtk-pmic-wrap.c
> index a33a1b1820cb..366e40b802e4 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -47,6 +47,7 @@
>
>  /* macro for device wrapper default value */
>  #define PWRAP_DEW_READ_TEST_VAL                0x5aa5
> +#define PWRAP_DEW_COMP_READ_TEST_VAL   0xa55a
>  #define PWRAP_DEW_WRITE_TEST_VAL       0xa55a
>
>  /* macro for manual command */
> @@ -1222,12 +1223,16 @@ struct pwrap_slv_regops {
>   * struct pwrap_slv_type - PMIC device wrapper definitions
>   * @dew_regs:      Device Wrapper (DeW) register offsets
>   * @type:          PMIC Type (model)
> + * @comp_dew_regs: Device Wrapper (DeW) register offsets for companion d=
evice
> + * @comp_type:     Companion PMIC Type (model)
>   * @regops:        Register R/W ops
>   * @caps:          Capability flags for the target device
>   */
>  struct pwrap_slv_type {
>         const u32 *dew_regs;
>         enum pmic_type type;
> +       const u32 *comp_dew_regs;
> +       enum pmic_type comp_type;
>         const struct pwrap_slv_regops *regops;
>         u32 caps;
>  };
> @@ -1548,9 +1553,12 @@ static int pwrap_init_dual_io(struct pmic_wrapper =
*wrp)
>  {
>         int ret;
>         bool read_ok, tmp;
> +       bool comp_read_ok =3D true;
>
>         /* Enable dual IO mode */
>         pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_DIO_EN], 1);
> +       if (wrp->slave->comp_dew_regs)
> +               pwrap_write(wrp, wrp->slave->comp_dew_regs[PWRAP_DEW_DIO_=
EN], 1);
>
>         /* Check IDLE & INIT_DONE in advance */
>         ret =3D readx_poll_timeout(pwrap_is_fsm_idle_and_sync_idle, wrp, =
tmp, tmp,
> @@ -1564,8 +1572,14 @@ static int pwrap_init_dual_io(struct pmic_wrapper =
*wrp)
>
>         /* Read Test */
>         read_ok =3D pwrap_pmic_read_test(wrp, wrp->slave->dew_regs, PWRAP=
_DEW_READ_TEST_VAL);
> -       if (!read_ok) {
> -               dev_err(wrp->dev, "Read failed on DIO mode.\n");
> +       if (wrp->slave->comp_dew_regs)
> +               comp_read_ok =3D pwrap_pmic_read_test(wrp, wrp->slave->co=
mp_dew_regs,
> +                                                   PWRAP_DEW_COMP_READ_T=
EST_VAL);
> +       if (!read_ok || !comp_read_ok) {
> +               dev_err(wrp->dev, "Read failed on DIO mode. Main PMIC %s%=
s\n",
> +                       !read_ok ? "fail" : "success",
> +                       wrp->slave->comp_dew_regs && !comp_read_ok ?
> +                       ", Companion PMIC fail" : "");
>                 return -EFAULT;
>         }
>
> @@ -1640,19 +1654,41 @@ static bool pwrap_is_cipher_ready(struct pmic_wra=
pper *wrp)
>         return pwrap_readl(wrp, PWRAP_CIPHER_RDY) & 1;
>  }
>
> -static bool pwrap_is_pmic_cipher_ready(struct pmic_wrapper *wrp)
> +static bool __pwrap_is_pmic_cipher_ready(struct pmic_wrapper *wrp, const=
 u32 *dew_regs)
>  {
>         u32 rdata;
>         int ret;
>
> -       ret =3D pwrap_read(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_RDY=
],
> -                        &rdata);
> +       ret =3D pwrap_read(wrp, dew_regs[PWRAP_DEW_CIPHER_RDY], &rdata);
>         if (ret)
>                 return false;
>
>         return rdata =3D=3D 1;
>  }
>
> +

Remove this extra line please.

> +static bool pwrap_is_pmic_cipher_ready(struct pmic_wrapper *wrp)
> +{
> +       bool ret =3D __pwrap_is_pmic_cipher_ready(wrp, wrp->slave->dew_re=
gs);
> +
> +       if (!ret)
> +               return ret;
> +
> +       /* If there's any companion, wait for it to be ready too */
> +       if (wrp->slave->comp_dew_regs)
> +               ret =3D __pwrap_is_pmic_cipher_ready(wrp, wrp->slave->com=
p_dew_regs);
> +
> +       return ret;
> +}
> +
> +static void pwrap_config_cipher(struct pmic_wrapper *wrp, const u32 *dew=
_regs)
> +{
> +       pwrap_write(wrp, dew_regs[PWRAP_DEW_CIPHER_SWRST], 0x1);
> +       pwrap_write(wrp, dew_regs[PWRAP_DEW_CIPHER_SWRST], 0x0);
> +       pwrap_write(wrp, dew_regs[PWRAP_DEW_CIPHER_KEY_SEL], 0x1);
> +       pwrap_write(wrp, dew_regs[PWRAP_DEW_CIPHER_IV_SEL], 0x2);
> +}
> +
>  static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  {
>         int ret;
> @@ -1689,10 +1725,11 @@ static int pwrap_init_cipher(struct pmic_wrapper =
*wrp)
>         }
>
>         /* Config cipher mode @PMIC */
> -       pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_SWRST], 0x=
1);
> -       pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_SWRST], 0x=
0);
> -       pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_KEY_SEL], =
0x1);
> -       pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_IV_SEL], 0=
x2);
> +       pwrap_config_cipher(wrp, wrp->slave->dew_regs);
> +
> +       /* If there is any companion PMIC, configure cipher mode there to=
o */
> +       if (wrp->slave->comp_type > 0)
> +               pwrap_config_cipher(wrp, wrp->slave->comp_dew_regs);
>
>         switch (wrp->slave->type) {
>         case PMIC_MT6397:
> @@ -1754,6 +1791,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *w=
rp)
>
>  static int pwrap_init_security(struct pmic_wrapper *wrp)
>  {
> +       u32 crc_val;
>         int ret;
>
>         /* Enable encryption */
> @@ -1762,14 +1800,21 @@ static int pwrap_init_security(struct pmic_wrappe=
r *wrp)
>                 return ret;
>
>         /* Signature checking - using CRC */
> -       if (pwrap_write(wrp,
> -                       wrp->slave->dew_regs[PWRAP_DEW_CRC_EN], 0x1))
> -               return -EFAULT;
> +       ret =3D pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CRC_EN], =
0x1);
> +       if (ret =3D=3D 0 && wrp->slave->comp_dew_regs)
> +               ret =3D pwrap_write(wrp, wrp->slave->comp_dew_regs[PWRAP_=
DEW_CRC_EN], 0x1);
>
>         pwrap_writel(wrp, 0x1, PWRAP_CRC_EN);
>         pwrap_writel(wrp, 0x0, PWRAP_SIG_MODE);
> -       pwrap_writel(wrp, wrp->slave->dew_regs[PWRAP_DEW_CRC_VAL],
> -                    PWRAP_SIG_ADR);
> +
> +       /* CRC value */
> +       crc_val =3D wrp->slave->dew_regs[PWRAP_DEW_CRC_VAL];
> +       if (wrp->slave->comp_dew_regs)
> +               crc_val |=3D wrp->slave->comp_dew_regs[PWRAP_DEW_CRC_VAL]=
 << 16;

IMHO, the number 16 should be replaced by a define even if I guess
it's a simple shift value.

> +
> +       pwrap_writel(wrp, crc_val, PWRAP_SIG_ADR);
> +
> +       /* PMIC Wrapper Arbiter priority */
>         pwrap_writel(wrp,
>                      wrp->master->arb_en_all, PWRAP_HIPRIO_ARB_EN);
>
> --
> 2.40.0
>

Sounds good to me.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Regards,
Alex
