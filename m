Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEE56FD9AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbjEJIlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbjEJIlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:41:02 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129555FF7;
        Wed, 10 May 2023 01:40:39 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9360D85FB2;
        Wed, 10 May 2023 10:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683708037;
        bh=M6jyMMO/z9LqJl4FYKJ/cETxNCTnMLV7qAQJB5zCK68=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jz9Oc1PQBFflEWbT+PzimKv17XfvWuctoKOgNESTdQRgti/njaXzryvKY3KA7/z0s
         qHtkUFAZUptlIt6QihCjLav3y3qfe0O7McdsxvQMfUDtKystN2NVXo/ATp/7TVU2B3
         Odji6lZ3jkr42aL5KxfcBNamlCzLc0Nzy6C9SsRcfIOlxWjlK9Oi+C4CO4jT/QU1DZ
         qMse5GbXfRtgrLqFngl936E2hGYXsZZ9cR1QO2+qiJMA2+tDYRUObJAWbOvkYhWlNk
         MGuNKqYpY5yUfQyAAlvcNvI4IDpPZtYwSYNgrQuUjUWlVDIM0epeY+bDJ5kb3SeCvX
         vx86zwYBs7nAw==
Message-ID: <c9dedb24-5714-0301-d8cc-7c56673b07b0@denx.de>
Date:   Wed, 10 May 2023 10:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/6] drm: lcdif: Drop unnecessary NULL pointer check on
 lcdif->bridge
Content-Language: en-US
To:     Ying Liu <gnuiyl@gmail.com>
Cc:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, conor+dt@kernel.org,
        alexander.stein@ew.tq-group.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, linux-imx@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        LW@karo-electronics.de
References: <20230508055740.635256-1-victor.liu@nxp.com>
 <20230508055740.635256-3-victor.liu@nxp.com>
 <05b44685-d6a7-5f6e-0f55-04c96e94a9e1@denx.de>
 <CAOcKUNXjvOMXtf2FVwjhWNbdwQy82T+wz-QN7ukAOmQo5DKQ2w@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAOcKUNXjvOMXtf2FVwjhWNbdwQy82T+wz-QN7ukAOmQo5DKQ2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/23 10:30, Ying Liu wrote:
> On Tue, May 9, 2023 at 10:14 AM Marek Vasut <marex@denx.de> wrote:
>>
>> On 5/8/23 07:57, Liu Ying wrote:
>>
>> Hi,
> 
> Hi,

Hi,

>>> diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
>>> index 262bc43b1079..e54200a9fcb9 100644
>>> --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
>>> +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
>>> @@ -394,7 +394,7 @@ static void lcdif_crtc_mode_set_nofb(struct lcdif_drm_private *lcdif,
>>>        struct drm_display_mode *m = &lcdif->crtc.state->adjusted_mode;
>>>        u32 bus_flags = 0;
>>>
>>> -     if (lcdif->bridge && lcdif->bridge->timings)
>>> +     if (lcdif->bridge->timings)
>>>                bus_flags = lcdif->bridge->timings->input_bus_flags;
>>>        else if (bridge_state)
>>>                bus_flags = bridge_state->input_bus_cfg.flags;
>>> @@ -463,30 +463,21 @@ static void lcdif_crtc_atomic_enable(struct drm_crtc *crtc,
>>>        struct drm_display_mode *m = &lcdif->crtc.state->adjusted_mode;
>>>        struct drm_bridge_state *bridge_state = NULL;
>>>        struct drm_device *drm = lcdif->drm;
>>> -     u32 bus_format = 0;
>>> +     u32 bus_format;
>>>        dma_addr_t paddr;
>>>
>>> -     /* If there is a bridge attached to the LCDIF, use its bus format */
>>> -     if (lcdif->bridge) {
>>> -             bridge_state =
>>> -                     drm_atomic_get_new_bridge_state(state,
>>> -                                                     lcdif->bridge);
>>> -             if (!bridge_state)
>>> -                     bus_format = MEDIA_BUS_FMT_FIXED;
>>> -             else
>>> -                     bus_format = bridge_state->input_bus_cfg.format;
>>> -
>>> -             if (bus_format == MEDIA_BUS_FMT_FIXED) {
>>> -                     dev_warn_once(drm->dev,
>>> -                                   "Bridge does not provide bus format, assuming MEDIA_BUS_FMT_RGB888_1X24.\n"
>>> -                                   "Please fix bridge driver by handling atomic_get_input_bus_fmts.\n");
>>> -                     bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>>> -             }
>>> -     }
>>> +     bridge_state = drm_atomic_get_new_bridge_state(state, lcdif->bridge);
>>> +     if (!bridge_state)
>>> +             bus_format = MEDIA_BUS_FMT_FIXED;
>>> +     else
>>> +             bus_format = bridge_state->input_bus_cfg.format;
>>
>> The code below seems to change the logic slightly.
>>
>> Could it happen that:
>> - bridge_state is valid (i.e. non-NULL)
>> - bridge_state->input_bus_cfg.format is set to 0 (i.e. not set) ?
>>     (note that MEDIA_BUS_FMT_FIXED is defined as 0x0001)
> 
> Yes, bridge_state->input_bus_cfg.format could be zero.
> Will keep the below default MEDIA_BUS_FMT_RGB888_1X24
> bus format setting in next version.

Thanks for confirming.

The rest of the series looks good, sorry for the delay in reviews.
