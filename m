Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2609734883
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 23:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjFRVM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 17:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFRVMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:12:55 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D5713D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 14:12:50 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4AC1E2C0295;
        Mon, 19 Jun 2023 09:12:40 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1687122760;
        bh=n8GHzQbNON/Xjem4iPLcPT56xSQCP05AtkAX//cM2f4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hLOfbg3dnAiMkzPUA0tInJLoJgt/yEP53K+wUOFT4bHn+SDMi6eEB0dgo56EzEpX0
         hSbSEeMlnGPUmscqEmpQfI9B0MIz25MKcn1QiQcm95jIBzcye/cfgzyftEsXL1ZOQD
         ST1neWyxFBJgmUzUZjOf3h8sovf2ISJLWp3msIHddZVoneOyeo8gJGbIqQSJrvT3uX
         29c252Lwn3gV2rX5JOe01djaj8HE3VPCxRgAwHwrmgPOmjYEDwj+qVUgCB+dw3m/4M
         qZvLFtrhPRR497n2BJFo55gaDryzM+QdnMN78V3u59MTOC9xT6FVmjEP5P/QVtGXI2
         zMwnWaM+YU9ig==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B648f73480001>; Mon, 19 Jun 2023 09:12:40 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.30; Mon, 19 Jun 2023 09:12:40 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Mon, 19 Jun 2023 09:12:39 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.030; Mon, 19 Jun 2023 09:12:39 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "vadym.kochan@plvision.eu" <vadym.kochan@plvision.eu>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>
Subject: Re: [PATCH v6 0/2] dt-bindings: mtd: marvell-nand: Add YAML scheme
Thread-Topic: [PATCH v6 0/2] dt-bindings: mtd: marvell-nand: Add YAML scheme
Thread-Index: AQHZkpEvKI1tV7pyn0+RiOLc0KH0K6+MoboAgAADkQCAA7+hgA==
Date:   Sun, 18 Jun 2023 21:12:39 +0000
Message-ID: <e79cb44c-a669-3726-ea71-1a4db88ebe7b@alliedtelesis.co.nz>
References: <20230530005337.3687938-1-chris.packham@alliedtelesis.co.nz>
 <87r0qbhbqt.fsf@BL-laptop> <87ilbnhb5j.fsf@BL-laptop>
