Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB95D6BF3C2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCQVWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCQVWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:22:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173FC7959
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:22:15 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HJOhhL018089;
        Fri, 17 Mar 2023 21:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=dWDUPNdNa1wXrIEc16j0Hj94FPhGJwZFBydAztIpZJs=;
 b=sbOdbEfBxP3w3/AkEgB4i0hvAMS1Z0X7TqNwyyQ4eJDg9IO61P3yMfwwET4gYWPY+DmB
 TJKBQpD3OLGgFGc5Y6e/bPQZHXESSxRVD1P9xYT9DqeUfq4Bb4x9ovijJ/38pSnVYIhY
 TV3gFkZUOi29d4PaU5K89K2owJRX2Bn0w93ilRNE+hXYdfU9ajgxxCmgzTckVd9yvkm/
 yeYLFI82LKlCX3pyk0WLzT67JWwX58XOQTCyLzyWNQ7gSk1LZ/wRfk96/BlNxHdRNDQ0
 uichA85SQi4iXk231hzZZmNrw1M2dlbr4M0G34A2eRuX3mPUTcAu2hfOa+wm3bRIxBNM JQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29cyqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:21:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HL6d4Z002397;
        Fri, 17 Mar 2023 21:21:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq48ah43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:21:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDd7N7C+yUyvCXZNbSkETY8vcHEjdpsFQBaLViiZcvP1u756RRfUetP0Bu84Fq75w1fqAqgoRfC6jtl3EuO10osx6gvIeYqtofZWSMjILAFQu4b/6YVTtH9ekqDg5YcFbuLwPHFhNGXjUJ+2qpHVQc7Wi7XY0Gx9PNKJ/+hmLk6GfHACLcXgDmOMihvIHZO12PbtY9AScCgQxWn7O+DB5F/+/J3MBZrhJH6PoBJS9y8GegQkjhCadyP9xqEQwufMsiSbaNJA5etDthQEzZEXvac862LFjOdECZ2SNgj+uaBCA+YUMxSirgULRNSWBlRg3DVh9Wivssxl49HthB1qAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWDUPNdNa1wXrIEc16j0Hj94FPhGJwZFBydAztIpZJs=;
 b=Paah4cjqXtW+IZDCxcJl4IB8MIzyXLK9JjUQRCYBIQyWajS9rZn51OC9I8iwRZLVT2q7q/jy12ye98UnoqZBQoQV3ajJ/JILmfOgVl0bMWRiGcX08Ms5AAaRLkRzDoi1TfjnAMDSqEHZ9HSe9jGRuk7PUulbNkwTjInFFuJ8YGWhmW3C8I87t/XSG1WIRAKgS34QqwGO+ZLkRxN6xUTCK8XYEmRKC0/tV5vXWc3bL/ICK8N9AlJ3Bwql89JU0G/VLfOdry0m+zP3ic6nPYGSnrJs9X3zJ+xucwwbq4vPpQ7PyU0YRpSx2x7W3/Os8fVli7q2CQUX1PXYcgOpuZ3Smg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWDUPNdNa1wXrIEc16j0Hj94FPhGJwZFBydAztIpZJs=;
 b=F/r96uBupQ0IWXTgFZrU8PUElz3lYdceJQx46dEA9npItAx12CblZxorURmXRmM2ANrIL7a8UGlL4ukkSOg0+JanrQZ2dv2Qi623Is1IghFB7q6PRmuwsZmvyJ6MpRt+lfLcAZpbdxLfmsd4xzNYeHS+1LOLxtBi7hx9B8QETfE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB7483.namprd10.prod.outlook.com (2603:10b6:610:18e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 21:21:45 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 21:21:45 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v20 2/8] crash: add generic infrastructure for crash hotplug support
