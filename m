Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14586A0578
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjBWJ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjBWJ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:56:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB3851FA3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:56:06 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i11so4016187wrp.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zqMvyew1VuvLR+5MrHi+CVRR54Ec9Hg3AWm5Uzuvhkk=;
        b=y7DPYrkGk9xCwkGpaQAeXdWfCjSmojs2x7UvFOZ+JGW+Um8i0jZjaVS/JoDxV3yUZ0
         r2mzgdIy6vEOoh0l3o6m0w1lKsOZgXuQqbdwACzgM/m1DpSE+5//S4EF3vj81Dbd1bLm
         O4drKYRElSQ+HYorlA1n5JY9qwn/cNvnG0dTpi7UPGpPhIeDGCGUamJ8HfxuemB1tIsZ
         5NptNCmJtIF7INhKAxupGcRrEHkhAFbInzl5ei9Zqhy18pNNqLHEl5mIWMHcxWTaF7TL
         Lpib0IIgJrbiFYLDfpwk8fax+5qTX5rFXQOM1RvNC/rEYzOahY/lMrmWjmfm5Iwh/+xS
         BCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqMvyew1VuvLR+5MrHi+CVRR54Ec9Hg3AWm5Uzuvhkk=;
        b=u+pavbYiusTWS4YYNUv6ZqBaudHbry1bA0RVavpP4+/T2QbeHDXYcJNAVn/06m4FmN
         3oqARltShcyDNe65nwuBJKfGCcpcqPLNhPVO8VutuxdFSPo2KFMgAD2KBFtdf/eL9s77
         cB5798jQybaM0UUuXYwurHZtKjmumaghyK2mhVb4rXZ++qkxKNJFww3z1Gr3BKMn1UUY
         ucU5OFXpVs3lGRp0E0vS9tZlGHq76gxFTkqT9krTo+803JgxSk9pGlC3l3bTQ4ysgv2I
         1sFe8GnybS2u5shI7GhwMHPYmi37h2xMnl+nYbrB3LU0pORL8ljqD0d3QBo+HDMAFwY9
         fSWQ==
X-Gm-Message-State: AO0yUKUipFtQotOOxKkT0kHT3TnaT7/mOBVI7VzZ0LONNQQY5WGMM18n
        d2RoOWwMPdDw6lZ7tNkVxN3/wA==
X-Google-Smtp-Source: AK7set9wKGyiCs4mhXfwoAzjxI0hINeis8DMPCt/2knY34phjllU4IYlzLKUeg8KQ1/3trkYX25LXw==
X-Received: by 2002:a5d:4806:0:b0:2c5:5a68:958 with SMTP id l6-20020a5d4806000000b002c55a680958mr10075206wrq.33.1677146164810;
        Thu, 23 Feb 2023 01:56:04 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c265:a8c7:c71d:6e47? ([2a05:6e02:1041:c10:c265:a8c7:c71d:6e47])
        by smtp.googlemail.com with ESMTPSA id u4-20020adfed44000000b002c706c754fesm6399145wro.32.2023.02.23.01.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:56:04 -0800 (PST)
Message-ID: <2b843912-cc9b-f1ac-1f81-28e3ecf8daba@linaro.org>
Date:   Thu, 23 Feb 2023 10:56:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 06/16] thermal: Don't use 'device' internal thermal
 zone structure field
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balsam CHIHI <bchihi@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
 <20230221180710.2781027-7-daniel.lezcano@linaro.org>
 <CAJZ5v0gTmi7ZeDDdHWGWju4m3bv2366oVqSP1dGOT+3jLV-jaw@mail.gmail.com>
 <0889767f-d187-0cb4-895e-c149517b6636@linaro.org>
 <CAJZ5v0h=UCOyJ88UgEdqch4NZK+DaT8jWnDaguQGNx-KOMhPPA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0h=UCOyJ88UgEdqch4NZK+DaT8jWnDaguQGNx-KOMhPPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 21:06, Rafael J. Wysocki wrote:
> On Wed, Feb 22, 2023 at 9:00 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 22/02/2023 20:43, Rafael J. Wysocki wrote:
>>> On Tue, Feb 21, 2023 at 7:07 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> Some drivers are directly using the thermal zone's 'device' structure
>>>> field.
>>>>
>>>> Use the driver device pointer instead of the thermal zone device when
>>>> it is available.
>>>>
>>>> Remove the traces when they are duplicate with the traces in the core
>>>> code.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> Reviewed-by: Balsam CHIHI <bchihi@baylibre.com> #Mediatek LVTS
>>>> ---
>>
>> [ ... ]
>>
>>>>           thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
>>>>
>>>> -       dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
>>>> +       dev_dbg(data->bgp->dev, "updated thermal zone %s\n",
>>>>                   data->ti_thermal->type);
>>>
>>> The code before the change is more consistent, because it refers to
>>> the same object in both instances.
>>>
>>> It looks like a type field accessor is needed, eg. thermal_zone_device_type()?
>>>
>>> Or move the debug message to thermal_zone_device_update()?
>>
>> Actually it is done on purpose because the patch 9 replaces the accesses
>> to 'type' by 'id', the thermal_zone_device_type() accessor won't be needed.
> 
> Cool.
> 
> However, this is a change in behavior (albeit small) which doesn't
> appear to be necessary.
> 
> What would be wrong with having a tz->type accessor too?

I can add the 'type' accessor but from my point of view it is not 
correct because the information belongs to the thermal framework and it 
is used to export the information in the sysfs which is along with the 
directory name giving the id of the thermal zone.

Actually, the useful information is the id of the thermal zone, not the 
type. This one can be duplicate, for instance:

cat /sys/class/thermal/thermal_zone*/type
acpitz
acpitz

Given there are few places where 'type' is used in the drivers, I prefer 
to directly change that to 'id' in the next patch instead of creating 
the accessor for 'type', then send another series removing it.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

