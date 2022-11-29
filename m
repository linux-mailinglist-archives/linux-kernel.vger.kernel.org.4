Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2868D63CB35
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbiK2Wva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbiK2WvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:51:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73CF70DD1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:51:09 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATMDtFO003623;
        Tue, 29 Nov 2022 22:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ai5Z6340XBgifuzZvDQVr3i58Mz9Y04P69MGCD2WahQ=;
 b=ljtBORoCPoUwok5poqHUnGhHdMSbdI9laWPDBkFK8+/oIU01VNLrkOEGFx3hAbngMaRw
 7jET0Moc41Bi5xfWfRWgrQ9rvgoETyN4D9tOCamdZZPw/EOvJJe2aVY7xG/+0k5gfgM8
 ZuXytuCPLf8GD4qOWUN7AUYzSMKvBeS56gT7ekuXBi4U9rgEWQeSnHIVCeJoIfkjxYeE
 isGHiTRNTZJ89CesXiy+No6VAMLWtuP4HXacVDzKXKpTPjDo9tGeNWa7hOBRWRgjKfke
 EWdII8bnweeo6n6TuqP782hicD2tMehgrYfh09WJZvY1wO+FrpXynXOfgPleYbMWEpmJ eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3yddr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATMUMvJ027897;
        Tue, 29 Nov 2022 22:50:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m4a2hp9tm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsNMcn2G1tED7y6Md5E58oZ4jXr57LE1V5Afps9f5MgVZ42FulxW6ZV4bkpp5+ccRut4zgpAEQ53Pw1GPHrnLPa8Es9G1dxTwHQqS8H7Q/kuk8mzuwhcbRwKF3XaKHyj3of6HIkHDTKKZtHuhWlXhSI9phlnJS96845oRdv+hFTXFvltCKNNzraKKMz98j0slQRcEyesklrqZ4KB1THINlkk0CXXLekZwtKE5KZf+4g2xfF9FvaGgpfy5gO4CvfcW0Yy9T+fV8ijMp1dCky3YufMsMrw1WWnYMWfFE3rH8sLdj+fCkjBbPXvDgqJAFF179duw9tfZehB+DoHV0X2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ai5Z6340XBgifuzZvDQVr3i58Mz9Y04P69MGCD2WahQ=;
 b=Mb3DD6EHPvUzawmCG88AjWEgOH9SbF6FPWwLrDo/ie66PjRNBqZE5R+EiD6S+uEt9uArbmqjkZUWRyh45cZXqxj9ao+ZY0bonPInXrMX/wSIjUhrGh8EyrleESv1V8qTbuvjTqYmjNcLov/weH1GKpcjg1pepNaPu5Wi8mvBRauaBMQmHUNYgbWtGak+SoRhjs0GqL+bxWiyw+nnbCfy0fc4hmZFnNIWaXEUIY3KCRGjzIzTzF6ssRqeogu9SIi+tYYuumxe2qHo+aJ5LXbRPl+QqTDxRl1xzPKASpdHMnlyiEUA2yjpAOv8vzhy1R29DMy3S4WkgvG/2bX7NpDvaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai5Z6340XBgifuzZvDQVr3i58Mz9Y04P69MGCD2WahQ=;
 b=znguAmYxZZVWyB/j9/96YsMWoy6eq6KYmrcy61cdP5kTYupVeBb/pYoAHYtZCsLfNtTNU1eQADkDQxY1t6IA/Q4zVWRh4FIUSvPtYkejdUC3DZIMs2VTVNgHMSlEjMYARecGLU1NKghEX6bbQ/9DlfWaXOmnrXXibHIGdo/FxUE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 22:50:51 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 22:50:51 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v5 06/10] mm/hugetlb: convert add_hugetlb_page() to folios and add hugetlb_cma_folio()
