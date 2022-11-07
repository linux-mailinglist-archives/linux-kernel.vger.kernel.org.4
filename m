Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED13D61EEEA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiKGJ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiKGJ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:26:07 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485E317432;
        Mon,  7 Nov 2022 01:25:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=may0D3VN6N8idh/00oNUMqj2MphlvT7hg9GY51rBL0OMFee7UUCV/jTtczm36QdwbDsNKRwLPnczcQ0dAO7iikMizIRUy0iNMUau8NH1H7kF593OvblQxekls9xdP/Hkz5PMLmUgfnO86dSk5P41EoEO6tRF8JUc4f1OKDo8AncItpxBj/iz8zuFYTpAxX3XvWM60Iv5hIPYXLk1XmAQE1K+KPFoEClOBDEbO1idsZDdmas3wLj90t+eBFg6j7tucFWb2of4tduV7ysotnR5pTKj8Sc8eJ1roOuEMFJc/Ff3VPSoWwdWGpJWxa8KD2JkqOSX2faUNJRVgOXnqPGIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48IVJStpx/mrSZ1Ma3laIoGJTQJDISHNo5JWa4sAGKE=;
 b=KvY+1ffR3CQUisB+pRFH3WTZ7/nBee6VP2GfuO29bhZoEiv0EVhVvI3g5gZ3wl+iuLYNI4o3lp6pmGB3hGEsFiqeJVL1BEAdtweYMpEf0dJ3vOC/HvgwGGCuW/ELRk37NjozqcPxl5emKoExaQH+5EHlKVXu48sxZYSSYYYoCrI5Rlh55Eh/2U+3t8t806WIEGr3ENb7tilodi5PaiKqb/ciSIyYG2eTjPlTKJx8Qo48yA+tSGiIn9oAnRtMQL4K+yEhpVMAZD0nmOkHO0oQXpiONUvfqabqf7UGlBrnlYvlowoBjvlFylXc7NOmgs1McJ2GLkme23v8U8RNTcL9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48IVJStpx/mrSZ1Ma3laIoGJTQJDISHNo5JWa4sAGKE=;
 b=mxT9qCQ8V27pswQiJ/v2kOHfOJY7Az1JqOH7Cgb2YvpA1xNtdHBmPbdPBGLY4xTsQnujqiaclquncJL39/ldH29j3dz35lMohVVvOjaQNm7KmD8ynUqbCe7VcKl/ChanID655tdUUB0uPDy/oAA6GpCFdbhSQ4b5urtAbcIoTBWa5GG8MTpBe1Vn39jzMXFH+9es6woeHzRbGa0PGd0E5nYy7q6ZLKAtpXUX+GPKoONxWhyc61KZg+3LiV+P9gr7fEPoxTx1TpuVRzh51ngjhJtFd4Lf+d0+z6+bKAngbUCT5Xo3g5bPCuR6c7epTf67H9P0z2te0GB0JdBDVWjnCA==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 KL1PR0601MB3972.apcprd06.prod.outlook.com (2603:1096:820:25::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 09:25:38 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831%6]) with mapi id 15.20.5769.019; Mon, 7 Nov 2022
 09:25:38 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "garnermic@meta.com" <garnermic@meta.com>
