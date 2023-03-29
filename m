Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968846CEF4D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjC2Q0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC2Q0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:26:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEFC1AC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:26:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TEYXPj026864;
        Wed, 29 Mar 2023 16:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=QC18BKaejuuEYvVjuFFSQ0LpOT3I984xzR0SB9eQ2C4=;
 b=rvKtmvDih6L/eQO9MhYFiKoiI4MQxYE7RASgFV6q3HCHd1Dw7SGkXWbQ0twEXYyYd3Qi
 Z6qUmowTrAIXPG+hsaIqfqXaPQeyDP8AxOI7sP/5XSRXbeEZRxa2QpSK0QYAEJSlexXW
 hb1XNMdgKcJaIXcl0O7igaco0A+JbzBF9IzMAscOcvADXx1efJMOORaUdMe4PztF6U2L
 azODVvltqDd/l+gpUXJyN80S74s0FEOuIhLT462+/HEp4F4isA4REjdkdaLWKWJ4uj2T
 GuK6rGgizJaX5TvNSNRwm0SdOiFdp7e2GRcHI0ivLBHbi/hq/ZOXS6q6Hvvi+4TgnRY0 mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmq798ava-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 16:26:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32TFoTa6010782;
        Wed, 29 Mar 2023 16:26:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd89rur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 16:26:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ec9WpX3RqOi1Ky3fz7ITrT4Md/QIQPl5YgHN5sXSmjJJlBHoJ930yitQEWqgsRT4hDa819wa3TmHeYnVEtvD+Nm/LPR8es/6z3J40JoPS7S2xGv3arYo7Y3cD3WZGrCPdetkoqLtaYrlS4rjx3ckq4WNQ6+86EYUkhoH0dRw61Bs4QjYk9LBs01Rmy+9D+xkLr7PomuRLOHfLHgSQaMtKtjtVAOkifRkaKH3fookUBX7ekfcPTRHTVTpgIgJSEbGv8l0uFojVeBurSICH3erDP5RiICg5mYssP/ye6Sv0lx8dUtsxTkfcMXNZhmOOP2lZf95Ti/HpfVIkfAxJk8+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QC18BKaejuuEYvVjuFFSQ0LpOT3I984xzR0SB9eQ2C4=;
 b=iKbQrVhk15bvdWddP+F0jP4AnJ5oZvAF9c5yDLmeSyt5KxQeq+lxX4SXXpWjhgaDhAmRjFMmSOxai2MtpMzdbO6lHgG/oQ89PgSOgCDbZEY+BaS4l0YLiDb6XSDWtrdOiea7gaWHpAEAGd5k/G4sE4iUEHrg8eJvBH35/BTiKbC/dTzRHe9vQgGWdL9FAgcJwkZPmf5FBH/bpMKe5gt5Wr+/8MtLVJvmJcXAP5cCmifGTKl/WJ+fCNHF7R71FuAl1jpWUup29Y9FZYMvplsbPqF/3BP+MzHMDvOqS7Il3rz46cO6tjt6siDQVG70w7STdXa8Kukr4dp4ERcFXV59Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC18BKaejuuEYvVjuFFSQ0LpOT3I984xzR0SB9eQ2C4=;
 b=s2iqAP4q71OLzJXj6XOiDiXB2+w0Y9RTarVWFX6ekXiHhffhDxxWBGe6aI1PtyY/D5O0vRJL6bjBZHCihemUbwYoEy5uBj2sQepVGJgxWzj0FbN5wSUkaO0mXk4wySzjhGYMXzlhQfbRNFXR18H0jBO4vgNYbbUh3DFgpzj6pUE=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by PH8PR10MB6479.namprd10.prod.outlook.com (2603:10b6:510:22d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 16:26:16 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73%6]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 16:26:16 +0000
