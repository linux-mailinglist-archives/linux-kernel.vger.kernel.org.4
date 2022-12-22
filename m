Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC03653D60
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbiLVJSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiLVJSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:18:13 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988CB20BDC;
        Thu, 22 Dec 2022 01:18:08 -0800 (PST)
X-UUID: d1a4cb8872b84c5898609e3a622a90d7-20221222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hnwy00jPYBKAzirwf00BWBsMlBDUIN/IsWa9Ij3Anzc=;
        b=KmTmYruv15Z0b04wcQY46zRTpTdq4ot0jmiB8J0kwjLj06rVSHl+bialXkfwmEkdrIj6GkmSk8QrKwGsAejAGESnhDQsdld8UPGTVzedqLHt3mVTekqn2cr6pZPtRBRCu2nVG4+RnmAVn4fQoIhmmKje5QlFg1f3VeB61M7VDWo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:a46337aa-43eb-429e-a905-cd78741300a0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:10fe1a8a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d1a4cb8872b84c5898609e3a622a90d7-20221222
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 382223372; Thu, 22 Dec 2022 17:18:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 22 Dec 2022 17:18:01 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 22 Dec 2022 17:18:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhWfpyryEBymBl4ZEd+5z28obTP1SQv49HbVkfFOW64h4QA/wXo1t4B3kdIXaQNZmwd3DgMiW1sRUDNYtW4dvNsbbEGsTDI1/bXlUuUbS2G/t7mYIGxycvEPMAqqSxFVrdM19KV6wZZiwr9XVcIbrvk4Zi9mOFDSYyzV/6SU145SZ+3VuPr31rBzGw43sivO3N9NmbekdP35uG+5j1CFKL72/cvzmP+eNsIsOY4+eCZlDT9TTFbjc1TDO3gN2xDZMRuCE9YQMIKAxnSgC5VCzM+MxCTfy1c1Gt3ViS4UqbSyek9lgxWnadiHFvqOaR7El1lDwy5YCWivtJrf0LlDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnwy00jPYBKAzirwf00BWBsMlBDUIN/IsWa9Ij3Anzc=;
 b=OYJa6EB/k9gD65tjZbzUdHTEhsQB0iL8kKHUJtjdNt9wYKMYFztpha+a8/HSHjb0g8Cl/5vhW0cPrmBTvspe28dm56+m2Lgn+0lncjBP6Qqiig5KK24ZVtgDC5T1ltqe1ViXLcm11iyuMV6BdBL4FxAQJtPrvsiB7q0RHjjNUR7sem4lJzy634SQ1+GVbAQ/hRc71O3EtrIbl+exUdahxNvteEYOyl2YzjtuFTKaNZvG7loru786yYknjH9KOByQ5ygdf4gztTG+5wCNOw+eHmHBN5d4c1Gq67QptVQwmeR0tvVCMC5q7Mln3Yc8qXCwWWN2dg+R0XoSrFYWyvh2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnwy00jPYBKAzirwf00BWBsMlBDUIN/IsWa9Ij3Anzc=;
 b=iNh5KTskbGvnb9R7Lw6a8HYuIE6C1SwkI5vFXpxD9i6T3NXflXij3IA1dSHDzfPgLB+ekaR10tGGnS5Bai6hZYLmHHYw4IybQXfIH/5blY2xtVO9DNTrbcRxOfKNbArrFErXh8gCCRBrTZoja91RhQf4u3ba1wndsHoFXieQrSk=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SEYPR03MB6651.apcprd03.prod.outlook.com (2603:1096:101:81::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Thu, 22 Dec 2022 09:17:59 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4139:bb22:3bf9:f1e3]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4139:bb22:3bf9:f1e3%6]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 09:17:59 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH] iommu/mediatek-v1: Fix an error handling path in
 mtk_iommu_v1_probe()
Thread-Topic: [PATCH] iommu/mediatek-v1: Fix an error handling path in
 mtk_iommu_v1_probe()
