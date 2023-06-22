Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED71173A584
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjFVQFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjFVQFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:05:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3418E199F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:05:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f90a7325f6so63366145e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687449933; x=1690041933;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJvW53nb5FqsEkcvRqWfBEYOlULL4XurfYmevN3ZIow=;
        b=qO0Kt3yIWHDBqDbonun3S9MAe5A13eXySTWkUs/FyFHlAcUNw0bSn85wz2QURPq4Mz
         KyVoNlo/M7b9nj6A1xrQopmp6taNeq1pbgArN4uyF8rJdN9MaeqmOTRLExf3OgG3mZii
         Yik6a2qEMEMQKwiqO7url3ELGD+ooK5UZjr8BJhPDiDwUEShmyk/OyIvxRssO1Iil7ZP
         AWFC/O93h7TjrFO25UT+VR6mViImx84ZI8i7vXLonWfXHPdlELrVM7suEJKe6Zc7VVRa
         PFytufxKkheVFVXDAJMxG2SixpnJVRjrNPBzCMVhUKlcQXgwTlFqS8KbKfpM2hbzucYj
         Go+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687449933; x=1690041933;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oJvW53nb5FqsEkcvRqWfBEYOlULL4XurfYmevN3ZIow=;
        b=XB43HE9weCZKXw54+oPnJISNhNgKypqUzLSIuKy+R8oOHvNgkzYfKGUfu2UnZ7u2yH
         95K5ZwRG3Bh9CFtI/teVfvkbaPI4+7RHJM24jG3fhYamzjlVAJMjEJ//UNrFZ//cxo5g
         a7Unj0xPYWnlqrG9/zBNEHqbg7v1ae+IRscYrLwiDl8D1EnPKZ+WNBJzyhxh8brsYoKR
         mUl5GlI7SleS5/ecspTr5ADI8AOP7XYa/jWuM9OUJ7R0WdcOYHyP/MGIx+mL1WpXYK2y
         bTWqeiimCC1lsllu29pqMbGJhSgoi8YIgJwNBlKYD1ZZENPipbXoI3rdCk38SKxb9I24
         jC8w==
X-Gm-Message-State: AC+VfDxqqmNzdAMLNqrXYJMxIsBXpL+SODiy6E0MhMAIsIxkigFBwZgW
        iyAXlsA9JMq1XXkuxvbeSwq1sg==
X-Google-Smtp-Source: ACHHUZ7zuWEAk46hkD3RVwgfRUChkcs9OeigokRCbBkqGV0LoJuK2c4EWs57vmketmZrCtFApakQJA==
X-Received: by 2002:a7b:c017:0:b0:3f6:2ae:230e with SMTP id c23-20020a7bc017000000b003f602ae230emr18140379wmb.3.1687449933428;
        Thu, 22 Jun 2023 09:05:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f692:a800:4794:385? ([2a01:e0a:982:cbb0:f692:a800:4794:385])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b003fa52928fcbsm2461858wml.19.2023.06.22.09.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 09:05:33 -0700 (PDT)
Message-ID: <988aa0ec-c6a1-70ce-cd4d-abc2b2948323@linaro.org>
Date:   Thu, 22 Jun 2023 18:05:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230622101813.3453772-1-arnd@kernel.org>
 <286cf2d8-2da8-7203-ee53-bf08332fa519@linaro.org>
 <f28f78fc-84ce-4990-9126-4075f3d88e01@app.fastmail.com>
 <9c52ce87-f69c-e69c-ec43-6b2cc3b37c4a@linaro.org>
 <227ff023-a0fb-476d-ae5c-0733cc6223eb@app.fastmail.com>
Organization: Linaro Developer Services
Subject: Re: [PATCH] usb: typec: nb7vpq904m: add CONFIG_DRM dependency
In-Reply-To: <227ff023-a0fb-476d-ae5c-0733cc6223eb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 17:57, Arnd Bergmann wrote:
> On Thu, Jun 22, 2023, at 17:39, Neil Armstrong wrote:
>> On 22/06/2023 13:24, Arnd Bergmann wrote:
>>> On Thu, Jun 22, 2023, at 12:39, Neil Armstrong wrote:
>>>>>     
>>>>>     config TYPEC_MUX_NB7VPQ904M
>>>>>     	tristate "On Semiconductor NB7VPQ904M Type-C redriver driver"
>>>>> -	depends on I2C
>>>>> +	depends on I2C && DRM
>>>>>     	select REGMAP_I2C
>>>>>     	help
>>>>>     	  Say Y or M if your system has a On Semiconductor NB7VPQ904M Type-C
>>>>
>>>> I think it could be :
>>>>
>>>> +	depends on DRM || DRM=n
>>>> +	select DRM_PANEL_BRIDGE if DRM
>>>
>>> As far as I can tell, this would only avoid the link error
>>> against devm_drm_of_get_bridge(), but not the one against
>>> devm_drm_bridge_add(), which is defined in drm.ko through
>>> drivers/gpu/drm/drm_bridge.c.
>>
>> I'm trying to reproduce such situation, but so fail I fail.
>>
>> In the driver there's a guard to avoid calling into DRM functions
>> when disabled:
>> #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
> 
> Ah, you are right. I got confused because the check is in
> header file for devm_drm_of_get_bridge(), but not for
> devm_drm_bridge_add(), which has the check in the source
> file as you point out.
> 
>> so I wonder which kind on config leaded to that since
>> CONFIG_DRM_PANEL_BRIDGE is only enabled when DRM_PANEL and DRM are.
> 
> I only saw the original issue with
> 
> CONFIG_DRM=m
> CONFIG_DRM_PANEL=y
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> CONFIG_TYPEC_MUX_NB7VPQ904M=y

Ok now I see it

> 
> and since CONFIG_DRM_PANEL_BRIDGE already depends on CONFIG_DRM,
> I think that is the only one that can go wrong, so your
> suggestion of
> 
>     depends on DRM || DRM=n
> 
> should be sufficient. I see that DRM_PANEL, DRM_BRIDGE and
> DRM_PANEL_BRIDGE are now always =y whenever DRM is enabled,
> so I don't think the 'select CONFIG_DRM_PANEL_BRIDGE' serves
> any purpose any more, but it's also harmless if you think it
> helps for clarification.

Yes DRM || DRM=n seems sufficient, but having
select DRM_PANEL_BRIDGE if DRM could clarify things.

> 
> Can you send the updated patch, or should I?

I'll send an updated patch,

Thanks,
Neil

> 
> 
>       Arnd

