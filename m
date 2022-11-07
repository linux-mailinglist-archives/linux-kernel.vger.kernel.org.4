Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463E961E89E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 03:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiKGCfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 21:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKGCfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 21:35:00 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2113.outbound.protection.outlook.com [40.107.117.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529A32BFB;
        Sun,  6 Nov 2022 18:34:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azz+aK+IP1x2DSpgAhOudBL5B1kk1W+hwDagl61IPGZ17YZDIRmDZYOw1r4r1gKo6u6yPDY7WqG0jIU/9v7lqhotRVVpfLwVnPfvTXj4n10goNdxyZxc5eOdE2miZesyvR/OUoKELlLyap7ySoghOixBZ43nFUXJ20Wn3hUE/fUreQC8nM5FseAYOjO/szZcT+YPaeB7RjDHba4X1BeFy5o6nV52dwM3UYVYkzNX/6xHqjUFLEBXZfjUHl2TdUu261VxZm1Tyr++eW3l1lAh20S5NtPD7t3I1b1Bt4WGyt2nc1TV6xZNVM/MfNrO7OKoNtk0ANmJbZAPQGH4nbgK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ORcJm3nbhxyz6BTforkaRChcMvdzXnNMxzToH+THEg=;
 b=e9w93hxtfMJVyQC/VgH/VbMH4vMLjfi8+o7zNSCg8NDcG8Zg0eZumgauC9recfsP9bWAqRdt/O1nPYS02tDz5WB1RnNlNPCXTj7yjBVnmxukjLO38bZYKaDZY3z41yuOtSW1yzZ0MnuwrhhxmJ0D+sd31QT9SuQmeO+j5CohtyJ0yD3FkU2MF+/wT2hxwwLuZNWdrzQAwq25OxQxdLb8egxCUPR1p4qTQFjPDGIQiIB89AHg3fxKEG7vf7PPSRCzSlc0pS6kQ+f8iJaZ9WzrMv4ovQhZ0+bKwV655OiqopNUmFoE02AmK8sKBT9uUJCbVgwvQiNAnRvopgSCfBiADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ORcJm3nbhxyz6BTforkaRChcMvdzXnNMxzToH+THEg=;
 b=qEhT2w8P4mNJAu08x3jy7+uVS2Xa/+lQ72xEDHwiPkhtpe+rDqxJZziM3bhq59TfdZ7Ria+ylYVKh+KVWbr42XugMXaTrkRywELpwln17e/NTnmMbPAR+rnTKSwoobNlscdTqgSX1lDNI/TqifSzh50F3/WmPFW/oioJhWfu9tR81GTS3kYDqFa3+y3+w7jec+gKygUgou1CVhCCgupe/lqVI/c3Tem002GzZGRXfcR0l44Dx2IK3m1a1n7SpPnK5qm3xisWjaKimiz2/DUte4Gq+rhjLe22bcJidUyV77TPX9A5YrjX5DNvIy6mIvhuu7UfBYfenYkUwqof7bX2iQ==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 TYZPR06MB3967.apcprd06.prod.outlook.com (2603:1096:400:29::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Mon, 7 Nov 2022 02:34:51 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831%6]) with mapi id 15.20.5769.019; Mon, 7 Nov 2022
 02:34:51 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH 1/2] iio: adc: aspeed: Remove the trim valid dts property.
Thread-Topic: [PATCH 1/2] iio: adc: aspeed: Remove the trim valid dts
 property.
Thread-Index: AQHY7Rw1NbmjJHkKbkGa7Ii+yaZMSq4yA9GAgAFLFwA=
Date:   Mon, 7 Nov 2022 02:34:51 +0000
Message-ID: <16211538-3501-4A32-96B5-1AD1BF933CA5@aspeedtech.com>
References: <20221031113208.19194-1-billy_tsai@aspeedtech.com>
 <20221106144949.61731d8e@jic23-huawei>
