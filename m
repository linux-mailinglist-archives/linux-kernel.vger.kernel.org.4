Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDF96F897C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjEETZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjEETZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:25:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F202D7C
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:25:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhDHo020188;
        Fri, 5 May 2023 17:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3YIlBAFzfGCQ5M2VHn0qgaBT5Vs2S2TInPApujgd1e4=;
 b=WXjlu9uMeSOSmUzAG4GK6/MNdm3aXPZZCfpRu9OXpMK+OY6zvkQd5LQNE6zkIWKq3bAs
 04DYkwC6NXxgYECn9SCnT2HxcU9LgBDl+tUz0+lodL/rmJfpACrG6CpFErbWvbwyyeol
 QheSTnVCdsu04PRWGCmsDKil90EkV83/Lzm3+7q+LO3gTcIWI5A2E56x20ybeyOUJJv5
 X7J2Wrmw7L5ybkzrdG/bQacR/xfMyh7D5FXRu3KEE3a5W1u2n30vmfr1EcqrpUwRyyQb
 oRchG5vf5EfQYy6w6rwwGl01/tgZBcMhnUhckOMkhRcX/GmTAaCnFETG7W2bKmgIcMN5 IA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv5cte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345He9fm024982;
        Fri, 5 May 2023 17:44:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spacjj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emcPb/U5l7Q3PL0DUjrZXpSSUgqd/E+oP8k6gsQMrnuUDGNIURB1s4XtjPsIKS7KLYILWtGloghBhz3T8RGe9dsxp0zgrxdRt9aOLZ67bBpaGiBSeWUq6fybPojltxEv3ro4qz+29o+WCT2moPE9+WLOu1QUp8UnyRo5C1SS24v6JbMDoPTET44Xjuw4Cea7oE7WiV//hz/92gq5BFg2TbaU2bPUs32tQohCNUW8LJFUPt0uWW4PaY+hvJYUvSHhwTwHLl3iYzAOibEsRUZBhMwhFS1nTsepTbPzmX5zXqmF19WDWwYnOUYAFfb7CQg3ndmZgL79tp3CocF8yoroRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YIlBAFzfGCQ5M2VHn0qgaBT5Vs2S2TInPApujgd1e4=;
 b=g/thMbfBZPBvdSd4UKsqoLRk3nwuTWxxEsq40PY/r3qRhd3bC2ts5sQQ6GeNzNWoKkjkhACpMtSJGNx8fFbib48o1ZIyc3NtGn4HWsIflXR4SLYIzgCyT8reMjzNJiPqwijH6laVzMknMRTWmthM4vA/wM/+05iK02+n4buIOnqIIWSD+j2gql6mKKC1i5r78l81fg5Dxs4wVJ/b8LWda/7ZcYtKmoDc7lhFzMtqIp6ucoET0iXe0ykpLGeQHq7UV2JOgZVHo7X7/sz1s8fDmZFPnUzL6xUWmN/x2jEqMI69f4AEUMczKUvl5DFx8xcD5pxTBSDRQiIFL881gj1Oug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YIlBAFzfGCQ5M2VHn0qgaBT5Vs2S2TInPApujgd1e4=;
 b=TqiSiAQgQ2DBOJk5yLxssWZN5uBLyqtM2ZHw/2AZcUSKOm+Y4CCy0c/XnUDWgjp9FjncsqGzuo8NqTT8TZwOzSlZVdX34M/JPEAza0Ba/tei8dMLpHT3suKe4S7WCCc7trJtWbu3jHP+twWnVsFATULQKRHwd+bpxuJCOmCxHhA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:37 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 23/36] maple_tree: Try harder to keep active node after mas_next()
