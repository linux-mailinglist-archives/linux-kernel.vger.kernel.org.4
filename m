Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8364263A177
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiK1Gow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiK1Gou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:44:50 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D102E388B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:44:48 -0800 (PST)
X-UUID: c5d6c9b1e5174031bc77cda5c56b855d-20221128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2pb+Vtt9kbQBvOUKbLtdXI+Bz4NgksoHMjdVAXWItZw=;
        b=nLPEvP6NW04xGzuyDa9zPC9Wr4HaeJucHVVfkZVVKHE5NZCM+yytHjbuHLWgl6E+oFxlg6Vwfd32gwB3Qf/lylHzJqrBzvt/dfuK4BpjRb2tLWeAq0TrNr0SslqwbX/wF1YKGFveEbABNcqr4zLcP7XAK1tS9P+08C287ibghs8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:a11743d2-4085-4a14-9880-c8ce2378ee59,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:28,RULE:Release_Ham,ACTION
        :release,TS:29
X-CID-INFO: VERSION:1.1.14,REQID:a11743d2-4085-4a14-9880-c8ce2378ee59,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:28,RULE:Release_Ham,ACTION:r
        elease,TS:29
X-CID-META: VersionHash:dcaaed0,CLOUDID:b3f47a1e-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:2211260102492VKLCKZN,BulkQuantity:14,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: c5d6c9b1e5174031bc77cda5c56b855d-20221128
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 479381176; Mon, 28 Nov 2022 14:44:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 28 Nov 2022 14:44:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 28 Nov 2022 14:44:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvSbG/Q0aMi3X4xF433+1iapfGd4vHIJXW+DF3qHKrvoQ/lNYOWRv6tsNg8BKE6KcSy9g5+uT+zTLchKCEgYi6FfL4wftofYA7GhLnLQl3qPynYnuDUK+gMzikmZe0I0Fw79u2qYUQX1XKfw0d5KEiMHr4gXT2J86vN8QC8Kt7T0kTuqqZWsnlANHBsGVWeCzXoZcVBX5zYDkR3oefFi1aq05OXCpNewgWqOdk0OcMccYRQxMIQIAb3hJgU7/spPLQzdxY2vQYfPPBKCpTkk4PP1XUwq3oK5UQiO/jg1TN5qKNIZUn3YtoVJTEHI0jZKaoqiAon7nixxV/vm1zf0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pb+Vtt9kbQBvOUKbLtdXI+Bz4NgksoHMjdVAXWItZw=;
 b=LFvbO3XXOu8pVhZPHMP3Rp0iHoGKgeyzz8yv8li4EFsfd0sIULsk2QJ4GDABTxG582vg/KbfVFjDKyrDPYW5dSegjtndjSsWM6RHtje4unxd4Yy8uObBA6sZv6/2sVdQgpdcJ23KYKsYEKVTX1pTSwTic3JwhBuLSDQ6fyXyaxm/zLu2b2tuYhcEZoVVjIh1hsS0lz132dduQMz0oibVHfbf9VrAmzTRK9PHULnPnckBLzeG/DKqj/jXAOcApXEu+btzGonpaduvCH6R8AusCH5eDzm1yUu5UBluTQbM1K2doTBHJw/i7Mbtmk5vYevBnCRIdVIQjTjPxz1492U1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pb+Vtt9kbQBvOUKbLtdXI+Bz4NgksoHMjdVAXWItZw=;
 b=ooOOy0vGEuk7KHlGJfhoOQMRkJKg9NCUZ4vN57+SGB6zjgvOYKSqyEseURjZtvBUl3ENKDzeCzbY2kkewTp1b7ekGsmGpVn0GGHaMZxFpzK1X/VyLh6RO96ZQ6mei3zqZnfZKRUpejXTczV9mD1l68PqEqHJlpK/H06y7+oiPK0=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SEZPR03MB7007.apcprd03.prod.outlook.com (2603:1096:101:ac::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.21; Mon, 28 Nov 2022 06:44:37 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::8ea8:d28d:e480:b1d8]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::8ea8:d28d:e480:b1d8%6]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 06:44:36 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "ribalda@chromium.org" <ribalda@chromium.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH] iommu/mediatek: Fix crash on isr after kexec()
