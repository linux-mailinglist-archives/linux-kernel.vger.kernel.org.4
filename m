Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E866A69EB14
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjBUXPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjBUXPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:15:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246BE32518;
        Tue, 21 Feb 2023 15:15:40 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LMiK7o027553;
        Tue, 21 Feb 2023 23:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2022-7-12;
 bh=usXzotv/Uc1FbJNQJIM3TLoF8mvHgfZLBTFIltWf/ic=;
 b=tLBL2Q1gYwxTp5l3FOBo8hZCzn/PlkM9q8olHZtW9yDVIdFioNDVYOMMX6f+snMzsNCp
 5EpEPrAeU0+nZrjWB0ke3w6cHBZXEJHtLZsWr+sdHU9WEqSCrQE0u11yLyXAnrsF4yIc
 0SWNrkdOmamuH31LlNb4rwSXorSPyelzUgN9WH1DipJCEd1+fhMQsAKpQqJdCHsQVpB0
 XiP6XU5tdFO8COLtG1eRWYY8591Ee0UW/aoan7qwEYzw0faxnSpOmKu/aMdZTKYKYVag
 5kpzbozPd/NNBHam1qMG59+rDouoKWJFOMIuAEXK7Os7EWXFHck3qzUd6X9PxYQPJf5r Vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntq7uehwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 23:15:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LLEwoW023254;
        Tue, 21 Feb 2023 23:15:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn45va80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 23:15:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR+frjQjNBvzXzoRWllu3RvKR+rPNB1R7xasYAEJdPvPL+KE+I4LHgjAH424YOjdW1lli/LouU9OO7rs3eRD6f4FcNeBSOroAjnsWfZgXBTnnnb5hBaU55SobKkY8rQS/j5tdQqfYJBWjsKQftWxpp40LznxYoQI7OjxPyBoTYIlkqaytzFp+KEL4TBkElELweacCZW+lT2FwAN1eWBe+wsJyMIrrmNZSrUyqcsIMOxyRIU81Mf70iaUFD7X2kjDke/wAbtHm/Ozng/KKJKPeec44kalh8aAg3+rf8cfdDiBjMxS/WUsHkkDSM3AwmmXNqKiurCf7572GlQwoHSIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usXzotv/Uc1FbJNQJIM3TLoF8mvHgfZLBTFIltWf/ic=;
 b=W+0eFlk/3RJsGCkvK8IpC0sysjs0+3MMdL2aZvzPqvDlDzJCUh1mSxFulA3p1h+aGOIY7t3NPxUBJAsQ+7m2Z1gHRJMyt7Y272vklrh6QWquzBRScOEINY+Fix0od9LFh5FclH9gpjuFKUr/Mnyo0U+L3Jmyra4BGWolp9PokrwKnUexX0Ftz6+WDg/55A7AZxHgLvyfu7/T+UGNDT9dBG7FrrSd2tcq21sWH2kL7b0h+SIpgf3FMOh8sgqPjxiGYnFaqcUToXySn1vpyXy0DpUeqIl5UHsrAw8TO4zDYsPpPWOZRxfrY4VmToBVU/l9IB5oYBoZyqFNUWFw7qquFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usXzotv/Uc1FbJNQJIM3TLoF8mvHgfZLBTFIltWf/ic=;
 b=DA5oShY0SBSTevGZ5/AsaV2R/dlNsgT+6VK5Ymy9mJWJdQiP4meI5d2MjNBVIJRN7dpY4ekCjvtAbXCxpuhUXuqsY89hylHsQHB5o+MjApXhvXzTztevRFnNjXwONc92RZXMzaNHTz8qEPsngGbK7WFdVPlt3q0R2qt9rfKA/bM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB6876.namprd10.prod.outlook.com (2603:10b6:930:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Tue, 21 Feb
 2023 23:15:25 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6134.017; Tue, 21 Feb 2023
 23:15:25 +0000
To:     Yangtao Li <frank.li@vivo.com>
Cc:     stanley.chu@mediatek.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, zhangshida@kylinos.cn,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] scsi: ufs: ufs-mediatek: guard
 ufs_mtk_runtime_suspend() and ufs_mtk_runtime_resume() w/ CONFIG_PM
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20230220142431.54589-1-frank.li@vivo.com> (Yangtao Li's message
        of "Mon, 20 Feb 2023 22:24:31 +0800")
