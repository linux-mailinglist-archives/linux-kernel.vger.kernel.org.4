Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705F0700E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbjELSVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbjELSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:21:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541E830F0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4h4e027779;
        Fri, 12 May 2023 18:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=S58ESfS5JJYWB2ZAlQ3vKg+/QpLNdflt2UxDlEU9y5Y=;
 b=Oli02A2o4blnw7+PE0DbRYLdPs6+Sd+aTAdS1R1yh1jeAX+/vI3ycxHxZZ+c1InJGpyt
 nDCUq9O18vln0RmgUJNv8ApEIyIU/lnQ6/IkjiQYtOsYQ7L13cuJOyH74D9YotA7JJSe
 NynU1XQD3nc+v7up5bEv3J0qsdrAKt3RWyLB41uAR7ec1ATqMKwbXLUx7S6dEcsdyhkC
 K4zI9XgBJWHT3odrQ+8qdcP8GA0r6Fvjv9t5lxvlRf3f1uNkecw0D8rJawKzlQA0OqSA
 IM9GOPz5rhEuo0e/KaO4oa5mekYr4gdYzxq6mlp6TB/qNbFFrZaFO8P31WVOK1bjNtSA zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77cbpqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:20:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CHoFWh004627;
        Fri, 12 May 2023 18:20:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pnt4vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:20:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bK+9B9bNWRufEtHw+70qgphRiu15SY9A5YHUxV39xG5dqMU6kZPq/Hi1fTOBDy+oFKBGYjGsngUG6wNO2JP5hDyikarKLdRZMmL3wUXFjhndyog7S8f2GEZDf9643+afz3Wba67XAnbeSziKd41/QnXDC0k0v+bIfdgoVQvOHNFjWzXqxIjoTyCfjVfrPupRHEYEtJsqLq50/oo130EPDwNpB76So3EbJrshvpsGXWTbE8Zo2ZJVLuKyvuvxdS1bZEhgzzIWFysWmxHDcaunfgYbJeimY9Q9EZtyUiUTMgYOdKsOjyJP/ecfJwqB/QVrtXAf0/Rw1Lu2i26/Vow+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S58ESfS5JJYWB2ZAlQ3vKg+/QpLNdflt2UxDlEU9y5Y=;
 b=EmVNaFOEPataXDeKZY0YVka5GjSRcu8swzCJVabtuz2VtHu59M0a8BhNKFh591BmEwO9rOE5j4yS2SvSAvJvPozGCvNUlg12kE1BuqWl+XJb13TOMCjEq8D/m6bWgq2081LYauKDoF+lVdSavSiONqmh4+DCHwUuF/MU6YLkPlTSkJIvY2I/53ZjPh5NUaETdJ7hSzm9lv3O29eIwQsduCgGgqAUeT66Z8u8hSc1MJaYeImwf4F9FOBvzF3o55maHf94UtxkrCIUc2tUVRCOwaI2YicYwPWD292lNUn6faDQfFz0vNoQ6HKFrb6BvPfun23DkscgDzEjXeJAF3CsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S58ESfS5JJYWB2ZAlQ3vKg+/QpLNdflt2UxDlEU9y5Y=;
 b=EcGHaxjTio0pzOzukWbRzvg7Bm8vRS1enZcxyrqP3u7C3uiQfExHUOAIMMnpPitt2duidUezAcqK4wImz3DKV/h1u2ZZL/jNqNHAFrFy/NN1ztYKekpZRfhUxaW0xZSRcNRF1D+aV3a+d0jYUSkaLAfTwmvwUA8tlci6xiIQBLQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:20:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:20:54 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 02/35] maple_tree: Clean up mas_parent_enum() and rename to mas_parent_type()
