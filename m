Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021AA66A5F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjAMWb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjAMWbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:31:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9959111C16
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:31:42 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DK4LNV017071;
        Fri, 13 Jan 2023 22:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=HWdBF1Wlcs9D9iqHgpLX6ouOUWk7M0HHi9i4cwaLOUU=;
 b=UENJuRBPW6JC9H42G/FhSnfJkedG6DSf/aATX3gsN9YAIET8pf5y97e52Sz9t64Bu3YG
 6T+BIkU2lAxjnLNuoKW7Rr07v9mfTPycoEmj/j5Em8y0NcXnwo7B3jxTLmoZev76muD6
 D+xc195GpM769uSCepHVO1x0M6zXlTFPchf+D/S4ZnX1KQqfH1r3FEmV8jJOOa0QXe5l
 ysWjovB2/p4UW66JI4IMxn/tQ8VYeZz7uCuOjgTMZ96zkVBRPSxmUl/HwERG5HPIoDNw
 FNmjrUbAQpzJYpMxW3iBS8G79e00RbZRe0FngoADuLEhlx8oqi74zf4IHh8UyczgdlhS Zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0btwwjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DKwdj4006706;
        Fri, 13 Jan 2023 22:31:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n3etdjkpm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1zu5bnjXvSRnfZvO+VvggFUVHPszOSXvDhHqMNy6pckr4vnW5f1D6saqMmP8PMMaUheuIEFdKMFkFPlsM+9ys0k8Uciur6efPXzVNGDWzJVekK1+K3rRO4ahEw66+gS9PKOIpOXNNCemha51ZvJqxglilgPFBCgOWEkcpsccKYNs0yn9qWD83NmvdjaukMOQzc5MI1sR7j4uGSZXyMHO33qUoVXm4PWm5bWqXt+Dp1rYtRwtV6Q3kMlnWlSuAVWWFu96HxCeWXs82PkMG6ORqxbnAAfT4jPg2dpaA8TwJSRnLYGf6ZTTzXhQIR4JyLaNXezEwdVOxkNpnbqdhGrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWdBF1Wlcs9D9iqHgpLX6ouOUWk7M0HHi9i4cwaLOUU=;
 b=P7FehP0ofzRDQ6xhoE44m2W0kuO5QtNh8ikVpO8DDmaU6QSYPbUUKakhzEgs53slFlkA9c7OvZIufiJAd7x33HlF5Mg2WZMd2qKZdKKoM5tVIOZnFxjlqR6oJs+vJ/baFEmHgZ7cUhslLYF8xSEtx48KfZgMQjH3WsmJ7T4dLoveb4PN3zsb6yPGpRx1SITLSQTeA4pxd2LebXuWKh96R9+YFJColde62S1ZbfZ5mRl0p3LdqI5GNLJ54B4s4xQ1pc9Sdad9hT5Kb0y9IV8hWmgF8mto9w0GOgXKjSiqJObmUUJkHJVLvnuF3Hji5ShKzINVzv5Atya4jvJnumFcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWdBF1Wlcs9D9iqHgpLX6ouOUWk7M0HHi9i4cwaLOUU=;
 b=NviBA3+RQyD1yy4HVTJH1QjsRviJD2Hq+35K1+7JJL2uSSSOJNzvCm7NtjeijIGFiqdKHddsqjZbbrFqiZFecQMhurh+qy7wYj8wMvE4WMOX0iA8KgUDQGhtxsPYosZMcpbzL00GslI57kch7FzFuDn+VbMuhR7jbYKdj4eNZ7U=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 22:31:07 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Fri, 13 Jan 2023
 22:31:07 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v3 3/8] mm/hugetlb: convert dequeue_hugetlb_page functions to folios
