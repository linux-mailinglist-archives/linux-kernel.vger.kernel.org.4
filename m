Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A76B683986
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjAaWoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjAaWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:43:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257AB4614C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:43:50 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIiH3a021418;
        Tue, 31 Jan 2023 22:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=08ihQdBGWvRilR/2uujMfBbxUyEOPxzlfkXGugWjcW0=;
 b=ZAczgWqyZRMUOxpPVvFCYF0wpJT+MHhryqyeUCqrNtavMend4x36xEohDzlmEjlsqKPh
 /SBMsZ3qFCuj7uiIdoTjVBTXU9A9b+nXjabGbfC7NqOD7L0eM7DjHHPaFNtxyWKNT7Hh
 z74qzLlD0WirI4CgruM00mcrrSci1ZKgCsKTyHEOTgbqz9tL8PNocoO5mvOl2XWLC84E
 mg9j4RBnxe0/rfsST1NK6yLQ3vJWNjUD3MSporjSFCohSg76/Dlmky97b9HveYboFizg
 ZDhMMHeJLb6BLaVgvrrkYvt84657jC3pT7I235gYbuFt7E5LyGeCiLXL2g+uw7SWEyXD Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvr8q03d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:43:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VLCm8k012912;
        Tue, 31 Jan 2023 22:43:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5d7qg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gABU0SDt7YMpm/qDjk0zuyGga8MtWN3uXtvWya0cl0vO8ymHLz1keZPDn/dtW+OsrcDOPa/c5qmj6vHQr5jBeQnRpo+Thoa9qKw56DSFMkXPk2ANNr0vshV2QBRvi8v9h80pNLn9d//pNnPvzesfDcru1N7OGuNzflBTSWFsoMrcdLH3usruzvaHOFY1QbWYbyFQhHMfMZgTXs7qeX8+kft4OOpX65nOeD+S6M+ayZcX78/1Sr/tf/Wu4qi2+4zxNIC5LQsCHORekVuWkkJJLR5Q35nZuYHZRGJMuayyjMCL73ZLHy3OZr2igI5/Ih7Zed6KNdE+u0GMXBRUz9V8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08ihQdBGWvRilR/2uujMfBbxUyEOPxzlfkXGugWjcW0=;
 b=Hklmq3oW0AhNmsk7fdYTUjtFG7XOZzx7HJfFppT9a7bvxwgq5FfV7T4So4oVUcCqDU5ulo/nNg04gNp7swrpUoE253ILetwkD3dyjBjH5CYekM9q9ZhFoye7hv0zSBKREl37I90G6p0jQ2/pqf9uyIEjKYDtvgJHk4CINRQOISHOI6pDGgFtECxkQ0uAdIYs6KfS8vdKIZen3OGzQdtLpWp8/GCzVkcNV5DXcz9KJTMXzNuWfPANsI5+6BNOVtSET/tCK8vAdpMsDpJkZl1ShLaDUcccqihQnoDlrJyzQLnfvithnCXGahNcZeA+ZeaR55DOTFEwQj9mQ4b+kt14GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08ihQdBGWvRilR/2uujMfBbxUyEOPxzlfkXGugWjcW0=;
 b=JoX6xCZam5BL6Ofe0E5uaf3ZwFcKhTD3eqUSIuvYz44S+pT2PuuOXbD9q0lDJYc9vYwaOKedUOD9WmiizYT5Q+zv0lxv0/WdqdbAE34Utdmn5JZvfKgaULM9ETde2RsCOvIhYlseKADKsWo8maEKEGOrQIYT/0+YWQXaouChqXE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB7241.namprd10.prod.outlook.com (2603:10b6:930:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 22:42:54 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%6]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 22:42:54 +0000
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
Subject: [PATCH v18 3/7] crash: add generic infrastructure for crash hotplug support
Date:   Tue, 31 Jan 2023 17:42:32 -0500
Message-Id: <20230131224236.122805-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230131224236.122805-1-eric.devolder@oracle.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:5:190::37) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fe14bc-0f9e-4b52-23be-08db03dc7da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOyIB7cVMir4naFJ1ufqkVHz9nwEhkEAFQ9s0SPAORa9BW8p2lF1XsOq44gRb4oUFkCGU9PL/IqIBuW4lJnWI6Gq8jd86F0aNdi9cVM+EKK+hbduahq/QibdKI7EYqvO8VoYMzDEWN8kz6CH3uCmYXIA7vll2MJ+NdEQ0XIN+kLl/YPOfQaiAu2aorEKQjIH8JKE3XimrZgXyfGPWnaCcmzpFExvAE9ifaKBFkugdzKb+sK60c4zM8d07tUS9BTZJZ2n75gb4dKTXIFFqagcBEHIBLuwyGZm5NCthc15ibFtseLgPu/MJuySAMW59j3z576Y8mWdboi2R1VUmV8kkgswpzvKxKNn71mnrrmr/LRTzUMXWlrUYA+RCk7Rt17dtFdM9MXxjrPMus5eDSObfKZ6qGnx89Oq8FLRfXa6weHPzBafwwuSRBD9enchgdxpj0imdJFt0RYoC96cIaFrFBViLPkuhwtoaNzBnmaENaFp+4R607ltd8LZyMygyCqMtPpQ/H5ui7wlDtJelHKdXRy6oD92uUDYZNV4qQkC6/iasJyn4mgo2FnzduJtuLy+OWPpPIzLbwpRdZcjxherJl30sksDTS1pbWqGW6H25jTLq56fEET1AZZTp1L/gIrvFysk+PmBr21X8imJtUgrbRMhV1TNP1SAympBWePi8gUdiSxzBM6QzmDq6H/hVLHm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199018)(83380400001)(41300700001)(316002)(8936002)(4326008)(66556008)(6506007)(8676002)(1076003)(66476007)(107886003)(6666004)(66946007)(6512007)(26005)(478600001)(6486002)(2616005)(86362001)(186003)(5660300002)(36756003)(7416002)(2906002)(38100700002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kdj/6KlWL/SPp+7+5RSmJ2Y9Gy0wEZo4zkzMncaNc+EnqQVSV/z7rul/E5tW?=
 =?us-ascii?Q?rz/cyC982swefn/yTnNbkWhEFCPmU/7ArQiOFEJ1qJVwgvAhwaxdsU1yuM8c?=
 =?us-ascii?Q?YAP4GVi036RairRq614e5fd6xMbbiuCqVygI1n0s1KcQ5NwqLF382VgZaXsP?=
 =?us-ascii?Q?MxUieMCytNZMxCdb5UQ+zkkPtrdWx9gF6qjKqtkafCvSSlVcaB/nTbhoB2LD?=
 =?us-ascii?Q?hgfhkmXWCUv6iOFYDFhWe2krHIz8Isi/xDsXcI1r78mqxJeSsfPdVWaGY8FA?=
 =?us-ascii?Q?OIKAtgTb1mw9BPHLaGaXYC98BkQciCHeyky7gVFP2T6csNdOCfB2qFVNsUYc?=
 =?us-ascii?Q?rvZoO/141kknkUgPHGufOrQaYjSyKmmH+yE4JkPc1ykp6fCjcl5HYvRq67E8?=
 =?us-ascii?Q?inW8VbNosEn1vat9SxWWDEeb8lUaRnVQYYaSjoxLO0mHwj1N5yJMBY3NfnrQ?=
 =?us-ascii?Q?nbp6RmHeR5dVja7wMJ0wGWOB9hNJ8my5/lPH3DUCGoxFSI8VCVkrqzy6HC66?=
 =?us-ascii?Q?b81QD0OoCNx1lve9ieek7Xr27F4I/PYD94Ho3rJOPkI6WVSqdbMWnXnEt7Ak?=
 =?us-ascii?Q?CN+sa3ZgNk7ZmM1OKU+1YagT8WawmZr/bnnIuL35ipGDS6mXWBfZ/ZXYHvsM?=
 =?us-ascii?Q?ljtk5PDgVey7H/7jYYFxF7VwcW/KdlPCVKrO2zeSpHB6j4QJ2vtGQTPox16N?=
 =?us-ascii?Q?WBu3VZgKrKUCSHqCGGPSroShjz+PG3L9DTIlyZSzq6R8JpPkjXb/T40ZiwO9?=
 =?us-ascii?Q?1a3U74EYWAsJmnsb6dvJo8t7kqjEgYApZWvWVkzMUfZWDQZPQBOMjRaSY+Gi?=
 =?us-ascii?Q?uUWxaX7cS5PhGlrslOwAmZtcvQfkWM2x59N6/aIsPoIU//0l9BFwSi99s8Q+?=
 =?us-ascii?Q?vyhqzTe15dnQz87cvMRGfXsz4dAVxjARX8HRRthLiJnKCGceUD0PiW0AkuvK?=
 =?us-ascii?Q?I17li3Inwa+utCVrGKmPpbdE9ZoDqEmGBB1kGa7IjjhhD+jaXexyhi5zK7z6?=
 =?us-ascii?Q?QoiwOODD7PVQPlGLqWAaKMz5WC2I3IifpZCQLwplsuYYu3ByXjLXED6PSxWN?=
 =?us-ascii?Q?0L44IIbJXrzO1PGMcZWso4PaqsqN+vSYDeRjm2ZMVOgRsPAki26AVCHEHbxJ?=
 =?us-ascii?Q?Rq1g93t8MOcxGLVTErcPgxdUpgFfaQ4GOLfLdiZLmlI30HEMOW33inunAMA4?=
 =?us-ascii?Q?7VUTc0297nM7RXwBU1K06B/JmhfZ7ZAmdBun+hCUB8OZW8xGyoFN/vysPIIE?=
 =?us-ascii?Q?TEEdkPnXJr13tgdtdbL3Oj3sAmD6IzzTLvHwSJ/pj7PmrtPAyZWEKgu8cJzv?=
 =?us-ascii?Q?Y0pKJrQzFaYxYCR6mnfJ0p23G/4emyyLGLVwHk56O6TGLo8kKQZumCQVW8AK?=
 =?us-ascii?Q?qjzCbmaJYkfiz9qlkG4x8N4GOBHB9o0RLcTctXDOt9pApXasoISeEbhJVvC/?=
 =?us-ascii?Q?Snxs6rdVurRq6GNobr/ubPeha1rLeyCVTZfQL/pWCbWRPW4xsjtXSsOxmjun?=
 =?us-ascii?Q?7m+PZsojDNnPFveKLF06G3ZZPtWDrSvcv3WaKOcBJtKp+28VNe88u/T1JEfE?=
 =?us-ascii?Q?EyDhoDg94LVg9hYmHlCclyy8RcIk1gt1z83oBuJdBx83D6/H86umFTvdP0J7?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ef4yHhTJF9qcuhnP5u4uXAu7ObvvwAFzTsvb8j6YFxkUWzLisjHPHrg2/HPW?=
 =?us-ascii?Q?+aORWW0QGGZ+d47DIr0BhavOjubAuZCom1PvYfd3LN6EIRnScREhGcrLuTXS?=
 =?us-ascii?Q?j32tGBJsYExNCOgYYNpwUCzdylgvxtGN8uMhzLya8Y3oF3TiWxtqVc9yhko5?=
 =?us-ascii?Q?wsXRd7MZyEbvwklYux+5EdA82V9O1pZY5+wrJZWpXvER21mPHTAVuQaN6ZoN?=
 =?us-ascii?Q?E7beUTnXK9EqYVz4MOR/cIMajoaH4nDfkrCo6/5xG4lcg4ztmwvnMeTLprjY?=
 =?us-ascii?Q?mDyKYVmuiVk919yKhD5HQiZHOZVAAbDWvmS+dTqrUmjFUzcy1hkoGVCYlhIN?=
 =?us-ascii?Q?hI6KajHGUtKkpz3EwHUuiClwu5wY9A0lsnZeQOf8nMeBwuhNO8AyPaEIILSR?=
 =?us-ascii?Q?ZbsH3VRJxoIOcCfhRaZKb/iek1sPJ6AQDHTh/jqGZmyn4aICd4zOSg3qFFou?=
 =?us-ascii?Q?VdIxihQ1rB+drshesVKEbZIvcQxXIIHHwrS685R48O4vegDVvrggunZpWZ/p?=
 =?us-ascii?Q?EAwB7NtPNUSAvhMyq9UyyC/9zXg6l6UT5clv2GTcgfYDYHt74jDZpYStbxgB?=
 =?us-ascii?Q?1J/QIYxJIV0whpET8poX4+bCxTrPIRD8bI7nwjzlCIxFO3CWM+1gi758ERnJ?=
 =?us-ascii?Q?rzNJUFrDKawBP35gq6ruvD4jvOmui0zuVhG2muYlFUhOIPD+KNKGSo/bcUFi?=
 =?us-ascii?Q?XCjketD3iSeAcmaPaX27C32FVnyfrcox9p9vPSTSyxXjiOu+wV9yNpv6jxTE?=
 =?us-ascii?Q?LwmTKPEq31OOVjVHU59xCqPhs+NCSC2kgZNy/n7pktuzGWXFh2v0W3nDFmZu?=
 =?us-ascii?Q?/a7clGOsWsD2Yye84bzvEYveY87PEoDvbJ1SMgYVj5MgLMUd+c2LqW/l7FLY?=
 =?us-ascii?Q?DlZiBjtL849Gl5lHFM+yeXlKTbceAfMGlpVOTTwPX5czyNvhEzCLW7GJJTUl?=
 =?us-ascii?Q?Z9QR7qEIBHWhGfF5bqBKbYk40u90NKRD9MIfXbl2DKrXxBJrN4BRfLL5YEfA?=
 =?us-ascii?Q?uXa+nK5k8IzoraAl5vLHjjdFPvFqjrCo0e4iCS6hulK8Y+WhDQATWXitnm2b?=
 =?us-ascii?Q?n8V1sStu0luCTtlSHAvgmFHSFv5WMuIkuQ349Rltjg4zR0l83gyG6LVXQ0BO?=
 =?us-ascii?Q?bX1hvNZCNrewTZC/Vh8DBCSfjR1Hvns0tER7kkVIuWcjp5b1B4QT4sY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fe14bc-0f9e-4b52-23be-08db03dc7da9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:42:54.1325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kO2mSWlbuO8OFLhAYEEfqCYiH0UkkqWFus7W1XK58LbWEOJehIjZ70RM8dEek7HiEFDM44CcKkbRoczH4Dg5D0QDUFIlE2Z89OtT8VPRPtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310196
X-Proofpoint-GUID: Nr-jP7sDdrpDEwBOdqyS3--SDFINFZiR
X-Proofpoint-ORIG-GUID: Nr-jP7sDdrpDEwBOdqyS3--SDFINFZiR
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
onlining).