Date:   Tue, 29 Nov 2022 14:50:35 -0800
Message-Id: <20221129225039.82257-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:610:76::26) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO6PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: f13fc6f3-9c9f-43ab-3a7b-08dad25c2a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Ap0ockxtQf4Uwqk65oepW9uKYxzZlH8iSgCVRuuGt4iowEwfa3t8AzPnUjnHMGv2KHLUOXzd6Ug30j/CdU7Wz0pNMHzbbVGSE6U1EvnONCf0+jOq58/K4l06ihMopUGdqrgrI7MSz4vPHNRAsYeUXU9I+hG84qHTNr3OIRDo0OKe99AO4o5W+SjFqq1RsRDcc2JSrllzWoZxfDKxBahgBhr4o2BdJHRzGwO+k2/fcOCMKuvXuKzRczxoecBczXyQDPavqr5BvfpRkmbLN/ewacI78wIbPzj/u4w1DRRn4NaXwLosn6HR51BSHjBVAwVztTVWxBsr5u5HBf10uCKAcSEIfNn9s1IlIYeGTgD/G+BRkEx0Ie97GK5AKjnvmI3souHMd8tNbgjaVVIf56eoEmk4BbCRLFMbR9u7G5oF6geI55KtrR6Q6A2PLJzvQeJmJt6tw5mBN760cKzoqcLaVLN6nvpzzux7zPs1gn6Oh0mPq4GldeKXGjftjCyKNkAaikq7ew4/uh/ksIKPbiA75MGlZsQu3YOfHGhcJmTpqv5m9XDDZ2nShE1LblC43vnZTSYR4pNtJKORO/ktDrA/IJx8uNjouN5so0bMvP4PK8i5kI8OYmsNG4UVIzscGEMmTPX9wyRDFsVKeVmbjghzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(2616005)(6486002)(186003)(41300700001)(1076003)(478600001)(36756003)(6512007)(86362001)(26005)(7416002)(83380400001)(38100700002)(6506007)(8676002)(66556008)(66476007)(4326008)(6666004)(107886003)(44832011)(316002)(66946007)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i6snq8mzXAQ6RFTpYGY/Aj8MhP7/aQ1T4CJghyiqna6jG4CELLuZ4fcToSGw?=
 =?us-ascii?Q?cCoGnBcDkrdAcLjb5AAb7QZFC4wNEdQNCHCMxEdWB0V6HUDdLlI1RddczluV?=
 =?us-ascii?Q?QTx33x38aRXAMjvfsx4DkNYcCqRpPv4OaEH1w8QNOiQwEj3ktA8Ho0+634fx?=
 =?us-ascii?Q?cP/6BXn5C9K668Zu+9263NooM67Y4/mAOaTYwVcwP7s4qH8/m7HEmHQsp0xd?=
 =?us-ascii?Q?J+iNVk/JU4Q9GCpHYcO42N78dzSIN0/cFYtICoSWLc0T+vOd8N5NBet216wM?=
 =?us-ascii?Q?bFql9jQ+6EexaqaJmIB3aGceBabOuPRDijvVZ9n9d6bBS6E9n/rr5ouoiqQP?=
 =?us-ascii?Q?c9zu0Ur3nnKJDRDqhJE9orIgTNiJ8URC1AWIjt06uDi9r6rDGhi3T1oqqwF0?=
 =?us-ascii?Q?fxisUV0UZ5UFtBoc0KJaPp3KDPYk2uQ4WSf4xM9Jg1WqHuFScC96p6CpDYN4?=
 =?us-ascii?Q?rAEr2zTZB3Qqcz/+JgUtDfZbMAvCye1Khq5IMCO2xmq/kpNb2b7Dx5lzj2uY?=
 =?us-ascii?Q?quBycpQclYnWLkMfqC4X8GVut/axWQ92hI/j1fJpRc6MK2nPStjCFutGZOiH?=
 =?us-ascii?Q?ya25OZYLsYXpVhhtnTtHmz98BItzHhnoNcilNnMJD/b1nrLFb3sqyP/n7lV0?=
 =?us-ascii?Q?M4KF5OJu2/owZuCumbsZ5u5If5oE/IuzJdbIOZ6KEGgWNX6onSSJnKJYQiVc?=
 =?us-ascii?Q?BMep0+oW+5ynWowGIroRpom2MOrOUpkJqFfn1KQsUIBUNKw9JGX/Zc/y7yq7?=
 =?us-ascii?Q?ujI8DSZUKXGiLj+UU/PQQ4dJyjt+jskKNwfkbswM6giQC/Gli3HUGcmVOoil?=
 =?us-ascii?Q?1wZY6gvsaGtNKTXMSlBi9baOCWyzF0IE4ITnTWeWuRVaEhymvHDrjfAAjHxL?=
 =?us-ascii?Q?tXh2CVo8TFPsjAecdNkldQPlIIAoM60bduhBRz4Zb0i3uXaQqYWeGc3meN1Y?=
 =?us-ascii?Q?4N6lUYY5vWQ2uPCgOu5iw0MqYsyHxzSQ8Trn4BzqWkfe6BSvEyvQqhc9SMR4?=
 =?us-ascii?Q?qDwbvpfKe6gMot9EJ1EKvGPNPypUx8Li33cmOYO/7wZoCWyaFWTLDmQ4y9A1?=
 =?us-ascii?Q?F6mOYZE+t0UDJJBa/h+16DcceARp2Yn1tRyTJvsIu645WVwddLes7XuI8UMI?=
 =?us-ascii?Q?pRya+EkTihzWcHT/mZgNWjLQjdiUJwlNZuYipJDsLg+ncWJhjMi4Lk+mJXcg?=
 =?us-ascii?Q?Semxp7Y2LY+kn+CH9vfSK4qzTh+sLiNbmJf+0CBSgOyGZVQI//MRcFuFbJlG?=
 =?us-ascii?Q?0ZusAqOOU3qL3bj8S6LnRr0EHUG1mQanwteg/cr09cBVP7T4TZL237Z7pQkC?=
 =?us-ascii?Q?udwyO4yKEshuVPojvqTyuPdUCunCPDOiLd+ZBQGLU9hojul0FV1jGi98jOT5?=
 =?us-ascii?Q?tQaTVQ+4s1mpj+9ZFshMb9hvi4tjnu0dcqUSEXwxuKXHQzTBi5dhfPkUTbk7?=
 =?us-ascii?Q?CkR2iJ23/NK6XYRTTJMZswyGjMsTSn3rCs2I4H6R1nR+d5jTQP5YMwFd0jq2?=
 =?us-ascii?Q?lJDvlDO94S/e+hZmgK7kK2lF0Ma+iGB6g8KBUhN+K7xwsQmLIGk1mNrOraQ7?=
 =?us-ascii?Q?WFOLuN7VnkKT8HT5GO/xExLuzzg4LWSHCXsfu0o1civPYJKZ1yeuLP/5vsMY?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1Mx7K0pop3VtZT5XIY0+G4GnXJ8I8Xk6BRHQ+vl++v0Lspb9RyWIT2I1U/52?=
 =?us-ascii?Q?TQn4GP3pJefxT9sRDDffTbaCKIqxOaZL/W/Utu+i/hkVXflK38zx4o5TvRhe?=
 =?us-ascii?Q?Zp+Pyk8MlwoRDP3tq2hF6SejWtCWBhedUYXP/yDnjgqgykNKBjQewYu1xKYO?=
 =?us-ascii?Q?eyi5Q1F6MKSulN25Rpy10Byl2UitAvLIxgOLDba5539d33RghhZvorsarMPP?=
 =?us-ascii?Q?JwPSyXwNtUi/nhCh9qxzgs0RQczMjqdp6w7mawV79cXMBKxD0cpTxuV1+I29?=
 =?us-ascii?Q?VYfPNBrusXS/QPifzsSZSRf4YpcdCK8OeviLbc5DQ8fWq2uqtEifCq+OW75i?=
 =?us-ascii?Q?4coEeDIE/X1m8wR2wjJ/9QFb54Ao7uuT+3ERkOyGMGZqbxoD8KiqsDF9Czmx?=
 =?us-ascii?Q?h9nr57TY8C0csmHhWP9ByNiJV5TwYKaocyQqzRGGlFTdw71mQ7jJncbQW+kB?=
 =?us-ascii?Q?Zb3QLcgiwn6BB9QURdE/LO2ietJB0RsWqiEjD3M0OJumOqWcfHeD64hvfE9b?=
 =?us-ascii?Q?qsC47f0s+gbTi5GqkIbp1Rz7JTpjHoWA6OzjNKNftNeCYa68s/YllBvKKbiY?=
 =?us-ascii?Q?I1nW7IRy2LSGuooUwoW+vLB728Ogj42rb4gLK3VhsoB/xsYlFg9KKsxWVPoU?=
 =?us-ascii?Q?4khIggRdZRsmGVZ/0/dxp2z6NG/TatFMz5rK7ETpmPDpQt3sYxDUqiL9cnIv?=
 =?us-ascii?Q?d/z1sffCZNlHPrq5zHHT0AXHt3h8qWU8dKSvI8Bh35ed82zhVR0L6WD6JMfQ?=
 =?us-ascii?Q?3urqxIMtKFyA9B2GkkvA1erHCoCG9Wj5deMpd9zGO0L/9+WNurhyKuAyU/Vm?=
 =?us-ascii?Q?fclMNbmCEfM2RL+GZcHhgvaG9K75QqlcSpkxhpcD+pa/CTjDazklka/+GV81?=
 =?us-ascii?Q?dc7fboGPEbX08iPNoe4S5ZCAiwhZ7AzbT2SCNdivFyInro8QXF3+5W1y4xLY?=
 =?us-ascii?Q?aHbfkInpo6xuOlwOUpcDPrK9ZFAKL3AQr8e9odkoDUB2/KAn0VsabdJfGYFo?=
 =?us-ascii?Q?R/U31AE8PtnCf4qazdWBEX8vSn9aqBQjrhBE3u9X62isH61XP0z8+QXokKeZ?=
 =?us-ascii?Q?G3AdF7wiJuoSASSMn3rl+UlRuAPwk48yieSn3WQbr2g5z2/RdwI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13fc6f3-9c9f-43ab-3a7b-08dad25c2a05
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 22:50:51.1718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkwzMWTuwj8VTm9CbGqAu0XgCis/h+lo8YKQ+PB5fdgm27hFjb9OfSfd+yHTJI/FjhOwOBp0DqjaW7TfVuCBkMK33npWrKh4bLNEFEbovQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290137
X-Proofpoint-GUID: kQFLTrPF5a3ENu3o33otRaTLELTzFIe0
X-Proofpoint-ORIG-GUID: kQFLTrPF5a3ENu3o33otRaTLELTzFIe0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert add_hugetlb_page() to take in a folio, also convert
hugetlb_cma_page() to take in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 83777d1ccbf3..57909a0e7157 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -54,13 +54,13 @@ struct hstate hstates[HUGE_MAX_HSTATE];
 #ifdef CONFIG_CMA
 static struct cma *hugetlb_cma[MAX_NUMNODES];
 static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
