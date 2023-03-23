Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136966C63F1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCWJqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCWJqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:46:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F0B244BE;
        Thu, 23 Mar 2023 02:46:44 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5i4am011361;
        Thu, 23 Mar 2023 09:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=GhRMO7BnK6dQXX6z1oxGtvLvbEdp7/H2MMrMYl19yOw=;
 b=vucIeaV0g0FSP5Vxi4uxaceyzdwapi8sKhKTNA/Pkd5ELHhYy7w4v34JpCZeCBY66GmM
 9N8EeUuQB9aKe+rFDXM91UbXgvx2zFhU7K/GrsTsTqCAuS1lA23DdrY8CgZQjfYO0tbF
 2YHrtlAhVRpCrJ6D+z0ysCLbjmAhBDeF5glf4A45j66PGenQQ1P0x1HjWvOvKbPfV/Ei
 vRw6guMyIXqAkRXg4BzcuhMRyvbW66UoYzVbKnX1IARyHw6pAbvrE3c94wloLM/1XZq3
 NqQ2dclzQhOgNX1ByXCYA5Kgh+Y7PWcBS4DemZAOv01mKxeyTWqcK08H+uuQch5z2/5P Pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wtb7pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N9cdiA006987;
        Thu, 23 Mar 2023 09:46:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgmamg7ry-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq6emKv7zqdOuJNbxGSEuaY63PgDNZG9ETlTeId3Wu7KappGn+p25zLKkRAv9KDFuokcpsLvxyPMVC5ZpRfb1fNu6HSr4F9X86LpcBZaO80VKdUoYaQ3xNeKeZlX9xPFJDQmBbPVeryiYEMfCNgU648NTj2K7T6It+XEb6tAf9wER0YzLYVDZtKjhxNCuT6ZmdUOYwsKNwOJj4HoS6keymush9ho2YLyg4kuxmonPQ2OVQx1AD7+ZJU9yqPr3Sw4BaXcYsyQ+UbU+UfXtWtsTCRwU/oQmlmHrj7Nw41Zz232DVX89OS+EPF5MXtcVH5q5rbetEE2xMD03Z0XQ0OiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhRMO7BnK6dQXX6z1oxGtvLvbEdp7/H2MMrMYl19yOw=;
 b=FbJe1l4TixlLHtz/TKV/EFXeLU4HG44mInWcYklfZK0hjJTarPW4kwMtyiZWjvWxYqsys2EEZtu8sKN4rLZP6EQvoPzaz2ypZ8vW85roUPaBOLj37341+gXm49NZtHxvGdR47t9+fVKtKzxYaPkEw57LKAWo29Cbtmxxauxhu3B68lPtbJk/3So7QFkKF8IsGZU06RCOrKlRoYeVsYSQ3/aDFziNazHDjxX6RYfv8bYYXCeSyVmW7YIXze6f/DvQMR5P2Z1mr+UApUqrMVJf6uFygTLcJQzFY6dNBVX6Pod4Xl6LMwywISOYFnChbVxly4L36Ofp9stWPGi17qoYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhRMO7BnK6dQXX6z1oxGtvLvbEdp7/H2MMrMYl19yOw=;
 b=KI+OejzexsB3Frg+2ohZmhzOcoD0n2bwBeQL8O0HQ290FANDLFBNMo7aO7qKxCI62S+5CD+oCWMZSMyjecOBtCaMZeLe5NSpD2ljxtZlh790ygwDMGf8hqUaAQv7XNPsRTe/l/i2itl8KPl1mCL02qHc8uodfkrtDuVfGVhPDQE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:46:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 09:46:17 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 03/11] scsi: scsi_debug: Change shost list lock to a mutex
