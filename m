Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73C4631B66
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiKUI3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiKUI3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:29:11 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353D01C423;
        Mon, 21 Nov 2022 00:29:03 -0800 (PST)
X-UUID: 199793f35ca449f3a12dcb7553c50701-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kY9k0gB6+Zd0LQCjt1TM75VU1LL9hFg7h7yyLrATbj0=;
        b=Fo0xrh1SxnHzd51RxAvjfQbjEFG6FTbwp4OQaUwaKoagjl5k3K7edqErT/0Sl4/c9qaVC3HrYnP/8P6GLS7XJiEFAn1gFt16X1lVUZAtUtYzWSQkwbElHKMjLWsvGTe4qF9tlpSm3UAYvxrza4zlGK2QoD58qUb4NVu7NwpDgjA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:dfaffc37-c204-42b5-b5c8-52bf2ff059d2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:c9215c2f-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 199793f35ca449f3a12dcb7553c50701-20221121
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <bayi.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 796241796; Mon, 21 Nov 2022 16:28:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 21 Nov 2022 16:28:55 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 21 Nov 2022 16:28:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nux3lWqe0Kwzjp4kcNZHjDAbS8jekwu69zihKLzqPErQPEKRHwbAjh5xFoX6NNKJHG0iaGph5Z0gDLwLPg7ayQdp7BW60iilepaDVUxfle2S7YC6AL5gR0Rkf0ULVQa5b8shetzgyEIXH/9lH9n2lGdwL0VBEZm9SstXOH0KdNTxk20gM6JmG4IiQrXCg1JHpwR/trlGR/Fwl+AHFBAQqbSO/GmRq8Zkp4DJ42rznk9/nCnHhJqmzKMS9i7vKwpq2bDPsreiGegT/vpkfwj58dhftROZhlzNT0JrmrBvPOGJudpDzw5KyCv2Kaiz7ku9kUQjhYHRipYLGrc53rP7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY9k0gB6+Zd0LQCjt1TM75VU1LL9hFg7h7yyLrATbj0=;
 b=Swe89uGMG+2CiyXWnBm/H7K6dmmZCsLTLfRrryZ/BI6h53Uwr1fSawZuCT1DZqZl2VZzT6zlubk9hz88k/LnZt/rLRTaQbK28iLnr+BP2cbEtMsFn1P7omwg11pgtjjt4nLLZEr6QgVASjsspt+GOW8C/gFv7Li2/AJ3BflivfN1vVcIAW4AuCS7OOYsbPDyC/v2bFpjxpPK9GpCgNPb73sWLuDMvRDdMCUJFkbsyfv7Uz/6ubK/Fcu1hUltnyBHSC661mZOWBhEe8F4OUg7SAHG8pf7LxN0vvrWi+69ozEq3uNmcj4kQKW/AbpYOWLPCm188zBnvi5vIIchegAAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY9k0gB6+Zd0LQCjt1TM75VU1LL9hFg7h7yyLrATbj0=;
 b=e3qT0OCUZryZ0jf+4cXrKwPchxFygpRp6IQPUjDBsJxhKqmvdT85Rom8McfXSxc/DpLfBRSckTrRSkHOcfRzUcMQMGjjDgGS96+jmDRgnSXL+/ZKn2T9624oggNFUWwqUNaxcHCQm76Z+Cl4PAs13YpOt69U6KzyhuWFnUVi3bo=
