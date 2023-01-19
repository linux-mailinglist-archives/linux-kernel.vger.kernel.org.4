Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3077B674640
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjASWgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjASWgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:36:05 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E533717CC1;
        Thu, 19 Jan 2023 14:18:02 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1EEFAC0004;
        Thu, 19 Jan 2023 22:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674166680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JpJEqzHQqnXucAEeBIdt9PMVNIHwQVKdpxkEc3sDRTQ=;
        b=ifo7P9Q2GWBoPF5tUO78+PhK/XNNBOhUAizj+BSOfTqBJ8h1MTimuD6xsUC1LSL1A6piTy
        Vucf+Q9pIPX+ZvEeL9htL0npRbN17Y+lw5PF9uZXH/ZawPtTpRBblIjpXxJ4x736xEppd7
        gt5bOjd00shYFNBw7E0nRkvH85AZXRWiJi+LdcNgB833dZB2JG8ABV6W8luNM9rBczFPOT
        5iwemfWZG02Bu5CHRso2QQp65o7R8AW61TLUmXUB6SVupKt0pq9ZpIUAVQ4rxI+DsBlSot
        DSmrEx82ixacIqLc3V/Uksv0MTWgdhloocO9ql9fi00+HpQHMLboFkiXl8m1pQ==
Date:   Thu, 19 Jan 2023 23:17:58 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dennis Lambe Jr <dennis@sparkcharge.io>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@free-electrons.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 0/3] rtc: Set M41T82 & M41T83 xtal load capacitance
 from DT
Message-ID: <Y8nBloQfBPK3t5ce@mail.local>
References: <20230119213903.899756-1-dennis@sparkcharge.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119213903.899756-1-dennis@sparkcharge.io>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 21:39:00+0000, Dennis Lambe Jr wrote:
> Other than adding a sign-off to one of the changelogs, this is a RESEND.
> 
> Alexandre Belloni, what do you need for this before you'd want to apply
> it? In case it's additional reviewers, I have CC'd some more
> potentially-interested parties this time and updated Atsushi Nemoto's
> email address to one that's hopefully more current.
> 

I need to find time to think about it because while setting the analog
trimming statically from the device tree solves your immediate problem,
it will also remove the possibility to handle it from userspace later
on. I would really prefer this uses the offset interface or a better
interface that unfortunately doesn't exist yet.

> I think the original author listed in the header for this driver,
> Alexander Bigga, is inaccurate. It looks to me like his name got copied
> over by Atsushi Nemoto when he created m41t82.c by deriving it from a
> similar driver. At any rate, Alexander Bigga's listed email address
> bounces, I didn't find a newer one for him, and he doesn't show up in
> the kernel commit log after 2007. I don't think he can be considered the
> maintainer for this driver anymore if he ever was.
> 
> Changes in v3:
> * dt-bindings: added Krzysztof Kozlowski sign-off to changelog
> 
> Changes in v2:
> * dt-bindings: remove accidental wakeup-sources line
>     suggested by Krzysztof Kozlowski
> * spelling fixes in changelogs
> 
> The m41t82 and m41t83 have an adjustable internal capacitance that
> defaults to 25 pF per xtal pin. This patch series adds the ability to
> configure it via the devicetree.
> 
> Patch 1 just changes `#ifdef CONFIG_OF` to `if (IS_ENABLED(CONFIG_OF))`
> in m41t80_probe() so that I don't need to use __maybe_unused on my new
> functions and variables.
> 
> Patch 2 is the dt-bindings.
> 
> Patch 3 is the actual feature implementation.
> 
> The desired capacitance comes from the quartz-load-femtofarads property,
> following the example of two other RTC ICs that have adjustable internal
> load capacitance, the NXP pcf85063 and pcf8523. The m41t82 and m41t83
> support much finer-grained control over the capacitance than those
> chips, and ST calls the feature "analog calibration", but it looks to me
> like it's essentially the same kind of thing.
> 
> My use case for this is:
> 
> ST specifies not to add any additional external load capacitance[1], but
> the MikroElektronika RTC 9 Click board[2] has a 22 pF cap on each xtal
> pin[3]. The resulting combined capacitance appears to be outside of the
> operating range of the xtal, because when power is removed from the
> boards I'm testing with, the RTC reports an Oscillator-Fail flag on the
> next power on.
> 
> I found I could work around the problem by reducing the internal load
> capacitance as low as it will go.
> 
> References:
> [1] https://www.st.com/resource/en/application_note/an3060-applications-guide-for-serial-realtime-clocks-rtcs-stmicroelectronics.pdf
> [2] https://www.mikroe.com/rtc-9-click
> [3] https://download.mikroe.com/documents/add-on-boards/click/rtc-9/rtc-9-click-schematic-v100.pdf
> 
> Previous versions:
> v1: https://lore.kernel.org/linux-rtc/20221219190915.3912384-1-dennis@sparkcharge.io/T/
> 
> Dennis Lambe Jr (3):
>   rtc: m41t80: probe: use IS_ENABLED for CONFIG_OF
>   dt-bindings: m41t80: add xtal load capacitance
>   rtc: m41t80: set xtal load capacitance from DT
> 
>  .../devicetree/bindings/rtc/st,m41t80.yaml    | 16 ++++
>  drivers/rtc/rtc-m41t80.c                      | 84 +++++++++++++++++--
>  2 files changed, 92 insertions(+), 8 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
