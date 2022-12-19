Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E8A6507C3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiLSGoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiLSGnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:43:20 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB4A626A;
        Sun, 18 Dec 2022 22:42:42 -0800 (PST)
X-UUID: 47e5d6f9f49941bf99500eea425f426f-20221219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fujF3XWe4JM0MavFRZYW5x/onpaTflah7wl4kOMuu0o=;
        b=nHVwI1OhjhQBcvjEP8XHocuLo/DrX8y7Ckfm3SEnvRUPVnrC4J3MZ4yeMt+Ya69jvwGZAX9xveJOqtgiKgq+GoFjXFMfu+N1mHhY7Sv+RS12hhdZFRt11UPrC/bW80Q8nhgzFmbib8mp7ig/Vgcei1ztmRzRVDZ7WQZlmxk6crw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:ae3cca17-3e58-44ce-82fa-6236bc0d3955,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:8c98bc89-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 47e5d6f9f49941bf99500eea425f426f-20221219
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 427637115; Mon, 19 Dec 2022 14:42:38 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 19 Dec 2022 14:42:34 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 19 Dec 2022 14:42:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjfBTSzA7rdCQDmaWLMBz3lknXkJ3SlxUPw+V4yG1LTsHoKvHZjb8LlbANm8ftWkeB+yq/74yyyyOeVkwjvv81pJQ5TDHN4Sv2ne11ERTXId5vpkOmYB1UJt9ZC9tSzxTw/1JC3IJJxqEx13mAovLCd2kpZ4ROI5pFUiTVE5N2S5KP2+KPNLS1YFCSGaTKnziSfeHuPVgP2rf5oHHNMWc+uhzF9hYa3T9tV9oYWAWanO2gt+pOtimA8CdrWLsxxkZYjp+XQovDyUsdyzy+tO4VLHH+VyCj0K0vcxKEI9RxbKPtfi0JxrL50kSKhJF48qogOShwMkqPg8AS4uNL6GkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fujF3XWe4JM0MavFRZYW5x/onpaTflah7wl4kOMuu0o=;
 b=hxhanuw5WKrgezz1qbWU6RRrtIW7QwPWSbbHO5gAGEDwc+FIqdCEMg8Ub8UOr0FFn4wN1dyqIV2/b0p5ZMQ68HTxdvQ9SXelSmFXzJJgGQPulTHBlI4X3UEy12QNMtYJ9x2l81ENSMLIl+zcULVeKXYC7hbIXThX1p/LojRUND5QxQFm/A3hG/rS1+r5O/UeMlTXWU6EMadBjB3hWi5qkIk+HG287pEk1t6CCOSmLjHmYjD85fqOCinXi/BPIWo/rKUjnS/J5fQiKZdZdQqvaW0t5TE/N8WRn38ButXQKs2Nn6IvB/5Ab2AkoNMYeU3xA9+sK1PlibHdoCctL1fmMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fujF3XWe4JM0MavFRZYW5x/onpaTflah7wl4kOMuu0o=;
 b=RNgpTI84JayCtQPdJeyu6MFHjA/p7NpgBvyj85XaxiqAWsVh/RWDgpmWyf9pbFE/VVpVGIo9e3MISvLJw0qMDGe0yv1L2SnrA9/AUXiQzwxLAXnHuyvDzx4ufBLhXkqzAdGTHw407WqrGx/VxDIlETGvVP2AGKE3mgnfr1GrhDc=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYZPR03MB5533.apcprd03.prod.outlook.com (2603:1096:400:56::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 06:42:31 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::5a1c:8321:d329:db44]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::5a1c:8321:d329:db44%7]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 06:42:31 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/5] media: mediatek: vcodec: add params to record lat and
 core lat_buf count
Thread-Topic: [PATCH 1/5] media: mediatek: vcodec: add params to record lat
 and core lat_buf count
