Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F9A63B837
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiK2Cub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiK2Cu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:50:29 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BC548766;
        Mon, 28 Nov 2022 18:50:24 -0800 (PST)
X-UUID: 32cb9de38c4f4de89fdbe2e3653c2a04-20221129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=C9CDXHL0X72PQOGlZ07wcv0QDFriiipL+m18OdVMpYI=;
        b=fYkjNPKf+WiLQsN6b+FRrqQ2+S3eagjGp1M5zVdyEJ5O8fBosalgSoaPQry63uBvWC0KeLOA2glmo/sGzXaldw0KyhTmbFYq8SqXYmBzTOzpAAg8TrzUp3lED+vp1YFXABftO0PLLr6jAiLxplD3uFCH30t7DgPyodq3GBfs9C8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:3ccc3721-3746-40ea-a9db-b62deef6a16c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:bdbe1530-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 32cb9de38c4f4de89fdbe2e3653c2a04-20221129
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1341317236; Tue, 29 Nov 2022 10:50:21 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 29 Nov 2022 10:50:20 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 29 Nov 2022 10:50:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXCHs7MwmP/KZIIf43hc21HNxA/vSIccpBc8CMD2L07bwLTHiugwGTruXGjIxJNdYeCm9U4x+X4AOT0s2Is1PmCwPa45Mjgh48Gy3V5Zml2/THTwI0/eEiNeVLOZuPl3J7T8nXwSeSCFbZlf8B8LGZssQ3qsIcqtB3GmOkaeGNIPl3iqtf3RPuwnRGJcM25K7IRDUyi2CFcEydX/K8Ohkqe0ZIIm/TekRo8PGA3Mi42K4kjTMhwYRjtHhaoMMDu1hzZLbRHTIK5RpW3JuRmz8mtX+ygM03MCMkuUQzc/KqSvOZK+NFtzPaHW7ux91Rty5TxJ+/rz8jtRmQKBH9fq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9CDXHL0X72PQOGlZ07wcv0QDFriiipL+m18OdVMpYI=;
 b=GW1mAHkTYdWbwYP7xvkPuBIJqNeym7vNJZPLwgmFStyfXgXdh3NFxXCnndTk08kHM4raQQD21dzieqIuFJCiMRVhkfrnOni0BCeSpEg/Hm33W2TKNqQu9Rc+OQDDRayN9uInfA7TQUwQTI90f7ibigTHQ2ad6z28/KwjvbpYc0A9a5mlUJzSPE0r9kqeTIMNcObHHXcc/3mC9ne9i6aEqJj8dDcn+llYGfPeOe9TYAtHegH5CfyFRNCGYq30gQtNv2c8ZIyKUTGLyIzD8kIQ04fOYdzlBW/4XtI8h6tHr87GGi/MwV1urv+xOnwbOrnzL92M6k/jUwD0UU7cQdMQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9CDXHL0X72PQOGlZ07wcv0QDFriiipL+m18OdVMpYI=;
 b=m+xOfecxHvT3i+1IKTqk1FOvRLRJjHjuZi76CBF9Aape3R8BhVvMl2r0u8XNJ13oTxDrtzNkJhFbEe/Rhxt+7O3aWs8F45CuvZIBTIS5oDYxVMJBDCz6GELpgrCZYvo27oMT0CDiG6iBvkk9wtW51hLp8BCughsHP6yLHV628PM=
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com (2603:1096:4:84::10) by
 TYZPR03MB6917.apcprd03.prod.outlook.com (2603:1096:400:28a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 02:50:16 +0000
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::6f36:b7bc:7906:b179]) by SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::6f36:b7bc:7906:b179%6]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 02:50:16 +0000
From:   =?utf-8?B?WGlhbmdzaGVuZyBIb3UgKOS+r+elpeiDnCk=?= 
        <Xiangsheng.Hou@mediatek.com>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?= 
        <Benliang.Zhao@mediatek.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>
Subject: Re: [PATCH 8/9] dt-bindings: mtd: Split ECC engine with rawnand
 controller
Thread-Topic: [PATCH 8/9] dt-bindings: mtd: Split ECC engine with rawnand
 controller
Thread-Index: AQHZAs5lbo94HNi6n0KZExdn9VwqFa5UDc4AgAEnMoA=
Date:   Tue, 29 Nov 2022 02:50:16 +0000
Message-ID: <cba02d8972da75f89d9f0c0e03765cee58b42f57.camel@mediatek.com>
References: <20221128020613.14821-1-xiangsheng.hou@mediatek.com>
         <20221128020613.14821-9-xiangsheng.hou@mediatek.com>
         <69d35231-0ac0-297c-d669-5566a926aac3@linaro.org>
