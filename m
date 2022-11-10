Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E506241FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiKJMKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiKJMKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:10:00 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E110B51
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1668082197;
  x=1699618197;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WSR6XpqRh8FaedVQOxTlNFGrN/2SLbCYEUeIl/JJCws=;
  b=e0VPgmOnAdDfclHPeQHvoJjlWIaSUCMDabsMfHPgnTvW6YPDmr2+DCBv
   Z43SqFYYQ4QPck8JoUFFiEdCwcu+U7jQWA9LL/J0f2PYYJbijW9qUAe2E
   sU33XvgnasvquntRK/mppJgzdnU2/ouRwN9pDx59ot+X9VJ3mEsZLF5Nu
   4zBapVS54qvrJCNnUbDkCWRwmhZUvuPjXeAfeqkYYurkYWj25RVufN2q0
   xmE4vmHc/NQFn7kSGg2MN8qSmw4IbDjsmoAbN5xwXipliIswxySx2nyRm
   3DKq7qwTuCFkfNemGLwZO5HMc575wCFnHtfvkGklgZTmXYDRy8xYNL8CN
   A==;
From:   =?utf-8?B?THVkdmlnIFDDpHJzc29u?= <Ludvig.Parsson@axis.com>
To:     "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        =?utf-8?B?THVkdmlnIFDDpHJzc29u?= <Ludvig.Parsson@axis.com>
CC:     "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: Re: [PATCH] tee: optee: Populate child nodes in probe function
Thread-Topic: [PATCH] tee: optee: Populate child nodes in probe function
Thread-Index: AQHY9FVbeqfP3YVtpkqNWltUYufXla437AcAgAAVOIA=
Date:   Thu, 10 Nov 2022 12:09:53 +0000
Message-ID: <df564dc6ffbddcae12bd345b7a0525e586aba5ed.camel@axis.com>
References: <20221109160708.507481-1-ludvig.parsson@axis.com>
         <CAFA6WYPxTET4mUQ4YHosbPN1o0UthP6PU=t8bAp91GZL+5rjRA@mail.gmail.com>
