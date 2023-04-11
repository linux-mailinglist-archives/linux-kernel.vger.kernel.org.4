Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9DA6DD7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDKKQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjDKKQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:16:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5E2BB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:16:45 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-202-bowHtzPvNE6BHyZ3kkHlFw-1; Tue, 11 Apr 2023 11:16:43 +0100
X-MC-Unique: bowHtzPvNE6BHyZ3kkHlFw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 11 Apr
 2023 11:16:42 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 11 Apr 2023 11:16:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peng Zhang' <zhangpeng.00@bytedance.com>,
        Gang Li <ligang.bdlg@bytedance.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        David Binderman <dcb314@hotmail.com>
Subject: RE: [PATCH] maple_tree: Use correct variable type in sizeof
Thread-Topic: [PATCH] maple_tree: Use correct variable type in sizeof
Thread-Index: AQHZa5SNBUM02W5oJk2/4C7Y9C/9d68l5c/A
Date:   Tue, 11 Apr 2023 10:16:41 +0000
Message-ID: <4211c1ee2b854711b9ff03ddd8e82905@AcuMS.aculab.com>
References: <20230410091431.74961-1-zhangpeng.00@bytedance.com>
 <8b5af22d-1612-a2a0-02da-728f1fd57bf1@bytedance.com>
 <b1ea2c08-8e88-e04f-417b-4cf0daa417b1@bytedance.com>
In-Reply-To: <b1ea2c08-8e88-e04f-417b-4cf0daa417b1@bytedance.com>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGVuZyBaaGFuZw0KPiBTZW50OiAxMCBBcHJpbCAyMDIzIDExOjA5DQo+IA0KPiDlnKgg
MjAyMy80LzEwIDE3OjQ2LCBHYW5nIExpIOWGmemBkzoNCj4gPiBPbiAyMDIzLzQvMTAgMTc6MTQs
IFBlbmcgWmhhbmcgd3JvdGU6DQo+ID4+IFRoZSBvcmlnaW5hbCBjb2RlIGlzOg0KPiA+PiDCoMKg
wqDCoG1lbXNldChwaXZzICsgdG1wLCAwLCBzaXplb2YodW5zaWduZWQgbG9uZyAqKSAqIChtYXhf
cCAtIHRtcCkpOw0KPiA+Pg0KPiA+PiBUaGUgdHlwZSBvZiB2YXJpYWJsZSBwb2ludGVkIHRvIGJ5
IHBpdnMgaXMgdW5zaWduZWQgbG9uZywgYnV0IHRoZSB0eXBlDQo+ID4+IHVzZWQgaW4gc2l6ZW9m
IGlzIGEgcG9pbnRlciB0eXBlLiBDaGFuZ2UgaXQgdG8gdW5zaWduZWQgbG9uZy4NCj4gPj4NCj4g
Pg0KPiA+IE1heWJlIGFkZCBhIGZpeCB0YWc/DQo+ID4NCj4gPiBGaXhlczogNTRhNjExYjYwNTkw
ICgiTWFwbGUgVHJlZTogYWRkIG5ldyBkYXRhIHN0cnVjdHVyZSIpDQo+IA0KPiBNYXliZSBzaXpl
b2Yodm9pZCAqKSBpcyBlcXVhbCB0byBzaXplb2YodW5zaWduZWQgbG9uZykNCj4gaW4gbW9zdCBh
cmNoaXRlY3R1cmVzLCBzbyBJIGRvbid0IGtub3cgaWYgaXQgY291bnRzIGFzIGEgZml4Lg0KDQpN
aWdodCBiZSB3b3J0aCBhZGRpbmc7ICJGb3J0dW5hdGVseSB0aGUgc2l6ZXMgYXJlIHRoZSBzYW1l
LiINCg0KPiA+PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHRtcCA8IG1heF9wKQ0KPiA+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZW1zZXQocGl2cyArIHRtcCwgMCwNCj4gPj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2YodW5zaWduZWQgbG9uZyAq
KSAqIChtYXhfcCAtIHRtcCkpOw0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNpemVvZih1bnNpZ25lZCBsb25nKSAqIChtYXhfcCAtIHRtcCkpOw0KCXNpemVvZiAo
KnBpdnMpDQoNCj4gPj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh0bXAgPCBtdF9zbG90c1tt
dF0pDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbXNldChzbG90cyArIHRtcCwg
MCwgc2l6ZW9mKHZvaWQgKikgKiAobWF4X3MgLSB0bXApKTsNCglhbmQgc2l6ZW9mICgqc2xvdHMp
DQoNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

