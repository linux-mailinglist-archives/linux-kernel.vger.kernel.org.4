Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D993C6ADC8C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjCGK5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjCGK4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:56:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E9A5BC84;
        Tue,  7 Mar 2023 02:56:42 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32784PwB032149;
        Tue, 7 Mar 2023 10:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=o4av/CFOGKxbDVobMIKS3lljhvLbxcIxCcQaIFhrjWI=;
 b=bIKS5zQzAz76cVxd/nTJuGJ6i8joXtlwfkXtDXlbHbyI9UnoHiHmAZf9JYzAYHJQiee/
 MSq58KStZdCAYZhg29wqEvyxYCZL0E0rkZag9KZL4dbak/x4T/NGbxlyMJIKYHokkQud
 HQkrwAr+cm75NGlNc0eHVbE4Q+ZV31kOkI7YDPQ1Q5kHHeccSv1sqiZZKMDDSkboUBfV
 dDU2npbKjJI7BsRGHye03j5gdU+tSD8nGalpHAO08qr014lL7fNkkcxX2XkOionERyLz
 2FFZyeJU9GJ+zYIALEAVVXPpAFvuvKqiJM4PvxXIzNQbei1tmqe3cwHqYWX+jDc2+8Yt Qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418xw7hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327AY0gb023444;
        Tue, 7 Mar 2023 10:56:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u062k94-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9+exblbhcaHIaakYjunToRLjckFTU27/V6W5I2nVOdWMJaVxu48QQS5CbVK7VDWH1E21QvZC9UoISNU/3JxgLEV4yXbpjS3tir98IneczpcHihGY0fuglEoGLWMEcTp+JjyZmPb7VJGmL035UtDbr7R0FGizmXp++RG9o+jmof9j55p0dIiGjMCqzngQ+45wqLmifxTYLjSkF/G7XmppQj/egC1wXm+0+vYKywIOWJSsLjOa0Wq7nY2o/yMmKTG7Jeb35MCb/gX9aaCkaCFMFeWFQ+5BKHMyP7GuondYkF6eY175/APsFjGNEnh9Z1miWAYG2kxiqBdswiJxYNMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4av/CFOGKxbDVobMIKS3lljhvLbxcIxCcQaIFhrjWI=;
 b=bq+JIotiliErxlxA1IieNaJhzaBgtiJ5kr6BE9zHMpH3sXGV/tMaIOAx/BJoR/ZnTLL7iKOlLNaNf5ufFKRmESrpDGAyX61tsiPYALA+wBXE7LAxAIfdtDuEF+QddzElCDkkJn6LRN6w9CToIJsRLQnV7+Rn6mBftpGFjeBzjqB7nUEX7JmmpKGz0MDObCOozONu21NhvLOagbeXC7KyeSbZAE6/9vu9ozM+yiGETZYqzDAjIrOipaHA/SmFpqmOdoETze49QtSZFUbod+Pj2RNvCHdWAo3MgEaTEU3h5AvEGq/wc3DjBZnZ2d5GPooA68D8nyG5sWSq/5hDPSpH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4av/CFOGKxbDVobMIKS3lljhvLbxcIxCcQaIFhrjWI=;
 b=cq4YIQ6LeeJXGQtecqhsh9onIP7a40loANuTJNEDui62P9lqAJjaA1AGLVad1IzNxne2tlfUfJKBJgN1VYJGmdDlubQQtJqC1yC744WoQfCEZC5ref49p4Cn7XmBdxGQTpLdSSEOqTkKpiNsyg3ZLDVpYEfNHreK2lOdPDj03LU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 10:56:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb%4]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:56:37 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dgilbert@interlog.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 03/11] scsi: scsi_debug: Drop scsi_debug_abort() NULL pointer checks
