Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A867028F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbjEOJjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbjEOJio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:38:44 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E15359C
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:36:18 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac785015d6so131354011fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684143374; x=1686735374;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4imH+QKqyExRfuItA/L09H0HIV4Xd3BIqtl3lBoJ7/w=;
        b=qgGy5RuG4cWM4hsOv3c3+R5wyP1RuIStQcRarr3mmPWsBksbvULFY2lhHm3PQvnrAh
         OQBoc12S1HXXb2iiZzQdw2TQ3gg9eZuMhJaFYb8+4REwaJX6y3icxQJrNuj/OgK3HTl5
         vksqIQiN21bfIodjNci7GOohHhz6RMDPSFLYXvZDRY77ki1mYOOQ5tbC0Oh2XzL+/Jf0
         1OJA9g9b4IqDpD7f0QOLKvx4oHTzKnYJMvoO477V7UFZ38zpejVLfEm1w9Jp6PGWxEzr
         KYmUbVEGj8x6g9pq1DA8ffEwk7yOFi+SfY6jgMoIRcv8k4JU34nzscfVOo1eVMEFL/+u
         jhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684143374; x=1686735374;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4imH+QKqyExRfuItA/L09H0HIV4Xd3BIqtl3lBoJ7/w=;
        b=PlTsAGq4frzzJBSJiCBtmXeQQPWfGojhCYM/PcJwj6xbcTlhqhww/bDeZ4SxDA5upJ
         6XsdIutkTu2y2WcMav3YLY+tudnBUFEJagBisBfe9f/0IT1qIUr77jpnImAx0H23Zm7L
         WZipcMpkyp9LXTXStKLHO0b3D2Lz3LD++pPEQ7Y4Bxi4Fc7mqdWioBPGebChULrsSu02
         8WbjWN5JPiXbm8zwXIh0YCWjFhcjzSCNO/AV2UXWgWpAKsgIK2T+f/496QW5uPjmMIeX
         lbqpR4NGoXzlcSc8cH01Uvzggwr9hcU5Ri54SXwzYuOC9rW0eYrsIm6wVW5N05O5PmGr
         4doQ==
X-Gm-Message-State: AC+VfDwS6smHzOQsfGsr48iUMSIeKKJxbwFQo9XMIMPIu64Mbz9JMxWd
        GF6F2hz/vJQdayy5XaC21SU+QQ==
X-Google-Smtp-Source: ACHHUZ4E7xXXyCa9CZNxcMtbRVuPoMWzHuNIk6pR/Q95FYnG5BmjT9792nBXdG2kidVfZwFCfubQtw==
X-Received: by 2002:a2e:93cd:0:b0:2ad:dd61:ff74 with SMTP id p13-20020a2e93cd000000b002addd61ff74mr2588284ljh.23.1684143374205;
        Mon, 15 May 2023 02:36:14 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id n21-20020ac242d5000000b004ec8b638115sm2527560lfl.193.2023.05.15.02.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 02:36:13 -0700 (PDT)
Message-ID: <c6bcbf6b-2fa0-a6bb-a44c-6b0bd84e194f@linaro.org>
Date:   Mon, 15 May 2023 11:36:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: drop redundant unsigned >=0
 comparision
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230513112913.176009-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230513112913.176009-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.05.2023 13:29, Krzysztof Kozlowski wrote:
> Unsigned int "minor" is always >= 0 as reported by Smatch:
> 
>   drivers/soc/qcom/rpmh-rsc.c:1076 rpmh_rsc_probe() warn: always true condition '(drv->ver.minor >= 0) => (0-u32max >= 0)'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
I can see how it made sense from a human POV, but then it still
does with the right hand side removed..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soc/qcom/rpmh-rsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index f93544f6d796..0dd4363ebac8 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -1073,7 +1073,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
>  	drv->ver.minor = rsc_id & (MINOR_VER_MASK << MINOR_VER_SHIFT);
>  	drv->ver.minor >>= MINOR_VER_SHIFT;
>  
> -	if (drv->ver.major == 3 && drv->ver.minor >= 0)
> +	if (drv->ver.major == 3)
>  		drv->regs = rpmh_rsc_reg_offset_ver_3_0;
>  	else
>  		drv->regs = rpmh_rsc_reg_offset_ver_2_7;
