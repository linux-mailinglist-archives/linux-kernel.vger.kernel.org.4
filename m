Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFBC6684FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbjALVFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjALVCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:02:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241BE551DF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:46:53 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CJubal006533;
        Thu, 12 Jan 2023 20:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=OJ2PP8aFeoNdhHtIahoaYvPgXtAM2nrK1T2oYw7fFJw=;
 b=Sgl6AfG8HA7iSeUmbQ0XRsM2rnNAHxjGxnWA+1Syc+O20w4n6i5OlLyfxrtgdKVbi6JH
 kQKGr62qqekLyUAeX+Ugt07WBWXKGVUooCwYADCmgQ+HKu7KUcSrfNvp/ZQAE/QZyAX2
 DnAeVPUilwWxFVNTnUQC4Y8XbKu7suu56HdXTWylTExmqK69+y5In54bXqzvGnO3XgrD
 6kVC1oWfD6IMjDeit2jGvCNDrIfgK+ISxRzWYp4WKCcZ2y50AY25bXZ+E9H38ei43wMY
 ucna+L1F9F5yHmbuya6KN5bu+Rt3mOJBYEhzJuIJlpQLAWwq9L1KREhj+0pI2p7FqRvO 6g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0btud1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CJU1dK034131;
        Thu, 12 Jan 2023 20:46:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4h0wm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9M1/1htuXG75q1dVJZ4mYGhkvwKYTE7930Db51mCJMWs6A7dPLv4gkWE8BrLgQ/8tvrGcSySm3rZnhwj5ILwdAvXst+3Gu9zI6k1OdY4MkdLyBRMoxWT24S058V9BlUhNV0k111xUWC0Hi3EnKxMIEMsKzLXG5TKY8FlDLlQlWhfAnu0PvBrTHUtYCxI/ziuzyoOF9t/ZS1kt0deHkmbK9uKBKJkU6VOHhTw2lwzGOkCKkw7cJNhu6kf9OUBcVWfWN1aKryKgWBg+gcD25IAQyB9xlX29YyhS1Gu/Z6JjN5dlkHaGay3A92FSVLLX8iOsgR/PelcFmuTwhAQuqSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ2PP8aFeoNdhHtIahoaYvPgXtAM2nrK1T2oYw7fFJw=;
 b=DtKgQp0u+20EltOgdb1VdqnKHhKzg9BXNbTmZEWEGN7mbDOyjZKhQWnB4z4edoNJxPhgR64Z8pN823+PzNC+6Fx5JvJDTjF2RPYez2g81O4nHdZyRNzDhxrl25h+iUyh4YYOQR7l1siFRE980T8R0wEu/golhuXoT+TeDd8VIgAfBO4YkDjNvsyJQosgeijS2UFwOE1UD0PUs3WodbwktJOZGI+3z95+eVlqEjZMRwfw+DMWOc8CGqSxaLhIV06EQ0zcf1sZi19dV7se3nN0oexYkCbJMv0n/FTsMVjErxwKDK+w4BT+F5N7IB3nF0EHg3xWjswMqLhM2gd3gAd9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ2PP8aFeoNdhHtIahoaYvPgXtAM2nrK1T2oYw7fFJw=;
 b=CuOHGogxE49xyyKXz+tac9lh6zZr5gP1ZkIGRHFNx9FPgVV58xiXznMQt6CUOLWLySOdu4qo3/4G+Cmde23Sp/CaIMDRvH6hkR755z4ua/7u+BrwX5VT9/ZvNc8Jc0r6k0bLHlXtnyKZMVcfV4hMJYLN7HvkdsWxi/u1gh5N1OM=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CY8PR10MB6804.namprd10.prod.outlook.com (2603:10b6:930:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 12 Jan
 2023 20:46:29 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 12 Jan 2023
 20:46:29 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 5/8] mm/memory-failure: convert raw_hwp_list_head() to folios
