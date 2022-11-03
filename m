Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8508617641
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiKCFk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKCFkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:40:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2132.outbound.protection.outlook.com [40.107.117.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7B413F64;
        Wed,  2 Nov 2022 22:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsFfB1sAWLbfkswe96YNEeF3FBIZdpFwu4wUg87i6gJQV1SwscB1RyaMUH4H8PgZd+4qkANQiSywTbDR34J4E14V0qOp7886m9ecDiugOlE1SiQwIwcdK9YVMxTVCsoL4/Q+BPtkwnUOWEnvnqG6fvvThxoq1HgovimhnB72dL0cP01vu6pkBXblk7bWleLStzRSwjYDeknn6Fg5SG6BaCVPD0r0OM+TNoVWXjg4Na5IcmeqMfcFMDzIEvGUiOQTgoOd7qsgvbhQOFOV9Onfq3ZNnob/xjNNti0N4/FMEXWCvJaTYdv0YNPy5VGRmitI8MN9kBhZjBjH2sOmGaQ49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRu50K51FBbUECpUCGGaX8ZqxxqYABKJcCeLajMNLX8=;
 b=Un8WoJwiPrAGwE0ttmvmDpXMQ5nArF2MlLxSVKUYdTfvnMVr96zFgb+cI1FlBbA3WjSFDoiZntaDWjI/bZxqWOy/AKoM8MtBVIS3oKU3bMK/ZqUiEG61wmySQDR8ynAS7uFzXFb30RLk0I8Av2u1RH1sWaxhUOkgR8KKxvssucWkjZ9FjLrhyfWy4ZYIFWBdd677xeQKysTLtCJU2XN8H7Q2imzBeEKUbt3H/EB93Y4VV6XfKmqJEdGbFGPWUnMClfGpPYpKajlHM4v0UUg85MU8NlovYgvOYEzvgei1Dx8te4yNZ8koZtqpUMQ7ZthtxNrHWjVbCSkhzvuv/LeauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRu50K51FBbUECpUCGGaX8ZqxxqYABKJcCeLajMNLX8=;
 b=w43oH2VACIw1F8LPtRYkr+2dLNoQ+U+8wvLUd5zu4tt7GvfPZOKpPmvZUywK4Gm2WX5+4iuF9VwaEJVIQMAXDed5W2fPxXbFWeWYfJYXTSnj4L4CeVIiPmU8cDicz2vEvw2EoEIHcE5pWKMvclVWEeAmq9yiNX+EjmFu6aP0FlLg9KVfJY04aGCFB678CbRr0gpSRNKA8gm90isqOdtudwGIOwXcQphZTkHRAP+SiOvz9RSJzTukDitn/qhHgsTtLCtBdS3kTWkWEdL5qg/r08/e1JMO6WtP6o2qkqsZaBFfThtOrZo0bRQ4mqRRj87lXIKGxa2BVe0rCcHOaR1LPw==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 TYUPR06MB6049.apcprd06.prod.outlook.com (2603:1096:400:358::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20; Thu, 3 Nov 2022 05:40:45 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831%6]) with mapi id 15.20.5769.019; Thu, 3 Nov 2022
 05:40:45 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
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
Subject: Re: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
Thread-Topic: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
Thread-Index: AQHY7ddiCLgpICHNHkaN+NgNt8n5/K4qDDAAgAGuNQCAACN3AIABPBaA//+EZgCAAJm3AA==
Date:   Thu, 3 Nov 2022 05:40:44 +0000
Message-ID: <E9E92BC7-CB1A-487F-9E5D-2A403A01CB17@aspeedtech.com>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-4-billy_tsai@aspeedtech.com>
 <20221101131456.GA1310110@roeck-us.net>
 <271C521D-8F20-4C86-B3DA-9C0AD74242D4@aspeedtech.com>
 <20221102170138.GA2913353@roeck-us.net>
 <F1166366-99CC-4A36-A0A2-4965C787E60B@aspeedtech.com>
 <20221103043034.GA2113834@roeck-us.net>
