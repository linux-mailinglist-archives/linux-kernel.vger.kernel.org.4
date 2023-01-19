Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D8B673571
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjASKZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjASKZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:25:35 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C874DCEB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:25:34 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h16so1344457wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZPsqFx3N2mmetQ9IPUz/o5Ei0eo+cmPrq1DjOstt2U=;
        b=MJWEQ5YxvQO/KtG8yraOUX4CV9Y94kp3bly+P+taebUCUPTqA0FTLAry7ndjC4Jcds
         IdpXITWz5/oqJM4/9/4q1ign137txyKrOaBVi0V6Rt5v7sPuuFStqGlcDJWhzd4mKQKN
         VoWoppK5uodLiYc974plSupqfQv9Rm3le1E95l71rZ3SW+ddppk6Rn1keyY5l6eK5/7k
         Ak9je9NrfgzPego6uUFZM09G5FXG2pyXBw4ehu0ElKXA8zAQF4ma981HCuza3wyDorF0
         Q+PUWxYc/Seo7nnxPoiRAbH7kB4YqmKmo6J5DByveueUQGcTcYwmgEATQarpfrvCVaha
         4Fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZPsqFx3N2mmetQ9IPUz/o5Ei0eo+cmPrq1DjOstt2U=;
        b=dhNjMGRQ4okr7k8NdOrhmbbE162m3QHOUSa3BtDjsXpvVzB+I9cgK/LdbUDhK6vkuX
         DXRLvEb8Ek5edJdwVO7WmryTNPdSiEYU/1mivI1MAqev/7u8pSjJWHe0/+3VxNky+PB2
         TrAplD57XVdE0cWHRRRh9gOi/1ILEXcXTZgzLV+3vqPqyCGgGepRWWb9LQ9dRYYd0hTx
         w/jeu+3e8MKG5ll11/eHVNiErKOhguEMp/b7NC9qlNQrG2Ul+J4hNDfQctIJGauI+bsJ
         ZGREfxIjTPurpJEt+zAn5T9uJGl9mG2Y0Af7Ppo1T6J0gaq/ttQdF9pGGO8bnZlHDywA
         Blxw==
X-Gm-Message-State: AFqh2kplB6w6CGjjdytS4BAD6572F1MugBPTaOaw2q08cBjIOtc230mM
        eFSxbUOBe0Emgcx8TGogpvyhtg==
X-Google-Smtp-Source: AMrXdXtzkD23ITweixx6i2fklGVpeNFgVYzuFJhdqSjGlRzgFPKyYkDuQ9kwqM141fy6sRseX/gLkw==
X-Received: by 2002:a5d:5e85:0:b0:2b6:2eb3:82a1 with SMTP id ck5-20020a5d5e85000000b002b62eb382a1mr5497731wrb.67.1674123932401;
        Thu, 19 Jan 2023 02:25:32 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r11-20020adff70b000000b002bdf290efdasm10768285wrp.58.2023.01.19.02.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 02:25:32 -0800 (PST)
Message-ID: <d852675e-fdae-ec02-a4d1-4f3c7c8f64d7@linaro.org>
Date:   Thu, 19 Jan 2023 11:25:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/5] thermal/core: Sort the trip points when registering a
 thermal zone
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
 <20230118211123.111493-5-daniel.lezcano@linaro.org>
 <f515876ea2e43e734b8d4ac7feda7f17ee04894f.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <f515876ea2e43e734b8d4ac7feda7f17ee04894f.camel@intel.com>
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


Hi Rui,

On 19/01/2023 08:22, Zhang, Rui wrote:
> On Wed, 2023-01-18 at 22:11 +0100, Daniel Lezcano wrote:

[ ... ]

>> +int thermal_trip_sort(struct thermal_trip *trips, int num_trips)
>> +{
>> +	struct thermal_trip tt;
>> +	int sorted = 0;
>> +	int i, j;
>> +
>> +	for (i = 0; i < num_trips; i++) {
>> +
>> +		for (j = i + 1; j < num_trips; j++) {
>> +
>> +			if (trips[i].temperature <
>> trips[j].temperature) {
>> +				tt = trips[i];
>> +				trips[i] = trips[j];
>> +				trips[j] = tt;
>> +				sorted++;
>> +			}
>> +		}
>> + 	}
>> +
>> +	return sorted;
>> +}
>> +
> When this happens, the index(trip_id) of each trip is changed, but we
> pass the new trip_id to .get_trip_temp()/.set_trip_temp() callbacks.

If we pass the thermal trips to the 
thermal_zone_device_register_with_trips(), .get_trip_temp, 
.get_trip_hyst and .get_trip_type are not used.

.set_trip_temp is called from sysfs, where the trip_id is read from the 
file name. This trip_id will be correct in this case, as the files are 
created after sorting the array.

> This will confuse the drivers and update the wrong trips, right?

No, because at the moment we use the generic trip structure, it is 
handled by the thermal framework.

The drivers do not have to deal with the trip id or assuming its value 
given a trip point after registering the thermal zone. If it does, we 
should fix the driver as the trip_id is a framework internal value.

The trip_id is just an index to be passed around, so whatever the value, 
it should point to the right trip point.

For instance, the device tree describes the trip point and they could be 
in any order, all the DT based drivers are agnostic of the trip_id.

If there is an update of the trip points, we read the trip points 
definition again and do an update of all of them.

> IMO, we need a map between thermal core trips and unsorted driver
> trips.

That what I proposed several months ago but we concluded that would 
another extra level of complexity. So we decided to replace all the 
.get_trip_* by a generic trip point structure handled by the thermal 
framework itself.

Hopefully, soon we will have all .get_trip* gone with a nice cleanup of 
the drivers and the core framework.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