Date:   Fri, 12 May 2023 14:20:03 -0400
Message-Id: <20230512182036.359030-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0064.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e14c62a-a8d5-4fae-d0c2-08db53159fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9oXPyXynB/djRa0ML1tHidbU4NqPUoOeV6K8KEuqBxRKTXWNDXn66OcFoJaUHnDwsCBVjrVitkIPlAOmTmXI9Z6ZOCgRuTIqrWk15GOpTBH0SpIlAgPyh5/1Sq3mvXyR99oy44DWE5P/ga7w4niDpKkAMiCgnreWHHOnbo2NSGrCLmJpggKDZWj+A+ySfnDeWs1LgMqnXLmjIJfsKwXXhfTuvhQeefNKKbKeFF1oo531Bsxt+X4R6hFO2xz0iCEqhhQKu3mCVOOWh/quvDhGlTvNo/zxVEobtdmCl0Ndbs5tp7zuTQfvCc+gw+cZXQO38/8VQaBAHsYZwblnNrWTMtk5Nr52k5DiHqrQdb+nvxFg4ihvu5Q7l7YCupz8ueqpVFk9qkfcd3vPqRnLtqaut+LejLIOH9cV7TKtkEplH79u+0tSWfpSgTFT0hICWgUT4r4yBHQydcPApIYPhzBwCqQNnHkG9L8W4SQPrfSbfgSwmsWvNc/kEE/5Z0KWqluul5oSLMrz4FKy+pFz/zpOr1dVXgbCjxz/82MoKzKxN3F/Hqc4PpBr6ljB7tS6w8CA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(2906002)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(107886003)(54906003)(1076003)(86362001)(6666004)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kRoK3sDkohgFSf/Z0W9b6zc3hq2VIzuyJFvVdyeuDo04qkQfXzsj/3XPjmQA?=
 =?us-ascii?Q?HqlBF/jwLnAM9WgKSWbyMNDjVpwWABXicq/s0ESH+V/CSkVFr0J32w/WZZNZ?=
 =?us-ascii?Q?dWbFMjvqOYikHUlojLgboLqinA0eCtzDy5JGB3LSApR0VdLUnbCY6emk00yb?=
 =?us-ascii?Q?7fPE5ihmNouqfEcFjvyoMs7mcyZ4TGM7hJMAOvCY3wCqbIAVPCR40IImgFWD?=
 =?us-ascii?Q?jZy5Hy07PPmZqRq3CiCpSIkdflRs7UnK9i4mKgiKYEvrVkIcItIA4GoJHh7E?=
 =?us-ascii?Q?fEZA1hqlShPUeZm9ERcBjS6pJJPP/6ZLApVwy3IGeVc3Qwv4L7ai+GiNYcSP?=
 =?us-ascii?Q?L3v68seJl5Yc/NY3vQ7PPWAKQR7F5mhjSrnlE8xT25VaG1AFwb3m++ON3QXe?=
 =?us-ascii?Q?UsWvw+rnjIDxmDMWPzmunKiK8hoWwaGgD8F82Xj7wXmGpORJ6rkcoBXBD1a3?=
 =?us-ascii?Q?WNf6G6fZiuPZXvLq0ZT0sf9Iu8suJQhLnKJpolYFOi/oTpdyoWGEj+zZWpuY?=
 =?us-ascii?Q?vAQHrKNHeK99CUuugGc6MHPmETkoJfKAP9lAMcRNKABi+NztSxTqQ3CdJbxT?=
 =?us-ascii?Q?4TbHpPXFz1lXS2L+RIqHCQC7QJ7bPY+lXKmUIoH0SHeIKd+Fj5YGBtILNnKb?=
 =?us-ascii?Q?WF3W/In7q1P4MAINzSeIPliatCrSIw9si5W7UoDprBpDSX9DUuxY4cQMGFe7?=
 =?us-ascii?Q?llF9XAqzc5PUo6qUr8x1S5cm/50FTxH1JgLA+4DYfG4L9zumcEayF8mOtI3p?=
 =?us-ascii?Q?8R+N5ZOPBwwb16G6/ltJ/LJLrtbCfsTB3+6albvqac7O4hXphUGT2nsq4wFP?=
 =?us-ascii?Q?FynMqWd1xdyqFeP/ABPoLVnH0n9CYghLHFwEf4ZYTSLO6FoQNGoPyxIfKgNs?=
 =?us-ascii?Q?McUmfejh79ZITiiT9FvrC8ukGF9fNCC6E95RhVCVvGNyMZN1TiFYFJPgvE/z?=
 =?us-ascii?Q?+9KIRBIx+iSaLzoTdcnhDt7owS0vh97YqV6PoWxFUxhdlydKfis4r0WeOpZo?=
 =?us-ascii?Q?U7syTBgnZIStBnVppxp+8sqMjnpprd+76aJFVgL14q74wummUoGNVyfGopOC?=
 =?us-ascii?Q?ReqHOJOi28NhOh4y8zOf61vXKCwpfGoOgKg3C5He+b57qsUHGoKDhDbAth08?=
 =?us-ascii?Q?pvMdzKoeTmQphiM1vpiPm9CnqnTVfr8GPkOM6fmJnwT5L+iqHYw1COdT24hE?=
 =?us-ascii?Q?1NrnDXiEFeU5PQ/BzXnGtPaHplvPVh6SW8rUq0TxbXYhRiF9LLRgCzvCzlgn?=
 =?us-ascii?Q?4To+UB/ZDTrQ2jkgciZsrwLpsO8SORT/YY0/RrNcAZ95+KzG4gak+zV96Bki?=
 =?us-ascii?Q?kbzUQocwiGByLr6HReIu5W4CddHGTrU/RGEUK2C8Yhi/0NHyuX9DmuZAvNaP?=
 =?us-ascii?Q?gsoWq942OtTQHqZQTYxbNhaZWPY9Jk6voAfESahZfX5nr8hM1DULxGpKv50d?=
 =?us-ascii?Q?Q65QTefoE7avjQiMIKwMOFJCg69WebrErWv+nHAvAfaKVwW1dQu6nFo5QUoR?=
 =?us-ascii?Q?9WK2OToGnmqgmE4TjBRJWbukHRdpfWk1euIPHQH37j2M1pOxYxwRZFW2voJd?=
 =?us-ascii?Q?8hyy9JAYzitjHRvRv9rY7gjwOvuoQet41Y7A59Pxg6MI5ewfn3EKepKWrMq5?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f0gDQYlRXC350M9ZutpzcHPm+U3VXGBz0nGw6jCXzS3sWWeP3tq5RwaWpNseJZQo50MAOHECvVoxsio/BgIWO84dmxcpqe3orWfgw94yvYdqlq1NJOwJwupCM3zD/Z7mRCCNKPK1er6D9rwdenN8Pznuc+x7hp9pKvL1E1DcU9PY4ZdXStxg0UQnDs12dbaUrBQYqJ/SOy/Hzps121pQ37QUSNiQ2DFIEfcYVIpXEP5TSvYp9sg0IcB+AtTIwnnX/J6z8JtUJeqifgh6BVDA4HRdoaIKxkNDwmXXK0Y/DqbAy5BKgpGT7h7CCo+U2GOl9fLMJDYOXX1IHZ5aBFM2c+SWntU9VXTw38Ot4ySAg9sO3yM7PexkNAwuuYN225xm6e9x1w0Vt4TnTwcfy7H8We4AHHp6O6INjJxqIdjUGj+MDUjF6wNAldyQDPoVlKW52hVrTH50I0bxPMa3wU3Y27sJAm6Grfv1h8b1XLxC2voQWeP1LhwxTAbSPLx5Mxv8tZBjwrAXawoLsGKwV5yIdl0YaAq5eHEXYOckR9KmXcZ6X6n2fBmImP8QKxkekp1qTic9OBC3h6ogeALD1m1Kxr/jJn1zpAX8aHuG1iN9GGOXMF97JXo3tn5zLLLUw+0L1pazzpZ59sEK25UuKR5jCsSXNkhwIupYjigw7eK2i9NKypscHNXp0caZ4rcP5M4o8zsWafAY8vX/b6eD/O2d7L6cmJyXPJ+A39D7WmjIfQ5g3UteZcdoxOFj5ZvW5IQJSGOCS5kCahVplDRXIny/u88atnoXlGAoqWm1ktFgqNJqSOLGedVQ2UZlHoxurR4RNxIw/DRIQ9j6G//MgemIMUOZ1DkMVGjDpGEbIhS0DPm+dyeqvViJJ1uuX2MmYFG1B1mIlxaaGn8LcOiXZLQK+MqsbDMniQ7OywqlTMUA/1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e14c62a-a8d5-4fae-d0c2-08db53159fe1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:20:54.5939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+rpV6GZI18ERHt8P0bJtyj3w0CK83ZjiOQv7i9qXXsCoPJNbDiM2fT9FDrW6Ft0TfLUYGe7hrd94EgPtaPHOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: lDwKj8YGpx7yMfUqFNNvn9aT9O07jC-l
