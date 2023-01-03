Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAA365C744
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbjACTQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbjACTPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:15:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C713140C3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:14:31 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303JDtWX019338;
        Tue, 3 Jan 2023 19:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=bSfzxdeVDZnG/rkim5bvLm1bSYWCUMIGGlbWdlHgVZA=;
 b=wvf/OugtuNJlV08zBqNHAhf2cpExRE6YFfgljSMwIbR2osyKxpLlUKjdszvyoszDIJha
 CVEJkZ5Txzs0aJqYKKHsW9FAjboapeQRaYH8s2I3mNttLfQDrVgPHdhg1MIYaZysf3AW
 2gcsDbK1fw4oqOH/TIr9JOxbww89a1Juh6WLlQMsuhP1DwlNFy+oA5egCzq2vuM59ucZ
 Pg6v2S4zJTCF+6qhJr5k3tJdaBLbEmSIzXfctb2IMV4RnsvLjwI31bM1nS/blb2ssOtp
 qp5kDpE4KR3GgPEJX8AXmpm2bXuQuAW69GOrCI9zixPbUWzgiw7jwFvA3h1dmumAu685 0Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c4xt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:14:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303IRYA1008948;
        Tue, 3 Jan 2023 19:14:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbhbrvua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:14:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdMvLqP/cF0EVeYZ9cXY+ySIvoUQKjtfRqmoQvspvQlhKpXyG+QN2/IDXqc05WOS/x1yvzWWNw9FjRLXY0WV4Vln6M6qXJS4PfqwcnlUFDrJ1yxrO+6Cr7dsq0wEqSZKVEItJF7p7li3DasfQNFU6MFa06M8xmQqCsUSvBpdZ9SVNmC505ss4uTFIEUsUgyzDAWp1eylrcW/DQlnSOOchROJK3vdBfV9FXWsT/xF8S9ztk5TZPbhZJTjxe9knZ7TS4FGbs93UnfQtZ21npnRFjAtUnvSl7spljaZYCBP5W8FUse+nWpiCR7JtyrejO060YVT4hMlNqa2m0dL8xvigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSfzxdeVDZnG/rkim5bvLm1bSYWCUMIGGlbWdlHgVZA=;
 b=RKrQlHGsuXfyyMqe8B1VA5SApYa+WGWrOPVj/M7fXZ3XlNHIR+xL0IGCiG7d+uOQGRU3vluppQDa+MH4FpW/+VLSRzl2W0Zq9+XnDmuDdH6o3EKGj0Ck9wxvrDvjwAtezb0MU4qppdHOMcgvRkv6LVnjXpRJQa8MOFepIHv7bPILaxtY2rYWvrq9omVCT9724hh6HtgT05IQ+ybpg8z6gb+hW9S+WHriun3FqQ0E0q+pCEcd+yqw4adb5jufpWI1Ho6sQCPU/YUzDGYG4lbmORMuwS5uLcFgyZlFf0P2mUHZF3q1BN+ZqH8+rFNfXha6aBNtq44oZYNaNfd8bqozZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSfzxdeVDZnG/rkim5bvLm1bSYWCUMIGGlbWdlHgVZA=;
 b=MU4rvb/jDpnSipDt062zVv6B+9FhJbrS4PHX83o0Sfft5vskossYu9hC6o0yCNskDClp1I+g2OGEnhBLPcGyiTqNuLJfbrvjlAm6hfbUjFo925eFUijokLzN7xKIB4AgOZBzaHDyt4d5yl0lZ+4B4S5B8xNLw4tPrF8rcni80mc=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by MW4PR10MB6487.namprd10.prod.outlook.com (2603:10b6:303:220::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:13:57 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:13:57 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        jhubbard@nvidia.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 8/8] mm/hugetlb: convert demote_free_huge_page to folios
