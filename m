Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B5766012B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjAFNZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjAFNZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:25:07 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C7376831
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 05:25:05 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ja17so1039178wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 05:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEJY9SspoKTdZNWPwR91nPyxh8XhVna7p82Tp53xTkM=;
        b=FwHqLtth3iznDY87TFgqK4Zn/1OcPQR4+7tsaECyjX5gTy7VJeXCBa2UKhYwDE2igy
         etxWyPKfhNpF/NL4DyQXYI52QHoCtXOgZqLyVqiOSFeBxxbDKNsuvPm2D1Tkf4KbBJpl
         Pj1gyqVLqICtyGLYOiBFN4gxnCs1RpyjxcQzGe0OHlgDthlcCrso5YZBWsomjQ97z1z4
         bISVczJ2qYo08Vh+Fb52XNzwdxivBRWh3cCaQqVrkaMEPtfxoBtNGB+vliHxtQJdLlIg
         ta8tmqLJCCIusrzZJm1+rcosVa90dXeG4oNe64z4cT1SFqyCg5/GuQIf7K8ihFhyrZQm
         t04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEJY9SspoKTdZNWPwR91nPyxh8XhVna7p82Tp53xTkM=;
        b=KHVVu289KNEM3wiLjHP0RNPNtjcr7fmMAxP+QeP8qHrTlfl8LvH7MjzMpmLbbP4xod
         wWR9gjIVM8AjGYOXztx+tJi7dHFs/NWQqPuqzpa8Sigu2FjeZ4wKINceBnxpC/z/O9SO
         yFUu8Fe0O9RPXfmDqCOjPo+6FeeB1zq/WBadEcFW+nT9U6L2A/b3WtTre3r/DuhuplVr
         Our2+vEj/k4pmhzSeOH1bPqR01bBQKWCOguJyG6n0yv++mBGhil0OTSHSn1SX/OAzOmB
         UFa7sHSfOfzm9OA4+ZHqBjDSCrcyNgCsQ9AC2UZbDsuNIn4XhjiUExNU7KqAd2Y+Z7K3
         4WlQ==
X-Gm-Message-State: AFqh2konk+FvSMwU5+fR1l/h0QKPY2ghVvi5vAFzKYIjtNvWpx4KByR7
        9R2u38RYo2SJPJnL9pTPVv9y/A==
X-Google-Smtp-Source: AMrXdXt/n4jIfSt4F2r2JsJZVN39pMvLBWt5DXH1nuCZ9AUQMH3gVY4D9x7i9DeGKU1+3pcI6Cpc/Q==
X-Received: by 2002:a7b:ca4f:0:b0:3d3:56ce:5673 with SMTP id m15-20020a7bca4f000000b003d356ce5673mr41656067wml.6.1673011503623;
        Fri, 06 Jan 2023 05:25:03 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f11-20020a05600c4e8b00b003d04e4ed873sm7040282wmq.22.2023.01.06.05.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 05:25:03 -0800 (PST)
Message-ID: <9feeb96d-f5d6-d903-91bc-4fa54d0e0744@linaro.org>
Date:   Fri, 6 Jan 2023 14:25:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/3] Thermal ACPI APIs for generic trip points
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20230104222127.2364396-1-daniel.lezcano@kernel.org>
 <cef493c6d918565d1b8c16aedadf5a19edd48b48.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <cef493c6d918565d1b8c16aedadf5a19edd48b48.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 09:25, Zhang, Rui wrote:
> Hi,  Daniel,
> 
> On Wed, 2023-01-04 at 23:21 +0100, Daniel Lezcano wrote:
>> Recently sent as a RFC, the thermal ACPI for generic trip points is a
>> set of
>> functions to fill the generic trip points structure which will become
>> the
>> standard structure for the thermal framework and its users.
>>
>> Different Intel drivers and the ACPI thermal driver are using the
>> ACPI tables to
>> get the thermal zone information. As those are getting the same
>> information,
>> providing this set of ACPI function with the generic trip points will
>> consolidate the code.
> 
> My understanding is that the ACPI thermal driver
> (drivers/acpi/thermal.c) should be one of the top users of these APIs.

Yes, correct.

> Is there any specific reason that it is not included in this patch
> series? or is it just that you don't have ACPI thermal driver running
> on your test platform?

The generic trip point handling in the acpi thermal driver is another 
story. Some code reorg and cleanup should be done before. I have a 
series for that but I need to test it more. That is the reason why it 
will be submitted after this series is reviewed, so the changes will be 
focused on the acpi thermal driver only.

I have a laptop with acpitz but only the critical trip temp.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

