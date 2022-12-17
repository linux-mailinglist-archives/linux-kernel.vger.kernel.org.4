Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD764F8A2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 11:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiLQKKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 05:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiLQKK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 05:10:27 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2077.outbound.protection.outlook.com [40.107.12.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB23219022;
        Sat, 17 Dec 2022 02:10:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEbKH8towM5R1opIkw26Nc69luOjx9bv3+rPMyOfkL253tCz6//RLXPKYNMMctPGs4unV88BzcywLy46Uc0EoCPPCuY8jUz5soEeJ42sWRmUeaj5pNVXkrooLy1oQXKfpVoID7VG0BWmsqmJQ7svjnDFPElhP4k8tuy0qO8SCfv8JSBXF/v11eJ7fnqxt6iRYvuECRlxiwKZ5HM1vrg2DbaWy0evpNJ1eq51MIZEmFazSNbct+lNXljMvWX7DqX7fiJk+CRVoX7AbIV5jFYsIgLA23PL/QNLsNU7TO7OnkloXrENnlqa0/NnxJYYlMtx+tN5J7NcI6KSFxYBlxGokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmAVzm2sEP+F4niK/4UI2KTxz2Bhhgj5/FOzVHupFDk=;
 b=T5UXILskNOjvHmILe92PrEF+VpX3e9lyh2S8WqVYRh5MgZhonfiXqeUuK595tKoGCoadFv/T6IjNfY+80Hi7SwbrQBnXvAqjxcI3fOi6sV4EM+i4VjT0D/Do+xUVQ05S7tEB/zv2fRuCr+Mqc5PcUnE7TSh/O6cxJnIRO1EVp5tLK4ikElqmytEBCcDsuxPfCEaWiDCW8cQcHmofyDveCPJT3uApLynfiR8F0St40CpST7G4Z4vsyhHDwIbjoMGObwR0uBzNjqQ808I0O4cYt58d/NRqwmo0/0rfSMFNnlZzJQoZcWP4704uc9STUTdqiq18FU8aOpAEwHpsOskwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmAVzm2sEP+F4niK/4UI2KTxz2Bhhgj5/FOzVHupFDk=;
 b=eEYr1CLPTz4vc5L9a+V+b+jsIRIh4RSSF9TQabgBvchNjkStKyw0nvp3Wd4SKggD2ZaoivVujNIz+iljImyeyouA+sXvIswfoQtiBElBvt08pyC+8IQtncFRCHhw33JGzkeUyS8ve5S6yjdAUMSVThh0YKOVneSDviXHtBQEY8keQCzguGQF9SmSucO+3gp8yDmhq8/B0wp7ArTWFvHc48veKIFmjmx/ceq3K5gQ1C/BmpHXY7TxLHhm9peHXUsN6qnNq8K6aBVukznSzbz/13JmrYQWfqev+8SuMdJbmxeFnyMDAZbotEDPNutzHzEmFbsjAmltELi0AL2ZwieW6A==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1598.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 10:10:24 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8e8b:856e:12eb:ff9d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8e8b:856e:12eb:ff9d%9]) with mapi id 15.20.5924.016; Sat, 17 Dec 2022
 10:10:24 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Allen Webb <allenwebb@google.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 3/5] modpost: Add -b option for emitting built-in
 aliases
Thread-Topic: [PATCH v7 3/5] modpost: Add -b option for emitting built-in
 aliases
Thread-Index: AQHZEZw7JZwfGD6AvUa8VRBmQXkUiq5x3FUA
Date:   Sat, 17 Dec 2022 10:10:24 +0000
Message-ID: <690d86fd-bacb-bdae-2d1f-f9fed4cc6537@csgroup.eu>
References: <Y5IA2NYE5IaAzNby@kroah.com>
 <20221216221703.294683-1-allenwebb@google.com>
 <20221216221703.294683-4-allenwebb@google.com>
