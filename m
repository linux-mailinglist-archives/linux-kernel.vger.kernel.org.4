Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B936E0038
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjDLUxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDLUxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:53:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DF12737;
        Wed, 12 Apr 2023 13:53:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CJTWm6007826;
        Wed, 12 Apr 2023 20:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=LVRBXwMkktKNrIJhzmiTuaNht5Oct2+j/Tpu5+GMZCo=;
 b=1TDLpJZQemr1jtlP+Q4XAqSmGH8BLdluaEv7uV7NCg/lmSOOEGJIh/PEsUoSdM41wYsx
 JUP/S/KdCPBBpdBp4kfZJFeEYz46RIuZw4ELyweZ3eshDEFsFq3/C5QohEDL76rjyPQs
 23kWufp8cvuozruCIEhQHwy2aD/mYkQful5EGGu30xekFdKetmeuvBoPvdyrF9CM/Ffc
 jGEI/grTs9Lsqdzmcg9cYj+nzl+qQHggaUKBzLko4p5/QBBhuZJ8uyXNxT1vxYpQecH0
 wK9yzJgtT+nI75wvGj5A//KulRnFlU1uzaPMBrn5RDc2iqB3DHNP6tnBX8dx517nPsJL kw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0etsa1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 20:53:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33CJk0K5012666;
        Wed, 12 Apr 2023 20:53:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pwwgpxegx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 20:53:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBdapt84zbmy5vqDNWPhHu87SO6vY1eVdTiz8EQ6N58uZqQkHX9P4+JIpWR2Ho97iYvyWo9rjj5cNsC7RwXUKe3WmGuhYO4FeeCcIs9NrHGa0aAyefn2pun+oc8KvqH09Db6akptXe/a01nBt8bUlPfR7+qbeAkHeM00J6uKLUiDuFm85RAJdKWqMWB8u3A8K9+plVOfcybMFAVKtvUd6JSKmVQdy/4GkdBPS+veh/YIpYAKU+Hla/Nc2D3IgIdPeeRMqpHchC0BaTrls2qjVy95O1F1yKTxsl3ug5D8upCHrbQrcGg69t1tN5OkVnI/j1eC9w7S6gzTkAamS50dsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVRBXwMkktKNrIJhzmiTuaNht5Oct2+j/Tpu5+GMZCo=;
 b=LmCt14iJ9assmdvWOvVI03CnXKFV7t7scPjVHTpk3T/S9iL+kewWgXS5iQSA/+6A6XK/imWoC5ZPbqpaS9milxvIuo8d3KKluNlTlp5l+66T0psRN14DrIKEyUa3l3vRgtSNXiolUosqqUj2W28lfQu3h8Vh1PpHGPyWEh4GyCANfhALsQAILM36h5BJE3UecZSbOKJiNg73H35C5i53PO3npi9Z7ZDVTVwshVZn7Idm8sJCRgAcxipm0iA22mkQSdjyh08DRPYBHfYImFMZJh3xy3UoJX7YBikyGqWBHAZc9yK/wAB5/y1jGjjk604mKvmUXvHm7lzAtFWZN5IN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVRBXwMkktKNrIJhzmiTuaNht5Oct2+j/Tpu5+GMZCo=;
 b=Oime8J4aqtidLSulUBwSiUMb4YkrryYVxY3+O7ZqqrbR89/dfQwFYwn9Q7XHFK1wSwP580TR6rI6XY27EhvR/SUfx588AUfQqOEk6zWsiBumbwJ/8ssLJ42iJyjaEWR+KZiNU4u0+aw7BlOHLNx8soFzW4s2bfWrHaMpS2rAtvk=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by PH0PR10MB5548.namprd10.prod.outlook.com (2603:10b6:510:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 20:53:20 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::b3a1:e02e:37d0:afa1]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::b3a1:e02e:37d0:afa1%8]) with mapi id 15.20.6277.035; Wed, 12 Apr 2023
 20:53:20 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        nathanl@linux.ibm.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        joe.jin@oracle.com, junxiao.bi@oracle.com
