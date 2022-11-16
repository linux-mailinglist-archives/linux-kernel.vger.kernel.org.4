Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B029B62BF58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiKPNXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238812AbiKPNXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:23:11 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2068.outbound.protection.outlook.com [40.92.103.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A56E43AFC;
        Wed, 16 Nov 2022 05:23:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbSYUmyK7td9fimvJC4I3DvrE1bJnAxvrWvFrAgXf2OSwRSmyGgFXX3iDVppzIWh1XQMNSBfEHSX7WKfTuzQ+Rh8NqgoTm48Xs/IBZHPguXblGIZxBwbsVfcLcZQ7a7rkCfWZHaDWDT/b2B/TzsVxomfscz39vjmnD+5oXhtQbFusHnhf6P/XEhV4ohjxNjlT2S1QjHoWa+54hFDEhWGHQJ1a/I7lWMP2kIBtuuQd7luAXImmNHIO5XE9lJ5U/tdGZHzt0nowyLvqRLoZnKhRF/vahU46tWmb8RKic7d8UKf7x5GxVUTKilNeDjf1WHQTDzbjlQrzPFuDcS2+JrPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMyfu0lJW++Mozt3Oc+8P2e0t53r9MB12FcCiiaEbiU=;
 b=ePgRxep5LrLNDL3Y2+gNWEFI0Ac//wbyfgqIRYDtFL1Mmb3a7YB6MObOkv9HW6REOILH9YmhgADPsiA+6a5Qg24ly2Wlp7w4hMbPBqPab3oFxEHFHiUxCuKBizdK9WJzTrSuAhgj8/XclN13UW4VkylgW87AP6h4y0pjnFbiB0BX361eEL+lfbEC3F5rZMcfsLf2or0hPxjI+vCPBSbyGiu+2ZmNdiWJCS/BmUxIZs/1q7S0BPC4ry5U9QETMQ6xgQHqO85DbDDKR0z43bXmRdkkLvV7kVR3Dj/wZnY4XTdkVy4RbAI48/zNHLwr0KXsMwQOEy2NSzQxQAvMiodMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMyfu0lJW++Mozt3Oc+8P2e0t53r9MB12FcCiiaEbiU=;
 b=psr8PlDTJFRJKW4kfm0LROl/Ofz1oRqO0x2UHdfYSdWdrNa+LxoW1zMIoJ14IcbBKJHt3TyXdwwWmGjEnfEBs/mkpycal0EKMidWhdf5voUo7lfPeOOsNry1z41AOTJ90s+MoWYdQe+G/8y9Wr2Rm8J8+ugdjQz5LaT3M0uTg1l58unJBQlQ7yMjnSuopqzBKOdYpRSdURt1U6kZmm6xwDg3tf9jpuYPh3hjf7zTkcKUl1lJrTc7oSjtu3m9DcaUhVPJNOe0L4AXTF0N1B9GM7cH6VsWOw8QBi24yiDhCcZyRsuEYriGP4Ua86u/PZsu63k/q4b8DlYbLwOWcNHiUQ==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MA0PR01MB6499.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:75::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.18; Wed, 16 Nov 2022 13:23:04 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3dc1:f6bc:49e4:b294]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3dc1:f6bc:49e4:b294%9]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 13:23:04 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Jiri Kosina <jikos@kernel.org>
CC:     "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH] HID: apple: Swap Control and Command keys on Apple
 keyboards
Thread-Topic: [PATCH] HID: apple: Swap Control and Command keys on Apple
 keyboards
Thread-Index: AQHY8ERZH9Ct9MEf50+HkkcqhiMPOK4/FfyAgAKGhoA=
Date:   Wed, 16 Nov 2022 13:23:04 +0000
Message-ID: <915CC6C9-31E2-4538-B1BA-70188C485E02@live.com>
References: <7AC64680-44F7-4605-95E9-B5FF97A78D2A@live.com>
 <nycvar.YFH.7.76.2211142347000.6045@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2211142347000.6045@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [YyBd/+gYVmIJnBgzdApxRMojVPIVNgoF]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MA0PR01MB6499:EE_
