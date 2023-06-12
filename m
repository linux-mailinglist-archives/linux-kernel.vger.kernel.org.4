Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69B272CBCC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbjFLQvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFLQvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:51:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D681B8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:51:01 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f63ea7bfb6so5143722e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686588660; x=1689180660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bc2XJlWre4e2gBDTdr+40bFjaee8RTH5UZuMdlZsuEU=;
        b=eZRgWXqo4hq6/oz9ha7x5zEK9V63CWuGLWH1lCsWH+9SQalC9QrdW9+Z8Sm1vPaZQW
         zjNDfoE6ARzQMwD+LgcM11ZFKqNHjtoz+e6al+L+ysHRyViWSg9iEGWzZDxB3xHFSiAL
         YyQ7LU2QpfIixZ3vpyayhXQh+zlMwNl/Vuk1TEiBH7bWjHFTRbVcVAfCeCygiqzO3BXU
         HdOIrIvijxV28fZ/XvnLZHMiz0XOdVl3768Q6DVJ/Zp68oUbRDTUzMEw17/bABFys7pQ
         OSG5P2bTuU7z6msDQPCa4G7wqBEjVeeirRTCPaUG9r3ebjQdOhvysO5ex8DjjOzNDAmz
         XoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686588660; x=1689180660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bc2XJlWre4e2gBDTdr+40bFjaee8RTH5UZuMdlZsuEU=;
        b=EkROtIdKiz6C7pd77jpxOtxyGAv0i7ewT5X5yj35YVPzYihyUDTUhpiOIHQxXqjSmA
         jGfITamrRFS7H2HB0je73hkDElctqbXB1Kci7PjBWSW8IUnp/PB+LdPQ5lZbx1T+iynB
         oG7rzBFWFJL/x1NayLbW8we82njyiKdP5IamvlS3n0s99l+FXZeyaub12wqD49EHj/VY
         VcksuQ3ESVh1D0qfrUeGbtvdrj6HtGzDNaAPX/eihJAXBIdhg3VWUxTjfHFXHdbKLqH5
         bZ7/6aatfj4h9Cv3z7r45cZuO3FJpo+Tcu3uIqbNgTdHBmzpjJRJ6dSI7DgTgewSZ048
         4nnQ==
X-Gm-Message-State: AC+VfDwdWKJl17GY8OfnKSBSfVkYEudDl3lsVjRH479rg49yszWbBZLl
        k4zeeZ8XlInzScxfdjmIPlG1Fg==
X-Google-Smtp-Source: ACHHUZ6EkKBZ+W8P5v+lv3YaBBS6PyGdorCb5izxLPIOXCqPw9kHf6veSA7sPnKJFqZWW7ZxSuYXRA==
X-Received: by 2002:a19:5f1c:0:b0:4f3:a69e:1d80 with SMTP id t28-20020a195f1c000000b004f3a69e1d80mr3863304lfb.0.1686588659862;
        Mon, 12 Jun 2023 09:50:59 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id j4-20020ac253a4000000b004f262997496sm1479085lfh.76.2023.06.12.09.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:50:59 -0700 (PDT)
Message-ID: <ce7c4402-b58e-b5df-c864-9f1a959132d0@linaro.org>
Date:   Mon, 12 Jun 2023 18:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: sm8550: fix low_svs RPMhPD
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
References: <20230601-topic-sm8550-upstream-dp-v3-0-5f9ffdcb8369@linaro.org>
 <20230601-topic-sm8550-upstream-dp-v3-1-5f9ffdcb8369@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-dp-v3-1-5f9ffdcb8369@linaro.org>
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



On 12.06.2023 17:26, Neil Armstrong wrote:
> "low" was written "lov", fix this.
> 
> Fixes: 99d33ee61cb0 ("arm64: dts: qcom: sm8550: Add missing RPMhPD OPP levels")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
https://lore.kernel.org/linux-arm-msm/1d3c05f5-c1bd-6844-1788-8df0b863a02e@linaro.org/

somebody forgot to run `b4 trailers -u` :P

Konrad
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
