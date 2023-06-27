Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7309D73F95A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjF0J6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjF0J5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:57:32 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2040.outbound.protection.outlook.com [40.107.9.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BED030F9;
        Tue, 27 Jun 2023 02:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWgKYhrH+9oZvYIyzoyZXb/FkLR9aKqwRcBhwEHPGxt3qdK/Bibi99A3EH4qv3z0ftCO1aTaE20JcHZYSL77RdRv8jnxbYrzQkU7NlcMSRz4FKbn9O9kEgI+cnBIx+ebiFTwrMkSU+UBxqP+j3UH0qQLGEpr7vtM8LheN5Np64zXrvfivqADm9sKBNbYCdTeEwlEy2aEp6a09z0cqsKTYTeEX5DkYsR+/vAArJbAZA3G+XdLZXTvKTvi43z0VfecP+eM9WNTVB8qXBSuLRovR57hQ9oiAjgFjiKCEjwaGM6aR+Q2T8Ptjm7rIAZSeuyyDZ6iyRRmLU75rVOk5LFKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUgYjJagc14zRoM7zoURuCFitHaK90vvb4pVGg5TCuk=;
 b=JtwVRNzcktar/qYkH1Qck0B7U5SF+RMwpXW2/+ag8SD1ohLlG9bhNsdrYlLz4CjfRIAzPsxU+3N3XWUc3x/XrZnRkBukj3jxCextuUvDniV/ZAvQo4u0FnD15p7Y8tDTH1F1Nt8DPCgkqzsNofECgiUbC2Z6X6kDEMuzw1D8bcvTP+WTNzAYgyoFRdNvtxlDzE/xDuNM15w22GadSMpE2EDvjRTSYH71Iqg1xXFWCsTzqNEh1lADuL6sOYrMr1dxlCfgS0ITWo9/Cdg/ZVbFHKcdzB5Igcy4eK+CTWyS9AygAGRY3Qx8TZf4Q3kAq2D5CPrh8msi29QCIV1EybHbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUgYjJagc14zRoM7zoURuCFitHaK90vvb4pVGg5TCuk=;
 b=eVdRnmWs79a8BF4OuGaiE1aXn746tYr9KF0Qt9PUU+ZLG26eo4OoOZJiOIYvGcI9q5fUmMLRi+Tsmll2CesIFk8TNQcSGkgar2u5r4Sau5uX56dXqhTs179fBYczRVLdtXCRwc8LfJ7re6urmrOVD0jcTHNpTAfFzw4ylWES1kIsDCFZjJOBeV1C3oQtktFjc1yH4aq1upALPJC1mK4dHe/KVkAjkiEs8KtM7z9B50piSmyxS8Rcnd33zZPsTIifpj7DN/O76rhTYXs5qDMiBPUI5qW2YXEFV5C8AHF6cr3r18+qxJAkGLKR0bxz7rHr/7SZ1re3Dulw4HlDvsjC/Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2423.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:56:14 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:56:14 +0000
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
Subject: Re: [PATCH v6 05/13] iio: inkern: Remove the 'unused' variable usage
 in iio_channel_read_max()
Thread-Topic: [PATCH v6 05/13] iio: inkern: Remove the 'unused' variable usage
 in iio_channel_read_max()
Thread-Index: AQHZpbDuF2rg1yMkkUS9oe3A09ecH6+eb9SA
Date:   Tue, 27 Jun 2023 09:56:14 +0000
Message-ID: <e5d63dd7-f28a-9045-b617-287076a6adff@csgroup.eu>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
 <20230623085830.749991-6-herve.codina@bootlin.com>
In-Reply-To: <20230623085830.749991-6-herve.codina@bootlin.com>
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
x-ms-office365-filtering-correlation-id: 83729622-ff31-4518-d822-08db76f4bec1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n54OZ7Kci0LYtEKjl6LZ+bdeQJ9Zl3Z0/9aXYc3FTeRSvTk8Q9kK3moWT9ZCblhIsRoFNxmjMaZslYj0LrGGxp9vlBMQhu7sop0yV4TfJkVzwyk/+VrdKqYqRfOpYX82rt9TwRuUNdx5BfxMtQRrjHuGuF1LKjw6o5UQm5Ksng7DVMFnGTbmkJdG9K0t3+4x9CYdTGvIv7ghmNW2Nm0xXRIsn6UEURaUjzo5s/IkV/XOohvrIOQJcpRb57nZYZP1cDsbHMYtl1NW0WsBDZ6ZFQNhCbMOwBF6k/RQ1LuYC9hDeCOauyqvrgEP9CfyW54rCpjUsp0XWnlR6rxqFUeL3IWKYMVUbtm1Heb+LaDbh3G0/a4TViwS54qPkOXswFN2ghuEL9rzO6NoqST4A6YdAVVzxsd3RckEoeoG4LVas1vSfTvROPrDZa6LPK786C0BdK287MSAg/FECQwDg4MdRe8lJkV48KLXUcqElXddjsbiHpLxn4j1eOhIBf57A6exS8mLM9PI02B4ZLx3HLUjXHT+m3Bx3wZuDiPKekvmceCsqilSDROjyoSU/Efzj8ckgmCpNPGlUwyomLgRO7u5uxq3b6BtKb5fqlcFyGAtymle5lsaeMvKxcYqcg1SDm3o1EvAxfWrabcAiyUVtAGQlw++P/+uTkEHmV+/NAbtNTeG2zD8yFvWFw61kwROoJifibaz3LjdJArvsKgM9ZeNvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(41300700001)(66476007)(26005)(186003)(2906002)(66574015)(38070700005)(921005)(38100700002)(71200400001)(122000001)(6512007)(6506007)(8936002)(5660300002)(64756008)(83380400001)(44832011)(91956017)(76116006)(66446008)(66946007)(66556008)(8676002)(36756003)(7416002)(2616005)(110136005)(6486002)(54906003)(31696002)(86362001)(4326008)(478600001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnRiWDUvbktxd3Z6OFA0MXNlOUltK0o4ZDdaVWE3bjRkeGVBemtucjlSdVlK?=
 =?utf-8?B?NklVbWFMMHhnVW5sM24rejhiYkVXdFRkZUVsbXBOakFBKzFLUVNEWmhLdDhZ?=
 =?utf-8?B?eU1xaGdnYzFzUHZxU2FNSEdIbkd6U0Znc0Z1Wm8vaG5DYUNYM2hhMExZNHZP?=
 =?utf-8?B?L3JjUVlzc1FUc1lDQmNKWTg3K3h2aTJqNmZrZkZ0b3lHQ3JVZUxrSlNpdWxR?=
 =?utf-8?B?SDM2MlN3VFVaSTZZSzJjWE1QUXFONXYwU0xaN2VNNG1yT09oQ0VDQkJEVXNO?=
 =?utf-8?B?M3ZjV0l5U052NEJCOTBnemZtQ3VYN1l3VkN5Sis1Y0ZmNytLamdhNTllNTU0?=
 =?utf-8?B?VkhSamR5dlRXb2RNZ3czcVk1aCtwQkJkNW1oU3VreDZVRUh5ZzVlYmh3N2dY?=
 =?utf-8?B?eVFlT3RQTFZJQmpyVVA1aVlEdWtCUXJlVlNlSy9IQ0pMT1NmbUl3Sm1JU094?=
 =?utf-8?B?RnNRQjZCUWgycmpSbjFKMzB4OUtYVnlBcnBKOUxZckloZ3pRZ1hXcmZON2lX?=
 =?utf-8?B?N3h6Q2JIVVhIOEpibVVDdHVDZzhkaGhWMUJ4ZlE5ME1adHBKc2pOejhCVFQ5?=
 =?utf-8?B?YTIwcnJpaDlWNDE4L09XdzVraVR3dHBRcSs4NjY5ejhEa2JxMitxaGg0QXph?=
 =?utf-8?B?M1ozRHRKUG1LVlViTHZaUi9obzBrcEU1V3UrZ2VHalR2aEhtRzAxMHRXclZp?=
 =?utf-8?B?SUtVcXB0VU9jTkZid3NVOHVXMFA4NjNhUjNzSXlaWFR4Q0lPYklnZmx6OWo5?=
 =?utf-8?B?ZWxyUURUTll1d001eHZaSFNDbnYzSnVWYmF5U0trZUNqME1YUkU3K0ZUd3Q4?=
 =?utf-8?B?UFRWd2w5QTZ6bWI4czlzQTIvOURxYWxrajA3YzUxZkMxRGE4dm5sMkFWbEhH?=
 =?utf-8?B?Qlp5OCtnR2VSdEEvL2tWRGxHZDN6bVJ0S2Q5YXEyb2w1azFOZnU5OEt5bWtD?=
 =?utf-8?B?VlFnaXJDVUtXQTlOdnZla2dQR2Y3Uk84MWlsaXRtRUllWS9OZS9JSC9Wa2Qv?=
 =?utf-8?B?ZzRzN3lLMEF5V1NuVGZJZ0lWeFNqQ2Q4YTlxRVkxZUNueElTMkZ5allySWNV?=
 =?utf-8?B?U1N1Q3FZdHdsMHptdHZIdjZMRU9xem1WWWpHcit3a1I4eE1hYXk0amJQV2lt?=
 =?utf-8?B?VmE1WnpBTTBCZnN3VWV5U1RMUUcvdXBFbUhtTXBMWjZKMks2cXV3eUg1NHNi?=
 =?utf-8?B?QU5jUktYY3NNOWxuTnpnbDZsYndjemFnTlc0TUJodHQyN1RndGFSYUhRanRo?=
 =?utf-8?B?bk15Y1dvUERHc0NKYml4enN3VHZjYnJlaTN0UFU3TllPZ3BQQjJ1Q3cvZzNy?=
 =?utf-8?B?U1gzV2dCU01adkZIQU90UXRlUnhXK3R5aU90cVN1dmc4OEx4empGTnpnQnQr?=
 =?utf-8?B?NmJ0UUpZT25ySURvM1FTQXlVZ3BlS21WOUkvcDhUbDgwTkhZbVc3Y0lJTE80?=
 =?utf-8?B?enhySHRpSDFsc0VJNlljWXQxTnh1YmtUaUNuRmFBTHJUSmg0YytqcWxNYVFB?=
 =?utf-8?B?UFNLTkxIWjlqazl0dHA1YkJVMjA3cUtvRlNnblJRYTZxZG1tOGZoL2lzcEt2?=
 =?utf-8?B?cisrU1ZhRGpqSFh0WWhqWGxJUUpUeWl1bUgvZUNuSlc3ZjIxVDJUWUg4MTVO?=
 =?utf-8?B?TklqU2Z0QzI0Q3VwZXBWendBV003MDFWTUhiQmtJWVBQUWNZRVZ4aVYxcW5j?=
 =?utf-8?B?VXFaQzdweTRodGQyYWFsd0dwMHhIZTVEckdEaC90VHJwVkF2TjJmSlFoakhs?=
 =?utf-8?B?ZTlOakZ3RUxjL3FVVCtyYVhkZHlpMFhzU1dmSnh1UUYwV1JDeXRNRHZneG16?=
 =?utf-8?B?VVZ5RG1GcVBPSzk5cXlPbys2ZFhuWk9mLzhneDR2eFFqREh2akoxVXBuWENw?=
 =?utf-8?B?MTFnOEdtV2wvU0E3K1pJN3g2b3gyZkxjYUMvUzFqcFZVMTFQUFpZMjM3Ujhs?=
 =?utf-8?B?Qlc5cFdtRXUyUnBpQnBueDI4bGRVdDkzaFBlZXRaMW1GeFNQMFZSY2ZRNUEz?=
 =?utf-8?B?WkJkZG1NZEVnc05ldEd6bmtwc1pIWmZEcVd4OVljU0xWTmxqeUt0alhKbFV4?=
 =?utf-8?B?T09PcWJQQTlaL0tpZmp6a2h2dTIyM01rRURSMWkvNjFuOWY0ZGpQSmJneG5j?=
 =?utf-8?Q?n7OTO7ZLEq/56tKTUV52ACN+q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C13F0723EECCB542B71FB27AD721A465@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 83729622-ff31-4518-d822-08db76f4bec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:56:14.7513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRKjzFRDqxrDwbDkvFgg9V871e2M7eM7JCLk+PEvPmyOHykIyuN93+kbrtmdWyLfhE2He5Wt2JTrp5FRQ4JdVACOTFi+MZzwEoVyprVABR4=
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

DQoNCkxlIDIzLzA2LzIwMjMgw6AgMTA6NTgsIEhlcnZlIENvZGluYSBhIMOpY3JpdMKgOg0KPiBU
aGUgY29kZSB1c2VzIGEgbG9jYWwgdmFyaWFibGUgdG8gaW5pdGlhbGl6ZSBhIG51bGwgcG9pbnRl
ciBpbiBvcmRlciB0bw0KPiBhdm9pZCBhY2Nlc3NpbmcgdGhpcyBudWxsIHBvaW50ZXIgbGF0ZXIg
b24uDQo+IA0KPiBTaW1wbHkgcmVtb3ZlZCB0aGUgJ3VudXNlZCcgdmFyaWFibGUgYW5kIGNoZWNr
IGZvciB0aGUgbnVsbCBwb2ludGVyIGp1c3QNCj4gYmVmb3JlIGFjY2Vzc2luZyBpdC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEhlcnZlIENvZGluYSA8aGVydmUuY29kaW5hQGJvb3RsaW4uY29tPg0K
PiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29t
Pg0KPiBBY2tlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWku
Y29tPg0KDQpSZXZpZXdlZC1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBj
c2dyb3VwLmV1Pg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvaWlvL2lua2Vybi5jIHwgNyArKy0tLS0t
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbmtlcm4uYyBiL2RyaXZlcnMvaWlvL2lua2Vy
bi5jDQo+IGluZGV4IGY3MzhkYjlhMGMwNC4uY2U1MzdiNGNhNmNhIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2lpby9pbmtlcm4uYw0KPiArKysgYi9kcml2ZXJzL2lpby9pbmtlcm4uYw0KPiBAQCAt
ODQ5LDE0ICs4NDksMTAgQEAgc3RhdGljIGludCBpaW9fY2hhbm5lbF9yZWFkX21heChzdHJ1Y3Qg
aWlvX2NoYW5uZWwgKmNoYW4sDQo+ICAgCQkJCWludCAqdmFsLCBpbnQgKnZhbDIsIGludCAqdHlw
ZSwNCj4gICAJCQkJZW51bSBpaW9fY2hhbl9pbmZvX2VudW0gaW5mbykNCj4gICB7DQo+IC0JaW50
IHVudXNlZDsNCj4gICAJY29uc3QgaW50ICp2YWxzOw0KPiAgIAlpbnQgbGVuZ3RoOw0KPiAgIAlp
bnQgcmV0Ow0KPiAgIA0KPiAtCWlmICghdmFsMikNCj4gLQkJdmFsMiA9ICZ1bnVzZWQ7DQo+IC0N
Cj4gICAJcmV0ID0gaWlvX2NoYW5uZWxfcmVhZF9hdmFpbChjaGFuLCAmdmFscywgdHlwZSwgJmxl
bmd0aCwgaW5mbyk7DQo+ICAgCWlmIChyZXQgPCAwKQ0KPiAgIAkJcmV0dXJuIHJldDsNCj4gQEAg
LTg2OSw3ICs4NjUsOCBAQCBzdGF0aWMgaW50IGlpb19jaGFubmVsX3JlYWRfbWF4KHN0cnVjdCBp
aW9fY2hhbm5lbCAqY2hhbiwNCj4gICAJCQlicmVhazsNCj4gICAJCWRlZmF1bHQ6DQo+ICAgCQkJ
KnZhbCA9IHZhbHNbNF07DQo+IC0JCQkqdmFsMiA9IHZhbHNbNV07DQo+ICsJCQlpZiAodmFsMikN
Cj4gKwkJCQkqdmFsMiA9IHZhbHNbNV07DQo+ICAgCQl9DQo+ICAgCQlyZXR1cm4gMDsNCj4gICAN
Cg==
