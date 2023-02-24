Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9D26A1E09
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBXPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:08:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECDC2E0D7;
        Fri, 24 Feb 2023 07:08:41 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEmweP024913;
        Fri, 24 Feb 2023 15:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=a/hIjJFG2ugdFyvjCw00qDtaAiyJHaKEBHcEXTRhYi4=;
 b=o1dW6jt2pExbMWO6nQBFl10RNA/vDCbh3wbnUC3nIRoR1xe38Jv3qUFbFiXGLM8qQfCH
 khie4B/BTg7ACifpXurBL3BH1XSu+788GfHIQIc2Eb8vGb3B1nAl/gSGEv5xekCtGLu0
 Fl0m02sitoWeeePhPYbqB7nxVk+x3pg4yL7wi6MIS0fCk42xKP9QgZewcVoGzrFUjIWR
 CEEdBImUOsFgGAcgo1qd7+3C6ST0oIJGdt4hauegBEvHKRzjdneGhBX9SFTDe7OOA7YG
 6nkSy7Jwxk7mzf2+RIoV9hvhwjumoXoCEsoInPfweQvLpWMmdfvx9xhmddDHnXRjiSxi 3A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dwap9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:08:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OElERX000671;
        Fri, 24 Feb 2023 15:08:35 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nxsb4dtca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:08:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThLcQEgDI4UuP4rZb2aYIqPQJRf1EczTpuFz5RN0NKOKmJ3X2hY8jn7CsUL62sYUssp1AQePBUyUGUo9pvtZu1hBkbyjfEKXYQr+fxsz4gKTaXYyI0Ia/FZZcfB2/tgPyXnul/j5HT0QvvMJFRRmffg6aPlIkw0DmINCaqcmQAxhLCar6IjlCGBLISYvMNGQvnqsHx2U3/ZpjRsTadMDzx4v8sifvIsEswIyA0ZWRZS5gfo3isADyKQ3KqYo+RCLy7ttNEmuAT7jye90wUa8C+mp2I8JdDAoavnrxqr19LCEbj8e9UjceK4Ct5NySbJb+XZmON7wjLpjofYPoUamKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/hIjJFG2ugdFyvjCw00qDtaAiyJHaKEBHcEXTRhYi4=;
 b=R0y+3C8WzTreOY0/XbanTdbRKi9+omos3ENTQYuitH6Wr7P0yOTjuDbGcYbgNxKj8e1L7tzihBb6iomvf15SeS9gOFb5w+2ReI4R/3AcHfdl6QSWUNAqU4VwqIFnmGze1tQY2N6leMUeb716ELcK7+UIj/vclt6stC253vOoaWzeDkxMcJAWydhgNKuI3q8oA/yZITLOOiI/X/gapnI5hRrtvZg4R/55URiySEJ6VAOjUQycvC+k0YfuTl/Ub5vkrr+jrWgta6kzRzsOpwfzWXl1aE0kt5StuGfyzvVyZMhEdc3p7+bNGzMP5naJTwgcn+O18ri2p2/oV0EmEGzHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/hIjJFG2ugdFyvjCw00qDtaAiyJHaKEBHcEXTRhYi4=;
 b=PWoOwh1BsgAUOkEGsBWdGJegc/4QaRk0tdQF7J+gvPjyGvvune3BJPSkrbvieF+sp0JnxYrDtTcNUxQgNV9REu4leXsl+IYX9CeA+QYvuTV5NSpre1ZPk9pvOqjmD3epxL8J7AEgGKmr1xNmdrWuOBSEBna2kHxXyMcnkWjFns8=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5303.namprd10.prod.outlook.com (2603:10b6:408:125::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:08:33 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:08:33 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH 02/27] hwspinlock: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:07:46 +0000
