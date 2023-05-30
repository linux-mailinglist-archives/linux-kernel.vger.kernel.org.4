Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02BD716DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjE3TlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjE3Tku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:40:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6E4C9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:40:46 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UJEtD4002489;
        Tue, 30 May 2023 19:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=Zxjg7z3fa9CALbmlAr+UvBOJ5h4y8BfV0NJkPtfRUAI=;
 b=jSI2izY0J9nP3OXs1ZzxlStJXppMS3VepkqFkcZhnE8hvTiEyXAE0JZPHOGvr+XVWC+R
 IcYssqwSaHkyRQYzQLqqHlfzhpEZTv4z0eVUKXyK7tE+xWKDDQb/uGDIKZGQcDg8iQ8W
 pmASCsF4Vqsdh+myEJyoNGJWxl0NpreA8d0H/L0derRx71rYxRAVcs0UAWaZLiNoanMP
 NZExkD375+e5Z9yUeIkgLA4dTPtqAWIhK59QEa2MNkgnN62PisNHnqGmiuZ/gnHCL8tk
 3ipaiFrpkTnPw8r0WLkEB7Kmy2yBGaipKcFszIq2p3/skg1H4fazESb6yUGwq7Ddre7u XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9uubv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 19:40:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34UJYdk5019748;
        Tue, 30 May 2023 19:40:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a4mb4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 19:40:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tv/xE4wPM00Qx3tCUasvRO+6ooSMlcDPRz2yYwpSBZ/qKD5klIYEaduVaUEC2P2qHAw7Nu3W3qr/IEtiQHgzgIaHR1mvck4YjB6j/66+A90feoWhI/yR/yz5epRjR0qnvG3eCi371MvYqYlFs28ee43XBCXqQaOnBKYJiMPdTvrBc/JvB6re24ZXnPpB7dDc9xE0U18gEEKmQS7C64QAGjbBKbRfvIGtndobsU/6Qc2SGtq629BvcCo+KT/EOJTykxV06SYFZoswDgv4fKUCXtHriyqbJNM5BYHxSONTnK7CeTOaXcxStaXW7uxoGh4T/8S4pPt54U6+DloZOBvcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zxjg7z3fa9CALbmlAr+UvBOJ5h4y8BfV0NJkPtfRUAI=;
 b=GzrrU7v7V03x/nlw7ttaDkfeqoVxESXL2twPok08106l+3LPF/bTCTvj1X7YZrNMnWfMM1Yn9NS6UU++GKJ2zppHR+OiAq5O+aySgRnGONVfijbrVCnfVrDknfZ6noRIdBBkj29YoweKhXNRmdE2qbNIHg/zAQFswfJC+DCea53/aTu2R7iMI96AycruFJoecJseSZ1IMRqk+aa1dNRcUzf0ee0vHQClaf37hTXZf1J69ofmzvgqVZQ7wHsnuXDJ71thf7gxJ9Ln0fFaNKbFlCqmj5mHE8JPn9+y8AKQyWnmfQ6AEdOmtPEInnOZWdRdDNQ/+ZDdzcrxdsl8vLx0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zxjg7z3fa9CALbmlAr+UvBOJ5h4y8BfV0NJkPtfRUAI=;
 b=GIFQBfy+yY+mNOi5xbsPC8l9eN5dhSXPlmQCSkk+G7RHJvIxKYqH7oV2frcONc3x6UN21pK0Vb9bzUgUnBqY8n6AE6+s77Ej1yqYCVfxgzqinRZK6BE851bSMqsGwmN5mh2kh4nEFu7ARvJ8mL/+G8nvWWYXK7EwcClsOpDqSm8=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by CY5PR10MB6214.namprd10.prod.outlook.com (2603:10b6:930:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 19:40:32 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3%2]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 19:40:32 +0000
