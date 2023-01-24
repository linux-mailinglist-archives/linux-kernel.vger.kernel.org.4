Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4907678C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjAXAKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAXAKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:10:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F1923324;
        Mon, 23 Jan 2023 16:10:07 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30O04Haq013021;
        Tue, 24 Jan 2023 00:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=TUJKQ0WmgKW0iHKEhisopwAxvOrEgm8SGGTtLLZH9ks=;
 b=f9XyAYiG+Cq77o857SKKpFvdlGtb+7MzuiceiADMcqjUh6W3mCgqVxyccsshZsKunqaT
 beicaGCTfy8f1WDLsPOqs3xjIYGLvCz1KvAdyb552ee+xOqvqfFlT0Rpo32R8I6KlEtQ
 7f6mW6e/qdz5namh1wAMw9Q4rw9jSR3g//5MBD2AgzKS4BRnOTXQvNtQOROT2GzphScp
 vedw5dyV0nfWLIT0RTfQgNrLnlL2byu8JP6joERlvD0Zkxkto1UW2izOKkIuEk5O0FVx
 GSKpvbqwbdNfxYTfiNhrL5qyQfkM77wv+2TKs5vGbQ05iWZaSrYhC+5KL7UaCwrxK7qB 5w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86fcc8tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 00:09:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NNYBsd001108;
        Tue, 24 Jan 2023 00:09:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gah6cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 00:09:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7r5Yqdq+/adqhJxwoFHKZzCDl3z/NTc/W10kqzP4I91hkWbjAZRq3wC998Md/VN8CI7QoAuXf0yeN89dliameIsA5/OCQbX2V0sh8g47UsM4luanI3ZklPa60oV4H7NkGygB1bzST/mdQ5/ffht5+Kkvb+g4D9VUrLh10FUII9jLC9Ghp+BMv40Dj4oGHCsIYlYHgQzknTc3sU+SLDnDajoYha+GOKjUX9yexGxUTP1IdRPV2qeyETaLFAnr2JWaEWs8AROprrIO+IVto8hZIKbVuoV8Mj7EnJs+s8LihEqX1Bc5ugCcrBu2C9ELNwJaXVgEJ+Jr540N/S1m5eV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUJKQ0WmgKW0iHKEhisopwAxvOrEgm8SGGTtLLZH9ks=;
 b=gxWAnwMebcLZ/pg2omkdC9V0RPhCX7Swor5w/a6Z53GP98vVfpQ3XXGN5qPA035CgtGhjLRz1OiyPhWG7JwvaJB+wzmiorQjFwvcxbpj4ngIOgammTRGrcVggBIZunoMzCCECES3fsEwx9RvqhU7exQ8lvC8jor/R3ZSWq43JJR5jkkFriy9TzxMFxQKikqvUntx5MkdhODlkWYx8GKVD3u8PvV1OfmXRWZb64i7AZ6eA2Zg1gsLliH2a15+Y8T3hYrgE4I+u9dwidI0rwAlqRu7/LEgdKCI843Vja+/C1bbLx8pF93qAQ5v+8YCBo5o9v78dQsF8AXUWo4FL1D6vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUJKQ0WmgKW0iHKEhisopwAxvOrEgm8SGGTtLLZH9ks=;
 b=gVWvyFYBJcdM/dvP8X9mB14nauZKpwcw1vZ2KYqhvy7cLQp0tLC6p4kltGPJ7YBQ0z1Ym3VIaQ8aZM49TDO9g7aS0cpwtT12/Ckrtmv+Ue6HEHlHMCD2BoTDLAxjvfHkM6BHC2nQ2U6622/IR4HGOEWRHTeV+lqokeTMPS37DVc=
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by SJ0PR10MB5663.namprd10.prod.outlook.com (2603:10b6:a03:3db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.16; Tue, 24 Jan
 2023 00:09:43 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::f37e:ad45:7d9e:d84d]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::f37e:ad45:7d9e:d84d%6]) with mapi id 15.20.6043.014; Tue, 24 Jan 2023
 00:09:43 +0000
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     akpm@linux-foundation.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Dennis Gilmore <dennis@ausil.us>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        torvalds@linux-foundation.org
Subject: [PATCH] sh: define RUNTIME_DISCARD_EXIT
Date:   Mon, 23 Jan 2023 17:09:35 -0700
Message-Id: <9166a8abdc0f979e50377e61780a4bba1dfa2f52.1674518464.git.tom.saeger@oracle.com>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:806:27::16) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3794:EE_|SJ0PR10MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0b7c61-e690-4f42-35c8-08dafd9f4b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+rFJ8SsrJpxq1jTnpcShkjZefPjzK0Z5/G1joLm/D7L+kqkxIZCkMy+stKC5J20Bbk5UHe3GM6AyuZm5bHXCLQRMLl1KRJhQcBdWEmlRkk+BnQV94t+4K2I3L0ow5pbx+CjvjgOclYBtvRIQ+D/XfxTij9Bggf40fWBKvdTLSUz2edD2/smvqkNxxw+VKEovoej2uD4B9B/kR9fl5g3hXt4fOo/pWvM/qgz9HsEpA5bVyF6es7JM+kU90NOjOk1Xkr+zt3HbfCD0CJ4QcEO54HVzpESG03zjUyzq3Ed23KY2cljq6LKwmoqh6Nq4pV7S35mjhyGyT01gnMKpQ2dRhs1OKwrRlyiojAPzNSEO3v0TOWdyfXZ/CM3zVUK+OEPBduJTycPOR9NFkyRMYnAUSuV4ocLItapLMxPJhh+4R5Oqpp7WZcG/+DFP+gdNODgP6PLWDKFjEnOip/H/3tPaDJ4dboF4xYKPk5/cysGE+LJ53FGVNdpKQ/7cMZoXhuIAGYCmVcPRvHrGW3fJ//hXhjnwXGy2L2xuCbcLtkWEoZuoUiUC7noECu5oaXB/jrTCVWgQysKei32Uqn1TGP3WPR5ofqHOO8rwUcqYSRdhPlX2X8vmVKAcRByHExSTzEUqz7jmTcPhzs6IO5zXLOycbbPHTt3gVtJi4AbYXBikWSbfwWXZtaz44Ac6MXgb1cZzJJPYu/Zf3wBEOcPnbzYlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(66899015)(36756003)(41300700001)(86362001)(7416002)(5660300002)(8936002)(4326008)(44832011)(2906002)(38100700002)(966005)(110136005)(478600001)(6486002)(6512007)(186003)(6506007)(8676002)(316002)(54906003)(66946007)(2616005)(6666004)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wcKe16NZXHea5HT2tVycBpl9Fb0kBqK82Hcpq68/r80xMG0RAJgxuCkF2+c2?=
 =?us-ascii?Q?Ln5J0TSvoGAx6zzdrWE4E6nfsn+zqNNVXfJAwKu2zBIBeo38BE5bHwwGij1i?=
 =?us-ascii?Q?z9RsrK1zEMvyoEyl1SMR+bmwUrnFsiwJ4JiDJjWx6WLGUo+4AlICou6D8SIu?=
 =?us-ascii?Q?iVJoaTLRoMtvJEg2z5xtOgge/dvh6JMEpB1JhwuNKOD27sw6ExXa6y0zPmrR?=
 =?us-ascii?Q?PFJrp680tCuEleazNBxgdGiRoKRggcMXgA7VyaYllPLfwXcOVP7Ea4kqy2Tw?=
 =?us-ascii?Q?52TqK0WvCT1yhxP6GdVaQ8MDb0O0ei2w+I437JU7yjogRfdFJxIQskrUxKyr?=
 =?us-ascii?Q?FUTomuYylll0BJqv2dWBho+QhWLrOGOzHzXNVJKCmfd59cJ4Ibt3d0zWXDeX?=
 =?us-ascii?Q?PHNE2Voh/+ItnGxEHVn1XmqFqP46y2jMN0zqvUv9aBmB4wKm883bkFfbE6Ne?=
 =?us-ascii?Q?K6Ii6/j7JVetCo2w3BM0/0b+xavusFCL4yZfdcpshIGgnlnrNF0hP7H4+omg?=
 =?us-ascii?Q?PXqyWgqXvWdFR8Tzv8zIfQ06wWrSYeXX1+HYDVIWQqBzuyk/rHQJcrO7rwD4?=
 =?us-ascii?Q?RK36kASlnrVtJRfz0i9mwcibUBGZI2R9Jm07SPo78F6L64NUe7nhZp7GI0K+?=
 =?us-ascii?Q?cTOc57MNae4CxneuUtSPBde6GmDdOut33lUnzX7glBT/O0/k2hyCHszLi0Oj?=
 =?us-ascii?Q?f9utO5wflETkSq8t7MbKEmF8vxTGpeZn3AY+KNM4+JuDnj9L/Ep9HDcA0qEf?=
 =?us-ascii?Q?xYWZ48+vhVAdigomMRnzqDx+ZpLmKxgwq8Z4izSqIgOsMISgKpHFoVs2hO0X?=
 =?us-ascii?Q?v8m/f9qnxg+R7u6PD5D7xs7MgxuQx+Rjg/9l5f84s+P3TNkXJSHFz4WAdQar?=
 =?us-ascii?Q?mgFctyvlIYIT4D+xECPeOupla2i0MYvWJtjbd39Odv8ifcvT0x4ReHnU5cn6?=
 =?us-ascii?Q?Ewl/xUlLOGlxekOjpTLufOhJOfHA7MPIjSstFCDbDRAL6tF2azwub5hMF7FA?=
 =?us-ascii?Q?MPICeceHmYeTH/pq1eNKnUH9nsJbTcw68Dd39TANPyKd7NVGlTac5dmd/y3Q?=
 =?us-ascii?Q?8Of9Co24EDX2oTd/2xLM3GOG7NB/VIMpJFjTGfi3RnjrYOQyWnGahCD3rRyK?=
 =?us-ascii?Q?/NkF85Coxi81WYHMnhGqSF94BO82TVGSgDmSCjPIwUbP+MJUTmKmh5Z1ThFh?=
 =?us-ascii?Q?dU7YVlS+oQFXx0D8z/F8v8UpfMDIyhu7gfo+vRbLRj9O2Eik5QvsbdAV1eTe?=
 =?us-ascii?Q?SayiPSZtnXbkUPSi1bp44c9SvWPUYtFcoIsYsy+O1Dx/o2psEYFdZJsGVtJf?=
 =?us-ascii?Q?fH6BuzED/OiCIRpX4tzKYf0/ryNBsTFp9gzCg3/eTGwqCCgbU9aUJMwRawBP?=
 =?us-ascii?Q?zKDYBZpUuzH8nDK/YWmAAJN2JArRBtD4tcUF7JnLRkczZ0YfbxVRmuWTj/dt?=
 =?us-ascii?Q?GEhLZLyyVgyKcCHQNulBAygdNN+3IeTDv5es3XrEqAuX6VkPqbf30uaz/pta?=
 =?us-ascii?Q?RCucWP3p6vGjr+G8FM3dWXVdRG88ij4B9duyzpI5asBK0jCkyWlLNwqUDtnr?=
 =?us-ascii?Q?t5NhxcPEaHDiEvfi6m0pU5YZotRJrYnFA53MPf8ZhS+OJ1pf4Bu8hGmMJxCd?=
 =?us-ascii?Q?yhLTJc3l92SOAtBnEh2YMbE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+H4dp0ups0t81DUkFH2hygmihb8REoEo6JqpWTLkLeSqm3glNuNAmwzWrwzD?=
 =?us-ascii?Q?eT/Bsl2K7baXPDjKJ+wLpLpvhVmsZ/4lS8qcHfNeJ+gn8/2gbROmqvjF1FII?=
 =?us-ascii?Q?KA3Q2by6EzL5ExAN9eTSa8V1rUD8ntDxItl4THwmTmeXPIRZk3jxH/FsGk6v?=
 =?us-ascii?Q?a2R/+1tDuH882f+XOUxXBlOkML9W7BW9wNbUxNdSytDKHfAO81eTX4Ya7+NV?=
 =?us-ascii?Q?RhSkiQsj2JBOQOGCwET/QtLdg/Xwwbc7y1E6JqjLZKbYIoR+d1SSVoLk7dyC?=
 =?us-ascii?Q?qNcGzjxaiRPOb3lRdwmvf+Yfeq7m1zx0MVE6sGLXrZecDzbLO0bB+iMtcRou?=
 =?us-ascii?Q?WhsNMODAhvjyo9N5vvft/5P3w/XOjAa/W7UaUCYwQh660G6pxxIRxDDJs5vT?=
 =?us-ascii?Q?ZfFW878FX3gT7YlUGy5wFvhS4K1YN0Ify/S0AHFfIWdloB0ySDTfvAR8FYwx?=
 =?us-ascii?Q?XNE9EEqbmKS4GVgq+TRnVDXynj53S06PYErEgX6SUhKfGg03okCVKud9B69E?=
 =?us-ascii?Q?VdcC+IqvZjoo1215yk7xP75n9vJ/4Fq+lLbBPOBK8PRDZib5EP1HaRddCFe1?=
 =?us-ascii?Q?D6dz8MulwAPUxBRuGAJZnb5WwNxmqSDTrJ5/TWJIBEFV+odBMAJ2e+ZsIM30?=
 =?us-ascii?Q?Q8WXCx+A6YU10W5lLTMhwM3irbhZIm9ckq3x3p1kc3vbV83UhBO6lp3UUpWB?=
 =?us-ascii?Q?Lnz2mMh/lFjl1Rm406cTfd34Mq1/KzI2XDPcB0fEa/M2b8+eI0OkVpf7n+Xp?=
 =?us-ascii?Q?ovg1as5UuvRLrWCFdccsbcLp8c/Z0abBoL4YASaSgerQcifQYkrmdkAeQbIn?=
 =?us-ascii?Q?hFR6O09963oGRq1fD2gSlmy+HgnjTQfH+xcpsDioMj23uQuItAMjSyOXVPQ+?=
 =?us-ascii?Q?bQlqNisdX6y98tCidKYb2oyJ8BLA4KhR2TGL3WyN0dOAjMzyFsobz+3a4Vlr?=
 =?us-ascii?Q?b3Au7mJ0HJu1PF3jpquxnbirTMPI6j6Dg012msDrVFgdMnBAJG1PFsSrk0sB?=
 =?us-ascii?Q?JTrL8RIfuZ0BQy64Ag7aqnGoSnmaQDoX9ft+z7hcbQEtMP6fvn0efpwpbsrl?=
 =?us-ascii?Q?mlkHiUpmQRn0zXq8VDRgF+7KuwY/WFFPGgTCHgS8wXECZECLE7U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0b7c61-e690-4f42-35c8-08dafd9f4b93
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 00:09:43.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8s2ETDfvv8psI73C6RSVgQImT3psdup2vVdoT70PBOEnFAbFDt3rDMCxArxl6P9zSDysopRV59OUhDOn7oACg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230228
X-Proofpoint-GUID: 1N2HVkJkg1VLiR_q3CzMCx-cDeATIPbC
X-Proofpoint-ORIG-GUID: 1N2HVkJkg1VLiR_q3CzMCx-cDeATIPbC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sh vmlinux fails to link with GNU ld < 2.40 (likely < 2.36) since
commit 99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv").

