Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810B16C66A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjCWLct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjCWLcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:32:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7476A58
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:32:44 -0700 (PDT)
X-UUID: 6ca0b03ec96e11eda9a90f0bb45854f4-20230323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mac0wf/n0QKNEg6QEAQ5L7Ga96ma7umVjwbnPhzhUts=;
        b=YcWKBFtf1t5x7txFSOrxCL7pp5XyN+MXyQEHlK6hD5C+gcyQ4Ft12tXG6Er9fCgNJ0iYRu+ZOL+egKRsDw9jjxodxiO379463QvXzOeSjDUH10rmv3dLZWm79XkpFdR1R6uVIySfUU43MQy3GUh7a9xwOUwv6aEbpdyQlWuYh5U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:f8488018-d4dc-4795-ade1-dd954b3b484e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:c4784529-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 6ca0b03ec96e11eda9a90f0bb45854f4-20230323
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 115581270; Thu, 23 Mar 2023 19:32:42 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 23 Mar 2023 19:32:41 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 23 Mar 2023 19:32:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQZb1EnWv90qrzKTRug1YHOz+cqR79W9nq3B5ceFZpUlL5idGIC94UP8Ro6Zqig/mYdo4JB+zGKmsxIZL83Fmqiv539GoP73k7wpd0CC3epbjZGBWuIdFSNn80/NephqRJdCPm5RmU3wiCRzUR6ZS6S55LJ+wjVwA0nmyrxlksAYLQIjr64gCYaMdSJ2SZxlTEWRVWHD8i3FsxwJLgaKeAAlWvtCJQU5DVVRTQy8v3jCJZCgKdzm52Mg4fC3XhzzdgYIfL7NZO2SEMdkOwNO7r7rDCEiG3lAn0XYIhcLun3JrPNaGvnKxIHDELs3dN8kJ7Lz3RK4gBMcYkRj39g/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mac0wf/n0QKNEg6QEAQ5L7Ga96ma7umVjwbnPhzhUts=;
 b=VogTH1H7aLvwR6dtA9KJpcl9+kJhIDjTcZjae2gLrkV9n9E9304W45vkIJvlYdy38Ohp5igCEJlyGLRtd9snlk+0nRHiMROgbXxUT0IvjlZPlkCAtRj3+ikiwsES++pGfVLpurVBrf2d7ArzWvYc4MThFlBqi4CzYOSrD6SVKH4K6lctvHbkjv7rPXJIG/k1Ap4+CY+ywPTgyQOm3T1S1QENzVoB6yj6mSxgg/Y8Ls/H8/bTt0vio0qzEVwLj43c3vAuHsRxM1QDbCrK7omeayNnT0Y1bwMTrCNqNVVp4uOQYf5kYWjbAGo9Sa+4QHHZPFFc+JhOR5Dx+goD7k9Cig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mac0wf/n0QKNEg6QEAQ5L7Ga96ma7umVjwbnPhzhUts=;
 b=TaslLCudUTKqUOTGiIeL28n9AOdNL6fF1YxkMqpbde/AvBjnVV3QoReFp1q3l770fnKGg3AP4XTIfjxYw9XXQmG3aktiBXof3Uo7Luhaf3VZA0C6kRAoB+0wi2DvjlcZh2GK2109ORynrMTZl1u91tHp1GSkXH9SFdCx6gfezro=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SI2PR03MB5275.apcprd03.prod.outlook.com (2603:1096:4:106::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 11:32:39 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 11:32:39 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "joro@8bytes.org" <joro@8bytes.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v2] iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN
Thread-Topic: [PATCH v2] iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN
Thread-Index: AQHZV9KN16gSnfuMbUGDVD1QzcJh5a8G5rsAgAFf9wA=
Date:   Thu, 23 Mar 2023 11:32:38 +0000
Message-ID: <5555473c3f3a49656d8e62479aa2c0b9d6d8d7e1.camel@mediatek.com>
References: <20230316064251.7346-1-yong.wu@mediatek.com>
         <ZBsRlgJIaQieIbzU@8bytes.org>
