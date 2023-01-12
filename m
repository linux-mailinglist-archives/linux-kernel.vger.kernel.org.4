Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C9D667AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjALQd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239847AbjALQdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:33:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6FCB4BC;
        Thu, 12 Jan 2023 08:31:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D14B76209A;
        Thu, 12 Jan 2023 16:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8B5C43392;
        Thu, 12 Jan 2023 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673541068;
        bh=n0MeAvuzH6WUrj4MTycwGt8rNRUeUXI8SUJ0izEk4LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWIE4TiN6t5ZFJf2gz88bQ0rYRrLxz/Ul/4cwlAfpbNj0gzrdmZ4qDajpM6/j0qs2
         4vDiEB+jd+Z6P4AlLtXy2aUUUZiTbiunTjl3c1qOS0Ph1gVWG4HQsGH3YgeCUJfN/g
         AWSNGFL+dK0w6UDPYMxypGCW5jjv0Qz34lEJ+OQs857ZamZOU8PtBZ9e3JFVl//GAB
         XxFAdtNVnsTy8q8cphIqLbmia0OJ94CT8PyAPUh0FP3NBHGhzEApvfHRb2S63EHWyl
         RL3Az+Yp6s/cuZERmFXrGGrAfSwFt36sLdLZTFCM28RRDv4N33LzRpmooTrTgLtV3g
         W5NIGl5RhgwMA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pG0Tz-0003ck-Q2; Thu, 12 Jan 2023 17:31:15 +0100
Date:   Thu, 12 Jan 2023 17:31:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Duke =?utf-8?B?WGluKOi+m+WuieaWhyk=?= <duke_xinanwen@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jerry.meng@quectel.com,
        duke.xin@quectel.com
Subject: Re: [PATCH] USB: serial: option: add Quectel EM05CN modem
Message-ID: <Y8A10wPq3NoN/jUv@hovoldconsulting.com>
References: <20221227090109.115731-1-duke_xinanwen@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221227090109.115731-1-duke_xinanwen@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 01:01:08AM -0800, Duke Xin(辛安文) wrote:
> Add support for the following Quectel EM05CN composition:
> 
> 0x0310: AT + MBIM + DIAG + NMEA + MODEM
> 
> usb-devices output:
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=0310 Rev= 3.18
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
> index dee79c7d82d5..0f5c479fa678 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -256,6 +256,7 @@ static void option_instat_callback(struct urb *urb);
>  #define QUECTEL_PRODUCT_EM05G			0x030a
>  #define QUECTEL_PRODUCT_EM060K			0x030b
>  #define QUECTEL_PRODUCT_EM05G_SG		0x0311
> +#define QUECTEL_PRODUCT_EM05CN_SG		0x0310

This one should go before 0x0311.

>  #define QUECTEL_PRODUCT_EM12			0x0512
>  #define QUECTEL_PRODUCT_RM500Q			0x0800
>  #define QUECTEL_PRODUCT_RM520N			0x0801
> @@ -1163,6 +1164,8 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(6) | ZLP },
>  	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_SG, 0xff),
>  	  .driver_info = RSVD(6) | ZLP },
> +	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05CN_SG, 0xff),
> +	  .driver_info = RSVD(6) | ZLP },

Looks like you don't have an interface #6 here either. If this is
something that is only needed in some mode or similar, then please
mention that in the commit message.

>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0x00, 0x40) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x30) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x40) },

Johan
