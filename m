Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E610E669DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjAMQZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjAMQYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:24:48 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C328D5D4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1673626706; x=1676218706;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/xV9KQhAOgiWf7LCH+eXUHu4xospcdFIUdu/VAD2l/g=;
        b=L1Rz7Z2G0gK3mwgOFgMp20M3bVL8qQ5MxDwktTIugpwi7EdlkI2kiuRJoKW+cZN0
        La/cYBpk4e2H58IxmsIfxipkIkEfliDBVXuZKGmyYmIr908Rm09DsTh0LjUMb/PS
        2KxhfaC1F8i8ZH7VzBqiScs6JIwsXMwbN00fTCBlSuI=;
X-AuditID: ac14000a-917fe70000007ecb-fa-63c18452eb4e
Received: from Diagnostix.phytec.de (Diagnostix.phytec.de [172.25.0.14])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 03.DC.32459.25481C36; Fri, 13 Jan 2023 17:18:26 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 13 Jan
 2023 17:18:26 +0100
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Fri, 13 Jan 2023 17:18:26 +0100
From:   Wadim Egorov <W.Egorov@phytec.de>
To:     Rob Herring <robh+dt@kernel.org>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: Convert PCA9532 to dtschema
Thread-Topic: [PATCH v2 1/2] dt-bindings: leds: Convert PCA9532 to dtschema
Thread-Index: AQHZJe0oUHRxzvM6PEqccdluqYg+dq6Zfs+AgAL55oA=
Date:   Fri, 13 Jan 2023 16:18:26 +0000
Message-ID: <9e544e49-3f28-c628-196f-2e0fed6584ec@phytec.de>
References: <20230111163404.3526248-1-w.egorov@phytec.de>
 <167346265519.1103752.16521267476598663004.robh@kernel.org>
 <CAL_JsqJ0e__gb6xQxJ-XhJfyBx3mYdhqipqi9i1AoBaxoaBHiA@mail.gmail.com>
In-Reply-To: <CAL_JsqJ0e__gb6xQxJ-XhJfyBx3mYdhqipqi9i1AoBaxoaBHiA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E14F8E4D69F3054494F0CB36B7A17E1F@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWyRpKBTzeo5WCywZzH4hZLLl5lt2h/t4zd
        Yv6Rc6wWfS8eMlvsaFvIYnF51xw2i61v1jFaHFt9hc3i7qmjbBYnN1xis2jde4TdovudugOP
        x7w11R6Hvy5k8di0qpPN4861PWwe/d0trB7T5/1k8lix+ju7x+dNcgEcUVw2Kak5mWWpRfp2
        CVwZu/tnMRX8U6i4eek3UwPjBIUuRk4OCQETiak7jjN2MXJxCAmsZZI4NmMLE4TzhFHi66JJ
        UM5GIOf1QhaQFjYBdYmJf0+wgtgiAioSG57fYgYpYha4yyIxY8pSsCJhAS+JBdtWM0MUeUtc
        7z3BBGFbSby/+YQRxGYRUJWYOfk+WA2vgI3E3Bs/2CC27WOUuH+oHSzBKRAoMXXKezCbUUBW
        YsOG82A2s4C4xKZn31khnhCQWLIHIi4hICrx8vE/qLi8xIlb04AWcwDVa0qs36UP0WohMf/9
        DXYIW1FiSvdDdogbBCVOznzCMoFRfBaSDbMQumch6Z6FpHsWku4FjKyrGIVyM5OzU4sys/UK
        MipLUpP1UlI3MYLSgAgD1w7GvjkehxiZOBgPMUpwMCuJ8O45uj9ZiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOO/9HqZEIYH0xJLU7NTUgtQimCwTB6dUA2O8g1Qzl/+P5Z6LX21sa5+V41rbUvzx
        zl1PtifPL2yzWuaxUFPmscPsUCs7HkYPudXf3G0jf+746fvxSUKIktqXqhez0hi3Ovzg71oq
        1vRgy+n1vuWH6ouZOZSv6L9dfe32gTa/HSK66qppWw3Dmd3yH5TxHhXLWrCN/a908tzgqaub
        ux6In1RiKc5INNRiLipOBAAHHPea8QIAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTEuMDEuMjMgdW0gMTk6NTEgc2NocmllYiBSb2IgSGVycmluZzoNCj4gT24gV2VkLCBKYW4g
