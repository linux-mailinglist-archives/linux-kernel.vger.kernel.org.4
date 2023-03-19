Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6286C026D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjCSOe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCSOe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:34:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385A619C7C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:34:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b20so4606625edd.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679236494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13RptpPwU9CeIgu972ZARQHg4l6hn6RYakrP4lUSAIE=;
        b=jhidRbbQnrEJ7yOVgGoL3BUqzLX6xT2MlTC3071eYARrvKpnEGBHbcz8PYAkVPQ+8h
         QyqIC20VPp49BjMuxWMVOafio5J1yVwKC1bGist5t/s0/u8jUSJCrEi28nmugNocClJ7
         7WjzsCx/HhfIgELuP5q3mXDsP/crTubf6RjJEs0DSg8eBeitR8zeymfVf536NwlAXPhk
         3NnVCTpNxMJOsnAly1DM2JeG/7gsgyh2qtKIOMvvvLdFTyw1973agxDXLOCMhSTG2nUY
         HDbrz+iCo1Ka5L6KlOKEKQaY1qJAcnUoTvPo+S1AXFzLoniKnT3r9iZAo+HJht+3E2q6
         KalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679236494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13RptpPwU9CeIgu972ZARQHg4l6hn6RYakrP4lUSAIE=;
        b=yBDhqwGh7pQ8+28nYcEM8k8BlYFKmLSU3dIM1d1bZIkLZh+2icArTOdl5NSFH9M824
         nQC1Jxsb38LZv6NNZ96cN/6rxTqyl/edkPhC4jfnMZ/9pCkhEqWG7a8GdzxkzUvArBBO
         aEwKjcTtFi49blqzRRNefl7L+4TYtszhjI5+PKIXj0mVlWNuvTB7+NIvNwdCtAmtpLe9
         3Xl4RrSHcxv9cKBhKvWGNEL13BIQJak8LofTuy4a+AKmBcK2iCNG5pVqRCn4TXQ+a1y5
         dFNrNWFI4KCzb9BbRLcIwxrxYRP2io+B5W5Djp8zyzsopxTPFMfaboLxUNQdQeoPG4Pm
         e+fA==
X-Gm-Message-State: AO0yUKX/9qUeADm4stGIn7bjdNL6F3lYU1O4WwK5D6GXJecCvN+vUdcQ
        nzJplRZ63Dy4Og2RbaEkCUw=
X-Google-Smtp-Source: AK7set+oNEI5AB+Y6WRuVS4gibvoEWkUa8W7ULuy6tVY+CD196jC9edB8c62cUbgWPEN8DM8ylUDJA==
X-Received: by 2002:a17:907:2da5:b0:92b:eefb:b966 with SMTP id gt37-20020a1709072da500b0092beefbb966mr7966700ejc.0.1679236494588;
        Sun, 19 Mar 2023 07:34:54 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id w11-20020a1709067c8b00b009231714b3d4sm3242978ejo.151.2023.03.19.07.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 07:34:54 -0700 (PDT)
Message-ID: <54840613-5382-2aaa-acdc-2e28470913c4@gmail.com>
Date:   Sun, 19 Mar 2023 16:34:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] staging: rtl8723bs: include: use inline functions for
 dvobj_to_dev
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        namcaov@gmail.com, straube.linux@gmail.com, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20230319131030.151170-3-eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303191509330.2867@hadrien>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2303191509330.2867@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ١٩‏/٣‏/٢٠٢٣ ١٦:١٣, Julia Lawall wrote:
> How have you chosen the names at the beginning of the subject line?  The
> other patches on this file don't have the word "include:" in the subject.
> Please see the section "Following the Driver commit style" of the tutorial
> to see what to do.
Okay, I will check it.
>
> On Sun, 19 Mar 2023, Menna Mahmoud wrote:
>
>> Convert `dvobj_to_dev` macro into static inline function,
> "into a static inline function"

I will fix it.

>
> But the message is a bit too verbose.  Please see my suggestion on another
> similar patch that was recently proposed.
>
> julia


I will to rework on it, thanks Julia appreciate your help.


Menna

>> because it is not great to have macro that use `container_of` macro,
>> because from looking at the definition one cannot tell what type it applies to.
>>
>> One can get the same benefit from an efficiency point of view by making an
>> inline function (concretely, typically a static inline function, because
>> the definition only needs to be visible in the current file, or in the
>> case of a header file in the file that includes the header file).
>>
>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>> ---
>>   drivers/staging/rtl8723bs/include/drv_types.h | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
>> index 82159e1c7f9b..ea6bb44c5e1d 100644
>> --- a/drivers/staging/rtl8723bs/include/drv_types.h
>> +++ b/drivers/staging/rtl8723bs/include/drv_types.h
>> @@ -305,7 +305,11 @@ struct sdio_data intf_data;
>>   };
>>
>>   #define dvobj_to_pwrctl(dvobj) (&(dvobj->pwrctl_priv))
>> -#define pwrctl_to_dvobj(pwrctl) container_of(pwrctl, struct dvobj_priv, pwrctl_priv)
>> +
>> +static inline struct dvobj_priv *pwrctl_to_dvobj(struct pwrctrl_priv *pwrctl_priv)
>> +{
>> +	return container_of(pwrctl_priv, struct dvobj_priv, pwrctl_priv);
>> +}
>>
>>   static inline struct device *dvobj_to_dev(struct dvobj_priv *dvobj)
>>   {
>> --
>> 2.34.1
>>
>>
