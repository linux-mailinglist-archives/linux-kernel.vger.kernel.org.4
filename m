Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2F8609E84
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJXKFW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Oct 2022 06:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJXKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:05:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8923D585
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:05:12 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-198-_bLmbDQ9PiS-I0Bw451AAA-1; Mon, 24 Oct 2022 11:05:08 +0100
X-MC-Unique: _bLmbDQ9PiS-I0Bw451AAA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Oct
 2022 11:05:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Mon, 24 Oct 2022 11:05:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
CC:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Thread-Topic: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Thread-Index: AQHY54ozH4qdMwC1Yk+S6+0KOnujn64dR6XQ///w5gCAABLzkP//8/YAgAARZrA=
Date:   Mon, 24 Oct 2022 10:05:06 +0000
Message-ID: <d9df89d15b77446fae5c64f96e2cb6ad@AcuMS.aculab.com>
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com> <Y1ZQpcdK4sdy+5QZ@kroah.com>
 <Y1ZW2WYli7Bfioxr@paasikivi.fi.intel.com>
 <Y1ZZcL/Q7QJ+YYhJ@smile.fi.intel.com>
 <fbe735d131a44c2a95248cc4ad51485b@AcuMS.aculab.com>
 <Y1ZcyBd2Yjir/dNO@smile.fi.intel.com>
 <57360b976d5944babe1e85fc51b3f6f6@AcuMS.aculab.com>
 <Y1ZilPypeNNjl/6J@kroah.com>
In-Reply-To: <Y1ZilPypeNNjl/6J@kroah.com>
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

From: Greg Kroah-Hartman
> Sent: 24 October 2022 11:02
> 
> On Mon, Oct 24, 2022 at 09:46:40AM +0000, David Laight wrote:
> > From: 'Andy Shevchenko'
> > > Sent: 24 October 2022 10:37
> > > ...
> > >
> > > > > > > Wait, no one uses this macro, so why not just remove it entirely?
...
> > It might be interesting to check how many of the function
> > can actually have a NULL pointer?
> > Especially in staging code might be being 'defensive'.
> 
> This is a pointless discussion, this macro will now be deleted, sorry.

I think we actually agree :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

