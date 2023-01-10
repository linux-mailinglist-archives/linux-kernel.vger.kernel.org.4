Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E98A6638A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjAJFfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAJFf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:35:26 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D0E1097;
        Mon,  9 Jan 2023 21:35:23 -0800 (PST)
X-UUID: 3b7c65d8fba44c778115e6743b598870-20230110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0MjHVZQWJFkLf6rDngDjB+i96wABPRSSNf7E1+KsjW0=;
        b=PrQre8/fS04jKIU3wDIsWnFrc5sK9lBlIvEjE/49kZWXErfoj6uXqObSV7+GN0DQDGCOiJ5IO51yJ41FtrY9qFuFTzI4rgJdEIXAQ+Z4ihzlokz7BkPZzNCo1dWDnA2/fjDgbGUBIF5fXuC48RbrvUq2nAPPu9kNPvPERo7Pyj8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:17784585-b4b5-4386-a8a3-7ca80affb323,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.17,REQID:17784585-b4b5-4386-a8a3-7ca80affb323,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:543e81c,CLOUDID:9765cb8b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230110133042YU1ITUX5,BulkQuantity:7,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0
X-UUID: 3b7c65d8fba44c778115e6743b598870-20230110
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 630641750; Tue, 10 Jan 2023 13:35:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 10 Jan 2023 13:35:18 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 10 Jan 2023 13:35:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHbrcosimRFlqXXavvUezZ5G2JczVei6yW0nqBYrTCbb9hvIDjGOa6IPR7L4XVcQKXYNgZiTC5fWAvEMaitlBm1qeleEsu5eSLMXekeTC88SHqOJKpvyVIO33goOSzsZQkg1v4HL+xDphQdmKXSblN77OfXY0BARn8YgjifFWroarZMtUioWMtJ9QHezEUhAyfUtQ/2p09dt8IinI8978mTN0scNfYiQL9gJPQRxeAMWgdBDoCK1MEPOqozp7oXTK6xh6tRRU/tFmenXyJm5INbCyZq8khh6LMT4P8rmTZYg7hqsF8EML2Zk4Ptu77hWVLi4tRX7G0DnjRUtrl5Jeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MjHVZQWJFkLf6rDngDjB+i96wABPRSSNf7E1+KsjW0=;
 b=aHJl0kM36h5Jg+scA7mv569WQufTolJdtU2FJ5LRONPSLRmMwr2aidpTeJAkTrUj9aT8ugBqoPP5Pgd1OWylAm0nsuO+GUMhX7I/DwgWqL7KnQq/7qL/TQTE1QaQm6dBeZlw8FiUWAI/jrOX1DNqxEO4nRfksCzsSKtHCBvV78k/FqRyuM0IMRh6o5PK87nCJm2aMcJ+EPV4ra+tbZrSZ64GGmFsfz14veRjmU7GH6J3ZAhowBfqArXn6tad9cqURvaUkFqE90HUMWphohVrM3je5ZVkY2GZOIyLm5oKnyhoCorrUzthqnfiH4TWkC0B3QLueEOSNdTMX2NXJbO70Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MjHVZQWJFkLf6rDngDjB+i96wABPRSSNf7E1+KsjW0=;
 b=QldspQVhQwNzl2/CzFu5g2iHRjGm5STsUX/sC5ieq7UUr4vmHFNdywMRelwXZl7/3SfpQRFvcgtE9amShcdSe1XkF6JwaLzhvo8nLTTAINVgywzMvjcvU7yHmOHEOOCU03SpwqdooUwROoCiIHHQM2mkXG3OnkIFwR+BYOwj9Zg=
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com (2603:1096:4:26::14) by
 SI2PR03MB6589.apcprd03.prod.outlook.com (2603:1096:4:1e1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 05:35:16 +0000
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::58b9:b6cb:6595:bbbf]) by SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::58b9:b6cb:6595:bbbf%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 05:35:16 +0000
From:   =?utf-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>
To:     "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "drinkcat@google.com" <drinkcat@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>,
        =?utf-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>
Subject: Re: [PATCH v1 13/13] soc: mediatek: mtk-svs: keep svs alive even
 though debug cmd create fail
Thread-Topic: [PATCH v1 13/13] soc: mediatek: mtk-svs: keep svs alive even
 though debug cmd create fail
