Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EE961E85D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 02:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiKGBkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 20:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiKGBkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 20:40:08 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B558265EE;
        Sun,  6 Nov 2022 17:39:59 -0800 (PST)
X-UUID: bb6a2e9e36fc423781d804cd5406c0ff-20221107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sioR3BODH4jrVJmVjPb6d9YhcYoqD7Qy5KT5Xc020aQ=;
        b=jf27pLoLYHZ9YFOkEqZwrJEgKe6fexuDBME8Jl7m2SfLB+zqmqV1IA5LTOHOXRV8Q31lv/DGuEY0I7ZIgVNJbSTRmTPiolJo0k0+9xSViLZD66WRWPLaosh7MW4So8ybfi0CjC5IRb+ehByyag2xTFCgBJYoatExEF/FgEVfaGY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:76299c3a-19cf-4886-a708-ec261a423ced,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:4c85d4f3-a19e-4b45-8bfe-6a73c93611e9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: bb6a2e9e36fc423781d804cd5406c0ff-20221107
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1983407769; Mon, 07 Nov 2022 09:39:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 7 Nov 2022 09:39:54 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 7 Nov 2022 09:39:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OheZOQikScOaRG1nlXDCLk2yREa3VyToGPLVTUv5V/cGdoaQ9+9n+45lvIdu7cyOw+8s3VO5aYf2FY43vXiHIfdFQtC5pyziavJZ3IZ4LjfRv5H28UYkom95Fv85pwozQuuQePkPD0YQyDBzavylIj7R4RfgjqleZs630JTU7KiT2uDtCm+Q4pXs8siQadhhi0Ot6UYxsR+1msakiEymw2dLzo6+8CEc/wtnoytzQfkOb/TlwxVQzWu1MTOlmx7GTomGtnB/OtBpjYMVWf+6q8q6iSYjg2WCj1Ziw6Hk7nX9SPkwIDBIc/tQ6t5ySzQ2G8H15dCPGAiN8jSuPtkR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sioR3BODH4jrVJmVjPb6d9YhcYoqD7Qy5KT5Xc020aQ=;
 b=b8mAEp1ReDryG6MTHCxC3FZuqIihW8uzzhqWpi9+bFcjycS11or7L2E6koxdeo5zlDJKjZQ9WOCVgPDRMmMm8TYNpd4JctIaJbbQlZNMSMlzrZzriXd+AteemDElbE0JorUbJ6SnJ0jc4a2UOKtwJlR/gHLCSer5dFVuvQTIKiw4A/cYM415tcBwGGQxauEU7H7+SRXWdiucwvG4NEcyKC+vx+5nvVMcWl8G7HYabx1ce2ibcKUvFUD/BKyNAKV9Sr4eQ9ZYlQoO3jStf0zRlr2dm1lDdR1Pve6jYbMUN3vPK8l9E2TewS0lesCJ83PrEA21nwpw3aZ4BfzFEwTk5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sioR3BODH4jrVJmVjPb6d9YhcYoqD7Qy5KT5Xc020aQ=;
 b=Th4G2zNcc0UQCQBmIRmANlCVE+YrMP+EUjS64/7W9lcH5l6bZefU/H23W/M1BGWaXHV8zg69KyAqpRoseoaPWU448OBeO71ZBY7P6qog4m9yMdkx2jSUHOYdvK/fsdA7FK6WX4Uo3jsBdk/WNRaGfIcP8ZqzfGf0yaGGsH5nxTY=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SEYPR03MB6651.apcprd03.prod.outlook.com (2603:1096:101:81::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 01:39:51 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::7e10:1fdf:c6f6:597e]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::7e10:1fdf:c6f6:597e%7]) with mapi id 15.20.5791.024; Mon, 7 Nov 2022
 01:39:51 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 4/7] arm64: dts: mediatek: mt8516: Fix the watchdog
 node name
Thread-Topic: [PATCH v4 4/7] arm64: dts: mediatek: mt8516: Fix the watchdog
 node name
