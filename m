Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C70E6D6B30
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbjDDSFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbjDDSEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:04:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D040255BE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:04:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334Dwtr6022669;
        Tue, 4 Apr 2023 18:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Bo3s0V/G0r2+KolPP9DNdpfE8ZeB/rFFI32lR8aOZwE=;
 b=XNmwAim8SGu/B/git2poemwS0Vxss//wrsQ500du19n0c22uGkjP636tK5vPpaqeDv+/
 vDoBKO4ku1DQSgQm+gYBHHzxSuegy7TvvFR7XXzuTEIcAKgFdTeJ552iCA4p/qfrjdNM
 E+iP4JCrFUaVRmtiZRt3bVDifEwrhq+5ckYKJO/HWGGamWQmMFADSMFrKFY373knSJjc
 nNh2FnNnQKXnmWzT2C8p+Ne70WZjM/CiFdgJFao+W47Vf7k8VotcsSWO3vpj3E28aP4W
 xTTaAaoYqSnEj1ybfdazsAHQEIA59h+6hJmndmBRoqqSRho5UdkGEY14h5yZFv58rqO4 gA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7txfx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:03:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334I2Lqo017423;
        Tue, 4 Apr 2023 18:03:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptp7gdx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:03:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=np0HqA+Nl81X+mz5tgiGHfyUuYkPXehssPjQkl8UbPR3faJaaOI+d53EXy58qlWTJIqRx1SDqL7QZdBpDJxiGnE1LFmS/WC9Le+Hchs7JNDnWDXO7FpyXOVnirstOW/5RfDNAdtcqTiSyJvWVuc0I0h7IOe7UYKq884Wuq9ALpj/4vCx8VPuCIJon2+KlJtnVe2ehf9wVXxq1PHTSvtgGBh45A6+63+s0crzvlCGhk6vPGtHpfNkQpO+Z9Kiq9VL/GDgieC38dPXDaGv901XOkVwk5A/6BQGtLN66whEI63K3MSSs1WfiejM2O1ZzZDll+L6Of/knlCtFy8uuvpg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo3s0V/G0r2+KolPP9DNdpfE8ZeB/rFFI32lR8aOZwE=;
 b=GkyyYvi1TB8lxStOrurlVOOVwEKur8st+FtyYJMT8UxN7S/aIdBHJRNjt60ZN54IGUDXv5o2VBqShuOjwTRB1lpnl6Nou5UeqaA6iZjZAcIJiios2eVLhflJlXVw8N1UChsoUMW7lfJhwSZkMUy5dLoynFN5AOMPj2jdYjxoJLSQa3hgI+cKI91D3FIqOMjFh/MPTBldY9VS9HzMfpCEEyK/hfm5S7IbBRZSd392FscP1sbqB3nmucDYZpTZzbETBMW9dLHgSSl5mRgSP3zAegI+xfcjFtKsSaEQ3kRRBXkGv0jc26txLUx363kR3BYEqihsUmVvrenJLaG4UgREug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo3s0V/G0r2+KolPP9DNdpfE8ZeB/rFFI32lR8aOZwE=;
 b=n14Tbd6T9UVxoZvS8GSAfoB56h9rClsFbY9fRINdQHKwmR5pLu8BpuKtj246/X4Q+gNXrHSTa9foxZbCjedmTU7tTUM+7YRYO5q4zUqa2Wl4Ad9I+qJNDbgsfb8o9Dirs83gHihhIunxZ+wxHLrnCKXzrqzBYkVgKBdxrTEfVFw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN0PR10MB5909.namprd10.prod.outlook.com (2603:10b6:208:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 18:03:38 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3%9]) with mapi id 15.20.6254.028; Tue, 4 Apr 2023
 18:03:38 +0000
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
Subject: [PATCH v21 0/7] crash: Kernel handling of CPU and memory hot un/plug
Date:   Tue,  4 Apr 2023 14:03:19 -0400
Message-Id: <20230404180326.6890-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0514.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::21) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN0PR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ec3290-cbc3-44b8-b4bd-08db3536ea80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1K2q0OmHsE8jl8IZSc5o04M01mdbHHOhbCaLSedQl+UItjBguno66OfFyu0t+1dg9BAPaaai4yETTBYJDlp+5+y3RGXoQqspkgyf31CCp2foWrGH3ZZ9t7TyjaIq0MJ9WaAu0I1PrHoGLkkcNgtRt9o49wLmvGMad2LcGFaacd+pAxmXaG0C98E3tIu+OrmgOIP9NdHAeomjZ59xGQ/MfOXzW3ebMWUm/Yep1ToSXIVzO6dxLLlghKxPQnH99fjAxPzjdGolp3RvbLviekEUYphxXEJFzUKM4O+o5ZWjLJvVizv5J9UXG2J8/hhoLYqyXGwOG01Bg1amGqDAWBJrgKC20vWB3V9B7HOCxiWXNauW2FffRfXwR7bRxBaIDsAYtRqDfezrmOU4+NY/asx42jPPlj2EjOVnZWWv37eoHEv2jgTNy/Goyuuwy2bnkRGzExghhQVa6l+0BhoCYH6gZ0eg2IDxzGq7CTXfQ2W9gLHgftt0YCALhQs/0BTVY/8vzzRFqpwRf14oahpPbqpDG03HVuw7/CXzijjyNdwBWUn3of5LLqfebhyXxR3K1hx9r+6cIZVhOmxXKJSk/8FhkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(83380400001)(4326008)(8676002)(66946007)(316002)(66556008)(66476007)(86362001)(2906002)(41300700001)(478600001)(36756003)(38100700002)(966005)(2616005)(8936002)(6486002)(5660300002)(66899021)(6512007)(7416002)(186003)(107886003)(30864003)(6666004)(26005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NbYlCxrnbDXqafUX1ha3oYRDmf29Gj2YQfJLwUrOZjIlIVvjQ7BnskCLp3Yb?=
 =?us-ascii?Q?pFvSgXA7q01sbMOSQAFpj71cec+BKyG+vQEyA5Kdn2Qwd78m1FII90Le5GCO?=
 =?us-ascii?Q?P61KUJjhSsJxx7Iu3zxuywKSRTDCLJDZSnK7FVa+eBfbOksi28kRHAPoaj2H?=
 =?us-ascii?Q?bk4Y3SIHBKBOf4E1tbZLuBadsn6zFxu0gu0OWJ5yIhoSjV4bqHZIzVsGlKNf?=
 =?us-ascii?Q?9zoaTyge2vf6+KTCcF6AJ1M6v6AfwLqdsk+BAPUu8zcjJD3qNkY5IRA2bLSW?=
 =?us-ascii?Q?6TjBIFaP5YLoKJhwjmO8IXEF+x1Ww2LTlNT8cmWU2QPlkWbyUfE9GMwjDv89?=
 =?us-ascii?Q?3PLXUC6KFbHLbYJC170aMyCZiSCZyH9d2BFStnYJub1dmWNDItCkL1JoOOag?=
 =?us-ascii?Q?wdK7EJ1FPqgYcqkmexSvUv8gJkY1s51smiU+m7+w7Uyyb2clDodOLdUgOzhd?=
 =?us-ascii?Q?uYUb9MYX3wbuq57axW4BKgOJ3tkDkds+cDQLUP9Mf3Qjo1Q2gKNnxZxo74xh?=
 =?us-ascii?Q?gsKV0p9V6FWAsV9hCNv8VfQ9vBoZc+7p+FOkl0uqsGHSohf/qPAVWV91XBrM?=
 =?us-ascii?Q?/3mRXo3mq9mUqfzB6krVVr1PlXT38dPJHUi1GBFRYFxN/jFBd6VvUZuNOBKo?=
 =?us-ascii?Q?f2kTMA4wDNe6ikAHKtEcgZMz1UZW3IRhKXR6YZAD7PQqsZ55UWguZIppSRDW?=
 =?us-ascii?Q?BXHHyl7rlB5Y3gWke/+boT9e5RvmiVPN2NdArGDU8pg/e/K/ZJzJl9nxOpsL?=
 =?us-ascii?Q?QYQ9twyW3JFm4LIlzRxazk9saibgUeFciDB7bK9kw/aW2yJDaa33/6Plex9C?=
 =?us-ascii?Q?THVfJo6JOy6bVjmkcMjaHhdxU41vXKwFaXvm/cRySYKV8k7Tp+vktIcy9UMd?=
 =?us-ascii?Q?zegbhEPEiCKGRrWq3u6WBY68VmBcTgg37Vn0oAHDaQHPqRrp2mEE6aA2aITg?=
 =?us-ascii?Q?yOv6Ajlwv2r/mE2Gqx3unf2/Yw921Hl8IRHJebZW02kCSGz+Lg+c7IkoB4oK?=
 =?us-ascii?Q?uHdbw7kB10+S0G60ORjoFEkme0nCJHLUY9asY3G793/dYaTzilt/1s9NsC+r?=
 =?us-ascii?Q?7n0hYcNQsGPKe9o13ncKfhr2iActcAtpDQoPcMS3/frvF4z1cxZtLTHDOElv?=
 =?us-ascii?Q?3kBUd+gVG6vfxgtpx1QV4aSfKEdRmW4NfAmBz+IV+i3PlZ2Q0tNoc4OM1JU7?=
 =?us-ascii?Q?f+gFozRMlAsQtiZqP9XBhpmIS+QgTLVmYYtgHvXmiDTU/I8gTfUaG/EfHvcf?=
 =?us-ascii?Q?iWWHjDxElQ4Ak/sAU0ETGzqrDzQRkcjENf7gb8gHIIwvsyNejcuNvI691EHD?=
 =?us-ascii?Q?nmOUjyqrTM2vXHkt2f9WAQnxNPAqMR3p7/ZrejIyW4Eg8s3iNdgqQp1ZWCs+?=
 =?us-ascii?Q?/9dgjqqNGXcV8Hsd6Ybo6YCAmx+zuH7I2E77YYOgh1TyefKbeA23aPKQMclH?=
 =?us-ascii?Q?+juHzyDeh9slWF9IkwBgBIeUZmBCEeaa2M/J9tbSVTHTvJqJR7PQqjyhVmmh?=
 =?us-ascii?Q?lPs3+4wixMj2ksMy12+1Oo49VFVpd2Iosjca/HA2NNBMLn4R2/opgEu7xlxJ?=
 =?us-ascii?Q?QUiwTsXLrQoJ/1oz5Lhb+AJnu7QT8gjBujELBPn96NmPQhZOpmybLEWeXCV1?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XMgyWo5wLoZuPoxcCwxQgoVuY3SIi8LpSWC1hv1g5gPMWs1aG5tL+2QgNSqc?=
 =?us-ascii?Q?dskse8UWJkOLDZuAefPfSNYc4LuJxjKLFS+k3Y8kmoOf004lVGC67W8ddxl7?=
 =?us-ascii?Q?/eU8j9sLCZ4QmyzVPaQ8a5Db4YAnxNQ/8mIax9jGUQdv+n8PE1EWygwbLuF8?=
 =?us-ascii?Q?58F1MmilqdKtiP/Nz3QQ8G6luVQ5TfpIpDLm5vW+Shxx/13OfilrxgAjA4M1?=
 =?us-ascii?Q?6BHSmxI5IP7o8ddtcBdasYoLr0bW0e9sONKRvsIs1eEX/YbO6mJsnLPUXTSx?=
 =?us-ascii?Q?M8ncs8KtFr3jAwv8y5lcqU2hNsIZPPbTB9OiJT9eYRgmTL37KnFgCjT6EW2w?=
 =?us-ascii?Q?ictP14LIUVi+whfhiy+mPBXnNTT5FHPlCMpqpQp6QJo9Vgt5xZRktPEkXkdK?=
 =?us-ascii?Q?MkoVooGK+lX0SSbL4s9qW61eQt8TaWPCY953RDqVkGi+PGHsMcDfMOQC/E3X?=
 =?us-ascii?Q?T6gy1AivPOoANf2oG0ljWwvdArx0oxXy5sbskjQIOedTIIuFwgqs7cr8g/3q?=
 =?us-ascii?Q?KLg3Y58V7z1zn5rR8t9JSiD7DY9vlHGoV3g4bEWU3wN4/ixf/XFxov9ZV3KU?=
 =?us-ascii?Q?MZvR/RiKtVZs7mLn6TapqRZf3aOExkXxy4ni0dLtFO0bKwFxfVI5S+kiXXAV?=
 =?us-ascii?Q?3LV9EtLb8Y9TlH7scTeR4pGPzOXHKKvikrS3WqM6hsEhvaRnCL5ztswHLi9P?=
 =?us-ascii?Q?T4iq7OAqlWu752sDm9olcL5gl53VdF5Mg+VMhD/oYCbxLw3ie1UCRB+9dP/D?=
 =?us-ascii?Q?yS8b/nBNbyVodTWi9YLgooldyyFtJYpMzW0QkIuxzYAUIP4GKOAfMdgdEtNu?=
 =?us-ascii?Q?xSQbFz9k1sopaQ8A1pPcfR4Z0gcBlctIDduMnfMlaeJy4CkW8KhUU6Xb0KxT?=
 =?us-ascii?Q?7kU+bLx6qTYzx5MNOJNhOweBIvIqccJkxLf1qozL+WKh5sOnKj9baCmIWX4Q?=
 =?us-ascii?Q?WN/Zu5BI9vl+1x9Dui5VyyHGMpeEUjc4UDEEcIl1YYhmHRRgp5ebJwDWgEsR?=
 =?us-ascii?Q?iEFcuTM20A1exczh6lMe4p+XNFTEMhyKuOlJxrFCxVK4bUpI8Df+ktznWl2j?=
 =?us-ascii?Q?kpHwoF21B3fu6wEfMRJfAooQEB46CUWKUw+Ppsbkm7B/LZeQXcP6oqqhFReM?=
 =?us-ascii?Q?9YGa/2c1OkNS9kMkWFW4k8DOn5KFYIxB0AtOImTKXgMs8xC/VFsd9WM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ec3290-cbc3-44b8-b4bd-08db3536ea80
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:03:38.5068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUk5FbC3TbcMeQ6SBsumzHEDKUHM87dnwpXStVQLfr7/fO4eb2pVfIDQWmXmBPYrLiHak1DcHu0yE6+hsCLf8XTpnt9GuOWUprqfhKve00Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_09,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040165
X-Proofpoint-ORIG-GUID: jTqHHSRsIAH6mWw4fCBeMsXgXXny_fGu
X-Proofpoint-GUID: jTqHHSRsIAH6mWw4fCBeMsXgXXny_fGu
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the kdump service is loaded, if changes to CPUs or memory occur,
either by hot un/plug or off/onlining, the crash elfcorehdr must also
be updated.

The elfcorehdr describes to kdump the CPUs and memory in the system,
and any inaccuracies can result in a vmcore with missing CPU context
or memory regions.

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, purgatory and
elfcorehdr) by the userspace kexec utility. In the original post I
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash handler that registers with
the CPU and memory notifiers. Upon CPU or memory changes, from either
hot un/plug or off/onlining, this generic handler is invoked and
performs important housekeeping, for example obtaining the appropriate
lock, and then invokes an architecture specific handler to do the
appropriate elfcorehdr update.

