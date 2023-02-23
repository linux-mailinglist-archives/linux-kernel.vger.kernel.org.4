Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF38C6A0BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbjBWOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjBWOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:36:07 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B8858B7E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:36:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o14so9373168wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5A8UeRr2Gc2z9WOFsL/7qhv/YNUuwYHZ6QFgk2PLkf4=;
        b=G/KnzB+TqsBI8cevd406M1H2uS/axQyn5O3J8LbGgYCVum00LDCUcdsLRO4e+PYdTW
         U53td03TDwO3oqU/DfyEACJp3u8kqk/fQs1hqFQfHLbFvVaGxAxtxfhj20dVBDn/KocL
         bRm4dGcQ8RneN0QZZOclkTDXg5Tz49YHzlv2KJwX01gmRldUTxSI9wx6CwNtT7JS4MpX
         XQc/ceZ/Ksf8XK7DsOO+WaVEgFWi4+WZcf9lLCMAByGprBtrAIY/OBJ06L3/FJ6oVN0s
         EtSN5c388v7cMmniaxK9MZ4F5hupqKl7pkEC/gfUk5A76nvfNX4TMsgdKEROOksO965j
         GZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5A8UeRr2Gc2z9WOFsL/7qhv/YNUuwYHZ6QFgk2PLkf4=;
        b=kfBjTSiDrL1VAUEWxJwZVkeSls2+P2pdT5zMX3u8+D8vQE2aAz/f1uk80w5LRVujfE
         Bro48HQYCRRp3g4LTDvNji8ec6APUO5mR1IwzVGr82TS/kNMzm6nfFIJPOkZWsNcL2jm
         pKBhO1ZJMBwbhLCApauaB/fS8JRSmY2xEbMxxiT7aDzXpQJ01kYH3JmY/wxJ3vlfGZb0
         m50PrtAOiDiz6a9AUnbZQ7yvUK8Gl+YQtKbznr36o/O98j0t+7dqFT0YC46n+y7dCsPK
         zeUJg2omYx2JDqGFSEfti15JOGU+xn7mdtV/YqvvkkK5rR5muPYnqftRqbk7C96IYsHs
         D5Cg==
X-Gm-Message-State: AO0yUKX8cUdhz6agPDUChxbiJDo3uqcbyDJYcLK4YlS/7iGHwu7/MYmI
        ZjpJmFRoyLnYjxecutiK2DrVKw==
X-Google-Smtp-Source: AK7set8m6oTFiOFyJ69IZZpXnSY707D1wGVpzvSHc156iH26zK9yl1Et8LQfhfLoNB4CqfmWsB2ihw==
X-Received: by 2002:a05:600c:43c9:b0:3e1:f8af:7942 with SMTP id f9-20020a05600c43c900b003e1f8af7942mr3008298wmn.22.1677162958724;
        Thu, 23 Feb 2023 06:35:58 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c265:a8c7:c71d:6e47? ([2a05:6e02:1041:c10:c265:a8c7:c71d:6e47])
        by smtp.googlemail.com with ESMTPSA id n15-20020a05600c3b8f00b003e224ff61a8sm12388179wms.43.2023.02.23.06.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 06:35:58 -0800 (PST)
Message-ID: <abac6405-6a09-4267-a5ec-626e92f08f30@linaro.org>
Date:   Thu, 23 Feb 2023 15:35:56 +0100
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
 <2b843912-cc9b-f1ac-1f81-28e3ecf8daba@linaro.org>
 <CAJZ5v0g+fkX=ZUJ0MgENy2SmMv98wD0dApVwU352OS4ZXpDDCw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0g+fkX=ZUJ0MgENy2SmMv98wD0dApVwU352OS4ZXpDDCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 12:43, Rafael J. Wysocki wrote:
> On Thu, Feb 23, 2023 at 10:56 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 22/02/2023 21:06, Rafael J. Wysocki wrote:
>>> On Wed, Feb 22, 2023 at 9:00 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 22/02/2023 20:43, Rafael J. Wysocki wrote:
>>>>> On Tue, Feb 21, 2023 at 7:07 PM Daniel Lezcano
>>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>>
>>>>>> Some drivers are directly using the thermal zone's 'device' structure
>>>>>> field.
>>>>>>
>>>>>> Use the driver device pointer instead of the thermal zone device when
>>>>>> it is available.
>>>>>>
>>>>>> Remove the traces when they are duplicate with the traces in the core
>>>>>> code.
>>>>>>
>>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>> Reviewed-by: Balsam CHIHI <bchihi@baylibre.com> #Mediatek LVTS
>>>>>> ---
>>>>
>>>> [ ... ]
>>>>
>>>>>>            thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
>>>>>>
>>>>>> -       dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
>>>>>> +       dev_dbg(data->bgp->dev, "updated thermal zone %s\n",
>>>>>>                    data->ti_thermal->type);
>>>>>
>>>>> The code before the change is more consistent, because it refers to
>>>>> the same object in both instances.
>>>>>
>>>>> It looks like a type field accessor is needed, eg. thermal_zone_device_type()?
>>>>>
>>>>> Or move the debug message to thermal_zone_device_update()?
>>>>
>>>> Actually it is done on purpose because the patch 9 replaces the accesses
>>>> to 'type' by 'id', the thermal_zone_device_type() accessor won't be needed.
>>>
>>> Cool.
>>>
>>> However, this is a change in behavior (albeit small) which doesn't
>>> appear to be necessary.
>>>
>>> What would be wrong with having a tz->type accessor too?
>>
>> I can add the 'type' accessor but from my point of view it is not
>> correct because the information belongs to the thermal framework and it
>> is used to export the information in the sysfs which is along with the
>> directory name giving the id of the thermal zone.
> 
> I'm not sure what you mean here.
> 
> Surely, the 'type' is provided by whoever registers the thermal zone,
> so I'm not sure in what way it "belongs" to the framework.

I meant the goal of 'type' is to be exported to sysfs, nothing else.

That is the reason why I used the word 'belongs', because it was 
introduced to stay in the scope of the thermal framework, but then its 
usage has been diverted to a name.

Anyway, from my POV having traces in the ops is not a good thing, so 
I'll propose later to remove them and add a single message in the call 
sites.

Meanwhile, I'll provide the accessor for 'type' and hopefully we do not 
end up with a plethora of accessors to be used in the core code.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

