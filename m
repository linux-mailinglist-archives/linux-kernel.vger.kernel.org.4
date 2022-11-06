Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552DF61E183
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKFKLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKFKLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:11:11 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3066F53;
        Sun,  6 Nov 2022 02:11:08 -0800 (PST)
X-UUID: a0078fba31434f17a11c4c3248f8cb58-20221106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pbwGahhgLsKaG3etED8r0hHZSV8ZqoAnmJQfyGTak80=;
        b=hnZbJoojZ+zF1KQFFLXDMu7JS2TrtkVy+MPgbYiNT8pWEwDUaxdl6vxlyfNeKv9uA8aANU9Ukrd+7uY/gDczJosZG3ITfr1kqJflhGUPZR4aSB7S/PJSDcyz9mwTsN4JV2BVXH+iA7Ob75K2zgutrJWkQ/rhCNRDSm75mg9+WbE=;
X-CID-CACHE: Type:Local,Time:202211061753+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:ab148405-ee4a-4bc0-8b0e-9ee865f5638d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:a4c48eeb-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a0078fba31434f17a11c4c3248f8cb58-20221106
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <mengqi.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 136428577; Sun, 06 Nov 2022 18:11:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 6 Nov 2022 18:11:04 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sun, 6 Nov 2022 18:11:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYqYpyQk2yTU48uO09MMaeznKBOT1mmDY/wveuKpnav/2TqLZKm23RS3UNVsrzVXYDPLmtewgwfMY6/rb4D1IxZJiyHMGHCXQH/gY6tthr0W9sXSl2uhQmXw+e5Mo1rI5XOfyn098OROm+Qm5TFBjxxIvWwmpDj1ABkzb0wite7KIEv4SMMtwdQ8pUUQBWpzdgggXudd0CTxrrOmoRfiqJZb6Q0hETIcB2pUDzNIeKlqdjoEuAOI6YgMuG/KnUOhWFWmbrrnCKmqjpTmoYV0XhhKDQAa/l7vysm/dSLw2M7xAH1b3foBrfuFYwaxdvaHZGSZmf1iwVfBvjiAPqSyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbwGahhgLsKaG3etED8r0hHZSV8ZqoAnmJQfyGTak80=;
 b=WaHJmRhMpZu/6ALCcPYLhZEq+dSAuzpDCImPVahO9/aPh/06WC0scfWniEgqT2GEepNKri54vuyVLp4/ddPAfHsJqFMai6yJynF12bTVgzvldhGDqe/UkQ8rajCkE9qKnYSkWOZ2YUyvok9jEWfizzqIQkuoqDQXCwKXG/swvACpUsOm47nzhPQyyNGhCIwNsGGy7YiVQxJKjddeqQlGr8FAXigXJWmYe7U9I1WqjPqppCHdaZn4LC1rDH7RYaSzGQqUOp6Q7JVKUPvZKhkbEGLQRbkJyVCn98sU2mUUoQ197c8pUimsx6sx5FtSSjJxWDvwEsZnc1vNHJoihufyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbwGahhgLsKaG3etED8r0hHZSV8ZqoAnmJQfyGTak80=;
 b=WcQqe13pd+11ABIBMJT+idhW2AyswJRnlFNh774svV4ne9Z4I0lbay5BfmglzgY3VXPQH4dtyWt4HQps2L+7iM0nzui648KAaTy6dxq9bgWSGBk6BbWSs9wU+yWIvxk5eWu1hhpe4qe01ya7NgyMQ0n6yZlJtUNiZPlvlew3nh0=
Received: from SG2PR03MB6261.apcprd03.prod.outlook.com (2603:1096:4:175::12)
 by SI2PR03MB5676.apcprd03.prod.outlook.com (2603:1096:4:15b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Sun, 6 Nov
 2022 10:10:59 +0000
Received: from SG2PR03MB6261.apcprd03.prod.outlook.com
 ([fe80::b993:c60:a25e:5707]) by SG2PR03MB6261.apcprd03.prod.outlook.com
 ([fe80::b993:c60:a25e:5707%2]) with mapi id 15.20.5791.025; Sun, 6 Nov 2022
 10:10:59 +0000
From:   =?utf-8?B?TWVuZ3FpIFpoYW5nICjlvKDmoqbnkKYp?= 
        <Mengqi.Zhang@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TWVuZ3FpIFpoYW5nICjlvKDmoqbnkKYp?= 
        <Mengqi.Zhang@mediatek.com>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/2] dt-bingdings: mmc: Mediatek: add ICE clock
