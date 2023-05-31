Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CF671784D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjEaHdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjEaHdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:33:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD1C124;
        Wed, 31 May 2023 00:33:07 -0700 (PDT)
X-UUID: 5cb71cceff8511edb20a276fd37b9834-20230531
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fsElX02vrFYEod6uPaMGsDcZahc4r02LL6bJK3mAgYM=;
        b=VOfRavBp8Rf7oc9cR+Df+OYrLt1BndGUAJGEjmEGWz4bB8aUBDtXX4ecLl+UkVr2dbcPwVQQHDOgYASKWNTnLGRaQ2fLCWoXCg715ZJIIHVYGrVi6xgABZiN9QTmZ1X1SSV2PZN5L4GtTSlaHRiLa6lSg5KjK+n62FRnbde/zvs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:22ccd03f-326f-4735-82e3-94e7c418baca,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:b63aea3c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 5cb71cceff8511edb20a276fd37b9834-20230531
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2067382922; Wed, 31 May 2023 15:32:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 31 May 2023 15:32:55 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 31 May 2023 15:32:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EO9oMS9gH094qRb+wMN5zu8ZEZQ3BOjjkB5+qCJ0U8J9d44Ot72y4naWFZvPDuGIKbAe11ShwnHFzmC7w1eBRWN9tooLhnzW/DSTsyuWGVCukM+mw4R0w2DFGASKW9Y5RHdblFx5BcnLjyLKnXpW9VSbEJL/qIlujNFnNVReMYVwFzpLZ8DxJHDg3Y63QRXLzWrrAfRh9yvJeV8nR0ihB/Rm+jXH2eAvjpSAMYlzSvo+H0vzFDL/kt2dWHXZDq0ZjbNwRr0P+jX4Qoid0TTidM2oCfkZqI0cclURX+BtjOeEioG/Dd4yUb7rsVuZEUHPcdOqmS5oO6YLYf7aog5PgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsElX02vrFYEod6uPaMGsDcZahc4r02LL6bJK3mAgYM=;
 b=TRVa8KafpJOc+zliB7kENt7i4jXKa1UHe17AFGCHW/llYSkM9UtSZ9JoacmljaGQ5dUgB5maigOsGmc00MNeCVl3Gb7ay/eVfCUZUHpUdU5bIJv5XA+jy1/AYlZKbGW4gbKJ3/6kSFCxJ6Q3TFFx1jo/Dmihnii2KRWQOqRzGH8+BXNyPreYI1GKE4GIuPbxSDTfYEdKpzci3cTVcYhV7hRGWYoEtcLgBq7WUVgE+5cH0bej1JXk0KZVTSAkEYJzKaMZmYDzk1R0vA98ooRT2d164B7y1+81rQB9qbOD5I6c1Lt13bretmmuU186tgVgpbbREku68yC979AqpLOE9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsElX02vrFYEod6uPaMGsDcZahc4r02LL6bJK3mAgYM=;
 b=nITZVx6TK86W2cGyJr6STtKAJj8Dv2LQI/AfFILQos/0669K3wlkXDAOtdLSuJswKrHznhsizufpOYIoJZWP6rvI+xekoP4ZZ5cCv1M1oA6s4CjHlFPqClZEU+n4kYtpA4MuLEA5kzpSKkFg+ouaztJKwWE3okSVH1xJ+YRFW6U=
