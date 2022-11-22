Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7836D633A65
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiKVKoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiKVKoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:44:11 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40285B7F5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669113477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXF9hPBSo9vkwAFR1C6L/u7K/jsqqcsZv4mP1xuPqNI=;
        b=Gyv5FQk0Gdbj99PBZOJ5OHI6ptdAMytCwyFM/fOYaB7m8tuKILiFa67VsSYTTIkCljDY8g
        FCjUJNSpiOI3ZvGUOz0LlQtRkn1QQnMFbupEfg45u3v+C2aOD9e66BnzUcT5/ZZkgxzLst
        qFOU143eshgQznlRzjRpg1/dyp5/ft/zvQAHV1OWKdqsgAYoQugMMLqvO4AveKBDr9hHFw
        /KA3S6tyzYsb/l3bJ/c7ZjaCH7F/hktHSP84IoU755aPvJRxY5qo4Cp3EG74lRfQvtIOH8
        kToe3KhU9XJ7/m0Bt7R/pwqu87yGeJeg9Pe+ifsKLnrTQcdHMvP5zYpgO1tIwA==
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-ImHsRpvbNliKI16uNhsu_w-2; Tue, 22 Nov 2022 05:37:53 -0500
X-MC-Unique: ImHsRpvbNliKI16uNhsu_w-2
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by PH8PR19MB7046.namprd19.prod.outlook.com (2603:10b6:510:226::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 10:37:50 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 10:37:50 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v3 1/4] x86/of: Convert Intel's APIC bindings to YAML
 schema
Thread-Topic: [PATCH v3 1/4] x86/of: Convert Intel's APIC bindings to YAML
 schema
Thread-Index: AQHY/kRfW1rEdSurPU+OlYduityf0q5Kp+8AgAAJMgCAAAdZAIAAB+mA
Date:   Tue, 22 Nov 2022 10:37:50 +0000
Message-ID: <e63306e0-8cc1-56c5-3600-e95ce4fbd335@maxlinear.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <0cf089495a422b945ac4fc9c980ddb5429a711c3.1669100394.git.rtanwar@maxlinear.com>
 <Y3yR+Ouc7l9RvB8K@smile.fi.intel.com>
 <b790fa4b-e2d8-ad21-09a3-6b92c863343f@maxlinear.com>
 <Y3yf2OWt6nE4xVVi@smile.fi.intel.com>
