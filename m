Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D3560DA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 06:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiJZEKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 00:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiJZEKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 00:10:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B5B3EA43;
        Tue, 25 Oct 2022 21:10:41 -0700 (PDT)
X-UUID: 4a5b24cbf68f49bba4c3e015c2883f13-20221026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=D4X15pKIlmx8doi6OcOKibrU72ZMfYrQ95AxyIUOK5Q=;
        b=MIWUuD0glmxqlJ/F/DfLWfaNoXO4gHdQ2UtMEGwwsQQEVzSULBbKJ95XbqD/NQRulZWnGwpzxOEl+ppM9rZLWaabkOQAcwZRwGzH9e0mnA01fs4xCCGVKz9bCVH4yX7irgGbImvtQ6XUkoZcFJJyq+3K76noIK926LxNH/bIi2A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:19cccdf0-df6a-46e4-ba00-3d4bd5347dc5,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTI
        ON:release,TS:48
X-CID-INFO: VERSION:1.1.12,REQID:19cccdf0-df6a-46e4-ba00-3d4bd5347dc5,IP:0,URL
        :25,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION
        :release,TS:48
X-CID-META: VersionHash:62cd327,CLOUDID:c2db1d6d-89d3-4bfa-baad-dc632a24bca3,B
        ulkID:221025181853H1ZJPF6F,BulkQuantity:8,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: 4a5b24cbf68f49bba4c3e015c2883f13-20221026
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 19480512; Wed, 26 Oct 2022 12:10:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 26 Oct 2022 12:10:34 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 26 Oct 2022 12:10:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9v7E1pMlEbkH3manK1L/JnFKAmfWRnVQp3N2mX61Kkj1qJv5edZPuS7eH66YfrnhPkKeD877CQh10tka8YZVx4HsgT6MJQh0GHPnIj5XYF2uWaA9erMyz2FOCCIBtGszMtvzgX26omfVCZ0awNoHWycRjCWsAr3easKKRM6DUkhi9WV1M6ITMR3JrqHlIZZfF21DF0XGr6PZgM+S8/PQzbmqlQD6uXzi+rD4ROnYv9KZzPDOMmPGhBIwEecpWi6NSNAa3htwh741+NOAUe9U554pTAvtyTvdzKmnY4deswmKcpTE7QyT5iIUvQoKbO1RjEex2AjzEYOwBE4ReWuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4X15pKIlmx8doi6OcOKibrU72ZMfYrQ95AxyIUOK5Q=;
 b=ThwtW0oV831p3uyGCAdbxUv9T+pOs1lrQcWTO6fWY0mPcC9Q6rzk9U9OrpmWayy9ilBqQqBVsWOAwwOyQ/zztieo3CNrOZTTSB286tTtemfs8qdcekiN0VzfyxXzFPOF9zlMZsnHIA5aZp95GJujHo3Wb4PkTeM9a43RgiBduL3HFcgff1tNK/esIyODFYljbmSwyfTbdU93WbzgaFSHhhJHxhz1ovrLZcZ5Oat47LB9cJ6wWcYAVyrpoG3gcj4gQf/fy8Hj6cwLVWmS+fiicdaCntg+CY3tj3kXK6qpXvKcyQV320PpWXNLxNgPRYBVaNQtFW5MvAf57/TNFgC9mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4X15pKIlmx8doi6OcOKibrU72ZMfYrQ95AxyIUOK5Q=;
 b=uCKKA73JUTcZOulwpDHSsLdWZfSnMtBf5yAw8xVb+gCk+3P5OXHp3mN1HfXp/zKCmJJ2fwPx5FiIqCJgn8pgLBiaI1RwBFRl0FpuMSsSfo3KKvIAMQlHhBnVBMkFKSR0aCrTcz8mqTK13rLG7SvMZR4W0h2rplw1x5BxiuVRBBI=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by PUZPR03MB6101.apcprd03.prod.outlook.com (2603:1096:301:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 04:10:31 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::6c50:1e0c:f9dd:d45]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::6c50:1e0c:f9dd:d45%5]) with mapi id 15.20.5746.017; Wed, 26 Oct 2022
 04:10:31 +0000
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
Thread-Index: AQHY5Scb0+y44k7XlUu5apSFkxk6/64Yh3oAgAAVdQCABk8UgIABK3KA
Date:   Wed, 26 Oct 2022 04:10:30 +0000
Message-ID: <500f80b1ac84101af482bdfcb46671d523d51068.camel@mediatek.com>
References: <20221021082719.18325-1-trevor.wu@mediatek.com>
         <20221021082719.18325-4-trevor.wu@mediatek.com>
         <de66f0e3-7694-7315-c896-9211259a1a17@collabora.com>
         <776557c0fda5a538549ee0d4f4b7f482b0d69934.camel@mediatek.com>
         <473d67ed-198f-82c6-9f32-5827c1f8c852@collabora.com>
