Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5578269AD84
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBQOLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBQOLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:11:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509B86BDE0;
        Fri, 17 Feb 2023 06:11:33 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7hraF003558;
        Fri, 17 Feb 2023 14:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=+gqlOCEUOlTgOO+deJ76kqdWdq1sDWGJGwftVuzBVuU=;
 b=xgJYi/1JebijJUFkFoKVz/R3qqyq6bzo30Xxy1xZVlAACODFGQ4ioGyG0MC4+ED0T8M+
 Bsmmd51i2v//nsZK+uSKoUBumwdwr5MHZxYErqNqJ62WDrTo4Sk1GWCKC/hp+fct4CMT
 xMxH/lB5Tnykak2xNVdhxVChKbj0KVh4xSrtC7iV5vgNsiWjp0zH2j2+6chQrDPke46e
 vWthzM1pcG6RQCF+i8w2Ns8CZqKhFhIU95304oHsYg8kELKMXnAjfoDlXjPqNrX8KuJ6
 Awz1VmDb4pHsrjsG7dyOY2oa3axVB/mvX0SkFeOD0qPmTc+RbHCQ7lRRy8GYM9lZWpWj DQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np3ju5y8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCEZVX015352;
        Fri, 17 Feb 2023 14:11:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa7nam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbFDgH1R5q+X2kn+qLi4I7kQKLgaUzOPR4dVelISy3MQVIX19UX5fofVtWc0gz7Cz1kGoDUdjSHefkZ5WD8TjJ2B75p2O6O2LnBCTJn0LusL4orOHyb6pPpfPoUvT+8cubHCw2z2DzMvTs6UGFBGqVgSqGJ3QN2nKuoQQxV+7Ccic/tQyKCeOecVcY7271kNzyNeTqqdixgK8PS9f1xYXe0cgoD1coCrKJdFm6jBIPfvlkGBEo3UPMWWzdsO1k58+BEbd0X4y9un++GMWq5kFXtOujrzSLEEXo+TUg6MuGqWiGLY75RxBT0zkywFWYriHT+r8LuqaLI7a2kZyLlKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gqlOCEUOlTgOO+deJ76kqdWdq1sDWGJGwftVuzBVuU=;
 b=MNoxpTj2K3FPwWRLAe9FZUJcCaZgBhxcfswoSGaz6nXt54XNXGUIr7jqPqZXW1J84ctfrcz8WMuLJvDXg9YqI5iaiJG4DwMl//P5on/Cc7w7/IOuQn4N9EY1qNXB+Qyf0Iex2mGnwecam8Ykcr0o+e/QKXV7IrZN5QKR7Bm2R7FXNP7yjpUpXioFpyE6RO5tJUA1xsKA9Xtz8eU8HR9Jw6MGRf4IGIvwl6Cofu9oG+K3gfnT9WZe7dkDIG+8nBu3wFTQgyvDTNJKx8w313sRtYlS8/J/nCDrPN3aCmntvIbE2S0zQHpvGIalEdxJoMITRVYNcK6hqxZBlT3WN+T+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gqlOCEUOlTgOO+deJ76kqdWdq1sDWGJGwftVuzBVuU=;
 b=d7vc2RRzKzBg0uu6ysQbVg0k8fo5F9wJnOWg8q/ZldbYC/17mbo7X2iLNo1PqglYP2QJ6QYVrUGOipYesRk9CQnHj6tGo3OPbUb3TkxI1Yq9McApxw7VEvuSLU1OpGE0r9nK458G62/Bkty7GtnN/VHm8b4QAaoxgEVg8HYlyuc=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by MW4PR10MB6420.namprd10.prod.outlook.com (2603:10b6:303:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 14:11:23 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:11:23 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Lee Jones <lee@kernel.org>
Subject: [PATCH 03/24] kbuild, mfd: altera-sysmgr: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:38 +0000
Message-Id: <20230217141059.392471-4-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0660.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|MW4PR10MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 370c37af-3943-4a1b-ccbc-08db10f0d9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwdSijA+jLgo1RhzRk6DBKm0kdPvqbUe3a8dS6o3UiujN72SYXSYAZTpAR7Q4QsHiS7JR01g/ySlFPc/MI/gR2d9+Mp5PBEAhpfEoYXWKg0nwt63fpPOXBv8wR1tELx76wInr0X9oTc7xWLLr+945Bhgy/tmz3hb6yIsvtX14McA8G2spJjfDxcnEkpVgPGwx/MjjMUTT2rispPNXB+LyOIZ0E8BvuJOhX4qEDd7TjPejWS3BamBsVgVKyA4J3UwVXur/Ife62KPtlX2D9a2A1qukteVvrh16zmqH/D9T20CSXgnGDEMlK8ciXoE3O7CgCv7bhh4iaynj1WA4Oy3NnKdVLMDH8y9KLFs59+XatRTkZ8y0xa2dDrT/XutoDcYX+FABuavOE9ehnF5vDMHgGR84fgq0E2yFVrVPkyyQR1iuleDSYYQyjzM+okqZgJFlBfuOxmvh+1kHtMgCzgLIEpnbp3D1wMTD0vGaxmK653cWyT35BalCW193H4gfcLt4JGXvUzDF7MEzhtI8YvNY4zE4KwBbOUaVVkDbat7en9QdVAyyHjl27uFUajWM1AjnwmhraF9klhPMO+HNErr3E7flG81FbttZc7sJ0V0EYA4XZ055ZL990q2Z/e4kWgBRYD5MS6E+7EoIbT2pqJqTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199018)(8676002)(6916009)(83380400001)(54906003)(1076003)(66946007)(5660300002)(8936002)(2616005)(316002)(4326008)(66556008)(41300700001)(66476007)(6666004)(6506007)(186003)(478600001)(6512007)(36756003)(86362001)(2906002)(38100700002)(44832011)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NxaT0B1njvcaf4DdSLfwdb4GT1sGak4YgsnWS3l5tJ+cXA+09gfu4uocEJCc?=
 =?us-ascii?Q?x/2T4nsKiT2gs/eeRsoScuQxZRBuhktEcYseXRBmTwpK0pubHRx/l7oA+Lkm?=
 =?us-ascii?Q?pr7Ma3USb+DhETQlvXUG+QG+A4DMuiYdMMGKz7GDSzjgpFP8xIHimaGmUQq1?=
 =?us-ascii?Q?t2jUG/DcV3z0Lj2dWRsZH7GdDDomUkwI42Oto8O8De3vGi+aEyW2NuyIp3J4?=
 =?us-ascii?Q?XoRZ6h8THZdejOYMqSkDyHrL4OTUABibdHt3W+/VymOvOUFpOsm6CDRlCLBN?=
 =?us-ascii?Q?VgpaPbDq1d2R/Xjip5l8YITbQgw7EYSt8qsD6iEEOrgyw/+J+k4wRcgVg/48?=
 =?us-ascii?Q?d4bhWaEE2T63YjmimGEinsWp3rgi5a+LCvRIF8HG5XdfT9H248omdN7BnRny?=
 =?us-ascii?Q?8Z96snx9ZrNrou0AzEGm9lmzvAmKyQBYnovyfxreoLBs5jazZrhklE4gQvzT?=
 =?us-ascii?Q?6QGmoIV7HfWh4cRLtU5XYWM4R9u7TIgVnftrgCzk2vYUG9pM+cMaASvzE0Hh?=
 =?us-ascii?Q?OeNn4F1knu6SH8W6jdD5a7emsQsmDwMynoRis4mx7OZe+xiAF14rW0YkhPga?=
 =?us-ascii?Q?DSTj1vgr9Sl9K7KtDfiqrcpWZGViNDX84tqxdhzSdldKbOQ7iuCsltKDkXt4?=
 =?us-ascii?Q?YLDgSKU7Zmb9f5OyNraRXBkNuZUdnlh+q2/er07Uhf2UMW1bCLZ4yMkEBiei?=
 =?us-ascii?Q?dUVjVAuEHR4wYq3cYgLQYDN6OIvbndBLsdqXAwKlf5qRdsDfV1D0QtPvJIK3?=
 =?us-ascii?Q?T6DF7DHEyk33rMjoHiwAd9QUAwymjCUY6crbUDdzfdr0PvHowiEdJaDLobk8?=
 =?us-ascii?Q?nl9dsv5Q7hWCQruCu9z2Hta2ZbZqNk2WzCWoiIAJvJMPXjHLdVi4IzJopaI+?=
 =?us-ascii?Q?SHR35kh3iIivNNP9rDjLr4xak1lRrEr/nPCQuYuXQGkXqYQ65uBqI0B0SKor?=
 =?us-ascii?Q?8g1iTpxImUpud8FgM6pXX7CmPNSbJxIphxniyA6byYRxZ6DXzkxuz+h1jpIn?=
 =?us-ascii?Q?S4K8H8AO+2KSmW6R9MIhQQVjJX7MVN57MNTxe+okOlIqxaKOG9jxH7N6FFnA?=
 =?us-ascii?Q?I0ON+5WBu6fwROpzkPpWn7fZtF5wvSaOECAhP/1BBj0aL4nSIy9IPBY1APKM?=
 =?us-ascii?Q?98J3asKQ6KHVD07WY2SV+AaBwnvt0gJOnNp0F9yVz5A48mpDRgh9k6QCfL49?=
 =?us-ascii?Q?zJZxsZOJpaaQmvi8NT/X4h6UgmgpmrcEvcOCAvUbNpQxEW7GMK0XBP0ElMOj?=
 =?us-ascii?Q?x4sGVCO6Why8RFbfgc/GcX067hw0SohYOykue2Ijrn0Ci4xMM6agsJKDXcZc?=
 =?us-ascii?Q?VXF1ajIzJmpXtbANG3zOS70xMA/HX0Y9nSjznI4seZrwBy644rDPBXgOxjYh?=
 =?us-ascii?Q?Zb6wIoyClUYQA5pUVnP7cB110Vs5QiydN5JjkouK+DwyWFL2tvLPQPboCX49?=
 =?us-ascii?Q?xIiExVzGKw46nRPnzwnRtLgN+Duha/NWLyIDyD04hcJ7L30s8kyuOeIfmoiR?=
 =?us-ascii?Q?1zN1bUD+J74OLNzHqWuBLcHZ2RaV6ePM+Nb+iPVgQlcwwhdD28qMbDB0CEfK?=
 =?us-ascii?Q?wK4ngEcG/NmRjI3167eo3uHmYYKmSYXoBL5NGkRusc0xK1CTpRHqX8wHPWIg?=
 =?us-ascii?Q?PPM3Ph6k7BT5vbSwikbEutI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LwuPWytEavszqBvYkvACjKbtrjVvkR7TJP1ESDRP7tJwthiEe02PSVxOjmi1LA7MKojmmAlftENRp2Q/nxouCWsaZlOyJBjMmTtm1AJKKGruICzX99ACSmG2Ap0kQXPv3N9iYNolQskhcpX8IC3X0bqGvi3vxVpna2yLXBGI+3xJLo1C0BhHuLTastGjv67uPnYMmwmwKZaO8r876PaAqWVmt8RxMqOIRGDh1uvor2kQF8ksIgawlnJpSdjf/Vc3/C3Y3Kin0lg7I8hBErSPOK33Aj/4MgnLBlgcWxAkZCMzhJEL4h35aPYIG212t+gKlCAD073zU/8Ahwk3oyJOBkEWJZPbmZTHtVbSW8x/xnnsJ8EoWu7g+nqIaXmlQCmoH424bIIVKzAz42TLZ+e1+5qzg3vVwEdoEfeReya3FE6E4bEpYijwmT4PAmblP5bZBEr9fL+vfMAmbCcAmFpG34QAjS6HI6nF6hUoDGEQ4VRreGWZ0gvxTnRyy1hb9cShgwHF2otzmgzRMyl1uZRSITgsXlYzpQOkFo+hVZZ9Cy6pE5RqKp0nJIFvJbw+NfT8rHqtoGs1mQRW38ey1i6VTnsj9IsrH/IJJ6GP/G6428CYV+2751Mmbj2lCqlxgpclVOcfTA3FmFqHFoN/RgON/Yx4pFeG464qTSHKjhtarqim7b/lUpAOsSQhf9+2wZHOcq8lKWC1mAqWFB2ecrTCx1omibL+HQGsmkenrUACTDuCCJC8ZyXEpQfl+PK7ft7glfG6Wc06Ma50+R+dD3ddTydRBMhD5dTtMCdsgUuRZnZAW+bBzwmOwcc+nfef7TIeiM2cTaf+6UJul0dCpDw47wrxdEsxzbTMj+0WK/KiqZc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370c37af-3943-4a1b-ccbc-08db10f0d9d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:11:23.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzEXJmRDaR/OpohzV/AOZdrtUaQnpfb2bLcwDYZl/23R9iyzrgL5CjmxjErU0/fc0XJbSvKfUqq33C+ZaJUWFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170128
X-Proofpoint-ORIG-GUID: oyfBUW10eeoanaLLVLKoht-a1sEHVmdq
X-Proofpoint-GUID: oyfBUW10eeoanaLLVLKoht-a1sEHVmdq
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
Cc: Thor Thayer <thor.thayer@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/altera-sysmgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 5d3715a28b28..af205813b281 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -198,4 +198,3 @@ module_exit(altr_sysmgr_exit);
 
 MODULE_AUTHOR("Thor Thayer <>");
 MODULE_DESCRIPTION("SOCFPGA System Manager driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

