Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E1A6EA771
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjDUJpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjDUJpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:45:00 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314CDB74C;
        Fri, 21 Apr 2023 02:44:27 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ec8148f73eso1434149e87.1;
        Fri, 21 Apr 2023 02:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682070265; x=1684662265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4yqewm97wXIubxMTJYuR3/j8FVQClfJwz50CxbBMeY=;
        b=DSnCMytAXmWmWSR9WU6eLzGPk3yyyv4qzxp537rrFr29eC3nq2aCsxNZ3oAS9vI/qJ
         0Qq3RMk7Zp/aE5LZROXZnkFtv/ClH/3IUVbYVis7DWjncU77JjSCKpbGs23iHTDT++Ws
         74/+BXQELfk6jbqp4gG91UjMPne+UuCjpJ9v5HxISt9P1AY/FjBgcc7ScCYINbOFac2H
         94/VRzVq590sDEua51CBGPEakirQmYIsRPjXpQ4BZQCNnxnxdbyCPS04sK7YS/Oew/bO
         oFeucZJTq/S4G0UQAx84jeApzZkRVw1f6shqGuePJ68NaW1kZI+9S3S64CbQotFfJeyI
         6pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070265; x=1684662265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4yqewm97wXIubxMTJYuR3/j8FVQClfJwz50CxbBMeY=;
        b=avs7ZhZgXPmRY0vpFfA/qjI4JOV/s+qU3CCgRsesQlSPz1pCL3v+CUdRei0ZF5GnD/
         kNSiT0wAyNmoqoS4SATgkG94pyWszAOwn/JMBuld/b7tYM+SkpkW28/D7444mMHiWMQ5
         Qo7uZaT5wVKlI/8a/VkvRMX3ndPiKlVWQsTMnROiy9C7BUz+04qOC4wlZji+uutuTLs3
         lviZ8c/Hnj0lDh9IzzNXkTEVPNWU83LsWjDnPwj8UvNj9+7Om8pVr9LDUlbZl9AAVFVJ
         W3+rWK++NS6A4s0IBsgdhSCTKPX9mlFO0kcLQip98HaTseDsDhv7++La+52EHEhItosk
         5xug==
X-Gm-Message-State: AAQBX9dWgyNZZi+rZj8qYpYkJ3NBqpKRWGFgeZtpzdzktLFD610rlPyL
        vcNMjxvZW7heSrErSIpvc5k=
X-Google-Smtp-Source: AKy350YclHxD9WdhuVOWSKV8W2VP9zRTLGsQLgTPyOy7mzyBpIIdmrOGzYJbe+Eivehf+r08RwQ26A==
X-Received: by 2002:a05:6512:11d2:b0:4ec:a4b4:4731 with SMTP id h18-20020a05651211d200b004eca4b44731mr1116092lfr.68.1682070265363;
        Fri, 21 Apr 2023 02:44:25 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id b10-20020a056512024a00b004edc3bd7fa1sm497840lfo.201.2023.04.21.02.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 02:44:25 -0700 (PDT)
Message-ID: <2afe74ae-939c-39fa-1b1e-7451783a27a0@gmail.com>
Date:   Fri, 21 Apr 2023 12:44:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 3/3] MAINTAINERS: Add ROHM BU27008
Content-Language: en-US, en-GB
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1682067567.git.mazziesaccount@gmail.com>
 <82ae3f4eb27b64554d7804c46febbb4a7f9fe7ae.1682067567.git.mazziesaccount@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <82ae3f4eb27b64554d7804c46febbb4a7f9fe7ae.1682067567.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/23 12:39, Matti Vaittinen wrote:
> <lars@metafoo.de>,linux-iio@vger.kernel.org,linux-kernel@vger.kernel.org
> 

It appears part of the intended recipient addresses ended up in the 
commit message. (CC'd the missed people/lists here). Sorry folks, I'll 
fix this in the next version.

> Add myself as a maintainer for ROHM BU27008 color sensor driver.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ac81383129a6..6c0775aabade 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18099,10 +18099,11 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/iio/light/bh1750.yaml
>   F:	drivers/iio/light/bh1750.c
>   
> -ROHM BU27034 AMBIENT LIGHT SENSOR DRIVER
> +ROHM BU270xx LIGHT SENSOR DRIVERs
>   M:	Matti Vaittinen <mazziesaccount@gmail.com>
>   L:	linux-iio@vger.kernel.org
>   S:	Supported
> +F:	drivers/iio/light/rohm-bu27008.c
>   F:	drivers/iio/light/rohm-bu27034.c
>   
>   ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

