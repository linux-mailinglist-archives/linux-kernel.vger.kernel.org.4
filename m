Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE017692212
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjBJPYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjBJPYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:24:35 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E9E75F6B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:24:16 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jg8so16791095ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gCHYjcncflVx/yjUEZZwsiDoD/DvS3T0rRLgLEJn6PA=;
        b=cXGPeltBt6F1AY3xiK843QltijxYiz660ivWON60ggvCiutjrd/373RJLmscVYJr6j
         fA35d4famGzTBbF7gsH+gsNA4pKIEE0R/P3oEreOERvASYZGhjFrTIPDd3X4tCTF23A8
         F4llHl3Vthej69NZiZDOOQHuW6fTbsMpf/SE4T9PpCBtS0AY0gCm+vtvrZWLW3kX2dqQ
         o9Vj7Pyg7iazqlp8ngjJQbX/EED7mjrm/jorfaM8KEd84hVSnKnC7i3PYKJUo3SIUxVU
         hg0fhuvC7XWxL1Xq8QgKQXl6+3etHJrhAPiDO5WvNTw/H0WbpwtqmZs4TkkLOVgq7ywV
         qEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCHYjcncflVx/yjUEZZwsiDoD/DvS3T0rRLgLEJn6PA=;
        b=5fzrfGb/boyLoy+kT8ZxSTaZnE2EFE78UFKidGAfX/DvQD3l+GqeobgitB+h41peWG
         Iwr+zAwXsRSsUbu4Ki5XuJqeM9kXEOiMwCcJGAM0ZH2t8fQmtzgZWHv7Bxv8DHkw6aNE
         Pj039gYMzluiOWsIH/ZY8ShkMXwpVwfoA9Nj54LdQAMwDpdJ+FCBgZI5Uwd7KuR3eGth
         vBj1veiwbZzvW+mvF1YozLfCirwqkjsGr78gK++qJOtEms5keBPR6gjls9J9SYs0QO9q
         0LGLkg5aY+OXII96hOM3PVyRuuzUuoYWYUTH/UV1RqGU7TSiOYU71TW7snqhIvdxBxOw
         tM8w==
X-Gm-Message-State: AO0yUKU/MhBEbi1cfckwnmKrqu0eYAoCNs3rLOyaQPq8iu5KeSlXC8aM
        46CALUFrN78oik2PdfBDNgPugg==
X-Google-Smtp-Source: AK7set/KUCOzTCOVo2Vq2CGBzdc457jv12fo4H0oyU1WQa8Q4BmAWpLgg/AbmeTYX5Nv/2vROWHkng==
X-Received: by 2002:a17:906:3810:b0:888:952f:fec5 with SMTP id v16-20020a170906381000b00888952ffec5mr15692985ejc.8.1676042655400;
        Fri, 10 Feb 2023 07:24:15 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id mv9-20020a170907838900b0087bd2ebe474sm2485375ejc.208.2023.02.10.07.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 07:24:14 -0800 (PST)
Message-ID: <347a5193-f7b1-7f8e-0c60-3d435bdf952c@linaro.org>
Date:   Fri, 10 Feb 2023 17:24:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sm8450: add dp controller
Content-Language: en-GB
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8450-upstream-dp-controller-v3-0-636ef9e99932@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v3-5-636ef9e99932@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v3-5-636ef9e99932@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 16:44, Neil Armstrong wrote:
> Add the Display Port controller subnode to the MDSS node.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 79 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 79 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 6caa2c8efb46..72d54beb7d7c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2751,6 +2751,13 @@ dpu_intf2_out: endpoint {
>   						};
>   					};
>   
> +					port@2 {
> +						reg = <2>;
> +						dpu_intf0_out: endpoint {
> +							remote-endpoint = <&mdss_dp0_in>;
> +						};
> +					};
> +
>   				};
>   
>   				mdp_opp_table: opp-table {
> @@ -2783,6 +2790,78 @@ opp-500000000 {
>   				};
>   			};
>   
> +			mdss_dp0: displayport-controller@ae90000 {
> +				compatible = "qcom,sm8350-dp";

Missing "qcom,sm8450-dp". As I wrote in the comment to patch 1, I'd 
suggest having just a single entry here rather than keeping both 8350 
and 8450 entries.

> +				reg = <0 0xae90000 0 0xfc>,
> +				      <0 0xae90200 0 0xc0>,
> +				      <0 0xae90400 0 0x770>,
> +				      <0 0xae91000 0 0x98>,
> +				      <0 0xae91400 0 0x98>;


While this sounds correct, usually we used the even size here (0x200, 
0x400, etc.). Can we please switch to it (especially since sm8350-dp 
uses even sizes).

> +				interrupt-parent = <&mdss>;
> +				interrupts = <12>;
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> +				clock-names = "core_iface",
> +					      "core_aux",
> +					      "ctrl_link",
> +			                      "ctrl_link_iface",
> +					      "stream_pixel";
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
> +
> +				phys = <&usb_1_qmpphy QMP_USB43DP_DP_PHY>;
> +			        phy-names = "dp";
> +
> +			        #sound-dai-cells = <0>;
> +
> +				operating-points-v2 = <&dp_opp_table>;
> +				power-domains = <&rpmhpd SM8450_MMCX>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss_dp0_in: endpoint {
> +							remote-endpoint = <&dpu_intf0_out>;
> +						};
> +					};
> +				};
> +
> +				dp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-160000000 {
> +						opp-hz = /bits/ 64 <160000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-540000000 {
> +						opp-hz = /bits/ 64 <540000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-810000000 {
> +						opp-hz = /bits/ 64 <810000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};
> +
>   			mdss_dsi0: dsi@ae94000 {
>   				compatible = "qcom,sm8450-dsi-ctrl", "qcom,mdss-dsi-ctrl";
>   				reg = <0 0x0ae94000 0 0x400>;
> 

-- 
With best wishes
Dmitry

