Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A6663C8DC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbiK2T7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiK2T7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:59:14 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F6C27CD1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:59:11 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id q7so18502461ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AmnMdhMIbuK+ioOE5wyae0BlwkJ1ypVUOrJTSmxMhn8=;
        b=dgFKKoEXnI+rRu0A8nhpr9dIH8IXvWuvvzO9BpJZlIKDLavNMwYCmA5eeVuu55peXf
         OBEEo8a7yZU4vrsEm2H9LcvLtSKiOMsQfsN/a6uiTGDgv3q0PIt4aMkxxCnKKoAfChIf
         auDiKy0ExYOszLxQT+sUCwlIX3ceL1iohbJ6pSzgtfjHtDXGSHFH2fpD3hCTEOIxBYMS
         4zV1sVz31MK4SLt5UeGdBkqc9H9+2U0224CKZI5tRM8f2YxywtP5EMkDcrNDOH3I9c0m
         /mB/uykcptyuDWlMtDH+4v1WoybyWJkBPKsHxYX3g9h5hz/TugzFJ6dOnu78AiQGAW9W
         hcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmnMdhMIbuK+ioOE5wyae0BlwkJ1ypVUOrJTSmxMhn8=;
        b=3xti4VFOf3t08ELkjjgv5AE4sYCyLxGLHAR7q1brxdIlZyn4p+Xa1rqIZRgvcJfDnE
         pyyX29XUVuKXmzZwRiqc2Jc1xbZ/qylM/8qrh3L6eRW8gYA8xA88cesZJ7msp+Zyz/i1
         r7tCItNZw5/xBHruEurhsGQRaaXW/dDQTFGCwhmv1dQSr0xMlHaiJLqWvp5ZR8QFF32J
         ZpNkurpl96ssaFZTDuBYPR7goJRyW6EjjN98/+ekk45E+YxTS2Tf+0p28KbBES3Q82fQ
         N+Q0ctkjPX0TCAPk4NV418OrRytMobOMzHmR2R1Di0bDMbljusPsluufINzPHdGiRvyV
         FLEg==
X-Gm-Message-State: ANoB5pnjJOuzGfJV8HELrgksSTEQzh0KbTlTZvXOSqMyNhfjgW++6INa
        vrKJirOi1nxXbJez9kLw2uoi3Q==
X-Google-Smtp-Source: AA0mqf6eEb4mm4hewBmMNDBECy0NIbeDiiZarC+hAyVtbboS9KaMxc0n1e9xi4MDoQXy+dx122HEUg==
X-Received: by 2002:a2e:930f:0:b0:279:a72b:815b with SMTP id e15-20020a2e930f000000b00279a72b815bmr3336062ljh.490.1669751950146;
        Tue, 29 Nov 2022 11:59:10 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x7-20020ac259c7000000b004b529517d95sm321732lfn.40.2022.11.29.11.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 11:59:06 -0800 (PST)
Message-ID: <a1046ae6-cffb-2dbf-0bfd-3787eafe9a0d@linaro.org>
Date:   Tue, 29 Nov 2022 21:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 10/12] arm64: dts: qcom: sm8350: Add display system
 nodes
Content-Language: en-GB
To:     Robert Foss <robert.foss@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, quic_kalyant@quicinc.com,
        swboyd@chromium.org, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, quic_khsieh@quicinc.com,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org
References: <20221115133105.980877-1-robert.foss@linaro.org>
 <20221115133105.980877-11-robert.foss@linaro.org>
 <dc138171-f7b1-2761-d800-620e85afd6d9@linaro.org>
 <CAG3jFyuC59iX9p9eB7WT0Lx34DszZrwbOSnRyV_X02=TnVs6tg@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAG3jFyuC59iX9p9eB7WT0Lx34DszZrwbOSnRyV_X02=TnVs6tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 18:47, Robert Foss wrote:
