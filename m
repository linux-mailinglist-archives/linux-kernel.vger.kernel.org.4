Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE5265EFCD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjAEPSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjAEPRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:17:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2A050E4F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:17:51 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E448b021184;
        Thu, 5 Jan 2023 15:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=0WkScAuPCL2nzHWWGz3/rW0nPs4YZo8Ffn35KwPDCqk=;
 b=M+vPBAGFO0gfz5w9In+zm/XrnxS6yFVhCcDLsgUM5t+yyM+xTHIhI3ViJOFb3egRk3tu
 2EgsGxKey1wHQXV5QklQnjN0AqnfYVz04R77q5W3MRXmM2HU+WkY3JvqnOgiIdRaTZ/D
 oGwbNM3/Ub5IvF+3UDG5QTuUdbCWzNrjsh3WTPnbOVzbBr/T/zbKn62kWCEeZpsnw0AY
 iS+NpmUZU41LO2FXs5rOtN332I2lkl6LxosjxhrW52B4w7USlidAQm9ocxdcCUyxOJi1
 YaMXiS604TEdGNvRKnFvRFOQYnsUBEIykeCv0RLEaMu9EQBV6b6nlgquMYHJ+rkHgXdz Eg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya901j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:17:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305EPKOc040149;
        Thu, 5 Jan 2023 15:17:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwevjmsp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:17:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlVk330YNk5lLIwIYEhJpTQ9L0K1hXWjFP+mOk87NpS7kAP881ZI+JPzL36FxXKWIaNcV99mPm2HY6eqvoZhdoDY02A/OH4HjlND1D8lTJ41Sfpi9wRu5X6rGzwCUwJk9TypidEQkfkOfHcg2fl5KCt2B5Nk97F/ShutKzSmDYmW8XIXWmSwMiv+t5C8a4SSYOf6jo4WHh4yEB1oxbG7gVYEiRbJsTDn0LF1zgtzqn/5L2+2h1FF9cqaeYHyGLifJdxHiGNJrcKKtivrO/jCr8ffZ3n4jCQxlAt1P5nspNBqBgL/xrdpyQyWLpJym92aj5ppUC4JX1DaV6Vf+kWzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WkScAuPCL2nzHWWGz3/rW0nPs4YZo8Ffn35KwPDCqk=;
 b=agG0MDX6s6Zbir2ZkaZV1sQHVUPHm+3tY5DKZioA5YbIwmSlQToJ2CYKZ6tmfUeh0Zaq8HnxByf9V88nh1mor5jCmx3m1u8aBu5uwgcFVWEUA21PUN1Dn96VgQb8b+tpIm+Nfs78V4bsrft/9DpFaUk5nP/Gtm5IrwzRz6djxVPWQETiV3UPsxKsV6qLoW2NvOK9KKuMwxi+4Uec8AyFW1smnFRyx/hPPB8nWruD+WV2LtRy8SZpSw5BV34vT8wuG+4Mnf1p/Ius8zCND7L6YW1rtHLT/15ohM9dyr1goTfBlg9D/f7YPgZ1Olza+hCKEhiPZDR1HB3PalJiNdRhgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WkScAuPCL2nzHWWGz3/rW0nPs4YZo8Ffn35KwPDCqk=;
 b=wqfTFTTi8lnwGOycQ0V/f+iz0nn5U1nh937UImxNm6ayXVY8c1fpNgqibilIKVbpddmqWWDWG5vExXSY3edTXVJA2OR4aLebxM1u7vQtSHXb5maB5Ez75DJSEL8c4tZxBbYAosBTJaMgYHyZvZaftEA52ySzHb1uxzZ9elKU2dU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB7406.namprd10.prod.outlook.com (2603:10b6:8:158::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:17:27 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:17:27 +0000
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
Subject: [PATCH v16 3/7] crash: add generic infrastructure for crash hotplug support
Date:   Thu,  5 Jan 2023 10:17:05 -0500
Message-Id: <20230105151709.1845-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230105151709.1845-1-eric.devolder@oracle.com>
References: <20230105151709.1845-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:5:335::11) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: 803ff4cc-2e58-461b-8b30-08daef2ff47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ihzza8dsOXIEe31ef7xWOn8lvYaD/5835ZoffgHUsdXyV98NzZ+jKAlrdSPPTr2+oW1sKSsRquPbHF5pogPK7QM/wAO5HQsFPvH9AvnQOthqkOM4YXsyfUOi7/p4INBNbmWiT7b2UuGixf2uKbAWsef/lxFrVrzd4vef/LWfwQHLQigUAUjwDJ9fYMjQrwqODOeD9rwTK5L59wknWHE+ipP8QS/GpPQMHdgYm2QpI/ZSnJeNpEyvL3GmrjHMtIsXYb7jKnG5MVD5rpO3rgqtze3HZAzSPhOgVjUIsaz1Wek2x1CvMFzkQ/2sSpvKQxCgb2MGQUx/3u+OaxyiKT63rS6GbYJiZVRT3mjtzGTKtMamUHCseiBR7+T4C3bf5rzDJi4JNoG80/hTDRNXSgr9HcGaIIj7Sp0P8qLsOT489z7bskhAHncADMg6G2+yJ9xF/1cAOmpCuQ0oKRk0IY/JNlyIkM6Y56EDewqot3xyqElbOhPYrODt8T6Xyl8u6ucxVECDbJ0xS6JQtJvYkTBMzaYIbiTZ6HZK5zdyzS3dCzhh6XeXOk6QtQ5URhjU2IaD1X7k5laIrol5ajqjmMUF8Lyq5mO6bPiZ+7WGwUwK5SurfhQ4NEVREiz48WTDGWnCbjBUhe2A1XMmPRsPXTMO2AJt9bBSE1zp5kf3zptjpkH5/DVpTbNFWUQE8/3yMiyW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(4326008)(8676002)(107886003)(5660300002)(66476007)(66556008)(6666004)(66946007)(8936002)(41300700001)(316002)(7416002)(6486002)(2906002)(478600001)(6506007)(38100700002)(26005)(186003)(2616005)(1076003)(6512007)(36756003)(83380400001)(86362001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B10G+YLHkQ9JOeHXDwuCiBCgFlSK9sRJlCK1qZPiHAncP2mJ03qmyxC6foM2?=
 =?us-ascii?Q?J5sAgBDz31gvas+QwTTC8Xx3ct/+YjK0JpdNWVRhateiz2vfmNnxuRH5SkJL?=
 =?us-ascii?Q?3jxP5n2CNH0xR/uft46UQCXDoFLjemSgsaJGfrWXKmX6siSH/sIYtAoeumaV?=
 =?us-ascii?Q?K5KJtrs3kcQUPK9jzjiXq5HyyhUv9eAUjDQcjmUyeWmP1nNmACGnaN/34D1f?=
 =?us-ascii?Q?vNXvRum5MPO6pgRRQ2bspHMJCYK476OZGf5tls4+6jObBuolpVXGlA0TmdWj?=
 =?us-ascii?Q?lLWlwi4bOietswxs7/rWENcQSxeQ6YzWyOSfk4uNmIBbvFEe+238DO7OClm4?=
 =?us-ascii?Q?zEqOmlAz7f4rJkcaV185XhOQg/2SWyFwCHmCEg3/aNACZ9DBTmU/AulioLKw?=
 =?us-ascii?Q?qHKUEHT3Vdh937DjUNkhteFRbLEY1pY1yQS0a47jan9k4IIeQqpjT3o60jwM?=
 =?us-ascii?Q?c2spJGjHy52A54Uxs1bfYdypdazd+w5a8YsYNGRkQN7rGNYfBXxW8rhUShLP?=
 =?us-ascii?Q?I6XDjgtCFMrrFnXGTzOYKnb+V+DqDp1/u999odQVYU3njjWnriCiAg+fI6aC?=
 =?us-ascii?Q?x7JDVWgwkBkC/Iz4hsirWHnbz+e7s4rThBm5epqTRYTF4WD1wrZVWKTVuylr?=
 =?us-ascii?Q?+dAvtiz2ZEhc3i20nFRUBLJPep+NlaUPYPShuoeppFTiVCK7CMj/qhU1e/O2?=
 =?us-ascii?Q?uBlpZ2BKNhJpB0qMT1Sir2NP5qNl0ooFlmCsgxvWyqnSmrvAf4XUH6jUVNKe?=
 =?us-ascii?Q?BwCxcw6rkuGpoUFZRL1odQbiA+iPvxpkKWsUfEwrHCsvbOJ8jelei3Tctsqw?=
 =?us-ascii?Q?kwBhUhBCEByyYzzEqxTeSIA4lRX8qkMZWhjnM0DIA+O1/9PtsfcbO9Akp9l5?=
 =?us-ascii?Q?Kp0ty2C58XVAkQ2i7sllLHVoNFn9fBI+8EXa0f4RC6WnRDfA4pdE6A0VvsPO?=
 =?us-ascii?Q?kHs8anXKME8Elhv7YKjvHiy/vaV8xihadKQyUaDMjApincLAITj7IUOp8WVo?=
 =?us-ascii?Q?t8IdWA6MKVRErBJk60O4l9aXs+/8Q6kZiRcyXF7n8U6AlXUKY30tC1hy8RcN?=
 =?us-ascii?Q?DWXPUF81jW5mUUtE7pUfDjGvFBKvNlTgLR0X6G3I0BGmoJeNYfWgXc8064Uz?=
 =?us-ascii?Q?JKLdWmKAlHtBJNXSyOf7/71CzAzQtavyju6ZrLsD4BaOdA0mb0vwuZ8mk/5W?=
 =?us-ascii?Q?1rJWvNFLl4NM1C1G2+jxXYxim+sQn8T2GC7eRo+4ZHIABMC+3BIPFrtgJU4V?=
 =?us-ascii?Q?PvVThdM6R8G5LBux60v0MbaE0oGvG2LpfFnXdEZCqp19qYnriMcjVszgyARZ?=
 =?us-ascii?Q?KuIl/hAzaOMfrpjS7oAE+WrUg4ZAmmwVyGwKeeyfFpcmAdwY1/fYWXH3wfml?=
 =?us-ascii?Q?fXPHJGYb7E/Rz9RSDQjEf/E2rcISJFmdiSDtpeDXVsAvVEHDedVoHYRKwgkV?=
 =?us-ascii?Q?RkyV1ZSBgArkweROIuJ5R9I1qc+r0LRIEHFJYe88+QBPGEPC+4MilP71WcLb?=
 =?us-ascii?Q?xqmRZ/JBUlvssIq2a/8O73r0P+eZFQGf0eIXueds1fmJvRxFlLTjh2lnMieI?=
 =?us-ascii?Q?Mtj27H4/pUv0IqNzOagUGiO/iRuD7WYeZG/zYJ+yn0zQ3DG6uULhPr6gcpq5?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?91G9NGkkaqJMCY9eGsOFiA7EGYSeV0n1ruDT7oXiQjEIzp+MzB652jg9Wnco?=
 =?us-ascii?Q?sZ1tSNUb5wwvn5NmvOujNH/stecs4Emt8uTl44JXmhv2Wzsbt4KfHzXMMNDB?=
 =?us-ascii?Q?4GeQbJ9zl6kfJSZISJ/jFPkA7kxM5d+oY+A2r11n1ptomwPUUfKQA0vKM+6A?=
 =?us-ascii?Q?Y0p9qMUmKlJHXtA7oZTlE9CctEQzMI309JnZNBDTJDpTv5lakDIZq1InlqjR?=
 =?us-ascii?Q?T+iokaurz9LbR0djIlmVySKJEUuwh8CkJFUj2lJuDzC+ARJbTWhW2YkbKnJj?=
 =?us-ascii?Q?oh6jGN3xBCfydccsaQ3xc2304Mchv3trqqBaIEkGcVmq8Bf/xSPBkNJ2bAlf?=
 =?us-ascii?Q?Ud0N9lx0VWutmgtXx1RPOMnU9pOrCJPB1SZc7RMiqSItoqDSTC15Yq7TK05f?=
 =?us-ascii?Q?CVP306LjM+cQ/xgo7o2ij+hvGVAbc+zQJieJ1qxodkW5DjD1rhgRXg3fihHY?=
 =?us-ascii?Q?d8e9VusUt0d258rYVs0UFz0upeF8JRIqrrcc3eAlYXRKeLFsxcc7yCMl5m3j?=
 =?us-ascii?Q?4D4hdHHPu7Mr1ndOohwUCDMoor4aqq9teTqfFf+DMIWpoh8E1fvLgBoHabFr?=
 =?us-ascii?Q?f+krsx5GVkqHHVKztgjsqGr1NSxKK9a1zzyLCRCrAUS3E0o84Z5+JF6iwr0i?=
 =?us-ascii?Q?LbDTBQnb/X+9qSySBoF7buKaZbQbjEExlYedoFaymzzYu/faSaJEh9Yz2RSf?=
 =?us-ascii?Q?NjirxjogJIVMh0TGMKO1aKFFj5S+Co3rTBZME9kuFVaNMrU7QGs2jeWj9CXf?=
 =?us-ascii?Q?l2Yxr3a56/N80pdxCScK+gGEGjSP5LvNWrFYpUrTbXS5eFxxAECSSW9eETuj?=
 =?us-ascii?Q?KauKknfo944mUeF3yog2rW99BfdX6cG7gY+Xo4h7WR2mxLjxoVtBsjGj+poW?=
 =?us-ascii?Q?6eYdSEk341iSKuBQSOMV8tW6+0ih3O54vZI31Q1a3u/5nwiL2ACJ9K3YZ5ug?=
 =?us-ascii?Q?ypqnIx+FdnJHKsqUUOJYqx5XVGz+p96HODBPDDyFVC9QULcSSFwhPQ/iTX9I?=
 =?us-ascii?Q?YxVrI+dIO/Y1//h1bsCOckaTFrHVG+ILyknt/pkxpdlBsHJZazuUAydY0ud4?=
 =?us-ascii?Q?QiFfjt3MhzV94Ysn0AMxKEQOPUwg4G/ynvRhZkt2GKJO5bl3oayCVu7x4OWo?=
 =?us-ascii?Q?OWAEleZgN7aehwy4GHepMOV1sG0CNSUxd7rdEXih93BgUUGHxYlf4KNB+IuJ?=
 =?us-ascii?Q?/TsXuKe8kosTDHQQeqjeLJPek+LMqIXaZ3POeydG36BHL1i1WJqeb9p/ufFm?=
 =?us-ascii?Q?SYk6b1eeBSFsKj8ChbUUeuKpiJtUgECwXe9CFR80UBqwbvtekpOkBqSizM73?=
 =?us-ascii?Q?678rAGOMRKkGrB0iBCD/sx3TIZ6a6GQbMCWDx5fn23VEIw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803ff4cc-2e58-461b-8b30-08daef2ff47c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:17:27.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QO+HMfERiY8yhhishXFZe+xy7ysOC9X18djv29JOhgLznlL2NAD7z7594PWY3pr/2E03kggFuYqYr3QpiQd1lychzAG1aFEnr2xbiwPSbJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_06,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050119
X-Proofpoint-ORIG-GUID: p2-1S-9nRDJP5GABQxkm0mADFtpuZNMJ
X-Proofpoint-GUID: p2-1S-9nRDJP5GABQxkm0mADFtpuZNMJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU and memory change notifications are received in order to
regenerate the elfcorehdr.

To support cpu hotplug, a callback is registered to capture the
CPUHP_AP_ONLINE_DYN online and offline events via
cpuhp_setup_state_nocalls().

To support memory hotplug, a notifier is registered to capture the
MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The cpu callback and memory notifiers call handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event(). During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |   8 +++
 include/linux/kexec.h      |  12 ++++
 kernel/crash_core.c        | 138 +++++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..a270f8660538 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_REMOVE_CPU		0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c8662a48d455..a1838699d7b2 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -371,6 +372,13 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	bool hotplug_event;
+	unsigned int offlinecpu;
+	bool elfcorehdr_index_valid;
+	int elfcorehdr_index;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -500,6 +508,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
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
index 92eb7dc05457..973d7ddff1cf 100644
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
@@ -615,3 +618,138 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+/*
+ * To accurately reflect hot un/plug changes, the elfcorehdr (which
+ * is passed to the crash kernel via the elfcorehdr= parameter)
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
+static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	/* Obtain lock while changing crash information */
+	if (kexec_trylock()) {
+
+		/* Check kdump is loaded */
+		if (kexec_crash_image) {
+			struct kimage *image = kexec_crash_image;
+
+			if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+				hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+				pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+			else
+				pr_debug("hp_action %u\n", hp_action);
+
+			/*
+			 * When the struct kimage is allocated, it is wiped to zero, so
+			 * the elfcorehdr_index_valid defaults to false. Find the
+			 * segment containing the elfcorehdr, if not already found.
+			 * This works for both the kexec_load and kexec_file_load paths.
+			 */
+			if (!image->elfcorehdr_index_valid) {
+				unsigned long mem;
+				unsigned char *ptr;
+				unsigned int n;
+
+				for (n = 0; n < image->nr_segments; n++) {
+					mem = image->segment[n].mem;
+					ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+					if (ptr) {
+						/* The segment containing elfcorehdr */
+						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
+							image->elfcorehdr_index = (int)n;
+							image->elfcorehdr_index_valid = true;
+						}
+						kunmap_local(ptr);
+					}
+				}
+			}
+
+			if (!image->elfcorehdr_index_valid) {
+				pr_err("unable to locate elfcorehdr segment");
+				goto out;
+			}
+
+			/* Needed in order for the segments to be updated */
+			arch_kexec_unprotect_crashkres();
+
+			/* Flag to differentiate between normal load and hotplug */
+			image->hotplug_event = true;
+
+			/* Now invoke arch-specific update handler */
+			arch_crash_handle_hotplug_event(image);
+
+			/* No longer handling a hotplug event */
+			image->hotplug_event = false;
+
+			/* Change back to read-only */
+			arch_kexec_protect_crashkres();
+		}
+
+out:
+		/* Release lock now that update complete */
+		kexec_unlock();
+	}
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
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
+	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
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
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+						   "crash/cpuhp",
+						   crash_cpuhp_online,
+						   crash_cpuhp_offline);
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
-- 
2.31.1

