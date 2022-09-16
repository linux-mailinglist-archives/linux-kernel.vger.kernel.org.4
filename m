Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0D45BACB4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiIPLrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiIPLru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:47:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D1978591
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 04:47:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-317-gDmabKfNMGmiNQG_CFGsMg-1; Fri, 16 Sep 2022 12:47:43 +0100
X-MC-Unique: gDmabKfNMGmiNQG_CFGsMg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 16 Sep
 2022 12:47:42 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 16 Sep 2022 12:47:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'haoxin' <xhao@linux.alibaba.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        SeongJae Park <sj@kernel.org>
Subject: RE: [PATCH] mm/hugetlbfs: use macro SZ_1K to replace 1024
Thread-Topic: [PATCH] mm/hugetlbfs: use macro SZ_1K to replace 1024
Thread-Index: AQHYyK0ixJRInyXScUOgT9LTwM07m63h8Tog
Date:   Fri, 16 Sep 2022 11:47:42 +0000
Message-ID: <6fe4a3c252a34199b715e4e941fb2be7@AcuMS.aculab.com>
References: <20220914115723.38271-1-xhao@linux.alibaba.com>
 <YyIEsuOm0wEkmpAA@ZenIV>
 <408fbc89-8711-0ea2-16e7-99b746e1f09e@linux.alibaba.com>
In-Reply-To: <408fbc89-8711-0ea2-16e7-99b746e1f09e@linux.alibaba.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogaGFveGluDQo+IFNlbnQ6IDE1IFNlcHRlbWJlciAyMDIyIDAzOjQ1DQo+IA0KPiDDpcWT
wqggMjAyMi85LzE1IMOkwrjFoMOl77+9y4YxMjo0MywgQWwgVmlybyDDpeKAoOKEosOp77+94oCc
Og0KPiA+IE9uIFdlZCwgU2VwIDE0LCAyMDIyIGF0IDA3OjU3OjIzUE0gKzA4MDAsIFhpbiBIYW8g
d3JvdGU6DQo+ID4+IFVzaW5nIG1hY3JvIFNaXzFLIGluIGh1Z2V0bGJmc19zaG93X29wdGlvbnMo
KSBoYXMgbm8gYW55IGZ1bmN0aW9uYWwNCj4gPj4gY2hhbmdlcywganVzdCBtYWtlcyBjb2RlIG1v
cmUgcmVhZGFibGUuDQo+ID4gV2h5IGlzIGl0IGFueSBtb3JlIHJlYWRhYmxlIHRoYXQgd2F5Pw0K
DQo+IFRoZSBtYWluIHB1cnBvc2Ugb2YgdGhpcyBjb2RlIGlzIHRvIGNvbnZlcnQgc2l6ZSB0byAn
SycsIGFuZCAnTScuIEkNCj4gdGhpbmsgdXNpbmcgU1pfMWsgZG9lcyBsb29rIG1vcmUgYXBwcm9w
cmlhdGUgdGhhbiAxMDI0LCB0aGF0J3MgYWxsLg0KDQpZb3UnZCBuZWVkIHRvIHVzZSBTWl8xTS9T
Wl8xSyBpZiB5b3Ugd2FudCB0byBiZSBkZXNjcmlwdGl2ZS4NCkJ1dCByZWFsbHkgaXQganVzdCB1
c2VzIHVwIG1vcmUgYnJhaW4gY3ljbGVzIHRvIHJlYWQuDQoNClVzaW5nIG5hbWVkIGNvbnN0YW50
cyBmb3IgdGhpbmdzIHRoYXQgYXJlIGFic29sdXRlbHkgY29uc3RhbnQNCmlzbid0IHJlYWxseSBu
ZWNlc3NhcnkuDQoNCklmIHlvdSBoYXZlICcjZGVmaW5lIE9ORSAxJyBhcmUgeW91IGV2ZXIgZ29p
bmcgdG8gc2V0IGl0IHRvDQphIGRpZmZlcmVudCB2YWx1ZT8NCg0KQW5kIGRvbid0IGV2ZW4gdGhp
bmsgYWJvdXQgd2hhdCBoYXBwZW5zIHRvIHN5c3RlbXMgdGhhdCBoYWQNCnNtYWxsIGludGVnZXIg
Y29uc3RhbnRzIGF0ICd3ZWxsIGtub3duJyBhZGRyZXNzZXMgYW5kIHRoZW4NCm1hbmFnZWQgdG8g
Y2hhbmdlIG9uZSBvZiB0aGVtLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

