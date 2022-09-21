Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AF15C054F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIURcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiIURcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:32:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C8AA1D4C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:32:17 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LHO0iw002750;
        Wed, 21 Sep 2022 17:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mb0FbLnhXwZWhL3cFsrr5LH2P/D6aWZ+YDn/WviLEyk=;
 b=zjLBz+kEKXU0agQ9uKFU7vcAvuEb3vZmRUEEayqz6S5Z57HKUo2qHGLTf+hQKkynksSH
 BA0Gf1xzfKfwMbPKcfA5ZfFtTVCVbXC7Otm8z6sJDGY2nciSDCY9yi15DSjBD7nHRGxm
 QLkQ/RhpfHqgGBnLhNxRdlzrWbL7CZdEXmd5rtpKWVuHxfWKasoezA7MEg4g0ZpHDUgg
 AIHUyVi2Zo2soak/J+Cuxb+m5BDWBZRQ8ax+P/TNjzOIb1dPDREKKVvzUGlEDn6auVir
 JB2nw00nwhQrBjbbeE4cmpmpaXxhwKxfNELzZGrmDyo5mfNcEftHZaVKIHxAIXx9Q6aN hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68mb6bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 17:32:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28LHN5J3027850;
        Wed, 21 Sep 2022 17:32:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cpq2eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 17:32:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbexcUy2S04sjOi/zBKVjocAJdxEtyh+92/WtGzd/E56xbQlmuoMGOnxs4QPXjFr3qOInrc6UQpPoDAGm98Yr1MPQQoRmryUyh4im0xzTday7/fGgVS0thEKp9AhgY1aX6y0O85cc+kbczFKfQWvNcOnJEqDoCfYWY62pszTveEOVrmnn9zQcOt0wekYC2Sz9QAwrpPY00tRW2/HdojsOSvOnd8aEb4f9foulO6mmQZV5vKBLF0S/aDIuVGOD3gyB1/c3cPY2q+g0ABcL/R+8QJbaGCA+nexWNjP6YjvQB5ktRqT6Rr56jWVARV1Oiv+5ihtYF6IMaijh13TDLvuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb0FbLnhXwZWhL3cFsrr5LH2P/D6aWZ+YDn/WviLEyk=;
 b=BoyXrreCkm+1G5PDUhbAJqp6IwYA9vu1CjVLESKKD7dBFfINVYakezLQkMn/U2mYFfZHFiqoefLCPj2LYPFIVhdMu4IfvQeoZeQMIXT4awDuF9f+SP0WocU1ZSKoQXeX5/inRxMghAcXVE+MZg0KulAKzNdfRlZZTfVnQY4LaEG8UeSvlDQ1EgttUSteZEzjIl6VKdgHzwpQAZBv/cTTvm//9qIXqtSshIVYpK5elT1VH8bJVGrjsgaRuGy6Y5oIDA/cPSUKRCvCwOLqmHa7fgGgrSwXmXnIK8lTRtFWRSoEGa4EbTYy4R9OmSp6eR6OmwcuuWOn3qAg8vw4UB5H3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mb0FbLnhXwZWhL3cFsrr5LH2P/D6aWZ+YDn/WviLEyk=;
 b=Q0aIsWMnqAh6Bysg8bZHa3j3TJGpU7HMm00wle83MSkaPvmH+02PCFYvkFA3qn/X1xbkEyS4BETP2T6ofuMLZwUO5Ar2n42AxM7OheTyjg1eh77cgtMgwpMllOyJJmdOO0/K6v7sIVBaNBUGgnsa78Qb926PqFrwQmtGFEExOZE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BLAPR10MB4979.namprd10.prod.outlook.com (2603:10b6:208:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 17:32:04 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%6]) with mapi id 15.20.5654.017; Wed, 21 Sep 2022
 17:32:03 +0000
