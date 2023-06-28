Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED555740EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjF1Kd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:33:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12052 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231442AbjF1KbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:31:14 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S8xpY8023199;
        Wed, 28 Jun 2023 10:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=I63gI5Z2fYJEZuuoUwEztOOjT+fmTVS90Iv/RJgFuro=;
 b=ZV/lgJTDvah8Wu58jgug1BRwD4DnD+qpVv/oXddvB8Ah9jbkzD/r9XGF31r+lTHc0QPl
 Hw2lvrfGbTPyuT7RKDjs5u8GjrEReenDGvYAWEzYh7RPLr9Ilsg+PhDXEpJMxhJACZIl
 JKh5dv+tOVGvpDjBTKMyVClzhPWGKXwLElHb6X9UoZxvb0XYbIwzrLHt4a4BRrR7x+q3
 40XAn1TrtckaTXzx2KRH3CE2ffdsxImURf/Aybf+YnfEd4ols8ggw8UJdtinqvzAaxjh
 8yce+JIFVBHD02/3Nyi/nyj3xtvB7vQg1DqE2vk9qOexd6T4Pxdmzhm+bUzLsLcuyYfJ DQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdtq5wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35S9H161029644;
        Wed, 28 Jun 2023 10:30:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx5tpwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kd0nV1hgjecwgRfeMTpRLl0G7KD5AGmbyttgbe2HkIgC4b9lZYZoq3vAoEQZ6f8fJ+IFPqCwtCZCRPUWeENOvhu8D8FzoeClM4EvxG4GwCxHirNQc4qNke9UhsWlO0tHbIgWkvW4SBgsOqWr4bqCAfBrXHA6FFxbONPQ9hxOg1kKcBDoWx4AnGHRzY2lqVjFG7E1c8XKPXuzG085qlQEM9CPX4YWmGGYPS5RoIprmex9zc4R+aA/QBvNNkOV7nDzoGaL+uBLVIZc63fsk9R3s22cpVC8qFpuJjoGM1+rfKz41vUZ3k0Vv+k3aWC22ZvfcUHPrjY3pgh+PSW7SQoHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I63gI5Z2fYJEZuuoUwEztOOjT+fmTVS90Iv/RJgFuro=;
 b=UzmaZS0a0o/92iTILVc4vC7B8CTdhesJpRMuFV2n/2BXNM6AsP5EOuYhHrTirQs440j+R6tVLGGHOfcC7tYPHBwoEhXx2voclXiRWpCUKcx2ClAALE+bCAHc/vY3+2TZ1/DG9oDPJg+yoVSnyNqDtVoiVAkbxj9JnObuEs5KfUnYv/m/ZvHSos/bKaLrm3j2gnFLXRdVJMKOQ0yDu4aq/7dTrsxedcchVk901snk2BUEQVno4S9YnSxr3Yp6f5wkeRB9JNWv64wevJ7GZNE59HILb7Cm7NN08zUH+eOcYJ3FJo0GL6pfmX8Kj1BzMgGQhOQqWiZdWKeMmUJM8XTCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I63gI5Z2fYJEZuuoUwEztOOjT+fmTVS90Iv/RJgFuro=;
 b=vRKYcJnABQ7kzxx6DrJacC6OFv3G+495JV3zcbKIAflh0KEpdYDodIg4Umkk+gfIhqZLA3blgTIK9lWs+3Ufoto5pGuX3doEkaYtSAIG22s99kTNbPrOHz6Of1VcERH8tPPgdWuBrgd+9QIMU4qkf4Ns0Ytn1UokFLiD78USfZY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 10:30:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 10:30:20 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     acme@kernel.org, irogers@google.com, namhyung@kernel.org,
        jolsa@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 5/9] perf pmu: Refactor pmu_add_sys_aliases_iter_fn()
