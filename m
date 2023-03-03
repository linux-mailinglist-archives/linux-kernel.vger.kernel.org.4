Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA146A9E9F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjCCS0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjCCS0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:26:11 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845F710D0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:26:09 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 323CO0xO020720
        for <linux-kernel@vger.kernel.org>; Fri, 3 Mar 2023 10:26:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=KIQnU23YEoXs00q5Z/mdvrFUsDzQP5b/GxMwsCUEnko=;
 b=UqLyKHRi1u4AZ1RqgBkYO/xzDrr6kuot73LtbxLhbL5UAkniS9V7Dq3Cnvuxddw8byhg
 PrGq/J/q5Ql742RvlLqb4Q5QlyKxAAcpnozm6qPJ8vPF/ld7epTO0oUCiXM1ix9Q/kxz
 ircHYU5Kj3ADRQ1J+C7EFUeRtOM76fIEtafVGsDpv/EYGiLR5S2cySW/Wu+NPjElRgNk
 QcusFliaHRrmuuIUT0aU1YHTq8ZsxM6rY83/znc17ped7HQPW9STjJDIQiybvybkmTdS
 wjiiVuhu39lHCGUlJj9rwL4Mm/R0Lhy9Zy+U1YsSdHiWneG59n4wAJE+kr/qEvg9EoPx Tw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by m0001303.ppops.net (PPS) with ESMTPS id 3p3gv5adbr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 10:26:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQuEZw6RjO3SHhFBL/zL8k7dpPgLJ/olKC5pFouMvb2IPG5UWQANZZxn260zErhPG68v5b10KKqtTVy8+STk+PN22V6TbaoI3T6GjcyVLGEQaUHhJW+MXU032jpm6GpYrWn0Naw6W+VTMgvpruOPU+2nQ/qXqkr3E7IUySCdMvUBf2JvRwggKEZuUsj1eXATld58hIiDa2FT+5BBwzMJZLuIMJ2dDPSSOnchBU1AP3o91bxeBLw5YcXPB4BgcDuhErDpUi/bslvPV+vW8I8Q14e4q3IbM/ECcZcQTpZBEKNV2P1ovccdh+MpMkkf5AL2ECNQvz/qhIJhEtzq64WbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIQnU23YEoXs00q5Z/mdvrFUsDzQP5b/GxMwsCUEnko=;
 b=DqO5/d0yRnULBWOGTp9NQp7fs+EUTImqxR5YOWoCr1ofgc2PHD5d+0UwepnWDbTrmhRLjDlZbBHRG9jw94o7mcddfc//GuIl81RekTYzHGO7rLzH50rPCUkCM5/pfKb3r8oqYRw/wQaplf0Z6+c9RyojWb5uERhogiTMPgqYg4SzzoILL0vRnU49vAzRO3Mbe050UPly4mkxL72tvTOgwM2T9gM7wmR0hyazDB2z2vD1bezFCRV3Npvizu8c7y3T+JuFZqTyg3pZa3iH2XcOH/3NkjX4Ns6x3s1G7MOHx+AnuLiuXj9D3DjRio7CqFMIUTZaTg+xHkfAgBYZvIpNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SA1PR15MB4419.namprd15.prod.outlook.com (2603:10b6:806:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 18:26:05 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::4376:73:fdf9:d34a]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::4376:73:fdf9:d34a%6]) with mapi id 15.20.6156.018; Fri, 3 Mar 2023
 18:26:05 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Nick Terrell <terrelln@meta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>
Subject: Re: [GIT PULL] zstd changes for v6.3-rc1
Thread-Topic: [GIT PULL] zstd changes for v6.3-rc1
Thread-Index: AQHZTZizamXiGRhPv0GWaVIL9zubi67pT/wAgAAHCYCAAAF7gIAAAUYAgAADnoCAAAJtAA==
Date:   Fri, 3 Mar 2023 18:26:05 +0000
Message-ID: <F9991334-A4D4-4820-ACF3-7FFD17CFFA9F@meta.com>
References: <C8C4DFDA-998F-48AD-93C9-DE16F8080A02@meta.com>
 <CAHk-=wghhViNZCj4ibSr42HjVGdHro_DWW7wCOQ61p2v59cciw@mail.gmail.com>
 <4BA6A759-F69C-406E-9D29-EDCC9B48F798@meta.com>
 <CAHk-=wjCNtTJ3DrG1266xXPZF=qH=GvpWApkYStJ9knskRnU3w@mail.gmail.com>
 <2B90FACE-74EB-47C8-91FD-62E3F77B95EC@meta.com>
 <CAHk-=wj9xdS8hR1NWC8ZuvR2M35kHe9Tz5ERr5m9B=BUaPNv0Q@mail.gmail.com>
