Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7050743B28
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjF3Lvu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 07:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjF3Lvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:51:47 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0A43A92;
        Fri, 30 Jun 2023 04:51:45 -0700 (PDT)
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1BBFC0003;
        Fri, 30 Jun 2023 11:51:42 +0000 (UTC)
Message-ID: <98d83bf9c423c6ad7317cd6b6eb9474942739963.camel@hadess.net>
Subject: Re: [PATCH v3] HID: logitech-hidpp: Add wired USB id for Logitech
 G502 Lightspeed
From:   Bastien Nocera <hadess@hadess.net>
To:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>
Date:   Fri, 30 Jun 2023 13:51:42 +0200
In-Reply-To: <20230630113818.13005-1-stuart.a.hayhurst@gmail.com>
References: <20230630113818.13005-1-stuart.a.hayhurst@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-30 at 12:38 +0100, Stuart Hayhurst wrote:
> Previously, support for the G502 had been attempted in commit
> '27fc32fd9417 ("HID: logitech-hidpp: add USB PID for a few more
> supported mice")'
> 
> This caused some issues and was reverted by
> 'addf3382c47c ("Revert "HID: logitech-hidpp: add USB PID for a few
> more
> supported mice"")'.
> 
> Since then, a new version of this mouse has been released (Lightpseed
> Wireless), and works correctly.
> 
> This device has support for battery reporting with the driver
> 
> Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> ---
> 
> Changes:
> v3:
>  - Add git commit titles
> v2:
>  - Add commit references
> 
> ---
>  drivers/hid/hid-logitech-hidpp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index 5e1a412fd28f..94a045ef8e50 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4598,6 +4598,8 @@ static const struct hid_device_id
> hidpp_devices[] = {
>  
>         { /* Logitech G403 Wireless Gaming Mouse over USB */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
> +       { /* Logitech G502 Lightspeed Wireless Gaming Mouse over USB
> */
> +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08D) },
>         { /* Logitech G703 Gaming Mouse over USB */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
>         { /* Logitech G703 Hero Gaming Mouse over USB */

