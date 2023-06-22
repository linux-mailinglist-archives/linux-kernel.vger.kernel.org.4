Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36FC73A054
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjFVL7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjFVL7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:59:50 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7521E269D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:59:29 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b46bfa66d2so78316371fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687435151; x=1690027151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gfvgZtBkZSYhAfc+yGsnMs5vDVoQLGwn02xQquywfI=;
        b=A9Z5XrleFtxkeWPhM2xA/Z2/jXfRPUADuhZ/tkXK/G/ZKJw72GNOpeNhOdHHCoMN7/
         8sZoXuz+4QjJVRNr9fXLXzjqh7EyIeN+f7smrzNreQTurrM7f9aREX9n7RCyKnekSnFG
         FZsbixXXoNBT84hqoMwneqhkcDZIf0/yCLCm+EB1HYM+FBeLZHmAXHl9azBj8NgPbsMU
         RtGQX4QfdEwNSieila3owtChaA5jfM0QvDTnWFYnDW2nVa8ejQmxtXSfQjShatwx0BKq
         dgECufe67JL7zmv2a504Q+YPj29ymfRJnPl5AHp4jV4qSPqRyRVcHozjqdcK/1CQJCUD
         5ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435151; x=1690027151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gfvgZtBkZSYhAfc+yGsnMs5vDVoQLGwn02xQquywfI=;
        b=HEtYZ+pY9mKKDAopmycLc/0SKRLeyNYGpmfpAZr0zjIa2Ao2Yi7FQMIQga7Hf4Qrxc
         zrdfu2cZyH+EEfA6mwbPUfgILTHojOjawk6Ow+c/A8KzLpJxhGw6jzGKkNln4vM7TuJB
         1HYwC5fLci1RJ6BBSVbweeSX6SnPzNwDfkrVdWcdyIoGCZ2pNXsLZ1YHeaHum90Y5Na0
         xxQehfNMA7VdpYh6WOmnacVk0THXqdZRNOG3lGs8H/ywcVAcvVGxDZARaZYhN5kiEqzR
         Bk6/u3p10hihQGTxj9MdMZi5hnQSNTO9UPJ4iMKhRF0al8U37v4r9SLYhhgdPasGpCy4
         PQQQ==
X-Gm-Message-State: AC+VfDzOhXlXj/GIZ9++sPffb6c33ZZjfmb2cVkV8Hzy6tUJvefNakzA
        dt1s21Grp8jnxAkG70pyoNmhJQ==
X-Google-Smtp-Source: ACHHUZ4F1bF1UmUqlJE6VAJv5piLov6ByvxQd9nP8EQ0RxH3bU96LJw9NdAhvH0NxtD8GWthjv3OXg==
X-Received: by 2002:a19:381b:0:b0:4f8:5713:4400 with SMTP id f27-20020a19381b000000b004f857134400mr9925242lfa.1.1687435151334;
        Thu, 22 Jun 2023 04:59:11 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id u22-20020ac24c36000000b004f857bdbb26sm1100686lfq.30.2023.06.22.04.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 04:59:11 -0700 (PDT)
Message-ID: <cd7564a3-8cd8-4535-07ee-60c1d2b0e321@linaro.org>
Date:   Thu, 22 Jun 2023 13:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/9] clk: qcom: gcc-msm8998: Don't check halt bit on some
 branch clks
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
 <20230622-topic-8998clk-v1-6-5b7a0d6e98b1@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230622-topic-8998clk-v1-6-5b7a0d6e98b1@linaro.org>
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

On 22.06.2023 13:57, Konrad Dybcio wrote:
> Some branch clocks are governed externally and we're only supposed to
> send a request concerning their shutdown, not actually ensure it happens.
> 
> Use the BRANCH_HALT_SKIP define to skip checking the halt bit.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
Whoops. Again, right after hitting send, I noticed this one was already
sent with 

https://lore.kernel.org/linux-arm-msm/20230531-topic-8998_mmssclk-v1-0-2b5a8fc90991@linaro.org/
>  drivers/clk/qcom/gcc-msm8998.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
> index cccb19cae481..ef410f52f09f 100644
> --- a/drivers/clk/qcom/gcc-msm8998.c
> +++ b/drivers/clk/qcom/gcc-msm8998.c
> @@ -2112,7 +2112,7 @@ static struct clk_branch gcc_gp3_clk = {
>  
>  static struct clk_branch gcc_bimc_gfx_clk = {
>  	.halt_reg = 0x46040,
> -	.halt_check = BRANCH_HALT,
> +	.halt_check = BRANCH_HALT_SKIP,
>  	.clkr = {
>  		.enable_reg = 0x46040,
>  		.enable_mask = BIT(0),
> @@ -2125,7 +2125,7 @@ static struct clk_branch gcc_bimc_gfx_clk = {
>  
>  static struct clk_branch gcc_gpu_bimc_gfx_clk = {
>  	.halt_reg = 0x71010,
> -	.halt_check = BRANCH_HALT,
> +	.halt_check = BRANCH_HALT_SKIP,
>  	.clkr = {
>  		.enable_reg = 0x71010,
>  		.enable_mask = BIT(0),
> @@ -2151,7 +2151,7 @@ static struct clk_branch gcc_gpu_bimc_gfx_src_clk = {
>  
>  static struct clk_branch gcc_gpu_cfg_ahb_clk = {
>  	.halt_reg = 0x71004,
> -	.halt_check = BRANCH_HALT,
> +	.halt_check = BRANCH_HALT_SKIP,
>  	.clkr = {
>  		.enable_reg = 0x71004,
>  		.enable_mask = BIT(0),
> 
