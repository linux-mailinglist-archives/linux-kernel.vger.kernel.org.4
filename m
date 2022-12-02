Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B607563FEBF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiLBDYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiLBDYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:24:04 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7433FD78E9;
        Thu,  1 Dec 2022 19:23:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liaJjYoEQIdm1DOnnaBezD+S//zXcKbTO7TEa8g+1H6hjt8UdINJqp31afnRT4Utm7CbwAje9DxXzQ7oUL/6mz3h8zefB191sBcwq8MTILXu9eOI4M1DRrbyM4IJo93pq2cSLPlRzHvQ89oy77VmsyEpn8R2PVAILF9cc8wpytOVvlMSkHJqg1vSEEJUb4AizrKSM7wxOG2dFWqhTiRY2XsQYSQ0IMUzmiA/LBt/MHXBJorpfPsumLgPW4Yi1DMIClzcVSlntSaxotaHc+++9gwjJg6IUxvYwwFtxnjK75CDf9r56HjJgo+oftEFxuEIJccx5pn58ZG1aVJA7IpgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0irfIj75EdJFoRakpoWW1zrWVc49oF79KRJGUI6pyY=;
 b=EJ1wV1TQ1DUQ+tO/Gncw/10IavlkVE3AzFQMuSKNP11C4V0ZwWneF61BK+xtxB/PGFVkQUOXwh+9YWKxos56TcsskdjVJfNzq6TfoEIa3DaljG/5YSujBx4+uX09pLAIe1IgKqILisRvjeb6G3ZrMK/4kQOwSOkU0r6AaQ3LFPF6cIj8ghR+Im4+ig1YhLLK9AJ8DA8F/CvKVRWcZuNGs6xi41s5wf8aj/iScPej6I7D+84YVHuv1NhyvZC1ok3VcFF2jn1XaEg5luvCw2mrHwJd2ReIQAxq+D681U0YuH/aDRBoe4HqW0vKMNLPxV5D3ms05HDZX6knzZw5yLclLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0irfIj75EdJFoRakpoWW1zrWVc49oF79KRJGUI6pyY=;
 b=KYnLvEUC61x88pjEI895/p9ri72WNRudTxsAp8TrNQQeDbzWhqgh3RfUw1Fn53E5MVUmAQpoQyA7zbOeod5R2Rep6/OxL1f3Jj8DH1kqhbty5CtDAqWRX1qE1q2FOsCkFtsR46xiA3ReDkdspBl9HWyrVDfoRkR96wulPbKsjMM=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB8804.eurprd04.prod.outlook.com (2603:10a6:20b:42f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 2 Dec
 2022 03:23:56 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::3cee:dfa4:ad62:235a]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::3cee:dfa4:ad62:235a%7]) with mapi id 15.20.5857.025; Fri, 2 Dec 2022
 03:23:55 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Frank Li <frank.li@nxp.com>
CC:     "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH v2 1/1] iio: imx8qxp-adc: fix irq flood when call
 imx8qxp_adc_read_raw()
Thread-Topic: [PATCH v2 1/1] iio: imx8qxp-adc: fix irq flood when call
 imx8qxp_adc_read_raw()
