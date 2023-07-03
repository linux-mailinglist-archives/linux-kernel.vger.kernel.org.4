Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA769745726
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjGCITY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjGCITR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:19:17 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00734E49;
        Mon,  3 Jul 2023 01:19:11 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3638IVLG0009537, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3638IVLG0009537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 3 Jul 2023 16:18:31 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 3 Jul 2023 16:18:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 3 Jul 2023 16:18:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 3 Jul 2023 16:18:33 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     David Laight <David.Laight@ACULAB.COM>,
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
Subject: =?utf-8?B?UkU6IFtQQVRDSF0gd2lmae+8mm1hYzgwMjExOiBSZXBsYWNlIHRoZSB0ZXJu?= =?utf-8?Q?ary_conditional_operator_with_max()?=
Thread-Topic: =?utf-8?B?W1BBVENIXSB3aWZp77yabWFjODAyMTE6IFJlcGxhY2UgdGhlIHRlcm5hcnkg?=
 =?utf-8?Q?conditional_operator_with_max()?=
Thread-Index: AQHZqBvNKITprNb9K06+yWJl2zb8J6+fcjiAgAJYBtCABfI/oA==
Date:   Mon, 3 Jul 2023 08:18:33 +0000
Message-ID: <cb6cc27d71144bef9b7827f541fbeb43@realtek.com>
References: <20230626104829.1896-1-youkangren@vivo.com>
 <9e4e3bf85ed945e7b0c8d5d389065670@realtek.com>
 <9ea9d91e8ec94edda19bd57e835e0a79@AcuMS.aculab.com>
