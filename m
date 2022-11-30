Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1A263D32E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiK3KTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiK3KTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:19:05 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12401F9E7;
        Wed, 30 Nov 2022 02:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669803514;
        bh=Y3cIjGZ97O9XP5AIXaDxIemDyXTXl8QUtIF01shdqks=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dk/ZCUX67Ra33DGKxMCOtZ1cS/uySNgL5ylLhlw3rnLX0yxSyOMeLHx0tUXZO0i4E
         y5E37IZL04glPKmkfnU7YeiyJe12vzaIfgBgmNcMviDtf0fXb8dbEgHXREAgQQVLhX
         jvK0XfpnN8wOJNy7aeVAZSe2/e8tWcb01cnpT3+HWIsMZTW1HeP4vBMRK83OA6Lg+H
         x1rH9rlvmdH6Bkcw/VUmxaTI6/leV/iwcpvAX8chxqEukirof16t76WvxbLwCh/MgG
         q1Muf0BSGIWUP13sPO6p3GwXjf20fTysP/XhDE3/FuCEfH9NFHY7B+wwFo9lvWHfga
         tvtXJFwVk9DXQ==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>,
        kernel <kernel@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: mfd: da9062: Correct file name for watchdog
Thread-Topic: [PATCH] dt-bindings: mfd: da9062: Correct file name for watchdog
Thread-Index: AQHY/mNV4716Xuj+mEaiujkHazVYGa5V0CiAgAF8zUA=
Date:   Wed, 30 Nov 2022 10:18:25 +0000
Message-ID: <76a965bced9a4d6cb6a294143aa0d32d@dh-electronics.com>
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <20221122111124.6828-2-cniedermaier@dh-electronics.com>
 <ad9720b1-fb9a-e251-bf03-1870a980b0f4@linaro.org>
In-Reply-To: <ad9720b1-fb9a-e251-bf03-1870a980b0f4@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSBbbWFpbHRvOmtyenlzenRvZi5rb3psb3dza2lAbGlu
YXJvLm9yZ10NClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDI5LCAyMDIyIDE6MzQgUE0NCj4gT24g
MjIvMTEvMjAyMiAxMjoxMSwgQ2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4gUmVwbGFj
ZSB0aGUgd2F0Y2hkb2cgZmlsZSBuYW1lIHdpdGggdGhlIG5hbWUgY3VycmVudGx5IGluIHVzZS4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggTmllZGVybWFpZXIgPGNuaWVkZXJtYWll
ckBkaC1lbGVjdHJvbmljcy5jb20+DQo+PiAtLS0NCj4+IENjOiBTdXBwb3J0IE9wZW5zb3VyY2Ug
PHN1cHBvcnQub3BlbnNvdXJjZUBkaWFzZW1pLmNvbT4NCj4+IENjOiBMZWUgSm9uZXMgPGxlZUBr
ZXJuZWwub3JnPg0KPj4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+DQo+PiBD
YzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3Jn
Pg0KPj4gQ2M6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPj4gQ2M6IGtlcm5lbEBkaC1l
bGVjdHJvbmljcy5jb20NCj4+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPj4gVG86
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+IC0tLQ0KPj4gIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvZGE5MDYyLnR4dCB8IDIgKy0NCj4+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9kYTkwNjIudHh0IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9kYTkwNjIudHh0DQo+PiBpbmRleCBiYWIw
ZDBlNjZjYjMuLmU5NjYyOWViOWY0OCAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tZmQvZGE5MDYyLnR4dA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9kYTkwNjIudHh0DQo+PiBAQCAtODUsNyArODUsNyBAQCBT
dWItbm9kZXM6DQo+Pg0KPj4gIC0gb25rZXkgOiBTZWUgLi4vaW5wdXQvZGE5MDYyLW9ua2V5LnR4
dA0KPj4NCj4+IC0tIHdhdGNoZG9nOiBTZWUgLi4vd2F0Y2hkb2cvZGE5MDYyLXdhdGNoZG9nLnR4
dA0KPj4gKy0gd2F0Y2hkb2c6IFNlZSAuLi93YXRjaGRvZy9kYTkwNjItd2R0LnR4dA0KPiANCj4g
SG93IGlzIHRoaXMgcmVsYXRlZCB0byBMRUQgcGF0Y2g/IERvbid0IG1peCB0aHJlYWRzLg0KDQpJ
IGFtIHNvcnJ5LiBJIHVzZWQgZ2l0IHNlbmQtZW1haWwgdGhlIHdyb25nIHdheS4gVGhhbmtzIGZv
ciBwb2ludGluZyB0aGlzIG91dC4NCkRvbid0IGFuc3dlciB0byB0aGlzIEUtTWFpbC4gSSB3aWxs
IHNlbmQgYSBuZXcgcGF0Y2guDQoNCg0KUmVnYXJkcw0KQ2hyaXN0b3BoDQo=