Date:   Fri,  5 May 2023 13:41:51 -0400
Message-Id: <20230505174204.2665599-24-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::34) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 799597b9-a160-4fcb-2491-08db4d90654e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDLo46c0cajU9fskw7mJm4Eo2vRITcLK4QNiRU1EiAwt19rOuxMcJZdJIYNPiGFGMYMBeLJRHDCnZfwl6BbtND6iI1m1b7cLyJfrsj9YL1XiN1tB6S6gu9WldgDOabai2vvJ8M+zg+vH3k0y8iLBZfKc3Bihl+AfgVXKGSpd5F9NlEqUVtz1RVVKqEszp3kZjO3Zq2QnSqMkikkm/UfPRZguAsF6UlpCpxz/EmVTJUZg1CM0D6yP0W7YLSHRiBZs1Ofou1kt5du1WKWjBgbEhbYHR80HwpcqgRgxuYsb2a/cGp22Ty2uxgfnfKp1ONEK1msXsIZIdbEDMIuWUK4S39KC6/G55Cb6iO3URpbeLf79ENQjvluf7wUhFYmdN1vsrDZW5fLTmtMwcrs6534wuNmFRXqk4vTkGXXs/EVa7lBeRbTKXPiz5vGGvTzRwGVulbA7uKXUKLupIFLeFYynHaXcyZ+tKQH802r9deifyW+j7ZexQdrYTkuS71P9rZJHuvmPvVSfklH+1VnxPQaszfGT9Ouy0/9ciM+vmsnox8qDq9CW27eDRf/7UVyuquoLC12RjhQoNSFYN07B6YERU9X/5tjO4VAERcoRCj+4G3Bz7X2CQfrmlRvYTifFhv2msBTC0w/r0WVENonpIfGi+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(316002)(478600001)(6666004)(6486002)(107886003)(2906002)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002)(34023003)(148693002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WYZJfQdVIN0maX1ErVWb/X+T0r/ju8raQwAmLpdfQBvV188OhcmCCenCgCx5?=
 =?us-ascii?Q?hjdxBdSJ0+35L9jQKLMc4uhX9/pOFu84BnMB0jwsZ7Xxkw859KYqNlDTeVEe?=
 =?us-ascii?Q?/LWyjA7mQC6MXBke+JMx0omdbkTbXmVHVeLZFg83b7hg0xqe8hKE2IW2Uggb?=
 =?us-ascii?Q?+oIEVQT/MXwH/uqQS3Jaedz0NgAyDSoiW2QorzWVJ90EljwJ75supxhcVjWO?=
 =?us-ascii?Q?jL0y6YDr7gGyhwFgTtAUfMxDuo6CmVOAfqU1Yt2sCNToaQ13wh8gAPmvUoFI?=
 =?us-ascii?Q?7pTqQrH5fg2QeUx8Ropz768dx+TbU2GaTdjkpLE/4j5zhv23yl+L5Px1RwGh?=
 =?us-ascii?Q?xxbT4jEuzc/OkgOLKLhVOLLC6Nem/4BiZyZrSn06nKwYiWHHHgtzdkciSMOg?=
 =?us-ascii?Q?s3ok7t2+LLCD/0Evu0RbzSg9Q90rPPRHaQG7TzxjI4ch3/LenirXQJyoaXeD?=
 =?us-ascii?Q?WH5In9lZgLHz9zeldkwz2LGVfIRWbQKrj3gCecbGNFAZ90J1D6ObILHkn6FE?=
 =?us-ascii?Q?dyiJ2u883Fl+iuXoGKrZXuqwI3QaSDFMNK4jEY1y/AbKtgNffrFqJDrjKm6B?=
 =?us-ascii?Q?GBLtruYf4k12qAv0wK+ROhzxvzPhogI9ru974BBdqXnfinUi2WwdbOeXuLp8?=
 =?us-ascii?Q?MjwNn7yExB+cLbb204S426TH/H7ExK6/EMIgZDz3UAIjK4Fh6EJOYhrVGnKw?=
 =?us-ascii?Q?YzdTNmIu48NNYi1JrlBIqhS5H7ukvGChJ8yts74hcoXkV5FivEavzX0YYoiZ?=
 =?us-ascii?Q?tvUPEtvniq7SJVMgm3IwIVH/vREBuxW2VtM+p6Vub64U0D6yLGKQmAcE93EF?=
 =?us-ascii?Q?ljBOQs698v+mTvnF9WWcVUMAsofy3K4zQVXCZuvqz3MAJTpNx8Z+eA19dtKe?=
 =?us-ascii?Q?0LjdH7H7hRfe97enEt+6HTGfuVnfpGiBQBy4JLOaY2vdG+xJDmtwXAPydmTC?=
 =?us-ascii?Q?5sdzNLr1dwOsAPDIMHXXSSbDGI5LBkf/ImhTMYLUng2VgheFyhN5i2hfhnG+?=
 =?us-ascii?Q?gW10PPtDHkw2a46ekfLOVmUsMgHHHgGmyjptuKahpAswUOx3uTwK8W/b8OZ1?=
 =?us-ascii?Q?3UAVnJX2hgYkdKU+PwR0ZcDKH21EzYOmwXfHEVER4cyKT441vntpk3C0k6zO?=
 =?us-ascii?Q?kad3nAF+J5LHKvU4YZhwn4wolAXgNd6WHU+zz4Ayj+uI6ZhZhR+wbpkSQUw3?=
 =?us-ascii?Q?kc8d/VEGUhvv/72/G9pQeOrWYq5amPPYVNxQlT8pHFYJ6dkfPVBvY2fpLwFT?=
 =?us-ascii?Q?+ogc3OMcI5z7lSn9ah555wvGAnYwMDsR3scG6jWQBMGui0SRs/3Nbx0LJWlg?=
 =?us-ascii?Q?p+XTPAc6LTjw35QlJIge2e42vSxaJwR7yCWzUsY4QOBThdiACuDOPmBE9jN+?=
 =?us-ascii?Q?eafiupj/9EU36ZHQikY7KFDppA2pa+TNyz0CvashN3nK1h2mdT5mj7dgiz4u?=
 =?us-ascii?Q?3Stz9SM/wZooRmvJ95ZwaQ5hjSXwA680qTUEJlLREFH4T8BJ+fga6ZngdMBM?=
 =?us-ascii?Q?EIjTnnbXn4Q+hKVAmazUmPNkOUcjmsbe1uWi6n5PesMytGukWcouEWGtT8eX?=
 =?us-ascii?Q?trTP/CsNuSYX45RZ2Bejxf06dRllrxuEgBDKNkvZ1xKEuKKAAFC+R1ebiCI/?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5aTcAQAoDhbhgTlpXb+LbWAeZAeI0g3VsVy8KhIT0xcz6+q1mAhxMEK6SbYUPu5UC8Ag+u7nLhM9MLJO0NYLFlpuXe1RudQUtW8YWJLu5b0Fs0AdRTGEISiYyOorkKW1jbG2SWcTuEdCuk0Xk7dBr5kM6o1L6Bv7wLbIW/OTYQmtnPkA2THigDREcK0KYaSg80vMeOd4J9/Ia4eF6uSTXiQ/TjwJ8ri06cVBR1qvocz8uGe6U8sOH+FZVeyLBOxDrTIl//TJZFXoG1oJWNUNJsfBLcEVwMLkv8ogx6UILzDb1h3mOSs3LBXULnzoZT5t/rr2SNkXNWHpEBlD+YPqyLsGTD8gvX9Orf9YYsi/+wm1GRBVHuO9L+6SHCCeHu8i6rzDjMjQW6CAKFGBgm36MmUq+GloJQIFlo0kTuMKT4cMyLUWQIrxY7UBOiJeqxo8rYifCir0i3FMBaUj1ltjA5oLdbAMsd97DByTWvyJglmUZZFHybS5Mc0F4eVKuALiyZgpK0tkq7W/GhrmxCebuGb51UclniZUAzpid5LO1DtfHRM34x8WbaP2ZjWFkWL+pYPxtuH75eeF/3k4Z8v6NZfulhHfEiJxwKTEm5B9t9i5EkyjC0TACuV91wULk83VvL8KOSxWGnGgNSWSfKfjfqwOmU9YFBptyTDLWtYxEvytzhfEcR7w2c8FL90hV/LIpmSfELRMYnIIBQS5elOea9UtWXjVuFE3R9NNiEH2rwITDwwaOsRa2HCusFz9ExFGzNqRhAO2ss1S6Y3GgUohrE2D6LvcqPb196BRwVxy9TPY4thlmGp5nY76+5hjvVdFQTW6QOM/tPujuEpwwEmh0fy6J//RFgc+Q8zsB3gn5BMwAVxKgVHsb6FryZLFpkLp2CmoJrQsbYU1KUPqWl54Bw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799597b9-a160-4fcb-2491-08db4d90654e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:37.4267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFVV3opXPcfXRIjx4hslrAPziwPQkvzZh+pRuFEWAE676HgIK7053Hn44zA/inKmwG8Hxe6Jc/on8yXeU5X1+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050146
X-Proofpoint-ORIG-GUID: Pycvzo22Uy-PVKVCspYzE5pAH9MIW_pJ
X-Proofpoint-GUID: Pycvzo22Uy-PVKVCspYzE5pAH9MIW_pJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the mas_next() call to try and keep a node reference when
possible.  This will avoid re-walking the tree in most cases.

Also clean up the single entry tree handling to ensure index/last are
consistent with what one would expect. (returning NULL with limit of
1-oo).

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 89 +++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e233f41ed4da2..09142af082148 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4726,33 +4726,25 @@ static inline void *mas_next_nentry(struct ma_state *mas,
 		if (ma_dead_node(node))
 			return NULL;
 
+		mas->last = pivot;
 		if (entry)
-			goto found;
+			return entry;
 
 		if (pivot >= max)
 			return NULL;
 
+		if (pivot >= mas->max)
+			return NULL;
+
 		mas->index = pivot + 1;
 		mas->offset++;
 	}
 
-	if (mas->index > mas->max) {
-		mas->index = mas->last;
-		return NULL;
-	}
-
-	pivot = mas_safe_pivot(mas, pivots, mas->offset, type);
+	pivot = mas_logical_pivot(mas, pivots, mas->offset, type);
 	entry = mas_slot(mas, slots, mas->offset);
 	if (ma_dead_node(node))
 		return NULL;
 
-	if (!pivot)
-		return NULL;
-
-	if (!entry)
-		return NULL;
-
-found:
 	mas->last = pivot;
 	return entry;
 }
