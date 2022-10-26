Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956ED60DB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiJZGQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiJZGQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:16:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45732B97B9;
        Tue, 25 Oct 2022 23:16:31 -0700 (PDT)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CFEFC4F8;
        Wed, 26 Oct 2022 08:16:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1666764989;
        bh=LDd8LyBDCaecAwc7cjAu82arEqV1+W/A2kaOAkJvoqE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qC546QuqpKKimkHGcyQqJFYkbXES8AbpnIXBtMdTrQJx9Pv6y+wN4R5kSZX1eL8p1
         J6p5k7pk4ueK4qXfi+wrralYPXsFb+qPLK6KAk6pA7C6qUqQ7ZPYRs2uWsben53p4O
         zjrVdIe7qRdWWgE5BhqBzF/Z9MNbYJmbmAIkTUUA=
Message-ID: <6504f023-3df3-ac5c-8a8d-fef1bd715948@ideasonboard.com>
Date:   Wed, 26 Oct 2022 09:16:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v8 4/5] drm/bridge: cdns-dsi: Create a header file
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
 <20221021171820.15984-5-r-ravikumar@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20221021171820.15984-5-r-ravikumar@ti.com>
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
> Create a header file for cdns dsi and move
> register offsets and structure to header,
> to prepare for adding j721e wrapper support
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>   .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 446 +----------------
>   .../gpu/drm/bridge/cadence/cdns-dsi-core.h    | 458 ++++++++++++++++++
>   2 files changed, 459 insertions(+), 445 deletions(-)
>   create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

