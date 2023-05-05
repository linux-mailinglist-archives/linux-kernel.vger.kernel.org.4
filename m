Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645B96F87D7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjEERoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjEERod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:44:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CB11C0DE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:44:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhOID028094;
        Fri, 5 May 2023 17:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=IbTSmdyb2l0AxI/fykNQrwHeQXPrfhWT/toCcPlgTno=;
 b=FIgsVyjHkx1HBwzNx5m93fIiUUIyWgcZt4DpauEzRefY5gycl40dDTlixkwpK9w61jDz
 pxF5xYfw2CYToK2cQgkM7xqjZPR+lADCkGxhoBrDpFbGddgDWBLn9BOrhwf4EsueVCt2
 oPMqs2aKLlf0kUKsJudjh1bXjQb1njNHaeiKqkk15YOP67kN9nsogX4v28FbGlSM048m
 ymA6nQTSTG5tMRxhIvaN1h5ISfThcY+x8MBb+8nnDMmKKGoHqZ4PDNTsDkiKRsamdZ58
 7RSQY0gJYfG2xQdrOSx4yxdA700GuIWSONUo3QyJKbNWrRg6NJLWqWHtjZ9Qx16ALNG7 cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t145jcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345GVNqt024864;
        Fri, 5 May 2023 17:44:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spacj05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwTHHocOicNwRtjzoeWERVPG7WXSZ/qDbfLXlXAupLIMus8hjhB/FJj8/st3aQjMkgJ5F9oqBZwd4QiMt9hz7cnK31bq83ll2kLlqzm4vIf7TSmLVnO//gV8UVJIM5aYtLH6UXEQHQxR/TC1oU+Dy2gJWbhVWNdxqAUVE9L2SLKnshB7YhkuGuW0gXi4G/ryEhNiqEsHVOR5mwlaQghvutGSGlIrxZEtJ0mFMcGr3VAwYjmTHNRZan2zEfKOq5APzmgTFl2e82s2wh186DQaUkVfZVtaVNRs0JcthZD5lxpYDSimZdMWZ6CdVvM+BbDPr/hbJcN0wG7xfG9FVmkFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbTSmdyb2l0AxI/fykNQrwHeQXPrfhWT/toCcPlgTno=;
 b=Pk1+6OB2HDWDF+A+1R033hufITiZA3jQW2ce/ZQfE96UWKC0dXTS7aG/4xaHRr10UHzN2GA/3DW38oGtTyWOoCqE47U03bQAFm0pRzC6I1Ew46bx/17zPpXELrZnW08kfXN1dE0D6pAnlibxZWk+gEhITStdvY7Hnpna5MWj8aJrbYJfyoRuUxPfDEWBbgOnPWXqk2ahzJEPuYfcpseP92wRqE5bXyGI5fGa1o8jKOUdJA0CGolIV19g6k/mMnmzY5j/gZZUyRKuC19mWgm73JR0f4ZVxXIOFTWb6TrJh7EXYYW5FZV4a2q6YGHzYQY0crM8QrT0AZPOzpQFmqH1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbTSmdyb2l0AxI/fykNQrwHeQXPrfhWT/toCcPlgTno=;
 b=j6RpMMILtZ6XEmehJ0AkQRRvQwOyNqgZcLg4YscrxWkms2fj2aWO/j0V9dhlj66qIBKDjuptKoOJ9uOPGI3qSMu1cto25Rz3vW2kEZE98R3g7jyBwSythjO/d7hPiPpsvjW0ueJCePm8Nfa/oFpxXneGN3blNFEa2CtdA5RAa1Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:43:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:43:57 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 07/36] maple_tree: Convert BUG_ON() to MT_BUG_ON()
