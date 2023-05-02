Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561686F432E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjEBL5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjEBL5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:57:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28CA4EFA
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:57:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f127b10140so1006055e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683028630; x=1685620630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umAaLbyKBA92txDJzNJOzuf/4S23z+JegEgf5agHmrc=;
        b=n8KzRLz/k3FUfgdkh0fNui5N09Q2XHI9DP4vauwxVdeOPsEXhLwBbc2hYEm9s7x839
         ww5hS11j/4pZ0Zn8uliVpMxWKKqxEgKDAgm+vnhyAETkBBQeXvRl6jJVk6VVPXNMmI5r
         ocddjbgFTH6vH5lieuOglYpvFexig/298tl53UMDkaB6SAAD38ce6KHp3G1TYL7dep2a
         G5IIsEUaGLoOf2c7U3zVT2em3Q7UWBYlGbPK9abpjpYfK23YAxI69ZZzPnzqI6WE45wK
         vD62rRemo6cMfB46+dbDfT0+7EI4nu9mevVq5/GK0ZTgI59QP2c8gw72HB3yMLqFErxj
         Dm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683028630; x=1685620630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umAaLbyKBA92txDJzNJOzuf/4S23z+JegEgf5agHmrc=;
        b=d3H5sq2Lb5j78G+sTWqwJVOmiS2DVAYiFucBtxF2lVQNEiUaoqfMd2QnaHf3gwRMaO
         DENufCyROiKOrdqVpOz06h9/wD8FTPzuZJC/Ylo7lZdi33QvP1FbZDQc51e3r99nkvuO
         N8Vz4NQN1URB3HUwpUyKetB/OmB53VSLJQ8Z+1vbTnWuTWqXEt4ZvNgXwZqOgioD6h2B
         dbH2ovHa1A5tQhPMHnoiVMapYojZK+PV51dxmsOFnPYIRN4U+BoybORHMTzQQRn+CWQ0
         Dl4+nVfCqGG1a7yvTthZPyfJQfyq+LzcLwn3BM4xjMnZTW+Ah2bQc6Peg5fiWbXKbqbg
         NolA==
X-Gm-Message-State: AC+VfDzD7nUViynDqaAIxDh2fEKmSuTK/rQ0+zutoeACYvuelvTAJJfX
        mx31egieGnO3uI/fgka1mw/RxQ==
X-Google-Smtp-Source: ACHHUZ7tHLyCn750BxcAGjoo8KUW6w0zz68rv0kK4wZQO/lI5qTklyl+MUbJu20qubT/0Cr+1Ix8xQ==
X-Received: by 2002:ac2:4103:0:b0:4ed:d584:d1f4 with SMTP id b3-20020ac24103000000b004edd584d1f4mr4707916lfi.10.1683028630191;
        Tue, 02 May 2023 04:57:10 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id c5-20020ac244a5000000b004d5a5d90d83sm5325679lfm.60.2023.05.02.04.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 04:57:09 -0700 (PDT)
Message-ID: <3b84361e-fba0-3551-be55-474495f02a01@linaro.org>
Date:   Tue, 2 May 2023 13:57:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: qrb4210-rb2: Add SD pinctrl
 states
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        devicetree@vger.kernel.org
References: <20230501105832.1185477-1-bhupesh.sharma@linaro.org>
 <20230501105832.1185477-2-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230501105832.1185477-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 1.05.2023 12:58, Bhupesh Sharma wrote:
> Add the default and sleep pinctrl states for SDHC1 & 2 controllers
> on QRB4210 RB2 board.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> index dc80f0bca767..5a5294cc6e45 100644
> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> @@ -190,6 +190,10 @@ vreg_l24a_2p96: l24 {
>  };
>  
>  &sdhc_1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc1_state_on>;
> +	pinctrl-1 = <&sdc1_state_off>;
property-n
property-names

Other than that:
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +
>  	vmmc-supply = <&vreg_l24a_2p96>;
>  	vqmmc-supply = <&vreg_l11a_1p8>;
>  	no-sdio;
> @@ -200,6 +204,10 @@ &sdhc_1 {
>  
>  &sdhc_2 {
>  	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>; /* card detect gpio */
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_state_on &sdc2_card_det_n>;
> +	pinctrl-1 = <&sdc2_state_off &sdc2_card_det_n>;
> +
>  	vmmc-supply = <&vreg_l22a_2p96>;
>  	vqmmc-supply = <&vreg_l5a_2p96>;
>  	no-sdio;
> @@ -216,6 +224,13 @@ &tlmm {
>  			       <49 1>, <52 1>, <54 1>,
>  			       <56 3>, <61 2>, <64 1>,
>  			       <68 1>, <72 8>, <96 1>;
> +
> +	sdc2_card_det_n: sd-card-det-n-state {
> +		pins = "gpio88";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
>  };
>  
>  &uart4 {
