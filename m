Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FD76E4735
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjDQMLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjDQMLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:11:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ED144B1;
        Mon, 17 Apr 2023 05:11:05 -0700 (PDT)
X-UUID: df602e7add1811eda9a90f0bb45854f4-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LWE1EhqtPNErfPpV4WU2RNON7q3YOaLSiDxKPERhe7o=;
        b=WHa13MbYWFMRcYnZBhyNSnThl/6FD9dR/e09TX81VKejT/ldnxwXcoK7LfMDUnJYW6b7PctvTG91jROJw8sSVp8CPGcNM5FtiMGqxJ1qw8D5Z/u80H7r3iFRQb3532Nrh2MYHZ+jwrXI0/4nVjbnMhJ0fjtdMJaSNeJXykWMFjo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8eaad456-9879-4d2a-9421-5a4a3bb2e473,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:dc103ceb-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: df602e7add1811eda9a90f0bb45854f4-20230417
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 764922635; Mon, 17 Apr 2023 20:10:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 20:10:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 20:10:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfPE5WkxBS9RZ7y9QPu9Zg0dQpqs6SfwWFqgNU4enYS/iCck9FknmVaF2DXnrnUQBo3WFf4Wj+AzYox+nVLAxh1msw3SPR/iFjliESJp+kODAqvMh9dNiHd2aXf+Qa8XL7eHVdQG8AFM9qeZv7qmNRO7Fl2JeKqk/XpiN3FPrHn1CE2PDOgAB4dUEUH5jzHNh+Twu1EY2MsP/sB8FwOaR55MZsneQSrGVWGFc1pe/Q1b1id3Sj15jk/H6bmvpRn+J0ZUTkEo1/tRrJ+6/IZFNDZPTXrTgsjARIKMf5NK1fIj8zp9L4Y/8rKSBVrWxtW44J4JRracsDK7ko7M22UV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWE1EhqtPNErfPpV4WU2RNON7q3YOaLSiDxKPERhe7o=;
 b=muf1+R9Gjh/9/EP8aHzFxuHMCGLDmA/UeUS/F9HDKKRe4kYn7qQdhaP0i0pGCOsNjOJ1RqxKavXUTqjktxpyoMYJt4wDodbDbBfQOepVazrke3Fvdyd8jStNjAOhH7ubEPDw5e/aMGrbPFL4WBqbtM3BFLY9hLj0oPtJi9vc3AwuA0CiG9WjeNPkXPN8kllbACAO2dFRR1Ms3JZkOZJk0SwJ+jVLfhQKidGW9rF+LLzeGXkD+eEtja/ajWm/UDAQsetngaIYmO0uLzZdYadfM80YPkzu74/cxIhyINwK4OUks5bmGgOIPLyNJ0BW1UN9rtclaTeKwfa3hOFVebWy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWE1EhqtPNErfPpV4WU2RNON7q3YOaLSiDxKPERhe7o=;
 b=Tz1Q8TRFwmyM3qreiKf+Fr0RjZB+IvffQCd+gW2Ml7PUe7euCr7/r9VBQssgobXeuaoHahqUBpGG/osVCMzo9zzVD2M7SEPZivs0AcAAdvnc6oQ1fdovSsUf3JmPE/VL2YTpU/FYsG0KN4wy5spqIFnbO3UVAA3vYolZJkfdsYw=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYUPR03MB7231.apcprd03.prod.outlook.com (2603:1096:400:357::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 12:10:38 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::30b:621:6d75:8337]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::30b:621:6d75:8337%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 12:10:38 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/6] media: mediatek: vcodec: add the definition of
 decoder status
Thread-Topic: [PATCH 2/6] media: mediatek: vcodec: add the definition of
 decoder status
Thread-Index: AQHZcPBLN3ssw2WwnUGYwM/J+PAJ7a8vO4CAgAAt2wA=
Date:   Mon, 17 Apr 2023 12:10:37 +0000
Message-ID: <110bf71508ccdc3e7bac47d29b9b08dec712a353.camel@mediatek.com>
References: <20230417054816.17097-1-yunfei.dong@mediatek.com>
         <20230417054816.17097-3-yunfei.dong@mediatek.com>
         <26ac9fbc-cc7a-7f25-0db5-30ede1068501@collabora.com>
