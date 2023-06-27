Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61F273F926
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjF0Jxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjF0JxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:53:17 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2047.outbound.protection.outlook.com [40.107.12.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E621F297A;
        Tue, 27 Jun 2023 02:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDzd7E61fKfqByprb6Bzhe9O3ybc7GG7JR1n8x/sl2NEDuXWAf/AHno1kIkQrU3mEv36K1MTzm2DqT/wit8x7XSD1OsIEwKDZDt0aCXpR7F5R0PsFKua470k7t3wGOSNTkvYgvZQEQfH0QMh+S308lcgSnUnFWpmecNCGkQfwgNmS3CAmmoURT4YDsFsIIVtPp6YqPhiA+7hhwK5RAEMmhP+CRi5tkwTyImUjZGqD0cxtKrsRafXwON5fPXezPRLX2IY/YeQ7+Od/RxqKy8eW8qEN1qAAxhY5jldX3jVfKqCSp+8yrpwRrhWKrNFrK3WV3ims8Xr/9DVZMKW+mqcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46QoZtjK/8y9OwpX1KkLH7UTetz1fff8pB5hi6jklb0=;
 b=P4ouKJqWe9D+/2JKNiW/xLR1B182ITHU6YhIrqwDcQtx4c0UuanJTqVi4C8Ac0F0FwiukcRecFOeD3VwapUCu5v7M1mkDp5cEl6f5dwJnshIlTd3vosQMZcCqO9OOIKhD1fgW5f6a1EUNlD1C+JwFZsQ5QMOKCuWp64iABYEpsvF0pk0gBOENnn0a6mdpRjdCmaeaMc2uYfazUQ9nahLze+Ady9mTUfRNqDbp8o9NDr9bkiWP83tq6UZv0efMB1gFE7qXu1VQ50KKDu1u6x/urXrFmuCG9nUngamu/AJE70D0tGFV9tIYc2AE6iQlYU9MKAXKyv54Udlr/aRZUdFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46QoZtjK/8y9OwpX1KkLH7UTetz1fff8pB5hi6jklb0=;
 b=lxomv8MThrchiiUF7XF7+uIp/gAH74xMD5RPSrl6s6rSc+371ucAsssqxNgMjEnMeR1i44W2OjKN8aAzdKt2fi2SjyKaurIEcdWZxelQZS6MJTQ5ITqem/RDIamd5pHabRpqSRXMGjCN+Fk8Wdc9tgYFEguP2XdYWiTqnUAae4XWg9k8FfCCRgHeSXiP1prj7A60fjCyAuhaDAi/HVulj1juSehtvnqyQSuKrEbuhR1OIpy3JgdhsnqwV3Xfqrpkz//0X9I0ewogyCODRvCMqm0OgdQ36i7zPfxj9plUni7LEEgf7uXaKBYMJrmv2Oj2sFefR1cUB/X37FUGTUPlzA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:32::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:53:02 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:53:01 +0000
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 01/13] ASoC: dt-bindings: Add audio-iio-aux
Thread-Topic: [PATCH v6 01/13] ASoC: dt-bindings: Add audio-iio-aux
Thread-Index: AQHZpbDo7Vp4s+yhqUadHDn9az7Fl6+ebu+A
Date:   Tue, 27 Jun 2023 09:53:01 +0000
Message-ID: <95795ada-dbc6-3061-c39d-2a70163b49cf@csgroup.eu>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
 <20230623085830.749991-2-herve.codina@bootlin.com>
