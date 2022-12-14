Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A3264C337
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbiLNEn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbiLNEnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:43:25 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE2A60FE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:43:24 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id cf42so8613804lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ePtSpP/HbBedS26PomtLLslHHJHJCj5dUEEqmQ5fMs4=;
        b=dQQSHhxq4b0+PXDE0vgYFieN6asUOV9bubVkHrSjANmo1qh/dZNP7TgcGfe1uehreM
         hSL7v3Ck9YMwRrM15ptA/N1vB9gdkGCgZLSfbsv/34/xZ0m/W9eDEUB0TUa3F11gYUVV
         2Ms+RK69RdWYFrmynzhyzH/IRHpjuf9kWL4278VwKRbYuDl5mt2aXmXT/Y7u/67TBEkA
         B2TFYPvh9X7nX4H5MHSXqIgSLYUS8Nh5240LDFWzhIznXNCeWJcqeMjQmJarOLdMY33g
         gu6x9XRjQdijude3+rkuSAUsCoUeq5flOEak2ugooJbw98yeVvr0iYi1VyRdg2RuREDP
         RWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePtSpP/HbBedS26PomtLLslHHJHJCj5dUEEqmQ5fMs4=;
        b=keRoD/TvqxjKZ45BnxvrqNbXRe9yspkZU5QIi+1EhKLnRzH3NbtbcGhECBf30J6Vy/
         SwCrw73YtQD/uFq86535wU7BvaIwQhGvh+On4y1q/DnqrAoi+FlUxUZ1X8nsxp1ZxMT6
         RYRrdACxyus/PMpQKcjaJz1yyShjupnMsiuViLPbrPNM84yAeuZss1Wu42AjY1wObCdz
         6od2mXTs+VLS7c5aOsPpdVkscTY+kJ+2np9r09aGMs+VQpMn8OP8FbvMc2phTnpvgWPc
         5Mpijux0YaosVusNXOLNIwGZzShvVKeJd+cMqE9E9gFUFqH/cuJbO8bfcshvIMSqA3O7
         i9WQ==
X-Gm-Message-State: ANoB5pkamrZKFjmpKRLrH6JzWjOBYx/9YD00RATJuYfXdX8XZKyFlcFL
        aJKYx62nNXRcq6tdO/PhJlUBMvBq1VE3hKzGyNljwQ==
X-Google-Smtp-Source: AA0mqf7H6b/wLDU/ymtPnzM3dE/TBbaPlmrFJvkxaeAGzVLzeBH0KAomCqO+0tBvHqDEY7QwFKWx2QUFu95xPDkqocM=
X-Received: by 2002:a05:6512:a83:b0:4aa:f944:f7ec with SMTP id
 m3-20020a0565120a8300b004aaf944f7ecmr27772242lfu.467.1670993002358; Tue, 13
 Dec 2022 20:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20221213123823.455731-1-bhupesh.sharma@linaro.org>
 <20221213123823.455731-4-bhupesh.sharma@linaro.org> <20bd4594-7302-5823-447f-b980c476323e@linaro.org>
 <8D9809D9-AB2F-4D9E-9272-2BFC27FF49E5@linaro.org>
In-Reply-To: <8D9809D9-AB2F-4D9E-9272-2BFC27FF49E5@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 14 Dec 2022 10:13:11 +0530
Message-ID: <CAH=2NtyyqoX2B32OCbAva_zdq6g+GbvOFMwdcKoMhArv03+Xeg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 at 03:48, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
>
>
> On 13 December 2022 14:49:05 EET, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >
> >
> >On 13.12.2022 13:38, Bhupesh Sharma wrote:
> >> Add USB superspeed qmp phy node to dtsi.
> >>
> >> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >> ---
> >Please run make dtbs_check before sending dt patches, this one
> >introduces new errors.
> >
> >
> >>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 38 ++++++++++++++++++++++++++--
> >>  1 file changed, 36 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >> index e4ce135264f3d..9c5c024919f92 100644
> >> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >> @@ -579,6 +579,40 @@ usb_hsphy: phy@1613000 {
> >>                      status = "disabled";
> >>              };
> >>
> >> +            usb_qmpphy: phy@1615000 {
> >> +                    compatible = "qcom,sm6115-qmp-usb3-phy";
> >> +                    reg = <0x01615000 0x200>;
> >> +                    #clock-cells = <1>;
> >> +                    #address-cells = <1>;
> >> +                    #size-cells = <1>;
> >> +                    ranges;
> >These -cells and ranges properties could go after status=disabled
> >
> >Konrad
> >> +                    clocks = <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> >> +                             <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> >> +                             <&gcc GCC_AHB2PHY_USB_CLK>;
> >> +                    clock-names = "com_aux",
> >> +                                  "ref",
> >> +                                  "cfg_ahb";
> >> +                    resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
> >> +                             <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
> >> +                    reset-names = "phy", "phy_phy";
> >> +                    status = "disabled";
> >> +
> >> +                    usb_ssphy: phy@1615200 {
>
> We should not introduce additional qmp-with-child PHY nodes.

Not sure I understand your point. Is there some recent change (being
discussed) regarding the same?

Thanks,
Bhupesh

>
> >> +                            reg = <0x01615200 0x200>,
> >> +                                  <0x01615400 0x200>,
> >> +                                  <0x01615c00 0x400>,
> >> +                                  <0x01615600 0x200>,
> >> +                                  <0x01615800 0x200>,
> >> +                                  <0x01615a00 0x100>;
> >> +                            #phy-cells = <0>;
> >> +                            #clock-cells = <1>;
> >> +                            clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> >> +                            clock-names = "pipe0";
> >> +                            clock-output-names = "usb3_phy_pipe_clk_src";
> >> +                    };
> >> +            };
> >> +
> >> +
> >>              qfprom@1b40000 {
> >>                      compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
> >>                      reg = <0x01b40000 0x7000>;
> >> @@ -1023,8 +1057,8 @@ usb_dwc3: usb@4e00000 {
> >>                              compatible = "snps,dwc3";
> >>                              reg = <0x04e00000 0xcd00>;
> >>                              interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
> >> -                            phys = <&usb_hsphy>;
> >> -                            phy-names = "usb2-phy";
> >> +                            phys = <&usb_hsphy>, <&usb_ssphy>;
> >> +                            phy-names = "usb2-phy", "usb3-phy";
> >>                              iommus = <&apps_smmu 0x120 0x0>;
> >>                              snps,dis_u2_susphy_quirk;
> >>                              snps,dis_enblslpm_quirk;
>
> --
> With best wishes
> Dmitry
