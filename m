Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0A3750505
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjGLKps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjGLKpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:45:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2209A11D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:45:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so755160e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689158742; x=1691750742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iluNBERrBjXO7viewBM4iboX+U1uFRVZxXXClRgfNCw=;
        b=Z1sbslDV8zdM6KBWk5KXyl3J6twmx3R1OPARE99BHK/YM3t3c5PljYiM+1L83AtAI4
         JJmFzviXLH1GyoODqOjIm9bH56Y0tXEyXvwEFwZcp7HSD9ZyI3Q1/wtV6Ld8jC6IVLkQ
         N+mUBDJv010LlmfLUhlINlyu75SiorVSTdrt7ajVGHXwtxJBDAgVZBwFeuWp/b0cioqP
         AERXfEM/AWu99L1SApTkWpkYX9hG3DaMoYZknERGU8EulrVFxFimARshlGa88YdOzuv4
         wE1jMK94f7t7jSIbTTI/I/VUNBngH6PYrYpMIG5jdlRKN2T34AlvTM6BikeoieKWuFU6
         dQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158742; x=1691750742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iluNBERrBjXO7viewBM4iboX+U1uFRVZxXXClRgfNCw=;
        b=Q88DL+a/qdkrLgMK5IUmATdbXdDMVF1cRWs60HQprHWtY8Wn4TmUWSxyCp4uZPLPUU
         +Jg6J/96Dm9vbtNdWyNbnMO48gwKNv7L11q1WSG8tdh/P4P6HmKqYL11+8vm8xri6dlX
         P5zY29izMvjYjUtxYg/pgBxd9KdkXQ6ZIMaY0Ex3iE0qklviJAktzSMD0DMLPSsUJ7Do
         ew+7K2gEdjh4SCbhLLZXp+i6X1QIT7i1bB7Sww/Y90oee09sNIWgvHi9QS8m8GwG2dhi
         p9FErJX+cson7qr4/uQJ9tGzxMuyR9llJI1dplv0vwB47pxiDm8v4ApPSasihRjoEPjd
         dAwg==
X-Gm-Message-State: ABy/qLaXhUVX5NcaHni/egtj5a0itujYtoVq1mSQXg4IC8rTgzYyWCkQ
        fOmQW2wv0Qx+k8yfT4FV/zyG5DjHRd5GLuRIdrpoOQ==
X-Google-Smtp-Source: APBJJlHf07xhixZLZZuWiKRbPJfrFDADrlIdqd0QHXjd61oMSM3617q0gcTG4KvBepD1X1f7HfUpjA==
X-Received: by 2002:a05:6512:5d3:b0:4f9:56a5:81d0 with SMTP id o19-20020a05651205d300b004f956a581d0mr518007lfo.24.1689158742354;
        Wed, 12 Jul 2023 03:45:42 -0700 (PDT)
Received: from [192.168.1.101] (abyk15.neoplus.adsl.tpnet.pl. [83.9.30.15])
        by smtp.gmail.com with ESMTPSA id i13-20020a056512006d00b004f73eac0308sm652425lfo.183.2023.07.12.03.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 03:45:42 -0700 (PDT)
Message-ID: <4cc0156e-4324-9f15-089e-9946148753c9@linaro.org>
Date:   Wed, 12 Jul 2023 12:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/14] arm64: dts: qcom: sdm845: Fix the min frequency of
 "ice_core_clk"
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-5-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230712103213.101770-5-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.2023 12:31, Manivannan Sadhasivam wrote:
> Minimum frequency of the "ice_core_clk" should be 75MHz as specified in the
> downstream vendor devicetree. So fix it!
> 
> https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.7.3.r1-09300-sdm845.0/arch/arm64/boot/dts/qcom/sdm845.dtsi
> 
> Fixes: cc16687fbd74 ("arm64: dts: qcom: sdm845: add UFS controller")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Would it make sense to move the ICE to the new bindings instead?

Can sdm845's ICE also work with the sdcard slot?

Konrad
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 9ed74bf72d05..89520a9fe1e3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2614,7 +2614,7 @@ ufs_mem_hc: ufshc@1d84000 {
>  				<0 0>,
>  				<0 0>,
>  				<0 0>,
> -				<0 300000000>;
> +				<75000000 300000000>;
>  
>  			status = "disabled";
>  		};
