Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9426642F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjAJOPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjAJOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:14:58 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7B732E94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:14:57 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so16596693pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1YEiT9RxUJGUNM0Cb/4MKStLgz0n2nnsbx7vILoFQM8=;
        b=BAPc8KWZFmsTuSsojiaSuwjuq5H0vMnVQgK0ULYxExsNAO84LFWx9TbJYRXpC4dGXU
         sm1hHGGyiy76DWyBZaK4jDfDHVBo6rwZR6FKdd2mLCdfrjD+d9jheccm1skaG6+kDmKF
         CoRdj1ozDb7ZH0GB9PeME9M4LtY2a5zrh16aVOeWsz+1XKfZAx6mFB2IuUG1z3vusvjI
         s9U8/q2SgIVM9lmRLFx+W+J9+hOMupQDT/vW4xOYiP0d54v2H+QyflMRgZCg0RVaUH0g
         uLt2NLKngGDFK2DSkmjFqG8lpJQtsBq11rLfkRlOvu8s51SytcNpI/IPw0lTCR31I01t
         WIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YEiT9RxUJGUNM0Cb/4MKStLgz0n2nnsbx7vILoFQM8=;
        b=FjDcrIl6Tyabq2uxts2JzgLLij/rXraNXz++mPUJ+QQrevlJNDhK9EGcKyMEIx/d9p
         3q1CfSkrkg1loRj2Si7GngKwWslqq9q8+IVIstHg0yVpLWkguZB1TkiXEnV3y2JBpUBR
         0uOF0xDHKi/pJGeJL3xdeQg5E7OsnMlILcR9RLVVaSa0CPkrG1ZEJ8m4Q58Q1QzZLuS3
         TRsmraUtRbL3hoaOfGKOq2SDNzGcoWZ17F5txRgDqxyFgvuCtmlzFzjaaeSBclDbeznc
         EF2ieRszO3GTbLpjIoLjqc/fPqexMqWku/SaKXficEhMA8wpFyY4Oi1Z/tf7a8gdKC2f
         tTuA==
X-Gm-Message-State: AFqh2kouwS5fqwPZzwUDNW0X45jxqd8soUEbRIBOSWk8NvsMBqhDMfI1
        U+wQWpoko0lXqv0zM+/4xxw=
X-Google-Smtp-Source: AMrXdXvarrxWIEwPtq/EaU9G3fbJkVd88lcN/3SXfEs94ODnVmvY1/Rvk3a1LzXoETBTQZ7CxTIgng==
X-Received: by 2002:a05:6a20:4904:b0:9d:efbf:8156 with SMTP id ft4-20020a056a20490400b0009defbf8156mr87298299pzb.31.1673360097124;
        Tue, 10 Jan 2023 06:14:57 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id b145-20020a621b97000000b00575d90636dcsm6198990pfb.6.2023.01.10.06.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 06:14:56 -0800 (PST)
Message-ID: <3e95cc81-bd58-2a4e-7605-d827610ccbf1@gmail.com>
Date:   Tue, 10 Jan 2023 23:14:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] extcon: usbc-tusb320: make sure the state is
 initialized on probe
Content-Language: en-US
To:     Peter Rosin <peda@axentia.se>, LKML <linux-kernel@vger.kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Auchter <michael.auchter@ni.com>
References: <30cd9157-1850-b17f-bfd5-4c378990b81b@axentia.se>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <30cd9157-1850-b17f-bfd5-4c378990b81b@axentia.se>
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

Hi,

On 22. 12. 13. 07:36, Peter Rosin wrote:
> When the port is connected at boot, there is not necessarily
> an interrupt flagged in the interrupt status register, causing
> the IRQ handler to bail out early without reading the state when
> it is invoked directly from probe.
> 
> Add a flag that overrides the interrupt status register and reads
> the state regardless during probe.
> 
> Fixes: 06bc4ca115cd ("extcon: Add driver for TI TUSB320")
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/extcon/extcon-usbc-tusb320.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Hi!
> 
> This is basically a resend of v1, the patch has simply been adapted
> to fit after the driver changes for type-c support.
> 
> Version 1 of the patch, with its brief "discussion", is here:
> https://lore.kernel.org/lkml/ab1ad93b-4d39-8863-9704-da779fc4c426@axentia.se/
> 
> I cannot see how the patch can possibly affect detection of connector
> changes *after* 'priv->initialized = true', so the comment from Chanwoo
> Choi is still a mystery to me. The patch is about what happens *before*
> 'priv->initialized = true', i.e. when the IRQ handler is called directly
> during probe. There is no change in behavior after the statement
> 'priv->initialized = true', and IRQs are handled exactly as before once
> past that point.
> 
> Please look at this patch again.
> 
> Cheers,
> Peter
> 
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
> index 2a120d8d3c27..dc586e5e3c65 100644
> --- a/drivers/extcon/extcon-usbc-tusb320.c
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -78,6 +78,7 @@ struct tusb320_priv {
>  	struct typec_capability	cap;
>  	enum typec_port_type port_type;
>  	enum typec_pwr_opmode pwr_opmode;
> +	bool initialized;
>  };
>  
>  static const char * const tusb_attached_states[] = {
> @@ -323,7 +324,7 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
>  		return IRQ_NONE;
>  	}
>  
> -	if (!(reg & TUSB320_REG9_INTERRUPT_STATUS))
> +	if (priv->initialized && !(reg & TUSB320_REG9_INTERRUPT_STATUS))
>  		return IRQ_NONE;
>  
>  	tusb320_extcon_irq_handler(priv, reg);
> @@ -479,6 +480,8 @@ static int tusb320_probe(struct i2c_client *client,
>  		 */
>  		tusb320_irq_handler(client->irq, priv);
>  
> +	priv->initialized = true;
> +
>  	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
>  					tusb320_irq_handler,
>  					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,

I think that if priv->initialized=true on probe step,
tusb32_irq_handler return the always IRQ_NONE
because priv->initialized is never changed to false.

Is it right to keep the 'priv->initialized=true' always?

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

