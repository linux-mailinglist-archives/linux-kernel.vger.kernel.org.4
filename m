Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA2607E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJUS6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiJUS5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:57:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD7429069B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 11:57:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LIs5HG031008;
        Fri, 21 Oct 2022 18:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=O4/kjM6B9+5UoimDVVfGlVrdMUX76EMFgj4UY154nyY=;
 b=fBhuAd+TTamzTnf5mSbhsokPIG+lodq2SFi0ypZWYQcwvE6LMdlUcxMZUmJCiAGw86wD
 5IAQ1g/gfY/mBoeqPVOjGnoAy0e5FEHU7/560rJ1wThJUlf3EDQIKbpBFGCpesokAGjk
 WVWRHTnhue//YTrpn2TI7Hu8k+EmHB9ufKUSyDWsfuF1zrkXRCp2RxCvTgh29q3zhNnX
 UUUij7FN4XQhHgrPAnAZx+lQV9epiVT/4YPOHTo/n3w6HSRvLxHf6+ck8z7oYQvsvBjV
 mpyePC1jV51DcDuKhcoW2tAMtF5naM9m/K3haV/HOXk37F9/ZTfA94ymvswQWRHIJSE9 Qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7svhcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 18:57:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29LIXNMO007263;
        Fri, 21 Oct 2022 18:57:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hre3kte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 18:57:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRyPStRZiXoVtR7U4LKgTr5AgOGozM5yuv6rFVpj4MwJiDeqgCD4KK3UPkPV2+QRZPglCEGnLOJ8WPQawztbVs2RJHMgjvyO2XmMttOgGv6atD3JKXcRvk+h7uQM47m80kAgaHqK4U6VoVkqzrGqpuPsD4dsGP6SwZLvisL4UoHn3K7jD5nqIa6+5bkO6lOHBH85/U81tSqe36bOoE5r4O2SZSq8tNy56+1QB53fyS1lavzDVjFS38qw/rg2Nf43vSYmj299w9CnW+4FnA0N4l23x594a6+8eftM2JZvU7h0HoVPQSPCfF6T0FT6pfOWZ+rBkPVcP6hOGhFsMFNwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4/kjM6B9+5UoimDVVfGlVrdMUX76EMFgj4UY154nyY=;
 b=oU/eWDpMJrJUpfxwkcDunKHc9c0TEBbdozj1FInuMS0trBnwjXLxaHlrGwa7c7dSrMXCW7L2AcGT7dARiWrfoixUsKPiX2NTBBMiGSutBade6a2hq/YJ2wRcT6E3wP8HwfVbT6g13TStBB+nyCaRU/n6Mk2W50sqzlDxukYGjPVdB/Gya/aI+22oPquB2+EbDjmeiCEUGB+sYmPd7BK3qyfb299IUltphshb/ZYefiEatdUtGn1coebCuG9WSKdPoJVh45bKcSpVFpYksAdghyjo5TzGa2BAqMYamPwwUrPIEvs71zUcY6b1WI/t8imRLw7JKmndBJuxeKiU4RIpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4/kjM6B9+5UoimDVVfGlVrdMUX76EMFgj4UY154nyY=;
 b=Dhds2iv82QQU9ug+iMb9QDZXUrdWBhcJvk5Nr9UXJo7pl9o59E6MfPS5mKsyz8C33CnTPUYvuA6XoSC+TN8Fp79sOgg8a6ctVgMJEkpKhXFVL4wnruIO5NB9eqZhhXGgg0YnlCNFOGY3Fi6fWlp9pZz7axlxePfbnmaUVcTcQoE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4434.namprd10.prod.outlook.com (2603:10b6:303:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 18:57:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5f85:c22e:b7fa:21bd]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5f85:c22e:b7fa:21bd%5]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 18:57:04 +0000
Date:   Fri, 21 Oct 2022 11:57:00 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Houghton <jthoughton@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mina Almasry <almasrymina@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        regressions@lists.linux.dev
Subject: Re: [hugetlbfs] 3a47c54f09:
 kernel-selftests.vm.run_vmtests.sh../userfaultfd_hugetlb_256_32.fail
