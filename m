Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58886221EE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiKIC1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiKIC13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:27:29 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6561168C46
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 18:27:23 -0800 (PST)
X-UUID: 014885dfcdfc40dd82ce8c4d7bc33c6d-20221109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=P+g7uBaPDLFFg0J1gV8Dso1qvnMoueWJq6O4OzNz3Oo=;
        b=SxrgY+1QRYYUDsge0iCS4NiJL4QhWiKTk37eIrdwGp6IFq9QhoUOi2wsAbMxH+FaH5aebhp9Xob6de3aNy/fXBtr1Nf4jDxGHzk5mSIGuIDpJq9FjrP0z0lH7pGyOl+PLqe0ThYP6Dme8zTvWLJ0fkJ23uQVybMBiKC9EC6dCtY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:9990cb72-1dd9-44ce-bbff-22fc75c6a2f7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:676d0191-1a78-4832-bd08-74b1519dcfbf,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 014885dfcdfc40dd82ce8c4d7bc33c6d-20221109
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1891104711; Wed, 09 Nov 2022 10:27:17 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 9 Nov 2022 10:27:16 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 9 Nov 2022 10:27:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwEvNbYMhuPYNYS9ZNCPm26Pv8SKqdIlQ7hBpJK+lRkVphy5ZLLSP9jZSkRhZtmeV4g+cGcPgEcBPeU/xERSDnjaTsgMotozeABOld/BJgtAvOuqBdWfUhNufF2toLjrxL4FYMmf6JFnUVfBh+bQfjXYm8XTGdh/KxFLkhpFwzp/zYY28LzfTBRtXvEprZ6VsER9a7QVSladRIHDhqjRdLQS0x+28eaTyn7PFeXvGNahxWs0g0zu6IgZZe4mE2eRZOYKe48WjdzKWYsu/L0VULVk5yCUmkvQiFEZcJTat9lNDbjQbfM9ANiV58nyatpyWZ7scpK40lvrNBqXO4DU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+g7uBaPDLFFg0J1gV8Dso1qvnMoueWJq6O4OzNz3Oo=;
 b=SGe2uMVl+BrWtNtCJ5K3TgixB7J5EUnPy1Nl4aEjdwjXJJJB3NZW9Hy4G0UG5d7xn0e3mvnV1Wbe7c6knJR+mGsLoavEc0Z5AiXeqBrSeXCkb3YOPVERFRRVcv+vbcnFecTYMW5jkdCCX+ZL4udhShKiFAZMv+nJa1nsqc9ZZSlaT6FugK/BRdiOyfrLwJWmXUpXld/e8dngNXrAeoQ/6aQK3ii3pgloJyO4dGMGzdAtZJBiAeFsU9e4I63AP9EbcMKZ7i/YeLhJuI/oh8dX79YXflyVho3/psxfM08PKJKWbD9wLFhm1a/rivZJrX9h2nR3Y2BRgxqc1WMBsdOkBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+g7uBaPDLFFg0J1gV8Dso1qvnMoueWJq6O4OzNz3Oo=;
 b=tcAyLQdEQSiruYXvWlLFOo4GPvMlwFqlUqKuJl/GoASIePDqyk8fxatquF+byoqh6ObQNRFq4dCQGncVEuVi+JXkDZrPnElJqhW409thfFY5D2BCPxjg7ewZWSFSdWB+YFJTFVi8HY+9i4ghnnSX7uNaoK4QEPR+3RZSuln+M5k=
Received: from SI2PR03MB5339.apcprd03.prod.outlook.com (2603:1096:4:105::9) by
 PUZPR03MB6985.apcprd03.prod.outlook.com (2603:1096:301:fa::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Wed, 9 Nov 2022 02:27:13 +0000
Received: from SI2PR03MB5339.apcprd03.prod.outlook.com
 ([fe80::c97d:476e:330:2459]) by SI2PR03MB5339.apcprd03.prod.outlook.com
 ([fe80::c97d:476e:330:2459%5]) with mapi id 15.20.5791.019; Wed, 9 Nov 2022
 02:27:13 +0000
From:   =?utf-8?B?WGlubGVpIExlZSAo5p2O5piV56OKKQ==?= 
        <Xinlei.Lee@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH] drm: mediatek: Modify dpi power on/off sequence.