In-Reply-To: <Y3yf2OWt6nE4xVVi@smile.fi.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|PH8PR19MB7046:EE_
x-ms-office365-filtering-correlation-id: 41845b1e-1d1c-45c7-ac59-08dacc759a89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: K49aDPhvoHJpwiOzcFujDCPpFLB6yV87EuvaNgCKbXoeljTQRmfRVxMwEekW6Vh2sbg/ErEifO5AzXTgrlGIyTVCeq9Hjd3KgTBdsAtvUJozESHb4c9yuZNEcF8TswEfKCLlVEnCh/namaLynYnJ1qLKKvwR46xDsmYpICtcEc/ayVqcHtOb721ng0BtiloQ6AX2bT9OCl2/HRmA3aZ3ae1bqmGyxs7J0jBbCYOGGs4eIEWVWbBYuWbicyRAI/3fmH5iNBs84Z4HtIQx4/nMjpQenaw2v7etXn7NvON6YI0u210DguDm3XYW4ThJ6Atu9tvN4d2OT7K23RV2WVRNnl20c1hsOh1BQS7x5IJRAGwVGQvO2zK6k7/V0YcKsrNoT4yRDu3dCxLU5Y5bUjnz12Ito/yZ+MV2cdiTrCUgRl9sljmsJTqJMRn+CYS3ZCR0CK1ScJkuN0sd902RU4FiGXR8EmcjWTsojUfTOTQtEGD+NmeC6aKL+LmIpXCqgpY5v5hKQXEaDjnVsawK1+V7mOPZx8UJa7C5CMmvdYfIXW1I+Pxk3gfiAwxoWkQrXC1UWeiRe3pXNb+ABPKvAQNvZ+CVliprho57eAiGMl9yl38NqW9t1JYNyXiSVIx9HULGK/TpxMvmSecBc21dsIwNchrmPq1UGaScE1eU19UFy+xuuxfO2wTYRC2GwUgQNMti9Tza8whYDe9YR9tBrt3IwLEfqoFjz/o8+ywKz63SEvWYbTKmb6QPlj6HMBsv8jLAfB4mlCqCVFOW9gX5PmWNKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39850400004)(366004)(451199015)(38100700002)(31696002)(2906002)(31686004)(41300700001)(7416002)(66446008)(8676002)(66556008)(76116006)(66476007)(64756008)(4326008)(316002)(6916009)(66946007)(122000001)(91956017)(54906003)(6486002)(36756003)(478600001)(38070700005)(6506007)(86362001)(6512007)(107886003)(5660300002)(8936002)(53546011)(186003)(2616005)(71200400001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTg1MjFJbWlUMThtMW8ySHVTWWpGMTE3aUZ1SnN2cFdxNjloSWg5Vkh6dVBZ?=
 =?utf-8?B?UjNwdkFRUTdQQ1gwbjg1MWVTanhucEVscjBOYUVDamp4LzY4N2NYU2Exc2E1?=
 =?utf-8?B?ZXQzOWtBS24rRGVQUnNHVjh5M1Y5S250MlhYK1RFcjhmTGRmRm1tdWE0OWhK?=
 =?utf-8?B?SGxjNFJvN2VsT0pXd1pFNWd3NW1KKzFyVXM2dElyVzBCQlZrV29Ka3lzdHMw?=
 =?utf-8?B?cVorb2lFdVNLZU5GM3Mxalh3SWdSdHVnMkxoMFZIRmtvU0xJM3hBT21iQVQw?=
 =?utf-8?B?RlR1dy9VRk8rQ21sdjR1ZU1OdVlrdWRnY0t3UnhjZmw0ZUFjUHFBaGFzMmta?=
 =?utf-8?B?bFlaTFJRM2hZM3RsQ1VIVkZFSXROU3BSOG5Fd2RZMk1GckhCbGhEUVF1YWlS?=
 =?utf-8?B?cVZmNk9xV3NNaHJ3NG1MWlZINUlLY2g3ODFnMmY2THZUVkwxT1dud2VzeHBU?=
 =?utf-8?B?Sks2cGF0Ui8yK1FUOGlkUDdIKzd4T1ZTWFFwbnBYdlZwNzM3NFY5MjRxM2ll?=
 =?utf-8?B?enNuYUUvbE9jN1E4UFlnQjZOVkFPOGY5WEdzdEZqeEJnYTQ5aTZPQitVUWFx?=
 =?utf-8?B?cDdabEU5eFpiazFVU2RnVEVycDRObnNmTHVSajhkVGdRczU2Z3d3emF0RFg3?=
 =?utf-8?B?MnNWRVBxem9RNnlmTk9GY1Z5YlRMTi9INFlma2VjUW9Ld1RiWkpQSHptNkpG?=
 =?utf-8?B?eGJzWWw2RDZBSjVvUmxtS0VXd1p6MExTMDNqUk1DVks4VEJUSStuYmNjK1dD?=
 =?utf-8?B?azdDSjRpWlZLOS8wY2UrRFhISlNYTU0zNmszZ1pBZzFvUk1pZzZuYzhrWDJr?=
 =?utf-8?B?Qnd4OEZJUDNIZmtuaDNmZldTaTkvaGtTYUJWV1l3akpYWUlyeVdZNWRwMk5x?=
 =?utf-8?B?MjdnMWxUd3BMUDlacWVJd29JMzdmYkhWS25sM3Z5SmxTVUdEMXBCM2JaWWRV?=
 =?utf-8?B?T2sybzJMUDlBaWlCMUNXQ0tQU3lCR1c0NHpuNEJvQ1Nab3lzYVlEVzhQeHRG?=
 =?utf-8?B?Wnl1SGl4ZHVNNTcvcTBaNTJHTDM3SFdCSXBpZU1Cd2c1YUFrV0RIaGh1dXMz?=
 =?utf-8?B?SW92WVo3R1RoQi9NL21uejV2SzV5MEZ2emlUd3V1RWpWNXR3K3Q2T09oN2JR?=
 =?utf-8?B?VnNFRlRwL2Q2SFhsMTJEbFU4YzJ2WGFXTHQvQ1h0cFBCRlFONnVlUERpNXZm?=
 =?utf-8?B?VmVVbDdsSENvRVRwZUdNRXA0Q0lYYlRGdGxGZG9BMGpXdmQyRllQRXFoanNN?=
 =?utf-8?B?NGxPNGwzOEZISGR2MG0wR3FQQUtTWjg4M1JwTmxKVElJN3VodG41YkovRkR1?=
 =?utf-8?B?ZXB6RDBSNTMvb2pwd0VkUGVWbTVGVXhxRzhraWpqZC8yc1JLT1ZEYVprY0l5?=
 =?utf-8?B?YnhaZkc0d3JxRytBeUNiVkZmNnQ1M3BmR2xqVU80blc5Nmc2WDNGMlFDWTRN?=
 =?utf-8?B?aWMrV2FNYjhMLzgyNTlpWW5wRmM1NHpFa2F0UFRxRm5KNUs5Y0tNWGpQM1o0?=
 =?utf-8?B?OUY4SU9pS3F0blc3di8rcm16QmEzcUZXN3pZV0RRd0d3Z0ZLOFpza3d4VXo3?=
 =?utf-8?B?cm55Y2draWltV01qVUVCZTRQMElYQzJjc2FNTno4SVF1SHNiSENpYnk3NjFv?=
 =?utf-8?B?Qkg0eTA0bWVEMEpUdXV6bXdSNGtIYkx0RTBjS2xkZUdMeUM1NGhhdmZkSWFV?=
 =?utf-8?B?Q1NyZVhUeWRYOVBpUng2V2U5QnJKRCtmeGh5VlNzTlh5YTFMUFIrMVZ1VnBs?=
 =?utf-8?B?U1UzVHEvSjAwQ0V4bTJLQ0cvSkI2MWZFYTBZbmRZRmpERlRtb0dHTmpqZGto?=
 =?utf-8?B?TUtka0NCWWdoZjA0b2JMaE5hSjRCeXZXVkVBaHRNYkg0cDdVM25lVjlySldO?=
 =?utf-8?B?UUVSemNJKzJhOXYwaE12R1VHYllpRmNZTHhFRm0vZGppZEhHUXgydWx3YlFp?=
 =?utf-8?B?RWd2QjhMZ0hwNEtEdGlXRk9rZlExQmpEWHg4SUtsSVZqRVdkSFRzTTM4NHdj?=
 =?utf-8?B?REhGbExyc2kzMmxrdW40aEJyNFdHNEwzRjF0STJSYVNLUERxRC8wVnFWdXhL?=
 =?utf-8?B?aHFWR1BqTVlZb0F1L2txYmxxNC9JcmNtSkdXZ2JPaUZ1dEUzSDRHaTVWVjZi?=
 =?utf-8?B?K0wvY3NTU0dYeXhLL3FiT0pRSTdqdHI5UFRnY0VMV0Y0ZzlMZnJoY1dPT0xB?=
 =?utf-8?B?Nmc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41845b1e-1d1c-45c7-ac59-08dacc759a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 10:37:50.1831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XFaUEBL/NFZnrBw9ldeuFmOzpIYBJMOs0Rv+IrhWjwvOwUn/tlw2esdrD8Xkv9OKnlA1EB2vXcqEH9utnB1TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7046
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <18C3EEE2BCC0F345B53EB204B23DDB9C@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMTEvMjAyMiA2OjA5IHBtLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IFRoaXMgZW1h
aWwgd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIE1heExpbmVhci4NCj4gDQo+IA0KPiBPbiBUdWUs
IE5vdiAyMiwgMjAyMiBhdCAwOTo0MzoxMkFNICswMDAwLCBSYWh1bCBUYW53YXIgd3JvdGU6DQo+
PiBPbiAyMi8xMS8yMDIyIDU6MTEgcG0sIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4+PiBPbiBU
dWUsIE5vdiAyMiwgMjAyMiBhdCAwMzozOTowN1BNICswODAwLCBSYWh1bCBUYW53YXIgd3JvdGU6
DQo+IA0KPiAuLi4NCj4gDQo+Pj4gICA+ICsgZmlyc3QgYXBwZWFyZWQgaW4gQ0U0MTAwIFNvQy4g
U2VlIGJpbmRpbmdzL3g4Ni9jZTQxMDAudHh0IGZvciBtb3JlDQo+Pj4NCj4+PiBTaG91bGRuJ3Qg
eW91IGNoYW5nZSB0aGlzPw0KPj4NCj4+IERvIHlvdSBtZWFuIGNoYW5nZSBjb21wYXRpYmlsaXR5
IHByb3BlcnR5IHByZWZpeCBmcm9tDQo+PiAiaW50ZWwsY2U0MTAwLWlvYXBpYyIgdG8gImludGVs
LGlvYXBpYyI/IElmIHllcywgdGhlbiBpIHRvdGFsbHkgYWdyZWUNCj4+IGFuZCBpIHdpbGwgY2hh
bmdlIGl0IChpbmNsdWRpbmcgbmV3IGZpbGUgbmFtZXMgJiBhbGwgb3RoZXIgcmVmZXJlbmNlcyB0
bw0KPj4gY2U0MTAwKS4gSWYgbm90LCBwbGVhc2UgY2xhcmlmeSBtb3JlLi4NCj4gDQo+IEkgc3Bl
Y2lmaWNhbGx5IGVtcGhhc2l6ZWQgYSBzaW5nbGUgbGluZSAoYnkgcHV0dGluZyBibGFuayBsaW5l
cyBhcm91bmQpLg0KPiBGb3IgeW91ciBjb252ZW5pZW5jZSBJIHJlbW92ZWQgdGhlIHVubmVlZGVk
IHBhcnRzIG9mIHRoZSBjb250ZXh0LCBzbyB5b3UgY2FuDQo+IHNlZSBiZXR0ZXIgd2hhdCBJIG1l
YW50Lg0KPg0KDQoNCkdvdCBpdC4gSSB3aWxsIHJlbW92ZSB0aGUgbWVudGlvbiBvZiAiU2VlIGJp
bmRpbmdzL3g4Ni9jZTQxMDAudHh0IiBmcm9tIA0KaGVyZS4NCg0KDQoNCj4gLi4uDQo+IA0KPj4+
ICAgPiArIGZpcnN0IGFwcGVhcmVkIGluIENFNDEwMCBTb0MuIFNlZSBiaW5kaW5ncy94ODYvY2U0
MTAwLnR4dCBmb3IgbW9yZQ0KPiANCj4gDQo+IERpdHRvLg0KPiANCj4gLS0NCj4gV2l0aCBCZXN0
IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KPiANCj4gDQo+IA0KDQo=

