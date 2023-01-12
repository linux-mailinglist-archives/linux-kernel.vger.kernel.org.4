Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCB3666F01
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbjALKDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbjALKBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:01:23 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8D665B0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:00:53 -0800 (PST)
X-UUID: fc6d7aa8925f11ed945fc101203acc17-20230112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zKNOjTac44XXNHAvz3iKStt50HudZ5vZNA32Lpzvj8o=;
        b=YSe6nqjm0bJDpejDF8EnFedCm+DPoygH/KVGwpv1a+N16vnqFwsLM22dKc7HH/xVsONyeoIlQsBQd20h3rfJsLjU7j2g3r4WvPzxbYITJzVwyHMZhqn+NztAe5V5xphHvoBQSbxqyvUUXx0VkWDjJmL+kcd1TBlCK99lbRIcoJ0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:44b97434-eab2-47cc-893f-f4a8595de652,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.17,REQID:44b97434-eab2-47cc-893f-f4a8595de652,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:543e81c,CLOUDID:46669ff5-ff42-4fb0-b929-626456a83c14,B
        ulkID:230112180048738QOZIE,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0
X-UUID: fc6d7aa8925f11ed945fc101203acc17-20230112
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 734316042; Thu, 12 Jan 2023 18:00:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 12 Jan 2023 18:00:46 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 12 Jan 2023 18:00:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vjzo2OiuN59k9PnT5/WAyL6qZ4nLNnMw26AI2ticr0n0Bs8fk+es9X9gnahfqR/C6wjYkntX3Id2dgkj+wLRm3Z0Nvo6X+kXKwmfy9+PLuX67IGI0BA2EnMJ0hu19FJuRXQ5TsnMcYl2vT4tx9UCl6Zf6+2CqgwrZ0ayiWvEnTdYgzHqBHPGYaOTFuJz8cw1LZXHv2S0cphXahYGpdxT1YkRjfHXVueOTRCqTKSywLE72eSPZPhA+HF2pXhC7DgcOTdWyfW4gsjTX+UWicRFeAWmbDLZLo80A5EB1ZUQfPo33Jd7RRbTFCEfzSJ7+wWeEhnVfhzQ69VhSoiyXwqW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKNOjTac44XXNHAvz3iKStt50HudZ5vZNA32Lpzvj8o=;
 b=X0Rz9meIw0jdOMSmR3pUQcMzEZIMvPvyeSDvec9WayJlXsRsreojnHnYxj0uNdjNNopLgXnNXxweF3pOi/n9j5bzIKyeBN1egsD9qh6S1raBT3MQ24QUMCWnCSHD3z7LQO6EffoWxBcfLlRE4ny1SGHQk7DfC+ZzwHhX55C6DTLvMYc5EBEAyg2S+I3a3NOaw80K16hmRLzkFqS4WFo+bFZ0d0zenn/Xdj1a99DRqR38w+pbGRGWjPj8jb41j1yD9zACFG4x5bgS8hkOitLcCTEb6/phWofR+QnL+zzd1vBiCDf1rRGBn+biAayY7xipfe2uej6Ub51KyEnY2IS12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKNOjTac44XXNHAvz3iKStt50HudZ5vZNA32Lpzvj8o=;
 b=H/CL5DrWtisdYncaGOeu6d6M/R2iUHfZ+Y2jxNFMTTF09+I3h4kW9NeGWsx0JgYR76Og/Ak42FCo9sTauLllX0q4Af/3bHaAhXCo82C92cqmu3Nn7EYalHg0JJ+WdNLMjYHpd2KxHhYUUout5BEzdrBJghjN6Agzna6mA0VDXxs=
