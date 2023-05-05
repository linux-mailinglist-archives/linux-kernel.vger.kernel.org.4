Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A196F8884
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjEESQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjEESQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:16:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA41A635
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:16:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhIUc002987;
        Fri, 5 May 2023 17:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0Ka6Dn5m4CcrZYyEBIVismStZ9lyI0eLhcunT5aSalE=;
 b=1Y5MJ2jC7fhmsQFA6xkDTmOE5abZv36zg8fdOyol2Auvu+fUjQcAENULsF0cvwb1jl5M
 LrkcF/HOKztkvbd46JLOdFdSUPxsfGZKzawMgbIdRtjC3v8Qjh69uINLnMPXBDSphYL8
 GoHKcs7LJ+qFVQZ6wGiOeqJ3Q4GOFIif3DwQcxbD177KQHqZDhVSCyPCZ6uZe2RiqrJ6
 WI8mqELPw3E7Tjlru+hdMti3iz+UzcLxIH2uFzbVg0Qz4sROc6G0+0kQfg/FT/hG5/h4
 ZUHewQeFAJ6QRpQhR2Dr7A37KalTJNhksSMJcQ89HSJvnyYm5fA6ytyn0pmlqV8KeMAx 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qburgdkdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345HQSiU026716;
        Fri, 5 May 2023 17:44:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spgf06s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixQkarnanwo4Dv910eUdFhHE89QT0PzAQTVNfMzyUSD77Q7XPqLvocQxaEx6kt+XyT7Xjzrh+foVaB6xNSOcyGXo62ZL3Lx0oYDYRvH21ldDTJn7aqMcAV5+EeQ4kgR9NlONX7epijXCHpJwqzFs/65AINqwha9zhDb3Y0CU0GJ2ko8RmLq1Ogpg2WsxTpgcg0LmNje9P1JYEH57l32tLS50/vzSdcNbPjRfai068IEaLaEfCfCr9mPRVSdtHbUNC2CbOYz2tXDKCrds/b88v+vd7nrekz7Ba/kgmapCEEpZGDVEJXJE66x2BGZM+qw4OT6C/4UxgXd1DyXD7qEDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ka6Dn5m4CcrZYyEBIVismStZ9lyI0eLhcunT5aSalE=;
 b=VFbrIFum2wCEawCINkCOiaWR9MjTpBl2Bc+I7WTu3O2uhnHAdYAPEELx/gIDmIzVgs50ekOKBYzYT4dStHnmDalTZNn46glqHR0kDwg4epCYfXvSRemOL0D5z/yotDkS4J9IVLMR3aqI+wDYORW/2Th8tWclmw0Fzrj9wpx4DXMCDlnmiUiLRODfshAdN6U0P842Ru7Kv+3ZicagxyNbrgDWHoHrvAf//sizWErS7h0E4G0gRn+w0CAwv86flogbKFJTKaItzk0sK5fip8iW0pyCTofpI4544V3zU9m330MnrN108X35Yna7FTByIH9lVXoEqnEJ36wyJ+DYU+cgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ka6Dn5m4CcrZYyEBIVismStZ9lyI0eLhcunT5aSalE=;
 b=j71mbhqkBH9i9x7fPI/WSM31KJ+x0XVOPGsD5V0drnCBe+UJsacKABHMdVvPmQk0yn6dMxdwf/QMLNWKXx4LID0DPSFwDaC4CTxWYegupi+lKbKtHmf2fgCI+8BeZqQXpTWe6GCZKhVADfd1XwO0DVludOkD0rXqdUmtI3U6CDY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:43 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 26/36] maple_tree: Fix testing mas_empty_area()
