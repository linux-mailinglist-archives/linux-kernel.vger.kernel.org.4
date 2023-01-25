Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD4767B7D8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbjAYRGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbjAYRGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:06:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361D859B4D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:06:20 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFNkKQ030134;
        Wed, 25 Jan 2023 17:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=u0dwxiObzQekk8PfUp1TKaT7RYCgdVPTJRur8yXbulk=;
 b=hvMBVF+gs/A/eqnHZGDhEpbeXE6XoyMfgISh+MSjc/o9l6uMBPjxSJFzwXID8/D9cM+7
 UUEmyN+GtiqowSMSj36bVsFJOLOSc/UP2OMGS8cADXmdkpQnNDK+7YK8iLjcEOZNfVIA
 gXW6FSDlSylEkg2NzTnxe+t0QQ9ldMQGQUGOAIFxyOjIXun4zb6n5E4ceq2mn09y449n
 E5Hb/iXoJazJEqcBluc4znqinoXcc19KG4ETQ7UszaoQ2+mym84m6Z23UnGLCBcaWm9w
 kVK/IZ2GUHz0Tw37fNBXybvgEGILe+BfoSrKodrYg9lbMhba2rZTB42nhElB5t5xoDgC bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86u30hn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:05:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PG6rc7009131;
        Wed, 25 Jan 2023 17:05:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g757dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:05:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz9q85aCf0xJUJKEksmbg5MAMo9M+DpZ7RhrT7bRg7/yqH/8lMceEcxQofQ7Vz1HbK6HGCk1oqX6E4LlRFRzWDpg/otVpSMDRzRLlMjIaKbnN3Ruf4sf25EUWAhrFAHKZFyL9t9imCqKHPfl9g6y3+UFu7VlDI01oeR+n6++/pvjq9cJYcmF8xC5J0Ryv5edOpsgG1hXbdUHJJaV8N4wL6tqRqKBtODB+dy1bk8ou944RzS9pyJZXH49TcLY07aCWibca4E0LDdmB5zjT6cYPK3TMsC+4fJm1q/naCBhri6ixpXwUrawDlOTyZ7uzrjwNsrr0RhvI1mi7EZXvahZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0dwxiObzQekk8PfUp1TKaT7RYCgdVPTJRur8yXbulk=;
 b=UFSzzQWUxRWBuivB0uUMFtmSgwcyisUIfjXklqinpe5yV0pDOr8ETS5S9Y1IVZlTiNzzWvvdLb8dhMG7rtwTCptay3E/W8Ox371+jtg942/dUaxjdNiljZheWqFXuUyxLmitmk5NtmJDZ7wFCiKrdT6uiDOn1OPeuEjA1iRPh5S7AH567ONLSajf7/FkUlaTMQE6yHNIF5+TfLxjMry2i/Ng8r0rEuygg7PlvB+xF0tMVg9hycki7E82wFQmDPw8KdRJT7SLZoxs7ewYEUYPw3t5mSVO3mIEJ0vmk+IOSbtAfCSydNzTe63oLoHaS6aakVPf7M+yeyN9BDS+R0J8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0dwxiObzQekk8PfUp1TKaT7RYCgdVPTJRur8yXbulk=;
 b=R4sxQCaGVFWqJoBZVaAb0uMOrpYTO/wK2d1IFItPXaTCJjw3x5cK20S44m4bHEPmoYLTRhe0jwueJJ8bl7nW3I/5BcfJR9+ufPAowQfcmtYY6rUcp/sde3KAicLnFF/ytPNr9CIxE1C+OXO4tGxmisXVgIcHRGQgjyflcqtzDUg=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by MN2PR10MB4384.namprd10.prod.outlook.com (2603:10b6:208:198::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 17:05:54 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6043.017; Wed, 25 Jan 2023
 17:05:54 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        gerald.schaefer@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 3/8] mm/hugetlb: convert putback_active_hugepage to take in a folio
