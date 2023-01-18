Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F363671081
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjARCD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjARCDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:03:11 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0574B54210
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:02:22 -0800 (PST)
X-UUID: 1ee9417096d411eda06fc9ecc4dadd91-20230118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MXjRsdc3n1PE3Zd9kMsNsLPNMAHg2Z4h3MyoiHETM+4=;
        b=bdvf3vcs6mmvUcMTJK/p0x82zpiKU5hx0r/tpW4Q5c9z0YmzGuP271XDc1KebqLWQhxoO8WnXeR6nZ2Ml/Ch5CykHzyhiXBFS+E9vpQP3woyXhbsmtUrEQ/lyfQMLr/+F5dhgaLh+1F5BDP1gmI2lTuJRlZCrvC6ie9EfH1ZhFM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:85ee7e11-b57b-4788-8995-f4df26871d6f,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:3ca2d6b,CLOUDID:2f6c8e8c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 1ee9417096d411eda06fc9ecc4dadd91-20230118
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2138096854; Wed, 18 Jan 2023 10:02:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 18 Jan 2023 10:02:10 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 18 Jan 2023 10:02:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMjuMR0kPDfWlIF0W8gXYc79FwWCv6k9DJzlvw/HBqppwQzZyukaJgJD4DtXyHveOLkCBggOWuDSHhpnCMWWCiM2mys148ww7Tv3Fnx7Cplabm9NeXBkw+yP+hIdtXR5vRsBGB5EC2BmGifJNu1ycJ7Oi6HsASSyVXoqSkzkAvw3tIdH9UZxndsfOUd8juYAkTbt5Ey3uVBdsfMd3iA2VvKqz/OUCAuiCMX+oFku1tMrDQ/uFvT6M5mEXr+JBxgniWakWSJYmSYftbb1SN10mY1nw2lfd6Pa0lYc9Y2S0p2a1dOT6LxtfmoX6Byj5JuzZBljI+0HoS4H140qMA+dUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXjRsdc3n1PE3Zd9kMsNsLPNMAHg2Z4h3MyoiHETM+4=;
 b=PIwF/G+II+Zl/ilAGLR2UYkxgZEKEJ3izy5GGtkKGalTxpRkjyWTEOqNluGsEjJwl2qCA4qukB2+5SV4ELhdfNsMKOj+6Ju0/LYJtlEnpQ12T2pYFNpca8eljejI2o+kR28eaS2KR94A5/STcV7BhCBY+W8B4zLdJDUxsxVRlOb8/vh/5sH09pM+syLC75GgiaaOhweP1hb7W1E1ibxuZKA/MxBtac4tTKcSDJZhYOccDm4RcKnbUH2l3sajGusss0loaAoh2W+Fq9fDG3/p5iHyZEG6Dq0XroGbdQOkkUC0mJhSL8LwcxbRqgU03Fz/quRi+5hnwF4LfR4Lp4t7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXjRsdc3n1PE3Zd9kMsNsLPNMAHg2Z4h3MyoiHETM+4=;
 b=aghA5fllxFbWIjSKQ09VYRe/jhlECyF7oEaGvGRO0yr9uCdyNRkJ9jUlF1hAi/5dPhCqTvkXmxlFbtjs/ALBg26mPuYQYYR11fZvbmxBFIqXRwB4oILLDmdk1RhlUN6VD3w7SkpamgmrTBjhc1vaO+AJV8SwpdpVbhZF11GBM3s=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR0302MB5187.apcprd03.prod.outlook.com (2603:1096:820:44::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 18 Jan
 2023 02:02:08 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1%3]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 02:02:08 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v6 3/3] phy: mediatek: tphy: add debugfs files
Thread-Topic: [PATCH v6 3/3] phy: mediatek: tphy: add debugfs files
Thread-Index: AQHZIEA44YFL/mrrbEuqD9Ku1qRfkq6ctaeAgAbLkwA=
Date:   Wed, 18 Jan 2023 02:02:07 +0000
Message-ID: <1036fcf7661d0b6544c416fd8c9423836b9eb1e9.camel@mediatek.com>
References: <20230104132646.7100-1-chunfeng.yun@mediatek.com>
         <20230104132646.7100-3-chunfeng.yun@mediatek.com> <Y8Gf2xxq7iaV/+ax@matsya>
