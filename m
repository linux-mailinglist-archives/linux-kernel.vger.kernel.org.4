Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617B866D7EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjAQIUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbjAQIUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:20:01 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E964D7EC7;
        Tue, 17 Jan 2023 00:19:50 -0800 (PST)
X-UUID: b1180152963f11ed945fc101203acc17-20230117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sh2OONfVD70DzJxsxNiKd3garEDcksGmDyvNcBWsK6w=;
        b=pTUg+Gd3tZzt7op4rl4dApiAkHhODxPsEN7o73h3YjhV7ASRmkW73P+ntNyylQzJwirXehVatRl+N71+HDOG2aBuNHynkfoVFBlOigdAQ07hK//RjvRySmFKrf4seYhPvO9aa3vqo5mbAsBwE1oBOor/lT1BIC32JTewMYxe5UE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:b2ec7d87-b39e-4625-8da4-8d1cddef3b48,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:85a17c8c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: b1180152963f11ed945fc101203acc17-20230117
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 752638108; Tue, 17 Jan 2023 16:19:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 17 Jan 2023 16:19:37 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 17 Jan 2023 16:19:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay89t/SYPypymPlSOp19raP2cfc/QsGjQfmetEW3TT3jwOcfVS2J1NNuPKUwnUf+q0sQ3G3Z2lzcHOYX2D3kJA8fjnYl42HWPv7R8tfm8zTD9vJdkAg2LkKAdaGbpGAYuZHCwdPzfUL6/J8q5+LbO9fpZ0+OkD8S/rlAxpqZ8DeuLhRLfCWUhlX9/YWjZ5PDZe5cY6QaadI5wtShCkSAECUlvKj4uTpNiNbXUTqIxuAumj+VkQZjW+WNlYoeoRdB2WBlwW2uulM7umiiNHyhaEsk5b8EwcFoZfX1fX0m1hViCTQqhDGCBouKfW+yg1xYGfqg3Fni4GTqp2KsXtAWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sh2OONfVD70DzJxsxNiKd3garEDcksGmDyvNcBWsK6w=;
 b=eVawAPIwtW4Z0nLaFGKSXNkebc9IjiLy5Q9Tn8HVKHGhPqYqjYeSjl4MnK6PjrpMC6+XTRtMmiUvDnJGKeufagbpomibrhiH7zC0DbgLKbO5zYrQ34X9asS6oOK0l7TRRA448nzACtuSGTE98HC41r709Zwv+P+6aCtYVZDYEQeJrouPDVu04AQPjugnaC4KgJxCp8dneS2LSodWL/hkl9TqsLBndr+P4mwqjJRE413XfkUM1/Bdsg2Wlv8vl8RbY/A80dhR/TTpvxL37YYHiaHgajF9gKd+4XfQ5F1fYaTYJ/8wUThJodlgAs7yH5VyhSRKvfQRw3J/m3+mLqxYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sh2OONfVD70DzJxsxNiKd3garEDcksGmDyvNcBWsK6w=;
 b=jHx92pf+O22Bk7h2auE3S6uU7xisABm/SvlOn6eWxACmyyK8mFzPZEy3U1RJxOrLB4tAgmkWPlvhmh/JEvXB6AgFDolxIKbWIMubO7uCglutsYU4JWX+g3WVqRQ5RN+9HzSvPJNmCj/xGVvffPB8bQnSdSWYHVEix3ZkkIjcAKg=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by TYZPR03MB6447.apcprd03.prod.outlook.com (2603:1096:400:1cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 08:19:35 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::dbe7:4943:de9b:bc96]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::dbe7:4943:de9b:bc96%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 08:19:35 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        =?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 03/11] arm64: dts: mt8195: Add SCP core 1 node
Thread-Topic: [PATCH v3 03/11] arm64: dts: mt8195: Add SCP core 1 node
Thread-Index: AQHY0hz3m8cJMMJLVU+xSq3lgoSubK3zHKuAgK/X9wA=
Date:   Tue, 17 Jan 2023 08:19:35 +0000
Message-ID: <52e3bf53a6197f5b42724d7c5e706781ae8a6e56.camel@mediatek.com>
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
         <20220927025606.26673-4-tinghan.shen@mediatek.com>
         <cbed65b6-bd7c-b750-ac8e-504fe143a804@collabora.com>
