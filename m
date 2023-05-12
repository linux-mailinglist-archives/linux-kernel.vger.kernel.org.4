Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538FD700F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbjELT5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjELT5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:57:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006A861AE
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:57:36 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4ArO002642;
        Fri, 12 May 2023 18:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=P0YADHiyGIKZCSFs7likwCgMY85GQ9vKOmtp2jciIGE=;
 b=uLuFfe3VXVfQw6NaKFZdObab2uBHYbv44qf0fI7vuv+nUpKp2ojvtD2GVFZU0ML6Gmdb
 fvp2S3SnAMn4H55b0UHypNk0/ePXYtLBIYHbJYhhhF/X8HttFRt7dCAU6ZjWRuksMH8h
 dobaewibUdpOiYIs7Luy8YKqGb+taT3gmkksehxUJb9BHI6arcaUu0BVtozb73V+zAnx
 QuOUlETT2cO5U4eO+wRpRipp1t0UP5bnBMfFOh3lAenSm6yrj3hQvVL7dpFYH4KwcmCu
 7TXQMMD43dGA4/y/D89+0zKQw0D0QfIdAtkhxLZ87hJUWmZKl+JJYmOhyEUaJFZgf9uH rA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777bkxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CGhMOQ018122;
        Fri, 12 May 2023 18:22:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77mjmj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evknjDmA5+ABufeohnVltdbObitAkQ9auwIhZJB3jb69KxujGmvCfgufG4F8rVtowhIVG2BwL77eae1C83qsgQvG0S+PPGrNGvNP8OQHoUzSCs4tuBVSwGp2Qd//2UvPDEjtQWdRFLLmjWQtEraIaKBiCEQ6jt+1dSgxQ0h/0neWaPSZtnKie5om0A0R+KQz1c20M2MQwGtIjP+s077s/g9HZR6MPHytd3+hcEKQxxRSsMuuPReXLwJOfw5MenM5rQWh6fS9f0sWqlod0+ufSaDnV7xxkfCHPIr9sHMHKShwUtv+m6Z9VRFEkrjXnQOKWIuRW2RYFpI48SfB3r7dpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0YADHiyGIKZCSFs7likwCgMY85GQ9vKOmtp2jciIGE=;
 b=OXyN8LT4PdetWymlJsHC609ZfW85CwqzlytzQaHKewZ4mQroDdwkZN5teOhemj70hAhQuv12sN3o9KsptB5o6m343M06tsC/MpJ8IvpfdchDvXFIVF3msevo/8ZR33l7MHUDLfVyQ3bWQmWwzQCSGahNeoHGxHa1+fw2BGfqVwSqFdt8it8nVJCC8POz2ip2OhPXdvfZh0LSvkWiaob0uCYbTaQNSpvoaBlijMZRINf5PTrsyEMArpD1/tBc64Jz9SKh5Gf89K/4a1cjyZI7ecsUOLNP2BanZ7nQu0/UmG8+1VuoBUsANBapUp5kal9nBZ9FvO2JYtq0/vqu1gjhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0YADHiyGIKZCSFs7likwCgMY85GQ9vKOmtp2jciIGE=;
 b=UtGJCmvL16Dj7vJSko55Lhu+aRjNbY+3X56cX6g8QuT014k1PRDBnZNswE4eQJYKjzGzDGtFFNmNzY9aLDUsmDb24z2UnqSndHurm1a9Zwd4oaruXJIdKxcUoyHg4vCP5T1oe6fAgRrWxfkVOvW8j0Iwg4lFLlDASFlPlIgjMps=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:22:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:22:12 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 32/35] maple_tree: Clear up index and last setting in single entry tree
