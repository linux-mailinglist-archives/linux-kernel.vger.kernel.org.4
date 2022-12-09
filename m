Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B590D6485B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLIPh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiLIPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:37:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062902B2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:37:38 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9EwsGj021213;
        Fri, 9 Dec 2022 15:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=mijXuv7oHiRF5lvBg0NKfhfXlOiOtyS505PIT5Fw+o8=;
 b=o//vHPUn3mrCPRTMr3yZ7c5MYohNrjJ8sb4toV3vAApe8Z+nryeOTTpprIpitS+SQ8Qs
 8yb2ijZiiGuJIIyy9YY2KYBbqOYldRk+aIHrsWO6/ep6NyLwHx5mC2m2fXSg+LjRIYLp
 L/IutmOW8V4OyPDVXZsSpxZ9bFZxrbZrizbJthzhGZqmgTZCsJRYtCmuGS+YsHidXBgj
 h7Yfu8o7zz87jZWcg4+D8CpBa+0t/9BVEj2h8k77B7xX+wqQshTZNensrkUGicQab1bD
 4RluYhWsqWTQyVXsAMYvYMOkGGjos0akuUaSmWde/a9Cj42zlXTglb+MCGsU5llgSTw+ RQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maujkn92x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B9ECi3m019003;
        Fri, 9 Dec 2022 15:37:18 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa62ppc0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzrDhB0m5k+amv5ZfFeBm6EfjJU7FmNns9IO9sWPBMYjDlxGdDFjCREfvxiAcL4b4ibzw3yOifxXdzYbXWuf3DZNnC5xM7wvI4TykaLJOeOVgI+B64L/yDVecrkdDlLNP9gs7CekOqLV97+EPNN9ozMi2VNwuM63D0r8QAQfsike+PGGH2ZfsLgfuVNbzyYl7yjYIZ4fCAuz7iSCICjmCT8nuV97nKWF71sE3BM+XeMlwt5uYJvofLKerlgA9rlvFx03PCoA84ImvKj0I1dyhXT8iEAJKvqvlxFdyDV9z0PWi9usyNd53JPzc9va4fw3iPJ5LEH3kVhIgXFGSdYTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mijXuv7oHiRF5lvBg0NKfhfXlOiOtyS505PIT5Fw+o8=;
 b=DG7riG47lxS3KR61qQ5p/H0AoSG5uqUtsPycjehiCGvJCrEePg4dzpqjLaRsGoCce+IiKyTLBr5SicOvvzn20ak/g+6wa7vWQnC6wyq8IYOBcJR86RG1JQy4kYLeWklKc3laRYCpttrznOCv002ftaj0S3mrPUpYgOurT2Tzvcpr6x0HhojmfYaiGptl846bVw5Q2Uf5yVPZXABr+X6NoeMrHqWtr3IRt+WpZHefb7lEX9W3Zo5FP3H+0ugWte6aSe/yzJSqisKVc3aNVKwtZ2jYkQzeSR11tDsN9/RMuoGIeANv3KU/QU9H7RtWU9EypXNBHYenxuj2ZmhVdQwYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mijXuv7oHiRF5lvBg0NKfhfXlOiOtyS505PIT5Fw+o8=;
 b=AElywR1oNGTIkU1gayHOkUUooatTZWRak17f8v+6FLm7+Pr4yw5vhaDoDlgUsCitBwc2yyAvtuWiQQUcgQUXQvEjzefLacZ90E6mpkmKsf5NuejJ8x2PvbReTwUUD9ZViByW0NF2v6h1yAglEsQNzS5wLtaJ07cXbMXBS1h9HIA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA2PR10MB4666.namprd10.prod.outlook.com (2603:10b6:806:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 15:37:16 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%9]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 15:37:16 +0000
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
Subject: [PATCH v15 4/7] kexec: exclude elfcorehdr from the segment digest
Date:   Fri,  9 Dec 2022 10:36:53 -0500
Message-Id: <20221209153656.3284-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221209153656.3284-1-eric.devolder@oracle.com>
References: <20221209153656.3284-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0157.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::12) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA2PR10MB4666:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b6ab53-4a0c-4a01-ac05-08dad9fb3ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Q6U+VjyG2Q3ZbOCbploOKGXqlIlii1QtEkLvVSyPdBToDo163LpsiZP6eYn+FIlxY3Vai/c49VJO4CPfI3BR7fIp92dxR/TS9P02sgEcpKSsRyt/SNjEm5Fgty5qaS/rRiNmyRH96kQdPhCeLUqMVqo7QB0ono6lmYnkpJaHsT5YsZEzk5hM4pqcK/jkARdVVmR0WV/0bpNLxgp+KtRFzkoKj/bA5wpHQnEmfId/7NKRKWYfRlLA3Ou5wl9XAsdTtr2gCWwkgmMw8H3LE1PK0JJPPp4AkfaJ+w9Qtu9dfHao1ztek/ElH/C2KuysllIkIox/cNYs3v/A0iB5juEm+eld1b64wzlIcKz/x91UvHWoKZTXMZMCYHD18fWmvFUcwBLXlDLht8wbkbYjrYnzniTTKFbNe/8uHbhUROnDnkpHffbdgKYxn642I0fn701alolGj7DftPcBcCXYwf3IUWJe5VGUJ6R+qwoHyHI5MAg/2BcwsETiKC2csb1AbO8XWM3p2wy/d9EggCyhWjoem0GMtwerzq3sbC8lkYVZ0lOVhlQ93KBJ7cFWJBqaWd3KV/52vOGPh8KSolaUpIeRwf6h3S+JB/UNjoXjVrWD5LYGzQZO8V3GiinUY/Mz1PdUEIKagyRojGYhudS5dgezA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(107886003)(6486002)(66556008)(6512007)(6666004)(86362001)(66946007)(8676002)(478600001)(4326008)(26005)(316002)(66476007)(6506007)(2906002)(1076003)(2616005)(41300700001)(186003)(38100700002)(7416002)(8936002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eZUCWSpHr0c7a33YTrdZeK6/dUpmdFCL5+wrnTJQMMmdzJUfYHcrOABD/zwt?=
 =?us-ascii?Q?AM8DKO69WpgiEc/YpPycKI7QXHGec0WRP5lBCmX90mAStHQz7Lr+/e244xTF?=
 =?us-ascii?Q?cpHC8dNewKAnEt3yqA7nW/1ocm9u/scCpVhz4HHUCOAz1MF0BS5nOf3Fxpx3?=
 =?us-ascii?Q?Dr2YCz/3kwO/RoxR6XiIks9gMdgpWre4H55zILhBqD6F21VMoPQAp19Avz2c?=
 =?us-ascii?Q?Vg1UZNxtDVlFduaqqGU/5TyyA3QvMJA90EkEPmCIJfrRxlLdWWz3+RuFW18C?=
 =?us-ascii?Q?JVuFH8XTT1p0p7SENhFd1YzROX6isk7XiTTGXdJ71BPkIvFGeednLMt925kP?=
 =?us-ascii?Q?bORy6pHBQYCJJ93k/6OUFaeiG+FMEZYJNEUFJkeAPVOff1mPl5D0Z7lCen5s?=
 =?us-ascii?Q?DeDPzudQEm58tlAZQkOKGqjkTW2N4WHBoAkODmkGdEWAXlytsbxkAsGp8VZl?=
 =?us-ascii?Q?jekMvGuD/DHCEiAyX5iz4ORfxMn2OQLHpGzR+kkuwYXA7fB/+AM+1yP+21hN?=
 =?us-ascii?Q?GTILbK17GK2t0kTXmrutRw+WbNdt8wmkw0tpOUhAn8lZJGTals8PP/AOo+bc?=
 =?us-ascii?Q?v8WoWHbcT2iNw8wkbFefugjXN2m7MDd9JApV/K8QBuIaTlPbVIVqjKFB3iXc?=
 =?us-ascii?Q?lzhPm/HZwHU/QM7jezyC88gEKi3f5LSgk4gt/bnOXraYoSKI+OedmuWVottw?=
 =?us-ascii?Q?ujcbjj1Oxwo//TbbusSS2gzhrpvfCmFSYfFi6YJdRhF6j9/nbnA2eaQX9HCw?=
 =?us-ascii?Q?rdlrlhIlsXT7O8CTlF92HcrajxpmgOEwrRVb5PRw1SFPTgAzYvoAzoQZoYKc?=
 =?us-ascii?Q?DmLxehCWGclrsTQv2i5Lpn/9idZq+oO5Dpun6a+pFKd/VSNGP1qihg2nHu6R?=
 =?us-ascii?Q?Ca4M/CyeHIWhRMmluCsHMszRKEV0jaiUXS9tSFnQs/dpk0QT7N6H6lEO1M/c?=
 =?us-ascii?Q?tYhuF8CDwVEXqCUi1BQQ9/IDHNNHnI7s7jtDAhWWIUQYSM/CqWLQI2d4fFaH?=
 =?us-ascii?Q?Z6p6SWJLvSI1pPr9ROO3AIjN4lKLPu/DFSFs/X0z4bFxb+zVe7zev53faTxk?=
 =?us-ascii?Q?hVhwiNuL+u9NQCLmdwmzRjKhUPSnxGsfpz7u/5UOLGy0k3GLIKN5LDtq4Kxr?=
 =?us-ascii?Q?5pALyvqe33Q9uDxOJ+tg9sYupfxlJIzckZ8aJ9rJBRF017PVfeSPP9L/pcvi?=
 =?us-ascii?Q?ycmUIEn+xY3woZlYVbju1YA7iQo4elqoW79jsmXapcT0eQvYGyFzJsEJHokQ?=
 =?us-ascii?Q?sLzos+tBlCcMMYgyMteV/6BsAaCxsp2cHIOA833E4pgcWbCIvZ/b2dFUBN/c?=
 =?us-ascii?Q?WDz6KJDiOvHSyAxUg/96D7iaW5QaJAVPP9NdlUqV2+yEZb6yuikMISz+JzL9?=
 =?us-ascii?Q?00YuhVKYbokXOwMKdBBKpV2ri0XU/oU+n5r9GJVGBEc3E8lDz1g+931/OFwH?=
 =?us-ascii?Q?Oi+2V5YkSE0V00Xa/20tGUF89y68vdB1ElP6mi/SXOkS1hkv1PFDqyAdhLcq?=
 =?us-ascii?Q?1eA0YBaPeLMnhiyS44Tvw/Sr+gLxwSHuthkOjdwUXl+SEI/qTNSj+OR0Yoq2?=
 =?us-ascii?Q?55hWyuPYFViTezXblI1LSis3n3Ela02Eg6iLKZNU/6iiznqfTfzAvEb8w1je?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b6ab53-4a0c-4a01-ac05-08dad9fb3ffa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 15:37:16.2101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaqkL3a5e0Zktv1OHZQ8vC/bHKhebFXwRklKv2IX0F922WSu0afCtmWhxM9BsFKIDGdkfyb16tQjwd03VfPSmpbX4VkDZmeA1GKHZo5rPIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_08,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090066
X-Proofpoint-ORIG-GUID: uWy7Z9OpER-vsgfarcWdUE9bOtkQZJXQ
X-Proofpoint-GUID: uWy7Z9OpER-vsgfarcWdUE9bOtkQZJXQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load() syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. This digest is embedded into
the purgatory image prior to placing purgatory in memory.

Since hotplug events cause changes to the elfcorehdr, purgatory
integrity checking fails (at crash time, and no kdump created).
As a result, this change explicitly excludes the elfcorehdr segment
from the list of segments used to create the digest. By doing so,
this permits changes to the elfcorehdr in response to hotplug events,
without having to also reload purgatory due to the change to the
digest.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f98d1742872b..cc976948f17e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -723,6 +723,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Exclude elfcorehdr segment to allow future changes via hotplug */
+		if (image->elfcorehdr_index_valid && (j == image->elfcorehdr_index))
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

