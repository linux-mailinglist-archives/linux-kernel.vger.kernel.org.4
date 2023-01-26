Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A967CE18
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjAZO2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjAZO2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:28:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FE266018;
        Thu, 26 Jan 2023 06:27:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96EF46181D;
        Thu, 26 Jan 2023 14:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE03C433EF;
        Thu, 26 Jan 2023 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674743255;
        bh=kyg287jVxNn5KSlNEsVGJfYboudO4DBm+FJvwry/P14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWMMZa3enFGjyBvR2geXY/y1os9YbC/Uq6fvpBx147xoAci6F2dWQUwOp5qev7dqv
         sDFzMt7hO6YpQHUbi6UXLJq/caD9FXOsVNgrL+IcDeaytcggK82q8G4TPARg46UQvR
         qp4uxp3LOCVaFqBaaCiwljX3GBc1l6jZqUd5AJMLb2hOnEyztqjAXwXmyWbJDEosk5
         fuPKSnnu2l0tBH3n5rSQm/zULLwOhCLeU2BQcHzouuw4T2jv6+uHjM+0xXK+iTmSzm
         vld+2pv3ErucYbDOohg29FfZIjY619rILYR8g/bpIZoRx6/QTcILHFraOIiC5DP3WZ
         c4HaAqCJIpw1A==
Date:   Thu, 26 Jan 2023 14:27:26 +0000
From:   Lee Jones <lee@kernel.org>
To:     sam@ravnborg.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH 15/15] backlight: backlight: Drop the deprecated fb_blank
 property
Message-ID: <Y9KNziZJxMjCffbs@google.com>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-15-1bd9bafb351f@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230107-sam-video-backlight-drop-fb_blank-v1-15-1bd9bafb351f@ravnborg.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Jan 2023, Sam Ravnborg via B4 Submission Endpoint wrote:

> From: Sam Ravnborg <sam@ravnborg.org>
> 
> With all users gone remove the deprecated fb_blank member in
> backlight_properties.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  drivers/video/backlight/backlight.c |  2 --
>  include/linux/backlight.h           | 22 ----------------------
>  2 files changed, 24 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
