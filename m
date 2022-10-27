Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C87360F2EF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiJ0I5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiJ0I5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:57:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73299C2FF;
        Thu, 27 Oct 2022 01:56:56 -0700 (PDT)
X-UUID: 29f916af7dac41e0b39409219dc2e4f2-20221027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pVdo2PQ1qwgTbtygTFg6eNCTCqGLmFfSK5P0knFUw0w=;
        b=bCWAwivgU9XKEJg4z/A01t77/QpHxuziCKQQygT5Nr9mDVWxSiVAl4aQSUf1xiRrxWPZi6+JKzBsYNj1ekIX8/0cxvhBvMSPz4TTs3s74LFNORxUP/dMDEZ47XVfVHM4enJ7XscVwsPfUe1LYgYJ1jtIXlQD165ZdDCE07hRUtg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:672adcea-b674-4a81-8e3b-73405835cea7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:78fc4f27-9eb1-469f-b210-e32d06cfa36e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 29f916af7dac41e0b39409219dc2e4f2-20221027
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1820719692; Thu, 27 Oct 2022 16:56:50 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 27 Oct 2022 16:56:49 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 27 Oct 2022 16:56:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhpDC7MhnZyDdSD7cB5MKZBdehCn3vjjUjVENsNv5+cr+HjY0dMpiNeVjScTtTT1uSO/TfQ4YTtb6AaUFzgbFnnJzqQWwR5sz9mFZEwZZxV1nLAJ1GODdtRxu0jPTRRbV7Rn6Z4wIQMjzoVI6x+W3n/xE5XX8WBnhdRWixWJ4qpVWpiVja3CEu7/VtBziQGQQDFX9R2YiBX7YKYgp4BOrMhEv+3ToJ9p9pcmuDLziDeARwjQ0AqJDmCavRLqan+uPrqurYWdapP47Ekc/0mtlcGjD/vlPwW/wdR3m6IUNt7P6bHGgFLu/r+hjQf+Nvsb6fAUkZn1+OSEvrbi4Y/kzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVdo2PQ1qwgTbtygTFg6eNCTCqGLmFfSK5P0knFUw0w=;
 b=Ix7pVd6M19N6p8DIheFk+lIkwbrU1bZmil6c4+ov1Q5jRAyMWhydWFNm8aDkacsLkDmh0/FNuHt+gxpGyy9bASitWXe877LK2tBGZmu8EsRzB0LDWyPGhmoQTBrp4AM9uPtqaM+0FocemgjDAAvu/P+MQhoSgVnrpi70hoczU1aQ/8yNO1gZgEZBhiVZLj0yRJMFN9srrFeDPZPJov4C4LRD7K4c78GdpJmlHyZg8BsRqIOefa2ulltUIiqbxADgkCaA6wbwa/WTNPCHsyutvKEHpvrgnZhoDMQ128FKaVlrqM9WS+28rb3uy0MDu+BOghl8CsNGFkZbwrfZbXm9Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVdo2PQ1qwgTbtygTFg6eNCTCqGLmFfSK5P0knFUw0w=;
 b=r6xa1ydHqGvVAs3z2yS/xNDcB/FuzGLjCY17IyFNj6qM+oNDD030WlB0rlTMdobJGalhM2psBgOEwi0CyXFCWZQeyAnmFqh34NAbKI4M7N8GltQtErkVPxRFHBf6A3iNcYgdTKpr6AuBmEoA34ipts65Vvl+6DaauXoZZqOyesc=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by KL1PR0302MB5330.apcprd03.prod.outlook.com (2603:1096:820:35::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.13; Thu, 27 Oct
 2022 08:56:45 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::aafc:9c3e:1c76:c891]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::aafc:9c3e:1c76:c891%7]) with mapi id 15.20.5769.013; Thu, 27 Oct 2022
 08:56:45 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        =?utf-8?B?UnVueWFuZyBDaGVuICjpmYjmtqbmtIsp?= 
        <Runyang.Chen@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [RESEND v3 1/3] dt-bindings: watchdog: Add compatible for
 MediaTek MT8188
Thread-Topic: [RESEND v3 1/3] dt-bindings: watchdog: Add compatible for
 MediaTek MT8188
Thread-Index: AQHY6QT4ocXGA4ckS0yyWspoIxwFm64gzKyAgAEUB4CAABFXgA==
Date:   Thu, 27 Oct 2022 08:56:45 +0000
Message-ID: <5abd63240a7890895a6de26a52fc24086f1c8ddb.camel@mediatek.com>
References: <20221026063327.20037-1-Runyang.Chen@mediatek.com>
         <20221026063327.20037-2-Runyang.Chen@mediatek.com>
         <20221026152645.GA2946818@roeck-us.net>
         <e889728c-13e9-37f8-4d1a-e31332a39498@collabora.com>
