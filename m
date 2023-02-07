Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D98468CC60
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjBGB7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBGB65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:58:57 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489F3AD14;
        Mon,  6 Feb 2023 17:58:54 -0800 (PST)
X-UUID: f51d3a4ca68a11eda06fc9ecc4dadd91-20230207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EUwFgLpEqQmrs0H/FqJq+UKrZUqLXTUmhm5NeKNvt94=;
        b=QsMVbN7sjSyV6rY1fZBuQLN/iXj0t7E3lvnJzjqnlh3vydgjHH5gSG7iYbFrfjR1U/u9ZIITdEGbonvnDDzNK3tV+KF3ye8JIj6xFL+9OU+kWuU0EJ893bRwsEoUo1s9HfZeKHjGnTXqqQCCMNZ9RZ1UEnWZY60rMQLsxI4qliA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:ddb117af-b043-4c88-aee0-d994c5fd0888,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.19,REQID:ddb117af-b043-4c88-aee0-d994c5fd0888,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:004f1a8e-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230207095849A1ZLQ8NW,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: f51d3a4ca68a11eda06fc9ecc4dadd91-20230207
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1685600134; Tue, 07 Feb 2023 09:58:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 7 Feb 2023 09:58:45 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 7 Feb 2023 09:58:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lget8qBeTcSLL5M8HfY5F+8b0cy9DdNdYEoPVQluc8VXC4kGsAVdYGuvWcpGyxdZj7FGTUgOTpuxaAQlzaxvKkn5rbwa4m2t97nhJP9tMYjFNK5pQ8Y5hOoy4RV2Mv6QfCC3wIfqUzMqqQBWvWGK36+OJ4e0J879wyPhiCkj6IEuO+WORSTe3k9d0Xo9y/4zD3tcdhAUQaoX0uWA43EGEceXr3vuZvUnW0JmTzTz80MD5peAaHhvVPQL/W/UScpWcpwnBGPJT+gPIuvNyuxCtKQ63/iLT056hct1KpszNKmIUOdCgg3h86uBQ1iZDn8iYn62TPJndQPmLLKteVmXdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUwFgLpEqQmrs0H/FqJq+UKrZUqLXTUmhm5NeKNvt94=;
 b=NWfWsSNUZVEyfzKdQsjubni+vsqpwDXPcrTr+L1X5xXPQC5voIaBRqtX1SBaLtX3rBJrlfKA27qedkP7NxiWvPjLMavOfhFSNDR6PI+yzAHvCAwUmIox1xS4kTVVg56ZSmpmjNSeBnMvcgx92bmsZhmaxjB2N9APOfWqhnkJEFMKV/Irj7bTq0iI0IEMiwYrFtLWVStWKHIKOMjD2Bluz4LsOH4veyk2riO8DmOj5VzchJPl5h5s0YTZEAgt/mYJ3I29k9GQoFLzKUBE9aFrsZC2L95Cxg2msjKfCu5O7RCJ5q0TyyQqP1oSjDCHuyLsEcGRdQlhxR7iEBAZeOyKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUwFgLpEqQmrs0H/FqJq+UKrZUqLXTUmhm5NeKNvt94=;
 b=McsR5gXImHFMsKW0xhfhM5KNdSLwsPiBuT1l/OEHU/0yoWJcXfbmwY9zsTBSCVfY+CVhJuir1s7AFdXbk8wrByocQ5xYEOpYnuPGXg+Bli+ikC5nJBpgSPTvBbrkGH+r86168cRe9ItKUfWWOLaZkMngZrsnv5hE7W/m5kjqxJs=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by SEZPR03MB6812.apcprd03.prod.outlook.com (2603:1096:101:67::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Tue, 7 Feb
 2023 01:58:42 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::ba47:a392:dffd:355f]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::ba47:a392:dffd:355f%7]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 01:58:42 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v6 3/4] clk: mediatek: remove MT8195 vppsys/0/1
 simple_probe
Thread-Topic: [PATCH v6 3/4] clk: mediatek: remove MT8195 vppsys/0/1
 simple_probe
Thread-Index: AQHZKussAIBNhMuL60+kgFdojuoEW664XPSAgAp8nIA=
Date:   Tue, 7 Feb 2023 01:58:42 +0000
Message-ID: <cde1fda27834eb01d6f62c7d057724c03436e23e.camel@mediatek.com>
References: <20230118031509.29834-1-moudy.ho@mediatek.com>
         <20230118031509.29834-4-moudy.ho@mediatek.com>
         <CAGXv+5Gid0xT=Ru0G3d-z+ED_wKWpGYSbhwiFXRv5jqJL0vC_A@mail.gmail.com>
