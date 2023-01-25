Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE03E67B562
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbjAYPE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbjAYPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:04:51 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE01CA07
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:04:46 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m12so1911232edq.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/fOhzJHWBncviO+8KoSq7wlf7hb65a2LJ3emY6Ltu3A=;
        b=RVjF1zmunimG3lGTLeRCa8b+VtklkxoxzStUIe2vmyUTWVEc7EIXViDfw7k1eDudJw
         /dLoWJSpc/ExMmL06qpgakuBOn3fPUVDaBB0AGXUo/CuEo6UHTtRpEbq3y2wzl7MskF1
         EWI1SUwbzXkJikMRMYJVXxVW2Sk+9CwtBxO4rKHXfyWBlMlMqEVApPA9/hq+Nk8JkdnN
         Tiun2oEuHvV33eE+mT364rnnh5nXyholp2+miDbgAwNNOobmThZ+9WPQK0iJDy5HY7y8
         JoFfEK+SXk08N8cjSfXThiqPbSJ9ET65nNrJFoN+EEfyQ4eKH1WA5hsQB7ed3w/1vmGU
         ANrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fOhzJHWBncviO+8KoSq7wlf7hb65a2LJ3emY6Ltu3A=;
        b=24/CDFsRcrRDd2w37dgcHZxWLiBJ5XJ8D3C/aSgGq44YWKld0RkYgkLDnaVQDL3QaO
         O5Tv2NfRTSu6wlYcLVnnv70VNu+U75teHeEy36gfXbSm54GkeC7ylBz+BnH3Rb88gpvw
         spyH22CGFQ55/n9qflf7o7tQLvRW43pTuLfNvaT954Pj5XzmHL/HMtFzmJ0U4Go1NIeA
         OKJsHbtOhA/zv/DCSOjQTmddcbFEPubezXdzzkiaQhH39zL7XNjbzpZfZW9z28f1G0q2
         kYn2eGM+1VVD0m4tEA/rewafyCHH621MvICFIwVrKAA9zaQfTpXxfRPlK3Ul0w7VIdE6
         kNkA==
X-Gm-Message-State: AFqh2krBFCVlaIOufa2VGssreSOjDIRaKoRAiwMx7AV8YateulA0fkNA
        yH5MNnfyw1KPYGp/KGykxZ6tFlfXoRCmGwlYNZXwPg==
X-Google-Smtp-Source: AMrXdXu5EH+oSnT7I6l+aObYabUX53IzIx9ef5qbltDC8gHjErcHTUvXLVXPfiCcSe5HfprVu58Q58jz3XZRuEbvKxM=
X-Received: by 2002:aa7:c548:0:b0:499:b60f:5741 with SMTP id
 s8-20020aa7c548000000b00499b60f5741mr4178484edr.80.1674659084907; Wed, 25 Jan
 2023 07:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20230124131717.128660-1-bchihi@baylibre.com> <20230124131717.128660-4-bchihi@baylibre.com>
 <104bb37e-55c3-8dd0-f501-0e8a142511e6@gmail.com>
In-Reply-To: <104bb37e-55c3-8dd0-f501-0e8a142511e6@gmail.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 25 Jan 2023 16:04:08 +0100
Message-ID: <CAGuA+ooVx2ODdXjuy2udO6F4V5fUy6EjeUaJPOvnjAE39QH3RA@mail.gmail.com>
Subject: Re: [PATCH v11 3/6] arm64/dts/mt8195: Add efuse node to mt8195
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 3:25 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 24/01/2023 14:17, bchihi@baylibre.com wrote:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > Add efuse node.
> > This will be required by the thermal driver to get the calibration data.
> >
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
> I fixed the subject prefix to:
> arm64: dts: mt8195: ...
> to be in line with other commits.
> Please take that into account for future patches you send.
>
> Applied thanks!
>

Hi Matthias,

Thank you for the fix and for applying the patch!

Best regards,
Balsam

> > ---
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index 5d31536f4c48..09df105f4606 100644
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