> On Tue, 15 Nov 2022 at 14:47, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 15/11/2022 14:31, Robert Foss wrote:
>>> Add mdss, mdss_mdp, dsi0, dsi0_phy nodes. With these
>>> nodes the display subsystem is configured to support
>>> one DSI output.
>>>
>>> Signed-off-by: Robert Foss <robert.foss@linaro.org>
>>> ---
>>>    arch/arm64/boot/dts/qcom/sm8350.dtsi | 197 ++++++++++++++++++++++++++-
>>>    1 file changed, 193 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> index 434f8e8b12c1..5c98e5cf5ad0 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> @@ -3,6 +3,7 @@
>>>     * Copyright (c) 2020, Linaro Limited
>>>     */
>>>
>>> +#include <dt-bindings/interconnect/qcom,sm8350.h>
>>>    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>    #include <dt-bindings/clock/qcom,dispcc-sm8350.h>
>>>    #include <dt-bindings/clock/qcom,gcc-sm8350.h>
>>> @@ -2536,14 +2537,201 @@ usb_2_dwc3: usb@a800000 {
>>>                        };
>>>                };
>>>
>>> +             mdss: mdss@ae00000 {
>>> +                     compatible = "qcom,sm8350-mdss";
>>> +                     reg = <0 0x0ae00000 0 0x1000>;
>>> +                     reg-names = "mdss";
>>> +
>>> +                     interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>,
>>> +                                     <&mmss_noc MASTER_MDP1 0 &mc_virt SLAVE_EBI1 0>;
>>> +                     interconnect-names = "mdp0-mem", "mdp1-mem";
>>> +
>>> +                     power-domains = <&dispcc MDSS_GDSC>;
>>> +                     resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
>>> +
>>> +                     clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>>> +                              <&gcc GCC_DISP_HF_AXI_CLK>,
>>> +                              <&gcc GCC_DISP_SF_AXI_CLK>,
>>> +                              <&dispcc DISP_CC_MDSS_MDP_CLK>;
>>> +                     clock-names = "iface", "bus", "nrt_bus", "core";
>>> +
>>> +                     interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>>> +                     interrupt-controller;
>>> +                     #interrupt-cells = <1>;
>>> +
>>> +                     iommus = <&apps_smmu 0x820 0x402>;
>>> +
>>> +                     status = "disabled";
>>> +
>>> +                     #address-cells = <2>;
>>> +                     #size-cells = <2>;
>>> +                     ranges;
>>> +
>>> +                     mdss_mdp: display-controller@ae01000 {
>>> +                             compatible = "qcom,sm8350-dpu";
>>> +                             reg = <0 0x0ae01000 0 0x8f000>,
>>> +                                   <0 0x0aeb0000 0 0x2008>;
>>> +                             reg-names = "mdp", "vbif";
>>> +
>>> +                             clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
>>> +                                     <&gcc GCC_DISP_SF_AXI_CLK>,
>>> +                                     <&dispcc DISP_CC_MDSS_AHB_CLK>,
>>> +                                     <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
>>> +                                     <&dispcc DISP_CC_MDSS_MDP_CLK>,
>>> +                                     <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
>>> +                             clock-names = "bus",
>>> +                                           "nrt_bus",
>>> +                                           "iface",
>>> +                                           "lut",
>>> +                                           "core",
>>> +                                           "vsync";
>>> +
>>> +                             assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
>>> +                             assigned-clock-rates = <19200000>;
>>> +
>>> +                             operating-points-v2 = <&mdp_opp_table>;
>>> +                             power-domains = <&rpmhpd SM8350_MMCX>;
>>> +
>>> +                             interrupt-parent = <&mdss>;
>>> +                             interrupts = <0>;
>>> +
>>> +                             status = "disabled";
>> It doesn't make sense to disable mdp separately, as mdss is essentially
>> useless without it.
> 
> Ack
> 
>>
>>> +
>>> +                             ports {
>>> +                                     #address-cells = <1>;
>>> +                                     #size-cells = <0>;
>>> +
>>> +                                     port@0 {
>>> +                                             reg = <0>;
>>> +                                             dpu_intf1_out: endpoint {
>>> +                                                     remote-endpoint = <&dsi0_in>;
>>> +                                             };
>>> +                                     };
>>> +                             };
>>> +
>>> +                             mdp_opp_table: opp-table {
>>> +                                     compatible = "operating-points-v2";
>>> +
>>> +                                     opp-200000000 {
>>> +                                             opp-hz = /bits/ 64 <200000000>;
>>> +                                             required-opps = <&rpmhpd_opp_low_svs>;
>>> +                                     };
>>> +
>>> +                                     opp-300000000 {
>>> +                                             opp-hz = /bits/ 64 <300000000>;
>>> +                                             required-opps = <&rpmhpd_opp_svs>;
>>> +                                     };
>>> +
>>> +                                     opp-345000000 {
>>> +                                             opp-hz = /bits/ 64 <345000000>;
>>> +                                             required-opps = <&rpmhpd_opp_svs_l1>;
>>> +                                     };
>>> +
>>> +                                     opp-460000000 {
>>> +                                             opp-hz = /bits/ 64 <460000000>;
>>> +                                             required-opps = <&rpmhpd_opp_nom>;
>>> +                                     };
>>> +                             };
>>> +                     };
>>> +
>>> +                     dsi0: dsi@ae94000 {
>>> +                             compatible = "qcom,mdss-dsi-ctrl";
>>> +                             reg = <0 0x0ae94000 0 0x400>;
>>> +                             reg-names = "dsi_ctrl";
>>> +
>>> +                             interrupt-parent = <&mdss>;
>>> +                             interrupts = <4>;
>>> +
>>> +                             clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
>>> +                                      <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
>>> +                                      <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
>>> +                                      <&dispcc DISP_CC_MDSS_ESC0_CLK>,
>>> +                                      <&dispcc DISP_CC_MDSS_AHB_CLK>,
>>> +                                      <&gcc GCC_DISP_HF_AXI_CLK>;
>>> +                             clock-names = "byte",
>>> +                                           "byte_intf",
>>> +                                           "pixel",
>>> +                                           "core",
>>> +                                           "iface",
>>> +                                           "bus";
>>> +
>>> +                             assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
>>> +                                               <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
>>> +                             assigned-clock-parents = <&dsi0_phy 0>,
>>> +                                                      <&dsi0_phy 1>;
>>> +
>>> +                             operating-points-v2 = <&dsi_opp_table>;
>>> +                             power-domains = <&rpmhpd SM8350_MMCX>;
>>> +
>>> +                             phys = <&dsi0_phy>;
>>> +                             phy-names = "dsi";
>> I think that was dropped as of late.
> 
> Ack
> 
>>
>>> +
>>> +                             status = "disabled";
>>> +
>>> +                             ports {
>>> +                                     #address-cells = <1>;
>>> +                                     #size-cells = <0>;
>>> +
>>> +                                     port@0 {
>>> +                                             reg = <0>;
>>> +                                             dsi0_in: endpoint {
>>> +                                                     remote-endpoint = <&dpu_intf1_out>;
>>> +                                             };
>>> +                                     };
>>> +
>>> +                                     port@1 {
>>> +                                             reg = <1>;
>>> +                                             dsi0_out: endpoint {
>>> +                                             };
>>> +                                     };
>>> +                             };
>>> +                     };
>>> +
>>> +                     dsi0_phy: phy@ae94400 {
>>> +                             compatible = "qcom,dsi-phy-5nm-8350";
>>> +                             reg = <0 0x0ae94400 0 0x200>,
>>> +                                   <0 0x0ae94600 0 0x280>,
>>> +                                   <0 0x0ae94900 0 0x260>;
>>> +                             reg-names = "dsi_phy",
>>> +                                         "dsi_phy_lane",
>>> +                                         "dsi_pll";
>>> +
>>> +                             #clock-cells = <1>;
>>> +                             #phy-cells = <0>;
>>> +
>>> +                             clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>>> +                                      <&rpmhcc RPMH_CXO_CLK>;
>>> +                             clock-names = "iface", "ref";
>>> +
>>> +                             status = "disabled";
>>> +
>>> +                             dsi_opp_table: dsi-opp-table {
>>> +                                     compatible = "operating-points-v2";
>>> +
>>> +                                     opp-187500000 {
>>> +                                             opp-hz = /bits/ 64 <187500000>;
>>> +                                             required-opps = <&rpmhpd_opp_low_svs>;
>>> +                                     };
>>> +
>>> +                                     opp-300000000 {
>>> +                                             opp-hz = /bits/ 64 <300000000>;
>>> +                                             required-opps = <&rpmhpd_opp_svs>;
>>> +                                     };
>>> +
>>> +                                     opp-358000000 {
>>> +                                             opp-hz = /bits/ 64 <358000000>;
>>> +                                             required-opps = <&rpmhpd_opp_svs_l1>;
>>> +                                     };
>>> +                             };
>>> +                     };
>>> +             };
>>> +
>>>                dispcc: clock-controller@af00000 {
>>>                        compatible = "qcom,sm8350-dispcc";
>>>                        reg = <0 0x0af00000 0 0x10000>;
>>>                        clocks = <&rpmhcc RPMH_CXO_CLK>,
>>> -                              <0>,
>>> -                              <0>,
>>> -                              <0>,
>>> -                              <0>,
>>> +                              <&dsi0_phy 0>, <&dsi0_phy 1>,
>>> +                              <0>, <0>,
>>>                                 <0>,
>>>                                 <0>;
>>>                        clock-names = "bi_tcxo",
>>> @@ -2558,6 +2746,7 @@ dispcc: clock-controller@af00000 {
>>>                        #power-domain-cells = <1>;
>>>
>>>                        power-domains = <&rpmhpd SM8350_MMCX>;
>>> +                     required-opps = <&rpmhpd_opp_turbo>;
>> A turbo vote is required for it to function? Seems a bit high..
> 
> Dmitry hit a snag using &rpmhpd_opp_low_svs, so this was a dummy
> value. I can't replicate that issue, but am having a conversation with
> him off-list about this.
> 
> On my sm8350-hdk board &rpmhpd_opp_low_svs is working fine.

Maybe this is related to the bootloader setting up the mode or maybe it 
was caused by the fact that I have the drm_msm set up as built-in rather 
than a module.

> 
>>
>> Konrad
>>>                };
>>>
>>>                adsp: remoteproc@17300000 {

-- 
With best wishes
Dmitry

