Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8F66BF3C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCQVXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjCQVXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:23:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7FACA785
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:22:35 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HJUQ03020643;
        Fri, 17 Mar 2023 21:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=g1wxY3LICoo5vWQ+zWVRd+wf6XK2Gcx/FSKiBxH+Ieg=;
 b=GyHNPqaKnNIfqcWCYBYj0AC7YpWOEmYV8zyFcWLYrm3ktRTIhdZRBRPE3a0Sq2Gcy1sq
 6/JpSl+eo3533RwK3EaWv4p2XFqDwg506B32RIVwBPf6sWJI3b1YELrrbQzSPCESS0IG
 tye9GRdK2DLaZlBzifDRzIClHs27NOctVxsmwAlk4h/5F+V3tYLJ1BsPaMmxWuxCrHVb
 voXcH3vSJAzAwP3mwWw7tR3fjL4Au/y2lVTIwra+UssZ93dCtMKovFUaW3X8030Oqrxa
 a65pHUjybneSCsJV419SzKlH+pb/kAOaqr2IqPQ/CWWIOYP7T143cGx++nLq6QPTJZgN vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2651q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:22:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HJAVhh002489;
        Fri, 17 Mar 2023 21:22:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pch08j9q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:22:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPIha0LgA/u3GqH+WrEhnEYOzAwVzpzV5EJHYJyqiuujvvgqFE2fV7AOvs98Me4Lelg+agX2/SJW8xenn8zPfXzsaMCI6+GhBrDJ3Qou0Xr3lZMjHzZP1nG8n1ZbNPd06Bz/gEov4X9K0gYVgMFRhTtxXLlhabYQ+dw/Zn/XDHu7qJHAzv8oRxXPjaE9zpbj+A2D5w7ZS0sNwjGWvNMdJ9n31sbZE8Wt5YtfW03K7mM7cmcFkkcDJzzyvcY6Taou7ch+tfIo2gfGkJGI+61EdyUTo2ntjBAtMjjVuYnPQH56RcC4KTitko6JoKC869xAEl39MHnSfWcVskHCQ+kLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1wxY3LICoo5vWQ+zWVRd+wf6XK2Gcx/FSKiBxH+Ieg=;
 b=K8xF2pWb+qMFw6G8dgzPtn52SQD37ug12+Z8mprjR5Mom81BOozN2iBZILTw73Wzr/e7ZQd2lwpEsgyDQpckxcec5s4Ai/RnX2l2wpW20iiLHzvejFuiyP5zgHG2wwep892r9BEYqE2Z+vkyu+hfuLdqrfRiSW7UuPYifw6wdZmHbyB5imv+dtirt8sXsOW/Bo4otTTcjBjpbXNQHqqmNdRp5ZrlP4EF8mbKky2iOrp/CnGzq1NUMK+fN3Rcr2QQFVcaKiCJoRbm3MW/KnUDPyUK8mkSvhf7h/qIoKVYL3SSvhIji5oWDeQDnap3rz5l6z/iRioYK0msvBygLW6yVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1wxY3LICoo5vWQ+zWVRd+wf6XK2Gcx/FSKiBxH+Ieg=;
 b=UmJ9SKyjQuL7UA+FDaeFIoLwnnOH2tE2d9QAeMZZ40nakRu/TAwgI2evlGN1aAVapzOW11f31Vj4xczodqkJTZVtow1OCrCAYa3J1jGbev2Na1kLPFZlIxJKwOWZxZWMGvn7ok8h2uoMzM7LCK0j95FYS+0l6oGljQgbBED/aw0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5901.namprd10.prod.outlook.com (2603:10b6:8:87::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.35; Fri, 17 Mar 2023 21:21:58 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 21:21:58 +0000
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
Subject: [PATCH v20 7/8] x86/crash: optimize cpu changes
Date:   Fri, 17 Mar 2023 17:21:28 -0400
Message-Id: <20230317212128.21424-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230317212128.21424-1-eric.devolder@oracle.com>
References: <20230317212128.21424-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:8:2f::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 1006161c-94c9-42b7-b0ed-08db272da41a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wjmQOqC/i3ucJWBjhhxN4B/KIXqNDckkAIIJzXs+/3A25iEF8NWvvpZjzxfFcdX2k/Y5s1V/gK92njGsiXF7aOAzQ17Q2jkBaT/8hQJg9EbXIqFnwdtqXoP916u8G+VsMw9TUw0sGG10EWjZvtOanUBDg3aI3AVqmwDf4dFs4uCkGrELg6D4H4ipTElxO2o0T6Ds7J8ua6Z1Pvmyd4CsC05UYZw+9PEKEg80qtiipCzerGu05VhKUOsFnWjePs6FuHMQHtk9Eg14vacHO1P+HxwzW/OyVFjLFX9WgrdE++lPguvhVGMFpGo6eLt5UQ+T5kFTLFGZrphX4H0fu/tsY+ZRb8SoaFBhJPocGHIJFsPG7oTB6LJTJUOa29+5hHdFESSDD3yFtdPZGYedx3zkmXTAiBRAImWjn5zlLc+U4luAjQur1kgRs/xm3cJo6670y6p3/XyosGsGkj7AaZ5I59UM76YxeVJEDb0vcMqYt+6JVZu91Cxmd5V8l8I1IJcUZgQ5oyB4CUK2cpFGCGQ4XHhTr1mkgI6dgAZHJj0IhrbPEI1MRWyCWwUsMHyyyiGTRkhgb6c2a4VS4VQV+iBw8Tb+qx1lDrGjrI+jmTe6XVDGWs6adtkFb6HjH3FDKEyhCups9q7Pfen1pq823tlAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199018)(86362001)(36756003)(2906002)(38100700002)(41300700001)(5660300002)(7416002)(8936002)(4326008)(2616005)(6512007)(186003)(6506007)(26005)(1076003)(83380400001)(107886003)(316002)(8676002)(66556008)(6666004)(478600001)(6486002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6OaSFJpWu3CdwIwTDrOTPcOR914oDEb4iKZeOQi+v2bOPcxJOn0ukEvn+ZHO?=
 =?us-ascii?Q?c2KjvubXAU8kd7GRiRQyV8ks4xVwRO8rLwTSytJAbcTq6onCjM+x+qy3zOum?=
 =?us-ascii?Q?/qUFVJyQLu3nvf2X8CuMrE6Hr15yFSAaKQ19nLNLNJ3qrQLekbbEvsr8IBen?=
 =?us-ascii?Q?m+jdfkzvY66LJMinJcQQPm6ulySn8zDZk7nkMX1FL78Z0sSQu2oO2lEA6NrR?=
 =?us-ascii?Q?D9zxkNjBRWAqIL2EQkrF464igdGpFEzfMJWqT7zmAlZvT7y5Ef3FBBSqQRS9?=
 =?us-ascii?Q?flraQXot83i8qyCkkoOekvf+K1tsi/t0I1URhHZadfuLRIvtq7Pcvvux6Mro?=
 =?us-ascii?Q?Uv1TRAmLKWB8hG4RMGjKXow+xFmParYxvPMU8YNrvnO4czSikHnQ6UVCYwH8?=
 =?us-ascii?Q?HvKy+y2BKLBoiAL1FzNZNJBDf4vEtmY7IrkmD/9ildG74joiXsXewBQXX1IF?=
 =?us-ascii?Q?kdRR6b1+r7fhTdQ15ZgKa0QixBQqNwS3YNE/OfQHs5tyPVSwUw1bZYl4gfRi?=
 =?us-ascii?Q?UDXQ9+/tFl0/j0BcORpvpsQpMCFScFw3rApKrhC88Gq4sNvqMefwuAEreLow?=
 =?us-ascii?Q?YrOZ/GEamAvw87UB0m6GXQRKWt1yqr1M+oYutLgucgxd23ubJoHnYc7ARJTP?=
 =?us-ascii?Q?P/LfeQYdlzGcHjGTqMAALL3fp/PHLWx6WlAiXGJU66sF7/4rWr7eUfnG6e2a?=
 =?us-ascii?Q?3UAEN1yKm3mVUP/GHiP7LmLtNnYksiFDFSwvxvFY/e7B1lfq/Vpae6tuQIjK?=
 =?us-ascii?Q?Lt3+IvrkphEL8I46r08JbkxmVQ6QvlSUc13wTZ7dKNO8HZmqrs26pCUbXeoC?=
 =?us-ascii?Q?eqXXDvn9EE9rLC6H4cC90M/qxbEkylK3cxh8YeZkMxn6vzc5xp1w1VMolHi2?=
 =?us-ascii?Q?zJPpO7ZNeoco3gCmjH/IvPEe/NyIWXAj5GT84gByc/WdO+TiECkS0rYSNSyU?=
 =?us-ascii?Q?t1ungeH877/Nk7VoFSXnUP+lZL0biNpSGSealELBH/ywTaD97SGcNejhcAqr?=
 =?us-ascii?Q?w46Qr3+T6xR47yCZgsAQ5yQm3KonADANDh2Aae8Uoa0CWp3FrYNtWGgPi2Yk?=
 =?us-ascii?Q?VV5OXtm9tqPyuQavHR3AX2HKpPpwm61+e/YFI++7MS5JGpNsAHmmqFsM+fWb?=
 =?us-ascii?Q?jHtUzF5g/MK+OFE1ofRyqooDvFlL5rFpvOofUMmS51QWA830aWcBibOHG6tE?=
 =?us-ascii?Q?VJPr+Q70NXbceQwIz5T55qi41U8iY0fP0FLyuWSsIlr0f+cuQr979A5YFhFQ?=
 =?us-ascii?Q?xdTWgwr7FG29mQaaxIrwO0EXfZxNhfvv9BMk/Wo1uExqejT9FCJNA2j8XxvI?=
 =?us-ascii?Q?MIkO4qQ2ErTjlnfYum7zRBXpEUh2WIn9Y6xX9Ujqk4SjuE+KKakT8ttOWjZR?=
 =?us-ascii?Q?TeHS9mgBLj8bOHcLBsGWYcT62SJCWD9t4cxxUuo+XIr+1vjLkW24fMXdpIRF?=
 =?us-ascii?Q?M7VwAagzXivc7MYRx7QGousO5YruQJGVgV9BrGV8WR6tnz1r111ZVVDCO3V7?=
 =?us-ascii?Q?UaA1x5wlkOH0DQEki93BYhSypO88ozNHU7bCRCKrpxQFHfc5l7qbGs8jbwBv?=
 =?us-ascii?Q?LCS9FVwa+2w80DTYQFwENSqa7GTA0MePHvN5lo50YiEiAAtIeIBvlWPeW1QA?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SAuBwLLbmr3GHfTpu7AQKLPVWKXvjTpjqSa6vDV2wO/fE90BFS8oMjiDkIGV?=
 =?us-ascii?Q?dDuDuJpyByEbvmGZqH408w+4jELO3g8d4BUuLCymlzB+h0Vh5/2JaReBIpz/?=
 =?us-ascii?Q?nMS7RUPh2N+Xa5lIeJzkA2W6hlRuyUlwhhR+5/OJDZkIURFexxRlv9wed9ov?=
 =?us-ascii?Q?9I29yPRmR39+CGMFT5/8V9rOT4j1gWUB1r4Sn2DgIA+recA6SMLUtLOcP4QW?=
 =?us-ascii?Q?kP5XEyu0IAXNYEw0XdPERzDlNVHtl6/IdNkwyLVO0OlrhhvjkmzIhantW/pt?=
 =?us-ascii?Q?UXciIpaMBiYIt5HBV0GgqM2QUQzMX0A1dElx1krkPB49BTUli5AromWqVjJy?=
 =?us-ascii?Q?d7IG58eUUVtKsHpPuPickuwtrlMxwLlJbwdpEV/s9E8XavCPw9ZddWJcpCYC?=
 =?us-ascii?Q?hABC+7UiF60L4kuE7KljIEVeBEdkp/qP6z/eelXnlJDXdvkhaijQaYXAeg0S?=
 =?us-ascii?Q?XGzEHtYk5rkDLCIdNHh6spD4qQ+VpNFtAOGutV/S/Jhm2ZDdzDqD5O0PG1Ea?=
 =?us-ascii?Q?pk0/ifiocVpdzSnMHCLu6e/02gVxQtEAnUcAsS4R48sFcbcKztYMPv0g9tMN?=
 =?us-ascii?Q?NwM2Pjz4AG6H+39CIf4pcdbIDNGmRY7UXrZGdLG3tIE+WTthwzv/H6FyRog7?=
 =?us-ascii?Q?jxpH8+OB9WKGt3eOiQhQEkz4JZsRUM/UlnoorCbdvh2KCX8eqCNNA7MsceCR?=
 =?us-ascii?Q?sMXmohpHeOMvXXf5mrgyX4dHXh7+/ik8cWnw6PR5eT18WrsTzCOkOKnEqiky?=
 =?us-ascii?Q?EyO5bE8bkqp35X7zVmk8XjXbw7JsJmzzNBNZBfLxKN4CjmpfvgNyHX6oyNEL?=
 =?us-ascii?Q?8Nv8uGf5xSoliuM70SxHWCRE5yzDVhnEgAQArVMsWwq7L68zBdVEPsfYOWg8?=
 =?us-ascii?Q?el213DAWlW+s8Hsmy1A9I9wdDLMsutBpHau5PJP4rhV+3+e+MXZi/gR2gROD?=
 =?us-ascii?Q?G98tHlBBOwg7gTricKSC9bR+GmJXnMt/d//c/QpoZ5HkJedt8njaX6ugIyG2?=
 =?us-ascii?Q?7c/SUghDFDRD+K/OPs1qms3f/kCxJ8afo2z6FGXjstCAOaktliCERod+xD0R?=
 =?us-ascii?Q?hEv3dSLYvfjdgFpebOQKxFzHLezugwKnMAYXClCId577cyqucdvK6gePXT8O?=
 =?us-ascii?Q?pityBKpDnQWlQfrve5BGwySH8lb0PlIYZ0OeGXn+jnS5ZKRvooxkN2M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1006161c-94c9-42b7-b0ed-08db272da41a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 21:21:58.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HY6AeWuQgiaIGHwjB/NLlgyLEBqIMa5WooeMuVofPkHL1ZsdjxMJvC9yfDhA15Zs6rTHKGI6F9EcdcmGOeZoI2gssCEH3Cg7/t2Smpd8ovc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_17,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170150
X-Proofpoint-ORIG-GUID: 8Zlx89WUXmEXL5fSB-2NI3gezei0pgKl
X-Proofpoint-GUID: 8Zlx89WUXmEXL5fSB-2NI3gezei0pgKl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is dependent upon the patch 'crash: change
crash_prepare_elf64_headers() to for_each_possible_cpu()'. With that
patch, crash_prepare_elf64_headers() writes out an ELF cpu PT_NOTE
for all possible cpus, thus further cpu changes to the elfcorehdr
are not needed.

This change works for kexec_file_load() and kexec_load() syscalls.
For kexec_file_load(), crash_prepare_elf64_headers() is utilized
directly and thus all ELF cpu PT_NOTEs are in the elfcorehdr already.
This is the kimage->file_mode term.
For kexec_load() syscall, one cpu or memory change will cause the
elfcorehdr to be updated via crash_prepare_elf64_headers() and at
that point all ELF cpu PT_NOTEs are in the elfcorehdr. This is the
kimage->elfcorehdr_updated term.

This code is intentionally *NOT* hoisted into
crash_handle_hotplug_event() as it would prevent the arch-specific
handler from running for cpu changes. This would break PPC, for
example, which needs to update other information besides the
elfcorehdr, on cpu changes.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/x86/kernel/crash.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 0c9d496cf7ce..8f7b0b7fba90 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -456,6 +456,16 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
 	unsigned long mem, memsz;
 	unsigned long elfsz = 0;
 
+	/* As crash_prepare_elf64_headers() has already described all
+	 * possible cpus, there is no need to update the elfcorehdr
+	 * for additional cpu changes. This works for both kexec_load()
+	 * and kexec_file_load() syscalls.
+	 */
+	if ((image->file_mode || image->elfcorehdr_updated) &&
+		((image->hp_action == KEXEC_CRASH_HP_ADD_CPU) ||
+		(image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)))
+		return;
+
 	/*
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
-- 
2.31.1

