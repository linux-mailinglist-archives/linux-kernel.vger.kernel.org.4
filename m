Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9FE6A8BE6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCBWfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCBWfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:35:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D204E5CA;
        Thu,  2 Mar 2023 14:35:38 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K6gW6007832;
        Thu, 2 Mar 2023 21:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8C+9i6JX3+uhce88dj6JATXvdBvqBvbHDKC+Yf0i4nU=;
 b=YQR2JNJ7WeoAo87ssA4qH/MZtQOahRAZ98PmcArD3coh1BCW1V4FHp9TqF5XlnGjOi0z
 lYwWpfFuIQbjT58Qu//Vgu2066HehaPapd2TUyXp43mj1sZ9df75rsuDAl8GEkbNkVhR
 cPYLav6HjiHoVyLtvlJX9QXU5z2yGsmD9n1B3uCbPcfrbnz2WfI8IhL/rBsmbogWT1rG
 g2phThHNjnaSMmDvbyPOhODVnfOQ/nO2TypKf/TPa2yDwDMIgwr1eunhatXtBDvY7mQI
 bgj0LYxdC6x4XXYZo+QWnFKcc0c2Hy4AuslZzBHsRBi85uF/LScQ8Zd8Lnlxiq1ctOsO Dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7ww2th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:19:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KhnaH000709;
        Thu, 2 Mar 2023 21:19:28 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8samfxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:19:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cN4nENX8JRJd3pBvhkWTH0F2MujruTCrruvFSFAkOm57eTHzDcQvVeooh/g8SzO7vpMB63bRfQD2hOL37LaNGFG7gMlMSVIiSq0Odih+eL9DVvWGTP1cbxKH/uwQ1/XphhljDf0Lh3u4iTF4txsJdb9BiS1CAgsc1w5s6q9+09tmirastAEvT1p0qaXtT7hE0ZxN28zcVlPq5RJrqXUYoEmeaKwGVNCutHfQJndLmZCI+0s+PrwWO620VBxOpigh+b6HnA5sf2DX6h8MYZysUFgL8ImkB/s8biO5jt7aH6HaYuaR9d7pez66bOCOGdpnJeCfMDAlN1pbKMFowpXrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C+9i6JX3+uhce88dj6JATXvdBvqBvbHDKC+Yf0i4nU=;
 b=UyLB/+hkfpkDByzovLwDZ5YUBCUIJBKwbDgV/TxP9bmFkDEddSuymWWp9NCJdAr0meBYRy1y6gy2H90APpgCZOSw2DoehlS+8e5QJBnBkyWxLbAS6F1HVzFAZdyZGAeNx1opNFczUJRvFDVWqvf3N8yD26Ys/lhuZfh97d/vH86SXbb/jude3tTYBMepS533+IpU4Z7xCi1YRs9cKUU+aM6a/Nk0A1M0M2HObqJLyH8RLmxDGqIOQ5THPVksqmZVGmz69Gg7Q5ae4Z4nE/eLE+OMnIsWHiNhyVBxcHN00ovwzKGsZDIJ+kREjg/Kqr4JLhvNo5BPAtKlNVT/bnxbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C+9i6JX3+uhce88dj6JATXvdBvqBvbHDKC+Yf0i4nU=;
 b=yceMzw3jIenxytaJltT4wbj8cHcT5ECtU7z1p1hmIMG8LlsNkBtyOcRLpKvk1F52NVQrzGQT9InrENTzAar2jmz+SnTfOtoex0bnbbrnurLis5X2U1SQsthVff9gLVoVTEqx0e/6SmWSYsnLoaPouY3cNBxM5ZSLwWXEhS1SuVg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA1PR10MB6414.namprd10.prod.outlook.com (2603:10b6:806:259::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Thu, 2 Mar
 2023 21:19:26 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:19:26 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 16/17] zpool: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:58 +0000
