Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBEF613119
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 08:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJaHLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 03:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaHLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 03:11:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137EBC756;
        Mon, 31 Oct 2022 00:11:49 -0700 (PDT)
X-UUID: b92b9e6ac45846c68e2df8289e4697dc-20221031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0+V8JCf28qCS/2ySdzkt05aKNJYxvdw4k6npZ3MKA84=;
        b=CwUb3Ayg5jQUIewFgDjMCF2LmkLO8mzRId1RP88x4cxudiM4SNKr33KUQUn0Z2roIJKzM+44Y66kww62xX5BR82mw1a6HCHVmIUOGQYSg0+rlwhVf9+jR/DrqA1u63JGzWHtExewp8/25bzh3x6FeNdQ+goljYIJDzy8h1n14K8=;
X-CID-CACHE: Type:Local,Time:202210311450+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:fbfc8f73-2e1f-4932-a5be-af9c01e54eaf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:5e61efea-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b92b9e6ac45846c68e2df8289e4697dc-20221031
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 383818932; Mon, 31 Oct 2022 15:11:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 31 Oct 2022 15:11:42 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 31 Oct 2022 15:11:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wql/CDhPOz38hRQ2rDMS6ylZ6N4Eqh6pIzc5WDu+6RgbAa1e8Uz4YLQvcXUNbxgLzN0lkiajsse58qZXoBAGgLXoYeLBa1lxYmckEbWO1gf/UlP8j2I56jUZcTJ2hmo4AOKcnSQMDQUac9d42NCg47WUyO86Q4HGX+G80MoOf5zlULWAY6tDcNqJi3lQt5wjEiuE1z+t97nbtn1T/+s8o+wf6BE9st+u6AoUWnLLsuipewNcKGDhuTmjJD+FsYGC834n+lhjwLCxxYw5HVhWIFg/mCUsLV5xoVJl8t2OvOdlDnUqzQXu+2+ay/kK0KgkppgUmnDzUqW8ixi0KsW4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+V8JCf28qCS/2ySdzkt05aKNJYxvdw4k6npZ3MKA84=;
 b=HcgwUDRZahaYq+hCbIdqtt6n1fqocejWZV1RfP902mAYsEJXz6PvRkUI8g1buIczhT4ip13zOtdijj7DgXaCl2gLWd9ZCVwvkFqAcOR5wHoDFZ7pkgUilry7zKUavaZtJ24Bss/B/v+okn8+Q5fdXSkluyPen+2MOF3KQEK/gLz0kMPUNwkHyOQt3c0N++xMWFd0+2x0mxWCxLg0hTXG6qB8TUvgvSEFEB1zawp3MvdzSJdTg/AwTaFHoJKasoisX3QX09B9Kc1u9jMgy4ugU7rSdm0EhUmsRTABoq3GwOSwlRpAI15NsF70aFVYX05KIQfzVIpN1jiwylmKvnaNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+V8JCf28qCS/2ySdzkt05aKNJYxvdw4k6npZ3MKA84=;
 b=CHR8dRnuUERf+vo8GVWqP13cyVPq6DzaSOsz+cvC/F/TVrApFF0Cuwxr2avI6FpwlKFcRbG8W6Xmbe62QwwUWZ3FCNhNjCJryyodrDD8IqiFWYUoTX2B0eAbC2mu0wVbfdA77oK3lDohA6/sAH47vnSzKyEyG+3BGtCwrBSqIeg=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB5727.apcprd03.prod.outlook.com (2603:1096:400:8d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9; Mon, 31 Oct
 2022 07:11:40 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::3438:1068:ae0:32cd]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::3438:1068:ae0:32cd%2]) with mapi id 15.20.5791.017; Mon, 31 Oct 2022
 07:11:40 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Topic: [PATCH v2 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Index: AQHY5ScFWHLYnLzLOUayQJYsxOuXFK4d5AyAgApBrwA=
Date:   Mon, 31 Oct 2022 07:11:40 +0000
Message-ID: <8e9650f61d22b6f1e4fa551be34e7316e3edf30c.camel@mediatek.com>
References: <20221021082719.18325-1-trevor.wu@mediatek.com>
         <20221021082719.18325-11-trevor.wu@mediatek.com>
         <20221024183357.GA2012388-robh@kernel.org>
In-Reply-To: <20221024183357.GA2012388-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB5727:EE_
x-ms-office365-filtering-correlation-id: 51a4c25d-3104-4d82-6a09-08dabb0f2847
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: amFBsEHwqbRTCoN74704aUVQ1U84Hg2p9nhErRqe5JXkcSw41t2EeQaIXps6LPqm5ywW0q3P6dSb7zwK1pEmBgM3iDnu4HKzLPHvgWuaEz4dkN9LHa5vABaVwjElf8cCF4VP+fnkmrKM666Y8XJkOeP4yyjhnq41IyjTbBWUYUwKHF2YplUt5aim7Gt5INLR5VEg9YvZpMBudDc4RsUVacNPBT12HyrHNTl7W4g2AOBbhPqkRW1UcRLtE7GAWOgdPQ/Ysd0U2WYv/S6wkO4wMb8d0jqkecV347tSlR8YQ1LDqThQCv+1Wl76zZJjqPgP+OlHgqCVGd2r6wJAFX+HDTTCcBbW2c+WovgcCr4S6tUIzDiYw5EKgyEbr/jEpGGyAbSIMgQ7mYVJYfWDTDUaoGabUAh9ygxHrgi3k7ZUR1Wkuyea3j31NdfBxz6DzBfNbV14VxvJ6x0jwXUuEbtDDt2bSHRegNuzVCkUxmq5FL9oQuHwsTiEG+ZYwREaULPM8eE/4J3/6mCmgQwYK3pxAqCKCjJvsqVVAB77pC/yVZAxWJwUwtYheTNxuxhn3HWcENYnu9qKRMEo6iUV3rVpE4hhUfI2mUD9iw4pPX/L9BKN0nTrGRO7fCXhDYTyVAQifCYILDNeqWtJtvQRKn+eMtsMdHbrIOZciVsTy2nVvEuPFSz0Cd+ShQgZY46HyB8HzF8MUZd3quQy1Grxy5sbx5R7/19nUN2ViN+iWoWxwSJUHaYi0Qed8Mqqb67F5LRZqYHFlgwPIvCYB7pEkmW1x/wHhkovEDftGCnK/pp1L/g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(2906002)(5660300002)(7416002)(64756008)(41300700001)(8936002)(66476007)(66556008)(4326008)(8676002)(76116006)(66946007)(91956017)(66446008)(6512007)(478600001)(38100700002)(38070700005)(186003)(6506007)(26005)(36756003)(6486002)(6916009)(2616005)(54906003)(85182001)(71200400001)(122000001)(316002)(4001150100001)(83380400001)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUYrSmQ1TTVzd0pZMmNQWkpBUTdEWGFzdzBQZ015WkxsVUV3SWZ5UFhackVv?=
 =?utf-8?B?bWpoY3RSby83S0RSOFBhWExrTFlBdUVSODlKbkZwK294STEyaFNxL1N0b0ky?=
 =?utf-8?B?Q3gvc1pndnAxeGhOY1NoL0l3c21TelIxaTVVWGZhY1dJSWJuNVloV0orMEcy?=
 =?utf-8?B?bitITk9XUDdoY29QWEpBM0o1clBlaTV0Rmc5bnYvQWVPNVMrOUdtaFRpd2I3?=
 =?utf-8?B?ME9xZ1c1a3R2aXJQWG5TbW9SOWhLRkdNZVg4UGE1VStlUnRKa0JuY1c5Zmtx?=
 =?utf-8?B?SDkxNGQ5cERJUmZCNlpiN1FHMER3YjF1NmM2ejFvYlJXWk9RWEVYVXdLbmhB?=
 =?utf-8?B?bUJJWFVZeElHOTdkWlhyVE8zUWJZY0QyVG5EWlNwMTV1MzAxWllWS2ZhL2Zh?=
 =?utf-8?B?dkVJUVdrR000cmFRbEN1VGlzaEt5MEc2NVpLdzJKMHlkN3drRVk1Vmxqa3du?=
 =?utf-8?B?N2J6NGhqakZFYmJ6SC9HWXpIQ3pjNUlzVWVlMjJBZTlLWTJkQTNJSEpXS1ZT?=
 =?utf-8?B?cTkvSVlRWWMrL0V3bzhQd05qUVNHRXZVS0VnSzhYVzRGNVhjNTVJdUZCbk5E?=
 =?utf-8?B?b3d2M0RVSzZpM1pYQXIxTE4rR0dRY0JEbzBVT0w5Z1ZDay9WWU4vOWdTT25t?=
 =?utf-8?B?b0VHM2hhNnY5MDVOOXB1TG9nTW9oM2RrZGVITkV2L1J2M3VIa0hMVFpWWGpw?=
 =?utf-8?B?WFRvV2ZsOUt5RThpVGhGVDdxQW9hcGlZeWU3WHViQ0pWdFZ4WG8xdXIxbDRU?=
 =?utf-8?B?UElDaGJubnNHekVBTzNheitrT3B6eVFySTRncmRFcmxFa0FhWEltcmcrS09Y?=
 =?utf-8?B?aW1nbXhYclg5S0F3Tk9Sai9qcENDNW5PdjBGREJQbThJY1RtSTg1K0RRNFFF?=
 =?utf-8?B?aTNVN1ZNZGFMUkJIR3VwRWk1RUE4TVR2YVJNNy9ZMUdIWWxZUHV3UDduT0tn?=
 =?utf-8?B?WTFQSG9XVjd3ZVMxZnRzTHBmMWdrbDk4LzE0REVFOHhxWDdndUx5Rk1UQWZZ?=
 =?utf-8?B?ODkwb1ZDTkNCYkNZSEJ5MDJPRVJEOHoyeDZzNjBqbGtwUjJhb2l5YjVSelVC?=
 =?utf-8?B?Z1RrWmNlSHNHaXMzNTRBK1ZuRTI4RkNCZEpUaCt1SFplTlJPb2w3Ykt6cStI?=
 =?utf-8?B?SVNIRWZCM0ZRQWEvMlh2cmtxdzlzSHdlVzd4cEhvWDBKbmZaSXpOcEpPS3BP?=
 =?utf-8?B?dklCRkMrSnJ3b0ZIVDlDV3oyUkszVENZNHhLNmJENjB3bmVNd25OSFAwUUdv?=
 =?utf-8?B?SE5XV3A0UWhmZGk5bkNOWEVzY0c3NkF0QWFpd1dYNmRVKzZ3d3BNMUl0UVBC?=
 =?utf-8?B?YXE3dWNlcUhsQWx6Y1lzY2FST0Y2ZWIvZkNUL3RhOEFyUWxGVnptWElKSTdJ?=
 =?utf-8?B?a0xZTTFMa2FWT3U4NHJIbGhFcEZsYlY3M3VKanJJTmkrSUVxSEp3c3M3MnNG?=
 =?utf-8?B?TGdySkFwSkFhSkptek8yYk5GM1d6b0t3OW52ajhxSGRKNWpXSFpSdDJKeWZa?=
 =?utf-8?B?ZjI5WkoyOEtUdXI0SnB6WWxUMWRJVzNQajZ4Q2VTSmJiYjZLVFhoWWRhejND?=
 =?utf-8?B?NktmRFZ2aVR1VU9jVStFNmQyMWRyYm1YQjhPY3BwYmNSQ0FmVmRhZ0JyeUVD?=
 =?utf-8?B?WVVoUXlKTk9hNWZkU2RvbGlWMEpaRFh2WTRCUmJpNmFWMVZHSHhST3JyZElq?=
 =?utf-8?B?Yy9yTFNuYXBvYUJVcVNZNHlod2pTTGRDampSUEtOTkYvbGo4a29rdDJZZHBO?=
 =?utf-8?B?VG52WmlFcUt1OXpCTG9HdE4rUWdETlhJQW5lSUthNEtKL0Vqb2d2VkFUR0Rh?=
 =?utf-8?B?ZmxWeEFIekk4d2JnamFsMU8ra1pBM2NTVDl0bDVSUU55VGFYUUFZRjFDVWdI?=
 =?utf-8?B?d3NUUGRCbElYL3BXYWNQaVFJaTNvL1dxditlVzdmbzRZZ0dLUWZhSjdEYmhY?=
 =?utf-8?B?WUM1aGpTa3M0Y0YyYjc5VEdrMjR3bTdGWSt3eklrOXErNjY4VVZrTWV1UXpa?=
 =?utf-8?B?bUpzSHB3cjdFTWluRitObjNacGJaR3JvWkZxWDRSWENzOXk1S3V3YWdtQXdU?=
 =?utf-8?B?dHg5NHpKT2xzV3pvQVNBemFuOThJdENXTTQ1VmFVamZ3K2o0K1VnRFlVU0ZB?=
 =?utf-8?B?UVBTYkpWR3d4SUFDRjJjSGJxRGNEayt2aHVsb0hKSmRiRittUWJJcUxLY0px?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03C2E33A3CC0DB49ABEF3037408266B0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a4c25d-3104-4d82-6a09-08dabb0f2847
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 07:11:40.0480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4At8IkRT1iway9FknQKPwC7MaZKizg7LXNp0Erk9Us+IAVUVSLePUavKGY/YSl3HUxyOotAy76mD/huqhFKgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5727
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

T24gTW9uLCAyMDIyLTEwLTI0IGF0IDEzOjMzIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gRnJpLCBPY3QgMjEsIDIwMjIgYXQgMDQ6Mjc6MTdQTSArMDgwMCwgVHJldm9yIFd1IHdyb3Rl
Og0KPiA+IEFkZCBtdDgxODggYXVkaW8gYWZlIGRvY3VtZW50Lg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFRyZXZvciBXdSA8dHJldm9yLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
Li4uL2JpbmRpbmdzL3NvdW5kL210ODE4OC1hZmUtcGNtLnlhbWwgICAgICAgIHwgMTg3DQo+ID4g
KysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxODcgaW5zZXJ0aW9ucygr
KQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NvdW5kL210ODE4OC0NCj4gPiBhZmUtcGNtLnlhbWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210ODE4OC1hZmUtDQo+
ID4gcGNtLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ4
MTg4LWFmZS0NCj4gPiBwY20ueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5iMmM1NDhjMzFlNGQNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210ODE4OC1hZmUtcGNt
LnlhbWwNCj4gPiBAQCAtMCwwICsxLDE4NyBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4g
Ky0tLQ0KPiA+IA0KDQouLnNuaXANCj4gPiANCj4gPiArDQo+ID4gK3BhdHRlcm5Qcm9wZXJ0aWVz
Og0KPiA+ICsgICJebWVkaWF0ZWssZXRkbS1pblsxLTJdLWNobi1kaXNhYmxlZCQiOg0KPiA+ICsg
ICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDgtYXJyYXkNCj4g
PiArICAgIG1heEl0ZW1zOiAxNg0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gDQo+IERvbid0
IG5lZWQgJ3wnDQo+IA0KPiA+ICsgICAgICBTcGVjaWZ5IHdoaWNoIGlucHV0IGNoYW5uZWwgc2hv
dWxkIGJlIGRpc2FibGVkLCBzbyB0aGUgZGF0YQ0KPiA+IG9mDQo+ID4gKyAgICAgIHNwZWNpZmll
ZCBjaGFubmVsIHdvbid0IGJlIG91dHB1dHRlZCB0byBtZW1vcnkuDQo+IA0KPiBJJ20gbm90IGNs
ZWFyIG9uIHdoYXQgZWFjaCBvZiB0aGUgMTYgZW50cmllcyByZXByZXNlbnRzLiBXaGF0J3MgaW5k
ZXgNCj4gMCwgDQo+IDEsIDIsIGV0Yy4/DQoNCkhpIFJvYiwNCg0KRXh0IENvZGVjIC0+IEVURE1f
SU4gLT4gTUVNSUYoRE1BKSAtPiBNZW1vcnkNCg0KVGhlIG1heGltdW0gY2hhbm5lbCBudW1iZXIg
b2YgZXRkbS1pbiBpcyAxNi4NClRoZSBpbmRleCBtYXRjaGVzIHRvIHRoZSBpbnB1dCBjaGFubmVs
IElELg0KMCA6IENIMA0KMSA6IENIMQ0KLi4uDQoxNTogQ0gxNQ0KDQpVc2VyIGNhbiBjb25maWcg
dGhlIGNoYW5uZWwgSUQgdGhleSBkb24ndCB3YW50IHRvIGJlIG91dHB1dHRlZCB0bw0KbWVtb3J5
IGluIHRoZSBwcm9wZXJ0eS4NCg0KRm9yIGV4YW1wbGUsDQpGb3IgNCBjaGFubmVscyBFVERNIGNv
bm5lY3Rpb24sIGFuZCB0aGUgZm9sbG93aW5nIHByb3BlcnR5IGlzDQpjb25maWd1cmVkLg0KDQoi
bWVkaWF0ZWssZXRkbS1pbjEtY2huLWRpc2FibGVkID0gPDA+OyINCg0KUmVjZWl2ZWQgZXRkbTEg
aW5wdXQgZGF0YSBvdXRwdXR0ZWQgdG8gbWVtb3J5IHdpbGwgYmUgW2QwX2NoMSwgZDBfY2gyLA0K
ZDBfY2gzLCBkMV9jaDEsIGQxX2NoMiwgZDFfY2gzLCAuLi5dLiBDSDAgaXMgZHJvcHBlZC4NCg0K
PiANCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICBlbnVtOiBbMCwgMSwgMiwgMywgNCwgNSwg
NiwgNywgOCwgOSwgMTAsIDExLCAxMiwgMTMsIDE0LCAxNV0NCj4gDQo+IG1heGltdW06IDE1DQo+
IA0KPiANCj4gPiArDQo+ID4gKyAgIl5tZWRpYXRlayxldGRtLWluWzEtMl0tbWNsay1hbHdheXMt
b24tcmF0ZS1oeiQiOg0KPiA+ICsgICAgZGVzY3JpcHRpb246IFNwZWNpZnkgZXRkbSBpbiBtY2xr
IG91dHB1dCByYXRlIGZvciBhbHdheXMgb24NCj4gPiBjYXNlLg0KPiA+ICsNCj4gPiArICAiXm1l
ZGlhdGVrLGV0ZG0tb3V0WzEtM10tbWNsay1hbHdheXMtb24tcmF0ZS1oeiQiOg0KPiA+ICsgICAg
ZGVzY3JpcHRpb246IFNwZWNpZnkgZXRkbSBvdXQgbWNsayBvdXRwdXQgcmF0ZSBmb3IgYWx3YXlz
IG9uDQo+ID4gY2FzZS4NCj4gPiArDQo+ID4gKyAgIl5tZWRpYXRlayxldGRtLWluWzEtMl0tbXVs
dGktcGluLW1vZGUkIjoNCj4gPiArICAgIHR5cGU6IGJvb2xlYW4NCj4gPiArICAgIGRlc2NyaXB0
aW9uOiBpZiBwcmVzZW50LCB0aGUgZXRkbSBkYXRhIG1vZGUgaXMgSTJTLg0KPiA+ICsNCj4gPiAr
ICAiXm1lZGlhdGVrLGV0ZG0tb3V0WzEtM10tbXVsdGktcGluLW1vZGUkIjoNCj4gPiArICAgIHR5
cGU6IGJvb2xlYW4NCj4gPiArICAgIGRlc2NyaXB0aW9uOiBpZiBwcmVzZW50LCB0aGUgZXRkbSBk
YXRhIG1vZGUgaXMgSTJTLg0KPiA+ICsNCj4gPiArICAiXm1lZGlhdGVrLGV0ZG0taW5bMS0yXS1j
b3dvcmstc291cmNlJCI6DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZp
bml0aW9ucy91aW50MzINCj4gPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgIGV0ZG0g
bW9kdWxlcyBjYW4gc2hhcmUgdGhlIHNhbWUgZXh0ZXJuYWwgY2xvY2sgcGluLiBTcGVjaWZ5DQo+
ID4gKyAgICAgIHdoaWNoIGV0ZG0gY2xvY2sgc291cmNlIGlzIHJlcXVpcmVkIGJ5IHRoaXMgZXRk
bSBpbiBtb3VkdWxlLg0KPiA+ICsgICAgZW51bToNCj4gPiArICAgICAgLSAwICMgZXRkbTFfaW4N
Cj4gPiArICAgICAgLSAxICMgZXRkbTJfaW4NCj4gPiArICAgICAgLSAyICMgZXRkbTFfb3V0DQo+
ID4gKyAgICAgIC0gMyAjIGV0ZG0yX291dA0KPiA+ICsNCj4gPiArICAiXm1lZGlhdGVrLGV0ZG0t
b3V0WzEtMl0tY293b3JrLXNvdXJjZSQiOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMu
eWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsg
ICAgICBldGRtIG1vZHVsZXMgY2FuIHNoYXJlIHRoZSBzYW1lIGV4dGVybmFsIGNsb2NrIHBpbi4g
U3BlY2lmeQ0KPiA+ICsgICAgICB3aGljaCBldGRtIGNsb2NrIHNvdXJjZSBpcyByZXF1aXJlZCBi
eSB0aGlzIGV0ZG0gb3V0DQo+ID4gbW91ZHVsZS4NCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAg
IC0gMCAjIGV0ZG0xX2luDQo+ID4gKyAgICAgIC0gMSAjIGV0ZG0yX2luDQo+ID4gKyAgICAgIC0g
MiAjIGV0ZG0xX291dA0KPiA+ICsgICAgICAtIDMgIyBldGRtMl9vdXQNCj4gPiArDQo+ID4gK3Jl
cXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSBpbnRl
cnJ1cHRzDQo+ID4gKyAgLSByZXNldHMNCj4gPiArICAtIHJlc2V0LW5hbWVzDQo+ID4gKyAgLSBt
ZWRpYXRlayx0b3Bja2dlbg0KPiA+ICsgIC0gcG93ZXItZG9tYWlucw0KPiA+ICsgIC0gY2xvY2tz
DQo+ID4gKyAgLSBjbG9jay1uYW1lcw0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6
IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNs
dWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyAg
ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ID4g
Kw0KPiA+ICsgICAgYWZlOiBhZmVAMTBiMTAwMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTg4LWFmZSI7DQo+ID4gKyAgICAgICAgcmVnID0gPDB4MTBiMTAwMDAg
MHgxMDAwMD47DQo+ID4gKyAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDgyMiBJUlFfVFlQ
RV9MRVZFTF9ISUdIIDA+Ow0KPiA+ICsgICAgICAgIHJlc2V0cyA9IDwmd2F0Y2hkb2cgMTQ+Ow0K
PiA+ICsgICAgICAgIHJlc2V0LW5hbWVzID0gImF1ZGlvc3lzIjsNCj4gPiArICAgICAgICBtZWRp
YXRlayx0b3Bja2dlbiA9IDwmdG9wY2tnZW4+Ow0KPiA+ICsgICAgICAgIHBvd2VyLWRvbWFpbnMg
PSA8JnNwbSAxMz47IC8vTVQ4MTg4X1BPV0VSX0RPTUFJTl9BVURJTw0KPiA+ICsgICAgICAgIGNs
b2NrcyA9IDwmY2xrMjZtPiwNCj4gPiArICAgICAgICAgICAgICAgICA8JnRvcGNrZ2VuIDcyPiwg
Ly9DTEtfVE9QX0FQTEwxDQo+ID4gKyAgICAgICAgICAgICAgICAgPCZ0b3Bja2dlbiA3Mz4sIC8v
Q0xLX1RPUF9BUExMMg0KPiA+ICsgICAgICAgICAgICAgICAgIDwmdG9wY2tnZW4gMTg2PiwgLy9D
TEtfVE9QX0FQTEwxMl9DS19ESVYwDQo+ID4gKyAgICAgICAgICAgICAgICAgPCZ0b3Bja2dlbiAx
ODc+LCAvL0NMS19UT1BfQVBMTDEyX0NLX0RJVjENCj4gPiArICAgICAgICAgICAgICAgICA8JnRv
cGNrZ2VuIDE4OD4sIC8vQ0xLX1RPUF9BUExMMTJfQ0tfRElWMg0KPiA+ICsgICAgICAgICAgICAg
ICAgIDwmdG9wY2tnZW4gMTg5PiwgLy9DTEtfVE9QX0FQTEwxMl9DS19ESVYzDQo+ID4gKyAgICAg
ICAgICAgICAgICAgPCZ0b3Bja2dlbiAxOTE+LCAvL0NMS19UT1BfQVBMTDEyX0NLX0RJVjkNCj4g
PiArICAgICAgICAgICAgICAgICA8JnRvcGNrZ2VuIDgzPiwgLy9DTEtfVE9QX0ExU1lTX0hQDQo+
ID4gKyAgICAgICAgICAgICAgICAgPCZ0b3Bja2dlbiAzMT4sIC8vQ0xLX1RPUF9BVURfSU5UQlVT
DQo+ID4gKyAgICAgICAgICAgICAgICAgPCZ0b3Bja2dlbiAzMj4sIC8vQ0xLX1RPUF9BVURJT19I
DQo+ID4gKyAgICAgICAgICAgICAgICAgPCZ0b3Bja2dlbiA2OT4sIC8vQ0xLX1RPUF9BVURJT19M
T0NBTF9CVVMNCj4gPiArICAgICAgICAgICAgICAgICA8JnRvcGNrZ2VuIDgxPiwgLy9DTEtfVE9Q
X0RQVFgNCj4gPiArICAgICAgICAgICAgICAgICA8JnRvcGNrZ2VuIDc3PiwgLy9DTEtfVE9QX0ky
U08xDQo+ID4gKyAgICAgICAgICAgICAgICAgPCZ0b3Bja2dlbiA3OD4sIC8vQ0xLX1RPUF9JMlNP
Mg0KPiA+ICsgICAgICAgICAgICAgICAgIDwmdG9wY2tnZW4gNzk+LCAvL0NMS19UT1BfSTJTSTEN
Cj4gPiArICAgICAgICAgICAgICAgICA8JnRvcGNrZ2VuIDgwPiwgLy9DTEtfVE9QX0kyU0kyDQo+
ID4gKyAgICAgICAgICAgICAgICAgPCZhZHNwX2F1ZGlvMjZtIDA+OyAvL0NMS19BVURJT0RTUF9B
VURJTzI2TQ0KPiA+ICsgICAgICAgIGNsb2NrLW5hbWVzID0gImNsazI2bSIsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAiYXBsbDFfY2siLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ImFwbGwyX2NrIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICJhcGxsMTJfZGl2MCIsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAiYXBsbDEyX2RpdjEiLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgImFwbGwxMl9kaXYyIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICJh
cGxsMTJfZGl2MyIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAiYXBsbDEyX2RpdjkiLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgImExc3lzX2hwX3NlbCIsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAiYXVkX2ludGJ1c19zZWwiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgImF1ZGlvX2hfc2VsIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICJhdWRpb19sb2Nh
bF9idXNfc2VsIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICJkcHR4X21fc2VsIiwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICJpMnNvMV9tX3NlbCIsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAiaTJzbzJfbV9zZWwiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgImky
c2kxX21fc2VsIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICJpMnNpMl9tX3NlbCIsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAiYWRzcF9hdWRpb18yNm0iOw0KPiANCj4gSXQncyBn
b29kIGlmIHRoZSBleGFtcGxlcyBpbmNsdWRlIG9wdGlvbmFsIHByb3BlcnRpZXMgc28gd2UgYXQg
bGVhc3QgDQo+IGhhdmUgc29tZSB2YWxpZGF0aW9uIHRoZSBzY2hlbWEgbWF0Y2hlcyB0aGUgRFRT
Lg0KPiANCk9LLCBJIHdpbGwgcHV0IHNvbWUgb3B0aW9uYWwgcHJvcGVydGllcyBpbiBWMy4NCg0K
VGhhbmtzLA0KVHJldm9yDQoNCj4gPiArICAgIH07DQo+ID4gKw0KPiA+ICsuLi4NCj4gPiAtLSAN
Cj4gPiAyLjE4LjANCj4gPiANCj4gPiANCj4gDQo+IA0K
