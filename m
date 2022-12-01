Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5BF63ED2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiLAKF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiLAKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:05:53 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A54326F9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:05:51 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id g137so585196vke.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XrM8HiqXnZzTUWvDOAD7xr6db8l4mNmr+646ESgVc/Q=;
        b=cJbZWSetyvmZNNWfKs/XjqCxg926Jsjxx8jgSzxrFnHfI9lA7CTAQmRtPIFXhfNX8k
         tPeidGD0TdPRJA0MAxXbWI1LLJ6kadkbOW8vukkZjIKO9kmuJglBgh1/d3QABwZtbP66
         JzLAAQPysycvtiJyWjdqKtej8VBeKHxyXOWHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrM8HiqXnZzTUWvDOAD7xr6db8l4mNmr+646ESgVc/Q=;
        b=m6ygM6iPMRp0kEp4ODYv7gpOV4KKzQch8TO2rn+ll0rfUCg1N0n1GMsuh1ed0OwWGr
         A/Hyl1Wfpvjk5JARiG7unm1umns5yzi113UGd8ON/q7M3kCdw0Nm+AMUe9gvw4y/Hufy
         jJj+nDiy/K6tHkeF316RbBONFLI0HpgybEroBQKKDhLLSRo0RrsGk38pCmb1h/tEKem4
         pnNF1hcXy7E3vuynwGO877W7r6teLzX5y2IlmsrxswtxOTp1YbgTO8b3HpSM6XW+BtQe
         U3CbN+SVijc+ue1PeUl0AN0RM1BbY/NWUovW12SA/a1Y5H/K+4///K85m3UzsD4Ob93e
         DEUg==
X-Gm-Message-State: ANoB5plwUXVxrECUVc7rPWbXWm260Whu43WvmtR/X6FlTnX/ycF/sLQs
        IH9t4M46RnThH8aqFns83zT6huWQwmRtEOfMx8wZOw==
X-Google-Smtp-Source: AA0mqf6wG7AHF7XHQDT3r9jZs+UyadRR5/kyoPUrjBZc8SEmqo1csGnX4esmgX79FQS+PCnjOUsVyvbK5w5//Z/TLs8=
X-Received: by 2002:a1f:9f0f:0:b0:3b6:90df:eb0 with SMTP id
 i15-20020a1f9f0f000000b003b690df0eb0mr37365702vke.30.1669889150895; Thu, 01
 Dec 2022 02:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20221201073328.1559-1-allen-kh.cheng@mediatek.com>
 <ba14a46f-477f-70af-761d-696fe8a4f41c@collabora.com> <CAGXv+5Gg6ozYQcp_NPrAiH1kF-ZkfjVZhQZVhLnbSmjQBwsFwQ@mail.gmail.com>
 <8ae2a510-abf6-6e1b-9893-293db7d930e7@collabora.com>
In-Reply-To: <8ae2a510-abf6-6e1b-9893-293db7d930e7@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 1 Dec 2022 18:05:39 +0800
Message-ID: <CAGXv+5H+msQ1ct5CUzYnT_BmYPnS72HbivvyO39uOfMfXbo5qg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 5:39 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 01/12/22 10:10, Chen-Yu Tsai ha scritto:
> > On Thu, Dec 1, 2022 at 5:07 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 01/12/22 08:33, Allen-KH Cheng ha scritto:
> >>> Add adsp power domain controller node for mt8192 SoC.
> >>>
> >>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> >>> ---
> >>> Ref: https://lore.kernel.org/all/2ec80bd8-dfef-d2e6-eb41-6e6088043e33@collabora.com/
> >>>       [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
> >>> ---
> >>> ---
> >>>    arch/arm64/boot/dts/mediatek/mt8192.dtsi | 8 ++++++++
> >>>    include/dt-bindings/power/mt8192-power.h | 1 +
> >>>    2 files changed, 9 insertions(+)
> >>>
> >>
> >> Allen, thanks for this one, but it's incomplete...
> >>
> >> First of all, you must add the power domain on the driver itself, specifically,
> >> in drivers/soc/mediatek/mt8192-pm-domains.h - otherwise this change will have no
> >> effect!
> >
> > Actually it's worse. The driver doesn't know about the new power domain,
> > and so it will fail to probe. We might need to make the power domain driver
> > fail gracefully and skip unknown power domains.
> >
>
> Right. It's worse. I don't know, though, if gracefully skipping unknown power
> domains in the driver would be a good decision... as sometimes error messages
> go unnoticed.
>
> When the platform "explodes" instead, you're forced to read that log carefully
> and get it working again... Anyway, I'm only thinking out loud, nothing less and
> nothing more than that :-)

Me too. :)

> By the way, we can probably expand on that topic a bit later, as it's outside of
> the scope of this specific change.
>
> Back to topic, if we get one series containing both changes (devicetree, bindings
> and driver) with the right Fixes tags and/or Cc stable, we shouldn't have such
> issue on backports so we can probably ignore that potential issue, I think? :-)

Everything goes through the soc tree, so they should appear in Linus's tree
and get picked by stable at more or less the same time. I think we would
want the driver change to appear before the dts change, for bisectability's
sake (because of header dependencies and driver errors).

So we probably want:
1. driver + binding header changes
2. dtsi changes

And have these merged through fixes so that the history between them is linear.


ChenYu

> Cheers,
> Angelo
>
> > ChenYu
> >
> >> ...Then, as Chen-Yu said, you should also add the power domain to the scp_adsp
> >> clock node as that's solving the lockup issue...
> >>
> >> .......and last, but not least: we need a Fixes tag to backport this fix, here
> >> and on the commit that adds the missing power domain in the driver.
> >>
> >> Thanks,
> >> Angelo
> >>
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> >>> index 424fc89cc6f7..e71afba871fc 100644
> >>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> >>> @@ -514,6 +514,14 @@
> >>>                                                };
> >>>                                        };
> >>>                                };
> >>> +
> >>> +                             power-domain@MT8192_POWER_DOMAIN_ADSP {
> >>> +                                     reg = <MT8192_POWER_DOMAIN_ADSP>;
> >>> +                                     clocks = <&topckgen CLK_TOP_ADSP_SEL>;
> >>> +                                     clock-names = "adsp";
> >>> +                                     mediatek,infracfg = <&infracfg>;
> >>> +                                     #power-domain-cells = <0>;
> >>> +                             };
> >>>                        };
> >>>                };
> >>>
> >>> diff --git a/include/dt-bindings/power/mt8192-power.h b/include/dt-bindings/power/mt8192-power.h
> >>> index 4eaa53d7270a..63e81cd0d06d 100644
> >>> --- a/include/dt-bindings/power/mt8192-power.h
> >>> +++ b/include/dt-bindings/power/mt8192-power.h
> >>> @@ -28,5 +28,6 @@
> >>>    #define MT8192_POWER_DOMAIN_CAM_RAWA        18
> >>>    #define MT8192_POWER_DOMAIN_CAM_RAWB        19
> >>>    #define MT8192_POWER_DOMAIN_CAM_RAWC        20
> >>> +#define MT8192_POWER_DOMAIN_ADSP     21
> >>>
> >>>    #endif /* _DT_BINDINGS_POWER_MT8192_POWER_H */
> >>>
> >>
>
>