Received: from PS1PR03MB4747.apcprd03.prod.outlook.com (2603:1096:300:86::18)
 by KL1PR03MB6199.apcprd03.prod.outlook.com (2603:1096:820:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 08:28:53 +0000
Received: from PS1PR03MB4747.apcprd03.prod.outlook.com
 ([fe80::3632:e0db:581c:36ad]) by PS1PR03MB4747.apcprd03.prod.outlook.com
 ([fe80::3632:e0db:581c:36ad%3]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 08:28:53 +0000
From:   =?utf-8?B?QmF5aSBDaGVuZyAo56iL5YWr5oSPKQ==?= 
        <bayi.cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "ikjn@chromium.org" <ikjn@chromium.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1] spi: spi-mtk-nor: Unify write buffer on/off
Thread-Topic: [PATCH v1] spi: spi-mtk-nor: Unify write buffer on/off
Thread-Index: AQHY+PBbNWGPbs5KTEmHTq/VeziXfK5JFLEA
Date:   Mon, 21 Nov 2022 08:28:53 +0000
Message-ID: <55717252d640f942a1e41d8b04c828e7fb0f57f4.camel@mediatek.com>
References: <20221115124655.10124-1-bayi.cheng@mediatek.com>
In-Reply-To: <20221115124655.10124-1-bayi.cheng@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB4747:EE_|KL1PR03MB6199:EE_
x-ms-office365-filtering-correlation-id: 92d12c19-5949-472c-3a92-08dacb9a6c7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LiAXsJthXHmEawQh77vbRcWjSmXiOOkmz1MtTv+gxhm/g1G2MKE1VcJ5HasEojSMuANu7LOoynLql0fRysmx3nNmXxy3iDpDM4cB9L6k9Uurl2pujLF3mteh3Jew5yaQNvFf2PgczxOWWlMxm5/wSlj1iWjqiQHbvERwghfOBcPstMa8yTCmAjHw3GB3kQHdezqCgHcEkvKV+41oc90pMMQbtAPlpMlloZ20FLgpnXGmmFWHS7Og1AnBF4PvWBeSRn6drheGIu0B0QkmBBX7ms4CZpu4O6Fi7ux4c4YmgcjIewChuPjsp44nTx/7pBNdx+ZVfseqhwaIfhque7LL9bHOm3h1k/sVEAKSncS8ET8oGHqeBoqs9/efEXFqGoIBJjpedo+BEXvUOE/OahGBCipe8AFma4SL8nMw/A1Ws2WLNPkQ8GI/Ej+IolUuUXAK+K7e63PiJkP+/0MG5rH/TGO5rEbAGFOOocnXpQT/UHnvnWxP083plpR8dnz8PyZO7V9ZG6/G3ASgWzz977F8OZHmSuq0jnIqxAf/P+nC/CZkEreGgLpPeai5ZuZAqcqzc649pzMYh9vWOKcbqkfkP+wm536eihb+6AxwyHkrGx0AfWechpVjKeYRkKZQ8tLLQb6ShK+xzdUNg7knQk7iK1G8X6hPER5m503+V2jyaKOZ6DYr65TTQrCMG6DIdiVsTFUI+CLAxEUBSC19wQDD8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB4747.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(41300700001)(76116006)(8936002)(4001150100001)(316002)(54906003)(66446008)(66946007)(5660300002)(64756008)(66556008)(8676002)(66476007)(4326008)(91956017)(478600001)(36756003)(86362001)(71200400001)(6506007)(83380400001)(38070700005)(26005)(6486002)(110136005)(2906002)(85182001)(186003)(2616005)(122000001)(107886003)(38100700002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0QwbkNrS3ZLaWMzSWZ0RHM3ZWNReXBSVWd3RTdiekYyOExZTDZnYmZ5QTlW?=
 =?utf-8?B?MnB1Nll5TXM4Vkpnd3ZnNmNpcTRSQng2QnJmUVRLcFhMbVRTc1ovMFdQZzVI?=
 =?utf-8?B?RDZqNUFKbThzbWpTc0xsOUE3Q3RTSDgzWGdqWjVFZGl6clArRGVHS0I4ZzBQ?=
 =?utf-8?B?N01uYitvcWFLRzBPekZxejdla1UrMGFJUitiSkNqdnRQcElkS2RzR2dHYlhh?=
 =?utf-8?B?TEI0RmNPZ1Rnd043WU52TjQ2TmhqMXRoNXRKYXZVUVZma2NmSm5zZVFIdHlj?=
 =?utf-8?B?Z1BydVg4Rk0rUFlDR1JtaWZReTdxSTZYM3ZxQm8rcnByMXNTdGFGOVZ3aEdp?=
 =?utf-8?B?QnJpZXBjaFRhbzlJdGVLYTlXL1B0Q3V6ckJEQXZBQUtQSkovVUNJZzlqWjlo?=
 =?utf-8?B?c3lROVExWE9mZWNuYVRlTVRjZndqYk5SVzdUSlg4c2U2VWhzZDFwK2pNaURu?=
 =?utf-8?B?c1dWWUlUbkpSL1dnMDhVOUZvWUlHOEtCOXZRbmFOQU5wYVRRN05uQy9xV2dl?=
 =?utf-8?B?SEhtY3R4NjVNYTVZdkwzbXBZNkQzQTRqcE82WUZoRWVvTGVIQTltcWtiVDBm?=
 =?utf-8?B?MTBBQjF2eXpTUjduRzRiUmtqMUd3azczNWJLeDhEOTZqZG1DaCtPN3Y5Mmlm?=
 =?utf-8?B?NS9iWmxIeHNGalNaODNmSThNd1JqdExBcHN5T2ovdkZGbE5icG9YeXY3dVhY?=
 =?utf-8?B?b2lyY08xb2x1U1lQR1JUUnRRdkQyVVdlZDBndFZUdjZqakZtaDRoRE5hU2hZ?=
 =?utf-8?B?S1JzZlNmdXpLVzFVNnVLenJId0dKVEpnMTRySFVpcDZZOXdObVl6UTRDak1N?=
 =?utf-8?B?a2hjVlUzdnFQVWFaaVhxZGpwOEdCOWFNVnd3YlFhc1hraVdGUGtsWEtlanRS?=
 =?utf-8?B?dmluQlVGZC9XMW90WUFNUlJ6RFV0OElScVJIUnNlVkUxUlZFdDlxRnFpUFps?=
 =?utf-8?B?Sm1USVFJbmwrM1c2WUdxeURFNFBiOFNFeXN2bE9BNTY4VXZJcEtFeTVobmhy?=
 =?utf-8?B?NzEzcjdtMUxDMDN4dmQ3VHhQbVdlQjNGVkZRVXJqSDJVUUJFM2JqcnE0bWFO?=
 =?utf-8?B?YWptcTNKMzlxNkIyUE1XeE8rM1JIQVYvd3RQczV6TXpyS3VVZ2ppWms5cDVP?=
 =?utf-8?B?QXdaMGt6VDBnSFJlbHM5T1ovVys0MU56K0tINkdGTTkxWnBYVkxUMmk1WDBw?=
 =?utf-8?B?VTF5Tlg5QlBaeThmenBmVXFSNjE0YWx2S240R2l1eGh6V3hYK2Jqcm1lZGlt?=
 =?utf-8?B?a0NQenFyY3FnaXh2WXE2Wnpsbnd1M0ptSFA4M25YOHVGak9lRmUvQVpzK3N3?=
 =?utf-8?B?dk01T0N3dEhpK3dodm9ma2ErcmF4SmNGeEQ2dk5sREZNM242SmdqbzlmK3lR?=
 =?utf-8?B?clhzd0dIZG02UVdHelRXMTdMaXljbnpmdytYMkorZW5YSFlOWi8rOHJISUdT?=
 =?utf-8?B?UC9DbWJ6S3pDUHZQYTVCOVZWVUVmNEE3N3pGbkI4TkFLUkdPSWxIVXdwNkxO?=
 =?utf-8?B?d0lFR1ZyT0FCUmljaGJpZ2JzTW1VYmRaMU5SbzJiRUdUWWlTTjVTTGtiSDZE?=
 =?utf-8?B?Tk5WdjE3a05paUswRW8vSXFsS3h6WFRrU1JNRjlxbWN2Q3VtVDY3WTRDUnE4?=
 =?utf-8?B?VWMrZFRrL21yRGlYZWIyZVZRenJ2eHBiQTlmSG9VVVg1MFR2ZFcvOHJQUjVQ?=
 =?utf-8?B?K3ErUVVCK2Z5c09CT0VPWllpSEY4a3dGZ2JkMWZxSXIwQzQreW9CejA4Rzdv?=
 =?utf-8?B?OWEwRUhxUzBLQm9TWkI0NmZPUEE4UUdtT2p4NnVnUGtLMWlDWFdPMFhsN00v?=
 =?utf-8?B?ek00amJpY3I0Q0RYM1Awbkl3ODllL2hPcTQ5QVhLSGlESGRYOVh0TWZ1bHBJ?=
 =?utf-8?B?SldEZHhRUy9TN0ZGSC9sSUlEK2EwSG5yQkQzeWI0d2FhbDIrWCt0RFArV2tk?=
 =?utf-8?B?WitEckZBL2JESG9iYUZJdnBSdm1VK2lyQ095WWY3YlZ4M3J5Nlpub3puUVNY?=
 =?utf-8?B?TkZVY0F2ajFzbzlPUnhnR1kyUldQT3RlRFBZeGlpcGthczVNRzZVOWRnOVJ5?=
 =?utf-8?B?VDlDWXllNlI4STNSRFNoWnlxemJKVGJTNUkvZzRWazZCL0dNZmFwTUNqam9m?=
 =?utf-8?B?ZVhVR2lSMFFMTkFja3lZMDBKaC9qMWpPdjM0blZ6REllc2p2bTgwMkVjYmZG?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42A65D731C9B8E409811B7B652860EB1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB4747.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d12c19-5949-472c-3a92-08dacb9a6c7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 08:28:53.1869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25hy+JkQyJ3pOolH5ghURsQNRgf7QP6wB3pktyBI85Cco/KxEocGAN6pYx3l729U0qkrOstPW7SO3OH8/XCHBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6199
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDIwOjQ2ICswODAwLCBCYXlpIENoZW5nIHdyb3RlOg0KPiBG
cm9tOiBiYXlpIGNoZW5nIDxiYXlpLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFRoZSBsb2dp
Y2FsIHN0cnVjdHVyZXMgb2YgbXRrX25vcl93cml0ZV9idWZmZXJfZW5hYmxlIGFuZA0KPiBtdGtf
bm9yX3dyaXRlX2J1ZmZlcl9kaXNhYmxlIGFyZSB2ZXJ5IHNpbWlsYXIsIFNvIGl0IGlzIG5lY2Vz
c2FyeSB0bw0KPiBjb21iaW5lIHRoZW0gaW50byBvbmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBi
YXlpIGNoZW5nIDxiYXlpLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+IENoYW5nZSBpbiB2
MToNCj4gICAtRGVsZXRlIG10a19ub3Jfd3JpdGVfYnVmZmVyX2VuYWJsZS4NCj4gICAtRGVsZXRl
IG10a19ub3Jfd3JpdGVfYnVmZmVyX2Rpc2FibGUuDQo+ICAgLUFkZCBtdGtfbm9yX3NldHVwX3dy
aXRlX2J1ZmZlci4NCj4gLS0tDQo+IC0tLQ0KPiAgZHJpdmVycy9zcGkvc3BpLW10ay1ub3IuYyB8
IDQwICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3NwaS9zcGktbXRrLW5vci5jIGIvZHJpdmVycy9zcGkvc3BpLW10ay1u
b3IuYw0KPiBpbmRleCBkMTY3Njk5YTFhOTYuLmU4YjM1NWY1YmU1NiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9zcGkvc3BpLW10ay1ub3IuYw0KPiArKysgYi9kcml2ZXJzL3NwaS9zcGktbXRrLW5v
ci5jDQo+IEBAIC00NDMsMzYgKzQ0MywyOCBAQCBzdGF0aWMgaW50IG10a19ub3JfcmVhZF9waW8o
c3RydWN0IG10a19ub3IgKnNwLA0KPiBjb25zdCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApDQo+ICAJ
cmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBtdGtfbm9yX3dyaXRlX2J1ZmZl
cl9lbmFibGUoc3RydWN0IG10a19ub3IgKnNwKQ0KPiArc3RhdGljIGludCBtdGtfbm9yX3NldHVw
X3dyaXRlX2J1ZmZlcihzdHJ1Y3QgbXRrX25vciAqc3AsIGJvb2wgb24pDQo+ICB7DQo+ICAJaW50
IHJldDsNCj4gIAl1MzIgdmFsOw0KPiAgDQo+IC0JaWYgKHNwLT53YnVmX2VuKQ0KPiArCWlmICgh
KHNwLT53YnVmX2VuIF4gb24pKQ0KPiAgCQlyZXR1cm4gMDsNCj4gIA0KPiAgCXZhbCA9IHJlYWRs
KHNwLT5iYXNlICsgTVRLX05PUl9SRUdfQ0ZHMik7DQo+IC0Jd3JpdGVsKHZhbCB8IE1US19OT1Jf
V1JfQlVGX0VOLCBzcC0+YmFzZSArIE1US19OT1JfUkVHX0NGRzIpOw0KPiAtCXJldCA9IHJlYWRs
X3BvbGxfdGltZW91dChzcC0+YmFzZSArIE1US19OT1JfUkVHX0NGRzIsIHZhbCwNCj4gLQkJCQkg
dmFsICYgTVRLX05PUl9XUl9CVUZfRU4sIDAsIDEwMDAwKTsNCj4gLQlpZiAoIXJldCkNCj4gLQkJ
c3AtPndidWZfZW4gPSB0cnVlOw0KPiAtCXJldHVybiByZXQ7DQo+IC19DQo+IC0NCj4gLXN0YXRp
YyBpbnQgbXRrX25vcl93cml0ZV9idWZmZXJfZGlzYWJsZShzdHJ1Y3QgbXRrX25vciAqc3ApDQo+
IC17DQo+IC0JaW50IHJldDsNCj4gLQl1MzIgdmFsOw0KPiArCWlmIChvbikgew0KPiArCQl3cml0
ZWwodmFsIHwgTVRLX05PUl9XUl9CVUZfRU4sIHNwLT5iYXNlICsNCj4gTVRLX05PUl9SRUdfQ0ZH
Mik7DQo+ICsJCXJldCA9IHJlYWRsX3BvbGxfdGltZW91dChzcC0+YmFzZSArIE1US19OT1JfUkVH
X0NGRzIsDQo+IHZhbCwNCj4gKwkJCQkJIHZhbCAmIE1US19OT1JfV1JfQlVGX0VOLCAwLA0KPiAx
MDAwMCk7DQo+ICsJfSBlbHNlIHsNCj4gKwkJd3JpdGVsKHZhbCAmIH5NVEtfTk9SX1dSX0JVRl9F
Tiwgc3AtPmJhc2UgKw0KPiBNVEtfTk9SX1JFR19DRkcyKTsNCj4gKwkJcmV0ID0gcmVhZGxfcG9s
bF90aW1lb3V0KHNwLT5iYXNlICsgTVRLX05PUl9SRUdfQ0ZHMiwNCj4gdmFsLA0KPiArCQkJCQkg
ISh2YWwgJiBNVEtfTk9SX1dSX0JVRl9FTiksIDAsDQo+IDEwMDAwKTsNCj4gKwl9DQo+ICANCj4g
LQlpZiAoIXNwLT53YnVmX2VuKQ0KPiAtCQlyZXR1cm4gMDsNCj4gLQl2YWwgPSByZWFkbChzcC0+
YmFzZSArIE1US19OT1JfUkVHX0NGRzIpOw0KPiAtCXdyaXRlbCh2YWwgJiB+TVRLX05PUl9XUl9C
VUZfRU4sIHNwLT5iYXNlICsgTVRLX05PUl9SRUdfQ0ZHMik7DQo+IC0JcmV0ID0gcmVhZGxfcG9s
bF90aW1lb3V0KHNwLT5iYXNlICsgTVRLX05PUl9SRUdfQ0ZHMiwgdmFsLA0KPiAtCQkJCSAhKHZh
bCAmIE1US19OT1JfV1JfQlVGX0VOKSwgMCwgMTAwMDApOw0KPiAgCWlmICghcmV0KQ0KPiAtCQlz
cC0+d2J1Zl9lbiA9IGZhbHNlOw0KPiArCQlzcC0+d2J1Zl9lbiA9IG9uOw0KPiArDQo+ICAJcmV0
dXJuIHJldDsNCj4gIH0NCj4gIA0KPiBAQCAtNDgyLDcgKzQ3NCw3IEBAIHN0YXRpYyBpbnQgbXRr
X25vcl9wcF9idWZmZXJlZChzdHJ1Y3QgbXRrX25vcg0KPiAqc3AsIGNvbnN0IHN0cnVjdCBzcGlf
bWVtX29wICpvcCkNCj4gIAl1MzIgdmFsOw0KPiAgCWludCByZXQsIGk7DQo+ICANCj4gLQlyZXQg
PSBtdGtfbm9yX3dyaXRlX2J1ZmZlcl9lbmFibGUoc3ApOw0KPiArCXJldCA9IG10a19ub3Jfc2V0
dXBfd3JpdGVfYnVmZmVyKHNwLCB0cnVlKTsNCj4gIAlpZiAocmV0IDwgMCkNCj4gIAkJcmV0dXJu
IHJldDsNCj4gIA0KPiBAQCAtNTAxLDcgKzQ5Myw3IEBAIHN0YXRpYyBpbnQgbXRrX25vcl9wcF91
bmJ1ZmZlcmVkKHN0cnVjdCBtdGtfbm9yDQo+ICpzcCwNCj4gIAljb25zdCB1OCAqYnVmID0gb3At
PmRhdGEuYnVmLm91dDsNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+IC0JcmV0ID0gbXRrX25vcl93cml0
ZV9idWZmZXJfZGlzYWJsZShzcCk7DQo+ICsJcmV0ID0gbXRrX25vcl9zZXR1cF93cml0ZV9idWZm
ZXIoc3AsIGZhbHNlKTsNCj4gIAlpZiAocmV0IDwgMCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIAl3
cml0ZWIoYnVmWzBdLCBzcC0+YmFzZSArIE1US19OT1JfUkVHX1dEQVRBKTsNCj4gQEAgLTYwOCw3
ICs2MDAsNyBAQCBzdGF0aWMgaW50IG10a19ub3JfZXhlY19vcChzdHJ1Y3Qgc3BpX21lbSAqbWVt
LA0KPiBjb25zdCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApDQo+ICAJfQ0KPiAgDQo+ICAJaWYgKChv
cC0+ZGF0YS5kaXIgPT0gU1BJX01FTV9EQVRBX0lOKSAmJg0KPiBtdGtfbm9yX21hdGNoX3JlYWQo
b3ApKSB7DQo+IC0JCXJldCA9IG10a19ub3Jfd3JpdGVfYnVmZmVyX2Rpc2FibGUoc3ApOw0KPiAr
CQlyZXQgPSBtdGtfbm9yX3NldHVwX3dyaXRlX2J1ZmZlcihzcCwgZmFsc2UpOw0KPiAgCQlpZiAo
cmV0IDwgMCkNCj4gIAkJCXJldHVybiByZXQ7DQo+ICAJCW10a19ub3Jfc2V0dXBfYnVzKHNwLCBv
cCk7DQoNCkhpIEFuZ2VsbywgSGkgRGF2aWQsIEhpIE1hdHRoaWFzLA0KDQpKdXN0IGEgZ2VudGxl
IHBpbmcgb24gdGhpcy4NCkNvdWxkIHlvdSBwbGVhc2UgcmV2aWV3IHRoaXMgcGF0Y2ggYW5kIGdp
dmUgdXMgc29tZSBzdWdnZXN0aW9uPw0KDQpUaGFua3MsDQpCYXlpDQo=