In-Reply-To: <CAGXv+5Gid0xT=Ru0G3d-z+ED_wKWpGYSbhwiFXRv5jqJL0vC_A@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|SEZPR03MB6812:EE_
x-ms-office365-filtering-correlation-id: f59efe7a-f656-4fea-1877-08db08aed708
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XQvSUv79HKX9QzRsPVCPPKfIPlytrsnxRbbdomIS0Ycmaj2aP7+s+pVbsIDxQWQv97OVAqKbT7wSBjasLFk/GPgmo93q5Z8c/gZrU3tbMBaqduobp8ikFckXaKRxaXTfYE8QcCCWkncKUTQDVZMsBkQp4zXuJZ9l5Q/71zaaHo5P77VaLxUVIb574wFarm1LzfyO/g/VLpjNrWyvCDzwkAk5hXWJExZ2gSO7mzMTFg4yBRok1Iipw6menwcXQtnTNvD23IDgNNrSCDJADqn0pG4szicWSGxj5hTA+hCeKec15C4zBbQ09w71+zt8imWBpo4RPLmtDYRUrLWCtYqGLDcaBR54XOTK2g11OvAZ86pEqhqLUTL5MfwOAkxxF79UQ9ywjuk6thi/45TkeBOculnq/zlKrFF0SAJ+PSbh9UMRW7mvQMeJTOhq09z9hPS7cBaCVl9WpGtKGeh2dWpWMxUXnFu1pPKskRqPNfok2E81EbnqqsIl33kUEW6FtuaDR0orRSf0r/D/N0ailzjWHXBI8kAcap370tebaQr1hifXDRDX2zP+f3VA/ikyDOZP1RFz11478lKK7Txytn+OZI89I2r5Wx+3S3Cp1H69mHLE1uwc6+SfKo7gAk9i2NkIO5F9P4jOoL9jU95NspR5YVlhjCh+c7/PF6vYDW9H5ipzPKkYDVRoWRilmaUdVPSK0igyUKCxUxzcYi/1+UnLYOChMb+Fv2ggjnQ51cCFiXiZ7CgOp1IpLFKKf7NpYhObOPrNtm8sriu2Imuo9BRjn33VvGBe6VQUQrt+NbD6IBsajP9CEReiVz02y8Z3i9oH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199018)(8676002)(4326008)(66556008)(6916009)(66446008)(76116006)(8936002)(41300700001)(64756008)(54906003)(122000001)(85182001)(38070700005)(36756003)(316002)(86362001)(38100700002)(26005)(6506007)(6512007)(186003)(66476007)(6486002)(966005)(53546011)(5660300002)(66946007)(478600001)(7416002)(71200400001)(2906002)(83380400001)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0licFNDb2pNVkxxMnF5blVhaDVUVi8zaytWMzdtQm4zWWN5Sm4rODRCVkJz?=
 =?utf-8?B?dzBqdDVPek9uV1dxQU9yWTFMdjZxNGhYeVJ1ZFhqMVV3ZHBuZFFBR2d0alQz?=
 =?utf-8?B?SmJrVDFsOWh0QTcwV2dyRmxJdFRGckJuZjRCM1lnWVpEY29wSU41Yi9OdWZ2?=
 =?utf-8?B?OWNDdUJtaG9BTEJzdnJLZVphU1Z3ZEdKQ2tTd1ZabmpqU3hpSjM4WXpLc0Yr?=
 =?utf-8?B?RXh3ZWV1dHliZzlyRitPTEV1RXRlOXV2OXpjM2FadVZNWXE3MlUvUDNoMEFB?=
 =?utf-8?B?VnZLb0h4UjhnZ3VNZm9LU28vQkNqS1JsNHZNT1RCZ1phQlFSZzByWnZZVGVh?=
 =?utf-8?B?K3lmaFFTSHFyc0d4MjVhV0d6T1NkMXhaV0orVFhJRFplRlgyczFoTHl6d0NJ?=
 =?utf-8?B?S0dmbGhibkZQNlBEMnZ3ZTZ4bndXdjFNWmw1SUpOd0pLdXNwQm1sM0FFV0xG?=
 =?utf-8?B?SDFjNURmL2ljSzd3NmFhSHZGcmtuRjMvd0xsNG1RRWMvQjgyeld6bDI5OGxa?=
 =?utf-8?B?Qyt1SFRReG9xc0ZtakM1bkZ2dDRHOTlLNmJCczVNckVOaXRZVGdUM1pSVlFv?=
 =?utf-8?B?aFhzbE9uQjJYRHQ1dHdjY1FTMzEzWGRnaE8xbmJ0b2V3ZWNPV3c2c1ZxVmlD?=
 =?utf-8?B?VEl1aksxbUdKRUlsc2s3cDI5RUJCZDZxZ0ZvSFcyRFA3by95blUyMVFqcUZO?=
 =?utf-8?B?alE5V2k5N21yc2VSZVJmSWJtWHJJdmw2STV1cGt0c3c1RXhOQUxkTUlhUjQ4?=
 =?utf-8?B?SFltcmJEUG1VRmR5Nk5UaktSSUZDZEcxNXR5N1Rpakkrc0pkRjlSTWMyRksx?=
 =?utf-8?B?TTh2QTdweHNxMWE5cUxlZjNEOTFUVjBmNWtYdE05OUU3N1pNaUNYRkdJK1d1?=
 =?utf-8?B?cUMvMDU3ekVlNk5jVWdVdEM3UTNQTUhRdE8wdXJYME8xRit5alRRV0p0cXU3?=
 =?utf-8?B?QW5BN0ozSlFoQXRRVlQreURhbnhXWXJEbHhoTU9WMkgvdVhaSUlBMGNXL1FG?=
 =?utf-8?B?RW1DM3VHaUpEMkU3bXBCbkxxeExqRkxhZ0lYSFR3NUg1cWUyaVBobEQyUmFG?=
 =?utf-8?B?c1c3aU1LNDZKTGdxdU9ZT2lxMnJFTEtMSUU0REFidi92Sk0zUUIwam9PTDNo?=
 =?utf-8?B?U3dZWjRXaDVyaFFYeTE2U0tOREVodS9GamFOR3BBalFCUjlmT01JTUN3Y1RB?=
 =?utf-8?B?WngzaGloeTNFdzQrSm1kN3R2aTNSd2JuK0xmdkRDMC8ycWh5T1F5dDdkZHlU?=
 =?utf-8?B?VytvbUhBL0tIMHpuYm9ubnBuRG9FODVhTXlEa3pXL0IxQTNXUXJDSE9LQU8x?=
 =?utf-8?B?cHNTYjlLZWthdGdzbXhwWndlTURXMkt6aHhrUy9ycUFzRjRxTFQ0bEJJcCtR?=
 =?utf-8?B?Q0F1cFZQZUptNjhHQ2VCazJOdC9Ib1RwTk1CdXRneENhbENSYlNaTjN2VU0w?=
 =?utf-8?B?UDdnZ002V29QQ29VUkFmaGUyZXJTYWZuNGJkL2IxWjZXUCsyNFk5TGxSdHBY?=
 =?utf-8?B?MnpiN3ozbkcvci95QnY4WFphcHpERFVRcWlZOUJCWWMxczRGb1N6L3ZKdXhV?=
 =?utf-8?B?QjdYc1VEQU9Xa2lMQTBpdmpGTWlOTGdxYWFJcTIwcFQ2NElRYjEwYUFGRkRw?=
 =?utf-8?B?K0ZUR2N3cjE2VHFSM0k3M2l4VFhTQ01yUEw5ZGVOVTlMd0pTSUJBL3hIcVlR?=
 =?utf-8?B?aEk1VWluZ2hqam83SFlvL1pETTNiSDFBUFh1UGFMeTF0dlZkWENrLzg0a3J6?=
 =?utf-8?B?UXpZanlDVVpZckdOUWFMQ1JncVViMCsxUEc3b2VLSHZ2TERGbVVYUUVyaXhO?=
 =?utf-8?B?czVocUQ4djB3b3BNU2JQeUxPVTRFcUlFQVhpY3IxQWtUZWRRM05jbjdkY0Zj?=
 =?utf-8?B?UGovZ3d0UG5GdFdOcmNiTWpodERicjB6eHNKVTN1NDFVRHhyWi91SGs4NFhI?=
 =?utf-8?B?NDZjbzJvSnRQbnlBTjBmemtpQjF1V2FhdTlIcElIUEtGTGhWUHRxL0EzcGRo?=
 =?utf-8?B?NUdiVkIyd2IzT3VPdGtXeGo1OThOaGlEazZNa3ZVbUxKN2k3UDlXSjQ5alpo?=
 =?utf-8?B?RCttMEZVTm4zc2Y1TUtqQlJ6dENZQ3h0aTFIUnVBaGNOZlZzQzVOUldsU1VU?=
 =?utf-8?B?SExMVHRtZ3haSGx0RDcrd0xIY090YVp2Ym53aDU1MjJ2d1dNRjZ3aGwzdTdG?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71F28F171B1C3741ACCFA6928D64D1DE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59efe7a-f656-4fea-1877-08db08aed708
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 01:58:42.7864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mcbk8au9s2ibsLUJa2qPupBhIsIvwMF7P5FXGQHkShzesU55FhKsHu7UNE+l4plO6niKmTtxM1M87vVepeaWfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6812
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTMxIGF0IDE3OjUwICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
IE9uIFdlZCwgSmFuIDE4LCAyMDIzIGF0IDExOjE2IEFNIE1vdWR5IEhvIDxtb3VkeS5ob0BtZWRp
YXRlay5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IE1UODE5NSBWUFBTWVMwLzEgd2lsbCBiZSBw
cm9iZWQgYnkgdGhlIGNvbXBhdGlibGUgbmFtZSBpbg0KPiA+IHRoZSBtdGstbW1zeXMgZHJpdmVy
IGFuZCB0aGVuIHByb2JlIGl0cyBvd24gY2xvY2sgZHJpdmVyIGFzDQo+ID4gYSBwbGF0Zm9ybSBk
cml2ZXIuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTW91ZHkgSG8gPG1vdWR5LmhvQG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5NS12
cHAwLmMgfCA1OCArKysrKysrKysrKysrKysrKysrLS0tDQo+ID4gLS0tLQ0KPiA+ICBkcml2ZXJz
L2Nsay9tZWRpYXRlay9jbGstbXQ4MTk1LXZwcDEuYyB8IDU4ICsrKysrKysrKysrKysrKysrKyst
LS0NCj4gPiAtLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgODYgaW5zZXJ0aW9ucygrKSwgMzAg
ZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVr
L2Nsay1tdDgxOTUtdnBwMC5jDQo+ID4gYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTk1
LXZwcDAuYw0KPiA+IGluZGV4IGJmMjkzOWMzYTAyMy4uNmQ1ODAwZjY5ZjZjIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTUtdnBwMC5jDQo+ID4gKysrIGIv
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5NS12cHAwLmMNCj4gPiBAQCAtODYsMjYgKzg2
LDU0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGUgdnBwMF9jbGtzW10gPSB7DQo+ID4g
ICAgICAgICBHQVRFX1ZQUDBfMihDTEtfVlBQMF9XQVJQMV9NRFBfRExfQVNZTkMsDQo+ID4gInZw
cDBfd2FycDFfbWRwX2RsX2FzeW5jIiwgInRvcF93cGVfdnBwIiwgMyksDQo+ID4gIH07DQo+ID4g
DQo+ID4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Nsa19kZXNjIHZwcDBfZGVzYyA9IHsNCj4g
PiAtICAgICAgIC5jbGtzID0gdnBwMF9jbGtzLA0KPiA+IC0gICAgICAgLm51bV9jbGtzID0gQVJS
QVlfU0laRSh2cHAwX2Nsa3MpLA0KPiA+IC19Ow0KPiA+ICtzdGF0aWMgaW50IGNsa19tdDgxOTVf
dnBwMF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICt7DQo+ID4gKyAg
ICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsgICAgICAgc3RydWN0
IGRldmljZV9ub2RlICpub2RlID0gZGV2LT5wYXJlbnQtPm9mX25vZGU7DQo+ID4gKyAgICAgICBz
dHJ1Y3QgY2xrX29uZWNlbGxfZGF0YSAqY2xrX2RhdGE7DQo+IA0KPiBtdGtfYWxsb2NfY2xrX2Rh
dGEoKSBBUEkgY2hhbmdlZCBhIGNvdXBsZSByZWxlYXNlcyBiYWNrLiBTbzoNCj4gDQo+ICAgICAg
ICAgICBzdHJ1Y3QgY2xrX2h3X29uZWNlbGxfZGF0YQ0KPiANCj4gPiArICAgICAgIGludCByOw0K
PiA+IA0KPiA+IC1zdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBvZl9tYXRjaF9jbGtf
bXQ4MTk1X3ZwcDBbXSA9IHsNCj4gPiAtICAgICAgIHsNCj4gPiAtICAgICAgICAgICAgICAgLmNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXZwcHN5czAiLA0KPiA+IC0gICAgICAgICAgICAg
ICAuZGF0YSA9ICZ2cHAwX2Rlc2MsDQo+ID4gLSAgICAgICB9LCB7DQo+ID4gLSAgICAgICAgICAg
ICAgIC8qIHNlbnRpbmVsICovDQo+ID4gLSAgICAgICB9DQo+ID4gLX07DQo+ID4gKyAgICAgICBj
bGtfZGF0YSA9IG10a19hbGxvY19jbGtfZGF0YShDTEtfVlBQMF9OUl9DTEspOw0KPiA+ICsgICAg
ICAgaWYgKCFjbGtfZGF0YSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+
ID4gKw0KPiA+ICsgICAgICAgciA9IG10a19jbGtfcmVnaXN0ZXJfZ2F0ZXMobm9kZSwgdnBwMF9j
bGtzLA0KPiA+IEFSUkFZX1NJWkUodnBwMF9jbGtzKSwgY2xrX2RhdGEpOw0KPiANCj4gQVBJIGNo
YW5nZWQuDQo+IA0KPiA+ICsgICAgICAgaWYgKHIpDQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8g
ZnJlZV92cHAwX2RhdGE7DQo+ID4gKw0KPiA+ICsgICAgICAgciA9IG9mX2Nsa19hZGRfcHJvdmlk
ZXIobm9kZSwgb2ZfY2xrX3NyY19vbmVjZWxsX2dldCwNCj4gPiBjbGtfZGF0YSk7DQo+IA0KPiAg
ICAgICAgICAgICAgIG9mX2Nsa19hZGRfcHJvdmlkZXIobm9kZSwgb2ZfY2xrX2h3X29uZWNlbGxf
Z2V0LA0KPiBjbGtfZGF0YSk7DQo+IA0KPiBTYW1lIGZvciB0aGUgb3RoZXIgZHJpdmVyLg0KPiAN
Cj4gDQo+IENoZW5ZdQ0KPiANCg0KSGkgQ2hlbll1LA0KDQpUaGFua3MgZm9yIHRha2luZyB0aGUg
dGltZSwgY291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGUgdjc/DQoNCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzAyMDcwMTQ4MDAuNzYxOS0xLW1vdWR5LmhvQG1lZGlh
dGVrLmNvbS8NCg0KUmVnYXJkcywNCk1vdWR5DQo+ID4gKyAgICAgICBpZiAocikNCj4gPiArICAg
ICAgICAgICAgICAgZ290byB1bnJlZ2lzdGVyX2dhdGVzOw0KPiA+ICsNCj4gPiArICAgICAgIHBs
YXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGNsa19kYXRhKTsNCj4gPiArDQo+ID4gKyAgICAgICBy
ZXR1cm4gcjsNCj4gPiArDQo+ID4gK3VucmVnaXN0ZXJfZ2F0ZXM6DQo+ID4gKyAgICAgICBtdGtf
Y2xrX3VucmVnaXN0ZXJfZ2F0ZXModnBwMF9jbGtzLCBBUlJBWV9TSVpFKHZwcDBfY2xrcyksDQo+
ID4gY2xrX2RhdGEpOw0KPiA+ICtmcmVlX3ZwcDBfZGF0YToNCj4gPiArICAgICAgIG10a19mcmVl
X2Nsa19kYXRhKGNsa19kYXRhKTsNCj4gPiArICAgICAgIHJldHVybiByOw0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgaW50IGNsa19tdDgxOTVfdnBwMF9yZW1vdmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0g
JnBkZXYtPmRldjsNCj4gPiArICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IGRldi0+
cGFyZW50LT5vZl9ub2RlOw0KPiA+ICsgICAgICAgc3RydWN0IGNsa19od19vbmVjZWxsX2RhdGEg
KmNsa19kYXRhID0NCj4gPiBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gPiArDQo+ID4g
KyAgICAgICBvZl9jbGtfZGVsX3Byb3ZpZGVyKG5vZGUpOw0KPiA+ICsgICAgICAgbXRrX2Nsa191
bnJlZ2lzdGVyX2dhdGVzKHZwcDBfY2xrcywgQVJSQVlfU0laRSh2cHAwX2Nsa3MpLA0KPiA+IGNs
a19kYXRhKTsNCj4gPiArICAgICAgIG10a19mcmVlX2Nsa19kYXRhKGNsa19kYXRhKTsNCj4gPiAr
DQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+IA0KPiA+ICBzdGF0aWMgc3RydWN0
IHBsYXRmb3JtX2RyaXZlciBjbGtfbXQ4MTk1X3ZwcDBfZHJ2ID0gew0KPiA+IC0gICAgICAgLnBy
b2JlID0gbXRrX2Nsa19zaW1wbGVfcHJvYmUsDQo+ID4gLSAgICAgICAucmVtb3ZlID0gbXRrX2Ns
a19zaW1wbGVfcmVtb3ZlLA0KPiA+ICsgICAgICAgLnByb2JlID0gY2xrX210ODE5NV92cHAwX3By
b2JlLA0KPiA+ICsgICAgICAgLnJlbW92ZSA9IGNsa19tdDgxOTVfdnBwMF9yZW1vdmUsDQo+ID4g
ICAgICAgICAuZHJpdmVyID0gew0KPiA+ICAgICAgICAgICAgICAgICAubmFtZSA9ICJjbGstbXQ4
MTk1LXZwcDAiLA0KPiA+IC0gICAgICAgICAgICAgICAub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRj
aF9jbGtfbXQ4MTk1X3ZwcDAsDQo+ID4gICAgICAgICB9LA0KPiA+ICB9Ow0KPiA+ICBidWlsdGlu
X3BsYXRmb3JtX2RyaXZlcihjbGtfbXQ4MTk1X3ZwcDBfZHJ2KTsNCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5NS12cHAxLmMNCj4gPiBiL2RyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdDgxOTUtdnBwMS5jDQo+ID4gaW5kZXggZmZkNTJjNzYyODkwLi4zYjg4
YzY5ZTk2YzkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5
NS12cHAxLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTk1LXZwcDEu
Yw0KPiA+IEBAIC04NCwyNiArODQsNTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSB2
cHAxX2Nsa3NbXSA9IHsNCj4gPiAgICAgICAgIEdBVEVfVlBQMV8xKENMS19WUFAxX1ZQUF9TUExJ
VF8yNk0sICJ2cHAxX3ZwcF9zcGxpdF8yNm0iLA0KPiA+ICJjbGsyNm0iLCAyNiksDQo+ID4gIH07
DQo+ID4gDQo+ID4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Nsa19kZXNjIHZwcDFfZGVzYyA9
IHsNCj4gPiAtICAgICAgIC5jbGtzID0gdnBwMV9jbGtzLA0KPiA+IC0gICAgICAgLm51bV9jbGtz
ID0gQVJSQVlfU0laRSh2cHAxX2Nsa3MpLA0KPiA+IC19Ow0KPiA+ICtzdGF0aWMgaW50IGNsa19t
dDgxOTVfdnBwMV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICt7DQo+
ID4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsgICAgICAg
c3RydWN0IGRldmljZV9ub2RlICpub2RlID0gZGV2LT5wYXJlbnQtPm9mX25vZGU7DQo+ID4gKyAg
ICAgICBzdHJ1Y3QgY2xrX29uZWNlbGxfZGF0YSAqY2xrX2RhdGE7DQo+ID4gKyAgICAgICBpbnQg
cjsNCj4gPiANCj4gPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgb2ZfbWF0Y2hf
Y2xrX210ODE5NV92cHAxW10gPSB7DQo+ID4gLSAgICAgICB7DQo+ID4gLSAgICAgICAgICAgICAg
IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS12cHBzeXMxIiwNCj4gPiAtICAgICAgICAg
ICAgICAgLmRhdGEgPSAmdnBwMV9kZXNjLA0KPiA+IC0gICAgICAgfSwgew0KPiA+IC0gICAgICAg
ICAgICAgICAvKiBzZW50aW5lbCAqLw0KPiA+IC0gICAgICAgfQ0KPiA+IC19Ow0KPiA+ICsgICAg
ICAgY2xrX2RhdGEgPSBtdGtfYWxsb2NfY2xrX2RhdGEoQ0xLX1ZQUDFfTlJfQ0xLKTsNCj4gPiAr
ICAgICAgIGlmICghY2xrX2RhdGEpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVN
Ow0KPiA+ICsNCj4gPiArICAgICAgIHIgPSBtdGtfY2xrX3JlZ2lzdGVyX2dhdGVzKG5vZGUsIHZw
cDFfY2xrcywNCj4gPiBBUlJBWV9TSVpFKHZwcDFfY2xrcyksIGNsa19kYXRhKTsNCj4gPiArICAg
ICAgIGlmIChyKQ0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGZyZWVfdnBwMV9kYXRhOw0KPiA+
ICsNCj4gPiArICAgICAgIHIgPSBvZl9jbGtfYWRkX3Byb3ZpZGVyKG5vZGUsIG9mX2Nsa19zcmNf
b25lY2VsbF9nZXQsDQo+ID4gY2xrX2RhdGEpOw0KPiA+ICsgICAgICAgaWYgKHIpDQo+ID4gKyAg
ICAgICAgICAgICAgIGdvdG8gdW5yZWdpc3Rlcl9nYXRlczsNCj4gPiArDQo+ID4gKyAgICAgICBw
bGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBjbGtfZGF0YSk7DQo+ID4gKw0KPiA+ICsgICAgICAg
cmV0dXJuIHI7DQo+ID4gKw0KPiA+ICt1bnJlZ2lzdGVyX2dhdGVzOg0KPiA+ICsgICAgICAgbXRr
X2Nsa191bnJlZ2lzdGVyX2dhdGVzKHZwcDFfY2xrcywgQVJSQVlfU0laRSh2cHAxX2Nsa3MpLA0K
PiA+IGNsa19kYXRhKTsNCj4gPiArZnJlZV92cHAxX2RhdGE6DQo+ID4gKyAgICAgICBtdGtfZnJl
ZV9jbGtfZGF0YShjbGtfZGF0YSk7DQo+ID4gKyAgICAgICByZXR1cm4gcjsNCj4gPiArfQ0KPiA+
ICsNCj4gPiArc3RhdGljIGludCBjbGtfbXQ4MTk1X3ZwcDFfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9
ICZwZGV2LT5kZXY7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBkZXYt
PnBhcmVudC0+b2Zfbm9kZTsNCj4gPiArICAgICAgIHN0cnVjdCBjbGtfaHdfb25lY2VsbF9kYXRh
ICpjbGtfZGF0YSA9DQo+ID4gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ID4gKw0KPiA+
ICsgICAgICAgb2ZfY2xrX2RlbF9wcm92aWRlcihub2RlKTsNCj4gPiArICAgICAgIG10a19jbGtf
dW5yZWdpc3Rlcl9nYXRlcyh2cHAxX2Nsa3MsIEFSUkFZX1NJWkUodnBwMV9jbGtzKSwNCj4gPiBj
bGtfZGF0YSk7DQo+ID4gKyAgICAgICBtdGtfZnJlZV9jbGtfZGF0YShjbGtfZGF0YSk7DQo+ID4g
Kw0KPiA+ICsgICAgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiANCj4gPiAgc3RhdGljIHN0cnVj
dCBwbGF0Zm9ybV9kcml2ZXIgY2xrX210ODE5NV92cHAxX2RydiA9IHsNCj4gPiAtICAgICAgIC5w
cm9iZSA9IG10a19jbGtfc2ltcGxlX3Byb2JlLA0KPiA+IC0gICAgICAgLnJlbW92ZSA9IG10a19j
bGtfc2ltcGxlX3JlbW92ZSwNCj4gPiArICAgICAgIC5wcm9iZSA9IGNsa19tdDgxOTVfdnBwMV9w
cm9iZSwNCj4gPiArICAgICAgIC5yZW1vdmUgPSBjbGtfbXQ4MTk1X3ZwcDFfcmVtb3ZlLA0KPiA+
ICAgICAgICAgLmRyaXZlciA9IHsNCj4gPiAgICAgICAgICAgICAgICAgLm5hbWUgPSAiY2xrLW10
ODE5NS12cHAxIiwNCj4gPiAtICAgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0
Y2hfY2xrX210ODE5NV92cHAxLA0KPiA+ICAgICAgICAgfSwNCj4gPiAgfTsNCj4gPiAgYnVpbHRp
bl9wbGF0Zm9ybV9kcml2ZXIoY2xrX210ODE5NV92cHAxX2Rydik7DQo+ID4gLS0NCj4gPiAyLjE4
LjANCj4gPiANCg==