In-Reply-To: <20230623085830.749991-2-herve.codina@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2481:EE_
x-ms-office365-filtering-correlation-id: ede90dd0-34b3-4c79-93b9-08db76f44bd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ejqeSj/naFgtbLYDKD5i5sdA70+TvigHBFml+EiPntnLmhG7WGSkuMyIUlN5o6sRAXLURYmTiCaQoMTbGuihkYHAsumrt4vB0xxsPxDhXsvvQZ4O/vJx3AxmKfbsuJD87o/WDqqiTfhdF16qa0EtjEOV8iTsWzyyu4DTiEBL2QpZ4nq80cxd2jbwtf/HY6WmMQcSNRcCNtAR13W99HYCFCRyF7EDCsc/WKUIloe69ZSFZqn6U2FjXZnYYdIHfj0pTYOJ0bchfGXXeYzAS0M4A3y1rf7TFxTDbVneuP34L1uWPVMulXIU6KPA0uOPZgaPCP3Xf3UB1amQgDOjaacBEU5mHOyCD304mbwf4Vuix5kAQHEyX9XvTi/pHDcR73dpxLpHYk3oiklMFt6RgLVoXVSvSuVkz8m1GwvcxIpp3T/Gjo9bjbq9TnzJB7zlkHtDFTUuVjZNJ8ozdXprqVZOHBdVEFN89yo3IpoDJPXziQfgp4uiTk6BPCjmKmxVWhSfOCIpXkKVjcdX3gv1YrPFT67WBFkxpDX+0xfvdi1UdbZvJwC5N0b/ObVm0wj1kWxDpk6d3V+Fi2EM6Hz0N/CNOs8JPYPdZDks1fa/Sgf/S9FGRUlM3ZT8Z9uGjDvWcCEvjA6h4IB3xtmJuXk4wpmEPjo+Jwjx8GOM5FrheHT5ZNtUDDT//HFZB8hZEiM2FRJN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(66574015)(966005)(6486002)(71200400001)(122000001)(38100700002)(921005)(26005)(83380400001)(2616005)(186003)(6506007)(6512007)(41300700001)(110136005)(2906002)(31696002)(86362001)(54906003)(38070700005)(478600001)(4326008)(316002)(76116006)(66946007)(66476007)(66446008)(66556008)(64756008)(44832011)(91956017)(8936002)(36756003)(31686004)(7416002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjJhVHlGbmlzUElYOVVMaTlnV2wvaXF2Tmg4QnBXM2h4YkdRVUw1VkVaK1lS?=
 =?utf-8?B?NEN5bHF4dWJ6MkpvTnFTeTc2TFZyN2hTV3JYWUdINGlRWlBlS0JDaFF3Z2Rl?=
 =?utf-8?B?TEN6Z25VczhjZkFzbndSQUR1Z2lKbHNQQmttdCtlZjVGazNXTTMveVYyN0oz?=
 =?utf-8?B?RS81YUtsaDV6SXBLSkUwNVk4MnQ1eExwbkFOajc0QjRCaU5kaVNnbzZsb1BF?=
 =?utf-8?B?V0RVMEFjS1lXQTRnL3Z3WCtnWjF4WHl0YkJGQ3JQb1JTc1FsNzF5U3U5eWVS?=
 =?utf-8?B?eEkzQ3dVM2xydnJEQnR4bE9sbExOTGJ5TEM1dE5md0pGVDJOWlJHcEllMHFQ?=
 =?utf-8?B?dHJjc05lRjNmV09rMjd6OU41cHRRQUJ4UGwvYU5pNnhMa1hta3FtbjhvbUk3?=
 =?utf-8?B?TVM2MmZ6MzFhN2NjNUE5bmVuSDZYV0hrUkVOKzlVdk5SYzBlNU5vNkZXa3Bh?=
 =?utf-8?B?NExWTlhkQi83MHZtWk1xQ0Fkc0RPS2d2M3pNQ1cyVFA1YlBJU2V5c28yVHFN?=
 =?utf-8?B?QnZpaHZsWFV3aHhrb0hvVkhEM0QwVUlIbGlkVVE0UzdveUpYQ2hWMWVkZ09X?=
 =?utf-8?B?VjFOWWIvcEJtVmpGTzBBV3M1enVKdkdZdHFOU2xxbkdYUWNtNFFhNWNqOFpQ?=
 =?utf-8?B?dFFwUitFc0VidkhHcjNIZXlKbVB5OVBSa1BaUUdMSi80QURhYTNoZmdTYUpx?=
 =?utf-8?B?RFQ1aHBLR2xYbWRrMGlrU3hzWHc5TWdiNko0T05rYzA2emhLb3FNN1dSQVEr?=
 =?utf-8?B?SEpVM3FieURTRG9iVjl5NzJwK0ZwUU11bjhXd0dyRXg0V1ROTUYxQVlkdS9t?=
 =?utf-8?B?YjdqWVZ2TW5GQitMUXV2UGUvQUhveXNJN2ppakJtMUppdjQ2dE8yUVRidUo3?=
 =?utf-8?B?OG92cjN2dWt0QzNqRTZpTmFhVUNMMjE0bWxhNVcxajg1Vllvam5mck50TUdI?=
 =?utf-8?B?NlExNGFHM2hJdmFLUGkyZ0ovcEhmUGJ1UjlNNXdqZWNrcWVDL0h2RXErMVFI?=
 =?utf-8?B?V1FxSklrc2FmeTczTUhtYXRJaUdUMC96RGhWSWgxUTRNY1JxdEgySlg5dkhV?=
 =?utf-8?B?bGE1NUJSYVFEaWdSelpsajhyYXpxMFgrcVprd1JaUEMzUUpxVHVzbUNYb2NH?=
 =?utf-8?B?Q1p5b0taeFBrOWZ3L0grTkhWSjIyV3o4Mk9wcGo0SG0zeVh1ZjlUSHRZWDJ1?=
 =?utf-8?B?N0I0MEhiK0FQdGNxUzRRWVRPTis3LzI4ODgwRnFHQ3MvMTZaVm5WTVdSaEhz?=
 =?utf-8?B?NFdmOFBWRTZ5VnQweGtGbWdSQ084VHVuRHVydGZsNlNGMitJRkx3YlZtdnE5?=
 =?utf-8?B?b0lyMTRmRDVXL0Y3QmM1SzlHZmZQdHF4Y213UEk3VmNXaHpQQVQ1TVFleFBL?=
 =?utf-8?B?ZitNeTdzZnRPQUp3MVZ3LzBZdmRTZEdlZS80b1BKcUNrQVdVR3YrZDV2NnVo?=
 =?utf-8?B?b1FpU2hLN2ZqV2g4bmdpTjhONnpyTWs0WUx4Wkp6TVNpM3d5c291OVhya1dE?=
 =?utf-8?B?bTkzWkNRdmlydG9aUnAvYWFvOGVmQWRLZldzazNrWThWZmNBdE9uWHBQV1Fx?=
 =?utf-8?B?NFlGWDdydXVHRnQ4cWIwZ09lTHg1L0VIS0c5QVVWOWxCa0o2ZFdMMEJLNVpJ?=
 =?utf-8?B?cndKRkFBOGptOHdvQzBlMUFPQXNPcXczOFVaYTdONDBCUFJWR2lyU1BtSlMv?=
 =?utf-8?B?dUtqWG0vQjZ1dWVmbWRBSWdSaGg0T1NmeERGKzExNlZYdmp6MlJQZTRzN2Yz?=
 =?utf-8?B?Q0Y5OXVYZ0g5M1VzY2g1OC94cllmMTlVZmlFOFhmK2l3WHloS3dnU2sxWURp?=
 =?utf-8?B?UnFIMHAwZ0tXR2h5MnhSS2lRUDhZY052RTVCWVJia05xaXc1MmJUQUxxbGEy?=
 =?utf-8?B?NGRweVdBWHZERkFpUGJqRVIwKzZXM0FMTEpHMW1XR0dvelh1cTZqMEU0djVZ?=
 =?utf-8?B?NHZQRVhDWFVGanpQUXdEd0sxWFFtSlNZZW1DOXRZVUZFd3pJZzcvN3grUlVY?=
 =?utf-8?B?RTNyN29GeXhPOVhIT0lJblQzUWZwdWZHU0w5UEFzOXNZSnJac0FPdytYaDZs?=
 =?utf-8?B?NWNaaFVWRkRmMndWenJLd3Q5cUhnN215VUlDWS9HKzhpUTNpb0ZvakVQdUxH?=
 =?utf-8?Q?MgwqskPnD1IxXByVd9wW5tI55?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6F9EDEF6DA82E469DCD8925ADB00F89@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ede90dd0-34b3-4c79-93b9-08db76f44bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:53:01.9345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rz/n7kFxWxye598T/vHFwbxLYOixML6NgR4KkXrZ60yc7uW+6hnxFggEbrxNPNAk/wfsVKTQSmgJUmbVxKbhJ6oDwDLhU1c4Un5ZGHlwMMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2481
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzA2LzIwMjMgw6AgMTA6NTgsIEhlcnZlIENvZGluYSBhIMOpY3JpdMKgOg0KPiBJ
bmR1c3RyaWFsIEkvTyBkZXZpY2VzIGNhbiBiZSBwcmVzZW50IGluIHRoZSBhdWRpbyBwYXRoLg0K
PiBUaGVzZSBkZXZpY2VzIG5lZWRzIHRvIGJlIHZpZXdlZCBhcyBhdWRpbyBjb21wb25lbnRzIGlu
IG9yZGVyIHRvIGJlDQo+IGZ1bGx5IGludGVncmF0ZWQgaW4gdGhlIGF1ZGlvIHBhdGguDQo+IA0K
PiBhdWRpby1paW8tYXV4IGFsbG93cyB0byBjb25zaWRlciB0aGVzZSBJbmR1c3RyaWFsIEkvTyBk
ZXZpY2VzIGFzDQo+IGF1eGxpYXJ5IGF1ZGlvIGRldmljZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBIZXJ2ZSBDb2RpbmEgPGhlcnZlLmNvZGluYUBib290bGluLmNvbT4NCj4gUmV2aWV3ZWQtYnk6
IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gUmV2aWV3
ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQoNClJldmlld2VkLWJ5OiBDaHJp
c3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QMKpc2dyb3VwLmV1Pg0KDQo+IC0tLQ0KPiAg
IC4uLi9iaW5kaW5ncy9zb3VuZC9hdWRpby1paW8tYXV4LnlhbWwgICAgICAgICB8IDY0ICsrKysr
KysrKysrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQ0KPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291
bmQvYXVkaW8taWlvLWF1eC55YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2F1ZGlvLWlpby1hdXgueWFtbCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9hdWRpby1paW8tYXV4LnlhbWwNCj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi5kM2NjMWVhNGExNzUNCj4gLS0t
IC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291
bmQvYXVkaW8taWlvLWF1eC55YW1sDQo+IEBAIC0wLDAgKzEsNjQgQEANCj4gKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiArJVlBTUwg
MS4yDQo+ICstLS0NCj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc291bmQv
YXVkaW8taWlvLWF1eC55YW1sIw0KPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21l
dGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ICsNCj4gK3RpdGxlOiBBdWRpbyBJSU8gYXV4aWxpYXJ5
DQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIEhlcnZlIENvZGluYSA8aGVydmUuY29kaW5h
QGJvb3RsaW4uY29tPg0KPiArDQo+ICtkZXNjcmlwdGlvbjoNCj4gKyAgQXV4aWxpYXJ5IGRldmlj
ZSBiYXNlZCBvbiBJbmR1c3RyaWFsIEkvTyBkZXZpY2UgY2hhbm5lbHMNCj4gKw0KPiArYWxsT2Y6
DQo+ICsgIC0gJHJlZjogZGFpLWNvbW1vbi55YW1sIw0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiAr
ICBjb21wYXRpYmxlOg0KPiArICAgIGNvbnN0OiBhdWRpby1paW8tYXV4DQo+ICsNCj4gKyAgaW8t
Y2hhbm5lbHM6DQo+ICsgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICBJbmR1c3RyaWFsIEkvTyBk
ZXZpY2UgY2hhbm5lbHMgdXNlZA0KPiArDQo+ICsgIGlvLWNoYW5uZWwtbmFtZXM6DQo+ICsgICAg
ZGVzY3JpcHRpb246DQo+ICsgICAgICBJbmR1c3RyaWFsIEkvTyBjaGFubmVsIG5hbWVzIHJlbGF0
ZWQgdG8gaW8tY2hhbm5lbHMuDQo+ICsgICAgICBUaGVzZSBuYW1lcyBhcmUgdXNlZCB0byBwcm92
aWRlcyBzb3VuZCBjb250cm9scywgd2lkZ2V0cyBhbmQgcm91dGVzIG5hbWVzLg0KPiArDQo+ICsg
IHNuZC1jb250cm9sLWludmVydC1yYW5nZToNCj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55
YW1sIy9kZWZpbml0aW9ucy91aW50MzItYXJyYXkNCj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiAr
ICAgICAgQSBsaXN0IG9mIDAvMSBmbGFncyBkZWZpbmluZyB3aGV0aGVyIG9yIG5vdCB0aGUgcmVs
YXRlZCBjaGFubmVsIGlzDQo+ICsgICAgICBpbnZlcnRlZA0KPiArICAgIGl0ZW1zOg0KPiArICAg
ICAgZW51bTogWzAsIDFdDQo+ICsgICAgICBkZWZhdWx0OiAwDQo+ICsgICAgICBkZXNjcmlwdGlv
bjogfA0KPiArICAgICAgICBJbnZlcnQgdGhlIHNvdW5kIGNvbnRyb2wgdmFsdWUgY29tcGFyZWQg
dG8gdGhlIElJTyBjaGFubmVsIHJhdyB2YWx1ZS4NCj4gKyAgICAgICAgICAtIDE6IFRoZSByZWxh
dGVkIHNvdW5kIGNvbnRyb2wgdmFsdWUgaXMgaW52ZXJ0ZWQgbWVhbmluZyB0aGF0IHRoZQ0KPiAr
ICAgICAgICAgICAgICAgbWluaW11bSBzb3VuZCBjb250cm9sIHZhbHVlIGNvcnJlc3BvbmQgdG8g
dGhlIG1heGltdW0gSUlPIGNoYW5uZWwNCj4gKyAgICAgICAgICAgICAgIHJhdyB2YWx1ZSBhbmQg
dGhlIG1heGltdW0gc291bmQgY29udHJvbCB2YWx1ZSBjb3JyZXNwb25kIHRvIHRoZQ0KPiArICAg
ICAgICAgICAgICAgbWluaW11bSBJSU8gY2hhbm5lbCByYXcgdmFsdWUuDQo+ICsgICAgICAgICAg
LSAwOiBUaGUgcmVsYXRlZCBzb3VuZCBjb250cm9sIHZhbHVlIGlzIG5vdCBpbnZlcnRlZCBtZWFu
aW5nIHRoYXQgdGhlDQo+ICsgICAgICAgICAgICAgICBtaW5pbXVtIChyZXNwIG1heGltdW0pIHNv
dW5kIGNvbnRyb2wgdmFsdWUgY29ycmVzcG9uZCB0byB0aGUNCj4gKyAgICAgICAgICAgICAgIG1p
bmltdW0gKHJlc3AgbWF4aW11bSkgSUlPIGNoYW5uZWwgcmF3IHZhbHVlLg0KPiArDQo+ICtyZXF1
aXJlZDoNCj4gKyAgLSBjb21wYXRpYmxlDQo+ICsgIC0gaW8tY2hhbm5lbHMNCj4gKyAgLSBpby1j
aGFubmVsLW5hbWVzDQo+ICsNCj4gK3VuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4gKw0K
PiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAgIGlpby1hdXggew0KPiArICAgICAgICBjb21w
YXRpYmxlID0gImF1ZGlvLWlpby1hdXgiOw0KPiArICAgICAgICBpby1jaGFubmVscyA9IDwmaWlv
IDA+LCA8JmlpbyAxPiwgPCZpaW8gMj4sIDwmaWlvIDM+Ow0KPiArICAgICAgICBpby1jaGFubmVs
LW5hbWVzID0gIkNIMCIsICJDSDEiLCAiQ0gyIiwgIkNIMyI7DQo+ICsgICAgICAgIC8qIEludmVy
dCBDSDEgYW5kIENIMiAqLw0KPiArICAgICAgICBzbmQtY29udHJvbC1pbnZlcnQtcmFuZ2UgPSA8
MCAxIDEgMD47DQo+ICsgICAgfTsNCg==
