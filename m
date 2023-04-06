Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3F6D9CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbjDFP4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbjDFP4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:56:16 -0400
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E68919B;
        Thu,  6 Apr 2023 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680796540;
        bh=GhPn2yoiJZiYnRLmYZe/b7SZ66ptMTryzBnkmgogbeM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MwjpQm3xLYPaaFWc5pnmsPt73AKwvZH/j7NY3/UQqeqGqiugA3mG4AapgiktMxvHQ
         dqKkyOqspDmPtoJR1oG2ONx7ZWtzRzX+vOJ1pitJ6iL1DvTCpEPHSWkO+dWDSQjrMo
         tXQx/aZNjTt9CHY/AZ7sEXKdvy+zli7EE2BHfqSLMY/RWAv6BElmpmCF1W70MoGIjT
         uhz5n2IECqIob/e+XbmNc5gd4s2dZqQRKAjpTp/bkXAHTD0panvGJEVgl5bGDy/THZ
         eVZZQbrTMmE6zNZsDYP6chhNJb/LC3+KhTaIw66hC1YrbMr9mDyDZi2+LYzVA1IYUO
         kW8LZ9nD6CWWw==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel <kernel@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] dt-bindings: arm: fsl: Add Marantec maveo box as a
 DHCOR i.MX6ULL SoM based board
Thread-Topic: [PATCH 2/3] dt-bindings: arm: fsl: Add Marantec maveo box as a
 DHCOR i.MX6ULL SoM based board
Thread-Index: AQHZaJ764au6gDoXdUeT2yZ0coOJZK8ebuvw
Date:   Thu, 6 Apr 2023 15:55:31 +0000
Message-ID: <fe37297a2aa248c6af42251eaf35a39c@dh-electronics.com>
References: <20230406154529.6349-1-cniedermaier@dh-electronics.com>
 <20230406154529.6349-2-cniedermaier@dh-electronics.com>
In-Reply-To: <20230406154529.6349-2-cniedermaier@dh-electronics.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hyaXN0b3BoIE5pZWRlcm1haWVyIFttYWlsdG86Y25pZWRlcm1haWVyQGRoLWVsZWN0
cm9uaWNzLmNvbV0NClNlbnQ6IFRodXJzZGF5LCBBcHJpbCA2LCAyMDIzIDU6NDUgUE0NCj4gDQo+
IEFkZCBNYXJhbnRlYyBtYXZlbyBib3guIFRoZSBzeXN0ZW0gaXMgdXNlZCB0byBnZXQgYSBzbWFy
dCBjb25udGVjdGlvbg0KPiB0byBhIGRvb3IgZHJpdmUuIFRoZSBjb3JlIG9mIHRoaXMgc3lzdGVt
IGlzIGEgc29sZGVyZWQgaS5NWDZVTEwgREhDT1INCj4gU29NIGZyb20gREggZWxlY3Ryb25pY3Mu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggTmllZGVybWFpZXIgPGNuaWVkZXJtYWll
ckBkaC1lbGVjdHJvbmljcy5jb20+DQo+IC0tLQ0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRA
a2VybmVsLm9yZz4NCj4gQ2M6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dz
a2krZHRAbGluYXJvLm9yZz4NCj4gQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4N
Cj4gQ0M6IExpIFlhbmcgPGxlb3lhbmcubGlAbnhwLmNvbT4NCj4gQ2M6IE1hcmVrIFZhc3V0IDxt
YXJleEBkZW54LmRlPg0KPiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZGVueC5kZT4NCj4g
Q2M6IE5YUCBMaW51eCBUZWFtIDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gQ2M6IGtlcm5lbEBkaC1l
bGVjdHJvbmljcy5jb20NCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFRvOiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gLS0tDQo+IFYyOiAtIENvcnJlY3QgdGhlIHZlbmRvciBwcmVmaXgN
Cj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1s
IHwgNiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1s
DQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiBp
bmRleCBiMTc1ZjJiMWJkMzAuLmZjMWJmNDNhYjU0ZCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQo+IEBAIC03MTcsNiArNzE3LDEy
IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgICAgICAgLSBjb25zdDogZGgsaW14NnVsbC1kaGNvci1z
b20NCj4gICAgICAgICAgICAtIGNvbnN0OiBmc2wsaW14NnVsbA0KPiANCj4gKyAgICAgIC0gZGVz
Y3JpcHRpb246IGkuTVg2VUxMIERIQ09SIFNvTSBiYXNlZCBCb2FyZHMNCj4gKyAgICAgICAgaXRl
bXM6DQo+ICsgICAgICAgICAgLSBjb25zdDogbWFyYW50ZWMsaW14NnVsbC1kaGNvci1tYXZlby1i
b3gNCj4gKyAgICAgICAgICAtIGNvbnN0OiBkaCxpbXg2dWxsLWRoY29yLXNvbQ0KPiArICAgICAg
ICAgIC0gY29uc3Q6IGZzbCxpbXg2dWxsDQo+ICsNCj4gICAgICAgIC0gZGVzY3JpcHRpb246IGku
TVg2VUxMIFBIWVRFQyBwaHlCT0FSRC1TZWdpbg0KPiAgICAgICAgICBpdGVtczoNCj4gICAgICAg
ICAgICAtIGVudW06DQo+IC0tDQo+IDIuMTEuMA0KDQpJZ25vcmUgdGhpcyBwYXRjaCwgSSBmb3Jn
b3QgdGhlIFYyIHByZWZpeC4NCg==
