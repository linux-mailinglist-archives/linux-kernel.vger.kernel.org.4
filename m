Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA16EAF59
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjDUQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjDUQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:39:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE9AE47
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:39:34 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-221-LzxJYqU5Ow-hxxu1l_t_zA-1; Fri, 21 Apr 2023 17:39:32 +0100
X-MC-Unique: LzxJYqU5Ow-hxxu1l_t_zA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 21 Apr
 2023 17:39:30 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 21 Apr 2023 17:39:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joy Chakraborty' <joychakr@google.com>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manugautam@google.com" <manugautam@google.com>,
        "rohitner@google.com" <rohitner@google.com>
Subject: RE: [PATCH v8 5/5] spi: dw: Round of n_bytes to power of 2
Thread-Topic: [PATCH v8 5/5] spi: dw: Round of n_bytes to power of 2
Thread-Index: AQHZdDLD1iEgTrZDeE+sBNd9TfRPX6818oJA
Date:   Fri, 21 Apr 2023 16:39:30 +0000
Message-ID: <969a083998224016947f5e77218f4587@AcuMS.aculab.com>
References: <20230420055131.2048959-1-joychakr@google.com>
 <20230420055131.2048959-6-joychakr@google.com>
 <20230421085354.34dwrgr3enlxqhtc@mobilestation>
 <CAOSNQF1aK2EdgeUbNN4Bpp8hjPHTzBwt-q6+-Wb24VSsUOtSqA@mail.gmail.com>
In-Reply-To: <CAOSNQF1aK2EdgeUbNN4Bpp8hjPHTzBwt-q6+-Wb24VSsUOtSqA@mail.gmail.com>
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
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm95IENoYWtyYWJvcnR5DQo+IFNlbnQ6IDIxIEFwcmlsIDIwMjMgMTA6MjINCi4uLg0K
PiBTdXJlLCBJIGNhbiBtYWtlIHRoZSBmb2xsb3dpbmcgY2hhbmdlIGluIHRoZSBmb3JtYXR0aW5n
IGFuZCBzZW5kIHRoZQ0KPiBwYXRjaCBzZXJpZXM6DQo+ICAgICAgICAgIGR3cy0+bl9ieXRlcyA9
DQo+ICAgICAgICAgICAgICAgICAgcm91bmR1cF9wb3dfb2ZfdHdvKERJVl9ST1VORF9VUCh0cmFu
c2Zlci0+Yml0c19wZXJfd29yZCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJJVFNfUEVSX0JZVEUpKTsNCg0KV29uJ3QgY2hlY2twYXRjaCBibGVh
dCBhYm91dCB0aGF0Pw0KDQpJcyBpdCBldmVyIGFjdHVhbGx5IHZhbGlkIGZvciB0aGUgY2FsbGVy
IHRvIHByb3ZpZGUgYQ0KdmFsdWUgdGhhdCBpc24ndCA4LCAxNiBvciAzMiA/DQoNCkknbSBzdXJl
IGl0IGxvb2tlZCBhcyB0aG91Z2ggc29tZSBvdGhlciBsZW5ndGhzL2NvdW50cw0Kd2hlcmUgbGlr
ZWx5IHRvIGdvIGJhZGx5IHdyb25nLg0KDQpJIGtub3cgdGhlcmUgYXJlIHRpbWVzIHdoZW4gaXQg
aXMgdXNlZnVsIHRvIGJpdC1iYW5nICdvZGQnDQpudW1iZXJzIG9mIGJpdHMgLSBsaWtlIGNvbW1h
bmQrYWRkcmVzcytkZWxheSBmb3IgZmFzdCByZWFkcw0KYnV0IHRoYXQgaXMgYSBzdWItMzJiaXQg
dHJhbnNmZXIgc28gKGF0IGxlYXN0IHNvbWV3aGVyZSkNCmlzIDEgd29yZCBidXQgbm90IGFsbCB0
aGUgYml0cy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

