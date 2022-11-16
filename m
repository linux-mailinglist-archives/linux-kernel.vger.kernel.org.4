Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1017462CCF1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiKPVry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiKPVrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:47:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A62A165A8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:47:31 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGLhWOH024213;
        Wed, 16 Nov 2022 21:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=yMEg29W3sMLUXgMiy8fBRbgWQt1x97oMT+MMk1QNbdw=;
 b=o8d6jDEjSmxxjhAH2r4zR1penVClzaIsc4eAraeAiFF83MllxgUeQ7UoPZfdZmHCIxjW
 KgOwWW0i9R1SDnDX7HWS3R2cGLffripwJZ4qCHQ7x44LICumjJ38+LMnlMvNm+gKVasE
 YGHnNhJb/K0oXk2Ow4xVyqjj/IuTZNr4Y6a6g1z7XYAHgyIR0to86utcLn6U53qpNf3m
 QJuOGSryZvLcjGOEHKALs7bC6gclFbSa4ktbrXrpmT8+K2C5JVuV/Bxjj1WMgwjjzIZW
 QiidC09HP2rRtq3iloCy5ZYHHUYRCCVhyuQEajg9g3BBQpJRlRpuuwg2+nMXurp+0SRB sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3n16t5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:46:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGL7Dm0040913;
        Wed, 16 Nov 2022 21:46:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3k8y3kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:46:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UN5tkUl0l5RYA96yu5IG2VKRIB9FCLLnhYT+gE6z7LZWjLRrj0jtmHWcEYI9lBrIQzSQ7k78kkGgtCsELioQ+g5pRgF8+jTyhU3z8+G46FTo07Iz1pItftl3lLfZBEMiWGc7x8JNJ16qctP0SIpP9E7pS+7zfrHTO2FoZi207NCAXxYOhw8HAXx50VFp5yhEZKnKt85XDZ2gE5V8lhcwu99k7AtnfwDIVMcpHxfw30KGmNFyRPLCWQY3m0JC/xZ/GuxJ1qRhS67fyyIphXq0dTLoDpR1vNLNDYmF5lN15z6LFMcmwd8yaf8MZpQlvbD2anWrp4MXEyQ4H/HNPnMC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMEg29W3sMLUXgMiy8fBRbgWQt1x97oMT+MMk1QNbdw=;
 b=ULBhyYGStk16ZmZf1bBvsvyCK3IDPP3PV9qGQYiYPBJ1GQMgAA8al6L8micljNNYtDLW1Ep21C33kqbdN+HcAr0LbIGeoxc0DDMOUCwCMYi4nX+JMqT2vHsQ+E7oQTGxNaDuGYJq7MINFN9TkEkK3Dim6GXE/dTQKnK2bXLT4qP5lfwnaRJ3cDGYSy+ZOJUgTlXQfaYEcpKrCcNQ4AyLHt4iHLEcW+UiK7Nk6caq5hZcx+wIEcqT0rfUEYrf5vQZ1d9ekmaYgyMC6sqWIHMXzYazFHO4aKtbAzue7ZLJXxiAiKSUUvX8ZjDMwdLOY5mZTcubWirQm92f3Ba7O3RJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMEg29W3sMLUXgMiy8fBRbgWQt1x97oMT+MMk1QNbdw=;
 b=EUQWIZW9MtyiluJb3Atexp2u6/almX60yftMTuuiEFrO6rduXVyIcXkxLyuYjdrClNTkOur8veA1EmDmvC7adcet+9mIk7bRf+jdeQyzXeknpEiJf89x+YR+2UyFLLnFCrXu01mPVF54XFe9AoJFs095UI5XOVvkIyqv5yiUumk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 21:46:53 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 21:46:53 +0000
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
Subject: [PATCH v14 1/7] crash: move crash_prepare_elf64_headers()
Date:   Wed, 16 Nov 2022 16:46:37 -0500
Message-Id: <20221116214643.6384-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221116214643.6384-1-eric.devolder@oracle.com>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:805:f2::32) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ec44e6-ee9a-4a2d-c3e3-08dac81c1322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNAiHKzSLyVhoLW/eK56U+FhYZReRWU79aXyI/9XxZ7AZHrsu9zLvFS2obeeRAY9gyVSZq98BXYbab89uJWgUzzOmJjxWsxEv+92Wmp9GpA8fNdA8muSV4LAzl8cSJXqStWW3x8x7W9Lmj6mZwwSxcTL8K1p90RUIdW+PnN1Xfozwp0XYhdoHIO9ZjfqKFT4QaJLBEbdDpn0aMBwYt/+lP5ydrXtrhB+9w1todIxBt1mmu2/U77H+RBA0DX1jAWxsBBuyFt9ksAbRsBVIn+n9J9zzxIjsocMZPnHh3ocyFL0tkl9si8rNRbEo3dVJ5qwdDzPRE8IJyDgrMXOFLsrD7obAT66xfuQa3++LorhSW1xt8MD/Lw9iTnlAWhG6q3FaMvZHGp+lFOHO+874IMS3FoHzWWnQUtwZqqLYjklTtu8SBll6f8Y6OyqfAKvCVzFyP1YICl0W69hJ5Wdt8mDKdXKIkpCZhW/PBtJkQ6Oxg5l1j9GI70qLKLiDVs3Cp1NEQiU5seESFhk5DvGHc5BcCu1dQFuUxVuMY1ouAWJzTukzdrW7V/jiAfdt5QIyW9WXmHEZnKjC9zN7Cvg/PbHhYEVhYCsgXd6yMad5jadqqGrWll8OEy4jdaMA3E37QZpF6sqsWeu2zD6BFVR8Ly2Gu84k+NCX3AgXqcAtJgsr+jzQamFx2mOKKsF3T2r1pm2KN2k4GZ5W7ObNNi8Mg3tWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(26005)(478600001)(1076003)(6512007)(186003)(2616005)(6666004)(107886003)(86362001)(6506007)(38100700002)(36756003)(8936002)(41300700001)(2906002)(5660300002)(7416002)(4326008)(66476007)(6486002)(66946007)(8676002)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8JK246N5oRIX9EXJDlF6UPF0FlFyHrwKu3HQjQ0PxX3X7zyq9O/j5ZetWI+4?=
 =?us-ascii?Q?9uTQ28InpODBHwJY2Ud29kyBliBwe3CyUwiRrCVKsMsez30rR0Yx9XABLxmX?=
 =?us-ascii?Q?vcmunZ8V6++lmSreWced/P0u6wO2a18+pjm0VV0/fk3K50lVDBbVVNotCD/L?=
 =?us-ascii?Q?3UbAG8wXQY854OEh8uC5ZYdUbkjMjtOJsq2Imdm9w6RMinAlW5p5IZUhl3BY?=
 =?us-ascii?Q?uHGYV7DAWdHT97icTimpFpC2TehgzAQeEGFIaRYcEe9qoSaqsbaTA2Ug8yzM?=
 =?us-ascii?Q?jQWQS8lwRF3twrirHcISsMaGanm/ilHjafKriBYFQsa11TvyJIijaKcJDDu4?=
 =?us-ascii?Q?qy8ChjA8xuvvl+vnacPlmwfMjnkxUCddJ4F5DsB+3CH/IjUkH9OFrc2/kZcT?=
 =?us-ascii?Q?Wz7SKL2w/E0s9JYbWqyZrrlhEkHjFNcKSD+wMwHpMUUkcVoSN7pizy3HgA84?=
 =?us-ascii?Q?3Dla5PMc6eBo2k+rlm3BjeTXTcAEtVUV12FjquZORSRcVbHgKIKlUxrg+uRt?=
 =?us-ascii?Q?5ziTjJ62l+q4qrGg0N1wpWHXyS3vTsXpm3KR/yKBG6dNJMxyEwfE9xSumGP0?=
 =?us-ascii?Q?CUEeAHyKD2XZtalIIF0LyhEsnOXSVGsqrubzQeOHnxvLD8XumM1bFtumxiqw?=
 =?us-ascii?Q?owBZS6lNV3u7fLsZpJodq4uZPFj47eSaihqoJb+lfUks5yDWLIok2wdlD6vO?=
 =?us-ascii?Q?eCmspcjshQ5IL7RY0qT1gFT0gOgzc7tK3Y7xR7NuKOHdjbI+HXrGWpdQCvNW?=
 =?us-ascii?Q?Z4Egh4EmCkHHNrk8c6yEZxqI6XV6FEbYLSazf4nkyghSQfCyMZi2gIyIzTKQ?=
 =?us-ascii?Q?NRPntIqyXw7zdC/Vk1cYFFkfFE1lJcvJo7gI0Unf9VDDgY709QvV6Npkfd0v?=
 =?us-ascii?Q?OMALcmmMDgVGcIR6bqkdAhnbWFF4DM7b7dKUk/iPa0yNGrJsvX9vCkwjdKdz?=
 =?us-ascii?Q?OMcY/Btn3Qn/ph30xawWuoyFSPafEe84rhj+WfLOBgFpuM7wZ7QJnA3YUBAH?=
 =?us-ascii?Q?GTGGsrZFVOW1AjkSz7hmoyTMxcjhLvoClVD5ZLUoMq8AvCBsaGOdRshZfQb+?=
 =?us-ascii?Q?PNsu99NztS3l/wmfTgyBNAzTzAtuLV83EVj/vLleBGsnz1ujOEul3M7ypEiR?=
 =?us-ascii?Q?c8EGd2Ex2RV9iyKpEGbhKGg2F/75qF01Buv14KHrEgOuKtAw0cPQ9EdkSrmJ?=
 =?us-ascii?Q?5m609OK9dredAT2+WJkhgYlpExeCz2QVTw8DfXwLCxjBHUxwqUq9aEKCxgPW?=
 =?us-ascii?Q?Vg2fL+k3IjI8TR9Fw21qP7dAvcWxSRUwebztG6mqmVP/83mjawRIlQsc0i+y?=
 =?us-ascii?Q?1Qd1kq7M31ioWq4dbaIo/hqGE0NB1q4ZGLoPjyA1xv9+EIaLiJCDnxAL7DvF?=
 =?us-ascii?Q?PBSFcoT5fyabBHFjkyqe0+TcZ/CgRNQ+j6a9xz4m8HG3Ii+PeV2+L0FQdPYj?=
 =?us-ascii?Q?gDsLuOSQQVOmsVLcovsK74WCY5njGTHzVOqgv9kfrsHUNIKRo+SeBjq0I7yu?=
 =?us-ascii?Q?4YJKplbtXtb/PcJ2egxZ5+hfKhwnw/gSuR9uwPJlCdxKEJZU8ZA08OzCaEH3?=
 =?us-ascii?Q?xHYOv1Q2uCs2EZ3oUAAXD/MKssloGU6m3buqno+06l5GTwrfmffvvUkOaSu9?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JyCR1TK754J5mUOdBq+3n7bMGk52TUjfPQfFbiVYXyaFVxAkoAC6NRClug3N?=
 =?us-ascii?Q?u3mpHnXytZgiQVC+DOKKpVGLoj+63Vtm0Z4JOH9noGpdAs/rWUBPRd55Ohsa?=
 =?us-ascii?Q?cCpr+IX1CKG3gf+KoCg6d8d9MfbRBlJ7LEs1/hfSf5m2OzY10X++a/zdzGY9?=
 =?us-ascii?Q?frd2/KhQ/jbF9DSg91pmxqtFIJatxgYNr4HVpvfjXjgsZW8mLZGH5o0Gteaj?=
 =?us-ascii?Q?BYOZcBYd8oJ8WJmp1D2CU2O7LX8Jzet5cHJ8a7tOachI17tnvCSzhT/J7DOp?=
 =?us-ascii?Q?sx5jeXL5hTZ6I2f/N+4F6No4c5Mnxf+tUKoMt8fSnAE1BcleG7ZJyzGgHJO8?=
 =?us-ascii?Q?wWd10jVayoH29E5cxto/DM5oZO/bVWe3YWL9x+CwU9sHzF60K+QvUYkJI3D6?=
 =?us-ascii?Q?ijU5xP2wx8rZMtsaDznV18gKKMclent27ct1urCZOQL2UpFKJqWO1A1a/wKD?=
 =?us-ascii?Q?Bbt46ToWgkZO/5O8EtuwhcO5ajx+zlAEaCa4DzisIk8RTTcmZeBioKlBB7cW?=
 =?us-ascii?Q?P4A2RVUpeR7h7JBWxpFI5H1gG8gQ9VUkUNrzQgFcFDyvkfBXQ5N9ScVm0hxf?=
 =?us-ascii?Q?+MehQUQDvOs0HVzk63dVUzrtqkFqEfuMcZveJFzNw6al7aJ0AuXOCDhFK/vF?=
 =?us-ascii?Q?0eOJEm2Z+1rOP4IlVJzeg94XDOg70G548BGbjy7hkegVym41u0Ed4jBfXxhx?=
 =?us-ascii?Q?wuCgLzjOyY0YDcKMHqFp28Y24Z3p/ygnZ2mDS1NVPWJSouJU7NvAlH4ZWxFw?=
 =?us-ascii?Q?HsS3Wb/CiUhculwZWO37m/ZYsXMfMg7P6Zc9ueReFsiI/Y/299m2ZyEFHBbu?=
 =?us-ascii?Q?JgO5nvC5HQtcRZQRo5APpiBpwF7qZq76BTRx2621DWDb2OC9OkRZB5kbQnzt?=
 =?us-ascii?Q?8svwvmTvXRaBCEAsE0iT9RofGCZpcq1FcT/XBi4NIWRyvuVJz7yuz/E4XAtP?=
 =?us-ascii?Q?nybhKfdBmecTL4hFgud12NGk1rrUW4ip0SzdTALu3KFzte/dxPSAsaPswg9q?=
 =?us-ascii?Q?QhQ0osBKB7DqPmGcpWTlAd3ysEZRtYWR4m5ADTvwiXiQZnb7YZwdCkm8Z2Oo?=
 =?us-ascii?Q?3slz5KQ4eyDj2rn0BuyfcRDFjxFKW92EeTV6dOb/TMuL/h+OlFvfifeqfRY9?=
 =?us-ascii?Q?I9/XtNhHIZ1hN0PDOMuzgvsxH9cNUJxj8EPUS90a2CZLAaoKmXj1Jvbl8YtV?=
 =?us-ascii?Q?T9Iz/d6tm2o6aVzIzxaH+1vwksOmLIBXQbVlPQt14kaTVKSb/INpsuR6QwjK?=
 =?us-ascii?Q?fW/MPIyEaYYpkvb6g0OScJnHZ52w7F03yl89ty/v8KcID28VxcsXbnYx90WY?=
 =?us-ascii?Q?2RwACeGVeeLfIk1acX/YscLmIO5SKr15Hl2XjSLdfrg9jA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ec44e6-ee9a-4a2d-c3e3-08dac81c1322
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:46:53.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVgXW2l1/WJmCROTe+gIlUDhOFto6yGWNXxKRP8D4cxvTXndJlufI5z2AJ8Qe+eF2FBHjyAW0SHnxOpNcPfEaxWFcCG9G58QtDOzerCSD5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160148
X-Proofpoint-GUID: gS0q9uj4B05ey9rxSbcdA_7-402_e7OK
X-Proofpoint-ORIG-GUID: gS0q9uj4B05ey9rxSbcdA_7-402_e7OK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the outcome of this patch set, the crash_prepare_elf64_headers()
is utilized on both the kexec_file_load() and kexec_load() paths. As
such, need to move this function out of kexec_file.c and into a
common location crash_core.c.

No functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c |  99 -------------------------------------------
 2 files changed, 100 insertions(+), 99 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a0eb4d5cf557..46c160d14045 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -314,6 +315,105 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..f98d1742872b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1217,102 +1217,3 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	mem->nr_ranges++;
 	return 0;
 }
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1

