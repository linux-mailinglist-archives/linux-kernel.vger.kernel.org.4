Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12605F52E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJEKtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJEKss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:48:48 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00071.outbound.protection.outlook.com [40.107.0.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6C92873E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 03:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eF/p84yKQeZnY1HH0PRRtw0mXFYRKxn+EC8/ynUYK+ArKEj4e4P7PEGgLXv5vtzEJbREzT3xdoVOzs5AH179CBAYsFEO1cOyCuXj9XBH1NAfJsMegBc+34Xg65fKtQ+UPhI0oNLWnpDI961P3DcsVL/NRpfhQfpNKF0lyNy9Ej4n65AqcmxPFhCz4/90nUkbQgF0IZkPi/xX1FTgGiCGT7rXUZVD6y6CHReoQMFNz0LJY1685Q2aLn1fsmCT/GzT6ecOpZtP+BVZnm3NZ+OznwwH1X13qwg1ezY/aPIPJ8HzRhXqzndatnBcMsd1Wiw/RayIhbMEXrf/3+u7mEvFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adjmjjzk1gvVfDiDPh64tVFHcrvcjeQoL68itdDzRfs=;
 b=LVHTLIJSe4XXOEYlJButDUbDZIjFXXZPbgk4v6x7J4Q/8fcB2W7HNNt5Zd9b+jp3vkJmotMvFOs4vw5zYWJ9ZBZ4r+/akakTDXnZe6nqXyLXuqAMqCDJNaYb3G8bkOolBBnvMrQz0WN99bl12A5vbekcgzt903ZhQckvge0s1uDu1VYI/9CNSUcMjNIets1arDE9yjkjUQp+GVflv3ckGIaO+RlxB5wK3ZKt6ksh8K0OUIQVRMVEq3Rrj0TULQyaKGYXuRpbcJQGETXkFEpT1KURk39ZoGziT5wHKysibbUMwUMjc5pP4I4QBKEV2e54vSnTSNmcO6uIiLdCaJZWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adjmjjzk1gvVfDiDPh64tVFHcrvcjeQoL68itdDzRfs=;
 b=nqLK+XTxgxouQipCAg5FeHPvz8ZIKEveG0R38qwRPGhrPHWppkqLwwTjURoufhcNiDeKT442y2qy3TrQK6SS738aut3fdslGPxFR37Net9RGK6zvjuHqIKvPkpE7szKcOgW7vOXKnTpsT2DN6u4iratWhpSyXHCJu8VEkvSVEPTm6DGQoNlpwSdyyN5XxkxmQw98R3dqw2aQ1aTiTWMPVw44svk3PTXMnMksjKadTtRWUDk+Fss5SDoFj+i++0s67yVEY3IN1ZuyBCDay6DbhVMaRjT9xbMY7vYX2LKb0i2+GW12j/xSt7H79oDJPyy5IAyAfvcIbYn9wyVHpWiFxQ==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by GVXPR10MB5912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 10:48:40 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e455:6769:fc57:e85f]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e455:6769:fc57:e85f%4]) with mapi id 15.20.5676.023; Wed, 5 Oct 2022
 10:48:40 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: RE: [PATCH v2] tty: n_gsm: avoid call of sleeping functions from
 atomic context
Thread-Topic: [PATCH v2] tty: n_gsm: avoid call of sleeping functions from
 atomic context
Thread-Index: AQHY2KfleP9QglhAv0+8Mjv6RBsYzw==
Date:   Wed, 5 Oct 2022 10:47:44 +0000
Message-ID: <DB9PR10MB58814C87D370B045EFB6682EE05D9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20220826193545.20363-1-pchelkin@ispras.ru>
 <20220827091353.30160-1-pchelkin@ispras.ru>
 <20220919113219.GA14632@duo.ucw.cz>
 <46a91b24-1c84-3ab8-2508-11720ee9ed5f@ispras.ru>
