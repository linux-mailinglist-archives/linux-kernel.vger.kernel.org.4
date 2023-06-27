Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DFD73F5A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjF0H1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjF0H10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:27:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBE12D66;
        Tue, 27 Jun 2023 00:27:02 -0700 (PDT)
X-UUID: ff245a4e14bb11ee9cb5633481061a41-20230627
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2FJwKL/5zo2oFU56YyICip0E4KghzxRK0RdpkXd3/PM=;
        b=ZcPR6PpYZD+wFun+H3qw2iIvMnOtm1kpWE72cK1sT4PBz2X5IJ/M0I4KfQmL/h1ru5x6yF60wq8XNXG+eS+SAobqMawlOaPuCPiFSy5axFGXfR5pyNpB50v5T7+arcwdC6fmAD5z64aED9CjNtnD3Fqrijikb5Qimq1kXVF0MsU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:6f0a3f10-3cf4-4945-a360-4d682d3ff2b3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.27,REQID:6f0a3f10-3cf4-4945-a360-4d682d3ff2b3,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:01c9525,CLOUDID:4a21860d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:230627152657TQ0K750W,BulkQuantity:1,Recheck:0,SF:38|29|28|17|19|48|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: ff245a4e14bb11ee9cb5633481061a41-20230627
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 70113045; Tue, 27 Jun 2023 15:26:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 27 Jun 2023 15:26:55 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 27 Jun 2023 15:26:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWXLfAEYCBwSK0ef61E/7wlxHkw5k/K5TfYzMhMsao13K/Z3g3oj0SyE8Ejct3Asf8P7f/wisCUXHnjVCeoZLbPxn4NxbDqqhsoyTZuqwhEvo35YPtAMCg7hwGn+NSxzoWO9KpqhG6+0+kBdGij/mUn4yJ9wGe2E2Q2Wq1UHkG+zS2jxq5lCsZ8iLBoEuFH3xo4vuKjCXz2hfqulGIhYNV4NRvlKwbpnFMlzfZO9vECD2QPFhZluaiGShPZj8rZo8JHUUyjvHITj9OCp6o8XUhuBpMZqB7w7tO90P/oKPeqCSLYzxmhIvop7oajlBq29KD3yCH1RTNeIa1NW54/aHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FJwKL/5zo2oFU56YyICip0E4KghzxRK0RdpkXd3/PM=;
 b=UuMjCxQO+U1aDyIuKCXEjmGZ78lDzVJlijfv5sWdlA0MO/oxtJFiUzFyb3Q4BGj8TH54kovzoC3PoCQRWRS1A5nI2SFAWxlZWDneaqonmdXiuTi9SDKKAgO6NJiOHHUpeIKZYR8oHCJFXZyOFjwEc/xRbmiiteuHyqSxB7cz7mb7USbLtUKTfwJpYdNniHMLBShj96ZN9ixeq5Oz8zKb5lchdQ3qoHLTe5TRV5wwqnCRjRVbQmVLwi3nQjbgUd4LU0urGlUH3cylyqO980RRCtwoMVbq7ihUjA8qUK20hWfRmsQ2arxyXwvC6HRvfaKDzu+W/J4R4SpsnMsPOMms5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FJwKL/5zo2oFU56YyICip0E4KghzxRK0RdpkXd3/PM=;
 b=lhzcTeMbOwXWi1HX9ucZfaAI+3t631kVgUjwZU8c34pnVTZ7eCARlyvqbIcf37q6apAtHIWsPvB+5Zxe2FPk/JCUXRboM7+BeLQSLZYi+/29hsz2CYMo20Q65/dRy4VrIVwzDF96qTTBCPbU3OgMyy7Ou2bpZW3AoQoPlkZ/UyI=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SI2PR03MB5858.apcprd03.prod.outlook.com (2603:1096:4:142::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:25:50 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::cfaf:d71b:dabc:6d0d]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::cfaf:d71b:dabc:6d0d%7]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 07:25:50 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 12/14] drm/mediatek: Improve compatibility of display
 driver
