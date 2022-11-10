Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45608624AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiKJTbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKJTbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:31:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9291045A12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:31:33 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAJKvUw029620;
        Thu, 10 Nov 2022 19:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=GbugLgu+nmiP/t0sTd/lS+7Z2Anw66vk7i1+xPNlbWw=;
 b=o7pNHh8u/xMU9lrDEZu+GAaWKKG4ZB2P+GWibq5DgOwcvkCCCmtzEtlIC4STZeZUkrky
 TYTci5UZqTq6IOESN/M1CWZMd3dsOyO56/mFeYhOoQ8ognO4dG7zJDPSXgwp7GUT9dpC
 Sjl/bBm7zbAEc9+33/sOfYZCNrP4n41c6CmcSbx3Vtxqm0j/8CoV3X1WgVL045N1D2ZV
 Xlo4RLOBWggObpdNxOQ7PmS0+Mzj49SnRSiwQMJjPU+wVzrL8MHo2Icbbv9qdte1Ef6N
 B27clWrKPqzR4dAEG4TKdL2WngXv1wjRCDKpjR8+daLtro+bw/U8hFUvReJjTcpgv4De pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ks7cf006s-80
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 19:31:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAHavaY009668;
        Thu, 10 Nov 2022 19:08:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq5ca1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 19:08:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKyRF6U7spjirwj/W+1Q+xpUBb2s60EovYIBuanZMwYmg+zGnCkAsVIoMqAH01Nwn3+PCJrImcKWhITJEQa9UUdm1ZC7IG5UuH08wP1EMZOBsXrbSHaON/8fQKXwXNufJ7dcype+huKbQ9cRo97/Szc18m/I2qqmA6SCAa+jL296fABlCFdrLkyeySqoaVn9IWQ7n96FQaW1mK/xTsBCIbTw/oJbs7iyP6glQppqbpqf9JaI+jdHXW1+zSjlOSpR2d5tgsNWCsW7yRRJbQzM9c2sI8xlNX3nKYE2vmh1610KKOiJl2mr/K6XNl0zpD/rLLqmnxP9O5PlcSX5Xlphkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbugLgu+nmiP/t0sTd/lS+7Z2Anw66vk7i1+xPNlbWw=;
 b=fjYi2/NNgz2XZPQHBJZkO9hzMHtOMK9hSnjmIpNx3/o+gGlEE0nxcE2DUaFTpwHR8PD9E/hUw/4WLfIxxZcoljB/HZ5x4eiacVWGGgeePHikzr7ZU8VFJkSc/ocEiglOgQjAcfNhXjS0GIMf4k1luMTWk4QGc+WClO8Bz0vbAmJLy96KomV8rkylegrY7rxKSGozp9BE2PFMZQ5XjHWQUefnYn1LzHpXaJ/lcT8qSH3LnFaN1+fvoo5KSParxfzMbLisCn7NjbhD1cNKZi0RN7Ugy9G8QsRSN/7U7NnrojGOI8hm3YJ5/gvx/6+nM7iP8MzJdcPSEm6EFWKUTz9Scg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbugLgu+nmiP/t0sTd/lS+7Z2Anw66vk7i1+xPNlbWw=;
 b=cTdybO8z/E7JZNmV/Sxwfhht55IKD5Ek6Zv6HMZOp77HhpvJ0NEbZBSWtMjcEr/ySQk5iO57sEXG/c1KPui4kRJ3g61X9VKVRFTFx9T6DCxuvjEl/Eopra+VOhrh9kNj2OZ+EtaU1MqBAka9iWf7MQP0fCwpQcFJNvCbn7duO08=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5122.namprd10.prod.outlook.com (2603:10b6:208:328::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 19:08:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5813.012; Thu, 10 Nov 2022
 19:08:36 +0000
Date:   Thu, 10 Nov 2022 11:08:32 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v2 3/9] mm/hugetlb_cgroup: convert set_hugetlb_cgroup*()
 to folios