Message-Id: <20230224150811.80316-3-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0009.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: fe261ce3-2c85-4b8b-da63-08db1678ff28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ff2TrswJ9Gm+u0vbjIXtX+82PtPf2dBaT6A1BisNeRzWgzha47V+gBoDFYUbU2lQmrXtlxIob2pyrXwqBvOOv2uPRcv9G73vbtu+59tZIqKWWcxyNtN965FyR/DNmpn7edT9HmRxRJpFRj38IpqFvCkrchpaQ4amh/IoPi1raqJkU+ApvtGSdgQAoruidnGgJLJq1vK9ygJWBgvrlr9UMlVWp0vz1foZQazvChsxSESY0F/muK/jTfWgE15mRm/QEm7SG/QkJhnDKBSdpgranq9F2RDIS2Eo1unPH6bKYxts6WtmCgu1+RhGsAaBZDmk3KtVqGY5LEGaMfhFCswrlQ3gHDbpiIoKsjbYLybJ9E8zG+N+OrT4djK4BTCrGSqy6mMp7tffceP3O+1Hm7LDRB/rHIWR6DrNqy55Kx05e1y3N7M1+wP1qKB19oAAgv7gMMjYeY07Ec5CYAS5S3fZ381HkhCsNAPfY55akYxt6NnmAE0qG/DWoFkuOXP0QfA90lqhsDZm+yfucJ7enjZ3vnZ/nX++uvP7ZxAKj5lQa47F70j6Ng3IcoEaH91LNRTHsX53zm4k0JAB+zryFxpHTs4fmWJNY5xDVHcF/3M4Gw5b3NEjl1XJjeoJWqvUV+gXn3K6vl/lwxbioHJ0aTfqlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(36756003)(6506007)(83380400001)(2616005)(1076003)(6512007)(6666004)(186003)(8936002)(41300700001)(6916009)(4326008)(44832011)(8676002)(5660300002)(2906002)(6486002)(478600001)(66946007)(66556008)(66476007)(54906003)(316002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uFVO4RA4ZITerCrYNtaRjiLpztQr7niBTjeA7Wf6q7LO4Z/IixX5NGVj2ViV?=
 =?us-ascii?Q?cMU8teGofDng4Tye7r1Wz5aBH0IsFoEMXuvCuMVg+ZduqGpNm/TFZTG/V9mZ?=
 =?us-ascii?Q?aZF5tLQTo6sONfZP0Wy/ZhN1EXDf6V/3fjYnAKqMOvX5O4z5luGsxphnK4rF?=
 =?us-ascii?Q?cdL/Jeh98DRS1g5KgMdjIF7RzzpDelE8XnjovPU9DXVsujbJyKCd/4GYlyCB?=
 =?us-ascii?Q?1Foq4nM55tVP/9tbQiRSpKbdej57dzlAwzoBx7MqGTbtvzNFYLvs0U368hC4?=
 =?us-ascii?Q?CvnKRBB9RJrsdOOzGxZIMewMT/UVrTusphCt9aufaU0x+9l4aae3+TpptE/u?=
 =?us-ascii?Q?bm1jZBYdrq01wlrTyO9APH9moB4nnP8ANPmtXFrZKmfEPIQ30fNLZqEICE/N?=
 =?us-ascii?Q?49OUHl46ynYHGjV2Al3E5SpVPbe2+ukWUc5yXPmE+hEUrI0DW7ho+WYCM6NP?=
 =?us-ascii?Q?P/3uEgxLhVvmehbY9257ge3JJKsxMQD2aJ7DXDcuyOVVLoeuTg2rvCPQ2Mqv?=
 =?us-ascii?Q?yqu4smCsU+WMm2r/+ax1sPQSNtLpaMmKM5nwy209rh261DlJaUbZRJuEIhhv?=
 =?us-ascii?Q?11OSYfPtcFVK0yOZbOaO6gINuqlyS7pugj55682G9KwC5WwBNHwQszbdY/ZE?=
 =?us-ascii?Q?zrDu5DHlKXsCdsr/Kb9NGDyPFeGh7To8Q5iiiKEAvrHZRZ1inzYk6DZZi0Wm?=
 =?us-ascii?Q?8i59BmunZz/T0PeTras+MAgtBDmjzpTB/icrB5aXACZoIUe1dgubyHQOEyu6?=
 =?us-ascii?Q?PsYI0OiNArGIxkBBdruZG6nAZnQq6uOwcyUBGDjueLmAD7A6N+WZcq4nmUKg?=
 =?us-ascii?Q?SX0dJJBwAwFDQPRfj3f4J8jSWVJt5mguk8teR6Vruez2UScVptkRC7Fy9N8Z?=
 =?us-ascii?Q?vI280hw55S3bBnQQf1n4KPaRZy/Rcd392+01vKQkPJMWZQOTxjnzB0VknXJX?=
 =?us-ascii?Q?Rrt3UTGhDW179kAW3VH9Q2V1M1tZXl8ygSQ2Yq8nVpr0wv1ccBAyd/i/j4DH?=
 =?us-ascii?Q?a6rSusyr/wL/rCQ9TSSsnwYwuN+MBZy97VeBs2ky91y3df8FzACSu485RksP?=
 =?us-ascii?Q?jbl5+SlDHGhncx45LBv/QYgur264sCw2EeAk7wT5lqPHntWeiKVGYuuL/Ywg?=
 =?us-ascii?Q?WJIj5EOPhtxqElyxnklvnZzJ5+r548uiwVmk4QreTuE7YUhCRXNjJ8XVWvfA?=
 =?us-ascii?Q?Mb+ui3hgzBei33i41glNHjLzEX5ZSacrAXBzaShhmqiqYOOBvW/VG9ezVTqJ?=
 =?us-ascii?Q?qndPShyZsw9tFiTF6GOS3ubhllG4dZMtw9SWHIMQqWu5FBjWRrfMn5traggz?=
 =?us-ascii?Q?u8j6rr1quDiBgkzsy7whMXeVkqGf2Gd67SDuP6N3TO8tOmxo+/oskjbe/upc?=
 =?us-ascii?Q?+GeKtFf6v9i+L8WaicnU6Yn0LW0m9/8annDxYol/4V6JP8OeVPJFZbrEWDz0?=
 =?us-ascii?Q?EqMjYh8n5YSlMHuBNzCiMHh9rAUr5nZ6WA9qWegjFuXQY8aDd+i1I9GdbsPY?=
 =?us-ascii?Q?XtxFNT5hPs8czBNoa+vTHKzP7CDXdOa4zDCClBAqLwC4YxcB/7zPOGyLe8bk?=
 =?us-ascii?Q?U9p9LQuBYqXKFqPrLiv7UPj6W4IqBbxdSfm94cdTL5cV8fCWLUqWlDc05pQH?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VFlsexZwB9cVTJuRWa7sBxga7HJK20Ka9yZrPshfxHV5Czfq4uH1sGL5nlPPWXRVSquttk6NjNDonK8UNAeDAIOIBlngLE5+4BrONYnXLhOk1DIEbo4a6MEvyS8H+ny0HkKghIbXOeGJvmJTbwYghIS7ZULOu/93G61Sgh6C28SToU08eQVZA5kt/yVMG7YBMsLPc9XnL67o+j2gr+toQSDQoCG/S3ci/5oTjFXrtIpp1cWz3MGs5uCoXcyhzl6PitYbLB+JDybWoOkOTRTYlf1jEWCnb1IcYG8ck+JG688Dq6KnqhFIVR7IvCNNd9ce3J1MbjqBPMQig2lNe5pOiATpq0fJhwbh6Jh1xFnFwMltQvDMakR1RvY0+MoXp4OSAKq8LggxQ6p420Y/IZyBAPrl8mQDAPeWodQPOQmjsBS1nH/Tlcysb2PrtigcS8Z7TUIs3NDMtC2PJzrPcabB+bV9JSV7WDrQVgxaPJrEN1uDs15bA3fz5IWCouQPNyno/M5aeZYaWF2CBg+3w8Rg8MPTfEifBR2QldVmajhJM4lfNXi72zv3pVgH/YhWqDrb0ZlWNT/VeeIa67p/ByFNgYculQtlNAAFbFDYds7KefbsSj8o91f4aVDbpaZYSaRg39YB2UAW7rgyvTKN3TREqFq3DBkUpymepia3J8Q7W92XSm1kkNiIDVFAVqHGZN8UG+8VmKvJBQjHpDrEnvPjATls9ldn6G1dsreF5XbVmsT8QVMUfAIiAFwsScpRno49JCxLP0fuCfqIOgx767lJKjZ1vw5rtLfLLFWIetVmx9LYLy5rjw8M/S2lJHo2yqKoX478eTDyA9KsvZCNk3mdqsQeLYf45/RWtSuhtDb7E+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe261ce3-2c85-4b8b-da63-08db1678ff28
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:08:33.6748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhpSOt2e9GEc5fk3SBLCuP2ddrWwjnQikL8QMFeV+37HdJEQllTtaVueFCM3WRhseQFv3bmBSPFcl0UvkHA35Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240118
X-Proofpoint-GUID: 0AGtS7ZHa98FnQvsQEPxkJxSl_8c6mQa
X-Proofpoint-ORIG-GUID: 0AGtS7ZHa98FnQvsQEPxkJxSl_8c6mQa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: linux-remoteproc@vger.kernel.org
---
 drivers/hwspinlock/hwspinlock_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index fd5f5c5a5244..5048e95c1413 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -949,6 +949,5 @@ struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_hwspin_lock_request_specific);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Hardware spinlock interface");
 MODULE_AUTHOR("Ohad Ben-Cohen <ohad@wizery.com>");
-- 
2.39.1.268.g9de2f9a303

