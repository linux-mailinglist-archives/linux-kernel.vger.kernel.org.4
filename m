Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC1F724071
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjFFLE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjFFLDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:03:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9515410E6;
        Tue,  6 Jun 2023 04:03:33 -0700 (PDT)
X-UUID: c3ddc0be045911eeb20a276fd37b9834-20230606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QWpRPgPEVcPXASTyau+JhBDwsM480WQaPYY0V+HmNF8=;
        b=t7cOxXL6PTxokWM5/oF1ug8XzJpBZPwe5F0lO/v1mSc9BOggICc7bLY5Op4IU9xcrtZoppf/UH6YqLF7ybxhqdzYL5SKTZdOdPoLKM+9HJVQ21+oEMruG68HIpje5/eGwjoIyezWwEWccdIMowMFlf8FWU0ygaHcc8x43StoZsE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:4d58de11-243f-46c2-88ae-a7e0a7eca99a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:e78ebd3d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: c3ddc0be045911eeb20a276fd37b9834-20230606
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1390512135; Tue, 06 Jun 2023 19:03:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Jun 2023 19:03:26 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 6 Jun 2023 19:03:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9d+ABZQO0B9klvAtOZjGoU6XUzmm1BrlIN2T10PZlmJz4sudXqBAKnBElw+c4nesSbm8569beaG6g39X6dsTfwfQCklzuWLEkIkwH3h/9IF8NzwcUMscHEjT3gN/i3LtpapWJcHVVlDb3xG7XQX65X9yQyaMOqA1qHf26AnJC5AO43xUuhudhRvX+LOcn+sZz2BYVzEusJrROMGH5sHbilPHRHhs0aBeyBPGqVKw2XBoEPpvFnTj0vI+XorayUmNt2dqUirkmAdN3fUzAS6NiF8NDUqc8clAQZyOHnKcl4npFHuxPijN67xn4UaHKbZrfpFya4Cfy8ggbK5cMSjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWpRPgPEVcPXASTyau+JhBDwsM480WQaPYY0V+HmNF8=;
 b=NLXuPDFKSf2HezZr9+Oa+PMqsn6yeJniOXtgUS/cYcqPrHS/d2svXtrcHzORG5cPxUmONcHf9IrAumiU1FPYSLmMfSBQrErNJXAuwcF9X/IxWd1OMb4sC1lr3SO+2vEiBrydqCAZZckSXVjWSIVWk4np6aS/U5OFXsfGMOU0jGmVCdrn38so014MlsyBfMfTLUC18LiuAplaLlT/0vTP27Wr8WFosjuaSpH/peyoLO8jTyqO45uFf+Eg6Bw10I9fAkV0Sm2Ur+fRyODNSwj9S+HT/gCor/1Fu0ZDU4SLol91TH4VZOGJGvKwuJtsWZya7U+ThKfrKwQADIAYkECtNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWpRPgPEVcPXASTyau+JhBDwsM480WQaPYY0V+HmNF8=;
 b=auUPI1BKjXNihgC13SNGrDjM/iaEYmV/7SPattTskK+apgLvnMjwsm46FPgA1KxHR0TPOej4+u2XiHneavs2woJqo5IZ2jUzSTZvd2FCL/D8Rg0Z5nX1/zT5qLiUNQdufKDzc6bVJyMtKRgT0tVlg+EmqmazLjN335CPoOLLb8M=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by KL1PR03MB7039.apcprd03.prod.outlook.com (2603:1096:820:dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Tue, 6 Jun
 2023 11:03:22 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147%9]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 11:03:22 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4] mmc: mtk-sd: reduce CIT for better performance
Thread-Topic: [PATCH v4] mmc: mtk-sd: reduce CIT for better performance
Thread-Index: AQHZl6dRPPunsFP83kqJ9kXlEUngRq99evKAgAAiwoA=
Date:   Tue, 6 Jun 2023 11:03:22 +0000
Message-ID: <9bb9ec09f17d18081bb07711cf9b5810ab932688.camel@mediatek.com>
References: <20230605121442.23622-1-wenbin.mei@mediatek.com>
         <c47301df-a408-767a-a1ba-ec848a3cc588@intel.com>
