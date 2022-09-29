Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800495EF441
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbiI2L0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiI2L0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:26:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F1A14D48F;
        Thu, 29 Sep 2022 04:25:57 -0700 (PDT)
X-UUID: b31d4f035dfc44cd85ab75df61f1b1a6-20220929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GxuOuwTcWVxrxRf6yFr6MWT4EQG5qo8VHl88NntElBw=;
        b=BLAfk0+UnezXrZuu5tvmCU78uYhBfIDZtwg/IYrzfYvOa7vc4quwBjzZLrow4nXOdmMNr3jN4FxfiQO7VyNv8B6ZUwo5GxYGBcvKy9mZNGpxqHz0C2sAA8rLmFj6RpwM18ZmCo2rSkl4ElMkymfUwYpn9VJb0MteQ/dKwY6xwNY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:718defd2-0b0e-41e9-9f82-908c5ed539e9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:7c6e80a3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b31d4f035dfc44cd85ab75df61f1b1a6-20220929
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 802717521; Thu, 29 Sep 2022 19:25:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 29 Sep 2022 19:25:53 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 29 Sep 2022 19:25:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cx5V9XPlF6NPbkLeQOGEy72W7gxcgvKyp4LXdap4QbXyN5A5ptpFhMi6oRN6oa8Sl0ZSb6/qlMKA9ab5Te8eyTOmr+8fFL6Hr+aFXNap97wF6bVkwSBkwCxkWdnqHQ6g4uZZjWy92eOWLgHUm00Z3VbW/cgkb9da+Zn1TTundr0t1w7vjUY858y0wJ32b8kMvAVW2vOslblXoxrLu9buZ4dM88Q3CoAKx9DiWxgC/KWnsxFK6irFw+w5zD5EcuRNurjgoEHZQ0IRQ185K3hvWLNLJQ/wapeUsiWueL5llk5JIN27B4hfDitnRr0uIgTyjO5RAyLDRWyAVbursf09Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxuOuwTcWVxrxRf6yFr6MWT4EQG5qo8VHl88NntElBw=;
 b=eutkMGKdrcAA5mxL0kb1pdIHZ4HMbt/WlC09N5LDXEdGufCl2/rluBXJ24EKb9H1XUBwSNoPpToTyNGpFD5n8P3RADfpIW1ZstHGiWSeQxPqQQrVb3gIk5S6I8DqFy1Xlh6vDPLg+DsMsfcRFkV+dwiKetYSTOe2JSLO7uUC78CU2wkrR6M/BfNXvvqPGWaMYfhc61eIOg7D8JextDlWAdHxIq4OUhljJ71KUEWJR5Q2Mr0cvcx/UF6szYhmX3mchzeraxDO5sTp7IyHXNqtKETSjcJaxiJ3T0GCrGgxIQpZZOcLWRnSmeLbRmIG52Kg8kbZNvftWDMjX9WNRgc61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxuOuwTcWVxrxRf6yFr6MWT4EQG5qo8VHl88NntElBw=;
 b=RvJC3cfoDKQax6w1Q221sDEe8CEmOEzaZRu7NmKwpJEI7WgqwRseGrjo8+nPbB9yiN/xoLr7U8yW5W2fBeXmuusBtmFYXpEPfmlAKMBt71YckFq3pMnfkttaSIlkOjHUPfuvxRRpHopqzkE5I3Rp46KYGzazCe1gZYZ2P+a7dgM=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by PUZPR03MB5992.apcprd03.prod.outlook.com (2603:1096:301:b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 11:25:49 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a%3]) with mapi id 15.20.5676.014; Thu, 29 Sep 2022
 11:25:49 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: mt8192: Add vcodec lat and core nodes
