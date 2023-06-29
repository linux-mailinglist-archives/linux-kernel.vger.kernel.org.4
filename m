Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01683742E03
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjF2UAP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 16:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjF2UAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:00:08 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91762D5B;
        Thu, 29 Jun 2023 13:00:06 -0700 (PDT)
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0D28FF80A;
        Thu, 29 Jun 2023 20:00:03 +0000 (UTC)
Message-ID: <c1f92c939cad778a5943207161dd026f7b62c8e6.camel@hadess.net>
Subject: Re: [PATCH] HID: logitech-hidpp: Add wired USB id for Logitech G502
 Lightspeed
From:   Bastien Nocera <hadess@hadess.net>
To:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>
Date:   Thu, 29 Jun 2023 22:00:03 +0200
In-Reply-To: <20230629192422.980071-1-stuart.a.hayhurst@gmail.com>
References: <20230629192422.980071-1-stuart.a.hayhurst@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-29 at 20:24 +0100, Stuart Hayhurst wrote:
> Previously, support for the G502 had been attempted and reverted
> within this driver.

Can you please mention the commit(s) where this was done?

> Since then, a new version of this mouse has been released, and seems
> to work fine.

Can you please list the features that get enabled by adding this USB ID
to the list in the commit message?

Cheers

> 
> Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index 5e1a412fd28f..050bad0f9aca 100644
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

