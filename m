Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A063613EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJaUMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJaUMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:12:34 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBFD6390
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:12:32 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 099192C02AB;
        Tue,  1 Nov 2022 09:12:28 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1667247148;
        bh=XZ+if1N2/Ks4LSOWRvtmswP4a4+DC9ER27mb2KT5/QU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=xdBosmzTcBxJXMO8IJQtUjMXuNPpOiKVsPnw5lEByGHc1hxGBJVMW93DebxcKWs0B
         UI68gNnkIUMHBRVTObH1J5Hqyvwk4MtCFmYYPfE7fZxuONcKhq6xSbliQaMOqj/dny
         vft6sGmpqUkrPWv7OOhBmc9b1Pw/mpoWeOXRtJldQhiU0CLMf9o7O7h93baQC7PD08
         l2cCagdMQot65F1iZ9R3c2SjyNqvgMP25+2TqZ/gHN8/DiW9SZlgxB5SujLgRONNSS
         MZlzEpUDpcQ2QA4+Ys9uY9EbrGCCN1LxbSHR88uuZhT8TiPxvXBAGADP1n1OWCFVu5
         T0BPNcdxHwxnw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63602c2b0001>; Tue, 01 Nov 2022 09:12:27 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 1 Nov 2022 09:12:27 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.042; Tue, 1 Nov 2022 09:12:27 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Pierre Gondois <pierre.gondois@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Rob.Herring@arm.com" <Rob.Herring@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 10/20] arm64: dts: Update cache properties for marvell
