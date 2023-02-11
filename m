Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23629693062
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBKLha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKLh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:37:27 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6D920D20
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:37:25 -0800 (PST)
X-UUID: 6bea95caaa0011ed945fc101203acc17-20230211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ffa4TbfvMcRgr83Z1KM6OmsjIclNeAm0Wrn1eBVT6So=;
        b=Q4TTxiHWEg8Pdoilgv8osJb77nwT9c1OQ3GJiMbZML2WlgoQtIYjfqn7t1dkmUU9m/8mRxjkCUw2fE0X1hPZjq0eqmxniTUGkUnRRw8oIe30/1gbJD5eu/5+X2YDOAwOgr+QpFOZ9wrTHqYeIWHGXfCECAaCnSxQoITNXj+XOAI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:e4b51ea6-ae6b-42c2-8f5c-cdf040f6d56c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:05e722f8-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 6bea95caaa0011ed945fc101203acc17-20230211
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1176851841; Sat, 11 Feb 2023 19:37:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 11 Feb 2023 19:37:09 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 11 Feb 2023 19:37:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L12tIveCm8UsiERjYKQF2osSIslip1Wtex+PcjslD3g5lVCZdB+xalqgUIIprpX85Nrm/Z4d4hQil0fTvjX3OGixwV2jLeJTFj/c3a86BcSvXq7qgKc6llMBLBtZDw3GxQFtbtBIHGYok1PXn8g/O/lMvYIBz/yE+KykFuHPIJyl4XOlhFGOgKoZ3an3Z/Xuh9QektSOqzkC0yID8HcdseNtcqBP3CJ0pGGw67hphEOxyBL8+aFhwp0XAIUAlzi4IdThZmDjfofAucv4FI59Nib7pkdlT4QePb/UR/nPyoHd/auo2771wonUWIFeRdRlcYMKA+lIzaACGPCO11qXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffa4TbfvMcRgr83Z1KM6OmsjIclNeAm0Wrn1eBVT6So=;
 b=nsMDacerLzHox/7irgbimZv8KsjDQTN4XdUYqQPyj64OYm3fc91nVR51ZnxJsoThBYdB1eEN1c1EmzklHcgMrT9JVCe1h2Rb7qdVLNARfN66GAVOjF5xbZ5CwQbM0Qfm19Tyg+neGlu+pSC7sNf6+r+Xpb8/uJw7akF9S1YUvvu4hY0gguUR9QD95gySjn9fbE0os69nbci6R0IrnbqPNuLhw2ou3LNO7pwpoxmlFZ6hHefgmMN0Hx4GdNORkMfRqYzPU4wxKk7wvGPbuGHpRhzLzPksab6I6rpXuf48bbvdEzNM2JWO4mH6S2S0auimOyq5sTfduWBM8GaWnpPBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffa4TbfvMcRgr83Z1KM6OmsjIclNeAm0Wrn1eBVT6So=;
 b=RDIhxpGADmR+faOU0nK/8QukRgwTVqihgwjY0WTGU/wsMVg1zfFFZ+w919aDn/mzkLYuWovX7YpgBegV2ttQ01c+gMllZOkpoHQcGNJkHUFvQPFIBteoGvMEq+0A3B+WHru6NiDhU6mH6qwCG1VbAFZbpw1lYc3XQFWJhzvJW7I=
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com (2603:1096:4:26::14) by
 PSAPR03MB5653.apcprd03.prod.outlook.com (2603:1096:301:8f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.21; Sat, 11 Feb 2023 11:37:06 +0000
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::39b4:279c:45f5:a591]) by SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::39b4:279c:45f5:a591%7]) with mapi id 15.20.6086.018; Sat, 11 Feb 2023
 11:37:06 +0000
From:   =?utf-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>
To:     "matthias.bgg@kernel.org" <matthias.bgg@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH] soc: mediatek: mtk-svs: delete node name check
Thread-Topic: [PATCH] soc: mediatek: mtk-svs: delete node name check
Thread-Index: AQHZPKMH+zsy4XDP7Uai+ARXSfAp3K7IFYIAgAGLjIA=
Date:   Sat, 11 Feb 2023 11:37:06 +0000
Message-ID: <65af4673ef79d8dd3404f4cfb773859410c85cc5.camel@mediatek.com>
References: <20230209162403.21113-1-matthias.bgg@kernel.org>
         <12ff7576-76d3-8cb6-4c8f-6c9417ac28c2@collabora.com>