Date:   Wed, 28 Jun 2023 10:29:45 +0000
Message-Id: <20230628102949.2598096-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628102949.2598096-1-john.g.garry@oracle.com>
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0182.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 00582e73-4061-4588-f35c-08db77c2ac8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCh1JtPZmod7/1xma3t754m87XlJQ0JNnAcS3y/Q8C1uAXDwB+oJdjKjn0aP2QnO5UV1K8k+WJgrcUT+kU5Vr18QSvl7F0Htt9+pIzYsTCDoQ82+dSoPkC7x7YKX4v2JdAQ8aIQjvgiJ/7Vfv5aKyY/Fp+wNSvljh10r7h6cR6YVxTrKFcS6WZpM1hDdfCAdhL7hMo+jV0a+tHRjasuDfAR7NFK8Mk25D/rlxEcnb2NgESK5ks1u5yabVVI+FqpwR/faKlTUDJicPdAH8uWQRpkm6E/meXq7CD5Or61vE8Ijz4I6ja5NxqsRDsjm5H4VX7E65K5E366jphOfM6IOXJ8fcHEbX0Vj8TQ11u8CThKOQStd/wAf2oODnW3jh9XzwZ/SNhV16maXYfAlaJnNgHZW5ZTtLpKMUOHyQhQkvXVm2OOTKSK2GYHdZQYcUigzOrK71QhS2agRPclDnty6DLj00x04En53/hsVzABBzC5ljbHqgs9NcgDqn09ByPqnmIyl3/H2rVx9eEqeI6K2aEAIMkFZOz1XhItEPvH5BDf5WpHd7G20SVtUHspT953/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(38100700002)(83380400001)(103116003)(36756003)(86362001)(478600001)(6666004)(6486002)(2616005)(8936002)(316002)(66946007)(8676002)(41300700001)(66556008)(4326008)(66476007)(107886003)(1076003)(6512007)(6506007)(26005)(186003)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aoQUDfpqVY0Lv5E7qaVZJSi47+4AlvejxAybgj8hgtC4ZIlVjHMxgoH013/O?=
 =?us-ascii?Q?FNBq1Yeq7gokT4yxhGGcS/C2F52dFQPgTpiR7LRI2QVUjRv8G13ZUnEyRrpy?=
 =?us-ascii?Q?uXa6lmOd4NWkX5TlA8CkKV4xlbJyRAVF6/O+40bzT54DcmkjoTBgh9fQRmNS?=
 =?us-ascii?Q?OiSx7PYOwhl0nJ0Xag8diDsiTv/x5uUjl3xqRcueoRuJgIt4FIny3hg/rTSy?=
 =?us-ascii?Q?HqwtTf5rNypR8WGRZht1IqIHCODbsVXh+/IJYY9722CwqfJwFX0CJQ90y40K?=
 =?us-ascii?Q?osh9Qv28fuxoboBth2DePSFfb87Y+vr/9BosaauMtN25GwkKKovcUXLHnNz1?=
 =?us-ascii?Q?L40fb18xMhB1wET2gbSm6E4bralblcd1D9nzAeZ9+BzbAYlo1sQMo1sI73XY?=
 =?us-ascii?Q?XsbRCjYFqq2te8CWHIZvEzOhQZVuIki71UvrFqa6gFAfHZDhYOVJ65YKwISf?=
 =?us-ascii?Q?zJAEU8y2rqBClw/bNcDXcOiF6KWGjC7bjdwxw/0Z7YzxvPE5obdyAZ7rVsHU?=
 =?us-ascii?Q?VH2mUlGJ2+ZQ+CDI3gsoZTr6s6Tz9ZulzRflvWQSMjXuWcgBpbZcjCMoPhFD?=
 =?us-ascii?Q?eBBHsQo0gfIQIBXdMBq2EEt8maSNPly0I+UQ87RiRiqeSCDKtjjZbA5B3r49?=
 =?us-ascii?Q?zG2Wc17jyz0ycnDHhMS4Q0BwNbIuEYnrjA/uOwUPh+TEfLpw36CV1/kYbrm3?=
 =?us-ascii?Q?UEXvhP/dl+pdma2JkC0bv4JxICudEbvAo4M8wqIUKjiRdvVU9uivkfXgB6Fs?=
 =?us-ascii?Q?vdS13CBE0i06YX42299VX5Ymwm+6lcaN7H6VHeau7R8eEkCVLFWPhCGrZvRF?=
 =?us-ascii?Q?aECOiGT61q54ecpKy9mGmzJaeLhH9QBIIsCtCJ0t7hGSg0kfficL5J8mkt1Q?=
 =?us-ascii?Q?MUVKst8N6LzdtJYZvL2IioFs5njqd0FTdeP/EcaXAU06Ci705ubPj8B+HQAr?=
 =?us-ascii?Q?4OWzGjQRKMgfIbB3I7LxgRvK4ukQsPV+lqQ/uvyxK7Am35LbTpZhz4Det7F2?=
 =?us-ascii?Q?f9lJIIMPq8oC5+ZOCkMc/L2R05eZcV9zCCanRvmoYaoK2VRcizk/95onCUBH?=
 =?us-ascii?Q?Xq7HCH6MfZZYLCCab7dRhcWYpMLoIYQ/ug5ksWlRxQH5czGCh+VVzmCVG+Ms?=
 =?us-ascii?Q?ZyDF4Q6edKjMG7FD6ER0G1k7ACSTT2cxtqGNjXSQhDswZI0SMiDHp3mk/0np?=
 =?us-ascii?Q?i7UZwLmcLEvPUKjaA/CyjmpQTnsqXE2lOXFqbsIvGJc9cwlHOaSC1UABfSPN?=
 =?us-ascii?Q?dxT2Drafu04tC8w6yewqaKphycXTR/MQMfICU25S07kbD6lvGNavgDJX8UwO?=
 =?us-ascii?Q?+jg9ElmBNN6KWGDl88bQvyMa2GuamZXz04oP/NyvOJY8Klm45cUSA8ih+P7H?=
 =?us-ascii?Q?2Iz1Cx0nwygAti0oKadpCDZO/alZR8gNzvK8Kb/tpBj1x7+64o4Ct3OXMSOx?=
 =?us-ascii?Q?853il4AdfkuuA9rcgu3xZACwSP1AjP3k3RL6QVof0hc6J5AXhZ9LKw1B/LJW?=
 =?us-ascii?Q?cGp4Z8TFRdbUHp4p86rhQN9vHx5qGGdwuePeD8GZm/Tx6wHMrK2+HZ7d+D0V?=
 =?us-ascii?Q?9TLvkUxrSP+kOXaasg/t4Xmhyn3vBbNtWwibbo37UsNBN4bod76NMJqZ2930?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?H258B0Xpc5mFJg0Icsx7rm5Bd4Z8EHxJBSjhQ2P1xNcHTfhovHLyy1I6PL+k?=
 =?us-ascii?Q?SYeKr0P9WyuQszul0rg9E43CBhoiNVd3dP+nwPXF0GekGDkzix4ss7zwwN75?=
 =?us-ascii?Q?Tt+b5S0dIezrji7y9xwxQTrX46f4sjb1BtT8h/g8jLCxxH0pGMsMOOk5AEpR?=
 =?us-ascii?Q?PO2b2ebNhmBPvQOWbiKUCfKt0XUE7pxYuD8gRWJLRu2rqp4u6cikBQdMOpHP?=
 =?us-ascii?Q?ZrcZiq8qgfBzkDplDqfj9nukfwlxya7mltMhhrmHQ9iyICLwEKbneT/rjVH4?=
 =?us-ascii?Q?JsB7SoyXGKggssuygOm0xL1sZ1bQK9us5CzL+vvOvBsxEBy6D4rOyNVzQmXA?=
 =?us-ascii?Q?g8OwYm0IrqxFywcFYTSjiS8NpfcujzgOy024OIhaZbgjTcihaj8uaiUo8NVW?=
 =?us-ascii?Q?s4xtoc/qonCndo8xT/hV2i+2aKEDaFEVsEytf5MswnXcgDSs3nRTXXLxEtor?=
 =?us-ascii?Q?Sahg0/SeC9v5Hie5YWxnf0XPdOmzROMvx/zGBf6UQAIAt6jA1bbraSADYR/M?=
 =?us-ascii?Q?Dw+MNbUiS00ykksw37YN5inhRNEuiRFHaZUhHH9cHRny/JPcs91tYaDEvSxf?=
 =?us-ascii?Q?a7DNZoiIh2jxrYtj8dPlFnlUMKVmhwfQnA5oNB8BuwV/0doX4taFGPZHC6DO?=
 =?us-ascii?Q?aAeTtdlVq2lJiTUvfw1I6dNuSsVijK5Rkb8guIJKLwYY6KXI+lzA7Kd0iCvf?=
 =?us-ascii?Q?8RtgizSqW4reRZMvKl2KZRbu4M73o09AkYAv0YYKVIJGfkChT7r/KIcVRygI?=
 =?us-ascii?Q?bjxFCA4OJL1p9lrKust6EWwtUai6VOrKuqXgy3LlsSRr9tQ1NCfejo28l0j5?=
 =?us-ascii?Q?SGgcy+afkoBIeN/zTtEjrFT83GCjWA2EODTY0Oj940pN0y/dn9ygMAr5yGw2?=
 =?us-ascii?Q?pRfAmJ0FDEzgq+bck6SYl8/XmcD9BJTkrVfHk4LtdZ8JfW4MNrTjW+oxNGND?=
 =?us-ascii?Q?ZZ0yp25AuqshGb4ReBM1J5o/qFlrrAwgt+vyOniqaqR42akjLQrqrRtVUQaV?=
 =?us-ascii?Q?+AVLXDy8GZWg1T+6ncTNlimK7WDJBKrjfaNwJ2Vvj6c87FK2wRcVzsITqur1?=
 =?us-ascii?Q?+OL8T+Bey5rqh48UvjMh8fCfd/R8lQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00582e73-4061-4588-f35c-08db77c2ac8c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 10:30:20.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYcp/nLggZTXjJ0FTXkRheU9aKJifjmjkIPzKi1ANE+K6MvLeEoCyj65ID5I0jJW6l3ez8Ntam6ZOBVYaym53w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280092
