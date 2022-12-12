Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9636499C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiLLHyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiLLHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:54:04 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71356A458;
        Sun, 11 Dec 2022 23:53:56 -0800 (PST)
X-UUID: efd43f78a5944fb88f519361e6e89526-20221212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HJhEMHGUomZw50QFjB0fWaXnjtYGPQ7teTeCpTfBX8I=;
        b=j8P+EqPm4IM2hA7b97Fdo1at9i1gDhWuzjomYk/4zv4rlkguz9X/RR7MxuOeQH5TPG6rFvV9p/e43++XdQt/zzouB3zxZMRmuvJgkhTOxp0aqKbIR/SXUcG5S+7I6GiDCZnlZz0Ar7bM46bE2Ew1dbhZT3jzaTvB10JHT3/aOOo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:a7dce958-7669-482b-b7ee-7d77b32021cc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:a7dce958-7669-482b-b7ee-7d77b32021cc,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:ddba3d17-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:221212155348X9W8WM5E,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: efd43f78a5944fb88f519361e6e89526-20221212
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <garmin.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1989572475; Mon, 12 Dec 2022 15:53:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 12 Dec 2022 15:53:46 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 12 Dec 2022 15:53:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDZXwlIvg6ik0sD9QCBUGXQYNzuiJYNhI0+q5wCtRxnRG86Z+gUUXlh4tG2HNiXyTK9oeDMQ8KuP5q6cghZ/EM5fBjlQd/MsL38xd5hkTDXvR4GXQlyRbiMdbbXAjdP4qrY2GbLyfLQ+CRqGfKhUJV034mXmkUq5uQcuZ/9guyya+3raA9rEGKl13TT7JvPei6ol0yhMVopwCssvHISVs/kBocmqNEXkJ17MgvU1NPl23tBXmxr23bjFavBzI9XBdVamNtrfWh7mRiQoR4OLYy87MgT/f8ejqjq+XOipnh1UD09dKIY00duLBcwEPBcQEUkp+DMj4kKq5A4m/x+Hvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJhEMHGUomZw50QFjB0fWaXnjtYGPQ7teTeCpTfBX8I=;
 b=Ukl5mJAyCagHqqDzFSm4fufqv7mcjl9z+0yAwCdAypOmC/nWn+pAH5FGLbekRi0B1l4zqd9RoKk5dzxL0zGQxH6Ya06WYRRAWUo25XkodUON/CMcJsc6sKWDKhtAI4qbhLe3ErWWSLFL4cmq/QhWQskjGePyCtvsLrean7h57/+uCRYaVqb3EyjQu4RPDvJ6/xS2rDXz97sRuK5qBNSDnYPBDXLbp2tOFvJKwadXFcai12KzweQqaS+sfCA6m1d3dk+Y/y60pzhZGgeVYm/Hup7jqPuaezokjvXC2dYfS9gQGphSF4ZweGezcrMXA1rs90DSKJ8InciItA3CKZG1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJhEMHGUomZw50QFjB0fWaXnjtYGPQ7teTeCpTfBX8I=;
 b=EctaktgEDNxIZTIBN73NSUs237bVJoT9dbS6eG3NDk99ZlMC2Y53MKrYojCtyV/cEuyfv3Mpbvas8bgA4Xg6H3y4ZFxZCwAHmPIX1H5IQ/NxEL8RLCHaMQdKS5TXKIIXpkkJR+Xe4iwIYvPkjJbtCMLot2++BdMOyC3M4vFDUi4=
