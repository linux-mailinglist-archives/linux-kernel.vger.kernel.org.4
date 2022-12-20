Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC29C6527EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiLTUbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiLTUbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:31:09 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6F2C7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:30:39 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id b16so14347493yba.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vgbR39hs3UJeulPBNIIjjd/7lo0Ai0QVKbaChn2/tu0=;
        b=lAPvSs0+UCfL0hswzUDMwVhZQ52vDzcTkcDEDO0tTAyKobBcaVm47DQTXdo2GA76OC
         QOeBC7/RKjZvAeUBuE7TL0gf6GxwhhjgTM8dplpd0IOFJ7r0wH7t2nP9ErSN2aw6h4kl
         +1CPD0oWzHm9Acy33j0YNcxWoxGgxBLfKbP+K5GVeltnBelfZKrkHNxevKAVdWr6YEj/
         H+mA+QdKL35JNzqUkpVv6sduNfXKzejBjSXTR1z0vqIL+XiFDdBBo+7aHsBSSgvkZIrg
         VoK3vAwINpcP3+8boj6j7Uq4CWrBMtD53ZgBJOno5YwmfyS3HtjymMFjrR0JKemN8afR
         P7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgbR39hs3UJeulPBNIIjjd/7lo0Ai0QVKbaChn2/tu0=;
        b=Iuf7mxByqzUgrzgBq0ukeKrLCVfbQX2kwPyFOEbc8c4DRj6p8goB7yVOsbjmFJhvDX
         2pDN2b02412LNTfoPEooGUiTWnUlhyDdC93ArU2gBxPAiXcGAQPmXG753qqgSneGd5UG
         6JTSXU1TuW4zc4PF3ngpkbHL2dB4SNGd1Gzvu+Y8wOR6H3Py0tFpn0bNCQcNoIO+UaY8
         fpKFwef6m26IQ3unNazNNesth6AzyfFvH2SbKNLya0QbvCajsk/q9POAuPRoKhlcW2+h
         wJg/7TK48bKVShz/8KY+XsQ42lgBIegaKoZKfFP+dyu9c/uYoY7MUal0fns/+OOkebIW
         qgYg==
X-Gm-Message-State: ANoB5pkWgXBbP5S4HzM8ylm9H4Uz1eirdFYYeWSCZEdJoHsx7FUrmRIz
        F1hN0z3/WbAgj0vbSOX0JFqrur4QXromAxEEMi2T5A==
X-Google-Smtp-Source: AA0mqf5qeM4TsMsdlufh7YNQMhtx7OKcYKcQOWSMXJxvn2oVQPJtKDpQIycNSluqOaFCKHD38spkZW8K3ovWYHwsAJQ=
X-Received: by 2002:a25:8544:0:b0:723:5b57:cde9 with SMTP id
 f4-20020a258544000000b007235b57cde9mr5023292ybn.194.1671568238281; Tue, 20
 Dec 2022 12:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20221215190404.398788-1-they@mint.lgbt> <20221215190404.398788-2-they@mint.lgbt>
 <e474f99d-2375-c8db-203c-632c918d8e4d@linaro.org> <9c185e36-4342-0f8e-1816-494303ebd072@mint.lgbt>
 <66140726-0771-a28b-4916-cc3aef569cab@linaro.org>
In-Reply-To: <66140726-0771-a28b-4916-cc3aef569cab@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 20 Dec 2022 22:30:25 +0200
Message-ID: <CAA8EJprw+314QagdqmvZ7_6SR-TH5NSmndL66DQqc2=zeaT6AA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2022 at 21:33, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 20.12.2022 19:57, Lux Aliaga wrote:
> > On 16/12/2022 08:24, Konrad Dybcio wrote:
> >
> >>
> >> On 15.12.2022 20:04, Lux Aliaga wrote:
> >>> Adds a UFS host controller node and its corresponding PHY to
> >>> the sm6125 platform.
> >>>
> >>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> >>> ---
> >> Please include a changelog, I don't know what you changed and
> >> what you didn't. Also, you sent 4 revisions in one day, not
> >> letting others review it.
> >>
> >>
> >>>   arch/arm64/boot/dts/qcom/sm6125.dtsi | 67 ++++++++++++++++++++++++++++
> >>>   1 file changed, 67 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> >>> index 7e25a4f85594..b64c5bc1452f 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> >>> @@ -508,6 +508,73 @@ sdhc_2: mmc@4784000 {
> >>>               status = "disabled";
> >>>           };
> >>>   +        ufs_mem_hc: ufs@4804000 {
> >>> +            compatible = "qcom,sm6125-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
> >>> +            reg = <0x04804000 0x3000>, <0x04810000 0x8000>;
> >>> +            reg-names = "std", "ice";
> >>> +            interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> >>> +            phys = <&ufs_mem_phy_lanes>;
> >>> +            phy-names = "ufsphy";
> >>> +            lanes-per-direction = <1>;
> >>> +            #reset-cells = <1>;
> >>> +            resets = <&gcc GCC_UFS_PHY_BCR>;
> >>> +            reset-names = "rst";
> >>> +
> >>> +            clock-names = "core_clk",
> >>> +                      "bus_aggr_clk",
> >>> +                      "iface_clk",
> >>> +                      "core_clk_unipro",
> >>> +                      "ref_clk",
> >>> +                      "tx_lane0_sync_clk",
> >>> +                      "rx_lane0_sync_clk",
> >>> +                      "ice_core_clk";
> >>> +            clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
> >>> +                 <&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
> >>> +                 <&gcc GCC_UFS_PHY_AHB_CLK>,
> >>> +                 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> >>> +                 <&rpmcc RPM_SMD_XO_CLK_SRC>,
> >>> +                 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> >>> +                 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> >>> +                 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
> >>> +            freq-table-hz = <50000000 240000000>,
> >>> +                    <0 0>,
> >>> +                    <0 0>,
> >>> +                    <37500000 150000000>,
> >>> +                    <0 0>,
> >>> +                    <0 0>,
> >>> +                    <0 0>,
> >>> +                    <75000000 300000000>;
> >>> +
> >>> +            non-removable;
> >>> +            status = "disabled";
> >>> +        };
> >>> +
> >>> +        ufs_mem_phy: phy@4807000 {
> >>> +            compatible = "qcom,sm6115-qmp-ufs-phy";
> >> Krzysztof asked you to add a SoC-specific compatible in v1.
> > I'm working on adding a new compatible for sm6125's UFS PHY. Should I copy sm6115's tables or just reference them in the sm6125's config in drivers/phy/qualcomm/phy-qcom-qmp-ufs.c?
> If they're identical, you can just do something like this:
>
> compatible = "qcom,sm6125-qmp-ufs-phy", "qcom,sm6115-qmp-ufs-phy";

Ugh. I'd prefer to see either of the compatible strings here, but not
both of them.

>
> And ensure your newly added compatible is documented in bindings.
> This way, the driver will fall back to the 6115 compatible that's
> defined in .c, but if we ever need to adjust something specific
> for 6125, we will just use the define that we added here. That's
> important, as we're supposed to stay backwards-compatible with
> old device trees.
>
> Also, wrap your emails at around 80 chars or so, some people
> are grumpy about that :P
>
> Konrad
> >



-- 
With best wishes
Dmitry
