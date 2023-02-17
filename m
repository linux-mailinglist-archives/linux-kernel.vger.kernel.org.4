Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E2A69ADA4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjBQOOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjBQOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:14:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FCE6BDF2;
        Fri, 17 Feb 2023 06:13:58 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7ikqk030517;
        Fri, 17 Feb 2023 14:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=K1Jn7hVhMr8uNvmhvVtAONAh9Wwsfz+vx8AuJA7IYwY=;
 b=qqlsy19XaEoKXETwlmWgmxxoaUGQMamMBGBHAX6QgOz2ysKRnlI5jqI9bU1NI860wn0m
 7yg8ZAvBWz8tlzcaRsRN9CRAljLuqR9o5yZE/PzY85sln/adVid+hUQR0Ro/O3AaH78u
 QSuzBIE8NrvZI1WWSxK3Nt7ib1JPBhjnMJ0yeskhyB8CsAM7RWsodvIzq/cDLkU9h5mn
 PBOVQ+SoIYgIqMqOUKEAJoFiqx+Kg1f+s5tJjWklmaXIMFQcZfTH194Zd8LJRLSKucq/
 lRjzXtzasEUQP/oYACdI7GiZryw4JQgVGMerX1QEcpRwEGVhWOGD8Xar25dt9J8qJSMJ Aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32cp0e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCc909019951;
        Fri, 17 Feb 2023 14:12:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fapp7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDgu+8cmQVb5XticfoCuzzxGGKxZef5FjtQBTTmFP6AxR+wlKlboma8k4hi67k9oGbQ6fCuzZyL5wPKwi13Ip81ZCiYwt3QkOAJnWbusCbu+AEMyc3kABCNOGhAPqDzio0o8Qh3kSEpYZdCUp4NzU4+Lpj96xajbRl16cpTVwf9cmUnRg3/0tKHYJWR4Egvrmd5HRDtO0tXRJzaeoyj0TghYkmlOInfkuxMuXBbTHMgrz/IzD4nAvW3eweqZ29Z+BXv2iCeoQyEyiXHMwQhkKp6VAaau0yOSpRjTuwzCBKKEC2jsCBpSEXsT2MLlUeckjKLPcP+PFfUECcQiJeDp9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1Jn7hVhMr8uNvmhvVtAONAh9Wwsfz+vx8AuJA7IYwY=;
 b=f8b8wJtl6acg74jJ4l1FJJgen3y6xQ7tPLmj7SBNyyjbE3ePsOUy1gLYtySII6OVp+fJCscBqFTYU+wC0s7tBM48qAyWZcp8P5iROovTZQYttrr9dURSzejp6bi365s/okh4/C3tcI2K8d0XYSAAyukZtCb1Mtjvj/U2sf35i/EF+lf2C1FPto4++xyh9GJEdKkJUq6Si5XXsWAtRz2/jXhhRKsvy0C37Xg7HkncPNBCrDBHnVDV1Y+gWSEszAizsxGRMn2+FfY2yFGaYT6SW3nwEtphX40a2eiK0tddOEU74PLkfT/jmkGNHSb46bN/V8xy+iNibiXzczOue06VYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1Jn7hVhMr8uNvmhvVtAONAh9Wwsfz+vx8AuJA7IYwY=;
 b=yyxlD92NS6IJKB+MMxeelxWAQf5NVzQfK29oV9qPSyYa7zY6WDbwhHrGqnf2kSKztJUSjHMvf80D76yXCF3NToXxZwaJNbUcVEJ6+VYIK+XdLObLKc73xxfaAsl7eY4TBRriPpC9rJGypdhXvrjPKq/+HZ08SiyEGLiBb3N+qF8=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.12; Fri, 17 Feb
 2023 14:12:39 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:12:39 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 19/24] kbuild, bus: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:54 +0000
