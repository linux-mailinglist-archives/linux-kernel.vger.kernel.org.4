Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1212B654F99
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiLWLWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLWLWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:22:33 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4856578
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 03:22:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6sxt0s2HfvgM7k5noge3sa/eh1Ux3PUibEGzAzaZtbentJQFzQuwHpCY/XvBcf61QyKwolRtsHjaA9A875QrfdsXMeh4AeIri4PMV9Q8Q+MUliGBV0n17gR8ppwf/7xSTVqBu/0Uedmky1d/Pv8L1c3fAqhC9uQskj1ihaaxV1fnZW7qQcdeNP6octvJKM0wdyKPK/+I8AJ/SAwWpfKp8RJS8X/SzPUIogyCNYjHEYkIrKFRTf3SDXAn9xtRkHXYVVzKSoP/jtCaBTbo3afE9d7+6WEmnrcr7VJbSwcmnkil6DrT6S4zb3+AdqlPVh6jkDaiKDhX9549rVVWowr/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJF2UW8SaXBnAzSW9KgBc/INWzWC4QnKOmjTyI3DV1g=;
 b=Bs2RMjOpD3oe8jGm6RNZsCxdeU5WflB1161wmCh18CPnisWM6p+PH480Hm0Z4LnIsxYa4FJumBYaL0KH4pDWHsY5Kx+P9soE6RO9pEGf/4GT+URVRHE370B6ZQV+Y8kGhg8CXCCjGHEQjeeUpUYvJl2sVt3Zl93QGE8FkYKuv47n76rLtgf5Tyl4aqTGP+luuWfD3APCIzz9VNcoSdpcHn0/yjuQ2osu1mKT8oW21c8TVKjrXV/h23Eq11YTbDu/mJfaCL0WDfH9iNtC6zXtQ8LAaAL+NkMl5u/k+tfNhra8F3U6zhozNNLpoCy6igJaxpYuLtm2O2ql27HsZVgyRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJF2UW8SaXBnAzSW9KgBc/INWzWC4QnKOmjTyI3DV1g=;
 b=ASucqjS7CPip9cmraxftM558UOCpjT8kggJFbHbG/nTL7qEVdsz+fFDDGTva/TLp5SHbvbToLK4nd+jiVx9S0y3uhSdoZS3Qb0VxeJku/qQQUqImSr0vEN2KSh5t/hgdx5wrbDTUAdoxW8tC2kicmi1cg/4FEOjm28Zd0q6YOiBSc824VFoxFKM/wo0bV7ZlAE6kc9/02FdOPEBgBsf60MJr7DObvBVPE4odplCI0CwMwo2smVj5ZHS5XkNbfpN2LqiMemaaFLFArUaYXckjNd1Cd9+TEulFOj9Mx7+5cAUcsNcpz12Qk5xm0pq5RX3wKv+lm+Q4ovjEHmalJliSxA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB6803.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:478::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 11:22:30 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6180:97c1:d0ad:56a9]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6180:97c1:d0ad:56a9%2]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 11:22:30 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "manfred@colorfullife.com" <manfred@colorfullife.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "1vier1@web.de" <1vier1@web.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH 3/3] kernel/irq/manage.c: disable_irq() might sleep.
Thread-Topic: [PATCH 3/3] kernel/irq/manage.c: disable_irq() might sleep.
Thread-Index: AQHZEV/GZzBrhyYxKkmDnOs4JW58Ta52XjsAgAT44YCAAAfTgA==
Date:   Fri, 23 Dec 2022 11:22:30 +0000
Message-ID: <9593a9758731af70bdb6ad4f73af3ddc102571f1.camel@siemens.com>
References: <20221216150155.200389-1-manfred@colorfullife.com>
         <20221216150441.200533-1-manfred@colorfullife.com>
         <20221216150441.200533-3-manfred@colorfullife.com>
         <ca1972cec9724189b5a97a09069f3ee4f8c3f97c.camel@siemens.com>
         <1540f1d0-4fda-aaf4-acda-f5aaa6952a00@colorfullife.com>