Note the description in patch 'crash: change crash_prepare_elf64_headers()
to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
enables further optimizations related to CPU plug/unplug/online/offline
performance of elfcorehdr updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel updates the crash elfcorehdr for CPU and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   With this changeset applied, the two rules evaluate to false for
   CPU and memory change events and thus skip the userspace
   unload-then-reload of kdump.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load() syscall.

This kernel patchset also supports kexec_load() with a modified kexec
userspace utility. A working changeset to the kexec userspace utility
is posted to the kexec-tools mailing list here:

 http://lists.infradead.org/pipermail/kexec/2022-October/026032.html

To use the kexec-tools patch, apply, build and install kexec-tools,
then change the kdumpctl's standard_kexec_args to replace the -s with
--hotplug. The removal of -s reverts to the kexec_load syscall and
the addition of --hotplug invokes the changes put forth in the
kexec-tools patch.

Regards,
eric
---
v21: 4apr2023
 - Rebased onto 6.3.0-rc5
 - Additional simplification of indentation in crash_handle_hotplug_event(),
   per Baoquan.

v20: 17mar2023
 https://lkml.org/lkml/2023/3/17/1169
 https://lore.kernel.org/lkml/20230317212128.21424-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc2
 - Defaulting CRASH_HOTPLUG for x86 to Y, per Sourabh.
 - Explicitly initializing image->hp_action, per Baoquan.
 - Simplified kexec_trylock() in crash_handle_hotplug_event(),
   per Baoquan.
 - Applied Sourabh's Reviewed-by to the series.

