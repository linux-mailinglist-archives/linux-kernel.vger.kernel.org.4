Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08536577E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiL1Oge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiL1Ogc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:36:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788022DEB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:36:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y16so15115816wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcDJ8cLQMqdQCgdlu7boodh16/p3tpC1pQ2svfRFC3A=;
        b=IvNoRS6OeLqDUjIqbx1sfziFPIjchIHDmR5ZRGybzQrDZWA3db8SEyytYdHzfyIgPV
         tArCq9XdUhjK9kJqZGLya+LvIlZ11naohLQvLziQoWcRkedMFb54dgAGJa2izFqlC/G8
         0s0yjC48OT1vsWJr8akX1ERobMHTMjwozQjkk4T3DwptvyVqi6ovXvVFqY1T9HlzvGfg
         JuJqTQTTehi76HsS/RDXLKLmDnsIzpeB3yUjlmivqLCMQDJ1Yyg1NyQcKR+uZgLc8aUO
         mgp0KkEZS/MBpMWxWKWLT1HWkw48D1V9av9nSGKH4nCapSrLluq54CmMHHcsoGb5mM85
         4rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wcDJ8cLQMqdQCgdlu7boodh16/p3tpC1pQ2svfRFC3A=;
        b=UEYqReiMN8cEYxJSSNyEI8ICv0h3z1fNv8LXRyJ6CpkUF1ZdQa+s0Ix225HHz03Vyc
         lKLxk2Yau3WjuWQy41GIEbu43cQNNVB5KniHDO6lHJLlsfdJpfi/nOqJPgMh0sKCney3
         Cleu5Jd8mczPktpFFZe0woBVJ8AOmykg1YIyy/eAR9TQ717M7K2yNMxSZVJNnUql/OEV
         FUnipu+FqMqlcegUuFqX5dtuiEcb/8Pc2fUKacV3sJn/3TafJLMU0tcncqTUyGnsnrVr
         DstUEiquJsij0qA068JKlsvuL7Heol7GWZYJcUJVsKf5QwmkJUw0pCzvWR6AWO8ZXYJx
         W8Ow==
X-Gm-Message-State: AFqh2kqGSR7dbVavjLrWP9cB2nu1KNObps9hLdOe+syk85gtVA26ZJrw
        0hlgUK1oLyr75kiieZoEjePTWA==
X-Google-Smtp-Source: AMrXdXs/f/cqcVzu+3CGx54m9jP459zFofYksGpECKKnYTfedSdo9W0pKOM1c8Lw4Ke4C5BjkK6Zbw==
X-Received: by 2002:adf:d850:0:b0:273:7882:2c7a with SMTP id k16-20020adfd850000000b0027378822c7amr14770589wrl.62.1672238189044;
        Wed, 28 Dec 2022 06:36:29 -0800 (PST)
Received: from localhost (2a02-8388-6582-fe80-0000-0000-0000-0006.cable.dynamic.v6.surfer.at. [2a02:8388:6582:fe80::6])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600012c300b00236c1f2cecesm17860300wrx.81.2022.12.28.06.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 06:36:28 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 28 Dec 2022 15:36:27 +0100
Message-Id: <CPDIYQ3SSY3E.I0Y0NMIED0WO@otso>
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Johan Hovold" <johan@kernel.org>, "Vinod Koul" <vkoul@kernel.org>
Cc:     <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] phy: qcom-qmp-combo: Add config for SM6350
X-Mailer: aerc 0.13.0
References: <20221130081430.67831-1-luca.weiss@fairphone.com>
 <20221130081430.67831-2-luca.weiss@fairphone.com>
 <Y6xP4YRAp68TfxFi@hovoldconsulting.com>
In-Reply-To: <Y6xP4YRAp68TfxFi@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On Wed Dec 28, 2022 at 3:17 PM CET, Johan Hovold wrote:
> Luca, Vinod,
>
> On Wed, Nov 30, 2022 at 09:14:28AM +0100, Luca Weiss wrote:
> > Add the tables and config for the combo phy found on SM6350.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> > Changes since v2:
> > * Drop dp_txa/dp_txb changes, not required
> > * Fix dp_dp_phy offset
> >=20
> >  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 126 ++++++++++++++++++++++
> >  1 file changed, 126 insertions(+)
> >=20
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qu=
alcomm/phy-qcom-qmp-combo.c
> > index 77052c66cf70..6ac0c68269dc 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>
> > @@ -975,6 +1039,19 @@ static const char * const sc7180_usb3phy_reset_l[=
] =3D {
> >  	"phy",
> >  };
> > =20
> > +static const struct qmp_combo_offsets qmp_combo_offsets_v3 =3D {
> > +	.com		=3D 0x0000,
> > +	.txa		=3D 0x1200,
> > +	.rxa		=3D 0x1400,
> > +	.txb		=3D 0x1600,
> > +	.rxb		=3D 0x1800,
> > +	.usb3_serdes	=3D 0x1000,
> > +	.usb3_pcs_misc	=3D 0x1a00,
> > +	.usb3_pcs	=3D 0x1c00,
> > +	.dp_serdes	=3D 0x1000,
>
> I would have expected this to be 0x2000 as that's what the older
> platforms have been using for the dp serdes table so far. Without access
> to any documentation it's hard to tell whether everyone's just been
> cargo-culting all along or if there's actually something there at offset
> 0x2000.

From what I saw comparing downstream code vs mainline 0x1000 should be
correct.

From https://gerrit-public.fairphone.software/plugins/gitiles/kernel/msm-4.=
19/+/refs/heads/kernel/11/fp4/include/dt-bindings/phy/qcom,lagoon-qmp-usb3.=
h#38

USB3_DP_QSERDES_COM_BIAS_EN_CLKBUFLR_EN (downstream 0x1034) =3D
  QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN (mainline 0x034)

USB3_DP_QSERDES_COM_CP_CTRL_MODE0 (downstream 0x1060) =3D
  QSERDES_V3_COM_CP_CTRL_MODE0 (mainline 0x060)

These defines downstream are used in qcom,qmp-phy-init-seq
(lagoon-usb.dtsi) which super abbreviated gets used like this:

lagoon-usb.dtsi:
    reg =3D <0x88e8000 0x3000>;
    reg-names =3D "qmp_phy_base";
    qcom,qmp-phy-init-seq =3D <...>;

drivers/usb/phy/phy-msm-ssusb-qmp.c
    res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
                        "qmp_phy_base");
    phy->base =3D devm_ioremap_nocache(dev, res->start, resource_size(res))=
;

    of_property_read_u32_array(dev->of_node,
            "qcom,qmp-phy-init-seq",
            phy->qmp_phy_init_seq,
            phy->init_seq_len);

    reg =3D (struct qmp_reg_val *)phy->qmp_phy_init_seq;

    while (reg->offset !=3D -1) {
        writel_relaxed(reg->val, phy->base + reg->offset);

I don't see anywhere where an extra 0x1000 should come from. But perhaps
I'm missing something. The reg address is the same downstream and
mainline also.

>
> Vinod, could you shed some light on this as presumably you have access
> to some documentation?

That would be useful :)

Regards
Luca

>
> > +	.dp_dp_phy	=3D 0x2a00,
> > +};
>
> Johan

