Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761BD6DC6D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDJMm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:42:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0B84EC7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 05:42:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33A0OoeI022540;
        Mon, 10 Apr 2023 12:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=nqItNrJ1KRp6VkvskcMY0ZCbhwWewl/NJPSufbF6zAQ=;
 b=ZPhXZV2HzzLe5ByOU9tWpqGtPaw9ufmkgCjxlg7IR0f6EmrB2b7yUIpyY2Ex8VI0oNtG
 4uHmmC5qbVEMNuN58FnaOL6ZORHxv7ENeaG5khke+vz3qVZsX8pkZ+w33aXC25BWCU8c
 lpMRBAVO5REHHPjckTfhAKrrFh9gnACBqiq9EIsVJnOuHIItr8htfr31DOozmKnua5Ow
 ky3AdF+dEQK6FVw+8SphLDzxzBuNPvqb24DOqy2U4Jb92H+jr/egT6s7YNhVSZwnWYLy
 gtSBms4RWs9oxbKj4bSXQdeDzjT5nmDuVSUSRQT3qsJ5SvH2trLQu8cNF9g6sGzPkAZ1 UA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0etjpws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 12:41:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33ACPWLe038107;
        Mon, 10 Apr 2023 12:41:49 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puwbk42rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 12:41:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6Co7S9JR0ozf61KCKUJDLUrVIhMXx+Xfy0TlH5N8T+Fzbaztwzs+bqGckBFYruRSxMrDonZZVyBkEsNUeWzm9YSaqGH2nh55FIlbSK6WeQ91L+gRUVJf47SR4XVufKdXpM58LEHIusuoo7mx+V3giDWm9xtQtkDImJkl0mSqqaMj5lzIQxe4cXEh7V6OGqveUaawW7lz+XDy6/I9UjqNglR46yTCBFRv8XY9g3mGEiI2ONRdP5qQVIt8QhZmcExBk3SjiQ6LCqJh9QdaX+oocbDGcIRs7fEEGM7QYAo1ZZapaxN1w1Yl4g4nJKqDQIYhdp9wlwoXVqp+31cbds7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqItNrJ1KRp6VkvskcMY0ZCbhwWewl/NJPSufbF6zAQ=;
 b=mUujbxDEU4FAPidOEhXBDL2QLT6Vna+GR/9pphabI5EYr0FXbiZcrkse9v7x+WYY7Ru6gfYS/BIpssv8TFCSu2D6TYqcqV0na7YZjT+suwmDy1X7sY4ahqP+a1n11QXoI/snzLrg4zDYwfZhtofrPa03P3TaQVJ69uth1t2sKQGrKoz41EhkZpuQSgVqG/1BPjYepIECkbmiSySVvw1dxsz0y6UXYFASzFnIVLG6am8LYGrqz5qmNUH6lXkWMhSc7Cbh/VCFA+m28a5w2WHwKaIOw5tw/TPw6Ohy6/O5qPAFlU7HzigDNmTmgxd8AWi9TnLJljgDOqN/cNSiF7KO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqItNrJ1KRp6VkvskcMY0ZCbhwWewl/NJPSufbF6zAQ=;
 b=HWR8kghNNoYujr2MFjtZwdzTQqjY0sQvrgPqHE4QHrfFnogk448NmfTr6im6GEk1Ygdi9VAYwePNlC4aZHpdVVUfqm8xMvSQXmiJpdp7jURQzx5fr8IyAIkUvV7YA5pXOfCI7VjBl+fGktt/0UIS79DDTk30J+RH7ovcE/vMPDE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7454.namprd10.prod.outlook.com (2603:10b6:8:163::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 12:41:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6277.035; Mon, 10 Apr 2023
 12:41:47 +0000
Date:   Mon, 10 Apr 2023 08:41:44 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/2] maple_tree: Add a test case to check maple_alloc
Message-ID: <20230410124144.ouhhnmfoipkqtveu@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230407040718.99064-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407040718.99064-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e611a81-ba47-4371-c7d6-08db39c0f2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8RHERJu8S6GsuCXQNOYQSabj0Q/sNiRGBdEd9Er08aFUCKhPXP4U5D2ywHzHZUKEBdH/FI6mObzfddj4ESv4kx2vvOdsAfQiISgkUCN+RzuWkiNtCUF4F8zG03v0SvEJC7iMTtxdT+B2lSaJxKwkXnT8PSLL+7GoJ7l6NfqB12DMo7CbPTQD9LOr3lGWA4XFSE7Gc+1/4pSaCd+XNnOuk/R4U/pXaYM1xRHfKx83/W1fmDbfi/G/CyYkSCOuUV7mKsF2jp+JDC34Q3pZRNvhuNv+qGbpGbsSYP4pBMIuTqqZPBa8BkUojKTyAo+aa+W4LwH4B/avSqRaR0r9yG/gJvAIcMgtBpAIXWt8ro9qClExvxRFwn4VG0kdYLu219az48w2HtnBWHECbpuEGK6SqwGBhUkstKGiX45hPYdMoKTuVnPqWI4mdT8TuCWc+npaWXfF6RynWezUy1GY+439yVMlRrPfEGuJ5drGpdWLO/8hW2f5wuJqM1jQxTBznsEbw6USdeAW0dORmQCbsnt0ZwXdtAEWqe3pWidMVGUyxeemQUNx65/cnA6K4fDoQVS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199021)(478600001)(316002)(9686003)(6512007)(6506007)(26005)(1076003)(186003)(6486002)(6666004)(2906002)(3716004)(66556008)(33716001)(4326008)(66946007)(41300700001)(8936002)(6916009)(5660300002)(66476007)(8676002)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8/Iluy1Sy19+tz21grBuBH9NIcgVV1wo0KKbviZ+zZA3hwlG8JyqQbWR3wRh?=
 =?us-ascii?Q?l5J644jg+9BbD9GsLbl400w9uVHU3B9kPbO0g7Ow4Z4phYzITuQi9ZXQ/tkS?=
 =?us-ascii?Q?QFNot/G+/Wfvaq+4aqEJOQfFedYa3rE3dfYr4AyYQXZf/XOFGX+i69kLS0EP?=
 =?us-ascii?Q?0HOREFyuaT4pApy0IovU+JGUaWRO2ctcOA9fb+7SCbJpHuRjaHGKY+dLP1Ov?=
 =?us-ascii?Q?0/aC/lUiQ9MZExowaqQypxPMfd0NyvefTQp9Zk/hIBUYYJipuFwGctVBbwtY?=
 =?us-ascii?Q?LALJbgI0VpwfxttXixvs59BgQ6w/kNil7Bru5EmW/zdNeGkWBo1abDittt5a?=
 =?us-ascii?Q?iEwsbEgvfzKMxBwh3l5XqNM8LL074Kijdlcg672UdmowV9G9PPMb32Fc07Yn?=
 =?us-ascii?Q?gjDQZHJS1QPxqeGTgUfZGpb0nE4Z3h1TUEo2hYuhs65nezdWithjunbBU+c4?=
 =?us-ascii?Q?8CxNGtVgMbKH5NlzeV6KEgLW+yGpeIhCFCXC2Q3HVhsRjuvD8+dKRDJRLtIe?=
 =?us-ascii?Q?mX6SQMrwTIEo88sQNbN6z4qvhlBLZ/G89KfilzfcCBf/9fVFQ0u2yR3ALGyf?=
 =?us-ascii?Q?RWvlSoF3JGeUZ7lpCGYCxgoao82Gjm2UfvSuBY/mrGu/Xp1nwWwAFNbg83Yb?=
 =?us-ascii?Q?jUhZJ1X/vRyHTuF0emEfftx8udnCwGK4Xvm7Zxp2jBeemEaS/aCMmTcGhKKL?=
 =?us-ascii?Q?GpJDjvhrMZy5m3ZQk9SJl2jnyy2vKqayhr1s68x6WBWIK1QEvuplvV65FKMA?=
 =?us-ascii?Q?9F7A8xAw200HKjXLWXcRVR7JlaBnMQmUI6qg8Npvm1E8fF+k+UJcR0h8x4Jc?=
 =?us-ascii?Q?IFHEM2r312BubNrrK/Ns8zjnejoUKRs3FuR0YZfFXAqbjzCvdAP+SnWw6a4v?=
 =?us-ascii?Q?tpyPcesLmr4JHKq0CY2QVHP5JS3TRPk8UubGWUTXL3G5mRLfd2XTXhKWqk0w?=
 =?us-ascii?Q?AdmYzril/UtJVPVhappug8YtI0bwTakKMES93J8egb1iX+sQ1qT+00jKVi+x?=
 =?us-ascii?Q?4epbQhlBFl6FmpPFQfGbusxMY+v4j6ZCXYOteJViCWpSYZ8S4G/EZh5PKCKN?=
 =?us-ascii?Q?jmde8AzLMak0Efu3z8wjxcPXoMB7m4VLWbD85ip5D1uUlJ2EJE8AJj+V+Lld?=
 =?us-ascii?Q?umBdWJMVPwYQnxOayTgheiFnTSVKWDMXgswB8MX9UciQuQRj4Vt2AKfnWQ0q?=
 =?us-ascii?Q?+L/LtGioxRzObYuqyWo83KU19JyP+vjds0Kg62+jmI/u3NgIetQ5mizUGFc3?=
 =?us-ascii?Q?2qPVQclbwJA5P7LVoG+pdFYavslP98ktJ/Q07rC8EHqza+fnk0UlYnMVXYNw?=
 =?us-ascii?Q?BMm2OEubLS4V7Aj2MMgmjaEr9LDAPaD1DvmIq3h8KbALDUdWkcIShZ719qSQ?=
 =?us-ascii?Q?RHkXznFK50QG11ND3g0nLp69P/NqDzpAhOcTn4muDxqKLkQB/A1EAA8LIUko?=
 =?us-ascii?Q?zbgBeo5bG40aSRHUdRPOJ5R5x3jol3VoIyva9E9dRGDBA1dXFfuErQcShUwf?=
 =?us-ascii?Q?M3VytiiQZwqOoQPqVC3+mSkncLGaulZqQNZunZKBwq9eiMFxfxh0+7w/7uIw?=
 =?us-ascii?Q?F8GEcAYm/CYgDq6xR6nN1qpuPD2f1vysj2SGI1p9YBSwsLko2kf10+c+cXNo?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VLu/vy5NEnA2OVM1Xp+VKYphVKzW2BXLZ1CiUbgO5FBch1xVhwM+p3MBpTug?=
 =?us-ascii?Q?5AxMX6xfhij2PDyyJ6Gbb0jCVnXf1Yd8jhj6wXQMWEHavVXjvWAy2vAR+KJj?=
 =?us-ascii?Q?kvSAB5CaNq35YiYrHRfPX7tPO6IjgMZglbixOXUekufAbbLdzRcmPyohH42e?=
 =?us-ascii?Q?FwxskUiKOZJTskWQYkqSLFHWN98HutdiKw7CnRjeTEFGU/YBxsxq8m0QqTPe?=
 =?us-ascii?Q?PTeP7zSFMQdLpOew1whvn0IQK1DeHdvDIwr/XYTdCrGnlxatGoMlzumR7XEq?=
 =?us-ascii?Q?DEBFezKJPMGkl9GekstzZwBD1OYOSkCQbJn5opS5EVtIxDEOxNPAmGsiAEpF?=
 =?us-ascii?Q?16oxscIFZ1Gh/NFoFiTArQGlnx4WepwK7+gXXaMtVKT3OThH0nqyt9KV7wn4?=
 =?us-ascii?Q?GRO300IMhMhQ8CO4uMnMFerKkorehcaA/rPsEJ4AJtDuxnOYqL36CDYO6aaH?=
 =?us-ascii?Q?LBJ5re6/YkYTz8MWhdt7Ti5rA89l2BfD57Asp6mqcn/18mA5CsaTMEdeJ3D+?=
 =?us-ascii?Q?tXAfngwNmEDDwam6MiIyPHlODRIXGXEbHrA69nA5qeOvC0c9KmDRWDCRizAT?=
 =?us-ascii?Q?aO7alLM8tZa/DYzpKQ7KUQDfgFw12utiRk2MuOSPJrKnaXov/mTO/mV9GvSU?=
 =?us-ascii?Q?ZcucYY+ILcHIY1zSFwcdHPWIlXV1BcSDxQowyLpOlqwGGCjqA7eyAdScGWi5?=
 =?us-ascii?Q?kHebt5wt/MxmmWh9eHJ9QX45t4NsgJCN7975NDAlLsQ9wyEWImUXbc5WjEae?=
 =?us-ascii?Q?RIy34Ysv50jWlgQAKcFhnpW3elEziLZzB0Nsp1jvRgpw8fA6RnyXuBoiKlks?=
 =?us-ascii?Q?WJeWGJ5Uepmh+S4iWGlk5dZxHVDA3LEqCJT2zj7oS2HEub+7q4z9qtcGx7Zr?=
 =?us-ascii?Q?MKPZgSSIhplD3s21V0kzLdVCkReI6TVilwpzoXYEuJpn/ZuUtCz2V2XTi8hv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e611a81-ba47-4371-c7d6-08db39c0f2cc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 12:41:47.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AC8lO+0OZQUMeBN2+uOxH0DCzDzbbbIip0LHATtG4wVhGdI7Z6+thBBytvM9UDENAPju2La++1+IyKjHuNccyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_08,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=853 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100106
