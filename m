Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35996015D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiJQR7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJQR7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:59:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6171A217
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:59:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HGBmth022632;
        Mon, 17 Oct 2022 17:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=/sg4ze5V606HxzYpaaaY6Co08KHCzV+l6Yesp0zIL58=;
 b=Q39zwjG8NlLykUectdckMvVE2aD8B4CXYNQxf0Fcnges9Lj5cBq4goA0MOVaEbMnA9CK
 dAOxO3/5a/3X2BTcH3VXjFPVXvZAmMQ3i6Y5XchyQOSy6/kMcxVbu5j8LPfltjD/mVMl
 aHP+Sef7i07wOxbrmt0zq/Sp5zc9id8BJVFyShi9pDJDcdzI3dXcL36mQtcnT9ydphUr
 llkPHJ57in0ecD9KKpkOLEqlct8HqC9Ug5u/nD4ybnUq0ys1kcWcQ/wK1kG+3qkQcwJj
 LBeWX6o2EeO3Pim4F7tWLKZecOaZ1gPHNq+Lt6fkrMBy55eveP4mCXdpgAEshx/UP/dL Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99nt8j9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 17:59:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HHhbmw029843;
        Mon, 17 Oct 2022 17:59:35 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu580r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 17:59:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjOWN7aXWGW7gk1k5QhjNBu4APDQY18MASvCNnFJCofwfazfVi8AeISIfi4Jado7LMnMGNi+pv8EoNLq7QMdy0cEYinaKR5zTrfgOfKL/9uapxQ5h9gAf1wUATrSZy4ByzUkKILdrGrBiSF6v53BTT1g4lf1tZUg/U9sR06QyBFRpBiAJ8Bl5B1XbtF3gAdEZXiHLIKHhNEdwmE4r6RrN96TgU+zqwArrvqCtmlEO7VnbQFFuUpij8vFUEhZIlVVdvXwdLKsGWPxLY5rNHH58pVYfMLnhWbr62g+OXeJKmtGEHJk8GX3dSs2WC1oPdJ0ErPGFu75A0rmT2GYNR48bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sg4ze5V606HxzYpaaaY6Co08KHCzV+l6Yesp0zIL58=;
 b=L4STFAFe55wSm2X6L3/R2/D4oEZxtZ2epBcBmgdjQFpvQxfhToQFyLWUHGQ5mk6Y0HtvNpP8pZsXsPlJvlANp7RhJWN9EDMtdOLCJcU15wwnbKvzwVo4DxlI0RsQJrstxxCcalzqe3Vaco4Qr/YDvrt4gK/ghKagfEXT7jdN13FUqQOSmoKmHfDnck3foura/ceWCXrut2/Gt4jZf261IuuY4QqB0qwzk8ffbtrxAWJCPbvKDdovM0wdhmajb+qCeqz03FlJOOFpTpSVlHDbnkGCEJDSfoLo6vmErDJALQIM4sSVD7uQmd/UKm5GpN2y1hirhYfBsQeSxbJWyA72eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sg4ze5V606HxzYpaaaY6Co08KHCzV+l6Yesp0zIL58=;
 b=Ut+RFS/4Xey/KHySl65Q3rgI5HtofK56IYFI5769K4zstnUyAdfwxZnGsneElQ5dgtslqvoRJcNfIAnzw7PkJPmf7kjQdtIgHdQZ+TwAtpX0vrq+F6nnFOPg9CxZCcuwpCCPxZsdOiptTH0WAcO20GEKLBm3y/IRNFIcGYQGY/k=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4631.namprd10.prod.outlook.com (2603:10b6:510:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 17:59:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7%4]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 17:59:33 +0000
Date:   Mon, 17 Oct 2022 10:59:31 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>,
        songmuchun@bytedance.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] mm: hugetlb: support get/set_policy for
 hugetlb_vm_ops
