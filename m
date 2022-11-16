Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F24562CCF3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiKPVsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiKPVrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:47:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AE018399
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:47:32 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGJDxk7021268;
        Wed, 16 Nov 2022 21:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=FBOy/qrNE2LepDHPiTcH8lZ4QjwqMgdDISjHDIOKtDE=;
 b=gphGceHaIo0HnCNId2MQnPNld7Iw7kXHkmSvEoChcnWjTbVfW1js7c1OUQekNbKzvuqZ
 5y8ma9qWNHXZ45/faNYeUeZTVU85SOUFc3CiBjYIKIaos3Al3p/Nf6k+FxzSWf1sWvdl
 /z19cfgTQNKkVa1yL5LtsjUCP2e6wpJb8qImi0dKCeerq1k6bHGus0suDX+EBkJ60igw
 K/8nB8PGFUiKmG+GASfxMMydkkyEo38qw9N2C06ExA/Nf1Wz2bSqqtYk55GnJcnNK+WP
 Q71XAaO2ilEgq/H4ylxGK/giZarnGwT2FChACowbKg2IMcA4pzV78k+GLq17fufJ422b 1Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3ns6pgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:47:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGKiJtD000432;
        Wed, 16 Nov 2022 21:47:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3k8y3u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:47:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv8GxNT8ASYluY1ZbH77d2A2cSfQ+V6NhYyBJNxZ0ugfgP95UfthE43PCfiVRLUS4JEvhi/EbIci0GvndVQG8L6emyUXrEhx7l1V3uKsyBumIAcPHascDlkYNsQSUCbNUnUaRAbR9bI30pIynlKcAamgfXr6M/couDWEr121O4uNpTb3Qou4nH9foP4ANv51HV3kWk6r4SzvBFGuJkIqWwPPUJ1TweY+VSnOn+dWdV/U/ldmEpF2/t8jiYZBwWDPmH0nHjnWJ8CIvyVTkyBf68jommqO1o6Gl8DbY2HbOYoyzOTWzrTpx2AZl5NIwKfFEGWKUNm0NyFEjC+vrGNGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBOy/qrNE2LepDHPiTcH8lZ4QjwqMgdDISjHDIOKtDE=;
 b=T2I4Vs+u/6Cs8L1V6YYzZxd0lsKsO8Xv0F0nMRLyskI7/qqgCQ5WdBeszQK5deNj19n30vt/qinKu+CYAMP07e+BjxtPzJcLRxybF9TBgP9cfLeyYoLnBnSZYZUTfK1hV1bwbMHsaI1E7LVuUGT95DAL5k50nsLbfhvFqIsDlE89kZZpEQYqKp64sr5QHiK+UQNpZd1bq5pErKwYYm+JQyuSw7eYYgdWFLq8T6asTaxCfBv1PhEtM0lNWm5VnBj5t0mAnferffyMhKnWNYjv27YANraqYn/mck51XZxfpvQhgFxfncNLRDU7NoNdNTzx2m34y4p6uOaLaua820d5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBOy/qrNE2LepDHPiTcH8lZ4QjwqMgdDISjHDIOKtDE=;
 b=UoaMOK/F9oNYiHCthgCd9X1x0yrBWVYf4UF0M5idKiqgjr8rFgQyNtj4Vyi7woUfGrTHcMxj0dnesWylNPDXV8gMG3oQSS0xVH66JSouBWfCW+iuguEXY6UZbP99UeSENTp1ZR8vAdcFkvvP491wbKN8pV5nj9C9PKbxYp6GKP0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB6376.namprd10.prod.outlook.com (2603:10b6:a03:485::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:47:03 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 21:47:03 +0000
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
Subject: [PATCH v14 5/7] kexec: exclude hot remove cpu from elfcorehdr notes
Date:   Wed, 16 Nov 2022 16:46:41 -0500
Message-Id: <20221116214643.6384-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221116214643.6384-1-eric.devolder@oracle.com>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0050.namprd12.prod.outlook.com
 (2603:10b6:802:20::21) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b30f633-edaa-4698-a496-08dac81c193c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OqHFaLbXyZRSAecE8TXYVxacT+9FCGG/6W0TGKYHoxYs8LYCw6UD/NUwiuwxwsQtPoHEXL7DugSwxznGDZu41cbN877A4yF+11eDbOYXPKbJLGYp2md9UhXcsgdCTGVr/N1cDR6MHtsIVagvk0k4Pi78fcrlYJ2JmeiwzEhVjQxuxOA7aD1HRgest+zvY4qcGFQdFJsFyOpm2G3T5ODLzJyGqBYJH43LY3/I8l1kLwLnmv/MmvQDDzPL3PK2H0fmwbcH7dxbvt9kAi6sQO7aA4PSTns4Pyhm8dgSqrOBzSTNJrKm3oE+8QcKma1VLanWRiDh1xPyU6J70go6DBtndLFoOnws3uy78PuY6BdH0EZtiouQUGYXNEdxlHGTCF37SrSGWJlsaUCOf+/VaGxlukqrAcLyhaUfdn0IaETcmMOFksjB8gGa8h90swDkMT3jAGGFaDVB85RtgRQT4cGcQ1yMJ3RgpX/dUtt3fvtLu/qd21YIt3cXW8MOd3m/RB2mY5K1kSfC3mcQ6U+ZJm/iMJXezwIfxbr5uPAQUS66G6d6+s9uc9hXSJMn0tLivr64ZRhEwfTSBMP/OKRVdeK/vI2O48gzxemxYMh9nA5ZoVHCQez8NHGylzZs7wFRS2byhbkDfxCTAt93RDzhXOMbzwgPHdKVPzGZITrMucPSv0vX+bVx9o0nqSYi6XBVTYyG1nw+cCZavl+y6g6IBqnDBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199015)(38100700002)(186003)(86362001)(6666004)(5660300002)(6486002)(478600001)(2616005)(8936002)(7416002)(107886003)(6506007)(8676002)(4326008)(316002)(66556008)(66476007)(66946007)(41300700001)(1076003)(83380400001)(6512007)(2906002)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ao4Bb+FP03WmIB/3YbbHwhOjiL7LSABhrM8I6i5CfZV57rOPevJMsD2KqMie?=
 =?us-ascii?Q?gBHFOSeYlOQbXVIu7EKruLk2Gq4I6lhvqJPq/UWjSD4U2KvG5jtVhWP6+enC?=
 =?us-ascii?Q?ysVDVDf2+TPgL1UvRwNDNE5T8/Ep07mTtxvqVHvL2PJw9YihRLUe51kmgbzF?=
 =?us-ascii?Q?P108ZZJu6Yb8NC4dZTc/lCCXY5AR5+1vg8FkVBLvnPVPqYBQDvajlFzLpmm/?=
 =?us-ascii?Q?c/yUaxvK8hp78MQJ4oslcwpX8bkFBSKReejGrR9EOmNxnfjVZHJGh2+41woc?=
 =?us-ascii?Q?NHdv+jGn8gWgKrQRbUOMrPUcfAq6X3LikOZ3H4RaM2ntnSg9Mp4qGJapoilx?=
 =?us-ascii?Q?QP5GqijLb7IxK562WROdG3q8UUC1Kg2rLUCAfmdF34H4vH9OKe1ZcLBF5/Rt?=
 =?us-ascii?Q?WZTO6Pgok3+1K1sitzGtQYEFckE+JBBublAzqMj0qlbIWlj+Qw3HeJ1fo2ff?=
 =?us-ascii?Q?ZyBInOwoj315lUc4GyxURB0KdJHxRufVyYsVAy/u9jfmC9QYjgJyE7cE1X32?=
 =?us-ascii?Q?nGBknp+Pxt7WUDfVyTIvMXXgKnowA0CggXHALMmhiJRLvhW9GGDlRWPjKblh?=
 =?us-ascii?Q?gRm6YZWwejaSGaUEYLcnuW4DxUBGcJ5UMBX/erwwNa6uZNijQ7fnIoELfCb8?=
 =?us-ascii?Q?X9MD/FLJxT0gBPg/GgP1iS5LsUDqyFYzGLTxCf+fgJ/uIa0nnvF/k+6XYSsn?=
 =?us-ascii?Q?zZq6s7eHgd0Q3LDqxscbAOp4Fq1ZmmZ0XcMkGovt7qTACKAJ7jL732TiTC7c?=
 =?us-ascii?Q?QQjJBSJu08v3mHC4c98gilm2j5wQzgNpV44bbvIa/p2hvCjOXgsfhwXAp+zv?=
 =?us-ascii?Q?32DfdHuqm48s3U9XQDXKXOnljcBW2L9J2YyZzVXEHlVsbmKOj5hc4oaQ6Ajn?=
 =?us-ascii?Q?jv9bEKNmwCJZ5toXIRaFn2x1/Lq/3Rvty/KQdOyQ2jg1WPaZaYJWa8VmGTIX?=
 =?us-ascii?Q?cYiYFQfjiHfCogEpDfGTDcoT61qQ+w+zz2rvQWWsUChbaO5NU98zp6IwVvQq?=
 =?us-ascii?Q?M1bTwa23NtlsouXpFSeWTqLzoubTAnGAhHRXABme50eH5la2rgqsR5Dn/wZ0?=
 =?us-ascii?Q?GyRBEDGciMmB6hYBaJbaqEg0BQVk8SxCcAO/p8YWeJdfySJSCNKHzkMbcyIr?=
 =?us-ascii?Q?exaIwUyVymhEcOg0aYxBkq+YSNnez5dUAGXxEF+3Ukx8kLLY4k+mQ4k/fcJi?=
 =?us-ascii?Q?/68CNLlJVu+xDIIJoi2uSe3HtWa58XavQt9kb1OriTa8bqjSSh/MEyVS6XdR?=
 =?us-ascii?Q?djtP3RM1vISJM7k8uymwUleb1w3Je/K2oQ9lNOBPjqwTPyLwNf5QcmtxSbG5?=
 =?us-ascii?Q?6knU2tCotdJlhO78wt79yqS1bYGH7JceEZFD/CCF1XuECixfFp7QSB1voTFc?=
 =?us-ascii?Q?xPx5Lz0Zbet8qz15jeirgns5L8sYaAw8HXPTMNnnRszCAO0I8g5LrXfVjYFH?=
 =?us-ascii?Q?4Y9+2neUg6+PgaEVCXEZb9VkA/izOcO7YvVsao7+KgN2Adu0Diq48ZYyhRzW?=
 =?us-ascii?Q?cdu4tWm1wFsBKiQT2j5s9vo7/EZt4K1vQXzpUKKyDA1Bf9d6/YjI4UP0qB8t?=
 =?us-ascii?Q?+0MllkuQXRSGmQVe7JLSOeYfZf6zM785c8AgFGhTffuS2oRUDg2n/hc01fSq?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?luIJE1ZCWX9rMdP4/KKU2OptHb78lnhmMqpcSaIQGthgTUiCYbTC2uQZ+i7X?=
 =?us-ascii?Q?sIwAaG9yytsmhy/xn4E0vkf0sSX+42eJO5R/ly8rANo17IvTtdsdted1mxLw?=
 =?us-ascii?Q?EVRVv9FP+oUZfJOKOkZM/XG1gZMY/mCalmsoZJ7ycUhdRLJjbEN0RLMYoVNA?=
 =?us-ascii?Q?/pbEJfe/c1CLvldYnud9NLLtYDwOU4GJG5XsZw8e9Mzxqk1rUYHDQ8QfYO/5?=
 =?us-ascii?Q?D21aVsoLKOcaP6WXThcUfhAFcXTwUIkhEubuTzm8jhbv+evRRUqT1p6q8nkK?=
 =?us-ascii?Q?FqUC7m7NgzPMeSEtle1hd9ZjdVBKvlYl8LtDup29rOrJeQ+WDtzVWiEFXtad?=
 =?us-ascii?Q?+QeScNqgwXmXP6zqkhl9wcXOGrsUSKkEvKLQQ7hWkiH6RoypkVk2jf0Lro8b?=
 =?us-ascii?Q?zjN9Bk7LixBXTs8eUeM3mvGEbn5kN2aUKpGVQitgCnB2zeJriIhC+fPf3CLe?=
 =?us-ascii?Q?31fY7yewn5CDMoTidnhnzIB7dv/s0zituqRJAexOQ/Z1ysuH6sI2JllVuBK7?=
 =?us-ascii?Q?zm/Ao3t+HvnJRU3yovjdlCXd4Se1K1iDNKPu19rKgdmVMdsDBqteNJlCztZx?=
 =?us-ascii?Q?+eqzbsfj88Rfh8sbM0V3b0Z6gFlS+7n4my4zNUNIJfg/lOGrsw+fnI0rvJyr?=
 =?us-ascii?Q?AC+YYmu89OX/jYmoMIGWMcMklV1JXyBkR2hlrIyLpdIMJVlk/M/x2NICiS0m?=
 =?us-ascii?Q?mE+loNtgdYNkQNqoXGsvY3acnZMHitrYhWFDOwOxFYvR11xCkEPCouV+A2oL?=
 =?us-ascii?Q?WQM3r8a6Fxl5q12VU861Vz0bHpiH81L1ln3Ga6wrqcesPpjFlBeo/pJG3+Bm?=
 =?us-ascii?Q?JZ0vi4nO2k8fA9XRNPXqZwMUNhwSq9pFWm/h1ZxVW0ukNg2MwE4SzvYIpzXv?=
 =?us-ascii?Q?qid6ukkIIb061/RbAivkpAb+2nZ8luF1u1PthkaprO1aCfwpO/vWzn51cvu3?=
 =?us-ascii?Q?6wcWqNYWsXTufbT3kn3+6MQnZkuqiuWmM0zeExpU8IbYUXLVoSyk9G0wvskV?=
 =?us-ascii?Q?rNb9xrgXivuy7qkl5jbhvT1GX5i/e93x/xHMX+z3Mbza4bOnbP2m7xoM1bgE?=
 =?us-ascii?Q?yAhEbrzmtYsOUB4FipU+21XRLPz1IMIRkr4geImzJ2f+NJ9ioOTxkmuC5xrw?=
 =?us-ascii?Q?4qszD1SWbQBJzKF7UFtOAG96cZmCDnhKed62fldgBZcnSgQoA1CHUuitdoDz?=
 =?us-ascii?Q?VzcrtEB7b6FLnZw7vZiq/MvKTX20sHb6I9PHOTMVhONfSzzbGkDSxNcvUH0l?=
 =?us-ascii?Q?2LzN1PDSsiCmytQXEDFD+Gn48pZxS6+oamYxiEpU+6B/3hM1gsALFHjQo9Ki?=
 =?us-ascii?Q?dEPZwbjkTKUlxGNysZHmnrRI2oTb9LeZ8clFIawSM60ZgQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b30f633-edaa-4698-a496-08dac81c193c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:47:03.5483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F86+AcivgNO4yc4K3LNu0ejtr32yFw5eSsrW6n7A5GpgGuWrZ/k0fa9Xh3k9C0teZTH3lCTefs7Hc+6k2mvgmCO+zMRB+DLr/8r1+6RGLNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160148