X-Proofpoint-ORIG-GUID: lDwKj8YGpx7yMfUqFNNvn9aT9O07jC-l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mas_parent_enum() is a simple wrapper for mte_parent_enum() which is
only called from that wrapper.  Remove the wrapper and inline
mte_parent_enum() into mas_parent_enum().

At the same time, clean up the bit masking of the root pointer since it
cannot be set by the time the bit masking occurs.  Change the check on
the root bit to a WARN_ON(), and fix the verification code to not
trigger the WARN_ON() before checking if the node is root.

Align the name to mas_parent_type() since mas_node_type() exists
already.

Reported-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/maple_tree.c | 50 +++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9cf4fca42310c..555de3a8343e1 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -425,28 +425,26 @@ static inline unsigned long mte_parent_slot_mask(unsigned long parent)
 }
 
 /*
- * mas_parent_enum() - Return the maple_type of the parent from the stored
+ * mas_parent_type() - Return the maple_type of the parent from the stored
  * parent type.
  * @mas: The maple state
- * @node: The maple_enode to extract the parent's enum
+ * @enode: The maple_enode to extract the parent's enum
  * Return: The node->parent maple_type
  */
 static inline
-enum maple_type mte_parent_enum(struct maple_enode *p_enode,
-				struct maple_tree *mt)
+enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
 {
 	unsigned long p_type;
 
-	p_type = (unsigned long)p_enode;
-	if (p_type & MAPLE_PARENT_ROOT)
-		return 0; /* Validated in the caller. */
+	p_type = (unsigned long)mte_to_node(enode)->parent;
+	if (WARN_ON(p_type & MAPLE_PARENT_ROOT))
+		return 0;
 
 	p_type &= MAPLE_NODE_MASK;
-	p_type = p_type & ~(MAPLE_PARENT_ROOT | mte_parent_slot_mask(p_type));
-
+	p_type &= ~mte_parent_slot_mask(p_type);
 	switch (p_type) {
 	case MAPLE_PARENT_RANGE64: /* or MAPLE_PARENT_ARANGE64 */
-		if (mt_is_alloc(mt))
+		if (mt_is_alloc(mas->tree))
 			return maple_arange_64;
 		return maple_range_64;
 	}
@@ -454,12 +452,6 @@ enum maple_type mte_parent_enum(struct maple_enode *p_enode,
 	return 0;
 }
 
-static inline
-enum maple_type mas_parent_enum(struct ma_state *mas, struct maple_enode *enode)
-{
-	return mte_parent_enum(ma_enode_ptr(mte_to_node(enode)->parent), mas->tree);
-}
-
 /*
  * mte_set_parent() - Set the parent node and encode the slot
  * @enode: The encoded maple node.
@@ -1123,7 +1115,7 @@ static int mas_ascend(struct ma_state *mas)
 	p_node = mte_parent(mas->node);
 	if (unlikely(a_node == p_node))
 		return 1;
-	a_type = mas_parent_enum(mas, mas->node);
+	a_type = mas_parent_type(mas, mas->node);
 	offset = mte_parent_slot(mas->node);
 	a_enode = mt_mk_node(p_node, a_type);
 
@@ -1144,7 +1136,7 @@ static int mas_ascend(struct ma_state *mas)
 	max = ULONG_MAX;
 	do {
 		p_enode = a_enode;
-		a_type = mas_parent_enum(mas, p_enode);
+		a_type = mas_parent_type(mas, p_enode);
 		a_node = mte_parent(p_enode);
 		a_slot = mte_parent_slot(p_enode);
 		a_enode = mt_mk_node(a_node, a_type);
@@ -1659,7 +1651,7 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
 	enum maple_type pmt;
 
 	pnode = mte_parent(mas->node);
-	pmt = mas_parent_enum(mas, mas->node);
+	pmt = mas_parent_type(mas, mas->node);
 	penode = mt_mk_node(pnode, pmt);
 	pgaps = ma_gaps(pnode, pmt);
 
@@ -1691,7 +1683,7 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
 
 	/* Go to the parent node. */
 	pnode = mte_parent(penode);
-	pmt = mas_parent_enum(mas, penode);
+	pmt = mas_parent_type(mas, penode);
 	pgaps = ma_gaps(pnode, pmt);
 	offset = mte_parent_slot(penode);
 	penode = mt_mk_node(pnode, pmt);
@@ -1718,7 +1710,7 @@ static inline void mas_update_gap(struct ma_state *mas)
 
 	pslot = mte_parent_slot(mas->node);
 	p_gap = ma_gaps(mte_parent(mas->node),
-			mas_parent_enum(mas, mas->node))[pslot];
+			mas_parent_type(mas, mas->node))[pslot];
 
 	if (p_gap != max_gap)
 		mas_parent_gap(mas, pslot, max_gap);
