Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833926AFD6C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCHDcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 22:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCHDc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:32:27 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E18169CFA;
        Tue,  7 Mar 2023 19:32:20 -0800 (PST)
X-UUID: d2c10c56bd6111eda06fc9ecc4dadd91-20230308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MBlgWsjdXsB4EqdLFB+R/JBqopYZU8BHOj2bQHMJj3c=;
        b=SVylB3QojkJ1RUq44fDlfRoy+CFr6GOuAH0znsaR/Ii61w4GaBSLsCZrWyl+FMicpNg47kiTIYeR8X3UDTjn2I4/rsENnMYlb+5IVU4bAHFVpAfTU0awc4ZDDviXE/PcP6nwG+fAKdRFIurrEsXF/F453Gc25D6yusTj0AW/Hhk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:53d6b14b-cffd-49eb-8876-cf6dcf161534,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:cc268cb2-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: d2c10c56bd6111eda06fc9ecc4dadd91-20230308
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <kyrie.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1089580559; Wed, 08 Mar 2023 11:32:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 8 Mar 2023 11:32:15 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 8 Mar 2023 11:32:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYj5sT+cWgTtxpcec6cnjjULyUPWdWYagJSCFbmz/jIsoEXQeS0nD13UkaZcKWFyBcAiO7IvkuPsp1OtQSPaJd1FE9V3k+FB7YIbrHSkREDV/vDCRKanDrApJhpMaffDKfRa8hG326IZHR1kxGymnvE7pbMnR8BNAUW/J7uDOoAkfB2QSgJvrsmUfM8nodeuOj45Q1vWNtQasBgl/O+QfebmdRACq1aYcDUQHnKVCba2u2Ph2Re/fD2QbuNa6ZwZonNUqRp5jYAPXpEQQVNA6OM3FnBK/jhZCTPTMVUlW1Hah8MxTP0boZErvR6pn0gd2Eq3w46Ex5ua7NAAeViEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBlgWsjdXsB4EqdLFB+R/JBqopYZU8BHOj2bQHMJj3c=;
 b=CmllXNI0V3LYPh9weaB+hk1r646ENmwor3Fls9/VICkk+RlOpcKBmkj22hNmZ8kysZtmAKVNtfF0CD3GDG5wJkTzBPNTZzXhvANEuP0Q0+ydvXTYwFa6vDO2OewjMl3WChaSiUlarMW2Ux+1+RGhFuEwIP5sLA3o6RAI7p7RSAvV4EjIFKFxxhh1Kn229VzYHr7bgoparhrT7+YDWE2V1OjDikceoZwpKSzMN81yqZMvEm/tae0M+yMoox2hRi60Eeq2hRovpZhM47JPDP61tfNtVpkapp6R6VEgnMK3mg28xc9SLPnlbok0Q8dOCaFii2YesfvurbBTG4GXp7k70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBlgWsjdXsB4EqdLFB+R/JBqopYZU8BHOj2bQHMJj3c=;
 b=qQIsD75rKBRxnN/7bMe2Gig0I9PVcZZtSKXt32ZC3uiMxNUlClrrCm8DavIB3LiEtT4kpS1gtz9KWWNh+Lm2MxPyqkCyGz1VXqg2HYmBB1VmRhOyrv5hherFJ0FcrU6ZUOxxncEPxhdpDjw9lneqGLamSzL5Umo3K/40IvMgl94=
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com (2603:1096:301:b9::5)
 by KL1PR03MB6271.apcprd03.prod.outlook.com (2603:1096:820:a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 03:32:12 +0000
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::804e:d33a:c275:6d52]) by PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::804e:d33a:c275:6d52%8]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 03:32:12 +0000
From:   =?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>
To:     "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "zyytlz.wz@163.com" <zyytlz.wz@163.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>,
        =?utf-8?B?QmluIExpdSAo5YiY5b2sKQ==?= <bin.liu@mediatek.com>,
        =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>
