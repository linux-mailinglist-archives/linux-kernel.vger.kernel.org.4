Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7070F73F9A4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjF0KG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjF0KFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:05:48 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2087.outbound.protection.outlook.com [40.107.9.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44EB26A5;
        Tue, 27 Jun 2023 03:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtlwAyyo/fknQHJxjUxn4MnqpNDYAFKFbQ0dqeiRSuy77r+ZVaN+RqZ//mUDG066sWDo29gV4QAYDv6OkYjgQLfHcQ044Iwye+KqhI9AevzpqY9HJX/OEBqMdJR4JTYuB2G7SDfMpsyF/pnoEFb2im9ps1y6LpcCCow9pHgOwZ9+vmAIfuT/OyHmrGsjLyMPaYtL3EXd3jgMQWcvCE3afIbiL89khA99PE3iy+T1OhAaavyM1vaBePOW24xlFsl4cRkufG1GZ1tJO4oASudwhbACjtAjpabOz59PxM3tZYYkWAhHd1tAnTJTOzuNagEmy/Jt2fiPU1QmSdgwfvESyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4QJtBuNS4zHuZUXhgqIvEsG5LJZOhqciVpxxwXdj9c=;
 b=BhWZMcJI5gPNAh/CTsl/2mN76U4vZ8ZHEiMD+KVIeETNmRerMzzWamb6r2rLfWuv0r3KQMc9Qct3RuyDOrUnc6QlBrewwmJ0NHYLqcaq3XiY6RH7JbvIvWAjfJLaw+oJziiywNMA5ssOiFb3UG6PFWiZNoBVV0wbKpEt31w6MfoK1g84Gn1kd08jpSsFATbQQNo5yqFj4Tm2DZezzr7xDY/D7E9lEW0codSmS/cEf/+AFpqtC73IzuvwJSkXDDVlYY0g+7Q/P/GKMq7/J1s81/KihwRKSydGYj6pWeZKmj6E0+EyowH0h9ukp573ABCk7fIZ3MTUf+kl9gFFOmugAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4QJtBuNS4zHuZUXhgqIvEsG5LJZOhqciVpxxwXdj9c=;
 b=fYt1IFeE68sky850qPpbsgzQjn43mAXQOAj9nD1FHiJSKthXCcPiSQMK2Myy4s3Uop3XqijB2qJ6jj419XVblcZOUUuyYSMLz7cVWj4AsbiJ5sBHM+Pwbbbm7Vhma02tl2y+e/RFwG0IRoJvk7JzU68bdwZjzHcuJQZTDiwXxdhYs6slj6jPWmYojYpn4kLx4MV2+Lc8AgSnP/aWjC3to8xdxTF4Dg2WL7pxWpU59RS1Kwel5xoaQS4831SJdoQCePcmeqnYcSQsZFG5m1jkkhL0ruFhTEe6c8gqgZ7C6g3Wb7A5vURXk2I1BrpNpjykQ1w3bnUQUzVuI8HYjd3tVg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2308.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:35::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 10:02:14 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 10:02:14 +0000
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 13/13] ASoC: simple-card: Handle additional devices
Thread-Topic: [PATCH v6 13/13] ASoC: simple-card: Handle additional devices
Thread-Index: AQHZpbD4F31hH0bJxESPeddNVX0586+ecYGA
Date:   Tue, 27 Jun 2023 10:02:14 +0000
Message-ID: <9a3ea029-15e5-9273-3c66-f165056c2a56@csgroup.eu>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
 <20230623085830.749991-14-herve.codina@bootlin.com>
