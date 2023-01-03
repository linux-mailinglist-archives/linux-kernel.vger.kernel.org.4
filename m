Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5162B65C748
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbjACTRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbjACTPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:15:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C27313FA8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:14:30 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303JDwAZ027905;
        Tue, 3 Jan 2023 19:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=EwC5Tm4tgFzepPQEIJu9ctB3QRjFntVvmEbyFza6K+E=;
 b=nBNsu+oP3XPM4qMCBbKkqxzkB7okLIRkPYeUfmSg+WbqO2y9r92FsI+D1z33/s8Tlgm8
 83RW6DdqFLL3tvHu0LMKsy4PV2JDECF3WQ2fjiPk5/IfuYpCBusyVsKTRfPiaK1xGRuZ
 w0GbMLTYfGy2qrHhVS/yNARcClSrqE6gOp+FF12ZmGb8qv8Umi4oPGQ2chbqbSmapv62
 X6qqIFpgGkNIDQdsx5GDlx/oXNYsuxyEVtqQlRGZ3Dkpaz+6cel8CMO+GiShEVpSYb90
 xtKSY+pkk6KPC9K0tgVRK3CPG7M0g0mkjZoILT3Es64K+2b3/qewN/w48gCrS9ZMiXoJ 4A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbv2vwxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303IOtmQ012258;
        Tue, 3 Jan 2023 19:13:51 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbh58pxg-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+RsjuuuS1WEOdWuqwdhnTIT9HMc8HOgDZawjlvY7TiHGMPfpxLF22omtGxUsx33DOYbwQWfy4UrZiA+mXwyMQXAsV1Z9A7pJGrCkUO/JnFN2U4J8SDFr3tQOr2kvrVG+BRPntK/UWaFDpiBK4AFI2bCJiWn6k2LF3qoyKDqK7ZqP5JSCeDa8bEg6oCDl944UM3bl4+0wOTqLtgwgxXQ1EXCh6MOSvutnDUzz4bUjCBuGdQ7H/VdlDs0FQu2eiQn2anAn1adOIt+Cg2QWrpeRTu9he1xn4wF/dB5qOpJOUIy6i2qBiYRrrmFBgU3gAGwr+NBLhEaODP/H7l2g2d9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwC5Tm4tgFzepPQEIJu9ctB3QRjFntVvmEbyFza6K+E=;
 b=VFxU3qe4B+FsiCHYTGurhVfP2Y3RzFSlxAmLhx4qcfZpVUd5aeso+sGjtNAS3XDSPHLdjFo9JfshZ/Dkqi7HtRGrFKviygsgXATyJdLzNwXPSjwVI6JFxw7rHRNvNrwrXpLJKCcp8pZVYy3Db1dWX8VUaDRwzPl3zv6oW+0nUs24omq4LIvXR5F0KTwNvwiYo2pM47EfM384Cy37KKKd0EZlXh3AzwlVr3O+pyLtBdkPel66u5b6C4ZHFHYcSu++CROkcx90sXh6i5umOoDneVIrCQbYwsEryINUzXLbbvwJr4UN2W0H83Q89Xp2daubbkBRZyF/Uw/k5i6yWhBFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwC5Tm4tgFzepPQEIJu9ctB3QRjFntVvmEbyFza6K+E=;
 b=QFewjOTFIwHVKfwMF9uYmZ1FJpJz6hZ+uKMScdThPdK4VGgnPL6DEvvCPav0ysgUyVdxbNhoWba+PnBvRS4CbABjq9yc+40BLNvK1l1hZ4M8XHIIsSt4SS7lBTakh4vDDA8hDCQ9PaZqVb635R02kammt5mlKyOMH5ghEnALtC4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7332.namprd10.prod.outlook.com (2603:10b6:610:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:13:49 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:13:49 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        jhubbard@nvidia.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 3/8] mm/hugetlb: convert dequeue_hugetlb_page_node functions to folios