Date:   Wed, 25 Jan 2023 09:05:32 -0800
Message-Id: <20230125170537.96973-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
References: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0041.namprd17.prod.outlook.com
 (2603:10b6:a03:167::18) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|MN2PR10MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: f89f6fde-83b6-4c7d-f006-08dafef66b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: viDzAjOblUKq7eIsGADRaM/lyXhKv7oOmyiD0pgt1+xyiRYZsGXDofdIiFq66DIAZnk2+aOOGD8b2Kx/gXHIFiawnVkJIx6Xb+QxRNFjLelPhN3WKMZ2CMJh1CwgBlfKL8CQjFmfd7oCugxG1P3jbmrxlewehbKHbOlyr1Ql7YbJR0lbICg2Et7ADiW/YzvU08+r77sN7DD5TqXKV/BfG4UoqTlCjCsqx8/NuS3tyERga9yS3O0Fo4a5tccDTbY/zdNtudLEZqS2P65OGND8/03CNhmbDwzMSY46W7RdzYk/Dx1D0G6GEAiguFpkId9QBD4bXAdgBwkJ98SNQDclgtT3viTMcJ75awPb2B86qUavSl/wQ3NIqd4wJ3G35fvl3O6Fo305imOonG2CBzuXVpufqLefPGn5A/WYJlFsND/84dJ3GNnov4m4yV4ZfemvkTlfKvDeBMO+39xCeLUSsfWbFoF9g2S4rCfShOi6oIZ99LKIb/P7flIMNAZ1koJWPq8PT9XO+shnJQujKymaV4KaOX8tep7dW5q5QlGdwOZu11j5X+EChoVBnuEssxY8Zar1M7x+f2ZXIzXyeEqfUw2jLo1/StleJPA9iXOnYyAPJK52zrVweOlMbZ9OdPdgX5Qh4rJPqVsRwUHU7JiTFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(186003)(26005)(6512007)(38100700002)(66946007)(66476007)(66556008)(8676002)(83380400001)(4326008)(8936002)(41300700001)(2906002)(44832011)(107886003)(6486002)(478600001)(5660300002)(6666004)(2616005)(1076003)(6506007)(316002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9sgAYD3gdXxS2CRN9w2rlxC3xGPdd9uuYCRpvYkm6X5on0epumjmGR2Itwph?=
 =?us-ascii?Q?YaBEeHffyb9/lBvqZCDrav/FRxncbMZ6vY1kRuxRDlSfhE8mAMSTWwgD8Ksp?=
 =?us-ascii?Q?MTPXZmizufSmGc7l0X13+hIHj/KwT99MStWFj9F3LEMM9pnz1Tl9x11xQ8oC?=
 =?us-ascii?Q?v7nyeY5y0LhKX69KRWXqcQvk3OXavNwvQesuZxTr1nUrmsravImCOtUu441A?=
 =?us-ascii?Q?jlUcKVgILnIj+NuW+JXrlSz/cBsX3FcJ3aSFC32cHl+yA4ZbyMDgYFK2kSTE?=
 =?us-ascii?Q?IFQUom3n33DW43Yg5iXBsla4lSbKLcu7tn/7obdBV4Uww1P1Wi2WytmvVc1a?=
 =?us-ascii?Q?Dm8OYyqYXoKo0tDmEyFi3e+zqYdiYZocIQBlm4j98Q27nVcUhCze0zio3TTT?=
 =?us-ascii?Q?t08yUNlxkNX9YfU50zbdgVi2gWxafvKdFC2FRlpnMTkkWhNsuaHceFNJV73y?=
 =?us-ascii?Q?Q7BC8gY//VQPV4hD1b4uteOdVtiSMCH1qy8rd7/7ZTF0uRcfMd062vGXWssO?=
 =?us-ascii?Q?JKwIwyMTNBeKWJRqGjT9saEO3mYRWecZR2k6z20MzAdzJpelON0MOpBXJVJM?=
 =?us-ascii?Q?QaMga1l3hZpGtE7yI/UgGxXeHMLyztak5uGR3GA/6QPr5MYehug11ISRYpyB?=
 =?us-ascii?Q?C5imxDTrCpb2U7LdhCnW4LVn51U9NaRj6TPJTseG0WMlQsC8wW2vY+sdRFJc?=
 =?us-ascii?Q?8c33ozynHoFHxLV7/z6nphnJLPC69zt0ZqyhveyLt1o/SQRMdEzCI8EXxqRj?=
 =?us-ascii?Q?FHOlugs1mqKESrBnqAbuXkEiqb4mbX/K0fXvEPZhVkj9sduGoiuXsMb28ZP7?=
 =?us-ascii?Q?h4JC3QoaSXMqAwYSh8f38GctkCOH+1xGgVWqfekSIh/gmb/WVX5wc7i0+gWu?=
 =?us-ascii?Q?tw7aCd9/sl0t/qSYIGBXW4ojQe1slo8k/0bBxlPBeQPqHCsjEqV+/JVbM3H7?=
 =?us-ascii?Q?3EhoeGvaJboBGeldcmAo1gU6Ayy1rzTrBsCzkPu40aMsd7R3bIpFLsi4NorP?=
 =?us-ascii?Q?iehUageLTIgN8OGqy6F31SH+wGTweVY5lZYaQ/tTHl3WrED/fLAKnMSX4Zga?=
 =?us-ascii?Q?HCOc1z5ZLud5XPWrfJAIOaavCAFsSV9eRj++QkhzTtKIvBCW66vRhKeeKJpr?=
 =?us-ascii?Q?QmMbP1RQChKITLI4zH2q2B3eAc+/XOoTgREYN6aHJ0cZyXgifwxVXV/+mQ2t?=
 =?us-ascii?Q?Ar4hPhBHOJ+H5slXVr0vVZrk8KxbvQj7mm5xysldGRc3xfLUcPK2do4PZcgT?=
 =?us-ascii?Q?AX27TqrQ+z66D9rToSuFPazEF1kD+cyEP1ZYauO8JtqhoWjGfclzth5EiqOo?=
 =?us-ascii?Q?UeT0Ef95VJf3m3z0ECQMjbGDim6XdYblqzUUC5eJF7et/kP3Nz6qqgC20skk?=
 =?us-ascii?Q?AQZwCXfndgw8TxCl+HiDCBXlHBNzcpHyq81IKgaoHNrZ/17z0EpMFNp2ZlYv?=
 =?us-ascii?Q?QXa3JKfKhfkTtOkQJzam7a1/EC0GA7A3430xGMV99TUvx4jlf+E0YtJVdh++?=
 =?us-ascii?Q?MgdeFLnjyaZQSq8obLqal8X/9lTwCWgevjRCSMmpWCdX0xlWj4g7YPonYyUl?=
 =?us-ascii?Q?hheL2zw1trOHr7X8YY3N7MaTZHd1h4yQqDgYtR9GNNca6X+lCv61B69fjijf?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?n0ryBzR9McwWSWQGZFE+UCgD1AfXhMAvKGvv/yjkbN2BJvV0VxU4D7WdqcFk?=
 =?us-ascii?Q?5TRgqT+5Mu/H/kLumBUDCKdxjNpZQBitOWaOOd1+fjPiQZryRT18zkLZYuEt?=
 =?us-ascii?Q?VXrFOEZ0zOpG4OCncr7wvfglq+GVu4kCw5mFvrd0j8oyUPHuvTLXEEyq8fWg?=
 =?us-ascii?Q?vbs4WdMd3CXdj6usPGM9glooVd4k0xDaqEO+fuKLcrECAwprGcaBaBZLqusi?=
 =?us-ascii?Q?661YxjFSfpdfxq22fNNtfBSN3VlebHMkIXLUTA9YrbbvOMztFzgCCuP9brIl?=
 =?us-ascii?Q?+CPf+mI+6rs2t0emeis1wuIjFX93HVuFNlUZ1OMbeYjH9mZ6VYPW2f4OLjAt?=
 =?us-ascii?Q?rx1qRLq4nYeWjdp7URK7Kor7xsHnQ5OgEbutZeCivx8ifDcRVNRTKOKIwd/c?=
 =?us-ascii?Q?2a5j4tH2fYUIaWKfHgF5BG0pWTAcGfrrIf+RzV1ka0Fp4PxOKbMk2xriaPlH?=
 =?us-ascii?Q?yKwUi24mCT2Ak4jAmFvlVQk8beVIxHtuhMtx2ayWadexx6mJioteTbUX7eEs?=
 =?us-ascii?Q?rwj6BYXPchP6YUUwcMmxRYp8eF8An/zI/47AvnLa5inrdDSjb6c2NZC7YjJf?=
 =?us-ascii?Q?6NgS7AXwtMLFiGNuSlDI2N6SBZOSKRjsRniRQhDb2oz655NPlsjpzVeQe8YX?=
 =?us-ascii?Q?8TW0T5sX4Vt1hTdiUmZqzLvdX3o7GPE3mUIQhg6b9Uha9B1C2c7sojtkx2q3?=
 =?us-ascii?Q?7V904Q4LxfwlMcjaJnehFEi5naPK8C4VLiQ0REhGHcY4iSsbU9WCp4L/c9MJ?=
 =?us-ascii?Q?jjWWuMMdiZQ8D6y/qLFrg9uRIwEd2gHuTdZs3p53oYdSkDOhLVjGW3bI5kaT?=
 =?us-ascii?Q?VMMlaZxiQ/wql2PkHTRpo+g/L83czSVZIxgIkEytIqWGSXRLisgV+Lom3RZ5?=
 =?us-ascii?Q?rzHDbaVs5k3GGZw2j0Bm+PePtVaTms4bQPywK993TDYToRzb7mHqoAF05NHJ?=
 =?us-ascii?Q?90M9njo8XfCcfrmURnxIRjMKbsXSXCljxCo1VR50CXM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89f6fde-83b6-4c7d-f006-08dafef66b8d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:05:54.7782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +57xr/a8geWzW5upmnHPiDNri19ynodnV6mqQ+D5FFodrPPB/VBRIStU0wAC6g83cTbTjM31J/oRH6mzk3fCXhY+5R58Ix4fPoUmtc4QhNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_11,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250152
X-Proofpoint-GUID: P_ZwQ1rLJe-OcpQjGYuDE_1D7vSIqOLi
X-Proofpoint-ORIG-GUID: P_ZwQ1rLJe-OcpQjGYuDE_1D7vSIqOLi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert putback_active_hugepage() to folio_putback_active_hugetlb(), this
removes one user of the Huge Page macros which take in a page. The callers
in migrate.c are also cleaned up by being able to directly use the src and
dst folio variables.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
The call to folio_putback_active_hugetlb(page_folio(page)); in
putback_movable_pages() is being converted so that a folio can be
passed directly. This patch has been sent by Vishal Moola and is
currently under review.

 include/linux/hugetlb.h | 4 ++--
 mm/hugetlb.c            | 8 ++++----
 mm/migrate.c            | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 06eb59711e4a..1170db8e7831 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -174,7 +174,7 @@ int isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				bool *migratable_cleared);
