Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4965569ADA7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjBQOOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBQOOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:14:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023054617F;
        Fri, 17 Feb 2023 06:13:51 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7hfVh027191;
        Fri, 17 Feb 2023 14:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Bwc3OOW9WgedNktZ4mRSsYL6iPpgGSM96zdksZDN/ck=;
 b=2y+nhWGLCTWW1QbttzryVyMMy8TiJKp/vBox5sWxl/RY2yp4uqQt72qNmqsbbquWWSoG
 tzqC7i3ALYinhZj0a6O+FMqwtTnNrqJFbM9aLCo/fs6nh1dxpY8QcLCm81kCQ/I0McSf
 xVQ0Ncoox8Gky8QhHlS7OJDvfTz7FmQU0EMiFhzECKeGhCxKPnEjMGMP6K70tiomTN2d
 80PaULsaBWldrI9rhxz47yfrjIWStPYlzlLVLytp9WdnJnYKLQ+o+Fy9NeklNIwlFBPs
 LJjSEM8xQTNl9iflVoP8urok/eBa55brB8bpYOSYFNx2gh4xcAyJE+4pomCDinMa0/Xx ZQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32cp0f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:13:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCutxC020120;
        Fri, 17 Feb 2023 14:13:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fapppx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:13:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI0A9sj5KUSUC3YU6xCzT7qHAjO6pV5uA6qQEdZnSoh7vCf2KcwAMVI27AARRZ8w+gpyXyDIprAxZZG54lBxPfGHU3sY4flddd3Yn6h+IIu9QTbAEeV9NCcyJDVIA7VspYcOsxC1HZ4y/DLUHLcusG8U9rPMGyNw5m+EwPPucMl0J2QygeJHOLtegu6aZf7rChJkFBxNCl+p4dIDSTmB1yAvNmg5OwUmOV4uigLNCCUSOf2cNdYhjq6Pe0q+bux7heFi6dhH02Dg/hJdRwhCOJYUErC/5Y5nMMDRcPG94z/sRXy9kuXSy9PkajfDH4kay0BREVkEiQ8EdFF2/Z43wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bwc3OOW9WgedNktZ4mRSsYL6iPpgGSM96zdksZDN/ck=;
 b=hDdy6BlsUjWKFapotuQuOXlj89MBvEYQiuKI6YKkrJUO922D6hR4lVZwQWz2kDKcIK8XtGc8mP8gmSJ2YlQy7gzh1mmrpwbjJSG0KAMfkWmgdK7CIGiIilKSMlIRNYk/6X/FZVxsc+6bMq9sbGXczSs9AFrkiAblxZnSxGuqlEwsJ1+GO+MghO0oS9UO5CRGjwKWED5Ws+GAeYb8g8ZSXx5jjuMDksO5omNjardg9fZZuHHsHcu4xc916RvY2uTUSlfIfOSd/ZjzDBEjmBvYd5nSnLi/jdx/DgSTLdZqxQXX7Og+6O1DyBbDwBK0yMU0xZUhYmnzc2oLFmcQD2Uakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwc3OOW9WgedNktZ4mRSsYL6iPpgGSM96zdksZDN/ck=;
 b=XW6xur4iK6a9JuNKfG0CYKa0yo/aW6c9OcRbZ4ohasAEY99fGw3kbC5J9+z7pSftd9yny8DCEy6aalzOKUKPsejjERXb1iyVa0RQRCHz7S/ht+E+ha+04Y0Fx7BqT1C5z8KCW8DTheFflkbg7ItP+LWMUkcTdhltIdnrbHoCJRE=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH3PR10MB7493.namprd10.prod.outlook.com (2603:10b6:610:15d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 14:13:03 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:13:03 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 24/24] kbuild, power: reset: keystone-reset: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:59 +0000
