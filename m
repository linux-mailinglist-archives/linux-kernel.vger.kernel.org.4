Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC14C742F66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjF2VTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjF2VTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:19:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F84A2;
        Thu, 29 Jun 2023 14:19:02 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ3ooG000846;
        Thu, 29 Jun 2023 21:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=xJbf8guuOrmIYOlfYR/rb+OdjdA8izXf9Ay1RhJFQBE=;
 b=sjMcNhM1cc6FlxB8EJEOJGxEU0UF939qcFjTZqbcrzQNM7JXFs424blLeFyeVQMNjdtK
 TzEXujNpJnzx6hsg61vFQRcIEbEWF9h1quMHD24429QE7avht9rqSesNej2lACIulWYx
 6DFq63goH7HwvGvKygWMTbMTTqvzM83ye7lddmqeI9vh1b9EITTN75U8a64thtvpSuCT
 scJdtAYnOkxQKBvbhv99HmXycK4Vy/ijf4rCaOQRG/sAfo1x8R116Evxeaymq3lb3y3U
 JtCzFmfCe5FPqH7tJUMyX1JF3dvCzUONPDztr4aBQdVUiml76SoUzO34Bqdm5NlhfSXA Yg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrhcxa14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 21:18:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJZU7L038172;
        Thu, 29 Jun 2023 21:18:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxefraj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 21:18:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C60MCitLfK9XH5PC48THx+c5QMRlwoZLo2zDRFMC0RlC77f3fuLq/mGECC5o0o1TUXTzEC8PYJrixtdc0EWD6CGoucbG7DLBy5YIY2kZvHm6HwgzSN2mFuoPSTKkieBDMx8IU+gdzbc3xCkM8uNzWIUmEic8SoG2EfysdZRViutmiKTtmfZeRM+aOoIikEzAxtSqUdo7+U2koKumHb4Ag4RafLGxEyvWdA+MXPbyZ+LegJjlMz9k1Yp5AXQvHueYPwTKjFaxpTwlmLtTB2pydHXw5+Ujo1+loyF7xG1Bp/0jnH2ONaSPRNnVJPtLojY4KqbDjs6Sd1RF7yRakRAXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJbf8guuOrmIYOlfYR/rb+OdjdA8izXf9Ay1RhJFQBE=;
 b=QYnXHcxgUYn571Mbg/5d4uuciIbBXve+JO0fGgnbBPtTXWAJWX6JRORgNGJHzwTKczJApLQ1DLpjmIHaBVtXVjMeQ3gjpC4gRsXc4kbzrqO1q7mRCuk6Ct4jnY3lX/UpB/GmuGrDYo+7ypFWtXCr0O081G6gF0c857q+64bX9SJUwanVfMsFYJwxlzGr4hCjNyarsjSwLbVDOp1QuVFZZxHtMvJKNadDEECa9D6HCtfCZGaAzYGUKCihVwyedidIhaxwBjLWEbxAtcBUDdJ6RTjaC/8nhokQ+lLdyOYYaXsyLa6mB6UDam6kjB9rsGFSWdomggUhcxqy6IWkoBnB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJbf8guuOrmIYOlfYR/rb+OdjdA8izXf9Ay1RhJFQBE=;
 b=VGv6kY5g/MtP0Hsz1yWCI5Yj9OES1n8FD/ta7DV4R01o4royg+b3DjnsTFfoXydc8ydcXa3IE+9tfEn+z8kwUs+HEwC5pfQJD594BkXxi3ECmDMZtGfulohlc0GhaSO7OTutcNGd28DbCcf4Kyg7lQ1IiiapBXSr0ZXvuIv4oWI=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB5033.namprd10.prod.outlook.com (2603:10b6:610:c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 21:18:47 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6544.012; Thu, 29 Jun 2023
 21:18:47 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     songmuchun@bytedance.com, mike.kravetz@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Ackerley Tng <ackerleytng@google.com>
Subject: [PATCH 6.3.y] mm/hugetlb: revert use of page_cache_next_miss()
Date:   Thu, 29 Jun 2023 17:18:17 -0400
Message-ID: <20230629211817.194786-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::13) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: 19139f9b-03e8-4a94-388c-08db78e66d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6kmovwgtJtkfbr5MBDJZ2D1Fkb7TISX/OkLS6HJvo5uiD0MCngaqUHVdkCrUy84Uu+ThR0uUT5MkOLHwkhFbngv82NFln3o7vvKvkweJB7YlkHe7/IgBlPmHZ/fiU+BRjK7YnM4sr9znpCewRpClVpli60zQ4RZuqBJObT0QXMpcW3lKsqDl/RgHkXuq4vdpQYUmXihjDeK/khJw0yaQaBG8llQqY6UnsKjzoiAyi+zTx55lmMkniemZIFv0iiyOQgVXtPe+i5akk07664VAtdPqIkrL7EAhi+9c0QtyMWdHhuBlUk4akVNrM1r5ZrPuAIku+fWMNHJmiAQzYNNJVdbR8eQ8zIaY3w0JhyUqNPItI+DKOilgO8EgYQreHr3Mw9NyXS9Qt4tJujww4ntujfiLSQ5OSTTzNvExfGX9LhOc4P4awWflS4/MeK1G0w7iSOC1MUN2H9Knv0rJmjb9YcjXtdAOhDjsNCTYJCrtXSQQ5NyNanoO0/6bM+Vk2VRt8tEitUSAP+HEgJQC1mnJlk0N6YDBy3YS8PPmzRUB+0ZSx0ivC7Pw/61ZWuoRjs7PVZiJMYOHXbZTRoz0S7ZWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(66946007)(4326008)(66476007)(66556008)(41300700001)(54906003)(8936002)(8676002)(478600001)(5660300002)(44832011)(316002)(38100700002)(6486002)(6666004)(86362001)(6512007)(966005)(2906002)(36756003)(2616005)(6506007)(1076003)(26005)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l5Rn25LBOcvb1bEAJUatTNdyu9BQTqpRYE28RziaSGTEJZ+kvkoUjg0U7Tlj?=
 =?us-ascii?Q?/xL960v0Du09FbdZlSzvaBRDV8sU7v6x9GdnJgru2sWMYq4ymZn0lh6Hn7aO?=
 =?us-ascii?Q?bnlUlgwIv6ZQoyqjuYTWNkwOfwlK2Ew/tAIfYb2pgvw51LVciQ03PEEZijaH?=
 =?us-ascii?Q?1l3RqLfZxkZeOPOhvio+xjKVTzsUTjH5bHgeYLbX4iWZEhjVOQw4j8DgIEB0?=
 =?us-ascii?Q?MgsJU478eUjxes3nA2sS4PukIj0WOs2l6KDxhWUs+qCFBxkinNth8/mKYq6C?=
 =?us-ascii?Q?jaOb1mx0MuWsR+jQkR87OcpUE/ApOI+Px2QVPtc9XvIWhZVFIf5KGe7Rafg0?=
 =?us-ascii?Q?oum1JQ+3+6JaA1faVduQ88zqxLpHGJA//JFToV6T7KXlW0mV11uL8U9SuBYS?=
 =?us-ascii?Q?6sKVsmJZfPEg7NHfWgsGAiksIMOUKHb0w120Jvwj8lywgAdRnq1SHbrMcpqr?=
 =?us-ascii?Q?0+pp+ZtCHDDK4uKXo39+lBwFkMZM1b5WCTiOYNv4KCYxOoAsQE+2rE8LKJq6?=
 =?us-ascii?Q?LUWcWO4e6MercCe0fCd/wtxfZD4L8Xc5njNT3XoSxzzf9dJHacgB0RwXvo47?=
 =?us-ascii?Q?hSCsiBXKBRHcgQn3RSBL86vLwnwc1MhQIqb8G3Xn8ULwXfoD/idxT76G+uhY?=
 =?us-ascii?Q?4s6ivA+Xr5u2kDtIteWKMGbI/sQM1DdJr5FwelcE4pCMZmdEiMAmsU1EP+OQ?=
 =?us-ascii?Q?vxKaeNXWWlH9k7EPs2FtY/5z+DQAqnGvZgxKcacBWtn2Si+Of/3QUFAeVFTq?=
 =?us-ascii?Q?7VEYkboEaaDZJWJ4rvEslQK7cGfATTE6gDZIJKQ8nTmlI2+sa0ZZdSlYW2r5?=
 =?us-ascii?Q?XPugmpTN5QZTih4RJHIGqAfjL+VfLDICxXXSPzmuD9I6Aq++9/VmbU/ZHj6H?=
 =?us-ascii?Q?s+kxOpH7tXgmwLBn496kknR4ChFdw3/BJfQdf0FrRTFnXgAmaG/W3c5AdH97?=
 =?us-ascii?Q?G+xK0Q2R4wcMma4kVyaOhDFlPzkiI+J8RkW0ML1if4cKpJtwPMg4qHbR3Ymh?=
 =?us-ascii?Q?zILtdpMANroWbWWvFbCfi4jXQVNckfXupMaHZROKKe5BUZMVrFI20SdEMzb0?=
 =?us-ascii?Q?AVt/4Yc9ae0H3b6OsO3WXGDr6A0XoQMIe+ADfJ1AU7xN2F6H4DImsB5rQUBQ?=
 =?us-ascii?Q?KUN25i4vi5jjpLyFPSMLAvrqLBl/fSwSPqdohrGRuIjLSBIoSUYlvY6E97Em?=
 =?us-ascii?Q?0+VNsZfM7hDNJ3L0kHQfMgIf2J9BoFDMMER15NxQZfGVQCR5awplmTmhTzfn?=
 =?us-ascii?Q?uvqPbyM1Wx+jt3J3AZUV5UgAZ+kaRDlizP5D+HW358tppDgw+ymlnSbUIuKv?=
 =?us-ascii?Q?DGrqs6Thfa/S21hDjdM0JiLpghIqUk1Sdg4fZDO69ykMHM8p98jI3T31RTw9?=
 =?us-ascii?Q?Vu3uJ0sxWNj5vqoFDYvLBqQeYmuUCpaf7quipUcnvGSlHO0ljhwluKU7j8rq?=
 =?us-ascii?Q?83KApRjSLFTwGoWgBLiArRkHPM2N2aIdid2V7m00FuWOSApVFRrMfuyXPSxY?=
 =?us-ascii?Q?MuGLtB4xyOLWeCUmf9VA5n75h3b6cu3Cwp6VkE8cq6f2KQZi0xGIKMhPbBvv?=
 =?us-ascii?Q?/1MHZXr9GM4iYrutBuY4tF4Bt6Xdi8t28zKPv+jNNMmsss2mySZJiVCstdue?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p7i4qOKArhMBztDgKdSJA2IXWrWxJLPPmNYv737FIBVFdum0+VPIkSGd5cWkpmMPw7IGk50IQecBpAf3smJmM6AgYaYFPfCF2jZbqLI1jp+etiXONNxsL//cF6imnRSct0RqcMQuZxfPe3f/3ANPIFzyCZQFf/PMB3WkgaMQdegmH3E9qDvVTPqO2wbgOuAhkdh6awn6ogaM9GIsodKhrh/KXnudv9Vj5jp9NDXoLb+B+iblypZzW0K0yrZnJY0sSC7NOfD9DkyGhM1NAGF8AChGOHkd2FQ7qhyHnSaeDaWARuwgX2qOXo6Qahv6a1/mO8Ozkrfs+i1Bv1Ik3SV2+2lIVJoj82B6pfJLK3qVywxIKNxE7EcTCCL4dm3Ok8iZX3FIQFBr/FuWzN21u+VEo5oMmJ1pqHgISmNW4wOL4ZY35K13X8r8yNzZhTjtFmfWXm56OJlXGWoD5rnse/Mp0/kTU9aJByWE+cdCkSCq4dL8inTS4sAtKVn2sJEKuZdot+koau2iwX0Mz5U4ryu0XcDtmWRBVW0FRQkDyRbpi44mI6mueY2UGlgpglUik1lMe7jouQT66TCNM9xC8WLlPhchwRNa1L6oDhI8Y9iXzJpmieiPgKxWn/09WRWG/ck942/uQXEZXsRBx39SLj5AHXxpPDJBp43Md5Cno+Gwj3fl1YV+5CwJX8/Dme7y+2U5s8n6Rlnu1JSCVUKaEJFWs/6b7qXrCn3Iklf1Pi1QgUdZiUUyC15ut72rImC6inBGzSTbu7oZNbxB/aZUSz+S5kdXbZS57KNKVP4p1yOZmBwx1Z2TBC+WG74QVwVzSGr5fWYUA68Yt5zUQCcjfsPq3g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19139f9b-03e8-4a94-388c-08db78e66d6f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 21:18:47.8491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LniMnLSSXeLr3Pu3IBNwzYbKBWkTwvHzHs4acKybRwgyOYpRyQwlNIgGAlkWasbfKRZgsAAyx6hBJmuh9xub2ogezGdbzizLbr6hWptBjW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290193