Thread-Topic: [PATCH 2/2] dt-bingdings: mmc: Mediatek: add ICE clock
Thread-Index: AQHY4jOUgyH6+5+WtkSOcn+enm8V6a4r1vsAgAX0vgA=
Date:   Sun, 6 Nov 2022 10:10:59 +0000
Message-ID: <0541996bc0d7e16b4eabfb4781aed21fd1d293bc.camel@mediatek.com>
References: <20221017142007.5408-1-mengqi.zhang@mediatek.com>
         <20221017142007.5408-3-mengqi.zhang@mediatek.com>
         <CAPDyKFowa5mXVTU+ZcoSRp8daz=O=AJ1BdnH2roCG-hmB3Bz9Q@mail.gmail.com>
In-Reply-To: <CAPDyKFowa5mXVTU+ZcoSRp8daz=O=AJ1BdnH2roCG-hmB3Bz9Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6261:EE_|SI2PR03MB5676:EE_
x-ms-office365-filtering-correlation-id: 7807b3f1-2953-42d7-1cd8-08dabfdf33be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bk3CjP79THqXwOteqGo+DNgPOtwESsHZGEQ4Z4Odl6DtJeXS6tafFkoV0G+CUTyfToLXCopUOXHS5szxKC9PU27H7o6CjthI/DjLIbyO6yxUheRUeqBuHubXeUreW6mVvtEeSTCwGVfkWmWLjm/rMTLH0Ql1MUZy1VNjEZI3UrLl8xwDnRIlmvOV9i1MtxKxLIM2sYoDi4f6Qy6B9A26AHXIAaJilp0a/G5YRzwN1OwS0H7ZdU+HESV95/rwFF6VNDQUbE3kbBMuErFLMt+lLKznfPkLMOJUsSaX9md8BWc5s8Mqc9nPfwsPiG0s8l+yRlX8vNB+I0tZTDqQkkH4HroT8OSqlnbKsDBAR16EwGmJ+1KFKgw2wdMjMMtBtswxp4DU8YXUQnqGWDf7s0V7O/4sqY5VjexXZwXOC5A/WVlUkeOyC0VXElJ4/ONz5nJTF+XW43t3wjW3m6stHtuMk0Rtp9m2cZ3RX8IEyvP1Q6HkDFTLPmrXejhKUsh3vT6mA9UHb/wMmnZnIVtHbHhXNfrOE92UMCL3BT8ogdKOgZ/KoThDGcLzv2+I+PVjY35NgUKCq+fsB599VtC8gPaVt1Euj4zAoS8OU9Z4UEOKI/TKbno/OYuoLSO4/OcgIY5e9LwoF5pzMJUIhMQwo83pFSpE2Q+Mf153XjFTRQ+sQWgVbPus7POeA5z55IxIuMblmQ1WmsZfID7kZJaSRNBggIE1tn2hRciOWddPsBEgRroGZjIs1cV/aBhPz/PaNWHy5TKtUkGu0MAsoMxpR+hNL7PVg6XG0HT3rd6U56vEB2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6261.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39850400004)(451199015)(478600001)(2906002)(316002)(76116006)(41300700001)(66446008)(66476007)(64756008)(8676002)(66556008)(4326008)(66946007)(5660300002)(6486002)(71200400001)(966005)(54906003)(8936002)(83380400001)(38070700005)(38100700002)(122000001)(6916009)(6506007)(86362001)(186003)(6512007)(26005)(2616005)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vy9BY092MjNURWhDUHNsSmJ2NUNJT0RHUk1kZGVKMkY0T1RyUW0wbnUzTmph?=
 =?utf-8?B?VEpaQUVmaXZVSVNyZVc1ek9GR2V2VFhvdWxJU3Q0NWtpbDEzcG1qNXd4UHA2?=
 =?utf-8?B?QjlYR3poY01UdDVQU2hHa0pHV2dUSnFEWHZhNUowWVhUcmVSYzU3UENUTVZt?=
 =?utf-8?B?bjlBUDk2Y3BuYlM3T3ZxQ0UyOHAzRHRHSy9iejRqUVhrTHpPMXNvL0kxeENL?=
 =?utf-8?B?T2srdzJqdEdxaElyT3VGK05sb3pwc2FjUWZtekRDeDh4MmdTZ3NGeGtyUm00?=
 =?utf-8?B?V2toM1hTakV6U3oyME9jeFJsN2NoSStIREhlamwvN3VhRzh5REI1eDdrY1Nk?=
 =?utf-8?B?QXVqMklyZ2NaWG5PWGI0dE02NmNyTVFtajdRSGdELzhkcjYrbExOTTg5YzRk?=
 =?utf-8?B?MGRCb0lHcDdaUFBLWkVhSXRmdm9wazNDWVFNR3BFV2pFallsaWhZNFRwYTVp?=
 =?utf-8?B?TVpVV1B4ek00M2JlcXBFeDVaMTdRREdVU0tpS2YxQWtSUjhUUGUrQnd5WGh5?=
 =?utf-8?B?ZUZ1c0FTbC9hTGtFQWxiRVhaZkcxL3NTY2lVTVZldlU1akdoSzd4QmRxeWJi?=
 =?utf-8?B?RUxnK2dISndjTHUxUlBsTVIyMHhNbC8ybHQ3RVIyVTRpVExwbFZpOVB5VGZ2?=
 =?utf-8?B?a1d1NEY4YlNPb1V4RkFkdFI4ZFhubVZXYkVwSTF4bXFqSzNPdWswSzlZb1Zr?=
 =?utf-8?B?bnVEbWwrK2tMcUsxci9kM1FVV0xibmhaeTduTjliNFM3U3BjQXJIWE56aFRs?=
 =?utf-8?B?NXVYNUdRWU1HTE0yU2FZbUtPdTNnZEZGZ0xrMVlBMEZLejh2RFgvcW1rbnA4?=
 =?utf-8?B?Nkw3WjYwY0ZwUW9JRzUyN2RsUXFaU3Z0aGtSaEhsRnF1VzRnR2VxdUs0L0Qy?=
 =?utf-8?B?amRCaXcxRGp6cThSWlQ2YW5DQ2JMV1RidUVLakxnU3BFalJpSzBnSnZnY1BJ?=
 =?utf-8?B?dzAvMXEwS05FNHg0ajNER3FPRnBaWEJDL0lSMDN0eC9Rb2VVWi9OMmhhMnNV?=
 =?utf-8?B?WjJNQW1rS0VBSkQ4d1Vjb0tPb0FCZjFMUHRPaVVsTmQxRWN1WDZCM1M1a2ps?=
 =?utf-8?B?REYzc3RJeUdMZVZKbmYxNmNUbmgxVXd5UUF3bTMycnlkZUhTY2VJRi9jeXJU?=
 =?utf-8?B?NTVHanpxV1B0cmxucXBVclNtU1dlTzVWMCtONVNaR3lGSDAweFpMV2QvMHdy?=
 =?utf-8?B?ZHBaaWY1OU5FUG5oRXVUem5lUWhQd1haNDhHOVQ2RCtYSjhES1pMQjhhdHF3?=
 =?utf-8?B?RTFGY2t0OVJTYXJMVUZnZ1M1UUc3eVBzUFBuZCszSTZtT21lbS9PZ2doSzFh?=
 =?utf-8?B?NHpSRjlyZmtKQkxTNTdLUk5SYVNZNTBuS2J6WlFsTHRtT1ZIWWFscG9rSUF4?=
 =?utf-8?B?eC9pOHpsZWV3QzVaRGVhN3RiS2pwSytvTm9oVDJJVmtjajduTFlFTlV0dDIx?=
 =?utf-8?B?WXQ0Qm1WYmJnTDBxNmxOMmxZa1NrUXVyakVQeEdRVThqdDFXZkN1Zml0NDdz?=
 =?utf-8?B?bnE2N09EUjdZNUc4dC9NK29hMU9mb2JsUTZ4NUhzNHdRcmlMaEE0WGFndUVo?=
 =?utf-8?B?MDFCdUxBZ2tzSGV0OElVaTllYkpPV3dFMk9rYk5NQWF0d0RObGRYaEIzZ2Ri?=
 =?utf-8?B?aHA1d2F5MGppREdUSW8vRXF3QzBURTFKSEZjRGJtblpJQ2d2R1VvZ3lqUzJR?=
 =?utf-8?B?emRNZkJ6dXZyQWVNZGhKSW5WbzY2VjJBcTNIZG14RnMyZnhrUTVuZDhveFNM?=
 =?utf-8?B?YW5mWEZLdmNaRVZIK050cEVVWFo2V09HeG54K1AvVGZSSXhJUEUyQWtCYVo2?=
 =?utf-8?B?V2Y4QlJrZXFBQ0d2MzFXSVlwVEVJV1NwMUdzNVI0cjBLQ3BTaGNHS1VxY1I5?=
 =?utf-8?B?ZmloY1d4RzdPd1Jldy9NWEVuTVVrbE9sb1hpSVFCVlBHbVdlMjVwMlVoU3dj?=
 =?utf-8?B?S2ZBU2lEa29pZ2lnVDRWS0wrMWxVRUVaRC9YeEJZVUQ1T3Z4RDZiNit6ZWdi?=
 =?utf-8?B?QXpEZEtUbndoaE8yZWdNVCtnZE5mZzBVeEtrZCtVdUpyY0ZnalBPVUszTFIv?=
 =?utf-8?B?d1FvUkQ4eFVDM3pJZjJBdDV6RWpXSDh1TFBMTGt2VVpLQzJlOFdmN2FIUXpM?=
 =?utf-8?B?UnVPMjIrTk9xNUZob1hYS1MyeFBOKzdKaVVCTlhYWVVBcjhwT3lmK0UrUXc0?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB4555F0D61B844F9B0F5518709E506E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6261.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7807b3f1-2953-42d7-1cd8-08dabfdf33be
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2022 10:10:59.2586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7A8tU8xn4b7ZsFJBTnvU08ouyRj0jlAweDHjxKmlgWwrFk1ABiBKVV5Yu3W9Y9irnqSK4bz38IAzRndc29syvTZ1oyRiWPGRuC20O6K2/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTExLTAyIGF0IDE2OjEzICswMTAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
T24gTW9uLCAxNyBPY3QgMjAyMiBhdCAxNjoyMCwgTWVuZ3FpIFpoYW5nIDxtZW5ncWkuemhhbmdA
bWVkaWF0ZWsuY29tDQo+ID4gd3JvdGU6DQo+ID4gDQo+ID4gRG9jdW1lbnQgdGhlIGJpbmRpbmcg
Zm9yIGNyeXB0byBjbG9jayBvZiB0aGUgSW5saW5lIENyeXB0byBFbmdpbmUNCj4gPiBvZiBNZWRp
YXRlayBTb0NzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1lbmdxaSBaaGFuZyA8bWVuZ3Fp
LnpoYW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21tYy9tdGstc2QueWFtbCB8IDIgKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sDQo+ID4gaW5kZXggZDhlMWUyZTlhZGYy
Li5mOTNkNjg2ZTI5MTEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21tYy9tdGstc2QueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwNCj4gPiBAQCAtNTcsNiArNTcsNyBAQCBwcm9w
ZXJ0aWVzOg0KPiA+ICAgICAgICAtIGRlc2NyaXB0aW9uOiBwZXJpcGhlcmFsIGJ1cyBjbG9jayBn
YXRlIChyZXF1aXJlZCBmb3INCj4gPiBNVDgxOTIpLg0KPiA+ICAgICAgICAtIGRlc2NyaXB0aW9u
OiBBWEkgYnVzIGNsb2NrIGdhdGUgKHJlcXVpcmVkIGZvciBNVDgxOTIpLg0KPiA+ICAgICAgICAt
IGRlc2NyaXB0aW9uOiBBSEIgYnVzIGNsb2NrIGdhdGUgKHJlcXVpcmVkIGZvciBNVDgxOTIpLg0K
PiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBjcnlwdG8gY2xvY2sgdXNlZCBmb3IgZGF0YSBlbmNy
eXB0L2RlY3J5cHQNCj4gPiAob3B0aW9uYWwpLg0KPiA+IA0KPiA+ICAgIGNsb2NrLW5hbWVzOg0K
PiA+ICAgICAgbWluSXRlbXM6IDINCj4gPiBAQCAtNjksNiArNzAsNyBAQCBwcm9wZXJ0aWVzOg0K
PiA+ICAgICAgICAtIGNvbnN0OiBwY2xrX2NnDQo+ID4gICAgICAgIC0gY29uc3Q6IGF4aV9jZw0K
PiA+ICAgICAgICAtIGNvbnN0OiBhaGJfY2cNCj4gPiArICAgICAgLSBjb25zdDogY3J5cHRvDQo+
IA0KPiBMb29rcyBsaWtlIG1pbkl0ZW1zL21heEl0ZW1zIGZvciBjbG9ja3MgbmVlZHMgdG8gYmUg
dXBkYXRlZCB0b28uDQo+IA0KPiA+IA0KPiA+ICAgIGludGVycnVwdHM6DQo+ID4gICAgICBkZXNj
cmlwdGlvbjoNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+IA0KPiANCj4gS2luZCByZWdhcmRzDQo+
IFVmZmUNCg0KSGkgVWZmZSwNCg0KSSBqdXN0IGFkZCBjcnlwdG8gY2xvY2sgdG8gbXQ4MTg2L210
ODE4OC9tdDgxOTUsIGRvZXMgbm90IGV4Y2VlZCB0aGUNCm1pbkl0ZW1zL21heEl0ZW1zLg0KDQpJ
IGhhdmUgcmUtc2VudCBteSBwYXRjaCwNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
bW1jLzIwMjIxMTA2MDMzOTI0Ljk4NTQtMy1tZW5ncWkuemhhbmdAbWVkaWF0ZWsuY29tLw0KUGxl
YXNlIGhlbHAgdG8gcmV2aWV3IGl0Lg0KVGhhbmtzIQ0KDQpSZWdhcmRzLA0KTWVuZ3FpDQo=
