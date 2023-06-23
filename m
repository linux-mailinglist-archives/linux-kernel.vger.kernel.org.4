Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3211C73B5C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjFWKxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFWKxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:53:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6039170B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:53:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-71-tBdxpI3cNWqapSN6ZcwC3A-1; Fri, 23 Jun 2023 11:52:59 +0100
X-MC-Unique: tBdxpI3cNWqapSN6ZcwC3A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 23 Jun
 2023 11:52:58 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 23 Jun 2023 11:52:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Edward Cree' <ecree.xilinx@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-net-drivers@amd.com" <linux-net-drivers@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] sfc: selftest: fix struct packing
Thread-Topic: [PATCH 3/3] sfc: selftest: fix struct packing
Thread-Index: AQHZophqKcvkZ7aqX0qxFV2c9Cl8D6+YOv4A
Date:   Fri, 23 Jun 2023 10:52:58 +0000
Message-ID: <ee0cf01638074abfbddda7edd3074d2c@AcuMS.aculab.com>
References: <20230619091215.2731541-1-arnd@kernel.org>
 <20230619091215.2731541-3-arnd@kernel.org>
 <7c448f02-4031-0a90-97e2-0cc663b0cff9@gmail.com>
In-Reply-To: <7c448f02-4031-0a90-97e2-0cc663b0cff9@gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uDQo+IER1cGxpY2F0aW5nIHRoZSBkZWZpbml0aW9uIGlzbid0IHRoZSBwcmV0dGllc3QgdGhp
bmcgaW4gdGhlIHdvcmxkOyBpdCdkDQo+ICBkbyBmb3IgYSBxdWljayBmaXggaWYgbmVlZGVkIGJ1
dCBJIGFzc3VtZSBXPTEgd2FybmluZ3MgYXJlbid0IGJsb2NraW5nDQo+ICBhbnlvbmUsIHNvIG1h
eWJlIGRlZmVyIHRoaXMgb25lIGZvciBub3cgYW5kIEknbGwgZm9sbG93IHVwIHNvb24gd2l0aCBh
DQo+ICByZXdyaXRlIHRoYXQgZml4ZXMgdGhpcyBtb3JlIGNsZWFubHk/ICBNeSBpZGVhIGlzIHRv
IGRyb3AgdGhlIF9fcGFja2VkDQo+ICBmcm9tIHRoZSBjb250YWluaW5nIHN0cnVjdCwgbWFrZSBl
ZnhfYmVnaW5fbG9vcGJhY2soKSBjb3B5IHRoZSBsYXllcnMNCj4gIHNlcGFyYXRlbHksIGFuZCBl
ZnhfbG9vcGJhY2tfcnhfcGFja2V0KCkgc2ltaWxhcmx5IGRvIHNvbWV0aGluZyBsZXNzDQo+ICBk
aXJlY3QgdGhhbiBjYXN0aW5nIHRoZSBwYWNrZXQgZGF0YSB0byB0aGUgc3RydWN0Lg0KDQpNYXli
ZSB5b3UgY2FuIGdldCBhd2F5IHdpdGggYWRkaW5nIGEgMTZiaXQgcGFkIGJlZm9yZSB0aGUgZXRo
ZXJuZXQNCmhlYWRlciBzbyB0aGF0IHRoZSBJUCBoZWFkZXIgaXMgYWN0dWFsbHkgYWxpZ25lZC4N
Cg0KKFRoZW4gZmlnaHQgYWxsIHRoZSBzdHVmZiB0aGF0IHN0b3BzIHlvdSBkb2luZyBhIG1lbWNw
eSgpDQp0aGF0IHJ1bnMgaW50byBhIHNlY29uZCBmaWVsZCBvZiBhIHN0cnVjdHVyZS4pDQoNCkZh
aWxpbmcgdGhhdCBtYXliZSBhIHNpbmdsZSBzaGFyZWQgY29weSBvZiB0aGUgbWlzYWxpZ25lZA0K
SVAgaGVhZGVyLg0KDQpJIGFsc28gc3VzcGVjdCB5b3UgY291bGQganVzdCBhZGQgX19wYWNrZWQg
dG8gdGhlIHR3byAzMmJpdA0KYWRkcmVzcyBmaWVsZHMuDQpUaGF0IHdvdWxkIGdlbmVyYXRlIGJl
dHRlciBjb2RlIG9uIHN5c3RlbXMgdGhhdCBjYXJlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