Subject: [PATCH V2] debugfs: allow access relay files in lockdown mode
Date:   Wed, 12 Apr 2023 13:53:16 -0700
Message-Id: <20230412205316.7114-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:805:ca::38) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|PH0PR10MB5548:EE_
X-MS-Office365-Filtering-Correlation-Id: c104e925-ed26-49db-f007-08db3b97f2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyB/EvgWDgn9DKtdJaSGuCD+VtxSI/SQsycgi0IVXieWo2gkXud4WkAvL6ZrFneloUsC7f59kSnJaDmNvBmewp3mDVN9QPnA54mPzSS6AfTrpzx8j9M1OzPLIULCKa4aNJ21pV+10XbKXBE2feW08Wg7BIc7t6qocylt3H1CTOU5SNTXOoR8Cxlbb0aWyZR8ivFCKSHfg0RQ5h0GHVtmirap7tUI+Iv1VNNMTpo/pnvlIQ4Ey5O/AookFYmll+Zrrd7kzZUcy5VHBOkhb04rWYmzIYkAt+1F5CVxFAI22oia3VSHNf6WJiWfySyeN0Dq4uuYcjuNUIqlli6VAUFS5zJ24CmpY/FXZqWikwbD5R4EdiPIzTxpYdvZ3t9jAWDC12ihjpdk9PRd413ssvSASn5ZUYNYBX98PXg4jYGQK1EhnWC07qqS0DDAPVSllsr+GqGvIX2wRTgdDUoeMfpDZ3SK0eMpdjg09GbsCmruVjwHKIgVgguQyBAuboX0cl4MGYPMqdIF15xljP/1ErNHaoYJ0jEljD2SjGLjS4qC9m4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(36756003)(86362001)(41300700001)(66946007)(316002)(83380400001)(966005)(4326008)(66476007)(8676002)(6486002)(66556008)(478600001)(44832011)(2906002)(8936002)(5660300002)(38100700002)(186003)(6666004)(6506007)(107886003)(6512007)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TqH8WL0yh833lCICczAszq4GnDdoDDjBU5PEOITItkGTHP9emogofhqQ1rc+?=
 =?us-ascii?Q?7/+GILUkF9zrKFy8SPnKtpzaRVdXWz774qomJKvru9CUILWVs51P7c7DZUF1?=
 =?us-ascii?Q?wO4zBo6Ilg19EwhQM7WZbMlhZb/ufuwId7F4Ffe+yK1WiZyCYYr/76Zdf078?=
 =?us-ascii?Q?x8x+BqJs8OC1vakH6SBTzPF4tdxkU01r0WOwmQyqhKFyTkKPMFgiH1vIo+0f?=
 =?us-ascii?Q?0YE6sBLIDmkHfQGMNdJJUulkwbwDcWD3SEpoEnuok8/wP/a3GPYiXKGxKtPe?=
 =?us-ascii?Q?vjgK9rwUyFnYfIWSbK9DVHZZa7ablRLOQ2X4zU7QhkxGG1Dop85sCLgzov38?=
 =?us-ascii?Q?rOsdGAVK9EzmzkWuHz2I9Ao//lYMjSGg2eMRUTRbmR46eJy3eoB9+M0/8gXg?=
 =?us-ascii?Q?hKp7x/HAzx2bxliwPniIUSuHyOOukIRb0B3wX+UpsMv9vltfuUG+LAHyq7F0?=
 =?us-ascii?Q?S6+LBH73W1063xubN8oJX6U1mdNNbTELd/86kJlSzwm81z9J218V2EimsoFc?=
 =?us-ascii?Q?jOKkqO1S0fh22VrWW8oBj4s07txAb1fXc+m/LUlRVqPOb0AE9GYP54yJNwlv?=
 =?us-ascii?Q?b06H25AF2H7DkJJf0x1MrDnNwweNsKEmL2uifv78YA0dKcvHkgIKTIJF7fan?=
 =?us-ascii?Q?l80q8KRMzA7LoNBERkDgQxOiIzQJfHZ3j5ffjR7Okbj59wHMOunbFdg0nAWf?=
 =?us-ascii?Q?9E6fITPNnDc4LDT6SKCXbtbYL21K+102ada5d5V3GgZNpa2nD3tfrijhcH0/?=
 =?us-ascii?Q?h2C6AenREOPr3MyP8Fqckjo/mdz/Gzvt9K4cFLYIDZKlrpOF2ob+OngADtcL?=
 =?us-ascii?Q?YhKBCEoxcW0bbM6jfPBA1XN8Em8jJSkTaGgrSEJEZ8umx2Gr81fpSYArr0nS?=
 =?us-ascii?Q?crBpuG2qWRa3PCvTVJyWfnPMJyTAh1fc2dj1/1FJu6Q9r8fDeyCSxq/iMHfE?=
 =?us-ascii?Q?P5Cx0kmF9gu+rDpV0V2hi2t5XWl4czJxGFaEsKd7Uj7CLJWsK4aFFBn733/s?=
 =?us-ascii?Q?J8FxRkjXa/eMnSZDAD6oXCF2sa6rDsIouPiNWgekPGa1LNncz5BHCJvk8pfw?=
 =?us-ascii?Q?Vg+UpZrJZ2YyZS5HkIbqvhiuotMk8rmFDisbIlh0d4SWkc+iNQsz7PcO1xPi?=
 =?us-ascii?Q?HhY0x1nRAE6GCeoz6DzHT+zIhMBVtvtREUAgBemRoXq3uCgvaq08cHu816CF?=
 =?us-ascii?Q?/BT2bkhycs1mkRG90avwoMrRRaxJhF4LeAjmBqgutx5FflysR+wsUrWY/gEo?=
 =?us-ascii?Q?Tjf8kEDUgl0+UclcWwdFyOvH9d27vedA1OUrOXKATwImDXkpV2oRWG1ZHogQ?=
 =?us-ascii?Q?oRa9okTk9yhbb8uQ3VGHe9lmFxdOSX+PZu3FvD09MO05KvQSy/sySfDEHMAf?=
 =?us-ascii?Q?bmIhJ1fiXnqTSkU3t5NSxofxQ9vqXs+4lRvJl4ikVKen5yj8G90NDDWwjmed?=
 =?us-ascii?Q?Gdysnm0uvmaZxf6OuZCfXwkQAdC6cosXlFp8qd3NOYHD65c14Szt/W5xJSXr?=
 =?us-ascii?Q?QUl8lmTW7rZkUNVb6sYfXbLmTIcuKKe6PxADqCqTtPrh4JzkuBCwkFQbzYT8?=
 =?us-ascii?Q?bLxXyrVQ544SAOmpIyjvgCuy8UgjtVp+9iO6UdE3U8wUA0iomf6/xADauJki?=
 =?us-ascii?Q?yQfrXWUXwl9ELNI77C3aUac=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YfqyaMiu8J6AUgYFPzDCamZeQWu6VoRMLGX5EqGssAJa8EWeg/SYp/vWJ5XjS6piZsNfgvDstxd/G6Ddt38WCm4nKqPvUzr6oYPrFIwwpvJIa7CXuSdc8B6vGG3yXO7EOmN0XkcLrRCjvpbcuCHYNNdpq6oNnTPAuIhmVDSPh78HvBv1kOl+huFyHwhcWDNf0L6u0Y+gReAqS+O05+wknASBvefPuEgoMoZXo643V9EiVQpxJSenJFXe56UCOkbP9gmDChHEfPf/a66z4bbizDo2JvNOy1lE1BtpNnzmjDKFT4inHaHjULitvgOsbmei/SOaAQklzuf4DKZucHHoBYqAzYvstdtS3+7ZgXB2ca28SOr6pgrVg8WlvGa3UXkcry7r9deIBbV3bWGqGWSXdqDlPdk4mLGZhHW4ykIVvpG8nwYfqc3qlhqXMmZbonJ5EM13Kl7fPXuKrVrUF8wHvd8TzNkx91gSFz9s8CDSLJDunRsT89TGa+JPSGl9sQ1h5Mk5uVJkcAinmqfIjaUJr+TswoiESXX1uKQxn6DyKaeEmFji/x5+rBd+0kPAJhBKpGF76rEb6RjqdAs5btIMvkrkZlRXnj1yqhhXuDx578u0Q2KVYFnTLnsdalyva3quiIGgGMJD/k3M4Te/xlnI1NvMc3xdkove+WGWXRjEPwP8corxBROJFAbA3t1d2YEwt2RR5w7iWLmHsNRBBIe7fu7rUFqyBkhjqJ/ewbZ+0LHK3956gLUAO7dlPUmyz0qZZA2WhwQbHqJj6mAJnkyaBy0q6uR6keW5jQf08ypGdhvjMxHqVyBHoy6dGKvvZVTrDkgyNEkq67+fh3JMhaSj0+IV4Kll7/PgghGw/pqYBqCt3IEkgQmJ3ZKraIDLBnOS9ChB6LYbvlpvKiy/UBfYhigGBbv2F7pUcsKrM1iIbfw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c104e925-ed26-49db-f007-08db3b97f2c5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 20:53:20.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkbh1fQL01aBSxZmFTEoy36b36PSwhf2tKZMW4GQFxmQbG8ZdAnhFMT8LSvxhmxHAg5BaHNUZRNF/F+8Tevz5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_11,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120178