Date:   Fri, 12 May 2023 14:20:33 -0400
Message-Id: <20230512182036.359030-33-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YTBP288CA0025.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e0ab98-647b-42a5-d15a-08db5315ce0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVmPDy68VSFJOkWaOc7FIOIXG7cTJHHAhfQI+19Wqo65HdBBIDS465fIXHCerFbSOQ9XI/1qB4lM2SZPaSHsvGOxP9et3guBBD1bVQ5Qc7elbIPuQ0gwJ7spxzm+St5TP81juYbR0embVCH3I6ii4oNI2fHOFMiZlbwx8HiEM4/OJlMJG/yGnGnkKiJUGbqedx7TSK5enpeEnBRfmj1/5X1iCyYakMpl1Hg79KvLx5LQ7A4yr3nlydtvbYCwbbdTMOPjRYMJ5qyglQgFR4UJmiNAjofzb4hlUu8E6+AP4z0M8jgBT4sEhb6B+7jCcTpeh18hWpuDAyfPDicqKsyBOyqGwj2FgW0bchTtOZDHYR/xIhK7Yw0jpyElhjVPcOD485i1tIldJ0USHKNq0dpZmH8XhPwSdgWEzuLlDFra078O+eE9VZ638n7a/2vSNwbKqgFrKzFdyJW9E0hFOUUhw2GqXbpSKwidMZ35CgN2v6AEw96KKganaNo4dnLl4l8+hxwhP9vNlZOoNCtBSJnzMQY7MEIj1hO9reZdgHmKlb1JiuROohNRWki5Py/QB/ul
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(6916009)(66946007)(54906003)(83380400001)(5660300002)(6486002)(316002)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+A++nQUB1iFGap4S8daDXiVf2ojLcYTiAlBBV68JWjysaRnubuyM4MgZJO5y?=
 =?us-ascii?Q?32FLz8HkTvqrqZvZlTqxkJoaF90s1tk8imbL/yFnYQpz+FSYwAxNSG47mAs0?=
 =?us-ascii?Q?lgjEV+MrdLBRe9jki83AzXW4+QZA3YPPNBN0ZIT0dBqF+6Un80OFQOKq2iq8?=
 =?us-ascii?Q?YiQ14A1ye1876w/7aFFAPUBD5CcVgYhRE8yj9weo2AxAnAxZ0KPErfifmBIH?=
 =?us-ascii?Q?EzAYkJ+h3Z9Nx847KqESihzkx7G6pTe7D8kNHV4HdLijNXCrQxaUX7qObQEG?=
 =?us-ascii?Q?7toRbVTD7fF/KZR0T6gwM90iPDJNuCDm95FrVXeyXa0GQFZesBeEP8R+UA4z?=
 =?us-ascii?Q?DqdJFPIPsxdVNJKeqd8h3IMzHnYOlBR2tlJufXa3WmFZBa+gHn4hYUL+CmCs?=
 =?us-ascii?Q?soTUn8h3RbuwTOpIn2pcGDMjFA7J9UfIOmkBn/Qo5EGkillMy4KlUbKpVey9?=
 =?us-ascii?Q?s8/ezRQidNrnggZ/sNXINsEWg9TtOBSjztPmDKr2F28n3frzBJZhhgKazVhj?=
 =?us-ascii?Q?XHUp0Dy6Pg14+qH7qtRyYaPGOMu2yw3e27qIQB5rs4hwPcUCh5s3nB4UHsQp?=
 =?us-ascii?Q?TvGak6+UBh23RQY/PEZ71SAPVazClrm669bCxFcDcyqXQw54t1s24RTX5/eM?=
 =?us-ascii?Q?McPUDVvshIU/r8krwi2/DSPwv32IW8Slj16wktjj90Z2cwE2tqK4GWu1tsLE?=
 =?us-ascii?Q?QmKQlpCksuayxy8SLOfZ/EtOiIzbwNvI1OAYnfMVIFYf+ZbSgh2QFAokSMFF?=
 =?us-ascii?Q?U2piOnJXQ35xI4AD//IVMfmeXm2AaXKmK7FztTP+EVV+9YQe22NVbms+a0n9?=
 =?us-ascii?Q?HL366MuvGDx33ChUSwi0U+qttGdJ7nJWJkgE6nzG3d086sKt2f37b6+M7ibm?=
 =?us-ascii?Q?VXEEwC7slJN8gn/eaN4PLU1j2QhSq3ov/y5TdGvcSu6bVLQyKKhHyPDm3eOr?=
 =?us-ascii?Q?tZM1VRG2eEuD6w0WaTo5LjlxafHshDxli+MrqR4byiKc9yssZ6i5gMoe+wX0?=
 =?us-ascii?Q?lnv+BsOa0mBoAvc1Ra1fIm49n4+mjKNAdlDpb1OZ3kFMLuMmFCKg25tcuItw?=
 =?us-ascii?Q?0H9TtHYUN477OVjbEdzSkKclurL45M8kBRWepxVcr+zHbDYLiRRVW4iAN59/?=
 =?us-ascii?Q?hCdlNkqQRNB/uVNZHIHa53ch909tHNdOahtCk2KRm9SuDiXi1YwxLXVwQJaN?=
 =?us-ascii?Q?jbFcijXGuOb8TUINIT/cGshwXpeml19bz4pqufS8YaQMzs1DFWubNEgjHeyE?=
 =?us-ascii?Q?3aicFQOtpEMIqZ1KoRI1bnGxGFW6oGFfF2RED/y+A5yziZNVgNRqVor08lM2?=
 =?us-ascii?Q?nA3REnYeZ2jWxZHSQyYvuoqNvUxU7LNPxxvhrh3qfWKdGV+LVn4VFoGgjnYa?=
 =?us-ascii?Q?66pGZ2228MhQMEI/c7umu7RxD9Gj2phh3bIPZ31vRCIJ48dVtsmUge4OhT2Z?=
 =?us-ascii?Q?wKzbxWXjDOUlbFzagu7uLtm1Bndb7uuAaO91NkMoKNFTQyDPtGBv5Oi2RnZ6?=
 =?us-ascii?Q?xew8c5t2q+2BVVGmudduLFSX8W/Htr0hfvC/28/0OXRFCqfk75FR6HT4FXGq?=
 =?us-ascii?Q?E0tx6TJetSyH29cpN06k1IpwSv3R8Np8WUKsTUX0ttl4wsVFYKhSNpd/Nycu?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vtB9Wy1c5ZbE/1a+sYQrwGCIZO0EU71V8laZp5pfhbfaMcOndbXbYhi6bTy0?=
 =?us-ascii?Q?RtnaFt9qO0D/tvcPnWA+nLp1zybobvqOLG0ipekZbfj/QFUEFHUb/Q3ySboU?=
 =?us-ascii?Q?uHWdei2eglLPNA+OztE3LHvM5GzE3VzS9YKoYokfNJ6aehRlPEUN7RY/6Xg3?=
 =?us-ascii?Q?163B9eyx+Gn7BgvoABAy6Er8OcFr9rHeK2pHIz66wRKqbcUBRwMuTfP1GFaC?=
 =?us-ascii?Q?0EgJ+tmqeqpIhaVYcUAlU5bOY8m9oBV6Tkg2crgn6tq/oSXxKFnKzsnTiLvg?=
 =?us-ascii?Q?PVtblyH/al71IS9o2HBAmP/MsSZrvpkvXxuXnstxlFZUveemeYJyH49clm84?=
 =?us-ascii?Q?fxsJiJnJAHRjMQCCE/ECKpnRrF1Zip73owyJFYqZsyTTHEChH6i0tNFotqe3?=
 =?us-ascii?Q?3BVaXB56KqezP2TH7t3eUlxFUcQGPYkwyAp04uK+nUJ03LLuF8HslLmmNLWl?=
 =?us-ascii?Q?zV+Fq4mB4T8JmbuF6Jy5MRvBakjJh5dgnqanBf7ujjmTV2+9LT6Dhl4vQ2ZF?=
 =?us-ascii?Q?f+hIHNaTdYwKLnn2wczEL8Gp8eRR3/rwJ0PJrMebcYT942wvNtJpG6AzKqWJ?=
 =?us-ascii?Q?UsZVAF/mOpQbJlxupYPdnF0aICdyeSZbJo9oLcXL8HX9Yn9r8Svs6kyWZXnp?=
 =?us-ascii?Q?C2HS3FMatYKEK6JAKJCw1SFAa0ber/bZ8239Efat8U36ylx6xd5kMFoeEvqh?=
 =?us-ascii?Q?4chipJuigfLBmRxRHs4W4sXRAYBvWAd8j3WS8ustoe6UurPfirToxS/PqKF3?=
 =?us-ascii?Q?LpTIuh5mWoZgQuGL2jKXtlVpalSxgjiao4N0grGS/FsQXxzk4UUjw4Hdz5WY?=
 =?us-ascii?Q?eHox/M1HGkz0iIob2LKQsmNrfVAncVqix3xipsfjFLl/L/ks0Cuxt6ZSaF3i?=
 =?us-ascii?Q?set57wkmAXvAOqv7MGDWvB3hEiXjaUiOJDYNIg3izSFcg4pxCq0CP6bQLfJ+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e0ab98-647b-42a5-d15a-08db5315ce0d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:22:12.0464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7TYYJ7yvW9YHIy+KjENPuxEWhequXwiBO31b9YUzTaGlq4X1+U3LMpzEbRVX6SyIzSj4szSInbH69pLUGRf0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: nkKDdgHHZ4vCy6gzgg1hRUReXDTwaVyY
