Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA6262CCEF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiKPVri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiKPVrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:47:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28C214D30
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:47:29 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGJNlgS021470;
        Wed, 16 Nov 2022 21:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=oIcaLpLhTJwhNXYzYLCwxX19gHvExvSo36aggEIVlAM=;
 b=daNAg3v/+EQKACx5hLo3q0+RTee5acmEl2Ak3PHYIztLXOMY3hA94Z7yKJCa1gZA4L78
 HbKmgpctQjyVwyIgkEIOFV07Lc5GXy0tQMSGmEIxguOfR523+3vrBFjz8+8MEzVBHrzL
 sX4uEqSE7xFJPg6TKKiFyCNekIXbZBmgsBLAIMS7F6zCBsrMm2VlCsnjTznN++qr/HKK
 DH2iav+Lrhduk4vAjFr741nZMVoL61gWrz8YAXi5J8sy360HpJMg5o9Sx35BfWs4GC8F
 +zhyEZeeHOBN6zrqK8n2HZvP3NjjVlBDC/fNiB0Mtt3g4jpjDxvWfIiBzr814ijT8yJS Hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3hdx9qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:46:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGKERsm034784;
        Wed, 16 Nov 2022 21:46:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kw2dcjtph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:46:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYR35jv72vbJT8LEwGzZPuAuxqqV7RJ737NXSF/qORDmi49LfLqv1NkmxSKV8fn4ePnDHDgqOdcAS4kM/vQLaEbCZj6hmjARoV9QXCQfgFW6Glz5pztqSo9JWsPZzdUcG1b1dRZOaU6cd+qQRv58ms4mLjwugwPVP1qdYRbc9UfCd/jHFOLuWyKtXQw+/XaOsCZqHqTIUj3i/wCwT3iPcY1kbep0qz3l0xUw3S4A+FSCiGKykhd0Ysij/wVWzPsFdQZZkmAjXwL8meYqXJLM9N0Jgs4bSsV7ctJJqwX2xd2G/B0b/Vo9P4HNTRUmIgandziSMrJYSi0AkwW8SgLWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIcaLpLhTJwhNXYzYLCwxX19gHvExvSo36aggEIVlAM=;
 b=OKuuJdBZq78p1ql+1zCDX+p6mlfZeyAjHABWRKsBjHfE7I1V7vv4tNKGecyuueVKuBRgxy/pT0+gU6i2V/WdqYTcMHNUO5bQIeLMEsldTTn83uU7JJ5a9x8yBfmR9Yuj5riaTqWmb7vfnzBDeHKXvjy/GNtrEgKNJ+1QzD98IHpdN/n8y4eOQGeo+gUS/963VDzc3CUuAWxzvVqqbmyO94hDhbff7CpGIFOwBc0P8ncax49AvH+bn18Mxfh7tx+PybcpfljVuEfQcJ/WGlLWgSfB20RKGRfT9505mlhsvMKWTUTVVaq0nQ5AIbFRKWfW3xfCBFDHNkLFBSBdFze5Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIcaLpLhTJwhNXYzYLCwxX19gHvExvSo36aggEIVlAM=;
 b=vGvIoaM4uA9RjBChd1Bp58iiOaJJpVbS9K4vq67NV27uuPt5DMf+zhaMjqs3Zwfz/TqtynjgZi4Pbom1YabecOHe9CBEMfylX+wStBVRYbHDJ1aAwqBiJL0Y2v8G6p+CXQgoVm/xk3lt3o8IqXDbHnzSaNPw7PgiJ0T+hGZ7Nfs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 21:46:51 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 21:46:51 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v14 0/7] crash: Kernel handling of CPU and memory hot un/plug
