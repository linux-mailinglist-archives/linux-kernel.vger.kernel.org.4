Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB3560109D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJQN54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiJQN5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:57:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE2D543C6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:57:33 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mrdn12kMjz67ZTx;
        Mon, 17 Oct 2022 21:55:49 +0800 (CST)
Received: from lhrpeml100006.china.huawei.com (7.191.160.224) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 15:57:30 +0200
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 14:57:30 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2375.031;
 Mon, 17 Oct 2022 14:57:30 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     liulongfang <liulongfang@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [Linuxarm] [PATCH 1/2] hisi_acc_vfio_pci: Add debugfs to
 migration driver
Thread-Topic: [Linuxarm] [PATCH 1/2] hisi_acc_vfio_pci: Add debugfs to
 migration driver
Thread-Index: AQHY33jn3vm7nL+b2kmRrtcPPJ6rEq4NjJeAgAS3HwCAAFuBkA==
Date:   Mon, 17 Oct 2022 13:57:30 +0000
Message-ID: <b8bf06ebd8da46a5a72001bead4b4a09@huawei.com>
References: <20221014025757.39415-1-liulongfang@huawei.com>
 <20221014025757.39415-2-liulongfang@huawei.com>
 <42d12308-4777-47a7-a1ae-50dfada050cf@huawei.com>
 <7c041671-71bf-d558-d47a-70296fe5c30e@huawei.com>