Thread-Topic: [PATCH v2] arm64: dts: mt8192: Add vcodec lat and core nodes
Thread-Index: AQHY0ZXZ3y9DZV7pPEGmFoiEPn734q3x1joAgAC1wgCAAIWYgIABXEqAgAAPGgCAAJ6wAIAA/KsAgAAw8wA=
Date:   Thu, 29 Sep 2022 11:25:49 +0000
Message-ID: <6b8a0f42ae7f868bc09039af07f165bf2e640e05.camel@mediatek.com>
References: <20220926105047.19419-1-allen-kh.cheng@mediatek.com>
         <4d1e8600-f73d-8d2b-2e7a-1b75be7624bd@collabora.com>
         <d71334b63427df73d01ff1b9fa4d2dec94ad9c95.camel@mediatek.com>
         <05ed341b-2db3-620f-7a70-dcebfaa66f1a@collabora.com>
         <172e10ee-22fd-ccec-1a5a-7bd0a29dbfc4@linaro.org>
         <68e1c8b0-04cf-acf8-b6b6-97d9eb8a7c4a@collabora.com>
         <186bc17e-56d2-f125-aab9-f47bf3f45b79@linaro.org>
         <514f8de1-1a23-1947-80cd-6136e17af490@collabora.com>
In-Reply-To: <514f8de1-1a23-1947-80cd-6136e17af490@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|PUZPR03MB5992:EE_
x-ms-office365-filtering-correlation-id: a4e06c6e-ca19-4552-c3a6-08daa20d5c35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6pO1Wp7teqzBqg/yA4VqACmf9O1p6Gqq3tGsJADCWDAjQVcLxWSrUN0brRgdqjRg9y6u8D9O/q8KpU9+1UpKnqS26jXTS2JRJrjPKCOmzF4e7pnx0qjn+CVA5Yc36F90ofhFk+hvM47yTZACwvwbaPWdcqKQ0m8Rf/uaYXD+LLiawbdmZyFFncJpK/VHe2pGtqna9s1khgC2isICFyVECDiC/HqvQM8xyh6N9MOQMsjnuyOe78KopilFOZXpdEvGQ6hj//huUCx8Cn2HCA4veUu9U6OCF07arbogcnIJUFqmBHRwI5sCaJwvavOE461SMZsAR6BDxeuhbH2COcypwXGvUvk8+mjkanaNpz2Y3I1WGUjNtTVcyFDHEz2o4h0u04AswM8B0dXp//qDJVhnx7i0ZemLjMUDuI5/gOrVYLTtmUoWpV9i76+7QJmJniZE1Qxaiv1XRBC1P2InDfhIYalGbJ9vjpCYNQltij26pPWMX92V2vB2Gd8k1KYZxoRxB9sU35P+rNieBPV6ksuoE/Rm6qf8zU92bVqcMykhOHu6VbY4TKqqIIUynV3sW9ons5LFdKappDcW4Z4v4/BupNYKU3sf4gRhYvlvUVPYlNctLHd5zinXtE1XUj+vfkcz664OSaA18jJdsOcCiFPV5E/wIrSBqPEnxzlWhTIwPMsXFbf1gGKKKPdXBA1EPZe+Ix0xy2mOas2x4/JawZZsokfx7qlqyCfLTFkEZbFMDIWBUiQ1SfQvVWEOLZ24bhRBotcRm9JnE7LvOkxu6fdfVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(2906002)(8676002)(64756008)(66446008)(66476007)(66556008)(5660300002)(38070700005)(4326008)(38100700002)(8936002)(36756003)(66946007)(41300700001)(91956017)(76116006)(316002)(54906003)(110136005)(6486002)(122000001)(85182001)(478600001)(2616005)(86362001)(83380400001)(6506007)(53546011)(186003)(6512007)(71200400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHhQVDFOVUZYTUJucENMS3hjeE4zODJaWWt0cXVBTjdBcUtnNVlqd2pUYlJj?=
 =?utf-8?B?Q2loTWFubUMrTDBDQnc0dWx0dGFmWDRyRXhHQlV5UEk2RnNndDRhck5LNHNU?=
 =?utf-8?B?VzE2VGRnSnFRNy91QzU5T0FnOXFXN3V5U0VDNUh4a2tyd3RJaERQdUhBUmFr?=
 =?utf-8?B?K3dsQ1FoQkh3N3dLaXpvcmROaTY3NzEyb1VmbC9kK21BSzMxZEdPZGhMMEhK?=
 =?utf-8?B?YzFGbWUxaXlYak1QN1daL2hxYXAxOHpHS3duMzVZUWF5Tk9Mb256cnRNR1Zo?=
 =?utf-8?B?dVkvVHllNGpVT2dscDlWQjhPRHRVSTQvcnRDMjF5dzlSQzEwYktUN0kydzds?=
 =?utf-8?B?ak16Tmprbm1kTTJ0ZjRxUEVhekNGOFhUYnhNRm90U2pRNHQvbkZiUW5rRE0w?=
 =?utf-8?B?SHp2d3JqWU1ZdU5NVWlYeU8raTRaQU03Qy9zK2N2TTZmTlMvb0IrREJiL0gw?=
 =?utf-8?B?ZXA0N1h2NFRlMDllbWt2aVlsT2tlRCtrVzJIS2tIUnd0K20wZzNrT1Fxak5D?=
 =?utf-8?B?Q1plalZ3ZmkyNlFRWlFOZ20vTitUTXlqODQ4Q3BzeWEwYzUzNVNyWDRkNEYx?=
 =?utf-8?B?Y1RxdmU5c3ZGbm5PeEZnOUpuYzcvY0lKcy8zU1hwMWU2TnVWVHNpK0UrL0Zu?=
 =?utf-8?B?UnRYZkp1OVJhOE9ucHplajRPaFZQNktKc2F5ZTJhaE1mTzNpcTl6THpUTVJT?=
 =?utf-8?B?Q2NzbXRnTmtaZXphSnF2VDZxcGI3VWRnakNOOXZ1R1B2NXVWTWlHMVBTbFg4?=
 =?utf-8?B?OXcwQmMrU3hNQ2J4TjdQSFhzUVRlTFU2ZjNIcmxhVkZpT0d4YjB5VWlzVSt1?=
 =?utf-8?B?UEN5N3pjbzVGRWRtNHA5Y25MWGhaT1FVUFNQd3liOCszOStGT0syWXdDNEJQ?=
 =?utf-8?B?a1dpaDhmMk5rUjNPYnNxK3FISUVXRGQ5c1RpN1VoeFQrby85amlsMEZiMG4v?=
 =?utf-8?B?RVhaSTBaMkgvRXRRSjZDNVFQQ3pxWWI0N2NiK0hKb0I5Y1hpV2lIcGFvUExv?=
 =?utf-8?B?ZXQ1alJIbFY4YWRrZWZKQkFRUVV1NFlNSVFvNmdheVJuZExFbWxoOEVhSmJC?=
 =?utf-8?B?TGJWTHEvT2cyZEJJZ2QyYTJmQ2xudTBKalhlaFpGMCs0Y3dUZ1crS2ErVzNF?=
 =?utf-8?B?b0hoUXpvZG14VUM3Sk1ZajlxRzVNdTBodWY1L2NhRjJYZ1dKSzhpWDF5a3Ux?=
 =?utf-8?B?T1hLSldzOUR6S0kyTlUzSXpsQlI3RVI1NjA2eVlhMEttVW1CdlJna2JpQmw4?=
 =?utf-8?B?Sy94RXNSeUwvYlN1YUNnbkdCMHAySnVNcGNRUko2dEE0dHlLN0F0VTFzR0xh?=
 =?utf-8?B?ZFJuOUVBQnQrdytzUHZPQVVMNFdFaDczb0o1aGI5OHQ4TG5wZWFTRGgzVFZR?=
 =?utf-8?B?U3U5RjYzcEU5R2lPbTZDTFVobTluVFIxZUFXK0NTcXFpekZzK0JvWmNIQ3g5?=
 =?utf-8?B?Y0NrM0wxZWNRWkJXMDA3cTIvNUV1bXVWWDVHMFRYb3h3a2NHbUowSUhHRGdU?=
 =?utf-8?B?TGFQUWdRSHNtendEMkVYZ2xCTkFMU2FNM0FORURod3lpSFNMSmVNN3RjN2VN?=
 =?utf-8?B?M2IvaWQ3Vy9uMGErb3BSMEpGS3ZSM1RRVDA2c3VDSzJ0bmEyWEhMTVpXcWNT?=
 =?utf-8?B?RDYyWlFSN0ZOR2hvc0tiSE5jWWpWTzBpREV1TFl0clpjQS9OeDVkbE1FbzhX?=
 =?utf-8?B?ajVpeEFWVXJwY3d3ZGo3R28reFR3NU43QmQ3eWdLYkZrcXBIUm1Cb1ZXTWtu?=
 =?utf-8?B?aWVDVHp2SXYvbm5VcjNPWThTditDc045cmxQb2M2WDdxdG5pcVB5UHYvTjMv?=
 =?utf-8?B?WCsyL0pmWmVkWDg0aHBXSDlRbXRMTGZMUDdlNmVFOEpQM291OHRIL2NKUVBy?=
 =?utf-8?B?b0wva1plWVhvem9oWGF5WjdkYkdpR2JLd2Z5eFBzUnNQQm9MY0JaM09BclJN?=
 =?utf-8?B?cHVoYU50ZklTVlowcHdUSGh6a1htM3Q4NkRNeGpiY2J2VmJwZU1CZjZ1WW1n?=
 =?utf-8?B?QjlTTzJOTVQ3NDhSaHZyMDM1T0JNdGVWVDJpeEVxV2JXMWNFbktpaEppcThU?=
 =?utf-8?B?RE1GTmhYZTZudERHZ0o4ZHg3SVFiZmV2TEpTNmNheVdzNTUwcU0vN1VRM0FW?=
 =?utf-8?B?czJkcFVlZUdVUnJSaTJxemhnL01CTlRnc3BwQU1lVlRLRHZMZEEvVFU4K2dx?=
 =?utf-8?Q?QoYOtZjydkHyXYgt00ZdbPY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D77C6ECA6AB744EB90A2AC1D9C2E3E7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e06c6e-ca19-4552-c3a6-08daa20d5c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 11:25:49.1335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFWv3zBhH3yyq5A+ERXCpzkDPzINIyUj1Q97arVJDX8ZekUEYWETQKiBKioWRdVauAiMxh43b6n/WllR6IklG8VmcT1vcQsCKbxAOUBVyCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5992
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTA5LTI5IGF0IDEwOjMwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjgvMDkvMjIgMTk6MjYsIEtyenlzenRvZiBLb3psb3dza2kgaGEg
c2NyaXR0bzoNCj4gPiBPbiAyOC8wOS8yMDIyIDA5OjU4LCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gPiA+IElsIDI4LzA5LzIyIDA5OjA0LCBLcnp5c3p0b2YgS296bG93c2tp
IGhhIHNjcml0dG86DQo+ID4gPiA+IE9uIDI3LzA5LzIwMjIgMTI6MTcsIEFuZ2Vsb0dpb2FjY2hp
bm8gRGVsIFJlZ25vIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gU29ycnksIG15IGJhZC4gSSBhbHN3YXlzIHJ1biBgbWFrZSBkdGJzX2NoZWNrYCB0byBj
b25maXJtDQo+ID4gPiA+ID4gPiBkdGIgd2l0aA0KPiA+ID4gPiA+ID4gYmluZGluZ3MuIEkganVz
dCB0aGluayB3ZSBkaWRuJ3QgbGltaXQgbm9kZSBuYW1lcyBpbiBtdGstDQo+ID4gPiA+ID4gPiB2
b2RlYw0KPiA+ID4gPiA+ID4gYmluZGluZ3MuIEkgd2lsbCBwYXkgYXR0ZW50aW9uIG5leHQgdGlt
ZS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBTaW5jZSBjdXJyZW50
bHkgdGhlIHZjb2RlYyBsYXQgYW5kIGNvcmUgbm9kZXMgYXJlIGFic2VudA0KPiA+ID4gPiA+ID4g
ZnJvbSB0aGUgbXRrDQo+ID4gPiA+ID4gPiBkdHMsIGRvIHlvdSB0aGluayB0aGUgY2hpbGQgbm9k
ZSBuYW1lIHNob3VsZCBiZSBjaGFuZ2VkIHRvDQo+ID4gPiA+ID4gPiBzb21ldGhpbmcNCj4gPiA+
ID4gPiA+IG1vcmUgZ2VuZXJhbCAoZXg6IHZpZGVvLWNvZGVjKSBpbiBtZWRpYXRlayx2Y29kZWMt
c3ViZGV2LQ0KPiA+ID4gPiA+ID4gZGVjb2Rlcg0KPiA+ID4gPiA+ID4gYmluZGluZ3M/DQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gVGhlIHZpZGVvIGNvZGVjIGlzIG10ODE5Mi12Y29kZWMtZGVjLCB3
aGlsZSB0aGUgb3RoZXIgbm9kZXMNCj4gPiA+ID4gPiBhcmUgZGVzY3JpYmluZw0KPiA+ID4gPiA+
IHRoZSBWUFUgaW5zdGFuY2VzIChhbmQvb3IgdnB1IGNvcmVzKS4uLiBJJ20gbm90IHN1cmUuDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gS3J6eXN6dG9mLCBwbGVhc2UsIGNhbiB5b3UgZ2l2ZSB5b3Vy
IG9waW5pb24gb24gdGhhdD8NCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFdoYXQncyB0
aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZW0/IEkgdW5kZXJzdGFuZCBwYXJlbnQgZGV2aWNlDQo+
ID4gPiA+IGlzIGVudGlyZQ0KPiA+ID4gPiBibG9jayBvZiBjb25zaXN0aW5nIG9mIG11bHRpcGxl
IHByb2Nlc3NpbmcgdW5pdHM/IElmIHNvLCB2aWRlby0NCj4gPiA+ID4gY29kZWMNCj4gPiA+ID4g
YWN0dWFsbHkgY291bGQgZml0IGluIGJvdGggcGxhY2VzLiBCdXQgZmVlbCBmcmVlIHRvIGNhbGwg
aXQgYQ0KPiA+ID4gPiBiaXQNCj4gPiA+ID4gZGlmZmVyZW50ICh2aWRlby1jb2RlYy1jb3JlLCB2
aWRlby1jb2RlYy1sYXQsIHByb2Nlc3NpbmctdW5pdCwNCj4gPiA+ID4gZXZlbg0KPiA+ID4gPiBz
b21ldGhpbmcgbGVzcyBnZW5lcmljKS4gU29tZXRpbWVzIGl0J3MgdHJpY2t5IHRvIGZpbmQgbmlj
ZQ0KPiA+ID4gPiBuYW1lLCBzbyBJDQo+ID4gPiA+IHdvdWxkbid0IHdvcnJ5IHRvbyBtdWNoIGlu
IHRoYXQgY2FzZS4gSnVzdCBub3QgIm10ODE5Mi12Y29kZWMiDQo+ID4gPiA+IDopDQo+ID4gPiA+
IA0KPiA+ID4gDQo+ID4gPiBUaGUgcGFyZW50IGRldmljZSBpcyB0aGUgZW50aXJlIGJsb2NrIGNv
bnNpc3Rpbmcgb2YgbXVsdGlwbGUNCj4gPiA+IHByb2Nlc3NpbmcgdW5pdHMNCj4gPiA+IGFuZCBo
YXMgImdsb2JhbCIgY29udHJvbCByZWdpc3RlcnM7IGNoaWxkcmVuIGFyZSBMQVQocykgYW5kDQo+
ID4gPiBwcm9jZXNzaW5nIGNvcmVzLg0KPiA+ID4gDQo+ID4gPiAgIEZyb20gbXkgdW5kZXJzdGFu
ZGluZywgdGhlIHByb2Nlc3NpbmcgY29yZXMgYXJlIHBoeXNpY2FsIGNvcmVzDQo+ID4gPiBvZiBv
bmUgYmlnIFZQVQ0KPiA+ID4gYW5kLCBkZXBlbmRpbmcgb24gdGhlIGFjdHVhbCAoY3VycmVudCBn
ZW4pIFNvQywgdGhlIFZQVSBtYXkgaGF2ZQ0KPiA+ID4gb25lIG9yIHR3bw0KPiA+ID4gY29yZXMu
DQo+ID4gPiANCj4gPiA+IFJpZ2h0IG5vdywgdGhlIGJpbmRpbmdzIHdhbnQgdmNvZGVjLWxhdFhA
YWRkciwgdmNvZGVjLWNvcmVYQGFkZHINCj4gPiA+ICh3aGVyZSBYIGlzDQo+ID4gPiBhIG51bWJl
ciwgbGlrZSB2Y29kZWMtY29yZTAsIHZjb2RlYy1jb3JlMSkgYnV0LCBpbiBteSBvcGluaW9uLA0K
PiA+ID4gY2hhbmdpbmcgdGhhdA0KPiA+ID4gdG8gdmlkZW8tY29kZWMtbGF0QGFkZHIgYW5kIHZp
ZGVvLWNvZGVjLWNvcmVAYWRkciB3b3VsZCBiZSBtb3JlDQo+ID4gPiBkZXNjcmlwdGl2ZS4NCj4g
PiA+IA0KPiA+ID4gLi4uT3Igc2hvdWxkIHdlIHNpbXBseSBsZWF2ZSB0aGUgYmluZGluZ3MgYXMg
dGhleSBhcmUgYW5kIGp1c3QgZ28NCj4gPiA+IHdpdGggdGhlDQo+ID4gPiBhYmJyZXZpYXRlZCAi
dmNvZGVjLShod3R5cGUpIiBuYW1lcz8NCj4gPiANCj4gPiB2aWRlby1jb2RlYy1sYXQgc291bmRz
IGJldHRlciwgYnV0IEkgYW0gbm90IHN1cmUgaWYgaXQgaXMgd29ydGggdGhlDQo+ID4gY2h1cm4s
IHNvIEkgYW0gZmluZSB3aXRoIGJvdGguDQo+ID4gDQo+IA0KPiBUaGFuayB5b3UgS3J6eXN6dG9m
IQ0KPiANCj4gQWxsZW4sIGNhbiB5b3UgcGxlYXNlIGNoYW5nZSB0aGUgYmluZGluZyB0byB1c2Ug
InZpZGVvLWNvZGVjLWxhdCIgYW5kDQo+ICJ2aWRlby1jb2RlYy1jb3JlIiAoc28gY2hhbmdlICJ2
Y29kZWMiIHRvICJ2aWRlby1jb2RlYyIpIGFuZCB0aGVuIHVzZQ0KPiB0aGVzZSBuYW1lcyBmb3Ig
dGhpcyBjb21taXQ/DQo+IA0KPiBEb2luZyB0aGUgY2hhbmdlIHJpZ2h0IG5vdyB3b24ndCBicmVh
ayB0aGUgQUJJLCBhcyB0aGVyZSdzIG5vDQo+IGRldmljZXRyZWUNCj4gdXNpbmcgdGhhdCBiaW5k
aW5nIHlldCAod2l0aCB0aGlzIGNvbW1pdCBhZGRpbmcgdGhlIGZpcnN0IHVzZXIpLCBzbw0KPiB5
b3UNCj4gY2FuIHNhZmVseSBnbyBmb3IgdGhlIHJlbmFtZSB3aXRob3V0IGFueSBjb21wbGljYXRp
b24uDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo+IA0KPiANCg0KSGkgQW5nZWxvLA0K
DQpObyBwcm9ibGVtLCBJIHdpbGwgdXBkYXRlIGluIHRoZSBmb2xsb3dpbmcgdmVyc2lvbi4NCg0K
VGhhbmtzLA0KQWxsZW4NCg==
