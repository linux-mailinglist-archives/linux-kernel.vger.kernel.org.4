Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6878169B8C8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 09:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBRIkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 03:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBRIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:40:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8DB39BB3;
        Sat, 18 Feb 2023 00:40:36 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9C616660212B;
        Sat, 18 Feb 2023 08:40:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676709634;
        bh=DZ4yl6pLDxAn2zGVTcu68iBMqMhqGYiMmgtbG2Io9u0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3mjSIHKh+1g/v/FQEA3nV3EyS3Ese4havM2n5ssHpnM2j7nmDXt1KLtaotl6uL4W
         nzuwuljjaH1zX8cGzJDUkMDK9u9C2VDr8yEATKnKye1XVJ2O/Bf7jX+elzvJAJzO66
         IEU9xlI7RECif488RgR00eq0Eh1rYfAkcAjo9UHaLQYeEb4IPvID87PKhISh8Ln9Mm
         pV8yJHOSXzC8Azwct3wT/ZroGNn/bztHyrLrq9/A/GH4KO4Y4U/4DPsvENi0j9ck2K
         Ixrj5sPOobbqhDfoUZyQWIwacbzjvkSu0IePkQpVAc+uRoSbsSf1/6ywOf1BjRVNWv
         k960a3XxDXvSg==
Date:   Sat, 18 Feb 2023 09:40:31 +0100
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Vishal Parmar <vishistriker@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] first patch test
Message-ID: <20230218084031.xn2valzzjmx6vgzh@basti-XPS-13-9310>
References: <20230218031238.5747-1-vishistriker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20230218031238.5747-1-vishistriker@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Vishal,

actually sending noise to the mailing list is not very nice.
And you also just did the same mistake as someone else a few weeks ago.

Please see this mail:
https://lore.kernel.org/linux-media/49d1dece-cb90-23f3-977e-98905b1a0abc@collabora.com/

If you don't know what to do for your first patch, then either ask in
the mailing list or have a look into the TODO files in
drivers/staging/media or ask on the IRC channel: https://linuxtv.org/irc/

Greetings,
Sebastian

On 18.02.2023 08:42, Vishal Parmar wrote:
>Signed-off-by: Vishal Parmar <vishistriker@gmail.com>
>---
> drivers/media/usb/uvc/uvc_driver.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
>index e4bcb5011360..c79dcee2213f 100644
>--- a/drivers/media/usb/uvc/uvc_driver.c
>+++ b/drivers/media/usb/uvc/uvc_driver.c
>@@ -2082,7 +2082,7 @@ static int uvc_probe(struct usb_interface *intf,
> 		(const struct uvc_device_info *)id->driver_info;
> 	int function;
> 	int ret;
>-
>+        pr_info("I changed uvcvideo driver in the Linux Kernel\n");
> 	/* Allocate memory for the device and initialize it. */
> 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> 	if (dev == NULL)
>-- 
>2.34.1
>