In-Reply-To: <12ff7576-76d3-8cb6-4c8f-6c9417ac28c2@collabora.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3434:EE_|PSAPR03MB5653:EE_
x-ms-office365-filtering-correlation-id: 1f7d4c1e-ad1a-412a-3245-08db0c244d6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tDTbbKS9e1qVjXJwN00waND16a0buFedHdymYLQHBrmroRjdZrrJTG/+KJZkS2j6T4YXGltjnxYBHfgU0nsRpaP3irM60oVeOgxuNMUzST/AIvHkZWDon7tuVp5jdaaCAsQ1Mj1ewStkTIUQlKKsNluySUd2VeWGJD5kFqzY0wf8+6lB8EYDpGrC8VNS/pCEAvapHqkPtHW6wJoCxCAgRnwLshq2474yV0PZ55fTCmgAQfRAKxhkhinEEuZVeg7awtFj1hURqCC1eeYFHydolUEMl0LFk/BBLYDOuLQUiIJohKaZ4yfUyn9AR3FfqjyuM7BsWZc4oNkE45xIZoeHEUHc2GaW2yFAv90gb1m09CBBqvofgwUlqigRcFSi9j0Z8MrcR+pFTOpLqC0k5smjDePj0/eysBkfKHgCfMSM9LOjqj3Di9icEyeYPKK5SWfOmb7mZouyW+oiWYJUVeN6cFSNhYad4BOJ/JP2hAe0oTuSFTDvpyd5BhYaUehF0iO/zeuw8syjw/WaYNCw4Mqrv/jFNs9gVyZ2EcYM2uJs7/hSlQ01zUuTkQ7LTZjYTbnFAljr4kXDA4FGBnUsUCg0p/lWybf9wouC5lkkwyVllnL9KhIbfDUH/RXYajqjlyjOcUh8Mtcxbc6blEsfNcSJEvZC275YrFzXIDj33jFIdvbpvbAttzQmZT+lbUdgplPoJtcDpslpWBLslThU1ef7wOcppUVjLIIu/W2yVXDlhmcCvuGzNLfkEZirYoFXdiej
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3434.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199018)(38100700002)(122000001)(2906002)(86362001)(4744005)(8936002)(186003)(26005)(71200400001)(6506007)(6512007)(478600001)(38070700005)(110136005)(316002)(54906003)(6486002)(66446008)(4326008)(8676002)(5660300002)(41300700001)(66476007)(66946007)(66556008)(76116006)(64756008)(85182001)(36756003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dytvM1hrd2kvMVVFL0ROMzNGeWp4WE9YUzRSSmd1ZTREVmlXNzVndkpaRk5w?=
 =?utf-8?B?c1pJdWpQWmlsdHFiaHFYd3hBUDYxdVE2eUJVR2FQcWVtWHp3RjRBVDAyMitO?=
 =?utf-8?B?OVNGNjBzQUd5ZWN6S0hjM29wZGd4WDdBOUZDeUh6bkRQaUxROW44UjNNWi9B?=
 =?utf-8?B?SXFWbnQ1aDl3VEllbzVFejhlZG4wcTVEc2IvRmlweStWd0VlS1B5M2FjNVcy?=
 =?utf-8?B?Z0NHVDVpZlhVWE1VZjFDb25mN0F3OW1aODltL0tRY2h4M1plSjZySUorZ05U?=
 =?utf-8?B?dS81ckhGcjJQWHRzVmNuK05SZHJyUjY3aVdEeE53ZmE4czlsMEVEbnk4dGhx?=
 =?utf-8?B?cjIrODZ1RnZlUC9PQjJlUURVOHUydG5VQldVU1Bvd09KNFF2Ykt0N2d2OG1M?=
 =?utf-8?B?bktMemV3eHNSRVdqR0hKM21IRHZmcXBqVTZ3aHhJdmZjaHdzS1k5dTFhdWY1?=
 =?utf-8?B?b2o1b3hqejV1bXprM1FtanIzSW9LTWVtMU5Rc0MrK1RkV3VOSkJzM3V3ck9r?=
 =?utf-8?B?TzVGT0JhNXJjRnFJS2hiNlVyQTJ5aWFRcGJWUU1HZVBOMlZjU1VrN0QxS3p5?=
 =?utf-8?B?c3pQRERSNVZzdUJ4SmlpdzlqMlowNkxaVTRpMlM2cVl0Rjk2WG40cnFjVklp?=
 =?utf-8?B?UTE2cStMY1cybG1RS05RbG0xMm5Zdm0yVjBtalovOXBEeDdzdytISW5YdytE?=
 =?utf-8?B?ZjFNeVlQajE5SndqUUtXeFYyaVN6dGtiaU9HNkovNFBzZFlsVjIyblB2bDc4?=
 =?utf-8?B?WUFLZGRJRW44dVAyRjRDZ3RzeDNiMS8wSldRZXBJNXhkL1VSSGlyMlFDck13?=
 =?utf-8?B?ai9GSHgvOWlnMldlYjIwbVlyQlV0UU8rY09obi93VFg1My9FNlRaTmx0Vk9l?=
 =?utf-8?B?L1BzdmczSWJQSTdmRDJhM29NQ3YyYmx5T083MzNJb0d2RG5Wa0J1c3ZLSkJ3?=
 =?utf-8?B?V29wclo0c3IxbkFVclV0MFoxRGRyMHlRRFJRMDBaVHJpMzV0T0piNjFXZVdn?=
 =?utf-8?B?RzVpTGhwS0I4ZEx5YUZteHNCYjYrTkVRR0NtcU5rcXl1UWRiSHRJRGtKRjlO?=
 =?utf-8?B?OUwzcWloOUU2MFhrWGNiWk5ya0VmeWVOV1RjeTdlSFB4U2l6Y2dsRjBjUEky?=
 =?utf-8?B?bFJWUkRaL1B2a3Y0bFgvemtUamp3Y3pMQ05zMkxEQ1NpOE1ZMlFhN0p6cFB3?=
 =?utf-8?B?Znh0blYvbUR6S204WW41M3V1NmtXdmhlVEovT0NmbHVYTzRVQTRVaDA3cjh5?=
 =?utf-8?B?dVAyajVzb3hOQmJwamJjc3VVOGlpRy9YUkpaeHJGNm1VamZDNUVsRlNjNlZi?=
 =?utf-8?B?RzNUKzB0a0xpdUJBTkdJRVVsZVNCOGQxSW80RG02VjMza0dRVWpCT1VzQm4w?=
 =?utf-8?B?SnFsNFRBWWZlZC9oc29laVFkeE54U2tETzlIME04TEhXa3EyejNtNElGNzg4?=
 =?utf-8?B?d3ZmR2FMN0hWdkdRNFQ2MjN6UHdsa3lRYmdaTFZ6Y2V0R1I1UXoybVg3WGUw?=
 =?utf-8?B?UEJoUHFJRERVSGR0NEhZa1J3c3FoMGlhWXdtTURQbkRnNHlVdUU2aURWMlFu?=
 =?utf-8?B?Vk01U1RkNTlmaHNpeFhxeHhhRWd6ejdJdW9ONURhMm8zOHZHN1gvdFdpeTk5?=
 =?utf-8?B?TWtYV1EvcUJ3YUlWMEE4VGZOUFdJeVduYklNYkhBdDhzNnhEMnhvQm91emRM?=
 =?utf-8?B?RGpycHlMY0pXTTNONkVaYzJZY25wY0c2cjQ1K2ZHYWh1bDFmQ3dlTFJBMmFQ?=
 =?utf-8?B?M1BRb0k4ekNlVWY3bUZJdFFEL3h0WGpQWCtuS3phb21naHRZcXR4ZjdBYmZu?=
 =?utf-8?B?QkVMR2tjaVQrSkpGNC9FNDNueFlRNjZ5MHdHNmFzMmNyYTRrSllHR282TW9B?=
 =?utf-8?B?a2hXVG1hMDBwdUg2MnIzYU91TGp4ekpSWERxMExEVWoxaHkrbkxhenNJdTVo?=
 =?utf-8?B?UytlMFFsM0pMcVFJRDdRaE9qbGF6bnh4RDJCSTRtWFZ2S3R6WFBjbXpKMTBU?=
 =?utf-8?B?SnE3RWNrUVB5SUpYaEEwdzhlSjkwcjdWaFI2K1d0ZDFNcHF0UWtBdVAwdEh3?=
 =?utf-8?B?VW54V3dkRURqRUc5cE1tYUNuS3I1VTJQZ1NaejdocU9rRWRuZHlLK3VPWC81?=
 =?utf-8?B?MnpXdm84L3YrTTFvaW9mR0tNR0I3OGlUdWZhT3Y0NTBMeG5oOWoxTHpWaERZ?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67F9738F8D83C5479DC14AB764DC9B00@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3434.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7d4c1e-ad1a-412a-3245-08db0c244d6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 11:37:06.0233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOF2b8Y5N9uT1gRHv8SaQt1OmkdC2Mdh8q8LVQAE0C444JWXSznI9mfBKZdvxyjQPCSB2fesYxWF5YkntKUEmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5653
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTEwIGF0IDEzOjAxICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDkvMDIvMjMgMTc6MjQsIG1hdHRoaWFzLmJnZ0BrZXJuZWwub3Jn
IGhhIHNjcml0dG86DQo+ID4gRnJvbTogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdt
YWlsLmNvbT4NCj4gPiANCj4gPiBUaGUgZnVuY3Rpb24gIHN2c19hZGRfZGV2aWNlX2xpbmsgaXMg
Y2FsbGVkIG9ubHkgaW50ZXJuYWxseSBmcm9tIHRoZSBTb0MNCj4gPiBzcGVjaWZpYyBwcm9iZSBm
dW5jdGlvbnMuIFdlIGRvbid0IG5lZWQgdG8gY2hlY2sgaWYgdGhlIG5vZGVfbmFtZSBpcw0KPiA+
IG51bGwgYmVjYXVzZSB0aGF0IHdvdWxkIG1lYW4gdGhhdCB3ZSBoYXZlIGEgYnVnZ3kgU29DIHBy
b2JlIGZ1bmN0aW9uIGluDQo+ID4gdGhlIGZpcnN0IHBsYWNlLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQo+IA0KPiBS
ZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2No
aW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQoNClJldmlld2VkLWJ5OiBSb2dlciBMdSA8cm9n
ZXIubHVAbWVkaWF0ZWsuY29tPg0K
