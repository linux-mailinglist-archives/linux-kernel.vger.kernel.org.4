Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B3563EB6A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiLAIoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiLAInx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:43:53 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B488B4F;
        Thu,  1 Dec 2022 00:43:44 -0800 (PST)
X-UUID: 22cd19d396a54cc9a8d48a8e9c367ceb-20221201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=rgoPk/BLigM8O79ku2HfXq9cut1CSqB7jZMarNMG/lQ=;
        b=KYaCKk4Od6zhWfy3VUK2c+Bblclr1cFcgwTkJ3S1b5Zb1xai+GCzd2lC2H1aHEOybrv83XZKpx+YzGP9eL+hCIXxvY+3kkyYtXSGJXbkgSd/dxfGGVao42NK2uLWeYS5xHehMBe3BVf7FqTswXPETS+egFqZSS5zPbdptD5leuA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:8b2a9bb7-eb04-45fc-9382-c5737928a9ab,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:8b2a9bb7-eb04-45fc-9382-c5737928a9ab,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:ea695e30-2938-482e-aafd-98d66723b8a9,B
        ulkID:221201164340VDJGKQIR,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 22cd19d396a54cc9a8d48a8e9c367ceb-20221201
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1466061048; Thu, 01 Dec 2022 16:43:39 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 1 Dec 2022 16:43:38 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 1 Dec 2022 16:43:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyQfKlfBYwiUYv1NgukX25MLzufiw48ylGnoYqpQ+UyS65JpCCRCRV9xoQosYFk0RObJH1ba7pZmeGMySB+IhwP7XjpHyinB1S3/xS1l4Bwu5ltRA+jvIT546V1HggZfGX+zKSnqMotClXpo7dpKjf15FJ7KS/2eRmpLKZbfcmgLAmVvn2MzhaI9xg9rNfuyT0cn2jboDuEq6jHl7s4h3fr1WdRbDPqx5Egq2oRWuL9BfhQb8Qd6eQqkxyCeZ8hTvlsu3qrrr+cmwhvvFbWt29ztC2APqOdyxpWy1psRpCKT1pEmNCTRlsUWKcsLOjKUFgyy5DnF4cLqfQjd24KiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgoPk/BLigM8O79ku2HfXq9cut1CSqB7jZMarNMG/lQ=;
 b=aBDFP5QOmj3x5LGhe6lG4rS16tEcNo+hIAssxTY1oJi5Ec1jY72aDDhWpxa5yh7QtOTvs9ZcfJQCkix9R9RbxiS2xrUsH7PUncnPeHdLQP3ZWLuI9HIwlqccx0B+817oKzqsvxY11/QmEW5pZ2b3QCgbfNvIJaNohfFe4oA71xDXeBJelAEhOkgZ84JE5KKCMIvLwjZSsgEgZJkrK/l8budWFDIJDc2YRCDLpqsM4H4FTwAiMxgKdUxetlPJ1N0R9ObUUH5cpQVFlqqTHi6TrJJ2jBaNflSbgT0c2nFoyBgsrMlQ8+BxcPJa6+E2MdNPDPCX0ZpxZ7q6jh0ZORyfAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgoPk/BLigM8O79ku2HfXq9cut1CSqB7jZMarNMG/lQ=;
 b=fUAdd74aPYEbBqwjGDZ4dP4zzeF1TSuzDxFaymL1TfNwpMy1dN3D93n6krSUrQgU7upVt7m2F6DJucVCfV7mERM4pwOI3KBcgVX/3LT2eJV9rrWBdcd+cq1vocTcFJZIKJD6tHnUI6Y8qRX6t4g8A10DtRP5MTiWhEbm2u9fKb0=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by KL1PR03MB5506.apcprd03.prod.outlook.com (2603:1096:820:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Thu, 1 Dec
 2022 08:43:36 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::961e:5315:5a2f:1e8e]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::961e:5315:5a2f:1e8e%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 08:43:36 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 03/12] ASoC: mediatek: mt8188: support audsys clock