Date:   Fri,  5 May 2023 13:41:35 -0400
Message-Id: <20230505174204.2665599-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0262.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: f838c09a-da3d-4f7f-4586-08db4d904d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVjs/kMUbaTNT+Zw0TwIiWprUjseWCCkvLSM4cbVPiFmSqb+V/zclfD8IOWdOAeLD2gTrdVQJ+TQEL3czlTdEASRzG9gIHf1bVraXo79AHS39Z/ofdkZN6fP0D43TLtqDIFAw+FCzAk7n19ZTxJXXuB05VofHobXxd72y6p8YsP+iHiaprJKOAZpGg4pPiBdmxHPJd9VhPu+CwxQ91Ykq/dHdha21kmGK9KCbZTJZDfoKPQzantiw9sBwthDMCKuqi4LSPp5f5nj2/32l1L/K4166Do7M93XV82zFyGmr91nsYforjXDPcGK2+PC2InLWrel36qtNyMlWkK5xi47OX/zy9WkRjE3InAVk8wJi0YrL6XFKc7lN1BQA5PYX132npRtqzaeushstHPa6mdRwikySuIoHrVKIzt6ScfOixicNzRjLkwhpp2EM8K4wH6NwcdXZj2IKXgZIlIoFYvheh7NwpKzsKmjaKjTn7OPhqrQUcaUJ7oWLSV0mxsmJSDKbM/GpagLyR5Wywvh79Ta4ELJtqOvEg+4iBRInuUoMBrWpAav2UNUs3nPw7dWybzA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(54906003)(36756003)(86362001)(83380400001)(107886003)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(4744005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2KtuLIsyPwugbGvWwM2s+ppSn1nCiXvrbjipKASHuBLNYZ+mXfTy5s4O9p9e?=
 =?us-ascii?Q?Ze10pCL3rDj+DlzoAggHGTp1Qtzw6aKr8LPgW4LqTjSFnj4326t1HZB4ddto?=
 =?us-ascii?Q?nIbZEYNf/gGy1UUUGMbInDs7KUIKGEPNuWRL3c4MFQzstqwGxYgnjksHl0bW?=
 =?us-ascii?Q?vR5tVQOWRzl86+t2OXjYIZKwT8/l9WffenA0/cTvDcUOSBMKRr7zysImPGl+?=
 =?us-ascii?Q?y2BWw4lWjN/bFSNySxQLM+izKjE+mYKZOqd6let4dJLNyN8spzECvtJYGlmv?=
 =?us-ascii?Q?EPJjqpANPEuzelNIlzl5qqvXGbbHGLrHHkpWx+h6NLxvxf8858bc5qMTfQza?=
 =?us-ascii?Q?kfrMA+eqlWcmZTdioLRMUOZNX3Mwb6iOw+aJGZZZVpdqu4AvU1xfjkhc5uo6?=
 =?us-ascii?Q?SLKjBogf71wrMo/TYQ0/VtK3vg0V70aOpweoR+SESHuuNre+OgfJQ1QAGQFw?=
 =?us-ascii?Q?hViGGUZ/6hbovyEUmdMc1cpRFPumCHC1FMYT1TguoHl9WSK6Y+xnf1xp+iLs?=
 =?us-ascii?Q?W8+DTMaDBd70A+NwBRbOFW7dbmgf6koHrz53zbUNFqKBQ+bl7tcgIG5r4zyw?=
 =?us-ascii?Q?W3eY6b4bGb7nyGr5Vbcdd8RD1mmNVtVcfYzlFGOxCZKMlFH3WFA9ZHrflvPR?=
 =?us-ascii?Q?4etM2lnciuA8+bE21FxEXu6UVO3bQCCGJXHtPOs/ytT8z0+eg06e14qK9z5T?=
 =?us-ascii?Q?RjPJnHFMljSN7kcc2et9h347Ha2dRyACJoAvUn5UzdO7Yuha+AvKGiEHCrGA?=
 =?us-ascii?Q?NKeJABCR+UdcBN+Xj01N6Ujd0RktUBp67Ggb7I/ZAu1asJ8h/oJOxv264usY?=
 =?us-ascii?Q?yGaSfXTC3R/hO55JVR6YByCyFvAR6z4ljoM3jtQefaLFhMDoFyKcKhwDZ3vf?=
 =?us-ascii?Q?ua43kiBjtkAL1R90YeK8KMYhWYFfvrKYYWBeaRr0hCOy5KCH8bMloUWF/5pR?=
 =?us-ascii?Q?M5QYXi8OT8PsKBBmdwnMKU+s3efN56c5obmchiBaNYKDMybWyqas6hvNCrod?=
 =?us-ascii?Q?cNrRZGnVxmNHDHNjgrIN9rrTzY29Bk7+ojbh8hQ/H4TN3MBv2aD+5ki8DWqk?=
 =?us-ascii?Q?gap539eDd1kDEFe2VAOeUQlYKKuoZLnzaDLhb/yC2XaSghWfs9acubmtempa?=
 =?us-ascii?Q?D5RaHgdHbJTYBInTBzjuz5r55CHTZnqdwcTf6aP4474WEuzR78lvXm5oYXPV?=
 =?us-ascii?Q?usbs+SVKTzfgNRxbCskVoDSWi7qp5/HGOo8Uc3Ma47QQ+9a8C/ClacFkFauU?=
 =?us-ascii?Q?rDiYsP0HDDA8jN9AjtFrsNut4pa2kJCV4HfG9otvacOspjGSF8Mx7JYZjflK?=
 =?us-ascii?Q?tqzqBzsjn5KsfXNbotPRClkJvQFZYQGgIXF+7K8PpIt/Wvp+0PCfCTh82WNZ?=
 =?us-ascii?Q?BrpCiVjcuxe5yqtXSRKeqcHwwPefiZU9X8GYBsOXCYYkCA2VfwudLDjuDF4k?=
 =?us-ascii?Q?3l532D5AJzEbBHb52iLmmwIrUyxz1SsNa1YN6cozWslm3Q7D7gWhUWRWQIvR?=
 =?us-ascii?Q?/JrlI3x8mPDUDuwghwGd3C7DjmQZQ5soo0owB1eP9tB6EL4d1R8cIdWM4Dnq?=
 =?us-ascii?Q?47pIcvRLW2/6fN8d5NabgJU1AvYspawu12jtK/p1k90GAak41R/m0XquPnPs?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TR5CI5HGFDGntasAJpbZw5RBMEtdBNMd7iF5sgzYmZMHESJOCFRChTrq68Vo50L4LYIdkWTVXZLfxz5omOL7ZXoyq9SKyljCXZpcJCFG9KrMqMT/Yovnx0rjBYXVo5EGb3f5za+uAUlh19kpfofhf5hUb4mJoS1gOdIi+1KqMu++yiPWy2uQOXrq8uI5pjO85J++/kVnjmwfOgsfO8uWJeZb/ru8LXeklW19JPlTNeNyl38t0rTP2PnSY3NyhGrOF4vJXnf43TXK4kOU70NuTwKqerwVaei7bxtz7HI5IzV3/s9e9Ks+y2MvG2FfKWuHCTSK/JnEddJovWvFT+fKBvPAdN89/DAgyzEILbKBo0k8Kx3FsMl0VdxM88ASFUfpnZkC7kny8/ZcdxLXSBDe6AvP7klZJJC3lIff+xuWNVcPnMPk/qG1n3HCJoK6pgSpnLpvzBn1isJFDKVFCJx8xnl6IsfAwVw1IbAUAM3VrjAdEN0YNTEhoaQtMDJCxjkeEBcPwM/HWaQzwhyaghPuy/H+WsJ77aqmSxIKj+4RsLFgN9XVZRy7/cGkLx/CM3RD+mQf0WUI5bcKOe6015BZtOcsacq5W8YrX2lXZ2WQm06Or9QanYkceEeUlxgVqMAv6tgqgkvVlw/dgO8WU3ofR5JtbKYbEYJomOp0MstcH3SbtnwrUauObuDahVBL365fSiG8/mjaM7W9BDHCDSE39wOSDcy7owhW5E7ZaGOJJ01zKury4GFViD8MhxpnkDNKhIzYW1aQTtgn8ZY0QsKdHczf7et+b7VpeEM+dCiH/3c6gkx73QDHzOoipd4E/NoJvNgoApNlHHK+9grG47HDEdxJtBsyY/PfBtKi0zNqR65ib/53BgdRlYjxzXEp0W7F7AH5OR50hYhVYr+dOxXR5w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f838c09a-da3d-4f7f-4586-08db4d904d53
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:43:57.2123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QawuG0CLqHXL+lzdg3PzY5EXxb3eABbfQfM06N825NZgVpNV1z1ssj/OWexxM5KoMfLFue2EIwwnme679mzzqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050146
X-Proofpoint-GUID: QrLV76Ilo-Cwoq2-kmfLUs69XoD8go7A
X-Proofpoint-ORIG-GUID: QrLV76Ilo-Cwoq2-kmfLUs69XoD8go7A
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use MT_BUG_ON() to get more information when running with
MAPLE_TREE_DEBUG enabled.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a28b021f740f1..c3ce2bc594123 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -194,7 +194,7 @@ static void mas_set_height(struct ma_state *mas)
 	unsigned int new_flags = mas->tree->ma_flags;
 
 	new_flags &= ~MT_FLAGS_HEIGHT_MASK;
-	BUG_ON(mas->depth > MAPLE_HEIGHT_MAX);
+	MT_BUG_ON(mas->tree, mas->depth > MAPLE_HEIGHT_MAX);
 	new_flags |= mas->depth << MT_FLAGS_HEIGHT_OFFSET;
 	mas->tree->ma_flags = new_flags;
 }
-- 
2.39.2

