Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0593B70DD38
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbjEWNJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbjEWNJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:09:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA683DB;
        Tue, 23 May 2023 06:09:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6608B60B2C;
        Tue, 23 May 2023 13:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729A5C433D2;
        Tue, 23 May 2023 13:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684847381;
        bh=tUIEDhWUragSFmrhWHZWpo9jbX/OndSi1BV6tpr5HO4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YS4OiW5L3gnYl6KDh1zP4R3wdbRu9FwgLJvmSHnYnegaxgKQPg/xIVpVvEhm/vWbb
         mSZJbuAy96tE/zB4qZl5luHpxOdk/blGabnpnBQldUTiSFsEV5ABjw1UTtbQUz38De
         VgwY3FMjPX04T6UqoJmjAi/IZ4oZucKufHlHrI0Dp63ajYUC2tuKri6T7DkzXl+Rza
         517W1RI6sSsVZCkeoUdPr4vHqKEnjv4vL22i9O2n++tf2a8EGa6ngQcELvix6dfmRw
         sT0N8rryBPe63f0W0VM2p+C/UBX2q2qFON3q0P1XEepFgsKzQ2WOd7455aWa0xQziJ
         RAj/8+uYKiI3w==
Date:   Tue, 23 May 2023 15:09:38 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sung-Chi Li <lschyi@chromium.org>
cc:     LKML <linux-kernel@vger.kernel.org>, phoenixshen@chromium.org,
        chentsung@chromium.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: google: add jewel USB id
In-Reply-To: <20230424023736.338464-1-lschyi@chromium.org>
Message-ID: <nycvar.YFH.7.76.2305231509260.29760@cbobk.fhfr.pm>
References: <20230424023736.338464-1-lschyi@chromium.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023, Sung-Chi Li wrote:

> Add 1 additional hammer-like device.
> 
> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> ---
> 
>  drivers/hid/hid-google-hammer.c | 2 ++
>  drivers/hid/hid-ids.h           | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> index 7ae5f27df54d..c6bdb9c4ef3e 100644
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -586,6 +586,8 @@ static const struct hid_device_id hammer_devices[] = {
>  		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_EEL) },
>  	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>  		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
> +	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> +		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_JEWEL) },
>  	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>  		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MAGNEMITE) },
>  	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index c2e9b6d1fd7d..c40cd6f1095f 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -528,6 +528,7 @@
>  #define USB_DEVICE_ID_GOOGLE_MOONBALL	0x5044
>  #define USB_DEVICE_ID_GOOGLE_DON	0x5050
>  #define USB_DEVICE_ID_GOOGLE_EEL	0x5057
> +#define USB_DEVICE_ID_GOOGLE_JEWEL	0x5061

Applied. Apologies for the delay.

Thanks,

-- 
Jiri Kosina
SUSE Labs

