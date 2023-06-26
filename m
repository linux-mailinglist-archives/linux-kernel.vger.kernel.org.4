Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF82873D9ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjFZIhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFZIho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:37:44 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EDCDA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQD5NSCwyhKUe3njJCRv1Pz0tHjA+iIAH3KjhL+gmXE+UVmT9W9mMNUjeo/3SF22XJ3xTfVzxdi8hMz/Wd6dxtTjpAmtH4N2HdZZkrgUhC6xHuOtkOcDK0meY51CNwEROjgsowihkVIQKFBtVQIacDoe1xfhVNzjxA0pQyxowbRuDFMUqzghyBcztT94VrZ/mwv16cQk7bwF1sM8KcAFJ/d081rFpVjh++Z6MHeNjXWWRdu+FjEB80k7ojliM20eylLUpdvCtPKFJHFu55SD6x8IQ1jlmlkZLvKIsZ7PS1lAhLHwPOOx4C9uDWdUlTPqTJubAffADaV48KcL+sF/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/tHganJ5EogouDstCudGP03Xam6lTNJCpXJarz3088=;
 b=SMTYmTa4VMzjgTS0h7xTLjO8v3x9mr6g5laUPrsMXLZgRS/PcSzlrkhJhLXQU8c5qTiYrssC8juXXArr8lUgBm1i7Uq8uJXe/7UYWqm6/P13d5EHmOcKZGPvcvfJm9Kwued0ZpYIbun2sGImoB3qFqdRideeNWNwzs25fSY3iSHDYYGsANLS1bpitNTtTclLGMEM65dfyFZvmtQif+fUKJlKIBERoybUDBEeE/wvWEWtrpC7QNNHe9dglYQn6t11W9JJcUye3JaX6YNb+fV634XPXC+jFlkrBSfIHiitAKljlDwmh8mZNCw0U4VQCdER2tFMZYUKzYSdUzKKAiXxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/tHganJ5EogouDstCudGP03Xam6lTNJCpXJarz3088=;
 b=Nz3AhNGhsPbqEzEVssm9ua/0Bhl50FGRTN5G1NVahZRxpKQypJTMkVmRD4bh6UnIrdBUqjo+oo2PPTFg6NS5Fu0j1UOj1rkzD0F0jYDudwsNEC7eNz4rwpQVSwrSo9IjRiYafBv9wrX8Otby9NPnwVLtQlCYfQhhjZT1iRCRhLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 08:37:40 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e452:1914:1054:de79]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e452:1914:1054:de79%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 08:37:39 +0000
Message-ID: <b2126d18-c9d9-0e93-952f-fbedd478b587@amd.com>
Date:   Mon, 26 Jun 2023 14:07:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] cdx: add MSI support for CDX bus
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     maz@kernel.org, tglx@linutronix.de, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com
References: <20230518114418.18025-1-nipun.gupta@amd.com>
 <ffb49486-4e29-a44d-97f6-18fea5386ba1@amd.com>
 <d866dba9-3b0f-3573-9baf-0d02f4049fcb@amd.com>
 <2023062612-navigate-hyphen-6fc7@gregkh>