In-Reply-To: <cbed65b6-bd7c-b750-ac8e-504fe143a804@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|TYZPR03MB6447:EE_
x-ms-office365-filtering-correlation-id: 20a54ca3-d9a0-45ab-5dbc-08daf8639181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UVIC/FbhATzOZoXAQNa9K2uKYUtumrv95NCWC5CplSxUynmx/noP/AUiiCcevJS9+LR24yFJLw7cZGtJWcWOgBGWabr06y4ib9NGQ5N7RABglHOE0Jhtw4nMr82nJBEpyFF9dwrnXGusQyR5SKNxbuWn0nTgGPyTJijYJTOn0Ss9HFvB4dQ4rbQP+v1Y0jftKr2erEtZyYqXvpDLA3xZ2Trsf0dNOtGy7rq5jTTqxbZX+WW5scOrLacElCxHkJMBqSlTTaKJgesrggZ1F32hQseHbb2djOlksyzEA8WAD8+0If9plCNxlfyq08ZDY8FeDtpppu/IofCRUvgaFaOaVW8O2vcxQC7q/iKari+ILw2BDsDDIeszb31bRSoATLUlcTTR0ufbFDpV3qzHSi0+SBnSXpGjw7i/BjlUJg6Na93ED2j5CdR0npUsZfWCxLULC7YrcR7WaSupwtaPHwzDNAVQ0OPbMA80cCEUmyDDf7Mquh2sfYX9HsEevdN2JYZMtEUQXWy/kvfBcRtR6gY6+Jh+Vw3ZKueSDjzlwS0/Sm3eKRhtz0ix8MMERwsFbiOs3GiR8wQGAxuzkEICuYFynLxKiNEZRAcmuEATi/ifZw7Z3JsSAwqy+NiUa14Oy17vq+FLGy8iZSOzVXMIAV9j2PNBiMyPPtz9uCQ8LWBl1v5c2+hYAE4+I+nnrCTmsKAcaMBMz/C7zzM+4GopYbsS7mPN1Pzq9I2SqQpJ1G7crAHdB/rGg2GVHG4RBlHH/eY7gE2OalDrSAmsQzfJU4Ffhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199015)(85182001)(36756003)(38100700002)(86362001)(921005)(38070700005)(8676002)(76116006)(66556008)(4326008)(64756008)(66476007)(66946007)(66446008)(2906002)(8936002)(5660300002)(7416002)(122000001)(83380400001)(478600001)(71200400001)(110136005)(54906003)(6486002)(316002)(41300700001)(91956017)(2616005)(6512007)(26005)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2Z2WmU0M3dBNlN0QmkvUjFRMVltY1ZZT1ZKeEtyMGdmNUJyVkZXN0kyMVR6?=
 =?utf-8?B?MldHUUJMYk9TeUJjeEpMZGhSUFpKbURJenZCZytHTVNtZVpVV2hOVStBQkdW?=
 =?utf-8?B?bDl3VzBmdDB6QWFhQnRKM3RLdEh6SC8xNWJ5VkhOdXY5NGtoclJHY3FLN3FH?=
 =?utf-8?B?R0p4T3JYZVlrRnA2RXlZMk1ySUhLQ3F5ZlZGelp4M2RxQ2U0eTlvQkhONE9O?=
 =?utf-8?B?V0pWRUQ4aWtKV3JHbHlvQ2h6MXhyN2RDLzdYY2s0MDZHQkNaZThUbTVUOE9o?=
 =?utf-8?B?ZVozdUVBUUxQWUFuUjBaRE5LOEtMeG5WbU9pQWJWOWd1SDE1K0pHMFBmYkY2?=
 =?utf-8?B?aWN3bHlRTUt2TGFBRmZRQmxCNmVJckk2KzhLZlNYWDBFanBiK1V3NWtBMG5p?=
 =?utf-8?B?M3IraEQraEFHS2phVHdGRVp6bHJxeG5rOWpma2pwbUZvRFplMW9nK1ZMQ2dy?=
 =?utf-8?B?NGFQcHdISUF0Q09mRmR2OFhYYllyUFhGVys3OWVvbnIwV1d0aklDdHQza1cy?=
 =?utf-8?B?QnAyWWNZaGZvSEd4VjFjVEplWG0vS2x6MHViaUsxd0tKcS8rNGpzNWs2U0Nl?=
 =?utf-8?B?SGRxSmRkVmJKU1FuVVdzV01IY2Z0dGh3enRIaENKS29McUxHWHBXcWNkemNQ?=
 =?utf-8?B?L3QyZEMwSWNRZjZDaWpFRVltQWpyQjRmc2NNNFo5V1FpU1V4Z2Z0UzArVlY3?=
 =?utf-8?B?TDJGRUJFbmpJMnNteVNXaGIrUWQzSUsweDM3aTRpQk00UTB2SlEyOG05VGsy?=
 =?utf-8?B?UHNMSE0yVEtwR2grUTJEZzROaStQdDdKa1pyTzg3alIxdThWVzBlemFpcGZC?=
 =?utf-8?B?WmxOcjZpcVpBdGVOaFpnUTUwODJvbFZzcTl2SHZYNmluaGg5aEpHYVM2eXdW?=
 =?utf-8?B?RUNLcWhDUVdxa3krWmJLRzE3d2pUODRia1MyT3k3dHZhQ3FleTZMZW5HalYw?=
 =?utf-8?B?Mll1dklHVjZ1RWFDaWlBWTNCakw5T2Z1b01KVEVPQzhEQ1RzOVhKVkw4UEhX?=
 =?utf-8?B?YTBwTmpIVFZKbmE3YmxyR0tqQzlocVVuNk9tbFFKWTRldi9mMTlYYTl0eUVS?=
 =?utf-8?B?NEp5UXozQm8xcnVCN21OT3hKYkRBQkRVQStWTzg1eDdTc2crbGxmSWdJQXJy?=
 =?utf-8?B?aHZtL1MxczMrRm1zaU9GSkZIM3RGTlZWT09icStkTFhEMVhWS1NUZUEzNjl4?=
 =?utf-8?B?c1VNbzR5b0crODdFZXk0ZmhCcVR4S21HWEtHWXU4QkdSOGNFK2gwSlFwbXZH?=
 =?utf-8?B?LytTWFc0MFpkbExLZUJYZmZFOEY1TXZNMEpxdXoxN25Tdk1QQkp5RHgvUEVL?=
 =?utf-8?B?SnExS1dTZ3ptWG5ZVWFabnFDWjExVkRWNHljNHppSUwvd01BdU1vRlludlc2?=
 =?utf-8?B?TlVndnExTGVNbHhjR2NQWldtVlNybG0rUzgzbGhDOGdQd1RwQUl3Qm83L291?=
 =?utf-8?B?VkdqdWI0M0hSNEU5aTF6eWlNNmFWUUVpeUg2VTZTa3hEWTZoNkNCZzY1MlVx?=
 =?utf-8?B?bFFNaWJMV1Q3bWhtMXlTZWJDWUswanVwL0dnRnNGeVY0ZlpsZWxrNWMyMFh5?=
 =?utf-8?B?WFNvTnF6a2F2QVJMczZKU0RaQ2EwN2JTS3pQakJzd3FCUVV0UDZzZkpCVDZS?=
 =?utf-8?B?U2luaWxmL0dvY2g3L1RvNFI4ejVOUlJzME5vYWtlN1pEVy9UTWZFc3grcm9h?=
 =?utf-8?B?K0R1ZlJlRFNscnY3S20xTzVZZFZOOUZTTlBFKzgrcldrNWtJcUhNbzlpeHlH?=
 =?utf-8?B?cHNIMWNrTmVCOWZpKzd4b1g0bTdyTjhTNGVCR20xSHlxYi9YeFg3OHo2a1Rl?=
 =?utf-8?B?QXVOc215QzI5eFpOR0tKK3JXVnlUbUd3MEpwMDVnNUU2amQwMmcrL1NrYm1T?=
 =?utf-8?B?UWZIS1J0aTUyT21LUEJFZnpLdWc1QUxYYUJsMXhtSmN3T1lib01HZ1RZaC9T?=
 =?utf-8?B?eGhLcDlkL2lHNFBEZTBaeURBUnB5aUl4a1M1bnFMYTNoY2docUJGU2Y1WUZJ?=
 =?utf-8?B?TlhWdEI1QzJGS3JFSVVtWkh0RkZ0UFkza2hBdTY4WjNkdmsza2JCenc0VE81?=
 =?utf-8?B?S2tRRU1ZYUVoQ1ZmVHp3b09HTWU2ZEhpajljZml6SXcrM0pmbFRubkYrNy84?=
 =?utf-8?B?NXlRYTJlTEVKb2lTSkdVemc1YWFIZ1lYMzI4ZEwrZUJTck9ZZXhvZXp2a24v?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E295BE792201FD4CBF1E3EB2F062B978@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a54ca3-d9a0-45ab-5dbc-08daf8639181
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 08:19:35.2503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5u644wJUDfpCNi+sRawL/sQ2se7LofXRXjyQhm0SAahr9f5EVK39NVc0x0WCNGi7Wfj4djwDjx35GIsinUWI1UCoZZ7W1X8Dkk0p18FGJCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6447
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA5LTI3IGF0IDEzOjAxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjcvMDkvMjIgMDQ6NTUsIFRpbmdoYW4gU2hlbiBoYSBzY3JpdHRv
Og0KPiA+IEFkZCB0aGUgMm5kIGNvcmUoY29yZSAxKSBvZiBNVDgxOTUgZHVhbC1jb3JlIFNDUCB0
byBkZXZpY2V0cmVlIGZpbGUuDQo+ID4gUmVzZXJ2ZSBzb21lIFNSQU0gc3BhY2VzIGZvciB0aGUg
Y29yZSAxIGltYWdlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRpbmdoYW4gU2hlbiA8dGlu
Z2hhbi5zaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ4MTk1LmR0c2kgfCAxNCArKysrKysrKysrKysrLQ0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaSBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0c2kNCj4gPiBpbmRleCA5MDVkMWE5MGI0
MDYuLjQ4ZDQ1N2JkMzliOCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE5NS5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxOTUuZHRzaQ0KPiA+IEBAIC03NjAsMTIgKzc2MCwyNCBAQA0KPiA+ICAgDQo+ID4gICAJ
CXNjcDogc2NwQDEwNTAwMDAwIHsNCj4gPiAgIAkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTk1LXNjcCI7DQo+ID4gLQkJCXJlZyA9IDwwIDB4MTA1MDAwMDAgMCAweDEwMDAwMD4sDQo+ID4g
KwkJCXJlZyA9IDwwIDB4MTA1MDAwMDAgMCAweGEwMDAwPiwNCj4gPiAgIAkJCSAgICAgIDwwIDB4
MTA3MjAwMDAgMCAweGUwMDAwPiwNCj4gPiAgIAkJCSAgICAgIDwwIDB4MTA3MDAwMDAgMCAweDgw
MDA+Ow0KPiA+ICAgCQkJcmVnLW5hbWVzID0gInNyYW0iLCAiY2ZnIiwgImwxdGNtIjsNCj4gPiAg
IAkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA0NjIgSVJRX1RZUEVfTEVWRUxfSElHSCAwPjsNCj4g
PiAgIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gKw0KPiA+ICsJCQkjYWRkcmVzcy1jZWxs
cyA9IDwxPjsNCj4gPiArCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gKwkJCXJhbmdlcyA9IDww
eDEwNWEwMDAwIDAgMHgxMDVhMDAwMCAweDIwMDAwPjsNCj4gPiArDQo+ID4gKwkJCXNjcF9jMTog
c2NwLWMxQDEwNWEwMDAwIHsNCj4gPiArCQkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1
LXNjcC1jb3JlIjsNCj4gPiArCQkJCXJlZyA9IDwweDEwNWEwMDAwIDB4MjAwMDA+Ow0KPiA+ICsJ
CQkJcmVnLW5hbWVzID0gInNyYW0iOw0KPiA+ICsJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDQ2
MyBJUlFfVFlQRV9MRVZFTF9ISUdIIDA+Ow0KPiA+ICsJCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4gPiArCQkJfTsNCj4gDQo+IEkgdGhpbmsgdGhhdCB0aGUgYmVzdCB3YXkgb2YgZGVzY3JpYmlu
ZyBhIGR1YWwtY29yZSBTQ1AgaW4gZGV2aWNldHJlZSB3b3VsZA0KPiBiZSBlaXRoZXIgc29tZXRo
aW5nIGxpa2U6DQo+IA0KPiBzY3A6IHNjcEAxMDUwMDAwMCB7DQo+IAljb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE5NS1zY3AiOw0KPiAJcmVnID0gPDAgMHgxMDUwMDAwMCAwIDB4YTAwMDA+LCA8
MCAweDEwNWEwMDAwIDAgMHgyMDAwMD4sDQo+IAkgICAgICA8MCAweDEwNzIwMDAwIDAgMHhlMDAw
MD4sIDwwIDB4MTA3MDAwMDAgMCAweDgwMDA+Ow0KPiAJcmVnLW5hbWVzID0gInNyYW0iLCAic3Jh
bS1jMSIsICJjZmciLCAibDF0Y20iOw0KPiAJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDQ2MiBJUlFf
VFlQRV9MRVZFTF9ISUdIIDA+LA0KPiAJCSAgICAgPEdJQ19TUEkgNDYzIElSUV9UWVBFX0xFVkVM
X0hJR0ggMD47DQo+IAlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiB9Ow0KPiANCj4gLi4uYnV0IHRo
YXQgbWF5IHBvc2UgYW4gaXNzdWUgd2hlbiB0cnlpbmcgdG8gYXNzaWduIGRpZmZlcmVudCAob3Ig
bW9yZSBpbnN0YW5jZXMNCj4gb2YgdGhlIHNhbWUpIHN1Ym5vZGUocykgdG8gZWFjaCBjb3JlLi4u
IGZvciB3aGljaCwgSSdkIGJlIG1vcmUgZm9yIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gc2NwOiBz
Y3BAMTA1MDAwMDAgew0KPiAJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtc2NwIjsNCj4g
CXJlZyA9IDwwIDB4MTA3MjAwMDAgMCAweGUwMDAwPiwgPDAgMHgxMDcwMDAwMCAwIDB4ODAwMD47
DQo+IAlyZWctbmFtZXMgPSAiY2ZnIiwgImwxdGNtIjsNCj4gCSNhZGRyZXNzLWNlbGxzID0gPDE+
Ow0KPiAJI3NpemUtY2VsbHMgPSA8MT47DQo+IAlyYW5nZXMgPSA8MCAwIDB4MTA1MDAwMDAgMHgx
MDAwMDA+Ow0KPiAJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gDQo+IAlzY3BfYzA6IHNjcC1jb3Jl
QDAgew0KPiAJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXNjcC1jb3JlIjsNCj4gCQly
ZWcgPSA8MHgwIDB4YTAwMDA+Ow0KPiAJCXJlZy1uYW1lcyA9ICJzcmFtIjsNCj4gCQlpbnRlcnJ1
cHRzID0gPEdJQ19TUEkgNDYyIElSUV9UWVBFX0xFVkVMX0hJR0ggMD47DQo+IAl9Ow0KPiANCj4g
CXNjcF9jMTogc2NwLWNvcmVAYTAwMDAgew0KPiAJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTk1LXNjcC1jb3JlIjsNCj4gCQlyZWcgPSA8MHhhMDAwMCAweDIwMDAwPjsNCj4gCQlyZWctbmFt
ZXMgPSAic3JhbSI7DQo+IAkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDQ2MyBJUlFfVFlQRV9MRVZF
TF9ISUdIIDA+Ow0KPiAJfTsNCj4gfTsNCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCj4g
DQpIaSBBbmdlbG8sDQoNCkknbSB0aGlua2luZyBhYm91dCBpZGVudGlmeWluZyB0aGUgY29yZXMg
YnkgdGhlIG9yZGVyIG9mIHRoZSBzdWIgbm9kZXMsIA0KaS5lLiBjb3JlIDAgbXVzdCBiZSB0aGUg
Zmlyc3Qgc3ViIG5vZGUgYW5kIGNvcmUgMSBtdXN0IGJlIHRoZSBzZWNvbmQgc3ViIG5vZGUsIA0K
YmVjYXVzZSB0aGUgc2NwIGNvcmVzIGluIHRoZSBleGFtcGxlIGhhdmUgdGhlIHNhbWUgY29tcGF0
aWJsZSBuYW1lLg0KDQpJJ20gaGVzaXRhbnQgdG8gbWFrZSB0aGUgc3ViIG5vZGVzIGFwcGVhciBp
biBhIGNlcnRhaW4gb3JkZXIuIElzIGl0IGFwcHJvcHJpYXRlPw0KT3IsIHdvdWxkIGl0IGJlIG1v
cmUgcmVhZGFibGUgdG8gY3JlYXRlIGEgbmV3IGNvcmUgaWQgcHJvcGVydHk/IE9yIHV0aWxpemlu
ZyANCmRpZmZlcmVudCBjb21wYXRibGUgc3RyaW5ncyBmb3IgY29yZXM/IEkgd291bGQgYXBwcmVj
aWF0IGl0IGlmIHlvdSBjb3VsZCBzaGFyZSB5b3VyIG9waW5pb24uDQoNCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpUaW5nSGFuDQo=