Message-ID: <Y1LrfJ6ZECI0kniN@monkey>
References: <202210211425.92ab6e9-yujie.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210211425.92ab6e9-yujie.liu@intel.com>
X-ClientProxiedBy: MW4PR03CA0326.namprd03.prod.outlook.com
 (2603:10b6:303:dd::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: de8a1d7d-0723-4d25-ad79-08dab3960b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QtS8L2LqQNEqPehMSU3LzDyUm4JTz/Pw9Qjfw7aR6sL/xpc9zexEAq2k5Sbgf2gq0hZ/BaTGcEEMMxEJ9jMPjnU6T+kp9NmqtxoqnwqVKUYKRlAtKpqFgiN1AGDShQUi0f2lXZLpOV72229/pHdgFZG6LHJc9TIpm6xxX2y6WFealQkZr4j4cIyrDl2vHxZXSyJodQ0u/8tMkt2UvyTTMga5hY/zsiUJ6fMQhsdpqxy8eoc5LXmlMPHAP8oLqb1Q01AsrioHoonWaM3ZXyqgOS/bCsYB9Vepw3SuSLU4pZmVY/C1/iFaJt0uAwXBYHUIjkHNdwgskkHkfng1Z0KKlMsrqR/+YmwBrWjVtcZ8cIhi/q3qIaCw+EFlauBv+AuGNjhVxxbR7S7p/DGv82zcQeGrB+LIQj7Ufrd9O6/arCFif37/N5/CHF2ZCPHDxCGWerGdCmG+Dzu3G1HvPF35QZ9hW7TRW1AWiFnm8LjJKeSL92NiqAF7uu/zo+dm0eOtjZIDXh6Q1PwgP+pxE6B9FLq9NrtFbJfLGieGiP+kNydQUPfaYxkxshoQ9hEKc52iREE5OwIJhGt2pFUKm+4x22X4Y3pYebZHS7aloFsHMJK/75CvM+6LvuyWghfOostwtwR2kOXhVeeTyT08iIcS79FSlwEQk9/Ksc5CWaTbKIC7WkbO/lJc//06MXRiGn9qZ1A7t35MFxaMkaIn+iPSZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199015)(6486002)(38100700002)(5660300002)(6666004)(54906003)(6916009)(2906002)(4001150100001)(478600001)(8936002)(33716001)(83380400001)(7416002)(41300700001)(26005)(86362001)(9686003)(316002)(6512007)(53546011)(186003)(6506007)(66946007)(4326008)(66476007)(66556008)(44832011)(8676002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/iOHyiPPq6ugWcba1kQpV3sUANeIphPnZMyB/MZDkWgSfmtGptmKkbpkGS5u?=
 =?us-ascii?Q?jW41eaKw3e+190o8dI6GyDhCx58Q06Z4RyobaBucdhYwzhCm5LTYVNOSxbPK?=
 =?us-ascii?Q?TLQib02dw0rp3xly/r6Hgrk6g249escYMewB6D6reOBJzD3m8lDwV1LFRc1Q?=
 =?us-ascii?Q?3xXgLyBLnjru8/NJr40Xs7z9+6LxRme6dRvgN5naNcEGoOkDbkRNxoaje1wa?=
 =?us-ascii?Q?WvUFkJFNsf72n9s3dDW6zztqM9fACJ5F5+aIQcUUdT1GkHQzWzUO9sAN7UhH?=
 =?us-ascii?Q?1wzL6h90UE0WfJnfvP0HDZOu2aa+S6rIvxNxGkQp3Mvnis/HPPdR4pRITdHO?=
 =?us-ascii?Q?RiXvfZIBB1A3V5zxxIHt/BFgbPZ+bGZpNeOZWYA7i6A0+tYi+2LN/QLO7Sj3?=
 =?us-ascii?Q?ebpZyRXbdpFYVgTlaw47W6XpOFWBeJX45qG6keiL/4+cloLwO532cU0AP4pG?=
 =?us-ascii?Q?gl6PpJnpH6B7TK7g7KsX0wUkOXnm2zoF4o9FSRoOCE5DEKYPlTY55VaUyGp3?=
 =?us-ascii?Q?J3bD86/A3qYQjRMYP2CcjmjbDj1ZJbb8ZpwLzRHhWHT/i79TRD5JP6SUQDO4?=
 =?us-ascii?Q?g1UY342dXUI/LYK4iSc9borvfdDy1mrybnpZA4Mf5I584nuVftzzSuuKSBBP?=
 =?us-ascii?Q?TliHBrCuGYj2ztLRNH04cUAzekmpjvQF49xJXOM/M2QB1ylbGAyhFzz0eDpL?=
 =?us-ascii?Q?H1kHo4+KfRipU+cOr22kwC1rsQoY6PbEx4tdo5hVcEvS2LOlg20OenuEpGyn?=
 =?us-ascii?Q?MycXJPwbdIP77YX4kVIX8xyFkf8gdVEGG7Qs7jYYIjYYOfXUfFJH9WtFicbN?=
 =?us-ascii?Q?pMvn09KSrxPiCKah3r4WHpnPWOyCdkhF4cRwjR9HZvcAEBimzLljxOeAy8No?=
 =?us-ascii?Q?CTrosVQm7mQJBiBMfK6aX19REYuERY5lGsP2Pp/uC4kNnA+UAUGpRF5Qqcxp?=
 =?us-ascii?Q?b4DOSc5iNN9JOIFDsh8do4fm5F2sn2ZItpqyH8iwtigw7fQFuhKdAng34wP6?=
 =?us-ascii?Q?lNNRnPQeN/vYgyWQZYhUU2u8yWmiAN9iDORkcGzpSHvHNFa1Bc+dDUuI0Z36?=
 =?us-ascii?Q?VXc1tGZy5Whn4yDPSUyGqay+LGjwzB4TDFOu1fX9veq1YPmfseR0P+TEuAbi?=
 =?us-ascii?Q?QKKnN4hHMFRVaGTbGwDC1yJdvyCrAS5JIbCY2euO3eyHwLip+ehL6WoWMpW8?=
 =?us-ascii?Q?lzrDf6mUzPIpX/22U9wkrg9e0IJGEJYvdpIXZ4cuK2Ly9YO5y5refjNcdnIq?=
 =?us-ascii?Q?9alEaZL7WehxzyzMyfmJVg+QrKdliDYMqJaIpl3xJmEJYJ5x6gYyVemS1GmH?=
 =?us-ascii?Q?OZC+e8f6/jQq1x+hKqC805x5SzuzDSArCm499DfqB3NtOd7RuvdMhEiAe0XF?=
 =?us-ascii?Q?nbHGu0PdzzYanB9Z7BzyPcH5ru2cRrnxnT+yM6pVJSvYF9xY9w8P0nCuBog4?=
 =?us-ascii?Q?yz1tmqaSPX+uKOxLFsRUtbzqqhj3XRuEQoGSKFAXuwJ7S2WZOjXNDwAqE2QW?=
 =?us-ascii?Q?PfO187wa+LOXRBshsi8HVFDMvK8KCNIG+vxM2udCDQBLJqBUoWZCaxX00c3f?=
 =?us-ascii?Q?aQoDos9llTsJA5yZdc4463zpEoPAceV/+oxgI9TpaYhkMkvIGygfJhqadawe?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8a1d7d-0723-4d25-ad79-08dab3960b07
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 18:57:04.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Wy9j+Dz78Ie7uIOZ7vJ66n4EZ0KJBnB9CRRfWCWDI8O77h+sYN8RYWljf3XSy0f00UCMe389RETWpMIeqUPLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210111
X-Proofpoint-GUID: F1_lxwsp6gFSAdwNl4h3EoiG1HxxuWUK
X-Proofpoint-ORIG-GUID: F1_lxwsp6gFSAdwNl4h3EoiG1HxxuWUK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 16:04, kernel test robot wrote:
> Hi Mike,
> 
> We noticed below commit reverts some hugetlb related code in fault path,
> and we happened to catch a "userfaultfd hugetlb" selftests failure on
> this commit. Could you please help check if this is an expected result?
> 
> The commit message mentions about:
> 
> "In subsequent patches, a new synchronization mechanism will be added to
> coordinate pmd sharing and eliminate this race."
> 
> We noticed this failure still exists on the latest mainline head
> e35184f321518 ("Merge tag 'drm-fixes-2022-10-21' of git://anongit.freedesktop.org/drm/drm")
> 
> Please kindly let us know if you'd like us to keep tracking this issue on
> mainline, or please feel free to ignore this report if this issue is not
> that important.

Fixed with commit 2ea7ff1e39cb "mm/hugetlb: fix race condition of uffd
missing/minor handling"
-- 
Mike Kravetz
