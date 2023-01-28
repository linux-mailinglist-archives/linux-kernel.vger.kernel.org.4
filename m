Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA46067F54D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 07:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjA1Gv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 01:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjA1Gvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 01:51:55 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5736E442CE;
        Fri, 27 Jan 2023 22:51:53 -0800 (PST)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P3lRr3VrdzRrDL;
        Sat, 28 Jan 2023 14:49:44 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (7.193.23.29) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 28 Jan 2023 14:51:51 +0800
Received: from kwepemm600002.china.huawei.com ([7.193.23.29]) by
 kwepemm600002.china.huawei.com ([7.193.23.29]) with mapi id 15.01.2375.034;
 Sat, 28 Jan 2023 14:51:51 +0800
From:   zhongjinghua <zhongjinghua@huawei.com>
To:     Mike Christie <michael.christie@oracle.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "emilne@redhat.com" <emilne@redhat.com>,
        "hare@suse.de" <hare@suse.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>,
        "houtao (A)" <houtao1@huawei.com>, yangerkun <yangerkun@huawei.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHNjc2k6IGZpeCBpc2NzaSByZXNjYW4gZmFpbHMg?=
 =?utf-8?Q?to_create_block?=
Thread-Topic: [PATCH] scsi: fix iscsi rescan fails to create block
Thread-Index: AQHZKhyR4Le9xCcAm0ekZK9DgjD7Ba6kSOuAgA8kHoA=
Date:   Sat, 28 Jan 2023 06:51:51 +0000
Message-ID: <40d06d0004354b79989168a90e5d7a60@huawei.com>
References: <20230117030114.2131734-1-zhongjinghua@huawei.com>
 <c3bd2bf7-e174-3afd-43d2-7010d9809815@oracle.com>
