Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E9863D36A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbiK3Kan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbiK3KaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:30:21 -0500
X-Greylist: delayed 591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 02:30:18 PST
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5D741999;
        Wed, 30 Nov 2022 02:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669803245;
        bh=Xz3jaEkv4PN5ryRyzvRWZ3Or1VE5t+AzW95bckbQGzc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VOvsT7ReTvIa/LsRMZUV2oJ2vhW7eydwZwLiJ3TuyfqXw+XZuWkCg2GEgDGU/K6o/
         7XXBWkJ9+dYGkcYvPPEYocYG0EWSsudEMmPNvp84q7GTn8Jfpba5tzzX+6zGlX0AOs
         TGXdARx2soxIKwBbDcny8ZB+L9L9863JH4QKgHtFN3EV+qZh/NXA5ldrOpniR6/dNd
         d3TsfZDDLAoPYzBKStjOucQTL/gjRhqv+xe6FBsm5L57Gps2rlawLTs8SN7r3RdazG
         ISDACKo/j+ph6ie8iIjLVkjdBc1/32MLptxMdxHFwBGiDdC4UoRtDTm5fUQphQMmax
         3dZ+waDvq5eiA==
X-secureTransport-forwarded: yes
From:   kernel <kernel@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Support Opensource" <support.opensource@diasemi.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>,
        kernel <kernel@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: mfd: da9062: Correct file name for watchdog
Thread-Topic: [PATCH] dt-bindings: mfd: da9062: Correct file name for watchdog
Thread-Index: AQHY/mNV4716Xuj+mEaiujkHazVYGa5V0CiAgAFqKwCAAAEJwA==
Date:   Wed, 30 Nov 2022 10:13:55 +0000
Message-ID: <a9c29522997f4688b9f28646e978f41c@dh-electronics.com>
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <20221122111124.6828-2-cniedermaier@dh-electronics.com>
 <ad9720b1-fb9a-e251-bf03-1870a980b0f4@linaro.org>
 <Y4csBBZ3OnpXS5TR@google.com>
In-Reply-To: <Y4csBBZ3OnpXS5TR@google.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
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

RnJvbTogTGVlIEpvbmVzIFttYWlsdG86bGVlQGtlcm5lbC5vcmddDQpTZW50OiBXZWRuZXNkYXks
IE5vdmVtYmVyIDMwLCAyMDIyIDExOjEwIEFNDQo+IE9uIFR1ZSwgMjkgTm92IDIwMjIsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+IA0KPj4gT24gMjIvMTEvMjAyMiAxMjoxMSwgQ2hyaXN0
b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4+IFJlcGxhY2UgdGhlIHdhdGNoZG9nIGZpbGUgbmFt
ZSB3aXRoIHRoZSBuYW1lIGN1cnJlbnRseSBpbiB1c2UuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RvcGggTmllZGVybWFpZXIgPGNuaWVkZXJtYWllckBkaC1lbGVjdHJvbmljcy5jb20+
DQo+Pj4gLS0tDQo+Pj4gQ2M6IFN1cHBvcnQgT3BlbnNvdXJjZSA8c3VwcG9ydC5vcGVuc291cmNl
QGRpYXNlbWkuY29tPg0KPj4+IENjOiBMZWUgSm9uZXMgPGxlZUBrZXJuZWwub3JnPg0KPj4+IENj
OiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPg0KPj4+IENjOiBLcnp5c3p0b2YgS296
bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+DQo+Pj4gQ2M6IE1hcmVr
IFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPj4+IENjOiBrZXJuZWxAZGgtZWxlY3Ryb25pY3MuY29t
DQo+Pj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+Pj4gVG86IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4+PiAtLS0NCj4+PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21mZC9kYTkwNjIudHh0IHwgMiArLQ0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2RhOTA2Mi50eHQgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2RhOTA2Mi50eHQNCj4+PiBpbmRleCBiYWIwZDBlNjZj
YjMuLmU5NjYyOWViOWY0OCAxMDA2NDQNCj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWZkL2RhOTA2Mi50eHQNCj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWZkL2RhOTA2Mi50eHQNCj4+PiBAQCAtODUsNyArODUsNyBAQCBTdWIt
bm9kZXM6DQo+Pj4NCj4+PiAgLSBvbmtleSA6IFNlZSAuLi9pbnB1dC9kYTkwNjItb25rZXkudHh0
DQo+Pj4NCj4+PiAtLSB3YXRjaGRvZzogU2VlIC4uL3dhdGNoZG9nL2RhOTA2Mi13YXRjaGRvZy50
eHQNCj4+PiArLSB3YXRjaGRvZzogU2VlIC4uL3dhdGNoZG9nL2RhOTA2Mi13ZHQudHh0DQo+Pg0K
Pj4gSG93IGlzIHRoaXMgcmVsYXRlZCB0byBMRUQgcGF0Y2g/IERvbid0IG1peCB0aHJlYWRzLg0K
PiANCj4gUXVlPw0KPiANCj4gICBbUEFUQ0hdIGR0LWJpbmRpbmdzOiBtZmQ6IGRhOTA2MjogQ29y
cmVjdCBmaWxlIG5hbWUgZm9yIHdhdGNoZG9nDQo+IA0KPiAtLQ0KPiBMZWUgSm9uZXMgW+adjueQ
vOaWr10NCg0KSSBhbSBzb3JyeS4gSSB1c2VkIGdpdCBzZW5kLWVtYWlsIHRoZSB3cm9uZyB3YXku
IFRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuDQpEb24ndCBhbnN3ZXIgdG8gdGhpcyBFLU1h
aWwuIEkgd2lsbCBzZW5kIGEgbmV3IHBhdGNoLg0KDQoNClJlZ2FyZHMNCkNocmlzdG9waA0K
