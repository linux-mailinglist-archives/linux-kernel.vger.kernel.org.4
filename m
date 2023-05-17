Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5301270680A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjEQMZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjEQMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:25:23 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212685FCC;
        Wed, 17 May 2023 05:25:21 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34HCOjDH077036;
        Wed, 17 May 2023 07:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684326285;
        bh=ZdnZw29gNXuAQdLSzCiUFNQsPERQNjSnz3MX3E3cqOA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=TZXIbrSYGkgeTg7sUwZoLimUISOmupo2ubHNtf2S/R1gAnO/oEJDDX+8BI4WwRSrB
         EPTB6FN6PNL/rKPrxMw16h+u+uJdfiZLT3KjqunEIfFvsuQwmLk8Fz1tURtTUiTLCJ
         DowI4GQ2nDH/mJpIf0hKp2sCSYMobVDbvhkQ9PcQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34HCOjQu012585
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 May 2023 07:24:45 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 May 2023 07:24:44 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Wed, 17 May 2023 07:24:44 -0500
From:   "Ding, Shenghao" <shenghao-ding@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     Shenghao Ding <13916275206@139.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "gentuser@gmail.com" <gentuser@gmail.com>,
        "Ryan_Chu@wistron.com" <Ryan_Chu@wistron.com>,
        "Sam_Wu@wistron.com" <Sam_Wu@wistron.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 2/5] ASoC: dt-bindings: Add tas2781
 amplifier
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/5] ASoC: dt-bindings: Add tas2781
 amplifier
Thread-Index: AQHZgw2r46dnAmj+dEya5A38wB/fZK9U5kcAgAA/wgD//+cmsIAAb9cAgAjm74A=
Date:   Wed, 17 May 2023 12:24:44 +0000
Message-ID: <26c335994d91492eb9439483ac98f61c@ti.com>
References: <20230508054512.719-1-13916275206@139.com>
 <ca9d45cf-8a84-4fbc-e1dd-c96eef36fe25@linaro.org>
 <ZFyBzHWo3ORKAskX@finisterre.sirena.org.uk>
 <ca2ed8e9-850a-56c5-e395-72e5861b9c71@linaro.org>
 <3c48d5e47aff478b8ce8998d7efe001b@ti.com>
 <3e62d34b-a439-ac42-83a1-deb26ade63ff@linaro.org>