-static bool hugetlb_cma_page(struct page *page, unsigned int order)
+static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
 {
-	return cma_pages_valid(hugetlb_cma[page_to_nid(page)], page,
+	return cma_pages_valid(hugetlb_cma[folio_nid(folio)], &folio->page,
 				1 << order);
 }
 #else
-static bool hugetlb_cma_page(struct page *page, unsigned int order)
+static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
 {
 	return false;
 }
@@ -1506,17 +1506,17 @@ static void remove_hugetlb_folio_for_demote(struct hstate *h, struct folio *foli
 	__remove_hugetlb_folio(h, folio, adjust_surplus, true);
 }
 
-static void add_hugetlb_page(struct hstate *h, struct page *page,
+static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
 			     bool adjust_surplus)
 {
 	int zeroed;
-	int nid = page_to_nid(page);
+	int nid = folio_nid(folio);
 
-	VM_BUG_ON_PAGE(!HPageVmemmapOptimized(page), page);
+	VM_BUG_ON_FOLIO(!folio_test_hugetlb_vmemmap_optimized(folio), folio);
 
 	lockdep_assert_held(&hugetlb_lock);
 
-	INIT_LIST_HEAD(&page->lru);
+	INIT_LIST_HEAD(&folio->lru);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
 
@@ -1525,21 +1525,21 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,
 		h->surplus_huge_pages_node[nid]++;
 	}
 
-	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
-	set_page_private(page, 0);
+	folio_set_compound_dtor(folio, HUGETLB_PAGE_DTOR);
+	folio_change_private(folio, NULL);
 	/*
-	 * We have to set HPageVmemmapOptimized again as above
-	 * set_page_private(page, 0) cleared it.
+	 * We have to set hugetlb_vmemmap_optimized again as above
+	 * folio_change_private(folio, NULL) cleared it.
 	 */
-	SetHPageVmemmapOptimized(page);
+	folio_set_hugetlb_vmemmap_optimized(folio);
 
 	/*
-	 * This page is about to be managed by the hugetlb allocator and
+	 * This folio is about to be managed by the hugetlb allocator and
 	 * should have no users.  Drop our reference, and check for others
 	 * just in case.
 	 */
-	zeroed = put_page_testzero(page);
-	if (!zeroed)
+	zeroed = folio_put_testzero(folio);
+	if (unlikely(!zeroed))
 		/*
 		 * It is VERY unlikely soneone else has taken a ref on
 		 * the page.  In this case, we simply return as the
@@ -1548,8 +1548,8 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,
 		 */
 		return;
 
-	arch_clear_hugepage_flags(page);
-	enqueue_huge_page(h, page);
+	arch_clear_hugepage_flags(&folio->page);
+	enqueue_huge_page(h, &folio->page);
 }
 
 static void __update_and_free_page(struct hstate *h, struct page *page)