In-Reply-To: <46a91b24-1c84-3ab8-2508-11720ee9ed5f@ispras.ru>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2022-10-05T10:47:42Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=b63f5138-8cde-44c0-8051-96f91f48b3c5;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|GVXPR10MB5912:EE_
x-ms-office365-filtering-correlation-id: 3cb36505-2394-4643-0960-08daa6bf08ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: syvWA1ws1xy8AwgVAYqbu9hf71jQXFNp4SgQNgnFG3MrCxw8YgeqnLA/z8OhZlR684wi1grKErFWV1jph7ZPfn6VnmjlSJcfm7mujwRc6NXjKzjuueaQ2ZSqfUNcJD6YQ8y2/qyWh+d8JN6bEhr+XaZyBOBMeMlwaUBGZFnASxytnHd+PkYjqx2nKzyvmpRZ5QF3t/AlkjRywdrt09ytqLj4wTDbNrzz7ZWpoEMmxcz5rzuh5fLC8kAQJDLbXrTt6nRp816JFNKbotj6U5alWspKoRRq6ea7ErmgoAGiwQb+4qvChG/l4+zPIbQpD8I3D7Qk7wdu8K/sZL/G0eW+ZtnzT/MlwPbmwFTjNsrFupOFAznQDLxacIT5WSb4yiXO0q1gyqVeZbEr7Fs3tZeokCEJmJMsEinfFVcd5s+AmFgckDZVEKIENbwhbH05Lio7FOnaCS29z2LloZymY9ekfS0NFOwpdK8R4u7nzRJ0LFIf6OmrdQYpc4YmE5flpvYzqs6Apnf6bceX2SZfPBhPTQ1k1BBTFcXe0jzkgJXlcrfQainNhfTf64gZMAu2KvUmfkqMbcimsdBLNOO+CXk7FpNrHCIlD+VdvWbMbuLGC2Oeltwb5Rp7REkpyEInTYhxcbn4cnDEDHsqAowUyLg/7J7L/sRvBq2O/uwnU6hXIqNK2vQaDAo0Mpdiv2O1UbPT5wttuzQw8Pio7ooGrlbFOaC1gMGEUvf6yzXkFS7iSKdCkf3DUsuWdDsduszorFCpbFNAM3VJIks9n70LlTnB5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(52536014)(33656002)(26005)(8936002)(41300700001)(7696005)(6506007)(66946007)(76116006)(66476007)(66446008)(5660300002)(8676002)(4326008)(9686003)(64756008)(66556008)(316002)(38070700005)(38100700002)(82960400001)(122000001)(2906002)(55016003)(86362001)(186003)(83380400001)(71200400001)(478600001)(6916009)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVdQM2FmMDU0Tll5WHRqTDJ4UXkvVllkTEdHQzJFdHhsTzduYUpIOG1uamhL?=
 =?utf-8?B?K3dlbFhiSERmWGR4SDEzbUduamhoMWFpQXpuSmNwMWpMWng3ZURsT3pEbm51?=
 =?utf-8?B?NGl2QURFa1FTWXl1SzFoVG9WZGlXL2FFNTZmNStudnFFTVlnL0RTRUtpZERp?=
 =?utf-8?B?SENzZnQzWGo3ekxxTjB1N1BwWU5PZGdtRy9xTmg2Y3VDUzluRmxLMEp1Vm9w?=
 =?utf-8?B?NElUVDl2ZDFkYU8xUGZPbmk4WWVSREM0eVRRNWxsQnM5Wm9MV0k5U0VVMXhj?=
 =?utf-8?B?SHI0dXJwbkZVZXM5Tnp2VU1KOStuU003VkhDMTZxQ01iWTRHdGVveGFUVWNF?=
 =?utf-8?B?bmJMZE45NHlIeDBCREJIcVhsOTBJL2VoRHhYc0lPWXBWb1lnNjhzNElKS2dC?=
 =?utf-8?B?VGZPMFY5S0lVcGw5cE5aQXFaUXo2OCtVaGcyZWN5UUZaRzNMck9lZjF3SmJ3?=
 =?utf-8?B?ZEtXSHZEQTBLeUs5YnhkL2lid0tLOGF1T0tTR2FFZ090UVBZM3hGdlVmSTVX?=
 =?utf-8?B?bnUrK20wS3N2UTFTVTFicUNsbjZVVGR6NVFhNk0xbTNlVFczdmp5dDVaK0lJ?=
 =?utf-8?B?Mk5pT2FuZTlZTjkxamY3TGIrNm4xMGxJT3dvQVNDK1lwQnJ5akp2OUcrQUNN?=
 =?utf-8?B?eUNqejloUkNTd0JMN0NrbGdhVXpkRTR2bVlLZis4RGdFSUxLWCtJRmlYaktx?=
 =?utf-8?B?S0lVYVFtcWx0ak45TSsyMngxcjFaOGppR0tqbTFWaTRpcWJCMStkZGRHYkJY?=
 =?utf-8?B?MGFYZlNYMHl2cDFoNjZzN1BqSWprY0ZhUmRjWGpLczVDSnJCbmdnVXluT1du?=
 =?utf-8?B?SFVZU29lNHVIcWhlM1RtcUkydXNiVFo0MzlxR1N3bkNNM2MraFR3VjFVeXR6?=
 =?utf-8?B?WFZFbUtIdHV1Z1hkSEVITFR0MkE2TmRHRnhMeVZXTmltMVBDTit3bm54MlY5?=
 =?utf-8?B?VExPaWNxZlBWRG0rOHl2SmxaYmYyK3dveG16MTlRaGEwTVFJd2JJN1E3R3d0?=
 =?utf-8?B?MCtzU29MbEgvclFWUGJ2WGJoOUNmWlNKVEM2QS9YeUdBNkszcWlSNzZNMm5x?=
 =?utf-8?B?c3QvSkhyaFNhR1lwMjJseVZuTEpnaEE5RUh1Q29FeEVIemlWbFhOdWRtVlM3?=
 =?utf-8?B?NVY2eWM1ZlplY2NSaC91NWFET1oyOWgrRDhYMGdiOWJaTXVmWGhSUjd4VEty?=
 =?utf-8?B?eEFEaW9qU0NaRzNrajNvV09aaW9DOGNlclRDUGNKV3JqMWlQZTVYUmN0Wmdk?=
 =?utf-8?B?WkZQS3ZrMFRhbmR5OXRxaFhsdFVST3FkRW1kdFA5cUVQZ05WVWtWRERpODY5?=
 =?utf-8?B?ZC9LZ3pIY2x5WUJQZnkwYS84MldobE9ZY01rQ040c3dQelU3QjZsblFROFpG?=
 =?utf-8?B?KzNTQThCRkVpajJ0bTlQam5xWlJrNWhxTUZERWU4a1dFRnNZb3YyMWxxN0NK?=
 =?utf-8?B?Mlg5RXZHTTFaUjZwRTVBeG5YWGViZW1GZ2l3c3ZDR3hLNUs2bnZ5eEh2M2xY?=
 =?utf-8?B?ZVhHeFZrR1Bkd0F0aFBheWhJc2dhdFlWSXoxa0FDclpjekVOOFlZREFJV0o5?=
 =?utf-8?B?enEzVjNaU1IxdzdObEtsUTAxYktoSWZ2WTVmY2wxdzJQdEZTWFhSL2NOWlY3?=
 =?utf-8?B?Nm5SeVFqSUhuMGVEMXdsUmxoVGI0azNkUlJlTjRpZHpGUXBHTUpEK2tVL25z?=
 =?utf-8?B?Z3Rtd21TbE80WUV1M1h5eUNaUDNvZHdXa0RBUFVaU1JSbEdvNUthOW4xS25y?=
 =?utf-8?B?VHVGOWVITysvYStRZnRxRjByRnRvWXNZOWRFU3dJaEhPRms4UFlXeTlsR01V?=
 =?utf-8?B?WUZ4OFg4M2lCNU55MHY4QUhHYTZKK3ZRaWpISStwZk1IUEFRZ0RxU0hrdlVt?=
 =?utf-8?B?MmhBV3drYzNpVVRLN0FTclRSZnZDaVFMbXNWWnpZUnpZQkhhUWdFOGJHNE1H?=
 =?utf-8?B?dDN1aEVLY21XQjU0TW9zWmdqdGJKR0h4YjBXdUtWd1JMSzFaWFkvNnhKYTRP?=
 =?utf-8?B?U3NQWXMyMkJPQWZJVktyQUgwMVcwYmF4REZnVEpRQThtU1pMRTJVT3dmS0xr?=
 =?utf-8?B?RUFqMm1DeG9HNTZNTDc1NWlEWGJHb2s0eGFGL3VlODNVR1piaGlmY3cvc3kz?=
 =?utf-8?B?ejBvT1FIYmZBTE0ydHE1Mk9zd2trZXNTWHkzODFSSWNpTXJrM0hrVDBNbVdX?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb36505-2394-4643-0960-08daa6bf08ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 10:47:44.4836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jju3Ocwk2Jzhbs9CgmsloAEKZhEAIPdlcrDKtqkahhC/lMfxUUtEfKeLJYDg95okprS5IByib5+yhZNoWw/en+Lon6DtuaU7JtZGxVMdvoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5912
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiBzcGluX2xvY2tfaXJxc2F2ZSgmZ3NtLT50eF9sb2NrLCBmbGFncykgLy8gdGFrZW4gYSBz
cGlubG9jayBvbiBUWCBkYXRhDQo+ID4+ICAgY29uX3dyaXRlKC4uLikNCj4gPj4gICAgZG9fY29u
X3dyaXRlKC4uLikNCj4gPj4gICAgIGNvbnNvbGVfbG9jaygpDQo+ID4+ICAgICAgbWlnaHRfc2xl
ZXAoKSAvLyAtPiBidWcNCj4gPj4NCj4gPj4gQXMgZmFyIGFzIGNvbnNvbGVfbG9jaygpIG1pZ2h0
IHNsZWVwIGl0IHNob3VsZCBub3QgYmUgY2FsbGVkIHdpdGggDQo+ID4+IHNwaW5sb2NrIGhlbGQu
DQo+ID4+DQo+ID4+IFRoZSBwYXRjaCByZXBsYWNlcyB0eF9sb2NrIHNwaW5sb2NrIHdpdGggbXV0
ZXggaW4gb3JkZXIgdG8gYXZvaWQgdGhlIA0KPiA+PiBwcm9ibGVtLg0KPiA+Pg0KPiA+IA0KPiA+
IERvIHlvdSBoYXZlIGFueSBoaW50cyB3aHkgdGhpcyBtaWdodCBiZSBjb3JyZWN0Pw0KPiA+IA0K
PiANCj4gVGhlIHRoaW5nIHlvdSd2ZSBwb2ludGVkIG91dCBpcyBhY3R1YWxseSBpbnRlcmVzdGlu
Zy4gTXV0ZXggd29ya3Mgd2VsbCBpbg0KPiBnc21sZF93cml0ZSgpIGJ1dCBhcHBhcmVudGx5IEkn
dmUgbWlzc2VkIHRoZSBvdGhlciBjb250ZXh0cyBsaWtlIGluDQo+IGdzbWxkX3JlY2VpdmVfYnVm
KCkuDQoNClRoaXMgcGF0Y2ggYnJlYWtzIHBhY2tldCByZXRyYW5zbWlzc2lvbi4gQmFzaWNhbGx5
IHR4X2xvY2sgYW5kIG5vdyB0eF9tdXRleA0KcHJvdGVjdHMgdGhlIHRyYW5zbWlzc2lvbiBwYWNr
ZXQgcXVldWUuIFRoaXMgd29ya3MgZmluZSBhcyBsb25nIGFzIHBhY2tldHMNCmFyZSB0cmFuc21p
dHRlZCBpbiBhIGNvbnRleHQgdGhhdCBhbGxvd3Mgc2xlZXAuIEhvd2V2ZXIsIHRoZSByZXRyYW5z
bWlzc2lvbg0KdGltZXIgVDIgaXMgY2FsbGVkIGZyb20gc29mdCBJUlEgY29udGV4dCBhbmQgc3Bh
bnMgYW4gYWRkaXRpb25hbCBhdG9taWMNCmNvbnRleHQgdmlhIGNvbnRyb2xfbG9jayB3aXRoaW4g
Z3NtX2NvbnRyb2xfcmV0cmFuc21pdCgpLiBUaGUgY2FsbCBwYXRoDQpsb29rcyBsaWtlIHRoaXM6
DQpnc21fY29udHJvbF9yZXRyYW5zbWl0KCkNCiAgc3Bpbl9sb2NrX2lycXNhdmUoJmdzbS0+Y29u
dHJvbF9sb2NrLCBmbGFncykNCiAgICBnc21fY29udHJvbF90cmFuc21pdCgpDQogICAgICBnc21f
ZGF0YV9xdWV1ZSgpDQogICAgICAgIG11dGV4X2xvY2soJmdzbS0+dHhfbXV0ZXgpIC8vIC0+IHNs
ZWVwIGluIGF0b21pYyBjb250ZXh0DQoNCkkgZm91bmQgdGhpcyBpc3N1ZSB3aGlsZSBtZXJnaW5n
IG91ciBrZWVwIGFsaXZlIGZ1bmN0aW9uLg0KDQpMb25nIHN0b3J5IHNob3J0OiBUaGUgcGF0Y2gg
dmlhIG11dGV4IGRvZXMgbm90IHNvbHZlIHRoZSBpc3N1ZS4gSXQgaXMgb25seQ0Kc2hpZnRlZCB0
byBhbm90aGVyIGZ1bmN0aW9uLiBJIHN1Z2dlc3Qgc3BsaXR0aW5nIHRoZSBUWCBsb2NrIGludG8g
cGFja2V0DQpxdWV1ZSBsb2NrIGFuZCB1bmRlcmx5aW5nIHR0eSB3cml0ZSBtdXRleC4NCg0KSSB3
b3VsZCBoYXZlIGltcGxlbWVudGVkIHRoZSBwYXRjaCBpZiBJIGhhZCBtZWFucyB0byB2ZXJpZnkg
aXQuDQoNCkJlc3QgcmVnYXJkcywNCkRhbmllbCBTdGFya2UNCg==
