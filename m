Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7AB674441
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjASVXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjASVV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:21:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9609FDF8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:42 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKwkre010055;
        Thu, 19 Jan 2023 21:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=N+yn86ESbBpJl8IWFmBr7oglLMvx4RStv5pLlKp0ZEM=;
 b=xZLVvhuvysCfuePvrw3nVMGtQyUcFRkEzBxdH6E8/TJOuOt1VVPn5wp2lce2E9/BPHY1
 coVjbV/X0JhCr9htvQW52Aihdt6FjjQYICxi1LI2Og24fMyM76faibbIr+HThnzsHaBE
 SVe7FRDCLLWQKzMuFq/7s2eg2UTeSy2IUP+zs4RS++3ymq1Nr+JS0sc91jgXHMAPPI3m
 GPTYAvn4eC6lyMru3uv9gwGLVPyuNBuYrRUvJuL9gWEvxSJgLxjtgygxVF/iA2Mo4EZ5
 TCk8mVV9NSvAFiGha6P5eyTubZuGH7shivNRXkW0cM9690Fgi/pioTT31626CuYnbIpB DA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medkdw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JLEQkL013443;
        Thu, 19 Jan 2023 21:15:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qme9njw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exHkHQOIWQ0dqw8IYbZWrnuaH7fDww3AjSyE1yw/z7hyRZLp7+2VCvW5trJlcEfq/Y4fBhWBtbhAgVFALZPd+dCUmL4GxuKG3CJkh7v7QikALwIucBu5imocm7i8zQjiMtGHgc2ogKeqHKBzhF8KXsGZljQjV/5wLVso2WieYWpgRARTexX3G9jqHVhuuG+l9fisjTXXi0VHBpzHHM6Rhj6SqxC6inH4D+7vIump1DORMxzhV4UC6dL7PEtBcAFKDVAlaUew6E+aBGBQtMaPAdaO7ixTamFIZYF14hi/xYML7aTPUdgqBL4XgVnp75MnlJnE4OxmVjXjNjJhVBDjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+yn86ESbBpJl8IWFmBr7oglLMvx4RStv5pLlKp0ZEM=;
 b=Eog71K7bZBB5H8VWNwjxmrqnHji0HH44ppcD8BUkO5cFdAQEaETxHUMH9F0YvGcEJrRmmgNrul+/LjiS8hN89XrKbRYvPOvEmFYSd77hB06JcJ+uIoUGPmq0+xkVAN3PNdsDoJpyFitXTB4GQboas4KQqTdat8GLPz3yOtnbWFO8x2/AYkCKo++eDml8muBh/h1F6iypf7nYRSKjtPtj1IxOVmy2Gjzo5avIXpK6ZTZBzy3GvEgnxvoZYYPDaVkclUum+uxq75UTYjuMJrHe8ffWM+um4X7X9EW79nlwbCCr/rTAAfAoleXha5OTN/rTjKzF9bScMaFm2jW+MUhtqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+yn86ESbBpJl8IWFmBr7oglLMvx4RStv5pLlKp0ZEM=;
 b=jnh9FoxNITU9cGwKPzckjSdvYFMaW+EQL2Hkb56M7uIlU5HJeI59/E19Q4zOaRndAj/ZzO3TXBCk4purseLcDeIfIsCJ5egckH3Uro1Qf0udYOi1mzlz23EjnV2/Hm6dTY+8ween9fyOkSUH7H+tOzyQlcd7eTHU6g2K6ZTC1dw=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 21:15:23 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 19 Jan 2023
 21:15:23 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 8/9] mm/hugetlb: convert hugetlb_wp() to take in a folio