X-Proofpoint-ORIG-GUID: nkKDdgHHZ4vCy6gzgg1hRUReXDTwaVyY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is a single entry tree (range of 0-0 pointing to an entry),
then ensure the limit is either 0-0 or 1-oo, depending on where the user
walks.  Ensure the correct node setting as well; either MAS_ROOT or
MAS_NONE.

Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index fd4f9f766cf23..ec4285e141d53 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5022,24 +5022,25 @@ void *mas_walk(struct ma_state *mas)
 {
 	void *entry;
 
+	if (mas_is_none(mas) || mas_is_paused(mas) || mas_is_ptr(mas))
+		mas->node = MAS_START;
 retry:
 	entry = mas_state_walk(mas);
-	if (mas_is_start(mas))
+	if (mas_is_start(mas)) {
 		goto retry;
-
-	if (mas_is_ptr(mas)) {
+	} else if (mas_is_none(mas)) {
+		mas->index = 0;
+		mas->last = ULONG_MAX;
+	} else if (mas_is_ptr(mas)) {
 		if (!mas->index) {
 			mas->last = 0;
-		} else {
-			mas->index = 1;
-			mas->last = ULONG_MAX;
+			return entry;
 		}
-		return entry;
-	}
 
-	if (mas_is_none(mas)) {
-		mas->index = 0;
+		mas->index = 1;
 		mas->last = ULONG_MAX;
+		mas->node = MAS_NONE;
+		return NULL;
 	}
 
 	return entry;
-- 
2.39.2