Date:   Thu, 23 Mar 2023 09:45:47 +0000
Message-Id: <20230323094555.584624-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230323094555.584624-1-john.g.garry@oracle.com>
References: <20230323094555.584624-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:8:56::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a82656-5b4c-4719-61c1-08db2b837303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pe6d+UQpkkDmOfLpCIztb6ADbkL3rZ7+xvl7azWn+zC0Wlt5SzWFpCfgn2+mOPZbktMrooSb/yCdxNJpgKd52BlHN7FWQbYEZyT3BSJ+yR3DhV/paKvSj+k5WXcuyudfBflLJWFzewsrUdLWE+XwYFa8Gw/qI5CK5iWXb534EpXlAqBejY8BvS8SSw/0iELETQQTFoLBYp0NZmSI70iQ9rqTHOSoSEGc8c/0DfMc2465UzyBUvvDSCFXeBoJCMaw4JOshEMGaPqCJhmFROtvoUFWs+Iu7toEBMw6QziEu/Ixny41mJz23nRWY1Nf0JzPTGI+pLDEtwyyjb5bQyQeIGhMgO5+0totSbOFE5cOrW/Y+09UL9OtptNvisiU2lJYyhleKtDVJ09ZIQHbW93mgWQ48JiD5JdB/91Q1Hvhr3oayCPGF9WrLUD9irmAIDFexg5kGdOUkGmUASVKZAJ5NWGkLdI8qUBRQv+8i7azJidXWfR55AzYWfhzPHKAtwFVX5IXW+vXk9CykWdrTZ74OGCHVpqZx7T+NdFZgLgh+2Fbpjw22wZR6FPdKwZLrwp+oNArfJDfOOPwAMm+aQpfVNf6+AFzpSRV6/T9aWM5ESMUt97Y47RKd0aORhqGWvKR2rD/PQeDpO3M+02c+RadkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199018)(6486002)(316002)(5660300002)(2616005)(8936002)(83380400001)(26005)(103116003)(41300700001)(478600001)(86362001)(38100700002)(2906002)(36756003)(4326008)(6506007)(66476007)(186003)(66556008)(6666004)(107886003)(66946007)(1076003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ya0nQ7eqq9nqzBhsEmprSKxQmzOOp+fQUHcFV7qHJhnVilUfPD4DHTOdf0ME?=
 =?us-ascii?Q?pOcnPmaBgAEm2ZHaOf970k2inLC/hdFRNCGyVNbyD8JDeVoY+nvqmU5bUOEt?=
 =?us-ascii?Q?MIBwhgDp4482o2rix96CKnfKsclva/Arl/i7s5YW3ZOvSXxUSBiuWJUXIfwS?=
 =?us-ascii?Q?mRaZZRpKyE5ubS/wbP+aBO8xtdfs2uuJA81WTlq/9kzo1IUC79gPwE1ReLO8?=
 =?us-ascii?Q?PEbxpjDfIDY9HGvgrDUjuTp2wJTaraAi/G2+zOpgal60+kUw9xMf0Oefzvwa?=
 =?us-ascii?Q?E8dI1lwMwllN7v2qwvwLW/9rQfDUnlnOxTtv296Q/PZsLUL47VNG3YsDP3g1?=
 =?us-ascii?Q?fgcr72ervZHY8yukgepT8xnD1RNY0duaiv3BuWvc6q+mbkI6qpQLtDzoxoQZ?=
 =?us-ascii?Q?cs5mW/Rx/UhfAJ4D9/YBBgoGstMPt6ihAiqrWsKgsx50Eje7qcgZREZ/euvS?=
 =?us-ascii?Q?hC/Kxfkpfa3bDtdKgvnkwSsIUba7vipLZ8cyBwp7SnxFkqb+gIg4iAgFzm1N?=
 =?us-ascii?Q?WX+EMJV7SGKg/48/hrin6GaBopKUCIX8fSflXWLgoFtPDwncJN75WXD9QAfE?=
 =?us-ascii?Q?B9EvghhJ24Li/l+doNAus2v47nRdMq4RXa4zRagTWtt6X630bZkw2ieBQ2UD?=
 =?us-ascii?Q?nQeoK8gbq/mhVYmJcBsydjJGxBlIsm/A7SUdlTHxKCCsgMwH8PcjJxKvRrrY?=
 =?us-ascii?Q?dbaNCLPjxhxUV4cHZVmya5wsGeGgUk7Nw/NgD8bwoChywRNRxQhcE2DpSbwD?=
 =?us-ascii?Q?v2X2cEN5Fd5Kx6Tn2k2buJzacfAgKIb5g7P/hj4Ow/cj0ewELamFIw58FkeT?=
 =?us-ascii?Q?wp35KB5cql5EdJb2yxIq/JSwgOBh+/HDAcSBK5/kFQnQWyCx+eKThDRCLHFP?=
 =?us-ascii?Q?/zkyUUHRVFCga8n+2zcfzeieycSntpgw9DVcRKOA6WmViLeR1NIQstXM88aP?=
 =?us-ascii?Q?s+bsgTI/BlMlf6BJxYvVdrP3dEnX8ptGPA+n2dy1mQTttzY4MZ3NG3Lsr6u4?=
 =?us-ascii?Q?RFVWeMjY4JGe7wjP8p1B5zqJ/csC29q8O9f1/9NsX+CHvQ4nKUbmqhy56eNL?=
 =?us-ascii?Q?/ijbNEZQRjHL0UqFyxedeJ9t7UyZv3cpFczjZ5uTvY1e7BKOp3M5F0C8BROa?=
 =?us-ascii?Q?OQSxZi0wFc+yHmCTYKTzZl5x8NAPsXBrSgghyipy7KLY3bPtUbb749BV85a1?=
 =?us-ascii?Q?ZVWQbpG4Gnu+MnDmCHlH35HjV6HxiB1WC2ystqLOwqaNWSc01DTQYVjTNJCm?=
 =?us-ascii?Q?zP/T/yNMOLweM4/GVJEg6Pk7IsEdoFoE8HDkcAoELzwi32gSgYjTPDsjqzvF?=
 =?us-ascii?Q?tq6iixru9g5qBnsMlR0JGxzrMHVtGsH14AVv7iDXaEeu+7OjWzLPokb9Zp1N?=
 =?us-ascii?Q?zpzXVkwEvZSLdtHX+KwBqIYyavy7g6t/dPaK6zxdP3Bez8uJVM2aY2ZXQy4G?=
 =?us-ascii?Q?sgjWEY9CAr/Xgd/CkHdpdtspvuRp8eQvZjI5SEDL9qvyE4chffW3LnF+KMaw?=
 =?us-ascii?Q?pofvYhJmD+oXhgDjgexeSLBqPvjMXehVURIRFUhwXJGBFLDqekY4pO+hcWvi?=
 =?us-ascii?Q?xUWwCRgfl7MU5XupUoyBTo0a91MyIpo16xGMlqQHXhuAvIfbw2afAOWkqT1s?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xu7h8Gta+9JvTmyvPsA8a2jEkJAhfkZnlkbJJZioVWj8A0ynBnGmtA+FNGDkFo8J1uyEUxkAO4JVpr4VZKxn3LzAtgWba9pvDs+KpfUlqARH6kPHSDS2d0hZgPaLHwA9NUS3oANBjZgyvkTvge1YQIvwc+tF0vkojP5+2duzq2uuwO4+WPyceQqN9u6Raj/DQcv+B2Z0wy32z/B4MNwS4WypNUcfadgz7gprzZQ86QVgZrRgohuz5DC8Y8PcPejZaeeyatTrwUxPz+0o88eshF31uwD3nFU9DrP/5Agj6vZe+cZGJNjnj2qPQSgBBIQq6S/568ZVLXD2+CDIQT1f86ClRTX3zUwov92HfTgn0ROOX96e7RlrEX1VvCasXE13VGXLQYVYtJEOMotPqR5zTglYkHd1iYjsRwKFRTf2K9/1Y9+J9kBvfes/tR2U3Q/85dU0Ay5EP9+tAPeMutDfUD+Lb6yBZ8uWP1sRjf50ojz9ENDuj5hEoaQCYoy3Nt1rrvzSELTZrVKryksAzbgPO1/IRGWNcukBemA4z5FX/aFsa4OVcdepFiKnQblbyylCZMmFR6VoUJJI3GrKwFifF1yfo0vTdLbf2oBnHNzXsMPxu6P9fBodlkTDdAHq1ReL5+tWLH1eU1BdOcbwMumW75t5R9A8TUJCYJrp8EBzvn322Ec8LWfo6Os8MUyZVK2YVZZTd3QHyiauxn2x1dXB/1w0x7pLnFzsFnyf/dTCuNHuCVxtjyAKu7F/SQE2Tuv3tOegWIPxIe/PMPTEuCNyQGCmmLlP/5Gcy9PpEj/5OhZ/PZFDCySYQGLGjyZmvWMzM2PlD+bIE3MpmhTXsLdKNPBX+kx3FzLW0T40S8+gE5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a82656-5b4c-4719-61c1-08db2b837303
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:46:17.4306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxvbViMdH0wLtxAtbs2luT9yLLig3iAualY9MoKr65Qs07VLESFF4mRXSxMEjrmbCo4WbQQjbnfKHp921eS8KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230073
X-Proofpoint-GUID: IudMzMNwS346n8xCa78QHSr_D7rsRokm
X-Proofpoint-ORIG-GUID: IudMzMNwS346n8xCa78QHSr_D7rsRokm
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shost list lock, sdebug_host_list_lock, is a spinlock. We would only
lock in non-atomic context in this driver, so use a mutex instead, which
is friendlier if we need to schedule when iterating.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index eba6eca81e84..a61e7c31dab5 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -816,7 +816,7 @@ static int sdebug_cylinders_per;	/* cylinders per surface */
 static int sdebug_sectors_per;		/* sectors per cylinder */
 
 static LIST_HEAD(sdebug_host_list);
-static DEFINE_SPINLOCK(sdebug_host_list_lock);
+static DEFINE_MUTEX(sdebug_host_list_mutex);
 
 static struct xarray per_store_arr;
 static struct xarray *per_store_ap = &per_store_arr;
@@ -908,7 +908,7 @@ static void sdebug_max_tgts_luns(void)
 	struct sdebug_host_info *sdbg_host;
 	struct Scsi_Host *hpnt;
 
-	spin_lock(&sdebug_host_list_lock);
+	mutex_lock(&sdebug_host_list_mutex);
 	list_for_each_entry(sdbg_host, &sdebug_host_list, host_list) {
 		hpnt = sdbg_host->shost;
 		if ((hpnt->this_id >= 0) &&
@@ -919,7 +919,7 @@ static void sdebug_max_tgts_luns(void)
 		/* sdebug_max_luns; */
 		hpnt->max_lun = SCSI_W_LUN_REPORT_LUNS + 1;
 	}
-	spin_unlock(&sdebug_host_list_lock);
+	mutex_unlock(&sdebug_host_list_mutex);
 }
 
 enum sdeb_cmd_data {SDEB_IN_DATA = 0, SDEB_IN_CDB = 1};
@@ -1051,14 +1051,14 @@ static void all_config_cdb_len(void)
 	struct Scsi_Host *shost;
 	struct scsi_device *sdev;
 
-	spin_lock(&sdebug_host_list_lock);
+	mutex_lock(&sdebug_host_list_mutex);
 	list_for_each_entry(sdbg_host, &sdebug_host_list, host_list) {
 		shost = sdbg_host->shost;
 		shost_for_each_device(sdev, shost) {
 			config_cdb_len(sdev);
 		}
 	}
-	spin_unlock(&sdebug_host_list_lock);
+	mutex_unlock(&sdebug_host_list_mutex);
 }
 
 static void clear_luns_changed_on_target(struct sdebug_dev_info *devip)