In-Reply-To: <3e62d34b-a439-ac42-83a1-deb26ade63ff@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.160.143]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzA1LzIwMjMgMTU6MTksIERpbmcsIFNoZW5naGFvIHdyb3RlOg0KPiANCj4gT24g
MTEvMDUvMjAyMyAwNzo0OSwgTWFyayBCcm93biB3cm90ZToNCj4+PiBNaXNzaW5nIG1pbkl0ZW1z
LCBidXQuLi4NCj4+DQo+Pj4+ICsgICAgaXRlbXM6DQo+Pj4+ICsgICAgICBtaW5pbXVtOiAweDM4
DQo+Pj4+ICsgICAgICBtYXhpbXVtOiAweDNmDQo+Pg0KPj4+IC4uLiBTbyB0aGVzZSBhcmUgZml4
ZWQ/IE5vIG5lZWQgdG8gZW5jb2RlIHRoZW0gaW4gc3VjaCBjYXNlLi4uDQo+Pg0KPj4gSSdtIG5v
dCBzdXJlIEkgdW5kZXJzdGFuZCB5b3VyIGNvbmNlcm4gaGVyZSwgdGhlcmUncyB1cCB0byA0IHBv
c3NpYmxlIA0KPj4gdmFsdWVzIGZyb20gMHgzOC0weDNmIHdoaWNoIGhhcyBtb3JlIHRoYW4gNCBw
b3NzaWJsZSB2YWx1ZXMuDQo+IA0KPiBBcmVuJ3QgdGhlIGFkZHJlc3NlcyBnb2luZyB0byBiZSBp
bmNyZW1lbnRlZCBieSBvbmUgKHVwIHRvIDggb2YgZGV2aWNlcyBpbiB0b3RhbCk/DQoNCldpdGgg
eW91ciBzdHlsZSBvZiByZXBsaWVzLCBpdCBsb29rcyBsaWtlIHlvdSB3cm90ZSBpdC4uLg0KDQpB
bGwgdGhlIGFkZHJlc3NlcyBvZiB0YXMyNzgxIGFyZSBpbiByYW5nZSBmcm9tIDB4MzggdG8gMHgg
M2YsIHRoZSBvcmRlciBvZiB0aGVtIGluIHRoZSBhdWRpby1zbG90cyBpdGVtIGFyZSB1cCB0byB0
aGUgaGFyZHdhcmUgY29ubmVjdGlvbnMuDQpJIGhhdmUgc3R1ZGllZCB0aGUgcmVnIGl0ZW0gdG8g
c2F2ZSBtdWx0aXBsZSBpMmMgYWRkcmVzc2VzIGZvciBtdWx0aXBsZSBwaWVjZXMgb2YgdGFzMjc4
MSBhbmQgZm91bmQgdGhhdCAiJyNhZGRyZXNzLWNlbGxzJzogICAgIG1heGltdW06IDMiDQp0aGF0
IG1lYW5zICJyZWciIHN0b3JlIG5vdCBtb3JlIHRoYW4gdGhyZWUgYWRkcmVzc2VzLCB0aGlzIGNh
bid0IHN1cHBvcnQgdGhlIG1vcmUgdGhhbiAzIHBpZWNlcyBvZiB0YXMyNzgxLCANCnN1Y2ggYXMg
NC1zbG90IFRETSBjYXNlIG9yIG11bHRpcGxlIGR1YWwtbWVtYnJhbmUgc3BlYWtlcnMgY2FzZSwg
aW4gc3VjaCBhIGNhc2UsIG9uZSBzcGVha2VyIHdpbGwgdXNlDQogdHdvIHBpZWNlcyBvZiB0YXMy
NzgxIHRvIGJvb3N0LCB1c3VhbGx5IGF0IGxlYXN0IDYgcGllY2VzIG9mIHRhczI3ODEgd2lsbCBi
ZSB1c2VkIGluIGEgbGFwdG9wIG9yIG90aGVyIGRldmljZS4NCg0KPiANCj4gTm8sIHRoZSBpMmMg
YWRkcmVzcyBvcmRlciBpcyBub3QgYWx3YXlzIG1vbm90b25pYyBpbmNyZWFzZSBvciBkZWNyZWFz
ZSwgc29tZXRpbWUgaXQgd291bGQgYmUgZGlzb3JkZXIsIGFjY29yZGluZyB0byB0aGUgYXBwbGlj
YXRpb24uDQo+IEVhY2ggZGV2aWNlIHdvdWxkIGhhdmUgZWlnaHQgcG9zc2libGUgaTJjIGFkZHJl
c3MsIHRoZSBmaW5hbCBhZGRyZXNzIGRlcGVuZHMgb24gdGhlIGhhcmR3YXJlIGNvbm5lY3Rpb25z
Lg0KDQpPSywgdGhlIHF1ZXN0aW9uIGFib3V0IHRoZSBicm9hZGNhc3QgaXMgc3RpbGwgdGhlcmUg
LSBjYW5ub3QgaXQgYmUgZGVkdWNlZD8NCg0KVGhlIHJlYXNvbiB0byBkZWZpbmUgdGhpcyBpdGVt
IGFuZCBhZGQgaXQgaW4gZHRzIGlzIHRoYXQgdGVsbCB0YXMyNzgxIGRyaXZlciBjb2RlIHRvIGVu
YWJsZSBicm9hZGNhc3QgYW5kIGl0cyBhZGRyZXNzLiANClJlbW92aW5nIHRoaXMgaXRlbSBtZWFu
cyBkaXNhYmxpbmcgYnJvYWRjYXN0LiBEbyB5b3Ugd2FudCB0byBoYXJkY29kZSB0aGUgZ2xvYmFs
IGFkZHJlc3MgaW4gdGhlIGNvZGU/DQpBbmQgdGhpcyBpdGVtIG9ubHkgdXNlZCBhcyBhIGZsYWcg
dG8gZW5hYmxlIG9yIGRpc2FibGU/DQoNCkJlc3QgcmVnYXJkcywNCktyenlzenRvZg0KDQo=
