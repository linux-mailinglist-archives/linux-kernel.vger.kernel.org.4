Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC967443A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjASVWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjASVVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:21:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C1930F8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:31 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKx5v1027492;
        Thu, 19 Jan 2023 21:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=zsPQG8fDL482u8E62UY54HDAQGMVSvhN1uuGsS+Bkwk=;
 b=QVzMNEdR8NrPY+FPHxNJnZQoiFkBOOHMrdgYk5KLGMZ0rfGhA7ciV+mQlz8rmOYPEP46
 rr/zKF3RJOi0cUdo23K3uUXhnBK0rPYTtve8gU8S9ci37XMWgKK5eUsjYXlcHf/Udag7
 GJd/ZwieENmNBUl08uxVhg0+VnjHlxdf0AWW1Dp7SS7YBHkd1axa/1RU1EqW1oCI6Exz
 1g1R49ir0FEJ2Y9pMASzAZiOjCgrB/coF6CQsiF/QekQsZiN2BUg3Iae4rLhpJ44rPNJ
 hPfJXcHpY1/QzmVRsFUPDgNtQcZFtU3NB7fjy5CwKYGPJjCWN/uwZQxFUEndRong7TyJ TQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k013at7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JJavLs004672;
        Thu, 19 Jan 2023 21:15:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2v07ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSDzYNIs3ono7piW/ia5OI2GrWBWOUGrObv6a73SfGWPl2o3WIcziG8OJRdfQgIprypxjY++ZH1Ys/GwJ7JNETuonjdxKKDOpwZZfKkvIj4UCnrlEbPUCkym9qt8sC6gdPxfSDjXGz7mJCc38QTr4NOXBeplr9I8uW/ABcO+AoKkKXy5cQDoeXalxNh20e2WFwkJtzlAdCW863IsNorBnfEbKPSJyPT6AtbijUtr92b5b4JGmRHoQu+Q7RALpFB8hDvEmWF608g/nYUrY84dvevP/LT5lTPL4OpbXtW8Gp86eWGeBsQcfxCqeF0nFphDO47mSJaDDkgRHd0q3qyURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsPQG8fDL482u8E62UY54HDAQGMVSvhN1uuGsS+Bkwk=;
 b=VkrbmEC/T/6JtjclRUkORw+5/xeZw/hDLabjbNjmpu6ZvNTFeGdbg4J/9Vk7q5mCAfd3NZqHAi47KQ0gDHFqEVOKcGjaqwWaGi6Pvo8Qi1pVTzVRqFm/1SzkarKDRWOLX/LVf9riUbHt46NX5IvZjdXy6tujzigyC04lUqRowBQXRyvIG6utb9FLyHCPn7+cWVb+QPfx57/pETxaj5iaWuZ1QaozpCQhs/fsgQ3cTHFmgjlShR56XZlRo08QWDtCvVrhSEGvBkeVX0QEg3qq5QE2499V+akuFswCXhmR5y3V7Z6BoGRuNMMzklJasfd5vWFG8pVxfnEctc2atPk9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsPQG8fDL482u8E62UY54HDAQGMVSvhN1uuGsS+Bkwk=;
 b=jxPsxp1t/+kZt0j3C+h9jUmcdkBabhEJLJJFSNZ7te3nhwTVmXtv0chHb7xYIIZrAFynKXFBe9BGJ8uAhIdzUaQ8Vq17lhI6NWzjFo7z1pVHpTsLjl403WmOcIE1427e8blpIdzQgzp1M8a1usTG3jEcW47BZYKHH2v5oigSRG0=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 21:15:00 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 19 Jan 2023
 21:15:00 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 2/9] mm/hugetlb: convert hugetlbfs_pagecache_present() to folios