In-Reply-To: <CAHk-=wj9xdS8hR1NWC8ZuvR2M35kHe9Tz5ERr5m9B=BUaPNv0Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|SA1PR15MB4419:EE_
x-ms-office365-filtering-correlation-id: f2e20174-0f10-4e25-eb9f-08db1c14c03f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LWWpKJi3L/hu5usXUwfnP/XtP7xfaoa78BJMOnBo20k2fVbr4Yvnb9X3TSUsfpxPwrf20ixOb6Vr8uFXWijtwcO8YIw3OYYlOGjraPMmX0CQzj8qfY1ocvZPWyyXltfYUwvYmS757/Gxb9gdMbkcEP8oanibUOZFceSoT1HC1Fe1aduBhsaPdjjyGZ7xGkKxe8sG7I9RymJBYU1x7UZrOsI2xChfiC23MbiUqHtrQNswWLCrhURhECPFpIdJ/I58c2cx295DWbMOl4KWZByHK05eWbgCVNlJAWWT5VvayjhDRheBDRxdzekCk2yfe5UGADctDc/9sZdgjeblfR/ffsKe76WwCRvp5nQ6sbyXe+Pwxt8qGWxG842iGHvAuowJmFZQfb0y+yjIPouevG5jZBJLAc89P/w1Gmlr2ExXZ+y8ACgKYTW0LRBp3oSF4IkTMkjhbNJCl3I2pB51PaoEijBxm/wbmIIcoVe+mpeVgiAUrcfxKkV26kDTjA4iY9la68FIno/6ETuNgDR52ueJGVCTLmk8RJLz3xzWQL1340fiDD1UUTiRGXCnUqp4erqf5BPcBbzWh70tdQPgjZbFhqYs/x71gfDwiO8gdsOOvz4Pz1GjJ9s4bZ9Iwo3fDV6A1N/gxUskWQjvxmxa4bmMR8G6pSaQx1w7Sa5mOuUpjIHQsx26zSU8JPhPOQQYStsftmMgCzZuAE3hrU/5JzQr70ZeiGk+OJSybl24EyFglBs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199018)(71200400001)(186003)(6486002)(478600001)(54906003)(64756008)(66446008)(316002)(8676002)(4326008)(66946007)(6916009)(66556008)(66476007)(76116006)(53546011)(6512007)(2616005)(83380400001)(6506007)(8936002)(5660300002)(122000001)(38100700002)(2906002)(41300700001)(86362001)(38070700005)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE83ZVlWM0FNVXBvRHVkUk51QXQ4b3I2VmhXTUZLSEJPWlpIWkN3VCtqeEhs?=
 =?utf-8?B?Wm0ybWZ0aHdsTDBicFZ0aHg4YjRWZzZjejNiRFhQV1RuNUpUakFuMGR3RmRQ?=
 =?utf-8?B?aTF1MGJMVVZnWUNhU0E0bTJPWVlvMVBzRElNR0drQi8vWVNEaXNsWDJyblN2?=
 =?utf-8?B?Sk9uTnN3ZHF4YXFoRUV2WGZobVJWaVlWQ25IeGpOUUVHcFV6S2xUdHJlRnlq?=
 =?utf-8?B?eU8zTS9jcEE1ajFYZWh5U1A4aW04UEp2VUJOK3dJWEdtR2F4SkxQS3g0MFg1?=
 =?utf-8?B?N1BzVmZJM1dFSUc2ZisrMTJ6RXpwVUJ0NTNzeVp4aG9XSmlKOTBabEMvckM3?=
 =?utf-8?B?Y3k3cjJCTXpVdTZ0ZlpQU25obTJsNXFEVEpnMjNpVDdaMjRTRFkxV095NE8r?=
 =?utf-8?B?a3FDT2lnNXBDbk13d2p4NTBLMnBJdndzamliaGI2V1Q0YldSUUZhMHVvTThr?=
 =?utf-8?B?aHRkNjE1L2VXNDRsZ2dEN0pGYmdZMVRQdW9DZDBMdTYwV3JpcUFneTJpQmV4?=
 =?utf-8?B?RVgzV1BuanVMQUNWN3hXODRDU09RaVBOTE14UnlWSmpaSk1tTzFnNFRWRURW?=
 =?utf-8?B?alJSODc2dnpaQ3d1KzhCWjVQTXZmZzdUNWM2QzFDZ0srQm1HVnQ0bnlPN0RX?=
 =?utf-8?B?ZWd5amZHcGNZdXhzSEtpR0JYdDh6cVB0akdFdjRYSWxYOWlqNkJLRHVkRFBW?=
 =?utf-8?B?OVR4aEhKY0V0NXBqUWpnekNMeHBudGVkUTV3RUdzNzNiQjRkRmhKRGR4T2E0?=
 =?utf-8?B?WjVvVWUwRGNNUjM2T3RpK0FRc0czdlI2SGZaTUw2R29kSFptaEpDSVVrUWY5?=
 =?utf-8?B?WGZOMkVGdzBXYjcwc3Noblhad0ZqUEluQWlkMlhjdVFnVExIeUV2UTBoZk45?=
 =?utf-8?B?WkFlaEkzOTE2SEc1M0hRYzJsemI1d3lvZWRhRW9JUkNlRFc2YXFEaXhuT2Rl?=
 =?utf-8?B?T1k3bDIvSlZVVTZrS3lxRTlDV3JJdFN2a0RJbGNPYVZja3QwQzQ1VE9ZbGFn?=
 =?utf-8?B?TDZDc3JDWU1ENmN4dmFFTzkvZDZWQ3FoSkxvQzJ6ZTFNTUs4Zy9VRVFQdm00?=
 =?utf-8?B?UEJGQmZ4WHJHQS9qenBJcGxYN1Q4eno1M1VSQVVnaDVRWW0waC9USDF5NEJF?=
 =?utf-8?B?VFVVVDMwYVFnRWt6Zzd2L0tZL1BkVFVHN1FRWjV1VUNxamszeUJ4MjhEc1F3?=
 =?utf-8?B?UHdXUEZqZUVhRkVQTzBaQXdRNlgrWjB0dytGK0c4c24wZG9Ma1BodEZTR09Z?=
 =?utf-8?B?dnA0YkZoWjI3dGRRRzdsYlBXSWpRK3VST1FOY1l2TjBtb2gxQWVYRVAvRjJl?=
 =?utf-8?B?NXEvRC9RSHlJZklMa1NpMWVWcUNwMlVnQ1JoM3VrRDdRblI3UHFERndsRDdm?=
 =?utf-8?B?T3BUcEFxUDlNU1JtNmJvUGVWYkxXcjZoWWFrZGRra2h1MDhqTHlmdlJUMFdi?=
 =?utf-8?B?Zm5BTHJ0b1NCcUVIdDFudUdMeVRQcjlBZjNSYUg5SnBjbmRKWXdlcjBZRUJp?=
 =?utf-8?B?K0x2T1B1NnNia29IY3NYQTNiQk1YMXRBSnV2Qmc5UnZhcUcvcUFldGF1QXVz?=
 =?utf-8?B?Q2lNWXdsSHpyWklOYWJmbzN3Q20remVFM0VvS3lhcGYxaGEvaWZqZlhQNCtw?=
 =?utf-8?B?MkRwNUZOZkxHUlN5K21CU1AyWjl0dmIvdjBWSEY4T2Vka3F0M1hYcEJNenk1?=
 =?utf-8?B?dytDalRQdys0REQ0dkozN0lSU1BzcVNjYVVJMmUxYlk3bm4ybGVZeXF2cEhS?=
 =?utf-8?B?STFJdThwazZxdFRvUW5LdUxzTE96WVYzUC9STVA1VXZYNkNXRFg0ZHFEZDU5?=
 =?utf-8?B?bkRTQ1krWndjYXJCbU45ZnJHZnNJWGNNQU5LSWwzN3ZCdGpsN0c0UjdYNWs4?=
 =?utf-8?B?dkVDb0lYVHdlTHlYa1k3NTdPVXdRWm4wMnQrY1hrQXFaMk5YNkVRbHhiODB5?=
 =?utf-8?B?SkR4VjltMS90TmlGZDIzb1NPWjJNUlJsejZOUjJ6UXVGc01ncTE0aVNjMW9w?=
 =?utf-8?B?eFNwdEZRNzdDTU5UQ2NxbGtvaWZJdU1ub3hJWnNsb1B0bmJGVFNWT2FzS0pC?=
 =?utf-8?B?MDZ3eGh0VDhaZXMwdmlQN2ZHVnEzOG9zcTZCcmpFVjlCU1pxZ21BNnJUb2FV?=
 =?utf-8?B?NjBMb1ZFaDlBYlVJTjd5N2lkbDVjNXozbG1qSEQ2YnIzMUpKQkphN2M0MUc4?=
 =?utf-8?Q?73bCokyDvu7pblxoIKwPat0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35BC85FECD5C924DBDCE8A2E094CBFC3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e20174-0f10-4e25-eb9f-08db1c14c03f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 18:26:05.3239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVWU5ocTbUvhWL2OPtQJJxCFTWBt0TaYD9ve45LS60tgxAQJr8OmCZYg8NZpK6FoaqFq6GYvbYsMuLcvLJSZfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4419
