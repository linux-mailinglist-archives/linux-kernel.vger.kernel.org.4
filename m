Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A7363EC09
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiLAJK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiLAJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:10:54 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CDF63D69
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:10:54 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id g137so527880vke.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RmeWn94LkVUu4tw9eu7qIjwdQxs9X/lPN1HtD4czkz8=;
        b=iaV00wCJ4DS7weiRp4Yw4j61ZEqhjOgAl+mihdJ4qF0iIOYQ+CuCNiLXc0RcF57ZOI
         QcBE7TAFYM0edIfMCDMuUT6bZ6lQXNfia/NTQqZ5iluHTzPjkBnEOH8gb9DvPfgtJbCT
         wjUAgszWR72pzNXurHZMegxe8l2Iy8dNhmDwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmeWn94LkVUu4tw9eu7qIjwdQxs9X/lPN1HtD4czkz8=;
        b=47eZRyinwHV8ykjk25t5AAlX/waTAmaFNd9bwFmHfLcCBcs0YBXCqmXPWC08rb561G
         2w1lGBe2ddLGIZnDzPX22RfGZf0pPhmzv906ZdZ4A5pysDkaXtbkeG7+5ba+D1pzZoG6
         cgY254riFZ6T/ZwbjT60jT+Jc91JYB/nYKigXoNZC6IroqGvRJrfcAomEhhXJyKW1Ze1
         1MrEb5MdfNxcBboXY+L/UVoNI3+DY1lSRKT+XqReDi0+6mmNCMNEure3qmR4z8ULYk6e
         5QVoIHXEKOfqc9mzmZD/ZGH1BpB0oPaQtl70SYv/qRxSCbL0YS7wjad9mFUmmUA+HP0k
         E+yQ==
X-Gm-Message-State: ANoB5pnua6hnT4Sfo8rqJC+Bs1KAhyDlJjqzu6Fmy8JJljUGHN1nSiZc
        YM52thwvTIjQ9tqToMffQiJATpc0uZkcELGnb7boyQ1llA4=
X-Google-Smtp-Source: AA0mqf4awAdlAk/sq5NWU1xv87d2t6gi6AnY8KPsEvf+7K1uvG1yrMV65xrzMZ9nwdUuppcvpNW9DAzRfyInxSaUOqY=
X-Received: by 2002:a1f:a00e:0:b0:380:5dbd:1076 with SMTP id
 j14-20020a1fa00e000000b003805dbd1076mr28138415vke.22.1669885853192; Thu, 01
 Dec 2022 01:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20221201073328.1559-1-allen-kh.cheng@mediatek.com> <ba14a46f-477f-70af-761d-696fe8a4f41c@collabora.com>
In-Reply-To: <ba14a46f-477f-70af-761d-696fe8a4f41c@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 1 Dec 2022 17:10:41 +0800
Message-ID: <CAGXv+5Gg6ozYQcp_NPrAiH1kF-ZkfjVZhQZVhLnbSmjQBwsFwQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8192: Add adsp power domain controller
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 5:07 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 01/12/22 08:33, Allen-KH Cheng ha scritto:
> > Add adsp power domain controller node for mt8192 SoC.
> >
> > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > ---
> > Ref: https://lore.kernel.org/all/2ec80bd8-dfef-d2e6-eb41-6e6088043e33@collabora.com/
> >      [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
> > ---
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 8 ++++++++
> >   include/dt-bindings/power/mt8192-power.h | 1 +
> >   2 files changed, 9 insertions(+)
> >
>
> Allen, thanks for this one, but it's incomplete...
>
> First of all, you must add the power domain on the driver itself, specifically,
> in drivers/soc/mediatek/mt8192-pm-domains.h - otherwise this change will have no
> effect!

Actually it's worse. The driver doesn't know about the new power domain,
and so it will fail to probe. We might need to make the power domain driver
fail gracefully and skip unknown power domains.

ChenYu

> ...Then, as Chen-Yu said, you should also add the power domain to the scp_adsp
> clock node as that's solving the lockup issue...
>
> .......and last, but not least: we need a Fixes tag to backport this fix, here
> and on the commit that adds the missing power domain in the driver.
>
> Thanks,
> Angelo
>
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > index 424fc89cc6f7..e71afba871fc 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > @@ -514,6 +514,14 @@
> >                                               };
> >                                       };
> >                               };
> > +
> > +                             power-domain@MT8192_POWER_DOMAIN_ADSP {
> > +                                     reg = <MT8192_POWER_DOMAIN_ADSP>;
> > +                                     clocks = <&topckgen CLK_TOP_ADSP_SEL>;
> > +                                     clock-names = "adsp";
> > +                                     mediatek,infracfg = <&infracfg>;
> > +                                     #power-domain-cells = <0>;
> > +                             };
> >                       };
> >               };
> >
> > diff --git a/include/dt-bindings/power/mt8192-power.h b/include/dt-bindings/power/mt8192-power.h
> > index 4eaa53d7270a..63e81cd0d06d 100644
> > --- a/include/dt-bindings/power/mt8192-power.h
> > +++ b/include/dt-bindings/power/mt8192-power.h
> > @@ -28,5 +28,6 @@
> >   #define MT8192_POWER_DOMAIN_CAM_RAWA        18
> >   #define MT8192_POWER_DOMAIN_CAM_RAWB        19
> >   #define MT8192_POWER_DOMAIN_CAM_RAWC        20
> > +#define MT8192_POWER_DOMAIN_ADSP     21
> >
> >   #endif /* _DT_BINDINGS_POWER_MT8192_POWER_H */
> >
>
