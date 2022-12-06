Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CA9643D39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiLFGoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiLFGoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:44:11 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66E65FE3;
        Mon,  5 Dec 2022 22:44:06 -0800 (PST)
X-UUID: 4eea35d680374e51bcdd560b27039e7c-20221206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+Yh1Hi6RHJPDs9EyHNW2unJfQiuU4mKUyCkWYVK9/go=;
        b=Avn5tliF7AKg8F2QDVGRvVyMyyy7iwjmyKdV6+mNlAbxnOvITz5M9flIbt9lCNda8vZtGvaLznYW4asDfQJpFQL9NIiTwJD9/t5jUFDW2RggVNse83RbvRDLorjZGOYQcSYl3ay7vZXO4jrwqfqysroif8phI5zjgWlqwGQZ2uM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:fa559191-d88e-4439-a909-bfa1e1b0dc77,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:fa559191-d88e-4439-a909-bfa1e1b0dc77,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:dc9e6f24-4387-4253-a41d-4f6f2296b154,B
        ulkID:2212060154346MVY9JE9,BulkQuantity:8,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 4eea35d680374e51bcdd560b27039e7c-20221206
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1644667348; Tue, 06 Dec 2022 14:44:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 6 Dec 2022 14:43:59 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 6 Dec 2022 14:43:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrORMR0BL0pdiTLmwSdWaRa1tsqR5RUqnI9wzJKiUCXmh7DfKJlFYc2kQrL+Jtuk/NY67ZI9QNGtckPHu57iLvXowmQSdJERHq1jflmFLV3Si9WCli7xXA/wcaRlZu6Tul+dTQ5HhnlLmkh0LjNEeKPmCK7khGUKR18lIP/Rpw1KIULRZNR/a1p+5JgGLXQq+JhaP9DhLWR2G3b96NLwyqvwNfEg0zSmRhLSp/w4Vj0FPjjKtBPbYTvOgPyNaHkT7EvL1c2c5ECq4bXABCjsLZ0NZr9I3sNHBGIQ+xZTua9ee9f0yVZ0bW40lyvXseXwKc1FnVRpeEEA/GlRtl4VqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Yh1Hi6RHJPDs9EyHNW2unJfQiuU4mKUyCkWYVK9/go=;
 b=Q7B9BPNhnJ8J0DXF3gR6iaTFUHRnbnm0XFI1WievjSeOA18w2F+t8PPsikQkc5rQdPypiABxobcpoDLkFXxoYScYy+0P70e5jK3Ud6EQk3U1hxjbkCsJnv+6sKPulTYno6mEqkpdos2hK9+nAwI5dPjWpmw3++XHQdh1DCWZjezEFdj9/x1j6dT+OdtT67/7liConBczM583+r2eSCiBA35R9MfYDONtHySM+6QdyudTc2bA5Bv7yeIs7Z/uikH/GlEDsTSlaJD2W0HElow4lLpssQhJSBCZmFUES273/hvKtzCFrBgUSDnd7+/Kv+52APMD7Pl3HVkDNabLmdVSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Yh1Hi6RHJPDs9EyHNW2unJfQiuU4mKUyCkWYVK9/go=;
 b=WzZwh3ebqWZy39THpcbii6n68pnf4ltL4f4vUCCyW2ukqgwIm6coucSrwaQFJT49owokyDqMHuY++me/w0+/Vf58/sScSuYSFp1k+63TBwzkjzhQKF1eIYRER3KnRE5Ji8c9Bjf4E/4eiTSLWCGchbLLPPbWHGel5CyRe9K3YII=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by SI2PR03MB6487.apcprd03.prod.outlook.com (2603:1096:4:1a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 06:43:55 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b%6]) with mapi id 15.20.5880.013; Tue, 6 Dec 2022
 06:43:55 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4,1/3] media: dt-bindings: media: mediatek: vcodec: adapt
 to the 'clock-names' of different platforms
Thread-Topic: [PATCH v4,1/3] media: dt-bindings: media: mediatek: vcodec:
 adapt to the 'clock-names' of different platforms
