Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1701B6313D3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 12:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiKTL6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 06:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTL5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 06:57:52 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B625B870
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 03:57:49 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v28so8942467pfi.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 03:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3RC94dFUI9XuWDZS+NGRURpEncXuZJoI/k2VjqNqZI=;
        b=ceZA88J+EfDETft4atPPB7o4s+yW4eXgb9n7ZManZDLam0Xs+4lRTSFYTz7rfy8xjR
         m8q5VvYDCDo7MGKpSXEluyrAzRrNBlycx328NsJos698JmiU52EraCbEfjKwZ7724Gqc
         D6EQsSDT8x5XizKA/qFWPKco5E6G0xd+CbH0uPEogR55injV+bYsEaHN3ypnGvBSUcys
         72bnecA1nVRahh9J3gHMZNhc3sw+ERANpCF/oVUmwkTbk2oowEWLBaVSCvzp0ySj7OxL
         Ef5phQt9z+Eu0+uey5Xzx3ZCYTcZAfoWDXK8OlxzOjqnoB9eQTsMedo7sbM49fXCOQHi
         c/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3RC94dFUI9XuWDZS+NGRURpEncXuZJoI/k2VjqNqZI=;
        b=p96xzUEHXCORK3hztxci/VxnbvJUrJom+KUylJowRtTDfU6AvqP6RmbyCeRkSBPgbn
         kuCLdcyOdbmqrvevcYJYyN+PtyfM8UTphVHNNhCXTDgM+rqgy1b2ActD4i/EMAdIlIFM
         U13zgm3nYeBjKUH0kLFhGiDxwa42G5/YC5F1hLU4RSp++GND+goiy4UxwwgyfYJAUrVb
         Hku64NUxprfMbXOreyEIqm4dAgkNQkh+kEx4YLALc/i2NoPBLj3M+/z0xU9CHyLpgLKN
         evCul757+O+SF7k3sT0xom7xsuQvM6l3z/rH+cJwvhfX7tpHPqukjXjsM3vhRMTn42YJ
         HKMA==
X-Gm-Message-State: ANoB5pkNxYOzG2JBaQNgvdDcUpZKFTkRKdWPSoanQVkqkmHr/CQuI8CY
        KL2kE5scIyPyStJ9rxVfY3w=
X-Google-Smtp-Source: AA0mqf4DAqaDcQHxhuh1vhj+r5OYhMyv/vWyEbefjoViaNKEVxgAI0lR0wLESuVWEiER7YbEZT+nEg==
X-Received: by 2002:a63:4d5c:0:b0:46e:dc0a:ba96 with SMTP id n28-20020a634d5c000000b0046edc0aba96mr13927479pgl.419.1668945468431;
        Sun, 20 Nov 2022 03:57:48 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id w1-20020aa79541000000b0056c360af4e3sm6577412pfq.9.2022.11.20.03.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 03:57:47 -0800 (PST)
Message-ID: <bb94bd7d-0b65-a832-48e9-b1518719db51@gmail.com>
Date:   Sun, 20 Nov 2022 20:57:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] extcon: max77843: Replace irqchip mask_invert with
 unmask_base
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        myungjoo.ham@samsung.com
Cc:     linux-kernel@vger.kernel.org
References: <20221112152446.41690-1-aidanmacdonald.0x0@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20221112152446.41690-1-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 11. 13. 00:24, Aidan MacDonald wrote:
> Remove use of the deprecated mask_invert flag. Inverted mask
> registers (where a '1' bit enables an IRQ) can be described more
> directly as an unmask register.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/extcon/extcon-max77843.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
> index 8e6e97ec65a8..1bc0426ce3f1 100644
> --- a/drivers/extcon/extcon-max77843.c
> +++ b/drivers/extcon/extcon-max77843.c
> @@ -189,8 +189,7 @@ static const struct regmap_irq max77843_muic_irq[] = {
>  static const struct regmap_irq_chip max77843_muic_irq_chip = {
>  	.name           = "max77843-muic",
>  	.status_base    = MAX77843_MUIC_REG_INT1,
> -	.mask_base      = MAX77843_MUIC_REG_INTMASK1,
> -	.mask_invert    = true,
> +	.unmask_base    = MAX77843_MUIC_REG_INTMASK1,
>  	.num_regs       = 3,
>  	.irqs           = max77843_muic_irq,
>  	.num_irqs       = ARRAY_SIZE(max77843_muic_irq),

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