In-Reply-To: <c47301df-a408-767a-a1ba-ec848a3cc588@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|KL1PR03MB7039:EE_
x-ms-office365-filtering-correlation-id: 228c61f4-4efd-4b82-dc33-08db667da49e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b50Um/fZ7VLVdQaYWYakj49TYcKFxl5BPFqvUsgB+CQ2k2SfvOwGkRtYlBwBRsmi0O2Mb6KegvAzF/0lHxuNNGpzM4+GF/QP/I27f65WiCB9XWsAG/x19mA6yzt7l6CZMMAJMM3ELQ8Ioj86g4LoSFrSs+tQpxU+lDN36SrY/DRCdN97Fn7B+IzRtNjtiJYVpq55FZLnSRHRA0vWX7Q1Exv1sUHuLYuBbiNz/qDHA2uPTes7i5nFoK62vmF0cC1XVsEzvNLG1yvHkDe9hbqfPBErHLsLb1ZlMUGTE/aWL2OQ+TyeRqTnBoh00JI1/hQeneYY5VnoCJ2D9EB5/AfYOzsQS/AUY/nnjpanT/e8KXiNSgg3tv6wRr7mTt+KN7fuMT51gGsOKQxL0ObB7vRxoF5wz2fRkIM6CXtp/7yQqMuDYq6ASvcjnV3EZAMX1hz7BPrbtMbrHUrxMp3VC5kxvyCtivzflw1W0snG6qjkyFc9jojGXnYQPOtqhk98kAeRn5V8agX/KmU4HSAYh4s7bw8+IB77n+XjfTbbhPdhpkhuLALoJd86NzPI1J8KXUIrMRXyE5XnMbbUGJp2Hkas5fTHwasISPfhyymL3EJRRjS3jfWpxviLAua3GWm6rJ84
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(2616005)(8936002)(8676002)(186003)(41300700001)(2906002)(5660300002)(26005)(6506007)(7416002)(6512007)(53546011)(83380400001)(478600001)(110136005)(316002)(54906003)(6486002)(71200400001)(122000001)(38100700002)(66476007)(86362001)(76116006)(66446008)(66556008)(36756003)(66946007)(85182001)(38070700005)(4326008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHdHdk5tWHUzcmExRTEyazZ6RFAwVTIwWjRBTi9KYzVxSVFUSElWbU1lTEdY?=
 =?utf-8?B?YkdkenpKYStqRzllRnBkcklnSnVvRG93ZmVvWTVoeEdpdmkydkc5Z3RtR2Nv?=
 =?utf-8?B?Q3RKTmZqOVNMUU5JZ25iYTl6NzBTM3VhTHpvTkJNeHB5WnpubXlFdlRhQWll?=
 =?utf-8?B?ZTRkeWhzbkR2VGhFVWxkY2dSSkhOQW9xZk91TlBsUGpUOWU1eGZRUEVRRldl?=
 =?utf-8?B?Sk5JZHE5ZWZsRVk5eng2ekFmeFlkRUZ5YUFDRWZNZEtLeUQwVFZJY1hRT3M0?=
 =?utf-8?B?bmZOUkxadjIvSEZPTnpCWDhybEw2b1c3eW1mK0pVTUMya3VzeG9SQnd2blc4?=
 =?utf-8?B?UmZCMG81UDd4UjNETi81cTU0WE9sT2VxWUNseFZqamJMWndVUTRnK0xmR3ha?=
 =?utf-8?B?M1IvRis4c3QvMTBiUjgvZi9mUU4xdGVNL3g0SXJzbTE2eVdEUEk0ekIxcmwz?=
 =?utf-8?B?R3h1cHV2OFFQVENsRjYvWUVnR0hodjViZHJ0MFVOcTE0U1JyN3FMOG8rb3N3?=
 =?utf-8?B?NlVQb1BlaDBxVStuTElnRWhMT0JHaktiMDRFekNDZXJxQW1tRmNTQ3E5YVN1?=
 =?utf-8?B?MUlEOU8vbi8zbkdkM3UzRHJjY05hQjh3K1R5RENia3VSL1YwenlxbTlBRFdt?=
 =?utf-8?B?RjJOZnZqU0F2cHM4NW5vU1p5eWR6WWRTeDdJY09pR1VmTm12QzB5U1ZUcUNr?=
 =?utf-8?B?Nkl6Ump5aG1GaVJ0RzJheDJjUTFEQ0FmQ2gvbW1UZlhoQzcxNUk3SHJrbHVa?=
 =?utf-8?B?bXhMWGgvcGpwU0VVSlNXU0pxVlFVTWhjODQzRVkwRjdsY2xHeWNtY0JJL1NU?=
 =?utf-8?B?ajNVM0pEYjJnejlOWFVNb3YraUlUNVp5ZkFsaDhvWUMwNW93ZDZpSkJFUllV?=
 =?utf-8?B?aG9adjRJNDJzV2hGNXJ3YWlSc2FuVkJTWnNkZ3p2UXJYVGdaNDI5eHU4MVgx?=
 =?utf-8?B?TjN6S2t4UVl1ZHJjTG1JSmtaN2lZWUtmWnhDSzgyS0k3T2R1Q1NKL0oyYTls?=
 =?utf-8?B?ZTBsMDR0R0RlNkhmMjUyQmM2RHlmSG80RTMrTVZVVWs2UDJ5MVBRaWhwck03?=
 =?utf-8?B?RE9jS1B0VjRRenAwVEJ5SGRwbkU4YXlHTDlxcms5eEExa3l1YWF6dXRKZExV?=
 =?utf-8?B?SnB2S3UxS3hOZHd5c3MrY3ZwUXh2UE1EcCtGYjJ6cWJ1c1dlcWU5TytuV1BW?=
 =?utf-8?B?UUh5RW1hMnhjc1BqSXRQU3JqQVdOUDF1WjVESlVwMC9IdHc3Q3RXa0hPempG?=
 =?utf-8?B?MkZUTWNyVmNrWThNREpOMEdwQUk1bk9tdlhZYjZSVzR5NmxMdFEyUk1OYjJh?=
 =?utf-8?B?YU5pR2RCQ0JrazhIL2J2UUlTTG9NRTRoQkUrQ21lOUJxS3pEMTk5cVNnejY2?=
 =?utf-8?B?MVhKbEZodTErc0VQYml1MkROMnZqb1UzVk9mWTI0UHpxRTVBWXNYYTNNeEd2?=
 =?utf-8?B?dXdVMXN1OXZhNDFIL2V2Q1BRRmxONldxOFRIc3hhbHJmNUFUQlBmdThTdU50?=
 =?utf-8?B?VFVCWVhwZHNabWRTSU5EUStLc3NMZTY2bmVoM2wzQzJ3SU5OWmVKb0NadzZq?=
 =?utf-8?B?bWZvRlM1aEhUd2hESXN2SG5vQ1dMSHM0WXk5VDR4cHBjZGIrOGdlRWNuaXpM?=
 =?utf-8?B?UERsbU1ZZ2hYMTdpdXAzS09XNnpkRi92dVNmL0o2dXZHRGNiMm1JMzYySlZq?=
 =?utf-8?B?eGMrV1VqeVVCTWJubG1qeldkWHNqYXptVnRXT3d2aUtERStDZmQ0aExFNmFs?=
 =?utf-8?B?UFp3TzdBQmJYUlJucGRYRDJ1a2UzRVd0WjZtZHp3V0FVWW1nYWd1eCsyczQy?=
 =?utf-8?B?TVJiS3RtV3BsdCtQeExuR3g0d1RhaXJualBuV3Y3S1lyQkpRUTZzVEhsMi9p?=
 =?utf-8?B?VUYwR2hsTndLdnovZHNydG12eDlvUWhaSStjZDVNaVUvUTJ5WWdKQzBvZ1Y1?=
 =?utf-8?B?azh3MnFXalhDRUtadFBtY3gvUVRHTzFXa3B0cm5JeGNvTitld1licXlsNnJ3?=
 =?utf-8?B?cWFCYkRXN1hIWTZPWnNkYis3LzhjWVpzTFBEN0tHNGM5eVB6WC9tYWJ5NG5j?=
 =?utf-8?B?N3hYaHdxRU1NUEJUV0lVTHFMS2NCcEJldjZPVzYwcHVzcG9naGRHYm42Y0h5?=
 =?utf-8?B?ZUV1MXJzU05aYW1SOG9lOGJQbjFOVU0rODArSGREUG94a3ZhbDhSRUNSMkxu?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B63A9116D8A6F4ABA92911CD039D3FD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228c61f4-4efd-4b82-dc33-08db667da49e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 11:03:22.1625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ykUoc7r8ibal9sZkqqpS5pf3F1R33Nl3h/2jgwisAKtxBF7vKpzc3rKfmaFtZHh9To+8EqNbNIjjVuI3LDn8JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTA2IGF0IDExOjU4ICswMzAwLCBBZHJpYW4gSHVudGVyIHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIE9uIDUvMDYvMjMgMTU6MTQsIFdlbmJpbiBNZWkgd3JvdGU6DQo+ID4g
Q1FIQ0lfU1NDMSBpbmRpY2F0ZXMgdG8gQ1FFIHRoZSBwb2xsaW5nIHBlcmlvZCB0byB1c2Ugd2hl
biB1c2luZw0KPiBwZXJpb2RpYw0KPiA+IFNFTkRfUVVFVUVfU1RBVFVTKENNRDEzKSBwb2xsaW5n
Lg0KPiA+IFNpbmNlIE1TREMgQ1FFIHVzZXMgbXNkY19oY2xrIGFzIElUQ0ZWQUwsIHNvIGRyaXZl
ciBzaG91bGQgdXNlIGhjbGsNCj4gPiBmcmVxdWVuY3kgdG8gZ2V0IHRoZSBhY3R1YWwgdGltZS4N
Cj4gPiBUaGUgZGVmYXVsdCB2YWx1ZSAweDEwMDAgdGhhdCBjb3JyZXNwb25kcyB0byAxNTB1cyBm
b3IgTWVkaWFUZWsNCj4gU29DcywgbGV0J3MNCj4gPiBkZWNyZWFzZSBpdCB0byAweDQwIHRoYXQg
Y29ycmVzcG9uZHMgdG8gMi4zNXVzLCB3aGljaCBjYW4gaW1wcm92ZQ0KPiB0aGUNCj4gPiBwZXJm
b3JtYW5jZSBvZiBzb21lIGVNTUMgZGV2aWNlcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBX
ZW5iaW4gTWVpIDx3ZW5iaW4ubWVpQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9tbWMvaG9zdC9jcWhjaS5oICB8ICAxICsNCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9tdGstc2Qu
YyB8IDQ1DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oIGIvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oDQo+ID4g
aW5kZXggYmE5Mzg3ZWQ5MGViLi4yOTJiODllYmQ5NzggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9tbWMvaG9zdC9jcWhjaS5oDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oDQo+
ID4gQEAgLTIzLDYgKzIzLDcgQEANCj4gPiAgLyogY2FwYWJpbGl0aWVzICovDQo+ID4gICNkZWZp
bmUgQ1FIQ0lfQ0FQMHgwNA0KPiA+ICAjZGVmaW5lIENRSENJX0NBUF9DUzB4MTAwMDAwMDAgLyog
Q3J5cHRvIFN1cHBvcnQgKi8NCj4gPiArI2RlZmluZSBDUUhDSV9DQVBfSVRDRk1VTCh4KSgoKHgp
ICYgR0VOTUFTSygxNSwgMTIpKSA+PiAxMikNCj4gDQo+IExldCdzIG5vdCBvcGVuIGNvZGUgRklF
TERfR0VULCBwZXJoYXBzDQo+IA0KPiAjZGVmaW5lIENRSENJX0NBUF9JVENGTVVMR0VOTUFTSygx
NSwgMTIpDQo+IA0KPiAjZGVmaW5lIENRSENJX0lUQ0ZNVUwoeClGSUVMRF9HRVQoQ1FIQ0lfQ0FQ
X0lUQ0ZNVUwsKHgpKQ0KPiANCk9rYXkuIEkgd2lsbCBjaGFuZ2UgaXQuDQo+ID4gIA0KPiA+ICAv
KiBjb25maWd1cmF0aW9uICovDQo+ID4gICNkZWZpbmUgQ1FIQ0lfQ0ZHMHgwOA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIGIvZHJpdmVycy9tbWMvaG9zdC9tdGst
c2QuYw0KPiA+IGluZGV4IGVkYWRlMGU1NGEwYy4uOWY1NDA5NzNjYWZmIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0
L210ay1zZC5jDQo+ID4gQEAgLTQ3Myw2ICs0NzMsNyBAQCBzdHJ1Y3QgbXNkY19ob3N0IHsNCj4g
PiAgc3RydWN0IG1zZGNfdHVuZV9wYXJhIGRlZl90dW5lX3BhcmE7IC8qIGRlZmF1bHQgdHVuZSBz
ZXR0aW5nICovDQo+ID4gIHN0cnVjdCBtc2RjX3R1bmVfcGFyYSBzYXZlZF90dW5lX3BhcmE7IC8q
IHR1bmUgcmVzdWx0IG9mDQo+IENNRDIxL0NNRDE5ICovDQo+ID4gIHN0cnVjdCBjcWhjaV9ob3N0
ICpjcV9ob3N0Ow0KPiA+ICt1MzIgY3Ffc3NjMV90aW1lOw0KPiA+ICB9Ow0KPiA+ICANCj4gPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfbW1jX2NvbXBhdGlibGUgbXQyNzAxX2NvbXBhdCA9IHsN
Cj4gPiBAQCAtMjQ1MCw5ICsyNDUxLDQ4IEBAIHN0YXRpYyB2b2lkDQo+IG1zZGNfaHM0MDBfZW5o
YW5jZWRfc3Ryb2JlKHN0cnVjdCBtbWNfaG9zdCAqbW1jLA0KPiA+ICB9DQo+ID4gIH0NCj4gPiAg
DQo+ID4gK3N0YXRpYyB2b2lkIG1zZGNfY3FlX2NpdF9jYWwoc3RydWN0IG1zZGNfaG9zdCAqaG9z
dCwgdTY0IHRpbWVyX25zKQ0KPiA+ICt7DQo+ID4gK3N0cnVjdCBtbWNfaG9zdCAqbW1jID0gbW1j
X2Zyb21fcHJpdihob3N0KTsNCj4gPiArc3RydWN0IGNxaGNpX2hvc3QgKmNxX2hvc3QgPSBtbWMt
PmNxZV9wcml2YXRlOw0KPiA+ICt1OCBpdGNmbXVsOw0KPiA+ICt1NjQgaGNsa19mcmVxOw0KPiA+
ICt1NjQgdmFsdWU7DQo+ID4gKw0KPiA+ICsvKiBTaW5jZSBNU0RDIENRRSB1c2VzIG1zZGNfaGNs
ayBhcyBJVENGVkFMLCBzbyBkcml2ZXIgc2hvdWxkIHVzZQ0KPiBoY2xrDQo+ID4gKyAqIGZyZXF1
ZW5jeSB0byBnZXQgdGhlIGFjdHVhbCB0aW1lIGZvciBDSVQuDQo+ID4gKyAqLw0KPiA+ICtoY2xr
X2ZyZXEgPSBjbGtfZ2V0X3JhdGUoaG9zdC0+aF9jbGspOw0KPiA+ICtpdGNmbXVsID0gQ1FIQ0lf
Q0FQX0lUQ0ZNVUwoY3FoY2lfcmVhZGwoY3FfaG9zdCwgQ1FIQ0lfQ0FQKSk7DQo+ID4gK3N3aXRj
aCAoaXRjZm11bCkgew0KPiA+ICtjYXNlIDB4MDoNCj4gPiArZG9fZGl2KGhjbGtfZnJlcSwgMTAw
MCk7DQo+ID4gK2JyZWFrOw0KPiA+ICtjYXNlIDB4MToNCj4gPiArZG9fZGl2KGhjbGtfZnJlcSwg
MTAwKTsNCj4gPiArYnJlYWs7DQo+ID4gK2Nhc2UgMHgyOg0KPiA+ICtkb19kaXYoaGNsa19mcmVx
LCAxMCk7DQo+ID4gK2JyZWFrOw0KPiA+ICtjYXNlIDB4MzoNCj4gPiArYnJlYWs7DQo+ID4gK2Nh
c2UgMHg0Og0KPiA+ICtoY2xrX2ZyZXEgPSBoY2xrX2ZyZXEgKiAxMDsNCj4gPiArYnJlYWs7DQo+
ID4gK2RlZmF1bHQ6DQo+ID4gK2hvc3QtPmNxX3NzYzFfdGltZSA9IDB4NDA7DQo+ID4gK3JldHVy
bjsNCj4gPiArfQ0KPiA+ICsNCj4gPiArdmFsdWUgPSBoY2xrX2ZyZXEgKiB0aW1lcl9uczsNCj4g
PiArZG9fZGl2KHZhbHVlLCAxMDAwMDAwMDAwKTsNCj4gPiAraG9zdC0+Y3Ffc3NjMV90aW1lID0g
dmFsdWU7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyB2b2lkIG1zZGNfY3FlX2VuYWJsZShz
dHJ1Y3QgbW1jX2hvc3QgKm1tYykNCj4gPiAgew0KPiA+ICBzdHJ1Y3QgbXNkY19ob3N0ICpob3N0
ID0gbW1jX3ByaXYobW1jKTsNCj4gPiArc3RydWN0IGNxaGNpX2hvc3QgKmNxX2hvc3QgPSBtbWMt
PmNxZV9wcml2YXRlOw0KPiA+ICANCj4gPiAgLyogZW5hYmxlIGNtZHEgaXJxICovDQo+ID4gIHdy
aXRlbChNU0RDX0lOVF9DTURRLCBob3N0LT5iYXNlICsgTVNEQ19JTlRFTik7DQo+ID4gQEAgLTI0
NjIsNiArMjUwMiw5IEBAIHN0YXRpYyB2b2lkIG1zZGNfY3FlX2VuYWJsZShzdHJ1Y3QgbW1jX2hv
c3QNCj4gKm1tYykNCj4gPiAgbXNkY19zZXRfYnVzeV90aW1lb3V0KGhvc3QsIDIwICogMTAwMDAw
MDAwMFVMTCwgMCk7DQo+ID4gIC8qIGRlZmF1bHQgcmVhZCBkYXRhIHRpbWVvdXQgMXMgKi8NCj4g
PiAgbXNkY19zZXRfdGltZW91dChob3N0LCAxMDAwMDAwMDAwVUxMLCAwKTsNCj4gPiArDQo+ID4g
Ky8qIFNldCB0aGUgc2VuZCBzdGF0dXMgY29tbWFuZCBpZGxlIHRpbWVyICovDQo+ID4gK2NxaGNp
X3dyaXRlbChjcV9ob3N0LCBob3N0LT5jcV9zc2MxX3RpbWUsIENRSENJX1NTQzEpOw0KPiANCj4g
V2hhdCBhYm91dCBTZW5kIFN0YXR1cyBDb21tYW5kIEJsb2NrIENvdW50ZXIgKENCQykgYml0cyAx
OToxNiA/DQo+IA0KTVNEQyBjb250cm9sbGVyIGRvZXMgbm90IHN1cHBvcnQgdGhpcyBmZWF0dXJl
Lg0KPiA+ICB9DQo+ID4gIA0KPiA+ICBzdGF0aWMgdm9pZCBtc2RjX2NxZV9kaXNhYmxlKHN0cnVj
dCBtbWNfaG9zdCAqbW1jLCBib29sIHJlY292ZXJ5KQ0KPiA+IEBAIC0yODAzLDYgKzI4NDYsOCBA
QCBzdGF0aWMgaW50IG1zZGNfZHJ2X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ID4gIC8qIGNxaGNpIDE2Yml0IGxlbmd0aCAqLw0KPiA+ICAvKiAwIHNpemUsIG1lYW5z
IDY1NTM2IHNvIHdlIGRvbid0IGhhdmUgdG8gLTEgaGVyZSAqLw0KPiA+ICBtbWMtPm1heF9zZWdf
c2l6ZSA9IDY0ICogMTAyNDsNCj4gPiArLyogUmVkdWNlIENJVCB0byAweDQwIHRoYXQgY29ycmVz
cG9uZHMgdG8gMi4zNXVzICovDQo+ID4gK21zZGNfY3FlX2NpdF9jYWwoaG9zdCwgMjM1MCk7DQo+
ID4gIH0NCj4gPiAgDQo+ID4gIHJldCA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgaG9z
dC0+aXJxLCBtc2RjX2lycSwNCj4gDQo=