Thread-Index: AQHY7/I2KJT3UOIXqkaZgAfT5yU62q4u1JiAgAPfKgA=
Date:   Mon, 7 Nov 2022 01:39:51 +0000
Message-ID: <f6aa2fe039226d3fc94d92df5e1913515e0e564e.camel@mediatek.com>
References: <20221104020701.24134-1-allen-kh.cheng@mediatek.com>
         <20221104020701.24134-5-allen-kh.cheng@mediatek.com>
         <20221104143219.aiwfezso7r72yg7q@notapiano>
In-Reply-To: <20221104143219.aiwfezso7r72yg7q@notapiano>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SEYPR03MB6651:EE_
x-ms-office365-filtering-correlation-id: f863d2ef-32cb-4d78-2e12-08dac060f68a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9YH0ONge4s4AxKeumhLwJ+/17ILDJqMdKLcBXJ8Px5+z8B4mNGO6+x0g6kVWZg/nxX+8+kWlwqpt0Ia6dzSGwSZy4IT6AAtWKc07yNKCR7ipfqiuQ1LPLfHdkp1t9gSvkMa3Qvu1urAuZtUhANt1YtljjUF//JbVdzpCeu/mnoNJrxHK5USDfwwrusPlqLZvTuFOnJbh8HyJlL5N8WA6PpOZXYrwj+vcAFOaeic4TYeIy0auyUfNbSN5lXxCxvodAyNkjCfYsp8SWcl/0/gfy2Anw/Ba+ZoM+dYHCxOmck+KA/wFd8mhQRG/j0snHK2Kad0m2JrRLx+tIw8vy56J2QygsdH9rcVzs52Gjs0tr98AQX7n8PxgJ4eaCyz6Gm3rEse9jxZ6s4WusZHVltA4myw3hRBXefV24++mWHSZl2dYP9qpC4VwIEdUdBYts3WOhKvjIzArzp7d8ZwozOIYAODrxUSOfoLhdy4G1VzRbGksCzlwrE/+oCN8uv2Uy1K+5vZaF3IGLUCUfHTTwBnw1SThP0zXeTwpNJk23I6ZjaX9xBH3+3se+PNf9jSPH8o12SunvLRyV6TjLM3aoMsk2GxwKNMO0zPsUVAsBxNXB0TDzcUFcVp9cni2oqGzWxb59NjsMR/TGSJU5Std1phTjO1aYf9AT3Oy8c4hpaF8bM808JhR7lkouMAhVZXwqZ+dZU+3TI10Kf4mQoSiLKLzTgl+mME2MkYCXrYTFz90/vzhulL//+yuQ3+kNcoyR3ez8b/c6FX8vbWGENN43llNig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199015)(66946007)(2906002)(5660300002)(478600001)(66556008)(7416002)(54906003)(64756008)(66446008)(66476007)(91956017)(8676002)(76116006)(316002)(6916009)(6486002)(41300700001)(71200400001)(8936002)(4326008)(36756003)(83380400001)(38070700005)(38100700002)(122000001)(6506007)(86362001)(186003)(66574015)(26005)(6512007)(2616005)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWRPa01UeEM1aE5wUE1xRDM3OHBEMCt4ZUtLUHRXR2tTSmhkczFNdFRkTU9P?=
 =?utf-8?B?NWtCalE1Q0JveGk1Sm9OQzFXUXBjV29XaTlXaEVtWW0rTC9zVGZUd3dNdWVk?=
 =?utf-8?B?clRGWTBGK2krNkNoOXZqZlFWcS81T2t0VmpnaXN0Z1JjS25MY1F1RE13aEJD?=
 =?utf-8?B?K3lvRVpic2RuTGJaUHp5LzdzWDUzUy9PVU9SSXc1bFR6WHAra2R4cDBTYWhz?=
 =?utf-8?B?R0RsTytoY1IxVzJWWUZZUjVoRlk5R2hWQjk0S2hxam5Sc1JoWkE5TDVOaEEy?=
 =?utf-8?B?djNvNW9ISTVWblVFQk5pRUVxUzJEemJoK0VjSTR1S2hISWJTQVJhVmFla3px?=
 =?utf-8?B?NFBWaU94dE1jV1dFKzE1NG5PbVZDNzdDTHVIRmwvOFFzK24ycmQvam9Yb0dh?=
 =?utf-8?B?VXN3alNJUGZBK3MveWxxOS9weDg0Zk9KSURDQ1lxcWtjblFqRmlWTElhWmVm?=
 =?utf-8?B?UEFpdEtGVTNlTmZGbVZYOG5wUjM2NUluMFArM0YvT1U0VzNHRDNpaXpVOUxp?=
 =?utf-8?B?dnR1MDJ3WHR2TjNpdFVUQnFPZWpGL3Z5aXBFbjBMQlRrV04ybDgrY2ZwR3hQ?=
 =?utf-8?B?UDhGY2F2MWFvbXpUTGFXZWd6aHErdFZEbFRhUzQzUnZqaFc5cW5HNmJWS1Er?=
 =?utf-8?B?WnVhQ1NZeTlUSTI3UHMyOHFCMW81Y1lFYXNkb3hsZlNjc3pRMlc2cWZZK3hR?=
 =?utf-8?B?WHZ3SlFETld4bjhVN0JyWW1FS1ltU3pNNE5PS3l4VnlwUnNZd2tFTXYxWEZ4?=
 =?utf-8?B?SlRVUzdJeGIwRnpEZ0FPMFVhMkcyYS81czFMcVY5R1JUeFdqYzM2R0NSaUJZ?=
 =?utf-8?B?RC9SMEVvcFBFbnRSaitFcnBmVjBNdFNrZWs0NU52dGxsUWl5Vk4zRDZCeFox?=
 =?utf-8?B?UkpoK3ErZ2dMcHBRZjRrWDNBUDZmblltSnNmNzVtbzYwenU1bkU0ZVlQYlZV?=
 =?utf-8?B?VGdzMGRDREhIU3IvbEFJcEViTm9lK200N0ZEZzN2S210R1RSanFwc2lhd1k1?=
 =?utf-8?B?TUp0OCtLSmc1QmJrZU1IVFBtZXZBUUVDUjYzRHE4clRkdmptLzNzVWhFck45?=
 =?utf-8?B?Z3gxZk12M2dhYVRlSlF2QnNScGdUY2ZuR215NHdaYjlxd1cyZ3FFaGViS2dC?=
 =?utf-8?B?MkQ0KzhIdzEveWFPS3gxazdITHByQjdDWUVwUUJwQ2M2aE1mM0QwUWNpN2JF?=
 =?utf-8?B?ZUQzRWhUVjdxdkw2NnRXd05EL2QwQUY1WXRzMFpRR1VMMGZJUTRWbW9PVENU?=
 =?utf-8?B?amVlWTVHSE1YZjZMcU53ZGZkNEM4LytlRCtZTEtoUTlYbHdGQjZQTDYxNEJV?=
 =?utf-8?B?ekNmZUQ0Q3Q1aWxZR2JCWHFZZ3V4VFJkSTNXSlJYYXVOa3lBYXlEczhmYVNJ?=
 =?utf-8?B?aE11Y1Zobjh5K2t2ZXJnbmFTWS8rK1o3Y0dLUFRPRDR2Z2w5WFAyd2Mrc0pD?=
 =?utf-8?B?Q1p1UDFtZmNqemVDRTBCN1A5Q29HMG5mVDErczFXb1RXb2lEWHpFY055Rkgw?=
 =?utf-8?B?Q2RiTG5nUVF5THFFRWs3UkdxWGxYUEZTZ2RtUmVXTDRaQmlrMlg2a0ZBNEZk?=
 =?utf-8?B?NExjZ2NCNEtkemRza1lHUlc4RklSOEpBaVRFSjQ4ZGdxMUEwdUs2cy9scEQx?=
 =?utf-8?B?S2s4cFlUOG1nYnRmNlJsQVBxSUNkSmcxSkh4V21KUmM4ODFWOE9ScEFXYVpi?=
 =?utf-8?B?ZEwvSmlMNFA4Q2JwbFpDaWNLWjc1WE9GNk9OeFdRRXcvNGFkMkR0N3RlVS9y?=
 =?utf-8?B?U2E0YjJoWm5uU2VjR0didUxvVC83Wnd6K0pJOEVYek56OTlRNnBJTFFzaEVG?=
 =?utf-8?B?Wlhxems3ZDZMMTJ0NzJRdXdhbldnakkyaGhyMURxNy9pcFcxTS9pTWcwOXFm?=
 =?utf-8?B?aDNxZzl4TUxRQldBNGptNVJXM1BDSmZmYjBkbHJHSURGZFNCR3R2QnMvOFZB?=
 =?utf-8?B?c250QS9sdTExSVJ3c0Y2NUIxeXR2U0hDQnkwak84LzV0Z1dxZ1dyVHNEdFE2?=
 =?utf-8?B?bWJnZGE3SHV0bnRWVVRLMS9PalFmOE4rSCtCSW9INGk2UTNSS3p0WnlFNEVh?=
 =?utf-8?B?YUoyU1ExYlVDaDNDRHBYTUFsTFIwZ0crRjc4TEVrNGFiZld4bHpTOWROKzhY?=
 =?utf-8?B?OFhYWHNEWG43cDBaL3VHVWZNY0dlTEprVFIwK3MyN0ZVNHZRNnFqVTRRUDhO?=
 =?utf-8?Q?VyVJKxl3i6OsREgiHZvDpV4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5F6456913E7D5438D657DABBA81B830@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f863d2ef-32cb-4d78-2e12-08dac060f68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 01:39:51.1834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mP004NfA1aa+00qzyt/fuVapRkfQ03FiUiT3q4vi1Pg15CAUq7rTkObAQgdhSZHJcGvPhm3lWeI9OH+2fX72Aj/y/wUp68qqhsB/drk3CIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6651
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTsOtY29sYXMsDQoNCk9uIEZyaSwgMjAyMi0xMS0wNCBhdCAxMDozMiAtMDQwMCwgTsOtY29s
YXMgRi4gUi4gQS4gUHJhZG8gd3JvdGU6DQo+IE9uIEZyaSwgTm92IDA0LCAyMDIyIGF0IDEwOjA2
OjU4QU0gKzA4MDAsIEFsbGVuLUtIIENoZW5nIHdyb3RlOg0KPiA+IFRoZSBwcm9wZXIgbmFtZSBp
cyAnd2F0Y2hkb2cnLCBub3QgJ3RvcHJndScuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxs
ZW4tS0ggQ2hlbmcgPGFsbGVuLWtoLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiBSZXZpZXdlZC1i
eTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVs
cmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTsOtY29sYXMgRi4gUi4gQS4g
UHJhZG8gPG5mcmFwcmFkb0Bjb2xsYWJvcmEuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210ODUxNi5kdHNpIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDg1MTYuZHRzaQ0KPiA+IGIvYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDg1MTYuZHRzaQ0KPiA+IGluZGV4IGQxYjY3YzgyZDc2MS4u
ZmZmNTlkYzFiNGQ3IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ4NTE2LmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODUxNi5kdHNpDQo+ID4gQEAgLTIwMiw3ICsyMDIsNyBAQA0KPiA+ICAJCQkjY2xvY2stY2VsbHMg
PSA8MT47DQo+ID4gIAkJfTsNCj4gPiAgDQo+ID4gLQkJdG9wcmd1OiB0b3ByZ3VAMTAwMDcwMDAg
ew0KPiA+ICsJCXRvcHJndTogd2F0Y2hkb2dAMTAwMDcwMDAgew0KPiANCj4gSSB0aGluayB5b3Ug
bWlzc2VkIG15IGNvbW1lbnQgYWJvdXQgcmVuYW1pbmcgdGhlIGxhYmVsIGFzIHdlbGwgb24gdGhl
DQo+IHByZXZpb3VzDQo+IHZlcnNpb24uDQo+IA0KDQpZZXAsIEkgbWF5IGhhdmUgbWlzdW5kZXJz
dG9vZC4NCg0KSSB3aWxsIHJlbW92ZSB0aGUgbGFiZWwuDQoNClRoYW5rcywNCkFsbGVuDQoNCj4g
PiAgCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDg1MTYtd2R0IiwNCj4gPiAgCQkJCSAgICAg
Im1lZGlhdGVrLG10NjU4OS13ZHQiOw0KPiA+ICAJCQlyZWcgPSA8MCAweDEwMDA3MDAwIDAgMHgx
MDAwPjsNCj4gPiAtLSANCj4gPiAyLjE4LjANCj4gPiANCg==
