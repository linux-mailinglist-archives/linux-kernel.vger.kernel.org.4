Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D9A6B2CD7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCISYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCISYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:24:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEECF5D03
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 10:24:31 -0800 (PST)
Received: from lhrpeml100003.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PXcyr3Yg1z6J7f5;
        Fri, 10 Mar 2023 02:24:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 18:24:29 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.021;
 Thu, 9 Mar 2023 18:24:29 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 06/14] iommu/arm-smmu-v3: Unset corresponding STE
 fields when s2_cfg is NULL
Thread-Topic: [PATCH v1 06/14] iommu/arm-smmu-v3: Unset corresponding STE
 fields when s2_cfg is NULL
Thread-Index: AQHZUnWW/wX8VWz+vEGpoiDFTSTiqa7ybOCAgABO2MA=
Date:   Thu, 9 Mar 2023 18:24:29 +0000
Message-ID: <e923418a99e44cd38483ea24e4c1d373@huawei.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
        <995e48fe6eb9e31c71dbe8bb80d445aa34a51819.1678348754.git.nicolinc@nvidia.com>
 <4e426dc4-6852-336f-7321-5b4df69fd430@arm.com>
In-Reply-To: <4e426dc4-6852-336f-7321-5b4df69fd430@arm.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDA5IE1hcmNoIDIwMjMgMTM6MTMN
Cj4gVG86IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IGpnZ0BudmlkaWEuY29t
OyB3aWxsQGtlcm5lbC5vcmcNCj4gQ2M6IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsga2V2aW4udGlh
bkBpbnRlbC5jb207IGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbTsNCj4gam9yb0A4Ynl0ZXMub3Jn
OyBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2Rp
QGh1YXdlaS5jb20+OyBqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc7DQo+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgaW9tbXVAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDYvMTRdIGlv
bW11L2FybS1zbW11LXYzOiBVbnNldCBjb3JyZXNwb25kaW5nDQo+IFNURSBmaWVsZHMgd2hlbiBz
Ml9jZmcgaXMgTlVMTA0KPiANCj4gT24gMjAyMy0wMy0wOSAxMDo1MywgTmljb2xpbiBDaGVuIHdy
b3RlOg0KPiA+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4gPg0K
PiA+IERlc3BpdGUgdGhlIHNwZWMgZG9lcyBub3Qgc2VlbSB0byBtZW50aW9uIHRoaXMsIG9uIHNv
bWUgaW1wbGVtZW50YXRpb25zLA0KPiA+IHdoZW4gdGhlIFNURSBjb25maWd1cmF0aW9uIHN3aXRj
aGVzIGZyb20gYW4gUzErUzIgY2ZnIHRvIGFuIFMxIG9ubHkgb25lLA0KPiA+IGEgQ19CQURfU1RF
IGVycm9yIHdvdWxkIGhhcHBlbiBpZiBkc3RbM10gKFMyVFRCKSBpcyBub3QgcmVzZXQuDQo+IA0K
PiBDYW4geW91IHByb3ZpZGUgbW9yZSBkZXRhaWxzLCBzaW5jZSBpdCdzIG5vdCBjbGVhciB3aGV0
aGVyIHRoaXMgaXMgYQ0KPiBoYXJkd2FyZSBlcnJhdHVtIHdvcmthcm91bmQgb3IgYSBib2RnZSBh
cm91bmQgdGhlIGRyaXZlciBpdHNlbGYgZG9pbmcNCj4gc29tZXRoaW5nIHdyb25nIGxpa2Ugbm90
IGRvaW5nIGEgcHJvcGVyIGJyZWFrLWJlZm9yZS1tYWtlIHRyYW5zaXRpb24gb2YNCj4gdGhlIFNU
RS4gVGhlIGFyY2hpdGVjdHVyZSBleHBsaWNpdGx5IHN0YXRlcyB0aGF0IGFsbCB0aGUgU1RFLlMy
KiBmaWVsZHMNCj4gZXhjZXB0IFMyVk1JRCBhbmQgcG90ZW50aWFsbHkgUzJTIGFyZSBpZ25vcmVk
IHdoZW4gU3RhZ2UgMiBpcyBieXBhc3NlZC4NCg0KVG9vayBhIHdoaWxlIHRvIGxvY2F0ZSB0aGUg
ZW1haWwgdGhyZWFkIHdoZXJlIHRoaXMgd2FzIGRpc2N1c3NlZCwNCmh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvY292ZXIvMTE0NDk4OTUvIzIzMjQ0NDU3DQoNClRoaXMgd2FzIG9ic2VydmVk
IG9uIGEgSGlTaWxpY29uIGltcGxlbWVudGF0aW9uIHdoZXJlLCBpZiB0aGUgU01NVXYzIGlzIGNv
bmZpZ3VyZWQgd2l0aA0KYm90aCBTdGFnZSAxIGFuZCBTdGFnZSAyIChuZXN0ZWQpIG1vZGUgb25j
ZSwgdGhlbiBpdCBpcyBub3QgcG9zc2libGUgdG8gY29uZmlndXJlIGl0IGJhY2sNCmZvciBTdGFn
ZSAxIG1vZGUgZm9yIHRoZSBzYW1lIGRldmljZShzdHJlYW0gaWQpLg0KDQpJSVJDLCB0aGUgU01N
VXYzIGltcGxlbWVudGF0aW9uIG9uIHRoZXNlIGJvYXJkcyBleHBlY3RzIHRvIHNldCB0aGUgUzJU
VEIgZmllbGQgaW4gU1RFIHRvIHplcm8NCndoZW4gdXNpbmcgUzEsIG90aGVyd2lzZSBpdCByZXBv
cnRzIENfQkFEX1NURSBlcnJvci4gOigNCg0KWW91IGFyZSByaWdodCB0aGF0IHRoZSBzcGVjaWZp
Y2F0aW9uIGRvZXNuJ3QgZGVtYW5kIHRoaXMgYW5kIEkgYW0gbm90IHN1cmUgdGhlcmUgYXJlIGFu
eSBvdGhlcg0KSGFyZHdhcmUgdGhhdCByZXF1aXJlcyB0aGlzLg0KDQpDb3VsZCB3ZSBwbGVhc2Ug
aGF2ZSB0aGlzIHdpdGggYSBjb21tZW50IGFkZGVkIGluIHRoZSBjb2RlPw0KDQpUaGFua3MsDQpT
aGFtZWVyDQoNCg0K