X-Proofpoint-GUID: R-xK04NnQGRExH-stAKxvXo35LxAM32s
X-Proofpoint-ORIG-GUID: R-xK04NnQGRExH-stAKxvXo35LxAM32s
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230407 00:09]:
> Add a test case to check whether the number of maple_alloc structures is
> actually equal to mas->alloc->total.

Thanks for the test case.  Can you please send the code to fix the issue
first in the future?  This way the verification code can be used to
bisect any issues.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  tools/testing/radix-tree/maple.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index 958ee9bdb316..26389e0dcfff 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -55,6 +55,28 @@ struct rcu_reader_struct {
>  	struct rcu_test_struct2 *test;
>  };
>  
> +static int get_alloc_node_count(struct ma_state *mas)
> +{
> +	int count = 1;
> +	struct maple_alloc *node = mas->alloc;
> +
> +	if (!node || ((unsigned long)node & 0x1))
> +		return 0;
> +	while (node->node_count) {
> +		count += node->node_count;
> +		node = node->slot[0];
> +	}
> +	return count;
> +}
> +
> +static void check_mas_alloc_node_count(struct ma_state *mas)
> +{
> +	mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 1, GFP_KERNEL);
> +	mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 3, GFP_KERNEL);
> +	MT_BUG_ON(mas->tree, get_alloc_node_count(mas) != mas->alloc->total);
> +	mas_destroy(mas);
> +}
> +
>  /*
>   * check_new_node() - Check the creation of new nodes and error path
>   * verification.
> @@ -69,6 +91,8 @@ static noinline void check_new_node(struct maple_tree *mt)
>  
>  	MA_STATE(mas, mt, 0, 0);
>  
> +	check_mas_alloc_node_count(&mas);
> +
>  	/* Try allocating 3 nodes */
>  	mtree_lock(mt);
>  	mt_set_non_kernel(0);
> -- 
> 2.20.1
> 
