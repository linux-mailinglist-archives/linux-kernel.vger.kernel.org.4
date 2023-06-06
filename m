Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96950723B25
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbjFFIRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbjFFIRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:17:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77385AF;
        Tue,  6 Jun 2023 01:17:27 -0700 (PDT)
X-UUID: 90a4addc044211eeb20a276fd37b9834-20230606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7iq8M4j0pR+r4NV6h7PoZpnS9c9M31vuAF8XXKFXkP0=;
        b=rlt0jQlP4Xb5Cx0kcdzb6SNEPWPNsMcV2FVYrrnrHB9fNf5r+VMtwQqVt98hd1356kixfbUGxEGccOXVrdMJRGIDeMd8ImBXKLb8DpQaRPFZlZhgw+jYo2jKY31ryk648AW8QwUI546opog6+isyPpk0yOaYCWuKTLCxtzRIdTM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:666a6edd-696c-41e9-8361-a7bbaf6b51d4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:f4832c6e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 90a4addc044211eeb20a276fd37b9834-20230606
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 560514005; Tue, 06 Jun 2023 16:17:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Jun 2023 16:17:22 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 6 Jun 2023 16:17:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htHpqQeS8vuREQkvJXBNYRzYWS6QAfvx4Yoia3jMzgoGffpjqHR0/qN4O1nsivMjO7FI31ktRU4ZgkF4CaUZjR66PLGxLAcO1tBwgAy8JvEwe0av8Kc07ljeERiKDEA+96CW8CR12xgzfd1xTVgU2ETBt+ityUDxY0OgWZN69EzzvR4uA/Az1dQajwT22CcjTwCKrGB6zcOySceM6RW9firzfG/1l0ydQrywBpRg2aCoxhw5SsBjh+3JWLXopw+7HaXGkPFJYlX0r+6k9JqzIqldBFoqF5y6mt77CvaBObDh3UaiE7tRTR8e5g5WYjle+etYeq8GExEbiU0LJEivEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iq8M4j0pR+r4NV6h7PoZpnS9c9M31vuAF8XXKFXkP0=;
 b=i61KBmuMJWuArJxldSlK0TTCjbZiO09klfVVF2k7HV0NqCzc8oxYdEWnF3rGCaBimXlXlVmeuuFlFv63D+Au0OyCR2/qySSEH/BB6vlK+IW+nwikDhDGRSsVS4MX45aUcaJn4B825OtMjcBk/nMo3wy7z4hchAiu7jcrk0kz5yyTtKh+Bx4kW3iC2YH7XETegEICaJ3dTm0iAOTzSDuX4G1gsrXGuq2qLuKWN2aT4RTw15oBJRzBbZUSgN0eCp5eN76dTjQheI9Vlz4YPKcbymlgVPMgsz1UFk4sOJYXXN+NtjwbqUUKwsYf0zNi6XR7C/qz3A5jUmwZ6f8uXyp/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iq8M4j0pR+r4NV6h7PoZpnS9c9M31vuAF8XXKFXkP0=;
 b=F0p6remIB4YdLIvYdKMToYknGXXxQPHy7zZalcm+tuKvmzAjy1lnSXqs3Thzzo4I1pw5Qn6x5pGhoHUAKxON1IQnnCCgz04xT6dKe1DFddbeW9TgZoMDihpNb8w0rPEdH/IMBQWoZMQqxXTxPR65Dlc1pSqfr51VwBUiHyiAqEM=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by SI2PR03MB5225.apcprd03.prod.outlook.com (2603:1096:4:10c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 08:17:20 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147%9]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 08:17:20 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH v3] mmc: mtk-sd: reduce CIT for better performance
Thread-Topic: [PATCH v3] mmc: mtk-sd: reduce CIT for better performance
Thread-Index: AQHZl3MhuZQwxAGKvU2Q3XN2G99nQK975gIAgAGJtQA=
Date:   Tue, 6 Jun 2023 08:17:20 +0000
Message-ID: <0de574510def6fa736a6dceaf8423ee80561642e.camel@mediatek.com>
References: <20230605060107.22044-1-wenbin.mei@mediatek.com>
         <47ee4c8b-dedf-d69a-dceb-dcaa34ddd0e1@collabora.com>
