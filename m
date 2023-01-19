Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD8C67443F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjASVXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjASVV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:21:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30D049564
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:34 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKwkrb010055;
        Thu, 19 Jan 2023 21:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=GYb+knLTbexJ/uzVeiIADOAI5vrG5GzfsA+zdeB1WS4=;
 b=Js7G3498bNb4lQAbgEqSwauB/bU9fyDV1m7R0zt2RcZuYEG4hgwyaC7TYyM+6D7Sh+LG
 oMZETbkP644t9grbj2fRCdnN2JNckzwmy20zcwFV12j8khdKOtZ+ppKXBBxWD4r7BhH+
 7BiQr6Wrfi9kI1NErZJRgPoAzwTyK/wiDFWD6n4Rpoq+ucBdfRy71ePGZoTulg+o4zXA
 1T7VazkfpndYMRSWidfIQuj0JaXGN9XPtY0JxkegnoNy/oU5c+bzGcxULF7tW5jQvanM
 ulXbEvLpLe7RiIVxQShCllu0Lc1PfhRs9UZRH7ZPB0R7JpCJhiwx8FpvxYlt647XcgpU jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medkdva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JLDiNF018698;
        Thu, 19 Jan 2023 21:15:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quh8tg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4Oi9dJgGLosP9so4eQf76H5sfgrzsUwFb+IvDYovyiIHuTpJtndUxtMk72i/zVSeHSm9nmHl2K4T3Vhk3hQJd5YsUVdeX+4FDuEy9cn5G/5lAW4DSlalxDy+K8AJf79AKm4ABvIaj2f5z5wHQi9Qx151xMgV5R5Vo8Mp1d/YZtNOlYcmZUWAE2KmGM5dviBgNmrd3RReDabojEFMksC3IaaYar1G6aQ/vL0zcYHRsllnRd9S/TbxDja64DgZ9tBzRFnF7y3L8L9xVIlpChZA7cluPzIxnl5DimH97wPYgqNFnrZYeAgyH1/jcbkRgWRh1k68iGfzewAk5bngLPRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYb+knLTbexJ/uzVeiIADOAI5vrG5GzfsA+zdeB1WS4=;
 b=AMVFumpRxu0q63xu2wbYD0PKcStjti0jPYBWSpu9C27Gb95YoVbQ/adTEbWduG6TyNRoXhIFlkOK7UDt+4FWpg1bNCPmHYPt9KAqOFPBHFJaE6qtRIEfSIeDDUovHHZAG2KfcfPYf2j+bjvudNbtAv+nktJ1MhJ3n1Oje9+w8B2vkQLEXZKJJnaisQQ2xTZIVK4FlKRSZkqFOCP/LP/rko69PgfAyybUwQ4winY47jI3p+2IxRmXSpzvlJgwpcSnzBjHG7tQGMTRPE0/xwJL0+VhW2zqZpOPOasjxCLw4xh4jPQ/ClmbHmj+7zKssnRqz0iSUI984a6zwmAKmlnAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYb+knLTbexJ/uzVeiIADOAI5vrG5GzfsA+zdeB1WS4=;
 b=hwJLMfjE92dZ4GpZJ3DuUS7XiDxQbrEn+REfwod//qMz80ioYxn0Q5QTFkobYdWA9SjNq+a2xqpIBs4VNYDkqKlGTfc3U6mD44HRdrabwrv7QEAhKulvj+fTTUlUS4caeNmdAzI0ZQLSE7TW9gT6+3fRqb4k68w2Pr2FKIVI+u4=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 21:15:11 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 19 Jan 2023
 21:15:11 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 5/9] mm/hugetlb: convert alloc_huge_page to alloc_hugetlb_folio