Message-ID: <Y21MMJML0CrWmivY@monkey>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
 <20221101223059.460937-4-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101223059.460937-4-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW2PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:907:1::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c31222-2a26-44f5-7532-08dac34ef758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqfy6kpxUhxepMaIFkv1P8f0u7qE4yGEvc/956CMxnkW1uO8XU0Xj1iCyCdhce2MBDOzW/Q+VBdn3/e/hlS02o9nDvGOXwAloC52Amkf31vxjV6ZGYCtG9wivan9VLKRlf1m2i/trHLsaBO22+kRsYj6ay1mXoC5IeLNGHReVRecwJqR5qM9Abm5ti7UfqzjOH0fr1qx7/N9NlLjahhGHKJiBCXP6MqDwfL3oFNq1tLQaU4OglnAzayt9T1aWlBWXQbKozb9sjnEbN+P5HejmfHAD3aDZjjdvlvXpRrHdHFDt0PeHSqXD8+flUd6HpGWp3rL0Foc717i1iU0XscY2Y7TKUAdnCHOtqnh4EKJpyPoFqwa+JDHMkJUAY3JSf8tGNEph9gI7ourCdDJbLA0hPniE248uolX/OiopHgO/Lm12k2kS8lw3ZjIN/xEQ7dNEfLy48Yoi0hBZMIZQyLqAadt/vgt5JKXCUUta421yyM2LmRnFcEehv22CsKsBzIfWWo7q66OjI4IQ5dEyYqaAYo0twxSw8ya0r40c9YV79qjdxLx3Ot0dFAm4yyIdPE/8vUGsuQsCqwmHyNclBDtw5D3zJ9nbqBMURAoqnrQTwnbNAjw1qvPWGz0SlB/CwFwY6PmUrMzZmsDmMb4KS5gPKisECkSx3531iZE+SYGrmVirHAy8UqVjZoGAxXY4I9UdsFX8w1kgtve6L792hy5mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(83380400001)(38100700002)(86362001)(5660300002)(6636002)(6862004)(66476007)(41300700001)(8676002)(4326008)(8936002)(66946007)(66556008)(316002)(44832011)(4744005)(33716001)(2906002)(53546011)(186003)(6512007)(478600001)(6486002)(9686003)(26005)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3qQ+VVhXK4ssnO15iLyKbf6l+b7pHYtFRxQqmYIxiEFCHaD2p2R5ks+TDgFw?=
 =?us-ascii?Q?2vLh+wW+oxSKmR/PmskJQWMDSKEbVccHyGsd44R6Sx0ze5ocrETPo2oIQ4FU?=
 =?us-ascii?Q?7g1qPouNBeDbw16I/vqhmqofq9oHPJwx3PWs8rQDs8Edco2WOQ8eg5zK8IJu?=
 =?us-ascii?Q?RSYQu7JsbGjknZvKxqo4qi0FQ5cPOgEqgKSvmy4IR8dixxsBis8lLSyHAcXQ?=
 =?us-ascii?Q?YSporq+FqcZYq9+kGVWDKALJzFYmQo2BJhwQxTa6vJoiat4fPTAY/Dx19N+r?=
 =?us-ascii?Q?k2GYmxhuD7IpqF6FS1hviV66f+rC3IYYVxbYZ/1BViDh/8SjjIEVdXHyOPQS?=
 =?us-ascii?Q?W43/hKJHrWC9zYEd0tZcQGRghzadFNmY+gNrWUYgJinrsmOaWq8S05VapRHX?=
 =?us-ascii?Q?w0gbvgRHW5uBF8J7+ICFTO+gAcI06civP718ULA1RQNM4J/4sDcJpmGNTF1k?=
 =?us-ascii?Q?Wy40mW7Ogflk1LdaJ404khKdA/wGxy8XWLDW4pCtUleE0tjCnma2RHWRpLOv?=
 =?us-ascii?Q?OVkEOPZgsHEDJvfU3ZT5aXdl7HhsbmUTJDmeHCggMKUOyUUXh9248SHjv7zL?=
 =?us-ascii?Q?gvHWEYCwA7PnLB0l79H9bNwbo8a0otGMrGwHkQ82C4ksb+l7fxeFe5oninPb?=
 =?us-ascii?Q?ps8qQv+DMKFPr1Lkk6cEmhNl3uzU0Knn4ZyPuTsb14n9mywKm5I0ktUwP6PH?=
 =?us-ascii?Q?+MuLgzaa9H89a1uHIssgiSye3LwmCfJ1p5qF4gerC6Awp9t9ZF51M4XAHs0n?=
 =?us-ascii?Q?TRgftB38HKS/JocLpcVMa43vT3b0Fh4KTXimezyWZGvSQn47O287jeEuPlDb?=
 =?us-ascii?Q?Q/APsUyH+oKqL24B88Ar43XPmTiHRfOpJXMmmjq1b1b7nKS+3kN8vDgO7/2E?=
 =?us-ascii?Q?lQwZ1lYu+U9TEJuSg4PM42eprD0h2CBNndTTVbMWg8xA8G4r5ylAPngKJhNX?=
 =?us-ascii?Q?PY1qkham8sPD1jKk0OBVpO6Bd+v+9z9+eK8+YrHaz8QVvL18px29vbF0F+XD?=
 =?us-ascii?Q?Wmgaf1X/dfCXXWf3oyn6DMMEUj1x8Wx6Eu553iX11J6bRMoEbdM20SlGoN+X?=
 =?us-ascii?Q?kmIxvyU2iCMhkPoZzVHwZLM6OiP0juTwyBxXOlPLfme0teKPSoZPXDOWcBRt?=
 =?us-ascii?Q?lBrbZ8GN0IUMc6v9JYwxEBk/MxuCt2vv0oDcUs/zMNMxXADwdUZ8Tlfy1A7Y?=
 =?us-ascii?Q?g2kPa2JdkdkKopDOQp+jjYwaZnJcXhWNA11bG3cmQBIIMOsIMKGj2eEXT2FG?=
 =?us-ascii?Q?hfbecMZ2MXE4uGiLc1qQTgOpVA5RDbwUJJXv1rcECRmPDUOy3g/+U/BEngX1?=
 =?us-ascii?Q?7vFr81vLCmY1DbS+mAz92nHR05t7qhz4MybcOP3QR13Ltb85MIBc0uOdXArH?=
 =?us-ascii?Q?bW0l7qs/8WcJIvnVaPqYYCQfpc7eg5MP6wRPxsEnGOapY/wZnVdaXRtL3soO?=
 =?us-ascii?Q?M8lH7jgtO25Q5u4forCIubL9NasDOLkBSM6rEDe+icA+jDlwPpXJWcGmB732?=
 =?us-ascii?Q?g5Ns3isSS7CldqYkNLteD00Vq5ZBvLbqg3Q3lOZC31gO4vGCurJ5DUDuvFPp?=
 =?us-ascii?Q?oRB7UZZbrwPqAtFOVA210YGZXpLkKBJOeSpp3afnSuhwWpmUZBPRBuJ0MlBx?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c31222-2a26-44f5-7532-08dac34ef758
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 19:08:36.7241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1OiKRYxld/i1N1rC7fzy+HDAR9SAC1ccPgzkM2tCk+ZbLn7qFqjrfWqxmPkhTTRp3HWzhhTpUJBrf8UDoPmtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=974 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100134
X-Proofpoint-ORIG-GUID: c2HUCCxB5AM0aYHZvNgieTc35MhL17M3
X-Proofpoint-GUID: c2HUCCxB5AM0aYHZvNgieTc35MhL17M3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/22 15:30, Sidhartha Kumar wrote:
> Allows __prep_new_huge_page() to operate on a folio by converting
> set_hugetlb_cgroup*() to take in a folio.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb_cgroup.h | 12 ++++++------
>  mm/hugetlb.c                   | 33 +++++++++++++++++++--------------
>  mm/hugetlb_cgroup.c            | 11 ++++++-----
>  3 files changed, 31 insertions(+), 25 deletions(-)

Muchun had the same comment I had in v1 about the need for a routine to
set the destructor of a folio.  Since this will be added in a subsequent
series,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
