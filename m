Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C967690C3F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjBIOzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjBIOzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:55:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36608530C9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675954483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DpgL/IcISKsq7IcCEre0n6OsL5J/bZYwcM0Lm4TahMs=;
        b=A4C7HTyLpg6XGDOIJjdVamIicqu/h+pjrg/vlq3lc3sqyaeP+tUOqAyLIGbqk1wdHbUFM1
        oey7ao5oG1qyoMdLYiCKsnN9AFAMEZXdNU8AiB9wK3X/d0ZCZvX49hWjFZ0KmBlHGnKoN9
        Lfa0yNyWVjKJgqXm5lpCFB1l0biradI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-Dp3dJkwtMWSF9__ZQ15reQ-1; Thu, 09 Feb 2023 09:54:40 -0500
X-MC-Unique: Dp3dJkwtMWSF9__ZQ15reQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D22543C025D7;
        Thu,  9 Feb 2023 14:54:39 +0000 (UTC)
Received: from mail.corp.redhat.com (ovpn-192-232.brq.redhat.com [10.40.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 301791121314;
        Thu,  9 Feb 2023 14:54:33 +0000 (UTC)
Date:   Thu, 9 Feb 2023 15:54:26 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH v2 1/3] HID: logitech-hidpp: Add more debug statements
Message-ID: <20230209145426.njlfqdqr2etnhfog@mail.corp.redhat.com>
References: <20230206221256.129198-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206221256.129198-1-hadess@hadess.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 06 2023, Bastien Nocera wrote:
> This should help us figure out some hairy problems with some devices.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

FWIW, I am currently testing this patch and will probably push it today.

Cheers,
Benjamin

> ---
> 
> Fixed kernel test bot warning:
>    drivers/hid/hid-logitech-hidpp.c: In function 'hidpp_send_fap_command_sync':
> >> drivers/hid/hid-logitech-hidpp.c:343:25: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Wformat=]
>      343 |                         "Invalid number of parameters passed to command (%d != %ld)\n",
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>  drivers/hid/hid-logitech-hidpp.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index f44ba7be3cc5..1952d8d3b6b2 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -338,8 +338,13 @@ static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
>  	struct hidpp_report *message;
>  	int ret;
>  
> -	if (param_count > sizeof(message->fap.params))
> +	if (param_count > sizeof(message->fap.params)) {
> +		hid_dbg(hidpp->hid_dev,
> +			"Invalid number of parameters passed to command (%d != %llu)\n",
> +			param_count,
> +			(unsigned long long) sizeof(message->fap.params));
>  		return -EINVAL;
> +	}
>  
>  	message = kzalloc(sizeof(struct hidpp_report), GFP_KERNEL);
>  	if (!message)
> @@ -3440,11 +3445,17 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
>  		ret = hidpp10_enable_scrolling_acceleration(hidpp);
>  		multiplier = 8;
>  	}
> -	if (ret)
> +	if (ret) {
> +		hid_dbg(hidpp->hid_dev,
> +			"Could not enable hi-res scrolling: %d\n", ret);
>  		return ret;
> +	}
>  
> -	if (multiplier == 0)
> +	if (multiplier == 0) {
> +		hid_dbg(hidpp->hid_dev,
> +			"Invalid multiplier 0 from device, setting it to 1\n");
>  		multiplier = 1;
> +	}
>  
>  	hidpp->vertical_wheel_counter.wheel_multiplier = multiplier;
>  	hid_dbg(hidpp->hid_dev, "wheel multiplier = %d\n", multiplier);
> -- 
> 2.39.1
> 

