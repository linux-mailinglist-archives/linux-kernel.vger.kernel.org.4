Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B976DF21A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDLKkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjDLKjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:39:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917666E80
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:39:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso12611850wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681295990; x=1683887990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGPoMrimq4ykC+CCAmU0vfBHgEx9Wc5sSeoWOQ7Muos=;
        b=nk7EYXw1Ck11A+VETjG1M3ziBr3z9h7J/pLLp1qaOO9bYjTOZGD8Z+Mt1H+WNWMGs7
         vgoO38EJ2garxLct10JyNXGnzma39thy3k1VdUY0kr+CBZnJLOu+HXrLHJ46mBet2yw3
         kUtKUKQK9rw45b2T/NgNMK8slwgW3rNVGB9atEnQ77r2Jbx4XFwi2Y5DVExFgY5B2u0W
         jkfD3QEgpAxqq3aJ2zjeivGn6U/YbJdGu7H4XeDF3+G+wh0gNTudngb/SvfHOZioOITh
         HP/1V3fSvyWIZlJmPx7vJNoC4KgrVS1ADE3FtMAHgzV4k1h9AyiESOvs1OHTCo3Asr6Q
         Mc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681295990; x=1683887990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGPoMrimq4ykC+CCAmU0vfBHgEx9Wc5sSeoWOQ7Muos=;
        b=O9UOkoLrhufNKWy+EBZSPhhOkwOrktEmCzm9CG3UW5fjO9/8J+GtM9rRrUYuiLWyOu
         Yt4IHIl9s+vo7qRPPHzc+oZ1Mr9Emlzwb+/WoVpM21RIg06ESisOjStPKzK5mvAYR42c
         8uPD3EVJ4qIwitYeB5/BNjLscVcs/UbC+nBfbB09+aksci6/kWJH94qjWfBwPLr/OUnc
         oujn/M6Chdoxx6wF8uJQ0li8iilx2Gg62avGyFcAyX/3Wm9EJl5N2wnCmkfWQ6zyBAOc
         hxqRncyVdSOThY+Nd4MRzmFdShRxMlXDUQ7as/Hd/d18koRTLMockRBPFobzEWJU94DE
         2jWg==
X-Gm-Message-State: AAQBX9d00L5ernn/ablaDY1ImTl1Wee8uLuWsqIYBynDh2isiMoQA9D6
        LoBY/TgoBrpqosP4FdHkI4E=
X-Google-Smtp-Source: AKy350Zus9gjtjUqe2oU8CgEhLggOze5DqaENaV5ht12OYm2dkXU4dJQKK8YoUOw/rwWYacl7Qr8Qw==
X-Received: by 2002:a05:600c:2284:b0:3f0:a023:2614 with SMTP id 4-20020a05600c228400b003f0a0232614mr558740wmf.6.1681295989743;
        Wed, 12 Apr 2023 03:39:49 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b003edc4788fa0sm2043373wmq.2.2023.04.12.03.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 03:39:47 -0700 (PDT)
Message-ID: <a1136c32-0c29-3803-da15-59b40fcf333e@gmail.com>
Date:   Wed, 12 Apr 2023 12:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/9] drm/mediatek: dp: Cache EDID for eDP panel
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
References: <20230404104800.301150-1-angelogioacchino.delregno@collabora.com>
 <20230404104800.301150-2-angelogioacchino.delregno@collabora.com>
 <09c61b94-1ed1-eb72-9682-1f1f203f6f63@gmail.com>
 <783c03af-fc88-96c8-c6fc-6f02051dc6b1@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <783c03af-fc88-96c8-c6fc-6f02051dc6b1@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 10:06, AngeloGioacchino Del Regno wrote:
> Il 12/04/23 09:08, Matthias Brugger ha scritto:
>>
>>
>> On 04/04/2023 12:47, AngeloGioacchino Del Regno wrote:
>>> Since eDP panels are not removable it is safe to cache the EDID:
>>> this will avoid a relatively long read transaction at every PM
>>> resume that is unnecessary only in the "special" case of eDP,
>>> hence speeding it up a little, as from now on, as resume operation,
>>> we will perform only link training.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   drivers/gpu/drm/mediatek/mtk_dp.c | 11 ++++++++++-
>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c 
>>> b/drivers/gpu/drm/mediatek/mtk_dp.c
>>> index 1f94fcc144d3..84f82cc68672 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
>>> @@ -118,6 +118,7 @@ struct mtk_dp {
>>>       const struct mtk_dp_data *data;
>>>       struct mtk_dp_info info;
>>>       struct mtk_dp_train_info train_info;
>>> +    struct edid *edid;
>>>       struct platform_device *phy_dev;
>>>       struct phy *phy;
>>> @@ -1993,7 +1994,11 @@ static struct edid *mtk_dp_get_edid(struct drm_bridge 
>>> *bridge,
>>>           usleep_range(2000, 5000);
>>>       }
>>> -    new_edid = drm_get_edid(connector, &mtk_dp->aux.ddc);
>>> +    /* eDP panels aren't removable, so we can return a cached EDID. */
>>> +    if (mtk_dp->edid && mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP)

Maybe better like this:
if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP && mtk_dp->edid)

To in sync with the if statement below. Anyway we are only concerned if it's an 
eDP so check that first (and hope the compiler will do so as well ;)

With that:
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>>> +        new_edid = drm_edid_duplicate(mtk_dp->edid);
>>> +    else
>>> +        new_edid = drm_get_edid(connector, &mtk_dp->aux.ddc);
>>
>> Maybe it would make sense to add a macro for the check of mtk_dp->bridge.type 
>> == DRM_MODE_CONNECTOR_eDP
>> it would make the code more readable.
>>
> 
> I had the same idea... but then avoided that because in most (if not all?) of the
> DRM drivers (at least, the one I've read) this check is always open coded, so I
> wrote it like that for consistency and nothing else.
> 
> I have no strong opinions on that though!
> 

I think the only reasonable solution would be a macro like:
DRM_CONNECTOR_MODE_IS(mtk_dp->bridge.type, eDP) which in the end is longer then 
open-code it, so probably just leave it as it is.

>>>       /*
>>>        * Parse capability here to let atomic_get_input_bus_fmts and
>>> @@ -2022,6 +2027,10 @@ static struct edid *mtk_dp_get_edid(struct drm_bridge 
>>> *bridge,
>>>           drm_atomic_bridge_chain_post_disable(bridge, connector->state->state);
>>>       }
>>> +    /* If this is an eDP panel and the read EDID is good, cache it for later */
>>> +    if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP && !mtk_dp->edid && 
>>> new_edid)
>>> +        mtk_dp->edid = drm_edid_duplicate(new_edid);
>>> +
>>
>> How about putting this in an else if branch of mtk_dp_parse_capabilities. At 
>> least we could get rid of the check regarding if new_edid != NULL.
>>
>> I was thinking on how to put both if statements in one block, but I think the 
>> problem is, that we would leak memory if the capability parsing failes due to 
>> the call to drm_edid_duplicate(). Correct?
>>
> 
> Correct. The only other "good" place would be in the `if (new_edid)` conditional,
> but that wouldn't be as readable as it is right now...
> 
> Cheers,
> Angelo
> 
