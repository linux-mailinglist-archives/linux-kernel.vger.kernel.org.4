Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B01712ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbjEZQfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjEZQfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:35:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA83CBC;
        Fri, 26 May 2023 09:35:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3a873476bso995184e87.1;
        Fri, 26 May 2023 09:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685118945; x=1687710945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZdVc8cg3rTwRQ3rUGrbIe2G7Mi0MzIoMDjJTPUXsKU=;
        b=EmEi2d9UpDaO/uDti+2NYtSCgpRhj7sgXUxRN9Sx/VbofLPSxKJKwBca93UIYX5e3K
         qkA5Pf35BlxUXq+gNVWg/SPLT4WsrDzIFYsj9/WGFM8Wbk78HQACFY1vFoeINfYqXn7M
         /71C3vO2yLvOCb8VkZxdQ0JB6gUG3UfXZA/b93cAuH4jp6sKm2MgMksWoFvjK4wq4UWs
         0ByhHBeCp0TcnRZTAA5m0wGoxDMK4zrx9EODcnC4CZOunVNA+PpFdzNDDFM+H8hRWKKr
         rzfnOOt849X1iWQs+nquUgH2MmsOHZVGqzEjn6ACJ14OPXT+9CZdY2rdYNqBnm8BSsOc
         Qc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685118945; x=1687710945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZdVc8cg3rTwRQ3rUGrbIe2G7Mi0MzIoMDjJTPUXsKU=;
        b=OZw/gswfJuh6P7tQ8G1gxxdrbw3PFGFhJSqwNDJbROqB1WHNbaSvknRKihyPeg8zA3
         EnygA2XhO3WfNeaManNo48iGXTZmqVHrmtEnwv47Q3HbcCjdlB1bJwzD+WqTIJRDMkJt
         3NcCRedwujB4Ast/AGJGueTwNXZMNl13c0KGStLkAObJy4ljX2f/nroFkbU+ITAHa7qe
         bVB3MUhe6/e1UlucTYw2xEam5/aQeQRZgnMdweocmB2WOfuAbPvnq6SsR00cN0zm0eFs
         Sq5GIFjprg0VBc7OsHx95nyuecsTOlCXPKl63nj8CLBIPsRLVpKXkYQKbsj3AFvtMNsY
         UGcg==
X-Gm-Message-State: AC+VfDwXYOpP+H5/vodgoR33LPBMBnzuE/nPHSnywcYKkDXamjdAKRZZ
        e2huwFwBS4Ln9LNdaU/3wpc=
X-Google-Smtp-Source: ACHHUZ5k55KO5kA8DfPcVtzmJBHus1jmL85c0KC+03dEOqFdaSdMVkyjM7UiGFCrWnesoACtTtH+qg==
X-Received: by 2002:ac2:5ec4:0:b0:4f3:7a8c:d46c with SMTP id d4-20020ac25ec4000000b004f37a8cd46cmr778242lfq.66.1685118944902;
        Fri, 26 May 2023 09:35:44 -0700 (PDT)
Received: from [192.168.1.126] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id b15-20020ac2562f000000b004f13c3cb9ffsm681853lff.200.2023.05.26.09.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 09:35:44 -0700 (PDT)
Message-ID: <0a816b1c-eef3-95c8-fb71-1c81251224e0@gmail.com>
Date:   Fri, 26 May 2023 19:35:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 4/7] iio: accel: kionix-kx022a: Add an i2c_device_id
 table
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1685109507.git.mehdi.djait.k@gmail.com>
 <ea14686bc9a9262ef9c370d9cd1a4a7b2902b4ea.1685109507.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ea14686bc9a9262ef9c370d9cd1a4a7b2902b4ea.1685109507.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 17:30, Mehdi Djait wrote:
> Add the missing i2c device id.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
> v4:
> - no changes
> 
> v3:
> - no changes, this patch is introduced in the v2
> 
>   drivers/iio/accel/kionix-kx022a-i2c.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> index e6fd02d931b6..b5a85ce3a891 100644
> --- a/drivers/iio/accel/kionix-kx022a-i2c.c
> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> @@ -30,6 +30,12 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
>   	return kx022a_probe_internal(dev);
>   }
>   
> +static const struct i2c_device_id kx022a_i2c_id[] = {
> +	{ .name = "kx022a" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
> +
>   static const struct of_device_id kx022a_of_match[] = {
>   	{ .compatible = "kionix,kx022a", },
>   	{ }
> @@ -42,6 +48,7 @@ static struct i2c_driver kx022a_i2c_driver = {
>   		.of_match_table = kx022a_of_match,
>   	  },
>   	.probe_new    = kx022a_i2c_probe,
> +	.id_table     = kx022a_i2c_id,
>   };
>   module_i2c_driver(kx022a_i2c_driver);
>   

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

