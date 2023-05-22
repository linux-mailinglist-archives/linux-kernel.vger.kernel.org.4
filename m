Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D19370B748
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjEVIFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjEVIFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:05:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8C1AA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:05:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f60444238cso8178285e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684742745; x=1687334745;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qNnn7PmV/vr5HWgu+npE6GoARdS8Ld8ogeDqZenNmtY=;
        b=IPLy8THmg61Dq3Nn16nCtSg3u3OFz968wHhincjhCldkO2qquCTtbrUm45XBcFwL9O
         uzSrPylq5hjOyqLalF/sPl8vPw1AkfC0nqRlC9hqcmCf5BnSdTQtPfWEONKvQZM43QmV
         x+bH+ZwcFODPJK7Cg/5D7CTEzuTeejtSuL43DR9ks434vwHpUsjzL62HGs6f34dqJS6c
         7mABuwPAyj7d7rfgdIR/tAozlZ2aTt3Xf67u4cEnzIbrKOYmG5hurhoJnpBqZ8aZERQf
         fOt62tTHGzPJS1tbTO09WpQ234RR8FTmfjfOSxhwahDiJHbrp/m2PR94B7zwJyKnqBF9
         ewNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684742745; x=1687334745;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNnn7PmV/vr5HWgu+npE6GoARdS8Ld8ogeDqZenNmtY=;
        b=f6ipnOGxLjDcSsGxcMwi32gS686J/Mh8BUq172H/c4EL57+SQzNloT2a+GSyllsTpY
         0OVqyGiNwcrDHoa9wWNGS3D/S7DBbx2iy8S/Q36iLSuSlcE7wdLSabPhUCDNm7QQDQlh
         GlCbI6gAp4TtDV1rDtZzAW60DO1vN/zA6MOw3NmpypLL0oH19Lyc/1pzAgUrs30nA/oo
         LY9osyC25fmu3T90vNpyI2ScbzHLWuKbaouunw/FLe0ShxwVdGDkmIvaQRI5t7pN60Jz
         GRoG4MbJ278dBxCgw5NFxBhv8ozoOUJcgg0RBoG5R3huNi5SaCSSv6t2+pIv+7OaGVa5
         ntqg==
X-Gm-Message-State: AC+VfDxaAEwSLzv2+5xtOC9GYYqog/AaEl+iwWmKkN87njr03OblDiMT
        ehRmt1OC166hvmDBXTitFIXBSQ==
X-Google-Smtp-Source: ACHHUZ6e83lSEXbsLSSwbGbX62ldxrVOsmAYLsRuKiSZqxL4I0u4IRS0C2tndIowOjIjp87W2rUWRA==
X-Received: by 2002:a5d:5383:0:b0:309:3cd6:1282 with SMTP id d3-20020a5d5383000000b003093cd61282mr7267862wrv.5.1684742745253;
        Mon, 22 May 2023 01:05:45 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id w8-20020a5d4b48000000b0030771c6e443sm6873509wrs.42.2023.05.22.01.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 01:05:44 -0700 (PDT)
Message-ID: <cc84cc53-53b6-1ab2-7053-36b3d3d3c423@linaro.org>
Date:   Mon, 22 May 2023 10:05:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v6 4/8] drm/bridge: mhdp8546: Set input_bus_flags from
 atomic_check
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230509093036.3303-1-a-bhatia1@ti.com>
 <20230509093036.3303-5-a-bhatia1@ti.com>
 <b43f0808-8ac8-746f-6cbc-5396722261aa@linaro.org>
 <1b95b75d-1b81-806b-7b7f-34cd93c9d0ec@ti.com>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <1b95b75d-1b81-806b-7b7f-34cd93c9d0ec@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 07:48, Aradhya Bhatia wrote:
