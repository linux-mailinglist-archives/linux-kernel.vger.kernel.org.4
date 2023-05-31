Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E57718ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjEaWwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEaWwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:52:16 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391D8107
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:52:14 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 66C0E2C0274;
        Thu,  1 Jun 2023 10:52:12 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685573532;
        bh=G5su1+wWyrff/Xtt9JuT0Z3YnzFXV2Q2j+hANN/fN4o=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=UJlrp8+PKYdYFWpyzu//CXtCwKvn0LOldK/bUtXtyoi1tvECDDmZ/yt1YBITUw9Hx
         XsKqFQR6un5n4Jn0jkENL91JNWys84C0c1SYPd5DiShuFJ1+VWHxcmrVMZ+/as3z3R
         ld6en2LukvtYB7NPT5SwK+SEXxiMjJoGjs/OETD4G8cQS/PLhBmtCHCZ9Xu1UWIhQl
         R+o6i3fDstLfHXLqL4SxRoVPWa0qcPpfGE8BslDc8D+xdcZAiWc/x0IUvAEdpwDGPU
         qRtKoTxRBihezxJ7EgKo+BkyWa7yX6lLOcB5whZ6ayd6uA9PxBb54lcspcjaM76yx3
         Xi9Mh8lIbaPHw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6477cf9c0001>; Thu, 01 Jun 2023 10:52:12 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 10:52:12 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Thu, 1 Jun 2023 10:52:12 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Conor Dooley <conor@kernel.org>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
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
Thread-Index: AQHZk1IoMAbW60jvr0qoP82+zj4DOK9ziNwAgACsZoA=
Date:   Wed, 31 May 2023 22:52:11 +0000
Message-ID: <4143ad74-db36-e800-df11-19b8c191480f@alliedtelesis.co.nz>
References: <20230530235456.1009082-1-chris.packham@alliedtelesis.co.nz>
 <20230530235456.1009082-4-chris.packham@alliedtelesis.co.nz>
 <20230531-botanical-swoosh-05683af1d3f0@spud>
In-Reply-To: <20230531-botanical-swoosh-05683af1d3f0@spud>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA2D0A4F5F5B0E4F895E3C0888A65839@atlnz.lc>
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

