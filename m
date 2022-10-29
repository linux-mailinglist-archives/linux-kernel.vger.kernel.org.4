Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B678612245
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJ2LPj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 29 Oct 2022 07:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ2LPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:15:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743C8237CC
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 04:15:31 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-146-75xd6qPbO8iGWQnN0ZN75w-1; Sat, 29 Oct 2022 12:15:28 +0100
X-MC-Unique: 75xd6qPbO8iGWQnN0ZN75w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 29 Oct
 2022 12:15:27 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Sat, 29 Oct 2022 12:15:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Julia Lawall' <julia.lawall@inria.fr>,
        UMWARI JOVIAL <umwarijovial@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>
Subject: RE: [PATCH] Remove Unnecessary typecast of c90 int constant
Thread-Topic: [PATCH] Remove Unnecessary typecast of c90 int constant
Thread-Index: AQHY6p4QqXp6c6aJbUmajhb1BaK9064lOaUg
Date:   Sat, 29 Oct 2022 11:15:27 +0000
Message-ID: <aca0b365ab6b46789fd20dec14454ad6@AcuMS.aculab.com>
References: <20221028063711.GA35659@rdm>
 <alpine.DEB.2.22.394.2210280918550.2845@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2210280918550.2845@hadrien>
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

From: Julia Lawall
> Sent: 28 October 2022 08:23
> 
> On Fri, 28 Oct 2022, UMWARI JOVIAL wrote:
> 
> > According to Linux kernel coding style.
> >
> > Reported by checkpatch:
> > WARNING: Unnecessary typecast of c90 int constant - '(int)2.412e8' could be '2.412e8'
> > WARNING: Unnecessary typecast of c90 int constant - '(int)2.487e8' could be '2.487e8'
> 
> It's not ideal to just include the checkpatch messges verbatim in your log
> message.  It woudl be better to say what you are doing and why, in
> complete sentences ("According to the Linux coding style" is not a
> complete sentence).
> 
> I also suspect that the checkpatch message is wrong.  Floating point
> numbers cannot be used in the kernel, and the case of the constant ensures
> that the value will be converted to an integer at compile time.

Much better to just use 241200000u (or 241200u * 1000 for readability).

	David

> 
> julia
> 
> >
> > Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
> > ---
> >  drivers/staging/rtl8192e/rtllib_softmac_wx.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> > index fdf867a5dd7a..4fc4fb25d8d6 100644
> > --- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> > +++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> > @@ -41,8 +41,8 @@ int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
> >
> >  	/* if setting by freq convert to channel */
> >  	if (fwrq->e == 1) {
> > -		if ((fwrq->m >= (int)2.412e8 &&
> > -		     fwrq->m <= (int)2.487e8)) {
> > +		if ((fwrq->m >= 2.412e8 &&
> > +		     fwrq->m <= 2.487e8)) {
> >  			int f = fwrq->m / 100000;
> >  			int c = 0;
> >
> > --
> > 2.25.1
> >
> >
> >

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

