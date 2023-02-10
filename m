Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8760E691A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjBJIaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjBJIaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:30:21 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2059.outbound.protection.outlook.com [40.92.102.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F068A38653;
        Fri, 10 Feb 2023 00:30:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC9RlqIIevwiAXT1qlEmK09BcHVUup7dWSQzzRErt6F/cwPxO9NEL1ZS8s64vjs6nSMnOcwY+qxVXrtCv7v2eNWNsSt8afEaqwWw+qtwqriup2XW5m6sQ4iFiW6s15uN9ZhmSsUT4PW2xVoaq/6c5cuxbttF7+EFAjIpi/tUVy2LckrVpOyBm9jzTf2ovZmOHk7z2MrCqwWHdQlHWxWZHRtHIm9Kn7VR4hY5HLlT9GT4SEFAu6SAsjqNaIuTBJoqhNBAzWcFEd9MKKWp8ZYA8fQR2dlsm89wSGqwtvKQlDYl3N7HyBwsw5sE3LVUSHVOg3uXEIbR4+37v03zdATQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onrGzcq0NBx5LMznhdxiD4hKfOj7nXgzBCTiJ32ulK4=;
 b=AU+vkSSJleYuXBoGiP7dgNKOpqvT3fm0r4/EjdiLQAdCqp5V/RWcgLgrCtEsfCee+DRaxtMrzFQOU/vEuGmbQ5m4BjJBRhhI0WA4wAejWBCIKbIAhhExgzqyKvzOR4hGektt+1l/WieZcdA+pZOW13bMTHDNCwuWS33T+yFK9bW7tniK5bJoAhk7q61drPTGNioBCQxgzPjz2lpjKt1TuBIY6DKuBNHHavljW+G2oelKqhzweiYg8A7XFZDinDCKcbjuUVHjB3zCjRzaY6vBkZa53eP32u+PYMa8uiJbgPuKMyeCJL19rjLaqKXCeY9nFEQ/dG77JnntkWMRoi1NAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onrGzcq0NBx5LMznhdxiD4hKfOj7nXgzBCTiJ32ulK4=;
 b=iZfhT1GPm7qg9Q+S67pnJxh9+dS99u/mNkxhD0k4aZiiveHQ+C5Led1GwicuCQbOuUj31Im2ox2QHaNkAhvIiQpQmEoX7DCaIXJGRkNpmvcpkskIs1jgKhanms9GnPaC1C7GfuuA+dpoIGIL9NfT0E40tjSGJAXkg+HWa7ZcJQFcVvWKyD9Qk52Phjfw5NQtPSCzLUEnFYw/bgLKteP/VWn+7klYBPfRk+Js2l6mRX3fjqyaiQ0nkwvUJe90BOFo6FtY7cuDbhYld0/yZ5kZaPTwpgTEGVlhz/TnSX0Fl1C8A9Q5B/u8ReDIStwEBk+AzbruZKHVj/l2jDVqhXzxmg==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PNXPR01MB7185.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:c4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.6; Fri, 10 Feb 2023 08:30:13 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d%11]) with mapi id 15.20.6111.005; Fri, 10 Feb
 2023 08:30:13 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <thomas@t-8ch.de>
CC:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH 1/3] HID: apple-ibridge: Add Apple iBridge HID driver for
 T1 chip.
Thread-Topic: [PATCH 1/3] HID: apple-ibridge: Add Apple iBridge HID driver for
 T1 chip.
Thread-Index: AQHZPQwM5DSulXBskEykQ8jgSAssVq7H2aOA
Date:   Fri, 10 Feb 2023 08:30:13 +0000
Message-ID: <AC5AB6F5-4D65-4362-A8B8-A694D1371188@live.com>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
 <20230210045624.cjxroikmmvm3liij@t-8ch.de>