Date:   Tue,  3 Jan 2023 13:13:40 -0600
Message-Id: <20230103191340.116536-9-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0447.namprd03.prod.outlook.com
 (2603:10b6:610:10e::24) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|MW4PR10MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d168594-b4ab-4df0-38c3-08daedbea98c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgcowUrglrbUo32NH2VlkJKXYHYk6yCxCtc+hxUv/O/H9IjpLEqYjqmUo+UTR+nncaSqphPfiR2gFQNhJTP4bykLgryBY/bvEWGv0QYqxpqieDGS0JrREwWqvwwhxlzgI9dg0ghSs//d2C5fpd+0ADBEkZ2BHPfm2auH+HP2+1quFSiuNJYUsqirNAq4ZGgBoQ0yaOz99FF0Xhd7sP0qhs6VZrFdGFH6aenHPU12R1w+JGaCPxgIizHUZ4rcsp34zHqHGIxqWJIZXfsKQcrvbmLMgsFJj3maOA2WotbFlAAb8uHrMS7rlfO8cMXiulnnTO6ltyKZtF8MS4uRnDTCzjXkMHNG8xEHofn0YWsekdozJp6L2o3t+0EXzsutCeRiJvsSmM/+cHPUwEl4qoEkvMDXSO6BKdzVqEpqVMfHMikoj64L5VuPgGJhOyQDBsc7Z9o321UddZPGEevrCZSs9DF1DVV+pVM1XMsbDPVusVytXNszTNtTxCS7iKvmEjpgVtFQbbGAh2/5SbbsEjC9LF5VlV1BpHkm4Yw0ZS+9wa6+FU3JoMTr+czmUa1s4fRxxFKczSFHFeT0gpLvtHn+5JfijpwaA7mQ0it/3AYHaYLnwrelwjqtHslpv/gGPuIyFPIJstK1R4dg6DPDpmzwOOwIwp6AhFpxFL58lqJe7cpIg4z8oQof5HdO/vhAgojmBBi55HHFn+rquT+kn8co+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(38100700002)(36756003)(86362001)(6506007)(316002)(66946007)(66476007)(2616005)(6486002)(66556008)(478600001)(6512007)(26005)(186003)(107886003)(6666004)(1076003)(2906002)(8676002)(4326008)(83380400001)(8936002)(41300700001)(44832011)(5660300002)(22166006)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5i6rMt6LujJEPrHL77bq2FdqqHZMjRWRz/UypaQRaNwjbWkraBcy+meHjR/j?=
 =?us-ascii?Q?ennZvquIjsK/OMoYpKBMz64EZirpS+TUxM+QEaSOp7ywRRhQgj88gZ4Mkz+g?=
 =?us-ascii?Q?IJDm9/Sjl8imW2gnGYIbP4AoMfVqHkeWChqZhMQWDZ0AecmkX1FOq1nc9nAf?=
 =?us-ascii?Q?Xwq8xpvTOd8nsTI/8bVK/axWh9qS0Mzdhlj/MXtB4f0HZg/IxDx5BbKn5h24?=
 =?us-ascii?Q?5jIW5iDlejzVyrFoQfRRuPTOppDfxJ2m38zKQ3TYGitFQFD0SycdyzBmSRFS?=
 =?us-ascii?Q?nW6TAgk0efWRmmDOP+Esdw8TK06xPc7XsTp1CUUiouW+nuJcdkMC3fm7YFTu?=
 =?us-ascii?Q?c9onCXbhkJDSy9h6RdJXFIpJjLzO4omt21Z301fiTy5OUGOIAyv4GP/ntSgk?=
 =?us-ascii?Q?5fnDrAd7BAkliLpBlqv0N4qCh2flRScnBkZ/ebtCv1FGoPZgoo4Cy6/ND357?=
 =?us-ascii?Q?BgnZibfJ8NYGETw+uDi5YXerz0EVrUFJPb0BIcsfIPMNzJ4ITyOcqqAmtSd/?=
 =?us-ascii?Q?YpSkdsK0aWbzqE0F/NK8wZQF9TyY6i/RNNn6MUj9IN94s0lzOUEsQavS0pW5?=
 =?us-ascii?Q?/rlm7VSrHL9Es7jeBc1ANyc5s3lMOC78dTLTeXf9YdBRCD/mXlYZfs573PvP?=
 =?us-ascii?Q?IMgfCxVTyaTdhudTqablr1Anilo9NaA6Cw7BcwdmJVU6o0qMJCdaMtWchoe2?=
 =?us-ascii?Q?4Ksu8LAa+iAmyw46aVxJeXgP4r6G7JociXoi2Bq6fvpcvVpV0hZxC6tDeETK?=
 =?us-ascii?Q?bZXMXsS0dsx6RO0qmA+wj7+iegaWzb+SEZ75U1jb2UFyuaJzY0hoyc6it2k4?=
 =?us-ascii?Q?ksYESMdkVoh8KYPG7mKBI93fcTsupw2+g6Z8lWbvTEQL9qCYh3Xuy12RlJmv?=
 =?us-ascii?Q?o/pQhZErpNgkcGA188vhGBEoXo9Fays0OEUk0fqW0qo7XoEQRsPejwlF5BDO?=
 =?us-ascii?Q?Cix0Ni8dLNvBWUYz7vcXacbg/koUP5J1luXABJvFaCs7NKwso+VSUq2aukSw?=
 =?us-ascii?Q?O8RV2chPgBgjzVHTkL64e0dbDkDf1acpYsKKw4O+Erd6HtO9w1mwOROiFswJ?=
 =?us-ascii?Q?UmuHOx8do/7wSuh2EarFCC0OGTlM6Ifcoh6QbFVd0yffiTeZHN5q5dQhizY+?=
 =?us-ascii?Q?r4Qvctli0dWYG0RwNgUXQZzxBZ0LBxKJkq+dRwnHGUWht0elftfBwDlViiHa?=
 =?us-ascii?Q?sNQB5RxMnIa+IbOn7t3RDjVLWLSMM6jdQ6HABUw6y3EV9U+yEhJvdND/8IAa?=
 =?us-ascii?Q?OTyA0F8ogUjoUusG/KBC3Q3F1lcYTfFxSz3njNBrKunJlwSr7VyfphhUZl0q?=
 =?us-ascii?Q?Gdzep6qqAFn3+qxqLRxEO2evxF7hObUgOgbfRebca1ABYlr4K4zgZLzEXr/p?=
 =?us-ascii?Q?g7w9QrnPh/pa0evvam826s4OiacVzshfIa77+JdRv3vp3IiVlWfzgovxykfq?=
 =?us-ascii?Q?maJhSgdV7P4+rM6siQvc3kTrKADgUHjQrT5F9jdkUc3M0tRcxPnkyZ+ay1Xd?=
 =?us-ascii?Q?DAUsip+TfUnNWYCnWDnk8MZ9Ltgab6YCJyDhtn90CJFKJcyRHQ8PLyPDdRMp?=
 =?us-ascii?Q?B/cIq9q43u/x0zES2qaRYUG+keIPce8OpmJBLhBn+4NcYuc5UjKja7+GsstW?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vTvgQ+Q7PeP0ItJY7i4MGHrsDlNkmTSpSUII785BW80W3372O385HN8xGcx0?=
 =?us-ascii?Q?uhORzdVvDrR5yqhLNIpHtxGq45j9W+WIxOA9tITGAQGaLvPVTfmdy9jMxRNF?=
 =?us-ascii?Q?m4oeRREWEpX6Re7K7kVWaYheUZvTt9wmYNyKfUVqmxWtNQg4FZmeBtccEzQe?=
 =?us-ascii?Q?w4hVuyHC/Bx0AobNPn7XCizWps2p/+LZ9sTltJAT7I6/MqRejiamHpt8LBOg?=
 =?us-ascii?Q?bMIYJfIriZ58zO5MM0PEN81UioRNSkgwIh7ZZOnLsGDm4RnLC+rDU8W/eHBl?=
 =?us-ascii?Q?ojH8cFqd29xxs2HA7z5XvvlPaqe4Vfql0nh+sduYaBO9x5wOiOX9SmypgbnH?=
 =?us-ascii?Q?7N1DPvYHsOiqW0nnKz99S/kHz1EWke5mp85fA8rb0SemGbafzNy/S/LhB1AW?=
 =?us-ascii?Q?lx+aaTwDrtdN72K+PTtUYLb8CZoZGuB2A+Ktr/kYxS+xAg9hB4V4sDUHXB+U?=
 =?us-ascii?Q?gfEntQNYFRHxkSr/IoeJTU5Yo7pYwe75W7oe/E7+BCLxaKRguT1x7i4JJSgV?=
 =?us-ascii?Q?uRbFb5PG0ZsR84AbDy2ejwLgu1c1OPM1r0TrUvY0b5UCoBHq3zyq9m1JpqzV?=
 =?us-ascii?Q?81g1cr46xYWDyl+2/2yl2Q1rL+b4gzb4SLCMHR8aCtPje/MBf/liLIuO/eMJ?=
 =?us-ascii?Q?tU2ZZ7wX3ScYbSsqBMZLDvQU5bMGAsy8yEBfZRoddoepdxhXQGJZXGflMWM4?=
 =?us-ascii?Q?pfDFLZ4bMZAw82P2/1rUhfntXnCehZElUZH2hprCunXueXL6VZazky98NYhW?=
 =?us-ascii?Q?7H56pAR1FJUW+mgZRWH0AzYxbTKYbrj5u6068P7ge8JDAyq+ma0MwfeRyReY?=
 =?us-ascii?Q?dXlbUYfa2lEof0JThkvXlO8fy2DXidZFvYDDI61D5zphrFuSdh7mLfIS2Zce?=
 =?us-ascii?Q?ZTSaAA20zx2jqeC9u1wd0rRrc8e+dkqMX3qBieN26JplvqrmUf6FLQwuMf5T?=
 =?us-ascii?Q?WCaS7D8eGeZaJLtyZhUxq7WjgLI1SvSJ03Ahz8uqqMA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d168594-b4ab-4df0-38c3-08daedbea98c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:13:57.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIAoqIrPr6tl4z2DdF9yr1kxDwr2oLcsp8f66jKsU70xn6Gqhd3Tn5idzf2pEF+Ep8DNJPuQkM6dR7PNCl7VEmgmdKpaoHYEse4HPeJI55c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6487
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030165
X-Proofpoint-GUID: neVdGINwwXt0uBuZYXJUDeELV306vcft
X-Proofpoint-ORIG-GUID: neVdGINwwXt0uBuZYXJUDeELV306vcft
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change demote_free_huge_page to demote_free_hugetlb_folio() and change
demote_pool_huge_page() pass in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2bb69b098117..a89728c6987d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3438,12 +3438,12 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
-static int demote_free_huge_page(struct hstate *h, struct page *page)
+static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
-	int i, nid = page_to_nid(page);
+	int i, nid = folio_nid(folio);
 	struct hstate *target_hstate;