In-Reply-To: <CAFA6WYPxTET4mUQ4YHosbPN1o0UthP6PU=t8bAp91GZL+5rjRA@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD84F61765274040A96E8796E067C595@exhub.se.axis.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTExLTEwIGF0IDE2OjIzICswNTMwLCBTdW1pdCBHYXJnIHdyb3RlOg0KPiBP
biBXZWQsIDkgTm92IDIwMjIgYXQgMjE6MzcsIEx1ZHZpZyBQw6Ryc3NvbiA8bHVkdmlnLnBhcnNz
b25AYXhpcy5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IEN1cnJlbnRseSB0aGVyZSBpcyBubyBk
ZXBlbmRlbmN5IGJldHdlZW4gdGhlICJsaW5hcm8sc2NtaS1vcHRlZSINCj4gPiBkcml2ZXINCj4g
PiBhbmQgdGhlIHRlZV9jb3JlLiBJZiB0aGUgc2NtaS1vcHRlZSBkcml2ZXIgZ2V0cyBwcm9iZWQg
YmVmb3JlIHRoZQ0KPiA+IHRlZV9idXNfdHlwZSBpcyBpbml0aWFsaXplZCwgdGhlbiB3ZSB3aWxs
IGdldCBhbiB1bndhbnRlZCBlcnJvcg0KPiA+IHByaW50Lg0KPiA+IA0KPiANCj4gV2hhdCBlcnJv
ciBwcmludCBkbyB5b3Ugb2JzZXJ2ZT8gSSBzdXBwb3NlIHRoaXMgY2FzZSBpcyBhbHJlYWR5DQo+
IGhhbmRsZWQgYnkgc2NtaSBvcHRlZSBkcml2ZXIgdmlhIC1FUFJPQkVfREVGRVIuDQo+IA0KPiAt
U3VtaXQNCj4gDQpIaSBTdW1pdCwNCg0KVGhlIGVycm9yIHByaW50IGlzIGluIGRyaXZlcl9yZWdp
c3RlcigpLg0KDQpUaGlzIGlzIGtpbmQgb2Ygd2hhdCBoYXBwZW5zOg0Kc2NtaV9kcml2ZXJfaW5p
dCgpDQpzY21pX3Byb2JlKCkNCiAgICBzY21pX29wdGVlX2xpbmtfc3VwcGxpZXIoKQ0KICAgICAg
ICBzY21pX29wdGVlX2luaXQoKQ0KICAgICAgICAgICAgZHJpdmVyX3JlZ2lzdGVyKCkgPC0tLSBw
cl9lcnIoKSBpZiB0ZWVfYnVzX3R5cGUgaXMgbm90DQppbml0aWFsaXplZA0KdGVlX2luaXQoKSA8
LS0tIHRlZV9idXNfdHlwZSBnZXRzIGluaXRpYWxpemVkIGhlcmUNCg0KVGhlIHNjbWlfb3B0ZWVf
bGlua19zdXBwbGllcigpIHdpbGwgYWx3YXlzIHJldHVybiAtRVBST0JFX0RFRkVSIHRoZQ0KZmly
c3QgdGltZSBiZWNhdXNlIHNjbWlfb3B0ZWVfcHJpdmF0ZSBpcyBpbml0aWFsaXplZCBpbg0Kc2Nt
aV9vcHRlZV9zZXJ2aWNlX3Byb2JlLCB3aGljaCBpcyBvbmx5IGNhbGxlZCBhZnRlciB0aGUgZHJp
dmVyIGlzDQpyZWdpc3RlcmVkIGluIHNjbWlfb3B0ZWVfaW5pdC4gUmlnaHQgbm93IHRoZSBkcml2
ZXJfcmVnaXN0ZXIgZmFpbHMNCmJlY2F1c2UgdGVlX2J1c190eXBlIGlzIG5vdCBpbml0aWFsaXpl
ZCB3aGljaCBpcyBwcmludGluZyB0aGUgdW53YW50ZWQNCmVycm9yIHByaW50LiBBbm90aGVyIHNp
ZGUgZWZmZWN0IG9mIHRoaXMgaXMgdGhhdA0Kc2NtaV9vcHRlZV9saW5rX3N1cHBsaWVyKCkgd2ls
bCByZXR1cm4gLUVQUk9CRV9ERUZFUiBhIHNlY29uZCB0aW1lLCBhbmQNCnNjbWlfcHJvYmUgd2ls
bCBiZSBzdWNjZXNzZnVsIHRoZSB0aGlyZCB0aW1lIGluc3RlYWQgb2YgdGhlIHNlY29uZA0KdGlt
ZS4NCg0KQlIsDQpMdWR2aWcNCg0KPiA+IFRoaXMgcGF0Y2ggZW5hYmxlcyBwdXR0aW5nIHNjbWkt
b3B0ZWUgbm9kZXMgYXMgY2hpbGRyZW4gdG8gdGhlDQo+ID4gb3B0ZWUNCj4gPiBub2RlIGluIGRl
dmljZXRyZWUsIHdoaWNoIGluZGlyZWN0bHkgY3JlYXRlcyB0aGUgbWlzc2luZw0KPiA+IGRlcGVu
ZGVuY3kuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTHVkdmlnIFDDpHJzc29uIDxsdWR2aWcu
cGFyc3NvbkBheGlzLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMvdGVlL29wdGVlL3NtY19h
YmkuYyB8IDUgKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90ZWUvb3B0ZWUvc21jX2FiaS5jDQo+ID4gYi9k
cml2ZXJzL3RlZS9vcHRlZS9zbWNfYWJpLmMNCj4gPiBpbmRleCBhMWMxZmExYTljMjguLmJlNmYw
MmZkNWE3ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3RlZS9vcHRlZS9zbWNfYWJpLmMNCj4g
PiArKysgYi9kcml2ZXJzL3RlZS9vcHRlZS9zbWNfYWJpLmMNCj4gPiBAQCAtMTUzMyw2ICsxNTMz
LDExIEBAIHN0YXRpYyBpbnQgb3B0ZWVfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiA+IMKgwqDCoMKgwqDCoMKgIGlmIChyYykNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZ290byBlcnJfZGlzYWJsZV9zaG1fY2FjaGU7DQo+ID4gDQo+ID4gK8Kg
wqDCoMKgwqDCoCAvKiBQb3B1bGF0ZSBhbnkgZGVwZW5kZW50IGNoaWxkIG5vZGUgKGlmIGFueSkg
Ki8NCj4gPiArwqDCoMKgwqDCoMKgIHJjID0gZGV2bV9vZl9wbGF0Zm9ybV9wb3B1bGF0ZSgmcGRl
di0+ZGV2KTsNCj4gPiArwqDCoMKgwqDCoMKgIGlmIChyYykNCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBnb3RvIGVycl9kaXNhYmxlX3NobV9jYWNoZTsNCj4gPiArDQo+ID4gwqDC
oMKgwqDCoMKgwqAgcHJfaW5mbygiaW5pdGlhbGl6ZWQgZHJpdmVyXG4iKTsNCj4gPiDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gMDsNCj4gPiANCj4gPiAtLQ0KPiA+IDIuMzAuMg0KPiA+IA0KDQo=
