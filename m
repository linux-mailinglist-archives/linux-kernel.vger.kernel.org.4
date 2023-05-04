Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00B56F6D91
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjEDOQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjEDOQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:16:07 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2080c.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::80c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3635383FD;
        Thu,  4 May 2023 07:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f387mgaaKU+HiHbHN5SmO/05EhYqlND8GR7Cn6qcVPOdhs0s5xekCyRAWwN5YLAooCoIGzs9m4PYSTqxY82BdcAIkKpoylJ5FISCFwre2tM6FTbaKkPL/NUyDe6qIGCGPHj2s7QWDBvcEH5ZsjtWZg8rVHF2maXkGWGUj95m7qIQq1ADEAbZl9eJ/WGjcArKS8C92hZIVUyTUQuapLifeq9glcy6QH5jk2zbEWevjAA8ANsHE7K+ucod9bjDaytZiBLb915lz9VeN93zLNrZeVu9YR5SLw+BIgmCcMFVvDOmpQXHC8j7QBdVe53B+54r/yuFK5XM1Ze6AnQmmOimyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn8aM/iOlqop1wIUdOpz0u7+SqgKrBcg5DuetY0DXiE=;
 b=Qb8E7lzhPYWp+95ngli/UEsMOdivGuYNHURWvNjIhe3drdmUEZE8/sqDhSPVzDLAMBRyLJt3RqGM9mTBw6qzoIwB8Z15b8BvnKSpR8SS9o45AwIoarb7nF94+Ie/zcQKBGFKKlsUVSUDGAUWuIWbUO3T3Pwfm9Wjf0JcRaMurjtDwUvky8eGyfgGMz1OF4NhRAliGobmapOSnfwPU6fpb0CqPqmCjlLo0QK5X0HexnZOoN03SA/4acQlWMdtuLG0wfmPnfXUGTwRkv+EpQvInXVCXeOjRl03cI3mV5P2ZPmTNDNx5Yo6wf0e9aX7uTG4nWszUV1ry8GmxuAlOHzjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn8aM/iOlqop1wIUdOpz0u7+SqgKrBcg5DuetY0DXiE=;
 b=oLVFaxLvxcLwAhYrWiEhKbZFZea5uYAz365vu2PRKcXYbrIcPvgjBgEIzl3JliBpa0vDsS46WEFAGk73msjs6gRFAef8scDP6NGHQAXjr+DuMuMy1lpJ6efTkrAdCyFyHrwoETYLfKx8AKA5sQSegSr15KbVoLikDxC/KzVShTO54nOOj6Ln+rZUsrQvDRa7d5MITFIRKmfOAnJkEVcwjLPR1R/LxcIy4tUah7V1D3fodkvPWFV+U9+w+G/zPJuAosClnTcNPLdeRWThLwnaIYib+CAKl/tjJNIwbLvZQkd8lxYYl9Xp9ryw27TO3e5r91Bft9UbN1NSJPwpyKdY3A==
Received: from TY0PR01MB5444.apcprd01.prod.exchangelabs.com
 (2603:1096:400:32b::13) by PSAPR01MB3926.apcprd01.prod.exchangelabs.com
 (2603:1096:301:23::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:16:01 +0000
Received: from TY0PR01MB5444.apcprd01.prod.exchangelabs.com
 ([fe80::3f42:e9a0:b922:882b]) by TY0PR01MB5444.apcprd01.prod.exchangelabs.com
 ([fe80::3f42:e9a0:b922:882b%7]) with mapi id 15.20.6363.027; Thu, 4 May 2023
 14:16:01 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH v2] gpio: gpiolib: clear the array_info's memory space
From:   Yan Wang <rk.code@outlook.com>
In-Reply-To: <CAHp75VdFqL4e=awSg0pxnzEYLvWRenTYohRfZ5p-ZOc2B5Lzgg@mail.gmail.com>
Date:   Thu, 4 May 2023 22:15:57 +0800
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-ID: <TY0PR01MB5444D77F48A2BF19F3A44087E66D9@TY0PR01MB5444.apcprd01.prod.exchangelabs.com>
References: <202304232146.7M89pwCz-lkp@intel.com>
 <KL1PR01MB5448327326B6EDA8001AF714E6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
 <ZEk4YNQeYohEwnSg@surfacebook>
 <KL1PR01MB544880BE86B3890E33609C5AE66D9@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
 <CAHp75VdFqL4e=awSg0pxnzEYLvWRenTYohRfZ5p-ZOc2B5Lzgg@mail.gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-TMN:  [Pzso/XucFW6dDeewCU4AbMNLPkl68h0K]
X-ClientProxiedBy: TY2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:404:e2::16) To TY0PR01MB5444.apcprd01.prod.exchangelabs.com
 (2603:1096:400:32b::13)
