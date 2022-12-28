Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268326573A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiL1H3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiL1H3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:29:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC83F5AF;
        Tue, 27 Dec 2022 23:29:31 -0800 (PST)
X-UUID: 58f3addc7852466ab07aefa6fbb85da9-20221228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0kCKIEfPvm8LLneE/wXqHve8xBrCDQvOgrSMdYyy73A=;
        b=asx4JXMJD92axxMrrRIifwSaNA1Xv56hkGUq9aJQj6WOnE5so9Fc++A9THxDUrtz2+m35FWwbp+PDmHzEL0m1SDB4VpsfBIhRsc2MxGJ+5Dg1DJ7fn5kLcGormXlFxcTvywUQCa5gMNW1PJbhfk+WBA9aaaCgrL9rBdLewHH+xE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:1a28a34b-421c-40fa-8b7a-1b4c7c3f5920,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:96f42bf4-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 58f3addc7852466ab07aefa6fbb85da9-20221228
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <kyrie.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 717214030; Wed, 28 Dec 2022 15:29:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 28 Dec 2022 15:29:23 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 28 Dec 2022 15:29:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqeeP5R0SaBHC7t+aGqKRBN7TqfWKF6jS7kZRvKDtavYUCdvQBnkvM8EU74nWKKcYvemNNY6WODq7LXJymTcBClyJm5pZ0K2wN07JMCc2b0HOplJISRWjN6HWUOl/3CwuocYq90M+cZgRMDEygfz5+mgEPkHwDlwbO0b8iof/mOyYu+9zx0v/uI5xsxfRtbCqxHveJUpPy1jJOd5W7yCFmWEDdURsS2S/vZtcTl6K8h8a0P9dcfPLtybPcx+hftUEid0TxD5S/qc6QLEyDqyiWiDeaDCIRW+7Uafh7xF/Ut4rXjJV21n3b/heGD1AlhY1nKHqeheYR7sTgYjQetPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kCKIEfPvm8LLneE/wXqHve8xBrCDQvOgrSMdYyy73A=;
 b=ggi9YsFlGxoOuW8ZVW7uGlCQenVSxoeknG/Bv4GO6USHH1rzLsscZtkN+4DEF3D+OAszA9ZUOOwqcfqeE1s/lEG1AaJCSgJSOOESYgRFkunBfgNxs12iWwaxwG8TUcQStxDipUk4zKKJxrZUvNm+283KVLEW025jtQYZptz2HjtjI6qBqtaZIaF59amIXD8MBiBkzKMTTvSqcGJ4zaSUimeBwmz+l6WWM2MovakDlIE7x3RUJXsef5iF5Zyms8hIRu2+SzgZuNThp63zPdw5OemGx6b2JYY+iCFW16CLjgrSy/wS9pHZ/vzKXnYOYRmCMI3JRXDCCmTOVJAOOgeCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kCKIEfPvm8LLneE/wXqHve8xBrCDQvOgrSMdYyy73A=;
 b=ayHWNhDfP68vtpTnOxb0nPVfG7qTQrwREv07wsh2oWqtbSe3GwIo9melUECMj4iBCvrATCEmMS58xvgQeZacpbZpl9pnozwOvodFtJBzEKzNXV26zvvRg/dyXaxEjYWe1ljz2z+Y7VYGT1ls4DxMPG5qjiFqngfIRxIG2lpaF2U=
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com (2603:1096:301:b9::5)
 by PSAPR03MB5448.apcprd03.prod.outlook.com (2603:1096:301:44::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 07:29:22 +0000
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::c77c:2f56:104e:3ffd]) by PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::c77c:2f56:104e:3ffd%7]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 07:29:22 +0000
From:   =?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>
To:     "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        =?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?WGlhIEppYW5nICjmsZ/pnJ4p?= <Xia.Jiang@mediatek.com>
Subject: Re: [V2] media: jpeg: Fix multi-hw judgement
Thread-Topic: [V2] media: jpeg: Fix multi-hw judgement
Thread-Index: AQHZEQHzckg8C/GLFkqeWepbendq8q52j8OAgAxqbAA=
Date:   Wed, 28 Dec 2022 07:29:21 +0000
Message-ID: <52c48ab759bc9edc129774d7dfb745deaeaa174a.camel@mediatek.com>
References: <20221216035247.18816-1-irui.wang@mediatek.com>
         <4c198fb0-48a7-2e4d-3363-7eac47a0d5a7@collabora.com>