X-Proofpoint-GUID: WS6o2pCBn__imzgaBx2nPW621fg8mWqS
X-Proofpoint-ORIG-GUID: WS6o2pCBn__imzgaBx2nPW621fg8mWqS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit fd4aed8d985a3236d0877ff6d0c80ad39d4ce81a upstream

Ackerley Tng reported an issue with hugetlbfs fallocate as noted in the
Closes tag.  The issue showed up after the conversion of hugetlb page
cache lookup code to use page_cache_next_miss.  User visible effects are:

- hugetlbfs fallocate incorrectly returns -EEXIST if pages are presnet
  in the file.
- hugetlb pages will not be included in core dumps if they need to be
  brought in via GUP.
- userfaultfd UFFDIO_COPY will not notice pages already present in the
  cache.  It may try to allocate a new page and potentially return
  ENOMEM as opposed to EEXIST.

Revert the use page_cache_next_miss() in hugetlb code.

The upstream fix[2] cannot be used used directly as the return value for
filemap_get_folio() has been changed between 6.3 and upstream.

Closes: https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com
Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")
Cc: <stable@vger.kernel.org> #v6.3
Reported-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

[1] https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com/
[2] https://lore.kernel.org/lkml/20230621230255.GD4155@monkey/
---

 fs/hugetlbfs/inode.c |  8 +++-----
 mm/hugetlb.c         | 11 +++++------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9062da6da5675..586767afb4cdb 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -821,7 +821,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 */
 		struct folio *folio;
 		unsigned long addr;
-		bool present;
 
 		cond_resched();
 
@@ -845,10 +844,9 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
-		rcu_read_lock();
-		present = page_cache_next_miss(mapping, index, 1) != index;
-		rcu_read_unlock();
-		if (present) {
+		folio = filemap_get_folio(mapping, index);
+		if (folio) {
+			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_drop_vma_policy(&pseudo_vma);
 			continue;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 245038a9fe4ea..29ab27d2a3ef5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5666,13 +5666,12 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	pgoff_t idx = vma_hugecache_offset(h, vma, address);
-	bool present;
-
-	rcu_read_lock();
-	present = page_cache_next_miss(mapping, idx, 1) != idx;
-	rcu_read_unlock();
+	struct folio *folio;
 
-	return present;
+	folio = filemap_get_folio(mapping, idx);
+	if (folio)
+		folio_put(folio);
+	return folio != NULL;
 }
 
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
-- 
2.40.1