Date:   Thu, 19 Jan 2023 13:14:45 -0800
Message-Id: <20230119211446.54165-9-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|BY5PR10MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 913cc73c-1485-4e11-d31e-08dafa6246fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVmMkJXFS1s2aZ2tefNuwmks4I5ZCiWA2CkghMlp/jYMkaqwDSUCMHHsnN0Z0XaIn2z8WGvtevVkMEKtX0FjE+yFcDDMSddomZdB3p0ogHe8eLuov75S+XpZOWr6GHhnopZhoRidVkWHSlymBEFB5qFkkuVt10D3tED9bKgHHwyhtB7k4KthLyi1TIhIirdlWOWLYsLJPvc+mVlZTbwVTVUvp8rxkB3zlmdw5iaWnLgP3UJQWFjTs5D+RClmzkvGESDeWEV8mQ9ugqQrNTvn2LAC4ObxIedzR72Ia5aWKkZ9c0JyOEw12FiKGm/HH+ErPDYVLjDxolDf7N0Vhtw1BAmCIbUj4V8dqN7PUzCMXhcKge2p4j7vloSvzgBEkjm03HOZ5omhdt952btLRdTjeGrLzDw+ymhU8Igtb09TEdqeL3zLzbpTufZbQBD+juQxtjkYrlC4aVjPN50pAUbeKbYa+MpesH9pjYYYuIyqQOT8sWjffghtjVURukI1x65Qynhq88pxhA+xPK7l0oOK9+/31ucb28gJRBLdYq84QYlRebhuM7eIiEi8KgRA+7jZc3Vz7HCSpkuPg7csDK7DdF3sACXP3CxLUDI3IwGkDjg5k6zbWhSZ6uLu+D/ltn+aoZQkTnAQSycpJ5+nHr1xXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(6506007)(66899015)(5660300002)(86362001)(66946007)(66476007)(44832011)(2906002)(8936002)(66556008)(38100700002)(316002)(107886003)(36756003)(6666004)(478600001)(4326008)(6486002)(41300700001)(8676002)(186003)(6512007)(83380400001)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m1pBqf6B8SMfFm0UNvtkuo81SiUbVhSsCnu85RCz6JCU/JXAT3lNeKEhmEby?=
 =?us-ascii?Q?97wbCXISV6rEOqzP/4Ho7hXxS+s263ztjBvrfMV41vwOxtKm4EqFTmUGEzls?=
 =?us-ascii?Q?2yPhVqZ+PeluimzXUQvLdmEpO6242m8YGXXMtGkrhIy2OQtW7qtqqbeM77q0?=
 =?us-ascii?Q?mpMWTdx0I9TgRGK28ddvpQ12EQVnIyHPr9kYYn5Ea0VGMXiDwTUfnLy2UcCR?=
 =?us-ascii?Q?EDNETUg2c1WpOg3HstWGaPJdx+jxKctrGMHTKixaqyNzot5wsVoqcYkkzYyt?=
 =?us-ascii?Q?DFZTaDAMbH1G1inzfCTPi05TkxVbIHQmgT3siNlM5oqMivHWF153BVE3niSU?=
 =?us-ascii?Q?0GWXXocm6YLw9NdTZgTfAckUOvJJfrxWhyCi6GR9R/K7ZbFJsXHd29Xfp0Y2?=
 =?us-ascii?Q?uBy1sQ8z5Z4AAe8JkJDIidfUUYw3eesLPSIaYjmSQUOsrNSydz7tOPeVs8x+?=
 =?us-ascii?Q?jIYR4ETprgCQXg+VrQjtGTrn+ErqKu7O5pJPb/+PMd4pD0itMbaHGJUoZ/w1?=
 =?us-ascii?Q?R7+/AGV9OKZJ/PJuTwhcG+H7DauQrLuYQT1LKfVz0E2oK3vKMpZKLiQYO2vj?=
 =?us-ascii?Q?KQt5yINvkECMN0+HHTiHPdJYh159X6q7fchFnAQjsUUIBGgqHfzy/wz5WHJt?=
 =?us-ascii?Q?+M4IAsIZ9sjgcL0IX1pRaju9AWkVI40FVrRFLcSOSxDyWGdpVGzbHl/j081m?=
 =?us-ascii?Q?1j3ieTbJUR8eqs01fDAJMWy6GARPWXRFgJFmmKLIlGQLtrXX5GXG3HtHffoH?=
 =?us-ascii?Q?DLKh9iLpoD5y5GvIJujzsplgDsz0PlkzO34vk7Vd+HLDSoCU2FJjaEdQxcXk?=
 =?us-ascii?Q?DXUf9QglndHfPdDUnf8skjEj5ah6k5jqP783czqVeDli4cK/C6mJSyr7waKU?=
 =?us-ascii?Q?vGV8a5y1ooWkvwJcOCanN9Aika177g9Mc0o2G7G3QuFZRKbNvLD6x6zQkMxP?=
 =?us-ascii?Q?uNuZzGzqhD/T0ixiQpntH1a34cwUS4RUIIANTbbVdPC/ZxH39SZ4Be7wU90u?=
 =?us-ascii?Q?6p5ageWvjfT63e8HKNZnGFugyX4fS2wYcG4xWUxTsBYq7mSaM6XT79NMaOsx?=
 =?us-ascii?Q?f1Uncmy5ZpIiguSK56EKes1xKFQU0HxcHLK3wcPflA2KSdEQGMOF4RD6MGcf?=
 =?us-ascii?Q?O4hMP4lJfbgavtVrscXLZlu+ZnWq2y1DEbj5VZUjIOl8U5BLOnyUpji8BoZE?=
 =?us-ascii?Q?5R2soaVHLsyx9HN03tqFokcClCnMmz2DdRly0WFPGxaIpelxinvZpJUZQLz1?=
 =?us-ascii?Q?rj+4nK4gYO9r60WdlGwlG2zAy/yNE28IAogqKaOSdVAL1ffgc6nYKoF+40A5?=
 =?us-ascii?Q?4IWR1HPKHsP2oPC36BnlUyiPt2Fxvbp0Q4kSHIVdeGrimQlW+TZuggeTTyIq?=
 =?us-ascii?Q?FsYEqHEh1iT7dSMbjUJi5QeZG23XoXKfy18tXiQuJKc+qL7uqLzMGV9wCkWm?=
 =?us-ascii?Q?ANQli2E2qamFJ/mv29+4UQ8UuOCMzfp8gk0yE+fsTmEhzZ5epSJj0VBmaRXf?=
 =?us-ascii?Q?26WFBYszJn07Q7UnLJTExfsfc9e5im8hrfbNKPlTAlA6ZJhgGFvWkO3VcG43?=
 =?us-ascii?Q?zx92LxCm4fb/Coa6u5LhUjXhgJGHgUMEoh84sDV1pu2O0K8ox2Vu2N3lHE0C?=
 =?us-ascii?Q?WjS1lQRL7k3cHBzz+DjkjArPPweHj9dXe0403TCDWBAbdF5tLnsliJcTYcTd?=
 =?us-ascii?Q?T00I2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4KFNrtjcdJitKxEycWAaYOpvVSiy/6HHZllvhUnjBCBt9nOCRsy2wejylULZ?=
 =?us-ascii?Q?M/7S8O/YLO9j8/8TnK2ovjbiPJ1ZbZyxEo5piyyobKPX1oQ1zP9u6aNtIqBb?=
 =?us-ascii?Q?Pz0GcyoflCDycRW4WvUrbwyuYxkdfFdlU0/5lxSlgcdla21S/Pv9sP70gJvy?=
 =?us-ascii?Q?TXlUQi9MAm7QQgx2nDhS2wQn4Gft6E95gjBli37TOTTh3Q9/Z0XL/c5Q9HaO?=
 =?us-ascii?Q?rr8YZQF0nggo3S3AWL9bryiz8AKjYd9xBS3hY5nhIFZ16O9UGTNarDkQ2woy?=
 =?us-ascii?Q?JMhMhsnGxkSw2Tqf3TwEP6knvf6xSynwTct0OHHhhrUxXb3VChJCwk4fl8xT?=
 =?us-ascii?Q?ZItAhQ/zklLP9q+KuXoxbarhzfENcUD3hR1UpTYhQqgLG+/f7V556ydDsHlY?=
 =?us-ascii?Q?TZ8AcZdc02+9riaV5F4oVLcF2zT8+Q2+RC408hAMgQ2nNqJFgfMx1diDycP2?=
 =?us-ascii?Q?Je2MpPOebLF7EgDOcz7/0H8EmY/lW8kYkGT01UblBl1ivDDFtljNgJ01VxBy?=
 =?us-ascii?Q?Mm1MVW85Q8REiowir0yvZEtpP7gA3iHxw7AxvFObVgxVPg/LFfAXlcRBr80p?=
 =?us-ascii?Q?Z4GpLcA78tegIPGbKBVxzMbE8cTnC85FAfxitFPA/lkCvPBPGnlOp14oANCt?=
 =?us-ascii?Q?sRIm/6UYxoBhN7u676rmcrduqr/bZMbEQ4acWZ44Y9vqQVPJ64ruO1r9QGQB?=
 =?us-ascii?Q?fpTCt4lnnTvtrwhYsDEYeVbyLN+FLeGL/q/ljcqdT2Mbmn/Ejsgox7OvKrD5?=
 =?us-ascii?Q?2NQoPnzm8boSxkVQehLvroGnwS0DF64WkPcRxQlvP19pyTlQcCBAH86AySPa?=
 =?us-ascii?Q?CoFn/hp+vSrC1x7XnJ9451oeG87V0uquALkXTHPCiQpTIWfwwXg1EDplgmBl?=
 =?us-ascii?Q?bKBsCzPaPzEvoj13gYo99XpyB4G99KWuMLsc/ZdQQ7qR3ShHG+v8GwvRC/bt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913cc73c-1485-4e11-d31e-08dafa6246fb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 21:15:23.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLzOi28GAyrYTvKS83yrpTiva+q9SMI+mlFCriPDHOJbNTWREg1Tkt6IQzDAIwgcYQt7Dta+LjNRyXQqImvJus3xwJtipyUQa9EmrvFfdD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190178