Date:   Thu, 12 Jan 2023 14:46:05 -0600
Message-Id: <20230112204608.80136-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
References: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CY8PR10MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 898f0049-b0b3-4eab-6f0e-08daf4de146f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2rnS3myjW30mxQNiY80iNHOt5tgpeoH5XUkHU3CHbtcMzkZWy4HZcaKfAXLzCYmkTr/WW3bFGkLs2kANZ1OxgJhujRzr8UeGlV1kpxow6Irz9jQbTEdg+kAIsM2GjQQAYf6PCNB1jEOyCg5C03QbLRk2xVQubCcFbl/jPifx3GHJnLROndjtYuHcF7WMqyGeZuVmYV9NBh+fhcfdyoJSb6DPza2xbV8osMj8YtSCLk+6IVYUgCv5+fxKd6Y6RTPf/OiZTP2y44DbHkUsELfs7j1B/R9geE/+hTD1OpKCimg3IDd+KI9rW1VcocWk7+hsrw0afYdnf9e5TndDVzoZSOXS2SZuC9ShtSpJo2vABMUDpa52pEj2XR6t+zKTNJOVM18SnYdyOw0OB4LHyO1NjHxFmXMeOwRmu5qnVgFIp+d8McpxPed9FJ57fSlCmKeE2vhUaNprd6J4J4NvBLLmpNMWvDfAwoblfpmxAnHrc2w0xIeHXEnis3wj7kC2faMz/byIP6UnHIG3ypkGBwf3mNYgrKMMgWrSaFXX45qspCMnrwYL1KMEJclqaHOzgkTh0Sgf9Jb8fKW+OD+npsbFaVqcfZb7asNV0HYKRjKQ9JF/CQeV+88L5CuDgilOKeZIkAr9W0hhIIdvVB+zThwtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(44832011)(186003)(2616005)(6512007)(478600001)(316002)(5660300002)(107886003)(6486002)(1076003)(66946007)(8676002)(66476007)(66556008)(4326008)(83380400001)(8936002)(86362001)(41300700001)(36756003)(38100700002)(6666004)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OfJjdrmpAvmhjbPjZayIajE69Z1PPHWKSfCwdc0A7vSbm2ruPkepcWv0X0hN?=
 =?us-ascii?Q?Qr/BetnNpjM0ZpxAjbHeZ14kM+cjq3Nmp+b5iVzZnotbDkxAEwcgO67LT102?=
 =?us-ascii?Q?wT+dYGRYeIHdR2M3P5bmSlDIXHq68+bVypuZalhWrMcyuBWqOKOiR14b2wJw?=
 =?us-ascii?Q?t73LAiLevNW43Fv25JYN9LBq5UPhTH93VAu8daQZhD/kHbFGcKvNwk+KJ5Wr?=
 =?us-ascii?Q?miP/35Wk7STYnw2OtxLhn/yaQEoWDcttEStLOmlZRY1lnFwjHYwSvD5xWw5d?=
 =?us-ascii?Q?U0ikkpoD4ot7yUZi2NWaUpKqcQpI0aTBits1RpW9b8Uw7ngEDJsGN13dqnkN?=
 =?us-ascii?Q?Y/CZ054DbKo/RPUYIij8x75E6ZIiNIoNX+0SxGnyHzzAl3CTgObHFrdrpT+1?=
 =?us-ascii?Q?Jqp8jFgnrHFhjfeREsTQIzbbEfM+Z7hjGKXt7rnNkkqbRGrsn5Kb8uH9FLI3?=
 =?us-ascii?Q?g45rsiV6hxXYmt/5jA7IKCOgnJrLqriZoOEX+qwau16eWZqLrHrLohUwsRkh?=
 =?us-ascii?Q?pSuGk2iKHZhzo8yAb9DdxVr7sQUAORpLsteyWRgIAd1JWaJ2/cSjz7ennzG5?=
 =?us-ascii?Q?8kZ3+Rvk+GCYak7WKhycINKy7fFtvP4TyTsVPriNNDYb4SXFmm996831IFd0?=
 =?us-ascii?Q?0g0zIl9BQ1dDb7ryqEM9iSbRgZkP60brck/kfystXu/HOd0P0cEQYAjJoogl?=
 =?us-ascii?Q?imQR+gWo0BE/XO8m5OP962mcwLQzh+wVmXrfJIECMuXpzeYiisJpL2HQxJFi?=
 =?us-ascii?Q?lLA2dobMvhTH5/AczV0dqdLA680+nNwlDCXMF4mPLDk0wmaHsRD+CmS5m24L?=
 =?us-ascii?Q?ddRXLrPyNkTTEWRzFCxrD+UULO7BerXV8Ov8WKp07V3h3wZda76KlX4yDErV?=
 =?us-ascii?Q?kB3s4KPNg+p48A+j4rQu8+ZexbH+1KAlHjo/o8XA02UZVM1Yj9CILd+W4xYE?=
 =?us-ascii?Q?r5n7qFcdLYU6s+sMw3E0lMgdWq768ncj/7/vh8RDwGwYXtnjFHPAUKaBFvZX?=
 =?us-ascii?Q?IOGVBLRhNWHYxM2LDrZIgtstd/AgCRuEy0Bf2Kq1A3c7V8seHher5WP9Uq7R?=
 =?us-ascii?Q?qE1IJAPYluzNp+LOjmonecE6rbc2V5bzGW+BEWYlDGhXcErIaZ5hF5xnzagu?=
 =?us-ascii?Q?W3veoOumePsUt22E4b5D8TeD8qlvAFNKiOn/5I6rLRTyw0AOMETVtRuaxCu1?=
 =?us-ascii?Q?OFbASlxGIRFRxZXw4mFk/fD24NR8CdlbK9Cn8Bdjs4lfauP9r1oCVch2yiFr?=
 =?us-ascii?Q?BRETWhkfjQYu7ipg1aKUSQuzYHdxd2wJyQCpdj2rGL+DMBt4qTWejs8PukQj?=
 =?us-ascii?Q?ej6MobdzSV1FG0IqW1whHoMOQX2tNrrD/hyvVfoaV/Kkmei3Q8X9A0TCtyVQ?=
 =?us-ascii?Q?p900gxWNmo6lu31pgX1aWYejjJQlqvO1e6uqKZrf5+P62gQ9YSZPP9RD+SpU?=
 =?us-ascii?Q?ZP2ZqGxufsFeFYDW3VoxBajnEvm2j7LUlGFeKI0Fk52ZeJQwRvWBqC9bQGvu?=
 =?us-ascii?Q?SsgqGoITnPV8q8ErVxi0AznQcauYP9FRQgT4aH7frwgOAIGBFVNneqeHt3wM?=
 =?us-ascii?Q?nJ93CF6d7Z7iLSkQlU+uNeoBLj85Qm2ELEItpX2r6wFsgizua5LN3zAQY98N?=
 =?us-ascii?Q?J44Y3yyTlg7pHm3RojXTJhg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LJB1JvWwJCDRUhgwvb5A/+bqghDW1cYc1ZIPVFwOBvIV/SNKH1DWM4Bbw7Yx?=
 =?us-ascii?Q?Y5xVlvvUeocMs4YA7qspwFNznl/XSXUQsu8mGpZBEINmK4g2ol8d3tSdgZUJ?=
 =?us-ascii?Q?oiVo4z+nfEeBJUzo+xc4KfMM8ZX6142P3gy+JGomWTdUYM4NyQ1L/AaEzTD7?=
 =?us-ascii?Q?yBt6hzr9dhjrBbbSpqqigKriB8SDgWkugExT4bXPxYROjM7mbOYfaN2vYceZ?=
 =?us-ascii?Q?oEk8+YRxdOFLQyAOLm1AkgaEzqLDOyyi4czgfphmiuKy7H22SXIVmD8k4232?=
 =?us-ascii?Q?PMIFahtBQKPeb7WcK0bYhlF7ke5v9xd8A24uNdzYjnHYdzau3X+oiCc7oWFp?=
 =?us-ascii?Q?aUkoP1HwIwxaIk7sHqk4piAhYiuxmIoKYwEqDHB8STxUNm3Y2kF0skc/luOo?=
 =?us-ascii?Q?o59oHy37xIxS3DpiXH8P5ThDJjry3tXyLTmNn/IJcTG2QIbN4XgLM0YmygA9?=
 =?us-ascii?Q?T3zHz6tZkUAK5M0hHw/XxCMu9qVWufvD3a5Xt4pML+vDu5fCuG2wdYBCV5g2?=
 =?us-ascii?Q?/4GNd8k8nLpLqEd6nLo1HMWDqBLm90toaBIDEadCKJhHJd9C4NOlwug3wvJ5?=
 =?us-ascii?Q?OPHYU+E1CmSdtnn7PmeXn0+eUpE02qTFJCdPg6b53TYsh3akREs7cb35cDZs?=
 =?us-ascii?Q?BM//cBEPyrMaJlxv15dSDbiuf34DJQm7LKPweLXbP82Jw2zhhUY2FVY1WkKi?=
 =?us-ascii?Q?WatvLcgjueEn/XzE8ukacmWzZMqJrp9zH0q2OcVpR0icXFamfslS0hf7b0Wk?=
 =?us-ascii?Q?fWSVeU+kTjuUsiV4y2GFEESjIJb/vSAE/fm+BnGFuZ4TXNoymOTP/qYei36a?=
 =?us-ascii?Q?SttnMkVAYr/fC94GkeblygfWhX8CiECELgAkQ5yc5gsMQgTlRJ5TMEXfabeG?=
 =?us-ascii?Q?ni0DqxBhqX6drlxL/ztNjcAZjUwj7kbluQieOwKQMZhWfpPTzLK9LCIPvsdg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898f0049-b0b3-4eab-6f0e-08daf4de146f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 20:46:29.0673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnXi2Rlve3u9AR9BqtijHPbXW4qluqwCq19z9i4b+REJ/reLOyLXqQquIcPtGc0zQR7F0HJ0P/F8Ej5vPppjRwRfBZOHvGzgfVLQSxrbtPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120148