This is similar to fixes for powerpc and s390:
commit 4b9880dbf3bd ("powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT").
commit a494398bde27 ("s390: define RUNTIME_DISCARD_EXIT to fix link error
with GNU ld < 2.36").

  $ sh4-linux-gnu-ld --version | head -n1
  GNU ld (GNU Binutils for Debian) 2.35.2

  $ make ARCH=sh CROSS_COMPILE=sh4-linux-gnu- microdev_defconfig
  $ make ARCH=sh CROSS_COMPILE=sh4-linux-gnu-

  `.exit.text' referenced in section `__bug_table' of crypto/algboss.o:
  defined in discarded section `.exit.text' of crypto/algboss.o
  `.exit.text' referenced in section `__bug_table' of
  drivers/char/hw_random/core.o: defined in discarded section
  `.exit.text' of drivers/char/hw_random/core.o
  make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
  make[1]: *** [Makefile:1252: vmlinux] Error 2

arch/sh/kernel/vmlinux.lds.S keeps EXIT_TEXT:

	/*
	 * .exit.text is discarded at runtime, not link time, to deal with
	 * references from __bug_table
	 */
	.exit.text : AT(ADDR(.exit.text)) { EXIT_TEXT }

However, EXIT_TEXT is thrown away by
DISCARD(include/asm-generic/vmlinux.lds.h) because
sh does not define RUNTIME_DISCARD_EXIT.

GNU ld 2.40 does not have this issue and builds fine.
This corresponds with Masahiro's comments in a494398bde27:
"Nathan [Chancellor] also found that binutils
commit 21401fc7bf67 ("Duplicate output sections in scripts") cured this
issue, so we cannot reproduce it with binutils 2.36+, but it is better
to not rely on it."

Fixes: 99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv")
Link: https://lore.kernel.org/all/Y7Jal56f6UBh1abE@dev-arch.thelio-3990X/
Link: https://lore.kernel.org/all/20230123194218.47ssfzhrpnv3xfez@oracle.com/
Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
---

This may be moot given sh might be soon removed:
https://lore.kernel.org/all/20230113062339.1909087-1-hch@lst.de/#t

However this did come up here:
https://lore.kernel.org/all/20230123194218.47ssfzhrpnv3xfez@oracle.com/


Regards,

--Tom


 arch/sh/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/vmlinux.lds.S b/arch/sh/kernel/vmlinux.lds.S
index 3161b9ccd2a5..b6276a3521d7 100644
--- a/arch/sh/kernel/vmlinux.lds.S
+++ b/arch/sh/kernel/vmlinux.lds.S
@@ -4,6 +4,7 @@
  * Written by Niibe Yutaka and Paul Mundt
  */
 OUTPUT_ARCH(sh)
+#define RUNTIME_DISCARD_EXIT
 #include <asm/thread_info.h>
 #include <asm/cache.h>
 #include <asm/vmlinux.lds.h>

base-commit: 2475bf0250dee99b477e0c56d7dc9d7ac3f04117
-- 
2.39.1

