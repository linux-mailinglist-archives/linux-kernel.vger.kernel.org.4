Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A289F70882A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjERTCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjERTCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:02:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D2ACA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:02:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6JDwi018330;
        Thu, 18 May 2023 14:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=b6NFuY1Cli4ZxcQEF1wHnuQb58sUXliXR5M9M7xX02Y=;
 b=yDwp6wmDBM9uW6tcSjWCdUd9ZTDYfLmtHlYTXfcglePt4veqm9MsRt9h5gLFNslNerda
 vZq6ogYU+wbhTXQkGeM0tYCkeQucy5yQB/2E4ylu8IMpH5WgcPGfm+7V/5MAp0EmyO9Y
 uO4aHyk1i+flPKbB0Ll3Azyv8WjOQq/hkRd5SkARsFOiiO4SWene1qpwavTfYLO277J/
 KUdTji62eUb2c3056xCQo6bMMbuRaoY0QpczDQSiD/uQ3jLoeGRMMzsTjR0dAMPZF0DA
 wIOkRjmcRvYugyZj8EFB0ONQ/pCavLg+LzL7Q9CEXEJkRusTaqO2I+YCvPcRgwA0+nwe qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmx8j2vnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IE1P74004143;
        Thu, 18 May 2023 14:56:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10d66wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBGPGOfrbZ3zfrPoMRq1esGh2bwI6bbJwt0TGYOA4K1IYtRG8bpnSeW4ollXATZ3OdCLQqWmitH24lKsqW7F9tkO5f1Q6IOP3T8nkNIzoMP7sRTqr10ZfGRON8lSOZ3ZmPqN1NiLSM0SP1mCwJ3yTtR2DW+DYjc9ubIG4Z1AVYwzUD085C0+8DWPoA6FLzKS1hG20Ht5p7qf5w76FFs/UG9vhJ6IKzrh7MRSwL1/lx2QWs05tJwU61a1hoLmq4KamNpoNCy/9XHEcXI2ptVOoot2wq8zafqFRKwBu6d7mrHGgXIc1RWe4eg/xVIkQkgVMXGmB6uaNX4GO9DufNYIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6NFuY1Cli4ZxcQEF1wHnuQb58sUXliXR5M9M7xX02Y=;
 b=UGwxfDxGZ4GJGIeyk6v5aniHTxSnaZeyZPwTsbv82FAVsbHWQdX9+G5ew/NJ/NI7omVCHi6qNfcNTogLoQoA6r5CRhjPbX2Rf04E6+0ZFHaFYQZ2eDUKQ6vJbPJc3VXl2suBRNjQTmPkx0e9M3aimwLZ77L65/mQKkEHSYojuH8AnosWWhZjfuI2tpHColUL6oZy9kD0H4TLwChAI2f9notUTvhhNkF+wp4QFaqaLk7MM2Q5PkJ0jJ4nROVUH3R9aMgN/hakxCCxRMQPP15kmXMkIqdBB+OazPD5sUx/xB4PWS8mHs3a7IvNvK8SO2XEXb4ZJbhobbu84BvPbLgaLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6NFuY1Cli4ZxcQEF1wHnuQb58sUXliXR5M9M7xX02Y=;
 b=NC1AfEUWqNr3kF1+QBHgbB238jZiGAGRE2IjLe88LWEBNyQPhBs48MgxtDx9m/sMeMJScKIFAuc6xpmu2+WAZBhqUNnFTSKco0lW4dNTlkFoPhLOlst3b59MRf2dI3OuT4kFIcxYCTu/K59rL3e8fPrfT4bXZmRxL5uVgkk/ShI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:56:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:03 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 06/35] maple_tree: Add debug BUG_ON and WARN_ON variants