X-Microsoft-Original-Message-ID: <553231DF-FCE4-4DBF-A9EB-48D3EA5B1F9A@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR01MB5444:EE_|PSAPR01MB3926:EE_
X-MS-Office365-Filtering-Correlation-Id: ade3c397-a6c6-4564-54c4-08db4caa1681
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUrGKgbvctuT7+s6ERSW7LpWNtG2CB8vFkQ1FLnJgMdOYbVVqZ8+dafxGZsjwhS+yXqoGFeBvQjT1OKztrB0OmE/MiM4OMOzRsX+gSIfuUpa/W8PxHfrT3yD+h9nPr/oh7tYO8GlXIC5B7EVAB0QGP4JheWBAvW1ImWd8FrTkA0WrCVK91L+E2k+7cyD/OEkFoZYUkAPtWWdZVe7WrPDjGOfLs4xRJBzUI+EZFDoK4Y1wS4KIbE5P9zTd1Rs2tnODvHNNjyCyXI2OKJdBOQH/BG3QVhxF0Bv5uK4rEJ0giUhvBDhRc5jISMwwZ0HH7BHL5K0AXGvO2TsJTmw7tRXy9EsLADzJ+ZQrwzK9IWxFwlMYIRofCeOxcWvXphAZuS5PNWhTOVxzr9waCiBfuDiYeV6eGFm5US6S4fYwntNS/W6DjJGBob+So9iT+bIsLy+40i8q8N422L0IALw2KcXaduyz8Vg89dLBe+uug4Rt4MDjQbyTKnC5X2OWURFlvXxog8HPdV5CXvViMagPOBLLqIZd/6357Z7buq3KJi3AH0cBL4pwfKDLUdaYKKB6+/gIWM9LxGnDb6PXq9pqF0MTXPeRVsxziLBUQbchg4/558=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blFWTUdjZUtVeWg5N25GRlpJK0pKUVVBOWs1N2tlajhKM2xsOUtsTGhhdWJY?=
 =?utf-8?B?UUpjOGNFUnFhQWJsVjNsV0xCZHc0OEl5UDJ2bEdZVWFzNjMxUUUxSmU0L0Fy?=
 =?utf-8?B?SWh2cVExUTdqWm5XOE1CRDFZSHB6UVRWYkYwN3M4VWptdm9pVkxWcnRYVm5w?=
 =?utf-8?B?Rjc5Z0xkZE9PTTE0cjU5WVN6Mk9BODYrMnNBWk93WmU4d3E4VVNBRXZTSE9p?=
 =?utf-8?B?SUI4MDRNcDBobmRnSTJpeHNvMmNBYTNlcWhtSHFFNmExNWp2Mmt1dnlUNDdz?=
 =?utf-8?B?WFNBR3lIanVhSmxnZ0t2N21TRkFMT2M3ZnMwUzlWYnlqZTJuUnZWUFJqT0l2?=
 =?utf-8?B?cDYvMW4xZmxMOGRFclR1VDZ3WDVyWHk0bjBMWXZTN0czSGo1WldMcEtzN1dV?=
 =?utf-8?B?Qnl3MXZyc3J3QzdNT3ZmT2x5Tm5xaExMWWp1ckFvWkxwbTErTEZLTHNaZmtY?=
 =?utf-8?B?VmRKcVZSZ21VcjJFeTB4T0VsVVBUR0syKzgzZmRUYXRSRkNPQ2pNaFN4UHpI?=
 =?utf-8?B?ZnVvYndFdUtSSU04Zkw4OGNuM0J1bDNVcHk4SjdRMVhPMnJqRlhpYUhoVTN2?=
 =?utf-8?B?MDQ0MmdGOWlvTUx1QkdyTEdsL1BFaDVFTzJxZjdXSjRNOTlsVWNuN1NGb3Er?=
 =?utf-8?B?ZCtMTnAxVUJNQk1XbzUrU2NYeGloQlZ1MTVuTUd2SW5GMlFublZjWWF6N1N6?=
 =?utf-8?B?b0FmM3lCN0pwR3FFUE5ya2pVMzl4eFdRRG54NWhvSit1ZllPS1lJRUYxVnpu?=
 =?utf-8?B?Q1M5VUlPMUJYR002ajA3NUdGMGVVMDRWSDAyUmkxZk90aVRUcVNXb2xxbUJy?=
 =?utf-8?B?M3QvdGRUTUFVR1JqZ1M0RHRueTRHUkZWREtKU3F2NUtGbGdHdjlYU2tjTGpZ?=
 =?utf-8?B?Vy96NWt1b3pPL0R1b0NSN3Z1Y3UydW9yUm1PT0xMdXFpMkx0cXBiekI0K216?=
 =?utf-8?B?aVcyMnpOZHBENEFNSmR1VlQ2b24zMXVXbFRmYi83YmpXdnlTNTUzR2F3SW9X?=
 =?utf-8?B?WWlOczZwNGQvYitxc0lRZDh6VEtHTFpzVGFWY1daSHFid0R3QTF2RmhZTHdB?=
 =?utf-8?B?cStpdHVJaG0rWkRid25HbjU4VExLaFliZlJ3SC9uUTIwOG9ET3FmZHRUSHZv?=
 =?utf-8?B?L0NsRHpxVkNQM1p6a2g5eTZHR2VIWlAwTGk5c2p6K0x6aDUzYWhObUJPSndh?=
 =?utf-8?B?RmxJQUpPSGQ2ZVE1dUxGSng2UlRMQWExYlhodEZySzczcE1VckNCYytXdnls?=
 =?utf-8?B?cTNoK284NHJjMVhVY05yWGQrTmtZVjdVZUEyYTJUYThhNDA4a0lnbk9lV0oy?=
 =?utf-8?B?Zjh6ZE5QbTQzQ3NFenY1LzBNTnlwNmIwMWNoM0l4a1EzWFdXN1BhRWhoSTBv?=
 =?utf-8?B?cGhtUDdXY2x5WEhZaFlVL3dJTGc4RnRQckF0M1JBbjJyRTlqcmhYdFZQb1NP?=
 =?utf-8?B?R0hRUWpNN2psWDA0cFBlS2x3SmpLT0VYc3JGUU9ReWg4RHV5aTh0dis5Nk8x?=
 =?utf-8?B?WSswdHR1SnRHWjdkenZYcUM4V052TWUxM2hmSjNhcEVVditVaDUvSTFoaFpm?=
 =?utf-8?B?MC9hSUNzUGNiUHlvd0REUndMSlE5SUI1K2RxcjBwdzRqdHo2TUZZT21saTEr?=
 =?utf-8?B?bzlCUmZjcVlnc1RGZlZxdURlTkUySWc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade3c397-a6c6-4564-54c4-08db4caa1681
