Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FA46D091F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjC3PJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjC3PJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:09:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF511CDE5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:08:13 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UEEd0s021652;
        Thu, 30 Mar 2023 15:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=N+U6BntXZJtnUuMShahUhC87lVl2uwOH1z97GS5eZCE=;
 b=NViJmoUy7tJtVN3p+xHDiWwW35SmgQbfaVNMm2qD22uy9hGVGKQ9JYPEiPh/Ys2AFuia
 +J11/QJd0iJs0RAasfh+XZomDY/b3Q1/R/pr+gyPr8fTmALuUrUmrvf/+JptR9qLiWnB
 FGS4NNLoltEBMVWFmTwd/5QASJwahfas+H15ydfEngdjGZvyuUpevcJ6QqSO6pZ85692
 GF2s2LtHAP3B6wg3BSoQfL09NaSOZPNLff9qYwMgqidVQE1JgnF8COTobfLeHBgQAIKV
 xKyJCwTGqeDGpUmwPEchXrJYxmImfkHMOQpIRhJRBEnirYPpcjYqqr5H7Gzo2XsxPuv6 ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmpc93519-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 15:08:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UEx1Z1030075;
        Thu, 30 Mar 2023 15:08:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdg32kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 15:08:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqdr8SuEhHrmcvCdSunZ2arCrrJt5Zb7dmP47UbX6bnh+UhP5qtlbVBfbOJlu7fh4U7PypjCwuXjx4Rgqknyu7SbhzERQY3HWzRWjs2GLNDId1+07MKz2qnHI0U+1lKM1DePz2iqivFvKpNaX9ZW3rKRKQwSYPoR+PGe1y+AI+k+F4yvhL9JMzGSBHzV4aNaq4oW+FUmaETB+GPvwvnhyT7lh2HZ9pK2zOybEpYoXSMBdJRZZk4zomR+RBhNgeI0oe/5TbHko0iKJGtIZ6q5ZSycjWGk5g8pKqjwKksSy8qrMKkFNWw8M9BT3v5yhDFkDVyj3NIQ/Q/dnmEksAWitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+U6BntXZJtnUuMShahUhC87lVl2uwOH1z97GS5eZCE=;
 b=Jqr0b6RWCEf2QT0JF5sI28ckMZsmDenMZdcjwTNudvyA1o8Vpite2RbeEFAmyJj6dEfsW3bDSZAU471kn+mLd2IFHhdzb1n6OlYxmchDx5FMeYZpukZ6YRkXVNSgr+f8euRs4jqEDEo8r+kdtZEM+FzoelmeeG4oi/6G2IyMnPLUn2sCoG2Pq8YffJ7IH70nntEzD98xUnB+RodNavqX+lg390GFCsbKjvEh46Hm9cpAOp2HdQoB5GO1Qf0roodxjbJtaK3hBhlc7B5mj8aB25pRTtDLWIuDgl0nuCvNdfoJciM1JrOknxvgF1YeJwCbWMjp/LYWd029LoWohxwjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+U6BntXZJtnUuMShahUhC87lVl2uwOH1z97GS5eZCE=;
 b=Qg0966itWDZYJffyLw9k9/OPB+MW1wdghh1qLUIeCvpMPYAxJCq42RwqKpij+fqzokE26DIki5YxywWWTvM6tleCkeAOp928Fr8VmqJYSpd3LzLKV/kbnnZ09w0BNqPy1O9YgJUVu4vDuPAiIxnteqOHWFeITJn7Hwttra29/Is=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SA2PR10MB4732.namprd10.prod.outlook.com (2603:10b6:806:fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 15:07:59 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 15:07:59 +0000
From:   chris hyser <chris.hyser@oracle.com>
To:     chris.hyser@oracle.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, peterz@infradead.org,
        vincent.guittot@linaro.org, "Chen Yu" <yu.c.chen@intel.com>
Subject: [PATCH v2] sched/numa: Fix divide by zero for sysctl_numa_balancing_scan_size.
Date:   Thu, 30 Mar 2023 11:07:57 -0400
Message-Id: <20230330150757.547423-1-chris.hyser@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::20) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|SA2PR10MB4732:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ed7b16-de63-40f8-7b08-08db31308ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2r26hwnHUxUknj3G4dR+KCm6dHn+paEG7jlOYJbdvwvSMmFwWgNELZyXH5dEFr2DtCekZXz2QILzIYDwNi/C0aqHMBwLWyH+W1fbrsaBeeyzRVlb4VsMWhO0rUs5tH0hxG5y8aou0p4FN407cRgCyuZ+HOXSvung3GeQdh13amx/aVIgyxBBEfnC77AzZ7URqpqsaxZeYJX7g0PIZvn4wZCWrrrf7t8OKmGkMmpGCRcZ7ldsgJQ16ARlsDcd44n8XzZxD34ot1yWFUdJfVbElrrNRT/ae9f5OEnAuehwPPhBXWdUMnBl4E+zRJoXQAq5nh7/HxdBx0MVhFG8mzHvJ4ng6+Y7Kep3cJi+9zrloF3euadGdd61qgz2PdlR8hfuASL8dersJ1wMiPrW2n1ykm/+8nm7vJbJtc+SKU0hhneleZNoZbFb/xkzZGDt4IIAaHuANDDbkbSEUL371CQ1K1DKWG7IiH7pLWs+YRGPBSoNLC2gfvO/7AoY9g8oFr4OyjGBaEIczmr8vTWUePwOeuZmpfmO8f+4jFew0ju6qUh7/73sJ3qYNhKLY0bAOgB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(8676002)(6916009)(66476007)(66556008)(66946007)(86362001)(41300700001)(8936002)(36756003)(2906002)(5660300002)(478600001)(6486002)(83380400001)(6512007)(6506007)(1076003)(26005)(186003)(316002)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IS/GiX2XVNKSkMqBn4fLmiQ95SrBxkufcmAUEo69UuoQkUE13YbNlyzZF+br?=
 =?us-ascii?Q?WYD8v654+lGAc6+QVMVKtU1OCG1fju6hlqngoEQt/7GpesaTY9j8EOr/WVwg?=
 =?us-ascii?Q?Nb5FxQ8OxDkgJkAIVoGiu2XDhD0RDIlWv7Uj5rMtFbOpSr7QpFFyoOj6YYHH?=
 =?us-ascii?Q?4emFptF+LdnKB2iva17wQXFce44+bsSlt6+mbu/VbZ//cGb3/gT1VwPJr8n5?=
 =?us-ascii?Q?0bMjnIBpZ4jgI0qAcwKRbNqyskyZGVMGptSNdaQTo6ki/914cwDHRcUwS8k3?=
 =?us-ascii?Q?2XQb5XirtpEvybxaqI/3b1k2KTK98T1N/hE1ej5GSqGu5zGp7a3tEKegCth6?=
 =?us-ascii?Q?0R/P6DAjcyea9lSnNhS68IPRbCGI/CrpobohRhe5/CJXIqgRKStSy2Xryi8f?=
 =?us-ascii?Q?lDkbI6juBiuHu/hTCFrhQKtzvuulVDqKLoRbExq0/oCOmSni1vDsSBemE6eG?=
 =?us-ascii?Q?yM0HkBvjZzpYHCdnOfm49sIary6ey4vahewokxW8JZ4F9fzxuQMonHpNGA7L?=
 =?us-ascii?Q?ohN1+qbNvelFxLYg2oE1P7WwXxRpWV7Se3kKdGtG9AMHNkeL0z8inlvKfX2O?=
 =?us-ascii?Q?/eA1KHIc2esqTsANKtHw5IOsUGF6xom0Sd36YQUwo/PkeqaYl/6yPG7Ghr3K?=
 =?us-ascii?Q?0+TbmLZ9fvqEd10rZydfiSvqVTpwN2/2tnF9/7S75W1Kj5mnuRucxl5/+Vyn?=
 =?us-ascii?Q?ourbRXK8PQSCWnHsckm9a5hhnJWbY7VpkAqNmWH3tVUYprQ8aFnZDVJ2QUmA?=
 =?us-ascii?Q?FwsiUQ+Jf6JJn7CAatHYJbLDYO9e1UrI18DpUl6/gBBnqTvO4HaOu9NWMOd4?=
 =?us-ascii?Q?J0q1f+RprbF+PucDIweClgo0D9gqYQxLCF+bPtWvGAxAYyCBaCxbVZkkNT0L?=
 =?us-ascii?Q?Reu1WdrgGD4c7qOd5e1WpNWAE1U936H0j8FCSLPbbzy8SUgTksbeeIGMMi65?=
 =?us-ascii?Q?nDbnaB3CdF2stRCwrti8oS8os0zPjSXQxVz8zITftFsqh/95mwCEgRTFrfbf?=
 =?us-ascii?Q?MSoM7spmQ1oVdhE/lAQ7DNBVUvr6tiRR+FfGxbsoOShRrl7wVYGHhUz5U2i4?=
 =?us-ascii?Q?Q7ESOg7E4Epg14eaVXalX64CsvrfpjhFU8U/ZunjZRX0ELnUsWXGBfBtZJEe?=
 =?us-ascii?Q?VUC7RxKcNqoGS24LQMeBY4RuU5q4EEEh3lyJgD8MsmpCcMFRvRvEAWxcDpqZ?=
 =?us-ascii?Q?nRLUo9yEiIaFpNcrKqLj/yYxw80WyI1Qmy2J5ZSoE6T3O6DFad7EnmshKlEH?=
 =?us-ascii?Q?itv1+b4cEDKcFrj9NMC7feuhCOsvySNzdkMxeAT5yyzubXSQPOV8JK9WbaDr?=
 =?us-ascii?Q?oU/kIXGzg1+UhAeDEv2KNp1nFXZAQfybfBc9WuGYTBFqE1O9JEvHEXixpmHg?=
 =?us-ascii?Q?nok+NLERPDh3c30tN7U/x55BtVtCIyLtGYCle29dp0XIhlqE6BAhkOXSbDBT?=
 =?us-ascii?Q?6oFxVnEb7sYn3azesnjQ594SuoZCg+FXjVbynZvawiBtWK6B/X6bVN96wRlY?=
 =?us-ascii?Q?tRrGgwRqxB3P+/jevvLejH7WOBH3F701jR13YJNeya4La5OBEgBMSUa68+ZX?=
 =?us-ascii?Q?eZPhZQNxVVusbjGfBmMPyG5NLKqXblkAVvlZVG9p?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BzVU1U2Z3CbzJNCFtkfPqsXhwOllyw3HYsZABp4GhqZAqajDr6WCSzr/6A3/hbXM9OiXdQ/IuEAT2OAU8WL0Zpa5S4/rJ5zrbs2E3QMYIZ6//+QUW15XwUwQcyyEBaXrND856DFBTqDs5y68HtrTDa6HRWjeGGX4GKKdiSv64O3qI8J7/Br/x1J44q3mhoTbEX5su96LwfJQjx9npAsVWxfqJ2nUNdRmZy6FJAbPT1Tij00z9qJUEU7oN9Spstg7HSx1Ui09eWbCc4fKvyotIRTJ+HWbncpNeEaEsdcskgqA1EPeiBhUyl08TycytmbHX+xX9DkRk+NsslG2I5lJyQ3h01lni+QceSdgJWQt7qHGfmvrYzU5KOWz/ozRdX5NaqiGpfs9rAOF1cm8ksn7x08+iTeD7/X0z1HyP9JLILkv5JraIc4+kuIPeQBZohWHq1pk/UIclKzMDMqymEiSS56kDpZkk8J3HdD2VGGsxklo6nKkZ/ubjN3Mp84gQlGCqwIT8IoZDI+55nP+C2baLMDXfqmuggBipsi0rSQXm8P8x1BWh5ri1GFLx++p+gPkL6nRHrH724hGsJfegRFySs4jAoWHG9GUOjD08xsxvMxaGi2WGIj+DmC5nf3bEufqHmtDQJ1nOb+2C/cyhp4iyEY2UP/N/Grp7GWa1GHrUJ4AWDN7NjLyhFKXbE8U6niPK8XmnY/W7eAi5glWGljY9RNgp3FevhLXNGgfO+Np9OxEUYYoFoZXVVzD1dOBQNelHQuqXFVixvn1yyf5yE5g+Le3VTSWTVgOZXYlH/KoHBb8lSJsEJwmMX1dTmxu7nH3Cn1c1+2JHNss3//H/2OuKGhzv2duKttdOUlgDtAIQwPbP4Pd3BRqwiUdGk3tmblK
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ed7b16-de63-40f8-7b08-08db31308ce7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:07:59.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pei9ph2gJT79d9twqe7vKlUGkD4wjno8gF/GynvW/A2ocEzBhQAmKP2yuXS/8zpAWpObkBotENm0aCU5E98AEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_09,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303300119
X-Proofpoint-GUID: q7IPPc0BsXEyNqavjxQDe5fAEM7WNRXa
X-Proofpoint-ORIG-GUID: q7IPPc0BsXEyNqavjxQDe5fAEM7WNRXa
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6419265899d9 ("sched/fair: Fix division by zero
sysctl_numa_balancing_scan_size") prevented a divide by zero by using
sysctl mechanisms to return EINVAL for a sysctl_numa_balancing_scan_size
value of zero. When moved from a sysctl to a debugfs file, this checking
was lost.

This patch puts zero checking back in place.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
---
 kernel/sched/debug.c | 52 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..b5fc7e250128 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -278,6 +278,56 @@ static const struct file_operations sched_dynamic_fops = {
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
+#ifdef CONFIG_NUMA_BALANCING
+
+static ssize_t sched_numa_scan_write(struct file *filp, const char __user *ubuf,
+				     size_t cnt, loff_t *ppos)
+{
+	int err;
+	char buf[16];
+	unsigned int scan_size;
+
+	if (cnt > 15)
+		cnt = 15;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+	buf[cnt] = '\0';
+
+	err = kstrtouint(buf, 10, &scan_size);
+	if (err)
+		return err;
+
+	if (!scan_size)
+		return -EINVAL;
+
+	sysctl_numa_balancing_scan_size = scan_size;
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static int sched_numa_scan_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%d\n", sysctl_numa_balancing_scan_size);
+	return 0;
+}
+
+static int sched_numa_scan_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_numa_scan_show, NULL);
+}
+
+static const struct file_operations sched_numa_scan_fops = {
+	.open		= sched_numa_scan_open,
+	.write		= sched_numa_scan_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#endif /* CONFIG_NUMA_BALANCING */
+
 __read_mostly bool sched_debug_verbose;
 
 static const struct seq_operations sched_debug_sops;
@@ -332,7 +382,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("scan_delay_ms", 0644, numa, &sysctl_numa_balancing_scan_delay);
 	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
 	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
-	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
+	debugfs_create_file("scan_size_mb", 0644, numa, NULL, &sched_numa_scan_fops);
 	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
 #endif
 
-- 
2.31.1