In-Reply-To: <20221103043034.GA2113834@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.66.22101101
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|TYUPR06MB6049:EE_
x-ms-office365-filtering-correlation-id: 5d3bff85-d7f0-4982-1339-08dabd5df420
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nvP9jOhVdoZWmu6OMi1yQN4EMecWYqPLomDyVMwgAs8i0CP3uANIQ85jIG4dZAKsLQDZEOH8z4JmzGd33TIt0B64GePoJMSu8UW62+H+isN06r6pl9OqTG1rLIq/ySX4uoGwuq/CtBEJ5JXtxhlALj7kuuqyCKwNc+YCTgUHqYwTL1RH6xDGaQppQwymPgkXinXz//zUGMtCOwXflxfSugXaxkHVp0GMRYAROIzVHJy5nYNkZbsa82AbA36oHIblVxAsr3TN0VgfLL39QZaCPorqTKyb74HJL00GfGIM9SRyCF5N30O8r3fUTWc8bHKhLcw9UgwmSnBddkNN2s0E2lMzs4WBt9c8apkO89YLrLhsWIAQ75wZhSditfhwvd+3kI70dIu6mhmP9wAXbqVBvWjauAc3CYan4/YE6B3dYWt3iD+sGdv8VwSdVC6RGOWAM+AkQQ2WoeDHcswzGTybM7Hp3HWeEhSAYwlcHRNgNYQmrEMKVMXFHGByqdqisGZHEVkFu+ekdGkohCjxGT9vHKIrXA8ZIT2BfCiftJ5wmEuqWxuJ2jPbVcs+4PT51XpDGdegPZ4jJtKEzxgz3WISI0lPBDcVeYF3+rAlsRCkW2gINlYTSfe9tG4636vO0dADpqeZ6kKmk3WNr8bVZNPOtbrBnoBdJLMwbFRRheCCwsqkzjrPXgNtIJSmAlO+aEZnYjDiaSrgEUz+U+BE0p3XQDS8t1/H992NSdGvUgGw3uIyj81CdN4UxIzJVvH01VADFwWdQbQ+2Y2MHHs/S2nx43pO5hj9YXyYWXCIYYXFD4Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(366004)(346002)(396003)(136003)(376002)(451199015)(33656002)(83380400001)(2906002)(38070700005)(86362001)(5660300002)(122000001)(8676002)(38100700002)(7416002)(66446008)(41300700001)(66556008)(8936002)(4326008)(66476007)(6506007)(66946007)(53546011)(478600001)(186003)(6916009)(6512007)(2616005)(26005)(316002)(54906003)(64756008)(76116006)(71200400001)(6486002)(91956017)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFZOQjQ4MTNoZFI5TWlBTGJUc25CZi8zQVMrdU1pQzN2L3hzbFVkSFF1d285?=
 =?utf-8?B?ZDBkdmNJUjVGTkFpVGx4ZW5HVHAxa1hkWjZZaWxNY0xRWEsyVTdhOUZpTEFs?=
 =?utf-8?B?cHBxWVVZQ2tLd2pHYm1DckkxTjVUTVBrKzhHREpBa1hQT3BvaFRBRG1NUEpU?=
 =?utf-8?B?RWwvd29Vc1ZvNWFYVmdBMG9hOGpya2x3bndwS2pDOHp5bnlEYzk1eTd0S1lW?=
 =?utf-8?B?RVp0WERIM0x6NGMzS0wzTlpPcFFSR0VtT1RjVDI5WEZFOFBZOGhxYWdrcE81?=
 =?utf-8?B?WkpHWjQxZStQMDI5QnNGL2JNSXk0eHNmT3ZtdE5EcWQ3OHZNcDBjaW82a3JS?=
 =?utf-8?B?RFZnTzNDaldWN2NTb2ZwRlFzYU0zNm5LaXd0SDE1RFVEb1E1VFFteFpxTEs5?=
 =?utf-8?B?eGJLYzErUWFEbzgyWW9Tc2I1SWFoQSsxM3IwOGtxL2hyYjhCQkxGd0IrckZR?=
 =?utf-8?B?Vkc2SU50NFhMZGZHSndHV1VpRlVueTA3a3VKTHp4YnZDTjdQbmxhcUplWWtw?=
 =?utf-8?B?S21tTEZWUnI3TXlNZStWTisyNGpicVRHaGVtSkJNQnY1ZXZRMFlVQjZtM2J0?=
 =?utf-8?B?cmt0amZMQ29BRFZqMkkwUFUxcjlKUXlUUG41ZEtidXRqNHlVbjhORytMRGVu?=
 =?utf-8?B?Sm1QU3h3UTBZUUZKKzhCcnlXQ1RNWThwdmtmQVN2OEU2VnVKZE9QUFpLbWJW?=
 =?utf-8?B?eXcrT1Q5Tlk1N2FqdlNXUkRnZDUreGtRZGtwdzE5VUhEQmJKOW45ZE1ENDRQ?=
 =?utf-8?B?SkN6Qkp1NEY4LzNBMHVyYXFqenk4bWtLemdYYlpwMmgrZnpEMXRoUmYxUUR1?=
 =?utf-8?B?aUo0bFFPV0JxbGdpL2hQNTdjcUV5WTBtK042WUdBSUdEbkc2TG44QjAwbGJF?=
 =?utf-8?B?RUU5N09GaUJvT3ljeUE0VGJKbUh3UERySzlNNXZGRXVLRHlySjFPbXkwTldO?=
 =?utf-8?B?S0ZqR0hDU1VtbzNCYnllcFlZK3Q2anNVamN5V3ljSVZyUGVqQnQ2YTRaRS9N?=
 =?utf-8?B?L0xidTRlaXB4QW5jS1J1R2l2aVNsS2tET1Q4QTJTR3hOS2RiNnpWZkJNRUZX?=
 =?utf-8?B?NmhtMGsxMDN3ZFpKZXZ6anlVTng3UUI3T1RrVU9NelRINDlsUGRoNmZJRisw?=
 =?utf-8?B?aStIZkdaOThweldMbWRoSVhpMTNXNlRVMllzSzVtL1FXUnV6OVh2VElUaUcv?=
 =?utf-8?B?bEtoSzZTR2poSWp6NHg0MXNxcXoyaGwxZ05VSjlBRVVsb0FtbCtOSXJvVEZG?=
 =?utf-8?B?SmFZeUJlK3ZDZmRWZFVzMmpmQ25odmNOcVIxZXZnTWlkdWlaeFBrRHdvWXMw?=
 =?utf-8?B?amhiSHZjQWRBbTY0enhGUXNDTjVRNVFPMTZpN25Qd2hCN1NyVWNqWmYvSzRp?=
 =?utf-8?B?dUpzeUx4MDcxNzRXMDJOSVNSbWhCaVZBSHR0Q1F6ZkpLSnM0emxVa1U4Nk1D?=
 =?utf-8?B?cXZvVVVxMWx0UUhYQStqRUNWOU4yZkRvMUFkMkt4U01VQ0MzemxPUnhYcjB3?=
 =?utf-8?B?dDdIUFpuVXZCeDRCeWZZQXBSSkxTMytCMDgyZHJTY3BPcTF6YjFVTzlzZHhz?=
 =?utf-8?B?ekV2UUd2Y2l3WlQ5VDZ5ZEVHbU9uUXNtN3EzUlJTekttejV6OFpvaldlakJF?=
 =?utf-8?B?ajhock85WGZneEVtOVNWRFJGWmYzZ3Bwek9EbmZXUm9ZNEwyeGhxejRXMFdx?=
 =?utf-8?B?a09wQ1hxYkV3Q2Jhc3VtQ1Bjb3U4UEJPVDI5YjE3Y1doMksvWWtxRDNLRXp0?=
 =?utf-8?B?YUI3OGxJUVJ2Y0U2WmNiMlpRRkF1STNEM0dZSnlHd1lsQTYzZHVRVzVUZ1Vn?=
 =?utf-8?B?THpncDV3cGdXTGFoWjBBSTRlKzNpaEwzTEVwUWFoUmVzc1RhQ1BKUE5wL0pT?=
 =?utf-8?B?eU1SWUx0RExNakpDRVNXNmYza3VObmF4TGppY2l4WFpJZlNDVTVzNWZDaEVE?=
 =?utf-8?B?WWp4eUplTkMrN3JyZGNKVUZBMG9mWGYvWFVOcmFKQ04xTmlsczNIM1ZYZ29N?=
 =?utf-8?B?TWg1MGNTdUt5b1NKRHF4WDZGaFJDMHN4Y3JGKzBmMkpyODdNM010QktsTGRL?=
 =?utf-8?B?UGd0Nm04QTRKMllseER6R2tsREJZOXd6RGh5L1Y1RkFEbnJRVTVxK255eHBZ?=
 =?utf-8?B?cTZGUnJyRDlCSGl4c3laNFZvYTZCTTBITkpPTzZBdDhLUGNYQTB0dGNPQml3?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D3ED5D042A0EA4D9A980FFE47787649@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3bff85-d7f0-4982-1339-08dabd5df420
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 05:40:45.1072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b52dQ9QpWsPBZnBTz3q81fC51N5ycT7XPAWIBqQe7sVrGgSUT5Q/GCDTdApSpWiLNih/EA8i3heyRIgvYynpT8vv6alvDFkVSjZixmfOoc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6049
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMS8zLCAxMjozMCBQTSwgIkd1ZW50ZXIgUm9lY2siIDxncm9lY2s3QGdtYWlsLmNv
bSBvbiBiZWhhbGYgb2YgbGludXhAcm9lY2stdXMubmV0PiB3cm90ZToNCg0KICAgIE9uIFRodSwg
Tm92IDAzLCAyMDIyIGF0IDAzOjUyOjU5QU0gKzAwMDAsIEJpbGx5IFRzYWkgd3JvdGU6DQogICAg
PiA+IA0KICAgID4gPiBDYW4ndCBJIHVzZSBhIG1pbi9tYXggUlBNIHRvIGxldCB0aGUgZHJpdmVy
IGtub3cgYSByZWFzb25hYmxlIHRpbWVvdXQvcG9sbGluZyBwZXJpb2Qgd2hlbg0KICAgID4gPiB0
aGUgZHJpdmVyIGlzIHRyeWluZyB0byBnZXQgUlBNPw0KICAgID4gPiBCZWFjYXVzZSB0aGF0IG91
ciB0YWNoIGNvbnRyb2xsZXIgaGF2ZSB0aGUgZmFsZyB0byBpbmRpY2F0ZXMgdGhlIGhhcmR3YXJl
IGRldGVjdGVkIHRoZSBjaGFuZ2UNCiAgICA+ID4gaW4gdGhlIGlucHV0IHNpZ25hbC4gSSBuZWVk
IHRoZSBwcm9wZXIgdGltb3V0IHRvIHJ1bGUgb3V0IHNsb3cgUlBNcy4NCg0KICAgID4gSWYgdGhl
IGNoaXAgbWVhc3VyZXMgdGhlIGZhbiBzcGVlZCBjb250aW51b3VzbHksIHdoeSB3b3VsZCB0aGF0
IGV2ZXIgYmUgYQ0KICAgID4gcHJvYmxlbSwgYW5kIHdoeSB3YWl0IGluIHRoZSBmaXJzdCBwbGFj
ZSBpbnN0ZWFkIG9mIGp1c3QgdGFraW5nIHRoZSBtb3N0DQogICAgPiByZWNlbnQgcmVzdWx0ID8N
Cg0KICAgID4gUHJldHR5IG11Y2ggZXZlcnkgb3RoZXIgZHJpdmVyIGlzIGRvaW5nIHRoYXQsIHNv
IEkgcmVhbGx5IGRvbid0IHVuZGVyc3RhbmQNCiAgICA+IHdoeSB0aGF0IHdvdWxkIG5vdCB3b3Jr
IGhlcmUuDQoNCldoZW4gdGhlIGZhbiBzcGVlZCBkcm9wIGZyb20gYSB2ZXJ5IGZhc3QgUlBNIHRv
IGEgdmVyeSBzbG93IFJQTS4gRXNwZWNpYWxseSB3aGVuIGl0IGlzIGNsb3NlIHRvIHN0b3BwaW5n
Lg0KVGhlIG1vc3QgcmVjZW50IHJlc3VsdCB3aWxsIGJlIG5vIG1lYW5pbmdmdWwgdmFsdWUuIFRo
ZSBzbG93ZXIgUlBNIG5lZWRzIG1vcmUgdGltZSB0byBzYW1wbGUgaXQuIEUuZy4sIElmDQp3ZSB3
YW50IHRvIG1lYXN1cmUgdGhlIGZhbiB3aXRoIDYwMCBSUE0sIHRoZSBjb250cm9sbGVyIG5lZWRz
IGF0IGxlYXN0IDEwMG1zLiBEdXJpbmcgdGhpcyB0aW1lIHBlcmlvZCwgd2UNCndpbGwgYWx3YXlz
IGdldCB0aGUgd3JvbmcgdmFsdWUuIFNvLCBvdXIgdGFjaCBjb250cm9sbGVyIGhhdmUgdGhlIGZs
YWcgdG8gYXZvaWQgdGhpcyBwcm9ibGVtOg0KVEFDSF9BU1BFRURfVkFMVUVfVVBEQVRFOiB0YWNo
IHZhbHVlIHVwZGF0ZWQgc2luY2UgbGFzdCByZWFkDQpUaGlzIGZsYWcgd2lsbCBiZSBzZXQgd2hl
biB0aGUgY29udHJvbGxlciBkZXRlY3RlZCB0aGUgY2hhbmdlIG9mIHRoZSBzaWduYWwgYW5kIGNs
ZWFyIGJ5IHJlYWQgaXQuDQpJbiBvcmRlciB0byB1c2UgdGhpcyBmbGFnLCB0aGUgY29udHJvbGxl
ciBuZWVkcyB0aGUgcHJvcGVyIHRpbWVvdXQgYmFzZWQgb24gbWluaW11bSBSUE0gdG8gYXZvaWQg
d2FpdGluZyBmb3JldmVyLg0KDQpCZXN0IFJlZ2FyZHMsDQpCaWxseSBUc2FpDQoNCg==