In-Reply-To: <c3bd2bf7-e174-3afd-43d2-7010d9809815@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.159]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCldlIGFsc28gd2FudCB0byB3cml0ZSBnZXRfZGV2aWNlX3VubGVzc196ZXJvLCBJ
IHdpbGwgdHJ5IHRvIG1ha2UgYSBwYXRjaC4NCg0KSSdtIG5vdCBzdXJlIGlmIHRoaXMgcHJvYmxl
bSBleGlzdHMgaW4gb3RoZXIgcGxhY2VzIGFuZCBjYW4gYmUgZml4ZWQgaW4gdGhpcyB3YXksIGJl
Y2F1c2Ugd2Ugb25seSB0ZXN0ZWQgdGhpcyBwcm9ibGVtLg0KSSB3YW50IHRvIGZpeCB0aGlzIHBy
b2JsZW0gdGhhdCBpcyBub3cgdGVzdGVkIGZpcnN0Lg0KDQpUaGFua3MuDQoNCi0tLS0t6YKu5Lu2
5Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogTWlrZSBDaHJpc3RpZSA8bWljaGFlbC5jaHJpc3RpZUBv
cmFjbGUuY29tPiANCuWPkemAgeaXtumXtDogMjAyM+W5tDHmnIgxOeaXpSA3OjA3DQrmlLbku7bk
uro6IHpob25namluZ2h1YSA8emhvbmdqaW5naHVhQGh1YXdlaS5jb20+OyBqZWpiQGxpbnV4Lmli
bS5jb207IG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tOyBidmFuYXNzY2hlQGFjbS5vcmc7IGVt
aWxuZUByZWRoYXQuY29tOyBoYXJlQHN1c2UuZGUNCuaKhOmAgTogbGludXgtc2NzaUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHpoYW5neWkgKEYpIDx5aS56
aGFuZ0BodWF3ZWkuY29tPjsgeXVrdWFpIChDKSA8eXVrdWFpM0BodWF3ZWkuY29tPjsgaG91dGFv
IChBKSA8aG91dGFvMUBodWF3ZWkuY29tPg0K5Li76aKYOiBSZTogW1BBVENIXSBzY3NpOiBmaXgg
aXNjc2kgcmVzY2FuIGZhaWxzIHRvIGNyZWF0ZSBibG9jaw0KDQpPbiAxLzE2LzIzIDIxOjAxLCBa
aG9uZyBKaW5naHVhIHdyb3RlOg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Njc2lfc3lz
ZnMuYyBiL2RyaXZlcnMvc2NzaS9zY3NpX3N5c2ZzLmMgDQo+IGluZGV4IDQyZGI5YzUyMjA4ZS4u
ZTc4OTM4MzViOTlhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Njc2kvc2NzaV9zeXNmcy5jDQo+
ICsrKyBiL2RyaXZlcnMvc2NzaS9zY3NpX3N5c2ZzLmMNCj4gQEAgLTE1MDMsNiArMTUwMywxMyBA
QCB2b2lkIHNjc2lfcmVtb3ZlX2RldmljZShzdHJ1Y3Qgc2NzaV9kZXZpY2UgDQo+ICpzZGV2KSAg
fSAgRVhQT1JUX1NZTUJPTChzY3NpX3JlbW92ZV9kZXZpY2UpOw0KPiAgDQo+ICtzdGF0aWMgaW50
IHNjc2lfZGV2aWNlX3RyeV9nZXQoc3RydWN0IHNjc2lfZGV2aWNlICpzZGV2KSB7DQo+ICsJaWYg
KCFrb2JqZWN0X2dldF91bmxlc3NfemVybygmc2Rldi0+c2Rldl9nZW5kZXYua29iaikpDQo+ICsJ
CXJldHVybiAtRU5YSU87DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lk
IF9fc2NzaV9yZW1vdmVfdGFyZ2V0KHN0cnVjdCBzY3NpX3RhcmdldCAqc3RhcmdldCkgIHsNCj4g
IAlzdHJ1Y3QgU2NzaV9Ib3N0ICpzaG9zdCA9IGRldl90b19zaG9zdChzdGFyZ2V0LT5kZXYucGFy
ZW50KTsNCj4gQEAgLTE1MjEsOSArMTUyOCw3IEBAIHN0YXRpYyB2b2lkIF9fc2NzaV9yZW1vdmVf
dGFyZ2V0KHN0cnVjdCBzY3NpX3RhcmdldCAqc3RhcmdldCkNCj4gIAkJaWYgKHNkZXYtPmNoYW5u
ZWwgIT0gc3RhcmdldC0+Y2hhbm5lbCB8fA0KPiAgCQkgICAgc2Rldi0+aWQgIT0gc3RhcmdldC0+
aWQpDQo+ICAJCQljb250aW51ZTsNCj4gLQkJaWYgKHNkZXYtPnNkZXZfc3RhdGUgPT0gU0RFVl9E
RUwgfHwNCj4gLQkJICAgIHNkZXYtPnNkZXZfc3RhdGUgPT0gU0RFVl9DQU5DRUwgfHwNCj4gLQkJ
ICAgICFnZXRfZGV2aWNlKCZzZGV2LT5zZGV2X2dlbmRldikpDQo+ICsJCWlmIChzY3NpX2Rldmlj
ZV90cnlfZ2V0KHNkZXYpKQ0KPiAgCQkJY29udGludWU7DQo+ICAJCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoc2hvc3QtPmhvc3RfbG9jaywgZmxhZ3MpOw0KPiAgCQlzY3NpX3JlbW92ZV9kZXZpY2Uo
c2Rldik7DQoNCkkgdGhpbmsgdGhlIHBhdGNoIHdpbGwgd29yayBvay4gSSBkb24ndCB0aGluayB3
ZSB3YW50IHRvIG1peCBpbiBvdXIgb3duIHJlZmVyZW5jZSBnZXR0aW5nIGZ1bmN0aW9uIHRoYXQg
d29ya3Mgb24ga29iamVjdHMgZGlyZWN0bHkgd2l0aCB0aGUgcHV0X2RldmljZSB1c2UgYSBsaXR0
bGUgYmVsb3cgdGhhdCBsaW5lIGFib3ZlLg0KDQpTaW5jZSB0aGlzIGlzIHRoZSBzZWNvbmQgdGlt
ZSAobG9va3MgbGlrZSBIYW5uZXMgd2FzIHdhbnRpbmcgb25lIHdoZW4gaGUgb3JpZ2luYWxseSBm
aXhlZCB0aGlzKSB3ZSd2ZSB3YW50ZWQgYSBnZXRfdW5sZXNzX3plcm8gdHlwZSBmdW5jdGlvbiBk
aWQgeW91IHNlbmQgR3JlZyBhIGdldF9kZXZpY2VfdW5sZXNzX3plcm8gdHlwZSBvZiBwYXRjaCBh
bHJlYWR5IGFuZCB3YXMgdGhhdCByZWplY3RlZD8NCg0KV2h5IGRvZXNuJ3Qgc2NzaV9mb3JnZXRf
aG9zdCBoYXZlIHRoZSBzYW1lIGlzc3VlIHdpdGggb3RoZXIgZHJpdmVycyBhbmQgc2ltaWxhciBz
Y2FuL2RlbGV0ZS9ob3N0LXJlbW92YWwgdHlwZSBvZiB0ZXN0cz8gSXMgdGhlcmUgc29tZXRoaW5n
IHRoYXQgZmx1c2hlcyB0aG9zZSBhc3luYyBzY2Fucz8gSSdtIGp1c3Qgd29uZGVyaW5nIGlmIHdl
IGNhbiBkbyBzb21ldGhpbmcgc2ltaWxhciBmb3IgdGhlIHRhcmdldCByZW1vdmFsIG9yIGlmIHRo
ZSBob3N0IHJlbW92YWwgbmVlZHMgYSBzaW1pbGFyIGZpeC4NCg==