Message-ID: <dd2900e4-fbfc-67c0-73cd-9ddcb1963737@oracle.com>
Date:   Wed, 21 Sep 2022 12:31:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] mm: hugetlb: fix UAF in hugetlb_handle_userfault
Content-Language: en-US
To:     Liu Shixin <liushixin2@huawei.com>,
        Liu Zixian <liuzixian4@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20220921083440.1267903-1-liushixin2@huawei.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20220921083440.1267903-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::13) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BLAPR10MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: 092967b7-c8ef-4f45-0e3e-08da9bf73299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1EXSJPCOAiC2jkAtYrblmeUTH+MxNs7l1INrTIpeiw2RiNkffWj0hEgwpSanBBWEj0BDr8aTOCSwxQ9ShovxnlLeCm8P1Pca8MfA6eOI5645cUqOc86Dp5PVstVx6GYpSGW0l9nJr/+xLICoyJU1y85DZ5kpau8gLeq6PVFjVK03htRXaF3XBvrSlkdhke4hxaSn0D607LriMls+c8pDycgGnFDxhvYbnkx/pg2i3kBWizYSVG+U5mCEUNIhELNNpDQN+43Xqy4nb89my0h3FWFhpcWC6pqrfWBP3o9LMG+rp8Qtt1KZDJTE0G/CVdiHwfwbKA+S0FvJPKOZiHPDwZbOV4Wv73LYxiGiI8CwymXLhNPEqm8hF9NNaIYJtytGpkrYGKThO9z0MhxIOGTwjRKjUxdK5B7cmNWSl0Fdx2gRFRSR1E9zvcJFt8OBoGInb4s5/lfmBvPtB63HIYqvhKMilj54D87kjYUI/U6N9V+PzbA6Kk9Z/ps8g7gZ3RrVoGTKKKKpIzEk1g7pDqnBOTy/e4yxBb+Auk0pEx32zqPiMFFLKTay9ycb9lCAoOFzpZdY2M4K48LT7/v9eVnet6Mw9fuVAY4I2hAfRbuIHILrk9laX/km4NKUn5zGyIHnknFl9QKTNAYJVAPxKtA+9ls2fUonIP1fcln/famxQLBLElbJJOIWCwGkkj3yiAzHmAUXDaygKT8URDxAjh1KsGwS0EmI3Eid5t9rONONt2YnrpadMzt/9W2HDfyMU1cHvAW28ayeD2QI8HeOCPUFuV1Kz1kokOVP3Wu2u+F6OE8z6SVa3SVDkLY2lwW+kTS0EJilXljtzKTGtbI3TW9NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(6666004)(38100700002)(53546011)(66476007)(6506007)(6512007)(8676002)(66556008)(4326008)(8936002)(110136005)(86362001)(31696002)(966005)(6486002)(186003)(478600001)(36756003)(2616005)(2906002)(41300700001)(44832011)(316002)(31686004)(66946007)(5660300002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2JIR1RxQ2tjeWsvbS9uZnlsL09weFlsd3NPREN0VEZSOWppMGdsRlZQV2M1?=
 =?utf-8?B?LzdFWkpNZDAzYVZPTE1rdEtVYnAwZTJLdWo3SHN2a0hMdm9MWlV4eGkrOVpW?=
 =?utf-8?B?M2xaNjM3QUVFbW9KTklDOXRkZXBXSFJ5aWRXUG00dnA4WFJhMlFFUHJWVmNs?=
 =?utf-8?B?dHBTbVBRVWsrMGVad3paODVTTEZSemppWjdQZ3BXOFAwakZvdHR5c0p4M1By?=
 =?utf-8?B?ZFh4QmxKVjVRV3Rzd21RaHcxbTN6R2dUMWh2SGxTZDNGdGFmc2RHRmpjb2hm?=
 =?utf-8?B?QUJRZlpmVlBzVTlZb2NSN3hzMGNXWTd3bmdualU3T2RwN3ppSkp5NStxR3FJ?=
 =?utf-8?B?bFFwTk5zYnRzQmVjSWxFTEQ4Q29iWVM0Ukx0eEJMNXdTdjNweWIzOFV0Wk4x?=
 =?utf-8?B?ZnYzaStDZG02Mk5LNW9uSVZnbXZKL0toTWNtdzgyNGtnbEhMclZHTjlQblls?=
 =?utf-8?B?d3dEdjJuOUt6RVphVm9QZnlqWlJ3UTF5anhUdU9HZzV5ZUpRbys3UXhLVGZs?=
 =?utf-8?B?ZjZNSmVUbmc3OUk2YU1ib1I3T1R0L1R3L1FEeVdLeWY4V0U1QTdkNEp0dnNF?=
 =?utf-8?B?SGlJVWliM1ZZOHV2UE1jaGJyY2c5ZVpvK3lJTnFiT3JCVWEyTFBRZEI5a0Jo?=
 =?utf-8?B?ekpOaEpvTU0xaHlVWlNWR0RtRS83TFMyVzhyaTloN3JPV3ZRYU0xYUlWUGtB?=
 =?utf-8?B?ZUwycHBSaFFsc2dNK0Q2QWtSSGsxaWJiVHZKbEFQNG1wYS82dTJwaDh2dXBr?=
 =?utf-8?B?Y2VrMGV3WjJXK0pFVUNSaERsQ1Y4R1BEa01JeHhDK0k3cTRoUHVkZW5Vb1NN?=
 =?utf-8?B?cWVqUnpCVVkySUdINVRuVGhWcnZyWTRDUndEZFVadUVPU0JtZVlUUjVtZUlm?=
 =?utf-8?B?SHF2SVRoZFNYd1JFNE0wRlNQM0V0aFVSbHVXNTJxdXFPWnl6ZVFDSS82eHRH?=
 =?utf-8?B?ak1zWnlCWHpKMmlzUGdTY0dwTkNCcDZHV1JGV2IrMTRZaU8yZUNJTG5LQWhu?=
 =?utf-8?B?MDMxellDcm82d3FoNFNGamRud3ZxR1p3SzBmZVZzdUlOUjZCWldudFBueGNY?=
 =?utf-8?B?enA5ODJZd2tDZU9uSitEejZETVZ4ZmZ2RStvKzlCUVphQXdyMmNYblNZNzRN?=
 =?utf-8?B?ZngrMStIeDYxZHAwZ2g5USthQ1Q2Z1d1dFJJVTNKanpLSitsbjhiTjQxYmc1?=
 =?utf-8?B?TnBTemNFQThQUGxLL0tpZS9sZkwvNlhORVFBc3BCTVFwZ3JXSlJRR1pNeEVp?=
 =?utf-8?B?UFE3bFRMb0lhZFF6WHVpWmpnQnJURjdPRXI5aGJ0SERTT1RGOTh6UXl6aC9P?=
 =?utf-8?B?MjUrcmYvWDhHR3dZZndSUnE0UVJOQnVvS1hmT1d5ZWh6OW16bTZNYkNLWDBo?=
 =?utf-8?B?enRIM25yb3F2dm1mdVhOc3ZCbG5Ud1pROFA3UDVwcFNpaTNmN21BamdlUjBj?=
 =?utf-8?B?Rnl1clIrYy95RFh0cGlHQXJNR2FldUFTaDBuUFBtSlJPT1l1TXFUWlFEdHJI?=
 =?utf-8?B?dkdtRm00cEw4dUZ4UWxWS3E0NGxYN0ZMbzlZQXZ2UTZiZW5tMU1Od0IzeEFR?=
 =?utf-8?B?eTlPT0dsd0VTNzVVYUc5c21xK0M2QjZaOVBuSXUrWXkrclY0WGFHNzM5Mk9n?=
 =?utf-8?B?a3FFZnpNY0QxZnFQdGNPdVI2UWZib1pza29MWWphNWpXQ3JhcVp1b2RTdy91?=
 =?utf-8?B?M3FjRFpkaU12MHNiODlBenVveXQrU1F6cnBvYjVQdHhRMG56aENhZDU1N2hU?=
 =?utf-8?B?SjZpRklwRE9DU3ltbUE4cTlzWjg3ZDNtMlpVdW12R3VRaXhySzBoaGxFYVUw?=
 =?utf-8?B?UUlnV3haZlE4TTl1NjRrZGNpSVphd2VCV0RBN1hORTZxWnRBZmE0OWg4MFFF?=
 =?utf-8?B?UGpyV2MyL1VaaFljNnkyenZLV3V4Y2thcU05dU1SZG1zV1lYUUpaanMvSmFW?=
 =?utf-8?B?WTYvUFNGRHkvbVh6aGczS3BTdU1sREFEQ1VlUDJYbERHL0F1TlNLOExOR3NX?=
 =?utf-8?B?SXE1czRzZ21mM051ZExNbDlwaURYdGtUR0Fnc3lEaVRWb01LSStsWm94SUQ3?=
 =?utf-8?B?K1NRQW9ZVzhVdVVUMGlCaXFrN1lhclB5YWYzQ3ZMRjBLTWdwZnhrS2lwTEJS?=
 =?utf-8?B?RzNlTDY4bkNITVBMSDlDd3U5OXU1NWxBRGQweFB0a2Z1NGV3b0lKa0VCNlVC?=
 =?utf-8?Q?pQb2GYB5I2vVp/wO/Iq7WLQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092967b7-c8ef-4f45-0e3e-08da9bf73299
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 17:32:03.8527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZMsEZeND+Y7dvYjUy37FL5O4MtGV+6b2XS4K+XSpR7L2SY6p4VMk3qXXVXgiKJ2LwAlxA7A2S8lVd/kYBLywBHLSS0qVVVORZrF8FTzwlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_09,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209210118
X-Proofpoint-ORIG-GUID: GJrh11ICpAUMALiqhzp83TOQVMhS91sq
X-Proofpoint-GUID: GJrh11ICpAUMALiqhzp83TOQVMhS91sq
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/22 3:34 AM, Liu Shixin wrote:
> The vma_lock and hugetlb_fault_mutex are dropped before handling
> userfault and reacquire them again after handle_userfault(), but
> reacquire the vma_lock could lead to UAF[1] due to the following
> race,
>
> hugetlb_fault
>    hugetlb_no_page
>      /*unlock vma_lock */
>      hugetlb_handle_userfault
>        handle_userfault
>          /* unlock mm->mmap_lock*/
>                                             vm_mmap_pgoff
>                                               do_mmap
>                                                 mmap_region
>                                                   munmap_vma_range
>                                                     /* clean old vma */
>          /* lock vma_lock again  <--- UAF */
>      /* unlock vma_lock */
>
> Since the vma_lock will unlock immediately after hugetlb_handle_userfault(),
> let's drop the unneeded lock and unlock in hugetlb_handle_userfault() to fix
> the issue.
>
> [1] https://lore.kernel.org/linux-mm/20220921014457.1668-1-liuzixian4@huawei.com/
> Reported-by: Liu Zixian <liuzixian4@huawei.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   mm/hugetlb.c | 30 +++++++++++-------------------
>   1 file changed, 11 insertions(+), 19 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9b8526d27c29..5a5d466692cf 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5489,7 +5489,6 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
>   						  unsigned long addr,
>   						  unsigned long reason)
>   {
> -	vm_fault_t ret;
>   	u32 hash;
>   	struct vm_fault vmf = {
>   		.vma = vma,
> @@ -5508,17 +5507,12 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
>   
>   	/*
>   	 * vma_lock and hugetlb_fault_mutex must be
> -	 * dropped before handling userfault.  Reacquire
> -	 * after handling fault to make calling code simpler.
> +	 * dropped before handling userfault.
>   	 */
>   	hugetlb_vma_unlock_read(vma);
>   	hash = hugetlb_fault_mutex_hash(mapping, idx);
>   	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> -	ret = handle_userfault(&vmf, reason);
> -	mutex_lock(&hugetlb_fault_mutex_table[hash]);
> -	hugetlb_vma_lock_read(vma);
> -
> -	return ret;
> +	return handle_userfault(&vmf, reason);
>   }
>   
>   static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> @@ -5537,6 +5531,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   	unsigned long haddr = address & huge_page_mask(h);
>   	bool new_page, new_pagecache_page = false;
>   	bool reserve_alloc = false;
> +	u32 hash = hugetlb_fault_mutex_hash(mapping, idx);
>   
>   	/*
>   	 * Currently, we are forced to kill the process in the event the
> @@ -5547,7 +5542,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   	if (is_vma_resv_set(vma, HPAGE_RESV_UNMAPPED)) {
>   		pr_warn_ratelimited("PID %d killed due to inadequate hugepage pool\n",
>   			   current->pid);
> -		return ret;
> +		goto out;
>   	}
>   
>   	/*
> @@ -5561,12 +5556,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   		if (idx >= size)
>   			goto out;
>   		/* Check for page in userfault range */
> -		if (userfaultfd_missing(vma)) {
> -			ret = hugetlb_handle_userfault(vma, mapping, idx,
> +		if (userfaultfd_missing(vma))
> +			return hugetlb_handle_userfault(vma, mapping, idx,
>   						       flags, haddr, address,
>   						       VM_UFFD_MISSING);
> -			goto out;
> -		}
>   
>   		page = alloc_huge_page(vma, haddr, 0);
>   		if (IS_ERR(page)) {
> @@ -5634,10 +5627,9 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   		if (userfaultfd_minor(vma)) {
>   			unlock_page(page);
>   			put_page(page);
> -			ret = hugetlb_handle_userfault(vma, mapping, idx,
> +			return hugetlb_handle_userfault(vma, mapping, idx,
>   						       flags, haddr, address,
>   						       VM_UFFD_MINOR);
> -			goto out;
>   		}
>   	}
>   
> @@ -5695,6 +5687,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   
>   	unlock_page(page);
>   out:
> +	hugetlb_vma_unlock_read(vma);
> +	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>   	return ret;
>   
>   backout:
> @@ -5792,11 +5786,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   
>   	entry = huge_ptep_get(ptep);
>   	/* PTE markers should be handled the same way as none pte */
> -	if (huge_pte_none_mostly(entry)) {
> -		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
> +	if (huge_pte_none_mostly(entry))
> +		return hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
>   				      entry, flags);
> -		goto out_mutex;
> -	}
>   
>   	ret = 0;
>   

I've been looking at this as well.
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