@@ -1767,7 +1759,7 @@ static inline void mas_replace(struct ma_state *mas, bool advanced)
 	} else {
 		offset = mte_parent_slot(mas->node);
 		slots = ma_slots(mte_parent(mas->node),
-				 mas_parent_enum(mas, mas->node));
+				 mas_parent_type(mas, mas->node));
 		old_enode = mas_slot_locked(mas, slots, offset);
 	}
 
@@ -3251,7 +3243,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 	l_mas.max = l_pivs[split];
 	mas->min = l_mas.max + 1;
 	eparent = mt_mk_node(mte_parent(l_mas.node),
-			     mas_parent_enum(&l_mas, l_mas.node));
+			     mas_parent_type(&l_mas, l_mas.node));
 	tmp += end;
 	if (!in_rcu) {
 		unsigned char max_p = mt_pivots[mt];
@@ -3294,7 +3286,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 
 	/* replace parent. */
 	offset = mte_parent_slot(mas->node);
-	mt = mas_parent_enum(&l_mas, l_mas.node);
+	mt = mas_parent_type(&l_mas, l_mas.node);
 	parent = mas_pop_node(mas);
 	slots = ma_slots(parent, mt);
 	pivs = ma_pivots(parent, mt);
@@ -6995,27 +6987,29 @@ static void mas_validate_gaps(struct ma_state *mas)
 	p_slot = mte_parent_slot(mas->node);
 	p_mn = mte_parent(mte);
 	MT_BUG_ON(mas->tree, max_gap > mas->max);
-	if (ma_gaps(p_mn, mas_parent_enum(mas, mte))[p_slot] != max_gap) {
+	if (ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap) {
 		pr_err("gap %p[%u] != %lu\n", p_mn, p_slot, max_gap);
 		mt_dump(mas->tree);
 	}
 
 	MT_BUG_ON(mas->tree,
-		  ma_gaps(p_mn, mas_parent_enum(mas, mte))[p_slot] != max_gap);
+		  ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap);
 }
 
 static void mas_validate_parent_slot(struct ma_state *mas)
 {
 	struct maple_node *parent;
 	struct maple_enode *node;
-	enum maple_type p_type = mas_parent_enum(mas, mas->node);
-	unsigned char p_slot = mte_parent_slot(mas->node);
+	enum maple_type p_type;
+	unsigned char p_slot;
 	void __rcu **slots;
 	int i;
 
 	if (mte_is_root(mas->node))
 		return;
 
+	p_slot = mte_parent_slot(mas->node);
+	p_type = mas_parent_type(mas, mas->node);
 	parent = mte_parent(mas->node);
 	slots = ma_slots(parent, p_type);
 	MT_BUG_ON(mas->tree, mas_mn(mas) == parent);
-- 
2.39.2

