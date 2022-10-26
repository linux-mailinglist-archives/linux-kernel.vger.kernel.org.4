Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3A460DB08
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiJZGQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiJZGQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:16:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017127F101;
        Tue, 25 Oct 2022 23:16:03 -0700 (PDT)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 93F334F8;
        Wed, 26 Oct 2022 08:15:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1666764960;
        bh=ZXopEcCpgH9eAwwp4/DUAyOe27gRPmMK5DaQ4UaceFM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sfh179/ytkHAXPeEtgIME61E17s1TeKe7J+HRFQfASn9dZEqWVtVtjKaZlNIVSHW6
         A+aEvb3QxuujNAMDEQHgqIKDImJ/lX/dT3oBY3Xm7WpljGNFQN0h9hPxtFHQS0eISk
         +y+D0tZCPLapo3yQRqr4tF+8szZA6HEHD20xh/S0=
Message-ID: <d65d7963-0a37-612b-c953-106548d729ab@ideasonboard.com>
Date:   Wed, 26 Oct 2022 09:15:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v8 3/5] drm/bridge: cdns-dsi: Move to drm/bridge/cadence
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        jpawar@cadence.com, sjakhade@cadence.com, mparab@cadence.com,
        a-bhatia1@ti.com, devicetree@vger.kernel.org, vigneshr@ti.com,
        lee.jones@linaro.org
References: <20221021171820.15984-1-r-ravikumar@ti.com>
 <20221021171820.15984-4-r-ravikumar@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20221021171820.15984-4-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 20:18, Rahul T R wrote:
> Move the cadence dsi bridge under drm/bridge/cadence
> directory, to prepare for adding j721e wrapper
> support
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>   drivers/gpu/drm/bridge/Kconfig                        | 11 -----------
>   drivers/gpu/drm/bridge/Makefile                       |  1 -
>   drivers/gpu/drm/bridge/cadence/Kconfig                | 11 +++++++++++
>   drivers/gpu/drm/bridge/cadence/Makefile               |  2 ++
>   .../bridge/{cdns-dsi.c => cadence/cdns-dsi-core.c}    |  0
>   5 files changed, 13 insertions(+), 12 deletions(-)
>   rename drivers/gpu/drm/bridge/{cdns-dsi.c => cadence/cdns-dsi-core.c} (100%)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