In-Reply-To: <1540f1d0-4fda-aaf4-acda-f5aaa6952a00@colorfullife.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB6803:EE_
x-ms-office365-filtering-correlation-id: 3133c84c-36a6-474a-01ca-08dae4d7fac8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cz9m0n2OP8g6qTlWrpEL0/pic5KxgOH0xeSXXiu8cKibUdW1m9MDyBiufe/t3lAwMoOWLohJq8nZ4sfUGEbCmd7ahsjI4K3xQZ2bJCJD2W396Jn1WWjEktEOVEyFYzJ0IPSiqj/pd3KLNJ13LfJYSUaxHXiF7MLzOKvGvTGHd7tJMBZ70CNGzSTvPP3/CqXT2P4RIBD+3HTWIuIMX8HeI0rivkr3baGMeBoAvaBFXhFuz9WrsGiVqyvLMsdI1lTFSjEVMZOHvJZ1XWqvqJBb2uFTOzix7RCqBXR3ijW3/MKEntJizIxj1Afa+LGwyWT41fbwmnG9ksWFFIcC88D2JtERLWBQqyPf2sP+DjiWweEFFkAiEnGsYrMow4rbH1hwjFYurB7dsObxYhFcqF+2w9GYfPUUl8DATKXbzfKbA8pQFDZemYO25EbtPLWTgb4sAylhi8WkmK16WTHR+w+vEtpaTWSc0GLCtm3N14IHlDf9MVoS73Yi2OicDEqzyZTwFCQiz4IplMmgOaNbDlF4YeESLCTU3/aBktDtBJ/ZqnoYQ/dvuPY/rYWZFjIvknUf0E5Aha+C0Lpff+xEPJrMunJksRv3uzWp5ivT4KRIVxQbIUP4yizsmCvRe62ZrxtaDad3JDlk4hup0e5k9tOvFYiy5CEg6V/YN2ttDqhVnaxTCzZjoMes5KKCYZL513fABbosjbBl3QR2buutzBlWHripmWaHCGoX/0MtvCN0rPrrtoFiThSSwRPF8Ul+YAJxLDWVFNgbFG+tkI07i1dasQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199015)(83380400001)(2616005)(86362001)(316002)(15974865002)(122000001)(38100700002)(82960400001)(36756003)(38070700005)(8936002)(66446008)(2906002)(66946007)(110136005)(64756008)(66476007)(76116006)(54906003)(66556008)(4001150100001)(4326008)(5660300002)(91956017)(4744005)(8676002)(6512007)(41300700001)(186003)(55236004)(6506007)(26005)(478600001)(6486002)(71200400001)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnphN1BweFBwSzMzeVVKZ1JoKzd3OHVWMlh4YlRCYXVieVVLUFh1TUROYVNX?=
 =?utf-8?B?bDM4WCtKQ0wwNGdiU1BqZEZ3RmVSTGduZDI3VTFHZFdtWkdWb1dGSi9IcXBw?=
 =?utf-8?B?RkFKQ2xhU2djaDE3MjgxZ3JYZWFrVWlFeEhaVjRDZ3NrMlJYZ1BDYWgyaWw3?=
 =?utf-8?B?ZExOcVFwbCtZOVMrY3VGYVN4di8wRHkzT05UWGpaMFh5d2t2NVZPOWpaQVBX?=
 =?utf-8?B?KzVzZHU2eCtlU1A3SmZIYThmMlZsYzBvVEFuSTY3V0VnOERhV0x4RG9zTlhE?=
 =?utf-8?B?R09BcUJwNFVkeE9JZy9UZmd0MjcrUkQzZThNSk0zN0pyM2ZjY1pUNlZHcHFa?=
 =?utf-8?B?ZzlHSHlOSXNrUTFsb1VhVHRqNHVuSHJQOTgzSFhDMUtPNEtDc3haSVdtMXN3?=
 =?utf-8?B?clZNdXNOV2xmTEp1Sm9HczFTM3Z0dmdHT1YwZWoxWmFsY0VlYkpwNG9lT1RS?=
 =?utf-8?B?bHBDekNRKzlncC9vN2g4TUFHZC9EYUkrV3EzYVF4RjhDYlV3YlZmNUU1UUpL?=
 =?utf-8?B?eWpoWlJsbjFYbXVDT08xYWFMaDJEUThsTXBEem40ejRWQm5XMG1NcHcwN2E5?=
 =?utf-8?B?THc5KzBMQlJ3bXdpcEl1a0JtdkJlNXBoNkpiZUs5NFg2THpLbWlaYytINjRK?=
 =?utf-8?B?NFhqbVRKSEtFeGE0bHRBM0hyTE45MDVObDFJM1JaTWxQd3ZxSkxEOVIrQ3Jj?=
 =?utf-8?B?UmM4QUc0ZW5YRFlmcHRmdHU0Q0kyelJsWW5LcVI1cXRWV3FENEJPeEtNWVpY?=
 =?utf-8?B?SFZXT3BNdHVIaml6bUxCVXdNdUk4VnF5WklnbWFCUmxPSkFxd3YyWFhOM3kw?=
 =?utf-8?B?NmZxaWRKSGFlNFpaRW9JMWhKSTlUQXFEbCtyN292eHhONit5OFlUNUtqUGVj?=
 =?utf-8?B?eDVsc2xQUFFGZmxERVpkZW1nMDFtT201NmY2K0loN2w2ZURIVG93WEt5eUxI?=
 =?utf-8?B?NVJGeFlLc3BYSWd3bHlMOTdTMVR1REdYVVpWczVPSW1Hekd2aUtYNGgvbXdz?=
 =?utf-8?B?OFYrQ0o5ck9XZCs2K1F1MnV2MHlqMDhlUVdlbkhiU1NTYTVIcXJVUHQrRmdC?=
 =?utf-8?B?L2M1T2g0QmNxKzN4OG5iSEtFUlQzREV6bktuT016WTVPQnhieWdxb0FubzNh?=
 =?utf-8?B?SGx4NW45Y3dGTTJKRXpwQzh3emNhTkwrd2doRGRlSUFhZmNnOXUvek9GMzdF?=
 =?utf-8?B?YjMzUW56QnZkVTlzS2ljS3JoZ2kzdmRFTnd2Y2JXM0dQUmxFbXNoS2hBbm9T?=
 =?utf-8?B?S3ZWWncwTzh6djZBcW8rY3FEUllENmpmR2ZkRHhrUWVDYThoQzcyazdtSEtl?=
 =?utf-8?B?S052dUMzL1dsNGFaSHFSa29YWEdMdjh2bjdva0ZuWEhOK2R4NjBRODVZTUNp?=
 =?utf-8?B?cHR3QU82S1VSR1FCTjhiNVIwVWRBeU5SbXErTXM4dXNUQXFweUJJVjRiV1g1?=
 =?utf-8?B?M3JKOVYveDdyYnl6YW9wVG1mNFdERnJXMmdkZmkyWDVrVFppMlVFTWQ3WFNk?=
 =?utf-8?B?cU9sZXFsWXhtRVNlcXc4QzNqUXNpOFZGaUVyOVdueFRETlZlQ3lZOS94cjBJ?=
 =?utf-8?B?VlZILzRtenVaY0JiVXhBWkMzUDJSZG1FS3Niek1UTHBReEtST284cXZrWStY?=
 =?utf-8?B?bHhSZWNJUWZxM0RpdW4vMnQyK0taSVoydXhDZXoxMzlNanh3eGEyOXZaYzdH?=
 =?utf-8?B?ODlaSnYxaDRLQ2pHanZ1TTVleGc2Y0F4Q0QxMXZ2OXNWY1NQUlZvR29Tck12?=
 =?utf-8?B?ZDdZVVBlNlJoWjkyVkFSQ2VQbkNoR05ISnNHN2pVQ2hvYVdzZXhFZENERlEw?=
 =?utf-8?B?OTRHb2lXZm9McEM3NVVZWkc2TkY0T2c3QW9zektab3JzaDNTcE9IMkVrdmRi?=
 =?utf-8?B?a1ZUWWN1Sk4yTk13VGgvdzFpWFBtaUVLZkxJclcrOGZyL001bHJXRmplcHRk?=
 =?utf-8?B?RnErYnF1aUZvNjdkSVJiSTRRODY0WCtZaitMMjlBWFE5NXZjWHRRd00wcTNI?=
 =?utf-8?B?bThYMFJvOVpHYlZGVlpLYlZuNTRwY0lCVXIyRG1PdU1PUlYvREJTY3lpNzJs?=
 =?utf-8?B?UW52T2NIL3NEek5kVHlLK3ZrUDVLOStXWVRnTTZRQk5rbWZLb2s5cHMzVjJq?=
 =?utf-8?B?MzNyaVZDMlN5eTRMTFRFbTBuWXhlVlpNTnRkL3FmUkpYYkY5c0Q4R0pRanVp?=
 =?utf-8?Q?LD2OW1Cl+KkWfz3+KQZDUZA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C3BC4D982ED054FA428FFE28FE5683F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3133c84c-36a6-474a-01ca-08dae4d7fac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 11:22:30.2234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0SyChiBe6E6WLgeewf8rzMtg061kGCXz4wz3gjEYf/kaYfYN9R4puQLM6hwxkhmbeg6vEOE5oX2qi/Qz/7dpaHmyTss3+wtwLx6HNagayU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6803
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWFuZnJlZCwNCg0KT24gRnJpLCAyMDIyLTEyLTIzIGF0IDExOjU0ICswMTAwLCBNYW5m
cmVkIFNwcmF1bCB3cm90ZToNCj4gPiBJJ20gbm90IHN1cmUgYWJvdXQgdGhpcywgbGF0ZXN0IHdh
aXRfZXZlbnQoKSBpbnNpZGUNCj4gPiBzeW5jaHJvbml6ZV9pcnEoKQ0KPiA+IGhhcyBpdCBhbHJl
YWR5Lg0KPiA+IA0KPiA+ID4gwqAgwqDCoMKgwqDCoMKgwqDCoGlmICghX19kaXNhYmxlX2lycV9u
b3N5bmMoaXJxKSkNCj4gPiA+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3lu
Y2hyb25pemVfaXJxKGlycSk7DQo+ID4gPiDCoCDCoH0NCj4gDQo+IFRoYXQgaXMgdGhlIHdob2xl
IHBvaW50OiBtaWdodF9zbGVlcCgpIHNob3VsZCBiZSBhbHdheXMgY2FsbGVkLiBXZQ0KPiBhcmUg
DQo+IGNsYXJpZnlpbmcgYW4gQVBJIGRlZmluaXRpb24uIEV2ZXJ5b25lIHdobyB1c2VzIGRpc2Fi
bGVfaXJxKCkgZnJvbSANCj4gbm9uLXNsZWVwaW5nIGNvbnRleHQgc2hvdWxkIGdldCBhIHdhcm5p
bmcsIDEwMCUgb2YgdGhlIHRpbWUuDQo+IA0KPiBOb3QganVzdCB3aXRoaW4gc3luY2hyb25pemVf
aXJxKCkgaWYgdGhlcmUgaXMgYW4gYWN0aXZlIHRocmVhZGVkIGlycSANCj4gaGFuZGxlci4NCg0K
QXMgSSByZWFkIGl0LCBpdCB3aWxsIHdhcm4gYWxtb3N0IGFsd2F5cywgZXZlbiB3aXRob3V0IHRo
cmVhZGVkIGhhbmRsZXINCmNvbmZpZ3VyZWQsIG9ubHkgaW4gc29tZSBlcnJvciBjYXNlcyBpdCB3
aWxsIG5vdCB3YXJuLiBJJ20ganVzdA0KdGhpbmtpbmcgdGhhdCBkaXNhYmxlX2lycSgpIG1pZ2h0
IGJlIGluIGEgaG90IHBhdGggYW5kIHRoaXMgaXMgYmVpbmcNCmNoZWNrZWQgYW55d2F5IHR3byBj
YWxscyBkZWVwZXIuIEJ1dCBJIGRvbid0IGhhdmUgYSBzdHJvbmcgb3BpbmlvbiBvbg0KdGhhdCBh
bmQgaXQgbG9va3MgbGlrZSBpdCBoYXMgYmVlbiB0YWtlbiBpbnRvIG1tIHRyZWUgYWxyZWFkeS4N
Cg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
