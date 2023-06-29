Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99799742763
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjF2N2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjF2N2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:28:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01E530FA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:28:04 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-146-72SqaBN2NJKYGBr_JEE1Lg-1; Thu, 29 Jun 2023 14:28:02 +0100
X-MC-Unique: 72SqaBN2NJKYGBr_JEE1Lg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 14:28:00 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Jun 2023 14:28:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ping-Ke Shih' <pkshih@realtek.com>,
        You Kangren <youkangren@vivo.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:MAC80211" <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: =?utf-8?B?UkU6IFtQQVRDSF0gd2lmae+8mm1hYzgwMjExOiBSZXBsYWNlIHRoZSB0ZXJu?=
 =?utf-8?Q?ary_conditional_operator_with_max()?=
Thread-Topic: =?utf-8?B?W1BBVENIXSB3aWZp77yabWFjODAyMTE6IFJlcGxhY2UgdGhlIHRlcm5hcnkg?=
 =?utf-8?Q?conditional_operator_with_max()?=
Thread-Index: AQHZqBvNKITprNb9K06+yWJl2zb8J6+fcjiAgAJYBtA=
Date:   Thu, 29 Jun 2023 13:28:00 +0000
Message-ID: <9ea9d91e8ec94edda19bd57e835e0a79@AcuMS.aculab.com>
References: <20230626104829.1896-1-youkangren@vivo.com>
 <9e4e3bf85ed945e7b0c8d5d389065670@realtek.com>
In-Reply-To: <9e4e3bf85ed945e7b0c8d5d389065670@realtek.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGluZy1LZSBTaGloDQo+IFNlbnQ6IDI4IEp1bmUgMjAyMyAwMjo0OQ0KPiANCj4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFlvdSBLYW5ncmVuIDx5b3VrYW5n
cmVuQHZpdm8uY29tPg0KPiA+IFNlbnQ6IE1vbmRheSwgSnVuZSAyNiwgMjAyMyA2OjQ4IFBNDQo+
ID4gVG86IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+OyBEYXZpZCBT
LiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQNCj4gPiA8ZWR1bWF6
ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBB
YmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBvcGVuDQo+ID4gbGlzdDpNQUM4MDIxMSA8bGludXgt
d2lyZWxlc3NAdmdlci5rZXJuZWwub3JnPjsgb3BlbiBsaXN0Ok5FVFdPUktJTkcgW0dFTkVSQUxd
DQo+IDxuZXRkZXZAdmdlci5rZXJuZWwub3JnPjsNCj4gPiBvcGVuIGxpc3QgPGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4gQ2M6IG9wZW5zb3VyY2Uua2VybmVsQHZpdm8uY29tOyB5
b3VrYW5ncmVuQHZpdm8uY29tDQo+ID4gU3ViamVjdDogW1BBVENIXSB3aWZp77yabWFjODAyMTE6
IFJlcGxhY2UgdGhlIHRlcm5hcnkgY29uZGl0aW9uYWwgb3BlcmF0b3Igd2l0aCBtYXgoKQ0KPiAN
Cj4gVGhlIHNlbWljb2xvbiBvZiAid2lmae+8miIgaXMgZGlmZmVyZW50IGZyb20gb3RoZXJzLg0K
PiANCj4gPg0KPiA+IFJlcGxhY2UgdGhlIHRlcm5hcnkgY29uZGl0aW9uYWwgb3BlcmF0b3Igd2l0
aCBtYXgoKSB0byBtYWtlIHRoZSBjb2RlIGNsZWFuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZ
b3UgS2FuZ3JlbiA8eW91a2FuZ3JlbkB2aXZvLmNvbT4NCj4gPiAtLS0NCj4gPiAgbmV0L21hYzgw
MjExL3RkbHMuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L21hYzgwMjExL3RkbHMuYyBi
L25ldC9tYWM4MDIxMS90ZGxzLmMNCj4gPiBpbmRleCBhNGFmM2I3Njc1ZWYuLjlmOGIwODQyYTYx
NiAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvbWFjODAyMTEvdGRscy5jDQo+ID4gKysrIGIvbmV0L21h
YzgwMjExL3RkbHMuYw0KPiA+IEBAIC05NDYsNyArOTQ2LDcgQEAgaWVlZTgwMjExX3RkbHNfYnVp
bGRfbWdtdF9wYWNrZXRfZGF0YShzdHJ1Y3QgaWVlZTgwMjExX3N1Yl9pZl9kYXRhICpzZGF0YSwN
Cj4gPiAgICAgICAgIGludCByZXQ7DQo+ID4gICAgICAgICBzdHJ1Y3QgaWVlZTgwMjExX2xpbmtf
ZGF0YSAqbGluazsNCj4gPg0KPiA+IC0gICAgICAgbGlua19pZCA9IGxpbmtfaWQgPj0gMCA/IGxp
bmtfaWQgOiAwOw0KPiA+ICsgICAgICAgbGlua19pZCA9IG1heChsaW5rX2lkLCAwKTsNCj4gDQo+
IE9yaWdpbmFsIGxvZ2ljIG1lYW5zICJpZiBsaW5rX2lkIDwgMCwgdGhlbiB1c2UgZGVmYXVsdCBs
aW5rICgwKSIgaW5zdGVhZCBvZg0KPiAiYWx3YXlzIHVzZSBsaW5rX2lkIGxhcmdlciB0aGFuIG9y
IGVxdWFsIHRvIDAiLiBTbywgSSB0aGluayBtYXgobGlua19pZCwgMCkgY291bGQNCj4gY2F1c2Ug
bWlzdW5kZXJzdGFuZGluZy4NCg0KVGhlIGNsZWFyZXN0IGlzIHByb2JhYmx5Og0KCWlmIChsaW5r
X2lkIDwgMCkNCgkJbGlua19pZCA9IDA7DQoNClRoZSBjb21waWxlciBjb3VsZCBlYXNpbHkgZ2Vu
ZXJhdGUgdGhlIHNhbWUgY29kZSAoY29tcGFyZSBhbmQgY29uZGl0aW9uYWwNCm1vdmUpLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

