Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5E16805DF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbjA3GIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjA3GIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:08:11 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185A740EA;
        Sun, 29 Jan 2023 22:08:04 -0800 (PST)
X-UUID: 70f9259aa06411eda06fc9ecc4dadd91-20230130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OuTJCvqWB2m4s+GsxQvsjxcQnwCfEvqKnqdwIPnm3+s=;
        b=dtkqB7GR7zGBE08WrLjST3RsIe7zPXfcTWbEcL/tbF5rm8draFyJorUqsDwdADNo5qwSFo3j1aLHZx8gAHiz82m/AO53sHx7CMsj7oRkDejBeu8YEk5ir8cD5ZDgANamakgWO5S3P/sJ52qUGSUU3PZfnfHeCMe2f51rlhidqOM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:51f7bef7-4e83-4450-9610-984d40bca3aa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:060be1f6-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 70f9259aa06411eda06fc9ecc4dadd91-20230130
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 399561412; Mon, 30 Jan 2023 14:07:57 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 30 Jan 2023 14:07:55 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 30 Jan 2023 14:07:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEeeBa0l1tedku3G02MCi+eN2opIG9z7K4eWzUnw9O+t+N2ZEgBQzaSaRLCfAoRgb/XDT69pDM55zU65v/qwtAGSiQuh3vZDjhQ2X5AxLK7MgaEEYP+Oxa8aIv7avLt4qzoVdxxXd58y2ZKBqk+h4LOJ3eAoA1x2kRT0fAgfpBmhx15o08dC/uUzYnQBzgq1e8jTzuPyfCJH84QQywTZ8UxntnhXESeo/du02NVLaYPIa8+Q1og6eXXEqhd9rwUtO42HWbmA9ZKuKRtKhT2My8pDnc9Df0405EnIpt3DgBNbXbsF2kZpOylOIhGahFiBFEh/z4JDrKyBfLV8fybqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuTJCvqWB2m4s+GsxQvsjxcQnwCfEvqKnqdwIPnm3+s=;
 b=H13U1cxnApKKt1UXbEK91vqt7zno50oMmvC+ryytT/UdbTs0uklko4gBySdOljtjPGXlw93E1d/QCIVvzWaUs1Z+XUlTnrJs7+v18pgpBgGmYbgIkSZeBHmOrv48lI5NC43NrXlUF6S+ZRgk27PVQfgXy7G2IZVIlSWb9HQ94j9lR7gMvWDnumZaytwhrzTUdl16RFny44FrNm2hv889GEI44wqeyoksPnq98Z++5onaSCIRRQMry7lqA93vz1xzOrroGyqwCR4edb99lcfdBEkcCTchJApQTcKwTN6ayfnGhmj7BXSmUf42vMmS0wj3w9p4nrcct5CNy9dVWdkTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuTJCvqWB2m4s+GsxQvsjxcQnwCfEvqKnqdwIPnm3+s=;
 b=YPfIFwietgdLv1hGxhSFrFJ71RzChFc/G4IBATevZhOIpOt4Oz7T5fD1h+Qn+QcR9Unx+rBf40DuUitKyIUKpfou8+sx9cRXQTqYF/g1yQkqCn+UGsQ3GaIyMqQ3txECwNpKvT+a2WJHgIzu/+G4yS5YVu+P7/t4VFHoRpZBIbI=
