Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866306684EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjALVD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240130AbjALVCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:02:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B88E6550
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:46:41 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CJubak006533;
        Thu, 12 Jan 2023 20:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=pX5Ehn0FhmHlD7jbJcixLeN9Bde5WmQy5YXsDNwQ/bE=;
 b=0K8avunK91DNmIJeOeSkAoI4OOXrZOhFb8AFtiIGE8+0zeNSXbooOmS5ylersbp3fKDF
 ZGZPwc/bjW7vnOCDz0kUsw75Wpt9sZriFL0Zkiry767Na6ecfs0Zat029Mf2fubXg+Io
 /zf5qcsM5EPpFcU8CQxJuGNT/7XxY8Obvv+heh+znlLCP3QYGgK2uhTKCyDuTvDgz0HD
 y0zwbynhhEXnRJ+RqxeC85/742jbNXzginKRJNyPKN2YPmMaul7jTP28Suk6StJTp+hY
 a/+gTtRWNK3igoZvqbthdjv/gc6yyWneBoXc6uQQ5GIDsDNGu1cAs/lA1zIvEzGXvmXc qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0btud12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CKHvDZ005280;
        Thu, 12 Jan 2023 20:46:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4brque-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCQtWHqwvH96ngRGVGgxymah8VQ/7bYi+XKh1e6FByZhCmKj5exTlPnQ6mxqo9h3/kj1mDfjptuwBuKGeFmzvCvwwzGsQWpqe+IDlBdQr17WtL9VOUyxFYgCRRdebdVjULFQAaMvTVbxFryCCqf2YdLn/TanUr2DxPTHAEs6ALyBAi6+EaxjSwuNmLqW+tjtekSTJNn+5SHZOIuvNWl/YBJhyr68cx5rCzHgeoJyIxg+LDTuFTqyU9o0dVtfFtY5sn1KKPLW0DcfZZBWuEp/ubnCWq/T5Dx84E4238NSqGClq5qRm/qJy73jmwrv5w3VBIjBpw6O3FyN37+TMdim6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pX5Ehn0FhmHlD7jbJcixLeN9Bde5WmQy5YXsDNwQ/bE=;
 b=cwOKOKFd62rPteM74d/HhVtdbcQuzf+GCzMsep4iPWWrYTPJcKi3zjnBQge/UPbGKZ790BMvbJT+4PNlsj7vRXAYGQGEn0aCLHTGa705ET8BPKXTr9FBLnC+9CPNIG9PXXcHDr9uDF7Icc6ys2+UzdMVNLrX+lx/MAz4Ip+HRsAW+SYokMRDpXZZ4SPouvcI/KjP95aW8QqA9dwS0D390fBGQ0AG6E9yIk4o7PQgDVdX32Fdw8isncI4R2okmr/7EVx2rPNufxeVU1egzJK6qFyEqmHj8Hfxe1a1vsFkb7yi4FX9zwM0xagITUOcjDBafSDBXbxb8RzSFbp3YRrNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pX5Ehn0FhmHlD7jbJcixLeN9Bde5WmQy5YXsDNwQ/bE=;
 b=K7IzCtTkYSn1LvhvfIqV0jOoS8T/ncRIbfGgnZUOYHRrZ23R9V0Ajmw8LwgsHPCGBxuA5M4SFq6SNmMuwZ/aTgANguJgXPB5GJhXwtffA8Jo2X99x4d9APLMA0yepCBs9mq6gQwlVzvmx3EOvYiu8TWCvtiwA5eVzwqCuu7E7gA=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CY8PR10MB6804.namprd10.prod.outlook.com (2603:10b6:930:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 12 Jan
 2023 20:46:22 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 12 Jan 2023
 20:46:22 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 3/8] mm/memory-failure: convert hugetlb_clear_page_hwpoison to folios
