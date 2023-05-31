Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FBF718EB1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjEaWnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjEaWnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:43:50 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D4D9F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:43:48 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 25BD12C0274;
        Thu,  1 Jun 2023 10:43:47 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685573027;
        bh=ODkHDBMzn3prvfeednZ/XfpWu2daBvR6MQnbPOCcr9Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=m2pTps4d+e2qfepLh2vl/T6OZJpinYryQEo/owcll1jTrz95zdySPydmgyeWzIBF0
         dZlPkQLx2B+k6q1JV2HE9wP3MtyebYyCSmnk+YQwQhPBwXAD+YJtPjoBsPApxIcaaO
         isociIMkS01q+mpdxR0GBvf4tsKFnIJUfOBwbk2HA75NvG8s2oO5NHt63Xk+SE8YbQ
         263qyk6KjhCY/TnGjxWMRX90L6QPvz7TOVsCTIrIKA7QuLfrsQw1qkd2DPtm/PS+rG
         uMUTgOANVUMBuwBFVqQQkM3XKFG1VzvdPeQNf4r5PcbQ+dVQowfpyH/USpRg10G3CV
         G+uz3E0dWqbHw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6477cda30000>; Thu, 01 Jun 2023 10:43:47 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 10:43:46 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Thu, 1 Jun 2023 10:43:46 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v7 3/4] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Thread-Topic: [PATCH v7 3/4] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Thread-Index: AQHZk1IoMAbW60jvr0qoP82+zj4DOK90MugA
Date:   Wed, 31 May 2023 22:43:46 +0000
Message-ID: <40bb4ad8-2bec-4eae-d0c8-c9aa31e03f32@alliedtelesis.co.nz>
References: <20230530235456.1009082-1-chris.packham@alliedtelesis.co.nz>
 <20230530235456.1009082-4-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20230530235456.1009082-4-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D81B5783BFD2D41A00284EF5D509ECE@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Score: -1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQpPbiAzMS8wNS8yMyAxMTo1NCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4g
RnJvbTogVmFkeW0gS29jaGFuIDx2YWR5bS5rb2NoYW5AcGx2aXNpb24uZXU+DQo+DQo+IFN3aXRj
aCB0aGUgRFQgYmluZGluZyB0byBhIFlBTUwgc2NoZW1hIHRvIGVuYWJsZSB0aGUgRFQgdmFsaWRh
dGlvbi4NCj4NCj4gRHJvcHBlZCBkZXByZWNhdGVkIGNvbXBhdGlibGVzIGFuZCBwcm9wZXJ0aWVz
IGRlc2NyaWJlZCBpbiB0eHQgZmlsZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogVmFkeW0gS29jaGFu
IDx2YWR5bS5rb2NoYW5AcGx2aXNpb24uZXU+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2to
YW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4gLS0tDQo8c25pcD4NCj4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWFydmVs
bCxuYW5kLWNvbnRyb2xsZXIueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tdGQvbWFydmVsbCxuYW5kLWNvbnRyb2xsZXIueWFtbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjdjZDRhMmU5OTM0Mw0KPiAtLS0gL2Rldi9udWxsDQo+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWFydmVsbCxuYW5k
LWNvbnRyb2xsZXIueWFtbA0KPiBAQCAtMCwwICsxLDIyMSBAQA0KPiArIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ICslWUFNTCAxLjIN
Cj4gKy0tLQ0KPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9tdGQvbWFydmVs
bCxuYW5kLWNvbnRyb2xsZXIueWFtbCMNCj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiArDQo+ICt0aXRsZTogTWFydmVsbCBOQU5EIEZs
YXNoIENvbnRyb2xsZXIgKE5GQykNCj4gKw0KPiArbWFpbnRhaW5lcnM6DQo+ICsgIC0gTWlxdWVs
IFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gKw0KPiArcHJvcGVydGllczoN
Cj4gKyAgY29tcGF0aWJsZToNCj4gKyAgICBvbmVPZjoNCj4gKyAgICAgIC0gaXRlbXM6DQo+ICsg
ICAgICAgICAgLSBjb25zdDogbWFydmVsbCxhcm1hZGEtOGstbmFuZC1jb250cm9sbGVyDQo+ICsg
ICAgICAgICAgLSBjb25zdDogbWFydmVsbCxhcm1hZGEzNzAtbmFuZC1jb250cm9sbGVyDQoNCk9u
IHRoaXMgc3BlY2lmaWMgcG9pbnQuIFdhcyB5b3VyIGludGVudGlvbiB0byBhbGxvdyBqdXN0IHRo
ZSANCiJtYXJ2ZWxsLGFybWFkYS04ay1uYW5kLWNvbnRyb2xsZXIiIGNvbXBhdGlibGU/DQoNCkkg
bWFkZSBpdCBhIGxpc3QgYXMgdGhlIGV4aXN0aW5nIHVzYWdlIGlzIGBjb21wYXRpYmxlID0gDQoi
bWFydmVsbCxhcm1hZGEtOGstbmFuZC1jb250cm9sbGVyIiwgDQoibWFydmVsbCxhcm1hZGEzNzAt
bmFuZC1jb250cm9sbGVyIjtgIGJ1dCBhbiBlYXJsaWVyIGNvbW1lbnQgeW91IG1hZGUgDQpzdWdn
ZXN0ZWQgdGhhdCB5b3VyIGludGVudGlvbiB3YXMgdG8gYWxsb3cganVzdCB0aGUgOGsgY29tcGF0
aWJsZSBvbiANCml0J3Mgb3duLiBMb29raW5nIGF0IHRoZSBkcml2ZXIgaXQgZG9lc24ndCBkbyBh
bnkgaXNfY29tcGF0aWJsZSgpIGNoZWNrcyANCnNvIEkgZG9uJ3QgdGhpbmsgaXQgY2FyZXMgKGN1
cnJlbnRseSkuDQoNCj4gKyAgICAgIC0gZW51bToNCj4gKyAgICAgICAgICAtIG1hcnZlbGwsYXJt
YWRhMzcwLW5hbmQtY29udHJvbGxlcg0KPiArICAgICAgICAgIC0gbWFydmVsbCxweGEzeHgtbmFu
ZC1jb250cm9sbGVyDQo+ICsgICAgICAgICAgLSBtYXJ2ZWxsLGFybWFkYS04ay1uYW5kDQo+ICsg
ICAgICAgICAgLSBtYXJ2ZWxsLGFybWFkYTM3MC1uYW5kDQo+ICsgICAgICAgICAgLSBtYXJ2ZWxs
LHB4YTN4eC1uYW5kDQo+ICs=
