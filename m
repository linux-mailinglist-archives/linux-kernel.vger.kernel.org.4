Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFA367443E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjASVXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjASVV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:21:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920815B98
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:32 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKx3ZH008407;
        Thu, 19 Jan 2023 21:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=P8ONpzIrTwJHXkSAMdbEViZE3APyT+eQytr+nrla0D4=;
 b=WEBbfSvIKL7zyFvdfVE6VaSg8ulre58/pe70f8iZmRuox7f8wIgTyIKzLdlwqsnyBM25
 7ZgHLYELqDxgYJCK3dlz5zmj1T3lAzZAZiWIjjSUL1gJ4Jqmebt+WYlsI6ME0XY4YtUC
 egs2Rf2zq8WHGTV0uAtk7rk3869etbMIEI/0k6tAptVAGaGaoB5z//KFFapDXurnN4Jb
 O7zuX9r4dlUSJHnvTVJ11lPlIqjZJZVjqIQ0TTajResawbUsvICNIP5EWQR0cUVGprSm
 SAShA7283b45r/94RmBMG/M4/vUzd4B/eNC1iRm9DRKKicx7rc/h8rAr9MUQFFfsqZ8Z 9g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n78958x94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JJZwGp027915;
        Thu, 19 Jan 2023 21:15:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quc8abw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxDQsJZaClsp4uzKsAj5hZ5sTeYR7D7p/CAa27SZ3bR1QSuMw4rZy6cCJWKszfQHDckyos5mb69s2UmXhdBOfVBzqN9pwyaOqt3vbSdGqQvw1XPDVc92utBmNxJC0RKAOjkkhEdKX5V2mVXLkFxokhCGFEsHs3uKTgr1QEIIkvuXk6bALVD/EDXIoo1l3zeDqKP0QSxNY+wDNAVMfjL4j029EZJZw9cmXrea1V1VfnbUlbQi/nqekNWFUeu4l3pBXKsSp9LsCeLrNXoznPzuAvI1aTxJYE+BUbKpvqtdmmKvNIr1fYFxqitap+9EviGWbXMkHk5GfqZaxzCXdOEgLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8ONpzIrTwJHXkSAMdbEViZE3APyT+eQytr+nrla0D4=;
 b=F7c3fgd8n+s/yW5PInQELS8LhUcf1N+M0zuRvB/NPRX4RUFK+dJQezavfWdDtkx4ntXx3sUB3G203XYAjIUmYFpWlqrWbqZDrJp0Vb/lxVCJaHtEd2E/Q1CFr2aHM60yvVNCl6Xdc/OWrsPZdo6x4/F1ssf6UXcg/VmA51zOi6QPcVb0/MgeFslnrRaayj96sN36hMSwF/kqHFfEhYeD+fnbDg++nA4J6DY7YcEb42qvHkJ24ShZ7r8QjgGUJ+XVHQqxRdKkY1t7X2hVD4PdvRITdU0rwUeqwy/606vl/2K9OSDIP/kWa2qwAN7hCEQPnrNGOSW2DK2tihAkUeS0QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8ONpzIrTwJHXkSAMdbEViZE3APyT+eQytr+nrla0D4=;
 b=OiE23BRcUYHNPmnmrg6RE9E1ebgmOIX07XXB6bKYjt/xa6DLLWKcBMu/wSrOdngoZF/n/2VWqqXWtn2c5jbQkmF7mtAAsOWq7nGgG2fM/Rt7fRRM8RekwSbq9VegfbSiNHvpZUgGiUE2FdcLuHv6kVzOTL0tj+tFN8hGEdljDqs=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 21:15:05 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 19 Jan 2023
 21:15:05 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 3/9] mm/hugetlb: convert putback_active_hugepage to take in a folio
