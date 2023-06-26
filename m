Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B704673DFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjFZMpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjFZMow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:44:52 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2034.outbound.protection.outlook.com [40.92.41.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9616810C8;
        Mon, 26 Jun 2023 05:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv6lJEvRtV2o8NtnmolOm7JFnStirA1vlW/sXGY9x23b7jJyBvTyxvniMdFT3eyoUCL+sh3EGhStWT1udd1XBGgogAs2lZiVbeeKmbD/h4EwMLOYk6j/Ti2g9XOY4yCetnWhsBaA91ENfTIhRO8fw0S/0+pF5sYfodw0bTGGJglFetiYrGCzn6ISYPN1cPo/mptb0cdYs0zHLG29uLwtbO07K/XEpe3auZa4zoRIxZMWSK/yi/MwDTSrssStZc1S9UAS/3WXqiQzxSk9XkC9FDERwzgE5eyxUbwgHqmaWPo9TETSeJxW2qB0EhVhAgnyCfkM8lKJiBrarkvW20ZnbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uF3/wJK7/JEIf74Mz1uIA+E9ZroWrrW4wkGlwwkGTLA=;
 b=b6xcuu0q/EVslNqmg8v4WdNUbdBoCu1vs/Bu98HvSRYQqU4M7hvYP5BfnbOJSwFDqk+fvsNNGHjm0bDwrvMnxz9oepDsMJ+6ujoVqeVIavqu03sLYnMTzHN0Qp7cDeGhSTtPdQj7pvJG0xwY+1Q5GrbIG8rqHSB/wJm9lDavBsUEBRXcJVvGHQMQV8aqS5jQXFsLSpXpgF5MozOYaHdM1w+3cci8bvLzU6fEc5mhRc48XagF1lb0yhpnD1PBE03JO5fSUvJXbZw+WMeEPBhi0cUDWGq72Iy1f4tjg4U4TsqozWhX2ff90kCA4CT60O4zB8IKpTWoKTPZ7BFs6JxJQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uF3/wJK7/JEIf74Mz1uIA+E9ZroWrrW4wkGlwwkGTLA=;
 b=npgWZ+vuLtMqwDjCMBUZZB5mkwhkbm6/UTASt5gu4f8jWSJU6xfEGxVxuqmrL6ICn6jxb2nYgunT9hInPj/sr0I/RxDPWtESyRiizMcNd3gPG/hFAGBqG96cmFuwW6Kxhyjy8hTbq7ZfoOejKua5K1AkCpNelzAO8dT15rSerJo8hUKzIKRtbJwuWww/LzcWxk/YgtGLCljide0bMHqzQKncYtVZHydytq5L2UGS4/fs5rcynNglR0cQTZj/9p3/Xt0Qn5AS841zXJcQzFxFtECyKPMamjaI0AAdcgpk/aOfQY3Hj0eIwreJLXMN93UWJQsdY+nImZzs0aMpS98T7g==
Received: from RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM (2603:10d6:10:c9::8) by
 RO2P215MB2318.LAMP215.PROD.OUTLOOK.COM (2603:10d6:10:130::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Mon, 26 Jun 2023 12:44:24 +0000
Received: from RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 ([fe80::6c3:80e7:184a:98bc]) by RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 ([fe80::6c3:80e7:184a:98bc%4]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 12:44:24 +0000
Message-ID: <RO2P215MB1938BA68BBB683EC696F4BFAA726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
Date:   Mon, 26 Jun 2023 07:44:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: After kernel 6.3.7 or 6.3.8 b43 driver fails
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Cc:     =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
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
Content-Language: en-US
From:   Sardonimous <sardonimous@hotmail.com>
In-Reply-To: <67faf4f4-f36c-3ff7-03b8-cd259e4a5548@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [9Gh/SFQQiM6vQGlVNndbowJFXh6zA3xQVS9p6dqnhGdVxPoI1qFXNNJ8+bBzeFtAaCaGyIxwX44=]
X-ClientProxiedBy: CH2PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:610:57::22) To RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 (2603:10d6:10:c9::8)
X-Microsoft-Original-Message-ID: <56d1b220-bfec-c0cb-f4d5-757776b28e24@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: RO2P215MB1938:EE_|RO2P215MB2318:EE_
X-MS-Office365-Filtering-Correlation-Id: baac0937-3038-4707-2df0-08db76431228
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqdNngPyG2fBcrS3tcCRXf7rx7jbMFGklrQlRb4gpdb+DdrzfPF1G8ReNkGon4vYV7Hd3PxCJ5DlXMwxaxKxYWC1X5/qiC7XuDgS2GnLXBbNMyuc3FgxmIgQPOvq2Ei9TOhkBktbL7gnGev+jgl0wOC9yF4uZqFCjf9WqoywBCDityuCgWPPtNQGLcBqcGUr8wnoW9wozhEyPXi+MaEB6v+BpZ3ym+guLebTxnh8MYeV5hdOMxEoY/rgzL5sPjGUxk4PMbudsSny2+uDHKeQnJEi6NWwoNjh8W9w6JxrYUdhxGMWrAUrKupInsdaR6/Z1hhpRJnaAuNzM8AyuYFwelsKsyV1krFjssFxiXBElt/kAhkvgDI8h38kdIMClODMxIEgBRT8ie9GzY8rW5JcsC1ypJXUw3Q89yMIRJzMuEddkTio8O/bicV0t9W9RcIr9+gN976LVKwIAOg6N6vOuG9Jd2GjqJK56TYlBo1eLdgUeo6YA0KW052grG1eM863P7VemmDX36FaHb4eU5TRw402xicXYgIg4T4MwQsS9ApIndj3odniONKrZYnyCBcB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WklzLy92NUYzN2dxZVllUFhyV2RDZWNiN0lRWXFmZzcwbkJROUxuUlMxc2pT?=
 =?utf-8?B?Q08zZFZSNDNreTFkT1hGdzc4RUlvc2FybWMxWFoyZ0tQQlVhV0tOaU0wRkd5?=
 =?utf-8?B?SHR4b0ZEN01BSmk3VnhmOU1vUi9LaUxYM0c3RUcvMTRZUm4vZGI3YmY4TVRs?=
 =?utf-8?B?NkhWVk14dU5RdjViUlFNditiaVo2eGFQdnY4Rm9yN1IvOC9NaHZDdU5jWFpB?=
 =?utf-8?B?MkhZb2VYNFdoNWZHSzZUSTQxOTBHVk1GekN3OW9pNTJYR0t0MlR2RkFmWVE1?=
 =?utf-8?B?SlZHK2ZZS0tkK1U4Wk5sL0hobjFaSGZaVHdSMG9lWUZ0ak9KWDBOZVFqNm95?=
 =?utf-8?B?YU5COWs0cjN6a1BZL3d6dnFpb082T09QMXdQQ1FGR2wvQnhQYjNEQVk5U29v?=
 =?utf-8?B?eUVGY096MG51Z0JXM3FTM3dHVldMRFgzS0lOcWo3c0kwYmk5by9nNWVuL3NX?=
 =?utf-8?B?WXZiUWVSRnRPYTNZRlZtaEI4cVNuOTVCM3o0bVBhVmpnT2NEeVZieExIRlJN?=
 =?utf-8?B?U0FRRVlOQS9YeTBnQ09CQW8yVDRDK1VhdGZZMk1mZ2xFallmalByWW1ZQ1lQ?=
 =?utf-8?B?am5DWkNtSEhhZml5RmRjYzBXWUZVM09mT0lGdUFXUDc0dDZiRlRHV0hOdE5G?=
 =?utf-8?B?cVE5NUdZTUpxakR4ajFhbWlCakRPTGIzNTdYei9SOHM5dTd1RFVwTU10SkNI?=
 =?utf-8?B?YkM2YmNPcVB4MmtRUkpENzFSUDZhdDh5bEg0eXQ5eHZKME5TcDRNUXlYMUdD?=
 =?utf-8?B?T0U2ZU12c0ljbWd1LzRCRlNKcjZadEJEekh2cUFOY1VETWVJd1lnUGlEQi93?=
 =?utf-8?B?L2M3b25MVUkwendqZzhNZ21xd3VxZkpNQnBYOGplV0s2RUhhZTFhT0UwVkNE?=
 =?utf-8?B?SFBER0phWjYyZEdRdGVYN1JGejRMWGJRd0JieUUyM1Ewdjl6dmFlM1RCNWUr?=
 =?utf-8?B?WlcySGpPZ0RJVzRDdXo0WHd5MVRvSjVuR1dKZFZBRkF5djU5L24xUTBrVUht?=
 =?utf-8?B?ckQxYU1jcGwxSjVTRFpqckZJRTkvNGg1OFZYWmJ2cm9SOCtYSTRvbDRvYnp2?=
 =?utf-8?B?WDRIQWlIZEtxNGE0ZzJINmRVY1hkSVk4QU1qMVRTT09qWWUvSkovSE5pK3ZF?=
 =?utf-8?B?VzRUM2U2bU9Qck1wSDlpU0xOQ3A2VzNBQXpBOFhRcm9FSmhGRUNKZzBrSzhG?=
 =?utf-8?B?cTlZRXI0YzgwV0FhVmtuYktTa2NtY0IyNUtTMlFQYVVLVTd6b1FRQlhMOGlp?=
 =?utf-8?B?UWFySGZ2ZFRmakszbFBqS0I1a1hXM2x0QTBWZHptQnRYSVplaFMrdS9VRWZN?=
 =?utf-8?B?TWpScFdocmM5bHlWRWswNUhndHZRajJkc205cVVsQ0FlSVNpWFlJcllQWUhD?=
 =?utf-8?B?UVNCblZDdG9zeHJpOS93ejh6c0h3U0VoUTBrNU8yWTByQ1RWVUFLVkJ0Y28y?=
 =?utf-8?B?aUkrT0ptcmc2Tm9ZVGhxRENudFNLbWVLTElORnllWlZpM1E5dWFQZktQK3lX?=
 =?utf-8?B?enhNZ0htcXQyTDVadU1qeS9iWjNhZWhFQmZQTFpuc0FDZEQ1ZlVvOGw1dU51?=
 =?utf-8?B?aWg3bHR6VkNIWkFnM3ZFMExjalFvNUIvM0tGNldmWFhnRVFCQzhkY2NvZDZV?=
 =?utf-8?B?akVoYzhNVzNkSjQyTThSaXhIbE11L0JoVGtwVitZUzdGdW84cERJZUpZU2FO?=
 =?utf-8?B?TzlKQmlTd2NILzZ2K1FLMlpjTjc5d1FpamVrZVZNV25hUEV1dlBoVlZJMXRu?=
 =?utf-8?Q?7sPuK6Fkvzt5JEPNLQ=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-7d2c5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: baac0937-3038-4707-2df0-08db76431228
X-MS-Exchange-CrossTenant-AuthSource: RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:44:24.8112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: RO2P215MB2318
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/23 18:05, Larry Finger wrote:
> On 6/25/23 16:11, Sardonimous wrote:
>> On 6/25/23 13:17, Larry Finger wrote:
>>
>>> On 6/25/23 13:12, Arnd Bergmann wrote:
>>>> On Sun, Jun 25, 2023, at 18:58, Sardonimous wrote:
>>>>> I have been unable to get DMA to work in the past.  So I have been
>>>>> configuring it with PIO=1 (/etc/modprobe,d/b43.conf):
>>>>>
>>>>>       options b43 pio=1 qos=0
>>>>>
>>>>
>>>> I think the qos=0 parameter is what causes the WARN_ON(), as that
>>>> causes the use of only one queue, while the warning happens when
>>>> tx function iterates over all the queues and warns that they don't
>>>> exist.
>>>
>>> I agree and suggest running with no options. If we need debug, we 
>>> can turn it on later.
>>>
>>> Larry
>>
>> Sure. Of course, this is what I started out with years ago (2017?) 
>> when I was trying to get this to work.
>>
>> Now:
>> Linux version 6.3.9-arch1-1 (linux@archlinux) (gcc (GCC) 13.1.1 
>> 20230429, GNU ld (GNU Binutils) 2.40.0) #1 SMP PREEMPT_DYNAMIC Wed, 
>> 21 Jun 2023 20:46:20 +0000
>>
>> This is the sort of loop I get (dmesg | grep b43):
>>
>> [   31.979539] b43-pci-bridge 0000:02:00.0: Sonics Silicon Backplane 
>> found on PCI device 0000:02:00.0
>> [   35.239389] b43-phy0: Broadcom 4322 WLAN found (core revision 16)
>> [   35.275018] b43-phy0: Found PHY: Analog 8, Type 4 (N), Revision 4
>> [   35.275046] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2056, 
>> Revision 3, Version 0
>> [   66.890631] b43-phy0: Loading firmware version 784.2 (2012-08-15 
>> 21:35:19)
>> [   67.437162] b43-phy0 ERROR: DMA RX reset timed out
>> [   67.498976] b43 ssb0:0: Timeout waiting for bitmask 01800000 on 
>> register 0F90 to clear
>> [   67.707177] b43-phy0: Loading firmware version 784.2 (2012-08-15 
>> 21:35:19)
>> [  391.127300] b43-phy0 ERROR: DMA RX reset timed out
>> [  391.360514] b43-phy0 ERROR: DMA TX reset timed out
>> [  391.382127] b43 ssb0:0: Timeout waiting for bitmask 01800000 on 
>> register 0F90 to clear
>> [  391.590659] b43-phy0: Loading firmware version 784.2 (2012-08-15 
>> 21:35:19)
>> [  709.123840] b43-phy0 ERROR: DMA RX reset timed out
>> [  709.357235] b43-phy0 ERROR: DMA TX reset timed out
>> [  709.378623] b43 ssb0:0: Timeout waiting for bitmask 01800000 on 
>> register 0F90 to clear
>> [  709.573851] b43-phy0: Loading firmware version 784.2 (2012-08-15 
>> 21:35:19)
>
> Sardonimous,
>
> Did it ever work with DMA. or was PIO the only way to get it to work?

No, I never got it to work without specifying PIO=1.

> If you add in only the pio=1 option without qos, will it work?

In this case, authentication to the router fails.

[   31.021510] b43-pci-bridge 0000:02:00.0: Sonics Silicon Backplane 
found on PCI device 0000:02:00.0
[   33.889890] b43-phy0: Broadcom 4322 WLAN found (core revision 16)
[   33.925016] b43-phy0: Found PHY: Analog 8, Type 4 (N), Revision 4
[   33.925053] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2056, Revision 
3, Version 0
[   63.863977] b43-phy0: Loading firmware version 784.2 (2012-08-15 
21:35:19)
[   64.170661] b43-phy0 warning: Forced PIO by use_pio module parameter. 
This should not be needed and will result in lower performance.
[   64.550635] b43-phy0: Loading firmware version 784.2 (2012-08-15 
21:35:19)
[   64.847342] b43-phy0 warning: Forced PIO by use_pio module parameter. 
This should not be needed and will result in lower performance.
[   90.247286] b43-phy0: Loading firmware version 784.2 (2012-08-15 
21:35:19)
[   90.514031] b43-phy0 warning: Forced PIO by use_pio module parameter. 
This should not be needed and will result in lower performance.
[   91.263462] wlan0: authenticate with 0c:80:63:26:16:b5
[   91.551389] wlan0: send auth to 0c:80:63:26:16:b5 (try 1/3)
[   91.551916] wlan0: authenticated
[   91.553776] wlan0: associate with 0c:80:63:26:16:b5 (try 1/3)
[   91.554656] wlan0: RX AssocResp from 0c:80:63:26:16:b5 (capab=0x11 
status=0 aid=9)
[   91.554883] wlan0: associated
[   99.619556] wlan0: deauthenticated from 0c:80:63:26:16:b5 (Reason: 
15=4WAY_HANDSHAKE_TIMEOUT)
[  100.348068] wlan0: authenticate with 0c:80:63:26:16:b4
[  100.640896] wlan0: send auth to 0c:80:63:26:16:b4 (try 1/3)
[  100.647930] wlan0: authenticated
[  100.653778] wlan0: associate with 0c:80:63:26:16:b4 (try 1/3)
[  100.654653] wlan0: RX AssocResp from 0c:80:63:26:16:b4 (capab=0x11 
status=0 aid=9)
[  100.654884] wlan0: associated
[  108.717245] wlan0: deauthenticated from 0c:80:63:26:16:b4 (Reason: 
15=4WAY_HANDSHAKE_TIMEOUT)
[  109.267996] wlan0: authenticate with 0c:80:63:26:16:b6
[  109.767538] wlan0: send auth to 0c:80:63:26:16:b6 (try 1/3)
[  109.769105] wlan0: authenticated
[  109.773778] wlan0: associate with 0c:80:63:26:16:b6 (try 1/3)
[  109.776774] wlan0: RX AssocResp from 0c:80:63:26:16:b6 (capab=0x431 
status=0 aid=3)
[  109.777254] wlan0: associated
[  116.001372] wlan0: deauthenticating from 0c:80:63:26:16:b6 by local 
choice (Reason: 3=DEAUTH_LEAVING)
[  126.612857] wlan0: authenticate with 0c:80:63:26:16:b5
[  127.234092] wlan0: send auth to 0c:80:63:26:16:b5 (try 1/3)
[  127.234734] wlan0: authenticated
[  127.237108] wlan0: associate with 0c:80:63:26:16:b5 (try 1/3)
[  127.238173] wlan0: RX AssocResp from 0c:80:63:26:16:b5 (capab=0x11 
status=0 aid=9)
[  127.238410] wlan0: associated
[  136.279232] wlan0: deauthenticated from 0c:80:63:26:16:b5 (Reason: 
15=4WAY_HANDSHAKE_TIMEOUT)
[  136.991245] wlan0: authenticate with 0c:80:63:26:16:b4
[  137.254104] wlan0: send auth to 0c:80:63:26:16:b4 (try 1/3)
[  137.254645] wlan0: authenticated
[  137.260507] wlan0: associate with 0c:80:63:26:16:b4 (try 1/3)
[  137.261447] wlan0: RX AssocResp from 0c:80:63:26:16:b4 (capab=0x11 
status=0 aid=9)
[  137.261699] wlan0: associated
[  141.001670] wlan0: deauthenticating from 0c:80:63:26:16:b4 by local 
choice (Reason: 3=DEAUTH_LEAVING)
[  141.081565] wlan0: authenticate with 0c:80:63:26:16:b4
[  141.117429] wlan0: send auth to 0c:80:63:26:16:b4 (try 1/3)
[  141.117979] wlan0: authenticated
[  141.123927] wlan0: associate with 0c:80:63:26:16:b4 (try 1/3)
[  141.124662] wlan0: RX AssocResp from 0c:80:63:26:16:b4 (capab=0x11 
status=0 aid=9)
[  141.124895] wlan0: associated
[  149.240176] wlan0: deauthenticated from 0c:80:63:26:16:b4 (Reason: 
15=4WAY_HANDSHAKE_TIMEOUT)
[  166.273957] b43-phy0: Loading firmware version 784.2 (2012-08-15 
21:35:19)
[  166.577378] b43-phy0 warning: Forced PIO by use_pio module parameter. 
This should not be needed and will result in lower performance.
[  177.507291] b43-phy0: Loading firmware version 784.2 (2012-08-15 
21:35:19)
[  177.780745] b43-phy0 warning: Forced PIO by use_pio module parameter. 
This should not be needed and will result in lower performance.If I were 
to send you some test patches, could you create a kernel with them applied?

Doubtful.

> Larry
