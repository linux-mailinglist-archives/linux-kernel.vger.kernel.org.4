Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFAA6DEC48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjDLHMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjDLHL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:11:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C223584
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:11:29 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-252-UbfbuGmJMbSwt-VYwJ58OQ-1; Wed, 12 Apr 2023 08:11:26 +0100
X-MC-Unique: UbfbuGmJMbSwt-VYwJ58OQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 12 Apr
 2023 08:11:24 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 12 Apr 2023 08:11:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Baolu Lu' <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
CC:     Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Thread-Topic: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Thread-Index: AQHZbEHu9QGkmONo40W+xGFseOdGmq8mnrSggAA1HQCAAG80EA==
Date:   Wed, 12 Apr 2023 07:11:24 +0000
Message-ID: <b6ab9a30960d41c9b42e5880b89277e3@AcuMS.aculab.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
 <20230411064815.31456-12-baolu.lu@linux.intel.com>
 <ec1536af68e6478a9b10a0d884cc988d@AcuMS.aculab.com>
 <6d9ed10d-12ee-792f-fc34-60a8e432c5d2@linux.intel.com>
In-Reply-To: <6d9ed10d-12ee-792f-fc34-60a8e432c5d2@linux.intel.com>
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

RnJvbTogQmFvbHUgTHUNCj4gU2VudDogMTIgQXByaWwgMjAyMyAwMjozMg0KPiANCj4gT24gNC8x
Mi8yMyA1OjIyIEFNLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4+IFNlbnQ6IDExIEFwcmlsIDIw
MjMgMDc6NDgNCj4gPj4NCj4gPj4gRnJvbTogVGluYSBaaGFuZzx0aW5hLnpoYW5nQGludGVsLmNv
bT4NCj4gPj4NCj4gPj4gVGhlIHBhdGNoIGZpeGVzIHRoZSBrbG9jd29yayBpc3N1ZXMgdGhhdCBv
cGVyYW5kcyBpbiBhIGJpdHdpc2Ugb3BlcmF0aW9uDQo+ID4+IGhhdmUgZGlmZmVyZW50IHNpemUg
YXQgbGluZSAxNjkyIG9mIGRtYXIuYywgbGluZSAxODk4IGFuZCBsaW5lIDE5MDcgb2YNCj4gPj4g
aW9tbXUuYy4NCj4gPiBXaHkgaXMgdGhpcyBhbnkga2luZCBvZiB0aGluZyB0aGF0IG5lZWRzIGZp
eGluZz8NCj4gDQo+IFRoaXMgZGVzY3JpcHRpb24gaXMgYSBiaXQgbWlzbGVhZGluZy4gQWN0dWFs
bHkgSSBxdWV1ZWQgaXQgYXMgYSBjbGVhbnVwDQo+IHBhdGNoLg0KDQpIb3BlZnVsbHkgd2l0aG91
dCAnZml4JyBhbnl3aGVyZSBpbiB0aGUgZGVzY3JpcHRpb24uDQpPdGhlcndpc2UgdGhlIHNjcmlw
dHMgd2lsbCBwaWNrIGl0IGZvciBhIGJhY2stcG9ydC4NCg0KPiA+IC0JCXZhbCB8PSAoMSA8PCAx
MSkgfCAxOw0KPiA+ICsJCXZhbCB8PSBCSVRfVUxMKDExKSB8IEJJVF9VTEwoMCk7DQoNCk1vcmUg
cHJvYmxlbWF0aWMgaXQgd2hhdCBpcyBiaXQgMTEgYW55d2F5Pw0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

