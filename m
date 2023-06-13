Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650CA72E023
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbjFMKxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbjFMKxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:53:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF171BC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:53:46 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1a4250b07so65905201fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686653624; x=1689245624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/ZCLAeCcfQ3eJIRINpsKqGfmpkFlfxkpCbtPVXG0hM=;
        b=SRe6PcgilZzJ8XMwydFMBJuZRq1Nxti3V2V7ii10Hl2Ze/ycLRjuWGqaZAhO7pk9OR
         Yar79XLKLpX476NlndJETikJTMThoX1Zs4EuzGlLFZkYA+TQO7wN3OZzXJKsM3qt66KL
         Cf8Pk3PcGrNsnuQ8IRkN73Q9AdB6X6Xdaa+StFHB+J/145KqV/vsbc5u298Urua0BVCg
         TzSwOwG94q0Xvmf9xswOS+1ee8GXq4kBqKBjmx5D01mSkmqGEU0sgQT4uEEGPuiljiIy
         uAniXpRzJE41PTq2hR+aK5qPwlKyI5EjqRuxYLDH7XfdbNG2n+fZ77qgEChfevDizg0O
         O8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686653624; x=1689245624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/ZCLAeCcfQ3eJIRINpsKqGfmpkFlfxkpCbtPVXG0hM=;
        b=jEtwRpwT7OeB43pHx+DbmUxaH2RSrqsNPU3H2Gn7TcnERf/jzBZMM/1hLSOis7rF6K
         2wQLiHgbI01trOuS/zCeS52ONWhPmBRDDZccOZMsqCMkHMOdjxsQG/GjCidqosYI8iW2
         Qq/5i3AXtaOCnUUjeQbsgu8n0HFPCeTxdoxPj0OtRde4VlN+P5SzESWPjWGP2X3obpCu
         VuT2awe06zxMKKwtZmHcY/vFSOF+L4Xv/lEcII8X5nm8Mbc5rKdfjyLObencfeY3bvyJ
         gkQMUyLqCAD8twmk2r65snJUsgeJhZ3jqZ5wXEUr9ZnODL7Yt5JdS9RKIr1Nt0rSQpZH
         ruuw==
X-Gm-Message-State: AC+VfDwIaEhtneUhi4R/+x+VwRqLxlaneU026ABc5758gv12vbFR+Q+s
        8ZNwCK1dxbUmJT3J02lTvzaYBw==
X-Google-Smtp-Source: ACHHUZ6uqHRBmuiaAjNwO4VItTgi9nDeWav7bqGdckColPNj3KXQMh0quW3KrJxlXIfZqAQuxdoPAQ==
X-Received: by 2002:a2e:7306:0:b0:2b2:4e86:57f2 with SMTP id o6-20020a2e7306000000b002b24e8657f2mr4150861ljc.19.1686653624441;
        Tue, 13 Jun 2023 03:53:44 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a12-20020a2e830c000000b002b22a1a21easm1731993ljh.110.2023.06.13.03.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 03:53:44 -0700 (PDT)
Message-ID: <e9bf9658-216f-a882-c699-858c41892451@linaro.org>
Date:   Tue, 13 Jun 2023 12:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sc8180x: Add USB Type-C of_graph
 anchors
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612221456.1887533-1-quic_bjorande@quicinc.com>
 <20230612221456.1887533-2-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230612221456.1887533-2-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.06.2023 00:14, Bjorn Andersson wrote:
> Define anchors for wiring up the USB Type-C graph in the board files.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 48 +++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> index a7668f9e68d6..4144beb70cb4 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> @@ -2464,6 +2464,23 @@ usb_prim_qmpphy: phy@88e9000 {
>  
>  			status = "disabled";
>  
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					usb_prim_qmpphy_out: endpoint {};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					usb_prim_qmpphy_dp_in: endpoint {};
> +				};
> +			};
> +
>  			usb_prim_ssphy: usb3-phy@88e9200 {
>  				reg = <0 0x088e9200 0 0x200>,
>  				      <0 0x088e9400 0 0x200>,
> @@ -2513,6 +2530,23 @@ usb_sec_qmpphy: phy@88ee000 {
>  
>  			status = "disabled";
>  
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					usb_sec_qmpphy_out: endpoint {};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					usb_sec_qmpphy_dp_in: endpoint {};
> +				};
> +			};
> +
>  			usb_sec_ssphy: usb3-phy@88e9200 {
>  				reg = <0 0x088ee200 0 0x200>,
>  				      <0 0x088ee400 0 0x200>,
> @@ -2607,6 +2641,11 @@ usb_prim_dwc3: usb@a600000 {
>  				snps,dis_enblslpm_quirk;
>  				phys = <&usb_prim_hsphy>, <&usb_prim_ssphy>;
>  				phy-names = "usb2-phy", "usb3-phy";
> +
> +				port {
> +					usb_prim_role_switch: endpoint {
> +					};
> +				};
>  			};
>  		};
>  
> @@ -2659,6 +2698,11 @@ usb_sec_dwc3: usb@a800000 {
>  				snps,dis_enblslpm_quirk;
>  				phys = <&usb_sec_hsphy>, <&usb_sec_ssphy>;
>  				phy-names = "usb2-phy", "usb3-phy";
> +
> +				port {
> +					usb_sec_role_switch: endpoint {
> +					};
> +				};
>  			};
>  		};
>  
> @@ -2986,6 +3030,8 @@ dp0_in: endpoint {
>  
>  					port@1 {
>  						reg = <1>;
> +						mdss_dp0_out: endpoint {
> +						};
>  					};
>  				};
>  
> @@ -3060,6 +3106,8 @@ dp1_in: endpoint {
>  
>  					port@1 {
>  						reg = <1>;
> +						mdss_dp1_out: endpoint {
> +						};
>  					};
>  				};
>  
