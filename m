Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E0871464E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjE2Ic3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2Ic1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:32:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40C0A4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 01:32:19 -0700 (PDT)
X-UUID: 4e931048fdfb11edb20a276fd37b9834-20230529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wMati21dm6vPO+WEtGVONkfDIYnZycB5+e/1j0NSQEA=;
        b=frr+oT+b2Rjsvh3JoAdf0+cxPvFeuGcritowNTSQ3KXKpHkedaMvzXXbtfk/Ax65opGKK7RJzaVl/uH562IZZAPVpGuADPmnU1RgaqgltFdCM/oABk2D1JoYX73lUAsrdWqpoM+TwqAMJH9HRacKPMpOco76uqXCKFNuxSPhQPc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:92fb1440-97fc-42a5-9f14-1e93147f325c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:fcc5ac3c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 4e931048fdfb11edb20a276fd37b9834-20230529
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1112005468; Mon, 29 May 2023 16:32:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 May 2023 16:32:10 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 29 May 2023 16:32:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=La+bU4u8f0izzmnMFoFEXGdPsq0EIqD+8N5w2kabni2mgKQym/5Jvt1/7wc9PZxTv05EDr6c8MjujIqR+UYs9q34NJ0lYmf6dG+ehFBwKOLxayOwC/KpavSxo5qO5l82CmjIHG2PH2MovTXFssQmwMflGXWtvxAHVLkqtprk3P3GWHwee3Zc6qbM9GH4x54fQJu6l9Bee20XVxz4VxmNQIc6Ke3CmbCBEvc3DjOON4NgaNgZaIgjGS7rxYOEuCTWdsieIxUSGINuX5UwQxFDvHDAgIGC0WeztiHkOeqvlN4LsVOyz+6+FIQrwsHeA2iNVU8J1odD0SXGO9gXKteQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMati21dm6vPO+WEtGVONkfDIYnZycB5+e/1j0NSQEA=;
 b=jkurxBhP4B9wY9ROC9rkMn6a9DQMCqvL4vEYxWap1cKAG7rOlVBijzrHNgoXk42TwptSR0Adbv9JaaMT2FSc6aMTGCuk/AbvZBE2JieTop1ajDfOkUgYgLMg2y4UHLjQ7XMG7CgwnE7w4iRXrTWX/ZmNrJJcxvU6vSrLrjBqC33KbmcSYg1HSQCvui1y3NjCDwKzkhZEMEtv7VrsmtVFxJKj4IpqDruljjAatXLcG07umU521PQG9ktBYA3dPBCZCzu9VZP0ed5zarASQsW2Vz2alZgrqPBa/xXyJxgnsfcZL9kCROOm7DLYUaplNiDGJwMZmT5zv+Q0LgflZKvARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMati21dm6vPO+WEtGVONkfDIYnZycB5+e/1j0NSQEA=;
 b=rMMbRW/yNdAE5pkcHf3otKGcDQss7a4y1ZhstViL9K1HtJTAlPc0YaNRMGV8yGZIcy77pF898hiBUg/FXOOqWxoe0Y2F/3S8hJEpxDuh+CUS9AMN75iQIsIXREDg1VXkLgezHv8ta711H/qJ7QVNw4H2CVIgwxHygapMa7KxmdI=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SG2PR03MB6381.apcprd03.prod.outlook.com (2603:1096:4:17c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.22; Mon, 29 May 2023 08:32:09 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::cedd:cfa9:c981:66cb]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::cedd:cfa9:c981:66cb%3]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 08:32:09 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH RFC] iommu/mediatek: Flush IOTLB completely only if domain
 has been attached
Thread-Topic: [PATCH RFC] iommu/mediatek: Flush IOTLB completely only if
 domain has been attached
