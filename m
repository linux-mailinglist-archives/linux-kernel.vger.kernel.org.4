Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94546624D45
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKJVqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiKJVqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:46:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A3A45A2C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:46:45 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AALNAqK016673;
        Thu, 10 Nov 2022 21:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EZEC6GRLY53sru7ry1gVpk4DuZ3LewhXC/z/ps0PZoo=;
 b=ZLx9Wwr6o309KDiWs3wrw2gUwKekleucpX5JacNb+HAxP4gbuZ8HbDGLAPAMfBVfWRUc
 9eEPH6TYQiKFx/qgAGPNJw1XdUC1HlIjqVJTqfOgzorspPY+vl9dS+mxQNCbs7NSs3t4
 uLLDQAGFsFcciDAYaM7snprVzCCJt/Z6B/fGjixFPK2BR7Km679vdLpwdlcgQ6kvT27f
 lz+F4xh7YN2AawPLyVaygzkRbLjaPfrkl/XxnPPW+8fDxsqBWphFNGJH9DeefX7K8h1D
 Jz3+HUiJSmA443tZnzoilShvCAb/Hvx/q/EUPoZRozzg0QV4p9Oe18x5ykTnCgOgPQ6f Uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ks95nr2re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 21:46:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAKWenF038125;
        Thu, 10 Nov 2022 21:46:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsh5u2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 21:46:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekcumI9jPkqA06O3j/pLBlxVxEsACj9xxv32e/Tk3PevYnoIzKfCzsRru9dopgJeOUyo+V2WMJuztdyJU9IXE17fUypY9JHRxDR4z4drFTqbAZ9cGqHQyXgkgT+eKftMr9ZKYViD5v2uQUrUXzd0G9dOhWY/564RVcXcd03B875nIex7UIjgOtonxVssRsrbBOuCKdBVKq6WDDxw7LVWA4+OiRAMtEcK7ej8+YW7PHBlSQ3vyF7YVJWwN8ciFdv7rV5Z5qb7KdYzc1dwNMoQWzNTiGPFqM8uI4kZBUZCg3NdeWnq5rkvqMmAiyjapK/vY0NPy6Ynmmohz4aKIPb4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZEC6GRLY53sru7ry1gVpk4DuZ3LewhXC/z/ps0PZoo=;
 b=kGRsSpTj7LdPnbeDAf5Ub9wSfnJMTBciZSgrsAvjLpV/aXuWSawuEA8C/r2LLA506c264YUD/ZceJd3CyCEZw/iPOm4LsNFYKYFGUgBj4ERw+0+UrvurIf94WNfyfTXL8xG6B13+JEXZIqAFY9WWLAdWDwnKJ3DNbpcs7XTQPAS2LoEfJW+QDvtLTzgnmmSmAimVaVRJACZhEwqc91tLWN5ZpAmgGj44zc6uXdzTcgkEz1KWsfhjO3HEsFGNRnlIRbfGuT2fsZyNQM/QIpSC4m3UN8W0iUj7FNvXhFSNY6HoN7qXT+mcszyktsiJingnL+AsQt6ZcLtFEYZfUtcR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZEC6GRLY53sru7ry1gVpk4DuZ3LewhXC/z/ps0PZoo=;
 b=oEgHGIA2geAjmyQNEzHtG9kHrQxxc/h1MVUZnSCo5aiEPsUiOwL45WLeFuB6pDfvK/Ka0nfYTpjXpvorUM5AQlxB3AxGp7+3bZI7WsgNNzgcQDyzjWJGcJQNPoI2Sp7wI6njFJp8nsUBU5RUTmE1/Lk0VVRKxMFQmY+7nO9GReU=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DM6PR10MB4377.namprd10.prod.outlook.com (2603:10b6:5:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 21:46:12 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::cdac:526e:e65:cfd8]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::cdac:526e:e65:cfd8%6]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 21:46:12 +0000