X-Proofpoint-GUID: 6K85tWasJqlKPJjfbVQroJJJ_uUY1L_j
X-Proofpoint-ORIG-GUID: 6K85tWasJqlKPJjfbVQroJJJ_uUY1L_j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relay files are used by kernel to transfer information to userspace, these
files have permission 0400, but mmap is supported, so they are blocked by
lockdown. But since kernel just generates the contents of those files while
not reading it, it is saft to access relay files in lockdown mode.

With this, blktrace can work well in lockdown mode.

v2 <- v1:
Fix build error when CONFIG_RELAY is not defined.
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304121714.6mahd9EW-lkp@intel.com/

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 fs/debugfs/file.c     | 9 +++++++++
 include/linux/relay.h | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 1f971c880dde..c52c94e20366 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -21,6 +21,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/poll.h>
 #include <linux/security.h>
+#include <linux/relay.h>
 
 #include "internal.h"
 
@@ -142,6 +143,11 @@ EXPORT_SYMBOL_GPL(debugfs_file_put);
  * Only permit access to world-readable files when the kernel is locked down.
  * We also need to exclude any file that has ways to write or alter it as root
  * can bypass the permissions check.
+ * Exception:
+ * Relay files are used by kernel to transfer information to userspace, these
+ * files have permission 0400, but mmap is supported, so they are blocked by
+ * lockdown. But since kernel just generates the contents of those files while
+ * not reading it, it is saft to access relay files in lockdown mode.
  */
 static int debugfs_locked_down(struct inode *inode,
 			       struct file *filp,
@@ -154,6 +160,9 @@ static int debugfs_locked_down(struct inode *inode,
 	    !real_fops->mmap)
 		return 0;
 
+	if (is_relay_file(real_fops))
+		return 0;
+
 	if (security_locked_down(LOCKDOWN_DEBUGFS))
 		return -EPERM;
 
diff --git a/include/linux/relay.h b/include/linux/relay.h
index 72b876dd5cb8..914f116d826e 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -279,8 +279,16 @@ extern const struct file_operations relay_file_operations;
 
 #ifdef CONFIG_RELAY
 int relay_prepare_cpu(unsigned int cpu);
+static inline int is_relay_file(const struct file_operations *fops)
+{
+	return fops == &relay_file_operations;
+}
 #else
 #define relay_prepare_cpu     NULL
+static inline int is_relay_file(const struct file_operations *fops)
+{
+	return 0;
+}
 #endif
 
 #endif /* _LINUX_RELAY_H */
-- 
2.24.3 (Apple Git-128)