Thread-Index: AQHZj6+wdAIENZbnYkqbh6ZpvVUY9q9w8L0A
Date:   Mon, 29 May 2023 08:32:08 +0000
Message-ID: <1617a5d426462a9acb9c83e8b65b83093df90bc6.camel@mediatek.com>
References: <20230526085402.394239-1-wenst@chromium.org>
In-Reply-To: <20230526085402.394239-1-wenst@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SG2PR03MB6381:EE_
x-ms-office365-filtering-correlation-id: d9f82358-2c52-488e-fabe-08db601f3145
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /MWjEL9qjH0lOGI14mDdTQB2TwcDyLdWhE/eBySnsyI2CYPvRcpmcHjD6Whr0yUWX9Ch0Dsrg1QxD4LwJq+0eV976hm/rBriDlzlCNylsS8eoya5CgXypS49rH3fkL7rUXXDj+JFLN6DeTXyJFnFDSgroMKAzSKfguO6Rok7su4rG8cuYB8TiHgBfd3F/R2xRAMAXn7vIYLOjKL3JjniHcfIc6j8irSMHzQ2OYaDnuUsf44VkCwZmj62222C6WaDgsptVL3a+/umQmWGTuLzTTWhSj/VM2TbvEHazfaEP+VeVe/+uaaTEezDajuOHqUyq1CDKyzHjAbO0+BADn45OJS/yb4Dx1NDEAVtM2qG0DqBX3/lVm6y3k5BKxrI253Jt7VtsuzVmjR/6GxCqCMppfXxJPmtis7yGW3Hs248jmzFr3sUYH/MA8JMZCGBCZkriy18eCcwFtmY8NeV4FRm6IA9ISKmXzi0jF+u5t/QKax5C+jSpPxlppeoqeagxrxmTSH3LiLaOgRiruqKFSIpqniMTDrYg7Zh0WPAHr9lPwge3/yvDLgqysotdPQVm0EHJ3wcF2KOQvXxL4UemQmddYjTYwe/saBfHfZIdtuhs6RJE8RcqaHJacDs+RARGw2SG9ipSkvLuDjGx2/Q/ZYksAL1LbFeXyAYdRkcj3YEV83eVlmKBF95hFItLsCyJt7K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199021)(6486002)(41300700001)(86362001)(38070700005)(4326008)(71200400001)(316002)(66476007)(66446008)(66556008)(64756008)(76116006)(66946007)(85182001)(7416002)(36756003)(5660300002)(186003)(478600001)(2906002)(6506007)(6512007)(26005)(2616005)(83380400001)(54906003)(122000001)(8676002)(8936002)(110136005)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGhka0lnVjlKQThUUXN3R1J2OVRrcUVGRjVwUFdzdjVZbkZMenpCRUdRNmxI?=
 =?utf-8?B?RnVlVWFUMEZhRTRCbWRTMml2a2t6VS9aRkVRaHc5eHUxQkZlaFBSYi9URHBZ?=
 =?utf-8?B?eFRTU3JjNDgrRlFaT0pRdm1sQk0yVWRDOTQ0VkV3V1I5UGtoSGsyNTJVanZj?=
 =?utf-8?B?Mk84eFQ0NjEwWmd3M1lJdC9IMHQ4K0RqNS9CejlBaG5MOE55ZnR4cEdrc0dF?=
 =?utf-8?B?VmlvQUEyem1hLzF1SEMydDVKZ1gza2ZTTUQ2MUY3WDRaYlNEbTVoWXlQVmpB?=
 =?utf-8?B?WW1BbytxbWFXTWs5RUZxU2dHNEhoUm9XWDhhdlhuS1B3U1pzWklTS1pCeVpM?=
 =?utf-8?B?TW93K1I1RjhRNDV2SEVTeWp3ampybENVZkFYN1B2aS9ZWEc1VlpDcVI1Vk42?=
 =?utf-8?B?RWtuL0JJcDJUQmo3WmNkZ0lmck0wOVdmL2ZoclR4Zng0ZjlIMVNNTmdGd2ds?=
 =?utf-8?B?NGxydlpqVTMxL2U5UTZKbElUQ3R2WEw1dFgyZ1dWeTYxOGRqUWxIRjlBQXNL?=
 =?utf-8?B?RURXRERMSFQ2c0VadlpsK01FS2p3ZEU5ekY4YkxZWTQ1QjlTZWt0VzgvR2Iy?=
 =?utf-8?B?YU1zbEdKU0F5azV4MDlBYmtMQzVRcmZNYUNzdGNvQ1ViOE1uV3pGSkpZaFJW?=
 =?utf-8?B?WFpLbWZERFpjRUdVcHRqNEc4S1gyZW1ObmRITkZnY1ozOWpkb1RMTUhRdWN3?=
 =?utf-8?B?ekRoQTRLRTJyakUvNGZGRHQ4Vy80MlpKQ0RGS2VMaUI0aFBYSkpMOXpUSWRC?=
 =?utf-8?B?N2ZtSVNOZjJSd3h6ZHZGak1BT3VsVTQ2cFE2WG9wUWl2Nys2ZUNmcXhrTnRy?=
 =?utf-8?B?anlDRmpVdzZIUUNEblN5SnF1NWlndXRhazR6anNILzU5dWlWQnRNenZBY0tG?=
 =?utf-8?B?VWVENWlEWTg1ZTJzWWdLTmVQM3dySkJxUDZPOXJQdjY0Nkw3cy84WkE1d01y?=
 =?utf-8?B?MDNaVkgyeHptYWpDUlV4QmdHTTlOelFQTnl4N29ySEZCN0tKSGd4QTFMUFdq?=
 =?utf-8?B?clVGUHBLMHhUb05rRkVGL3UreWRHY0hGbkw1eHJpNjVSZ1ExbE11MnZmMW5E?=
 =?utf-8?B?QnFDdmJ6Z0NteFZ6dnNNMy9VblZtUDFnM3pOU2dHK01JK3ViTnhVSTgzYW1F?=
 =?utf-8?B?UDRlUHNpWnM0VjFZamFkRXhsamVGRGpWelRteGg5czl0QkxWUkMybllwU0RQ?=
 =?utf-8?B?aTNWQkdQc3VONUtyNHBxa2Y4Nms0a2ZBbSt3dXltMzVLaUtoWFBCL1ZKb2Zp?=
 =?utf-8?B?KzNscTFrSy9Ca2ZDRm5lK0ZZb0U0U2NzWW8wU1A5NklvNG5FNWxKRGFTczBE?=
 =?utf-8?B?OTRyZENnL0R0RnNhVEJOQytiVEZmcENkcVBrNzdoR3MvQzRVU21keUpPdGFQ?=
 =?utf-8?B?UmZ5SmVKUjVUL1hLbDcwSUxRd2hpdm4xS0l4eCtYYTFzc3c3Zm8rVUorZWsy?=
 =?utf-8?B?Y245cDhlTkdmK2Z6STAwQnNZRm5ZSDU1SDl1YjFIbGFueUQzRURTTm51b2lM?=
 =?utf-8?B?dW5BNnNEbkpFQ3hZb2FyQkhhVC9xdmVpNHBLTHVZL2JPNHdHMURBT2tQSmZE?=
 =?utf-8?B?eE9UaGZ2MCtjQXdzeVdqRVZlUWZ6bW00VXVqU1paZVVHL1RSTE1DVndSd0RJ?=
 =?utf-8?B?YTI4VTJ4TzlTUTFRbFlSNHVKT3Q5ZEZmbFZNYTZFTVBreDNQWlNvUGFXQ0F5?=
 =?utf-8?B?MjRJUmxua015cHExV0FaVytpTndCOExxbFNPUEhCOFRxVjdKZWgxdHFaNWho?=
 =?utf-8?B?TGRsYWRrQ3Q4RURqU21TQjZtSVJEMExJQjM4UnIzOW1iRnVQYU5sb0NPSTJq?=
 =?utf-8?B?ZWFyNXUrRm5iQ0VFWXF2RHhUTFppakpjWDl6TFh6TjIrQi9MWURTZ1kyMTJv?=
 =?utf-8?B?b3Fid01HOUlTYlc4bzdudFBBZWFSeFYxdVBLdGdiV0c3ZjhpVkI3Y3J5Y1dq?=
 =?utf-8?B?eGRBRzdhU3ZkWWV3NzNJR1hNT2Z0aHBxRTVabzluZGRFN2IrNkxMMjhmS2Er?=
 =?utf-8?B?SHBnblZSTDZzdWZDcFZXaXFJUm5VWStMdTdWUkdLTTJ3LzhTS0dhZHcySSs3?=
 =?utf-8?B?WDZWUzh2bnU1YlR6Q0R4aTBzOUlwWWVMSG8ycllWVGk0Qm1OaUY0WElsS1ZD?=
 =?utf-8?B?UUpPU0RCN3JOUWRORTYyRFZoTzFXK3JCb0lleWc0TW9MRHVIUkgxMmFMaHZX?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C1D4385EB50E940A092821ACB4F3F39@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f82358-2c52-488e-fabe-08db601f3145
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 08:32:08.9556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LhHTuuZirjwOhPnycyCgTFR11QrgqHi//ArTEh0wZqfpl9/0C/qzeiErEAIIw6toBecF82gJfciASHvI61EaRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6381
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTI2IGF0IDE2OjUzICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
ICAJIA0KPiAgSWYgYW4gSU9NTVUgZG9tYWluIHdhcyBuZXZlciBhdHRhY2hlZCwgaXQgbGFja3Mg
YW55IGxpbmthZ2UgdG8gdGhlDQo+IGFjdHVhbCBJT01NVSBoYXJkd2FyZS4gQXR0ZW1wdGluZyB0
byBkbyBmbHVzaF9pb3RsYl9hbGwoKSBvbiBpdCB3aWxsDQo+IHJlc3VsdCBpbiBhIE5VTEwgcG9p
bnRlciBkZXJlZmVyZW5jZS4gVGhpcyBzZWVtcyB0byBoYXBwZW4gYWZ0ZXIgdGhlDQo+IHJlY2Vu
dCBJT01NVSBjb3JlIHJld29yayBpbiB2Ni40LXJjMS4NCj4gDQo+ICAgICBVbmFibGUgdG8gaGFu
ZGxlIGtlcm5lbCByZWFkIGZyb20gdW5yZWFkYWJsZSBtZW1vcnkgYXQgdmlydHVhbA0KPiBhZGRy
ZXNzIDAwMDAwMDAwMDAwMDAwMTgNCj4gICAgIENhbGwgdHJhY2U6DQo+ICAgICAgbXRrX2lvbW11
X2ZsdXNoX2lvdGxiX2FsbCsweDIwLzB4ODANCj4gICAgICBpb21tdV9jcmVhdGVfZGV2aWNlX2Rp
cmVjdF9tYXBwaW5ncy5wYXJ0LjArMHgxM2MvMHgyMzANCj4gICAgICBpb21tdV9zZXR1cF9kZWZh
dWx0X2RvbWFpbisweDI5Yy8weDRkMA0KPiAgICAgIGlvbW11X3Byb2JlX2RldmljZSsweDEyYy8w
eDE5MA0KPiAgICAgIG9mX2lvbW11X2NvbmZpZ3VyZSsweDE0MC8weDIwOA0KPiAgICAgIG9mX2Rt
YV9jb25maWd1cmVfaWQrMHgxOWMvMHgzYzANCj4gICAgICBwbGF0Zm9ybV9kbWFfY29uZmlndXJl
KzB4MzgvMHg4OA0KPiAgICAgIHJlYWxseV9wcm9iZSsweDc4LzB4MmMwDQo+IA0KPiBDaGVjayBp
ZiB0aGUgImJhbmsiIGZpZWxkIGhhcyBiZWVuIGZpbGxlZCBpbiBiZWZvcmUgYWN0dWFsbHkNCj4g
YXR0ZW1wdGluZw0KPiB0aGUgSU9UTEIgZmx1c2ggdG8gYXZvaWQgaXQuIFRoZSBJT1RMQiBpcyBh
bHNvIGZsdXNoZWQgd2hlbiB0aGUNCj4gZGV2aWNlDQo+IGNvbWVzIG91dCBvZiBydW50aW1lIHN1
c3BlbmQsIHNvIGl0IHNob3VsZCBoYXZlIGEgY2xlYW4gaW5pdGlhbA0KPiBzdGF0ZS4NCj4gDQo+
IEZpeGVzOiAwODUwMGM0M2Q0ZjcgKCJpb21tdS9tZWRpYXRlazogQWRqdXN0IHRoZSBzdHJ1Y3R1
cmUiKQ0KDQpUaGUgaW50ZXJmYWNlICJpb21tdV9zZXR1cF9kZWZhdWx0X2RvbWFpbiIgZG9lc24n
dCBleGlzdCBpbiB2Ni40LXJjMS4NCg0KVGhpcyBpcyBhIGZpeGVzIGZvciBsaW51eC1uZXh0LiBB
bmQgdGhlIEZpeGVzIHRhZyBzaG91bGQgYmU6DQoNCjE1MjQzMWU0ZmU3ZiAoImlvbW11OiBEbyBp
b21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzKCkgYmVmb3JlDQphdHRhY2giKQ0KDQp0
aGVuOiANClJldmlld2VkLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCg0KVGhh
bmtzIHZlcnkgbXVjaC4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBDaGVuLVl1IFRzYWkgPHdlbnN0QGNo
cm9taXVtLm9yZz4NCj4gLS0tDQo+IA0KPiBJIHRoaW5rIHRoaXMgaXMgYSB2YWxpZCBmaXgsIGJ1
dCBJJ20gbm90IHZlcnkgZmFtaWxpYXIgd2l0aCB0aGUNCj4gaGFyZHdhcmUNCj4gb3IgdGhlIGRl
c2lnbiBvZiB0aGUgZHJpdmVyLiBUaGUgQVJNIFNNTVUgZHJpdmVycyBzZWVtIHRvIGRvIHRoaXMg
YXMNCj4gd2VsbC4NCj4gDQo+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMyArKy0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYw0KPiBpbmRleCBhZWNjN2QxNTRmMjguLmU5MzkwNmQ2ZTExMiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiArKysgYi9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQo+IEBAIC03ODEsNyArNzgxLDggQEAgc3RhdGljIHZvaWQgbXRrX2lvbW11X2ZsdXNo
X2lvdGxiX2FsbChzdHJ1Y3QNCj4gaW9tbXVfZG9tYWluICpkb21haW4pDQo+ICB7DQo+ICAJc3Ry
dWN0IG10a19pb21tdV9kb21haW4gKmRvbSA9IHRvX210a19kb21haW4oZG9tYWluKTsNCj4gIA0K
PiAtCW10a19pb21tdV90bGJfZmx1c2hfYWxsKGRvbS0+YmFuay0+cGFyZW50X2RhdGEpOw0KPiAr
CWlmIChkb20tPmJhbmspDQo+ICsJCW10a19pb21tdV90bGJfZmx1c2hfYWxsKGRvbS0+YmFuay0+
cGFyZW50X2RhdGEpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBtdGtfaW9tbXVfaW90bGJf
c3luYyhzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sDQo+IC0tIA0KPiAyLjQxLjAucmMwLjE3
Mi5nM2YxMzJiNzA3MS1nb29nDQo=
