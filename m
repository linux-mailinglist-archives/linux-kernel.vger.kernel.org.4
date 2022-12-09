Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4BD647B06
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLIAy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLIAyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:54:23 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A940A4306;
        Thu,  8 Dec 2022 16:54:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LypF70FdcblkRAOnNxeF1mBZl1oHUPD91dNqN6HqcN/ZksJgWmlj0JmPAUDsrf4KGHT2MH2ftK4KwD7Ebph8/dLKW2QqbkUoj903BtX5C95R/5WoykKKcr4kLFXiRCpZhfEf9WldIPta2Qsx+N35recycGgzsOpubwmDwmjVadKKCUaKf2wKcxkVK8ZsNOuTb/yhu2komDibDJE4mIDOX3p9X5XH2F4jCieyD+V9b9eXmN2yWIszgBya/w4JKAfnglrzkWja3bDeneaO3GaOSGDkAZhRAYycJ674vxU13qFX8/q73sTiQpnfq4cHFTEYzgFzpzm+QxP0WDUxmBlzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmqILcC2qXyFYBmCoHN3fSQfxqNfNF8LzBtZqcx0Y2I=;
 b=gQ76VtYV1VBTbqXHk/5v1iy3u76qyPYIGIHO4yKSc4SI8FhvV3ioQmgtdlTF13ghTXCod/gH2vvrEkC2VBiN5Z3YpabgYwsPIi8r5mP7NhXcCGnbq5Th6u4R4ijYivyfunIi422Rnml9QB4LJsD0xecK4agelUK5gb5yhBO0uwkVZB73Y0s3LXi0AE7UHyY/40ttothnt+aGkwSe678Iu37OUv0Kc4jwtn3SBSOI0Gmq7c5ZwspCPnvvPpmTQGt1H5s9/055znt54Fccm6FuFrM8o7d386SNTM5GlZJFw0MGmq4fv/0Qg+agmGbPRcei0370rRBjwhbmGCQLOT38sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmqILcC2qXyFYBmCoHN3fSQfxqNfNF8LzBtZqcx0Y2I=;
 b=TLNoaqZ+HNJkH4sIa+Znrv8poS508srE1jCTO5YcsL5jY8qhjzv3NAB9viiHd2GilVC8cwP609X7wERNZHXIkp577z+uZYkhaDpJmpp1kv/XGHv5RaZFKkljns0Evhw46Qvue98gJpNGjsCjMxEV8sJulWtIpmR1/u7qyEFKjqCJqjjeGB9T38Xuoy91/Hz4uG/z3j3bml9zl1PY1allyznvFdhqywLXeH+aP+mEuVEU837fNNly88Lt8rQhQLxkDuQYD6LKBIvRrlalzfaTga6ipu57Vp9qVdt5HN5Yj1hmwCnm3/RnnbjTD9eyISR2vvfQISXB/zS+rmFO4a9D7w==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 TY0PR06MB5055.apcprd06.prod.outlook.com (2603:1096:400:1bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.16; Fri, 9 Dec 2022 00:54:13 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::b56:707c:e7a1:2e90]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::b56:707c:e7a1:2e90%3]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 00:54:13 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee@kernel.org" <lee@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Thread-Topic: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Thread-Index: AQHY/wMOXeMHCeVuUE6+Ya/NPsQ1eK5MLAIAgAAAwoCAGSzTAA==
Date:   Fri, 9 Dec 2022 00:54:13 +0000
Message-ID: <A5EA19E5-21D8-4954-9636-9B28AC8D946A@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-2-billy_tsai@aspeedtech.com>
 <c4b188b1-06a4-3cb0-a758-e12942e1f67b@linaro.org>
 <27055c13-11ab-cc73-f2ba-c269785b0e28@linaro.org>
