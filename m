Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320A870B672
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjEVHYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjEVHYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:24:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC441B9;
        Mon, 22 May 2023 00:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ba5VrD6bVL8rnXeNDuxfOPB6Uw2vRmGnv/b51l6S9x4XkSF/kLcL00XvlPoYG9m6803kcl1V2adgK1Uh62PjJPY7kKBVWOgd90zJiOK7TbkQsftsae7Z4zzWQ8jlOQJ9aC1u4OwWYRLwuCIYJxB06DZVzzhO+Hmuav+tDNizIIVS4sROGDLW2K3CiajpvYU+v9U6pll5fWZ0ftp4EqrZO5GI0Uw948FPcV1gLHOoVJHIhocVn9AWnH4FIuK8UVjnJyx/G1O8PTIYf2uwAM/bqPkbi91IASfCh9GqKQRjf9+5mJ8hoJUKvns5Nole+ttcmX6ALL8Xq2WvfzB0VAbX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh1UHABRvOJltI2nl5XZKgzpjvyGjfxoklNTDFeT+To=;
 b=KARprmAtdG2HhsALmvR2zDJaY2hNDJG3Pw3TqVGGf3lNAQBizArl/Dc4/4RJ+1GB8cjmNZD784A5enWMAE4D61V4SbvymvfgWyNU14YVzLeiZttcrD6cu/YcWse0bGmnWiIhPfsS1e31IptDe0rNGAmhTxHLYVUCKZTbTcldHtvSFuGcK090eehYSFgrj4siCTmNjV0w32AbBl7Atrw34VsVAuOrmAo/4hTlQcY1OqOvUuvX8NcchmMf5MZcNlbRMMspmY3PPVHmSMIEATA7MqA5MTsR9v1JGq/aEN8LhsvnXoSFXDCW4aCa7z+VLOnIehHHTZRLWeLnp5zznya9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh1UHABRvOJltI2nl5XZKgzpjvyGjfxoklNTDFeT+To=;
 b=5RgnoeEz1daFYyI+Rnh8IOYzWZnAhEMCEK7rdHtqEET3AgW5hJlsuJ+lKuW/o4dgKh22uPFOk2Vce1h71LPMKKmRCmP8v4fW8LmuIGwzn6WOZaL+LZP+piIHCYjosqiGP+BugMlqVim91XBfGFyCsitO58BAnvPvfsDLypoajpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 07:24:15 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 07:24:14 +0000