Thread-Topic: [PATCH v4 12/14] drm/mediatek: Improve compatibility of display
 driver
Thread-Index: AQHZo+9XAIksW/dJHEGGytGwpKkaVK+U6SmAgAlgKgA=
Date:   Tue, 27 Jun 2023 07:25:50 +0000
Message-ID: <b9279145425a405ddbac114ff343b5f452c3b0ab.camel@mediatek.com>
References: <20230621031938.5884-1-shawn.sung@mediatek.com>
         <20230621031938.5884-13-shawn.sung@mediatek.com>
         <13bd0198-457f-e0fb-89bd-fd6b6954b8b3@collabora.com>
In-Reply-To: <13bd0198-457f-e0fb-89bd-fd6b6954b8b3@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SI2PR03MB5858:EE_
x-ms-office365-filtering-correlation-id: 729fd9fc-898f-437a-9267-08db76dfbc0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U7uh0F5jd8zovGUipG+tTb2Di0dumEQuec35xW3fnjCdpbe6GK8774OXalkkP5wERKaMzuuHBNLd1h3rtkaVMsHYAUSYDtWD35eQhKdlenaBEaG9MnhOpbc/p7aEY+KKdaWieIik/dmzD+QI/DWrjS0XZAJ+wjx3E1twYs7t95D+AV8HKPYZYxLiw4l5j1EoMrcMvQp1uZTQtLyk2SzyqXyhBo8tKiN4kYNf13wmjMzl1gzcxKlYdc/+4pX3DK+mnRdx2fqOXU0G6R+TBNefuInwRSGYCMJoashpi0jbUDVRoJuzoxdHjJMcu07p87PnAFqt5iStxGM3fFh+Y3Bs6dQGP3vsfFkPJc4wmh02lIrpVO3adQzEvpCI+fPttyPsNOqU5KPRG0RIY7gp93m9SzfWeDOs0X7FACEhy0V86S0F14KsWHCn83T/lI72SBvjiRSu3OsznYb8ndCiyGAiVAlFCuy/qm3C0UP/OIQ3H7AvM3tXn/Y2WfVH0mJ/hitTaiEOweGd+Fhoh696jk0BXfN8bo3sNjbZ0sxBvw+5NRRhr6i6lSenQUVM0YLoyva2rpZspQgiAogydvBDuhmxabIrQtUF0N+W8/5micW3CqwdHv62VrRRfwCDxktKRMP5p6ZgUzFE0dxEy5MNwnfecWl/bt6FNOOxhIetg79Lhhs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(110136005)(54906003)(2906002)(6486002)(122000001)(38100700002)(2616005)(83380400001)(71200400001)(26005)(6506007)(186003)(86362001)(41300700001)(38070700005)(478600001)(64756008)(66556008)(66446008)(66946007)(76116006)(66476007)(316002)(4326008)(36756003)(85182001)(6512007)(7416002)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yk5Mc3QzTkxYYkxCZXcrZEtNVC84YzVBMHRxWDJBZ2svVU84Q3pKQm9RSkVw?=
 =?utf-8?B?cUFtUnRXRC85RldVMXNUMU9YV09WeFlIcHpsZEtKWDdQRzdEekczWC9PVlFC?=
 =?utf-8?B?MDlLby94dmo2MkNYeElBaGMxKzBTaUNaS1JDb0FScEVzZ1JtR3E3aTV3U1pX?=
 =?utf-8?B?ditmem5WQ3RvRy85WldMSG1LZzBDM2VzdDh4dmdFSlREUXQxS1FSaTM2UlZC?=
 =?utf-8?B?eHduMmlmVyt2TUpqSUliNTVwdHdqMjlpWmJPYitjWm1IaXl2aU82RVRwM2lv?=
 =?utf-8?B?WElRYXhMTHl1dnhsdG0yYmtrTkg1eDdXSzVXcy83eHpSTTNrUXpqVGhVS3pa?=
 =?utf-8?B?bU1MYU91cndZSkcxeGZSYUpZWWxCak1yd09Oa0FVTDlZOVlCdExtQmZqT29C?=
 =?utf-8?B?TXhaMnR4aU9FcUpyNXE0b3NLaUNFTzVsbHk5a2hnM2FucU9PdnYxMDhPZk5W?=
 =?utf-8?B?Y2VwRkJLaXc2WWxGRmJDVEszZjFBY3hmNVZiNjdRVkwrR0IyVkRBcDR1emdG?=
 =?utf-8?B?OGFkbmlRSXZQNVNUWjArcm5SRHREditKMGNsaG03SUxCenFPRWtNNjRFWHBI?=
 =?utf-8?B?S3F2R1dya3owdWRBMGsrSXRIdnZycHp5ZnJpWDlCaGYxUEVncmJVZ3dnZ0px?=
 =?utf-8?B?ZnY2TWVPVlc2MER2cFlxU0RkSStWNXJvNVBkWWpadlFpbFRORk8wc1AycFFo?=
 =?utf-8?B?UDNoMzNyTExORnhSMG44aTZ1ZE1mdkJrMGx6ZkpXZ2pscGpKSW5TZzRUemlj?=
 =?utf-8?B?MTczL2U3by9tdUpneS9BajROSzY3NW5CUHhDN3BvWG80cjhVT2l1Njk4Mkdh?=
 =?utf-8?B?SkJIVGJyN2M3M1h4WjZDM0xUanp3WnBNMnRLTzZwaEErNkRUTUNCYXNlNEVE?=
 =?utf-8?B?WDZJVXJ5djk0Mlg3U21hcjZCRXVLdHFNTUExcHA5M2drRlowOVdDQmtNOHZI?=
 =?utf-8?B?SWlBT3BHNzBhWm1BWXl2NC9WamlzTS9uU1FqeHJmUFBISG14RS9hclpoUC9r?=
 =?utf-8?B?N0hESDIvMTNEa2Vha01PWUFuRmJmRTdiRDBWRi9vQkc5ajNQc0RudjA4aVJt?=
 =?utf-8?B?aFZ3cHkwOWNqSnF0NlZVNHR3OXA3VWdQTGcwUzA0d1VUcWx0b0xOR3B6bzZK?=
 =?utf-8?B?blhTajFmWHBDWXFwblFveUJIdlRxa2ZwUlN2QXBKazNyWlRjbTFrODd6ejhX?=
 =?utf-8?B?YnJXRTRSOVhNdWE0Z2ZHeGRRUVJtbTc4TlBpNzhCK3ZqdlNOSnE1VVVsYy9w?=
 =?utf-8?B?RHhXSjJUeFRHUGJaak91bkdyM2JKdzlaNk51VnFvVHNibGVxcUpFcXJNYU1S?=
 =?utf-8?B?ZkVWM2hyek5wZUdtbzlHbEZSRVo3aHR2THhKcEg2blgvZ2tySzlaemdTalBn?=
 =?utf-8?B?MWRXWjlyTjFKNk5sbjd0T1h6Ry8vcm94SGphekNvMGduMjEvM2FGNXhXdU9N?=
 =?utf-8?B?cWJ5aEloaVgzVlVCMGxSS1hxSENiY0VZWTJQUk5PQ0wvYVp1YzVRNC9sOWFW?=
 =?utf-8?B?MCtNVU1YWWU5TVFHU2R1MGdQRGxXOEc3bHp6ay9qMWlybGVXamZVZXowY2NB?=
 =?utf-8?B?bWFuVVM3ZS84a1Y1ZHdMeWxVamFTVkRJaS9XUEpUNXluSkZvKy8xVFI1QkpT?=
 =?utf-8?B?ZllLZnZLWjR5anFPMVFaZStycTA1TGJNa1VGQkk3NnpTMHRlTklBcDY2U2lV?=
 =?utf-8?B?bWZOT1hrOUpXZ3M0Vlk4amFMZURUcWhIWlRjanRNekhYRExDYlE3SFVDcndo?=
 =?utf-8?B?VXhkK2xVekVSVkdUMTNHM1ZMU2pmV0IyRytVTmpncTBwR2FHM2FkL1JibGNC?=
 =?utf-8?B?R1ZKL1lNZ1RRdFRzcmJtMktCZHpPTTQrZWxOQ1B4VktDWGF1ajJJRjRoWDdH?=
 =?utf-8?B?SGcrOEl3NGxvOE5RSkpObkQyMmU4YWcwVUlJQUFxMVRJUThsS1dzclVSY0l2?=
 =?utf-8?B?ZkdaKzdNRjZqcENIU0hza0RYZjdvNGpNSHBFQjJoS0tiSFg0bzNaNVJGUVJY?=
 =?utf-8?B?NTRBZ1pUMFk2ekFmYzRFOWlNeWRibVBOMVFIdG9VNjZkbGpZRml4akVOOVZj?=
 =?utf-8?B?Q1hFWWpPaFlQbnlLbFgyaGdERHh5ZXp6VEM5K3JpMUtlMjdLR1ZvaGEwc3RR?=
 =?utf-8?B?bGpnKzlBaHVxYnhUMGRHSmQrN21TL205TEowMGVXekM0djkzejB5V1dYQ3BO?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1456DAAE18599F4189C20248C0C59EEC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729fd9fc-898f-437a-9267-08db76dfbc0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 07:25:50.7837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+eIF2DuO2rnxSY4yGMOhlgABA/UaCQUvmpPdC9pIP5vYR3lpYZ9D4Ez2FjEMIf14fVOOYPeESHTF713CYGidQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTIxIGF0IDEwOjE1ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gPiAgICAgDQo+ID4gPiAgIA0KPiA+ID4gK3N0YXRpYyBpbnQgbXRrX292
