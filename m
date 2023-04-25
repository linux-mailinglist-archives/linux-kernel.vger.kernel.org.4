Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954106EE476
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjDYPHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjDYPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:07:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07BCD319
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:07:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDi8r3024340;
        Tue, 25 Apr 2023 14:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=k0fVwaKie4oTeZToT+Ho+LImSroGb0R9XHF478dE6eI=;
 b=FSSkfT69UmkFY3kLoipbXjkOQtz9Ct8BuXm2X0D3cD2bftZjj5l8AEpKid34WsYhEAPB
 NQ2/m0yZD1bHY7yvnc8EWLqB15+5FnJ28orHWup7MRuSaSDxATBhdE2HT4cIldxd5fo/
 OrfzsnLZSPX1c1pNdQwbuEp+yVklvI0jqwBbSxwftRlyc1Ya9L5L5PzY+eQhqHxpjXH5
 gxET5JeyAULdGoIkfvj0ieLatnExUumrjzjMMD3H5UliCm2rnDekQ1BLjphHUO4O64Lg
 PvexKUU5fez+Sm/4kGUGiJd0RpAEdfQNN015ECo571sNFFPYnGwswMMja/+EeP/8MK1W Ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46c45fxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDRVTv008651;
        Tue, 25 Apr 2023 14:11:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616qpq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzLMoy+hYIZr7JsgZ95rQwvl++cQZit/1h9NTA8BK9zr8q6Br5fr65ebxQnSgEQg78INhiS49uqwTsX8u/TdYSuxsT6hbnR18Kxed1bVEiAbkyaUnxwPRRO2jsKstt35l3NcDSKKG4DMbnVg9qvvvQEamRj1w1+qkm22bhK2O1L38AGtJKQ7yr5Cf223NE5RjBzk7IeMv2uUSX2lbp7Xl4le0m39nO42rIUFJvNEzN3F4bzSf3ZTtHAkunL5zxwAXoxkkFTlsws7GgazvFRG2peVVLFLumQPw671Iq5fKbKwVZkzjCRLg/8C9VRveT/0RFaqDrY/vwzyxIZaYtj6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0fVwaKie4oTeZToT+Ho+LImSroGb0R9XHF478dE6eI=;
 b=SPdoXrAUmMUlohSAgnrpbmN1jE0v+fqcR1lm5gTEsQwVrX8s5fZ5rPWuunACCdzY3P98ICOo6sZwC48cDd+htgpAFLrmziY0KDerQW5LA/5ctNnZI6HzYiUztOpVCdxA1kfxWe48UQQ8ptXqXZ5LZg3BYGILRGErWw90PzD1MRushOAaqR427It5ApQxxh6QRTKsbuc2dYj0uPD4FfIsUy6FgKFNBA5jEa/dnt6xU5l6f7k3yPCQjbt0qeNGfoc4WmfLyfA9BU9B5tj8/bGYMTPtwzPhlzDvptyFAYCZseKSk4Xyd9HaJXlxigOY/cOIKOII9A2tYXX5ejLxLLZwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0fVwaKie4oTeZToT+Ho+LImSroGb0R9XHF478dE6eI=;
 b=eZJLvWM/EmvmTSvjGkQir7m4nAzxOVAw8JwstP6s3Gw8oXNsWxrHXKAMnAszNxCG1kJmyOwZ4hdO31WfKmYJl97V2rSTqlSUeoGxUKnzjvFD5ORu2YGGjfn/Iv5XzR+qypFYuykZglIpoi5FK4Wz23y03Xi0IfdPnJP/07mkMKE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:11:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:27 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 28/34] maple_tree: Revise limit checks in mas_empty_area{_rev}()
