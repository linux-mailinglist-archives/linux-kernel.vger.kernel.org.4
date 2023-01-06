Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A012E660974
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjAFW0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjAFW0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:26:39 -0500
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:405::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596F081130
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 14:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=FzeQ2Dq+eGnhGIGUDBX7a8tZe8RMNCIUBNvWzRCTVWU=;
        b=NfKmNYeiqCx3uqjYKT3V2SJPnS/UZgJTRl5a5jNLctUdZwpIb1qchuVETKJJFnN4zpIHJUBSefIYm
         uHZpkAcuLgmYmU5X/cIz1/qchE1xNOvJZjzhWWA77qisCNlS/xB8ZpM3FKTp1Qqn5SHkhWRosu5bCG
         5zfQGT40Zny+p+mM4GNRVfed2Ws+AJviYpk39GLJRdDBhMYiYiwxqCy5DEf3cURfc+vPWQmdFmU5h8
         D2xzZwdPYTumii9IShQsotqfO38sBI+0KDoU2xRuuIbYO4UecYOU3K2ERPSwmK7BlMaYXWnvhxoosx
         OytYznXKE63euvs0CmxJhhdrLMbv1QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=FzeQ2Dq+eGnhGIGUDBX7a8tZe8RMNCIUBNvWzRCTVWU=;
        b=sqZAuanYFqaCy1TTf6dGjVU6Hri+qI9GsWCDju2uwvI6toZqPENohtScReySR4NooYUFgMlR3fmeZ
         pcbd4uqBg==
X-HalOne-ID: 2c7a171d-8e11-11ed-b619-cde5ad41a1dd
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay6 (Halon) with ESMTPSA
        id 2c7a171d-8e11-11ed-b619-cde5ad41a1dd;
        Fri, 06 Jan 2023 22:26:34 +0000 (UTC)
Date:   Fri, 6 Jan 2023 23:26:33 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 4/4] backlight: tosa: Use backlight helper
Message-ID: <Y7igGYR/j9JoYpsq@ravnborg.org>
References: <20230106164856.1453819-5-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106164856.1453819-5-steve@sk2.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 05:48:55PM +0100, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
I just realized...

This driver is about to be deleted by Arnd's effort to remove
the PXA platform, so the patch is not relevant and can be ignored.

See https://lore.kernel.org/dri-devel/20221019161831.3864786-1-arnd@kernel.org/

	Sam

> ---
>  drivers/video/backlight/tosa_bl.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/video/backlight/tosa_bl.c b/drivers/video/backlight/tosa_bl.c
> index 77b71f6c19b5..e338b1f00f6a 100644
> --- a/drivers/video/backlight/tosa_bl.c
> +++ b/drivers/video/backlight/tosa_bl.c
> @@ -50,13 +50,8 @@ static void tosa_bl_set_backlight(struct tosa_bl_data *data, int brightness)
>  
>  static int tosa_bl_update_status(struct backlight_device *dev)
>  {
> -	struct backlight_properties *props = &dev->props;
>  	struct tosa_bl_data *data = bl_get_data(dev);
> -	int power = max(props->power, props->fb_blank);
> -	int brightness = props->brightness;
> -
> -	if (power)
> -		brightness = 0;
> +	int brightness = backlight_get_brightness(dev);
>  
>  	tosa_bl_set_backlight(data, brightness);
>  
> -- 
> 2.30.2