Received: from SI2PR03MB5339.apcprd03.prod.outlook.com (2603:1096:4:105::9) by
 SEYPR03MB7166.apcprd03.prod.outlook.com (2603:1096:101:d5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12; Thu, 12 Jan 2023 10:00:43 +0000
Received: from SI2PR03MB5339.apcprd03.prod.outlook.com
 ([fe80::dae4:f894:f81f:7a2b]) by SI2PR03MB5339.apcprd03.prod.outlook.com
 ([fe80::dae4:f894:f81f:7a2b%8]) with mapi id 15.20.6002.012; Thu, 12 Jan 2023
 10:00:43 +0000
From:   =?utf-8?B?WGlubGVpIExlZSAo5p2O5piV56OKKQ==?= 
        <Xinlei.Lee@mediatek.com>
To:     "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2 3/3] drm/panel: boe-tv101wum-nl6: Fine tune the panel
 power sequence
Thread-Topic: [PATCH v2 3/3] drm/panel: boe-tv101wum-nl6: Fine tune the panel
 power sequence
Thread-Index: AQHZJLhRCtqYcj9/wEqbWL7PZCoRga6XYMAAgAMvUIA=
Date:   Thu, 12 Jan 2023 10:00:43 +0000
Message-ID: <12828da82a646796642757c793f30e32dcbb4528.camel@mediatek.com>
References: <1673330093-6771-1-git-send-email-xinlei.lee@mediatek.com>
         <1673330093-6771-4-git-send-email-xinlei.lee@mediatek.com>
         <21efdb3e-3c4d-0bc9-bbde-34ec3e04bfad@collabora.com>
In-Reply-To: <21efdb3e-3c4d-0bc9-bbde-34ec3e04bfad@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5339:EE_|SEYPR03MB7166:EE_
x-ms-office365-filtering-correlation-id: cf933272-c10f-451e-6d1e-08daf483de77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WbWmoVag/CNIm9+pGcNSTS3yEFgdSwtzuM7guHYNfUjJrygHJfSPFdppAbvN4RrWIZoo+sECarnCgRdF5m4v2awmaIHC7xWXkPKmZN0GvF4L4mBuZB3qgLTrQQYWVECPfp0l4leI80mKAq2f8RHEDQeVdGmu5IU02sYnhMSuCz2cEtpej6KTIRiWHr9u7rAA7XL033oNJajc2YYL/ke3Wh3bKBW8BUsdVh/aGjwjaWdiQ8y9pGoT3fLf9WsNGsDpYswcb49sqghWresuKfQczrCVwlRhXvfFrBmG9C4d7x/GI1apwB6dMVBcY2/+O4i4t0X4ncxATWLlRg3a23D/anFoFDS6VkjnTNMUNjyTLUDew5Quk7mrhgtGbw+j9+jSwEZlHSMTU6A84GyvTH1m+Nq3Kx3Tz2SZWtGnQiICQ21TnA0idzucZFQXPhO0weYHn5lmWFIe6lZW+YjNnP5VH3gg3EEq+zYyTz3kOZjGwFgcGpXy2+f83VAI+WbZIrVPMSk9aVGcMvOxrY9Kt+hUGnIvC68dqLOeX63mCCgdUBe3JZdoTJwSTcomHGHlGP10WVCVIVaMKQAgqhInKYE/Q9sHZgs53KWfWYB+lTm038k8gmKCZnS7RPC0AoA39hFBZkPnOwN2JY/Y/tPMirXf9gKh+Ztqpnj3HuuW8z7KPtPC/j8ZzwySJTt7tsH4u0giTj0+YwiUmzovFE31YJeT/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5339.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(54906003)(316002)(26005)(41300700001)(8676002)(7416002)(8936002)(76116006)(5660300002)(66446008)(66556008)(4326008)(64756008)(66476007)(66946007)(110136005)(2616005)(2906002)(71200400001)(122000001)(38070700005)(6512007)(107886003)(6506007)(85182001)(186003)(36756003)(6486002)(38100700002)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OC83NGNnaTlnSmhEQ00yWmhHSGxqdzZzQ3k0a3JKclBuSGdDbzNpTWF4NklB?=
 =?utf-8?B?Z1FUV1pYZGhnNUJzQ2dZaitXNUlGNTBONVJrai9iSVdwY2NaeG8zVGkxZU5s?=
 =?utf-8?B?WFpiZ3BoaWRnWmlQcDB3ZDg0ck1ZOEhzSnBVMm9CUlNXZEJuOXA3L3FFRHRi?=
 =?utf-8?B?cWNkNDB0ZHdDbGJHTE1RMXgrQnBZZHYyWFBhczUwNEJ2YUFVM2R5K3htSFpx?=
 =?utf-8?B?eXNqVlVuL1o1RFIwaUJJRklweW1NWURPa0hVS01PNjFHWE1qcDhGOU9QZkpm?=
 =?utf-8?B?TlNsN0x2dDlCMmtXd3hSWnpBdVh4RVNzRG1jQmlPb2F6TjZLUis0QitoL1lZ?=
 =?utf-8?B?UkVVc2V3WkU2aTVhelduM0FJa0R2L1JwOHVmNmhnelhOR21iblBSanhCVUww?=
 =?utf-8?B?b09DNXV1dEVFYnEwS0NSc29qVnlOV0Y0VTRReXoyRjJLN243ZWl1WW9VQ3V2?=
 =?utf-8?B?bFNzMVRDRExSamUrellWYm9kVGVLdkMyMDNyL05sWXFMT1R0QStndXJMYlVy?=
 =?utf-8?B?bmZoMHplR2YyUDliRk5pa0VrenFQRHhaMVduY1MyMnhreHYyaThwQ1F2M1NC?=
 =?utf-8?B?czdOQi9sb01GVVN6dXdsTmRqTEpLSEJKTzZ3aFl0TVpOS0NoNU03Y2ozRUdq?=
 =?utf-8?B?VnJZSHlQMlpvRXJ6alpmbGhvT01ucVFOazJ3VTdneE9FdkhScXlGWjVXVHJG?=
 =?utf-8?B?VHk3OU5kY1RwUWYweVI4SHJJL0cwemNTejlyY0daQS9lV1VabUxFbmJrS3hM?=
 =?utf-8?B?YUxHbFN4cHdxRG5PamRmR1l5a3Vzblc0SzZ6U1NNb0ZwL3djbGkxdTBiM0x4?=
 =?utf-8?B?Z280OGJUSXdFdmtpVVo5S0Z1Z3JNelBBWDlWRFlBcU1wd3JNaCtsS2d2NWxx?=
 =?utf-8?B?N2dEWDJUbWk0YjV2Q0ZDdEowYW8vbmRZcEJNQjh6RU93ckpiN3F5ZWJKblFs?=
 =?utf-8?B?M2dlRGFTL0M4a3p2bWs5eFMwQ1hKakJTTXpUdzBCNi9DVGlENmZ4M1RZcnEy?=
 =?utf-8?B?N2I4RXR6UzdjNllRZHVpMTRtUnhIQ3BGQkZSTTRwVEcvRU5pYjNXQThOYVVO?=
 =?utf-8?B?eFpiT0YxZmpnTnNTWlM0bStMT0lWSjZ0ZThMWjlrK2RiempFUElleGV6bDY5?=
 =?utf-8?B?eU1Ub3hrQWs3UVF1WTZsV3AzcVpHTzQ5TTBqU0czWmM0aUpVTTBsTHBCakRL?=
 =?utf-8?B?MTRXcVEwOVc2NGhQYVdlb2I2b3BDZHNrUzdtc2ErVU5uUzBGckJNYk5teDFo?=
 =?utf-8?B?cWJldy9WcHRrcWRWeDNtbjRyYjk4bW9JNGFyQjE5UDBLVWN5R3Z1UzFlR2F1?=
 =?utf-8?B?YjZrYlJINE9DcFFwdDhLeWEzOTZBWXBtY0xaNU02OEFNVmJoOHl5SE1NTnpl?=
 =?utf-8?B?YkxaOW9ZbmthMk9mV3I1RXRmenR4eHRiY2l0S09JUWJJbmw0SGJYd01meWxu?=
 =?utf-8?B?UlduREVUV3JrK2VMQzZ3aGlNUXhyV01VOUZ3OHJ2MVpmejI0eXQ4NHJqWE5D?=
 =?utf-8?B?R2dQL0h2NnNGOEFTT0FFajZnRk9HMC9YYVJweWplWXE4ZHg4dTd4QkhMd2E5?=
 =?utf-8?B?ZjNpUnBUWk9sTXJ0bGFwUmpnSCtOckdUTWNJeDRVbmJmMXBoMEMwYlZ1QktE?=
 =?utf-8?B?RXhrQXdOLzc5bHRVZXBsQjFnVi9VQ3Q2eVlaUGdqY21mT29yNmd5VDFEYmtP?=
 =?utf-8?B?eUFPbHNWdTYvSzRlWnJKSWMrdjVIRDRMMncra1Fod01oWXBuYzJTa0lBVVVV?=
 =?utf-8?B?ZEZoNnpEMEVKdEpBWHA3SEdhMElWcUJXaXUwM0tBeURPRGozK2Y5NnFJWEps?=
 =?utf-8?B?YzJESEpYTVNjMGZQUGp4akJzeTM5eHF6Tjc0cllqeEczMlkxL1FDWlkzR0tv?=
 =?utf-8?B?eG9pUjhhMEhQMVd2RjRrdGpMZ0lTdnBidkE5NGZtYUdpcGxnbG8zVEZZUGRx?=
 =?utf-8?B?dXk4YlBwYVZlNXZraEpmcUR5VTRjSkFYVG05WHFLNUVrSlgwbHJMTXVpbkFu?=
 =?utf-8?B?K3FETmh2U0RYNHJTam9DTUlLdm9Sb3paTC95dlVPNEEzeUx4RHJYTldZNXRL?=
 =?utf-8?B?YUtYM2hER25wc3NqaVN2VGlZK3lIc002YkJPY3Zaa3N2b28vWVI0VmkxY1hS?=
 =?utf-8?B?Y1ROUmxSTUNTT3VxTWt1Z05WczROWHlPaHVZamNiQ3gvbTJHSlFjclBtL3RR?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD4DF3ED6D6BE3418C70FD6D84D822D7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5339.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf933272-c10f-451e-6d1e-08daf483de77
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 10:00:43.6295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwINudwUALcFwD+H0wzCL3CssbMmxtE/3Ky2PPw5txPo/iedrCtKBE6GykV7RkfE9K8yIx36AcnAUZ+NOT+AkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTEwIGF0IDEwOjIyICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTAvMDEvMjMgMDY6NTQsIHhpbmxlaS5sZWVAbWVkaWF0ZWsuY29t
IGhhIHNjcml0dG86DQo+ID4gRnJvbTogWGlubGVpIExlZSA8eGlubGVpLmxlZUBtZWRpYXRlay5j
b20+DQo+ID4gDQo+ID4gRm9yICJib2UsdHYxMDV3dW0tbncwIiB0aGlzIHNwZWNpYWwgcGFuZWws
IGl0IGlzIHN0aXB1bGF0ZWQgaW4gdGhlDQo+ID4gcGFuZWwgc3BlYyB0aGF0IE1JUEkgbmVlZHMg
dG8ga2VlcCB0aGUgTFAxMSBzdGF0ZSBiZWZvcmUgdGhlDQo+ID4gbGNtX3Jlc2V0IHBpbiBpcyBw
dWxsZWQgaGlnaC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBYaW5sZWkgTGVlIDx4aW5sZWku
bGVlQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9wYW5lbC9w
YW5lbC1ib2UtdHYxMDF3dW0tbmw2LmMgfCA2ICsrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
cGFuZWwvcGFuZWwtYm9lLXR2MTAxd3VtLW5sNi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vcGFu
ZWwvcGFuZWwtYm9lLXR2MTAxd3VtLW5sNi5jDQo+ID4gaW5kZXggZjAwOTMwMzVmMWZmLi42N2Rm
NjFkZTY0YWUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLWJv
ZS10djEwMXd1bS1ubDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1i
b2UtdHYxMDF3dW0tbmw2LmMNCj4gPiBAQCAtMzYsNiArMzYsNyBAQCBzdHJ1Y3QgcGFuZWxfZGVz
YyB7DQo+ID4gICAJY29uc3Qgc3RydWN0IHBhbmVsX2luaXRfY21kICppbml0X2NtZHM7DQo+ID4g
ICAJdW5zaWduZWQgaW50IGxhbmVzOw0KPiA+ICAgCWJvb2wgZGlzY2hhcmdlX29uX2Rpc2FibGU7
DQo+ID4gKwlib29sIGxwMTFfYmVmb3JlX3Jlc2V0Ow0KPiA+ICAgfTsNCj4gPiAgIA0KPiA+ICAg
c3RydWN0IGJvZV9wYW5lbCB7DQo+ID4gQEAgLTEyNjEsNiArMTI2MiwxMCBAQCBzdGF0aWMgaW50
IGJvZV9wYW5lbF9wcmVwYXJlKHN0cnVjdA0KPiA+IGRybV9wYW5lbCAqcGFuZWwpDQo+ID4gICAN
Cj4gPiAgIAl1c2xlZXBfcmFuZ2UoMTAwMDAsIDExMDAwKTsNCj4gPiAgIA0KPiA+ICsJaWYgKGJv
ZS0+ZGVzYy0+bHAxMV9iZWZvcmVfcmVzZXQpIHsNCj4gPiArCQltaXBpX2RzaV9kY3Nfbm9wKGJv
ZS0+ZHNpKTsNCj4gDQo+IE5PUCB3aWxsIG5ldmVyIHJlYWNoIHRoZSBkcml2ZXJpYyBpZiBpdCBp
cyBpbiByZXNldCwgd2hpY2ggc2hvdWxkDQo+IGFwcGFyZW50bHkgYmUNCj4gdGhlIHN0YXRlIG9m
IGl0IGF0IHRoYXQgcG9pbnQgaW4gY29kZS4NCj4gDQo+IEkgZ3Vlc3MgdGhhdCB5b3Ugd2FudGVk
IHRvIGRvIHRoYXQgYWZ0ZXIgTENNIHJlc2V0IGFuZCBiZWZvcmUgc2VuZGluZw0KPiBpbml0IGNt
ZHMuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQoNCkhpIEFuZ2VsbzoNCg0KVG8gZXhw
bGFpbiB0byB5b3UgdGhhdCBpbiBteSBwYXRjaCwgc2VuZGluZyBhIE5PUCBiZWZvcmUgbGNtX3Jl
c2V0IGlzIA0Kd2hhdCB0aGlzIHBhcnRpY3VsYXIgcGFuZWwgZHJpdmVyIG5lZWRzLg0KDQpJbmRl
ZWQsIHRoZSBOT1Agd2lsbCBub3QgcmVhY2ggdGhlIHBhbmVsIGRyaXZlcmljIGJlZm9yZSBsY21f
cmVzZXQsDQpidXQgdGhlIGRyaXZlcmljIHNwZWNpZmljYXRpb24gc3RpcHVsYXRlcyB0aGF0IHRo
ZSBNSVBJIHNpZ25hbCBuZWVkcw0KdG8gYmUgcHVsbGVkIGhpZ2ggYmVmb3JlIGxjbV9yZXNldCBp
cyBwdWxsZWQgaGlnaChOT1AgDQotPiBtdGtfZHNpX2hvc3RfdHJhbnNmZXIgLT4gbXRrX2RzaV9s
YW5lX3JlYWR5KSAuIEluIG9yZGVyIHRvIGF2b2lkIA0Kc3BlY2lhbCBkcml2ZXIgaW5pdGlhbGl6
YXRpb24gZXhjZXB0aW9ucywgdGhpcyBjb250cm9sIHdhcyBhZGRlZC4NCg0KQmVzdCBSZWdhcmRz
IQ0KeGlubGVpDQo=