bF9hZGFwdG9yX2VuYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGVudW0NCj4gPiBtdGtfb3ZsX2Fk
YXB0b3JfY29tcF90eXBlIHR5cGUpDQo+ID4gPiArew0KPiA+ID4gK2ludCByZXQgPSAwOw0KPiA+
DQo+ID4gaW50IHJldDsNCj4gPg0KPiA+ID4gKw0KPiA+ID4gK2lmICghZGV2KQ0KPiA+DQo+ID4g
aWYgKCFkZXYpDQo+ID4gcmV0dXJuIC1FTk9ERVY7DQo+ID4NCg0KV2UgaW50ZW50aW9uYWxseSBp
Z25vcmVkIG51bGwgZGV2IGFuZCBkaWRuJ3QgcmV0dXJuIGVycm9yIGhlcmUsIHNpbmNlDQpNVDgx
OTUgYW5kIE1UODE4OCBzaGFyZXMgdGhlIHNhbWUgY29tcG9uZW50IGxpc3QsIHRoZXJlIGNvdWxk
IGJlDQpjb21wb25lbnRzIHRoYXQgYXJlIG5vdCBwcm9iZWQgYW5kIHRoZXJlZm9yZSBpcyBudWxs
IGhlcmUgKEZvcg0KZXhhbXBsZSwgdGhlIG5ldyBoYXJkd2FyZSBQYWRkaW5nIGluIE1UODE4OCBv
bmx5KS4NCiANCj4gPiA+ICtnb3RvIGVuZDsNCj4gPiA+ICsNCj4gPiA+ICtzd2l0Y2ggKHR5cGUp
IHsNCj4gPiA+ICtjYXNlIE9WTF9BREFQVE9SX1RZUEVfRVRIRFI6DQo+ID4gPiArcmV0ID0gbXRr
X2V0aGRyX2Nsa19lbmFibGUoZGV2KTsNCj4gPiA+ICticmVhazsNCj4gPiA+ICtjYXNlIE9WTF9B
REFQVE9SX1RZUEVfTUVSR0U6DQo+ID4gPiArcmV0ID0gbXRrX21lcmdlX2Nsa19lbmFibGUoZGV2
KTsNCj4gPg0KPiA+IFdlIGFscmVhZHkgaGF2ZSBhIC5jbGtfZW5hYmxlKCkgY2FsbGJhY2sgaW4g
c3RydWN0DQo+ID4gbXRrX2RkcF9jb21wX2Z1bmNzOiB0bw0KPiA+IGdyZWF0bHkgZW5oYW5jZSB5
b3VyIG5pY2UgY2xlYW51cCwgeW91IGNvdWxkIHVzZSB0aGF0IGluc3RlYWQsDQo+IHdoaWNoDQo+
ID4gYmFzaWNhbGx5DQo+ID4gZWxpbWluYXRlcyB0aGUgbmVlZCBvZiBoYXZpbmcgYW55IGlmIGJy
YW5jaCBhbmQvb3Igc3dpdGNoLg0KPiA+DQoNClRoYW5rcyBmb3IgdGhlIGFkdmljZSwgc3VibWl0
dGVkIGEgbmV3IHZlcnNpb24gdXNpbmcNCm10a19kZHBfY29tcF9mdW5jcy4NCiANCj4gPiA+ICti
cmVhazsNCj4gPiA+ICtjYXNlIE9WTF9BREFQVE9SX1RZUEVfUkRNQToNCj4gPiA+ICsvLyBvbmx5
IExBUkIgdXNlcnMgbmVlZCB0byBkbyB0aGlzDQo+ID4NCj4gPiBQbGVhc2UsIEMtc3R5bGUgY29t
bWVudHMgb25seS4NCj4gPg0KPiA+ID4gK3JldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsN
Cj4gPiA+ICtpZiAocmV0IDwgMCkgew0KPiA+ID4gK2Rldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGVu
YWJsZSBwb3dlciBkb21haW4sIGVycm9yKCVkKVxuIiwgcmV0KTsNCj4gPiA+ICtnb3RvIGVuZDsN
Cj4gPiA+ICt9DQo+ID4gPiArcmV0ID0gbXRrX21kcF9yZG1hX2Nsa19lbmFibGUoZGV2KTsNCj4g
PiA+ICtpZiAocmV0KQ0KPiA+ID4gK3BtX3J1bnRpbWVfcHV0KGRldik7DQo+ID4gPiArYnJlYWs7
DQo+ID4gPiArZGVmYXVsdDoNCj4gPiA+ICtkZXZfZXJyKGRldiwgIlVua25vd24gdHlwZTogJWRc
biIsIHR5cGUpOw0KPiA+DQo+ID4gQXJlIHdlIHN1cHBvc2VkIHRvIHJldHVybiAwIGZvciB1bmtu
b3duIHR5cGU/IQ0KPiA+DQoNClllcywgd2UgaWdub3JlZCB0aGUgdW5rbm93biB0eXBlIGludGVu
dGlvbmFsbHksIGJ1dCB0aGlzIHBhcnQgaGFzIGJlZW4NCnJlbW92ZWQgaW4gdGhlIG5ldyBwYXRj
aCBzaW5jZSAnc3dpdGNoJyBhcmUgYWxsIHJlbW92ZWQgYWZ0ZXIgcmUtdXNpbmcNCm10a19kZHBf
Y29tcF9mdW5jcy4NCiANCj4gPiA+ICAgZm9yIChpID0gMDsgaSA8IE9WTF9BREFQVE9SX0lEX01B
WDsgaSsrKSB7DQo+ID4gPiAtY29tcCA9IG92bF9hZGFwdG9yLT5vdmxfYWRhcHRvcl9jb21wW2ld
Ow0KPiA+ID4gLQ0KPiA+ID4gLWlmIChpIDwgT1ZMX0FEQVBUT1JfTUVSR0UwKQ0KPiA+ID4gLXJl
dCA9IG10a19tZHBfcmRtYV9jbGtfZW5hYmxlKGNvbXApOw0KPiA+ID4gLWVsc2UgaWYgKGkgPCBP
VkxfQURBUFRPUl9FVEhEUjApDQo+ID4gPiAtcmV0ID0gbXRrX21lcmdlX2Nsa19lbmFibGUoY29t
cCk7DQo+ID4gPiAtZWxzZQ0KPiA+ID4gLXJldCA9IG10a19ldGhkcl9jbGtfZW5hYmxlKGNvbXAp
Ow0KPiA+ID4gK3JldCA9IG10a19vdmxfYWRhcHRvcl9lbmFibGUob3ZsX2FkYXB0b3ItPm92bF9h
ZGFwdG9yX2NvbXBbaV0sDQo+ID4gPiArICAgICBjb21wX21hdGNoZXNbaV0udHlwZSk7DQo+ID4g
PiAgIGlmIChyZXQpIHsNCj4gPiA+IC1kZXZfZXJyKGRldiwgIkZhaWxlZCB0byBlbmFibGUgY2xv
Y2sgJWQsIGVyciAlZFxuIiwgaSwgcmV0KTsNCj4gPiA+IC1nb3RvIGNsa19lcnI7DQo+ID4gPiAr
d2hpbGUgKC0taSA+PSAwKQ0KPiA+ID4gK210a19vdmxfYWRhcHRvcl9kaXNhYmxlKG92bF9hZGFw
dG9yLT5vdmxfYWRhcHRvcl9jb21wW2ldLA0KPiA+ID4gK2NvbXBfbWF0Y2hlc1tpXS50eXBlKTsN
Cj4gPiA+ICticmVhazsNCj4gPg0KPiA+IEluc3RlYWQgb2YgYSBicmVhayBoZXJlLCBqdXN0IHJl
dHVybiByZXQ/DQoNCkdvdCBpdCwgaGFzIHN1Ym1pdHRlZCBhIG5ldyB2ZXJzaW9uIHRoYXQgcmV0
dXJucyB0aGUgZXJyb3IgaW1tZWRpYXRlbHkuDQogDQpUaGUgcmVhc29uIHdlIGJyZWFrIGhlcmUg
aW5zdGVhZCBvZiByZXR1cm5pbmcgZXJyb3IsIGlzIHRyeWluZyB0byBtYWtlDQpvbmUgZnVuY3Rp
b24gb25seSBoYXMgb25lIHJldHVybi4gRm9yIGV4YW1wbGUsIGFsd2F5cyByZXR1cm4gYXQgdGhl
IGVuZA0Kb2YgYSBmdW5jdGlvbiwgc28gaWYgc29tZWRheSB3ZSBhZGQgYSBwcmludGsoKSBhdCBz
b21ld2hlcmUgaW4gdGhhdA0KZnVuY3Rpb24gZm9yIGRlYnVnZ2luZywgaXQgd29uJ3QgYmUgc2tp
cHBlZCBieSB0aGUgJ3JldHVybicgYmVmb3JlIGl0Lg0KIA0KTm90IHN1cmUgaWYgdGhpcyBjb252
ZW50aW9uIGlzIG5vdCByZWNvbW1lbmRlZCB3aGVuIHdyaXRpbmcga2VybmVsDQpjb2Rlcz8gVGhh
bmtzLg0KIA0KUmVnYXJkcywNCkhzaWFvIENoaWVuIFN1bmcNCiANCg==
