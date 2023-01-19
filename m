Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5F0673475
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjASJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjASJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:30:44 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB766840F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:30:41 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l8so996891wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jhnJi4E9sVUGqGUkCWG7nWSX0QsmXM9XnP6ncuKyEHg=;
        b=O1+2E6ROy3ivIGtDdoRnwXKd36Hq/Niu9lmsGsdB0LYqcgv/kU3gNm+AtviRK7tIcJ
         jytvFeN1D2wThPYDyiKmnI0ulomRVPjPU+8+YvD0YBKGb+icXkkVrCboVXZDzjedkVm/
         U9XgrekTIG+c8YSlqFN/bucsactpMQxVM8hwxbFaRCUC+QZPXB9YeZU96W5Qp6YulHZS
         77t/ZZpg5ZZyhNETEpeiAjS6f9dKS8GWPMaJI4YUi7JdM86MoWbUo1YY2oeGOjPHb4MK
         5n0f5YVqRJWEJeqGOEOtV3i6wdFCB4wgdievYyvg7pWoKZdOl0DblPpUOnnpfLQ5ZMTI
         8OhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhnJi4E9sVUGqGUkCWG7nWSX0QsmXM9XnP6ncuKyEHg=;
        b=R+2VD0kZqBjBBD1sx9+cuta3NGO/0Uw4GwZBbqxGH2R5dQL+2O6g6Iuv4U7fAQpWAE
         Zfjyn1jvElOUjymsPtJ0kES1LrByPbNvWuAx9L6rwWcsjGRHSrBB4g6a8HaRha7uV4g8
         TCBWNOq7t3uZdlCkjs3LwJhIWVnyOrWOsfmD2f5rM+70EPN2kbf9k8lyzJgb9i+mUR8a
         E/T2juw/UYF7h7w/Zz/tdmudyjH19ocBvfculqJoPJPD6q063RwOLs62o9Kz+OCtYFx+
         0DH0UNpxkiuuy2i2yF3vphOQstgWTRQZBWvsahJQVtTi9VResLQCyHdSfHGZOH2wzJdA
         HTAw==
X-Gm-Message-State: AFqh2kqlazJaOK3/K7jBtNDYRwMT2I7wq7e4YrBg8vChShWSBrRRtr3G
        JTIH0aInIl8oC20Fa4jqGbbd2S/8Z6sNMu3W
X-Google-Smtp-Source: AMrXdXsaV7kG3/vMfBxbKk0tSIsvYEESQ3zjv7ECywgahy3brNpKw+vpcXRtWy6qssPU9RwPq3cQkw==
X-Received: by 2002:a05:600c:35c1:b0:3db:1424:e781 with SMTP id r1-20020a05600c35c100b003db1424e781mr4859886wmq.23.1674120639282;
        Thu, 19 Jan 2023 01:30:39 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g9-20020a05600c310900b003c21ba7d7d6sm849700wmo.44.2023.01.19.01.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 01:30:38 -0800 (PST)
Message-ID: <db701c97-883e-f231-68fa-c851c6a1a862@linaro.org>
Date:   Thu, 19 Jan 2023 10:30:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/5] thermal/core: Remove unneeded mutex_destroy()
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
 <20230118211123.111493-3-daniel.lezcano@linaro.org>
 <92a6e8494b92f0bb8cb36c98d2237ee3d347c358.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <92a6e8494b92f0bb8cb36c98d2237ee3d347c358.camel@intel.com>
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

On 19/01/2023 08:41, Zhang, Rui wrote:
> On Wed, 2023-01-18 at 22:11 +0100, Daniel Lezcano wrote:
>> If the thermal framework fails to initialize, the mutex can be used
>> by
>> the different functions registering a thermal zone anyway.
> 
> Hmm, even with no governors and unregistered thermal sysfs class?
> 
> IMO, thermal APIs for registering a thermal_zone/cooling_device should
> yield early if thermal_init fails.
> For other APIs that relies on a valid
> thermal_zone_device/thermal_cooling_device pointer, nothing needs to
> be changed.
> 
> what do you think?

I think you are right.

It would be nice if we can check if the thermal class is registered and 
bail out if not. But there is no function to check that AFAICS.

Alternatively we can convert the thermal class static structure to a 
pointer and set it to NULL in case of error in thermal_init() ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

