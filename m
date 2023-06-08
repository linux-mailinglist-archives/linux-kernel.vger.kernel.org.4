Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D833728291
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbjFHOXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjFHOXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:23:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F54D2D4B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:23:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso6069755e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686234187; x=1688826187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDI2LBlFR8sITE2QFoLi3AUonttlw9k/UkWS9UEYZTk=;
        b=lC10Wy9gPzHJ6NnRAsIwUXnVpDb4XlofuxCgQjtk/rjWYr8LaqO/4tZz5jBjg1dy0+
         i1d3+ywhfHP/z3TZRxyse48aQV29v6+ymP9Y2xfOnmsafHMF7OU8MFnqh5OG4j2SI4Eh
         gr6xDrGNBIF3R9PSPaIiuAOfpjwKg6Nn+7FWN+I7nK8rvfsJ6HxZm5n3z6XTRDebz5BH
         9Xwg9rdveV0wz/Ifywl/ek2ibxhIpCOKIl7fbLZZmMMFrdH3sFjzbjIa2QdEDsfCfR3u
         jSBlxUnUgG9q8tLuHOE6oGt3K+oW2rRrra3zBg+hQsLkYSpNhbWkWZlNdh1Jpy8MMu4C
         uCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686234187; x=1688826187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDI2LBlFR8sITE2QFoLi3AUonttlw9k/UkWS9UEYZTk=;
        b=lMrkx/qt4bIVbgGEzrEoUIto06E70J1MFBui1UIdPoTuE4QhJHY4yIsA5xaeESWAya
         6tMSylaaMgXhOeoay27fJOTfkG2VP6y4E13JNgS8KVL4ZlJ0E2IrA6TsrX6wLCYqFSFc
         NvyhqPPmvMucbZIwRpwHH77BnHo4niKB66JW3SaSrDT9c4RZH55WLdVKNhpQPzNiCn8m
         ekAT5c35d1+gmLXQoMil3B3JQzzuqdqHASWj11FWkMiBlS9i3pUWwHF6l4b+vyR4dlny
         QW3TDSWciOH28QqXk3Zc0I2dWMH61qf2G9etqoavMQLBW4+KMduV3YM+mCd2iXcKy3re
         bc4A==
X-Gm-Message-State: AC+VfDw5E5lxDlnxjR1X7TcMDmdsUtZ3uiOJZSpMCIDP3C1Ogd3vH98v
        3lECYWtwxl9yvtjvMQwVtyG6gw==
X-Google-Smtp-Source: ACHHUZ70DZ36Tht5HkFG+bq4gQE4IqNFTe2YyyowzeRiFrZVN+Uf+ci5LYbWchKC8QNsI1RTxeAM6w==
X-Received: by 2002:a7b:cc84:0:b0:3f7:2323:e012 with SMTP id p4-20020a7bcc84000000b003f72323e012mr1498068wma.5.1686234187535;
        Thu, 08 Jun 2023 07:23:07 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id b14-20020adfe30e000000b00307a86a4bcesm1737355wrj.35.2023.06.08.07.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 07:23:06 -0700 (PDT)
Message-ID: <71712242-ffc3-69d0-6abe-6ee61d3630bf@linaro.org>
Date:   Thu, 8 Jun 2023 15:23:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/4] soundwire: qcom: stablity fixes
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     vkoul@kernel.org, andersson@kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
 <ZH2l-UbMyLi5Uwph@hovoldconsulting.com>
 <5d6bcc6a-151e-ac21-2dd2-f72a91f562d5@linaro.org>
 <ZIGpYPrNYDlkRQIf@hovoldconsulting.com>
 <ZIHMMFtuDtvdpFAZ@hovoldconsulting.com>
 <a236e2f6-0fd7-f814-f68d-ae0a3e3dfc92@linaro.org>
 <ZIHSGf18w7htb9o8@hovoldconsulting.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <ZIHSGf18w7htb9o8@hovoldconsulting.com>
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



On 08/06/2023 14:05, Johan Hovold wrote:
> On Thu, Jun 08, 2023 at 01:45:22PM +0100, Srinivas Kandagatla wrote:
>> On 08/06/2023 13:40, Johan Hovold wrote:
> 
>>> Looking at the above log it seems like we hit a probe deferral somewhere
>>> as some resource is not available yet, and this is eventually turned
>>> into a hard failure that breaks audio as the error is propagated up the
>>> stack.
>>
>> I was looking at this too, And I think this change should help..
>> Not tried it though
> 
>>    	ret = snd_soc_tplg_component_load(component, &audioreach_tplg_ops, fw);
>> -	if (ret < 0) {
>> +	if (ret < 0)
>>    		dev_err(dev, "tplg component load failed%d\n", ret);
>> -		ret = -EINVAL;
>> -	}
> 
> That in itself only seems to make the problem worse with new follow-on
> errors. Looks like a dereference of an error pointer in a codec driver:

Thanks Johan,

I will try to see if we can fix this properly.

--srini