Date:   Tue, 25 Apr 2023 10:09:49 -0400
Message-Id: <20230425140955.3834476-29-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: b43eeb0d-62b0-4217-3e7d-08db4596f5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nEIdFEDEwss2+1IjqFJzbHJQUM1w+mMz8mH6v0sUr1AalTV8MvcqncIQhYnwqnIxfgnQ8uI6E1mnO6+T2UpBM/OqkNBSd8XcaYQNm3xLEUztVz6436U9I92XEdW4jmw24oJniwS+TkNf6AVvyJtRTqxVpx8wLcyXehQVihVgOlTuxiWrB88GNLhKOBIYZqMwLWsyKy6taVTex5N5mlQcpTWEPag1kYdxrajFG6B2WrVw5vLsYtNz1fJCvzHegPbSM3EAKaYxx8OjEUUWYrl46JtR6lnfk0ZBfxLENhXye4ZUtpmQ4ZLoq6W5BICT1ac9D3ohjvvuj6tYvuE2jpJcc81kCOqUr6Q6qho10VI9C/yl6P/zAQ+ksBscos0RNpgZVHJk+PxqBU7FVWPhsbv3WhPKSIGW3RmQAbhpQP+NhrWCg0gZEx0bkVI9xYieTEUqP/LXo1FLsXPX++t2LVaCxT4wzEvBUFKb547MndJ2CFAfLHGQWh0Zng1y0QjoTwzVyG2IABVRsHRKTCN6JRSO7Hd4GArbCko4+jQDm9X5tYU9V5ZFxfoYBaQ1mXoHIONl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(54906003)(86362001)(36756003)(186003)(6486002)(26005)(1076003)(6512007)(6506007)(4326008)(6916009)(66556008)(316002)(6666004)(66476007)(66946007)(83380400001)(2906002)(38100700002)(8676002)(41300700001)(5660300002)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kYoRzLumolKC51FHmeyiwKkwbMNKQSB6yUYY1Jeweok+GHC+A9h0zRu/O0IB?=
 =?us-ascii?Q?6yTp+bJNlLwMcCEVbCq9jvedmhqBbp0YwZjVW9A6crPr1I2SyurE/hAog21S?=
 =?us-ascii?Q?rFwGJOHvBu0KMBxgK18L3t/S5CZwOU3M1cbpcY5/LQFL76Ahfbl2Q3/L/W6A?=
 =?us-ascii?Q?ZJAEpt/aKOanUflCKvq60nUM2TxSLOzyNqujxZR1RSgMFXv8UE859MxNiYVE?=
 =?us-ascii?Q?8KvcQclVnhKZnR7Z61aJQlkz0YE7yagHHnrgII+OOpvL8bXLkh8x+fvetxvl?=
 =?us-ascii?Q?i7ChHQegiAAkLaTRLfabw3uGZLv3Gye3tKC13EoBvT2IjH8p7DmFhoZxnrIa?=
 =?us-ascii?Q?KruRfbgYoxkq9U27cqyfcDwCqOnAWb/+Hb/lZWCC9Lcsg4wBgH8yMmvs7EmX?=
 =?us-ascii?Q?ns3hD1iHqd14fkuFnddQbEFylkrcyZFLil1KBbeQYPPGqZJlpD4XQA8ZL6Yo?=
 =?us-ascii?Q?58zZyc4embZz6LWFvXg2NmOV/O9hAjwxTaLnE4O2ooz3Em2lrVuc+CXj6Sex?=
 =?us-ascii?Q?+OOIagYRrw/+gkFEzDVupA8RalTJ4pyLqSz2YI0+ahGZ6vc0ktOrCo6g9Hut?=
 =?us-ascii?Q?IKGs0ZCLNUBw/CJIhLJM0Zk7kGts1+HsKlXoW+q9hVsJK3XuDMF9RrUUEkba?=
 =?us-ascii?Q?MOCbmW4u9zAjuorqjhr0Tim7jHtbj9sICd30RRtBshmhAjMVtIlCjg7mkNhZ?=
 =?us-ascii?Q?qD7cw4VmgIc/bNt70jjWkJ5mRK4C1V4w/+cBmPwNBpAbnjjw66vQeM60KvXo?=
 =?us-ascii?Q?uBEiI08jnTSXWJTy0K0tArL5UhSR8BVU+aqss8dCCdKwiaiAPsuiwNyMDKi5?=
 =?us-ascii?Q?3hYJETKkxHU6+9CEtSXTO4zQEYQTU684MkwlzmG5JyQWxmU538C+v7J+3bcj?=
 =?us-ascii?Q?UF1x0DuAwmlCXlMEjExT2Zp2xvpq1HKVH51VY+VREmmf8zgcJcWOINVvNXHH?=
 =?us-ascii?Q?23lmXffdS8EVr87URcKWv2PTurh9TRAv8/8FHsBAgmG3DGHKTGWNliOKtaZb?=
 =?us-ascii?Q?7t69c7tOSudtfGB65kzKHHSBIoNOlfgzldUUS0U93ZteVdxq5oI5epyZ4Iv9?=
 =?us-ascii?Q?HYQc5TfqUhuCnhrginFv8fJG3752qgf3goQgp0CgjMAiEf/SxI70jYlKNzBq?=
 =?us-ascii?Q?9oMIBEiGgDhntIQWgWc3rzsNkw1MIhdOngcIDpcHE9XbGQlnX3ZaqPQw1WDT?=
 =?us-ascii?Q?fYXE169q4hPkb31v4+3zdtsnKr17pBMQAwfo28poGWYY15Z7am+EfMvRD2uO?=
 =?us-ascii?Q?2/gw/0aEHBYPVgMaw6TTFtwS7s5fhgR7adu+hopRcNc/qWwQXiAtrfpXLlhg?=
 =?us-ascii?Q?L6wB5Cdmkp1G35gznnzxf758+j98WzGgotsKptHIeJcmrmyF9/ry6UVn1vVB?=
 =?us-ascii?Q?cSrYmfbWD40DsCyjrPt26K3MhbX2kROFal+E0JNOtsz3TbQa2O5FAGXj4sS/?=
 =?us-ascii?Q?SIFeuQgqXLh9i76HP3c0gcfbtQPXDaNb60xBv3AVGclO1Nc24HKPcNCOd+bL?=
 =?us-ascii?Q?LtEuZhKvx+cCfr0Vf89K0MjzJ4Zb/Fg9z32hLkyRgrxAV4FON7Gf4/jBAO1y?=
 =?us-ascii?Q?c4MsZXgx+dHZFb119UI4+PDznaLtVCiH6MyY37AmK2ONowGDEY5RtrFX6e6j?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6N6d2R+FGZS+Ded0nvSdXEoS8W23cju8DayuWrM/dpG1gKm0oPi2cz5A+Kti?=
 =?us-ascii?Q?8HNc6wn8fKal8lG8tw4IX211U2zdD+TSfY2uvV1jItPjjqelWE6iuVMkwn/O?=
 =?us-ascii?Q?lA5c0fNK2WktiXMa15hUnaN2OLX1pPdgpRWLB7+ab69bTtA9ZMMUQTQpMT3m?=
 =?us-ascii?Q?xLy0SL2Q4wriiCK0gghZXhGTTcQqcbtcFd2vQSBswBfMPgJqbR+U6LlRBQLD?=
 =?us-ascii?Q?QXiaRcHtz4uDjHIo+aJw6VpT4/caFx1VIS9cmw/Q2Jb7S1V+XhcEaIoun899?=
 =?us-ascii?Q?Amv/iIRPN5DldFDd1r7FFuwYmzeBXQCicFYCmz0KcUF4oYw+nnKtsBnrLMzG?=
 =?us-ascii?Q?DkTo8YyX8jVZY3OlF3YBp6rRW1dcwHy65azzEaq4rChZPah845/gbLGj8flH?=
 =?us-ascii?Q?2N8+XAo1Qi/RT3WtBwodYtH3cywv0s2zS0WmjWAJMqlHubBRA0AqPWqDCHCr?=
 =?us-ascii?Q?AfmXCxetXQUsmoL4h4NL5gHKWFA3gMwYvgw8itf3rB+4GoAc4REnezxa2+D0?=
 =?us-ascii?Q?f4jYnnhfcaVZOJOCcSP5Ft5M7ggJR9o4lfOl2tOqtL3XAIs8zDC3P5yzfYIH?=
 =?us-ascii?Q?tm7NrubZqGH7jtSAqFAjw7zUS2YQSmwdi8ATNhjMjUDmIeShp+No21wiLi2q?=
 =?us-ascii?Q?/trrrde4tvfsVv+umIQc2mTNOlcLqNN7cyRCj8dan2fTBd8x4obftfdWDMED?=
 =?us-ascii?Q?PC5BhrUMyld1SwQx5rv8KVYDOmaDXKyXWwGDR1qz49K0f1K2uXUCFUORn8MS?=
 =?us-ascii?Q?aaGx2NK9z4HWCGXDb7olSIVbB/XaneEZdozUxqzqabCpJZTLu9JzMfukOB9a?=
 =?us-ascii?Q?4yHJB1eQfkIrqAQJkRZMcx6Cv5dp4JwayGe7BDfPgTuL6s1p8Z6IkPMG3sqK?=
 =?us-ascii?Q?dR71MRLnJ5ccX8l9D3UjRF7nKPYY5BwzKTkDrR6w8tzOCIQ1lJPk/kkXxiQ/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43eeb0d-62b0-4217-3e7d-08db4596f5c5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:27.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USK32S/vwbS5JgYh123LPFQnhNFJp06dCVmgqY2cURbe39Jb3iM8xxQyUqg+0nDogjJln7k4xbS5WqiqX7FV3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-GUID: 28P6BtvjL_-cDmSEjHX2Nd7mihE-pkLp