X-Proofpoint-ORIG-GUID: t8iyFIkF5VwWwoQvov5nVgHRYOHmEaa3
X-Proofpoint-GUID: t8iyFIkF5VwWwoQvov5nVgHRYOHmEaa3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the pagecache_page argument of hugetlb_wp to pagecache_folio.
Replaces a call to find_lock_page() with filemap_lock_folio().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4ab3eda6db18..20127271b64c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5472,7 +5472,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
  */
 static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		       unsigned long address, pte_t *ptep, unsigned int flags,
-		       struct page *pagecache_page, spinlock_t *ptl)
+		       struct folio *pagecache_folio, spinlock_t *ptl)
 {
 	const bool unshare = flags & FAULT_FLAG_UNSHARE;
 	pte_t pte;
@@ -5529,7 +5529,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * of the full address range.
 	 */
 	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) &&
-			old_page != pagecache_page)
+			page_folio(old_page) != pagecache_folio)
 		outside_reserve = 1;
 
 	get_page(old_page);
@@ -5923,7 +5923,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, address, ptep, flags, &folio->page, ptl);
+		ret = hugetlb_wp(mm, vma, address, ptep, flags, folio, ptl);
 	}
 
 	spin_unlock(ptl);
@@ -5986,7 +5986,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	u32 hash;
 	pgoff_t idx;
 	struct page *page = NULL;
