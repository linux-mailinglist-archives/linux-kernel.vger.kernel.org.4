Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488BF740532
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjF0Utq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjF0Utm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:49:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6E926B9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:49:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb41682472so4677035e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687898979; x=1690490979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u5FTPvn30QPL4kCu475gLqCpNlEhXjGVNlal9AK4Pd8=;
        b=il25tTPhW/Rvl1RK/G0wd46AH78H28kA4j0hHV2yb+D9YTW2Oa7jgQwACbaoKaOT5M
         XG3Gz8kVhsQaPelu834BdknOebU6ml46yRNAbtTMjGp2/mUdVEL98cu1ef67IJVyoxzD
         JU1lO1/63ourhjsCO2FCPYYrItDBXIDduWGYOto0/flbaT7S6DQwYmsCi2xQLBoSAvYb
         to8A/InaT9JVoPSO3VUiV2b81xR8yabdI/BmmWHnlvhJboCjjUZaKaMgFN0hCbZ7tBhR
         5bWRYOMY9VLbIiOKhcUglhjPL6jMXxo3Xe6O7JkQvazDziLAuc3fdFL/6Auw28lL76CJ
         d6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687898979; x=1690490979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5FTPvn30QPL4kCu475gLqCpNlEhXjGVNlal9AK4Pd8=;
        b=g/DzHJy6cl+VxDRKG6iKcT/NiaMgrnZxUELbYVzS5aX0XQSrOkNYq3GMf33eSB49h3
         pkDZduWX2tFrutFkw227SkCByNAQ+vgjRwn5LR+cqIEHUMdAn61RVqeBRoD2UvwPpIT7
         ppD76Mm71dFCQqweHvYSKoCrl85UlB4VJWluvjUCTxZ7g4Viiob2L/Jv9vOpXqugwnjb
         70JJRpc4QKRq7ikPvVDRvUnwHYdGODc9poux/+ZAAc5mFifWum9u8xCb3lbBVEH+egFG
         la4pe1sh1GQvrspBgRilmeapajZtKOSwo7UgYZw1r66wHeKJ7wuagyf7wF7an8DjhhgM
         i8wA==
X-Gm-Message-State: AC+VfDxZ9w/YWhGIK5zV6ZdBNL+jKuP0O45LtMvTD2suw/PDpY/yU+BO
        hRelfzNYHhFZep2t6F/AUlbePw==
X-Google-Smtp-Source: ACHHUZ56rZXCHV+7wUEkRISGb+GdewVmnF02vDb/vrwCgBxxR+1Gg68dP7hpYy5JEb+vQz8qobD9bg==
X-Received: by 2002:a05:6512:1cd:b0:4f9:57e3:ba0b with SMTP id f13-20020a05651201cd00b004f957e3ba0bmr13314170lfp.23.1687898979125;
        Tue, 27 Jun 2023 13:49:39 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id l11-20020ac2554b000000b004fad5602c18sm1371420lfk.73.2023.06.27.13.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 13:49:38 -0700 (PDT)
Message-ID: <e9cbebe4-a400-8635-406e-f0ab9151e784@linaro.org>
Date:   Tue, 27 Jun 2023 22:49:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: msm8974: replace incorrect
 indentation in interconnect
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230627-msm8974-sort-v1-0-75c5800a2e09@z3ntu.xyz>
 <20230627-msm8974-sort-v1-1-75c5800a2e09@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230627-msm8974-sort-v1-1-75c5800a2e09@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.06.2023 21:45, Luca Weiss wrote:
> The clocks definition in the interconnect nodes should use tabs (+ 1
> space) for indentation instead of 9 spaces. Fix that.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
> index aeca504918a0..c6475837eda3 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
> @@ -1075,7 +1075,7 @@ bimc: interconnect@fc380000 {
>  			#interconnect-cells = <1>;
>  			clock-names = "bus", "bus_a";
>  			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> -			         <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
>  		};
>  
>  		snoc: interconnect@fc460000 {
> @@ -1084,7 +1084,7 @@ snoc: interconnect@fc460000 {
>  			#interconnect-cells = <1>;
>  			clock-names = "bus", "bus_a";
>  			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> -			         <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
>  		};
>  
>  		pnoc: interconnect@fc468000 {
> @@ -1093,7 +1093,7 @@ pnoc: interconnect@fc468000 {
>  			#interconnect-cells = <1>;
>  			clock-names = "bus", "bus_a";
>  			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
> -			         <&rpmcc RPM_SMD_PNOC_A_CLK>;
> +				 <&rpmcc RPM_SMD_PNOC_A_CLK>;
>  		};
>  
>  		ocmemnoc: interconnect@fc470000 {
> @@ -1102,7 +1102,7 @@ ocmemnoc: interconnect@fc470000 {
>  			#interconnect-cells = <1>;
>  			clock-names = "bus", "bus_a";
>  			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>,
> -			         <&rpmcc RPM_SMD_OCMEMGX_A_CLK>;
> +				 <&rpmcc RPM_SMD_OCMEMGX_A_CLK>;
>  		};
>  
>  		mmssnoc: interconnect@fc478000 {
> @@ -1111,7 +1111,7 @@ mmssnoc: interconnect@fc478000 {
>  			#interconnect-cells = <1>;
>  			clock-names = "bus", "bus_a";
>  			clocks = <&mmcc MMSS_S0_AXI_CLK>,
> -			         <&mmcc MMSS_S0_AXI_CLK>;
> +				 <&mmcc MMSS_S0_AXI_CLK>;
>  		};
>  
>  		cnoc: interconnect@fc480000 {
> @@ -1120,7 +1120,7 @@ cnoc: interconnect@fc480000 {
>  			#interconnect-cells = <1>;
>  			clock-names = "bus", "bus_a";
>  			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
> -			         <&rpmcc RPM_SMD_CNOC_A_CLK>;
> +				 <&rpmcc RPM_SMD_CNOC_A_CLK>;
>  		};
>  
>  		tsens: thermal-sensor@fc4a9000 {
> 
