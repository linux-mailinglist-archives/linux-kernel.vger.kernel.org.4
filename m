Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D65974D763
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGJNWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjGJNV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:21:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08502FE;
        Mon, 10 Jul 2023 06:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ao1nt73lWyzNBb7P5FJjfbCXU7iDQBwyM4XlgJx8UjytQ4IKGfZ+LuHQ59/RJoXT1WvnaD52nyv48ta1P3TEA+7joSnsM40WykYIvboAlCK5+wPoY/b64YZBFqs3tKpapHPdzh1yy7C1o16zAQJ3OkRDb24JtztelHxwnEVzecjT/h6jBQRWGTV4NAkIsY/JaKPBqcpR2WlEjOqVI9ZhQQSXwQExLwoSG+eSukKDZXRrPKmrAoQNomeeFk1NlCR7qLqNxa8NOsUL1CSDR23psnQmoHs40XjHqpz370wbjxHq+mzg8D8fLVwhL8VtRNAZmaiPCD6bqpZCR7j33Q/Lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HWUHvlYLel9tFFnh4GIFMznL+x1KU8noy3KB5XpWGo=;
 b=fykYDeSU0Ies8dX9+hgCv7Xls/Mezkw+Im2+0W+M4wRFsJnjJZdoys3pUBcaVNiGou5Vll4COB9ZqOz0+h9g6onSploTdJU1+Gk+VacJvapH39TyR/uHD+hmyEWMAxk1HRT1MMAa1KlFCSkmmTxenUuSd2ZXqd0jgpD3zW8Lq5iWTSNt0jzf6OuVTIsSJzuNP3leUw3Co9wbUKcvJIjO0wuOUAsWPj02G4yH3BiCKeF2EMELZjQQ//w1KCfove6FF+VCt4nJ+SQsjuDVe/LjLTByTfflajllignx5bkIfnhAbAC0JGvPvmhs8B0P8uVL7OcGlRCb71LH77PdxcYdgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HWUHvlYLel9tFFnh4GIFMznL+x1KU8noy3KB5XpWGo=;
 b=Toy45aE5xGU1p7wz5vtkbhhfkzjiZSanC/Jk/KzJydTbMOIr2gJSRebDvxnEb6BAj3anEhj+IrVFsgxVPjs5IBptAgXj2AzWh76/E4Up1AUcHS5MiSzNPilVbd7WC20+zp2lImAkHQQXS6Zg8SZroVI2qTrbsshxVM4KnnJtD0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 13:21:48 +0000