Date:   Tue,  3 Jan 2023 13:13:35 -0600
Message-Id: <20230103191340.116536-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:610:4c::33) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: f64d99a0-55ce-4e43-92a2-08daedbea4bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEl55aI6hzNJjAEIcnB5lq3ENrgvJkwoJynAhqiJb9kNOmSaEq7ixbejRhFkdNMq0WAO8bJ/RQ2malI/4VjvQgQZxAWvwuw8fzFuzYqUEWi3NCsR1dhx1urWOGOJhcXVUWkShzBHmDb5UD+vgrvbA+SzY8dUn8CmKD9w9LeC0m852Prs098hCTMvGdkluKukMa8RKs6DL2dsP+AoOl6T8UKk/S71G5Ha983s6MWH/CqaEMkY/A+/3GiWnrD3UzfbmqfVeZTkDDOYJjefuchyMAAtgsqlNCmQIuDHsscdj3iHhnkP4XEEfbad4EfzfWcP8Fj5Khxx9cwsKSFcj2Giv09HMXke2l69M/A7KHIP5xYU/vbzoZQzsHNtYPCGvRvg3c+10XbJLSnfYEF1HffobGUQmWHLMejGUo3TosV1EYbpPcS6unjaOGxYAcKiPgmXimkL/NUAqXsq9beP1UfpmZ4kT45WVs0cVIBP8d6EuPZ4awrziCkQUD+1AgS/folo3D+j3NP0Ru1Kvwv4Z6CAAFP0PCMIeP+XD3GGxd1P0Q/QtJXN8ZBNP2Dasm360fUVqtoOc3DIHXWJbUEqXK42HRIIOASOMjpnyziWz8LdbQU8sCf1ksBtDqfNqxEO6hWRpWHaMu+3w0I+A4APdUDi5HRct7F6uiiY/0Sk+/MwrXOwGzBsSnbs8QUOioF1GtfX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(5660300002)(2906002)(44832011)(8936002)(8676002)(4326008)(41300700001)(478600001)(316002)(66476007)(66946007)(66556008)(6486002)(107886003)(26005)(6512007)(6506007)(6666004)(83380400001)(1076003)(186003)(38100700002)(2616005)(86362001)(36756003)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LWj/Kt8uqfZgktrCSqF8sQgRMsTzJzUYR1ikNHAS1dLfQ5C+mhQ6yjGo4/54?=
 =?us-ascii?Q?V/4Jof8p+FIYU6BQZsAzxWgPFLHIPc0anHw0mWjUIkTswR10dixW1z7XXT3G?=
 =?us-ascii?Q?nssfqWOBH98ZoDoeWHBOCsyy0F13rgqsPGA/kSM90nsPzIiwRGSpRbUj3Rs/?=
 =?us-ascii?Q?Tjpdnuyn0uD0C1qgMVxTFNPWpUtfisfkeehgHqhVaV0uVBJhEyggeBAGCy4l?=
 =?us-ascii?Q?i9gxLnk/uCO0uAnQC4Dtpio+0D4Q8R4pKKaZveh1P545tLvILhl8nCqp13uy?=
 =?us-ascii?Q?EenjJoi5DEwToawLomP7TDR5PXDAO1fHNFmNnONguTWBOL6E7AKdG9M2/doK?=
 =?us-ascii?Q?oPYbwuW8iAC0CNmlzmWFOyG6yz6/qo2wmFWS6ZTO8YSaWFS2Jpg4zwEFLyoW?=
 =?us-ascii?Q?rye7JagXywoiLk2aC86/1sU6SrsMpj9nOx9fdk2h2OV0NoKrcUEDs0uzhBBG?=
 =?us-ascii?Q?CWCayxPoneV6qPuKW732YpiU8bE0LZyETdIgq714iPbp/tzEAepKryaYb9VB?=
 =?us-ascii?Q?AlWsmuR5z8gG9BDieozieqtyZ/GRCIOndq1zCG1KOCvHhvWayWWLXYFyETWC?=
 =?us-ascii?Q?aeWJbXkhDEBYGP3tlnrVKnUVTR1sIMFb9OWvBSZXJZcQa0L64Z46eCo7NpAd?=
 =?us-ascii?Q?Aw7ZV94FYGATadnHCOr0af7R7QE2nLqSDHaSVOBbByA0tBIIoG5Wlho2LbWa?=
 =?us-ascii?Q?r1EaOsAmxElMGmuNPIopy4jdQ2c3CiwzlY9Vt0HI7oMYTFbxOwkiftqjQUss?=
 =?us-ascii?Q?rUMyfVmhWfjqfyZHd2hDB2bG+MS9pGo4/xL78uir7q3JhGEQXJKlv1MEmNHR?=
 =?us-ascii?Q?JGEAQzNc7b7SxO+wTQpz4Cld5s+cEM1MO7yfCJFNYQIhsxo37tvyJPeyvaQs?=
 =?us-ascii?Q?5Xhos1QDm2lIRohjpJ9UxCG/UuUQcDGvmebRsSYgW5xDQ8Ib5oGd2LZ5lyOA?=
 =?us-ascii?Q?WhCw6VoEhsxvuUG8xk8Tdr5MmOylbfCBa9fUqyAPn49wREiF4OIfuyWs+DIW?=
 =?us-ascii?Q?w9fMMMxKg8zB+U10VUYv/DebjrUwkM/mEgr62Qf7H0Q4ZoI96+AAkqrWmsyv?=
 =?us-ascii?Q?FxGeTOyyZY31ZiAKtPVHAD0jqC2V8TCEVyZE/9pKIo+vZw39TsJg/jRDe9ab?=
 =?us-ascii?Q?q7D5TFByrdEGTW3NKmuIXa8EhTsQbCjO5sZCtRS/7hlfh6jW5Z7hs8yM3sCH?=
 =?us-ascii?Q?fm/I6qqjXpeIxDkPodvJCk88MQKBWOUfN99qSlpre1btcC/+J6Hi/ybj998d?=
 =?us-ascii?Q?QYAKA08DODwXua6dDTu2+CAER+Qd6668sbJUzD6IP5iGXeKULwwDZJBYk5uY?=
 =?us-ascii?Q?szvPeDCOBwG2ZUwMlppJ29/a0J/bkN+ysc0Ls9E6Mixp8uNDLs5uipgA7Lmy?=
 =?us-ascii?Q?Y+A+DfYei2rbNLsNseC+UIkgwIBq0p4OHu168YLIVVigj/saQmZ6X/k/O43n?=
 =?us-ascii?Q?VvivJLjV+R3BHT8J6R023oNaZq6XEvd8i5Mq41c/sl7TeAJOY8kaW6QEOg1T?=
 =?us-ascii?Q?IBrT0BfqDZFBZ1YNi9ArVARhgMljTLwcAEtZkHIpe4rfnGJSuYQ5ImXqQ7rb?=
 =?us-ascii?Q?I/uVqjglZf2HNPXizwwNjLarF8/JReF6B9pG0pIbjQin7iEOOaTUsOaeG+kt?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yxoTa3gafFucGukwHcFuDOnNCFCy90saecm++RiSypoMlFGCoGmfKrWVXnwG?=
 =?us-ascii?Q?KQOqvlZ+TMgmABQsZPxeRYpyZHDz//rYl8LDwpZtaqOA/y2ardUOZaT9e9/p?=
 =?us-ascii?Q?dy0Q/Nwha0B3beiRH2TlCM/KUErTRQDDO4fb3BAdcUpw1csiPZCXwU93hiu/?=
 =?us-ascii?Q?e42BVQicgLhOR173d8v+OsOafgtOIABczaIceC9YjldfueREdxmuUGZNEDml?=
 =?us-ascii?Q?Nx/3dyEXY6o3QBmI8uALPRNwCuHBkKql+bbmdBhzmZTcMINDaAsClBG9fKap?=
 =?us-ascii?Q?loU8pq9x5sSeuwf0DS6LD0iKIwZ5eso164FeAc2cxO6MkTUpCv8LGjJRuLAQ?=
 =?us-ascii?Q?28QpzL7mAZMeZl7ss08TQBzMdvUTUcNHAlS4QoJteaz2yeUrTsHNZWXSj96C?=
 =?us-ascii?Q?XLomUb2tHgSQDrRlkORlGcrrb6OsGU2S4Z44n4TaIdcq4R7MXCerb/GbkCwK?=
 =?us-ascii?Q?dYm4uXPtOp0n1gKvX9JOJtlUosBIqFQxG7of5w2/g8Q76Epu23xiTBBtH/2U?=
 =?us-ascii?Q?AALBYhitE8MPVaMbiOqiEWw2Ef+DRaKummKN0KEe5l+gEMG4gKH52M6zyU9w?=
 =?us-ascii?Q?20JQSXWYdiEebQ6TpNZbmt2pqcxiEeXI2zawqABV371putGwdm2HHUM7iOR1?=
 =?us-ascii?Q?rB98plT8KDNREiiu6St8mr+Z7CxGXWdcv5iuQs6nQDn+MPss1OIAaIlWZthk?=
 =?us-ascii?Q?If0poLkcxBXsK9FbWwL1ZBH2kkxRHc0xYMgOFyvXfPhdWzsE85gJugb182Wb?=
 =?us-ascii?Q?itz/QLt0EGXFhhsxGF88u4mcxqD0Rf0WZpZb0S/ueVoCtj+fDjn8GD/QiKqW?=
 =?us-ascii?Q?rBg/FG55IDGyi3zlauW7uncxPhq0f9YUN9FgctspiDFj+35msBmdYfuCYk+T?=
 =?us-ascii?Q?HCg6MJAreq9UawoWYgjW83RfU8GoSEXe3qveECSHAiiv8svXvX7Vb5Yze5ho?=
 =?us-ascii?Q?fiajzTuTzpzJcCcdtOmWK9VYft/zJGVcR+NQXJ0u1OU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64d99a0-55ce-4e43-92a2-08daedbea4bb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:13:49.2015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 949dJKJ94SLmN+1+5K/tjnfms6Z0RIWIg3dlfQmEbXjDiDKwqJN/cPgf9/pHnoFcOSR1QsPJemd75D8UFPN0YGiDEikwqKyMjYRtl2gFBf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030165
