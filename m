Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309126DA4B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjDFVcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbjDFVb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:31:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6541FAD39
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 14:31:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336EfHsf013890;
        Thu, 6 Apr 2023 21:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=i4VYxR4kfe3B5oqhRzQwh1dtWE5aJIgNC4d9/7WvcI8=;
 b=JuuslUQY/9g5RKRWzEXG3nl4DT0kuQepRgFqq6nHMkm0EM0WQG++9yF1gecUb8Dp3AFV
 3LPWQlBeFIQMvz4bj0UTmfUd6X7UYQ9Yptxs5RULpl982czawFD9Y43iplT5/XxaohJF
 lz0v2MtSBERQICmQAyTxlazDyXu8j5Pe5/PTQvjjCvTkQKpuKRyD0Gj6jZdxrE2Wp7Fz
 5rhzA0kT7UykJJQZ4TMceDiV4SWmdhuDKhkAAL9seJ1i1WBI20GF7RWL0R+FNi8TyuWS
 ZR/s7EVK4b/1rlYBIGrN890y7N1MowjmbjG+y3fdVk2n7boVdgAPB+xoYmOzuXF6aKPM CA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbd43yp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 21:31:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336KuWA1034219;
        Thu, 6 Apr 2023 21:31:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjvx1ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 21:31:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9G1Po9ccL15AAyTMZmbsvBPzDWrIOjy/RFMlYpH/jCcvEXLrKUC7NKC5UohyaT4b2jGH69nQ8OlSCymDgr+0mGEiIBak74pNXLsikw6jYU5TiXNBa34Ca6G9w8yWfygxb32IT+Ph7ZbyNk4wetOoTNXcQ5rCBr6KwoWCE3QKR1Ca3dc2yVH2S/Pt8CblFP4sIp4As4aVUcNqCM4rCBeYGxQxDRi4ENplHnaWV/SliotxCJ0UOSdfNF2QIXZcXAA77pcx5m+b975l9XCSLkEJKNbixRkRDKs+nubl/RW9v/dAZAwwyg5HerRJv0aLqcBg7T3oIrLAtgbcfx5HrByLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4VYxR4kfe3B5oqhRzQwh1dtWE5aJIgNC4d9/7WvcI8=;
 b=YNOnoDclEbjaac9/Wgc9MShd50xzZWW/oNUN9K1Ta0zT199P7sWmTx1h+htL4abwIyHljvZLGQHaAUQ+sV5RT4NRlIl3UpOWOMgkNuZYd2w2LU0hMqyWZ0O9EueUbGUQEwG24K33Xz/G3kRZGcauN2OHuyC/QvBwiY/eXeadTtHwmUBRhJ54//R1WQsaNMTmMMI1vhXvMV5zgcMKImyfqMY+7MkhkN/dRK/1xPz9rhaoQwmjzCsd0KHeqD522Y3qfOkK2PnMqWnakO3v4q12imuVKVcqNrtJYf3ebnaX+LDfq52Wo3HDnG3w8C1cCagR/RpamMfh7bptZAdoOxRSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4VYxR4kfe3B5oqhRzQwh1dtWE5aJIgNC4d9/7WvcI8=;
 b=NH7nUtc2h8N4q0aitVbHi/+j2WxvmMzQMBZ9T9cwOfGcBuMhhHt2LbQHVQBl8UPvZU8DB2G9svuEU/RreZzFU+yU1jyBzqyfDRDfGmQnEoIKS005KIwwCuWT7LiyqfTchOwHpy9jz9NLazozbHKaL9PVTRBbN4lhZTJw52sxddA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB6296.namprd10.prod.outlook.com (2603:10b6:806:253::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 21:31:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6277.030; Thu, 6 Apr 2023
 21:31:31 +0000
Date:   Thu, 6 Apr 2023 14:31:27 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        sidhartha.kumar@oracle.com, vishal.moola@gmail.com,
        muchun.song@linux.dev, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH v5 1/6] userfaultfd: convert mfill_atomic_pte_copy() to
 use a folio
Message-ID: <20230406213127.GB14244@monkey>
References: <20230331093937.945725-1-zhangpeng362@huawei.com>
 <20230331093937.945725-2-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331093937.945725-2-zhangpeng362@huawei.com>