@@ -1575,7 +1575,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 		 * page and put the page back on the hugetlb free list and treat
 		 * as a surplus page.
 		 */
-		add_hugetlb_page(h, page, true);
+		add_hugetlb_folio(h, page_folio(page), true);
 		spin_unlock_irq(&hugetlb_lock);
 		return;
 	}
@@ -1600,7 +1600,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	 * need to be given back to CMA in free_gigantic_page.
 	 */
 	if (hstate_is_gigantic(h) ||
-	    hugetlb_cma_page(page, huge_page_order(h))) {
+	    hugetlb_cma_folio(folio, huge_page_order(h))) {
 		destroy_compound_gigantic_folio(folio, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
 	} else {
@@ -2186,7 +2186,7 @@ int dissolve_free_huge_page(struct page *page)
 			update_and_free_hugetlb_folio(h, folio, false);
 		} else {
 			spin_lock_irq(&hugetlb_lock);
-			add_hugetlb_page(h, &folio->page, false);
+			add_hugetlb_folio(h, folio, false);
 			h->max_huge_pages++;
 			spin_unlock_irq(&hugetlb_lock);
 		}
@@ -3453,7 +3453,7 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 		/* Allocation of vmemmmap failed, we can not demote page */
 		spin_lock_irq(&hugetlb_lock);
 		set_page_refcounted(page);
-		add_hugetlb_page(h, page, false);
+		add_hugetlb_folio(h, page_folio(page), false);
 		return rc;
 	}
 
-- 
2.38.1