Thread-Index: AQHZBY1zOBGsM2ytGEuX+ljuaL0TeK5Z7qiA
Date:   Fri, 2 Dec 2022 03:23:55 +0000
Message-ID: <DB7PR04MB401084C620570D234A535EE990179@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221201140110.2653501-1-Frank.Li@nxp.com>
In-Reply-To: <20221201140110.2653501-1-Frank.Li@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AS8PR04MB8804:EE_
x-ms-office365-filtering-correlation-id: 8f96d2a3-54ba-40d5-da8d-08dad414a4f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j3Uh2J2m7ymsBtWELn2R4dIPFHysGMbbRu5Y0Mmcu0DhAjnJbC7t8CGH0IA2FYE1h2s9yjGY25AFg0eonQ6sJdbcr+F7CeOIrK4d4Fh9vQdlpK6bSgscRtAkJJVwrW5cm2PCgI3DrkN4k/ryOFFbiA5cpyYQUmdf/AOqWhFo9eA1fWowCIDoUAtNsxu+RHani6dk/kX8ylagCt3WrYQSH2AcqGHdDJSDar3ZkU+/8hskCIIp1/aA2IZKO5vqfySe+0XJXgxFZ5pYayiaH/J09JlQGDHlXLpGQnba+XS4QB2klOxTVAnZ1mZ2iuFiUEy+6AWSsmtAKoB0/iiyeErUzxdU38lH84O6toho9LSYpjRa/ARqBQg8DA45uRMyvarrEiWONJUDucvT0E+hU1qsOqPAxL4JGGMGKb0DfM+n9pkvqJ/KZx1xdL+mPLNC6rYfSE8hA9QkklYc5XGcwGywA6hNMQUi1c4f5XvH2jhmtLHEdC7ds/Up+OAmq4wIIdq+HBYx6jZndXUOLvn7VDgHqN4z/kEz4+uTlGRMPvOV1wRTOj15RZBRdfB2mYnXeN7xzyOKaXi6A+cm5Pl0nJFJf7snJV5hmChaUlqkt0BKNTI5A5MIezFhk35txrFo1FK417QhZf4hEB0VU6pyJJ7orwsVJ3WWVxFPsJCO6N8YUtpR/dN20Z4pdPr+HVPC6MGduFT0zNs4x7gX8JH/xWQviplzRSs2Ew0MQw1SAYvqx+Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199015)(7696005)(6506007)(83380400001)(86362001)(53546011)(478600001)(71200400001)(6862004)(316002)(6636002)(41300700001)(52536014)(55016003)(33656002)(5660300002)(54906003)(7416002)(8936002)(122000001)(76116006)(38100700002)(186003)(38070700005)(64756008)(66556008)(26005)(2906002)(4326008)(66476007)(8676002)(66946007)(66446008)(9686003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?STlCdXRxeDRQbW5XTlE3cUluSDJieksyeXJhbjdmamRQeWwwcU5yaW90Z3Ir?=
 =?gb2312?B?clo3VFdjajByazVZbzkxcGYxNXJxS0ZnMkNueWN5UGxIdGhRMVB6dlVTVm9o?=
 =?gb2312?B?TzJQaFNjcHQyeFovRTBmcnFQcnlTUmtuYlY1QUs5eUJSS1JCcDJBR1ZERzkx?=
 =?gb2312?B?NEFiTWRSb05PWDJsb3o3WXlaMVRyV1FiUnFtQWpaRDBvVlBIVzRMVC9WWG9J?=
 =?gb2312?B?KzdBcVBJa253NmFnTjRXMTRjOHUyd044cXhHQ2FySmtDWVQ3YWE4QURNZWFl?=
 =?gb2312?B?Yy9VVkZBbmNkQlNUZXpnV1VmbUhueDQwejRNcGNZbmJCRU5NNytsRHpSdk05?=
 =?gb2312?B?eEZYNVZkUVJlNmwxYWNYQnNUYkFnRDZibXJvZjQ0VVl3NlcvR0hqSWZLRlp2?=
 =?gb2312?B?dDlVdnhRREYvREFjT0pXS0hLWXBiRTRtMk9lRmlVTnorUEZkek9PSEZ4elJP?=
 =?gb2312?B?aEpWaVJuVkdJSktPT2R0YXVJTHJ5TWRxcENMeCtGSzN0T1NHVGU5eWQwNVpn?=
 =?gb2312?B?SWZnOXNpTWVQYXNiQTBFNkw1Q2IycThtK0hGUm5ES3RycDR0aVpMMlhWY3NF?=
 =?gb2312?B?N1ZHcmxwUU5kNlArcnNPOUxEQ1A5ZlRsaFhtZk4rem50UnllaHdkTExtQ3JG?=
 =?gb2312?B?a0cyZksrQ2pCWVRmZ1A2dGhKSlhjS2JhUVl2Yks0U21nWFFXOVBvL3U1Ymtk?=
 =?gb2312?B?eXZSZU5kVEhFQUhQK1dIVmtoTGxOUUZubVlWcXJYOXJ0K25YRVVsakRwTVUy?=
 =?gb2312?B?dC9CTE9sOFhwNDlsdWNKTTQ4ZFJ2NWUyRksrTnFTQkJySDBLTStnblZJZXM1?=
 =?gb2312?B?SXBXSkJEc3h3YVplMGZqM2p5U01OTm45U25IT0dtcXNOQTlNSDFWbVJDa1RD?=
 =?gb2312?B?UE8rV3VtVjVjeGt1TjhQOEZtMFh3cmoxaE9VS1lFSllVbTh3RDVLd1cxUnNX?=
 =?gb2312?B?dHc3MFd2aUdtczY4WHM0UjE3WWprSWc4Y0VMZ3RvSSt1MW4rU2tubHNycXMz?=
 =?gb2312?B?dFhHU2pkMlFjRG52a1E1V2ZsWHNHRCtvazVrK1ZSV0Y1VWhPQXdLWi8zeWtu?=
 =?gb2312?B?bkVualRRQmUzM09Hem12N3dXdFp1RGN1MXpaNDJJcjlVQnZ6bStmZXp1U0d6?=
 =?gb2312?B?U3NLZ1BNT0xHZjAwandhMWpsbFFLdHJiNndsU0xselpEdEZXSDl4dFQ2TFBt?=
 =?gb2312?B?RFhJMEh5WW81c1EyWVZidjdVQm9tL0pMZkY0aHNTaWdzYWZtdFN3c3FsaGwv?=
 =?gb2312?B?dm8zQ1dEVHhvRzByOHVieHcwSFZEOEJHUEI1SnQ4elU0Qmw4UHpIb09OdEg0?=
 =?gb2312?B?WnE2ZnhpWHljNmRib0ptUEtYVHZjZktUeXhmZ2NPQk8xaUZ0SElpRmxvY2xr?=
 =?gb2312?B?K3MrSllRazhPVTNWL3hNcmh5WmJObjFTcVIwa2ZPNWFoVVhQaDd4aWJ1bmFW?=
 =?gb2312?B?eENPN1drMnd6K055NzBjd2dodXViL2ZvSjRBQ1lCTUpET1VFYmRBTFdITmFh?=
 =?gb2312?B?WEJXdnp0OXZ1RG1CMDZIbFo0eVpScjFmV0hNUWhsQURRZWN6alZsanFPZ0pT?=
 =?gb2312?B?a1Jwc0dBL2RZMGU0UFdxSDN2d2dLU1N5Z1c3dXFNdjlUVlFjMGNkKzlTeTkw?=
 =?gb2312?B?ejliYXl1WHZPTmNFZkV4L2F0bWk4RlZ4Y1pnYTBTcU1Kd3dCNnJKY2J1U1FQ?=
 =?gb2312?B?Nmd2QXNuNy9SRDkvak1uSXY4dDN5alk4aHVMTXZ1UVYvMUM5U2dmQjdoRmNJ?=
 =?gb2312?B?NWZlTEZncEV1ckQ3Tm01R3hSbmRZRkVzbWRrdW1Bbmt1Tk8xWHZ2b09jUml5?=
 =?gb2312?B?a2JIMGFNRnVRNFJ1WE5INTgwSktrK2prRnJvSkdiVWs5QmkrUDBUWDJkcTE0?=
 =?gb2312?B?alNvQ0QxdVRvYTdmWEdJY3ErN0NsQXVMM3F1eWF1ZG9IalJyWU9LN0VFRUR0?=
 =?gb2312?B?ODF1U1pQeUVKalRSbXNMeVBLbFFvTXRyMFZ0UVZTaDhzVWVLN1RyWVptL2ox?=
 =?gb2312?B?VUIwS2FhczRLWXVUWWxVdjRlZ1FkWndKcDByRDBqZEQyV0dUZkxGTk1RckNF?=
 =?gb2312?B?alN2dGZscGN3RUc2NTdCVEdsdXJiV1ZqZVR4MUlpOGZjaUp2Rmt0MGNUK2JV?=
 =?gb2312?Q?A1lyIek14Qwwom0Qx8kvbJ/+9?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f96d2a3-54ba-40d5-da8d-08dad414a4f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 03:23:55.7731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYLy+lgt0P6GDtAdunX0TvmwL2EOq9lX8XNNLarbpqlX4o0V+TlLkYimXJ8U2ivMTC5FGQJ/VsgUMI20uYoljg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyMsTqMTLUwjHI1SAyMjowMQ0KPiBUbzogQm91Z2ggQ2hlbiA8
aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogY2FpLmh1b3FpbmdAbGludXguZGV2OyBmZXN0ZXZh
bUBnbWFpbC5jb207IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsNCj4gaW14QGxpc3RzLmxp
bnV4LmRldjsgamljMjNAa2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBsYXJz
QG1ldGFmb28uZGU7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGlu
dXgtaWlvQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7
IHNoYXduZ3VvQGtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHYyIDEvMV0gaWlvOiBpbXg4
cXhwLWFkYzogZml4IGlycSBmbG9vZCB3aGVuIGNhbGwNCj4gaW14OHF4cF9hZGNfcmVhZF9yYXco
KQ0KPiANCj4gaXJxIGZsb29kIGhhcHBlbiB3aGVuIHJ1bg0KPiAgICAgY2F0IC9zeXMvYnVzL2lp
by9kZXZpY2VzL2lpbzpkZXZpY2UwL2luX3ZvbHRhZ2UxX3Jhdw0KPiANCj4gaW14OHF4cF9hZGNf
cmVhZF9yYXcoKQ0KPiB7DQo+IAkuLi4NCj4gCWVuYWJsZSBpcnENCj4gCS8qIGFkYyBzdGFydCAq
Lw0KPiAJd3JpdGVsKDEsIGFkYy0+cmVncyArIElNWDhRWFBfQURSX0FEQ19TV1RSSUcpOw0KPiAJ
Xl5eXiB0cmlnZ2VyIGlycSBmbG9vZC4NCj4gCXdhaXRfZm9yX2NvbXBsZXRpb25faW50ZXJydXB0
aWJsZV90aW1lb3V0KCk7DQo+IAlyZWFkbChhZGMtPnJlZ3MgKyBJTVg4UVhQX0FEUl9BRENfUkVT
RklGTyk7DQo+IAleXl5eIGNsZWFyIGlycSBoZXJlLg0KPiAJLi4uDQo+IH0NCj4gDQo+IFRoZXJl
IGlzIG9ubHkgRklGTyB3YXRlcm1hcmsgaW50ZXJydXB0IGF0IHRoaXMgQURDIGNvbnRyb2xsZXIu
DQo+IElSUSBsaW5lIHdpbGwgYmUgYXNzZXJ0IHVudGlsIHNvZnR3YXJlIHJlYWQgZGF0YSBmcm9t
IEZJRk8uDQo+IFNvIElSUSBmbG9vZCBoYXBwZW4gZHVyaW5nIHdhaXRfZm9yX2NvbXBsZXRpb25f
aW50ZXJydXB0aWJsZV90aW1lb3V0KCkuDQo+IA0KPiBNb3ZlIEZJRk8gcmVhZCBpbnRvIGlycSBo
YW5kbGUgdG8gYXZvaWQgaXJxIGZsb29kLg0KPiANCj4gRml4ZXM6IDFlMjNkY2FhMWE5ZiAoImlp
bzogaW14OHF4cC1hZGM6IEFkZCBkcml2ZXIgc3VwcG9ydCBmb3IgTlhQIElNWDhRWFANCj4gQURD
IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZy
YW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KDQpUaGFua3MgZm9yIHRoZSBxdWljayBmaXguIFRo
ZSB0b3RhbCByZWFkIGNvdW50IGluIGlycSBoYW5kbGVyIGlzIGZpZm9fY291bnQgd2hpY2ggaXMg
cmVhZCBmcm9tIHJlZ2lzdGVyLCB0aGlzIGlzIHJlYXNvbmFibGUuDQoNClJldmlld2VkLWJ5OiBI
YWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQoNCkJlc3QgUmVnYXJkcw0KSGFpYm8gQ2hl
bg0KPiAtLS0NCj4gQ2hhbmdlIGZyb20gdjEgdG8gdjINCj4gIC0gbW92ZSBjb21wbGV0ZSgpIGFm
dGVyIHJlYWQgZmlmbw0KPiANCj4gDQo+ICBkcml2ZXJzL2lpby9hZGMvaW14OHF4cC1hZGMuYyB8
IDExICsrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9pbXg4cXhwLWFk
Yy5jIGIvZHJpdmVycy9paW8vYWRjL2lteDhxeHAtYWRjLmMgaW5kZXgNCj4gMzY3NzdiODI3MTY1
Li5mNWEwZmM5ZTY0YzUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9pbXg4cXhwLWFk
Yy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9pbXg4cXhwLWFkYy5jDQo+IEBAIC04Niw2ICs4
Niw4IEBADQo+IA0KPiAgI2RlZmluZSBJTVg4UVhQX0FEQ19USU1FT1VUCQltc2Vjc190b19qaWZm
aWVzKDEwMCkNCj4gDQo+ICsjZGVmaW5lIElNWDhRWFBfQURDX01BWF9GSUZPX1NJWkUJCTE2DQo+
ICsNCj4gIHN0cnVjdCBpbXg4cXhwX2FkYyB7DQo+ICAJc3RydWN0IGRldmljZSAqZGV2Ow0KPiAg
CXZvaWQgX19pb21lbSAqcmVnczsNCj4gQEAgLTk1LDYgKzk3LDcgQEAgc3RydWN0IGlteDhxeHBf
YWRjIHsNCj4gIAkvKiBTZXJpYWxpc2UgQURDIGNoYW5uZWwgcmVhZHMgKi8NCj4gIAlzdHJ1Y3Qg
bXV0ZXggbG9jazsNCj4gIAlzdHJ1Y3QgY29tcGxldGlvbiBjb21wbGV0aW9uOw0KPiArCXUzMiBm
aWZvW0lNWDhRWFBfQURDX01BWF9GSUZPX1NJWkVdOw0KPiAgfTsNCj4gDQo+ICAjZGVmaW5lIElN
WDhRWFBfQURDX0NIQU4oX2lkeCkgewkJCQlcDQo+IEBAIC0yMzgsOCArMjQxLDcgQEAgc3RhdGlj
IGludCBpbXg4cXhwX2FkY19yZWFkX3JhdyhzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0K
PiAgCQkJcmV0dXJuIHJldDsNCj4gIAkJfQ0KPiANCj4gLQkJKnZhbCA9IEZJRUxEX0dFVChJTVg4
UVhQX0FEQ19SRVNGSUZPX1ZBTF9NQVNLLA0KPiAtCQkJCSByZWFkbChhZGMtPnJlZ3MgKyBJTVg4
UVhQX0FEUl9BRENfUkVTRklGTykpOw0KPiArCQkqdmFsID0gYWRjLT5maWZvWzBdOw0KPiANCj4g
IAkJbXV0ZXhfdW5sb2NrKCZhZGMtPmxvY2spOw0KPiAgCQlyZXR1cm4gSUlPX1ZBTF9JTlQ7DQo+
IEBAIC0yNjUsMTAgKzI2NywxNSBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgaW14OHF4cF9hZGNfaXNy
KGludCBpcnEsIHZvaWQNCj4gKmRldl9pZCkgIHsNCj4gIAlzdHJ1Y3QgaW14OHF4cF9hZGMgKmFk
YyA9IGRldl9pZDsNCj4gIAl1MzIgZmlmb19jb3VudDsNCj4gKwlpbnQgaTsNCj4gDQo+ICAJZmlm
b19jb3VudCA9IEZJRUxEX0dFVChJTVg4UVhQX0FEQ19GQ1RSTF9GQ09VTlRfTUFTSywNCj4gIAkJ
CSAgICAgICByZWFkbChhZGMtPnJlZ3MgKyBJTVg4UVhQX0FEUl9BRENfRkNUUkwpKTsNCj4gDQo+
ICsJZm9yIChpID0gMDsgaSA8IGZpZm9fY291bnQ7IGkrKykNCj4gKwkJYWRjLT5maWZvW2ldID0g
RklFTERfR0VUKElNWDhRWFBfQURDX1JFU0ZJRk9fVkFMX01BU0ssDQo+ICsJCQkJcmVhZGxfcmVs
YXhlZChhZGMtPnJlZ3MgKyBJTVg4UVhQX0FEUl9BRENfUkVTRklGTykpOw0KPiArDQo+ICAJaWYg
KGZpZm9fY291bnQpDQo+ICAJCWNvbXBsZXRlKCZhZGMtPmNvbXBsZXRpb24pOw0KPiANCj4gLS0N
Cj4gMi4zNC4xDQoNCg==
