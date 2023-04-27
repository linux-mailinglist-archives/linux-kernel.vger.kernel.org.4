Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8B26F0726
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbjD0OUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243987AbjD0OT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:19:59 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2075.outbound.protection.outlook.com [40.107.247.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CFA4EC6;
        Thu, 27 Apr 2023 07:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bC0o6X4kWUe+sjqGJm9iGcBo/kRV7m0yzeKO4+6GMq4mRx49eQ4XBRvlS1wVxn0Fhhiti7V8Rms/7EAGaOR8RfHqHFBXAWtUsnQ5t91aruOQdmBBzauHkbCGL/9sQfFRtvItlQ5R4Z/e9WnyY1mIgLkBUcEYrr05ih24lfl4v2jhcq4BoQuNq4HpWsg3ezFRW9V8VHL9oxFYUMqNT0AJBws0LWuVcr94Fz38tJiBM7grzgFl7451pu6Y6Fb8K1qT5a7LzUT9h/S9AYZBkiYa8CvFsxl6P3MbE/S7xHqLIXVeumFoidrGkZ4VWd3xgw6+8MJtVRlf1SmVOwG1aTUmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxVjhEcTmq3F15tpQX+4uu2aTZ0uOioJRA2g+R0qVfs=;
 b=A6RT5XvYnz3tWEU4tfmFE5NuSw3tas4RP3qsJc3f27hvlTdQNB36gRB/uRjDWMFvsWilgpmYI/YIq5H6cW+iCaK2+7r0jBoHXFJu9ZX8oTTnGEGBnEZ0gcFNIZF55Y9rA1YLJ4yYevQhCQelo17HewGhZ+JOBncdZYc5WYfKXeCZ0sZ5UvThALRQYWjfil0Dk0n3ipwhLcL416PHmce5vN7wvInAkGEEw7WE3DyYuSQrY1BqKLcz4yxZwUTpZQLbC+kBw3jqWkAJcENZgqVpNTxK/T6A/70JcnwKIhjFuDwsUYB7Z3tNhiuQHwlvrp7ujWmVCSQ7r0XlVVKNQTEeQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxVjhEcTmq3F15tpQX+4uu2aTZ0uOioJRA2g+R0qVfs=;
 b=bjptb+SEqDytzvpHAj/Y94xVxLgnIsZLHqqx4r8SbtANJ3sK0AlY5GIpSqOK4l/9JHYi56jFQgO+vPgdAXDs1er9IW4dULTul7gSaPY1JtGpmaakUDwXSPUlXfSYFz/UfMxeFvMHzHmWCl22id74Z9LR+mkfEPqyJ0bdpxYWVSfgnKX+a/Y13Y8GYzvLZ96lyTFH8JclYyQEV+avIQK/MJmsTdt7DL+JsTjNm4dbxmw6iJiTN6DN4LKY12W03WiMhIBJcy7pOV7iA++ULOoP0VuG4N5HikLD/TJnDYWU7yOh/n11hVLxbFX4hx9JwzgEAqCv5aZTim0suc3yjdNAIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PA4PR04MB9590.eurprd04.prod.outlook.com (2603:10a6:102:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 14:19:53 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::6c14:307b:6fd3:3bfc]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::6c14:307b:6fd3:3bfc%3]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 14:19:53 +0000
Message-ID: <a0ce066a-fa24-1e56-ade9-22d7cde18c14@suse.com>
Date:   Thu, 27 Apr 2023 16:19:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: watchdog: pcwd driver updates (was: No subject)
To:     Guenter Roeck <linux@roeck-us.net>,
        Oliver Neukum <oneukum@suse.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230427133350.31064-1-oneukum@suse.com>
 <a6dd47dd-6dfc-787b-43ed-edda0cc0e51f@roeck-us.net>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <a6dd47dd-6dfc-787b-43ed-edda0cc0e51f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PA4PR04MB9590:EE_