Date:   Thu, 18 May 2023 10:55:15 -0400
Message-Id: <20230518145544.1722059-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0290.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6a7bf0-50e9-4a80-c2cd-08db57b00030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s3UOWhFza14ewH+TPTmENd+LGzNdwxQSqJyDFhl08B3GcFZwFOh8SUKpACoMcNug0Wzo6RLsxzU8UZVCYAqreNQocyRQ0NJA58XzRES14lIeYuzfVs6eNmqPfW81xOGxyt5gTaQ1qgPmCIrZob/lEoKKz91cJgmHfqsftXPl4OASjR38SSAE46hgmjo8BweCl137S1hsOXtwOJRmdrdvX/Goykqex4SkEqzIaYh5TQA9LtGBra4/bjZtbwyvrWcrVbwRAvT69uYr1HW9HkTOWUb20CkVZ49gixZSjSt0Y9ctQNTnJaogavbmUdz0ZIVrJmZUBqaIhWBOCzS3t3cYj+/fqcymRcDQuJXdAov+O/6PYoRIkihC+g2P3l5yAXHYgSFbppVF7PA9V6C0RIqWhAKuaaIZ8mMlsQNAsv23pCB71Xjq8BDqDVFjjrA7Uaqq2TjoWudbewM6NOofrZDtEAvY7XNoqdzqAbzMhS4VOBKGF/5bR+6pFFQQYDFr0LaF3f5DyXSRGyxX/p7k0UUAXloacZRQEBbsEGC9SAgBz7OKZWQg3AlK53VYyUxaPFJu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(6666004)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(2906002)(41300700001)(107886003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1wqL+IfcoMPPn6Nm1UVuTqOSk5GjjVqcz3mh/OAG1npxoccOOYYrDZ1IwvcW?=
 =?us-ascii?Q?JORmQXyjaXcPJvTG8XtC4KgxVE1l6IodFe3sQ3PxMDjnXCC9nIuWlt8rF6CM?=
 =?us-ascii?Q?7kWikAo2KCfWOgy+Robq0VZMT1vfdL8s9xdTMvSCN0AoPRNmVcgJK5ai/2gF?=
 =?us-ascii?Q?pVlKvTbkF/ojl9DcYrYi/BtId+kLMF1nENxQJOflvgYLqFxXUU7fLbKCCFhg?=
 =?us-ascii?Q?D5bVzvtXBySWQrVqnxkR2ag9MC6fmHl+jYXM2MgF7cMWYI6kjAfzyVBdXmWs?=
 =?us-ascii?Q?Lzb9zhuI8wE/xy4cxlBt7t294toXyNttAv+fByrxdH1dkTtxOrNyQyakDyJU?=
 =?us-ascii?Q?15H8ETxAHsFitMJmFTlFwBWsKmd0LtjgijO5pAlZ0frJzOHhtMSsBMnBGKnb?=
 =?us-ascii?Q?89WBgDAeoddHeScn7Dfpw6L8DCzngwZUm6/Q09kbIybtAaWauLO2HmXSdJoL?=
 =?us-ascii?Q?zJYxYxFN7W1G1TqjKcOttymVfqAvO0xaemW4k5+ttx5hLQA1jZ0y5V2sFrqV?=
 =?us-ascii?Q?EfspkM/9R2s7wylHuKslALqcDbdFd9Eu9bGCVoj04mLlzOyRPXA/vzIi6y4o?=
 =?us-ascii?Q?eYGaAwu6F73uN+3y8EkL7DkpSPA8jqS/STzJh9zIFxcZ/oTtAj29DQck9tJ5?=
 =?us-ascii?Q?VApntyEGM58MIEPu+4e4BrcXyFopxU8kbRP9SPP4NMmt35Af9mTOR98rCkDO?=
 =?us-ascii?Q?5gfj38oMtl8V4yQvkQOPe4sHSU4eXG3HYH5Aa2pWIVyG1LVIkjLwlVn7Atrc?=
 =?us-ascii?Q?sreUVZMa/Mc64YYKByFe2mdFJrmiKoNMwBK1RY4eHgywder3YVvEiXJLpfjY?=
 =?us-ascii?Q?l0HndvbjXCInDLAnnR6NKgyzwVzrD/tgiDgSUFM9COWpvsiFl7uac0TXyBTf?=
 =?us-ascii?Q?+XTP+cq5VGsrLwxXut61utWhPmV0JpYzmPA82ZArjXUg4U91eon3ZTtC2ScM?=
 =?us-ascii?Q?NvkMll9bk4o9a9wKjrF3oT7hYAIoIaRmp6pUt7xEnFSKDZVKfBgWxtqzW3h+?=
 =?us-ascii?Q?cM/HfLI/HtV+kRthhbROCXp1E1wXtCdjlv+bxZY7MJqpIvYC/Xs3fzZCaufC?=
 =?us-ascii?Q?tS4vvcyfWTlsE9s3FVH1DJSDeWpuz2UnH6C5k30sfdrQJSpzmcjZlBkMEOyd?=
 =?us-ascii?Q?izn1sp2Z7rzzuTPhTsXZ1ViB0oQD7wlM9ptzsh7Jm5mv3jPl1Meo02UYGo0S?=
 =?us-ascii?Q?489gLJGqezzr9TZqVHrnrdeArD/QxzuU253LrDDBHFz6ZHr1oiRkmc96tqWB?=
 =?us-ascii?Q?MMicLLMUUFukxbRI14UQmkjSbAHpS89KNgc2/kwCzrW53DpWcPyD+igy5SJD?=
 =?us-ascii?Q?1wOFCeCKrR4+xvoc06Buu6vEs9vYkXJcg3QJTZClBT8svwVfVE0LUfaVLpdw?=
 =?us-ascii?Q?Jaz7EeOn1POHn+7590xbwot+d8Ye+1fVQAcrp+9rWKvvPN1i42LFQI08OTTe?=
 =?us-ascii?Q?60M9U+7/5jb4XLFWTf0WzhVZSXmGiOIronzjz/eKCD/o6UAiKmabjNFKK1vT?=
 =?us-ascii?Q?Vm24la9GJfzTIaUBux4B56aU0wOibFyBEFY+09OcLaO1rQJbsKqtLa8gPUr1?=
 =?us-ascii?Q?9SZJwpRO6BhY8vYQVwyKGp+K3gXJK81cD+iLd1oQS2tOBbnQ+2hbiExZkwvY?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dDvc0x8Wxiyhw5Ib+H67gNNDbe6S50HBQ5g9jCY2NYrfynmMtGyo+i9n1exff+8dsrXd5J0g8pxDfc4nTjdZTXv693e834jRFfCC1DOVqqhAQvpJw5KeRulCcCpAZg5NoQQy8h/0YyDSq5Rp/y4Fh6Hi5ooZ2FG8j4rN/HCfRJyqDqQncxEHwphd1yQpZSq4LPEG9HDW4Ndb6g+H1ccm3kQicPt/VbW0zsfovAGCk/YLltrqCbHOMPcj2Y3H9/yPzu9TjmmJOWubeSmshNVogewouWURYzjA0kFaWnOMDl6DrFFQ81xOT9QnZ1qgdEQBokBEW2v1UU+AQ/sPq6jbEG7RaG/nGXqv9s/lFv7FyIfG7Zj3IQUhA/yTlmM/AIcoQ9QWQt7wbc7WoBKZBNd+nxKTXCL8NEJG23Cn3ElJzrSG5X7OfDuGXmi+qUZOzcjsXZRc9J47HrBegbzzloPduFeR0b0wuEiVAvT7vxYXQinXoJkbrU5wIdyXKWq3BZ+k3/KYnRvgq8+wtoRj09X7er7gwn/BAOPFqYd39s4FHGai/6bw7l5AvTRmzCHIsV/jBAg8aqv3QpopUD6Msww7flNgfWYjf78deqYSjusqr5K4fgn99ZGJ3cgsZWn1O1DUkGsHhfJ+3/x5VPd0prc7YUJZjtsHzXkb2ZCrkLwSDXX730VxJvfo3snZqnZ01Ai0pu7mUXRu4tl1Ww+MC3lrTM+ONjBRo31GLRpVkRN1E4JlDxBNixEA8OICPZMNOMpKFjwtFyw4Kh2V72KZ0ZJCfqGxmpJ7QXv6vIMg1N9kEni3IU2CgBEagFNtE01OG9cTgpOZSmAj1jP+LFbTaSvj03lTHs/7zt1SQZ5eC2mf4Yno54+6KMssG353wXCFXQdzUzX0iwRhETirweYATMCgPQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6a7bf0-50e9-4a80-c2cd-08db57b00030
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:03.3136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkaUwxLKA75uVd48XIzEohHL7O4CUOce6j2dTVot5Ee4dXBoQryUbFgsXvNWGglwcRNsXAQDXCJHnomsq5RvPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: 1Jc4f_3Hm22FCjvyvbpPXhgK3BUVPG-Z
X-Proofpoint-ORIG-GUID: 1Jc4f_3Hm22FCjvyvbpPXhgK3BUVPG-Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debug macros to dump the maple state and/or the tree for both
warning and bug_on calls.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 100 +++++++++++++++++++++++++++++++++++--
 lib/maple_tree.c           |  34 ++++++++++++-
 2 files changed, 129 insertions(+), 5 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 140fb271be4a..204d7941a39e 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -482,13 +482,13 @@ static inline void mas_init(struct ma_state *mas, struct maple_tree *tree,
 }
 
 /* Checks if a mas has not found anything */
-static inline bool mas_is_none(struct ma_state *mas)
+static inline bool mas_is_none(const struct ma_state *mas)
 {
 	return mas->node == MAS_NONE;
 }
 
 /* Checks if a mas has been paused */
-static inline bool mas_is_paused(struct ma_state *mas)
+static inline bool mas_is_paused(const struct ma_state *mas)
 {
 	return mas->node == MAS_PAUSE;
 }
@@ -679,6 +679,8 @@ extern atomic_t maple_tree_tests_run;
 extern atomic_t maple_tree_tests_passed;
 
 void mt_dump(const struct maple_tree *mt, enum mt_dump_format format);
+void mas_dump(const struct ma_state *mas);
+void mas_wr_dump(const struct ma_wr_state *wr_mas);
 void mt_validate(struct maple_tree *mt);
 void mt_cache_shrink(void);
 #define MT_BUG_ON(__tree, __x) do {					\
@@ -695,8 +697,100 @@ void mt_cache_shrink(void);
 		atomic_inc(&maple_tree_tests_passed);			\
 	}								\
 } while (0)