Message-ID: <Y02YAyE1TnU6/dkA@monkey>
References: <20221012081526.73067-1-huangjie.albert@bytedance.com>
 <2aaf2c3a-6e49-abb9-b9c8-19ce87404982@redhat.com>
 <CABKxMyOnxiS6RsJtQEQPrnzNn-cO0Z+OGJRCUpw1M4=WANx0Dw@mail.gmail.com>
 <2f41fc4c-68eb-ab7d-970b-fcb10f474fd4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f41fc4c-68eb-ab7d-970b-fcb10f474fd4@redhat.com>
X-ClientProxiedBy: MW4PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:303:dd::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4631:EE_
X-MS-Office365-Filtering-Correlation-Id: d088902d-441c-425e-057c-08dab06958cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2E0cdiiPhba+2eLlvhouRHeqZeEzZ/UPl/g+xzyJaH+/pVPV/WI21bHwnBPRIty40JQRNi2KSJfQploNTPbA6ydyJWjgTSaekENRUc38GOb07bKaKXDLDKc971XVaLG2A9T2RRcCMY2Acjz6jdazwdNsSI4TQInqpH/j1izmnj9VZCEDeGTAnTBWptPQUmlzpyFgw9Ev0KIYKqZNcqVZZ5xoecFiKi3RUaVnslUioWNS/tc20tLUDRirLMxf3DhM7PzuuW1V7cThFaQKh6eQMt+VR5CKU1CEGNjUoq/bVuKz3HnNrJ/a/G/mOPREnUKLffnFqTPs4Bc2g1+eC43cQF60ytZt0ydI5R91Z0Tlv5PJGgNdkkDETUbDx7vW7qb65qw4bVxRcb6Sln2S9rlcSCwqf7Jijlgm3CrkM1nb82YNwHgpEf4K1Nq4WZfctRVm8UlDwFFBROq+4mOzQLreDdlYl1W8Dfsd28gef+fRAGRrPfyGu7wNKgCm4AJSxLvmDNGw5Efwit4Pg/w0aWA3D8vIBUus2rZETsjXdGK/nX+s/NIyZM0AOpPNNea42Nukqhp/eVFg77Yl+DAC/+Lpj2/6cECkWE6Gh0gxATTwO9PTc3onpfExtncsbud32SKlIZ3IiTbhd+yw5B+xsDM4Hu2EXI+JLq/2cEQZy4EOhk/o22s1DtkEFswjw59mItKoYxx/CL+c87DKVLfxhjyi4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(33716001)(86362001)(38100700002)(83380400001)(66946007)(66556008)(316002)(6916009)(8676002)(44832011)(54906003)(5660300002)(6486002)(186003)(2906002)(66476007)(8936002)(6506007)(4326008)(478600001)(9686003)(6512007)(26005)(41300700001)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhWUUUwSSt3U0Yxb2lBTEVIQnBRcmg1OXlDSGtXemlLajZsWXJOWGpBMUFX?=
 =?utf-8?B?WnIyMjdsMCtEb2Z1RFRIZ3F0dU5Na2Vib0RwL1dJcHRNRkxnckxYNUxoTlp6?=
 =?utf-8?B?VGJUQnB4UlNlcTM0OHhDaUUvU1JaeXQxTWlSR0FHUVNteG1TK0YvRjJjNHBx?=
 =?utf-8?B?SmtHaWxQNUF5akhLcW1oOS9pY21BVE5GMGFvS2UxSDRYSWMyTm1yZ2xSd3NS?=
 =?utf-8?B?dkhHeC9LaU5weEVXT0twY0ZQeWhYbDZzcmhmc0hrT1p2c3U4LzVscGY2VW5L?=
 =?utf-8?B?cDVlSXQwZGJLK2I4dSt4UEhoZWgxTmpwWlZMYytkNFoxRlVxVVp1MjQrUjBa?=
 =?utf-8?B?bmFjUEdIVlA2cVQxd1ZueHYyb2k5N3BWV2Y1UVJGMDIxNFVYVjhBZlg0SE82?=
 =?utf-8?B?dGlvZnRvNEZSSjZCTVVRQjFrdS85TEdDaEdySysyazN4MmFTa3gwZ3hZUmJn?=
 =?utf-8?B?ZGZyekwycDRDR2RXaU9SWkdhZnd1eVMvenA3SHVRVmR0UjlyQk01N1F6MVov?=
 =?utf-8?B?ZnZVeHlVZ2k2bTFpVklDaEdybFR4NFJUV1FWc2JmK2NiVU44aUx2Vmw5RG5K?=
 =?utf-8?B?K1BBNzdsdDF3MjRnYVVQLzFYRWR6OHUya2JhaTc3NFYreVY4SDNXVkR6UWZj?=
 =?utf-8?B?MEdjS2NCT0lVVE0vaGFZS1pqOFlkNzh2MzlTQmlTb2VtWktFdlU1cUNWNXJ1?=
 =?utf-8?B?NnNPb1ZrVXFORlIyeXNjdFI1SSt6ZFRXQmlOdERQTFZCOHZuVWdUM1JHbDdZ?=
 =?utf-8?B?UUc1K1JFZ2F5cjFVbEJzSGdFTkFjYmR3ek5saU1SeGpPOVFrVEZkZ3hCRXdE?=
 =?utf-8?B?Y2djTTBZNHVGSld1S0g0L2laK3NZQzAyaHRYL0dNRm1yblI3WnVLUE5jU1gr?=
 =?utf-8?B?ZGlPQ2lrWTVSczNXVHlRY1NGcXVOWEtDdXhML1R1bmpyVCtUYVhMZHErQ3dE?=
 =?utf-8?B?ZGJwd1B0SDFuMmlmaUhrTTlhd0h5cVZ5ZjI4V3Q4b3QyNDRVVHExM2hjTE5S?=
 =?utf-8?B?akFCM0JzaFhaR3NnK3owQTBOeEZiYWFTNDVxK1ZYaWdadDVrL3VoR0tueml2?=
 =?utf-8?B?cTFFM2l0akllUTZNNTg3YXFQZ0FUWUx3UGVIYUFZNnl5UDV1WkpOS1lpV0lz?=
 =?utf-8?B?dkFCWmNQcWsxSHpDWGVZN0FOalNlY1o3d1NGZ3lqemkvb3ZKZDRwM1ZYN05O?=
 =?utf-8?B?c3ZZTm85dXNtQ2RpZmpscFlmc2ZSUDdPOTlFT0hYWHMzd1hmd01jS0Q0NW5v?=
 =?utf-8?B?TEdCQThvVk1JdExaLzlYem9PeGQ2WXVlQk9RTDg1dWpCcndXL291RGw2MU9x?=
 =?utf-8?B?TkVxT204UHJtMCtaL0U5blRsU3hKdFFIYmc4SnU2SG1qUm5Gamk4SkVCMVM5?=
 =?utf-8?B?bjIrdk1ETFMwM3ZCUVZxOWRTeHlWbVRGWTB5bGo1QjB4aEUyOU43RXNFbjZu?=
 =?utf-8?B?WFhtR3V2cGgxbWc5Q3djSVVXMTVISGh0aEhFeXJramxTVE5wZlhRbmVXSGRE?=
 =?utf-8?B?V2lxeG9USUxMa2ZVZzNlRTh1NmdYT1Boc0ZqWTRMVTU0TEdIOFc0YUJpYVB1?=
 =?utf-8?B?d3FORnV3NHorRUtPNEwxbk1uQ1FkOUptUHJ0MlhMM0xjUWNnczQ2aFlhejh3?=
 =?utf-8?B?dFBaZEVMK0hZRW95SWk3bjNXRS9qQjE5N05BWVpGZjk4RGE1d2pvdU5zYVRy?=
 =?utf-8?B?RzV4T3dKM3N6MVgwMTZVV3RoTXhDMmtUK1NXZnU3Q3pPMVJDc0x2VjdzWXE1?=
 =?utf-8?B?RzRQUnhGVkNUSzFRWWJxeGlMWEhKa2c5bWtwSml6aXlseFVkajBkcjZRcUhD?=
 =?utf-8?B?VTNIcVNmSXFTbEhTRTFJWEVPb3owd0NnV1dVaUxDSVhOWXdhbnVQSVRucUVH?=
 =?utf-8?B?Y1IyVyswQ0hMOTFYZnd1eGJXbTBWbmxWSG1FNWRwRzZIOUZlelNCTmp0TFNt?=
 =?utf-8?B?SElFNlhicER5enFUWFRQcFZYNEFueG9PZVVueTZvQWxMOXEvNHlBa2oxUG9v?=
 =?utf-8?B?eGRYbHlWOE5abjZkL1NITFV0clRUQnZwYkpwYUhqTjVYeE1xd3g1SmJRSXdh?=
 =?utf-8?B?M1I3VHNqTlhHMkpRVUlZNDVQL1d0OXFuYURhZGZHMEV2OWgyb0VTd21HVEpa?=
 =?utf-8?B?enk0MU04MC9JOWE1NmdpMFoyanNoS0gveU1xU1lycEQ5MThZend5N0o4ZW04?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d088902d-441c-425e-057c-08dab06958cd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 17:59:33.6263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nODqcgmL5esHlyH+M36jK3tDSA6KesCwwFFiROwx0P7j657pa8NpVVSrFrAjGov6TZGBWxvNIYtrgzgiFezEmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=733
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170103
X-Proofpoint-ORIG-GUID: z3N4cz5UrAjzHLUhkIfqwlpGRxFnbZUB
X-Proofpoint-GUID: z3N4cz5UrAjzHLUhkIfqwlpGRxFnbZUB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 13:33, David Hildenbrand wrote:
> On 17.10.22 11:48, 黄杰 wrote:
> > David Hildenbrand <david@redhat.com> 于2022年10月17日周一 16:44写道：
> > > 
> > > On 12.10.22 10:15, Albert Huang wrote:
> > > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > > > 
> > > > implement these two functions so that we can set the mempolicy to
> > > > the inode of the hugetlb file. This ensures that the mempolicy of
> > > > all processes sharing this huge page file is consistent.
> > > > 
> > > > In some scenarios where huge pages are shared:
> > > > if we need to limit the memory usage of vm within node0, so I set qemu's
> > > > mempilciy bind to node0, but if there is a process (such as virtiofsd)
> > > > shared memory with the vm, in this case. If the page fault is triggered
> > > > by virtiofsd, the allocated memory may go to node1 which  depends on
> > > > virtiofsd.
> > > > 
> > > 
> > > Any VM that uses hugetlb should be preallocating memory. For example,
> > > this is the expected default under QEMU when using huge pages.
> > > 
> > > Once preallocation does the right thing regarding NUMA policy, there is
> > > no need to worry about it in other sub-processes.
> > > 
> > 
> > Hi, David
> > thanks for your reminder
> > 
> > Yes, you are absolutely right, However, the pre-allocation mechanism
> > does solve this problem.
> > However, some scenarios do not like to use the pre-allocation mechanism, such as
> > scenarios that are sensitive to virtual machine startup time, or
> > scenarios that require
> > high memory utilization. The on-demand allocation mechanism may be better,
> > so the key point is to find a way support for shared policy。
> 
> Using hugetlb -- with a fixed pool size -- without preallocation is like
> playing with fire. Hugetlb reservation makes one believe that on-demand
> allocation is going to work, but there are various scenarios where that can
> go seriously wrong, and you can run out of huge pages.

I absolutely agree with this cautionary note.

hugetlb reservations guarantee that a sufficient number of huge pages exist.
However, there is no guarantee that those pages are on any specific node
associated with a numa policy.  Therefore, an 'on demand' allocation could
fail resulting in SIGBUS being set to the faulting process.
-- 
Mike Kravetz