Date:   Thu, 19 Jan 2023 13:14:40 -0800
Message-Id: <20230119211446.54165-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::29) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|SJ0PR10MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: b16a18f2-097a-4e65-e183-08dafa623c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Exsey0OWJC8tVsfv2tg4U8ArmbfX9jkBUgC9/T/ppyX7rlultj4BPX6cT63LatNKGUfmykTMurAY4F5AZzkOrbIbTgYVdZfJuxlwnVuDhWH9M/4GT7o3q284o8iwx/jBFy1ILU/FsLHlOKy4/ow8uDkpIhLGqbIoL2hH20+w3BZxj1jH9ueOqb7lWiVOqWwAapBb2edtmvS66c3SMQz31t74AUyfo9DeeGBdQeJAE+j0u0+wUYO/iXwdym/YX6Mxi8EYZzkFH+LiU7OeiIPDA7UaJ+qdF6VLHxkXtLoK9Jfz3nAI3X+FnnimnN8ibHY6XhRpVZyUfpwjD1cIFGTSo1vZwWEw4AmY6GFN+y8+zDpsfWiuJKbYr0zo/xpj3N/ZRfgl8cow3oi73Shn2u5VLc5scsve5J8tln2JxU2UEBMWyb1XxPAAtjgKAE+dSHS4YNZEkuKsATMAdvEtqV1kwdwcdD8CnbTTx4Y9EB/FBubsnLUKmWjJVeIb1sYSmECiFzMW5gNOVrofHc8toFZgbIQuFY3FsEOpsanRf7AYKlTNx77GUXIlXHPV7CgtVd6MkT48idu3qLRq807d82N1vHoVfLvSvG/cbMdxiNBM2qThhRStZkZdhY3D3oaub64ZLSSw/YvPro0Jo7O67BjoXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(66946007)(38100700002)(66556008)(66476007)(478600001)(8936002)(44832011)(2906002)(5660300002)(4326008)(8676002)(1076003)(41300700001)(2616005)(6512007)(83380400001)(186003)(107886003)(316002)(6666004)(86362001)(36756003)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A80D5j2fqFTX7aDlX3yACCAye1YXgs0KwL0TsYy9WRifFbHYyIS9hcXwkWml?=
 =?us-ascii?Q?R85T34mBvd5DvVAMvEghrWXP/ERXGrMCCG70uxKDoM34/xKC26Wz7qxYx74Q?=
 =?us-ascii?Q?km7otHrfguqh+DYdaCU1hlu+SeR0tsSbjqvvMZOObxGadmPHMnkqB7r0ay/q?=
 =?us-ascii?Q?VwSioK3DlwuBFqM9E2jMxbuhV3MMnTtahQrqbiGYpZgGp1UbV6mQsvsG6isy?=
 =?us-ascii?Q?CFgLaqddGd0dCMMHbqlBTyO1Gb+Lk50L+W/wA8x8MGoLQl4dtli0Seh93qZ5?=
 =?us-ascii?Q?zuJEF0PqSzSMaxoOMo6N8QIA+eDLWL+X1YSh1QUrvUhAbKR6c9hc79tsu0Im?=
 =?us-ascii?Q?EhrJG6zDEqVEJsXA6sNCD3RuNXO2WUyxylvHv+VN+jTB9VZkfeTCRGTbdkk7?=
 =?us-ascii?Q?Z9CkNZyeqj1eUhJ+czRo/BZ2gEwPtKltBuaNnoT/vBaIWEkVyBqGgpqrEaJd?=
 =?us-ascii?Q?ealek4YzHYhInn1RoOjMlkxKeicLuq0QVWZxbazj5fWnNXEN/6O/3C2QCpbH?=
 =?us-ascii?Q?FvMIx4N2f738643fEW59thlqCFMYDY9BYuBm5yaTB48VsG2hplKMvgziObGe?=
 =?us-ascii?Q?8BsVVV3RfcTpj/XLyceVffxXtiuPPYPdT7fhjtxl2sYm1ZlAHkpktiljmk7b?=
 =?us-ascii?Q?IU9Z7QYOOAe1yJhN3Gwg80u8PE242yEEyGbI57u8PMfsnhPQlbT/Jn93Ds7p?=
 =?us-ascii?Q?CQ+61Tf1P316K2nDG+CLCSZaWd/keFgT12bhae8S58k4YEcQVJ4iRcDZ2bBc?=
 =?us-ascii?Q?Cvzfy7vfpvjsyR6d6QbiC3zMM+z5PB4D1B+vhdAugkcvqXQCEdAKOZFCBDz/?=
 =?us-ascii?Q?Pzsv0mkpAylDJT2tYKbyDroYIYTcTqtddrh82GGSjcpzdjsviltQSYN9kwP4?=
 =?us-ascii?Q?pzOJRFnA1XhORj0bzT0Wq1GS/PiGJvV1PDcZizSN5YABfixdJ+5U1D98w1yh?=
 =?us-ascii?Q?BSBQoztB0h+XT0sRfk6upc13E/RRyUJ2U2qShgWs7m5SV30jcx69u7YfUEnq?=
 =?us-ascii?Q?O/uw9G2SI6Zorschzj3/MfnlbYFPZz56o9MgWVoOZk2LnbUvLy0ExWhWfJez?=
 =?us-ascii?Q?EECLkWXM1OdcBL9Oa/36ESzjuerSekUjQLVE6s+QMdcO1j3xBckxQlAp4K7G?=
 =?us-ascii?Q?aQKaeo3BQ3l9Ygr8vNojQjTa5+VL2ryuumDGrpFo/gffgTtr32pW6Vlckxv3?=
 =?us-ascii?Q?4poAO9ejif2GrSXr8UapEV8BIQaeF+537CMYVFGJsnKTwUcgLEl/1ZWpTvAW?=
 =?us-ascii?Q?Z6DLEB+ObjBgW+9p8SBGzs1wzkaJi7qLspay0PcLg9pBXf6OANqg/cIRa0Uh?=
 =?us-ascii?Q?yDiOirf5YR5bQT/PnG6P9uySk3yYqbS1CVeRjuiRwKbX3zN9iXj+IsXZjT1l?=
 =?us-ascii?Q?RXD0TbtfQe7VoJht1pMhnvZ8P+b+wXMHUd0sfzvEjW9T/CSWuNAWqEmoP3KI?=
 =?us-ascii?Q?sYSJxXDOD8RPXqPV2J7kyt64CBbZ147zG07EcY9DvbEV9raSzjxuBT4WfSu5?=
 =?us-ascii?Q?mVcZkF6SgPGIqIXksMIrxw9M5OMhqXcVCkiFV6uneDJ6qTIEP7CLS1WXwr9O?=
 =?us-ascii?Q?50tTlBk6elwfEir4UXhViKyrwjWzpJLcGu1KJlpNgJP83g0tNvnhyYTVkpjO?=
 =?us-ascii?Q?GKAOXI1WoI2NyvyVHjdqosmcxMDk+/jUvEJfY7v2RJDLtnJLUoBhkaQwlymU?=
 =?us-ascii?Q?YbEHHg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Q1HTZbwwpnZFdwA6Oi6Dz1QnsAEDe4Vc0deufbjSf5l+CW5/5l59/DdIr1H0?=
 =?us-ascii?Q?817RpydAPPxHBHTXuUt3MPFsySvLs51s/UVQquhBEtLrIxcVjnTAZQlHH26I?=
 =?us-ascii?Q?IQQ+E34BDhskzt5+Qzg6X9OJrW4RbU+dM34eEzDy3VxW+Be5gGGSWPUZNsF+?=
 =?us-ascii?Q?w2soDPVpahQ5KAd+r3BhqNO9bul+WMKb++xrpLGqhCBmAbX6zJAnuLb4dfHx?=
 =?us-ascii?Q?13glnv34ys9N13Pul+4b9k2mHnNdTyjp5wR4Btb02D5cOJSnFAh/Y60iePPp?=
 =?us-ascii?Q?24l7Nxi6sIQJ8/WFAGD6aI7LGj8VvEaUAj6AJ/dI4KNzdxuXZ4qtgTOMuKBn?=
 =?us-ascii?Q?KvcSUzVYdL7L2UHGW4cVtXAaRcKsdRh3W+DOO63woCNT3QlSFySA0mIpOQ+s?=
 =?us-ascii?Q?YtAbakYoXqtJbhZT7d5KPM9+pNAi6ZPKTfpkeofV9jsdeoceziOz6RVZDiBr?=
 =?us-ascii?Q?9eSQmm1S7+rm1pq1ah1ABE5bG2/xPjKCq9ffMgQg0vlFtjf5po5EsH8tVsHy?=
 =?us-ascii?Q?i8p8+sDK57LeomqGkJKrzMJWneEj/4cK+OR1BFC3I+n5G3D8x38RKPgasSJb?=
 =?us-ascii?Q?v56pB4E7eRchtah/Gljmv5w0vJWTdx4gGT8ITztKUSJwZKRvhnLLP9G2bO4P?=
 =?us-ascii?Q?xHAFNQHDsA2ORP/lpeFZfeAuLeEFXfLhBY2l8Im5AtW3BaOxc0jJHx6z5s6w?=
 =?us-ascii?Q?fix7fAcrEwICIBm7vIVDswz96IC22IwK5UOO2gdhC5aJsZcfwZYwXxkeDFz3?=
 =?us-ascii?Q?jlUK6vlR4pxyygbh2bKoXOo2com9ssnJCtwBUESqY1cTWXCwZOGR39wU/CkM?=
 =?us-ascii?Q?3F0Kfx0+ApZgFF9tkZOAmkABHRrePhfJ3w6dPEpik7812lfr3+M50WqZgvhz?=
 =?us-ascii?Q?mPFB3siEOKyadiljavjK0/YZiPmVtYluck3frlTWB0ALqVLqNGwJqZxr9uDf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16a18f2-097a-4e65-e183-08dafa623c0b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 21:15:05.0790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mEqyX7OEdmdS4snyBQQI7+CNtuCWhVQQZ/0mYcgGN9LWqo8+Ot1uaoTZB0FspJLfluElGtCuusn0C9YGvOBpWA62F6AMmfYFjcBCZPPslQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190178