In-Reply-To: <Y8Gf2xxq7iaV/+ax@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|KL1PR0302MB5187:EE_
x-ms-office365-filtering-correlation-id: 0e08967e-c71a-4780-0c2a-08daf8f80102
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w0w7J8W14YEB97RUZzc0g/GJxEKWdnnMqq7GtIlAQ4ib+62hipsfVJWDhlLhZC0TAP133mXttNMzrgJOLsiildHi2G9lyT9DecV4FF5W6oDxBKgEnjTZkYWZfXNBH7aPa9OPTz487cw+FjT30m2xR/ChXE/IcGPO2o7OWwZ3Yzy+7o+96Qv3lZdh5r4Qx/9HnUjtuFos01ZTDemKap4yFk/hnEOE9OZKizfnMax3wlbk+u1ExWU8dmSjXSu2baDzuQzWPQ2IKOAn2Ho3C8hWpR/6U0f60AkSV+wdgCjQ1lxreYeCbl3B0hqMWk0vJTBrLG1HbF4n67fzwhD0x13PNc92Uy+j7M4BorVLER0o2RD7aSuZjw/U9GF0+9YvxSI8i6GJCwIBa3GCWjS1cgJt1EOx5Hi5i9bHwNBxboq1gs+TduxwNBjtgL3Na3KbxlJhHEPOZLh8DUg+mC2eyXAywZb0A2GIMfRSD7pQPv47j8Vvp80LYZjFP5fRbFm1c12CGzaajZM4F85NjuuqDXY+PhxtX6ffme6Ve27YjcSkkN5wp7s5Xaxo9WZBo+3n/0pn5RcGC8lxTFwpmS6NXmtVFvUzzT2hhjRF1a0Pj2MJAEEVFV0vRgEqISVj3X7Fu/kSBApYSHZGtzpaz0tuW0VkNl38/LNoYCGujGA9E8nw99BX2J9RUEzIqPoFhY3NTzBUu2OoQ9W6CGqAdVos9HO0Vw4XydAUNdEqLJZUjO0qC1SzRZg+EE+GmAg0JCXP4uh/25AtoY/5HrAXh5JYBARQDrNFXBSxriSQYEXTpjAawOo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(6512007)(38070700005)(71200400001)(122000001)(478600001)(38100700002)(36756003)(53546011)(6486002)(966005)(6506007)(186003)(86362001)(85182001)(66946007)(8936002)(41300700001)(5660300002)(26005)(8676002)(66446008)(6916009)(66476007)(76116006)(64756008)(66556008)(83380400001)(91956017)(2616005)(316002)(54906003)(4326008)(7416002)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjlGMVVaZk02Nk0xNXBQNlNNVDJoYStvd3lmTjFJZnR2SHNvc1VXVGlJaFlU?=
 =?utf-8?B?TzNyNFRONWZmS1BQNnJkSFlyQ3V5SFdlcWJFYVBTVzNqR3RFRVE4Y3RlVzlZ?=
 =?utf-8?B?LzFZamdTQzlpaGhWaW1Dc0JoQUtEL2Y3VjlrTG94VkxscTZscXRETFE5K0tM?=
 =?utf-8?B?aEoyQjdJa0M4NEZhcEJBVXgzQzRZc2swdzRIOE51RmhnZEZtVFl6a1RDYVJE?=
 =?utf-8?B?SlZUM09hdmFtajRIMXJHVTZWYmdMVEZVMkRXd0E4YmRjbUpzKzNtZTAvRlBL?=
 =?utf-8?B?MlBKYmZJanhyRGw0VFB0UmNBcDJUb1ZXOVg1R3pXSlNwdzAxZUNzMGpobStv?=
 =?utf-8?B?Z2pqTjdoVy9pU0xhSEg2YUJuWWdralk5djhLWW1XNHR1eHN6c0dPNVpWeDV3?=
 =?utf-8?B?YndlQzFsY2tYczlxR2cwdm1jbDJkR1UrVFNzbmE1U1UvWkdlTlRHYWJZOE9r?=
 =?utf-8?B?cysxSzE5MXByTXhWczUvRHV4ZU9OeXJrTEpCanN4YlVzejZPYVduUGl2UVBE?=
 =?utf-8?B?aEJ6Sk9Dc3NpUEZUNXZQU0FrRFB4TDZTdC92aE9zTjVud1ZmVHJyNHAvam5M?=
 =?utf-8?B?clZFeGV5N0x6TUxpc2JMdTJSdGhucEZEdzQ3OW9RWm9ZckZpOFplSldCamMv?=
 =?utf-8?B?b3ZBeDdWc2V0ZEZNK29lek81NWlFRjVNUk1Jak56VVhxZ1dYMXc5QXJuY2pt?=
 =?utf-8?B?ajBYUS84d2NkL21HOUQxeHdTOGxZN2tkbDJ2aUxoTlBhVis3aEJsV3JDMDJk?=
 =?utf-8?B?d201dXcrZnpabjRNUS9MMVZHazgwK29ZeVhmZDkyajMxZm9VS0ZrVU5aZnFK?=
 =?utf-8?B?bHdycndKcWpQcUVJMlBuRk9ISGV2SkxQV1l4OTU0d3VuS2lYTjN4cDVFNlZ5?=
 =?utf-8?B?Nllwa0RqWWZhSEFBVzYrQlFxdm1KcjMyeEV1WmFVNmxIdjFkSTZSUHRHckFq?=
 =?utf-8?B?QUNBd1RNL0lhd2g0Q0JtU0xGeExIalA5NVlFM053QVdxcmdpckdHZEVWMFE1?=
 =?utf-8?B?TjZINllqVWhDMWpaRGRHNkx6aitkYjEwMnB4MGE4RDIvQzFKMCtxdEVVcUZm?=
 =?utf-8?B?cEp6Tm9ORjhJK3c5UkJYRUk1cGJTUDAyVUs1UVVrRG5qK1diMHN0bUx0K0lY?=
 =?utf-8?B?ZFptazRvSXdPS1hveHNNNzdYN0RPU2wxcE9QamQ1QVVuaDRrUFBsZWxDSWFN?=
 =?utf-8?B?VmtMTU9SaWdHbHhNODd5WnFWUTV1dU5iM0Y1YnlvUEMvUFk2NnhYZElDekdG?=
 =?utf-8?B?N3lIQVlUQlNmcGFpZUtUc3p5ZHNTcXlZTmRWZU9rbUVSL2lIczJvTHdHb2tm?=
 =?utf-8?B?YTZRYUM4N2swT2I2NmplNFNZdzhrS2N0aVg1YmNJL3VYeGxkSTI1a09GV3dV?=
 =?utf-8?B?QWNya3hadmpSUXBQc0RFK3hFN2o3MDZPUXliRmVXdm0vTFJDOWFIckZxK0Fj?=
 =?utf-8?B?ay9TOVcvVzYzVThyWmdJWGgrZ0tUeVVqaWJhdVdkNk0xQUxIYmJrdkVaQ2lY?=
 =?utf-8?B?SVN4UDRybHRoODJITlloQ1p0bnZKRElXTStrYkN5WWtkNU9jMDN6SktKWmVE?=
 =?utf-8?B?NXNJRmdiNjJVR3VZT0EvVk9jRlRQck1Ka0wvQjlicG9QRGMzTFpabkNaVDFr?=
 =?utf-8?B?MlBjUDNJZDNtRENVSit2NlNlSXlqRy9aTlRYa3Y3aG00ZWE2Y2lCdFpNT00v?=
 =?utf-8?B?VkhVaWVNaFBJRXZHWWRiaGVZMzgvWHNtOXFvcXhEUzRkY1Q5TDU4RGZJejZQ?=
 =?utf-8?B?T2pSUWJ0UnZTRStDakNqaDRsb29pTlVJRzZMbnlZUnhQUExBSTlvR3gzdTlF?=
 =?utf-8?B?THpLb3lSR3VNQmxMd1hiUysrNHZQZ1R5ZGRaMTg0OG1Xc0RNWmFRS0JadnJ3?=
 =?utf-8?B?dW9RM21lTnBrL0F6MTgzK0VVUVdVdktHaEtEdlZMcTJLczBaOEJuZm94anBj?=
 =?utf-8?B?NVhCQVRYOEpaaUZ0S3E5ekdOL2FEZmFmamNFS2JCYnlFZ3pYSWNRYmR5aFhk?=
 =?utf-8?B?T2lQMUNxRkgwc0QrMVlBQmxmTDZ1Uk5ZSTR2UzhwSno2TVRBSUJzRFB0MDlJ?=
 =?utf-8?B?TnVoTWRSTmVGdmpTd1ZZTGo1UkRpTGUvS2VTeUc1VUtlTnMrMTR5bEdaRzEv?=
 =?utf-8?B?RmNPdHNYVDdVUjUwamxMQTkxYWkvZ1htMnpTL0tVQ3p6N1AvMzk3bDlJeVho?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBC697252BE99E4AB0CED0A0D89A6965@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e08967e-c71a-4780-0c2a-08daf8f80102
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 02:02:07.8679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fo3iTmugtZDwIctUkTJpiHaONR108hfoEnLcfp+Jinz6Tq+MxOJiAEo2mFWzrl24NCOhhR6LAJzVYQO8tWYPibA9qd4X0qWzGaNLZ5F4Qqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5187
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTEzIGF0IDIzOjQ1ICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBP
biAwNC0wMS0yMywgMjE6MjYsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiBUaGVzZSBkZWJ1Z2Zz
IGZpbGVzIGFyZSBtYWlubHkgdXNlZCB0byBtYWtlIGV5ZSBkaWFncmFtIHRlc3QNCj4gPiBlYXNp
ZXIsDQo+ID4gZXNwZWNpYWxseSBoZWxwZnVsIHRvIGRvIEhRQSB0ZXN0IGZvciBhIG5ldyBJQyB3
aXRob3V0IGVmdXNlDQo+ID4gZW5hYmxlZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVu
ZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjY6IG5v
IGNoYW5nZXMNCj4gPiANCj4gPiB2NTogdXNpbmcgY29tbW9uIGRlYnVnZnMgY29uZmlnIENPTkZJ
R19ERUJVR19GUw0KPiA+IA0KPiA+IHY0OiBmaXggYnVpbGQgd2FybmluZyBvZiBzb21ldGltZXMg
dW5pbml0aWFsaXplZCB2YXJpYWJsZQ0KPiA+IA0KPiA+IHYzOiBmaXggdHlwbyBvZiAiZGVidWdm
cyIgc3VnZ2VzdGVkIGJ5IEFuZ2Vsb0dpb2FjY2hpbm8NCj4gPiANCj4gPiB2MjogYWRkIENPTkZJ
R19QSFlfTVRLX1RQSFlfREVCVUdGUyBzdWdnZXN0ZWQgYnkgQW5nZWxvR2lvYWNjaGlubw0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYyB8IDQwNQ0KPiA+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQwNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQo+ID4gYi9kcml2ZXJzL3BoeS9tZWRpYXRl
ay9waHktbXRrLXRwaHkuYw0KPiA+IGluZGV4IGU5MDZhODI3OTFiZC4uOTIzZTVlZTExOWYzIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQo+ID4g
KysrIGIvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay10cGh5LmMNCj4gPiBAQCAtNyw2ICs3
LDcgQEANCj4gPiAgDQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9waHkvcGh5Lmg+DQo+ID4g
ICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2RlYnVnZnMuaD4N
Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9pb3Bv
bGwuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCj4gPiBAQCAtMjY0LDYg
KzI2NSw4IEBADQo+ID4gIDxza2lwPg0KDQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCB0cGh5X2Rl
YnVnZnNfaW5pdChzdHJ1Y3QgbXRrX3RwaHkgKnRwaHksIHN0cnVjdA0KPiA+IG10a19waHlfaW5z
dGFuY2UgKmluc3QpDQo+ID4gK3sNCj4gPiArCWNoYXIgbmFtZVsxNl07DQo+ID4gKw0KPiA+ICsJ
c25wcmludGYobmFtZSwgc2l6ZW9mKG5hbWUpIC0gMSwgInBoeS4lZCIsIGluc3QtPmluZGV4KTsN
Cj4gDQo+IEkgd291b2xkIHN1Z2dlc3QgZHJpdmVyIG5hbWUvIGRldmljZSBuYW1lIHJhdGhlciB0
aGFuIHBoeS5mb28uLi4NCj4gYWdhaW4NCj4gZm9sa3MgbmVlZHMgdG8gc2VlIHdoYXQgaXMgZm9v
DQo+IA0KSSBjb21wYXJlIHRoZSB3YXkgeW91IHN1Z2dlc3RlZCBhZ2FpbiBvbiBtdDI3MTIgcGxh
dGZvcm0gdGhhdCBoYXZlIHR3bw0KcGh5IGNvbnRyb2xsZXIsIHQtcGh5QDExMjkwMDAwIFsxXSBh
bmQgdC1waHlAMTEyZTAwMDAgWzJdLA0KWzFdOiANCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L2xhdGVzdC9zb3VyY2UvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDI3MTJl
LmR0c2kjTDgyNw0KWzJdOg0KDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRl
c3Qvc291cmNlL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpI0w4OTEN
Cg0KDQpFYWNoIHBoeSBjb250cm9sbGVyIGRyaXZlciB3aWxsIGNyZWF0ZWQgYSByb290IGZvbGRl
ciBhY2NvcmRpbmcgaXRzDQpkZXZpY2UgbmFtZSB1bmRlciAiL3N5cy9rZXJuZWwvZGVidWcvcGh5
IiwgbGlrZSBhczoNCiNscyAvc3lzL2tlcm5lbC9kZWJ1Zy9waHkNCnQtcGh5QDExMjkwMDAwICB0
LXBoeUAxMTJlMDAwMA0KDQpUaGUgcGh5IGNvbnRyb2xsZXIgaGFzIHNvbWUgc3VicGh5IG5vZGUs
IGVhY2ggb25lIGluZGljYXRlIGEgcGh5DQpzdHJ1Y3QsIGlmIHVzZSB0aGUgcGh5IGRldmljZSBu
YW1lIHRvIGNyZWF0ZSBhIGZvbGRlciwgaXQgc2hvd3MgYXMNCmJlbG93Og0KI2NkIC9zeXMva2Vy
bmVsL2RlYnVnL3BoeQ0KIyBscyAqDQp0LXBoeUAxMTI5MDAwMDoNCnBoeS10LXBoeUAxMTI5MDAw
MC4wICBwaHktdC1waHlAMTEyOTAwMDAuMQ0KDQp0LXBoeUAxMTJlMDAwMDoNCnBoeS10LXBoeUAx
MTJlMDAwMC4zICBwaHktdC1waHlAMTEyZTAwMDAuNCAgcGh5LXQtcGh5QDExMmUwMDAwLjUNCg0K
cGh5J3MgZGV2aWNlIG5hbWUgaXMgY3JlYXRlZCBhczoNCiJkZXZfc2V0X25hbWUoJnBoeS0+ZGV2
LCAicGh5LSVzLiVkIiwgZGV2X25hbWUoZGV2KSwgaWQpIg0KDQpkZXZfbmFtZShkZXYpIGlzIHRo
ZSBwYXJlbnQgbmFtZSwgaXQncyB0LXBoeUAxMTI5MDAwMCBhbmQgDQp0LXBoeUAxMTJlMDAwMCBp
biBleGFtcGxlLCBpZCBpcyB0aGUgcGh5LT5pZC4NCg0Kc2VlbXMgbm8gbmVlZCB0byBwcm92aWRl
IHBhcmVudCBuYW1lIGFnYWluLg0KYW5vdGhlciBwcm9ibGVtIGlzIHRoYXQgdGhlIGlkIG1heSB2
YXJ5IGlmIG90aGVyIHBoeXMgYXJlIGVuYWJsZWQsIHRoYXQNCm1lYW5zIHRoZSBwYXRoIG1heSB2
YXJ5LCBpdCdzIGRpZmZpY3VsdCB0byB3cml0ZSBzY3JpcHRzIHRvIGRvIHRlc3QuDQoNCndoZW4g
dXNlIHRoZSBjdXJyZW50IHdheSwNCiJzbnByaW50ZihuYW1lLCBzaXplb2YobmFtZSkgLSAxLCAi
cGh5LiVkIiwgaW5zdC0+aW5kZXgpIg0KaXQgc2hvd3MgYXM6DQojIGxzICoNCnQtcGh5QDExMjkw
MDAwOg0KcGh5LjAgIHBoeS4xDQoNCnQtcGh5QDExMmUwMDAwOg0KcGh5LjAgIHBoeS4xICBwaHku
Mg0KDQpAaW5zdC0+aW5kZXggaXMgdGhlIHNlcXVlbmNlIG51bWJlciBvZiBzdWJwaHkgbm9kZSBp
biBlYWNoIHBoeQ0KY29udHJvbGxlcidzIG5vZGUsIHdoZW4gdGhlIGR0cyBpcyBmaXhlZCwgdGhl
IEBpbmRleCBpcyBhbHNvIGZpeGVkLA0KdGhlbiBmb3IgZWFjaCBwaHksIHRoZSBwYXRoIGlzIGFs
c28gZml4ZWQsIHNlZW1zIG1vcmUgY29udmVuaWVudCB0bw0Kd3JpdGUgc2NyaXB0cy4NCg0KU28g
SSBwcmVmZXIgdG8gbGVhdmUgdGhlIGNvZGUgdW5jaGFuZ2VkLg0KDQpUaGFua3MgYSBsb3QNCg0K
PiANCj4gPiArCWluc3QtPmRiZ2ZzID0gZGVidWdmc19jcmVhdGVfZGlyKG5hbWUsIHRwaHktPmRi
Z2ZzX3Jvb3QpOw0KPiA+ICsNCj4gPiArCWRlYnVnZnNfY3JlYXRlX2ZpbGUoInR5cGUiLCAwNDQ0
LCBpbnN0LT5kYmdmcywgaW5zdCwNCj4gPiAmdHBoeV90eXBlX2ZvcHMpOw0KPiA+ICsNCj4gPiAr
CXN3aXRjaCAoaW5zdC0+dHlwZSkgew0KPiA+ICsJY2FzZSBQSFlfVFlQRV9VU0IyOg0KPiA+ICsJ
CXUyX3BoeV9kYmdmc19maWxlc19jcmVhdGUoaW5zdCk7DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwlj
YXNlIFBIWV9UWVBFX1VTQjM6DQo+ID4gKwljYXNlIFBIWV9UWVBFX1BDSUU6DQo+ID4gKwkJdTNf
cGh5X2RiZ2ZzX2ZpbGVzX2NyZWF0ZShpbnN0KTsNCj4gPiArCQlicmVhazsNCj4gPiArCWRlZmF1
bHQ6DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwl9DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2
b2lkIHRwaHlfZGVidWdmc19leGl0KHN0cnVjdCBtdGtfcGh5X2luc3RhbmNlICppbnN0KQ0KPiA+
ICt7DQo+ID4gKwlkZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNpdmUoaW5zdC0+ZGJnZnMpOw0KPiA+ICsJ
aW5zdC0+ZGJnZnMgPSBOVUxMOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCB0cGh5
X2RlYnVnZnNfcm9vdF9jcmVhdGUoc3RydWN0IG10a190cGh5ICp0cGh5KQ0KPiA+ICt7DQo+ID4g
Kwl0cGh5LT5kYmdmc19yb290ID0gZGVidWdmc19jcmVhdGVfZGlyKGRldl9uYW1lKHRwaHktPmRl
diksDQo+ID4gcGh5X2RlYnVnX3Jvb3QpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9p
ZCB0cGh5X2RlYnVnZnNfcm9vdF9yZW1vdmUoc3RydWN0IG10a190cGh5ICp0cGh5KQ0KPiA+ICt7
DQo+ID4gKwlkZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNpdmUodHBoeS0+ZGJnZnNfcm9vdCk7DQo+ID4g
Kwl0cGh5LT5kYmdmc19yb290ID0gTlVMTDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArI2Vsc2UNCj4g
PiArPHNraXA+DQo=