In-Reply-To: <69d35231-0ac0-297c-d669-5566a926aac3@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB4565:EE_|TYZPR03MB6917:EE_
x-ms-office365-filtering-correlation-id: 44595c6f-d6c8-453a-98d4-08dad1b47215
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hFvSaiJd6ePNeGdzQWSDFfkoPeWsomtAn9DYZBGXtGWu9uiJA2gO77/wnHGDLgbANZg6/2xGJKtJeCZzWMk7MrHFWBNT9h3WgpTQpoYrIyRFmy/8N8O1NVPlgRuzbKAyhJrecATyrOzk6ETM7bTl4tS0mJdHUcRChJBFX4jUb0YpxIYI9oDKikiBz7kp7+aa5ylJGeHSFC/hGDeSAWd8ggurwZXo2ZuUDQ6byKIc2AkoDgwhgWh4XswIwvTc7aQ3XjpeVLjZONB0ZWQrcW+fRZ76nkZexa2iKWb+59wSJsneNoES/AHrFqNm0yAAmAiAHxpDqdO8L9CG4crl5JIVh6VfodaVO3LggDYAuNSKoFSgxGhhnnP3T5zO+e9Q3YwSKvIFPOjbF4O+1ieFyFZ5ZZbq34D7QWhv1twvoww8TJAo4OSSDNNfEHRsUK39AHmDi0f9chBNu/CkbXYilOoacxQvsCc/t1rQYUrrhkE1L/qYH4f8MiMY0XRSy1OE2T+V/dCYGNRKQjPY/x1uMSgXPDJYkine/m/l8YYtEs8iQLitlFzlnyywsMyICvylqugKkapE6SMjIMeG9Bzgjs5u5qHfKoKrbwdNLITjhVjiXP7If6FSZYRN0hEg+PQ9eEJFZzquinNr/RB6gXBkgoR3rXVmliDe0p3geAdxXsKztXRrwYrwkRIFjtR7yQmNaHSKeHQ8tBGCs/KF6//fJnSswUU+3k+xgGGaeBlpEnQIzOkQctz5pfYHz/w6vUvsY18
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB4565.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199015)(36756003)(83380400001)(85182001)(8676002)(4326008)(316002)(66476007)(66446008)(64756008)(186003)(66946007)(66556008)(76116006)(2616005)(110136005)(86362001)(54906003)(8936002)(5660300002)(38070700005)(7416002)(4001150100001)(122000001)(2906002)(41300700001)(38100700002)(107886003)(6486002)(71200400001)(478600001)(53546011)(6512007)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFN6K1pJUnIzR0tnc2xnQ1V3MWUxMGVIdlEvV3g5VVFLSDUwZXZGa09NcnNM?=
 =?utf-8?B?d3pCUnF2dGN1blh6YmNNWmUwMmJ1bkwwdUNTRzNqb2pOeWYvbHZ4Ui9LYWZR?=
 =?utf-8?B?WWplRFJ5c29hNzYwYWdTWGx4bnJPQmlGWGd1RUpnd1E2TUsyaTBkK1dnL1h0?=
 =?utf-8?B?VjdObjJnM1p0dWMyZzNsUEpvRlV5eExWSUlhYlB1dHR3U2VpMUpoUHFGK1VC?=
 =?utf-8?B?QXN1Unk0SFpPYjR4c1VvTmJOc01ZZkVyYjExUm8vM1R6WTZqQ3pUSWJTUjFx?=
 =?utf-8?B?MHR1bmNoclptVWNldW9kM1haVG4reWZPZHVSLzBCVDZQczIreHU5N3pzMUJs?=
 =?utf-8?B?TDNYS3l1L0t6YXlnMk93eUpLYmFxQnFadHp1UC94UGw0emhCakpDdmxpUW56?=
 =?utf-8?B?MUJaeTROQVJqdTRnYUlDUktnRVJCbC9tc1JoTUsyb09ycUNSVG40UDJMSUdZ?=
 =?utf-8?B?ZTZQUHhPdGVYcFZmbnJOenZJVlp5R1E4VnBaWU5HWWhvQ3RGSGszc2VMYTdo?=
 =?utf-8?B?OEN3bVM0cGl0VkRxSjRzdVVqVVg5eHJHdGhFM0lpMWh0RGdYQmRsRnF3RHVj?=
 =?utf-8?B?ZjN2VkRRRzE4MXJORDM3bTAxcE1zNEtYR1kxV1dKblg2UmNTaERsdXV5NmJP?=
 =?utf-8?B?UGlmeU5yTUdlOUZOdU0rK1I5d094ZU9lZVcrbXBKNWtsU2VvTWdsQXIrQ2g1?=
 =?utf-8?B?ZmdHbTZuU1dCaXVaZlBmMCtnOEtZcU5uTzdobDB5cWwyQjZNKytVT2hSZmZp?=
 =?utf-8?B?VGF4aTRybU91ajE4ZmJLd2RoUnllZSt0WkJUVmFyNzhWL1Z5YjE0WW5YQ3Zz?=
 =?utf-8?B?QUtjV0dRK0RqYm5YUmdZSEJpRDF1WVpOY010Y3JvYjhVZXpUZEFaMnFRbzJ2?=
 =?utf-8?B?Z0dlOE5GdVIxbXlDZGRZb1g5VG5jbTEycVJ6aWgyMUJXRU1PaFNFMEdRS215?=
 =?utf-8?B?a0VqS0hvL0hkRmVPUlM5ak1mT0ZibGx0alpCenk0UTJhNWpkVXBlMkU5T243?=
 =?utf-8?B?WWNiTzl6QmhwWWlaNVNVbUNtRFhsWTRPZUJYSEFDbzlyOFpEMHhENkR1TW9Y?=
 =?utf-8?B?VXdEdFBQUHNWU3JXU0pLQ0tFR3pVVElSd3hwa0cvWUYwKzhYU0NCcHlwUkZM?=
 =?utf-8?B?OXRrajNzb2VqS3R1ak15eUJ2cVEvNzlKWEtiOGY1ZGtRaENaOE9BR0FZaXEw?=
 =?utf-8?B?aUtBVWYycVplT3hXdXdHL1ZSWVI4K01ZbEF6MkY5cEphQzhBMGNUQWRISHZ5?=
 =?utf-8?B?eW5HZXhubzVsSFFDcGNQRGtaK29RT3VQb1VrMnhyZkt2cmtjNHczeDJiNU1k?=
 =?utf-8?B?QzlDODhmdlA0NWpNdDl6K29HTS9Hc2R0aktoNmh0QllpaWhyQWtSMjY4a0xN?=
 =?utf-8?B?WnF6RGttMkd2RWtodDRGSEwxS1ZNSFZ5NWplTTB6b29iYkdtdGdFT1ArbXN3?=
 =?utf-8?B?K202K3FGM3V6RFNWM1BnQjdBL0sza0RXS2VoaElmS1JYb3k1TXhaa1JSbFV2?=
 =?utf-8?B?M0Jja292amRkMTc3OVEyZ0tZbUx0aWtmdGF5Tzc2U0lrSFlGUnBEbkFNUHN6?=
 =?utf-8?B?NDBBU2g2MXFEN1FWUlBteWtGOGlHcU9FeXEyUnlJWU1mRWNvZkNYV1M5eU4v?=
 =?utf-8?B?S3JIOHpLSFE0OHRTbXg0ZFBPTlU3aXlzY3ZDRmNRY0JScmR0WXJpb1Z2ZS9a?=
 =?utf-8?B?c2hKcFJYVUtKa0NLdVM4SHlMUjRGcEJsSHJkWTlmM0xIaTdTS1FPbFA3OHlz?=
 =?utf-8?B?bnRJaGVJL05tRGErVGFMUEhuSzgzWDJ1SnNPWkRFRTRBRm5lR0k3NTdWeWdq?=
 =?utf-8?B?WHpIM3lqTHIwR2JYTFdxa3JRdThYM3UzS0xRMXhqQkpTZ3NrdVhDYWFmd3Rm?=
 =?utf-8?B?UnU2QjlMdklPYmg4Qyt4NWl6NTh4emFtcXA4eXRNcGFIN3JZME9ya1RwSFk2?=
 =?utf-8?B?QnlsajczNVZZa3pvS0VuQ2FlMFhxZ0t2eDR0YkFSL2ZvTUZJaktUWlRqNEFC?=
 =?utf-8?B?emxLUUdhamFHMlJqYVV3Tlp6UUNYSy85MGEzaGYvNmp2R1Q0K1RnYWkyaEhG?=
 =?utf-8?B?VUN1dzNKZzRpNURzaHFYdzNTa3FzSjFkRzZlMEN4aElxRHNGZ0tsbGl5ZkhX?=
 =?utf-8?B?OFBNV0tSNjNjb0FFV1BxSXRJbEpUaS9mYTlNdGpZS21WaUgrYlBaSGNWRTFk?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC9C71091DCB0843851F83A1BFE73C8D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB4565.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44595c6f-d6c8-453a-98d4-08dad1b47215
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 02:50:16.4214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rFdINXRErs1qzql3TbMQwX71Bnxe8jBAl/gq87mXis7tW0PDl22fghXD/eu7vxzSN3aGEYtQvLt5DHjwGsWbgS+cTaEawFkiCU5Bzt0/bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBNb24sIDIwMjItMTEtMjggYXQgMTA6MTMgKzAxMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDI4LzExLzIwMjIgMDM6MDYsIFhpYW5nc2hlbmcg
SG91IHdyb3RlOg0KPiA+IFNwbGl0IE1lZGlhVGVrIEVDQyBlbmdpbmUgd2l0aCByYXduYW5kIGNv
bnRyb2xsZXIgYW5kIGNvbnZlcnQgdG8NCj4gPiBZQU1MIHNjaGVtYS4NCj4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9tdGss
bmFuZC1lY2MtDQo+ID4gZW5naW5lLnlhbWwNCj4gDQo+IFdyb25nIHZlbmRvciBwcmVmaXguIElz
bid0IGl0IG1lZGlhdGVrPw0KWWVzLCB3aWxsIGJlIGZpeGVkLg0KDQo+ID4gKw0KPiA+ICsgIHJl
ZzoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBCYXNlIHBoeXNp
Y2FsIGFkZHJlc3MgYW5kIHNpemUgb2YgRUNDLg0KPiA+ICsNCj4gPiArICBpbnRlcnJ1cHRzOg0K
PiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IEVDQyBpbnRlcnJ1cHQN
Cj4gPiArDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gDQo+IERyb3Ag
bWluSXRlbXMuDQo+IA0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246
IGNsb2NrIHVzZWQgZm9yIHRoZSBjb250cm9sbGVyDQo+IA0KPiBEcm9wIGl0ZW1zL2Rlc2NyaXB0
aW9uIC0gaXQgaXMgb2J2aW91cywgaXNuJ3QgaXQ/IFJhdGhlciBtYXhJdGVtczogMSwNCj4gVW5s
ZXNzIGNvbnRyb2xsZXIgaXMgbm90IG9idmlvdXMgaW4gdGhpcyBjb250ZXh0IC0gYWJvdXQgd2hp
Y2gNCj4gY29udHJvbGxlciB5b3UgdGFsayBhYm91dD8NCldpbGwgYmUgZHJvcHBlZCBhbmQgZml4
IG90aGVyIGNvbW1lbnQgaW4gbmV4dCBzZXJpZXMuDQoNCj4gPiArDQo+ID4gKw0KPiA+ICsgIG5h
bmQtZWNjLWVuZ2luZToNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBSZXF1aXJlZCBFQ0MgRW5naW5l
IG5vZGUNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3Bo
YW5kbGUNCj4gDQo+IFRoaXMgZG9lcyBub3QgbG9vayByaWdodC4gVGhpcyBpcyBhIHByb3BlcnR5
IG9mIE5BTkQgY2hpcCBhbmQNCj4gb3JpZ2luYWwNCj4gYmluZGluZyB3YXMgc2F5aW5nIHRoaXMg
YXMgd2VsbC4uLiBvciB3YXMgaXQgY2FsbGVkIGVjYy1lbmdpbmUgaW4NCj4gb3JpZ2luYWwgYmlu
ZGluZ3M/IEJ1dCB5b3VyIGNvbW1pdCBtc2cgZGlkIG5vdCBleHBsYWluIGFueQ0KPiBkaWZmZXJl
bmNlcw0KPiBmcm9tIHB1cmUgY29udmVyc2lvbi4NClRoZSBNZWRpYVRlayBOQU5EIGNvbnRyb2xs
ZXIgZHJpdmVyIGhhdmUgY2hhbmdlIGVjYy1lbmdpbmUgdG8gbmFuZC1lY2MtDQplbmdpbmUgcHJv
cGVydHkuIFdpbGwgZHJvcHBlZCBhbmQgZXhwbGFpbiB0aGUgZGlmZmVyZW5jZSBpbiBjb21taXQg
bXNnLg0KDQpCZXN0IHJlZ2FyZHMsDQpYaWFuZ3NoZW5nIEhvdQ0K
