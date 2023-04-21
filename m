Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFEE6EA716
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjDUJfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDUJfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:35:45 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2014.outbound.protection.outlook.com [40.92.99.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EC7AD25
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+jVsEBXqGs1myzUt0FuMuOMZdZlq9MCjYfdajm6AcEbxwYvE9koTrWNkaqO3gA4oSvIzc4lfc18T7Nf/DKBGyvjKwndcz693MU/q2ysSnMJVsoAh1AFjG5n0Un+ZKj5hPNdrQIVbsy1oOjdMHdIE/julswl8jL4sonxY89vc3Eure3nKkhJPOgAWpZ7NFgEywUfZlP/vgBEwz6912yH0V4vtXM79KErsNauxAjYNdrIpQhEDkprUuDX5PuCIyng6esK95L+jfNIwAELWdWBr+w73KOadD/CWTHvGkY19nZVO4+JhcmB4hFxpKeOjO0/rTKS6tDfAzMD1JogJnlG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0V+JHbjBrPs7dwmYs8kUdC6/BVtn8XPN6HSHWgXwVKM=;
 b=h2j8lP6qu7E6LlhYwppFWUyxGBn8A8JDzW1bfwbEjtVJJ6S6hdmVItqIOqtx2EOX8dICodiw45cU3aCWWDkBE85TPLVvtCs8/tfojOGpuc2kXLHQtKfW5/i7kUTtse8gKeukk1uTWbKS+jSpMwTNvbOEsp/hwoGdAq/AVoKiX/FX9SXy0KzIVRWXqWAvc+gh7thHP0x5gD+/rVenmOm1x0fc72E3rdcq6hsEVWORc/v81Jr6P9Xb0rLkyPGyyXPXQH4cn6wMXFWnpdItQ44nCfrO4Yf/bo/qLDdzCaqBbtrkZtOLty/w22ZiuD+nfuRB8k344hZBLS6dz6q9FtTKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0V+JHbjBrPs7dwmYs8kUdC6/BVtn8XPN6HSHWgXwVKM=;
 b=H/RcSEukrWr7qlzGWPeztgq+JfsnOF3hI64caiL8dh6TlmDQLfaZyyw+uSIsldhXevJAohDSQfWaWhJE6jq1y/B8gSL88u91fqz1y7zXw9alzazwxU/FAoG9ABpO6Xa96InDYmBldBGDGPfwq/szJUdCABZa0nLn8DyP/TAA6CG5AgkXqDkQcHbypo0hSdL5XkEhd23M45+m2DVQp1W7LG3ZtrrxdQomzdtvDRS0TZrEuG/bGQdV7xO+BwvOUEg7sXPnfADe30/4MxKTuIRIKTliOM4EO4Be1XUdQTSOYlSL8g8iBQoZ8mYHGIEKcABozTaH082ymK+dCkjFXbHxqw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OS3P286MB2710.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 09:35:32 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639%2]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 09:35:32 +0000
Message-ID: <TY3P286MB2611E7B758E6C2208925127E98609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Fri, 21 Apr 2023 17:35:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v10 2/3] mfd: axp20x: Add support for AXP313a PMIC
To:     Lee Jones <lee@kernel.org>, Andre Przywara <andre.przywara@arm.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Mark Brown <broonie@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230401001850.4988-1-andre.przywara@arm.com>
 <20230401001850.4988-3-andre.przywara@arm.com>
 <20230421073137.GM996918@google.com>
