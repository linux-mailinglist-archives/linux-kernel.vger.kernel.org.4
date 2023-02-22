Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF24169F452
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjBVMSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjBVMRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:17:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D1139CC4;
        Wed, 22 Feb 2023 04:16:48 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xEkk029560;
        Wed, 22 Feb 2023 12:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=N77FyshD7+elqGy+wtJI+TxNXB/cysj/7vXXeaV4hC4=;
 b=dwNedKsduEBNPnph8tvnI7ZAdm97oUWcicSLS3bCXeD5Ax4kW36TFczWX6olQ6yj1aYu
 xaSJ8Kab6MfyVRVfUT8dKEz7Zu5/grrOZOKOZOBItTwIjVzm2+Uy6upX/znZah9f9UZN
 2lrB9WwGbl+yDJNpyyfW4d+AMVaN+TPSlmkYMNt+eH7YCFFsH058/MCHKedL372gKEVl
 CaDIx8KnnFXklvTrqBb0gNgBO+KbZfOG4FeUfJacrUuNncxu0q/bExWRe6dsaujT2lEi
 8JdpD7Nk5gOi/26umAmkSJw8AZefK/r0ByMn+RJxNo+jOzi9sPrADY76KntX/uPWT1+l qA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dqqdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MACWue040932;
        Wed, 22 Feb 2023 12:16:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46fvtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARVBZ/EGDBprLXVlOXTvrfldIneIJq+OUxYTCW73+JCyJkXtoiTynFCuFOoVl65aw3clfb5Fvg81p6jUS+wEtALdjuQ4RbNzpJ4fL+cdMXfasF+DVkYhMHV7AAqNnOj8oUm11SPqk16uBKGoQvwOEISeiBVbKppgokAvQy2DHzZvsy9HUgVJWlM/vm2Pd8BFDP2s+UlojWF4dktngJ+lRvb+mH6Ke1B7OiM/G7bkfgWbxL6KbuG44iyQZkHWW3WzXZY8mM3kRsGRSk7i6gU5VYIB8rguPdn5cUuPl+qtlOgot70DThfJ4zZ2x+xQb8skhGKLMQoraxRsNM8MLGoZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N77FyshD7+elqGy+wtJI+TxNXB/cysj/7vXXeaV4hC4=;
 b=YfMGUwGkzRRqFRGnC3t9zsfIIWY8RfoeA3OzOml9l7qGroVquCRlYTDZuyz6jpzoja7DlMPWisQKvD3nib7bHQ03Vp/MkGyN2Ej4Nesx8ugMB1106aR/yFgomaj2f12/LHrP9oOViNDSHgymSMCv1F07gfTZ5H2snIjD12VbBA2eDsZvfwmIw+Tb653FA5BdfA0RHbGZvmIRPnRzXfQ383PsP7PbcQya8am0NFh4VenKCvd6fX4sYVPQvW/ANjQPdD6KkXz31c+C/8ARB2q+Ek30RLDt9W89ExHFibCnmA+UdBDZcs56Ck1iX6/5uh1R2EzAjBkNkKgFLcUUU7k3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N77FyshD7+elqGy+wtJI+TxNXB/cysj/7vXXeaV4hC4=;
 b=gEb2YzimAYGLUkDb9RDWr6kvLJgOhRiZh0JGAO1DymUUOKRn7DXk7xX6cnNQwWYjKEBDvLJF597c0XL1nm1v3zLZO+THeZEZbExXi4etHBdtWMXhT9W5ApUfTbKFi/AdUc5gb0ziP/aF50k32JVjfYbm4I7Sju98i2B48NHbjzw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6412.namprd10.prod.outlook.com (2603:10b6:510:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Wed, 22 Feb
 2023 12:15:58 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:15:58 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 12/27] kbuild, clk: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:38 +0000
