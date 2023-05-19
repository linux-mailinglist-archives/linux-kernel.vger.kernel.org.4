Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F34709CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjESQuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjESQuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:50:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBF61728
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:49:43 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f27977aed6so3906041e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684514972; x=1687106972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UoJqhyAehxEE8IzaFRIjwy7At/aHaz/mTctqSYW77Ps=;
        b=edZnk59vtfRbVveJW2Wp7hxu7rzwL1wnB+YDKUqq4hKRd2VdeZI2yP378Vj3kuFqsh
         VxjCFat5uj4kxcEpT53TmNB96Ncls5iM9FLgv6mTudpfWB8GGcU3H/lu99jI4SsqARFc
         ioQqwbILjLlp7vnn4/owvL0tMktS4uZAeiQkOFAPnoT7kvzUDWD3QcLLV4+8vmyr3P7m
         XjscQl4J5yVQyQ/ud2zAXPfEGyuvpHv2InLiHWr4xLYz7NJ8qFYS6GwZoSR+xvXW/7oo
         brib1WAlbgxW1BKegRzYspZMMKf4sRG+8AEfDMhEL1SQdYlqRk/vuICeYvhZ+2GePNHr
         D4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684514972; x=1687106972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UoJqhyAehxEE8IzaFRIjwy7At/aHaz/mTctqSYW77Ps=;
        b=KFg4bVCd+uaCphXH0dxBYNrX6A6NrbNXoNlfL7K3Cbf5SIvS8HVtqHh/JQtUG78GMb
         YbVos5a/hwC5Ogm3JzRCJUQZdK9dOCdraZ+VwWEmceIqNkd40Gxc0yZGeIZdKNA2cImH
         yND046xWQPapby83cbDttWj/iNlN5sAsdEDLVlW5Jz5w3Jk9ticpDtjQwVDs7X0YuWyH
         rkW8KaCA1tOgEOzgeA0VmGSYaet92bxIeSheTS+KIQSdS63sPESowIuksUHXjRvZeqDt
         prebF9iSGjoJ0X8Ra3TjgHrRyOLA4T0v1TacC55EYfXJLF/Q/+c8q9Hyoo60dKWvhj30
         1+7Q==
X-Gm-Message-State: AC+VfDwmRfWySbX8rq4LqpQr2wJonjLC0HOKFl/6LeCONLePLrwtMb/R
        uMI/+Zib/QxH1EXohQ3wj3/XJqFkcJsXajRiKug=
X-Google-Smtp-Source: ACHHUZ5prLsQF0d2sfE7FXa53jb99u03XPIwvFMjNKmBLZeFPS/8GhrY3PXVAmZjOBdUdeG+ybqqUQ==
X-Received: by 2002:ac2:4556:0:b0:4f1:5015:43c4 with SMTP id j22-20020ac24556000000b004f1501543c4mr1073151lfm.38.1684514972574;
        Fri, 19 May 2023 09:49:32 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id q25-20020ac25159000000b004efe8991806sm668958lfd.6.2023.05.19.09.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 09:49:32 -0700 (PDT)
Message-ID: <e62200fb-2398-dcd0-0b25-afa94942bae6@linaro.org>
Date:   Fri, 19 May 2023 18:49:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] clk: qcom: clk-alpha-pll: Add support for rivian ole
 pll ops
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
References: <20230519155602.6642-1-quic_jkona@quicinc.com>
 <20230519155602.6642-2-quic_jkona@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230519155602.6642-2-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.05.2023 17:55, Jagadeesh Kona wrote:
> Add support for rivian ole pll ops and ole pll registers to
> configure and control the rivian ole pll.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/clk-alpha-pll.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
> index 4d9b6d5b7062..e6df398bee6d 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.h
> +++ b/drivers/clk/qcom/clk-alpha-pll.h
> @@ -24,6 +24,7 @@ enum {
>  	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
>  	CLK_ALPHA_PLL_TYPE_LUCID_OLE,
>  	CLK_ALPHA_PLL_TYPE_RIVIAN_EVO,
> +	CLK_ALPHA_PLL_TYPE_RIVIAN_OLE = CLK_ALPHA_PLL_TYPE_RIVIAN_EVO,
This makes sense

The rest is just sugar syntax, I don't think it makes sense to keep
adding meaningless defines..

Konrad
>  	CLK_ALPHA_PLL_TYPE_DEFAULT_EVO,
>  	CLK_ALPHA_PLL_TYPE_BRAMMO_EVO,
>  	CLK_ALPHA_PLL_TYPE_STROMER,
> @@ -181,6 +182,7 @@ extern const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops;
>  #define clk_alpha_pll_postdiv_lucid_ole_ops clk_alpha_pll_postdiv_lucid_evo_ops
>  
>  extern const struct clk_ops clk_alpha_pll_rivian_evo_ops;
> +#define clk_alpha_pll_rivian_ole_ops clk_alpha_pll_rivian_evo_ops
>  #define clk_alpha_pll_postdiv_rivian_evo_ops clk_alpha_pll_postdiv_fabia_ops
>  
>  void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
> @@ -202,6 +204,8 @@ void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regma
>  			clk_lucid_evo_pll_configure(pll, regmap, config)
>  void clk_rivian_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>  				  const struct alpha_pll_config *config);
> +#define clk_rivian_ole_pll_configure(pll, regmap, config) \
> +			clk_rivian_evo_pll_configure(pll, regmap, config)
>  void clk_stromer_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>  			       const struct alpha_pll_config *config);
>  
