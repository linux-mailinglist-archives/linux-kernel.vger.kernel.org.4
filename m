Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C326320C2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiKULf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiKULe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:34:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E0F450B5;
        Mon, 21 Nov 2022 03:31:01 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALBNnSj030446;
        Mon, 21 Nov 2022 11:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=YnNGwAbKQw/sTERP4S2NFUXlbn3Q7NUm4p/vQJ4eFq8=;
 b=x+INcXMCkAuoWR+mvKX7FjtMqE4/A3MZ+vIaQUODHJ5HNidSrXbUKPno3g5pVw947tnC
 QDKvfHzkeIqAUSkynLNRAk1ioHz120RwJTRPkzF3a+agdIERSfgoDoES16NWzOYqOKO1
 /NYDvec8JGsIoHSyI8G7aTxumIta6bZl14yy1Q64P613jiv2yhyOwfJ+bLGtOYACEbCW
 vPBcyuxOwNbiB50+NMjvkfMiEDMOm4l0k++DlaO4OUSXcBlIEeq39TCvgUoLudqx4v45
 5zyAixkLLGctZyX3xmgt2uhZJWTT32wOLlgoYL4zH+OsliYrd2fuHF+FElQLLC+PTdyD fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxs57m6qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 11:30:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALABDKv011706;
        Mon, 21 Nov 2022 11:30:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk9bhfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 11:30:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxPHWCmtIQMmvvSWdLlri00M+t8U4nhF9dgDT945Doy/vM9TQOT9fK1hZKTDTjCpqU+OsPdqZxT4wh1YvEc7kqywqBWNXgaWGKYlsqJyFMs8P4L5v7DYpjuaWDF+v22OL+EIZNfT10e9qraBs7jzjaL78VIG9Woy+KNtMuY+985UcfNsuCVzlHyzcsrIFolPGMx3tyc3DfYE8x/T8YPXPST66OhWIPNDDJDLjKMkmTyvAUJSkYow/ISZuVLR6pgTqJMgsRU9EhVs4+v4yzIDTCRhp1zu/nDWqCWeEoszXyHROJli/zL1S7InKySDkce8Q1FmrAEz1AK8cVaukUaCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnNGwAbKQw/sTERP4S2NFUXlbn3Q7NUm4p/vQJ4eFq8=;
 b=agNqB90f7HLyYF7kJurjhHP/iJZd+0FlH1vNRmRVpUyerEYiv4T3R/I6+D/X45oOXXI5/f9XBxC0DOLaEtNRw1r8YEFs4fqpHekk0WzcFqsKPQhxBBPPO6hDeP+yVOQHgeMeAMzrBIbC+7tCNSZ02NSPk4avpoIXMADkuikv0gp0DxHbn8s/Yluh2Rk4ebfUKaTOQ6eKbWZOW+zEsTwBro7abL8t2GPu45CLe6ucTnaY4HFIVw8GIywS33HjtSzP8BS4wmCv9RCk3Xeop8DOxJnFV3qbhLulZ76ASRcZkl21TIye0iQYdiK2O4gMcOjN8jxl8XORrsKuh7+SPDmCXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnNGwAbKQw/sTERP4S2NFUXlbn3Q7NUm4p/vQJ4eFq8=;
 b=iETkZMPWJ4pJgkouLpfh+EMhEePvGZxQxkbtlCtWDx6c7tmh7732LSdo9p4g1vRZoOyPc3PuIlPrsBsbyJ8inQcaLfRYA0v+79aS0fcPZwxLbdYzOtU3lztT3BacF82P+opZEqJGqDpWXyPDFiDvTMC5I6JmTL87dGfK/6+YfmQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4252.namprd10.prod.outlook.com (2603:10b6:5:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 11:30:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d%9]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 11:30:54 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     acme@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        irogers@google.com, will@kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] MAINTAINERS: Update John Garry's email address for arm64 perf tooling
