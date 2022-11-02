Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD796159F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiKBDWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiKBDVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:21:40 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B7925C4C;
        Tue,  1 Nov 2022 20:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAee28tU7p0sNzY2AphHGmh2tfiI1zLkhT17QyN6qL3meIsnYA5eOmP19yZeEpPwT/eIx0KhdHR863qBS4P8YB32V6wBoFVQne5YcMBBF+oYcFsTvd3NSoUk4mvbvdPJIKEv57KCYCLWlREZ829zjsJcR8ip2e4mgNwaJ9LFY8gb9v/nxh/Injs9zw/aZh+bOh7CA2RDjXfPbGjkfVQYznW1kktG8M6ZpojLAxuR64/EpGJuuD+5r4d4AtJ4UaNbAh5bjg6WZa8HEo3fEIdig7zYFomjvwy83rbZ3+nvAhbTjh8BB4G6uDgvntnV2AhnOXYVRHXSf6agW6OHJxoSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBOndhZ03xETFgMICQLNX0kCejCitjq8yKIutzoavQ8=;
 b=lyeP+yHOv8bATF97nD4aYIkJEKW6HaUYBPRG0JRIVcPV7ZhyEBzoxzwTNhHWAhZ8fr0mRRpjxzR7dlq9Md/6B9WJUgTvWZGyxZ+taoxUMKB0NwmKiW5KB5Vo8mNaXgvaicpGZvZbvtT4cvXjvQy5s0JzvX7xn8yD8GePek0UAtjsOyqipJDaVp03g+tAfNR5l1OLtIFI26ZgYva9T0xCGSy/baV2D4rU+7Ivj+M6EI6mTSRUluARYvNBtNVA6IG1C2S74wTW4od6tGxOgIsAihwHGfgZdla8qKUi1b66zPG+JoEfk+OkGX00p1sfGOkSXZIapnOuS0ijs3UdJkqNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBOndhZ03xETFgMICQLNX0kCejCitjq8yKIutzoavQ8=;
 b=QOuTyj3eXj204wpTd2a4bwVQgu4B+RdKC12tVnUvZPQJ+xDaMtiGJFA0v3mUq6t9gDz/mDIFqBZBRr1u6i2JP5/cDweMPrVzyjxEbHjUn1VSF/WZ2iqCGG3qOd5fD+pUtpzGqc7+/DBeaPZsjLHp87REI9GrDHLQ0frlhGmXKd+91ghzC+ysNb1WYn1qTT7+MNUtsVlUD0H7fddRMqn5V0AhHjvwKA7bmr+b1uleCrkTj2rLPgX21907H6BJeUpaOwsmaRpFpa60QDGxR4vQq5mFbhBI+H2NVfhcOQsDrPGgkFo0mG995KhTBZXaUIDZUhZuFKDU/1YS2kw70P3Udw==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 SEZPR06MB5788.apcprd06.prod.outlook.com (2603:1096:101:aa::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.18; Wed, 2 Nov 2022 03:21:22 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831%6]) with mapi id 15.20.5769.019; Wed, 2 Nov 2022
 03:21:21 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
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
Subject: Re: [v2 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Topic: [v2 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Index: AQHY7ddeW4ZmCSdnLkm5NlBsHfM2O64qZyqAgAEXnQA=
Date:   Wed, 2 Nov 2022 03:21:21 +0000
Message-ID: <C4090559-71D3-4DC4-A994-474D375DC4EF@aspeedtech.com>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-2-billy_tsai@aspeedtech.com>
 <20221101184033.GA1879756-robh@kernel.org>
In-Reply-To: <20221101184033.GA1879756-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.66.22101101
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|SEZPR06MB5788:EE_
x-ms-office365-filtering-correlation-id: 13fb60df-72a2-4524-1b64-08dabc815067
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S8vJokTMaKAHa0h/z0orZomYGvaU3B2bpvfoBxN/yW49Sdmfd2rdxlC7ylVGjkeC0Ss3vORcpzhpOQY1iK6Uq3l4T2Dkhn3QB+Bfl/R742dk2kYo0WUGMzL5JKY9YQDFuUwrZqguT2epqqFGgecUGXayOZpglH6EsXrXHzHYyDQM36QMLVlwYx8ekFRo8ZcAxeYReC/Vn1j9JwenUDXHgOej/EGYhhWs1U5B3A+42EIOsIYXanSmCJQec+J1chMZyuLLX0A6b+TZDJoMCUiFmzbLlYU1+/t2y9wsh21W+CWXgzbi/YX1h/cseFsLROVNMsdgIxmv9W0hi9wDTc2ysfMYP6IX6cycs5huPSJ+gdiRRGq/iaKnQak30Mp+WbxHDWH5lrkaCPw97o/VyKIaUX0OmG++VN3grm++xnjpqAv/LuJPOjR2ItXaOOQXV1zXhyqbmQvomaCpy+WTRRS1UHk3nkDGnNxv7PEMauJxwDElDxA1rWeDbLQIsF7YpxlruCpQzQ7L+UCU/B9cOBEv+dU3sX/D/D0RH2SDXclbwE/orexsZhkqyb0lyGOs3HQsiA+bMQdcUhgHL1zgkg7cNC8Vg7yxjXHogLyA28nXWpb90bsqRG+DYrg9XFnY669XjFi4hiFX7m6+HivUNhoiFKy1/WHAJ/0lQpKgswkLhLssuVgPjC2sQsvORYJ3UOTfCuLnxAvec3rthyK7Msx63jbJ9NYA1cgb4xVcQQc+ZVOls13LsTv5LBpaxZtLrvp/UhJZfwcvBHzsGaYAqTgT74hCxDX71Ux0Poenw14jBaPhQoXs8ljv2Zq8vuvleTI9Bfu92cOc3McT2EavJ5MWdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(136003)(39850400004)(376002)(451199015)(86362001)(5660300002)(186003)(41300700001)(122000001)(8936002)(7416002)(36756003)(26005)(38100700002)(33656002)(6512007)(38070700005)(83380400001)(2906002)(2616005)(478600001)(71200400001)(316002)(53546011)(54906003)(6916009)(76116006)(66946007)(91956017)(66556008)(66476007)(6486002)(64756008)(4326008)(8676002)(6506007)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVdOQlJLMzA1VUx0YTJrMWNrNmN1UzZjWVRaL2NxUWNrTjA4OWVyVEdQdDNH?=
 =?utf-8?B?VkJPU0FkVlU2UEtCTzFUazhyWXcyNldGZFRQTitNelJNdDBGY242UFluRFl1?=
 =?utf-8?B?TXVCalg4cEJDU3ptcXhKV2JnREJkUkhaNW84QUtRU2VMaDdxTXVDa2laRjJ1?=
 =?utf-8?B?OE5yVmYvdTZ4disyWVMzQmgrbUcvR2ttR3dhYkV1M1lNWHdFQ3dCOTUrV3Jy?=
 =?utf-8?B?Z2Vyc3k2QVJuSXlqNHdRaEVWajk3UFdmRFpGQmEwS21zcWdmK0ZzSzkrZXlC?=
 =?utf-8?B?MzVsenVBeGxkSUFCWDg2eTUzOWtJZTRvamxVL3EzTGdwT05JQ1p2UjZ0Wmh2?=
 =?utf-8?B?akl3RVFiRVJ2WWJPdHVvcnNrY1A4NTAyenI1NHQyRUN3U0FMNmwzU202OTVn?=
 =?utf-8?B?MVZYOUJGelhzOE5jWUl0aFVWR3N5S2Z3SXNHbVB2cjdua3M1R0t0TmRkN0VD?=
 =?utf-8?B?Z3BtemdUVHBqb0JyWlFWdnpEZTlXVWprSUpIMTU1V0hyTU1lNjhYOEtxWE9V?=
 =?utf-8?B?N3VFN2h2Y3RkNnZ5T0k5ZVI5a2k0YkdoMnZmSVdVYmE2bWtUclpld2pkWnJE?=
 =?utf-8?B?OHV2MzUrRjlOM3A4TnFHeHY2OUFJSmdldm1QWGVGUFRHOW5uaDJNZmh2NHVF?=
 =?utf-8?B?SW9BMnFRWDVnSklhcjZHdkNORGpYc3o1czlsdmRocXRwcHBLeCtVRndJeWhU?=
 =?utf-8?B?RVV0VmppcXdlZ3VGclpwRHJRVXdmWW1CejFwdlRkTitKSmJtbVJCekE2UmpF?=
 =?utf-8?B?Zm8vY0NBcGZTc0M0TGU1bWF4VlhxQXFSamt0cTJOcFBBbmp6K2EzNWQ4QjdN?=
 =?utf-8?B?SGVuV1pPNm9qbmFzaElUOVRZSVdWNUw3bis5TGpQL3ZqWWNnazA5Q2xFa0lU?=
 =?utf-8?B?ZTVpcFlwejFURWZWRkY2WVFONXd2ZWR0TGlnZXJGMW50RkRGRWRneWlzYW81?=
 =?utf-8?B?NFdqUTF3Ni9mdFhNSU94WGNkRUcvSGpKQTJ1SmpWUjc5ZEtMcXJ5RnBCNlo3?=
 =?utf-8?B?ZFRSVktPV1QxWWpLZFprNnZRbFNpczdTRDdubXdHcERSN2FwckdiclQrOGF3?=
 =?utf-8?B?S0VFWFkya01YRGF0ZkRnZTYyTXg3R3hpdXNlemp0YXBHT2RZNitpa3NSOEJL?=
 =?utf-8?B?cHpjSTBtLzlUMTNKQmVuaWFQT1ovVzRyTTM3eVBjQUIrRUZzWVhGVEh0RDlG?=
 =?utf-8?B?anFseTFBbVFvKzBPSkM3L3ZZWStKaTRtMmdlaE84YmlrVlFrWTZiMzFiM1Yz?=
 =?utf-8?B?czNpWkNEanp1QXozaUpldmsvOFNmOU8xZ24zSVBXTmNRS3lmcExTL3dyS3NC?=
 =?utf-8?B?WEVhaGYwSDJ5MVlvbU9aZi9PSVNBWEpQblYxc3VJSkNYcnFLK0IrOXo5NWdk?=
 =?utf-8?B?bE9paXpicHpoRHhzSG5QQWl0WFc5cDhxdVRMZzZYWTl0alJPYldMQ1VUaVNB?=
 =?utf-8?B?UG5YbUY1QnJhb1pVQkl2TmFsdmF3OFlDbVhJOGluVVhETk53c0ljNTVGZ1Qr?=
 =?utf-8?B?b0FMd09IaHBFRDJpUzUrL21md2Rlb2twR1REM2tLdmFrOWppNzhXZzg0OGVY?=
 =?utf-8?B?SzhrQW9jRXVZZmNIZWVDSW9pR0VCYmhiOFRXWitvYlRGWjJ3ZDZHZVQyTUZH?=
 =?utf-8?B?UithR3hYS3g4cC8vU3pGRTVDQmZXemFCSWg0VnhzOTR6ZHN2d3dCRzJxRVZN?=
 =?utf-8?B?WXN2Y1Z3LzFndTlURitSWVZqY1Uwb0FkbEZaSGNrQ3JCRG5MQkJyaWlVeWRW?=
 =?utf-8?B?YUlSREJoTzBSSEwrS0dUVksxSEtNdStaTjhKd3RpZE80Yk1Mek44T2ZwbE4x?=
 =?utf-8?B?MkVjaW83cThvQk9obDk0bXRad0xmbEpSTGxiRXdmYk56RzZQVnNjQ0NOTndQ?=
 =?utf-8?B?MGxacHIzRm02YkFsTlFsaVo2YStYbkk0QlZ2dGNrZWNDOFhQemxOc29EMGVv?=
 =?utf-8?B?YVcyZmN1dFNZZTVSb2NSS1IwUkN1cjl1SkFDT1NxZ1lFalNzRkk4Y2tFcis1?=
 =?utf-8?B?SVNMSUp2MVhqN1lZRC9YUjRTRVNLQWwrc3RHQjJERStlWFZIanRkWFk1Z01B?=
 =?utf-8?B?RWVmWmduOVVzbWZ2a08zMzhEWlVHeEZIYUZYTHJ5S3dHYlJOcVlwOWIvZVNX?=
 =?utf-8?B?MWhCQytZdVkvWGtpeUhQK3p1SHQ3a0RiUkc2VFVXODQ5UkhnOUdCcHhjZDR1?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <221958AF23BCE941AD9B352404CCD794@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fb60df-72a2-4524-1b64-08dabc815067
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 03:21:21.1615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1JOUp63kChL99PLp09Q4dfT5Hh5oh1H6DF3ih+CaiuZEUWjI2Ff5OuYvBB6EaxPoEbv2YAc2aw2tTBs4k+2tmjXkAk+y6bOwnu+kAeMC5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5788
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpPbiAyMDIyLzExLzIsIDI6NDAgQU0sICJSb2IgSGVycmluZyIgPHJvYmhAa2Vy
bmVsLm9yZz4gd3JvdGU6DQoNCiAgPiAgT24gVHVlLCBOb3YgMDEsIDIwMjIgYXQgMDU6NTE6NTRQ
TSArMDgwMCwgQmlsbHkgVHNhaSB3cm90ZToNCiAgPiAgPiBUaGlzIHBhdGNoIGFkZHMgZGV2aWNl
IGJpbmRpbmcgZm9yIGFzcGVlZCBwd20tdGFjaCBkZXZpY2Ugd2hpY2ggaXMgYQ0KICA+ICA+IG11
bHRpLWZ1bmN0aW9uIGRldmljZSBpbmNsdWRlIHB3bSBhbmQgdGFjaCBmdW5jdGlvbiBhbmQgcHdt
L3RhY2ggZGV2aWNlDQogID4gID4gYmluZGluZ3Mgd2hpY2ggc2hvdWxkIGJlIHRoZSBjaGlsZC1u
b2RlIG9mIHB3bS10YWNoIGRldmljZS4NCiAgPiAgPiANCiAgPiAgPiBTaWduZWQtb2ZmLWJ5OiBC
aWxseSBUc2FpIDxiaWxseV90c2FpQGFzcGVlZHRlY2guY29tPg0KICA+ICA+IC0tLQ0KICA+ICA+
ICAuLi4vYmluZGluZ3MvaHdtb24vYXNwZWVkLGFzdDI2MDAtdGFjaC55YW1sICAgfCA0OCArKysr
KysrKysrKysNCiAgPiAgPiAgLi4uL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MjYwMC1wd20tdGFj
aC55YW1sIHwgNzYgKysrKysrKysrKysrKysrKysrKw0KICA+ICA+ICAuLi4vYmluZGluZ3MvcHdt
L2FzcGVlZCxhc3QyNjAwLXB3bS55YW1sICAgICAgfCA2NCArKysrKysrKysrKysrKysrDQogID4g
ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTg4IGluc2VydGlvbnMoKykNCiAgPiAgPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hc3BlZWQs
YXN0MjYwMC10YWNoLnlhbWwNCiAgPiAgPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXNwZWVkLGFzdDI2MDAtcHdtLXRhY2gueWFtbA0K
ICA+ICA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3B3bS9hc3BlZWQsYXN0MjYwMC1wd20ueWFtbA0KDQogID4gIEknbSBwcmV0dHkgc3VyZSBJ
J3ZlIHNhaWQgdGhpcyBiZWZvcmUsIGJ1dCBJJ20gbm90IHRha2luZyBtb3JlIGZhbiANCiAgPiAg
Y29udHJvbGxlciBiaW5kaW5ncyB3aXRob3V0IGNvbW1pbmcgdXAgd2l0aCBhIGNvbW1vbiBiaW5k
aW5nLiBQbGVhc2Ugc2VlIA0KICA+ICB0aGlzIHNlcmllc1sxXSBhbmQgaGVscCBlbnN1cmUgaXQg
bWVldHMgeW91ciBuZWVkcy4NCg0KICA+ICBSb2INCg0KICA+ICBbMV0gMjAyMjEwMTMwOTQ4Mzgu
MTUyOTE1My0yLU5hcmVzaC5Tb2xhbmtpQDllbGVtZW50cy5jb20gPGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC88YSBocmVmPT4vIj5odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjEw
MTMwOTQ4MzguMTUyOTE1My0yLU5hcmVzaC5Tb2xhbmtpQDllbGVtZW50cy5jb20vDQoNClRoZSBs
aW5rIHlvdSBwcm92aWRlIGRvZXNuJ3QgbWVldCBteSBuZWVkcy4gVGhpcyBpcyBmYW4gYmluZGlu
Zy4NCkFzIEkgdG9sZCBiZWZvcmUgDQoiVGhpcyBwYXRjaCBkb2Vzbid0IHVzZSB0byBiaW5kaW5n
IHRoZSBmYW4gY29udHJvbCBoL3cuIEl0IGlzIHVzZWQgdG8gYmluZGluZyB0aGUgdHdvIGluZGVw
ZW5kZW50IGgvdyBibG9ja3MuDQpPbmUgaXMgdXNlZCB0byBwcm92aWRlIHB3bSBvdXRwdXQgYW5k
IGFub3RoZXIgaXMgdXNlZCB0byBtb25pdG9yIHRoZSBzcGVlZCBvZiB0aGUgaW5wdXQuIiANCk15
IHBhdGNoIGlzIHVzZWQgdG8gcG9pbnQgb3V0IHRoYXQgdGhlIHB3bSBhbmQgdGhlIHRhY2ggaXMg
dGhlIGRpZmZlcmVudCBmdW5jdGlvbiBhbmQgZG9uJ3QgbmVlZCB0bw0KYmluZCB0b2dldGhlci4g
WW91IGNhbiBub3Qgb25seSBjb21iaW5lIHRoZW0gYXMgdGhlIGZhbiB1c2FnZSBidXQgYWxzbyB0
cmVhdCB0aGVtIGFzIHRoZSBpbmRpdmlkdWFsIG1vZHVsZSBmb3INCnVzZS4gRm9yIGV4YW1wbGU6
IHRoZSBwd20gY2FuIHVzZSB0byBiZSB0aGUgYmVlcGVyIChwd20tYmVlcGVyLmMpLCB0aGUgdGFj
aCBjYW4gYmUgdXNlZCB0byBtb25pdG9yIGFueSBkZXZpY2UncyBzcGVlZC4NCg0KVGhhbmtzDQoN
CkJlc3QgUmVnYXJkcywNCkJpbGx5IFRzYWkNCg0K