+
+#define MAS_BUG_ON(__mas, __x) do {					\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (__x) {							\
+		pr_info("BUG at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_dump(__mas);					\
+		mt_dump((__mas)->tree, mt_dump_hex);			\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+} while (0)
+
+#define MAS_WR_BUG_ON(__wrmas, __x) do {				\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (__x) {							\
+		pr_info("BUG at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_wr_dump(__wrmas);					\
+		mas_dump((__wrmas)->mas);				\
+		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+} while (0)
+
+#define MT_WARN_ON(__tree, __x)  ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mt_dump(__tree, mt_dump_hex);				\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
+
+#define MAS_WARN_ON(__mas, __x) ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_dump(__mas);					\
+		mt_dump((__mas)->tree, mt_dump_hex);			\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
+
+#define MAS_WR_WARN_ON(__wrmas, __x) ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_wr_dump(__wrmas);					\
+		mas_dump((__wrmas)->mas);				\
+		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
 #else
-#define MT_BUG_ON(__tree, __x) BUG_ON(__x)
+#define MT_BUG_ON(__tree, __x)		BUG_ON(__x)
+#define MAS_BUG_ON(__mas, __x)		BUG_ON(__x)
+#define MAS_WR_BUG_ON(__mas, __x)	BUG_ON(__x)
+#define MT_WARN_ON(__tree, __x)		WARN_ON(__x)
+#define MAS_WARN_ON(__mas, __x)		WARN_ON(__x)
+#define MAS_WR_WARN_ON(__mas, __x)	WARN_ON(__x)
 #endif /* CONFIG_DEBUG_MAPLE_TREE */
 
 #endif /*_LINUX_MAPLE_TREE_H */
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 084868865849..a28b021f740f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -240,12 +240,12 @@ static inline void mas_set_err(struct ma_state *mas, long err)
 	mas->node = MA_ERROR(err);
 }
 
-static inline bool mas_is_ptr(struct ma_state *mas)
+static inline bool mas_is_ptr(const struct ma_state *mas)
 {
 	return mas->node == MAS_ROOT;
 }
 
-static inline bool mas_is_start(struct ma_state *mas)
+static inline bool mas_is_start(const struct ma_state *mas)
 {
 	return mas->node == MAS_START;
 }
@@ -7251,4 +7251,34 @@ void mt_validate(struct maple_tree *mt)
 }
 EXPORT_SYMBOL_GPL(mt_validate);
 