Message-Id: <20230302211759.30135-17-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::19) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA1PR10MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1e16c3-75e4-44f9-22e2-08db1b63cd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P19fzngf+AvrbZgYSbUIfPGAHHFCpMOYUPl374iloxeTlXR299XTgVDFBCDSw9w/kuCs8pRWY8G8weTL1eEEuOewrAeZgqEcL+0XGFzvQ4LrP9r7WDUNFoxaLIg5RxEtVLac/gvJ3FxIU4E/LBFTEcOy7bj1+GE2KvXQjw/ezyJ/weMOmAOZYoEceNX2BDoq03nPOFzWRi0DQJaTPs3kaHXpo/0QlL98tO7LKcGhewBrr7tgiUi+xDUotTmJF4Yd9+H5ZlZ/Mn0MhdjBz0t6R3ReDxMBCofGgF9x59F+ngn3fqYMHcMjrAdYzNsbYjf3RoqOjGfsp03MIhNcAMJjJDCeVKHZ8CbbpcAUmdFLhs5kJa0YiyadUHTmF8yYrMLwsDurGbHn2IldlhJok9MsRoTBtQJbwW162sHUjC7htGnU0ekrHxRi9fg5Zur5cvtGLAV1/sDi7dlAJ9dKZXOcdDFm9O/fscC2JIBnGm2xQ72wgACltBIK+whO909YpvKsXa94ww/RyG/kImGNlJ/eTI56HlilrGDkEGueSBjsYkEG41uObg+tEzbyzL7OcUvuy3avJr+lklkXUXEHlJjW0O5n1OMms1+IzsVUUk+imVKPuJ8DRpi87sNqx/JnODbjp2FARv6QtdiH/Btsv387rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199018)(44832011)(5660300002)(41300700001)(38100700002)(8676002)(83380400001)(4326008)(6916009)(8936002)(66476007)(66556008)(66946007)(36756003)(2616005)(2906002)(86362001)(6486002)(478600001)(316002)(186003)(1076003)(54906003)(6666004)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WEcxiCNnenKbnXk32MkRPliI0vkalkPfRWWzAmuBdwJeRu9iCYiOUXteg23p?=
 =?us-ascii?Q?MqMNC9aYyXn1AuWcvx3lkieT9RVhfcY1+kZK8xsvCaEg3IuOmZIiGqYZQUtg?=
 =?us-ascii?Q?PLY8NDJBh8j37d+l1+s3dPIkMLZSilI7dIZ3L//u3N1Y8cWc9LP1ftrFIk6T?=
 =?us-ascii?Q?ablysANz4yoVfYnytte2nW9cOMwh6iqnfHqfI2tAcAaPpgTXIHO0+1t615DW?=
 =?us-ascii?Q?ljCt6hwWaSJt/uvrLeOHLscA/Vwy5wmIfsqLl70eonijsnPbQZJAA3nim0QL?=
 =?us-ascii?Q?D3uNbbudL8ZwNKq6u1EcYmZRd4jzUQjmD8Rnbt1ZLFSaNmxitbkCfRpQq7bV?=
 =?us-ascii?Q?ord8ahofpkmqehwdo7xNPpnFcXxZKpyG49EFhqOUegHEhDw84na7sTFjnhUw?=
 =?us-ascii?Q?aScKVgBLLagHB+JoMBjRxX+OX18hhnE/EjJd8FuJgN/V7hoTDAEuejMwaY9S?=
 =?us-ascii?Q?phnk+uPlyIO0RHCpafDLixUKoIghxFDEDSUoTEoqkRr/qzpQ85iE0fBih0/c?=
 =?us-ascii?Q?RoZltRcuLyCoicMAvI5PJNYAnkmtQB1gsisJfnZfUolNtYpn3ih9e7lBdw7x?=
 =?us-ascii?Q?tP1qDLXedvt0QlmQC2er7htQ/uQKLxhWYtIAWaagK3SCV3q18XIbZDHHRORt?=
 =?us-ascii?Q?G2bhu6Ga6FZ37m9aTrTbk2yRTYbWYs9Nkh5GElkGL/BOrt9kWiyJ/eAnWonH?=
 =?us-ascii?Q?CniNcK485jV0EucX8LkTVU5tcL25dZeS0htePpsUtDkFXbyJQouMsWjAH7TJ?=
 =?us-ascii?Q?/xVeE2G2k+CeroqtuG6PGRA6Go8MfSANJdRG8OhWbJuKIx5kQ4eu+QaGnFOY?=
 =?us-ascii?Q?hjdXRf2jSiTVbfHRAEMndTTVgDz/1HEbVoXdh+oLlQ4vvbQo62UTHGUInoiV?=
 =?us-ascii?Q?IAVDSjxgqBXFPj3/pvyKRe75BDIzkAzir87VVT0Y13mcfklokhN1TqEhHYX7?=
 =?us-ascii?Q?VcPuM8XbYyK/mFHLfUb8c9emNyyyFq4YXH/E06X9C6uaNqBUJU22BkDBBiTy?=
 =?us-ascii?Q?U10RG95LlM68VXwhKPLbqPu5o+H+e7s5x10LV1Hp5Ez2GCy14dxdIdwDseFS?=
 =?us-ascii?Q?tx/8tYY3uL8K+cYTjxrgOXzOYbKMyeVvbtJqRdEjoaMHt6f3PT0k0VEP6Bb8?=
 =?us-ascii?Q?O2RNbsPYq3dVb2ESsob4SfA1vBsFgEHrS5m29pzR6RdLfnx9mk6ETB36pNPT?=
 =?us-ascii?Q?+KP07xqmpihaVQHfs09U6rXlPmbge8PoYX2rXTyLZNkYCxSRnL1k5zLUjYEU?=
 =?us-ascii?Q?wW0RpBFhJI6vC86kEXNSRd5yBodXEmoGAUge5Ya/0vUTOqLWaeXQjoxpdwXW?=
 =?us-ascii?Q?789vrar+KJJ+zxp/j2pOef6nigKDJA1MOP4XkvFBjSkPMfsSgBnFQbth/ZSu?=
 =?us-ascii?Q?xQaIM8MJVT0flvPPfvz7jL7lb6NywQhsHSj0cohi+gz1oUuT/G2+l+v/nT6E?=
 =?us-ascii?Q?5M0bNPaGhJPahaZAy1BL4qQmod+btF34fggvsyjKbxp5dOVtRNAnGIblaOiL?=
 =?us-ascii?Q?85v9OgUqfX7gWNNSOBZh8GFkJi0OtR4V82F1oD3z5sAhoiZ0YeS+CVhbBRVL?=
 =?us-ascii?Q?/umoLavlTwxhrpvZQckGQx8G07aWeEJ4pZxTfhjam3jRGH07obGko+Xo7wsA?=
 =?us-ascii?Q?0fSbvV3pe1wITHWCcrVtTyQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dhjsJ0OYIgDEcP9XPrkkpxWx+cwPJPPidy1TOOFRHRr0S/PvOaOmU9lDeDqAntjeR/OQFeSzMZIwxXXPw9WRjBcYDtpmcEi4qhsR5AKORjEnrp/XI5kxW5+UNEcRfkJuxMFBzNhHpJuYss0OMzfnWFh5taNcJMlqDHwK6usPmL4NkqOHB/UGI2I6wuQLvPOuOrWV78Lb3RCAwMEptGAgcKKNZq1P1Ofj6MNLoUKUXu2504Ac3siovUVRwLTTu8RcPmwn1IYU2uRYFdXUcLVEfc2OrzHUS/JQ3PIv7Nj3AMLGIrZg9ODVr1Hs2I7ZPURqVZMVB2zV1c0aCkMqVMTCQOo1fHXqmyJtgnULcbK/2I42bMc3TpIJmeqFlDxulk91bk12nMsaXvUIqBxdJn8jj4duOtXsdbEpg0CWESw0/vaGmz28h+3Kwe+cv5NpgmHZejW+b08Fpwvbn6kSacHop1W9tS0oMntVUSJE+D5P7v8qRQd5p6PTjRSIOEIiBjHrhW1DU4aFr69m+PykP1opaQ/FLXp6c7iWSyNNUEYBZDR/mttVxnMhLO1sy7qzDlvOLqj3FuRyDk4B0q1RD20QsC2SISfFyBWN1N3aTDZ4zQvVjKxml/unCF+DJyQh7/VQiBNsxk5AB9JDT7JUpGoSf9yz+aZWOSco1btFJDmY/zRJaKrpv1hSps1iRog4qKJi1FBc6OWUmNWgisQf+wddjuT8okVCH4pLbcXAvzAE6Tyqmb9U2hcL8Q1jesmr4GDqFmZ4GSJCUXWscoji4456jDQmmgbhzSs175sp4lpNnRWK52CfpP5RmGJvaVvmK6Iym6eFlN3k4m3tyQl5NstD/wnjTOb6ltNz5gyW5WZU7g9H/JQO5k+FSOrETj55Quzc8uHeatT/EzInK+/Qvelng5Q2sNO6OOvSWU+9qbvJYPE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1e16c3-75e4-44f9-22e2-08db1b63cd16
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:19:26.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2bQ9jskztEUTZlfjmZF/GwKMEk4cK07Ui2X6lHjOQ6JA5wVNRTvEivUI6T72VxYVsSbnHoDusa1jKsXrKCo+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020183
X-Proofpoint-GUID: M7iNwr6l8zqH0N7E3WWW6CrpvsjtcXq6
X-Proofpoint-ORIG-GUID: M7iNwr6l8zqH0N7E3WWW6CrpvsjtcXq6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 mm/zpool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/zpool.c b/mm/zpool.c
index 571f5c5031dda..6a19c4a58f77b 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -395,6 +395,5 @@ bool zpool_can_sleep_mapped(struct zpool *zpool)
 	return zpool->driver->sleep_mapped;
 }
 
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Dan Streetman <ddstreet@ieee.org>");
 MODULE_DESCRIPTION("Common API for compressed memory storage");
-- 
2.39.1.268.g9de2f9a303