X-Proofpoint-GUID: ZUQObEtsCYZ68AeawPRFgxxHM6rCd_kK
X-Proofpoint-ORIG-GUID: ZUQObEtsCYZ68AeawPRFgxxHM6rCd_kK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor pmu_add_sys_aliases_iter_fn() into sub-function
pmu_event_match_pmu(), which is a function which allows us to match a pmu
against a "unit" and "compat" values.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tools/perf/util/pmu.c | 20 +++++++++++++++-----
 tools/perf/util/pmu.h |  2 ++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6142e4710a2f..ae1a2a97965c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -801,6 +801,20 @@ struct pmu_sys_event_iter_data {
 	struct perf_pmu *pmu;
 };
 
+bool pmu_event_match_pmu(const char *event_unit, const char *event_compat, struct perf_pmu *pmu)
+{
+	if (!event_unit || !event_compat)
+		return false;
+
+	if (strcmp(pmu->id, event_compat))
+		return false;
+
+	if (!pmu_uncore_alias_match(event_unit, pmu->name))
+		return false;
+
+	return true;
+}
+
 static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 				       const struct pmu_events_table *table __maybe_unused,
 				       void *data)
@@ -808,11 +822,7 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 	struct pmu_sys_event_iter_data *idata = data;
 	struct perf_pmu *pmu = idata->pmu;
 
-	if (!pe->compat || !pe->pmu)
-		return 0;
-
-	if (!strcmp(pmu->id, pe->compat) &&
-	    pmu_uncore_alias_match(pe->pmu, pmu->name)) {
+	if (pmu_event_match_pmu(pe->pmu, pe->compat, pmu)) {
 		__perf_pmu__new_alias(idata->head, -1,
 				      (char *)pe->name,
 				      (char *)pe->desc,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 8807a624e918..8cccbc9b2548 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -288,4 +288,6 @@ int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename,
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *lookup_name);
 void perf_pmu__delete(struct perf_pmu *pmu);
 
+bool pmu_event_match_pmu(const char *event_name, const char *event_compat, struct perf_pmu *pmu);
+
 #endif /* __PMU_H */
-- 
2.35.3