In-Reply-To: <20230210045624.cjxroikmmvm3liij@t-8ch.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [kATHbdQpdibsPMJ+vtZWodyB/1P5LZa7]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PNXPR01MB7185:EE_
x-ms-office365-filtering-correlation-id: f76e45e9-1d8a-4303-ecc1-08db0b4107ed
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PNMB/xJ4ETepKU3kBf44uhSrtltgPqOZME5X9TTi8VXUzd39fWQL+tDSLXv8k0KFWyVUwHosCxxkRbGD7rti1yUTm5GI7pAb4qR+0vcv8DTqw0opikkxkE72sF/2XNKcC2bYyXqIYuKCC50LNNm2ljOVRHgwxsoRZIlH1jg319pC7OvPpzu+WmC3AUVBVLTLxeiGab/GC8gF7x8qMCTNqZ3j0aAaWHcUAA9LR1sadiECMlphMO8CREhI1zUKMNXI0Vo6Pr6C+NZwyU1+2BqnghlK2aQOh5emxTymfChdhkq1wSAKK1+GB2SNQf/nu4kWBZo6itLPKwMzOCkDjriZEQimalxv/FUNYGxDvvRrTkdDobWAdA8FwrTuuQsMRzc5zHovi3+BitU6L54WNsbNqXW45ELH5dNHA8JdE79rn4yqWBQemjakdWo+zbfuBTUvzQE3H9GcNVlQlC6pRX9vAtl8fnFszak9oBHVy5BfMOaRcroasY3wYK9cjGB6tidtB52noAeLYalLBlskEOGkHHUqRSKQ4abj2oqusBMljOzmnTckyuXSk6cz6pxA0EGWI+N7GfSu+2QjL+SQqPBo7eEQmfAdJ86JEwElhU4u9JwnyME1/5hEmm+/XLFNGLeeDcl4Va4eyvh+EA4SDrM/Og==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c09xR2RzM25lNEErTkNTSWxHZm42U0FUa2Z2NkNxa1piNEIyd3NUZk4vbzh4?=
 =?utf-8?B?MUNuY2YvTEN1emJhYWFVQk9JOEZHZmg2M1I5L0gvOWtjWW1pSHpjUjhVc3J4?=
 =?utf-8?B?WVlJaThyNjhrOXFNN2VxdXhodVk3djZsbThMS2tUSkhLdVFhdjNMWTFYdXVx?=
 =?utf-8?B?S0J5OWxZWmhpN3VCSTJyV05laDZtRE9valVKSzZFMWxvMUoxZk83anFMYUZz?=
 =?utf-8?B?MjY4TkdWNzlEczk5WkdFUCsvTzAwNHhXZERKMzJuSDltU1N4SnZHSWpTZitI?=
 =?utf-8?B?YUQ1K241WHNoM0hnWWZvRDN3d1JYMnBTNlZXZW1pblBXYVlVZEtUY3lIT2tX?=
 =?utf-8?B?KzRmZ0Y5QU1iZS9hdDl2YnZManI5T0FiRUJsUXo0OHFKZ2VVWDBCWnhnaTcw?=
 =?utf-8?B?bjZ6V01GcmpOVHF6ZWZDdENBNGlZaWxNRXpkc1NaU0d3UUNUbjZnRTJod3BW?=
 =?utf-8?B?ejVjY0gyb2M1cUsvclhGU0lzM09YYUtBV1NxSy82aVRNbm5ISGpGTWR5SlFL?=
 =?utf-8?B?TGRPYml3SHJnbnhUa1M3VlhQNFFSdWZrV0dxOUhrV3EzS0NGUlZ2MnNjeWZ3?=
 =?utf-8?B?TmdMeFlCSW11UUZHZHpmSGdLcUkyZWtNdEZVZCttNUxWQjZNU0VHVUFTRndt?=
 =?utf-8?B?UStma0xESFNSamhYc2xITzlxbWlKcDV1dEFNdzIybmZVejhnZjNUU005RXJr?=
 =?utf-8?B?NUdvMWVKcWtodjNLNHg2WUc4K0dWdzlPeE5RMHVvK0F6YjNjVitYNW9pRnJh?=
 =?utf-8?B?NTJGVDFlVzEza0ZoOE5MZ1FNYXBCZGpjajllOHVEaTdubWZ3eTF6ZGorbTJ0?=
 =?utf-8?B?Z0NTOUFwVWEzV2lBOWdUc29RMjljVjIyeEVKSE9kZVBIYzhsaGFvcG05UFg5?=
 =?utf-8?B?dnRtVld0MnlRczd6SnlzNVRXUk5GYXd0NmVRQTUrR3BHTXpONGFKemRlMWkz?=
 =?utf-8?B?TGdUUnRmTGMzdGFFbnp6ZXpoVHJ1OWpvMHpyUUhMVGk4czIwMmM2a0t0Y1pK?=
 =?utf-8?B?VmNobWMwa3hUWGJ5VlhVbmtHSW5BMXovc08ycitLMWd0S3JBUC9xdDU0ZHJL?=
 =?utf-8?B?Q2VoVEF4dzRXaUpzTlNnak9pM0N6dmRmYVJwc3RBSHdlem1pMGJQS2dTK0Nr?=
 =?utf-8?B?L0xQbkYxNllxR01jd25TREhrRkRtOVpIRVY2QURUWG5ySkNiM1lsWm1JVnh3?=
 =?utf-8?B?L3RURFNkQ0lCVGhpWFNUMlVCKy9JUGVSeGgzNmlZU3BtdUdOalptZ2NuSlE3?=
 =?utf-8?B?YndLcjZ0dVp1eC9FVlp1SDhuN0VvR2NVeVNFb2ZjbDBxWUFvcmhHbWNTbDU5?=
 =?utf-8?B?eUtjYTQ4KzBkdE9MQnpPZmtFOEI3U1BSbDhqU01OTGs5YXBlM1hLcVhUdGVQ?=
 =?utf-8?B?cFFOWFU3cnZXWjNOZTF6RGM3bnJEb3JBMW1ZQlVBWXBNRzVZRXgyZGJENW53?=
 =?utf-8?B?S1hqb1lCWTdGRU1qb3pHR1Q5dW8zNjdFT1EzNGozRERjcU1ZTERjZldhaEJ3?=
 =?utf-8?B?eEE2WjN1QnVzZ3ZjZjh5NlJkZ3R2bGowcDFXdW1mQSt0OC9WdzNzY0YrOHhv?=
 =?utf-8?B?VEFab3RBb0UwNUpKNzBUQytLS0UrN1RNTzVXWThydDJkTlc1SEEzZHkxYmZh?=
 =?utf-8?B?YkNreEZwMFBSY3JjSmN3bHJnNWVCZkxwTTBpcWpNeElqVjl5OERiV2tueGQ3?=
 =?utf-8?B?TWNsdnlVbWN5SFNnSUZIRVlaUENWL2pyemNQVU1NNTBsY2ZHREp5UTdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <558D9CDF6300D7439111DC46510D7233@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f76e45e9-1d8a-4303-ecc1-08db0b4107ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 08:30:13.6401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7185
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTAtRmViLTIwMjMsIGF0IDEwOjI2IEFNLCBUaG9tYXMgV2Vpw59zY2h1aCA8dGhv
bWFzQHQtOGNoLmRlPiB3cm90ZToNCj4gDQo+IEhpLA0KPiANCj4gc29tZSBjb21tZW50cyBpbmxp
bmUuDQo+IA0KPiBPbiBGcmksIEZlYiAxMCwgMjAyMyBhdCAwMzo0MzoyNEFNICswMDAwLCBBZGl0
eWEgR2FyZyB3cm90ZToNCj4+IEZyb206IFJvbmFsZCBUc2NoYWzDpHIgPHJvbmFsZEBpbm5vdmF0
aW9uLmNoPg0KPj4gDQo+PiBUaGUgaUJyaWRnZSBkZXZpY2UgcHJvdmlkZXMgYWNjZXNzIHRvIHNl
dmVyYWwgZGV2aWNlcywgaW5jbHVkaW5nOg0KPj4gLSB0aGUgVG91Y2ggQmFyDQo+PiAtIHRoZSBp
U2lnaHQgd2ViY2FtDQo+PiAtIHRoZSBsaWdodCBzZW5zb3INCj4+IC0gdGhlIGZpbmdlcnByaW50
IHNlbnNvcg0KPj4gDQo+PiBUaGlzIGRyaXZlciBwcm92aWRlcyB0aGUgY29yZSBzdXBwb3J0IGZv
ciBtYW5hZ2luZyB0aGUgaUJyaWRnZSBkZXZpY2UNCj4+IGFuZCB0aGUgYWNjZXNzIHRvIHRoZSB1
bmRlcmx5aW5nIGRldmljZXMuIEluIHBhcnRpY3VsYXIsIHRoZQ0KPj4gZnVuY3Rpb25hbGl0eSBm
b3IgdGhlIHRvdWNoIGJhciBhbmQgbGlnaHQgc2Vuc29yIGlzIGV4cG9zZWQgdmlhIFVTQiBISUQN
Cj4+IGludGVyZmFjZXMsIGFuZCBvbiBkZXZpY2VzIHdpdGggdGhlIFQxIGNoaXAgb25lIG9mIHRo
ZSBISUQgZGV2aWNlcyBpcw0KPj4gdXNlZCBmb3IgYm90aCBmdW5jdGlvbnMuIFNvIHRoaXMgZHJp
dmVyIGNyZWF0ZXMgdmlydHVhbCBISUQgZGV2aWNlcywgb25lDQo+PiBwZXIgdG9wLWxldmVsIHJl
cG9ydCBjb2xsZWN0aW9uIG9uIGVhY2ggSElEIGRldmljZSAoZm9yIGEgdG90YWwgb2YgMw0KPj4g
dmlydHVhbCBISUQgZGV2aWNlcykuIFRoZSBzdWItZHJpdmVycyB0aGVuIGJpbmQgdG8gdGhlc2Ug
dmlydHVhbCBISUQNCj4+IGRldmljZXMuDQo+PiANCj4+IFRoaXMgd2F5IHRoZSBUb3VjaCBCYXIg
YW5kIEFMUyBkcml2ZXJzIGNhbiBiZSBrZXB0IGluIHRoZWlyIG93biBtb2R1bGVzLA0KPj4gd2hp
bGUgYXQgdGhlIHNhbWUgdGltZSBtYWtpbmcgdGhlbSBsb29rIHZlcnkgbXVjaCBsaWtlIGFzIGlm
IHRoZXkgd2VyZQ0KPj4gY29ubmVjdGVkIHRvIHRoZSByZWFsIEhJRCBkZXZpY2VzLiBBbmQgdGhv
c2UgZHJpdmVycyB0aGVuIHdvcmsgKG1vc3RseSkNCj4+IHdpdGhvdXQgZnVydGhlciBjaGFuZ2Vz
IG9uIE1hY0Jvb2tzIHdpdGggdGhlIFQyIGNoaXAgdGhhdCBkb24ndCBuZWVkDQo+PiB0aGlzIGRy
aXZlci4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogUm9uYWxkIFRzY2hhbMOkciA8cm9uYWxkQGlu
bm92YXRpb24uY2g+DQo+PiBbS2VyZW0gS2FyYWJheTogY29udmVydCB0byBhIHBsYXRmb3JtIGRy
aXZlcl0NCj4+IFtLZXJlbSBLYXJhYmF5OiBmaXggYXBwbGVpYl9mb3J3YXJkX2ludF9vcF0NCj4+
IFtLZXJlbSBLYXJhYmF5OiByZWx5IG9uIEhJRCBjb3JlJ3MgcGFyc2luZyBpbiBhcHBsZWliX2Fk
ZF9kZXZpY2VdDQo+PiBTaWduZWQtb2ZmLWJ5OiBLZXJlbSBLYXJhYmF5IDxrZWtyYnlAZ21haWwu
Y29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZlLmNv
bT4NCj4+IC0tLQ0KPj4gZHJpdmVycy9oaWQvS2NvbmZpZyAgICAgICAgIHwgIDE1ICsNCj4+IGRy
aXZlcnMvaGlkL01ha2VmaWxlICAgICAgICB8ICAgMSArDQo+PiBkcml2ZXJzL2hpZC9hcHBsZS1p
YnJpZGdlLmMgfCA2MTAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiBk
cml2ZXJzL2hpZC9hcHBsZS1pYnJpZGdlLmggfCAgMTUgKw0KPj4gZHJpdmVycy9oaWQvaGlkLWlk
cy5oICAgICAgIHwgICAxICsNCj4+IGRyaXZlcnMvaGlkL2hpZC1xdWlya3MuYyAgICB8ICAgMyAr
DQo+PiA2IGZpbGVzIGNoYW5nZWQsIDY0NSBpbnNlcnRpb25zKCspDQo+PiBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9oaWQvYXBwbGUtaWJyaWRnZS5jDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9oaWQvYXBwbGUtaWJyaWRnZS5oDQo+PiANCj4gDQo+PiANCj4+ICt9DQo+PiArDQo+
PiArc3RhdGljIGludCBhcHBsZWliX2xsX3Jhd19yZXF1ZXN0KHN0cnVjdCBoaWRfZGV2aWNlICpo
ZGV2LA0KPj4gKyAgIHVuc2lnbmVkIGNoYXIgcmVwb3J0bnVtLCBfX3U4ICpidWYsDQo+PiArICAg
c2l6ZV90IGxlbiwgdW5zaWduZWQgY2hhciBydHlwZSwgaW50IHJlcXR5cGUpDQo+PiArew0KPj4g
KyBzdHJ1Y3QgYXBwbGVpYl9oaWRfZGV2X2luZm8gKmhkZXZfaW5mbyA9IGhkZXYtPmRyaXZlcl9k
YXRhOw0KPj4gKw0KPj4gKyByZXR1cm4gaGlkX2h3X3Jhd19yZXF1ZXN0KGhkZXZfaW5mby0+aGRl
diwgcmVwb3J0bnVtLCBidWYsIGxlbiwgcnR5cGUsDQo+PiArICAgcmVxdHlwZSk7DQo+PiArfQ0K
Pj4gKw0KPj4gK3N0YXRpYyBpbnQgYXBwbGVpYl9sbF9vdXRwdXRfcmVwb3J0KHN0cnVjdCBoaWRf
ZGV2aWNlICpoZGV2LCBfX3U4ICpidWYsDQo+PiArICAgICBzaXplX3QgbGVuKQ0KPj4gK3sNCj4+
ICsgc3RydWN0IGFwcGxlaWJfaGlkX2Rldl9pbmZvICpoZGV2X2luZm8gPSBoZGV2LT5kcml2ZXJf
ZGF0YTsNCj4+ICsNCj4+ICsgcmV0dXJuIGhpZF9od19vdXRwdXRfcmVwb3J0KGhkZXZfaW5mby0+
aGRldiwgYnVmLCBsZW4pOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgc3RydWN0IGhpZF9sbF9k
cml2ZXIgYXBwbGVpYl9sbF9kcml2ZXIgPSB7DQo+PiArIC5zdGFydCA9IGFwcGxlaWJfbGxfc3Rh
cnQsDQo+PiArIC5zdG9wID0gYXBwbGVpYl9sbF9zdG9wLA0KPj4gKyAub3BlbiA9IGFwcGxlaWJf
bGxfb3BlbiwNCj4+ICsgLmNsb3NlID0gYXBwbGVpYl9sbF9jbG9zZSwNCj4+ICsgLnBvd2VyID0g
YXBwbGVpYl9sbF9wb3dlciwNCj4+ICsgLnBhcnNlID0gYXBwbGVpYl9sbF9wYXJzZSwNCj4+ICsg
LnJlcXVlc3QgPSBhcHBsZWliX2xsX3JlcXVlc3QsDQo+PiArIC53YWl0ID0gYXBwbGVpYl9sbF93
YWl0LA0KPj4gKyAucmF3X3JlcXVlc3QgPSBhcHBsZWliX2xsX3Jhd19yZXF1ZXN0LA0KPj4gKyAu
b3V0cHV0X3JlcG9ydCA9IGFwcGxlaWJfbGxfb3V0cHV0X3JlcG9ydCwNCj4+ICt9Ow0KPiANCj4g
Y29uc3QNCg0KQXJlIHlvdSBzdXJlIGFib3V0IGNvbnN0IGhlcmU/DQoNCj4gDQo+PiArDQo+PiAr
IGlmICh1ZGV2LT5hY3Rjb25maWctPmRlc2MuYkNvbmZpZ3VyYXRpb25WYWx1ZSAhPSBBUFBMRUlC
X0JBU0lDX0NPTkZJRykgew0KPj4gKyByYyA9IHVzYl9kcml2ZXJfc2V0X2NvbmZpZ3VyYXRpb24o
dWRldiwgQVBQTEVJQl9CQVNJQ19DT05GSUcpOw0KPj4gKyByZXR1cm4gcmMgPyByYyA6IC1FTk9E
RVY7DQo+PiArIH0NCj4+ICsNCj4+ICsgcmMgPSBoaWRfcGFyc2UoaGRldik7DQo+PiArIGlmIChy
Yykgew0KPj4gKyBoaWRfZXJyKGhkZXYsICJpYjogaGlkIHBhcnNlIGZhaWxlZCAoJWQpXG4iLCBy
Yyk7DQo+PiArIGdvdG8gZXJyb3I7DQo+PiArIH0NCj4+ICsNCj4+ICsgcmMgPSBoaWRfaHdfc3Rh
cnQoaGRldiwgSElEX0NPTk5FQ1RfRFJJVkVSKTsNCj4+ICsgaWYgKHJjKSB7DQo+PiArIGhpZF9l
cnIoaGRldiwgImliOiBodyBzdGFydCBmYWlsZWQgKCVkKVxuIiwgcmMpOw0KPj4gKyBnb3RvIGVy
cm9yOw0KPj4gKyB9DQo+PiArDQo+PiArIGhkZXZfaW5mbyA9IGFwcGxlaWJfYWRkX2RldmljZSho
ZGV2KTsNCj4+ICsgaWYgKElTX0VSUihoZGV2X2luZm8pKSB7DQo+PiArIHJjID0gUFRSX0VSUiho
ZGV2X2luZm8pOw0KPj4gKyBnb3RvIHN0b3BfaHc7DQo+PiArIH0NCj4+ICsNCj4+ICsgaGlkX3Nl
dF9kcnZkYXRhKGhkZXYsIGhkZXZfaW5mbyk7DQo+PiArDQo+PiArIHJjID0gaGlkX2h3X29wZW4o
aGRldik7DQo+PiArIGlmIChyYykgew0KPj4gKyBoaWRfZXJyKGhkZXYsICJpYjogZmFpbGVkIHRv
IG9wZW4gaGlkOiAlZFxuIiwgcmMpOw0KPj4gKyBnb3RvIHJlbW92ZV9kZXY7DQo+PiArIH0NCj4+
ICsNCj4+ICsgcmV0dXJuIDA7DQo+PiArDQo+PiArcmVtb3ZlX2RldjoNCj4+ICsgYXBwbGVpYl9y
ZW1vdmVfZGV2aWNlKGhkZXYpOw0KPj4gK3N0b3BfaHc6DQo+PiArIGhpZF9od19zdG9wKGhkZXYp
Ow0KPj4gK2Vycm9yOg0KPj4gKyByZXR1cm4gcmM7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyB2
b2lkIGFwcGxlaWJfaGlkX3JlbW92ZShzdHJ1Y3QgaGlkX2RldmljZSAqaGRldikNCj4+ICt7DQo+
PiArIGhpZF9od19jbG9zZShoZGV2KTsNCj4+ICsgYXBwbGVpYl9yZW1vdmVfZGV2aWNlKGhkZXYp
Ow0KPj4gKyBoaWRfaHdfc3RvcChoZGV2KTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGNvbnN0
IHN0cnVjdCBoaWRfZGV2aWNlX2lkIGFwcGxlaWJfaGlkX2lkc1tdID0gew0KPj4gKyB7IEhJRF9V
U0JfREVWSUNFKFVTQl9WRU5ET1JfSURfQVBQTEUsIFVTQl9ERVZJQ0VfSURfQVBQTEVfSUJSSURH
RSkgfSwNCj4+ICsgeyB9LA0KPj4gK307DQo+PiArDQo+PiArc3RhdGljIHN0cnVjdCBoaWRfZHJp
dmVyIGFwcGxlaWJfaGlkX2RyaXZlciA9IHsNCj4+ICsgLm5hbWUgPSAiYXBwbGUtaWJyaWRnZS1o
aWQiLA0KPj4gKyAuaWRfdGFibGUgPSBhcHBsZWliX2hpZF9pZHMsDQo+PiArIC5wcm9iZSA9IGFw
cGxlaWJfaGlkX3Byb2JlLA0KPj4gKyAucmVtb3ZlID0gYXBwbGVpYl9oaWRfcmVtb3ZlLA0KPj4g
KyAucmF3X2V2ZW50ID0gYXBwbGVpYl9oaWRfcmF3X2V2ZW50LA0KPj4gKyAucmVwb3J0X2ZpeHVw
ID0gYXBwbGVpYl9yZXBvcnRfZml4dXAsDQo+PiArI2lmZGVmIENPTkZJR19QTQ0KPj4gKyAuc3Vz
cGVuZCA9IGFwcGxlaWJfaGlkX3N1c3BlbmQsDQo+PiArIC5yZXN1bWUgPSBhcHBsZWliX2hpZF9y
ZXN1bWUsDQo+PiArIC5yZXNldF9yZXN1bWUgPSBhcHBsZWliX2hpZF9yZXNldF9yZXN1bWUsDQo+
PiArI2VuZGlmDQo+PiArfTsNCj4gDQo+IGNvbnN0DQoNCkFyZSB5b3Ugc3VyZSB5b3Ugd2FudCB0
byBkbyBjb25zdCBoZXJlLCBjYXVzZSBvdGhlciBoaWQtZHJpdmVycyBhcmUgTk9UIHVzaW5nIGNv
bnN0Lg0KDQo+PiArDQo+PiArc3RhdGljIHN0cnVjdCBhcHBsZWliX2RldmljZSAqYXBwbGVpYl9h
bGxvY19kZXZpY2Uoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICt7DQo+PiArIHN0
cnVjdCBhcHBsZWliX2RldmljZSAqaWJfZGV2Ow0KPj4gKyBhY3BpX3N0YXR1cyBzdHM7DQoNCg==