Thread-Index: AQHZE9Ss3wdcJ2MgPk6Wps7LwXrd5K55pOYA
Date:   Thu, 22 Dec 2022 09:17:58 +0000
Message-ID: <40866f6da41c8ae5127db0053bb3b449e5a2eb5e.camel@mediatek.com>
References: <593e7b7d97c6e064b29716b091a9d4fd122241fb.1671473163.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <593e7b7d97c6e064b29716b091a9d4fd122241fb.1671473163.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SEYPR03MB6651:EE_
x-ms-office365-filtering-correlation-id: d927c893-5ce8-4b5a-1e26-08dae3fd6b2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9BZxm2mTrF1AyfU8uNYTfP5Hi40kWKwGDveewM2HXp4rDSj+qIKv/hP00JDn+AtD6RTXw/g6eOUL9v8p3pcArKUYvKm2noonueVwiU9DV6i5HuxOEZlvZ6vkzCIOslVHtDKjB+/B901G1TMOuVZCfIp17x3TCtkdseucMDH9xEGXzmc1hZaBDKS1qz6E86CxMpEBGPH2hX+yZA4lAULAkfbGHWUnITJMszA9aM2vGVwukJG4pPxa2CJ89kNjQus/RKrxciAFmmworGGOQTmGyoivrL3+aXJUwwU62ipzJpfofydQ7SmnCaS1e/Lsk9wUsVBe3wN81oDFh6iHg0vFTP+D0BeMRh7Wg9QULuElRRNZnT1INXD7S/jNRY8MgNvA8YxCwTGH09h6cKknN9g+X14eAHrfBleOpNceHy8BvdOQxNRY397ifA3jPlLDccEzpexL2f0kgMz8wmcLXcYKuG3Wl6KUKB65EqqAljZVjRlWFiImDMFfJb7IPnH6WCsqpV6iAo0ekYny36L3hb3ebRTguI8cT8S9dLSdRiDSevaNaJRjuVmpXJDYNCTzKwXyRUuBG8dTzi9PNAo60JjGapXdwjdP0R/9BBB7uwmCxcnK+S1Qn75N4Mv3KZY0sI/SdBZnoEPIurqwWtsPikOAuXCk5NKcUo+mDitBg5hTq7/cyv2OkNZhefvE9ZPFup8EIFS1NG55MKVQCM6blbChCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(86362001)(38100700002)(122000001)(4744005)(4001150100001)(38070700005)(7416002)(8936002)(41300700001)(5660300002)(4326008)(66946007)(478600001)(6506007)(2616005)(6486002)(26005)(6512007)(186003)(76116006)(91956017)(8676002)(64756008)(66476007)(54906003)(71200400001)(110136005)(316002)(66446008)(66556008)(2906002)(85182001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0xhVGtJS1pQOG1rMUVyZ3R1MGJMYyt5Z1dlblJVVlAvdGcwMTJFNGxtdTRl?=
 =?utf-8?B?THNzNW90RzlGNEFIOXZDMWdDcnF1c1NGNlV4Nk10ZGoxWVdUamI1dXZXUitJ?=
 =?utf-8?B?aSs5WjkrbGhVTmdiTzJoYjJwaXRlN1pBdXRwNmRTSXlRWGRiV1hLTjVwSnBP?=
 =?utf-8?B?TThUVVdOdjV0N0hLdVRwY1RORXY0NkdURzNvMzhKN3lldmUvV2JLNDF6UEJU?=
 =?utf-8?B?anlqZUhVdUFJU3g0M1hMTWRnLzZobGxmdDdkSXBFYkRLa2dYY2ExbEVobHlB?=
 =?utf-8?B?UzJETWNuclI1UUl5cnB6S0hRNDMrWGhKczVMTjFuazF5RnljcUpnYm1uSnJB?=
 =?utf-8?B?Szc2NzdxR0xib2N6aUg2ZmpHSWU4bkN3YUdpZDc3N1JSbjZ3RHZVK0owOEJl?=
 =?utf-8?B?K05ZWnU1MWhhVHd0Z3NVNFlZaUQxMm1mdDNpbW5kZlpZalZSRUoxc0dwT29i?=
 =?utf-8?B?UkphN2xTZXYrckJyNHF5dmNFZVJPZURlcU9OMXFHR2ticlVkVHJnRWNFZEs1?=
 =?utf-8?B?TGcyMEFlc0FRVmcwcEJVc2tYRXlrd0MrazZmNEhKalRYNXo3SVJPMFFpS0dT?=
 =?utf-8?B?Mk1CSXFpZXI0K0VqL2FDM3VtMHIxcUkrWjFOT1JRa3Z3MHJtYzIwd0tTU3VI?=
 =?utf-8?B?cytPTXRSWXJHTmRmMjRhV0YwbDJZQzVYZjZka00yelpoT1A2eVhWZVVVMWkr?=
 =?utf-8?B?OS80dXFGTXhlRDFwT1JTUGN2OW5hd3pQb0lXTHp5dGxJNldMS2dPWmxQeVhD?=
 =?utf-8?B?OU9xTXptSHcwdVVtNjJTeXh5cUxrSWJKMzA0TzdPTVh0a0kvS0g4a3AvUE5k?=
 =?utf-8?B?bFJ0bjBWUXljNkZObVpmQnhxWHF6SWRFeUM5SDBpVGxSU0JHd1ViOVAwVllO?=
 =?utf-8?B?SWhHN1poa1FqWktjUXpyYmZ4TW1kS2pJeU5mNU9kMmFrZDl4aVJXcWRHbUY0?=
 =?utf-8?B?R0owS1JxZ2VqcXU1TFBPenc0ckZJWWdBZmZaWmh5cFR3dXJaeVVqNUJYTk8x?=
 =?utf-8?B?OGRDYW9kUUJTRzY2Nm1BNWhwbnM5cUc2Q1ExaDJuQ1JkZXpRRWVCdlBBNXM4?=
 =?utf-8?B?aXdnVDRYNFRFTElOZTNTSExUeW5icVRCVU1FeUFoaVpsMXU5bGtTTXFKeG91?=
 =?utf-8?B?cFliY1ljZDFHQWREUWZrajlSZ1piQythUDlkV0dsbHZDQlJCV3hBQWVCRFFF?=
 =?utf-8?B?eTh6a2MzbFViajh0a1gxMmNVQk83WVpFN0hZeWVPVnpFR2dTUE8vUFpRSDB4?=
 =?utf-8?B?UXZTZnQ2dWZEVHNZZFJNT2lZam1CaG8zYmhkRzhSRjB1bzhvRVQzckhJUFNR?=
 =?utf-8?B?MDR5NnZrcE9IT0gyaUZ3ZjRsR2RLa3lXdFlWbm1oT0s0dlJLYmdYY2JSNWlo?=
 =?utf-8?B?cWdpRFgzTUhaZkE1bGZ3MXkvcnNiMSsyTlR5b2RDWWdNWG1DN2FZVmtxbWhy?=
 =?utf-8?B?WVZ6WEdKV1UvV2pCSDFjVHFaVWNtTlo3aHF0b2FadFhVQzhqejhDbTN3Y0tG?=
 =?utf-8?B?S0tyaCtMbGRaK0ZMVzJOb1Axd09ERHRSMzYyaDIvVE5RdkZmVmV4bmtGTTJN?=
 =?utf-8?B?NHA0UmF4VWw4NEo2RnJYUm9TcTRmakpxdG84WnA0SEFlK2N1TTFTVlFkbzhn?=
 =?utf-8?B?YnViK3l4WkxYSzRWeXFtOEdTSlpNNEVOakhiNVJEOCtOS28xNTd0QndQRUE1?=
 =?utf-8?B?Q2JRWkNqKysyRS94MjNWbkIxQk51WTBMZXloTm9FQ3luNWVCMDZOTTBpL2tj?=
 =?utf-8?B?RC8yV29qL2pBYUcrNERha0g5czg0QWJKZDNKdXcvMWlaYUE2blk4b3dyWG41?=
 =?utf-8?B?b1VLN2c2alg2YXRxQVNGbEFwQWRxQWxJZkVqTU1pUGpVblBTdzY5bnJ4REls?=
 =?utf-8?B?L3RvWkVyeC9vSFJLMDA1WTZJY0lpL2dyQlJhaWE3VDZ0SVFISUd5YVdpRFhQ?=
 =?utf-8?B?eTBmdGRaa3NMcGdMRUNoYUFWNG5YdDFNdWd0SUNKbUFYQmQ1MW5WTEZzdmEx?=
 =?utf-8?B?QlIvd1Q3clMzdUZEMXdzakxoVjlENlNKcGtlZmk2QnlWYSs4Q3IwdWRPeHhS?=
 =?utf-8?B?YTZkVlBtOWZHR2t5SUlKWHJCdUI2M1k4VStNNlYzQk0xUXJnbUoxc0ZXbUdm?=
 =?utf-8?Q?R1kkFA9yoN6IO981MrqJRwIt3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A60F887A2771CD45B6587476B7F27680@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d927c893-5ce8-4b5a-1e26-08dae3fd6b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 09:17:59.0293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlfP1PbW22hdkgPdxw5bxqXW6q7ZWtMVhud2GpGzYis0A69aDVrhwQegDlEoFFp0Z3A9dssrmnbFqXrfuudZpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6651
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

T24gTW9uLCAyMDIyLTEyLTE5IGF0IDE5OjA2ICswMTAwLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3Jv
dGU6DQo+IEEgY2xrLCBwcmVwYXJlZCBhbmQgZW5hYmxlZCBpbiBtdGtfaW9tbXVfdjFfaHdfaW5p
dCgpLCBpcyBub3QNCj4gcmVsZWFzZWQgaW4NCj4gdGhlIGVycm9yIGhhbmRsaW5nIHBhdGggb2Yg
bXRrX2lvbW11X3YxX3Byb2JlKCkuDQo+IA0KPiBBZGQgdGhlIGNvcnJlc3BvbmRpbmcgY2xrX2Rp
c2FibGVfdW5wcmVwYXJlKCksIGFzIGFscmVhZHkgZG9uZSBpbiB0aGUNCj4gcmVtb3ZlIGZ1bmN0
aW9uLg0KPiANCj4gRml4ZXM6IGIxNzMzNmM1NWQ4OSAoImlvbW11L21lZGlhdGVrOiBhZGQgc3Vw
cG9ydCBmb3IgbXRrIGlvbW11DQo+IGdlbmVyYXRpb24gb25lIEhXIikNCj4gU2lnbmVkLW9mZi1i
eTogQ2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmphaWxsZXRAd2FuYWRvby5mcj4NCg0K
UmV2aWV3ZWQtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MuDQo=
