Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C9362BC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiKPLnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbiKPLmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:42:39 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFEA5CD1B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1668598061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEuE3CJDaQfluGDDO8Jzwt+RjFUAFltayvSVQj5nhqc=;
        b=kUBT3ctQrhxjlqoZlVVa8LvxzQuPJgjH53LlIqzV1w5VUkN8w0FG/SdjWzMyYA0IKXe/S2
        iU3PYTSnhNEsuXRYQMGWsIqaWrIUT1CIDHAYoVbdtC0uBs7StQsgL2BiQY2DST65IS2tBJ
        QQFRMA7+00ULfphvFh6lG4cAYdsZDD9NJVutdp0vL6x09J5AkSyerO2DaSQ/wZjn6OQ11k
        DOBW41ucRw4dkqTIFYKrmJG57PwSCemtpuV0ex4fImxhokzVf7g1nxN1JH3XMskChASg7q
        /mtRSy79mmuoug1pARnBuAQPv1EhrdC0oAxBZeArWS5pL9aQMUpmp4uWw4SLBQ==
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-88278trJNPiCERzFa9N-yQ-1; Wed, 16 Nov 2022 06:27:40 -0500
X-MC-Unique: 88278trJNPiCERzFa9N-yQ-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by BLAPR19MB4276.namprd19.prod.outlook.com (2603:10b6:208:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 16 Nov
 2022 11:27:38 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::3696:7b21:2a3f:1503%7]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 11:27:38 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
        "dirk.brandewie@gmail.com" <dirk.brandewie@gmail.com>,
        "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
        "sodaville@linutronix.de" <sodaville@linutronix.de>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v2 1/2] x86/of: Add support for boot time interrupt
 delivery mode configuration
Thread-Topic: [PATCH v2 1/2] x86/of: Add support for boot time interrupt
 delivery mode configuration
Thread-Index: AQHY+aYwfQQe9+ocpUuq5OloShaUDK5BXPEAgAAMnwA=
Date:   Wed, 16 Nov 2022 11:27:38 +0000
Message-ID: <94efde88-ba30-8155-4561-c6b335fec1a2@maxlinear.com>
References: <cover.1668589253.git.rtanwar@maxlinear.com>
 <9114810c7af7fbaf9d0b2823752afcef865bdda0.1668589253.git.rtanwar@maxlinear.com>
 <Y3S+lLzcmytKHLRq@smile.fi.intel.com>
