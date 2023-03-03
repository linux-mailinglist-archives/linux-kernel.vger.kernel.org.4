Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAA86A990F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCCOFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjCCOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:05:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B54761530;
        Fri,  3 Mar 2023 06:05:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BAE06182E;
        Fri,  3 Mar 2023 14:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DE2C433EF;
        Fri,  3 Mar 2023 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677852316;
        bh=D4OGBQMV3kIvKtXN5nmPzVPwjeBndJk4gNY4ETLcbA4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=blt0YT3hY3kFwvj5l7EoIWRJRO312sexuk1X+a9gPQWEd1dkJAXzsghYBZqrzJ8V7
         u5a6lB0U6g/DpPVEm3y1UoxNoP4PhVJLP0lHBLVyuRTO91J+ed6HOeexpxdxw6Yv8n
         CLLgPzI4x9rO+IC1JpJMVRZc1N9LuIbQYLXA9o8BkdE/SAOJ1ZqRYPm/Wr8mhmst9V
         rQb3NMdw6QAw8JUidLenPqL2wS2LpvxEv7kkdRJCS/KbqBbddjOJ4K3bPN1jjordaJ
         NHUwwFSZDKGznRorgHZD79lbdr0Ux1m1k/SqdUhSuBJBtmsBoXRuK7zYj89xATzE33
         X/ZaLhabVfYtQ==
Date:   Fri, 3 Mar 2023 15:05:18 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-2?Q?Rafa=B3_Szalecki?= <perexist7@gmail.com>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 1/1] HID: logitech-hidpp: Add support for Logitech MX
 Master 3S mouse
In-Reply-To: <20230301012356.940756-1-perexist7@gmail.com>
Message-ID: <nycvar.YFH.7.76.2303031505130.1142@cbobk.fhfr.pm>
References: <20230301012356.940756-1-perexist7@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023, Rafał Szalecki wrote:

> Add signature for the Logitech MX Master 3S mouse over Bluetooth.
> 
> Signed-off-by: Rafał Szalecki <perexist7@gmail.com>
> ---
> Hello,
> 
> I'm sending the patch to add the support for Logitech MX Master 3S mouse. The main reason for adding the support for this mouse was to enable high precision scrolling as it is now supported by Wayland composers. Tested with KDE 5.27. High precision scrolling was configured with Solaar and successfully tested with Brave browser.
> 
>  drivers/hid/hid-logitech-hidpp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 25dcda76d6c7..5fc88a063297 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4399,6 +4399,8 @@ static const struct hid_device_id hidpp_devices[] = {
>  	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb02a) },
>  	{ /* MX Master 3 mouse over Bluetooth */
>  	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
> +	{ /* MX Master 3S mouse over Bluetooth */
> +	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb034) },
>  	{}
>  };

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

