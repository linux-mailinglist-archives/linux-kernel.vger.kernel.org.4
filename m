Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74DC6ED03D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjDXOWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjDXOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:22:13 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn20831.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527479761;
        Mon, 24 Apr 2023 07:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNGUCVYl0FhLGCSrHxBfGK7sch1pyi7scch+OfTKxUTqe2Hi980oxuNto9eng6RqO4aQQ0V7FzhjW5VmeI/dVuQWZxhRnPCYnOMVkMsWdVOt99Jmq/Z74ChJHqMQc62xkegUGZR+uWZnzRhhDNv71DBXwRKZHIGd5+I30PpIVKlmpOYB5y6ZH16pnjX7GCn1AC8ifIg2uU04EcWP1WGGo/qI8G1Ttu2jtGvj4hLtXZEvcin+I7ImFCGIJ6TjRCI3AA2F/u+PpP/tBHyZOhbCUh08IByU8mBhr5Qbw/sVd69RbK9ViOrr3BpjnLkyK10DJx8lyWOXeC6lwlptA0IXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8TFCJrIi9hhZcvtBuwV138plA3p3fy28ZUqfhrjHf8=;
 b=Kuf5124DFV9qVfcfYSelqf+hXJeqKTGawfOk3F5gz0IfSHreSf/AoSQcrfy4a0OjcwFYrv3mtg2zi8e40gJjUfZuitMarUkMl7gG40Lj5/SfX0tCgWNmQcczUeW+eRLO1qAViXYFmxZ/H6cDJGapuefszDs2BVdu7NIwTQbv98tTgvof0Pgzxp+fbrOz976V3SS6gd4H4/0jgHoRPPAnAG8rM95jnP8mdaCn91kfjuUnRNP2aP43GK16ranwKXd/nHG360yBQNvi1XGJjPjc/IdsZkFfEM5inb3dx2O2yGF3/mlWzjB+pAltAHbvso5XoR+NLU9KM5r3/ds+Dz3dHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8TFCJrIi9hhZcvtBuwV138plA3p3fy28ZUqfhrjHf8=;
 b=QT7YI1Og8JemU/6oIIelgYqch25MEXiV/PWTscuGwY4wL7Io9Yn+9uK6kiL2m/FVyi4WONXX6GroxIe1Gxu+EvGfZDUq66prViw+amllBg3IQnwEb0HpIhA1UEnus2Yio+WqJdN/jQMKEfqWpXKk3slgo/23w1itGo6lihmZ2SXYVrz/crbb0y2Ml3eeAB+sZ6q94jssCQoyhudPOvgVeFW5GqUV9hiJF7540ogLvrylBxwPTL8EBBiLmuB3dSexL4p8w9iP5Gl9hJ/z6gHNEU7XSgipf4kZjU+ka47axHVRiHeT/sFRaPHVSrTCiMc+rR8rzQwswbBiVTwffuyWqQ==
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9a::12) by TYZPR01MB5183.apcprd01.prod.exchangelabs.com
 (2603:1096:400:339::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19; Mon, 24 Apr
 2023 14:21:58 +0000
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::5bff:fd7e:ec7c:e9d3]) by KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::5bff:fd7e:ec7c:e9d3%5]) with mapi id 15.20.6340.019; Mon, 24 Apr 2023
 14:21:58 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH v1] gpio: mmio: restroe get multiple gpio mask