Thread-Topic: [PATCH v2 03/12] ASoC: mediatek: mt8188: support audsys clock
Thread-Index: AQHY5Scb0+y44k7XlUu5apSFkxk6/64Yh3oAgAAVdQCABk8UgIABK3KAgABFWYCAOJregA==
Date:   Thu, 1 Dec 2022 08:43:35 +0000
Message-ID: <7dfdb4866ccf7356c2a8beb0359e5b62df4f245f.camel@mediatek.com>
References: <20221021082719.18325-1-trevor.wu@mediatek.com>
         <20221021082719.18325-4-trevor.wu@mediatek.com>
         <de66f0e3-7694-7315-c896-9211259a1a17@collabora.com>
         <776557c0fda5a538549ee0d4f4b7f482b0d69934.camel@mediatek.com>
         <473d67ed-198f-82c6-9f32-5827c1f8c852@collabora.com>
         <500f80b1ac84101af482bdfcb46671d523d51068.camel@mediatek.com>
         <360a5f27-8abc-938c-04c7-13ea65b5a89f@collabora.com>
In-Reply-To: <360a5f27-8abc-938c-04c7-13ea65b5a89f@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|KL1PR03MB5506:EE_
x-ms-office365-filtering-correlation-id: a4038c8c-e441-4a15-f9e4-08dad37822c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SPgYUZ7rpPwz/TFCF0JxnkH7JmOGWSr5CDcOrYS7/pryu7/3Rb8hoTwdsPbR4N4//aFfUMBjqMlMKHEXhn/w3VfNTJZ3Lyu7tT9sML5SQ15n70F9B0fVrVyqZLO3yFd5eo+kFXR8O7jz/9InR7UxEjQnCzACIq6BJMPnVSvdPcmfgNmULq4aiAS1fCJJDH3t6WXSP9nbki/k7D7bP+vMA6ndj265q+BcnyFAhr4vEwba5PNCvbnv/FVXHq3aN0WVsIc7VRWsHLRmhGAdhYd5S0yBXqO2QblC+jgYXRV95ogCfMH0WnX5YXmgGAy7Ky9Tc7GpcZr7M1T9vJaaQG6+XzHwa4HofRynvHmBa7qRc9tcEHGgXU01mftGHQFyHzEjMkA3Rpw1FB5fB/lRfZWD5b0WmXfr4tRhH2u7RK5NR15Dw02s4PIzCnCPCv8ESndhqvh+tKJ29+bRu4p+fFRtdAPLAJlZpPqoMydPrGk/rlxzm1E+uXBi8Vgl/06kyq7g4+qlkRsGyWTOC+ze/pkovOkH3mMRtrTFnlGnN9dIJp/JlRRnzasfVRw2XVVuneeGfmvlz0xaTJ4QYza3VgFRF266nAJg5vmCx/uaAgr72w76WiB9zs8pokJvo4AbhsDRRWK2LIcSsY+f2wZryZNGx/JFh4z3d6J9wByt6WQwlQ31TtyEUw8rP/D52mZEOWDSdejyNjwBMoS3BAQl8VnvYeioEI3MC7lO7GesdutZNMtD2MpVLa35fU+2gDxzrdlO2jDsbagBFGnO93f+l7yUWENEgh/J1B5FcyVtrVhFWuA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199015)(110136005)(83380400001)(86362001)(91956017)(2906002)(316002)(41300700001)(38100700002)(38070700005)(122000001)(4001150100001)(7416002)(8936002)(26005)(4326008)(6506007)(5660300002)(186003)(71200400001)(2616005)(8676002)(54906003)(66556008)(66446008)(76116006)(66946007)(66476007)(6486002)(64756008)(6512007)(966005)(478600001)(85182001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFh5Q3BWZ1czUU9jVVFoR1hPOU5wemNVUEIrRW05TWJFNHR2bVlRN3cxMnVn?=
 =?utf-8?B?OUl5Q244cVhLTTJtQnJXamJLWU4xU0VCcVlVV0dYVVpDQWdacXZTa3NHdlNp?=
 =?utf-8?B?S1dScWh5a3lyS2tIait3NWFJbmQ0WWJQVWtsTzNYUEpEZG9DdEFDS0htcWFq?=
 =?utf-8?B?WUJ0T1pHQU9ZZ05kd0p1VkFidnU3UGw2OXNJZkpROWVERFp3WEU2MDkrRnJW?=
 =?utf-8?B?TG5CNGF1dzk0amZJbDZEVFF4ZG05SmppZC9tTi8vNERHWC9oSXVaaTY0SjU1?=
 =?utf-8?B?Uyt1bXBObjJ5MWRSZDVEeDUrWkl5di9XTkpnQVRCbFRzNVQ2RlN2a05BR1Za?=
 =?utf-8?B?b0hPbVNQYUhmMFl6bU1oaklMSlV0Q1hOZVJFTnR3SkV6OTUzdW52R0lZWmds?=
 =?utf-8?B?MU5pQlRZd0hDRy9aZzZNc3NqWXlrT3ZCYjdWZ2Z3b0VHQzhTb0RRVTJuUW5Q?=
 =?utf-8?B?NnpZdlJGVmFGS0lWV0FwVGdYanhPQk9tSUdGYnlIcXZRRHNGbkk5aVRMN3FD?=
 =?utf-8?B?WXl2eXlndStKQWJUbHQ1OEZjZWRrY1FuUkVUK2hDMnpCRFdSUHJJQkcya05D?=
 =?utf-8?B?MmRUamdHalI1RC9TNHBqZWdpOE1LWWhqaWtKOWwvQnBmbVgxU3RwaGMzdHdB?=
 =?utf-8?B?cFVHWDhzemUrVng3c3dJZzFZSG44UnRSMGRoWGV3WENFbTdUcTF2NndnTWox?=
 =?utf-8?B?d2UxOFM5VFE1Q29CeC9QeWtSMWxHTE9ndWI0bVNvampMVHp3NEF6MzUrcXla?=
 =?utf-8?B?NVRuMVR0S0sxaC9sSjZtc1QzNStZc2J1OUFGcDAvZVpnQldOc1RqeUJiVG11?=
 =?utf-8?B?ZFNYaHEwRVNaeVRKTFdRbXpacWljN3EwWHgrSDNxQzdZZzliZmM1OTd1ZUFw?=
 =?utf-8?B?bE40MDk2L1lEK2IzSUI3d0VFUGxLYlRyZjhBVmxOZVlFeEhtWjM2NmdMb1Jj?=
 =?utf-8?B?M2ZiTzAxN2ppRTNUOWdSYU5BQ213YlFYdmxMMmZJQVZjVndydnhVWkFKV0c3?=
 =?utf-8?B?OUpxNjl4M0lkM0hHbk4xYXZsM3prZGFucTNZamdxUC9VMmdGa2VKNVZsZ0xX?=
 =?utf-8?B?MkZma2ZHd2k5T2l3N1g5YytWMGNMbVkxSFFDRHRReFhBTklNV2ZGWUtJRU1G?=
 =?utf-8?B?ODdycmwwSDhHU2pLcE81K2JOb0UwSXhXQzFranRpby9ScTVxV2JTcjE2M1pk?=
 =?utf-8?B?M0xvYUEydExsblA3dHVPeTlMdUdWUjRHSWhZWVJ3WDRlZWJuRWxZTklHd2xD?=
 =?utf-8?B?VG56RUM3KzBmOUsrTGo4T0h2QWJtZ2xZSi9maUtLVXNLMlZOVXR1dlBlU2Jy?=
 =?utf-8?B?S3NWeFVnaFgzMGpwaHFmK3F4WUpkQ1RTbmNwNGRFa2krVXVmOG04YnFFMHVN?=
 =?utf-8?B?c2tXSzEzM21Yd1BjWUV5c2xzem9vUjFTUW9Bc25PMFgrTHRuYjhKUElLVkYw?=
 =?utf-8?B?eWZodktITEJqOHJCeGtNeVNoZ0pJSURmU25CUkNVUXl4SUxZMjVYb0RhbWx5?=
 =?utf-8?B?akNZSTFsUUV5aDN6aXRWTGJ1Zmt4WWdNdE9IT3ZSTStBZ2VlQUxSMmJBRlNm?=
 =?utf-8?B?bFBGckdISTJvdUltTDkzNThLWnZENnp2VGdGbUg4OSt2OUl0UXNmL2F0dE5n?=
 =?utf-8?B?dHh1emM3TjJOeUtPKzJJenVhSkZrakQvczFIV2dqTnl3YWNnd1QxMHJFTEpR?=
 =?utf-8?B?NVAxQUdhTG5hT01rQmFCSXVDai9oVk5kdnkrSlZ6a2RXVmtVdFZmanJ0R3VF?=
 =?utf-8?B?WklBb1dZQkZWendNU0RmM05IUVZSbEc1MHBWWEh3SktHTjZUL1NXb0N2MDIx?=
 =?utf-8?B?eUZVcmc2bzNyaGY1OHRGWGEyR1BETXBjV3hveEpqbU1rLzRjN2pQbEdRUHo4?=
 =?utf-8?B?amV2RGlMajJJcGE1eVIvbWF2OFhtS2pEV3g3Zmsva1MydkZRZnZYMVowbWR1?=
 =?utf-8?B?OUZ0WkhpMjBBT3AzNHFZYUJybW5FUVVycDVDa2ZKek5rUG4xN3N3SVRtTFEw?=
 =?utf-8?B?eFo5WU1HbTJRS01sWVdaQjYxbDA0bzAvNUJjUGZzeVRxMXRxTGdocWJZNkNI?=
 =?utf-8?B?TFBtNkZOTE9obFRONGp0QXR6cUdFOG4zbzNRUE9CRzhwZUpSQ2lGM0JCNWE3?=
 =?utf-8?B?RFpBN2xrZU5uRDRvNGdGUUlDZ3QzNjVZQ05BWlVuWkNwcWlPWm1sZXlMRnht?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14B842EA3126C7409AACBD927E2A552C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4038c8c-e441-4a15-f9e4-08dad37822c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 08:43:35.8657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLBQ+JNppNRowvSp1shQ1fYzfeiwS5P538VWZuFKQ0zh+rYJScEaf7AltqbCB8BLJCwYFapOa8jRvfbnaNIv5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5506
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

