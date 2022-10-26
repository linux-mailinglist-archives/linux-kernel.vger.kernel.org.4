Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D204060DCE5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiJZIRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiJZIQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:16:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456AF8E446
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:16:57 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-52-4DcjjJ0EMoeug2VsJRIvhg-1; Wed, 26 Oct 2022 09:16:55 +0100
X-MC-Unique: 4DcjjJ0EMoeug2VsJRIvhg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Oct
 2022 09:16:53 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Wed, 26 Oct 2022 09:16:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jiri Slaby' <jirislaby@kernel.org>,
        =?utf-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: RE: [PATCH] block: fix Werror=format with GCC 13
Thread-Topic: [PATCH] block: fix Werror=format with GCC 13
Thread-Index: AQHY6Qsijfxi7q7dmk23Q8IZX/WJaK4gUbAA
Date:   Wed, 26 Oct 2022 08:16:53 +0000
Message-ID: <067786a28a034bbeb8518984ef32ee04@AcuMS.aculab.com>
References: <f70c7a11-e81e-f6b9-a403-315117f4aa3a@suse.cz>
 <bc107c62-25ab-f959-c5bc-d5bacc511f20@kernel.org>
In-Reply-To: <bc107c62-25ab-f959-c5bc-d5bacc511f20@kernel.org>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmlyaSBTbGFieQ0KPiBTZW50OiAyNiBPY3RvYmVyIDIwMjIgMDg6MTgNCj4gDQo+IE9u
IDI0LiAxMC4gMjIsIDIxOjAxLCBNYXJ0aW4gTGnFoWthIHdyb3RlOg0KPiA+IFN0YXJ0aW5nIHdp
dGggR0NDIDEzLCBzaW5jZQ0KPiA+IFtnM2IzMDgzYTU5OGNhM2Y0Yl0gYzogQzJ4IGVudW1zIHdp
ZGVyIHRoYW4gaW50IFtQUjM2MTEzXQ0KPiA+DQo+ID4gR0NDIHByb21vdGVzIGVudW0gdmFsdWVz
IHdpdGggbGFyZ2VyIHRoYW4gaW50ZWdlciB0eXBlcyB0byBhIHdpZGVyIHR5cGUuDQo+ID4gSW4g
Y2FzZSBvZiB0aGUgYW5vbnltb3VzIGVudW0gdHlwZSBpbiBibGstaW9jb3N0LmMgaXQgaXM6DQo+
ID4NCj4gPiBlbnVtIHsNCj4gPiAJTUlMTElPTgkJCT0gMTAwMDAwMCwNCj4gPiAuLi4NCj4gPg0K
PiA+IAlXRUlHSFRfT05FCQk9IDEgPDwgMTYsDQo+ID4gLi4uDQo+ID4gCVZUSU1FX1BFUl9TRUNf
U0hJRlQJPSAzNywNCj4gPiAJVlRJTUVfUEVSX1NFQwkJPSAxTExVIDw8IFZUSU1FX1BFUl9TRUNf
U0hJRlQsDQo+ID4gLi4uDQo+ID4NCj4gPiBhcyBzZWVuIFZUSU1FX1BFUl9TRUMgY2Fubm90IGZp
dCBpbnRvIDMyLWJpdHMgKGludCB0eXBlKSwgdGh1cyBvbmUgbmVlZHMNCj4gPiB0byB1c2UgJ2xv
bmcgdW5zaWduZWQgaW50JyBpbiB0aGUgZm9ybWF0IHN0cmluZy4NCj4gPg0KPiA+IEl0IGZpeGVz
IHRoZW4gdGhlIGZvbGxvd2luZyAyIHdhcm5pbmdzOg0KPiA+DQo+ID4gYmxvY2svYmxrLWlvY29z
dC5jOiBJbiBmdW5jdGlvbiDigJhpb2Nfd2VpZ2h0X3ByZmlsbOKAmToNCj4gPiBibG9jay9ibGst
aW9jb3N0LmM6MzAzNTozNzogZXJyb3I6IGZvcm1hdCDigJgldeKAmSBleHBlY3RzIGFyZ3VtZW50
IG9mIHR5cGUg4oCYdW5zaWduZWQgaW504oCZLCBidXQgYXJndW1lbnQNCj4gNCBoYXMgdHlwZSDi
gJhsb25nIHVuc2lnbmVkIGludOKAmSBbLVdlcnJvcj1mb3JtYXQ9XQ0KPiA+ICAgMzAzNSB8ICAg
ICAgICAgICAgICAgICBzZXFfcHJpbnRmKHNmLCAiJXMgJXVcbiIsIGRuYW1lLCBpb2NnLT5jZmdf
d2VpZ2h0IC8gV0VJR0hUX09ORSk7DQo+ID4gICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB+XiAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
DQo+ID4gICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgICAgICAgIGxvbmcgdW5z
aWduZWQgaW50DQo+ID4gICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAlbHUNCj4gPiBibG9jay9ibGstaW9jb3N0LmM6IEluIGZ1bmN0aW9uIOKAmGlvY193ZWlnaHRf
c2hvd+KAmToNCj4gPiBibG9jay9ibGstaW9jb3N0LmM6MzA0NTozNDogZXJyb3I6IGZvcm1hdCDi
gJgldeKAmSBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUg4oCYdW5zaWduZWQgaW504oCZLCBidXQg
YXJndW1lbnQNCj4gMyBoYXMgdHlwZSDigJhsb25nIHVuc2lnbmVkIGludOKAmSBbLVdlcnJvcj1m
b3JtYXQ9XQ0KPiA+ICAgMzA0NSB8ICAgICAgICAgc2VxX3ByaW50ZihzZiwgImRlZmF1bHQgJXVc
biIsIGlvY2MtPmRmbF93ZWlnaHQgLyBXRUlHSFRfT05FKTsNCj4gPiAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIH5eICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fg0KPiA+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgbG9uZyB1bnNpZ25lZCBpbnQNCj4gPiAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICVsdQ0KPiANCj4gQnV0IGlu
dHJvZHVjZXMgdHdvIHdpdGggZ2NjLTEyIDspOg0KPiAgPiBibG9jay9ibGstaW9jb3N0LmM6IElu
IGZ1bmN0aW9uIOKAmGlvY193ZWlnaHRfcHJmaWxs4oCZOg0KPiAgPiBibG9jay9ibGstaW9jb3N0
LmM6MzAzNzozODogZXJyb3I6IGZvcm1hdCDigJglbHXigJkgZXhwZWN0cyBhcmd1bWVudCBvZg0K
PiB0eXBlIOKAmGxvbmcgdW5zaWduZWQgaW504oCZLCBidXQgYXJndW1lbnQgNCBoYXMgdHlwZSDi
gJh1MzLigJkge2FrYSDigJh1bnNpZ25lZA0KPiBpbnTigJl9IFstV2Vycm9yPWZvcm1hdD1dDQo+
ICA+ICAzMDM3IHwgICAgICAgICAgICAgICAgIHNlcV9wcmludGYoc2YsICIlcyAlbHVcbiIsIGRu
YW1lLA0KPiBpb2NnLT5jZmdfd2VpZ2h0IC8gV0VJR0hUX09ORSk7DQo+ICA+ICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fl4NCj4gfn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4NCj4gID4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfA0KPiAgICAgICB8DQo+ICA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGxvbmcgdW5zaWduZWQgaW50DQo+ICAgICAgIHUzMiB7YWthIHVuc2lnbmVk
IGludH0NCj4gID4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICV1
DQo+IA0KPiANCj4gTm90ZSB0aGF0Og0KPiAxKSB0aGUgc3BlY3Mgc2F5cyBlbnVtIGJlaGF2ZXMg
YXMgaW50LCBvciB1aW50IGluIHNvbWUgY2FzZXMNCj4gMikgaW9jYy0+ZGZsX3dlaWdodCBpcyB1
MzIsIGkuZS4gdWludA0KPiAgICAgV0VJR0hUX09ORSBpcyAxIDw8IDE2LCBpLmUuIGludA0KPiAg
ICAgc28gdGhlIHByb21vdGlvbiBzaG91bGQgYmUgdG8gczMyL2ludC4gT3Igbm90Pw0KPiANCj4g
SSB0aGluayBnY2MtMTMgaXMgd3JvbmcgLS0gaW5jb3Npc3RlbnQgd2l0aCBnY2MtMTIgYXQgbGVh
c3QuDQoNClRoZSBwcmVzZW5jZSBvZiBWVElNRV9QRVJfU0VDIGluIHRoZSBlbnVtIGZvcmNlcyB0
aGUgZW51bQ0KdG8gNjRiaXRzICh0aGlzIG11c3QgYmUgYSBnY2MgZXh0ZW5zaW9uKS4NCg0KVGhl
IGNoYW5nZSBpbiBnY2MgMTMgc2VlbXMgdG8gYmUgdGhhdCB0aGUgdHlwZXMgb2YgYWxsIHRoZQ0K
ZW51bSB2YWx1ZXMgYXJlIG5vdyAocHJvYmFibHkgY29ycmVjdGx5KSB0aGF0IG9mIHRoZSBlbnVt
Lg0KDQpTbyBXRUlHSFRfT05FIGNoYW5nZXMgZnJvbSAndW5zaWduZWQgaW50JyB0byAndW5zaWdu
ZWQgbG9uZycuDQoNClNlZTogaHR0cHM6Ly9nb2Rib2x0Lm9yZy96LzZLNFBvSzlzdg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

