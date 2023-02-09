Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C575E690B64
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjBIOLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjBIOLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:11:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2705D1FB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675951844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8EVZ2hzCIPgSAPXNoHMOtGO/EgYBjGAER2fyRQiSoO0=;
        b=cdrwB+MxCkpJwpmRo5XU4BUK3Y6DTSrXV7aQ/Gv9+mtPlt+tjREbfbm3mLyOqMSSJVnAE0
        1f2sbACfTtLE6pTmj6NllQqrz1zKv8IG+o87XoSWNdfp/uFI5GhQzVgzSzr9XsqgJF29oi
        pJ8Li7m2DEyC3hmRyVKIeXuZtrnN3e4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-EYckN3U-Nr-gmm0uyioYHg-1; Thu, 09 Feb 2023 09:10:29 -0500
X-MC-Unique: EYckN3U-Nr-gmm0uyioYHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73B0B100F91A;
        Thu,  9 Feb 2023 14:10:28 +0000 (UTC)
Received: from mail.corp.redhat.com (ovpn-192-232.brq.redhat.com [10.40.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8C552026D2A;
        Thu,  9 Feb 2023 14:10:26 +0000 (UTC)
Date:   Thu, 9 Feb 2023 15:10:22 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Walt Holman <waltholman09@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add support for Logitech G923 Xbox Edition steering
 wheel in hid-logitech-hidpp. We get the same level of features as the
 regular G920.
Message-ID: <20230209141022.oql7n52igjybh3km@mail.corp.redhat.com>
References: <20230207195051.16373-1-waltholman09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207195051.16373-1-waltholman09@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Walt, we are almost there. I have applied the following to your patch
(and will push upstream as soon as the CI says it's fine):

* subject must start with the subsystem: "HID: " in our case
* in your commit description, you should add a blanck line between the
  title of the commit and the description. Otherwise, git-format-patch
  considers everything to be the title, which is a little bit long :)
* the Signed-of-by line should be added in the commit description, so
  right here, before the first '---' so that it gets included in the
  commit itself
* for future submissions, please try to keep them numbered. Here, it
  should have been '[PATCH v2] HID: ...' and below the first '---' add
  what changed between v1 and v2.

Again, I have fixed everything, so no need to send another version :)

Cheers,
Benjamin

On Feb 07 2023, Walt Holman wrote:
> ---
>  drivers/hid/hid-ids.h            | 1 +
>  drivers/hid/hid-logitech-hidpp.c | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 0f8c11842a3a..de1f385b0ecc 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -819,6 +819,7 @@
>  #define USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO	0xc22e
>  #define USB_DEVICE_ID_LOGITECH_G29_WHEEL	0xc24f
>  #define USB_DEVICE_ID_LOGITECH_G920_WHEEL	0xc262
> +#define USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL	0xc26e
>  #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D	0xc283
>  #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO	0xc286
>  #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940	0xc287
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index abf2c95e4d0b..4dc833c8a44c 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4347,6 +4347,9 @@ static const struct hid_device_id hidpp_devices[] = {
>  	{ /* Logitech G920 Wheel over USB */
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
>  		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
> +	{ /* Logitech G923 Wheel (Xbox version) over USB */
> +	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL),
> +		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS },
>  	{ /* Logitech G Pro Gaming Mouse over USB */
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
>  
> -- 
> 2.37.2
> 
> --signed-of-by: Walt Holman (waltholman09@gmail.com)
> 