In-Reply-To: <47ee4c8b-dedf-d69a-dceb-dcaa34ddd0e1@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|SI2PR03MB5225:EE_
x-ms-office365-filtering-correlation-id: 5b83e0fe-45b6-42b7-107d-08db666672bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HfQRoVpvoUFRNxovG3Moz8nHbic33okXGsUnbCwxAgGZ9p37/EbFj9bsweQc3kF4ZbjQ+kbN6BK0iy+IR+M+ehTfsYRiKYbuwAnme4KYFFm0AIAV1IW2rJTs2eAQZSD6rLhLAQzWvIwM/pMss5+o7v/FPbshkODbHhe+7x+v4PSI2wCZELcX+Fdrgmj/KVndQh9s3dZOS89ZstuYseSHvhsG+h5EQvo1ArFFdYEgBUKXmJkG+dDrZZqhId5p1emySN0OeE631Dkb69Ni3AYBUS9f98tdFClSYToXFLvVyTjNMSQmCKFrWQJpSEPFburFWqXH4xHaH6LldEfCIPLdsHiMo7I8WXuO6VRQB5WskqRtSy0KdcigXMTOoaflT61yEsBEpY/X+eeDUE1Y7oqC8EE7mUoBF61oucJJyQ+2a8V4lPkm8jN3vWs0txoCqqCv/4P8zscT1a/9/e27BAZdHSgVnZmZrtYRFkPQenDSu21u4qTWbetEDw6MhjvpV9tWSjSG2TNzud8n27wjSINwZwhc1VO3RKb+rR5yCodEDfyu4QQ7HBkp2VgSUueMLifG9Ir4ND09uvBwBKtjd1ZTaqV3YgiaRqE57Ja1iFlF7KnSZ2mp/q3symDzcBTFqTRu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(6512007)(2616005)(26005)(66446008)(66946007)(6506007)(83380400001)(4326008)(66556008)(122000001)(66476007)(76116006)(64756008)(6486002)(186003)(316002)(38070700005)(71200400001)(478600001)(85182001)(54906003)(36756003)(110136005)(2906002)(5660300002)(8936002)(8676002)(86362001)(41300700001)(7416002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1BPc1ZLcDQzMnhjQjhzbnJmajF4K0tLN1RFR3h4VkllTFMzQ25aRkVCbDVI?=
 =?utf-8?B?Z2NIR3ZmWUNpdUx1REFMYjNxTG9STEs1MHNoZ1oxbFAyK0hHaUZ5bkdDOUQw?=
 =?utf-8?B?UTBGRDh3ejdVQnRDNnpPYStIRkxkVHV5cGtEQWNRWVM1YWJla3BrdUZTSnI5?=
 =?utf-8?B?WVJSbnhGZXRKako4TlBudWxMTWxVNzlqeGN2cFFMNVVPa2cvR3V5L0tPVDAw?=
 =?utf-8?B?N0VDekh6OE9UYjFXSzdCM0JnOFhmUVBJY1lWYTNYdmxqbFU5TkZEYWlZMWxt?=
 =?utf-8?B?Y3JzZzVIS1dYcVRONjBhNXJHOVRzVVVyeGFMVjN4SzMzYThNd0ovb29DbEJk?=
 =?utf-8?B?ZDJOd1ZvYWJBN1Mxc1cvL0JXcXFITnl3OTN1R0g0NmRWcDJodlRIRmZYckJX?=
 =?utf-8?B?Vng4S0NnbC9tSVRjbmxFd3pXTmJnZi9UdkFiMFltMUdiVTlhU2JQRjNyZGZG?=
 =?utf-8?B?clU1MUhhVEtnMVAxd21QVU9DRnNFSXJCdm9VQ2ZqdXJqSk1hdFN2dk93ajFH?=
 =?utf-8?B?SWpkMGN6SWlzeUFGN2NZZ1lOM3dXbGpRaXZuTUFtSllGMnVXWnpjY2RKTmJB?=
 =?utf-8?B?QUxQMXpZNk53aDQ4WXgrL3BlMFFmdXdkcUpTQXdZTFhlZWVNbUlQVXB2K2Yr?=
 =?utf-8?B?cjd2MUlEcGxQOFIrZHBNT3Jsb0ZyakY1Wmd5UkkzMktMcTg1cENyUzNWUFpQ?=
 =?utf-8?B?b3g4N2lhUTFudi9tWHRoajBBejFjS25JekxaMlhVNHVleTBkQ0dDd2ZLSXZY?=
 =?utf-8?B?ekwvNDJCdzJDa1JEUDBuQlFDdWJBVkRBN1g0alk4dmdzMU50ekk5dVh3eExE?=
 =?utf-8?B?eThmWVVTN2lzT2tPdmhtczZGbnZKSGpEZkxZZG5wTDNpSzE1dzZ4RmdlSXRv?=
 =?utf-8?B?a2ZiclhaK0R1Y1Q0dE1LRXUrdllJNHBFbElZbFVhYUY0b2ZVUDRHMnVweTM4?=
 =?utf-8?B?ZG5BUTUwSmovankyRmUvWm9PQXVjMFRlZExBc3h5cUtOWjhRcnlDSnkzeE1r?=
 =?utf-8?B?RnlYOC9XNnRRQUZraW40UUlLN1MrNExkQnJMOXJHZ1lySWNHQnBDTDZDWjJJ?=
 =?utf-8?B?WXYvdTFYT2M1eFVYVzBjc0VnSW5zQkdoeWtJVDJOY1gyUDl6WVljNWt1RzA5?=
 =?utf-8?B?ZFN5bzgxY3I2Vlg3V1Q3dnZBSjl3UFBYKzQ5RW1SdFVEbXkya2kyR3FYU2s0?=
 =?utf-8?B?YUFsRHhPUTY1ZG5aSm5BODZ0NkprdDdibzNTM0tDYkY3RlA1dkNobUV3Ymtr?=
 =?utf-8?B?cER2cnRXTm9OYjRoWjdzNk1USzhibksraUtsNExtOUZydTU5d0ZmeElaaVlv?=
 =?utf-8?B?RnJsSklVZEFLNHFUZzk1Rlg5RytUUUFleXRobkVjcUtiS1ZPb2ZCMzlvcVRL?=
 =?utf-8?B?ak1pTE1VNi9Ta1pIZTAxc1VITnI2TVJ3b0dPY21MWGNLWWpJQ2ZTaUM4VnJZ?=
 =?utf-8?B?d0ozcjRVWWJjL0FlTUpMV0JjN0hGMXVqa2hxb255MkpjNjYvakhqL214SDdE?=
 =?utf-8?B?bmpRRHJiNXNieXg5RzNCaXVjUFduWFdFZVV3bWJZZGo1L3o4R0x6bXRhWlNH?=
 =?utf-8?B?TGx4RVdWQnpmVEZCaVlRWktDL01MZ2dtaXVqclYwWUNhV3FwTXFkeE5wT1hm?=
 =?utf-8?B?YjAzTUlrWW1ZR0NCd0tUK21aeG5EYUwwcXRXZGUyc3hsd21mQWNHSzF2aGdr?=
 =?utf-8?B?SitDRVJURFpUa3d5eS9FQ1R3d0hvVG1IcENTci9Ccy90ellIT0gvbXZwSk9C?=
 =?utf-8?B?Q0FLQkRPZHdmNXRWdFRGUVVONGlQVE9jNUplbitPOTM0OVJEV0FhRVZ4KzZ0?=
 =?utf-8?B?ZXgxZWhoUlZld25kVHJLNHJVakRIL2JpaXJ1dkIvN3hlWFp0S0pZYk5BK1g2?=
 =?utf-8?B?U2JLU3FUYmRPRTVnN0R5TUxVK21qVFQ5V3hjUGtLakZuSXhtUXJEOXV5ZmNj?=
 =?utf-8?B?VnZid2JhNm1GOHNMUGtOYUZJUDdSeTVlQXl4K1lKa1BLLy9qZ0tRZE9lUS9E?=
 =?utf-8?B?Z1VDMHh5eERIZnVnVDFKcTM5eVFpQVMreTFLdnJDWnJaV3Q0bS9jZUtMenRw?=
 =?utf-8?B?S1ZKQzdtUTNkNzB6d0c5TEtBTmhvcEZrdms0WjdMeFo0T2xFbStPZVgyWUE4?=
 =?utf-8?B?bS9vR2VseDk4OTNjZVg1WFpqN1BwQjlpdmVGODNUby94UGRPMVJ6VC9vR25Q?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FF595EBC0922B45B1C0878052395DE1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b83e0fe-45b6-42b7-107d-08db666672bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 08:17:20.0319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SaX6cFZDSp4Z+MKtRHzxtMwWbnKlI/8AEUag1dqGqrt0hSAw/HcO7KmRbbz6c4eV0RhIPYT9/IId7me2Ab4DzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5225
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTA1IGF0IDEwOjQ4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAwNS8wNi8yMyAwODowMSwgV2VuYmluIE1l
aSBoYSBzY3JpdHRvOg0KPiA+IENRSENJX1NTQzEgaW5kaWNhdGVzIHRvIENRRSB0aGUgcG9sbGlu
ZyBwZXJpb2QgdG8gdXNlIHdoZW4gdXNpbmcNCj4gcGVyaW9kaWMNCj4gPiBTRU5EX1FVRVVFX1NU
QVRVUyhDTUQxMykgcG9sbGluZy4NCj4gPiBTaW5jZSBNU0RDIENRRSB1c2VzIG1zZGNfaGNsayBh
cyBJVENGVkFMLCBzbyBkcml2ZXIgc2hvdWxkIHVzZSBoY2xrDQo+ID4gZnJlcXVlbmN5IHRvIGdl
dCB0aGUgYWN0dWFsIHRpbWUuDQo+ID4gVGhlIGRlZmF1bHQgdmFsdWUgMHgxMDAwIHRoYXQgY29y
cmVzcG9uZHMgdG8gMTUwdXMgZm9yIE1lZGlhVGVrDQo+IFNvQ3MsIGxldCdzDQo+ID4gZGVjcmVh
c2UgaXQgdG8gMHg0MCB0aGF0IGNvcnJlc3BvbmRzIHRvIDIuMzV1cywgd2hpY2ggY2FuIGltcHJv
dmUNCj4gdGhlDQo+ID4gcGVyZm9ybWFuY2Ugb2Ygc29tZSBlTU1DIGRldmljZXMuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogV2VuYmluIE1laSA8d2VuYmluLm1laUBtZWRpYXRlay5jb20+DQo+
IA0KPiBPSyEgVGhhdCdzIGFsbW9zdCBnb29kIG5vdy4gVGhlcmUncyBvbmx5IG9uZSBjb25zaWRl
cmF0aW9uIGhlcmU6IGlmDQo+IE1lZGlhVGVrDQo+IFNvQ3MgKnJlcXVpcmUqIG1zZGNfaGNsayB0
byBjYWxjdWxhdGUgdGhlIENJVCB0aW1lLCB0aGlzIG1lYW5zIHRoYXQNCj4gdGhpcyBjbG9jaw0K
PiBpcyBjcml0aWNhbCBmb3IgQ1FIQ0kgZnVuY3Rpb25hbGl0eS4NCj4gDQo+IElmIG1zZGNfaGNs
ayBpcyBub3QgcHJlc2VudCwgQ1FIQ0kgY2Fubm90IHdvcmsgY29ycmVjdGx5Li4uIHNvIHlvdQ0K
PiBkb24ndCBoYXZlDQo+IHRvIGNvdmVyIHRoZSBjYXNlIGluIHdoaWNoIHRoZXJlJ3Mgbm8gbXNk
Y19oY2xrIGNsb2NrOiBpZiB0aGF0J3Mgbm90DQo+IHByZXNlbnQsDQo+IGVpdGhlciBmYWlsIHBy
b2JpbmcsIG9yIGRpc2FibGUgQ1FIQ0kuDQo+IA0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9tbWMv
aG9zdC9jcWhjaS5oICB8ICAxICsNCj4gPiAgIGRyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgfCA0
Nw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDIgZmls
ZXMgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21tYy9ob3N0L2NxaGNpLmggYi9kcml2ZXJzL21tYy9ob3N0L2NxaGNpLmgNCj4gPiBpbmRl
eCBiYTkzODdlZDkwZWIuLjI5MmI4OWViZDk3OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21t
Yy9ob3N0L2NxaGNpLmgNCj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L2NxaGNpLmgNCj4gPiBA
QCAtMjMsNiArMjMsNyBAQA0KPiA+ICAgLyogY2FwYWJpbGl0aWVzICovDQo+ID4gICAjZGVmaW5l
IENRSENJX0NBUDB4MDQNCj4gPiAgICNkZWZpbmUgQ1FIQ0lfQ0FQX0NTMHgxMDAwMDAwMCAvKiBD
cnlwdG8gU3VwcG9ydCAqLw0KPiA+ICsjZGVmaW5lIENRSENJX0NBUF9JVENGTVVMKHgpKCgoeCkg
JiBHRU5NQVNLKDE1LCAxMikpID4+IDEyKQ0KPiA+ICAgDQo+ID4gICAvKiBjb25maWd1cmF0aW9u
ICovDQo+ID4gICAjZGVmaW5lIENRSENJX0NGRzB4MDgNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvaG9zdC9tdGstc2QuYyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gPiBpbmRl
eCBlZGFkZTBlNTRhMGMuLmMyMjFlZjhhNjk5MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21t
Yy9ob3N0L210ay1zZC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+
IEBAIC00NzMsNiArNDczLDcgQEAgc3RydWN0IG1zZGNfaG9zdCB7DQo+ID4gICBzdHJ1Y3QgbXNk
Y190dW5lX3BhcmEgZGVmX3R1bmVfcGFyYTsgLyogZGVmYXVsdCB0dW5lIHNldHRpbmcgKi8NCj4g
PiAgIHN0cnVjdCBtc2RjX3R1bmVfcGFyYSBzYXZlZF90dW5lX3BhcmE7IC8qIHR1bmUgcmVzdWx0
IG9mDQo+IENNRDIxL0NNRDE5ICovDQo+ID4gICBzdHJ1Y3QgY3FoY2lfaG9zdCAqY3FfaG9zdDsN
Cj4gPiArdTMyIGNxX3NzYzFfdGltZTsNCj4gPiAgIH07DQo+ID4gICANCj4gPiAgIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgbXRrX21tY19jb21wYXRpYmxlIG10MjcwMV9jb21wYXQgPSB7DQo+ID4gQEAg
LTI0NTAsOSArMjQ1MSw1MCBAQCBzdGF0aWMgdm9pZA0KPiBtc2RjX2hzNDAwX2VuaGFuY2VkX3N0
cm9iZShzdHJ1Y3QgbW1jX2hvc3QgKm1tYywNCj4gPiAgIH0NCj4gPiAgIH0NCj4gPiAgIA0KPiA+
ICtzdGF0aWMgdm9pZCBtc2RjX2NxZV9jaXRfY2FsKHN0cnVjdCBtc2RjX2hvc3QgKmhvc3QsIHU2
NCB0aW1lcl9ucykNCj4gDQo+IHN0YXRpYyBpbnQgbXNkY19jcWVfY2l0X2NhbCguLi4uKQ0KPiAN
ClNvcnJ5LCBJIG1pc3NlZCB0aGlzIGNvbW1lbnQuDQpJIHRoaW5rIHRoZXJlIGlzIG5vIG5lZWQg
dG8gcmV0dXJuIGEgdmFsdWUuDQpCZWN1YXNlIG1zZGNfaGNsayBpcyBleGlzdCwgYW5kIGlmIG5v
dCBwcmVzZW50LCBpdCB3aWxsIHJldHVybiBlYXJpbHkuDQpFdmVuIGlmIGl0IGdvZXMgdG8gdGhl
IGRlZmF1bHQgY2FzZSBpbiB0aGUgc3dpdGNoIGZsb3csIHdlIHdpbGwgYXNzaWduDQphIGRlZmF1
bHQgdmFsdWUuDQpTbyBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIHJldHVybiBudWxsLCBkbyB5b3Ug
dGhpbmsgaXQgaXMgb2theT8NCg0KPiA+ICt7DQo+ID4gK3N0cnVjdCBtbWNfaG9zdCAqbW1jID0g
bW1jX2Zyb21fcHJpdihob3N0KTsNCj4gPiArc3RydWN0IGNxaGNpX2hvc3QgKmNxX2hvc3QgPSBt
bWMtPmNxZV9wcml2YXRlOw0KPiA+ICt1OCBpdGNmbXVsOw0KPiA+ICt1MzIgaGNsa19mcmVxOw0K
PiANCj4gaGNsa19mcmVxIHNob3VsZCBiZSBgdW5zaWduZWQgbG9uZ2AsIGFzIHRoYXQncyB3aGF0
IGNsa19nZXRfcmF0ZSgpDQo+IHJldHVybnMuDQo+IA0KSSB3aWxsIGNoYW5nZSBpdCBpbiB0aGUg
djUgdmVyc2lvbi4NCg0KPiA+ICt1NjQgdmFsdWU7DQo+ID4gKw0KPiA+ICsvKiBTaW5jZSBNU0RD
IENRRSB1c2VzIG1zZGNfaGNsayBhcyBJVENGVkFMLCBzbyBkcml2ZXIgc2hvdWxkIHVzZQ0KPiBo
Y2xrDQo+ID4gKyAqIGZyZXF1ZW5jeSB0byBnZXQgdGhlIGFjdHVhbCB0aW1lIGZvciBDSVQuDQo+
ID4gKyAqLw0KPiANCj4gLyoNCj4gICogT24gTWVkaWFUZWsgU29DcyB0aGUgTVNEQyBjb250cm9s
bGVyJ3MgQ1FFIHVzZXMgbXNkY19oY2xrIGFzDQo+IElUQ0ZWQUwNCj4gICogc28gd2UgbXVsdGlw
bHkvZGl2aWRlIHRoZSBIQ0xLIGZyZXF1ZW5jeSBieSBJVENGTVVMIHRvIGNhbGN1bGF0ZQ0KPiB0
aGUNCj4gICogU2VuZCBTdGF0dXMgQ29tbWFuZCBJZGxlIFRpbWVyIChDSVQpIHZhbHVlLg0KPiAg
Ki8NCkkgd2lsbCBjaGFuZ2UgaXQgaW4gdGhlIHY1IHZlcnNpb24uDQo+IGlmICghaG9zdC0+aF9j
bGspDQo+IHJldHVybiAtRUlOVkFMOw0KPiANClRoaXMgY2hhbmdlIHNob3VsZCBiZSB1bm5lY2Vz
c2FyeSwgYmVjYXVzZSBpdCBoYXMgYmVlbiBjaGVja2VkIGluDQptc2RjX2Rydl9wcm9iZSgpIGZ1
bmN0aW9uLg0KPiBoY2xrX2ZyZXEgPSBjbGtfZ2V0X3JhdGUoaG9zdC0+aF9jbGspOw0KPiBpdGNm
bXVsID0gQ1FIQ0lfQ0FQX0lURkNNVUwoY3FoY2lfcmVhZGwoY3FfaG9zdCwgQ1FIQ0lfQ0FQKSk7
DQo+IHN3aXRjaCAoaXRjZm11bCkgew0KPiAuLi4uDQo+IH0NCj4gDQo+ID4gK2lmIChob3N0LT5o
X2Nsaykgew0KPiA+ICtoY2xrX2ZyZXEgPSBjbGtfZ2V0X3JhdGUoaG9zdC0+aF9jbGspOw0KPiA+
ICtpdGNmbXVsID0gQ1FIQ0lfQ0FQX0lUQ0ZNVUwoY3FoY2lfcmVhZGwoY3FfaG9zdCwgQ1FIQ0lf
Q0FQKSk7DQo+ID4gK3N3aXRjaCAoaXRjZm11bCkgew0KPiA+ICtjYXNlIDB4MDoNCj4gPiArZG9f
ZGl2KGhjbGtfZnJlcSwgMTAwMCk7DQo+ID4gK2JyZWFrOw0KPiA+ICtjYXNlIDB4MToNCj4gPiAr
ZG9fZGl2KGhjbGtfZnJlcSwgMTAwKTsNCj4gPiArYnJlYWs7DQo+ID4gK2Nhc2UgMHgyOg0KPiA+
ICtkb19kaXYoaGNsa19mcmVxLCAxMCk7DQo+ID4gK2JyZWFrOw0KPiA+ICtjYXNlIDB4MzoNCj4g
PiArYnJlYWs7DQo+ID4gK2Nhc2UgMHg0Og0KPiA+ICtoY2xrX2ZyZXEgPSBoY2xrX2ZyZXEgKiAx
MDsNCj4gPiArYnJlYWs7DQo+ID4gK2RlZmF1bHQ6DQo+ID4gK2hvc3QtPmNxX3NzYzFfdGltZSA9
IDB4NDA7DQo+ID4gK3JldHVybjsNCj4gPiArdmFsdWUgPSBoY2xrX2ZyZXEgKiB0aW1lcl9uczsN
Cj4gPiArZG9fZGl2KHZhbHVlLCAxMDAwMDAwMDAwVUxMKTsNCj4gPiAraG9zdC0+Y3Ffc3NjMV90
aW1lID0gdmFsdWU7DQo+ID4gK30gZWxzZSB7DQo+ID4gK2hvc3QtPmNxX3NzYzFfdGltZSA9IDB4
NDA7DQo+ID4gK30NCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyB2b2lkIG1zZGNfY3FlX2Vu
YWJsZShzdHJ1Y3QgbW1jX2hvc3QgKm1tYykNCj4gPiAgIHsNCj4gPiAgIHN0cnVjdCBtc2RjX2hv
c3QgKmhvc3QgPSBtbWNfcHJpdihtbWMpOw0KPiA+ICtzdHJ1Y3QgY3FoY2lfaG9zdCAqY3FfaG9z
dCA9IG1tYy0+Y3FlX3ByaXZhdGU7DQo+ID4gICANCj4gPiAgIC8qIGVuYWJsZSBjbWRxIGlycSAq
Lw0KPiA+ICAgd3JpdGVsKE1TRENfSU5UX0NNRFEsIGhvc3QtPmJhc2UgKyBNU0RDX0lOVEVOKTsN
Cj4gPiBAQCAtMjQ2Miw2ICsyNTA0LDkgQEAgc3RhdGljIHZvaWQgbXNkY19jcWVfZW5hYmxlKHN0
cnVjdCBtbWNfaG9zdA0KPiAqbW1jKQ0KPiA+ICAgbXNkY19zZXRfYnVzeV90aW1lb3V0KGhvc3Qs
IDIwICogMTAwMDAwMDAwMFVMTCwgMCk7DQo+ID4gICAvKiBkZWZhdWx0IHJlYWQgZGF0YSB0aW1l
b3V0IDFzICovDQo+ID4gICBtc2RjX3NldF90aW1lb3V0KGhvc3QsIDEwMDAwMDAwMDBVTEwsIDAp
Ow0KPiA+ICsNCj4gPiArLyogU2V0IHRoZSBzZW5kIHN0YXR1cyBjb21tYW5kIGlkbGUgdGltZXIg
Ki8NCj4gPiArY3FoY2lfd3JpdGVsKGNxX2hvc3QsIGhvc3QtPmNxX3NzYzFfdGltZSwgQ1FIQ0lf
U1NDMSk7DQo+ID4gICB9DQo+ID4gICANCj4gPiAgIHN0YXRpYyB2b2lkIG1zZGNfY3FlX2Rpc2Fi
bGUoc3RydWN0IG1tY19ob3N0ICptbWMsIGJvb2wgcmVjb3ZlcnkpDQo+ID4gQEAgLTI4MDMsNiAr
Mjg0OCw4IEBAIHN0YXRpYyBpbnQgbXNkY19kcnZfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gPiAgIC8qIGNxaGNpIDE2Yml0IGxlbmd0aCAqLw0KPiA+ICAgLyogMCBz
aXplLCBtZWFucyA2NTUzNiBzbyB3ZSBkb24ndCBoYXZlIHRvIC0xIGhlcmUgKi8NCj4gPiAgIG1t
Yy0+bWF4X3NlZ19zaXplID0gNjQgKiAxMDI0Ow0KPiA+ICsvKiBSZWR1Y2UgQ0lUIHRvIDB4NDAg
dGhhdCBjb3JyZXNwb25kcyB0byAyLjM1dXMgKi8NCj4gPiArbXNkY19jcWVfY2l0X2NhbChob3N0
LCAyMzUwKTsNCj4gDQo+IHJldCA9IG1zZGNfY3FlX2NpdF9jYWwoLi4uKQ0KPiBpZiAocmV0KQ0K
PiBnb3RvIHJlbGVhc2U7DQo+IA0KPiBeXl5eIGVpdGhlciBmYWlsIHByb2JlLCBvciB1c2UgdGhl
IGVNTUMvU0Qgd2l0aG91dCBDUUhDSSBzdXBwb3J0Lg0KPiANClRoZXJlIGlzIG5vIG5lZWQgdG8g
cmV0dXJuIGEgdmFsdWUsIHNvIHRoZXJlIHdpbGwgYmUgbm8gY2hlY2sgaGVyZS4NCj4gUmVnYXJk
cywNCj4gQW5nZWxvDQo+IA0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gICByZXQgPSBkZXZtX3JlcXVl
c3RfaXJxKCZwZGV2LT5kZXYsIGhvc3QtPmlycSwgbXNkY19pcnEsDQo+IA0K
