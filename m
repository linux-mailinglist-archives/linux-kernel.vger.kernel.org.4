Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857DE7105F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbjEYHKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbjEYHJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:09:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B854919D;
        Thu, 25 May 2023 00:09:46 -0700 (PDT)
X-UUID: 1ca84900facb11edb20a276fd37b9834-20230525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/oLj3BdLOb7WSQN4p+a9sJ0Mo7ko4sH480agAECTe/E=;
        b=VayI5VLK4XMp17K5E4cLlGHSwGnPQ8ZcK8nhWR25fWNVYbGl0rCpn6HTDDaLIdIOd4v36rSbAqMUZ47uo8FHLNTd1yvUG1kaISlk8lS0mjdE97p/kKVLYtgO5D4nsRlFmqxKOcb8cfeBdV5KYiOhtmfVtSh/27XnxbHg6R65BK4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:758d969a-c7f9-47bb-9524-24cc8a3173f2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:758d969a-c7f9-47bb-9524-24cc8a3173f2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:bcd3f56c-2f20-4998-991c-3b78627e4938,B
        ulkID:230525150941RG0VXQWP,BulkQuantity:0,Recheck:0,SF:19|38|17|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 1ca84900facb11edb20a276fd37b9834-20230525
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 329324345; Thu, 25 May 2023 15:09:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 15:09:37 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 15:09:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgEWQNTm6QAK1XB31UOHtqkh4Qp+XLzfwOnXcS8pyyIFIVqqVD/GMFcuz4tKG0dwy6N5v6NR827NUfoI/OdNLz5sFecDuGZ+74tgdlNEFF+dVgQyyPNh9Ctcgjvjl9ADZvrfM93/5L6tUbyrrcGeLjxNFdPD5W0Bme1am5Wwr9ghf/vmR24FW/aZhXYjgj+lEA3FS8j3GNsTU526UqZGFScsePJPhwavoosGK4RnZBThya5gZcg4pvZOVRilgAP56YXkq/ygFOIEjokdeBWct0uvX1Yg/EYh5CvnonQz2nBctQUGvi+1CZRiHbw1I90jLlSlt2AxF4HgCDAiePfQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oLj3BdLOb7WSQN4p+a9sJ0Mo7ko4sH480agAECTe/E=;
 b=PfhxaGHwP77GP4KK5vM4wFKK/utGITP9uKHrER/yA34ZUnR8hdR/7tu14DTycn+4VXz+hN+KUHgGfzLgqDJWKAfBgsaLnKVZTiUWO4g/JZXUJVaRbmf7qu309QaZ6Nb31ub24ftIqJlJFxDeL7eGWkc951Wa/pyFo8XT4xr6Q6HobB0dA2CmV/0SjaaWgWu+LtPO2El9aheUWUCKcF2A0vTkcwcQc7Zdt5+2ck+4dDdchNW7iuwYbFeVMQPdr9z48qQ7NbFbq43kEhXsNPzvKvkiGSIjw3nXUZLelFwHJ1bDvhjeUKdExs2J02b4Wwdgq+rUn1J/KqsOxY1rXDjQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oLj3BdLOb7WSQN4p+a9sJ0Mo7ko4sH480agAECTe/E=;
 b=ndGpgJPZ8b2uGJvo2z/YYxdriZS5kWdXXRwFJgL9u2j5vpt7ZmMdXS/odqJk1x/AR+gY5VRa/Z7nTpZKuJcaWQBo8OoKwDYqoiW3lBu5EiLmxTKj+RQ3J7TyFvyd5B/MI8Opd4/Rc45XJmLiICLrSogUv8B8JyiPHqetM/CnZbA=