v19: 6mar2023
 https://lkml.org/lkml/2023/3/6/1358
 https://lore.kernel.org/lkml/20230306162228.8277-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0
 - Did away with offlinecpu, per Thomas Gleixner.
 - Changed to CPUHP_BP_PREPARE_DYN instead of CPUHP_AP_ONLINE_DYN.
 - Did away with elfcorehdr_index_valid, per Sourabh.
 - Convert to for_each_possible_cpu() in crash_prepare_elf64_headers()
   per Sourabh.
 - Small optimization for x86 cpu changes.

v18: 31jan2023
 https://lkml.org/lkml/2023/1/31/1356
 https://lore.kernel.org/lkml/20230131224236.122805-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc6
 - Renamed struct kimage member hotplug_event to hp_action, and
   re-enumerated the KEXEC_CRASH_HP_x items, adding _NONE at 0.
 - Moved to cpuhp state CPUHP_BP_PREPARE_DYN instead of
   CPUHP_AP_ONLINE_DYN in order to minimize window of time CPU
   is not reflected in elfcorehdr.
 - Reworked some of the comments and commit messages to offer
   more of the why, than what, per Thomas Gleixner.

v17: 18jan2023
 https://lkml.org/lkml/2023/1/18/1420
 https://lore.kernel.org/lkml/20230118213544.2128-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc4
 - Moved a bit of code around so that kexec_load()-only builds
   work, per Sourabh.
 - Corrected computation of number of memory region Phdrs needed
   when x86 memory hotplug is not enabled, per Baoquan.

