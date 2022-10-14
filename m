Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9AE5FE7F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 06:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJNE2U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Oct 2022 00:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJNE2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 00:28:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4883818C942
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 21:28:14 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-281-qbtRuGIQO0Om9_IsP-xPYg-1; Fri, 14 Oct 2022 05:28:11 +0100
X-MC-Unique: qbtRuGIQO0Om9_IsP-xPYg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 14 Oct
 2022 05:28:10 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 14 Oct 2022 05:28:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willy Tarreau' <w@1wt.eu>, "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Mark Brown <broonie@kernel.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: gcc 5 & 6 & others already out of date?
Thread-Topic: gcc 5 & 6 & others already out of date?
Thread-Index: AQHY3x9k7iEL7dtsYEaMGjvDqAFL8a4NSzVg
Date:   Fri, 14 Oct 2022 04:28:10 +0000
Message-ID: <406260e46943493781891c480e4f8b17@AcuMS.aculab.com>
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
 <Y0gLyLbdOCetX5LN@sirena.org.uk> <Y0gteD0QYVlYxSZh@zx2c4.com>
 <20221013161813.GI16609@1wt.eu>
In-Reply-To: <20221013161813.GI16609@1wt.eu>
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

From: Willy Tarreau
> Sent: 13 October 2022 17:18
...
> That's also the model where people routinely do:
> 
>     $ curl github.com/blah | sudo sh

Anyone doing that wants their head examined....
I'm not sure I'd trust any source of files enough for that.

Maybe some things get run as root, and maybe they might
do nasty things, but running random downloaded scripts
is as bad as clicking on links in outlook.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