Received: from DM4PR12MB5295.namprd12.prod.outlook.com
 ([fe80::60d6:aa8b:170a:7e93]) by DM4PR12MB5295.namprd12.prod.outlook.com
 ([fe80::60d6:aa8b:170a:7e93%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:21:47 +0000
Message-ID: <54adffa8-b500-e1b4-7274-9a5354be8cfe@amd.com>
Date:   Mon, 10 Jul 2023 09:21:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: Signed-off-by missing for commit in the amdgpu tree
Content-Language: en-CA
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230710082534.762599c8@canb.auug.org.au>
From:   Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230710082534.762599c8@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0213.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::13) To DM4PR12MB5295.namprd12.prod.outlook.com
 (2603:10b6:5:39f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5295:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8113c4-f62e-4886-ec6a-08db81489d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0V+JS1jNXmeRwuCXDrZ1jLrYmgEMYBBl+ON9gfIVZXQG7zLgXKUARzHJ1Pu0wxct4SxFjPRhUeBCHoB0wf8ilxsQy7LeQjJoR3meblD6uW706AcUmZZSeJN7VAP4t/NcOLwUDBFMbW93YT2J+kSG9gKJncvjfdGmt2lmtf/4hNo3Gkfcdrb1CwsT99Z7xiOJxwYqeK0Kwy1M5ueMjn9z2+nbqTFsV2hp5v2hB2a8UnSqGW9xIjoVR99Q9VKTMaenJfGZpmwhR38/sM2pDAZlgm5T2lkrpsprDozx+u0P+QLvmzWk8vaPoBIerimjstqYlAipJIuoh3ffMXS9Nf29WuWoUFv+r9A+IolnIB4wJLSEDDLZ8zD3dqDNwx/11pW5wYnLQUwAirpY4+C4RprS5MpEusXCA03LA4d6yxMcwlAM13mVDpjTXfNjhZHZH8/au/BFH1vTuPsDyBSmpYgEaZVwgDAJyviZ8afDURh3H3HphzySo/tT2ot2x1B54cROR16zyXu+SO37ksr3I+xAqlm1Sitf9s4oCocfCQlRerK+ubff/hi/cGz4f5MnQlr7RB00Qr4wonJNYT7wftPfhQd015Jj6LN7QqMa+6rCAXnpWKFkIg3+566k2LxFieAKUg3qJpaOjQt+W2Rp6pGDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5295.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(186003)(53546011)(26005)(6506007)(2616005)(6512007)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(44832011)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(6666004)(110136005)(54906003)(36756003)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUtDQ3VnOFFsTzRlOHEvUzM3ajdiVk90MUlYdlJ1TUhMNjhGU0sySkU5SXcw?=
 =?utf-8?B?dHgwRDZmc0RyMlhNeWhSUGtlWEJFbDNUM2pmWFlSQ3ltVWxya3JjVHVlWFhN?=
 =?utf-8?B?Y1dwRnpFSk03dVYwSDVqNWtteW1lbGNQbExCRk1oTHVrYzYwb1lhOWlqak9W?=
 =?utf-8?B?dXVsM1JCN3VXMSsrOG92QnVXbFI4UHMvalhmZUZZZ1NxVEN1N2VBVzRZWXBN?=
 =?utf-8?B?WTRtNDhVREJTdCtkSXFWUGtIbEw1RWlqNlFkRVh5L0U0WHRqLzNJaDFxc0Nt?=
 =?utf-8?B?cDNNSVMxRlQ1R2lvSFU1Rnk3YlNuWW9aSW84KzJxaENwZWIrbDA4S1QvWDZi?=
 =?utf-8?B?ajV0dFpuZmNuR1BYU0JtTmx0Z0NwdUFCdjRKZDVqd0JVMjU2NXJJOXBpMWdl?=
 =?utf-8?B?VFk2R29BVW9VbkpaUDR2aWd5YzVEYWRSVEdrTzFEcDN2VjJHdjRlNVpROEE0?=
 =?utf-8?B?Q3lzd0dnaHFWcGZ3Um9GRk1uMFpJeDZwQUFCMzc0bzErRTZnTHA4VGVsMnVm?=
 =?utf-8?B?WkJ1MTNjSno0QVc3MmJsR3hqTHNOaHBkZUN6RFpNelZNZkw2NUVXV2dlSEYy?=
 =?utf-8?B?dEpRV2Z6QllSNGwyVU9kK1JmZE1EY241OVpsSTF0TWJkek10akJSL3NBRVRC?=
 =?utf-8?B?cWRBZlZlNmkwYWNLcnN0TmZXdjVPS2EzdGpCTnFJUTc2L2ZyWGVadDN2SGRD?=
 =?utf-8?B?QUhLYUxPRDJzY29Rb09lMWJLSm42RTB2M1AyZERXbkYxMFZtYk1jYlFIOHNE?=
 =?utf-8?B?VTk2eGlFMVhnS0ZLdlczN3M3UTJWNkQ3L2k3UjZQOGkyZjNFaFE4aGwxdFo5?=
 =?utf-8?B?UWJiOWRQYTlENS8wTVhmOTJsdVZaa1p1OGdmYjBVazFGM3FPZFZKaHlUK3k2?=
 =?utf-8?B?ZS9SaWRIWjkxSkNISnJVRjh5Z1AyWHhKa0JLd2I0eGtmZTQrTURUZ2JrWEdU?=
 =?utf-8?B?UEkxcWRkUWIwTFUyUkpLVjV1SjVFeXUxYkF1QVdmMjB3bG90cm9zRDlZOWVj?=
 =?utf-8?B?T242enVlaVNqQ3ZneGozZEVRS2JWY1hjcngvRzdmWGIrOWEyeU1scjZDaUVD?=
 =?utf-8?B?c1A0aTIxVTBuL0w0ZWw4OFdRVmxIRFRocjFtdDMzSDZlVy9aR2tSaG5MTjdn?=
 =?utf-8?B?c2hGdzVBUVAvRzZkVSsybDRNTHdMYzRZQUhhZ056eEFrWHBsajNzRXlmYWE4?=
 =?utf-8?B?ZE1GOTNiYy9ySjNWYXlINHR4M0lpMzZOeG1xazkwbHpLWlplVWJsV2orRGtT?=
 =?utf-8?B?WU5TZHE4OG14V1NwUVhaOE10VmxrS2g4N0VZdGx5V2cvVWNLVFYrWnVRcFdO?=
 =?utf-8?B?WjBqWE9mSEdrYzdFeTdhYWtQOFpnb2RoaVFWYkMrOThGSWhBVVNwTFY5bE1F?=
 =?utf-8?B?WXU3ZXZ6NWoxQTFFUThQTGRyQUFrOTF6ZkdxZWNkL01ia2ZGSnN1VGxVSXJH?=
 =?utf-8?B?VG5DbXNwN0pybURBdE1pdkVkQ2RycVRyeXBLWWtVc0VFek96UlNON2Mrbksv?=
 =?utf-8?B?NEIrR0l1dUluN3BrelowWGwwYzlFSGlZbVd4QzhpNTd3S2kweUdHSk83QWpH?=
 =?utf-8?B?S0Q2eGZJSnpmb1BUUDViakdDK1JoY21oMmxjWUhsVndtWk5UWVB1dDZ1R2Ev?=
 =?utf-8?B?aVltNml6YmlDWndYZXdTcHZUUzVqZUxYNksrazdJelhldXRYNVNEZ01Jdnly?=
 =?utf-8?B?R1cwWjMzbmQ0a0tuU2ZQNnBEN24yRTJCcWNWWUMyamx0bDJsNXVlQm5qUnJI?=
 =?utf-8?B?VXlQb05CME5wZS9lUHJSK0RDZHVTdGhzbnAyRm50b2J6NitkbnRaT3MyWXlS?=
 =?utf-8?B?bUVUbDZmWVdGVG5xZEtQTXI1QnJ5dUtKSzF0Uy91aStNSEFMb1dZUFFXbGh6?=
 =?utf-8?B?S2NrWDRodTlacCt6cmFLNGJvcTRSYXg2VGtCM01VYjNkVXpHY1I5azI5REYy?=
 =?utf-8?B?RTIwN3dweno2eWpyMGRWdGdHQ0trUjVyRWdtR1hWMGtIMmFJUm53NkRMSW1t?=
 =?utf-8?B?WUZaMkRTejBCZStwVEpRNHg3Z2c4OHJLbVBuTUtaMzA0SkRUZXllNWt6aGQ3?=
 =?utf-8?B?MklicmtHdHpId3ppbTdHQjNHeTIvazRmODEzT3NHSm1CRHlJNExaUXZEZFIx?=
 =?utf-8?Q?sIDlWp156BkgM2lIHjSO1KIIE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8113c4-f62e-4886-ec6a-08db81489d15
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5295.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 13:21:47.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STgnzeXRGwamAyL4GMMytc5r7EZKJyLlceRzN9KLhUHkl/pm/aP3vwbKI2L0bemygRBJ1FdHKdtU1QNu62hTWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/2023 6:25 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>    aeddb7d13ad3 ("drm/amd/display: Block optimize on consecutive FAMS enables")
> 
> is missing a Signed-off-by from its author.
> 

Hi Stephen,

Not sure how the tags went missing, but here is the full commit 
(a7d8d8bcbd9af8d4aa1580bffd418af78384040f) information from 
amd-staging-drm-next:


     drm/amd/display: Block optimize on consecutive FAMS enables

     [WHY]
     It is possible to commit state multiple times in rapid succession with
     FAMS enabled; if each of these commits were to set optimized_required,
     then the user may see latency.

     [HOW]
     fw_based_mclk_switching is currently not used in dc->clk_mgr; use it
     to track whether the current state has FAMS enabled;
     if it has, then do not disable FAMS in prepare_bandwidth, and do 
not set
     optimized_required.

     Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
     Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
     Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
     Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>


--

Thanks & Regards,
Aurabindo Pillai
