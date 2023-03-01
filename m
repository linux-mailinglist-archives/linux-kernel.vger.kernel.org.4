Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1EC6A68D3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjCAIWC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Mar 2023 03:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCAIWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:22:01 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3B41B0;
        Wed,  1 Mar 2023 00:21:59 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 7B3B940009;
        Wed,  1 Mar 2023 08:21:56 +0000 (UTC)
Message-ID: <0e7312fba2edeebde9250b3c0b6be8050dbd0e8e.camel@hadess.net>
Subject: Re: [PATCH 1/1] HID: logitech-hidpp: Add support for Logitech MX
 Master 3S mouse
From:   Bastien Nocera <hadess@hadess.net>
To:     =?UTF-8?Q?Rafa=C5=82?= Szalecki <perexist7@gmail.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>
Date:   Wed, 01 Mar 2023 09:21:56 +0100
In-Reply-To: <20230301012356.940756-1-perexist7@gmail.com>
References: <20230301012356.940756-1-perexist7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-03-01 at 02:23 +0100, Rafał Szalecki wrote:
> Add signature for the Logitech MX Master 3S mouse over Bluetooth.
> 
> Signed-off-by: Rafał Szalecki <perexist7@gmail.com>

Reviewed-by: Bastien Nocera <hadess@hadess.net>

Thanks!

> ---
> Hello,
> 
> I'm sending the patch to add the support for Logitech MX Master 3S
> mouse. The main reason for adding the support for this mouse was to
> enable high precision scrolling as it is now supported by Wayland
> composers. Tested with KDE 5.27. High precision scrolling was
> configured with Solaar and successfully tested with Brave browser.
> 
>  drivers/hid/hid-logitech-hidpp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index 25dcda76d6c7..5fc88a063297 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4399,6 +4399,8 @@ static const struct hid_device_id
> hidpp_devices[] = {
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb02a) },
>         { /* MX Master 3 mouse over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
> +       { /* MX Master 3S mouse over Bluetooth */
> +         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb034) },
>         {}
>  };
>  