In-Reply-To: <e889728c-13e9-37f8-4d1a-e31332a39498@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|KL1PR0302MB5330:EE_
x-ms-office365-filtering-correlation-id: 0e499788-3a0f-46c6-5ff1-08dab7f92d1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6pOcmFxzrJV/gHwqeXaRHwX1IrMJj+5//icTREkKe5CgAD0j8QNYGMtZQQkRex3s6JuT5+5biFYv6aB8qz8sJ4EhYuz9SkDN515+alUXyXFh+LBg3hW92GE37JKsWcxCl7pjDMd6vTqIKuyLbh0Lo/uHm4scfOiXhnkWhpMU5kKO2ctPohOhAM03TEp4lxOzqHPRid9ZuvaRUcAiNevYLU1X1WN8nKwewGu/xXeEESEkUewXRtrdbFPoWslTyoMwR0wcN5gR+jGO7CI7TCZCfbPAR9ZIbgGl4tj6I62TX9k5DO5WOHIaQO0qlhBgTb4/UGV5irrYOMj3jfZiVMIN2r+paT2b3zyIW6HOiOP3v8TtI6anQruSGsLz7/8PP9hctORc+hBPcqikKVRvStO+LTDhqc35Ckp5KDXeYt9VUa21TSHcURamN/Rvc9eSK6WrbD7WpXOGk7l/YkgsJ0oQN9/E7dFg4AMM1d7EkHEaW3Ff+RKK/2WnRRhswt47NCNKOWet+eUl4jbZQaZKYGPypIXHm2wWJXgx15XJ3vUnHzmfqCzb7yXehtN0lWqZ+0yF/xcGAHXg5fbNMJxr25/2vOc9GOzup8CPw3sho6oVPaD8bce84NgGYk4NSVmI2Bss+XjF2RUOrbxnfyBWVMUFF0Kn6aQQcikqHxxII0xawm6ytIyzj186r3d5ouNHjAFZLMYwmZJZeDkUZ4NShr7l75zjWSKsf7iTQXypQIyhULGQnY41MFzQpIi2eqNQ8vKLE8gAJ3IiexMLgHdo7eTCJ+c3BulCFBCU9Q8VD61s1ziGEJku7mSSfotTAktIKH6LPrlSPM7j5tRMDmBns7UK95ZaAFXatm7l10mgjhD4cdrzqSgXCfjo/VRwiqskbm3M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199015)(966005)(64756008)(478600001)(110136005)(4326008)(6486002)(122000001)(66946007)(66446008)(8676002)(66556008)(316002)(66476007)(5660300002)(2906002)(54906003)(7416002)(36756003)(4001150100001)(186003)(86362001)(76116006)(71200400001)(85182001)(38100700002)(8936002)(41300700001)(6506007)(38070700005)(26005)(6512007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGE1NDNtUS8rWEpubHBKOVFONVpLajEyQjA4MzFtQm1LTXd0SUFCejh3L1V3?=
 =?utf-8?B?TXF4U3prYVVUU1lGY3ExSWMzbkgwSlMra0lYUCtDWm5ZVlQvNnVYTTFET1FG?=
 =?utf-8?B?UG1WS0hjdHdRY1ZGK1A1dDN4ZDJnbWszWDkvSm1vT2hnVW5VazVxVTBLbGtV?=
 =?utf-8?B?OUhpWTVtNTVydElPSzNkTzE0RnkxdlppS3dHWHpZTHhTS1piS3ErSFVLZE5I?=
 =?utf-8?B?VTdjWHVuK2g1ZDhLOG5Sd1M0bjk0RVhqVExjSDl1ZFRNQjJZaDRGclVsTXBW?=
 =?utf-8?B?QUJNdi9JWnhaUFF1WWNsdFZrVk1iYjlwSWkzamJIWnA4SThJaUlHSWRRNm9D?=
 =?utf-8?B?c2w2WE9RdFNHMm1NNW8zM2lEYzVpRzBZRXhQc1ZKYmNWK2luTS9RUi9nMHls?=
 =?utf-8?B?bThsUjZXcmJ2Nk9HNTRYMW4xTENqS3ZnM1RiWHU4VGhaY1dIY3piT1l6Zld5?=
 =?utf-8?B?V1VHVFkveEZhSkpiVm9IWVlNNm9namhUS0s2SzgxTHIwS0lRbDk4WmI2UlBJ?=
 =?utf-8?B?YzZZbDhaUnpFNzE1b0RxZTdjWUtHeFpxT3BGdUhvdjdLWTBiS3JWSkNVb2pJ?=
 =?utf-8?B?Y3dWbkM5Zndxb2RiT0RJTjVySm55Ung4QzRhWUhqTy9PODgvRlFMQ3lvMnZM?=
 =?utf-8?B?MkZjcXkxQ29EMlN4dHpjYUhiNVFWNU1NeGRrOFZzemNmQkE3NGxWSDh4KzZz?=
 =?utf-8?B?OEN1Wk1VbCt0K3crajUvTGNJcjMvb1lyeDFtaVV1Yk41ZkU4cEZSV1NySGY2?=
 =?utf-8?B?d0xlOFpUSGhoMHVkVCtNYzZyOFhlTjBIdHhnOWtEZXhXSnV5Z2RGZlJRVjlI?=
 =?utf-8?B?cHVUYkdDb3E1TWo3alMzejBydE9yWmtibGhjZWdPOUV6RkU0TTFJZEFiMVRv?=
 =?utf-8?B?WUhsNkcwV3AxK3JKaHZjS0tzcExQMzlBZGZzektSdlZEYVdPb2Z4cFJGMXdF?=
 =?utf-8?B?S0p0OUtzZEUxVlVZazZWTXNRZUpkVGJ2MTVKVlF2MFMzYmhzMDFYOXg0OWR1?=
 =?utf-8?B?OXU2bzNDa2NOb0ZadHpuVDFzL015SjBXWW1ib1UyL2QvS084WFlqdnNvL2h1?=
 =?utf-8?B?anhTZ0pXNzFYWXdka3ZLWStHbFIwemJ2YnFMKzFraysybld6UUVRT25IOUxZ?=
 =?utf-8?B?bklEZU5qNTRBVXFiKzBrSjZlc0hRekorU0l0UlBPZDQ0Vlh2YmVlUnpXR2xy?=
 =?utf-8?B?UU5xYWVFQkZ4eVpOZUhBVG15VCs5RXFLV2RXVVdnbDNkRTlENFZseTR1RUpV?=
 =?utf-8?B?U0RLaHkrRHZlc21ZWC9vdWh5aVpyVnRUWEplOUo2YWxkRTlObmc4NTQrcGZk?=
 =?utf-8?B?NTZtejZkdStxMEhJb2R1OU16YWJtdmxOYUJwYTFyeGwxcGh4dmV1d2F3Ky9D?=
 =?utf-8?B?L08xY1F3bHhBcnJqdHg3enFlZUN4ZlcyUWt3clVTeC9wbWlhNnJSNVl3Umg3?=
 =?utf-8?B?U1R5ZUpZN1hvMzEvTzMwbkJSMkZncXBhYzhJRnNkU0YyNGZ2cEpBUVZPZkpV?=
 =?utf-8?B?L2tUMTV6Yi9XYjRjdU41UzlyNCtuanQzRVUzaVJ2VGcwblo0cFVPRHJWV09S?=
 =?utf-8?B?WTJYeGY1ZWVoZXNSSURNUzBLWk0zOGtzYnE5VjYzbzc4VmxSZWxzWElhZklv?=
 =?utf-8?B?Y01XTEVUc040Vys1MENJRytENFJ2Z2luT0hhWnp5N0Mza3VGMGE4eDRnN1Y0?=
 =?utf-8?B?cDM2K3hsYXFDd1Z1VU9PS2dObEE3eE1NdS9MWVFyMC95M0F6aWtVNnRrSFJk?=
 =?utf-8?B?a0pNdjA4S1d1Wml3czdRL0srQzJrb09vVGpLb2E5MThXaDE0Rkl1SDUrU2c4?=
 =?utf-8?B?aFBqZTh5YTBTZWRHeVJxcmdieVFDK2VsNWYwUHZMNXpvZ1VYRmRZUWpSV2xm?=
 =?utf-8?B?ekMyVkhCNUw1VktkTXEybEFiczBRak9uRm5ESW83WHlXT2diOFFXZFZHWWFT?=
 =?utf-8?B?c0M1WGlrc3ZOZGd6K09iQW9jR014TEhkZTZKMlBwa0RhTlNzQmZTZngwUmVV?=
 =?utf-8?B?MGxZa1BhVm5XY2JUSFBhaDYyRFVnOHBKUzNxVXZ5ZGRYcjl5SXZwZnJsaTYy?=
 =?utf-8?B?elJFWEo1VmZDRXl0MjNsdFB4c0tyZU9tQ1daRFZuQkI1SVFJVHJhRjFselli?=
 =?utf-8?B?dVJsdzdudlFHREpJSVZVc0g0ZXdBNHYzTXNNOEJ3ZXlLNTk5S0g3Z3J1VXRO?=
 =?utf-8?Q?4tIERAQUq6nzhC2MbAaHZ+s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDB92EE0E4C22D499AC06529093618B5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e499788-3a0f-46c6-5ff1-08dab7f92d1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 08:56:45.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGU+2ucetjf6Eb4ebJdjq2X0IRLey3/18PSrc8Z3ggKqI1VTh39RfYdqvlvOfnQdkPt1rdo2DFs5Bi5PQ5Zdg3e1Q3j9TNUDEVuFvuGjcAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5330
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTI3IGF0IDA5OjU0ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjYvMTAvMjIgMTc6MjYsIEd1ZW50ZXIgUm9lY2sgaGEgc2NyaXR0
bzoNCj4gPiBPbiBXZWQsIE9jdCAyNiwgMjAyMiBhdCAwMjozMzoyNVBNICswODAwLCBSdW55YW5n
IENoZW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBSdW55YW5nIENoZW4gPHJ1bnlhbmcuY2hlbkBtZWRp
YXRlay5jb20+DQo+ID4gPiANCj4gPiA+IEFkZCBkdC1iaW5kaW5nIGRvY3VtZW50YXRpb24gb2Yg
d2F0Y2hkb2cgZm9yIE1lZGlhVGVrIE1UODE4OCBTb2MNCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogUnVueWFuZyBDaGVuIDxydW55YW5nLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gQWNr
ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9y
Zz4NCj4gPiA+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+ID4g
PiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gDQo+ID4gVGhp
cyBjb25mbGljdHMgd2l0aCB0aGUgb25nb2luZyB5YW1sIGNvbnZlcnNpb24gb2YgdGhpcyBmaWxl
DQo+ID4gd2hpY2ggaXMgc3RpbGwgbm90IGFjY2VwdGVkLg0KPiA+IA0KPiA+IA0KaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9s
aW51eC13YXRjaGRvZy9wYXRjaC8yMDIyMTAwNTExMzUxNy43MDYyOC00LWFuZ2Vsb2dpb2FjY2hp
bm8uZGVscmVnbm9AY29sbGFib3JhLmNvbS9fXzshIUNUUk5LQTl3TWcwQVJidyF6VDM5T2VoRDRn
bnlES1BZd01iTGRleUdJX29OT2Z2V2E0SElyY29vTDNBeDhPNy1OLUJqWEJaQW9sc0NPdUxiMzlm
SjdRJA0KPiA+ICANCj4gPiANCj4gPiBOZXZlcnRoZWxlc3MsIEknbGwgYXBwbHkgdGhpcyBzZXJp
ZXMgdG8gbXkgd2F0Y2hkb2ctbmV4dCBicmFuY2gNCj4gPiBhbmQgYXNzdW1lIHRoYXQgaXQgd2ls
bCBiZSBpbmNsdWRlZCBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZQ0KPiA+IHlhbWwgY29udmVy
c2lvbiBwYXRjaC4NCj4gPiANCj4gPiBGb3IgbXkgYW5kIFdpbSdzIHJlZmVyZW5jZToNCj4gPiAN
Cj4gPiBSZXZpZXdlZC1ieTogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0KPiA+
IA0KPiA+IFRoYW5rcywNCj4gPiBHdWVudGVyDQo+ID4gDQo+IA0KPiBBZGRpbmcgQWxsZW4gdG8g
dGhlIENjJ3MgdG8gbWFrZSBoaW0gYXdhcmUgb2YgdGhhdCwgYXMgaGUgdG9vayBvdmVyDQo+IHRo
ZQ0KPiBtdGstd2R0IHlhbWwgY29udmVyc2lvbi4NCg0KSGkgR3VlbnRlciwNCg0KSSBjYW4gc2Vu
ZCB0aGUgZm9sbG93aW5nIHZlcnNpb24gb2YgeWFtbCBjb252ZXJzaW9uWzFdIGZvciBjb25mbGlj
dHMgDQphZnRlciB5b3UgYXBwbHkgdGhpcyBzZXJpZXMuIFRoYW5rcy4NCg0KWzFdDQoNCmh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIy
MTAwNzA5MzQzNy4xMjIyOC02LWFsbGVuLWtoLmNoZW5nQG1lZGlhdGVrLmNvbS8NCg0KQlJzLA0K
QWxsZW4NCg==
