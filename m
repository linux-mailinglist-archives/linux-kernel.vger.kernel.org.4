Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EDF683987
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjAaWoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjAaWnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:43:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F444221
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:43:51 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIhr2W025726;
        Tue, 31 Jan 2023 22:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=nN3aFpo0np67yBPrfAKy3et0sb4QX9dxrzTYCtzr4eU=;
 b=vJRo1c3gLmOvTCIr7asCka879yfzQiCq1x1R0BaXUDeuLCRIRWQxRK46T6R/IXS12EGe
 83/9kcY4/TWntWJ52uoByWxE43F7IgOUb1j4nyNRKQJ5qAQkCf2Hxf4bjZAiSYMFRWGl
 SfaG7hE1zbQoOkAVnPmCT9HUgFZFp4+fWA0ZWPAZvJsPpenybalP5dnqyb/Bw60ULC7M
 LjDQjEkTPs1aj7pqGbY6Tl77sutTFcPJhbvkbdBsSVDTqogRCtIHkX/9RwnzqAELsZZm
 87iK7TQ24POTAmOllXXqCXyghlBBiHJ0ErjcWm08gxW9ZV7C4L4DQQV176SMbPgOpT8g xQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvqwy0ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:43:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VLKJdb031557;
        Tue, 31 Jan 2023 22:43:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5d6y3p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:43:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0LGOLlpr150+YgHjTGqFf9cG3cCHQWZe07NHMhLSKaP6YYghALlBKbxOki4u2OZnMRnW1NQroTs6x5P2PMHV4mlXnxJOXvJJzWgYF6LUs/aJ7yQ9BBr49Ha1pupyCYtGNgYPLMDYZ3N+XKW1JoAXY01UKwTNRiXiaa+GjcxLbk/kZnS00kn+qpEMbcPtYCJqjYz0xtcDhPs2maB/kJjBHT9CrXM1L45dD5mb6uvFjwq71XnZ4VqNlpIsIjBbS+cewgADoVHDJjvP0HTJvtrOF8vpo58cK/Kx/Aiw+jTBeQtPwhb+8a6sCBj2T5FIxFdrV/ztaUBGnDq19PdrEbXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nN3aFpo0np67yBPrfAKy3et0sb4QX9dxrzTYCtzr4eU=;
 b=YUO+AlpMW1q7HWvaJ+mbyEr90Wl+P95vqi9BR5caGqv7/i1bfTgg4XdfXSrPCpZ0OYNZPs1icN8L5UjxSxUZWkb759X7uYXG06YobQmuONA8o21c0Gu78HzZPA0y9TBiWByHWKYygKui4aVM9HjlOuWG5Jjf7dt2l59TA8hQBJjLnw2c/6P4a2CJOieLNWbaqOT4X8XE6OaxcLjugOkCmOh+dAItpzrEjZF4klTud5NKC40FV7HV2K35l19w9Awuc0VtmjbVdk8ECpwWCHsaTaRXaW5nM5hIuDu/2rwnYn7B1X0JnT7ENSWY5+usecoWgRKt9VVgEmW56aGkq0WePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN3aFpo0np67yBPrfAKy3et0sb4QX9dxrzTYCtzr4eU=;
 b=bYDbG2eNOKt8wwqj8n5p57mNZ1mZYZkMVpahAYjtTGceScDk17yGx1wbp7NhePLbt8u7aUNAxeymmKKatNL6TqARzk3KNdMMwuPmhAsqIY09DT9g3GpmO/8l4fduTjna8Q6lgAKl13h2XskWEc3nDj5bOFq6fN2zKCHkRg7AA4Q=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 22:43:03 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%6]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 22:43:03 +0000
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
Subject: [PATCH v18 6/7] crash: memory and cpu hotplug sysfs attributes
Date:   Tue, 31 Jan 2023 17:42:35 -0500
Message-Id: <20230131224236.122805-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230131224236.122805-1-eric.devolder@oracle.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b4f817-11f5-4eb8-f3fa-08db03dc82d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8clh703IkwXNApQGqAZN08nnufgzYS1gfKZj7z4HNufFTBQ9TrLGP5b0JbiXtuZkcmVmDq5XJblHirfRsm3pi5sPEzfPZT24WLyZTT1vPOsrNmSwQq0aMMczfF8aT2YHHCC9dXzQ9dLSNGLo1/vg1C3NdWn9FCEGC2TLOoS3QUwabRr3SgtkL5AVJgWO0z5XF1aMDCGo/dgOOAx70o/JIbv1bBNweLD033/owDpcUA6NXT7Yo6fTeVnvcKgePJGnIX1fPYLOFkLTOnJtVMR6d7nbp3uxZzU5XwC8/Tykij+7eQ0zqaqiPWtzXxKZlkQVxmTXaiLxsvhjnDL92mxwiTQYuY4auNCCavV31A47+1w8JL78MtH2uXQBfvTGFNvY3vJMnXLgWHMyW/nq/mOgjAe41iyBbtihi7gHXr5X8CzWGUsQN4dBSECjgkLG8S1KFfQmddSRhk2UduR1J6fmv/cm4uWW7xRQ0mp7gi6OJw/BYs6IX0BSCUJmttqfl8uPEtz8p8hANdc2T7TpCnjaJkCE9lydoUFwMHVcdC0LKCskMs9qCCZXrqJ1uTmVaQi82dvN3H5uu1q7YZYkaX7En7Rmz+Pmt18Ons65Zl2gkEXgz7hKdNPwKrOSeqFkO5BBCyJocdIP65/cPp6Co2kV+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199018)(2616005)(316002)(83380400001)(66556008)(41300700001)(8936002)(8676002)(66476007)(4326008)(66946007)(107886003)(6666004)(1076003)(186003)(6506007)(26005)(478600001)(6486002)(86362001)(6512007)(36756003)(2906002)(7416002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tQqP8s2fQrjokXWSE6bPLYWJ29icHVgZ9O4k2PI0XU3aqQagyxUTTY3nHfjm?=
 =?us-ascii?Q?VmzKhg0W/E3Qcz+OKNMzVeFSYSJDAS3vem2zYEKYpTmNVrSHAcaWyvoITMRP?=
 =?us-ascii?Q?yzfmxErkcqiuKWNC8yXfgVCCU+0kEFGU0vXUa7E94spQN7GvoJn3Zkuv8NVn?=
 =?us-ascii?Q?mGGN2dwyLGeDp39rVndVVwj39GdyJdRb7xGFOVzIkT4jIk1D0X4g7MEfkHZM?=
 =?us-ascii?Q?J2RjKf0NJKf86bIprWKqT10j0Zdn39HGw6XU/nTMbe134C1HCV4g56QHyOXO?=
 =?us-ascii?Q?t/rBDkXNLzCU3wmri4YRX6hCb3tNbG37OJkgJX0jyd1JcrSdC9/RQWZVqdH/?=
 =?us-ascii?Q?6OElEWu4l5gU3b9fv1sa1zQZn686MyaRjFxf0pSUWz+ZqJlrRvSbQEJn5EpS?=
 =?us-ascii?Q?1czYS4zIv+SvY1ispi2BZQjsFvTt8UbkXhNvO4tqnyYrcSN4RoNXLOV25kE8?=
 =?us-ascii?Q?Ipe6PgBFDFUAfwgoipdnC6UfCBaNW1NfCFT+UvlumzPMuioCj64Y68/SQc7L?=
 =?us-ascii?Q?KsrFsxVzfVLauY22mU3zSZVIRXK8J0AxOWgz4+6L62I7tjxuByWq7hoFZodL?=
 =?us-ascii?Q?kFmiAv2A109sgxEtROlNGwVycgY3bMKokSMDTAK+m1wZTYvWF1mECicy3pk4?=
 =?us-ascii?Q?s/mEEMgTHeOm/NDfiYLGCsJLwF+U3CPduM/bN15lAQsbhxeMO6KzHmVsJhvV?=
 =?us-ascii?Q?pp4Dx3wBhsQV56aP3VgS8g/A5E/vJ2mv0PGlpn55EwPJ56mM47oXPgVA48BD?=
 =?us-ascii?Q?03fvOVFnkYVbKFg02/mcSjSANbx6k1lZC1lfFzq/prLl5XE8kcYVYaFi2Pab?=
 =?us-ascii?Q?VCP+2Nb7hmIUSTFHbbyiESn1qqOwhuZ7HcGbJ2cd3t+RdqjBSv48xa5p8+We?=
 =?us-ascii?Q?qT8JNKVq8pt/Ke3A7UYfX6/vPEJOUpbQPVNybVB7FV4AZZxHhuLyBXHy1l8S?=
 =?us-ascii?Q?yQ1TPJOy6oqVWCTnJjdmz3yuZNIztBgZA2UBgRB1AiZvrokIcbBGZDHO4yax?=
 =?us-ascii?Q?8kfsCWuP4UgFlS+KpFc5/pL+80K6bpMHr3w3o5IocCj48sYIxm7OPEBlPJyW?=
 =?us-ascii?Q?sFgeOOnXvFQWtfVf6ZewIQ9t8ljLnM/thp1qgLEKXCQ6vuGeG+039W+z7bpz?=
 =?us-ascii?Q?m6Q7qfaz6Ie8qfei0Z4hPrZtOOUPVwl+SvUkOH+OhIlkFfS/y2n0M3P2Mx1s?=
 =?us-ascii?Q?WlWShnxFgFq0eVSzTIRiYU9YdSp7OT5uOBXarmEmQsm3Ds+lcXudCIbbd4f1?=
 =?us-ascii?Q?n6whfTOifsp7irKeABZUce59Jl2eAQThYY4v7nLUVPrZkHyEYWf+ESL0Cnln?=
 =?us-ascii?Q?Ge4Fufs9VPnzvijUBZEyD+Mm2SJBtlX0VswoNK+tNHTSDMd5xdLewTQF1Bud?=
 =?us-ascii?Q?P8APa1CQQHVFS7ZkkzabFpJSdhlkjLDJoXCqKD/IDdtyfhQ07mTo/s2kKMG8?=
 =?us-ascii?Q?GSXHCi+Ca9GQ098Gz+DOrQPfjgDvzCndSDHN6x/XDg1wxTfWGMzBJIDF/lsP?=
 =?us-ascii?Q?lkVxXVCuARrexwRRupSIWxaYMnvSwR8IZC0ljVELPTm8kv1UV5le7TGh7roT?=
 =?us-ascii?Q?eOCFCnmoI7+9PF/fAO5teV81LZQSDBt9LueQ6SB1hnaqLLF//5bTXMFNHHWL?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LzGa0UjDzFdD8YtCXDqI7qCUUETMgR9KcfWpPPg4G9B2MdYETRG32BRZ85g3?=
 =?us-ascii?Q?qRAFOqiTYoSapp/zV7uB6zB3MR7/jnT2+blg5ZwlMfUzA+CebY2redAAyzKG?=
 =?us-ascii?Q?1Br+C45amu3AKpN2Occb3sDXmNv8x8nT1fJo3NOij7VImRt3J9UeiKhgLlW/?=
 =?us-ascii?Q?azaXbOkri/lr3u+BzKCB8EgYoCnyfjGkR4U4KtuGvKp/KkO1ezusE1BKBsgP?=
 =?us-ascii?Q?HlHnQkXXCTDqeFxLIRnV09d2wMEEmQmBRyxVKve1vSi1WrA3O2nfog3TwGUY?=
 =?us-ascii?Q?W7J2g0APW9WvlD2+jps40Hziszh8XUKRsG/Jxe/jS3+qcgoonCtGWtC17lG1?=
 =?us-ascii?Q?9eFAEDIC4aaeX9xby/HMNMi9aEuCe/xC7QYntdPHSwTI/DfxexknZ+w1oPTL?=
 =?us-ascii?Q?mkzuEFDwoYm4DjhsZx9Oa7N2jA4aZy7R0iqdvKVHe6gUp1ZbQx6+Xxx5oEWT?=
 =?us-ascii?Q?iklWpsBaO14itrP+Mcqpk81cFqPstt6joBP6HcK2OPo+WPc9iEa2XUmC/Swd?=
 =?us-ascii?Q?Zn3YO5EnBy/HSUAHEAOq5cfnifNNOG2+1JsOHYkKBRHiN9zlkgERKCAp0K90?=
 =?us-ascii?Q?1Hw41xC5x8XH9z55TUcOccZ2vs5EwMiRJ/Ms5NlLk++KMz56Etx6xPAIKWbi?=
 =?us-ascii?Q?p3+5gBbo8l8BPmjj/SdRqdecL2KJNkAPBbMVeawS5wV/pYi4CZ4446pmNQ8L?=
 =?us-ascii?Q?cd1YATGrzrVGYOV7h25cpV//POqU9qFKCuoArlzlcV4y5hyz5hWix3N20OOS?=
 =?us-ascii?Q?miQyajLizk9tPMkrmnW/bz4gvIcBWevLAHaxtKRZxJmSbzZAfa4bYS/KEKHs?=
 =?us-ascii?Q?da0yoUBSMkp/k7JYNcrcbjaq3jX0b435T41Lj3+hAKpfwliIW/sRjtAIHgan?=
 =?us-ascii?Q?1V62vA5XOIHO68l35k5J/MyT32JsOh5R1CFVjSMTPKz3hyGAhRfjalVbRVYU?=
 =?us-ascii?Q?9x+rae92XrBZwAmof9+TYgwIXMA/1CKKW67uwazKD7oowrkJ/3MXbZdqQFb9?=
 =?us-ascii?Q?/JHrDuS3t0mlpUDugs88cqLZ1juPDQNTixo1uIRwWsm7JBrsrDvUBVj0FEY5?=
 =?us-ascii?Q?QhrqvTCDfD+yHvjDTaqMJ0G5Hp8oe/VqiXOfJQ8H2nnzD6cI8xDexoVjz3b2?=
 =?us-ascii?Q?ZfKivwYEYBGuD7cYN0w2MXvyL0jzTUO98cSnd4dSPZOvDI0xQhuJ3uw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b4f817-11f5-4eb8-f3fa-08db03dc82d6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:43:02.7901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ma7mKWL9KJNF84xcJVZRdxt0xjhtzmM7WSMdxPqOgx1w3zzbvd0KHR3ZstzcW4le+pd7QYuWfCawUnKZ4IR68+eOTySnn86kUoVe87AJy+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310196
X-Proofpoint-ORIG-GUID: w-IDA8lxt6N8WJIyAm9AMYVzfEXJE2m_
X-Proofpoint-GUID: w-IDA8lxt6N8WJIyAm9AMYVzfEXJE2m_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces the crash_hotplug attribute for memory and CPUs
for use by userspace.  This change directly facilitates the udev
rule for managing userspace re-loading of the crash kernel upon
hot un/plug changes.

For memory, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/memory directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/memory/memory81
  looking at device '/devices/system/memory/memory81':
    KERNEL=="memory81"
    SUBSYSTEM=="memory"
    DRIVER==""
    ATTR{online}=="1"
    ATTR{phys_device}=="0"
    ATTR{phys_index}=="00000051"
    ATTR{removable}=="1"
    ATTR{state}=="online"
    ATTR{valid_zones}=="Movable"

  looking at parent device '/devices/system/memory':
    KERNELS=="memory"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{auto_online_blocks}=="offline"
    ATTRS{block_size_bytes}=="8000000"
    ATTRS{crash_hotplug}=="1"

For CPUs, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/cpu directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
  looking at device '/devices/system/cpu/cpu0':
    KERNEL=="cpu0"
    SUBSYSTEM=="cpu"
    DRIVER=="processor"
    ATTR{crash_notes}=="277c38600"
    ATTR{crash_notes_size}=="368"
    ATTR{online}=="1"

  looking at parent device '/devices/system/cpu':
    KERNELS=="cpu"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{crash_hotplug}=="1"
    ATTRS{isolated}==""
    ATTRS{kernel_max}=="8191"
    ATTRS{nohz_full}=="  (null)"
    ATTRS{offline}=="4-7"
    ATTRS{online}=="0-3"
    ATTRS{possible}=="0-7"
    ATTRS{present}=="0-3"

With these sysfs attributes in place, it is possible to efficiently
instruct the udev rule to skip crash kernel reloading.

For example, the following is the proposed udev rule change for RHEL
system 98-kexec.rules (as the first lines of the rule file):

 # The kernel handles updates to crash elfcorehdr for cpu and memory changes
 SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
 SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

When examined in the context of 98-kexec.rules, the above change
tests if crash_hotplug is set, and if so, it skips the userspace
initiated unload-then-reload of the crash kernel.

Cpu and memory checks are separated in accordance with
CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
If an architecture supports, for example, memory hotplug but not
CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
attribute file will NOT be present. Thus the udev rule will skip
userspace processing of memory hot un/plug events, but the udev
rule will evaluate false for CPU events, thus allowing userspace to
process cpu hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 14 ++++++++++++++
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  8 ++++++++
 5 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index a3c9e8ad8fa0..15fd1751a63c 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -293,6 +293,14 @@ The following files are currently defined:
 		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
 		       kernel configuration option.
 ``uevent``	       read-write: generic udev file for device subsystems.
+``crash_hotplug``      read-only: when changes to the system memory map
+		       occur due to hot un/plug of memory, this file contains
+		       '1' if the kernel updates the kdump capture kernel memory
+		       map itself (via elfcorehdr), or '0' if userspace must update
+		       the kdump capture kernel memory map.
+
+		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
+		       configuration option.
 ====================== =========================================================
 
 .. note::
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index f75778d37488..0c8dc3fe5f94 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -750,6 +750,24 @@ will receive all events. A script like::
 
 can process the event further.
 
+When changes to the CPUs in the system occur, the sysfs file
+/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
+updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
+or '0' if userspace must update the kdump capture kernel list of CPUs.
+
+The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
+option.
+
+To skip userspace processing of CPU hot un/plug events for kdump
+(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
+file can be used in a udev rule as follows:
+
+ SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
+
+For a cpu hot un/plug event, if the architecture supports kernel updates
+of the elfcorehdr (which contains the list of CPUs), then the rule skips
+the unload-then-reload of the kdump capture kernel.
+
 Kernel Inline Documentations Reference
 ======================================
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c98849577d4..fedbf87f9d13 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -293,6 +293,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sprintf(buf, "%d\n", crash_hotplug_cpu_support());
+}
+static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
+#endif
+
 static void cpu_device_release(struct device *dev)
 {
 	/*
@@ -469,6 +480,9 @@ static struct attribute *cpu_root_attrs[] = {
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+	&dev_attr_crash_hotplug.attr,
+#endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
 #endif
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index fe98fb8d94e5..a3f37cb57d79 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -495,6 +495,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
 static DEVICE_ATTR_RW(auto_online_blocks);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", crash_hotplug_memory_support());
+}
+static DEVICE_ATTR_RO(crash_hotplug);
+#endif
+
 /*
  * Some architectures will have custom drivers to do this, and
  * will not need to do it from userspace.  The fake hot-add code
@@ -894,6 +904,9 @@ static struct attribute *memory_root_attrs[] = {
 
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+#ifdef CONFIG_MEMORY_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index a52624ae4452..ef2b607fa105 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -512,6 +512,14 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+#ifndef crash_hotplug_cpu_support
+static inline int crash_hotplug_cpu_support(void) { return 0; }
+#endif
+
+#ifndef crash_hotplug_memory_support
+static inline int crash_hotplug_memory_support(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
-- 
2.31.1

