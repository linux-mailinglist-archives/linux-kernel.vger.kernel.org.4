Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14E2653DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiLVKEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbiLVKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:03:49 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EC126AB9;
        Thu, 22 Dec 2022 02:02:34 -0800 (PST)
X-UUID: 9a19ff4edcfa40199c776c181ad9e527-20221222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vPhfx6UhW8gxZI3+eFGe0W4wGRrKKvTrV6JdigN9Q0k=;
        b=hDP+CvLMd1Vb0AOQcemQEZ6iZwOtCwgTXpi7AQioI7YfQjd4J0z6gofCzkL6R+0pXuShYzHHix07AeQG76NjLq6WPtfzDVmPnr0Ri05/1LB/Gh9DkVUwuT4BCosy1B4cMAEEe/TidIYxMaCv3L/DtWQuaaaeCJNkADMOcXhhx9k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:ad3b18f0-1567-4606-8422-f5a50182c899,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:ad3b18f0-1567-4606-8422-f5a50182c899,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:a9258152-dd49-462e-a4be-2143a3ddc739,B
        ulkID:221222180231J1CL3HZA,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9a19ff4edcfa40199c776c181ad9e527-20221222
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1321581445; Thu, 22 Dec 2022 18:02:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 22 Dec 2022 18:02:28 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 22 Dec 2022 18:02:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiiAMBJjqhM8XiaH35G0E/SQdDBlQ2t76JBeqOuBxndtxRefGBmViWq2ROsaNXE6qlTOiFDuuhzIzdYA2mdgc6XCwHDhRq+Ljoha9n0+nU7a4fAcG5DVGq25UxABMhJaqYtSSV2RWiLIdxFlL3BHIeo7r/SxK590rCvysdIV0ISjjtEfxa9hPLAHSZ3XIUKtyIhV9ThGtPnsYFCUQTrss1BOh+rUE5kaQf4svhCCYEJcBmU4gVGmBIL1k56LHctOdCNVhKK6KRggUpXsCq2cJaPeyP+BPhvmXbQ18ziy+I5qeVUM2CZMuZTlVokRU7ystoedcrE2/e9husw1XE9BcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPhfx6UhW8gxZI3+eFGe0W4wGRrKKvTrV6JdigN9Q0k=;
 b=St4pjIjuHsg92I1uuH/S7i8RU2/0TC/2HTyVYNrlrVVBd+l5qX0yMkBFvvuEF/Ky7oz2YMy6k2cnWIy97Q8A860yZl39mIHIU0vRxxi9r0Nd6cYSwPg6FS9HygfkPkjrCz9Lnu1Un7JmMwPAjREo7y/57Vas6Cwa+E9Bp+3KZWSMZ5EQGVD0Cz617PV+RBuJ/5FGp8F6Z0UdmPSk0Ey0CcAEvcZwyZgllYFI1Kn0LFUlULme/9lvmSYsit+TsX+F4UY8SU5syYmW+DYQwcp/ytt1Bk9bZFrM1GrT9dTjkV4yZtW4XqHzbKfj7l1IIFb0Iy7MB3c1FP+xfLnogp0iyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPhfx6UhW8gxZI3+eFGe0W4wGRrKKvTrV6JdigN9Q0k=;
 b=L+UtB8TMyN/Uc8a1NVYdzTmA/2UB4R8eys/WnD9KVEEgwPOYcBz7lZHtc/uO+bo5UZUZ7SyHpSsJlfJhKRPa7qiXXQOSnaPNHajD0Z9G3UJML0TWSucSZJ4a8Qr0Cy9h0Akd6IRgMzZA4t71sIRcb/8HCMiy/fBMCBqbYMdyJm8=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SI2PR03MB5564.apcprd03.prod.outlook.com (2603:1096:4:129::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Thu, 22 Dec 2022 10:02:27 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4139:bb22:3bf9:f1e3]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4139:bb22:3bf9:f1e3%6]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 10:02:27 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v5 2/4] iommu/mediatek: Adjust mtk_iommu_config flow