X-Proofpoint-GUID: 0J8ymEVbajvIS9xvHQIgQrHItO0m3Oj2
X-Proofpoint-ORIG-GUID: 0J8ymEVbajvIS9xvHQIgQrHItO0m3Oj2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dequeue_huge_page_node_exact() is changed to dequeue_hugetlb_folio_node_
exact() and dequeue_huge_page_nodemask() is changed to dequeue_hugetlb_
folio_nodemask(). Update their callers to pass in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 55 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b06ec8d60794..8dffb77d3510 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1140,32 +1140,36 @@ static void enqueue_hugetlb_folio(struct hstate *h, struct folio *folio)
 	folio_set_hugetlb_freed(folio);
 }
 
-static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
+static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
+								int nid)
 {
 	struct page *page;
+	struct folio *folio;
 	bool pin = !!(current->flags & PF_MEMALLOC_PIN);
 
 	lockdep_assert_held(&hugetlb_lock);
 	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
-		if (pin && !is_longterm_pinnable_page(page))
+		folio = page_folio(page);
+
+		if (pin && !folio_is_longterm_pinnable(folio))
 			continue;
 
-		if (PageHWPoison(page))
+		if (folio_test_hwpoison(folio))
 			continue;
 
-		list_move(&page->lru, &h->hugepage_activelist);
-		set_page_refcounted(page);
-		ClearHPageFreed(page);
+		list_move(&folio->lru, &h->hugepage_activelist);
+		folio_ref_unfreeze(folio, 1);
+		folio_clear_hugetlb_freed(folio);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
-		return page;
+		return folio;
 	}
 
 	return NULL;
 }
 