Date:   Thu, 19 Jan 2023 13:14:42 -0800
Message-Id: <20230119211446.54165-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::16) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|BY5PR10MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: d6151c72-6de9-4a0d-0236-08dafa623fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLOczRA67EZmUuymv1DJYdmMvE9woS4V37tJ4ZKWjSTqWVpFRF2EBBKvyeBtuKW0W38DQaFghDJgzuYUb8esPPbjRwWt07ZVF3y0GGjMOwlWox7Q89zo8IIyAeDyBVChK0/CJ16z4qA9H2q82n+/SBXbobc81P0KsP+qWx+P3Qri0UERt34K09f1vdsExWeE4VKKOXj7en+EFyFgeHHkUkFAgaB6l6T/zYKdN07pQ3xfq67Jrp6ZeRFhaLgG6bu4NiwzB09jfk/0kq42R2yzUQMWVgqEj7zt0mu3sQZXfC8wzk/6msECsntv80TZFhQKlkPFZsxh/J3tKWs6RyshfVmbkfpY/AqnywZ7ig45pizENo3Gs2Xp50zWefHEpGUPFapis6mMJc+sS8E0vXdi+/ktBrDycTw2qUDHzQU4ZGZWtX3oCIG72ESZovZHETDo7BVlzHg5lipUQ9+mohnA+bHs+dcoeQiqPM+lEIFxZlWLPDEBBKykiq8/Cz8KWnFz+tFVOQaEfmk5xKgaajRId7P14DQbTHoE3p6by4gX/Qw7saryIZGDMMrbCkdAyaPBpjdjVNSvedyBbtVNHdrSuR7P5g35Vg8zy4y1TxTSy+PRDf2Djn3fOnKJphH8l72U0b+Jl/yo6Y3W4oM6WJpHbxK5SI3KsZtdlhxuaRzO2gpFKd0uQfq9Un1vVWmyYW22
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(6506007)(5660300002)(86362001)(66946007)(66476007)(44832011)(30864003)(2906002)(8936002)(66556008)(38100700002)(316002)(107886003)(36756003)(6666004)(478600001)(4326008)(6486002)(41300700001)(8676002)(186003)(6512007)(83380400001)(1076003)(2616005)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xa9a/g9GiR8PjecpvF9/aMd04znLLmMWGRZQ3fLPJ7YIo2f9TTTCl5cG16Xq?=
 =?us-ascii?Q?xdiTdizl4rObWCZbj3Mit5CV9B1MQL2z4Tc0s4+e0G7+6bn256AzmWsWL3la?=
 =?us-ascii?Q?y76CALegqu966pGkorS00lzcA5DCRRzq8RoFfWYLCZIRSKoPQW9lUUlR+KXU?=
 =?us-ascii?Q?44SFEvznz932gnrCQDBd33CdKgQ0ZE4JKo/52GyMG1n4ZJH+GVhIklrNo3WB?=
 =?us-ascii?Q?5daRIwzE71WwIA2o8q89M+kl7BJC/0T9gvWnxGGDQR/j/hdP7V3C2ULDtoUw?=
 =?us-ascii?Q?OXEcx9z4HdwsCS1JIm+0xM9L1Ac1yDi3jd0/o6TKsUgPsZkiDl0apJl0DBVU?=
 =?us-ascii?Q?lH8W41LUcM+W6ZWMkmkqAhUi4bZDovHrFt5UicMQZfNXV7P1Jdoxnxo4y7ia?=
 =?us-ascii?Q?xnlqS6uTPKFSPQckwVZARldSPYX9tO+0lR9CfOfjZRSGk9r0kgg7+11wnDq8?=
 =?us-ascii?Q?taNerFgRT1a6jJbBLi0sQgLOdpIgjDAIN+Y3a6pBNwCExyb2sJ8UuBBYWVij?=
 =?us-ascii?Q?IuFjV2UrdeYUQ0ssaYfFPy3PAmmtS+qK71RzdN65Ny/wz8mVHwj+Xe441q7h?=
 =?us-ascii?Q?jGX4hB1tNkX3FF4Dd+IhF9DZgzb/lw0bvykAVroqd6r1D1/VMYc8qLi+e0E2?=
 =?us-ascii?Q?QP3qWTDtPnBcBsdlyPgzOPgn9UpRv0PPv8aV74PCT0hHVkyzjxRWV3j4Gnik?=
 =?us-ascii?Q?mwPSSVk/LeDhewZC4y3+/s4ku9l94uaFAi9TZs1TOq6L+VoFFAPdrPzKGUV2?=
 =?us-ascii?Q?cooNmrj6tmt2iU8SIze4CB2z9uBaLSdm7klfIc0hmmzz+6xg5YXE7DpxB5Q3?=
 =?us-ascii?Q?S+4If6kfamc0XTK5wMPfuMzrQ/zmt6C18DSUADAcN/OykZm3J6LD0KNNAeRl?=
 =?us-ascii?Q?nR21eRwOZ/uphb98jaCzKj0dkC9PicN06PyUOP7kYZnnJYTIC5cmSiELGkXE?=
 =?us-ascii?Q?Yl0HXOYDEguiuMtqPU7UhlzJTXuZsrHRlm5Q7iZdVTPQZp9cRiTfku/dilrP?=
 =?us-ascii?Q?BG8zv5BxH/QVCBSoPYN3mAhSyOPB6OWIg8n663lz7dCYDej3wIkkzG7QSdEJ?=
 =?us-ascii?Q?Z1YyOIEEIWp5dORVJv02bTktC1EuVgTq0n9qTuxhn/jwjk2mwdIFpD1eM3iC?=
 =?us-ascii?Q?WhSFMcMR2sfNL/ynLwy2hTxAWLTr8sA15MUhzIjGEvCg+4oOtAbCsfnkIk1+?=
 =?us-ascii?Q?UaKTxTuP546Igp+wGFqIBCYoGiCqA0Mu2ohRTEUW1l3qI42FTvvOE6g21asj?=
 =?us-ascii?Q?gwIikFnNlMO/8lm51lz2Uocwo85hGlwjyzBE0Zdc7PkPpR3FHWqnBSZt0TYj?=
 =?us-ascii?Q?vDzvfw3SjAIng479AJYZET8jrzeCWjojVcA9i1ZRBS8HPH61GjsyhlXG24lH?=
 =?us-ascii?Q?TFNdoCA7Fb/tmysBJian606qDcTtuudfkFQ5YCKpT8aZkWrCSm796h9+/T7g?=
 =?us-ascii?Q?OpRx67xv7jrVan1mNNbJdxD2FF6gFlx3K2QAsv0zVoKGf8cNOI9sH8UUeWDY?=
 =?us-ascii?Q?6Wzw+lPAkQgd/fEqFOep8L5BWEuib+1SoQ3QGs+RyTM06oVpt+L7btcfaMFd?=
 =?us-ascii?Q?Wpoo3fLzxt+t1OoqQzOhGcyWFpywzaVTtLCkKk1qUcHWKzYt4XPQb0fYPZwR?=
 =?us-ascii?Q?wDOnuMNW+JjLYPHMRPLajnXZSn8SXkQeYfE2KCUzNamUhuOqruNTOecg3au6?=
 =?us-ascii?Q?rAFrcg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VCHvQ8c2H7uEaUzLKMBAGe0LyyxLb697cGd2Cr9Ts4UUgvhKmcudzxrQ7fV6?=
 =?us-ascii?Q?hpizd8ODIgLhK1HOnN5hP2OVkJAgHicu0xXhjhlNkF0/2nnT2IYXPAWP6Jeb?=
 =?us-ascii?Q?BaleE7fB6CF8fHJ55XNEKO1x3pvEeP8lWyb8FU3QSvENoKna/fUYI+g7SW3J?=
 =?us-ascii?Q?fWHF3i7rzoQx3WVUQAm9MYHQM7crurdRrxoi1woeZrBzvtD/el76D/MDlS4/?=
 =?us-ascii?Q?lh4Q4FqBS3jX7vNUn1BWjH0JUVWyfDwxCsWEIfGsAdNoRldJUuK9V+p/udB0?=
 =?us-ascii?Q?1nkKOXkEt6tfSM4XL7P2r3Tn9B5mYkv79Ltfqb5UT5T1nXBF/lr71tXXBNPm?=
 =?us-ascii?Q?6ok7JLGkuCHaMl9SmO7y17op5F3wkJbadEqp3F0+ZwRE58x8T+Pbuev3gc6i?=
 =?us-ascii?Q?Zl74dLW9qOwMd561Htw4t5GLFUkUKyKYIgLMWUNJnbo6HEnuD8LralePeBJJ?=
 =?us-ascii?Q?YAiCDPAEpDVVAifr8TR8HY1+xf/kSyRIGGwwH4hMhWXb6SH6m7t8wwe/a1Kw?=
 =?us-ascii?Q?lgsCVxBC6N4CMzrmqAl5Cd2GKSOqo4Rr9jRLTzXfxxXSkDciYMmyy1qwJe9z?=
 =?us-ascii?Q?W58ajtomJ8SFSgVr1HKh64tD/dSWkrSSWupSlNGKk+u4A7tVxClwQkap585i?=
 =?us-ascii?Q?Cz5ot0aRkESLZoF0BiPnD48iqwmcAbVp+YmVMH9aIgSOY36ME+Zs9fvE+7Wm?=
 =?us-ascii?Q?gvM83ocPdnV81kq+nJVo8943qec4w14AuGmtims51jgw3Yuek2An+uylklTL?=
 =?us-ascii?Q?qeFf3fKeHzlWa4fUPBTp7bxZPcWIZVq2PH2lJ/Qz7HTllo772ezszlP3imeh?=
 =?us-ascii?Q?dB04LLXdJzTzcuKODYkOZGt8U0vz05NfH4q29hj0SeuiDxzVLHUf7CiMQxXY?=
 =?us-ascii?Q?RfUOFpnPavnLR0WO4nWFlo/X3eakqDj0cFjwYJDzR10WeY5T6SzCfV31kdAY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6151c72-6de9-4a0d-0236-08dafa623fdb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 21:15:11.5165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvut+1pMwoaHNH+H5Bb8O5oNgZ0tO+tpU2iEiQYsC7Ljp14nUOeUuIQpcAba4/XP464HFv0oAAyL2l2sr6QV7kySr2W8sCCwfyGA/wvi9gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190178
