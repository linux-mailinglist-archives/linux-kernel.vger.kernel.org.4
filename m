Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0345F72C3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjFLMQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjFLMQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:16:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722788F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:16:33 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-91-XdQt0ZPZNuyOONttEZbueQ-1; Mon, 12 Jun 2023 13:16:30 +0100
X-MC-Unique: XdQt0ZPZNuyOONttEZbueQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 12 Jun
 2023 13:16:19 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 12 Jun 2023 13:16:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>
CC:     Breno Leitao <leitao@debian.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "leit@meta.com" <leit@meta.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Thread-Topic: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Thread-Index: AQHZmviQI/r0/Sv4xEqYGehxHbaKRa+HB92A///5/gCAABWy8A==
Date:   Mon, 12 Jun 2023 12:16:19 +0000
Message-ID: <bdcc00582da6454ab7e5778ad108a1d7@AcuMS.aculab.com>
References: <20230203120615.1121272-1-leitao@debian.org>
 <20230609173343.GDZINid4EgJGnkW7HK@fat_crate.local>
 <543116e1a8cf4b7a8b086c850374f99e@AcuMS.aculab.com>
 <20230612115154.GEZIcG2tWkn8I0+E2t@fat_crate.local>
In-Reply-To: <20230612115154.GEZIcG2tWkn8I0+E2t@fat_crate.local>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDEyIEp1bmUgMjAyMyAxMjo1Mg0KPiANCj4g
T24gTW9uLCBKdW4gMTIsIDIwMjMgYXQgMTE6MjI6MTVBTSArMDAwMCwgRGF2aWQgTGFpZ2h0IHdy
b3RlOg0KPiA+IEkgY2FuIGRlZmluaXRlbHkganVzdGlmeSBjb21waWxpbmcgdGhlbSBhbGwgb3V0
Lg0KPiA+IEZvciBpbnN0YW5jZSBlbWJlZGRlZCBzeXN0ZW1zIHdpdGggbGltaXRlZCB1c2Vyc3Bh
Y2UgYW5kDQo+ID4gKHByZXR0eSBtdWNoKSBldmVyeXRoaW5nIHJ1bm5pbmcgYXMgcm9vdC4NCj4g
DQo+IE5vdGhpbmcncyBzdG9wcGluZyB5b3UgZnJvbSBhZGRpbmcgIm1pdGlnYXRpb25zPW9mZiIg
dG8geW91ciBncnViDQo+IGNvbmZpZy4NCg0KSSBkbyAoYW5kIEkgY29tcGlsZSB3aXRob3V0IHBh
Z2UgdGFibGUgc2VwYXJhdGlvbiksDQpidXQgc29tZSBvZiB0aGUgcnVuLXRpbWUgcGF0Y2hlZCB2
ZXJzaW9ucyBhcmUgbm90IGFzICdnb29kJw0KYXMgY29tcGlsaW5nIHRoZSBjb2RlIG91dC4NCkl0
IG1pZ2h0IGp1c3QgYmUgc29tZSBub3BzLCBidXQgbWF5YmUgaXQgaXMgd29yc2UuDQpUaGlzIGNh
biBiZSBwYXJ0aWN1bGFybHkgdHJ1ZSBmb3IgbmV3IG1pdGlnYXRpb25zLg0KDQoJRGF2aWQNCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K