X-MS-Exchange-CrossTenant-AuthSource: TY0PR01MB5444.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:16:01.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR01MB3926
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 4, 2023, at 19:36, Andy Shevchenko <andy.shevchenko@gmail.com> wro=
te:
>=20
> On Thu, May 4, 2023 at 12:38=E2=80=AFPM Yan Wang <rk.code@outlook.com> wr=
ote:
>> On 4/26/2023 10:42 PM, andy.shevchenko@gmail.com wrote:
>>> Sun, Apr 23, 2023 at 09:59:43PM +0800, Yan Wang kirjoitti:
>>>> if hardware number different to array index,it needs to clear to point=
s
>>>> memory space if the array_info have been assigned a value.
>>> Can you explain a bit more what's going on there?
>=20
> ...
>=20
>> I use gpiod_get_array() to get a gpio array form the node of DTS.
>>=20
>> the node is as follows:
>> ...
>> gpios =3D <&gpio1 0 0>, <&gpio1 10 0>;
>> ...
>>=20
>> First scan pin-0 of gpio1,its index and hardware number are 0,
>>=20
>> if (descs->ndescs =3D=3D 0 && gpio_chip_hwgpio(desc) =3D=3D 0) {
>> ...
>> descs->info =3D array_info.
>> }
>>=20
>> Then scan pin-10 , its index is 1 ,but hardware number is 10 .
>>=20
>> if (gpio_chip_hwgpio(desc) !=3D descs->ndescs) {
>> array_info =3D NULL;
>> }
>> just set array_info =3D NULL, Should the array_info point to memory be
>> cleared ?
>=20
> This is a good question. The entire algorithm is a bit difficult to
> understand from the first glance. I need some time to check it myself.
Looking forward to your test results.
>=20
>> if not cleared ,I use the gpiod_set_array_value_cansleep() to pull up or
>> down pin-10 is invalid.
>=20
> I'm not sure I follow. The array operations are against the given
> array of the descriptors. If you ask to have that operation done, the
> all descriptors in the array should be considered.
>=20
>> I found that the set_mask and get_mask vlaues of descs->info are seted
>> 0x03 in gpiod_get_array(),
>=20
> Yes, this mask is for the argument. The 0x03 is the correct one.
>=20
>> I think 0x401 is their correct value.
>=20
> No. You have an array of two elements, and not 11.

Due to hardware number are 10 and 0 , so this mask is 0x401=EF=BC=88bit10 a=
nd bit0 are 1=EF=BC=89.

>=20
>>>> if (bitmap_full(array_info->get_mask, descs->ndescs)) {
>>>> + /*clear descs->info*/
>>>> + memset(array_info, 0, sizeof(struct gpio_array));
>>>> array_info =3D NULL;
>>>> }
>=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