Message-ID: <adccf55a-4738-396b-69ad-752152d673b0@amd.com>
Date:   Mon, 22 May 2023 12:54:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20230522171145.38a8bd4d@canb.auug.org.au>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230522171145.38a8bd4d@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|BN9PR12MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: d72d61d3-22be-4957-226c-08db5a958af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4egeH9WqFROqPdo3/P6F+28ekHYejkrqyRXTrXcj8rG3PizIbi43jgvoyeiZINi7VflGPwJCvuky8Ns5AFUrfd2uvXrM3ji0GmCP4W8TB1RSf+lh84CBut9UGHtmUmquspdD21AqS8EDm92wtkO9/tpshH3O60+IGgUiQmg4DDx4PmKPXrkwHeExOcKVF53DMOPTbkhRq74sjDBpmsubULtEChTibqG/g2iLG0D54VwVXW3l8nUlMlZpL769/QsZd8YCIJUPP3ukNGrNrd+MmhIItBEiy/QaUfdF7VdB9oidyZW+JH1Zx3bog+ApnbMrc6LUgEba8NBBux2HpWrAQLv+TDWjHSjWYHEAp6ZM+wSl4tDasXYlbcHlHuMHIpzmRAGRodaeqtbI5rYEI0ZMR8CBtKolv1tJiSFO0luF1OcqRlrOirTgrMwvazSIBGubb4BjWMyiTzMCeoQTPEf+GlhRfYrn+gM1nuaePrAjxnPYTcvbT92oSjTUPptWr9yaavg6KD1WZ5nYMctooxDXSUOBo7fzlaKHzqxgm/JKEEGyaZUE6pKbBiP6zGqlZYLRLmv0qgITJqaSpqTwdgS9RWqciDls9uHohd9yYGh4of8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(38100700002)(31696002)(86362001)(36756003)(53546011)(6512007)(6506007)(8676002)(8936002)(2616005)(4744005)(2906002)(186003)(31686004)(54906003)(478600001)(110136005)(316002)(4326008)(26005)(41300700001)(5660300002)(66476007)(6486002)(6666004)(966005)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVRZWU5qNEJGbXQ0a1V4NjY2Qm9seWl2TGdvcFhuakpzd3NMMS9nQ012dk51?=
 =?utf-8?B?TjdPVHY2SDhmQWJ3clI1ekxnb3c5Q0R5TklqVXdkVElUK005bHRTUHFFVVN0?=
 =?utf-8?B?WU1tSTJCUy9Ob0VHbHZ1N1BsZUZoamtOQk5adkM1Rk00aEg5NHlBSnM5a1A3?=
 =?utf-8?B?clVVM0VtTUw5cXQrRXM4b0RCT0I5bHJlYkJNbE5SV3FlU3VzM1JUbksvTGVk?=
 =?utf-8?B?VlJ2Zi9zWlpkL0JtNmMrdjRwa01admorQ3VQUCs4MHAzQWFIZU9SU0xwN0gy?=
 =?utf-8?B?TE1GN1h4dmRscENBOURvK1IxNGlWdUlZTjlQQUpoNjBXaXR2ZURlODJEYm9S?=
 =?utf-8?B?Y3lOSnFJNW13RzI2Vmk1V2VEU3hTYnFOdm9GWEZJbkZwSUlkekQxNEJYQmpN?=
 =?utf-8?B?aUJ2dlNubUZCU21lTjYvdVoxWE4yUzkwUGlLVHNnUG96KzFKNjRDbkxOM2ZZ?=
 =?utf-8?B?TnljVng4VnptUmNCK0xXR0RDc3MrMlplaFZ2bktOUW9ab3UzM2ZPajl0RWdW?=
 =?utf-8?B?NTFHT0xkdG5Gckh5bDltV0RkdE85d1NSTzVWYWtiUUJGUnY3c2l2ZDJIc1Mz?=
 =?utf-8?B?ckRvTng1ZEhndTBhMllsWjU1eUpLY0FBS2VkcXZtWUxqd0RGUWhRUXZrSHpy?=
 =?utf-8?B?V2dvdDRsR1N5U3p0NEwveGsvZ3FUTmFXTWFiWjM5Skc1TVVLTThxaFF6cDQ2?=
 =?utf-8?B?T3dXcFhLT3RSKzUwMjFhSVJYT2hqaDk3SGV4Mnp1cDFPS3FDTm1OSUVUWnJ6?=
 =?utf-8?B?eWptWFVrcHlDWlQzelBUVklzNXliQ2ZIbmV2U0FSWnlPQWJYQVkxL1NYRG01?=
 =?utf-8?B?VVAzbzlmZE9zT1NqWnd1N204TytoZWN4N2JZRVFhdDNYN3pTWFhiTGY3OEk0?=
 =?utf-8?B?bXJIYTIzNVpLejJBRWRnNnBuUDI0eVlvVjlieDFrQ2lKakJDTkRpeE9uT2lH?=
 =?utf-8?B?ekRXbXNmRmpYSmRWNWxBSVJCK0N3SG5sSHhxcFIzVnBiNHZFMHFwWDVVZHF6?=
 =?utf-8?B?ejhjWFZBZDFKeXE5YXNXVENlaHJLRThiNksvWWVuZVNJMzZrQSs1MWpFN0Q4?=
 =?utf-8?B?TmRacEw3aFVBSHhpd2hEcmExMFg2dk8vTzVrdk9rL1B4UWhyWEpZRzd2OWo1?=
 =?utf-8?B?RFBQOEZvb2NqMmdUNHJWUUlKYXRjUHFZUmZxemsrTnJza1hyYUVqMFBpb3E3?=
 =?utf-8?B?VXNKNEZ4TzdCNVVud1htTkdyS3k5a1Rrd2VPRHhCMXArdk9PM3ZhZURBcG83?=
 =?utf-8?B?ZzJYczNxS1ZCUFlEWmhRMkI1K0ZqQjE1RnlPVjhwUjFoa3dZbGFiNG9hRXlS?=
 =?utf-8?B?ajFaT29XS09ZQ2ZQSllkSDgranlicFpJOUpKSnQ5U0J3ZS8zNC9XSWpYbFJl?=
 =?utf-8?B?R2ppNGF0RnV4NzVzYU9ORk1TVUhXaWZ3czZNckJ3RXdhc0JnT0pyWkg5Wm53?=
 =?utf-8?B?dyt1MU1qYVJGZDJZMkE5Y3lRTGU5MUxKQjBrNDlJeExiSTQ4RDF4U2hreERK?=
 =?utf-8?B?UlQxc0UvVDV2UGkwUVVNZ0tYcVB1VXRNc0VWcE5xZXAxaGxsYzVyNTkwa0Zh?=
 =?utf-8?B?cTRUSFpUeUk0MUVBYmJ2eUVzL2JoSnFHcVRnQVBkTTVXQlVrNG9idnFwOWtV?=
 =?utf-8?B?YTdSWUlEL3NiMzhNSkcxZytDMUxja2ovQkNmb2RhcmQ2SFVnQVd5elh1VVZi?=
 =?utf-8?B?S3ZlQTBvWTFsRmxxTGFPYTVvaUtSRkxkWTJSU1phN2h0OHBXTkVUb2Rma21w?=
 =?utf-8?B?STVPWjdHQlY0YklUQ1RZNkk3VGVyT0VUY3pUajdSM3MxNS92U0UxdnVxaDJa?=
 =?utf-8?B?SmpyN002K0VxMEovNkdqS1ZLaTNMbkxvQ250SHZQMUR1dzZqVW1YaUwxek9w?=
 =?utf-8?B?YVJhWFpDT1A3WFpqSVNodERGbkJud2NqeGZud1BVeVZPT05ieVhNTUFsdmJl?=
 =?utf-8?B?NWFGQnhmeThHdVFPUk0xTlk4bUw0NDlHS25kd3E4dXNITkJlcHp4bDF3UWV1?=
 =?utf-8?B?STl6L29BQ3FTWlZqbXR3MEE2Q0srNGdzc09vcGRocU5VQituQTFKcjVMNnVR?=
 =?utf-8?B?Q0wrblJwNXNBN2tMR0JHanZlcTlLc1BWV2RKK0c4blpYWFE3czhPaUFrbHBi?=
 =?utf-8?Q?L72/AN9Tfa+RoMr5pRicCp73n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72d61d3-22be-4957-226c-08db5a958af6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 07:24:13.4919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNB7oIDy5lITB2dv+wVh9pJritKCOQlt5QNeN4NHKUdkHtfvc1lsuM2YneQbH9QK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Srinivasan

This is fixed by https://patchwork.freedesktop.org/patch/538022/

Thanks,
Lijo

On 5/22/2023 12:41 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the amdgpu tree, today's linux-next build (x86_64
> allmodconfig clang-17) failed like this:
> 
> (in function gfxhub_v1_2_xcp_resume)
> drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c:657:6: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> 
> Caused by commit
> 
>    c554a01e1c08 ("drm/amdgpu: Add GFXHUB v1.2 XCP funcs")
> 
> Reported by the kernelci.org bot.
> 
