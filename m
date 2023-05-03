Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD86F616A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjECWnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjECWnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:43:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443308A68
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:42:53 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HouHj016633;
        Wed, 3 May 2023 22:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=xX7GqRjv0l8rGlzfC1g8FDMs0/47L6KjM6D/7AV654E=;
 b=JjGjdSw1iphk4Fh1geXACXaKZZQeu/37EuzqmY6z0AD8Eumj+tIscJpRk2AlDgBogUK4
 W+OeUNwglUDsmUs1+dcBl1xS8uZ3ipbspVuUW2ChQyzBtCKyUvu4Yeyr+e+kU9koHkk1
 CjkK32zZM4twZh9prL6hE3DcYrIrxuJVy3+H3B2GlDLyU61bM/1v4dpa5d1/LY+NQ9PX
 E0xaTrxSl7t67TaewJg5vmI3++T81O1g8W9u+r2pQvKh9Ah+5XzgBHagAkTHFjLOhEMo
 6dKeWYbAnhqJKR95i21R5yZmCo8ykfoup1VOj/17lLczvLdq5nbDmln/k7GF2lg3T5FW 4g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5frj7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:41:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343LBtBX010262;
        Wed, 3 May 2023 22:41:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp87sg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMb6iCy7CYYcGkQluTDNgzr53Mt3N/u8yg7WUVRbXhOiB/xP3Ckz0qI66glCKZIJwWpD2fnhk6Upsfl4e3HVjNUI/cGNWJLgvXFcsxmmDrycakiinv08BcIa5PFM3wOO0eszqL1eN9ANYMNAY5xaP8qXVeiVSQtLkRPTMuke5FDCuIaYsi9/W6PNikhOrBdz0VHY8tLxf8z0XwQj0IBeUvv4Mqmga0WvgPEbWlsHkOODhXcR69xo/Rd25zun0dR7IRdcAmOmHgpC+v9sj8R1fD0KU8W/EkGuIvdmVKcybaJwdl5zO7vjOJFqiYhGTkwFd+F4/HEXiYcLG47UhO2EKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xX7GqRjv0l8rGlzfC1g8FDMs0/47L6KjM6D/7AV654E=;
 b=GDg/GnVwa42janl3ARoH3LLlXdqFQFQ38a5WoaFR8hKzh6vKRm/E9D6J3VpqX2fs21Ng6qmz/tP5KyoVPy78awEq5/Y/JDtHyhTuSw5m/PqPT+xUsWSKriBucJE6Lj66X0f2QL6+487tpwdvLqpbNgrWkGpnskJx139m9VfVfjg/Achz9sMpYe2o1Nfbe+eODWdTdCzhdw5QfG89k3tZBgtRzikkMZznYZzOFMsb02ewCj58MT5nguMoqtdPAdUyaFtxdThcL0yhUmu7ExmOQGsRXkuWFmyemBy/9XQha+LmV2DNoPRdyScs0xstNdM/U7H8/8gi2b74NCnM2u1Rmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX7GqRjv0l8rGlzfC1g8FDMs0/47L6KjM6D/7AV654E=;
 b=BPI/w1Xswahd57VDAMtSeRsH1Eq1uQLX6BeLU+rwIdvJvbwcG+EWLWWefcfW9H5BIj0H2jBN+PNK2Dlfo+vZ7zEkZsKYO5Ct/5B+3LlVRER2lKyESnqB2QDDlnmyI3HzHFyt5j4GcGhGpyhlGQKBgzS5M6NyNTk1Bs0n83E2lE0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA0PR10MB6890.namprd10.prod.outlook.com (2603:10b6:208:432::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 22:41:54 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:41:54 +0000
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
Subject: [PATCH v22 1/8] crash: move a few code bits to setup support of crash hotplug
Date:   Wed,  3 May 2023 18:41:38 -0400
Message-Id: <20230503224145.7405-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503224145.7405-1-eric.devolder@oracle.com>
References: <20230503224145.7405-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:806:23::26) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA0PR10MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: da01ac87-5e95-4236-f022-08db4c2797f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FBYnCcpqX7fSFLRkkliwlExAizIr7bffom9K978+aQeO22iBVZ9cYXwBkHATAdjRxdMjHozgS0aISWvzB6M8EpgS3hwyfZlfOAh5yrxDVgZShidQogGktjSquHu4zPtynPcjx+976FZApzPrq40o6SL9ldiyoBd10fBSuE8uyFFCaONkHaTeW5aF8YQvbytTk9vdnMfFfdcNMmN93nsEtvSUBSp2ety2K8t+guwYUvcKwWClP26+Hp1U+JfLv83c28H+WLPGpfxG1AsGNevd4p0LwDbzkw4pLL2j2+SMnKPRfojtKibzG1CvDoC3846KEC2uB4WUNnW7qYgH9ZOyYFf52z/Z0mnrWhJ2vo+vi+2DM1KU66pD+C2Ge5GZFlwyBbo5dHDCmcNOMClxCvO2FzyHQUqWZUASOwWoRDTDXPxRMSak2ry+cdVFoZrkwRqoMmVQmUjDDo2nL6lnu2//BsdowDKHNA8pD7rhUlX81uCct/pJfyQrG3ut0qVz/4qu/nwuGdHq3jXmEZKI4xfmpmTd5NuOS1x2RFTZ9WjbIt5nJMeFzRsDTUVOO7HJMuF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(30864003)(2906002)(107886003)(38100700002)(83380400001)(2616005)(6512007)(26005)(1076003)(6506007)(186003)(36756003)(8676002)(8936002)(66476007)(5660300002)(7416002)(316002)(478600001)(4326008)(6666004)(6486002)(86362001)(41300700001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9akAKBlu9wmDCYaN1zW0uCafF8fl7ReGmC5MVOaJ3FhSxhGiZylsGSeVXyQu?=
 =?us-ascii?Q?c+pZC5b+M9OzxVWmulgFvWj6jEmoBu6Hb9x0ILoKqDHvWd/h2Eh9t9MIMHjN?=
 =?us-ascii?Q?vzUUv6wvU8VoA9q5Cz4FyWtD4ASTpUxdY5K7+O66n5yl16p0BIKFqdJo6y/g?=
 =?us-ascii?Q?aOJ1BhPtHMkNdCeNedwthboCLR+figmyoFwifPa8WIdUPN70/nFoEGC2ldx3?=
 =?us-ascii?Q?HOuiZCxB20Q9EN1EMnF3QoaPiAiq6sh47i5kgYz7670+BdRFIcbU3Mr1kV82?=
 =?us-ascii?Q?d3jT6oqaPFxlFJMX5AOGmhrD88fot7lJ9LVoofdjyTUSRHCgOYYBbPqwLDkW?=
 =?us-ascii?Q?40pnfFSn9j+fQaLu5lpMVcYSfd+GPBFiBbyjnKQVQltZdz7jyhAXpAzzUX2i?=
 =?us-ascii?Q?xElaQ9nhGL9M5xQxJyFG1JF110r5XJ5kG1EdjGZqviWSYs+a8b186uv0OGJ+?=
 =?us-ascii?Q?bMieaGWmU0baDhH8JRtDsSxsNglxJmZOD76m2ZWMF47bSQAXWccn3xPQWOOp?=
 =?us-ascii?Q?Dum+im4N6SKsgmsr9SKFNZXPWOpAr/1RqaiDLoN7HFj1W+gXQ6sDmAkMi4+3?=
 =?us-ascii?Q?LSnY/xnMHgqoBrnGpuLwzzEe9KfRCSS/71gcwfYojL+3zKpFm45rVSenv+af?=
 =?us-ascii?Q?P0r/K4fUxOXT99aGnSOK8LWYbbxW3NmWn1df+Xpwoed4d9tyX1ruMa/kf6a4?=
 =?us-ascii?Q?E032hMkQ0cVtboGLYsjdIooZEH2v7Ctcc0fLs9TeSVJJx9xKLDW7BJjTXyPZ?=
 =?us-ascii?Q?mqQeqfjhCnL0cwAgCjIuBQgeaFjIbGREDyjmrEhLI6AqZ5Hnj8ZqTpy8tLq7?=
 =?us-ascii?Q?3n0rfXab1naSv60Z3T4GF8NfKIjRoUphxLDSLi/ttQyHjfrmxcogC7O8jKQ8?=
 =?us-ascii?Q?FB0laqJFj+m+hJUjxU4BCwje+e6YzFyT+yVYRll9M0JCxKDszbZKEJkbMwwF?=
 =?us-ascii?Q?s/VzAG6P1w6OsSFmuIAg5/+Cr+qIM0wHHox0kJqURRD8e7msNzSrxNp0zZ8v?=
 =?us-ascii?Q?AEcy2j25WYWKEgiG57LXQTgDxv0oSAaWPhdCq2WAs3v/cM6Ud9C4hdb1rO1J?=
 =?us-ascii?Q?b1Gb7GAMe1SoHn2OPlJoUckzrf2dfi38DSE/sFMfQSti2qrrQ9qi1ydy4uEE?=
 =?us-ascii?Q?PmIRA+8N9UsOwjuKx9BjIayZrRSaFLAh1zN9jdXpo5hRbtPvM4OiqSd3Nuec?=
 =?us-ascii?Q?wk7d7hb0fUOer1DNybRJCKlxwZGb1EmDL2CRMB5xtykljgyIav/93tLNsnje?=
 =?us-ascii?Q?KfH7ko2dA8Efz3VOaGVQrnzDgJXh5N2v6w/KgRczhLdTzog4fP49mGcr/Wjx?=
 =?us-ascii?Q?/Mo9EjmGgbNCllnvi55mW16UsyA/slmA2muQsDu+3SamIMZqRxlpHyxi4j0p?=
 =?us-ascii?Q?2R0v6mXlMlB8z5jqblqsI+m9+jzVUHeJNYXRIUcQ3FQ2oAiUce7RDTPsfybB?=
 =?us-ascii?Q?+XdOb7bumo/ZhulKU4Ye+hmgX0q7RI2i40WpiLB57X06ydgG9Uu87C0zT1pL?=
 =?us-ascii?Q?zQKpQJwtMoL3G9sGogf4t+be9TV+bqi0LkHFU/VTtb1ToiHy7oEMQ1Vwze8Z?=
 =?us-ascii?Q?cdPYYlkb1MCrH2sqeo1BGFa8JC6S0ih0PSXNbEMxQkknVEgLErIzyoDNsGRF?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?i/OfWYbUwOD4EScsk4JpxeyWUPmxRzPnfrxECvdM2zkxSz4M3hfSNTDrLDEG?=
 =?us-ascii?Q?OL4KEM/5v5+iuTL5XIERKbkTsviDdxbkmNfr3JLcfizGGpnigcEUUqwkYYWq?=
 =?us-ascii?Q?nhh8HZDe6ZHy8FLqv85NvNVXW6RNPwfcyrlY+218aQHX5Nzg3Laaa6kQPTu8?=
 =?us-ascii?Q?DY3WdqgzHgWBMTQhczuux/u9hZKauS90XIkrLjXQDyI/FA2oEXwIGfRQz1Y5?=
 =?us-ascii?Q?P8HBt/H3J1i7VetvLFBJbRFGCNKx1pcPLma9grmgDnF8wVgVPBUar4zjZ0Vp?=
 =?us-ascii?Q?VI20/BFtBNnC0BWlGPOwqcDfgkuwScgBupV2e6CBKTdIDHAAsMM8vbqzgX5G?=
 =?us-ascii?Q?PknB+wY5JTN7ItNmSVdsxfdNfs43QARg3I6RGpYKGF6smSF8qK65NOEOIJCj?=
 =?us-ascii?Q?NoLx9Zz/2JFz3VDJGdkfWpY9zgKc25gGa30MctTwob6JdQq1JC6mCTYAPFoP?=
 =?us-ascii?Q?INe2Oh90SYMEsUUON1yBylBNm89GUyst8TA8lwB0suOl98u8mchbmQWk05TD?=
 =?us-ascii?Q?O5RV57GZtuzm8dYkktwc2WG7zwOKDwj53gtzlxAcpSMJl1oKa8Rp/oyu3mwc?=
 =?us-ascii?Q?P15ovgdcbw8vjeNPYvS4RBXQaI4FyZWG8rgPrkRq+7ORDTB3/zfFzQAXsFpH?=
 =?us-ascii?Q?H7YqTuRI+fpjsKWkRkWi/ckCxU4nygZZN5i9lDKHjpqn8ReHvAOHbvGwe8MP?=
 =?us-ascii?Q?Gc96HF6a3K2xm6n1+toXUYVKjX2auo1vbZedb1QmeIFBQNuY6kgVk/9COJxC?=
 =?us-ascii?Q?uRB/kdm9oCEdtrHiK0NuGPfI7hRjTvPWE2BvcgIfBTgwThTf8avfaqOpuUlR?=
 =?us-ascii?Q?24mruj6jcW0qF4uHZ2ffryvJuTDJSBy9omb7yuY20Q3gFHlZDr5g8nNzzafp?=
 =?us-ascii?Q?nk9iPW2YacqmdTTnpa85cG70BHuFkCjAehvfEO2cN2wclpNc4+34ww3K4T/4?=
 =?us-ascii?Q?+dOWw+mFN8odYv3DzYtM823WPLjdRDrxt15cUlqbDd28bxhFGDiGmJEqNf0B?=
 =?us-ascii?Q?39nj8JgMRsN9mqdkGhFBYvKFcAuGgswBdRJTxvlNMsGAUnqysp5vVZaQiQa7?=
 =?us-ascii?Q?682NuqXAUZjcj9/hey477beDnyVEzOWfPEu7VNy0fPx1mJz2vj/u+9d7glHI?=
 =?us-ascii?Q?J8RVB4l9Jj1CyafZPmu0C4UlTKO0EMYZIV3MAQ3RfO8eLox4dMiC1KQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da01ac87-5e95-4236-f022-08db4c2797f1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:41:54.1902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMwgYXgccLQjXz5LnaAPfQ1ryMhOgtC4oBZp0dnMRcYAMrl3u6yWfSLquygm++Z/0viVnw7W7Odvx9of8Ap2mu2V7o/pgrGIb3u/qie8/Fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030195
