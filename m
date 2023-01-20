Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524F96759E6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjATQ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjATQ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:28:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D1F85348
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:27:44 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBj3w011477;
        Fri, 20 Jan 2023 16:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=OqPv05vjnes8gnRFHpELhzz7iWgFrPUYrfEVVp1d2bU=;
 b=X50BlQHFu40ZI1kFLa+85XVGXpcAy56xc0AWGW4P7jX9Mzxx/n/wDLWnWKmbSYXIj8WT
 Rx5MFDJiAePMixYzbFjzjA/Swjnp29LhIyxl6I44TLdJtZJpubbfpRkgEg+khA9DIJWx
 J0sw3QtgNl2xEqeUtzrw68MECiRTQWHCqiuhD+mKLJ2kx4ZvPGaKbxO4cSUEDklVfc0o
 TOSjLzHXMci5JqLuoSJ4awsAPKy02fdTdo4mVHHoHXGzEXTNZFR1aJxD8UUDq+uEsIPc
 airWZUroFdu7Y3vfTbuHB0HtpIPaQgqRNGpUJ8VZOVINx8zQi2JS42tye+fnw4NU99m6 tQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n7895aqpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGNsPc018698;
        Fri, 20 Jan 2023 16:27:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quj9ye1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWym/S3n9o20a/nvmFOUQp5y7O5x+8wnwGxYg+OZD/QM0UseKMws/DSj1R13t5pnyr+FLU6JVkiGhLAGtWsPTyipJ5JDIg60QOQy3l80Er32LcxoJVezQwpm1E5uMPB2c96Y1EtSRMfrxYy/MxtOOlz1xdrNwFPMVi6nV8YoxAxwCjrqhz8vSSCGwXkeTVmg6GrIwDk34khey6IloAN5zc4KeYAy8t7HqqxkQX3mL/grsN6lmm0n/Q5MfPCh6ThPlgq1yAOU+4n8TIX5LUzl/b9FhAZXB8oaEIq3qYYRieCpeLa7TfgwN0Ci8zGf4p6XBDLh+BAdW88JzvKTMsqu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqPv05vjnes8gnRFHpELhzz7iWgFrPUYrfEVVp1d2bU=;
 b=gi8OTe0Ym9amUQhVlTG1q5iGTchuym0Ih+9WDuqQb34GRqTBiCausSSgRJmZa4ABjnfHFcialIjBuf1SvxUFGcH3FsyS14jPfC8f7XTy1t5FiKjI2fCHHXLIoqgGePR22MTowoAdX2+aMi0J4QjXXSmTgqIUm1rU1D6GF0eCm5k1aNuToLD+ed872/N3cCiv7K7rO2KR9CF7SA2R3edcuTqMYRja0Q+C4/UVhzFeoOAq8NX1EDWJW65Xt2SgaBMUjjilSPGIDyLe0NI/OgWUZgqvybKL7CEUOeAogjgyJQKZvQZHmPHlmdhPTq4qX6qLfxWdVffeepyeScxa1ni3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqPv05vjnes8gnRFHpELhzz7iWgFrPUYrfEVVp1d2bU=;
 b=v6Tw6Fp6oUL96LuxtPhC6QQfq3OCvNQdj1RCZMAJea8TajgTrjP9/0cVvNt0xWYk7HoLuuUPFB6UlgZgA8Gl1R32JmSbftxtNKkI5KAiKh44LAT4zBR2vseHUXO+Kf5Nl6vW6DR3a1zTvdCiy6C6D1/4CU7ha/C/GpUepVQe4zc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6026.namprd10.prod.outlook.com (2603:10b6:208:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:33 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 09/49] kernel/fork: Convert forking to using the vmi iterator
