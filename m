Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE02667AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjALQXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjALQWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:22:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB8E55B0;
        Thu, 12 Jan 2023 08:19:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE76A62071;
        Thu, 12 Jan 2023 16:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58166C433EF;
        Thu, 12 Jan 2023 16:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673540374;
        bh=KIhE0X/TCSZ5yljv2IhM8/pMTZ0UticyVsF8g70H148=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLMVgh0Qy8MTdtsLGUGUgtTJ5xr/F5yp7nJdu0pKLXw3oAEYRAsoQq9BxUmi8VTIM
         74FAK81RdQ/jaiNhYcgHtWBGY9hssnYq9x/1I/8Uw2wdpkQzYxHUv2QskitQeYzu8l
         UgT5qh/2WOQ0mLBbqtfxDgDgBWlaWqFj5dzOZrpLHrb10CfO2enHMo3eMaVn6yBz5q
         RMaj+sntLqdwz5Z4dNoG+1jux4M0BBnAy1e3QIL7Mvqi3iAGbdesXTLKlMbBLuAgw7
         gxTuilJFD0et/FW24g0gL6BFgq2BOKh5vJmBE3l+f+Fwx/UDMBtSNm8dcmPidbYSgT
         E4hnVu0hwubHA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pG0In-0003Nw-34; Thu, 12 Jan 2023 17:19:41 +0100
Date:   Thu, 12 Jan 2023 17:19:41 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Duke =?utf-8?B?WGluKOi+m+WuieaWhyk=?= <duke_xinanwen@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jerry.meng@quectel.com,
        duke.xin@quectel.com
Subject: Re: [PATCH] USB: serial: option: add Quectel EM05CN modem
Message-ID: <Y8AzHUc4R9M/mK2L@hovoldconsulting.com>
References: <20221214043546.10339-1-duke_xinanwen@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221214043546.10339-1-duke_xinanwen@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 08:35:46PM -0800, Duke Xin(辛安文) wrote:
> Add support for the following Quectel EM05CN composition:
> 
> 0x0312: AT + MBIM + DIAG + NMEA + MODEM
> 
> usb-devices output:
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=0312 Rev= 3.18
> S:  Manufacturer=Quectel
> S:  Product=Quectel EM05-CN
> C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
> A:  FirstIf#= 1 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
> E:  Ad=89(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
> I:  If#= 2 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:* If#= 2 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Signed-off-by: Duke Xin(辛安文) <duke_xinanwen@163.com>
> ---
>  drivers/usb/serial/option.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index dee79c7d82d5..a35842be0ca0 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -256,6 +256,7 @@ static void option_instat_callback(struct urb *urb);
>  #define QUECTEL_PRODUCT_EM05G			0x030a
>  #define QUECTEL_PRODUCT_EM060K			0x030b
>  #define QUECTEL_PRODUCT_EM05G_SG		0x0311
> +#define QUECTEL_PRODUCT_EM05CN                0x0312

Please use tabs for indenting the values and make sure they line up with
the surrounding ones.

>  #define QUECTEL_PRODUCT_EM12			0x0512
>  #define QUECTEL_PRODUCT_RM500Q			0x0800
>  #define QUECTEL_PRODUCT_RM520N			0x0801
> @@ -1163,6 +1164,8 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(6) | ZLP },
>  	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_SG, 0xff),
>  	  .driver_info = RSVD(6) | ZLP },
> +	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05CN, 0xff),
> +	  .driver_info = RSVD(6) | ZLP },

Based on the usb-devices output above you have no interface #6 so this
should not be needed, right?

>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0x00, 0x40) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x30) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x40) },

Johan
