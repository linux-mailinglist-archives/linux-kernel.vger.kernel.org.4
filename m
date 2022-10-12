Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF05FC64B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJLNUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJLNUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:20:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8FE3F1ED
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:19:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CCx72X015123;
        Wed, 12 Oct 2022 13:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=EURTGFZWKvazteUqkIlGmTV3cTWM2xWsl4qCl76sCE4=;
 b=QOETv4A4r/orxeBZDDoYTEQbv7jg5iwKgOt8RdBqUX/GGISH4u1kJBRspH3oA5P1yf1M
 8R3GNAun88vqTssTZfojiSz6yVOugJ+yXt6dOaF4C0NmZKg73iKgB1lL/XcF5HcXExCl
 zTEqV1LIZ9g7Aartrhqc4SVfF1z9xJf5sAGsEXKKqk3GBxHyTl/kiCt1OldCFYh68JOq
 w729ha291voJaFN9jnUD5JKBoyitqNxcPThtoH8Vrjm0U4eI0+JTjTOhyeq/bpHPe1Di
 fVNqAnVHb4uQbYin/AX7bVbvx8GSJbFPbAA0HDq6PNThzXGIEENJ2oABPuPt9Km/i2nI 1A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k2ymd1j9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 13:19:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29CCPFJO021097;
        Wed, 12 Oct 2022 13:19:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynbdp6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 13:19:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvDvo7OickhZmJsaNE3kGOcI3iY++cxFOoKC/QSV9WHJ6CqBQ9obNsupiSmdSQ3vNPMLz4EWGtYwJSNUsr8POdm88xJyY1jw20iYJ5g+11hmiB38iLktB9KUs0tOKOvdsU1eEQdYb/K8EpWvTeYv25C5PovWNuAVzHifWvx7mshef5rKPuADhgQIw183G+yCbP6n6DLuo+GxlETIkJo3qkoca3rgHJ8tA1A2VNXqvROPOvzsfDmvvuUkygSd/9HM9sqYO4s1oTYvzw5jVnyFPohf1mJaeWlY9jY5RLTZxAa/gxFeeVXy1pN/jLn7or6y5w6oaWiHFykiG4rpXTOxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EURTGFZWKvazteUqkIlGmTV3cTWM2xWsl4qCl76sCE4=;
 b=gNonLDAh8ynPJIqKVIEhsNQzhjv/6oQYZngsEHmUrVA3piOCQUnTfDwbx+OHHzlxAbeY4tUMUwsMAhwzczRHY/znGRH1D793OW6SPg0rE0YW6uI0plItGSMXW7NE16I+cGVUACk14b/CPljMYjbK8ywLMw8okyetc4huvyODd8HOXgbRjEjwZcdnczz1T2x6IlhvKgkVk+0QHQ+ocDvdZc+7g9c5qdEzLtwCRO6eex3tIWwmc73SkdmNwoNPooACqmMFL5xbOaAfaophHEpdGOr67vDxWHrxFo91zYLHu3Bbfl7G7LclamdyaOX1NvfLezFHDwsuM4B8C/vZ8u0NhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EURTGFZWKvazteUqkIlGmTV3cTWM2xWsl4qCl76sCE4=;
 b=x2IbsVNfSz2tUWlk/NP8atioVA5bF9ci2oJ2FTmPy1oWJFkKqaPqE1MjHzexZYhs1ZhDSm77HRYZjnr+/aCnjM5UDNvrzNzBztqyoUM4t1HBnHeDUDjqQz97GXAWoZ8hEG13YIPM5tnjptrcb0IUTB7TqJhrKZhzUXa0yFB/OZ4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4848.namprd10.prod.outlook.com
 (2603:10b6:5:3a2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 13:19:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Wed, 12 Oct 2022
 13:19:47 +0000
Date:   Wed, 12 Oct 2022 16:19:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH] mailmap: update Dan Carpenter's email address
Message-ID: <Y0a+6+5SHMdvUnpg@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: LO4P123CA0525.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|DS7PR10MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6245be-984a-4dc6-cf8f-08daac546f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOmulsmmgCIVDBNG78nsMIj8HJ9ZrdaB01CD2LPq6g38HPBOhnGHNTkshFJgXcdk8QRqzK24gsb94Hqc3S4DdMJMeM8hJsNHiTP8VQ7/QlHhgpomPsGUB94nBNdSYGHe52VrcoZf2rGBFpw5jYxNCqc6FSXcnmUN5IIbt3PasvinIWyHz1H9Vagfy6+mH1Ct1yatnSASXAHtU/F9BuSH1tsmqPOqhBoRxyOFJIEp/hYmpWPPYjzJTiPfBSSwY+ZLIwXrU8SFym0MHZju17XtH3+5OUZaXHGqDBYAX4rMVVsUPPHbuO7hxG76ES0PTOfpYFvPw73fvsqPvmibskkXYpiejArB29obIneQD+XvQEujnNfeyKDvcGAljh4n+Q3K00ehZxtst7zmv7Wqf5n6xPKFTuQEKAD+XWNtNOVmqXdHwSlYr7CNBT7nmEZiAj8XEXxnxfqNwFOw551JvxFRj/aBSz2tzNXlwzNJLb4uusnRAGxTv4emF5DYz7owBiQsHtDgAkp8VrKJdPtyyVB1/nPbNRpZez0zbjedkdebM/Pb4SSi2rcISbihU83txYAX3WwzQ01XLROXXTmtI9qflvBdaTEWPQgudt6/YfiDBfufpT5+xz+Rf3ZErdEIu/Oa3H1WO8K/HJ12ANM0yAqai+XZ7kIA2FWnGj+KH2Ae3RZ3kLppD2MXnt5cpvB8elOIeVeE0FM+cakqAOFLgS+VqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(4744005)(5660300002)(4326008)(8676002)(66476007)(66556008)(9686003)(66946007)(6486002)(478600001)(6666004)(44832011)(6512007)(26005)(15650500001)(33716001)(6506007)(38100700002)(86362001)(8936002)(2906002)(41300700001)(186003)(316002)(6916009)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fIkQdZOLbGByxooKPhtm1sAIy2oLBJAB8KUHgqBMU8mKx3R7QmFtP8nMcEjD?=
 =?us-ascii?Q?kxEH2aYrRMr6416ClR5HBjXBzQmOYj2f9itkYbz8WQyHIZx1E+diPecLetQR?=
 =?us-ascii?Q?zf/abtWHOQhDKOS8nCOk7h1cthQPEIt7ytZAxhVZe6TOciGJ1zbAUP7FWDXx?=
 =?us-ascii?Q?mLAPs6O6PaNL1eXVwQWfgVewpVOopsw3q7XmMk5QRKCkg/hevxCBRvg+m006?=
 =?us-ascii?Q?UjTNvreLhLXh26O6t33NMC6RJP35ns0EMngObcVWMttYMumtkb8P7Rs2ChbM?=
 =?us-ascii?Q?3Me4C8/ZX3KCPEBS6dF61HLuU0D1ZwufcX72NrvfgFm8qU/VnYskzuoNoYWo?=
 =?us-ascii?Q?Em4je/rKzKijTodImP5HePaKx43czsfC0wYEaQXcm939MKYfYBd6oFCdqf9J?=
 =?us-ascii?Q?BfAT8WEh3VfN/MhDGM+quSo0vk7PpD0hYc8wTiA77RnK09A48/USICv1T4rU?=
 =?us-ascii?Q?mIg3Qu9ExYWTbVf4E/VE3E4IxlV9sI3y3ksqtEb4QNCp0gpKY7SiRGuYSalX?=
 =?us-ascii?Q?8oeh6wGwylAJW8dz6Us96FyjWDZOWVnR/8+lFQh831iNRVWa68CRB6WJCbt7?=
 =?us-ascii?Q?VlaS7jdXfTSqsxzgD6V/qs0YFtbwWgjZUQry0A+19/1DuSWJ+JVqI9AhQG45?=
 =?us-ascii?Q?x6b/hellZUqy+lHjtEViGI6fimM16veJUJCGL7b9W1PkasH3NxJkFYqjJgDi?=
 =?us-ascii?Q?XwO4d1udDrPCDBfTOSex8ji1iZpVujB1j4IyFYMDMpia1kiKo9NSqksU6hER?=
 =?us-ascii?Q?3+KUIcF/vXcuFcj1NNakwlT2m/bn0Qvjgo9Rd5CKnA/EOMPTWKvJZXm4kUQi?=
 =?us-ascii?Q?bB2NYp6346/Q1sLJQvjcU6MVzwbv1XQgWJ5wq1y32jDnHqDyFkd95cWQyTsd?=
 =?us-ascii?Q?QzOqEguP49D6W2yCYP1pMfUMO5VHlPveavqLJT4JjXTOjYhMRBnVcSGwh/Fl?=
 =?us-ascii?Q?5V68HegufmHrP0j4l2OuQmxPfwFxzGlai/jT/3RkogCRGcsyYMKaQzN2tvkV?=
 =?us-ascii?Q?XlD4G3zFz8m6Fw0/a6T3D8uSIvqK3glZmrhOISufvRnkTpau36edBSS97dgP?=
 =?us-ascii?Q?GB4/sZI0r9oEetxD9tdQFDHW3lZVub1/Bdlg/TV41EKUCaYRot58fBu2pzfG?=
 =?us-ascii?Q?d/R2askrrLf0N1HR6UxDxbdZfkCxQXS0EM+EJ0sHRweq+WXfc6+G/rgkfbgf?=
 =?us-ascii?Q?7E/dRSjVeJ2kS1rvxq9iaNsni/fGC1f4z0WP4OmwQCnv9YOYHiLgQT5z+AR0?=
 =?us-ascii?Q?mreYDweEQjgyh8JUWDLSHbYWaX9rKUBxfkUxOaPMGZ2ZvCUECqts3ub50tRn?=
 =?us-ascii?Q?06cy/CAvoiUjbNA1Z9xIbAZdzV26PhMgOGff+aR02bOsEzpwArFqEZWM5H3m?=
 =?us-ascii?Q?tXxYomcoA0iGm+Zlr9sA1IN8fXvRax6W5EFF2BT7vSk3vZ+ujwMI03vFjepc?=
 =?us-ascii?Q?Xf12Gb9W0ypFNSG3zMYBeUC1QyCRLxG6VVDqO9Iqr/4gdV5iTXECo7g4qyss?=
 =?us-ascii?Q?Q5sJJQn664R6RHyDMlw0aI79lYP6mXFkFkGG2l8JKannrReiLfrouBOjQKd9?=
 =?us-ascii?Q?oOmOCte4ttDiOO1PAeBvhi3MQ7d4ggIZGncJ+vNurvq7Y8O/kLvfXQGRLmsa?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6245be-984a-4dc6-cf8f-08daac546f14
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 13:19:47.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5C7ypbGGhYDWP5dJhOOxzQQOKbPdopOBusDJMMIjngMgqWgz+x4HW9fdGnHzcp+ZO0GOXVG+1eMhK/fk+xVn096gu7+DsBAzBxQlBBKRBIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_06,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=733 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120087
X-Proofpoint-GUID: GQ-CT6hP6ZUczy4GuksdAtf4hO1IACDs
X-Proofpoint-ORIG-GUID: GQ-CT6hP6ZUczy4GuksdAtf4hO1IACDs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My time at Oracle is ending at the end of the month.  Update my email
address accordingly.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
It's sort of unfortunate that this changes the output of git log.  I
wish there were a way to update get_maintainer.pl output without
affecting the log.

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 380378e2db36..b4e7511121f0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -104,6 +104,7 @@ Christoph Hellwig <hch@lst.de>
 Colin Ian King <colin.i.king@gmail.com> <colin.king@canonical.com>
 Corey Minyard <minyard@acm.org>
 Damian Hobson-Garcia <dhobsong@igel.co.jp>
+Dan Carpenter <error27@gmail.com> <dan.carpenter@oracle.com>
 Daniel Borkmann <daniel@iogearbox.net> <danborkmann@googlemail.com>
 Daniel Borkmann <daniel@iogearbox.net> <danborkmann@iogearbox.net>
 Daniel Borkmann <daniel@iogearbox.net> <daniel.borkmann@tik.ee.ethz.ch>
-- 
2.35.1

