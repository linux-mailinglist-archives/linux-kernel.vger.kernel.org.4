Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15190701109
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbjELVUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240535AbjELVUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:20:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811CA5FD7
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:20:35 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4SYB028694;
        Fri, 12 May 2023 18:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=1Q7wqf4ijKrU09WVtajX7KD9NtJGhpTDiMYTNaVpvaY=;
 b=PAl2fHrZwqBGlz3zR6AmaycDbWLYav4NF9ebkiDKn/3157doY+YKuLlQpuNlA8YIPEWB
 Q0NpBxAdxENYeMo5Gm+NEmG652klKO0HvnwQh0/ZGIFtF4MhxJQ14YJNuUnhEavJSBT2
 FUHB5dSJMu4GoRGKj1MFKTaoU2L9FaDbISoawonjUddtewrP0A8hEQDplO8gsHUyQrpz
 SqG4DL0VDRNtrog048V7des9dAsGPBz1f/9x03EmOw3B/xNfb/OYWUaSwj3vlafIszS5
 gmL8feWz/RxNlQBagBYU+vI6vWbKqLHp3caVB+CsXbbJBgBHPfscMhGi0fBjqnh8irQ9 wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77dknmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CHou3I011834;
        Fri, 12 May 2023 18:21:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8156yvt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KffMwL3Q2Hn/131z5HxGilOMV3T9ZpUuAz9sCxSdMeULkqdfcAarBMJoOLKeM9ODZ1SRtgcXKfEQBuxEOU7TYUvAystxii9Zq2V3L/4TD5NXc0cM/tySGAN6Cu8pvk+RuUu7gQv5kX96rbDu/uiZub4GLbcElyenONeEk47fxphXYsfe9xkOOYjYWGu6MhhJiMOvhQbEj7fzdYugxbtSmlqojwz0mk/nAONEX/Iu7Itor1V2foWcv7AV0dqt7+6VjdMyozficIp2pNV/san65vLZEIVJsDBUN5qXv/j6rKtQHkWNmTp2q/s00sMdCvu8KA+JHdmeFCKJNxwFx52fDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q7wqf4ijKrU09WVtajX7KD9NtJGhpTDiMYTNaVpvaY=;
 b=HUFUgu+BCloGz+FN8JBpzftY2M9sflO6bOQcSDu4V00m/1nhlIyWDb0FvtrYoEcprbfs2JYGU49gBp3yNGiE2NyQpzXfcyR6tvfIJ1xQtYEPviz9m0gMAgs4b86kSdM+Yxjw63t1LAm9dLKozZLhV2wNLdS38qlf63TzxPZ4Hgzye7TUdyXOgG6mdJXp76amHtSVdHDqrY/0SG3XWlh13c0/a9NOF8YYAh7YTmM+5TL8b3zWTQQKHhkUpk2PaAphK0CnUNRFcfp6ezq6R8Io7vYomfHMMn+kpc2nfmtBvU1S1uajh1QUhM29rrAseKiggn4X9R0w11IeQ7ArzzQi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q7wqf4ijKrU09WVtajX7KD9NtJGhpTDiMYTNaVpvaY=;
 b=Y5fcbGP+U80GUm0NXUxrxexOGY0mE2PZQQ4CjVQHiUR1Ulq6SCc2k+IobcxWH2Yn58JyrDQjxR2ag8X2ssyyrpOTd1QxHW2O0239S6AQHjfu7PWd5Z+4YKgXzqwUjQFokwD4KxyeeTF5XWD7j1EeTR/De0gETFtd+/AVfItNnds=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:21:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:42 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 20/35] maple_tree: Remove unnecessary check from mas_destroy()
