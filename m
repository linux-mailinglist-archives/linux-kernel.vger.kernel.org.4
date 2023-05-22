Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5826870BCEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjEVMHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjEVMHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:07:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EF6AA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:07:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-75-nEeo5WdKNgC3tzWX8ags8w-1; Mon, 22 May 2023 13:07:35 +0100
X-MC-Unique: nEeo5WdKNgC3tzWX8ags8w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 22 May
 2023 13:07:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 22 May 2023 13:07:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'15330273260@189.cn'" <15330273260@189.cn>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Li Yi <liyi@loongson.cn>
CC:     Thomas Zimmermann <tzimmermann@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "loongson-kernel@lists.loongnix.cn" 
        <loongson-kernel@lists.loongnix.cn>
Subject: RE: [PATCH] drm/drm_vblank.c: avoid unsigned int to signed int cast
Thread-Topic: [PATCH] drm/drm_vblank.c: avoid unsigned int to signed int cast
Thread-Index: AQHZiBwkXHI4wBkIl0yfSK4Xtptrs69eSnTggAfuD9GAAADacA==
Date:   Mon, 22 May 2023 12:07:23 +0000
Message-ID: <f25545e96bc1458eb5bffc1505255e68@AcuMS.aculab.com>
References: <20230516173026.2990705-1-15330273260@189.cn>
 <f6bd362145124f34a1af800dd330f8e9@AcuMS.aculab.com>
 <b23c41b1-e177-c81d-5327-fce5511cb97d@189.cn> <871qj8ob7z.fsf@intel.com>
 <7f81c053-ba60-a4d2-23d6-d0f032acbcff@189.cn>
In-Reply-To: <7f81c053-ba60-a4d2-23d6-d0f032acbcff@189.cn>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogMTUzMzAyNzMyNjBAMTg5LmNuIDwxNTMzMDI3MzI2MEAxODkuY24+DQo+IFNlbnQ6IDIy
IE1heSAyMDIzIDEyOjU2DQouLi4NCj4gPiBJJ2xsIGJldCBtb3N0IHBlb3BsZSB3aWxsIGJlIHN1
cnByaXNlZCB0byBzZWUgd2hhdCB0aGlzIHByaW50czoNCj4gPg0KPiA+ICNpbmNsdWRlIDxzdGRp
by5oPg0KPiA+ICNpbmNsdWRlIDxzdGRpbnQuaD4NCj4gPg0KPiA+IGludCBtYWluKHZvaWQpDQo+
ID4gew0KPiA+IAl1aW50MTZfdCB4ID0gMHhmZmZmOw0KPiA+IAl1aW50MTZfdCB5ID0gMHhmZmZm
Ow0KPiA+IAl1aW50NjRfdCB6ID0geCAqIHk7DQo+ID4NCj4gPiAJcHJpbnRmKCIweCUwMTZseFxu
Iiwgeik7DQo+ID4gCXByaW50ZigiJWxkXG4iLCB6KTsNCj4gDQo+IEhlcmUsIHBsZWFzZSByZXBs
YWNlIHRoZSAiJWxkXG4iIHdpdGggdGhlICIlbHVcbiIsIHRoZW4geW91IHdpbGwgc2VlIHRoZQ0K
PiBkaWZmZXJlbmNlLg0KPiANCj4geW91IGFyZSBjYXN0aW5nIHRoZSB2YXJpYWJsZSAneicgdG8g
c2lnbmVkIHZhbHVlLMKgICIlZCIgaXMgZm9yIHByaW50aW5nDQo+IHNpZ25lZCB2YWx1ZSwgYW5k
ICIldSIgaXMgZm9yIHByaW50aW5nIHVuc2lnbmVkIHZhbHVlLg0KDQpUaGF0IG1ha2VzIHZlcnkg
bGl0dGxlIGRpZmZlcmVuY2Ugb24gMidzIGNvbXBsaW1lbnQgc3lzdGVtcy4NClRoZXkgYm90aCBk
aXNwbGF5IHRoZSBjb250ZW50cyBvZiB0aGUgdmFyaWFibGUuDQoNCj4gWW91ciBzaW1wbGUgY29k
ZSBleHBsYWluZWQgZXhhY3RseSB3aHkgeW91IGFyZSBzdGlsbCBpbiBjb25mdXNpb24sDQo+IA0K
PiB0aGF0IGlzIHUxNiAqIHUxNsKgIGNhbiB5aWVsZCBhIG5lZ2F0aXZlIHZhbHVlIGlmIHlvdSB1
c2UgdGhlIGludCBhcyB0aGUNCj4gcmV0dXJuIHR5cGUuIEJlY2F1c2UgaXQgb3ZlcmZsb3dlZC4N
Cg0KVGhlcmUgaXMgbm8gJ3JldHVybiB0eXBlJywgdGhlIHR5cGUgb2YgJ3UxNiAqIHUxNicgaXMg
c2lnbmVkIGludC4NCldoZW4gJ3NpZ25lZCBpbnQnIGlzIHByb21vdGVkL2Nhc3QgdG8gdTY0IGl0
IGlzIGZpcnN0IHNpZ24gZXh0ZW5kZWQNCnRvIDY0IGJpdHMuDQoNCllvdSBjYW4gZ2V0IHdoYXQg
eW91IHdhbnQvZXhwZWN0IGJ5IGVpdGhlciBmb3JjaW5nIGFuIHVuc2lnbmVkIG11bHRpcGx5DQpv
ciBieSBleHBsaWNpdGx5IGNhc3RpbmcgdGhlIHJlc3VsdCBvZiB0aGUgbXVsdGlwbHkgdG8gdTMy
Lg0KU28gdGhlIHByb2R1Y3QgaW4gJ3ogPSAoeCArIDB1KSAqIHknIGlzICd1bnNpZ25lZCBpbnQn
IGl0IGdldHMNCnByb21vdGVkIHRvIGludDY0X3QgKGllIGEgc2lnbmVkIHR5cGUpIGFuZCB0aGVu
IGNvbnZlcnRlZCB0bw0KdW5zaWduZWQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