Date:   Fri, 20 Jan 2023 11:26:10 -0500
Message-Id: <20230120162650.984577-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0074.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: e436d87b-6d82-43dc-c777-08dafb033be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ONyWbtZ3jVieZJyIOnmZku6kzbf31ozlDn2PlEev14xE9yWOQ0GwZ1MzZQHVGaH6r4gUNJiMV4VJh199qqAAtsgjmiEarYEs46n2zHq+V2tb9ozCewMDUBAWzIt+BgjczpSAxfsAaT/ETCbIwQ0RL9H7YeSaBOu3Emg99HW+5ZckdvAPdFi8cxcAQeDd75wmhQEuf3X6exYWJmaMZxOIAFiNvt1cIHvUXf/cMYLq9QBeBEo5NJxjvmLPnU8eVNgLKkS18whEjze5j6ki63FvTb9U9LBoI7D/pTLYDGpolxgg5lWhObajei0ypOXS/s9eI8cMmmi7NVq8RcknMDjDtVzy9pG4JH2X6GR4aRmA8JG4XBhipzMZ7W+BhJ30XZEhGV0nDqLFInNSg92mB2b9ERSgFaWWblwEBLO7VKgkbe6Naqk+UsMxwQ08V3/6e0qzUdaq1EbZ45k06lsgvfhF8uENA3+Hqk4ivy3Yued/tCeIFlz9kOQoDHbAc5bGxinhqU3TgyDFP+fvbFk+kjaIzcUh5ZuUpm0bxJB1N78lZaiYRidZQpYJiF0SAteV3loK3vxq9i0cs3v7nnJXC+fYIiFqebbAsTijSJ32hTcxbP1bd7cjlEG0bdiLOK9/NAGin/CouPzgQSSEhdIVTRHLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(5660300002)(8936002)(4326008)(66476007)(66556008)(8676002)(66946007)(36756003)(6666004)(107886003)(38100700002)(6506007)(26005)(6512007)(186003)(2906002)(54906003)(6486002)(478600001)(316002)(2616005)(83380400001)(41300700001)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQ42DKInULnwz3bqtvIa4QieCbV10Rj7k3bUTeKWRnUbkUMoPp5fFFc0PbQH?=
 =?us-ascii?Q?wonL1ytdpCZdKKSeNG2oHwkq9Y/JZvSQV4SbBk+bq9SY4p2a1lcbXpBpoaP9?=
 =?us-ascii?Q?IWirtbfRrIBbpNm9Ebg6mlXdFGPwu7rFcUF18hNwziamdCU5GbI9UvOuRCzu?=
 =?us-ascii?Q?ZjC3F7g59i/bRhv1RHXSX0HGcMjbuTBGajzi2G6aVsfqggaK3WiepUx8lbVI?=
 =?us-ascii?Q?m1yQd4UwtBM6mFX+aFfYo4G/qMmdGs+fUNy8BtQXinJP20ClFJbowISgnId1?=
 =?us-ascii?Q?uSv5iRuM6VQWFiEiYAaz75Dba0uuKOdCGcqhT/VxtYaZc4IgrpJrleQNn1eS?=
 =?us-ascii?Q?3Hhl4ang/ZMmVgGtydQz+uMwtfY0uZkKHHXNIP3gLP09WQf1KCwRPro/GRG7?=
 =?us-ascii?Q?/+xPPmD9bjmOGEZP+DNscLqHCjxKVeeSd4QXs18r8vNzyH1snP0h10zFIJKz?=
 =?us-ascii?Q?pYV5nCUfbI/Sftry1mQLk5yx0m9+U9cL+XINkMY6uCBeLDLbImQrfqQCYgJc?=
 =?us-ascii?Q?1eiRBntVHYzeNE6pzI3stNJ5Kp0HTnJFmKYmZYF+0oJ5yzTFYDNlHM9StUja?=
 =?us-ascii?Q?T0c0sCYzI4UDcmTH5hlCXLqpZTry/n1k4wqADXCv9BWDtdvzMMMvs92ckZzm?=
 =?us-ascii?Q?gEKZoVH8idfMepHIadvaINXz8jzCQKakipQRfOLEUffSgoyqZ/inKbUqvSd4?=
 =?us-ascii?Q?EvJ5R8qWO7+ytJdn6odjRLKbOVPQvJwJnGGbbO9wokI1QUQfHGF225+X7zNP?=
 =?us-ascii?Q?Grad3rJn0cc1QOqebH4M9cwyyWZukT3XoNGw2V8P1jSHyGwe5jZFKGQ3cZA/?=
 =?us-ascii?Q?3bPmuZo8Ur2NBc8r7iJi6ZKNeDxIgxOfXvD/Wz09ubLJ42EFnqeInxm3YFN+?=
 =?us-ascii?Q?lKCgjLOin+5tlFYtvhfWlcNuqQ3lJ2joaKkc8Xedog6NpJqG+3mdB61wkttC?=
 =?us-ascii?Q?V3gC4pNMWzcomTYLDyMBvIQ1q0y8+n0vSduk6LokZqNFwrLxrs8ZyqVD3XtS?=
 =?us-ascii?Q?Gmcy8/YnDDxVqJ/bfCpj0GCbumUdz9K6QHyOyoQjM1w6rvpC6mrgJ/tCkyMQ?=
 =?us-ascii?Q?S/yyYLZzPEcoqoy4UF78ByXpyLvWkBcFqL+9lU3Hl/piRSonUATJAxOuliz9?=
 =?us-ascii?Q?hPCLpZcxUDNkMB5KORwWM7CoTMIU/nOAUNtEpbpPazK5jXtJ8Q8HYcLABKP7?=
 =?us-ascii?Q?ube24M9kkdYnNZm/7vUt/p9NX30rKY8eRgXDeR4ElibW7rzjZdFUao1WMWsj?=
 =?us-ascii?Q?duJK2PveKKjrSdqKToZCt1NVofPcmtfNny4yLIJqTRafsAHyWBotclhcTdMv?=
 =?us-ascii?Q?B26VjIuABdvTqQ6G6opxOXZ4/oVEOMNG6GQZrXRv0z1zzMBTkChsw7fTw1Jn?=
 =?us-ascii?Q?zG0ducgXRKdvjreWt0jPo1Cm2bWgb6ytJ0GN651WivN1LvBcDvikbepTg6np?=
 =?us-ascii?Q?D2T12Nel8LHxs2WrQlY3LDv/xZGtxS3mur59X4CvL9I8idnbPyja5gXoUreU?=
 =?us-ascii?Q?O0yh3NB9k1oireHcgTLEgPD10JVub+t+beocDUMhCNSAXUloFV6X1PkGE+Eb?=
 =?us-ascii?Q?0yyP7+KYxFoH8B6ZFfWkxieSH4BYHDzYDUwyCzJVE4GuXGXtylemqqJaHgUc?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ohcierEhc1urTWCtjAc+fr9OFFFaeCr9IUAIBzt/OTNcJ9gVclE/XV1W5H5DUcAE3PbM51Q6r1uvFGuenrRRrdaE+XOHUKvHKMKgrauoWst9N+PqMZ6p2OwsX5Al+XOiGD7OlaqvLfUnbTCMopoGQMP5mzzoppTjiRvBKQCg6jbxdl+V2Ow+4jnWcvZ0Ds7fPRG67pKwJNxeB4H0Sn/EAtQyaov4b9py3JJrte8mJC5Qy1usYRcSiCoI0KBte8rWWUtB2NI0ET5OK83et+vTkPCLfN/vJfq4qtcI82Z6NMpKfjQxhDqtIPi+GmdwOZt3NjCmMBL+l0j1kPM5an+6wqav0CBh1EGixlBN9HEyt/HIyTOHh2xvSr+LdfBdbrMyC/9JBZmG6LnmvJc9Q79njIgrhROUMqemDIRrXoYolpDG67Vz95QaWh+7e5yNo4h06uKAKQ1J8yf/rb1yiBxgnPZUo6VkzYWnfffNszLv4eHWlDwZr9AhdOkmfbGvXHHIXoJu1HejA+spsPL8AWSPDT88GdZnlylEY2NMlQuJCmqtRCS4TKcl9AZsJIweuvalpXLSxyxv354w7+HWbcD33Hz8irevqH9xmxOyChH2rEq35gO05TH+Y5GkGCLl6YvlryUt+vuZ1DhceUlmHknHsNaziQhe5dYviCD2s52agCXxQ88aMfQZGAeBTrHhPBKLICkc7gu+3QfUm4T21Q2zGMaFS3eeZY23E4y4wB2YLLBnIs954mX+mE3xjcyrA7gkq6y7wRsIxmfrWDbcozOuWRorFE1g6jVTZyKdoYOcysSlDxhoMwL4tMjSa54vLjr3cqnYhYgzWfgRP4YFqTkQZ2r80iY8Ljv9Uf2aKgq3fwCxEk/Oy9Eb6CCktS0VNGvQJWpaCvUwOfjLbQmaqwUoBQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e436d87b-6d82-43dc-c777-08dafb033be4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:33.5294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RuDvmoDtGxxsCm64+Psy0+qHHIqi+Z6xtuQMtsL4w4HSaa8MgNTJDvy8//R38JkTFBBhFf4NNhnRDj5tuuxVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: AUjfzzJDgKrQ7a91hMlcTL4O-FE_sf3_