From:   Yan Wang <rk.code@outlook.com>
In-Reply-To: <ZEaEu7Yxd+E53sth@smile.fi.intel.com>
Date:   Mon, 24 Apr 2023 22:21:54 +0800
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-ID: <KL1PR01MB54482B74FB1AC599EBDB5D1AE6679@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
References: <KL1PR01MB544800D7E51C9209A9BD998BE6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
 <ZEaEu7Yxd+E53sth@smile.fi.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-TMN:  [gHwXVLaGnKKVjkR32r0SJRRexnhB1Xu3SwR1cY3uFoM=]
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9a::12)
X-Microsoft-Original-Message-ID: <FF205773-84D1-4248-8E47-2699CD2CE0B2@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB5448:EE_|TYZPR01MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: f674a4bd-da04-4d53-71cd-08db44cf4325
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uefI5j7t2JcUThh5GLvKmgdzJjEovEPu+NIajcdeebvcjFS5Q+yQH58FpRERWtksgPv/kzyBEfNZH56QxIREp4olQEJvZMv9hsws4muIYlveslNQHvzoPVpQj+7UCEW1YZYHMLxhH+QCFoJ2AwAX9RJpMXMn6xQn3uxBmdK5+QPkZrrylVdgcYNy2WDTrww/ASydZC8qJdh6WJhEMZRF7Cr9wWGwYTXbRRjdETnf8dCqz2a0cZ+TG5MF8GCOiOnhUSuognOVk0I5bim0szCCtxSezRxhePCSWGXoyfnGVb++dmTvXsgjC8SIJc3RtsgnsrL90xkfLO52lfC5QvZrhPIsYgTx103pFd9yU8HSowI0TnzO1CoVEhiH1rjTtUmL9sDFGFCfeP7DtiCGq3u4w5R2u3NgB4WXA2bogN0yKt+Gx3ztGByoYmizbU33NnPU0GVsfVoIWntjnB1D+yt6YQW+JgMTAMAKFrOEnxAwGfVKwcv7rZGXwvPr+M+CgcCI3nFEN62DlwEvvDesKpr/IZy0fw+j3iRJWbnid3SlujotZ6KL/J3JPkFIUfUjMAOwjK3MC+9iG9WvKPGxB75AQwcjV0h9TGEMpOltq2VNEtiPbO5413P6045WYQQbsKVI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGc3YUxHci9Ta1VmMWNzUStxcDFHdW1HbGMxbjFuNGhtWFlWaXVJaXFNWEFD?=
 =?utf-8?B?SEtuR1lwWTRGYnJ6ZzIwUDEvRk0rUVloZWxDNGJKREVtL3FNNDMwRnp3dGh0?=
 =?utf-8?B?azNyZzV3UUJvdHhqWmNiY2VsYlFYczd6dUg0QnFMQjg4K0JxSVpSZ1JDNlRY?=
 =?utf-8?B?YjZjNTcvWEtoSlRiNjUvWGw0Y0ZIYzJsWlNHanJ6alpJdTFpTHZBSFdsNGFU?=
 =?utf-8?B?dzRMdjlBeUJoN0h0SjJybWZYSWRnM0NiT1BCSUZKN3hCSUJMOGJ5WXE5SlZL?=
 =?utf-8?B?OWhQOFNRWEFMV0tWYmJ0MCtsemREL1lrL29GdEdBYjB3K2x6czBQODlKZ2ti?=
 =?utf-8?B?cEJFTDF5L21hWXpGZDdtYmdrVFBvNE1kREJuajVOVldoUmNaaDRjdFRtY004?=
 =?utf-8?B?UndubkxnOWd2bHR6eG8zTkdNNmVlc2k0ck0wNjhad3psdk1VU1d1OE05NFdx?=
 =?utf-8?B?WU5QWmVlL3VFQTk3Smt6dU9OSUkzL2FveHdoWHlmdERyN0xIRzJ1cm9tczV2?=
 =?utf-8?B?VlJ3ZkhKaG1wWHpNdDZHQWpJTWNuVThjazFvRzFrOTg2VFJlc0ZQLzhEazBT?=
 =?utf-8?B?M05ldFF4T3lydXFrMXRmbnNlWmNtYzcwV1BnM0JQclNWc3NrQUJBeUQydTd0?=
 =?utf-8?B?WnIyK3NrR0gzYURjSENYMG92UktNZHJJa1RybURNQ2NyNk9QQ3BQZnZSZ3hE?=
 =?utf-8?B?Z2FLd3UzdVJMekRXYUJ6Sm5RdmlpdWR4RUdGdkRJYTRhUzlSZXMwbzdzTzgv?=
 =?utf-8?B?Z2x6c1BYSVNpdzFjK2ZHYXFhS1dQRDY0QTlXcVd2Vkc3c3NMRWsxMC80Q09P?=
 =?utf-8?B?SnhrdzFsLzhnS0dCSFlSWTFETk0wZSsyOUx2V1hrR1JhRnFyYlFaZTVqVE9T?=
 =?utf-8?B?Tkk2d0cwZ3hMdzM5NmV3Z3E1KzZ2NFRqSnNyeHE1Q1FscDNIOE42TFJTR3pv?=
 =?utf-8?B?bklGN2ZscCt4WlJMNHJRRTM4UDEvcXpxWWhWc3hUVFJRR3VCbnFFY0pVNFRs?=
 =?utf-8?B?ZHMyQ28za2dOWXNINit3LzBwT0Y3ZmQraHZSd29jNHFaQ2I4Tm9QVnhmdGVk?=
 =?utf-8?B?WklFTnJOKzUvOS84V0VCZUl0RXhrS1ZWdy9SSjdidDdmMXI1M2lYK3VKU0ZX?=
 =?utf-8?B?U3JiaWFKbzk4emRFMGRCV1RLZ1B3YnpNaVRXRGJKVzUvOEFxTGZDS2txNGpE?=
 =?utf-8?B?c1p3U3VZRnc1VGFzaDBPYzFYNE9pUVBlRjcrVDY4YWF2aCtZRVp4KzF3ZVhm?=
 =?utf-8?B?WHVtZzh3NStmMFhmSG1KVHVpczJITnZjbTFCMkQ3ZUtkTmhMdE54RU5sa3ZD?=
 =?utf-8?B?NEpmaHloUEx2dzBEZ25oc3hXMGlFYWEyMkJ2dG1GQXJnZEhFWEx2L1kwU2Nl?=
 =?utf-8?B?RE1SYnpEdmoyTCtlTEhLVm9tNTBXKzJiemZMY3gzcTJPTzRFY1JzUEZRSFZw?=
 =?utf-8?B?NmxZMnlMdWg1c04wcUhzVzh3K2tCY1pNd0YzRWptd2xQRlNiOUtscml0cG16?=
 =?utf-8?B?dnozQTFxblQ1L254NXEzRmpXZzhBQWozTmVDSHI4eXRPd0NzclhuUWROa1hK?=
 =?utf-8?B?cUNQczBjTmhHdFFpWXdkSWZ2cTdLOC9xdFpkSy9TWEs3VzJNdkNONWdYbFU1?=
 =?utf-8?B?cjFmSWw3QVBpeDBZakVkUm9na2RaeHc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f674a4bd-da04-4d53-71cd-08db44cf4325
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB5448.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 14:21:58.1023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 24, 2023, at 21:31, Andy Shevchenko <andriy.shevchenko@linux.intel=
.com> wrote:
>=20
> On Sun, Apr 23, 2023 at 05:06:48PM +0800, Yan Wang wrote:
>> Simplify the code,should not modify its logic.
>=20
>> Fixes: 761b5c30c206 ("gpio: mmio: replace open-coded for_each_set_bit()"=
)
>=20
> What does it fix?
>=20
> ...
>=20
>> 	for_each_set_bit(i, mask, gc->bgpio_bits) {
>> -		if (test_bit(i, bits))
>> -			*set_mask |=3D bgpio_line2mask(gc, i);
>> -		else
>> -			*clear_mask |=3D bgpio_line2mask(gc, i);
>> +		if (*mask =3D=3D 0)
>> +			break;
>=20
> Huh?!
>=20
> We never enter here if mask is 0. So, do not add a dead code, please.
>=20
> Moreover, in principle mask can be longer than 1 long, this code simply w=
rong.

You are right.

Because  I use gpiod_set_array_value_cansleep() to set multiple gpios
occur wrong . I restored logic of the original code and found it to be effe=
ctive.=20
So,I try to modify it.

I  recheck logic of  this position that it=E2=80=99s correct. I think  ther=
e should be a error in=20
Gpiolib.=20


> NAK
>=20
>> +		if (__test_and_clear_bit(i, mask)) {
>> +			if (test_bit(i, bits))
>> +				*set_mask |=3D bgpio_line2mask(gc, i);
>> +			else
>> +				*clear_mask |=3D bgpio_line2mask(gc, i);
>> +		}
>> 	}
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