In-Reply-To: <Y3S+lLzcmytKHLRq@smile.fi.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|BLAPR19MB4276:EE_
x-ms-office365-filtering-correlation-id: 99dfcf94-1160-4afd-f1f1-08dac7c59169
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: +NgvzIrW6F6oeDz3nLrw1iq+w9si0ODkT1/D9pwYb3DyORfp1JWBMLQcP3uEJH3OWFCF8cuWQ7gNm704V/4HhfLk7r2TDQiYOqiCO7wNgMvTOSN1xlZfCczG52LuE0Tqxt/kWQIgg/b3fpcluSyqjkph8AT/URkCYATgaKC/jBP9KwwUC9Gzo3zrpORR6IXPZsFvEPHJVfrNmfqLC8T30SFqi+NGm2YjsON7JibHAdUvlDf2W4f+T+gxrpPwvnoVrs1W/GeFU7lgeAndsOMVcBXGuUQshBsqojHFWvHXC+Pm7ntmYy1QsvEc9jmJj0iU2HH9iOn1DiNJscDIjFfDbcoJieG4WNNa8HDbllfRjqef7RnKtMDrPiLZV4WJoJi3pse9yaap4rrurJL5jbbL/zm+QGVQcthU0vNMnrlUdxy7Qm253hgM+N8KXupMMXQnvl+EJV+JFMMi6QXaVfzV8KvuAtK7xGgrQqZ9IdhI67bqbp4vxV4eCstHgGouiaAxio5S3EjycI8sU9RMDz3Exfb4AhsVJZBmgbkbiFvbVUVBHohGJOaaM5fOQZLR0GnzEi5skcrMZxDCf504Y8gIjZkWOxyYGHKzzFg/+aI0PG+0xv1y3D5wLkyBhYaJXd6S3D093NaNd6EJHu4AzpESYk4YjR9yt3G8U5aaLrUmcW/ValhdBndTvLr4989ZZRYcyXcLphBFcK7M1hJ8MitOW4i00CUTQY2TpN8/UlRltbdbiWPtaacDHafWae0Sp7zf0fxgO/Q/sVVc+lSHwePflYIDNln5UsrBstLK0BWxAKhzFv9dYUEGGp6K3ow3V6EQcnbEP8piDnWoPVK0KC84WAnxvAswR0AOUrlw0UTl7d8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39850400004)(366004)(451199015)(31686004)(122000001)(38100700002)(36756003)(478600001)(6486002)(966005)(71200400001)(38070700005)(83380400001)(76116006)(31696002)(86362001)(7416002)(107886003)(8936002)(53546011)(5660300002)(186003)(2906002)(66556008)(4326008)(66946007)(8676002)(66446008)(66476007)(64756008)(6506007)(91956017)(26005)(2616005)(6512007)(41300700001)(54906003)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnBCQnphQldQQUpGM0dGOE9sWWhMbHI3cG53QnNOL2U3Q1d5Z3NZVHVRSCt3?=
 =?utf-8?B?UWVDUW00WVJjQURWNFVVWmJQNHlIWTNYYW10RHlMRTlHOFhTZmtjMUpwdmI2?=
 =?utf-8?B?N3k4a2lHd1NkTUJSVXQrc0NVbVNrRVFnbEwwRTh6OGgyeGJ0YkRGTlpCOWN2?=
 =?utf-8?B?S0ZNRjhLWUYxenlxakhjcUZqNnJrOWtteCtLMWdxRWg1RTM4aE5XbWdNdmpk?=
 =?utf-8?B?MzA4M1dQS2RtWkowTE1MVzlDaWN3MmpTaGJCL0o1Q3lwZlphV1BaT21yalV2?=
 =?utf-8?B?TG4weHpSTGszaVM0NGpDYlBsc1prVldOaEpIMVM1T2dJTjBHelkyVklTWExD?=
 =?utf-8?B?T0lGNVB2b1o1WnBDeDRCS0twZTh4M2prT0Nnbm1PYW5SNmRXRyttUlhrRWVt?=
 =?utf-8?B?VXROdnVlaGU3Vyt0bDZxMFc5ZEowdkVMZTV4WXZoNnFyamNORDlmKzNHeW1U?=
 =?utf-8?B?bHBhQWJLdS95MXVJOUJPRjJKdFptY3NDTUpSVGJ0aXVMMkpQaGZ6R3NjVU9M?=
 =?utf-8?B?VVEyUDVFSjVpLzRyNCtIK3hQeDZxTm0wNXdPQnVReW9CNFkyVEJOV3hHUSs2?=
 =?utf-8?B?YldOOENXV2VKOU1RNzFXMlJLVFhuanFmRnk2MDMzWWE5TzdBUnRySlFiTGRF?=
 =?utf-8?B?N1I2K2tiRmxSVlBEWFowTG55M21xTjdiYnF3cHJWTkVxMHF6eWNPZXpGMUV4?=
 =?utf-8?B?Y1VPbVhPa0FzSXJTdEtSYy9ITXhwRFRDaysyc1NUdWNqbzJ3Y1ZyME5tbkEr?=
 =?utf-8?B?ek9ESjlybE9sd0lIOE1BVnhyMzk0WDNxNjdzYjVGM1g0RGZZTksxQ3VSajBK?=
 =?utf-8?B?a2p5aFoyakg0a1IySTcweVpxekNFb2wxN1NtRCtVMWkwSFpSVGRRV2hHN0VV?=
 =?utf-8?B?S1lUbDF5NU1JMTl3dlMvWVQweUV0U2xFdXhwS0J4TDQ5NTY1ZG1jemxtVFhx?=
 =?utf-8?B?SjJacFZsZkJFTk5xL0YyL2dKdkViNUpkYkVaazRKZEwwMCtndUtVa2lySHpN?=
 =?utf-8?B?VlBoYWk3QVNBZkRFYU9tcytydGxML240bFhZRXNmNW9lb29PakhBZDI4UXVz?=
 =?utf-8?B?cHFqWHFjRnoyNjFGN29xK0hRRXRDenNHTTYvUTh5cVFtV08zUWloMEJhZEQ0?=
 =?utf-8?B?c1BEcGovOUpjTkZvN3l6Tkl2TzJTSXNXYkJmR2JwZDdUNVhYZEQ3b09aOUVP?=
 =?utf-8?B?ZzlJVHRKQ3BDUnF2enhkd2NMNlFKVDlQMnBjZDJhcXhESUMybi9DWDh4enho?=
 =?utf-8?B?alRzQVBmeUNJMnJEZmM5SWJvbEZxMnNyc0pLc2JHRW1zSnlqTGRBWHRHUnI2?=
 =?utf-8?B?MW9hMWg5ZXJCK29UYmg2RjdwVGM4QllhclJkd0lUQUZraUt3WFJRVkZ4cVN5?=
 =?utf-8?B?RjNnZWdVTTJSUFhIWm9wK1o5MWJ4YmhhanZOU2VMaExlbGVGTnRQS25VNU9M?=
 =?utf-8?B?ODE0VFg4eElqc1lxZW9CcGYzNXFHdmpNaXdRdTl3V2FjNEtjN04rM3R5czQ2?=
 =?utf-8?B?RGlFdFNDdENRcXhTcmxjSUNpVGpFSkdUUEk2clVMUmFLQ1AvRXp0UExjdi9W?=
 =?utf-8?B?M0FvOVFQcW1YRndFSEYzZGxsaEw5amRJbUxuK01vcEh6dFNCM3RRenFTTC9x?=
 =?utf-8?B?bUx5SkhUZlZoMTJKNWU1cGtsbEZMMHJNalZWZTA2aHNWT2FwWGUxVTZxZlhL?=
 =?utf-8?B?RmJoSDNsNzNsOHpHS2pVUjRMaUVLY1hHdEJqd0RzVUVjMTIzWGxOY3ZRdDRx?=
 =?utf-8?B?QzU1allBQ2U5Kzd1UUZOSjc2TUZyZ1FNWHFSYUhZbVNqQk5DUXg1WXZndWxW?=
 =?utf-8?B?Qzl2cXRoQWFvVXg2N1pBZWlhVEFFQVRxbXR4V2NIeHNXNWJNRVJSTHlJNDlj?=
 =?utf-8?B?U1BMMmNhaExzQm5Vb1FuazNGOWRGWDlQWWEvS2xMUzlReWovcWtCcHpZNmtx?=
 =?utf-8?B?SnZEblQ0SE44WnlYUnpEZmRzOGVldTYva0s1Y29jWXZZZTZJRXRWL1RNeEY3?=
 =?utf-8?B?SWYzQ3pLRG9CTGZOa1E1VHFYbm55dlBnZXduZWhhTi85UEN4cVNsTnBlcVp1?=
 =?utf-8?B?ZjFKSGdVUnhFM3U4cFFHM3QrZ2NVSG9Hc2crWi9lZnBNb0FFSFhxeVJtZ1FL?=
 =?utf-8?B?b2x0ZGJGZ0psSmxqQStMaXl1UTBBc1h6dFR2U2NOYVNkNXprRmhVTm9aS0V0?=
 =?utf-8?B?YVE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dfcf94-1160-4afd-f1f1-08dac7c59169
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 11:27:38.8002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDmGFJy+tD8icj2COfFvT83GXQs6nwyc+y6wqwW6NMuZW0GIZzpW3caGLHUN8YTqSjnG59oJ5FGrc7qhMoTrBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4276
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <7F3A50DB1B8F7144B68A85DF99893410@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMTEvMjAyMiA2OjQyIHBtLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IFRoaXMgZW1h
aWwgd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIE1heExpbmVhci4NCj4gDQo+IE9uIFdlZCwgTm92
IDE2LCAyMDIyIGF0IDA2OjI4OjIwUE0gKzA4MDAsIFJhaHVsIFRhbndhciB3cm90ZToNCj4gID4g
UHJlc2VudGx5LCBpbml0L2Jvb3QgdGltZSBpbnRlcnJ1cHQgZGVsaXZlcnkgbW9kZSBpcyBlbnVt
ZXJhdGVkDQo+ICA+IG9ubHkgZm9yIEFDUEkgZW5hYmxlZCBzeXN0ZW1zIGJ5IHBhcnNpbmcgTUFE
VCB0YWJsZSBvciBmb3Igb2xkZXINCj4gID4gc3lzdGVtcyBieSBwYXJzaW5nIE1QIHRhYmxlLiBC
dXQgZm9yIE9GIGJhc2VkIHg4NiBzeXN0ZW1zLCBpdCBpcw0KPiAgPiBhc3N1bWVkICYgaGFyZGNv
ZGVkIHRvIGxlZ2FjeSBQSUMgbW9kZS4gVGhpcyBpcyBhIGJ1ZyBmb3INCj4gID4gcGxhdGZvcm1z
IHdoaWNoIGFyZSBPRiBiYXNlZCBidXQgZG8gbm90IHVzZSA4MjU5IGNvbXBsaWFudCBsZWdhY3kN
Cj4gID4gUElDIGludGVycnVwdCBjb250cm9sbGVyLiBTdWNoIHBsYXRmb3JtcyBjYW4gbm90IGV2
ZW4gYm9vdCBiZWNhdXNlDQo+ICA+IG9mIHRoaXMgYnVnL2hhcmRjb2RpbmcuDQo+ICA+DQo+ICA+
IEZpeCB0aGlzIGJ1ZyBieSBhZGRpbmcgc3VwcG9ydCBmb3IgY29uZmlndXJhdGlvbiBvZiBpbml0
IHRpbWUNCj4gID4gaW50ZXJydXB0IGRlbGl2ZXJ5IG1vZGUgZm9yIHg4NiBPRiBiYXNlZCBzeXN0
ZW1zIGJ5IGludHJvZHVjaW5nIGENCj4gID4gbmV3IG9wdGlvbmFsIGJvb2xlYW4gcHJvcGVydHkg
J2ludGVsLHZpcnR1YWwtd2lyZS1tb2RlJyBmb3INCj4gID4gaW50ZXJydXB0LWNvbnRyb2xsZXIg
bm9kZSBvZiBsb2NhbCBBUElDLiBUaGlzIHByb3BlcnR5IGVtdWxhdGVzDQo+ICA+IElNQ1JQIEJp
dCA3IG9mIE1QIGZlYXR1cmUgaW5mbyBieXRlIDIgb2YgTVAgZmxvYXRpbmcgcG9pbnRlcg0KPiAg
PiBzdHJ1Y3R1cmUgWzFdLg0KPiAgPg0KPiAgPiBEZWZhdWx0cyB0byBsZWdhY3kgUElDIG1vZGUg
aWYgYWJzZW50LiBDb25maWd1cmVzIGl0IHRvIHZpcnR1YWwNCj4gID4gd2lyZSBjb21wYXRpYmls
aXR5IG1vZGUgaWYgcHJlc2VudC4NCj4gDQo+ICA+IFsxXSANCj4gaHR0cHM6Ly93d3cubWFudWFs
c2xpYi5jb20vbWFudWFsLzc3NzMzL0ludGVsLU11bHRpcHJvY2Vzc29yLmh0bWw/cGFnZT00MCNt
YW51YWwgPGh0dHBzOi8vd3d3Lm1hbnVhbHNsaWIuY29tL21hbnVhbC83NzczMy9JbnRlbC1NdWx0
aXByb2Nlc3Nvci5odG1sP3BhZ2U9NDAjbWFudWFsPg0KPiANCj4gTGluazogPw0KPiANCj4gLi4u
DQo+IA0KPiAgPiArIGlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2woZG4sICJpbnRlbCx2aXJ0dWFs
LXdpcmUtbW9kZSIpKSB7DQo+IA0KPiBZb3UgbmVlZCBhIHNlcGFyYXRlIHBhdGNoIHRvIHNob3cg
dGhpcyBwcm9wZXJ0eSBiZWluZyBhZGRlZCAoeWVzLA0KPiBJIGhhdmUganVzdCBjb21tZW50ZWQg
b24geW91ciBwYXRjaCAyKS4NCj4NCg0KV2VsbCBub3RlZCBhYm91dCBpdC4gV2lsbCB1cGRhdGUu
IFRoYW5rcy4NCg0KUmVnYXJkcywNClJhaHVsDQoNCg0KPiAgPiArIHByaW50ayhLRVJOX05PVElD
RSAiVmlydHVhbCBXaXJlIGNvbXBhdGliaWxpdHkgbW9kZS5cbiIpOw0KPiAgPiArIHBpY19tb2Rl
ID0gMDsNCj4gID4gKyB9IGVsc2Ugew0KPiAgPiArIHByaW50ayhLRVJOX05PVElDRSAiSU1DUiBh
bmQgUElDIGNvbXBhdGliaWxpdHkgbW9kZS5cbiIpOw0KPiAgPiArIHBpY19tb2RlID0gMTsNCj4g
DQo+IFdoeSBub3QgcHJfbm90aWNlKCkgaW4gYm90aCBjYXNlcz8NCj4gDQo+ICA+ICsgfQ0KPiAN
Cj4gLS0gDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCj4gDQoNCg==

