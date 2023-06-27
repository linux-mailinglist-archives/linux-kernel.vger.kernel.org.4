Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F182F73F98F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjF0KCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjF0KBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:01:46 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2057.outbound.protection.outlook.com [40.107.9.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADC93C0E;
        Tue, 27 Jun 2023 02:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvGbQz8tDPPTVL0/k5qSVF/+FCf1r0AK6nu6/rAwJ+ADzfKubZ4HpFbvPCO5wyr2thkRtYNt/es8c5q1ul+apfGUsB+4tdgnzXd3wnpFIGedPuaN4rw4Y6gtiugvHj6xuHkPU6Zz88yH25MRe4CX7d0NASlK6lgNnqUkVRypD/V3mepbCb2+p9seLDFj+2UatheeNZ/xw9XZLDWcKtyS0y29toOZomrCyyQcS4/iCc4odVEIfiQ9/kVwS+l0tnv5u4XRMbwQ69yBkjhwOkuewvYUptyBePxNQEriqItJgB1W4qdod6IjLgHWlIuBbfjWECaMpiD/TTKk7pG6Lrag+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ji+1ebQePYZGlUUiMgbMcK49MhW/wjsnL60+P2UiG4Q=;
 b=B1KamYQrmmPBRoqsfR+Tp3BPRsvhijf0e/Gy60NeObjsc3RSfWCm9uxaEkjX3W4sgr3uD4Q2HKsgbUn2kb3dknzaLXieHcr2MK5sEUXFHY07bhFnwmKlHxEVhMvdXOca75JJcPnLaAVje4BS8hmcVgVQBD1ZFQFJLTloZ6D/y2tUwfXnvsYsGPUpfbodNJNCStl/HiupHA956+O4FIQXXN4hU3Zb8SoF2/rHOJWkR8YRwzG7nKOgOIJZ/Cj1/pfIPBYNvmSbIRJFqD/cr1vpJnXDESVHXlDCQl0M2iQKZr1jPn76136jNjbtOoX8PW0w+BRsnnfeBcikBeTLW2V8rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji+1ebQePYZGlUUiMgbMcK49MhW/wjsnL60+P2UiG4Q=;
 b=f3t9E6U9LHUpgsLeaeDnvChmrXvboaBSz3C3N/XY53WB+dibhbfuptMb1gG8dhqqmEA8/L83ekKiZuEz+7u/dOA82VlE97s3kLrUDonJF8FMFBifMkc41VBxQCx7PTWB2FGzFhu8p0eO+/9Tvn0alcr8KuqobsiQ55oKnYtFPL5DSj3OM2O6LY/ZUSNWTK52UG6JwX14m2JJBDffgdSfpy0ZuvfBUgsx8qYJ4vq7kuuzIxH9GMGP2z32kFdlMkpSPbBLEQjVB98LCZOUlSgxeuLPSMUNLDdVW61SHTMrf1xQwu2dyHNQVgx9KDOU+GPcZvAehDty+/1LZrgfuQKudw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2423.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:58:32 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:58:32 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 10/13] iio: inkern: Add a helper to query an available
 minimum raw value
Thread-Topic: [PATCH v6 10/13] iio: inkern: Add a helper to query an available
 minimum raw value
Thread-Index: AQHZpbD0vGuxZGcZSEKBw8iWwI0WK6+ecHmA
Date:   Tue, 27 Jun 2023 09:58:32 +0000
Message-ID: <0c6533ce-edad-5b41-c033-b1a0641272f8@csgroup.eu>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
 <20230623085830.749991-11-herve.codina@bootlin.com>
