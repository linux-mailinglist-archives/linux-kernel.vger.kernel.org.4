Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4704E6B715D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjCMIpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCMIp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:45:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480D222798;
        Mon, 13 Mar 2023 01:45:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D0Ighh020044;
        Mon, 13 Mar 2023 08:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=RpfwjlR5NSIsbG1LgT3/6b8EwaISwikIKxQsBbflVmc=;
 b=nuRF5nZUQ05zR3tyMP3qTZHnNZkUJBdR7ndxrdr8Tw1uEPncn7+WgErkCIW8+WDg9wYa
 Fir9wUZjuS5LPZSIfJgA63xVPRCMCsw+2h9F7t24x1J5XRjJgQuINUio1mALO6o4b8G/
 MgWYFClW/SPHadySxZpHpITAEQ/WtGQBCqDXrQLhyGzkuY6pXPTcI11oLnXxy65Xpbp3
 e9Tg1ueSqWoounXRSJ9VJQtqCwVytDawrMqL4uaiTdvM05q1Vw+K/8uFtRCYpciTFtMv
 ms14UoMUmdIKTqcdQnQmZRUZQjbPlMaIplDjn8IfN09iTwASCW3W0fqCTQaFSDW3CnRS Fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8ge2u99p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D6q9Lg008306;
        Mon, 13 Mar 2023 08:45:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34b4d9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMhF3GzFuIWy2xy9aoiVhZanI9vtvMhrkdTEKI+F1qRHgVXN1K/5tkwNwJBWcFyp496rJtyj6xuVWP2TL3WHqyrbWT6mPSf/BlrqbsQg6MIT73kCFtLEjjmOxNINqXJlTyYKdaDzOCqFxPxNXF5ZROiY87F2tpUx0BMFn0j1cW8ez0ICfOlkdST8OoSz8wURnOGQd9M61uu2pp6cWvb2Y714GpVBMam0y21Ysz3pgrB7pAkMs0KEK6q083K8+xfd01vAyRv4HOatwUxwrnOAve8XLjDxZssZEbCTTpgUl5eMM0AEA+QnCMTastBE5khJnMGYOUP3W4kxS1cjvtX62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpfwjlR5NSIsbG1LgT3/6b8EwaISwikIKxQsBbflVmc=;
 b=J8i5nXSVfDiA9Zr+7+2hEegBX8tNskL4ocKYtdQHzBa45Mbx2MN/ImQPUVeXuEpODcI2CiXff2ijUTFXpLXtIW9tgSSkJPO66h+kAeUILemPHwx26vyBW7G/f3tKuz8Q32hX2P80H4RL+/X0ummDjerYl9wy+iMuRIyg7CqGpXXmVXfLaIlaC16qNZMQh9/UNtKtER+hgUD1DmdOKdVyM4Uu7IZ1PhOpmCW1D2k/+PxRpLLLLHp3jSxu4vp7ioxejXGnQ3tzmrG9EH0EG1USlYLt9vuCv5jrj+DOVBKNYKICeAh2qCkKp0hWwl9nblQtg99rn9aQz43KnSMls4M5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpfwjlR5NSIsbG1LgT3/6b8EwaISwikIKxQsBbflVmc=;
 b=k8FfmTs5u3Jwd62kW0fTf1AviBGLNBvIV29Xa9kq40wa+lv+cIn9md2Uq5TSXfXQPkceXfUdLf5dj8mFooSGqyr18zI87q4sT32+LuYXEeYQ7VenwZjXR23P7zgofaqbft0oiYC27ySdHy9KhC1jhhT4IcSEQ4F7Wl49eOJGuv4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:45:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:45:21 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 01/11] scsi: scsi_debug: Don't hold driver host struct pointer in host->hostdata[]
