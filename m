Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6516370F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKXDY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXDY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:24:57 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C55C5B58;
        Wed, 23 Nov 2022 19:24:55 -0800 (PST)
X-UUID: 33562dcdcfaf41829d1dfb7c92e05918-20221124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CfVls4+9BgG/7cP4ojK7vAlubf0AVNNkYkpLqv8S6Sk=;
        b=lH1jf0Mt6XOEo2ThluVIhJXCWkyxVb32/HQEBvmAoW+h3auOq324wiQOd5afY0D4OhNOQsHcRwJppVT1jJfQO9zL1I0MGXWC2iANz0wxt4yxFUibw8O7f4tq2ofS+Y82hBWAVql5bO23dEYbcOTzVDWKi4R+/j5T3U4YTGtLdus=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:8981fff2-a17a-42dc-82c9-26f6a362086a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d12e911,CLOUDID:fca316dc-6ad4-42ff-91f3-18e0272db660,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 33562dcdcfaf41829d1dfb7c92e05918-20221124
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2144487369; Thu, 24 Nov 2022 11:24:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 24 Nov 2022 11:24:51 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 24 Nov 2022 11:24:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlTUtUUwHT0rOn6SjenqG9cn9Jzu0ebalTDP5JW1pgqdRXZXy6NbcnTy9Cj56BjzRKCU7RgdqyTrv0L3GUL+pHXlw7SP1pp4hdOAgJQUwexw5pof0hbT4Nw8vgPuMraW7SZJ04kYFoEkGf5jWobjVEedEq5SYyElkHWhR1asiAoyGUwfZn8o53OTEqR7/jKJ0c3NjvzFjHKIL35RQvJKO+rpJUu1lHjgaDrXRutTinWg7alOumpe+9XE23e8ulvQhynz2Qr7ec8cnqhSjeJ5Rbw8uLM9ovHSxbQX2IYx2MmS79bzDnwFB3tgWyobt9MtPK/klrRyaO+MvdZwWJWxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfVls4+9BgG/7cP4ojK7vAlubf0AVNNkYkpLqv8S6Sk=;
 b=kp/5Hg+tnz5NHYwsIopeb0OB1qQlCEMRQmQd7+P6WLfc1RbazQPG2PSFsO1ue7LtUwym3ZWdzUo6qRE0QEW7A2IjjrxHFNu2uXoDtdiplxyWF2mJ+fygfYGI9btWxwbF8zWKtzBinAP7Y+d+M2SRAF68Ux6kuICR2AeuuzhLGhdc1E2hRRI63robd/shjsTkxXrhpGM0kZvDV9wbcnbVTy/KCqzDaEg1udNPHrIuG29QS0A3aez2OU2u7v0i17UxnqrM93ejEi7nzSXOhOYZfHw2QL8sLTg7zX143baiYUSD2lcl/zWciubK+TTrTSOwq5fSw7LLr49CnwFYwtp+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfVls4+9BgG/7cP4ojK7vAlubf0AVNNkYkpLqv8S6Sk=;
 b=Jz24scq7gsDFwPDhScQDIo/FKtbHrFIoiO69cPTwwtMNbeq6xlgVsCvY51MuPSX3KSrhLhDi2gus08f1QNFxSKE4uaFv0IVrqHktJnBRZOE/31uD9eVVGIm9QobeFGcG7+xIqc0i1aDvymczWLQB6iH2NZ8YGjvpW9ZFFdPAPdo=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Thu, 24 Nov
 2022 03:24:49 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9df1:f970:54b3:a25a]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9df1:f970:54b3:a25a%9]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 03:24:49 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1] drm/mediatek: add dma buffer control for drm plane
 disable
Thread-Topic: [PATCH v1] drm/mediatek: add dma buffer control for drm plane
 disable
