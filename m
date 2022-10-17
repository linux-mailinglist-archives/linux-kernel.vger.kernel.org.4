Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3674E601A84
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJQUoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiJQUns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:43:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895E7816BD;
        Mon, 17 Oct 2022 13:41:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HKXK16028490;
        Mon, 17 Oct 2022 20:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=RXLQ7pXypaIg62Udiavwi5Q5Xpjoo0H0lZQcirtVXKM=;
 b=nZwtmrgtJrwG/evxNEF8gk8hqjEqhP/DVUkPtQmF5DwIujsLnKHwhSF/sdEUxomQY7j5
 yybjNWDWcLztzOp+JESpSHXxcxbFttm8h0q9z/OygrJsFoWI0mVdbVBskih4ghGq7FT+
 +/Oke+WlTQ7Ka1FYKMloEyTWcRkeoKFB1KmEvL5FGAjbBKSR7XEAdSUAytIb+9iC7QLL
 qRwLJ3Xrm1iAv3z2B7BkRkjN22IMwdISrQPU2AB9GHeAOiFcqkayYL1ieefQYr7maFAs
 VlS8NK+tNUZbsocEl1IX3TUGHbO2BenDQ7YbtaHbe4910tQ+vpJ47g8qd+7Il/aULRA9 ig== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3cpy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 20:40:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HK3xKj017394;
        Mon, 17 Oct 2022 20:40:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu6fetm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 20:40:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOa3Y3Q/1siq1Lc4uNkVoz5gL7Kj78CiYc0B3SUegQ7nChRo9VAsgmWSzRLadIOak/T4uz3SrsS3vrUMVQPD3gJr0o7eKKh7uG2kfu9+NePEidbZWrM4U4ADRZj9WeQjqdY4LT3kuJ3hD7WDu79950nza/veUiXdtCJjZ92A8A/b2cTOxUihU3LdfSsua0rWqaGoO95PyXUU2/sycEscisvb/kxYua/mfcc/RpBo3k7C3cBVq5WS99CgSumLXbxPGKh6uey1zXnQPNvE41wtkZMlw9WTwFLGdlr4hf6U23aTHUUAoXwUBE1vGFpS69/q1lXegGVwdjJHKUIWtfNUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXLQ7pXypaIg62Udiavwi5Q5Xpjoo0H0lZQcirtVXKM=;
 b=SZjG06w7KYk4Bi7ShvsZVvwqhHeHCSMpoaSYmTCKhQ9NMTQZuQzoYE7+/N0FrDc5A3fA6pH2rLlS9+RYisr7IKXF4QoEPlImrEtWVKB49s0s14mluKyR/U+uLA0FLfC5oe7yyFc6DP2xFXnqEpkY0QTeUAVAPbtgnlGDMZgHpbJ+9ZDNxgPYiQFDKoGSP429U6xTYskFr0DPVZhTziPDJPvbD+1MC+br3QY21l/vQLvrTUxHzlYgJUiHkuRfrplvkyNxoog2QTHM1NO0vHSfCMcrRdNCdt4pMhWxC2lEoMgRmMUMmyDXzWvIMSxojGRFGjDemhZtkveLx/VbfQ/3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXLQ7pXypaIg62Udiavwi5Q5Xpjoo0H0lZQcirtVXKM=;
 b=bNT++TxLHLl6+L2bVxb4RzOKZscF983/jGPnYW0idxJuv3osbPqyS9FoI53Kj3BOCBXA1DpsB4BnD6vGVkTyi1LizlvCQ30rmPCetPRmYb59OlFcxY2U8Pwix7uF2kAOSyK9CYftMzs2o6uXE+8fAy9uOAKS59nrNADw3RywbaE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB6603.namprd10.prod.outlook.com (2603:10b6:510:207::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 20:40:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7%4]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 20:40:34 +0000
Date:   Mon, 17 Oct 2022 13:40:32 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Observed memory leak in hugetlb_reserve_pages
Message-ID: <Y029wEbf5/AwxGPy@monkey>
References: <CAKXUXMxf7OiCwbxib7MwfR4M1b5+b3cNTU7n5NV9Zm4967=FPQ@mail.gmail.com>
 <Y02TIcPTBcQPmk5J@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y02TIcPTBcQPmk5J@monkey>