Date:   Wed, 16 Nov 2022 16:46:36 -0500
Message-Id: <20221116214643.6384-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:805:f2::44) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: b5005227-d219-4163-f3ca-08dac81c11a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11lGADv9XORH0+WY0yMqNN4o08T1x6WuxhWUIxBfCDtaJf2G9XXz5TfWqwxYCeapJAnyyz9FBjQLLasa0xfFEfLgIOkATuP/QvKA1qpWAB0BIOu87tRcxK+OrY9mHZ6cBb4ym4WXW9N+5zEf2zQjNeySgL+TSAO4gxbv349bMFAqghZwm2EDUhTvRxuI+QlVe+JcYw9IOPM33QoU4TD3fedrwhmBDvu3ANwkpTSg7xnGz73LPe+WcI9L/ChYqeq6C3HPO7l4BC5cBMS+g6scw4Jkfz84z5dqN7XTXk3PrNvuVTQm7dBeKI/mkIHvRc6822Zn0TgzsNEEa+L5fJXPbKbu3LXLihPXLBAhY/+6SrftYe6eLKgr6S7r8cv9XIQhNxG8Kr+vRaPKfGlEQRn9BMhm0kbx6/Z14FJIKZmE8Ib8pfmmdvcmHlNWUbvJ3jPL4C9vtnERKH+Yrweq1S5D5BRz7oUlzq9/a74vBdwKhVmHv2v8eQYR31NSnddU2xwegxTJH/DpPKfW3z8tgowsLn5nlwjwBO0QllDtBxq6faGNqO2iCGPN74Qn2/f5WBLrqXsZ0Bb55X2MBPpEEDM55tb4H4vY98b5DbZ2BHDTqn2IDC4PzM4ZTPuXQc1j11TbXDRIiijS6lwvQ9senrVyMV9yYC/5sUvhU3hKSGaXk9wA6VepngCZ9+fjoTlq8W406dpLyRW0lYYBB0UIGMRoBA0XUy4ohllPkhmYSvSF5j6QQI8gZL3aS2Deygy5jblnX2RLvtojEWb+zPooxmUgSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(26005)(478600001)(1076003)(6512007)(186003)(2616005)(6666004)(107886003)(86362001)(6506007)(38100700002)(36756003)(8936002)(41300700001)(2906002)(5660300002)(7416002)(4326008)(966005)(66476007)(6486002)(66946007)(8676002)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZJ+mHhwUeQlTDi5xMepchynD+sBeLPHumlzWXOK8mHpWUTRkbtOkP9GJmtb7?=
 =?us-ascii?Q?9cP2YkLHli6a5d0s7SagZ0VpL/XnmLyBIvo4fGuI8YFQOAkZmV7/YpAsacbr?=
 =?us-ascii?Q?QskWgn4bpK5BsPXG0PRLkcY9+nSATKKnQxbuXmuWaf2GpMPA4NBeWtDzhf+8?=
 =?us-ascii?Q?nhr5JePX8a20z7I7nVhzKYqKa3ei0eS0/McTv3IlK5EQei/MBTGB9nPMbu3W?=
 =?us-ascii?Q?8cClNxEvwtLKsMwXZAKRpwmQN4OUT1+ZGJ3VmwpUfBgIi+3cNp5xPHzZbxOk?=
 =?us-ascii?Q?f+N2ZAzMjAO61R8c8dP7QibsWC1vC7ydqvNTC/iZss2ZNbcrPSmECDfdFjds?=
 =?us-ascii?Q?ZtkGdSUsP2fqeUZDmTib5IRg5HSwqDMFKdTzOXgNT7c7DW7as0eWu/6pwdBP?=
 =?us-ascii?Q?UVkyFbVNAlDTrJOLo5GxltpAjnwCRRgBuTe0M27mediMva5rQH7UUNw8Gyfh?=
 =?us-ascii?Q?4zedzhvNFrKs0jKnEufbhlnbwY0CaXEUjV0QONWMqN8m/3Bn27c5pWjMkzaZ?=
 =?us-ascii?Q?1xfVnuGZktlMC0tJYUFs0wBuUeFgoYnOvS7Nu4rpWNYFi/nlIApTrCNHd6+f?=
 =?us-ascii?Q?0N0p4g5AnEjPts87K+uJ9iUyrDJefldWau5mNAbiCPq/+Znsc/w6IK3dG87n?=
 =?us-ascii?Q?twJ23Fhk7aglpUQpFbWZ+yVVZwMpbqHSN6CNazGfP774N7YEcpS5kq9V3oey?=
 =?us-ascii?Q?iBgDH26udzk4Oa5MtWu5MC6/WpJehA9TDuPPWrMSUyRaDS1up0PtkwShZ5gr?=
 =?us-ascii?Q?QIITQl9P4TBYfisZVQplidRP5izDaon8f6lO1nMkWr8FF54Krv/GAFZMpiz+?=
 =?us-ascii?Q?OJQjm7PK5O8CxAsvGcYjzWYC9tVqsOLZM27gtqNDkCLt+n5KKpdDvts47VgC?=
 =?us-ascii?Q?zHS0E5zRwNAC2yvyKvjvIXTvNiQ6iMxwSikYfQ/raXeCkR1LoW/pLbd975lt?=
 =?us-ascii?Q?+BGI46sScwJ7IzJu7JQnbgMhMwrJm91keIWGyYw2T9vp9bgXqd5jxmoWfLq0?=
 =?us-ascii?Q?BDXxNYg+h7LR57Y1M8YUKLAroaglEbeN/Xg6AsUzwaa6/v8PAsyqFtVfdmNT?=
 =?us-ascii?Q?OR0zx4ARjWt/WYRfLSEZvGAY6AZnaofumPkuYerW9fl0N/koQELavWypYa7P?=
 =?us-ascii?Q?oqVsyY04Y9SGvD35UgdzSYorRyC/BCX+XSuW4keFi2jjF5NZ4TpXCI3BgHFO?=
 =?us-ascii?Q?PBAR3dL/gViiT2do3BkzBZqHxC4kNUl01ddhLbYS9gMx07sgOfClhfH27Hu7?=
 =?us-ascii?Q?f5UFlA6UMh4w08Fl+NIjZfX8uhOx/E6bKUD7UiC5WqIa/ioimz/JIDdCqh3j?=
 =?us-ascii?Q?chbmLvWIUznFEIlw8Vx6wBiKTD9WiZrtE5+7DDJRvH8akdDqjnZV+lORIL61?=
 =?us-ascii?Q?Q9GJNTXlDGH9GcvKJys1gsG1GzflHH9/wgoR6Y9vw4ccouQaCHgQ2jVKZv6Z?=
 =?us-ascii?Q?hzNSrZB8kAJzrtmXJ/PlKw0ug5VRE2u3qSOo1Dfbe21vej5ORYLzn/KojV4n?=
 =?us-ascii?Q?J0sIzT9uF58bP7y4epSrH+yM35SAxBwLQ7lZhfdTg2+w/6l0J17iNCefkS9z?=
 =?us-ascii?Q?jqH9N7XluiND2SOJxiCtBTgC10KfslR2PPZdw/lD9IkQiaB9tCgQzfsEmwn0?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Rf8wjLa+qAPY7C8kxhCXGO4OSL+2k9SQL9qWJPuLmVc2WXWcb16/ojb9nq27?=
 =?us-ascii?Q?8Ng6IwOTP2bjd8N3QkliylPOZgRbgDkmQDjSJ2YweS1MxtzbmTk07XdMOpwB?=
 =?us-ascii?Q?RArojNHQW3jvyBLNSjAdPAWekNvT4pl/w4lD+Fm32Q9l5pwwbhkm1sV4Wm7I?=
 =?us-ascii?Q?HfB2FIh1fTG1tPnoSgDvpD2gtpLzmLKkezKyoK93MNipdQGpA49S5e2SJbmh?=
 =?us-ascii?Q?PVuy0XqvbBo3dZ/S9E+FDTwSflNqJTnnav13lD46q7g7Bl14u0rfFOXlNGHE?=
 =?us-ascii?Q?hnCgxj+JvkO6RlCrpJTyQYeUn/+YexlqZJAj0j54o+tsarCOJQZHRgGu/AIY?=
 =?us-ascii?Q?zdy/jAOttin1yc9sYVXzYhMcUOQY1G3r/3XPZd8cXe92rdgTIqb4uMcMPMz6?=
 =?us-ascii?Q?QtnyNpNPzzef/QI8W2ms/7J/qu4EsTCcY5bHJsuqIabvYtp+UO1GLMu8srNb?=
 =?us-ascii?Q?Tu5rx6+u/X6icdLqZInGMGUUG9jOAoxoPltyTokcr23qk3BKyI9op+cC48M8?=
 =?us-ascii?Q?BU8lMFwQ77kTA7rEI9wiXBlrwapz8gVZrf0DTO0KST5jauBS5D+X/NGqP5aM?=
 =?us-ascii?Q?1RjPT6k28vY4njJHKLfBAncSaOwGl8prIjLB9Zf0hCJdMBR9ETyYZauAit82?=
 =?us-ascii?Q?u5elQDx5ET1Od5/xtVTqH7+LqJFnprN3ZhrL+IclAe8exNftpD3VJq6GzxbU?=
 =?us-ascii?Q?0MNFdybO5y0a7vMr4kkFZxVwaCAOjijgBMiPH6JapuFsB7Uu8ZotZstGDvzK?=
 =?us-ascii?Q?drKJl2o021h1RxNceLYQuoaTEtdC5eteMCUImDNye2k3o2OSPIL+B5vTgMFJ?=
 =?us-ascii?Q?PpFTmBdtJLM95euNPu6XDxz9iIjDQscfJW2/WoAZyL0pEtVOQQZzeKjHvN6x?=
 =?us-ascii?Q?Z0bD3p4IyCYpNlp6eHUrGHsh8AiC/FhpXcMumMKSkLhzUGCkqm/Ft52G1tpH?=
 =?us-ascii?Q?sWmRpf9Icbzv4KnChqXdCOQRMGqqUQGaKO7wFmcuFrooTh4MSm50jLZvrSt4?=
 =?us-ascii?Q?g2eD0I2MqoRuTo35M+zFf/jPGM1zsi2sGzUBF0u+QOVZR66t/HnIbhtG+fS5?=
 =?us-ascii?Q?Q8kzjSfpU1jWBLLoavGaLmWb4XKbLc7QOZtPg6i3/Q+Lp+yvMdtQC+Gyr6Ia?=
 =?us-ascii?Q?MeFIs6cyieSaKirFFVuSc39nTNGPfq6tycHKcEDw5sIN6I7K+F+h7AhxC7th?=
 =?us-ascii?Q?UrtlgpSYZ7d8Z10MHm67C96ISbnkwkrAdO8XtYoJrQcp59tGJIgI7H3L8xnL?=
 =?us-ascii?Q?jujIE+dyUNOa0j5OYzc6YN1a4fxUrwSrHArwDGtU+9iRWUPZXj97XLbYHqOt?=
 =?us-ascii?Q?IzbXSj7CY2T3fVjwmV1UW7JOgqYGe9FIr7b+D8rR4V9tNw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5005227-d219-4163-f3ca-08dac81c11a2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:46:50.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETblKsL6eO94Nu2ZF6UoJsf7QzglBJY6/x5bxy5/dUjeDeYgo7FGk2coQFuXIVXiZvlJDgCeW8HZZWbHmbaTnxTcoQlPND301ZM5gEZUMCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160148
