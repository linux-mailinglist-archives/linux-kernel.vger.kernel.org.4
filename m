Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EAE71FD32
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjFBJKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbjFBJJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:09:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AF51B3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:08:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af1822b710so26029831fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685696895; x=1688288895;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4e3D8wbEggeQGIo2buFsWrZA498FNn9qdCy/c3SYEoI=;
        b=Lj8tg9L2//EmP7464jerxxGD595+r3ajL8bIgJlbTBM//lUZelSn2heRoIseqlIwmA
         n1DvV0j9ZVqn92pZeqJxkEm/q5R4ohwBzr8KLiI9bTy+vtYleq/S+M3BiC++AjqalbNp
         730Nd8FajEtYvZiXlNByu7qFyT5yRDjZ9Jx2iAPpZwJsejgrW4g5Qhs71WGKC2530SPg
         MRa1hfSN8TxYwzHl05w0ZkH16nUW/TgpyWIme0sw3ZoSvBWHY5vQNuGsusLsSWvqCMqD
         OBC/qPSBFRQyy/prk99jjd3s8Pf29zm6bu4nYTe9hMkr7RHiQ1pFYQwYuVundm1tfSaP
         666g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696895; x=1688288895;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4e3D8wbEggeQGIo2buFsWrZA498FNn9qdCy/c3SYEoI=;
        b=BD8J3wNBtqCJOz7IEZekS/uOonC85uwG1suYRjvE/9tEcbuTYBQG3PsOqERUJqkmoK
         Swmkey7xFMW3nf4EdyE0jmVrubzythJBpshFPbq6dlslysYTFsJC4cH5cOspGPQBa0P5
         E4uU8az2JWv7UZ1DojOPyNbibz2fKyry6GqXhzQqIa+l3538dmwUsiF844X+PyuxTY/N
         tfihA1Vok5BJYucN4RU3twZKiVjdp09GW5nIWy/hFXbdUYx/qLU3hVA2LpImvGmAbTw3
         of8qGModNWP5oF9VEKPdJDinWsZD5vnUms09gStH2Ms+98MiPvcpCF0PWXAt89h1Fidl
         Ue4Q==
X-Gm-Message-State: AC+VfDwU9uM3Xo6tAA5Z0BBHbMsQiWgJL29ByW0qx9iogjFfmOUcHHoY
        g+HRSqGpPvgzSgsLklWFzUr6IA==
X-Google-Smtp-Source: ACHHUZ4DmXCKy69G7/pkudz8CT8H8TcpLM9+ikGm3f+uy8F4re44Qhm1Bpee8jNZrBLkjGxdlNNOwQ==
X-Received: by 2002:a2e:3e07:0:b0:2ae:d269:5a1e with SMTP id l7-20020a2e3e07000000b002aed2695a1emr1264044lja.21.1685696894885;
        Fri, 02 Jun 2023 02:08:14 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id f14-20020a2e9e8e000000b002ad9057fd00sm148934ljk.85.2023.06.02.02.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:08:14 -0700 (PDT)
Message-ID: <9da3d4b9-ef0b-01ef-7819-850260f3ce08@linaro.org>
Date:   Fri, 2 Jun 2023 11:08:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 6/8] pinctrl: qcom: allow true compile testing
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
 <20230601152026.1182648-6-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601152026.1182648-6-krzysztof.kozlowski@linaro.org>
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
> Makefile selected Qualcomm pinctrl drivers only for ARCH_QCOM, making
> any COMPILE_TEST options inside Kconfig ((ARCH_QCOM || COMPILE_TEST) or
> (OF || COMPILE_TEST)) not effective.  Always descent to the qcom
> subdirectory to fix this.  All individual drivers are selected in
> Makefile via dedicated CONFIG entries, thus this should not have
> functional impact except when compile testing.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/pinctrl/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index e196c6e324ad..482b391b5deb 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -66,7 +66,7 @@ obj-y				+= nomadik/
>  obj-y				+= nuvoton/
>  obj-y				+= nxp/
>  obj-$(CONFIG_PINCTRL_PXA)	+= pxa/
> -obj-$(CONFIG_ARCH_QCOM)		+= qcom/
> +obj-y				+= qcom/
>  obj-$(CONFIG_PINCTRL_RENESAS)	+= renesas/
>  obj-$(CONFIG_PINCTRL_SAMSUNG)	+= samsung/
>  obj-$(CONFIG_PINCTRL_SPEAR)	+= spear/
