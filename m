Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B4B655F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 04:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiLZDMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 22:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLZDMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 22:12:46 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0E6388A;
        Sun, 25 Dec 2022 19:12:41 -0800 (PST)
X-UUID: 6b7ba0633f0b4c04bdabfd6d1a375872-20221226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0RGMsfvBkY7lgi9HWLTV6CYFCnu6rjP/RWt+G6FwJZA=;
        b=CoVh3BkT576l85nkFE5gLqbau4QvEjpRnK5kTz0zdBP2Mp/SKzag30KODeRmhFJCeZfnTQNYiveJ7e9ZiwWEl1pR2z6WNk2asJPM41AGCB1lv2wViUjnWTeBKWfsA5zHho/zMM6jin3xVB753Y54oZ+o77eDTT3AllQ6tPHgELw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:ab3ffa73-933d-4ee8-a3c0-833ee84e453f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:7fd4c352-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6b7ba0633f0b4c04bdabfd6d1a375872-20221226
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 43478172; Mon, 26 Dec 2022 11:12:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 26 Dec 2022 11:12:32 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 26 Dec 2022 11:12:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktsohy72uWtPNq/Dq0EPiTgXJhKoCGJgHMYCDeLCrG/PpcyKWzMd5ChLChcd3CV9UdV/MSyJZmIcnvkqhbNzOS1MFhx0G0EzUJ1kfvoCig4qgbLaiBK2HRVOnY3punN3sjqsIjHf3BayK3xq5FABsvWOzyHitdS+0wPROCfKCGDKn9iCccP0+XCXGWjCjIHvbUzhSkEm59qOatnXC/sV/K7Esig9o13pFqIJMEdlnrnYGLGzPTsp/Zy8MVNUvyP00lQzHXynRAoBqrGYSquMEOZCk7oRjig8N4bMtiRlNk0fp3P26nVh02FDcYqJ1YjyxPCXdMUSCjiQBBjUb5Kt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RGMsfvBkY7lgi9HWLTV6CYFCnu6rjP/RWt+G6FwJZA=;
 b=TZTtLxpqY7av/5fvpK1ghECK/UPUKYqZPlv3u7AJaXLDyXCImUOkNI9PeG+/mxH37Ek5roOGg2MLbE1GcSWUkQChxRpUYnEuUllC0CHDhbwgbWK22Y/F+YK28iouHQw7dFsDbC8mg6Nj82BgT7TiYhrh68K09bfPN7nQvlGyGqnecRQx/rHl5mGEyWsNfotP30rpFq5t0cj74mlF2uVcG2sN/EqwMMOB/OmvZLk6+kqC+Zn0dgig01837d3GuKGqXuggcPIGACyTfqDuuczTbrCBD77dC3Sk+Di81obMRey3tRle7YjSKRJ7qdaDVdFKMwWNSvvDo4HmfGvFsEXuZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RGMsfvBkY7lgi9HWLTV6CYFCnu6rjP/RWt+G6FwJZA=;
 b=gG+3/dDQE6f7VYUtqnuMYoK73NQ4UAi26IkcT23W4duHN5kQdBW43yTXWM7A7w1irdrSsB5JEFLVjmWAz89b3pFC8SznKobKZnfJyykc3idTz6j0315LvZpqv3ehHaxc/zmJVxQDNJ/9uvLkxmT6yMQ9IbdOx5rj9Uv5Y7fyN90=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR0302MB5426.apcprd03.prod.outlook.com (2603:1096:820:46::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Mon, 26 Dec
 2022 03:12:29 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::99:4418:290a:ce5d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::99:4418:290a:ce5d%9]) with mapi id 15.20.5924.016; Mon, 26 Dec 2022
 03:12:28 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "granquet@baylibre.com" <granquet@baylibre.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?U3R1YXJ0IExlZSAo5p2O57+wKQ==?= <Stuart.Lee@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 07/12] drm/mediatek: hdmi: add v2 support
Thread-Topic: [PATCH v3 07/12] drm/mediatek: hdmi: add v2 support
Thread-Index: AQHY8Ffe+1ZB8K1DFUKMHr1G5htplK5/zxOA
Date:   Mon, 26 Dec 2022 03:12:28 +0000
Message-ID: <8060f38c3db6d2f6e1cb7eb6d6bbc199d289aa7d.camel@mediatek.com>
References: <20220919-v3-0-a803f2660127@baylibre.com>
         <20220919-v3-7-a803f2660127@baylibre.com>
