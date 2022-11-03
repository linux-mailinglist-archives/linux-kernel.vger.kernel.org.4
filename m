Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5714161764B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiKCFoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKCFnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:43:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B274213F64;
        Wed,  2 Nov 2022 22:43:52 -0700 (PDT)
X-UUID: bb32e0ab30fd4309bd18c56b0a902992-20221103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=r/Hl6dER18Nai+w1o8qNKCypeLHj/TKdH7SoU9Mw3bs=;
        b=IwOksrJJe4AqreD9cZBsktYjF+idle7Q2+X9RdbPkkX6Klp0fWSmuy+wm4CJ0trAFifuQ7vxJYV4fAcKBhvI4YMml0JjvembSQy6d7ERQDDmRyedkKH+m1LT7FctV6rxuwXnxcVvgqVRpjS09y7+Sx6G2Kx+R9vv3MqMu+y8qeg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:a84f6229-277c-4ef4-a5a0-fd13b99eee8d,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:041e4beb-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: bb32e0ab30fd4309bd18c56b0a902992-20221103
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 426539578; Thu, 03 Nov 2022 13:43:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 3 Nov 2022 13:43:46 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 3 Nov 2022 13:43:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KImw9ES/kQc00ENbJjFGsBAXKcf8NZyBJN7gNXIzgdBAGCVmy+OQgHviA2mVtUWJjMIZtbqcHNfm6fm4omrZ5T9QCFlPPpEDec1Fcna9edowNXEesm6+27xPbQqrVU5E1RAJgiWozlD1z8dLhLEBuruflFXxsZeXxcXv8pSvZerk7d+2i6fy9tAM9sa6+K8HOEnYrqGVujPeb2ElQYS6L7Pi8y88fV2jwgw1zgnb+0IyxTQkNceyfuAFNxfkFYYZHFdawKQnPOSeAa8yf8TEGKV0RUSBHWJRkdnjMvpkLwh6CK+RijyxXYbjo5rlb5Cqy3rJgu/5uV2DJsMEkLzoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/Hl6dER18Nai+w1o8qNKCypeLHj/TKdH7SoU9Mw3bs=;
 b=Fm7fMoOmoeU+UPLtYk6XmzniEgFP7irLcV71aIloTOBFM3woc+rokf48Sw2lqGpZGuCpH6oh0mtr0s8BaZoVoUax4ZRHxSmX6oT1OIXaulkOc1HRSPsxeGX9+KHGhuv8arF02dxyWGwmaoiZ9h+QeowDOI0ryYBl5SdCZnNdub+fY+HDSpbrr36LMpQzuCG7PnJ67g5fTmeLXBMODwR8PJNqfnIqcE/wZLy2AOw9I3tmg9VhJpcnxhm/wl+PnH0e9onBpWgwi42rIPVb2xRW/fctH6KsUPLZ42/CMl6UU4yXXb0trEYxzsxopPHypE8p5KHUHRxXq4nXK3rez1QRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/Hl6dER18Nai+w1o8qNKCypeLHj/TKdH7SoU9Mw3bs=;
 b=viEJGIGo99OHTIdJOx7RLkmMA4pnMmXBiQbyVx0a/tHBWrCGEH4G+XAM835bLUxTdxW2l216d6B/YWVa3MkZt9BFjQwDK3N6+iG8fuFlGqdLBhibrJ7Sho96ogyWuQgHrRdFxaNfxRHKMSfAIH2z1E2C98p6U62wJ9bTTFG5LGI=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SG2PR03MB6683.apcprd03.prod.outlook.com (2603:1096:4:1d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 05:43:43 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::6059:8025:59fb:55b7]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::6059:8025:59fb:55b7%4]) with mapi id 15.20.5791.009; Thu, 3 Nov 2022
 05:43:43 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     =?utf-8?B?QmF5aSBDaGVuZyAo56iL5YWr5oSPKQ==?= 
        <bayi.cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "gch981213@gmail.com" <gch981213@gmail.com>