X-Proofpoint-ORIG-GUID: nHZzUFyrpwLp5WnpePjkZtYkHixNnMnI
X-Proofpoint-GUID: nHZzUFyrpwLp5WnpePjkZtYkHixNnMnI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kdump service is loaded, if a CPU or memory is hot
un/plugged, the crash elfcorehdr, which describes the CPUs
and memory in the system, must also be updated, else the resulting
vmcore is inaccurate (eg. missing either CPU context or memory
regions).

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, puratory and
elfcorehdr) by the userspace kexec utility. In previous posts I have
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash hot un/plug handler that
registers with the CPU and memory notifiers. Upon CPU or memory
changes, this generic handler is invoked and performs important
housekeeping, for example obtaining the appropriate lock, and then
invokes an architecture specific handler to do the appropriate
updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no
involvement with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel handles updates to crash elfcorehdr for cpu and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   These lines will cause cpu and memory hot un/plug events to be
   skipped within this rule file, with this changset applied.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load syscall.

This kernel patchset also supports kexec_load() with a modified kexec
userspace utility. A working changeset to the kexec userspace utility
is posted to the kexec-tools mailing list here:

 http://lists.infradead.org/pipermail/kexec/2022-October/026032.html

To use the kexec-tools patch, apply, build and install kexec-tools,
then change the kdumpctl's standard_kexec_args to replace the -s with
--hotplug. The removal of -s reverts to the kexec_load syscall and
the addition of --hotplug invokes the changes put forth in the
kexec-tools patch.

