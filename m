Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC425B3436
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiIIJme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiIIJmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:42:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD28C57AD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:42:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d2so1820047wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JS0Czy7dsUI1cWCRoLjh3QMDTfvpIvOi8LnTDYzrDZ0=;
        b=xP9k++dx7d5LLlwEg98W3EOH+AzIBtMr+JHYdIyjEPUAbvI+red0aOZMzFTj97yEg4
         J/YmlC2Fyvo3OuKGiXm8YqLofQmqpWv9F3aeyayGRbY2g7Sq98oFmhKhryue7TB1k6Hq
         N3GeWWxQCzWsKxy+pGQiK5G0+b1JL+zsKqzWJZVBaKc768padgEjV6zS1QGqyR9wUkDQ
         hXpzsfNtcPZ0b8G21/DlfnJl8tg4xpV1FTQbnxegc/Xu9Mudk9/QUhEDwP6GZw4oIVl4
         taXstMfHj/KQF1CYqgWwlxpzLQ1PZmW5pzJDwuB+31dHUZH6Gwy97bnmJ/2XTL4VVG5A
         JoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JS0Czy7dsUI1cWCRoLjh3QMDTfvpIvOi8LnTDYzrDZ0=;
        b=5hSInF8CsR0MWDLnlTKg0LBGTEJWgDiWH5IZixAZyM77tnboij+LzYGbDu5Czp/5Oq
         JvQJ25lhCQ+tM378XHQjz6eAQv7UQCwSrj/LnKUmU+6V4AM/O1Q67sF8i/Yqb2zbZ2va
         gTuSzX72JJ9P47vrl+76SP99RWIUhmy5Bxann68ZFjn24Dbv4cgC1E4fa1+sPKqZHzkm
         7BMmgq61ZcW0uqK7HMH9chGCVlXhfBw2/Z28xUVMRHA/AO2ONiOTyQlKWIBk58GuC0rw
         s8hFj1pr/WxQphoAs6MF6RQqS+Vg0tr/1B2kcKTTBpTEKqm85Yz7jzh4mEERgtDT4PHc
         87Aw==
X-Gm-Message-State: ACgBeo1428f3ORL0eoCwpQnxiyGxkILm1/hJM8b5eJq++daQFxqkYeOK
        dfq3qHxMmNv8t1b/QbO9CUFZEw==
X-Google-Smtp-Source: AA6agR5TOXDSJeXNS8ameg/jXPtMSLz7G7W0z8By9yV5czl7eFUQKgNjyqjiM/lafjuNn/JAFIwKuA==
X-Received: by 2002:adf:d1e4:0:b0:22a:34a4:79ab with SMTP id g4-20020adfd1e4000000b0022a34a479abmr3438748wrd.188.1662716548864;
        Fri, 09 Sep 2022 02:42:28 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id p27-20020a05600c1d9b00b003b340cca018sm100814wms.16.2022.09.09.02.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 02:42:28 -0700 (PDT)
Message-ID: <983d552e-1dd1-8881-47e5-5d3e8bfdefb3@linaro.org>
Date:   Fri, 9 Sep 2022 10:42:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] slimbus: qcom-ngd: use correct error in message of
 pdr_add_lookup() failure
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20220830175207.13315-1-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220830175207.13315-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/08/2022 18:52, Krzysztof Kozlowski wrote:
> Use correct error code, instead of previous 'ret' value, when printing
> error from pdr_add_lookup() failure.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: e1ae85e1830e ("slimbus: qcom-ngd-ctrl: add Protection Domain Restart Support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
Applied all thanks,

--srini
> Changes since v1:
> 1. Correct typo
> 2. Return 'ret' instead of again PTR_ERR
> ---
>   drivers/slimbus/qcom-ngd-ctrl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index 0aa8408464ad..f4f330b9fa72 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1581,8 +1581,9 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
>   
>   	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
>   	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
> +		ret = PTR_ERR(pds);
>   		dev_err(dev, "pdr add lookup failed: %d\n", ret);
> -		return PTR_ERR(pds);
> +		return ret;
>   	}
>   
>   	platform_driver_register(&qcom_slim_ngd_driver);
