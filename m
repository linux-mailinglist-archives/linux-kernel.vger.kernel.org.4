Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAA666BA07
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjAPJPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjAPJPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:15:03 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7FB16AD2;
        Mon, 16 Jan 2023 01:14:46 -0800 (PST)
X-UUID: 35a3d760957e11ed945fc101203acc17-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gkVsLrHDOeIYOlPzxeWRou0PLoKD3MU/53b3Jcdx/WQ=;
        b=hCr8PbUz0TZG4iseCm4OEb8x5pZptfr7OEWuUOVfHwmafQ9WbXUF2hnJMc74FUb8haK8QctFBcdTSaS91vVWPrV8e3n6LVNQ9W6DoYBEGbHWYsxZC2hr/w7gwzajORZAzaQjgr9Nt3RhG4WCnQP8jdMY0o2Y+42qLyEB74CW/sQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:6fde7b21-7c50-404e-b880-949cf8b0a4f8,IP:0,U
        RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:2
X-CID-META: VersionHash:543e81c,CLOUDID:5deaeff5-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 35a3d760957e11ed945fc101203acc17-20230116
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2081041857; Mon, 16 Jan 2023 17:14:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 16 Jan 2023 17:14:40 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 16 Jan 2023 17:14:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2/8AvfaUaho/hlnlF6KbIWTM3AcRwmAnfpM6hG8/DeL9NjdDvXBk/AcRLJbCetSjcoKudusu1Raog6FiCv3ROS2O9YgETxXv+0C6QCpICk8i+bmAHQ+CbXiE5wvUp9nFckHoshp3IfHgMyXjVmQdCK5mfx9Fy+/JICfKSWu/qZ+F9wydxGp/yVSs2O1mYvPxvqLJAvTOQ/TLrkXToh9oyqht2bgTDzs22mGaSaywBy7VT4CiNl4DBDzgfGjiECst0zfohz9iWty00nNSFMG5Nzu1ckLRwhzd9z9kBixta7gLeVdDSN0JZnIkpRRiKsfZ0nZTipc96udoHkJNemdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkVsLrHDOeIYOlPzxeWRou0PLoKD3MU/53b3Jcdx/WQ=;
 b=OzvFPesqEnSojcZ32cg1MnkQ4uuf1jOMR90+FW0CYHloVyHozx8+a2a1AA4Qp29QoFW62b33/pfAScnzltWS6cP69QzpTsefnVoq/Utdf68ygf1orvIkeVNId2LnZov/LNVvjnitsdL1QKnFHBvMUofYkaIBlY3U+bDctEXdw03FMrvIrXXUhqlcUzrX4Yk7AU+BR7w9OwXAAOdX6RDxHRSrBq1S2C5qDWQNB4Ww6iKzPAhkpprtsxIZZkxrDQqDsHk7Sjob8yJXOni5oK7T6jKBvasVLH6FPfbLFig5XwW4jqZ3hrpGUqXXKFIEDIwPdi+Vhaxb677kEQjeoYCJZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkVsLrHDOeIYOlPzxeWRou0PLoKD3MU/53b3Jcdx/WQ=;
 b=qAzTHY8TCALp6bg/mLZCxD2gNU2vzyuPVNC9HewNfWzDl2numO38dvwfgvT674mkUFXV5W09T3/FzTz6VMbckdS43qJ6H/rLAUGR4rmoogx2ne/yVzpHF0SOlKkh6P4UVm/Fh3NtyNujV4D0XHpb8nfkxYUGmvMr6FWVfwZJGM0=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by TY0PR03MB6244.apcprd03.prod.outlook.com (2603:1096:400:140::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 09:14:38 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d%4]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 09:14:38 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [RESEND v3 02/13] arm64: dts: mediatek: mt8195: add MDP3 nodes
