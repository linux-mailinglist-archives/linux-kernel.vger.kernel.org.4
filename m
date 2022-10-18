Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C848602FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiJRPo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiJRPow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:44:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C4A1583C;
        Tue, 18 Oct 2022 08:44:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IDxiEL005979;
        Tue, 18 Oct 2022 15:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KfbhhNosA+WBs+y3aTVYe9LVhIBJW+pdgotv2mt596Y=;
 b=joerbc5zi/P7C1KwwVyovT1fsY9K9Q1pHN43NB/XjZbHZMvz2jeA3uvf224oefvZAuD8
 hoFL+9mK4AH8Fhc6jZbNf/bNXOLHN8swUeJtBSK64jwSK52/tnIRmQ9Xorp+CDujKykz
 TvAlkybrs52VHijVT8QHKwgffgln41Y5h2FRoCP6MzY/gqEzmybDBZCvwmt9eD21viY9
 tl1u03eonAgB/qn4qK0l/y/wzJcFOwp6Gi75nWvFq/lWU1XIb1+ROnnOH0SFi1nPW7LR
 F32IQq77xb2iYSQSt8H0CaFWiZzZXqOayIDhax25Qe/HckWjMuL+f3cC22/MkvxrjbFC lg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntb9cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 15:44:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29IEeXiC033274;
        Tue, 18 Oct 2022 15:44:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hradt9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 15:44:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFOXsEPlJWMK7kGZkTpYM+IaRubL1UrclI3HB76dJuEZMNe6yXisF/Q+I7oHSwv3wIRFt1K+BA8kUw3oE6Stk5ouRdQNiWFQ5tKwiLaBdv0gWO3IFO2P+r5o5ZxcnMVuIFvQTUOz/j73MACKcbVOj+guDuHbAB8Ozp4SnYzmGTFpbEducIJBq6TnfoQH5ySxL05hX8T/SPo85QQ3Ib6tc0pM8N5P48xV8A4r0uoQ1k3DSsUQ1itP2pHXRxu13aAU6EMIy7lkEtUn8540zQa/hz4sxxtdEXhhdB+szKaeGuu8BbbPMVLKWMu//KkdkLvIx0pkI+Zav49T8jFQPtc9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfbhhNosA+WBs+y3aTVYe9LVhIBJW+pdgotv2mt596Y=;
 b=RWxg68z/PL5KGJEzU1uid1P3dpc5AJ+/khEn/j8/kek5d4QshtXXxxJjnIAi8sVLrAX6eDM20giaOLwKV8MKbuWbHe58zthapK0+hLXJqLfKh++wgtaZc8sAXKYFkD8s1q18lGATwQs5AQSxGdvv0TTo2vlLE+8MnRrVbivBkxl2SBtxgoESHAOLZ4kpQDy4sKblV0e5WqjWZqdIvxdZ2IL9Axs5U2AA032edDPliCskS5nrMFeNSmZbOt5LqmwzEkOK5w6P2asxIPc//3aKSrZJCja+jk2MDFaxDsT7LcJ1gJZrggfeLKtk0qO0gHc9c+hEMikoHyRHWh5jW2POCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfbhhNosA+WBs+y3aTVYe9LVhIBJW+pdgotv2mt596Y=;
 b=DZ5X80Dzg9gc4sMH9ufH0ge2harcb1MGSHSYaAK+3/9ZelzoGFHLDggKZAmvCV3AlgYbOacBxk8bx4M+I/5jgXwBguRFRy3Il/jOPggtC/rCRIb597FW6glD8tR+7wzowqgo2nLz/d7GN9PJv2Soi9XYHVr2nmvSA7UYOKigxoU=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CH0PR10MB5017.namprd10.prod.outlook.com (2603:10b6:610:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 15:44:32 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 15:44:32 +0000
Message-ID: <2c02b2de-4fb3-1ad2-5a30-614f9550c108@oracle.com>
Date:   Tue, 18 Oct 2022 10:44:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH][V2] jfs: remove redundant assignments to ipaimap and
 ipaimap2
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        jfs-discussion@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221018152310.941770-1-colin.i.king@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20221018152310.941770-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:610:57::37) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CH0PR10MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c05e085-031a-42f9-4781-08dab11fa6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: beD35QvKBMPdb2cZhmZ/juaBndiv0L28HS5m816AZGSaDBKIc8qM77ZUOhTR/nI4aZOJaH5jH+5tKnakMyffkMh8mrcXX/PEXrN7uJdHIoKtEb7hsots1a9fKq10SKW90mFeE1krHgukOzAc1VOnxEE31exltBJKpqxd5H5aVRIsIy49cg/q7OxUxzuB34w7XF64VAQDECatuTBnR+ZfKYwqXo5dZmV/BlFOScPw+gvaiS7gWZ3cE6D+5tZqhjTwixMmDAbLNk3TLPMpTaVhxyuQO2DAuCNOmoXBuc4NpMCrVMk3JvTawrP+vD2fOd3WXwcXqt01pU6yUqtA1BqQaUl3pQu2+crMdto3jE/ARm4xOTOeH4leaFCfn3i3FCBpfN5bTKP9Xmyiso9hnAGrVkEl3F8ahiWhs5KqwYnAE+8LdwbNtkFLsAAyizqvr+NjNi14fHj8pgOoIvliTjHvTwOpkKoQwLkoW3cIHMkE2k8q3ZRRSJpI1kD92FAwqbxjjby7JD8gQT2EUpZ77CAolpgR92Ah5jH66QZzjR+BZNP2uAiITJAtKDmd3yE6RazQboN5jUyYFjafEQo7xrorkNJB+/6zWPVFL1vPuFYLthst76jV+6tICy3MYaIpfajlCTZjyvuxLZYjp7d7QmqhHxq8QRUTwrth+3aB5sG1Hzdd5yQInAhCqHM3V2khVjARTR/d6uKga283d64s6S18vRRIGXK6N4oTq1iElwipf75UaNWsUUY3x7RwImPE02NOknV9i5Y4dzF0BcVfKOcr5vB2ggRksCN/S3+QeYD7oys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199015)(2616005)(6506007)(36756003)(8676002)(66476007)(66556008)(4326008)(186003)(2906002)(38100700002)(5660300002)(26005)(66946007)(6512007)(8936002)(83380400001)(44832011)(41300700001)(478600001)(31686004)(86362001)(31696002)(6486002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFp2eHV1czNoaEh2aVlNSDYvSmxUdmIvQmNReXIvNkxkQk5RcjBWU2ZkL1Q1?=
 =?utf-8?B?K2xjQ1VmVEppeWovUERZQ3Jjek5KSDB6UmJvNEVYTkFBeTBGb1ZrdXdLamFV?=
 =?utf-8?B?MTZYa084RFhPL2daVi9xVGpXNDlkVlFWb1BZT1FzSUtOSEp1c21ZT3daN1NX?=
 =?utf-8?B?bGNoMUhFbjY3cjJSYXFTdkp3RlUzcGtHTTd0b3lNNjRxeWwraTEwM1lvbnUv?=
 =?utf-8?B?S2xIMC9ZZlJXQWRwMXBhbkMzMWNjRTdCdDl2dVdFWVFDQTdOSS9BejVYaFdX?=
 =?utf-8?B?TlZnVTk0aHY5M0x5NklIV244MDJDS2pwY2lkM1A3cUJ2YUNxanRGYVh2Y0lG?=
 =?utf-8?B?NDZxVmRRN2pnZTkwZGRiVkVWTlRtR2tseTlBSllxQ21tUE5JM2tVeXRyNFMv?=
 =?utf-8?B?eVRsYk9JYjBzTkNzb1YvWmlGRGJLTzJiS1JOeHpZTitzSVZLVVlPTzJzRUdB?=
 =?utf-8?B?dlJvSlBwelJoelBkMWRvcUZ0LzRkc3g5b29mM3FFOWpNNjZaWnRmalhkUFRn?=
 =?utf-8?B?cnZ6MWd6cFRmZVBabVZ6ZEYxVUh4QXl5dDBoZndqemtoekluYXBiN2xEU1h3?=
 =?utf-8?B?MGVNVlBKM3pVSzQ1OVQzaUhkTmdFZUZBUExRNnh2aGZyMEtmY0RhOFhtVzBJ?=
 =?utf-8?B?YWZGSEVwVnF0Y05SQ3Y5MVFPSTlkMTQ1NWdzQnoxcXdxRHFzZVVVV0hZOVlB?=
 =?utf-8?B?d09LRnovUVN6Sko5ODVQUXZ3WjB5dksydVpWWllxSkEzVkJmYkFkdVRsQllK?=
 =?utf-8?B?M01MWE02cW1vbUpZMVhZekIyUEExVmdtN1BmMEQrTEJEYUY5MndxYzBna0F0?=
 =?utf-8?B?MkZETW9TMmwxRkNEbXVCemE5bTNibFd1aVpqTlMwbkFTUURqdEhoMmFySUYz?=
 =?utf-8?B?VVpYbWp2anRpczN0SkhQMGFwUWhlYlB3Q21jRHV0VUJkSzN2ZTlVcWFaNGlJ?=
 =?utf-8?B?M0t1dTFVVHRURVpFZHhuR2grYWlyTjg2T3owY2FrcURVZW9VVmpSczRrbTVJ?=
 =?utf-8?B?ekxVL2dabXJUdm5CMFFCLzNYcDZQb21lOENqRGFlckNmSmNRTXkzVXU0U3hN?=
 =?utf-8?B?a1NrQXM0MzY1ZUt0eVZ1Um1QbkxVTEdmUkpsd05LbktyOUhuV1BLR0lvTEdF?=
 =?utf-8?B?OWRSSXRuOUR6aGpWTHpYcm1MN25oU0dZeXNDbndsYjliTUFwVHJ4WEdJNHdR?=
 =?utf-8?B?K3VieHpmbzBPZjRUYVpqSG44UXN1aXRWZSt5UXF0eUUzZXdKLzBJYjdKV0FR?=
 =?utf-8?B?VE8zMU9NZE5BcjRSUi94elJORE5VYmxGVkpFMEhlSlIrS2VqcTdJWEVPeXVa?=
 =?utf-8?B?RStKWlIzSW9pSmpGSUlmdGV0bHlBc1RlWDA3eG5oZUtEM0M5UEVJdkRKN3FT?=
 =?utf-8?B?ZnNraGs4TVlwN3V3ZHIxV0ZmbHdOVGdrR2pzVStzbnVoRGRlelQ2UE91cUNi?=
 =?utf-8?B?QmZxenJFbjVmYUJ5ZkJZditvd2xBN2ZpdUtCd0phRkcraEtueW13dWN4ZHVW?=
 =?utf-8?B?Y3JoV0REbmczbG9FRU9XdmZ2TWpmVHlrU0VnM0ZWWWg5YzExd0pIT2kxOXpy?=
 =?utf-8?B?U2htc2NyWkU1ZG1ZbzRGYWI5Wmc3TTd0RHo2Q3JBZnc0MmRhUktkWmFjYVRk?=
 =?utf-8?B?Wm5ldENFdVlIR0ZvZUQ3b2NQbkxybjg2dDMwdXhOcHVEY090Y0s1UVBobk9K?=
 =?utf-8?B?M2ZXaDBNTVBTb0xyREt1aml2c2w5UnJocXMvWHljOGx2T0ZDNm9xUDVNclBN?=
 =?utf-8?B?Q2VOTzhIWmFjKzFZSWoyTUw5SGovOGhHN0l3MzdPU2I4R1N4QWVBb3MzODJ2?=
 =?utf-8?B?a1NmNWgvWUllSHFDRnFiYW4zWkZFQWxpcGJLUCtxRkxjVjllWXpKUVpkcFNw?=
 =?utf-8?B?N29EeFpoVVFnUVZ0bitsa1VkbWczREsySDdTQTVLYW5wRGw0U3Z1Skl0OXg4?=
 =?utf-8?B?Yi9iMlJvV2cyY3FBYnFmdEJERnp3Mmh3eHhEOW1QK2I4V3Nob0Zoai95YUda?=
 =?utf-8?B?TzZoQTZZSis4SGwrZE0rUE1NN0o1eEVscmkvdEpKeWRGR2VTVkM1eEZoZkRR?=
 =?utf-8?B?RlU3eXBlbUJaVjF3cW5KdWtXV0sxSk9kWEg5RmdSUTdyUi96WUUybElmWWU0?=
 =?utf-8?B?L3daeG9zVWxJTFVLM3JoRkZiQ2tSLzZ6ZFhJU1VzaTJJVWhFTWcxSG9nZVJq?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c05e085-031a-42f9-4781-08dab11fa6ad
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 15:44:32.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZ3vNLKR6XyNhiX3iRE6wBrz5t2AEZGrhYNAOBpIWSIh2vjK/kB14fJ9NFaJpc4OnZ05L40nUZIMCjteimvM5pIwdb4KqGvCmvgSgEQVpZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_06,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180090
X-Proofpoint-ORIG-GUID: yX5upKYJvUlFggn87Wku5MuevZOw_9Q_
X-Proofpoint-GUID: yX5upKYJvUlFggn87Wku5MuevZOw_9Q_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good. Applied.

Thanks,
Shaggy

On 10/18/22 10:23AM, Colin Ian King wrote:
> The pointers ipaimap and ipaimap2 are re-assigned with values a second
> time with the same values when they were initialized. The re-assignments
> are redundant and can be removed.
> 
> Cleans up two clang scan build warnings:
> fs/jfs/jfs_umount.c:42:16: warning: Value stored to 'ipaimap' during
> its initialization is never read [deadcode.DeadStores]
> 
> fs/jfs/jfs_umount.c:43:16: warning: Value stored to 'ipaimap2' during
> its initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> V2: remove re-assignments rather than initializations as per the
>      recommendation from Dave Kleikamp
> ---
>   fs/jfs/jfs_umount.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
> index 3e8b13e6aa01..95ebcd17ce75 100644
> --- a/fs/jfs/jfs_umount.c
> +++ b/fs/jfs/jfs_umount.c
> @@ -68,7 +68,6 @@ int jfs_umount(struct super_block *sb)
>   	/*
>   	 * close secondary aggregate inode allocation map
>   	 */
> -	ipaimap2 = sbi->ipaimap2;
>   	if (ipaimap2) {
>   		diUnmount(ipaimap2, 0);
>   		diFreeSpecial(ipaimap2);
> @@ -78,7 +77,6 @@ int jfs_umount(struct super_block *sb)
>   	/*
>   	 * close aggregate inode allocation map
>   	 */
> -	ipaimap = sbi->ipaimap;
>   	diUnmount(ipaimap, 0);
>   	diFreeSpecial(ipaimap);
>   	sbi->ipaimap = NULL;
