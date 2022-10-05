Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE65F562C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJEONX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Oct 2022 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJEONT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:13:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F778786CA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 07:13:18 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-277-pbZ9B6vQOZqIfuygrqUt7Q-1; Wed, 05 Oct 2022 15:13:15 +0100
X-MC-Unique: pbZ9B6vQOZqIfuygrqUt7Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 5 Oct
 2022 15:13:13 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 5 Oct 2022 15:13:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Enzo Matsumiya' <ematsumiya@suse.de>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
CC:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        "Ronnie Sahlberg" <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        "Tom Talpey" <tom@talpey.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] cifs: remove initialization value
Thread-Topic: [PATCH 1/2] cifs: remove initialization value
Thread-Index: AQHY1/zYsp5T2i23xkGOtbqlLehPIK3/2DFg
Date:   Wed, 5 Oct 2022 14:13:13 +0000
Message-ID: <fbb39e4354434cb99b6f6731cab2e0c9@AcuMS.aculab.com>
References: <20221004062333.416225-1-usama.anjum@collabora.com>
 <20221004142306.ysgh45nhgdo4z3ok@suse.de>
In-Reply-To: <20221004142306.ysgh45nhgdo4z3ok@suse.de>
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

From: Enzo Matsumiya
> Sent: 04 October 2022 15:23
> 
> Hi Usama,
> 
> On 10/04, Muhammad Usama Anjum wrote:
> >Don't initialize the rc as its value is being overwritten before its
> >use.
> 
> Being bitten by an unitialized variable bug as recent as 2 days ago, I'd
> say this is a step backwards from the "best practices" POV.

Depends on your POV.

If you don't initialise locals there is a fair chance that the
compiler will detect buggy code.

If you initialise them you get well defined behaviour - but
the compiler won't find bugs for you.

Mostly the kernel is in the first camp.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