In-Reply-To: <87ilbnhb5j.fsf@BL-laptop>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6664D2983A17914E9F86CFFF8D694C22@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=NPqrBHyg c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10 a=P-IC7800AAAA:8 a=62ntRvTiAAAA:8 a=ddKjx2dgZxSzjoJ6qqIA:9 a=QEXdDO2ut3YA:10 a=N53muDpBR4cA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=pToNdpNmrtiFLRE6bQ9Z:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SCC_BODY_URI_ONLY,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNi8wNi8yMyAyMzo1OCwgR3JlZ29yeSBDTEVNRU5UIHdyb3RlOg0KPiBHcmVnb3J5IENM
RU1FTlQgPGdyZWdvcnkuY2xlbWVudEBib290bGluLmNvbT4gd3JpdGVzOg0KPg0KPj4gQ2hyaXMg
UGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56PiB3cml0ZXM6DQo+Pg0K
Pj4+IEFkZCBZQU1MIHNjaGVtZSBmb3IgdGhlIE1hcnZlbGwncyBOQU5EIGNvbnRyb2xsZXINCj4+
PiB0byB2YWxpZGF0ZSBpdCdzIERUIGJpbmRpbmdzLiBPbGQgdHh0IGZpbGUgaXMgZGVsZXRlZCwN
Cj4+PiBub3QgaW5jbHVkZWQgdGhlIGNvbXBhdGlibGVzIGFuZCBwcm9wZXJ0aWVzIHdoaWNoIHdl
cmUgbWFya2VkIGFzDQo+Pj4gZGVwcmVjYXRlZC4NCj4+Pg0KPj4+IEFsc28gZml4IG5vZGUgbmFt
ZSBpbiBjcDExeCBEVFNJIGFjb3JkaW5nIHRvIG5hbmQtY29udHJvbGxlci55YW1sDQo+Pj4NCj4+
PiBJJ3ZlIHBpY2tlZCB1cCB0aGlzIHNlcmllcyB0byBob3BlZnVsbHkgZ2V0IGl0IG92ZXIgdGhl
IGxpbmUuIEkgdGhpbmsgSSd2ZQ0KPj4+IGFkZHJlc3NlZCBhbGwgdGhlIGZlZWRiYWNrIGZyb20g
dGhlIGxhc3Qgcm91bmQgb2YgcmV2aWV3Lg0KPj4+DQo+Pj4gVmFkeW0gS29jaGFuICgyKToNCj4+
PiAgICBkdC1iaW5kaW5nczogbXRkOiBtYXJ2ZWxsLW5hbmQ6IENvbnZlcnQgdG8gWUFNTCBEVCBz
Y2hlbWUNCj4+PiAgICBhcm02NDogZHRzOiBtYXJ2ZWxsOiBjcDExeDogRml4IG5hbmRfY29udHJv
bGxlciBub2RlIG5hbWUgYWNjb3JkaW5nIHRvDQo+Pj4gICAgICBZQU1MDQo+Pg0KPj4gQm90aCBw
YXRjaCBhcHBsaWVkIG9uIG12ZWJ1L2R0NjQNCj4+DQo+PiBIb3dldmVyIGlmIHRoZSBmaXJzdCBw
YXRjaCBzaG91bGQgYmUgbWVyZ2VkIHRocm91Z2ggYW5vdGhlciB0cmVlLCBsZXQgbWUNCj4+IGtu
b3cuDQo+IEZpbmFsbHkgSSByZW1vdmVkIHRoZXNlIGJvdGggcGF0Y2hlcywgSSBtaXNzZWQgdGhl
IHZlcnNpb24gOSENCj4NCj4gSSBhcHBsaWVkIHRoZSAyIHBhdGNoZXMgZm9yIHRoZSBkdHMgZmls
ZXMgZnJvbSB2OS4NCj4NCj4gVGhhbmtzLA0KPg0KPiBHcmVnb3J5DQpUaGFua3MgYW5kIHNvcnJ5
IGZvciB0aGUgY29uZnVzaW9uLiBUaGVyZSdzIGEgdjEwIG9uIHRoZSB3YXkgYnV0IEkgY2FuIA0K
ZHJvcCBvdXQgdGhlIGR0cyBjaGFuZ2VzIGZyb20gdGhhdCBub3cuDQo+Pg0KPj4+ICAgLi4uL2Jp
bmRpbmdzL210ZC9tYXJ2ZWxsLG5hbmQtY29udHJvbGxlci55YW1sIHwgMTkwICsrKysrKysrKysr
KysrKysrKw0KPj4+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL21hcnZlbGwtbmFuZC50
eHQgIHwgMTI2IC0tLS0tLS0tLS0tLQ0KPj4+ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAxIC0NCj4+PiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFy
dmVsbC9hcm1hZGEtY3AxMXguZHRzaSB8ICAgMiArLQ0KPj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAx
OTEgaW5zZXJ0aW9ucygrKSwgMTI4IGRlbGV0aW9ucygtKQ0KPj4+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWFydmVsbCxuYW5kLWNv
bnRyb2xsZXIueWFtbA0KPj4+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tdGQvbWFydmVsbC1uYW5kLnR4dA0KPj4+DQo+Pj4gLS0gDQo+Pj4g
Mi40MC4xDQo+Pj4NCj4+IC0tIA0KPj4gR3JlZ29yeSBDbGVtZW50LCBCb290bGluDQo+PiBFbWJl
ZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nDQo+PiBodHRwOi8vc2Nhbm1haWwudHJ1
c3R3YXZlLmNvbS8/Yz0yMDk4OCZkPTBjNk01SDhQQmFnV1hEdVNLc2piWHBkMXpMWC1ISEhSazN4
U1pPZEZEdyZ1PWh0dHAlM2ElMmYlMmZib290bGluJTJlY29t