In-Reply-To: <20230623085830.749991-11-herve.codina@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2423:EE_
x-ms-office365-filtering-correlation-id: f1fb9e6a-d87f-490d-8928-08db76f51101
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ANwg/9oNv9xGFsaWlUJ1gY7wGDS2d1xbWpr2qKeCpFK+S4fvs+yLfiO3hDhzZupq2oqQzzL3VSiLaQdHDmBtaJfWcpftpuEmtTldpEkG1/evEkrLUVglPAtewzi36ePC3ZNmCtpAHz+w/0Lfsh9bVan2paU+qbi8x4DtEm16VPGaqV7n/kghx3VBLwUWIXzolEcXhPbOwN/SoP3ls1J7uTJMe3lDk/HA1IYdLOgH8rcGt3Y/oGrNmHhmPJib0qlo7hQ9Um7iRyFsqy86YgZ8cz4KxvAWq82emboQUnjPHLpJOicHd6sEVM5DNgBr8k7VQQvdpYAv29YTJ97ge1gfxc/2otgiO4rPiHVAm0Suc94cPC5wXgYhxnCQnpduu1pY6dl5dIq80SzHqjA537nc9rcWJZ4ZXnLcyK+ibbhu7mFGlXsxsMFCmR665Gs52xZrvJnyL6CUnPftdVaOMfYGST6WYRsfVCdj21xfbQMHmB4fpmXOpo5c6f4/a4uumHexlEAcRJwXCUFLuxJ11GLJv8cHaeEKy31/pCevUsL+EnI8X9QfDi4GEBk8MCS1kGTZNUpY9p4X+vTfTy24yRQp/fXVo0rd4OayIiClZCKLmANPfMfg7I7q1TZLSg2TXkqRMXkHXVuJswe8Ois4lGKMEYGNNLLSk8YEfpH6lJ0oKcU/ma3WPchy+o7LIp2CY74gPkcFU27gcZQrhqNg6D08pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(41300700001)(66476007)(26005)(186003)(2906002)(66574015)(38070700005)(921005)(38100700002)(71200400001)(122000001)(6512007)(6506007)(8936002)(5660300002)(64756008)(83380400001)(44832011)(91956017)(76116006)(66446008)(66946007)(66556008)(8676002)(36756003)(7416002)(2616005)(110136005)(6486002)(54906003)(31696002)(86362001)(4326008)(478600001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVJKbjdxaG9NWFRTMlZXRDErZFpGajNjLy9Gb1VqMllFeHJuY1dvZVA1bzNK?=
 =?utf-8?B?R3NHVWIvcllJcDJ6eUdINy9HdGI5MGFvdG5RcFlYVGNCcHVYdlg2TThrZjZE?=
 =?utf-8?B?bnJHS3pPbkE1UXZFRHgyZ2g1YlZjd1F3Z2hSWDNBeGl3bmtGYld1NTVWWks1?=
 =?utf-8?B?RDRoUnpFcGdac01SOUdGUW9EVkhqaExHcTl1QVhRVDcrdVlxTFA4dFByMDBp?=
 =?utf-8?B?TmttdFFWV1RPbFpSME5MUHA2alYzUHFqeHpTNE5rWmRKZEo4a0pxTUg1ZkxW?=
 =?utf-8?B?eU5QRTIzYXRqVmltc0Z1YlNQeUFRV3dEc2x0V1hDNElzY3hncEZwNFZTN1dF?=
 =?utf-8?B?MGJEbjMvODZ3Qk1pRk5FZHh6S3pPZzFPM1RlTjNCMHlXUSt4dlV2ajZNM2VR?=
 =?utf-8?B?NHF1QWFxT2dNUVRvQ0c3ZDdQZVE3TnJSaWFLalhpOThBZXBCNmVzVndKQndn?=
 =?utf-8?B?bGErZDg4dVJiMGVUeiswR3Z4WmZNWlB3Sm55UU9BeGpQMEw2YmdMd2FTakgr?=
 =?utf-8?B?Z0Z0KzkraWYvdkZ1NHhEVjZnOWx3R0krdEJtOTNuT292NnJvSWFyWmZvdWRU?=
 =?utf-8?B?U2ZkZWdRSHhJd3g2K09YK0sweDRxT2VCVDFHV3NseUNqTXdjMXFuRmZ3Y01X?=
 =?utf-8?B?MjNHMkZYeGZqK1lGbm9IRlBlWjBWcVp0VmVtR2s2d2FnSSt6MmhteTNPeVk1?=
 =?utf-8?B?ZHR1KzBIZ1BNTzdhWnY5WG52TWRNTXFtcmk2UUhsamgyRFJpTnRwUXI3bnEy?=
 =?utf-8?B?bytxQnhwdlcxbEJKUjFkdldLVTNJRzBFT0NHaElHTjVaMC9LL0llMnJsTGJh?=
 =?utf-8?B?alZhSW9YZlZCRUE3OFdGZnlqNU04V081L0hRczYzY0VIS1k4Z1lvbE1pM3pw?=
 =?utf-8?B?aXdXbW1HRGF4bFVYVkUxMHpuM2N5dEFFdTkrVGw1MStrWkJWQm1UcEVxcC9C?=
 =?utf-8?B?RWYzNFVpLzJBRkNUTVNJdVRGUHZXblJPWmxuL1BFZFJsRXI0aHhuVThGT0pp?=
 =?utf-8?B?SlAxWC9PREs2UllGQm8yNDUwOU9xR2V6ZHoxbFFvS1hISnBaZkJTb3M0TjZU?=
 =?utf-8?B?VHBGcGkwMjA2dlVCS2pDQllPMGQrTHZYMUJEQmlOZ2EzNGc3ZjhvMGdIOEpz?=
 =?utf-8?B?b29rMjVUWHF1S1NXbmw2Mk1EdVVEZWZUOXVnMG9rYjRja1lzSjB1eHlhQ2dT?=
 =?utf-8?B?aTlMMGd0L1ZWRExkSHlCV0E4bnJGRUt6REd4YWlScnNwQSszbU03a204ek5D?=
 =?utf-8?B?akZyRUE5S08zNHhLNXlXNjhzWGkyTGw3amluVWh6NzRPeit2RlRUTjBtWEVU?=
 =?utf-8?B?Y25OV3FySXBSRmYyUDVMcnQ4V3FQK1BJclViZXpTc2VYL2J6RXhaWm9td0tX?=
 =?utf-8?B?Ukc0QlhoTjJXQXBHSk83VHluc3JBWmJRckd4TDU0emFuT010Q1Nwa0dDUlVa?=
 =?utf-8?B?UU52WVEzbWtQVmVEaU5tRDhQdWZZbFlqUWhOOTRpWS9UbkxmQnRia09OZTJG?=
 =?utf-8?B?TkRCQ2tpeHZ4TTM0eWRLZ2RzNXVON2RORFY5Y0pQOXp0TTN3SEtTV3J0aGdq?=
 =?utf-8?B?T2t4QlkxcXFnZ3FSYTBTTlYweUoxT1NUQ1MweXBQRGhDTXhVVUhXd09MOGVF?=
 =?utf-8?B?Z2Y1Q2wveStISVBybTR6NGh6N0MwdE5sTjRiUVczcUY0Vjh4Um5mdEVtU3RZ?=
 =?utf-8?B?VFNPK2lVNDJQTlJKZmladFVIUTQrZ3hQOWdaQW5KNjZ2L2FnekFIYndOK2xY?=
 =?utf-8?B?c2JTeUhwOGN2d2E0bkhHUDErckoxZC9Lc2ZvMXpEdnJpSnY1MzhBSi84d0tj?=
 =?utf-8?B?bmNEVVF2N0RqTHdrZWY1VzcrZDl4a0FsWnRtVVJlNHFyZTgvNUhIU2VJTHkx?=
 =?utf-8?B?SjBLa28wSks4RmFuUTFiS0dES2lwN1pmdjBITWljSXVGdCt4SitUSFRYdGRC?=
 =?utf-8?B?cmlqa1FCS3p4L2IxalFXc0dyZmw5aU9tdDVid2dQc0RSTjNuMFB2L0txTlcw?=
 =?utf-8?B?NERGc0pLTlRxdVhLa2FxTW9VNXJCY0JRZGpDb0tEZnExRzZEckk4RDFaR1pB?=
 =?utf-8?B?SjE5KzV4dlpFUWozb0d0OSt0aVBtNnFxQ2hqSzN0QUo3RnlnY1J3Y3phWEp3?=
 =?utf-8?Q?tTq7utjcQ7ptU+A4edzeShrZG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA1DF3DB60E68F4E9C0EC828934C079C@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fb9e6a-d87f-490d-8928-08db76f51101
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:58:32.7189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d639CaNKNSaGSmutiVQdvAl47t8LY+EPV7eAY2dlLZXIToAr/bp3FQjaxCOXbKyEYb2bhKsOddAGfPTXMq+QS1m50tSylP68CPecK8FcKbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2423
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzA2LzIwMjMgw6AgMTA6NTgsIEhlcnZlIENvZGluYSBhIMOpY3JpdMKgOg0KPiBB
IGhlbHBlciwgaWlvX3JlYWRfbWF4X2NoYW5uZWxfcmF3KCkgZXhpc3RzIHRvIHJlYWQgdGhlIGF2
YWlsYWJsZQ0KPiBtYXhpbXVtIHJhdyB2YWx1ZSBvZiBhIGNoYW5uZWwgYnV0IG5vdGhpbmcgc2lt
aWxhciBleGlzdHMgdG8gcmVhZCB0aGUNCj4gYXZhaWxhYmxlIG1pbmltdW0gcmF3IHZhbHVlLg0K
PiANCj4gVGhpcyBuZXcgaGVscGVyLCBpaW9fcmVhZF9taW5fY2hhbm5lbF9yYXcoKSwgZmlsbHMg
dGhlIGhvbGUgYW5kIGNhbiBiZQ0KPiB1c2VkIGZvciByZWFkaW5nIHRoZSBhdmFpbGFibGUgbWlu
aW11bSByYXcgdmFsdWUgb2YgYSBjaGFubmVsLg0KPiBJdCBpcyBmdWxseSBiYXNlZCBvbiB0aGUg
ZXhpc3RpbmcgaWlvX3JlYWRfbWF4X2NoYW5uZWxfcmF3KCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBIZXJ2ZSBDb2RpbmEgPGhlcnZlLmNvZGluYUBib290bGluLmNvbT4NCj4gUmV2aWV3ZWQtYnk6
IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gQWNrZWQtYnk6
IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4NCg0K
PiAtLS0NCj4gICBkcml2ZXJzL2lpby9pbmtlcm4uYyAgICAgICAgIHwgNjMgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgaW5jbHVkZS9saW51eC9paW8vY29uc3VtZXIu
aCB8IDEyICsrKysrKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDc1IGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbmtlcm4uYyBiL2RyaXZlcnMvaWlvL2lua2Vy
bi5jDQo+IGluZGV4IDE5ZGRkNzdhZGIxMS4uN2ExZjY3MTMzMThhIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2lpby9pbmtlcm4uYw0KPiArKysgYi9kcml2ZXJzL2lpby9pbmtlcm4uYw0KPiBAQCAt
OTA5LDYgKzkwOSw2OSBAQCBpbnQgaWlvX3JlYWRfbWF4X2NoYW5uZWxfcmF3KHN0cnVjdCBpaW9f
Y2hhbm5lbCAqY2hhbiwgaW50ICp2YWwpDQo+ICAgfQ0KPiAgIEVYUE9SVF9TWU1CT0xfR1BMKGlp
b19yZWFkX21heF9jaGFubmVsX3Jhdyk7DQo+ICAgDQo+ICtzdGF0aWMgaW50IGlpb19jaGFubmVs
X3JlYWRfbWluKHN0cnVjdCBpaW9fY2hhbm5lbCAqY2hhbiwNCj4gKwkJCQlpbnQgKnZhbCwgaW50
ICp2YWwyLCBpbnQgKnR5cGUsDQo+ICsJCQkJZW51bSBpaW9fY2hhbl9pbmZvX2VudW0gaW5mbykN
Cj4gK3sNCj4gKwljb25zdCBpbnQgKnZhbHM7DQo+ICsJaW50IGxlbmd0aDsNCj4gKwlpbnQgcmV0
Ow0KPiArDQo+ICsJcmV0ID0gaWlvX2NoYW5uZWxfcmVhZF9hdmFpbChjaGFuLCAmdmFscywgdHlw
ZSwgJmxlbmd0aCwgaW5mbyk7DQo+ICsJaWYgKHJldCA8IDApDQo+ICsJCXJldHVybiByZXQ7DQo+
ICsNCj4gKwlzd2l0Y2ggKHJldCkgew0KPiArCWNhc2UgSUlPX0FWQUlMX1JBTkdFOg0KPiArCQlz
d2l0Y2ggKCp0eXBlKSB7DQo+ICsJCWNhc2UgSUlPX1ZBTF9JTlQ6DQo+ICsJCQkqdmFsID0gdmFs
c1swXTsNCj4gKwkJCWJyZWFrOw0KPiArCQlkZWZhdWx0Og0KPiArCQkJKnZhbCA9IHZhbHNbMF07
DQo+ICsJCQlpZiAodmFsMikNCj4gKwkJCQkqdmFsMiA9IHZhbHNbMV07DQo+ICsJCX0NCj4gKwkJ
cmV0dXJuIDA7DQo+ICsNCj4gKwljYXNlIElJT19BVkFJTF9MSVNUOg0KPiArCQlpZiAobGVuZ3Ro
IDw9IDApDQo+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwkJc3dpdGNoICgqdHlwZSkgew0KPiAr
CQljYXNlIElJT19WQUxfSU5UOg0KPiArCQkJKnZhbCA9IG1pbl9hcnJheSh2YWxzLCBsZW5ndGgp
Ow0KPiArCQkJYnJlYWs7DQo+ICsJCWRlZmF1bHQ6DQo+ICsJCQkvKiBUT0RPOiBsZWFybiBhYm91
dCBtaW4gZm9yIG90aGVyIGlpbyB2YWx1ZXMgKi8NCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiAr
CQl9DQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICsJZGVmYXVsdDoNCj4gKwkJcmV0dXJuIC1FSU5W
QUw7DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICtpbnQgaWlvX3JlYWRfbWluX2NoYW5uZWxfcmF3KHN0
cnVjdCBpaW9fY2hhbm5lbCAqY2hhbiwgaW50ICp2YWwpDQo+ICt7DQo+ICsJc3RydWN0IGlpb19k
ZXZfb3BhcXVlICppaW9fZGV2X29wYXF1ZSA9IHRvX2lpb19kZXZfb3BhcXVlKGNoYW4tPmluZGlv
X2Rldik7DQo+ICsJaW50IHJldDsNCj4gKwlpbnQgdHlwZTsNCj4gKw0KPiArCW11dGV4X2xvY2so
Jmlpb19kZXZfb3BhcXVlLT5pbmZvX2V4aXN0X2xvY2spOw0KPiArCWlmICghY2hhbi0+aW5kaW9f
ZGV2LT5pbmZvKSB7DQo+ICsJCXJldCA9IC1FTk9ERVY7DQo+ICsJCWdvdG8gZXJyX3VubG9jazsN
Cj4gKwl9DQo+ICsNCj4gKwlyZXQgPSBpaW9fY2hhbm5lbF9yZWFkX21pbihjaGFuLCB2YWwsIE5V
TEwsICZ0eXBlLCBJSU9fQ0hBTl9JTkZPX1JBVyk7DQo+ICtlcnJfdW5sb2NrOg0KPiArCW11dGV4
X3VubG9jaygmaWlvX2Rldl9vcGFxdWUtPmluZm9fZXhpc3RfbG9jayk7DQo+ICsNCj4gKwlyZXR1
cm4gcmV0Ow0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwoaWlvX3JlYWRfbWluX2NoYW5uZWxf
cmF3KTsNCj4gKw0KPiAgIGludCBpaW9fZ2V0X2NoYW5uZWxfdHlwZShzdHJ1Y3QgaWlvX2NoYW5u
ZWwgKmNoYW4sIGVudW0gaWlvX2NoYW5fdHlwZSAqdHlwZSkNCj4gICB7DQo+ICAgCXN0cnVjdCBp
aW9fZGV2X29wYXF1ZSAqaWlvX2Rldl9vcGFxdWUgPSB0b19paW9fZGV2X29wYXF1ZShjaGFuLT5p
bmRpb19kZXYpOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9paW8vY29uc3VtZXIuaCBi
L2luY2x1ZGUvbGludXgvaWlvL2NvbnN1bWVyLmgNCj4gaW5kZXggZjUzNjgyMGI5Y2YyLi5lOTkx
MGI0MWQ0OGUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvaWlvL2NvbnN1bWVyLmgNCj4g
KysrIGIvaW5jbHVkZS9saW51eC9paW8vY29uc3VtZXIuaA0KPiBAQCAtMzAxLDYgKzMwMSwxOCBA
QCBpbnQgaWlvX3dyaXRlX2NoYW5uZWxfcmF3KHN0cnVjdCBpaW9fY2hhbm5lbCAqY2hhbiwgaW50
IHZhbCk7DQo+ICAgICovDQo+ICAgaW50IGlpb19yZWFkX21heF9jaGFubmVsX3JhdyhzdHJ1Y3Qg
aWlvX2NoYW5uZWwgKmNoYW4sIGludCAqdmFsKTsNCj4gICANCj4gKy8qKg0KPiArICogaWlvX3Jl
YWRfbWluX2NoYW5uZWxfcmF3KCkgLSByZWFkIG1pbmltdW0gYXZhaWxhYmxlIHJhdyB2YWx1ZSBm
cm9tIGEgZ2l2ZW4NCj4gKyAqCQkJCWNoYW5uZWwsIGkuZS4gdGhlIG1pbmltdW0gcG9zc2libGUg
dmFsdWUuDQo+ICsgKiBAY2hhbjoJCVRoZSBjaGFubmVsIGJlaW5nIHF1ZXJpZWQuDQo+ICsgKiBA
dmFsOgkJVmFsdWUgcmVhZCBiYWNrLg0KPiArICoNCj4gKyAqIE5vdGUsIGlmIHN0YW5kYXJkIHVu
aXRzIGFyZSByZXF1aXJlZCwgcmF3IHJlYWRzIGZyb20gaWlvIGNoYW5uZWxzDQo+ICsgKiBuZWVk
IHRoZSBvZmZzZXQgKGRlZmF1bHQgMCkgYW5kIHNjYWxlIChkZWZhdWx0IDEpIHRvIGJlIGFwcGxp
ZWQNCj4gKyAqIGFzIChyYXcgKyBvZmZzZXQpICogc2NhbGUuDQo+ICsgKi8NCj4gK2ludCBpaW9f
cmVhZF9taW5fY2hhbm5lbF9yYXcoc3RydWN0IGlpb19jaGFubmVsICpjaGFuLCBpbnQgKnZhbCk7
DQo+ICsNCj4gICAvKioNCj4gICAgKiBpaW9fcmVhZF9hdmFpbF9jaGFubmVsX3JhdygpIC0gcmVh
ZCBhdmFpbGFibGUgcmF3IHZhbHVlcyBmcm9tIGEgZ2l2ZW4gY2hhbm5lbA0KPiAgICAqIEBjaGFu
OgkJVGhlIGNoYW5uZWwgYmVpbmcgcXVlcmllZC4NCg==
