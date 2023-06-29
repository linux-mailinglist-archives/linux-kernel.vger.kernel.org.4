Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEA8742D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjF2TXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjF2TWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272A73AAE;
        Thu, 29 Jun 2023 12:22:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ429I028819;
        Thu, 29 Jun 2023 19:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=lDYKfkREByz7jvq19kj93wpHDJC+zhrt+rEZQxH0MSHVpzhgIRQhGDptEnnKU58KAr5E
 1/ROhdb7ka0H9OZwi7sBFLK6lT51tU5VHKyIzRx7dTzoxlInKPzCmhpi3Gven2PVbqwD
 xxfjL7poJYidX5LFdG4z4O2XAZs5y5P5hvbuTseLixjlfPKo7PSNV00eDkWc6nImq8yS
 UfQN4Rfpy6adnf/mCzh0d4VDV/cttf2hRZ1HTtb97XWM65jVglP0OIqtMSHFZDgVLiNK
 62nFwF4Qo6B8X8Zdx4Y6JaJz+iNXd7QVN5WSTfZQKW3Q8rGauMJF0rHnj8Ksb2CfnZ8J fg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdnggv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TIM87c008573;
        Thu, 29 Jun 2023 19:21:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx7tsc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCvhzIWSIEtVpZanbVu6ozyz/6YRSIsBZpzASuk9sJ1gOgyiO9M2T5ejsvEcG+90HoBLp9WpfGRvD4gIa8xmjgb8K5bqyfAd96tC78c8jlNm/m0sGSrBsoV2zr6mrUY8nXwRNr9FQKNtoVtUfIhdcd7HNeGra2RWRqgL+0N6REYstXkNs3Zt6UTzmKPjnYrFMII2aJbeVwxdFBEMGjVxhRa2IfS38IG/fqncAjz5lUZNRnbjweLTM7fIfiUQtrhMwuP3lgJZ8k879JB8qoiQUxnVGVa1gutrC+8NkQVn4QQZ2FFksWmevrwf1bFeaPqxXV35tuTuBPJXb4iOM2sedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=BMzqGucjDBLgvsRi1FmdzEmszSBXxxG2M6479o30HZwpR2gI/RzataqgLFfZ0Ajra0Xopcfm/M8TMC+3TatcHk0agu6lgZjvGyu8Y4AxzYUl8kDdo26CFZ89AfrxGqebcR62aSuUkGnW00asZ4VqhTOif+OjtPJypsPeUN/JP1xcJHdpipcru4B6MNo4ohNKCHK+AiqJe25GHvbVD8gmvLZelDBdfGp7m3txCMbQaYSMxElVYnSxST+qYrbb+hYHOoxi6poVowOEMeLu+ba3UKBVlqmDy6+5cLVGFvfJuM+N8B3GKGFKefBBLWPfkMCD86YHgmFZcFVrmDP4Ws87yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=R7xJt5HsiOlYYth60yX2JXyJN2cys8L80knO5+Ikxu/ZJJPR0+CLzdFOwBfsBWuExWpdq27pryGTPeGOPUQE0wiU2GZIvKlq31Iqu9d3Z/ub9ynfb+fxmPvyuFb0QAOw0lbtmpyeD7Va++WK5+opnv+8enzj/w3FexVuUJIBksE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 29 Jun
 2023 19:21:53 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 19:21:53 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v25 09/10] crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