Date:   Fri, 13 Jan 2023 16:30:52 -0600
Message-Id: <20230113223057.173292-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
References: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:610:52::16) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 310e7877-a5ad-4ccb-8c05-08daf5b5dcec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6GSPKYmSIORPbHfUeUvMuYTTqdKYkmYju/D4e7ODsy9DIFE1W1r/HYkcPDh0htgInvItTPtWt/3HMwwWySrP7G2D5inUiSvIJ9g/lrEoiTc1iA2DowTfZq7R3GH63pNMkR43v9K1jsLA2yWb0oYURbOXZXOG//7D4CYeWzgQeQfbY48QxcuwFDRVZ/vVaxxKhR/mpz6gHuwUueAwk0zN9WMCKRhnK7RbW7e72M4gP5ndbFF+yAafk441pYG9qBxlUL5loBnc9k8Y4o1ZyrFlSAmJNa7u0IGs2iIa5gSF+C2eEr4ni36d/iYpfYn5k+KQKuT8Rrp2xQu/+cKfM++8gWK6b44vyTO75FVheyGHhz+qGmt10H0GMvND1uA4suWkYzMA1ExqxObvMFE0yn0uD52BEhhUPL1HLBHMP9zZ7b672JfhmdgQxTuD288ZKRBZFaRgLjsoeCOw5vRR2wfHnCrUAp6DkhtMdDfPNJWl0HdvxfLuD3R1egcXzq012SYdVCERyQWq5Im2+ihRITHRD/L0Gub1iExT0R60ci16MxedloZ58poLHPBpC/q6ReVgNuvY0o0MAndUlskK4ypp5izT8cVdPgLD5GExGWB++dgtAslNSVy9nO0JO68DWkEXqeCok9cNkzOubOUmUaDZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(44832011)(38100700002)(86362001)(2906002)(41300700001)(8936002)(5660300002)(6666004)(107886003)(478600001)(6506007)(1076003)(2616005)(26005)(186003)(6512007)(8676002)(66556008)(316002)(4326008)(66946007)(6486002)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TcKLX/1KKs6Xz6QfgDdFHniUobMiEuorpQvnpEgmLto02NgK3hhB0GeMj+Dh?=
 =?us-ascii?Q?2q6a1lyTBCYNh4Fi0Z8UlHbLBIGVWVv1GlDOGNY1JV0hQK2gXjeB/Vm6M9ki?=
 =?us-ascii?Q?6dvbbK/x7xtpxbX6oAft78Hs+GoJSBJoj1NuDmjE2h8Ia6oJpJplV9ngNRGH?=
 =?us-ascii?Q?07/l7GyYOLIgv9aCL6+f9bBMhO0p/MlECGfnvLCAGWMgIiI6LPC6mv7RcOry?=
 =?us-ascii?Q?WvRV5nerhW+HPggd7al6tuhnB2bLATDenL1W/F6O9WOXVF1TtaR1IpUITOLi?=
 =?us-ascii?Q?JWCo7mJqWBCHCx2/N/uDMoUj0aP9d0U2UCS/at0oWC8nPvPFCfrrybwxQWrb?=
 =?us-ascii?Q?1G4gFMub6Zb4swQ7WXv3KSYzf9ER73IbiAZzO9yea2pOTMQylSStTJ9X1BT3?=
 =?us-ascii?Q?5drBSjv9/mCLC5qWcXvsCIfjJoxQekVxe58PSAEOWw2gFJqVTDM8zUEKJhlH?=
 =?us-ascii?Q?6eZnIW7zaTx5mB+8Q1DqEPkeD4MiXCAccyWgDt6WMh68JdjvPYlqnMJjXURj?=
 =?us-ascii?Q?j2uND6+ZlBhgvrerA8xIxPm41jSdnn0epTppMPQt4z1ieCK/UE7psux7Lvwv?=
 =?us-ascii?Q?CDphlO44GPL7dAJgU0qWiRwyrFbqiN1TVoViLumZINNgYLbUgpcFgc+mkPMc?=
 =?us-ascii?Q?LLVqrUJBrhrQVQhonEjSaW+N8EJEb3MTs3b8F3fLeusBdptPnPQVp67SDWBZ?=
 =?us-ascii?Q?zd/xV6QTDqj2wKWL65ZQ4iXoMKL0n2Mrae8tKTw/wuWlPiVCrDbV0/Q3YzFR?=
 =?us-ascii?Q?anmT1Hv2v2oAN9ooYyZFr9NJBhUgQEdjJW5tUnFBF+DlCGjD3kciHGmB+47m?=
 =?us-ascii?Q?pXqHfdPIbyxcFoSAWrwgt2PAyy6KIJCRvJ4hp//yfT9mFcTc68OjNri1DUlk?=
 =?us-ascii?Q?I/SELXCQLcdVfrMJ7rhr+Z/UnZdY+Z5urERAKz2uOoo9ougGX5MSTpJXc2xr?=
 =?us-ascii?Q?s+1NtRWfrvlk8EdgvYCKsT3Jav5BTvkKnrfjW9IfZtKgZF4qJOCYe7soJYbY?=
 =?us-ascii?Q?eVtABGaZJmb1eYbtm7x8IS70K/vrsc0WUmgK0vDGHX0EibSrLd7XO70UV2R7?=
 =?us-ascii?Q?DBU48M0vQ7b0/1V9fBDGngqwOnCbtSHTV7P+qXu5Ljrn+h+Npo6wBMYCcQBh?=
 =?us-ascii?Q?nQ3EKn5Pmf9JEbtxQ/V0V6Ml2OS+yujRjWA4ibFN+xWPRtlgwpcViHVv7yix?=
 =?us-ascii?Q?BHOzIyP8SaRrD0Ox2L+PaD0eHqfV6Ge7eaHYozRUmt9kT9h0PaYaOW0nXlOs?=
 =?us-ascii?Q?ZMjrESkXRwtuQfxM/qthzAaq1N51c0Wfm1nEUPj1G5gXQm4VQBOCqVt8DG+A?=
 =?us-ascii?Q?Jybn7iBvW7hE+faw2mlTd5r6F5lODtJq/dcIYd1iSRxAd9F6lWIzA2MaC+lP?=
 =?us-ascii?Q?/QwFDOFEIbAwPk2TuPqGOPtAVY+5kIjbGMmQYmzhTAoLCo0x7WL6VCXV05zE?=
 =?us-ascii?Q?jNtqFJRpPppdpSm2bPplL5OwqUqMR12vrPKRVgcelnkypsASNJxp3eRg7gzY?=
 =?us-ascii?Q?xNF4j8I6Kb6jD4z/J5EtbsqRqfZCpLCwXcOQw/fwohj0DVMlveZIFYPWP2on?=
 =?us-ascii?Q?OA/rpNWvTRqpi7dFNhNXBLscj9xQA9Zwgx31ffzEtH0SnPMuvQ7sU/CaijYF?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?V/SXUqQpnNakY1Gcjc5x7Jz3sBV9POtZmnK7lCAwnq0KQQo48+GQLHmEUH62?=
 =?us-ascii?Q?sdNkMSmhwsTqQdIclFyowM0m67ktKNqbOuPL9Y2EqUayvR0lCUaBDp2c3Cr2?=
 =?us-ascii?Q?BeCkN78BN/ut6l3nR4fDnurcsFG7Aj0kBugkon6r8xesgFNSpej5Ig9nIWQB?=
 =?us-ascii?Q?s5yZqnBVPd7p1cZOfdMMvohIRahtIWUkSXewX23WHFCDHy8zJpPxo41IKEna?=
 =?us-ascii?Q?8dR+tLm+gxHqKa5pPJ2rD/sXZbdaDaDXwD7PYYIYYqF3z3okY4x0MSpXMJk8?=
 =?us-ascii?Q?KATdU8OiJgXtQDCd7t2qrIkJAYDz+qL9NrQ3lyePJFlNWZrsA8wBV0jzvliq?=
 =?us-ascii?Q?PKyYZyQNGEmiSoxrsoSVRTW3osGImUfVdAYx0EtgKlRHFr/xdR0FaC5mI0i/?=
 =?us-ascii?Q?QA8FwMWCwH49j8Ic/CT24rvacvKxMkwnq9SznDUVPE27LdVXK+4pio9itvET?=
 =?us-ascii?Q?LsaZ4CrEOnM/7oLNBDQLKfmRSKkCEyzp3CQYOyqfwArHscYbhpoFpANwzgFx?=
 =?us-ascii?Q?VevXlISnkpM+1ImRkh7IL249g0eypJ3d2Y/MD5zlmjUci90oADAFFCy+D8/A?=
 =?us-ascii?Q?NwMN4ZPfdoDTzAoCPLlxCI6axQoHUx4Gxc6OCJYwDg4BcaVHli9E3sdtbIyX?=
 =?us-ascii?Q?N8JSv0+wE36URO1Unh5lJvVZIeIKLtAlLqFElHyw0bx9YA1v6T6tpX7laJrZ?=
 =?us-ascii?Q?P6hdKRAF90SqV1S9oW3gzfRWaQeUEaOq8HIJdwZgPlXjE/chi2F0np8+KP4m?=
 =?us-ascii?Q?p/pQnfNx2jG4GdpixBRBlyXUg+OjNp5EYeSL7epL6XTmBFVrl7ScCi410fHE?=
 =?us-ascii?Q?qPNjG7HYr4qPWyyWU8OXG5wbU6Kh+caSthpEPy4zHXG9WVSDibQXv6AWGP7p?=
 =?us-ascii?Q?2tTjkUNeByPKE7OiRIyGorSSgW8TPpIultV8itp7tzPYlyaX6s2JyrVady6j?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310e7877-a5ad-4ccb-8c05-08daf5b5dcec
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 22:31:07.4003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXg2HmkNdzZHV8w4wG19ZgV4Nx2d1KOUxc9rHeltLpI/uB/lFFlvhpKUwguQPBwwk/leKh7apEhiib6n7qOkKeFItobwh3B4fixcymqHSWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130154
X-Proofpoint-GUID: UwhZjTw3rZ1-cxucN7E9ckJqDl7cuW1e
X-Proofpoint-ORIG-GUID: UwhZjTw3rZ1-cxucN7E9ckJqDl7cuW1e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dequeue_huge_page_node_exact() is changed to dequeue_hugetlb_folio_node_
exact() and dequeue_huge_page_nodemask() is changed to dequeue_hugetlb_
folio_nodemask(). Update their callers to pass in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 56 ++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9155bb5ee570..c206a8c1ddb6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1140,32 +1140,33 @@ static void enqueue_hugetlb_folio(struct hstate *h, struct folio *folio)
 	folio_set_hugetlb_freed(folio);
 }
 