Subject: Re: [RESEND PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Thread-Topic: [RESEND PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Thread-Index: AQHZUNol+KoTCb2NbEShoW8BcHTMZK7vGQcAgABRWYCAALIggIAACusAgAAUAgA=
Date:   Wed, 8 Mar 2023 03:32:11 +0000
Message-ID: <86c98d73b0d294e143014ea5e15d0a5d065e1a66.camel@mediatek.com>
References: <20230306062633.200427-1-zyytlz.wz@163.com>
         <CAJedcCzeVwwi9SkkwouFXUAVhF-tKF4dkqsFqVQwszSwY1SJ0A@mail.gmail.com>
         <57c17bfd-83f3-fcce-0eab-e28469fb0ced@collabora.com>
         <11c2bce1e5286ad3a9a5be2ee59c2beac168f135.camel@mediatek.com>
         <CAJedcCx13sz5h=fWvJU38P_1W-zd6yZe=iSMpO28_E_kAqUGDA@mail.gmail.com>
         <cfa2f64d2d01ffc53a6afdc9a5b867bbcb07b5f6.camel@mediatek.com>
         <CAJedcCwhk_XuMF8keGZGBTVBZSMuoQeyV_7L1H2VeT2x_vj-ZQ@mail.gmail.com>
In-Reply-To: <CAJedcCwhk_XuMF8keGZGBTVBZSMuoQeyV_7L1H2VeT2x_vj-ZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB6186:EE_|KL1PR03MB6271:EE_
x-ms-office365-filtering-correlation-id: 6a65b468-be95-4b61-24b0-08db1f85b44e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SSABMx2YMomh53tAjn3VS/8pl8EZzlYscOuOBxxgQdubIUGEYKduTxt6sTVbvtcB2Qud6yQ5x8jRTkv2HZRFE8feKZEJxVDaiOoxDtQhVlFR4z/93f2rHZvESEp6Rhc7pOo7S0KanhbKtgdFRnz9bizlLmjqi3X/0PY4abqGZTMWJTJiX+p+zQ4otgrvjlJapTvDioe31D7WOjpU67lkjSxC7Kh60MK2CVUy4tuiRFL9x1CIfhsMQtief7t+dxHTLy0mOrqZB/Fz3JW/ZjXl0Ehz6adYUTLwYMdauvaQlggsuCpOjU8Ek9XVuu06G2d8T5nQD52DOTRargRBU2pw6mWTJ8LN0XicVBs/+y+MTDf9wZXRbADBbcPWtUr8NQDoHQ04XjgM7VJwXnwDMjBkw2u+EIIKxhQTDjIok+woAUrWiUVnfoGVmIfqU6nJebZ9rrL+WdCTdPfnl4hVciEobV+hS5AFn+rahiKlcCmJl8eWkShdT3kLlrtCVRoa99GtazzBhQoHMvrf0OCCRClCgtNz2LApZkh5+XqXdCckzmgOy64cT/jy3DqC3ZXiAfiTjECfJkxpeCX8KHsyAlu9u1YSLf4x9YSibcbNQFcktm5wGCAZqmA1Hnupgxh1cT1LcT36j1I8oJr+3zIGwpq+n/fLyn/olVRtST6H46xPly8csn6RKBbo3sBqGPx+c/zSjwJMdYg+pm661bEjSCxevA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6186.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199018)(478600001)(5660300002)(7416002)(26005)(83380400001)(186003)(38070700005)(6512007)(6506007)(86362001)(2616005)(2906002)(36756003)(6486002)(71200400001)(85182001)(38100700002)(316002)(41300700001)(66946007)(66476007)(66446008)(64756008)(76116006)(66556008)(8676002)(6916009)(4326008)(91956017)(122000001)(8936002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFd0UHVTQnhtMFJlUlFKcDBJMFcvalgxbW9wNVJ6MkpmWmJCRVFWenN5S2RW?=
 =?utf-8?B?Nmo5YmRobGkrQ3I1enE5QnhCU0MzUjN2ZXVQTFJUc1hXNEJFVWUySmQ3ZklN?=
 =?utf-8?B?THBzQTlodldlYkZEUERHWmE4NFpsNjBBZkJyRVhhZnZhdjAvck1BUVpubWlH?=
 =?utf-8?B?T1d5MmVKSUFsOXJKR09zNG1zRktoSm5zbkw3ZDRIaTJ0QU5ZdVh4eWx6aC9t?=
 =?utf-8?B?bjE5WVFtUTdRRG0zL3R6a2N6Q2grakgyWXBNb1lyVzRFZ0JRS1lDaUJGdXNG?=
 =?utf-8?B?Q1hTL1dSLzl0RlpvSGpsYlJlc3hMM3d5QWpkcWdCUGJBbnR1eVc5dFM5eFJO?=
 =?utf-8?B?WmhOVm1OZVlxTzFXVlZhV0c4SGdIVVhiVUs2Ui9jL1NyczlOK2Q1MXNzc3dT?=
 =?utf-8?B?TXVhbmxjRDlJUXYyNU9MNDNjalg4QlNISC9Xc21oS1RBTi9yOXlkYTJxczJ3?=
 =?utf-8?B?UHlZY2RzN0F3d2k3NmZSdmFqKzJPVzhKOHdReDFaVWtsclVqeVBkcmpMZHNC?=
 =?utf-8?B?VkFTL1E2TC9RcE9GdDJJaXNqc0o0NVEvbm9icDU4bzZSOWhFTkJIVU91R28w?=
 =?utf-8?B?OUJHZU5RSkhyWktTd0gyb2RlQlJyaXpGZ0txOVd5UFAwRU9hdmlUWmlFYTNF?=
 =?utf-8?B?YWE3aVZNb0VFVCtoNUl2Vmp0MjJwb1JhZVY2akw1MU1hYzNpMnJ5b3pTQkhC?=
 =?utf-8?B?LzdvOHhnN3VoOEFVcUg2UXNhRG9GeXMyazM2ZklHU1VjRjcrdWRKL0diM3R0?=
 =?utf-8?B?Slo2UU9FNzdNN3RzSGJVMy9yYTd5cFJGTy8rMjArVEZBMHNtTlpPYStESlJh?=
 =?utf-8?B?VkpkYytvZndtTitTNG13L3ppZW9QUTJ6M2I1cEFIV3lKR0h2UmxaVzJwL3FT?=
 =?utf-8?B?SjA0M3lrRW1LYnN3a2REL0ZFL2l4emVjQ2d3KzJ4akxBdjNGaXNJMGRLa25j?=
 =?utf-8?B?Rlp0SWxlNG5TaW5mT01RNytYQzlsUVVSZGtwd09YK0Zma3hmYjBtK0lEM004?=
 =?utf-8?B?MWhacUp0Sk41MWlJY2pXYm1pNVVSTlZQVi9BZFdHY0svV0k2Wno4R2k0YUp0?=
 =?utf-8?B?ZzlsR1RVRDJ4WkQwVmprTzgrcTdkK1BGU3kwdVAwbndqd1pqV2JKZUhncTY4?=
 =?utf-8?B?MmZEMjJYYzdOdzR6czNSQ1BxNjBaWVh1eXR0eFYyOXVUUVc0aDMwbmYwVHdv?=
 =?utf-8?B?SVV3dGE2RFZGNEI0SmpIVlZ4alQ1VEJPT3RWbEtOWUc3V3BqQWtQWjhiTGcw?=
 =?utf-8?B?SndDVk5ySStDVzRiazNZdUd6UGgybk9QV1N1QzFidEsxRnBzSlhvYlIweTF4?=
 =?utf-8?B?dTVvWk4rdUtXc0VCTTNhS1FyZi9WajJlSGhUaGdvYnEzNHBhTlJybUptQWJG?=
 =?utf-8?B?KzIwU2FGbDNEZUNVc1N0cldzQ2pYRmZvSGFYNkQ2elF3N1FsZUVBOEZyeGxa?=
 =?utf-8?B?cW1lMmdrdXRvSHI2ckYzVm5tMGJqcDg3TXlObXBINEZjY0lrclVSQ3VNSEpW?=
 =?utf-8?B?Z3FPdGdSTWtndEN1TVJKZlc3NFZsTnBLa1ZGMHRmTkw3cTAxdVdVS25Udm1P?=
 =?utf-8?B?aVpkS0FoNC9Kd1BrdDhkV0IzRjhuQzRuV2FJT0pUbjh4N3ZSeEluY3AvcUd1?=
 =?utf-8?B?cGdUaHFVN0JKd1dRYzY0K29yaUJuNFRPR044YTFhbnhIVGIwSlNpd1kybndG?=
 =?utf-8?B?R1VkRFZQdDN6T1NoSm9LU2lLeHpUWjViSldiOC9VT284MzMvbWZXcE54em9Y?=
 =?utf-8?B?MWkrU2pnQUt6RXRmblJFODk5NW5sLzJhb0NaRzl4OHUvenZHMUg2ZkRsdVp6?=
 =?utf-8?B?dldyak5DNE91R1NMbjQ0U2dYNkhpa1UyUjN4c0N4V3Z5Ukk1RlN3OFNpajJt?=
 =?utf-8?B?OWswTWdET2hOK3lkVEcrSHhMdjl6Y1U0Y3l3aldnT0J3U2c1Q0NYVm4ydUgx?=
 =?utf-8?B?Y01ua3VPdlpWSy9MZENXLzhjSEc2NUdHMlRJUDFscHhUak83S0pZQXFCSEp6?=
 =?utf-8?B?OHRRN29Ic2EzdTV1Nmd5NVBCRmJVN2U5NUFEZWw5Qndld1hhdzJkV1ptOEZv?=
 =?utf-8?B?aFFpWXFwUFAvZHNZYjhJQ3lWeG1nUVJlUG1DaEQ0MVRsb1A2c3RaV0tXdUhD?=
 =?utf-8?B?ZWZPOUZESE44Y2FCL2w4SGp2UUpYbFJhNEVSRmRjSitqT1JQNjJZZTF5bkpX?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3AD38E3D49F124BBE0B88497927F4DC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6186.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a65b468-be95-4b61-24b0-08db1f85b44e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 03:32:11.8563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbnY0SacGafMbd1p42lIuqc6dz7Z1RzdYsDdY6oQrci8eDho0tZWadF7vo/YOQNlH9lKBw86Vxfc5AldpaPTGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6271
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTA4IGF0IDEwOjIwICswODAwLCBaaGVuZyBIYWNrZXIgd3JvdGU6DQo+
IEhpIEt5cmllLA0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIGNhcmVmdWwgYW5hbHlzaXMgYW5k
IHJlc3BvbnNlLiBJIHN0aWxsIGhhdmUgc29tZQ0KPiBhcmVhcyB0aGF0IEkgZG9uJ3QgcXVpdGUg
dW5kZXJzdGFuZCBhbmQgd291bGQgbGlrZSB0byBhc2sgZm9yDQo+IGNsYXJpZmljYXRpb24uIFRo
YXQgaXMsIGhvdyBkbyB0aGUgZnVuY3Rpb24gcG9pbnRlcnMgZm9yIHN0b3ANCj4gc3RyZWFtaW5n
LCBpbml0aWFsaXplZCBhcyBtdGtfanBlZ19lbmNfc3RvcF9zdHJlYW1pbmcgYW5kDQo+IG10a19q
cGVnX2RlY19zdG9wX3N0cmVhbWluZywgZW5zdXJlIHRoYXQgdGhlIHdvcmtlciBpcyBjYW5jZWxl
ZD8gSQ0KPiB3b3VsZCBncmVhdGx5IGFwcHJlY2lhdGUgeW91ciByZXNwb25zZS4NCj4gDQo+IEJl
c3QgcmVnYXJkcywNCj4gWmhlbmcNCg0KRGVhciB6aGVuZywNCg0KRm9yIHN0b3Agc3RyZWFtaW5n
LCB3aGF0IEkgbWVhbiBpcyB0aGF0IHN0b3BwcGluZyBqcGVnIGRlY29kaW5nIG9yDQplbmNvZGlu
Zy4NCk9rLCBsZXQgbWUgaW50cm9kdWNlIHRoZSBzdyBmbG93IG9mIHN0b3Agc3RyZWFtaW5nOg0K
Rmlyc3RseSwgdGhlIGFwcCB3aWxsIGNhbGwgdjRsMl9tMm1faW9jdGxfc3RyZWFtb2ZmLCB3aGlj
aCB3aWxsIGNhbGwNCnY0bDJfbTJtX2NhbmNlbF9qb2IsIGlmIGl0IGZpbmRzIGEgam9iIHJ1bm5p
bmcoYXMgeW91IG5vdGUsIGNwdTEgaXMNCnJ1bm5pbmcpLCBpdCB3aWxsIHdhaXQgZXZlbnQsIHRo
ZSBldmVudCBpcyB3YWtlIHVwIGJ5DQp2NGwyX20ybV9qb2JfZmluaXNoIGZ1bmN0aW9uLiBBbmQg
djRsMl9tMm1fam9iX2ZpbmlzaCBpcyBjYWxsZWQgYnkganBlZw0KZGVjL2VuYyBpcnEgaGFuZGxl
ciwgd2hpY2ggbWVhbnMgdGhhdCB0aGUgd2FpdHRpbmcgd291bGQgcmVzdWx0IG10ayBodw0KdG8g
ZmluaXNoIGRlYy9lbmMsIGlycSB3aWxsIG9jY3VyIGFuZCBpcnEgaGFuZGxlciB3b3VsZCBjYW5j
ZWwgdGltZW91dA0Kd29ya2VyLiBUaGUgZm9sbG93IGlzIHNob3duIGFzIGJsb3cuDQp2NGwyX20y
bV9pb2N0bF9zdHJlYW1vZmYNCiAgIHY0bDJfbTJtX2NhbmNlbF9qb2IgICAgICAgICAgICAgICAg
bXRrX2pwZWdfZW5jX2lycS9tdGtfanBlZ19kZWNfaXJxDQogICAgICAgd2FpdCBldm5ldCA8LS0t
LS0tIHdha2UgdXAgLS0tLS0tdjRsMl9tMm1fam9iX2ZpbmlzaA0KCQkgICAgICAgICAgICAgICAg
ICAgICAgICBjYW5jZWwgdGltZW91dCB3b3JrDQoJIA0KQXMgbWVudGlvbmVkIGFib3ZlLCBpZiBp
dCBpcyBub3JtYWwgc3RvcCBzdHJlYW1pbmcgYWN0aW9uLCB0aGVyZSB3aWxsDQpiZSBubyBoYXBw
ZW4gdGhhdCB0aGUgdGltZW91dCB3b3JrZXIgZG9lcyBub3QgY2FuY2VsZWQuDQoNCkJ1dCBpZiBt
dGtfanBlZ19yZW1vdmUgaXMgY2FsbGVkIGRpcmVjdGx5IHdpdGhvdXQgYWJvdmUgZmxvdywgaXQg
d291bGQNCmNhdXNlIGxvdHMgb2YgaXNzdWVzLg0KDQpSZWdhcmRzLA0KS3lyaWUuDQo+IA0KPiBL
eXJpZSBXdSAo5ZC05pmXKSA8S3lyaWUuV3VAbWVkaWF0ZWsuY29tPiDkuo4yMDIz5bm0M+aciDjm
l6XlkajkuIkgMTA6MDLlhpnpgZPvvJoNCj4gPiANCj4gPiBPbiBUdWUsIDIwMjMtMDMtMDcgYXQg
MjM6MDMgKzA4MDAsIFpoZW5nIEhhY2tlciB3cm90ZToNCj4gPiA+IFRoZSB0aW1lciBmdW5jdGlv
biB3YXMgc2V0IGluIG10a19qcGVnX3Byb2JlIHdpdGgNCj4gPiA+IG10a19qcGVnX2pvYl90aW1l
b3V0X3dvcmsgZnVuY3Rpb24uDQo+ID4gPiBBbmQgdGhlIHdvcmtlciBpcyBzdGFydGVkIGluIG10
a19qcGVnX2RlY19kZXZpY2VfcnVuLg0KPiA+ID4gVGhlcmUgYXJlIHR3byBmdW5jdGlvbnMgKG10
a19qcGVnX2VuY19pcnEgYW5kIG10a19qcGVnX2RlY19pcnEpDQo+ID4gPiB3aGljaA0KPiA+ID4g
bWF5IGNhbmNlbCB0aGUgd29ya2VyLg0KPiA+ID4gVGhleSBhcmUgdXNlZCBhcyBJUlEgaGFuZGxl
ciBmdW5jdGlvbiB3aGljaCBpcyBzYXZlZCBhcyBmdW5jdGlvbg0KPiA+ID4gcG9pbnRlciBpbiBh
IHZhcmlhYmxlLg0KPiA+ID4gSW4gbXRrX2pwZWdfcHJvYmUsIHRoZXkgYXJlIHJlZ2lzdGVyZWQg
YnkgZGV2bV9yZXF1ZXN0X2lycToNCj4gPiA+IA0KPiA+ID4gcmV0ID0gZGV2bV9yZXF1ZXN0X2ly
cSgmcGRldi0+ZGV2LA0KPiA+ID4gICAgICAgICAgICAgICAganBlZ19pcnEsDQo+ID4gPiAgICAg
ICAgICAgICAgICBqcGVnLT52YXJpYW50LT5pcnFfaGFuZGxlciwNCj4gPiA+ICAgICAgICAgICAg
ICAgIDAsDQo+ID4gPiAgICAgICAgICAgICAgICBwZGV2LT5uYW1lLCBqcGVnKTsNCj4gPiA+ICAg
ICBpZiAocmV0KSB7DQo+ID4gPiAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8g
cmVxdWVzdCBqcGVnX2lycSAlZCAoJWQpXG4iLA0KPiA+ID4gICAgICAgICBqcGVnX2lycSwgcmV0
KTsNCj4gPiA+ICAgICAgIHJldHVybiByZXQ7DQo+ID4gPiAgICAgfQ0KPiA+ID4gDQo+ID4gPiBI
b3dldmVyLCBpZiB3ZSByZW1vdmUgdGhlIG1vZHVsZSB3aXRob3V0IHRyaWdnZXJpbmcgdGhlIGly
cSwgdGhlDQo+ID4gPiB3b3JrZXIgd2lsbCBuZXZlciBiZSByZW1vdmVkLg0KPiA+ID4gDQo+ID4g
PiBBcyBmb3IgdGhlIHNjaGVkdWxlLCBtdGtfanBlZ19kZWNfZGV2aWNlX3J1biBhbmQNCj4gPiA+
IG10a19qcGVnX2VuY19kZXZpY2VfcnVuIHdpbGwgc3RhcnQgdGhlIHdvcmtlci4NCj4gPiA+IFRo
ZSBzY2hlZHVsZSBpbnZva2luZyBpcyBxdWl0ZSBjb21wbGljYXRlZC4gQXMgZmFyIGFzIEkga25v
dywgdGhlDQo+ID4gPiBpbnZva2luZyBjaGFpbiBpcyBhcyBmb2xsb3dzOg0KPiA+ID4gDQo+ID4g
PiB2NGwyX20ybV9pbml0LT52NGwyX20ybV9kZXZpY2VfcnVuX3dvcmstPnY0bDJfbTJtX3RyeV9y
dW4NCj4gPiA+IA0KPiA+ID4gdGhlIHY0bDJfbTJtX2RldmljZV9ydW5fd29yayBmdW5jdGlvbiBp
cyBhbHNvIGEgd29ya2VyIHdoaWNoIGlzDQo+ID4gPiBzZXQNCj4gPiA+IGluDQo+ID4gPiB2NGwy
X20ybV9pbml0IGFuZCBzdGFydGVkIGluDQo+ID4gPiB2NGwyX20ybV9zY2hlZHVsZV9uZXh0X2pv
Yi4NCj4gPiA+IA0KPiA+ID4gQmVmb3JlIGNhbGxpbmcgcmVtb3ZlIGZ1bmN0aW9uLCB0aGUgIG10
a19qcGVnX3JlbGVhc2Ugd2FzIGludm9rZWQNCj4gPiA+IHRvDQo+ID4gPiByZWxlYXNlIHRoZSBy
ZWxhdGVkIHJlc291cmNlLg0KPiA+ID4gDQo+ID4gPiB2NGwyX20ybV9jYW5jZWxfam9iIHdpbGwg
Y2FuY2VsIHRoZSBqb2IgYnkgY2FsbGluZw0KPiA+ID4gbTJtX2Rldi0+bTJtX29wcy0+am9iX2Fi
b3J0KG0ybV9jdHgtPnByaXYpLg0KPiA+ID4gDQo+ID4gPiBCdXQgdGhpcyB3aWxsIG9ubHkgY2Fu
Y2VsIHRoZSBjdXJyZW50IHF1ZXVlIGJ5DQo+ID4gPiBsaXN0X2RlbCgmbTJtX2Rldi0+Y3Vycl9j
dHgtPnF1ZXVlKTsNCj4gPiA+IA0KPiA+ID4gSSB0aGluayB0aGlzIGNhbiBub3QgY2FuY2VsIHRo
ZSBwb3N0ZWQgdGFzayBtZW50aW9uZWQgYmVmb3JlLiBTbw0KPiA+ID4gSQ0KPiA+ID4gdGhpbmsg
aWYgbXRrX2pwZWdfam9iX3RpbWVvdXRfd29yaw0KPiA+ID4gDQo+ID4gPiBpcyB3b3JraW5nIG9u
LCBhbmQgdXNpbmcganBlZy0+bTJtX2RldiBhZnRlciBmcmVlaW5nIGl0IGluDQo+ID4gPiBtdGtf
anBlZ19yZW1vdmUsIGl0IHdpbGwgY2F1c2UgYSBVQUYgYnVnLg0KPiA+ID4gDQo+ID4gPiBzdGF0
aWMgaW50IG10a19qcGVnX3JlbGVhc2Uoc3RydWN0IGZpbGUgKmZpbGUpDQo+ID4gPiB7DQo+ID4g
PiAgIHN0cnVjdCBtdGtfanBlZ19kZXYgKmpwZWcgPSB2aWRlb19kcnZkYXRhKGZpbGUpOw0KPiA+
ID4gICBzdHJ1Y3QgbXRrX2pwZWdfY3R4ICpjdHggPSBtdGtfanBlZ19maF90b19jdHgoZmlsZS0N
Cj4gPiA+ID5wcml2YXRlX2RhdGEpOw0KPiA+ID4gDQo+ID4gPiAgIG11dGV4X2xvY2soJmpwZWct
PmxvY2spOw0KPiA+ID4gICB2NGwyX2N0cmxfaGFuZGxlcl9mcmVlKCZjdHgtPmN0cmxfaGRsKTsN
Cj4gPiA+ICAgWzFdIHY0bDJfbTJtX2N0eF9yZWxlYXNlKGN0eC0+ZmgubTJtX2N0eCk7DQo+ID4g
PiAgIHY0bDJfZmhfZGVsKCZjdHgtPmZoKTsNCj4gPiA+ICAgdjRsMl9maF9leGl0KCZjdHgtPmZo
KTsNCj4gPiA+ICAga2ZyZWUoY3R4KTsNCj4gPiA+ICAgbXV0ZXhfdW5sb2NrKCZqcGVnLT5sb2Nr
KTsNCj4gPiA+ICAgcmV0dXJuIDA7DQo+ID4gPiB9DQo+ID4gPiANCj4gPiA+IHZvaWQgdjRsMl9t
Mm1fY3R4X3JlbGVhc2Uoc3RydWN0IHY0bDJfbTJtX2N0eCAqbTJtX2N0eCkNCj4gPiA+IHsNCj4g
PiA+ICAgLyogd2FpdCB1bnRpbCB0aGUgY3VycmVudCBjb250ZXh0IGlzIGRlcXVldWVkIGZyb20g
am9iX3F1ZXVlICovDQo+ID4gPiAgIFsyXSB2NGwyX20ybV9jYW5jZWxfam9iKG0ybV9jdHgpOw0K
PiA+ID4gDQo+ID4gPiAgIHZiMl9xdWV1ZV9yZWxlYXNlKCZtMm1fY3R4LT5jYXBfcV9jdHgucSk7
DQo+ID4gPiAgIHZiMl9xdWV1ZV9yZWxlYXNlKCZtMm1fY3R4LT5vdXRfcV9jdHgucSk7DQo+ID4g
PiANCj4gPiA+ICAga2ZyZWUobTJtX2N0eCk7DQo+ID4gPiB9DQo+ID4gPiANCj4gPiA+IE5vdGUg
dGhhdCBhbGwgb2YgdGhpcyBpcyBzdGF0aWMgYW5hbHlzaXMsIHdoaWNoIG1heSBiZSBmYWxzZQ0K
PiA+ID4gcG9zaXRpdmUuDQo+ID4gPiBGZWVsIGZyZWUgdG8gdGVsbCBtZSBpZiB0aGVyZSBpcyBz
b21ldGhpbmcgSSd2ZSBtaXNzZWQuDQo+ID4gPiANCj4gPiA+IFJlZ2FyZCwNCj4gPiA+IFpoZW5n
DQo+ID4gDQo+ID4gRGVhciBaaGVuZywNCj4gPiANCj4gPiBZb3Ugc2V0IHVwIGFuIGFwcGxpY2F0
aW9uIHNjZW5hcmlvOg0KPiA+IGNwdTEgaXMgdXNpbmcgdGhlIG10ay1qcGVnIGRyaXZlciBhbmQg
dGltZW91dCB3b3JrIGhhcyBiZWVuDQo+ID4gc2NoZWR1bGVkLg0KPiA+IEF0IHRoZSBzYW1lIHRp
bWUgY3B1MCB3YW50ZWQgdG8gcmVtb3ZlIHRoZSBtdGstanBlZyBkcml2ZXIsIHdoaWNoDQo+ID4g
Y2F1c2VkIHRoZSBVQUYgYnVnLg0KPiA+IEkgd29uZGVyIGlmIHN1Y2ggYW4gaXJyYXRpb25hbCBh
cHBsaWNhdGlvbiBzY2VuYXJpbyBjb3VsZCBleGlzdC4NCj4gPiBUaGlzDQo+ID4gc2NlbmFyaW8s
IGFzIHlvdSBkZXNjcmliZWQsIG5vdCBvbmx5IGxlYWRzIHRvIHRoZSBwcm9ibGVtcyB5b3UNCj4g
PiBtZW50aW9uZWQsIGJ1dCBhbHNvIHRvIG91dHB1dCZjYXB0dXJlIG1lbW9yeSBsZWFrcyBhbmQg
dW5yZWxlYXNlZA0KPiA+IHJlc291cmNlcywgc3VjaCBhcyBzcGlubG9jay4NCj4gPiBUeXBpY2Fs
bHksIGlmIHdlIHdhbnQgdG8gcmVtb3ZlIHRoZSBkcml2ZXIsIHdlIGZpcnN0bHkgZG8gc3RvcA0K
PiA+IHN0cmVhbWluZywgd2hpY2ggZW5zdXJlcyB0aGF0IHRoZSB3b3JrZXIgaGFzIGJlZW4gY2Fu
Y2VsZWQuDQo+ID4gSSBhZ3JlZSB3aXRoIHlvdXIgY2hhbmdlcyBmcm9tIHRoZSBwZXJzcGVjdGl2
ZSBvZiBzdHJlbmd0aGVuaW5nIHRoZQ0KPiA+IHJvYnVzdG5lc3Mgb2YgdGhlIGRyaXZlciBjb2Rl
Lg0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gS3lyaWUuDQo+ID4gPiANCj4gPiA+IElydWkgV2Fu
ZyAo546L55GeKSA8SXJ1aS5XYW5nQG1lZGlhdGVrLmNvbT4g5LqOMjAyM+W5tDPmnIg35pel5ZGo
5LqMIDE4OjIz5YaZ6YGT77yaDQo+ID4gPiA+IA0KPiA+ID4gPiBEZWFyIEFuZ2VsbyBhbmQgWmhl
bmcsDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ggYW5kIGNvbW1lbnRz
Lg0KPiA+ID4gPiANCj4gPiA+ID4gRGVhciBLeXJpZSwNCj4gPiA+ID4gDQo+ID4gPiA+IFBsZWFz
ZSBoZWxwIHRvIGNoZWNrIHRoaXMsIHRoYW5rcy4NCj4gPiA+ID4gDQo+ID4gPiA+IEJlc3QgUmVn
YXJkcw0KPiA+ID4gPiANCj4gPiA+ID4gT24gVHVlLCAyMDIzLTAzLTA3IGF0IDEwOjQ5ICswMTAw
LCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiBJ
bCAwNy8wMy8yMyAxMDoyNywgWmhlbmcgSGFja2VyIGhhIHNjcml0dG86DQo+ID4gPiA+ID4gPiBI
aSwNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSXMgdGhlcmUgYW55b25lIHdobyBjYW4gaGVs
cCB3aXRoIHRoaXM/IEkgY2FuIHByb3ZpZGUgbW9yZQ0KPiA+ID4gPiA+ID4gZGV0YWlscw0KPiA+
ID4gPiA+ID4gbGlrZSBpbnZva2luZyBjaGFpbiBpZiBuZWVkZWQuDQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBQcm92aWRpbmcgbW9yZSBkZXRhaWxzIGlzIGFsd2F5cyBnb29k
LiBQbGVhc2UgZG8uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gTWVhbndoaWxlLCBhZGRpbmcgSXJ1
aSBXYW5nIHRvIHRoZSBsb29wOiBoZSdzIGRvaW5nIG10ay1qcGVnLg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+ID4gQW5nZWxvDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiBUaGFua3MsDQo+ID4gPiA+ID4gPiBaaGVuZw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBa
aGVuZyBXYW5nIDx6eXl0bHoud3pAMTYzLmNvbT4g5LqOMjAyM+W5tDPmnIg25pel5ZGo5LiAIDE0
OjI45YaZ6YGT77yaDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJbiBtdGtfanBlZ19w
cm9iZSwgJmpwZWctPmpvYl90aW1lb3V0X3dvcmsgaXMgYm91bmQgd2l0aA0KPiA+ID4gPiA+ID4g
PiBtdGtfanBlZ19qb2JfdGltZW91dF93b3JrLiBUaGVuIG10a19qcGVnX2RlY19kZXZpY2VfcnVu
DQo+ID4gPiA+ID4gPiA+IGFuZCBtdGtfanBlZ19lbmNfZGV2aWNlX3J1biBtYXkgYmUgY2FsbGVk
IHRvIHN0YXJ0IHRoZQ0KPiA+ID4gPiA+ID4gPiB3b3JrLg0KPiA+ID4gPiA+ID4gPiBJZiB3ZSBy
ZW1vdmUgdGhlIG1vZHVsZSB3aGljaCB3aWxsIGNhbGwgbXRrX2pwZWdfcmVtb3ZlDQo+ID4gPiA+
ID4gPiA+IHRvIG1ha2UgY2xlYW51cCwgdGhlcmUgbWF5IGJlIGEgdW5maW5pc2hlZCB3b3JrLiBU
aGUNCj4gPiA+ID4gPiA+ID4gcG9zc2libGUgc2VxdWVuY2UgaXMgYXMgZm9sbG93cywgd2hpY2gg
d2lsbCBjYXVzZSBhDQo+ID4gPiA+ID4gPiA+IHR5cGljYWwgVUFGIGJ1Zy4NCj4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+IEZpeCBpdCBieSBjYW5jZWxpbmcgdGhlIHdvcmsgYmVmb3JlIGNs
ZWFudXAgaW4gdGhlDQo+ID4gPiA+ID4gPiA+IG10a19qcGVnX3JlbW92ZQ0KPiA+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ID4gQ1BVMCAgICAgICAgICAgICAgICAgIENQVTENCj4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIHxtdGtfanBlZ19qb2JfdGlt
ZW91dF93b3JrDQo+ID4gPiA+ID4gPiA+IG10a19qcGVnX3JlbW92ZSAgICAgfA0KPiA+ID4gPiA+
ID4gPiAgICB2NGwyX20ybV9yZWxlYXNlICB8DQo+ID4gPiA+ID4gPiA+ICAgICAga2ZyZWUobTJt
X2Rldik7IHwNCj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ID4gPiA+
ID4gPiAgICAgICAgICAgICAgICAgICAgICB8IHY0bDJfbTJtX2dldF9jdXJyX3ByaXYNCj4gPiA+
ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgfCAgIG0ybV9kZXYtPmN1cnJfY3R4IC8vdXNl
DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBaaGVuZyBXYW5n
IDx6eXl0bHoud3pAMTYzLmNvbT4NCj4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiA+ICAg
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9qcGVnL210a19qcGVnX2NvcmUuYyB8DQo+
ID4gPiA+ID4gPiA+IDIgKy0NCj4gPiA+ID4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IGRp
ZmYgLS1naXQNCj4gPiA+ID4gPiA+ID4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVr
L2pwZWcvbXRrX2pwZWdfY29yZS5jDQo+ID4gPiA+ID4gPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9tZWRpYXRlay9qcGVnL210a19qcGVnX2NvcmUuYw0KPiA+ID4gPiA+ID4gPiBpbmRleCA5
Njk1MTZhOTQwYmEuLjM2NDUxM2U3ODk3ZSAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gLS0tDQo+ID4g
PiA+ID4gPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9qcGVnL210a19qcGVn
X2NvcmUuYw0KPiA+ID4gPiA+ID4gPiArKysNCj4gPiA+ID4gPiA+ID4gYi9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL21lZGlhdGVrL2pwZWcvbXRrX2pwZWdfY29yZS5jDQo+ID4gPiA+ID4gPiA+IEBA
IC0xNzkzLDcgKzE3OTMsNyBAQCBzdGF0aWMgaW50IG10a19qcGVnX3Byb2JlKHN0cnVjdA0KPiA+
ID4gPiA+ID4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPiA+ID4gPiA+ICAgc3RhdGlj
IGludCBtdGtfanBlZ19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiA+ID4gPiA+ID4g
PiAqcGRldikNCj4gPiA+ID4gPiA+ID4gICB7DQo+ID4gPiA+ID4gPiA+ICAgICAgICAgIHN0cnVj
dCBtdGtfanBlZ19kZXYgKmpwZWcgPQ0KPiA+ID4gPiA+ID4gPiBwbGF0Zm9ybV9nZXRfZHJ2ZGF0
YShwZGV2KTsNCj4gPiA+ID4gPiA+ID4gLQ0KPiA+ID4gPiA+ID4gPiArICAgICAgIGNhbmNlbF9k
ZWxheWVkX3dvcmsoJmpwZWctPmpvYl90aW1lb3V0X3dvcmspOw0KPiA+ID4gPiA+ID4gPiAgICAg
ICAgICBwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQo+ID4gPiA+ID4gPiA+ICAgICAg
ICAgIHZpZGVvX3VucmVnaXN0ZXJfZGV2aWNlKGpwZWctPnZkZXYpOw0KPiA+ID4gPiA+ID4gPiAg
ICAgICAgICB2NGwyX20ybV9yZWxlYXNlKGpwZWctPm0ybV9kZXYpOw0KPiA+ID4gPiA+ID4gPiAt
LQ0KPiA+ID4gPiA+ID4gPiAyLjI1LjENCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gDQo=
