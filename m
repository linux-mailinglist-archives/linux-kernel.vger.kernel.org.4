Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CAF74E239
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGJXZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGJXZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:25:32 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322699E;
        Mon, 10 Jul 2023 16:25:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhmK0GG3smj/D99V0pLu4Fi/s2zbxO2NnLMxMaOIv7XKVW+7XeMlbhf1DlZ3Ryp1K5bfG9bjIesH/YY37OD1c1J/XK1gHF8gZUAJUosL4NcYbTY18Wq2vCjqVf9HrIXpVRAhl7lVRrZukoV0mCbrxNOYEucR0+Iqo8m/Drce9uF6sCA97zStkakdx3GX4gyKs1J6oVxEN983lYMPd5XZ3tGEY78vVZh+snld5lFHNZYpgJHrM97Xyr3QrU8CQ5ToTxUGsbssRndIKtxiMp3Zd13Xryl2LPgdGB7EYCJB7t/bgwxu1/956frTs30XmPJ4Jwleiw+jiWB0EXhLrG2tBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mMjcflkmqy9eSdZ4IUt7Z+fE2xlwm6qWY4mAFugCPQ=;
 b=i6ElI1SkIUxUkhXJjmsP3ZLP7AK9pxdjcWa90IdKH4yRTQzi4LXGMTnfShvqlbw66/sCs7JMktXns+wdkNGI33oW5sMnvSaOFx+2cut/JK/OW0xdrsIkf4sTY9HgOyd7v6oDn6bd8mWlIBsVna5La64+NhPNdEsVSycx82TzpYYsX8/nJWmIEuZ/+FilVcAzAOpBS8z7JjwKsvnZAxyPubiRRktMiT24mxnAI4usCxPsSsDZ05dOoX3Bey1v5wKdIDlSMEXQv9AIl+6DPTm5aUSWAdmwqW7/HvZron3mc9w/YG+wpTUtncrpMrgNf6+RGrsXyBgRD7VoIBqjYUmp3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mMjcflkmqy9eSdZ4IUt7Z+fE2xlwm6qWY4mAFugCPQ=;
 b=U5OL6hHirpyioaORDip3zDuyyxBuWDAX8GkfHsjtk6rZXj1aid5UIJnxdtEetx/97HVa2zfioqkIBmJzC7eeNPuCg3RcmhmZIEd0pfIWQ2wiT46+7LAcBSunhrmeHuEEtNxvry/m/zQzPf8gazemg8AC4Jnr8OaL2fydT7ZA+Rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29; Mon, 10 Jul
 2023 23:25:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 23:25:25 +0000