Date:   Mon, 21 Nov 2022 11:30:18 +0000
Message-Id: <20221121113018.1899426-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: edf20b26-77fe-491f-a1ab-08dacbb3da0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1Kv5u+ZxCOi6isbHmPLHWFEeco/WWshizEUQpWmuVZ4u+A/B+jGVNwBqYmiAnBPRbGvnQ1O8Ib0g9thHDNo8w+jZKeDZ+T3tb3J097labxF9+ULuqY8qwQ8yiWQNz5d1LGF9jUbhM7WFJW9ihRlM4JPPbuMjLtezLnqIh5QN/oK1gAEuB4j/FkCnoIE/KolOdYrrPefV+8MgAryehdXGaBo7ODzwdJQCL0DrPHO5oXmOXimLXqtCucwjwsWBpFo8H4KSqVEl3WpR7vdkuMZR1FF3Wt50/jd94bcmTMv3zO5//EBoQk7/HCQJA4M+0TRAABk/13KxmUfwX1Hrxb4oFjkxrR8Vz/tZg80RxKMRMEmiIbW2KAbkd61sCv1XYzZ7LDMtIY3o80X5qPcA6m2YqSvfpKAhYP1i4QeIWVOXDaZq3CeMVfuKcbsh2Ug6LDKsTV5LOQAA0kMm7ff2BQVdrtLR8rXAd1w8KPW08oNoqlCxgFr4OlfhBMaGMG/S5uaCtpTbv9outeU9lnM9tZ2d/RAvq64v7Cc5vFDhGcXaOskRz/nCX7ZZvsczmUPSO2iVTaCpj2RK7HqFEXYBNMVzQsYWv+8Lfta/Xiy1pW0OY09njHIw92jb7Rf5xuzPMk8S0CddSG92PMJpuXuJM9k2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199015)(83380400001)(6486002)(36756003)(8936002)(103116003)(5660300002)(2616005)(86362001)(478600001)(38100700002)(6512007)(26005)(41300700001)(15650500001)(4744005)(186003)(1076003)(2906002)(6506007)(8676002)(6916009)(66476007)(4326008)(66556008)(66946007)(6666004)(316002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XMjKEZfNBsFurTTQ/HBzcsC3ytGc5O5nvOz/A8kJnrv2D3Rn2Fdq3PE3tArG?=
 =?us-ascii?Q?sj26Zml/U/JuWcIvrjqdTYKIiYAuqk2IC5ZWZp4bXebRVsjG29v1jm94Z2UM?=
 =?us-ascii?Q?Kk00VvDF6iSo7xeTpR8uuKAJvz5khnmj30vNzQ95Po/iNJOmCaEv2t4UCUzn?=
 =?us-ascii?Q?ZZuWEzffFvZBqSeLeJ8CzqKCEkM7fsdz5dcUEMdbrzpz93Fg27bRP+FbdgGn?=
 =?us-ascii?Q?tNrWllkL2yH30XCqHI9F5WQh16g3K8L2uT4EQaDox3K2L0gUNVhWp8PGxYsx?=
 =?us-ascii?Q?tRMLJN0oRTbcp5jZUPHlEGB6nuBXyvwSX55VfcJa2yofl5in0nHbhGCm8sU9?=
 =?us-ascii?Q?UYNFjYB6Co40FRHSb5M3OfQJhY9t8grRnjPFlsCsAdzv7ecf1ugOOcA/zEui?=
 =?us-ascii?Q?ohm92G3PdAqKeXJ4RW0jfTuLk3nBdvF8o9FCE9+Dlh9dwU73BS2KdeHW/S/q?=
 =?us-ascii?Q?WhCXqRKJCFFtncChZINXw7POe4ZSMYask/ubWt1kI4iaHO625l7+9pwLcbab?=
 =?us-ascii?Q?oF72m2ztboiPnrmzFPMlkhyYDU7Guot24ij6OGhlBovglFDZV54yVFvQussL?=
 =?us-ascii?Q?x+5vJXB6gm4wYl3sxfIkEdVNYMAXBndZ3mRxFcKi5C+a2KVBVmjc/5H+s/SM?=
 =?us-ascii?Q?Uo6XNf2aWWpPzcAlBpJEaGDJyXXSnHxGzmBegjxuLlFSC8LBx9jKo1KsZUiX?=
 =?us-ascii?Q?bF1POJXZSE3NiYRh6jFpdXh0x69bvTlFbv1KFxSSJJJhPr5kjH+CQZ9Gvlme?=
 =?us-ascii?Q?qbnhP6OfgHy/r1hwcDqNKrC4jRudqq/6RymA2FHCYRflCBJq/PfT3gfOpvIq?=
 =?us-ascii?Q?BJaYHkBirudKvRa9TX4dqLpGEWzkbmummELpPlufYjKgU14QN/TQIHSvwZHn?=
 =?us-ascii?Q?/bJxWfFKJMKAo3BDgm1ZNPNelj1y5IyIyvzg+mgrySWz86dApaWFKARCqx9f?=
 =?us-ascii?Q?ANqvQDJcBoZgM2wIOqbRTAqCCmAFpMTV77fGDSz5la+8jgiEkbQLK+ZqraCZ?=
 =?us-ascii?Q?HgDFwVyg//hzt+w1RZu6RreLDFDYTBv/bHlF+vt4z0+E9/GWSm4A9JqvE05p?=
 =?us-ascii?Q?OlXb0qEDcNkXbRmol5JUOhb2yeolor5M9ePJ5Wrufm0/mfc46bZUsa/AIoWI?=
 =?us-ascii?Q?eSgEBatiiLbFycg3JmC8OQJ9PDdgepfpjiJr+2Mj54QFEOINDlNd19V5aoGo?=
 =?us-ascii?Q?dCPWT5g/shO+jEr5umiRR28PkTc3oLeo5SIAgAyhyHFcXdIm/13oaUbpsH3G?=
 =?us-ascii?Q?SMyb9r8WCWETFND7Hrm7u4+y0R+glNuvy/MXYBfvSpkR7u2s+DGo7XrwZSc7?=
 =?us-ascii?Q?UFkEMI2+7HwD0adudib0OnD9vAjb/U1ju2WBMsE9OOqohBTq1T86W9+cUMB5?=
 =?us-ascii?Q?VeYiolBfiY9pOVt5+akUoa4zCyjAenm+YjcvLTGumeks/ZHx89Ci4p0poX5O?=
 =?us-ascii?Q?yBHiMDKD4XRc7yjes1t+zl9aZGWxMOo7UXmy3rJWQwknMR2uPNmcIlvmW/zs?=
 =?us-ascii?Q?QnkIlqyhEDiGqRRs7fwx8whlluCpuDUTYfkBf48qDAlvHNJXly/mjnVAWaT+?=
 =?us-ascii?Q?2XggbPIZXfogFaSLoN+6h2h41AbNfj7ZJZlhKkYL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XMBEXdPBEkH4hEIBiWz9W5xce8G+l60zb0zIC9KBi6CGtiPGtITUIEgRdAjhPm5jYvvb1I95GHVZZUE+IGkD+oNsQV26tG4jVSgLNISclZJZ55r+rhIHNUD5RSrbde2yruNK1jn4aVWnaIwEEUAjas2cdpVEBhehimzKorVjqgax1p8fhvYCMcJ8yvVCmX8PqtUbiyskBlG41YJx0AjGz1hw3NmsRcGw1grNBPhRWXVcelUm4GBmC950meLjnZqkD0i97Lc9iSKxYjkdD4FjS4o3GQjH10ZcitmOa6GkC/9T4+zp6szAGjnj554qCgGTsbl0Dx8MdSCvGYGVBKLzFYzw37488fUcs1m/hFAxbDxKoR6mR49MfV0n1KJ+VerKgFOhjIPOH8gZkcXFa3BQIXoy4fLJeW3cNm9rNQOrKnceL+LV2e3FrE62eqBA12QYfXVLtIxH4oj2CsM4+1VZYTg8yPv45/kg1wKufa0laUGLlqpFLBpHgpiFTFxY1Q7/vCfRx5qJdXqcpdkaI4nO1mcxI7hyRNKWlfsU/H3uJyYisWd7KDvbH+D6U3NUNLST1yQaL0vf6VEHVUw58YYDEYqiUg6YzRQcZWI+m/4ZJezE0Dou8bDvl/AS0/fWUa449wVYD8evdqFtGyrzj9ssRdGrlpnSiC4cCYVolRkqXK99TcKwWDGUtLNy54bY7G21POJmWiZ4LWdGlq7PVrsJM6PGedD7ecgSSNgvDQGKkMeycbP5kVIqtTCkDG9JwPddnw0qCuHWWK+ZU39rhsp5+oq0Fi2dbAFRpSciNmb8j9WdsAUdA1GBv3rvL8SohOMuVqvRcsiG2yUTSdivcBPTx0+l0uW4lAwpMF7csM4TESRx9/csr1bijtHbheSt+gdq05oSjSxVVchDDOn+Yuilsg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf20b26-77fe-491f-a1ab-08dacbb3da0a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 11:30:54.4685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cm6UQhJaznM4/RyXwHny7aHhCt77MbRsO3Pn3sbVoJHdQ0x5AdChBJq0Am/VIE+yVutarl3YGk1/nRt7FwjxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_12,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=863 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210089
X-Proofpoint-ORIG-GUID: z4OifEBNzF_Akfe8kakyc9E2JwldEfOI
X-Proofpoint-GUID: z4OifEBNzF_Akfe8kakyc9E2JwldEfOI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my address.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 379945f82a64..2ec6a2709225 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16191,7 +16191,7 @@ F:	tools/lib/perf/
 F:	tools/perf/
 
 PERFORMANCE EVENTS TOOLING ARM64
-R:	John Garry <john.garry@huawei.com>
+R:	John Garry <john.g.garry@oracle.com>
 R:	Will Deacon <will@kernel.org>
 R:	James Clark <james.clark@arm.com>
 R:	Mike Leach <mike.leach@linaro.org>
-- 
2.35.3

