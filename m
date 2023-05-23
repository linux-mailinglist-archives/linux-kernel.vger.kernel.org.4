Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8E670D7DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjEWIu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjEWIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:50:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4590DFD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:50:50 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-194-4-IWd40DMtWa4Ek3F1Cvjg-1; Tue, 23 May 2023 09:50:32 +0100
X-MC-Unique: 4-IWd40DMtWa4Ek3F1Cvjg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 23 May
 2023 09:50:30 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 23 May 2023 09:50:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'15330273260@189.cn'" <15330273260@189.cn>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>
CC:     Thomas Zimmermann <tzimmermann@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "loongson-kernel@lists.loongnix.cn" 
        <loongson-kernel@lists.loongnix.cn>
Subject: RE: [PATCH] drm/drm_vblank.c: avoid unsigned int to signed int cast
Thread-Topic: [PATCH] drm/drm_vblank.c: avoid unsigned int to signed int cast
Thread-Index: AQHZiBwkXHI4wBkIl0yfSK4Xtptrs69eSnTggAkC21SAAEjo0A==
Date:   Tue, 23 May 2023 08:50:30 +0000
Message-ID: <e5effc4568034489acf2f4d4dad6eba9@AcuMS.aculab.com>
References: <20230516173026.2990705-1-15330273260@189.cn>
 <f6bd362145124f34a1af800dd330f8e9@AcuMS.aculab.com>
 <b23c41b1-e177-c81d-5327-fce5511cb97d@189.cn> <871qj8ob7z.fsf@intel.com>
 <4c9c0897-5e3a-1469-3d87-ff7723ac160c@189.cn>
In-Reply-To: <4c9c0897-5e3a-1469-3d87-ff7723ac160c@189.cn>
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

RnJvbTogMTUzMzAyNzMyNjBAMTg5LmNuIDwxNTMzMDI3MzI2MEAxODkuY24+DQo+IFNlbnQ6IDIz
IE1heSAyMDIzIDA1OjI3DQo+IA0KPiBPbiAyMDIzLzUvMjIgMTk6MjksIEphbmkgTmlrdWxhIHdy
b3RlOg0KPiA+IEluIGdlbmVyYWwsIGRvIG5vdCB1c2UgdW5zaWduZWQgdHlwZXMgaW4gYXJpdGht
ZXRoaWMgdG8gYXZvaWQgbmVnYXRpdmUNCj4gPiB2YWx1ZXMsIGJlY2F1c2UgbW9zdCBwZW9wbGUg
d2lsbCBiZSB0cmlwcGVkIG92ZXIgYnkgaW50ZWdlciBwcm9tb3Rpb24NCj4gPiBydWxlcywgYW5k
IHlvdSdsbCBnZXQgbmVnYXRpdmUgdmFsdWVzIGFueXdheS4NCj4gDQo+IA0KPiBIZXJlIEknbSBz
dXJlIGFib3V0IHRoaXMsDQo+IA0KPiBidXQgdGhlcmUgYXJlIHBsZW50eSB1bnNpZ25lZCB0eXBl
cyBhcml0aG1ldGljIGluIHRoZSBrZXJuZWwuDQoNClRoZSByZWFsIHByb2JsZW0gaXMgKGF0dGVt
cHRlZCkgYXJpdGhtZXRpYyBvbiB0eXBlcyBzbWFsbGVyIHRoYW4gaW50Lg0KUmVnYXJkbGVzcyBv
ZiB3aGV0aGVyIHRoZXkgYXJlIHNpZ25lZCBvciB1bnNpZ25lZC4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