Regards,
eric
---
v14: 16nov2022
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
 - Rebased onto 6.1.0-rc3, which means converting to use the new
   kexec_trylock() away from mutex_lock(kexec_mutex).
 - Moved arch_un/map_crash_pages() into kexec.h and default
   implementation using k/unmap_local_pages().
 - Changed more #ifdef's into IS_ENABLED()
 - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
   into x86 crash.c as #define rather Kconfig item, per Boris.
 - Check number of Phdrs against PN_XNUM, max possible.

v12: 9sep2022
 https://lkml.org/lkml/2022/9/9/1358
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---

Eric DeVolder (7):
  crash: move crash_prepare_elf64_headers()
  crash: prototype change for crash_prepare_elf64_headers()
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  kexec: exclude hot remove cpu from elfcorehdr notes
  crash: memory and cpu hotplug sysfs attributes
  x86/crash: add x86 crash hotplug support

 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 ++
 arch/arm64/kernel/machine_kexec_file.c        |   6 +-
 arch/powerpc/kexec/file_load_64.c             |   2 +-
 arch/riscv/kernel/elf_kexec.c                 |   7 +-
 arch/x86/Kconfig                              |   9 +
 arch/x86/include/asm/kexec.h                  |  15 +
 arch/x86/kernel/crash.c                       | 108 +++++++-
 drivers/base/cpu.c                            |  14 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |   8 +
 include/linux/kexec.h                         |  51 +++-
 kernel/crash_core.c                           | 256 ++++++++++++++++++
 kernel/kexec_file.c                           | 105 +------
 14 files changed, 508 insertions(+), 112 deletions(-)

-- 
2.31.1