-void putback_active_hugepage(struct page *page);
+void folio_putback_active_hugetlb(struct folio *folio);
 void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int reason);
 void free_huge_page(struct page *page);
 void hugetlb_fix_reserve_counts(struct inode *inode);
@@ -428,7 +428,7 @@ static inline int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	return 0;
 }
 
-static inline void putback_active_hugepage(struct page *page)
+static inline void folio_putback_active_hugetlb(struct folio *folio)
 {
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e506a46b7871..ded5fe790c79 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7300,13 +7300,13 @@ int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	return ret;
 }
 
-void putback_active_hugepage(struct page *page)
+void folio_putback_active_hugetlb(struct folio *folio)
 {
 	spin_lock_irq(&hugetlb_lock);
-	SetHPageMigratable(page);
-	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
+	folio_set_hugetlb_migratable(folio);
+	list_move_tail(&folio->lru, &(folio_hstate(folio))->hugepage_activelist);
 	spin_unlock_irq(&hugetlb_lock);
-	put_page(page);
+	folio_put(folio);
 }
 
 void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int reason)
diff --git a/mm/migrate.c b/mm/migrate.c
index 92d53e0b609a..b971edbf32fc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -151,7 +151,7 @@ void putback_movable_pages(struct list_head *l)
 
 	list_for_each_entry_safe(page, page2, l, lru) {
 		if (unlikely(PageHuge(page))) {
-			putback_active_hugepage(page);
+			folio_putback_active_hugetlb(page_folio(page));
 			continue;
 		}
 		list_del(&page->lru);
@@ -1374,7 +1374,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 
 	if (folio_ref_count(src) == 1) {
 		/* page was freed from under us. So we are done. */
-		putback_active_hugepage(hpage);
+		folio_putback_active_hugetlb(src);
 		return MIGRATEPAGE_SUCCESS;
 	}
 
@@ -1459,7 +1459,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	folio_unlock(src);
 out:
 	if (rc == MIGRATEPAGE_SUCCESS)
-		putback_active_hugepage(hpage);
+		folio_putback_active_hugetlb(src);
 	else if (rc != -EAGAIN)
 		list_move_tail(&src->lru, ret);
 
@@ -1471,7 +1471,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	if (put_new_page)
 		put_new_page(new_hpage, private);
 	else
-		putback_active_hugepage(new_hpage);
+		folio_putback_active_hugetlb(dst);
 
 	return rc;
 }
-- 
2.39.1

