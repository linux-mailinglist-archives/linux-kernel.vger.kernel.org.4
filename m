Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08A5743361
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 06:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjF3EHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 00:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF3EHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 00:07:03 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32128199C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 21:07:01 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 84C402C0543;
        Fri, 30 Jun 2023 16:06:58 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1688098018;
        bh=jB27fmXkfzp7He06PxN/Gc4RfV1heM0YKMl2NWUGi/A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=d2zsqXm+xOY9ObtniFSp1XB3ylZj8/9z186Q/lBwA1e6yz1HFJsrvoRLNb5WSexuv
         TnRn+Mij8sADWO6qEQL9wgM3S19CnRodag/v+l7eRsnqnsnzy9V4OSVjTFVYLgEUSs
         2TnFTKM3MloDZFC9p1tmqAGzlovrnokHuGOId3JTeVpaBKPvFWb+nKabqC+o0jbR9Q
         IDQr4BJoE+e9+L5vUegfdDnHVgqNvqWxVyJnJ7H4+6jlRocYoZBuMUB3ZtQtFq2GLe
         zvorIGltlrlqg98TO1DokdACVnC2K/4V3tSl0HhAPbzvoqwUqAwb2U/MmraVcEQash
         SDyuf+qlzFuvg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B649e54e20001>; Fri, 30 Jun 2023 16:06:58 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 30 Jun 2023 16:06:58 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.030; Fri, 30 Jun 2023 16:06:58 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] arm64: dts: marvell: Add NAND flash controller to
 AC5
Thread-Topic: [PATCH v2 2/3] arm64: dts: marvell: Add NAND flash controller to
 AC5
Thread-Index: AQHZp9wFzLABkbH5wEGgo5cmf3kQUa+h972A
Date:   Fri, 30 Jun 2023 04:06:58 +0000
Message-ID: <aa45c265-5b90-b8a5-722e-4bcbc662660b@alliedtelesis.co.nz>
References: <20230626031217.870938-1-chris.packham@alliedtelesis.co.nz>
 <20230626031217.870938-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20230626031217.870938-3-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0324BC037DBF9749B057D985433F6C8F@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=NPqrBHyg c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10 a=w2twMtuE976TmCkByo0A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyNi8wNi8yMyAxNToxMiwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4gVGhlIEFDNS9BQzVY
IFNvQyBoYXMgYSBOQU5EIGZsYXNoIGNvbnRyb2xsZXIgKE5GQykuIEFkZCB0aGlzIHRvDQo+IHRo
ZSBiYXNlIFNvQyBkdHNpIGZpbGUgYXMgYSBkaXNhYmxlZCBub2RlLiBUaGUgTkZDIGludGVncmF0
aW9uDQo+IG9uIHRoZSBBQzUvQUM1WCBvbmx5IHN1cHBvcnRzIFNEUiB0aW1pbmcgbW9kZXMgdXAg
dG8gMyBzbyByZXF1aXJlcyBhDQo+IGRlZGljYXRlZCBjb21wYXRpYmxlIHByb3BlcnR5IHNvIHRo
aXMgbGltaXRhdGlvbiBjYW4gYmUgZW5mb3JjZWQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlz
IFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4gLS0tDQo+DQo+
IE5vdGVzOg0KPiAgICAgIENoYW5nZXMgaW4gdjI6DQo+ICAgICAgLSBOZXcuDQo+DQo+ICAgYXJj
aC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FjNS05OGR4MjV4eC5kdHNpIHwgMTAgKysrKysrKysr
Kw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYWM1LTk4ZHgyNXh4LmR0c2kgYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL21hcnZlbGwvYWM1LTk4ZHgyNXh4LmR0c2kNCj4gaW5kZXggOGJjZTY0MDY5
MTM4Li43NGQ2NDRlMGMyOWUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFy
dmVsbC9hYzUtOThkeDI1eHguZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZl
bGwvYWM1LTk4ZHgyNXh4LmR0c2kNCj4gQEAgLTI5Niw2ICsyOTYsMTYgQEAgc3BpMTogc3BpQDgw
NWE4MDAwIHsNCj4gICAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAgIAkJfTsNCj4gICANCj4g
KwkJbmFuZDogbmFuZC1jb250cm9sbGVyQDgwNWIwMDAwIHsNCj4gKwkJCWNvbXBhdGlibGUgPSAi
bWFydmVsbCxhYzUtbmFuZC1jb250cm9sbGVyIjsNCj4gKwkJCXJlZyA9ICA8MHgwIDB4ODA1YjAw
MDAgMHgwIDB4MDAwMDAwNTQ+Ow0KPiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8MHgxPjsNCj4gKwkJ
CSNzaXplLWNlbGxzID0gPDB4MD47DQo+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODkgSVJR
X1RZUEVfTEVWRUxfSElHSD47DQo+ICsJCQljbG9ja3MgPSA8JmNubV9jbG9jaz47DQoNCkFjdHVh
bGx5IEkgdGhpbmsgSSd2ZSBqdXN0IG5vdGljZWQgYSBwcm9ibGVtIHdpdGggdGhpcy4gVGhlIE5G
QyB1c2VzIGEgDQpkaWZmZXJlbnQgY2xvY2sgbm90IHRoZSBjbm0gb25lLiBJdCdzIG5vdCBhIGdh
dGluZyBjbG9jayBsaWtlIG90aGVyIFNvQ3MgDQphbmQgdGhleSdyZSBjbG9zZSBlbm91Z2ggZnJl
cXVlbmN5IHdpc2Ugc28gaXQgbW9zdGx5IHdvcmtzLiBJJ2xsIHVwZGF0ZSANCnRoaXMgdG8gYWRk
IGEgZGVkaWNhdGVkIG5hbmQtY2xvY2sgZm9yIHYzLg0KDQo+ICsJCQlzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KPiArCQl9Ow0KPiArDQo+ICAgCQlnaWM6IGludGVycnVwdC1jb250cm9sbGVyQDgwNjAw
MDAwIHsNCj4gICAJCQljb21wYXRpYmxlID0gImFybSxnaWMtdjMiOw0KPiAgIAkJCSNpbnRlcnJ1
cHQtY2VsbHMgPSA8Mz47