In-Reply-To: <20230623085830.749991-14-herve.codina@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2308:EE_
x-ms-office365-filtering-correlation-id: cc59848d-ba26-479a-0b80-08db76f59517
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vM8Ta5JdEFcug2Jq1BUmyYBtU6kAqrxKfdSAHFrfQbdST4/xbRyf4wwcIzWhTZjdkcfrkOHa6I/qZeP4ctv9KEKCRprV+iWvxnmRGvTT9p8QJFQ3uE7p+skNLVIjIAY+S1yMUWDo1MpkD0WLdHgLHLbXlk08IaTtHWrl/cXfAVfywPZ/49alOFXrY1FHym8d0tmnkuK3xmdL/Z1vJ/dDDc5FtRN3G5697jQW94cddi7793GeMbwhjOsKN4xoHFIxGKCfrovrA+hmysOB6jGvxuTUvhWbGPSXs01x45mQMcLSzKqFrXSZ3cxLh0V+YOJFKCFDN43bSpaIthlXksbEOzpR7Ur8sgrWufr/NB9YD7UlfjKfoRqYEbHDhKZMiQd6X1v/cKiY8N1XXEKHvC7PMb7UmHn23qqgWNEgofE5U9ipyy+Xqa0OG6bzKD+VK0Lrzv7pndziB5xB1+pS/STaw/3N1r0XbJvh2BuMMCtAm4Gyt6kLZ0EHclJlw8bUWuzIsSPkXYXHEx+JcV3lpZmZJYMdPpLqVYAWpSl0f2pz16WkmWK0q3BMlDvFGdFjmFTzqz+XA+DgpL1OEMavVHis7leck9zSaBIiALay1va+F7zc9I981nUeGC0Ck8SI+ZUAWzZdzSvO41d/6VCbDUrtFOoZ6PygjdJzLGj2uLCNuotQlG6Ag1LZAIgmB0ZQlF4b3dxVhM6aJOt6mj9LxgTL4jGNDfKm5PJVEPrY454M6xw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(83380400001)(2906002)(186003)(2616005)(71200400001)(66476007)(66556008)(64756008)(66446008)(91956017)(76116006)(66946007)(316002)(54906003)(110136005)(478600001)(7416002)(5660300002)(6512007)(26005)(44832011)(6506007)(8936002)(6486002)(41300700001)(8676002)(4326008)(38100700002)(122000001)(921005)(86362001)(31696002)(38070700005)(36756003)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWtuU1FNQkRrWHJoRzl5RDZWOEEzVjh1d0xNTXpSWXlFNkZkQlM2VWFMWGlC?=
 =?utf-8?B?aDMvLzNOcmlmYzZyTHRNL2ExTG5OQmhmZk1IdHoyT2hscE5ibFdRYzR2RDgz?=
 =?utf-8?B?S0loYlhwdE1QblN4SWlWMk1HZERzMFc0RE5FRFRLNjZ3c3FJOVFJNlhjRDNr?=
 =?utf-8?B?VFg5ZGJ0NE4wRHlEU3ZKQzZTL1lJUzZJaDZLMCtqelFVMld1d216YlE5OGIr?=
 =?utf-8?B?cE1JR0pWaS9LNmFvMThpQWVRNldkMWRTQXNEVXI5bm9LVGRGdnl5cXBXY2RH?=
 =?utf-8?B?T2dNYVB0RXd2NGZoNW9qOEQ2N1NKSy9nRE1IcHFjUkZ1MG9OZlFlNGpiU01Q?=
 =?utf-8?B?YU1YdkpVQWI4aE0zdUZyV1FaUlFJQjBTb05LbnZtNFRmN1FkN0g1bUllL1kr?=
 =?utf-8?B?aDI5L2lUR3Y3aVQrNTAvVW5oU3JnUkVrL0xBSldDR1JXeVluZlcvMmgycnY1?=
 =?utf-8?B?QjNkYUthRC9zRGtxSWVIT1IrdUNkOHRGRVZFZ3IyaGZQL2ZxNGtxbEtuMk1K?=
 =?utf-8?B?b0U1Rmx1U3ZTQ29LZUFXOHB6QXNnM3d5dXU1dTl5d3ZoZFRnNXhNV0ZqbG5w?=
 =?utf-8?B?bkNPRFJGVGdVVmNmTGdoYVFJcnR4VkV5cllNelh3MVVVNEpEdHl6TldUSFBW?=
 =?utf-8?B?TFlsZFp5RURhdS8rNVVyV3NHRFc5d0VOOFFqMWV2L2dGRU15Tml1alBYbkps?=
 =?utf-8?B?bERHcVRGWEFNNksyUjVTT201b2NXSS91NXducTIzeWd6eWNuZUdHRWNHQ2I0?=
 =?utf-8?B?VmowRUY1aEV6MVlJWU9LMnNKdVppWFNZeFp0WUtGUWpLekEvOU5pYmNHRWlx?=
 =?utf-8?B?bDg1eFZ3bmpJVno2K0hKSDh1cmhLSXkwU1Yzd2dRVGlLK3FKK2VXZUxWZjdE?=
 =?utf-8?B?T0ErV212Y2lyR1BXaXFmL1hUSUorNm44NXNyZXpTTmtaUnM4RVRFU2FLcEht?=
 =?utf-8?B?TzFFU0lZZjVnUjgxSjRPeFp3QXlVTGdxVmRiOHl2dkxQVkQwUGMzVmRNc0Nu?=
 =?utf-8?B?OU9vSm5IVDZ5dnNuc1pDYnNYcjZxbWs4L3k3eEI2dVhjUWplaVF6VDkrR2dt?=
 =?utf-8?B?UUpPT2pmQXNyWlRrQWRVSzFCMWx2Yy9MRldYNlNVcEhsWUNaVmRBdkpIMnB5?=
 =?utf-8?B?ZTA1VHllaktrb0NFUUdOVGs0UXltSTQ2RjVJK05pczQxbG9RQUhwUVgxQXdG?=
 =?utf-8?B?d2lZS2MzWk9YdkxxK1VGR2Qwd0R5YWUxYWdoaEFsZDhkdjR4ajVEQUJGanF5?=
 =?utf-8?B?N1NhSlRGSzlZYXRJckd1dFFKNG5KSEdZOURWL3ZMOUt0UUpHb0grTTJxeUt6?=
 =?utf-8?B?ZnF6TUVQTWJ0MDUxVUVIVTJNMGRVMWdxamJkSnpqQ2lQU2pTd3NGdWV0ODhv?=
 =?utf-8?B?OUhRUStpcXUwMVdsYWlFd2Y2MEZTYmtlSDRrOHpsZUl0cGNWcTZnV25GdDA1?=
 =?utf-8?B?UWRZQVdGdm56MGRrU3pGKzZRVHYwSERqMTZxbzBQR0RiSXJXNjJ5OFZHdWFR?=
 =?utf-8?B?NWFWSEtLYXRlS3hnZnNzL0Irc0l3M0JWWU1NUjA1MkN1QmgzM3VtM1VKY0Y4?=
 =?utf-8?B?SEc4ektGUytGVmE2QkdWdWl5SG1nQkxEdExWdGNXWjRXOHltZ1h0N3E5TS90?=
 =?utf-8?B?OFdVV0dhbDNqVDlUZ3h0MzFIU0EvdnRvQjN2c1MwNWVkQzdTUENHM3Jvb2Ra?=
 =?utf-8?B?UTFxSVRiYVU3bjFrSzBsRzc2RnpMUlA0aXh0Q3ltejgvYjJveGpLdW5mMkRO?=
 =?utf-8?B?MEJPdHM5N3ZrN003bmxRQklhTU9iRHovUEo3WTFZTTlHekhDMDhRdWNQeFda?=
 =?utf-8?B?SGJicVpBRXN4MUlTbzdmS0psa2haVnpqQk4xdTJCdEYyb0U2OEkydkFRRkp4?=
 =?utf-8?B?SnI1OHJBendXc2E4R1YvTC9md2tlTXFTa3JudE9SWm5VY1ZCKytQTFlZK1Jz?=
 =?utf-8?B?RTFISndXWEgyeE9USzF5S0tmdFNyQ2tWbkNReU81eU1JdVh1d1JHN1ZlMTRp?=
 =?utf-8?B?SHZ4OUt2ekFKQTRSRmZiMkVXSWcrTFk0YWtGcVJheGV4QlY1UmphcVo1VlMw?=
 =?utf-8?B?WU01ODgyZVhXZGhaUWtmMDVHV2N5bFM0blhtcFVaOXFFQm9MUmtDcFRKQWFh?=
 =?utf-8?Q?N7VaVFvmewe3PU7UkJ+NLxpcR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F179C9AD662EE94D97D9FD1C0E503562@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cc59848d-ba26-479a-0b80-08db76f59517
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 10:02:14.3289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCX5B8QLlaIrhttF3fBj6h5PrWa6pdsF4PfpBQy4VMaeqspCd8BTi/DlDC7od3bN0yFBtoebdFWvIlGJyuND4wUJto94jLl6M/brbYhVBqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2308
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
biBhZGRpdGlvbmFsLWRldnMgc3Vibm9kZSBjYW4gYmUgcHJlc2VudCBpbiB0aGUgc2ltcGxlLWNh
cmQgdG9wIG5vZGUuDQo+IFRoaXMgc3Vibm9kZSBpcyB1c2VkIHRvIGRlY2xhcmVkIHNvbWUgInZp
cnR1YWwiIGFkZGl0aW9uYWwgZGV2aWNlcy4NCj4gDQo+IENyZWF0ZSByZWxhdGVkIGRldmljZXMg
ZnJvbSB0aGlzIHN1Ym5vZGUgYW5kIGF2b2lkIHRoaXMgc3Vibm9kZSBwcmVzZW5jZQ0KPiB0byBp
bnRlcmZlcmUgd2l0aCB0aGUgYWxyZWFkeSBzdXBwb3J0ZWQgc3Vibm9kZXMgYW5hbHlzaXMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBIZXJ2ZSBDb2RpbmEgPGhlcnZlLmNvZGluYUBib290bGluLmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nn
cm91cC5ldT4NCg0KPiAtLS0NCj4gICBzb3VuZC9zb2MvZ2VuZXJpYy9zaW1wbGUtY2FyZC5jIHwg
NDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDQ0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc291
bmQvc29jL2dlbmVyaWMvc2ltcGxlLWNhcmQuYyBiL3NvdW5kL3NvYy9nZW5lcmljL3NpbXBsZS1j
YXJkLmMNCj4gaW5kZXggNmYwNDRjYzgzNTdlLi5hZTRhNDcwMTgyNzggMTAwNjQ0DQo+IC0tLSBh
L3NvdW5kL3NvYy9nZW5lcmljL3NpbXBsZS1jYXJkLmMNCj4gKysrIGIvc291bmQvc29jL2dlbmVy
aWMvc2ltcGxlLWNhcmQuYw0KPiBAQCAtMzQ4LDYgKzM0OCw3IEBAIHN0YXRpYyBpbnQgX19zaW1w
bGVfZm9yX2VhY2hfbGluayhzdHJ1Y3QgYXNvY19zaW1wbGVfcHJpdiAqcHJpdiwNCj4gICAJc3Ry
dWN0IGRldmljZSAqZGV2ID0gc2ltcGxlX3ByaXZfdG9fZGV2KHByaXYpOw0KPiAgIAlzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKnRvcCA9IGRldi0+b2Zfbm9kZTsNCj4gICAJc3RydWN0IGRldmljZV9ub2Rl
ICpub2RlOw0KPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqYWRkX2RldnM7DQo+ICAgCXVpbnRwdHJf
dCBkcGNtX3NlbGVjdGFibGUgPSAodWludHB0cl90KW9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShk
ZXYpOw0KPiAgIAlib29sIGlzX3RvcCA9IDA7DQo+ICAgCWludCByZXQgPSAwOw0KPiBAQCAtMzU5
LDYgKzM2MCw4IEBAIHN0YXRpYyBpbnQgX19zaW1wbGVfZm9yX2VhY2hfbGluayhzdHJ1Y3QgYXNv
Y19zaW1wbGVfcHJpdiAqcHJpdiwNCj4gICAJCWlzX3RvcCA9IDE7DQo+ICAgCX0NCj4gICANCj4g
KwlhZGRfZGV2cyA9IG9mX2dldF9jaGlsZF9ieV9uYW1lKHRvcCwgUFJFRklYICJhZGRpdGlvbmFs
LWRldnMiKTsNCj4gKw0KPiAgIAkvKiBsb29wIGZvciBhbGwgZGFpLWxpbmsgKi8NCj4gICAJZG8g
ew0KPiAgIAkJc3RydWN0IGFzb2Nfc2ltcGxlX2RhdGEgYWRhdGE7DQo+IEBAIC0zNjcsNiArMzcw
LDEyIEBAIHN0YXRpYyBpbnQgX19zaW1wbGVfZm9yX2VhY2hfbGluayhzdHJ1Y3QgYXNvY19zaW1w
bGVfcHJpdiAqcHJpdiwNCj4gICAJCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7DQo+ICAgCQlpbnQg
bnVtID0gb2ZfZ2V0X2NoaWxkX2NvdW50KG5vZGUpOw0KPiAgIA0KPiArCQkvKiBTa2lwIGFkZGl0
aW9uYWwtZGV2cyBub2RlICovDQo+ICsJCWlmIChub2RlID09IGFkZF9kZXZzKSB7DQo+ICsJCQlu
b2RlID0gb2ZfZ2V0X25leHRfY2hpbGQodG9wLCBub2RlKTsNCj4gKwkJCWNvbnRpbnVlOw0KPiAr
CQl9DQo+ICsNCj4gICAJCS8qIGdldCBjb2RlYyAqLw0KPiAgIAkJY29kZWMgPSBvZl9nZXRfY2hp
bGRfYnlfbmFtZShub2RlLCBpc190b3AgPw0KPiAgIAkJCQkJICAgICBQUkVGSVggImNvZGVjIiA6
ICJjb2RlYyIpOw0KPiBAQCAtMzgwLDEyICszODksMTUgQEAgc3RhdGljIGludCBfX3NpbXBsZV9m
b3JfZWFjaF9saW5rKHN0cnVjdCBhc29jX3NpbXBsZV9wcml2ICpwcml2LA0KPiAgIA0KPiAgIAkJ
LyogZ2V0IGNvbnZlcnQteHh4IHByb3BlcnR5ICovDQo+ICAgCQltZW1zZXQoJmFkYXRhLCAwLCBz
aXplb2YoYWRhdGEpKTsNCj4gLQkJZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZShub2RlLCBucCkNCj4g
KwkJZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZShub2RlLCBucCkgew0KPiArCQkJaWYgKG5wID09IGFk
ZF9kZXZzKQ0KPiArCQkJCWNvbnRpbnVlOw0KPiAgIAkJCXNpbXBsZV9wYXJzZV9jb252ZXJ0KGRl
diwgbnAsICZhZGF0YSk7DQo+ICsJCX0NCj4gICANCj4gICAJCS8qIGxvb3AgZm9yIGFsbCBDUFUv
Q29kZWMgbm9kZSAqLw0KPiAgIAkJZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZShub2RlLCBucCkgew0K
PiAtCQkJaWYgKHBsYXQgPT0gbnApDQo+ICsJCQlpZiAocGxhdCA9PSBucCB8fCBhZGRfZGV2cyA9
PSBucCkNCj4gICAJCQkJY29udGludWU7DQo+ICAgCQkJLyoNCj4gICAJCQkgKiBJdCBpcyBEUENN
DQo+IEBAIC00MjcsNiArNDM5LDcgQEAgc3RhdGljIGludCBfX3NpbXBsZV9mb3JfZWFjaF9saW5r
KHN0cnVjdCBhc29jX3NpbXBsZV9wcml2ICpwcml2LA0KPiAgIAl9IHdoaWxlICghaXNfdG9wICYm
IG5vZGUpOw0KPiAgIA0KPiAgICBlcnJvcjoNCj4gKwlvZl9ub2RlX3B1dChhZGRfZGV2cyk7DQo+
ICAgCW9mX25vZGVfcHV0KG5vZGUpOw0KPiAgIAlyZXR1cm4gcmV0Ow0KPiAgIH0NCj4gQEAgLTQ2
NCw2ICs0NzcsMzEgQEAgc3RhdGljIGludCBzaW1wbGVfZm9yX2VhY2hfbGluayhzdHJ1Y3QgYXNv
Y19zaW1wbGVfcHJpdiAqcHJpdiwNCj4gICAJcmV0dXJuIHJldDsNCj4gICB9DQo+ICAgDQo+ICtz
dGF0aWMgdm9pZCBzaW1wbGVfZGVwb3B1bGF0ZV9hdXgodm9pZCAqZGF0YSkNCj4gK3sNCj4gKwlz
dHJ1Y3QgYXNvY19zaW1wbGVfcHJpdiAqcHJpdiA9IGRhdGE7DQo+ICsNCj4gKwlvZl9wbGF0Zm9y
bV9kZXBvcHVsYXRlKHNpbXBsZV9wcml2X3RvX2Rldihwcml2KSk7DQo+ICt9DQo+ICsNCj4gK3N0
YXRpYyBpbnQgc2ltcGxlX3BvcHVsYXRlX2F1eChzdHJ1Y3QgYXNvY19zaW1wbGVfcHJpdiAqcHJp
dikNCj4gK3sNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBzaW1wbGVfcHJpdl90b19kZXYocHJp
dik7DQo+ICsJc3RydWN0IGRldmljZV9ub2RlICpub2RlOw0KPiArCWludCByZXQ7DQo+ICsNCj4g
Kwlub2RlID0gb2ZfZ2V0X2NoaWxkX2J5X25hbWUoZGV2LT5vZl9ub2RlLCBQUkVGSVggImFkZGl0
aW9uYWwtZGV2cyIpOw0KPiArCWlmICghbm9kZSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwly
ZXQgPSBvZl9wbGF0Zm9ybV9wb3B1bGF0ZShub2RlLCBOVUxMLCBOVUxMLCBkZXYpOw0KPiArCW9m
X25vZGVfcHV0KG5vZGUpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4g
KwlyZXR1cm4gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KGRldiwgc2ltcGxlX2RlcG9wdWxhdGVf
YXV4LCBwcml2KTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBpbnQgc2ltcGxlX3BhcnNlX29mKHN0
cnVjdCBhc29jX3NpbXBsZV9wcml2ICpwcml2LCBzdHJ1Y3QgbGlua19pbmZvICpsaSkNCj4gICB7
DQo+ICAgCXN0cnVjdCBzbmRfc29jX2NhcmQgKmNhcmQgPSBzaW1wbGVfcHJpdl90b19jYXJkKHBy
aXYpOw0KPiBAQCAtNDkzLDYgKzUzMSwxMCBAQCBzdGF0aWMgaW50IHNpbXBsZV9wYXJzZV9vZihz
dHJ1Y3QgYXNvY19zaW1wbGVfcHJpdiAqcHJpdiwgc3RydWN0IGxpbmtfaW5mbyAqbGkpDQo+ICAg
CWlmIChyZXQgPCAwKQ0KPiAgIAkJcmV0dXJuIHJldDsNCj4gICANCj4gKwlyZXQgPSBzaW1wbGVf
cG9wdWxhdGVfYXV4KHByaXYpOw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQlyZXR1cm4gcmV0Ow0K
PiArDQo+ICAgCXJldCA9IHNuZF9zb2Nfb2ZfcGFyc2VfYXV4X2RldnMoY2FyZCwgUFJFRklYICJh
dXgtZGV2cyIpOw0KPiAgIA0KPiAgIAlyZXR1cm4gcmV0Ow0K