Message-ID: <12148445-cc19-28a2-2a36-7511d5c57e9f@amd.com>
Date:   Mon, 10 Jul 2023 18:25:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 00/11] Add dynamic boost control support
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        John Allen <john.allen@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20230623135001.18672-1-mario.limonciello@amd.com>
 <580858e8-27c8-ca3c-cb3d-61041298eb44@amd.com>
 <ZKyRUB7dGzQ/FaIG@gondor.apana.org.au>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZKyRUB7dGzQ/FaIG@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::31)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: e34cf08d-ed59-47ad-455b-08db819cf019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3svFPXYr/BY8omP0/EGwlPN3XvD+6oVfgzmUfXyk6tSOhyRPDFw5jYerRhl67rtg5nbEi2yjpBCN8ROZFsMikCX58SkaNSQpJo6lewCP6+NH4noeCrhpuf2d33jtEefwZdQlQnmVTJBIW2iUBh7NpEcO+0AwZUniMreu3xmZJIYGJzkD9EpBZ1Ok6om6fdgZ/69E57td8K3a+htx8EtbNeZmUr4lB15yv9WPQLsRmEiXvfaXOPGGgbLNFj4Uem7EQh/7JBcGXUj3j6wk2bVQiUWk0xQ7CuuhCM7UdpyVcf6Ff50LLs/50ySsS4CLN3ZewUwZLLCUq+s1x/dkGI2nDpz9KYaHjy+YbEAUtPCLJ3TpGWkHImffZ/cWT3P39HB88Rja2AvMYijRQcHuXCV4DXnXaVdbAm7Iet2DXqecg5+ybdkIMJqeyNF7bu4AbvSkU9q2KOi1WEOlpefrSQ2t/BfxyxnVKm60ItYamKj9u6YwHUEtPLbAQYh1PwmsSSWGrfuyoIgeekqfFFHO/Gsb23yqmeN3iMwtRCLp2gqNvtvHUUMyMcA0S8qvHZcmSTK5HCO86i1N587m4tEegMKJ4luAat//g4n1G1rQNGzaHbDaGHvknocw0vGtNQrIo2kTw7IsH6/JYz8BQ960oUxhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199021)(41300700001)(54906003)(6506007)(53546011)(66899021)(478600001)(26005)(186003)(6512007)(6666004)(6486002)(4326008)(86362001)(66476007)(66946007)(66556008)(31696002)(36756003)(316002)(6916009)(8676002)(38100700002)(8936002)(5660300002)(31686004)(2616005)(2906002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDhWQ3JLQTFWcjR4QlNWcEhSTkdBRkhuL0F3d2VNb3FVZ3FHZXRRMjNsaTF4?=
 =?utf-8?B?MWxFSG54bVlZVFNxSHUwYXBHNW9uSWJzVWZuNXlHcDYrTWMrTDRsZVllMHZD?=
 =?utf-8?B?emQ5MkFDQ0hiZUdkVjNxMzNvWFZLMEZidTBpbFYrcUQvaHNqYStJbGxIaitJ?=
 =?utf-8?B?WkhSRkRtQmpBS2FFR3k3dFpIM1lzMkM3ODE3QTFJSHRqQnpkb1FjREpOZmo2?=
 =?utf-8?B?VFVMYmJyMHRMa1lJVmNmMXFqRHNON09KRFJxMXFNWFFzTXlwbGlsVzhsVGF3?=
 =?utf-8?B?dVg4dEJvTnpzamtQSkRoVkl2ZWhNek53VzNKcFgzUXFYUWNXVE5JZEFOUHQ4?=
 =?utf-8?B?NXRwNEQ0enRvQ0djcDNrTkVZcDI4dStGaU50ZmxOVTV6TTVkL095M0l5Z0Q2?=
 =?utf-8?B?TS8zSXZicVZ4dmJENXUzRFpRVlAyWUJTaHNsWjI4Q3grUVhURDJSZlVuK1NS?=
 =?utf-8?B?a1AxcjBBZExQZmpCVTJtSDZoTHNoSkllWDFMOXNhUHdnOUkwOTZONnZsS2hW?=
 =?utf-8?B?SjZCUXpONS96Qk5oNzF3QjJES1U3R3RSMy8yY2c0d0RnL211djZOTzVJbUZU?=
 =?utf-8?B?eWNYVTdVTEM0RmtpVldCYW8vYUFHY1dxcUp6akEwSlhHVkdyQWtvRjV4eUZF?=
 =?utf-8?B?U0RsaGNZa1hXVXA5WklRekZyaTJTdElvUFlJeVVoS0RmRGVJREIzTCtQRlIy?=
 =?utf-8?B?cFNZY1c3bCs5ZlFQL1Bsc1NBYitDb1V4YkswYXN6dXVYZDQyWWJKeTNYMkpX?=
 =?utf-8?B?R1grUXQwdHBFSEZOUXBIaktqaUNYejVKZTlHdWs3Umt5QWY5WEhSb0VMZWIv?=
 =?utf-8?B?RmtEUlkyb0UrSWRHdkFWYUtLNmRSVm9kY0p2WWFhRUgyUU5MRzMvQUxlYnZ0?=
 =?utf-8?B?MUhUSWtLVXEwaEVBL2ttaWtaSWdiVkZrdjNiMU51bE9FR0NkWlZvNUdHWkZP?=
 =?utf-8?B?VGhJREE4NzBmbHN5YWxyeVVmL29pRjk3bFdhY09NdlNPb3BINkpKeHd5UDB6?=
 =?utf-8?B?bFBqNWVXY0IyalhXNTJzckVTUFdDbDdHMEJFSDlUR2xoVjlYOTlyeXRpaUQv?=
 =?utf-8?B?ek5CNFRYaXo5Rjc3dG0rNk9KV3VZckNiaURwVWZMaEFmYzh2dUFJMm1maU03?=
 =?utf-8?B?c3hDcG9SVG1IVWZoZlVXK2hCb0ptUGVIM3dKWW5UcGs0TnJ5VkpxWmJTbUlv?=
 =?utf-8?B?TlNXU1lwT0h3VTRKYUxaOHgzVjk2eFZPMlBBMjZIaVRsSkszWGJRQ0ZaUXJ3?=
 =?utf-8?B?eW52TDBPaSt4RnQ0RFk4VFZoaWUyVWVlRnVzOTR5VHJLVnkwOFUyVDZKSldp?=
 =?utf-8?B?b1VNUjdRdzRqWThVMGFaTnBtMXhUSTZvS3ZaaXZhRGQrc1VJNXBGQUlTNk1w?=
 =?utf-8?B?aVl5UUZKZjJXWE4wU1FPM0pDcWJIY1pYTmN4cXI5M21vNmY2eDJya0ZOdklT?=
 =?utf-8?B?emxad3lhTlN6NDBvNUprY3N6QkVYWjhLWXZSTGkrenlSQlVIMHFIdzNWTDRK?=
 =?utf-8?B?WG5kL3JrNGpwano1R1Q3V3NKMkh5NU5SeU11b3Y5ZnV6YTlhMzdESWZTaFNW?=
 =?utf-8?B?TTJodkE2MGY3aDMycmFrVFZSQ2Urd0syR0pGV3pENEhFazZ2ZHRES01zUE9l?=
 =?utf-8?B?V29sZ1VnVkRjdWNQcDJaV0IzNE9SZ3pDa1EwYWFWSVdTanNadW9NWE5LUUxY?=
 =?utf-8?B?RzlPOU5DNmtFNW5JY0w0UVozZ0VsbkJsbGU1OXJXK0p1NVhSNHpFVXFWaVFq?=
 =?utf-8?B?cjdmblRxSWJSaWcxU0F5S0lSUmRsZ3p6QVVWczloMzh3YkV6TVVLQU52bTBn?=
 =?utf-8?B?MnZIMllCMEVYeUVHWjZVN1RrRExadUwwN0tNTnhQZThUanN6d2ZNZVZSZGk0?=
 =?utf-8?B?ekFYNzAwTTFRRHQ2dmYzN3FZU1RUeHJOSE9rMk9wYlBzUjZjbVZqdTNucXJh?=
 =?utf-8?B?L0NyRFIyeHd4dGlyRVZyT1BxaC9JUG5sbjlqZWoxUjFBWEE2cXpvelhmd2x3?=
 =?utf-8?B?YkJLVGZPSzZLU1hsMzlRc3BOZERqZ2J4U2lOYTBTZWdFaTk1ZkhoUkFtK3F0?=
 =?utf-8?B?SnpNT09DbGhUQXJxNjhKZk9YUVFmMXhnYWtQYVZzRytWWmx1eUhIbUZCdXR5?=
 =?utf-8?Q?TZND15ghw7GH1OR6g0ezW0hWR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34cf08d-ed59-47ad-455b-08db819cf019
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 23:25:24.9104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6VNR2CCEbMyLoFZ7fsD3zDlZfWhwdtei5EJSyf04AHr21NY5hDbOQVgzZyqYNcvAkXwG8trWRgXOE3LK/9oCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/10/2023 6:16 PM, Herbert Xu wrote:
> On Mon, Jul 10, 2023 at 01:26:41PM -0500, Limonciello, Mario wrote:
>> Any other concerns on this series?  It has acks from Tom and John both now.
>>
>> Do you want me to rebase on 6.5-rc1?
> Please be patient.  New code is never added during a merge window.
> The earliest this can be applied is this week.
>
> Thanks,
Right; this is why I was offering to re-base it on 6.5-rc1 if necessary.
