Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89873ECF4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjFZVdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFZVdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:33:18 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2069.outbound.protection.outlook.com [40.92.18.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97ADC2;
        Mon, 26 Jun 2023 14:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dtwh3nM1Mcy5NqXpA2nWA3qZQeLAqMe0yKjNtBxhtJit119pHqTcSLScn7W1oTN/erNiHIko562j9o5BWiAinhodVkwIuNT1SV9L2+G8epjfQHeEEeJskFajiNeRQ0zHfR63TEwRUvHyDRVsvbkJQ0TL59y2U5Cze1oL+mo/2Os+ZjpZ1RNY6DRXQQvxgB7l3Q8DBlHFzrPxQhs3/Bo8GyQBSmiu+C1wihPb2pczU0koPZNECOk7EMY7vXb6cAsy38l108x+ROOarN/67FQ/YMzxW2W4FOADm9pXjN+DDgids+tRO0CYnTbNkeFGAOljh5mjNUXYDBfMXIeEXlajSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xltZiW6/jtkjktzT0AsfgJNHpIBtvo1PFS139PXGWE=;
 b=gy84rehKygHiyFd1IkO4RTxurq3WQy3w26pm8Bzpf2AylSA6TqYf/7Gfl9mkwhaF0rEqnhq4yL13hP9WXGOVDpXWy/M5CCYidZrE4vDjLjchNOKUvoh9hHG7Ww2DvDdTL0xRjrNuq8OO+f+JpbTZ2AK2PP6g+/oUBqVBFBsKHPZH7iQ+lF4eIdziH+taFb0kI0CQT5/lq2F3PdGovA2Pu3jzw5pSiao6Sw+y2SFBgpi/5o1jnKTReKXS3UMt19CegnLnghdiMQkoCBePSC6+Rkpp+5+VVXNZ3QJ1C8kpIo9qfolM05BD+PZow1meICsNTUf9BiMocNuXM9TJS+9vhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xltZiW6/jtkjktzT0AsfgJNHpIBtvo1PFS139PXGWE=;
 b=KvvCX87v1s3yBwffZrye6c9pAhNl0WS6zIWUiOx7KWvmNkS682vpp3Vz1zBVc1JuaMIUPEiGH5gEukuhfG2ntFfE42Q6Chfpoehf5kg6GZ0ixR75BplCoGkoqfyeaqZRZYPhU4LAehDi7tPQLVa4zDnUb4rx9cn6N2mOUlXrFuVK5QGmaZ8gEZKpuBoLZovm057NjNslXi2SbLBQetf4k13+O7dsUXCvlqQfXcbQF/z6h7JG9r4nGLxS70RtesX9UAspqwPD2ZcdpCOUcpEr7BS8iKndLb6T695BmZJOSYYnzfIHlsmdC5W0K+XiDFroIOuFuUoREZcmsx6HF1ResQ==
Received: from RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM (2603:10d6:10:c9::8) by
 SCYP215MB2288.LAMP215.PROD.OUTLOOK.COM (2603:10d6:300:a5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Mon, 26 Jun 2023 21:33:12 +0000
Received: from RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 ([fe80::6c3:80e7:184a:98bc]) by RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 ([fe80::6c3:80e7:184a:98bc%4]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 21:33:12 +0000
Message-ID: <RO2P215MB193898F3008E0F390CCEBC87A726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
Date:   Mon, 26 Jun 2023 16:33:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: After kernel 6.3.7 or 6.3.8 b43 driver fails
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Cc:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>
References: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
 <b9428e48-f0f9-46f6-892c-4c8834c930c4@app.fastmail.com>
 <RO2P215MB193850DDADD38492BEC8CC2FA720A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <a3bc5eb5-9639-8016-36ab-105abc8c0ca3@gmail.com>
 <69b98eb4-2c4e-fe75-90b4-4b08505a595a@lwfinger.net>
 <RO2P215MB193879B2D99DD0BAF59EFA92A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <e0a08449-554a-4a28-ac50-7051866eb95e@app.fastmail.com>
 <da80b806-de3f-c7ea-0352-cd23e0f6dd65@lwfinger.net>
 <RO2P215MB1938BD13105900F3525E0FE7A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <67faf4f4-f36c-3ff7-03b8-cd259e4a5548@lwfinger.net>
 <RO2P215MB1938BA68BBB683EC696F4BFAA726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <6afa0ebc-1d3f-8cba-79dc-8ddfe13c296a@lwfinger.net>
Content-Language: en-US
From:   Sardonimous <sardonimous@hotmail.com>
In-Reply-To: <6afa0ebc-1d3f-8cba-79dc-8ddfe13c296a@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [A4r9SWpZYQTajJSxVSvYFtV7WooMVl7nV5ayYhM0xxjP1vqPsPiGxMcktA1piEoRGSOT+xWVmcA=]
X-ClientProxiedBy: CH0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:610:cc::21) To RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 (2603:10d6:10:c9::8)
X-Microsoft-Original-Message-ID: <5783e3ff-d06a-f9ba-9cb0-5e2f0c0ffc52@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: RO2P215MB1938:EE_|SCYP215MB2288:EE_
X-MS-Office365-Filtering-Correlation-Id: 82914c8d-b75b-46e2-d279-08db768cf101
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XheQVPl+ElCQstpa+6ffbd69cm1UrTVhDJo3tWRQ4/iO1hL4lGv6jeGqw3zd6S8CxaEaef0qGfQ9cdjJ36dYuxCKjf2lwLsKDxTu+yTWzmIYMpUbKmAhj7SxyRLq3VFpr1trAaklwLZfe5bPyNlJxsxmbcobkkoJA1Hat2JCE003wyyhiLdfCu4L+x2tDbcO813+bgLuYVkWga+4jqz37AhrspYvR0J9XG99C539vtbiaJQ1pB5yExeL1AbE7wqnJEDgF+M7JoLDwi2rTFQWEB7UmwO2vH78hYRK39iTxJ0ivZ6iqSmqgT7xopFK+ijutEwaUid19AdPrBSnYGUULYj4BW+vXRmcT5lSwQqvAaGU9vcu3cGoHoZLXT+3UT0k2u1VZbu8Fah/whCQokrWANGNQI2RQNywuf6LvdEa8dgJRyaj2tEth37WGBx1w9X3CptI5lqAg/SwuIMGAax4QQPloV8rVAka2f2nXEjK+POUdwrsaA+ghvIWk/CCxbpeSGB6jCcHwTX3Y2Bio4h1I0VB6yy8+pP9+Im1q2UMrpU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anZsemVUVTJFN3E3OXovek1mVndqdnVIKyt5bW1PcTlicW56MHQzVThLRUtC?=
 =?utf-8?B?ZFpRaDB6RXN3Qk9HSHRhdUZqM01rMG1seTdUWGZwTkQ3TXlMeTAyanFEY2tk?=
 =?utf-8?B?SnZIZGZScGVraE1Gb3FqYzZwVFNXdldZVGxyR1pHZitjckQzL1YvdW5Gckdt?=
 =?utf-8?B?Wk5rYU9tekhockhuMFMwRlhyVXdYa1Q4eTNaOFBOb2ZPTUQ1a2lhM2tGMFZP?=
 =?utf-8?B?akZYTTdoTCtkMVQ1T1FVbGRRQjR2SC9oeUEyQ0Q0U1N5VUE4Wmx4WjgxUUth?=
 =?utf-8?B?OElLUXpKK0huWVpSZDVsZDBlU1hCTGxTbGxINUN6eFRzNkZ0eG5zYWxoTGl2?=
 =?utf-8?B?dXZTMEhqYVA3WFlNdWRyd2tycHlDSGV3NTZ4M3FuSVRRMC92RWxDaXV6WE1K?=
 =?utf-8?B?RzNDK1U0WjFJVXNsQXFMYmVVRlBxN2JJSCtBcDVhaGpzU2ROeGNnUW5vM3Ez?=
 =?utf-8?B?NVJpalRZOGNwaWxMU0wxTWQ2ejdETHh3RnZiaENZdGNDbVpDZHRDdjQ4R2ho?=
 =?utf-8?B?OGw2THRWckNuRU43czlVbXkrVTl6SEpxVzJBYjVZLzg5T1MwK2xiZ0tOM0sx?=
 =?utf-8?B?dHRJdkExSXZuaXFkQ2lGRFVvZGdOT2ZJTWFVM2NtY1RGQzN2amhReW5ycVhR?=
 =?utf-8?B?S01kWHhsL1ErTWdZcHYxZEplbmJrcmZINFY2QmFHSm8yYnkwMHBZT3NoZEF1?=
 =?utf-8?B?OFRVeFFtTWoxZ0NvVnAwTDJDaG1ra09iQjZmTEt4US9lS1VQVlc5cDR6ZVly?=
 =?utf-8?B?aThKclQ1Mjh3RWd5aEFiODNPaFZlNTRITDF0ai9tdGNxeEJONW9WZTJ5ZHpv?=
 =?utf-8?B?S1V4cUdLMmdldzdLeGtiRlhqc2lxUXNZMUdxcWczV1hEWFpIdTdvTUZYdjVl?=
 =?utf-8?B?WkRlWHN5VTlVUEhKWGVSYnpXMTQ2b3BXR0VWVFljYUxxRFJDTFQ4WkF6L3lU?=
 =?utf-8?B?UUJqS3kvRmc0Ykt5d25kL0orV3JENXphOE9MYzJRdWlJSUk1N1EyUFRBbG51?=
 =?utf-8?B?K3VBMGQ4YUEvVzBCS2tKU3B2Y2ZZbi9vNmdYNER1c3F2a2s1RDZRWWhmK2Jp?=
 =?utf-8?B?bGhtRmg3eVBZeU9ISWs3a3ZQVEZCTUoyUmtsTlZpRFl5VkVrZ1Q5TFF0OHRP?=
 =?utf-8?B?eXhpL0dRejdKcml4NE1nOUxWeUNCaUJiRHlyOTlCMExjVzFTdW51bUlsS3ZQ?=
 =?utf-8?B?S3hrRk5kZzlldUxpSlJVanBQVkRMSVYrTG55RjVzYXFyL05xekRsRGhpSFBr?=
 =?utf-8?B?NnptTWRRVkVEVVdJMG83L3QrakVYNmpic1RrblB0T0RSVXQrOCsxYXRqWEpO?=
 =?utf-8?B?eVBsU2FxQ0FhYUI0aldSUGhZK0l4YXVEVVZBWmpvRTJ2djk2eHJsSitUWi9G?=
 =?utf-8?B?UGNmd0EvNmhuN1E0czQvWTFmMjhtVW4rMWhjMXlveTlrUFV6b1pWR1hGc2o4?=
 =?utf-8?B?blJWOTlGbUQ0YUxpRmpibldPTnlJUXVLd3ZTcjk3Qnc3RDUzWUJnRDdRSGZ3?=
 =?utf-8?B?eUNxZVVWWENlT3crZ0dCMEl0MlptLzdCTXltT3JqYW1XRGRndjh1bEwvUWky?=
 =?utf-8?B?d0dFcXhvOTQwMzdaM3c2QzJHcG0zY3lVVlpSNnBzYmwwSWw4TC9sczlOZFZ6?=
 =?utf-8?B?bFRVNzNTbnlmOVR3N1ZHTE52NkJ3RWFucHpOWTdwTXNzOU9TWGlWQXZTRUQ3?=
 =?utf-8?B?UlQwcUhLT3pOS0NUVWxoRHhsK3pCQ1Yxa29ySHNWK0tNVXN0NmVzRFd2Rndq?=
 =?utf-8?Q?dKwji7Vfaa2QH2ZZH0=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-7d2c5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 82914c8d-b75b-46e2-d279-08db768cf101
X-MS-Exchange-CrossTenant-AuthSource: RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 21:33:12.2824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SCYP215MB2288
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/26/23 10:21 AM, Larry Finger wrote:
> On 6/26/23 07:44, Sardonimous wrote:
>> If I were to send you some test patches, could you create a kernel 
>> with them applied?
>>
>> Doubtful.
>
> Sardonimous,
>
> OK, that essentially eliminates  getting DMA to work. The cost of a 
> MacBookPro7 is too much for me to acquire one to debug that issue.
>
> On my PowerBook G4, I also got the failure to connect, thus I should 
> be able to fix that problem, but getting a new kernel with the fix 
> onto your machine will not be easy.

It might be possible to follow the arch instructions for patching the kernel

https://wiki.archlinux.org/title/Kernel/Arch_build_system

It takes about a day to rebuild the kernel following this procedure.

> Is it possible to ssh into your machine, or to use TeamViewer? Those 
> questions do not need an answer now, but think about them.

This is complicated by being in a CGNAT environment.  I usually do this 
via tailscale.  Will have to think about it.

> Larry

Should pio=1 qos=0 cause the problems that it does?  It if is no longer 
a supported configuration, perhaps it should fail more gracefully.


