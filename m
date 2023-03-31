Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A60D6D27C1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjCaSYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjCaSYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:24:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783591BF49
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 11:24:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VHNxPi021401;
        Fri, 31 Mar 2023 18:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=iderfUjaSCln/Qj9f0pHYHO0DLRynzuHyzu1YKfDaj0=;
 b=0WISZ8dgnmmnEMLNWVz9/FuzDjfVpuoxauD/Evo0uWwZIz0AAN71GlbrsBOpHqaAoLfF
 xsE66bsx2qdaSyP7t7j6/ah1Av6frAGkp7lh7OuJgczX2gqse8FRPDZsrZvElKW1FCNx
 FCPauyXGL1vz+W9pJPrgkhOVUyMbWnM8X2QP+BjD/tO5Yvbw+ycWzDIOLU0QCi5rxdsa
 p7yewSExPZK68mdxe3CCbruUWpcguCzEIRUmoANPox66o7ySmzF9E6AXPYDjVzO1cJXb
 36mhq2zwRXp66MqSZKIGoNGfPHNfMA12zfFvkIInLVpm353tEdblrv2g5yLz7wksdqGY UQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmq79eq1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Mar 2023 18:24:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32VHiuHW024005;
        Fri, 31 Mar 2023 18:24:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdj0qyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Mar 2023 18:24:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHzAAMPjZ0iuaeq/Fsw8/ORm7+qoSnKM7bygLOXUquOZWFywCwEMl61DBDgkdPWzL0AzkwbMJIWdp37sR5mCJmN/BtDmIqZMVisvdNi+Se7VKU6tGoPjdABIL1dh7w2uGAEF5K/J3xLdI4NyzZDJkhnwx71gyEGqMlJsmi8bGXRqThP55oDN5O8fRq6LtWqoK1rX3qDqCD9ZzWdPJdRIN5lRmQtCwUucidNrFKDdfFRI7C+6DO+tZUo3BiKdHayO8P1nYrdQx2kEKEGIoQT1GaPlooO2F30cBf9DG1/AnW4zUZclt7ZVPYbbHy0ZFfuYcRnkcNkn9bMDBUjGrSMGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iderfUjaSCln/Qj9f0pHYHO0DLRynzuHyzu1YKfDaj0=;
 b=dKPI6F/rfsInoLnwwi/UndgFxvR9dAfdtnpLNj+Kl2mMJ6/d9uFklmKWAUGfXESU479GGF8i8M0jmXAVqCwBVfCBQ/133KbLIexAzkD8AM7GsNy6dvqGLd8W40rnDVJxy51WyDsDUNBRViYwZxWikjJGdBc+Ymkjqoaw5KvLeANWFqQDD9TGf/kYOvglRnBLGGdaoRJ3UDxBdfBMe+wvBHP2ZbnHQO++ODekQb7mOBoRG69UECX5myOtsLpJwkumtlqNKY317rJxkLg31IPTIQAet7/S0DZufApF6Pj6PX5TqTc/wuF5loXbH0W9sW/qN8uFFULl6AVs+tJb6yC+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iderfUjaSCln/Qj9f0pHYHO0DLRynzuHyzu1YKfDaj0=;
 b=x7uwPFVWCGt93dKHN9N/W6RxNQlkqAD5U5vRDtUP+oYfy5TPbIp4q625OlbLxkOiLd7IS72uoKpX6B0FhbEYlvq6h+nyPDA3X9c83CJ3T2FosvDxeai/4Dm+hXxkRtYcsozjr50HG8YdzRYvdQt4QU21mNs9YKdEDty309gxVHQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6218.namprd10.prod.outlook.com (2603:10b6:208:3a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 18:24:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%9]) with mapi id 15.20.6254.023; Fri, 31 Mar 2023
 18:24:11 +0000
