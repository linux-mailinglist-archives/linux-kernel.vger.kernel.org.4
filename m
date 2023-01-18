Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822B8672A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjARVgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjARVgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:36:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DAD630B1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:36:23 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IKnKJL001433;
        Wed, 18 Jan 2023 21:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=hjA8LtzxdRdzjixqkYOUgiBezHcVOhJoacVpmeuNeag=;
 b=FA13uOTOm2ykaE/cPVYfAom5AH+zwMei0POo5xmpNYEe8lXY595mV+EMUTINcTW5g0bW
 CEOSnLWgoUnDJICKXceHRi9MmehgapsbKvzknuJKCH+u0HzekM61HTw1IMC9FOsHI0qd
 nx6ScwkYejgvG37d6eCz2qnY0Ypq4fiHNBDACgZ4NPlpHohHNoQH9djNLxxaRjsp/T/1
 uVfQUBkIf7w2pYmPq2Q4m67X1OTmgi59O/YxqJWatMWZvZYbolDsPQDl1pKTjGHLxRAt
 GZOfgC1dpgMQMKvN/l7It6JzcgC3jDFA8Ekx33nRC/lmYKTZT93vV+EXCXFn7olshWxQ fg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaagsnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:36:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IKDhFi009445;
        Wed, 18 Jan 2023 21:36:05 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmcu8s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:36:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7nuj8LvVqJ0TP0QMHBE5l6wUKIJ5E5+gU1NkGJKBl5bYLyiVQpGkwhlJItonNggjx4pusE/vlk4AWPfDw2WNihc3aQxSOK810b2ko/riUfP3JI+608UCoMzbgK5XUkL5ls+/NHU8BQP7CZxVhBNLkbD2tVAHfKOMJJ1Z0TYQ8ntuQf6Kt+YDmz7L+RlAy/DZnhk2eQQV9+yxxEtWMmK8+y5UXkUlydSeYpVaDaV/AXC0YmbO05YaJJb+xEIAqcyOtpwGxlv0cEsvfly/UhlZ4CZABxJirSQznh6AJFuiUCsi8m8SbFFEAkgc4zNeyIl4Y0/rx9soGD4TL1J3dje5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjA8LtzxdRdzjixqkYOUgiBezHcVOhJoacVpmeuNeag=;
 b=b+4CCqkveX9md9rY0XTnF4+wEuZpKmcyr0A87dPlRTKgHCwb8UttHVYDbXpN06nmlmjqO7pdQtBWoOoPJp/zTE9F3WjGXZuOBU73o78w84ikg09mXZ3TJIT/7XEN1cj2s0CvoAb3qp9ZTjUIJso2cJ/7P8IXTRBqsKqfNWI/k8B2n0tHPukklGzs/2jWdQzu/mAg8dX1eVb3dfrXHcINc8zNVmACPYu/tBdxfxTnA/9qDSiwM/B2H5lcR5wBbVUqgMacsIbHpzN512xL4kzBbls/qkfdDs3FA3QbunQXs3T2I5QfvD8iNIXjzROLvhFhObR2UJh88eGRVNh8wW8R8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjA8LtzxdRdzjixqkYOUgiBezHcVOhJoacVpmeuNeag=;
 b=a547fEAn/0ae2gFySTSxHWWEGlL3W1/OFXCS+hZTbf9RTD/ceaCzMJ5XK4zJEfMSuXUj/NaxQQc0R3OglghWPyN60o/LRzUwBKb+woE6RNLMNFtlllUWGK1wWJjE1q+uadxT7x2iOYP/xHCYzPG/9AJnr/AA5yWP6XR+LXGaiBE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5056.namprd10.prod.outlook.com (2603:10b6:5:3aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 21:36:03 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%4]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 21:36:03 +0000
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
Subject: [PATCH v17 4/6] kexec: exclude elfcorehdr from the segment digest
Date:   Wed, 18 Jan 2023 16:35:42 -0500
Message-Id: <20230118213544.2128-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230118213544.2128-1-eric.devolder@oracle.com>
References: <20230118213544.2128-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc41809-2555-4574-05f9-08daf99bffe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/Dz5woe2EIOIZwGvL3jieVJOVtjcKNl7WqiuZF+sf3UeeKZe8Cws6snj2DTxUIP4isaubIQ0L6yaGOK9ANvjWcb3KzA4k9gnycaxzTgbz0RjyojqyLMChPfb5rSyQmFLySsh/e36yPLx0IrY69Wu/f/JXLwBfIID2fUaB4wLL5QxjKyR5FTtyqYPQF2MXeFiqqa6jyHMkDLbVCxQP4e5EUaQzTV54zGDVW9bMmLt9TlAkAFvTDjgQIplb1IdNZ0YoyWJmueyVbSdgvjEMC31CF+bib/QNVfqNmV2L6jsdWzvIW6wMXavdXAEPdOY3AeWkFroLimen8nSiX/u/s3UCRr8Hegw2kRUeNu7xElSzVPk9hEVrIIX+QlumBPtXrkh1Y4eMLsrJHFhU0WDmF5rwxifwslq9zswpedfv/Biz7JlpXograx96Ve7LqgJuBKIKwotMjtCWDz3GzWFIdnsFHntOYw5Rlgb5tkWynYhbxT2z6WQydyNCAtt7palD9MWlGtft9BvL69MacZf4KrfcAS3e2HE/5hBpGM9G/t6sjb43VsXdjgA9wG/XciNThckANCjVeQlY8oN4miDMH0LGYSkyCS8HHzK2e2uAedVu7kv1PtpdmIyK9zeOUZVvNK5nR+YRD9X4Jgg2fca6TTIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199015)(38100700002)(36756003)(86362001)(316002)(66476007)(66946007)(186003)(26005)(4326008)(66556008)(8676002)(6486002)(6512007)(478600001)(2616005)(1076003)(2906002)(6506007)(8936002)(41300700001)(107886003)(6666004)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?otsTjMd3UOp/U+dSCcPlIIPAkSHzMBnCxD6MEEKaK35U5vgeP5PFoKedG2Xe?=
 =?us-ascii?Q?KMPtqrylyaatG1KkGHIRji+6Eu0O5YW7UFiIvNyQDzjsbg1+LKWxMg8NDOUV?=
 =?us-ascii?Q?85wkvTq6MFXutbl+q6BhkYDcmKPtEJFuCu3f1/EpXqOsGpmqAZFtUWh+p2+S?=
 =?us-ascii?Q?ARcpnvikaU/XzYrXluEeuiWZJV1pETIgCBLg8NL3IIHvOKns9JNk8JEuY6Ki?=
 =?us-ascii?Q?+72M/gemGbtYsDpIxq7wHQvXZ+BXgFn5xj96K5ovq6QuKzhuzsffgA9eOnp0?=
 =?us-ascii?Q?Rl/IK1NAQ6xKsK33d4THqe+J70NtMT/13qgL2o+a1XD1bXA0q9EcXVFNd9NM?=
 =?us-ascii?Q?GWfPk+1LaW7VaYylyr7TV6sGgAQOtTESQQcHbwq1D1ynOPi33nDjSh20gc3J?=
 =?us-ascii?Q?PIVl0W6OJYm5wnOtRB9x90GrAeWoUHJc8GsYz+SueBluSKv5tNPftmBFdBsj?=
 =?us-ascii?Q?BZaqaUsQ8ILS/tVC8dOVKFHtVNARJQN7onC5zrVHB7V7VnebEo+zaJ88DZWu?=
 =?us-ascii?Q?HRPQye/kxRWavVN32igYdSgCS/hB9PTwclbKnTQLtFC2beovOHYGYf4f2CYF?=
 =?us-ascii?Q?APzp0xZOA2XhlTJwCtlQ7dhCx/e+vbJKqnTU6WjORbCQyYrrQcpyrPLQnGxh?=
 =?us-ascii?Q?BZcUX+oK2gwva8sXCmNgWkFMExGxhKB111L0F2KM8p0iLdnSJTqBVjOCfeoS?=
 =?us-ascii?Q?vbFDf4qyetrwME06NQXrsuaGwWPjjgwtPi7Hvby/YSuZRj7F/r2k8tinOD5B?=
 =?us-ascii?Q?lMcbn+cYGw1fc8ipDF51hSWtaFY8aM7XvmJWnZk7ucqMF9y4rYEVmwjrENle?=
 =?us-ascii?Q?D4w0ClcY+78bdkzFbzhkaRWZGbKs7rGm8mnS9+aklLEIfnMS6ig4MNk5vXg9?=
 =?us-ascii?Q?qHZom2ybzCwdKuWYK8SBoNBGVTGQSZeZNRSdkZg7kQSlCf5lbWntj4/SE1EQ?=
 =?us-ascii?Q?UgQ1wnHoLeZPpECSdqoJtZQDoYF0OIYqR6zYmajS9GuysgtMoajfsUb+40dA?=
 =?us-ascii?Q?0JysY0OhUPkOA9ESCoYvDUEIJpwVEm3gLmG3Q6WwHEtdAVCIrVNczLmLb95W?=
 =?us-ascii?Q?XWp0FfydbNbHI0RKz0gnplWNCFTgGJRRJax3R3xWhIUalTYBESH8bKHdtngK?=
 =?us-ascii?Q?H2hXyiNQ9CvfJ2AQphNY7WswQicMKx1AEAr2BxFM+gkDf9e/JDJyLtrortHy?=
 =?us-ascii?Q?DRo/zDJyFF1C06Hz7LxoHMvfDkix4Jy6bZ05bLf5laABgvq95tE+u4xdb8my?=
 =?us-ascii?Q?PzJNSDF+A1eFLWzJHwu+cIdBA4I6WvLCj18uKZW6nG+7uV2WmzgjtM9nPGhi?=
 =?us-ascii?Q?OCLv5hTkJaKJ2FdcFAvdarZaDJljdR25m2hXWpZHCa+nLaK4+ljcNn27b9Uh?=
 =?us-ascii?Q?w06gG+9iR3oHT2+MOquTqsLQmNfjnSj6Yns6EjV6nXbbjICDcwrvRtma02mN?=
 =?us-ascii?Q?pviRelrzkT4gF5n4GllzAP6TgfrlOyCgyTTH+EklJvF2Co525nQFIPF21hHY?=
 =?us-ascii?Q?RNOnKeR1FDTJEjTgwm8IxML7daCgT9mZBT7yklBpdM7H4P6OIxKdHa4D15R3?=
 =?us-ascii?Q?vjXatxd+VvePhvB3GnrWGJEuT3OYqBzFcee1DaziRuWD2V8tGxDxiyqNPkGb?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?M/ruLzGwaT+auMPphHWC458Zn8doWXHcI8upJHC0d0/ggI9uzCkRfHzsuoJc?=
 =?us-ascii?Q?DpkS8K3qY+D23xvD+/xMYH1myuYtn7/r/QTRubBKOoizZ9WGsnifd3cZmEE/?=
 =?us-ascii?Q?ZSX5cTJAEkufOQeVcaOVBKXlo1VZr5wzpeOfsmi6msqa4vD9NtOzi9Bv/PhD?=
 =?us-ascii?Q?H56uJUqQ3LU+UYk3DsJHzDa4/PYVf+bWmWrtO4b9Nqgd6V+q9AqWxbcj4HKS?=
 =?us-ascii?Q?7vwxYy+11HyZ/Ea7XKQdORFPIqt09hW4O7tpwDSNOEL2PXiHk+vRJ8ExqfHc?=
 =?us-ascii?Q?THY+UH03AR5lJzaVUyQFLif77Xqc4jIq0zX8inFRVEVDBbjqyB0bT8A9v0lk?=
 =?us-ascii?Q?32NGRsO8ZWHZETQjrrjeIEynjJJVO4mLAn0bZijpXvXaZ8KPJhPfjivDkBuS?=
 =?us-ascii?Q?w4+s6nUdLEIKr7ObD0koo9gFaWagDNhw09gNjp76t7YYD/bJzeUdzn7zbeXS?=
 =?us-ascii?Q?P4DGtd41/cRkMcnOs+HrGYA6siEO+xRKTzLjdo/odTLjcgLPeUXuQZwU6TtX?=
 =?us-ascii?Q?RnGsU7O3IZPy95LRoLXXHhfWlAAjQGzVMrk6Ts6HO0Fa29q51WDwHOJQtGiq?=
 =?us-ascii?Q?hzRSaWg2f3nrLtoVnCPlA3soJvlgLzJQoEGaN3HVQt2hz8lA0NP4LjY6+CvR?=
 =?us-ascii?Q?viyXVGNewujtYByF/zQHXcdR7ncu431Acda2MXNpcIy84xrBy4N9xJYMdo/+?=
 =?us-ascii?Q?uepSG8xz2TQrlZPxVNriPmd7ec+aFGNS/1yjb6Z5SCVuu/JMwqvtF2H3TxrX?=
 =?us-ascii?Q?gczS1SKwB4WeTiiIsreKoyvV12AY4rPEvb1avYTBPG3Iu1Ap2uTvRrtlt6Yk?=
 =?us-ascii?Q?uxZn4BlRE8i/Irr+sRfAj/ZRyC67X97AeZL+8rLqoBYLEIdBgu9bYG8nU8v6?=
 =?us-ascii?Q?jPDtW3uHOA6fgBPCoXuOnJDS+Kf/eEEsBs5FS/GrufhfsM7BFEwVS+BZArN7?=
 =?us-ascii?Q?+VMz4eRebkezDpuaSDFSw4iwcRgFhP2YLfZP7KqaQdUoSUWsjJWtQ6BXSHSM?=
 =?us-ascii?Q?YLaIFQ5QHgLtzr9jmtn1tuV3iNo8RmzZ12DHDSnjdAtOkqohiolmdHL7se48?=
 =?us-ascii?Q?RUv7zT8Wj2rYeUovm6fUOaLweSKtIkQShB5OTygcUm6lfCh+2xGfp8gEDaxJ?=
 =?us-ascii?Q?gchHLMKxckQve6Egryr1VaYtCTZkMl96fH31f1PFdAIcfPCVM5rkhx0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc41809-2555-4574-05f9-08daf99bffe5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 21:36:03.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrEeb/YpJsv4Q87rWJbMjIJYtQcF9yVs0Z2skIu6vNEiJOGLTzUZ76nsnrz8Ye3mLCqfEsrwluGmMvX6RSrSOcMuO2GquQe1Z4g0bSNQxIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180180
X-Proofpoint-GUID: Xgalic_tRCTEpC57pixzS6nw4i7w10Qk
X-Proofpoint-ORIG-GUID: Xgalic_tRCTEpC57pixzS6nw4i7w10Qk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load() syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. This digest is embedded into
the purgatory image prior to placing purgatory in memory.

Since hotplug events cause changes to the elfcorehdr, purgatory
integrity checking fails (at crash time, and no kdump created).
As a result, this change explicitly excludes the elfcorehdr segment
from the list of segments used to create the digest. By doing so,
this permits changes to the elfcorehdr in response to hotplug events,
without having to also reload purgatory due to the change to the
digest.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ead3443e7f9d..2f3b20b52e5d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -723,6 +723,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Exclude elfcorehdr segment to allow future changes via hotplug */
+		if (image->elfcorehdr_index_valid && (j == image->elfcorehdr_index))
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