@@ -5423,7 +5423,7 @@ static int scsi_debug_host_reset(struct scsi_cmnd *SCpnt)
 	++num_host_resets;
 	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, SCpnt->device, "%s\n", __func__);
-	spin_lock(&sdebug_host_list_lock);
+	mutex_lock(&sdebug_host_list_mutex);
 	list_for_each_entry(sdbg_host, &sdebug_host_list, host_list) {
 		list_for_each_entry(devip, &sdbg_host->dev_info_list,
 				    dev_list) {
@@ -5431,7 +5431,7 @@ static int scsi_debug_host_reset(struct scsi_cmnd *SCpnt)
 			++k;
 		}
 	}
-	spin_unlock(&sdebug_host_list_lock);
+	mutex_unlock(&sdebug_host_list_mutex);
 	stop_all_queued();
 	if (SDEBUG_OPT_RESET_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, SCpnt->device,
@@ -6337,13 +6337,13 @@ static ssize_t lun_format_store(struct device_driver *ddp, const char *buf,
 			struct sdebug_host_info *sdhp;
 			struct sdebug_dev_info *dp;
 
-			spin_lock(&sdebug_host_list_lock);
+			mutex_lock(&sdebug_host_list_mutex);
 			list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
 				list_for_each_entry(dp, &sdhp->dev_info_list, dev_list) {
 					set_bit(SDEBUG_UA_LUNS_CHANGED, dp->uas_bm);
 				}
 			}
-			spin_unlock(&sdebug_host_list_lock);
+			mutex_unlock(&sdebug_host_list_mutex);
 		}
 		return count;
 	}