In-Reply-To: <20221106144949.61731d8e@jic23-huawei>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.66.22101101
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|TYZPR06MB3967:EE_
x-ms-office365-filtering-correlation-id: c2378aa3-b638-42e6-ee28-08dac068a5d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Js2q9uL9tDuJFceg2leGnsAM55tQUOlLDV5BEUHuKQSWMl5A3YNRVlB9CwfC4vvOi92zHbdIN9AwRpZ9klmjCTfHXODNKCia7gOh4F/m5WPV3wlzA9eDwjEbhcPBL0BtQHlKyQY6FE9nay7vx37GGmfp/VhTCH426B16rlEiZtxGn2RPVKzlys7YPTyOz7mXVNqVoIdbbnkOulkKYjsgSlG3JIIVFHNK5/EH7Fa/LyxiQHru56oLhrf5I/m+8S7eqAGWIzOhp3qGLvKm2U0XjBJsj0YuhfPmuTypZMNGik0MCdVsYiqrsF5VwVcEy1/fPrfVlGcPGU7xIRPZUJIxiTjMLp/h3I1Xa1PBRAOblkTRzrqMEbUOVapCouSITRJgSGIjo4gZlg0Zw7UttqpkSdeo7St6ZKZmlvyudIrv1KrZ7lrDhzfmvCyRA4duGWSXkLde3yaJrs9pCil8Xz1N2Y/XqP0aBKsx8E+ZOqQr5puqxfoUgzhUxtAtheWA5b1OsrZmroeKeNZn3yi+zidkXhyn0x96XDe+r0UHf8i8O60S1j/DzAd9TKJFd41AR8X+lfhbSXYQX8bJFSc3jTSqfRjYiu0tziV3/t2OoxGES7pKBrhNqv7copw0WZKwLRlxpDX9DbTsn7X2aRyzt6N0s75lpJbg2VFId2XslkEUrCdPsYfzxkwfBu+UQNxNsACdCjBFP5YwmWs8Kvg4VxjcghVPjQIcVLEjCHQVbgQlFsUHWrjwcgrHovaUMgUDX+xPFxQgwypHP+2nrDiPudKksCYkfN4PuJHl4/5NT9qja8g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39830400003)(136003)(366004)(376002)(451199015)(6512007)(26005)(5660300002)(6506007)(53546011)(7416002)(478600001)(54906003)(316002)(6916009)(2906002)(122000001)(71200400001)(86362001)(6486002)(8936002)(38100700002)(33656002)(41300700001)(36756003)(107886003)(83380400001)(91956017)(4326008)(76116006)(8676002)(38070700005)(186003)(64756008)(2616005)(66446008)(66946007)(66556008)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWxKMjdRdjJzOGRsYnlpay9TZUkwK20yZjZtZWV2QzdPT1Qzd0F4ZFlNZWk5?=
 =?utf-8?B?UzFjVVRlMWFVOFA3SEsySmJ0TE1nZ2dOTWI4amcwWDdsKzJMQmM5TUVaT1lD?=
 =?utf-8?B?aFAwQXpISTNnbTAzSmlUcVhZR0w3bWwwSEc5WDg3Ly80eGQwRmhxU3VsVUF2?=
 =?utf-8?B?MjdTZG53VEN1UFJYT1dpT05MekhEei9RTWdQQ1VMWGNUUXJQVGwxQjE3aXlm?=
 =?utf-8?B?blEzZCtUMzMwZVNseisxOTVCc3U5MU0xYy9wQUhtWW5OdUxoa01EeE9nWTF1?=
 =?utf-8?B?UzBCejhMakJKR2JkQUFlYzF0eUw3SVJuZGVSUnlIVzhsNzhNRElvY0FLQ0tp?=
 =?utf-8?B?WHd2YkpwUzlpOXUxSGdzVENrampuc0lNQno4Y2cvb0NKM3hJaGRIYURzdVNM?=
 =?utf-8?B?YzRvNkpreThoakhlNi9NbURYV2diQlBvRHBNdUJ5NVBBMlVyVlB0UC9wclJl?=
 =?utf-8?B?UUlwSnVhRFdKZjBwU2JZMjZWaTlmblNoTThWMXlveGl2SkU3Y2FqcGttUnNV?=
 =?utf-8?B?eFJJTEhwSmFHMUE4dHM5QU5UV2o4dm5wQWVMbkFVR1dibWc5SGRkSnpSd3lI?=
 =?utf-8?B?aCtXWUQ2ZTlWd1lsREU3V09pMjJCdVVYT01xUVcrWDJYdms1QWthL2FFd3Y0?=
 =?utf-8?B?QkNjT0M2cTRTbSt5c0xSR1ZrTk4wblhEclBlYURqaTkwaW1SOUhxYjQrbU80?=
 =?utf-8?B?clRWN3duTytqK3U1bGZJUkExRFpXbmtqbmFGM0hJWHBxZE5rNkJQRW5MaVl5?=
 =?utf-8?B?SGFOL2NVVHZjUFc3NEp6OUtLdTRJQXFmMGhDeERpdU1vV3hvOFhYRy94bVZQ?=
 =?utf-8?B?eXN2Slo0Y2Z0NTlvSXhjb2ZGMkw1czY3OG52bklMdjhqTUpJMndLd3ZlZG14?=
 =?utf-8?B?eXBSRW9rbVVLU2llWk8yam1FWlRyVTdnMGgwUGQ5N1puWjF0VXhUVkVUdlpn?=
 =?utf-8?B?RlN5dW9LaFFpTDFTWThhekRvR2pBWE1iV2ZhOTVya0V2aDlOQlh6WnJmQjRj?=
 =?utf-8?B?cXBPVFhBQ1psWm9RR3F5QUxNNGVQNGlWR3FWekxaNlBJN1dGM1FCMFlUOWpr?=
 =?utf-8?B?L3d1Tnpvb1JsbVJmSUtGbTVZOE1IbDhVdXpsYk5IZjM5eEltbkFmL1JpdkNv?=
 =?utf-8?B?cTRBNjdhYmpuVDZTY3VrYkZXQXZXU2p0Z2pGcURHaVFlcUFnRzhDWU5Xb3Ra?=
 =?utf-8?B?L0swSlJCUGFqNnNmeE1lVC9YUXRvYld3U0R2M09zdWR4Um1YWDRQaVdHQk52?=
 =?utf-8?B?bG5BSUtoczFzZmp0aXRZbmV6NHVFUmVUc3dNWVhPclJicTFyQ0ticzhEa1Vw?=
 =?utf-8?B?RTJCQ3JaNWFpcFpyNXJuWWxVMld1ZG5hQVZRT3ZxM0NCQVI4c3c2eitVOS83?=
 =?utf-8?B?OXZCcDN5YTc3dndraVhRM2xZcmlZazh5SlMrOHVQRkYwUEJ4aklkSjJWTENP?=
 =?utf-8?B?NFlwMVdpNlkzVDRlODcrNWxwajQ0T0JOSDdZQXU5R0hXZW5uZ0R5UW1UakFX?=
 =?utf-8?B?QTd5MUE5RldpRFYyZFlpUmpGNUoxcktqMXdZYTVuMGRsSmc3bzJweUE2NmtR?=
 =?utf-8?B?K2lEcm5HZEtmSXJPVDZGSXBSb3VDamgxeEEyWjd6OVJXSythTzVxNFQ3Rkhp?=
 =?utf-8?B?c2NCWHlrRTNQcm5tRmlqZjBKdUJ0dDVwaExhejVVYXBGMkZtM25hZEdzNVly?=
 =?utf-8?B?U3A0Z1l0TitDMVdDeldmVTErQWc3S0FkaUJLNmFYQmNDMHhnKzlnN0FSTzg1?=
 =?utf-8?B?SHJVL1V0VmlCaVc5S2UvYXh3NElFWnhYMkNHbGJwcEdBYmE1WUxUbGF0eTBK?=
 =?utf-8?B?aHE0MGp1U3hIYm1XR2RjQjd3SFhYMEJocHozaVdLbGdWdjF3azBnU3BZNE05?=
 =?utf-8?B?dGFGamZqcGdsOHpLemZiNlZwc0VQd0M3b2hWdUFNT3JEWENOL3dxTWJ1U2tj?=
 =?utf-8?B?WnEvNkN2UjIxbHJLOVkrcHc1cGQrditoN293ZUhodlZtR0psRndmWWJvaTIw?=
 =?utf-8?B?eVgxOXRoQmVMZnE3aldSeVZCUnMyL25KTVZZQ2VBZFdWZlQwMTJnNzlyRnRW?=
 =?utf-8?B?NHVkdUNTVTlXYUEzOEtLT1dFSWc4ODk1WjNqSjh0MHlhckFOb09UZ0IzalRZ?=
 =?utf-8?B?cnJCTFJXN1ZicGFRUUMrNUFVcjBuSWxLZDIvMDFNZks1aThmdTkxRTV6UXRj?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6954643D34254F4C90F3EB7E28DFD8AA@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2378aa3-b638-42e6-ee28-08dac068a5d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 02:34:51.7361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wiuUvQv+oJyqRd8hhLqP66l9Pr6Q9sBKQDjJflOqHLmLK+P94BL2N3czybDn1m4D8+8wcOrCS7F/WVr5hoHFhYbUgLM8z1HLxAONuIymCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3967
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMS82LCAxMDo1MCBQTSwgIkpvbmF0aGFuIENhbWVyb24iIDxqaWMyM0BrZXJuZWwu
b3JnPiB3cm90ZToNCg0KICAgIE9uIE1vbiwgMzEgT2N0IDIwMjIgMTk6MzI6MDcgKzA4MDANCiAg
ICBCaWxseSBUc2FpIDxiaWxseV90c2FpQGFzcGVlZHRlY2guY29tPiB3cm90ZToNCg0KICAgID4g
PiBUaGUgZHRzIHByb3BlcnR5ICJhc3BlZWQsdHJpbS1kYXRhLXZhbGlkIiBpcyB1c2VkIHRvIGRl
dGVybWluIHdoZXRoZXIgdG8NCiAgICA+ID4gcmVhZCB0aGUgT1RQIHJlZ2lzdGVyLiBJZiB0aGUg
aW1hZ2Ugd2l0aCB0aGUgYXNwZWVkLHRyaW0tZGF0YS12YWxpDQogICAgPiA+IGluc3RhbGwgdG8g
dGhlIGNoaXAgd2l0aG91dCB2YWxpZCB0cmltbWluZyBkYXRhIHRoZSBhZGMgY29udHJvbGxlciB3
aWxsDQogICAgPiA+IGJlY29tZSBjb25mdXNlZC4gVGhpcyBwYXRjaCB1c2UgdGhlIGRlZmF1bHQg
b3RwIHZhbHVlIDAgYXMgYSBjcml0ZXJpb24NCiAgICA+ID4gZm9yIGRldGVybWluaW5nIHdoZXRo
ZXIgdHJpbW1pbmcgZGF0YSBpcyB2YWxpZCBpbnN0ZWFkIG9mIHRoZSBkdHMNCiAgICA+ID4gcHJv
cGVydHkuIFRoZSBjaGlwIHdpdGggYWN0dWFsbHkgdHJpbW1pbmcgdmFsdWUgaXMgMCBzaG91bGQg
YmUgZmlsdGVyIG91dC4NCg0KICAgID4gSGkgQmlsbHksDQoNCiAgICA+IEknbSBub3Qgc3VyZSBJ
IGNvcnJlY3RseSBmb2xsb3cgdGhlIHBhdGNoIGRlc2NyaXB0aW9uLiAgV291bGQgdGhlIGZvbGxv
d2luZw0KICAgID4gYmUgYW4gYWNjdXJhdGUgZGVzY3JpcHRpb24/DQoNCiAgICA+IFRoZSBkdHMg
cHJvcGVydHkgImFzcGVlZCx0cmltLWRhdGEtdmFsaWQiIGlzIGN1cnJlbnRseSB1c2VkIHRvIGRl
dGVybWluZQ0KICAgID4gd2hldGhlciB0byByZWFkIHRyaW1taW5nIGRhdGEgZnJvbSB0aGUgT1RQ
IHJlZ2lzdGVyLiBJZiB0aGlzIGlzIHNldCBvbg0KICAgID4gYSBkZXZpY2Ugd2l0aG91dCB2YWxp
ZCB0cmltbWluZyBkYXRhIGluIHRoZSBPVFAgdGhlIEFEQyB3aWxsIG5vdCBmdW5jdGlvbg0KICAg
ID4gY29ycmVjdGx5LiBUaGlzIHBhdGNoIGRyb3BzIGhlIHVzZSBvZiB0aGlzIHByb3BlcnR5IGFu
ZCBpbnN0ZWFkIHVzZXMgdGhlDQogICAgPiBkZWZhdWx0ICh1bnByb2dyYW1tZWQpIE9UUCB2YWx1
ZSBvZiAwIHRvIGRldGVjdCB3aGVuIGEgZmFsbGJhY2sgdmFsdWUgb2YNCiAgICA+IDB4OCBzaG91
bGQgYmUgdXNlZCByYXRoZXIgdGhlbiB0aGUgdmFsdWUgcmVhZCBmcm9tIHRoZSBPVFAuDQpIaSBK
b25hdGhhbiwNCg0KWWVzLCBpdCdzIGNvcnJlY3QuDQoNCiAgICA+IEFsc28sIGlzIHRoaXMgYSBi
dWcgZml4IHdlIG5lZWQgdG8gYmFja3BvcnQ/ICBJZiBzbyBwbGVhc2UgcHJvdmlkZSBhIGZpeGVz
DQogICAgPiB0YWcuDQoNCkkgd2lsbCBwcm92aWRlIHRoZSBmaXhlcyB0YWcgaW4gbmV4dCB2ZXJz
aW9uIG9mIHBhdGNoLg0KDQpUaGFua3MNCg0KQmVzdCBSZWdhcmRzLA0KQmlsbHkgVHNhaQ0KDQo=