Date:   Fri,  5 May 2023 13:41:54 -0400
Message-Id: <20230505174204.2665599-27-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b86e0c4-8a91-4240-37bd-08db4d9068fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwSJIVWieIOgG5+ZY3ET7xyE/I280Xe0ivhzRpDDJGrrMYTyjrSxUo8SBOoQQwsNpAivCIIWUwzgYsuIzREAuRE/hBwsTVqX+RXm9hfflE0vyLfhtrgWRp+9StLx8hGyf8YMdZwyAeB7CG6N5IwrFSmeYBzpcfg4hNKUPnH7oB6sKMR+bNpZpf8CVeFNMjTxFf9MjR68ICkoAdM1pwqgEHzp8SvtNw/qJRQjJwaxLPEhA+03vnCJl5fI5qRIAo6bHNrpY+2WgmJ2/o2lj9gT9VlbQVdCRv/73Mnt5H51oRDjpxNQj+Ydt7hl8T+FonOMesCv2R0jqmAWrlE6EeRd0M0XXcOYj8OeculfbGiFF8GZlpkMhoOQLby3xqu7IK3TUWhC4tJPEps3rchqqJ0ALTzTDvpTlzoV8OhDYDa1dUbgEcvG6XGo5QpkaHWUGybU7yHbu4Q6yYlT2UKC6DvmI9kUgrEWjL1Swy3W7J9SnH8/oFM/tvOoL4zyEyQRF70sa5F+mBdkW+RxKZ/Zww6QPNET/nH+uzGMjppyizqRgDtMM88bNODxLsB5Hz25BHYb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(316002)(478600001)(6666004)(6486002)(107886003)(2906002)(4744005)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AdxUxb/TF+gLMjBj2CjlJUoMEWlTASwgQJ9icGZnlOQHEwiGDEs136+dh1cH?=
 =?us-ascii?Q?eZbHYc3fV6bzWoLhVoIKUtsRXp5GSB2ZSD8INjyqbjFF4eLVgmsWUrC+05RV?=
 =?us-ascii?Q?2YAI4KBaoGhMgBnX/nOR05ctW+2iRcj/k/cilDVJIbwnfiS5UV59oibGZMeH?=
 =?us-ascii?Q?JI5MW3MwZFMxmK22IAPZmCJ4H0ap2pgXDAmIMSsb3r2iNJmBktIc9veH5pq6?=
 =?us-ascii?Q?VIk/HhwBn8uhUht9VXv+Ns88Y4ngRnHsanRiBZFoUDqhkclbMSfypEdHpDMX?=
 =?us-ascii?Q?A83uaBrbYeUfRr33mYyt35DPO2U2mCxMSlq9kJJBsWBU7ta35fh8+UePTvsH?=
 =?us-ascii?Q?4bF0Qhppbyzqu27OV1s/6vIYom7w300+Nn5JJvTgGueAs1yVSw+0P/LP6+kV?=
 =?us-ascii?Q?cM9uvPG65QC1GpFvuFkTJ0bGzofdE6iTkdVrPxP3QStXixewov9Fw/SAxZP3?=
 =?us-ascii?Q?p35lKNatCN3GRJIL91ZT9VVzw5PlJzP5ZJrRErEJA25VGzvVi+ZYzomuYyCG?=
 =?us-ascii?Q?fos+wVYts/2MeLYsj3OBLgDdVhBvLcDQTfF/jxaezGf2MW/2AwUArrnFzDvj?=
 =?us-ascii?Q?q774mv3PFb8cNMAiBkuf6UEvza7XnsFJValbPfzSM9+aeSbLPMvzFcRn1tk3?=
 =?us-ascii?Q?THMNQ2H/+QJIZ1XY5wDoykalhLWybGVmLs3qq+/IxM6Wvoy+wB6aFyvykXSU?=
 =?us-ascii?Q?K3XMryrTeFHv9dE3Oi6sd/Z52co3R0ndtJGIC6NsnypJ1uFJOplsrXl749fQ?=
 =?us-ascii?Q?rtIQxBWjkeseaNJCFjsvVKa0dBkPRNkmwyVCr02jMi1oHa3oKmJCPkstheBr?=
 =?us-ascii?Q?vKO7c566yVMjaeciTqzioD1+kdVCZS9DNi6E4RWqKLg1FhtIX4ffO50lGZhb?=
 =?us-ascii?Q?dpUshX69MiJXM9krj4sxogynYU03UX7xTtbgK1QR5w34wv3Lk8ydruxz5WVL?=
 =?us-ascii?Q?rZQ135bJbD/Y1sB2sMYVt3VEKlnwWQAEBZgi0ttC+a71jxptepSoGuYmex5C?=
 =?us-ascii?Q?0Qwr09z7Y2EsaiUQdwK0GF8lxl+f3J+UhdjG33x+RB05n20QIdBDVI15UzmL?=
 =?us-ascii?Q?0TxTvOcZPL7Zv3Kg5YQZrWGbET14hAn9f9km2/DIKOczvATLALQMqjddl959?=
 =?us-ascii?Q?yU06kIVY+Irw1zOINfN4rSZSifiJNYfbZcRxRipeYnzQMXssbXTXSZMQxhNh?=
 =?us-ascii?Q?2tTpbfGjR8SuWFjPKr8bVkug/zZ/ldUlrDktChDCejubfblafzGjTZ3jRrF2?=
 =?us-ascii?Q?2lvt01016LUkg8CkUyqDuXbPv088IdIImdy5yNeRrVjAVHhjiq6PdDEyzbmX?=
 =?us-ascii?Q?eR9Fxs7d85dGVtE97uPDFGPHyt6+XE5vQ/1nEVdc+ucSLIhfTBguD3hMlfam?=
 =?us-ascii?Q?D6wO91T4OtPB4ssC2ZIxcHiyxQdu5SBUU4CMHFHGsB4d1TcCEOZIGIX/OZOQ?=
 =?us-ascii?Q?/u8yGCKC2pbQfYFc+HFGhUerVOMBqqFIfCwhPV6e2PC1E/JIKMqbFJubRGdR?=
 =?us-ascii?Q?kwLSMDUAptgrfjysrGhTKu6KjHkVqrkSYRaUXTpyxbbgWnNS49ZXxE98U9B5?=
 =?us-ascii?Q?BaVt8saxr3WmU83JTzjFwf03w3gy9hmj1+nqFmlvWiK7P2Nbwt7LWf4f+P7D?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EtAWkKwGnwgzPbalKoMFQRu6BdKTSLck0bRbCyJqgzjzIWS/2AcND7VbvYFontjlNDF67LW1ztO9Ue+AL618me2XR2CBN3FxNUqZQADMsVtc/6Su1SJz8UqqSJ+rFXPioETZcH/D15FFQ0YoGavp+0IGjtljntGq05tpU/qTISv8NdEWOIu7MHIyfA/He949OJEy3JsBYUO4f2Rx4Y/cvJVvhXacLUBqh/EjbqupTlKbcm1Ba0KgpmzWlzt1y9JgT0E6q6eFe+57CIPCuomnXyxbOAexbldYIjNCUVQfjUzdCcDKCyz34I7P+RYOzLbC9Y28iNty26zWF7lOtugl7yKu2TxbU6xrCzqdfxsP51pTivC59lWP82RGt0r/O/Azdrso/EleqgW+57eIPrPJeaIBH3SdOXID6VFGzabAIzIADfDoF2wXhvHcT9JYxS7j48UZMiezPDUJaT/sVkWv9YGYA1kWvZSu5cfsewtM5S7gGbWpAwiyAIUhbr4WXBuIYHJ5mDZYVoZNB6aXUWnGtAZhjSirQ4632YPa9qun2CEhp+0ejtjOQw1aglCuvb6woAQuJn6uq5m+qC/WURFzdmpw2qIzh7dkVy0X0StXQYC+70wq+YREDGkcTfUJtaZYZ6Sj32vdSZYz/8QYwI6yTX49Vld+XTgLScvO2/tta3siHSKHILj0vAHsKDfFePD6ipvU3lRpYE4K7/hjoG5UzVvH83TXKYonsq3NnuOlT1QZBc3+xfyZ0Rfrp+N0IgQ3ezj60VgaROvsZJePk4SdGeCJagnZyOBTX1SBR9JtxUaQ2CA+OHpYVMl5xjG14Q5nHMsNr5C1GYmSs5mh4kuNXHeBcQkZGjQgtrVr1rKS2eZ61bBTRmXZ8CAZuCH9jiaqqUimT7zfMXHN6ujUUcn+qw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b86e0c4-8a91-4240-37bd-08db4d9068fe
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:43.6360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHphY56w4ebcZ7oBKb9DqkhNHBw6gcT/of39C0HCj7dpTEkoH5BznPoDhdS65sVNFnwLWeb8EuIMoIpQm5ujuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: 9HqCwzYjEgnuCZJY1gbFlvgOMzNsLOzZ
X-Proofpoint-ORIG-GUID: 9HqCwzYjEgnuCZJY1gbFlvgOMzNsLOzZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Empty area will return -EINVAL if the search window is smaller than the
requested size.  Fix the test case to check for this error code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index fbf7b6f227f34..48bc4ad984c86 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -2696,7 +2696,7 @@ static noinline void __init check_empty_area_window(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_empty_area(&mas, 5, 100, 6) != -EBUSY);
 
 	mas_reset(&mas);
-	MT_BUG_ON(mt, mas_empty_area(&mas, 0, 8, 10) != -EBUSY);
+	MT_BUG_ON(mt, mas_empty_area(&mas, 0, 8, 10) != -EINVAL);
 
 	mas_reset(&mas);
 	mas_empty_area(&mas, 100, 165, 3);
-- 
2.39.2