T24gV2VkLCAyMDIyLTEwLTI2IGF0IDEwOjE4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjYvMTAvMjIgMDY6MTAsIFRyZXZvciBXdSAo5ZCz5paH6ImvKSBo
YSBzY3JpdHRvOg0KPiA+IE9uIFR1ZSwgMjAyMi0xMC0yNSBhdCAxMjoxOCArMDIwMCwgQW5nZWxv
R2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPiB3cm90ZToNCj4gPiA+IElsIDIxLzEwLzIyIDExOjU4
LCBUcmV2b3IgV3UgKOWQs+aWh+iJrykgaGEgc2NyaXR0bzoNCj4gPiA+ID4gT24gRnJpLCAyMDIy
LTEwLTIxIGF0IDEwOjQxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA+ID4g
PiB3cm90ZToNCj4gPiA+ID4gPiBJbCAyMS8xMC8yMiAxMDoyNywgVHJldm9yIFd1IGhhIHNjcml0
dG86DQo+ID4gPiA+ID4gPiBBZGQgbXQ4MTg4IGF1ZGlvIGNnIGNsb2NrIGNvbnRyb2wuIEF1ZGlv
IGNsb2NrIGdhdGVzIGFyZQ0KPiA+ID4gPiA+ID4gcmVnaXN0ZXJlZA0KPiA+ID4gPiA+ID4gdG8g
Q0NGDQo+ID4gPiA+ID4gPiBmb3IgcmVmZXJlbmNlIGNvdW50IGFuZCBjbG9jayBwYXJlbnQgbWFu
YWdlbWVudC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogVHJldm9y
IFd1IDx0cmV2b3Iud3VAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4g
PiAgICAgc291bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtYXVkc3lzLWNsay5jIHwgMjA2
DQo+ID4gPiA+ID4gPiArKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiA+ICAgICBzb3VuZC9z
b2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1hdWRzeXMtY2xrLmggfCAgMTUgKysNCj4gPiA+ID4g
PiA+ICAgICAuLi4vc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtYXVkc3lzLWNsa2lkLmggfCAg
ODMNCj4gPiA+ID4gPiA+ICsrKysrKysNCj4gPiA+ID4gPiA+ICAgICAzIGZpbGVzIGNoYW5nZWQs
IDMwNCBpbnNlcnRpb25zKCspDQo+ID4gPiA+ID4gPiAgICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHNv
dW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LQ0KPiA+ID4gPiA+ID4gYXVkc3lzLQ0KPiA+
ID4gPiA+ID4gY2xrLmMNCj4gPiA+ID4gPiA+ICAgICBjcmVhdGUgbW9kZSAxMDA2NDQgc291bmQv
c29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtDQo+ID4gPiA+ID4gPiBhdWRzeXMtDQo+ID4gPiA+
ID4gPiBjbGsuaA0KPiA+ID4gPiA+ID4gICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2Mv
bWVkaWF0ZWsvbXQ4MTg4L210ODE4OC0NCj4gPiA+ID4gPiA+IGF1ZHN5cy0NCj4gPiA+ID4gPiA+
IGNsa2lkLmgNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL3NvdW5kL3Nv
Yy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LWF1ZHN5cy1jbGsuYw0KPiA+ID4gPiA+ID4gYi9zb3Vu
ZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1hdWRzeXMtY2xrLmMNCj4gPiA+ID4gPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjFmMjk0
MjMxZDRjMg0KPiA+ID4gPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gPiA+ID4gKysrIGIvc291
bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtYXVkc3lzLWNsay5jDQo+ID4gPiA+ID4gPiBA
QCAtMCwwICsxLDIwNiBAQA0KPiA+ID4gPiA+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wDQo+ID4gPiA+ID4gPiArLyoNCj4gPiA+ID4gPiA+ICsgKiBtdDgxODgtYXVkc3lz
LWNsay5jICAtLSAgTWVkaWFUZWsgODE4OCBhdWRzeXMgY2xvY2sNCj4gPiA+ID4gPiA+IGNvbnRy
b2wNCj4gPiA+ID4gPiA+ICsgKg0KPiA+ID4gPiA+ID4gKyAqIENvcHlyaWdodCAoYykgMjAyMiBN
ZWRpYVRlayBJbmMuDQo+ID4gPiA+ID4gPiArICogQXV0aG9yOiBDaHVuLUNoaWEgQ2hpdSA8Y2h1
bi1jaGlhLmNoaXVAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+ID4gKyAqLw0KPiA+ID4gPiA+ID4g
Kw0KPiA+ID4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiA+ID4gPiA+ICsjaW5j
bHVkZSA8bGludXgvY2xrLXByb3ZpZGVyLmg+DQo+ID4gPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4
L2Nsa2Rldi5oPg0KPiA+ID4gPiA+ID4gKyNpbmNsdWRlICJtdDgxODgtYWZlLWNvbW1vbi5oIg0K
PiA+ID4gPiA+ID4gKyNpbmNsdWRlICJtdDgxODgtYXVkc3lzLWNsay5oIg0KPiA+ID4gPiA+ID4g
KyNpbmNsdWRlICJtdDgxODgtYXVkc3lzLWNsa2lkLmgiDQo+ID4gPiA+ID4gPiArI2luY2x1ZGUg
Im10ODE4OC1yZWcuaCINCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICtzdHJ1Y3QgYWZlX2dh
dGUgew0KPiA+ID4gPiA+ID4gKwlpbnQgaWQ7DQo+ID4gPiA+ID4gPiArCWNvbnN0IGNoYXIgKm5h
bWU7DQo+ID4gPiA+ID4gPiArCWNvbnN0IGNoYXIgKnBhcmVudF9uYW1lOw0KPiA+ID4gPiA+ID4g
KwlpbnQgcmVnOw0KPiA+ID4gPiA+ID4gKwl1OCBiaXQ7DQo+ID4gPiA+ID4gPiArCWNvbnN0IHN0
cnVjdCBjbGtfb3BzICpvcHM7DQo+ID4gPiA+ID4gPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+
ID4gPiA+ID4gPiArCXU4IGNnX2ZsYWdzOw0KPiA+ID4gPiA+ID4gK307DQo+ID4gPiA+ID4gPiAr
DQo+ID4gPiA+ID4gPiArI2RlZmluZSBHQVRFX0FGRV9GTEFHUyhfaWQsIF9uYW1lLCBfcGFyZW50
LCBfcmVnLCBfYml0LA0KPiA+ID4gPiA+ID4gX2ZsYWdzLA0KPiA+ID4gPiA+ID4gX2NnZmxhZ3Mp
IHtcDQo+ID4gPiA+ID4gPiArCQkuaWQgPSBfaWQsCQkJCQkNCj4gPiA+ID4gPiA+IFwNCj4gPiA+
ID4gPiA+ICsJCS5uYW1lID0gX25hbWUsCQkJCQkNCj4gPiA+ID4gPiA+IFwNCj4gPiA+ID4gPiA+
ICsJCS5wYXJlbnRfbmFtZSA9IF9wYXJlbnQsCQkJCQ0KPiA+ID4gPiA+ID4gXA0KPiA+ID4gPiA+
ID4gKwkJLnJlZyA9IF9yZWcsCQkJCQkNCj4gPiA+ID4gPiA+IFwNCj4gPiA+ID4gPiA+ICsJCS5i
aXQgPSBfYml0LAkJCQkJDQo+ID4gPiA+ID4gPiBcDQo+ID4gPiA+ID4gPiArCQkuZmxhZ3MgPSBf
ZmxhZ3MsCQkJCQ0KPiA+ID4gPiA+ID4gXA0KPiA+ID4gPiA+ID4gKwkJLmNnX2ZsYWdzID0gX2Nn
ZmxhZ3MsCQkJCQ0KPiA+ID4gPiA+ID4gXA0KPiA+ID4gPiA+ID4gKwl9DQo+ID4gPiA+ID4gPiAr
DQo+ID4gPiA+ID4gPiArI2RlZmluZSBHQVRFX0FGRShfaWQsIF9uYW1lLCBfcGFyZW50LCBfcmVn
LCBfYml0KQkJDQo+ID4gPiA+ID4gPiBcDQo+ID4gPiA+ID4gPiArCUdBVEVfQUZFX0ZMQUdTKF9p
ZCwgX25hbWUsIF9wYXJlbnQsIF9yZWcsIF9iaXQsCQkNCj4gPiA+ID4gPiA+IFwNCj4gPiA+ID4g
PiA+ICsJCSAgICAgICBDTEtfU0VUX1JBVEVfUEFSRU5UIHwgQ0xLX0lHTk9SRV9VTlVTRUQsDQo+
ID4gPiA+ID4gPiBDTEtfR0FURV9TRVRfVE9fRElTQUJMRSkNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBDYW4geW91IHBsZWFzZSBleHBsYWluIHdoYXQncyB0aGUgcmVhc29uIGZvcg0KPiA+ID4gPiA+
IENMS19JR05PUkVfVU5VU0VEDQo+ID4gPiA+ID4gaGVyZT8NCj4gPiA+ID4gPiBNYXliZSB3ZSBj
YW4gc29sdmUgc29tZSBpc3N1ZSB0aGF0IHlvdSdyZSBmYWNpbmcgaW4gYSBjbGVhbmVyDQo+ID4g
PiA+ID4gd2F5Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+ID4gQW5n
ZWxvDQo+ID4gPiA+IA0KPiA+ID4gPiBIaSBBbmdlbG8sDQo+ID4gPiA+IA0KPiA+ID4gPiBCZWNh
dXNlIGNsa19kaXNhYmxlX3VudXNlZCgpIGNhbGxzIGNsa19jb3JlX2lzX2VuYWJsZWQoKSwNCj4g
PiA+ID4gcmVnaXN0ZXINCj4gPiA+ID4gYWNjZXNzIGhhcHBlbnMgaW4gaXNfZW5hYmxlZCgpIG9w
cy4NCj4gPiA+ID4gQXQgdGhlIG1vbWVudCwgdGhlIHBvd2VyIGZvciByZWdpc3RlciBhY2Nlc3Mg
aXMgbm90IGVuYWJsZWQsIHNvDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiByZWdpc3RlciByZWFkIHJl
c3VsdHMgaW4gQ1BVIGhhbmcuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGF0J3Mgd2h5IEkgYWRkZWQg
Q0xLX0lHTk9SRV9VTlVTRUQgaGVyZSwgYnV0IGl0IGNhbid0IHJlc29sdmUNCj4gPiA+ID4gYWxs
DQo+ID4gPiA+IGlzc3Vlcy4gQWN0dWFsbHksIHdlIG1ldCBzYW1lIHByb2JsZW0gd2hlbiAiY2F0
DQo+ID4gPiA+IC9zeXMva2VybmVsL2RlYnVnL2Nsay9jbGtfc3VtbWFyeSIgaXMgdXNlZC4gV2Ug
YXJlIHN0aWxsDQo+ID4gPiA+IHN1ZmZlcmluZw0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gcHJvYmxl
bS4NCj4gPiA+ID4gDQo+ID4gPiA+IEknbSBub3Qgc3VyZSBpZiBJIGNhbiBpbXBsZW1lbnQgY2xr
IG9wcyBieSBteXNlbGYsIGFuZCBleGNsdWRlDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiByZWdpc3Ry
YXRpb24gb2YgaXNfZW5hYmxlZCgpIG9wcy4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IElzIHRo
ZSBwb3dlciBmb3IgcmVnaXN0ZXIgYWNjZXNzIGVuYWJsZWQgd2l0aCBhIHBvd2VyIGRvbWFpbj8N
Cj4gPiA+IA0KPiA+ID4gQ2hlY2sgZHJpdmVycy9jbGsvY2xrLmMsIGdyZXAgZm9yIGNvcmUtPnJw
bV9lbmFibGVkLg0KPiA+ID4gDQo+ID4gPiBJZiB5b3UgZW5hYmxlIHJ1bnRpbWUgUE0gYmVmb3Jl
IHJlZ2lzdGVyaW5nIHRoZSBjbG9ja3MsIGFuZCB5b3UNCj4gPiA+IHJlZ2lzdGVyIHRoZW0NCj4g
PiA+IHdpdGggdGhlIHJpZ2h0IHN0cnVjdCBkZXZpY2UsIHRoZSBjbG9jayBBUEkgd2lsbCBlbmFi
bGUgcG93ZXIgZm9yDQo+ID4gPiB5b3UNCj4gPiA+IGJlZm9yZQ0KPiA+ID4gdHJ5aW5nIHRvIHJl
YWQgdGhlIGNsb2NrIGVuYWJsZSBzdGF0dXMuDQo+ID4gPiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4g
PiBBbmdlbG8NCj4gPiA+IA0KPiA+IA0KPiA+IEhpIEFuZ2VsbywNCj4gPiANCj4gPiBJIHRyaWVk
IHRoZSB3YXkgaW4gTVQ4MTk1LCBidXQgaXQgY2F1c2VkIGNpcmN1bGFyIGxvY2sgcHJvYmxlbS4N
Cj4gPiANCj4gPiBCZWNhdXNlIG10Y21vcyBkZXBlbmRzIG9uIHNvbWUgY2xvY2tzLCBjbGtfYnVs
a19wcmVwYXJlX2VuYWJsZSBpcw0KPiA+IGFsc28NCj4gPiB1c2VkIGluIHNjcHN5c19wb3dlcl9v
bigpWzFdLg0KPiA+IElmIHRoZSBjbG9jayBhbHNvIGRlcGVuZHMgb24gdGhlIHBvd2VyIGRvbWFp
biwgdGhpcyByZXN1bHRzIGluIHRoZQ0KPiA+IGNpcmN1bGFyIGxvY2sgcHJvYmxlbS4NCj4gPiBU
aGF0J3Mgd2h5IEkgZG9uJ3QgYmluZCB0aGUgcG93ZXIgZG9tYWluIHdpdGggdGhlc2UgY2xvY2tz
Lg0KPiA+IA0KPiANCj4gVGhpcyBpcyBub3Qgc3VwcG9zZWQgdG8gaGFwcGVuLi4uIGNhbiB5b3Ug
cGxlYXNlIGdpdmUgbWUgYSAoTVQ4MTk1KQ0KPiBwYXRjaCB0bw0KPiByZXByb2R1Y2UgdGhlIGlz
c3VlIHRoYXQgeW91J3JlIHNlZWluZz8NCj4gDQo+IEkgd291bGQgbGlrZSB0byBpbnZlc3RpZ2F0
ZSB0aGF0IHRvIGNoZWNrIGlmIEkgY2FuIGNvbWUgdXAgd2l0aCBhDQo+IGdvb2Qgc29sdXRpb24u
DQo+IA0KPiBUaGFua3MsDQo+IEFuZ2Vsbw0KDQoNCkhpIEFuZ2VsbywNCg0KU29ycnkgZm9yIHJl
cGx5aW5nIGxhdGUuDQpUaGUgb3JpZ2luYWwgaW1wbGVtZW50YXRpb24gYWJvdXQgY2xvY2sgZGVw
ZW5kaW5nIG9uIHBvd2VyIGRvbWFpbiB3YXMgYQ0KY3Vzb3RvbWl6ZWQgcmVxdWVzdCwgYW5kIGl0
J3Mgbm90IGJhc2VkIG9uIHVwc3RyZWFtIGNvZGUgYmFzZS4gU28gSQ0KY2FuJ3QgYXBwbHkgdGhl
IGltcGxlbWVudGF0aW9uIGRpcmVjdGx5LiBJIHRyaWVkIHRvIGltcGxlbWVudCB0aGUNCnN1Z2dl
c3RlZCBzb2x1dGlvbiBpbiB1cHN0cmVhbSBjb2RlLCBidXQgSSBjYW4ndCByZXByb2R1Y2UgdGhl
IHByb2JsZW0NCnN1Y2Nlc3NmdWxseS4gDQoNCkF0IHRoZSBzYW1lIHRpbWUsIHdlIHJldmlld2Vk
IHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gTVQ4MTk1IGFuZCBNVDgxODguDQpJdCdzIGZvdW5kIHRo
YXQgQURTUF9JTkZSQSBzaG91bGQgYmUga2VwdCBPTiB0byByZXNvbHZlIHRoZSByZWdpc3Rlcg0K
ci93IGFjY2VzcyBsaW1pdGF0aW9uIGluIE1UODE4OCwgc28gd2UgY2FuIG1hdGNoIHRoZSBoYXJk
d2FyZSBkZXNpZ24gaW4NCk1UODE5NS4NCg0KQWZ0ZXIgZGlzY3Vzc2luZyBpbnRlcm5hbGx5LCB3
ZSBkZWNpZGVkIGluIGZhdm91ciBvZiBBRFNQX0lORlJBDQpzb2xvdXRpb24uIEFsdGhvdWdodCB0
aGUgbG9jayBwcm9ibGVtIGNhbid0IGJlIHNlZW4sIHRoZSBuZXcgbG9jaw0KcmVsYXRpb25zaGlw
KHByZXBhcmVfbG9jayAtPiBnZW5wZCBsb2NrKSBpcyBhY3R1YWxseSBjcmVhdGVkLiANCg0KSW4g
Y29uY2x1c2lvbiwgQURTUF9JTkZSQSB3aWxsIGJlIGtlcHQgYWx3YXlzIG9uIGFuZCBJIHdpbGwg
cmVtb3ZlDQpDTEtfSUdOT1JFX1VOVVNFRCBmbGFnIGluIFYzLg0KDQpUaGFua3MsDQpUcmV2b3IN
Cg0KPiANCj4gPiBbMV0NCj4gPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xLXJjMi9zb3VyY2UvZHJpdmVycy9zb2MvbWVk
aWF0ZWsvbXRrLXBtLWRvbWFpbnMuY19fOyEhQ1RSTktBOXdNZzBBUmJ3IXlWRkNELUI0VlpPeERY
VEdnRHRwQjBtSmJWb1k5dEhPRGVJQ3h0aEFDMzNsWE1xNkxSVlRHUy00Vi1EajEyOV9jQSQNCj4g
PiAgDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IFRyZXZvcg0KPiA+IA0KPiA+IA0KPiANCj4gDQo+
IA0K