X-Proofpoint-GUID: JiLGyF5UOqtVT6qOz8_Hx3_yE309Jf3a
X-Proofpoint-ORIG-GUID: JiLGyF5UOqtVT6qOz8_Hx3_yE309Jf3a
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
still in the for_each_present_cpu() list when within the
handle_hotplug_event(). Thus the CPU must be explicitly excluded
when building the new list of CPUs.

This change identifies in handle_hotplug_event() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 4e7221226976..5c90a90f3fe3 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -366,6 +366,13 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#ifdef CONFIG_CRASH_HOTPLUG
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+			/* Skip the soon-to-be offlined cpu */
+			if (image->hotplug_event && (cpu == image->offlinecpu))
+				continue;
+		}
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
@@ -684,6 +691,16 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 			/* Flag to differentiate between normal load and hotplug */
 			image->hotplug_event = true;
 
+			/*
+			 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+			 * this callback, the CPU is still in the for_each_present_cpu()
+			 * list. Must explicitly look to exclude this CPU when building
+			 * new list.
+			 */
+			image->offlinecpu =
+				(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+					cpu : KEXEC_CRASH_HP_INVALID_CPU;
+
 			/* Now invoke arch-specific update handler */
 			arch_crash_handle_hotplug_event(image);
 
-- 
2.31.1

