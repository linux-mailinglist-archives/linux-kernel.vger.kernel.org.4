Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9A769173E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 04:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjBJDly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 22:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBJDlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 22:41:52 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2095.outbound.protection.outlook.com [40.92.23.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8B0B447;
        Thu,  9 Feb 2023 19:41:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTYFsQCKddvy8Eh8DB1Tl50zmMHzZeZT3rVNrAVcq9uT8YSFRnv2jqsmiAQ7DKqp1Ftk8U+pQOEq6HeR5DOFZC113k9xR12Es/Sq25ubM0ZkEbm/bo1uYJC1LmN4MYrrbx2S+JdN3uOeeYNa1D8mVkE9laZstd+AejiLAp95/7snenl6OWe/+oXbhf+aiiZPASNEUhL1o/XT7RQ35fmFPpsOMv+tgHcyO+hGmtjsWdNebfMLH0t+ILcWSJRn5E2va9bis77DBbeL3s8nNPI1C3Dn0AqjRTN+Lqu1TYnIagRMLfLCzDVuc/z4wDQ/QBkn/c7ltfEQfX6iFAQDZemr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYLrxwCzAgaIBrJ/Y8+mlCbtavcgnMndawta0t5bdXg=;
 b=VFuqU0PR9smjGSgzUs+U8YRTSZeYDF0pC/XY7JrrRBGMjW2X6eaMJcXy2Hbbq+++wVdThPfCYNWby8bYE30gBiKrPa7ZvpPDKO33EWhmZhRhkN+oCU5WB67U8wDDzsgNc3VhF/m7q4wZOeF2bb+GW6Vh2w1/w87h3X0NZCPwtJMubgTGbW/0hwBtYrCavMlSq4L0Nlc+Zh9KL9zTyE75on9ZOxNR7MBTzYQn4FOPmPifQxzYbLgsxq7jH+qxFiPdhDHq93/8/C+U1H+z3knPvzaspNY4lhgBMEjqfOMr1H2DFamx36o4smTdbDu43Zyd1ghVZ50gtnR3dCEFYKjsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYLrxwCzAgaIBrJ/Y8+mlCbtavcgnMndawta0t5bdXg=;
 b=mKlnp8+s7W5zi2J5W+zG2ys/ufLIi4jzV96PNsJdQXG+eb+HvLyKeRcueI84lAAYDWVBHndMHox/Y5f1tewSH9M8opjs52Ys4+AGnmOritxYlXf+25H3UV8TS64Bc4SgE7mkBxfJcHFSBlUSKRbA65cC3fDPVcGvQUIHDmc3VNYdnwy/faYYAA3sDUnKkAYXv3NrP9ay4KWdsZ345w5ol/UGP+dI3L7yvhWNmxGYOtwWcHZYnoLBUdBTXaOjQSzcLgrSc1Va6waimLgmE0wCrK3nhBo/jOZ4O8haL+smHVTqrhgKqjr5buf0HlBko6sElpeWTuSLPRWrZGG5C+JXCQ==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MAZPR01MB5554.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:61::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19; Fri, 10 Feb 2023 03:41:45 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d%11]) with mapi id 15.20.6111.005; Fri, 10 Feb
 2023 03:41:45 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH 0/3] Touch Bar and Keyboard backlight driver for Intel Macs
Thread-Topic: [PATCH 0/3] Touch Bar and Keyboard backlight driver for Intel
 Macs
