Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D216F8991
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjEETjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjEETjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:39:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1C24496
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:39:09 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhNkf031597;
        Fri, 5 May 2023 17:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PTafvL4X6xGu6T0ZfW1qKXJxgqqfRSq/Q/MjkpchD+M=;
 b=c2cuLEKUg8uBZL6TMj16K3BXpOp5nIMSRU9K8JTDNUbTrBdpttIM5Xe0ooqRkQISwueh
 SPB9yz1wxWmNB2T/XbAvsUOmdrNTllixAu+E6FEhba/VwcCNmu89ZdwDXoyYAfdvoxvO
 dylElGrFRHVRk7ZZlaNZHh/J1gIPT9vYL6x6xjRXIur4PlNrbg9YopVLgfNiN3VOHfpM
 lfDE/27n8o+aQrPsrW4rJj45MZfmuoKwZ+GPkwDIfViQ6gW2L+XFpxtzlWqJNBC/jH4P
 fXwpQ/5WUH+WyQg0X5iJlL7uqxXyuK42CGA/DY5XzkoH1aLDgM0OEawSunUW0DcJqqOh OA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d5nfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345HA61j009869;
        Fri, 5 May 2023 17:44:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spankhx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oz5IyQR4o1StFJ4zEhM+bOIiYI5/W4ztW0gBIGPftAdB25bAEVSAG0DvXHZWF/5tivdOp/GnMCWGDrBxKmFxO845znZdIs0Pk8jHlstd9iu8movWVEbyDUktcob+GQeGs5XFimUJtSU4L1zCRQkbQiqcAHmZpckQFb0rGxPIfhEFpqZF+UDsRkgf0lbiTLcBL+klKsfNe8Zybm/GPE/9kUmrMJ+mCmN0LMdEVtN1PnhnlN6XEq8iGc+fFjWGIcOiLY8dOuN0xrI0lGzCxxiT6uztkO1L5XED6Z07WqnSK7CF/ZaaymnieC6MbejqqOtX2YgnH3m5R5oXFD0+Bhoukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTafvL4X6xGu6T0ZfW1qKXJxgqqfRSq/Q/MjkpchD+M=;
 b=UVmn43+XGYcPqFO2Uxab7uXn9+lwcqbkdEQZoPsigH4VSwxsOucqdYQh5Lf6f75TY257zr1hYQ9CNucthblRkVr/ZWov6kKqBOEHRwhZG17iB2kwO4WMR/Upg1GqdW3D/aKi9VzyaBNPZnSWrVNg6gHREdBXJf7rV8Odo3LG9fOIGGOT9eHLzuc1pl0UBC3+zWPbdNlOxsGv4tgwa+GrOOT/twLdSu799z6Z5YDzHB/9wqC9lfIyiY8+inh/slT6sp63/n1EJF7xAucYMCEbJbm1gaED60S5qpJS9vgD7nWYQHh1NvQyS3N2no8Bi2DPOuugN4FDodcRNyVqmn8wzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTafvL4X6xGu6T0ZfW1qKXJxgqqfRSq/Q/MjkpchD+M=;
 b=aUWMEpRhHPBnm94w3GAu5OoZwHhwzHNr9iAGnuYpUEGzD1fJ9BeioSbWPBWI9YuPZXq149mtueBUjCpjduxn+cB9w46SA0sJtIAMIKhSmEPOWmoffuW2AaeaT/iY/Y+IFZBx0T9Ua0VdNNoGDGijsHnzIGm8FVEF8uYxTySgfRs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:50 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 29/36] maple_tree: Relocate mas_rewalk() and mas_rewalk_if_dead()