In-Reply-To: <26ac9fbc-cc7a-7f25-0db5-30ede1068501@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYUPR03MB7231:EE_
x-ms-office365-filtering-correlation-id: 98bc13a0-3156-4e05-85fe-08db3f3cc14d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jxLC1JsI3B/aQZEOymmSxOYnX5xHXc25zvnnrlXwRnpXwQvAAVR78h0ERdHk2Wmnh3dGRGB3EVTHf+ppzZCUav6zbnytgqC6o/kGCx5XzHyMqmhK/EdkPBBjhZwSeBUv06KcwEi1yTTH2g4+J9aytWKQdW6PZ3AJ9JQ18hzqLNegFgvr4MNiuI3xFbwhN8cv57F3eS+G1vDgZrPsoG5idVugN0/DSXnfSVzHEjHcCw/i5sNunJU9HUo7VpgHx1hiTc1mWpzXVDOL+j+TUDTMko8hlXOsjmAUHipJNgRo8HGZS1zPzVDdayUW8FzYvsoYe8W/W2j1dbnbSezw0ZyQw5DESZBXGSfUjgMcd1qsdNYn+gR0K+kCN2F4rmBzA3h7rLOWtz9IjqQebJCUSJ9/vZ1aDKpg3WMGkO/MUPZ5POLZ0ybCd9U5AAdCWGILTC9KUHK5hoF3VJDw+o131AGBPAYxk71So3XmKrcz60220zPhypxUjYd9+3dCGopSkL+lWYfWCGxD0CR7a7oFMkoGHtx6Lj92yM/47dYZkzC51AOOjvoZgPYRqX+eoABEtQ3K8CdSSzJzE7dqa+qAO6zJAHOG1o94SrNStp+oTAtZaXael6GSOvxcoSh8VtGWHjdHXsvAlZJlRs18ITCeK9rBxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(478600001)(2616005)(186003)(26005)(38070700005)(110136005)(83380400001)(6486002)(6506007)(6512007)(316002)(71200400001)(54906003)(64756008)(66476007)(66946007)(66446008)(66556008)(4326008)(91956017)(76116006)(122000001)(38100700002)(8936002)(8676002)(5660300002)(7416002)(2906002)(41300700001)(86362001)(85182001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDI5QUZzakFiOEU4T054K2kvVUZDT05qbTVmSXpoa2RPUVBJcFVzZGtUYnVu?=
 =?utf-8?B?SGVsSkgrb1BnVGJxOGtLUHVYd3B2NnVQYkNlK3BYNncrUzh4Rmd1U2VmenBB?=
 =?utf-8?B?S2pBZldGajdiTkVSVGJHZ3RqTERhaXR5Mi90MjhrcThpTTh3d2dzMm5GQXQz?=
 =?utf-8?B?QmJZN2EvVEtZZGhBeE5jU1JVYmdsK3NnYjRJNXY3cUE5ckpRNUkwVXpQY3Nw?=
 =?utf-8?B?Z2VrMW1hRUpHVU41YUlDK2h2WU0xMTBjWUZXQjJ4Ti9aakRXcEYzc2tWVmFR?=
 =?utf-8?B?elE2cVRWZ3hMcVhuOExEK280MGpkeHVSM0dpeEVQUXd2U0pnWkdpRUNJNjFo?=
 =?utf-8?B?RmlxS3lzc2o1UW9CYldOTlZBTkhQUFBXME1xOHBjYXdCU1NYUEoycUhhNmhz?=
 =?utf-8?B?WW1ZeHd5cFZQUkJscitRRjdxZlJoRzFzdGpEM0tzUnlhZDR3Q3VFL0ExMHQ5?=
 =?utf-8?B?OEd6bDVhcWtSRktCc25WdDVORUQvbUxJdG9pZDBQeVA3US9YeXhPS2FIRlUx?=
 =?utf-8?B?d2JvUVpLZUFYc2RXdzJKcDAxbmVESXltU3EvSlRXOUpyTDhFRHR2SFcxTkhn?=
 =?utf-8?B?RUU0RzBCZG4yRVhqVTlOY2kramt3WTlsRjdsR1Q2VFJUUkN1bFB0YlorUjIx?=
 =?utf-8?B?WEVLUFZyUTNrMk04MExRZU5YU2docjVNMStzbzhLM1lCMnl1cVNLTWZsdnRu?=
 =?utf-8?B?TUhEb25IZTZBUXZ5WGVWVXE5RjhVcUhWQzUwSFB1NHZwQXo0WDZicVRzR2VU?=
 =?utf-8?B?czEvUnpzajZTdGdXbndRNGFyUFNsTjFyeHNuZmtqMW5rc1Y2YnZtRWg3alpN?=
 =?utf-8?B?WlpZVjN1K3c0VldyM21KRUJGZGFOT1VtK1RkRDJSSk9hakM5YTlpYzJZbVhG?=
 =?utf-8?B?WlJUekhqd2NIWGtFMTZYQ0o4TDFDY0ptU3JEbG1ROHJaQnBKUm5WU1NCRFMw?=
 =?utf-8?B?K3Y4RFhZcE5nblhjdTZKVTZvbkV0dEtScEZHV0Q0aitkZ3pVSU1rWnE0MmxP?=
 =?utf-8?B?cmVsMmsrRTRrblBBcmIvSVlmemFiU2p3YTJGSnkxS3dnSG9LV09oYkE3bHlO?=
 =?utf-8?B?bVdQM292UEpiTi9mY1FNK053cElxSFY5cVNkdmE5OWg1V2JPUkNSajlzWHkv?=
 =?utf-8?B?OGEra0x4dG81UlBwai9QQU83ZWRTMW9CbHU4RHd3TXhkSUFyS1h6WU0yNllX?=
 =?utf-8?B?MFhDRzFvbDdVYjBpYSs5SHVGeFhMMXQ5NjRUYTEzcTZkMlVQNkVvZDR6Y0lS?=
 =?utf-8?B?MWJmb0p3cldRY253bDJsNWhwU2xMUkQrNDdBbEl5M0RjTHBFMU5sSU9DSFNn?=
 =?utf-8?B?TVU0QmFZSTgvL0UxWkVtb2xjQnlKOTBRYm00QTViNEJMRitrTlJ3WGJNVTI5?=
 =?utf-8?B?OHd2aTViKzhtc1NsWjlnZHRZbjNZcEF6b0k1aGNMVDd0dW0vY2RYbjRXRDFX?=
 =?utf-8?B?WHNTeFNwSkRtcHR0TTdxTnpBajYyU0J4Y3pKQVJubmtYV2NmRHIwTnBoRk03?=
 =?utf-8?B?STBtTnJxelhzeVd0SHlTOXYxODZoNmJKRng1UVJhSy9IK1B5djlndzQ0dW1n?=
 =?utf-8?B?ZlRRaEhaZ2FaKzlwTFFVcmVOb3l2TFdMWG9CWEgxK2ROYzdQcmg3aW56RE95?=
 =?utf-8?B?dGdPaDdiZnpCNGd3SEpiRWQydlpDOHhzaEZIaVY3V05peXF2OEVsTnZ6b0cv?=
 =?utf-8?B?NHBvMG05YW42cy9vSUdtMHlkNFNHb21IZVBtTnRnUGtZdURJVmoyQkZzMno5?=
 =?utf-8?B?U0htRktOdG13T2RwN0RWNDJFdHVRRTB6YitSdi9zUFEvRmJXWG9pVFpEcmsx?=
 =?utf-8?B?SkM0Rmo3eUpGYTE1YjdCai9zanBxTTY4YURZa0lJcG5tZ2VYNWJnNVgwU2xr?=
 =?utf-8?B?VmZhVVUyVytCZzdON293MTV4ZHdhWndGRnlFRjdBak0zM1RZclhiU083ODZC?=
 =?utf-8?B?c2FYNldqbjQwNlEwbXJhY3VxOTlXYk9QYlJsZ3o3Y2c4eWFnNWlRR0hBcmxB?=
 =?utf-8?B?V2o1a0tTM1lCSlBnNUdCc2hyazBnRTdjRWExb1Q4aUhDZkJMTEJ2aXhTT0hG?=
 =?utf-8?B?ZHVUbzR5NWVrcEJmejl4WDZCcHd5UTZHWi9BOUY5U2d6ZHorY1JYWTV2cUw3?=
 =?utf-8?B?M0hLaGxld1IyaG1ZYjFIdDh5blkvb004b3drQTlzdXJZRGpSaFFKclpWQVFD?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC1065FD8AF1EE4DB4C32E9D5264E587@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bc13a0-3156-4e05-85fe-08db3f3cc14d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 12:10:37.6733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JW/30Anl6eQYqHREFDJMSWOtZmZ0EpGyX90ZKpFlAcRt9ztGqek2l+xEsotrinjIbQpfMpijocwX/Xudqcdu4/t+LxakpE3wsNZhdLR7xGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7231
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQoNCk9u
IE1vbiwgMjAyMy0wNC0xNyBhdCAxMToyNiArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVn
bm8gd3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gSWwgMTcvMDQvMjMgMDc6NDgsIFl1bmZlaSBEb25n
IGhhIHNjcml0dG86DQo+ID4gQWRkaW5nIHRoZSBzdGF0dXMgdXNlZCB0byBzZXBhcmF0ZSBkaWZm
ZXJlbnQgZGVjb2RlciBwZXJpb2QgZm9yDQo+ID4gY29yZSBoYXJkd2FyZS4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBZdW5mZWkgRG9uZyA8eXVuZmVpLmRvbmdAbWVkaWF0ZWsuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvdmRlY19t
c2dfcXVldWUuaCB8IDcNCj4gPiArKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9tZWRpYXRlay92Y29kZWMvdmRlY19tc2dfcXVldWUuaA0KPiA+IGIvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvdmRlY19tc2dfcXVldWUuaA0KPiA+IGluZGV4IGE1
ZDQ0YmM5N2MxNi4uMTk1MDhiZTA4NTY2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL3ZkZWNfbXNnX3F1ZXVlLmgNCj4gPiArKysgYi9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy92ZGVjX21zZ19xdWV1ZS5oDQo+ID4g
QEAgLTIxLDYgKzIxLDEzIEBAIHN0cnVjdCBtdGtfdmNvZGVjX2N0eDsNCj4gPiAgIHN0cnVjdCBt
dGtfdmNvZGVjX2RldjsNCj4gPiAgIHR5cGVkZWYgaW50ICgqY29yZV9kZWNvZGVfY2JfdCkoc3Ry
dWN0IHZkZWNfbGF0X2J1ZiAqbGF0X2J1Zik7DQo+ID4gDQo+ID4gKy8qIGN1cnJlbnQgY29udGV4
dCBpc24ndCB3b3JrICovDQo+ID4gKyNkZWZpbmUgQ09OVEVYVF9MSVNUX0VNUFRZICAgICAgICAg
ICAoMCkNCj4gPiArLyogcXVldWVkIHRvIHRoZSBjb3JlIHdvcmsgbGlzdCAqLw0KPiA+ICsjZGVm
aW5lIENPTlRFWFRfTElTVF9RVUVVRUQgICAgICAgICAgKDEpDQo+ID4gKy8qIGNvbnRleHQgZGVj
b2RlIGRvbmUgKi8NCj4gPiArI2RlZmluZSBDT05URVhUX0xJU1RfREVDX0RPTkUgICAgICAgICgy
KQ0KPiANCj4gSSB3b3VsZCBwcmVmZXIgYW4gZW51bWVyYXRpb24gaW5zdGVhZDsgeW91IGNhbiBr
ZWVwIHRoZSBkb2N1bWVudGF0aW9uDQo+IGZvciB0aG9zZQ0KPiBzdGF0dXMgc2lnbmFscyB3aXRo
IGtlcm5lbGRvYyBvbiB0aGUgbmV3IGVudW0uDQo+IA0KPiAvKioNCj4gICAqIGVudW0gY29yZV9j
dHhfc3RhdHVzIC0gQ29udGV4dCBkZWNvZGUgc3RhdHVzIGZvciBjb3JlIGhhcmR3YXJlDQo+ICAg
KiBAQ09OVEVYVF9MSVNUX0VNUFRZOiAgICBObyBidWZmZXIgcXVldWVkIG9uIENvcmUgSFcgKG11
c3QgYWx3YXlzDQo+IGJlIDApDQo+ICAgKiBAQ09OVEVYVF9MSVNUX1FVRVVFRDogICBCdWZmZXIg
cXVldWVkIHRvIHRoZSBjb3JlIHdvcmsgbGlzdA0KPiAgICogQENPTlRFWFRfTElTVF9ERUNfRE9O
RTogQ29udGV4dCBkZWNvZGUgZG9uZQ0KPiAgICovDQo+IGVudW0gY29yZV9jdHhfc3RhdHVzIHsN
Cj4gICAgICAgICBDT05URVhUX0xJU1RfRU1QVFkgPSAwLA0KPiAgICAgICAgIENPTlRFWFRfTElT
VF9RVUVVRUQsDQo+ICAgICAgICAgQ09OVEVYVF9MSVNUX0RFQ19ET05FLA0KPiB9DQo+IA0KPiBN
b3Jlb3Zlciwgc2luY2UgdGhpcyBpcyBhIHJhdGhlciBzaW1wbGUgYWRkaXRpb24sIHBsZWFzZSBz
cXVhc2ggdGhpcw0KPiBjb21taXQgd2l0aA0KPiBwYXRjaCBbMy82XSB3aGVyZSB5b3UgYWN0dWFs
bHkgYWxzbyBpbnRyb2R1Y2UgdGhlIGFjdHVhbCB1c2FnZSBvZiB0aGUNCj4gbmV3IGVudW0uDQo+
IA0KRml4ZWQgaW4gcGF0Y2ggdjIuDQoNCkJlc3QgUmVnYXJkcywNCll1bmZlaSBEb25nDQo+IENo
ZWVycywNCj4gQW5nZWxvDQo+IA0K