Received: from PUZPR03MB5877.apcprd03.prod.outlook.com (2603:1096:301:a5::6)
 by SI2PR03MB5498.apcprd03.prod.outlook.com (2603:1096:4:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 07:53:43 +0000
Received: from PUZPR03MB5877.apcprd03.prod.outlook.com
 ([fe80::6bf6:aaf0:3698:5453]) by PUZPR03MB5877.apcprd03.prod.outlook.com
 ([fe80::6bf6:aaf0:3698:5453%4]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 07:53:43 +0000
From:   =?utf-8?B?R2FybWluIENoYW5nICjlvLXlrrbpipgp?= 
        <Garmin.Chang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 08/19] clk: mediatek: Add MT8188 imgsys clock support
Thread-Topic: [PATCH v2 08/19] clk: mediatek: Add MT8188 imgsys clock support
Thread-Index: AQHY540YX3zhj+mxdUm0B+9h+NoRt64h7EoAgEhCTgA=
Date:   Mon, 12 Dec 2022 07:53:43 +0000
Message-ID: <36f37e88feea9217864f86304cdd1045b793fc23.camel@mediatek.com>
References: <20221024094254.29218-1-Garmin.Chang@mediatek.com>
         <20221024094254.29218-9-Garmin.Chang@mediatek.com>
         <cb050482-cf6e-829e-7fd4-cfcde72c545b@collabora.com>
In-Reply-To: <cb050482-cf6e-829e-7fd4-cfcde72c545b@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5877:EE_|SI2PR03MB5498:EE_
x-ms-office365-filtering-correlation-id: c0ba1a35-23f7-4a4c-f4b3-08dadc15fd79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2c7Vt8zgI+xcr2VedyhcRZvlmRByw8Z+r2vvNEoaci/G0YF/HhacVsxydbI6P+SbS6wldCWU8hjmbXCL1wrBIP0uevy00XFU3YlWCXHJoKw4jOfQDHGuAf8iMQ86NJTu38+GjSMz/bPO5SwkNqSfhnqzq1xHyXDldiglNhsDy5kjZfz9XJVTCJH+8tuPDpvT6tRDrygNDGd324LNPd7xh6Yyg/GxBf7yfFk5HR4q2v1u2xW4m7kN71e4D7PjEqybqYkGZ5abhqLLHKFbTe0DxQ1UhmUoF6YiPomdIxAA7BJzYntMss0ArJ66MlcPDqK8LaXgRCrhMcAvifGQGx2LXreDbAKApeeUwfg/VWs6/ofLQAhx6g4fXkrt3o833tulInG8ICOK7HkRvfgGMv6nYxeo1AcHfRbFMOgGw40IdnWwxm7nN2ZqNlwmPyf1UrND6m830faBBoZJJ/Ssol6qTHETj6Q7s6B9ROZWNJ5kaE15si86MRz6XAmdU/C2R7Rgde5dSJA2NENKvj/bJ6K7qLJxvsqkTS5gu5VfB1l79RaesBqRcNm8Y3oSwyV2mF6n/DJ0VXktMH6ac+zt7RPuFdLxTwTqWCM/4nPV58Qcg/Jt0wp/gRQS4vChs136J/PhynHnM906Rkg1nBe1MlufE3kc1hoaoQvJMwfmYxfcqZATpP5jDZ0ozUz+jZ3n1QGT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199015)(54906003)(86362001)(316002)(41300700001)(8936002)(66476007)(5660300002)(66446008)(36756003)(110136005)(76116006)(64756008)(66946007)(66556008)(91956017)(85182001)(4326008)(7416002)(38100700002)(186003)(2616005)(6486002)(83380400001)(122000001)(6506007)(71200400001)(6512007)(478600001)(38070700005)(26005)(2906002)(8676002)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OURseEIxR0RTbGFRVG1sOUdRSGtrbktoQ1c0bVJBaE9xU1JTMmkrUGVQVmJy?=
 =?utf-8?B?Q3d4VEJ3akFTb2x5ZmYrYXhOdVZGMEJ6V3EyR0tMRytZVGJJanNpS1FpSm9U?=
 =?utf-8?B?M0VxeFNzVytCNkkxKzdVQ05uRU5YUEpjRXpENU1yMi81emwrOTlWOGVvSkw1?=
 =?utf-8?B?cC9xSkFhaFpneEhEWk02aVFHYmg4bk56UXF1UnQ4TUNEUGZBRkhqOEcxejNw?=
 =?utf-8?B?cGp1cmY5WDdhYXc5eTFiUjR6VnBidTM2MnIzaGZUck80RFdydjB1WkhqZDNY?=
 =?utf-8?B?YTRZbE44ZmtNdzc4VEJHSGdKMlRPZGROb0J2Skl0K1UyS1JnY0t5T04vUi83?=
 =?utf-8?B?OTcyYjdtOEFsTGJoUnRNZ2o1KzRabFZHTlhnYmRJUGZLczhUSzFlUnhGSHBq?=
 =?utf-8?B?MUFFV1RZankySGIvdWhWY3poRFFhak1ucWdYQUl4VTFxeTdPTjhRNXpPV0RQ?=
 =?utf-8?B?WUtlWTJCMTZTV01aU1ViendhdE9SZVF6VGRaQnhkQkszMFh3elJiaUc2VTh0?=
 =?utf-8?B?dWc1bDBpN3pyVmZvWmVwOW9IRnluZUp3UHQxVGhUTUMwNVRSekUyTWU5Mk00?=
 =?utf-8?B?d2Q3RitjWjMrZ2c5dFhmcUEyRXlibEY0dGtYOHI1dWtUSHd4UFZmL2ppaHAw?=
 =?utf-8?B?RVVzeGVWNXFoYjMzWC9qN1hkejB6TWZiSWZTbEJyU0c5WHRLYmZmZk1qenN1?=
 =?utf-8?B?K1RGTW1GOUpmU3VSeUxnTVRINm1MNlpLK0lRd2N3TFF0SCs2TXZqVUhicDZ2?=
 =?utf-8?B?M2psaWZHaTROZ2R5K1RYNEVmaDRYQlhLMjJ3RkI4OGpaeEF3SExrbytMSitt?=
 =?utf-8?B?VlhENHVqWExjeSttNDlweTFFdkE3VkI3dHh5MTZOZVVrOXJWZ3RaTWZFNE1z?=
 =?utf-8?B?QzZFdUY4Y2JrTkN5VE1rQUorcGZlTE9yc0ZjUkp2SmVXakJpcitxOWRWUmhE?=
 =?utf-8?B?d1hRYXhnSnJleFJGUWVLTTMvWFZQaXdjSjlYRVhKZy9HN3JxTEcxb0FuZDJV?=
 =?utf-8?B?VW9ERDI5U0tob3dzZ0VPY0JkeExCQkFEQXBRdzRlbFRLSDVKN01FcVE4QlRh?=
 =?utf-8?B?clRReUdTZTBrdW9jdDUwWk4xVmQxMG1GUFBEWFZweXpPTFExUk9QTy91QzR6?=
 =?utf-8?B?TGNleUlzR0RSN3R2SE9mMmY4TXpBZ04rMkZiL0duUTdhVTQvS2N3L1VzZS9U?=
 =?utf-8?B?NEovL2tsc3hrdjlIOVFha3pRVFdXeFF6TmF6Tng1SjNTNG95VGM3NGFQcVJW?=
 =?utf-8?B?VS9VMHFySjh6QmRiQ1VVRU9YNjVSaG5sUzUxVHhRTXRHNlVTN3NRRlJ1Z1hG?=
 =?utf-8?B?UU1LTDB6bUtjR1FtMVZCWjQvWWc1cUhvS2FpM1J2a0s0WUdnYWNFK04yaXFB?=
 =?utf-8?B?UUdjekdWdmJGbmlJb3RaTUg4RHB4VWwralVEaXQzNDYzc0FyQUhCT1dtWE5X?=
 =?utf-8?B?MzljVFFmc09JcWNvRUM1QWlsbERYMDJrSGRDcUtjWTBPVTIzZVh4UktuU0ly?=
 =?utf-8?B?Q0x5L2VSVmR4Mm9JYmtNRitoZ2JwSStlM1JQZWlxb3BDYUhIcFlyMkJYbWox?=
 =?utf-8?B?TXlXRVdVOGlBN1Job1FMTnR6VkZkYSs0dllUcjFCUHN5d3pkRE1hZm1JZ2Jo?=
 =?utf-8?B?VFZXb0lVVmVGK2dmc1BvelNvY2JFZWw0QzhWaGNZZTEwdTNOYm13SFo1TEtP?=
 =?utf-8?B?dDhsdVA5UE12QVlPK1FlcXZodys2ZlpKN280QmpzWDMrOEtoWjJaMGNKVWs5?=
 =?utf-8?B?MG02MURZR1F5SW0wcjhaOElNSnZnSXlEaTVmc3UwU2MyRmtIUFozQWtUNk9u?=
 =?utf-8?B?Mytyb09UOEhxVk5CanRJVUFhaHRrcmM3bTYyU081ZjdRM3dxL29lMEMzTWtl?=
 =?utf-8?B?TmgzT2w5SFJhc0RRazlpT0phbGdHVHpEY1hVUzRnbXJ4cXJGMzlacWZzMUJn?=
 =?utf-8?B?UzJIQzF3ZVo3RDF3ZGVFd0NJT0pkdWJIWWtDUFVWaGN1WUVCa3NwSzhYUCtR?=
 =?utf-8?B?cDJxZUJPSVZwTmNwOTZJdzBDS1NuQ3RCQWxDUzVlNnJBWWptWVA3TVFsZDF4?=
 =?utf-8?B?WVJUbEhxZllyaFJsZjQ4Z2d1M01sMnRueVJXZjhtNWxwVDFzU05IaGMxS2hL?=
 =?utf-8?B?dGZZUk1hMEVvb1hrZ0NOck9jZW4xNkFrNkExN0NESVdJK0hlSTBEQUFWSWJM?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11A4021DD597624EA0827E3C6EA5496E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ba1a35-23f7-4a4c-f4b3-08dadc15fd79
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 07:53:43.0773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmQIRQjd0SIfhkk40kUTwLjOYtzYyCD/ZKqWBhZECPCpmOS7Z58a39pVcd11eUYXyShoIf22zp4FulGW9sgnDcyansjczJANXxkOLgdvqwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5498
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTI3IGF0IDEwOjI1ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjQvMTAvMjIgMTE6NDIsIEdhcm1pbi5DaGFuZyBoYSBzY3JpdHRv
Og0KPiA+IEFkZCBNVDgxODggaW1nc3lzIGNsb2NrIGNvbnRyb2xsZXJzIHdoaWNoIHByb3ZpZGUg
Y2xvY2sgZ2F0ZQ0KPiA+IGNvbnRyb2wgZm9yIGltYWdlIElQIGJsb2Nrcy4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBHYXJtaW4uQ2hhbmcgPEdhcm1pbi5DaGFuZ0BtZWRpYXRlay5jb20+DQo+
ID4gLS0tDQo+ID4gICBkcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZSAgICAgICAgIHwgICAy
ICstDQo+ID4gICBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg4LWltZy5jIHwgMTI0DQo+
ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTI1
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg4LWltZy5jDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQo+ID4gYi9kcml2ZXJzL2Nsay9tZWRp
YXRlay9NYWtlZmlsZQ0KPiA+IGluZGV4IGJkMGEyYWE1YjZmYS4uMjQyYjQ5YmFmYTllIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQo+ID4gKysrIGIvZHJp
dmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPiBAQCAtODQsNyArODQsNyBAQCBvYmotJChD
T05GSUdfQ09NTU9OX0NMS19NVDgxODYpICs9IGNsay1tdDgxODYtDQo+ID4gbWN1Lm8gY2xrLW10
ODE4Ni10b3Bja2dlbi5vIGNsay1tdA0KPiA+ICAgCQkJCSAgIGNsay1tdDgxODYtY2FtLm8gY2xr
LW10ODE4Ni1tZHAubw0KPiA+IGNsay1tdDgxODYtaXBlLm8NCj4gPiAgIG9iai0kKENPTkZJR19D
T01NT05fQ0xLX01UODE4OCkgKz0gY2xrLW10ODE4OC1hcG1peGVkc3lzLm8gY2xrLQ0KPiA+IG10
ODE4OC10b3Bja2dlbi5vIFwNCj4gPiAgIAkJCQkgICBjbGstbXQ4MTg4LXBlcmlfYW8ubyBjbGst
bXQ4MTg4LQ0KPiA+IGluZnJhX2FvLm8gXA0KPiA+IC0JCQkJICAgY2xrLW10ODE4OC1jYW0ubyBj
bGstbXQ4MTg4LWNjdS5vDQo+ID4gKwkJCQkgICBjbGstbXQ4MTg4LWNhbS5vIGNsay1tdDgxODgt
Y2N1Lm8NCj4gPiBjbGstbXQ4MTg4LWltZy5vDQo+ID4gICBvYmotJChDT05GSUdfQ09NTU9OX0NM
S19NVDgxOTIpICs9IGNsay1tdDgxOTIubw0KPiA+ICAgb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtf
TVQ4MTkyX0FVRFNZUykgKz0gY2xrLW10ODE5Mi1hdWQubw0KPiA+ICAgb2JqLSQoQ09ORklHX0NP
TU1PTl9DTEtfTVQ4MTkyX0NBTVNZUykgKz0gY2xrLW10ODE5Mi1jYW0ubw0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg4LWltZy5jDQo+ID4gYi9kcml2ZXJz
L2Nsay9tZWRpYXRlay9jbGstbXQ4MTg4LWltZy5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjAwZjNiYmY0ZDUwMg0KPiA+IC0tLSAvZGV2L251bGwN
Cj4gPiArKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg4LWltZy5jDQo+ID4gQEAg
LTAsMCArMSwxMjQgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b25seQ0KPiA+ICsvLw0KPiA+ICsvLyBDb3B5cmlnaHQgKGMpIDIwMjIgTWVkaWFUZWsgSW5jLg0K
PiA+ICsvLyBBdXRob3I6IEdhcm1pbiBDaGFuZyA8Z2FybWluLmNoYW5nQG1lZGlhdGVrLmNvbT4N
Cj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIuaD4NCj4gPiArI2luY2x1
ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
Y2xvY2svbWVkaWF0ZWssbXQ4MTg4LWNsay5oPg0KPiA+ICsNCj4gPiArI2luY2x1ZGUgImNsay1n
YXRlLmgiDQo+ID4gKyNpbmNsdWRlICJjbGstbXRrLmgiDQo+ID4gKw0KPiA+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19nYXRlX3JlZ3MgaW1nc3lzX2NnX3JlZ3MgPSB7DQo+ID4gKwkuc2V0X29m
cyA9IDB4NCwNCj4gPiArCS5jbHJfb2ZzID0gMHg4LA0KPiA+ICsJLnN0YV9vZnMgPSAweDAsDQo+
ID4gK307DQo+ID4gKw0KPiA+ICsjZGVmaW5lIEdBVEVfSU1HU1lTKF9pZCwgX25hbWUsIF9wYXJl
bnQsIF9zaGlmdCkJCQkNCj4gPiBcDQo+ID4gKwlHQVRFX01USyhfaWQsIF9uYW1lLCBfcGFyZW50
LCAmaW1nc3lzX2NnX3JlZ3MsIF9zaGlmdCwNCj4gPiAmbXRrX2Nsa19nYXRlX29wc19zZXRjbHIp
DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19nYXRlIGltZ3N5c19tYWluX2Ns
a3NbXSA9IHsNCj4gPiArCUdBVEVfSU1HU1lTKENMS19JTUdTWVNfTUFJTl9MQVJCOSwgImltZ3N5
c19tYWluX2xhcmI5IiwNCj4gPiAidG9wX2ltZyIsIDApLA0KPiA+ICsJR0FURV9JTUdTWVMoQ0xL
X0lNR1NZU19NQUlOX1RSQVcwLCAiaW1nc3lzX21haW5fdHJhdzAiLA0KPiA+ICJ0b3BfaW1nIiwg
MSksDQo+ID4gKwlHQVRFX0lNR1NZUyhDTEtfSU1HU1lTX01BSU5fVFJBVzEsICJpbWdzeXNfbWFp
bl90cmF3MSIsDQo+ID4gInRvcF9pbWciLCAyKSwNCj4gPiArCUdBVEVfSU1HU1lTKENMS19JTUdT
WVNfTUFJTl9WQ09SRV9HQUxTLA0KPiA+ICJpbWdzeXNfbWFpbl92Y29yZV9nYWxzIiwgInRvcF9p
bWciLCAzKSwNCj4gPiArCUdBVEVfSU1HU1lTKENMS19JTUdTWVNfTUFJTl9ESVAwLCAiaW1nc3lz
X21haW5fZGlwMCIsDQo+ID4gInRvcF9pbWciLCA4KSwNCj4gPiArCUdBVEVfSU1HU1lTKENMS19J
TUdTWVNfTUFJTl9XUEUwLCAiaW1nc3lzX21haW5fd3BlMCIsDQo+ID4gInRvcF9pbWciLCA5KSwN
Cj4gPiArCUdBVEVfSU1HU1lTKENMS19JTUdTWVNfTUFJTl9JUEUsICJpbWdzeXNfbWFpbl9pcGUi
LCAidG9wX2ltZyIsDQo+ID4gMTApLA0KPiA+ICsJR0FURV9JTUdTWVMoQ0xLX0lNR1NZU19NQUlO
X1dQRTEsICJpbWdzeXNfbWFpbl93cGUxIiwNCj4gPiAidG9wX2ltZyIsIDEyKSwNCj4gPiArCUdB
VEVfSU1HU1lTKENMS19JTUdTWVNfTUFJTl9XUEUyLCAiaW1nc3lzX21haW5fd3BlMiIsDQo+ID4g
InRvcF9pbWciLCAxMyksDQo+ID4gKwlHQVRFX0lNR1NZUyhDTEtfSU1HU1lTX01BSU5fR0FMUywg
ImltZ3N5c19tYWluX2dhbHMiLA0KPiA+ICJ0b3BfaW1nIiwgMzEpLA0KPiA+ICt9Ow0KPiA+ICsN
Cj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSBpbWdzeXNfd3BlMV9jbGtzW10gPSB7
DQo+ID4gKwlHQVRFX0lNR1NZUyhDTEtfSU1HU1lTX1dQRTFfTEFSQjExLCAiaW1nc3lzX3dwZTFf
bGFyYjExIiwNCj4gPiAidG9wX2ltZyIsIDApLA0KPiA+ICsJR0FURV9JTUdTWVMoQ0xLX0lNR1NZ
U19XUEUxLCAiaW1nc3lzX3dwZTEiLCAidG9wX2ltZyIsIDEpLA0KPiA+ICt9Ow0KPiA+ICsNCj4g
PiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSBpbWdzeXNfd3BlMl9jbGtzW10gPSB7DQo+
ID4gKwlHQVRFX0lNR1NZUyhDTEtfSU1HU1lTX1dQRTJfTEFSQjExLCAiaW1nc3lzX3dwZTJfbGFy
YjExIiwNCj4gPiAidG9wX2ltZyIsIDApLA0KPiA+ICsJR0FURV9JTUdTWVMoQ0xLX0lNR1NZU19X
UEUyLCAiaW1nc3lzX3dwZTIiLCAidG9wX2ltZyIsIDEpLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAr
c3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSBpbWdzeXNfd3BlM19jbGtzW10gPSB7DQo+ID4g
KwlHQVRFX0lNR1NZUyhDTEtfSU1HU1lTX1dQRTNfTEFSQjExLCAiaW1nc3lzX3dwZTNfbGFyYjEx
IiwNCj4gPiAidG9wX2ltZyIsIDApLA0KPiA+ICsJR0FURV9JTUdTWVMoQ0xLX0lNR1NZU19XUEUz
LCAiaW1nc3lzX3dwZTMiLCAidG9wX2ltZyIsIDEpLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSBpbWdzeXMxX2RpcF90b3BfY2xrc1tdID0gew0KPiA+
ICsJR0FURV9JTUdTWVMoQ0xLX0lNR1NZUzFfRElQX1RPUF9MQVJCMTAsICJpbWdzeXMxX2RpcF9s
YXJiMTAiLA0KPiA+ICJ0b3BfaW1nIiwgMCksDQo+ID4gKwlHQVRFX0lNR1NZUyhDTEtfSU1HU1lT
MV9ESVBfVE9QX0RJUF9UT1AsICJpbWdzeXMxX2RpcF9kaXBfdG9wIiwNCj4gPiAidG9wX2ltZyIs
IDEpLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSBp
bWdzeXMxX2RpcF9ucl9jbGtzW10gPSB7DQo+ID4gKwlHQVRFX0lNR1NZUyhDTEtfSU1HU1lTMV9E
SVBfTlJfTEFSQjE1LCAiaW1nc3lzMV9kaXBfbnJfbGFyYjE1IiwNCj4gPiAidG9wX2ltZyIsIDAp
LA0KPiA+ICsJR0FURV9JTUdTWVMoQ0xLX0lNR1NZUzFfRElQX05SX0RJUF9OUiwgImltZ3N5czFf
ZGlwX25yX2RpcF9uciIsDQo+ID4gInRvcF9pbWciLCAxKSwNCj4gPiArfTsNCj4gPiArDQo+ID4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Nsa19kZXNjIGltZ3N5c19tYWluX2Rlc2MgPSB7DQo+
ID4gKwkuY2xrcyA9IGltZ3N5c19tYWluX2Nsa3MsDQo+ID4gKwkubnVtX2Nsa3MgPSBBUlJBWV9T
SVpFKGltZ3N5c19tYWluX2Nsa3MpLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0
IHN0cnVjdCBtdGtfY2xrX2Rlc2MgaW1nc3lzX3dwZTFfZGVzYyA9IHsNCj4gPiArCS5jbGtzID0g
aW1nc3lzX3dwZTFfY2xrcywNCj4gPiArCS5udW1fY2xrcyA9IEFSUkFZX1NJWkUoaW1nc3lzX3dw
ZTFfY2xrcyksDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19j
bGtfZGVzYyBpbWdzeXNfd3BlMl9kZXNjID0gew0KPiA+ICsJLmNsa3MgPSBpbWdzeXNfd3BlMl9j
bGtzLA0KPiA+ICsJLm51bV9jbGtzID0gQVJSQVlfU0laRShpbWdzeXNfd3BlMl9jbGtzKSwNCj4g
PiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Nsa19kZXNjIGltZ3N5
c193cGUzX2Rlc2MgPSB7DQo+ID4gKwkuY2xrcyA9IGltZ3N5c193cGUzX2Nsa3MsDQo+ID4gKwku
bnVtX2Nsa3MgPSBBUlJBWV9TSVpFKGltZ3N5c193cGUzX2Nsa3MpLA0KPiA+ICt9Ow0KPiA+ICsN
Cj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfY2xrX2Rlc2MgaW1nc3lzMV9kaXBfdG9wX2Rl
c2MgPSB7DQo+ID4gKwkuY2xrcyA9IGltZ3N5czFfZGlwX3RvcF9jbGtzLA0KPiA+ICsJLm51bV9j
bGtzID0gQVJSQVlfU0laRShpbWdzeXMxX2RpcF90b3BfY2xrcyksDQo+ID4gK307DQo+ID4gKw0K
PiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19jbGtfZGVzYyBpbWdzeXMxX2RpcF9ucl9kZXNj
ID0gew0KPiA+ICsJLmNsa3MgPSBpbWdzeXMxX2RpcF9ucl9jbGtzLA0KPiA+ICsJLm51bV9jbGtz
ID0gQVJSQVlfU0laRShpbWdzeXMxX2RpcF9ucl9jbGtzKSwNCj4gPiArfTsNCj4gPiArDQo+ID4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG9mX21hdGNoX2Nsa19tdDgxODhfaW1n
c3lzX21haW5bXQ0KPiA+ID0gew0KPiA+ICsJew0KPiA+ICsJCS5jb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10ODE4OC1pbWdzeXMiLA0KPiA+ICsJCS5kYXRhID0gJmltZ3N5c19tYWluX2Rlc2MsDQo+
ID4gKwl9LCB7DQo+ID4gKwkJLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LWltZ3N5c193
cGUxIiwNCj4gDQo+IEkga25vdyB0aGF0IHRoaXMgd2FzIGRvbmUgaW4gb3RoZXIgY2xvY2sgZHJp
dmVycyBhcyB3ZWxsLCBidXQgY2FuIHdlDQo+IHBsZWFzZQ0KPiBzdG9wIHVzaW5nIHVuZGVyc2Nv
cmVzIGluIGRldmljZXRyZWUgY29tcGF0aWJsZXM/DQo+IFRoYXQgbWFrZXMgdGhlbSBsb29rIG1v
cmUgY29uc2lzdGVudCB3aXRoIHRoZSByZXN0IG9mIHRoZSBEVC4NCj4gDQo+ICJtZWRpYXRlayxt
dDgxODgtaW1nc3lzLXdwZTEiLCBhcyBhbiBleGFtcGxlLCB3b3VsZCBsb29rIGEgYml0DQo+IGJl
dHRlci4NCj4gDQo+IFAuUy46IFBsZWFzZSBkbyB0aGUgc2FtZSBvbiBhbGwgb2YgdGhlIG90aGVy
IGRyaXZlcnMgdGhhdCB5b3UgYXJlDQo+IGludHJvZHVjaW5nDQo+ICAgICAgICB3aXRoIHRoaXMg
c2VyaWVzLg0KPiANCj4gVGhhbmtzLA0KPiBBbmdlbG8NCg0KVGhhbmsgeW91IGZvciB5b3VyIHN1
Z2dlc3Rpb24uDQpPaywgSSdsbCBjaGVjayBhbGwgZHJpdmVycyBmb3IgdGhpcyB1bmRlcnNjb3Jl
cyBwcm9ibGVtIGFuZCBmaXggdGhlbSBpbg0KVjMuDQoNClRoYW5rcywNCkJlc3QgUmVnYXJkcywN
Ckdhcm1pbg0K
