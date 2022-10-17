Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB92B600DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiJQLic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiJQLia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:38:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1300E57BCA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:38:28 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-255-Bmg7jhz4PN2oTzRNHy1Z4Q-1; Mon, 17 Oct 2022 12:38:26 +0100
X-MC-Unique: Bmg7jhz4PN2oTzRNHy1Z4Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Oct
 2022 12:38:24 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Mon, 17 Oct 2022 12:38:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Morton' <akpm@linux-foundation.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
CC:     =?utf-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gcov: support GCC 12.1 and newer compilers
Thread-Topic: [PATCH] gcov: support GCC 12.1 and newer compilers
Thread-Index: AQHY4cE1cEgJvGaXh0+C5+heU0CnvK4SdXig
Date:   Mon, 17 Oct 2022 11:38:24 +0000
Message-ID: <9b724e2af2d048c3a7f7f20ae0942ab6@AcuMS.aculab.com>
References: <624bda92-f307-30e9-9aaa-8cc678b2dfb2@suse.cz>
        <581f6037-ff43-4f91-cabf-d9aa0d72bbe6@linux.ibm.com>
 <20221016174033.d33a998b4c91b7d18b3dc310@linux-foundation.org>
In-Reply-To: <20221016174033.d33a998b4c91b7d18b3dc310@linux-foundation.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5kcmV3IE1vcnRvbg0KPiBTZW50OiAxNyBPY3RvYmVyIDIwMjIgMDE6NDENCi4uDQo+
IFRoZSBjaGFuZ2Vsb2cgZG9lc24ndCB0ZWxsIHVzIHdoYXQgdGhlIHVzZXItdmlzaWJsZSBlZmZl
Y3RzIG9mIHRoaXMgYXJlDQo+IChwbGVhc2UsIGl0IHNob3VsZCBkbyBzbyksIGJ1dCBpdCBzb3Vu
ZHMgdG8gbWUgbGlrZSB0aG9zZSBlZmZlY3RzIGFyZQ0KPiAiZ2NvdiBpcyB1dHRlcmx5IGJ1c3Rl
ZCIuDQo+IA0KPiBTbyBJJ2xsIGFkZCBhIGNjOnN0YWJsZSB0byB0aGlzLCBzbyB0aGF0IHBlb3Bs
ZSBjYW4gdXNlIG5ldyBnY2MNCj4gdmVyc2lvbnMgdG8gYnVpbGQgb2xkZXIga2VybmVscy4NCg0K
SSBjYW4ndCBoZWxwIHdvbmRlcmluZyB3aGF0IGhhcHBlbnMgaWYgeW91IGxpbmsgYSBiaW5hcnkN
CmNvbXBpbGVkIHdpdGggYW4gb2xkIGdjYyB3aXRoIG9uZSBidWlsZCB3aXRoIGEgbmV3IGdjYz8N
Cg0KVGhpcyBjb3VsZCBlYXNpbHkgaGFwcGVuIHdpdGggb3V0IG9mIHRyZWUgbG9hZGFibGUgbW9k
dWxlcy4NCk9yIGp1c3QgbGlua2luZyBhbiBvbGQgLmEgZmlsZSBpbnRvIGEgdXNlcnNwYWNlIGJp
bmFyeS4NCg0KTm93IG1heWJlIHRoZSBnY292IGRhdGEgaXNuJ3QgdXNlZCAoSSd2ZSBub3QgbG9v
a2VkIHVwIHdoYXQNCml0IGlzIGZvcikgYnV0IGlzIHNvdW5kcyBsaWtlIHNvbWV0aGluZyB3aG9z
ZSBmb3JtYXQgc2hvdWxkDQpiZSBzZXQgaW4gc3RvbmU/DQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