X-Proofpoint-GUID: qzGBox78vKEFijFfaGq6y8wsZ5VWQvc1
X-Proofpoint-ORIG-GUID: qzGBox78vKEFijFfaGq6y8wsZ5VWQvc1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE1hciAzLCAyMDIzLCBhdCAxMDoxNiBBTSwgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgTWFyIDMsIDIwMjMg
YXQgMTA6MDPigK9BTSBOaWNrIFRlcnJlbGwgPHRlcnJlbGxuQG1ldGEuY29tPiB3cm90ZToNCj4+
IA0KPj4gV2hhdCBkbyB5b3UgcHJlZmVyIEkgZG8gd2l0aCBteSBjdXJyZW50IHRyZWU/IEkgZ3Vl
c3MgSSBjYW4gZWl0aGVyOg0KPj4gLSBMZWF2ZSB0aGUgbWVyZ2VzIGluIGFuZCBrZWVwIGEgc3Rh
YmxlIHRyZWUNCj4+IC0gRml4IHVwIG15IHRyZWUgYW5kIGNsZWFuIHVwIHRoZSBtZXJnZXMsIGJ1
dCBicmVhayB0aGUgc3RhYmxlIHRyZWUNCj4gDQo+IEluIHRoaXMgY2FzZSwgc2luY2UgSSdtIG5v
dCB0YWtpbmcgaXQgZHVyaW5nIHRoZSBtZXJnZSB3aW5kb3cgYW55d2F5LA0KPiBqdXN0IHJlc2V0
IGFuZCByZWJhc2UgYW5kIGJhc2ljYWxseSBzdGFydCBhIG5ldyBmaXhlcyBicmFuY2ggdGhhdCBj
YW4NCj4gZ2V0IHB1bGxlZCBuZXh0IHdlZWsgYWZ0ZXIgaXQncyBiZWVuIGluIHRoYXQgZm9ybSBp
biBsaW51eC1uZXh0Lg0KDQpJIHdpbGwgZ28gYWhlYWQgYW5kIGRvIHRoYXQuDQoNCj4gQWxsIG9m
IHRoZSBhY3R1YWwgcmVhbCBjb21taXRzIChpZSB0aGUgbm9uLW1lcmdlIG9uZXMpIHNlZW0gdG8g
YmUNCj4gZml4ZXMsIHNvIGxldCdzIGp1c3QgdHJlYXQgdGhlbSBhcyBzdWNoLg0KPiANCj4gQW5k
IGZvciBzYW5pdHkgcmVhc29ucywgZG9uJ3Qgc3RhcnQgdGhlIGJyYW5jaCBhdCBhICJyYW5kb20g
Y29tbWl0IG9mDQo+IHRoZSBkYXkiLiBQYXJ0aWN1bGFybHkgbm90IGR1cmluZyB0aGUgbWVyZ2Ug
d2luZG93LiBZb3Ugd2FudCB0aGUNCj4gc3RhcnRpbmcgcG9pbnQgdG8gYmUgc29tZXRoaW5nIHRo
YXQgZG9lc24ndCBoYXZlIHJhbmRvbSBpc3N1ZXMgdGhhdCB3ZQ0KPiBtYXkgbm90IGV2ZW4ga25v
dyBhYm91dCB5ZXQgLSBzaW1wbHkgYmVjYXVzZSB5b3Ugd2FudCAqeW91ciogYnJhbmNoIHRvDQo+
IGJlIGFzIHN0YWJsZSBhcyBwb3NzaWJsZSwgYW5kIHlvdSBzaG91bGQgYWltIHRvIGhhdmUgdG8g
d29ycnkgYWJvdXQNCj4gaXNzdWVzIHdpdGggenN0ZCwgbm90IHNvbWUgcmFuZG9tICJvb3BzLCB0
aGF0IHBhcnRpY3VsYXIgYmFzZSBoYWQgYQ0KPiByYW5kb20gYnVnIGJlY2F1c2Ugb2Ygc29tZSBt
ZXJnZSB3aW5kb3cgdGhpbmcgdGhhdCB3YXNuJ3QgZm91bmQgdW50aWwNCj4gLXJjMyIuDQo+IA0K
PiBTbyBzdGFydCB0aGUgZml4ZXMgYnJhbmNoIGF0IGEgcmVhc29uYWJsZSBzdGFibGVpc2ggcG9p
bnQgKGluIHRoaXMNCj4gY2FzZSBwcmVzdW1hYmx5IGp1c3QgNi4yKS4NCj4gDQo+IE9mIGNvdXJz
ZSwgdGhlIHNhbWUgdGhpbmcgaXMgdHJ1ZSBvZiBuZXcgZGV2ZWxvcG1lbnQgYnJhbmNoZXMgdG9v
LCBub3QNCj4ganVzdCBmaXhlcyBicmFuY2hlcy4NCj4gDQo+IEl0J3MgYSBiYWQgaWRlYSB0byBi
dWlsZCBhIGhvdXNlIG9uIHF1aWNrLXNhbmQsIGFuZCBpdCdzIGEgYmFkIGlkZWEgdG8NCj4gc3Rh
cnQgbmV3IGRldmVsb3BtZW50IG9uIHNvbWUgdW5zdGFibGUgc291cmNlIGJhc2UuDQo+IA0KPiAo
T25lIHNwZWNpYWwgY2FzZSBvZiAic3RhcnQgZGV2ZWxvcG1lbnQgYXQgYSBzdGFibGUgcG9pbnQi
IGlzIHRvDQo+IHNpbXBseSBjb250aW51ZSBvZmYgc29tZSBvbGQgcG9pbnQgb2YgeW91ciBwcmV2
aW91cyBkZXZlbG9wbWVudC4gVGhlbg0KPiBpdCdzIHN0YWJsZSBub3QgYmVjYXVzZSBpdCB3YXMg
c29tZSBrbm93biByZWxlYXNlLCBidXQgc2ltcGx5IGJlY2F1c2UNCj4gaXQncyB3aGF0IHlvdSB1
c2VkIHByZXZpb3VzbHkgYW5kIGhhZCBubyBpc3N1ZXMgd2l0aCkuDQo+IA0KPiBUaGF0IHdob2xl
ICJwaWNrIGEgc3RhYmxlIHBvaW50IiB0aGluZyBpcyB3b3J0aCBub3RpbmcgYWxzbyBmb3IgdGhl
DQo+IGNhc2Ugd2hlbiB5b3UgX2RvXyBkZWNpZGUgdGhhdCB5ZXMsIHlvdSBkbyBuZWVkIHRvIHJl
YmFzZSBvcg0KPiBiYWNrLW1lcmdlLCBhbmQgeW91IGhhdmUgYSBnb29kIHJlYXNvbiB0byBkbyBz
by4gRG9uJ3QgbWVyZ2UgYSByYW5kb20NCj4gY29tbWl0IG9mIHRoZSBkYXkuIE1lcmdlIGEgX3Nw
ZWNpZmljXyBjb21taXQgdGhhdCB5b3UgY2FuIGV4cGxhaW4gd2h5DQo+IHlvdSBwaWNrZWQgX3Ro
YXRfIHBvaW50IHRvIG1lcmdlLg0KPiANCj4gT2YgY291cnNlLCB0aGluZ3MgbGlrZSB0YWdnZWQg
cmVsZWFzZXMgYXJlbid0IG5lY2Vzc2FyaWx5IHN0YWJsZSBieQ0KPiBkZWZpbml0aW9uIC0gd2Ug
ZmluZCB0aGluZ3MgdG8gZml4IGFmdGVyIHJlbGVhc2UgdG9vLiBCdXQgYXQgbGVhc3QNCj4gdGhl
eSBhcmUgaG9wZWZ1bGx5ICJ3ZSBhdCBsZWFzdCB0cmllZCB0byBtYWtlIHN1cmUgaXQgd2Fzbid0
IGEgYmFkDQo+IHBvaW50Ii4NCg0KVGhhbmtzIGZvciB0aGUgdGltZSB5b3XigJl2ZSB0YWtlbiBo
ZWxwaW5nIG1lLiBJIHdpbGwgYWxzbyB0YWtlIHNvbWUNCm1vcmUgdGltZSB0byBiZXR0ZXIgZmFt
aWxpYXJpemUgbXlzZWxmIHdpdGggdGhlIG1haW50YWluZXIgd29ya2Zsb3csIHNvIEkNCmNhbiBh
dm9pZCBvdGhlciBtaXN0YWtlcyB0aGF0IEkgZG9u4oCZdCBrbm93IEnigJltIG1ha2luZy4NCg0K
QmVzdCwNCk5pY2sgVGVycmVsbA0KDQo+ICAgICAgICAgICAgICBMaW51cw0KDQo=
