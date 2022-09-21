Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3355E53BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiIUTTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiIUTTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:19:04 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2116.outbound.protection.outlook.com [40.107.135.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CED2A1D07;
        Wed, 21 Sep 2022 12:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtPwRkiYjio0jxt3GnYuQu0aWLfTg6Gj3gjdJzIBmWqya3Ls3Y7irjTevmYVsrBaPdgdevNX7kmyffFfc+/SdNwITqK/DkR8IavVfvk6b3/dNYOb45d+97M0aybAqA9UvRKYDRFlg2B5mnmluQW7pmUEqYxEKJWdV7MRYJPoPeE7TGqvzboGIYjVYYplCH0U2mNt2kZKdBxvNgeu6GcZMCvf8AH3GHvh+b8D10uUrU2eGBlJ1U1RwpnmRv8RI89vvkUYfEBTAxh1Th1Eo+ubUwDMBa+XL2wmSxriOreYroWLteA14nUBYMTiPYWj/vb3bB2jCxcjVcnVMFdrEo6IJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEX/ElzSFu4xwbadrnvpYDdP+1EX/hETcKkxF7FN5H0=;
 b=hAYaubDHhMrEEkXSael0CI5qrHAz8WRILWr0cyiQ2QKDCO4xOax+49WO/ePqiZ5axcSySWwPNz1MbMQ01DGjQNAhB/dV+S91Wf3I65luWlTkYTwxyQLrauS7bvvOKGVyTJsE81EE7A5llFr/jF3sZ7tGZDjQd2bHMsrtLOCARJpwGECp2n78JYbte/gPJxyUUEICW4MTKGO51ls9/XfQeYpMqB4bfgWgQjBNyFh/94HQi+GCJSdMKnkZ6XmuOEgL1iyq3R/vTz9Q+MWOngl6V2XWo2i8Trp7HvLuGT/bTTV/7jgaZukiT3TvUpgyjmpfLcn/nNq8ZqqGa8B+qXDz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEX/ElzSFu4xwbadrnvpYDdP+1EX/hETcKkxF7FN5H0=;
 b=MFcmEzWs5hBb+tYvCfkzb5Vuebhr6eX61n099hEiFpIv2qynKWxiwCgsGv/3G4mNWwjGWF7Gn6zijlKu7DHpxGFR/cWSmRxEng6FteRrZ8A7CydOwhe9nIC3KxpVgdjtDXHDUqr4S7Nx6i9DlJc98KzYdBdAcGFdyFLHb2mn5w4=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR3P281MB3040.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:5b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 19:18:56 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::74b2:f96e:154d:8aa2]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::74b2:f96e:154d:8aa2%7]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 19:18:56 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Thread-Topic: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Thread-Index: AQHYza+y2hgGmsftnkiq37OGUqNqR63qQpyA
Date:   Wed, 21 Sep 2022 19:18:55 +0000
Message-ID: <31fb15a7-1e5e-f645-5065-e34220f17835@fi.rohmeurope.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
 <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
