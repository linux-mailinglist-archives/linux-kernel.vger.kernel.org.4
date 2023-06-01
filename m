Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97C77198BA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjFAKOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjFAKNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:13:08 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99231BD3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:11:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f3b39cea1eso702985e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614280; x=1688206280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0EutEtUlaihGOUpNEbgEBes28fbf5E3F3e4/FdOjCc=;
        b=fn0ZXO6khFqmtQby2jEWTpRQCd+n7hAb5cPmaSCpGfMTYqsAM+8FFPC6ufvohBRanx
         GrKXtyLZPGNgCjPhEyUyl7d8Jm9odVjsJniezIIiBvMJG8x/E1xrLZLnpyDIDOoltLvX
         UxemvroY+1nu0kZJFbi3CR4NrZn77jbYQGcDuflCQE08ccf7Vo8xJctUBxfpYzON8tfZ
         uRkPZuuPOb0DUVIpT1x0ur7JS1xwWtJIGCfFovY+U3LQC+npj/hlM90f7BvhwSara1CT
         C4g7U8Mefs1g27eTlUSEHqxihcVJuODyPZrG4VGvDZZnNwVmmIDQtUtpyiit4tXtFMDy
         qe2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614280; x=1688206280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0EutEtUlaihGOUpNEbgEBes28fbf5E3F3e4/FdOjCc=;
        b=J3un79bdGFYg/nKv+lDcomR73xIXtth88+D1qoU579Yo4RnzGpHryqBQoqEeC059se
         z5nGhzZ6L2nwL23wgyhm+kAg2wDfNexSk/6kSJJs8TSJNdOvTntHYeTJDzgZ31fo5B4C
         P5mzhm8LxB1VkbgojkzwsqkO81EMeokBMRX2dgYbtnCUahDwWUnyCqM1zNMw4cfobviZ
         1Zb1ghVRQ9bt6aGD12EBeqkwzzkxN2NR3sBQSFr9jsusGmB8HEt/eS6QGAXHfngHGlrA
         afVjwyWMRsxUGaKe7ij+PrbZlTgZZD4n1pkY1/wk3/u1161a7WrHctZtUBFzs7OacE6v
         hQeA==
X-Gm-Message-State: AC+VfDwbxErg280eVnQnSiy+FBm49w11U0WLYpcIlCjC8g0j+nW5WjGl
        YRKB9j+swy8lHVh8xKwtp7wcUALSC6sVPDr7eJI=
X-Google-Smtp-Source: ACHHUZ5JYhRGJi1iagoXEofCxIsDTHFigDWsXEwXZ8RRZ2iRl/lv9p/dOGBCXY71bwfXZDzpJ1u21A==
X-Received: by 2002:ac2:4115:0:b0:4f1:3d7d:409e with SMTP id b21-20020ac24115000000b004f13d7d409emr1027466lfi.0.1685614280471;
        Thu, 01 Jun 2023 03:11:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id p9-20020ac246c9000000b004f256fed9e8sm1036600lfo.145.2023.06.01.03.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:11:19 -0700 (PDT)
Message-ID: <1d3c05f5-c1bd-6844-1788-8df0b863a02e@linaro.org>
Date:   Thu, 1 Jun 2023 12:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8550: fix low_svs RPMhPD
 labels
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230601-topic-sm8550-upstream-dp-v2-0-e8778109c757@linaro.org>
 <20230601-topic-sm8550-upstream-dp-v2-2-e8778109c757@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-dp-v2-2-e8778109c757@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 12:09, Neil Armstrong wrote:
> "low" was written "lov", fix this.
I "lov" making typos.. Thanks for spotting this!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Fixes: 99d33ee61cb0 ("arm64: dts: qcom: sm8550: Add missing RPMhPD OPP levels")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 75cd374943eb..972df1ef86ee 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -3649,15 +3649,15 @@ rpmhpd_opp_min_svs: opp-48 {
>  						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
>  					};
>  
> -					rpmhpd_opp_lov_svs_d2: opp-52 {
> +					rpmhpd_opp_low_svs_d2: opp-52 {
>  						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
>  					};
>  
> -					rpmhpd_opp_lov_svs_d1: opp-56 {
> +					rpmhpd_opp_low_svs_d1: opp-56 {
>  						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
>  					};
>  
> -					rpmhpd_opp_lov_svs_d0: opp-60 {
> +					rpmhpd_opp_low_svs_d0: opp-60 {
>  						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
>  					};
>  
> 
