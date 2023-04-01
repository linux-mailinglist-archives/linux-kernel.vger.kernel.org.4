Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823946D332B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjDASdh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 1 Apr 2023 14:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDASdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:33:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4774A128
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 11:33:34 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-310-9qR693MXNOmG_FSLux21XA-1; Sat, 01 Apr 2023 19:33:31 +0100
X-MC-Unique: 9qR693MXNOmG_FSLux21XA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 1 Apr
 2023 19:33:28 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 1 Apr 2023 19:33:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vlastimil Babka' <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] mm: remove all the slab allocators
Thread-Topic: [PATCH] mm: remove all the slab allocators
Thread-Index: AQHZZH7yC1nc5Yxd6ES5VUUdsjQvja8WxpGg
Date:   Sat, 1 Apr 2023 18:33:28 +0000
Message-ID: <eea7e17ab4264b7ca7ccea0ab725120f@AcuMS.aculab.com>
References: <20230401094658.11146-1-vbabka@suse.cz>
In-Reply-To: <20230401094658.11146-1-vbabka@suse.cz>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vlastimil Babka
> Sent: 32 March 2023 10:47
> 
> As the SLOB removal is on track and the SLAB removal is planned, I have
> realized - why should we stop there and not remove also SLUB? What's a
> slab allocator good for in 2023? The RAM sizes are getting larger and
> the modules cheaper [1]. The object constructor trick was perhaps
> interesting in 1994, but not with contemporary CPUs. So all the slab
> allocator does today is just adding an unnecessary layer of complexity
> over the page allocator.

Why stop there?
Remove kmalloc() completely.
With cheap memory isn't unreasonable to go back to compile-time
settable fixed size arrays for all items.
Should make 'use after free' much easier to track down.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

