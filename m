Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19BC60C95F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiJYKGE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Oct 2022 06:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiJYKFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:05:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4334517FD48
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:59:56 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-221-ubkgpKyWN-GZuVIw3Ovb-w-1; Tue, 25 Oct 2022 10:59:44 +0100
X-MC-Unique: ubkgpKyWN-GZuVIw3Ovb-w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Oct
 2022 10:59:16 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Tue, 25 Oct 2022 10:59:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Winischhofer <thomas@winischhofer.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH] video: fbdev: sis: use explicitly signed char
Thread-Topic: [PATCH] video: fbdev: sis: use explicitly signed char
Thread-Index: AQHY59GfTKHiiX1cE0qqKUXinyrVOK4e4PPg
Date:   Tue, 25 Oct 2022 09:59:16 +0000
Message-ID: <37a4d200e0b74c72854c018c02e18b50@AcuMS.aculab.com>
References: <20221024162901.535972-1-Jason@zx2c4.com>
In-Reply-To: <20221024162901.535972-1-Jason@zx2c4.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason A. Donenfeld
> Sent: 24 October 2022 17:29
> To: linux-kernel@vger.kernel.org
> 
> With char becoming unsigned by default, and with `char` alone being
> ambiguous and based on architecture, signed chars need to be marked
> explicitly as such. This fixes warnings like:
> 
...
> ---
>  drivers/usb/misc/sisusbvga/sisusb_struct.h | 2 +-
>  drivers/video/fbdev/sis/vstruct.h          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/misc/sisusbvga/sisusb_struct.h b/drivers/usb/misc/sisusbvga/sisusb_struct.h
> index 3df64d2a9d43..a86032a26d36 100644
> --- a/drivers/usb/misc/sisusbvga/sisusb_struct.h
> +++ b/drivers/usb/misc/sisusbvga/sisusb_struct.h
> @@ -91,7 +91,7 @@ struct SiS_Ext {
>  	unsigned char VB_ExtTVYFilterIndex;
>  	unsigned char VB_ExtTVYFilterIndexROM661;
>  	unsigned char REFindex;
> -	char ROMMODEIDX661;
> +	signed char ROMMODEIDX661;

Isn't the correct fix to use u8 and s8 ?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

