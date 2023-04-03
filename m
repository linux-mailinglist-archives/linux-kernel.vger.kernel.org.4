Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA226D4D1E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjDCQFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjDCQE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:04:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03361BF4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:04:56 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-65-BBf6032fNrmxOQj_Mm1cNQ-1; Mon, 03 Apr 2023 17:04:53 +0100
X-MC-Unique: BBf6032fNrmxOQj_Mm1cNQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 3 Apr
 2023 17:04:49 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 3 Apr 2023 17:04:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jaewon Kim' <jaewon31.kim@gmail.com>,
        Petr Mladek <pmladek@suse.com>
CC:     Jaewon Kim <jaewon31.kim@samsung.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "GyeongHwan Hong" <gh21.hong@samsung.com>
Subject: RE: [RFC] vsprintf: compile error on %09pK
Thread-Topic: [RFC] vsprintf: compile error on %09pK
Thread-Index: AQHZZjo06zU/Uk1aJESRuJ9LqrEnba8Zvx1Q
Date:   Mon, 3 Apr 2023 16:04:49 +0000
Message-ID: <694722c9409b43808cfbc1fc9e495016@AcuMS.aculab.com>
References: <CGME20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
 <20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
 <ZCrMMQt2xnnZIyz6@alley>
 <CAJrd-Uvzy18SfjjqbqZCPHjw+ujQXsBpvov4b=bfAwZrj=bCAA@mail.gmail.com>
In-Reply-To: <CAJrd-Uvzy18SfjjqbqZCPHjw+ujQXsBpvov4b=bfAwZrj=bCAA@mail.gmail.com>
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

RnJvbTogSmFld29uIEtpbQ0KPiBTZW50OiAwMyBBcHJpbCAyMDIzIDE1OjQwDQouLi4NCj4gSSB3
YW50ZWQgdG8gcHJpbnQgcGh5c19hZGRyX3QgIHR5cGUgdmFsdWUgb25seSB3aGVuIGtwdHJfcmVz
dHJpY3Qgc3lzY3RsIGlzDQo+IGFsbG93ZWQuIFNvIEkgdGhvdWdodCBJIGNvdWxkIHVzZSAlcEsg
Zm9yIHRoYXQgcHVycG9zZS4gQW5kIHRoZSBwaHlzaWNhbA0KPiBhZGRyZXNzIGlzIG5vdCB0aGF0
IGxvbmcuIEkgd2FudGVkIHRvIG1ha2UgdGhhdCBsZW5ndGggc2hvcnQgbGlrZSA5IGhleC4NCg0K
SXNuJ3QgdGhhdCBpcyB0aGUgd3JvbmcgZm9ybWF0IGZvciBwaHlzaWNhbCBhZGRyZXNzZXMgYW55
d2F5Pw0KVGhleSBjYW4gYmUgbGFyZ2VyIHRoYW4gdmlydHVhbCBvbmVzIChlZyB4ODYgd2l0aCBQ
QUUpLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

