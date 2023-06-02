Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE15A71FCF1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjFBJCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjFBJBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:01:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0E91BB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:01:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f4f89f71b8so2410307e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685696506; x=1688288506;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwgsgMAg7oqkWKtA9ARjdycdp0sFv9de/hyXYAPV7fQ=;
        b=agFUrV6Ulcvygm1bLPR9dFf9IjnUJKRO8lR6DufrM09WFb2cmQQss9gOhx/5zHmU7M
         64iKFYoRW3p999QIImwOz7jMkPsH2TjlPVRE3twWsFwxSkQ+Lp6ALYC6taunvPIPEG1j
         S/loCqtWOm8rw310sU4Hb0houZP2Ko9sLG6yBkduhHQrhw9wlU5ePtHQ/oHB6Su30PR/
         fLXJFVomsmxj8KUkJPpRAM4w2ATm1EWXPCwUdmGvr6tcUy1FjnkInzjoMFsH4IM3vtct
         Am9YI6qeS15zK1wtsS0Ic/SPyfl13VgnyL1+Gr/JDWzr4suHq90s5MKIi8YgbfjEmeDu
         Ot8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696506; x=1688288506;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwgsgMAg7oqkWKtA9ARjdycdp0sFv9de/hyXYAPV7fQ=;
        b=Pt9VV9Le/zbq9dUxDaHtGsjgkeSWOVt0Mzejke1R6wDX+SDdxFHd64Cn3MyaAxhUW6
         t7kArrDfG9KR4FZfzBzzO781I7fMlguhYUgjVOy93bsIPybwaa4iKFjr8UkfqaL7U4c+
         kmGmV40M/Wd1rIJu8w2KYgBW2+3rSvwGOHmm38hiW9FGNtZDpyOPa7FGk29Z5OlpyBtM
         MQb0LSHCj/6CMQzGzRQsqrVtFYUZrYi2+m7+Em1OLexEpvpNW8ZqNzmLcCVeX8jtuscX
         PxkNAY1RvdcbeVDVtWI4WAzd6XlQ44QDJJjTv5I4oVvUeu4B0Fnx/7jz8q+l7xJOu873
         tnDw==
X-Gm-Message-State: AC+VfDwqFOZZy61WCtp7X78CKNH0kJ8RsTn1mVaztpfxRhvVN0N6iSQZ
        d/0Vz9STAkTOMQywiXtMrFpXyw==
X-Google-Smtp-Source: ACHHUZ6XMRORxk0H28KhaJr9QQvl9wz69kF0QV/iwPeAeAWOe8C8Jxn0/4LKz1MSZPwmFxye+3uxIg==
X-Received: by 2002:a2e:8057:0:b0:2a7:6f82:4a87 with SMTP id p23-20020a2e8057000000b002a76f824a87mr1146115ljg.35.1685696505796;
        Fri, 02 Jun 2023 02:01:45 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id t17-20020a2e9c51000000b002ac7a25c001sm146056ljj.24.2023.06.02.02.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:01:45 -0700 (PDT)
Message-ID: <a503ac0a-9123-0e47-f76f-e3674f1ca136@linaro.org>
Date:   Fri, 2 Jun 2023 11:01:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/8] pinctrl: qcom: qdf2xxx: drop ACPI_PTR
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 17:20, Krzysztof Kozlowski wrote:
> Driver can bind only via ACPI matching and acpi_device_id is there
> unconditionally, so drop useless ACPI_PTR() macro.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Oh I forgot this SoC existed... I wish I could play with it!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> index b0f1b3dc6831..b5808fcfb13c 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
> @@ -142,7 +142,7 @@ MODULE_DEVICE_TABLE(acpi, qdf2xxx_acpi_ids);
>  static struct platform_driver qdf2xxx_pinctrl_driver = {
>  	.driver = {
>  		.name = "qdf2xxx-pinctrl",
> -		.acpi_match_table = ACPI_PTR(qdf2xxx_acpi_ids),
> +		.acpi_match_table = qdf2xxx_acpi_ids,
>  	},
>  	.probe = qdf2xxx_pinctrl_probe,
>  	.remove = msm_pinctrl_remove,
