Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405B668977B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjBCLHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjBCLHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:07:12 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A364372669
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:07:09 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qw12so14371995ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 03:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkQ8Gz4j/geHcEad/4Eauy1yNTF7OO2D+brLgcLvLOo=;
        b=bIa1jBCPI5MWhjL0rRPnJN7kCSzLkePkj2byuaF4LkJSK7i059EOqSRIKaq/egcsWn
         q7lDpxltYyEJ74vGv0hGLN3Mg/jAAfy2proI4RMVLagxNlKuqpkj26dHM8iOgxZDbDKZ
         9iXmSEeCVr+rLCabe1LR84R4byjKOVC0MXMoZRMuzNkQUH7m8xXQ4LKu78bPKCukoPa0
         9QIHhRDXiLWV+SB9rLuZCnQauR9A2It/1tHpHiye0ctyhbEFXjMviq1IduUueMEHtflS
         gUHGiuEFmraZiPPCb5NdjqVDwaAS0NodsgJdjEVK9e3XvireT7bB9yUdonxAfvBUmboS
         bBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkQ8Gz4j/geHcEad/4Eauy1yNTF7OO2D+brLgcLvLOo=;
        b=sDbCVGDmiWPOwjF5e3Lt9lqi+RlbsB7AsDpcH6I64hTvzAvr2J9hCiMdx7ORmHm8sS
         flhHJ9EIGI3VvbfGloGZEJr7kyDkl1JzdKEVE2vidz1WwtYr4Mt0RB8LOmPKqx3chxif
         S5rY5LD7ZcWaSghhPBaI8TNXUwJ9BQ5fxs+DRlT/oqjWdVr3JQhSfcmoDl0vLi6dVlgn
         GKGbBZPLq+sq0ELO9UbeLVQvIjj3pQiLw9quzR7ltyzG4CIylvZ7noJdpujPZWiUofgw
         LXDEm+8SI7vFX/7vxgVuUxqTx799HrjO3rlew76a+4/42In88BU1QLaWccE1Lzy+zJtS
         nO0w==
X-Gm-Message-State: AO0yUKWFqvlCKUFeUo0UDFnDrwZsC/9hq78kFNJsyHykEZBSVxUJcyIC
        gXVcTf8SYGjHmhQQm8L9T//F60C+odu47+/zCVodCg==
X-Google-Smtp-Source: AK7set9W9wLn3JZ8MrFzo0VuFe/HAuvajC0zCNwULGTi/uQ9VI1ybXodYpHBrfydldHh9/xqXzDFQFITEAIkXYRU2Zo=
X-Received: by 2002:a17:906:1803:b0:7c0:f45e:22ff with SMTP id
 v3-20020a170906180300b007c0f45e22ffmr3345979eje.104.1675422428182; Fri, 03
 Feb 2023 03:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20230124131717.128660-5-bchihi@baylibre.com> <20230131153816.21709-1-bchihi@baylibre.com>
 <ab1e4822-d5f4-79f6-ea38-47e2342ebe49@linaro.org> <CAGuA+oqLiCxb1g7pwf+RwUTWHV37pXdAWUXHV51TnUy1-xUOXQ@mail.gmail.com>
 <8662c6bd-b32d-3d3d-b3b7-7f4aeb028309@linaro.org>
In-Reply-To: <8662c6bd-b32d-3d3d-b3b7-7f4aeb028309@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 3 Feb 2023 12:06:32 +0100
Message-ID: <CAGuA+or+rKzZaVO--yhBuOnUrL1+LhJAwxLsNcTif4t9W0TFWA@mail.gmail.com>
Subject: Re: [PATCH v12] thermal: drivers: mediatek: Add the Low Voltage
 Thermal Sensor driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Feb 1, 2023 at 6:12 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 01/02/2023 17:46, Balsam CHIHI wrote:
> >>> +#ifdef CONFIG_MTK_LVTS_THERMAL_DEBUGFS
> >>> +
> >>> +static struct dentry *root;
> >>
> >> How do you handle two instances of driver?
> >
> > This root node is the topmost directory for debugfs called 'lvts', the
> > different driver instances are below this. It is a singleton.
>
> Indeed. What about removal? Aren't you remobing entire directory
> structure on first device removal?
>

For now, the driver only supports one instance.
I will find a way to handle this when the driver supports more instances.
Is this suggestion OK for you?

> (...)
>
> >>> +
> >>> +     of_property_for_each_string(np, "nvmem-cell-names", prop, cell_=
name) {
> >>> +             size_t len;
> >>> +             u8 *efuse;
> >>> +
> >>> +             cell =3D of_nvmem_cell_get(np, cell_name);
> >>> +             if (IS_ERR(cell)) {
> >>> +                     dev_dbg(dev, "Failed to get cell '%s'\n", cell_=
name);
> >>
> >> Is this an error? If so, why debug? dbg is not for errors.
> >
> > AFAIK using dev_dbg does not increase ELF size when DEBUG is disabled.
> > If this is not a good reason for you, then I will change it to dev_err.
>
> But also dev_dbg are not visible in error or warn level logs. If this is
> not an error, then indeed dev_dbg could be fine. But errors should be
> verbose.

OK,
I will replace all "dev_dbg" with "dev_err" in this function.

>
> >
> >>
> >>> +                     return PTR_ERR(cell);
> >>> +             }
> >>> +
> >>> +             efuse =3D nvmem_cell_read(cell, &len);
> >>> +
> >>> +             nvmem_cell_put(cell);
> >>> +
> >>> +             if (IS_ERR(efuse)) {
> >>> +                     dev_dbg(dev, "Failed to read cell '%s'\n", cell=
_name);
> >>> +                     return PTR_ERR(efuse);
> >>> +             }
> >>> +
> >>> +             lvts_td->calib =3D devm_krealloc(dev, lvts_td->calib,
> >>> +                                            lvts_td->calib_len + len=
, GFP_KERNEL);
> >>> +             if (!lvts_td->calib)
> >>> +                     return -ENOMEM;
> >>> +
> >>> +             memcpy(lvts_td->calib + lvts_td->calib_len, efuse, len)=
;
> >>> +
> >>> +             lvts_td->calib_len +=3D len;
> >>> +
> >>> +             kfree(efuse);
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int __init lvts_golden_temp_init(struct device *dev, u32 *val=
ue)
> >>
> >> You did not test it, right? Build with section mismatch analysis...
> >
> > I'm not sure to fully understand this comment.
> > Would you explain, please?
>
> git grep -i "section mismatch" leads to lib/Kconfig.debug and
> DEBUG_SECTION_MISMATCH

__init is removed from all functions.

>
> (...)
>
> >>> +static struct lvts_ctrl_data mt8195_lvts_data_ctrl[] =3D {
> >>
> >> Why this cannot be const?
> >
> > I've got the following warning when I added "const"
> > drivers/thermal/mediatek/lvts_thermal.c:1286:27: warning:
> > initialization discards =E2=80=98const=E2=80=99 qualifier from pointer =
target type
> > [-Wdiscarded-qualifiers]
> >  1286 |         .lvts_ctrl      =3D mt8195_lvts_data_ctrl,
> >       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> As with every const... Do you need lvts_ctrl to be non-const? If yes,
> then how do you handle multiple devices (singleton)?
>

I found a fix for this it was simple.
add const here as you suggested
and in other function parameters every time we use this variable.

> Best regards,
> Krzysztof
>

Thank you for the review!

Best regards,
Balsam