Received: from SG2PR03MB6343.apcprd03.prod.outlook.com (2603:1096:4:17a::6) by
 SEZPR03MB7195.apcprd03.prod.outlook.com (2603:1096:101:e3::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Mon, 30 Jan 2023 06:07:52 +0000
Received: from SG2PR03MB6343.apcprd03.prod.outlook.com
 ([fe80::670e:3cb0:9b9:42d3]) by SG2PR03MB6343.apcprd03.prod.outlook.com
 ([fe80::670e:3cb0:9b9:42d3%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 06:07:52 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v5 02/12] media: platform: mtk-mdp3: add chip
 configuration header file
Thread-Topic: [PATCH v5 02/12] media: platform: mtk-mdp3: add chip
 configuration header file
Thread-Index: AQHZJxoE2tKZVIYBWE+Y0Al5Aj+L066sKPCAgAprOoA=
Date:   Mon, 30 Jan 2023 06:07:52 +0000
Message-ID: <1196d36a2988e1ac90a3b23ffd4315dab44a3777.camel@mediatek.com>
References: <20230113064104.22402-1-moudy.ho@mediatek.com>
         <20230113064104.22402-3-moudy.ho@mediatek.com>
         <068ee5ec-6863-2c1d-39a9-b18156d4e57d@xs4all.nl>
In-Reply-To: <068ee5ec-6863-2c1d-39a9-b18156d4e57d@xs4all.nl>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6343:EE_|SEZPR03MB7195:EE_
x-ms-office365-filtering-correlation-id: 113acb36-0574-485b-169b-08db02885291
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XQDTkq7Pn053ESZMg0vQxKf/SXpOuNetEOCj0/ExM0BDO5pnSzWgcvJuaURp1SY9DMOFISVK7bUlnU9/psYgTFU9qoYpAoAJdF8naKvAd40BVPL+J/PtYTlRu/a+iL4UqFkc1I/DlcTTs1KhaFHLH7BrI8dJ02onSRMJCWiE+LeiJkbmh19ZhmdjJTeqbu3u967Dv7CU/VGEcKzWi5lkZY7tejmGlkQ5IV1XUpZTdJ/g617zKXdVnsNR7wTIBwUMXJS0+7UoQwRQOxPu15tnA5m2LayQXdy/76qWU9cGfBQFyGK0DiEB45fxisdN1t69QGWovXSbju4vEpnNROn4HQ5bxlfEF0Nf1PRlEzhsIArx7De2o+9M2G+UeExPx7keEnMu6E9qEe5ilIvNxm6fjMPwZX+jOlw/eul+Keqh9W+CuIhqLCevYaV5phMCqH05fyNktsB8GZNo/BWzJztSF4mkMr2Xe0Np62byEXeHMUVEAU7ldYbg8kgr4ESgpLpByteyOxDTqaPQCRtsVf/FqdRUbfueuhD8BBBSAD41d3gz+CyDBaV6R+B8DZqADSjtPZRROMEzxe86vIGYbyphkI2lDoiJXgcLAvaetyT+zfZ301rlN5pxZv9tl9eCWLYO5Ik1iZxz+9f11i9hr1Inp71jvRf40SnBM/wz2bMJ+3/cj3Y9D3WeDeneFmRpkfm4sHhYbkO8YwHPwJahYOkvUD9EVs4cIYhNFJC3egTltic=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6343.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199018)(2906002)(5660300002)(38070700005)(86362001)(83380400001)(8936002)(41300700001)(36756003)(71200400001)(6486002)(478600001)(26005)(6512007)(53546011)(85182001)(186003)(6506007)(107886003)(2616005)(110136005)(66946007)(38100700002)(66556008)(66476007)(66446008)(64756008)(91956017)(4326008)(8676002)(76116006)(54906003)(122000001)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QS9zOHJ3QXZNNnpUQjJSU083Z09oamtkdXF6bGhiRGtuc0txT2QzV0RmcmpV?=
 =?utf-8?B?SkJVNUZ5KzROUVhPcWJlR1h6TzNkd3h4a2Z4aGsrNm1NTWt6RmJ2Ri9vNTVS?=
 =?utf-8?B?bGpVTWcxLy84RzZTWDJvZG1Va1hqYWFVQVhGY0x6SXRwVEVUKy93d0VyaTlF?=
 =?utf-8?B?bDlYdm9WUzdiYTJnN01YbW4zTDlwOVlybm9RL2NxN3VEUFJVVjJNUllNa01N?=
 =?utf-8?B?eGtZaVRodGR6Tng2TDUvcEVPbitzN2QzcE03SjN1L3NhdURhUTkxZXhVTDBD?=
 =?utf-8?B?OUdESFgwUFptS1hkM0RIMWw3elN6NHlTZnpPNTQ5LzBOcU9KK3cyZnU0ZEtB?=
 =?utf-8?B?Q1BQNHhDMW1aUE8rVUYrYUpxNDRocVhvT1Z2bjAzZlBiTzA2UXVTUDM1SmhU?=
 =?utf-8?B?RXdsaHNBTXprUkNlRnhsK2VSYytZZjVCRW8yNm4wQm1wQm4zVGpxVnhFTFp4?=
 =?utf-8?B?OWFGRmNmZnVqVzFpQTlLUzBpK2JZQWxRZFl3NkdTK2lzeDBJTUoxbkVaVW1L?=
 =?utf-8?B?TW9SS2FROHp6YWtJanlCT1NIYnVNcllVUHEwMlB0WHJ3TC82NzcxdjdidnU0?=
 =?utf-8?B?UkVYT04vTFJidFJCeEFYekJnZlgzRytLL0Vna1F5T00ycmxPSVRxYUdwelo3?=
 =?utf-8?B?YVBlUnFMOUF6SEdzT3JtTmlxUnE0dDJHYXBCUGx6SlFQT2IrOEQ5dW1ZQkRq?=
 =?utf-8?B?bjMyQTRJYzc0WHoxb0M1dkhUN051Yi9LNVUrRnBOa0pQR1RWSUZuSkxDeUww?=
 =?utf-8?B?UmRMdWQwa3dWSzkyMDNyVHloUW1xcTZrb3pncnppcHNHQ25qaGpRbFpiM1dw?=
 =?utf-8?B?RGlaZ3Jrb210UDZOaVloZEUyL3ptK0FpbkdpSTM1L1ZZbmpTc2ExNVg1OGtM?=
 =?utf-8?B?dGZWQ0RJWTR5NTBuM0JIeHFQV0ZvSjd5c0g0b1JmaU5OSEZKUlRleXVNczJL?=
 =?utf-8?B?and0SFFLcmE1MmJ2a3ZtVGFkUTZOTzhteVJPQVl5cDFkVVArSmljT05HZ1Yr?=
 =?utf-8?B?Y0NScldaYm9XelRkODFOQWsxS1FDTlVmdXhTVU9XaGpPSlRUamVYSUQ5eU1t?=
 =?utf-8?B?bU41VTdlTzhPbXFxV1lDb1RYcWRqUDJXZ2RuY0gvYUx3Zk1QbFF1a0hlN2pC?=
 =?utf-8?B?MVRxVlRMZ01TTkE4U01YYjkwY2hjUG00aHNJaEN6aGVYMVBLVS94R3FzN0ww?=
 =?utf-8?B?WlpVdnRFY0ZieU11MUlQYjhIRDZOSEkzOUpVMDdrYnRJU3hXcWs0ZzJlN0FR?=
 =?utf-8?B?d3BuM2ttNzVYTnorV3V3b1dsK0c0YVZWZjRQcFNJNGZXVnVPNThIQmEwMzBk?=
 =?utf-8?B?dm40K0lZcnZGM2FZUGRiVTQwWTk4anBGeGc4b3BncnJIMnprRjZnbUl6ZFRP?=
 =?utf-8?B?YktIeU8rNVFFN0FYOTF0K3ZDOVlQQTYybzNXUUZXeHRvVzlpaDJjNlkzNDAz?=
 =?utf-8?B?citXNlVaSk1URG40MzJQeVRHVlU2OW9mWHV6cWZ4WTdoT2JzaTVRR2tTc0dP?=
 =?utf-8?B?c1h1K0NXbEhGcEF3UUJTNmM3VHlVV3lLbGZEcWd0dW9qSm00S2xaN2JRRHRl?=
 =?utf-8?B?QjhMVnJkS2ZLVmpTQ2ZMSVFLWVJ0MlF1VG9TRS9rU0lqMnpGYXRoWWE2c3pa?=
 =?utf-8?B?MWZVQy9zMTdQOFdsbXR3S2ZtMVZYTG9aa2hCS041Tm9xM2dULytTQjVtejc1?=
 =?utf-8?B?Q3NMVTdJd0dWT3M1ZHdEMFpuZ0RseWltTFFyNWpvRHRUc213ajl6Z1E0VW5z?=
 =?utf-8?B?Z0JFN3hYWTJqSzFibGNiTDdTS2FCdnRHUFVkNDQ0bVB3V3V4RnQrZ096TWxx?=
 =?utf-8?B?dUs0K2hTV0orazcyZVlteHltTmxYbjBuQU50MVlBZDBXTHBuZUhVTjNBWXdy?=
 =?utf-8?B?MFBNQVFOd3Y2WThwMHZWL2VmUkxzOGFHbjJQamJObi9vajltOExRWGRFYXBR?=
 =?utf-8?B?d2hiNE03eW9tNWVvUnFpdThBb1ExNldRQklZNGhkbElteU5yTURvQnVSV3VR?=
 =?utf-8?B?N3pJYk0zVStjTUpxQlRBalgvY3ZEWmpZOUZibTU5bkZrZUJzUWczNExuVGFD?=
 =?utf-8?B?bmVCQkQyc0VkeGJwS0MweExKWHBlRjBVd0pnVE1UbTl1WTd3dm1qamlvbk9a?=
 =?utf-8?B?bGlxQy9kQVdJZFNINFFibUdsTFFBaTJDRkJmWGJEY3pUSE1aWVBhOGhoMzQr?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F446542475548344ACA3B01B95C2BA5A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6343.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113acb36-0574-485b-169b-08db02885291
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 06:07:52.6480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyNy05diKGdOrvzfljhRAEI+bySXDx3b36DvRg3x+/MRld+ENlpTzrTipWnPjtDb3os+cBQ49JNkWcVZJveWZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7195
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTIzIGF0IDE2OjAxICswMTAwLCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+
IE9uIDEzLzAxLzIwMjMgMDc6NDAsIE1vdWR5IEhvIHdyb3RlOg0KPiA+IEluIG9yZGVyIHRvIGJl
IGNvbXBhdGlibGUgd2l0aCBtb3JlIE1EUDMgY2hpcCBzZXR0aW5ncyBpbiB0aGUNCj4gPiBmdXR1
cmUsDQo+ID4gbW92ZSB0aGUgY2hpcC1yZWxhdGVkIGNvbmZpZ3VyYXRpb24gdG8gYSBzZXBhcmF0
ZSBoZWFkZXIgZmlsZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNb3VkeSBIbyA8bW91ZHku
aG9AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vbWVkaWF0ZWsvbWRwMy9tdDgxODMv
bWRwMy1wbGF0LW10ODE4My5oICAgfCAzNQ0KPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAg
Li4uL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRrLW1kcDMtY29yZS5jICAgIHwgMjcgKystLS0t
LS0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCAyNSBkZWxl
dGlvbnMoLSkNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9tZWRpYXRlay9tZHAzL210ODE4My9tZHAzLXBsYXQtbXQ4MTgzLmgNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ODE4My9t
ZHAzLXBsYXQtDQo+ID4gbXQ4MTgzLmggYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVr
L21kcDMvbXQ4MTgzL21kcDMtcGxhdC0NCj4gPiBtdDgxODMuaA0KPiA+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4zMDg0ZjYyZTdkZjUNCj4gPiAtLS0gL2Rl
di9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210
ODE4My9tZHAzLXBsYXQtDQo+ID4gbXQ4MTgzLmgNCj4gPiBAQCAtMCwwICsxLDM1IEBADQo+ID4g
Ky8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgKi8NCj4gPiArLyoNCj4g
PiArICogQ29weXJpZ2h0IChjKSAyMDIyIE1lZGlhVGVrIEluYy4NCj4gPiArICogQXV0aG9yOiBQ
aW5nLUhzdW4gV3UgPHBpbmctaHN1bi53dUBtZWRpYXRlay5jb20+DQo+ID4gKyAqLw0KPiA+ICsN
Cj4gPiArI2lmbmRlZiBfX01EUDNfUExBVF9NVDgxODNfSF9fDQo+ID4gKyNkZWZpbmUgX19NRFAz
X1BMQVRfTVQ4MTgzX0hfXw0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtZHBfcGxh
dGZvcm1fY29uZmlnIG10ODE4M19wbGF0X2NmZyA9IHsNCj4gPiArCS5yZG1hX3N1cHBvcnRfMTBi
aXQJCT0gdHJ1ZSwNCj4gPiArCS5yZG1hX3JzejFfc3JhbV9zaGFyaW5nCQk9IHRydWUsDQo+ID4g
KwkucmRtYV91cHNhbXBsZV9yZXBlYXRfb25seQk9IHRydWUsDQo+ID4gKwkucnN6X2Rpc2FibGVf
ZGNtX3NtYWxsX3NhbXBsZQk9IGZhbHNlLA0KPiA+ICsJLndyb3RfZmlsdGVyX2NvbnN0cmFpbnQJ
CT0gZmFsc2UsDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZA0KPiA+IG10ODE4M19tZHBfcHJvYmVfaW5mcmFbTURQX0lORlJBX01BWF0gPSB7DQo+
ID4gKwlbTURQX0lORlJBX01NU1lTXSA9IHsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgz
LW1tc3lzIiB9LA0KPiA+ICsJW01EUF9JTkZSQV9NVVRFWF0gPSB7IC5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE4My1kaXNwLQ0KPiA+IG11dGV4IiB9LA0KPiA+ICsJW01EUF9JTkZSQV9TQ1Bd
ID0geyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtc2NwIiB9DQo+ID4gK307DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgY29uc3QgdTMyIG10ODE4M19tdXRleF9pZHhbTURQX01BWF9DT01QX0NP
VU5UXSA9IHsNCj4gPiArCVtNRFBfQ09NUF9SRE1BMF0gPSBNVVRFWF9NT0RfSURYX01EUF9SRE1B
MCwNCj4gPiArCVtNRFBfQ09NUF9SU1owXSA9IE1VVEVYX01PRF9JRFhfTURQX1JTWjAsDQo+ID4g
KwlbTURQX0NPTVBfUlNaMV0gPSBNVVRFWF9NT0RfSURYX01EUF9SU1oxLA0KPiA+ICsJW01EUF9D
T01QX1REU0hQMF0gPSBNVVRFWF9NT0RfSURYX01EUF9URFNIUDAsDQo+ID4gKwlbTURQX0NPTVBf
V1JPVDBdID0gTVVURVhfTU9EX0lEWF9NRFBfV1JPVDAsDQo+ID4gKwlbTURQX0NPTVBfV0RNQV0g
PSBNVVRFWF9NT0RfSURYX01EUF9XRE1BLA0KPiA+ICsJW01EUF9DT01QX0FBTDBdID0gTVVURVhf
TU9EX0lEWF9NRFBfQUFMMCwNCj4gPiArCVtNRFBfQ09NUF9DQ09SUjBdID0gTVVURVhfTU9EX0lE
WF9NRFBfQ0NPUlIwLA0KPiA+ICt9Ow0KPiANCj4gSSBhbSByZWFsbHkgbm90IGtlZW4gb24gc3Rv
cmluZyB2YXJpYWJsZSBkZWNsYXJhdGlvbnMgaW4gYSBoZWFkZXIuDQo+IFRoaXMgYmVsb25ncw0K
PiBpbiBhIHNvdXJjZS4NCj4gDQo+IFdoYXQgeW91IHR5cGljYWxseSBkbyBpcyBwdXQgdGhpcyBp
biBhIHNvdXJjZSB0b2dldGhlciB3aXRoIHRoZQ0KPiBkZWNsYXJhdGlvbg0KPiBvZiB0aGUgbXQ4
MTgzX21kcF9kcml2ZXJfZGF0YSBzdHJ1Y3QgZm9yIHRoZSBjaGlwIGNvbmZpZywgYW5kIGp1c3QN
Cj4gZXhwb3J0IHRoYXQNCj4gdG9wLWxldmVsIHN0cnVjdCBhcyBhbiBleHRlcm4uDQo+IA0KPiBB
biBleGFtcGxlIG9mIGhvdyB0byBkbyB0aGlzIGlzDQo+IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
dmVyaXNpbGljb24vaW14OG1fdnB1X2h3LmMuDQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gCUhhbnMN
Cj4gDQoNCkhpIEhhbnMsDQoNClRoYW5rcyBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIGFkdmlzZSwg
SSdsbCBtYWtlIGNvcnJlc3BvbmRpbmcNCmFkanVzdG1lbnRzIGluIHRoZSBuZXh0IHZlcnNpb24u
DQoNClNpbmNlcmVseSwNCk1vdWR5DQoNCj4gPiArKyNlbmRpZiAgLyogX19NRFAzX1BMQVRfTVQ4
MTgzX0hfXyAqLw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlh
dGVrL21kcDMvbXRrLW1kcDMtY29yZS5jDQo+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21l
ZGlhdGVrL21kcDMvbXRrLW1kcDMtY29yZS5jDQo+ID4gaW5kZXggMmQxZjZhZTlmMDgwLi42NTgw
MzdkMDYyNTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRl
ay9tZHAzL210ay1tZHAzLWNvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
bWVkaWF0ZWsvbWRwMy9tdGstbWRwMy1jb3JlLmMNCj4gPiBAQCAtMTIsMzMgKzEyLDEwIEBADQo+
ID4gICNpbmNsdWRlIDxsaW51eC9yZW1vdGVwcm9jLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9y
ZW1vdGVwcm9jL210a19zY3AuaD4NCj4gPiAgI2luY2x1ZGUgPG1lZGlhL3ZpZGVvYnVmMi1kbWEt
Y29udGlnLmg+DQo+ID4gKw0KPiA+ICAjaW5jbHVkZSAibXRrLW1kcDMtY29yZS5oIg0KPiA+ICAj
aW5jbHVkZSAibXRrLW1kcDMtbTJtLmgiDQo+ID4gLQ0KPiA+IC1zdGF0aWMgY29uc3Qgc3RydWN0
IG1kcF9wbGF0Zm9ybV9jb25maWcgbXQ4MTgzX3BsYXRfY2ZnID0gew0KPiA+IC0JLnJkbWFfc3Vw
cG9ydF8xMGJpdAkJPSB0cnVlLA0KPiA+IC0JLnJkbWFfcnN6MV9zcmFtX3NoYXJpbmcJCT0gdHJ1
ZSwNCj4gPiAtCS5yZG1hX3Vwc2FtcGxlX3JlcGVhdF9vbmx5CT0gdHJ1ZSwNCj4gPiAtCS5yc3pf
ZGlzYWJsZV9kY21fc21hbGxfc2FtcGxlCT0gZmFsc2UsDQo+ID4gLQkud3JvdF9maWx0ZXJfY29u
c3RyYWludAkJPSBmYWxzZSwNCj4gPiAtfTsNCj4gPiAtDQo+ID4gLXN0YXRpYyBjb25zdCBzdHJ1
Y3Qgb2ZfZGV2aWNlX2lkDQo+ID4gbXQ4MTgzX21kcF9wcm9iZV9pbmZyYVtNRFBfSU5GUkFfTUFY
XSA9IHsNCj4gPiAtCVtNRFBfSU5GUkFfTU1TWVNdID0geyAuY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxODMtbW1zeXMiIH0sDQo+ID4gLQlbTURQX0lORlJBX01VVEVYXSA9IHsgLmNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRpc3AtDQo+ID4gbXV0ZXgiIH0sDQo+ID4gLQlbTURQX0lO
RlJBX1NDUF0gPSB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1zY3AiIH0NCj4gPiAt
fTsNCj4gPiAtDQo+ID4gLXN0YXRpYyBjb25zdCB1MzIgbXQ4MTgzX211dGV4X2lkeFtNRFBfTUFY
X0NPTVBfQ09VTlRdID0gew0KPiA+IC0JW01EUF9DT01QX1JETUEwXSA9IE1VVEVYX01PRF9JRFhf
TURQX1JETUEwLA0KPiA+IC0JW01EUF9DT01QX1JTWjBdID0gTVVURVhfTU9EX0lEWF9NRFBfUlNa
MCwNCj4gPiAtCVtNRFBfQ09NUF9SU1oxXSA9IE1VVEVYX01PRF9JRFhfTURQX1JTWjEsDQo+ID4g
LQlbTURQX0NPTVBfVERTSFAwXSA9IE1VVEVYX01PRF9JRFhfTURQX1REU0hQMCwNCj4gPiAtCVtN
RFBfQ09NUF9XUk9UMF0gPSBNVVRFWF9NT0RfSURYX01EUF9XUk9UMCwNCj4gPiAtCVtNRFBfQ09N
UF9XRE1BXSA9IE1VVEVYX01PRF9JRFhfTURQX1dETUEsDQo+ID4gLQlbTURQX0NPTVBfQUFMMF0g
PSBNVVRFWF9NT0RfSURYX01EUF9BQUwwLA0KPiA+IC0JW01EUF9DT01QX0NDT1JSMF0gPSBNVVRF
WF9NT0RfSURYX01EUF9DQ09SUjAsDQo+ID4gLX07DQo+ID4gKyNpbmNsdWRlICJtdDgxODMvbWRw
My1wbGF0LW10ODE4My5oIg0KPiA+ICANCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfbWRw
X2RyaXZlcl9kYXRhIG10ODE4M19tZHBfZHJpdmVyX2RhdGEgPSB7DQo+ID4gIAkubWRwX3Byb2Jl
X2luZnJhID0gbXQ4MTgzX21kcF9wcm9iZV9pbmZyYSwNCj4gDQo+IEFwcHJlY2lhdGUgZm9yIHRo
ZSB0aW1lIGFuZCBhZHZpY2UsIEknbGwgbWFrZSBjb3JyZXNwb25kaW5nIGFkanVzdCBpbg0KPiB0
aGUgbmV4dCB2ZXJzaW9uLg0K