Subject: Re: [PATCH v1] spi: spi-mtk-nor: Optimize timeout for dma read
Thread-Topic: [PATCH v1] spi: spi-mtk-nor: Optimize timeout for dma read
Thread-Index: AQHY70VfsHmgJVcej0yOAuqgNyNava4sr+sA
Date:   Thu, 3 Nov 2022 05:43:43 +0000
Message-ID: <4c3af48b0300508312782db1eeb16c352e191e87.camel@mediatek.com>
References: <20221103052843.2025-1-bayi.cheng@mediatek.com>
In-Reply-To: <20221103052843.2025-1-bayi.cheng@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SG2PR03MB6683:EE_
x-ms-office365-filtering-correlation-id: 731fc964-6580-464d-9909-08dabd5e5e33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: STCsaltkrHiTc5jQttew8xrgmNr+hQeeXslq0wPqQDguLs/KnVn6BWyf+QPuzJW72fi4+biFqg5RQDa0yz7LzhGBIVXcPcW0Z6tVm0DneOVAS7rsPe7zLwVjz6qtenrLdoRby0k5NsgieUgHhr3YM2YIKslkVw+o7WOr7IkrgBDU4p9YK08D1BvN9VeR62AGMf54zeiTAPZHaY3kT9ZFKTnmM5VxS8HhpTkeNvu6ziOMnMMoVLHDO1bVRykcbq5WA85NkyOggFecQRyxyFkjVIY1iNNsYN5WjaDe/xssRzRRFwExSOzxdh1G4OU9QfuUtEBQ54MIQM2//3Es9VY6vUnZHV1d2/FOrBCX1UL8Q62NjWTXrltl7oEh1KjY1QGSuH6TWrqRx0KESNRUhJ5Dd3nk91Y6tik51k7jyrPrC45nPlsJT//lwL51MS/sQPDw0Z7kthVnJc1e0yEwJdAwd0tAwOZh68rasfDU6DiOUcJIHirIzqwgZtI833K9zrBPAGhU8+7vzzLxz/MgR8u/+mHBibLOoTw/XNIMl7jdf9dXAIMsMRyjJiMrgB88aWj6iBy6DU5dMvFo1wJ0iWAgTz5r8qjHgADohuKIMnqCPKA4DZU8dMf+PijNJtEoATV2h8gADh81ZH3nWh8gjB55CDNjlTxGKWEjB6MOaZ3Fj9fYctHP+E3Mgf2okBDHgve/peoH9p1aRS5Wnj2++yC5ZpBpGuNVjAaK77DNdeZwCZxo3DDnHxseKOdejkRbPaet0YyOGalror/hac1TAr2KvCaumx53a3LvX/KqqQ8rBLI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(186003)(122000001)(83380400001)(478600001)(2906002)(41300700001)(71200400001)(2616005)(36756003)(4744005)(966005)(6486002)(86362001)(8676002)(110136005)(54906003)(8936002)(6506007)(38100700002)(85182001)(6512007)(64756008)(38070700005)(5660300002)(66946007)(66446008)(4326008)(66556008)(66476007)(26005)(76116006)(91956017)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eldZdVkyOGMyZXdiMzVRNUtvUmc5b2t3c0IzZkJ0S0ZFM0VtZDdVTTI4WGkv?=
 =?utf-8?B?NTBZRGhmYTZBbFdVRFNOTzVhVUVBY0puSU5TSU5Kc29EZjhKQStZSEJmVHlQ?=
 =?utf-8?B?ZmpKc1hLTTBHa1owT0I0N3E2UjBDZU01UFgvczhkMUxRME1OcUpSejY4WUFL?=
 =?utf-8?B?YmZWbkFkSjBtV3pYdnpadWlFTy9HcENUSDFNUXVGb3B6MTM4L1ZYcDh1OXU4?=
 =?utf-8?B?THp0UVI2OU4ycEEyZ2tnMVlBN1NrUXY0bHNzdHluaGd1elZTQTRlTXF0Z3F4?=
 =?utf-8?B?SUlPeHVxRXMxNHJWNC93akVYQUE0eHltOSs2cWx6L2hsNXNxVmI1dXlCMTlt?=
 =?utf-8?B?eit3cWFzV2JicjZmVzZQdHpFQ3FkRjFPd1RaNlV2eUQ0RGRDVUtYQzVvOGZt?=
 =?utf-8?B?Njd1UTJGL2gzSnFoVkFjVzhHbjRQRktrR3ZMT2FseW10b0kvdWRjVG1vaFhT?=
 =?utf-8?B?ZjhFSnBuR015ZzlWaE10ZkJuQjh1S0lpSkwvd2xGc2ZWdk1HL29PcE1SVVhx?=
 =?utf-8?B?S3YwM1dLSjk3TGtYN0pYa1U5d3RGVVdzQWN6MEVZWVdub0FBQnFCMjF1Y2pW?=
 =?utf-8?B?YXNjdnpRMmV5Z2tpQ1NLUmwvUjNybHJ6clE4Q1dIdGFpMXpRdXExMy9rMVlL?=
 =?utf-8?B?RmZ0dHJPeHN2WGYyVlpJL20zWVZaN0FhVWtTZ2xNc1RJT1Z6emRESnpySXpW?=
 =?utf-8?B?T3ovNkgzb1lEZWR5cFhaQWFRYVY0bzRQVnZOZEMvaXRkMmtncnJLSjJ0QzNR?=
 =?utf-8?B?Slk2aHZ5MjcxTE14RE4ySm1pRUlHbUZ0WE91KzR6OVkvVjdIYWRmU1BwZ0pj?=
 =?utf-8?B?bUhNYmtlOW5DK0hiR3ovNEFUNWRmcnBTZTc3NUU1YlJ0anpncVEzakRtN29H?=
 =?utf-8?B?NXRJcmhXZUZrODd4b09vaUh6eDdoRHdxK1lSUmp0TDZLUExIaVdCNlJnNjJH?=
 =?utf-8?B?Mkw0SHFlcU1wdXdWcFViNEh0dWtIY0hnU2tuaTAzdUJlUnIrbEVwWXdJalFF?=
 =?utf-8?B?WDBSSHFnbmVrV3lHWk45NlRVdWJFcjVubEowZkhseGt3WExCSlBCdE1YcVZT?=
 =?utf-8?B?NmszV3lhc3Z4QnRkbVJrRHNDTU42Z1JxcjB0SUExNzJ4Y0FPOGxiZFBmc0p0?=
 =?utf-8?B?KzJobnhwWWs0dHpqMTNUckZHQTExY2ozY1V3c0NBdGFmYXJveUhsbTVFMUQv?=
 =?utf-8?B?ZjIrZkdBdmFQeGphRllMbWUzcXZiNUZSbmdvYnNzdDVpd1RZQ0FaNEllY0RE?=
 =?utf-8?B?dTZmQ3ZWY05oV3BtRml0MkEyY0JxV0l6cGY4bHNxS2hiZklWTmdIRXovbnZr?=
 =?utf-8?B?L2VuNm9qVXNNRThZUEErZmpqd3V5MTRBRWt3R01UM3A5dmJMZUFKbmlIelBE?=
 =?utf-8?B?UWswVzl0Wm5EVlVTS3hpT0FwcFRKUFp4bkhVUXJ5NDRzNVUrekJRcGpmQmdo?=
 =?utf-8?B?MHdIaUVOZnl2Zlo2YjhZOTZSNnpFeExFT1RxN3lQVFhGbHhPTEo3d0ZKVGRG?=
 =?utf-8?B?aXVxOG5xZkVOU2lkTVhtZ0lLYnA4UHBpT0MvcDMvRnJBZVRRV0liV0ZUVGpj?=
 =?utf-8?B?dEtkT2o5MFFyT3RnYi9IMi9DTDEycWlidjczM3hGUm5qdWJDaUJ4T0xhUzZt?=
 =?utf-8?B?YktmQUF4T29Zd3B0TEl6V2c0dmNaL1lrdHJQeFZzZDYzemNVNnRldTQrMWpM?=
 =?utf-8?B?ZGRTb2szdk1BaEFYcmo5SkU2NnFmeFhoeHFha0w0L0gxb3JRbDNsL0Y3OHdZ?=
 =?utf-8?B?UFJSbGsyaEtHOWZUdmsvdHM3OXRUOUEwNGtSYkVzdTlpL2phSmdsUDI4bmJE?=
 =?utf-8?B?RGdRWGhFckZtbjc4STJGbFcyb1VYeFJPejg0NjQybi9GYm1UVis1b3JoeHhn?=
 =?utf-8?B?VGFERTFNUU5mNmtaTE8wcEptNjJxUmVFdVlpZ3drSmR5M1FxZnFCSXRlQS9W?=
 =?utf-8?B?bTlIY1QvSDN1TzlJRWRCelZZdmtPNnRKWDlMWDRhemVoT3VpS3VZOG1MeE83?=
 =?utf-8?B?Q2NsZEZVTVhxTXg3cUFIR3FheEJoSDBZbWZFRGp6ZUdNeTNaMUorTU0vTytj?=
 =?utf-8?B?MERxWThCUS8zdzZUSEI4aGVpblBGZ0NhWE0zSEI1eWpVbDhIQzNBQ2NJcFBu?=
 =?utf-8?B?bnJ1QloyWXJKQnE3T08rSHJFVXdFNFRaby8wZkxwbkYvaUx4b0NRY3YwNkZ2?=
 =?utf-8?Q?mI9FNrIasy6ugYJ8A3cKx/k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75200688B833B04CA9D503C9C54B99DB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731fc964-6580-464d-9909-08dabd5e5e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 05:43:43.1049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FF4tXAEuhDizx4vuO/ahCUWmel5vu/Bh9rReJhhhXsp6s6Y6KxWtnmhRz5mxrCb/imHJlyxi7ZmB33vcRy5t15psXwwHS0GrGhiJgOyisPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6683
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmF5aSwNCg0KUGxlYXNlIGRvbid0IHNlbmQgY292ZXIgbGV0dGVycyBmb3Igc2luZ2xlIHBh
dGNoZXMgWzFdLCBUaGFua3MuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvWXVK
c0RJOHJxa0h1eXNJVEBzaXJlbmEub3JnLnVrLw0KDQpCUnMsDQpBbGxlbg0KDQpPbiBUaHUsIDIw
MjItMTEtMDMgYXQgMTM6MjggKzA4MDAsIEJheWkgQ2hlbmcgd3JvdGU6DQo+IGJheWkgY2hlbmcg
KDEpOg0KPiAgIHNwaTogc3BpLW10ay1ub3I6IE9wdGltaXplIHRpbWVvdXQgZm9yIGRtYSByZWFk
DQo+IA0KPiAgZHJpdmVycy9zcGkvc3BpLW10ay1ub3IuYyB8IDcgKysrKy0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo=
