Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5858E73E08B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjFZNXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjFZNXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:23:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E921AB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:23:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso701332e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687785793; x=1690377793;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FX52cR42UjsCJaM68RlRM+9U+7DEs1rV1cvkX/J08Rg=;
        b=lW8CiMt8OoOEdsnfIH/829zvDo9LhMmt9uwOZByFaoqoTSTnFf1/9zLumViORWwvzL
         V+1Asd9cQXswC4xk+NAzUMZQiqZBw9xxPWy3dFScUSqc+GPfaknQ6QJ6JXSR3HfvTB7r
         HN5lwHmSOBD8R8bsl8QD4WwByW4BsSigr0/IG2ffOHmBvtFkZN8wB6MhvSvNijEi45PX
         tUZc7ttHb1GIHkWbV8u+yHJxW5Jtc8U2IXT5nmtMJegkI/KkUNVzlALNJNCORigIwAiU
         Yq2c/9LSoe4DsSThii8uc///p3NjJB77dk2bUVnPMvwxUP1EkFXAiYnBgWy2zsJykFV+
         5SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687785793; x=1690377793;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FX52cR42UjsCJaM68RlRM+9U+7DEs1rV1cvkX/J08Rg=;
        b=RJBlb6jjC20AIg5iIVddb+LijcOJcRksIlfrv6mNKd4lRwDgvTjftzu+My13sI8mmV
         egHusNp6NTnRY+CngLVmxhQ02K4/HFuYSFBz+dd5L+4tfGL+YbL54nEyEjqpKrhLY65U
         M6HsUVh5B5/k6+iS09aebNKzX1i657IDzq1VZl2BNwQd+7G3YR8+cLPOzRD6Lts+UeQ+
         PLl7Cmc3KJ5Ske8tn2ImKEex1qL6BBKydrtc57j6vDYev1D/SqrHhq88oUGB5Hwh1V/h
         Z+o/VxouR27bk0PxlVAvsgzksnRUiKD2MCfhJ6T40/PWbcOF81lyDBFqB78Oj4YKuTlg
         c+WA==
X-Gm-Message-State: AC+VfDz5ZsKx1gjX9E0l7M6Hq87cS7Iim+bip7D0O7Hvh8aGFVL5kwPe
        mOt2ISLuDIIzgK4lGrmm4xgqaQ==
X-Google-Smtp-Source: ACHHUZ6ThfhatPMJ0vxDsoclNGj83u9LNnGVVi4gVS3IPbj6ktLOHHmeDqsmxik2zI19UoDqnGGvWg==
X-Received: by 2002:a19:ca02:0:b0:4f9:586b:dba1 with SMTP id a2-20020a19ca02000000b004f9586bdba1mr7763330lfg.4.1687785792656;
        Mon, 26 Jun 2023 06:23:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b25a:b26e:71f3:870c? ([2a01:e0a:982:cbb0:b25a:b26e:71f3:870c])
        by smtp.gmail.com with ESMTPSA id h11-20020a1ccc0b000000b003fa8158135esm8427591wmb.11.2023.06.26.06.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:23:12 -0700 (PDT)
Message-ID: <c0bb8255-db4f-e93b-5593-0faa32e44410@linaro.org>
Date:   Mon, 26 Jun 2023 15:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] usb: typec: ucsi: call typec_set_mode on non-altmode
 partner change
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230614-topic-sm8550-upstream-type-c-audio-v1-0-15a92565146b@linaro.org>
 <20230614-topic-sm8550-upstream-type-c-audio-v1-1-15a92565146b@linaro.org>
 <ZJlIViwb9sfNrgjH@kuha.fi.intel.com>
Organization: Linaro Developer Services
In-Reply-To: <ZJlIViwb9sfNrgjH@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/06/2023 10:12, Heikki Krogerus wrote:
> Hi Neil,
> 
> Sorry to keep you waiting.

No problem, thanks for reviewing my patches!

> 
> On Wed, Jun 14, 2023 at 03:10:39PM +0200, Neil Armstrong wrote:
>> Add support for calling typec_set_mode() for the DEBUG, AUDIO
>> accessory modes.
>>
>> Let's also call typec_set_mode() for USB as default and SAFE
>> when partner is disconnected.
>>
>> The USB state is only called when ALT mode is specifically
>> not specified by the partner status flags in order
>> to leave the altmode handlers setup the proper mode to
>> switches, muxes and retimers.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/usb/typec/ucsi/ucsi.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
>> index 2b472ec01dc4..44f43cdea5c1 100644
>> --- a/drivers/usb/typec/ucsi/ucsi.c
>> +++ b/drivers/usb/typec/ucsi/ucsi.c
>> @@ -809,6 +809,23 @@ static void ucsi_partner_change(struct ucsi_connector *con)
>>   		break;
>>   	}
>>   
>> +	if (con->status.flags & UCSI_CONSTAT_CONNECTED) {
>> +		switch (UCSI_CONSTAT_PARTNER_TYPE(con->status.flags)) {
>> +		case UCSI_CONSTAT_PARTNER_TYPE_DEBUG:
>> +			typec_set_mode(con->port, TYPEC_MODE_DEBUG);
>> +			break;
>> +		case UCSI_CONSTAT_PARTNER_TYPE_AUDIO:
>> +			typec_set_mode(con->port, TYPEC_MODE_AUDIO);
>> +			break;
>> +		default:
>> +			if (UCSI_CONSTAT_PARTNER_FLAGS(con->status.flags) ==
>> +					UCSI_CONSTAT_PARTNER_FLAG_USB)
>> +				typec_set_mode(con->port, TYPEC_STATE_USB);
>> +		}
>> +	} else {
>> +		typec_set_mode(con->port, TYPEC_STATE_SAFE);
>> +	}
> 
> Can you do that (set safe mode) in ucsi_unregister_partner() instead?

It seems greg already landed the patch into usb-next, but I can send a fix to
move it to unregister

Neil

> 
> thanks,
> 

