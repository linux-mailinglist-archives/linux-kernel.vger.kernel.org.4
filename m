Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316D0613E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJaThW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJaTg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:36:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B72A13D2C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:36:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJWZDf010794;
        Mon, 31 Oct 2022 19:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=MgHZ5FjOepLu/BslyLNPE49gEH6Ji1IVwBbpMqjwKeI=;
 b=n72O2pUkStLgoM2KfWOJN6GS5gE6DqjwGyj4jKPbIN87GfpFcxBMibd4hQRY2eADn9oi
 ggNcrHXqI1mzlIWA/cWOo8AzrIHwU9hqIr+ZlZf7oPFhcDpRYE0c/j9raj2e86BfBNVN
 dPk8f+xy7avMQg8hwQGm/fmePGaZYeBY9MINEdaTW4dkBT9wObGqfq54Ae2U7jzdsMxb
 PtGQH6zyGTw2bmxexMGBg5C5qUvcTNi2pOlRsqZsS0YIqHx848jySrt6QYbOSyzdE0R9
 X5p7lTWjPNQP3f1ajIstWMVpuyIWpd8dWwtWGd9SPF1oRbr+bNAkzVqgZzaGbkAVcrgX Aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgussmu4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VHTiY3032881;
        Mon, 31 Oct 2022 19:36:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3mpw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBL9MvbIL7h2RVO7ZwG+yzWlg6rNPvJKTV3UspWZXhr1xkJ6uuP9U45WXJNf/AkWfyoaO8EEvEVJ1oAc8Y+9sch99EydhLQnIbLRuy7fJyJLy3jNp/bLfaMWA5Og8JnsM82I58YJ8XJBpIPTtLIToizQoEk97pQ0YYxgEFiPFYtrv7TtqvYZst2nnB7YFxF8V3Nf8IX1mg5a658Jz7WtCccz6Imwpu1npFGVsE1twR8FHLpYTsoOJo2quExEzmE42K4XdoY9xe1NvEGuTyFvmClSc+AS34ht4wpttSd+qEAJ19CWyDPpN4nQ+qa6Up3FomlCB4A5/qcjrhHFf4R9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgHZ5FjOepLu/BslyLNPE49gEH6Ji1IVwBbpMqjwKeI=;
 b=a/iUtKZJekvws/DRDofPuTP2IFozkRPXqS3/iD4aBXCCr2+IalwKO/0GNUC4udHH3i/dJbeOENDUJT8lEP81V+YYlUe+4aeOVigWwueacfoG+xEPH/ZfOsgT91iMjHWGoQvPGCyaeXZ1XakdimJilFmV0dY3dKxp4Mnry1qUduuaNeKCoaHnDsmCsqv7ZmswwQEoqlQJ93jQKitzpdogW3+c31tYNgNN86NbWJxDlvcjaKVAehmE+CZmxBm6yXskA+6PJZj6MzxdNbI7Jf1d9RBfZzaEnkeECN3zYtCNVhcqgnOlGpQFecG/OGvsVadjnm8YjMcOWV56weYldmBnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgHZ5FjOepLu/BslyLNPE49gEH6Ji1IVwBbpMqjwKeI=;
 b=pq+bA9+Hn3UYOGW9F4L6NjfJK/ZO+uHaXCDIUpJ6YackYSEDmp5Y6Vw2a+itKjhMiodiBSppwBT8P7KzXueMo8GtDkC4Au09LBclSJ97h3zdlbmEk1KlGEOrL5oVTpcJNDU2E2mxgzjk5mO/GV4sv5RJm7T/ymKMQ5YFF90lH3k=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4228.namprd10.prod.outlook.com (2603:10b6:a03:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 19:36:22 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 19:36:22 +0000
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
Subject: [PATCH v13 4/7] kexec: exclude elfcorehdr from the segment digest
Date:   Mon, 31 Oct 2022 15:36:01 -0400
Message-Id: <20221031193604.28779-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221031193604.28779-1-eric.devolder@oracle.com>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:806:6e::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BY5PR10MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f686fc6-37df-4ea6-fa45-08dabb77310c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GE0KFhpHrfd6qY7YB7tNoJmYwNjnHvmrPgYKLJsfkv1aFlJuiYyOxeJb3eSryiCivXVfDA2VGULOJ3J78I2jRAHPFR6+cRHivQ0AJiQBvCbeJBnTNbugBA+RE9Gl7XitroznV4hCTp9poL/i3fwOcdYsvhx4WfvmFm+QvUykNbwmJ1fgEnSxqN9RfQ4tBtUqAYg+G3MY7bwwN4lUUrWWjBFXNnf+ak2D4g+PxJYmOa5MSZBn/of2DjYyggZvjQZUjvhbdgvWGvoUp8lzMoxduN7duDWp+WlyEy1CCALfrgmIvA8C24lM/FSngbr60lwkcnfRWIb+aWx+1WuJCFJxJ+HIMhzIrhMxZg3OnzfqQ0lSRZFJgOZRuJGMCFbDkVWfMrKfoB31bqvbNzZ7srGqZHGwy7s10iVmweBrERpOW0AHabf57TJPb4OyW2EXkZJAKJL5JKH1fmjkfHV2SMd+AxkrLFjxUcj7KXywnczpZ2Hc0xhtOTTK7p1Csg2oHHAp9ADFAhed9OZqP5laGZF9UloCNnfWSKVSZb06ESz9c6BFznN1q2NLQD3Jr5g1tqoE+Ghz22ie1J4AjpaKGFNdw3ZjSgSb5DdM589EY08P7T09QfHa3CIR+Urlh52RIqYLv3Osmy31ql+gUR3amQeYdttHvhtZ9gygyt2D/OqnopkGbHid4OUR7tTT+pI2Jx1S3ynj0HdCGs78StPkEYPsNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(36756003)(2906002)(86362001)(6486002)(8936002)(41300700001)(7416002)(5660300002)(4326008)(8676002)(66946007)(66556008)(66476007)(316002)(6666004)(107886003)(478600001)(2616005)(1076003)(6506007)(38100700002)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eTWiOkdi6Z91f32Kku7E7kIf3655dWJ6eJKt+nUS2FBXom11PO8aeSjkFeo3?=
 =?us-ascii?Q?QAOeT6NhZlwS1I6pB+4/EfMJ2O9Fmb19izXSX5TcEPGKjgRIRXFNr7Ev+fE+?=
 =?us-ascii?Q?MtQ+21NEGqDtP4lfeOxN5YR80tmAxO00+z6eKC+ojj2f1xpKNVdK0vi9OKh2?=
 =?us-ascii?Q?ixoPEGgZVak15bAi7NZw+mbjQlc45lFLK+prZ35+tMfXWKyooq9xXmTST36k?=
 =?us-ascii?Q?b6aM7OctkaK1BAwhumAzK+wHcVVBxOWQYHl1CD21pUh7u3CLmvhUt31b2wd1?=
 =?us-ascii?Q?nLBwJhQrj6t00oOi4UUeVpXHHN3jVAIVoFKLUZUILXLOVbg+lZOO0pJ1yFam?=
 =?us-ascii?Q?hzyGLxpW/XhohhSMsnPFF5QUd0H0jOtdATwP6hPhTaWo6HToh+euQJk+m1dS?=
 =?us-ascii?Q?q5dzPJwRRMryUJ6VjVnCK+ghiH5HKmFWZoTPjzhI1mV4jnStXOQjtcFm2PLg?=
 =?us-ascii?Q?6yG5bmARiJXL2GWuj6s9Tn36/U1nHvWFoqRQujoa2Bg7UXKcPzkkmkM4kZTA?=
 =?us-ascii?Q?3JbT4F0skGE/btPQ1bNOaduVHMOEkzmJkI/vd0iJ8yaa+Kc0wkHZvksG8Q3x?=
 =?us-ascii?Q?84D7wpkSUTmNgiVYbhiBpplJXYwno8+tajufbUHsKSsTlKm90nwf3/UAsv7+?=
 =?us-ascii?Q?krmaDEMja5VaUubZxoUDxX5nThDza6sXNoJZqDVLA6aBDl8obQefsyNAS/D1?=
 =?us-ascii?Q?KWR0oi7gY8Yq/F8BvE4eTrb3n/95kJIqI/sENu0UcyzI2Jr5cUlOxgpOuzKv?=
 =?us-ascii?Q?gbs6nK1ZQ/IfkSNuTcICRuusB1IrMq68O25EUcYwsHwHae+h6FAB8LtCDf/1?=
 =?us-ascii?Q?U0owS1D7tgU71YTUo+E9ctVfFk6oI6m/Livi9O4yomaYHuNq3p/wNHvcdQ5O?=
 =?us-ascii?Q?gfpFfzDHh7LboR6vWfkIO+c/2KEsEuPAhMnb+ewppqfwMNnGOVDPpbE5i2jC?=
 =?us-ascii?Q?0uVJL04JocMOjklVjTVvm+5ZpoCcekY+f6ZYC9grRBIEvD898568Uun1Uqc0?=
 =?us-ascii?Q?e1Z6oBm4ChX9uq8Kiy3yAZolxOwyUEdag4VIr25iBqod9ocpzrmrWEfKG0LB?=
 =?us-ascii?Q?JYXdqEoRCbYPSg3hpxSgOS8fKl+SPtlkufYSxW8Vy7/GyMagDKUITEU9XHJX?=
 =?us-ascii?Q?UG9nFMrIdeOUOiBs5Xy4GbyHqf9sRwXvmVXpADfu0QJV2fY0K+mUkabk1nxJ?=
 =?us-ascii?Q?HLwlfkz+OPhsFLAOcR8u9iGkp31u3E2fnBZ91SajF57NmbQtTXzrDuWr7iU2?=
 =?us-ascii?Q?wd3RyTtfQl9KwK7L7VOFQ8djCC2jXyOWngkiqkApM8oQkoRSyddHZuFBR9EA?=
 =?us-ascii?Q?LZ/54kj+RzmwESx648gI3ppjL1BInSy9LlAW+Nyy9e/qaYV5b5y3plol4hp4?=
 =?us-ascii?Q?pgUBU0/8ePQkw9zqVAej9DN+yS3mVgOWJVlJMgsQ8VSC1Qb6UAIuSCFoEYGV?=
 =?us-ascii?Q?KDUD3TUTNMkyBKoAIiGVDH6Ek8wwoZTzeiQHwNIRue8y0n93WiYLBHSm2PGj?=
 =?us-ascii?Q?+ms7zkJFCuYxqSYgg/TJ4nXDvbBxzteDXixOJ2wAXy4vOrKY9RsqRU53b6w8?=
 =?us-ascii?Q?noQia3selfYQiDVTQKc+U2VLhKRgv3sTpqUusCvCTwRJVuG51Vum4YlDEj6I?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f686fc6-37df-4ea6-fa45-08dabb77310c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 19:36:22.7271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMR4y52lrXdheuiNaEfgl0jABkHwEneeYbiHGSWQK/Mqk7zQ0UWDnUGddHHk7mVDgBfrOEYx5uM7628hB06EvTfLhdZTKaE8mwbQfQopIqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_20,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310121
X-Proofpoint-ORIG-GUID: H_eQ0N7lDN9fwgbf_ensSii7eJ15xs8B
X-Proofpoint-GUID: H_eQ0N7lDN9fwgbf_ensSii7eJ15xs8B
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
index f98d1742872b..4d3451cf9f0c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -723,6 +723,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU) || IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
+			/* Exclude elfcorehdr segment to allow future changes via hotplug */
+			if (image->elfcorehdr_index_valid && (j == image->elfcorehdr_index))
+				continue;
+		}
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