X-Proofpoint-ORIG-GUID: 28P6BtvjL_-cDmSEjHX2Nd7mihE-pkLp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the maple tree is inclusive in range, ensure that a range of 1
(min = max) works for searching for a gap in either direction, and make
sure the size is at least 1 but not larger than the delta between min
and max.

This commit also updates the testing.  Unfortunately there isn't a way
to safely update the tests and code without a test failure.

Suggested-by: Peng Zhang <zhangpeng.00@bytedance.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c      | 20 +++++++++++++-------
 lib/test_maple_tree.c | 27 ++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index fe6c9da6f2bd5..7370d7c12fe3b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5248,7 +5248,10 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 	unsigned long *pivots;
 	enum maple_type mt;
 
-	if (min >= max)
+	if (min > max)
+		return -EINVAL;
+
+	if (size == 0 || max - min < size - 1)
 		return -EINVAL;
 
 	if (mas_is_start(mas))
@@ -5303,7 +5306,10 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 {
 	struct maple_enode *last = mas->node;
 
-	if (min >= max)
+	if (min > max)
+		return -EINVAL;
+
+	if (size == 0 || max - min < size - 1)
 		return -EINVAL;
 
 	if (mas_is_start(mas)) {
@@ -5339,7 +5345,7 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 		return -EBUSY;
 
 	/* Trim the upper limit to the max. */
-	if (max <= mas->last)
+	if (max < mas->last)
 		mas->last = max;
 
 	mas->index = mas->last - size + 1;
@@ -6375,7 +6381,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, max - size);
+	MA_STATE(mas, mt, min, min);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
@@ -6395,7 +6401,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 retry:
 	mas.offset = 0;
 	mas.index = min;
-	mas.last = max - size;
+	mas.last = max - size + 1;
 	ret = mas_alloc(&mas, entry, size, startp);
 	if (mas_nomem(&mas, gfp))
 		goto retry;
@@ -6411,14 +6417,14 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, max - size);
+	MA_STATE(mas, mt, min, max - size + 1);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(mt_is_reserved(entry)))
 		return -EINVAL;
 
