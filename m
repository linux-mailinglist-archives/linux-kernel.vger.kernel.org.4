Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA326B7169
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCMIqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjCMIpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:45:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5512728E51;
        Mon, 13 Mar 2023 01:45:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CNxAbN027282;
        Mon, 13 Mar 2023 08:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=3twTDmQzcn3PpUPNMcEt26F6nLlJpy9fVUXokJnpMaI=;
 b=EHp+SgHld+JcDi2bIbB2kQ+BkFytNjt/QOWadfOsHzbkYH7nE3kb2q2e4GWYCyhdGXMC
 ufBXqVEhgI7nr28N2d1ZkuelzPuvBI+YotsNxeITFp13yBZlB8uOekCMp72412vmgESK
 tfDFE8klsWiE9AuTjovr35HHbhyt5Pf16f7ulBkmWgyu5SkXb8fFNJ7w0rW3jr1LZoNl
 SYpKUqSU8ZtZ4/Oj8bqupac7Rmsof998AgFc0xc72SDjrLdImkwWDQxV80bWQBzKTO42
 KC0GmQg1BkT7z7Hr5oC/6FCFYq1gazzMDZ1avqjRDSkzorXW8XlTvdyMzoIdywxKI1GX zA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8h8tb7yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D81e2O015267;
        Mon, 13 Mar 2023 08:45:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34umme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bG3LLVVkqxqbCrnUIMQxcnlX0MvVct/8aHHkeR0rRkecPIom7pdQJvhLhOU+TL8akTSZjKJa22dzypHBUxZ9nGl5tHH5oGSD/NOcPhV7jtYbkj/fNwSZM859Qi6gqDOlcPXGnWwFdyxFmYFNBlSYH9vv2OgrQD82f90zXTmQKeCcXjrX7Ja1R0u0zA7eD/fAatG164VcWHcI8qQvEjCaepmnjpE7isA3tk24NRcGBJ4KOJz5tiDJJwiqrcBTCAzI4hWGbz1Ft1aZaX5wBBGrYeI30tlUQPwsrkx3vJreSP4YjGV/CEpCDvvm7P9Cy8uwe1EGTJL49pbIiESecbO7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3twTDmQzcn3PpUPNMcEt26F6nLlJpy9fVUXokJnpMaI=;
 b=P3I55vga8SZY5IMv8Y4AWu16HSXuw48Fb3KhPFFBJb2w+b44y2oNe41E8HIr8sJDHoFNyFzrxDTli0n/+EIu+lRi4tPMV+N/CKYHQ2u0OlSJTa2r+IRNtR1L2ZGcIbZ2Do2+Z6M0gRKRMJO9kgmmfmzdj9tVshFtWkg3UgGItuRNaB34myFuUcxjRm0PUJv6pgDYo4nZ+1fw930PQTw1oL7qUIKwufeyYAsbows5Low+vr2RdgoxiK+Sb5/2496D7dCg6woBMN+VZAVg4IGsSrrXh7NjHGKnnhIf5nJwVDx9ZukCLrTCArSkBuCxsEFhhStVTvULYph1++m8mvIeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3twTDmQzcn3PpUPNMcEt26F6nLlJpy9fVUXokJnpMaI=;
 b=LMDq3zxXPiQ6yo/rR8XzHGKpyU+ynU1eQhe6aDN6cqX2Bwo5I0Zowh3BmoTRVKoIfTDtfKl0n5cmmjBXwHga2I4SO8aH62jTrqAgsjbXoQIPtIuMg+ygl2QWDRe90VdGuJ0cA2nJ8BH7IcKiV6+kWaMKlLgqTF+3J1u7CJR18Lo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:45:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:45:34 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 06/11] scsi: scsi_debug: Drop scsi_debug_bus_reset() NULL pointer checks