In-Reply-To: <9ea9d91e8ec94edda19bd57e835e0a79@AcuMS.aculab.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGFpZ2h0IDxE
YXZpZC5MYWlnaHRAQUNVTEFCLkNPTT4NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMjksIDIwMjMg
OToyOCBQTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBZb3UgS2Fu
Z3JlbiA8eW91a2FuZ3JlbkB2aXZvLmNvbT47IEpvaGFubmVzIEJlcmcNCj4gPGpvaGFubmVzQHNp
cHNvbHV0aW9ucy5uZXQ+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBF
cmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+Ow0KPiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgb3BlbiBsaXN0
Ok1BQzgwMjExDQo+IDxsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxpc3Q6
TkVUV09SS0lORyBbR0VORVJBTF0gPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxpc3QN
Cj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IENjOiBvcGVuc291cmNlLmtlcm5l
bEB2aXZvLmNvbQ0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSB3aWZp77yabWFjODAyMTE6IFJlcGxh
Y2UgdGhlIHRlcm5hcnkgY29uZGl0aW9uYWwgb3BlcmF0b3Igd2l0aCBtYXgoKQ0KPiANCj4gRnJv
bTogUGluZy1LZSBTaGloDQo+ID4gU2VudDogMjggSnVuZSAyMDIzIDAyOjQ5DQo+ID4NCj4gPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBZb3UgS2FuZ3JlbiA8eW91
a2FuZ3JlbkB2aXZvLmNvbT4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgSnVuZSAyNiwgMjAyMyA2OjQ4
IFBNDQo+ID4gPiBUbzogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD47
IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldA0KPiA+
ID4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3Jn
PjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgb3Blbg0KPiA+ID4gbGlzdDpNQUM4
MDIxMSA8bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnPjsgb3BlbiBsaXN0Ok5FVFdPUktJ
TkcgW0dFTkVSQUxdDQo+ID4gPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiA+ID4gb3BlbiBs
aXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiA+ID4gQ2M6IG9wZW5zb3VyY2Uu
a2VybmVsQHZpdm8uY29tOyB5b3VrYW5ncmVuQHZpdm8uY29tDQo+ID4gPiBTdWJqZWN0OiBbUEFU
Q0hdIHdpZmnvvJptYWM4MDIxMTogUmVwbGFjZSB0aGUgdGVybmFyeSBjb25kaXRpb25hbCBvcGVy
YXRvciB3aXRoIG1heCgpDQo+ID4NCj4gPiBUaGUgc2VtaWNvbG9uIG9mICJ3aWZp77yaIiBpcyBk
aWZmZXJlbnQgZnJvbSBvdGhlcnMuDQo+ID4NCj4gPiA+DQo+ID4gPiBSZXBsYWNlIHRoZSB0ZXJu
YXJ5IGNvbmRpdGlvbmFsIG9wZXJhdG9yIHdpdGggbWF4KCkgdG8gbWFrZSB0aGUgY29kZSBjbGVh
bg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvdSBLYW5ncmVuIDx5b3VrYW5ncmVuQHZp
dm8uY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgbmV0L21hYzgwMjExL3RkbHMuYyB8IDIgKy0NCj4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvbmV0L21hYzgwMjExL3RkbHMuYyBiL25ldC9tYWM4MDIxMS90
ZGxzLmMNCj4gPiA+IGluZGV4IGE0YWYzYjc2NzVlZi4uOWY4YjA4NDJhNjE2IDEwMDY0NA0KPiA+
ID4gLS0tIGEvbmV0L21hYzgwMjExL3RkbHMuYw0KPiA+ID4gKysrIGIvbmV0L21hYzgwMjExL3Rk
bHMuYw0KPiA+ID4gQEAgLTk0Niw3ICs5NDYsNyBAQCBpZWVlODAyMTFfdGRsc19idWlsZF9tZ210
X3BhY2tldF9kYXRhKHN0cnVjdCBpZWVlODAyMTFfc3ViX2lmX2RhdGEgKnNkYXRhLA0KPiA+ID4g
ICAgICAgICBpbnQgcmV0Ow0KPiA+ID4gICAgICAgICBzdHJ1Y3QgaWVlZTgwMjExX2xpbmtfZGF0
YSAqbGluazsNCj4gPiA+DQo+ID4gPiAtICAgICAgIGxpbmtfaWQgPSBsaW5rX2lkID49IDAgPyBs
aW5rX2lkIDogMDsNCj4gPiA+ICsgICAgICAgbGlua19pZCA9IG1heChsaW5rX2lkLCAwKTsNCj4g
Pg0KPiA+IE9yaWdpbmFsIGxvZ2ljIG1lYW5zICJpZiBsaW5rX2lkIDwgMCwgdGhlbiB1c2UgZGVm
YXVsdCBsaW5rICgwKSIgaW5zdGVhZCBvZg0KPiA+ICJhbHdheXMgdXNlIGxpbmtfaWQgbGFyZ2Vy
IHRoYW4gb3IgZXF1YWwgdG8gMCIuIFNvLCBJIHRoaW5rIG1heChsaW5rX2lkLCAwKSBjb3VsZA0K
PiA+IGNhdXNlIG1pc3VuZGVyc3RhbmRpbmcuDQo+IA0KPiBUaGUgY2xlYXJlc3QgaXMgcHJvYmFi
bHk6DQo+ICAgICAgICAgaWYgKGxpbmtfaWQgPCAwKQ0KPiAgICAgICAgICAgICAgICAgbGlua19p
ZCA9IDA7DQo+IA0KPiBUaGUgY29tcGlsZXIgY291bGQgZWFzaWx5IGdlbmVyYXRlIHRoZSBzYW1l
IGNvZGUgKGNvbXBhcmUgYW5kIGNvbmRpdGlvbmFsDQo+IG1vdmUpLg0KPiANCg0KVGhleSB3b3Vs
ZCBiZSB0aGUgc2FtZSwgYnV0IHBlcnNvbmFsbHkgSSBwcmVmZXIgb3JpZ2luYWwgc2luZ2xlIG9u
ZSBsaW5lIHN0YXRlbWVudA0KdGhhdCBpcyBjbGVhciB0byBtZS4NCg0KDQo=