+void mas_dump(const struct ma_state *mas)
+{
+	pr_err("MAS: tree=%p enode=%p ", mas->tree, mas->node);
+	if (mas_is_none(mas))
+		pr_err("(MAS_NONE) ");
+	else if (mas_is_ptr(mas))
+		pr_err("(MAS_ROOT) ");
+	else if (mas_is_start(mas))
+		 pr_err("(MAS_START) ");
+	else if (mas_is_paused(mas))
+		pr_err("(MAS_PAUSED) ");
+
+	pr_err("[%u] index=%lx last=%lx\n", mas->offset, mas->index, mas->last);
+	pr_err("     min=%lx max=%lx alloc=%p, depth=%u, flags=%x\n",
+	       mas->min, mas->max, mas->alloc, mas->depth, mas->mas_flags);
+	if (mas->index > mas->last)
+		pr_err("Check index & last\n");
+}
+EXPORT_SYMBOL_GPL(mas_dump);
+
+void mas_wr_dump(const struct ma_wr_state *wr_mas)
+{
+	pr_err("WR_MAS: node=%p r_min=%lx r_max=%lx\n",
+	       wr_mas->node, wr_mas->r_min, wr_mas->r_max);
+	pr_err("        type=%u off_end=%u, node_end=%u, end_piv=%lx\n",
+	       wr_mas->type, wr_mas->offset_end, wr_mas->node_end,
+	       wr_mas->end_piv);
+}
+EXPORT_SYMBOL_GPL(mas_wr_dump);
+
 #endif /* CONFIG_DEBUG_MAPLE_TREE */
-- 
2.39.2