X-MS-Office365-Filtering-Correlation-Id: 981d0cc3-7b28-4b05-45c7-08db472a77f1
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lmme8EalVitV/hQGu+KJnAAaTGcdSoGY38KvgjmaSY/Cx9dumJXHByapgY6nkjiVOA6HigqzqAocD1jangYX7EeqBpuw2xANbvjJz6x7GM4wd/UoC8K+CfhxA0g3DeTXFWV7ewnT0PC3RoXJroZnsCbMUTCmO9EWHNQP5Bq+kwRlJUijjM+ojnfxt/A5etmpqfTzk3cJFs1tHlmds6m/5Sygq+Ze/nBjbCc5eKGWwOTZdE2HU+2RWP8ZOq4VgOrj47LF5ir9CTXUCUdSQ8mThIJk2LYgyCEt4DrAB/2aCgrWkRbxHtZ5Hg1PM7byZSj+mFT3q80ROm3fCUW6qZzdCtx4G/dYVBdnMnfT7syeV53b01z1+M2D8TNJ564OR021jt7TgxXT7+swR7RyitTyjSdc32AweAYmVWuhX6xQbNjA0nbglWlqi0fJkXu1XXdAyXC5+Dwn5pioHWbuwMSoh+CsgcaOxaDpJYDp9KekwvppFEAXaunv7OZXu+yIRyodLwSJnwDnN9sShv8VQf+aXPovjhk/J2Kot2jy+LIlInCNekBoDIPo4T+z0EKTKeNLiX4izx6/kQ189BwVa/JuV4iHrXNRBUpdo32d1eNePtBvaZYHMw/7fjOm+ksm4VhSevHsw53VqF16UCUmQUOOPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199021)(186003)(31696002)(41300700001)(6486002)(6666004)(53546011)(2616005)(31686004)(36756003)(6506007)(6512007)(66556008)(478600001)(66946007)(110136005)(66476007)(38100700002)(316002)(5660300002)(2906002)(86362001)(4744005)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0lGdXZVeWVvTldTOFBTTTNMd2JQR3RVeWFwZmFlWmFGYllqdE5pdW13YzZl?=
 =?utf-8?B?aUZVT09GSkFGWVZTbzFrM3R3cVpidzc5U0VhNjFvbVI3OVdkb3c3V0FQcmdC?=
 =?utf-8?B?Y3UwUy93VkdWSVVhMkl3OEw1OTNsdkVVcjd5bDhYZEVaekh2dkljSGc1SGtE?=
 =?utf-8?B?MTd5WWtZM1VFa1Z6TzZ6Q29jQWZrVGpHZzB4enZSSm8xUFpsS2N4S3JPMVBz?=
 =?utf-8?B?MXdYdnRyMitXS0lDTXZ1S1pXcWd3Q0xGUVRBWk1aOFhOa2lUaGc5TWtBS1E2?=
 =?utf-8?B?MUZPV0E2ejl5VGk1RVZGTnhIZzB1UDU2TlNrRStPd09mdXdab1c5VUp2c0Y2?=
 =?utf-8?B?R2NuRkpLWFE4aTEzTmVTN09kQ1hwTXN4V3dXYmFacGxRSlAzdEl1czlBZHFI?=
 =?utf-8?B?dE85dElnUHdyYTMycVJ1dXZMNFBZallFOE50eG5VaGYwUDEydEQ5SDF2RGVr?=
 =?utf-8?B?K3AwVHpRN0x6MFhMYm5oN09BUUJ5YjB0Rmw5UmdKRWpIQnA2Ykl5RXFjU21F?=
 =?utf-8?B?enRIWlNtUGZYL3l1MitMU3hnYjZvQnlHQ1VjVks2dFNrTWYvZ3FYL0VmQjB2?=
 =?utf-8?B?UlNmcngwVVhVa3NVbEZoNWQ0SW9GZE9SckNZRGxhU0w0eHZtV1VJODI5Q2pZ?=
 =?utf-8?B?b21GTzFPMmMrSGlrUC9KaUxuc3UvczFaK0pqbG9nMDNBdnRWYllYOTJtMUxj?=
 =?utf-8?B?QWxLck9uNDZpMkZzY0xTWGtCV2YrYSthRjdrQmtlOCtSNGExQ1lmYVNIMXRI?=
 =?utf-8?B?UW1ESHkzQm8zQkxuSWl2OXlSbjREZXVadlZnejdWeXZzMi9qTzFSbUpjaldk?=
 =?utf-8?B?ckliYWM5TTB3ZzRGbWR1WVZnWlA4RXJTaWNtTk9jQVM3TUcrTnU3WU9KN1RC?=
 =?utf-8?B?R2puT2NuV0JRcklDcys5dDNUeHpDUDJlUEs1NlBzc1Qrd1FIVXA0Rys4SHFa?=
 =?utf-8?B?NnJPU1FOdmVXZDhuRWgrNkNYNlBaRDhMeVBEUTJoYm50V0xUQzFHRGUweXRs?=
 =?utf-8?B?dVZrVGVsVGd5RThlek90MW16akkxYlNVKzZZV3FXL1ZxRkVyajR1ZWRpTDFp?=
 =?utf-8?B?djk2Szlra3dTaTFOaTQwWWY0amJva1g4THo4Y0hndlRsaU0zRWZMOVpmNml6?=
 =?utf-8?B?WjQxZ0JHYUJQNWg3UXlzL0EySS8xL0lEeG9oSUJLcjAxOFJ6c0k1NGZ6dWNG?=
 =?utf-8?B?b3lOL2R3RWo0VkYrTHYrRUh6WGNLVTZmWkpDaWc4UWZYcjhtTnFVcndtVEt0?=
 =?utf-8?B?dGpHNVhqbEE1MXNhRkpGWkJtemVZK1d1cXZMSXVhbVdLSXB6cGhRRURUVzFu?=
 =?utf-8?B?b2x6ajZTM1VZbytMSmlDYitiR01nV2hpR2laMm1JdUxucm56R1lqZ2szR2xW?=
 =?utf-8?B?eE5ESm1KQ2FoL2EyOWtSK3RndzdXZFRpN29pY2pwZUFuVnY1bmxLdmRBR1Fo?=
 =?utf-8?B?UnNYVm5zODZVMDJZSzZ1U1REcTBHZm8yUHF4a2h3QUkzRTBabWRpUnQ0ZXRQ?=
 =?utf-8?B?T0ZvQ2dPOW41MGdWMDl0NWVXcDNBeURCbEJTem9jdWZvUUh3MEhGSUN5VTFz?=
 =?utf-8?B?VUJrMnQ3NHRlQzUvaS9qQnFKd1FWRFBmdWpGbFkya2dhL05KcS9uUWthSyto?=
 =?utf-8?B?dHMyUnNRMUlsWnRRY2VWeVk4Rm1TbWs4RzhoTkMxQWluL0g5UHdOeDRHVGdl?=
 =?utf-8?B?SEtBbnJRVGNYQmNQUE9iNWtSelJRR1hVK0tsVjRqeFFjLzZ1cXlicVE4OHhY?=
 =?utf-8?B?WnRkK0lTNzE0NTh5Ty9IK3g5YlZhbVE1WEc5WVRnRGcwZ0VSMFJHU29VNTFW?=
 =?utf-8?B?QUtRbkc5ZmVXbzBjS0ppanhSLy9GOXFOQVp2S1hNTUhoaU1PNmhpNUVXWDZa?=
 =?utf-8?B?a0ZOOEV5WGdkbDFsUWY0QXc3TDhDU1Z0eFdpbmljSG5DS1BQb05LTHZpWWRh?=
 =?utf-8?B?dkFaMU1XWGVIa3pUaU80OEpDZk01ZzdHdWZLelFnTmVvaEZMK0l0MkswRWJH?=
 =?utf-8?B?NVN0dFpLanpXM201dEkzQTJkWEFOYzBxWjRkSHByUmF6US94WS9XZ1Axb1NJ?=
 =?utf-8?B?QWpSMGJwbHNiK1dDcTZVcnMzTDhEL3dONkFEUnl0bWFrTGFwMnpqbmRMbld1?=
 =?utf-8?B?dkJ6Uy9kUlRFcElNRGY2cFcrSklaNGlaampaQ1Y4K21sT2dyMndJWWtuMHBJ?=
 =?utf-8?Q?uu3Jb3z543YT2OTlN2Kga8L74fyAD6HNbgQ+JRrkY6Y7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981d0cc3-7b28-4b05-45c7-08db472a77f1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 14:19:53.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7ESkXJwzz+RyO5UTKIVceqrUq20XmX/e5lZ9siTyurdScopDknGycL26X26Cb7bPFwCmtKybnZ/MjGeq832BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9590
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.04.23 16:12, Guenter Roeck wrote:
> Oliver,
> 
> On 4/27/23 06:33, Oliver Neukum wrote:
>> This fixes some long standing deficiencies in error handling,
>> several race conditions and disconnect handling.
>> Finally a cleanup as we now can get the device easily
>> from the interface.
>>
> 
> This series is a no-go. If you want to improve the driver, please
> convert it to use the watchdog subsystem API.
> 
> Please note that the subject of your patches should start with
> "watchdog: pcwd:"

Hi,

this would be problematic, because I do not have the hardware
and given its age I won't. I certainly will break the driver
if I do this extensive a change without testing it.

However, as is the driver has obvious issues, which I can fix.
We can either do the sensible fixes or let it quietly rot.

	Regards
		Oliver

