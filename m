Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B9A69ADA0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBQOOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBQOOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:14:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A11367E0;
        Fri, 17 Feb 2023 06:13:51 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7iKPs005185;
        Fri, 17 Feb 2023 14:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=7b3HjGAS5BE2xeVZ/vL6Ag8gHXwuHKtr+gRPUDCfryM=;
 b=hF1rvB9WL6LgQrEfDNotldhxdpDiDCT+4lOkfukYwWjc6IS5D38E3Kgn3ViShr8GXUYg
 oYKJLB03RrVB9iVOYT3VQhUJbR7Vx+d/ysZC34A7QtyUi68uk7Ow9xFbA3L7WAbMJ7gn
 GZUgKj5TatS8aWVxTULUXTfUNTo8CHOAgvzqgKRApiSdsv+q4XLfCzi2E6MW3iXTrjP0
 6GHatcGIg5h691CCa+jV2kKKZK5MOPi5+xGfWuVgNlUG9GJaw+MsgPOvADmCZpH1AT/W
 LAvoweD8d6wf8kPPh5M2PMTItV9xtejnpVs0xZ2R4ERHX2ev9qJqWp9LzPkS1ehkzE68 UQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np3ju5yb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCtGuO022990;
        Fri, 17 Feb 2023 14:12:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa58xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US3j5CYvEAo5EWAUuD02m4/jhBuwWZTPjC+z9wYXRLilF/xgGo9ZEof/jAi4ZWUesa6mStVwR6X2I6Kwd/wN33P3faatOV5tBRu8NKUj+Ktt+o7H+tAlO0Ark7Iu0XUahUZJnWZHxOBk2hyA9Oot6Ye4q/AMHxNNw3/a/jU7NlPup+3bAo4Fi10ETfvbGDo6fP/41z8KMucpXL2++K1/ZhOZyMP9qXl4969+OAJkTRP3nC3UL+UpMkP3SwimGqcrxcgddf+KEnd1JeE5IZBecVWGQ82k6bIiGeQMNDzjKYox0F5WQom7ELxA45JBX99G9fsq7hqatbOLbEM0MfYQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b3HjGAS5BE2xeVZ/vL6Ag8gHXwuHKtr+gRPUDCfryM=;
 b=GJc0dkgUQBnlS2+WYAcprSvVnjOFJWgXuH24GMiEORejIYuXCt7Ip7Wp+xylDYBkwsAWwH6TaayWTjM6JnLo51RKfXfaJOmLpJx/Y70m/+KaP3/hVbPiOkABdRrPjoq7T9UP3jA5wIimZkJLEj6OUY3wsaD9NikVN5KCl4M7Cub5/w5Y9woejD0/hEXgD7zJl7Piu2eFW496mEH77FGjuc03nHmFpt7I/qHPlgT0igqWhugYCiRSB9cdnLCPGCsIMK2uW/ebpwz1QOUOHTeFM/1OlVDDRhu9Qw+gL06Ys0+ZqWMQ5metoDn0ZDEKOOiEdGssrwevBojjE9WJQjQ7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b3HjGAS5BE2xeVZ/vL6Ag8gHXwuHKtr+gRPUDCfryM=;
 b=giebjb0mBRJL3gVry172MkI1Gs07MtORgm0+jqZw9Kopgzu16mDV5tUSRdCg9q/uKDOp0usDSEEdPtwZOXFmLvN9cjvdtFUNUA2ehFp7NG/3/IIEUUfgfSgHlRHxuHlPveJGhG5rXElIGs2pucixDzCjOYZtFd7LrI0rxMyNPrs=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.12; Fri, 17 Feb
 2023 14:12:35 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:12:35 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 18/24] kbuild, bus: qcom: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:53 +0000
