Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808D17418A1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjF1TGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjF1TGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:06:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BB6E4;
        Wed, 28 Jun 2023 12:06:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-263253063f9so1442262a91.1;
        Wed, 28 Jun 2023 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687979178; x=1690571178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=paHX3Iae9acGKLhSH26DZU14Gz3gF8upgejcn3o6KiI=;
        b=C0BRN//vSTkyhBmMaTR0CaSA9MrlSPGVuT9kb0dUkTysLD4LneAvC1r0kDdQDBBaBM
         4nXoPQK+CLs4lEXRyenQXJ8xkQUqPRGK5MXx0voqWXx2F+iCdgB++5YppcQNg35jpyH4
         RO19u5zf2nvmTsPVNDKULIX+llwl+VaBHbqQIP6ezZEFlzIvyEQ7V13P1XceoaW0YO2E
         x1n0f6XGFXrhlNvcYUhPmlFmbmXnNdwmlGXCpcb5MGIidTxzUmxo45niZcC4ios9MZ3j
         GxROEmwsUJ/Cni6Mk/tmxMselQYvG1Vu2ztToJScRHLNXN4kHiPIEnoZGF9mo5BoDyS0
         ToFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687979178; x=1690571178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paHX3Iae9acGKLhSH26DZU14Gz3gF8upgejcn3o6KiI=;
        b=D+QkDeQhBwWiQUHlXfW0BeuTxOSe4b7hkUxKbtnDvnAC7S4NTI2DzOHjJsuIZCISkg
         /h2KSk9/5f6A8jtJSY06fk81XY6qKG017iycWDEVtHAAlM6dK7cf/Z9vAuZ89M+wPh2J
         ZY5RKlGPqso5IfhyGJBEVt/sdCPJAoVJXM7epOU2XNtACslxi+4THiaN2pSbw7dnP5O1
         XG1n/R3q90Ke35/dtTQzWCnOyiQKi0ww+o/eMcc8vymg0INJo5Qo/a9R/48+I3Qp6PSh
         8T3tWh8vL35OTwVho08L74MDFdHDt8bGxea+sIEIfsLD6BYvSDvjFJKVjg5msqlZ4WTd
         3qUw==
X-Gm-Message-State: AC+VfDy+xim2QtOojwYBR+QA1sx5t9N7qF5Y/GG8nZc65/59d5ASu2Kl
        eCGmbx5llc/Xi3pHq/DQ7HU=
X-Google-Smtp-Source: ACHHUZ6LJ12DxLlblcInWmUxgPjgvhzSgwDwlucA/Gew9Vz3zYm3H0OAMop0dj5mjUNiSt4xMfAAIA==
X-Received: by 2002:a17:90b:3906:b0:263:945:61ae with SMTP id ob6-20020a17090b390600b00263094561aemr7150878pjb.23.1687979178266;
        Wed, 28 Jun 2023 12:06:18 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:95ec:4c43:368:77b0])
        by smtp.gmail.com with ESMTPSA id p16-20020a17090adf9000b0025bf330903esm3986824pjv.1.2023.06.28.12.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:06:17 -0700 (PDT)
Date:   Wed, 28 Jun 2023 12:06:14 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Valek - 2N <jiriv@axis.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v4 2/2] Input: cap11xx - add advanced sensitivity settings
Message-ID: <ZJyEpuat1A8Z+Ft4@google.com>
References: <20230627065316.1065911-1-jiriv@axis.com>
 <20230627065316.1065911-3-jiriv@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627065316.1065911-3-jiriv@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Tue, Jun 27, 2023 at 08:53:16AM +0200, Jiri Valek - 2N wrote:
> @@ -439,7 +589,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
>  	priv->idev->id.bustype = BUS_I2C;
>  	priv->idev->evbit[0] = BIT_MASK(EV_KEY);
>  
> -	if (of_property_read_bool(node, "autorepeat"))
> +	if (of_property_read_bool(dev->of_node, "autorepeat"))

It would be good to have this driver switched from of_property_*() to
device_property_() API.

>  		__set_bit(EV_REP, priv->idev->evbit);
>  
>  	for (i = 0; i < cap->num_channels; i++)
> @@ -474,14 +624,8 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
>  	if (error)
>  		return error;
>  
> -	irq = irq_of_parse_and_map(node, 0);
> -	if (!irq) {
> -		dev_err(dev, "Unable to parse or map IRQ\n");
> -		return -ENXIO;
> -	}
> -
> -	error = devm_request_threaded_irq(dev, irq, NULL, cap11xx_thread_func,
> -					  IRQF_ONESHOT, dev_name(dev), priv);
> +	error = devm_request_threaded_irq(dev, i2c_client->irq, NULL,
> +					cap11xx_thread_func, IRQF_ONESHOT, dev_name(dev), priv);

I would prefer this change be a separate patch.

Thanks.

-- 
Dmitry