@@ -6373,7 +6373,7 @@ static ssize_t max_luns_store(struct device_driver *ddp, const char *buf,
 			struct sdebug_host_info *sdhp;
 			struct sdebug_dev_info *dp;
 
-			spin_lock(&sdebug_host_list_lock);
+			mutex_lock(&sdebug_host_list_mutex);
 			list_for_each_entry(sdhp, &sdebug_host_list,
 					    host_list) {
 				list_for_each_entry(dp, &sdhp->dev_info_list,
@@ -6382,7 +6382,7 @@ static ssize_t max_luns_store(struct device_driver *ddp, const char *buf,
 						dp->uas_bm);
 				}
 			}
-			spin_unlock(&sdebug_host_list_lock);
+			mutex_unlock(&sdebug_host_list_mutex);
 		}
 		return count;
 	}
@@ -6489,7 +6489,7 @@ static ssize_t virtual_gb_store(struct device_driver *ddp, const char *buf,
 			struct sdebug_host_info *sdhp;
 			struct sdebug_dev_info *dp;
 
-			spin_lock(&sdebug_host_list_lock);
+			mutex_lock(&sdebug_host_list_mutex);
 			list_for_each_entry(sdhp, &sdebug_host_list,
 					    host_list) {
 				list_for_each_entry(dp, &sdhp->dev_info_list,
@@ -6498,7 +6498,7 @@ static ssize_t virtual_gb_store(struct device_driver *ddp, const char *buf,
 						dp->uas_bm);
 				}
 			}
-			spin_unlock(&sdebug_host_list_lock);
+			mutex_unlock(&sdebug_host_list_mutex);
 		}
 		return count;
 	}