Date:   Mon, 13 Mar 2023 08:45:01 +0000
Message-Id: <20230313084505.1487337-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313084505.1487337-1-john.g.garry@oracle.com>
References: <20230313084505.1487337-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:23a::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0e10aa-9ef8-489b-f5a7-08db239f4fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/vwfgEse/zb9oi61nK8w32+eIO+js2Vc66jDK9UmbM2ak0UPRkkuXLbVZ9ZSXhXXIRXjuaxQaK8eCp3HAnI7eTmJijNDxcvqDK8ymhN0OCoHlRrrPWG4LKie5uaijq1aO51In2pAdR7cPVxAHkhzV6d5PFZEll48NOqdndde+0DNzTMqSX9h94/HMFo19ANbt+z9DCUt+J5cqWCeuw1EF8hRgo2t6j4IkePBCV52maFwBKK2IwTXvtZWeRjwv3IxpAbN1dyvmbQ5tEIUM+YI/dehG5tWsLrOtomYrX4RRMqyPZX3CG7jYS4ntSheUT87/TR37oIOSwatf2V2GrchauoC5ftD7ou/Vgy3QKHUjx0XeElpYJH0wQOp6/6qfSsbm/I07hjJMNu8BIpEAuFlfx05A5X/rY0Tr6Gma0/3Yg2Tl+rBQ2rC+vzBNTWeMHt8zD+SV6Kqb8m5ZUsbXxL+QP7B2SrN7MC7qXPXGo+2UxhAm677v807VezTVmXgD66s+pYErLhPZhBfk99QLUa2D8akoQpHKF6HScXjgYe9dP01pyKp3SEvINWGvVixWm/PojXF1kfjX/SRksAdRdVUnrPC5E9vXhBaMm5yNtMqrjG2cX9/3kE9b2BXAst/BglbycN3iEkk6JbM/Bv6UIGgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(83380400001)(36756003)(5660300002)(66946007)(66556008)(41300700001)(8936002)(4326008)(103116003)(8676002)(66476007)(38100700002)(6636002)(86362001)(316002)(478600001)(186003)(2616005)(6486002)(26005)(107886003)(6666004)(6506007)(1076003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XuedCLXgiX24P5RG0Y+3pnYeSRctdksZtzRC/l54km4La1qSfjqbqTOFlnkG?=
 =?us-ascii?Q?d1gLR4lN3nlLC3fKybNpDO9ZtH45SX8L8B50uXNGBCA1RhBUKZqnITdHYfsu?=
 =?us-ascii?Q?SNs6gjM5B3IC55JFxWM3QqWlJ+bCeEegxwXWKfMrVO9BEZiJQUZlaLmNoFm1?=
 =?us-ascii?Q?FLlwB3dJFlAtgA5syYK5YkgNgC3hRIbScXrEqaZljhHN0Qlbt3DKlw33MGha?=
 =?us-ascii?Q?F9jcUxWJgKaKMs0JQpk6BNlW+gGcznKmGe5Swks6Wz9XBBzBCH+FPfzS1aUR?=
 =?us-ascii?Q?KwQxi7hlEsY8Voa6nPrsMA1cxweO+fEU8T/nVy6nz1jnPD+18Wufdfr0BKzB?=
 =?us-ascii?Q?7An3+3Re5XDayGj6tl6Qoc40mQpNdv7lglDl94r1owcKgDr60V5zgNISfAjm?=
 =?us-ascii?Q?IjfxTmQ7RPr4P0gcQxbvrz5T7unvuZWbZhm/X3AIWhJ1cp03z+69OTRMUvjZ?=
 =?us-ascii?Q?cGcIY/Rj6aoDO6Seo88JubLvzb9YGtE0GHMDith/cW9gR50IqF0sXTDgXZel?=
 =?us-ascii?Q?2l1tZD4wDpPOVLf9cv3L0npre5djR2nTJMcSd/EWaO5oUCLnXigvXGGuRequ?=
 =?us-ascii?Q?W3CJRVO2AdutyqlquBk/HvGjrMT5pXdxH+Fd0vI494CYSf9syKIQ0Bi2x7W8?=
 =?us-ascii?Q?dijommO9wTXiG0e6NN/A5yXZZc+ARm4azKmmW4nnFs3UOnNmJvvv+EbsOV5S?=
 =?us-ascii?Q?AY7lWVgs7Y8s/7cb9M9QTRW6yaA0y3/1BzpcHpyHohJ/LH+e4ttoBwS7KF4M?=
 =?us-ascii?Q?ssFq07gwA6RUQlwelPhpS1LM70QiR3pDxnd/d+x1ejpPdWBzdmWVK1af5kZ+?=
 =?us-ascii?Q?GbyLK4BN+7suJynK8XyqP3yYGy3beDWhiNQv22EUIbFQp4wh4kpWlCvZsMSX?=
 =?us-ascii?Q?JxJEX2el+IP5d3CBoEX00sLt4cmbMRWFEbMDbllvZJuP+vpUJSU5FD3L7Ovx?=
 =?us-ascii?Q?ODo67driBLfWeKnXbsImwiNtXCByWCs4BnBI8HscyqKSLgPjSl1hxc8lk9BC?=
 =?us-ascii?Q?qgx9P1IiZhmupg+WzO1MQQb2WLhEH7RHLedEoQCbMT2iQWltanfLGfmZlUqe?=
 =?us-ascii?Q?0dpY5uO/qAqgLtx1vaBSziV1cbjlL/eG2OWSRyO1/31wszL3N0cMIrv/Y4ty?=
 =?us-ascii?Q?il6YVxtxtqNHZ2fU8tjat3KeIhKeuDc019x1cAHWAihK02qklFxmTcyX/KQx?=
 =?us-ascii?Q?RU4YmRF/1YHdUaV+pVFFaVefEAxQD2QyVQ8Tjsbe46gQE7RIRUqig5uCoN/G?=
 =?us-ascii?Q?ASsHl/OfisZEU/TS05ne9hPNqByGuayXtxBMxjGYlMLRrcINqHRPEyb81HHP?=
 =?us-ascii?Q?e50xP1Qu19SxGZbMtWuM2lTO6GEEM4mREwaDR+jjVJEhGBdNpLO9wgRf7fi3?=
 =?us-ascii?Q?foaTc4PtrZbJUnpkshCOGUPKNsv+s6Y+D2Kn8EvtHhDRVvppblU6/k2TGxF1?=
 =?us-ascii?Q?XVb9OEGylsovAS2Fivs2tmDDIIwGSTxykmX1lVYg8ADsj4eVpit4Tyt/NE82?=
 =?us-ascii?Q?DEZoB249I6BK7SxStLUaK5GLLmRXrU/5nmpA/ncg0pfJwbS9s0pncEdh8r3e?=
 =?us-ascii?Q?wdlq0LW200wds+A1dFpBJMyYEbuux7pfmF5z3R9Srs3XNVHBTJTCaRt4gJRn?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +QJhXv1JKrE854To26zCf/ZIhMeHjM+8ARooSAy7QKJSm/T1cXtx09m9IS0bstRuIlSb6xXK4HZuTB1IXuVnzSGUz6E/yx0gYCDovNkRmVt8Lak96B9UcsIWpOAhxq/FimHTsZ3ZimfWBDhQLORqOlzHWzE6poIUPiCUaJAvUW/lS+Vrz+scGJQqTscPymhtnlbEWiCsn8AohSW8DZmDkPDgGeQ7N1t2XVTP5cFQjrYSqBBTMZo09XfRKkyJdusFUJCQ2OBgMBm1N7xF43WeAezYTW/6ph4w2isPvgXORDeiUQ1R1ONFotv80teKam2FPXAngMcX8IUFol6dfSY2JZ+cCEUIJKYwgfa3mpU7kmiittjLx4uikLd119xskjklUnp1iWgungBeLFgZ7nbz7QCwns5u3VO8VUUj14d7w2noAPHSzMXQv6g5FrhjV1TGyz2Voyt36v21Ux62MLdXy5LTwXxDt4w2xEgZ2etNh7jqkAhmnubJ+zH1kLVE40BStV65G+z2TJwF2GiSZmXtEuKmjnGY+j7UViYnfIpg0GHJRm3eIUtdQXJw2Fqtfthly/Nk9pgJsXTqI3X4GVCtjWrFNcTKDvGH7iyHSyeufyb2q0jjHUi6uU36VErufCrwAyO+w2y6htQJDgLlVkbzhpUg1BdqpecqgW9xGEDziqgaGpa5jgQ0UdLmqqfbn7iL6fv5dS1XP6xW9hindLYz37ugSutQ68deQFtvliIDc1VZjHjuuwUmhdCIoFSI1moDFBLeXTjVaiKsiYUcrjnNwXiNQeQ8Qb9KqDfnCZdhM+u9LPmw0Uflz7/rDg5mpGD4GegBy0ROCogNXqIEgKxGfwa0vQqaAOlTezclc8p3uKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0e10aa-9ef8-489b-f5a7-08db239f4fb5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 08:45:34.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gPzI+a9HlvsT+RQPvkjet+V/ejo5inTqHSxuwHf/6YYCMiFe6fWEnq6gZUTyeKk4wbcbtCew6F/ytS5pTX/WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130070
X-Proofpoint-ORIG-GUID: SczhUJ_zHd5LU_jh4msMsq4Hd_mW2mmW
X-Proofpoint-GUID: SczhUJ_zHd5LU_jh4msMsq4Hd_mW2mmW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checks for SCSI cmnd, SCSI device, and SCSI host are unnecessary, so
drop them. Likewise, drop the NULL check for sdbg_host.

The only caller is scsi_try_bus_reset() -> eh_bus_reset_handler(),
and there those pointers cannot be NULL.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 6364d6f08861..749358b48335 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5412,34 +5412,24 @@ static int scsi_debug_target_reset(struct scsi_cmnd *SCpnt)
 
 static int scsi_debug_bus_reset(struct scsi_cmnd *SCpnt)
 {
-	struct sdebug_host_info *sdbg_host;
+	struct scsi_device *sdp = SCpnt->device;
+	struct sdebug_host_info *sdbg_host = shost_to_sdebug_host(sdp->host);
 	struct sdebug_dev_info *devip;
-	struct scsi_device *sdp;
-	struct Scsi_Host *hp;
 	int k = 0;
 
 	++num_bus_resets;
-	if (!(SCpnt && SCpnt->device))
-		goto lie;
-	sdp = SCpnt->device;
+
 	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, sdp, "%s\n", __func__);
-	hp = sdp->host;
-	if (hp) {
-		sdbg_host = shost_to_sdebug_host(hp);
-		if (sdbg_host) {
-			list_for_each_entry(devip,
-					    &sdbg_host->dev_info_list,
-					    dev_list) {
-				set_bit(SDEBUG_UA_BUS_RESET, devip->uas_bm);
-				++k;
-			}
-		}
+
+	list_for_each_entry(devip, &sdbg_host->dev_info_list, dev_list) {
+		set_bit(SDEBUG_UA_BUS_RESET, devip->uas_bm);
+		++k;
 	}
+
 	if (SDEBUG_OPT_RESET_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, sdp,
 			    "%s: %d device(s) found in host\n", __func__, k);
-lie:
 	return SUCCESS;
 }
 
-- 
2.35.3