X-Proofpoint-ORIG-GUID: 0CFDQ5Rd1e0o3TcRMDdds8c63c6BLrUN
X-Proofpoint-GUID: 0CFDQ5Rd1e0o3TcRMDdds8c63c6BLrUN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert putback_active_hugepage() to putback_active_hugetlb_folio(), this
removes one user of the Huge Page macros which take in a page. The callers
in migrate.c are also cleaned up by being able to directly use the src and
dst folio variables.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h | 4 ++--
 mm/hugetlb.c            | 8 ++++----
 mm/migrate.c            | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 06eb59711e4a..f88c832bdfa4 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -174,7 +174,7 @@ int isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				bool *migratable_cleared);
-void putback_active_hugepage(struct page *page);
+void putback_active_hugetlb_folio(struct folio *folio);
 void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int reason);
 void free_huge_page(struct page *page);
 void hugetlb_fix_reserve_counts(struct inode *inode);
@@ -428,7 +428,7 @@ static inline int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	return 0;
 }
 
-static inline void putback_active_hugepage(struct page *page)
+static inline void putback_active_hugetlb_folio(struct folio *folio)
 {
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 04cbdf5025a5..c37a26c8392c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7302,13 +7302,13 @@ int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	return ret;
 }
 
-void putback_active_hugepage(struct page *page)
+void putback_active_hugetlb_folio(struct folio *folio)
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
index 92d53e0b609a..a35f2b36df01 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -151,7 +151,7 @@ void putback_movable_pages(struct list_head *l)
 
 	list_for_each_entry_safe(page, page2, l, lru) {
 		if (unlikely(PageHuge(page))) {
-			putback_active_hugepage(page);
+			putback_active_hugetlb_folio(page_folio(page));
 			continue;
 		}
 		list_del(&page->lru);
@@ -1374,7 +1374,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 
 	if (folio_ref_count(src) == 1) {
 		/* page was freed from under us. So we are done. */
-		putback_active_hugepage(hpage);
+		putback_active_hugetlb_folio(src);
 		return MIGRATEPAGE_SUCCESS;
 	}
 
@@ -1459,7 +1459,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	folio_unlock(src);
 out:
 	if (rc == MIGRATEPAGE_SUCCESS)
-		putback_active_hugepage(hpage);
+		putback_active_hugetlb_folio(src);
 	else if (rc != -EAGAIN)
 		list_move_tail(&src->lru, ret);
 
@@ -1471,7 +1471,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	if (put_new_page)
 		put_new_page(new_hpage, private);
 	else
-		putback_active_hugepage(new_hpage);
+		putback_active_hugetlb_folio(dst);
 
 	return rc;
 }
-- 
2.39.0