From:   Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <20230421073137.GM996918@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Qy4Mamr8EZqfsyxo0pGxH4N7"
X-TMN:  [pAb07HyuE7aVydAiK5Isl52t0MK3Vk7B040aLL02xSQ=]
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <a49b2d2f-bb3c-f5ee-3193-19c83287a82a@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OS3P286MB2710:EE_
X-MS-Office365-Filtering-Correlation-Id: cc40261d-c44f-4c51-8111-08db424bc048
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 62BzlJ02yXlEbZ18+slmI8a7b7VDGP/VaFRSOyXOLR2yTchne7vSyNgfoSbVnLzft0KFoaq3Nt8wj+uQUawHAwbwMuMUJU57SnOhVVWhnpoWRN9Ac61Mav5aqyMsVO8eK1E9iAaRr6iS1LVPiWhiZYl2AbtUWHAxbrluU0vZVbBVy0AbrnUIsUqfVyhVUkYQdqe6xINaqzfr/eOnbHkOai355M6xHRJg0vVmEgm8COhENXh4wq7g8iS76VLMxpFBig+/VppBSOiEOJbw0xBGRZcHRMv274NI857DK1YaHLs9/7P+5llSWrYNOXOCWfEurzDVbb7X+KvVjg8XFvWI83ZysZcqxSYT3xKOq/7lus0SO867RXjkEZj+yiwkGcB4RsB+5/LZHQRxu7UMXjPsugdhxnhqbHA4rnUQiEQjNeZzFtMzPiHJSxAlgc46it9GPogrtrm8/nZJIeIPrSpgM9rc8KLBvm9M72+7EYdg5+cT2QM9pf/+Xvo1tUIzi/pPB3bzmjO68f8JZ0pGXFNil9zfK7Y7idbqK3gyJwiX+lMPQVcrDV5iY2gzehmNcexYZ+V/snzqQ27OcMfwO3EInjyE9GTSGQ66knB3UNtNcb34arp5s0tc1rw8Fl0f33ow
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXlSd3QzWkQ5d3N3a2h6N3ZPWnBEbGdrVURRbzZpYjFCVGpQdkZTMmUyVEdQ?=
 =?utf-8?B?ODZ5TzJVWGFEL3pjdjN0N0twL1FLWjg5Vk44eW1oN2Rsd21hYW10bXpmRHNx?=
 =?utf-8?B?S0V3enhKUFhmVE5oN1VGY1dwblFWWXN4eFV3cEZRMFFXakdILzlNaGZ4d3VU?=
 =?utf-8?B?YTE1Tmd5NERNaFUyRm8za3ZRZVZuemtpVGFOWkRxeTA1ai8xWDFSa2tWdThO?=
 =?utf-8?B?Y2UxS0kwYUlLZlhQejg3b2lMa0c0SkF1ZHM1NWhKSmJ6dW10bDlxOVY5V21l?=
 =?utf-8?B?V1VjemVVMGtDdG9ocEtpWE5FVzJBY2RwaUdwd3pnTjBYQlFSMHRjaWcvTTRu?=
 =?utf-8?B?OGRUT21laFR0dGtzUFFZL1FrbXBzNWlpa2ZDclVGYWd3ek1yK2VxTVZrWUpa?=
 =?utf-8?B?RjRIaWFBZDhWdHhSbCtyaThZc0RZZ2FseklDblFzWm1uMFlnMzBCNDZBSlVw?=
 =?utf-8?B?Z2VJMnZpSWN6dTdiT0dkR0M3Vk4xaVVCK0NLSFBtemx0OWtnaVcrd29lM2pJ?=
 =?utf-8?B?SVY2NXZpVUZBaHoxR042OTc5aDhpblNVTHJFWUhPVDk4NWtaY0IvYS9zcHZm?=
 =?utf-8?B?Z3Fkb3R6UFg2WkszLzl5d2pRUEJUck9BVlIyOUthb0w1NHpoYnN6Zk5sSXhG?=
 =?utf-8?B?aW92dTF6R1E5Y3FucUx4STRmQVArcnN5b0NIQkdBNjZsQjlZYkh0elhicHpJ?=
 =?utf-8?B?dGZMaVlNdkNyN1VaNU1NaFFKcWc1TXFwaW13VlUyQ0dITDRaMGJGWXpoV2RD?=
 =?utf-8?B?ZVFqbXJPVG5MMUplQXBvT2djR1hqdSttUlREVEhUQ2puaTFRK01hc2ozNkRK?=
 =?utf-8?B?cGlqS0NoRktUamp4U1lmcEhrWmNaVWFaVWoyb1pxeVhVcFRlMXVoT2pGTnk1?=
 =?utf-8?B?bU5rb1NOSzBVcHJIUzIyWnZlZXIyOGVIMVhubFVsRC9sbExENU1rWHBpNUVa?=
 =?utf-8?B?c2hkbU1wTGlCUGFqMTFqblppTzFBbUpCLzZ1c1lIMkFYOUhHaStmYzVBd2lx?=
 =?utf-8?B?NHBFQVBtKzFpU1JxV2dSNWgzVVdhNEVHM1JMTGk4TXp5dEpLUlhaSkdSbXA3?=
 =?utf-8?B?M1FJdVRoYTlKRkVXRGtiUHdPaWpMdVRRaDF2Tm5jRzdBcDlKL0hsUnZvUEox?=
 =?utf-8?B?WFRRYmFCcERWalhwUVdjWlJOVjFDVWNSR3A5U0hweTYvTG5GQWViNms0TkND?=
 =?utf-8?B?cnFXek0xc1lPWTRtejlyTS9IelRQR2c3TDNTRkpWcEdyVGk1YVU3WHFPK2Zt?=
 =?utf-8?B?cEd3OEVIaDg5OWE2Unc4cm53KytsM1REMDlrYndQVU9wK3RzajlkRDZUM3ZK?=
 =?utf-8?B?RWM1TzVWUjNtVWVQT2xpdXVXcVIzYlorTmczVzRvalJYRmlGUUQzQ2FQd1ZU?=
 =?utf-8?B?ZGxWMXFFZFUxbEJ6NHNUTVB0c0RrZnBIUGFEMEt4WmZGOGtxSmNqbnEvR01O?=
 =?utf-8?B?RmxhSC9lZ0VaTzdRYzNmUmJNc0Roa1A2THBKMVhHTTJDenVBV1RSd2xOS1lv?=
 =?utf-8?B?UXlETVhMU2hkaVZMWjRqRkxiMi9TWlRBQWsxMTZUVUFKTS9BZ1hxRkw1cklm?=
 =?utf-8?B?OUpTT1E2Z2FuNDVmYml4OGVpTFZBaWJKenl3cm1hVlN6OEpHb0RxTHNtNkNI?=
 =?utf-8?Q?4bwahrxGarUhI7nAMdWy6svoTnMC2GLKUr6FqOasFW1E=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc40261d-c44f-4c51-8111-08db424bc048
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 09:35:32.2837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2710
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------Qy4Mamr8EZqfsyxo0pGxH4N7
Content-Type: multipart/mixed; boundary="------------EV0XuPfrAvbh1dWQbhhhHx3y";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Lee Jones <lee@kernel.org>, Andre Przywara <andre.przywara@arm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>, Martin Botka <martin.botka@somainline.org>,
 martin.botka1@gmail.com, Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-ID: <a49b2d2f-bb3c-f5ee-3193-19c83287a82a@outlook.com>
