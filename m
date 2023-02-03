Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB1C6891AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjBCIKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjBCIJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:09:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB2111144
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:08:10 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q5so3934876wrv.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 00:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g7K3x1KoZ0SY31LR0/m8kYHO83BED7q9ShhIFN2VocU=;
        b=O8fO3Yv5/AyKSPGueF6cDOqOUHJDjxLZ/ZoN6O64VbMigib8iKS2qYuNw+KAD29JC0
         XC9BAsfb1xQK/piER6sRDNdHAxj5J/uQAJb3JP/h+b7PbYYjaWQKPP3UwLdDmxk+IiVK
         k4EK95HM46FxuqXw2VNuw7QcYt0VmYLOPz7Ka0Uo2VCl9gaOBMTpiqXqSxT8jlx7KhLQ
         o5ZU80U9Od7JbtN/Vi8+jZWK7eLk821xS+U232fKaco00PN9insUJ7K6RBw6vW2Zaf9k
         07/7Tm7qe83QLEYxIRGB6u3S2/rUeCkO/6dzTIMDpHP0qp3aTx+peIsy+3+XEup0SBSN
         aFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7K3x1KoZ0SY31LR0/m8kYHO83BED7q9ShhIFN2VocU=;
        b=guCFB/3wkuQzwwo8Io1v8r9Sr9kGQYqYbRQNBA/DZZlQCoHJwyZ79Ok+CMPne+9Jwe
         GybxbCI1fup+JdPlDI/AU4sHL2/1SjRWGJss8sQhbAAg4WgDxXaJoMrJCe8dkpsKWRSk
         r9K0i6j7DI/6OT8j8kXh1UyJeYxAbIE8m3Mb7oVbgnNdBKKUortikwW1knbNOTZFeFjf
         xILbrZp2TViaTyqOWCVA+ncTrFJ9nktbKlIIKC1ENLNMx97d1YwWVjBGanBbVIt1IS4i
         OyK/SbG3I0JITVRom3o4uGPqM3uw9VkFiO2rsnwsUaCQ0JEBrnMV9puS6BLTlowlCn6m
         1FgA==
X-Gm-Message-State: AO0yUKWLu6BAqJQiN77UFLnG9FAhSdoSe0tX/oAJyN4ryPf2RhMOunJ7
        O9+CyCRglqXkayN0A+pnGYhZbzeZUuwoIhYNwQE=
X-Google-Smtp-Source: AK7set8jRwvrWFKr2PO+lainT8LGHKHAEY59qPHfhztf4/eWwH0fOilrYQom+wwpiU3u7Ne4DYU89Q==
X-Received: by 2002:a05:6000:10c2:b0:2c3:d9d1:e341 with SMTP id b2-20020a05600010c200b002c3d9d1e341mr339713wrx.33.1675411688943;
        Fri, 03 Feb 2023 00:08:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7407:d8b9:ec7a:537? ([2a01:e0a:982:cbb0:7407:d8b9:ec7a:537])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d6845000000b002bdff778d87sm1355584wrw.34.2023.02.03.00.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 00:08:08 -0800 (PST)
Message-ID: <581da0b5-fcdf-aa02-cab8-3c0e65dd48f8@linaro.org>
Date:   Fri, 3 Feb 2023 09:08:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: panel: Set orientation on panel_bridge
 connector
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     John Keeping <john@metanate.com>, Sam Ravnborg <sam@ravnborg.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20230120114313.2087015-1-john@metanate.com>
 <CAD=FV=UPD6c+NY8Ub37N7LmrRFpcr6gKOh0Os14DaKrf3bKo2A@mail.gmail.com>
 <Y8uo7vIcQ6caH9pu@ravnborg.org> <Y8wnswk++tvr9xMe@donbot>
 <Y81Px74OUYt21nj4@pendragon.ideasonboard.com> <Y856rWmtA4tQCcZz@donbot>
 <Y86wO8nvFbC81b1S@pendragon.ideasonboard.com>
 <CAD=FV=UwMS86RKR9dqzOnjEhKxh=d=EJPfjcCOvWZMjVVQsmKw@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAD=FV=UwMS86RKR9dqzOnjEhKxh=d=EJPfjcCOvWZMjVVQsmKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 01:45, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jan 23, 2023 at 8:05 AM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>>