Date:   Fri,  5 May 2023 13:41:57 -0400
Message-Id: <20230505174204.2665599-30-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0464.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: d16eb292-4577-459b-48eb-08db4d906ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpOhe0XANZRDcY8pgNvWkB+Aj+R8IlyQd+tmkDsjdQkrRS+dBeMdgsnV5C/eEvM3x29C5Pg7iSdpcZ4Qv4IMKclwnTwtg/nh0jbTJ4MDUItmfL2PhlDT+8r6VVxV1I6xP29oUa0vzVKB/xrOb12pxf/Kq+1NqPgzewP/vgZl65J4cNw8cpeiE1ZPfNZbNjf6dlaD/8MThbIz+BMJm31K1a7yLJkR1BsvXx7fcmVqe4ZIggQlDVq/Q1Wajj750+7mP7PYlcg68PcwQ5YnJteO2Z7Zd9u4u6nPGvxnTsflliyjAsYhQH0t0/PWfiLmDY29v8YS2ys6rERWeFw2KwH4HVfEwMcx95sbToqNHiQNVhmbs06kIr9ArApN/J52Zr5PtUWVNchUpA522qnB0o3DNA5nKrQ/psu71WOcx9lZKs88xDUC3BJpYeONiJ3JQRFp8d55ZZc0syRreAtUPalVhYyO8R+cD70CUNhG5btXKyHRausSmvB/Z+Hby1E9MS1Dt536GYO9YBJZhDpF/hdbmzK7+7sWQXw2oD63WIX1PcGGs304aIjBesEvHOkWNrtC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(316002)(478600001)(6486002)(107886003)(2906002)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F51w7Ox4aS8VmXwu46vP1/cbaWXIyW3Xc3hTU2n352THbGvJaSUNFtHjpqaH?=
 =?us-ascii?Q?ZWLw9N4o0LlEReFP2DLMN5xpPOy1bn+cVXee4NgZvav4xAWCXaPWkKru/hV4?=
 =?us-ascii?Q?+Z6ZPpSHps0HiwpWwL5zcfXl2xJcyEANmR/xfBks0IP5PxAaoOI2+jtNyBLf?=
 =?us-ascii?Q?c/TvTQS1FvZ0xBoFHH2VWjbX0rV6vE5j4S57lCtRtA4ytb6HTMv9lG6NCd1E?=
 =?us-ascii?Q?91PZ2owiw4HGYk2UYp63V/Zo79gJF8WFSj2WvvR/UsN7uSnllODjhnzJH4mK?=
 =?us-ascii?Q?KFYmmHnLv+KYPny7hT7m9SZt91fBff5tZzKPvDT82TBG7CpUvvC7keOrvBE4?=
 =?us-ascii?Q?Y2dJzZYgoXyeNCr/6X1SbJSP92aT7vlCI75Z3+qlvhi1bsoawom+F/Yy2FmL?=
 =?us-ascii?Q?cZKb0z2+Ce9uV7ILyjvEpEMsSCDnyg3LU+m+MlDoN2PxquYIAmhEda/ekf28?=
 =?us-ascii?Q?Zg9spx9ldUemkJ/WRySVJdPwrbhM0rLhOMeexJ1fClU11yMML6BtgI6qsxdI?=
 =?us-ascii?Q?hEkQ7eiZklxWOf/0zfjFkn6wKHxOqfHqhpDiyHeM4paIcCipUCbElkXDKxX4?=
 =?us-ascii?Q?rgiIDJlkIDucp3VJKeohN9UNHUU2d2O8//Zb6569PrfZVZeiAw/LGkXv+wpK?=
 =?us-ascii?Q?+zxSjxdpzLOQqGqtOdZ+EeZ1Jhrsl3SnMLES8nrOQAHD83Tbf4kpOGqCzK5o?=
 =?us-ascii?Q?vukylGlmw/ZW7XFLMnmbVwF5o/TnSRmqOnJfUNjM0/UaBu9T9aYPHoZLDLZA?=
 =?us-ascii?Q?qZwLx6iaeGILVpy0rteF0fMIW1ST8h/9ODpM4F4ZsofGkD3LyDcNpgcUK+ky?=
 =?us-ascii?Q?08yxM9XxKLDVi58Tap2eegTIAi6J3ib0CPfr3GZUOkszoJap2p5rhCgmA32+?=
 =?us-ascii?Q?MFPbiEuSUpMDBPfyD8PKWPApf2AIHzWK2vk3vYtNvFUBj+CQ58Al9GHzRTj7?=
 =?us-ascii?Q?0WLehjBoSifhP3JQCGyFIBEp2NfmzSESBqdfjAJMd6gNpb+y2yz+33k4nz9M?=
 =?us-ascii?Q?GyDZueyjhJYeHpvM6pO1n4IhbnrSnLlLXooot+b39i4JvCymNG2TbftMLaYG?=
 =?us-ascii?Q?kYMLG5nyqbrfgRa+/nJvInCQnnmj9nvsiZlnust0iM76hecQO6ASmfYu6v6P?=
 =?us-ascii?Q?HxAoD/awT6dIzAhG5oHnRppRzlxtNiSWPxiZ4y74I2FquyvNJdSGJ3cvtfsR?=
 =?us-ascii?Q?uIkaxLCK9VlUXHFmg07hhR/MudlsnOO4QP5h81DQsKbcvs2GxkZMI3pMrLbS?=
 =?us-ascii?Q?tDSQJf3eiNwUOFYiILk19k9xUWnexTmQtWZ8Fk9zXvp4wwiSiN+KNxFXyRuS?=
 =?us-ascii?Q?iMJaaWVavYOSe8rYstDlovL8UdWyDffkz5/kleWFGb86uRY0Nwe0dQJwD+v+?=
 =?us-ascii?Q?gEzL/7hYww2oPUNCqYum1EfqHPuDpKKnD/JhKiz4Bo/AVfZoYWiQLC4yNcHa?=
 =?us-ascii?Q?imOPMytIEnRrIoaH+lr8gc/i9n8HMaFjG/L69X4eecUVkshIfMKxColIyHuL?=
 =?us-ascii?Q?Zl7sYI3WL+S8cph/xMKp1uHx0bfemr1pp62SNcVSl/THVqyfH9O+Qc43Fo0I?=
 =?us-ascii?Q?g3JFhqIdYxYxcvy41QzvRBTGOB9hPM8VHaRYoQGCQg+lnaMcR1j6i1Y2JkpA?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fj7sNh8mQtUWMjQ1TmOVabSzr+oyfTLNBiup4bOyvgwlLpT5hWQDK4qmkRuju/NDkXdJK3D96/slDLznmsE5Ha+V0iLvJP2Tnz3dsyFHylTGQJggRqaHWyPfxeM/o7NRPL064IzjRnRuWOzgX3ZAg5C5O8DWyZFHOZsHaPqm0O4Ss5cXYfmd6+X20LLb3R3OJzB4t/yVVieGB6QSEuCq8IxTqdhpOEhGzJgfor8rn+JGimoO/guCadFlN6oJBsTP5vtJ577TD53HANmfPwb8F6Zsx8fhsboDecnkb1Q/9sOQlNC61/gr7cCvY0YOksPFDbzYqcGdM/OY/mYZfLRdbSKHzngDTlwDb+d9bJ84fZT0fqGSZo+IfufftFfoo/yunwSu9OGAbpZ8/1gkHE0TrCph4g+SzvakvwgxWQhoQArfEqsOshCGS/Q5coZUVUd57vKjkXLVoq0wz+n2T0GCkKt5ttO+IEt3K04wbNzn/cSaNygu6aX9SzXK9OfaJDpqA8gv1FThOmVtZlXNio8Sh2IrMQFeSOmZbGsQzIugqPGyq9q6JUuUXSFxep7gSrTVaL7zFns7fw5AeFPeFJMEykAQEHSs27KpRC3M3ZuiDoC7/0/SOSxAx76NcmspQKX9yLr9IkojIDhl20uCCGFXg4183Io92hnuDOpLmDFdUHmX8/YghyXwlR1ypAboP6u7M3f9raflpTjxVi/gKv6PIcay97GECAYDTRSRN7XcZBql5CYGxNQgR72ZIkiYNIGoqXTzPoFtLRRqBG06MFxHmhcQcgUIEGiLhuhOEEpOvJsSt1oh4cgzdSewTYbcHattGnGp4pavK5gvQN3/S3iwPMW3jm2vY5q25umjjXtORhlFQjYQePapDf2/l9A4wq1zjjtpQMhpdWPYCBowxha0Ag==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16eb292-4577-459b-48eb-08db4d906ccd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:50.0191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYnmyhw6QJRY+JOclBkelaQB3YpcgpSie8u3NuATYnM2GxtZy4tSdO5Zss/ll9GTtO+nx5xZhXCcuIzTLG2T7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: Y2EvNB6zQMbOz4BlHOh-QzHJ5m_eydTy