Subject: Re: [PATCH v10 2/3] mfd: axp20x: Add support for AXP313a PMIC
References: <20230401001850.4988-1-andre.przywara@arm.com>
 <20230401001850.4988-3-andre.przywara@arm.com>
 <20230421073137.GM996918@google.com>
In-Reply-To: <20230421073137.GM996918@google.com>

--------------EV0XuPfrAvbh1dWQbhhhHx3y
Content-Type: multipart/mixed; boundary="------------PPMhgdyUn5Rd0qPjPo7LdRq9"

--------------PPMhgdyUn5Rd0qPjPo7LdRq9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8gTGVlLA0KDQpXaGVyZSBpcyB5b3VyIGJyYW5jaD8gSSdtIGdvbm5hIHJlYmFzZSBt
eSBBWFAxNTA2MCBzZXJpZXMgb24gaXQuDQoNCkJlc3QgcmVnYXJkcywNCg0KU2hlbmd5dQ0K
DQrlnKggMjAyMy80LzIxIDE1OjMxLCBMZWUgSm9uZXMg5YaZ6YGTOg0KPiBPbiBTYXQsIDAx
IEFwciAyMDIzLCBBbmRyZSBQcnp5d2FyYSB3cm90ZToNCj4NCj4+IEZyb206IE1hcnRpbiBC
b3RrYSA8bWFydGluLmJvdGthQHNvbWFpbmxpbmUub3JnPg0KPj4NCj4+IFRoZSBBWFAzMTNh
IGlzIGEgUE1JQyBjaGlwIHByb2R1Y2VkIGJ5IFgtUG93ZXJzLCBpdCBjYW4gYmUgY29ubmVj
dGVkIHZpYQ0KPj4gYW4gSTJDIGJ1cy4NCj4+IFRoZSBuYW1lIEFYUDE1MzAgc2VlbXMgdG8g
YXBwZWFyIGFzIHdlbGwsIGFuZCB0aGlzIGlzIHdoYXQgaXMgdXNlZCBpbg0KPj4gdGhlIEJT
UCBkcml2ZXIuIEZyb20gYWxsIHdlIGtub3cgaXQncyB0aGUgc2FtZSBjaGlwLCBqdXN0IGEg
ZGlmZmVyZW50DQo+PiBuYW1lLiBIb3dldmVyIHdlIGhhdmUgb25seSBzZWVuIEFYUDMxM2Eg
Y2hpcHMgaW4gdGhlIHdpbGQsIHNvIGdvIHdpdGgNCj4+IHRoaXMgbmFtZS4NCj4+DQo+PiBD
b21wYXJlZCB0byB0aGUgb3RoZXIgQVhQIFBNSUNzIGl0J3MgYSByYXRoZXIgc2ltcGxlIGFm
ZmFpcjoganVzdCB0aHJlZQ0KPj4gRENEQyBjb252ZXJ0ZXJzLCB0aHJlZSBMRE9zLCBhbmQg
bm8gYmF0dGVyeSBjaGFyZ2luZyBzdXBwb3J0Lg0KPj4NCj4+IERlc2NyaWJlIHRoZSByZWdt
YXAgYW5kIHRoZSBNRkQgYml0cywgYWxvbmcgd2l0aCB0aGUgcmVnaXN0ZXJzIGV4cG9zZWQN
Cj4+IHZpYSBJMkMuIEFzaWRlIGZyb20gdGhlIHZhcmlvdXMgcmVndWxhdG9ycywgYWxzbyBk
ZXNjcmliZSB0aGUgcG93ZXIga2V5DQo+PiBpbnRlcnJ1cHRzLCBhbmQgYWRqdXN0IHRoZSBz
aHV0ZG93biBoYW5kbGVyIHJvdXRpbmUgdG8gdXNlIGEgZGlmZmVyZW50DQo+PiByZWdpc3Rl
ciB0aGFuIHRoZSBvdGhlciBQTUlDcy4NCj4+IEV2ZW50dWFsbHkgYWR2ZXJ0aXNlIHRoZSBk
ZXZpY2UgdXNpbmcgdGhlIG5ldyBjb21wYXRpYmxlIHN0cmluZy4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBNYXJ0aW4gQm90a2EgPG1hcnRpbi5ib3RrYUBzb21haW5saW5lLm9yZz4NCj4+
IFNpZ25lZC1vZmYtYnk6IEFuZHJlIFByenl3YXJhIDxhbmRyZS5wcnp5d2FyYUBhcm0uY29t
Pg0KPj4gQWNrZWQtZm9yLU1GRC1ieTogTGVlIEpvbmVzIDxsZWVAa2VybmVsLm9yZz4NCj4+
IC0tLQ0KPj4gICBkcml2ZXJzL21mZC9heHAyMHgtaTJjLmMgICB8ICAyICsNCj4+ICAgZHJp
dmVycy9tZmQvYXhwMjB4LmMgICAgICAgfCA3OCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLQ0KPj4gICBpbmNsdWRlL2xpbnV4L21mZC9heHAyMHguaCB8IDMyICsr
KysrKysrKysrKysrKysNCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMTEgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiBBcHBsaWVkLCB0aGFua3MuDQo+DQo=
--------------PPMhgdyUn5Rd0qPjPo7LdRq9
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------PPMhgdyUn5Rd0qPjPo7LdRq9--

