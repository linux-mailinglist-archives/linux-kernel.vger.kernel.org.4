Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1A6EA26E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 05:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjDUDog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 23:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDUDoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 23:44:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64520E57;
        Thu, 20 Apr 2023 20:44:31 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ec81436975so1200220e87.0;
        Thu, 20 Apr 2023 20:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682048669; x=1684640669;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy9R4yyUoP7BX/FYodocgkN9ttU7PdKqko73E36Oc78=;
        b=NmqWYY3FIF1BLQvy6wOdhFYGCX4rYgMDFsHGg1J2ji/wRK9duWCh84kBiAWUrDnOCf
         MhgPrgvbw4aMAkTp3sz8VL5hwPcW2aoCTF4z/8S5vCvVDGIc4EjNXFHRyYdNVS1AUk8j
         CTQ8QmU6HogxpfGYW1u5jmDuFxtkQj25atVljUdiFgcvU5KyGqRWImQozi5R0klnsVQD
         nkKuu5NqgwxxSbVBiaHPDUiv2WBBfUheSskcN0qeWOUUSSKSiC48K04p/XfB+lV41qyq
         rqalaawwFHL5BaVt37E4u/skVgWGFeomIZ6/Akp5Oq7NPy5b226T5ZAqX7kzTG6bMQrM
         n4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682048669; x=1684640669;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vy9R4yyUoP7BX/FYodocgkN9ttU7PdKqko73E36Oc78=;
        b=fJ7egiAlAorGWQcqmeEK2IYiaLx0tFBno+SAwrh1LF+Okk8F1fmBh9pod5FYSpFped
         wwi0PFvGEh+4i2id7M2c5svbJor+EIEB1UYDdLMHF09AgsS7+tZWRluXDa4RMdAiQFH4
         nduEybAwTAvZiZEroVs46c0jT4pOFMmGy7ShxSL/Xa2Djl3+N2QPnPIQp+eaIy3+ZFCI
         YGuyZ1XMzrEMNAtiV//gVlr4yFP0GjOMnI5RJBBced/UBiaUU7ekaoTt22kid0IFlUCj
         5liijFmDr+bCThW6MgK7U/Gi7KQZ9U5McwHR8q7ttMowZzb6kEdekohK2jOJI6Mja9EF
         fC1g==
X-Gm-Message-State: AAQBX9d24rjj1OfmjCdBbIcQdIu+mP7bKE7nwq+IXz6V13Mcwbk3TpvP
        vCwTJxUX3sQLOkLKqmmL3Wc=
X-Google-Smtp-Source: AKy350YqRtokS7FKci5QWqOumjOwN5erQQb8osQ8vB8JG/KTzSd8nTQqyvCTC+CWiPsUl1ArbcBIPw==
X-Received: by 2002:a19:ee12:0:b0:4e9:5f8e:315a with SMTP id g18-20020a19ee12000000b004e95f8e315amr696371lfb.65.1682048669510;
        Thu, 20 Apr 2023 20:44:29 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id j8-20020ac253a8000000b004eed73f6db8sm421199lfh.12.2023.04.20.20.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 20:44:29 -0700 (PDT)
Message-ID: <6caba41c-3db2-90c4-e1f7-2392162e2b0a@gmail.com>
Date:   Fri, 21 Apr 2023 06:44:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
 <b6cb3d48ab9e4177b924b18e27487f8ef763dfd6.1682019544.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/5] iio: accel: kionix-kx022a: Warn on failed matches
 and assume compatibility
In-Reply-To: <b6cb3d48ab9e4177b924b18e27487f8ef763dfd6.1682019544.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/23 23:22, Mehdi Djait wrote:
> Avoid error returns on a failure to match and instead just warn with
> assumption that we have a correct dt-binding telling us that
> some new device with a different ID is backwards compatible.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
> v2:
> - no changes, this patch is introduced in the v2
> 
>   drivers/iio/accel/kionix-kx022a.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index f98393d74666..70530005cad3 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -1038,9 +1038,7 @@ int kx022a_probe_internal(struct device *dev)
>   		return dev_err_probe(dev, ret, "Failed to access sensor\n");
>   
>   	if (chip_id != KX022A_ID) {
> -		dev_err(dev, "unsupported device 0x%x\n", chip_id);
> -		return -EINVAL;
> -	}
> +		dev_warn(dev, "unsupported device 0x%x\n", chip_id);

Just a 'nit' - no need to re-spin the series for this if there is no 
other changes requested.

Maybe a slightly better wording here would be "unknown device"? If I am 
not mistaken the code proceeds because device is assumed to be supported.

Jonathan, do you think this change is worth backporting? If yes, then we 
might need a Fixes tag.

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

>   
>   	irq = fwnode_irq_get_byname(fwnode, "INT1");
>   	if (irq > 0) {

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

