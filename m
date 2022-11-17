Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76D062D9F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbiKQLz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239586AbiKQLzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:55:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3F72BB0B;
        Thu, 17 Nov 2022 03:54:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 893EDB82028;
        Thu, 17 Nov 2022 11:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69110C433D6;
        Thu, 17 Nov 2022 11:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668686097;
        bh=WX1FWx2cF2AM6qxLI/JRI3DYphuxTC736SeVco5ArOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcpxXSpU/6MGdIy4/UdvTwVesfdFJVIvX6SASQZT5tQM/KAQsk85zm7H0/fAizZYX
         w/jVFYK12QJZnNTUY6lQAo4wyo32XRQFNI2ul1/XBUbGdEj8AW5wdxBfPgaqasCbCK
         n+nCHTy3yjEnj8etlVFnL2uKE4oE3scLyDJhIhYdVn45Swl3tI50V/SKSLc8Jc3+Uh
         P7+iIIBRJZb/sFrDE8KDDn84kEA/PoturCLKlO1RX0lqnONRY32fJWLKUSjg4rep9o
         rMAiyMB4s+Evij0XT01fzNkplXD9561TaDtKOcwTot3iofbxH5UvqHj/AtzD2ajC9G
         5hr5yz1clrsIw==
Date:   Thu, 17 Nov 2022 11:54:52 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Drop support for legacy PWM probing
Message-ID: <Y3YhDLwOSEQoSWrb@google.com>
References: <20221117072151.3789691-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117072151.3789691-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022, Uwe Kleine-König wrote:

> There is no in-tree user left which relies on legacy probing. So drop
> support for it which removes another user of the deprecated
> pwm_request() function.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/backlight/pwm_bl.c | 12 ------------
>  include/linux/pwm_backlight.h    |  1 -
>  2 files changed, 13 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
