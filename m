Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256DC65A5B6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 17:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiLaQbi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 31 Dec 2022 11:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiLaQbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 11:31:37 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0912F558E
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 08:31:34 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-213-AHTFuIkIMMqNt7aEoGq0EQ-1; Sat, 31 Dec 2022 16:31:32 +0000
X-MC-Unique: AHTFuIkIMMqNt7aEoGq0EQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 31 Dec
 2022 16:31:31 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Sat, 31 Dec 2022 16:31:31 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Shawn Webb' <shawn.webb@hardenedbsd.org>,
        "oss-security@lists.openwall.com" <oss-security@lists.openwall.com>
CC:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>
Subject: RE: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
Thread-Topic: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
Thread-Index: AQHZGtCXw3AZMxRdFEGt4rB+yFX0n66IM7kQ
Date:   Sat, 31 Dec 2022 16:31:30 +0000
Message-ID: <fe260c38cf7e416288449691bb9cb5dd@AcuMS.aculab.com>
References: <Y6SJDbKBk471KE4k@p183> <Y6TUJcr/IHrsTE0W@codewreck.org>
 <1a1963aa1036ba07@orthanc.ca> <20221228152458.6xyksrxunukjrtzx@mutt-hbsd>
In-Reply-To: <20221228152458.6xyksrxunukjrtzx@mutt-hbsd>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Webb
> Sent: 28 December 2022 15:25
> 
> On Tue, Dec 27, 2022 at 04:44:49PM -0800, Lyndon Nerenberg (VE7TFX/VE6BBM) wrote:
> > Dominique Martinet writes:
> >
> > > But, really, I just don't see how this can practically be said to be parsable...
> >
> > In its current form it never will be.  The solution is to place
> > this variable-length field last.  Then you can "cut -d ' ' -f 51-"
> > to get the command+args part (assuming I counted all those fields
> > correctly ...)
> >
> > Of course, this breaks backwards compatability.
> 
> It would also break forwards compatibility in the case new fields
> needed to be added.
> 
> The only solution would be a libxo-style feature wherein a
> machine-parseable format is exposed by virtue of a file extension.
> 
> Examples:
> 
> 1. /proc/pid/stats.json
> 2. /proc/pid/stats.xml
> 3. /proc/pid/stats.yaml_shouldnt_be_a_thing

None of those are of any real use if you are trying to parse the
data in something like a shell script.
Multiple lines formatted as "tag:value" are probably the best bet.
Provided something sane is done with embedded \n (and maybe \r).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

