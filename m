Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A82D65EFCB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjAEPSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjAEPRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:17:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517FA59304
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:17:52 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E4B2k021275;
        Thu, 5 Jan 2023 15:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=hoB+ZXNuIZGger6owOm6C5AtLZTyPSJ9zZfxQpAPnIk=;
 b=Lzil0qmPB8E88wgsmvk/AtzPjY/ieP2TlMFSYyoYVAMebp/hrD3XQ/+JJwCfUKWxYkN4
 5Qc/ayBjlF6X7ZS+yRVXOtnCsnkVXQGkT4CpnyG7bMFlxs8T9LT7RUeKAIs36C4V+RET
 imc28xpVRzNL9EH3qXeSojeDB492E8WCMG8tCehl5HUpYkTAhHU3w81n1tfFdXKYluBD
 PjT7f89tQfV4QAuLoN1353qVBngI6kSjmeFmzbbnqcG/Dne/AQJtysBZsxA4CEGU4YKO
 S05MWEjnOxm1QbcdI5DwQWz9Ei6T2croiJgsPI1XpIk/2t5PHYBwkC2Yej6YO22Upu1D tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya901u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:17:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305EPKPM040220;
        Thu, 5 Jan 2023 15:17:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwevjmsqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:17:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcaakJ6OB9QP1suBHy6re9W86e9a/v2/2PNo43kD4F14zQKNkSiljPqvwU1kvla0zyUN/OaYy6JnBX1zkzDMtXDFPkWt52fO1MJbm8i2l6frbPw+YSXPXvSQq97XjyXNnIco4lYoONkjaM9w9fsNH6xA18RGavxP/GxoW+GISMnkWvyM6YKVdAJ8BoZ9sjF7kHFNb+M6L1AZa0/wHCHvXe4JgjcI5in7QujLgJJMVfxpaZNOjcRnPgmx/3TW08c1XR4sI6vnn2XyzrKExfrKHFaf8gtpwTH5hGGTdK1EQUuxpezhph/1fSsHirikO0HCQNQoqOVNYYFgS39rNGTf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoB+ZXNuIZGger6owOm6C5AtLZTyPSJ9zZfxQpAPnIk=;
 b=aCB5XYChaeki9vrAn6CO2iWkj8bYMgXDrXNVD2K3OUbGta9Dtp7y4/sNDXCPPzjBQ+Gkl/JLVMstpqkjdfx9S+AexOQvZPRHNp5tNAN9xVpNtS/s4FwiWGsooWaLSJn8515fsY8O7AA/EJ+Xx4qoLizqVrVW0nZAo1Lr/w2T+TUkCL/k/wqzLQuNj7QJU12DCT1Mhy79oVk4dYCX9Bqmg3HkCtq1GljKSd+0XxQ1WhYCWDbmTZ18CJ7ri/r4Da4OnclyChUqytQUbdrmnqgoRBWSICZpdF84JTub67B/VaZPPzlHmoYgUCOEBTOaQPihW57KKMXAyRgKVMMoOa9Q0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoB+ZXNuIZGger6owOm6C5AtLZTyPSJ9zZfxQpAPnIk=;
 b=Ez6oBTV8VHbJ+nh2QOW9VuznAFvKr3xqCydGEXRSy0mMmnOBEbxVIDLR+xYYsFuX1/AcFm8Z2jBFMF21XmkUh4pVbsP3B70Km3fMXxbD9aN4OEGhk3NNUMad6bK3lZX8oppSwRB0f22P08xVuMP/Wwim2CxzIA7oh125gjSWpDI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB7406.namprd10.prod.outlook.com (2603:10b6:8:158::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:17:30 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:17:30 +0000
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
Subject: [PATCH v16 4/7] kexec: exclude elfcorehdr from the segment digest
Date:   Thu,  5 Jan 2023 10:17:06 -0500
Message-Id: <20230105151709.1845-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230105151709.1845-1-eric.devolder@oracle.com>
References: <20230105151709.1845-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::20) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: 412bb6ba-d2c9-43c3-c3ca-08daef2ff60f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5oGXQ3xqK2LQmW8kf+KKEwoifvZ6DM9INWK01lQf5yqnSY81WWrPTYCNL9g3XP8DJHjiFbkqCNbfe4/rxJfyjp+JPwdbzI71UUA+hJqo0BzX92lK+Rt/dwc7YslAcV0rjOfCq0YeIGCimDuq/0qoDx5d243Jd8Sg+YFrG5/KfQ1eUT0Rf6eEOqr2J5IQHlsXQ+JFSLcnja0grRbol/slEgmT6HNP1nYtXhabwHD1Q0y7oZNsNLVBA8Fm1HWBU4VtU2LZ+In+94PfW6xAoZQQG53VeKqDgVVXdSm8kdnFIGkhI0hDJGgJfnQJvItFRbtcsx1FU516AfUWJX2+pU/WOMerertH18uwzq4KecJdBXZPwd4NVcKhbYb33Fgi+TnxArpguIrtQ9RxTwrllcsTkj+8ygMBYPAIn7Tv773ozkriZMqU6M3xLM9Wjutnsxr43f9vS/1CMenke0ZinGkPHzlz/aEInCg2Bno61tGsP4I25yOJ/dmAcnNYKY42hEpb0pELID6Q+p8Let4aYuEMf3tm5S8/lBKNpzzRY9Q7wp+7Q1A7VpDAPNFR27h3rqh9sNDwu0JR8wN7QEy2S1xiMmZKl0oXT/RDXiZxSAOODbsuQt5JUDNm79AIhge86yEf0/qp2ecyMxniitJRnXOvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(4326008)(8676002)(107886003)(5660300002)(66476007)(66556008)(6666004)(66946007)(8936002)(41300700001)(316002)(7416002)(6486002)(2906002)(478600001)(6506007)(38100700002)(26005)(186003)(2616005)(1076003)(6512007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ZM7fDmRRsW1LeI06CVOItgcDumqAljId/Fi7oZwN+em/SVIZxENjZFIu5EE?=
 =?us-ascii?Q?tHy1nrT/NV1z3ewgtrmFa+RZ02kp3jPStrAOK6oSTPnCvJwwOqnQwtWBVmVp?=
 =?us-ascii?Q?P4U2gXaxM1SciHTBwNEJDAsTgBoiIBJ7m+b89sVFnFOWpDlu/iKdMrPaE9n0?=
 =?us-ascii?Q?6lXlxvKHg/nBvMpV6M+5xtYxfVk3pYunDjQi4dZT9kAiqxdxxjWSsDm5HY/a?=
 =?us-ascii?Q?Vuq5VTPInwmutnie/eZ4vxf1+p1LNdzY3DJGsAjrthy0PvHK9wOyNBqQHJK7?=
 =?us-ascii?Q?lDoEf7QlJfLly1li2VMxFuombLpyGMh8out+59PTT18tvtauYCDQDW+susKi?=
 =?us-ascii?Q?rSULex4a1ULtGh1a8TCpwOjKmHWP1r6jeUCW1diEdq8RBCunRH2knDCqPnRZ?=
 =?us-ascii?Q?uMaX8Xs7rXqWEmO4wxOeMif9PzV+KTd9uwKYfWozeqwrwxmOVsppyvU36bgP?=
 =?us-ascii?Q?/flJWYe6lx0LJvsh1sU4n0KiXJwn9aaQSykbIAEN9a+yNRtFW0CnsDKSHOzo?=
 =?us-ascii?Q?zhbe/RjnvfBn3Y6ESXMSIsDeHuQTbWUDPBCG6uQXjIZ2/i0909bpk/Mf29Sr?=
 =?us-ascii?Q?wbvMjoLB4eY1r273UfOzLBD8rXj1SRyF8VNLGAe2G1bBB4clj9Qv0ElbEWWF?=
 =?us-ascii?Q?5qI8OblOSinLz30vvG5p1b2jXtjPo9oLXm/RgFbjO/dFMUNIpOioqtRPO/rs?=
 =?us-ascii?Q?Uay0GLqluuY19CicQLoEs52vdQjMQPkX2zwaIlFz1cd+CHQdOix5NH688Z4V?=
 =?us-ascii?Q?H7wS8EAwHJGa5gK2mnV/9r6hkCH8bbPsMe4+RH73qBnVb3F5p2+tgKA1ZBZK?=
 =?us-ascii?Q?Ui6YXS8R2cT0aE6bCJlphKjM7olV1MQnCY6PdboAvZ2sJMuE4ZsowNG5lC+C?=
 =?us-ascii?Q?CGVRDcYYDuIZCU2hje2OE48flv/K3q6z6AUfC8HQuVH/Wi+O8J7DQLylwRXZ?=
 =?us-ascii?Q?YEWvy44q1BrYk8MtnieBnMYqwB3FN2A42H1f9QTGgpY8pLaExr+XdtwVPEjh?=
 =?us-ascii?Q?VrDyF/NV2YS8s2r2K0230vQKKQ47RvVOlozywlGVP/lAQ/AyQPAqLm+5oRmU?=
 =?us-ascii?Q?GASvVlfD6osXAQa2pGd91Y+5PkmeUseeOveSUVIPCGGDJWDVbrlukAr+1B3U?=
 =?us-ascii?Q?NSvcjr+BHnlfEIi89FOSHydxC+W5u33k1UkYubfGs1u0Bl5C5OEP05avByTR?=
 =?us-ascii?Q?qE/SV419/fAzTyRBQORVyvvqRPShhfqSC7SH7e5Z3ENGppUA6mvtmTqCbiTp?=
 =?us-ascii?Q?TPHHqac0eayAcaNH8Ohl5ztcAjZ8I3MBkIVCmNm39ASPIVBGa7iHvHBn7LXC?=
 =?us-ascii?Q?jw8qkMJ14xQgD8pJ6OJj0MB4HWzaVdH7ziBPS99cV9N3tV6ToFptElM2Kg6H?=
 =?us-ascii?Q?l80LUuNVvMb7ho+vncIszb2ssHRLYDgSYvwws1llXj8O8WIoCTT7aZq5V/eX?=
 =?us-ascii?Q?3jGQd9jS2J6l5enidYuRcm+pElxl/cFFXQ1M7NxuKJW0FhL5ai4Ql2asmJi7?=
 =?us-ascii?Q?M9Bib95+4YtXhLIkKvNhTUM2dtHjnZf8Zx0hTmtsxfGdTfqCO0b29HJjaPOI?=
 =?us-ascii?Q?homexZQIrmHAhc/7rwbIazlSXuOfK1XiK8MUnVk1NY/BlOQEXaSqoGi9tQn1?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?T1DTavDUGWJiR2gMdYSQPWdz9n89uf1WKku2wExIEE2cM8n2JfPP6IdAjvr3?=
 =?us-ascii?Q?C3Mja3z4I4xJBI1Szqo4uRYTiSZVrwUeQsK3qPs34LnfOmrU9uarOT9iNmcd?=
 =?us-ascii?Q?IwErskf4dUTJp9cEj6HEotnbKpAze4E8XtThQ8Y/9+9m9QaeU5d629mJQUgO?=
 =?us-ascii?Q?ATc6U6RmV1t9lB9JGWNMEsUTasYhsGdFSD6KxYVv7Q9Bsru1saXFvl/jid1K?=
 =?us-ascii?Q?XHv7M2ea1IYunKjE5m6Ulc7bTLc2yYOEq86Adf9Uo9Pum16nvo/rQH4WQE0V?=
 =?us-ascii?Q?9gQjI5RLA5lpEKqQjn3/WgdCxBEWMdPvEoBjEkWw9hsZHbN+7JJxyy76ScK/?=
 =?us-ascii?Q?fq3YNAFC4r2FCO7icfhAwnbNb2h6+qGrlkjWGBv4j55NvLNgEFZn/jdOXP0U?=
 =?us-ascii?Q?5ey/TqBvh7Sl2SSGDMm2o28BgIxa9jPW0AkPENHXgzWhRyAVgdWGMIElTNkk?=
 =?us-ascii?Q?40X4YU2o+ndN66aUoj9gFlAXrkolEdmDlh29aua30rPIUo7THlqTkGq2MyBo?=
 =?us-ascii?Q?YpjW2mtDMSELBSmge+xOhPcxVLvMcGUuZ3dk4BkJuzf7JDi7YUQ84imqR1Ey?=
 =?us-ascii?Q?whXANsYhLRPsnSMXyLgOu6sw4uzzB7E/QWzBpAtG2v5QNDorWwuQWJrt2DUp?=
 =?us-ascii?Q?kWB2rhRAck3iWpkUL3FZXLwtHTSrBHs59Vjmz0H+/d3R6E7PXmC+UFbYi2/s?=
 =?us-ascii?Q?H8CT0olQZkCpAXPbCvsIuu+8uzrfulfzjSmQaJwv5JuQxcjMOJ6iCARssZom?=
 =?us-ascii?Q?9AJsJHQ+VP5yPo3YEK1MhK31MOMc9Zsax0L0LkxcQoga2yKdCDqUSZ33TJqh?=
 =?us-ascii?Q?0EIzdiTzYQo5n0wbl5Sl8RaX+yKf0LZUeCSqPXU8Q/HeXQqDMiYsDWaaFn+y?=
 =?us-ascii?Q?lP0mKK7Ya/wnVckUWZWOfrEEA1JXrDRg6JRu8k/JEKpWGU8nkaAr0JTlhKn3?=
 =?us-ascii?Q?on5mNSPMRgOpHuBEx99dy++3lDhpGAgKvlvED+qeHVLfG40tPI1YZa0FkBfz?=
 =?us-ascii?Q?myMHUnWSJPWyf/JrYigP5wUb7CvP+29nHERkVBkSFYre/qUsebLTQoWOG6eV?=
 =?us-ascii?Q?m4bY9c6qtYBOS9+q4tSnskGm/GNKDefXdiH5Qdf418qLfWLAp2DHrCl+aKzS?=
 =?us-ascii?Q?Ipsd4dkP1SniBRrB2KUr0/2BnV3yhgyb5cl0wJpjPVgWvo3xcm3vmm1AcYu5?=
 =?us-ascii?Q?PtzKpVN+cLa83DaZ+zYDq9dWwEUR/lkAd55ogPEF1sR/IPbuQ5M+ewr6c5SZ?=
 =?us-ascii?Q?wqGQEur0Ct2MtRmyo/AsX/ED/gQntqcg0kcyJSlufixNZJMrdqTP3kPULc9v?=
 =?us-ascii?Q?qXCXZ+Zj6pVEJeN9Y2dc3XJIRKqCf7PKirIPTG1B/QNcHw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412bb6ba-d2c9-43c3-c3ca-08daef2ff60f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:17:29.8950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MgOxTW/ednTZ+4uVHchnDavhEviJXCnkicvy5yzN+Xurzn0yW9uvHSgaVlcu5tw5zLxECeassl+0LgPCi2B1CsKWg3QtcOWUf/gcXq8ATw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_06,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050119
X-Proofpoint-ORIG-GUID: eDMx-5plBCV27ZrjFpbU5lTvvf-ATTT9
X-Proofpoint-GUID: eDMx-5plBCV27ZrjFpbU5lTvvf-ATTT9
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
index 270acae2801e..6e13b3a71fa6 100644
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