X-ClientProxiedBy: MW4PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:303:85::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 7579aabb-98c7-4b5d-84a6-08db36e64985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kflpuuL8GrrEKOspP6sW4cyTyyYHjuuSsDgy6yGt0FcOokSWjDfxaruf4qQes84PcFKChVpcXW0jeClaGWhfVwVlVvnzvdd4xX3b7o8c4XyTF60s1HH0ezYCKOvjLyXLKZKaIeVGUj9HTz15aPobOCZSsONHxSVlNAcRau4F7OI3q6jIXrAUoi784/O8DkrxPPWIGMkH94xqEV0epWO8G/43o3xZbPOzcWwfv3mr+NJNQAlGi+fDi3+AND0sjrqRvHr9dls06O4SGlsH+6JA6E/Fsknl0Wb0ozRgatNA/vjecLkaLz47OMNOxi82OobBM7ySDpD9slmnGo5ubIyqtKy6uxdLj/XjpDvZAZId8Xq1sk0mpUuk8TbTxQeHADavCqP3zC70DOBffTvtRfxyJLHCBNgNKWrhmb4KCshb01XLcIkV1cZCaJJMssf1Pn/1S+DSjwUhxqOMFWeY+eCc9z0Sacp9x83ph2ISDJmPLkgFDkUAShwkXIjzORg/mw7IzRmabwyzsmhLnUbhic5p4hfpDRPvmxL1UG7DVPg7Ak7EvozfXAcs/8YF9+Emm5JA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(38100700002)(86362001)(33656002)(6486002)(83380400001)(26005)(186003)(6666004)(9686003)(33716001)(1076003)(4744005)(6512007)(6506007)(8936002)(66556008)(66476007)(53546011)(478600001)(316002)(4326008)(6916009)(8676002)(66946007)(2906002)(44832011)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e2/4nKzfSf651nqgyyo3fWSWlQC0vsF+U2onbLWi7uk5/deEEpBBfJOGRzyg?=
 =?us-ascii?Q?GchasZfsMe9G13H0oThirBr8dDpTsngXbLVb1btYUElXUkyWDHeNCA4r5bIa?=
 =?us-ascii?Q?VRC28kKVlQQ2Tkwc2qZW79jBS7ACAhCP+tdhtEQIupFYcwHY8GgdkjrHxS9+?=
 =?us-ascii?Q?mNkQWF3BAwqDUC/JpOcXcZyB5uB30t2HBycthlGk3XyC4JkfgO+lz5YMoku9?=
 =?us-ascii?Q?t2cj1TTQDcxOro/wOC6sMh+ZNeXgHASiS/hfSrCVickhe/XPa4Lk1u5Y19la?=
 =?us-ascii?Q?3Ixoqi85GU41sVSIXhiPHGvPILqT8YmnNXH/MPuJxsy2LXemkJQGtYj1afnW?=
 =?us-ascii?Q?0ynUjgZJVa/gNnbc0ZvX6hnuemGkh4Ex2dK2FU3WPcZ7hzXB+gx8H66XbhIR?=
 =?us-ascii?Q?7beMcY6wQyeO66E6fCPwV6V5O2JAZkxRfGpvklNenyWMIMZf/ls7qPdffsGA?=
 =?us-ascii?Q?0NekBGTBImBWw0ojwAsD/PLsSePa7wG5Z3IbTRD1O3uUz4pUnmUVhLLB4+6T?=
 =?us-ascii?Q?1X0A0EA32sZyeR2P2gyCgmlR4uExWzX42U+QCVsB8hJFy0fDiZEwScawcGPG?=
 =?us-ascii?Q?pNN5uUNGdxYOPwRNp7a+i+Xt6zHOfW3FKdcJmEkw7b/xRphY7xLXJiIR4bqK?=
 =?us-ascii?Q?05sHLy/dg5DuqUV4VsFFakh91142ed5rYxsJ7yybxOIHgQByUGCLRN0EGXSa?=
 =?us-ascii?Q?GKyZ8QR8MP980nUnslPeepkOG7WETXGs11CnBPfpF4xL/EXZCH9NR2BW+rhZ?=
 =?us-ascii?Q?OgFKHHMGkWp5L2iB8gqEG7Rcp9kCNU5sZ37kOtdwCCt7rA5ev+oJgUP9zWda?=
 =?us-ascii?Q?lDeYKeQh4R5ANjg/JCOkPu77ZuJZSPsMcH5YCPwoQkr+G50iHkpgj8A5bojJ?=
 =?us-ascii?Q?sR3mpcWTEj9NmiTeJBqUf6SfoQSUuF1fhfvtbAqMpI/fQ8reWBRkLIHsMJkf?=
 =?us-ascii?Q?tULADDC+zG0NVdIFTevcfYnKJ3tLjKkNH1u/uDP39X/nrlLrixjboVKVrn0D?=
 =?us-ascii?Q?3xXzxqjb8bmGyLncz4z0WECXSj7H59YwXWDWxwA4elhwEzBo/34dQrbdkxiG?=
 =?us-ascii?Q?aV9/wwkgMXqh2YwnwPLd66CwA60lTmVR2coghU+8l7cPHxUdTsULOJhugBHP?=
 =?us-ascii?Q?J503XMyvXYi0Wtln7gXbceFTSdEz7JKfELBSUZG26uwMFX6EmieVL64YVFM5?=
 =?us-ascii?Q?6FgNNhT4muyrWtgmtJg/iddaeVFq4NF2YC3mIMWtnEIVW4GhcU5+N9HNGZru?=
 =?us-ascii?Q?yjnYKc3yKBDbOSrP/Bbnd5pAt34uPFklQzH806ng/esy8NN6qBHA8wRpefUc?=
 =?us-ascii?Q?oSGf2xTzCMfuE779KUYjzNmqDZehIucZEAeBAxQv470CEA8XZ8IqN5Gl47Vf?=
 =?us-ascii?Q?qKoe+LsjdVuBxkUPk7Ynltfie6bW5+iTj/s9bP/ZQfTfHafdrBbcZQDzqLZ9?=
 =?us-ascii?Q?MhXPfhpdHrRRcnRAij9uYeb0NRv02FaHoYAG+B0ir4cBnh/QTg20kPk7Z16q?=
 =?us-ascii?Q?KY/p1j7nS7enWdfUPNKasD/om8ddqAWaK8NMmYAdmKe0tGrCNK30bd05cfLi?=
 =?us-ascii?Q?/KnscGw1KNCKRZw+vVSZDeMl/rNXi38nz89ELpiyFsPLQanvwCJtzpIgWHpx?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?gQmgyXNLDVklYejaluxvndG0r6jsrwEKXZuNb6xLgIVSqdn8xrc8hruTFN/c?=
 =?us-ascii?Q?I67uI+RR3cOF02PG4vU67SkmabHxbglBiu827ApAlxixDvzAkUf/dtbbioQO?=
 =?us-ascii?Q?CXxQYZ2ihBbFTCccAibd991V5bF7pdnEMFs9wPvOj3Lna3g/DucKz1/6X0Op?=
 =?us-ascii?Q?TbmdzIKEWaVLKU8XOeWD+DNRy9pfmbu/XtvrvguTb/u/qlGpcmRRiXPMExQk?=
 =?us-ascii?Q?J6mlUwqhldLESOuIybWSZyg9qqksqkU4hmVWze0fenYXNQv+whbQyy/PKsZ3?=
 =?us-ascii?Q?Lz+j2EUa/lxdsOXWntTOjU3Piktp8UqfTq12e2Q7YhHvsar/QLTcpTcdKBaS?=
 =?us-ascii?Q?gxSpiKzUd+1iIZL0j24yGe1QGOK1ap3rH1AARsKq6yUhIFFiP1hNTYLYSsW3?=
 =?us-ascii?Q?gLHZv25XANBJU3bip/MUH4VIrUR79Uz9UUia6/i2k1noqkvskkLeoTAu8otn?=
 =?us-ascii?Q?mnYTUfsOjkrVrcak+WO4QHpAa/OHZYxFRNs459CTT8GyybkadUenlYu1MrW8?=
 =?us-ascii?Q?Jk2mmiuSGsG7ZUOp+Ho4q/1kghiXmo2DbBesOCJfz1dNLRr2/yXBizNG7brd?=
 =?us-ascii?Q?nkZmQvVVR+CKHtd7EmWXWOBT6dwjF1bBU0NeoTkDOqjegRS0zhPyK+xxUMFZ?=
 =?us-ascii?Q?yK8OauWg77AsWP5sHsUBOj/A23OsfTJsNr6zT8ZOcEwScOfh7YpRkJuSWRG3?=
 =?us-ascii?Q?81xkZ/8JKXF+jT9v4w4FQ+H2b7xI8JsaMPM9BU942kTN2wWi62FCFNKw6JGn?=
 =?us-ascii?Q?HUQBADpcXcMS/BBV3zJB+TzhcJz1pmWU/kOoMWbFTMcqH8tpCXT4zfQfUaKz?=
 =?us-ascii?Q?XXmadxzX5TD25czOOF0QxNu1bc2etA9LGXo6eESB82laAEnNV/ZMyoJuZKYE?=
 =?us-ascii?Q?GSlJmTEyakfd5CaBSmZpxJShgxeTecCu5XXm4jgYSDoDFvCLUSatUA6Zdi0H?=
 =?us-ascii?Q?++Z9+C4b1ZCNsX8YrcO0IA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7579aabb-98c7-4b5d-84a6-08db36e64985
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 21:31:30.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6e+q/CnUjy2hPSuLzd7taMy2ARd2KfhZD2pNx4ltyOfK9Tmv0h7DfV5O/+EQXTUaGU0rQ78Xh3qdKRI7qdT7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6296
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060190
X-Proofpoint-ORIG-GUID: VW9db5eZIJXUAt96YiG6vr-NsrLNdy2p
X-Proofpoint-GUID: VW9db5eZIJXUAt96YiG6vr-NsrLNdy2p
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/31/23 17:39, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Call vma_alloc_folio() directly instead of alloc_page_vma() and convert
> page_kaddr to kaddr in mfill_atomic_pte_copy(). Removes several calls to
> compound_head().
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/userfaultfd.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)

Looks good,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

>  	} else {
> -		page = *pagep;
> +		folio = page_folio(*pagep);
> +		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>  		*pagep = NULL;
>  	}

However, I am still unsure about the reason for adding the VM_BUG_ON_FOLIO
here.
-- 
Mike Kravetz
