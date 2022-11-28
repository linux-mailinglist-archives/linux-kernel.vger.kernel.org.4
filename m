Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7059563B2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiK1URI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbiK1URG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:17:06 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C44527DD2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:17:02 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D27382C038A;
        Tue, 29 Nov 2022 09:16:58 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1669666618;
        bh=RPcW+ftZttjSXd+yRPvwtCbGy40cVtIyHjEHz59IFyQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jp6ZTfDU4qgqp35Qr0W2321fmUCuF0rtqNP13OBBghJPlMr2Z5YnV8kcIQ6sQJwS5
         QyG67DLHSsPTtZ5qi3UlaHK2ILAVIrFdc69votnXVgSJ4uYCOSFDlEu2eH1Pg6uvcu
         5Z+fLQsDPQ9bG7rnKPeyGLeHmIqvLbZ0HABTLDsCcHklFWRtQpf4K5GeirTDyA3Lg7
         70iTii8+/npLOHv95+bow8woNHNlhbqsBJpGLB7HFq+fxwWgHhHDNOj+dxRGmhu+ek
         L/4k1kWgoyxMZVK/3vl7xTlGZChXtOfbs67AwkgvV+LxBIwMXB4B2jwTMlaeXH5872
         W7Ht2H8W8dvcQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6385173a0001>; Tue, 29 Nov 2022 09:16:58 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 29 Nov 2022 09:16:58 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.044; Tue, 29 Nov 2022 09:16:58 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "thomas.petazzoni@free-electrons.com" 
        <thomas.petazzoni@free-electrons.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: gpio: gpio-mvebu: deprecate
 armadaxp-gpio
Thread-Topic: [PATCH v4 2/3] dt-bindings: gpio: gpio-mvebu: deprecate
 armadaxp-gpio
Thread-Index: AQHYcKAX7vPs34W8ukmHKj5eMF08ma5UQ6SAgADN6IA=
Date:   Mon, 28 Nov 2022 20:16:57 +0000
Message-ID: <887c89b1-5efc-e058-7ccc-58d1473f491e@alliedtelesis.co.nz>
References: <20220526012946.3862776-1-chris.packham@alliedtelesis.co.nz>
 <20220526012946.3862776-3-chris.packham@alliedtelesis.co.nz>
 <20221128075959.3a3io5nhaizm7uxj@pali>