In-Reply-To: <20220919-v3-7-a803f2660127@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR0302MB5426:EE_
x-ms-office365-filtering-correlation-id: 671d5c17-2ce6-454c-55a7-08dae6ef053f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tzbiuEcFCiXN7KS7drRcfulSpppdtgnlNQw/G0r43IU24iCiKsOWk/P0O9IwKvbw/OXXkv80411EQ2yHKcjIHAVKm30bDf+PBxRVKOt5TohU7ox4pVUwrS81x30z280mSyUE4tqe0gSgBSViIyavBio69gC0TJ8GI49V0F02Gnlv/UkT16HNs3UYTfKekc6NlFCxl/2PvOtMln06v/1Oj4cJqKYif7HF21vmWEeGbbql8AxLE/0opob42IHYqR8PDorlMcpmyc37Djcp/bMMjOK9Tfp4/Qh/nuIO1j58mzcTEfoCjSWxY6CWS3jjDJQaSTf325G842slwRinAQfcOKamUtGEHt3zmnTumapkLsHmyXJjSX2vXJB9Feeevc30pbcj2ZTmH0wyl52h/Toa7Pq1aCOflFM6C8pSreoBxOY/cl3K6C6KwOgY0vH3PW5dVqZ4XmmNQGKKtRgO7Rk/+2g5wRt5lInc+DJ6+ZjH82GRJy5KMNbPKhVLPUYSltTpWfuSIVnuJ/xbsf1pSvMd5Uij8iayAnzkNQEisKIp7C7bM9dFsUAYFvg3hAZOD3ugds+Bd/uky2plKrqyg/qCHhGHlc1e8AG5HE9LNnAzRo0DfP3/7JRDYo8ubDCWd2kEe9cMbo7uV0lcLWRc9Fh5jwvhWJ05OJ1Z1e8t/feyqxNB8KwVUqot65klBe4TRb6w02juckQIzlOR70Ji7Imq9/MY9KbAPSkj+uh7c/MML7gegUUBBnIKSYjzc8b1sMJI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(6506007)(71200400001)(41300700001)(186003)(26005)(6512007)(2616005)(83380400001)(478600001)(7416002)(85182001)(122000001)(36756003)(38100700002)(110136005)(54906003)(921005)(8936002)(2906002)(38070700005)(316002)(6486002)(966005)(5660300002)(86362001)(76116006)(66946007)(66556008)(66476007)(66446008)(4326008)(8676002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clpxK2d0aDc0a045d2ZTR1FacHRZTjBWSGg3UVBzQ3VraHJIeVBkMVVzQ2dl?=
 =?utf-8?B?NVdaZEE0T2ZvQXpnYWpNK21SaFpGOFI3VFZvM1VtU21Sb2FtWkVMdVlUVFMv?=
 =?utf-8?B?R2trMnowaFRJaHoxc05mQ3pVWFNxTTNxaFdiNEdXTXArYXZMcVQ5aGNvclFF?=
 =?utf-8?B?dzV1V3daSE9YMFRaWmxMb0ZKZXJzb1lmWTJydnFCOCtyUGJhM0VGOXRnMmF2?=
 =?utf-8?B?ZitFbU1oMkQ1VEVUVVo1Ym5jOGZOWGs5SWRhYW0yUjdPeHFmWklCblZ1RFF3?=
 =?utf-8?B?b0UrTnVCM21BdWJJVFpLeXJJZG9RYVRPQXFjczVYeEdwNXE2STRWVWRlbDho?=
 =?utf-8?B?UDdTMWh1c0t1ckZtZlQ5RFN4V3FnYXRCNGROOUJQd2haQ1BHRDk1b1lGTlJu?=
 =?utf-8?B?WHROYUd5UEVlTDJYZ2xEVnJ1ZmlPSUE4a0huYUZXb1NDbEI5d3BGNUY2RWg3?=
 =?utf-8?B?Z2ZzT3RjbWJCQmtacHpSMmhKTlo3cVh1dUNxS0dXR2wrRVVCeGNHbmVlUDls?=
 =?utf-8?B?bWxvcGhwS2NVN1Y5TDJ3RXRSeVVza2FMU3ZaZUtZS1FvTnZ0ekxQVUQ4L3pP?=
 =?utf-8?B?VlphZDIzRm1RSEhRNnQyeHozUTduaWtHbkxVZllqbWc1ZzB2S1J6bzVMOGQw?=
 =?utf-8?B?RHZPRzhBUzlwQ0VSTGovODhqcXNqTDR6cFNWTC9RditSSjZoZSs2NkFBNS8r?=
 =?utf-8?B?RmgwbDJWQmZIWFQrMzdEdkVJZ2V6dzcxKzRpeUx2RTZNTnBuNm1XcTJ1NFVW?=
 =?utf-8?B?bUNLRzZ5UEE5SHJMNTV3ZTFCYlo0TnhieGhlelFheFBuSUxOMFVsWEN5bWhu?=
 =?utf-8?B?b0F0NWp2bDFsdGt2VkZlMnVncXBxOEp3bFJ6SHB1V3ByZk5PdTlDUElSeHBz?=
 =?utf-8?B?WkxWTzBxRTNPcWNad2FTeWRHTDY5VFBDbGR5dko3SW9IQW9JUHNoVzNzZkpV?=
 =?utf-8?B?bUNWN3VHeEFGR1ZZSWJvR1duUkFBQ1hYMUNLUjFyLzNkQ3ZxbFhYZjFiaFdT?=
 =?utf-8?B?Z2dMNGNqbzg0NENnNTI1NFloNElqK3VSOUlkUHVTZTJ1aHFURkVCRllBR0xN?=
 =?utf-8?B?TXp4SGpqYlhRUXh1N0dlbk12anBOdS9SeG9kdEUwc3N5VzhraHhRU243bmtF?=
 =?utf-8?B?TDlGNU9jSGVYbFBqTFhpMi90T3JKbXFrUWFhZS9RN1VzK0MrcXozYzU2bHEw?=
 =?utf-8?B?bE5YQ2w2Y2ppbHNrVE1VUklDK0RETCtpNERyQmNBZmtVUTBoL0FPdXpidVZJ?=
 =?utf-8?B?cC9rUVJRNis1L1hLYkVJcmQvclJGRUpWWmpqd2tkN2FsMnJxcVJXZWVPTkxB?=
 =?utf-8?B?a3I5dS81a0xQcVpVMnpObExKK3JMVFRqK1c5V0o0R25PNzFzOUtaNGM4d2JE?=
 =?utf-8?B?bGx3QVBrK2JUUGgrSXBFcUFhemRLbE5RK3lJMDFXTFZ1eVBNS0x3UUhxV0F5?=
 =?utf-8?B?T0QyZU1VK1Nwa2xQMVJnNzdEVTBrekxwemNhSTFoaGhLNGpHeGEwY1RyM2sy?=
 =?utf-8?B?NkNQWXI0QktHNHE0elVDMjliSjdoR3FwTVdpNy9KOE02T0sxOEJzaTI1eURI?=
 =?utf-8?B?bFhsN1kwd3UwM1Z0alJkT3hSdFdzNXdraGVMTG45TmQrTDNVQXZLaVZucjZG?=
 =?utf-8?B?ZXUvWmJhQnM0bFhWTWFmV3VhYUwwM1NCQXAxSUVmVmFoSml0ZjNuSkkvOEZP?=
 =?utf-8?B?RThOQkE0ZmUxOXFiZGFjdHdZcEdjU0kwdGxnM01KTWw4RTVRZUFORC9pTGlZ?=
 =?utf-8?B?YThLc2hTMFpqS2VjemtMSTN3a1JNN2dGSW54UUkvMVA4ZmthdHhObTgrMXU3?=
 =?utf-8?B?ckZCTGVzeDhSTXBPcGw0ZWpUSHJiaVpXV3VraEFWaXpjaS9FbnpqZ0QxOC9W?=
 =?utf-8?B?dzdoZG1rQk54ZStjOXI5V3lscS94WE82WFlHR1M0UEdULzBmVnhGaXppVHdB?=
 =?utf-8?B?a3NERm9jbVlvNktWQ3FLSHl6U29FU1lIdExWZlNzNDIxSHBhZU9lWlE1Wkg2?=
 =?utf-8?B?aUUwZUNlVUp0RjByWnVTbHUyUUY4ZXFzZlVBZDltSlhiMmo2S241NGZoVU9k?=
 =?utf-8?B?SzNNSEcybmhCb0Y4L2JHWGdXQ2J4bEVGNE1zSmh5YVlMMGNNNkNJSTJiVFUx?=
 =?utf-8?Q?F8N3frvR6EqOFbXFCn8afug6Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBB0875CF0C81D4386E7E75B9205AE30@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671d5c17-2ce6-454c-55a7-08dae6ef053f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2022 03:12:28.5643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVgZaLaCA4K31L3t/c5BZkCvCBrMpdtRcswA58XK3FgygR6CFlVhs/BVbpL7tODsOOLHIv9T79fYpn3plW2H4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5426
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEd1aWxsYXVtZToNCg0KT24gRnJpLCAyMDIyLTExLTA0IGF0IDE1OjA5ICswMTAwLCBHdWls
bGF1bWUgUmFucXVldCB3cm90ZToNCj4gQWRkcyBoZG1pIGFuZCBoZG1pLWRkYyBzdXBwb3J0IGZv
ciB2MiBJUC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1aWxsYXVtZSBSYW5xdWV0IDxncmFucXVl
dEBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2Vm
aWxlICAgICAgICAgICB8ICAgIDIgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19o
ZG1pX2NvbW1vbi5jICB8ICAgMTQgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19o
ZG1pX2NvbW1vbi5oICB8ICAgIDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19o
ZG1pX2RkY192Mi5jICB8ICAzNjcgKysrKysrKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19oZG1pX3JlZ3NfdjIuaCB8ICAzMDkgKysrKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2hkbWlfdjIuYyAgICAgIHwgMTM3OQ0KPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV92Mi5oICAgICAgfCAg
IDI5ICsNCj4gIDcgZmlsZXMgY2hhbmdlZCwgMjEwMSBpbnNlcnRpb25zKCspDQo+IA0KPiANCg0K
W3NuaXBdDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRt
aV9yZWdzX3YyLmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWlfcmVnc192
Mi5oDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uZjRjMzY1
MmY0ZWFiDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19oZG1pX3JlZ3NfdjIuaA0KPiBAQCAtMCwwICsxLDMwOSBAQA0KPiArLyogU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gKy8qDQo+ICsgKiBDb3B5cmlnaHQgKGMpIDIw
MjEgTWVkaWFUZWsgSW5jLg0KPiArICogQ29weXJpZ2h0IChjKSAyMDIxIEJheUxpYnJlLCBTQVMN
Cj4gKyAqLw0KPiArDQo+ICsjaWZuZGVmIF9NVEtfSERNSV9SRUdTX0gNCj4gKyNkZWZpbmUgX01U
S19IRE1JX1JFR1NfSA0KPiArDQo+ICsjZGVmaW5lIEFJRl9IRUFERVIgR0VOTUFTSygxOSwgMCkN
Cj4gKyNkZWZpbmUgQUlGX1BLVDAwIEdFTk1BU0soMzEsIDApDQo+ICsjZGVmaW5lIEFJRl9QS1Qw
MSAoMjMsIDApDQo+ICsjZGVmaW5lIEFJRl9QS1QwMiAoMzEsIDApDQo+ICsjZGVmaW5lIEFJRl9Q
S1QwMyAoMjMsIDApDQoNClVzZWxlc3MsIGRyb3AgaXQuDQoNCj4gKw0KPiArI2RlZmluZSBBSVBf
Q1RSTCBCSVQoMTApDQoNCkkgdGhpbmsgdGhpcyBpcw0KDQojZGVmaW5lIEFJUF9DVFJMIDB4NDAw
DQoNCg0KPiArI2RlZmluZSBBSVBfQ1RTX1NWQUwgMHg0MDgNCj4gKyNkZWZpbmUgQUlQX0RPV05T
QU1QTEVfQ1RSTCAweDQxQw0KPiArI2RlZmluZSBBSVBfSTJTX0NIU1QwIDB4NDE0DQo+ICsjZGVm
aW5lIEFJUF9JMlNfQ0hTVDEgMHg0MTgNCj4gKyNkZWZpbmUgQUlQX0kyU19DVFJMIDB4NDEwDQo+
ICsjZGVmaW5lIEFJUF9OX1ZBTCAweDQwNA0KPiArI2RlZmluZSBBSVBfU1BESUZfQ1RSTCAweDQw
Qw0KPiArI2RlZmluZSBBSVBfVFBJX0NUUkwgMHg0MjgNCj4gKyNkZWZpbmUgQUlQX1RYQ1RSTCAw
eDQyNA0KPiArDQo+ICsjZGVmaW5lIEFVRF9ESVMgKDB4MCkNCj4gKyNkZWZpbmUgQVVEX0RJU19X
UiAoMHgwKQ0KPiArI2RlZmluZSBBVURfRU4gQklUKDIpDQo+ICsjZGVmaW5lIEFVRF9FTl9XUiBC
SVQoMTgpDQo+ICsjZGVmaW5lIEFVRF9FUlJfVEhSRVNIIEdFTk1BU0soMjksIDI0KQ0KPiArI2Rl
ZmluZSBBVURfSU5fRU4gQklUKDgpDQo+ICsjZGVmaW5lIEFVRF9NVVRFX0RJUyAoMHgwKQ0KPiAr
I2RlZmluZSBBVURfTVVURV9GSUZPX0VOIEJJVCg1KQ0KPiArI2RlZmluZSBBVURfUEFDS0VUX0RS
T1AgQklUKDYpDQo+ICsjZGVmaW5lIEFVRF9SUFRfRElTICgweDApDQo+ICsjZGVmaW5lIEFVRF9S
UFRfRU4gQklUKDIpDQo+ICsjZGVmaW5lIEFVRF9TRUxfT1dSVCBCSVQoOSkNCg0KSSB3b3VsZCBs
aWtlIHRvIHB1dCB0aGUgYml0d2lzZSBkZWZpbml0aW9uIHdpdGggZG91YmxlIHdvcmQgZGVmaW5p
dGlvbg0KdG9nZXRoZXIuIFlvdSBjb3VsZCByZWZlcmVuY2UgWzFdLg0KDQpbMV0gDQpodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5n
aXQvdHJlZS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jP2g9djYuMi1y
YzENCg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArDQo+ICsjZGVmaW5lIEFWSV9ESVMgKDApDQo+ICsj
ZGVmaW5lIEFWSV9ESVNfV1IgKDApDQo+ICsjZGVmaW5lIEFWSV9FTiAoMHgxKQ0KPiArI2RlZmlu
ZSBBVklfRU5fV1IgQklUKDE2KQ0KPiArI2RlZmluZSBBVklfSEVBREVSIEdFTk1BU0soMjMsIDAp
DQo+ICsjZGVmaW5lIEFWSV9QS1QwMCBHRU5NQVNLKDMxLCAwKQ0KPiArI2RlZmluZSBBVklfUEtU
MDEgR0VOTUFTSygyMywgMCkNCj4gKyNkZWZpbmUgQVZJX1BLVDAyIEdFTk1BU0soMzEsIDApDQo+
ICsjZGVmaW5lIEFWSV9QS1QwMyBHRU5NQVNLKDIzLCAwKQ0KPiArI2RlZmluZSBBVklfUEtUMDQg
R0VOTUFTSygzMSwgMCkNCj4gKyNkZWZpbmUgQVZJX1BLVDA1IEdFTk1BU0soMjMsIDApDQo+ICsj
ZGVmaW5lIEFWSV9SUFRfRElTICgweDApDQo+ICsjZGVmaW5lIEFWSV9SUFRfRU4gKDB4MSkNCj4g
Kw0KPiArI2RlZmluZSBDNDIyX0M0MjBfQ09ORklHX0JZUEFTUyBCSVQoNSkNCj4gKyNkZWZpbmUg
QzQyMl9DNDIwX0NPTkZJR19FTkFCTEUgQklUKDQpDQo+ICsjZGVmaW5lIEM0MjJfQzQyMF9DT05G
SUdfT1VUX0NCX09SX0NSIEJJVCg2KQ0KPiArI2RlZmluZSBDNDQ0X0M0MjJfQ09ORklHX0VOQUJM
RSAoMHgxKQ0KPiArDQo+ICsjZGVmaW5lIENCSVRfT1JERVJfU0FNRSBCSVQoMTMpDQo+ICsNCj4g
KyNkZWZpbmUgQ0VBX0FVRF9FTiBCSVQoOSkNCj4gKyNkZWZpbmUgQ0VBX0FWSV9FTiBCSVQoMTEp
DQo+ICsjZGVmaW5lIENFQV9DUF9FTiBCSVQoNikNCj4gKyNkZWZpbmUgQ0VBX1NQRF9FTiBCSVQo
MTApDQo+ICsNCj4gKyNkZWZpbmUgQ0xFQVJfRklGTyAweDkNCj4gKw0KPiArI2RlZmluZSBDTE9D
S19TQ0wgMHhBDQo+ICsNCj4gKyNkZWZpbmUgQ1BfQ0xSX01VVEVfRU4gQklUKDEpDQo+ICsjZGVm
aW5lIENQX0VOIEJJVCg1KQ0KPiArI2RlZmluZSBDUF9FTl9XUiBCSVQoMjEpDQo+ICsjZGVmaW5l
IENQX1JQVF9FTiBCSVQoNSkNCj4gKyNkZWZpbmUgQ1BfU0VUX01VVEVfRElTICgwKQ0KPiArI2Rl
ZmluZSBDUF9TRVRfTVVURV9FTiAoMSkNCj4gKw0KPiArI2RlZmluZSBDVFNfQ0FMX040IEJJVCgy
MykNCj4gKyNkZWZpbmUgQ1RTX1JFUV9FTiBCSVQoMSkNCj4gKyNkZWZpbmUgQ1RTX1NXX1NFTCAo
MSkNCj4gKw0KPiANCg==