X-Proofpoint-ORIG-GUID: g3RfW7cwUdjzMdXp-gfxlsfdP3aqLzZp
X-Proofpoint-GUID: g3RfW7cwUdjzMdXp-gfxlsfdP3aqLzZp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change alloc_huge_page() to alloc_hugetlb_folio() by changing all callers
to handle the now folio return type of the function. In this conversion,
alloc_huge_page_vma() is also changed to alloc_hugetlb_folio_vma(). Many
additions of the use of &folio->page are cleaned up in subsequent patches.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    |  38 +++++++-------
 include/linux/hugetlb.h |   8 +--
 mm/hugetlb.c            | 113 +++++++++++++++++-----------------------
 mm/mempolicy.c          |   6 ++-
 4 files changed, 76 insertions(+), 89 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 48f1a8ad2243..e2f8951103be 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -819,7 +819,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 * This is supposed to be the vaddr where the page is being
 		 * faulted in, but we have no vaddr here.
 		 */
-		struct page *page;
+		struct folio *folio;
 		unsigned long addr;
 
 		cond_resched();
@@ -844,48 +844,48 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
-		page = find_get_page(mapping, index);
-		if (page) {
-			put_page(page);
+		folio = filemap_get_folio(mapping, index);
+		if (folio) {
+			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_drop_vma_policy(&pseudo_vma);
 			continue;
 		}
 
 		/*
-		 * Allocate page without setting the avoid_reserve argument.
+		 * Allocate folio without setting the avoid_reserve argument.
 		 * There certainly are no reserves associated with the
 		 * pseudo_vma.  However, there could be shared mappings with
 		 * reserves for the file at the inode level.  If we fallocate
-		 * pages in these areas, we need to consume the reserves
+		 * folios in these areas, we need to consume the reserves
 		 * to keep reservation accounting consistent.
 		 */
-		page = alloc_huge_page(&pseudo_vma, addr, 0);
+		folio = alloc_hugetlb_folio(&pseudo_vma, addr, 0);
 		hugetlb_drop_vma_policy(&pseudo_vma);
-		if (IS_ERR(page)) {
+		if (IS_ERR(folio)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			error = PTR_ERR(page);
+			error = PTR_ERR(folio);
 			goto out;
 		}
-		clear_huge_page(page, addr, pages_per_huge_page(h));
-		__SetPageUptodate(page);
-		error = hugetlb_add_to_page_cache(page, mapping, index);
+		clear_huge_page(&folio->page, addr, pages_per_huge_page(h));
+		__folio_mark_uptodate(folio);
+		error = hugetlb_add_to_page_cache(&folio->page, mapping, index);
 		if (unlikely(error)) {
-			restore_reserve_on_error(h, &pseudo_vma, addr, page);
-			put_page(page);
+			restore_reserve_on_error(h, &pseudo_vma, addr, &folio->page);
+			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
 		}
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
-		SetHPageMigratable(page);
+		folio_set_hugetlb_migratable(folio);
 		/*
-		 * unlock_page because locked by hugetlb_add_to_page_cache()
-		 * put_page() due to reference from alloc_huge_page()
+		 * folio_unlock because locked by hugetlb_add_to_page_cache()
+		 * folio_put() due to reference from alloc_hugetlb_folio()
 		 */
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f88c832bdfa4..8f054d81e63b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -716,11 +716,11 @@ struct huge_bootmem_page {
 };
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
-struct page *alloc_huge_page(struct vm_area_struct *vma,
+struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
-struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
+struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
 int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
@@ -1032,7 +1032,7 @@ static inline int isolate_or_dissolve_huge_page(struct page *page,
 	return -ENOMEM;
 }
 
-static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
+static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   int avoid_reserve)
 {
@@ -1046,7 +1046,7 @@ alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 	return NULL;
 }
 
-static inline struct page *alloc_huge_page_vma(struct hstate *h,
+static inline struct folio *alloc_hugetlb_folio_vma(struct hstate *h,
 					       struct vm_area_struct *vma,
 					       unsigned long address)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6f25055c3ba5..46467e80716f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2493,7 +2493,7 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 }
 
 /* mempolicy aware migration callback */
-struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
+struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
 		unsigned long address)
 {
 	struct mempolicy *mpol;
@@ -2507,7 +2507,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
 	mpol_cond_put(mpol);
 
-	return &folio->page;
+	return folio;
 }
 
 /*
@@ -2798,14 +2798,14 @@ static long vma_del_reservation(struct hstate *h,
 
 /*
  * This routine is called to restore reservation information on error paths.
- * It should ONLY be called for pages allocated via alloc_huge_page(), and
- * the hugetlb mutex should remain held when calling this routine.
+ * It should ONLY be called for folios allocated via alloc_hugetlb_folio(),
+ * and the hugetlb mutex should remain held when calling this routine.
  *
  * It handles two specific cases:
  * 1) A reservation was in place and the page consumed the reservation.
  *    HPageRestoreReserve is set in the page.
  * 2) No reservation was in place for the page, so HPageRestoreReserve is
- *    not set.  However, alloc_huge_page always updates the reserve map.
+ *    not set.  However, alloc_hugetlb_folio always updates the reserve map.
  *
  * In case 1, free_huge_page later in the error path will increment the
  * global reserve count.  But, free_huge_page does not have enough context
@@ -2814,7 +2814,7 @@ static long vma_del_reservation(struct hstate *h,
  * reserve count adjustments to be made by free_huge_page.  Make sure the
  * reserve map indicates there is a reservation present.
  *
- * In case 2, simply undo reserve map modifications done by alloc_huge_page.
+ * In case 2, simply undo reserve map modifications done by alloc_hugetlb_folio.
  */
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			unsigned long address, struct page *page)
@@ -2844,8 +2844,8 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 		if (!rc) {
 			/*
 			 * This indicates there is an entry in the reserve map
-			 * not added by alloc_huge_page.  We know it was added
-			 * before the alloc_huge_page call, otherwise
+			 * not added by alloc_hugetlb_folio.  We know it was added
+			 * before the alloc_hugetlb_folio call, otherwise
 			 * hugetlb_restore_reserve would be set on the folio.
 			 * Remove the entry so that a subsequent allocation
 			 * does not consume a reservation.
@@ -3014,7 +3014,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	return ret;
 }
 
-struct page *alloc_huge_page(struct vm_area_struct *vma,
+struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				    unsigned long addr, int avoid_reserve)
 {
 	struct hugepage_subpool *spool = subpool_vma(vma);
@@ -3130,7 +3130,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					pages_per_huge_page(h), folio);
 	}
-	return &folio->page;
+	return folio;
 
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
@@ -5080,34 +5080,34 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			} else if (page_try_dup_anon_rmap(ptepage, true,
 							  src_vma)) {
 				pte_t src_pte_old = entry;
-				struct page *new;
+				struct folio *new_folio;
 
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				/* Do not use reserve as it's private owned */
-				new = alloc_huge_page(dst_vma, addr, 1);
-				if (IS_ERR(new)) {
+				new_folio = alloc_hugetlb_folio(dst_vma, addr, 1);
+				if (IS_ERR(new_folio)) {
 					put_page(ptepage);
-					ret = PTR_ERR(new);
+					ret = PTR_ERR(new_folio);
 					break;
 				}
-				copy_user_huge_page(new, ptepage, addr, dst_vma,
+				copy_user_huge_page(&new_folio->page, ptepage, addr, dst_vma,
 						    npages);
 				put_page(ptepage);
 
-				/* Install the new huge page if src pte stable */
+				/* Install the new hugetlb folio if src pte stable */
 				dst_ptl = huge_pte_lock(h, dst, dst_pte);
 				src_ptl = huge_pte_lockptr(h, src, src_pte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
 					restore_reserve_on_error(h, dst_vma, addr,
-								new);
-					put_page(new);
+								&new_folio->page);
+					folio_put(new_folio);
 					/* huge_ptep of dst_pte won't change as in child */
 					goto again;
 				}
-				hugetlb_install_folio(dst_vma, dst_pte, addr, page_folio(new));
+				hugetlb_install_folio(dst_vma, dst_pte, addr, new_folio);
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				continue;
@@ -5478,8 +5478,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	const bool unshare = flags & FAULT_FLAG_UNSHARE;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	struct page *old_page, *new_page;
-	struct folio *new_folio = NULL;
+	struct page *old_page;
+	struct folio *new_folio;
 	int outside_reserve = 0;
 	vm_fault_t ret = 0;
 	unsigned long haddr = address & huge_page_mask(h);
@@ -5540,9 +5540,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * be acquired again before returning to the caller, as expected.
 	 */
 	spin_unlock(ptl);
-	new_page = alloc_huge_page(vma, haddr, outside_reserve);
+	new_folio = alloc_hugetlb_folio(vma, haddr, outside_reserve);
 
-	if (IS_ERR(new_page)) {
+	if (IS_ERR(new_folio)) {
 		/*
 		 * If a process owning a MAP_PRIVATE mapping fails to COW,
 		 * it is due to references held by a child and an insufficient
@@ -5587,13 +5587,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			return 0;
 		}
 
-		ret = vmf_error(PTR_ERR(new_page));
+		ret = vmf_error(PTR_ERR(new_folio));
 		goto out_release_old;
 	}
-
-	if (new_page)
-		new_folio = page_folio(new_page);
-
 	/*
 	 * When the original hugepage is shared one, it does not have
 	 * anon_vma prepared.
@@ -5627,7 +5623,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 				make_huge_pte(vma, &new_folio->page, !unshare));
 		folio_set_hugetlb_migratable(new_folio);
 		/* Make the old page be freed below */
-		new_page = old_page;
+		new_folio = page_folio(old_page);
 	}
 	spin_unlock(ptl);
 	mmu_notifier_invalidate_range_end(&range);
@@ -5636,7 +5632,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * No restore in case of successful pagetable update (Break COW or
 	 * unshare)
 	 */
-	if (new_page != old_page)
+	if (new_folio != page_folio(old_page))
 		restore_reserve_on_error(h, vma, haddr, &new_folio->page);
 	folio_put(new_folio);
 out_release_old:
@@ -5759,8 +5755,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 	int anon_rmap = 0;
 	unsigned long size;
-	struct page *page;
-	struct folio *folio = NULL;
+	struct folio *folio;
 	pte_t new_pte;
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
@@ -5784,8 +5779,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * before we get page_table_lock.
 	 */
 	new_page = false;
-	page = find_lock_page(mapping, idx);
-	if (!page) {
+	folio = filemap_lock_folio(mapping, idx);
+	if (!folio) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		if (idx >= size)
 			goto out;
@@ -5818,8 +5813,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 							VM_UFFD_MISSING);
 		}
 
-		page = alloc_huge_page(vma, haddr, 0);
-		if (IS_ERR(page)) {
+		folio = alloc_hugetlb_folio(vma, haddr, 0);
+		if (IS_ERR(folio)) {
 			/*
 			 * Returning error will result in faulting task being
 			 * sent SIGBUS.  The hugetlb fault mutex prevents two
@@ -5833,15 +5828,11 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * sure there really is no pte entry.
 			 */
 			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
-				ret = vmf_error(PTR_ERR(page));
+				ret = vmf_error(PTR_ERR(folio));
 			else
 				ret = 0;
 			goto out;
 		}
-
-		if (page)
-			folio = page_folio(page);
-
 		clear_huge_page(&folio->page, address, pages_per_huge_page(h));
 		__folio_mark_uptodate(folio);
 		new_page = true;
@@ -5870,7 +5861,6 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			anon_rmap = 1;
 		}
 	} else {
-		folio = page_folio(page);
 		/*
 		 * If memory error occurs between mmap() and fault, some process
 		 * don't have hwpoisoned swap entry for errored virtual address.
@@ -6185,15 +6175,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	pte_t _dst_pte;
 	spinlock_t *ptl;
 	int ret = -ENOMEM;
-	struct page *page;
-	struct folio *folio = NULL;
+	struct folio *folio;
 	int writable;
 	bool page_in_pagecache = false;
 
 	if (is_continue) {
 		ret = -EFAULT;
-		page = find_lock_page(mapping, idx);
-		if (!page)
+		folio = filemap_lock_folio(mapping, idx);
+		if (!folio)
 			goto out;
 		page_in_pagecache = true;
 	} else if (!*pagep) {
@@ -6206,34 +6195,34 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			goto out;
 		}
 
-		page = alloc_huge_page(dst_vma, dst_addr, 0);
-		if (IS_ERR(page)) {
+		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
+		if (IS_ERR(folio)) {
 			ret = -ENOMEM;
 			goto out;
 		}
 
-		ret = copy_huge_page_from_user(page,
+		ret = copy_huge_page_from_user(&folio->page,
 						(const void __user *) src_addr,
 						pages_per_huge_page(h), false);
 
 		/* fallback to copy_from_user outside mmap_lock */
 		if (unlikely(ret)) {
 			ret = -ENOENT;
-			/* Free the allocated page which may have
+			/* Free the allocated folio which may have
 			 * consumed a reservation.
 			 */
-			restore_reserve_on_error(h, dst_vma, dst_addr, page);
-			put_page(page);
+			restore_reserve_on_error(h, dst_vma, dst_addr, &folio->page);
+			folio_put(folio);
 
-			/* Allocate a temporary page to hold the copied
+			/* Allocate a temporary folio to hold the copied
 			 * contents.
 			 */
-			page = alloc_huge_page_vma(h, dst_vma, dst_addr);
-			if (!page) {
+			folio = alloc_hugetlb_folio_vma(h, dst_vma, dst_addr);
+			if (!folio) {
 				ret = -ENOMEM;
 				goto out;
 			}
-			*pagep = page;
+			*pagep = &folio->page;
 			/* Set the outparam pagep and return to the caller to
 			 * copy the contents outside the lock. Don't free the
 			 * page.
@@ -6249,22 +6238,18 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			goto out;
 		}
 
-		page = alloc_huge_page(dst_vma, dst_addr, 0);
-		if (IS_ERR(page)) {
+		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
+		if (IS_ERR(folio)) {
 			put_page(*pagep);
 			ret = -ENOMEM;
 			*pagep = NULL;
 			goto out;
 		}
-		copy_user_huge_page(page, *pagep, dst_addr, dst_vma,
+		copy_user_huge_page(&folio->page, *pagep, dst_addr, dst_vma,
 				    pages_per_huge_page(h));
 		put_page(*pagep);
 		*pagep = NULL;
 	}
-
-	if (page)
-		folio = page_folio(page);
-
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * preceding stores to the page contents become visible before
@@ -6887,7 +6872,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 			/*
 			 * pages in this range were added to the reserve
 			 * map between region_chg and region_add.  This
-			 * indicates a race with alloc_huge_page.  Adjust
+			 * indicates a race with alloc_hugetlb_folio.  Adjust
 			 * the subpool and reserve counts modified above
 			 * based on the difference.
 			 */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fd99d303e34f..945b41c245a5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1218,9 +1218,11 @@ static struct page *new_page(struct page *page, unsigned long start)
 			break;
 	}
 
-	if (folio_test_hugetlb(src))
-		return alloc_huge_page_vma(page_hstate(&src->page),
+	if (folio_test_hugetlb(src)) {
+		dst = alloc_hugetlb_folio_vma(folio_hstate(src),
 				vma, address);
+		return &dst->page;
+	}
 
 	if (folio_test_large(src))
 		gfp = GFP_TRANSHUGE;
-- 
2.39.0