> Hi Neil,
> 
> On 16-May-23 12:54, Neil Armstrong wrote:
>> On 09/05/2023 11:30, Aradhya Bhatia wrote:
>>> From: Nikhil Devshatwar <nikhil.nd@ti.com>
>>>
>>> input_bus_flags are specified in drm_bridge_timings (legacy) as well
>>> as drm_bridge_state->input_bus_cfg.flags
>>>
>>> The flags from the timings will be deprecated. Bridges are supposed
>>> to validate and set the bridge state flags from atomic_check.
>>>
>>> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
>>> [a-bhatia1: replace timings in cdns_mhdp_platform_info by
>>> input_bus_flags]
>>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>>> ---
>>>
>>> Notes:
>>>
>>>       changes from v5:
>>>       * removed the wrongly addded return statement in tfp410 driver.
>>>       * replaced the timings field in cdns_mhdp_platform_info by
>>>         input_bus_flags field, in order to get rid of bridge->timings
>>>         altogether.
>>>
>>>    drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c  | 11 ++++++++---
>>>    drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h  |  2 +-
>>>    drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c |  9 ++++-----
>>>    drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.h |  2 +-
>>>    4 files changed, 14 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>>> b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>>> index 623e4235c94f..a677b1267525 100644
>>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>>> @@ -2189,6 +2189,13 @@ static int cdns_mhdp_atomic_check(struct
>>> drm_bridge *bridge,
>>>            return -EINVAL;
>>>        }
>>>    +    /*
>>> +     * There might be flags negotiation supported in future.
>>> +     * Set the bus flags in atomic_check statically for now.
>>> +     */
>>> +    if (mhdp->info)
>>> +        bridge_state->input_bus_cfg.flags =
>>> *mhdp->info->input_bus_flags;
>>> +
>>>        mutex_unlock(&mhdp->link_mutex);
>>>        return 0;
>>>    }
>>> @@ -2554,8 +2561,6 @@ static int cdns_mhdp_probe(struct
>>> platform_device *pdev)
>>>        mhdp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
>>>                   DRM_BRIDGE_OP_HPD;
>>>        mhdp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
>>> -    if (mhdp->info)
>>> -        mhdp->bridge.timings = mhdp->info->timings;
>>
>> Won't this cause a breakage because at this point in time
>> bridge.timings->input_bus_flags
>> seems to be still used by tidss right ?
>>
> 
> tidss was using the bridge.timings->input_bus_flags before the 7th
> patch[1] in this series.
> 
> After the patch, it only relies on bridge_state and display_info for bus
> flags and formats.

OK thanks, then:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

if you resend a new version, please add this info in the commit message.

Neil

> 
> 
> Regards
> Aradhya
> 
> [1]: https://lore.kernel.org/all/20230509093036.3303-8-a-bhatia1@ti.com/
> 
> 
>>
>>>          ret = phy_init(mhdp->phy);
>>>        if (ret) {
>>> @@ -2642,7 +2647,7 @@ static const struct of_device_id mhdp_ids[] = {
>>>    #ifdef CONFIG_DRM_CDNS_MHDP8546_J721E
>>>        { .compatible = "ti,j721e-mhdp8546",
>>>          .data = &(const struct cdns_mhdp_platform_info) {
>>> -          .timings = &mhdp_ti_j721e_bridge_timings,
>>> +          .input_bus_flags = &mhdp_ti_j721e_bridge_input_bus_flags,
>>>              .ops = &mhdp_ti_j721e_ops,
>>>          },
>>>        },
>>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
>>> b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
>>> index bedddd510d17..bad2fc0c7306 100644
>>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
>>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
>>> @@ -336,7 +336,7 @@ struct cdns_mhdp_bridge_state {
>>>    };
>>>      struct cdns_mhdp_platform_info {
>>> -    const struct drm_bridge_timings *timings;
>>> +    const u32 *input_bus_flags;
>>>        const struct mhdp_platform_ops *ops;
>>>    };
>>>    diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c
>>> b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c
>>> index dfe1b59514f7..12d04be4e242 100644
>>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c
>>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c
>>> @@ -71,8 +71,7 @@ const struct mhdp_platform_ops mhdp_ti_j721e_ops = {
>>>        .disable = cdns_mhdp_j721e_disable,
>>>    };
>>>    -const struct drm_bridge_timings mhdp_ti_j721e_bridge_timings = {
>>> -    .input_bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
>>> -               DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE |
>>> -               DRM_BUS_FLAG_DE_HIGH,
>>> -};
>>> +const u32
>>> +mhdp_ti_j721e_bridge_input_bus_flags =
>>> DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
>>> +                       DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE |
>>> +                       DRM_BUS_FLAG_DE_HIGH;
>>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.h
>>> b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.h
>>> index 97d20d115a24..5ddca07a4255 100644
>>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.h
>>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.h
>>> @@ -14,6 +14,6 @@
>>>    struct mhdp_platform_ops;
>>>      extern const struct mhdp_platform_ops mhdp_ti_j721e_ops;
>>> -extern const struct drm_bridge_timings mhdp_ti_j721e_bridge_timings;
>>> +extern const u32 mhdp_ti_j721e_bridge_input_bus_flags;
>>>      #endif /* !CDNS_MHDP8546_J721E_H */
>>