Message-ID: <1cd321d7-9227-b71f-ed7e-b0a7509dc3c4@oracle.com>
Date:   Thu, 10 Nov 2022 15:46:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] jfs: Fix a typo in function jfs_umount
Content-Language: en-US
To:     Oleg Kanatov <okanatov@gmail.com>
Cc:     Oleg Kanatov <okanatov@astralinux.ru>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20221028121639.19341-1-okanatov@astralinux.ru>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20221028121639.19341-1-okanatov@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:610:cd::29) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DM6PR10MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbfb244-8335-4c0f-7dec-08dac364fc44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7sS68Q8K7S42DCbyHLAVbX41/krQ3GIh3fHj17Owf2o76a/DTs+/oQKizhmH7kP0Z2kyA+Vp9wLbletkbx5dE6ojNG8qlBF4ijsCiRK+MSWZgwEVMewTnURFt6RlVkVEcpGOBuO41x9KAtq7DCucc+I1zIu4W4M6voERoPqHC/s/t/M4I8bBZTzXQpDpuP28a+6dqZmxrRjkIYfdpjKNC8xM246BOrIIXGKMvs946XsDByr4det9p318kAhoC0uxvIi6pfKWTRIvi+HKA8tmuJMRjUctom/xFhBX/r1MIhpaxUE0QjFDex/Yw9xGJV1GVTz1gHp9nAotQ95v7RcDTYVl1qlRk5m0TU42b4jEtim5wUdHWuaf1ZW4eJ7Jjdcbm/hBr0e6QRxMR8maOpTaqZjTD3h8dsjB6oukvCZCyJjC4rC/m3e3fcClsB/mRXwZoP1RcTlkPj0uIiNFlOwEhNwB66z/p2u+LMiHEUqssmgsWnBX+Fiu+dQbc6/yQS4U4GOVLB5wqSjfqjkF38rbvgDJXTtdrJt/KhAAfHmR3tQN1N5GrPeFXTvlXOYGlZm8pxIrBaFKvdegtbXUZVKBtfMrSJk8RWmyHhcvrL/sIRaQwFwG+oTFyEbUzUFfRfUbMGLqSavI3t1ltMHCH3qU1Ck/6z+XIgDxY0sEuftaYBRUiZlRHDTn73rVJVqq0/U84TaYi0eOuKrOpjrNeJPXZJDuGND+Z1KSf8oqLm3xXBTNxyiM5+rAqsEGK2iAtCkuootoCd4dkX6li7Xbs+9kt2YeEFeUwbLHtFY6J0hZTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199015)(6916009)(31686004)(6486002)(316002)(36756003)(41300700001)(44832011)(6506007)(478600001)(6666004)(4326008)(8676002)(66946007)(66476007)(8936002)(66556008)(26005)(6512007)(4744005)(2906002)(5660300002)(31696002)(186003)(83380400001)(2616005)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW54ZEFuQVd1WEgrRUl1MGRsQXQ5dlR4T0ZPRzk1Z2FMVFFxZ2pVNWNrNS9p?=
 =?utf-8?B?RngzY1FoNWFqRnZJK2NGZVRxRTExcEg5dWpZZlNWLzdFbWpKODArNWx1alBp?=
 =?utf-8?B?UkdnSDY5b2MxRXhPc1FreXI0bnJZZWJDTGxRdjlJbm1ZTHk0dzUzT1NtZkhP?=
 =?utf-8?B?MEM5QTNjOUNZTkZIRFlJdUxUR2ZJd3h4MGpHblNUaHNaeUdDdHVJRmplRTdH?=
 =?utf-8?B?bmFBVm5jY2lBaGJ0NXJOd0Z6ajFYT3Yrb2NMZzNCSTIzQzlZVEFPNmFaY1VQ?=
 =?utf-8?B?aFpIQVUzdVJvZXQ2SHJ5eFhqbXVUTUlvRUl0NTJxT0ZEb0FGRUtkTkhQNjRq?=
 =?utf-8?B?KzFwZVNzT0x2S2gyYURPdlFkNTlML01aRlJWS0RYRVBBb2JhaE9GZEIzZFls?=
 =?utf-8?B?eHhSNlJWdVlGT1hjU1J1b0hJRmNwcE5ubVc5bWExTDFUSmxnVlhkRzcxb1Bi?=
 =?utf-8?B?TENzN0dkclBFeXlRcENwcFRaTXVlVUpYSm9hSHVQQVIxS25jdmlzblBpNXFu?=
 =?utf-8?B?YXJid0JkMHFoM3I1ZWFYOGxMUVZ0OFFpaC9WTVNRZkxUZlAwUjczbU1uaUlq?=
 =?utf-8?B?eTBERUpLNExhdnBIcXJqcER6SmZVME91dFpFaXowd3daYTVwN25GZi9tRy9O?=
 =?utf-8?B?TVNXeThidVNXR0g1YW83cDREVFQ4RzQ0Uk5BY2oyVVRqMlBzS011bllqK2NN?=
 =?utf-8?B?ZCtJWGdFYkxjWEF4TnQrRzBtT0xxcGQ0V0FHbmdmOUo5UTIrYTk3aXpiZGxv?=
 =?utf-8?B?SnFuaVM4MnhTT1FSSEV3VndNRytONnh2d3hSU1FIQmpEdU9GSVBzSExHbWl0?=
 =?utf-8?B?RmdXR1VJZ0RHblpYZWlhMi9KZm9vRkh1djR1dnRjbmZ2R040SUE3c2crNG1Y?=
 =?utf-8?B?SitTUXp6T0NGdzBvYUpVS3pZMVNveGMwQUdPME93M3E1dDM1L25yeEpMWklt?=
 =?utf-8?B?RlpZR1R5Ui9VR1NXZVMrWWZ6WDNVVkdwSERQTXkwTks2cHZnek9YM01YR29j?=
 =?utf-8?B?eGRQWUdhYzFFRWNGdEwvWVB0WVE4dDlQOW1HekdxcGFVMmh3VUFlWFhPOU1Y?=
 =?utf-8?B?RUovRWVHMWUwOTdsMkNSQWc5WW1HZzNXY1FQelRkQk1PbW1RZTJxYzJYSlBp?=
 =?utf-8?B?UnNDMWlQb1Q0Nkk1TXppd3BZblRpYWRqOVlkQk1uS0V1NlRuTmgrRUlVbGE2?=
 =?utf-8?B?bVpaazY0VXBaeW9xSTVGalkzVkdBVk1iVnRoQWl3b3RpdGovWmp2dnU5NzEv?=
 =?utf-8?B?aGh3TGZZMmVlcmoySUNxTmRnOUhaOTdoZ1UyUHMrbThlbG93VFRhMlNOTDYy?=
 =?utf-8?B?UVBGcm9GY0Eza2c3NFpOM0hqWVNqaEU1cndRaDhQMkdsaFdtL3l1dU1wbE9R?=
 =?utf-8?B?dWZJYTNKWmR0VDBRNlYrU0VRSm1FNncwNm15UzNUWTNYcTRmUmJVdjd6YXdF?=
 =?utf-8?B?RVZGMUhmZnphaTdoajBOKzhjRmxPdHRQdUg3QU02d1IzZVlaNGt4TGczbzJH?=
 =?utf-8?B?U2E1ejJxYkFXOVhKRkY3RGY2WGtKR1BpT3kvdi9xRTZtQ2d3N0diQUpnTnYy?=
 =?utf-8?B?SWRFK08vSFdJOGZ6K2hNcFl6VS9GWTI4MUtUallzL0w0MlFPMHVnK1kxUEF1?=
 =?utf-8?B?R2RjSEkwaC9vdEpzcG5aVGFQK2dBdzRyVVU5ekJ5THpZdkhLbGVBQzhSMzQ1?=
 =?utf-8?B?Q3hZQWlHUzlmTzZKekFnRXJmN2ZsbDJaQnhZZDJIWHpqRlFiVXgxRSsrdG00?=
 =?utf-8?B?aDdoSTdHdnEwb09hYnNUMGRuNUFSSER3NGNZemo4T1Bua3ZXdVVPaVlmNkRE?=
 =?utf-8?B?MTY1alcydHMwUXMxejBIVjZ0b0lyRkx0UlNpSi96V1BneENMSW5WSEFQcHJr?=
 =?utf-8?B?UTVSc1RGc3IrQnE0QmIxdGN6OTdUQkN4eE5BMmFGUmludFQyMUlaeXZPcVZP?=
 =?utf-8?B?RTE0R0xaMHljVjVTejV3bGRxdUpVYW1kWUE4c2hETlh0ZW5pN0lNQTB4MlpM?=
 =?utf-8?B?eW1nQjVKNVJzc2Z0a3FyNTVsRFpSajU0Zzd0ZE9CRGp6Q1FrM2hSdCs0MG1V?=
 =?utf-8?B?czcwUE5DTTMrMHY1WlduVUI3T2xOeXo3b0JSMTlBcXJnMDRJMzlnK3BVV2wx?=
 =?utf-8?B?aTZHYU5EMWVBM3JGVzVmRzRERWJ2OWh6S21rUnhuWFp3WEI5a2xxejg2NE9Q?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbfb244-8335-4c0f-7dec-08dac364fc44
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 21:46:12.5026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1F5lkOn5KNu6kqZiwndZ2sWh0ivleMzwcDx0BNsIQHuWlFfCQcDftT46g2yGJegQALbPW1d9Fp/0bTggPbYF1q5AmVvOEGQX2Ovxqqz880=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100153
X-Proofpoint-GUID: G1VlYWj6jkDvH2nkKVjmssNda6EVXeYK
X-Proofpoint-ORIG-GUID: G1VlYWj6jkDvH2nkKVjmssNda6EVXeYK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied. Thanks.

On 10/28/22 7:16AM, Oleg Kanatov wrote:
> When closing the block allocation map, an incorrect pointer
> was NULL'ed. This commit fixes that.
> 
> Signed-off-by: Oleg Kanatov <okanatov@gmail.com>
> ---
>   fs/jfs/jfs_umount.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
> index 3e8b13e6aa01..673e132c1c26 100644
> --- a/fs/jfs/jfs_umount.c
> +++ b/fs/jfs/jfs_umount.c
> @@ -89,7 +89,7 @@ int jfs_umount(struct super_block *sb)
>   	dbUnmount(ipbmap, 0);
>   
>   	diFreeSpecial(ipbmap);
> -	sbi->ipimap = NULL;
> +	sbi->ipbmap = NULL;
>   
>   	/*
>   	 * Make sure all metadata makes it to disk before we mark