In-Reply-To: <ZBsRlgJIaQieIbzU@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SI2PR03MB5275:EE_
x-ms-office365-filtering-correlation-id: 8795f6aa-c562-4bce-0d8c-08db2b924ed3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VH1F01YuzBzdxddpU+QRB8DQQOYvIXB/m7yTUZ8Wdlcu2lbgTs9Znfsb+Sk5EwR8bcy2gN/MXQGqXpwCwGtVdsg9ImZRLHip3uQxII0Rxg+KujFOaWmHa5WIB3D+SYJRNSC20t4SfPH6DalxM8Zbx5mLdK7lLZC7GBkPa9RMIbjDfAhZU2J3aUdNpowdSUkqce4f00eAlfTUVddXGuyyQPT1yLLKteiogBKvdDwChTMByxln0qQUNCEB/sKfTOyCEk7BO5+SXfxsekDmfKOfvqgMj6LTeYr17SJfnNRFSccWtAzjIOvSs5BAVjGgORHvpVkwEnp6FrEMazR/KuzRadW9Vks10EdQ2vCUMYUNWtFZFYPRVzQEwYoEMhY9IKcvh6qUthCdIHuJcsQkRqLalAZDBvo/vxN/JBBW/MLGPHaDHAJV2tLJkz0GSjynZ38IzkguHsOQ3ebAkeeRhmvNVaB3Q8h6B6N9OcI0zinjka1JfvBlXi2LhNoRxTfJILQWERay77WlAINtpP/ZZY8z9SIAVaN4zsORJ+TmhegijB3fRanTcpIHYrNvmsrWiiEI8j0Sb9SyL+8L35u5eiQgtLxmnELoHSZoPJUc3tC+lIiaNAjCbvZWtVqJ9QLCfuUrG39bObUzj9P7O8DXC5N0JPR5GHIPsYGeu7qZSHh/6hKcO0Z2riQ9Ox+e++Uq41H5npKDxIArZnt7XIKXFxSCvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199018)(38100700002)(38070700005)(2906002)(71200400001)(478600001)(966005)(6486002)(2616005)(186003)(86362001)(36756003)(85182001)(316002)(54906003)(4744005)(66476007)(66446008)(64756008)(8676002)(66556008)(6916009)(66946007)(4326008)(76116006)(8936002)(26005)(6512007)(6506007)(122000001)(5660300002)(7416002)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkZkNXFZNjRsU3J5ZGxUU1hkNm1wZW8ySnF4bkZlYzljeUtYaTNMTS9wRk9E?=
 =?utf-8?B?S3pzeWhZVEsyaXo0TjlDTmQ4K3FJSVpxTm9icDVkMmY3eGFnTFBNb3hoRFJl?=
 =?utf-8?B?c3FiN3FVZzg0aXFxd3ZWZElVQ1hLYVdaK1ZLR0gyY09NYm8za0dObFpGNm1K?=
 =?utf-8?B?T2pyZDY1Z0NIUFl1T0RXM2Fmd05JOTh2cCtoZmFyN2I1YUMyYXplY3ozQmlm?=
 =?utf-8?B?UmtTd214NkdMTHFwTm9wYW4za0twVjFEZFN0YlpqY080MURUQkROb1QzUnNu?=
 =?utf-8?B?Nkk5UlN2WjlXYnJBNFM4QWw2R2JQNFU4NUhhcytCT1BWY2U4MkZZNGNwdmEv?=
 =?utf-8?B?UFRSdk4yKzdpVDJidUR2d1hLOWhYTmp0RnBEaFIzNTJCUlFjd0owOUlRQjJt?=
 =?utf-8?B?TUlqODNyZE1ZbmlWaGtIOUxacmRIa2QvL0ZjeDFlM3IzMGVMZFI3OXRXMDVS?=
 =?utf-8?B?L3R5UEFHZ2J0LzByUU1CZGRzNzJ1bUNMd280NGNVZlRXU0hCdDZsaDdSRjUv?=
 =?utf-8?B?K3ZjYUw1VHgvSGc4a21MUkIwVTFpQThvSSt2aHZydm9zYklnZlhvdFY1SHJs?=
 =?utf-8?B?Tk9WSEFrRkZ2S1Z1aUhjTEFYQ0hOUVFZQ0RPMG5mekpVU2lCbWt0ZGhLT0ZZ?=
 =?utf-8?B?a25LWGpGZjB6UlRhLys3eTVoNEUrc1owalBrNjJpSyszMUFxWTZCZHVQU2Vv?=
 =?utf-8?B?Qmx2N3VlaFdTSFVtdEpkdS9TT1NtN0hWUElmcmJEUWh4REFXcmFmbDNqOVQ0?=
 =?utf-8?B?NkRZeWJRR1ArZnliUVpGaWtDWVdXQ0FaOEZ4VXJubGpad0hYeVd4bUZKekRD?=
 =?utf-8?B?ak9ucyt3eGZ2RFRlVUNrNXY1ZUlGMk1jazFGZHJRNnFrci9ndFZFa1hVYjRO?=
 =?utf-8?B?OC9mYlU2akI4YlZMV2tLUUdIMGpwR21TUTNmOHFyYXMrS0ZTYXh4QlI5YmZB?=
 =?utf-8?B?azFOdWpPZHlTczl4UzZLYy9VT0luU04zaXVtRld6VEk3bUdnZmVnd1EyMUNX?=
 =?utf-8?B?V3ErcE1ua2gzbFdPck9zRTJMWWVBVmxNT0FNRm95WktSc2xmT0ZnVVBOVVVh?=
 =?utf-8?B?TU85TVpMK2hPOHdDRjhDQWIvV2QzL00vUXJ6WWNtQ2ppeVNmRyt4cDdFK29Z?=
 =?utf-8?B?WFBYOXRiZGtteWcxVXlWTEZib1VoNEtDaTRKSWtWZmwxQnlWQk9YRDRQc1J5?=
 =?utf-8?B?WjFIWDJZNTlTRVlJd1o4QWlpWGUzOHYxeGgzeFR1bUNKaHcrZTRIN0VRcUVN?=
 =?utf-8?B?VnhuWG1SMG1raUpSaXk4c2xIMUVpdUoxYTNmbjZVZWcxbDRaQWxGL0pGT0xk?=
 =?utf-8?B?Z2xtUTNTdmhCRlZ5dkFxa3c1dmJsNk1ycHhubWFLaVZ2dmM2ZE5pUWlWUHUy?=
 =?utf-8?B?WGNSaVRybjF3NFIwVzNPUUREWWk5RGJDejRNbUYrTkFGTXNaenRJWXpvWlYw?=
 =?utf-8?B?KzlKeHo2VFRDTm5ucFVPczJybVZhS2EzNFhPQjhGTWo4ZzBTeVRLalErZitK?=
 =?utf-8?B?R2Vza1pvM3BzZkd3bnlSMkVFSzVnK2NjeWhaZFdXMmZ5aUlHOWtjbklldEdG?=
 =?utf-8?B?VXlRNkRyRWpWUHFubnBpVFBibkFYdFV3WUtvQ0VzT2s4ZVAxUTE1aytzVjNa?=
 =?utf-8?B?TnVDdGNibXllNmFLc3pJQkdHakJKTHdWVkIvcnROaWlFVnpCck9mTVlUNitQ?=
 =?utf-8?B?bnpCWS9FNzFJV1V6WkowUXo5TEk5cS9heEtNZ21oTEtqaldud2N1YzZyL010?=
 =?utf-8?B?bkdzLzlkSVo3TUdvbEVLYXB4aVlaRGtYelpReU91dzcwVEloNzJTa05leEs0?=
 =?utf-8?B?UmQ3SWQ2aElvSXhZV3JJckRuK3lXbjlvTEgwblBCdzkrL3RvK3BqQkJvdWdo?=
 =?utf-8?B?M1RYS3ZROCtvejVVdnpXUjF3SzNFOGsva2Y5RFV1VWQyVzdZU0RjdExCRE5j?=
 =?utf-8?B?Z0szRkFuQ0EwdVcyK0FuK3Ruc3RLeURDR2pyUVlLUWJhWXdvOGFrS2E4UFlM?=
 =?utf-8?B?WEFiaW1TV2k1MGVNcGNMVmNTK0lIdDFLWXhtNWhTa2NiclhjSml6T0NDejBw?=
 =?utf-8?B?YlNLbGxzZnJpanY4R24vckYzY3NKMjM0eGROWFlPNVVoYzR4a1ErL2tHOHRV?=
 =?utf-8?B?emtRZnBPY3FMelhMWWlLOVIvZFg5RXJGT010Y1JiYms3ejd3OFVtNGl0TVZZ?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <530C838516B1214FA8388BABF2BC19D5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8795f6aa-c562-4bce-0d8c-08db2b924ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 11:32:39.0106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6WVdXygbIcF92EbBmmUIjLv0iBnsfTbMNw4eYWwVoJEK0+HxqwtT+XIBghGKrjy0zQHXlHExncYhLcUhc2QIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5275
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTIyIGF0IDE1OjMyICswMTAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+
IE9uIFRodSwgTWFyIDE2LCAyMDIzIGF0IDAyOjQyOjUxUE0gKzA4MDAsIFlvbmcgV3Ugd3JvdGU6
DQo+ID4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCA4ICsrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gDQo+IEFwcGxpZWQsIHRoYW5rcy4NCg0KSGkg
Sm9lcmcsDQoNClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHRoZSBhcHBseWluZy4gSSdtIHNvcnJ5IEkg
aGFkIGEgdHlwbyBpbiB0aGlzDQp2ZXJzaW9uLiBJcyBpdCBwb3NzaWJsZSB0byB1c2UgdjMgaW5z
dGVhZD8NCg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8yMDIzMDMxNjEw
MTQ0NS4xMjQ0My0xLXlvbmcud3VAbWVkaWF0ZWsuY29tLw0KDQoNCg==
