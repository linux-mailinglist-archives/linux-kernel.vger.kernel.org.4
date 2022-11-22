Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8DD633757
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiKVImo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiKVImg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:42:36 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E6991;
        Tue, 22 Nov 2022 00:42:26 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 00F68A16;
        Tue, 22 Nov 2022 09:42:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669106544;
        bh=nDX429cvmSfpNqL7ldm3Nf0LSI65LZrA71ihpOhaQUM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MfhFVla0VBq06phjBEMN7R4Xvyh+DmA10/WZOEd3BBUmDpYq1CPQ/D25BZ1+qUWAO
         zXvrYdPYrmojO0rSjiyhGL4EFd3eRpqVaqZjuNU6rGrWKHBtJ86YQliqDN8WH6kKVu
         UjlCfNTuFKBOiieC7nrygKddbxLoKPI0K+OYsX8Q=
Message-ID: <cd2b6725-ab9f-45f6-b660-b43d6da0c562@ideasonboard.com>
Date:   Tue, 22 Nov 2022 10:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 6/8] drm: rcar-du: Add r8a779g0 support
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
References: <20221117122547.809644-1-tomi.valkeinen@ideasonboard.com>
 <20221117122547.809644-7-tomi.valkeinen@ideasonboard.com>
 <166869771876.50677.1905794243575000038@Monstersaurus>
 <Y3w8cBh0uVaSPonO@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <Y3w8cBh0uVaSPonO@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 05:05, Laurent Pinchart wrote:
> On Thu, Nov 17, 2022 at 03:08:38PM +0000, Kieran Bingham wrote:
>> Quoting Tomi Valkeinen (2022-11-17 12:25:45)
>>> From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>>>
>>> Add support for DU on r8a779g0, which is identical to DU on r8a779a0.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>>> ---
>>>   drivers/gpu/drm/rcar-du/rcar_du_drv.c | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>>> index d003e8d9e7a2..b1761d4ec4e5 100644
>>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>>> @@ -524,6 +524,27 @@ static const struct rcar_du_device_info rcar_du_r8a779a0_info = {
>>>          .dsi_clk_mask =  BIT(1) | BIT(0),
>>>   };
>>>   
>>> +static const struct rcar_du_device_info rcar_du_r8a779g0_info = {
>>> +       .gen = 3,
>>
>> Given that this is the V4H ... I wonder if this should be bumped
>> already. I guess that has knock on effects through the driver though...
> 
> rcar_du_group_setup_didsr() would need to be fixed to test gen >= 3
> instead of gen == 3. That seems to be the only problematic location. It
> could thus fairly easily be done in v2, but we can also delay it.

Ok, I can fix that here.

  Tomi

