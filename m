Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DD46A9EA0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjCCS0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjCCS0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:26:11 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C576E10F1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:26:10 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 323CO0xQ020720
        for <linux-kernel@vger.kernel.org>; Fri, 3 Mar 2023 10:26:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=KIQnU23YEoXs00q5Z/mdvrFUsDzQP5b/GxMwsCUEnko=;
 b=bSzJzWppiKvacZBEy5NaeTLtqX/RezXZ0AA3PNvxwpq1JX+U1ou8olwd7J7Lb3GNMDZB
 lvhrysU4+re2+5201+9Yfze5vjpDDpTCAS8w+mL4WWB1WtSoFwV6erIraXknQTiPK1dw
 rUKPKakObLo5vEGvOKpbK1BL003pYc4ZbBiGOUHswouUmygh3Fo24mvcnQ3Jh0k64A3P
 w0oE/vDGuAqvyqovar7IJ3Vub5D3Xp9O2PF4BqUK7XQL4+uISH8pTmWIFuijZdVCD10j
 uWIiBpAzb3a9uMH/pALl8NST3m9tu8cAOX9pTwrcY4qCQtwcPTGwv1b9azdJstDtHAla CQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by m0001303.ppops.net (PPS) with ESMTPS id 3p3gv5adbr-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 10:26:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co4wSZ4gwxjSRXR3NUYJAVfejjFwXPFnrabuUyjt9Q263yQVMMV4yjrHRFgEOj47kgWwD3kkV123tDKD4EvHrDs6R3m8Sw4UMbsP+s5UJ9VYk3mYLmGv8vMabBRN0ttx2n+pgG/+UKVj74oEY9H+CQDvVdaV7+z2jtsMCJYi/6TuyZop2IbCC5Mck0BlbNRGEdNSIKQUlw9JuIuz9LmC3FhYoqMP3XEDLLsK39D2omgzfhUk6rFZbyC89hWJwprIIQhO8mMi9qQkDlUjbHZ5J5SWjxvZ0s1CubHCH9g8tXvavLHX2pCCBnzFTojXPqPsf1qeZBJHtkPyWlylO/cY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIQnU23YEoXs00q5Z/mdvrFUsDzQP5b/GxMwsCUEnko=;
 b=gFGeYYkUB2ZuefQy25PwfIzM30djWcThLBoi1LAgNuoj4OY/aireHDZAW3D0H8GTXo62SZV1G6jfgbBtJbFV+iHm8CVCjcX1R6bCSgZ6wGqN3zpl0MZp+UY5pBehHS5fRZ2v6qgDgHhyj5D/dRNxD1Oqw8VCvZYKJvtumMc86MWZpVYRWoWeofDJIREIqEDWb5m3qh/wILxS3Sc4akm5RI6s/pdKBKWRGyqjayUMVbfms5VMqQ5ZMOTji2jX7fd0OvI+Xaf0vDwXUxUiDInmdyEIU6fG4cI4YyKPaOETsyzKKL5a50yyDq5aES3Qn7xAAmtT1S5PV/rnzj5RSx5w0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SA1PR15MB4419.namprd15.prod.outlook.com (2603:10b6:806:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 18:26:06 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::4376:73:fdf9:d34a]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::4376:73:fdf9:d34a%6]) with mapi id 15.20.6156.018; Fri, 3 Mar 2023
 18:26:06 +0000
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
x-ms-office365-filtering-correlation-id: 35b3cc03-e719-46eb-95ab-08db1c14c0ad
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Af6rZ/ySad2VlRMAjRHd/3hBmByWwTdT5MVpbChHZXe1j61PqUssMX/yl7YBS8TUrkjGauZWo9X0aUb1EnK5lodjIGkRodlAlkfBvJPTy/6FsFcYrNQDNERm8Mu6oZLTj2gwE8vEeEkelPb2TD8fbamj/XFuPxw0fBSxZW5AgjmMM304AQj0L4ws/7ean+cIIRSYBGndlKhmtOUORUh8yti+cIvSFCRLjiTZ6jHNx8LiJnxI7cRfKc9lSgzzKhdUVoZoWcCj5o38JyT4/WTfnR4jXDf6zXwRIheN0tt5tCSgEK/r5QMWo/4Pf2YPwStmrCEzgZTyUejIPv9PHaqIz1+Fg++qOCYiHmiU9gbUbevlM0v9BpM3jKnX2mdtOKMVrt7bXeASJzbuamsGDc36y8HL6zDB0lBEQhOM73+b68Hdlbn7K7SyqKu7eCynhVaGRrRpsc/NJH07jbb+05xiZ4aDh0gwEJgmkMm9M7jhxoEiMQIPYjAh4BEXT6o/rko8oFUlCL5An0cEcW9/v/r6Fhjr4NrnN0pW0ROEmUlX9nrYHBy9oG8BdjF/JyorqaN4i8Gadvihe9sXQnLADQPPAhFa0r8z9LdrRo13/p8QxVkiVIdP9/jpIMcHC8xL45/B1/hj4YfQwOSTIRzYwt7kEds1+kZB5rRCqzpdhlAAV5UKgSShQ+MRO+MKY1N3InPFYgBovXiglRiA6LWl9LtSckzYbJIO3XXJeibnHihbG/0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199018)(71200400001)(186003)(6486002)(478600001)(54906003)(64756008)(66446008)(316002)(8676002)(4326008)(66946007)(6916009)(66556008)(66476007)(76116006)(53546011)(6512007)(2616005)(83380400001)(6506007)(8936002)(5660300002)(122000001)(38100700002)(2906002)(41300700001)(86362001)(38070700005)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aitrNW9ScUN4MjBsZlpKelBhNm5IVGVhcmVHSTFkdUJHUWV2Y3NTNENuMVhq?=
 =?utf-8?B?NXdpNktyK25qakdvUEV0TGRFdnZZZjQzSWYvYnViVFE3aUpMb1B6ZGxTZjgx?=
 =?utf-8?B?UEViZWtzQzIzcjdwR3NRODVxSjhTdUVQL0VmUm9jZHhzSDZzK0g0bExIVEht?=
 =?utf-8?B?VXhEY05UdFJjZGJBc0dKN0NxZmE3YUpIdHhDN1V4SHZ6bFBOM0xleWRQeDJl?=
 =?utf-8?B?VDd3c3Z5MEhjbXpseGk1dXVzeVZuRXI3NTFpaktiMXNCbFc4TTVidDdWOFlo?=
 =?utf-8?B?UUlPWkFZSnk0NGx6eFRSTkM3ZWpqdU5HUGVFODRyK2lpVFB6QU9pZFNFRmRs?=
 =?utf-8?B?YVNjY0N2Skh5dTJFazJkSDlJTFFlUlFzTUNmMWVPNHdJYUhvWDBrZjM1V21n?=
 =?utf-8?B?SERxSVR3YitvSHhaTzJqYmE4dXZ0SVZ2QUVnVzlWZmtUMkZhc0E4Y1lwKzV1?=
 =?utf-8?B?NzVMUjVzM1JaZ2NpT2hXeTJCYlA4aWFiTzQycXJ5NWJDcEhsc21kREVkMzZq?=
 =?utf-8?B?b3BqeEh3Qkw2Q2kxdWg1aGpxSE15NVRUcUIxQXB0VkRDbHpMUndEdWlSTTdX?=
 =?utf-8?B?ajZBYVBodXl3RWlDaWhQc1phTjl0UTk0NEJhanJzYnE5T1JrN3RlT0Y0b05Q?=
 =?utf-8?B?dlB2WVJZaGVHeEgvTTNmWFVLWnFMY0RqS0JyYXl2RDZPc3UvdXRvSllFNVNR?=
 =?utf-8?B?RU95Vk0rTGNnMjhEYTJOVHBpNDRMMTVHenVpY29uenpQQ2xodGFMOTBua1RY?=
 =?utf-8?B?OWo1TzlzdUFhOUtEOGpTN0VvS3phMDdnSkMrTk95NHgzS3ZqQm1uOEprUFVj?=
 =?utf-8?B?M1JqZCtlTDV5aUFKZW1JbWY4U3N3eFA2cWFyQndYSnpCUVNSeldIUGNSKzhU?=
 =?utf-8?B?RUt5ZTBLU0ZvOGUvSzBQeVFENWRjYTdiWjVuM3NjV3JYMTRUQ0s1THQ1cURk?=
 =?utf-8?B?bHNNRWtVb1VtbDNrWFM0K3BlSjB4ZzRhRlVtUFl1dHRqTW9RZFdxRnEvT2Nv?=
 =?utf-8?B?RDVMSDZXQWRzaUhPR25oUUQ1R3JMUlh0eHltbEVEQUlyVUVleHJvQzRlZVlC?=
 =?utf-8?B?MzhxMThvdjhndVVNR0kwRUtINUxiVDBORWU4ZHVGb05QQXpWZWhnY2xXQ05J?=
 =?utf-8?B?VFpneWRZaTlSQXBCeWthVGNzSUs4SHlsOGdVMUtIWFJEZG40a2ZSTjR5djRB?=
 =?utf-8?B?SXp0ZC9od0IvdHJQZWhidk5GSlNQM1FsbzVLcUN5RXhmbGYyYUtENXRWMWMz?=
 =?utf-8?B?bjRSL2ZBOS9ldW9Dc0hrWWJIYUZrWXBHekx6eE8zQUNTaGxwdDAzaitMZTIz?=
 =?utf-8?B?bHBrNGRab0lkL3N0U0EyZjI2eGhlYnpmRlpPeGVwQ3VPZDk3VlBkMloxeWhj?=
 =?utf-8?B?VUdBL3FBT1NjOVZUMVVIek9KSXY5aGZTQVdYNEFlYzBOSUpHT1JOMzcxaDVJ?=
 =?utf-8?B?Y2ptR3FUNkNNKzk1UXNEKys3TmxqT05EbE1aUmgvRnBwSkFzTlU0N1hoVkEy?=
 =?utf-8?B?NHBvcmpEQ3NycFpOR3VObnZwOE5VTmdKbUtWSVFYRjZmYzZRNWNrMXhlUFFP?=
 =?utf-8?B?cjZNeldqNzlSZlFMeEhXTmdjdHlQMno3ekY5UDNaeFFqd01oMVZPQTNrNE8z?=
 =?utf-8?B?aEpkUzgwbUljNXNUcXIrT2JuaUozWGdNdlpNTU9TYzF5YTRXR0NDdXpoQXFO?=
 =?utf-8?B?dXkwempDQXIvV3R1Y0I0cTAvbEM4VlJyblpSNWxDektLc2VjS1JOcGFnZlZK?=
 =?utf-8?B?S1JXR1FzQ2RManJwTW8rU2p3VytwZ2VEOW5ZT2s0RElSbU9DV2FoRDhFTStZ?=
 =?utf-8?B?Uyt0ZnJINXhYZmx2WXNrSU5qaFFla2xqUEZiOWFkN2xOcWhIWnYxT0NPN1VO?=
 =?utf-8?B?OXR4MG5LOE9vZ0NUc3U3aTNtdHBTTkR5Mi9FdmxXbWoyOUxZMmtvU0NwUkVm?=
 =?utf-8?B?Vm1IMTFicFpnZUhtamp0ekxPeUM2eFBuYnV1SnB5VXlxVzJnV1dtZnFJMEdU?=
 =?utf-8?B?aVZodzhURFQyek9xNHRPWHlCY0J1cWNiY0RCbmRaNzJrajNIZ2RQTUxVbElj?=
 =?utf-8?B?OEwxbVRXWjVHS3RldGxEUVQ4YzdQQStGMWNoaEVZZWFPQ3pYVU00b0VDYUFs?=
 =?utf-8?B?YXRNeS9lWXZ0cWFuRWRJNVdkNkh4OXBVNWo4aHJsbWcxZklLQlZLS29tbk1X?=
 =?utf-8?Q?80NLYGIPQ8zavwfE7GWWYOM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F94005FF95C448459F55BDD3C77E4D82@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b3cc03-e719-46eb-95ab-08db1c14c0ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 18:26:05.3395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5mfchLZx0xwdVBrIT8R03UmpNLp4er8K1aXr5fGCLkNno6IPeZmI/bhNi1uz5DAYbXlOJK7ReL5MoBxJa85gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4419
X-Proofpoint-GUID: JkwZuY693J3PFJyge9kbP8J-u5t1YPe-
X-Proofpoint-ORIG-GUID: JkwZuY693J3PFJyge9kbP8J-u5t1YPe-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