Date:   Thu, 19 Jan 2023 13:14:39 -0800
Message-Id: <20230119211446.54165-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::8) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|SJ0PR10MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: e34cc9b9-ffe2-47f9-d7af-08dafa623942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qy7x+wNVZ50XB5JrxhxodaiJrWso3rgp366E4bqEOwLQg/fKsZxLfQ/L6wLxBhdhaiARmQUf6UCGoiKnn/pShohT1hP/H9ZYTl1JzsQ64LTWv6kkiDp+vlhnfSHGExQtv/3Y/jhRxLVTi8mYDzRzJ3d0LyYEHuEVchcXkS+E1s0/Y29Bw0Gj1gehjx9xUAJFh4lQ5VDzqscV4nsBOEroXXWibL7Yq4uTaSCTJ8DagKdBhO9zQWODRz1khux7oyCd5U9z/9CchQMjUpE2obduWFI3IALyJRgqF9czgbNKRm15EFTxc6IcYlGe+S1K18nx/dtVatasetKauLp/MdSZP9b5F+yYFSSuoLcsTXdw+9vpcZxjr72fBhmcKGOCn1lgTa1XwQnSNj0TSVaxB/A86s5RdJKxAAR+GgKuP903XV/aJ2gxrceaEd0z5i1Fy3yHC+zd1GPGuW2tejhhCaD8KLFV3caI4IP0HegVF5xMHKjD49DjbmGRRxPAscEAUGkaiaAE89CwlUq8OfVkDVzjt0Ne60VVYTyy+49PM7jT8kUUJ/rStSO2O6Eu0b2qJQKxe9A9+e3pENCykIZfXGQFdprlK+jSWOokLmaiI5KwLmwrgw+TVZew9lCL8gdlmZn9KxYVp/HEO5ct0CMQLEKj/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(66946007)(38100700002)(66556008)(66476007)(478600001)(8936002)(44832011)(2906002)(5660300002)(4744005)(4326008)(8676002)(1076003)(41300700001)(2616005)(6512007)(83380400001)(186003)(107886003)(316002)(6666004)(86362001)(36756003)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P25M3ehEgCDwDYwSFs2PBXV/efuxjWJIBydC9Yz2rrG7SCXRHs8tALod2n28?=
 =?us-ascii?Q?+pQSf5N6vO+OIzOc85J1t3uMHM+Bph0zXAphAMbxUvLfotbvGgFSzifBqdOL?=
 =?us-ascii?Q?tyUXhgsYYXz33br3QFAdqe+MPOpnJe2PTd59owsd0R1BDAZk3PgQMgyTlcBd?=
 =?us-ascii?Q?AuzPyf+qkDxvcs0/9EJP84nsOmLmcPItx6HMoHW7sm+nhhiqkPDH0NzzTyRz?=
 =?us-ascii?Q?hKLfIexYbBJVTyOix8Meq/JwIB8DKYiYLABuPDsLAZ0Pl4r9LnOH1fV6UKD7?=
 =?us-ascii?Q?5Eb8GPq/lmptC+cdS0kZPDzZGCl2GA+QwctWjQjbMrkWfAyKftbrsPJCzgM3?=
 =?us-ascii?Q?Olone19e3za61pylyAkUnjJ1lpg5pAmJIdLmqHV7O8QVemxiE4RYob9W+vp/?=
 =?us-ascii?Q?yO9B/liN0xIe+WWJjjiuGjm+a9kJ6nHDx4zkmDVRco5w4Ir8G2tAxFEUrrQc?=
 =?us-ascii?Q?tutpW15Kx4BYw6+K2XgJskE/ODQM5xBNElfyanten2BBsctXdDNdgNO25vB7?=
 =?us-ascii?Q?2G+dVvGYlCZl3T/xb7AJq7bZnMuQ3m4WDBAQWocEeUdgasGCHxIlCoFKCOLf?=
 =?us-ascii?Q?hGn2cTWLPHqw2ePQgb7OcyOom4xeLf4JG9+9fohmdRx5/HnhUxnG7dbWSngP?=
 =?us-ascii?Q?zAfBr9iBXTGQ/lAH+c1Rly5PoWi9i4oeN9THGEQhwbWQIgXB5ktbOWPMD+rA?=
 =?us-ascii?Q?sHzqmptMY0eyJEbdBvFo7+xkFD9luwBoutLmmWUNEBEUkPXOzMiAUM/JNJ94?=
 =?us-ascii?Q?A9b0x9XAJghj3k/DEQ9FsKwPLb2xDpxIFtdU/MuFVJMURMLbVtpuka00p0qS?=
 =?us-ascii?Q?z0E1qwAmj8861t2X5m8WmpIo6E9GOPw+K1sJ1qxwNhlzgGCEnmMmk/n+ZfZv?=
 =?us-ascii?Q?BddVXH0LLowPTrka3UaAVkLk+XvJWP69/e9dWYH8hoivCsJWI6HQSFJtMiZ+?=
 =?us-ascii?Q?bDG5sHBGSt2RrbsRyV8pM4HINyfjFCzFQxPrL6ZIs2w87hK5ohkSe1bJugTa?=
 =?us-ascii?Q?hiztS8XOY7LhxD5VFt8kJUQh+mnPH1S+ffaUpiMN/gy2iPETD5AnB0zkSRDz?=
 =?us-ascii?Q?jrGsNmch8l+WLZB7+aBE8UuUpqWqgdpotD7MFqPL7Dtw9y7HPmuoWeQvFOum?=
 =?us-ascii?Q?224k485MF6SvPWD8AAh3FYx34s3ymAqo3GF8VoP44t1o605rGA7Pl2GZTh/f?=
 =?us-ascii?Q?Ixg8dN/ErfznifAoSzXSqQ3p+ZPFEK1OH+tedqhiqPceiNZ+9qOPJ+Gl4ezd?=
 =?us-ascii?Q?vt0L6rKUiub7amXuVpk3q2xJWxpqbwkQGxPxGoS3hjc1UwlpvUVonf0k2vLx?=
 =?us-ascii?Q?/Zxrup6WLufO9UBOM8ZJyoNGX4IkxT/+hjXW12WMDN5zUWyQfrtAilRz3RLO?=
 =?us-ascii?Q?qb8kwrkPO23mTE/PC8aWlYOONr/TkTujEWo5QOqrTY20z0AShjG+t/tQwcgm?=
 =?us-ascii?Q?b/tcHvL+PokY3Ro/G2E7uHOGxEcgPzvCF6DxcjfOMEXVYQxLUt7ayirCbN2I?=
 =?us-ascii?Q?mWWSb2pErCACbi3sOO45OhfCluHtZtN6imseJkLPwSQuUQeV78Md0BRg/rEL?=
 =?us-ascii?Q?cFhfNgXJE1H9w2X4oCr32NJAB0o0ieRxbQRyqwcy/Lrps72ZEVgvtFEfAgEY?=
 =?us-ascii?Q?qCIpgt9UV90ykqjdU+tglpT3VD87SmAEjO0ksi0r0dGF3L/cWanVEKkkESdS?=
 =?us-ascii?Q?VVIOvQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?7TjHEhK2LtOKWCSc+vC8oREPG0+NszCv0yo/8F2EgzH/Bs3g56uawiP2mbO9?=
 =?us-ascii?Q?N8frfy2EKY/hm0w0vf9Nz0nqaz+7Bwm6cofVdYlEIDIJSv/w1uDretlf68m5?=
 =?us-ascii?Q?pQfYc5uLU9kMgXQbOsjuVFZPe3kSOjZAferZzJ4xjD/7MVagf2rtby6mys3z?=
 =?us-ascii?Q?7SRCJ0kTTkgVI09QPNth7v6bGXR/2mYVU/V3zn6+eRqDG6K2KAtSriMcOJIf?=
 =?us-ascii?Q?NtSD+CAM2HBKOR3kTxG4Trth5EE/iXGenBNazvpx6DQR6JKDx6eTlS+1mHLa?=
 =?us-ascii?Q?asaBaHj04pP9XqYxB43FT1EpnUOURMB5QFu0uRnKeAkJ+MAFThpE4qDY5JTa?=
 =?us-ascii?Q?3YtZHj2iiPWSg1+Aos3rz5XjY7Tg1/CTFhkbiSUbKE37tc6eu51UJV+IK3YW?=
 =?us-ascii?Q?8lxXHgN/5Xe7RhVBDfjqkT6mMdhx1PcXGQnNRD6AFp9J8Ci3hWZ8ghvYp1bi?=
 =?us-ascii?Q?R3+LZkYjCjpeuuDmDXGJ4ywBPcElq5hIFL33ExGouP1PcaP4KA1ReeC0/tat?=
 =?us-ascii?Q?XKHEu86Ahokn2A7x+1+gaUtEeEu0Q6K7uGeBjJRXcTeAa9qQvB1Z2mXZC85C?=
 =?us-ascii?Q?cdbrFxBeAFXqc3leNzEfK6AmaGfuzeCZhD1bJO3pGptYL/ZpCpg3JVLz6L5a?=
 =?us-ascii?Q?EiYGHb5qoiee6zND+KO/8jjvqjOLifpXnGSF2Mc/tywtOhH79UTrija0ieXN?=
 =?us-ascii?Q?qrLIyRVAU+UpR/aYKBAT/2TNP989IbghtyBDgZ4Pc55j1tt60k0D4TZpBEOt?=
 =?us-ascii?Q?0kI8QGgNtmEwBsiNK39PgcxQE7C3Jige5qnT3z8ROzIHT+32ipFoL9ILAMMr?=
 =?us-ascii?Q?+G1jzuoOhRacEU4vkHM0SPK4aQpOldgautGac9BPLsAauNc1hcG0W994OEgw?=
 =?us-ascii?Q?WXl+9kx8AzfQizluRcogMvDnwK8Dcsk0trDt3fGlprPqqWXvkTbwcuQoZ6f1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34cc9b9-ffe2-47f9-d7af-08dafa623942
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 21:15:00.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7of99WqYH2u7RSI4R6eDcS0eUnzuG8wTfN9fx1/PhVmF01jFiriuSQvDlV0FY7gK0FYdAkYeslGT14AeMVSJf/QncAzShYbiktIsm4wsAx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190178
X-Proofpoint-GUID: jsivQA4vrPT8-DTqgdFWT04JY3JksEJJ
X-Proofpoint-ORIG-GUID: jsivQA4vrPT8-DTqgdFWT04JY3JksEJJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert hugetlbfs_pagecache_present() to use folios internally by
replacing a call to find_get_page() to filemap_get_folio().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 849206e94742..04cbdf5025a5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5653,15 +5653,15 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 {
 	struct address_space *mapping;
 	pgoff_t idx;
-	struct page *page;
+	struct folio *folio;
 
 	mapping = vma->vm_file->f_mapping;
 	idx = vma_hugecache_offset(h, vma, address);
 
-	page = find_get_page(mapping, idx);
-	if (page)
-		put_page(page);
-	return page != NULL;
+	folio = filemap_get_folio(mapping, idx);
+	if (folio)
+		folio_put(folio);
+	return folio != NULL;
 }
 
 int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
-- 
2.39.0

