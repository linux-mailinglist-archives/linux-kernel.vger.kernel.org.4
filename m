Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E538A643CAD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 06:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiLFFag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 00:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLFFab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 00:30:31 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AA822B14;
        Mon,  5 Dec 2022 21:30:24 -0800 (PST)
X-UUID: b03bb8d147a2431899e8e77d1a0d9815-20221206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ou2ZiiawNJtlpv/ltjV2HLWqzKbgP0RFJVszpeDQTwc=;
        b=BWyTu6i7JhEihKpz0dUdVfGOIeKyFDcOKDZIJJzLpKfppZ2FfS/EGH+UnygOOx7BAk8Dj1e6J3phj5vbtARF3LkJhPZftG6RvvvfXNkdwiK58KsyqdhzPdcphRqIubtp75gXcbxY2gT778TnevfqFyo4OrQUaAVhIDeBXO1i9i0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:2ba58e3d-ec98-4c98-af82-79906fe5ae58,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:2d13c2d1-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b03bb8d147a2431899e8e77d1a0d9815-20221206
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <bayi.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 635378984; Tue, 06 Dec 2022 13:30:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 6 Dec 2022 13:30:18 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 6 Dec 2022 13:30:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2qOX8Jz2AUG6cNyE9gaB0HlK6RcKWgHuvE3VAlqcCQVqX0I8K1FyjiK3iXVDMaDTXCjxWs2jxSpH+lDp6XgcnCfCzcWDJ4D+wV6mGswPpiwn+pUcA9GjHdi1OgC0HXYqj0e8L/r64/x1Aho9kOKjgnPq4DC9Ca5WC5lq7i2HYNMtVgD/TrLA8NQv1D6nfT7YCnnd1inN7AdEJ0FrUHLafhq5XlvvlCS7ojcmkg3RQ0BcGL4Njp4KrIpv6FOTcLMNA5KAZcs1EX5MlVf4bLz92kH5KGv6WCmneMJfpW0V3tewAX2NvQSgCsj/0qSqGk0mzK+6GLe/HLSJu3NMSO3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ou2ZiiawNJtlpv/ltjV2HLWqzKbgP0RFJVszpeDQTwc=;
 b=dRNMY5KOjEjxl9+gjOr4cpfQCHmBpLw3BH8NVkcyCHccT9/erys/sMJGRH8hrHjB/yn3ZnWZakIR10iqHa25hKyEXBVsn1XEYqwqCz0oMumf2rBERZrUMVkeoW8oNVbT8RIoUUQnSBm0bnymfPfet74ujsLMGFgMpF/lA8Z7Z6EoiG9WyLoKctrBZMs1ursgdVfhitp2ShCkfuNu2LapeBPcuKE8TrQIBYelrOrEp8TPYpur62KNSyo8KzXxHbMT8blLOiIzQ1M4FR6R3EyyVLsOU6Kc41RcqvNzqvKXW1GDzx6Kd+JucIpNf9TJfhLQqegWzZ5RK3pZOO/soX+2pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou2ZiiawNJtlpv/ltjV2HLWqzKbgP0RFJVszpeDQTwc=;
 b=KfAHCkoIBPB3KaC0tiy8NwlZzT5hBUAUTmqf5FX1PRdsgT2gAh73VGDdXQhlCV7eOBhmyXXTctGgqGBaimKliyCKk3mX7oGXlAkBMJ755s1V8NJ/TJLlva2YCNpPSEAiGkNTq4r/ZBWLCXL1Bv6yqkRALmjbGeozLFnLdbir1VY=