In-Reply-To: <27055c13-11ab-cc73-f2ba-c269785b0e28@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.67.22111300
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|TY0PR06MB5055:EE_
x-ms-office365-filtering-correlation-id: 3b6cd0aa-114c-40ae-9b42-08dad97fe3e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QLRAkOIUWnt2s5A67O0iFwncO1jv2pbaLjfIWCTjYutgNOOZvmdbU6oZVdXWxAQG6LWMCyroT5XC9YYNd4+qYxp0/cV4b3zplvynUyoVfx9bar92RNPzq59oSalHX1BygC0n/tSA7Oe/ishXJi5FT6VHFd11SmG9CR7LUXagf/XW50FCxmGoxub7dOnmigMlaHIxm0cXviWYOAGwMScdToWVnuIYoWuDuT31IlM0k6K9ahWthfgQOaim4DIiUAzP8clDoS4Hiqgs8yl9ZQtNeu0JKpvscvKaEY5ao9nA/lMNQkSBrncbjsNtCFzbN25JWatPKzIl/SG36Jgf3zzOsdTgg5gGJFQ6AARh5nBnmAgz2qLQBKhfEACAcfsNap3ur9IPvBsDsYjo1+8uRuolqBq3BM7Jc70xsIk/yWe45CDwQS5uSdJ5uJcLLBkN9b/tQyXZDs0EEeOyKyYqzaE6Rs3D9c1yePcGHvCyX3u1QPbhNRdLbs2MVopPRCbwkCm/l5ArvplJ/NuJLSDCH6QuLn6rJkdCC4wl+LnC2zv382dGLfr1fStZiuJi2ZYNdgxnyvzf9L+hLhDS5BjeneZqBQYw5gINskUURrEOVw6HYhzecBCC0iSwgz1372QBeQNMCJGdvzg8jAK6odjLEz+DNvSoIIvR8lG34H3oGOpp2efrKqT59gziOUCelvk7RJU7OXy5XiVxQyrpA5Cd+UMjXzoUmIYmNj4axFpSmc3HfwU+CeBR8FPATSags5qmUzVQl5gmCZ6WG24f78tu4cD9FgA6Bo/5wnm4puxkxS6aATs0iiyCPzg/Sgpmq7W+0ZAg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39850400004)(136003)(366004)(396003)(451199015)(86362001)(41300700001)(38070700005)(921005)(33656002)(122000001)(38100700002)(8936002)(7416002)(5660300002)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(2906002)(2616005)(6512007)(26005)(83380400001)(71200400001)(6486002)(966005)(316002)(110136005)(53546011)(6506007)(186003)(478600001)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDcvaUlEZUFDM2Y4MW5ReXgyaDd0Y2htazdmYUdudkp0OVRoTTczMDh1aXpQ?=
 =?utf-8?B?VitpR1A2RFJrUm1wYnZwRHBObytHNXR5eGlWakNPMTFmQlVPVjBVaDZzOENt?=
 =?utf-8?B?azdZTjJSMklIdjREUEhEaWVVb1ZDSnZjczFhRk5TSDh6V0RlQ3FKMnppam9q?=
 =?utf-8?B?K3NYSlYvRlZlOHQyOW9XcklSNGsrbmZkeGQ0ZVZGTFc2MVUrQkc3b0FzdFJ2?=
 =?utf-8?B?dEZpc3pRSjJlZHhQNVdwZW0vd3daSjdjTmJudEsvNkdCcXN3VFVHaWY1Mmgw?=
 =?utf-8?B?WjBmTFd3NndMS09LTEtpeTVlQUVpcytIZ0Z0RFhJaDVGQzlyWUF6ckdVZ0ZZ?=
 =?utf-8?B?MDA1RitLSkIySEcvMWV0NFlscnZmZWJjdlY3VHA0SGZnRVBKcThtYmpPeUxs?=
 =?utf-8?B?TmVqZ3Q5YnIrbERaMk1ybWF6SWJaeWYwa2dUdjNOaDV5b0VId05sYlUrRkds?=
 =?utf-8?B?WDRrcHdyRXN3WnNuemlnRndRQml6d1VnVzF6WlhLZnpQeVRtTnV5b0dhOTFL?=
 =?utf-8?B?bmx6UTQ3eldjNk5vNWNpNVhvVTlLdkFEdFByTVdJL3VYYWs2U1V5Qll6MGNQ?=
 =?utf-8?B?b3BackkrY2lNUmhYenZ4ekI4ak4rcWpMUDQrRGlYK0N1aFozS0RDWXhpTTBQ?=
 =?utf-8?B?bEJRV0o2Q1pmUVR5U09xS2g4VWlJMUtjTzhrazRTc3BLVnZFdnlDb1IrSXRE?=
 =?utf-8?B?LzJOVUZsN3dzWjFjRjlIaitaMjM2SjdLYVM0N2NORHlqS2hnTHRhV3AvZDdO?=
 =?utf-8?B?SnVVNEl1cjR6a29ETUNwaGhacjV0RUNwdnBPZHFzVWpPYmptdjh6Vm9zVnU4?=
 =?utf-8?B?Y2I2UXFxdVZReVhhcGxhSGgvV1g4RDZPaHpDelJFd0FBMGxDendyQ3FEY3JS?=
 =?utf-8?B?MExxZ3BWV2lyZmNMcFMvRDRYTGJ2NjlSU1I4Q1VXZGd4ZmtLbURQZjFSRUt4?=
 =?utf-8?B?Z0l0TTJRRUZIcGt3dFpSN3VuaWpDZ3d3MTN6bUlwd200S0VvcjczOUVUbVFj?=
 =?utf-8?B?WGtLNVExY2FOTGVHT0ZUYzVXSytkQXM0U3FwSmgrbkU3ZVVnYXI2N09kMS9o?=
 =?utf-8?B?aVQ1OXJGdktUK2ZMcFgrRlpONWRuUXcwM3QvK1NLT1JOV1cyeWx6bXl4aGI1?=
 =?utf-8?B?OWdHS0d5NVYrbFRWblU2a1dQVStoWWdWdnlMWUJnbmRIb3NNZTFtM0UrQWh5?=
 =?utf-8?B?THRkL08zRXhhekxMSEI0dlVOcTBrekVYYzdKdm1QSXV3RTRUcFFCcGIrMXVu?=
 =?utf-8?B?NkhEZTFzb0ZQeWprU2pMYVBtd1gxWXB1YXJqdmhkTmJITlRXWmFIRVI3L3ZD?=
 =?utf-8?B?SUV3TlZMUEg3UFRFWU1xMnBlL1FveGNnRjNsRU9lZ3pKWklUQzVEL1pvK0VE?=
 =?utf-8?B?T1NvbU9kR2NnMXN4VjhLWWxnREZPbE5rMXAwOGdNc0F0cTl3OEZMOFBob2Jh?=
 =?utf-8?B?K0kwamwyOEc4NXMxZlE0KzNxTEJ2a0NYNG41b3VzQkNQNk9QRi9sS0o1T0Zp?=
 =?utf-8?B?cUpWUytBeFord0ZwR1B5ZERWUUhlM1hqSTNObS9GMUtHZlA2VGwwRlRmMkdY?=
 =?utf-8?B?TWNFN1p5T2xYV2NpL1Z2NUlPWm43YkxzWnRnZEFSUE04MTA5L1c3WlNYUEJp?=
 =?utf-8?B?ZUR2NERTVENIYWZyVnIzbkk5ZWhkOEMwMW5OdHdndlo1anZndXViZmgzTmRi?=
 =?utf-8?B?SlVKdXZtbXNrcTV4YTVYa2xGano2b25yYTZMckJ0M21lbm0wb2ZCVThUWXMz?=
 =?utf-8?B?SXlBZjlxdmNSNWZucXZPN0trUDkva0Q3QThlQlF0NXNiZGN3Q3RrTHRmQVAz?=
 =?utf-8?B?QjN5NnJIWlR6bVJiZ3VtVGY5TlNjVE9FcEhLeXRpYTduMDVhdkR2cHYyb21n?=
 =?utf-8?B?WlozZlVodDVEM0k4WjdhcU83SmNzaXFTVWxNdDRhdUx3a1BBRlpRWGsxYmFz?=
 =?utf-8?B?emY4RlUxdUZvcjZsQkFvR25nZktpS2tFZzBzckVBeFg3ankxR0h2dXJiTFRY?=
 =?utf-8?B?UmlnVWdTVmpBMVc5Q0ZrMGxHYWJkSlVIeHUzT3c1U1kyZ2JVWHIxYktxVmEy?=
 =?utf-8?B?eEZnVlFTVkE1VjZSeTQ5cytrYmFhU2Q4WnRDZUt0cnMvMjh3czV1OVo5ZlVB?=
 =?utf-8?B?a0NHY2lmdXFnVjlIZkM0SmJVN1RMekFTbm1FbEU2WnpyUzdJWmpzeDRuUEJk?=
 =?utf-8?Q?TFdCdmEDt/5LSwyc45AhD+I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2302FDDD49F5034D93C5150086022C19@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6cd0aa-114c-40ae-9b42-08dad97fe3e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 00:54:13.3402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64/UZK7NsRTNc2nVkIVCg5pAy68ISbnc8dBGfMfhs0yOkTPvnsUWoKvGAQICDx3Bj26fk5qgzgUVv55fxAexe3vxM+k/0BlVkbq5e7p/EP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMS8yMywgNDoyNyBQTSwgIktyenlzenRvZiBLb3psb3dza2kiIDxrcnp5c3p0b2Yu