Received: from SG2PR03MB5070.apcprd03.prod.outlook.com (2603:1096:4:d0::19) by
 PUZPR03MB6157.apcprd03.prod.outlook.com (2603:1096:301:b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Thu, 25 May 2023 07:09:34 +0000
Received: from SG2PR03MB5070.apcprd03.prod.outlook.com
 ([fe80::da23:cc83:c195:77cd]) by SG2PR03MB5070.apcprd03.prod.outlook.com
 ([fe80::da23:cc83:c195:77cd%4]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 07:09:34 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "jstephan@baylibre.com" <jstephan@baylibre.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        =?utf-8?B?QW5keSBIc2llaCAo6Kyd5pm655qTKQ==?= 
        <Andy.Hsieh@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "fsylvestre@baylibre.com" <fsylvestre@baylibre.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add mediatek mipi csi driver v
 0.5
Thread-Topic: [PATCH v2 1/2] dt-bindings: phy: add mediatek mipi csi driver v
 0.5
Thread-Index: AQHZh82MnhOeQsvIm0id8ldZeegKaa9cpbSAgA36Z4A=
Date:   Thu, 25 May 2023 07:09:34 +0000
Message-ID: <60ee0c015eabc83bc5a7ed89932e4ee8daf1c1e1.camel@mediatek.com>
References: <20230515090551.1251389-1-jstephan@baylibre.com>
         <20230515090551.1251389-2-jstephan@baylibre.com>
         <ab9aa30f-82d7-1d14-5561-e19ff10af0b0@linaro.org>
         <4yppinkucchwnwtnnpbqdn4bejmntjq3q6mx6es55f2pwyce3c@qdhdks47lpyt>
In-Reply-To: <4yppinkucchwnwtnnpbqdn4bejmntjq3q6mx6es55f2pwyce3c@qdhdks47lpyt>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB5070:EE_|PUZPR03MB6157:EE_
x-ms-office365-filtering-correlation-id: 359da5f9-6837-4995-c85b-08db5ceefe5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJvgbCHitnICWieLAzVQr3PVfzVvKw3zWEyEhYrmeDUcPdb3MpEsdXBVqkE+R127YZ95wNLu0iyy06MXg17NwY2qD7pkazhYObYho0k5/1vR7c7KKWAjwKuoE47BOcjwriBoJw6ZlOONc2EBlLwIT1P93e98TEfbJTH0C6BTSTCZAOOcvnQlWvBqN7J1He1+cfFCUbrqsB/EZDpfAY2hTyl8DUaiX0QM+gmhNuQZ4JWgKPGxg8x3c4q0Rz5j9ExB6enI3ue2Zh0XIERgbwbZO0hS73qBO8zczrH7r+7f5TxRQZpb33oTMqiHFX2CrRaLyq35BKFBZHKkGvlHcdKJ4ZTwynks2CkO25oiIPj/OPm5rgDZquVvkPVo8E3tpgDO5g7Pgp8kpT3HZH/QX4eVyU0XcIqNHe8A0QZ9paqoM4LPSh0a9+w4FOQ9hENWOVK/MZryeB0CW2NTs5tb5H1VeawUYD12g4m0fyLljrcKYjtVJ1Q760JIQnoTAQYKKewTYNr7wbHR3Ut/q2x5lQ+KQu2dVHgyu5Il4FNwSmflJPxvPCkWX7X+DIuTI8/9Rt1VKiHdpTOsth4g+KpSSGMUTUdi/lhE2egd7fMEKVzBFiq8ZgaGRDC+fubnQXBrONIHUGXcYwtFR36gFiwiCr/bhyM0V+Tq3hud4QOORxiZ1xE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB5070.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199021)(6486002)(2906002)(71200400001)(53546011)(966005)(91956017)(76116006)(38070700005)(66556008)(54906003)(66446008)(66946007)(66476007)(110136005)(478600001)(8676002)(122000001)(38100700002)(85182001)(7416002)(316002)(5660300002)(86362001)(2616005)(36756003)(4326008)(41300700001)(6506007)(83380400001)(64756008)(8936002)(26005)(186003)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2ZrMWtubHV4Znl5ajRxVkdhcHBzUS9NSkQzSkhuQ2RxMkpheXl4VjdqMEtl?=
 =?utf-8?B?QXdMVHdFL0E5MVlEME9ONFg1M2JuYzROd3g4SnNMU0RxcE1sMXhJRXlwUmFv?=
 =?utf-8?B?SDBaaS8zNm5QNmtTQ3VYZjNjYlVPWDkzWDkvY1RVZnJMWFJmeTc2NHVjcXB2?=
 =?utf-8?B?UnZsc3RBRkN1dS9WK2U0S0lrWGFvV0dORmg5NDI0UnhrdEtaOTVhM21oeWts?=
 =?utf-8?B?akpUeXF5OGw3WjF1TFNtSFVGNFp3dlhUbjU2a2FFRUx1a0RsTUJyMjdORnVD?=
 =?utf-8?B?WlJNb0RMZzZPc2lSUmZRNXF2cFQvL2wxYjAxZGQySEpMZGRTRUx5LzM2L3M5?=
 =?utf-8?B?MlZMbndtR2hCVjdDYmdsYXJLZzJBTVdjV2ZUbnhwVGNxVHlKUlNPZ0I1YmdH?=
 =?utf-8?B?Z2hRWWZtQjJlYkk1S2trSGhOYnFmS2hRbjB4eGhTU0FNWjU1NFNDbHAwcmpL?=
 =?utf-8?B?YTJJaEZvSHRrNFR5UWZITVc5NnZhYmgxdHVjWjFLV3VJK1ZCc2hUaWVNVkJl?=
 =?utf-8?B?Wityc0R5ZUwvc21Fck45d0tXZ2FlLzlzMktSejR6R21QdFAzcE9SZDhyRWZm?=
 =?utf-8?B?VWtibS91TVowTWxlV0NFVjV3SVZrdmRINk54dVZjUkI0OTV3dFlTVTVqMFZ4?=
 =?utf-8?B?SkVLZk9zVUI0V2Yzb2NBc1ducjRJQldXdlRHK3VPc2R2NjZBcXVTMTVZaC9i?=
 =?utf-8?B?aTBVbUpoN0M5QXJRUkMxQkZlT3dURmVLYS9iQ0Z0T1hsQklWSXVNMmNZUHJv?=
 =?utf-8?B?MXF3b05vOFg2V3VBYU1JdlAycXJpRk5jVGo0eDNIWU1yNXZ6R2wwVmd6T3RG?=
 =?utf-8?B?TEdBazVQc0xrSFJPc0YyS0JPYWhvdHBHK0QyZjFPMXc3VVh1Qm9xdlhPRFFm?=
 =?utf-8?B?WS9iNVVzdlJEK2NtRElpc3czbitSQUx2M1dUcTdHZ0tENnh1bTZ5TGhLY3Rq?=
 =?utf-8?B?SVdTYktXR2JJbklUbkt6UlRMN2k2SEtZbzRpWlhtOG9oZWxhWS9lQllVZXNE?=
 =?utf-8?B?WmJ4ME9GYjYrNVA5WjdwQUp5ZGdkS3NUeHpPVFpEdVVvdDBLUFQ5UFB3eGFp?=
 =?utf-8?B?aURuRjk4SWxMcEN6L3p3czVTNnVMZ3VxQ2VmLzI2d0hBd0dLb1NmZlNRejh3?=
 =?utf-8?B?RVpLeGIwNXoxelBhczB5UU9GbVFoMTA1UUplYTY4K2Vvc1RpL3NzKzZrT3VU?=
 =?utf-8?B?dWRmYkdEbnlZK0tVazEzMzRxS2tEWHIvU3RzTnZsYWE5MTlreW1qUDRnOWtD?=
 =?utf-8?B?bGpsbFJYMzZUcXlQUnVDdVVJOVVjb0JkbDh1UmxWYVpDcXFOYXpENTFhaXJu?=
 =?utf-8?B?bVJjOGh5aXNRVWpPOER4b0Q2M3lFZmZoNTdvMDd0Z1RWc04wZDdQbGt4N1lz?=
 =?utf-8?B?bENtbENIeE5lTStHL0tONm1yVlUxajBoQm9lN2owQWFnWUI5c293UjcxUkZY?=
 =?utf-8?B?UHJFaHdPYkxxU2lkajZUSTI5bXhrNWRZTFAxdy8wclZ0UmRiTXJHUzlzM2pG?=
 =?utf-8?B?SlA4ampFbW54RndJTGE2RElsRlI2T0pXSGpVbzR6dkk1UzlqUit1eDhVRHU1?=
 =?utf-8?B?NEk0MkpDbXRvN3FJZ1pDZmdmYXpEZFRrUG8veU1NQVRDR25BdURoelN1MjJW?=
 =?utf-8?B?ejQ5MzF4YWpJYmVMMW1pZUlJbFQ1U3FWelpCcmF5b3JWTUE2YjYyMWZBQStT?=
 =?utf-8?B?S3FwZHVBQ3lxTkdOekloRXVVd2U2WFBWZmdBd0dOdUw2bDljRXNIRWJ2NzZq?=
 =?utf-8?B?cmZPU2ZEaDB6bTVzVnRmYTZlQ3MvQkhlbGVKNXdWczdVZHVTRDVHREJpRzA3?=
 =?utf-8?B?RDBGTjNFazhHVUcyU0o2VjQ3ZUZnYWdVNVU2ZVRGTUc4U3ptUmpzeVA1d3pp?=
 =?utf-8?B?VjA5REE3M2I4d2hNbTlJK1BhM1ExTG80OG5vVnVmTTVuamNqMkhPNWZDNTlt?=
 =?utf-8?B?ODErenhYeFdiN2VhcC9BbHJDRitDK3dJZDJES3pqWkVma3RuOWV3aGt0QUha?=
 =?utf-8?B?TUc0clhCVnhHb0pVQXprYTdhNXpJbUFKejJ3dFpUb2FTYlB4UWswWitWOSsx?=
 =?utf-8?B?SklacGg3cDJhdFNiWTV4MlVydngydFpLRUx0UUJuUm1uOGY0dXR6eTZCQWpE?=
 =?utf-8?B?d2JnaG5oN0laVWtvQTV6VlZZSndEdU1IMGUzcVNiREYwZWdVSDZJa3g4TExh?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43448A73028D2F47A02532F713E68540@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5070.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359da5f9-6837-4995-c85b-08db5ceefe5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 07:09:34.2598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egH5JbyXMMgNyASk1Dc7PTETEfwP70AB3fYSu+dndfT34PayAflP7WZIMPnyp5SdhcMwuJZLVN8EZ6sdliiVjE0rku7pLyICD83eM1l/HSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6157
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTE2IGF0IDExOjQxICswMjAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29u
dGVudC4NCj4gDQo+IA0KPiBPbiBUdWUsIE1heSAxNiwgMjAyMyBhdCAxMDowNzo0N0FNICswMjAw
LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+IE9uIDE1LzA1LzIwMjMgMTE6MDUsIEp1
bGllbiBTdGVwaGFuIHdyb3RlOg0KPiA+ID4gRnJvbTogRmxvcmlhbiBTeWx2ZXN0cmUgPGZzeWx2
ZXN0cmVAYmF5bGlicmUuY29tPg0KPiA+ID4gDQo+ID4gPiBUaGlzIGFkZHMgdGhlIGJpbmRpbmdz
LCBmb3IgdGhlIE1JUEkgQ0QtUEhZIG1vZHVsZSB2IDAuNSBlbWJlZGRlZA0KPiA+ID4gaW4NCj4g
PiA+IHNvbWUgTWVkaWF0ZWsgc29jLCBzdWNoIGFzIHRoZSBtdDgzNjUNCj4gPiA+IA0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogRmxvcmlhbiBTeWx2ZXN0cmUgPGZzeWx2ZXN0cmVAYmF5bGlicmUuY29t
Pg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSnVsaWVuIFN0ZXBoYW4gPGpzdGVwaGFuQGJheWxpYnJl
LmNvbT4NCj4gPiANCj4gPiBXaGF0IGFyZSB0aGUgY2hhbmdlcz8gSU9XOiBjaGFuZ2Vsb2cgaGVy
ZSBvciBpbiBjb3ZlciBsZXR0ZXIuDQo+ID4gDQo+IA0KPiBIaSBLcnp5c3p0b2YsDQo+IEkgYWRk
ZWQgYSBjaGFuZ2Vsb2cgaW4gdGhlIGNvdmVyIGxldHRlciwgYnV0IEkgd2lsbCB0cnkgdG8gYmUg
bW9yZQ0KPiBkZXNjcml0cGl2ZSBuZXh0IHRpbWUuIENoYW5nZXMgZnJvbSB2MSBhcmUgbWFpbmx5
IHN0eWxlIGlzc3VlcyBmaXhlZA0KPiAobW9zdGx5IGZyb20geW91ciBmaXJzdCByZXZpZXcpDQo+
IA0KPiA+IFN1YmplY3Q6IHlvdSBoYXZlIHNvbWUgbXVsdGlwbGUgc3BhY2VzLg0KPiA+IA0KPiA+
IFN1YmplY3Q6IGRyb3AgZHJpdmVyLiBCaW5kaW5ncyBhcmUgbm90IGZvciBkcml2ZXJzLg0KPiA+
IA0KPiA+ID4gLS0tDQo+ID4gPiAgLi4uL3BoeS9tZWRpYXRlayxwaHktbWlwaS1jc2ktMC01Lnlh
bWwgICAgICAgIHwgNjINCj4gPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ICBNQUlOVEFJ
TkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNiArKw0KPiA+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKQ0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NA0KPiA+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxw
aHktbWlwaS1jc2ktMC0NCj4gPiA+IDUueWFtbA0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxwaHktDQo+ID4g
PiBtaXBpLWNzaS0wLTUueWFtbA0KPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGh5L21lZGlhdGVrLHBoeS1taXBpLWNzaS0wLQ0KPiA+ID4gNS55YW1sDQo+ID4gPiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi41YWE4YzBiNDFj
ZGYNCj4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWsscGh5LW1pcGktDQo+ID4gPiBjc2ktMC01LnlhbWwN
Cj4gPiA+IEBAIC0wLDAgKzEsNjIgQEANCj4gPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiAoR1BMLTIuMC1Pbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiA+ICslWUFNTCAxLjINCj4gPiA+
ICstLS0NCj4gPiA+ICskaWQ6IA0KPiA+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3BoeS9tZWRpYXRlayxwaHktbWlwaS1jc2ktMC01
LnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFrVUFCamJRTzYtX2pyQU5LaXFvTFB4WmtoXzBM
QXBsUXdsZ0NHOWxobUNLbTJlYzhwQ0l0WVVCMy16UTJQR0JubEFjZ3NCaHdyT2dpNXFlaWxyZGRa
NXMkDQo+ID4gPiArJHNjaGVtYTogDQo+ID4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwqX187SXchIUNUUk5L
QTl3TWcwQVJidyFrVUFCamJRTzYtX2pyQU5LaXFvTFB4WmtoXzBMQXBsUXdsZ0NHOWxobUNLbTJl
YzhwQ0l0WVVCMy16UTJQR0JubEFjZ3NCaHdyT2dpNXFlaUFCb1N1LU0kDQo+ID4gPiArDQo+ID4g
PiArdGl0bGU6IE1lZGlhdGVrIFNlbnNvciBJbnRlcmZhY2UgTUlQSSBDU0kgQ0QtUEhZDQo+ID4g
PiArDQo+ID4gPiArbWFpbnRhaW5lcnM6DQo+ID4gPiArICAtIEp1bGllbiBTdGVwaGFuIDxqc3Rl
cGhhbkBiYXlsaWJyZS5jb20+DQo+ID4gPiArICAtIEFuZHkgSHNpZWggPGFuZHkuaHNpZWhAbWVk
aWF0ZWsuY29tPg0KPiA+ID4gKw0KPiA+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ID4gKyAgVGhlIFNF
TklORiBDRC1QSFkgaXMgYSBzZXQgb2YgQ0QtUEhZIGNvbm5lY3RlZCB0byB0aGUgU0VOSU5GDQo+
ID4gPiBDU0ktMg0KPiA+ID4gKyAgcmVjZWl2ZXJzLiBUaGUgbnVtYmVyIG9mIFBIWXMgZGVwZW5k
cyBvbiB0aGUgU29DIG1vZGVsLg0KPiA+ID4gKyAgRGVwZW5kaW5nIG9uIHRoZSBzb2MgbW9kZWws
IGVhY2ggUEhZcyBjYW4gc3VwcG9ydCBDRFBIWSBvcg0KPiA+ID4gRFBIWSBvbmx5DQo+ID4gPiAr
DQo+ID4gPiArcHJvcGVydGllczoNCj4gPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gPiArICAgIGVu
dW06DQo+ID4gPiArICAgICAgLSBtZWRpYXRlayxwaHktbWlwaS1jc2ktMC01DQo+ID4gDQo+ID4g
U29DIGJhc2VkIGNvbXBhdGlibGVzLiAwLTUgaXMgb2RkLg0KPiA+IA0KPiA+ID4gKw0KPiA+ID4g
KyAgcmVnOg0KPiA+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4gKw0KPiA+ID4gKyAgJyNwaHkt
Y2VsbHMnOg0KPiA+ID4gKyAgICBjb25zdDogMA0KPiA+ID4gKw0KPiA+ID4gKyAgbWVkaWF0ZWss
aXNfY2RwaHk6DQo+ID4gDQo+ID4gTm8gdW5kZXJzY29yZXMgaW4gbm9kZSBuYW1lcy4NCj4gPiAN
Cj4gPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gPiArICAgICAgU3BlY2lmeSBpZiB0aGUgY3Vy
cmVudCBwaHkgc3VwcG9ydCBDRFBIWSBjb25maWd1cmF0aW9uDQo+ID4gDQo+ID4gV2h5IHRoaXMg
Y2Fubm90IGJlIGltcGxpZWQgZnJvbSBjb21wYXRpYmxlPyBBZGQgc3BlY2lmaWMNCj4gPiBjb21w
YXRpYmxlcy4NCj4gPiANCj4gPiANCj4gDQo+IFRoaXMgY2Fubm90IGJlIGltcGxpZWQgYnkgY29t
cGF0aWJsZSBiZWNhdXNlIHRoZSBudW1iZXIgb2YgcGh5cw0KPiBkZXBlbmRzDQo+IG9uIHRoZSBz
b2MgYW5kIGVhY2ggcGh5IGNhbiBiZSBlaXRoZXIgRC1QSFkgb25seSBvciBDRC1QSFkgY2FwYWJs
ZS4NCj4gRm9yIGV4YW1wbGUgbXQ4MzY1IGhhcyAyIHBoeTogQ1NJMCBhbmQgQ1NJMS4gQ1NJMSBp
cyBEUEhZIG9ubHkgYW5kDQo+IENTSTAgaXMgQ0QtUEhZDQoNCkRvIHRoZSB1c2VyIG5lZWQgdG8g
a25vdyB3aGljaCB0eXBlIHBoeSBoZSB3aWxsIHVzZT8NCg0KPiANCj4gUmVnYXJkcywNCj4gSnVs
aWVuDQo+ID4gPiArICAgIHR5cGU6IGJvb2xlYW4NCj4gPiA+ICsNCj4gPiA+ICtyZXF1aXJlZDoN
Cj4gPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ID4gKyAgLSByZWcNCj4gPiA+ICsgIC0gJyNwaHkt
Y2VsbHMnDQo+ID4gPiArDQo+ID4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4g
PiArDQo+ID4gPiArZXhhbXBsZXM6DQo+ID4gPiArICAtIHwNCj4gPiA+ICsgICAgc29jIHsNCj4g
PiA+ICsgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiA+ICsgICAgICAjc2l6ZS1jZWxs
cyA9IDwyPjsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICBtaXBpX3J4X2NzaTA6IG1pcGlfcnhfY3Np
MEAxMWMxMDAwMCB7DQo+ID4gDQo+ID4gTm8gdW5kZXJzY29yZXMgaW4gbm9kZSBuYW1lcy4gSG93
IHRoaXMgaXMgdjI/DQo+ID4gDQo+ID4gPiArICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVr
LHBoeS1taXBpLWNzaS0wLTUiOw0KPiA+ID4gKyAgICAgICAgcmVnID0gPDAgMHgxMUMxMDAwMCAw
IDB4MjAwMD47DQo+ID4gPiArICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4gDQo+ID4gRHJv
cA0KPiA+IA0KPiA+ID4gKyAgICAgICAgbWVkaWF0ZWssaXNfY2RwaHk7DQo+ID4gPiArICAgICAg
ICAjcGh5LWNlbGxzID0gPDA+Ow0KPiA+ID4gKyAgICAgIH07DQo+ID4gPiArDQo+ID4gPiArICAg
ICAgbWlwaV9yeF9jc2kxOiBtaXBpLXJ4LWNzaTFAMTFjMTIwMDAgew0KPiA+ID4gKyAgICAgICAg
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxwaHktbWlwaS1jc2ktMC01IjsNCj4gPiA+ICsgICAgICAg
IHJlZyA9IDwwIDB4MTFDMTIwMDAgMCAweDIwMDA+Ow0KPiA+ID4gKyAgICAgICAgc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gPiANCj4gPiA/Pz8NCj4gPiANCj4gPiANCj4gPiBCZXN0IHJlZ2FyZHMs
DQo+ID4gS3J6eXN6dG9mDQo+ID4gDQo=