Thread-Topic: [PATCH 10/20] arm64: dts: Update cache properties for marvell
Thread-Index: AQHY7QoEsh2dDxNstkG/65AkQ+4wgq4oFi+A
Date:   Mon, 31 Oct 2022 20:12:27 +0000
Message-ID: <74622aa0-e74b-9ed9-2dab-8a4f0fce40e9@alliedtelesis.co.nz>
References: <20221031092020.532456-1-pierre.gondois@arm.com>
In-Reply-To: <20221031092020.532456-1-pierre.gondois@arm.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5579AC05A4CB84BA1A5FD7110D7B708@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=YrxxuLQX c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=9xFQ1JgjjksA:10 a=7CQSdrXTAAAA:8 a=Xk00A_WVHji455j1H8cA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAzMS8xMC8yMiAyMjoyMCwgUGllcnJlIEdvbmRvaXMgd3JvdGU6DQo+IFRoZSBEZXZpY2VU
cmVlIFNwZWNpZmljYXRpb24gdjAuMyBzcGVjaWZpZXMgdGhhdCB0aGUgY2FjaGUgbm9kZQ0KPiAn
Y29tcGF0aWJsZScgYW5kICdjYWNoZS1sZXZlbCcgcHJvcGVydGllcyBhcmUgJ3JlcXVpcmVkJy4g
Q2YuDQo+IHMzLjggTXVsdGktbGV2ZWwgYW5kIFNoYXJlZCBDYWNoZSBOb2Rlcw0KPg0KPiBUaGUg
cmVjZW50bHkgYWRkZWQgaW5pdF9vZl9jYWNoZV9sZXZlbCgpIGZ1bmN0aW9uIGNoZWNrcw0KPiB0
aGVzZSBwcm9wZXJ0aWVzLiBBZGQgdGhlbSBpZiBtaXNzaW5nLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBQaWVycmUgR29uZG9pcyA8cGllcnJlLmdvbmRvaXNAYXJtLmNvbT4NCg0KRm9yIGFjNS05OGR4
MjV4eC5kdHNpDQoNClJldmlld2VkLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFs
bGllZHRlbGVzaXMuY28ubno+DQoNCj4gLS0tDQo+ICAgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2
ZWxsL2FjNS05OGR4MjV4eC5kdHNpICAgICAgfCAxICsNCj4gICBhcmNoL2FybTY0L2Jvb3QvZHRz
L21hcnZlbGwvYXJtYWRhLWFwODA2LWR1YWwuZHRzaSB8IDEgKw0KPiAgIGFyY2gvYXJtNjQvYm9v
dC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4MDYtcXVhZC5kdHNpIHwgMiArKw0KPiAgIGFyY2gvYXJt
NjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4MDctcXVhZC5kdHNpIHwgMiArKw0KPiAgIDQg
ZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL21hcnZlbGwvYWM1LTk4ZHgyNXh4LmR0c2kgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL21hcnZlbGwvYWM1LTk4ZHgyNXh4LmR0c2kNCj4gaW5kZXggODBiNDRjN2RmNTZhLi5kNDc3
MGFjZWM2YWMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hYzUt
OThkeDI1eHguZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYWM1LTk4
ZHgyNXh4LmR0c2kNCj4gQEAgLTQ5LDYgKzQ5LDcgQEAgY3B1MTogY3B1QDEgew0KPiAgIA0KPiAg
IAkJbDI6IGwyLWNhY2hlIHsNCj4gICAJCQljb21wYXRpYmxlID0gImNhY2hlIjsNCj4gKwkJCWNh
Y2hlLWxldmVsID0gPDI+Ow0KPiAgIAkJfTsNCj4gICAJfTsNCj4gICANCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4MDYtZHVhbC5kdHNpIGIvYXJj
aC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1hcDgwNi1kdWFsLmR0c2kNCj4gaW5kZXgg
ZmNhYjUxNzNmZTY3Li45OTBmNzAzMDNmZTYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4MDYtZHVhbC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4MDYtZHVhbC5kdHNpDQo+IEBAIC01MSw2ICs1MSw3
IEBAIGwyOiBsMi1jYWNoZSB7DQo+ICAgCQkJY2FjaGUtc2l6ZSA9IDwweDgwMDAwPjsNCj4gICAJ
CQljYWNoZS1saW5lLXNpemUgPSA8NjQ+Ow0KPiAgIAkJCWNhY2hlLXNldHMgPSA8NTEyPjsNCj4g
KwkJCWNhY2hlLWxldmVsID0gPDI+Ow0KPiAgIAkJfTsNCj4gICAJfTsNCj4gICANCj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4MDYtcXVhZC5kdHNp
IGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1hcDgwNi1xdWFkLmR0c2kNCj4g
aW5kZXggM2RiNDI3MTIyZjllLi5hN2I4ZTAwMWNjOWMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4MDYtcXVhZC5kdHNpDQo+ICsrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4MDYtcXVhZC5kdHNpDQo+IEBAIC04MSw2
ICs4MSw3IEBAIGwyXzA6IGwyLWNhY2hlMCB7DQo+ICAgCQkJY2FjaGUtc2l6ZSA9IDwweDgwMDAw
PjsNCj4gICAJCQljYWNoZS1saW5lLXNpemUgPSA8NjQ+Ow0KPiAgIAkJCWNhY2hlLXNldHMgPSA8
NTEyPjsNCj4gKwkJCWNhY2hlLWxldmVsID0gPDI+Ow0KPiAgIAkJfTsNCj4gICANCj4gICAJCWwy
XzE6IGwyLWNhY2hlMSB7DQo+IEBAIC04OCw2ICs4OSw3IEBAIGwyXzE6IGwyLWNhY2hlMSB7DQo+
ICAgCQkJY2FjaGUtc2l6ZSA9IDwweDgwMDAwPjsNCj4gICAJCQljYWNoZS1saW5lLXNpemUgPSA8
NjQ+Ow0KPiAgIAkJCWNhY2hlLXNldHMgPSA8NTEyPjsNCj4gKwkJCWNhY2hlLWxldmVsID0gPDI+
Ow0KPiAgIAkJfTsNCj4gICAJfTsNCj4gICB9Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9tYXJ2ZWxsL2FybWFkYS1hcDgwNy1xdWFkLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL21hcnZlbGwvYXJtYWRhLWFwODA3LXF1YWQuZHRzaQ0KPiBpbmRleCA2ODc4MmYxNjFmMTIu
Ljc3NDAwOThmZDEwOCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxs
L2FybWFkYS1hcDgwNy1xdWFkLmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2
ZWxsL2FybWFkYS1hcDgwNy1xdWFkLmR0c2kNCj4gQEAgLTgxLDYgKzgxLDcgQEAgbDJfMDogbDIt
Y2FjaGUwIHsNCj4gICAJCQljYWNoZS1zaXplID0gPDB4ODAwMDA+Ow0KPiAgIAkJCWNhY2hlLWxp
bmUtc2l6ZSA9IDw2ND47DQo+ICAgCQkJY2FjaGUtc2V0cyA9IDw1MTI+Ow0KPiArCQkJY2FjaGUt
bGV2ZWwgPSA8Mj47DQo+ICAgCQl9Ow0KPiAgIA0KPiAgIAkJbDJfMTogbDItY2FjaGUxIHsNCj4g
QEAgLTg4LDYgKzg5LDcgQEAgbDJfMTogbDItY2FjaGUxIHsNCj4gICAJCQljYWNoZS1zaXplID0g
PDB4ODAwMDA+Ow0KPiAgIAkJCWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47DQo+ICAgCQkJY2FjaGUt
c2V0cyA9IDw1MTI+Ow0KPiArCQkJY2FjaGUtbGV2ZWwgPSA8Mj47DQo+ICAgCQl9Ow0KPiAgIAl9
Ow0KPiAgIH07