Message-Id: <20230217141059.392471-19-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0041.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::29) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f797bc5-f902-4853-1b88-08db10f10484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESTmUJ+2nmYr8oD9Gq5L8HZQOOFmKB2R8ICbpydLSSbiC6PTuCet88ogkINCtgpL+t27LOF5n2Ff38CC2dquA3ax9jEVqlPoipSEVJKj23mBq2UNPVengnJBxGbh4u0y+73J2l4TIIkFl8gfpdWXvoWG8f7Vz/5dMdD+/TueGYRiyAGUFLMmSEIA32tQ6NeZwtwQFtyP2tSsG7QFGtXeAN6qJCYimQ0ZBnDCxHD/ZA3ehOTU+qfOGdvzy9fHUK2FdQWjDP+ZbLl6NmZ7PLKXxhK+6H7PvDJR94Ln49IfBRGZDg26NYjcjB8ua8XeVAkNUzp1bhbEkzpnMoydCW6THB5Ub6qDNSkpfQpeZ9VSW3KkSSoA2VYIul3GfYBSHxH9yJh4AeOt31gpwyl5K30dyCxBAw6w7kkrfBtjPNoH3fBIoh3eriXG7rjfPspCOp/0GP2Sg/5vPz8c85i3uMuAgtwL5gaUV/5RLjvZWo2o2tlrtP6zSy8oxBYtPx1HdYBQXLQ3wvjUglF/yBtiCr7MXrJQFnvkMkymRnlI72YSgUN1cwrG+SJtyAR7Dx6BwntscVmM4nriTicNGQvxeYUdxgrfkRHpxllLdaiQ75NclxDUsDhx8AtrAa8xiYX9kUe0oZXfeYT352GmwyYGX52fLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(44832011)(5660300002)(36756003)(8936002)(86362001)(41300700001)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(83380400001)(2616005)(6512007)(186003)(6506007)(1076003)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zd6SIcVUk5cjBHGHgok7bYdZtbqirBFehSaOM7cPdFKRoelTNQhXxezJ0B71?=
 =?us-ascii?Q?Hru/Da+sVMoqs3JOtkrBXkcEBIeZclTfax+oKWhSDUNlT8IO80WENTwSuCMQ?=
 =?us-ascii?Q?c+sOnHvTINPySu0uvWa1J6zsVX8HDfDfh21It8iB5kdS4bZ3wUUP/gW64Gbw?=
 =?us-ascii?Q?V6a7NVF/MrRuArzyKIKERg1+l3RgWxwyE5+ZZpZoky+EcxSoP23GWyNWddKX?=
 =?us-ascii?Q?EZlJZsMowOobVoculdxVGlKas3VPxyYdV9dA2tPLjcamcm8Zay5nK8kgGawR?=
 =?us-ascii?Q?RZYkbc4EeDqzYSCmLQ8YxNSLVAb+AqIyYuucXrlaSp9Fxf9L2RGzIm8kN+Ps?=
 =?us-ascii?Q?qPpxaQ/8ncLBZwhCuZ6C2WcM47McnROfA9Ea+ks5fYOdDIt9rq3sEWDl1AV7?=
 =?us-ascii?Q?bXwiws0POSbH8P/ouUmAKEY6sG8VaFtrSkZAPgKLqSUTwenMhzgBlejD2mIT?=
 =?us-ascii?Q?+DasrlOraU4Mf7jZdLxelLy6Bf+OCjP10Svx4al9ED4esaYCiyU12Wjr6hnj?=
 =?us-ascii?Q?eGCh11IGr8G2ww0/qSWHCLtPJ6dTHY/HocrNly2RZgL/JCW0+g6jL+5eXITC?=
 =?us-ascii?Q?g5WWQ0Nmg0mKEBgvx0oWqDTDLl7mFWCnJXUv7xRrbZfJh2rO/0rUdPV1T9tj?=
 =?us-ascii?Q?nbUxfrdvZCIj7+sZIzOeYFM/tB91k9CNgLBE/b79TtNTxikVk2NftAoeHeFi?=
 =?us-ascii?Q?Henc2fV/giEBZenq0H6muLsD6PgkfMILW5vLXe10rorMoUzYKOofWbDTj+NK?=
 =?us-ascii?Q?XC2vN70GUIhnfWKlmMFRkE5aHyUhm60E45Ei98NnIrDXitxAeacUf2PNMnKr?=
 =?us-ascii?Q?YjTYONbnDl+xeGalQPVyf/1LUTmFgsTDi8Xu8ZbpghaUZS05R7wmEZXfAFc3?=
 =?us-ascii?Q?0FEnL7T7v7KYiYqIa6FIWWmgqtJtEozNNrbHvJ43b6w2tkhO8O6UONA+te24?=
 =?us-ascii?Q?zSPC+jYIc5XS6yForNtenNX+fHWg20elQyn1E77k8N4q6XVvGCbzI4Ap14XF?=
 =?us-ascii?Q?hEh48x5VXTsxQDDaKDyKyAaAzjs8EBN1njEOvWOY+/Ek1siMhCptD5206LDW?=
 =?us-ascii?Q?kTGi58iq6d1AayTOutwV5kyWAkDA1Vh0qtxdNzmYyGql33fmAKs5pAZtiqJU?=
 =?us-ascii?Q?4lbDy5sGOJIq/zRndWiz35MhVL0IWaA0qoyy+VDSPq/naaYWKQZG3q2WAQBH?=
 =?us-ascii?Q?NKBJaRsilIjq8nMBmQboE3yzTymfh3TKs0045Xl7l96vV4VBQ7+Q4jhIb/tj?=
 =?us-ascii?Q?n2pOPHc0qxmUSQDExsTVojBV8Bh3e1Ap0xIvkZ51cmpri3GW3DxLK4IAfq+/?=
 =?us-ascii?Q?j7cdAHe75kshSRd+Uc4/O0EU2PkEbEiFEqkWT2i5ZpZz0CgfZxumADIbXa8s?=
 =?us-ascii?Q?sIIMSHhHWGjmIjsiKna+4C81pRAozPu/3S6RjS7EGXTlC5WaR8uRa5j7Sk2J?=
 =?us-ascii?Q?zSlJFxywjJoxJQACMHm0BoDbWo9HLwPP+x/P8TGQAbsvNOwrSY5sizWjWujT?=
 =?us-ascii?Q?ZaBjeIxeMzhOv6UYltBMte6RO5BO7JUcjNtYQZrSfRZl5iCauMizoBq9lpFS?=
 =?us-ascii?Q?xgKrW6zB2VRb/AxrHA+Pw1o6UwbqfmzXw6xeQDzOWmRf+pps3SdUliBHlNAP?=
 =?us-ascii?Q?uuBziDbicwMxn4mxNbeXA7M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aKDK5ABk/tMlQZ0BIgOMDxnGFw1ba0ImO5dq0XduT6K3Y4TnmB8Zd2MvkcDAEGwAxbD4Vc4b/y7F1eTi/qZQOyMRMZDf0/8DDK/ozWP1Dp2huuV3+phosXHBeaSaPW4pw+ia6QjxIYSRdPT24urNB6BWPA8oxuiCEFTKHQUrslXlLIIsz8rC4xgZn4Gns85PkPwpOfsbdz+3wxxoJYKK08Q7sWQXEa4il931V3HQJfejAW7/JFPkCu1EzgGxGHOvJZQXfBTW3uXwA3lyd0vdGNiTIqzDkDNK+LDi1GN/pc5rHtBUgky2pbNlXywjHRm6WbQvOBgDmFWyC59yXbh9g/U+q6/njM1NqqQ2M81tA8iZ8ENvdghOXatc5bLa/Jy35OBccd3EzSZqYl4SsQZXJue28SUyzJlv1HYUdtZJ9KICoBT2vDDuu67r4DUCCrtbnWeMk/KLGFX+5AVndIWaBpfz9nsUoCmHtqR21LUo18nLKq13Gimirlnx7gik2RfoBHEjqB2OlKS7SQl+zvbqfxLMxDcrQXoHhtPf73s2PH2hCn/AwORN0vPh9QGboNYgdKBr1/tKEWJimsqmr6YdVeXeQhleevG5YBTbRYxHegdEo4oJksQT0eRC/6uWiBFj8i4sRq52b6uQxfNqR47UZk9Bshnyo0PKB6HZErPo4j7wY5YaoiA1MZaicw5XUe+/UvfLeBdcJRjSvXH57oP/dGQ6LQmvYSNMB/1/htVj4RoVNt64sZYWaqFvufORyAuWP9THR4I9B0/kxH4SmB3d+h7vItTyHpqm6IGOpf9ZZbXz0Qqq+a4gLbtVWPuCH0dl
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f797bc5-f902-4853-1b88-08db10f10484
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:12:35.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pkh4K6I3aA07QvWx8AOni2V3qtOILgQqzM6OUA9xM/n9lBLj2ruKtMSGffB6MN76jjZFGgC5KUFqo4Q5nxRCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-ORIG-GUID: fvnwT9JDJYjz42N4KDtphi1JNRKtLlWg
X-Proofpoint-GUID: fvnwT9JDJYjz42N4KDtphi1JNRKtLlWg
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
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
---
 drivers/bus/qcom-ebi2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/qcom-ebi2.c b/drivers/bus/qcom-ebi2.c
index 663c82749222..c1fef1b4bd89 100644
--- a/drivers/bus/qcom-ebi2.c
+++ b/drivers/bus/qcom-ebi2.c
@@ -403,4 +403,3 @@ static struct platform_driver qcom_ebi2_driver = {
 module_platform_driver(qcom_ebi2_driver);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Qualcomm EBI2 driver");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