To track CPU changes, callbacks are registered with the cpuhp
mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
crash hotplug elfcorehdr update has no explicit ordering requirement
(relative to other cpuhp states), so meets the criteria for
utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
state and avoids the need to introduce a new state for crash
hotplug. Also, this is the last state in the PREPARE group, just
prior to the STARTING group, which is very close to the CPU
starting up in an plug/online situation, or stopping in a unplug/
offline situation. This minimizes the window of time during an
actual plug/online or unplug/offline situation in which the
elfcorehdr would be inaccurate.

Note, that when a CPU is being unplugged/offlined, the CPU is still
in the foreach_present_cpu() during the regeneration of the
elfcorehdr. Thus there is a need to explicitly check and exclude
the soon-to-be offlined CPU. See patch 'kexec: exclude hot remove
cpu from elfcorehdr notes'.

To track memory changes, a notifier is registered to capture the
memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The cpu callbacks and memory notifiers invoke handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event() to update the
elfcorehdr with the current state of CPUs and memory. During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |   9 +++
 include/linux/kexec.h      |  12 ++++
 kernel/crash_core.c        | 139 +++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..ed868d237c07 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,13 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_NONE			0
+#define KEXEC_CRASH_HP_REMOVE_CPU		1
+#define KEXEC_CRASH_HP_ADD_CPU			2
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		3
+#define KEXEC_CRASH_HP_ADD_MEMORY		4
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 27ef420c7a45..a52624ae4452 100644
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
+	int hp_action;
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
index a3b7b60b63f1..5545de4597d0 100644
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
@@ -697,3 +700,139 @@ static int __init crash_save_vmcoreinfo_init(void)
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
+			/* Differentiate between normal load and hotplug update */
+			image->hp_action = hp_action;
+
+			/* Now invoke arch-specific update handler */
+			arch_crash_handle_hotplug_event(image);
+
+			/* No longer handling a hotplug event */
+			image->hp_action = KEXEC_CRASH_HP_NONE;
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
+		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
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

