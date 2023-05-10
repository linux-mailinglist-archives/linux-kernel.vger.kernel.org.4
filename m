Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF376FD4DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbjEJD7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbjEJD6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:58:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A326B6A72;
        Tue,  9 May 2023 20:56:10 -0700 (PDT)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QGLkB0yhjzsRHG;
        Wed, 10 May 2023 11:54:10 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 11:56:02 +0800
Received: from dggpeml500019.china.huawei.com ([7.185.36.137]) by
 dggpeml500019.china.huawei.com ([7.185.36.137]) with mapi id 15.01.2507.023;
 Wed, 10 May 2023 11:56:02 +0800
From:   michenyuan <michenyuan@huawei.com>
To:     Simon Horman <simon.horman@corigine.com>
CC:     "isdn@linux-pingi.de" <isdn@linux-pingi.de>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] bluetooth: unregister correct BTPROTO for
 CMTP
Thread-Topic: [PATCH v2 net-next] bluetooth: unregister correct BTPROTO for
 CMTP
Thread-Index: AdmC8p97tjZZmALXQZ+5PWW9GDAupA==
Date:   Wed, 10 May 2023 03:56:02 +0000
Message-ID: <57262f4de08d4940bd47c2b28a5418e7@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.184.199]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIHRoaXMgYnVnIHNlZW1zIHRvIGhhdmUgbm90IGJlZW4gZml4ZWQsIGl0IHN0aWxsIGV4aXN0
cyBpbiB0aGUgY3VycmVudCBtYWluIGJyYW5jaCBpbiBsaW51eCBrZXJuZWwuDQpJcyB0aGVyZSBh
bnl0aGluZyBibG9ja2luZyB0aGUgYnVnIGZpeGluZz8NCg0KLS0tLS0tLS0NCk9uIFR1ZSwgQXBy
IDA0LCAyMDIzIGF0IDExOjI0OjIwQU0gLTA3MDAsIEx1aXogQXVndXN0byB2b24gRGVudHogd3Jv
dGU6DQo+IEhpLA0KPiANCj4gT24gVHVlLCBBcHIgNCwgMjAyMyBhdCA4OjQw4oCvQU0gU2ltb24g
SG9ybWFuIDxzaW1vbi5ob3JtYW5AY29yaWdpbmUuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1
ZSwgQXByIDA0LCAyMDIzIGF0IDA5OjUyOjU4QU0gKzA4MDAsIENoZW55dWFuIE1pIHdyb3RlOg0K
PiA+ID4gT24gZXJyb3IgdW5yZWdpc3RlciBCVFBST1RPX0NNVFAgdG8gbWF0Y2ggdGhlIHJlZ2lz
dHJhdGlvbiBlYXJsaWVyIA0KPiA+ID4gaW4gdGhlIHNhbWUgY29kZS1wYXRoLiBXaXRob3V0IHRo
aXMgY2hhbmdlIEJUUFJPVE9fSElEUCBpcyANCj4gPiA+IGluY29ycmVjdGx5IHVucmVnaXN0ZXJl
ZC4NCj4gPiA+DQo+ID4gPiBUaGlzIGJ1ZyBkb2VzIG5vdCBhcHBlYXIgdG8gY2F1c2Ugc2VyaW91
cyBzZWN1cml0eSBwcm9ibGVtLg0KPiA+ID4NCj4gPiA+IFRoZSBmdW5jdGlvbiAnYnRfc29ja191
bnJlZ2lzdGVyJyB0YWtlcyBpdHMgcGFyYW1ldGVyIGFzIGFuIGluZGV4IA0KPiA+ID4gYW5kIE5V
TExzIHRoZSBjb3JyZXNwb25kaW5nIGVsZW1lbnQgb2YgJ2J0X3Byb3RvJyB3aGljaCBpcyBhbiAN
Cj4gPiA+IGFycmF5IG9mIHBvaW50ZXJzLiBXaGVuICdidF9wcm90bycgZGVyZWZlcmVuY2VzIGVh
Y2ggZWxlbWVudCwgaXQgDQo+ID4gPiB3b3VsZCBjaGVjayB3aGV0aGVyIHRoZSBlbGVtZW50IGlz
IGVtcHR5IG9yIG5vdC4gVGhlcmVmb3JlLCB0aGUgDQo+ID4gPiBwcm9ibGVtIG9mIG51bGwgcG9p
bnRlciBkZWZlcmVuY2UgZG9lcyBub3Qgb2NjdXIuDQo+ID4gPg0KPiA+ID4gRm91bmQgYnkgaW5z
cGVjdGlvbi4NCj4gPiA+DQo+ID4gPiBGaXhlczogOGM4ZGU1ODljZWRkICgiQmx1ZXRvb3RoOiBB
ZGRlZCAvcHJvYy9uZXQvY210cCB2aWEgDQo+ID4gPiBidF9wcm9jZnNfaW5pdCgpIikNCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IENoZW55dWFuIE1pIDxtaWNoZW55dWFuQGh1YXdlaS5jb20+DQo+ID4N
Cj4gPiBSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuIDxzaW1vbi5ob3JtYW5AY29yaWdpbmUuY29t
Pg0KPiA+DQo+ID4gPiAtLS0NCj4gPiA+ICBuZXQvYmx1ZXRvb3RoL2NtdHAvc29jay5jIHwgMiAr
LQ0KPiA+ID4gIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvY210cC9zb2NrLmMgYi9u
ZXQvYmx1ZXRvb3RoL2NtdHAvc29jay5jIA0KPiA+ID4gaW5kZXggOTZkNDlkOWZhZTk2Li5jZjQz
NzAwNTVjZTIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9uZXQvYmx1ZXRvb3RoL2NtdHAvc29jay5jDQo+
ID4gPiArKysgYi9uZXQvYmx1ZXRvb3RoL2NtdHAvc29jay5jDQo+ID4gPiBAQCAtMjUwLDcgKzI1
MCw3IEBAIGludCBjbXRwX2luaXRfc29ja2V0cyh2b2lkKQ0KPiA+ID4gICAgICAgZXJyID0gYnRf
cHJvY2ZzX2luaXQoJmluaXRfbmV0LCAiY210cCIsICZjbXRwX3NrX2xpc3QsIE5VTEwpOw0KPiA+
ID4gICAgICAgaWYgKGVyciA8IDApIHsNCj4gPiA+ICAgICAgICAgICAgICAgQlRfRVJSKCJGYWls
ZWQgdG8gY3JlYXRlIENNVFAgcHJvYyBmaWxlIik7DQo+ID4gPiAtICAgICAgICAgICAgIGJ0X3Nv
Y2tfdW5yZWdpc3RlcihCVFBST1RPX0hJRFApOw0KPiA+ID4gKyAgICAgICAgICAgICBidF9zb2Nr
X3VucmVnaXN0ZXIoQlRQUk9UT19DTVRQKTsNCj4gPiA+ICAgICAgICAgICAgICAgZ290byBlcnJv
cjsNCj4gPiA+ICAgICAgIH0NCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi4yNS4xDQo+ID4gPg0K
PiANCj4gVGhpcyBvbmUgZG9lcyBub3QgYXBwZWFyIG9uIHB3IGZvciBzb21lIHJlYXNvbiwgbm90
IHN1cmUgaWYgdGhhdCB3YXMgDQo+IGJlY2F1c2Ugb2Ygc3ViamVjdCBvciB3aGF0LCBzbyBwbGVh
c2UgcmVzdWJtaXQgaXQsIGRvbid0IGZvcmdldCB0byBhZGQgDQo+IFJldmlld2VkLWJ5IHlvdSBn
b3QgaW4gdGhpcyB0aHJlYWQuDQoNClllcywgY3VyaW91cy4NCg0KUGVyaGFwcyBpdCBpcyBkdWUg
dG8gdGhlICduZXQtbmV4dCcgaW4gdGhlIHN1YmplY3QgcHJlZml4Lg0KSSBwcmV2aW91c2x5IGFk
dmlzZWQgYWRkaW5nIHRoYXQsIHdoaWNoIEkgbm93IHNlZSB3YXMgaW4gY29ycmVjdCBhcyB0aGlz
IGlzIGEgQmx1ZXRvb3RoIHBhdGNoLiBTb3JyeSBhYm91dCB0aGF0Lg0K