Date:   Tue,  7 Mar 2023 10:55:47 +0000
Message-Id: <20230307105555.3745277-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230307105555.3745277-1-john.g.garry@oracle.com>
References: <20230307105555.3745277-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:4:60::37) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: b369364e-8b16-4e4e-c03f-08db1efa9ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E0UnyYNkLPjw2Y0NFMhyv2hRwQrl7t7qTGkAPUdwVtTyZe3n3PFwXvgA/rYZsNz0nsDBHJ4ltQyZ70pUd2mQsmIXV2xqEjUevJWg4Ily87Pc0/qMYnXv3sgC9+yTHN9f2HNh6zSDJKEIqMsYhVXwYRvJXnFniN7iZJ6onDWAWDzJdYE2rNmPTTOrA/NLRQc4QMvqwYDt2++NwZE3nZFDLygk6NBGpeQFFuIFeSgvJMyyenh6pe1YX2tQ3pINmL1Kdx2dDqZp2eC7IgZ+6OAcjnFft49clSlSMsNL+rp4ve5wQSTlXkdOaS1sZmRZ3PYdIJMlvwEP757VNCBsWtbxtmBh6OSE5S6gWLFeqC+aGpK3c5B1HwfFyVXUYRoXPXrKKJlPeOG1WxRfJhT0WhnZyU8sJHB7bVjYSwbk9wpds2O314bae/PVwPsnCeMT60RtyXGEuYX+S8D7Sm4KF8NY5pkJoRuzeZZKCtHCCvgOydIOg/uT0vDMesTDY900aeOcRVhx6jqZlGMEt4I0WiK5dF1YL+Eco1zsyBDCjHZMBAgjR9Er7WDFuUhAu7tj+XEXKgOwn2oAv3d+3OJpQh4w1qcj2Yt6f/9Sl0VmbYVE5QgsPsRCjOFy4HZP3IQaC5IiayxPOHr/tR92nqWC49PAbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(103116003)(66946007)(4326008)(66476007)(8676002)(41300700001)(83380400001)(2906002)(86362001)(38100700002)(8936002)(36756003)(66556008)(6486002)(478600001)(6636002)(316002)(5660300002)(26005)(186003)(2616005)(6512007)(1076003)(107886003)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lhhDvMvLOEwxtWeFu7GtFzpjB9Zt6g5P6LHcS9mNDLMP86jc61PqMkuTvFjQ?=
 =?us-ascii?Q?8NwT9DLqRL/tOtvcQTOk0qfeI7ofOrFzrPet5SaVezPGHKzmmZC08m34v0AI?=
 =?us-ascii?Q?GWPmxslqFcXxrIGkgiG8j3eTmx5U2U/MQg95xuyYVc59w82KEn2nEmbP6Q/l?=
 =?us-ascii?Q?RQtEhKDRAB35tt4TFuOkSf7ZrGbm9/PtSJwBTr+cHqmGnciy1vXzae4YpEXr?=
 =?us-ascii?Q?gE6e/TlXtJ7hFFZuc01tL3Xfa7+U5qYALvGpfF6z4U5sdSSXATAj/YkF9EZB?=
 =?us-ascii?Q?LPSFJMrEBAwjtXHu8A35MkqE4TRpLjl8WRP6NkebXvnD4sxdvCrUP87gWaW9?=
 =?us-ascii?Q?4sZ41OomYd6rMzqsw2AEjXmtnu3HNO15Pn/HxdEFI/VKwyusxyC9fq12yP5m?=
 =?us-ascii?Q?MG/Ofll9jfPVc2lVWBEubBpehEGo4GmJ//ccF1OaTZL8cl3D0zlkiX3sB3A4?=
 =?us-ascii?Q?fG4zLSicOBzWxLI9ns6YeGczJRCx8w+q3RDRYfNEWLCghoJzRyqZ8onfpgqC?=
 =?us-ascii?Q?AdWELC4tQ7AqnCe/nVsfI7eJYcsQuwHOK+KxC1WJvzrHGx1D0/synJ8FCjRc?=
 =?us-ascii?Q?FYDQU6mlEwYxG+WFx0YCAL+eR8tqSrcm6busZ9bnJEWMf6pXrSkL0uPMm+UE?=
 =?us-ascii?Q?muzNJgvRAWQbhc/gClGiwstP+dU/RsY9LZjrQ+VgChN++v0ZprrYkwlISS3v?=
 =?us-ascii?Q?vy9mz5wFKt/LIv1tnoEzsUhhKXmMsTRhnx9fElypmYx6YJqUClkep176t8cm?=
 =?us-ascii?Q?SV59O6d2v8Ol5lSOaCJsUbotRkJZaeFYeve74KB1pbnL9iDmkEe+jWST/4xj?=
 =?us-ascii?Q?H3IJfZ9WYpsT1Eisk0jJE5ufO9Fyr37ajnOmYFkUlTu7fJ+Bx0WebbigJGgF?=
 =?us-ascii?Q?jxhVns/oT40SB5W7gF2YD7u1C7aUbEgtvB7AsFAH8ZstaH0IyOyiLtdtL6iF?=
 =?us-ascii?Q?0ehcMvoMFCfNgSj7tKydwPZ77AD4QwtamRHxejYOYwbNHkLQ4mgdPuGGVuhj?=
 =?us-ascii?Q?pbQYPfv2qPdfLiuKtKI9T0Zf+fZ+QDFCkaMSqyIRG/ghAKg9Peq6OIw4Xkn3?=
 =?us-ascii?Q?+8jPlsj/VUsHpgAwQLYHgXv7GKw79ySWQYiyaIhNZFRmFi0j6srAOz1gYG/7?=
 =?us-ascii?Q?9Jvu5GeiP2iJSB1NKgeh/F5Sj2av2ZWOR+6gXlfWuhiRpk5DtyC4TeNJW7yM?=
 =?us-ascii?Q?0SL6o8kr5Ccd8o4jm+olxL7NBE0DccL0msBeZI3WTFVXElyxbCA/cGvcP18O?=
 =?us-ascii?Q?Z/NbCGlpgwBPpyqkLkYLlynxcHlF/Z1gg/vQuYVCeOeYAD40tXdCZSLlOR8H?=
 =?us-ascii?Q?T0neUU2FSnWgLpAuMWNCPVD5H+cxJcjo/tyueij+0H2HV72zrYxihPmgAIfH?=
 =?us-ascii?Q?AZvyy44dJBYKMO46lJP8TUt72DvcyH8Mub0Wxo+L1V3GGDTMOl7PuC4ZbILh?=
 =?us-ascii?Q?JcCK/Ie3JPJ3JkubQD8X23bRhOk/aYCwClqFZ4Gt62GAOqPiN8qfkXFheZ74?=
 =?us-ascii?Q?HSfWVaml2HeT5eqRp0BBvrjfiA54yhYrSQW5yZ1K6nRhkaWfm7yjzikh+Ss+?=
 =?us-ascii?Q?beg5tmXNLWZmYRgLqGImkoHluBFa7nb+ekh7CcivoP+f9g1BXEbuoeV3OzAT?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cIw/lHiKPwGxhmUrGtBMcF+Gc9qQJkF8T5OAQmrDuaataRP71GaQOGncZJEfjcBRZ02g1GlPdoNUnSwarTdl1zarY0iBszBhCBg9L/QVwn9TRrL5QZeaF7Lr79SUYElL78uZkjOa9aK2WtUODzqMLslvekH/2BlZ6bJwV1S+0f5MxqQ7TRcPXrVR4DmjBs9rYRT5JnijRCSU0y5ZyYolJ2IDC9MplhQ21CqmnCZ7RXA/YI3zn0sJgZ968SwSxAefaQa0khSC/yGcAqbVHR/Z6kev68m5IyUJ0rwhQSsI9Ab0fVGqmQUZs94CVTfDPcgQqafsZ9jPzMrBv1F1FG9tVd1ENShHp9SuNKSUh05O1ZSRYlQXJ4ahZAQSVXYkNN0ASUYKg8D5IkE5hQzb5OHAs9fAUrSXW+mbD3we+99mNQcJuO3QuiL6aluAMnr9H9mo92RiFKV3dOlurOLclIeCHOgto6FuvbD23G0LMtqsDU+x+r9YHVUM3syQ4B7VMKfzeqEy+Srt7KWCBY58MNPFjpn2saYjOXyFbBLBqHx0WnTZRFDJ03LdJAXRjp+as8SIbCuNrsP1gx5AjFWcss+F7W/hXkdelmwMlgOcPD8D2eKKK1QzXOVSFLRI4zruchWgcYoo5+xRMBTTkuAqX/mTrLP9mGMy0GqBP7RNAux/B3F0/OEeteea8Fw0e7gVZZiw1YNB0ySF1vI4qdCdcGVivHh9lnDxCJtF0acYJI2xL4maDwFs5OXmNjtCsyLqPxx2szA+tDoVcxTPXmEn+w3BnclTE2Msu3S9984pE9EDp7pi12rAqOdit0XYrcPTtElrjE5zUvTGbAGCwxqhLF7ylg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b369364e-8b16-4e4e-c03f-08db1efa9ffb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:56:37.8727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dafuwev4nLRD+/CEYyHYvFLdZmUdtk0I+tyI3GdeDYZgukeBno5RRZkQOYaGUi821U9yPnfm2yqZ2NC/A3TvQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_05,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070098