From:   Chris Hyser <chris.hyser@oracle.com>
To:     chris.hyser@oracle.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Subject: [PATCH] sched/numa: Fix divide by zero for sysctl_numa_balancing_scan_size.
Date:   Wed, 29 Mar 2023 12:26:10 -0400
Message-Id: <20230329162610.4130188-1-chris.hyser@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0248.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::8) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|PH8PR10MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 579cadfa-7b9f-479a-0313-08db3072520b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjXnCcJoFAxIYuojwCVxuDGti9vj114PALHcJCj1LgtrHxOzcQ2dR4rTWXAK4kFur4fVQUpEVznXv0BdmV4EasGcN1SCXgibD/3L1PxCPYC1AqkJsyE3/WESlhgSz4bJlmetk19uyJrqWJFoekkENodtmU9qtfh5Qji2IZEmcrXAzS/dplQlfJ4nlwhh0lzlVS1PZxr9P/zXHt1ZjIMM6qhlUv09jPe4JmlgEoaJcpjalH1SbJkK/APHtZNm39YFE7n9R7yh8UycQ43CVTQ9Zc67lStuahbrGZj0U80jmRNM2YjAahxBzZEtHyaL30Xv0OV+DxfL4qBJG64uBKSnyHhrOZJ0Yw+dtAu+FkNvcQkko38+ME3MU+xdcjY/CSlab2S2OO7C+XB8V9PGxRB86sk4tG58GiKhTllDe19jHjZNN2gmnG0kWCYU6PezQAa4qg8+DCpR7BIwYiGUXjnXm3EV269PmNGVedwRuFgdHKj3SQw1eab4pjvGzsYWbUIRRyvYnhridLRv53EU/ut5+pjw3EnqryC5pTKuJ04ZGo0GjvQct+5pPP5sQY5TK7jc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(66556008)(44832011)(316002)(41300700001)(2616005)(83380400001)(6512007)(6506007)(26005)(1076003)(86362001)(186003)(5660300002)(38100700002)(36756003)(8936002)(6666004)(478600001)(66946007)(8676002)(6486002)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sv2Hu8ghK89a8SJEJcyC7MH8HA9dYwrXD2AzD4YgKTOPvuO+e1k1MM40P/J+?=
 =?us-ascii?Q?Q82WUwXNp+8UbZ7U2gq/SqX8Zmmzg2Kg++5oL6Nm//eIMARSOU+e9brkxHI/?=
 =?us-ascii?Q?hhAH8i/z+ljP9btghzWE44kGExiFC33joT3oaB3KDIo1wRGnqNHWPVddVr0j?=
 =?us-ascii?Q?4LD2K+ytfL6MCixp4RbWh0BWSrD3PpprpU2Id9+6Vo16UfD41IC9j+LDGfW6?=
 =?us-ascii?Q?KDoD8JQu4luA45SjphIdEQSFWvTB61FR7kZh2b8R72mFOgtfpug0LfFvED+L?=
 =?us-ascii?Q?2x4MiYyzjzWLfdoi/fZuU8wdwhgghzkIXsMAUL0uHAiAC/tfvhELitPo7ivi?=
 =?us-ascii?Q?bOVl9pnuV7b7kLg2reofip1aPQa56qZdlXmbEwwkgrMrzPNmpCdyv4HEe/tx?=
 =?us-ascii?Q?hUR5FwriZSTpJkckvOt7nsUNFjlkGoB7c36YcTfZI31LBDe+vrT+KyjUAAd+?=
 =?us-ascii?Q?/epR9U8+R5JZxOpWg8imXBIKl/KeBBj3IZtl0OT0/gNhdWlo2N7syipZAGtH?=
 =?us-ascii?Q?KyCqHhw4pmwXjop9xOgMgs96xzYnZwFWLZDpN/ACLOn3dsyqA1grfDCKN6Qu?=
 =?us-ascii?Q?6eUyV/7BbreCzSZcRUpLBqTIsTH5Io4coMSEkRuJN2I2kCBPNrVKyApB7LOF?=
 =?us-ascii?Q?vo9yZP573CPWr2Dy5pJ54w+EeQvgS/JaSTEYnRenfJDJG9uC31bKghr2niJA?=
 =?us-ascii?Q?Rx19cNCb/+e2K/AN59STX8nHLZyK810Y75CvEKq0Z1eoOhN+nZV8rgWSPDAj?=
 =?us-ascii?Q?AJ4UQbiJIP1hP+ZRx+9sBC4iWbvfRmKGF+njHqn2//YbeLgTI1A2TICo1sVY?=
 =?us-ascii?Q?S158f8W51YTc56LZQx++XiZtHIQDgPZFZsUT7ogXjILhbgmRWILpEvTpPzOR?=
 =?us-ascii?Q?Wf5TZ7VrkZ+4ZkwUssgndhyVS1COjYwbb5TGscTFSsan3tIrIi1gFjCZQu7y?=
 =?us-ascii?Q?GWEDHNQB1dRV8h4WgPVKXH7tNwa4Q4qVZDdFDQURlAiTmfTJ79pXai0nhTEA?=
 =?us-ascii?Q?YSp2nDXdiJ/8Px+l5ywNZWvwHPKDgiinPrs+i8XnSN0psuox7DnE21NxAOoP?=
 =?us-ascii?Q?IikrnDhhjPX6/uTr1YZ9wrMQYMuDRW6X60WOakp+hve6Iver48ylsvfJ59Sa?=
 =?us-ascii?Q?mz57fhhLFI3BhrTErsbl3vBDUVSAg0QthR/emWDB4MNmBYcKb8OP93G5Ef06?=
 =?us-ascii?Q?tb55AV9JJaBHOWVZ1Tqf5DidS86aK00ZaDt9tdXci4GpLzXNWcswCF6QKHcI?=
 =?us-ascii?Q?YhsfhlVwwxAPIFv8vAzweIWsEA07+VxfR48APRA/1Us22Lketd9qo+OtDeWu?=
 =?us-ascii?Q?NJETkYhFwzZZVZ13ZYxI93DQTqyJh2CtNxUWWTTKDPCtVpOIrW6L0rKn7C5F?=
 =?us-ascii?Q?iTmGeHnIIXPuZOYoK2SkqJpmp9bIxTTRhADMU4hIco0ey8sNREuDdMsMJqb/?=
 =?us-ascii?Q?lE5ZysU2hd9U1JP1XzD5yEY6A9J1+pyXFiQBDvPd9DQyRiAzCgxSPuHCTHRA?=
 =?us-ascii?Q?CuHIVFCyeVUYfj/GIiYFG8+/0XxSEAdhWpo8dlVYKRgzRjDjhFNhFy40G+Mm?=
 =?us-ascii?Q?pg5DHZGq5ZQvrFXYWWz8Zuegfa1G10TcqeaCcwQ4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d3wsxyr6YcFJ2UDr0iNeNR3KEiIN8qhVcEKwM8RKtSvLk17gIdkNSAd5xoiIbVMrFGbjL2ysizpeLmpAkW2U7vbC7z9GlSAgU6oeUsPGDx2QSc/jyGGMYdrJ/tS1BPH58MF9M04UZIgHrqYSn+WovHFpy1HWPdGQcpi/516/g743WExmoT6aJ1s9tDY1847hWzrKMPj9iEXnp6Zoxq/D/jR0L8P9018OmmCIW88y7rmxOFguvJVnrnZRYthT5eVB5DiBNEVh0LQC+IHKkVsFI3vFV14Mh0d+RsF2/YcyLd+WK6Fbnbw3Md/Sjx7Juylf9pG4WyfxqOAoq16yuk0XikmAt4C0EI2j9hy3itxh/nxxkpRBX3MTOHNVZQtbNFOBobc6P0UfVh4Q9r6ZHIUYcGHEFZIBE0V51VdrsQxxYMZRSebrXsrwdJ44R9Ly6EiMwdCtHigR6PwLvABxTkX6+exV9/7KsMfr1nY1CV7yOfaora7XVoQN09hOuePDuJIHRYZftv/wAx4IICz5gKdza/dfNIYGu+E7teypMYPEik7cFscTmimXbgoAxS4xhrrytFuv7iNJzRb9wem1KcUk80zqrO3YyVI4MR+I1+y8DdnYRdmmaiHhXiGl8pmu0hbX344jBHb+d0YNQ+VXriLMCIrx3Rb7A4qZGu+nrTeS+tDlwnpJhR0UM5jygGFb8fn17RuLg2d/abPXDyrUp4uIYFPgANaYGKr+uHPFcJ9Jw8UQMS+lHa1baygaFCe5rnERkYkspl/dvrWoFObjmKvmSVn2uB1oMf9+isXC9tNNS/Zp9aMvxHQsc6QCtGH85wjzZ7e6rcQuAsoueQLyi6HH3o6OeXIu1+dXR4q8cIJ93So=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579cadfa-7b9f-479a-0313-08db3072520b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:26:16.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgGrHilNFcJGWFvh/3NANi5FOPkgDgWOSpmzHCo+/kULvSyYxA7KJDuHJ4NWcbLL+MpeLE+soCjLAhbPOrdNYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_10,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290127