-static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
+static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
+								int nid)
 {
-	struct page *page;
+	struct folio *folio;
 	bool pin = !!(current->flags & PF_MEMALLOC_PIN);
 
 	lockdep_assert_held(&hugetlb_lock);
-	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
-		if (pin && !is_longterm_pinnable_page(page))
+	list_for_each_entry(folio, &h->hugepage_freelists[nid], lru) {
+		if (pin && !folio_is_longterm_pinnable(folio))
 			continue;
 
-		if (PageHWPoison(page))
+		if (folio_test_hwpoison(folio))
 			continue;
 
-		list_move(&page->lru, &h->hugepage_activelist);
-		set_page_refcounted(page);
-		ClearHPageFreed(page);
+		list_move(&folio->lru, &h->hugepage_activelist);
+		folio_ref_unfreeze(folio, 1);
+		folio_clear_hugetlb_freed(folio);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
-		return page;
+		return folio;
 	}
 
 	return NULL;
 }
 
-static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
-		nodemask_t *nmask)
+static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_mask,
+							int nid, nodemask_t *nmask)
 {
 	unsigned int cpuset_mems_cookie;
 	struct zonelist *zonelist;
@@ -1178,7 +1179,7 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 retry_cpuset:
 	cpuset_mems_cookie = read_mems_allowed_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
-		struct page *page;
+		struct folio *folio;
 
 		if (!cpuset_zone_allowed(zone, gfp_mask))
 			continue;
@@ -1190,9 +1191,9 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 			continue;
 		node = zone_to_nid(zone);
 
-		page = dequeue_huge_page_node_exact(h, node);
-		if (page)
-			return page;
+		folio = dequeue_hugetlb_folio_node_exact(h, node);
+		if (folio)
+			return folio;
 	}
 	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
 		goto retry_cpuset;
