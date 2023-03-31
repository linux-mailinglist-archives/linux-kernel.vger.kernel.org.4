Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0AF6D158D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 04:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjCaCVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 22:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCaCVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 22:21:14 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6F5C17E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 19:21:12 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32V2JgvP091623;
        Thu, 30 Mar 2023 21:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680229182;
        bh=unyTBO4Ygm+1ODxAbCPxACaeUdm0WzLSPlIfSATDC4M=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=pO7AKfxKxhUumVESD5UQ8nW3rXWMHBn2RI7HBqd8WgDznCm/jZkHHtVZX16Yhrvmg
         sLKp/ZEgcm3JbyDae84gnxWmv+yHOoQe0X5ak96NDtVRc9GUAkH+CFvmJxDbE92DiB
         bZJhag4+zw/bETuryAREXxdIFKBR8iLiZJMyQy0c=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32V2Jgwn057153
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Mar 2023 21:19:42 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 30
 Mar 2023 21:19:42 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.016; Thu, 30 Mar 2023 21:19:42 -0500
From:   "Ding, Shenghao" <shenghao-ding@ti.com>
To:     Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>,
        Shenghao Ding <13916275206@139.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
CC:     "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v10] ASoC: tas2781: Add tas2781 driver
Thread-Topic: [EXTERNAL] Re: [PATCH v10] ASoC: tas2781: Add tas2781 driver
Thread-Index: AQHZYv5dO/gdHn+1qke4qmD6peEJfK8UJ1NQ
Date:   Fri, 31 Mar 2023 02:19:42 +0000
Message-ID: <7a0cfa60e2a244168edd49c3d2f6a2bd@ti.com>
References: <20230329100107.8181-1-13916275206@139.com>
 <8d0d0478-1e45-ea52-f1b7-910b747d6282@linux.intel.com>
In-Reply-To: <8d0d0478-1e45-ea52-f1b7-910b747d6282@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.160.107]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW1hZGV1c3ogU8WCYXdpxYRza2kNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KQW5zd2Vy
IGlubGluZS4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFtYWRldXN6IFPF
gmF3acWEc2tpIDxhbWFkZXVzenguc2xhd2luc2tpQGxpbnV4LmludGVsLmNvbT4gDQpTZW50OiBU
aHVyc2RheSwgTWFyY2ggMzAsIDIwMjMgNzo1NCBQTQ0KVG86IFNoZW5naGFvIERpbmcgPDEzOTE2
Mjc1MjA2QDEzOS5jb20+OyBicm9vbmllQGtlcm5lbC5vcmc7IGxnaXJkd29vZEBnbWFpbC5jb207
IHBlcmV4QHBlcmV4LmN6OyBwaWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb20NCkNj
OiBMdSwgS2V2aW4gPGtldmluLWx1QHRpLmNvbT47IERpbmcsIFNoZW5naGFvIDxzaGVuZ2hhby1k
aW5nQHRpLmNvbT47IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgWHUsIEJhb2p1biA8eDEwNzcwMTJAdGkuY29tPjsgR3VwdGEsIFBlZXl1
c2ggPHBlZXl1c2hAdGkuY29tPjsgTmF2YWRhIEthbnlhbmEsIE11a3VuZCA8bmF2YWRhQHRpLmNv
bT4NClN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2MTBdIEFTb0M6IHRhczI3ODE6IEFk
ZCB0YXMyNzgxIGRyaXZlcg0KDQpPbiAzLzI5LzIwMjMgMTI6MDEgUE0sIFNoZW5naGFvIERpbmcg
d3JvdGU6DQo+IENyZWF0ZSB0YXMyNzgxIGRyaXZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNo
ZW5naGFvIERpbmcgPDEzOTE2Mjc1MjA2QDEzOS5jb20+DQo+IA0KPiAtLS0NCj4gQ2hhbmdlcyBp
biB2MTA6DQo+ICAgLSB1c2luZyBiZTE2X3RvX2NwdSBhbmQgYmUzMl90b19jcHUgaW5zdGVhZCBv
ZiBTTVNfSFRPTlMgYW5kIFNNU19IVE9OTA0KPiAgIC0gb3B0aW1pemUgYW5kIHJlZHVjZSB0aGUg
Ym91bmRhcnkgY2hlY2tzDQo+ICAgLSBBZGQgY29tbWVudHMgb24gc29tZSBrbWVtZHVwIGluc3Rl
YWQgb2Yga3phbGxvYyttZW1jcHkNCj4gICBDaGFuZ2VzIHRvIGJlIGNvbW1pdHRlZDoNCj4gCW1v
ZGlmaWVkOiAgIHNvdW5kL3NvYy9jb2RlY3MvS2NvbmZpZw0KPiAJbW9kaWZpZWQ6ICAgc291bmQv
c29jL2NvZGVjcy9NYWtlZmlsZQ0KPiAJbmV3IGZpbGU6ICAgc291bmQvc29jL2NvZGVjcy90YXMy
NzgxLWRzcC5jDQo+IAluZXcgZmlsZTogICBzb3VuZC9zb2MvY29kZWNzL3RhczI3ODEtZHNwLmgN
Cj4gCW5ldyBmaWxlOiAgIHNvdW5kL3NvYy9jb2RlY3MvdGFzMjc4MS1pMmMuYw0KPiAJbmV3IGZp
bGU6ICAgc291bmQvc29jL2NvZGVjcy90YXMyNzgxLmgNCj4gLS0tDQoNCi4uLg0KDQo+ICsNCj4g
K3N0YXRpYyBpbnQgZndfcGFyc2VfYmxvY2tfZGF0YV9rZXJuZWwoc3RydWN0IHRhc2RldmljZV9m
dyAqdGFzX2ZtdywNCj4gKwlzdHJ1Y3QgdGFzZGV2X2JsayAqYmxvY2ssIGNvbnN0IHN0cnVjdCBm
aXJtd2FyZSAqZm13LCBpbnQgb2Zmc2V0KSB7DQo+ICsJY29uc3QgdW5zaWduZWQgY2hhciAqZGF0
YSA9IGZtdy0+ZGF0YTsNCj4gKw0KPiArCWlmIChvZmZzZXQgKyAxNiA+IGZtdy0+c2l6ZSkgew0K
PiArCQlkZXZfZXJyKHRhc19mbXctPmRldiwgIiVzOiBGaWxlIFNpemUgZXJyb3JcbiIsIF9fZnVu
Y19fKTsNCj4gKwkJb2Zmc2V0ID0gLUVJTlZBTDsNCj4gKwkJZ290byBvdXQ7DQo+ICsJfQ0KPiAr
CWJsb2NrLT50eXBlID0gYmUzMl90b19jcHVwKChfX2JlMzIgKikmZGF0YVtvZmZzZXRdKTsNCg0K
V291bGRuJ3QganVzdCBiZTMyX3RvX2NwdShkYXRhW29mZnNldF0pIHdvcmsgaW5zdGVhZCBvZiBi
ZTMyX3RvX2NwdXA/IA0KU2FtZSBpbiBvdGhlciBjYXNlcy4NCltESU5HXSBkYXRhW10gaXMgYSBj
aGFyIGFycmF5LCB0aGUgY29kZSB3aWxsIGNvbnZlcnQgZGF0YVtvZmZzZXRdLCBkYXRhW29mZnNl
dCArIDFdLCANCmRhdGFbb2Zmc2V0ICsgMl0gYW5kIGRhdGFbb2Zmc2V0ICsgM10gaW50byBob3N0
IGluc3RlYWQgb2YgZGF0YVtvZmZzZXRdIG9ubHkuDQoNCg==
