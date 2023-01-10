Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6221663C22
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjAJJEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbjAJI70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:59:26 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2050.outbound.protection.outlook.com [40.92.103.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B3B4FD71;
        Tue, 10 Jan 2023 00:57:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUl8Sn0Yb2JiSiXSvvcnWxGJuhMATG2BsBjRITUf4udE32iYCDH8F2v7gPC3vEPRD9+h8Cabi6mms9nOf2PVERSr5mr3LUiBR6GYQVu0Si+Judq6ht9L6eT27SOzy5WCGsFs1BPHvWP5HByarrjZfPF+mu3U0iQvH70M4VUa+uVPj2L0J1/nAFmYd8MJ6kwGRabxJrDgtdGFdrjjCBfKpFyg+Z/B2XevhzzgInhF/MTlyAXoJkS3DPtS6UQvHFndcBjUFqKSN/O4XY0eIapkEpbKMvrNko6//Caincq6USmhsIDZ+tXw5O/udz+7QbIXvmFcnmR/Nc/XPHld8AlVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ+JSh8VdcdlVdhK3YrfTF+0PHYj5uvFL/qOQS5mtrs=;
 b=lz0aUG0LqwdlGwbNNqDDxz1DD2LE0E3J/Ekryr06CXavSwlLaGlv3uda8pKIGbOuY+23mEOqU62tclzdzoN1Hb/MiR0GVXGbtcD1elZiJuBxmgh3N3zPYT+ajqI43v0SZZOYIhTX9o2ZtmrvSXxij+6+zj3RYvV/fwhwJyl86Sta9nmAqAiEknPSoyupp8okuLvKH2jVcg0b/5mnqwivN5RUF9IAGMbT2sm1sJ1kUcTMiBiMC2E5JlAKYTtXMybPGDlk7jUGG0BhnqlqtKxQWto8wT387kNtCP2cX2ImM6AXTuCaDL09FvhZTjscbi8/Rv2T6t3QMWQDCmQnkpgF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ+JSh8VdcdlVdhK3YrfTF+0PHYj5uvFL/qOQS5mtrs=;
 b=LqyW5NSYk0BGAdUlc0RxmgYjgC7R/ryzsm2/MoXcdvgmImQCUhpw37KbE8mhHD+vVtaqBMCpFOV8Ee+bH/oOKBYMCYRvr0yGdpRSCKfRduR4vBQtUWbVKOvfBHICMqb0nZcyo34Wd7S/PJPxvRJHyR+86SNsbBPO80njapGO8emdVYTrIIUKLMrTF0lIq8poSl0/PZYBfVAN0vKl+xhhyxq3grh9LwJ9J808LuCqRYChUlvcKFTVoHOw0KOHIffg4zSIsLuvrG5FxP5Ng+vzwZSbrSG6vEEeyvIL9M6fDMhNIRLZ5WPCPIc2Af54Iw/t1InHsjFeniFxZLqpuWD43A==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN0PR01MB7672.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:c9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11; Tue, 10 Jan 2023 08:57:28 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f2f0:34b5:eb58:bb5a]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f2f0:34b5:eb58:bb5a%6]) with mapi id 15.20.6002.010; Tue, 10 Jan 2023
 08:57:28 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "orlandoch.dev@gmail.com" <orlandoch.dev@gmail.com>,
        "ronald@innovation.ch" <ronald@innovation.ch>
Subject: [PATCH v2] HID: Recognize sensors with application collections too.
Thread-Topic: [PATCH v2] HID: Recognize sensors with application collections
 too.
Thread-Index: AQHZJNGQHGy5pxaqk0SG23+WPMWSag==
Date:   Tue, 10 Jan 2023 08:57:27 +0000
Message-ID: <EFCEA45A-C6F4-477A-B011-9C9E6E61E488@live.com>
References: <8DA00FF4-DB08-4CEC-A5B4-47A71DC09C13@live.com>
 <01D620E2-18CA-40F6-A330-454CBC20C542@live.com>