>> Hi John,
>>
>> On Mon, Jan 23, 2023 at 12:16:45PM +0000, John Keeping wrote:
>>> On Sun, Jan 22, 2023 at 05:01:27PM +0200, Laurent Pinchart wrote:
>>>> On Sat, Jan 21, 2023 at 05:58:11PM +0000, John Keeping wrote:
>>>>> On Sat, Jan 21, 2023 at 09:57:18AM +0100, Sam Ravnborg wrote:
>>>>>> On Fri, Jan 20, 2023 at 01:44:38PM -0800, Doug Anderson wrote:
>>>>>>> On Fri, Jan 20, 2023 at 3:43 AM John Keeping wrote:
>>>>>>>>
>>>>>>>> Commit 15b9ca1641f0 ("drm: Config orientation property if panel provides
>>>>>>>> it") added a helper to set the panel panel orientation early but only
>>>>>>>> connected this for drm_bridge_connector, which constructs a panel bridge
>>>>>>>> with DRM_BRIDGE_ATTACH_NO_CONNECTOR and creates the connector itself.
>>>>>>>>
>>>>>>>> When the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is not specified and the
>>>>>>>> panel_bridge creates its own connector the orientation is not set unless
>>>>>>>> the panel does it in .get_modes which is too late and leads to a warning
>>>>>>>> splat from __drm_mode_object_add() because the device is already
>>>>>>>> registered.
>>>>>>>>
>>>>>>>> Call the necessary function to set add the orientation property when the
>>>>>>>> connector is created so that it is available before the device is
>>>>>>>> registered.
>>>>>>>
>>>>>>> I have no huge objection to your patch and it looks OK to me. That
>>>>>>> being said, my understanding is that:
>>>>>>>
>>>>>>> 1. DRM_BRIDGE_ATTACH_NO_CONNECTOR is "the future" and not using the
>>>>>>> flag is "deprecated".
>>>>>>
>>>>>> Correct.
>>>>>> Could we take a look at how much is required to move the relevant driver
>>>>>> to use DRM_BRIDGE_ATTACH_NO_CONNECTOR?
>>>>>>
>>>>>> If this is too much work now we may land this simple patch, but the
>>>>>> preference is to move all drivers to the new bridge handling and thus
>>>>>> asking display drivers to create the connector.
>>>>
>>>> I fully agree with Doug and Sam here. Let's see if we can keep the yak
>>>> shaving minimal :-)
>>>>
>>>>>> What display driver are we dealing with here?
>>>>>
>>>>> This is dw-mipi-dsi-rockchip which uses the component path in
>>>>> dw-mipi-dsi (and, in fact, is the only driver using that mode of
>>>>> dw-mipi-dsi).
>>>>>
>>>>> I'm not familiar enough with DRM to say whether it's easy to convert to
>>>>> DRM_BRIDGE_ATTACH_NO_CONNECTOR - should dw-mipi-dsi-rockchip be moving
>>>>> to use dw-mipi-dsi as a bridge driver or should dw_mipi_dsi_bind() have
>>>>> a drm_bridge_attach_flags argument?  But I'm happy to test patches if it
>>>>> looks easy to convert to you :-)
>>>>
>>>> I'd go for the former (use dw_mipi_dsi_probe() and acquire the DSI
>>>> bridge with of_drm_find_bridge() instead of using the component
>>>> framework) if possible, but I don't know how intrusive that would be.
>>>
>>> I'm a bit confused about what's required since dw-mipi-dsi-rockchip
>>> already uses dw_mipi_dsi_probe(),
>>
>> Indeed, my bad.
>>
>>> but I think moving away from the
>>> component framework would be significant work as that's how the MIPI
>>> subdriver fits in to the overall Rockchip display driver.
>>
>> It will be some work, yes. It however doesn't mean that the whole
>> Rockchip display driver needs to move away from the component framework,
>> it can be limited to the DSI encoder. It's not immediately clear to me
>> why the DSI encoder uses the component framework in the first place, and
>> if it would be difficult to move away from it.
>>
>>> Any changes / modernisation to the Rockchip MIPI driver look like it
>>> will take more time than I have available to spend on this, so I'd
>>> really like to see this patch land as it's a simple fix to an existing
>>> working code path.
>>
>> So who volunteers for fixing it properly ? :-)
>>
>> I'll let Doug and Sam decide regarding mering this patch.
> 
> This thread seems to have gone silent.
> 
> I'm inclined to merge this patch (removing the "Fixes" tag) since it's
> a one-line fix. While we want to encourage people to move to "the
> future", it seems like it would be better to wait until someone is
> trying to land something more intrusive than a 1-line fix before truly
> forcing the issue.
> 
> I'll plan to merge the patch to drm-misc-next early next week assuming
> there are no objections.

I'm ok for that,

Neil

> 
> -Doug