v16: 5jan2023
 https://lkml.org/lkml/2023/1/5/673
 https://lore.kernel.org/lkml/20230105151709.1845-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc2
 - Corrected error identified by Baoquan.

v15: 9dec2022
 https://lkml.org/lkml/2022/12/9/520
 https://lore.kernel.org/lkml/20221209153656.3284-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc8
 - Replaced arch_un/map_crash_pages() with direct use of
   kun/map_local_pages(), per Boris.
 - Some x86 changes, per Boris.

v14: 16nov2022
 https://lkml.org/lkml/2022/11/16/1645
 https://lore.kernel.org/lkml/20221116214643.6384-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
 https://lore.kernel.org/lkml/20221031193604.28779-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc3, which means converting to use the new
   kexec_trylock() away from mutex_lock(kexec_mutex).
 - Moved arch_un/map_crash_pages() into kexec.h and default
   implementation using k/unmap_local_pages().
 - Changed more #ifdef's into IS_ENABLED()
 - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
   into x86 crash.c as #define rather Kconfig item, per Boris.
 - Check number of Phdrs against PN_XNUM, max possible.

v12: 9sep2022
 https://lkml.org/lkml/2022/9/9/1358
 https://lore.kernel.org/lkml/20220909210509.6286-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 https://lore.kernel.org/lkml/20220826173704.1895-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 https://lore.kernel.org/lkml/20220721181747.1640-1-eric.devolder@oracle.com/
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 https://lore.kernel.org/lkml/20220613224240.79400-1-eric.devolder@oracle.com/
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 https://lore.kernel.org/lkml/20220505184603.1548-1-eric.devolder@oracle.com/
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 https://lore.kernel.org/lkml/20220413164237.20845-1-eric.devolder@oracle.com/
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 https://lore.kernel.org/lkml/20220303162725.49640-1-eric.devolder@oracle.com/
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 https://lore.kernel.org/lkml/20220209195706.51522-1-eric.devolder@oracle.com/
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 https://lore.kernel.org/lkml/20220110195727.1682-1-eric.devolder@oracle.com/
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 https://lore.kernel.org/lkml/20211207195204.1582-1-eric.devolder@oracle.com/
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 https://lore.kernel.org/lkml/20211118174948.37435-1-eric.devolder@oracle.com/
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 https://lore.kernel.org/lkml/b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com/
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---

Eric DeVolder (7):
  crash: move a few code bits to setup support of crash hotplug
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  crash: memory and CPU hotplug sysfs attributes
  x86/crash: add x86 crash hotplug support
  crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
  x86/crash: optimize CPU changes

 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 +
 arch/x86/Kconfig                              |  13 +
 arch/x86/include/asm/kexec.h                  |  15 +
 arch/x86/kernel/crash.c                       | 129 ++++++-
 drivers/base/cpu.c                            |  14 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |   9 +
 include/linux/kexec.h                         |  49 ++-
 kernel/crash_core.c                           | 324 ++++++++++++++++++
 kernel/kexec_core.c                           |   6 +
 kernel/kexec_file.c                           | 187 +---------
 12 files changed, 582 insertions(+), 203 deletions(-)

-- 
2.31.1

