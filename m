Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF66F638D69
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKYPWk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Nov 2022 10:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYPWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:22:39 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376B863E4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:22:34 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-272-AinR9xNaOC64AqHkfcoN4w-1; Fri, 25 Nov 2022 15:22:31 +0000
X-MC-Unique: AinR9xNaOC64AqHkfcoN4w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Nov
 2022 15:22:29 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 25 Nov 2022 15:22:29 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "'Joe Perches'" <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [PATCH 0/1] Slightly relax the type checking done by min() and
 max().
Thread-Topic: [PATCH 0/1] Slightly relax the type checking done by min() and
 max().
Thread-Index: AdkA3hAUrkOWi1xYRg2SAA6P778SAwAAwSsAAAASUCA=
Date:   Fri, 25 Nov 2022 15:22:29 +0000
Message-ID: <7fe2b744f0aa4d1c8852cdf93193f2af@AcuMS.aculab.com>
References: <cfc6c0f0fd4c4724890be8a8397c2cbe@AcuMS.aculab.com>
 <Y4Dcnha/JYoRl4HH@smile.fi.intel.com>
In-Reply-To: <Y4Dcnha/JYoRl4HH@smile.fi.intel.com>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: 25 November 2022 15:18
...
> You have an issue with your email setup, i.e. you send two independent messages
> (not a chain). It probably shows that either you don't use `git send-email` for
> sending patch, or you missed --thread option to it.

It is technically impossible for me to send (or view) threaded emails.
I have to send them using outlook.
The only way to avoid mangling the text is to cut&paste from wordpad.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