@@ -7258,9 +7258,9 @@ static int sdebug_add_host_helper(int per_host_idx)
 			goto clean;
 	}
 
-	spin_lock(&sdebug_host_list_lock);
+	mutex_lock(&sdebug_host_list_mutex);
 	list_add_tail(&sdbg_host->host_list, &sdebug_host_list);
-	spin_unlock(&sdebug_host_list_lock);
+	mutex_unlock(&sdebug_host_list_mutex);
 
 	sdbg_host->dev.bus = &pseudo_lld_bus;
 	sdbg_host->dev.parent = pseudo_primary;
@@ -7269,9 +7269,9 @@ static int sdebug_add_host_helper(int per_host_idx)
 
 	error = device_register(&sdbg_host->dev);
 	if (error) {
-		spin_lock(&sdebug_host_list_lock);
+		mutex_lock(&sdebug_host_list_mutex);
 		list_del(&sdbg_host->host_list);
-		spin_unlock(&sdebug_host_list_lock);
+		mutex_unlock(&sdebug_host_list_mutex);
 		goto clean;
 	}
 
@@ -7311,7 +7311,7 @@ static void sdebug_do_remove_host(bool the_end)
 	struct sdebug_host_info *sdbg_host = NULL;
 	struct sdebug_host_info *sdbg_host2;
 
-	spin_lock(&sdebug_host_list_lock);
+	mutex_lock(&sdebug_host_list_mutex);
 	if (!list_empty(&sdebug_host_list)) {
 		sdbg_host = list_entry(sdebug_host_list.prev,
 				       struct sdebug_host_info, host_list);
@@ -7336,7 +7336,7 @@ static void sdebug_do_remove_host(bool the_end)
 	}
 	if (sdbg_host)
 		list_del(&sdbg_host->host_list);
-	spin_unlock(&sdebug_host_list_lock);
+	mutex_unlock(&sdebug_host_list_mutex);
 
 	if (!sdbg_host)
 		return;
-- 
2.35.3

