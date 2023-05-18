Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC452707DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjERKQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjERKQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:16:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05472686;
        Thu, 18 May 2023 03:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BA3D61CBE;
        Thu, 18 May 2023 10:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57737C433EF;
        Thu, 18 May 2023 10:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684404950;
        bh=uBbt+WuNwyKBCJiUPk2UbCj3sGzTHUx1o8GlXmVog6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFOoiG43ev/5LiFXeTp54x5mxeSbp/84SkcrtrOYIGBZObh7KtuoIydPvoK4TOcHq
         DgIvjyxHRdkMZ2pgLWQU/wXRlt/J4mBaQmkF+soR6EmO0+hMhBRZOVxhQMUogQWduT
         K/3ISJbCnBAIyUq/yIhW7gjOJY9ldQD/D2G4Qt2nOC8y45LPDxdqdtyb4QfavU4j/a
         zdyTFgzW6DW0MWHcaNDRS4TeQ87VYPo9clOsrJKP8bm5AjVPnu6YObgc/E1B2vfkUR
         E88CMHM34+OOfpmTLvgX+azrr4oGis/3+njqdwJ3MGtIiOYIaS1fw2dDtyueHjQWsY
         ZIeSeGJ0dkMJg==
Date:   Thu, 18 May 2023 11:15:45 +0100
From:   Lee Jones <lee@kernel.org>
To:     Maximilian Weigand <mweigand2017@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Maximilian Weigand <mweigand@mweigand.net>
Subject: Re: [PATCH v2] backlight: lm3630a: turn off both led strings when
 display is blank
Message-ID: <20230518101545.GF404509@google.com>
References: <20230510085239.1253896-1-mweigand2017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510085239.1253896-1-mweigand2017@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023, Maximilian Weigand wrote:

> From: Maximilian Weigand <mweigand@mweigand.net>
> 
> Use backlight_is_blank() to determine if the led strings should be turned
> off in the update_status() functions of both strings.
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

I moved this tag to the correct place and ...

> Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
> ---
> Changes in v2:
> - fix description, replace display_is_black() with backlight_is_black()
> - use backlight_get_brightness() instead of accessing the property
>   directly
> 
>  drivers/video/backlight/lm3630a_bl.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