X-Proofpoint-GUID: AOKTQfPuepCASsw4s40TRaZ5XEcl3QH6
X-Proofpoint-ORIG-GUID: AOKTQfPuepCASsw4s40TRaZ5XEcl3QH6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCSI cmnd pointer arg would never be NULL, so drop the check. In
addition, its SCSI device pointer would never be NULL.

The only caller is scsi_send_eh_cmnd() -> scsi_abort_eh_cmnd() ->
scsi_try_to_abort_cmd() -> scsi_try_to_abort_cmd(), and in the origin of
that chain those pointers cannot be NULL.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 6d1c483a0a3b..4f971e8bfebc 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5362,13 +5362,13 @@ static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
 	bool ok;
 
 	++num_aborts;
-	if (SCpnt) {
-		ok = stop_queued_cmnd(SCpnt);
-		if (SCpnt->device && (SDEBUG_OPT_ALL_NOISE & sdebug_opts))
-			sdev_printk(KERN_INFO, SCpnt->device,
-				    "%s: command%s found\n", __func__,
-				    ok ? "" : " not");
-	}
+
+	ok = stop_queued_cmnd(SCpnt);
+	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
+		sdev_printk(KERN_INFO, SCpnt->device,
+			    "%s: command%s found\n", __func__,
+			    ok ? "" : " not");
+
 	return SUCCESS;
 }
 
-- 
2.35.3

