Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2896B34B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCJDVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCJDVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:21:07 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4AB103BE2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 19:21:05 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id s1so3537925vsk.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 19:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678418465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbTDjvc5ieqfrIhKoRc6A4Iamnhwe4zfbF/KdHYvMbM=;
        b=ePB0Z4h/EVZe6K5HjRzYtbfXmGb1TicluV0XhOHpbVkr/KNK62T6oukk0GlEiwZa3n
         mzt/b6VrT0J9pDhKgzgTuLe8B/ow3gEPUmo+4uQBs/CmbCWkkSKxeB+yMDA6hHHqfunD
         gHJQ/rJEcbNFBbLF8zOtsNxZFidTempbV9t34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678418465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbTDjvc5ieqfrIhKoRc6A4Iamnhwe4zfbF/KdHYvMbM=;
        b=gKOTKgrSHiE8E2wdCQZKyIcHRuO8ZVxcDLaU/0mBVJOkJZZHLrv85TpdiHo87EYeol
         pUGwCK2qiqiKHspATkE3iA2OaU9coQnKiBIT2QVCk15kx/gK3nl8q16pi60KF1rNfNkb
         iddbQofIDzSFNfdvLn/UlQNPr1G3SBlUqx2ph6Z9zf6jB5YwgSQBM0mf7ery2BFOnrFE
         QZX1fJiRGZoFiEckZ2Rzl+pZkPMX6lE7m1ddBM8lxJ541rnDSbBwYAmurWKjHwiAJqmj
         TvSM3Huxoi1ViXnQvbJ3H+fD/nPqfCla//xOyuKMrAjIJ6Wf/bITqUxqYmeXOEvmu+xR
         qcQw==
X-Gm-Message-State: AO0yUKUvDL7Xn2RGA+xR9KTk22KaicfLje5lBf2/o9AieqS1V1MSynKM
        yChdxTpYRuwBgHseX7drwEpC+87Wr5hh7WnqbDtw5w==
X-Google-Smtp-Source: AK7set+si04/1KeeWL6kRQ5LkOK77tstrb85bSbjd1w4JQ4/NvTHJ5iJ4Kv4gkWbOuFVDQCpn5vP7kaNIm7RZOiAPQ8=
X-Received: by 2002:a05:6102:3192:b0:421:c926:4b6d with SMTP id
 c18-20020a056102319200b00421c9264b6dmr361086vsh.0.1678418464888; Thu, 09 Mar
 2023 19:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20230307154524.118541-1-bchihi@baylibre.com> <20230307154524.118541-2-bchihi@baylibre.com>
 <CAGXv+5FUrWEF4SZ6DKjoF8Oai--JGFffzQ3_DyzQrUrThVEQ7Q@mail.gmail.com> <e5959cb5-af8c-9410-9530-b3e19e9b647a@linaro.org>
In-Reply-To: <e5959cb5-af8c-9410-9530-b3e19e9b647a@linaro.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 10 Mar 2023 11:20:53 +0800
Message-ID: <CAGXv+5EhTi5t1yqDP8BqdCzWzNFSYu4n39kBi0YhEvJQPu7bLg@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: thermal: mediatek: Add AP domain to LVTS
 thermal controllers for mt8195
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     bchihi@baylibre.com, angelogioacchino.delregno@collabora.com,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 6:39=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 09/03/2023 05:40, Chen-Yu Tsai wrote:
> > On Wed, Mar 8, 2023 at 12:46=E2=80=AFAM <bchihi@baylibre.com> wrote:
> >>
> >> From: Balsam CHIHI <bchihi@baylibre.com>
> >>
> >> Add AP Domain to LVTS thermal controllers dt-binding definition for mt=
8195.
> >>
> >> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> >> ---
> >>   include/dt-bindings/thermal/mediatek,lvts-thermal.h | 10 ++++++++++
> >>   1 file changed, 10 insertions(+)
> >>
> >> diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/inc=
lude/dt-bindings/thermal/mediatek,lvts-thermal.h
> >> index c09398920468..8fa5a46675c4 100644
> >> --- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> >> +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> >> @@ -16,4 +16,14 @@
> >>   #define MT8195_MCU_LITTLE_CPU2  6
> >>   #define MT8195_MCU_LITTLE_CPU3  7
> >>
> >> +#define MT8195_AP_VPU0  8
> >
> > Can't this start from 0? This is a different hardware block. The index
> > namespace is separate. Same question for MT8192.
>
> The ID is used to differentiate the thermal zone identifier in the
> device tree from the driver.
>
> +               vpu0-thermal {
> +                       polling-delay =3D <0>;
> +                       polling-delay-passive =3D <0>;
> +                       thermal-sensors =3D <&lvts_ap MT8195_AP_VPU0>;
> +
> +                       trips {
> +                               vpu0_crit: trip-crit {
> +                                       temperature =3D <100000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
>
> If MT8195_AP_VPU0 is 0, then the code won't be able to differentiate
> MT8195_AP_VPU0 and MT8195_MCU_BIG_CPU0
>
> The LVTS driver will call devm_thermal_of_zone_register() with the
> sensor id. If MT8195_MCU_BIG_CPU0 and MT8195_AP_VPU0 have the same id,
> then at the moment of registering the MT8195_AP_VPU0, the underlying OF
> thermal framework code will use MT8195_MCU_BIG_CPU0 description instead
> because it will be the first to be find in the DT.
>
> If MT8195_AP_VPU0 is described in DT before, then the same will happen
> when registering MT8195_MCU_BIG_CPU0, MT8195_AP_VPU0 will be registered
> instead.
>
> IOW all ids must be different.

I see. I didn't realize the lookup namespace covered the whole platform.
In that case, please ignore my request.

ChenYu

> The namespace is already described by the macro name AFAICS, so whatever
> the values, we see only the macro names and those IDs are private the
> kernel implementation.
>
> If the numbering is really important, may be something like:
>
> #define MT8195_MCU_BIG_CPU0     00
> #define MT8195_MCU_BIG_CPU1     01
> #define MT8195_MCU_BIG_CPU2     02
> #define MT8195_MCU_BIG_CPU3     03
> #define MT8195_MCU_LITTLE_CPU0  04
> #define MT8195_MCU_LITTLE_CPU1  05
> #define MT8195_MCU_LITTLE_CPU2  06
> #define MT8195_MCU_LITTLE_CPU3  07
>
> #define MT8195_AP_VPU1  10
> #define MT8195_AP_GPU0  11
> #define MT8195_AP_GPU1  12
> #define MT8195_AP_VDEC  13
> #define MT8195_AP_IMG   14
> #define MT8195_AP_INFRA 15
> #define MT8195_AP_CAM0  16
> #define MT8195_AP_CAM1  17
>
> But I would suggest considering this change as a separate patch after
> the AP domain is added.
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