-	struct page *pagecache_page = NULL;
+	struct folio *pagecache_folio = NULL;
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping;
 	int need_wait_lock = 0;
@@ -6068,7 +6068,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		pagecache_page = find_lock_page(mapping, idx);
+		pagecache_folio = filemap_lock_folio(mapping, idx);
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
@@ -6088,9 +6088,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		};
 
 		spin_unlock(ptl);
-		if (pagecache_page) {
-			unlock_page(pagecache_page);
-			put_page(pagecache_page);
+		if (pagecache_folio) {
+			folio_unlock(pagecache_folio);
+			folio_put(pagecache_folio);
 		}
 		hugetlb_vma_unlock_read(vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
@@ -6099,22 +6099,22 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/*
 	 * hugetlb_wp() requires page locks of pte_page(entry) and
-	 * pagecache_page, so here we need take the former one
-	 * when page != pagecache_page or !pagecache_page.
+	 * pagecache_folio, so here we need take the former one
+	 * when page != pagecache_folio or !pagecache_folio.
 	 */
 	page = pte_page(entry);
-	if (page != pagecache_page)
+	if (page_folio(page) != pagecache_folio)
 		if (!trylock_page(page)) {
 			need_wait_lock = 1;
 			goto out_ptl;
 		}
 
-	get_page(page);
+	folio_get(pagecache_folio);
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(entry)) {
 			ret = hugetlb_wp(mm, vma, address, ptep, flags,
-					 pagecache_page, ptl);
+					 pagecache_folio, ptl);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
 			entry = huge_pte_mkdirty(entry);
@@ -6125,15 +6125,15 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 						flags & FAULT_FLAG_WRITE))
 		update_mmu_cache(vma, haddr, ptep);
 out_put_page:
-	if (page != pagecache_page)
+	if (page_folio(page) != pagecache_folio)
 		unlock_page(page);
 	put_page(page);
 out_ptl:
 	spin_unlock(ptl);
 
-	if (pagecache_page) {
-		unlock_page(pagecache_page);
-		put_page(pagecache_page);
+	if (pagecache_folio) {
+		folio_unlock(pagecache_folio);
+		folio_put(pagecache_folio);
 	}
 out_mutex:
 	hugetlb_vma_unlock_read(vma);
-- 
2.39.0