In-Reply-To: <4c198fb0-48a7-2e4d-3363-7eac47a0d5a7@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB6186:EE_|PSAPR03MB5448:EE_
x-ms-office365-filtering-correlation-id: 1d4928ad-3d58-4d8b-0a7c-08dae8a53d2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjZP2PKa37AR2Pg8IWQ6A4XKwlykG7cIenQeb3vPZOjzjingMmzK5kcEVa1NLahh/W1U5XAoG0EZhQ1r9qO0TWe91zKq3IWlcY9kMhwy8AOSzYd2U7CUd3CpSpN4aLb4Kxfm1Rp8/BqbnPoyPzhkHh41admMvE2Fi7C8esfyG5YzpYRfI3VHbQV/O9/ko3XnhAdM/Z6rICf0C0LGGAmf2cGqcNoENPzpBoBPyGCPrDTaYPpRhDP/5wJRSpWABWukY3HfVTtisKsp+p7xJg4M1We5dyk8FfAlpDI05G1yp/YmJ88qJliFV/0GADQ0yjrTeTZGN0XgPUHOGBKdWVMDxYz2jMHKfjI79HgoCvh/fN4rndYFN+3mPVXYrEvKtEffYa0Lk35jNaT6oyLL+2vBW1WcMwQNr9a6q4Cmjt7IquqlHWJrknyQG9exoI88LNQWuiwwK/5AGpdYnv7aRnCpGHuAYaTkqcwRvTuCARr2CIYVPqwJu3dJ1Y9a2pzk30r6mbhkE9H3q8likzZ7FIiimYHDr5/8owv9pDyeUEyzx2yhpZniD/M7bOGRJZGGCGTMiqfTpIED+GiiHruRySVD+LpWRPXrdaTuyE4VN2XNVhdEmkeXYAjOpk0WnnledH92LwtHczOxxEHOKvjheK1Ajopll8h3jIjJFez7E7iXFOjtwpHJXFrNro/pibMcAgjR3vjuSLd5IeU7jNhchDAP+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6186.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(85182001)(186003)(71200400001)(6512007)(478600001)(6486002)(86362001)(26005)(36756003)(2616005)(38100700002)(38070700005)(122000001)(5660300002)(41300700001)(66446008)(66556008)(64756008)(76116006)(66476007)(7416002)(66946007)(91956017)(6506007)(4326008)(107886003)(54906003)(8676002)(316002)(8936002)(2906002)(4001150100001)(4744005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUY0ZFVjV3U3TktFUXphdWExRGFhcXozT0RITVBLcEx6Uy9qaXNRY0J0ME5h?=
 =?utf-8?B?ODlKK0cybU5nVGducytRdmRDclFsYXUzbUluQUJyUm5GTTZVQnVJSXlaNzhI?=
 =?utf-8?B?M2dMY2MwekVXTER5dlNhNW5jSWZJSGNsYm9jc2FCY1hsdGNPdDFPbVB4dlRn?=
 =?utf-8?B?K1ZvS0dxdlE2L25nMUhmNkFSNUNBKzFtMTZaeitJczVsc0VzL25rZnM4L0hL?=
 =?utf-8?B?bnVTRkptUUp4M3Ixa1A1K3UxN25Gbit1UjdHeUxtYlZ6RHoyNkhDclBSQTRF?=
 =?utf-8?B?UHBBVXpSUGc2T2VxcnNrekZpWnlpZisrQ2ZVZUtzYjRFeUtYbWdscGY1dkZ4?=
 =?utf-8?B?Szl4OHp5cEw5TWpDVjhRc2JoM25oODJmVDFvTGtXWjlBZ0JYVWxIRERhT2Fq?=
 =?utf-8?B?MHU1TTFCRFlUbms5YUEzOXNOLzBQZ29wREx6MEp3bmdFSTdrOHVwT3dUQmdV?=
 =?utf-8?B?WDB3WUJEYnhlMmhCYU1WaU1hcHRDOVB3T2VuUWRDbnMwMjJhQjR0M0ZjZ3o2?=
 =?utf-8?B?OWtYQUVZWGplNmZ5QVFrbmNjTVVMQlNlZU1VbHkreTZpNSt5RVMxQ0ZvZStM?=
 =?utf-8?B?VlBZYW5McGxMN3pLdHVjL1RPaWUwcWkvSXFpR1ZzT2M1clZjcURFWmplSUwr?=
 =?utf-8?B?bTNObC9GYS9jM1lldStoYWh5eDd4eFlaek5XNWpTMVdRWHJFMGJWdnFqWnJu?=
 =?utf-8?B?NytYZXRwQUcxZTdpdnpyRytYazRzdThXSG42VENmcmZvSjA2RUVXb3NQKzY0?=
 =?utf-8?B?bDlZYWxROHM5Q1BkMEFIekNnU0FDN2U1bXJpYmFwNGp2dmtubzROamp1dHdy?=
 =?utf-8?B?emdsTXVST2tXZW43aFJzRUVsOEpNclB6dXM5dE5qQ2krVXVRWUFLU25VeHZW?=
 =?utf-8?B?em1NZXcyNnptTjdET3FWanM2eW1IQURlS045REZOL3lSWUtRaDA1T3NibEtJ?=
 =?utf-8?B?bGJEbjk2NXVPRkczTVdqaktLcXJtRVZDZmlNTjFqSjZudXBaSGlFcnRDL3I1?=
 =?utf-8?B?ZDluTzNqc3dxMzdJTDd2bFV3RFkvbGxPbWhnaWZZM29oWDFGTFJxZktVRDNJ?=
 =?utf-8?B?ZjAvem1CN2FWbGRUcjNDK21LWndOVGhJZHN3Y1lSeUpub3hQMWpURHlvZ2hl?=
 =?utf-8?B?RWpVa2N6V3ZLWUlTTU5HYWxxZGZHUE1PbWIrSjhESHlLL0o2UXBRNXErR05m?=
 =?utf-8?B?STUyTUlTd1FwaUdNYTlYTVE1b0g1RzJIVjIyck85NUFBVFlhTXJCZUR6TVV4?=
 =?utf-8?B?TnMxNjVZZXVUZWl3eHVFNEQvL1FtOGJpazlNYloweU9WVjkwZzVhdVNuM1dE?=
 =?utf-8?B?Y1JRSTFBMk5UdzJzYk9CSWxMcU9EZUJ5bCtCWXpuVE5wV0owZDZhY3lUalRI?=
 =?utf-8?B?NUtqK2xMc2hBYUw2OHlZeVRQLzd4MG9VTVkzR2pHUzVrdzhQMXlsVDVjTmRt?=
 =?utf-8?B?dzNRSFdTVTN0Skp4aG9INVNWZEF1ejdVUWM2Y2VZajBpcWZqWkpkWHFBNHVC?=
 =?utf-8?B?aEJpN0ZoV24wdUJSQ2lsN1djVjdHMTB6WUdWWWp3cU5jaStjSVFmZDVhS1oz?=
 =?utf-8?B?UW90ZDc1R0I1QWRpemtJTjgwaXRwOHlVQmVxekNwMUhxcnZaK0FXTWRON2Vk?=
 =?utf-8?B?TkZUWUc5Umh4VlAvK2VpUjZKdGxBTFRZTEYrdjZBb3Exa3IrUER5eHdFUWV5?=
 =?utf-8?B?MHNUd2ovVVVYT2FYNGtRU2xIWnU5M3g0d0NzeDZRbGI2aEYvV1I3L0hPRWhR?=
 =?utf-8?B?T0U4V3cwT1VvcDZuQUd6NEZieHh0VWcwc2dLSkszTUtOaUNUU0dBQ1RTdXBj?=
 =?utf-8?B?dHFOQUlJRHZYVGZMOXB5YjJaMVpCSDRkUmFVaGRLdjZJUjc0dnYwVVZMb3Fn?=
 =?utf-8?B?YmZaMWVVZ0Q5bWIwSjJHT1loSmdpMmhMSnlUR1k2dUdhZHJWOEF3R3cvV2RP?=
 =?utf-8?B?dVV0OFhaSG1LWW9WYysyTlRuZHBDMk12c0dKUjd5NERJU2g3aTJCc3NuZGJa?=
 =?utf-8?B?bEIzT29RdkNaNkZ3TXpLVVBNUXhraWxOK1FUcHNyTDc0UURnT3Y5Y0YvWlJP?=
 =?utf-8?B?Nlk3a20zMXoxdVhMWVluc1BuU1lENHlUT252WVpkb1Y1QnpPa3BTcFh2K0JQ?=
 =?utf-8?B?K3o3V1BJMG9wSThRNDBlVWxvMHBJZDJQV0kvTHRVWFhQemQwaTZoZHRmREpM?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0439E97139D96479ACE31BBDE985013@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6186.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4928ad-3d58-4d8b-0a7c-08dae8a53d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2022 07:29:21.9628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSTlS1QCuWSWCREgyAZd5lS+xfyy7HC6xBW31cH3diF2H9PLR93RvHknKp7un+lhZOfFkf8d2rAWR46v5OL6OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5448
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEyLTIwIGF0IDEwOjUzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTYvMTIvMjIgMDQ6NTIsIElydWkgV2FuZyBoYSBzY3JpdHRvOg0K
PiA+IEZyb206IGt5cmllIHd1IDxreXJpZS53dUBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gc29t
ZSBjaGlwcyBoYXZlIG11bHRpLWh3LCBidXQgb3RoZXJzIGhhdmUgb25seSBvbmUsDQo+ID4gbW9k
aWZ5IHRoZSBjb25kaXRpb24gb2YgbXVsdGktaHcganVkZ2VtZW50DQo+ID4gDQo+ID4gRml4czog
OTM0ZThiY2NhYzk1ICgibXRrLWpwZWdlbmM6IHN1cHBvcnQganBlZ2VuYyBtdWx0aS1oYXJkd2Fy
ZSIpDQo+IA0KPiBUeXBvLiBzL0ZpeHMvRml4ZXMvZw0KPiANCj4gRml4IHRoYXQsIHBsZWFzZS4N
Cj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCg0KSGkgQW5nZWxvLA0KDQpJIHdpbGwgZml4
IHRoYXQgaXNzdWUgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLg0KDQpSZWdhcmRzLA0K
S3lyaWUuDQo=
