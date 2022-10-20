Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A52C606BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJTXOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJTXN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:13:58 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9773722E0F6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:13:56 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DC8A12C048F;
        Fri, 21 Oct 2022 12:13:50 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1666307630;
        bh=fgJ7uD7kfNF0O9FMoUEaassWIRXGLCe8NVSu130vzYo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=1tskjm5ljMlMykF+QD5hQ2Pbg3TRTrKXDKW/VeVerWy3UJWaH0VvaRYzPfGS5osbG
         /IK2Q8rBizvgysWc/0Rq+gsHhjMUw92AW04EbHRjgqHyQsXZYOS7bka1wq2X/JVbIB
         nOsHfbXC/oh6RXpgl4My+JCWnGRcj/3PgiL9kf+T07gJ+UQedyD8LnYWiUSh0v/Qn0
         UhpTIct5FMVUPO1+LTUNH1rQN+vxeB9XZ5QvSbypOB1l9gdluVVsONbXakMPl95kMg
         d94AVb7fR+8CN+4CvB71cBA9oQkhV6H1fgZF37fyxjrmN9osiCwdbqBpqNb0Tpzt0u
         AAp8kCedzPa0Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6351d62e0001>; Fri, 21 Oct 2022 12:13:50 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Oct 2022 12:13:50 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.042; Fri, 21 Oct 2022 12:13:50 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Elad Nachman <enachman@marvell.com>,
        "Aviram Dali" <aviramd@marvell.com>
Subject: Re: [PATCH 2/3] dt-bindings: mtd: Add AC5 specific binding
Thread-Topic: [PATCH 2/3] dt-bindings: mtd: Add AC5 specific binding
Thread-Index: AQHY45PZG1Eksg8lkEuM7xSMI1VNl64UjZcAgAKEjQA=
Date:   Thu, 20 Oct 2022 23:13:50 +0000
Message-ID: <e13c3b91-c092-7756-3969-f1822e04cfdf@alliedtelesis.co.nz>
References: <20221019082046.30160-1-vadym.kochan@plvision.eu>
 <20221019082046.30160-3-vadym.kochan@plvision.eu>
 <20221019104654.7ee35744@xps-13>
In-Reply-To: <20221019104654.7ee35744@xps-13>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE745B3BA81DA041852ACC5DF8D4D834@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=YrxxuLQX c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10 a=g8kJ_gb0AAAA:8 a=M5GUcnROAAAA:8 a=2f4N3uraW7I7RusRnqYA:9 a=QEXdDO2ut3YA:10 a=ecSNLfPMzbq-p5zXJZOg:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmFkeW0sDQoNCk9uIDE5LzEwLzIyIDIxOjQ2LCBNaXF1ZWwgUmF5bmFsIHdyb3RlOg0KPiBI
aSBWYWR5bSwNCj4NCj4gdmFkeW0ua29jaGFuQHBsdmlzaW9uLmV1IHdyb3RlIG9uIFdlZCwgMTkg
T2N0IDIwMjIgMTE6MjA6MzkgKzAzMDA6DQo+DQo+PiBGcm9tOiBBdmlyYW0gRGFsaSA8YXZpcmFt
ZEBtYXJ2ZWxsLmNvbT4NCj4+DQo+PiBBZGQgYmluZGluZyBmb3IgQUM1IFNvQyB3aGljaCBoYXZl
IGl0cyBzcGVjaWFsIHdheSBvZiBoYW5kaW5nDQo+PiBOQU5EIGxheW91dC4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBBdmlyYW0gRGFsaSA8YXZpcmFtZEBtYXJ2ZWxsLmNvbT4NCj4+IFNpZ25lZC1v
ZmYtYnk6IFZhZHltIEtvY2hhbiA8dmFkeW0ua29jaGFuQHBsdmlzaW9uLmV1Pg0KPj4gLS0tDQo+
PiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWFydmVsbC1uYW5kLnR4
dCB8IDEgKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9tYXJ2ZWxsLW5h
bmQudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9tYXJ2ZWxsLW5h
bmQudHh0DQo+PiBpbmRleCBhMmQ5YTBmMmI2ODMuLjI5MzU1MWVjNzM1MCAxMDA2NDQNCj4+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWFydmVsbC1uYW5kLnR4
dA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9tYXJ2ZWxs
LW5hbmQudHh0DQo+PiBAQCAtMiw2ICsyLDcgQEAgTWFydmVsbCBOQU5EIEZsYXNoIENvbnRyb2xs
ZXIgKE5GQykNCj4+ICAgDQo+PiAgIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+PiAgIC0gY29tcGF0
aWJsZTogY2FuIGJlIG9uZSBvZiB0aGUgZm9sbG93aW5nOg0KPj4gKyAgICAqICJtYXJ2ZWxsLGFj
NS1uYW5kLWNvbnRyb2xsZXIiDQo+PiAgICAgICAqICJtYXJ2ZWxsLGFybWFkYS04ay1uYW5kLWNv
bnRyb2xsZXIiDQo+PiAgICAgICAqICJtYXJ2ZWxsLGFybWFkYTM3MC1uYW5kLWNvbnRyb2xsZXIi
DQo+PiAgICAgICAqICJtYXJ2ZWxsLHB4YTN4eC1uYW5kLWNvbnRyb2xsZXIiDQo+IENvdWxkIHlv
dSBwbGVhc2UgZG8gdGhlIHlhbWwgY29udmVyc2lvbiBmaXJzdD8NCklmIGl0IGhlbHBzIEkndmUg
ZG9uZSBhIGZldyBvZiB0aGVzZSBjb252ZXJzaW9ucyBpbiB0aGUgcGFzdC4gSSdkIGJlIA0KaGFw
cHkgdG8gaGVscCB5b3Ugb3V0IHdpdGggZG9pbmcgdGhlIGNvbnZlcnNpb24gaWYgaXQgaGVscHMg
eW91IG1vdmUgdGhlIA0KcmVzdCBvZiB0aGUgc2VyaWVzIGZvcndhcmQuDQo+DQo+IFRoYW5rcywN
Cj4gTWlxdcOobA==