Thread-Index: AQHZPQGZPHmOr7bJ2ke1lktvnMU+hg==
Date:   Fri, 10 Feb 2023 03:41:45 +0000
Message-ID: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [BPkq9N1xH58gZgFypXoqeqYW7QARpENP]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MAZPR01MB5554:EE_
x-ms-office365-filtering-correlation-id: a027e547-735e-4cc4-5401-08db0b18bba4
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ZRNDnTWtlKVOKa6edZm/XKwifPH9v6FWqp6hVddxqeL0EVvh+PkzvozThq1ILFIlk0WnrBcUW7j+erwSg3eb1rv5vuQvQwcp0abFPAazl2E9l/czQvFpwp2pJIExbxl5UIulepKwQecaFFllH+nf70e9zg4WJ4cW8bPSS0l3m0zwmPu0+EDpjxlPPWJImUQSN5P7FbsDHU4u3Ae5WVlt15rtsjS5BLFXxknz30QGSfnddO5dfbR4RMkCSxfRLinPeHTaaSt0jzFi2DxLZiVMsbw+C0B58WrHTsu5myN1SETGOrbh9+Y9QXkSHV1ZlqR4sm0V+V/QOg32OIdZamrmpcNiL3O+M2km3CxxxiJQnlBx+9lM9upXPVpT95OcFicp/lUbgKui4Rm1JUzA/objiGIbQrpRVUJab+hp5DL98dqXqpkAYg+7wsiR4RV1ohZnv4ylWG6g/3hsCe/mOoipghIN91EpHZo9X4H5uYtNibaAMk34I+PlLs1BoJBCmNEhYnrXB2iPXIeGuKyMlMaDgZRsSu9HK2q+bWqCmNlx/p/DQHYaUBV7Xo0+NlHhOxxdy7XvR12RmrCqJ1VOIKyKg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGhuZTMxSDRNbDF1SC9odUQxL1VEUlczSGg2bHRLNGxwS09SNmhZaTZ0QWRH?=
 =?utf-8?B?QzU5eC9zVXZIMUQrN25zN3BsOWcrQlpNanNQL09kVUhtN2hFY0p6TnE4VG13?=
 =?utf-8?B?NUdNTW5YQkFydWI4Q0k3MnZsNFpxUHh2Z1Q5eXU4NDA1UkhsNDZUeWRaRERN?=
 =?utf-8?B?QzdMVStDNHo2YmVNL2pBeWVhUlkreVJvMENrdFlJNkUwM1VzZ1Z3aVJWSE42?=
 =?utf-8?B?dHFaT2FiRzZmUG14aVRoRSs1d0xJdWJSTlFHZGV4R1EvMVRxMFJUZmJ1TEJr?=
 =?utf-8?B?dEtLYi9BQWRtemFhaU5SWXpyV1JORlRseGtTYW1GT1J2RWhKV3k1MEY2dEJU?=
 =?utf-8?B?OWF5UCtEMVYzbC93OEpFaGM0N0pMRVpORE1GRFBCMXo1T3VMZGNlVHAzNkk2?=
 =?utf-8?B?bGRBVC9sYWl2c3RvWDJ1NlRCMEFZalpNaDJXWWs4VDlvVEFkbVFadldwZFJT?=
 =?utf-8?B?d2szMDgzU2dTOUdJOEhTOStTWTN6elplemJmckdwaGRaQkdVcnZFUTdDT09C?=
 =?utf-8?B?T1dPaTRrWW9WNTl3a3dWM1c2NmMvY2hkSi9DOUNGdytyZHR2SWpkclBOMTRS?=
 =?utf-8?B?TTY1T2Y2V3FENUpnRzg5cnFKSEtEcTYxZnVka0Z4VkEyZGUzVzNmdVpRQmdX?=
 =?utf-8?B?MWVBZU5BaUQyN1huL0QyVzBSNEs1L1RKRmZ2anNPbXl6SXBXTDJlVmliRFkw?=
 =?utf-8?B?M1NNdXN3d1M0YjBBNUJ5a0tzaG40OVdOUGN5Yjg0WFdsZC9wUDQ1MkI2NzZX?=
 =?utf-8?B?Uks5NEd6ZFBzY0hodEJmWjhaV21NNFNqb1hITU9GaFBSZjZTcXdyRjcwSjMy?=
 =?utf-8?B?Vkh5VWMrbnBYamRxSmZlVXJORGlPei80enRCYndGb0djaWN1ZCtnYy9kUEpV?=
 =?utf-8?B?N0NkUGxBUkNKQTlrOUxoRjVJSHZGV0NhQ1Y3S3BpR3l0WHREbTlxN2F0SkpM?=
 =?utf-8?B?bkhsMFdFUEFNbDFyS3N1eG5mSnBLakFvMmtWMlBtMnZ3QkhmbWFRNUFGQTIz?=
 =?utf-8?B?WlYzU3dnNHlJbm4yaG03azU5R0s4YWpDS1orYXZrU2FsQTVma24wSDg4MGJz?=
 =?utf-8?B?N3ZRNUV1ckd1ZkNNVDBPSWhGdTdyYlpmcGFja1lJNmhpN1ZNZkgrUGJsSVJa?=
 =?utf-8?B?eTFLR0xZREZtUC9MTFl6eWs3dXpidXFIci9iQ3NiSUZERys0Qm1mNVVVZFdG?=
 =?utf-8?B?cys0cHdJNE9FdkJsRXJCbHUzVmdYTlorWmxMclBjVEd5WThGNjFTM2xSSXpE?=
 =?utf-8?B?U204WUh0ZlhuQkgwQlFLNDBpbmZjVFc0UzQ5V1BrOTkvV21wK0lMY1ZISTVX?=
 =?utf-8?B?aVN5c2NNV0VyMGt6TE9zZ0pMMWhHSktNaDRFNlVQenVFcUtJVkhiWExoeTBJ?=
 =?utf-8?B?TDNhTlliTmczQmdPcVNRTTl1b2VwL1I5Q0RaUGRkYUpmeEpzaUJQTDQ0eXlP?=
 =?utf-8?B?RStLckR2UVl6Q0tJTFJvWnNJTXJkTzNhY3NsUVlwRWwwOUpoaUJLeUtFaDRG?=
 =?utf-8?B?b3RUK015Vm9peC9ENVRqd0VPNVBzT1QyaEVUZFZGdDhwRUNiWGI5akpyVGt5?=
 =?utf-8?B?K1p4OTYwQk4xTGRreHZZTWZJaEFXUEQvT1ZnRmoreXl3ODdRWC92bGJNd2JZ?=
 =?utf-8?B?U3diYmtoVC95RFFhYU9PR3FrMlBMYzBtR1FoNlR0bzFVSGJybDhUVEVhODFG?=
 =?utf-8?B?TU5mVlpCT3ErM1pxazNMNkozbzdGU0hBaTRYTGt6bXVGaTVNaVN3bHRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7DDB2D0A7D59A409B1144752A8EFE28@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a027e547-735e-4cc4-5401-08db0b18bba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 03:41:45.7817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5554
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R3JlZXRpbmdzIGZyb20gdDJsaW51eCENCg0KMiB5ZWFycyBhZ28gYW4gYXR0ZW1wdCB3YXMgbWFk
ZSB0byBzZW5kIHRoZSBkcml2ZXIgZm9yIHRoZSBUb3VjaCBCYXIgb24NCk1hY0Jvb2sgUHJvcyBi
eSBSb25hbGQgVHNjaGFsw6RyIFsxXS4NCg0KRHVlIHRvIHNvbWUgaXNzdWVzIHBvaW50ZWQgb3V0
IGJ5IHRoZSBtYWludGFpbmVycyB1cHN0cmVhbSwgdW5mb3J0dW5hdGVseQ0KaXQgZGlkbid0IG1h
a2UgaXQgdXBzdHJlYW0uIE5vdyB3ZSBhdCB0MmxpbnV4IFsyXSBoYXZlIGFkZHJlc3NlZCB0aG9z
ZQ0KaXNzdWVzIGluIHRoaXMgcGF0Y2hzZXQgYW5kIGFsc28gaW1wcm92ZWQgdGhlIHRvdWNoYmFy
IGRyaXZlciBmb3IgdGhlIFQyDQpNYWNzLiBXZSBhbHNvIGhhdmUgYWRkZWQgYSBuZXcgZHJpdmVy
IGZvciBrZXlib2FyZCBiYWNrbGlnaHQgc3VwcG9ydCBvbg0KVDIgTWFjQm9va3Mgd2l0aCBNYWdp
YyBLZXlib2FyZC4NCg0KVGhlIGZpcnN0IDIgcGF0Y2hlcyBvZiB0aGlzIHBhdGNoc2V0IGFyZSB0
aGUgb25lcyBzZW50IGJ5IFJvbmFsZCBiZWZvcmUsDQp3aXRoIHRoZSBpc3N1ZXMgYWRkcmVzc2Vk
IGFzIHBvaW50ZWQgb3V0IGluIFsxXS4NCg0KVGhlIHRoaXJkIHBhdGNoIGludHJvZHVjZXMgYSBu
ZXcgZHJpdmVyLCBhcHBsZS1tYWdpYy1iYWNrbGlnaHQsIHdoaWNoIGFkZHMNCnN1cHBvcnQgZm9y
IGtleWJvYXJkIGJhY2tsaWdodCBvbiBUMiBNYWNCb29rcyB3aXRoIHRoZSBNYWdpYyBLZXlib2Fy
ZC4NCg0KTm90ZTogQXBhcnQgZnJvbSB0aGVzZSBkcml2ZXJzLCBmb3IgdGhlIFQyIE1hY3MsIGFu
IGFkZGl0aW9uYWwgZHJpdmVyDQpzaGFsbCBiZSByZXF1aXJlZCB0byBjb21tdW5pY2F0ZSB3aXRo
IHRoZSBUMiBTZWN1cml0eSBDaGlwLCBhcyB0aGUgVG91Y2gNCkJhciwgdGhlIGludGVybmFsIGtl
eWJvYXJkLCB0cmFja3BhZCwgY2FtZXJhLCBhbWJpZW50IGxpZ2h0IHNlbnNvciwNCmhlYWRwaG9u
ZSBjb250cm9scywgYW5kIE5DTSBFdGhlcm5ldCBhcmUgYWNjZXNzZWQgdGhyb3VnaCBhIFVTQiBW
SENJDQpjcmVhdGVkIHdpdGggRE1BIGNoYW5uZWxzIHRvIHRoZSAiVDIgQnJpZGdlIENvbnRyb2xs
ZXIiIDEwNmI6MTgwMSBQQ0kNCmRldmljZS4gQSB3b3JrIGluIHByb2dyZXNzIGxpbnV4IGRyaXZl
ciBjYWxsZWQgYXBwbGUtYmNlIFszXSwgb3IgVVNCDQpkZXZpY2UgcGFzc3Rocm91Z2ggdG8gYSBM
aW51eCBWTSBndWVzdCBvbiBhIFdpbmRvd3MgaG9zdCB3aXRoIEFwcGxlDQpCb290Y2FtcCBkcml2
ZXJzIGNhbiBiZSB1c2VkIHRvIGdldCBMaW51eCB0aGVzZSBVU0IgZGV2aWNlcyB3b3JraW5nIGFu
ZA0KdGVzdCB0aGVzZSBwYXRjaGVzLg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDIxMDIyODAxMjY0My42OTk0NC0xLXJvbmFsZEBpbm5vdmF0aW9uLmNoLw0KWzJdIGh0dHBz
Oi8vdDJsaW51eC5vcmcvDQpbM10gaHR0cHM6Ly9naXRodWIuY29tL3QybGludXgvYXBwbGUtYmNl
LWRydg0KDQpPcmxhbmRvIENoYW1iZXJsYWluICgxKToNCiAgSElEOiBhcHBsZS1tYWdpYy1iYWNr
bGlnaHQ6IEFkZCBkcml2ZXIgZm9yIGtleWJvYXJkIGJhY2tsaWdodCBvbg0KICAgIGludGVybmFs
IE1hZ2ljIEtleWJvYXJkcw0KDQpSb25hbGQgVHNjaGFsw6RyICgyKToNCiAgSElEOiBhcHBsZS1p
YnJpZGdlOiBBZGQgQXBwbGUgaUJyaWRnZSBISUQgZHJpdmVyIGZvciBUMSBjaGlwDQogIEhJRDog
YXBwbGUtdG91Y2hiYXI6IEFkZCBkcml2ZXIgZm9yIHRoZSBUb3VjaCBCYXIgb24gTWFjQm9vayBQ
cm9zDQoNCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDYgKw0KIGRy
aXZlcnMvaGlkL0tjb25maWcgICAgICAgICAgICAgICAgIHwgICAzOSArDQogZHJpdmVycy9oaWQv
TWFrZWZpbGUgICAgICAgICAgICAgICAgfCAgICAzICsNCiBkcml2ZXJzL2hpZC9hcHBsZS1pYnJp
ZGdlLmMgICAgICAgICB8ICA2MTAgKysrKysrKysrKysNCiBkcml2ZXJzL2hpZC9hcHBsZS1pYnJp
ZGdlLmggICAgICAgICB8ICAgMTUgKw0KIGRyaXZlcnMvaGlkL2FwcGxlLW1hZ2ljLWJhY2tsaWdo
dC5jIHwgIDE0MyArKysNCiBkcml2ZXJzL2hpZC9hcHBsZS10b3VjaGJhci5jICAgICAgICB8IDE1
MDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9oaWQvaGlkLWlkcy5oICAg
ICAgICAgICAgICAgfCAgICAxICsNCiBkcml2ZXJzL2hpZC9oaWQtcXVpcmtzLmMgICAgICAgICAg
ICB8ICAgIDUgKw0KIDkgZmlsZXMgY2hhbmdlZCwgMjMyMiBpbnNlcnRpb25zKCspDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvaGlkL2FwcGxlLWlicmlkZ2UuYw0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL2hpZC9hcHBsZS1pYnJpZGdlLmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9oaWQvYXBwbGUtbWFnaWMtYmFja2xpZ2h0LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9oaWQvYXBwbGUtdG91Y2hiYXIuYw0KDQotLSANCjIuMzcuMg0KDQo=