In-Reply-To: <20221128075959.3a3io5nhaizm7uxj@pali>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF82FAC90C8B0D478858DCC008C3C239@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=PqrtkDE3 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=9xFQ1JgjjksA:10 a=VwQbUJbxAAAA:8 a=ZK0KQZw8tARzpkxUnbQA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGFsaSwNCg0KT24gMjgvMTEvMjIgMjA6NTksIFBhbGkgUm9ow6FyIHdyb3RlOg0KPiBPbiBU
aHVyc2RheSAyNiBNYXkgMjAyMiAxMzoyOTo0NSBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gQ29t
bWl0IDVmNzljNjUxZTgxZSAoImFybTogbXZlYnU6IHVzZSBnbG9iYWwgaW50ZXJydXB0cyBmb3Ig
R1BJT3Mgb24NCj4+IEFybWFkYSBYUCIpIHRoZSBtYXJ2ZWxsLGFybWFkYXhwLWdwaW8gY29tcGF0
aWJsZSBvYnNvbGV0ZS4NCj4gTm8sIG1hcnZlbGwsYXJtYWRheHAtZ3BpbyBpcyByZXF1aXJlZCBm
b3IgcGVyLWNwdSBpbnRlcnJ1cHQgc3VwcG9ydC4gSSBmaXhlZCBpdCByZWNlbnRseToNCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZGV2aWNldHJlZS8yMDIyMDcxNDExNTUxNS41NzQ4
LTItcGFsaUBrZXJuZWwub3JnLw0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1kZXZp
Y2V0cmVlLzIwMjIwNzE0MTgzMzI4LjQxMzctMy1wYWxpQGtlcm5lbC5vcmcvDQoNCkknbGwgcmVw
bHkgdG8gdGhlc2UgZGlyZWN0bHkgYnV0IHdoZW4geW91IGNoYW5nZWQgdGhlIGNvbXBhdGlibGUg
dG8gDQphcm1hZGF4cCB5b3UgY2hhbmdlZCB0aGUgbWVhbmluZyBvZiB0aGUgMm5kIHJlZyBwcm9w
ZXJ0eS4NCg0KPg0KPj4gVGhlIGRyaXZlciBjb2RlIHN0aWxsIGV4aXN0cyB0byBoYW5kbGUgdGhl
IGFybWFkYXhwIGJlaGF2aW91ciBidXQgYWxsDQo+PiB0aGUgaW4tdHJlZSBib2FyZHMgdXNlIHRo
ZSBtYXJ2ZWxsLGFybWFkYS0zNzAtZ3Bpby4gIERvY3VtZW50IHRoZQ0KPj4gbWFydmVsbCxhcm1h
ZGF4cC1ncGlvIGNvbXBhdGlibGUgYXMgZGVwcmVjYXRlZC4NCj4gRm9yIHBlci1jcHUgaW50ZXJy
dXB0IHN1cHBvcnQgaXMgbWFydmVsbCxhcm1hZGF4cC1ncGlvIG5lZWRlZCBhbmQNCj4gdGhlcmVm
b3JlIGl0IGNhbm5vdCBiZSBkZXByZWNhdGVkLg0KT0suIFdlIGNhbiBtYWtlIGl0IHVuLWRlcHJl
Y2F0ZWQgKGFzIHlvdSBzYXkgdGhlIGNvZGUgZXhpc3RzLCBqdXN0IG5vIA0KYm9hcmQgdXNlcyBp
dCBjdXJyZW50bHkpLg0KPg0KPiBXaGF0IGNhbiBiZSBkZXByZWNhdGVkIGlzIG1hcnZlbGwsYXJt
YWRhLTM3MC1ncGlvIGFuZCBpdCBjYW4gYmUgcmVwbGFjZWQNCj4gYnkgbWFydmVsbCxvcmlvbi1n
cGlvLCB3aGljaCBjb3ZlcnMgX2FsbF8gU29DcyBzdGFydGluZyBmcm9tIHRoZSBvbGRlc3QNCj4g
b25lID0gT3Jpb24uIFNlZSBkaXNjdXNzaW9uIGZvciBtb3JlIGRldGFpbHM6DQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LWRldmljZXRyZWUvMjAyMjA3MjUyMDA0MTcubnd0aHh6dmR2
MmJ6ZDVlakBwZW5ndXRyb25peC5kZS8NCg0KWWVzIEkgY2FuIHNlZSB0aGF0IHRoZXkncmUgdHJl
YXRlZCB0aGUgc2FtZSBpbnRlcm5hbGx5LiBUaGVyZSBoYWQgYmVlbiBhIA0KdHJlbmQgb2YgYWRk
aW5nIHNwZWNpYWxpemF0aW9uIGNvbXBhdGlibGUgc3RyaW5ncyBqdXN0IGluIGNhc2UgdGhleSB3
ZXJlIA0KbmVlZGVkIGluIHRoZSBmdXR1cmUgZXZlbiBpZiB0aGVyZSB3YXMgY3VycmVudGx5IG5v
IGRpZmZlcmVuY2UgYmV0d2VlbiANCnRoZSBiYXNlIHZhcmlhbnQgYW5kIHRoZSBuZXdlciB2ZXJz
aW9uLiBUaGF0IGFyZ3VtZW50IGZhbGxzIGEgYml0IGZsYXQgDQpzaW5jZSB3ZSBuZXZlciBhZGRl
ZCBhcm1hZGEtMzh4LWdwaW8uDQoNClNvIHdoYXQgcGF0aCBmb3J3YXJkIHdvdWxkIHlvdSBsaWtl
IHRvIHNlZT8gSSdkIGhhcHBpbHkgc2VuZCBhIHBhdGNoIA0KdW4tZGVwcmVjYXRpbmcgdGhlIGFy
bWFkYXhwIGNvbXBhdGlibGUuIEknbSBhIGxpdHRsZSBoZXNpdGFudCB0byBtYXJrIA0KdGhlIGFy
bWFkYS0zNzAgYXMgZGVwcmVjYXRlZCBnaXZlbiBpdCdzIGN1cnJlbnQgdXNhZ2Ugd2l0aCB0aGUg
aW4tdHJlZSANCmR0c2VzLg0KDQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxj
aHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+PiAtLS0NCj4+DQo+PiBOb3RlczoN
Cj4+ICAgICAgVGhpcyBjb3VsZCBwb3RlbnRpYWxseSBiZSBzcXVhc2hlZCBpbnRvIHRoZSBmaXJz
dCBjb21taXQgYnV0IGl0IHNlZW1lZA0KPj4gICAgICBtb3JlIHByb3BlciB0byBkbyBhIHN0cmFp
Z2h0IDE6MSBjb252ZXJzaW9uIG9mIHRoZSBvbGQgYmluZGluZyB0aGVuDQo+PiAgICAgIGNsZWFu
IHRoaW5ncyB1cCB0byBtYXRjaCByZWFsaXR5Lg0KPj4gICAgICANCj4+ICAgICAgQ2hhbmdlcyBp
biB2NDoNCj4+ICAgICAgLSBOZXcNCj4+DQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dw
aW8vZ3Bpby1tdmVidS55YW1sICB8IDI0ICsrKysrKystLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL2dwaW8tbXZlYnUu
eWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL2dwaW8tbXZlYnUu
eWFtbA0KPj4gaW5kZXggZDE2OTVlN2JkODI1Li40NTllYzM1ODY0ZmUgMTAwNjQ0DQo+PiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Bpby9ncGlvLW12ZWJ1LnlhbWwN
Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL2dwaW8tbXZl
YnUueWFtbA0KPj4gQEAgLTIxLDE3ICsyMSwyMSBAQCBwcm9wZXJ0aWVzOg0KPj4gICAgICAgICAg
ICAgLSBlbnVtOg0KPj4gICAgICAgICAgICAgICAgIC0gbWFydmVsbCxtdjc4MjAwLWdwaW8NCj4+
ICAgICAgICAgICAgICAgICAtIG1hcnZlbGwsYXJtYWRhLTM3MC1ncGlvDQo+PiAtICAgICAgICAg
ICAgICAtIG1hcnZlbGwsYXJtYWRheHAtZ3Bpbw0KPj4gICAgICAgICAgICAgLSBjb25zdDogbWFy
dmVsbCxvcmlvbi1ncGlvDQo+PiAgIA0KPj4gKyAgICAgIC0gZGVzY3JpcHRpb246IERlcHJlY2F0
ZWQgYmluZGluZw0KPj4gKyAgICAgICAgaXRlbXM6DQo+PiArICAgICAgICAgIC0gY29uc3Q6IG1h
cnZlbGwsYXJtYWRheHAtZ3Bpbw0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLG9yaW9u
LWdwaW8NCj4+ICsgICAgICAgIGRlcHJlY2F0ZWQ6IHRydWUNCj4+ICsNCj4+ICAgICByZWc6DQo+
PiAgICAgICBkZXNjcmlwdGlvbjogfA0KPj4gICAgICAgICBBZGRyZXNzIGFuZCBsZW5ndGggb2Yg
dGhlIHJlZ2lzdGVyIHNldCBmb3IgdGhlIGRldmljZS4gTm90IHVzZWQgZm9yDQo+PiAgICAgICAg
IG1hcnZlbGwsYXJtYWRhLThrLWdwaW8uDQo+PiAgIA0KPj4gLSAgICAgIEZvciB0aGUgIm1hcnZl
bGwsYXJtYWRheHAtZ3BpbyIgdmFyaWFudCBhIHNlY29uZCBlbnRyeSBpcyBleHBlY3RlZCBmb3IN
Cj4+IC0gICAgICB0aGUgcGVyLWNwdSByZWdpc3RlcnMuIEZvciBvdGhlciB2YXJpYW50cyBzZWNv
bmQgZW50cnkgY2FuIGJlIHByb3ZpZGVkLA0KPj4gLSAgICAgIGZvciB0aGUgUFdNIGZ1bmN0aW9u
IHVzaW5nIHRoZSBHUElPIEJsaW5rIENvdW50ZXIgb24vb2ZmIHJlZ2lzdGVycy4NCj4+ICsgICAg
ICBBIHNlY29uZCBlbnRyeSBjYW4gYmUgcHJvdmlkZWQsIGZvciB0aGUgUFdNIGZ1bmN0aW9uIHVz
aW5nIHRoZSBHUElPIEJsaW5rDQo+PiArICAgICAgQ291bnRlciBvbi9vZmYgcmVnaXN0ZXJzLg0K
Pj4gICAgICAgbWluSXRlbXM6IDENCj4+ICAgICAgIG1heEl0ZW1zOiAyDQo+PiAgIA0KPj4gQEAg
LTEwMywxOCArMTA3LDYgQEAgYWxsT2Y6DQo+PiAgICAgICAgIHJlcXVpcmVkOg0KPj4gICAgICAg
ICAgIC0gcmVnDQo+PiAgIA0KPj4gLSAgLSBpZjoNCj4+IC0gICAgICBwcm9wZXJ0aWVzOg0KPj4g
LSAgICAgICAgY29tcGF0aWJsZToNCj4+IC0gICAgICAgICAgY29udGFpbnM6DQo+PiAtICAgICAg
ICAgICAgY29uc3Q6IG1hcnZlbGwsYXJtYWRheHAtZ3Bpbw0KPj4gLSAgICB0aGVuOg0KPj4gLSAg
ICAgIHByb3BlcnRpZXM6DQo+PiAtICAgICAgICByZWc6DQo+PiAtICAgICAgICAgIG1pbkl0ZW1z
OiAyDQo+PiAtICAgICAgICByZWctbmFtZXM6DQo+PiAtICAgICAgICAgIG1pbkl0ZW1zOiAyDQo+
PiAtDQo+PiAgIHVuZXZhbHVhdGVkUHJvcGVydGllczogdHJ1ZQ0KPj4gICANCj4+ICAgZXhhbXBs
ZXM6DQo+PiAtLSANCj4+IDIuMzYuMQ0KPj4=