From:   Nipun Gupta <nipun.gupta@amd.com>
In-Reply-To: <2023062612-navigate-hyphen-6fc7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::23) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e179571-3e9a-4a3b-d292-08db7620998c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDyGg64LVBqG4ZDehN1olUUFSzqvCeKvVhj3WY8HdvyXLk4eSMUHoY9ZJFZLl9MncY0ScfLB79lM0WkUYiKHo9K79unRfNllDHGrE8TXcXlJOUQFIbsOn+pT0bPByWMwbPggR82eqySviQ+5/x3iS5M11gP0BBUP0Mn2pboeYnzlwIwaScAfZMx8NdwG6rWyH6JS9eLNuV60pQ5/HMtWwHBFoteUC0r/KpWXVa3Il/CDqeUJZWC/piw6bD1XZ3+ut2on2MHkwt0EUv60Xicf8M2bnJcqF0y1fVen5MDNhSiY6sM4EYo2oDUzeYlWtSeD0MRDO7LguD2vEiZ8wRnsrhufG+hZ2zNvmRG3dGdGX0b71msx8U1u1xn5JIJaINzZy8IIfAp2zwQrN9H/gn7UsfuRPJDHdHg6iVMf7osDLFQ6vAcP6JR13/ORpEjdwayebun3bkUTC3WE9h/S7v7+8R3gElzRQ7PxrPemvyIe8ASutCSQh6lX5Jr/ZuMFDnqZzGi/eyNFho5ajo5BZ4gXWSiUdWcxYCNt90dqYPw8e6dFHFAoPxmdFHdMsiFirUpWB6lCMZAEtpwlJE/BRWoP0OE4aOK/dc+porLws/TdpN5/GMCf+GAoNNlzBMu4GIB+7Ug+QJcl5/aCJW8YYKDuzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(2906002)(6486002)(6666004)(38100700002)(2616005)(83380400001)(6512007)(6506007)(26005)(53546011)(186003)(41300700001)(31696002)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(44832011)(31686004)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDJBOWVVNklsTjI2akl0UlZxK2ZGY3plZm15OWFQQUZNQkU1K25rY0p2VXds?=
 =?utf-8?B?QjFUSWFuMHRnRFNLOUhsdU44Q3JzTUZlemd2dlprcUNFaVJRdllUd0x2TXpy?=
 =?utf-8?B?MXpCdGlnUG8wdmhSalN5MHoweVVGS2RpcGNuaFdsVkRySHlQU0FTSnJLb25Z?=
 =?utf-8?B?a0l2OW13RUJZQ1BMbG9XbDRWYjA3SWpwTHVQY3NiWXBrZXRtT0tjRC9CUVV4?=
 =?utf-8?B?YVV3MlRzTVpTME50NWhId0QvQllVbUxFUXJKSzdiMTZ1aTlBcDE4TmM5YUla?=
 =?utf-8?B?cG9SK3pUR2wrdXRVQ0J6YmpCREhNMmFjRGdtWUhLOHZPbzZtZkx0Mk5pdUpB?=
 =?utf-8?B?eWlOc1Y2S2lSdStiVXNqRllvamYzQUxDL3ZDK1pzZWlPb2ZsUDBQNkJDbnFj?=
 =?utf-8?B?M2JjVXJwZEFmVW50bzBtbGRoSTdScXU2ZDBWcjZsam5lbnp2R2lkcGhmSHZk?=
 =?utf-8?B?ODJrbW9kWDdsVVUyWmJpaVVkVHdKWTJMRnpna2RNM2JCSlpicHFRNzYyZGl5?=
 =?utf-8?B?VGpjWUxTajZwQkU2RDJicFlzdzRnbW9GWjFLQisxSFJPVU5jTGN5RkZLaXU1?=
 =?utf-8?B?NUc5SzM1U1ZpeEJiQ0xBYmp3ODNzYS9zdTU4VVBReWovZlVyZHlSd1lUcTJv?=
 =?utf-8?B?dDg1d1RoQ0o2SFV2R2JVQ3VQN3JKQnpOY3JOL3BpUHZ3YVNMYjh3Y2tnRXVC?=
 =?utf-8?B?SDVwYlUxVU9kazlQSzhENDY0REd3OTEyMVA1RUx1eXJTRUdoZlhRVGpRK1Ri?=
 =?utf-8?B?M0NTTnY0V0c1RmVIRERvdm1vNkxMSkNKS0JWclNUYWlvT1RhSmlmY1VqMG1I?=
 =?utf-8?B?WVByMjFUNEthZENhOEhua0d6MXBiZzhhOCtzR0JXSmJpU3pUWXFmSHd5TDNs?=
 =?utf-8?B?Qy9YVVhqRkt1TWNSbm9ueDUvRk9MSlNsaUpkMHAreitXZExUZ0RpZXFPVU16?=
 =?utf-8?B?ZHB6TEUvbVVCVTVUREVnTTlWdEdFbW54U0N4d3Y2cGRoZ3Z3Vmh6YlY4cXc0?=
 =?utf-8?B?M01OSHZUNEQ5dnh1dTNXRC92eUF3Tk5PaDdvaXB0WVVGaXRUbnpuWnczU1VV?=
 =?utf-8?B?ekQzN0xTUE9rWU9HUDZmU25VSjVyczJBdHFja2g2b0hGSnlsbWpkNlkvQVl4?=
 =?utf-8?B?dUg2SlhqODJCaXlHdWdCTkgwR1hFRjI4K3FlbFBUSkZnWGFYYlFVZlVHQnp3?=
 =?utf-8?B?b2t0U2hjMjFMaDJ6Tm1yNGNhdlZvNDdHUXk1am9XQm1yeVRyOXJ6OEhTbklj?=
 =?utf-8?B?SnhHMzZCbGVqTVAya2dEMnBaOGhKdVUwZWV6K1pRcE5JN2VWeGFMUS9xVnlM?=
 =?utf-8?B?YitMSFI0QlZqMUhyZGZ5U3J0U1RuQjJveXBEMUpJcmFkZWxDdDVDY09GV01H?=
 =?utf-8?B?QjdTK0Radlpaei84R1cvTzdqdmpZOWx4WjR3ckNMcGVBZlp6L3hPc0RGUkJ3?=
 =?utf-8?B?aVVUZzBxUDVwZUZUOVk4TzAvOVVxMjRVUEQxczFCK1czTGd1YXZady9nM21o?=
 =?utf-8?B?OG1tKzRoNlNBTlZkdWRHNUJtcGlYZVUybCtmZzl2UWJZVTdrb1E1VnAya3J1?=
 =?utf-8?B?YjFZZHpSaHFvVnNoQzZCL3lmTmdtNnlmejNaSFpLQUNWbHYyVzg4emN5Mmk1?=
 =?utf-8?B?MjFBWnhqWGhIMXBlaXN6TERRcW1HSlRRTEVWNzlWeE5Nek9saUxjbG1BN20w?=
 =?utf-8?B?YW9vQmZKbUhpaXZXRVRHUmtKYTZpNnNhcVBMZFhFNmRWZ0kxTFBwdEJoMDNr?=
 =?utf-8?B?NWwwUlR4b2NYMFZ2OS9hV3J2SFlZeUY1QWFaMURhQU9QQzBQUTRIOExjN2Z5?=
 =?utf-8?B?RjM2RWtGS2gyTkFyUHEyVjJ6TkNIaWRKTE5BcWpXK2F6MnJOM3lzbmRCanI0?=
 =?utf-8?B?UEpWdk4xMDQ0NXMxWGZUYUVGRnAyZUZuSG9rbkZ6Y25Sa3hITlhqOGIwQVVh?=
 =?utf-8?B?U1lwL0dscjFZai9wZ3NkTmU2WnFuNHExQjdXNGI4V3Q0UlU0RUNzeGY0bzM4?=
 =?utf-8?B?eERPQUdpcC9mdmdXLzNZZUxxTnY4THBZQzQ1a281NElRdjN4UUs2dVdFanQz?=
 =?utf-8?B?RllvTE1QZzFQdEw0dHVncFRKdVp5NWVmL0I5aTJYL2ROMnZSSFNpMUY2a09l?=
 =?utf-8?Q?FEARfzAQ/IbKnUq9IbyOXNwLu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e179571-3e9a-4a3b-d292-08db7620998c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 08:37:39.4042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gutEai+68xJF2zl0f8u7UPMZXZIfXOq3qT7UVkkv1OM294hCaHVh0KZrmmKbucqL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/2023 1:30 PM, Greg KH wrote:
