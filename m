Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556026B64B8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCLKGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCLKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:05:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27ED1C7D1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:04:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g10so8684641eda.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678615440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIqRqJQWxyWyp+7pWTYPje+scwaftD+oSHprfH2ssSw=;
        b=LwN1zyWcU+7gQx1gHeM0LZ6sL9jJ5FX9NnYNQp0itQFk17eu372cOAIxC8z+hmFoOZ
         ya/VO817mKfi1xinlpWmDvDFqDRjWxLg9AQjI5MFOqTEilbCmpqOEVqTj11bf62Aud0B
         mVq87JJ2nub44hMxXTv5h5yIaR6P1JI5b20AqvZNrJxruvm+v/esiuUfxl7AbDvCfBLA
         DkW5K+BEhitTJ0hqCQ1P1ZCGW/CG5/0J08Yp/XAOijhqa/TOIN7NzDacnWa9HmtFw/nR
         wFWyvY1LoTDOzQvtslVG1rqmHEg8xonBKClSY8G0ssNUiZKwutVTpWFoHkivNEpbiUHD
         PqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678615440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIqRqJQWxyWyp+7pWTYPje+scwaftD+oSHprfH2ssSw=;
        b=FrJU+Nt4bMMLYoKUBwflfTIouYn9eR6Y7lcBOgvM9j6ZoWX4pe+LSdBurytQXZjG13
         TteAueREy9xsjAKR3jg44CVABRe5DTld5sd2cjdRyajTwups1plrOY+pV9/Cc6Ljs7IW
         tEkS2Atw5RCej9RYej3/zJT3VrGCgeP8AHS38k+D5U9dnqBXfsLpTvEjm64/U7pG0dG4
         k5koL5Idv5P5nukoGwdWOHnN9inABLT6sTo9TZDcm+pEtVeoecxOG8RhQEvcmp+XJh1x
         QCQYZI2k4K7Loviv6le7H4G5q5AmRpbqc7rCDNDIize/yCnxDeyrVPKKFjRM0k5EU5IK
         Mv+A==
X-Gm-Message-State: AO0yUKWJxpEfe837xJ9Suf34PL9GTyBjc2VCcOCbGZ+GlJHybNs60npy
        6NIxtEFFN3TlWSeF7z/DDItRldbPXnlp5MekdXM=
X-Google-Smtp-Source: AK7set9BNyklSZqUMLmjUu0BMV2qwFcaLVPC2rn+aSkSJjZmyq8uEhBBimKQ5IDtGdQHPDcEoYS4Pg==
X-Received: by 2002:a17:906:30c8:b0:8b1:4b6d:c57a with SMTP id b8-20020a17090630c800b008b14b6dc57amr5595353ejb.21.1678615440513;
        Sun, 12 Mar 2023 03:04:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id x14-20020a1709060a4e00b008dd3956c2e3sm2057895ejf.183.2023.03.12.03.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:04:00 -0700 (PDT)
Message-ID: <b159616c-f665-42c5-6fbb-841de937d868@linaro.org>
Date:   Sun, 12 Mar 2023 11:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/9] regulator: max20086: Mark OF related data as maybe
 unused
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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
 <20230310214553.275450-2-krzysztof.kozlowski@linaro.org>
 <20230312094216.GC707@pendragon.ideasonboard.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312094216.GC707@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 10:42, Laurent Pinchart wrote:
> Hi Krzysztof,
> 
> Thank you for the patch.
> 
> On Fri, Mar 10, 2023 at 10:45:46PM +0100, Krzysztof Kozlowski wrote:
>> The driver can be compile tested with !CONFIG_OF making certain data
>> unused:
>>
>>   drivers/regulator/max20086-regulator.c:289:34: error: ‘max20086_dt_ids’ defined but not used [-Werror=unused-const-variable=]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/regulator/max20086-regulator.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
>> index b8bf76c170fe..c98a72f43935 100644
>> --- a/drivers/regulator/max20086-regulator.c
>> +++ b/drivers/regulator/max20086-regulator.c
>> @@ -286,7 +286,7 @@ static const struct i2c_device_id max20086_i2c_id[] = {
>>  
>>  MODULE_DEVICE_TABLE(i2c, max20086_i2c_id);
>>  
>> -static const struct of_device_id max20086_dt_ids[] = {
>> +static const struct of_device_id max20086_dt_ids[] __maybe_unused = {
> 
> The following change would also work, as the of_match_table field of
> struct device_driver isn't conditioned by CONFIG_OF:
> 
> diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
> index b8bf76c170fe..ad92f84b4abb 100644
> --- a/drivers/regulator/max20086-regulator.c
> +++ b/drivers/regulator/max20086-regulator.c
> @@ -320,7 +320,7 @@ MODULE_DEVICE_TABLE(of, max20086_dt_ids);
>  static struct i2c_driver max20086_regulator_driver = {
>  	.driver = {
>  		.name = "max20086",
> -		.of_match_table = of_match_ptr(max20086_dt_ids),
> +		.of_match_table = max20086_dt_ids,
>  	},
>  	.probe_new = max20086_i2c_probe,
>  	.id_table = max20086_i2c_id,
> 
> Your patch should reduce the module size without any real drawback as
> far as I can see, so that's probably best. I'm fine with either
> approach, so

I know it would work. If you check all my patches you see both patterns
used depending on the needs:
https://lore.kernel.org/all/?q=f%3Akrzysztof+of_device_id
(~100 patches so far)

The point is that here the device can actually match via ID table, so OF
table could stay optional. I don't think PRP0001 is relevant here, thus
I proposed to keep OF table optional. Different folks have different
opinion on that, so if general consensus is that availability of OF ID
table (for PRP0001) is preferred, I can rework the patch towards it.


> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks

Best regards,
Krzysztof