-static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
-		nodemask_t *nmask)
+static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_mask,
+							int nid, nodemask_t *nmask)
 {
 	unsigned int cpuset_mems_cookie;
 	struct zonelist *zonelist;
@@ -1178,7 +1182,7 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 retry_cpuset:
 	cpuset_mems_cookie = read_mems_allowed_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
-		struct page *page;
+		struct folio *folio;
 
 		if (!cpuset_zone_allowed(zone, gfp_mask))
 			continue;
@@ -1190,9 +1194,9 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 			continue;
 		node = zone_to_nid(zone);
 
-		page = dequeue_huge_page_node_exact(h, node);
-		if (page)
-			return page;
+		folio = dequeue_hugetlb_folio_node_exact(h, node);
+		if (folio)
+			return folio;
 	}
 	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
 		goto retry_cpuset;
@@ -1210,7 +1214,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 				unsigned long address, int avoid_reserve,
 				long chg)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct mempolicy *mpol;
 	gfp_t gfp_mask;
 	nodemask_t *nodemask;
@@ -1232,22 +1236,24 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 
 	if (mpol_is_preferred_many(mpol)) {
-		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
+							nid, nodemask);
 
 		/* Fallback to all nodes if page==NULL */
 		nodemask = NULL;
 	}
 
-	if (!page)
-		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+	if (!folio)
+		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
+							nid, nodemask);
 
-	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
-		SetHPageRestoreReserve(page);
+	if (folio && !avoid_reserve && vma_has_reserves(vma, chg)) {
+		folio_set_hugetlb_restore_reserve(folio);
 		h->resv_huge_pages--;
 	}
 
 	mpol_cond_put(mpol);
-	return page;
+	return &folio->page;
 
 err:
 	return NULL;
@@ -2331,12 +2337,13 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 {
 	spin_lock_irq(&hugetlb_lock);
 	if (available_huge_pages(h)) {
-		struct page *page;
+		struct folio *folio;
 
-		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
-		if (page) {
+		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
+						preferred_nid, nmask);
+		if (folio) {
 			spin_unlock_irq(&hugetlb_lock);
-			return page;
+			return &folio->page;
 		}
 	}
 	spin_unlock_irq(&hugetlb_lock);
-- 
2.39.0

