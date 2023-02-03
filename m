Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2046896C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjBCKf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjBCKf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:35:56 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E62CA08
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:35:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gr7so14103991ejb.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 02:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OiFGc1hvU9VhxKMXFyUNXO2Gwzj0bxXzL9q4pdCqr5Y=;
        b=sazEFmGQ/yPDRcukt/2jabKqWss56+SM/dMS6noQWcmnCZuPntbr1osUd1DdPVtnp/
         PUJiddL9N4f8YKpiRH3pi/8nZnr9i0IHsD5cZ36XNJqkTA4q1YMstM6mFwGBk43z4Dkb
         pFDCQwed3o2L7ggIBc1u07Iqmrzbx8U7gZK2fWAQb9yn1QJt7s96BkNAMUgqba3Gzw+Q
         fC1koJ4PIAAPo28xfY8oX8O/8YGOBcWd67HvGqci/Y59xxcvZBRPYtP3eFvm6b4xb/E1
         FQgS1rma99kUn93ZXoKraHM2Ec0pbgcRxgo4we4XgCPP6T/4/TGF4fK2vV8YRFHlvSB4
         xGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiFGc1hvU9VhxKMXFyUNXO2Gwzj0bxXzL9q4pdCqr5Y=;
        b=pXAPur/kwxlTJzlXFN5bQEHd6YG/HJLUAokup973n9fHZrNoRRrfbQPYx3hClXBVjm
         mLpBNDyEkTQqwL6qvUWzoSY1Hd7vqEG/+LP3iE4lnsKhYLoOL7ZTdsp6A+zHD/MKEhRa
         Jh5WdcDNLEOxpCjGW4OD4L4tXwQEPdZQUfJr1QQedOVS0tIIZKhmHmdAoMJgpRF8SB6n
         imZEwudCEp4xOCTaDP78k7yrO8VO0INg+47gDkqWdyHDRa9O1g44dUdlgRsirbhQDawf
         3dVaj6bTp88KSpcFMf3QPux0mFrMI5dTXoP5Kb/4Ocy50tvoDkHRAkEzpqwXrG6A6zZe
         K9iQ==
X-Gm-Message-State: AO0yUKUBIAYoHQ3XiGdr+SndjhHo5KP5wf4uSKkSjBQr4YVpm+1XjuxH
        Skmi6zUxb77tER5CHi19NEI+GqQudxMbnja+wnvnWYO8YOxgrMuZnv4=
X-Google-Smtp-Source: AK7set+HyDtAPr7xlvnHLTiVM3CyrgRd1MsKwlB5flwTkTAH2vWTXjkIbfN7erg4r2gqmRDekX4I6TLcEM6jA/K6Hyg=
X-Received: by 2002:a17:906:1803:b0:7c0:f45e:22ff with SMTP id
 v3-20020a170906180300b007c0f45e22ffmr3313742eje.104.1675420551371; Fri, 03
 Feb 2023 02:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20230124131717.128660-5-bchihi@baylibre.com> <20230131153816.21709-1-bchihi@baylibre.com>
 <ab1e4822-d5f4-79f6-ea38-47e2342ebe49@linaro.org> <CAGuA+oqLiCxb1g7pwf+RwUTWHV37pXdAWUXHV51TnUy1-xUOXQ@mail.gmail.com>
 <68466850-ddb0-119a-ea82-636ec2c5368e@gmail.com>
In-Reply-To: <68466850-ddb0-119a-ea82-636ec2c5368e@gmail.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 3 Feb 2023 11:35:15 +0100
Message-ID: <CAGuA+oq1jZvDUK01rX-jJH7-5waWA4JnytoBmCeD7+SbndPgrw@mail.gmail.com>
Subject: Re: [PATCH v12] thermal: drivers: mediatek: Add the Low Voltage
 Thermal Sensor driver
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Wed, Feb 1, 2023 at 5:59 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 01/02/2023 17:46, Balsam CHIHI wrote:
> > Hi Krzysztof,
> >
> > Thank you very much for the review!
> >
> > On Wed, Feb 1, 2023 at 8:55 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 31/01/2023 16:38, bchihi@baylibre.com wrote:
> >>> From: Balsam CHIHI <bchihi@baylibre.com>
> >>>
>
> [...]
>
> >>> +
> >>> +static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
> >>> +{
> >>> +     irqreturn_t iret = IRQ_NONE;
> >>> +     u32 value, masks[] = {
> >>
> >> Don't mix different types in one declaration. u32 and a pointer are
> >> quite different types.
> >
> > I'm not sure to understand.
> > LVTS_INT_SENSORx are not pointers but register values.
> >
>
> u32 mask[] is a pointer to a array of u32 values of undefined length.
>

I will change this to :
u32 value;
u32 masks[] = {

> [...]
>
> >>> +static int __init lvts_golden_temp_init(struct device *dev, u32 *value)
> >>
> >> You did not test it, right? Build with section mismatch analysis...
> >
> > I'm not sure to fully understand this comment.
> > Would you explain, please?
> >
>
> AFAIU:
>
> lvts_golden_temp_init() and lvts_ctrl_init() are called from a function that is
> not in __init section:
> lvts_domain_init()
>
> So if you free up the first to functions after init but not the callers, things
> can explote.
>

__init will be removed for all functions.

> [...]
>
> >>> +
> >>> +static int lvts_probe(struct platform_device *pdev)
> >>> +{
> >>> +     struct lvts_data *lvts_data;
> >>> +     struct lvts_domain *lvts_td;
> >>> +     struct device *dev = &pdev->dev;
> >>> +     struct resource *res;
> >>> +     int irq, ret;
> >>> +
> >>> +     lvts_td = devm_kzalloc(dev, sizeof(*lvts_td), GFP_KERNEL);
> >>> +     if (!lvts_td)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     lvts_data = (struct lvts_data *)of_device_get_match_data(dev);
> >>
> >> Why do you need case?
> >
> > Would you explain, please?
> >
>
> Typo by Krysztof, he meant the cast.
> lvts_data = of_device_get_match_data(dev);
> should be good enough.
>

OK,
It will be like you suggested.

> Regards,
> Matthias

Thank you for the review!

Best regards,
Balsam