Thread-Index: AQHZDGmkI9Ot+ww4uEiN56E34TDGB65rjIAAgAlEzgA=
Date:   Mon, 19 Dec 2022 06:42:31 +0000
Message-ID: <9644b2fa60b308010c4fb5602a4c3083027f1027.camel@mediatek.com>
References: <20221210073218.17350-1-yunfei.dong@mediatek.com>
         <20221210073218.17350-2-yunfei.dong@mediatek.com>
         <7e668b90-e3e6-5d25-e894-f754662405af@collabora.com>
In-Reply-To: <7e668b90-e3e6-5d25-e894-f754662405af@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYZPR03MB5533:EE_
x-ms-office365-filtering-correlation-id: ecb218a8-9ba4-4da3-5f21-08dae18c340d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ad8LoTuYecuylNedOLU4KE6nmOe5strBpHqPqol+U8fQOy/scugzdZZCsVjMdesUCz4T+IrwRdjv/RYY4y+u29jSO82aNnxskOkeHr3qEy8N1lO9WBGAFY4DGVjVtd9P5nkHzSCIqi9rO0QrvwZZEnYZqFzdsPy2ouCLeB2jpGPAh/DEbnI0noBaYgLTLCiaLrP3I9hgmWj7B8Q7sTiuIVQ+eHSWw37UfzZTc9L68K5z3QAg6FSCnCVZtMNq0v779+Y5aHYrpQDYm9xswGA//sV3/SErB8cm5ArCfg1uxQbQrF+j68fYGaS3F6gBgt/G4Xs0qDHPBsVGLOq5CTAaqrsbY+10KcxZ541/+vd1/CZXtWICmf5/aBsMXXlY0EGDIMidHL8znqWSpBMo8Y9krAZd+7Y295MU9uOWs6WxU/n+Qc9KeJh5j6Ji6Jt+kA3Jzj+PTCazO9P/Y6lisyZh7+eiVLMao0L7PBYkpZDjaWFXJCF0X/zbD/DJ+PVO6nO3OsgcaloUNrPthNvb0OeG7R6rZ9fE3qGCaUD0lJ8Vkq8jvioUeiZLVv+GuyWAup+qmIFE72WTWESnImTvRTwIVAFKMbM3TZINzudWNttYdVqVf9YTmoBO1yzjXcCYMIiMqWyxDvd52Y1BKDtNwk+sM9czpBMESOfFIj8wWCwjSgXrHAFwvdMAQ27AGgZ6zr35fCXVPk6RvCO+lqZ6Nr3jfoLcLwjmA1sNEaN6kVzj7mU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(6506007)(316002)(6486002)(26005)(186003)(6512007)(478600001)(110136005)(54906003)(2616005)(8936002)(64756008)(4326008)(8676002)(66476007)(66446008)(66556008)(66946007)(76116006)(91956017)(71200400001)(83380400001)(5660300002)(41300700001)(4001150100001)(2906002)(7416002)(36756003)(38100700002)(122000001)(86362001)(85182001)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3JyT1Y4VjBpZWpma0RvckplWlNnSTFvYldkL2hXN0wxNFQ0Umg4dkJBRWdQ?=
 =?utf-8?B?YkRVTDVYZEdYRC9yVGxsc3pYVWZzQ0dWVTRlZkJBT0NCdXdkS1dRaDh2aTg2?=
 =?utf-8?B?VGN5d1g1QmtsU0hjdi9KakpXTUNOaGlRZmhsRjBJc29KVlV6Ny9QVkVuemV4?=
 =?utf-8?B?Z1FXWW55dmlWbDhsWWhpMXVYa3NvUkNqeXBRSkIzTnhVbWxpN2ZSMXJwRHFw?=
 =?utf-8?B?VFAyZmgrOXhFSHZCZmhZK1pDYmhwam5GOFA2Sm10MVlDVTY1MXlFcnhIa3g4?=
 =?utf-8?B?QkVUcEk4cFMydS9sanUwb2Q5eDROeGNJTDhSWUp4YzBwQW8yUDRMTG5mWC9C?=
 =?utf-8?B?MXptMmsrci9YeHQ4SXc1ZnMxRERBdnBRZXFMZkRzZ2hHWUg1djJRTHZKaFkw?=
 =?utf-8?B?NXRZSm03dGczWTVQeEVwYWhWQmxHSmpLS05TYnplT3pLcDdNNVVxZEx4SnY3?=
 =?utf-8?B?NWJKUmdDdHAvbm4vWWQxME5XNkxEc0tIZ2ppY2ozcXIwWHUrcncyQ1JTYlJk?=
 =?utf-8?B?UTNxaEpUbFZMb2NrMXRjRTVsY0pCMTVCdDNxMWJIUlkrN2srcVF4N3YzWW9n?=
 =?utf-8?B?akxVSlFqVCtIeVRYTTUxMjNpNUtuSWY1TWpQRms3R3o1SEZ1MEJPQndWQlB3?=
 =?utf-8?B?QkFBZDBKYndtUldlMExSRkczQk1JaFdFbElPaE5yZXEySVUvazRTZUdsWFRm?=
 =?utf-8?B?ZmhoUVNiL3BuQkRQU3ZhVTI4VnJlbHpXTGx6SjNRWkptM24zY3Z5YjR5ME1v?=
 =?utf-8?B?anBlTlFPMC9iSkxJQWlBTkdmc09BUnZFUWppVjZjcWlkcDFmU3p2NWxhTmZ3?=
 =?utf-8?B?VmhYZmNDcmxFSHkvTVJHWS8zWVNBVG9RT2Y1bFg4NzB6bjdKMkk1V0R1YmFw?=
 =?utf-8?B?ck92MXJTVFpBUDFkZ3o2WmxVS2ZPQ2RHVWQxV0g3VmlXblo2UEpVNnhUME4v?=
 =?utf-8?B?MnFXcDIrRjJhTHZKenpqNVNBZjV5VXJjSHBueFFGWk1xV1hSdVhHODNiMzUz?=
 =?utf-8?B?akJDMjk3YTkydm5YcnFiZ1NTMWk0S0xWV2UzWldSbHpnWlNEUUl5eVM1dTRI?=
 =?utf-8?B?R1M2Qjlna3pka2ttOGI1cmM3eGNRS0lzcnV6YXBQNzlFdlhwMnU4WkcrMktN?=
 =?utf-8?B?R0RWOEVucXpSdG8rNjNmQ1IyTDdSUmQwWlVydDNYdzkxY1NweDBmY1RxV3F3?=
 =?utf-8?B?OFBzWGgzd1E4bTRVWldlZnpyVUZuRFBxSG9sNGVnOUVMNUV4dHFnNHRoaHNX?=
 =?utf-8?B?NWltR2U4cTZXQWJ4K2J4eXRKVE80Yk0rdytaLytaTUMxVnVGNWRQdWh6RG5V?=
 =?utf-8?B?cFpvaFhDeHJtS0RhL0dZOWpZS2RmZW5wZWpRWHpBcjMyWndFVEtGMXhNbFBn?=
 =?utf-8?B?RFR1NjVyekVrejcycnArb3V1TnVWUGVJVHh1Q2c2anhsYkpjL2tNeFoxUnpJ?=
 =?utf-8?B?WExENUVERGwrSzdmRzUydllwbU5GV2Foa2Q3U3F5RTdURWV6dWxtWTFlK1ky?=
 =?utf-8?B?Q2J2SWswdW8rRW03b3Rjd2lqWGpScFcvNUFGV0tFTlAvb1I0cXV5OS9mS3M3?=
 =?utf-8?B?dzFhNjdRZmZzbElCTFpHc2NiRTFiOHRtOWs2UHVIUGdXdlQrTFdEVENqUzJY?=
 =?utf-8?B?SGs4aE5CVVdidHdiaXBQQm1uZk03cEFGa0wwWTNOdTRLQUNSUzZNVEdrUUtE?=
 =?utf-8?B?bDJoRUhZK1pvZm1nb293V3Z4RzRXcEp3clEyTm9IT1lUVVE3VGxHM3lDNnkx?=
 =?utf-8?B?MlB3cm50ZFlGYkd0V0EzcC90VTY3bHpuWVV5NjhKWTVyZEp6aERWbGtQemNu?=
 =?utf-8?B?RGdMRk02UVI0U0JWcEVvYmtjbjZwNFlMbEVjTlpIL2VjbGxNZnByYUFqT0Ni?=
 =?utf-8?B?YVYweTZVRzVBNjBVcXM5bnREU05EVUxqeHFqeTlOWFI2UnA3NVdiWGlBanBG?=
 =?utf-8?B?ekFHbmFxQWdyTXgxQ3pybE5MV041U0tRTGNrOW1rZUczTklsYVN5NldqUkFE?=
 =?utf-8?B?bHZwejZUSkVnTVRRcmhybUZCRXRYMEZmMmdnN05LZlNQU2llL016b1lheWNr?=
 =?utf-8?B?K1RwV1JLS0h2MUh2RGZ4Z1gxbG96MjdvSWRaVk5RWmVmOGQ3YW9JTlRNS1Rr?=
 =?utf-8?B?b2RJT3d4b0RtOS9MeG5ubURIYlN1KzFNZncrSDdLZmdlKzRtZkJZRk5Fd0Zr?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBB10FDC4E5F9B4FB2C21C6347E258C1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb218a8-9ba4-4da3-5f21-08dae18c340d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 06:42:31.0840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PE6c6vpxRpnavn7QcuXRNqqX7PSL5rB7Yx4QNWH26CpOkW8CHi5fjklt7kmwB0fLXjmEe4oaVzF73C8Mxvi4OJlce0JhEnAHVcwD/gVcAPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5533
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCk9uIFR1ZSwgMjAyMi0x
Mi0xMyBhdCAxMDowOSArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+
IElsIDEwLzEyLzIyIDA4OjMyLCBZdW5mZWkgRG9uZyBoYSBzY3JpdHRvOg0KPiA+IFVzaW5nIGxh
dF9idWYgdG8gc2hhcmUgZGVjb2RlciBpbmZvcm1hdGlvbiBiZXR3ZWVuIGxhdCBhbmQgY29yZQ0K
PiA+IHdvcmsNCj4gPiBxdWV1ZSwgYWRkaW5nIHBhcmFtcyB0byByZWNvcmQgdGhlIGJ1ZiBjb3Vu
dC4NCj4gPiANCj4gPiBGaXhlczogMzY1ZTRiYTAxZGY0ICgibWVkaWE6IG10ay12Y29kZWM6IEFk
ZCB3b3JrIHF1ZXVlIGZvciBjb3JlDQo+ID4gaGFyZHdhcmUgZGVjb2RlIikNCj4gPiBTaWduZWQt
b2ZmLWJ5OiBZdW5mZWkgRG9uZyA8eXVuZmVpLmRvbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+ICAgLi4uL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy92ZGVjX21zZ19xdWV1ZS5jIHwgMzIN
Cj4gPiArKysrKysrKysrKysrKysrKystDQo+ID4gICAuLi4vcGxhdGZvcm0vbWVkaWF0ZWsvdmNv
ZGVjL3ZkZWNfbXNnX3F1ZXVlLmggfCAgOSArKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwg
NDAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4g
PiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL3ZkZWNfbXNnX3F1ZXVl
LmMNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL3ZkZWNfbXNn
X3F1ZXVlLmMNCj4gPiBpbmRleCBkYzIwMDQ3OTBhNDcuLmFmN2RkYmExOTIzYSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy92ZGVjX21zZ19x
dWV1ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMv
dmRlY19tc2dfcXVldWUuYw0KPiA+IEBAIC01Miw2ICs1MiwzMCBAQCBzdGF0aWMgc3RydWN0IGxp
c3RfaGVhZCAqdmRlY19nZXRfYnVmX2xpc3QoaW50DQo+ID4gaGFyZHdhcmVfaW5kZXgsIHN0cnVj
dCB2ZGVjX2xhdF9iDQo+ID4gICAJfQ0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gK3N0YXRpYyB2b2lk
IHZkZWNfbXNnX3F1ZXVlX2luYyhzdHJ1Y3QgdmRlY19tc2dfcXVldWUgKm1zZ19xdWV1ZSwNCj4g
PiBpbnQgaGFyZHdhcmVfaW5kZXgpDQo+ID4gK3sNCj4gPiArCW11dGV4X2xvY2soJm1zZ19xdWV1
ZS0+bGlzdF9jbnRfbXV0ZXgpOw0KPiANCj4gSSBkb3VidCB0aGF0IHlvdSBuZWVkIHRvIHVzZSB0
aGlzIG11dGV4LCBhcyB5b3UncmUgdXNpbmcgYXRvbWljcy4uLg0KPiANCkNhbiBiZSByZW1vdmVk
Lg0KPiA+ICsNCj4gPiArCWlmIChoYXJkd2FyZV9pbmRleCA9PSBNVEtfVkRFQ19DT1JFKQ0KPiA+
ICsJCWF0b21pY19pbmMoJm1zZ19xdWV1ZS0+Y29yZV9saXN0X2NudCk7DQo+ID4gKwllbHNlDQo+
ID4gKwkJYXRvbWljX2luYygmbXNnX3F1ZXVlLT5sYXRfbGlzdF9jbnQpOw0KPiA+ICsNCj4gDQo+
IFRoaXMgYnJhbmNoICh3aXRoIHRoZSByZWxldmFudCBhcHByb3ByaWF0ZSBjaGFuZ2VzKSBjYW4g
YmUgc2ltcGxpZmllZA0KPiBhcw0KPiANCj4gCWF0b21pY19pbmMoJm1zZ19xdWV1ZS0+bGlzdF9j
bnRbaGFyZHdhcmVfaW5kZXhdKTsNCj4gDQo+IC4uLndoZXJlIGxpc3RfY250IGlzIGFuIGFycmF5
LCBhbmQgaGFyZHdhcmVfaW5kZXggaXMgYW4gZW51bWVyYXRpb24uCQ0KPiANCk9ubHkgdXNlIGxh
dCBhbmQgY29yZSwgbm8gbmVlZCB0byB1c2luZyBhIGFycmF5IGZvciBldmVyeSBoYXJkd2FyZS4N
Cg0KQmVzdCBSZWdhcmRzLA0KWXVuZmVpIERvbmcNCj4gPiArCW11dGV4X3VubG9jaygmbXNnX3F1
ZXVlLT5saXN0X2NudF9tdXRleCk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHZk
ZWNfbXNnX3F1ZXVlX2RlYyhzdHJ1Y3QgdmRlY19tc2dfcXVldWUgKm1zZ19xdWV1ZSwNCj4gPiBp
bnQgaGFyZHdhcmVfaW5kZXgpDQo+ID4gK3sNCj4gPiArCW11dGV4X2xvY2soJm1zZ19xdWV1ZS0+
bGlzdF9jbnRfbXV0ZXgpOw0KPiA+ICsNCj4gPiArCWlmIChoYXJkd2FyZV9pbmRleCA9PSBNVEtf
VkRFQ19DT1JFKQ0KPiA+ICsJCWF0b21pY19kZWMoJm1zZ19xdWV1ZS0+Y29yZV9saXN0X2NudCk7
DQo+ID4gKwllbHNlDQo+ID4gKwkJYXRvbWljX2RlYygmbXNnX3F1ZXVlLT5sYXRfbGlzdF9jbnQp
Ow0KPiANCj4gU2FtZSBoZXJlLg0KPiANCj4gPiArDQo+ID4gKwltdXRleF91bmxvY2soJm1zZ19x
dWV1ZS0+bGlzdF9jbnRfbXV0ZXgpOw0KPiA+ICt9DQo+ID4gKw0KPiANCj4gUmVnYXJkcywNCj4g
QW5nZWxvDQo+IA0K