-	if (min >= max)
+	if (min > max)
 		return -EINVAL;
 
 	if (max < size - 1)
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 345eef526d8b0..7b2d19ad5934d 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -105,7 +105,7 @@ static noinline void __init check_mtree_alloc_rrange(struct maple_tree *mt,
 	unsigned long result = expected + 1;
 	int ret;
 
-	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end - 1,
+	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end,
 			GFP_KERNEL);
 	MT_BUG_ON(mt, ret != eret);
 	if (ret)
@@ -683,7 +683,7 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 		0,              /* Return value success. */
 
 		0x0,            /* Min */
-		0x565234AF1 << 12,    /* Max */
+		0x565234AF0 << 12,    /* Max */
 		0x3000,         /* Size */
 		0x565234AEE << 12,  /* max - 3. */
 		0,              /* Return value success. */
@@ -695,14 +695,14 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 		0,              /* Return value success. */
 
 		0x0,            /* Min */
-		0x7F36D510A << 12,    /* Max */
+		0x7F36D5109 << 12,    /* Max */
 		0x4000,         /* Size */
 		0x7F36D5106 << 12,    /* First rev hole of size 0x4000 */
 		0,              /* Return value success. */
 
 		/* Ascend test. */
 		0x0,
-		34148798629 << 12,
+		34148798628 << 12,
 		19 << 12,
 		34148797418 << 12,
 		0x0,
@@ -714,6 +714,12 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 		0x0,
 		-EBUSY,
 
+		/* Single space test. */
+		34148798725 << 12,
+		34148798725 << 12,
+		1 << 12,
+		34148798725 << 12,
+		0,
 	};
 
 	int i, range_count = ARRAY_SIZE(range);
@@ -762,9 +768,9 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 	mas_unlock(&mas);
 	for (i = 0; i < req_range_count; i += 5) {
 #if DEBUG_REV_RANGE
-		pr_debug("\tReverse request between %lu-%lu size %lu, should get %lu\n",
-				req_range[i] >> 12,
-				(req_range[i + 1] >> 12) - 1,
+		pr_debug("\tReverse request %d between %lu-%lu size %lu, should get %lu\n",
+				i, req_range[i] >> 12,
+				(req_range[i + 1] >> 12),
 				req_range[i+2] >> 12,
 				req_range[i+3] >> 12);
 #endif
@@ -883,6 +889,13 @@ static noinline void __init check_alloc_range(struct maple_tree *mt)
 		4503599618982063UL << 12,  /* Size */
 		34359052178 << 12,  /* Expected location */
 		-EBUSY,             /* Return failure. */
+
+		/* Test a single entry */
+		34148798648 << 12,		/* Min */
+		34148798648 << 12,		/* Max */
+		4096,			/* Size of 1 */
+		34148798648 << 12,	/* Location is the same as min/max */
+		0,			/* Success */
 	};
 	int i, range_count = ARRAY_SIZE(range);
 	int req_range_count = ARRAY_SIZE(req_range);
-- 
2.39.2

