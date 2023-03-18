Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3D16BFA14
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 13:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjCRM63 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 18 Mar 2023 08:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRM61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 08:58:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFC02F067
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 05:58:25 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-321-xbDhQ8nbPeueo_HxbHsttA-1; Sat, 18 Mar 2023 12:58:22 +0000
X-MC-Unique: xbDhQ8nbPeueo_HxbHsttA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Sat, 18 Mar
 2023 12:58:20 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Sat, 18 Mar 2023 12:58:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: THP backed thread stacks
Thread-Topic: THP backed thread stacks
Thread-Index: AQHZWPlZJwMTNLTeV0WLE6c5qQ1d3K8AfxPA
Date:   Sat, 18 Mar 2023 12:58:20 +0000
Message-ID: <9725accc24aa4d76b01cdc9b210d12d4@AcuMS.aculab.com>
References: <20230306235730.GA31451@monkey>
 <ZBSo+mLUOsKvy3rC@casper.infradead.org>
In-Reply-To: <ZBSo+mLUOsKvy3rC@casper.infradead.org>
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

From: Matthew Wilcox
> Sent: 17 March 2023 17:53
...
> My understanding is that for a normal app (like, say, 'cat'), we'll
> allow up to an 8MB stack, but we only create a VMA that is 4kB in size
> and set the VM_GROWSDOWN flag on it (to allow it to magically grow).
> Therefore we won't create a 2MB page because the VMA is too small.

Is there anyway that glibc (or anything else) could request that
for a thread stack?

It would make the process 'memory size' reported by ps/top
much more meaningful for programs with threads.
I've noticed some (what should be) small programs having a
size (rss?) of 277m.
I'm sure a lot of it is thread stack.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