--------------EV0XuPfrAvbh1dWQbhhhHx3y--

--------------Qy4Mamr8EZqfsyxo0pGxH4N7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmRCWNEACgkQX75KBAfJ
sRm1DQ/9EcIfy5rWH6ItsvdU/PX25PtH6bV7rLc3LxfP/agXaa68/felizuKNrEx
eWuj3eOk/u86DBCJv9KcFA6BsnnTivMo+0JrroU6wvyjG8KlrhGfOGf+gebxk0Za
Y8nbZ9IAZQB6Y0URibCWpzEc94tC9/j9zFFOEh2W46ot5Rhni92VF4Lfwuout2vn
NDHF83ujpYPVeOXMIPWwd+yDY0z2y4zU7M0L/S1BYigf7bRYGcLLVJak79yq5cYV
kPxBdI7RqS4AlgbunDctUe+gl7alE1sarF9wsvosF9J2tRwrOP3AH9MNY3Wm0Nm1
Bz3TtmXMrEJQvOOwd6oV94cXXaBkqGLCToiBDmmTa4/OAIArN5jSMhmHmnpUT0tv
b8kC37hBiwsmKlXG+9mWfjdLYdtuSO8u/Gno8Azvv/Wh97SoTm8KV7Pm2Hsn8OI3
yE3uc7ANRVpJgnV2AiWIpF9gqULxRoJ9t0JnmE1dI+vghm5tKGbkxfIT9bLJUtnw
mqmkfGhk/Thjz+LHfcdZIDlr1ANRf1v1eVdtAhPdoHynnoEK3srX+TCTk7AZ/YYc
L4ydDURDte2iBu6ImDplo8VkN0K5mlPcHvDRuerEz0BNG9hl6s+8nkhhUa3AqaIO
FOQjKqHfyCNQBbSu7KACvTWJ3PC528VGt1g0c4o4WXTbEczXTYc=
=C1To
-----END PGP SIGNATURE-----

--------------Qy4Mamr8EZqfsyxo0pGxH4N7--