CC:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHY7pXw7ASL6kfe60CZV9tzr/Df/64ryjuAgAfp3QD//3wFgIAAjp2A
Date:   Mon, 7 Nov 2022 09:25:37 +0000
Message-ID: <E3A2DC80-3D8D-451F-9EA1-A3262F4A3C43@aspeedtech.com>
References: <20221102083601.10456-1-billy_tsai@aspeedtech.com>
 <20221102083601.10456-3-billy_tsai@aspeedtech.com>
 <OS0PR01MB5922014A7D74A884D2E7BDC286399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <C7224BE1-D81E-4FE0-8B7C-5A3CA69898D2@aspeedtech.com>
 <OS0PR01MB5922EC7AB73207DF30F42A0A863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922EC7AB73207DF30F42A0A863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.66.22101101
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|KL1PR0601MB3972:EE_
x-ms-office365-filtering-correlation-id: d9a59054-8688-4fa0-0323-08dac0a20832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ad5kutSwaPZyseajdF//r8f9tZ/4K7Xl/gi48ydBRhwP1DjChk/g72Li5nTlkbvSzgImPnOPOv9wcZn4rTT+fymVmKLMrwgu3jMfusGa/xYhMNbZyiFRfnbXLjrKmZvbQwLPyHLERJTbABhkA08mCpGlP/9/qqWynJk1n2yDfHHqbXTW4I1PyMuCeL2h6UrpCIz5uqEIyvg+kpZhY6fWnP4PUPjLgbXs0TOgruTWSSCs3mWu3pY0wW/mfFsUAttP2cwmPaw9aU/ZEFuaFsKKx42GjMAGXGhxJ7ki1BQQCllwzZDh/+aSlbOKiQoRhdBTDLngqiY2lRCTcfqkXbB7FTDUrUpVGkpgXjpd60rd5oWtLlBQXuFEzAtnoMPXRNc+tzYEKdeGwhdETufrTRCR07A4Pxs16JKSLcI9Alum43xgPwsxaw26TMxGGAIuTFqZrOg8pIFGeXUmt76NEfeoORMZuFLAjI4oL+Go01kfyNISh+TBtml8+UubYph+oNXKjC26eZz4zQeMl/3Q9bkjRdBm+F6kfWtEfR1KqLhX9TZPSa66Xxn8ItBFxq3/BVH6eVJeGJZTosoz1/cjXojiOFDuBEYaXPeCBTlSZvN21sxUuXKmj1igEtCqT/8OLREX2+vH85KUNqHO7yDN/ZqQOXebWAqLcJQfZSFHMAFK4w7rdr5fuaMuv9fbyLuyNNdwY9sZp+q3wqBKo++mx5MHRzh7eVmw8+v7SXaFZ2st6i5aV9xDbJnKdVM9bUcCztG906SS5WTl0nLu1JWOnrNuKpUbGoF0uZjx85ut8V5JtsJQKqIlhrGBMP/OQYgrvtsp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39850400004)(376002)(136003)(366004)(451199015)(33656002)(36756003)(86362001)(921005)(38070700005)(2906002)(2616005)(26005)(6512007)(186003)(53546011)(122000001)(83380400001)(6506007)(66556008)(64756008)(66946007)(66476007)(4326008)(66446008)(8676002)(316002)(54906003)(478600001)(110136005)(7416002)(91956017)(8936002)(76116006)(6486002)(71200400001)(38100700002)(5660300002)(41300700001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWx6VHcxcklaYnZUVGphTmxBOXRVMGVwU3J6UWQxVlppSk9GeDV3eVBqNUpz?=
 =?utf-8?B?NEpJZmF1T1ZWbkxaSWdoQlVkV1V1UStuV0pwTEF5aEk2VzJDUDlmQWRhL0s3?=
 =?utf-8?B?djhlQWdtRjc5ZW9uSmdlT2JGbGRCMk9JcHkrNmlDY2M3d2cxUHBicytCZnBC?=
 =?utf-8?B?NUxieWVwM3VHQ1Zwbkt4T1FRNThhQlowZmF4S0pESTNCZ05zMmt1dVNIUXhV?=
 =?utf-8?B?MWZWRjJhZmk2Mk1BQlpvOEdZQk12MzhTZmR5YjYzb2diQVc0VkxXL0htQWJy?=
 =?utf-8?B?cGVlOUpyVjRFZm4rMjFrMWdjUjBjZTM4UTdGM0pnOWYrRjBnYnF0T1ZDSThH?=
 =?utf-8?B?UkZLcHM3RjhDZDVuN1ZlUm41NVZ6ZWtucmdBZUgwUEk5WkhzQkh5dmFrbW5B?=
 =?utf-8?B?aGpiQVFEMzJ1N3hnd2VNUG9GYkw5RXh2QjBmMkJ0K3ZNQnVqZXVEN3JMOCtp?=
 =?utf-8?B?Mm5raTFOMitJY0N3WnZrcXptM05YUGlQZy9XV0QxeWx0bDg4cnhFMkFzckcv?=
 =?utf-8?B?ellDdWZBK0VBaGpzaGlTRzRlWE1oK2trZWFaSUREVlRKWGszTEJPVS9vUkds?=
 =?utf-8?B?dm9sSllJR0ZaaTR2UEJxbmZpc1ZKVFZoQlhnVnRRNnVyS1FSMEhzT3pndU0z?=
 =?utf-8?B?bWxML1FKUUMrd3pSY3pLN0FlSllpTGV6Z2RhV1dKblZOd1lBaFlaN05zdXNh?=
 =?utf-8?B?Sk4zZkViQzArS1N3dzhsNzJ3TEVOQkJRY0llMnhlUjdWQWZ0WlA3Qnl4SFJD?=
 =?utf-8?B?WkZXNUphaklwNk1KVDIvYkJ0VGdiTTgwbVIzTjZ4ZTVzMys3QUNzd1R6QUli?=
 =?utf-8?B?cVQ2c0JJaUdQTURKQUpPWGsxUjQ3NWhkWnV1RUR4cUViVDZWVllpUEp4QnhJ?=
 =?utf-8?B?OWgzdlIyRzdPMVk1VjFLOWZjZmcwY3hoMUoxcXVVRHRWVDQydjdFNU1zRHho?=
 =?utf-8?B?OUJPR29YZTFtWm5kVnk3a1NrZGZlSTNiNU9JQlBiUTlGVTNqNnBEckdKVWty?=
 =?utf-8?B?cXg3TmlKUkVrQThONEhDQ0lFbUEyZGU3VDgzTzNQNGRabzZYUkpTS2lVMGVZ?=
 =?utf-8?B?ZVRhWE10bDFXVjFFQmdnT1VzTkc4c3FXQ3drd1ZnNG5HMlFTNWllRCtCME1u?=
 =?utf-8?B?U3VSSzhlOWFabU9DUFN2dWN4UVVxdXBabm4vcmk1ZU8rMHFuU1JUZVgxS1Mr?=
 =?utf-8?B?WC9EVUgxa1JKODNyV2F6ZnBVd09Ydnc0R0FTZitvQ1JaNDJNUXU0TTAxZjhP?=
 =?utf-8?B?OFlPUVlMcnFtNlM4cHRsSHp0bEJzRXIxclZTOFhQdUdvVlg5VEhyb3U0RXg2?=
 =?utf-8?B?cjRCZ0M2RTNMbnVMaXB4OSs5bi9mSlU3amtabi9tdnhkdjF0aG1hTWk2aDh4?=
 =?utf-8?B?OCtJVFpuSm4wYkk3MUtvZFMzUmhrUjZoaDZ1TFJpME5UMGszeU1aYytMaSti?=
 =?utf-8?B?Z0dBU1poWk4vdzFIbFFXN1U4dDlaRGJrOU9ZU0hUdFRWbGwwZFRFY1VRRmc5?=
 =?utf-8?B?V1JHbVFLRXNCb1Y4WmpjNGpSNlNIN1N0cXR3akdrbjdmK3JsVHlrSjBWRlJy?=
 =?utf-8?B?Q0V1VFBYQnp3NitmSUVJbnJXRWdmTk1tc1p0WG01R3VEbzNZVEFhTklkTTJh?=
 =?utf-8?B?eTlVWitJRFZKWW9ZNnJJNDUrU2hUUDl2MXpId0kzaVRqcFZNTkRGR0xQeXA3?=
 =?utf-8?B?a29reXhPQmh2MlNJMHI5L01Xa3ZpVEdLd2RWS000eEoxYm56M2kzL3VDMG12?=
 =?utf-8?B?cG13NkpHcE9Cck94OGdJRG10dFpWSlE2Qm5XU0l1N21EbExPR01OcVI1UGgy?=
 =?utf-8?B?cElOOFJuSWxTNU84S0ZLQnY1SmlqZFk2Q0pQRERiV3pPeHN2TjlES2V4ait1?=
 =?utf-8?B?UllUVnlibGFpTUl2RXBYTkxOT1IycGhCS2ZhcnN3K0Z0N3YwRHJtSGFiMlp6?=
 =?utf-8?B?UytzNDN3MVdGdzhtZWRSRDNWRkhFMU5sQ0tOc3d1b2lUWCtqNzhsZFVhRjMv?=
 =?utf-8?B?R0w5ejU5TTVJc01zR01ndStENEN0NFVLWkVlMHl5QVc5T3FsbXl5d1JiVmdK?=
 =?utf-8?B?SWRGWDlleUR4blExQlVUNGkycDRpMUhIL3RxZmRCck9QRE4zUDlwMWJ4ZStZ?=
 =?utf-8?B?NEVhV1IxRHBSaFIwM3ZPelMrLzNIY2xSeWN1WXYvTkZMaTNjWWlXM1NEUkU3?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AC2544701A2844C8783B2B036C8E638@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a59054-8688-4fa0-0323-08dac0a20832
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 09:25:38.0451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGk6QUentDB3ITZy/2s58lbc/9Wmq0gWiFRHR7rv/2x3c1pxe4I5VzXsz3521SxF5AfCQfSn21hsg5fua4krA19JrUIYRTCmxboJHQNBUDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3972
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMS83LCA0OjU1IFBNLCAiQmlqdSBEYXMiIDxiaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbT4gd3JvdGU6DQoNCiAgICA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCiAgICA+
ID4gRnJvbTogQmlsbHkgVHNhaSA8YmlsbHlfdHNhaUBhc3BlZWR0ZWNoLmNvbT4NCiAgICA+ID4g
U2VudDogMDcgTm92ZW1iZXIgMjAyMiAwODo0OA0KICAgID4gPiBUbzogQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPjsgamRlbHZhcmVAc3VzZS5jb207IGxpbnV4QHJvZWNrLQ0K
ICAgID4gPiB1cy5uZXQ7IHJvYmgrZHRAa2VybmVsLm9yZzsgam9lbEBqbXMuaWQuYXU7IGFuZHJl
d0Bhai5pZC5hdTsNCiAgICA+ID4gbGVlLmpvbmVzQGxpbmFyby5vcmc7IHRoaWVycnkucmVkaW5n
QGdtYWlsLmNvbTsgdS5rbGVpbmUtDQogICAgPiA+IGtvZW5pZ0BwZW5ndXRyb25peC5kZTsgcC56
YWJlbEBwZW5ndXRyb25peC5kZTsgbGludXgtaHdtb25Admdlci5rZXJuZWwub3JnOw0KICAgID4g
PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eC0NCiAgICA+ID4gYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KICAgID4gPiBwd21Admdlci5rZXJuZWwu
b3JnOyBCTUMtU1cgPEJNQy1TV0Bhc3BlZWR0ZWNoLmNvbT47IGdhcm5lcm1pY0BtZXRhLmNvbQ0K
ICAgID4gPiBDYzoga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQogICAgPiA+IFN1
YmplY3Q6IFJlOiBbdjMgMi8zXSBwd206IEFkZCBBc3BlZWQgYXN0MjYwMCBQV00gc3VwcG9ydA0K
ICAgID4gPiANCiAgICA+ID4gT24gMjAyMi8xMS8yLCAxMTo1NiBQTSwgIkJpanUgRGFzIiA8Ymlq
dS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KICAgID4gPiANCiAgICA+ID4gICAgID4g
PiArCXBhcmVudF9kZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlKG5wKTsNCiAgICA+ID4gICAg
ID4gPiArCXByaXYtPmNsayA9IGRldm1fY2xrX2dldF9lbmFibGVkKCZwYXJlbnRfZGV2LT5kZXYs
IE5VTEwpOw0KICAgID4gPiAgICAgPiA+ICsJaWYgKElTX0VSUihwcml2LT5jbGspKQ0KICAgID4g
PiAgICAgPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihwcml2LT5jbGsp
LA0KICAgID4gPiAgICAgPiA+ICsJCQkJICAgICAiQ291bGRuJ3QgZ2V0IGNsb2NrXG4iKTsNCiAg
ICA+ID4gDQogICAgPiA+ICAgICA+IFdoYXQgaXMgdGhlIHVzZSBjYXNlPw0KICAgID4gPiANCiAg
ICA+ID4gICAgID4gSXMgcHdtIGNvbmZpZ3VyZWQgYnkgYm9vdCBsb2FkZXIgaW5pdGlhbGx5ID8N
CiAgICA+ID4gDQogICAgPiA+ICAgICA+IE9yDQogICAgPiA+IA0KICAgID4gPiAgICAgPiBwd20g
Y29uZmlndXJlZCBieSBMaW51eCwgbm90IGJ5IHRoZSBib290bG9hZGVyIGluaXRpYWxseT8NCiAg
ICA+ID4gDQogICAgPiA+ICAgICA+IE9yDQogICAgPiA+IA0KICAgID4gPiAgICAgPiBEcml2ZXIg
bmVlZHMgdG8gaGFuZGxlIGJvdGggY2FzZXM/DQogICAgPiA+IA0KICAgID4gPiAgICAgPiBKdXN0
IGFza2luZywgYmVjYXVzZSB5b3UgYXJlIHR1cm5pbmcgb24gdGhlIGNsb2NrIHVubmVjZXNzYXJp
bHkgaGVyZSwNCiAgICA+ID4gICAgID4gSWYgeW91IG5lZWQgdG8gYWRkcmVzcyBhbGwgdGhlIHVz
ZSBjYXNlcy4gSWYgaXQgaXMganVzdCBmaXJzdCBvbmUsIHRoZW4NCiAgICA+ID4gICAgID4gSXQg
aXMgb2suDQogICAgPiA+IA0KICAgID4gPiBIaSBCaWp1LA0KICAgID4gPiANCiAgICA+ID4gVGhl
IGRyaXZlciB3YW50IHRvIGhhbmRsZSBhbGwgb2YgdGhlIHVzZSBjYXNlcy4gQ2FuIHlvdSB0ZWxs
IG1lIHdoeSB0dXJuaW5nDQogICAgPiA+IG9uIHRoZSBjbG9jayBpcyB1bm5lY2Vzc2FyaWx5IGhl
cmU/DQoNCiAgICA+IEZvciB0aGUgdXNlIGNhc2UsICJwd20gY29uZmlndXJlZCBieSBMaW51eCwg
bm90IGJ5IHRoZSBib290bG9hZGVyIGluaXRpYWxseSIsDQoNCiAgICA+IFlvdSBhcmUgdW5uZWNl
c3NhcmlseSB0dXJuaW5nIG9uIHRoZSBjbG9ja3MuIFlvdSBjb3VsZCANCg0KICAgID4gZW5hYmxl
IGl0IGR1cmluZyBwd21fZW5hYmxlDQogICAgPiBhbmQgZGlzYWJsZSBpdCBkdXJpbmcgcHdtX2Rp
c2FibGUuDQoNCiAgICA+IEZvciBjb25maWd1cmluZyByZWdpc3RlcnMsIHdoaWxlIHB3bSBpcyBp
biBkaXNhYmxlIHN0YXRlLCANCiAgICA+IHlvdSBjb3VsZCBqdXN0IHR1cm4gb24gdGhlIGNsb2Nr
IGFuZCBkbyB0aGUgcmVnaXN0ZXIgY29uZmlndXJhdGlvbnMgYW5kIHR1cm4gaXQgb2ZmLg0KDQog
ICAgPiBCeSB0aGlzIHdheSB5b3UgYXJlIHNhdmluZyBwb3dlci4NCg0KSGkgQmlqdSwNCg0KVGhp
cyBjbG9jayBpcyB0aGUgc291cmNlIGNsb2NrIGZvciB0aGUgcHdtIGNvbnRyb2xsZXIgKGluY2x1
ZGUgdGhlIGFjY2Vzc2luZyBmb3IgdGhlIHJlZ2lzdGVyKS4NCkZvciB0aGUgb3V0cHV0IG9mIHRo
ZSBQV00gKHB3bV9lbmFibGUvcHdtX2Rpc2FibGUpLCB0aGUgY29udHJvbGxlciBoYXZlIGFub3Ro
ZXIgcmVnaXN0ZXIgdG8gY29udHJvbCBpdC4NCg0KQmVzdCBSZWdhcmRzLA0KQmlsbHkgVHNhaQ0K
DQoNCg0KDQoNCg==
