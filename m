Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3E74915D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGEXLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjGEXK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:10:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4FB1988
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:10:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365LuPNT005375;
        Wed, 5 Jul 2023 23:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-03-30;
 bh=LP8aD7/sIRvmzN6JOMnWgAnUHcEtLh+iin698DhKQwo=;
 b=F+2SQkHTrE3Vr3rktQEsxSkdpPAFePj3oDig+HN/V5dhvhlxELqQAz0Z5L5q9vGHC3I7
 5dxpZGQUHOeTEUYr+d0NC/qGTd9fB+LpAoPLH6a18DW2jaT18cNbYbIFnZEziX3Y8BD0
 PbfMFm7VjH+dxaZ9IrHTxah9SLeH9fabHm15cC7AQihOgw4Edp/OECWJDIgOj8Fj1j7n
 Iv7v0kmX+YVn+jYJAijtMyY8EhGyKy+fX8oJzn/m7oOoA4kYmwrACEg1av0GOBADpcAH
 LHmBm4nLSsIuK+yTrvtkRADCiGLEdKdzPF0+WVClYN2EORYnQS88zi30Hzsrmca0wWub Fg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpufjcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 23:08:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365KksCU013596;
        Wed, 5 Jul 2023 23:08:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak67yxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 23:08:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG0H53YJe/vYEJXFDqOAl88dM3+OvfrG/PG2xJe7NyONjsSohewekINNZBUG883ANBfmwVfn9NlaF1GTD8Trbweq7HotzRTP2a4A2M8QUJXpHV16dLiU8AcA8XIMBWKNDek9cL9DqPVE5XT409m9UFJDsPAO1WTsc1JbDWtBlYyIKD4F8001kdb+gNgWgZwyID84UGn7OLBxdxLZZoRg/OkDYQ4yqcbugjjW2u1/EryaQgWOmO3lG9Rnk1CuSta5w7GYAScio74AIOMj8iKIwcP6fb8iKY9T16pjM7Vw/1LgpvcgNMqVZI6F4hG2Bksg7+4T7Zgyff3ipN1e9vwNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP8aD7/sIRvmzN6JOMnWgAnUHcEtLh+iin698DhKQwo=;
 b=js6rXHiFXELuP3fjbeNhxOSL+NSzgwuEfBMmk571OdgpBKOIic8+IKeHeA0xKLQXXSgLPbvjv5RcrfX05DcL3a1jwEw1zYv9/ngt1LbsA+l2uUieboCFxVa13Dl3kIzrbGBe+UN8iFBhdDZv4dUz+BxmeIafADTa4/d0GsZ9WpPmSRt/lQuZzj0SNwgMCiYbBJj6AHIK7chbi9WtLYUVKt4eGB04Wm2YhHTmCksZojT9B07jCjyIu0apwMOWGUhWcGOuvOKFaBuopp9DmYb6A+DEH+kugQ06wqtlsGlF091y1VoO7XOqVRQJrUt3zPbSOqjhHtkstQNQKo68ewU8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP8aD7/sIRvmzN6JOMnWgAnUHcEtLh+iin698DhKQwo=;
 b=S9wwTNsMLf3D21AcEkaSi2T/rS6Cd8K9p7tFGsP9CuEO/iY1mzGxxEmZYU2zXPw/UTb+/m7O7EfMKMg9/pUjUIR/yGaNMEdV8OIacjjd4653/nxz9Ma3ZlRRZq/2tbXsEPIwdwIpvM3/fXXY1xPyLlSRZlPUn+/PTDDGZ1ZLYTQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN4PR10MB5800.namprd10.prod.outlook.com (2603:10b6:806:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 23:08:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 23:08:11 +0000
Date:   Wed, 5 Jul 2023 16:08:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: mprotect and hugetlb mappings
Message-ID: <20230705230808.GA41006@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:303:8d::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN4PR10MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e2e423-dbb0-4791-29ae-08db7dacb435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyWNCdNUcXgMudz/0zPP06NyvKg2dWBY5L2oI/ERrNFTkYgA+1nx+3qhk5gGOCzymjbpTczR4AaYclCe1GCytgAscFyDLiFuf6sXGI9HNcBkVPcF4hQmRWclYgHGdC+EfB45xAScafHstzYPsBmyQvJCGQEnu0NGTbeksQICeRl3gGWfqsGlSQn2GivUErY54ImPzgLTUcAJkGiHFUkfFZXY2Ss+xXEc4f0aINwICs56qblS3sMRV+mGSh2lABtB7z/xUt4t42VEkmdPoMQWjrgLif9pO1eS1TCIiYgBw4gdQkMR63IEUYbD1Rjl+1EOKut7GQkPrqkbYvdRL99hANzpQ4UsaEUBtn1kuJuEspduBD3WQWKQoqbS5L6y8RV68+FO3GCed49eJkVBbzBaU339+xQOJTu77P/mvDJDZuPfZ27W3aUGb15t0+pNGTKNFzwLofZZUPul8Iwt7g/tH8zo2vT9zJJvzGZ68dQtKEFH/imUvE5MEXzoeKyPp1HMwhzj5hMgPZbD8lJR8cXYsqp8xa8yep+XADcdqvABSWClakI/DYwJI2feswLI3qE4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(54906003)(6486002)(4326008)(6666004)(478600001)(66476007)(41300700001)(8936002)(8676002)(66946007)(316002)(3480700007)(66556008)(38100700002)(83380400001)(186003)(6512007)(9686003)(6506007)(1076003)(26005)(86362001)(33716001)(33656002)(44832011)(5660300002)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y6U/W3nqSJWl5rp/byv147DFvJH0vrPimPbG/fwRKzgY/tFhxx8Q+rkE4kD8?=
 =?us-ascii?Q?6ZBn78oT0K+PY5lINLlmrp1CivqVwUsKXs5n5VPW5aG/vxJwEYwV3SXt9civ?=
 =?us-ascii?Q?Q3ptAVl0o+QvHe1iVRxixog1LHjm8kdNnawgOHWtzD0qduJ3KqwfaNRnR36r?=
 =?us-ascii?Q?Y/4DNihcetWgBJKhcQ+aRVB9EOhc5VbNf5/BO8j9xEcvFGstwGMdj+UXnKAF?=
 =?us-ascii?Q?7JGw+6H5qi6saEbCdR9uVMyP1Jxe5wZL58cEAb4UWnbmpjOtHj9+a+uHMJc5?=
 =?us-ascii?Q?71GguUT/MccHrPwMa1U/S2ptEV8g31mmx2DlgV5Cgs31z3cJlrqQgqktmiAi?=
 =?us-ascii?Q?lRtfelQbHhgF4HQlpyhuRmMXkgZf0sDtNPy8brOlRphU5n4t0BNm+g0j5suz?=
 =?us-ascii?Q?v8FqVRitfXMUNhGC4YWHqh4TpK+uG8SPkhDbBS5EGjKWbWRvar2gF5TnRF2T?=
 =?us-ascii?Q?ldHUgyVL3lRKwbMLzlTv/eqbuA2/OSNlS9TIgJlLQhCHOGF32QL+wvgp1Kt4?=
 =?us-ascii?Q?3One+usBTB1TpN27gMceCF6QLKV8FTWQVN6HH/0aMQ/QmT1UZpZw33UdYKA5?=
 =?us-ascii?Q?33pw1/6RZvuwMRhaLIMwRrr/KYYVtpBZ7yMzzgwbLlhnDpr/RoI5gx7Uz2nu?=
 =?us-ascii?Q?UZ2h2M6Zcnnq8VtcCaBGALQsQOL6JEXuG4MA+I2M2k/wAFEZcipfU4zODfQh?=
 =?us-ascii?Q?JVNi4iaKPHVlhz/z4+bW6HiZsib5WE13OvU7tYUabB5UjihVg9qk5RZqk3o0?=
 =?us-ascii?Q?gEGzjGQcxOPHVyHTW6RAA8WLGyP68NMdxZ5o6OzSWbg4yXopEFOhhKFHSclw?=
 =?us-ascii?Q?xS9/d0oq2C5LR+lWUoXKyA8GrYDbNAFJqQ3ZccYukuBUvBXbNVIouzylYbQk?=
 =?us-ascii?Q?8wWKISRdUHoji+s+wQ03aoQkOgyPiLq/oUh67mQhefJs0SdHy48LY9Itv2Wz?=
 =?us-ascii?Q?QWQzbh1rMb5NCT15YM2iSiwsj6PhrU8uZFRy0Ko+s61My3adUQHs5p96zh7a?=
 =?us-ascii?Q?KcKzgGAFjMboDBkV80EkGb+3RMWuulTR+g2Ntyw0xyHf3WbeF4feLhl1RkKE?=
 =?us-ascii?Q?jrNJrrD4U1oMOpmVeeaPobcUh1OiOqO2+XdjeCmfuXdK6Yz1E80PnLufzaLX?=
 =?us-ascii?Q?0tZhnSfVdAsOmsBOsMG6Edq3tsPRdmPcJmJeRhQ7lr7ERdViXDr0vWRl8F4D?=
 =?us-ascii?Q?6YexoA+7zE0HxQzzUii3yhDoozu5Lsv5hsl40gvsYyG1QeXQ38wpGQ4+R87v?=
 =?us-ascii?Q?bhIz/tAO/d9OXwQyHBDCgz8I3eQwGI9HgRhdOcfLGFJtJNE1HWJjgfYfgPxq?=
 =?us-ascii?Q?Q+jNqWjcskOPKJeSaryYa+1sRsLYLn9futowf/r/5R2YAPdlpCrwGXl/AF+p?=
 =?us-ascii?Q?SLlWFD2XbAkeoRW38kCn9ciyT8i1IF7L/J9fSnzJVtmnb0Q11RXgJyVG8Aw/?=
 =?us-ascii?Q?jmPGOwg8a+nuA2bfWuGf8j9uKQ9+tJL04yjQiP/M3aYOF/2rzajJ8MpgB8Sl?=
 =?us-ascii?Q?BfycIa8O4BiOkQQis/PlujOWHBjo1OJIMtwdB6F/r8Tytki5gOH4xFw94j4T?=
 =?us-ascii?Q?Q3CbSgkdZTSSP6gn5ETS1vLj8dDI1TSb4gscMrIpfYRrgQaxwOdT/upPyKzG?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iVEQgxBZoAUV/p0JVMnlhi9/ncycHWjTC9X8UV6an4GDIVKDzS7VqhmCxt9s51niJk//s+vr73caHL5RPyGAFPSHM0waameTh950T6Je8+eae/czsr0spmiWaLUeBWhJfTy9+ScmG5vwnUFU/SWcnXtHPIqpQQjWMyHVoJCOt12t21JwMXd2YS9bmde9mOnBETOwtbwl4DdLoAVapeePrczY2Zvw5XSQ/qNg6F/QrqeJQD521lt1RFPi7vyxJeP0ueoElKojH6SggeSdS3K7UA64DYG51r8BAULq96UVT1NyBoxdDlnYxx6ess4VtfBTq4I/9mTplfeFFnX7DfL7Ig+6ie/aJnfEcAKADiri88uFsnAMORdc88oc3N6fl8wwBJ8EMzPLXEAZpkUa4pjxp1M+Fn1rov6NMq/dqnBWNnclfc8jdCPoCSq/h/lJXZviQYVCGLsmeo92SJjuBsAVyzdcpgY/bnvIpuHng7MfSg1wvltuqq5Vg//d3qBgf1k1rmt5Derbh47ttcGAeZ3ECE5JDf6q26/7y2qPhO0Azcp320mGYeMhuD5j4wzZcb4goByGGY0A6AQ2htMev1M9aKTxWx279v/33LjnxcmCyT4M7RPzdRufF3YhF89l1ZuHC2bTgs42zbi12tIp7MdzOiom5H1iWL/eWonqqI9lIO8CW5Fl+q3Qtq8gRxpNIZIJKmkobs2Z4atlpxXEopfHpvbUWyIsAkw9DuvP0Qnw7im5lS++3HfijCRCuvOJOJXfx7i2Mciy9GRDJIiR/BrtlYKxTGbgqdxrhw30mRDgYGyDUXgndkhMash2BX9n2l+sxn9w2QfUjQFk/CmOtb1i9OjYILGATRipaT98Kzbj7gWx/S7Wagpr8kX/28flCc2vaLe1b1tMX1vF26ubXAJ020dGVadvQlpRVQf7dqajBFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e2e423-dbb0-4791-29ae-08db7dacb435
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 23:08:11.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLLlWgrVTR/z6xx7hv834pDYpIxB78vTBBFU2pB4C2V+pDGNxm5mgPOVS3ezPx4zJEW9keA5DEUehIM7nhXTIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=390 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050209
X-Proofpoint-ORIG-GUID: Hxe57qKCt3zmtEXZJHqRyPJqfGm443ia
X-Proofpoint-GUID: Hxe57qKCt3zmtEXZJHqRyPJqfGm443ia
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was recently asked about the behavior of mprotect on a hugetlb
mapping where addr or addr+len is not hugetlb page size aligned.  As
one might expect, EINVAL is returned in such cases.  However, the man
page makes no mention of alignment requirements for hugetlb mappings.

I am happy to submit man page updates if people agree this is the correct
behavior.  We might even want to check alignment earlier in the code
path as we fail when trying to split the vma today.

An alternative behavior would be to operate on whole hugetlb pages within
the range addr - addr+len.
-- 
Mike Kravetz