In-Reply-To: <01D620E2-18CA-40F6-A330-454CBC20C542@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [WeZSo3tYEJvTUKOztUz6yf0QA9WnC7MiCNF8inqwknGZnGTodRx0I9r3ydfJQU69]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN0PR01MB7672:EE_
x-ms-office365-filtering-correlation-id: e50cf2a9-faf7-41b8-2906-08daf2e8b33a
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TqRz5Ris94fW5yyFS0Wx7m4rZboQpi8E3Li9eK5jWXtsk4vwMe1q9mjuU7Z8kZpq1vcWGx01FowYPJXsR7KlMyZ5hEg+6MHTuDLHi5JZPFlPTcUVomiwqunEQInEyHvD+4ZN8N4/6c3KQq9lN8v4IMkv6RLD6yFghWg8OGT9lrCrvf8GfwZsnV4wMvVmTt3QBnNXkzy6WWibtUG93Z4KSRCN+WvA0ctYfGb7mV1JllcLttXBGmwthK056J4dTEARYAJUe8pwbt8U+jWLMFt52d0SGvBewmL0lMnXfR/r36wnzdHdDgTvaBAJrNBgtHY2DbTwdi/EHJydv2m2MZwX7KkjDyeRcaaL0ztLWJEOaLxwbd/urKz45XeytbBox6TGXBFjk+Xk5eIejNNswdJMj5HvkjHhhJwd0osU4+hc8RrC9dbKe5cUsysM99dP2RvuS8wnRe34E6eWE6BPC9GXMfAo40y+rvx5KecFTwFUrdB84Mc5bGG9tp2HMxY9MkjpHL2trI1wn3BkWSviKqL8ZoWj3eOXosf4Sx8fkDpnAMqrQgOCkIascXRAXBXTv1XUNXjzXqATT7jao2zWA3d+fvw8P/+TJ9DQaiii1lbWAho=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkNTY0p6R1ZMVkQzVDBxTTlMbHZnbEtzMzN1VWVzMFEwaGl3Sk0vTy9zSWRN?=
 =?utf-8?B?WlBXVzYwd1JQOXY0a2hqaVlyeFFMNkFwamxYZ2ozQ0tMaUxQNUczSHEyVjN6?=
 =?utf-8?B?bDN5UDBuTXlleDFsOVBIN3AyQ0ozU0pqNWtyRTZyaUwzT2dNSHdJdWVaN3My?=
 =?utf-8?B?cGVaR0I2RlBXM1ZXZVN0TXB2Z3VEMldBeEtjTXBzMFpHV1RNVGhqZ1N6bi83?=
 =?utf-8?B?Y2NEQjZyN2IyU1J4Sno4d1lycGh4NndTck9vOXgxSHNsbzBNTzZUUXVVOXRB?=
 =?utf-8?B?Y1VHT3B1SnN4ckhjdnIyUUswNTd2LzRmbWtBYVlMUWhSYldlWEd1YnFsTjg3?=
 =?utf-8?B?ckE3NlhHcWxSbjRiY3ZYWWhRd3EycHZjcHFMMS9MYjNtaWJGZUlXZ1RuN0Ux?=
 =?utf-8?B?cG50bUVpT0kzOGRETjlYSWxhUXVVb3owSlB0YzE1anBMUjl5UGoyeHVZVnBv?=
 =?utf-8?B?Tm1pemttQXc4a3B5OXJ0VGI5azM3ejZBQ2FWZU1kSkhWTnQvcm5sNGVFdkxU?=
 =?utf-8?B?cEp6TWlCYml3ZFd0K1FaNnpKSXFuY1U1NkZsUVcybmoycVVyclExTG4rcThk?=
 =?utf-8?B?eGhVNEdBRnlKbTczc0JUamxYWWMxaDI3L0RLVEx1V1RLZmhCcjQ5NnJYb2Zo?=
 =?utf-8?B?NTk4YlJzUEV3OG5XN1hPVjBEWk5nRk5EM3pVYWNHdk1UYUowQWIrZUtnSHNz?=
 =?utf-8?B?SGZaSnROTHJiYXFieExQU1NjcUpiOWdIa3hYa2syYTZDaGFMNVozZng2S0xq?=
 =?utf-8?B?SkJmbU84RE1OK3ZORFNDWGdBTEZKZDBwaEVjdlpSYTk5SkxOOTdtQUxrK0Fs?=
 =?utf-8?B?dkcwUkx6dmdhTWZzOHNKUGFsNHlUZUUxbnNxWnA5NG1zUk0xZXpndTFvWG5o?=
 =?utf-8?B?ZFNnQzByMmk1R1ZXdHl3VWh6NW5aWitqVWM3U0VPNUd0aG1Mdmp0OUtJUUVF?=
 =?utf-8?B?Wm80aUtoM1NqQkVvblhKZkRPVE5GT2dJYWZFckYvRXArWTBkaXRIcmVaQk1i?=
 =?utf-8?B?Mm5pSE1FdzVWeWFHNXJlVGRMTWw1YU5FUHA3eGM1R3FpWURFR0FyWkxETDR4?=
 =?utf-8?B?TjNtS0pSZWpzYy9Ydm1ndGhiaGtoakVnWDNmQWhnZFYrcTh1b0ozVlg4blJN?=
 =?utf-8?B?RGJHNS82dzJQWDI1dlQvc2tNV2wyYk03TU1rYTV5SWt2UGlYT09sWGo4UFFy?=
 =?utf-8?B?dlZybWVnRWVsTjBHYUlyMjJhRlZGV2oyZkUxQ2NjN3ExT295OGhaOGFLdXRH?=
 =?utf-8?B?eWdUS3lub082YTBZZ1Fwbk9McmE3Vkl2bzVzSnhDMmlDMWYrNGdwU3ZPZWF2?=
 =?utf-8?B?RlV0aE84dk1IMnFyVjRKeGJYNEQxeEJrRExvM2xxbTRJVG9IYkhMakxiNnRp?=
 =?utf-8?B?cDNEOVgxY2hPcHZhbjRPNlp2UEpxQjBSRlhIVlFqZm54NUhFQlVDaENEcjIr?=
 =?utf-8?B?SGljRFF1VG9GV2lvRVZXL00rMTE2UnJnK1NXY3dxRFVRUlZjeThpWGxmWGhy?=
 =?utf-8?B?THlMT1BLUmRveDRIaTRwNTZMdlB3Vm1mdjdaZUtzMHZ0ZXlTVm5vaXpnTGtV?=
 =?utf-8?B?NkJzeUt6blVWZmtkbEZKNFRweWZqb1ZSUlp5Z253SUxnczR6eXFuaTBGZ1Mw?=
 =?utf-8?B?WUw1QytWTnFxVElyMTdmcDd2bFVvM3lEWnZQZFZYQUtLd01TUnlnbitqcTRz?=
 =?utf-8?B?and6WWpVcllBNjl6b2wzK2haR0I1WWpvUmdIZEFqRCtQYU12R0FMR2V1aGJt?=
 =?utf-8?B?ZDhiY0hreXc2UVc2TXowWjVxc2NkdjZWdExkRTV2Yk5zUUYwcjFjbmhZeVB4?=
 =?utf-8?B?TDhnbzNBZ0lyQUR1OVlpZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F265BE6504826B43B101FBC69F150427@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e50cf2a9-faf7-41b8-2906-08daf2e8b33a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 08:57:27.8989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7672
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUm9uYWxkIFRzY2hhbMOkciA8cm9uYWxkQGlubm92YXRpb24uY2g+DQoNCkFjY29yZGlu
ZyB0byBIVVRSUjM5IGxvZ2ljYWwgc2Vuc29yIGRldmljZXMgbWF5IGJlIG5lc3RlZCBpbnNpZGUN
CnBoeXNpY2FsIGNvbGxlY3Rpb25zIG9yIG1heSBiZSBzcGVjaWZpZWQgaW4gbXVsdGlwbGUgdG9w
LWxldmVsDQphcHBsaWNhdGlvbiBjb2xsZWN0aW9ucyAoc2VlIHBhZ2UgNTksIHN0cmF0ZWdpZXMg
MSBhbmQgMikuIEhvd2V2ZXIsDQp0aGUgY3VycmVudCBjb2RlIHdhcyBvbmx5IHJlY29nbml6aW5n
IHRob3NlIHdpdGggcGh5c2ljYWwgY29sbGVjdGlvbnMuDQoNClRoaXMgaXNzdWUgdHVybmVkIHVw
IGluIHRoZSBUMiBNYWNCb29rIFBybydzIHdoaWNoIGRlZmluZSB0aGUgQUxTIGluDQphIHRvcC1s
ZXZlbCBhcHBsaWNhdGlvbiBjb2xsZWN0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb25hbGQgVHNj
aGFsw6RyIDxyb25hbGRAaW5ub3ZhdGlvbi5jaD4NClNpZ25lZC1vZmYtYnk6IEFkaXR5YSBHYXJn
IDxnYXJnYWRpdHlhMDhAbGl2ZS5jb20+DQrigJQNClYyIDotIEFkZCBtaXNzaW5nIHNpZ25lZC1v
ZmYtYnkNCiBkcml2ZXJzL2hpZC9oaWQtY29yZS5jICAgICAgIHwgMyArKy0NCiBkcml2ZXJzL2hp
ZC9oaWQtc2Vuc29yLWh1Yi5jIHwgNiArKysrLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1j
b3JlLmMgYi9kcml2ZXJzL2hpZC9oaWQtY29yZS5jDQppbmRleCBiN2Y1NTY2ZTMzOGQuLjhmY2Q2
NjNiMTBlMiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaGlkL2hpZC1jb3JlLmMNCisrKyBiL2RyaXZl
cnMvaGlkL2hpZC1jb3JlLmMNCkBAIC04MDQsNyArODA0LDggQEAgc3RhdGljIHZvaWQgaGlkX3Nj
YW5fY29sbGVjdGlvbihzdHJ1Y3QgaGlkX3BhcnNlciAqcGFyc2VyLCB1bnNpZ25lZCB0eXBlKQ0K
IAlpbnQgaTsNCiANCiAJaWYgKCgocGFyc2VyLT5nbG9iYWwudXNhZ2VfcGFnZSA8PCAxNikgPT0g
SElEX1VQX1NFTlNPUikgJiYNCi0JICAgIHR5cGUgPT0gSElEX0NPTExFQ1RJT05fUEhZU0lDQUwp
DQorCSAgICAodHlwZSA9PSBISURfQ09MTEVDVElPTl9QSFlTSUNBTCB8fA0KKwkgICAgIHR5cGUg
PT0gSElEX0NPTExFQ1RJT05fQVBQTElDQVRJT04pKQ0KIAkJaGlkLT5ncm91cCA9IEhJRF9HUk9V
UF9TRU5TT1JfSFVCOw0KIA0KIAlpZiAoaGlkLT52ZW5kb3IgPT0gVVNCX1ZFTkRPUl9JRF9NSUNS
T1NPRlQgJiYNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWh1Yi5jIGIvZHJp
dmVycy9oaWQvaGlkLXNlbnNvci1odWIuYw0KaW5kZXggNmFiZDNlMmE5MDk0Li5kMDNkYzRjYTA5
NWYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWh1Yi5jDQorKysgYi9kcml2
ZXJzL2hpZC9oaWQtc2Vuc29yLWh1Yi5jDQpAQCAtMzk3LDcgKzM5Nyw4IEBAIGludCBzZW5zb3Jf
aHViX2lucHV0X2dldF9hdHRyaWJ1dGVfaW5mbyhzdHJ1Y3QgaGlkX3NlbnNvcl9odWJfZGV2aWNl
ICpoc2RldiwNCiAJCWZvciAoaSA9IDA7IGkgPCByZXBvcnQtPm1heGZpZWxkOyArK2kpIHsNCiAJ
CQlmaWVsZCA9IHJlcG9ydC0+ZmllbGRbaV07DQogCQkJaWYgKGZpZWxkLT5tYXh1c2FnZSkgew0K
LQkJCQlpZiAoZmllbGQtPnBoeXNpY2FsID09IHVzYWdlX2lkICYmDQorCQkJCWlmICgoZmllbGQt
PnBoeXNpY2FsID09IHVzYWdlX2lkIHx8DQorCQkJCSAgICAgZmllbGQtPmFwcGxpY2F0aW9uID09
IHVzYWdlX2lkKSAmJg0KIAkJCQkJKGZpZWxkLT5sb2dpY2FsID09IGF0dHJfdXNhZ2VfaWQgfHwN
CiAJCQkJCWZpZWxkLT51c2FnZVswXS5oaWQgPT0NCiAJCQkJCQkJYXR0cl91c2FnZV9pZCkgJiYN
CkBAIC01MDYsNyArNTA3LDggQEAgc3RhdGljIGludCBzZW5zb3JfaHViX3Jhd19ldmVudChzdHJ1
Y3QgaGlkX2RldmljZSAqaGRldiwNCiAJCQkJCWNvbGxlY3Rpb24tPnVzYWdlKTsNCiANCiAJCWNh
bGxiYWNrID0gc2Vuc29yX2h1Yl9nZXRfY2FsbGJhY2soaGRldiwNCi0JCQkJcmVwb3J0LT5maWVs
ZFtpXS0+cGh5c2ljYWwsDQorCQkJCXJlcG9ydC0+ZmllbGRbaV0tPnBoeXNpY2FsID86DQorCQkJ
CQlyZXBvcnQtPmZpZWxkW2ldLT5hcHBsaWNhdGlvbiwNCiAJCQkJcmVwb3J0LT5maWVsZFtpXS0+
dXNhZ2VbMF0uY29sbGVjdGlvbl9pbmRleCwNCiAJCQkJJmhzZGV2LCAmcHJpdik7DQogCQlpZiAo
IWNhbGxiYWNrKSB7DQotLSANCjIuMzguMQ0KDQo=
