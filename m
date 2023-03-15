Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0124B6BABD4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjCOJNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjCOJNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:13:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE5E67014
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:12:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j2so16593823wrh.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678871569;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8eWJAVwfdAMUCwI3o2WJJsF7HeRR9gB8W1OrllJjb5o=;
        b=XzSmAIL6WPDc9unS6StGpnGGh/CGMJ8Wy8hZjsWSd8gRTPzMl4yLkyH89Z+NjNNOEE
         /Zl4VkWXiNeVyyMGC7M7hiIBT32VcDKSLy3AiNF1yo1y17rrs6Q98cNSLWgczakKjRen
         nr+onVKwv62YRyFi0/Ar2V62oOKd932RzGtYRliH1EwMglxP5NqYCJwxiWMCjhIRnRog
         2R4k6Q7byMQpvMmJkzinKqrxYlBIs2v9GCUanWcefXQXQ8MJEjRntl+eLd6HQc/jPsgZ
         n2XpIhHApTZItuwQB5/c5PwtrzQI3mSIHqoIDWaieiCE+5NREvvA69rUWPdAieBmH6G8
         8Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678871569;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eWJAVwfdAMUCwI3o2WJJsF7HeRR9gB8W1OrllJjb5o=;
        b=jKh9TOy6ozBxdqdlHTk/I46d8FPAPkHEdeOg+wsdRN3HmAJ04ImeE3sYKRC2epMgfR
         Vye1TiJsnk/iQbh4RzPzCnnOzMwIwLUdRjq6vB5zuOfu1FtnlgTQB/0yMNTuoIiXVbyB
         yVqs3jGi9uz6XRyBrTDAeUnQ62eNjDBph34ql2k1He2jPHg7Pf8J1WIXhqJ47GtKjEz/
         VrY+NAiwKqsxh0i3YVQKJFXrFPJx0v8zrcu1/nkfsOwlU8hPvBQnYi5orVhTEDIpfNXc
         U14Tk1lmRxvQiplh+UqmmAlU1sHWji9Q+uav1rXRaGSpyI+JJ7cGjxAntOpIRC5+Rm9C
         i2xA==
X-Gm-Message-State: AO0yUKUwgZpadZ/zte9/EuX+E7JS8hr8DIVMyH842x7cG50ZZB52yjgj
        iL625BvRYvw2DyG9D5zcjFcv1A==
X-Google-Smtp-Source: AK7set+eEbACpzLETf5+yoKzRbTbJU8SVnRF6TSezwW6SQk2wIN2YnBbU8HXUTnpArYwaQ5lSXadsw==
X-Received: by 2002:a5d:4c8e:0:b0:2cf:e710:a4b9 with SMTP id z14-20020a5d4c8e000000b002cfe710a4b9mr1357985wrs.32.1678871569378;
        Wed, 15 Mar 2023 02:12:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5d2d:8427:397b:8fe7? ([2a01:e0a:982:cbb0:5d2d:8427:397b:8fe7])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6b84000000b002cfe685bfd6sm4027654wrx.108.2023.03.15.02.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 02:12:48 -0700 (PDT)
Message-ID: <f4801f1d-cd6a-2a3f-155c-e72d3d28da30@linaro.org>
Date:   Wed, 15 Mar 2023 10:12:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 7/9] regulator: rpi-panel-attiny: Drop of_match_ptr for ID
 table
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
 <20230310214553.275450-7-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230310214553.275450-7-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 22:45, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).
> 
>    drivers/regulator/rpi-panel-attiny-regulator.c:390:34: error: ‘attiny_dt_ids’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/regulator/rpi-panel-attiny-regulator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
> index 34514976475e..3953fc1f389f 100644
> --- a/drivers/regulator/rpi-panel-attiny-regulator.c
> +++ b/drivers/regulator/rpi-panel-attiny-regulator.c
> @@ -396,7 +396,7 @@ MODULE_DEVICE_TABLE(of, attiny_dt_ids);
>   static struct i2c_driver attiny_regulator_driver = {
>   	.driver = {
>   		.name = "rpi_touchscreen_attiny",
> -		.of_match_table = of_match_ptr(attiny_dt_ids),
> +		.of_match_table = attiny_dt_ids,
>   	},
>   	.probe_new = attiny_i2c_probe,
>   	.remove	= attiny_i2c_remove,


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
