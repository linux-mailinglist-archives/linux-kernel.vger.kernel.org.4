Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B41E7158AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjE3IhL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 May 2023 04:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjE3Igx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:36:53 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080B5A1;
        Tue, 30 May 2023 01:36:51 -0700 (PDT)
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0AD812000F;
        Tue, 30 May 2023 08:36:48 +0000 (UTC)
Message-ID: <468317007b2bcbcce28778f9a1d3ae0426563522.camel@hadess.net>
Subject: Re: [PATCH 1/1] HID: logitech-hidpp: Add USB and Bluetooth IDs for
 the Logitech G915 TKL Keyboard
From:   Bastien Nocera <hadess@hadess.net>
To:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, jikos@kernel.org
Cc:     Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 May 2023 10:36:48 +0200
In-Reply-To: <20230529233025.22932-1-stuart.a.hayhurst@gmail.com>
References: <20230529233025.22932-1-stuart.a.hayhurst@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-30 at 00:30 +0100, Stuart Hayhurst wrote:
> From: stuarthayhurst <stuart.a.hayhurst@gmail.com>
> 
> Adds the USB and Bluetooth IDs for the Logitech G915 TKL keyboard

Which functionality gets enabled by that addition, battery reporting,
something else?

> 
> ---
>  drivers/hid/hid-logitech-hidpp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index b2cd7527de19..28761272afe5 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4403,6 +4403,8 @@ static const struct hid_device_id
> hidpp_devices[] = {
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC086) },
>         { /* Logitech G903 Hero Gaming Mouse over USB */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC091) },
> +       { /* Logitech G915 TKL Keyboard over USB */
> +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC343) },
>         { /* Logitech G920 Wheel over USB */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_G920_WHEEL),
>                 .driver_data = HIDPP_QUIRK_CLASS_G920 |
> HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
> @@ -4418,6 +4420,8 @@ static const struct hid_device_id
> hidpp_devices[] = {
>         { /* MX5500 keyboard over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
>           .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
> +       { /* Logitech G915 TKL keyboard over Bluetooth */
> +         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb35f) },
>         { /* M-RCQ142 V470 Cordless Laser Mouse over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb008) },
>         { /* MX Master mouse over Bluetooth */