Date:   Thu, 12 Jan 2023 14:46:03 -0600
Message-Id: <20230112204608.80136-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
References: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CY8PR10MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5abec9-8b0f-46e0-31a1-08daf4de105d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qLPcGlIcOMpwqkqxCYWGWOvpccHBrliuDGJ+5ZhioLY9vfP9idzVpqKZW25RKyRhWDVo79mCffPobiPmCII5/YggQ8AJsv5IH2+UwYey3IFUA8q6ZGlCbGyGjJebnOAanFaDbuDZuQ4s/fTrfCC10pdIuSEn+o480vsY6Q5WZZGBvMLCzy9GCbce3558LZEb8vsviLX6bzEr1vkbHe0Hd6vfUrXvQBQWi9D6yu3gNWG41ykgTxLCxl5+YyXZ7aEj5/Qbe2z7MObwEBQFbM3CalTU3xP6TDAHU/fw1c6kwl22XxVRyHFs6sZggPEeMLBnxUIUNDFc/wVUb75n295lZakEsHH4cT/u1VSVIaNcfk7qt+A/R9PbuwuQ/MEB6U1Pgu9SiKiNQ2IOJj3pDL7JVWu2b6KeYKvw58nDmaymqRir2COHhcEEpvw3Bjw1+05KnISNCIyHVADb9jAXzvPyNOYGlxlMbfRPx4zkhvk3J2VyxjhJhOxsrHLxAkPKfy4w3w+k3DAAbAnVO12TnuZVAc/MVeXD9lH8pptByBO7MNZJ/5Nh9vz+5zQTdqV/Zvbiaeqd2xgbHRd7ZQbWbefGzDeRPNvbAGy8WQa4MmnzqkIq53+5SJAT5nLgKE+lIBSBEnwEQRZXIpXAEQHw56duA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(44832011)(186003)(2616005)(6512007)(478600001)(316002)(5660300002)(107886003)(6486002)(1076003)(66946007)(8676002)(66476007)(66556008)(4326008)(83380400001)(8936002)(86362001)(41300700001)(36756003)(38100700002)(6666004)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EcCFvgPpE6aHPDd5OYXiqvacEF0v4RyGbKAr/NCUMEO6fb7/Qr2/xJi5/HIq?=
 =?us-ascii?Q?PM0CaU/a+OpVxK+zm/0/rb4N0V2ZiB/7HZK1MpJVFRmssCeJPkX8OzhigJ0F?=
 =?us-ascii?Q?HLogN+zLO4MUHXJ629FCPbISXwsk8JHyENQzRd+fMs85BBYNsfbaTZiNpxk5?=
 =?us-ascii?Q?ZuY25upfc0pTS9gyg6GfEfsgoQZdOVLDT22UX8K1TaK2hV1n4chX4CNOmEFn?=
 =?us-ascii?Q?DSf6XXkiOf+yg0Y1geqr+yc8O6sU1AOU4d1+N+Kp3pT3uU8eqFBWFVbvGIks?=
 =?us-ascii?Q?MXwDMOF1F8cWzklTDseSg9ynVYzGyDpYvcYlxmXeyEoab1DxjcjEpKtEv6jc?=
 =?us-ascii?Q?CrQzYOh9n+8XLgjpgd7LWOMOcpPzDtcC5Jo5U7tHzO0cpKgOYFN5n/eKtwgm?=
 =?us-ascii?Q?LcektEb3oHmvUCImN5y68cfbjIbuL5E/823vKFoUgdhRzHa8sjCkbD523vqY?=
 =?us-ascii?Q?VjKCuppr4SDK//4AyfEtMCS0Tq3jo/SwFpoxrkcuLR30ucLMtII5P1e25ZpC?=
 =?us-ascii?Q?+vauYyjOK2G4n3Iz8WZeam5UD7DzG8W+BLPGSBkgJXNOh+SBltRpGWN1m+AO?=
 =?us-ascii?Q?GJ97cTUScuTUTj7Zv/iju0KoP4gpWrCaEpWWK+3fW4mqq+kBwIxupaTlrsXu?=
 =?us-ascii?Q?g+rLbaEtx59jvlrgW6KV1B0+yjclcAfRTq0zbGaWt1gjAoeM1pNj1egrqS6h?=
 =?us-ascii?Q?yT9ccZRaBmreLMNdytDVx77eZzO9CvyUkDCAuExRaQ7Ln/OxrNwEmgk5itiZ?=
 =?us-ascii?Q?JAPEB8Jk6CoY0cAj4uwgG4hm4alkjz1QkgWuaiBIND5R0mc8Fnx7htmJ1dYu?=
 =?us-ascii?Q?+VLKJ8dXOSLLnaj0H4AFa/pSuS0+ZWW0O0ahPp7dT80aXFBL0bSKtWfK0oyv?=
 =?us-ascii?Q?nE2sAQvf+vlE/OxZUkqUZ1OrulzwEX8gz6JEH13WMO19v1fAUw0qxPJlEXti?=
 =?us-ascii?Q?7KnJMpLfSZZkGZh+HfuIruAHPtodSwd/Uzar6A63YYc5I5gtEVFJvtBwRoga?=
 =?us-ascii?Q?TlpVeshprU1G8/C2FI6UpNPTxN2qn2FHLS0XWZZ+cYd3efwdt3UrdXBuQtoq?=
 =?us-ascii?Q?XzP7YTV2z+rsqTT5ICRhgC9IegTO9pJtXpRyNR+Oyl9So4PVwfWElH65ZLQ7?=
 =?us-ascii?Q?xtrQgPevDJuhMIPyEegAbdiTeYqpNfoTl7woBa+6cUi3lBNco/8U0E0vQvh/?=
 =?us-ascii?Q?XOufNe01FsbQ2Ub0SWGStnlgxI69DizwC3wD5lGHSkho6+F2GWXXIR/h10wY?=
 =?us-ascii?Q?MIRyjWlLL6uWwHkMLed2ztVNVKGyPwChoXcuM5+9Rtr4hbVDYr9ZJ/D++Av5?=
 =?us-ascii?Q?s/lK7xcFvtLqqf22La/Cxcn8izcW2MoT/FNCxLFkPDQFx/8PAB4EiWIzeA8x?=
 =?us-ascii?Q?NSDC3QYzEya5aB5D38OwTlG7ouHzgTyPslS9hGBy+CxGiLcYrubQbEPNp+V6?=
 =?us-ascii?Q?Sq0b9gWTMMWRFrqUYiZ1zPmEi0OpIX3l1oQWai4xqwOOS2IHojjTp7+o5zbr?=
 =?us-ascii?Q?Vae+3hW4uIcotXEB1QoyFlBr6iz36VibPkBVgWRe0veT9OrERIPqkYfe9nlW?=
 =?us-ascii?Q?0mQR+1dtyuUc7M8jFKuJ9y5BSXLh9lsrhNcrAcNGNzmQDkKsj2ZoL72diKO0?=
 =?us-ascii?Q?jKzQRlAm8UAXh97QZr+3ThY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vMAg877RHHnaZiPSIqRD8fkO8ZhXer5NlxyoBIs6F+MbaNHy05EcbOliuLXn?=
 =?us-ascii?Q?YLSDS62XalxuikxGCmjq3og3gjqODsegUR5X6J9lZoDJA7rPoTZVLwA6Go+1?=
 =?us-ascii?Q?ZWba+YRnR4WyaQLs8LLD5UjmnYlpBDq2iZqOu3xGQOJYoXwAO58w+kiTnOOP?=
 =?us-ascii?Q?TY7NsmpEnFhhDXeVIf7KUpcwVGkbY0JgjX25YRZRlNt3khTU2PzJHfQRFLBJ?=
 =?us-ascii?Q?XTAOjeqr83naBcYek5440rpDA2TuGciKYJoQB4aMJK5jH53bfMTt25l+xxBL?=
 =?us-ascii?Q?JWYCAt4qMkmrUWgyLKngZUsLd2lNsBWOnn7DXS4WY/NXNA1CQ+rtH2lQlrnQ?=
 =?us-ascii?Q?8V6sGw6wJawv2ArjdV5+9nWo/sG2ThrlE4z1Yzp/Uir6+ZgumV12oI9on9Ow?=
 =?us-ascii?Q?nlDYPM1lCB50OSmNduNlrLLEUMKO7CvDK4nVVB2DzUbInZb3DgJgQf3XBXQn?=
 =?us-ascii?Q?ocYWAf5nGNFZ24GQWpTJbziE0uaacBsCqScarppdmRYNAEnGbcuTh+jUgnPk?=
 =?us-ascii?Q?zKdV1r6d5XUhJ1c8+hGrxHufrY6ME2RnlUsBi9nzsPFmb4NoxnUefArnI5fS?=
 =?us-ascii?Q?Qd4weRG3AG4VQW8XXcLY0GsCiNsJ9IFw7Q3rZGrPzjf/Qy7K0u9lz87s+rey?=
 =?us-ascii?Q?YcFgjmfFW/v9sLF4r+615jAsatCHC1+SiVutrViaQlI6MVzlSMMf5bmey2vR?=
 =?us-ascii?Q?Ug0LmAnRZlphzyiiuekel3GRsnLfzjkjV9wRIM9oOkfKS5pSArxYBHK+4pVx?=
 =?us-ascii?Q?T8dsWOLU8IfyqHaF830VK5zwxWAMk+yd7GMm9INUq5HCc6+Y+M1DVwP2MmaM?=
 =?us-ascii?Q?mGwC3ZzSSilf2FzpjNl89c2wzPC8sEao1pbsaupnJzlz9j6cNnSjoldaf8Ov?=
 =?us-ascii?Q?JrWBrpn+gt1Vhx1PbnHAxQZlAg8FwqVkoqMEyL5Qp3vEDX8SjdlCl3YaJ3vN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5abec9-8b0f-46e0-31a1-08daf4de105d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 20:46:22.2993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYiclIHPahYIRhny2vsCkp7Izr1boSK2Sg7bnmrkwncdk54gPGB1rvHqqGnE4uCc+gkkYMI+JhBWjxGnhR71O/zgXyfo1+khXNvVul00djE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120148