@@ -4781,21 +4773,15 @@ static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 {
 	void *entry = NULL;
-	struct maple_enode *prev_node;
 	struct maple_node *node;
-	unsigned char offset;
 	unsigned long last;
 	enum maple_type mt;
 
-	if (mas->index > limit) {
-		mas->index = mas->last = limit;
-		mas_pause(mas);
+	if (mas->last >= limit)
 		return NULL;
-	}
+
 	last = mas->last;
 retry:
-	offset = mas->offset;
-	prev_node = mas->node;
 	node = mas_mn(mas);
 	mt = mte_node_type(mas->node);
 	mas->offset++;
@@ -4814,12 +4800,10 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 		if (likely(entry))
 			return entry;
 
-		if (unlikely((mas->index > limit)))
-			break;
+		if (unlikely((mas->last >= limit)))
+			return NULL;
 
 next_node:
-		prev_node = mas->node;
-		offset = mas->offset;
 		if (unlikely(mas_next_node(mas, node, limit))) {
 			mas_rewalk(mas, last);
 			goto retry;
@@ -4829,9 +4813,6 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 		mt = mte_node_type(mas->node);
 	}
 
-	mas->index = mas->last = limit;
-	mas->offset = offset;
-	mas->node = prev_node;
 	return NULL;
 }
 