a296bG93c2tpQGxpbmFyby5vcmc+IHdyb3RlOg0KDQogICAgT24gMjMvMTEvMjAyMiAwOToyNCwg
S3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCiAgICA+ID4gT24gMjMvMTEvMjAyMiAwNzoxNiwg
QmlsbHkgVHNhaSB3cm90ZToNCiAgICA+ID4+IEFkZCBkZXZpY2UgYmluZGluZyBmb3IgYXNwZWVk
IHB3bS10YWNoIGRldmljZSB3aGljaCBpcyBhIG11bHRpLWZ1bmN0aW9uDQogICAgPiA+PiBkZXZp
Y2UgaW5jbHVkZSBwd20gYW5kIHRhY2ggZnVuY3Rpb24uDQogICAgPiA+IA0KICAgID4gPiBTdWJq
ZWN0OiBkcm9wIHNlY29uZCwgcmVkdW5kYW50ICJiaW5kaW5ncyIuDQogICAgPiA+IEFsc28gdXNl
IHByb3BlciBQQVRDSCBwcmVmaXguDQogICAgPiA+IA0KICAgID4gPj4NCiAgICA+ID4+IFNpZ25l
ZC1vZmYtYnk6IEJpbGx5IFRzYWkgPGJpbGx5X3RzYWlAYXNwZWVkdGVjaC5jb20+DQogICAgPiA+
PiAtLS0NCiAgICA+ID4+ICAuLi4vYmluZGluZ3MvbWZkL2FzcGVlZCxhc3QyNjAwLXB3bS10YWNo
LnlhbWwgfCA3MyArKysrKysrKysrKysrKysrKysrDQogICAgPiA+PiAgMSBmaWxlIGNoYW5nZWQs
IDczIGluc2VydGlvbnMoKykNCiAgICA+ID4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MjYwMC1wd20tdGFjaC55YW1s
DQogICAgPiA+Pg0KICAgID4gPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZmQvYXNwZWVkLGFzdDI2MDAtcHdtLXRhY2gueWFtbCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXNwZWVkLGFzdDI2MDAtcHdtLXRhY2gueWFtbA0K
ICAgID4gPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCiAgICA+ID4+IGluZGV4IDAwMDAwMDAwMDAw
MC4uZTJhN2JlMmUwYTE4DQogICAgPiA+PiAtLS0gL2Rldi9udWxsDQogICAgPiA+PiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FzcGVlZCxhc3QyNjAwLXB3bS10
YWNoLnlhbWwNCiAgICA+ID4+IEBAIC0wLDAgKzEsNzMgQEANCiAgICA+ID4+ICsjIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCiAgICA+ID4+
ICsjIENvcHlyaWdodCAoQykgMjAyMSBBc3BlZWQsIEluYy4NCiAgICA+ID4+ICslWUFNTCAxLjIN
CiAgICA+ID4+ICstLS0NCiAgICA+ID4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hl
bWFzL21mZC9hc3BlZWQsYXN0MjYwMC1wd20tdGFjaC55YW1sIw0KICAgID4gPj4gKyRzY2hlbWE6
IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KICAgID4gPj4g
Kw0KICAgID4gPj4gK3RpdGxlOiBQV00gVGFjaCBjb250cm9sbGVyDQogICAgPiA+PiArDQogICAg
PiA+PiArZGVzY3JpcHRpb246IHwNCiAgICA+ID4+ICsgIFRoZSBQV00gVGFjaCBjb250cm9sbGVy
IGlzIHJlcHJlc2VudGVkIGFzIGEgbXVsdGktZnVuY3Rpb24gZGV2aWNlIHdoaWNoDQogICAgPiA+
PiArICBpbmNsdWRlczoNCiAgICA+ID4+ICsgICAgUFdNDQogICAgPiA+PiArICAgIFRhY2gNCiAg
ICA+ID4+ICsNCiAgICA+ID4+ICttYWludGFpbmVyczoNCiAgICA+ID4+ICsgIC0gQmlsbHkgVHNh
aSA8YmlsbHlfdHNhaUBhc3BlZWR0ZWNoLmNvbT4NCiAgICA+ID4+ICsNCiAgICA+ID4+ICtwcm9w
ZXJ0aWVzOg0KICAgID4gPj4gKyAgY29tcGF0aWJsZToNCiAgICA+ID4+ICsgICAgaXRlbXM6DQog
ICAgPiA+PiArICAgICAgLSBlbnVtOg0KICAgID4gPj4gKyAgICAgICAgICAtIGFzcGVlZCxhc3Qy
NjAwLXB3bS10YWNoDQogICAgPiA+PiArICAgICAgLSBjb25zdDogc3lzY29uDQogICAgPiA+PiAr
ICAgICAgLSBjb25zdDogc2ltcGxlLW1mZA0KICAgID4gPj4gKw0KICAgID4gPj4gKyAgcmVnOg0K
ICAgID4gPj4gKyAgICBtYXhJdGVtczogMQ0KICAgID4gPj4gKw0KICAgID4gPj4gKyAgY2xvY2tz
Og0KICAgID4gPj4gKyAgICBtYXhJdGVtczogMQ0KICAgID4gPj4gKw0KICAgID4gPj4gKyAgcmVz
ZXRzOg0KICAgID4gPj4gKyAgICBtYXhJdGVtczogMQ0KICAgID4gPiANCiAgICA+ID4gSWYgdGhp
cyBpcyBzaW1wbGUtbWZkIHRoZW4gaXQgY2Fubm90IHRha2UgY2xvY2tzIG9yIHJlc2V0cy4gIFVz
dWFsbHkgdGhlDQogICAgPiA+IHJlY29tbWVuZGF0aW9uIGZvciBzdWNoIGNhc2UgaXM6IFRoaXMg
aXMgbm90IHNpbXBsZS1tZmQsIGRyb3AgaXQuIERyb3ANCiAgICA+ID4gYWxzbyBzeXNjb24gYW5k
IG1ha2UgYSBwcm9wZXIgZGV2aWNlLg0KICAgID4gPiANCiAgICA+ID4gSG93ZXZlciBJIGFtIHN1
cnByaXNlZCB0byBzZWUgc3VjaCBjaGFuZ2UsIHNvIEkgaGF2ZSBubyBjbHVlIHdoeSB0aGlzDQog
ICAgPiA+IHdhcyBkb25lLg0KDQogICAgPiBBY3R1YWxseSBub3cgSSBzZWUgaXQgd2FzIGxpa2Ug
dGhhdCBpbiBwcmV2aW91cyBwYXRjaCwgSSBqdXN0IG1pc3NlZCBpdA0KICAgID4gZHVyaW5nIHBy
ZXZpb3VzIHJldmlldy4gQW55d2F5IHRoaXMgbXVzdCBiZSBmaXhlZC4NCg0KSSBoYXZlIHR3byBt
b2R1bGUgKFBXTSBhbmQgVEFDSCkgYnV0IHNoYXJlIHdpdGggdGhlIHNhbWUgYmFzZSBhZGRyZXNz
LA0KVGhlIFBXTSB3aWxsIHVzZSB0aGUgb2Zmc2V0IChOKjB4MTApICsgMHgwIGFuZCAweDA0Lg0K
VGhlIFRBQ0ggd2lsbCB1c2UgdGhlIG9mZnNldCAoTioweDEwKSArIDB4OCBhbmQgMHgwYy4NClRo
ZSByYW5nZSBvZiB0aGUgTiBpcyAwfjE1Lg0KQ2FuIHlvdSBnaXZlIG1lIHNvbWUgYWR2aWNlIHRv
IGZpeCB0aGlzIHByb2JsZW0gd2l0aG91dCB1c2luZyBzaW1wbGUtbWZkPw0KDQpUaGFua3MNCg0K
QmVzdCBSZWdhcmRzLA0KQmlsbHkgVHNhaQ0KDQoNCg==
