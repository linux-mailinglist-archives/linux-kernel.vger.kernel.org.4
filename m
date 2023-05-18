Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2686B70770A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjERAly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjERAlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:41:53 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2539926A3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:41:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f122ff663eso1627545e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684370509; x=1686962509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/SAOeYHBHul2YtsRmMbh4r4W4oFry5DWEF7i1RAXUI=;
        b=L+NJzPKGz1MdczOWV22R6U54LlMY+bl0xrDcbHO0T28Qu3cOLwRGSU4nMc65129acN
         vcAAhCyaGtX2hLgX0Ev/c5V1EA+p0Ao2U/5Se0MXOuFnW1rw0/eGfiv5dUDoeB0ScPtk
         t7u3Yb0C3xZyU+bWfu9J3Y9pFn1cCNHW3WyT4X1kEKdKW8w3ozUwS+pd6pRWsNX2z1Hc
         koW1ZK0Y49eIQvhpgM053vX+FB9PU4a/kUEpv+B519zi7czDkfXZumk7Vgez4xhHj10Y
         7/BTJ5qqKzrsggCN+waRz9b8S0JQyn3r5z/nWipdCZrJEJlGZnLHHSCZrXQcT1dIOvz4
         svvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684370509; x=1686962509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/SAOeYHBHul2YtsRmMbh4r4W4oFry5DWEF7i1RAXUI=;
        b=J3GMQ1snrL2sX4GARZYTJv5STpI11U4WYtpdu0ZBEFV7p7Mr9x3qtsMFmsFr0j4vdD
         53Ewt/QiJUTD1iflc6yVXHNCW0IW28ThA7ua5ZVSCpmL2mNGFqxbXpkyOjNbUHlFpatZ
         oaPz1V02xPemwlkO3qX3XFJrMLvEhdH2u3d6NvPbtji0WY7yUOiAt2rR2N6hLo1TVyTn
         LRgtUCVyraXG/GZn17GXWa0hv/uA+3nqh1Ln50s0Op5rbAorTlvXwCMiGNiMwQL0IE1q
         cPQljSeqQhHhGId06XEGFSOkrf2PAPUeYjaGOz2+PGemVeK5NYCHowJq7ZraGlXFRYzg
         fgWw==
X-Gm-Message-State: AC+VfDxRl2m+z36dCROm6kp2+fP/3TYzenqAEasjxenUXA9t+SL54xyR
        8JYnAn0Wbvipj8VVF7/XEc6KvQ==
X-Google-Smtp-Source: ACHHUZ5aIzgk3m2o2IAObDgBGBCFuMq+3fPLj3I+rqm3HSPD1nGHTudoS5AbICudL3F6m64hdFKduw==
X-Received: by 2002:ac2:44cc:0:b0:4f3:7a01:f0d6 with SMTP id d12-20020ac244cc000000b004f37a01f0d6mr708575lfm.67.1684370509364;
        Wed, 17 May 2023 17:41:49 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d7-20020ac244c7000000b004eb12850c40sm68157lfm.14.2023.05.17.17.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 17:41:49 -0700 (PDT)
Message-ID: <5db3bc67-9ef2-b97e-0eab-77460bc2b5c0@linaro.org>
Date:   Thu, 18 May 2023 03:41:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm8550: Add missing RPMhPD OPP
 levels
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230517-topic-kailua-rpmhpd-v2-0-3063ce19c491@linaro.org>
 <20230517-topic-kailua-rpmhpd-v2-3-3063ce19c491@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230517-topic-kailua-rpmhpd-v2-3-3063ce19c491@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 23:12, Konrad Dybcio wrote:
> We need more granularity for things like the GPU. Add the missing levels.
> 
> This unfortunately requires some re-indexing, resulting in an ugly diff.
> Rename the nodes to prevent that in the future.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 40 +++++++++++++++++++++++++++---------
>   1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 6e9bad8f6f33..1c9460dc3d44 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -3608,43 +3608,63 @@ rpmhpd: power-controller {
>   				rpmhpd_opp_table: opp-table {
>   					compatible = "operating-points-v2";
>   
> -					rpmhpd_opp_ret: opp1 {
> +					rpmhpd_opp_ret: opp-16 {
>   						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
>   					};
>   
> -					rpmhpd_opp_min_svs: opp2 {
> +					rpmhpd_opp_min_svs: opp-48 {
>   						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
>   					};

It might have been better to split this into two patches (one to rename 
existing opp, another one to add new opp nodes). Nevertheless:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

(if for some reason you send another revision splitting this patch, feel 
free to keep the RB tag).


>   
> -					rpmhpd_opp_low_svs: opp3 {
> +					rpmhpd_opp_lov_svs_d2: opp-52 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
> +					};
> +
> +					rpmhpd_opp_lov_svs_d1: opp-56 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
> +					};
> +
> +					rpmhpd_opp_lov_svs_d0: opp-60 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
> +					};
> +
> +					rpmhpd_opp_low_svs: opp-64 {
>   						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>   					};
>   
> -					rpmhpd_opp_svs: opp4 {
> +					rpmhpd_opp_low_svs_l1: opp-80 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
> +					};
> +
> +					rpmhpd_opp_svs: opp-128 {
>   						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
>   					};
>   
> -					rpmhpd_opp_svs_l1: opp5 {
> +					rpmhpd_opp_svs_l0: opp-144 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
> +					};
> +
> +					rpmhpd_opp_svs_l1: opp-192 {
>   						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
>   					};
>   
> -					rpmhpd_opp_nom: opp6 {
> +					rpmhpd_opp_nom: opp-256 {
>   						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
>   					};
>   
> -					rpmhpd_opp_nom_l1: opp7 {
> +					rpmhpd_opp_nom_l1: opp-320 {
>   						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
>   					};
>   
> -					rpmhpd_opp_nom_l2: opp8 {
> +					rpmhpd_opp_nom_l2: opp-336 {
>   						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
>   					};
>   
> -					rpmhpd_opp_turbo: opp9 {
> +					rpmhpd_opp_turbo: opp-384 {
>   						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
>   					};
>   
> -					rpmhpd_opp_turbo_l1: opp10 {
> +					rpmhpd_opp_turbo_l1: opp-416 {
>   						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
>   					};
>   				};
> 

-- 
With best wishes
Dmitry