-	struct folio *folio = page_folio(page);
 	struct page *subpage;
+	struct folio *subfolio;
 	int rc = 0;
 
 	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
@@ -3451,18 +3451,18 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	remove_hugetlb_folio_for_demote(h, folio, false);
 	spin_unlock_irq(&hugetlb_lock);
 
-	rc = hugetlb_vmemmap_restore(h, page);
+	rc = hugetlb_vmemmap_restore(h, &folio->page);
 	if (rc) {
-		/* Allocation of vmemmmap failed, we can not demote page */
+		/* Allocation of vmemmmap failed, we can not demote folio */
 		spin_lock_irq(&hugetlb_lock);
-		set_page_refcounted(page);
-		add_hugetlb_folio(h, page_folio(page), false);
+		folio_ref_unfreeze(folio, 1);
+		add_hugetlb_folio(h, folio, false);
 		return rc;
 	}
 
 	/*
 	 * Use destroy_compound_hugetlb_folio_for_demote for all huge page
-	 * sizes as it will not ref count pages.
+	 * sizes as it will not ref count folios.
 	 */
 	destroy_compound_hugetlb_folio_for_demote(folio, huge_page_order(h));
 
@@ -3477,15 +3477,15 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	mutex_lock(&target_hstate->resize_lock);
 	for (i = 0; i < pages_per_huge_page(h);
 				i += pages_per_huge_page(target_hstate)) {
-		subpage = nth_page(page, i);
-		folio = page_folio(subpage);
+		subpage = folio_page(folio, i);
+		subfolio = page_folio(subpage);
 		if (hstate_is_gigantic(target_hstate))
-			prep_compound_gigantic_folio_for_demote(folio,
+			prep_compound_gigantic_folio_for_demote(subfolio,
 							target_hstate->order);
 		else
 			prep_compound_page(subpage, target_hstate->order);
-		set_page_private(subpage, 0);
-		prep_new_hugetlb_folio(target_hstate, folio, nid);
+		folio_change_private(subfolio, NULL);
+		prep_new_hugetlb_folio(target_hstate, subfolio, nid);
 		free_huge_page(subpage);
 	}
 	mutex_unlock(&target_hstate->resize_lock);
@@ -3508,6 +3508,7 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 {
 	int nr_nodes, node;
 	struct page *page;
+	struct folio *folio;
 
 	lockdep_assert_held(&hugetlb_lock);
 
@@ -3521,8 +3522,8 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 		list_for_each_entry(page, &h->hugepage_freelists[node], lru) {
 			if (PageHWPoison(page))
 				continue;
-
-			return demote_free_huge_page(h, page);
+			folio = page_folio(page);
+			return demote_free_hugetlb_folio(h, folio);
 		}
 	}
 
-- 
2.39.0

