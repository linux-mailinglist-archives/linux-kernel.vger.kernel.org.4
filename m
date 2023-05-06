Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E844D6F926B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 16:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjEFOH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 10:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjEFOH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 10:07:57 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2099.outbound.protection.outlook.com [40.92.98.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9191886B;
        Sat,  6 May 2023 07:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nj5ADgk0dwlpWpmkzIPdlEmryVP/SeJQKQJzcGCfrn+2+VrYP5dqrWBdsESY4VtcqRBo9V3CncPSR1ZDDjULTTNY0KtVbEqns2TAIn/qKByhXakweEPuEdWmbFTx5m8UdF9DvsCu7cEKxIimDzzWE3oRlzmhRNNxdtE0bZkvflEcefOWOs8UpouTqZVrnYe4wKQ7Zkfmc8MA8/oFqpWdimwT+gHO/ppWqILzMnbUHXwwV1WQEnKER+c53Ggja70x5bfplm51rjS99t7LcN6WPmnmQRSkEipdPAuW5Plfz7HOc0+abqfGWs5xaJEpvTGL1R+YBQ33uFpYU0oTUSFZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhHMWNwnu/7w4eoV7qK6OCQmLj1Ugbb1zKw56gd+IKo=;
 b=a+fTeoPjuVrW0VjAWe4QXDCfW4PEMTgopP9gAJBzpw8pkH2CYRk6FnzIJTDgm0EbJa0vSSrQdss9LwJegmFV7rfoh0V+MZ7IlSVFNxeK0eBmbkSJzWjZqQ7/2nGs8y6nFKCGaZMc4R0TMDVwzC7J5fBDJBSmXyFRxRtqslSwe9EaSc1zymvb0FhLFUoBKlROF5xnYl0EeqzE6lBh3rSADZi6Wai7picGX3PMS89McYZzQGBcz4a80nxCfd+snXgvvzg1bZigQ8S72JDfVpkYrOZMseL0cDX1O82ZlT7Oo3S/1l7uCsId7dDsiUFH36r21DqXU+sMNGNdC96D4ExZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhHMWNwnu/7w4eoV7qK6OCQmLj1Ugbb1zKw56gd+IKo=;
 b=byv0Wxro4uWEvTCuJucV/tEbAYFl00+usbSyWe3Ot9d+/jyPt40ElN0EO2lbcAiwukUYofcdE5o5MzUbZ8VZxISrouZg2HIAgymA7g8WETmgVtNr29z0WkWuRClHotU7e6eKVkej+ytjhrFvGirYVi1kxkm98Mt8WanWSLFVyGDyNlhxc1E1te1EfZmihy+Pubs6vC3LEYrJJnJ2ZhHeRD23kwQbAx38NAMU3XSmNxiMcfKHj5vprOpgF+QAlBf7HhyU+FcTAv5LG5crCYm4Kczqevhf//+b2Ulr+5ZNnMpNwhmFiS6AoMnqC24aQydvKn0cRCd2rdY1UuWEaa7I9w==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYCP286MB1755.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 14:07:47 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639%2]) with mapi id 15.20.6363.029; Sat, 6 May 2023
 14:07:47 +0000
Message-ID: <TY3P286MB2611B62D9408B6D136A8676498739@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Sat, 6 May 2023 22:07:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     wiagn233@outlook.com,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [RESEND v2 5/6] soc: starfive: Add JH7110 AON PMU support
To:     Conor Dooley <conor@kernel.org>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-6-changhuang.liang@starfivetech.com>
 <TY3P286MB2611D930A36FDC4EA431D77398739@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230506-doorpost-cranberry-59a46968f15e@spud>
From:   Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <20230506-doorpost-cranberry-59a46968f15e@spud>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5Zr39SwSepbLUvbgyC7BYeIR"
X-TMN:  [U1IhNdN8U1PfPmP71X5U9VYflYWLg+Wn]
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <7232e00f-66e4-5acd-2b0d-58be2809ac7b@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB1755:EE_
X-MS-Office365-Filtering-Correlation-Id: c6078bc3-3fc6-4c5d-a6da-08db4e3b44dd
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmqqMbmmUl3hm7hc0TrACvCbsI/D/6WajLLmZFonntBvLupmHz2ltYl7bZiWeXqDwj4iJWSOBfkkfWwSQERKjwY8z8aSqV7qLfkbu7YpSzuaQ4zHlP3bikJqHAPGXN3PWtX8hPZSL5YcKYeSO8qVwLF/qvuFsdt2ZI0AXl276tH7d7aKfAICBzeJJrfc+K/XgksL4EOZlscuaew3DmzFVXUcu70AgRVDpllm3YDJxfAYp9/hUVUp0gTnYguDMn88FEvLzNZDqfV2MnCZsO1RabsoStn5+zvA+acvizI9Axn7jcOKNkQyZsbFqIX55FDeUAIqFUWaGRzrb3NRBR1zXsdf8j72Uq4diuIyyVGS2O1oQCjBC0pvsM5ZZINq07Xc+HROZbc8+Xo/NBuWp7/rIrg9pAU+v1YNCvW2j9fQdQYY+SMmLTSdetGJBFrvQ/qxwj0R5SPAqaOX0y35+u8vWbMvSYAygmxR5g0BJp2NWc2Izu788sWQP/I9ZWTjzCszDOdMrSTU7QaZUg1vaTwh9BT17gVOun9uMwYq/mvOCi2fZTso1qFaq2pAeECpwfXsD/RVu0ijtzGhmW5K7tbxrYnt7OkQB5n5sJoJ4ptjOPBYWgN1Zr0VSASM6mXg0ZNV5OBkWUwssuEuraMIbEIwUij78WipH4U3itVk2raw3XUuvpkX3N4v2LckV13upLzXB0bWVYW1nbM247OhWkU363+MeRimG3QQA8wTDTUjCCYh7obvLZT86WJt4NLB3uBzxRY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: doxKN1c9MR+fuIfNXdoh4l9oJZcY7zc4EP95WUwkhwIA7yDzemRLVpfIt5GaRgql5D8pKV3NHwfyoRCXw6Cje+UEPqwRvKYVfnZ0fF8GiWPsPY530JzUZgCj06BaHYFZpazXLNTbe7/dQ/TQDpkWv+KwyJtToUYkLzuC5C/iEiHC/GpC8M9w/Dkq3pR9C9Lqr8kMKV6zduKGPRjCDhaRxb6mC6r7ZjBhz+rnyjUl0tUVwvjuWAMH6eRgslqEuzZ1J3PNgEHOecW/UWdTfvfXkUC2m+g0TV5kXT2Sz6Hm05yui15wy9asRAwm3FcfhIbdfE0p3zPDDJCMP3ibQkLSO3Gj/3sESX6kQF52d9EEFF3j3BKr0xcjDK2rdAT0+0ZUBKeDbqzybYf34Z2JVdBv40cNmNIlrZaZR+Kr2llEa0KZOyzjbBeXYaUOZB4GA9KCxneZpyTpZwXBwCL5FwIMz3r3rxMGabQBDZgqhkAi329KAmMFn8qlAmiOm6tTUdbo9t8SL6tzIOtF3u4WXBm+I158At4UE8qSSR65IY1OB/IcifrdVmcUACAM53GnottxoGhU98EYE3J3OSmoD9azdKnL337wdUMB3kdSsM6ZdFvKsSRZeMcWiKjjLPtVe8XI+O3HZhSl85rKAUrNeGMf+w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTZGc0hmVFgwWWRzRGpkZWVlc1phNDRzZ2VGb055ODhvY0E1NnA5OVhwcDQ5?=
 =?utf-8?B?MmJyRlBsQ1ZZWFp6cEMxZk0yUzBTd1dqVk83K2RhemlROXgxdmtKWWFlQWtw?=
 =?utf-8?B?djhqYzdSdkxQVHRzYWx5dDg0b09oN1VYTzFxNVBHaGxNUzM1WDNQL0JzK3VJ?=
 =?utf-8?B?RjN1eTNNaHhNbGpZZXp6SXhHUUhmbWk0VkRwTUo4cGVCVFVDYVdUK2JWVnNW?=
 =?utf-8?B?WXJhMUdaalYwM1MxUDBmYVA4OVNzYVV0bVZSTjZrdUF6eXVJN3dSZE9KY3o3?=
 =?utf-8?B?SzdndEszUHFGMjR4VXlMVGthazAxTWx4MUtleW1PTWtJYThPSCt4OTRMU2Fw?=
 =?utf-8?B?TFErMGYwekFPejdYdGJaa0xzQ1EvcmtYeVFReThFTVBYR1pKa3QyWERYWjRM?=
 =?utf-8?B?cXNkaUhMbVNxcG5hbGxid2RkaW1CMEFuWFVQY3BwbUxMa1BGU3hhT20wYWZB?=
 =?utf-8?B?YVpQU1JnSE5Ca2s3azduNVg1dERqSStWZ1NTdzRZL1VyUW1IYjJkRUVGRHRu?=
 =?utf-8?B?R3phcWdvTk9LMW1tOVJFcVlraEVlYXJZdHBrOUFXMnB1NnJuUXk0V2lOZ1F3?=
 =?utf-8?B?M0ljVnFOMjIrWFA5UkN0TlFxaWVBRW9ZM01INTJDR1paK3haS3ZpVFJ1Tjh0?=
 =?utf-8?B?KzNtOHB1WXdsQUxqWlZIdHhKWjJGQ2UvN1lKeTVDZFdjeFVrOEZQOWpnWXRq?=
 =?utf-8?B?THg1VG5RazI4c2NIcFVGdzRlcUxhM0cwSzJGclgveEhNV3JrNlh5WVJidTRa?=
 =?utf-8?B?TkVtaUxsaEtydEZZU2NHT0JibG5OMzJ3R0F1QnQ2Umt1dlJ1Tis5MEltOUt0?=
 =?utf-8?B?dVFNcFNlWWdBL3dEWXdQRU4xUlo4UWZodTQ3b1ZtMXBjQUV3KzI0M3pScmsv?=
 =?utf-8?B?Vzg3cEhMcUJkdWFOOGdFVjBLVU44YmZmYisxeHdENHkrTHFEZXNFczNzeDZS?=
 =?utf-8?B?dUFoKytocHZGSTdSeGJNek5xTFlHK1RwbVF1L3V5akRmcFJMa3JGRjN3UXJU?=
 =?utf-8?B?Ynd0REk3U0R4VDZCd1BxMmlNT29rRlZxK1lOSjRDYlJUTVJLcDBqUFp6SUdI?=
 =?utf-8?B?UGtGYVJ1WjJLRUU1bU9iQ3BiWW4ySVVtbW9VcEQ2NStncWNJWDd1MEhlbXJE?=
 =?utf-8?B?RFBNaUhOMERtWGN4MlRlRGovL3VKK1o4azNXY1RsQzB2KzZybjF4TGU5WXhm?=
 =?utf-8?B?WmZwTjlSOHQ0V0swa25NK2tlVGVlV280WlVlTHlIYXVQWW5OeVoyb3VsTUdV?=
 =?utf-8?B?Z0FwdEpPYnFYeEVwTy80MjJmZktEWmNkSzhjSkxTSDBldHVHWWNJemNOMU54?=
 =?utf-8?B?cXJEWDBTWHZHSE10RXFGZXNJL2xWalAwMHVJWHFnZnBXMGdiWDVnanF3Z09i?=
 =?utf-8?B?Qi9aaEhnVlJkS045YitxUGUvWmJLUnZDZlI5ekI4RDNtNDVVODI0bkpSMEpC?=
 =?utf-8?B?b2Fud29VL25CS2FUWUVMaDcxQnYyMk4zUUh2bk5JcVBzZU44cXNiTVhCV1VL?=
 =?utf-8?B?MWpuTitLajRPbFN1cEdjeTlpeWRKV0pGeGdpTHdCWE4wbThKYXl3RUJNY25l?=
 =?utf-8?B?NnZFVkx4ZW5sV204ZU5UY0RyMGl1aGhhcmg0N1ZtWm03dG4yTGRNdVc3SW1M?=
 =?utf-8?B?enlFZ0VWM1l1Q0ZNTkVib0cwdlhsQ3c9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6078bc3-3fc6-4c5d-a6da-08db4e3b44dd
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 14:07:47.2012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1755
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------5Zr39SwSepbLUvbgyC7BYeIR
Content-Type: multipart/mixed; boundary="------------BEFD0CApexPriMYiTTrS3ruo";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Conor Dooley <conor@kernel.org>
Cc: wiagn233@outlook.com, Changhuang Liang
 <changhuang.liang@starfivetech.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Walker Chen <walker.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Message-ID: <7232e00f-66e4-5acd-2b0d-58be2809ac7b@outlook.com>
Subject: Re: [RESEND v2 5/6] soc: starfive: Add JH7110 AON PMU support
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-6-changhuang.liang@starfivetech.com>
 <TY3P286MB2611D930A36FDC4EA431D77398739@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230506-doorpost-cranberry-59a46968f15e@spud>
In-Reply-To: <20230506-doorpost-cranberry-59a46968f15e@spud>

--------------BEFD0CApexPriMYiTTrS3ruo
Content-Type: multipart/mixed; boundary="------------FTtthJSSBGviFUjFNnztpcL6"

--------------FTtthJSSBGviFUjFNnztpcL6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQ29ub3IsDQoNClNlZW1zIGEgYnVnIG9yIHNvbWV0aGluZywgcGF0Y2h3b3JrIGRyb3Bw
ZWQgcGF0Y2ggMSwgYW5kIEkgZGlkbid0IA0Kbm90aWNlZCB0aGF0LCB0aGFua3MuDQoNCkJl
c3QgcmVnYXJkcywNCg0KU2hlbmd5dQ0KDQo+IE9uIFNhdCwgTWF5IDA2LCAyMDIzIGF0IDA5
OjU4OjM5UE0gKzA4MDAsIFNoZW5neXUgUXUgd3JvdGU6DQo+Pj4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3Qgamg3MXh4X2RvbWFpbl9pbmZvIGpoNzExMF9hb25fcG93ZXJfZG9tYWluc1tdID0g
ew0KPj4+ICsJW0pINzExMF9QRF9EUEhZX1RYXSA9IHsNCj4+PiArCQkubmFtZSA9ICJEUEhZ
LVRYIiwNCj4+PiArCQkuYml0ID0gMzAsDQo+Pj4gKwl9LA0KPj4+ICsJW0pINzExMF9QRF9E
UEhZX1JYXSA9IHsNCj4+PiArCQkubmFtZSA9ICJEUEhZLVJYIiwNCj4+PiArCQkuYml0ID0g
MzEsDQo+PiBXaGVyZSBhcmUgSkg3MTEwX1BEX0RQSFlfUlggYW5kIEpINzExMF9QRF9EUEhZ
X1RYIGRlZmluZWQ/DQo+IEluIHRoZSBkdC1iaW5kaW5nIGhlYWRlciBhZGRlZCBpbiAxLzYu
DQo+DQo+IENoZWVycywNCj4gQ29ub3IuDQo+DQo=
--------------FTtthJSSBGviFUjFNnztpcL6
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------FTtthJSSBGviFUjFNnztpcL6--

--------------BEFD0CApexPriMYiTTrS3ruo--

--------------5Zr39SwSepbLUvbgyC7BYeIR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmRWXysACgkQX75KBAfJ
sRnQtQ/+JpZjuFt5vuuQ4oTLQbTxuwpVAjn2ympwfzQ6N+thiOs5/etVeopAHuqV
FSa3I/trRZiP+2Mk0xg0UbFy7L92ZlIW+ViwlRVs7msTSemuJ2R8G3XPtbfVbhW1
52g/kDRxIO9byz/fgxkc9EAQMsZhfDBhG56twePtUH/I4LJILgThPEr2L+N44l11
eH4d8MPslBbkOmjNxzZ0iyKxtfKTKNUiyPJKDe6n+tlzlKjcb1dvqN6/OXa93GIt
FY9C/nr51kHF3JJQQ3xoIkwEYCcnDe5fa+3bcn6BuwqK35phgI6nWA9AbtA5Lyxq
CxHDzFqFBgAzJRPft1ifCQTpDF3Z0cg0p7dHwGRT5RdvsUbB922fyxZ9cUGXkD8t
dit/2WAOkmLjx0H2ZGqIYtcVR7PEaadEXLfXdGyvav5c4BeF+2Tw9bvVfbMXnwlu
RIz6L1/wY1bVCycHEec7buJc2pJQgWV0XIMQdH2yUKaaSTR1npeurafnzDLcS7uq
wQCnXEHeqgdf0InmXgMvhtQoTUvh00TgwTJmPtJ2we/cHRR1jU9O8GQPv9e6t7qt
UjHdLG2/0KJ/nA6MbU+fV9LvbjwpOr84YSqZOTgcukALR90DkgnnZHAdhbtRpU3R
AORKvUKppCJXB/yuakc4TrTYHtCnAsrgtu5RM29+Hh4cs3UOsYg=
=/+kr
-----END PGP SIGNATURE-----

--------------5Zr39SwSepbLUvbgyC7BYeIR--
