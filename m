Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF511732150
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjFOVGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjFOVGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:06:19 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4955B184
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:06:16 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E54342C03DA;
        Fri, 16 Jun 2023 09:06:12 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1686863172;
        bh=SJORa6w3ccYV408Vqt+utFhLfjPKwke9Ih59IiX92jo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=H81Q23ZTJWdJVKBg0ixrut/RhVw+GgIkwNxQzV/0T4CfFFtBwWje5E8MZ9uCWI0Ah
         cUV/cRFFS8BLaQhqjkCWG2MWYJ1qZcc6xBbo0tN/CEvEQrOtMA9hv80BCAfct9Hoel
         CCBCFpVIoGXQCVQ2vYco0UjFw2d//jRbbVPnrIRgdTgWq8ChgNDnrKJNMRgRwGgK0O
         9dJPIVT8MVf88KJs5GatvbpZOZD2PEu6wuT5VHpwn6G/Sk4lpQF4+/zbzcYMXNpEat
         rCj64OR1oYCWc/Vsep0AbA3piS40pa0Cd3YJ+L+q8NL7C+2KWvz5bZObiyhb2exs0F
         n1f85fSqpLZ6g==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B648b7d440001>; Fri, 16 Jun 2023 09:06:12 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.30; Fri, 16 Jun 2023 09:06:12 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Fri, 16 Jun 2023 09:06:12 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.030; Fri, 16 Jun 2023 09:06:12 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v9 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Thread-Topic: [PATCH v9 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Thread-Index: AQHZnz6KyypKHONfy0GlUm129g+x+6+KswMAgADfwYA=
Date:   Thu, 15 Jun 2023 21:06:12 +0000
Message-ID: <1863cd53-9846-def2-ee5f-f4a51160ed8d@alliedtelesis.co.nz>
References: <20230615040447.3484564-1-chris.packham@alliedtelesis.co.nz>
 <20230615040447.3484564-4-chris.packham@alliedtelesis.co.nz>
 <f16e742f-e6f2-9761-e70d-e0e7cadcba4a@linaro.org>
In-Reply-To: <f16e742f-e6f2-9761-e70d-e0e7cadcba4a@linaro.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D364D9AA48BCD4FA426D9C37648FD18@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=NPqrBHyg c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10 a=g8kJ_gb0AAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=pr6tp4WARypXyZtOCmcA:9 a=QEXdDO2ut3YA:10 a=ecSNLfPMzbq-p5zXJZOg:22 a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiAxNS8wNi8yMyAxOTo0NSwgS3J6eXN6dG9mIEtvemxvd3NraSB3
cm90ZToNCj4gT24gMTUvMDYvMjAyMyAwNjowNCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IEZy
b206IFZhZHltIEtvY2hhbiA8dmFkeW0ua29jaGFuQHBsdmlzaW9uLmV1Pg0KPj4NCj4+IFN3aXRj
aCB0aGUgRFQgYmluZGluZyB0byBhIFlBTUwgc2NoZW1hIHRvIGVuYWJsZSB0aGUgRFQgdmFsaWRh
dGlvbi4NCj4+DQo+PiBUaGUgdGV4dCBiaW5kaW5nIGRpZG4ndCBtZW50aW9uIGl0IGFzIGEgcmVx
dWlyZW1lbnQgYnV0IGV4aXN0aW5nIHVzYWdlDQo+PiBoYXMNCj4+DQo+PiAgICAgY29tcGF0aWJs
ZSA9ICJtYXJ2ZWxsLGFybWFkYS04ay1uYW5kLWNvbnRyb2xsZXIiLA0KPj4gICAgICAgICAgICAg
ICAgICAibWFydmVsbCxhcm1hZGEzNzAtbmFuZC1jb250cm9sbGVyIjsNCj4+DQo+PiBzbyB0aGUg
WUFNTCBhbGxvd3MgdGhpcyBpbiBhZGRpdGlvbiB0byB0aGUgaW5kaXZpZHVhbCBjb21wYXRpYmxl
IHZhbHVlcy4NCj4+DQo+PiBUaGVyZSB3YXMgYWxzbyBhbiBpbmNvcnJlY3QgcmVmZXJlbmNlIHRv
IGRtYS1uYW1lcyBiZWluZyAicnh0eCIgd2hlcmUNCj4+IHRoZSBkcml2ZXIgYW5kIGV4aXN0aW5n
IGRldmljZSB0cmVlcyBhY3R1YWxseSB1c2UgZG1hLW5hbWVzID0gImRhdGEiIHNvDQo+PiB0aGlz
IGlzIGNvcnJlY3RlZCBpbiB0aGUgY29udmVyc2lvbi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBW
YWR5bSBLb2NoYW4gPHZhZHltLmtvY2hhbkBwbHZpc2lvbi5ldT4NCj4+IFNpZ25lZC1vZmYtYnk6
IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+IC0t
LQ0KPj4NCj4+IE5vdGVzOg0KPj4gICAgICBDaGFuZ2VzIGluIHY5Og0KPj4gICAgICAtIGRlcGVu
ZCBvbiBzZXJpZXMgZnJvbSBNaXF1ZWwgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbXRk
LzIwMjMwNjA2MTc1MjQ2LjE5MDQ2NS0xLW1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20vDQo+PiAg
ICAgIC0gZW5mb3JjZSBtaW5pbXVtL21heGltdW0gZm9yIG5hbmQtcmINCj4+ICAgICAgLSBtb3Zl
IHJlcXVpcmVkOiBibG9jayBmb3IgY29udHJvbGxlcg0KPj4gICAgICAtIG1vdmUgdW5ldmFsdWF0
ZWRQcm9wZXJ0aWVzOiBmb3IgbmFuZCBjaGlwDQo+PiAgICAgIC0gcmVtb3ZlIGxhYmVsLCBwYXJ0
aXRpb25zIGFuZCBuYW5kLW9uLWZsYXNoLWJidCB3aGljaCBhcmUgY292ZXJlZCBieQ0KPj4gICAg
ICAgIGdlbmVyaWMgc2NoZW1hDQo+PiAgICAgIA0KPj4gICAgICBDaGFuZ2VzIGluIHY4Og0KPj4g
ICAgICAtIE1hcmsgZGVwcmVjYXRlZCBjb21wYXRpYmxlIHZhbHVlcyBhcyBzdWNoDQo+PiAgICAg
IC0gQWxsb3cgIm1hcnZlbGwsYXJtYWRhLThrLW5hbmQtY29udHJvbGxlciIgd2l0aG91dA0KPj4g
ICAgICAgICJtYXJ2ZWxsLGFybWFkYTM3MC1uYW5kLWNvbnRyb2xsZXIiDQo+ID8/Pw0KPg0KPg0K
Pj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBvbmVPZjoN
Cj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFk
YS04ay1uYW5kLWNvbnRyb2xsZXINCj4+ICsgICAgICAgICAgLSBjb25zdDogbWFydmVsbCxhcm1h
ZGEzNzAtbmFuZC1jb250cm9sbGVyDQo+PiArICAgICAgLSBlbnVtOg0KPj4gKyAgICAgICAgICAt
IG1hcnZlbGwsYXJtYWRhLThrLW5hbmQtY29udHJvbGxlcg0KPiBUaGlzIGlzIHdyb25nLiA4ayBj
YW5ub3QgYmUgYm90aDogY29tcGF0aWJsZSBhbmQgbm90IGNvbXBhdGlibGUgd2l0aA0KPiAzNzAu
IEl0J3Mgbm90IHNvbWVvbmUncyBjYXQgdG8gYmUgaW4gYm90aCBzdGF0ZXMgYXQgdGhlIHNhbWUg
dGltZS4uLg0KDQpUaGUgY29ycmVjdCBzdGF0ZSAoSU1ITywgTWlxdWVsIGNvcnJlY3QgbWUgaWYg
SSdtIHdyb25nKSBpcyBgY29tcGF0aWJsZSANCj0gIm1hcnZlbGwsYXJtYWRhLThrLW5hbmQtY29u
dHJvbGxlciI7YMKgIGFzIHRoZXJlIGFyZSBzb21lIDhLIHNwZWNpZmljIA0KcmVxdWlyZW1lbnRz
IHRoYXQgYXJlbid0IHByZXNlbnQgb24gdGhlIDM3MCAoc3BlY2lmaWNhbGx5IHRoZSANCnN5c3Rl
bS1jb250cm9sbGVyIGFuZCB0aGUgMm5kIGNsb2NrKS4gVGhlIG9ubHkgcmVhc29uIGBjb21wYXRp
YmxlID0gDQoibWFydmVsbCxhcm1hZGEtOGstbmFuZC1jb250cm9sbGVyIiwgDQoibWFydmVsbCxh
cm1hZGEzNzAtbmFuZC1jb250cm9sbGVyIjtgIGlzIHN1cHBvcnRlZCBpcyBiZWNhdXNlIHRoYXQg
aXMgDQp3aGF0IGlzIGluIHVzZSBpbiB0aGUgZXhpc3RpbmcgZHRzZXMuDQoNCj4+ICsgICAgICAg
ICAgLSBtYXJ2ZWxsLGFybWFkYTM3MC1uYW5kLWNvbnRyb2xsZXINCj4+ICsgICAgICAgICAgLSBt
YXJ2ZWxsLHB4YTN4eC1uYW5kLWNvbnRyb2xsZXINCj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBs
ZWdhY3kgYmluZGluZ3MNCj4+ICsgICAgICAgIGRlcHJlY2F0ZWQ6IHRydWUNCj4+ICsgICAgICAg
IGVudW06DQo+PiArICAgICAgICAgIC0gbWFydmVsbCxhcm1hZGEtOGstbmFuZA0KPj4gKyAgICAg
ICAgICAtIG1hcnZlbGwsYXJtYWRhMzcwLW5hbmQNCj4+ICsgICAgICAgICAgLSBtYXJ2ZWxsLHB4
YTN4eC1uYW5kDQo+PiArDQo+PiArICByZWc6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+
PiArICBpbnRlcnJ1cHRzOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgY2xvY2tz
Og0KPj4gKyAgICBkZXNjcmlwdGlvbjoNCj4+ICsgICAgICBTaGFsbCByZWZlcmVuY2UgdGhlIE5B
TkQgY29udHJvbGxlciBjbG9ja3MsIHRoZSBzZWNvbmQgb25lIGlzDQo+PiArICAgICAgaXMgb25s
eSBuZWVkZWQgZm9yIHRoZSBBcm1hZGEgN0svOEsgU29Dcw0KPj4gKyAgICBtaW5JdGVtczogMQ0K
Pj4gKyAgICBtYXhJdGVtczogMg0KPj4gKw0KPj4gKyAgY2xvY2stbmFtZXM6DQo+PiArICAgIG1p
bkl0ZW1zOiAxDQo+PiArICAgIGl0ZW1zOg0KPj4gKyAgICAgIC0gY29uc3Q6IGNvcmUNCj4+ICsg
ICAgICAtIGNvbnN0OiByZWcNCj4+ICsNCj4+ICsgIGRtYXM6DQo+PiArICAgIG1heEl0ZW1zOiAx
DQo+PiArDQo+PiArICBkbWEtbmFtZXM6DQo+PiArICAgIGl0ZW1zOg0KPj4gKyAgICAgIC0gY29u
c3Q6IGRhdGENCj4+ICsNCj4+ICsgIG1hcnZlbGwsc3lzdGVtLWNvbnRyb2xsZXI6DQo+PiArICAg
ICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUNCj4+ICsgICAg
ZGVzY3JpcHRpb246IFN5c2NvbiBub2RlIHRoYXQgaGFuZGxlcyBOQU5EIGNvbnRyb2xsZXIgcmVs
YXRlZCByZWdpc3RlcnMNCj4+ICsNCj4+ICtwYXR0ZXJuUHJvcGVydGllczoNCj4+ICsgICJebmFu
ZEBbYS1mMC05XSQiOg0KPj4gKyAgICB0eXBlOiBvYmplY3QNCj4+ICsgICAgJHJlZjogcmF3LW5h
bmQtY2hpcC55YW1sDQo+PiArDQo+PiArICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgcmVnOg0K
Pj4gKyAgICAgICAgbWluaW11bTogMA0KPj4gKyAgICAgICAgbWF4aW11bTogMw0KPj4gKw0KPj4g
KyAgICAgIG5hbmQtcmI6DQo+PiArICAgICAgICBpdGVtczoNCj4+ICsgICAgICAgICAgLSBtaW5p
bXVtOiAwDQo+PiArICAgICAgICAgICAgbWF4aW11bTogMQ0KPj4gKw0KPj4gKyAgICAgIG5hbmQt
ZWNjLXN0ZXAtc2l6ZToNCj4+ICsgICAgICAgIGNvbnN0OiA1MTINCj4+ICsNCj4+ICsgICAgICBu
YW5kLWVjYy1zdHJlbmd0aDoNCj4+ICsgICAgICAgIGVudW06IFsxLCA0LCA4LCAxMiwgMTZdDQo+
PiArDQo+PiArICAgICAgbmFuZC1lY2MtbW9kZToNCj4+ICsgICAgICAgIGNvbnN0OiBodw0KPj4g
Kw0KPj4gKyAgICAgIG1hcnZlbGwsbmFuZC1rZWVwLWNvbmZpZzoNCj4+ICsgICAgICAgICRyZWY6
IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL2ZsYWcNCj4+ICsgICAgICAgIGRlc2Ny
aXB0aW9uOiB8DQo+IERvIG5vdCBuZWVkICd8JyB1bmxlc3MgeW91IG5lZWQgdG8gcHJlc2VydmUg
Zm9ybWF0dGluZy4NCkFjaw0KPj4gKyAgICAgICAgICBPcmRlcnMgdGhlIGRyaXZlciBub3QgdG8g
dGFrZSB0aGUgdGltaW5ncyBmcm9tIHRoZSBjb3JlIGFuZA0KPj4gKyAgICAgICAgICBsZWF2aW5n
IHRoZW0gY29tcGxldGVseSB1bnRvdWNoZWQuIEJvb3Rsb2FkZXIgdGltaW5ncyB3aWxsIHRoZW4N
Cj4+ICsgICAgICAgICAgYmUgdXNlZC4NCj4+ICsNCj4+ICsgICAgICBtYXJ2ZWxsLG5hbmQtZW5h
YmxlLWFyYml0ZXI6DQo+PiArICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZp
bml0aW9ucy9mbGFnDQo+PiArICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiBEbyBub3QgbmVlZCAn
fCcgdW5sZXNzIHlvdSBuZWVkIHRvIHByZXNlcnZlIGZvcm1hdHRpbmcuDQo+DQo+PiArICAgICAg
ICAgIFRvIGVuYWJsZSB0aGUgYXJiaXRlciwgYWxsIGJvYXJkcyBibGluZGx5IHVzZWQgaXQsDQo+
PiArICAgICAgICAgIHRoaXMgYml0IHdhcyBzZXQgYnkgdGhlIGJvb3Rsb2FkZXIgZm9yIG1hbnkg
Ym9hcmRzIGFuZCBldmVuIGlmDQo+PiArICAgICAgICAgIGl0IGlzIG1hcmtlZCByZXNlcnZlZCBp
biBzZXZlcmFsIGRhdGFzaGVldHMsIGl0IG1pZ2h0IGJlIG5lZWRlZCB0byBzZXQNCj4+ICsgICAg
ICAgICAgaXQgKG90aGVyd2lzZSBpdCBpcyBoYXJtbGVzcykuDQo+PiArICAgICAgICBkZXByZWNh
dGVkOiB0cnVlDQo+PiArDQo+PiArICAgIHJlcXVpcmVkOg0KPj4gKyAgICAgIC0gcmVnDQo+PiAr
ICAgICAgLSBuYW5kLXJiDQo+PiArDQo+PiArICAgIHVuZXZhbHVhdGVkUHJvcGVydGllczogZmFs
c2UNCj4+ICsNCj4+ICtyZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcN
Cj4+ICsgIC0gaW50ZXJydXB0cw0KPj4gKyAgLSBjbG9ja3MNCj4+ICsNCj4+ICthbGxPZjoNCj4+
ICsgIC0gJHJlZjogbmFuZC1jb250cm9sbGVyLnlhbWwjDQo+PiArDQo+PiArICAtIGlmOg0KPj4g
KyAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICBjb21wYXRpYmxlOg0KPj4gKyAgICAgICAg
ICBjb250YWluczoNCj4+ICsgICAgICAgICAgICBjb25zdDogbWFydmVsbCxweGEzeHgtbmFuZC1j
b250cm9sbGVyDQo+PiArICAgIHRoZW46DQo+PiArICAgICAgcmVxdWlyZWQ6DQo+PiArICAgICAg
ICAtIGRtYXMNCj4+ICsgICAgICAgIC0gZG1hLW5hbWVzDQo+PiArDQo+PiArICAtIGlmOg0KPj4g
KyAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICBjb21wYXRpYmxlOg0KPj4gKyAgICAgICAg
ICBjb250YWluczoNCj4+ICsgICAgICAgICAgICBjb25zdDogbWFydmVsbCxhcm1hZGEtOGstbmFu
ZC1jb250cm9sbGVyDQo+PiArICAgIHRoZW46DQo+PiArICAgICAgcHJvcGVydGllczoNCj4+ICsg
ICAgICAgIGNsb2NrczoNCj4+ICsgICAgICAgICAgbWluSXRlbXM6IDINCj4+ICsNCj4+ICsgICAg
ICAgIGNsb2NrLW5hbWVzOg0KPj4gKyAgICAgICAgICBtaW5JdGVtczogMg0KPj4gKw0KPj4gKyAg
ICAgIHJlcXVpcmVkOg0KPj4gKyAgICAgICAgLSBtYXJ2ZWxsLHN5c3RlbS1jb250cm9sbGVyDQo+
IGVsc2U6DQo+IG5hcnJvdyBjbG9ja3MgdG8gMT8gT3IgaXMgdGhlIHNlY29uZCBjbG9kIGFsc28g
dmFsaWQgZm9yIG90aGVyIHZhcmlhbnRzPw0KPiBEb2VzIG5vdCBsb29rIGxpa2UgZnJvbSB5b3Vy
IGV4YW1wbGUuDQpDb3JyZWN0LiBXaWxsIHVwZGF0ZS4NCj4NCj4NCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCj4=