Message-Id: <20230222121453.91915-13-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::23) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 377c9ae7-7d18-4f81-b79f-08db14ce8e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynycHiwZbGYktgf8lAUJksYUlR8DIfw6XF7t6otpFgLunc0cMS8c9HuN41FI8fQ28XKxCGnQhc1o+he7wfMErmiei3GY/Ty6MoGrXztM2N+I80vjA2OSZ2Sa7YhWpFvrjDycnHznvqXFnqusm51VJhnQ+Sy6EkuSZc1awivOOeKlXYjwVq6QD8UWSJ62i4t9hcUGUUWm2C6s0gGQ57q5jU5I79PlsUc1FoZvYnuRU25KlvfVWRCwDfMu8b9HO24V658r2pnaGmoHM8hsUBWtNh85Nhg+MeHiOLIm0SKmPDq+hl+PXy8k2JZkhxfYc72GQt+FCFWYvhefPJMZKb64aLun+0m6e/W4bn+F5x3UsWHV3z9WH4G9LW0IMltDZgBF7uasYThRSmGmTnY2r/1tY50sii7+cMooKAFEPlcJrL2wQyVSooCfajJfLwNeRdmB76E2t3TD9kpG/n/yfgWqZBWd4Wj5edol0wfVVlZ3d6zQFS92KzlvnP/IAGHHp58ItM55AiQTufAVpXX4usDWEWUlEEDZW5gxozYu3R4kouShDEkUMBK/1CYZjzArpoKlNDQ/R9XQmsJ9JFk7T5Bmvi+bjihYL2+HYNrc/7qfM/7/+xB9u1xQV1FPl/5VSCeBc+26JQM9U1Kv+kH1/QDbUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(478600001)(86362001)(54906003)(2616005)(6512007)(4326008)(316002)(6666004)(6486002)(1076003)(6506007)(186003)(44832011)(36756003)(5660300002)(8676002)(38100700002)(66556008)(66946007)(41300700001)(66476007)(8936002)(83380400001)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k2rCa4RFMYEWMCFlYgGgjmrTBZxsUdoB0KK9Pg845MhemDZ0GqM+WwTzdPvO?=
 =?us-ascii?Q?SMYIfVbJ/EjgjDF3iuPkGo0SbT3ERDkqtwCrCe9bbAS6zVGj/Uwuws8gYgGS?=
 =?us-ascii?Q?UOc7Fq70EjcXXilz3CZyYIaL9QuQ389vpupTrn3LF1Y0FatLDJbPRav8njiO?=
 =?us-ascii?Q?3Ig5eSyOKIpwSMB53eqK1MPCNprub+T04499qEOdHKJYPf/yF0GbnspdMPbk?=
 =?us-ascii?Q?h/Jn2EkDOwEeUfm5s6cK+KEIEkAzKiL87gw8w6v1bEMjoFLPYGiexaNVVPaP?=
 =?us-ascii?Q?e0C8OI5x4aZmLuS+BYCUSHw+EFme2ieBW9kNrPdqN4erPkW0PUMmiKgzN3Dj?=
 =?us-ascii?Q?IK8bdxZ61JyxaktkGjWbHru2IsmqsF219Zmnu3W3YPITqu8lueNhPfb/iW4R?=
 =?us-ascii?Q?YVPpvT2zBiK4ga0vKm5xyHd0H9ss4YJLQXV9NY72rdRwtdbbDLEfONzpR6xe?=
 =?us-ascii?Q?fp8/sSMv0cwC7jMKDDOzLLD6UcpDbE6JsgpB6lBUYIbyfyi/+oI3QIb8q/CE?=
 =?us-ascii?Q?iekJzdlw6Ho73u1GLGp/Ez1WYTFYJVCUGZ1NdbOGZjtWvP9NoXSZUxGaCwPS?=
 =?us-ascii?Q?DEaDZlhY+Lpmo8s/4vogY6nCLKcV1E2lXvLtbf0s09HWrdeXkI28i+3gv3+q?=
 =?us-ascii?Q?fpLErB1GWjsGe3/s/QvXJNF4nu19MyVkxz3xF3ln7YVnNWJY4k1V9bxH3naV?=
 =?us-ascii?Q?m8XjUVql3HG/HUtqGQakCILS7y/yqLiplrD70uRglDG8PVp6UJKQZ1H3dxx4?=
 =?us-ascii?Q?lnkl10Twv/FpVNuvMbyBn6wC5nIDHPHrcPXHnFMzMxGf8txC8RpD5usWtdO2?=
 =?us-ascii?Q?Rp+mFuc0Va7AAoh6Aov91SBtbh70tji8W/3h66CcmHAwMTSTKWBEe6vkkoIE?=
 =?us-ascii?Q?UVHEmcyMtqT9PfzmUndN35uHk1FdaIfjhDedbcdDMjI7rMvJaHVoIx0ZcbPc?=
 =?us-ascii?Q?52n1BiwxH4mALCIV8E5YuyrY7nVSJomeQtYoKQu9rCpgx1TqvuUQDZcZyOAn?=
 =?us-ascii?Q?7O9XW9Fslr3hlqK76dJ/IYzAES20xsNltig+xwxCcbnBJ7E44+HPuHM00r9c?=
 =?us-ascii?Q?ONWdLk3bvhxr1UeXO6rFtJnwp3kS8NW8TyNXs7IYsrLvlJNatwRVOpSqMbnE?=
 =?us-ascii?Q?+XoMX62XbesJurU8s+86w0xokg742nzQWtxGpAl2qtKs0BJuFEdeff2hi0Mj?=
 =?us-ascii?Q?drE7FdRFEVcddLm5tA/0R1G6bHoKB2VmgjJk4zekb3S1Nf7fuKjDD3OoV6Ba?=
 =?us-ascii?Q?Zq0wIsMA2FRk624ILYu17j+nhOPDx4XHkWwM2v4jeStGm0pRlav5Ww/3lagO?=
 =?us-ascii?Q?aw754QfnZdyZpZsgbJ0WBUow3XLozMsjBEI5gZ6Ne4xNryAzqN5OkocRsufc?=
 =?us-ascii?Q?YlqL6URi42co+7hut72OhvrIv0GHkR5L4fQABXPpZusPWFKtlOHQ68OsN1e7?=
 =?us-ascii?Q?HPEebbM98R+8WHWk9rwg4zLqLea1OYyCyBe1zDUfV8zVsSFOQMX661rCKYKZ?=
 =?us-ascii?Q?K4+J2UfGL4Bb/UDFm6cIEMpCaBYxbu0JB8HkkpVam8QX77UVwdO5cIHrFP12?=
 =?us-ascii?Q?S5PsNOYzzoOx+ZVbQ4PzNb5/27bVik5FdVInGD/lquX3oMzU7EitlZzECR2w?=
 =?us-ascii?Q?ZSVzJGtZbW0MIdaY+SFCeTE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1GXZAAI14YnZOwylC+uJcaOboZZn358iouMtpZZiZHqWBvurulWWIhj9QbhfB8Gwa/yibY8dJedS1cr4kOcSnIe5Cv0NVdCzZmX6AseUBcNBZnYi+a2ctIhRQHS15M2XiwbGHv9wyUF+Dv2FkAIDrXr6U3s72kc0eERhBwtakzOb3qJSxKY5ltSNQMuVkWOmOKmEo0KqM+ULIsQVHwfqDjoezNN+uxp7lpCGVOP1OjKy34AnojA+rwT8ODSNuVS7jtPaKm8Ak/mtOu1iJqQTNbhAwncZr+yIw7Rte1QmI4PM4ZX2P6C8fB8u6FSQMAPwNUPEQYfBZyBK8lMXMDiI+EXXKc6SgltU5wxCp5vZf1D9P0DVW15BaDOtJGGPVGruYcK+1R0jNIKvB5Tt/v2uQflhNTErDM4e9+f3YU/zJ84+furUIjdY+UdvgfmBPIIfS1Sa/9d8Qox7H3BQYL38tbVWUPFH90Pia0ODo2mlf5Dcl9vAw0AI3Hc0CqxAYkfZeMb5bdnSK5mRKHNq/n9Cnd2OeOAc6KlkLXojWMsV0rW7qvsIYrKY0EHxoVhPzGdIReAYkzcBI6pVFegRurIQTUvlubgMydd59lBAc32pnnb9OjM98QZ5OWJPaChqEMKcsCEHf5Ha0wu0sLq1/2WcIWMLr7kOh6NrSlm8d2/LtJmokhkT0sqSfZHnradO+mUHJH/cYbWvmdKmu8T5OBa8ipFj0lg7rI9UL4W05XSanJI6lYwaWfGFEFlgg9HCW4Sv7pN56C6FPad2rJr/pcmRjP5cZaQe5HADYIsZh0FggKq6vMoWQm9OFobEv5rE3THVkPWu+ujlrxd9SuPngjauykAV+xrDK9P+EM18W98kNY0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377c9ae7-7d18-4f81-b79f-08db14ce8e1e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:15:58.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9LAoT2hETHl+kiHujwGaFfPvtE3dTt2WktxdK65fawHxwtrLNej3hg+Y03flXmNRCmP1hSkGm1/eSoLB5sGIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220108