@@ -5919,6 +5900,8 @@ EXPORT_SYMBOL_GPL(mas_expected_entries);
  */
 void *mas_next(struct ma_state *mas, unsigned long max)
 {
+	bool was_none = mas_is_none(mas);
+
 	if (mas_is_none(mas) || mas_is_paused(mas))
 		mas->node = MAS_START;
 
@@ -5926,16 +5909,16 @@ void *mas_next(struct ma_state *mas, unsigned long max)
 		mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
 
 	if (mas_is_ptr(mas)) {
-		if (!mas->index) {
-			mas->index = 1;
-			mas->last = ULONG_MAX;
+		if (was_none && mas->index == 0) {
+			mas->index = mas->last = 0;
+			return mas_root(mas);
 		}
+		mas->index = 1;
+		mas->last = ULONG_MAX;
+		mas->node = MAS_NONE;
 		return NULL;
 	}
 
-	if (mas->last == ULONG_MAX)
-		return NULL;
-
 	/* Retries on dead nodes handled by mas_next_entry */
 	return mas_next_entry(mas, max);
 }
@@ -6059,17 +6042,25 @@ EXPORT_SYMBOL_GPL(mas_pause);
  */
 void *mas_find(struct ma_state *mas, unsigned long max)
 {
+	if (unlikely(mas_is_none(mas))) {
+		if (unlikely(mas->last >= max))
+			return NULL;
+
+		mas->index = mas->last;
+		mas->node = MAS_START;
+	}
+
 	if (unlikely(mas_is_paused(mas))) {
-		if (unlikely(mas->last == ULONG_MAX)) {
-			mas->node = MAS_NONE;
+		if (unlikely(mas->last >= max))
 			return NULL;
-		}
+
 		mas->node = MAS_START;
 		mas->index = ++mas->last;
 	}
 
-	if (unlikely(mas_is_none(mas)))
-		mas->node = MAS_START;
+
+	if (unlikely(mas_is_ptr(mas)))
+		goto ptr_out_of_range;
 
 	if (unlikely(mas_is_start(mas))) {
 		/* First run or continue */
@@ -6081,13 +6072,27 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 		entry = mas_walk(mas);
 		if (entry)
 			return entry;
+
 	}
 
-	if (unlikely(!mas_searchable(mas)))
+	if (unlikely(!mas_searchable(mas))) {
+		if (unlikely(mas_is_ptr(mas)))
+			goto ptr_out_of_range;
+
+		return NULL;
+	}
+
+	if (mas->index == max)
 		return NULL;
 
 	/* Retries on dead nodes handled by mas_next_entry */
 	return mas_next_entry(mas, max);
+
+ptr_out_of_range:
+	mas->node = MAS_NONE;
+	mas->index = 1;
+	mas->last = ULONG_MAX;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(mas_find);
 
@@ -6518,7 +6523,7 @@ void *mt_find(struct maple_tree *mt, unsigned long *index, unsigned long max)
 	if (entry)
 		goto unlock;
 
-	while (mas_searchable(&mas) && (mas.index < max)) {
+	while (mas_searchable(&mas) && (mas.last < max)) {
 		entry = mas_next_entry(&mas, max);
 		if (likely(entry && !xa_is_zero(entry)))
 			break;
-- 
2.39.2