Message-Id: <20230217141059.392471-25-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0207.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH3PR10MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: adba4090-e34b-4b1b-b9fc-08db10f1151c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sQv7tqSe8jp3m/SheUK8zZxqcAoWgt1GGpEIBn2WubdBExwuarui9dD4cvXFf7nITKtllbTdjTnDxWQHy22xHyyqj4MYx0G+oxbhN2yvkFchjQ7g9QLQtRsdvs81jUVJBmVpIG5Cn4HvdDyiHeZLgu5hgPZ/Y09Mlrg+9dpeaRvJrzug8Rb3zYd9gTBEfg6AjNvuSNdaAu+vluIkCaKOPWJcrdtUY+HIyqUBJ5DeZ5kp+Q2Us+aajpWF+Xc/jPAubE9jDebNTmwRJ7EPq0FXbJtWAEdUk3RrtcMG5uGFXkLGP7Yizw0fcfgQAdCIPDVA9JCAavIUfK9XMo6fzplqlyxffjx/F2sNViQN75S3uC130/qR8inUbSMDgtEKWGx05PjhpoTb17bCpjoDKbcCJi5z9B39jvy3fu3zoYj4bH/x4afyfnTbLGJ2Ie65W3miyspYpgmesc4YWRsnNAerYeyW73HziZmAHmRuy+4K30oABnBhquRgZYDRo1rEvGQBwLpoHsugHhD4T+mh4ELCp51n3+P9qYm1G+0lgF60gvqLwTpwKtT2acYdGcBZEZDvUrhZgSeIvhGF8z4OVzd3bwPM6hJYY5l0Foe0+eoYX3BXu6XAqOLNfUHbaUE+VCDcBcXcXbqi9IYo3R6i9Widw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199018)(38100700002)(2906002)(36756003)(6512007)(2616005)(478600001)(186003)(86362001)(1076003)(6506007)(6666004)(6486002)(83380400001)(44832011)(41300700001)(8936002)(6916009)(5660300002)(4326008)(66946007)(316002)(66476007)(66556008)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GEhrusqNS+tmydOZJTgWyp07rDAGD8tMg8de6LXNocN/3XmdINQ7zyRJQssd?=
 =?us-ascii?Q?iviRLpSZs0K4pDgfGShPCLJSqInQd9yjqMD1AZ1UvUupeOieZNB+CL+CrY4a?=
 =?us-ascii?Q?FQaeXRgvnoV1l+kTIdLW13Ky3gA344vOhSpVrAJXtp3sxSWhcQB1gMUE0brm?=
 =?us-ascii?Q?Yw/MXeH8SFFGWhZ2LUknJz8ybT10atRl+jN+DbNLLJ1fSY1WoH8jat2TxlM8?=
 =?us-ascii?Q?qe6SlFPk5drS9zP6avad22TVw+A700iUWXSGpHQ6YohbpGrYDkIw7NX9F7f6?=
 =?us-ascii?Q?WEo4DP5/vv+vVOe8VtqG++ZubfK+uWGWQytMlZLOELKoa4pvZRFMNF9RPsPx?=
 =?us-ascii?Q?V3DgEhxKyFYg+mIlspBJrHg9lwzNom3K9R2F0EVLAIMSCqkcu0OdZ7OUQwl8?=
 =?us-ascii?Q?KwCxHWZdzpU3ClhOzIW38aHnpkfod3v/gy1T76hzWWWrN9BJt5+yIALGBReU?=
 =?us-ascii?Q?KWGXpMWRGkqJAXswABiNpdhI4m+L2NccrGiHXytIiOOgPeH9BsR++547G7Oz?=
 =?us-ascii?Q?zeUkZGjHSqACtj6BEY8jyAKgN/Gacm3JiStEGrT9BXuRLeLpjPqm7Pu39mem?=
 =?us-ascii?Q?6oO7LzAUMluXGNyd990Zb7+sEC9SSCcFYiJgYvFmcspZt0Egom0SO368HchT?=
 =?us-ascii?Q?sA9fcRHvgraqivXIU1z2NPVL88Rof2RMmy8l0YYKrZ/+aFUNQYfWpusTtyPK?=
 =?us-ascii?Q?S9MPjmMVLltLklekadr5gnvidvEEAAlGBVRCTJ0WZJa9IJbfEkPkZl16o3eX?=
 =?us-ascii?Q?WcrUfOsqIqCxZlOw0tc/MVnWxubShOuP7kWgj2I98mywmFuh8u6LPZgXgIkO?=
 =?us-ascii?Q?Gg0aFzbUGv+PDv1V/f4fg3h1w2gQcrFztEiFK6lWgTIJs6hSpGXqpW1V0Aas?=
 =?us-ascii?Q?0yFpuTR/pQCTHRlvRPkFh0WGyVA1i+Le1TILJrv23QI9UcJczW1tfwcR3TUz?=
 =?us-ascii?Q?lwrU7FbcSxtWIKHzADYEJ2Rd8SRHGQVd4aHT2pwiMJbgQx12Uq9AvPUXe1uX?=
 =?us-ascii?Q?a2z2A9M/UYuS8VtlMkoqN7BMWwROQ6QdPFfMexwAcGT66ClDNPY7Cdu+u1zg?=
 =?us-ascii?Q?s2V3X6K6tDZVfaiMobYvnuMOJdF/aCXzhALmr02u+4YSPJ7hah6nVh8qBUl0?=
 =?us-ascii?Q?b8lyolDPPmJUQHmVxoDAWUMwcMqpK0HzFLAWMdNdnpTOgZR1LZH/tdbbIZ38?=
 =?us-ascii?Q?DPCt8lWJTsf39glYbXiRMeTenVaJ1va8eERLJG3wXDknlxMyFcABPUm04iqW?=
 =?us-ascii?Q?55a2cIfVvzQ9PZMAX0WIxn8Eo2duKOBohR/hPcSIxSHE5ur4TXXbhPo8tgCN?=
 =?us-ascii?Q?buzhiJZ2RzNx5OlZb1HCHqdzkbFT1tVVvVHOxJBdpi99qyHo3Pq8drYDkyaB?=
 =?us-ascii?Q?EjIudyamtyQYZomLn0L8OltBUt8NEiGccFp9+YynBClZ7ABV069lwvYjQJRQ?=
 =?us-ascii?Q?9iAVwLmF/cnGeyoWbUj5Ut4dnfOFGuUR4TJsFqwKIcpLYW9P4/mkApP8tNkT?=
 =?us-ascii?Q?/8crIUYetL80CN10nBvH8/aLFGyzU6vS+6P2+1I+oOUFxTNqiHtW4Pg9oVCJ?=
 =?us-ascii?Q?ZMARR2/9eGYAq3jEaTu4YPOzjIlZXsWVz5uXxycBXwTF9yGl3XJemVRSGbyJ?=
 =?us-ascii?Q?dGKYDYLr9OTJwopbnSxnzzk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ipF/aWseSWCpqbR3rjthUZrMVEpxGOkc64FIbzeUi05JjN44XvsbOjG+PEKcjcx4htfLDA4tWxNQBS16/IUSEAD/8rCpBPMbpPiXZouHMr5dVSV+s/RFQndvblKnOraoTz3PwCsVwBeu3yoeXph+7x+JKo89PrVVekLI3aUL/pdpVJS37PPzR04V8l1550JH21WDOFpgb6aobypIgEGSdSO6fUlJRzmTHkDrXqJsY5ZARGbVnMR9EJ3o62fInZlPa80kbK2+25I8r1FqCDOvpjyQ8onhjlIM1ML1qzNQZ9KYsTzSB/TTRCyE6LavIMiOiM7OWYYzKgHo+fdOFmY5P7QysjcPtS6bPYEnm5XK44eaYelkgeBNyKtVn2I3BHCZCvoCm1c2Im9lSteWPT3uJ8fhToGFUbgo8lcMygGKvEmsHCRnd1MqbpTPOcGHZWDs7ylFgyt6VVgwQVKDZs3CIerZdGcEu07d6ptoNUpkJJrfiyBxVv38tXLSKeNImT2Fc7JNguFvzsFM3A0hiWrK3xRK6ziB3Wbfcc8wTWWUIUQyvflN+gI7c3msuN9buGvoNxXA80I3ohUgX6p0V3Y03Zawn28szFDcEe8ThCBhg6d97rqyJ5qeJ8VHnLL+BaYRLQ2ZGEDo9lumhScb1QgQDaRBr0bl7M382Pemxihn9QIkVnOJGF4HM/F4fqYuGqGuUNtptKeRrjNqwjqOKhMeLmAoddrm9QZwgVvLSq1JJC3un5RcIjcLBr/aJ58HVtibackhphD/0A0UtvD+MlZ+wvD4sKsmHsjX61Twnc1zqcovR48drIX3OiSHDxUrY0Qd
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adba4090-e34b-4b1b-b9fc-08db10f1151c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:13:03.1830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXf6SUpxS7pGRqQD6DnnAuv/WLtJA6gFDh8aG9GvmvFgEqpLtUqpAYk6bJ72eu0ORMsi6tTAKgq4uptMHo6VBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-GUID: QPX1Kcns9Gu1sSikfw2k9Exel_8-aY53
X-Proofpoint-ORIG-GUID: QPX1Kcns9Gu1sSikfw2k9Exel_8-aY53
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
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/reset/keystone-reset.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/reset/keystone-reset.c b/drivers/power/reset/keystone-reset.c
index c720112db704..83a4e1c9bf94 100644
--- a/drivers/power/reset/keystone-reset.c
+++ b/drivers/power/reset/keystone-reset.c
@@ -169,5 +169,4 @@ module_platform_driver(rsctrl_driver);
 
 MODULE_AUTHOR("Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>");
 MODULE_DESCRIPTION("Texas Instruments keystone reset driver");
-MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" KBUILD_MODNAME);
-- 
2.39.1.268.g9de2f9a303