In-Reply-To: <7c041671-71bf-d558-d47a-70296fe5c30e@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGl1bG9uZ2ZhbmcNCj4g
U2VudDogMTcgT2N0b2JlciAyMDIyIDEwOjIxDQo+IFRvOiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5
QGh1YXdlaS5jb20+OyBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsNCj4gamdnQG52aWRpYS5j
b207IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhv
ZGlAaHVhd2VpLmNvbT4NCj4gQ2M6IGNvaHVja0ByZWRoYXQuY29tOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eGFybUBvcGVuZXVsZXIub3JnDQo+IFN1YmplY3Q6IFJlOiBb
TGludXhhcm1dIFtQQVRDSCAxLzJdIGhpc2lfYWNjX3ZmaW9fcGNpOiBBZGQgZGVidWdmcyB0bw0K
PiBtaWdyYXRpb24gZHJpdmVyDQo+IA0KPiBPbiAyMDIyLzEwLzE0IDE3OjIwLCBKb2huIEdhcnJ5
IHdyb3RlOg0KPiA+IE9uIDE0LzEwLzIwMjIgMDM6NTcsIExvbmdmYW5nIExpdSB3cm90ZToNCj4g
Pj4gK3N0YXRpYyB2b2lkIGhpc2lfYWNjX3ZmX2RlYnVnZnNfaW5pdChzdHJ1Y3QgaGlzaV9hY2Nf
dmZfY29yZV9kZXZpY2UNCj4gKmhpc2lfYWNjX3ZkZXYpDQo+ID4+ICt7DQo+ID4+ICvCoMKgwqAg
c3RydWN0IHBjaV9kZXYgKnZmX3BkZXYgPSBoaXNpX2FjY192ZGV2LT52Zl9kZXY7DQo+ID4+ICvC
oMKgwqAgc3RydWN0IGRldmljZSAqZGV2ID0gJnZmX3BkZXYtPmRldjsNCj4gPj4gK8KgwqDCoCBp
bnQgcmV0Ow0KPiA+PiArDQo+ID4+ICvCoMKgwqAgaWYgKCFhdG9taWNfcmVhZCgmaGlzaV9hY2Nf
cm9vdF9yZWYpKQ0KPiA+PiArwqDCoMKgwqDCoMKgwqAgaGlzaV9hY2NfZGVidWdmc19yb290ID0g
ZGVidWdmc19jcmVhdGVfZGlyKCJoaXNpX3ZmaW9fYWNjIiwNCj4gTlVMTCk7DQo+ID4+ICvCoMKg
wqAgYXRvbWljX2luYygmaGlzaV9hY2Nfcm9vdF9yZWYpOw0KPiA+PiArDQo+ID4NCj4gPiBUaGlz
IGxvb2tzIHRvdGFsbHkgcmFjeSwgc3VjaCB0aGF0IEkgd29uZGVyIHdoeSBldmVuIGJvdGhlciB1
c2luZyBhbiBhdG9taWMNCj4gZm9yIGhpc2lfYWNjX3Jvb3RfcmVmLg0KPiANCj4gDQo+IFdoZW4g
ZW5hYmxpbmcgVkYsIGl0IGlzIHBvc3NpYmxlIGZvciBtdWx0aXBsZSBWTXMgdG8gZW5hYmxlIFZG
IGF0IHRoZSBzYW1lDQo+IHRpbWUuIFRoZSBhdG9taWMgdmFyaWFibGUNCj4gaXMgdXNlZCB0byBl
bnN1cmUgdGhhdCBvbmx5IG9uZSAiaGlzaV92ZmlvX2FjYyIgaXMgY3JlYXRlZC4gV2hlbiBvdGhl
ciBWRnMNCj4gYXJlIGVuYWJsZWQsDQo+IGl0IHdpbGwgbm90IGJlIGNyZWF0ZWQgYWdhaW4sIGJ1
dCB3aWxsIGJlIHVzZWQgZGlyZWN0bHkuDQo+IA0KPiAgSW5kZWVkLCB3aHkgaXMgaGlzaV9hY2Nf
ZGVidWdmc19yb290IG5vdCBjcmVhdGVkIGluIHRoZSBkcml2ZXIgbW9kdWxlIGluaXQ/DQo+ID4N
Cj4gQmVjYXVzZSB0aGUgbm9ybWFsIGZ1bmN0aW9uIG9mIFZGIGlzIHRvIHBlcmZvcm0gZW5jcnlw
dGlvbiBhbmQgZGVjcnlwdGlvbg0KPiBzZXJ2aWNlcywgdGhlIGxpdmUgbWlncmF0aW9uDQo+IGZ1
bmN0aW9uIGlzIGFuIGF1eGlsaWFyeSBmdW5jdGlvbiwgd2hpY2ggbm8gbmVlZCB0byBiZSB1c2Vk
IGluIHNjZW5hcmlvcw0KPiB3aGVyZSBvbmx5IGVuY3J5cHRpb24gYW5kDQo+IGRlY3J5cHRpb24g
c2VydmljZXMgYXJlIHBlcmZvcm1lZC4NCj4gDQo+IER1cmluZyBtb2R1bGUgaW5pdCwgaXQgY2Fu
IHJlZ2lzdGVyIG9wcyhoaXNpX2FjY192ZmlvX3BjaV9vcHMpIHRoYXQgb25seQ0KPiBwZXJmb3Jt
IGVuY3J5cHRpb24gYW5kDQo+IGRlY3J5cHRpb24gc2VydmljZXMsIGFuZCBjYW4gYWxzbyByZWdp
c3RlciB3aXRoIGxpdmUgbWlncmF0aW9uIGZ1bmN0aW9uDQo+IG9wcyhoaXNpX2FjY192ZmlvX3Bj
aV9taWdybl9vcHMpLA0KPiBhbmQgdGhpcyBkZWJ1Z2ZzIG9ubHkgbmVlZHMgdG8gcmVnaXN0ZXIg
aXQgd2hlbiB0aGUgdGhlIG9wcyBpcw0KPiBoaXNpX2FjY192ZmlvX3BjaV9taWdybl9vcHMuDQoN
Cklzbid0IHRoZSBvcHMgcmVnaXN0cmF0aW9uIGhhcHBlbnMgYXQgcHJvYmUoKT8gSW4gYW55IGNh
c2UsIEkgdGhpbmsgeW91IGNhbiBtb3ZlDQp0aGUgaGlzaV9hY2NfZGVidWdmc19yb290IGNyZWF0
aW9uIHRvIG1vZHVsZV9pbml0KCkgYXMgc3VnZ2VzdGVkIGFib3ZlDQphbmQgYXZvaWQgdGhlIHJh
Y2UuDQoNClRoYW5rcywNClNoYW1lZXINCg==