Organization: Oracle Corporation
Message-ID: <yq1zg96r4pd.fsf@ca-mkp.ca.oracle.com>
References: <20230220142431.54589-1-frank.li@vivo.com>
Date:   Tue, 21 Feb 2023 18:15:21 -0500
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013DFA.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:d) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a77bd4a-35e4-4edc-01c0-08db146182e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Po6acwtd50X7ZCmjIdtYdIvD3BlPgZNRcL71/Uof93hQxHc8s19gFuJF1qztXvP/sxQnVI+NwCZkAdz4iRr2h82BbDNtjeWxHwbscbjYigBWMfyYe4MWRErfMn0phiJG7gaOtVxMLWbRUXQo8t1O01osqpTPOzER0EemlGE6A+EJlbzD6sM+2CuSE2ykSQ6+jXCWYdC5jMoNWiZchbct/76pNhJEcaBA+pwrzhY6dNtOzgF8CcsgEQeA9H/tNZXcDtLZMBIO9YLj7tAGuH9FpB2EHuXbPR1kNHk4pBEZ7BZRr28m4xy2oChlbC6YJ0dsz3P4yC3i8eD6jJepXTTYbB71LcebunHtUzr8M5dH0SsCodIZSAJLE3cHF1V24Gn9hm5o7CoIKwbMhZJqohnSLX75lTocQMJqXDVFTVGbUVQ9ut0qo6vnzl4h6nf6L6X2/fI6Qx61n5FzZTMhYUTMzkgDo+0TiDW0416+p2Lyvevxlyl82j+goyJeEx4QW+ZOkRs3afY7To/V+QZLlmbXpPzCUGcnwBtsSRpKQHuV266t+YwlqqerSqkVI80vAtBTBGbtPsdMBpo/iivO0+OfY/9rmu/VFZulxNsO+zI7g5fzmL17YAf4IorbS9XTgyndLuAvApalA+Ac9duNnkvbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199018)(6506007)(6512007)(558084003)(6666004)(6486002)(86362001)(36916002)(478600001)(316002)(66946007)(8676002)(66476007)(66556008)(186003)(26005)(4326008)(6916009)(41300700001)(8936002)(5660300002)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bCFXo1f3fxjPoFLF0HJzXjI+xmS/h3GPl04r4GTyp8P4RrXkmkEpsbogR4ne?=
 =?us-ascii?Q?ds6x1Kzvr1lLmTuzji1KiiPgP8AqmYHSpBwptyaBg77BfN860yy76aAj5cb3?=
 =?us-ascii?Q?B3RKEXdJlJo06U/jMAUmf30zL60RQObZT90r2vtYc0mQQUBfQqY4SwzEjzge?=
 =?us-ascii?Q?o6NUDJbGiLknhl9Svj7ceA7NPGnKRgNsHSv63ptafYni5FNKMiRhWH2Yew+7?=
 =?us-ascii?Q?bfMWCQo+JyKKeit4HdrdRjU8E7q9IRHoh7CcxZAGpdsfN29hqtRu/Yaak7sQ?=
 =?us-ascii?Q?MC7zAoaT+5vrMsxknCLkNjy4fC9rkXKUJEQw5fFpfBOeVVA7cODazWoU8eYE?=
 =?us-ascii?Q?sNJp5XadX1Yuxu2L3KJuMGqwzorRtP7m0alFj9fQb1gWqO7HAc9t2CePP+hk?=
 =?us-ascii?Q?42qR34xT+HuvRC9LQBiS0HxGbGZd4bQgUF9aTT/4YDTdWnn4GGSUOll/qzsz?=
 =?us-ascii?Q?pFRUgzsiAFYVo6x3xirjqrRx4xJmSlPY8xC4phAyYirGvDZhP5Z/FIGzbY5k?=
 =?us-ascii?Q?ae/nURkaXP++6VP6ekr9iVoTl2LoHhGYGEhFv5dMXFhQqPqCzynI4J596vcB?=
 =?us-ascii?Q?ZWsBi+vJBs495BKYHgM+6SpcXJ8ua0zxB3s5x5pDRVbIAww0Kk3egrWe2krH?=
 =?us-ascii?Q?Nn7y6wIKkj9FM3TX16TVVHLZiiSpl7BqxVklyQorNcXB0QEQs8w7HCcwHaz6?=
 =?us-ascii?Q?5+AlIBE88OMS30zaeeGWv6NwJKfHVCkoKE4m1mfrJb57sLMWt7P5F3j+P666?=
 =?us-ascii?Q?ue4ulelnDIdaRYNoYFZvbJHB1ppPpzPd/oWdNdvzFEi7PCV5AhVdxamLv+j5?=
 =?us-ascii?Q?6Sd0NpyfssRnzsb79iFPmUyQ+aCiKiQd9RBgKfxNMYQlfsL1AynffEOXQDjI?=
 =?us-ascii?Q?eQua35pbRyoD0+KkuOeYTDz3bi0qhoynSp5MGfjNEOI2JnrRv42R8JcGYquQ?=
 =?us-ascii?Q?OrZnws5Y3YuW4mrp1vQvJAefcFq3cZisC6bhnQpkJ0hSgDnZHWqfQkWrENsC?=
 =?us-ascii?Q?gw9SrT/oaUgqPaZBt5w+DQgeepcn72d0QjSGghQJTq6VvfE1rAqr4ajg+n7l?=
 =?us-ascii?Q?T02JLCNVQlsYSZLj2iONundIxjaVd1nQ7kIRZkFLW0b0Wk1/52u9WIODK8Lt?=
 =?us-ascii?Q?pitx790RY4vrZD/mnp4PeuCq5hVwQPge1cYPcMg18zo44Bqc2TR53F6zzGKT?=
 =?us-ascii?Q?Ex8k2U65yIVRHbB9XzBFUxWiPkpWv2C6xrkhFTCpuiNz+gbqtM7QVtBQ36YC?=
 =?us-ascii?Q?GrnbqO22lm/cxVTnulJtQapM31z54/K7+SXWvkASH5BoMcni2Z6xWgRu5nI+?=
 =?us-ascii?Q?JXULgugnhGpyGmLRuQpIrPagyQEGPBR7YUFT0rzz38TJEiH6DN7wrEvzlgKp?=
 =?us-ascii?Q?LKhYtxKI6ICgQZI3LYSOj0mPJrZpUY1zn+Fyf6AEAUQ9Px/I3qDswk38ITuY?=
 =?us-ascii?Q?qKVLtPt3pNKKwUmLuhN62QTvk9CzJsOxHVO3/9lAv+pcMHw9RnzyNUnvgdXz?=
 =?us-ascii?Q?SaTPDQcbSllK37AhKW/l4YjmgAi9xcKQcrRolDFk9KsFdJz2qen2E+FIu7yX?=
 =?us-ascii?Q?MLBZqS1P2X92qLkGsWZjpdRNKGVVzdhRjGRCi7KWDYz1vFvgI3hiJqN8SynG?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+vWviEVO3Bgl6AW8iQGTA76xbps0ZztnyTKPc0sAjkVlk5VqvSzf0r3Q5ihk?=
 =?us-ascii?Q?2z3YISxZ8sWHA3cW5IZwDd+ls26XvxGug8pJhRculnPaSXRK93apj6vE6dxw?=
 =?us-ascii?Q?I1e+0i3POXgxQyoGoVXuud2jTkpq9sGkxUuyJWt/sPNaoAGTNLKutL3hnjfp?=
 =?us-ascii?Q?Ton8gbY1FCyTLAUFHy5d9ARifyooRL1HMW1+ViKKX3mbSsEqRkFxHIppHEh0?=
 =?us-ascii?Q?lZBRDIQdIuUnO/zL0grCyGLXzR/0zPVh7+ovOHvg720j9zPrX+taoqb6izSc?=
 =?us-ascii?Q?c5B3mj4HrOaNfnzPKiztYTQfEsuKcEpIZzHCSiTxJnB1+9CwCsD7eqHOBIlp?=
 =?us-ascii?Q?dm4mq1VmDtZ/RRg+efixHKEZDA+pzZY5A5+e/gr0xAXb6kBzyqFB1e+25lrU?=
 =?us-ascii?Q?c+Ve0CldFTZSvVqVr9ZUVzsHzzpcukxXeVPdc8MgmUR1O66mLQonw2yCRVPf?=
 =?us-ascii?Q?iXPiPFJ2Fz8hyvrLQbuj+fEkxQaR+HEEjwEaajG3BdmZB1QwnYyZ4xH6LAi0?=
 =?us-ascii?Q?rj+Dw2+l4zbX6DyWoeivzeztWgm714zc/M+tMSW1WYCqsFe7o2fjwIydKrHl?=
 =?us-ascii?Q?0Xn/cZCOYLqURMb0Rt1YFQCFqvjq6hZFfeYaDKDpnIuVZ73DqslfJJDJcJLe?=
 =?us-ascii?Q?Md/+u4IjIbpYhNWlO9BpVJyDZvt1yhP7TtDLAtqfBp9q/cC8lbhnkug6vhRn?=
 =?us-ascii?Q?N42zT4PH8HEnFK21EMNhOtH5rPnmb7A+Qn1vPtiQZokO+OuO9CKPZByXmUEE?=
 =?us-ascii?Q?mNs++tRzX5YTN/TfOisCuYoLkmy4Jup93BId8VrC670mJB0pAyfeSUGrG68P?=
 =?us-ascii?Q?1OrUgMA0IL27I98gmANSacRwGhuF1aW+/FTl+fWbZb+o/XUTx4wcylqoFq2g?=
 =?us-ascii?Q?4fYc6QLKlUW87dg5U/ICGKZxlzbYqDwWh0N4UnFHWU3CKPSHmGXnGHvlFYlm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a77bd4a-35e4-4edc-01c0-08db146182e7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 23:15:24.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XH8zPyveu7QepUlze00MnnUR0N7O1vjRIfi+P4hzN2sXQ64yFJMD7RX8V8FAnmX1rbynyLJMuq5qoJwlrrunyjXkfdDPaNOzJJ/HyyR5w/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210199
X-Proofpoint-GUID: nEb21C9TRB3wzb1Fo_RGltbD1W_4a_Ar
X-Proofpoint-ORIG-GUID: nEb21C9TRB3wzb1Fo_RGltbD1W_4a_Ar
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yangtao,

> To fix below compile error(CONFIG_PM set to 'n'):

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