From:   chris hyser <chris.hyser@oracle.com>
To:     chris.hyser@oracle.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/4] debugfs: Provide min/max checking for simple u8, u16, u32, u64 debugfs files.
Date:   Tue, 30 May 2023 15:40:10 -0400
Message-Id: <20230530194012.44411-3-chris.hyser@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230530194012.44411-1-chris.hyser@oracle.com>
References: <20230530194012.44411-1-chris.hyser@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0375.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::20) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|CY5PR10MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 44889246-5b36-4e02-94b0-08db6145bb48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KahGeb2DHOkdV2tkZv7LZczEd+oEXfoym7FEGXMN0TwYWBoEuOe725oh56ymgYvSz48Zb9Jf3FoS8WEGcaw87pQnuUXKiDh+V97sH5VPyzfC9DOHcRmsbBmOteQP7W1zByCU65hoDI8w2+Z5HgKv2dAKcSiyxptVj25Rt7zX2hiRxoiaQzTUxBeSDocfwen/cUj9s97sMkkxJVMO2yoaXHTArt5Ba3irOHkdnSpEbmMto5iQJ2WfALoLAQcm7aa1ewwpca5d6+RiORxbcIZYptY9UBX4ITP+z8NE6VUi6cp98fjTCS6uE+1IV2b8w/Ot/FPVshAFCpn+50PA3iChMqZGeuCMPKAtY36+RKqrwR4XffMXGZi2VjLEok7aDcAMCXaMu3e0uagHDoYNByg4eGIkkk7uPxXkyqiowClF4oHRUzoGrjAmFEeAc6v+q+3GBcU4Tp192bL+MgeCmk+ziorGZMo082TasYnqcQiA9lFSWpgYrK2d52LZwQpJrva3/R3RgC06yqqgsRv2+9Q2t5S/L6OF2DQRN8vYtqxsXhQkqOzqppRNJ/KykzZMqmJ2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(478600001)(8676002)(8936002)(5660300002)(6916009)(30864003)(36756003)(2906002)(86362001)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(6512007)(26005)(1076003)(6506007)(6486002)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iNzIg0b9/CA91ezbvmGMom7pIr4nn1hpggcHH4xaymUs3sCSmcZs76upEMrn?=
 =?us-ascii?Q?G7GHDwDpq3lkx5KSZckrY6xi4NtLpoTPvjQYxn8+6jQMBAsV+BcmjPNWbcgK?=
 =?us-ascii?Q?jIji0Tdxzv4uvvdsVtRShxt+8bcn9xaloBXp/HxxQ3qSlZwd0K/aRo5+GYTY?=
 =?us-ascii?Q?Hpej1ta0um5noFZ6UcT6cGjw1B3YNkSe9x5uQqwCjYArZcUf5jmVyMAToTCH?=
 =?us-ascii?Q?Wy/A46xwynuZhaQ0IPMZw2ZkNkcIrT2QAz8uFHGEIZdaFzEkYPWwFphNLxPb?=
 =?us-ascii?Q?3O2SNYexVMRhEs78thkhUPMYxvWOo4EPefKpxlYDeLzLpXC/Mo9hiVBnqWTB?=
 =?us-ascii?Q?SyKQiQWdu/z3xfX8KrrZTbY5XrR1jRFz/kCMw5raGqAXI+qq5edbGPoKakF+?=
 =?us-ascii?Q?OPtPG03Oqa623OQwZhoVvNRChFMceiclqYo+LcApBlNv4OU8qDlKdZe0bFjf?=
 =?us-ascii?Q?8Z/6tEdB7rrajs0U3Zp6NHUxn8iSwPKf/eh1v0yb/I9Z1mRxlfUI72lsN/WS?=
 =?us-ascii?Q?Awtwfku16RlfezS55f90NuWTbA+G16j8ao55YXck+Rboo4Leu0tdHiiJgeO5?=
 =?us-ascii?Q?f1w210S28PlCQjO47BXo1el9Ysz+Cu8MLXAjmdDGrmcjjRjR1kEJ7K2n/9Rz?=
 =?us-ascii?Q?yvEAQhYsm3W+9ojdteTX+6KhIfQihvG0A2XUjPYAF+Kfshwf+8T3/+XPfkK6?=
 =?us-ascii?Q?7X88cD1MsjSXRp2Hx+RPamrtI+KEs58mYV8BagLKeto/xaT2pChwd09SPS7X?=
 =?us-ascii?Q?7BkZEoCCg8fChupo7DSuWqqpP9G0hXKzcZ7tjDnpcoeveQhobAmyNmKYbtl9?=
 =?us-ascii?Q?E2p+T6SPaSp8LAjWBuiXWmF8VGAbFeisl1TxemqY+bKRcrbKyaT1tVVGm4O4?=
 =?us-ascii?Q?Rg3RE5SRsnCiO106+NVkzm2yPyGAjiFJA/1ndSdmLqSP8LhWkDPGVvwXkj5E?=
 =?us-ascii?Q?qs69IFJ7g4j7lZMlZz3R0t2XZ03gFTKjgqFORXFXnz1rXBgEYVQSd+WUfzzS?=
 =?us-ascii?Q?+B03tD8qrOTzlA4nZcRuVQukHfU/sa9rejTgv7paneSAlC7okjXxNhjTlmjg?=
 =?us-ascii?Q?ZczvHOqU02n0tQT0zUueMAW7q3wuE+xuxu7vkgKjlu2SMSg8U04sl2eEmF7B?=
 =?us-ascii?Q?iCfeZXL8rVvc8//aJt9lxQlHWiglyLlA+J9tZGxxvE6ejiF8uOj3uJ+7xJnO?=
 =?us-ascii?Q?iQYV5+s34cjc8EFQIWBxvT6p14fvBywHb96h3BIbFCJE7aUEMrpWcFOcPZWP?=
 =?us-ascii?Q?WV9zGCO8oRROAZtq9NgxX63bmtekQsTjyzQKf/BcHY3Djapm4ydckpvtQ+93?=
 =?us-ascii?Q?Z7fslh24NuQ/2dnErKvGJNwh+SR8ktKG/owRbKDCPzuaiGEg27bBY3ok5zZB?=
 =?us-ascii?Q?mS1b1DNBKqWnaIuvmfF/W9JUNZPxx6iSiGGnAcguHls7/vO0eCgcYJiDv8MC?=
 =?us-ascii?Q?SoKuH43I43uZOmy9noL3Alg/KrUj+otWUxQmQY+IZj2tOJRV4uUg3wDlbRGo?=
 =?us-ascii?Q?orgQ++8mMAWKB1hxwnwfirktOIPYk7bIjmJ1zz2wrPRS2TD/4dvzeQYg164F?=
 =?us-ascii?Q?95YtVjGCyrj6yagYCyDZvGSZly55KYE6+HhvHTQ/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QX5TOhw/98qT1DFKtA+0gStuLa4UtaSsdOaYV7FfxMoNF4zdQEUM4i+OQ3rbpsECeYWEYaKYCPR7/tlwvsGTydC97GzCPmwPYbeMsRyyxtLufKZ17rfOasQ7ah2kV34esAnyeqFA7iMH8vmUsStkHMQxMOuPXiuJqbkIMFimLrX2PecqiUNZEk12xSVVe5HzPSTACJurH24sizp6pu9d4Ym4/zJ28SYDKNqMibItXkWLl93h1KCLkOomH6r+/mOAmTIqjGkZ4FPBUC7Fg+KymmtBWFvZRSaDKCxLW+WFppvDZM015CuO6lGRhRx2W9RSIPM8B7Og7cZwBDjCuyMV4JNYLkJ6ZdmJBOS9H7f0EFSGYMU4cKvIRs8nH6HTzI5lrLlsCjVS2A4KkTq1rGJXwljgvJfpbl6QFg+if88rxKQWc+1rlODYFGbQGt/gRgL6GLbiqvtcV60NVEjQJcMvfgC8WPzidkoqH3dQzPIQZlhb+dUS97b0IHhHZylgZQC5uq2zz/KyCIz0COJ8Ddz/vkVRGVFGgV6ZAaG1ImR2Y6d/gee+CMuE6VpQNmjsaj3IfSbwSKGCI1zYacZP0lyJYIrSGRfIDjEZdYcgHKThXBnQGCpWJhoi1KbxOf5/exmHK6jJrWf+KaLalYpyNI/LYxK0RDJvzCjGbv3YjGON3w5v/uYyRMA+C9VNu0HE714/5kv2EQTMazS9oBpm+gg3ZUniqYcVDs9Td//gf2kCBACM1smCsVxnJwj1EvifdgBlwjU5mWHS2bmN51bEG3p5GosD3twddKXe0lhOAgjc8tBXVxnvA5x46NFThB7MxYUQ1b0nn0C07E0Us9q7jLxsfhx37nfgMq1ESY5rPpYDMNqLViKKELNuO1jWuEHxmcUb
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44889246-5b36-4e02-94b0-08db6145bb48
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 19:40:32.7689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81nmkSJSnYwTrtjE7PMfmUIsUiP9J+RPiol5sovZM8JyeCiePIGm801zRGQnX97tTrEeL1Hfi1TpVCRDwExnaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_15,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300159
X-Proofpoint-GUID: db2bk-tEHevCL_piht6FzJavvyW9joMo
X-Proofpoint-ORIG-GUID: db2bk-tEHevCL_piht6FzJavvyW9joMo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the simple file interface to include min/max checking
files.  Writes to a file are checked such that the written value must
satisfy the specified check (as well as fit into the specified storage):