Thread-Index: AQHZBgCQlnx5gc84MkuI7q0qbCe0Y65fmT4AgADW+AA=
Date:   Tue, 6 Dec 2022 06:43:54 +0000
Message-ID: <71003e4babe09bb7a5448bd7d0d5a987c9eb9c08.camel@mediatek.com>
References: <20221202034450.3808-1-yunfei.dong@mediatek.com>
         <20221205175430.GA2136513-robh@kernel.org>
In-Reply-To: <20221205175430.GA2136513-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|SI2PR03MB6487:EE_
x-ms-office365-filtering-correlation-id: 9ae7de83-7d50-4b9f-7ca0-08dad7553eb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VcDKp/a2qnclZtErG4I/UlzVKJL7PxGDpZGCQGXnxpf9ckZN0aVav7bV7ald60dq7qi0Z9NSW50bpx45xgu5sNobZRZXNHTOp3bB/bxtz+1Dsl51H9UqZPBby17rlAUDOxeya59i2HdkIJE7ADiTHpl5c9u6W1k1Rq5PvW6Nd+2HqP6jMCHOwhFPo3nQH/hpkxJ0BZB22So9zrE8LY1GVp/MBcIMctSfRaifiHEVEJIOHqWzdzJ+CkvFlJdszlB3CnWosjEVXleWid39bxRR+GY0BOU5f+XhugFx7J3goJeS6opcZ/JyiKrgMdTL/eI4iko2KJXJhb7aBjRVuxWIROUXzTai3ku+0Tn9EdYq58wkwtfUSB//qkRRAeRIXSDeeYmWqoL3p2v0epCAMago9UTiWe6NWh2knZofnHUlWOC8bTOXL5bO3aS2ZUEbtBFu4XvrPaYQ28+t/Tyk8yUuWkqirpeuir3Ho+C3/xNpJYDJ0QEy8ZQECBjivKzAf4cP41KA4sxb+yWi99bVjajDz5OpMXvzX9QXnRdeKFrTg7fRd89UpGAhTHLlKjRZX2RP/2CgyplDPQVhwF8zJatzD2bRiSd58uwpeHsQ5fbaz0wgznkxobyf8aM1e3bJ+3cX+r0fQeifNdoKWkGHDlx2fbFNd/TM3oGPuKyvtD+gqd/LXJy9CThZGMJLtkqxNncfnNy8EnVFnpVts6ZT3CmkhGuiNrr68g5BDvXIrFnieU11ib89r1666yHxdNciRazNMiIRHtm5wR6LEZ7jaXFwJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199015)(83380400001)(26005)(186003)(6512007)(41300700001)(8936002)(38100700002)(2616005)(5660300002)(7416002)(122000001)(36756003)(6916009)(85182001)(6506007)(54906003)(38070700005)(6486002)(4326008)(2906002)(478600001)(316002)(91956017)(86362001)(71200400001)(76116006)(66476007)(66946007)(66556008)(66446008)(8676002)(64756008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWl6TlF1dkwzT2ZmNmVsVWhlR2tvc29vMVZtdXpvMGhSUFdjaU9SNG14MUtp?=
 =?utf-8?B?SHgxQlB5b2lkSUh1NWRJWHQ4NFQ0czdNN3Bldi9jYkpSMGpGM28wNHMrVUFq?=
 =?utf-8?B?VDRIdXF6bjQvSTJ2TndjbExucmVuZFE4ajlORWZCa1N5MUhiZ1NUbVovL3Ur?=
 =?utf-8?B?bkdmZmpxM1ZENm9vOTBIMDlpMlRPOXVXOGp1eDlpbExiZTRXTlZiUmcwMkxO?=
 =?utf-8?B?Z2ZSYUV1WW01UWRFUWZvcUZJanFSRnRvMllYa2VVSy95NUZiTWNaMmJrZGlv?=
 =?utf-8?B?cm0rWndWNEJFa2pjUEVpTjc2ZkljTWhmVlNOOFBvTlRCNk1CSDBZaVM4a21Y?=
 =?utf-8?B?bkRvMGNRQmdnSXRQaGo2OTMzL2xkS2tRcW1DVHJ6SmkxaHdvR2xHamdzTE0x?=
 =?utf-8?B?YVNHWkRNZi9Hc1haN0dzTmZseks3aThoVFk5VVRHb3lUaFNjdG02U3Q2Q2NE?=
 =?utf-8?B?WUVmRnZSdiswUzZRWTlkWmtPT21OMDlib3JMeVJkcUtPYklpUmMrRjY3NlpL?=
 =?utf-8?B?ZzFFMjV6NUZYeDNqZ2gxalk4ZUJkYXF4T2VPUUR3eHYwM2tWa0dKNnI4VmhU?=
 =?utf-8?B?aHB3UVhHckJCVXd4Q2xhUStna2dsV2dDTTRWaHhEa1RWcmVhV05KQ0dCTi8w?=
 =?utf-8?B?KzF0bjMvclBEWW9pWURNejFjNHQwdEZMZjJGRFR0Mk9ReTVqbU8veEExZSt4?=
 =?utf-8?B?WUFValFxaDhyNkdseEYrK3d2NnhLWS9aU0dKb1lkaWFiU3ZYbWZPbUdHbXUr?=
 =?utf-8?B?cDMrdEh3eTlOSGk1bjJvODBDM3d2WWhmQ2lnQzg3Y2lSVjRyeStrbHZSR2tj?=
 =?utf-8?B?bS9oVmhzMDNsN3kxRERGdlNvRDJtZGxDeEhtRDlTOHlEYldDRFNsM0RwV3k3?=
 =?utf-8?B?b2h1U1loa0V5QUNZY0xBQ00zUVBiQjREQTNReVN5cXR6MGxFYmZRSnpWcStR?=
 =?utf-8?B?TmFwN3hGblA1aUdEeTQyY251TlMxSVUrZjdqblcwYlNuTERxNkNNVVRUcjRQ?=
 =?utf-8?B?U0E1aWQ4d2NZRWJXY3NnbndsRm9nenFOM0p2RmxuVUVqNHdXaTBYbWM4QU5X?=
 =?utf-8?B?aFZRZzdteHE4R3o2aGUzN0Y4NGJsRjNnK3JCZkxXWHpHRktSWVBBZk5NSzNa?=
 =?utf-8?B?d3o0TFBXbDJYcXBVMFl2MjY4RWk0clNGV1dhbm80UkFSeXlLUnovdFNtYVpT?=
 =?utf-8?B?OHlzbmh2RjFVbm5OT1NHYW4rTldCR3VWMGt6R2ZZRks5SEpNSVhuSE0zMkdV?=
 =?utf-8?B?OVRWQnlFeEs0bUppUFE2WDF1ckJsZzRydElPcFgrRmh2Yng0aGlpcjFJZDM1?=
 =?utf-8?B?TllJeUxyazRzT016c1pZbW9jWG1uemhhZU84UDRZeldIN3hmemVpeGFhaFho?=
 =?utf-8?B?TFNhaVIvR3dIeHpyZHlTbjVGUys4bWx4NjdoaFcydEFxaTJaOGFJQlBCUEFa?=
 =?utf-8?B?KzBIT1oxZWw5azl5Vmx4Mmk0YzRCWFowNDBNVUI2TzFvTnA2aW41dzJKT1A5?=
 =?utf-8?B?b3ZzYURadlJhekh1WW1sUFpPcFVnb3IzSzdPOXlZS29wOUpKQmNlaEV6cFd3?=
 =?utf-8?B?WWRUZzhxVENYRHhwb2tFU24yajEwNzBaelJ5Y0hUYVRhMjR6dUlJZVFySmJz?=
 =?utf-8?B?N01XdlpsS3Vmbk9LUXloNUZjYTUrcW94NGZXejZoVGMwbnV3bEVWUG92VVY0?=
 =?utf-8?B?S1J5SU82QXV5cmFUdW1oOXRaV0w1aDlheGtmRHowWjVsN3g2dnhUeWNaNDhO?=
 =?utf-8?B?bk5GS3ZnT0pHZEpvM1hncUsxeEcyWnFJcGllanpTQ0hjSWo2QnRxVVptL3RW?=
 =?utf-8?B?SGNvbnIwMXFkZU56a2FOLzdEYjZkeFF6S1A5dG9LOHhpQ2RmQVZ2NVhlWEpk?=
 =?utf-8?B?alZtWWJwaExoS3YxRmh4T1IvcHF6Wkg3SERxYlExYnJoQ1ZoK29jYXhCTHJq?=
 =?utf-8?B?bE5ueURGVTI3d2NOcG9wVzRoUTA2Nm82OFR1RTNFZS9pbVpRVlF4elE3c2tt?=
 =?utf-8?B?TlRtRkFNTG5Wc3ZwKzlsRlFLSU1ZWi9iU1dtTHR6QUVUQk5GenluaVdMUmZ5?=
 =?utf-8?B?cXNRdVYvc3UxcDY0N1dtb3VaZHRIbGxndThEdzFKbnVTVmZYMXMrejgvbE9a?=
 =?utf-8?B?MG5CcjlyUzFORW1sRnJlUzNiZWZFVW1lZEs2ZkJIazNwalp2a0M4dldaY29l?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91E7AE6D5B124A4E8B615A1A2B9B0A34@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae7de83-7d50-4b9f-7ca0-08dad7553eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 06:43:55.0060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJlSsWIkXp6vyVqGI+8nV9rZ3GUnbBT/K1acylWfDpqAux+xnPzCAZXzLn6xUxgvdW2fTR+IslxvzM9dxvjGWTtj17JPO2AdnN9vmxqpldk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6487
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCg0KT24gTW9uLCAyMDIyLTEy
LTA1IGF0IDExOjU0IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gRnJpLCBEZWMgMDIs
IDIwMjIgYXQgMTE6NDQ6NDhBTSArMDgwMCwgWXVuZmVpIERvbmcgd3JvdGU6DQo+ID4gbXQ4MTk1
IGFuZCBtdDgxOTIgaGF2ZSBkaWZmZXJlbnQgY2xvY2sgbnVtYmVycywgc2VwYXJhdGUgJ2Nsb2Nr
LQ0KPiA+IG5hbWVzJw0KPiA+IGFjY29yZGluZyB0byBjb21wYXRpYmxlIG5hbWUuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogWXVuZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4N
Cj4gPiAtLS0NCj4gPiBjb21wYXJlZCB3aXRoIHYzOg0KPiA+IC0gcmV3cml0ZSBjbG9jay1uYW1l
cyBhY2NvcmRpbmcgdG8gZGlmZmVyZW50IHBsYXRmb3Jtcy4NCj4gPiANCj4gPiBSZWZlcmVuY2Ug
c2VyaWVzOg0KPiA+IFsxXTogdjUgb2YgdGhpcyBzZXJpZXMgaXMgcHJlc2VuZCBieSBBbGxlbi1L
SCBDaGVuZy4NCj4gPiAgICAgIG1lc3NhZ2UtaWQ6IDIwMjIxMTI4MTQzODMyLjI1NTg0LTQtYWxs
ZW4ta2guY2hlbmdAbWVkaWF0ZWsuY29tDQo+ID4gLS0tDQo+ID4gIC4uLi9tZWRpYS9tZWRpYXRl
ayx2Y29kZWMtc3ViZGV2LWRlY29kZXIueWFtbCB8IDQxDQo+ID4gKysrKysrKysrKysrKysrKy0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWVkaWEvbWVkaWF0ZWssdmNvZGVjLXN1YmRldi0NCj4gPiBkZWNvZGVyLnlhbWwNCj4g
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayx2Y29k
ZWMtc3ViZGV2LQ0KPiA+IGRlY29kZXIueWFtbA0KPiA+IGluZGV4IDdjNWI0YTkxYzU5Yi4uYTA4
YjJjODE0ZjQwIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tZWRpYS9tZWRpYXRlayx2Y29kZWMtDQo+ID4gc3ViZGV2LWRlY29kZXIueWFtbA0KPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayx2
Y29kZWMtDQo+ID4gc3ViZGV2LWRlY29kZXIueWFtbA0KPiA+IEBAIC0xMTAsMTUgKzExMCwxMiBA
QCBwYXR0ZXJuUHJvcGVydGllczoNCj4gPiAgICAgICAgICAgIFJlZmVyIHRvIGJpbmRpbmdzL2lv
bW11L21lZGlhdGVrLGlvbW11LnlhbWwuDQo+ID4gIA0KPiA+ICAgICAgICBjbG9ja3M6DQo+ID4g
KyAgICAgICAgbWluSXRlbXM6IDENCj4gDQo+IFdoeSAxPyBMb29rcyBsaWtlIGl0IHNob3VsZCBi
ZSA0IG9yIDUgY2xvY2tzLg0KPiANClllcywgSSBzaG91bGQgd3JpdGUgdGhpcyB2YWxlIHRvIDQs
IHdpbGwgY2hhbmdlIGl0IGFnYWluIGlmIDEgaXMgdXNlZA0KaW4gdGhlIGZ1dHVyZS4NCg0KQmVz
dCByZWdhcmRzLA0KWXVuZmVpIERvbmcNCj4gPiAgICAgICAgICBtYXhJdGVtczogNQ0KPiA+ICAN
Cj4gPiAgICAgICAgY2xvY2stbmFtZXM6DQo+ID4gLSAgICAgICAgaXRlbXM6DQo+ID4gLSAgICAg
ICAgICAtIGNvbnN0OiBzZWwNCj4gPiAtICAgICAgICAgIC0gY29uc3Q6IHNvYy12ZGVjDQo+ID4g
LSAgICAgICAgICAtIGNvbnN0OiBzb2MtbGF0DQo+ID4gLSAgICAgICAgICAtIGNvbnN0OiB2ZGVj
DQo+ID4gLSAgICAgICAgICAtIGNvbnN0OiB0b3ANCj4gPiArICAgICAgICBtaW5JdGVtczogMQ0K
PiA+ICsgICAgICAgIG1heEl0ZW1zOiA1DQo+ID4gIA0KPiA+ICAgICAgICBhc3NpZ25lZC1jbG9j
a3M6DQo+ID4gICAgICAgICAgbWF4SXRlbXM6IDENCj4gPiBAQCAtMTU5LDYgKzE1NiwzOCBAQCB0
aGVuOg0KPiA+ICAgIHJlcXVpcmVkOg0KPiA+ICAgICAgLSBpbnRlcnJ1cHRzDQo+ID4gIA0KPiA+
ICthbGxPZjoNCj4gPiArICAtIGlmOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAg
ICAgIGNvbXBhdGlibGU6DQo+ID4gKyAgICAgICAgICBjb250YWluczoNCj4gPiArICAgICAgICAg
ICAgZW51bToNCj4gPiArICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi12Y29kZWMtZGVj
DQo+ID4gKyAgICB0aGVuOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNs
b2NrLW5hbWVzOg0KPiA+ICsgICAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICAgIC0gY29u
c3Q6IHNlbA0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBzb2MtdmRlYw0KPiA+ICsgICAgICAg
ICAgICAtIGNvbnN0OiBzb2MtbGF0DQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IHZkZWMNCj4g
PiArICAgICAgICAgICAgLSBjb25zdDogdG9wDQo+ID4gKw0KPiA+ICsgIC0gaWY6DQo+ID4gKyAg
ICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZToNCj4gPiArICAgICAgICAg
IGNvbnRhaW5zOg0KPiA+ICsgICAgICAgICAgICBlbnVtOg0KPiA+ICsgICAgICAgICAgICAgIC0g
bWVkaWF0ZWssbXQ4MTk1LXZjb2RlYy1kZWMNCj4gPiArICAgIHRoZW46DQo+ID4gKyAgICAgIHBy
b3BlcnRpZXM6DQo+ID4gKyAgICAgICAgY2xvY2stbmFtZXM6DQo+ID4gKyAgICAgICAgICBpdGVt
czoNCj4gPiArICAgICAgICAgICAgLSBjb25zdDogc2VsDQo+ID4gKyAgICAgICAgICAgIC0gY29u
c3Q6IHZkZWMNCj4gPiArICAgICAgICAgICAgLSBjb25zdDogbGF0DQo+ID4gKyAgICAgICAgICAg
IC0gY29uc3Q6IHRvcA0KPiA+ICsNCj4gPiAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+
ID4gIA0KPiA+ICBleGFtcGxlczoNCj4gPiAtLSANCj4gPiAyLjE4LjANCj4gPiANCj4gPiANCg==
