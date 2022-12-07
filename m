Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7124646178
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiLGTGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLGTGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:06:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEC56F0F7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:05:18 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GDv0O010250;
        Wed, 7 Dec 2022 19:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=vmQwSO+sHRdOxKyssFE+1LSKcto+OwyNSMXVrYSeDQc=;
 b=ei7S0zmTKPHvKkDlJ1szWBA0i6fPb2dScLIKZCv50b5yCFqSiLhXhkzwpwlaz8H9zBVl
 Txe7Ebg3dGbXi2hBMMYFkc9OL+wyrULgHw1cSA2XTRN17gyjzURYHUCAFchxPrwyAyZX
 qGkYXZzRRvNeRjTuM3EyiKZqIhJ/E2XSlBCEo28Uh9fto+6t/InToCmbpMLCcum+b2Sw
 Pq95QQucOKueZ4LiBp6I+lb5Y8HP+KHnLX/X0hgetzhj0PYZk9VnxP4r4lUrpCrwpFvu
 X7FNs+6rSXSzPw8N/0oNGVPLkKVHiT/eEQw19xenbFYbngBRugak741j2VbJkeT9OM1A FA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maudus42t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 19:05:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7J0pFL009885;
        Wed, 7 Dec 2022 19:05:01 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa69hbnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 19:05:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4UIAG0upIPXR0A7V+raD4EOUAwc/FoAUSOGtfh9iCKKtzRLVGW4EaWhhxCLnCdJcTvg2pB7x92m5jDEfcX6F0/OO63o0IMmE3us7wbXSl9DUUIfI8bk9afpeXXnongwWBvftXGhS9DiKa2yNdaphpGqqoInaqbrpAl/D1nZJ6IMCdUWGkVGmqf843HsS1bzkIaERhw8H1nCTlKqnw+PsXNJcnd69yfyy/+88PD2L8djgMA7SMApHEZaDNv0WsfV1a7+6vEPJueM0SD3sZhXxwXxsvFjWDxzb8MuXZAufVBgjsmwayGWeZ2LXTZEzp6OLZ9/39ywjrlH9Sh1c1hHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmQwSO+sHRdOxKyssFE+1LSKcto+OwyNSMXVrYSeDQc=;
 b=n8EbWNSlWisP950b+M6h6Z99P/6RBoBHzm6GSGtfMz0/HQP7HzCo6LjUYEOLQ4MOyUOKrrMYmJXRdOEwnDcBemEAHycJIUiHFtKPQShS7n4shI4i7VfN2bVCBQWipnScC2CCk1BVfp4cpB9DKgR9xjQ9VEkIYuix74RKF6iZ6GGqz50+9mzhBpRWMrPqb+/LGgD0jm986vsNzGwMV1akNypaBE9/KS6lQkL/d2gkx/PWXYpP/kivC9Vypz/4a1TjbMK0fLVaKZ/NDZ9zpIqs2bLJmIftUk3ZaOd6K+wp3UeQiAhBEmxTxPaCVC1eU0QMYKCiU+uFKc/8LpSc6RJZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmQwSO+sHRdOxKyssFE+1LSKcto+OwyNSMXVrYSeDQc=;
 b=iNfN7qyom2tLXPQzVB/t0Kgs9+YsCl1gtReLSDh8SwCCWhIwn9bmXdBbm0dssZgoaUIAvU+HS8vD/evJeQEuTUDKU0oxb4JheharnsuMgSDchVjgPcTTeMJMstc9E6384ThEnNfrbFbttmAxcC4cMZuC34jbL56itDPV3hRk+uI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6560.namprd10.prod.outlook.com (2603:10b6:303:226::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 19:04:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 19:04:59 +0000
Date:   Wed, 7 Dec 2022 11:04:55 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        hughd@google.com, tsahu@linux.ibm.com, jhubbard@nvidia.com,
        david@redhat.com
Subject: Re: [PATCH mm-unstable v5 08/10] mm/hugetlb: convert
 free_gigantic_page() to folios
Message-ID: <Y5Dj1yT1xmEJHXF3@monkey>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-9-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129225039.82257-9-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:303:b4::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c28be67-4ebb-4169-1d66-08dad885ef12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cgqcgmj2ycJqAGm35/mzyJWekzjMKvpZQDMI3mJ1Pyo36npde6yJJ0Z8PYrjhJgz3oQKYQZn8yYL+wiZLvg9B3O0SIWqqE/NvzjsHiTRPIXUN9FVP5HiGWQk54udkhEUDwyPfp3n3xXA0xpYFmo/1ncsJ3kqnKAxRomHKDmdVd4hJAiSB2CVWInxUwCbKko3vfZvVLlH6ICH3OTJcznX4yAsnhfor9dX/ukhZioIUMOHPCxwZQH/o6qNUaTJPsjJmex1iBjSwu/F/mNqk9R6XQa7NsVkgF4j4UYQHncbgYHDS0qaBd83XuB3W55hZ17tnIFA7xdRRSKMn2WABfCPMoKMXsY5nSmjv6qQvyUhEmNxzTAaNtc2gjogQpTj2hGasE+yngPrZKHU1v2hBbFEdMi2dBmLBwvPxgJnmLXSyVQEePDOZSL9yeAG2kPTtsaf89sastPWSrZpoyk0c2Wz+fSNSZdd+89KiMO6uAbJX2cbLXT75v1bRhXULSsGLcUvvm/7q5CB5vQibYlXkqzxXxzmRxJdZ3IaE93xzKtBcuE8iLyf1GQg2jyiWKL2Xly7d7EZRU82WKmjgjixO8KbezSkeuPgDmlMLVjROkv9iJ2F9+ykZCgyUVqNcKuCkAnBQHfclvxUEnpYoJuUdBa2Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(6666004)(83380400001)(86362001)(38100700002)(4744005)(7416002)(6862004)(8936002)(4326008)(44832011)(5660300002)(41300700001)(2906002)(33716001)(186003)(9686003)(53546011)(6512007)(6506007)(316002)(66946007)(66556008)(66476007)(8676002)(6636002)(26005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x1p5UaiBDZvsipuPnmgyCDgCTPbpbOqmDJaT9nkSRS4t7Td1lsP26NYsleAW?=
 =?us-ascii?Q?WAI1Q0XFWiPHUvefSlVCKHyso4+Z8H81fzHjTB/PJJFgpcXFIb4GwWZHzwJa?=
 =?us-ascii?Q?Pmibad7dBcRGwpxUckfTe6xBLKsyfYCXqzJ7KWnMT1xHIeWe5IzcYfh/M63V?=
 =?us-ascii?Q?cBbvCyfc7OViCEZRNZ5PzSyMxeZENwoFPOkINP5U9HVbvD+jvlWN1NonBo3C?=
 =?us-ascii?Q?gvj33uBLQps7hoPdICfG9o06HKpfKpcKTUVj7RC0iMbOocnc0q+oj31nrpj0?=
 =?us-ascii?Q?xXx95SxnNkynO9hz5iQtm/cXEOGqUSP/HlV+d0xyn3X9RLh0r90Na2RdahgS?=
 =?us-ascii?Q?/wXNi5b+lp3kQkrxz/eT3V+wJO+OcKhiGma/NOBx+sq0MqpFNYqfhP5KOb5g?=
 =?us-ascii?Q?itcIiCstLGScmlNtffbnbXGrHjoYYXwskgUlgdfhAn9fTriqGBZVllEtZKor?=
 =?us-ascii?Q?HdZKZ2G4LLc7BJ86AjPfrGDYmGKoUm1J7ryQ1HXgPpRBSRCCykLmAWORykXw?=
 =?us-ascii?Q?BXr2+oES7tMlPa3kTxrDiBI+FDKAoNuSYnigJng+zPfD1oRC9iYU/xREUZUv?=
 =?us-ascii?Q?NaKQp6BeGODrAxHVkRiJPGzXO/9y3dZwvDfIV45qd08xxxxlZebqHbJC7Kvv?=
 =?us-ascii?Q?YyuFl8KlM1yAYJDdUKll9ggPiDN9CO71Liq72S6k56DIc1f39KdCR0vW9txD?=
 =?us-ascii?Q?x2GqTA/TcP+eGqq6VBc/JlJP2ZmufoBeB16Lzafe1aiJjdPOeDH+UjnNO3rL?=
 =?us-ascii?Q?AkEAfY+hmvTm5KhnM3S8KUAqOer+p8WP6NTEdybzvw/Nj/rpP5MMbDT/13EZ?=
 =?us-ascii?Q?ViWKPhCr2C9k5VShJjdtIerdnljV0N4JESIQJZooEV/8cuV8j6pZY8709T6S?=
 =?us-ascii?Q?yWWmzK35bvZOLFmS8pON6ih6MU8OiYOE/cez+d3Yv7V/XIAgcWB1bqoUnF2C?=
 =?us-ascii?Q?V1V+YYIOZKdUu0WdBPjzrtGJoI0dKOGJb2eoToVsAZeMvnkBbXaEuSOALyBC?=
 =?us-ascii?Q?tL6HcCAxifd0LsRG6EDgv3IzTM9s/KgTx53d5GT2l5jNFvq1Xi28lccnHu3C?=
 =?us-ascii?Q?zwP3wFGI5gOGFP5azV/fGwJarBRLP3erCxNICv6M72mmus5PPdnelgR0Ehej?=
 =?us-ascii?Q?8ve7vqt9m7wBmnNV4EmD01thzzAHvMt/J56iKRSs4OmAIKH7y8yJ1TTcqa1y?=
 =?us-ascii?Q?Y6I8GL6oQ7QBWicvsy4PIGtIV5CGRsT8PebSNjaSGeUoQ9eopSGm66SkMXZy?=
 =?us-ascii?Q?enalWUQFfXkL73np5N5AQgaLzcRLFTUpH0tMzTPx7G8BIsjGPS9vgHLM20d9?=
 =?us-ascii?Q?EqnJfkONkqEqv5HnezodNwMmlr3Gb4riLOdkD/BcLi8ehNmhP2xhB5owtZsK?=
 =?us-ascii?Q?grTrbwBwWiifn4+txvz6QLjLpRtRycjgHVpc0opAuCaoediNr5PRifYQ6eKs?=
 =?us-ascii?Q?454ENFKP0T3S4vDQOf08cz83xlDRZFNxfd6O4/oyBvSvaH+LNHkkrmyDDW8N?=
 =?us-ascii?Q?5mRncGdHhUOVGlT+Lb6HIP82LweFK2fPF3qP68HAz5c3ZqBTqJmDxwC2GRwy?=
 =?us-ascii?Q?BFzba6gadapsdfNyXSr1Coes2DEt4oIC+WU1pkK/0WS33/bQA0ZbAfmBaGtz?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c28be67-4ebb-4169-1d66-08dad885ef12
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 19:04:59.6298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4G+Y9XT49noAuvBZQemmPYdlABA9kmCn+76O4CJJ28hYaJ2VuS2tpa+xUJCDwat4U8vXzkqgZ8FLAR6vWKXMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070162
X-Proofpoint-ORIG-GUID: _4u9aLFoyQ51etY7BeNqYKCUW2bEAMc0
X-Proofpoint-GUID: _4u9aLFoyQ51etY7BeNqYKCUW2bEAMc0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:50, Sidhartha Kumar wrote:
> Convert callers of free_gigantic_page() to use folios, function is then
> renamed to free_gigantic_folio().

More changes to __update_and_free_page than expected based on this
description.  However, they are all folio conversion related so ...

> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