Thread-Topic: [PATCH v5 2/4] iommu/mediatek: Adjust mtk_iommu_config flow
Thread-Index: AQHZCI8fNr2jEiArG0GG7BTfBl1pw655x94A
Date:   Thu, 22 Dec 2022 10:02:27 +0000
Message-ID: <26c16dcd2f9f02b860ce6f7a56aeef3be5c46856.camel@mediatek.com>
References: <20221205095001.31918-1-chengci.xu@mediatek.com>
         <20221205095001.31918-3-chengci.xu@mediatek.com>
In-Reply-To: <20221205095001.31918-3-chengci.xu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SI2PR03MB5564:EE_
x-ms-office365-filtering-correlation-id: 6326edbb-94c6-40f3-b143-08dae403a171
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fiNnK6FTRNQa6bK6AjqnBaM7A2J14oGB6ADDRbFYOzvuW78UjihsUNndw+yoCsBZQg3wJjevw76kTNDw2ounjjBkaYCucykDglE/XQWCYCWD/OFgKULS0nIB9USv4q2YLTk56BwvdZ2/M3t+JCZwiGr/MdWjXYEiEBhrRkVslaTLRmpOeeVHjucURZtsPL1ysFyi3L0Ndz+MY+8w5kTy2wE88ysvGe40JAUS7Ld4v30ItSA1hsC2ScXRTDF7KfAeAqbAgvnHUWx69602MuB1MUWKRXHCMphAS2CErYJSa2Oum4nW5FXdot5LH+fV6Zpo1nMhhpOT/JHgu82ZJSDoya7t2lIG5mJpCGWO7+P6el9LTtG3toTms2I9uJUjHbHMGHehU7eaZa5PfoEFeN0qB7M151Pg0dbHAg6gBdBvXmp3HeUg6nlo5dMuNFc3aDIT7N02HpQlBwmIPZREs8FAZOj1FqOVxbLAsL9PZOyAewevUa1iO+hDw+zH86EvefKTXHi19ya62DjySGbyeL5lQSHO5v3+E83mvdiEAQDT5obZ0eK2n/x+xo73ldcGuZ4EuPETRCls/VgPQ17uKnqxTFLO+FVu2HJzgzjYDfGlq4Yn3bBqoGl5gLlIFy/bOkP6bu4Tvi0/3bDCI0T6y1sN7Q1hS7IoNShpCQ0ZopXf0mdJ/n5+KJdaPevoSzGYfzAyTbjUIRrK8W4RAvZZZuiKKMgXt09PDNCGb17LSzddDWnDOlTIPHp+nYeC5znAS/mvjR3afYpowlip93MwDUf2Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199015)(110136005)(26005)(54906003)(316002)(83380400001)(85182001)(66556008)(6512007)(186003)(71200400001)(8936002)(36756003)(66946007)(7416002)(4744005)(38070700005)(2906002)(5660300002)(66446008)(38100700002)(64756008)(66476007)(4326008)(122000001)(76116006)(2616005)(8676002)(91956017)(478600001)(86362001)(41300700001)(6486002)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmlEcjk3K0hxRFlkMVAwWjg3VmpldG11anVpaFh0aGpsNk05MVZyT1JRN3pB?=
 =?utf-8?B?enlpNEY1MzkvcTN0dDlBMWVNamI4dGZKUFpqUUZIbTJqcUh0aW55RlZ0THRj?=
 =?utf-8?B?R01Tanc2SE5vY3FUdmJwSUFsVy9sWHZxZDBVNU9saTl1MVR5ZjRSam5yTGc1?=
 =?utf-8?B?NTNVMXE1YUpWNytMbjhITE5HRHA4SktqTzBIUVFGS1VmcG4wL2xOWm9pUjV0?=
 =?utf-8?B?SDM3Q3ljMHFPTDk4ZHZxeVE0cTdmeGZ3eFpwQjRRbHJQZTU1TmFpa1VWRklu?=
 =?utf-8?B?ODl1UjNteE11K3dIV25iT0xYN2xxZEdiazljWFVuRElEYVZPVjBCWW1BTjMz?=
 =?utf-8?B?Skx0dVppR1l4Z0hqb2dUS0xQNG1HQklVT3NYbW5GZU5kTG95SGNMUGhmditM?=
 =?utf-8?B?SVVoa1U3ZE1sTVpweVphNjE4QTIzV3o4MU4vb2dVdmNRTEYrazA0a0VSbUh2?=
 =?utf-8?B?bmd2NTZoRUZPVDVOOWtXb1ZOdk5vaGlMSHova25tZExzdkZYaEdTSlgyQzNT?=
 =?utf-8?B?RC9yOUxWeVdEMDMyZmJEUUpwWEtrSkJRWlhSMXluaWhnTEdFZ3dtdTB3NHpE?=
 =?utf-8?B?ZnRhMDFkaVVJdk9rMHpDeWYxV09ndjFhZElnWjhEWkwxVGtEYmZYdEIvUm9y?=
 =?utf-8?B?UFM3WEVuaDdHRFEvK21NZllVMm5lUURjSnFYZEJoUytDSnlYNkkwd1RQRzND?=
 =?utf-8?B?SXY2R0VleDh0TlZFRDRkdVNhZVk5b1lmN3QzcktQdHVnRk9hV3JZV0lEU29L?=
 =?utf-8?B?NSs0cUV2MVRveTZOZjBnTWVTYXdUUkRhenhYZGwyU2xpNGt6dEpzT28ybVNw?=
 =?utf-8?B?MG5XRXE0dDlTVXg2WEI1eFhrbVRBaDVrbHdnUjlrVzJOS2pPWmNydXhYQXpv?=
 =?utf-8?B?K0NBM29GSXBGN0tQeWhsQkMrOWN3c2pYT1ZTNlg3bFVjMW43UkFBQld3TGM2?=
 =?utf-8?B?MFVpa1ZwcnFtc0YwSWtSdU8zOEloZWJFSXFnK2FRc2lmaXlYbVNOT3kvc0cr?=
 =?utf-8?B?NWpiTElnV09aZ1IrbW9MT2VvVGRuSXZUdi9XcEx4ZVV3WUFDamZVMmdLaFJr?=
 =?utf-8?B?RURIa1E2TzZoN1k3SUJqZ1hEYmN5OSttbVdzeGFBQXhRMjZVU1RPTlh6azdR?=
 =?utf-8?B?Sm03eEpvdk5aNHoyS0dNcXZXeWVpaTVCd1ZRaDRTb0oxS2ZST0h3YXVQQ1V6?=
 =?utf-8?B?bDcvUnh1NEtJOXRtM3ZtR3NBYmxFNWIwZDVwWVFaTDY0bUovQTN2b0doUEJq?=
 =?utf-8?B?bmw3dkJPN0s0SFZVa3kza1lScVRObUxQZlRES2lPbERDRTlzOWI5TWduNzlV?=
 =?utf-8?B?SHkveEFIaGw2UDhkeWViQkFHRENFQjl2RWI3dk9PUE4vSjJpWmRkYzBoRHpQ?=
 =?utf-8?B?cUdwcCt0VVpVWTdRK25mYWJvTDBzUlRpVDZBM0ExNjd4ZEJiZ3VNL0xGcjdG?=
 =?utf-8?B?WGIyVmRlcVVNeWczaXdMN1NMNTVHUEEzZUszRlJycXVzblZIaDlsaWZnQzZ0?=
 =?utf-8?B?L2N2UkpRM3k2N2FYemtERVZmZHBucVI4RStTOTNTY3Q0alZwdHJaeDhOZVFh?=
 =?utf-8?B?Qi9vcWNjT2lXRHVZVStidHRiVksyMjRvWGRFZ08xUXVIbGJ2Q3FxNEJYOHQ5?=
 =?utf-8?B?b3Z0WWZYdytSM25QWHNlVW5tODM3S0NxWWRqS05PS09hSDNBaVNOOVpGYUFy?=
 =?utf-8?B?NjVRdzVJOXZzYVlYZEpFVGM3WHVMV2RGZktLZVQvQjkwaDBrd0hpQys1c1Fp?=
 =?utf-8?B?YW85TWc2TnpjVjYzRytKTVU1WFpYZVZCNitacU5aSmFYYkpPN1J4amF2eGFk?=
 =?utf-8?B?SDRhWURKMW9YMFhkaVpzaGFUZUtzc3VJWDJjY1BvY0dQTzJ2VDg0aHErNkdt?=
 =?utf-8?B?anl6RjZONEgvc2NpSGVsQ3RiZTNtZDBsQ2RlbVFYbVZuNnBiczd4dEJjbThV?=
 =?utf-8?B?ZGY1cnh2TGN2d2dMOFBlK1NENmxGVmV6QS9PcUNIbkhuZVhlQXNGQmNjS1VM?=
 =?utf-8?B?UVVUVTNuVjZpZXYzRzNkWkhpSkgxaHlKYms5VEVCNUpGZGdDNDNpV29PNmJV?=
 =?utf-8?B?OW56UzFaYUlYYW1rbks4UThXenZhSk9nTXdHMDZwZWJ4N1NjTlZsaTZJZ3ZS?=
 =?utf-8?B?Q1VvNXFYMDNWK1BpZEwxVFNVNmVZc3dOU3NlWVd4eTJHZ0oxVHNWaHpIRHNr?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22F85B1FE7B0844E91B200460733C63B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6326edbb-94c6-40f3-b143-08dae403a171
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 10:02:27.0807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4q+KGhsANZV3DMxYSiUtBNwl58eUm2yrh+srImjwMksiVF36eVzeWGUL2n8mrVJhnAtykkfXinYtQQwMXG8Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5564
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEyLTA1IGF0IDE3OjQ5ICswODAwLCBDaGVuZ2NpLlh1IHdyb3RlOg0KPiBG
b3IgcmVkdWNlIGluZGVudGlvbiB3aXRob3V0IGZ1bmN0aW9uYWwgY2hhbmdlLCBwcmVwYXJlIGZv
ciBNVDgxODguDQo+IElmIHRoZXJlIGFyZSBtYW55IHBvcnQgaW4gYSBzYW1lIGxhcmIsIGN1cnJl
bnQgZmxvdyB3aWxsIHVwZGF0ZQ0KPiBsYXJiX21tdS0+bW11IG9yIHVwZGF0ZSBJTkZSQSByZWdp
c3RlciBmb3IgdG9vIG1hbnkgdGltZXMuDQo+IFNvIHdlIHNhdmUgYWxsIHBvcnQgdG8gcG9ydGlk
X21zayBpbiB0aGUgZnJvbnQgb2YgbXRrX2lvbW11X2NvbmZpZygpLA0KDQpzL3BvcnQvcG9ydHMv
Zw0KDQo+IGFuZCB0aGVuIHVwZGF0ZSBvbmx5IG9uY2UgZm9yIElPTU1VIGNvbmZpZ3VyZS4gQnkg
dGhpcyBtb2RpZmljYXRpb24sDQo+IHdlIGNhbiBwcmV2ZW50IE1UODE4OCBmcm9tIHNlbmRpbmcg
dG8gbWFueSBTTUMgY2FsbHMsIGF2b2lkaW5nIGVudGVyDQo+IEFURiBmb3IgZWFjaCBwb3J0Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQ2hlbmdjaS5YdSA8Y2hlbmdjaS54dUBtZWRpYXRlay5jb20+
DQoNClJldmlld2VkLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCg0KDQoNCg==
