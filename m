Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2929B6D6B2E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbjDDSFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbjDDSEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:04:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F9A5260
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:04:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334Dwlv6024571;
        Tue, 4 Apr 2023 18:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=nCyMxT1FPk4fpvYw2hgKvHa0l7uRIM5ADEud4LzLzPY=;
 b=0HNrUlryhGIp7GmhIVpJ/pstKg9WKH+wDfBleIXVTG3EeaWP68vvH4JJIo++7sbbHpnc
 38EN9o0P04prYb8u3OemAr5LWpPdGBXGTjOAyrxeOOkNhU3DJPOY9U9F3eyf+sgR4R/7
 knqDeMmlAJ+9n1hIpw9WN9evg/2MMwa8eTq8kqwIjrYNuXBmVKXYPJs+kLMxzSBm4R7V
 7CRC8GOPkzhs76dfhYFXw2Tmqtawi/oPm4IgQ3w1wBDFhlYDYyzzqR6rc+7+iBfPd42n
 BPFrdTs9QXf9QYoHA/zLMapZMkfs23DM1QJWp0Mp7i77FoxAoYA7FNBkf8Yo9XV7Szox 1A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbd3xj1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:04:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334GX8C8014402;
        Tue, 4 Apr 2023 18:04:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3g80dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:04:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/9aGjaGeFqvUn4BWhJVel2dxFVfj0WNl06Ljmmm54m9+oiye1+mgskuo1TyPCzrtz7yYnJxBThxdcRw/rN6L9ybdwbu7Ks/fKlCMpwrHMoMopHP4yakIYMIarH/kA3JyQuGTwnkDKIm/jMy17xXJzTpS6XV/1uOcZIS9NUtfdPrkR2gCLlpp6IwdxM4HwU2ePLTJiPXJBR0d8fERLBh6adCrjaUk+exSF8AyjA6vyYAyD1JkPW0VB+sPvC6ITKm5ZldvfquUbXWmojZN2WlFOFwJfkjxmU6f1PpsMd5AHVgr/YHDrkB1+SgkTYho1z8JvIoyh+wgOnB+MrpUz0BhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCyMxT1FPk4fpvYw2hgKvHa0l7uRIM5ADEud4LzLzPY=;
 b=GqAezjrXMdQu2Rd/Av0Jr7bplzmW295t7UoI/Nu5MGUhmWxK14qN8eJu6CH7dveoq71j6oPLxjRv3Dm4waFhO4Rl1k0Nle3684I6ko4129M6l8Q0Nt77ar2WElYOaWasOdyDeDYsFIN6EIJVAAqXYHwbmk8shVUipptKE1iFydqvPgE4SfUFAsdCw25uIL5L6WzidHJaJv52lnNddEXaWj4nGcg1qmlXAYVUKEKMmtnEn9zkwcOB2ADtpvnG9JYgonjD5qjrGEVtHRYZ+Xk9lZHQxvHBMqACmY13Z8wPvIcrahLwSejUNo2PaO57+TNgjvd+cq6UytPGG5lIEwYf3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCyMxT1FPk4fpvYw2hgKvHa0l7uRIM5ADEud4LzLzPY=;
 b=GTYeOPwQMoNOG/sT5eAi8g+e0d8VRL1GspXByk+sY5Ey66vOt0+f4vuFXn+FtxzTH/uoL7Z5xySkZt/t0iiOgQSHR42jpL4EsQprgqlM7H/OkuOTO2RoGk6enYbey8gAZdJqPP4AvBa1kTTY7ivlhxFASOTl+yLHkDUss9N9brU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN0PR10MB5909.namprd10.prod.outlook.com (2603:10b6:208:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 18:04:02 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3%9]) with mapi id 15.20.6254.028; Tue, 4 Apr 2023
 18:04:02 +0000
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
Subject: [PATCH v21 4/7] crash: memory and CPU hotplug sysfs attributes
Date:   Tue,  4 Apr 2023 14:03:23 -0400
Message-Id: <20230404180326.6890-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404180326.6890-1-eric.devolder@oracle.com>
References: <20230404180326.6890-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0533.eurprd06.prod.outlook.com
 (2603:10a6:20b:49d::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN0PR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf0f40b-8620-40c7-8f25-08db3536f888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBywU+S3DPbHRHGI8Y1o9SkZdQFA6k4DUytwdpuBs+LPj1LWV91Akbg77dUXastmL0Q7MA1ibLAtvCYlR9nxSb8W1MwyxOpca9LFrZtsjFzxsA2LhejjipKiUKqb3hFMegIdJKHBAtcC4K1e4gm2TgJa9h4+xnJ7ry3HnV80thuKI7Rdt36QHNA8OcJqFitC6qInwrk502bjHEZ4sYANWfI5ZPlHpJwTSF73BeSFapSHCyr7Poj6ZKu+loZFQPIWOT9aA1tNu7feTOjwK6O43vErDOGxHolH6VieDAN/ttpWFuRfJXWi9qFI/HsXNvA6/vYZ5RsWNdJDWfVcJwUwHE+tlmSUlPslR1oOHUT71zvAtITNwbKRJYVKXVmmky1vf4CsWOEXd7d1jgvyRfkn06RFP1HPb/0W925dWCIa/TrccgzGq+wnmvFtu3vug9M6GUR1/Fx2NiHz+1IpCaxfBvuVNpCrbi/Lk2ksY2KtTTscYY2wi/J3cEVYovIgu49iXstcMiNE+K6SmbWj0xZuCziNLYvWf3Qkob5vi+xW8YNBIvwGoSzwqno6Qc5Gc28q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(83380400001)(4326008)(8676002)(66946007)(316002)(66556008)(66476007)(86362001)(2906002)(41300700001)(478600001)(36756003)(38100700002)(2616005)(8936002)(6486002)(5660300002)(6512007)(7416002)(186003)(107886003)(6666004)(26005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zvXuhXkSJ6UD8sq6WVHKLWLGXp0rn0zLNlbLURrDdRrUV9dvR9s4DANsYpAe?=
 =?us-ascii?Q?SYZXe/AR7DDTW2dUm+Dh1oof82W+vrkzzIGmz5Kl1YOf3ahLWWDL/G7ztDjg?=
 =?us-ascii?Q?rNDCo7iVB8HIwBu/LO8QOGhxQHHXZgT/WeN2UzMOYzVzglxALSX4n5uzX2+k?=
 =?us-ascii?Q?k5fxE2e0BHAH3+9vmPoVaKfjjsC5XxMZTeOQxnDjtDyDr3CjllO8k6WqlVSU?=
 =?us-ascii?Q?/3WhBQgTvW2xKVPxZgQjGNrSRyKItEoHMEYAIuhSru/TGLzbzAbZEDwYrHpc?=
 =?us-ascii?Q?QQ7ez7LJ8lNVRqJ/XbiRihVmaYOxgSxHALE8Mdx6OfgsfLFV/qrGhgaQUHdH?=
 =?us-ascii?Q?Nkz5KMZwQB3RngGpBkKmbif6PTWDWLxaahP+3bJdVfD6Uceq48tC6YXL741A?=
 =?us-ascii?Q?/WphVKi+3Xi2G8yHC1tMAuoHdrCbXNU0GwNfQrqq6hORWmKI6S2vgXV7C+Xe?=
 =?us-ascii?Q?c1K1BkGEuT78lSHEjzJUzcaNYvZIWovRwWO2FiCrajf2J+/dtNDdUXl9pjFp?=
 =?us-ascii?Q?CnqZFI4MOozosgQjT1IurV2K1QFMfs6/0DVNEgNlAFHuvB5/A4NsRSs0+j+y?=
 =?us-ascii?Q?TANTgKN/XvSvHAAq4WBq3uAJhzuSLjBvbwIkoH74hAa55agYOki1vQp4AD7H?=
 =?us-ascii?Q?uq771+qSFWDMLbEVCTCOvh6UHpFXBQUf4QwF3o46K9/aW9cLO7l/EKf0ug2I?=
 =?us-ascii?Q?RbHbTZ9wFNU3EdEDQzc9n0HAr5m+Qxvm2ZiEWg8hBbd473qnneD7GC7+qkqa?=
 =?us-ascii?Q?dVatJaYFF3meQ7U13xnXQl5DjHjtMuXChRufI0YVZPgFKJzJaYfLQzwyGqVa?=
 =?us-ascii?Q?CO3boSvneuvVn+JqpaAenrlco+JmyP1MTF6zTcQRQ5y1+eWAuupJZdJsaGe+?=
 =?us-ascii?Q?nqHC8cqJxBRB6Y2c5+QMtkhadtY6RbyTfPwWt2NlVEbgkaLyEzmZR5smpqMl?=
 =?us-ascii?Q?J5YxQ2tP4hi8xLde1p/ScaFhdnEgj0Bi6dRHikT5aFVYmOwGK4IWSzz3HfVP?=
 =?us-ascii?Q?4g54eW10o3VuT0HKoZRWivDFKEmNSlJiKfG0phLPmHGW1wvNZ00JLXqOVKGo?=
 =?us-ascii?Q?EeqvUzBS43CLQpG64bjNO2UlthZoAE/NFueYJ2sjPYcFD8qnGtwWae/L5AdF?=
 =?us-ascii?Q?5ryKwgHXzLkAcY/AGdZSTzp2Wx7wslBik25UeOd9krjAuftJgdKbl4C3DVgh?=
 =?us-ascii?Q?RtC/4z4QM6YsnlVn15nl3/m6S3z1RQP0cHubfmUpqd/A8XzCpxCixC0rxIat?=
 =?us-ascii?Q?DQFVcLZu6qvHSyNVZOKGnAdTeGLZOp4apa50FfZgeuCYfps/WMqmxvcT93eh?=
 =?us-ascii?Q?xebswWE9wiRdI5/Sl2vChO9o5Nf2GQ1NBXVJoyRa2HEvhdZuFJFW5hw1roi9?=
 =?us-ascii?Q?vaGq3fgjoU7jC6/a2+IIm6vQ06SdsX9gBVi4N5c5CXG06tO13cVxb8K38Nna?=
 =?us-ascii?Q?RN0yiecSqpPoYTni1wY90oHTLv8lrLQvp1VXjz9SgXVXJqQ3EHeBc0nwqMS1?=
 =?us-ascii?Q?hJHIA5LxpP2uciYxJgI33+k2QQXk89LsRLpoE6oXPQA52omRG3cXvRDApll2?=
 =?us-ascii?Q?QIH7Rvk2I/nn+NGfrrtvzYZ6s108+KU83JS+AOwtrwmxFsrr/VVjPxPeJM75?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MT/1yPsnkpPQqpVCw+KDrqaMLTJ4ZXCaLMvs6nk8uDV5lnmwau2Mv6RTXISJ?=
 =?us-ascii?Q?nSzblmaVXKfr0qG4i7qqAAUUgu2NTPj930XxqUDmtFIwsxhDKHlniKfiTt47?=
 =?us-ascii?Q?9nnvNOI3ldwGlhja4f7FZI7CVwwRru38I4c6R70PEXMIsB7xL7PhZ4NImJ+/?=
 =?us-ascii?Q?ES284k6hkjx5GqEYvy+d2bYB2CfAip7P3PHW0uVbsA7HpjweXF9KFpwNT/Q2?=
 =?us-ascii?Q?H2DjtOvc6n4NWlF1tXPA/q3np0i7XUsyUf8DoQYlLs6QItH6OKlAoQBwFiJx?=
 =?us-ascii?Q?47UEqCHcHveOmUNucc/gP9VBqtVbeO3fwl3+ResArqHyEj8hs/cb050yDhfF?=
 =?us-ascii?Q?uY2zsR0FyMqqKUp36Sku74jAqOgmy9CUVS5Ld+AQMqrR29NuFihuBiVOnClu?=
 =?us-ascii?Q?zEPjwm0KXvEewpIgnJYbmRvj0iabp6WJH4JXnwMgc/UKs7QtngR2U2PrqaL7?=
 =?us-ascii?Q?au9yoE3okv6hlbt+iGRPVIHqAjkwfqsaeQ32bXoMZguLpRUQ+2Q3Kws9p4jw?=
 =?us-ascii?Q?z3vuduCVneC5mj4JRZyG5ngzzGm4CgL99bxYRGqkmgWsYw8Vw+Gw0WuFYEYq?=
 =?us-ascii?Q?wzoySCHicMgjrhlbvvEPXfdKIlqHOxnlmry1q0DkleLYb0LlsdkMeylAGe1P?=
 =?us-ascii?Q?QgnZ5ka4bqeXoJ5zMFevy6VsV4MZelSd24tqQbIOB9HnOa8USVuN2FmRq5Q3?=
 =?us-ascii?Q?utinnSUZrPQCfcy1nUUPr2kjWkGoFCAQ3t8/2TTBoTzef5+PSAsVMjoB4Q4b?=
 =?us-ascii?Q?bEpRE61rHWrvsop7zCz9+3neSvJQVUuI4kUZVygL4P+Tp14JNxQ3I1DORtCX?=
 =?us-ascii?Q?v4gzHF2pHexmgKapPga9KalUFXdYpFeYCfJGmDl2QlUoc+segrRdPgA+XQLU?=
 =?us-ascii?Q?68aG0GaYhWniytHMRq+u15aipf0CE/WifOuNSTqMhpYM7jzv+y39IsuVb6tM?=
 =?us-ascii?Q?j57ikca2iTBn5yDkhMSg3NAEUTa9He58qXwFJ3BAYwPCJxhh7Pirr1aIykY0?=
 =?us-ascii?Q?qII+GlbcTnL3abIPcbThYWGIxIdBJLbzUtFvxnOtcscZR7CjXv42mDxxpoyp?=
 =?us-ascii?Q?pbgg6o0gr3v4FhfuC6EmKBpDbSYl7pM4skX8XFtYclP3bb9XwkTdsbrcLpOK?=
 =?us-ascii?Q?ordRtD17sTKLtTYMSvsrtOuw/ju9iZX1MFH4DQSx5nBKD7nXwjwDhDU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf0f40b-8620-40c7-8f25-08db3536f888
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:04:02.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nh95hR/P23d/HmObG86bM/UDXK0+Vd6DzwxPMJYnBTfLKRnjZbUibFwKEEt/0ZwfS452M6WftbO7EweAGgxXLz/pz7gH1BA/H9E90tAIiHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_09,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304040165
X-Proofpoint-ORIG-GUID: PFprifAp60VhlwadrRtgCm1LS54WV-MX
X-Proofpoint-GUID: PFprifAp60VhlwadrRtgCm1LS54WV-MX
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
instruct the udev rule to skip crash kernel reloading for kernels
configured with crash hotplug support.

For example, the following is the proposed udev rule change for RHEL
system 98-kexec.rules (as the first lines of the rule file):

 # The kernel updates the crash elfcorehdr for CPU and memory changes
 SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
 SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

When examined in the context of 98-kexec.rules, the above change
tests if crash_hotplug is set, and if so, it skips the userspace
initiated unload-then-reload of the crash kernel.

CPU and memory checks are separated in accordance with
CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
If an architecture supports, for example, memory hotplug but not
CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
attribute file will NOT be present. Thus the udev rule will skip
userspace processing of memory hot un/plug events, but the udev
rule will evaluate false for CPU events, thus allowing userspace to
process CPU hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 14 ++++++++++++++
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  8 ++++++++
 5 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 1b02fe5807cc..eb99d79223a3 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -291,6 +291,14 @@ The following files are currently defined:
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
index 182c6122f815..f779894c6abe 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -282,6 +282,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
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
index b456ac213610..24b8ef4c830c 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -490,6 +490,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
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
@@ -889,6 +899,9 @@ static struct attribute *memory_root_attrs[] = {
 
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+#ifdef CONFIG_MEMORY_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f9bd46fcbd5d..0ac41f48de0b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -509,6 +509,14 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
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