X-Proofpoint-GUID: DIHwfYpJNtbv7xZd9c4Aj4lRvle_ODH_
X-Proofpoint-ORIG-GUID: DIHwfYpJNtbv7xZd9c4Aj4lRvle_ODH_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash hotplug support leans on the work for the kexec_file_load()
syscall. To also support the kexec_load() syscall, a few bits of code
need to be move outside of CONFIG_KEXEC_FILE. As such, these bits are
moved out of kexec_file.c and into a common location crash_core.c.

No functionality change intended.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h |  30 +++----
 kernel/crash_core.c   | 182 ++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c   | 181 -----------------------------------------
 3 files changed, 197 insertions(+), 196 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 22b5cd24f581..811a90e09698 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -105,6 +105,21 @@ struct compat_kexec_segment {
 };
 #endif
 
+/* Alignment required for elf header segment */
+#define ELF_CORE_HEADER_ALIGN   4096
+
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct range ranges[];
+};
+
+extern int crash_exclude_mem_range(struct crash_mem *mem,
+				   unsigned long long mstart,
+				   unsigned long long mend);
+extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+				       void **addr, unsigned long *sz);
+
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
 	/*
@@ -230,21 +245,6 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 }
 #endif
 
-/* Alignment required for elf header segment */
-#define ELF_CORE_HEADER_ALIGN   4096
-
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct range ranges[];
-};
-
-extern int crash_exclude_mem_range(struct crash_mem *mem,
-				   unsigned long long mstart,
-				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
-
 #ifndef arch_kexec_apply_relocations_add
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 90ce1dfd591c..b7c30b748a16 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -314,6 +315,187 @@ static int __init parse_crashkernel_dummy(char *arg)
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
+int crash_exclude_mem_range(struct crash_mem *mem,
+			    unsigned long long mstart, unsigned long long mend)
+{
+	int i, j;
+	unsigned long long start, end, p_start, p_end;
+	struct range temp_range = {0, 0};
+
+	for (i = 0; i < mem->nr_ranges; i++) {
+		start = mem->ranges[i].start;
+		end = mem->ranges[i].end;
+		p_start = mstart;
+		p_end = mend;
+
+		if (mstart > end || mend < start)
+			continue;
+
+		/* Truncate any area outside of range */
+		if (mstart < start)
+			p_start = start;
+		if (mend > end)
+			p_end = end;
+
+		/* Found completely overlapping range */
+		if (p_start == start && p_end == end) {
+			mem->ranges[i].start = 0;
+			mem->ranges[i].end = 0;
+			if (i < mem->nr_ranges - 1) {
+				/* Shift rest of the ranges to left */
+				for (j = i; j < mem->nr_ranges - 1; j++) {
+					mem->ranges[j].start =
+						mem->ranges[j+1].start;
+					mem->ranges[j].end =
+							mem->ranges[j+1].end;
+				}
+
+				/*
+				 * Continue to check if there are another overlapping ranges
+				 * from the current position because of shifting the above
+				 * mem ranges.
+				 */
+				i--;
+				mem->nr_ranges--;
+				continue;
+			}
+			mem->nr_ranges--;
+			return 0;
+		}
+
+		if (p_start > start && p_end < end) {
+			/* Split original range */
+			mem->ranges[i].end = p_start - 1;
+			temp_range.start = p_end + 1;
+			temp_range.end = end;
+		} else if (p_start != start)
+			mem->ranges[i].end = p_start - 1;
+		else
+			mem->ranges[i].start = p_end + 1;
+		break;
+	}
+
+	/* If a split happened, add the split to array */
+	if (!temp_range.end)
+		return 0;
+
+	/* Split happened */
+	if (i == mem->max_nr_ranges - 1)
+		return -ENOMEM;
+
+	/* Location where new range should go */
+	j = i + 1;
+	if (j < mem->nr_ranges) {
+		/* Move over all ranges one slot towards the end */
+		for (i = mem->nr_ranges - 1; i >= j; i--)
+			mem->ranges[i + 1] = mem->ranges[i];
+	}
+
+	mem->ranges[j].start = temp_range.start;
+	mem->ranges[j].end = temp_range.end;
+	mem->nr_ranges++;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f989f5f1933b..f8b1797b3ec9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1138,184 +1138,3 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 	return 0;
 }
 #endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
-
-int crash_exclude_mem_range(struct crash_mem *mem,
-			    unsigned long long mstart, unsigned long long mend)
-{
-	int i, j;
-	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
-
-	for (i = 0; i < mem->nr_ranges; i++) {
-		start = mem->ranges[i].start;
-		end = mem->ranges[i].end;
-		p_start = mstart;
-		p_end = mend;
-
-		if (mstart > end || mend < start)
-			continue;
-
-		/* Truncate any area outside of range */
-		if (mstart < start)
-			p_start = start;
-		if (mend > end)
-			p_end = end;
-
-		/* Found completely overlapping range */
-		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
-			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
-			/* Split original range */
-			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
-		} else if (p_start != start)
-			mem->ranges[i].end = p_start - 1;
-		else
-			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
-	}
-
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
-	return 0;
-}
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