Thread-Topic: [PATCH] iommu/mediatek: Fix crash on isr after kexec()
Thread-Index: AQHZAOr2Is+QkAwmIku7JvGJIBERx65T5+wA
Date:   Mon, 28 Nov 2022 06:44:36 +0000
Message-ID: <9e81fb3cc4f315f330c610dfb16bad50b7241f4c.camel@mediatek.com>
References: <20221125-mtk-iommu-v1-0-bb5ecac97a28@chromium.org>
In-Reply-To: <20221125-mtk-iommu-v1-0-bb5ecac97a28@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SEZPR03MB7007:EE_
x-ms-office365-filtering-correlation-id: 12ff0510-ab55-499c-b411-08dad10c0454
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqEP2L+LbuJFxYj3v624whJx9a2WAiUUgZ9w9LlYRz4NyILiLi/D72+vzpdNT1jVKoeYD5Qe/Xo7je5iz7en8Wjfo2nzDj6Z5WvkwWfpGiqpFfdM8rsy/BXDNrmfP8G9xsZaWckhKFgYTdqaRJQxu6/wlU+c9U3E/WvKs3I/hjHyIAUlNrxvwbvWtV0PoAeJK0wi8HzQ314ddaaX0HIcmgeXsEuKAuWhYbSlUSiGD8xXck4a4xuwZL51jGgBdRo28XSDmv74eY/Mz8oKNguUHaJ361sctwlZ+4mJMgE3zMkKOaJ+p9LcKG9yA2MOb6qsRy+DQZjvFhga5Y2bSug7yzM05QALi9Dk0ayC+XtFdarjeaSQV9IO7kHVXFWGTHd5S7BV8TR9SpqxNUiQpM/XXoCCD6Cdh5D/ZAcD8MRhZ5RMhSIHMDEo+PFfvsllIksOcSusROl3ljXw90WaJnj8Qc/XIauf4aIzfx/s5DkEtwq8iRI1H/3aOeXdLXFNfrwXPgeYovnl8iRz0YyRgwm+MtCGqfoIFfHj0LDCnOYoxCGa8+7iLofzvkbE+oemZ7oPrRXukKdVoH/5qL3UkQdVNpm4m2DB9rdE7xLbQzs4/MPCnjGJ/rHmZ4RWv3L5Q+MdtdO7OFIYMwTBdAW8mun0ZN8ukHo8rDkuaKcdbslavJ9dlCrWfFpt2BL2ur6zxx+PEFqdQclvDtsbDHF0IaXWY+3u6ySQF/S1XVn3SgnT2BBpAACkM5Hq2asV0x3d9EosQiQsbGOJXcXLyXOQoamoag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199015)(4001150100001)(41300700001)(8936002)(2906002)(5660300002)(6512007)(86362001)(122000001)(66946007)(6506007)(2616005)(83380400001)(54906003)(316002)(110136005)(186003)(4326008)(66476007)(8676002)(66446008)(478600001)(38100700002)(64756008)(66556008)(76116006)(6486002)(38070700005)(26005)(71200400001)(85182001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGJaZGZPWHdPb2tqSjRBMnNzejlha1VsbnFodU9KMUJIbEw0TGVCSVl5MCtV?=
 =?utf-8?B?ZFdNckNrWUVYY0JhV1VVQ1lFNldtUkFKak9ENlJyeTZteTdualA4ZHBkakJn?=
 =?utf-8?B?UlMxU3MzajZxaTlwTVhaRkVOVG9WSDlUc1RRUUxyRXhpSkpYWGM3b1JlOXN6?=
 =?utf-8?B?bWNLV0JVeTRIdEhPSFBBR0t1OEJacExMNzY0NnFyRVB2Z3FWYWhVN2ZLNTlv?=
 =?utf-8?B?dWtJeEpqcUlUV0VvM3pwLzMvUGhFMDB5Q1dUV1FzSGVPUlU1YkJzRkxjQUNR?=
 =?utf-8?B?RGl5MEZYY1VxYlBoSmtFMkZQdXZjbHd4bkJxK05DL1JJU0NtUTQ0Y0xLVDNt?=
 =?utf-8?B?ZWhqMkxWdnJmazIvWTZHcVA4NFA2VDhSbWdXRzVPakMwR2JZM2E1SmNVUTVK?=
 =?utf-8?B?ZXR1bmxDZHhVQ3JjMU9acnk1b3NiUmN1T1gzS0FmVHdMU2ljcDYwMHJNSVd0?=
 =?utf-8?B?SHBEeHZIWnlmYVdCM3hQT1NJaXRRNk83c3V4bkYzWDVuNmxQTzBIcEIwTDFr?=
 =?utf-8?B?dWVWS1Y2dFhiSHdPL3IwTTZ5WVVFVmNhTEY0dzU5bVEvcmVZQVlja1JxQ1RU?=
 =?utf-8?B?WmhOUmswS2tYcEtETTcza0d6bGwwYkVnZ01LV0kwRjNzVDNrQlg0dUVDdXZX?=
 =?utf-8?B?QmdOZ2dwb1FKd3B1WGRDRktIT283elBSZDRidC82c0QrSTQrYjhvajJURG0r?=
 =?utf-8?B?c2dtWm5CMkVyeEt5czNsMGUvMENkaGVLcEt0V0swejAvNVpNbk42MkIxTG1L?=
 =?utf-8?B?TFh1MkRtM21WaWc5T1V2ci9UbVV6bld3OWNJZXJhaXRLcUUvNjlhbFM2WFYz?=
 =?utf-8?B?dFF4RG5jOWhtclVBTWhXWHpYOHdxdm9mNkdySWJFazA1REtaZzNFdjVtQ25h?=
 =?utf-8?B?SmJxTkxQazIxVlFyUnVBa2ZzRWtUWmRYZG9iSS80OGtOU25rREljdzVFMk9L?=
 =?utf-8?B?UTNMaUVqcTVzN3dIc3QwTlNUczYxZDViMWZ4ZEFSb3RXOHBUaStrb25Fb0pL?=
 =?utf-8?B?QUFmeEpLMHpJMGpsTy85dWVuUml5ODlhQ0Q5cVJveE5JeUt3STFVSno2MDV2?=
 =?utf-8?B?U3VhdWxuWUFuNStwbng1dUxDazFwMWZ3NEN1d2tTbExEMmJxSTdOWTkyTElp?=
 =?utf-8?B?Y09ka1NOQndINUxVSWpTK0s4SnFzeVk4SDNaNndvdlRyRjJYTWxPekFjZkg1?=
 =?utf-8?B?OWMrejVuTlRQZVMyeCtlSWpsS0Z1M3FIRHQ3Mm1hSm9SYUs3ZWN3bks5Tklk?=
 =?utf-8?B?OTVWNWZoOGpnd1psT2ZaMW82VzhEZ1J3MUJGVEI1THNuQmU5ZE5aNE95SlZx?=
 =?utf-8?B?eWJuZm55U3VRb3gxWEMwZWFjcVNPSnZFY2hXQm0wWVZ4ZzRxbldJaWNKRUVJ?=
 =?utf-8?B?SXA3UGFpMzREZFloSjkyQTJGb0htbjFFT3RpNys3UzhoVGdZV1hLV0w3SGlW?=
 =?utf-8?B?cUFEUGwwN1Bnb08ralJZQ2tCdlVpbzYvTlU0VUhYLzIxOW9UdEJ3NW0yeFpJ?=
 =?utf-8?B?ZzFrR2VkYWlzZUcrRGNWeFV1N0ViVmUveFJVZjhJbWovVkhEZlEyNDc2b3J6?=
 =?utf-8?B?dWttVUVyU3hnWmM5dUtkU0ZjUGI4NXVCQUlscElPZ0ppM3RIcWVtVHFoVDU0?=
 =?utf-8?B?VmJaL29qVTZjK2w4aEJWdXIwSnYvaGwwN0lFbmpaL0NSdDNLS2o2UWNNeFk5?=
 =?utf-8?B?Z25DQlBiOU9IU0lIMUlQNkszNll6RURyQnVhNWVzOHJmazhJK0ozYWVtNkh1?=
 =?utf-8?B?YXZJL1RxdXYyNFF4WXM3Q3U3QUVhRGJUT1lTcU1JaXM2TDN6aGlQOHJuTWMr?=
 =?utf-8?B?UGdPQXZ2d2NKK3hEZDJYSXlxK1EyWlp5Qkoyb3UwZERUdlM0TDdpSm5tRGwr?=
 =?utf-8?B?MzhlZzl0NWZaM1pvOVhBd3BBL0N5cndkdmhaenRrZlh0cml6VHA4ekdaMG52?=
 =?utf-8?B?cFJPREVpMFU2eGxZd0FtT3FKTWFDNFNJUGdQT0Q0RVlOWStzS2Y2N0QzNUZZ?=
 =?utf-8?B?V0hqMFREYjA3S0w2WC9hcCtwU3VXdEFkd1lTZ1I3ZmJRaWxGQWgwQjAvODFi?=
 =?utf-8?B?OTJDT3FoenJYdzVCTTdncWZ3ckRrZWNYVFgxRG1VeHJVaUFDOEVWTkxiWUdL?=
 =?utf-8?B?R09TWEwrWFVuUGtrZGJBalBmLzZLZ01LZDVuNU5ldXlFSTFzd2lNbXdhNVZn?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B35772F8BCC6C241AE56A2CCD293E6F9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ff0510-ab55-499c-b411-08dad10c0454
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 06:44:36.8506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBrrNbwJwATo1mnx4H5ZHL9UE/hlaKIAe49Nj6L/JZSWRwhIlf0E3iv8MTG+X7ZSQCND/zpbAGgwFaANoA/aWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7007
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTI1IGF0IDE3OjI4ICswMTAwLCBSaWNhcmRvIFJpYmFsZGEgd3JvdGU6
DQo+IElmIHRoZSBzeXN0ZW0gaXMgcmVib290ZWQgdmlhIGlzcigpLCB0aGUgSVJRIGhhbmRsZXIg
bWlnaHQgYmUNCj4gdHJpZ2dlcmQNCj4gYmVmb3JlIHRoZSBkb21haW4gaXMgaW5pdGlhbGl6ZWQu
IFJlc3VsdGluZyBvbiBhbiBpbnZhbGlkIG1lbW9yeQ0KPiBhY2Nlc3MNCj4gZXJyb3IuDQo+IA0K
PiBGaXg6DQo+IFsgICAgMC41MDA5MzBdIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHJlYWQgZnJv
bSB1bnJlYWRhYmxlIG1lbW9yeSBhdA0KPiB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAwMDAwMDA3
MA0KPiBbICAgIDAuNTAxMTY2XSBDYWxsIHRyYWNlOg0KPiBbICAgIDAuNTAxMTc0XSAgcmVwb3J0
X2lvbW11X2ZhdWx0KzB4MjgvMHhmYw0KPiBbICAgIDAuNTAxMTgwXSAgbXRrX2lvbW11X2lzcisw
eDEwYy8weDFjMA0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBSaWJhbGRhIDxyaWJhbGRh
QGNocm9taXVtLm9yZz4NCj4gLS0tDQo+IFRvOiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNv
bT4NCj4gVG86IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPg0KPiBUbzogV2lsbCBEZWFj
b24gPHdpbGxAa2VybmVsLm9yZz4NCj4gVG86IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFy
bS5jb20+DQo+IFRvOiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0K
PiBDYzogaW9tbXVAbGlzdHMubGludXguZGV2DQo+IENjOiBsaW51eC1tZWRpYXRla0BsaXN0cy5p
bmZyYWRlYWQub3JnDQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcN
Cj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+ICBkcml2ZXJzL2lv
bW11L210a19pb21tdS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gaW5kZXggMmFiMmVjZmUwMWY4Li4x
N2Y2YmU1YTUwOTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4g
KysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiBAQCAtNDU0LDcgKzQ1NCw3IEBAIHN0
YXRpYyBpcnFyZXR1cm5fdCBtdGtfaW9tbXVfaXNyKGludCBpcnEsIHZvaWQNCj4gKmRldl9pZCkN
Cj4gIAkJZmF1bHRfbGFyYiA9IGRhdGEtPnBsYXRfZGF0YS0NCj4gPmxhcmJpZF9yZW1hcFtmYXVs
dF9sYXJiXVtzdWJfY29tbV07DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKHJlcG9ydF9pb21tdV9mYXVs
dCgmZG9tLT5kb21haW4sIGJhbmstPnBhcmVudF9kZXYsDQo+IGZhdWx0X2lvdmEsDQo+ICsJaWYg
KGRvbSAmJiByZXBvcnRfaW9tbXVfZmF1bHQoJmRvbS0+ZG9tYWluLCBiYW5rLT5wYXJlbnRfZGV2
LA0KPiBmYXVsdF9pb3ZhLA0KDQoNCldoaWNoIFNvQyBkb2VzIHRoaXMgaXNzdWUgaGFwcGVuPyBE
b2VzIHRoaXMgaXNzdWUgaXMgaGFwcGVuZWQgaW4gdGhlIA0KdXBzdHJlYW0ga2VybmVsIG9yIHRo
ZSBkb3duc3RyZWFtIGtlcm5lbD8gDQoNCk5vcm1hbGx5IGVhY2ggcG9ydCBlbmFibGUgdGhlIGlv
bW11IGRlZmF1bHRseS4gTGV0J3MgcHJpbnQgdGhlIGVycm9yDQpsb2cgZXZlbiB0aG91Z2ggImRv
bSIgaXMgbnVsbCB0byBjaGVjayB3aGljaCBwb3J0IGZhaWwgaGVyZS4gdGhlbg0KYW5hbHlzZSB0
aGUgcG9ydCdzIGJlaGF2aW9yLg0KDQppZiAoIWRvbSB8fCByZXBvcnRfaW9tbXVfZmF1bHQoeHgp
KQ0KICAgICBkZXZfZXJyX3JhdGVsaW1pdGVkKHh4KQ0KDQo+ICAJCQkgICAgICAgd3JpdGUgPyBJ
T01NVV9GQVVMVF9XUklURSA6DQo+IElPTU1VX0ZBVUxUX1JFQUQpKSB7DQo+ICAJCWRldl9lcnJf
cmF0ZWxpbWl0ZWQoDQo+ICAJCQliYW5rLT5wYXJlbnRfZGV2LA0KPiANCj4gLS0tDQo+IGJhc2Ut
Y29tbWl0OiA0MzEyMDk4YmFmMzdlZTE3YTgzNTA3MjVlNmUwZDBlODU5MDI1MmQ0DQo+IGNoYW5n
ZS1pZDogMjAyMjExMjUtbXRrLWlvbW11LTEzMDIzZjk3MTI5OA0KPiANCj4gQmVzdCByZWdhcmRz
LA0K