X-Proofpoint-GUID: uPtoAD8HccRmitgp591mVbG_8w6vW4wc
X-Proofpoint-ORIG-GUID: uPtoAD8HccRmitgp591mVbG_8w6vW4wc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change raw_hwp_list_head() to take in a folio and modify its callers to 
pass in a folio. Also converts two users of hugetlb specific page macro
users to their folio equivalents.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory-failure.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d5c828328e32..55f34be8ea39 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1695,9 +1695,9 @@ struct raw_hwp_page {
 	struct page *page;
 };
 
-static inline struct llist_head *raw_hwp_list_head(struct page *hpage)
+static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
 {
-	return (struct llist_head *)&page_folio(hpage)->_hugetlb_hwpoison;
+	return (struct llist_head *)&folio->_hugetlb_hwpoison;
 }
 
 static unsigned long __free_raw_hwp_pages(struct page *hpage, bool move_flag)
@@ -1705,8 +1705,9 @@ static unsigned long __free_raw_hwp_pages(struct page *hpage, bool move_flag)
 	struct llist_head *head;
 	struct llist_node *t, *tnode;
 	unsigned long count = 0;
+	struct folio *folio = page_folio(hpage);
 
-	head = raw_hwp_list_head(hpage);
+	head = raw_hwp_list_head(folio);
 	llist_for_each_safe(tnode, t, head->first) {
 		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
 
@@ -1727,15 +1728,16 @@ static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
 	struct raw_hwp_page *raw_hwp;
 	struct llist_node *t, *tnode;
 	int ret = TestSetPageHWPoison(hpage) ? -EHWPOISON : 0;
+	struct folio *folio = page_folio(hpage);
 
 	/*
 	 * Once the hwpoison hugepage has lost reliable raw error info,
 	 * there is little meaning to keep additional error info precisely,
 	 * so skip to add additional raw error info.
 	 */
-	if (HPageRawHwpUnreliable(hpage))
+	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return -EHWPOISON;
-	head = raw_hwp_list_head(hpage);
+	head = raw_hwp_list_head(folio);
 	llist_for_each_safe(tnode, t, head->first) {
 		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
 
@@ -1756,9 +1758,9 @@ static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
 		 * hwpoisoned subpages, and we need refuse to free/dissolve
 		 * this hwpoisoned hugepage.
 		 */
-		SetHPageRawHwpUnreliable(hpage);
+		folio_set_hugetlb_raw_hwp_unreliable(folio);
 		/*
-		 * Once HPageRawHwpUnreliable is set, raw_hwp_page is not
+		 * Once hugetlb_raw_hwp_unreliable is set, raw_hwp_page is not
 		 * used any more, so free it.
 		 */
 		__free_raw_hwp_pages(hpage, false);
-- 
2.39.0

