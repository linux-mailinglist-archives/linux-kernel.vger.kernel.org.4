Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2B0691D18
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjBJKo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjBJKo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:44:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A766ADC8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:44:25 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso5966079wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TuIE3DFWf1ieG26fb802V4Dw782qOhFqrgu8/YDQEqE=;
        b=dKMCjgKnXwFUENbPIxmzn+ydcATqzU+NxqCs3sCFCNlicsOMtsO3rPBam735GvIPhb
         rUraR20VRGJ1Fy7OGapqMREFwcp650BQVEh0HrAgDNQH7Du/EB/sA8rqxMCiccp66m1P
         8Z0AeT491ld8YajEfDzMIhHdANVpSalmhHAVaK39yR9lMmSnW4Jdy3q+o0Nwcx+xYXsd
         WzvBeRDPgecbg6wktNAGzeCz/r8gd0By3DFzWYsxJ89uDFuMXFdbJU984AbvZLeUYcuQ
         h0RsZVe93f4tBoJXeFxr0tTt41NrHA8qLFk+/2KyUL1w4aGhskSsgW12JvN6riHO1cTz
         nzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TuIE3DFWf1ieG26fb802V4Dw782qOhFqrgu8/YDQEqE=;
        b=31eoG9PZLZzqSwLpZUogHhyQ1G0fwnlKhqjjZWlDj7TwHLGQnx6YOWYanZqhAY6ABa
         EoNEsX4+FcLzIPk+WP0mdJ+IThKN+WjtjxhGVd5mVENw/xaQGJD15wzgkl9LjgArY5gK
         hjKDvKobHrE+FsJhks+JQ8tevIvKbR/UanA5J8ym5eX7G9mpCb14XqXsdALEjO0U6AkX
         ywh7NNKWTLYYaqQzF84lswpJGLUGiIcwKS5XYS6Gf0QBPxtq68QNBIK2/l1aiKNhLwiv
         zf6wwpGlDqBxnt4l+vgfZyCxr7yBbGBe0K5utes7wE7TaP6VqSRZrbLCbPOA+M8KxOLp
         jCSw==
X-Gm-Message-State: AO0yUKVsOmBD++zlAeC88U6eDKKZQQXvI4JzWMyRSdZ3xaEJuBTNUsCr
        y7m++HLG4lNTD0jPSErD5fYrpg==
X-Google-Smtp-Source: AK7set926XzOGdWOriKW365z+hMWb/Sk5AMamr2w66iAIEhBCEEyboHJKTqbvQfZ31hAC7hgI1I6Iw==
X-Received: by 2002:a05:600c:329d:b0:3dd:97d6:8f2e with SMTP id t29-20020a05600c329d00b003dd97d68f2emr12190714wmp.17.1676025864139;
        Fri, 10 Feb 2023 02:44:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a65:5553:55cf:3027? ([2a01:e0a:982:cbb0:5a65:5553:55cf:3027])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003dd1c45a7b0sm4878029wms.23.2023.02.10.02.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 02:44:23 -0800 (PST)
Message-ID: <06670a10-c8e9-6f87-9c16-e88a90a74469@linaro.org>
Date:   Fri, 10 Feb 2023 11:44:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/7] usb: typec: ucsi: add PMIC Glink UCSI driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v1-1-0b0acfad301e@linaro.org>
 <Y9jcYdc30G026/fs@kroah.com>
 <720aee1d-87e8-5291-c6a0-ef53e830a21d@linaro.org>
 <Y+YerQrfWgmwTErM@kroah.com>
Organization: Linaro Developer Services
In-Reply-To: <Y+YerQrfWgmwTErM@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 11:38, Greg Kroah-Hartman wrote:
> On Fri, Feb 10, 2023 at 11:31:08AM +0100, Neil Armstrong wrote:
>> On 31/01/2023 10:16, Greg Kroah-Hartman wrote:
>>> On Mon, Jan 30, 2023 at 10:54:32AM +0100, Neil Armstrong wrote:
>>>> Introduce the UCSI PMIC Glink aux driver that communicates
>>>> with the aDSP firmware with the UCSI protocol which handles
>>>> the USB-C Port(s) Power Delivery.
>>>>
>>>> The UCSI messaging is necessary on newer Qualcomm SoCs to
>>>> provide USB role switch and altmode notifications.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    drivers/usb/typec/ucsi/Kconfig      |   7 +
>>>>    drivers/usb/typec/ucsi/Makefile     |   1 +
>>>>    drivers/usb/typec/ucsi/ucsi_glink.c | 321 ++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 329 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
>>>> index 8f9c4b9f31f7..dee6069e46a2 100644
>>>> --- a/drivers/usb/typec/ucsi/Kconfig
>>>> +++ b/drivers/usb/typec/ucsi/Kconfig
>>>> @@ -58,4 +58,11 @@ config UCSI_STM32G0
>>>>    	  To compile the driver as a module, choose M here: the module will be
>>>>    	  called ucsi_stm32g0.
>>>> +config UCSI_PMIC_GLINK
>>>> +	tristate "UCSI Qualcomm PMIC GLINK Interface Driver"
>>>> +	depends on QCOM_PMIC_GLINK
>>>
>>> No way to test build this code without this option?
>>
>> Nop, the QCOM_PMIC_GLINK is a build dependency, this can't be removed
> 
> Then perhaps the QCOM_PMIC_GLINK code needs to be fixed up to allow for
> it to be built on all platforms properly?  Otherwise you are
> guaranteeing you will not get much, if any, build coverage and api
> changes will cause this code to stagnate over time :(

The QCOM_PMIC_GLINK deps are:
         depends on RPMSG
         depends on TYPEC
         depends on DRM
         depends on NET
         depends on OF
         select AUXILIARY_BUS
         select QCOM_PDR_HELPERS

What would be the changes needed here ?

Neil

> 
> thanks,
> 
> greg k-h