@@ -1210,7 +1211,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 				unsigned long address, int avoid_reserve,
 				long chg)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct mempolicy *mpol;
 	gfp_t gfp_mask;
 	nodemask_t *nodemask;
@@ -1232,22 +1233,24 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 
 	if (mpol_is_preferred_many(mpol)) {
-		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
+							nid, nodemask);
 
 		/* Fallback to all nodes if page==NULL */
 		nodemask = NULL;
 	}
 
-	if (!page)
-		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+	if (!folio)
+		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
+							nid, nodemask);
 
-	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
-		SetHPageRestoreReserve(page);
+	if (folio && !avoid_reserve && vma_has_reserves(vma, chg)) {
+		folio_set_hugetlb_restore_reserve(folio);
 		h->resv_huge_pages--;
 	}
 
 	mpol_cond_put(mpol);
-	return page;
+	return &folio->page;
 
 err:
 	return NULL;
@@ -2331,12 +2334,13 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 {
 	spin_lock_irq(&hugetlb_lock);
 	if (available_huge_pages(h)) {
-		struct page *page;
+		struct folio *folio;
 
-		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
-		if (page) {
+		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
+						preferred_nid, nmask);
+		if (folio) {
 			spin_unlock_irq(&hugetlb_lock);
-			return page;
+			return &folio->page;
 		}
 	}
 	spin_unlock_irq(&hugetlb_lock);
-- 
2.39.0