Date:   Mon, 13 Mar 2023 08:44:56 +0000
Message-Id: <20230313084505.1487337-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313084505.1487337-1-john.g.garry@oracle.com>
References: <20230313084505.1487337-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:207:3d::37) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 1078707f-7070-46d8-b06e-08db239f4774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tx02ZKeb0GPo39Nez8mJLyAy+hSbCB+ivU422hHaufcinkz5e2WWgbomUT8nrK2/kccph0s7/46WrWf5fZKF+CR7wOHODP9dhZBuQT8vcTbwEaEDsXHVtmQPjRa2LIq0nlZBVz9O9vsZVflipMrVkEcNnuJ3pzbLrqtqxR0gJSnN+vTMucFuCFlkKHvk7oXt3FYAz8OgZpPIAVbIuhVeudF3enDrgWosZ3ZNeULx1AeLT8ZGSrER2jOQ+6QI5kt2RejwzPQpr1Y6+oUB9YQxEu7eNeRGLkLjs8MMsa4a4er9xrRWnYVIP+zIgmoZXYbIDTQZRVTzOmPLY+EPB34qm0JD19dUZ5mCxVAprbgx+S+jEBOqTQTDsKi/t6HRNnHxLFfRXM0MNXQYPqOUl+wSds/5UrZtuHfgehb0lnqjqTs4Og6+r/RdxQkQ+f5vwZrFNN5CCqSC4E59csRmmzHjprrjla7KG1GIYZtfTmwvD0hKdL9dCWbOjfjM8SPwrcGrCqGfclFgoi8qxBv5G4ZZeRJibbYf7ehO4wB1Gy/E+Xzj2oJyU5tkBgqWqf2BwzRydZZqTRivBFBEyL++meRXhN4RUgsdf7KjPZb2WYOjG3Nli3WnwYT6esDRcKd3an+kefHdSC9mFqFXNs8ICnaUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(83380400001)(36756003)(5660300002)(66946007)(66556008)(41300700001)(8936002)(4326008)(103116003)(8676002)(66476007)(38100700002)(6636002)(86362001)(316002)(478600001)(186003)(2616005)(6486002)(26005)(107886003)(6666004)(6506007)(1076003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0iT/Qh5MP2OH4i7wA9hb5cNK4KABdvGN1w7Yvt/ggJOgFYbV9SFwYj6sokPs?=
 =?us-ascii?Q?CSmp5mOSYcsz6anvnJU+To+aaAgUsWnIQJgyWf955D8t3mJNnzaoetD2bvWV?=
 =?us-ascii?Q?KG/EEuOq2STnTDveXGehHKmw3ZMyANjFpUa24rUdZG+I9W6qyBvoBWaokpWn?=
 =?us-ascii?Q?olAZ3dBVjp18SYWfnk529DgZfOEcyh+4sOktSvbMbEIG5YDtlvDNU84c+GJF?=
 =?us-ascii?Q?T6K1FtpSon5mj3YRo7yOYYXtETj3D2RwMXWT3yWWu/ImqanVRtOtDw5CB3Sa?=
 =?us-ascii?Q?eZi2abP+fVMxE3aNCgkSNDpKTGGgtEJtHQSWhwe5jo1VHNLbQuFZsJAbGVFT?=
 =?us-ascii?Q?N++DJe5G3+qUhmqwej9oelZ7k8IKD1OC+a0PDx6vLgmz+1L5JoJEgtHH8UYZ?=
 =?us-ascii?Q?Gkg9WrFzQoJyxaRF8/j77GSuBiQEXORWRvBmw/guzR6hqzuTBSTxfb256mIZ?=
 =?us-ascii?Q?orvyLUSGvlfVlxE0EHdDR1J145Ko/NVuQlFClAwBkdoT1C00Lkto3jO8ypqO?=
 =?us-ascii?Q?rSpQrb+FbkHZ6bqyOxANriYD3IrmzjbYtW9tlPO7zyvqOsSvCkLbqNLpJ+6J?=
 =?us-ascii?Q?SOTpS+pm5oipTDDd/2vddXisbQzB7Dmkh8/4ou52xSoKNCrLIFe3Q6XlscaP?=
 =?us-ascii?Q?81khkrgMcmzftgkV5mKNYYif0jE5WiqEd/7Lj6m9lS2uyaUxq3WcqsxpSUAK?=
 =?us-ascii?Q?bJRst0wDJhrRfH8eqZ/tkEhG5a1JVh0HXyhtlR6lGw8xn6Em0BNgQGQPEoCR?=
 =?us-ascii?Q?9FQvhRnqVQ7jz4c4GJQ1O64vawAV41vyJV6hQtMlwJTwUAxVtmhaEHGo0JP2?=
 =?us-ascii?Q?3f2CaJz++49ii6sk2wVyiqRj867yEVCK3nPm49BqzbgXyR4iqWNG4JQKxpJ1?=
 =?us-ascii?Q?tqtW4JZW0dxQuKtI/Mi7VUrwsvQY8SGSTlSfGMpcrRxyX+98i9zX/x/5frGQ?=
 =?us-ascii?Q?DJzQCtH0KViOIakMa4qtEEjTACJ8FiipYSpMlu1kkH8c/Y+B25lq0M5onC0T?=
 =?us-ascii?Q?44HtQ8uX2Z10SADCJAg/xi1Cybhei3HTFBSJHtZYkMYBXyZbpPgzzB7i6Pqr?=
 =?us-ascii?Q?tQ+skBC2ySSI53owZhr2WMooDULb3qPO05kGDH71SeYZVTWr0WwW0ZC91ynP?=
 =?us-ascii?Q?ImcJN3sy2FPmHxDE2cJjYQyTPwjEWfvy3x+7AbRTQFqQrN/2Ofh6fJx0LUAm?=
 =?us-ascii?Q?IBS5GcWy0Y6ogZU4SbWyD/yMZ7SXHOzmDmkDwNoBxYhMRWXri+ZpMZgbauY8?=
 =?us-ascii?Q?tFuOKt6qMIv/lMSiy9wv/6v4bQGT01v7lURuTfobOkfSnORxLKWjbUsrhyla?=
 =?us-ascii?Q?O9o4mSWdNhuxbUwQp0UAX7/zDmvqYrYyt3ifqvX02nPqLNi+5ac9qPQL/fd5?=
 =?us-ascii?Q?LFLU2EhOjr8LTpH/liaWiWHjpOb/ZIijl2OKsENFAI5q7jurc5xEPHVGASk4?=
 =?us-ascii?Q?il59OpVZt+Ftpy22mLpDiHj+kGAcD+w7No104wSQMOOQHRhaNk12fG3+c7io?=
 =?us-ascii?Q?Onqa/kyCErgNJPFbBBrp/RnO10Kfjeb+jJzf6hOMj87CDKdEPeN/5SBKe/Xq?=
 =?us-ascii?Q?f1TTHi21qNOrBphUDlZKkNjnf94tPIBv6bsk+fQLwZo9VgAO1m1oqcKmC3FZ?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gI01dK+0s2LGgWw9pmbgZGX0PLYQXUnSCNTGFttgYVTd1vbfOByXwbXwxQsLZyPuYIGwzh0H5DGyH1VrAkMrLqvV/8ESdd1YBtXRnhD+o/aiCfPUBzpcHp20z3MOeELLhE0s5YJNnnaG94fYvPoVas9S44AKx6hz8NyGidHXUp7iQSHuvEi44jB545GRtUhU6DDcMRwQzTSaAOOsjOCHoBteI25IzjWj/OdVVcD7GsqXE24I4W4cLLOhC4f8BVFfKHfCiNAoJC7oND8H9NkWkYlSFxohK+EVq/33dTXBju9tODsGmJi+33f0QMHY0odPy1RliHyyHXA4rLsxWZuXdznZXPw1gVPfWWv2eVPsIeccE8YHOnWTc5FkbEpsZemJDgmki11JHjd6+Yb73QzkZK4AqRKC+vIORwzGlitj8VqfsrtmsvCEXw/4E40kWFllvvPHu8SEQkeU06tWQraltudwrxwWeLKvsLl8MGN32GM3j7sFLRvel5Xa8uqQ4nAD0SefeNsyFIVAbXdJrZCb6AqOOk49f9XPgaiW7dMkk0ZORK759hziuYA+D7EhCMrtKPUpgB+9fO6XXrrdG71U5+wgseCllLC9Ob1OiIulW775hy59Y+896Z7N5z42Dz/4jpPcdEl1o/yGXFcVg1K2tijSJl7yUIH9nSmKC7ue8hA3sD/7bx5YemTDNaJtdH/4pY68O01CY3prTwqcXp3fQTa0jJc71/ZSEprgmRnbsr1cXzYlzKJvwlMpWN5vWn30tM5N2gKc64DDJZFFOq/undks9IbPiuS56O9HJgPSJtV3yxxNkVvUYaWm/nnvvXWukqbz2S64FjOJUyqiqo2B149uq2KKK5hr0hms04zJfXA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1078707f-7070-46d8-b06e-08db239f4774
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 08:45:21.0064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0VAIiaRZsqPtE0qsH3izsGfjM9RvMMHs3lnrQFaZRD3FdRr27nBab1oPWSDaZpQNbpqrLB9xP4Y3F5ppw1Hzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_01,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130070
X-Proofpoint-GUID: ycAC7iXlbxVkNKE7CkMKYkcldaedcqI-
X-Proofpoint-ORIG-GUID: ycAC7iXlbxVkNKE7CkMKYkcldaedcqI-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver stores just a pointer to the driver host structure in
host->hostdata[]. Most other drivers actually have the driver host
structure allocated in host->hostdata[], but this driver is different as
we allocate that memory separately before allocating the shost memory.

However there is no need to allocate this memory only in host->hostdata[]
when we can already look up the driver host structure from shost->dma_dev,
so add a macro for this - shost_to_sdebug_host(). Rename to_sdebug_host()
-> dev_to_sdebug_host() to avoid ambiguity.

Also remove a check for !sdbg_host in find_build_dev_info(), as this cannot
be true. Other similar checks will be later removed.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 72149eeee6e6..554c03d7a648 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -324,9 +324,12 @@ struct sdeb_store_info {
 	void *map_storep;	/* provisioning map */
 };
 
-#define to_sdebug_host(d)	\
+#define dev_to_sdebug_host(d)	\
 	container_of(d, struct sdebug_host_info, dev)
 
+#define shost_to_sdebug_host(shost)	\
+	dev_to_sdebug_host(shost->dma_dev)
+
 enum sdeb_defer_type {SDEB_DEFER_NONE = 0, SDEB_DEFER_HRT = 1,
 		      SDEB_DEFER_WQ = 2, SDEB_DEFER_POLL = 3};
 
@@ -5166,11 +5169,7 @@ static struct sdebug_dev_info *find_build_dev_info(struct scsi_device *sdev)
 	struct sdebug_dev_info *open_devip = NULL;
 	struct sdebug_dev_info *devip;
 
-	sdbg_host = *(struct sdebug_host_info **)shost_priv(sdev->host);
-	if (!sdbg_host) {
-		pr_err("Host info NULL\n");
-		return NULL;
-	}
+	sdbg_host = shost_to_sdebug_host(sdev->host);
 
 	list_for_each_entry(devip, &sdbg_host->dev_info_list, dev_list) {
 		if ((devip->used) && (devip->channel == sdev->channel) &&
@@ -5407,7 +5406,7 @@ static int scsi_debug_target_reset(struct scsi_cmnd *SCpnt)
 	hp = sdp->host;
 	if (!hp)
 		goto lie;
-	sdbg_host = *(struct sdebug_host_info **)shost_priv(hp);
+	sdbg_host = shost_to_sdebug_host(hp);
 	if (sdbg_host) {
 		list_for_each_entry(devip,
 				    &sdbg_host->dev_info_list,
@@ -5440,7 +5439,7 @@ static int scsi_debug_bus_reset(struct scsi_cmnd *SCpnt)
 		sdev_printk(KERN_INFO, sdp, "%s\n", __func__);
 	hp = sdp->host;
 	if (hp) {
-		sdbg_host = *(struct sdebug_host_info **)shost_priv(hp);
+		sdbg_host = shost_to_sdebug_host(hp);
 		if (sdbg_host) {
 			list_for_each_entry(devip,
 					    &sdbg_host->dev_info_list,
@@ -7165,7 +7164,7 @@ static void sdebug_release_adapter(struct device *dev)
 {
 	struct sdebug_host_info *sdbg_host;
 
-	sdbg_host = to_sdebug_host(dev);
+	sdbg_host = dev_to_sdebug_host(dev);
 	kfree(sdbg_host);
 }
 
@@ -7812,14 +7811,14 @@ static int sdebug_driver_probe(struct device *dev)
 	struct Scsi_Host *hpnt;
 	int hprot;
 
-	sdbg_host = to_sdebug_host(dev);
+	sdbg_host = dev_to_sdebug_host(dev);
 
 	sdebug_driver_template.can_queue = sdebug_max_queue;
 	sdebug_driver_template.cmd_per_lun = sdebug_max_queue;
 	if (!sdebug_clustering)
 		sdebug_driver_template.dma_boundary = PAGE_SIZE - 1;
 
-	hpnt = scsi_host_alloc(&sdebug_driver_template, sizeof(sdbg_host));
+	hpnt = scsi_host_alloc(&sdebug_driver_template, 0);
 	if (NULL == hpnt) {
 		pr_err("scsi_host_alloc failed\n");
 		error = -ENODEV;
@@ -7862,7 +7861,6 @@ static int sdebug_driver_probe(struct device *dev)
 		hpnt->nr_maps = 3;
 
 	sdbg_host->shost = hpnt;
-	*((struct sdebug_host_info **)hpnt->hostdata) = sdbg_host;
 	if ((hpnt->this_id >= 0) && (sdebug_num_tgts > hpnt->this_id))
 		hpnt->max_id = sdebug_num_tgts + 1;
 	else
@@ -7936,7 +7934,7 @@ static void sdebug_driver_remove(struct device *dev)
 	struct sdebug_host_info *sdbg_host;
 	struct sdebug_dev_info *sdbg_devinfo, *tmp;
 
-	sdbg_host = to_sdebug_host(dev);
+	sdbg_host = dev_to_sdebug_host(dev);
 
 	scsi_remove_host(sdbg_host->shost);
 
-- 
2.35.3

