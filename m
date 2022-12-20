Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF10D6520F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiLTMuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiLTMuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:50:05 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D843331;
        Tue, 20 Dec 2022 04:50:00 -0800 (PST)
X-UUID: 1efa20c282a44411ac5f506fa68d7a73-20221220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=yqMIhgOfn21CL5RngDrgkDBdnZyIfmhEyf3Gf0MoJYs=;
        b=kC6/8Uh5LhsRg2jIcfQTWw/soGysArgcOesBCntl9ATjhYN9Yi9ZpZvQULSdQyGgnTDozybIFQlfcD/X8gRv1q2jJMxNmMIwj/GIM8h/qqyq+yGN4RLx7sU9HJ/IIZP9WszGwHhyGmtQOJ33IR77yxgSJ8kzxmUPIBTp+pIuTDg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:78fbd70e-918a-4591-902b-861f259bf62b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:31f9e589-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1efa20c282a44411ac5f506fa68d7a73-20221220
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1481979840; Tue, 20 Dec 2022 20:49:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 20 Dec 2022 20:49:52 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 20 Dec 2022 20:49:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAifKr0OTxTdCJmS50WJ/He47i4LL1+4LqYwCIy6G7uDCKnInz4PvPR+SKd0eSFOli6/2zrb92Mwk9MEJ/Tn2TYml29NUxm4wL5g6EPZEglCKV3GYTM2n2wZ6Ao9sDnvN7gWasWXFB/yFctQb/r+JZD45DTxPSRM0pywDNTgMzW9ZmncCiSujxAAIsADaqY43/cxXnQIATyL+oSXulZ8AaDwq3MXmzil8k4qlk/88ZVytJcDpklWZhfpPEcFBHnXIVIv+lsXV3B8Jxmmt2/fPLeRt2ZDAsXSEEOF/9OpWKmq88kHs8v1uN6+WI9yQ1hhuqoxhxSgthkwEYAtrLKGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqMIhgOfn21CL5RngDrgkDBdnZyIfmhEyf3Gf0MoJYs=;
 b=Q78voWZX5P/WsailIq+VUWRzNQufUq6hH+7t5TN8K8j9q4GJGmhkvbUbNKB4a0agxy3wAw5mgeVk6TK82gy6D/TjHzY0IaMqfp6xOQ8wEAVVe5zhuWvJYI/UAYCnwnXG1/UZZh4qhJe5wuVedJhx/jwsk+AV0O4ICn9NQrV0nIGEVoY3tkoHH6Q8ya66wrpyQERHNpRb5Wz2rhg2ZOEYcHUbaVMYxgn7kDh9OS4d/720BeGM2KaUYSmk0gu94BnJSgRccHPMUD53vTB1qqnIa75I4PRXkQbXnk/ykJqJinF9yeZIIOzCQie3CZb9Uo1psp2Q4qOJgHB9q4nd+Tpn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqMIhgOfn21CL5RngDrgkDBdnZyIfmhEyf3Gf0MoJYs=;
 b=eYO+oFhRt1cThBUUOpDejRx9FoksZ0pWrbsMVzBRPVpvivWyVh1wYNtnprz8hxVZSdjIj8CvLeEUObVNZgBhH0Xm/GQB6NvYF3MlxkR/v3f1ehyyhR98nV3xFVtJ7pQ4w8o3oN9kRIbhg5uO92bO2HEuqXVLwGi+0grUFP7aWxQ=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by TY0PR03MB6426.apcprd03.prod.outlook.com (2603:1096:400:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 12:49:50 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::55ee:fab0:3a02:5aa]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::55ee:fab0:3a02:5aa%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 12:49:50 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ikjn@chromium.org" <ikjn@chromium.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: arm: mediatek: Add missing power-domains
 property
Thread-Topic: [PATCH 3/4] dt-bindings: arm: mediatek: Add missing
 power-domains property
Thread-Index: AQHZEHzqVOE1HEJN/UCrW3u9k6op9K5wWZoAgAZog4A=
Date:   Tue, 20 Dec 2022 12:49:50 +0000
Message-ID: <f4f9c2cdb60e09b1fc3c07a59b3d02a031a27a32.camel@mediatek.com>
References: <20221215120016.26611-1-allen-kh.cheng@mediatek.com>
         <20221215120016.26611-4-allen-kh.cheng@mediatek.com>
         <3bad1a29-6457-8958-64c2-a0002c7959a1@linaro.org>