Thread-Index: AQHY+xQogdlJqG21JEmcJxZvA4lCu65NcnEA
Date:   Thu, 24 Nov 2022 03:24:49 +0000
Message-ID: <a380d04cc35e5f3f0addcf7f919a9579282a7a47.camel@mediatek.com>
References: <20221118060725.13134-1-yongqiang.niu@mediatek.com>
In-Reply-To: <20221118060725.13134-1-yongqiang.niu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7001:EE_
x-ms-office365-filtering-correlation-id: 880dce00-b119-4ceb-6d8c-08dacdcb7172
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pPmgsvVc/dykNEsXyMTuT557Tr7BJXJT865vRo6YGVu78ZRhT5qIsKn4KeSMLFMtluhUNZn3iBTCYj/3GWnk+7w8D0l4VtUEcq5GLEyV2JNxLJaREk2zZTA8GK4ee+6p+jbfZg9k5SOeavVHpjVUNKPbDKCBYITxeF7MJbN/xUrBcIwmgpft9FDXilDj1g3mnfWtGmtXkVBF9v9H4eSR0fhASUJqXNSQlKetc2rSsCgmGZjZK60Xi+4bMyxABaIrWI4LaHksElJTxb17Y1Dn8Zj7Qn7tn/1YZVqRQ7oVdJwb/PxDide0Q4k+rKX6WO6kR3RlNMv1eYEoOv0GUhLL9cn5r1QKV9ybEsNarkZIbGZiH/1WWl+0yVPfwDPPabRZ7/EMQV3HfI3oQvbdN8fbsxhhTUdbunhiUnzyVhJshVMvJGGA3AQwdzOiQ1f+0qe/RjrQCLcwzd0YIrPBX2tJ5E6RjEVOn98iZAkJJVFw57Y8U/koGPydTV7t1mXXYhYlgTOrTAWrmOIfGI5/Q185T7MxwvfKBs2SFBDgvkqnaPSFO5OkLVrthFEo4qACIx627e4d7MzptDk7FkZ5m2O877VIl0SaXg4zj3g1GsvLaS94b5RJMZZ6nF2OcYMrhISnAmrtL+qlgzMM5vzDAT7je7O1UI7WzYmcMOkcXDzBbmA/Nx1Jn8LhtmQk+iUv71vgD0PRP6IJpzYEuJA0Cg3X+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(83380400001)(316002)(54906003)(2616005)(8676002)(110136005)(38070700005)(186003)(36756003)(122000001)(5660300002)(4001150100001)(41300700001)(8936002)(7416002)(66556008)(86362001)(66476007)(66946007)(76116006)(64756008)(66446008)(2906002)(38100700002)(4326008)(6486002)(71200400001)(478600001)(6512007)(6506007)(85182001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUxXeFVtY3VYYnFTenJ0VEgvOGhuYkhFTEdrcXJmckFhd1UzaytnejlZY1Ro?=
 =?utf-8?B?OHRyTFNXektRWUhTVFYrdllRMDRZcHBJeThxMHBnR01mZnlLbFR6RkZGUlor?=
 =?utf-8?B?cnVCOTNsZWNCR1ZSZUN6U2UvdHlXWTJSWHVRNWVQSnZkUkZYQnM1Z05ocEhj?=
 =?utf-8?B?WlZrbUJ6TzFSWGZkeWNMVlVya0YwRzVCMThVYzREeXFqYmRYbnpCYloxYVZV?=
 =?utf-8?B?NzlOWUN0QjFDMWpxUjhtVG5xdTJBSDZVTDdLRjFKZnR4blJBcUFpMENja0hw?=
 =?utf-8?B?RWU2TUR5QUc3Yklzem1CZjlPSkt2a0pISk1XWHBFWHJFcHFPd3EvYXkrenJq?=
 =?utf-8?B?Zk1SV3pCanc2aWhBMCtuR3E5d3l3NENjL0RacUVHNzZLTlZiRFhHV24vNllS?=
 =?utf-8?B?SWNkcHR0ZitpZ3pOS1JqK2xMVDc5Y2hmdURacUZ5YyszTFp3M3dKdzJMdzk5?=
 =?utf-8?B?QVVVMmNCQUcxcCtXL0RKT0lISUNOZnI2VnN3QmZvZ3FqZDhhS2hWVi9EM3pW?=
 =?utf-8?B?YVdOelZscVp6V3BFM2prd0QzOStMUHg4L25ydWUxaFhlY2xhdFlwUGNkV2hN?=
 =?utf-8?B?REFWaWFzUHdBdWxwaWo1MEVCQ1ExR1laRXNrOHozMk9QSjVMb1RLSG1wMWps?=
 =?utf-8?B?a3Y0ellEb3RJQUFkQU1nKzE0SFRYRzEwYXhITzIwVy90S0pqenFObnVOZDZS?=
 =?utf-8?B?RFM1NGtocE16ZGU1TE00QzJYQnZPd0xTbWlxMTd2c1Y4VXlsZnlGL3p0N3pq?=
 =?utf-8?B?bVVYTUdCOTUvdkczKzN5RHJkdEtUTWtveVhaYnBLVkpPeUJFenlzdnJQdUFX?=
 =?utf-8?B?b1NCMlVkZkNrQ3R6SytUZzZsanA0UU5FdTFBVkd3anoyUStkblBMUlU2L2lO?=
 =?utf-8?B?Z2UwTnN4TXBzUWpxVGpISG5QKy8ybjBUMDJheHdRQkZQSGk0dnBjUEU4ODBB?=
 =?utf-8?B?VEZNNWNZOUUwdWFzR2tzZWVBNTRicXpMMFVoOStTbUZOM1d3ZEZNMkFDaDJt?=
 =?utf-8?B?Vko5bml3Vm1TMnJyTUxRdE9JelhVbHAxQ2FJZnFpekJOUVgzL0Y1QnJzYXNK?=
 =?utf-8?B?Tkc1Vk5zMlBaMDdTSmlIQkFOUmw2aTJCUlJWTlRUK1EybHZ2Y0dETGZaSFRU?=
 =?utf-8?B?WkVDdlArR25tMWZseFZneGI2Tmo2RTdXdTJOSHdybG5JaFRHSnpqemU0U2N2?=
 =?utf-8?B?b2RLL3dsanNvV2tKTjk4U0FoNlgxajQ3WWlRK21Damtrd1hkRkdIMXZORXR0?=
 =?utf-8?B?c0RFd1ZFd0VqZTc0U3FTTk4yQ21paEN0Q1h0eWR2OWtEMUdoR093UWVxQi84?=
 =?utf-8?B?aEpLUmJvRGR2Q1VWd0JYbEp0ZCtsL25OVnJJSU5sS2w5NFBZdkZEQmtrdEM1?=
 =?utf-8?B?OWJkYjgvMzFWTUNRdEZtZG5PNHJiSkxHVFQ1WmRKaDdlNHJkUm1wNk9tcm10?=
 =?utf-8?B?N3VkVnJ1VFdZcjV2OExleU1PMk1SZUkyYVQwa0NCUWlQNXVqWEhkTXlJM3lC?=
 =?utf-8?B?QjVEY1MzMFdlQTYrSTRMQllaeVU5aU9xUytScmpONWFvSWdaOVJtLzEyMTcz?=
 =?utf-8?B?aFFuNUFFN2FXTDI0aFRqdDlsaHVlOWJsOVczdUV5ZU1jVmxOd2V4VCtCZjdJ?=
 =?utf-8?B?RE5adWE2dnRYbUZJdlFaMncwZjEyMXdndmVsVUhVRVd3SUhxa3pxZ1pCQ0Fi?=
 =?utf-8?B?RWNWYjBmLzB4NFlSbURQU0N2LzFVSHR0dFZwQ2gzMkpXYkdlNmlUSWVUSktG?=
 =?utf-8?B?ZU4zZzE3Y3NTSXlJUmNnTkFqcVVsbFZmQUxkTFZHU0s0V3NWdVRXMmNBQnpI?=
 =?utf-8?B?U0ZEMWd3TWd0a0h4d05EU0dMMlJIL2oyNk1xL1BiMlVuMFJUNlZFUHdGRmFI?=
 =?utf-8?B?eWJsVVZGUjJLK2VYWGo0MU9LVXM2VUNuU2Z2ajZucWN5bk94aGdYZDU5WjFP?=
 =?utf-8?B?Sm5BNGVNRm9iNFFDOHN6ZjYxSEY5dEp4WU1WcWZhS0VwNUppdC9maHY4YTg4?=
 =?utf-8?B?UmhCaXdHREZWbHRjR3htTU5FMGlwY0pKbHdOYlU2TXJkNWpzS0o4T1NIZDAv?=
 =?utf-8?B?ZkZMbTVoODNEdHlpNnVvUW1wK1NGakNEb0hWbDhLRGpGTTBOY0FlaS9MdUxm?=
 =?utf-8?B?U2grK01IQTZoTmR4WjluYWxNelZNMjNTSE5iWGxFSUwwY2NwdmpkMVNwYWdT?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0472696B88FA744D9D6EE90A08E743A8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880dce00-b119-4ceb-6d8c-08dacdcb7172
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 03:24:49.1570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJP7QZPCwnCu/tJUfoaGKxy3ss40Rkk8heQ7tczOoA8tdTR+VoURYPu/V5QdaCaH4ke1PgtsLZzKxXrFPeihIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gRnJpLCAyMDIyLTExLTE4IGF0IDE0OjA3ICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBnZXQgZG1hIGJ1ZmZlciB3aGVuIGRybSBwbGFuZSBkaXNhYmxl
DQo+IHB1dCBkbWEgYnVmZmVyIHdoZW4gb3ZlcmxheSByZWFsbHkgZGlzYWJsZQ0KDQpEZXNjcmli
ZSB3aHkgbmVlZCB0aGlzIHBhdGNoLiBJIHRoaW5rIHRoaXMgcGF0Y2ggaXMgdG8gZml4IHNvbWUg
cHJvYmxlbQ0Kc28gYWRkIEZpeGVzIHRhZyBhbHNvLg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZ
b25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgIHwgMTEgKysrKysrKysrKysNCj4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMgfCAxMiArKysrKysrKysr
KysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmggfCAgMSArDQo+
ICAzIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gaW5kZXggMTEyNjE1ODE3ZGNiLi4xYjEzNDFi
NTdkNjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Ny
dGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4g
QEAgLTQsNiArNCw3IEBADQo+ICAgKi8NCj4gIA0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0K
PiArI2luY2x1ZGUgPGxpbnV4L2RtYS1idWYuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9kbWEtbWFw
cGluZy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21haWxib3hfY29udHJvbGxlci5oPg0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gQEAgLTI4Myw2ICsyODQsMTQgQEAgc3RydWN0
IG10a19kZHBfY29tcA0KPiAqbXRrX2RybV9kZHBfY29tcF9mb3JfcGxhbmUoc3RydWN0IGRybV9j
cnRjICpjcnRjLA0KPiAgfQ0KPiAgDQo+ICAjaWYgSVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01E
USkNCj4gK3N0YXRpYyB2b2lkIG10a19kcm1fZG1hX2J1Zl9wdXQoc3RydWN0IG10a19wbGFuZV9z
dGF0ZSAqcGxhbmVfc3RhdGUpDQo+ICt7DQo+ICsJaWYgKHBsYW5lX3N0YXRlICYmIHBsYW5lX3N0
YXRlLT5wZW5kaW5nLmRtYV9idWYpIHsNCj4gKwkJZG1hX2J1Zl9wdXQocGxhbmVfc3RhdGUtPnBl
bmRpbmcuZG1hX2J1Zik7DQo+ICsJCXBsYW5lX3N0YXRlLT5wZW5kaW5nLmRtYV9idWYgPSBOVUxM
Ow0KPiArCX0NCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgZGRwX2NtZHFfY2Ioc3RydWN0IG1i
b3hfY2xpZW50ICpjbCwgdm9pZCAqbXNzZykNCj4gIHsNCj4gIAlzdHJ1Y3QgY21kcV9jYl9kYXRh
ICpkYXRhID0gbXNzZzsNCj4gQEAgLTMwNiw2ICszMTUsNyBAQCBzdGF0aWMgdm9pZCBkZHBfY21k
cV9jYihzdHJ1Y3QgbWJveF9jbGllbnQgKmNsLA0KPiB2b2lkICptc3NnKQ0KPiAgCQkJcGxhbmVf
c3RhdGUgPSB0b19tdGtfcGxhbmVfc3RhdGUocGxhbmUtPnN0YXRlKTsNCj4gIA0KPiAgCQkJcGxh
bmVfc3RhdGUtPnBlbmRpbmcuY29uZmlnID0gZmFsc2U7DQo+ICsJCQltdGtfZHJtX2RtYV9idWZf
cHV0KHBsYW5lX3N0YXRlKTsNCj4gIAkJfQ0KPiAgCQltdGtfY3J0Yy0+cGVuZGluZ19wbGFuZXMg
PSBmYWxzZTsNCj4gIAl9DQo+IEBAIC0zMTgsNiArMzI4LDcgQEAgc3RhdGljIHZvaWQgZGRwX2Nt
ZHFfY2Ioc3RydWN0IG1ib3hfY2xpZW50ICpjbCwNCj4gdm9pZCAqbXNzZykNCj4gIAkJCXBsYW5l
X3N0YXRlID0gdG9fbXRrX3BsYW5lX3N0YXRlKHBsYW5lLT5zdGF0ZSk7DQo+ICANCj4gIAkJCXBs
YW5lX3N0YXRlLT5wZW5kaW5nLmFzeW5jX2NvbmZpZyA9IGZhbHNlOw0KPiArCQkJbXRrX2RybV9k
bWFfYnVmX3B1dChwbGFuZV9zdGF0ZSk7DQo+ICAJCX0NCj4gIAkJbXRrX2NydGMtPnBlbmRpbmdf
YXN5bmNfcGxhbmVzID0gZmFsc2U7DQo+ICAJfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX3BsYW5lLmMNCj4gaW5kZXggMmY1ZTAwN2RkMzgwLi5iNjdmZGYxMmUyMzcgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiBAQCAtMTEs
NiArMTEsNyBAQA0KPiAgI2luY2x1ZGUgPGRybS9kcm1fZm91cmNjLmg+DQo+ICAjaW5jbHVkZSA8
ZHJtL2RybV9mcmFtZWJ1ZmZlci5oPg0KPiAgI2luY2x1ZGUgPGRybS9kcm1fZ2VtX2F0b21pY19o
ZWxwZXIuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9kbWEtYnVmLmg+DQo+ICANCj4gICNpbmNsdWRl
ICJtdGtfZHJtX2NydGMuaCINCj4gICNpbmNsdWRlICJtdGtfZHJtX2RkcF9jb21wLmgiDQo+IEBA
IC0yMTIsNiArMjEzLDE3IEBAIHN0YXRpYyB2b2lkIG10a19wbGFuZV9hdG9taWNfZGlzYWJsZShz
dHJ1Y3QNCj4gZHJtX3BsYW5lICpwbGFuZSwNCj4gIAlzdHJ1Y3QgZHJtX3BsYW5lX3N0YXRlICpu
ZXdfc3RhdGUgPQ0KPiBkcm1fYXRvbWljX2dldF9uZXdfcGxhbmVfc3RhdGUoc3RhdGUsDQo+ICAJ
CQkJCQkJCQkNCj4gICAgcGxhbmUpOw0KPiAgCXN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKm10a19w
bGFuZV9zdGF0ZSA9DQo+IHRvX210a19wbGFuZV9zdGF0ZShuZXdfc3RhdGUpOw0KPiArCXN0cnVj
dCBkcm1fcGxhbmVfc3RhdGUgKm9sZF9zdGF0ZSA9DQo+IGRybV9hdG9taWNfZ2V0X29sZF9wbGFu
ZV9zdGF0ZShzdGF0ZSwNCj4gKwkJCQkJCQkJDQo+ICAgIHBsYW5lKTsNCj4gKw0KPiArCWlmIChv
bGRfc3RhdGUgJiYgb2xkX3N0YXRlLT5mYikgew0KPiArCQlzdHJ1Y3QgZHJtX2dlbV9vYmplY3Qg
KmdlbSA9IG9sZF9zdGF0ZS0+ZmItPm9ialswXTsNCj4gKw0KPiArCQlpZiAoZ2VtICYmIGdlbS0+
ZG1hX2J1Zikgew0KPiArCQkJZ2V0X2RtYV9idWYoZ2VtLT5kbWFfYnVmKTsNCg0KSWYgQ09ORklH
X01US19DTURRIGlzIG5vdCBlbmFibGUsIHlvdSBnZXQgZG1hIGJ1ZmZlciBidXQgbm90IHB1dCBk
bWENCmJ1ZmZlci4gU28gcHV0IHRoZSBkbWEgYnVmZmVyIHdoZW4gQ09ORklHX01US19DTURRIGlz
IG5vdCBlbmFibGUuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJCQltdGtfcGxhbmVfc3RhdGUtPnBl
bmRpbmcuZG1hX2J1ZiA9IGdlbS0NCj4gPmRtYV9idWY7DQo+ICsJCX0NCj4gKwl9DQo+ICAJbXRr
X3BsYW5lX3N0YXRlLT5wZW5kaW5nLmVuYWJsZSA9IGZhbHNlOw0KPiAgCXdtYigpOyAvKiBNYWtl
IHN1cmUgdGhlIGFib3ZlIHBhcmFtZXRlciBpcyBzZXQgYmVmb3JlIHVwZGF0ZSAqLw0KPiAgCW10
a19wbGFuZV9zdGF0ZS0+cGVuZGluZy5kaXJ0eSA9IHRydWU7DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5oDQo+IGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fcGxhbmUuaA0KPiBpbmRleCAyZDVlYzY2ZTNkZjEuLmUwOTg1YjEw
N2MzNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxh
bmUuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5oDQo+
IEBAIC0yNSw2ICsyNSw3IEBAIHN0cnVjdCBtdGtfcGxhbmVfcGVuZGluZ19zdGF0ZSB7DQo+ICAJ
Ym9vbAkJCQlhc3luY19kaXJ0eTsNCj4gIAlib29sCQkJCWFzeW5jX2NvbmZpZzsNCj4gIAllbnVt
IGRybV9jb2xvcl9lbmNvZGluZwkJY29sb3JfZW5jb2Rpbmc7DQo+ICsJc3RydWN0IGRtYV9idWYJ
CQkqZG1hX2J1ZjsNCj4gIH07DQo+ICANCj4gIHN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgew0K
