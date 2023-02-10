Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17469691AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjBJJKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjBJJJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:09:41 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A4911EB9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:09:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id lu11so14049881ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y4xwd6NcIcu0eUIOaah2w2G0LfRuN+4uyTHcTQv42t8=;
        b=G/oOrzUe4Fwnevaf9IKo7y2rWgZnBkev6GGDd04NqukMlLhyVxAq0sWcWNMSrhEABU
         Z45y4y0xSXD/D1xFJOY0pu6Fvz1BMfIm71ounhleMUlkgyywu34KgnP4szxktFxxqPXt
         CIR1ySQ75eCJWqDs4fZScqltXCl7CXLtaQpaW0s1PxqD8CpLD0HOHeOojpcUKFRGzcKv
         Hw8aado1wmO4/gVIeWU+xfDj/368hQLSSQlS3SxEBPOD1NCXU7WBnFHT8Ect8OnZzk45
         RylAQAwchAgo5kicrsvcuaPowfOPl8p4Vf9fXCapvRYbwUUhcOMxijGW3jZGRHxSmMu+
         LKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4xwd6NcIcu0eUIOaah2w2G0LfRuN+4uyTHcTQv42t8=;
        b=gEuMwVs+P7o8xyElFZClTrYtVllS7pE2j+TRw6SLIzKJ5j9Trc6fJGXfhPHeK9fnd/
         77JXn3sxIt9ozcBHo9eWXBelGwXmMKM+j61M6+24S0M+tokvKJYB8EbHgGxU0uAr//pF
         KQc8Ts/fN5Q/G1C8oeCKoBr2Ni45EIamRBNHxbXZhwFRZzwJZ/hU92Z/fm7I72LvOBPV
         iy0CHhfD6zx5Y1pVZOMw/CkEjHiQAmA9Uti5AU1lLI6uzvh46h4Svwnw48bgo9PUgqAk
         x1pdtbpzsQf4V3uI0NU3jenIGWm4r+sUVVH+mcDdwbdqJl7Itj+eqUw3027PUz2roBbL
         BmmQ==
X-Gm-Message-State: AO0yUKUndnMiTW/IZjQLnpkjIbE++8z5geeDTIKChUnydRljBOT6pt79
        0gT9j6tuylNh2SqTPDmb3hfZXrzos1RXXSZlqcdEBw==
X-Google-Smtp-Source: AK7set9L922uBh+HaAt7lGdopHMTeCAl+xxeBTKnBZJVjI/dV3z8/lG/hi73l7PrChoojEnABiShvoTnY6vdPX01M8U=
X-Received: by 2002:a17:906:ca04:b0:7c0:f45e:22ff with SMTP id
 jt4-20020a170906ca0400b007c0f45e22ffmr3464668ejb.104.1676020156421; Fri, 10
 Feb 2023 01:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20230209105628.50294-1-bchihi@baylibre.com> <20230209105628.50294-4-bchihi@baylibre.com>
 <29a867d1-12a7-449f-8d52-aaac7a622c59@gmail.com>
In-Reply-To: <29a867d1-12a7-449f-8d52-aaac7a622c59@gmail.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 10 Feb 2023 10:08:40 +0100
Message-ID: <CAGuA+oqXmSDbNO1NWDHZ8-KGhF3mwzqwY6wWx2zUhwL7yfynQA@mail.gmail.com>
Subject: Re: [PATCH v14 3/6] arm64: dts: mt8195: Add efuse node to mt8195
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Thu, Feb 9, 2023 at 5:28 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 09/02/2023 11:56, bchihi@baylibre.com wrote:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > Add efuse node.
> > This will be required by the thermal driver to get the calibration data.
> >
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Link: https://lore.kernel.org/r/20230124131717.128660-4-bchihi@baylibre.com
> > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> This patch is already accepted [1], please drop it from your list.

Yes sure. I will.
Thank you.

>
> Regards,
> Matthias
>
> [1] https://lore.kernel.org/lkml/104bb37e-55c3-8dd0-f501-0e8a142511e6@gmail.com/
>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index 5d31536f4c486..09df105f4606d 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -1380,6 +1380,12 @@ pciephy_glb_intr: pciephy-glb-intr@193 {
> >                       dp_calibration: dp-data@1ac {
> >                               reg = <0x1ac 0x10>;
> >                       };
> > +                     lvts_efuse_data1: lvts1-calib@1bc {
> > +                             reg = <0x1bc 0x14>;
> > +                     };
> > +                     lvts_efuse_data2: lvts2-calib@1d0 {
> > +                             reg = <0x1d0 0x38>;
> > +                     };
> >               };
> >
> >               u3phy2: t-phy@11c40000 {

Best regards,
Balsam