Received: from PS1PR03MB4747.apcprd03.prod.outlook.com (2603:1096:300:86::18)
 by KL1PR03MB6973.apcprd03.prod.outlook.com (2603:1096:820:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Tue, 6 Dec
 2022 05:30:13 +0000
Received: from PS1PR03MB4747.apcprd03.prod.outlook.com
 ([fe80::3632:e0db:581c:36ad]) by PS1PR03MB4747.apcprd03.prod.outlook.com
 ([fe80::3632:e0db:581c:36ad%3]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 05:30:13 +0000
From:   =?utf-8?B?QmF5aSBDaGVuZyAo56iL5YWr5oSPKQ==?= 
        <bayi.cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "ikjn@chromium.org" <ikjn@chromium.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1] spi: spi-mtk-nor: Add recovery mechanism for dma read
 timeout
Thread-Topic: [PATCH v1] spi: spi-mtk-nor: Add recovery mechanism for dma read
 timeout
Thread-Index: AQHZCIL9rTX4J4Y/N02P6SNjnl/4Y65fUxyAgAEDewA=
Date:   Tue, 6 Dec 2022 05:30:13 +0000
Message-ID: <ffa970e5a28d869c097a39f9fd4fc81e5dbbd8de.camel@mediatek.com>
References: <20221205082419.29170-1-bayi.cheng@mediatek.com>
         <d5bcc6aa-bdb5-9705-a7dd-79a276f4ea01@collabora.com>
In-Reply-To: <d5bcc6aa-bdb5-9705-a7dd-79a276f4ea01@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB4747:EE_|KL1PR03MB6973:EE_
x-ms-office365-filtering-correlation-id: 4f364c61-072f-49b9-7101-08dad74af351
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vi86hLcV/8JShkCwzHb+n5jLPKo9HoSmlgrunVq+Efjsp3bKU/Cjfpbyshemg7DP9FDTGBDoyRbjlETRql6V9Dd3qwvr9CnHFQXZZdzpMYgDMhjQztsNdYtoylVenFlvxwyTGGHtK/npI/hYSE0DfBicVf16FYTsHMPWbLPOBN6goVwiO/Vly27QIXBzrv4FWD+bBboUf4K67UfsjFyH8nJOrHaFbzjLIpWzZ1k2OR6p/jtanCTNE7/6oulDK2z8O1zFI4xD9xpjRupwpTihanKYrYZ+iLGe+gguBAXjP7DatYXzrEOPGMLMCmybZIwPaLdcOroAU9tEQpTgLMEPOx2PFGXjocHle7kYe1CZSE1XTykwQce3JmbCpzO1rKNLnGEudGJKIROD3+jyEwHqaQr2HLtITkQ0PR+unauYJZEdxG3QNYCXtsFoMMvDRX8HEAvJ6/txuR0o7nYOiUeYJeuEXkBe79GCm5co/HHMddJE9XqvWCQrOP7g6TkILDJejC3FZXupu+NExSG9B2LFTZQu50B3hcoOv6Vhbkfnh18f+C5DUxHaOVVd64KbedLqAMhqXW7l2E2OJsoAVvOBzBoAG+qyFevGlkHpLfVnYr0zYVh3uwsJ//f/ZVtwSa4hntmNnVvO8zABFSUY6Yoh/w2NyDnqi1dAbmr1ck7GiXS90orETp83+C6N4AeSlgeYKKs3xOvD5WgtYKX8R4lY1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB4747.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(36756003)(66946007)(85182001)(4326008)(66556008)(91956017)(8676002)(76116006)(66446008)(8936002)(66476007)(64756008)(54906003)(2616005)(2906002)(316002)(83380400001)(186003)(6486002)(38100700002)(71200400001)(86362001)(122000001)(6512007)(38070700005)(478600001)(110136005)(26005)(6506007)(41300700001)(107886003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWVhT1lLM1QvWjJJQzlOeWpuSmk5QU9Bc0gzbTdsY2JORGpUTG04YjdXdUVk?=
 =?utf-8?B?Ry9oZmwwdU4rMm1BazlremNwc3J1RTlGVlMzbEVWU0NYeDBseVlSOHBmdkM0?=
 =?utf-8?B?UFhhUXo5Si80dTgxVmR0U3RJQWhWZ0VmOEVKM2c3ZE1CdU9hOWpxZzBEZFR3?=
 =?utf-8?B?NXFyeEZoVDhJY1F2K0x0a2dhSG9xMmtBYjQxK21zdkpLeGIwS0dXb28rak9I?=
 =?utf-8?B?UENQYXRCZCtLUWxqaUdEdGtCd1ZzQVRDOWJ6a2xlRVpnd3FBNXV2ZWtFZWM2?=
 =?utf-8?B?RktlaHpCWUVaOFdNbWhiZWFEczNvRFlheCtOVytScTI3ZEk5SnFOeXM4Ukxj?=
 =?utf-8?B?UldyMVNiUVQzOTFZTndvMHpmMU5VV014ZGxUZXhiS1VzNmdWQURnYkZWLzBI?=
 =?utf-8?B?azZJeHhsWDQzN0MzMTZYYkQ3a0lGMlB5Sm9ySXp4NWNPSnJQZ1VLQ3B0Yi9x?=
 =?utf-8?B?cFA0UmNnZ2ZJWE5VcThPTnViMXlDZEtXZE5zR3hnOHRtNTNEaEZOSHp2UkV3?=
 =?utf-8?B?Y2gzaXNYMUd4UDRjNVliT2VJbFV1UUtBcWNKMEtxZUYvWld3b2tSUGczV2cw?=
 =?utf-8?B?T1hKK3dZNHpuNC94QkJRVjNKZmxWK1VQUTYwZXRGMXI1RFFSeStRUUU2dEtk?=
 =?utf-8?B?WTBxSHRLbE5yNjlXRGhyMXlJZWY1bkViTmNWaEgxYzVnVHQvVHEzL3d2SEJx?=
 =?utf-8?B?bTVYWndkMm9wR0JmSDFxTzJITUwrcVg2eEhiUmdBem1aMWNQME1rQmNPMmN6?=
 =?utf-8?B?RjNXREI4Qkp4b2JNRWhKam1Sc1pkbmFSa1RIWTNDNkJPS2JsQ25MVVNxSUVC?=
 =?utf-8?B?S3RKUTNUc1BXd1JyTTJiQjByTnRyK25iYUZJN2NVc1ZReHQ1cVZCWUdWNkJI?=
 =?utf-8?B?ZVhYWHRGWi9nb211M1NkRUxwNlRJRHRudWR1amRLemUrcThCTUM3VzRENlkz?=
 =?utf-8?B?UDlEUzQ2UjdqNTIvbDA3bE8xdDA2a0ZvNlRjUFNMYnFVbU4zWVBNTXBIMUJq?=
 =?utf-8?B?ME5tbGJxYzNXeDZ6QTBaYnhtVWJmUFZWQjVqZVhpcHQxcit3bnZmd1kvT1dy?=
 =?utf-8?B?emp2c2krNE9HeXBMRnlmZ2Q2azlRNWRaUDR3Q3ZGYTJxa2xKekpLVzQrbFVa?=
 =?utf-8?B?dG1PazE3RUhLQWtOSnU2YmRGWjk3dklpd0gweEFEQ0JGenpJQW9zVUpFZUdQ?=
 =?utf-8?B?NFVxb25JeUlJR1FjZlZaQ1JmR29DSGlxd3J2M2xxbU02cld0akVBMmRybzV6?=
 =?utf-8?B?eUpvR0JCeDVKVGcwa1NHVm50R1VKQW51V1lQMkhZTlh2RS90K2lKL09WRkMw?=
 =?utf-8?B?UktpSzZIQ1haYnhrSlA1QWU5SDBINWtBYzVwdkQ4UW0rTjZ3dnIxcWdRZnpl?=
 =?utf-8?B?dWpOSks2Q05LT1VjdzZvYjF0dUFFRm56ZjBmUjlKbW5ocDFkVVViS09ndkFr?=
 =?utf-8?B?MDBOTG96TmJVSUVSZHpWZ2JsTVo0ZExSSjloK1k2eXk0ZE1jMDVsTkN1UVBL?=
 =?utf-8?B?bEt6WElkb2VKU2h5MFI0TXI1OCtVZjJ1SWZDc0JrQ2oyKzBkQ1hKRmp3Mm11?=
 =?utf-8?B?QnNiaWluaHlGWDJJanlrZllVZDZNaWtXQVF4VGdYL0VDb1ppM0lnZk5RUUd3?=
 =?utf-8?B?cEdicHU4MnJETFhsdDZsd1RMRUU1YjRCVVc5c2hhdHFIQ3RXaklIVW1GQUZy?=
 =?utf-8?B?UEVxTHV3UTJGdTNrL1VsTURHdkNzU0FMdkN5elloVHhGNDIrZG1TUXNTUTlZ?=
 =?utf-8?B?NEVtZXI5WVRySjVmVi9SYlBhNXMvZnZpSHZHN0dJV2JrWjB1bk9iZnhGand4?=
 =?utf-8?B?WUNUOUowcFkvWS9TUCt6NGNoWmtTdzlGOWE0anN1ZGhIUEcrR1BNL0tjSXBF?=
 =?utf-8?B?dGJyTkw0eEwreThxUEd3QzNqcis2QUFNY2Q5VkdRVGwzR3VGRnBUN3U3V3ZR?=
 =?utf-8?B?bXd0eVFiVTEvYndJaDg0enl1Y2RiblBNYVRBaVg5T3UzRWszbmNjR3lqK3pO?=
 =?utf-8?B?UUVrYmhYT01JWWxoeUZXRXk2RXRxRUlkRUVPOUtuWnZZV0NwZThObXBsTGw5?=
 =?utf-8?B?ZWpjRkRoWEozdHYvMEwyWXRmaFRhdmtxcGZOUlJQbDhKN1dkOFVLdXUyN2tP?=
 =?utf-8?B?dUdrZDB5SlJGUG9XbWI3MUFRazFkcE9wUGswdFh5SFU4L1kwSldxY1MzV3BT?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20C33C8E8AEA9C40904D2A6F214F4C61@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB4747.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f364c61-072f-49b9-7101-08dad74af351
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 05:30:13.5786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrjAIzUh2L+x8JB2LDFgy98dF+bCliHQRuNCH92e653q/zBq26wZDlJ0fYQSAtDiZkxJQQU8MCtrWi3yKieEUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6973
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEyLTA1IGF0IDE1OjAxICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDUvMTIvMjIgMDk6MjQsIEJheWkgQ2hlbmcgaGEgc2NyaXR0bzoN
Cj4gPiBGcm9tOiBiYXlpIGNoZW5nIDxiYXlpLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4g
PiBUaGUgc3RhdGUgbWFjaGluZSBvZiBNVEsgc3BpIG5vciBjb250cm9sbGVyIG1heSBiZSBkaXN0
dXJiZWQgYnkNCj4gPiBzb21lDQo+ID4gZ2xpdGNoIHNpZ25hbHMgZnJvbSB0aGUgcmVsZXZhbnQg
QlVTIGR1cmluZyBkbWEgcmVhZCwgQWx0aG91Z2ggdGhlDQo+ID4gcG9zc2liaWxpdHkgb2YgY2F1
c2luZyB0aGUgZG1hIHJlYWQgdG8gZmFpbCBpcyBuZXh0IHRvIG5vdGhpbmcsDQo+ID4gSG93ZXZl
ciwgaWYgZXJyb3ItaGFuZGxpbmcgaXMgbm90IGltcGxlbWVudGVkLCB3aGljaCBtYWtlcyB0aGUN
Cj4gPiBmZWF0dXJlDQo+ID4gc29tZXdoYXQgcmlza3kuDQo+ID4gDQo+ID4gQWRkIGFuIGVycm9y
LWhhbmRsaW5nIG1lY2hhbmlzbSBoZXJlLCByZXNldCB0aGUgc3RhdGUgbWFjaGluZSBhbmQNCj4g
PiByZS1yZWFkIHRoZSBkYXRhIHdoZW4gYW4gZXJyb3Igb2NjdXJzLg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IGJheWkgY2hlbmcgPGJheWkuY2hlbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+IENoYW5nZSBpbiB2MToNCj4gPiAgICAtUmVzZXQgdGhlIHN0YXRlIG1hY2hpbmUgd2hlbiBk
bWEgcmVhZCBmYWlscyBhbmQgcmVhZCBhZ2Fpbi4NCj4gPiAtLS0NCj4gPiAtLS0NCj4gPiAgIGRy
aXZlcnMvc3BpL3NwaS1tdGstbm9yLmMgfCAxNiArKysrKysrKysrKysrKystDQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktbXRrLW5vci5jIGIvZHJpdmVycy9zcGkvc3BpLW10
ay1ub3IuYw0KPiA+IGluZGV4IGQxNjc2OTlhMWE5Ni4uYzc3ZDc5ZGE5YTRjIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1tdGstbm9yLmMNCj4gPiArKysgYi9kcml2ZXJzL3NwaS9z
cGktbXRrLW5vci5jDQo+ID4gQEAgLTgwLDYgKzgwLDkgQEANCj4gPiAgICNkZWZpbmUgTVRLX05P
Ul9SRUdfRE1BX0ZBRFIJCTB4NzFjDQo+ID4gICAjZGVmaW5lIE1US19OT1JfUkVHX0RNQV9EQURS
CQkweDcyMA0KPiA+ICAgI2RlZmluZSBNVEtfTk9SX1JFR19ETUFfRU5EX0RBRFIJMHg3MjQNCj4g
PiArI2RlZmluZSBNVEtfTk9SX1JFR19DR19ESVMJCTB4NzI4DQo+ID4gKyNkZWZpbmUgTVRLX05P
Ul9TRkNfU1dfUlNUCQlCSVQoMikNCj4gPiArDQo+ID4gICAjZGVmaW5lIE1US19OT1JfUkVHX0RN
QV9EQURSX0hCCQkweDczOA0KPiA+ICAgI2RlZmluZSBNVEtfTk9SX1JFR19ETUFfRU5EX0RBRFJf
SEIJMHg3M2MNCj4gPiAgIA0KPiA+IEBAIC02MTYsNyArNjE5LDE4IEBAIHN0YXRpYyBpbnQgbXRr
X25vcl9leGVjX29wKHN0cnVjdCBzcGlfbWVtDQo+ID4gKm1lbSwgY29uc3Qgc3RydWN0IHNwaV9t
ZW1fb3AgKm9wKQ0KPiA+ICAgCQkJbXRrX25vcl9zZXRfYWRkcihzcCwgb3ApOw0KPiA+ICAgCQkJ
cmV0dXJuIG10a19ub3JfcmVhZF9waW8oc3AsIG9wKTsNCj4gPiAgIAkJfSBlbHNlIHsNCj4gPiAt
CQkJcmV0dXJuIG10a19ub3JfcmVhZF9kbWEoc3AsIG9wKTsNCj4gPiArCQkJcmV0ID0gbXRrX25v
cl9yZWFkX2RtYShzcCwgb3ApOw0KPiA+ICsJCQlpZiAocmV0KSB7DQo+ID4gKwkJCQlkZXZfZXJy
KHNwLT5kZXYsICJ0cnkgdG8gcmVhZA0KPiA+IGFnYWluXG4iKTsNCj4gPiArCQkJCW10a19ub3Jf
cm13KHNwLCBNVEtfTk9SX1JFR19DR19ESVMsIDAsDQo+ID4gTVRLX05PUl9TRkNfU1dfUlNUKTsN
Cj4gPiArCQkJCW1iKCk7IC8qIGZsdXNoIHByZXZpb3VzIHdyaXRlcyAqLw0KPiA+ICsJCQkJbXRr
X25vcl9ybXcoc3AsIE1US19OT1JfUkVHX0NHX0RJUywNCj4gPiBNVEtfTk9SX1NGQ19TV19SU1Qs
IDApOw0KPiA+ICsJCQkJbWIoKTsgLyogZmx1c2ggcHJldmlvdXMgd3JpdGVzICovDQo+ID4gKwkJ
CQl3cml0ZWwoTVRLX05PUl9FTkFCTEVfU0ZfQ01ELCBzcC0+YmFzZQ0KPiA+ICsgTVRLX05PUl9S
RUdfV1ApOw0KPiANCj4gIEZyb20gd2hhdCBJIHVuZGVyc3RhbmQsIHlvdSdyZSBpbnRyb2R1Y2lu
ZyBhIHdheSB0byBwZXJmb3JtIGENCj4gZmx1c2grcmVzZXQgb24NCj4gdGhlIGNvbnRyb2xsZXIu
DQo+IA0KPiBBdCB0aGlzIHBvaW50LCBJJ2QgcHV0IHRoYXQgaW4gYSBzZXBhcmF0ZSBmdW5jdGlv
biBsaWtlDQo+IGBtdGtfbm9yX3Jlc2V0KClgLCBhcw0KPiB0byBib3RoIGluY3JlYXNlIHJlYWRh
YmlsaXR5IGFuZCB0byBwb3NzaWJseSByZXVzZSBpdCBzb21ld2hlcmUgZWxzZQ0KPiBpbiB0aGUN
Cj4gZnV0dXJlLCBpZiBuZWVkZWQuDQo+IA0KPiBTbyB0aGlzIHdvdWxkIGJlY29tZS4uLg0KPiAN
Cj4gCQl9IGVsc2Ugew0KPiAJCQlyZXQgPSBtdGtfbm9yX3JlYWRfZG1hKHNwLCBvcCk7DQo+IAkJ
CWlmICh1bmxpa2VseShyZXQpKSB7DQo+IAkJCQkvKiBIYW5kbGUgcmFyZSBidXMgZ2xpdGNoICov
DQo+IAkJCQltdGtfbm9yX3Jlc2V0KHNwKTsNCj4gCQkJCW10a19ub3Jfc2V0dXBfYnVzKHNwLCBv
cCk7DQo+IAkJCQlyZXR1cm4gbXRrX25vcl9yZWFkX2RtYShzcCwgb3ApOw0KPiAJCQl9DQo+IAkJ
CXJldHVybiByZXQ7DQo+IAkJfQ0KPiANCj4gLi4ub3Igc29tZXRoaW5nIGFsaWtlIDotKQ0KPiAN
Cj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0KSGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHlvdXIg
Y29tbWVudHMhIEkgd2lsbCBmaXggaXQgaW4gdGhlIG5leHQgcGF0Y2guDQoNClJlZ2FyZHMsDQpC
YXlpDQo=