X-Proofpoint-GUID: 1xZiVx2AFMGGpg7qSevcJ-kVo75B9KZy
X-Proofpoint-ORIG-GUID: 1xZiVx2AFMGGpg7qSevcJ-kVo75B9KZy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change hugetlb_clear_page_hwpoison() to folio_clear_hugetlb_hwpoison() by
changing the function to take in a folio. This converts one use of
ClearPageHWPoison and HPageRawHwpUnreliable to their folio equivalents.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            |  2 +-
 mm/memory-failure.c     | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index befe64cb40d1..c33e36f5a1dd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -823,9 +823,9 @@ extern int dissolve_free_huge_pages(unsigned long start_pfn,
 				    unsigned long end_pfn);
 
 #ifdef CONFIG_MEMORY_FAILURE
-extern void hugetlb_clear_page_hwpoison(struct page *hpage);
+extern void folio_clear_hugetlb_hwpoison(struct folio *folio);
 #else
-static inline void hugetlb_clear_page_hwpoison(struct page *hpage)
+static inline void folio_clear_hugetlb_hwpoison(struct folio *folio)
 {
 }
 #endif
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ae9c6ba07a8a..a5d410c16cbe 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1592,7 +1592,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 	 * which makes any healthy subpages reusable.
 	 */
 	if (unlikely(folio_test_hwpoison(folio)))
-		hugetlb_clear_page_hwpoison(&folio->page);
+		folio_clear_hugetlb_hwpoison(folio);
 
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		subpage = folio_page(folio, i);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ca84b27489d0..205272c64f37 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1785,12 +1785,12 @@ static unsigned long free_raw_hwp_pages(struct page *hpage, bool move_flag)
 	return __free_raw_hwp_pages(hpage, move_flag);
 }
 
-void hugetlb_clear_page_hwpoison(struct page *hpage)
+void folio_clear_hugetlb_hwpoison(struct folio *folio)
 {
-	if (HPageRawHwpUnreliable(hpage))
+	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return;
-	ClearPageHWPoison(hpage);
-	free_raw_hwp_pages(hpage, true);
+	folio_clear_hwpoison(folio);
+	free_raw_hwp_pages(&folio->page, true);
 }
 
 /*
@@ -1889,7 +1889,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	folio_lock(folio);
 
 	if (hwpoison_filter(p)) {
-		hugetlb_clear_page_hwpoison(&folio->page);
+		folio_clear_hugetlb_hwpoison(folio);
 		if (migratable_cleared)
 			folio_set_hugetlb_migratable(folio);
 		folio_unlock(folio);
-- 
2.39.0