Date:   Fri, 17 Mar 2023 17:21:23 -0400
Message-Id: <20230317212128.21424-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230317212128.21424-1-eric.devolder@oracle.com>
References: <20230317212128.21424-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:5:334::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH0PR10MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e27402-d9d6-4bf0-1ed5-08db272d9c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CR0J4Q8L1JQMCyD9f+BiNDUir0Adub1T776s0Kfbg4LhDkWS7RgXUqm/+8GYHXnHoGWwmt8KKX1wCHQoin5huNtt/dzJLG/QEnTq8OIyHPtJ9e/1Q6X9wN4IJzhNuZUNZYhMn8MPwTlqMsqq2rcMwH3Kz/z5zeeOPeh2LQWxcYy9wEArEBACYvhtR9DFqV7hZyEelSdVtsJE5EP6XEb+OkMJ3SQ2/jtQBP8oiTCLxeyYyc1ClFKLM0v7/KywyTED7Gd++o7sNUyvy5Mv2/G7NZFi7hYzvL3YkTYZvbkFYCb9YDFu+Op1dYXNfVsBKB3z7br4WUZ1ozHCwKxaYrrA3yWS73KocCxIXZiREluTAAt0Ix9AGE/4p3QdKKUkDkKdkvJVlXmviepcP42WKxLRgcSsggq/iFCMTXbfNDOsahY/k+yS57UbLOynNtGK/L4RCo1w9w0jStL49GRknwV7as2cyhrMr2aZDkpQR2Rlvw9iQRbRNwg5mJSzVkLeITRx2CUmhCKsn6rhvk6sliY9vJFF6HpFvrolh4+1e4yGXikOsjWn8k5LboMhgOEIl62BSwrq667H4TjnsXgdXmyZZwBpS4BUQh/LxyBW0I5FwI4RAdATOKe1S2hHOVHMbUDJjCQOHNFEWQwMLaWlHW7iyUazFlj9/ZKuzZt89Y57bBVM9jNB7TaQZr7Yqlfbe2gk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199018)(86362001)(36756003)(38100700002)(2906002)(41300700001)(66556008)(66946007)(4326008)(8936002)(478600001)(66476007)(6486002)(2616005)(5660300002)(83380400001)(8676002)(107886003)(7416002)(186003)(1076003)(26005)(316002)(6506007)(6666004)(6512007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tr6JGPpor7Th2Dg6b1yVJqqOgmbM7+aaPDr6JadbSJhMcIhrYxP/xKInDfln?=
 =?us-ascii?Q?HEImeLhQy1zhND9BWJwx1vzHZEAwvRbQe9Pg87A6RtehCqlD0IrvP/+sDjNg?=
 =?us-ascii?Q?LRnaTE/QJT4oGyOSTY4CH3w2s4xm2Iz9AwZXSza4CKo3NKhTqERV0SXvLieq?=
 =?us-ascii?Q?i9I3ZrO6aUb29Uxz9mL7uHQ9GuWH5bYjDEHizGH2OaofWGsJzAKfpLDbXcOF?=
 =?us-ascii?Q?pgo6CsqQUjA2uVwXMBYxhrAV7lKmM4SvEqqQJD6FSTkdNEVRimC9BEm//ld3?=
 =?us-ascii?Q?T+k+bLZO2wf+6ljRuZk94zhgSPPuWaJxTn9oJ/qQ7fh0h+Go2HNHiwuFn7Et?=
 =?us-ascii?Q?kIh+sBkxU/iLUq151kUdqD+/DIziQwQkfDwxgYAYvpL+BJuosxsKKDDILD2L?=
 =?us-ascii?Q?k33WZiGoHElo/cgJ5DPvzJP6FNZh21YS2Qh2WDSUZ2Z77C8tvMXHCOM4VCSO?=
 =?us-ascii?Q?ClCl5AiaQy66/k3hIO7Ou5zOlsUxxtFE2WYd8v6pNXJZmVX9ILxocpcPfywm?=
 =?us-ascii?Q?4eiQickb+vPkmaS8dcBiAUlc2U9Hol9fdZ7hXyiYzk6tEtVFh/FT816bXkmq?=
 =?us-ascii?Q?gAei9+g9tsD0RDZlI/Xeop3VLFvU+gePEZ95ubTo3wHxiPz/7HqmaHWPEE02?=
 =?us-ascii?Q?6FyV4DoWKqIhnwRm7NmTLBaiXlTRZ0B0CeHfIDiREhk0/taBDHx3XwSOMyjX?=
 =?us-ascii?Q?NPSfBPxHP9SaEV5x1zlcflIl5M1l75Ct0NycZlmOqx+Wd4IEajLzBNQ75qz+?=
 =?us-ascii?Q?TGBC/cTUzwXCW3hezjHbAOlg0pQo91lI0GAg6ZjyG72CmoyROtpMFtNY3smT?=
 =?us-ascii?Q?WgzHDDihGdP1KBd+mUEh1eTAp/2/w5XQ3tCvpYMaxRtAmQSGHwHsbg7jDwxV?=
 =?us-ascii?Q?biucoUt6IifKByQaSvYGnCo9FHhEv0OfITELDCBPYkxsaX8nfqHkWsF7kAAn?=
 =?us-ascii?Q?NiZkhwici/v6wqnGzZc/kmOu2qlxqM4SFBaqd8Pfi0ZHfeE9DKZmS4HrlO+k?=
 =?us-ascii?Q?IPJTQPUhk2PQpEksDBLAbK+NyC68Xv9wnpjxDX4YR+/fzlIGajmBCDBS4Wsm?=
 =?us-ascii?Q?PSt//LrYHz98+UpaCfQRIQUKJ/BwepLPIr5muEamen+fUboU7UOGcac1PnLE?=
 =?us-ascii?Q?uRk9KVkVAA8Scmw2VMHejV+Zs+tOSUOweb/PK2t652SQ5Kq+u+Nw8EVuffDv?=
 =?us-ascii?Q?yOIfmhppRGDn3/PaHYLYv3PJFnONzY9Ldz8iKfS8Ey4tuXNfgf8jNFO2TjH8?=
 =?us-ascii?Q?ruBSmWfo0UgFN6i1QGyDUqJ9S+6LPy1alyKSKZRwloEcSKADALz118Tl+UmA?=
 =?us-ascii?Q?T2S3Kf5zR5Gt3X4r0lnLCDWV/OJAXOV0huwjz2+6REXm8PLPmvxPlu+Wq3El?=
 =?us-ascii?Q?z3DJMYZMn6wcpUHgMaEiPECZ1mZDSesvYlDfkgNqTn7tqJzWaU8lEGjARJZQ?=
 =?us-ascii?Q?dBwAwBEIA4t/paBrKsEeq0TMaQ+LRpYK2ekc5BK123KLQaoS38tmKItEvkGy?=
 =?us-ascii?Q?omfMelsnM+vSX7Tv0T2eEmlji545NwtSW7VCrd5j0MkLqBXZpA603jFFJUs2?=
 =?us-ascii?Q?0enCYS8UndvLqEfVc879jbrqUfVCd1TNADPYfzcOkcc15pQCd0px6418prB/?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pQiB1g9kALa2TFW7a7oAgMmZ6o7LBbPqF8Zn8iKsYjGupR+NO+kYNOPeM4eD?=
 =?us-ascii?Q?QJV3z/CJ3Ca3YhpK8YkzTyZ3Gpi8IjaZtqrcefVMQ+Eyg13JEvJmrRqs2Sf/?=
 =?us-ascii?Q?75N/8Zn/2m1bTHBsuYkFx6PFVy8hNEDtbj7gDJoXXBbLktYeO29pi2HBraK+?=
 =?us-ascii?Q?y6/ON+vyrKKApNk3CHseYrVxQHzWwqVaaXbSuwCCkPTOdZfcF31DchTTYAhw?=
 =?us-ascii?Q?yhkBStPC4AKIX6FOjVaMrIWvM0JdSKg0uYWQs40QPe7TVJxB5THI8D/acKB7?=
 =?us-ascii?Q?iqrXd6vB9xyYqvFOk0EAbrD/4oSdYtoRrURBf6xDGYXy7uIUFIgTP84AsO00?=
 =?us-ascii?Q?mfctRkECMbomp1NA42W3BJapzpzh9FchcGQV6aPqRkENfwMVusFTVKYenPFM?=
 =?us-ascii?Q?K7U5PUKyIkUiah4jmOqwTkJsNAbUZfwVzQNND1Q9igLJ4uBVcvbxTl2D2AvP?=
 =?us-ascii?Q?Yh6nLLDW+dU2u62+AjQx03cKKJAaokcf8un2VzaYfCTmYIk2m1Rhq4G+tkH/?=
 =?us-ascii?Q?E/n0wFkPRO2Tq2WZDgUVj3JQtLa4brB0h6/Ee/nXWKTdSvKulTqhT0Ye2ufk?=
 =?us-ascii?Q?h7QIAlz51fmfv1iJy3jdJLNqA2MZkRdGlHV6I2nIJLbD0Ea/xdCpSaHekSEn?=
 =?us-ascii?Q?V5i/B9Pjv6IS8PKlDuUITeqnM7/3Xu7p4natJ4d93tjZtRQqbxf3HtorwzVg?=
 =?us-ascii?Q?miPqFp9SLSrrmcqfGh3Uc/1Fyji1fc7T1d8VQlaT8DSroeX1mDAwHJGG45aW?=
 =?us-ascii?Q?n3i9E7cpzCFOvuZzQb3y+cH77LBu2SZI1DAmEJLHWI6S6t7otMM0W0X9ZxWU?=
 =?us-ascii?Q?WP50bz7x0il1azQu11Q4Q6c8ejyT2Z3eBNNp/itdrGK7PItQIK7C+Gd3Zpce?=
 =?us-ascii?Q?5oI67AZdp8gJ5AuNbolGtg6ydUqQAiE2ZDCziNXZm7DdOFesEadTPq7kX/Rx?=
 =?us-ascii?Q?BiuvABsCRPp+FE4Tsl3zclO3SrrbQY2U3bDqEcGjGzwqs+ldrVYHVOmXM+l/?=
 =?us-ascii?Q?DT5/zjPHKwQ9U60nL2kupkxiQKeQsrcKfhdJ/HbCimO45zOX2yGsAM9H6gI1?=
 =?us-ascii?Q?c1AxghnF7K2SIqgDGPHRzwXQTdXieH28IJR9rqbYH+ugGNlWAIwfYS4dXqb+?=
 =?us-ascii?Q?AmPaSzZb3rdVE0X8vYSmjq2zS2t7rMQyC3PLwYjlWual2E5h5hMZhTc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e27402-d9d6-4bf0-1ed5-08db272d9c28
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 21:21:45.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liOAH7/GS/zWjfOVUoLTUe3RgyTCmcl/1xrv9pjkeqjK6aPhfYHKM1YyU3zER9shxSTnXHWSt342a5wDopzzFe+xILAYiORCwRmSgE1BSV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_17,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170150
X-Proofpoint-GUID: FsIPkwnwoukHdJzU9bvfNmmBjLA9fn1X
X-Proofpoint-ORIG-GUID: FsIPkwnwoukHdJzU9bvfNmmBjLA9fn1X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support crash hotplug, a mechanism is needed to update the crash
elfcorehdr upon CPU or memory changes (eg. hot un/plug or off/
onlining). The crash elfcorehdr describes the CPUs and memory to
be written into the vmcore.

To track CPU changes, callbacks are registered with the cpuhp
mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
crash hotplug elfcorehdr update has no explicit ordering requirement
(relative to other cpuhp states), so meets the criteria for
utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
state and avoids the need to introduce a new state for crash
hotplug. Also, this is the last state in the PREPARE group, just
prior to the STARTING group, which is very close to the CPU
starting up in a plug/online situation, or stopping in a unplug/
offline situation. This minimizes the window of time during an
actual plug/online or unplug/offline situation in which the
elfcorehdr would be inaccurate. Note that for a CPU being unplugged
or offlined, the CPU will still be present in the list of CPUs
generated by crash_prepare_elf64_headers(). However, there is no
need to explicitly omit the CPU, see the discussion in the patch
'crash: change crash_prepare_elf64_headers() to
for_each_possible_cpu()'.

To track memory changes, a notifier is registered to capture the
memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The CPU callbacks and memory notifiers invoke crash_handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event() to update the
elfcorehdr with the current state of CPUs and memory. During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 include/linux/crash_core.h |   9 +++
 include/linux/kexec.h      |  11 +++
 kernel/crash_core.c        | 137 +++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c        |   6 ++
 4 files changed, 163 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..e14345cc7a22 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,13 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_NONE			0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_CPU		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		4
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 61443f8395f7..f9bd46fcbd5d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -368,6 +369,12 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	int hp_action;
+	int elfcorehdr_index;
+	bool elfcorehdr_updated;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -498,6 +505,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 45d241aebe3d..ec1d68569f6b 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -11,6 +11,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +20,7 @@
 #include <crypto/sha1.h>
 
 #include "kallsyms_internal.h"
+#include "kexec_internal.h"
 
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
@@ -697,3 +700,137 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+/*
+ * To accurately reflect hot un/plug changes of cpu and memory resources
+ * (including onling and offlining of those resources), the elfcorehdr
+ * (which is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources; the elfcorehdr memory size
+ * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	/* Obtain lock while changing crash information */
+	if (!kexec_trylock())
+		return;
+
+	/* Check kdump is loaded */
+	if (kexec_crash_image) {
+		struct kimage *image = kexec_crash_image;
+
+		if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+			hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+			pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+		else
+			pr_debug("hp_action %u\n", hp_action);
+
+		/*
+		 * When the struct kimage is allocated, the elfcorehdr_index
+		 * is set to -1. Find the segment containing the elfcorehdr,
+		 * if not already found. This works for both the kexec_load
+		 * and kexec_file_load paths.
+		 */
+		if (image->elfcorehdr_index < 0) {
+			unsigned long mem;
+			unsigned char *ptr;
+			unsigned int n;
+
+			for (n = 0; n < image->nr_segments; n++) {
+				mem = image->segment[n].mem;
+				ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+				if (ptr) {
+					/* The segment containing elfcorehdr */
+					if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+						image->elfcorehdr_index = (int)n;
+					kunmap_local(ptr);
+				}
+			}
+		}
+
+		if (image->elfcorehdr_index < 0) {
+			pr_err("unable to locate elfcorehdr segment");
+			goto out;
+		}
+
+		/* Needed in order for the segments to be updated */
+		arch_kexec_unprotect_crashkres();
+
+		/* Differentiate between normal load and hotplug update */
+		image->hp_action = hp_action;
+
+		/* Now invoke arch-specific update handler */
+		arch_crash_handle_hotplug_event(image);
+
+		/* No longer handling a hotplug event */
+		image->hp_action = KEXEC_CRASH_HP_NONE;
+		image->elfcorehdr_updated = true;
+
+		/* Change back to read-only */
+		arch_kexec_protect_crashkres();
+	}
+
+out:
+	/* Release lock now that update complete */
+	kexec_unlock();
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
+	}
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3d578c6fefee..8296d019737c 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -277,6 +277,12 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list of unusable pages */
 	INIT_LIST_HEAD(&image->unusable_pages);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_index = -1;
+	image->elfcorehdr_updated = false;
+#endif
+
 	return image;
 }
 
-- 
2.31.1