> On Mon, Jun 26, 2023 at 01:23:27PM +0530, Nipun Gupta wrote:
>>
>>
>> On 6/6/2023 4:32 PM, Nipun Gupta wrote:
>>>
>>>
>>> On 5/18/2023 5:14 PM, Nipun Gupta wrote:
>>>> Add CDX-MSI domain per CDX controller with gic-its domain as
>>>> a parent, to support MSI for CDX devices. CDX devices allocate
>>>> MSIs from the CDX domain. Also, introduce APIs to alloc and free
>>>> IRQs for CDX domain.
>>>>
>>>> In CDX subsystem firmware is a controller for all devices and
>>>> their configuration. CDX bus controller sends all the write_msi_msg
>>>> commands to firmware running on RPU and the firmware interfaces with
>>>> actual devices to pass this information to devices
>>>>
>>>> Since, CDX controller is the only way to communicate with the Firmware
>>>> for MSI write info, CDX domain per controller required in contrast to
>>>> having a CDX domain per device.
>>>>
>>>> Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>>>> Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>>>> Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>>>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>>>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>>>> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
>>>> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>>>> ---
>>>>
>>>> Changes v1->v2:
>>>> - fixed scenario where msi write was called asyncronously in
>>>>     an atomic context, by using irq_chip_(un)lock, and using sync
>>>>     MCDI API for write MSI message.
>>>> - fixed broken Signed-off-by chain.
>>>
>>> Hi Thomas,
>>>
>>> Did you had a chance to look at patch v2. Please let me know in case
>>> anything else is required to be updated.
>>
>> Hi Thomas,
>>
>> A gentle reminder, could you please have a look into this updated version of
>> the patch?
> 
> It's the middle of the merge window, nothing we can do now with new
> stuff.  Perhaps resend it after 6.5-rc1 is out and you have rebased it
> against that release?

Sure, will rebase and resend after 6.5-rc1 is out.

Thanks,
Nipun

> 
> thanks,
> 
> greg k-h