Date:   Thu, 29 Jun 2023 15:21:18 -0400
Message-Id: <20230629192119.6613-10-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230629192119.6613-1-eric.devolder@oracle.com>
References: <20230629192119.6613-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:8:2a::25) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 697c5db2-d34c-4785-7243-08db78d6185e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBsg1SRdsVswbdyvYROTwYP2Z0ko80zyZgFIUxRhGatHU/njUoOCWf+WTr137JasXizkPpPOij5qgDBhFCrnV6cG2vGO3AWxRI/cO5v4IvPRMqBWdIwffuo99lSMys15+MeCOlw+TcpWQAb+zrDk/vJb00QIz2Y+c5p9O6vrjikBxiMzG4OkLixvFEtlRISaT4o3EpkEo/t8wXzuYdmR4zWh9tPICh8zRP8fa1Fb1dG/Zqc9pnzQPckYekse698G/KERfQXuFOA8hVS7pCmg8BgTYl7qtxN/b8ga6LBRDWiOSGMHbYOrKf08UQhtmE4bbdkRzv7mHY/UAgwqRVqLQIG5IBK+R8GAWDlZK8RD5OT+SqzNnUz1JFjz5VEBIVHWi+aJwMyst+y1LHzJ3/ME9PZicplyPMu55OZE8M7RLUt+R7huiLpXzd18EFjCutAwlSQuI/Vyb1zTDF5qQUPmzvuffBO2OSul0gyQRTWcUhLghJN/SF3DPSktnn6JJAKfTG/G+VcvdRTgrjVaaFPyUP+n+cPMyyvlnmuhdx/H7LLq5H6sKmZnYo3oHliSsrCEo81bR1tSLFiCvfU2ISnOADwv4tzhwyKbo9Ha7WDRF4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(83380400001)(316002)(6666004)(8676002)(4326008)(8936002)(6486002)(41300700001)(36756003)(86362001)(38100700002)(921005)(2616005)(7416002)(7406005)(66556008)(6512007)(5660300002)(66946007)(66476007)(478600001)(2906002)(186003)(26005)(1076003)(107886003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ms/nawuuebVQ9giEJge8PvLS8OX1tFSToq7X6DNU1q3A5lB/UqA1SVSzAhdv?=
 =?us-ascii?Q?PxKrzWzf8QPNlr5wK6RUIRzZUPeRy8LO3tuD1xopvtvPikwY1cqSU1vERO4Q?=
 =?us-ascii?Q?QgmLczfMCXwPdH2VyzHe5J/QGIt2NhlfyZsxNMD/92Trjz8bWxBlgcjoXaMO?=
 =?us-ascii?Q?0JHCNWuAfKoO+D5RJxVVeJJ1HhMP51bUblZh4y/Vc28+8Lw/G3SfMNZ83NMI?=
 =?us-ascii?Q?NsCJy6VGxAzb3n27y8Bn1DgegvJavicLwxATjb0HSO19RP/RD6zIzyTdwO3w?=
 =?us-ascii?Q?umvmAtWh2SvWJagZYz8TTMIMMMv7qgY1b7mw9hips7YOve1HcW0n8+Xlhz1f?=
 =?us-ascii?Q?pHqsWP/igNWuOyzatrC1leh7ppVWXUGBv3/skf3jZuZN274trYbJDjqeEK5X?=
 =?us-ascii?Q?Bc5a+QvS7EqqGiXC+5c0ahBtEwGaqaLzN+Xo5/NXGYlybcF8AwpV9rqSqG3d?=
 =?us-ascii?Q?iyqY/SFRuKScm6+Qp3UqP0ZBtFH5hKPvO7EWmEh/k/fYyIIfc0Fnf106+zC3?=
 =?us-ascii?Q?gsUjtdzIIIb3BJYpepq3T/DiAYSVOhUEkVm/rf9eIEoG1OxQhVcg/bDbcgyd?=
 =?us-ascii?Q?hdnUB7JMlnQzE7MfJrByzUjRGO5Sb0w+SxnjBcAWGI9y7qzeYC32JAwemxlH?=
 =?us-ascii?Q?cdi6YCyJQ3dq2gEGJv/23c11ZDcjTNsUGRUW0V1gjHwQKeXzkZJEsriJ4mGa?=
 =?us-ascii?Q?efCRB7cRluq3yTsLGT6JqamJ0CjFH0934+nMf32P8PC5i5lQGlDW7if1vkoe?=
 =?us-ascii?Q?BNtmtr/FXg8Ak3jKjysqDsy6NDER+V5l21adlapBO0WyJFLln0DQi4b828TQ?=
 =?us-ascii?Q?Ph0hoLL/om1MfleZP22qLjmuEJuwnvdXEjRwOPW0TTJEWlwllutC1+dBg7jY?=
 =?us-ascii?Q?E3h9XsruS1A+t5tfb4j3nfa4eSaRICcWSeCTEmP3DkxCYwb4ileMUw+9Zxpi?=
 =?us-ascii?Q?XgBEJH4fdRrLdIpjWN9mj4OXmoeCjX+pI9DYGd3YI0ckkizEnPDB9Vb1Ceg6?=
 =?us-ascii?Q?r99eiiRc6vm+FIwuHWNDApFJrsLckps02R6SzTMzPsP++44SHPbHCSjgijme?=
 =?us-ascii?Q?i+fCdaJOcgpEshgGbBqDTtLFANR6uUNJi8RQDgdaGZsN/O3NUs2RqxmMxfWQ?=
 =?us-ascii?Q?vikaQrAsyV09PgvO7qVdO1kO4Ge/TSHOJXUGTw7aq4wQD+P5PX2aMW5IVEWz?=
 =?us-ascii?Q?3F0Omm7ZvoUAzDRDHvFuqK7jhpLAg4+7jPjrtaXCnvhdl5SyX7ZH2qDhf8Ox?=
 =?us-ascii?Q?z3J75yF9fXW19YtgPydnUBLb6w+X4aZRLk+OcO4pc0o7RoLjBbiYItzwaVFl?=
 =?us-ascii?Q?8Wp0yZI7ELf/vOmkLDzKPKWcyXo2j/bCpBR9cVSWimM9V9mOeoRxP5mAson4?=
 =?us-ascii?Q?QqKnxbpbjkS0oZyvGnnfxLt+B53BbftGhAV/b02Uqj6WDkHoZ3bB/jLsXyeP?=
 =?us-ascii?Q?REf+TaaWGrV1Qxva7UHtmkeTuMmwzs8TV/magouAl7LkpHG9pcNn1ON4PCzL?=
 =?us-ascii?Q?h5xlRgeyBGIRLVzdW+yT6AHxRSDSBvnxxuCcI8FEwKiLF1yz8746zi+PWS6z?=
 =?us-ascii?Q?qXa6EdV1pMJJKAGDM9NBMBZJUowtpJ15Nnqz4aCaiVqzD4QdGtQfK9pxLJLy?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1Nw72tnfCzXxrEJJQqBrCzxQHRP++iJ1H9GvaicAB79JJWGS9aO99upVwzEf?=
 =?us-ascii?Q?PCkS17quLXTziPgYwcJaZcoGH6yxI7ZFCEnE79lYS1lM2ixY/6r6nfqw+m60?=
 =?us-ascii?Q?F7cPvHrWoeGvMNAZHWpsLjjuXGZiJu67LP7KY8trgq9JbK8iPE/Uwg734xLj?=
 =?us-ascii?Q?Vk0fict8C+7QDaq37PPgKHJHtFpCBNJrCueqs0Sy+vs1DUxwgf++ZhL7+Bmo?=
 =?us-ascii?Q?NjO2D3L3mYrM+hkP1B+MTGt6rC3vuKHZxaWE8ibwY0qJwqCD2BxIeKQ86gXd?=
 =?us-ascii?Q?ncs3ab/UPi0w7yaHE1jJg78jBc55Z5uU6Xy+OxA1mLtBZpZKOEK6aaQJ2EDY?=
 =?us-ascii?Q?bMriuzksdImrhbH+V9mgoRppK+aThNzY0CWdGw2SAO4B70v3Vf9bMIz9ZkJ9?=
 =?us-ascii?Q?o7chdcCi/werUVgujdpcM45CI2IHbT0WU38C8aCVPg7NaRT6n9+VrHgNETnF?=
 =?us-ascii?Q?/si7c53z11o+5JEfl00188c2J13jwLJnG99p1b3liF1uwapIJ/9q7o2SBBnc?=
 =?us-ascii?Q?WZ/3lIe69+71e+c1/o/2joWt3hTZH++MU7oQ3dwqWD/vJh2JXTpb1DI1Ktp2?=
 =?us-ascii?Q?kwwSLlHdzTy8U5cyInfK4kMt8SMVyFDdmn/ndAVabtWDR3SUEwfXkvz52U6g?=
 =?us-ascii?Q?Ta8EuqsidnZtoO6Nl4FLU1I5T4rnDxxP/kbadJTnOpWpRBlzWplloMa03ZPq?=
 =?us-ascii?Q?NeuYeMpfwU54s9jj/rCd2ZM4lHCF1oVxYmMmKOTjreptIg/k3kBqVHU5AV03?=
 =?us-ascii?Q?5ttsw/oLgUCIs8vsCsCwR01UJrJ/36KNZMzEbBuc3idkv2yGx16M7bwHIB0V?=
 =?us-ascii?Q?XpN4p0ZHIRaw42t+V+vANkOBqhfZJfidvOo28ftERGxkJyuICfpv5j84/I6g?=
 =?us-ascii?Q?E/CzkrUl+6vD0Wc3j2h7FDB32wB3d0heUzNBnkMPadsh6U2KEgllQcZkCbKp?=
 =?us-ascii?Q?liTLBGH9nizDvS0ynbhmAJhOjUzBJMN3SklO/JluNXJcmY6QJyH149nDXO0k?=
 =?us-ascii?Q?1/OuqKiaqafsCKVBY2udK8i8z/pAYMZeXha+svYSBIe+oWvCapyq8YpuO9Mk?=
 =?us-ascii?Q?222bzjjoEOBPpH+9aDiA3aIDMR7rT02JGPe/r2PznbmSOhf0fek9Z3Qqk5al?=
 =?us-ascii?Q?SYP+mDIsuEvmUs9MhxCmJ5L24/ZDsr5j39ZYBl9dKwLHNS1FYqKJujRDTKcS?=
 =?us-ascii?Q?FCm6Fedx/hRLqSKHepFF0eV1Lk3HReR5yrMBvCuJ50BkNzcuQ8lz2n7vJhkj?=
 =?us-ascii?Q?bScShyMi2Gn4Tz+7NZ17PF1DmtrCzK2/01O+vF+O7iffH2qzgiqVN3XzCsti?=
 =?us-ascii?Q?NZ7fBAI/S+FZSdHcQxqsLcbiE0JjmV4et8JrekuieoofvFTaPvCObIEMTM3H?=
 =?us-ascii?Q?KGqxCFa9+ZZcSqTvNGY8tXMScxKMCYUs+2V4sxfmI35/2F2RBy6Jx5Zrcoip?=
 =?us-ascii?Q?gUtC7Mh5Gvc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697c5db2-d34c-4785-7243-08db78d6185e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:21:53.1633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMihUjeqjSDh96U8nwbZjLiNXy6bThxgFui8VSr1GwZet77krLnfTOt6k075l1nI5IlKKc5d2TdyT/f/XGTaZ20ojucwMZ1vHbM1CCMavRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290174
X-Proofpoint-GUID: FWUaFHBYwk3hRjxwqAaWeVtSQ5qKVbRy
X-Proofpoint-ORIG-GUID: FWUaFHBYwk3hRjxwqAaWeVtSQ5qKVbRy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function crash_prepare_elf64_headers() generates the elfcorehdr
which describes the CPUs and memory in the system for the crash kernel.
In particular, it writes out ELF PT_NOTEs for memory regions and the
CPUs in the system.

With respect to the CPUs, the current implementation utilizes
for_each_present_cpu() which means that as CPUs are added and removed,
the elfcorehdr must again be updated to reflect the new set of CPUs.

The reasoning behind the move to use for_each_possible_cpu(), is:

- At kernel boot time, all percpu crash_notes are allocated for all
  possible CPUs; that is, crash_notes are not allocated dynamically
  when CPUs are plugged/unplugged. Thus the crash_notes for each
  possible CPU are always available.

- The crash_prepare_elf64_headers() creates an ELF PT_NOTE per CPU.
  Changing to for_each_possible_cpu() is valid as the crash_notes
  pointed to by each CPU PT_NOTE are present and always valid.

Furthermore, examining a common crash processing path of:

 kernel panic -> crash kernel -> makedumpfile -> 'crash' analyzer
           elfcorehdr      /proc/vmcore     vmcore

reveals how the ELF CPU PT_NOTEs are utilized:

- Upon panic, each CPU is sent an IPI and shuts itself down, recording
 its state in its crash_notes. When all CPUs are shutdown, the
 crash kernel is launched with a pointer to the elfcorehdr.

- The crash kernel via linux/fs/proc/vmcore.c does not examine or
 use the contents of the PT_NOTEs, it exposes them via /proc/vmcore.

- The makedumpfile utility uses /proc/vmcore and reads the CPU
 PT_NOTEs to craft a nr_cpus variable, which is reported in a
 header but otherwise generally unused. Makedumpfile creates the
 vmcore.

- The 'crash' dump analyzer does not appear to reference the CPU
 PT_NOTEs. Instead it looks-up the cpu_[possible|present|onlin]_mask
 symbols and directly examines those structure contents from vmcore
 memory. From that information it is able to determine which CPUs
 are present and online, and locate the corresponding crash_notes.
 Said differently, it appears that 'crash' analyzer does not rely
 on the ELF PT_NOTEs for CPUs; rather it obtains the information
 directly via kernel symbols and the memory within the vmcore.

(There maybe other vmcore generating and analysis tools that do use
these PT_NOTEs, but 'makedumpfile' and 'crash' seems to be the most
common solution.)

This results in the benefit of having all CPUs described in the
elfcorehdr, and therefore reducing the need to re-generate the
elfcorehdr on CPU changes, at the small expense of an additional
56 bytes per PT_NOTE for not-present-but-possible CPUs.

On systems where kexec_file_load() syscall is utilized, all the above
is valid. On systems where kexec_load() syscall is utilized, there
may be the need for the elfcorehdr to be regenerated once. The reason
being that some archs only populate the 'present' CPUs from the
/sys/devices/system/cpus entries, which the userspace 'kexec' utility
uses to generate the userspace-supplied elfcorehdr. In this situation,
one memory or CPU change will rewrite the elfcorehdr via the
crash_prepare_elf64_headers() function and now all possible CPUs will
be described, just as with kexec_file_load() syscall.

Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index fa918176d46d..7378b501fada 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -364,8 +364,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
 	ehdr->e_phentsize = sizeof(Elf64_Phdr);
 
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
+	/* Prepare one phdr of type PT_NOTE for each possible CPU */
+	for_each_possible_cpu(cpu) {
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.31.1