In-Reply-To: <3bad1a29-6457-8958-64c2-a0002c7959a1@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|TY0PR03MB6426:EE_
x-ms-office365-filtering-correlation-id: 6638a0b0-ac2e-491e-ae96-08dae288aed9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: emHqwkPmqsD9ridptNWssPTGQiI7GeyKNDHRUZPgY0DBG2/HiK/N/AF/+SFEeqPZ7lS8H1P2ehOJ+hz+jECmmnAubtp1gxcdBzPh6jkc3jQ8oajqbTI/SlwEhD2WYM6Cjy3zyQ8yeVIqayajwgZDvbvB5rDSf42NvmUcsQbeJnQlrayblQKlo2zk4aCiYRW7X0DoRb8xnllSMYbljaM1enNFs2y3xiEWsPBoulZSyxbWWaAq5aJCglhm3C0tS0Dpy6gAUSfNVQm32AWR/qK0O8t/F+hAAabsy+swQXUGn3ziCPCynksvKiGXEuOt5TeXRlenAOXbmAiTCV0WnlyqBlpooCpibiL5ihOIKvu4SZbp081Hpg47erHyy+2rgCyPEiNUlB9fZR34pheaUPVEMZdWPPcegGz30CyzZaFBBzfuov3iKCNO+anGv4oNwiCvNt03nEx+x8z/Mch/Y7J01NLA4gVse0f4BTss1V5ZERWYuekhoCYt18GyWfaqSWoP+FCqoZPa0Q6o1z905BxXctyZr/lMPIRtge/UUWvmzXqn1fiANMOA0BhErjA1cfWxNGL9i6DBnX0v9li3K4LVX0vyXnPu1ldm0VPE53mLGE6I7+JKaMKpOfx2FW0zLoMJLXKvO+ZgDubMIrTVMsDiCwg9P3FYPVciFrZ5Yok0puJAQU1qROlPINrYDc4OH6zIlvcgy1B13uTSQac/UMr8WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199015)(478600001)(110136005)(53546011)(26005)(6636002)(6506007)(4326008)(6486002)(186003)(6512007)(66946007)(66446008)(76116006)(66556008)(8676002)(64756008)(316002)(71200400001)(54906003)(66476007)(5660300002)(41300700001)(38100700002)(122000001)(83380400001)(2616005)(2906002)(7416002)(8936002)(4001150100001)(38070700005)(86362001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU8vbkRCQUdiVlJxaGVrV1hVRXNQaXZTTkFFUHdHMDY2bUVyK3h2OE1BUTA3?=
 =?utf-8?B?Q1h4dGdFTENJMWYzMjBTRlRhMDVxcXo1S3BxTXhaS2ZvSHZSVWNFend4S3hW?=
 =?utf-8?B?L0JLM3gyZjRWb1FoQkFYMS9WK1YrMGM4WG5jbnJkWXY2anIra3hJeHFaYjB5?=
 =?utf-8?B?UzRKTU1KdXhBYm8xTjY0OU5EZzBrNkxuaGF2S2NWQ1BWM1ZVZW1CTWlrMVpN?=
 =?utf-8?B?YUVVOExCbDZJQy84bTYrSkVKSUlaMk1Tb3ZvMmVBT0lwSVZ1d2p2Y2pFamha?=
 =?utf-8?B?QmlFd1ZDMW9LYVd4TEtmenVhNm9lZ2EwSEN4Q1dad2s0UGl5emg3TlFORkxF?=
 =?utf-8?B?ZHJMd1BLT1hOU1lTamk1dEVLOElpNzVmZnJPdVkzYTRpSk1PSmlLUkZsdWtx?=
 =?utf-8?B?QytvRUIwc3N0aktKMk1GMUNBaWVZOTQ5Y3JUTWVSM3U1YkNxMXBnY0orK0ov?=
 =?utf-8?B?Y2IvS1h4S1BHZ1VKQTMwVm5uUngvckNmTS9IS0tqOVJwR0dzYXVkdEpteG00?=
 =?utf-8?B?OVlJdWNCZHhaa2tMdnE3R0RhYjU4Wkw0amJYQWVGTG9Gdlo4OFo0czE1NDJs?=
 =?utf-8?B?dUk2NWRydnhvNlJJTXhORk1WVi96V1pmWkdUTjFLVGJOVXdka2xLbVRWNnNi?=
 =?utf-8?B?NjY4VzlrdXp2OUZTUXpZbkhCekxDaW1Bb21qcDVrcmQzRmhLZWgrOUNLZ205?=
 =?utf-8?B?ZHdvTkNudjhoU1hHREtFSytLRDB1aEp2K3ZJKzZWdUI4L2E0SElwKzIrNDYr?=
 =?utf-8?B?ZmFMZTNvRnRCK1dpbHZGMnZWQjNPRUVyT3IvSy91bDdYSGtUSFhYQXMrMkRK?=
 =?utf-8?B?NmpHUlBxSG1UbkhyTDRDVWlhRlorYTJPaUhEVHFXMWROV1k0VlhtK3lqVWhG?=
 =?utf-8?B?dkFxbS90UkxxU0J5OVY1T3pSSGZkRm1peGk4OVBnOEsyUE9TZGx3QkVZLzI1?=
 =?utf-8?B?clN3blhHSThEbjZRU0ZnMzVjQ0U3RStIT0xxd1dWVjNYT2txNEVqRG9Od1g2?=
 =?utf-8?B?RXNDV3k4TW80WGRsb2Y4cDZ5UmpLbVcrcVljYW43c3F6cmV4U0ZCd2EvSEFF?=
 =?utf-8?B?Mmt0R0hLWUpYWEgvTTF4ZzRYVXRIcGlOblU2SEJzeHFBRDhjSkhyVUlxTGxW?=
 =?utf-8?B?dUgrRkowK0dmc05UNGpnSk9PNHNkVCtVeDdyQTZMRFdoZkJldFdWaFlzOHho?=
 =?utf-8?B?b1daRUZPd1F1M1VJK3RTMVFobmhqbGtpL2xrMzJvaytNcWZmRFFNQ2tnZ3dw?=
 =?utf-8?B?d3ZPUDNaNzZ3ZmtPWXhqeUhtR2FHUkxHaGFNR1RWODBBRllnZVpTcjlIeTBm?=
 =?utf-8?B?cXFvTSt0dmV2eEppQ3FVOFFuV0J5U2htVjFRbmxBdWNPZnRVK0tYNjBQN2xG?=
 =?utf-8?B?SXpuS1RKMWNBN2t4YThNL2l3RVBRaHBhYWlqSUJZQmlqOGdUWW5Gb3c4NGRs?=
 =?utf-8?B?V0YrbGVyQm5nNkR4MXNROWc1dlBhUmRWZGxuZVZ5SjZtSHRPaCtJRlZmSlA1?=
 =?utf-8?B?L0NpVFVneWk3K0IrVmM3V0kwYm4vQ2kyR2Y0VVRoVWgzT1RPTzVQeFV0LzlO?=
 =?utf-8?B?ZnphazF6Uzc5c1Njb3pMbzcwVU9tZ0NUdDFZSkRkWFBadFBvYmQ1VmVGbFJ6?=
 =?utf-8?B?TnJTdHhtckYzNG5QaHV1Z2hXVSszRmlUMkVtWGl1VjNWRDBTc2VCOERaV3Qw?=
 =?utf-8?B?L3VTQ2FxbEJVdlY0WUlHSWFmWDI1dHl4LzR3OENQMVd5LzFIQlArSGJXeHJQ?=
 =?utf-8?B?SzlWRUlEUUMvU2tsMHR3cThYRnFaaWNwN0g4SmFOaGJueXNnUXlPcnp6L2c5?=
 =?utf-8?B?VVE4UGswMEZhYUY2MmZ3NlpUWjNFenJ1eHp1aG05dXN4YnkvT3pkVE40SmZm?=
 =?utf-8?B?bXFPS2syL3d1YnVDRGlqRjB5a0RMQm9XZVNUTW1QVFBjWXdWSENtc3B4clln?=
 =?utf-8?B?dzlhalFzTlMwamZ6VEMxZWphd3FoY1ZSUnE1NDV6L2xyQkk5MFlOY2h1d0pw?=
 =?utf-8?B?NWVhU2Z4MkpYbG1lSzZ4K2lkYXJjam5zTGtRKzM1NGx1OTdENGZYdkc3REt1?=
 =?utf-8?B?RzRkK0ZmUExwdFFxUE1GTTdubStTVldGWmx2cWU5Nk93ajdibElQcysxcEty?=
 =?utf-8?B?bkN4OEFFQXZDT21QNWgzV1BjTThETjZES0wyK29UK1pEWWZ4UVRoRndYZ0dx?=
 =?utf-8?Q?QXkudLj9eBygtgvVQoQ/Ppw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15D81301BA99B74F9C52E569E1FB247A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6638a0b0-ac2e-491e-ae96-08dae288aed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 12:49:50.2965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ju3qEj06VjRtbwpErKM05ZLiMHCJqG8tL7/2rtOjkDY3tqevZsvS7+YxueEBwkAhvPW9EFPEEKfhU2mMZTWVzqjiPm97AXUnVjkzEa+t7HE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6426
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZW1pbmRlci4NCg0KT24gRnJpLCAyMDIy
LTEyLTE2IGF0IDExOjU4ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAx
NS8xMi8yMDIyIDEzOjAwLCBBbGxlbi1LSCBDaGVuZyB3cm90ZToNCj4gPiBUaGUgIm1lZGlhdGVr
LG10ODE5Mi1zY3BfYWRzcCIgYmluZGluZyByZXF1aXJlcyBhIHBvd2VyIGRvbWFpbiB0bw0KPiA+
IGJlDQo+ID4gc3BlY2lmaWVkLg0KPiA+IA0KPiA+IEZpeGVzOiA0YTgwMzk5MGFlYjEgKCJkdC1i
aW5kaW5nczogQVJNOiBNZWRpYXRlazogQWRkIG5ldyBkb2N1bWVudA0KPiA+IGJpbmRpbmdzIG9m
IE1UODE5MiBjbG9jayIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxsZW4tS0ggQ2hlbmcgPGFsbGVu
LWtoLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2FybS9tZWRpYXRlay9t
ZWRpYXRlayxtdDgxOTItY2xvY2sueWFtbCAgICAgfCAxNw0KPiA+ICsrKysrKysrKysrKysrKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRl
ay9tZWRpYXRlayxtdDgxOTItDQo+ID4gY2xvY2sueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtdDgxOTItDQo+ID4gY2xv
Y2sueWFtbA0KPiA+IGluZGV4IGI1N2NjMmU2OWVmYi4uY2JlZGVmMTE0MTAzIDEwMDY0NA0KPiA+
IC0tLQ0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRl
ay9tZWRpYXRlayxtdDgxOTItDQo+ID4gY2xvY2sueWFtbA0KPiA+ICsrKw0KPiA+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtdDgxOTIt
DQo+ID4gY2xvY2sueWFtbA0KPiA+IEBAIC00MCw2ICs0MCw5IEBAIHByb3BlcnRpZXM6DQo+ID4g
ICAgcmVnOg0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPiAgDQo+ID4gKyAgcG93ZXItZG9tYWlu
czoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICAgICcjY2xvY2stY2VsbHMnOg0K
PiA+ICAgICAgY29uc3Q6IDENCj4gPiAgDQo+ID4gQEAgLTQ5LDExICs1MiwyNSBAQCByZXF1aXJl
ZDoNCj4gPiAgDQo+ID4gIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICANCj4gPiAr
YWxsT2Y6DQo+IA0KPiBhbGxPZiBnb2VzIGp1c3QgYmVmb3JlIGFkZGl0aW9uYWxQcm9wZXJ0aWVz
Lg0KPiANCg0Kb2ssIEkgd2lsbCBmaXggdGhpcy4NCg0KPiA+ICsgIC0gaWY6DQo+ID4gKyAgICAg
IHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZToNCj4gPiArICAgICAgICAgIGNv
bnRhaW5zOg0KPiA+ICsgICAgICAgICAgICBlbnVtOg0KPiA+ICsgICAgICAgICAgICAgIC0gbWVk
aWF0ZWssbXQ4MTkyLXNjcF9hZHNwDQo+IA0KPiBGb3IgdGhlIGZ1dHVyZTogcGxlYXNlIGRvbid0
IHVzZSB1bmRlcnNjb3JlcyBpbiBjb21wYXRpYmxlcy4NCj4gDQoNCk5vdGVkIQ0KDQpUaGFua3Ms
DQpBbGxlbg0KDQo+ID4gKyAgICB0aGVuOg0KPiA+ICsgICAgICByZXF1aXJlZDoNCj4gPiArICAg
ICAgICAtIHBvd2VyLWRvbWFpbnMNCj4gPiArDQo+ID4gIGV4YW1wbGVzOg0KPiA+ICAgIC0gfA0K
PiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Bvd2VyL210ODE5Mi1wb3dlci5oPg0KPiA+
ICsNCj4gPiAgICAgIHNjcF9hZHNwOiBjbG9jay1jb250cm9sbGVyQDEwNzIwMDAwIHsNCj4gPiAg
ICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1zY3BfYWRzcCI7DQo+ID4gICAg
ICAgICAgcmVnID0gPDB4MTA3MjAwMDAgMHgxMDAwPjsNCj4gPiArICAgICAgICBwb3dlci1kb21h
aW5zID0gPCZzcG0gTVQ4MTkyX1BPV0VSX0RPTUFJTl9BRFNQPjsNCj4gPiAgICAgICAgICAjY2xv
Y2stY2VsbHMgPSA8MT47DQo+ID4gICAgICB9Ow0KPiA+ICANCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gS3J6eXN6dG9mDQo+IA0K