X-Proofpoint-ORIG-GUID: Y2EvNB6zQMbOz4BlHOh-QzHJ5m_eydTy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions need to move for future use.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2f43afeae94e4..b0f185a8154b4 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4497,6 +4497,25 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
 
 }
 
+static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
+{
+retry:
+	mas_set(mas, index);
+	mas_state_walk(mas);
+	if (mas_is_start(mas))
+		goto retry;
+}
+
+static inline bool mas_rewalk_if_dead(struct ma_state *mas,
+		struct maple_node *node, const unsigned long index)
+{
+	if (unlikely(ma_dead_node(node))) {
+		mas_rewalk(mas, index);
+		return true;
+	}
+	return false;
+}
+
 /*
  * mas_prev_node() - Find the prev non-null entry at the same level in the
  * tree.  The prev value will be mas->node[mas->offset] or MAS_NONE.
@@ -4676,25 +4695,6 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	return 0;
 }
 
-static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
-{
-retry:
-	mas_set(mas, index);
-	mas_state_walk(mas);
-	if (mas_is_start(mas))
-		goto retry;
-}
-
-static inline bool mas_rewalk_if_dead(struct ma_state *mas,
-		struct maple_node *node, const unsigned long index)
-{
-	if (unlikely(ma_dead_node(node))) {
-		mas_rewalk(mas, index);
-		return true;
-	}
-	return false;
-}
-
 /*
  * mas_next_slot() - Get the entry in the next slot
  *
-- 
2.39.2

