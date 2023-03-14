Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82776BA239
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjCNWPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjCNWOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:14:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2749F38E86
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:13:48 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bp27so11639222lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678831943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q7IZ9/42Vz12w/UhWJvvh9TDHZc4aTylvTdpvECO9YY=;
        b=crYJ+AsWsbvri0SBzNdxKp2m4z3iMgx3xNd45aNqdiVGwSrH0uBCa4Eb5Bt5LHQ4Js
         XQ+DkqM3moFi59nk0XtrglzfB7MVYbvol+nhffaM2KutBLwh/3vTn5pEbpuiwD57oW/O
         Baf5SRSb028y5hszarmDhzHfLBjkQhEaWsRx5qbsem8wA2wWGTRKx9sJiM46YI7NCGaK
         mPXFlZooGYc2pUlvUOfJ89ZJYc4omf+2fv2SbQ01HDYnUaP7TNE28u2O+MEOLqxz+D9K
         1TlHeL1o3LCOmAtulgpp4eGYcCFEjnu79UAiXYBsHlpOLGBGRgQLqTF1VcBM/fvtluWu
         EhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678831943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7IZ9/42Vz12w/UhWJvvh9TDHZc4aTylvTdpvECO9YY=;
        b=1AbkgEqMFgtJ216TiireRwrKfzQ+1ZDj7cDGDs5fr9qIoukfDUZGWFTbobVMvEVtS5
         Za6c9BYS3PvJwIi2ejyWXUFLcJZDO8+zJT3VRCzEo+6F61iYRGCcjBV+aHXBIbjXFXTa
         q1I1VyyB3/3Im84iJZv7ogF+tWU7VEbg/KrE2pk0J2CDY/F+NfdcS9cJSMb+HmvY5ZGs
         JpaVKI0dr+lXPjcTrf552d2xGO22J/o9W/LtY5GnzXCCqbBxJGR2n6T+bMgUUSyymxLq
         o2z8uIdL+IFNZIshNuJdOfv2ZSMadcN1RmavbSntOTcy0XlaIqaRezSHPu23vbpBI0QB
         YHTw==
X-Gm-Message-State: AO0yUKUh/ghUX8irBn7wgymcVIdKd3x5QCNvbGnk1+HhGU8CEHW2i4NA
        KXXUI29jq5ZNAivbO3XVOHzLLQ==
X-Google-Smtp-Source: AK7set/ZJKSOqYo3eqRe7cU87LMkjRpUBViavrajwK8eZnXV7MJyrHv254VUmXBH2Bu1YB16/ZZt/w==
X-Received: by 2002:ac2:44db:0:b0:4e8:5112:1ff2 with SMTP id d27-20020ac244db000000b004e851121ff2mr811415lfm.27.1678831942897;
        Tue, 14 Mar 2023 15:12:22 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id d3-20020a05651221c300b004e1b880ba20sm552430lft.292.2023.03.14.15.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 15:12:22 -0700 (PDT)
Message-ID: <c63ecdc2-11e0-79d2-8647-284913f0c0da@linaro.org>
Date:   Tue, 14 Mar 2023 23:12:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 5/5] arm64: dts: qcom: sm8450: add dp controller
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8450-upstream-dp-controller-v4-0-dca33f531e0d@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v4-5-dca33f531e0d@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v4-5-dca33f531e0d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.03.2023 10:19, Neil Armstrong wrote:
> Add the Display Port controller subnode to the MDSS node.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
[...]
> +
> +				dp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-160000000 {
> +						opp-hz = /bits/ 64 <160000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
Downstream seems to use 19200000 here

Otherwise,

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

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
>  			mdss_dsi0: dsi@ae94000 {
>  				compatible = "qcom,sm8450-dsi-ctrl", "qcom,mdss-dsi-ctrl";
>  				reg = <0 0x0ae94000 0 0x400>;
> 
