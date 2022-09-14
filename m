Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2D35B829C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiINIF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiINIFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:05:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBC436DD5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:05:18 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-310-cVSRc361N3OiNWkHinkhfg-1; Wed, 14 Sep 2022 09:05:14 +0100
X-MC-Unique: cVSRc361N3OiNWkHinkhfg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 14 Sep
 2022 09:05:13 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 14 Sep 2022 09:05:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: procfs readlink after unshare() in a chroot() reports the full
 path
Thread-Topic: procfs readlink after unshare() in a chroot() reports the full
 path
Thread-Index: AdjEMqjMb0GR/+CiSFubzc4Cg1EybADZcK0AAB3dyJA=
Date:   Wed, 14 Sep 2022 08:05:13 +0000
Message-ID: <09a2de005bf84ebcb9def00234ea3950@AcuMS.aculab.com>
References: <12add75b103b412494487518c408fe0b@AcuMS.aculab.com>
 <YyDPdr7v/ltQI+wc@localhost.localdomain>
In-Reply-To: <YyDPdr7v/ltQI+wc@localhost.localdomain>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDEzIFNlcHRlbWJlciAyMDIyIDE5OjQ0DQo+
IA0KPiBPbiBGcmksIFNlcCAwOSwgMjAyMiBhdCAxMDowNjozMkFNICswMDAwLCBEYXZpZCBMYWln
aHQgd3JvdGU6DQo+ID4gVGhlIHJlYWRsaW5rIGNhbGxzIGluIHByb2NmcyAoZWcgZm9yIC9wcm9j
L3NlbGYvZmQvMCkgcmV0dXJucw0KPiA+IHRoZSBmdWxsIHBhdGhuYW1lIGlmIHVuc2hhcmUoKSBp
cyBjYWxsZWQgaW5zaWRlIGEgY2hyb290Lg0KPiA+DQo+ID4gVGhlIHByb2dyYW0gYmVsb3cgcmVw
cm9kdWNlcyB0aGlzIHdoZW4gcnVuIHdpdGggc3RkaW4NCj4gPiByZWRpcmVjdGVkIHRvIGEgZmls
ZSBpbiB0aGUgY3VycmVudCBkaXJlY3RvcnkuDQo+ID4NCj4gPiBUaGlzIHNlcXVlbmNlIGlzIHVz
ZWQgYnkgJ2lwIG5ldG5zIGV4ZWMnIHNvIGlzbid0IGFjdHVhbGx5DQo+ID4gdGhhdCB1bnVzdWFs
Lg0KPiA+DQo+ID4gCURhdmlkDQo+ID4NCj4gPiAjZGVmaW5lIF9HTlVfU09VUkNFDQo+ID4gI2lu
Y2x1ZGUgPHVuaXN0ZC5oPg0KPiA+ICNpbmNsdWRlIDxzdGRpby5oPg0KPiA+ICNpbmNsdWRlIDxm
Y250bC5oPg0KPiA+ICNpbmNsdWRlIDxzY2hlZC5oPg0KPiA+DQo+ID4gc3RhdGljIHZvaWQgcHJp
bnRfbGluayhjb25zdCBjaGFyICp3aGVyZSwgaW50IGZkKQ0KPiA+IHsNCj4gPiAgICAgICAgIGNo
YXIgYnVmWzI1Nl07DQo+ID4NCj4gPiAgICAgICAgIHByaW50ZigiJXM6ICUuKnNcbiIsIHdoZXJl
LCAoaW50KXJlYWRsaW5rYXQoZmQsICIiLCBidWYsIHNpemVvZiBidWYpLCBidWYpOw0KPiA+IH0N
Cj4gPg0KPiA+IGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCj4gPiB7DQo+ID4gICAg
ICAgICBpbnQgbGlua19mZCA9IG9wZW4oIi9wcm9jL3NlbGYvZmQvMCIsIE9fUEFUSCB8IE9fTk9G
T0xMT1cpOw0KPiA+DQo+ID4gICAgICAgICBwcmludF9saW5rKCJpbml0aWFsIiwgbGlua19mZCk7
DQo+ID4gICAgICAgICBpZiAoY2hyb290KCIuIikpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVy
biAxOw0KPiA+ICAgICAgICAgcHJpbnRfbGluaygiYWZ0ZXIgY2hyb290IiwgbGlua19mZCk7DQo+
ID4gICAgICAgICBpZiAodW5zaGFyZShDTE9ORV9ORVdOUykpDQo+ID4gICAgICAgICAgICAgICAg
IHJldHVybiAyOw0KPiA+ICAgICAgICAgcHJpbnRfbGluaygiYWZ0ZXIgdW5zaGFyZSIsIGxpbmtf
ZmQpOw0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gfQ0KPiANCj4gSSB0ZXN0ZWQgbWFpbmxp
bmUgYW5kIDUuMTkuOCwgYm90aCBhcmUgT0s6DQo+IA0KPiBvcGVuKCIvcHJvYy9zZWxmL2ZkLzAi
LCBPX1JET05MWXxPX05PRk9MTE9XfE9fUEFUSCkgPSAzDQo+IHJlYWRsaW5rYXQoMywgIiIsICIv
ZGV2L3B0cy8wIiwgMjU2KSAgICA9IDEwDQo+IGZzdGF0KDEsIHtzdF9tb2RlPVNfSUZDSFJ8MDYy
MCwgc3RfcmRldj1tYWtlZGV2KDEzNiwgMCksIC4uLn0pID0gMA0KPiBtbWFwKE5VTEwsIDQwOTYs
IFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCkg
PSAweDdmZDk0NzUzZTAwMA0KPiB3cml0ZSgxLCAiaW5pdGlhbDogL2Rldi9wdHMvMFxuIiwgMjBp
bml0aWFsOiAvZGV2L3B0cy8wDQo+ICkgICA9IDIwDQo+IGNocm9vdCgiLiIpICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA9IDANCj4gcmVhZGxpbmthdCgzLCAiIiwgIi9kZXYvcHRzLzAiLCAy
NTYpICAgID0gMTANCj4gd3JpdGUoMSwgImFmdGVyIGNocm9vdDogL2Rldi9wdHMvMFxuIiwgMjVh
ZnRlciBjaHJvb3Q6IC9kZXYvcHRzLzANCj4gKSA9IDI1DQo+IHVuc2hhcmUoQ0xPTkVfTkVXTlMp
ICAgICAgICAgICAgICAgICAgICA9IDANCj4gcmVhZGxpbmthdCgzLCAiIiwgIi9kZXYvcHRzLzAi
LCAyNTYpICAgID0gMTANCj4gd3JpdGUoMSwgImFmdGVyIHVuc2hhcmU6IC9kZXYvcHRzLzBcbiIs
IDI2YWZ0ZXIgdW5zaGFyZTogL2Rldi9wdHMvMA0KPiApID0gMjYNCg0KWW91IG5lZWQgdGhlIHBh
dGggdG8gYmUgaW5zaWRlIHRoZSBjaHJvb3QuDQpJbiBzb21lIHNlbnNlICIvZGV2L3B0cy8wIiBp
cyBhY3R1YWxseSBpbnZhbGlkIGFuZCBwcm9iYWJseQ0Kb3VnaHQgdG8gYmUgdGFnZ2VkIGFzIHN1
Y2ggb3IgYW4gZXJyb3IgcmV0dXJuZWQuDQpTbyByZXJ1biBhbmQgcmVkaXJlY3Qgc3RkaW4gdG8g
YSBmaWxlIGluc2lkZSB0aGUgY2hyb290Lg0KDQpJbiBteSBvcmlnaW5hbCBjYXNlIGV2ZXJ5dGhp
bmcgd2FzIGluc2lkZSBhIGNocm9vdC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