In-Reply-To: <473d67ed-198f-82c6-9f32-5827c1f8c852@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|PUZPR03MB6101:EE_
x-ms-office365-filtering-correlation-id: b4c202b6-5fe6-4ff5-b44c-08dab70805b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XG247UwmlUrYe8yjPCK4axDwkNxNnr4pgEJdKRkDGRgJfZGVfmYkK+dKwgJwKFyUGLIQrRGxbFYTuJFz6h/oSDkS3WJN6CF4P1LpNwjRERtg+QLaEYo0at6SOxhXOhkZF2Vq8GZlroYNmo4X/5Cd049g+qhmShN929ZQxrgMGe89O3srM3Fek4dSV4gbCRfzVLTg9bfwC66kgzQOn8snMoMpyo/OBg9LLNZtMDMJ9Pd1TfMVvXCvJ/MQib8K7uVD9Jq59RbAN8soBa2VbridpPiOY242WCBL5r2qqqEMN9ZDc8+jfiUgZMa1Ypx91LD5I7lyjkQOBxGrCvh1rpbfBTOIAWdInmUDISyRZnres5KAQCi1j/SYZ0dpwdiCx9xBp7sQQxJ2dDqeU18RNjUwDt6VjV9nyTKZEgJNogKX3M+TFmvtO0axNrJu2H3Dp79olQpuz1xi58P1jZvTfGR5FSRI6i1VwiOpgMcVOVWPlvZgKQiyv1a6ljLHP95SXgryMQqZVs1SsKkbFNPxWu2O0xcIaDQir4m/bN5geiC+el59X24oGxEUdgB/DPN9eM/41Yq8sCMaAoIft3bau7GNAC7HrhOeSJmXRD4vfISaS1B/oewfoysPkBHEpnKKRGg93SuqckYM4lTcUxNGdENwarPpvnQ+QChrUGFN0bkQ1FApCjKsezkkkZ3AYm9TCP2nMH4L1MmRzYTsBAqETb4BPy6R3J0QkcHfxZMOT7xi8CiSPIbI4m7ctipAkJtsbKXd+73blNSNdQPysrAH70u/S3ETI8xj6iTN3VQy5Vhq2eQSN1z72l+u0OaLBHAA8Raw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(186003)(8936002)(38070700005)(71200400001)(2906002)(86362001)(5660300002)(2616005)(7416002)(478600001)(26005)(6512007)(41300700001)(4001150100001)(83380400001)(122000001)(110136005)(966005)(38100700002)(316002)(6486002)(91956017)(36756003)(85182001)(76116006)(66556008)(54906003)(4326008)(66476007)(8676002)(64756008)(66946007)(66446008)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEVPZ0EyU2tRVHA0ZUlHUmI3Y2lQWGo3TWcrOEFHT3gzQWIvVVltblcxemNK?=
 =?utf-8?B?NjhBWWlsTGJya0pNTWlTUFhvaWFaZ2hTZlB6NjNiTXBpWE4yU0h5cDB4dEJG?=
 =?utf-8?B?UEI4UDJuVldUclZ3MkFqbVpyYlMrczFTUURJY3NmYXN4MTNXUXBPM254NFc5?=
 =?utf-8?B?NWZya1lmMDZSZHlvUW9qZElyaHNkejZUQkZheDlTeEI3M1h0RE5ZOFlnWXdH?=
 =?utf-8?B?OEtKaFdjQUhWVzRCREcweHNSd0xOUkhDb1dhOEFhb1gzVUYxR3lwdkxldCtm?=
 =?utf-8?B?R0pqOFFBS0hBalhGVUhOUFRLM1NJQUNhVFdESHpKdUd4ODVhajlvUnUrUzdp?=
 =?utf-8?B?STBlQnVKcVVXVythRFk4dEpXWEtxcjlTNnlRTnJjVHMxdVprbmZuNXVWZ3Jl?=
 =?utf-8?B?S2l1M2FwenJHbkw4TjBscmprNkN1UDg2RVhjVlBCbVlXb2kxMHZFaytUcXNQ?=
 =?utf-8?B?UVBCUnVva29rZDdVQXc0Y3ljWGtIeThraGFubVFMZ1dMNHJGZmEzY0hyVFBY?=
 =?utf-8?B?QXBUbFlBTmlsMnB2Unk5UGxyQTBOaGc5bGdGVTJjOEFHaGJhWkJ5VW94Vi9h?=
 =?utf-8?B?VXlaNWxtV1BYZW1sQ2x5dk1FcERncklvYlNrSGVlVHBJbFhEcDcvK2E3UnBY?=
 =?utf-8?B?NTBzYkU1Z2RYQy8rSzhPVVh1d0xzVUVyU2hzRTkxRTV4bG4wZjdMNFVWNGRk?=
 =?utf-8?B?YlQ0M0ozVHBjOGRYbXRJZmJvUFRNNkVSaUFtYm13cVc0Y0FPT25ZZXdkMVUy?=
 =?utf-8?B?RFU0VnJUckZJbkRNVGZhRUI5ZXB2UTBoODFCdCsvaFhNMW5OV0lkaUErUkc5?=
 =?utf-8?B?SFpCTVM3VVJkSkpBMGFGTkxGSktaNDJnQjVzajFVOGRONnA4RDdLeFR0OU82?=
 =?utf-8?B?cDd4R3pvU1ZSMmtTTDVuc0R0Sm5Id0krVVBSci9SdmtHbGNMUkxud2xyMnZT?=
 =?utf-8?B?N0hmVVBGdDEybHJ2ajBIckoxazJYMGhqUi8yWm12c08yNHdYaGlONjhpVTRM?=
 =?utf-8?B?eUhtbUltZUxkaXJJZTFrdDRHanU0RklPRC9MeWpGQ2JUV0l0T1Nkd3N6YUpk?=
 =?utf-8?B?bS9BRjhrZWpLRnpVSmdQMlJIZ3ptRzFPamx4M05kUk1nRjArekVzOGV6dHk4?=
 =?utf-8?B?c0R5VnBzeVJaTjh1YWh3a3ZxR1ViaitVRzdyMnNuSVd5WThyV3AzeTdGVmJn?=
 =?utf-8?B?a0RuR0g1K1RxRjBIVkJ6cWZ3WGJmTHFMOUdmbHVzMW1YeUU5TEdBZFBOSG9P?=
 =?utf-8?B?UVVpVWxiWmh3UXJuTUFMYTE1U1JSVElLOUhHUlBTWFlqTnVzOXlzZEJYSExs?=
 =?utf-8?B?K0k3RDNRaFNkaStDSFdsaG0wMnNMcUNKMlFoQ2J6YXViaG9OK2xKaTVTTjgv?=
 =?utf-8?B?SUZEdDR1UENEVXQ5Y05NZ1paUi9ncmQrekdPUnpKN1hranQyUXVmRkVHaUhN?=
 =?utf-8?B?eUtLYUQ1MFNwVEd4eTFld3R5cndCRzBiZStPczlsVjRTRzlvN2QrM09zeDhn?=
 =?utf-8?B?UnlxQ1NwMklobUZzWE9jeHVGMjVrUSsvTlEyZTJ5d0JCZ3VrT21naE9OcS8x?=
 =?utf-8?B?c1V3ZEQvZDFHeVBnN2NjRndGNnNzVWdZUDY1U2pnNkxUeEt3SXcyMTdHbmw5?=
 =?utf-8?B?S0FmVWR3dWpvUTFEWWZqWVVrbk5mK2UvREVXOUNrQzJ5ekJnSlU5U3VHM3J2?=
 =?utf-8?B?eGN4c0RKRmo0UUtrd3hNWG81eFNaeUZqZ2I0cjY0TThVZ2w2cUJBZmFibVRN?=
 =?utf-8?B?MjJSRkQ2Zmp4R3lpUWlMeFc4WWpTYXQ3RzJkcjhYU3Z3Qzl5U0VZTTVIRVFt?=
 =?utf-8?B?cDV3cHArcXdncUhjdExKT1YwT2o1RHRkSUNENjUySE5YSnpRMjlac1RUUzJ3?=
 =?utf-8?B?Z0FtMmhCSlI3dVdkaUFUcVpSbWhGSGNyeU42aXJmcmgxZk13SlZyOWo4Syta?=
 =?utf-8?B?Qnd4eGFtK3AvN3JPeGUrd2VMcTA1Q0hwNW5idWhYU0VtNDlwektxVlprM1J2?=
 =?utf-8?B?RDI5MHpUQ2hsblpkR1N2aTE2ZVRpdVRCRE4xOHk3c3MxV2QvaHJ3NVJFaU5N?=
 =?utf-8?B?ay93Vi9KNWxXTEFhUU83SlJXOFY5cjVhWHVBU1FCL2s2ZTlsak15VGRTK2Y1?=
 =?utf-8?B?MEFJSTRtQzJabGVnb1VWQlR3Y1Z2UXFrNVdnYmpZUUpxQkdzN0ZZN3Vjeklh?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A785D3E755F06E4B80A85E9CFCD182F7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c202b6-5fe6-4ff5-b44c-08dab70805b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 04:10:30.9268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HssZgYhdMWA8JiMURNLGJXjHCcOgkw+tWFOfPC7K5z6hvDchp6nfuEjVD1uxgA0voSAFhs1vmeM6WzfiL+rDhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6101
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTI1IGF0IDEyOjE4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjEvMTAvMjIgMTE6NTgsIFRyZXZvciBXdSAo5ZCz5paH6ImvKSBo
YSBzY3JpdHRvOg0KPiA+IE9uIEZyaSwgMjAyMi0xMC0yMSBhdCAxMDo0MSArMDIwMCwgQW5nZWxv
R2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPiB3cm90ZToNCj4gPiA+IElsIDIxLzEwLzIyIDEwOjI3
LCBUcmV2b3IgV3UgaGEgc2NyaXR0bzoNCj4gPiA+ID4gQWRkIG10ODE4OCBhdWRpbyBjZyBjbG9j
ayBjb250cm9sLiBBdWRpbyBjbG9jayBnYXRlcyBhcmUNCj4gPiA+ID4gcmVnaXN0ZXJlZA0KPiA+
ID4gPiB0byBDQ0YNCj4gPiA+ID4gZm9yIHJlZmVyZW5jZSBjb3VudCBhbmQgY2xvY2sgcGFyZW50
IG1hbmFnZW1lbnQuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUcmV2b3IgV3Ug
PHRyZXZvci53dUBtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgICBzb3VuZC9z
b2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1hdWRzeXMtY2xrLmMgfCAyMDYNCj4gPiA+ID4gKysr
KysrKysrKysrKysrKysrDQo+ID4gPiA+ICAgIHNvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4
MTg4LWF1ZHN5cy1jbGsuaCB8ICAxNSArKw0KPiA+ID4gPiAgICAuLi4vc29jL21lZGlhdGVrL210
ODE4OC9tdDgxODgtYXVkc3lzLWNsa2lkLmggfCAgODMgKysrKysrKw0KPiA+ID4gPiAgICAzIGZp
bGVzIGNoYW5nZWQsIDMwNCBpbnNlcnRpb25zKCspDQo+ID4gPiA+ICAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1hdWRzeXMtDQo+ID4gPiA+IGNs
ay5jDQo+ID4gPiA+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4
MTg4L210ODE4OC1hdWRzeXMtDQo+ID4gPiA+IGNsay5oDQo+ID4gPiA+ICAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1hdWRzeXMtDQo+ID4gPiA+
IGNsa2lkLmgNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbWVkaWF0
ZWsvbXQ4MTg4L210ODE4OC1hdWRzeXMtY2xrLmMNCj4gPiA+ID4gYi9zb3VuZC9zb2MvbWVkaWF0
ZWsvbXQ4MTg4L210ODE4OC1hdWRzeXMtY2xrLmMNCj4gPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4xZjI5NDIzMWQ0YzINCj4gPiA+ID4gLS0t
IC9kZXYvbnVsbA0KPiA+ID4gPiArKysgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4
OC1hdWRzeXMtY2xrLmMNCj4gPiA+ID4gQEAgLTAsMCArMSwyMDYgQEANCj4gPiA+ID4gKy8vIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gPiA+ICsvKg0KPiA+ID4gPiArICog
bXQ4MTg4LWF1ZHN5cy1jbGsuYyAgLS0gIE1lZGlhVGVrIDgxODggYXVkc3lzIGNsb2NrIGNvbnRy
b2wNCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjIgTWVkaWFUZWsg
SW5jLg0KPiA+ID4gPiArICogQXV0aG9yOiBDaHVuLUNoaWEgQ2hpdSA8Y2h1bi1jaGlhLmNoaXVA
bWVkaWF0ZWsuY29tPg0KPiA+ID4gPiArICovDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyNpbmNsdWRl
IDxsaW51eC9jbGsuaD4NCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIuaD4N
Cj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9jbGtkZXYuaD4NCj4gPiA+ID4gKyNpbmNsdWRlICJt
dDgxODgtYWZlLWNvbW1vbi5oIg0KPiA+ID4gPiArI2luY2x1ZGUgIm10ODE4OC1hdWRzeXMtY2xr
LmgiDQo+ID4gPiA+ICsjaW5jbHVkZSAibXQ4MTg4LWF1ZHN5cy1jbGtpZC5oIg0KPiA+ID4gPiAr
I2luY2x1ZGUgIm10ODE4OC1yZWcuaCINCj4gPiA+ID4gKw0KPiA+ID4gPiArc3RydWN0IGFmZV9n
YXRlIHsNCj4gPiA+ID4gKwlpbnQgaWQ7DQo+ID4gPiA+ICsJY29uc3QgY2hhciAqbmFtZTsNCj4g
PiA+ID4gKwljb25zdCBjaGFyICpwYXJlbnRfbmFtZTsNCj4gPiA+ID4gKwlpbnQgcmVnOw0KPiA+
ID4gPiArCXU4IGJpdDsNCj4gPiA+ID4gKwljb25zdCBzdHJ1Y3QgY2xrX29wcyAqb3BzOw0KPiA+
ID4gPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gPiA+ICsJdTggY2dfZmxhZ3M7DQo+ID4g
PiA+ICt9Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsjZGVmaW5lIEdBVEVfQUZFX0ZMQUdTKF9pZCwg
X25hbWUsIF9wYXJlbnQsIF9yZWcsIF9iaXQsDQo+ID4gPiA+IF9mbGFncywNCj4gPiA+ID4gX2Nn
ZmxhZ3MpIHtcDQo+ID4gPiA+ICsJCS5pZCA9IF9pZCwJCQkJCQ0KPiA+ID4gPiBcDQo+ID4gPiA+
ICsJCS5uYW1lID0gX25hbWUsCQkJCQkNCj4gPiA+ID4gXA0KPiA+ID4gPiArCQkucGFyZW50X25h
bWUgPSBfcGFyZW50LAkJCQkNCj4gPiA+ID4gXA0KPiA+ID4gPiArCQkucmVnID0gX3JlZywJCQkJ
CQ0KPiA+ID4gPiBcDQo+ID4gPiA+ICsJCS5iaXQgPSBfYml0LAkJCQkJDQo+ID4gPiA+IFwNCj4g
PiA+ID4gKwkJLmZsYWdzID0gX2ZsYWdzLAkJCQkNCj4gPiA+ID4gXA0KPiA+ID4gPiArCQkuY2df
ZmxhZ3MgPSBfY2dmbGFncywJCQkJDQo+ID4gPiA+IFwNCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKyNkZWZpbmUgR0FURV9BRkUoX2lkLCBfbmFtZSwgX3BhcmVudCwgX3JlZywgX2Jp
dCkJCQ0KPiA+ID4gPiBcDQo+ID4gPiA+ICsJR0FURV9BRkVfRkxBR1MoX2lkLCBfbmFtZSwgX3Bh
cmVudCwgX3JlZywgX2JpdCwJCQ0KPiA+ID4gPiBcDQo+ID4gPiA+ICsJCSAgICAgICBDTEtfU0VU
X1JBVEVfUEFSRU5UIHwgQ0xLX0lHTk9SRV9VTlVTRUQsDQo+ID4gPiA+IENMS19HQVRFX1NFVF9U
T19ESVNBQkxFKQ0KPiA+ID4gDQo+ID4gPiBDYW4geW91IHBsZWFzZSBleHBsYWluIHdoYXQncyB0
aGUgcmVhc29uIGZvciBDTEtfSUdOT1JFX1VOVVNFRA0KPiA+ID4gaGVyZT8NCj4gPiA+IE1heWJl
IHdlIGNhbiBzb2x2ZSBzb21lIGlzc3VlIHRoYXQgeW91J3JlIGZhY2luZyBpbiBhIGNsZWFuZXIN
Cj4gPiA+IHdheS4NCj4gPiA+IA0KPiA+ID4gUmVnYXJkcywNCj4gPiA+IEFuZ2Vsbw0KPiA+IA0K
PiA+IEhpIEFuZ2VsbywNCj4gPiANCj4gPiBCZWNhdXNlIGNsa19kaXNhYmxlX3VudXNlZCgpIGNh
bGxzIGNsa19jb3JlX2lzX2VuYWJsZWQoKSwgcmVnaXN0ZXINCj4gPiBhY2Nlc3MgaGFwcGVucyBp
biBpc19lbmFibGVkKCkgb3BzLg0KPiA+IEF0IHRoZSBtb21lbnQsIHRoZSBwb3dlciBmb3IgcmVn
aXN0ZXIgYWNjZXNzIGlzIG5vdCBlbmFibGVkLCBzbyB0aGUNCj4gPiByZWdpc3RlciByZWFkIHJl
c3VsdHMgaW4gQ1BVIGhhbmcuDQo+ID4gDQo+ID4gVGhhdCdzIHdoeSBJIGFkZGVkIENMS19JR05P
UkVfVU5VU0VEIGhlcmUsIGJ1dCBpdCBjYW4ndCByZXNvbHZlIGFsbA0KPiA+IGlzc3Vlcy4gQWN0
dWFsbHksIHdlIG1ldCBzYW1lIHByb2JsZW0gd2hlbiAiY2F0DQo+ID4gL3N5cy9rZXJuZWwvZGVi
dWcvY2xrL2Nsa19zdW1tYXJ5IiBpcyB1c2VkLiBXZSBhcmUgc3RpbGwgc3VmZmVyaW5nDQo+ID4g
dGhlDQo+ID4gcHJvYmxlbS4NCj4gPiANCj4gPiBJJ20gbm90IHN1cmUgaWYgSSBjYW4gaW1wbGVt
ZW50IGNsayBvcHMgYnkgbXlzZWxmLCBhbmQgZXhjbHVkZSB0aGUNCj4gPiByZWdpc3RyYXRpb24g
b2YgaXNfZW5hYmxlZCgpIG9wcy4NCj4gPiANCj4gDQo+IElzIHRoZSBwb3dlciBmb3IgcmVnaXN0
ZXIgYWNjZXNzIGVuYWJsZWQgd2l0aCBhIHBvd2VyIGRvbWFpbj8NCj4gDQo+IENoZWNrIGRyaXZl
cnMvY2xrL2Nsay5jLCBncmVwIGZvciBjb3JlLT5ycG1fZW5hYmxlZC4NCj4gDQo+IElmIHlvdSBl
bmFibGUgcnVudGltZSBQTSBiZWZvcmUgcmVnaXN0ZXJpbmcgdGhlIGNsb2NrcywgYW5kIHlvdQ0K
PiByZWdpc3RlciB0aGVtDQo+IHdpdGggdGhlIHJpZ2h0IHN0cnVjdCBkZXZpY2UsIHRoZSBjbG9j
ayBBUEkgd2lsbCBlbmFibGUgcG93ZXIgZm9yIHlvdQ0KPiBiZWZvcmUNCj4gdHJ5aW5nIHRvIHJl
YWQgdGhlIGNsb2NrIGVuYWJsZSBzdGF0dXMuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4g
DQoNCkhpIEFuZ2VsbywNCg0KSSB0cmllZCB0aGUgd2F5IGluIE1UODE5NSwgYnV0IGl0IGNhdXNl
ZCBjaXJjdWxhciBsb2NrIHByb2JsZW0uDQoNCkJlY2F1c2UgbXRjbW9zIGRlcGVuZHMgb24gc29t
ZSBjbG9ja3MsIGNsa19idWxrX3ByZXBhcmVfZW5hYmxlIGlzIGFsc28NCnVzZWQgaW4gc2Nwc3lz
X3Bvd2VyX29uKClbMV0uDQpJZiB0aGUgY2xvY2sgYWxzbyBkZXBlbmRzIG9uIHRoZSBwb3dlciBk
b21haW4sIHRoaXMgcmVzdWx0cyBpbiB0aGUNCmNpcmN1bGFyIGxvY2sgcHJvYmxlbS4NClRoYXQn
cyB3aHkgSSBkb24ndCBiaW5kIHRoZSBwb3dlciBkb21haW4gd2l0aCB0aGVzZSBjbG9ja3MuDQoN
ClsxXSANCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjEtcmMyL3NvdXJjZS9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG0tZG9tYWlucy5jDQoNClRoYW5rcywNClRyZXZvcg0K
DQoNCg==