In-Reply-To: <20221216221703.294683-4-allenwebb@google.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB1598:EE_
x-ms-office365-filtering-correlation-id: 6fe7e0b9-2355-440c-6686-08dae016e9cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gY2IwJXi7OSZQJcwqE9euwzxvxMBM8LC14ZMdLqV4pmWdcZACKNmnzaH4ZmcK9O//81y5c+m5bmqgLhEiSL8YYPAP7YRtycE0nBqmP3eCiB5qRP7HeaoTCSaQpZjdFYfC4ClkPvU6ATJNEshBDWrek+p/yjfQA0Y/1hbcS+CdM5UQAbDKPCweK5b9JwMuzW/wn6puITWRc/C2UDaiIZTo9FD7x/BJLWgOtREJWY3QmaiZ2lL5+MOqim6Uh/fHsd35982wHIBVxmrOdVGackTA9StuETGBvjiFNuyOeBaPoFZBY40kHA5LPQhOv3rlX6zDgFrd1JbdKEUk3x+4ci917ChEp7BuEUMTSbGu32/DgAtxCscxHR1t25K2M/99I9+Kb91E4uSa6TsOuiXvWBjqtL68xi+hpJv+vQqXBADQeNMgogV7mnsXWDQVl60KnptzzHTtcCos8gBzDLdJrT1bgf1ql2Tp8YLdtZZCm0igvNEnNre84Jh0ChA/8oVN6aNbFOrO8a78RCRqA3Yzqq56+1/ZsidTcC44chT6dEMhiB32uneCDZ25T95BGOr9hVr/r+w0+shQB04rIJL9F/g93ibqZykGeFyHg85bKHWR3t/vnzkXw7T0px+aB4zZsO48/YZXo+RLY+yUzCy8ESIuUzh25Za6z9xRHfhBjeN+SNSSRCvH9cpHi1fhYdrtGCltDEoifknE3G6XUOUSGP0qiAsFofzLzkKQ8IIcd5gdDgifupTPPCIqjnttAy200uJLz17YvhNQ4x+SccVcK3SZRjsfrUPiAsBVxWTu5FNUF8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(39850400004)(396003)(451199015)(71200400001)(6506007)(2906002)(966005)(478600001)(6486002)(31686004)(6512007)(26005)(186003)(316002)(36756003)(54906003)(110136005)(66946007)(66446008)(2616005)(76116006)(66556008)(66476007)(64756008)(4326008)(8676002)(91956017)(8936002)(41300700001)(5660300002)(122000001)(83380400001)(44832011)(38100700002)(86362001)(38070700005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnJKTDhOTW5jS3RZVm8yMko5c2t2Tm10MUVCYUEvSG9LRHFGeXd6UUZzZnlT?=
 =?utf-8?B?NkdIZ0pYei85WVROWkJOSFpxTk1wamV4cXcwOUxHS2lnUm1GYWl6L1dYMHRH?=
 =?utf-8?B?NmJ5aUQxRU12UGxRUWxOK2wrcnNjNFZaWGRHK3JYN2hQcUFLckdPSnZjckVG?=
 =?utf-8?B?MGw0YUxSNm5ncHdRcmlld3JmNTFKZ0JkdXpzRENKYUVIbXdxR0Fmam0yQ0dy?=
 =?utf-8?B?dExvR2YyR1NHOXgvQ3pMSDkyT1JsQkZiQ0g2TnJJeU1XcmF1M3ZrbWNpOGli?=
 =?utf-8?B?dHFoUnY5djBRMzl3ZXovUGEvamJXT3Nvb3M3N2FjcVd5SWpDMFhWclpwNUVl?=
 =?utf-8?B?MXIxeFVUV3YyVnMzdUNnR2VNemlxSUM4WHcxbndNVy90M2l5NlVsbXRyL2Nq?=
 =?utf-8?B?VFFmMnZJVDRURDFNb1UrVmRIN1oreHlwWVBKdG8vQ2VCaG5DaDc2SVZ4ZjNk?=
 =?utf-8?B?VzRKNTQ4MDNQTlorQjRGaFA1N2RNSUdYMVZKcFMvNVJMMjZxbXIvVFRjOXlY?=
 =?utf-8?B?T1F5NDRQMlQwOXdoclFTS2h3K3RWUnlSTFpOL1N2VDZ0K2JOa2VjVERXcUFJ?=
 =?utf-8?B?cUd1RlJZU2liczJJVTJoVExmdjZKd2xGM0xvWUVuZ2FDTldVTjYyWkN4MUlG?=
 =?utf-8?B?clBiVFYvZUF0RWpPMGtQQjV4cDZFVTBVbllSMTVSckFMTmpYR0wxOUFONjc1?=
 =?utf-8?B?c0k5ZHpoRnhhcHc0dDVGd2dUTkR1MGhUbU1QNjFqck5pZmdmU2Q1S1Bya3Uv?=
 =?utf-8?B?R0I3cW5yNGwwQXlRcTFHSmVVNHVyZkhHaWpiRGFIbUdtbm4xVHNwSHZLMFVD?=
 =?utf-8?B?WHQ3TWMwRHZlRWV6bHRuUUVKdlV5UW9QcjZKL1FOQnhjR0t1OU1sWldjaGlw?=
 =?utf-8?B?VlFFc1A1c1JmZUlaaHNIQWJJYnVlUlhjOWxIa2l1WENIYzZsT1JYWWREOG5j?=
 =?utf-8?B?TmV5eGdzL3VlWTI2N3pMWU1jT1ltUTN5U09wQisxejd4d09qUFJGMkg4d1Ji?=
 =?utf-8?B?L3RaWU5oMTI0VFpMUXpqSjVIUzFmWUFHSjkxazVKa2ZtYzR5aHY5ZyswZ0Rt?=
 =?utf-8?B?K1R3V3ZpMFdOR1A0bHIrVThSUzNIZ2dOa2VIdU9rQWdpWkNrK25xWXFlZzU1?=
 =?utf-8?B?bEh4bTJuMnk0aERIcHR0citWOEljT0VrbDB2TE5IbTlNYlJ5MFRBQVcrYWcy?=
 =?utf-8?B?UW5sanFPcUVkTDBYTDFFVXRYQUNVR3RKMVBXN2dzMU5ybmtGRnJDQmZOOE55?=
 =?utf-8?B?NERvTmRpalFad1JGUWt6cjh1S1oyUDNKa252alJJQzBvelBEQmYvQmhHN0xC?=
 =?utf-8?B?MFRTTE5KQVR3MEhoY1ZndEV1S1R3WDNCZWdhbVdKVUxQaGZLa2NKaVhQNGsy?=
 =?utf-8?B?MDYvWXNEVFd0TVNaUlVma2dzSFJ3RDVzTFdHRWVPUnMrVTlEM0N5bThWZFUv?=
 =?utf-8?B?YSttdXBqN2FYZHFXeWQybW1Kd0ZYSDdHdnUyLzZvSzdQaWRUK3llblp1aWdj?=
 =?utf-8?B?SkVHdVFraklURUFzeW43V0lmT05GTTlNT2FaSERJUXI2MGlubytmMHRmN1Rn?=
 =?utf-8?B?ZzhabnBZN2hGYUs0T2s1d04wSHNwdnQzWWVNYXZJVXRtQXBWcVNSTFo3TkNm?=
 =?utf-8?B?VkVOVmFJWFEyU1A1NFdPZmRCR0M0QlNXRk9wb1VuQWNYbzJMRnN2ZXhyU1Vo?=
 =?utf-8?B?VmVnV1NFSlViOUN4b05saXdYWXVac3ZOcVJIT1Bibk1VVUFxOTlYYUd1YVFr?=
 =?utf-8?B?MncrRXBSMHh5R1FabEpwQTFZVjhNTWVGenlqT0lnSUdYMzd5ZXUrMkVYOHRw?=
 =?utf-8?B?RUIxeTdydGtTRkNTNkhBUnZKOGsvc1BVZ1F0eXVkcEYyZVE2M0J3T0FvTHlq?=
 =?utf-8?B?bFZtZVB4dHhkYzBtbmZEaUFpcXdnYmNtZDU5LzUrNHhPeDUzb21pQlFhbEtx?=
 =?utf-8?B?RVR0Z1NvRmprT3M0Yjl2amh3N1VsNUwyN3VBd0E3NmpTcGM2dlJIeTlpMHFN?=
 =?utf-8?B?Tm1jMURyUG41SjdFeENPUTkwNGtHbVl3RDh1bEtyc2RNbE5JUVdya3JXOGFv?=
 =?utf-8?B?T2Z5Z1hZQThLbU5JcTdTbTVmQ3E4dzdrUkZoTkE1cnh3U240bEtQcGlxLzQ2?=
 =?utf-8?B?blBXQXRUZ0ttbmhqYnkwTGZjbTZOTGVEazlyK3NwdXRIbmRrZTRCL2tCczRD?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A5533BADDFDFB40B8DC6F68E6269CFA@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe7e0b9-2355-440c-6686-08dae016e9cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2022 10:10:24.2110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JcvCy0HkA4EcaVk8Ms7j/oVaRsM5gxKyHHOC6QED6tl8knaHqLKhfqRepOSTm5dzkylcEeDYMLEX7xy3Efd0aNdbS3M/zS1ctFXk9Bxdqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1598
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE2LzEyLzIwMjIgw6AgMjM6MTcsIEFsbGVuIFdlYmIgYSDDqWNyaXTCoDoNCj4gVGhp
cyBhZGRzIGFuIHVuaW1wbGVtZW50ZWQgY29tbWFuZCBsaW5lIGZsYWcgZm9yIHdyaXRpbmcgdGhl
IGJ1aWx0LWluDQo+IGFsaWFzZXMgdG8gYSBmaWxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxs
ZW4gV2ViYiA8YWxsZW53ZWJiQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgIHNjcmlwdHMvbW9kL21v
ZHBvc3QuYyB8IDIzICsrKysrKysrKysrKysrKysrKysrKy0tDQo+ICAgc2NyaXB0cy9tb2QvbW9k
cG9zdC5oIHwgIDEgKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9zY3JpcHRzL21vZC9tb2Rwb3N0LmMgYi9z
Y3JpcHRzL21vZC9tb2Rwb3N0LmMNCj4gaW5kZXggMmM4MGRhMDIyMGMzMi4uODQ1ZjE1N2Q2OWVi
YyAxMDA2NDQNCj4gLS0tIGEvc2NyaXB0cy9tb2QvbW9kcG9zdC5jDQo+ICsrKyBiL3NjcmlwdHMv
bW9kL21vZHBvc3QuYw0KPiBAQCAtMjE2NSw2ICsyMTY1LDE5IEBAIHN0YXRpYyB2b2lkIHdyaXRl
X2lmX2NoYW5nZWQoc3RydWN0IGJ1ZmZlciAqYiwgY29uc3QgY2hhciAqZm5hbWUpDQo+ICAgCXdy
aXRlX2J1ZihiLCBmbmFtZSk7DQo+ICAgfQ0KPiAgIA0KPiArLyogV3JpdGUgdGhlIGJ1aWx0aW4g
YWxpYXNlcyB0byB0aGUgc3BlY2lmaWVkIGZpbGUuICovDQo+ICtzdGF0aWMgdm9pZCB3cml0ZV9i
dWlsdGluKGNvbnN0IGNoYXIgKmZuYW1lKQ0KPiArew0KPiArCXN0cnVjdCBidWZmZXIgYnVmID0g
eyB9Ow0KPiArCXN0cnVjdCBtb2R1bGUgKm1vZDsNCj4gKw0KPiArCWxpc3RfZm9yX2VhY2hfZW50
cnkobW9kLCAmbW9kdWxlcywgbGlzdCkgew0KDQpObyB7IH0gZm9yIHNpbmdsZSBsaW5lIHN0YXRl
bWVudHMsIHNlZSANCmh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3MvY29kaW5nLXN0eWxl
Lmh0bWwjcGxhY2luZy1icmFjZXMtYW5kLXNwYWNlcw0KDQo+ICsJCWJ1Zl93cml0ZSgmYnVmLCBt
b2QtPm1vZGFsaWFzX2J1Zi5wLCBtb2QtPm1vZGFsaWFzX2J1Zi5wb3MpOw0KPiArCX0NCj4gKwl3
cml0ZV9pZl9jaGFuZ2VkKCZidWYsIGZuYW1lKTsNCj4gKwlmcmVlKGJ1Zi5wKTsNCj4gK30NCj4g
Kw0KPiAgIHN0YXRpYyB2b2lkIHdyaXRlX3ZtbGludXhfZXhwb3J0X2NfZmlsZShzdHJ1Y3QgbW9k
dWxlICptb2QpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgYnVmZmVyIGJ1ZiA9IHsgfTsNCj4gQEAgLTIz
MjEsMTMgKzIzMzQsMTYgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiAgIHsN
Cj4gICAJc3RydWN0IG1vZHVsZSAqbW9kOw0KPiAgIAljaGFyICptaXNzaW5nX25hbWVzcGFjZV9k
ZXBzID0gTlVMTDsNCj4gLQljaGFyICpkdW1wX3dyaXRlID0gTlVMTCwgKmZpbGVzX3NvdXJjZSA9
IE5VTEw7DQo+ICsJY2hhciAqYnVpbHRpbl93cml0ZSA9IE5VTEwsICpkdW1wX3dyaXRlID0gTlVM
TCwgKmZpbGVzX3NvdXJjZSA9IE5VTEw7DQo+ICAgCWludCBvcHQ7DQo+ICAgCUxJU1RfSEVBRChk
dW1wX2xpc3RzKTsNCj4gICAJc3RydWN0IGR1bXBfbGlzdCAqZGwsICpkbDI7DQo+ICAgDQo+IC0J
d2hpbGUgKChvcHQgPSBnZXRvcHQoYXJnYywgYXJndiwgImVpOm1uVDpvOmF3RU5kOiIpKSAhPSAt
MSkgew0KPiArCXdoaWxlICgob3B0ID0gZ2V0b3B0KGFyZ2MsIGFyZ3YsICJiOmVpOm1uVDpvOmF3
RU5kOiIpKSAhPSAtMSkgew0KPiAgIAkJc3dpdGNoIChvcHQpIHsNCj4gKwkJY2FzZSAnYic6DQo+
ICsJCQlidWlsdGluX3dyaXRlID0gb3B0YXJnOw0KPiArCQkJYnJlYWs7DQo+ICAgCQljYXNlICdl
JzoNCj4gICAJCQlleHRlcm5hbF9tb2R1bGUgPSB0cnVlOw0KPiAgIAkJCWJyZWFrOw0KPiBAQCAt
MjM5MCw2ICsyNDA2LDkgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiAgIAkJ
CXdyaXRlX21vZF9jX2ZpbGUobW9kKTsNCj4gICAJfQ0KPiAgIA0KPiArCWlmIChidWlsdGluX3dy
aXRlKQ0KPiArCQl3cml0ZV9idWlsdGluKGJ1aWx0aW5fd3JpdGUpOw0KPiArDQo+ICAgCWlmICht
aXNzaW5nX25hbWVzcGFjZV9kZXBzKQ0KPiAgIAkJd3JpdGVfbmFtZXNwYWNlX2RlcHNfZmlsZXMo
bWlzc2luZ19uYW1lc3BhY2VfZGVwcyk7DQo+ICAgDQo+IGRpZmYgLS1naXQgYS9zY3JpcHRzL21v
ZC9tb2Rwb3N0LmggYi9zY3JpcHRzL21vZC9tb2Rwb3N0LmgNCj4gaW5kZXggMzRmZTVmYzBiMDJj
Yi4uYzU1YTZhZWI0NmJmZCAxMDA2NDQNCj4gLS0tIGEvc2NyaXB0cy9tb2QvbW9kcG9zdC5oDQo+
ICsrKyBiL3NjcmlwdHMvbW9kL21vZHBvc3QuaA0KPiBAQCAtMTIzLDYgKzEyMyw3IEBAIHN0cnVj
dCBtb2R1bGUgew0KPiAgIAlib29sIGhhc19pbml0Ow0KPiAgIAlib29sIGhhc19jbGVhbnVwOw0K
PiAgIAlzdHJ1Y3QgYnVmZmVyIGRldl90YWJsZV9idWY7DQo+ICsJc3RydWN0IGJ1ZmZlciBtb2Rh
bGlhc19idWY7DQo+ICAgCWNoYXIJICAgICBzcmN2ZXJzaW9uWzI1XTsNCj4gICAJLy8gTWlzc2lu
ZyBuYW1lc3BhY2UgZGVwZW5kZW5jaWVzDQo+ICAgCXN0cnVjdCBsaXN0X2hlYWQgbWlzc2luZ19u
YW1lc3BhY2VzOw0K