Thread-Topic: [RESEND v3 02/13] arm64: dts: mediatek: mt8195: add MDP3 nodes
Thread-Index: AQHZKVmtKUIj/R6yHUWKl/iIf9gAxK6gsZMAgAARooA=
Date:   Mon, 16 Jan 2023 09:14:38 +0000
Message-ID: <47f79e0ffda3fe72e574596aad8c4562a3b6e14a.camel@mediatek.com>
References: <20230116032147.23607-1-moudy.ho@mediatek.com>
         <20230116032147.23607-3-moudy.ho@mediatek.com>
         <63f3d41a-1aa3-396a-b515-bc805f4a19b4@linaro.org>
In-Reply-To: <63f3d41a-1aa3-396a-b515-bc805f4a19b4@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|TY0PR03MB6244:EE_
x-ms-office365-filtering-correlation-id: dcb6f674-749f-4ec9-afd9-08daf7a217bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +/fW/wKOEq8HYKYKou+OwBYO0mYJILfdgb5ZDJrt3Xo/7UV63kNEt+ELReTgP9M9lgMcnbA7wCEBAiHdQ+WWoDdSzq29I/4/2DekFO1S/J9posvoFwMk83gXBsLezg56zCUYRzW11lzxXzhgheyrH/ksf4zvSvXfziGkBFwNbpK3XdF6cS02VQCKtke7ZOfYppk2rxufzmjpEGXoF/46E6EzkGakfbwuxddLahFdybulXnDUCuak83b3io/PWspY46pdI5BP5a+fY0kVdlSrUFGah208Ulg2apiqUiQyro3iHr3Zz/cqLYKx59/3RkJzIg9mV2prFdD3EryTa8C5re7L3l69nKW1pTtoF6QwG+oCq+2/ibyixohkD29IPQdj47h7dovghpdpWU7dUYhmF6ASWRQmzh7lv+u2G/qT/XxMLNdarDs5FuE6oVoRtW0mRiSmr0+JSlK+wl3uDrWxZ5C8STuSh0CIbhC4qPLeyRIjR9tTgKISjiCahu5Wi6x8a/tb0WzMQSxPYBDUauWfwwDsEUj+NTFxddEOffHl49EUCbyJ4RhE5cErQVVA8rpzzQ4kFNEe8X5Rwy8AkXEPV3DxvvJLYVQehaERXS/+vug8FDiSowL718fJ6v4MQbyEcHQj7dpRwDYD4cHQAeBOVXsDrt32I01lzhKl0AaVmgrrO7JE4tgBmLw/ppbgWyER
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(36756003)(85182001)(66946007)(66556008)(76116006)(41300700001)(2616005)(66476007)(66446008)(26005)(186003)(6512007)(91956017)(8676002)(64756008)(53546011)(4326008)(86362001)(83380400001)(5660300002)(38100700002)(8936002)(107886003)(54906003)(110136005)(478600001)(71200400001)(6506007)(316002)(7416002)(2906002)(966005)(38070700005)(6486002)(122000001)(99106002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW1ONzBGdlBFOFpVMk5CZTVMOFRYdXc3U29DU3c1RmN0YmNhdkJCTzlJR3Qz?=
 =?utf-8?B?UjdHV1JocHRpMUtOS1hEdm0zWnZuRWNkdG1HS0owOUNlTEltYjhIem1qSi9l?=
 =?utf-8?B?SXNFRFVTMGlGeDdqcFNaaDZzTGFQUG1qZGR0d1RBQkc0UXNlQnJvMjRlUGZr?=
 =?utf-8?B?V3Q0RDd6RjNkOFRwcEFDKzlvQVlyYi8xZ2JUeFQvV3ZyNVN1YURnbXdVUERt?=
 =?utf-8?B?TFEvV25iOEVMNTVWd3VOUUN2bFNJK0MydlZ2VXpHWHdzaGFlZUlqY05mdUlv?=
 =?utf-8?B?UjRYcnpCbjYvMlpsNDlWczFuZTZ6YWZ3V0JTd0Vub1gyeGZReUxyQWVsUkpU?=
 =?utf-8?B?SjdtRTBWRlFJTm44UHByOXpjMUt3WjZZa3pPcnpocXZXZnJON0IwdWMxdzZR?=
 =?utf-8?B?ZlJhM01ESTNnYVUvRThkdndXVUMvN1N6Ujg4Y2did2dLUWszdjVjdlNYUFox?=
 =?utf-8?B?ZEhHNit0Mll0VlNjUllTOWUvSEtBKzVrZEhTYW9DbEIvZFRGTWhkS1BiZE9r?=
 =?utf-8?B?NEJQQ3QrTEFCcjVTTHBtaDRFNjBTSzZlaDN1R3JUT3YzQkRnc1AwZ1RTeEcw?=
 =?utf-8?B?cnl6Z3N0UDR1ZzJaSFNwRHBsdTNmN1JqRjNsMFBMVzRkOHFGS0NuQmprR1Zj?=
 =?utf-8?B?NjFZOFFOekpPQXJTOG92UWlTUE80SmlmbmxYYXIzRnloRXZ6TWFST2xqcnl0?=
 =?utf-8?B?eVRLemFiYmlCdUJCVnhhdkwwL1dLU3dvNitLbk4wK1E2Rk14bGRLeE1wL0lC?=
 =?utf-8?B?MGRBS2pHU1FFSVlLRlVDMGR3VjBUUXFkMThKTHRjd010N0l3UERJL0dFV1dO?=
 =?utf-8?B?a1FIckllUmtMT0NSOWIzdWozK1VIbVlab0FueXhhdzVwUnpFWXAyaS9rSUFy?=
 =?utf-8?B?cFFhMWZjc2J0RjgxUFphYkFta2plZGJTbDMzczA3aEc0dlJVWXFTOFZML1Ay?=
 =?utf-8?B?WGdOT0JpTTNORS9oUTNpb3dJTUl5eG9mdW0zdTFyY3E3WjBWMWVVRHFjKzdY?=
 =?utf-8?B?UlJqSVZvcThnKzlNUnR3Rkw1WUtpaUljZGQ4Y2xrczZjVUtmbG9Nd3VnYnM5?=
 =?utf-8?B?R09jQU5QaWVTaTB1cThvRTRqWk04Y29EZnpEbXdpSGFkaEpCd0MzWmJUcmJq?=
 =?utf-8?B?bWxMQUFhQ2piU2VydTZSU1dSOEVNamEzQ0pCRHJmaUMwUkI2RG5IRi9zT2pS?=
 =?utf-8?B?bktsbnl2SWlSMFhsN0ZHL1dJblcrSWs4b01wN3BDV0l4enNWdTltdnpiMjEv?=
 =?utf-8?B?VVgybzFkUXJ0Q2VwVzJSaC9KSEZHSzRWa0FXLzMrOVdPRFZpU2RLZHRDSE9X?=
 =?utf-8?B?UEZLUWZoakw2RXFleGRYYlM3aDNrblg2Vi9sa2MrM20zK1lmRkszMDIrUUIv?=
 =?utf-8?B?ekxxU3BEdU15MFdlODI2S0N0cmNtcU5yK1dwMlBOTlgxbkVsU3NXdldZWGJl?=
 =?utf-8?B?VzBtVWF3RkJvbXBIV2NhbkduS0VxWFdCUDdMbkFxaHlqRlB6TlZHVnhWWEpm?=
 =?utf-8?B?b2VScW9BeUNYUmlCdDA3TngrMGxUVlZQYjBJTHFkb21vSU1DVkUxOUc4c3ZV?=
 =?utf-8?B?NWFPaEhuNHJNQmNCcDJmeTZNMmprM083WFRmSGdHSGhRbHZpbjdPaGVJVkNJ?=
 =?utf-8?B?cnlVUndla05pSitKVTlqdjM0ZlZLS2dpVm8zc0pIN3ZQMkd4VVZSa3YvdnNW?=
 =?utf-8?B?R0tyNHpXMktWejgwYTlZanRCeklJV1FpUDRrUUVZRS81OHJ6NG84Zi9xRnZt?=
 =?utf-8?B?N1RlVGFDdExyR2s4bFI3QkltaHBrRjRMTXc3Sk1BLzh3TzV2V1Fsc1d3WUN2?=
 =?utf-8?B?OGlCVGgyRm1BdFRpWkMwSDZ6UzExT3VnUHR4MWl3UjRnanJ6RDFBY2VqYk5E?=
 =?utf-8?B?dFVtcENOaWtla1AyUnZnaTFGTmo3T05sTlhleFVGWHFielFiUnlVSWpnaExz?=
 =?utf-8?B?dGtlY09NWHNoSkExM0dOb080eWRVWE1mbDE0MG16c3FkLzBpeXcxeHB3OGxm?=
 =?utf-8?B?eGlZZnV6WXJvS2hnNHZSRlErN1ZaT3Q4ajVCc2x1SFNhSFpaTGVLck5WbitR?=
 =?utf-8?B?NWlML2l3R25ibGtDcW5oU1Ezem1mWDJsRkx5ZUxEMFVTTzMyekJteEQrRjgv?=
 =?utf-8?B?Q1Rna3NPaFFlVkxxTHBrdEZiR01NbGxCZHB2TnVEcWp2Q0t3Rlc4Nmp0OFJq?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E94CD417186534A9926293E380FB02C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb6f674-749f-4ec9-afd9-08daf7a217bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 09:14:38.0348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzdTLYg3IatJ7v3JljmFCx6wJtKJd4mmB+3kHZAF8VsDrrx+3JwcDeNpiqmh4M1pR8cjw5nIgALQoepRi/wdEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6244
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTE2IGF0IDA5OjExICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNi8wMS8yMDIzIDA0OjIxLCBNb3VkeSBIbyB3cm90ZToNCj4gPiBBZGQgZGV2
aWNlIG5vZGVzIGZvciBNZWRpYSBEYXRhIFBhdGggMyAoTURQMykgbW9kdWxlcy4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBNb3VkeSBIbyA8bW91ZHkuaG9AbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS5kdHNpIHwgNDIwDQo+
ID4gKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQyMCBpbnNl
cnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTk1LmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4
MTk1LmR0c2kNCj4gPiBpbmRleCAyMDZkZDUzNGMzZjYuLmQyZDFiYTcxMjIyZCAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS5kdHNpDQo+ID4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaQ0KPiA+IEBAIC0xNzA2
LDYgKzE3MDYsMTMzIEBADQo+ID4gIAkJCSNjbG9jay1jZWxscyA9IDwxPjsNCj4gPiAgCQl9Ow0K
PiA+ICANCj4gPiArCQltZHAzLXJkbWEwQDE0MDAxMDAwIHsNCj4gDQo+IE5vZGUgbmFtZXMgc2hv
dWxkIGJlIGdlbmVyaWMuDQo+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8v
ZGV2aWNldHJlZS1zcGVjaWZpY2F0aW9uLnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC9jaGFwdGVy
Mi1kZXZpY2V0cmVlLWJhc2ljcy5odG1sKmdlbmVyaWMtbmFtZXMtcmVjb21tZW5kYXRpb25fXztJ
dyEhQ1RSTktBOXdNZzBBUmJ3IWdtdUlJazlwSFRFR2NWVHRPWE5lUDNhOFhVdWNvaVRkNXZUbXhO
SzhsQ0h0eXRSRGMzUjhFaDQ0V09XTkVVa0psdl9wUEN0Z19EdlBDSHNDSE5zY2c2XzBjZkplJMKg
DQo+ICANCj4gDQo+IDAgaXMgZGVmaW5pdGVseSBub3QgZ2VuZXJpYw0KPiANCj4gSXNuJ3QgdGhp
cyBkbWEtY29udHJvbGxlcj8gb3IgaWYgbm90IHRoZW4ganVzdCByZG1hPw0KPiANCj4gPiArCQkJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtbWRwMy1yZG1hIjsNCj4gPiArCQkJcmVnID0g
PDAgMHgxNDAwMTAwMCAwIDB4MTAwMD47DQo+ID4gKwkJCW1lZGlhdGVrLGdjZS1jbGllbnQtcmVn
ID0gPCZnY2UxDQo+ID4gU1VCU1lTXzE0MDBYWFhYIDB4MTAwMCAweDEwMDA+Ow0KPiA+ICsJCQlt
ZWRpYXRlayxnY2UtZXZlbnRzID0NCj4gPiA8Q01EUV9FVkVOVF9WUFAwX01EUF9SRE1BX1NPRj4s
DQo+ID4gKwkJCQkJICAgICAgPENNRFFfRVZFTlRfVlBQMF9NRFBfUkRNQQ0KPiA+IF9GUkFNRV9E
T05FPjsNCj4gPiArCQkJcG93ZXItZG9tYWlucyA9IDwmc3BtDQo+ID4gTVQ4MTk1X1BPV0VSX0RP
TUFJTl9WUFBTWVMwPiwNCj4gPiArCQkJCQk8JnNwbQ0KPiA+IE1UODE5NV9QT1dFUl9ET01BSU5f
VlBQU1lTMT47DQo+ID4gKwkJCWlvbW11cyA9IDwmaW9tbXVfdnBwIE00VV9QT1JUX0w0X01EUF9S
RE1BPiwNCj4gPiArCQkJCSA8JmlvbW11X3ZwcCBNNFVfUE9SVF9MNF9NRFBfV1JPVD47DQo+ID4g
KwkJCWNsb2NrcyA9IDwmdnBwc3lzMCBDTEtfVlBQMF9NRFBfUkRNQT4sDQo+ID4gKwkJCQkgPCZ0
b3Bja2dlbiBDTEtfVE9QX0NGR19WUFAwPiwNCj4gPiArCQkJCSA8JnRvcGNrZ2VuIENMS19UT1Bf
Q0ZHXzI2TV9WUFAwPiwNCj4gPiArCQkJCSA8JnZwcHN5czAgQ0xLX1ZQUDBfV0FSUDBfQVNZTkNf
VFg+LA0KPiA+ICsJCQkJIDwmdnBwc3lzMCBDTEtfVlBQMF9XQVJQMF9SRUxBWT4sDQo+ID4gKwkJ
CQkgPCZ2cHBzeXMwDQo+ID4gQ0xLX1ZQUDBfV0FSUDBfTURQX0RMX0FTWU5DPiwNCj4gPiArCQkJ
CSA8JnZwcHN5czAgQ0xLX1ZQUDBfV0FSUDFfQVNZTkNfVFg+LA0KPiA+ICsJCQkJIDwmdnBwc3lz
MCBDTEtfVlBQMF9XQVJQMV9SRUxBWT4sDQo+ID4gKwkJCQkgPCZ2cHBzeXMwDQo+ID4gQ0xLX1ZQ
UDBfV0FSUDFfTURQX0RMX0FTWU5DPiwNCj4gPiArCQkJCSA8JnZwcHN5czAgQ0xLX1ZQUDBfVlBQ
MDJWUFAxX1JFTEFZPiwNCj4gPiArCQkJCSA8JnZwcHN5czEgQ0xLX1ZQUDFfRExfQVNZTkM+LA0K
PiA+ICsJCQkJIDwmdnBwc3lzMSBDTEtfVlBQMV9WUFAwX0RMX0FTWU5DPiwNCj4gPiArCQkJCSA8
JnZwcHN5czEgQ0xLX1ZQUDFfVlBQMF9ETF9SRUxBWT4sDQo+ID4gKwkJCQkgPCZ2cHBzeXMwIENM
S19WUFAwX1ZQUDEyVlBQMF9BU1lOQz4sDQo+ID4gKwkJCQkgPCZ2cHBzeXMxIENMS19WUFAxX1ZQ
UDBfREwxX1JFTEFZPiwNCj4gPiArCQkJCSA8JnZwcHN5czENCj4gPiBDTEtfVlBQMV9TVlBQMl9W
RE8wX0RMX1JFTEFZPiwNCj4gPiArCQkJCSA8JnZwcHN5czENCj4gPiBDTEtfVlBQMV9TVlBQM19W
RE8xX0RMX1JFTEFZPiwNCj4gPiArCQkJCSA8JnZwcHN5czENCj4gPiBDTEtfVlBQMV9TVlBQMl9W
RE8xX0RMX1JFTEFZPiwNCj4gPiArCQkJCSA8JnZwcHN5czENCj4gPiBDTEtfVlBQMV9TVlBQM19W
RE8wX0RMX1JFTEFZPjsNCj4gPiArCQkJbWJveGVzID0gPCZnY2UxIDEyIENNRFFfVEhSX1BSSU9f
MT4sDQo+ID4gKwkJCQkgPCZnY2UxIDEzIENNRFFfVEhSX1BSSU9fMT4sDQo+ID4gKwkJCQkgPCZn
Y2UxIDE0IENNRFFfVEhSX1BSSU9fMT4sDQo+ID4gKwkJCQkgPCZnY2UxIDIxIENNRFFfVEhSX1BS
SU9fMT4sDQo+ID4gKwkJCQkgPCZnY2UxIDIyIENNRFFfVEhSX1BSSU9fMT47DQo+ID4gKwkJfTsN
Cj4gPiArDQo+ID4gKwkJbWRwMy1mZzBAMTQwMDIwMDAgew0KPiANCj4gTm9kZSBuYW1lcyBzaG91
bGQgYmUgZ2VuZXJpYy4NCj4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9k
ZXZpY2V0cmVlLXNwZWNpZmljYXRpb24ucmVhZHRoZWRvY3MuaW8vZW4vbGF0ZXN0L2NoYXB0ZXIy
LWRldmljZXRyZWUtYmFzaWNzLmh0bWwqZ2VuZXJpYy1uYW1lcy1yZWNvbW1lbmRhdGlvbl9fO0l3
ISFDVFJOS0E5d01nMEFSYnchZ211SUlrOXBIVEVHY1ZUdE9YTmVQM2E4WFV1Y29pVGQ1dlRteE5L
OGxDSHR5dFJEYzNSOEVoNDRXT1dORVVrSmx2X3BQQ3RnX0R2UENIc0NITnNjZzZfMGNmSmUkwqAN
Cj4gIA0KPiANCj4gIjAiIHN1ZmZpeCBpcyBkZWZpbml0ZWx5IG5vdGhpbmcgZ2VuZXJpYy4gRHJv
cCBzdWNoIHN1ZmZpeGVzDQo+IGV2ZXJ5d2hlcmUuDQo+IERyb3AgYWxzbyAibWRwMyIgcHJlZml4
IGV2ZXJ5d2hlcmUuDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoN
CkhpIEtyenlzenRvZiwNCg0KTWF5IEkgdW5pZm9ybWx5IG5hbWUgYWxsIE1lZGlhVGVrJ3MgbWVk
aWEgZGF0YSBwYXRoIHZlci4zKE1EUDMpIG5vZGVzDQphcyAibWRwM0B4eHgiPw0KDQpUaGFua3Mg
JiBSZWdhcmRzLA0KTW91ZHkNCg==