X-ClientProxiedBy: MW4PR04CA0264.namprd04.prod.outlook.com
 (2603:10b6:303:88::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 82621f94-a81b-4f2c-9d3b-08dab07fd749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+0Snkb0XWAXYCbL+h1yMrgl2iUBqI9PTNlLb00BgFHM52pCw1QyM3jQSIBitvu0AjmlW6Dvinu2F+ZQucXMMEo2UDAQFNPgxvEptsCP60ZR+TexT7shnND4WrWT5/qKNl+CHZ0wbVLhjrArxRZC7VYNGBkLER1XksW4o5lOXV854ih/0JYokDYIg2KppdyQUWNOTI0ZRnfzXmvBJ9W+qXwIzzWiQkNTO6H2VVQzxGMRWKYzv1oS/ELK6hbPf8AYurU1Y94clJcs78oroKhAUicjUtffTAmDlW5dGCjHhGyt5XAHiMWIGrvQ0z2zgNx0UN7yktmef4A1lIivfOjXrvbvx7uF0b6YjGTYAYFMU3520Oz+t3x0MX1LoQUWFmtAScAograRH+WMBpyVAqq4Wtzg7SjNpthSthAOJrYlZN9aUcNAY6/jATZlOhlF5ArR0EBQ5LNxVWbht60uZsq57vGC+yzfKOnr1pQ4Y7yBIWCW28s8DMjjsp2zzoIl+1CT9rvldG27VJxY2u6icSoPdTpV2eERHAI4iwTLj8PuhpU/HNHbUKzpltElvdT+QAtDwwL1pEf9RCriQ4+PlprxidOZKKPgZmqmRY6Omj2Uay3GQkajBvHUP7m4DQeFAKQeESu8X+/0JWbJXZSNfU0JdYe0xcKcWl5cWBKglZROG33B4pVsdCrv7EzlcM3BdYK5+q2FPWkHgutjd1Hu/5DOneNZfqwWBD4VlAI2R3DakQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199015)(33716001)(86362001)(38100700002)(83380400001)(66946007)(66476007)(6916009)(316002)(54906003)(44832011)(6486002)(5660300002)(966005)(2906002)(186003)(8936002)(6506007)(53546011)(4326008)(8676002)(478600001)(9686003)(66556008)(41300700001)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W33MoQO1et+At1b17HNztjamtp85dVKQdmOKkTJJju6kAkLcdx88qmsQXHZs?=
 =?us-ascii?Q?+mavZvbxFFYxdJ9ngeGLxhapYT6GdnKhJtxtKKTNsIIds2iYnY5ae6p9yQg8?=
 =?us-ascii?Q?PHBtZZ06e9jnaZjsd1/oOWu9j737nqUeRAWK+lGfEnLb0bKaua7H23NVZVFz?=
 =?us-ascii?Q?UMRDiBINwVoGsKnnIvNq5jMQ5gMTKEPObddjTdJuul7yapE07yGn2xUzH94P?=
 =?us-ascii?Q?gqHGrYx4GoUw5h2jaZaloRYPO0JaCKhJLYNB7gE99lT1Z8ml2rGjddWDEGW1?=
 =?us-ascii?Q?uN/ho1VV6/Vmd6zW9vB/U/cuNF2jQfjN5PMJ1HvkP92ok3OBmSnsP+zhMIDt?=
 =?us-ascii?Q?kxad40YH0OY2clQ5FiMYYTt4ubWdvW6LJmfZT5k2LsRzpRsxvPavzFemaCkx?=
 =?us-ascii?Q?HVggpFW11GvIXla+IK7oIT8/P6LfDvX8400HxRcEy8KPAzuCpK2Ynajq6zir?=
 =?us-ascii?Q?QJNMsA6FMRFFimHf67LA5BtCHHVottz9DkalMdY7RKh/Bh2rKzFbMtpXap/m?=
 =?us-ascii?Q?6RgUdZdwUuMYRAbWnTwNU0YdP/BB4WmmA3g93mSJf6cHuY4FV49f3iZqHVAX?=
 =?us-ascii?Q?tjaszEDMXbYARgLlQ7/2CYHPAKDeGiFS+DL8j0B65H2iwhtKgQUXgZY31lgW?=
 =?us-ascii?Q?clPx4+Ga+6cLPsL4IkpQ4T4cBdzsgbqBge9gyDdFKZnQKPG9KjPDtWMvVAS7?=
 =?us-ascii?Q?nCxY1AeStDQMdH0kAhniQnhq417gvXoFlxR3gB57yZVIJJd2ayymg1rsDQAo?=
 =?us-ascii?Q?mxcHy/AUuc6v4N2vW3zvf9Otwy9IdX2LrdP/tk4y1LW4y8pfKkMk3ZZx18lh?=
 =?us-ascii?Q?SNUdJnF7Z/8QaX577nx+NX0VoLhZLqKz++JW+0F5ukezWU0mHacg3xYTlG7Z?=
 =?us-ascii?Q?plYg09dOrT3ABSyw6g8dBdxqUnK9Ay1yRSmWKRoIF2xK1zxlASE7GKmvAa97?=
 =?us-ascii?Q?M3vfeVXrYCI/tedqvjQ433k9ckb8Ars+dCR2BQhiWEFOOWqwqKtk50lS7iom?=
 =?us-ascii?Q?YNGxMBtwu/pU3ZI9OyJ0ygoPu8bjlQo69fdUcr/VkDMq462TA8E11Yiej4W6?=
 =?us-ascii?Q?7KuXVNOOaZ4GBXd3rku9cHbeXXZe/hWvt4/81/eTuNUd00mZbUT6LDVut+3B?=
 =?us-ascii?Q?Iyil+YHbr7vTLUQRAs51HqjqR2nwNZst2hflPdG8KhlmUZ9j0P8MzR9sqOQd?=
 =?us-ascii?Q?VOFCyYd28llhE/1L3FS8yc5roPyWvGX23dgODfq3d1yZP0UA3SMue8n1XnOc?=
 =?us-ascii?Q?pzV4UOxjK/rTsbufiNeZnVcn9ulweZlwvohr/K5QzdMVFHJ1vEyp6m9ozFV6?=
 =?us-ascii?Q?1pOa6J5BdH3Dw0KZUZxuDIA1IJ81l6/DMY2lvgBFs6bLe9px14n2JHXoOaHX?=
 =?us-ascii?Q?tjKkUmls9QWqx78y0nwn6dYKmH5BDvgD7utbqwQY1kYVVRSU41xT0q1ihXLU?=
 =?us-ascii?Q?jVlyyxoyzWOdsGkq5xxgApa8os0T+YJM53I4hmy+8ktLRxAB252CLZpTM89E?=
 =?us-ascii?Q?htQ3yCQQpQWZD+RuUEkGshKhpnezAci01b+9Y7TVUYyVgFb8kgm6dyIe+P/Y?=
 =?us-ascii?Q?Ql1lqWBZe1//Z9vm1U5RPyD1P9uhnFrJZxzr+Hn29kcZHy4fsscQ07orItDz?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82621f94-a81b-4f2c-9d3b-08dab07fd749
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 20:40:34.9044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EL1L4ZtozwRNfm3ogzGc/kcLvbNmPOEgZX/RqVAAc5h6XiwCSwzdLMXqLeRgFgyqH3oqOXCjenhir59FgeAoKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6603
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=720 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170119
X-Proofpoint-ORIG-GUID: ZuegZo2_LlStSL09nfG7Q-YZKFoAFUpM
X-Proofpoint-GUID: ZuegZo2_LlStSL09nfG7Q-YZKFoAFUpM
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 10:38, Mike Kravetz wrote:
> On 10/17/22 13:11, Lukas Bulwahn wrote:
> > Dear Mike,
> > 
> > The reproducer for the 'memory leak in hugetlb_reserve_pages' bug (see
> > https://elisa-builder-00.iol.unh.edu/syzkaller-next/report?id=3469603f4a0da86b581cc979bd6c6663b46ceb1b)
> > is reproducible, it is triggering the memory leak on the current
> > mainline (commit 60bb8154d1d7), and it was not triggering on v6.0. My
> > build config is a x86_64 defconfig with some syzkaller-recommended
> > debug options.
> 
> Thank you Lukas!
> 
> The leak is embarrassingly obvious.  Here is a bit of code at the beginning of
> hugetlb_reserve_pages:
> 
> 	/*
> 	 * vma specific semaphore used for pmd sharing synchronization
> 	 */
> 	hugetlb_vma_lock_alloc(vma);
> 
> 	/*
> 	 * Only apply hugepage reservation if asked. At fault time, an
> 	 * attempt will be made for VM_NORESERVE to allocate a page
> 	 * without using reserves
> 	 */
> 	if (vm_flags & VM_NORESERVE)
> 		return true;
> 
> There needs to be a hugetlb_vma_lock_free(vma) call before that return.
> 
> I will do some testing and send a patch.  However, I will use commit
> 8d9bfb2608145 in the Fixes: tag.  This is because that commit added the
> call to hugetlb_vma_lock_alloc in hugetlb_reserve_pages without the
> hugetlb_vma_lock_free in the VM_NORESERVE return.
> 
> > My git bisection showed that the first bad commit is
> > [bbff39cc6cbcb86ccfacb2dcafc79912a9f9df69] hugetlb: allocate vma lock
> > for all sharable vmas.
> 
> The reason your bisect pointed to bbff39cc6cbc is because the mmap/vma size in
> the test case is not sufficient for pmd sharing.  Therefore, the test did not
> experience a leak until the patch which allocates the vma lock for ALL vmas
> was added.

Please ignore this email.  I sent it before looking (or thinking) closely.

-- 
Mike Kravetz
