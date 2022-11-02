Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E3E616E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKBUFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiKBUFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:05:38 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F53194
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:05:37 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id l2so7377539qtq.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SbIgqqObVXdUI+2kRb0g0D7mPHoI2Zb5+1JVblPI98M=;
        b=J9SWxs9gKCeEeRjMUQ2pArglxl+xWOM5y+UgWQ4aXBy+oT1b0DvFjJA6HSbAs58P0P
         faMXLJQ+6PG40rsKk+qgm1cT96B/O8CJG9zDpGZWegdooaas7UAAU+c7zokYd5wADFgZ
         SCQkws/e3fFB4G+8wYMdf+yQkicFHISIXZwr51cs9Cg8aiJ10wUIVYwCIOAvCWZJ4DXL
         HC9dWKPEu36+7S+/mGym/F7sNxDpGTvmMGT14/AgaKnUW59Mp0muiWDsQxiMSMKeyhAz
         vA6eSYR0uCQLad1ATj/7Udra//Lgnyp3tLsKwo6CYHdwNOVQfx7mHBvX/Y11kBXkjgpb
         vm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbIgqqObVXdUI+2kRb0g0D7mPHoI2Zb5+1JVblPI98M=;
        b=wsDSV8LuYhlpiGkRW5A2QIpjHI7sazyd6HmgEiRhvuRPsfKnetnY5609HMGVdWo41Q
         KZLXvNHNroxhWyIwtnieekfqGaHAZTPk9O6pY8bK2pH34PqhCCCaFeHAsk6706gTgHm+
         g2Ip1q1wVdGLN8DCiTuf3D6xJKmKaOQSGPS5vNxrxQeiGdfvUDJWqfxgxZXIwkxnvPPy
         xugdtgxCtmB0A3g7wDUi0JkNsiwplEglCWdQQDvHdwFlk1GIkk4cKZR7kcqqrP5ido1I
         aS1mYp9LtCghbfQQJsiKJ06q1HGEF4sGWc1ou1KjBYdvLX1if9XcGkEPTrkEXCgmkiqp
         tJzQ==
X-Gm-Message-State: ACrzQf0GT3af47AcDKLJkWfyGRVSg9F9Inz8CTdoFXeoPeiFdUuNQ/B1
        1mP3L6xHsS32KMp0XLjv14+0Ww==
X-Google-Smtp-Source: AMsMyM4t71OGBZ8EeEH9/n3fCJ+rJhQVOX1h4DQDN3U3XpmX88UiFX8Mkf2I2k7xBe76iGkg4rBHnQ==
X-Received: by 2002:ac8:4893:0:b0:3a5:18ce:c034 with SMTP id i19-20020ac84893000000b003a518cec034mr18715622qtq.137.1667419536060;
        Wed, 02 Nov 2022 13:05:36 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id q21-20020a05620a0d9500b006eec09eed39sm9157848qkl.40.2022.11.02.13.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:05:35 -0700 (PDT)
Message-ID: <d11609d5-963a-de41-86f9-7451f460b6fa@linaro.org>
Date:   Wed, 2 Nov 2022 16:05:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 14/15] scsi: ufs: ufs-qcom: Add support for finding HS
 gear on new UFS versions
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
 <20221029141633.295650-15-manivannan.sadhasivam@linaro.org>
 <cf8dcf53-f131-68f4-c6aa-d41e02ac6d5c@linaro.org>
 <20221031145647.GC10515@thinkpad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221031145647.GC10515@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 10:56, Manivannan Sadhasivam wrote:
>>>   		if (hs_gear > UFS_HS_G2)
>>>   			return UFS_HS_G2;
>>> +	} else if (host->hw_ver.major > 0x3) {
>>> +		/*
>>> +		 * Starting from UFS controller v4, Qcom supports dual gear mode (i.e., the
>>> +		 * controller/PHY can be configured to run in two gear speeds). But that
>>> +		 * requires an agreement between the UFS controller and the device. Below
>>> +		 * code tries to find the max gear of both and decides which gear to use.
>>> +		 *
>>> +		 * First get the max gear supported by the UFS device if available.
>>> +		 * If the property is not defined in devicetree, then use the default gear.
>>> +		 */
>>> +		ret = of_property_read_u32(dev->of_node, "max-gear", &max_gear);
>>> +		if (ret)
>>> +			goto err_out;
>>
>> Can we detect the UFS device's max gear somehow? If not, the 'max-gear'
>> property name doesn't sound good. Maybe calling it 'device-gear' would be
>> better.
>>
> 
> UFS device probing depends on PHY init sequence. So technically we cannot know
> the max gear of the device without using an init sequence, but this information
> is static and should be known to a board manufacturer. That's why I decided to
> use this property. Another option is to use a fixed init sequence for probing
> the device and do a re-init after knowing it's max gear but that is not
> recommended.
> 

Why it is not recommended? By whom? You init on some default low gear
(support for some is mandated by UFS spec) and then allow faster gears
while you know the capabilities.

> We need "max" keyword because this property specifies the maximum gear at which
> the device could operate and not necessarily the gear at which it operates.
> Maybe, "max-device-gear" would make it clear.


Best regards,
Krzysztof

