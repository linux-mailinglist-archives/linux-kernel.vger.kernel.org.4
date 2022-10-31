Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809D3613A21
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiJaPft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiJaPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:35:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C4B634E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:35:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v1so16497054wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:reply-to:organization:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TsXJSVmpsfRwUaoUkQeZoN5vrNGuaXJ+yHnFyn7q25I=;
        b=kNDVSruV16A9lm4yIH6ED5p3NglZj4zIWm6IWzCXkUhLysu/9kFqTnjIKo0B5mdWtE
         bVkze8vz56g3cNUjHYUhdd2HSRi3Lr77pdsuZdu/ZSMft7E+XFsIZcNWXo6s6H0+dMVH
         x5hy2kxnN7LVX3Yki1W5sEdlWJRu5LnLP0Z30WQ5M4r6Xw4Aq0ROJk3qcBp2JfWxarBl
         zZTGvO9QBblm1HmA+daQtS4fyx7f1QGrlVWeziluZvNx7LQ0REWS2xw6IZ/EyUs2cjDK
         ZxxhWhPVf2FcTxe9wbNDK87W4N6DD4Gjf4lnkHIyHwncXHxqgu0zsO1XLUNAzjCI0n2i
         /RwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:reply-to:organization:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsXJSVmpsfRwUaoUkQeZoN5vrNGuaXJ+yHnFyn7q25I=;
        b=v0qwN/DRuNaczIAWPai0sbgshjKbTgg+XIlnVFq0hA4dE1GOVGVGfgi5v6WP8BE/xF
         yq+1imJaAri2BWfHIctAuBrCGMru3MzYC+AQMeabRU5G++y9sS4jUXGr7r8vwZL0BQQv
         pO9TqBNoufWuVAOtIkmeFBhFqld0vxLQzBPD95cRGn6zJ3OPv4GqyQMs9mY+9BPnSBFX
         lU2eDCaRCk+q1FICPVAcvNtLU55qcuT10LiY4iSwzKtAqIjpOORghO9wNAjHftgxb+Wr
         9mCmxA6q48FDDAWlMI1O/SPjJeA1qXXd4EaMeKejj6qOLu1oN1fTKglFLE/aFY29dTd2
         Dhsg==
X-Gm-Message-State: ACrzQf3aLvvNLSLv1sHHeDsx4YALvNbLCc9EZfZRdCRpZT7sp1/65aus
        z6UV/6rvkjx9O5LYDtjsKbWb7A==
X-Google-Smtp-Source: AMsMyM73Wi/PfFl19dSX+YB0TWP0LDVvL+RVag0yoxDj3CQC07pDBzEctGykPU2rWEpvK1FkJgWkuQ==
X-Received: by 2002:adf:f4c7:0:b0:236:c415:c707 with SMTP id h7-20020adff4c7000000b00236c415c707mr5202241wrp.24.1667230543206;
        Mon, 31 Oct 2022 08:35:43 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:34f:ed70:97ca:71f8:f780:5cf1? ([2a0d:e487:34f:ed70:97ca:71f8:f780:5cf1])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c070600b003cf483ee8e0sm7306730wmn.24.2022.10.31.08.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 08:35:42 -0700 (PDT)
Message-ID: <6858acf3-eb90-41aa-b714-a2ceb6afe9db@linaro.org>
Date:   Mon, 31 Oct 2022 16:35:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 08/11] mfd: qcom-pm8xxx: drop unused PM8018 compatible
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Gross <agross@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v4-0-dac2dfaac703@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v4-8-dac2dfaac703@linaro.org>
 <Y1/qnCyav/S35mRo@google.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
Reply-To: neil.armstrong@linaro.org
In-Reply-To: <Y1/qnCyav/S35mRo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/10/2022 16:32, Lee Jones wrote:
> On Fri, 21 Oct 2022, Neil Armstrong wrote:
> 
>> The PM8018 compatible is always used with PM8921 fallback, so PM8018
>> compatible can be safely removed from device ID table
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Tags should appear chronologically.

Indeed, they were added by b4, I'll report this.

Thanks,
Neil

> 
> I've fixed this up and applied the patch, thanks.
> 
>> ---
>>   drivers/mfd/qcom-pm8xxx.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
>> index 2f2734ba5273..601106580e2e 100644
>> --- a/drivers/mfd/qcom-pm8xxx.c
>> +++ b/drivers/mfd/qcom-pm8xxx.c
>> @@ -497,7 +497,6 @@ static const struct pm_irq_data pm8821_data = {
>>   };
>>   
>>   static const struct of_device_id pm8xxx_id_table[] = {
>> -	{ .compatible = "qcom,pm8018", .data = &pm8xxx_data},
>>   	{ .compatible = "qcom,pm8058", .data = &pm8xxx_data},
>>   	{ .compatible = "qcom,pm8821", .data = &pm8821_data},
>>   	{ .compatible = "qcom,pm8921", .data = &pm8xxx_data},
>>
> 