minmax: 'min' <= value <= 'max'
min:    'min' <= value
max:    value <= 'max'

Failure of the check returns EINVAL.

While the same checks could be done by providing a custom "set(void *data,
u64 val) function" in DEFINE_DEBUGFS_ATTRIBUTE() for each file needing said
check, each instance would require a private struct file_operations.

Using the same trick as the unsigned simple files (u8/u16/u32/u64), this
patch supports "unlimited" users with only two struct file_operations per
unsigned type. As min/max checking only applies to set/writing, read-only
files make no sense.

Various macros are provided to simplify setting up the params struct.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
---
 Documentation/filesystems/debugfs.rst |  39 ++++++
 fs/debugfs/file.c                     | 189 ++++++++++++++++++++++++++
 include/linux/debugfs.h               |  60 ++++++++
 3 files changed, 288 insertions(+)

diff --git a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
index 6f1ac8d7f108..31d186e952eb 100644
--- a/Documentation/filesystems/debugfs.rst
+++ b/Documentation/filesystems/debugfs.rst
@@ -99,6 +99,45 @@ functions can be used instead::
     void debugfs_create_x64(const char *name, umode_t mode,
 			    struct dentry *parent, u64 *value);
 
+Some use cases require min/max checking of the written values preserving the
+initial value on failure and returning EINVAL for the write.
+
+    void debugfs_create_u8_minmax(const char *name, umode_t mode,
+			       struct dentry *parent,
+			       struct debugfs_minmax_params *mnxp);
+    void debugfs_create_u16_minmax(const char *name, umode_t mode,
+			       struct dentry *parent,
+			       struct debugfs_minmax_params *mnxp);
+    void debugfs_create_u32_minmax(const char *name, umode_t mode,
+			       struct dentry *parent,
+			       struct debugfs_minmax_params *mnxp);
+    void debugfs_create_u64_minmax(const char *name, umode_t mode,
+			       struct dentry *parent,
+			       struct debugfs_minmax_params *mnxp);
+
+These functions are called with the following parameter structure, flags and
+helper macros. The parameter structure must be available for the duration of
+the file, thus requiring global or malloced memory. Failure of the specified
+check(s) return EINVAL.
+
+struct debugfs_minmax_params {
+	void *value;
+	u64 min;
+	u64 max;
+	u8 flags;
+};
+
+Flags are defined as such:
+    DEBUGFS_ATTR_MIN 1
+    DEBUGFS_ATTR_MAX 2
+    DEBUGFS_ATTR_MINMAX (DEBUGFS_ATTR_MIN | DEBUGFS_ATTR_MAX)
+
+Additional helper macros provide for
+    DEBUGFS_MINMAX_ATTRIBUTES_BASE(name_parm_ptr, value, min, max, flags);
+    DEBUGFS_MIN_ATTRIBUTES(name_parm_ptr, value, min);
+    DEBUGFS_MAX_ATTRIBUTES(name_parm_ptr, value, max);
+    DEBUGFS_MINMAX_ATTRIBUTES(name_parm_ptr, value, min, max);
+
 These functions are useful as long as the developer knows the size of the
 value to be exported.  Some types can have different widths on different
 architectures, though, complicating the situation somewhat.  There are
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 743ddd04f8d8..bd655b286da6 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -578,6 +578,195 @@ void debugfs_create_u64(const char *name, umode_t mode, struct dentry *parent,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u64);
 
