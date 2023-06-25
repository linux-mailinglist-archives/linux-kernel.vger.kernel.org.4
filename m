Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E8173D456
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 23:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjFYVLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 17:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYVLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 17:11:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2055.outbound.protection.outlook.com [40.92.23.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C06210A;
        Sun, 25 Jun 2023 14:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXlWXlUQ8/vJxpEQvy0l4qUNPagJaUy9cf6QckgAjueoJL5x7EKntIlTdNKpIWAyo5gRPaoZU2rej/24HpyxLjObH7eYexqXeZnRo+SkbtF+Kan9ha+EN5m4iKIRbqcX0ol1t2j78xw3oXG+lOP9JtgVjDQilvopb9HCvmXs0bEpbjdEsgEduNYSBDf7/KR4kDwVjhpKSVqrVuG/Fm/pjZjZHLXET25b1MNIsuQXnEFrRHWt+kODK18f3BQIRvi7saGBx8qzWe1gYhD4iPpuazwGO+UCJWckCfQwRbapX7HitdPcs78pbMYnTnk4h9zLe39FaQrcRh2ZdiHifcPZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cLQft2EB4qcUIhz+q97RHD5nIDZ2KgZoY8bBrFqggI=;
 b=NFrecjicx4mjg2OLEJjQX1MFcDScEaH5IXwD58xb0b2ETqS/rolvQ/3FkJ2PzD7zjUaCDtRGj02Q93D/8Ijfrn8L4ErUr6Zrh6RtOgYXYBo5Ng/28WXrrx+AGkObufwOdmuTDquFPIPXw3sBHTHhGXS2hTw6lxzBxbCkzA3ONLjxaceU9aNgzQXSD2yGep2mStKUU1z2DHBWPFdbJsIHsi2iK8iWxpmg6A8yLHhoMybiYjQUMWlDMs5ZA1jaao/l1fGRipBQ83qCHZvMRAsvzXDtEZeBF8wNfy9pD7V3iLo4f3RzL0pGRkWC7UCpI+vg3CEhZ1dzwTicTnkcpj9Eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cLQft2EB4qcUIhz+q97RHD5nIDZ2KgZoY8bBrFqggI=;
 b=qKwpIHuk2HSZ95Whmh8Va8ekltS+6PAgKQz83zjPO7LdCytDa9iqggUy3GW+e4Ke0VwP2gnjiGV2F5Yj3ZchxSW0Ato3MDnWNz3A8zFXeTHD/yYhcrEY28oa549XVahLLHpVX+orEcRghHStBVij0xgYkrDEVxW1hrQZVGScmlUKfoHc2jb/UryzuOoaJ+50t0mobHhiX1eOMrzkhGG1iWZ6cOR6C2jA2LaagOL7xNBhmNXsbyiTWB+0dZUYcCglbfjfjbO9iptr2ZHJv4G2qBXV01Fe/qNWKBMAYwhcwN4olEriYlrHSvMAqQu70PR+fn7F7TF3mMuZE/Kk82ptrA==
Received: from RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM (2603:10d6:10:c9::8) by
 CPWP215MB1892.LAMP215.PROD.OUTLOOK.COM (2603:10d6:103:13f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Sun, 25 Jun 2023 21:11:30 +0000
Received: from RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 ([fe80::6c3:80e7:184a:98bc]) by RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 ([fe80::6c3:80e7:184a:98bc%4]) with mapi id 15.20.6521.024; Sun, 25 Jun 2023
 21:11:30 +0000
Message-ID: <RO2P215MB1938BD13105900F3525E0FE7A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
Date:   Sun, 25 Jun 2023 16:11:20 -0500
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
Content-Language: en-US
From:   Sardonimous <sardonimous@hotmail.com>
In-Reply-To: <da80b806-de3f-c7ea-0352-cd23e0f6dd65@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [m+smDcuc7tdhoxGog3mSnSm79psqA6/wEhdvaob3RxTWS2fYxjyuBlklTPXKjqRTVEBS7x7QD+w=]
X-ClientProxiedBy: CH0P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::29) To RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 (2603:10d6:10:c9::8)
X-Microsoft-Original-Message-ID: <9b0ca9a2-126b-fffb-3b19-27eb0749619a@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: RO2P215MB1938:EE_|CPWP215MB1892:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a74570-1f30-45d0-2dc9-08db75c0bf14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: COJ4dpsqK1pe9pC+GjSn+cAAJW7D4ZSvWT1dZJQYQl7bC4b+/izoC2xoYWXDBFejkAJjuhZg7w09EthBpkahUM4rswAA+QPw7lPLKaYsW2iMiwT4WvPSVWievTINsqRApXLJag2tsjSV77Kgq0qEpH1nwHEiIi2jhhyB+WWXT4TjNG8IzWanzUSBCnTy2RSqIy7qhuRLddMCk3vhoCewoITrEtLDCsNZ039CO+Sn4Fk5FNo/XDfqwDX+12FzpSfIPApQYPt/2HTayZ1cPAGV9EgLf+s8xPYqKlrJa7u97x7tG/g+p9I+NPKSi0FE2RaAZEFZe4vuAj4ZCp/4kEmiZpRSUF+NWOs7bnRadf4XiXhc9iAajttLuYHSWX0bRBreMdd9RxR0QMXOUHKy68cSbwklBA6tz3hcxS549B6JzC2Y9ui6uYUKHqQpMttqUQqwoqss8zGH9OAXI7MSnPTkUFL03zWkmZUeKRotJTtnXHFpogK+oOPWAsTfWF0QLhxhxBml/WomryiNwzLh62I9Hxj0YVCFbAtqE00UCo/4oB51xekf8aGM1Pys4dJVZDle
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWxLbjBobVlwMG5USUtVWHhkTGRpQnkyOGs1UkRjV2VrVFNYK0c5M1NTS2xt?=
 =?utf-8?B?c3VTMm1WNVFtc2FjWENFWG1rYWpKZGhwVlNzdTA2ejlocHo1ZlMxUEpuU3A5?=
 =?utf-8?B?eVQ1YXVDSFlGRWFVWUhBMDJ4N0VySGVnVlVDYlUyc3dFQkJQcnZHbHcxaXVJ?=
 =?utf-8?B?K2VCTVNaNklqYVQ1QnprdG5MQ3pNOE1IQzBvYlRkR1V5cUxkNmJMeWEvSkpm?=
 =?utf-8?B?b3lDWm9CNjlCYzlac215N3FTRTVQK2N3dzYzQ2tUM2pBZkF0RW5qd3VyYmdy?=
 =?utf-8?B?U1haWWNkSzJEVWFQY3g5c0ZLZGR3RXQvaUF3cGw1cVJ1c0pNT2VvOFpsOVhX?=
 =?utf-8?B?SGhxK3BhNjg4VVhqdXlXS2VsTVQ4UUR3ZmQ0Z2p1OGFpUE5uUk1xSDMxY0R6?=
 =?utf-8?B?MmJpeExCTTlZY1p3R0ljNU92TTk4Njd3Q1AyNzVyZW10R2lWd1BkajhnSFJS?=
 =?utf-8?B?Lzdzd0ZIWTdsc05Sc250bmhQNmhQTDQ4MUpYeGczWW94YWVqWkZ2V2ExOHRo?=
 =?utf-8?B?RVNrNXg1ZjJXNUF4VDhTRlcwemhycy9la1VSMll5dGd2WnA3eWNwa2JqZEpS?=
 =?utf-8?B?eVkvbjZNa1RwZFpGZXEzS1h1NVIwbHFiVTcvdTJSbWF0WDBRQmpkcDBmQ21Q?=
 =?utf-8?B?eWxvLzlTVTJqYlpKWGk4NVlXTHZjZFlXSTE2eUFmb3d5YXdLTXhFZUljNkVC?=
 =?utf-8?B?RDVSMTlZRGIyYUhyanp1dllsK0ptYzJ2VkNGREsrZ0VBYm9wdW5ocUdxRTJB?=
 =?utf-8?B?aXBaZTNLUStxQUhNck5nZENiak5mZjh5bk1walJhWTVNbzBuOEtEUFF4enhQ?=
 =?utf-8?B?ZXE4ZHRrMTVHdlhFRE4xYWdFa1Y3aGx5dEp4ZUcrVUd0dDJjSm04ZVZXbENo?=
 =?utf-8?B?NSsvOHI2a2s0VW15STBkMGNnUkhlY2tuc0lvK1hNcWhRdVY5Rmp0SUgwUG5C?=
 =?utf-8?B?UlI5NE8yR05Yc1dKV0cyeGRWaytoMzJES3c5c0RpckJWZWFHK1BrSG0zMU5U?=
 =?utf-8?B?MkxORFcvZUNGeUFwbVprMkk2YUYrQnNEUzdkMUIwZlNhRTF5cEwxbkVvUFZ0?=
 =?utf-8?B?YWtwZE5FbDAreldqZHA1eDZsODJRc2RVTko0dnR4UDBhdVVGWTVOWmIzRkl3?=
 =?utf-8?B?VVlJVlNQVDdrbFdLNExsTnFEZElTSXRBOVVkNURPMnVnVWwrbmNicjFPWTNx?=
 =?utf-8?B?K29mQlM3amlBcW1TbHlYa1B3TkhaTHJMZUQ3T0Y0ZSs4czFNVXc3SG43RWkw?=
 =?utf-8?B?dmIxdlh1QlAxV2xjTE82cnR5ZFdqZ0ErTzBucVUrUHlLZk5CMUNMcU4xQW1Z?=
 =?utf-8?B?eHdGOGxacHNPTkJMMFhLd2ZmZU5lTzJHTmtiNzRvUzhxdWpaZkU4cmZyZk0z?=
 =?utf-8?B?ZmZLT1NLUm5DNVdhSW1zZ05wT1BxUVVTTERoaHc1d24ybnVYZmRWOXJuRWNK?=
 =?utf-8?B?VlJNMWJmZEtWQW5GRmlyOWZtRW1oRFZQVXBoVkhBUHh6V2YreXZKQXJQWnlH?=
 =?utf-8?B?RVUwREdDSksyYnVRbEdFRUpuZU1xVnhPbU4rQldpbSs2dnlvTkVCamdlaGt6?=
 =?utf-8?B?WnVpd2NZVzBDWHZSc3VQTGc2d2UrdW9ISEtzeHRkdkU2M1E1RTQvQ1hGY1dX?=
 =?utf-8?B?NnZqVDNXVUJGK3lETnlGNWlrcXdQSUJhUkV0S1RwcFA2UzdHUGpiVFZwaWlz?=
 =?utf-8?B?dDVxZkpEaytjQ0xHMms4YTFIeVR1ZE5BMUZkL1VPc0p5THFCVnA2YjA0TW9X?=
 =?utf-8?Q?OttcZQ38NrGAYyAMrM=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-7d2c5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a74570-1f30-45d0-2dc9-08db75c0bf14
X-MS-Exchange-CrossTenant-AuthSource: RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 21:11:30.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPWP215MB1892
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

On 6/25/23 13:17, Larry Finger wrote:

> On 6/25/23 13:12, Arnd Bergmann wrote:
>> On Sun, Jun 25, 2023, at 18:58, Sardonimous wrote:
>>> I have been unable to get DMA to work in the past.  So I have been
>>> configuring it with PIO=1 (/etc/modprobe,d/b43.conf):
>>>
>>>       options b43 pio=1 qos=0
>>>
>>
>> I think the qos=0 parameter is what causes the WARN_ON(), as that
>> causes the use of only one queue, while the warning happens when
>> tx function iterates over all the queues and warns that they don't
>> exist.
>
> I agree and suggest running with no options. If we need debug, we can 
> turn it on later.
>
> Larry

Sure. Of course, this is what I started out with years ago (2017?) when 
I was trying to get this to work.

Now:
Linux version 6.3.9-arch1-1 (linux@archlinux) (gcc (GCC) 13.1.1 
20230429, GNU ld (GNU Binutils) 2.40.0) #1 SMP PREEMPT_DYNAMIC Wed, 21 
Jun 2023 20:46:20 +0000

This is the sort of loop I get (dmesg | grep b43):

[   31.979539] b43-pci-bridge 0000:02:00.0: Sonics Silicon Backplane 
found on PCI device 0000:02:00.0
[   35.239389] b43-phy0: Broadcom 4322 WLAN found (core revision 16)
[   35.275018] b43-phy0: Found PHY: Analog 8, Type 4 (N), Revision 4
[   35.275046] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2056, Revision 
3, Version 0
[   66.890631] b43-phy0: Loading firmware version 784.2 (2012-08-15 
21:35:19)
[   67.437162] b43-phy0 ERROR: DMA RX reset timed out
[   67.498976] b43 ssb0:0: Timeout waiting for bitmask 01800000 on 
register 0F90 to clear
[   67.707177] b43-phy0: Loading firmware version 784.2 (2012-08-15 
21:35:19)
[  391.127300] b43-phy0 ERROR: DMA RX reset timed out
[  391.360514] b43-phy0 ERROR: DMA TX reset timed out
[  391.382127] b43 ssb0:0: Timeout waiting for bitmask 01800000 on 
register 0F90 to clear
[  391.590659] b43-phy0: Loading firmware version 784.2 (2012-08-15 
21:35:19)
[  709.123840] b43-phy0 ERROR: DMA RX reset timed out
[  709.357235] b43-phy0 ERROR: DMA TX reset timed out
[  709.378623] b43 ssb0:0: Timeout waiting for bitmask 01800000 on 
register 0F90 to clear
[  709.573851] b43-phy0: Loading firmware version 784.2 (2012-08-15 
21:35:19)