Thread-Topic: [PATCH] drm: mediatek: Modify dpi power on/off sequence.
Thread-Index: AQHYwS82s+Q+jayFZkiWluRDUUA5iq4LIdsAgCnnjICAATnIgA==
Date:   Wed, 9 Nov 2022 02:27:13 +0000
Message-ID: <8bdbffecc932dbfd40c2ed4d0b5c8cbe0f84fe47.camel@mediatek.com>
References: <1662386033-4463-1-git-send-email-xinlei.lee@mediatek.com>
         <9fe3a2381746b46bde171f01635d30da2cb93d64.camel@mediatek.com>
         <c59a202cd31d46286eff441c6f42ec309486f334.camel@mediatek.com>
In-Reply-To: <c59a202cd31d46286eff441c6f42ec309486f334.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5339:EE_|PUZPR03MB6985:EE_
x-ms-office365-filtering-correlation-id: fffaa891-7e87-465b-71fe-08dac1f9e972
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FetHX5ZuKDcYYv+ZJMOR2w+NOkK6mJ/oJaGsaYrWScimtbDml855rxZnCZL5p3kotC13cb8VnAbDMx9r92EsD8Y1nx/WbAZGSjwEslNszBVLXo38g4QdEdmx/KAEXl9adm86pCgj66lxIJhpQR/5UH+oXV8WmjlEXJUUYhaFXkS3XoxjlQ3IXzkWjHxcYQ5iLDaY2zl6sCWXwOd6Y5/C0K7ntVuwjyx2Lkca/oQI2ObH07fqRAEJoOoKBzgvh+tBsCF7s4sJgTTCI3M3xy+ds708o1MDvdPt5D77s2XAwJT8L80uX7wSqAHTNL1ssIEMWdhqc/wpMaYiOnFM2mvDbpBZkWoVl9dtWh7uiW2HgbrufzfR68Mvb6YlW5z4Z4Ns4faq9Zvv8GUNOJIv1Qn6aMrpS9Q3/8xHsWf4BMjR3rhxZ19PfA1jMrKaI8XH/Ny8VvQzEYnq+x5A3pK2Pjwi96udPRwIyw2KKmhw6X2D+zSZ1DXooNQSWnyy8D5mH3R9yVWYVAuasP6XXRwC2t9weZ6374qE5Yeq+wrRvd3cJZs61oihgCJ2K9xISUvTSIX0qdMqo0+vjB717NUe0ubjFSmi9TCDjXnq1fwuin/k+DGfvA+uoZowObknvkJCCZWhtruJj+DgWWtFsfdibAYtaQa6XSxtdJ2l93+emE0dAJ4h8d650F1NnkEAFQw/MHfiUsXz8MOpkZsBex5m/VHfhsQsiS7l5lwe4clfsaziCwyqilpChze+uRgeAFjHhuUcMCIDKlZNsUssDQES9qTL7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5339.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(6486002)(4001150100001)(2906002)(316002)(64756008)(26005)(71200400001)(41300700001)(8936002)(5660300002)(478600001)(36756003)(6636002)(38070700005)(110136005)(8676002)(66556008)(4326008)(66476007)(54906003)(83380400001)(186003)(6506007)(86362001)(107886003)(66946007)(2616005)(6512007)(122000001)(76116006)(38100700002)(66446008)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVVYZ0IwdnZDT1JZci85aXhKZkxLMFUzSTF3YjIwRk5rYk9MaFZaVDZ4SlAr?=
 =?utf-8?B?T2tBOFZwOEF0eGJUQ1E4N0VwNzh2UjN6UDUwdVN0OFA4VkVzU1ZQdGZwYVph?=
 =?utf-8?B?VHQrczg4NlRjVEd0eGRHaVlpOHZOcmt3c1hNa3RkYWQ0M1ZPa0VtZHhrb241?=
 =?utf-8?B?Y1Q3UHpOaW9ONEpwMU91TC85bEdXc3FEVytnRUc2R1c0Nzc1QXJpUVJYRHpw?=
 =?utf-8?B?ODBwdENYZzNFWlpDNWw5S3NhdXI1dXRuY1BuUG11K0RMRkFpRXVBdjEyMlpt?=
 =?utf-8?B?WGJhNmFMQmZ5MmRiT2luMlpDVWp5WXVOQmFqcGVMd3MzTzNRQjQyN2xoVkR4?=
 =?utf-8?B?WGplSXVBQ0xPZHY1eVlJQXJhS1MzQUU2bnZmR3Y1bkV6SzhyQzZyRVhxdGFl?=
 =?utf-8?B?R0xOTEZpR0FDcnlSL1lXZWJVT0xJeXJGanJrMllPWmh5MmVVY1h0RWVxSGx6?=
 =?utf-8?B?YStTbllYSWtvVlJJTHlZd3ZwVTFxWjZyZjhCUk16M0UrcE5xV0FVNFBobUR5?=
 =?utf-8?B?UGxUc1RxN2kwU0d2ZnA0clo3bmcwYWhRVHNpc0wxVVh0Um13bXh0aXIzREcv?=
 =?utf-8?B?T0pCbCtQMGNZSHNrOWpoOVM1SzVFYnErMHFhSE9NVk9iZlZCVC9vMXlnOXlm?=
 =?utf-8?B?OFZZcGxBRVEyaUFzMmVSeVhxWGQxMXJjQ2JJMkdCSm9wb0trY3hIZHZxTTFl?=
 =?utf-8?B?OXZMRUR6UFg1aGEyMCtLUEZnQW01RnNld3MvRVFSREMzRUYzK3VWYmgxMGZG?=
 =?utf-8?B?dDljYXo4WHZtcDFBaXNPSXVJQWRMdytPb0lsRWZBRFQrMkdvNS90Y0xCS1Vq?=
 =?utf-8?B?anhDSjhlM1doSFE4ekJ3bi80Q0xLY0U3QkR6Rmw2L2RKZ0tBRFJlUjJwMk9s?=
 =?utf-8?B?STI1RDZHRmY3RVhlMGgxQWVYT3lQMnUvQmVjTDRSWXQ2L3dPRWJnT3JaMUVM?=
 =?utf-8?B?WVZxVVZVVldMOHR2eWtEWXNUV3Z5ejhhV1RLdGpaaHVNRitqdFIrbUJaaWU5?=
 =?utf-8?B?ZUFVVjVoUTZLSFlmSlFFTms4RW80QlFyVFJpZEVQV0ZXamlUS3NXS0Jram4w?=
 =?utf-8?B?QXpPdWJ5OWVVanZBV01oa2tiQmxCRFAvakM3RHE4bFlaMFBQaXJicHlrcEp0?=
 =?utf-8?B?MjhpOXVvaXd2eHphc1U2L2V6VXJGS1JaekQwUVJkbkgwSnBudVVvSldmbSs5?=
 =?utf-8?B?TWhHY2xlWEJZdVRzY0JIOEx2WWd2dmhXdG1YcHNvUnBTcXg2c0FFMEpDekFm?=
 =?utf-8?B?QnRuTlpITjZhY0VxZHR3THVTN29lSXZEbjBvTnZRL3VLbXFrMW9WOG0vUnB4?=
 =?utf-8?B?dWVrMHZpcitrKzRkWXZ6YjdiOTlIR0xENVAwTGEyRFZLcVFOelo5NkgzY2lC?=
 =?utf-8?B?VXd5ZlFGWUUyWm0zU0dvYTNNWVRQNUh2bk1FaFVnUURRbWx1ZEx1RXNvWHQ0?=
 =?utf-8?B?aXNhdGJIYW5ZYjB4VHFkYjVuMkg4OTR1RXBpelJTSlozemZiS2YxM1B5VDB5?=
 =?utf-8?B?VUZhaEMvT1MwN1RwbndVYkczaUltSkpYOThpN3BIZmhVNi9vMS9NaG4rTC9q?=
 =?utf-8?B?TTI1NWJ3OWN6YUVrakQzVWFBOSsrQ2lXZldFNDhGR0hYeStRdHBmZEdBWTA0?=
 =?utf-8?B?bUlPWmxOWGZRS0h3SEtoVW4vTGRRdmFscHBsODdQS3JtSG5yL3lsU0hKcmYx?=
 =?utf-8?B?cFIrUU14OU9oQWd2RW9ma29iWEkrS0Nwbm9IZHVKMWtGMHlFRjl2dWJxTFRq?=
 =?utf-8?B?VVkzRm5sNy9PODZMYUQybHlHQmxIUjR0MEJsb1Znd0g3anZsazhNSk1ram1X?=
 =?utf-8?B?NVhyamRhZXNlRWI3dHZyRjI3YVM0YVU0NFN1djdDZzVRT2VCSlR6VnNLVEhC?=
 =?utf-8?B?aFNUVW0zN0FqOXZ6b2tLYVBsZ2c4NGtKS3V5TnFlNk44OVFiNS9saDNlTzQ5?=
 =?utf-8?B?SnJkYVdBNWNOT0o3U3R0VnpjZDZsRFJhamdFeDRMMmkxRHM4Yy91MGdpc2pH?=
 =?utf-8?B?WFFyczA0L2lZTk5JejJKLzRYakk5TWpPbkY5MWU1OXh5WWw2QVNMNEZkRGx6?=
 =?utf-8?B?S0lmcGFvYnJ4dTMxeStxNDBMWisrd2E2TGNrbldGaGpqemJBRWcrU3YwWDRF?=
 =?utf-8?B?dTRsM3BiVTRrUy9jeVk2K3g4YW9Ed3FEWGpoNUxWWkpnaEFicVNtZUhwZWI4?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79695469A51E6E4CAC908BD07AE9ACD9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5339.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffaa891-7e87-465b-71fe-08dac1f9e972
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 02:27:13.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ucYvsioaSz0VM1wKQ0D9yqEWw5ex4ILw2DJXiFVyNNJs94ohuIk4g+TmfUADqcuqydDLOEQjukeo5hX3L606cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6985
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTA4IGF0IDA3OjQ0ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIFhpbmxlaToNCj4gDQo+IE9uIFdlZCwgMjAyMi0xMC0xMiBhdCAxNTo0OCArMDgw
MCwgeGlubGVpLmxlZSB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjItMDktMDUgYXQgMjE6NTMgKzA4
MDAsIHhpbmxlaS5sZWVAbWVkaWF0ZWsuY29tIHdyb3RlOg0KPiA+ID4gRnJvbTogWGlubGVpIExl
ZSA8eGlubGVpLmxlZUBtZWRpYXRlay5jb20+DQo+ID4gPiANCj4gPiA+IE1vZGlmeSBkcGkgcG93
ZXIgb24vb2ZmIHNlcXVlbmNlIHNvIHRoYXQgdGhlIGZpcnN0IGdwaW8gb3BlcmF0aW9uDQo+ID4g
PiB3aWxsIHRha2UgZWZmZWN0Lg0KPiA+ID4gDQo+ID4gPiBGaXhlczogNmJkNDc2M2ZkNTMyICgi
ZHJtL21lZGlhdGVrOiBzZXQgZHBpIHBpbiBtb2RlIHRvIGdwaW8gbG93DQo+ID4gPiB0bw0KPiA+
ID4gYXZvaWQgbGVha2FnZQ0KPiA+ID4gY3VycmVudCIpDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFhpbmxlaSBMZWUgPHhpbmxlaS5sZWVAbWVkaWF0ZWsuY29tPg0KPiA+ID4gDQo+ID4g
PiAtLS0NCj4gPiA+IEJhc2Ugb24gdGhlIGJyYW5jaCBvZiBMaW51eC1uZXh0L21hc3Rlci4NCj4g
PiA+IEJlY2F1c2UgZHBpIHBvd2VyX29uL29mZiBpcyBwcm90ZWN0ZWQgYnkgZHBpLT5yZWZjb3Vu
dCwgdGhlIGZpcnN0DQo+ID4gPiB0aW1lDQo+ID4gPiBpdCBjYW5ub3QgYmUgcG93ZXJlZCBvbiBh
bmQgb2ZmIHN1Y2Nlc3NmdWxseSwgaXQgd2lsbCBjYXVzZQ0KPiA+ID4gbGVha2FnZS4NCj4gPiA+
IC0tLQ0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGku
YyB8IDEyICsrKysrKy0tLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHBpLmMNCj4gPiA+IGluZGV4IDYzMGE0ZTMwMWVmNi4uMmNlMWEzOWNlM2JmIDEwMDY0
NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiA+ID4gQEAgLTQ2Miw5
ICs0NjIsNiBAQCBzdGF0aWMgdm9pZCBtdGtfZHBpX3Bvd2VyX29mZihzdHJ1Y3QgbXRrX2RwaQ0K
PiA+ID4gKmRwaSkNCj4gPiA+ICAJaWYgKC0tZHBpLT5yZWZjb3VudCAhPSAwKQ0KPiA+ID4gIAkJ
cmV0dXJuOw0KPiA+ID4gIA0KPiA+ID4gLQlpZiAoZHBpLT5waW5jdHJsICYmIGRwaS0+cGluc19n
cGlvKQ0KPiA+ID4gLQkJcGluY3RybF9zZWxlY3Rfc3RhdGUoZHBpLT5waW5jdHJsLCBkcGktPnBp
bnNfZ3Bpbyk7DQo+ID4gPiAtDQo+ID4gPiAgCW10a19kcGlfZGlzYWJsZShkcGkpOw0KPiA+ID4g
IAljbGtfZGlzYWJsZV91bnByZXBhcmUoZHBpLT5waXhlbF9jbGspOw0KPiA+ID4gIAljbGtfZGlz
YWJsZV91bnByZXBhcmUoZHBpLT5lbmdpbmVfY2xrKTsNCj4gPiA+IEBAIC00ODksOSArNDg2LDYg
QEAgc3RhdGljIGludCBtdGtfZHBpX3Bvd2VyX29uKHN0cnVjdCBtdGtfZHBpDQo+ID4gPiAqZHBp
KQ0KPiA+ID4gIAkJZ290byBlcnJfcGl4ZWw7DQo+ID4gPiAgCX0NCj4gPiA+ICANCj4gPiA+IC0J
aWYgKGRwaS0+cGluY3RybCAmJiBkcGktPnBpbnNfZHBpKQ0KPiA+ID4gLQkJcGluY3RybF9zZWxl
Y3Rfc3RhdGUoZHBpLT5waW5jdHJsLCBkcGktPnBpbnNfZHBpKTsNCj4gPiA+IC0NCj4gPiA+ICAJ
cmV0dXJuIDA7DQo+ID4gPiAgDQo+ID4gPiAgZXJyX3BpeGVsOg0KPiA+ID4gQEAgLTcyMSw2ICs3
MTUsOSBAQCBzdGF0aWMgdm9pZCBtdGtfZHBpX2JyaWRnZV9kaXNhYmxlKHN0cnVjdA0KPiA+ID4g
ZHJtX2JyaWRnZSAqYnJpZGdlKQ0KPiA+ID4gIHsNCj4gPiA+ICAJc3RydWN0IG10a19kcGkgKmRw
aSA9IGJyaWRnZV90b19kcGkoYnJpZGdlKTsNCj4gPiA+ICANCj4gPiA+ICsJaWYgKGRwaS0+cGlu
Y3RybCAmJiBkcGktPnBpbnNfZ3BpbykNCj4gPiA+ICsJCXBpbmN0cmxfc2VsZWN0X3N0YXRlKGRw
aS0+cGluY3RybCwgZHBpLT5waW5zX2dwaW8pOw0KPiANCj4gSSB0aGluayB0aGlzIHNob3VsZCBi
ZSBwbGFjZWQgYWZ0ZXIgbXRrX2RwaV9wb3dlcl9vZmYoKS4NCj4gDQo+ID4gPiArDQo+ID4gPiAg
CW10a19kcGlfcG93ZXJfb2ZmKGRwaSk7DQo+ID4gPiAgfQ0KPiA+ID4gIA0KPiA+ID4gQEAgLTcy
OCw2ICs3MjUsOSBAQCBzdGF0aWMgdm9pZCBtdGtfZHBpX2JyaWRnZV9lbmFibGUoc3RydWN0DQo+
ID4gPiBkcm1fYnJpZGdlICpicmlkZ2UpDQo+ID4gPiAgew0KPiA+ID4gIAlzdHJ1Y3QgbXRrX2Rw
aSAqZHBpID0gYnJpZGdlX3RvX2RwaShicmlkZ2UpOw0KPiA+ID4gIA0KPiA+ID4gKwlpZiAoZHBp
LT5waW5jdHJsICYmIGRwaS0+cGluc19kcGkpDQo+ID4gPiArCQlwaW5jdHJsX3NlbGVjdF9zdGF0
ZShkcGktPnBpbmN0cmwsIGRwaS0+cGluc19kcGkpOw0KPiA+ID4gKw0KPiA+ID4gIAltdGtfZHBp
X3Bvd2VyX29uKGRwaSk7DQo+ID4gPiAgCW10a19kcGlfc2V0X2Rpc3BsYXlfbW9kZShkcGksICZk
cGktPm1vZGUpOw0KPiA+ID4gIAltdGtfZHBpX2VuYWJsZShkcGkpOw0KPiA+IA0KPiA+IEhpIENL
LA0KPiA+IA0KPiA+IEdlbnRsZSBwaW5nIGZvciB0aGlzIHBhdGNoLCBpZiB0aGVyZSBpcyBhbnl0
aGluZyBJIG5lZWQgdG8gbW9kaWZ5LA0KPiA+IHBsZWFzZSBraW5kbHkgbGV0IG1lIGtub3cuDQo+
ID4gDQo+ID4gQmVzdCBSZWdhcmRzIQ0KPiA+IHhpbmxlaQ0KPiA+IA0KDQpIaSBDSzoNCg0KWWVz
LCB0aGlzIHBhY3RoIGlzIG1haW5seSB0byByZW1vdmUgdGhlIGNvbnRyb2wgb2YgdGhlIHBpbiBm
cm9tIA0KZHBpX3Bvd2VyX29uL29mZiwgYmVjYXVzZSBkcGlfcG93ZXJfb24vb2ZmIGlzIHByb3Rl
Y3RlZCBieSByZWZjb3VudC4NCg0KSSB3aWxsIG1vZGlmeSB0aGUgcG9zaXRpb24gb2YgdGhlIHB1
bGwtZG93biBncGlvIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkJlc3QgUmVnYXJkcyENCnhpbmxl
aQ0K