+static int debugfs_minmax_chk(struct debugfs_minmax_params *mnxp, u64 val)
+{
+	if ((mnxp->flags & 0x1) && val < mnxp->min)
+		return -EINVAL;
+	if ((mnxp->flags & 0x2) && val > mnxp->max)
+		return -EINVAL;
+	return 0;
+}
+
+static int debugfs_u8_minmax_set(void *data, u64 val)
+{
+	struct debugfs_minmax_params *mnxp = data;
+	int err = debugfs_minmax_chk(mnxp, val);
+
+	if (err)
+		return err;
+	return debugfs_u8_set(mnxp->value, val);
+}
+
+static int debugfs_u8_minmax_get(void *data, u64 *val)
+{
+	struct debugfs_minmax_params *mnxp = data;
+
+	return debugfs_u16_get(mnxp->value, val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u8_minmax, debugfs_u8_minmax_get, debugfs_u8_minmax_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u8_minmax_wo, NULL, debugfs_u8_minmax_set, "%llu\n");
+
+/**
+ * debugfs_create_u8_minmax - create a debugfs file that is used to both read
+ *     and write an unsigned 8-bit value if it satisfies a min check, max check
+ *     or both.
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @mnxp: a pointer to the parameter struct which holds the test limits, the
+ *        test to perform and a pointer to the variable to display and modify.
+ *
+ * This function creates a file in debugfs with the given name that contains
+ * the value of the specified variable.  If the @mode variable is so
+ * set, it can be read from, and written to.
+ */
+void debugfs_create_u8_minmax(const char *name, umode_t mode,
+			      struct dentry *parent,
+			      struct debugfs_minmax_params *mnxp)
+{
+	debugfs_create_mode_unsafe(name, mode, parent, mnxp, &fops_u8_minmax,
+				   NULL, &fops_u8_minmax_wo);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_u8_minmax);
+
+static int debugfs_u16_minmax_set(void *data, u64 val)
+{
+	struct debugfs_minmax_params *mnxp = data;
+	int err = debugfs_minmax_chk(mnxp, val);
+
+	if (err)
+		return err;
+	return debugfs_u16_set(mnxp->value, val);
+}
+
+static int debugfs_u16_minmax_get(void *data, u64 *val)
+{
+	struct debugfs_minmax_params *mnxp = data;
+
+	return debugfs_u16_get(mnxp->value, val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u16_minmax, debugfs_u16_minmax_get, debugfs_u16_minmax_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u16_minmax_wo, NULL, debugfs_u16_minmax_set, "%llu\n");
+
+/**
+ * debugfs_create_u16_minmax - create a debugfs file that is used to both read
+ *     and write an unsigned 16-bit value if it satisfies a min check, max check
+ *     or both.
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @mnxp: a pointer to the parameter struct which holds the test limits, the
+ *        test to perform and a pointer to the variable to display and modify.
+ *
+ * This function creates a file in debugfs with the given name that contains
+ * the value of the specified variable.  If the @mode variable is so
+ * set, it can be read from, and written to.
+ */
+void debugfs_create_u16_minmax(const char *name, umode_t mode,
+			       struct dentry *parent,
+			       struct debugfs_minmax_params *mnxp)
+{
+	debugfs_create_mode_unsafe(name, mode, parent, mnxp, &fops_u16_minmax,
+				   NULL, &fops_u16_minmax_wo);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_u16_minmax);
+
+static int debugfs_u32_minmax_set(void *data, u64 val)
+{
+	struct debugfs_minmax_params *mnxp = data;
+	int err = debugfs_minmax_chk(mnxp, val);
+
+	if (err)
+		return err;
+	return debugfs_u32_set(mnxp->value, val);
+}
+
+static int debugfs_u32_minmax_get(void *data, u64 *val)
+{
+	struct debugfs_minmax_params *mnxp = data;
+
+	return debugfs_u32_get(mnxp->value, val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u32_minmax, debugfs_u32_minmax_get, debugfs_u32_minmax_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u32_minmax_wo, NULL, debugfs_u32_minmax_set, "%llu\n");
+
+/**
+ * debugfs_create_u32_minmax - create a debugfs file that is used to both read
+ *     and write an unsigned 32-bit value if it satisfies a min check, max check
+ *     or both.
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @mnxp: a pointer to the parameter struct which holds the test limits, the
+ *        test to perform and a pointer to the variable to display and modify.
+ *
+ * This function creates a file in debugfs with the given name that contains
+ * the value of the specified variable.  If the @mode variable is so
+ * set, it can be read from, and written to.
+ */
+void debugfs_create_u32_minmax(const char *name, umode_t mode,
+			       struct dentry *parent,
+			       struct debugfs_minmax_params *mnxp)
+{
+	debugfs_create_mode_unsafe(name, mode, parent, mnxp, &fops_u32_minmax,
+				   NULL, &fops_u32_minmax_wo);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_u32_minmax);
+
+static int debugfs_u64_minmax_set(void *data, u64 val)
+{
+	struct debugfs_minmax_params *mnxp = data;
+	int err = debugfs_minmax_chk(mnxp, val);
+
+	if (err)
+		return err;
+	return debugfs_u64_set(mnxp->value, val);
+}
+
+static int debugfs_u64_minmax_get(void *data, u64 *val)
+{
+	struct debugfs_minmax_params *mnxp = data;
+
+	return debugfs_u64_get(mnxp->value, val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u64_minmax, debugfs_u64_minmax_get, debugfs_u64_minmax_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u64_minmax_wo, NULL, debugfs_u64_minmax_set, "%llu\n");
+
+/**
+ * debugfs_create_u64_minmax - create a debugfs file that is used both to read
+ *     and write an unsigned 64-bit value if it satisfies a min check, max check
+ *     or both.
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @mnxp: a pointer to the parameter struct which holds the test limits, the
+ *        test to perform and a pointer to the variable to display and modify.
+ *
+ * This function creates a file in debugfs with the given name that contains
+ * the value of the specified variable.  If the @mode variable is so
+ * set, it can be read from, and written to.
+ */
+void debugfs_create_u64_minmax(const char *name, umode_t mode,
+			       struct dentry *parent,
+			       struct debugfs_minmax_params *mnxp)
+{
+	debugfs_create_mode_unsafe(name, mode, parent, mnxp, &fops_u64_minmax,
+				   NULL, &fops_u64_minmax_wo);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_u64_minmax);
+
 static int debugfs_ulong_set(void *data, u64 val)
 {
 	*(unsigned long *)data = val;
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index ea2d919fd9c7..322fecb22a0a 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -43,6 +43,36 @@ struct debugfs_u32_array {
 	u32 n_elements;
 };
 
+struct debugfs_minmax_params {
+	void *value;
+	u64 min;
+	u64 max;
+	u8 flags;
+};
+
+/* debugfs_minmax_params "flag" values
+ */
+#define DEBUGFS_ATTR_MIN 1
+#define DEBUGFS_ATTR_MAX 2
+#define DEBUGFS_ATTR_MINMAX (DEBUGFS_ATTR_MIN | DEBUGFS_ATTR_MAX)
+
+#define DEBUGFS_MINMAX_ATTRIBUTES_BASE(__name, __value, __min, __max, __flags) \
+static struct debugfs_minmax_params __name = {				\
+	.value = (__value),						\
+	.min = (__min),							\
+	.max = (__max),							\
+	.flags = (__flags),						\
+}
+
+#define DEBUGFS_MIN_ATTRIBUTES(__name, __value, __min) \
+	DEBUGFS_MINMAX_ATTRIBUTES_BASE(__name, __value, __min, 0, DEBUGFS_ATTR_MIN)
+
+#define DEBUGFS_MAX_ATTRIBUTES(__name, __value, __max) \
+	DEBUGFS_MINMAX_ATTRIBUTES_BASE(__name, __value, 0, __max, DEBUGFS_ATTR_MAX)
+
+#define DEBUGFS_MINMAX_ATTRIBUTES(__name, __value, __min, __max) \
+	DEBUGFS_MINMAX_ATTRIBUTES_BASE(__name, __value, __min, __max, DEBUGFS_ATTR_MINMAX)
+
 extern struct dentry *arch_debugfs_dir;
 
 #define DEFINE_DEBUGFS_ATTRIBUTE_XSIGNED(__fops, __get, __set, __fmt, __is_signed)	\
@@ -122,6 +152,20 @@ void debugfs_create_u32(const char *name, umode_t mode, struct dentry *parent,
 			u32 *value);
 void debugfs_create_u64(const char *name, umode_t mode, struct dentry *parent,
 			u64 *value);
+
+void debugfs_create_u8_minmax(const char *name, umode_t mode,
+			      struct dentry *parent,
+			      struct debugfs_minmax_params *mnxp);
+void debugfs_create_u16_minmax(const char *name, umode_t mode,
+			       struct dentry *parent,
+			       struct debugfs_minmax_params *mnxp);
+void debugfs_create_u32_minmax(const char *name, umode_t mode,
+			       struct dentry *parent,
+			       struct debugfs_minmax_params *mnxp);
+void debugfs_create_u64_minmax(const char *name, umode_t mode,
+			       struct dentry *parent,
+			       struct debugfs_minmax_params *mnxp);
+
 void debugfs_create_ulong(const char *name, umode_t mode, struct dentry *parent,
 			  unsigned long *value);
 void debugfs_create_x8(const char *name, umode_t mode, struct dentry *parent,
@@ -287,6 +331,22 @@ static inline void debugfs_create_u32(const char *name, umode_t mode,
 static inline void debugfs_create_u64(const char *name, umode_t mode,
 				      struct dentry *parent, u64 *value) { }
 
+static inline void debugfs_create_u8_minmax(const char *name, umode_t mode,
+					    struct dentry *parent,
+					    struct debugfs_minmax_params *mnxp) { }
+
+static inline void debugfs_create_u16_minmax(const char *name, umode_t mode,
+					     struct dentry *parent,
+					     struct debugfs_minmax_params *mnxp) { }
+
+static inline void debugfs_create_u32_minmax(const char *name, umode_t mode,
+					     struct dentry *parent,
+					     struct debugfs_minmax_params *mnxp) { }
+
+static inline void debugfs_create_u64_minmax(const char *name, umode_t mode,
+					     struct dentry *parent,
+					     struct debugfs_minmax_params *mnxp) { }
+
 static inline void debugfs_create_ulong(const char *name, umode_t mode,
 					struct dentry *parent,
 					unsigned long *value) { }
-- 
2.31.1