Message-Id: <20230217141059.392471-20-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0333.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::33) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: 316a6cd5-1c84-4b88-cc83-08db10f1070c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J58lBjCCvKODvg/0nIEqpJ32Wbi/ZtF6V7vw0oY0ZmIbBZXR2EOauEoo7Uo3wGKFOZCG/tsy9SLekuOHuUpoTSoNL1EO1O38Cq5w51fcvJ+bu40fe9GbQsikAo1CTFrMvjQ1HLZbcfBvqronifSHgGvyw1ou76PlKhx8Mduqcrarnd8zthdvRh2OkcLwC6sxfKCT+v7bQwrw4GN45EWXoTSEmG7qBb9MW5smpTBxJMka3K/L6dEiZqBsSZl49Fl1x21L9mb24RscRMKq1G/ZRC5jYnI5j/D+pJhVbtbfCBCuzzCzfUcL/KzcwY+0L/X1LUdCDwOlMBzwtbbln+abXZRn/63Or2VqGJuWIVlL2668BpcHjzHvA1E+PmSFzhYmHJfCJUzfwEdOj80bL4CAUZv7Y6qEp6mvuKj4MOsM6PqO+C92cuayCphHOhe5UT8QQce7mnKBQeNJiZH4jAVQl70fAZ5lLkFAHLekxNkbIiIJoOQccB3zduSowpE8iU+an9G02mRpDlesmm8P0JrheoB5yVDin7v6bwIEh3jcNncu/P7ejfrcEbP3GHX7SLxOnyPqk+Rq0ip0wSxIV5igUSkmDO5emc/4m1DI9iJF9wUYgwMmEDdSNuIYxhg4D9XzIMUsQekIAFfat3pHch40AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(44832011)(5660300002)(36756003)(8936002)(86362001)(41300700001)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(83380400001)(2616005)(6512007)(186003)(6506007)(1076003)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aUMGLruPqockEyArLmsbF0uZJclgFMb2qO9hqLJ9WnF7dyVd9GmlJPC078Pg?=
 =?us-ascii?Q?jrggaerTcHZc8E/qNLeLRgVjLO//Z9FNv+RPMbfGeCM6u06bD/c95da+p5tV?=
 =?us-ascii?Q?NVdaO4YvHVfGkSEjFctTa2bqv2vcacTn+Fm1rWSTLmeZ9l0izGkIEHDi6syY?=
 =?us-ascii?Q?4svoft/Gd1oIHMDwAp4io1hnFl3BVLcfUGjcwHjpTt5Enl8nkDWEyv0ePYKL?=
 =?us-ascii?Q?MjmB/LrzUBg+t/QpmfkkKFHRwIUHsXml8kzsRUyh5H9xCcKcot1vimgH/9pr?=
 =?us-ascii?Q?qG7zmvOgoMSETbqusMsXz63SW6tuz5lSyhcy9nIcuq2QdYNeEY7+RCO1f2E7?=
 =?us-ascii?Q?kVfNL0T3+lhIv/82x7ioo1gwe6shwigi4PqQBRzdY7y3Mp3Xmjlkd4pSL11o?=
 =?us-ascii?Q?MEr4QgtVFumuO6/uecAhhB6j7UsRTPfwOFhvnZacClaWW4gG2/0UvssJJt76?=
 =?us-ascii?Q?3YC535qw6ypfwp4/+9cne8rmEOMgSL4w9bsw8jLdk0znWP2WLdN7hp9dbUD7?=
 =?us-ascii?Q?4BSU0rrToGfMkvmbpIcjDlchg+XnaE3A3omMFViVUXkXCQX12aLMOOThrHsh?=
 =?us-ascii?Q?rHOcHEkPOLWrXCYvzPEDAti9jb1N/L0y2xu2iJ2GyTJaQTDuOpo/5rUUSncY?=
 =?us-ascii?Q?4fa6uCUqCodbo1FDa+65juxpLN9jHOxotRK4P9NLALIe8U5PRdAVHioz5UEL?=
 =?us-ascii?Q?XfYnWHXn+jsHTWifz3aPmzR70U0wDJkEUtR1POm6vsvwAut6+3Lq24oPdeAl?=
 =?us-ascii?Q?3LxA5FvXAJkj3XPztj3wm08LfgKBCtq/Ouvf5jljYUaIqJ8mULt/JvlZO1it?=
 =?us-ascii?Q?1igMS93+WtgZMYSlTPjYFEzHG/fVS4zItjYeduWtxLRSSKSVeBFnB5mKkEBB?=
 =?us-ascii?Q?T8BlsXPk69DmOZvLeNaG6mCJMSV+UpTEuzmfC+k5fVN8a0xsjN7FMXARiBQ1?=
 =?us-ascii?Q?yjIe5vOcwoAfGIIIpufXN2a3HGvKqbGUGwyYIn8nEApu4ACqKichVtAiTHwt?=
 =?us-ascii?Q?dNoXCDxNS+2hz0K+MjRLLIA+44kbL2ahDJZoMVZFxP6IfzuzIf6kJmmDFv5L?=
 =?us-ascii?Q?2ioYDDowqRn6gYOKPzo4Zcp5jRsYbVxqI6uTy4FKcblQ5+FZAmMZo2uQa+UR?=
 =?us-ascii?Q?pzHz6urFH2ou+fYRBkMVhh3Xf/SjqbsYa9jBP4QPd4cxXVv9YSfOnCIgLiMZ?=
 =?us-ascii?Q?A3ssPa9+lcRTqbCIffLaxAwf8c3TX6zIcgJiUexMlYGA8bnOsR1FNqVrorzZ?=
 =?us-ascii?Q?UU95OURSmEzLCb0gIv+1fJsI7VQTltBktcGORLHvOmq4Ic4XcFIV5fA4O2QD?=
 =?us-ascii?Q?++UoDjdC74tJaA+SX/mktTFk1lpKR+h+ATUz9uQQsd+JPopZEb1NHHjtlAmh?=
 =?us-ascii?Q?U+BrBWPuxa6qzZT642atBKHkyUUSYmCCLfllljx244QK870hinTXWxcPHC/L?=
 =?us-ascii?Q?fw2+c41Yt6pPQL1QZl1xqH6If8nLWiMuyX1jy4N2wLVhg0FFMHm9wwbLgNDI?=
 =?us-ascii?Q?YrVbh4wiBvZ+xfAhEyL3qojRYYVcbRDJIjm6SbRp1r+9LKHAow5IcCZSZ2XT?=
 =?us-ascii?Q?7RRIp0yAQB0+M4hvM/P+v+QmldIYH6FEyofPC60OMs6Y2r33O6B7ipUMehVB?=
 =?us-ascii?Q?i9WeMOXKLkqa9eFqpEUj09w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YgW24ljcXr7JXSbBODXCIfymloLxTAxtK0QDj7dTocxrQYIfRISyBtCpgdNjCdp3HocXyYem/zx8kBYMKMRqTM3ECJtF3/nKPppRngRcjvJiuLYE28g8EEE7hXWtBbGezkgnUb0U/SCVm/N8vfz/nV7/Oe6+WmY81krgFfLvWg6r7O7HMKPCy3OTptTRlhO9E/+3P1zE9i+R4s5VoX8OjvuuwTtl9JrNqCqidGu51dzB7fvgBgg2sOZmnZzd26Fls1LCtMMrNwqL+EV5KlJr627tUvI+bMNf835blEWkjdU/Oh+8XRqLHr9JDx1iy7E0znAZg0BiZ6gR5MZTC4WhZuHCexsYFLy7pPfLoJfTa3eo7wktQPqhStalLL3j96IUgBzVMPjQ1PVehAV+pG33dEbkt+nJo+n7fQTl9qD0kdt7/jNJg1qknogwREleDQiq+2i5oeVW5UB7a7vwwhIWqEsAOHBH+vPkcnUIGLbt5AOTXRq2FbpvIkSi74zPzf2IARruSituaZOjxtqWWsPXtBhxNn5NdQl4N7QbUVcojJOky/sdQTJd700YdvigJzrI3Lnr6Rhewkcpi0y51wnfzbeZLavVqFtCNZoFVZ7nZb6piGtdDTVKeepOKdZKmet6GjMXpn/ePc92BTMVtPu4M+Q/T1Hv7e0L3sQ8tpcVtnRGIiilFk6H+9YNiGmT5TTGepFgamlhrjYB8j+/1CVeBSbLRZ17XMZdwxdyK+wblVZxTUZ261HwMUQDVTJr2LT9+1E1gH4eGAP/gybtKwA4/J0w6LymbmzUbPO32kWBtRE8VlR4MefKNYV/lLIipkWueezItd3ycEwAQg4yZwGCGmmL8pHtTLQLGa/GKBbnDLw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316a6cd5-1c84-4b88-cc83-08db10f1070c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:12:39.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzkkujtkQneh2LLKn47Kb0dwq79P9r41HxxpyFdwS8TrD39ZsxBj8pjVNqMwI71AEzCW0MZRIpxNz7V+8G5Nfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-GUID: iFPSqwNDe2gjk9WZATUgMVzhb_OHG6mh
X-Proofpoint-ORIG-GUID: iFPSqwNDe2gjk9WZATUgMVzhb_OHG6mh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org
---
 drivers/bus/qcom-ssc-block-bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/qcom-ssc-block-bus.c b/drivers/bus/qcom-ssc-block-bus.c
index eedeb29a5ff3..3fef18a43c01 100644
--- a/drivers/bus/qcom-ssc-block-bus.c
+++ b/drivers/bus/qcom-ssc-block-bus.c
@@ -386,4 +386,3 @@ module_platform_driver(qcom_ssc_block_bus_driver);
 
 MODULE_DESCRIPTION("A driver for handling the init sequence needed for accessing the SSC block on (some) qcom SoCs over AHB");
 MODULE_AUTHOR("Michael Srba <Michael.Srba@seznam.cz>");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

