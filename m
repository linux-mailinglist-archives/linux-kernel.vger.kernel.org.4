Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5788B7054CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjEPRPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEPRP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:15:29 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ADA7D8C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:15:28 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-ba1815e12efso12473098276.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684257327; x=1686849327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ukVhfKT0mgHG11lGn0vYg1p+mBZBetpSLxzQrrq4sCI=;
        b=qKixGlL5+nxj7tkgi3LANSRTBXsdGbOzI2FobrZdmUaJ0AsQkwmHHkBdbQ9aL+XR8E
         BH9kbJDvGKbDACU861FInxJoKsdjDKZZsVca6ugKf2+uvsXU0AZh053tfBfMsotsspKl
         STGsKM4tqgFt/w9doDR0BK15waVcb16bkFqhELEui25F3rRYsRXmcKKnH4OVaLRun7L5
         LAins/6qDaMFg4vBs46HUDdZchMDsdHldzkc0kdCo+7IT1dCGm+fsnuuW8b6Cgr3A24a
         p2xA67TCKRvZ3u1OPwSEqnWiuq+81xLapggYccLTL8zAWYvajIAXEqQMAsE4sNKt0jLM
         AqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684257327; x=1686849327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukVhfKT0mgHG11lGn0vYg1p+mBZBetpSLxzQrrq4sCI=;
        b=LH8rZjYm5SYxaT/GZtYkti/haHlwSl36sl7iEoIGiLFE/TZkIfcs42Frxj9dcpjoEA
         wXBYsmmtR2P7gIE4SNuXq0QNZi5GhoD55Ax6IRMm0qr/XOGVfxEl4zPhzhcYpQ3K4Q+Q
         7YnhJJB+ENKxw2O+qphl1y72E6AdlNNQbzhBXi5uokoQNZCnqscpuXU8APNK24g3vviq
         XCg4//7MouRoqnnt1zzqXtkZJ8CCc5pOcJPcZlJaWE4FlF2lAHm5QNYRxS3ABpcLC5qp
         9KVrIbGEMaYmKF4WkVpnhkX6WAYTiIyBIPTMXQDvzxsTkYdl3JtTp1prgKv41F16WoS/
         hKPQ==
X-Gm-Message-State: AC+VfDxJt02COLmI/6ct7DUORb8Z+GOeO/KiCiwHvgZqbw/nVYdKsZ3M
        VIEZigYd1JKuaXQ6WAGB+mgaTsTFkQrUJXa61srG0A==
X-Google-Smtp-Source: ACHHUZ7NFOL9q2zyk8wGdHYwQCiYoz226yOqca154O5zJmUfiITU983nmgR3lS0yynOppeDLt38EJxDq1roTnHNDqLI=
X-Received: by 2002:a25:5344:0:b0:ba8:a3b:8e12 with SMTP id
 h65-20020a255344000000b00ba80a3b8e12mr2862948ybb.42.1684257327196; Tue, 16
 May 2023 10:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230516133011.108093-1-krzysztof.kozlowski@linaro.org>
 <CAA8EJpoTgseo3j_5Ab7cQs3ZZZymALpRqpuWGPyKpTEbXR-Cqw@mail.gmail.com> <2e6f282c-33d9-7f96-0338-c4fd457d04fa@linaro.org>
In-Reply-To: <2e6f282c-33d9-7f96-0338-c4fd457d04fa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 16 May 2023 20:15:16 +0300
Message-ID: <CAA8EJpq0x=H_SirdOwwhuiU7b1GPhP6-3xgR9PTQ_b2HYinMzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550-qrd: add PCIe0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 at 19:43, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/05/2023 18:39, Dmitry Baryshkov wrote:
> > On Tue, 16 May 2023 at 16:30, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> Add PCIe0 nodes used with WCN7851 device.  The PCIe1 is not connected,
> >> thus skip pcie_1_phy_aux_clk input clock to GCC.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 32 +++++++++++++++++++++++++
> >>  1 file changed, 32 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> >> index ccc58e6b45bd..e7a2bc5d788b 100644
> >> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> >> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> >> @@ -385,6 +385,38 @@ vreg_l3g_1p2: ldo3 {
> >>         };
> >>  };
> >>
> >> +&gcc {
> >> +       clocks = <&bi_tcxo_div2>, <&sleep_clk>,
> >> +                <&pcie0_phy>,
> >> +                <&pcie1_phy>,
> >> +                <0>,
> >> +                <&ufs_mem_phy 0>,
> >> +                <&ufs_mem_phy 1>,
> >> +                <&ufs_mem_phy 2>,
> >> +                <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
> >> +};
> >
> > Is there any reason to disable the PCIe1 PHY AUX clock here? I mean,
> > the PCIe1 is still enabled in the hardware.
>
> I was thinking about this. The AUX clock seems to be an external clock,
> although I could not find it in schematics. I assume that on QRD8550 it
> could be missing, if it is really external. OTOH, downstream DTS did not
> seem to care...

I might be completely wrong here, but I think that AUX clock is yet
another clock provided by the PHY to the GCC, which we were just
ignoring for now. For example, for sm8450 we have <0> there. I don't
see it as an external clock, so I think it is internal to the SoC.

-- 
With best wishes
Dmitry