X-Proofpoint-GUID: 4Hl2DRw4MBacxJZICm7l_Lk1QCSY4NNp
X-Proofpoint-ORIG-GUID: 4Hl2DRw4MBacxJZICm7l_Lk1QCSY4NNp
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
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/clk-fixed-mmio.c         | 1 -
 drivers/clk/clk-fsl-sai.c            | 1 -
 drivers/clk/hisilicon/clk-hi3559a.c  | 1 -
 drivers/clk/microchip/clk-mpfs-ccc.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/clk/clk-fixed-mmio.c b/drivers/clk/clk-fixed-mmio.c
index 5225d17d6b3f..8609fca29cc4 100644
--- a/drivers/clk/clk-fixed-mmio.c
+++ b/drivers/clk/clk-fixed-mmio.c
@@ -99,4 +99,3 @@ module_platform_driver(of_fixed_mmio_clk_driver);
 
 MODULE_AUTHOR("Jan Kotas <jank@cadence.com>");
 MODULE_DESCRIPTION("Memory Mapped IO Fixed clock driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/clk-fsl-sai.c b/drivers/clk/clk-fsl-sai.c
index 6238fcea0467..ee5baf993ff2 100644
--- a/drivers/clk/clk-fsl-sai.c
+++ b/drivers/clk/clk-fsl-sai.c
@@ -88,5 +88,4 @@ module_platform_driver(fsl_sai_clk_driver);
 
 MODULE_DESCRIPTION("Freescale SAI bitclock-as-a-clock driver");
 MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
-MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:fsl-sai-clk");
diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index 9ea1a80acbe8..8036bd8cbb0a 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -841,5 +841,4 @@ static void __exit hi3559av100_crg_exit(void)
 module_exit(hi3559av100_crg_exit);
 
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("HiSilicon Hi3559AV100 CRG Driver");
diff --git a/drivers/clk/microchip/clk-mpfs-ccc.c b/drivers/clk/microchip/clk-mpfs-ccc.c
index 32aae880a14f..6ee92c7925d7 100644
--- a/drivers/clk/microchip/clk-mpfs-ccc.c
+++ b/drivers/clk/microchip/clk-mpfs-ccc.c
@@ -293,4 +293,3 @@ module_exit(clk_ccc_exit);
 
 MODULE_DESCRIPTION("Microchip PolarFire SoC Clock Conditioning Circuitry Driver");
 MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