X-Proofpoint-ORIG-GUID: qTMdL7WfNzboRB-RjgBQvzC9wv4buwOP
X-Proofpoint-GUID: qTMdL7WfNzboRB-RjgBQvzC9wv4buwOP
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chris hyser <chris.hyser@oracle.com>

Commit 6419265899d9 ("sched/fair: Fix division by zero
sysctl_numa_balancing_scan_size") prevented a divide by zero by using
sysctl mechanisms to return EINVAL for a sysctl_numa_balancing_scan_size
value of zero. When moved from a sysctl to a debugfs file, this checking
was lost.

This patch puts zero checking back in place.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
---
 kernel/sched/debug.c | 50 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..dfd0fe6123ec 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -278,6 +278,54 @@ static const struct file_operations sched_dynamic_fops = {
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
+#ifdef CONFIG_NUMA_BALANCING
+
+static ssize_t sched_numa_scan_write(struct file *filp, const char __user *ubuf,
+				     size_t cnt, loff_t *ppos)
+{
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
+	if (kstrtouint(buf, 10, &scan_size))
+		return -EINVAL;
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
@@ -332,7 +380,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("scan_delay_ms", 0644, numa, &sysctl_numa_balancing_scan_delay);
 	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
 	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
-	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
+	debugfs_create_file("scan_size_mb", 0644, numa, NULL, &sched_numa_scan_fops);
 	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
 #endif
 
-- 
2.31.1