Received: from KL1PR03MB6285.apcprd03.prod.outlook.com (2603:1096:820:a4::10)
 by TYUPR03MB7230.apcprd03.prod.outlook.com (2603:1096:400:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 07:32:53 +0000
Received: from KL1PR03MB6285.apcprd03.prod.outlook.com
 ([fe80::5c8d:a40e:1569:2d14]) by KL1PR03MB6285.apcprd03.prod.outlook.com
 ([fe80::5c8d:a40e:1569:2d14%9]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 07:32:53 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>
Subject: Re: [PATCH v2] mmc: mtk-sd: reduce CIT for better performance
Thread-Topic: [PATCH v2] mmc: mtk-sd: reduce CIT for better performance
Thread-Index: AQHZguL8DXJ4wwqPNE+3vDjAEU6xMa9fzDYAgBRRdwA=
Date:   Wed, 31 May 2023 07:32:53 +0000
Message-ID: <e682b8b66261a71601707a4e74af2829f86800dc.camel@mediatek.com>
References: <20230510015851.11830-1-wenbin.mei@mediatek.com>
         <0df3968e-da34-b36c-4cb4-92d66508a46a@collabora.com>
In-Reply-To: <0df3968e-da34-b36c-4cb4-92d66508a46a@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6285:EE_|TYUPR03MB7230:EE_
x-ms-office365-filtering-correlation-id: 4565f593-571a-402c-7497-08db61a93e9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vqa1GIfOTTSk7wgYMUtwZNg9+8KrcZdW0VF8L0sXJLDGPLAWXuchnjt3V1n64RfgArPLl1xymbaUgVa1pkfqw2yHhBRrPcNA1s9I90yhvi71zskUv6I2QywT3GIoSMwQBZpogzjKzZwmcybpWYcsJraXfVcqDMy+VNEz5alvlcbQHXpIBqmt831tu0eyNbOFD9HheGn2BaXPEtmN58ULuBNTVtlsYdVFFdV7XL2cMKnAXR5pQacyzHAgrOjukJYDrOkTq5XvU5IRZtU7o9iu4Jj7txxyoqHoc1y+BA/zZLdDwtCpx+ALFgokq8NFwvvl3+0okSQxrma119l29X3Yd/+Iv3Zb5QHuqy6s0KJ6tlJdo2adG83gOg+KSjY+0Ni2LG6kvIbbllngZxknA34gN6JDF2snt/H9mZlacapnxcQjCuuPtKOscfcF5RABICAGgV0oV0j9t8wh3tnueLPy068ij0YhTUGpmBPJ9lNYZkzxJWu+zajsJcFR+qY48SVgzN18fhfv0l99Ex7632dTqNI3KtsWPDePWVU8zcLqIzrZtekZ+b0RRIKaxUcsIi3k17SnqX2ggUwzKscsfW4Y39DD8jAUgF1S04WHKqWpMxEfMFD33M8U4bK1CIxiSMxHM9uwNj5OotHLBAbmMxHe1FfmcrkkWL0EH/EKihbvnr0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6285.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(316002)(6486002)(41300700001)(2616005)(86362001)(83380400001)(6512007)(6506007)(38070700005)(26005)(107886003)(2906002)(186003)(122000001)(38100700002)(8676002)(8936002)(5660300002)(36756003)(85182001)(4326008)(478600001)(110136005)(76116006)(66946007)(66476007)(66446008)(64756008)(66556008)(91956017)(71200400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajdURDNZcmNadUpwNGU0Njl5Y05DMTg2cUgwa1B3TUZhZW9wOUFsQUxMRURz?=
 =?utf-8?B?WFlnN0daTFNMNjhHcmtGWGxBSWtIRmljazFVOS9EYXJCalJCNTZodFErcktM?=
 =?utf-8?B?ODN5N29yNFA0MytBVU1VaEhVTThZZ0dVdWRnakVLMm9HTkxrbU5Va3E0OWRy?=
 =?utf-8?B?RnZjWURlK2kycDlFKzZGNHdGQy9XQWhwZUo4MXBwUmtFenZYVDVYTkk5UEVG?=
 =?utf-8?B?WnhNMW82anJLQWlrTDJRRFJNZVlHdGVNbWIrRGYrajJqczMxSk5oTHhNdUs4?=
 =?utf-8?B?N0xWY1dvYmNzU1cwSTUrR3p1M2ozRThnbjZmL1lUdDFQTmwrcTdOSmRvUEVH?=
 =?utf-8?B?eHp3SmowU1BaZjBtMkRtczh3Q1RycjFFMzc1bGN6ek1qRkJndHZGU0VtWjhp?=
 =?utf-8?B?TWdicmNYeStDdk1OVk9WMDJ4dzVxZXE0QmVIUURnRThMWU5pSGRGOWVsUFBF?=
 =?utf-8?B?YWN5K2MwdjM2ZHNLVmRlMThHN0hrR2s2NlBCemtJVDdldUVaMEFKbC96NFZL?=
 =?utf-8?B?elZjQkM2SCtaZTZiVkNWdEpEbGZYb012SWo0U0htQTlTb0liUmUzMFk3U2RR?=
 =?utf-8?B?WUZYN3NWRU4rVGhReGRHZ2krM3REdVAzZHlCYjl4MUdHTnhadXdmVjlrWUk3?=
 =?utf-8?B?blFVSGJrMlFYeERsVlNtWVFCS01GYlYvUmFHelRhaXNyQkxUYU9CczMrTlZ5?=
 =?utf-8?B?MncrV3ZEZDNReXV4SWRVV0R2ZDVhb2o3MmtEOVVLRzA3TG5NSXhLbHlGc2pZ?=
 =?utf-8?B?QXplRUZmakJRa201T0FmY1BCT0FSaDR6b29aUFBkaTFncWRrYzRpSTVGM29p?=
 =?utf-8?B?UzVUNG5XRzByYWtUc01FNmhPYkE2Z3hUUEsvRjY0TEtSQ0M1Q2dHUnhKd1BU?=
 =?utf-8?B?QlRHaS9TbFJJUzhtVkxGZEhzZUlBNEppaUdObC80bzhQVkZVTWswK1g0V3J0?=
 =?utf-8?B?LzBUY21BRTQ5L1hPR0o4aG9FT3ZpZzd5emFIdU9TSHEybFhSQVlSRVViT0NT?=
 =?utf-8?B?NVVIc1UyTFdWN0ZnY3FteGc5TDRjdEpnL2NuWG5DSXp0OGxCOHpWRW9ZaUhU?=
 =?utf-8?B?TGV4MDRhMTBCUDh5V01uT0FyVW5yeHVCUndaeUpYY0FOeEl5aG1UVHlpZ0p1?=
 =?utf-8?B?UG9KbmljSWVGb0lPK3R1UXdkM3ZGQzIxMTJMMHROdTc1QjJ2dE1OY0FUUmtG?=
 =?utf-8?B?bmtHUkE5WVdrTjh2dkt1UW5xNHYxVit4YmJLaTNLMnJBSWZTTzFNYmRwRDR5?=
 =?utf-8?B?RlpGSitnQitTRmYveUNLRUptTGRGaGRHSWdXS01LNEtWZjJ2ZlhjQ3haSkNG?=
 =?utf-8?B?SDVaYkZzbWhCN3VHbUM0eENRc1ZFOW9NcFVQbVJvSmxpSmNFY3BiM0pzd2lQ?=
 =?utf-8?B?TkRSYUphMXgyWDFaYjQ3eldmQUk1QVYzYzZ0YmM0RGtJMzBDT25iTy9xYkVw?=
 =?utf-8?B?UGMxd09oSG5EMSt2U2RML2syc3NxSTNwZFZWNDB0VE5QVkg4b3NxSEczRXc2?=
 =?utf-8?B?TjIybmEwV3FvSFhNL1p0Z2JJVk1UdE5vM3JBb01KREdQY1pNc2ZzRkhYU3Vx?=
 =?utf-8?B?UGFwek91ODlHR0lhRmdqTXc0aVJLVkRBcm9uSURoRnFiWHBSMVhRRThJUlVI?=
 =?utf-8?B?Wkduc0swZGZlOWR6TW5hekxLd1lUQlBCY0xIRjJkeXJxSlFmeVNadWxLbmhv?=
 =?utf-8?B?ejQ1dERNc1VWdDRTRkloN1JBQzN6bTlLZE9TSVBtTzBJeWM4NUlBeVI1c0c2?=
 =?utf-8?B?ZmIrTlZTU2JGS2hqVHBlVi93UGh5NmROTFQwQmFFOEFHUkxvMFl2MzNJcjJx?=
 =?utf-8?B?K1VuNXpCZFNjN1N0RlhtcTZ5ZEs4dld6Wkcvbnd0dmxUY0FXNU5BY25tNWY0?=
 =?utf-8?B?SmxZMUxwdEJTMUNhUVFuV1NBNk94ZXRMRFRCd0pWMC9RVytDdlREdmRJL0Ir?=
 =?utf-8?B?cm1GZklHVlhBWWs1ZWZBbFo1bmVMN0E1dkxXT3I5RW42K2RES0M5WmlPb1px?=
 =?utf-8?B?NFRWNlB4b1huM053VFFmc2NRelQ5WWdyNEw4T3M3c3IrMUxlcEkxOGR6RnBq?=
 =?utf-8?B?QXdJd1d1RDBPeDJKNnYraktXdG1yZzkwakhkUHVPalZhZHlJUUpSOUdwOE5U?=
 =?utf-8?B?cFdybWpGMFBUcDltb05ma3JJNjhiVXB3TzlXVUJTakRvMHVuOTkwaEZZOUhR?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB380FD6DE7B5849987EDC78B6362C69@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6285.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4565f593-571a-402c-7497-08db61a93e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 07:32:53.0933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40Lip5gkIRmzzyNX+DwDl5oNHPbxwo4+Fdd86sd4aMH1WdugsZ5jbJ+SdzKHfz2F+yI9k/dv4JKiK86frvp4Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7230
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA1LTE4IGF0IDExOjEzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxMC8wNS8yMyAwMzo1OCwgV2VuYmluIE1l
aSBoYSBzY3JpdHRvOg0KPiA+IENRSENJX1NTQzEgaW5kaWNhdGVzIHRvIENRRSB0aGUgcG9sbGlu
ZyBwZXJpb2QgdG8gdXNlIHdoZW4gdXNpbmcNCj4gPiBwZXJpb2RpYw0KPiA+IFNFTkRfUVVFVUVf
U1RBVFVTKENNRDEzKSBwb2xsaW5nLg0KPiA+IFRoZSBkZWZhdWx0IHZhbHVlIDB4MTAwMCB0aGF0
IGNvcnJlc3BvbmRzIHRvIDE1MHVzLCBsZXQncyBkZWNyZWFzZQ0KPiA+IGl0IHRvDQo+IA0KPiBU
aGUgZGVmYXVsdCB2YWx1ZSAweDEwMDAgKDQwOTYpIGNvcnJlc3BvbmRzIHRvIDQwOTYgKiA1Mi4w
OHVTID0NCj4gMjMxLjMzdVMNCj4gLi4uc28gdGhlIGRlZmF1bHQgaXMgbm90IDE1MHVTLg0KPiAN
Cj4gSWYgSSdtIHdyb25nLCB0aGlzIG1lYW5zIHRoYXQgdGhlIENRQ0FQIGZpZWxkIGlzIG5vdCAw
LCB3aGljaCB3b3VsZA0KPiBtZWFuDQo+IHRoYXQgdGhlIGV4cGVjdGVkIDN1UyB3b3VsZCBiZSB3
cm9uZy4NCj4gDQo+IEFsc28sIHNpbmNlIHRoZSBjYWxjdWxhdGlvbiBjYW4gYmUgZG9uZSBkeW5h
bWljYWxseSwgdGhpcyBpcyB3aGF0IHdlDQo+IHNob3VsZA0KPiBhY3R1YWxseSBkbyBpbiB0aGUg
ZHJpdmVyLCBhcyB0aGlzIGdpdmVzIGluZm9ybWF0aW9uIHRvIHRoZSBuZXh0DQo+IGVuZ2luZWVy
DQo+IGNoZWNraW5nIHRoaXMgcGllY2Ugb2YgY29kZS4NCj4gDQo+IEFwYXJ0IGZyb20gdGhpcywg
YnkganVzdCB3cml0aW5nIDB4NDAgdG8gdGhlIENRSENJX1NTQzEgcmVnaXN0ZXIsIHlvdQ0KPiBh
cmUNCj4gYXNzdW1pbmcgdGhhdCB0aGUgQ1FDQVAgdmFsdWUgcmVxdWlyZW1lbnQgaXMgZnVsbGZp
bGxlZCwgYnV0IHlvdQ0KPiBjYW5ub3QNCj4gYXNzdW1lIHRoYXQgdGhlIGJvb3Rsb2FkZXIgaGFz
IHNldCB0aGUgQ1FDQVAncyBJVENGVkFMIGFuZCBJVENGTVVMDQo+IGZpZWxkcw0KPiBhcyB5b3Ug
ZXhwZWN0IG9uIGFsbCBwbGF0Zm9ybXM6IHRoaXMgbWVhbnMgdGhhdCBpbXBsZW1lbnRpbmcgdGhp
cw0KPiB0YWtlcw0KPiBhIGxpdHRsZSBtb3JlIGVmZm9ydC4NCj4gDQo+IFlvdSBoYXZlIHR3byB3
YXlzIHRvIGltcGxlbWVudCB0aGlzOg0KPiAgICoqKiBGaXJzdCAqKioNCj4gICAxLiBSZWFkIElU
Q0ZNVUwgYW5kIElUQ0ZWQUwsIHRoZW46DQo+ICAgICAgdGNsa19tdWwgPSBpdGNmbXVsX3RvX21o
eihJVENGTVVMKTsgLyogcHNldWRvIGZ1bmN0aW9uDQo+IGludGVycHJldHMgcmVnIHZhbHVlKi8N
Cj4gICAgICB0Y2xrID0gSVRDRlZBTCAqIHRjbGtfbXVsOw0KPiANCj4gICAyLiBTZXQgU1NDMSBz
byB0aGF0IHdlIGdldCAzblM6DQo+ICAgICAgI2RlZmluZSBDUUhDSV9TU0MxX0NJVCBHRU5NQVNL
KDE1LCAwKQ0KPiAgICAgIHBvbGxfdGltZSA9IGNpdF90aW1lX25zX3RvX3JlZ3ZhbCgzKTsNCj4g
ICAgICBzc2NpdCA9IEZJRUxEX1BSRVAoQ1FIQ0lfU1NDMV9DSVQsIHBvbGxfdGltZSkNCj4gICAg
ICBjcWhjaV93cml0ZWwoIC4uLiApDQo+IA0KPiAgICoqKiBTZWNvbmQgKioNCj4gDQo+ICAgMS4g
UHJlLXNldCBJVENGTVVMIGFuZCBJVENGVkFMIHRvDQo+ICAgICAgSVRDRlZBTCA9IDE5MiAoZGVj
aW1hbCkNCj4gICAgICBJVENGTVVMID0gMiAod2hlcmUgMiA9PSAwLjFNSHopDQo+IA0KPiAgIDIu
IFNldCBTU0MxIHNvIHRoYXQgd2UgZ2V0IDNuUzoNCj4gICAgICAjZGVmaW5lIENRSENJX1NTQzFf
Q0lUIEdFTk1BU0soMTUsIDApDQo+ICAgICAgcG9sbF90aW1lID0gY2l0X3RpbWVfbnNfdG9fcmVn
dmFsKDMpOw0KPiAgICAgIHNzY2l0ID0gRklFTERfUFJFUChDUUhDSV9TU0MxX0NJVCwgcG9sbF90
aW1lKQ0KPiAgICAgIGNxaGNpX3dyaXRlbCggLi4uICkNCj4gDQo+IEkgd291bGQgaW1wbGVtZW50
IHRoZSBmaXJzdCB3YXksIGFzIGl0IHBhdmVzIHRoZSB3YXkgdG8gZXh0ZW5kIHRoaXMNCj4gdG8g
ZGlmZmVyZW50DQo+IHRjbGsgdmFsdWVzIGlmIG5lZWRlZCBpbiB0aGUgZnV0dXJlLg0KPiANCj4g
UmVnYXJkcywNCj4gQW5nZWxvDQpIaSBBbmdlbG8sDQoNClNvcnJ5IGZvciBsYXRlbHkgcmVwbHku
DQoNCkZvciBNZWRpYXRlayBtbWMgaG9zdCBJUCwgSVRDRk1VTCBpcyAweDIoMHgxTUh6KSwgSVRW
RlZBTCByZXBvcnRzIDE4MiwNCmFuZCB0aGVzZSBmaWVsZHMgYXJlIHRoZSBzYW1lIGFuZCBhcmUg
cmVhZG9ubHkgZm9yIGFsbCBJQywgYnV0IHNpbmNlDQpNZWRpYXRlayBDUUUgdXNlcyBtc2RjX2hj
bGsoMjczTUh6KSwgQ01EMTMnaW50ZXJ2YWwgY2FsY3VsYXRpb24gZHJpdmVyDQpzaG91bGQgdXNl
IDI3M01IeiB0byBnZXQgdGhlIGFjdHVhbCB0aW1lLCBzbyB0aGUgYWN0dWFsIGNsb2NrIGlzDQoy
Ny4zTUh6Lg0KDQpJZiBDSVQgaXMgMHgxMDAwIGJ5IGRlZmF1bHQsIENNRCBpZGxlIHRpbWU6IDB4
MTAwMCAqIDEgLyAyNy4zTUh6ID0NCmFyb3VuZCAxNTB1cy4NCg0KSW4gYWRkaXRpb24gdGhlIGJv
b3Rsb2FkZXIgd2lsbCBub3Qgc2V0IHRoZSBDUUNBUCdzIElUQ0ZWQUwgYW5kIElUQ0ZNVUwNCmZp
ZWxkcywgYmVjYXVzZSB0aGVzZSBmaWVsZHMgb2YgQ1FDQVAgcmVnaXN0ZXIgaXMgUk8ocmVhZG9u
bHkpLCBzbyB3ZQ0KY2FuIGlnbm9yZSB0aGUgY2hhbmdlIGZvciB0aGUgQ1FDQVAncyBJVENGVkFM
IGFuZCBJVENGTVVMIGZpZWxkcy4NCg0KVGhhbmtzDQpXZW5iaW4NCj4gDQo+ID4gMHg0MCB0aGF0
IGNvcnJlc3BvbmRzIHRvIDN1cywgd2hpY2ggY2FuIGltcHJvdmUgdGhlIHBlcmZvcm1hbmNlIG9m
DQo+ID4gc29tZQ0KPiA+IGVNTUMgZGV2aWNlcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBX
ZW5iaW4gTWVpIDx3ZW5iaW4ubWVpQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZl
cnMvbW1jL2hvc3QvbXRrLXNkLmMgfCA0ICsrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tdGst
c2QuYyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gPiBpbmRleCBlZGFkZTBlNTRhMGMu
LmZmZWNjZGRjZDAyOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5j
DQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+IEBAIC0yNDUzLDYgKzI0
NTMsNyBAQCBzdGF0aWMgdm9pZCBtc2RjX2hzNDAwX2VuaGFuY2VkX3N0cm9iZShzdHJ1Y3QNCj4g
PiBtbWNfaG9zdCAqbW1jLA0KPiA+ICAgc3RhdGljIHZvaWQgbXNkY19jcWVfZW5hYmxlKHN0cnVj
dCBtbWNfaG9zdCAqbW1jKQ0KPiA+ICAgew0KPiA+ICAgICAgIHN0cnVjdCBtc2RjX2hvc3QgKmhv
c3QgPSBtbWNfcHJpdihtbWMpOw0KPiA+ICsgICAgIHN0cnVjdCBjcWhjaV9ob3N0ICpjcV9ob3N0
ID0gbW1jLT5jcWVfcHJpdmF0ZTsNCj4gPiANCj4gPiAgICAgICAvKiBlbmFibGUgY21kcSBpcnEg
Ki8NCj4gPiAgICAgICB3cml0ZWwoTVNEQ19JTlRfQ01EUSwgaG9zdC0+YmFzZSArIE1TRENfSU5U
RU4pOw0KPiA+IEBAIC0yNDYyLDYgKzI0NjMsOSBAQCBzdGF0aWMgdm9pZCBtc2RjX2NxZV9lbmFi
bGUoc3RydWN0IG1tY19ob3N0DQo+ID4gKm1tYykNCj4gPiAgICAgICBtc2RjX3NldF9idXN5X3Rp
bWVvdXQoaG9zdCwgMjAgKiAxMDAwMDAwMDAwVUxMLCAwKTsNCj4gPiAgICAgICAvKiBkZWZhdWx0
IHJlYWQgZGF0YSB0aW1lb3V0IDFzICovDQo+ID4gICAgICAgbXNkY19zZXRfdGltZW91dChob3N0
LCAxMDAwMDAwMDAwVUxMLCAwKTsNCj4gPiArDQo+ID4gKyAgICAgLyogZGVjcmVhc2UgdGhlIHNl
bmQgc3RhdHVzIGNvbW1hbmQgaWRsZSB0aW1lciB0byAzdXMgKi8NCj4gPiArICAgICBjcWhjaV93
cml0ZWwoY3FfaG9zdCwgMHg0MCwgQ1FIQ0lfU1NDMSk7DQo+ID4gICB9DQo+ID4gDQo+ID4gICBz
dGF0aWMgdm9pZCBtc2RjX2NxZV9kaXNhYmxlKHN0cnVjdCBtbWNfaG9zdCAqbW1jLCBib29sIHJl
Y292ZXJ5KQ0KPiANCj4gDQo=
