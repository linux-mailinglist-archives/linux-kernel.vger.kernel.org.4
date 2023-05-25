Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4661E710F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241419AbjEYPEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241117AbjEYPEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:04:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF9418D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:04:37 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-321-J5A-6mfhO5ePYqBmULgX2g-1; Thu, 25 May 2023 16:04:34 +0100
X-MC-Unique: J5A-6mfhO5ePYqBmULgX2g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 25 May
 2023 16:04:33 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 25 May 2023 16:04:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kenny Ho' <y2kenny@gmail.com>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Marc Dionne <marc.dionne@auristor.com>,
        Kenny Ho <Kenny.Ho@amd.com>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Remove hardcoded static string length
Thread-Topic: [PATCH] Remove hardcoded static string length
Thread-Index: AQHZjmnJx5LdtvUc0U+gvus5miHTlK9qs1lwgABJPoCAABjC4A==
Date:   Thu, 25 May 2023 15:04:33 +0000
Message-ID: <81d01562a59a4fb49cd4681ebcf2e74a@AcuMS.aculab.com>
References: <20230523223944.691076-1-Kenny.Ho@amd.com>
 <01936d68-85d3-4d20-9beb-27ff9f62d826@lunn.ch>
 <CAB9dFdt4-cBFhEqsTXk9suE+Bw-xcpM0n3Q6rFmBaa+8A5uMWQ@mail.gmail.com>
 <c0fda91b-1e98-420f-a18a-16bbed25e98d@lunn.ch>
 <CAOWid-erNGD24Ouf4fAJJBqm69QVoHOpNt0E-G+Wt=nq1W4oBQ@mail.gmail.com>
 <5b1355b8-17f7-49c8-b7b5-3d9ecdb146ce@lunn.ch>
 <CAOWid-dYtkcKuNxoOyf3yqSJ7OtcNjaqJLVX1QhRUhYSOO6vHA@mail.gmail.com>
 <30d65ea9170d4f60bd76ed516541cb46@AcuMS.aculab.com>
 <CAOWid-eEbeeU9mOpwgOatt5rHQhRt+xPrsQ1fsMemVZDdeN=MQ@mail.gmail.com>
In-Reply-To: <CAOWid-eEbeeU9mOpwgOatt5rHQhRt+xPrsQ1fsMemVZDdeN=MQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS2VubnkgSG8NCj4gU2VudDogMjUgTWF5IDIwMjMgMTU6MjgNCj4gVG86IERhdmlkIExh
aWdodCA8RGF2aWQuTGFpZ2h0QEFDVUxBQi5DT00+DQo+IENjOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+OyBNYXJjIERpb25uZSA8bWFyYy5kaW9ubmVAYXVyaXN0b3IuY29tPjsgS2Vubnkg
SG8gPEtlbm55LkhvQGFtZC5jb20+Ow0KPiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQu
Y29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0
DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9y
Zz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IGxpbnV4LQ0KPiBhZnNAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBSZW1vdmUgaGFyZGNvZGVkIHN0YXRp
YyBzdHJpbmcgbGVuZ3RoDQo+IA0KPiBPbiBUaHUsIE1heSAyNSwgMjAyMyBhdCA1OjE04oCvQU0g
RGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJ
IGRvZXMgcmF0aGVyIGJlZyB0aGUgcXVlc3Rpb24gYXMgd2hhdCBpcyBpbiBVVFNfUkVMRUFTRSB3
aGVuDQo+ID4gaXQgZXhjZWVkcyAoSUlSQykgYWJvdXQgNDggY2hhcmFjdGVycz8NCj4gDQo+IFRo
YW5rcyBmb3IgdGhlIHF1ZXN0aW9uIGFzIGl0IG1hZGUgbWUgZGlnIGRlZXBlci4gIFVUU19SRUxF
QVNFIGlzDQo+IGFjdHVhbGx5IGNhcHBlZCBhdCA2NDoNCi4uLg0KDQpCdXQgaXNuJ3QgVVRTX1JF
TEVBU0UgdXN1YWxseSBtdWNoIHNob3J0ZXI/DQpJIHRoaW5rIGl0IGlzIHdoYXQgJ3VuYW1lIC1y
JyBwcmludHMsIHRoZSBsb25nZXN0IEkndmUgc2VlbiByZWNlbnRseQ0KaXMgIjMuMTAuMC0xMTI3
LjE5LjEuZWw3Lng4Nl82NCIgLSB3ZWxsIHVuZGVyIHRoZSBsaW1pdC4NCg0KLi4uDQo+IA0KPiAi
VGhlIHN0YW5kYXJkIGZvcm11bGF0aW9uIHNlZW1zIHRvIGJlOiA8cHJvamVjdD4gPHZlcnNpb24+
IGJ1aWx0DQo+IDx5eXl5Pi08bW0+LTxkZD4iDQoNCldoaWNoIEkgZG9uJ3QgcmVjYWxsIHRoZSBz
dHJpbmcgYWN0dWFsbHkgbWF0Y2hpbmc/DQpBbHNvIHRoZSBwZW9wbGUgd2hvIGxpa2UgcmVwcm9k
dWNpYmxlIGJ1aWxkcyBkb24ndCBsaWtlIF9fREFURV9fLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

