Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678CB6D8CE3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbjDFBnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjDFBnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:43:19 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EB590;
        Wed,  5 Apr 2023 18:43:17 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 3361gKFI051470;
        Thu, 6 Apr 2023 09:42:20 +0800 (+08)
        (envelope-from Ziwei.Dai@unisoc.com)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 6 Apr 2023
 09:42:16 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.023; Thu, 6 Apr 2023 09:42:16 +0800
From:   =?utf-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?= <Ziwei.Dai@unisoc.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>,
        =?utf-8?B?546L5Y+MIChTaHVhbmcgV2FuZyk=?= <shuang.wang@unisoc.com>
Subject: =?utf-8?B?562U5aSNOiBsaW51eC1uZXh0OiBGaXhlcyB0YWcgbmVlZHMgc29tZSB3b3Jr?=
 =?utf-8?Q?_in_the_rcu_tree?=
Thread-Topic: linux-next: Fixes tag needs some work in the rcu tree
Thread-Index: AQHZaA8UKrRv8G6pjEWRwCfyXlZs868czk0AgACzgcA=
Date:   Thu, 6 Apr 2023 01:42:15 +0000
Message-ID: <82b6b670854f4366a4c02543f56be6b7@BJMBX01.spreadtrum.com>
References: <20230406083619.65dee33a@canb.auug.org.au>
 <66b7fceb-0a9d-42c1-987f-1ac6c857d987@paulmck-laptop>
In-Reply-To: <66b7fceb-0a9d-42c1-987f-1ac6c857d987@paulmck-laptop>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.93.65]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com 3361gKFI051470
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFBhdWwgRS4gTWNLZW5u
ZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIz5bm0NOaciDbml6Ug
Njo1OQ0KPiDmlLbku7bkuro6IFN0ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5iLmF1dWcub3JnLmF1
Pg0KPiDmioTpgIE6IOS7o+WtkOS4uiAoWml3ZWkgRGFpKSA8Wml3ZWkuRGFpQHVuaXNvYy5jb20+
OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
PjsgTGludXggTmV4dCBNYWlsaW5nIExpc3QNCj4gPGxpbnV4LW5leHRAdmdlci5rZXJuZWwub3Jn
Pg0KPiDkuLvpopg6IFJlOiBsaW51eC1uZXh0OiBGaXhlcyB0YWcgbmVlZHMgc29tZSB3b3JrIGlu
IHRoZSByY3UgdHJlZQ0KPiANCj4gDQo+IOazqOaEjzog6L+Z5bCB6YKu5Lu25p2l6Ieq5LqO5aSW
6YOo44CC6Zmk6Z2e5L2g56Gu5a6a6YKu5Lu25YaF5a655a6J5YWo77yM5ZCm5YiZ5LiN6KaB54K5
5Ye75Lu75L2V6ZO+5o6l5ZKM6ZmE5Lu244CCDQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2lu
YXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlDQo+IHNlbmRlciBh
bmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IA0KPiBPbiBUaHUsIEFwciAw
NiwgMjAyMyBhdCAwODozNjoxOUFNICsxMDAwLCBTdGVwaGVuIFJvdGh3ZWxsIHdyb3RlOg0KPiA+
IEhpIGFsbCwNCj4gPg0KPiA+IEluIGNvbW1pdA0KPiA+DQo+ID4gICBhY2RjNzk5MTdkNjUgKCJy
Y3Uva3ZmcmVlOiBBdm9pZCBmcmVlaW5nIG5ldyBrZnJlZV9yY3UoKSBtZW1vcnkNCj4gPiBhZnRl
ciBvbGQgZ3JhY2UgcGVyaW9kIikNCj4gPg0KPiA+IEZpeGVzIHRhZw0KPiA+DQo+ID4gICBGaXhl
czogMDM5MmJlYmViZjI2ICgicmN1L2t2ZnJlZTogQXZvaWQgZnJlZWluZyBuZXcga2ZyZWVfcmN1
KCkNCj4gPiBtZW1vcnkgYWZ0ZXIgb2xkIGdyYWNlIHBlcmlvZCIpDQo+ID4NCj4gPiBoYXMgdGhl
c2UgcHJvYmxlbShzKToNCj4gPg0KPiA+ICAgLSBTdWJqZWN0IGRvZXMgbm90IG1hdGNoIHRhcmdl
dCBjb21taXQgc3ViamVjdA0KPiA+ICAgICBKdXN0IHVzZQ0KPiA+ICAgICAgIGdpdCBsb2cgLTEg
LS1mb3JtYXQ9J0ZpeGVzOiAlaCAoIiVzIiknDQo+ID4NCj4gPiBNYXliZSB5b3UgbWVhbnQ6DQo+
ID4NCj4gPiBGaXhlczogMDM5MmJlYmViZjI2ICgicmN1OiBBZGQgbXVsdGlwbGUgaW4tZmxpZ2h0
IGJhdGNoZXMgb2YNCj4gPiBrZnJlZV9yY3UoKSB3b3JrIikNCj4gDQo+IEhlbGxvLCBTdGVwaGVu
LA0KPiANCj4gVGhlcmUgaXMgY3VycmVudGx5IHNvbWUgZGViYXRlIGFzIHRvIGV4YWN0bHkgd2hp
Y2ggY29tbWl0KHMpIGludHJvZHVjZWQgdGhlIGJ1Zywgd2hpY2ggd2lsbCBob3BlZnVsbHkgY29t
ZSB0byBhIGNvbmNsdXNpb24gYmVmb3JlDQo+IHRvbW9ycm93J3MgLW5leHQuICBJZiB0aGV5IGRv
IG5vdCwgSSB3aWxsIHVzZSB5b3VyIGNvcnJlY3Rpb24gYXMgYSBwbGFjZWhvbGRlci4NCj4gDQo+
IEp1c3QgZm9yIGNvbXBsZXRlbmVzcywgdGhlIGN1cnJlbnQgb3RoZXIgdHdvIGNhbmRpZGF0ZXMg
KHdoaWNoIGFwcGVhciBxdWl0ZSBwbGF1c2libGUgdG8gbWUpIGFyZSB0aGVzZToNCj4gDQo+IEZp
eGVzOiAzNGM4ODE3NDU1NDkgKCJyY3U6IFN1cHBvcnQga2ZyZWVfYnVsaygpIGludGVyZmFjZSBp
biBrZnJlZV9yY3UoKSIpDQo+IEZpeGVzOiA1ZjNjOGQ2MjA0NDcgKCJyY3UvdHJlZTogTWFpbnRh
aW4gc2VwYXJhdGUgYXJyYXkgZm9yIHZtYWxsb2MgcHRycyIpDQo+IA0KPiBaaXdlaSBEYWksIHdo
YXQgYXJlIHlvdXIgdGhvdWdodHMgb24gdGhpcz8gIFRoaXMgaXMgZnJvbSBhIG1haW5saW5lIHBl
cnNwZWN0aXZlLCBteSBndWVzcyBiZWluZyB0aGF0IHlvdXIgaW52ZXN0aWdhdGlvbiBpbnZvbHZl
ZCBzb21lDQo+IG90aGVyIExpbnV4LWtlcm5lbCB0cmVlLg0KPiANCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUaGFueCwgUGF1bA0KDQpI
aSBQYXVsLCByaWdodCwgcGxlYXNlIGhlbHAgY29ycmVjdCBpdC4NCg0K