Thread-Index: AQHZGQ5+vNKFCAwwHU6hiT/nGjkjK66MsY4AgAqG9oA=
Date:   Tue, 10 Jan 2023 05:35:16 +0000
Message-ID: <69748230f8fa79e4eb26bf12d9e163677d18ec96.camel@mediatek.com>
References: <20221226094248.4506-1-roger.lu@mediatek.com>
         <20221226094248.4506-14-roger.lu@mediatek.com>
         <2f4a78f8-9cdd-9e44-20a2-b3bd6abd5cc7@collabora.com>
In-Reply-To: <2f4a78f8-9cdd-9e44-20a2-b3bd6abd5cc7@collabora.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3434:EE_|SI2PR03MB6589:EE_
x-ms-office365-filtering-correlation-id: 3f724938-9225-4107-ea1d-08daf2cc7449
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OcySf0T+sW6MBDoRcXbMOvUn8NKFQGnfDJUZqdXGKoJDZbffVSczlMSKUoWOrTngnQdL+QIm4/Nds0oe540MKsqDD1jLFo0vRP+STe9Beqfpt2bp8Rl1Ox+80CqXbkxtwYGGyEkyqIP8e7vzS47sBEF/JWQC9J3SN7N1pAqPtRUD8AxDES7YXDkCy21WCHFkYM8ig48rUD4wvGKVdu428P5A29R8X0xDshSTLvf1wbsBCdd00G6rhC4myjKFrjvCqokIwG4ebP3TCyHUraAywge62YqXTmzi4zYo7RFX50EYxNtC/uYhmlnEY42KTvZ0lX50qeRiBfGfYHZ6EfWKdUoJBxTJu9jZHnAjGAOTjacsgVUqXS8DvpiuP9iYuU/5oBUWrzKCPMUhDA+Q0hz7qW+hTQwmBj20gzyHIyG23NAdDU7+36Os9keZZEvXcD5yBtW/6vPjsnk9uTxOTHWWh6TXLZp2e4aMGvfe4I7+I5qSJL2jO2WMulKCYTtM7TbuhWYOwcSMvgVzm+Hw00ewirwEbMpOPIM2CduvfQVP21tqm1/hG0q/eGmVLirqUwmpmeYV6nWumM3z8ahe70kSIru0/cB2jgf2SLtWl7wrgc4dnr7DNURTM/IXw0RqFQj8nOytEPxIDxCYAB1K2VDL8SuetMINUknWSlEOfXy/QTe7UEYA2Be/1aUmrDlvRisPBf5H5oFJTGgl8VYUzu79mch/SQN3EcMXdrcwLiFtbRhFS5jQF/wG9ESa7MqGhX7f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3434.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(2906002)(71200400001)(6506007)(6486002)(478600001)(6512007)(107886003)(26005)(186003)(110136005)(54906003)(316002)(36756003)(64756008)(85182001)(66946007)(66446008)(66556008)(76116006)(8676002)(66476007)(4326008)(41300700001)(2616005)(8936002)(5660300002)(122000001)(38100700002)(7416002)(83380400001)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUg0cDlsQlNicU1lZzZFWm1hbDFwSWpQUUlOTUZyVi94RDRLMWxDSEJOd3dC?=
 =?utf-8?B?K3ZaYmxNckd2YndKM3NqY3Nzc1ZncVNUL29NNjhWeHQwNjVLR0JtbUdIaks5?=
 =?utf-8?B?RUV4MWlEckMyOXA4MWFLTFJYQ0lyUkRMWUdoSytXZlJpU1Y2VFNDL1d0L294?=
 =?utf-8?B?R2x6T056K0FvUGt5NTR5d1lTTHlrVFVKZEpSQmxYRU1GK1M2MHRpSzBiZzBG?=
 =?utf-8?B?SWl0RFZKd2MyUEpYdkx6Tjc5TllYSlV4dEREcFRLdGVFSHRKOUxabEtqZS9Q?=
 =?utf-8?B?NkpSYk9MRnRnYVh5blBVNytUVm1GMFdVMFdJdHF5ZFlZYlUzVkVtWFEwbzNp?=
 =?utf-8?B?UTU2UUEyYkJ6N2svZWhzQkl3dmJoUUFFSDNhSlJiZ0NYbUVwYUFhSGVIb1Za?=
 =?utf-8?B?bkMwMFluY1VqODNIRGlqM3F4WGxWU3ZtSWZpbHIwalZqZU0xSlI4aTZiWERj?=
 =?utf-8?B?ekRLSWdGWGhFdnZ3M1NmUHBUNVh1YWtYK3FlTUxZS3M3TGhXbVhHQ3JSOGdM?=
 =?utf-8?B?NUYzRVY3SXpqZ2kvMDBtTFU4LzlRMXFUNzlIc1RSN29pVEdGV1A2ZGljNmU4?=
 =?utf-8?B?UVhsQjVFdUowV3Z4Sk9XVS9KWFNGYUl1VGFWWWhQV1I3VC96TTBPNEJmRXJI?=
 =?utf-8?B?N3BVOXVZVjQxbW9vbDk1TEtKazhpTjZYOVVVMzliNkJHbFhad2o3WGl5U0Ju?=
 =?utf-8?B?dko5VVQzL1owbUFnOHdOUlpoQ2VJTEJWZVRnWEkzcmdIYjVIZ2l0cFFveGlH?=
 =?utf-8?B?SVJRam1LR2tQek0xL3dxNXZBL3E2NFlvNlpaRkxMSUs0YVMyUmJBTXpKY2pP?=
 =?utf-8?B?UlZ4SEZwZU1zMzkzZnh6SW16OUJ1bzluZHByRTJ6LzF0ZU9xZzdKTU5xa1Fo?=
 =?utf-8?B?K0lvVFBjbHBRd2tjMEFUdE9Cd01xbFRRWENxa1hjTnVtZ29MRlQ2UVA2dzIr?=
 =?utf-8?B?U3dwNzdtMGJwSXBhZmhiQW9hN2ZtaGpCT1N4OW9JMDRYOXdLb053bitmbk5N?=
 =?utf-8?B?dlN1NWh4c1c2UGxlQWxLSG92UmxDYXdHeGp2OEFBdVBEc3RUOExQWHFJWHdr?=
 =?utf-8?B?M1U1SUF4Q1ZNTXk4R01xNTNvdUw5dC94djRmcU5FbEV2SXROeVNkdW5HR1Ns?=
 =?utf-8?B?QXNEbmdjdXRkRzlMeVNva2FSRnV5N1BqTERzUWd0YnoxT2VsOXlPS3pqaWNz?=
 =?utf-8?B?YWRnakRsSHQ5NVo4Tm5adlRBN2h6SURsOVhOMmNOWlBLSTVsbVkwZW9VSHEr?=
 =?utf-8?B?MmZhYWFyWEhlaitISVBKaUhCVS90UTJqdkxxTnA2c2pUSExiOXpwdEJYc0ZM?=
 =?utf-8?B?ak1hZnB5YWhBSHVOU1paVTJaU0hWcFNqK0pVSWc5RCsydWc5aFA4WVBERGQ3?=
 =?utf-8?B?WlgvZGlnTEZBcGRlWjR2bkhISG5hTE1VWm9SUnVQczE3NXRBY1p1aXBqSHdC?=
 =?utf-8?B?T2d0VWFLb3RHT01ZdStJNXdsRFpGZkhkS3k4THdsVDNqWUIvaHZKaWhRSXA0?=
 =?utf-8?B?c1pxRy9WUisvNkxVN1Nnd0JBRHl2NithVUsxa0NsYXoreUNVN2djbGVLallV?=
 =?utf-8?B?bkNKNzI1SCtYZFJ5TDZiYXdjRmM3SVFubHhBVkpQYjRlMXNxeTdsUzlVRzc2?=
 =?utf-8?B?SklIVFNCMVVhVHBxZzBOOW9XeXArazZaWkozenZIUjdGazBySmgzNncwL1BH?=
 =?utf-8?B?cDBCblJxd0o0WE1LQkZoUm5JZ2piZ0ExSkpvT0pLMGpKamszeTJITm1hQnFG?=
 =?utf-8?B?TjRCKytnT0lPK2xPUkp2Y0Z3Sm1uc1d3ZjR4S0gzUXAva0tTajVCSlp0T25q?=
 =?utf-8?B?WEEvTmJ5RVJ5ZFRBalVidjdFbjRDUVpaQTVpN1owWWtxVWgwWXVDUFUwUW5x?=
 =?utf-8?B?ekxXUzd2L2s1M0FxS2pmdGo5bzZXd25jbjFFc0hFTWRJQktwdHFIQXdiOHZj?=
 =?utf-8?B?aDZGbmEwejlTUTB4b2RHMnhVaXZBUVNhRjNLcFFhK05wMHR1L2tRbG54bnU0?=
 =?utf-8?B?QXRkQy9aYVFudis5VFVlTVRqTjJHSXpDMlY3dXY2ZGJWbWo0VDl2d0c4N0Ra?=
 =?utf-8?B?NnZjVmlId05aTUU1NllONkxnRkNVN3hYaTIxVEphelAraytKaTUxTDg4WGNw?=
 =?utf-8?B?ZlNPS3RYWTd5M3pMcXBZWGIvY1NZUEF3d0w2Mm5mN0lpSGJUY2JvUUhvQTMr?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E91044B716436446A8981E7C211C52BA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3434.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f724938-9225-4107-ea1d-08daf2cc7449
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 05:35:16.4129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Ab8R/RydnXCpVCAMAGyLwiVtKO5yTDSvov+hM23BZNfezO6h4Jej4aM/PvkNxCz4coR9ck/GA6Aw9QPmh5gtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6589
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5IGFuZCB0aGFu
a3MgZm9yIHRoZSBhZHZpY2VzIGFsd2F5cy4NCg0KT24gVHVlLCAyMDIzLTAxLTAzIGF0IDEzOjQ5
ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMjYvMTIvMjIg
MTA6NDIsIFJvZ2VyIEx1IGhhIHNjcml0dG86DQo+ID4gU29tZSBwcm9qZWN0cyBtaWdodCBub3Qg
c3VwcG9ydCBERUJVR19GUyBidXQgc3RpbGwgbmVlZHMgc3ZzIHRvIGJlDQo+ID4gc3VwcG9ydGVk
LiBUaGVyZWZvcmUsIGtlZXAgc3ZzIGFsaXZlIGV2ZW4gdGhvdWdoIGRlYnVnIGNtZCBjcmVhdGUg
ZmFpbC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBMdSA8cm9nZXIubHVAbWVkaWF0
ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXN2cy5jIHwg
NCArLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25z
KC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zdnMu
YyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zdnMuYw0KPiA+IGluZGV4IGFmM2ExMmUyOWU3
OC4uYzc4MGExMTU1NDNlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1zdnMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zdnMuYw0KPiA+IEBA
IC0yMzkwLDEwICsyMzkwLDggQEAgc3RhdGljIGludCBzdnNfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gPiAgIAl9DQo+ID4gICANCj4gDQo+IEluc3RlYWQgb2YgaWdub3Jp
bmcgYSBwbGFubmVkIGZhaWx1cmUsIGl0J3Mgc2Vuc2libGUgdG8gbm90IGZhaWwgYXQgYWxsOg0K
PiBlbmNsb3NlIHRoaXMgY2FsbCBhbmQgdGhlIHN2c19jcmVhdGVfZGVidWdfY21kcygpIGZ1bmN0
aW9uIGluIGFuIGlmZGVmLg0KPiANCj4gI2lmZGVmIENPTkZJR19ERUJVR19GUw0KPiANCj4gPiAg
IAlyZXQgPSBzdnNfY3JlYXRlX2RlYnVnX2NtZHMoc3ZzcCk7DQo+ID4gLQlpZiAocmV0KSB7DQo+
ID4gKwlpZiAocmV0KQ0KPiA+ICAgCQlkZXZfZXJyKHN2c3AtPmRldiwgInN2cyBjcmVhdGUgZGVi
dWcgY21kcyBmYWlsOiAlZFxuIiwgcmV0KTsNCj4gPiAtCQlnb3RvIHN2c19wcm9iZV9pb3VubWFw
Ow0KPiA+IC0JfQ0KPiANCj4gI2VuZGlmDQoNCk9rYXkuIEkgZ290IGl0IGFuZCB3aWxsIGFkZCBp
ZmRlZiBDT05GSUdfREVCVUdfRlMgaW4gbXRrLXN2cy5jIHRvIG1ha2Ugc3VyZSBubw0Kb3RoZXIg
c2lkZSBlZmZlY3RzLg0KDQo+IA0KPiA+ICAgDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICANCj4g
PiANCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCj4gDQo=
