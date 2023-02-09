Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7F76913CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjBIW4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjBIW4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:56:01 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469865BA4C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:55:59 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id d8so3910554ljq.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 14:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+/3WdsTnQdOHde9msyQKMoio/ECH8a5tpAu+T/cYiEY=;
        b=aRzGLdiNL3eF8phfIt/X7mZWoYj/8IzoLLTcAaXgn7QP0njSJYpssKCVpXQg9rIbDg
         kk/kyO3fWq0ZDRcQmQGXPqMLHMkvxIP+PCrcQz5fxtiWTx3IQjcqBqCTK68551Dgyz88
         Lww+qF8HyOkYhI4VNqfUUfdRZEZFaM0SFtpvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/3WdsTnQdOHde9msyQKMoio/ECH8a5tpAu+T/cYiEY=;
        b=vhgSU6wL00+Oax+54PWOesSe4q06eqBFu0qJPndKFpz3TBY8Or4bmxgLanp0CL86cw
         fCqflLPTlWvEKH2xHuc+w6rp27bOkW8SjmfeWnt4+34LLZWq8dFm3zRNcYmcG8kZmRnI
         SXZatdarPKqllVl+IywIz0i+VCH6YPUOUzTiLM6ifgET9iotj156q0lvhWn9w0PtpodF
         SsebTMYOxdb4yr8/S09DH84O5ph2Fh/eQJ8pzFTBE2/ecJgPkq/HyUyNsuX8WXPfDPwM
         cSDpL/n1H4K18xnYWLQ570efRusOcMHmqd6T++6qOPsPV6bWK8oNMtjUdec7BFvnT5FK
         Coag==
X-Gm-Message-State: AO0yUKUUjcRAzzpNPc680KiuR/RoTL8Qu3hNnsOpQ/Hc6026+nLlo3P9
        0weAFs9uS7eqJ3ZVuLf5hw73GSOsOPa4TPsizSOlzw==
X-Google-Smtp-Source: AK7set+i6F2muyublkl3zPHwaGKHmip/aE9IKN/2NWtEl3MCsCwksdVhnIOPhSnHD2GYLH1+A2DsbkPPT6t5/4vraiE=
X-Received: by 2002:a2e:8206:0:b0:290:5b9d:e97 with SMTP id
 w6-20020a2e8206000000b002905b9d0e97mr2076244ljg.187.1675983357541; Thu, 09
 Feb 2023 14:55:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Feb 2023 17:55:56 -0500
MIME-Version: 1.0
In-Reply-To: <1675700201-12890-4-git-send-email-quic_srivasam@quicinc.com>
References: <1675700201-12890-1-git-send-email-quic_srivasam@quicinc.com> <1675700201-12890-4-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 9 Feb 2023 17:55:56 -0500
Message-ID: <CAE-0n53uReg41RrHrBDaNt+BgaPem_JO-2Wwq8e_g0NeNCvgXg@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] arm64: dts: qcom: sc7280: Add LPASS PIL node
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        andersson@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_mohs@quicinc.com, quic_rjendra@quicinc.com,
        quic_rohkumar@quicinc.com, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org, vkoul@kernel.org
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

Quoting Srinivasa Rao Mandadapu (2023-02-06 08:16:36)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> index 1810a36..5e99f49 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> @@ -107,3 +107,7 @@
>                 };
>         };
>  };
> +
> +&remoteproc_adsp {
> +       status = "okay";
> +};

Sort this file by phandle alphabetically?

> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 6908bca..27ab992 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3439,6 +3441,97 @@
>                         status = "disabled";
>                 };
>
> +               remoteproc_adsp: remoteproc@3000000 {

This should be sorted on physical address. I think the node above is
spi@88dc000 so this is in the wrong place.

> +                       compatible = "qcom,sc7280-adsp-pil";
> +                       reg = <0 0x03000000 0 0x5000>, <0 0x0355b000 0 0x10>;
> +                       reg-names = "qdsp6ss_base", "lpass_efuse";
> +
> +                       interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&adsp_smp2p_in 0 IRQ_TYPE_NONE>,

Can these have proper irq flags? Doubtful they're IRQ_TYPE_NONE.

> +                                             <&adsp_smp2p_in 1 IRQ_TYPE_NONE>,
> +                                             <&adsp_smp2p_in 2 IRQ_TYPE_NONE>,
> +                                             <&adsp_smp2p_in 3 IRQ_TYPE_NONE>,
> +                                             <&adsp_smp2p_in 7 IRQ_TYPE_NONE>;
> +
> +                       interrupt-names = "wdog", "fatal", "ready",
> +                                         "handover", "stop-ack",
> +                                         "shutdown-ack";
> +
> +                       qcom,qmp = <&aoss_qmp>;
> +
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>,
> +                                <&gcc GCC_CFG_NOC_LPASS_CLK>;
> +

Drop newline so clocks properties are together please.

> +                       clock-names = "xo", "gcc_cfg_noc_lpass";
> +
> +                       iommus = <&apps_smmu 0x1800 0x0>;
> +
> +                       power-domains = <&rpmhpd SC7280_CX>;
> +                       power-domain-names = "cx";
> +
> +                       required-opps = <&rpmhpd_opp_nom>;
> +
> +                       resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
> +                                <&aoss_reset AOSS_CC_LPASS_RESTART>;
> +

Drop newline so reset properties are together please.

> +                       reset-names =  "pdc_sync", "cc_lpass";
> +                       qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x8000 0x13000>;
> +
> +                       memory-region = <&adsp_mem>;
> +
> +                       qcom,smem-states = <&adsp_smp2p_out 0>;
> +                       qcom,smem-state-names = "stop";
> +
> +                       status = "disabled";
> +
> +                       glink-edge {
> +                               interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
> +                                                      IPCC_MPROC_SIGNAL_GLINK_QMP
> +                                                      IRQ_TYPE_EDGE_RISING>;
> +
> +                               mboxes = <&ipcc IPCC_CLIENT_LPASS
> +                                        IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +                               label = "lpass";
> +                               qcom,remote-pid = <2>;
> +
> +                               gpr {

This node name should be apr per the qcom,glink-edge.yaml binding?

> +                                       compatible = "qcom,gpr";
> +                                       qcom,glink-channels = "adsp_apps";
> +                                       qcom,domain = <GPR_DOMAIN_ID_ADSP>;
> +                                       qcom,intents = <512 20>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +
> +                                       q6apm: service@1 {
> +                                               compatible = "qcom,q6apm";
> +                                               reg = <GPR_APM_MODULE_IID>;
> +                                               #sound-dai-cells = <0>;
> +
> +                                               q6apmdai: dais {
> +                                                       compatible = "qcom,q6apm-dais";
> +                                                       iommus = <&apps_smmu 0x1801 0x0>;
> +                                               };
> +
> +                                               q6apmbedai: bedais {
> +                                                       compatible = "qcom,q6apm-lpass-dais";
> +                                                       #sound-dai-cells = <1>;
> +                                               };
> +                                       };
> +
> +                                       q6prm: service@2 {
> +                                               compatible = "qcom,q6prm";
> +                                               reg = <GPR_PRM_MODULE_IID>;
> +
> +                                               q6prmcc: clock-controller {
> +                                                       compatible = "qcom,q6prm-lpass-clocks";

This is clk binding but not a clk driver? I'll look away now.

> +                                                       #clock-cells = <2>;
> +                                               };
> +                                       };
> +                               };
> +                       };
> +               };
> +