x-ms-office365-filtering-correlation-id: 7e68ce84-ed0d-4c81-14d9-08dac7d5b153
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8wWc0oI5BZF4n6CwFRr6WTcvGBDJ/02iOYo7EA9HCdnMEvwLi6yTmpPYcm1l4pnKul4B5fI6buBZQhREegybPWPwGqVOB/4T0gt9yd6BcIjM9m+ROnwzdbbQZQqPJGKGBuAmhyXpkyzCEyqfpkubUAudADtHCnjQqm6dNHzTXxZNN7b0L97FTJheL6kDcUNqA5zQEdNQvqT6eS7qbH1Szs5OmumIEqC7OZPWd2EpUeZILA+JZL0XqkOWBTIfuWY3corb4yzvTGD9tmuSj3LCc2zOjSAsiDVnH6pIkCNGKlK5T5kyigRNO4qfZ3OqPKZ0DziX3XbU9KtFGExHf4BGbb3MHtP4Ac7Wp+XybJ9/XUJh/YrXH22DoIqid2xUIR/nWTwA8S4wycGLZGQwEMD/S0SNxO+gj55dm70yjr0qg4Zp9d5UXM5yEQhXwcV2cviPflzJdI21P5ymWXlR9k12Rn14lPBa8mtEMjhITnnQ9hHV7KQ1phA2M/smJBsmrcqEBYop8xw0dV5NnftMzO+x2jcLNyTNlxmjvI6Z4Fe8aXRSIdrppTxxUEoCdY1KMCG19+irf7TGYBgR0JOMLcKnniJp1fw/xWOgDHdjsFAxYKsUnNZ7h687VdfeJ91mW9rSSYv1NOYRp61elXVihqwV4447Ht1EnBHuAUTAA89hMQjbVzfrjFNhRXG9kdNyDJU
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWNKQ212MTY3L1NCTVdzejFWSlBMd0llR3lEWll5dlRDRkljTHF0R05ERTBi?=
 =?utf-8?B?aU55QmFldnlmLzJFcTNQeHpidm1udXVNOUxmSk9tZHJGL2hNYzJTNmFKTXNE?=
 =?utf-8?B?aUszaitwRXRLd2ZuWTd1S3hjRUZvWW1ML0tZcHduTS9rV3FLK3Z5VktjNlpZ?=
 =?utf-8?B?NnhNcUluUEFDODlSTWRjSXBkN3o1Qi9IN0NtVUVUaXRJdG5yd2Q4eldvZUJV?=
 =?utf-8?B?ditiOTE2K1ArZEZERThsdzRKTE1KcUdmUXI0bjNLd292RXJhQlZmNkV0VXVp?=
 =?utf-8?B?Q0hxdUtsZk5hKzB1UjFxb0NXVVVMMzBJak5QdHBHbWQrTU5USURXMXM1M3Zz?=
 =?utf-8?B?QlZZaUNCcUZjazlDTXc5RGVMUmtLcVBOTUZEMXJocXdCUWtNTXhIM0JJMWNu?=
 =?utf-8?B?ckJyay9yTVRMNDFsTUUvbTR2V1p6bzVWRDFWUS9KSnZETCtkdVEvS0JzcUt6?=
 =?utf-8?B?RXBwN3ZHUnZpZTE4U0lWZE5MRWVWSXBjMDVnam4yTis5cGdRMlk5RUFoS01z?=
 =?utf-8?B?RFZtSVh4aC9mZTlwbWpncndiaHFLeEVtT3FmY3VSeGFQSHFaRFpCbUZBSjBy?=
 =?utf-8?B?Q0xPOENtbHllQzNjTmp4bm96MDdVSG5HZDduLzVNRTJhREZmeXhaMlVRbzZs?=
 =?utf-8?B?OVhQM1EyMEF4Y2pEZW9HL3VLcmlTQ0pXajJmU3R6ZDFSUmVhdHdqR0x0V0h6?=
 =?utf-8?B?M3Q2OTFyTUJTTmFNb1VBbjFnT2IxWldTNitIb21JK0ZWZGRuM0NDQ3lvalcz?=
 =?utf-8?B?UnRkOGo4OXU1OFhVVnBqSzhyaVRTOFM5a2t3eVErcGt5L1VpWUlyS2dRaDBV?=
 =?utf-8?B?Qm5VcmIzc2YwY1dxRmk4OEd0WjBuOTdDSG5yZzEzM0U1V01meDNQSDVzTFds?=
 =?utf-8?B?OEViOWRQR3BYaCtuZFhYWThwSVBuZGtTbUZoWC92b0JLTktsdEtVRndZVzJp?=
 =?utf-8?B?QkpSTHRHWGZMKzgyWW5NQXM2ZmtHOElrdms5M291WVlEYThkY2wzVldXKzBE?=
 =?utf-8?B?YWFWbTZ6Y0Nmd0tndG01RkRINFdURFpxRWd5b3JMaVRPMVZlMmhuN1loUzd5?=
 =?utf-8?B?akQ5UndLWkNnMlh2QUdFVG5VK2lJRU11eW0xRk1SdXZzRVQvaHpVYi85THk4?=
 =?utf-8?B?R2xOUEt0UTJSS2VUeFJYdzJvalJKMDBjeXVRcGJnQWRvaXpKUHc1d01oMTVV?=
 =?utf-8?B?OCtYcGNxM3paNUJsVjRxYVpBUis3ZW9vaThlalFndGtrbXQvU3ZYb1NEdkVM?=
 =?utf-8?B?V1M4T3FiMTZGZlNKOXhWK3NmenAra0l0TTBXa3orVUJSNVIvZHI0MHdEQlJN?=
 =?utf-8?B?eHo5WHRSaHRRU3lLVC9PaDI5bERxUUFxdGJlWUFCS1FSUUN0aUNORmFKZzlp?=
 =?utf-8?B?b09ORUEyT0Frb3JwSTdwZkpzYk1XOEFuOVhqOXE5U0lweGRhTmt1cUU4YkNV?=
 =?utf-8?B?TGUzcWQ3ZUFnaDkzb0M2TGVqNXlnMXZDZXdpSjd4d1doL2h5OFk2U2UwUnJ3?=
 =?utf-8?B?cHlJaGxLeUU5aDk3cXFHaStSRithVm8vajZCdlpvSnlzVFZjTnhKVHdRNE44?=
 =?utf-8?B?UW5ZbEdmUDdQZFpOdm9odVpXZzkzZ1RiWE1XS09nUjFOTU1SVmtWQzhJWWRo?=
 =?utf-8?B?enkzOEc4ZHM3WitGNnJzT2ZOWklnUTUvNlNFemFLR2llSG1KazFtOFcyVU1E?=
 =?utf-8?B?TUQ3b3VQU0JVYWVvQ2JYVkJiZklKU1NVcXMzYXRoS3lwUzVob2xORFV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C09AB7BF19A12469418E9E87C151FCD@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e68ce84-ed0d-4c81-14d9-08dac7d5b153
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 13:23:04.3163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6499
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEFwcGxpZWQsIHRoYW5rcy4NCj4gDQo+IFRoZSBudW1iZXIgb2YgbW9kdWxlIHBhcmFtZXRl
cnMgdGhlIGFwcGxlIGRyaXZlciBoYXMgYmVlbiBhY3F1aXJpbmcgb3ZlciANCj4geWVhcnMgaXMg
YmVjb21pbmcgYSBsaXR0bGUgYml0IHdvcnJpc29tZSAuLi4gSSBhbSBub3Qgc3VyZSB0aGF0IHRo
ZSBhY3R1YWwgDQo+IHVzZXJzIGFyZSBrZWVwaW5nIHRyYWNrLg0KDQpJIGd1ZXNzIHRoZSBBcmNo
IHdpa2kgb24gQXBwbGUga2V5Ym9hcmRzIGRvZXMgYSBnb29kIGpvYiB0byBrZWVwIHVzZXJzIHVw
ZGF0ZWQuDQoNCmh0dHBzOi8vd2lraS5hcmNobGludXgub3JnL3RpdGxlL0FwcGxlX0tleWJvYXJk
DQoNCj4gSXMgdGhlcmUgYW55IHVzZXJzcGFjZSB1dGxpemluZyBpdCBpbiBhIGZyaWVuZGx5IA0K
PiBtYW5uZXI/DQoNCkkgd29yayBmb3IgdGhlIHQybGludXggY29tbXVuaXR5IGludm9sdmluZyB1
c2VycyB3aXRoIFQyIE1hY3MsIGFuZCBJIGd1ZXNzIHRoZSBwcmV2aW91cyBtb2R1bGUgcGFyYW1l
dGVycyBpbiB0aGUgZHJpdmVyIHdlcmUgYmVpbmcgdXNlZCBieSB0aGUgdXNlcnMuIEFsdGhvdWdo
IEkgYWluJ3QgYXdhcmUgYWJvdXQgYW55IHNvZnR3YXJlcyB3aGljaCBtYWtlIHVzaW5nIHRoZXNl
IHBhcmFtZXRlcnMgZWFzeSwgYWx0aG91Z2ggSSBndWVzcyBhIHNpbXBsZSBiYXNoIHNjcmlwdCBw
bGFjZWQgaW4gL3Vzci9iaW4gY2FuIGJlIG1hZGUgdG8gbWFrZSB0aGluZ3MgZWFzeS4gSSBoYWQg
bWFkZSBhIHNpbWlsYXIgb25lIGZvciB0aGUgVG91Y2ggQmFyIGRyaXZlciBmb3IgdGhlIE1hY3Mg
KHRoZSBkcml2ZXIgc2hhbGwgYmUgc2VudCB0byB5b3Ugc29vbiBidHchKQ0KDQpXZSBhbHNvIGhh
dmUgdG9vbHMgbGlrZSB4bW9kbWFwIHdoaWNoIGNhbiBkbyB0aGUgc2FtZSBmdW5jdGlvbiBhcyB0
aGVzZSBtb2R1bGUgcGFyYW1ldGVycyBkbywgYW5kIGlmIHVzZWQsIHdlIGFjdHVhbGx5IGRvbuKA
mXQgbmVlZCB0aGUgbW9kdWxlIHBhcmFtZXRlcnMuIEJ1dCB0aGVzZSB0b29scyBhcmUgYSBiaXQg
dW5yZWxpYWJsZSBhbmQgYSBiaXQgZGlmZmljdWx0IHRvIHNldCB1cCBhcyBjb21wYXJlZCB0byBt
b2R1bGUgcGFyYW1ldGVycywgYXMgcGVyIHRoZSBmZWVkYmFjayByZWNlaXZlZCBmcm9tIHZhcmlv
dXMgTWFjIHVzZXJzLg0KDQpJIGd1ZXNzIEkgd2FzIGFibGUgdG8gY2xhcmlmeSB3aGF0IGFsbCB5
b3UgYXNrZWQgOikNCg0KUmVnYXJkcw0KQWRpdHlhDQoNCj4g4oCUIA0KPiBKaXJpIEtvc2luYQ0K
PiBTVVNFIExhYnMNCj4gDQoNCg==