X-Proofpoint-GUID: AUjfzzJDgKrQ7a91hMlcTL4O-FE_sf3_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Avoid using the maple tree interface directly.  This gains type safety.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 kernel/fork.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 5c8c103a3597..6683c1b0f460 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -595,8 +595,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	int retval;
 	unsigned long charge = 0;
 	LIST_HEAD(uf);
-	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(old_vmi, oldmm, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 
 	uprobe_start_dup_mmap();
 	if (mmap_write_lock_killable(oldmm)) {
@@ -623,11 +623,11 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		goto out;
 	khugepaged_fork(mm, oldmm);
 
-	retval = mas_expected_entries(&mas, oldmm->map_count);
+	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
 	if (retval)
 		goto out;
 
-	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
+	for_each_vma(old_vmi, mpnt) {
 		struct file *file;
 
 		if (mpnt->vm_flags & VM_DONTCOPY) {
@@ -693,11 +693,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			hugetlb_dup_vma_private(tmp);
 
 		/* Link the vma into the MT */
-		mas.index = tmp->vm_start;
-		mas.last = tmp->vm_end - 1;
-		mas_store(&mas, tmp);
-		if (mas_is_err(&mas))
-			goto fail_nomem_mas_store;
+		if (vma_iter_bulk_store(&vmi, tmp))
+			goto fail_nomem_vmi_store;
 
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -712,7 +709,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	/* a new mm has just been created */
 	retval = arch_dup_mmap(oldmm, mm);
 loop_out:
-	mas_destroy(&mas);
+	vma_iter_free(&vmi);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -722,7 +719,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	uprobe_end_dup_mmap();
 	return retval;
 
-fail_nomem_mas_store:
+fail_nomem_vmi_store:
 	unlink_anon_vmas(tmp);
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
-- 
2.35.1