Date:   Fri, 12 May 2023 14:20:21 -0400
Message-Id: <20230512182036.359030-21-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0054.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f0a56d-c222-4b5e-7b9f-08db5315bc2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXFtxbw8RVDxoBhZkZ/5pV6CBViYErX+vBycPcKG890rFuQzss3QHoODTu+EbwXmSL5fRyi05NUOpZe1pewpS7iQ1yD0PWCM5NWQZc4aJldf/iAW9fI+alfr9GDcwxXyHLo9pJdaxej2/uHagcprVxCJSHbTUeUyvgN+A1F+ZkB/Hih5cnPr/tqFb/+7NOkTiLL6s2nCdy8a21EfK8Wpx6FOFJsA550veeBX7WrcYmgpEGVezzMv5+V9C/yf2F8M4mIaOjxxD0d4kd/jQxdNGzEqotKfJ/nbn3Cz74RQWSWuLGAYZhYIn7/cHb5dwNaNXndYyrvJx8gwFlR9i7GGdRXGk+Mek2ih9aL1NzKzLQ4iENcRy6A2nB3om+xkZqogpgAB+Wwgl20aVP5jC7XXaotnRylfVvzM9zBDjLco5QvNaDPQmrcuCTg7i13Yu6ieblLEXqHzXm68NjnHoV9QGeHfscO6YO9ywJdZmHAqJyTquGbow1UJFFYlJ2RzNEFOBNSSlZkrCxUWI8PAIPKaJAmKul6PTNG0DP53iM/dLvqpEfEw++Fj0TTI96BAQIND
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(4744005)(6916009)(66946007)(54906003)(83380400001)(5660300002)(6486002)(316002)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LltO/dmXcXP397/OWer8c0Q6efunBrIPIEOy9daJKMLXp8+atSNJlWmMWpvD?=
 =?us-ascii?Q?R8ZWbKNWFOv5+5dkXUIBC3decWhhpY1QYHFxcTVbNlhX2aJ8CiG5KqMXdQEw?=
 =?us-ascii?Q?nwIlITU42MdQu1RSpU/B9c+hS/h37X9A4dW+BiucLP8L9TAy1q6qZP18DQD+?=
 =?us-ascii?Q?ramY7U8aUKRJsIgt0pHKY69SJhECzO3IApiP+L+pqAENjHqKF/ivd466DN5n?=
 =?us-ascii?Q?bDuG539tPHdiCYiOiyBoyMqhzRXeH1zyGuM6FaW5rEGW/f08qZrDhmc7NYxG?=
 =?us-ascii?Q?4QTBQuGH0Uvt1TqgMAKb/q4akO2KQ0H/feLorKk6Xh75QCZrX+8u215TCoaS?=
 =?us-ascii?Q?cZFFxo6LlRUqFxfbX2uxph8aZ5ahoqpzlzT3he1RtRSynj24iRS2l697ZQbB?=
 =?us-ascii?Q?pSg/Q26VWbdPaeQYMYIwLMLVKakYK/6VJk7icQaIwfMChxedhDmFAdCcTQT1?=
 =?us-ascii?Q?K4yNW47DTZhZNf8lvFxWx7cNkZn3sGT/tfuJl0dXGCZo1Oi/PNd7nKyKfvv4?=
 =?us-ascii?Q?0+Q9lbLmXuPFmYI5Hys7CoA96JbuwRVUItemE0lCg6e+6WouODiyuqadzWr/?=
 =?us-ascii?Q?M2jEF8tliPrsdDogNzoAkaeNy8XrdBeul8A4E77tbuXA6lYscjqpvjZ5Pi0B?=
 =?us-ascii?Q?xhXLln5MibSsxvf+QsPTgTuOw7uAyMb9nnP0v9BHlFn8U0tdqlkqkFmnVh83?=
 =?us-ascii?Q?dbjx33bh9kGA8WSv3vba985vjaLk6hKTa7bOCvyDC0mTzZcpx1vU3cumXYe8?=
 =?us-ascii?Q?ZPUqo37dFkcFkMzZKXm4EuCBUuSsohwShmqEhHINM+X6btMt4Dlhjp9WMBbd?=
 =?us-ascii?Q?j+F9H4kx+AAZS+Pa2YjtYMxeOVujfRGLnJiJWx8sHUTz9H5+FL9qn5t8MbjY?=
 =?us-ascii?Q?l2h29trB8Ws6OlBle4wiHvbDC2Nn8aKoQHcXRbGJ3e0LwFb3gERA0FVNF7eM?=
 =?us-ascii?Q?V2iAH/WyBNyCQ1B8QyjwpSQhiBS5yRXb1A0wM+x4U3Y33IR9jENncPJCsm0i?=
 =?us-ascii?Q?hO84jQFV6pjj2E6vAqOQNZGFkX+7eDUlVOpY4Du9UQFLW4117Mgxq4KxoGRn?=
 =?us-ascii?Q?RnJ9ZGT71fmop7YbOUTKlTHDhgKng/0GhgcTE02usdf9SRSYiWsophtBkifQ?=
 =?us-ascii?Q?AUV9+caYCn1yHA3SRizRHgIsjxEJ1PHtWlCNPFd3yEs00Gn02rrXCXExN5ZP?=
 =?us-ascii?Q?EiqVmSwReFg6JOS73QPSVkSlgWIgLHujhcJuzMLsh0dQqBXRg1SzkyQIcWcK?=
 =?us-ascii?Q?crw0w6WxOjlWpGYpY66ZBeajI6gV0sGfwtBw30+1qPVBp1vczYWrgE6udUus?=
 =?us-ascii?Q?+zexY5obx26nCtC3Rhqy7wX5ibrn9FwXs1AbE5RT3ZzAeeWJ3+IZSwXYl8UX?=
 =?us-ascii?Q?ohKqpOeof9rUAvENpdSHaXniaQJ5PJMyA5311KVOqmK6QUlMA9whvuM1vJQF?=
 =?us-ascii?Q?9QJ4ukT9iNzVCifg3H0KdMxHhSlNLrGFdK8jlP3N2HO8i0qJWo7PsEUy0BbR?=
 =?us-ascii?Q?e3gEHxN8+R/ql0wc1MYxbn2tnZdwFtzYEUDKNMpdCsHK2FJkgijMsXY3pBtW?=
 =?us-ascii?Q?LojVbsZRD8yAlXJQk3aSZ7E3kZvnSP2w3Myf8Yzi5veYn3FGIF+b9blg+8oj?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Eh+yf1k9kOD/xKcj/u93ghdkffYiSXdertA5gPeXuR4RGK1d+Tr5YPOqWhd9?=
 =?us-ascii?Q?Nz9yTaV4sDzwHdiDpu3bOrOttn/pljejxX0jCbpq4RFInnsL0jUPy8ueRGUl?=
 =?us-ascii?Q?7uePE/BQql1okkjCOUsjZ2p2PaJ/7GT7m8TsvXnLPTMvMuzPe6kRHfAGhB8E?=
 =?us-ascii?Q?ZkuHg5IEfi0B6FE24Gtswg5eJyRV8TZG8/Jj75c11uTU52b1mtQ/7b2uu5yQ?=
 =?us-ascii?Q?BmbcYQdrYRDwgadhhLKPHFLnDK64/QObpdI5HXDY1FFsWizUSyxfW9VVRek+?=
 =?us-ascii?Q?ia0fx+Y5RUmSXG+C5qXifGm0HNfECKmfGSpdT+AML2YaU2jRqC06u5b4y/aX?=
 =?us-ascii?Q?dX/wV2aS+jD6BX3FJnSc7xjn528Jn+oBtiuu0a+uOadddDt/7LBljQX3tcND?=
 =?us-ascii?Q?5YruDWQPCtzowAt99SgfKqb5gd0ATcxadycRWzjqPgSDq4vW1Iglt6ZfeK9t?=
 =?us-ascii?Q?ljzyTdkf1sWCxyaxdOxIVGJo8ep7VyJ8kvgs9j+O7unSNcxT/9NcObaVkg7w?=
 =?us-ascii?Q?vJCXsOW/ybbCLkJ9k93sS7T1YqH6gGYZNuvGX3FUlS8WOdZoCSRoRIsoc+Qs?=
 =?us-ascii?Q?DQDlrObbl8oxP94HPsJ8V065ibA7fH8DAKMF8s85y3wayTCft6ap1kRqrtBf?=
 =?us-ascii?Q?wNw3VlAO0BiK/3PPECPGuyWXuNIeT9oQLHSPXr/kAKXWR/8lm0/+o0Sk/a7y?=
 =?us-ascii?Q?fWymw04VdhoZvTjHAqTx9O6tQfNXG6fYumXG83gH4eKFuoHyoN+wmHkneCJb?=
 =?us-ascii?Q?x6VvGDmclQXrHk/N6tRif/5M6Ktb3ptBmbC+O1lPJgVYdhFikHMjyweRyMEN?=
 =?us-ascii?Q?3kHpwK35vzIllaN4ldvYDt7khCUz3HIF9rePlaKxqWBU+gIMZ7joxoIs2nwN?=
 =?us-ascii?Q?R6ytISPPLa2YK/bsYNEfd7TQs/vJM6GWMU/IGwtywrBfODUhTZZaZbvmYymC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f0a56d-c222-4b5e-7b9f-08db5315bc2c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:42.0531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrkK9PWylWvmgvm+l0ikyjt03AZ2dOF+5JZRDu7sv2+1p1kA5+f3AIZs5uR1AUQnut3ZRHwNQINE6M7IRYHARg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-ORIG-GUID: i7Lm6OokkYgwRAHttKLOpwicgTT2viKb
X-Proofpoint-GUID: i7Lm6OokkYgwRAHttKLOpwicgTT2viKb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_destroy currently checks if mas->node is MAS_START prior to calling
mas_start(), but this is unnecessary as mas_start() will do nothing if
the node is anything but MAS_START.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9f3784f4a5b7c..b3e5ae43ff8ff 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5816,9 +5816,7 @@ void mas_destroy(struct ma_state *mas)
 	if (mas->mas_flags & MA_STATE_REBALANCE) {
 		unsigned char end;
 
-		if (mas_is_start(mas))
-			mas_start(mas);
-
+		mas_start(mas);
 		mtree_range_walk(mas);
 		end = mas_data_end(mas) + 1;
 		if (end < mt_min_slot_count(mas->node) - 1)
-- 
2.39.2