DQpPbiAxLzA2LzIzIDAwOjM1LCBDb25vciBEb29sZXkgd3JvdGU6DQo+IEhleSBDaHJpcywNCj4N
Cj4gT24gV2VkLCBNYXkgMzEsIDIwMjMgYXQgMTE6NTQ6NTVBTSArMTIwMCwgQ2hyaXMgUGFja2hh
bSB3cm90ZToNCj4+IEZyb206IFZhZHltIEtvY2hhbiA8dmFkeW0ua29jaGFuQHBsdmlzaW9uLmV1
Pg0KPj4NCj4+IFN3aXRjaCB0aGUgRFQgYmluZGluZyB0byBhIFlBTUwgc2NoZW1hIHRvIGVuYWJs
ZSB0aGUgRFQgdmFsaWRhdGlvbi4NCj4+DQo+PiBEcm9wcGVkIGRlcHJlY2F0ZWQgY29tcGF0aWJs
ZXMgYW5kIHByb3BlcnRpZXMgZGVzY3JpYmVkIGluIHR4dCBmaWxlLg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IFZhZHltIEtvY2hhbiA8dmFkeW0ua29jaGFuQHBsdmlzaW9uLmV1Pg0KPj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56
Pg0KPj4gLS0tDQo+Pg0KPj4gTm90ZXM6DQo+PiAgICAgIENoYW5nZXMgaW4gdjc6DQo+PiAgICAg
IC0gUmVzdG9yZSAibGFiZWwiIGFuZCAicGFydGl0aW9ucyIgcHJvcGVydGllcyAoc2hvdWxkIGJl
IHBpY2tlZCB1cCB2aWENCj4+ICAgICAgICBuYW5kLWNvbnRyb2xsZXIueWFtbCBidXQgYXJlbid0
KQ0KPj4gICAgICAtIEFkZC9yZXN0b3JlIG5hbmQtb24tZmxhc2gtYmJ0IGFuZCBuYW5kLWVjYy1t
b2RlIHdoaWNoIGFyZW4ndCBjb3ZlcmVkDQo+PiAgICAgICAgYnkgbmFuZC1jb250cm9sbGVyLnlh
bWwuDQo+PiAgICAgIC0gVXNlICJ1bmV2YWxhdXRlZFByb3BlcnRpZXM6IGZhbHNlIg0KPj4gICAg
ICAtIENvcnJlY3Rpb25zIGZvciBjbG9jay1uYW1lcywgZG1hLW5hbWVzLCBuYW5kLXJiIGFuZCBu
YW5kLWVjYy1zdHJlbmd0aA0KPj4gICAgICAtIEFkZCBweGEzeHgtbmFuZC1jb250cm9sbGVyIGV4
YW1wbGUNCj4+ICAgICAgDQo+PiAgICAgIENoYW5nZXMgaW4gdjY6DQo+PiAgICAgIC0gcmVtb3Zl
IHByb3BlcnRpZXMgY292ZXJlZCBieSBuYW5kLWNvbnRyb2xsZXIueWFtbA0KPj4gICAgICAtIGFk
ZCBleGFtcGxlIHVzaW5nIGFybWFkYS04ayBjb21wYXRpYmxlDQo+PiAgICAgIA0KPj4gICAgICBl
YXJsaWVyIGNoYW5nZXM6DQo+PiAgICAgIA0KPj4gICAgICB2NToNCj4+ICAgICAgICAgMSkgR2V0
IGJhY2sgImxhYmVsIiBhbmQgInBhcnRpdGlvbnMiIHByb3BlcnRpZXMgYnV0IHdpdGhvdXQNCj4+
ICAgICAgICAgICAgcmVmIHRvIHRoZSAicGFydGl0aW9uLnlhbWwiIHdoaWNoIHdhcyB3cm9uZ2x5
IHVzZWQuDQo+PiAgICAgIA0KPj4gICAgICAgICAyKSBBZGQgImFkZGl0aW9uYWxQcm9wZXJ0aWVz
OiBmYWxzZSIgZm9yIG5hbmRAIGJlY2F1c2UgYWxsIHBvc3NpYmxlDQo+PiAgICAgICAgICAgIHBy
b3BlcnRpZXMgYXJlIGRlc2NyaWJlZC4NCj4+ICAgICAgDQo+PiAgICAgIHY0Og0KPj4gICAgICAg
ICAxKSBSZW1vdmUgImxhYmVsIiBhbmQgInBhcnRpdGlvbnMiIHByb3BlcnRpZXMNCj4+ICAgICAg
DQo+PiAgICAgICAgIDIpIFVzZSAyIGNsb2NrcyBmb3IgQTdLLzhLIHBsYXRmb3JtIHdoaWNoIGlz
IGEgcmVxdWlyZW1lbnQNCj4+ICAgICAgDQo+PiAgICAgIHYzOg0KPj4gICAgICAgIDEpIFJlbW92
ZSB0eHQgdmVyc2lvbiBmcm9tIHRoZSBNQUlOVEFJTkVSUyBsaXN0DQo+PiAgICAgIA0KPj4gICAg
ICAgIDIpIFVzZSBlbnVtIGZvciBzb21lIG9mIGNvbXBhdGlibGUgc3RyaW5ncw0KPj4gICAgICAN
Cj4+ICAgICAgICAzKSBEcm9wOg0KPj4gICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzDQo+PiAg
ICAgICAgICAgICAgI3NpemUtY2VsbHM6DQo+PiAgICAgIA0KPj4gICAgICAgICAgIGFzIHRoZXkg
YXJlIGluaGVyaXRlZCBmcm9tIHRoZSBuYW5kLWNvbnRyb2xsZXIueWFtbA0KPj4gICAgICANCj4+
ICAgICAgICA0KSBBZGQgcmVzdHJpY3Rpb24gdG8gdXNlIDIgY2xvY2tzIGZvciBBOEsgU29DDQo+
PiAgICAgIA0KPj4gICAgICAgIDUpIERyb3BwZWQgZGVzY3JpcHRpb24gZm9yIGNsb2NrLW5hbWVz
IGFuZCBleHRlbmQgaXQgd2l0aA0KPj4gICAgICAgICAgIG1pbkl0ZW1zOiAxDQo+PiAgICAgIA0K
Pj4gICAgICAgIDYpIERyb3AgZGVzY3JpcHRpb24gZm9yICJkbWFzIg0KPj4gICAgICANCj4+ICAg
ICAgICA3KSBVc2UgInVuZXZhbGF1dGVkUHJvcGVydGllczogZmFsc2UiDQo+PiAgICAgIA0KPj4g
ICAgICAgIDgpIERyb3AgcXVpdGVzIGZyb20geWFtbCByZWZzLg0KPj4gICAgICANCj4+ICAgICAg
ICA5KSBVc2UgNC1zcGFjZSBpbmRlbnRhdGlvbiBmb3IgdGhlIGV4YW1wbGUgc2VjdGlvbg0KPj4g
ICAgICANCj4+ICAgICAgdjI6DQo+PiAgICAgICAgMSkgRml4ZWQgd2FybmluZyBieSB5YW1sbGlu
dCB3aXRoIGluY29ycmVjdCBpbmRlbnRhdGlvbiBmb3IgY29tcGF0aWJsZSBsaXN0DQo+Pg0KPj4g
ICAuLi4vYmluZGluZ3MvbXRkL21hcnZlbGwsbmFuZC1jb250cm9sbGVyLnlhbWwgfCAyMjEgKysr
KysrKysrKysrKysrKysrDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9tYXJ2ZWxs
LW5hbmQudHh0ICB8IDEyNiAtLS0tLS0tLS0tDQo+PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAtDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMjIx
IGluc2VydGlvbnMoKyksIDEyNyBkZWxldGlvbnMoLSkNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWFydmVsbCxuYW5kLWNvbnRy
b2xsZXIueWFtbA0KPj4gICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL210ZC9tYXJ2ZWxsLW5hbmQudHh0DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWFydmVsbCxuYW5kLWNvbnRyb2xs
ZXIueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWFydmVsbCxu
YW5kLWNvbnRyb2xsZXIueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAw
MDAwMDAwMDAwMC4uN2NkNGEyZTk5MzQzDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL21hcnZlbGwsbmFuZC1jb250cm9sbGVy
LnlhbWwNCj4+IEBAIC0wLDAgKzEsMjIxIEBADQo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+PiArJVlBTUwgMS4yDQo+PiArLS0t
DQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9tdGQvbWFydmVsbCxuYW5k
LWNvbnRyb2xsZXIueWFtbCMNCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0
YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+ICsNCj4+ICt0aXRsZTogTWFydmVsbCBOQU5EIEZsYXNo
IENvbnRyb2xsZXIgKE5GQykNCj4+ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gTWlxdWVs
IFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4+ICsNCj4+ICtwcm9wZXJ0aWVz
Og0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgb25lT2Y6DQo+PiArICAgICAgLSBpdGVtczoN
Cj4+ICsgICAgICAgICAgLSBjb25zdDogbWFydmVsbCxhcm1hZGEtOGstbmFuZC1jb250cm9sbGVy
DQo+PiArICAgICAgICAgIC0gY29uc3Q6IG1hcnZlbGwsYXJtYWRhMzcwLW5hbmQtY29udHJvbGxl
cg0KPiBBcG9sb2dpZXMgaWYgSSBoYXZlIG1pc3NlZCB0aGlzIC0gYnV0IHRoZSBjb21taXQgbWVz
c2FnZSBzaG91bGQgcHJvYmFibHkNCj4gZXhwbGFpbiB3aGVyZSB0aGlzIGZhbGxiYWNrIGNhbWUg
ZnJvbSBzaW5jZSBpdCBkb2VzIG5vdCBhcHBlYXIgdG8gYmUNCj4gcHJlc2VudCBpbiB0aGUgb3Jp
Z2luYWwgYmluZGluZy4NClllcyBJJ2xsIG1lbnRpb24gaXQuDQo+PiArICAgICAgLSBlbnVtOg0K
Pj4gKyAgICAgICAgICAtIG1hcnZlbGwsYXJtYWRhMzcwLW5hbmQtY29udHJvbGxlcg0KPj4gKyAg
ICAgICAgICAtIG1hcnZlbGwscHhhM3h4LW5hbmQtY29udHJvbGxlcg0KPj4gKyAgICAgICAgICAt
IG1hcnZlbGwsYXJtYWRhLThrLW5hbmQNCj4+ICsgICAgICAgICAgLSBtYXJ2ZWxsLGFybWFkYTM3
MC1uYW5kDQo+PiArICAgICAgICAgIC0gbWFydmVsbCxweGEzeHgtbmFuZA0KPiBQbGVhc2UgbWFy
ayB0aGVzZSAzIGFzIGRlcHJlY2F0ZWQuDQpXaWxsIGRvDQo+PiArDQo+PiArICByZWc6DQo+PiAr
ICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBpbnRlcnJ1cHRzOg0KPj4gKyAgICBtYXhJdGVt
czogMQ0KPj4gKw0KPj4gKyAgY2xvY2tzOg0KPj4gKyAgICBkZXNjcmlwdGlvbjoNCj4+ICsgICAg
ICBTaGFsbCByZWZlcmVuY2UgdGhlIE5BTkQgY29udHJvbGxlciBjbG9ja3MsIHRoZSBzZWNvbmQg
b25lIGlzDQo+PiArICAgICAgaXMgb25seSBuZWVkZWQgZm9yIHRoZSBBcm1hZGEgN0svOEsgU29D
cw0KPiBBcyBhIG5pdCwgYWxsT2YgYmVsb3cgaW52YWxpZGF0ZXMgdGhpcyBzZWNvbmQgcGFydCBv
ZiB0aGUgc2VudGVuY2UgKGluDQo+IHBvc3NpYmx5IGEgY2xlYXJlciB3YXkgdG9vKS4NCkknbSBu
b3QgcXVpdGUgc3VyZSB3aGF0IHlvdSBtZWFuLiBJcyBpdCBqdXN0IHRoYXQgdGhlIGRlc2NyaXB0
aW9uIGlzIA0KcmVkdW5kYW50IG5vdyB0aGF0IHRoZSBzY2hlbWEgZW5mb3JjZXMgdGhlIHJlcXVp
cmVtZW50IG9yIGFtIEkgYWN0dWFsbHkgDQpub3QgZW5mb3JjaW5nIHRoaW5ncyB0aGUgd2F5IEkg
dGhpbmsuDQo+PiArICAgIG1pbkl0ZW1zOiAxDQo+PiArICAgIG1heEl0ZW1zOiAyDQo+PiArDQo+
PiArICBjbG9jay1uYW1lczoNCj4+ICsgICAgbWluSXRlbXM6IDENCj4+ICsgICAgaXRlbXM6DQo+
PiArICAgICAgLSBjb25zdDogY29yZQ0KPj4gKyAgICAgIC0gY29uc3Q6IHJlZw0KPj4gKw0KPj4g
KyAgZG1hczoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGRtYS1uYW1lczoNCj4+
ICsgICAgaXRlbXM6DQo+PiArICAgICAgLSBlbnVtOg0KPiBJIGRvbid0IHRoaW5rIHRoZSBpdGVt
czogaGVyZSBpcyBuZWVkZWQsIGVudW0gb24gaXRzIG93biBzdWZmaWNlcywgbm8/DQoNClRoZSB0
cmVuZCBpbiBvdGhlciBiaW5kaW5ncyBzZWVtcyB0byBiZQ0KDQogwqAgaXRlbXM6DQogwqAgwqDC
oCAtIGNvbnN0OiB2YWx1ZTENCiDCoMKgwqDCoCAtIGNvbnN0OiB2YWx1ZTINCg0Kc28gSSdsbCBn
byB3aXRoIHRoYXQuDQoNCj4NCj4gQ2hlZXJzLA0KPiBDb25vci4=
