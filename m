Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E18E671F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjAROOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjARONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:13:41 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9DA8F7D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:54:15 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t5so29594054wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=albyR7M4Sm1x20MXpcc41ksmutN77dAypqH0FLe54vc=;
        b=MImtZjXKS0rmylobnKCZ4FiFnLoo+rdZlvS910ec4gSGRn3zSnPT5N1YwzzPJxW9g3
         jjE7GwDB6ypOwSakYSsheMATxG3N1ZU5g0F1zwNEYGBhbR+JptgPed9RBpCrC7OIU943
         UF1fslpkxAJztxIMoH14KeyIxDjfY0NLce4ZnTVqGmAUmCCxx2Vi181QjYMtOruEVGoC
         iLOsVsPuq3snExveGavDoksNwqldLrmFMRrgyJqVf9zGJchw+EMPPm5pMbpvcDXX/rVJ
         F3EaVPrq7+aRLJbjvHBQ4K7Tt6+r/Qc22HTsk0W9wQ5xmvn8yzc/nD1WMBEJkeZb4wvD
         yqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=albyR7M4Sm1x20MXpcc41ksmutN77dAypqH0FLe54vc=;
        b=brilE900Mn88To4Y1lijPl7FnL64kymg+y/biSjDdSB0YvOABz4tNi6NrcPQmfPnfe
         +/4GKIcvgbdyHeD+aCuNIMAMetSShaKoMQymgGD3Ga43ehe1NW1nUELe+O58oHKhIPAT
         gi/DbhNjnXyg5oxzdzR4udhYKqvk9m59nWA87T0Go1GfY5MH4fIFfTsgUkl7n8zLzT+H
         HFVWSkNGucQSSeAwXzoYOq/4p8QFewlFlv5dwglW1BvANvYKeDb3qXdN5Posrfa/9peY
         nI8S8G84hm8br6CCJ5QgAlrRjJAlvIkDUSbN3z+PYP4WXK85Az+PoR97HI9VOXLlb8kP
         3wbg==
X-Gm-Message-State: AFqh2kre5rfC0hochs2W4q9gIlW3x0JVTATrfvzPibeO/bhQWS5B9bfX
        dS6lkgc2/c6WgGQAjwQkyetuCw==
X-Google-Smtp-Source: AMrXdXtoEO8B7QGqynVQp+xWpMt9v69XXMYM9zTidPENMGvfz9wRlUohKjlrN7LZiZfr63gC0xbHhg==
X-Received: by 2002:a5d:6b01:0:b0:2bd:fd81:b503 with SMTP id v1-20020a5d6b01000000b002bdfd81b503mr6368975wrw.1.1674050053800;
        Wed, 18 Jan 2023 05:54:13 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l6-20020a5d4bc6000000b0027323b19ecesm31157157wrt.16.2023.01.18.05.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 05:54:13 -0800 (PST)
Message-ID: <541df469-3ac4-0702-8382-7cdc6880273b@linaro.org>
Date:   Wed, 18 Jan 2023 14:54:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
 <f76c13de-d250-ebc0-d234-ccb3a9ce3c28@linaro.org>
 <2627c37e07dce6b125d3fea3bf38a5f2407ad6a1.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2627c37e07dce6b125d3fea3bf38a5f2407ad6a1.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 14:48, Zhang, Rui wrote:
> On Wed, 2023-01-18 at 10:53 +0100, Daniel Lezcano wrote:
>> Hi,
>>
>> On 13/01/2023 19:02, Daniel Lezcano wrote:
>>> Recently sent as a RFC, the thermal ACPI for generic trip points is
>>> a set of
>>> functions to fill the generic trip points structure which will
>>> become the
>>> standard structure for the thermal framework and its users.
>>>
>>> Different Intel drivers and the ACPI thermal driver are using the
>>> ACPI tables to
>>> get the thermal zone information. As those are getting the same
>>> information,
>>> providing this set of ACPI function with the generic trip points
>>> will
>>> consolidate the code.
>>>
>>> Also, the Intel PCH and the Intel 34xx drivers are converted to use
>>> the generic
>>> trip points relying on the ACPI generic trip point parsing
>>> functions.
>>>
>>> These changes have been tested on a Thinkpad Lenovo x280 with the
>>> PCH and
>>> INT34xx drivers. No regression have been observed, the trip points
>>> remain the
>>> same for what is described on this system.
>>
>> Are we ok with this series ?
>>
>> Sorry for insisting but I would like to go forward with the generic
>> thermal trip work. There are more patches pending depending on this
>> series.
> 
> The whole series looks good to me.
> 
> Reviwed-by: Zhang Rui <rui.zhang@intel.com>
> 
> But we'd better wait for the thermald test result from Srinvias.

Sure, thanks for the review !


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