Date:   Fri, 31 Mar 2023 11:24:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 08/29] selftests/mm: Use PM_* macros in vm_utils.h
Message-ID: <20230331182408.GB12460@monkey>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160708.3106977-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160708.3106977-1-peterx@redhat.com>
X-ClientProxiedBy: MW4PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:303:dc::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a884c2b-cb62-4c71-c9ad-08db32151f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UlZpHGmHFtgC26Jc1ZekqSSPEqcnRKCXzRSRF8gbyv9cgp5Phu9Afzvh3VLevodN5nPMwmriXqqaHwzgmIXmYbzrf9CywPjlb1I7/MRWqgFGo8X2fJMBVGvp8PWQRoU6HhknuFx7ACyN578FUczy4gvJw2pBWod2BUbMnPC/gyeNaIvEpFnApsWgcAlMedQKTSKMCsA9OZVCEwf/6DuYzwLoWAUC2leareraiXxvmtOwihnXjJcUxhrnU0hIjxZvDRffDKTsARObw9YGwHeXy5ZJaEIVyoOp/1VQ0rlYs1bzyq9SvfWnfvriiVpR2RsDK3uX9Aqgk1GBv04bFm9EXyf5eYjaEd4z+HK1pUUcwzEq2X6Gd7cLUjbd8hp3fLi4SjOAYyfjO1a/bbH/vWVNU1XAzrZbgbsqv64A7qVg+kmorQRLemLOqkVHPOCMb/xzTIDVisykWinTmwEDRBv4cjZx5teLQakYZKkAyY29VQizOFeHrAMivxD4j3zcHfG6yL91CVo3u6Zni1uVMpIB9Z0ypWnU17sKpmbOGWAk6NAnrPN87gr+ilZcgnffa9b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199021)(33716001)(33656002)(186003)(9686003)(1076003)(26005)(53546011)(6512007)(6506007)(41300700001)(6486002)(44832011)(4744005)(7416002)(8936002)(66476007)(4326008)(38100700002)(5660300002)(54906003)(478600001)(316002)(66946007)(8676002)(66556008)(6916009)(86362001)(6666004)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cU97ZakMG7v2FqtFmWFVeWMlGjivCi2+B0VGbzSTC9Hj5JR/7hvHveBW1Pzz?=
 =?us-ascii?Q?7zKV98eEm1vvjJLoXu22AwCwetTIA1f5hUwk/JAPFupceH1Hrt+Lvbs0yWoi?=
 =?us-ascii?Q?Eh0tl7SL8XG26Szu2hYzaLbf540PfPl6w9f0bajfBvhI8t/nt1R2x+1+umQH?=
 =?us-ascii?Q?182oxnNmWxjngmLmk+XXbwGpnEHNbJxw09lqk1QWLsy4LPS9dkeuMg4pQatD?=
 =?us-ascii?Q?bzPVwcYu9cHGMMoZi19kIzMeUT6jko9QDbilVKZUOepqcDN5ahtzni8tzbYx?=
 =?us-ascii?Q?b2OGvC2zM3QNR2KbO3NBjSd1q/RuE5QE6IrSHFt6bDzTWX9xd6jiIW1IiFdz?=
 =?us-ascii?Q?ab5GuoJq0jBxq+fft9TvlRnNR7eKRFkqeV7rTtRnzFQOXuc4kyQsYv1US8WE?=
 =?us-ascii?Q?JbiyTPLsWaQ0KcZQoVeEk+km2Mb892976JKwyKCWpdcavJQLez74bypASQtd?=
 =?us-ascii?Q?ox9ArZaCZ83NKhqPbuh64dQNEvKaKkLfMNj+PnqrGt7UPMZKtjOfeh0k2R82?=
 =?us-ascii?Q?SRavO2Psvp5rX5/KJ5mTXLwU7kZa8BnwPyWJaE+uk7brU90qv8kylNMNLIXl?=
 =?us-ascii?Q?8Bw9fevz1rt3KAvfP175Rw0oX+cJznysQ4pKQ8VK05rjuwYcBR36+s38s6fo?=
 =?us-ascii?Q?xNSyUJ5K7UnLUnT8BmJyPez/0cp4Ac733FhAy9T8Utc9/jHJLE5IxUxJ+4AL?=
 =?us-ascii?Q?uJzCE9EbAdQZ2hDWxVpHH3qsn29Kz9AO2ogwbCQD7wJOPGUZV6+oV1UivIwE?=
 =?us-ascii?Q?UMprSJkBj456qnsu9ojdJy7cwy5TafS/ARnC/tHCg74/CmX5GoU7JOiuNoRy?=
 =?us-ascii?Q?mJK05ETIsK2eCamqvDtO8/+2lyxKK6zUw+sDqbjCDu+5h/8fO4kYB8GT5f3C?=
 =?us-ascii?Q?I4HRCFCvueugH3z5/0/2ELw/vaVdjdHTgDIHAi2g+sjg64xoJ+Bzo2rhYXvO?=
 =?us-ascii?Q?gU84pE4YYLgsSMTAPdKcMp4T8f22wT41Zwexa2S7ThjoxkC1owb/IaVXLUCW?=
 =?us-ascii?Q?eIL98JsBGsvjoR1eZuYDuBkgaQGQGzoqsVPDRVPamzZ8/VY496TIu3oXaiFI?=
 =?us-ascii?Q?bfs7b1McNxDuA0HhyKirD+UalLB1x88SDWliKq/tLugGjEYwH5cmwK3+kpX6?=
 =?us-ascii?Q?tIYwnn/ruL3foklk5kaSsFvKQpdYbJmxmymJvxvnXcWRNGKPlyOcIDeExWiC?=
 =?us-ascii?Q?/Kj97wKJ+FuoaK/DrlGtyrMzME+SXoItSe30GIYe8cS1HYxIjVEr+1cnT6eL?=
 =?us-ascii?Q?aAXsSyhqq+sutC5UNZWLwhTllksMM4tMeOXUZh4Z+ZlPfaKdYXUPymqcfn5J?=
 =?us-ascii?Q?nzKtIyrCCQP165HZqtu6t35AxbLXZOS5P9aWBuHqiLq7JZNYIXSTRP2Kzzyx?=
 =?us-ascii?Q?vO3rUp7NCqFygZUX2Q0pb/sS8Vk1zSXZcOKWy73/vfxlj+g31VYefywIxhTB?=
 =?us-ascii?Q?nf+KfZK4XBlUzuGtXkTL930g41u0P3aC608Cy6aqg8WT8WhlXinFVd4kyAlX?=
 =?us-ascii?Q?VxgVdwUxAmNOyLL72amStneDfc3R4yVd+assYQlLgHY1S/HiH4BRYTdM5rVr?=
 =?us-ascii?Q?42W4ulCRe6Pzk3+g7Th+ArCiByM+tKog1rXlyCuGYlcT7HMCG0LWKfBhER8p?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PIWsS5jP5w99aWSl1Ecrg5Sp/3OYrwP9xzWVCl/+0DcJ998Lfcr+zZzTgwXS?=
 =?us-ascii?Q?cltQ9EOL1HKstjNMEMp7fDQxaF8clMrNXs/v61D20zDAFEYMWnfEhzZVzVjm?=
 =?us-ascii?Q?mbo2Fqq3bxXntBXmrYnv9p69TOvx1Ev1Aj7RdJOIRjQzSDiUxL0MOEEOvn6s?=
 =?us-ascii?Q?JVDzsybJBT53INd7BRXVi0sqK8Br94nVIQQScOfOjf2bMZshG5o3tuhzeZEs?=
 =?us-ascii?Q?2W7utTrCYGH44gIX8C6P7PqBcrM1Z3Q015osX6APJA6fUTY08FKHL9DY9BFs?=
 =?us-ascii?Q?s6MMnuq6RN++mT21XnjvwMVe9L/v5NQQcjM2lqnBKXJiqswxie00ruKMpG9t?=
 =?us-ascii?Q?AiQj7X7i2lv/48i5lK95pBiryo+Ur8nUxooK+QJbdA/psRYtW2Rmqn5+AwXZ?=
 =?us-ascii?Q?Wu8Jr1nJ7QAv52SrUbZSaXZ9hWtybiXObbs5CLO7ktiQ/1HF6dVIF/v6i+cf?=
 =?us-ascii?Q?MOS4yKt6F3bHos5TjPazMTsr1ZVAIXI+h1dui0an/KTY95/x3pk2ZtClZX76?=
 =?us-ascii?Q?riKtYmOlDTXm9OnpA6kvaSJ75Tw8Vf5yosKIRReI9VbYRkICer2hgqT3CK8f?=
 =?us-ascii?Q?+WeAhQ+NXdMMg3uWAH0zdMsaEq/tNYhH6ZpVK7hR7umxqGxOjmcQlPV/cIme?=
 =?us-ascii?Q?fquu9T9VPAsdsc+Xk/bRGf7t+RdZPU1lEiSYfw9f6UgNImRP7S1H2Huughgd?=
 =?us-ascii?Q?ka86OGqV3kjLW3CsXCHV7FAcWqeKNnYwht6RkjCCFcK2FI5CnswvipkAe0iL?=
 =?us-ascii?Q?5jamm+qfIvDe0isKiBbFgLn3GlcOSpCxIGW/7zmshSUfQjVimMbdyITdUZo7?=
 =?us-ascii?Q?h3SGEQWlw5ByFNNDw+RHw4RUOZoHOHKeHbRroocu+H/6eLctTMdudBzXiq+d?=
 =?us-ascii?Q?FzuAGS6zsEMd0Ar4pkOsMKpillPUN8DAn1Cdbl7VP64ZDaDm4Ux7DDd1Ikw0?=
 =?us-ascii?Q?NY9/wRWFBkolDWizFbrANnisLaB7YjfCW5Px4RDvTzQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a884c2b-cb62-4c71-c9ad-08db32151f9b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 18:24:11.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1DJq5jO2G/pXfOtAjymLtWZLfyl2hQs2FTS/mwFgaNfe0y3t/mHXstk0Bpoj0LzIuV//F9mxnknI4VoF7oEtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303310148
X-Proofpoint-ORIG-GUID: 2sBDo4IbtCvq298NxcInOiMY2plgrh9j
X-Proofpoint-GUID: 2sBDo4IbtCvq298NxcInOiMY2plgrh9j
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30/23 12:07, Peter Xu wrote:
> We've got the macros in uffd-stress.c, move it over and use it in
> vm_util.h.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/mm/userfaultfd.c |  8 --------
>  tools/testing/selftests/mm/vm_util.c     | 16 ++++------------
>  tools/testing/selftests/mm/vm_util.h     |  8 ++++++++
>  3 files changed, 12 insertions(+), 20 deletions(-)

Nice, thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