In-Reply-To: <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR3P281MB3040:EE_
x-ms-office365-filtering-correlation-id: 5003ba6f-ffbf-4f01-2dd2-08da9c0620be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f6cOHh5TEiv9er0N+W0VzhDWcP4BCFGpFMnC0dQMjr0jGh8KUDO4TPZQ1Pa3IOJ6BcQkZ2R1uK0VOoAeSAJPpW4ZCNqRxYe+PoEdeEfmFd16nCwyTH7OzA1ADShIdi8qqZRUU9CzxPozGuSTrf9SH00FxqsQwF72Gfi6LplscTs4f+J9FhhIEpiHLL/760uAez0gKRUzvf3NUVVOtM5TvvLjv8eVsenKPKZKbzz49Mv5l2yWKkKyRU5tw8XouGGRoRilIH8R4LLz3GSTeNXELIwgt42uiGWpBamtcYvK1zczP6JDwifagVuKvVzGi6wMr1TAyV3WHxgzA94RnXTD8eGFwovlKvpRHs28g4AyxFpLdacmvggfRwvxLYsMSF0Y17EqodTbvppNhvrDdlF4W519O2sN41knkH0wuI31LZ7lNFUMW3BEjHmbZi4JaZUEK8GMB1c9SsSRWJ+qXSBDFmw8qaFFSB84jHSfLQ8U4YRvjVWZWt5U/cEWBB72S9MeUuOGOBG5ygbl54mqvs0sD8RPu4aNcqj4dE5AzW8LKf3tkYKyHdNii2T+zPz0gwxNzFcf1EQv6vo8FV7ZM/64z+8DASd7dvuT6Q/vkl0lQR+KsCYEWqRMgOn9GQKKYoK07Xnwp2vxNQyBdg5N7fVPvUEbdFnY97DHrE37aqK8G6pz69F/Q6qOq2OQ5e25pu79et7OaxeZpIRfoYhgFled73JfM8hc7ktyffkizRJMXEAW6Lnl99NlJ17xCfwlpAaKqWqzgbHhyybu9HoYK3k3jifbbP/D+ySGTcjLgZ5bkBaMBbf878XhWbv6qO7k6JHTjAF9pYg0NEuFmHunCBRSLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39850400004)(346002)(396003)(136003)(366004)(451199015)(31686004)(71200400001)(6506007)(6512007)(6486002)(53546011)(38070700005)(91956017)(66476007)(66556008)(66946007)(64756008)(41300700001)(54906003)(5660300002)(316002)(66446008)(6916009)(4326008)(8676002)(76116006)(86362001)(122000001)(38100700002)(31696002)(83380400001)(2616005)(186003)(478600001)(2906002)(7416002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHNNeStlRDlyR0puUEgxV0dGRzFMMHZwZlhXdGYybDN0NTNTOXdJYWJBUjM0?=
 =?utf-8?B?bm9QSEEwK2FJeEdndDZqdW9yazRoRVdYMWdzTkYvN2ZYci9xVWI3QnlHU1ph?=
 =?utf-8?B?RkJNa1ljMWMvMG40TFNsM1ZhTHBGak91MzB5UXViM1pUSE9ZZFVNcHZHdk5Y?=
 =?utf-8?B?MGlMY05BdGdIamhlY1BYWVRTTGlpQmZnQWc2c3JrSGdxQUdHY25qVFpNN2RB?=
 =?utf-8?B?a3FjU0I4cDlFTEtrL0d2TUhMSjhOanphVktLUkZXRDVscGo2NmhhbEErMmR0?=
 =?utf-8?B?czhqU09pYzVPQ3VSQ1NCOGgrWm82clV2M1dmd0dNdllwSEFyeEtnRjZXM2ZW?=
 =?utf-8?B?MTBCZ2YxY3ZaYkFXTDN2RjgxR1owSy9pWHYzanM4T3RCbG13VzgxaktFeXRx?=
 =?utf-8?B?RzMxWVlSYk1vV1ozdlZIRkdFZDhWTlFPMm1IZzFrVTZEOVJOTGdPQ2JOOFVy?=
 =?utf-8?B?S3hwd0phekI1bllNV05jSWpJQUFwcW02VDFTcUJoUHJmV21xZG9qY2duYkZp?=
 =?utf-8?B?RWVZUzZybDRRSzczUlhuSzJRYlZWcDhlY0hCNzE1ZXExS1pvaEtuYzVGVyto?=
 =?utf-8?B?KzJBWnppWHlORDhtTnJNV1ZkdXV5V0l6OFBkOElRc1JXWi90aVo3Y0xQQVU2?=
 =?utf-8?B?Z3ZVOThDWis0YkhVS1lKOU9PWHh6aEJqU29NVXNJUG41NzI3aExWZjM2L25D?=
 =?utf-8?B?TmRvbndTbE5xRWs2alRGd0pVOHV5ZUJWSFlaenlXWG1YK2V2Y0czY0t6ZWJP?=
 =?utf-8?B?UTVSWEc4ZE4zL3krV1FyUDVDRDg2bktlYm5uZW1YYkZzbnVtQzE0SHNJRG1W?=
 =?utf-8?B?TEtKNXJ5bFdCZGlxbEI1WlF5Qk1yd1BOeTVwNEMzOEtlRnYyb0JGY0M2akFz?=
 =?utf-8?B?M3UyeVplR0N4WEcwa1BuTUZZd3F5YWpPYlA5K25KdW1ud0dyV3pQUk9iZE5J?=
 =?utf-8?B?Rmg4UTk3Y1RkaEtlV1VqaUxyRzNMeHJkeFJsbWNIakZYdUZXRjZEdm1rK3JO?=
 =?utf-8?B?c0syOGJNN2FENCtMZEFBZnFkN1pTZUVjTjRZaXllbWs5Yk85VkQ0c2VVLzRZ?=
 =?utf-8?B?YnAwVGE4dTVRN0dpUTlnQjR1eFJ1aFdaVitZL2ttNDZlaUhZaEh2YVRIWndh?=
 =?utf-8?B?aDNuY20wOG9HSzRoVlhHZ0x6MXpNZ0k1VEtBWW52bUw0Q0M0TjkrbzNXVm9T?=
 =?utf-8?B?VWljTW5yNmdlSDlHL0NpRWFIcFFXZnFCZDBmeGpVemgwc0ZzZUprbklDMEd6?=
 =?utf-8?B?d1VMQTBqalgvak8vTC9RWmVPamlkUDcvYkZ3eWMwVEtTbVJTcW9GcnRFUUxP?=
 =?utf-8?B?WHpyeDkzV3dZM3lOblRSVW9SRlNPUnhqQUN3MTZRTlFYWmI3ZDV6REE1MVBB?=
 =?utf-8?B?SVRQSXUwS2l1NW1tbHJwelh3cFlzbzZiWi91eHpFeUZZVVZycStRU0RFbVpR?=
 =?utf-8?B?VUNXd2tBeUNGcktsdEVubGhPODhacW55VklIenNPWTU2RnljU2xTWjdLbHls?=
 =?utf-8?B?UWtPdlZxS0hCdkZSZmxRWHJvS0ZsSTU4SlNBMk1xQkR0cEVUTmt3UG5aNzVs?=
 =?utf-8?B?YjJWTnJia1FTdVI4dGRjK3RDejMxbi9IdWwya1Vldm9qQWZ5Mi9TSW85Qi9a?=
 =?utf-8?B?RE94RENxL3JyRXBUbEoxenoxaXJyY0s1dm92U08zS3I1VFhnMmlFYVp3ZHIx?=
 =?utf-8?B?MlVzN3hBY29wTTlXQzEwQmhJdmpENUlKeFRxdDREQWRkL25BN0lOK2I5VFlk?=
 =?utf-8?B?cnQ2bjMyZUFBbXZBNnJ0cGdzaG9UdFRQUmpsQk9FbWpoSmNkVmlFcTYySmJH?=
 =?utf-8?B?anhHUjBROHRHQzZxM0prMEcweWhGTDNUNTZIN3huS0Rscno0R2JQbFdzYTh5?=
 =?utf-8?B?OHZBM0t3d0dhencveGNCZFRiZUVpaVgwYnRsMWplZ1ZYcmw0MjNlQzVLUStt?=
 =?utf-8?B?eUVNWUdZcS9Ea3V6SmVJZXZxOVhXQ3NFc21rQUNyaFZvb3VJckREbjJLVW9m?=
 =?utf-8?B?T1g4UjJLbG94MTB3MzFYYTQ1emZ3dXhMb1VnNG9VZHhPUTRkNStRVzVhV21r?=
 =?utf-8?B?L2Fad01wb3J3VGFzSk90SDg1L1VXMmJ0cG9RNk1TNjF2cDM1Z0pqWk5JNVpY?=
 =?utf-8?B?Z1pkd3RwZC9HMzZ2Zis3MVR5NkFpUW5oYUk1YjQ1UTdRLytGem8yL3d4czNW?=
 =?utf-8?Q?6KM7nYiTf2CPTeMDy3M61EI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4885BDC6FDD65F4490652E4A01B9BF53@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5003ba6f-ffbf-4f01-2dd2-08da9c0620be
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 19:18:55.9106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eT88nB6DCLELHtI3YdpnguxVHnoiuFvX7eyIUGDL8s9badyW/M8NBN6u9Jc/aAweMfS370Rx6JIVg/Ml2y0f5LR+anPuuw1QZeKoqKZyqL+4VE2662nMfDnhmvcwLLnT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB3040
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yMS8yMiAxNDo0NSwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiBLWDAyMkEgaXMgYSAz
LWF4aXMgQWNjZWxlcm9tZXRlciBmcm9tIFJPSE0vS2lvbml4LiBUaGUgc2Vub3IgZmVhdHVyZXMN
Cj4gaW5jbHVkZSB2YXJpYWJsZSBPRFJzLCBJMkMgYW5kIFNQSSBjb250cm9sLCBGSUZPL0xJRk8g
d2l0aCB3YXRlcm1hcmsgSVJRLA0KPiB0YXAvbW90aW9uIGRldGVjdGlvbiwgd2FrZS11cCAmIGJh
Y2stdG8tc2xlZXAgZXZlbnRzLCBmb3VyIGFjY2VsZXJhdGlvbg0KPiByYW5nZXMgKDIsIDQsIDgg
YW5kIDE2ZykgYW5kIHByb2JhYmx5IHNvbWUgb3RoZXIgY29vbCBmYXR1cmVzLg0KPiANCj4gQWRk
IHN1cHBvcnQgZm9yIHRoZSBiYXNpYyBhY2NlbGVyb21ldGVyIGZlYXR1cmVzIHN1Y2ggYXMgZ2V0
dGluZyB0aGUNCj4gYWNjZWxlcmF0aW9uIGRhdGEgdmlhIElJTy4gKHJhdyByZWFkcywgdHJpZ2dl
cmVkIGJ1ZmZlciBbZGF0YS1yZWFkeV0gb3INCj4gdXNpbmcgdGhlIFdNSSBJUlEpLg0KPiANCj4g
SW1wb3J0YW50IHRoaW5ncyB0byBiZSBhZGRlZCBpbmNsdWRlIHRoZSBkb3VibGUtdGFwLCBtb3Rp
b24NCj4gZGV0ZWN0aW9uIGFuZCB3YWtlLXVwIGFzIHdlbGwgYXMgdGhlIHJ1bnRpbWUgcG93ZXIg
bWFuYWdlbWVudC4NCj4gDQo+IE5PVEU6IEZpbGxpbmctdXAgdGhlIGhhcmR3YXJlIEZJRk8gc2hv
dWxkIGJlIGF2b2lkZWQuIER1cmluZyBteSB0ZXN0aW5nDQo+IEkgbm90aWNlZCB0aGF0IGZpbGxp
bmcgdXAgdGhlIGhhcmR3YXJlIEZJRk8gbWlnaHQgbWVzcy11cCB0aGUgc2FtcGxlDQo+IGNvdW50
LiBNeSBzZW5zb3IgZW5kZWQgdXAgaW4gYSBzdGF0ZSB3aGVyZSBhbW91bnQgb2YgZGF0YSBpbiBG
SUZPIHdhcw0KPiByZXBvcnRlZCB0byBiZSAweGZmIGJ5dGVzLCB3aGljaCBlcXVhbHMgdG8gNDIs
NSBzYW1wbGVzLiBTcGVjaWZpY2F0aW9uDQo+IHNheXMgdGhlIEZJRk8gY2FuIGhvbGQgbWF4aW11
bSBvZiA0MSBzYW1wbGVzIGluIEhpUmVzIG1vZGUuIEFsc28sIGF0DQo+IGxlYXN0IG9uY2UgdGhl
IEZJRk8gd2FzIHN0dWNrIGluIGEgc3RhdGUgd2hlcmUgcmVhZGluZyBkYXRhIGZyb20NCj4gaHdh
cmR3YXJlIEZJRk8gZGlkIG5vdCBkZWNyZWFzZSB0aGUgYW1vdW50IG9mIGRhdGEgcmVwb3J0ZWQg
dG8gYmUgaW4gdGhlDQo+IEZJRk8gLSBlZy4gRklGTyB3YXMgInN0dWNrIi4gVGhlIGNvZGUgaGFz
IG5vdyBhbiBlcnJvciBjb3VudCBhbmQgMTANCj4gcmVhZHMgd2l0aCBpbnZhbGlkIEZJRk8gZGF0
YSBjb3VudCB3aWxsIGNhdXNlIHRoZSBmaWZvIGNvbnRlbnRzIHRvIGJlDQo+IGRyb3BwZWQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1henppZXNhY2NvdW50QGdtYWls
LmNvbT4NCj4gLS0tDQoNCi8vc25pcA0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hY2Nl
bC9raW9uaXgta3gwMjJhLmMgYi9kcml2ZXJzL2lpby9hY2NlbC9raW9uaXgta3gwMjJhLmMNCg0K
Ly9zbmlwDQoNCj4gK3N0YXRpYyBpbnQga3gwMjJhX3dyaXRlX3JhdyhzdHJ1Y3QgaWlvX2RldiAq
aWRldiwNCj4gKwkJCSAgICBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBjb25zdCAqY2hhbiwNCj4gKwkJ
CSAgICBpbnQgdmFsLCBpbnQgdmFsMiwgbG9uZyBtYXNrKQ0KPiArew0KPiArCXN0cnVjdCBreDAy
MmFfZGF0YSAqZGF0YSA9IGlpb19wcml2KGlkZXYpOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwkv
Kg0KPiArCSAqIFdlIHNob3VsZCBub3QgYWxsb3cgY2hhbmdpbmcgc2NhbGUgb3IgZnJlcXVlbmN5
IHdoZW4gRklGTyBpcyBydW5uaW5nDQo+ICsJICogYXMgaXQgd2lsbCBtZXNzIHRoZSB0aW1lc3Rh
bXAvc2NhbGUgZm9yIHNhbXBsZXMgZXhpc3RpbmcgaW4gdGhlDQo+ICsJICogYnVmZmVyLiBJZiB0
aGlzIHR1cm5zIG91dCB0byBiZSBhbiBpc3N1ZSB3ZSBjYW4gbGF0ZXIgY2hhbmdlIGxvZ2ljDQo+
ICsJICogdG8gaW50ZXJuYWxseSBmbHVzaCB0aGUgZmlmbyBiZWZvcmUgcmVjb25maWd1cmluZyBz
byB0aGUgc2FtcGxlcyBpbg0KPiArCSAqIGZpZm8ga2VlcCBtYXRjaGluZyB0aGUgZnJlcS9zY2Fs
ZSBzZXR0aW5ncy4gKFN1Y2ggc2V0dXAgY291bGQgY2F1c2UNCj4gKwkgKiBpc3N1ZXMgaWYgdXNl
cnMgdHJ1c3QgdGhlIHdhdGVybWFyayB0byBiZSByZWFjaGVkIHdpdGhpbiBrbm93bg0KPiArCSAq
IHRpbWUtbGltaXQpLg0KPiArCSAqLw0KPiArCW11dGV4X2xvY2soJmRhdGEtPm11dGV4KTsNCj4g
KwlpZiAoaWlvX2J1ZmZlcl9lbmFibGVkKGlkZXYpKSB7DQo+ICsJCXJldCA9IC1FQlVTWTsNCj4g
KwkJZ290byB1bmxvY2tfb3V0Ow0KPiArCX0NCj4gKwlzd2l0Y2ggKG1hc2spIHsNCj4gKwljYXNl
IElJT19DSEFOX0lORk9fU0FNUF9GUkVROg0KPiArCQlyZXQgPSBreDAyMmFfZmluZF90dXBsZV9p
bmRleCgma3gwMjJhX2FjY2VsX3NhbXBfZnJlcV90YWJsZVswXSwNCj4gKwkJCQkJICAgICAgQVJS
QVlfU0laRShreDAyMmFfYWNjZWxfc2FtcF9mcmVxX3RhYmxlKSwNCj4gKwkJCQkJICAgICAgdmFs
LCB2YWwyKTsNCj4gKwkJLyogQ29uZmlndXJlIGlmIHdlIGZvdW5kIHZhbGlkIE9EUiAqLw0KPiAr
CQlpZiAocmV0ID49IDApIHsNCj4gKwkJCWludCBvZHIgPSByZXQ7DQo+ICsNCj4gKwkJCXJldCA9
IF9fa3gwMjJhX3R1cm5fb2ZmX3VubG9ja2VkKGRhdGEpOw0KPiArCQkJaWYgKHJldCkNCj4gKwkJ
CQlnb3RvIHVubG9ja19vdXQ7DQo+ICsNCj4gKwkJCXJldCA9IHJlZ21hcF91cGRhdGVfYml0cyhk
YXRhLT5yZWdtYXAsIEtYMDIyQV9SRUdfT0RDTlRMLA0KPiArCQkJCQkJIEtYMDIyQV9NQVNLX09E
Uiwgb2RyKTsNCj4gKwkJCWRhdGEtPm9kcl9ucyA9IGt4MDIyYV9vZHJzW29kcl07DQo+ICsJCQlf
X2t4MDIyYV90dXJuX29uX3VubG9ja2VkKGRhdGEpOw0KPiArCQl9DQo+ICsJCWJyZWFrOw0KPiAr
CWNhc2UgSUlPX0NIQU5fSU5GT19TQ0FMRToNCj4gKwkJcmV0ID0ga3gwMjJhX2ZpbmRfdHVwbGVf
aW5kZXgoJmt4MDIyYV9zY2FsZV90YWJsZVswXSwNCj4gKwkJCQkJICAgICAgQVJSQVlfU0laRShr
eDAyMmFfc2NhbGVfdGFibGUpLA0KPiArCQkJCQkgICAgICB2YWwsIHZhbDIpOw0KPiArCQkvKiBD
b25maWd1cmUgaWYgd2UgZm91bmQgdmFsaWQgc2NhbGUgKi8NCj4gKwkJaWYgKHJldCA+PSAwKSB7
DQo+ICsJCQlyZXQgPSBfX2t4MDIyYV90dXJuX29mZl91bmxvY2tlZChkYXRhKTsNCj4gKwkJCWlm
IChyZXQpDQo+ICsJCQkJZ290byB1bmxvY2tfb3V0Ow0KPiArDQo+ICsJCQlyZXQgPSByZWdtYXBf
dXBkYXRlX2JpdHMoZGF0YS0+cmVnbWFwLCBLWDAyMkFfUkVHX0NOVEwsDQo+ICsJCQkJCQkgS1gw
MjJBX01BU0tfR1NFTCwNCj4gKwkJCQkJCSByZXQgPDwgS1gwMjJBX0dTRUxfU0hJRlQpOw0KPiAr
CQkJX19reDAyMmFfdHVybl9vbl91bmxvY2tlZChkYXRhKTsNCj4gKwkJfQ0KDQpJIGRpZCBhIGxh
c3QgbWludXRlIGNoYW5nZSB0byB0aGUgbG9ja2luZyBoZXJlLiBBcyBhIHJlc3VsdCBJIG1pc3Nl
ZCB0aGUgDQpicmVhayBjYXVzaW5nIC1FSU5WQUwgdG8gYmUgcmV0dXJuZWQgZm9yIHNjYWxlIHNl
dHRpbmcuIFRoZSBidWlsZCBib3QgDQpwaW5nZWQgbWUgYWJvdXQgaXQgOikgV2lsbCBiZSBmaXhl
ZCB3aGVuIEkgcmVzcGluIHRoaXMhDQoNCj4gKwlkZWZhdWx0Og0KPiArCQlyZXQgPSAtRUlOVkFM
Ow0KPiArCX0NCj4gKw0KPiArdW5sb2NrX291dDoNCj4gKwltdXRleF91bmxvY2soJmRhdGEtPm11
dGV4KTsNCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCllvdXJzLA0KCS0tTWF0dGkN
Cg0KLS0gDQpNYXR0aSBWYWl0dGluZW4NCkxpbnV4IGtlcm5lbCBkZXZlbG9wZXIgYXQgUk9ITSBT
ZW1pY29uZHVjdG9ycw0KT3VsdSBGaW5sYW5kDQoNCn5+IFdoZW4gdGhpbmdzIGdvIHV0dGVybHkg
d3JvbmcgdmltIHVzZXJzIGNhbiBhbHdheXMgdHlwZSA6aGVscCEgfn4NCg==
