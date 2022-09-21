Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5185BFBBC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIUJy2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Sep 2022 05:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiIUJxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:53:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09D792F6C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:52:06 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-323-s3vy6a1IM_qw-LkxN2iECw-1; Wed, 21 Sep 2022 10:52:03 +0100
X-MC-Unique: s3vy6a1IM_qw-LkxN2iECw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 21 Sep
 2022 10:52:01 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 21 Sep 2022 10:52:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
        Jiangshan Yi <13667453960@163.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: RE: [PATCH] fs/efs/inode.c: use __func__ instead of function name
Thread-Topic: [PATCH] fs/efs/inode.c: use __func__ instead of function name
Thread-Index: AQHYzIdskrFLZR+H2ka5LnnQ208eAK3ppj5g
Date:   Wed, 21 Sep 2022 09:52:01 +0000
Message-ID: <c024f9d09a68417f8326ec318aec87ce@AcuMS.aculab.com>
References: <20220919023314.3622391-1-13667453960@163.com>
 <YykIOg0ApQycqOxu@ZenIV>
In-Reply-To: <YykIOg0ApQycqOxu@ZenIV>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro
> Sent: 20 September 2022 01:24
> 
> On Mon, Sep 19, 2022 at 10:33:14AM +0800, Jiangshan Yi wrote:
> > From: Jiangshan Yi <yijiangshan@kylinos.cn>
> >
> > It is better to use __func__ instead of function name.
> 
> 	Why is it better?  And why is it *not* sent to (active)
> maintainers of fs/erofs?  I'm not going to apply that behind their
> backs and I would ask akpm to abstain from taking that one.

It is distinctly worse.
Anyone grepping the kernel source for the message text will
fail to find it.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