MTEsIDIwMjMgYXQgMTI6NDcgUE0gUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4gd3JvdGU6
DQo+Pg0KPj4gT24gV2VkLCAxMSBKYW4gMjAyMyAxNzozNDowMyArMDEwMCwgV2FkaW0gRWdvcm92
IHdyb3RlOg0KPj4+IENvbnZlcnQgdGhlIFBDQTk1MzIgTEVEIGRpbW1lciB0byBkdHNjaGVtYS4N
Cj4+PiBXaGlsZSBhdCBpdCwgYWxzbyB1cGRhdGUgYW5kIHRoZSB0aGUgZXhhbXBsZSB0byBtYXRj
aA0KPj4+IHJlY29tbWVuZGVkIG5vZGUgbmFtZXMgYW5kIHRoZSBsaW5rIHRvIHRoZSBwcm9kdWN0
IGRhdGFzaGVldC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFdhZGltIEVnb3JvdiA8dy5lZ29y
b3ZAcGh5dGVjLmRlPg0KPj4+IC0tLQ0KPj4+IHYyOg0KPj4+ICAgIC0gUmVuYW1lIHlhbWwgZmls
ZSB0byBtYXRjaCBjb21wYXRpYmxlcywgbnhwLHBjYTk1M3gueWFtbA0KPj4+ICAgIC0gUmVtb3Zl
IEphY2VrIEFuYXN6ZXdza2kgZnJvbSBtYWludGFpbmVycyBsaXN0DQo+Pj4gICAgLSBSZW1vdmUg
Y29sb3IgbGFiZWxzIGluIGV4YW1wbGUNCj4+PiAgICAtIFJlc3RvcmUgbGFiZWxzL2RlZmF1bHQt
c3RhdGVzIGZyb20gb3JpZ2luYWwgZXhhbXBsZQ0KPj4+ICAgIC0gRHJvcCByZWcgZGVzY3JpcHRp
b24NCj4+PiAgICAtIEFkZCB1bmV2YWx1YXRlZFByb3BlcnRpZXMgdG8gcGF0dGVyblByb3BlcnRp
ZXMgc2NvcGUNCj4+PiAgICAtIFVwZGF0ZSBkZXNjcmlwdGlvbiBvZiB0eXBlIHByb3BlcnR5ICYg
c2V0IGRlZmF1bHQgdG8gMA0KPj4+ICAgIC0gRml4IGluZGVudGF0aW9uIGluIGV4YW1wbGUNCj4+
PiAtLS0NCj4+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2xlZHMvbGVkcy1wY2E5NTMyLnR4
dCB8IDQ5IC0tLS0tLS0tLS0tDQo+Pj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9sZWRzL254
cCxwY2E5NTN4LnlhbWwgfCA4NSArKysrKysrKysrKysrKysrKysrDQo+Pj4gICAyIGZpbGVzIGNo
YW5nZWQsIDg1IGluc2VydGlvbnMoKyksIDQ5IGRlbGV0aW9ucygtKQ0KPj4+ICAgZGVsZXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9sZWRzL2xlZHMtcGNh
OTUzMi50eHQNCj4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbGVkcy9ueHAscGNhOTUzeC55YW1sDQo+Pj4NCj4+IFJ1bm5pbmcgJ21ha2Ug
ZHRic19jaGVjaycgd2l0aCB0aGUgc2NoZW1hIGluIHRoaXMgcGF0Y2ggZ2l2ZXMgdGhlDQo+PiBm
b2xsb3dpbmcgd2FybmluZ3MuIENvbnNpZGVyIGlmIHRoZXkgYXJlIGV4cGVjdGVkIG9yIHRoZSBz
Y2hlbWEgaXMNCj4+IGluY29ycmVjdC4gVGhlc2UgbWF5IG5vdCBiZSBuZXcgd2FybmluZ3MuDQo+
Pg0KPj4gTm90ZSB0aGF0IGl0IGlzIG5vdCB5ZXQgYSByZXF1aXJlbWVudCB0byBoYXZlIDAgd2Fy
bmluZ3MgZm9yIGR0YnNfY2hlY2suDQo+PiBUaGlzIHdpbGwgY2hhbmdlIGluIHRoZSBmdXR1cmUu
DQo+Pg0KPj4gRnVsbCBsb2cgaXMgYXZhaWxhYmxlIGhlcmU6IGh0dHBzOi8vcGF0Y2h3b3JrLm96
bGFicy5vcmcvcHJvamVjdC9kZXZpY2V0cmVlLWJpbmRpbmdzL3BhdGNoLzIwMjMwMTExMTYzNDA0
LjM1MjYyNDgtMS13LmVnb3JvdkBwaHl0ZWMuZGUNCj4+DQo+Pg0KPj4gbGVkZGltbWVyQDYyOiAn
bGVkMScsICdsZWQyJywgJ2xlZDMnLCAnbGVkNCcgZG8gbm90IG1hdGNoIGFueSBvZiB0aGUgcmVn
ZXhlczogJ15sZWQtWzAtOWEtel0rJCcsICdwaW5jdHJsLVswLTldKycNCj4+ICAgICAgICAgIGFy
Y2gvYXJtL2Jvb3QvZHRzL3JrMzI4OC1waHljb3JlLXJkay5kdGINCj4+DQo+PiBsZWRzQDYyOiAn
bGVkMScsICdsZWQyJywgJ2xlZDMnIGRvIG5vdCBtYXRjaCBhbnkgb2YgdGhlIHJlZ2V4ZXM6ICde
bGVkLVswLTlhLXpdKyQnLCAncGluY3RybC1bMC05XSsnDQo+PiAgICAgICAgICBhcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdGINCj4+DQo+
PiBwY2E5NTMwQDYxOiAndGZ0LXBhbmVsQDAnIGRvZXMgbm90IG1hdGNoIGFueSBvZiB0aGUgcmVn
ZXhlczogJ15sZWQtWzAtOWEtel0rJCcsICdwaW5jdHJsLVswLTldKycNCj4+ICAgICAgICAgIGFy
Y2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1wZHUwMDEuZHRiDQoNCkhvdyBkbyBJIGNvbXBseSB3aXRo
IHRoZSBMRUQgbGFiZWwgd2FybmluZ3M/DQpJIGFtIG5vdCBzdXJlIGFib3V0IHRoZSBwcm9wZXIg
Y29udmVudGlvbi4gSSB3YXMgYXNzdW1pbmcgbGVkLTxuYW1lPiBpcyBjb3JyZWN0Lg0KVGhlIGZp
cnN0IHR3byB3YXJuaW5ncyBjYW4gYmUgZml4ZWQgYnkgZHJvcHBpbmcgdGhlICctJyBpbiB0aGUg
cmVnZXguDQpCdXQgSSBkb24ndCBzZWUgaG93IHRoZSBsYXN0IHdhcm5pbmcgc2hvdWxkIGNvbXBs
eSB3aXRoIGEgcHJvcGVyIExFRCBub2RlIG5hbWUuIA0KT3IgY2FuIHRoaXMgYmUgaWdub3JlZD8N
Cg0KPj4NCj4+IHBjYTk1MzJANjA6ICcjZ3Bpby1jZWxscycsICdncGlvLWNvbnRyb2xsZXInIGRv
IG5vdCBtYXRjaCBhbnkgb2YgdGhlIHJlZ2V4ZXM6ICdebGVkLVswLTlhLXpdKyQnLCAncGluY3Ry
bC1bMC05XSsnDQo+PiAgICAgICAgICBhcmNoL2FybS9ib290L2R0cy9scGMzMjUwLWVhMzI1MC5k
dGINCj4gTG9va3MgbGlrZSBHUElPIHByb3BlcnRpZXMgbmVlZCB0byBiZSBhZGRlZCBhcyB3ZSBo
YXZlIGR0cyBmaWxlIGFuZA0KPiB0aGUgZHJpdmVyIHN1cHBvcnRzIEdQSU8uIEl0J3MgZmluZSB0
byBhZGQgaW4gdGhlIGNvbnZlcnNpb24sIGp1c3QNCj4gbWVudGlvbiBpdCBpbiB0aGUgY29tbWl0
IG1zZy4NCg0KT0ssIHRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0LiBJIHdpbGwgYWRkIGl0IGlu
IHYzLg0KDQo+DQo+IEFsc28sIHlvdXIgMiBwYXRjaGVzIGluIHRoZSBzZXJpZXMgYXJlIHVucmVs
YXRlZCBhbmQgZ28gdG8gZGlmZmVyZW50DQo+IG1haW50YWluZXJzLCBzbyBzZW5kIHRoZW0gc2Vw
YXJhdGVseSBuZXh0IHRpbWUuDQoNCm9rLg0KDQpSZWdhcmRzLA0KV2FkaW0NCg0KPg0KPiBSb2IN
Cg0KDQo=
