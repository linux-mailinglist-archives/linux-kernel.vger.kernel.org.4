Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FB56BF3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCQVWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCQVWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:22:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF20C794D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:22:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HJtqCd027660;
        Fri, 17 Mar 2023 21:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ffU+kjuYuTVR2ucWynkeRq8pM8/PmVRs5cUAVYP0Sqw=;
 b=t0t2MvOJD1MrztMABmOZrrzxPnzfSa0moVBmZG+9NZd8IfajMZFVDTFglyTAXVPPhLno
 AT73/lfVQ5FcouiZ08bmd78W/LyMw/jJVyUSyRM1wKW0ZBrvA/L7+Zzk9Pg2F+GatSnC
 BBTco74yagaU3SFzzfJWaw/pENPVZNx1wvnGgA0hFWu+Ibhfh1NCq2R3NrwNM7r08UAm
 VvTLzcc8eTwK0YrcTzvfoSGLI+DlcetZ1VYEXKkZRFYhZlfupllq1jnuUpRpcwXW+Mmy
 JWFgRu+KwLxvRk+JoRo2aEwdBrH2f2KZRW3+8iJl2fAgOqQtiE9MExwnBjkviXzVwv3U hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs28myt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:21:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HJAlNp020704;
        Fri, 17 Mar 2023 21:21:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq46tndv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:21:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoydcxxkNPfsty/unU+SIb/Ij4kget1As8Nb+0X3+ddiWWRCdHB4fxMEbBm68pcd0P97+0J8ni0XGVF0Mn6mTjpVrQ2RBu/cM0bVw2H6nYmGQPQSVVTpInFJ4bkeWXvHP8qRe8+5AJXPl2E2ujYJPd6hNMKCcckGeO2LeZ2bCjZKdOcv8+OkByL9zbh0AfHhiH6+ryeoiSQg7p+QrTwu3JcuxPeaDgot/8142A7PY7B2zEZDfZBiUof8ytWi6Ktn1Wg5a1rMJMEsUcuypkPtJ3cmRM9ejotifK/zpUNTUs1qBoQzX1WsCskQsCEJJ/gtxpZ+Tf/5u3MR+cT6Ya9M9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffU+kjuYuTVR2ucWynkeRq8pM8/PmVRs5cUAVYP0Sqw=;
 b=kY+vkD/0ayYLkHvXfXt9QKS0u4oORRhC5qETMmT16TN348TZWNZosELQTjekVpgNpOBPwBBx+oyaoAjQ74swyUVMR7ZMaZP9p1BiHH11IkUtGbnIdnHfDK/s8mtjYUePDnwr3kpf299dwyqoBN9sxK/x9fNsfr9z0LgZpfWT0K2wGoC2YwbAnrFrsZnRwDKKkPQY51Rcfx8quoLmIE7Dfwk/aP3qMgeaJxWM5m7n0Zp8nAEz1wD591fT4MHjsAn8EoOGl9EakZOaLOh5tICeaD884msIdiQvL1TyYvudjqAFNM9i0YgsGl5gRcYKcHuCPfuApkgDw/qx3l6Ptm3zTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffU+kjuYuTVR2ucWynkeRq8pM8/PmVRs5cUAVYP0Sqw=;
 b=dt96EwZFdusPGx3my4CGyZUYin8q6ZEGuYkdEo9su8laZY+ogGuubRW6kIiodb/UtWs+DcRTS39IMnn8qeQko86pneQwlo5jXyywCXYlXrjmCi4IM4J9z/cfWMxIkbU409AjiJlV2rxG/6Eb+m7W0lD2nyx072KkNGrJLcbKtLI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5901.namprd10.prod.outlook.com (2603:10b6:8:87::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.35; Fri, 17 Mar 2023 21:21:50 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 21:21:50 +0000
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
Subject: [PATCH v20 4/8] crash: memory and cpu hotplug sysfs attributes
Date:   Fri, 17 Mar 2023 17:21:25 -0400
Message-Id: <20230317212128.21424-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230317212128.21424-1-eric.devolder@oracle.com>
References: <20230317212128.21424-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::10) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: d6838ff9-c71b-404a-bb57-08db272d9f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6G1RSEHk2+EncbpMaluhG0zLDrdxQerDYScgSbLLtvL+U3rVCltPSEl4812EeJbLk3Annb3QHUUt7EoWcPc2WEXnu5n0f2LQKHLSxtN5aocseRY1u8AZ2a74rpDO8W7oT7GierHYE/ddjngfBy6z1hudlrsn3DIpN6fINx+6TuMVekih6FcH3tJ/fI4dc4L0kBmnTYCMo2i1lmXP9Bw2QgAQVqXg6ug/7ls/JDb3N79YieT270ibDVlldstcOwi4d7QL/CPY0pubzdUt00hnxMn+43bQDcTZoz/mPBZgrj4md8+QezcFKlKKs7oqkknyRhBA/5wz56qFjJNkmwGn1DHMpvx+SupV2gzAqw/PKz8EZ/TxRErAWdzImgb9IQJ877wxszYVq7lRcKj77MmJx7N/7+uqT4EEjZdG7qibxt1yc4x4niDwzevjKkphT4rFxLuUAGacyngR6vvuNPYfMSGPEpSKZAuYJcjaDLg8qVKJlc2Ym2adsmf14WwbkTRzqOpUyxiz4/7XHISaAnFqmINSgz6YKUGOK01sDaZKLpAS2Bs0020e9Y2L/060H2Mv5urpu0gbJiA/80YrePMEjzuKkzzyM9WaJ/64e5Oth47Ep5NcQjEyWUS880n79aKxCgLO+kiFwhOW3Burt7/WEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199018)(86362001)(36756003)(2906002)(38100700002)(41300700001)(5660300002)(7416002)(8936002)(4326008)(2616005)(6512007)(186003)(6506007)(26005)(1076003)(83380400001)(107886003)(316002)(8676002)(66556008)(6666004)(478600001)(6486002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kn9daDAWYYRVlwD+UjolnjuXccu8lF87DfQYxgSY6XG6bfvbM6MYibTFiXRT?=
 =?us-ascii?Q?kJfLff+sTy0OdiACJBhNmy/gnWgAgLcAlLC5eBaQ7nGohHSQ1wA/txeTpHA/?=
 =?us-ascii?Q?9/TfjgWfIXjHNlqiYvLpPUgmI+61huu/TqMIsrOqnfy+ZPa8jfyOuaqcliR6?=
 =?us-ascii?Q?9VmmSdlylgt5hSOMN4Ao8IfiHjgevNL3ToUnhDpTPmr664TjI4toEDx159ev?=
 =?us-ascii?Q?1pHXzRBYY3ioEf6NHOvUaviPL0rLXgG0DZOjBSOV5rQCyTgFD6iA13GVyjVx?=
 =?us-ascii?Q?LbHVq+cnm+xZBt8dk1mZd5JXS+seBF4J9AX7GFdn519KfTewqRiR1V3Zx18X?=
 =?us-ascii?Q?lSYyP1V3YknN8r8iuWBVAaXTxkO1LhdBLMwZ8EPMcoY7BFoYMbzcsIbRG8c7?=
 =?us-ascii?Q?S3f7K7nd6T6138WVPP3uqF7836eG6qlZ+nfWBJ1WWdQs4XgRfsKN82FV87PC?=
 =?us-ascii?Q?UVeNJYV49gV3BglJ+S0sesPdtr78OHmTG5iEO2kOxaaf2XJgF+8ztY5j2uRL?=
 =?us-ascii?Q?ZM2GH4MYODre6lD5uo4Zj/YZcL5P++ohkvstCcKm+e1GFqxfw+jDsXRxLs9P?=
 =?us-ascii?Q?OofprqGNeCWgs8sOK1eKRbnAIPU9pQO0bKoJUzZoVWYscGox1l5cQg1dwxyi?=
 =?us-ascii?Q?66xNeghoC7iP9v56P9UWr9tfSx/SIlCZJSTpXz6GY7JDUh/WzM5X6cUvud67?=
 =?us-ascii?Q?crpTXHg/OLT42mZWp8ponghZaTtHeB28peBoty2o5ZuZUMxNEDu/vGKJWEz/?=
 =?us-ascii?Q?T2hKd3S9yXd2YblQafsgcAuo+q4Q/qQrCWSdmDh7uhiemUsfWrUfADl5g9+a?=
 =?us-ascii?Q?pUcC5PVQrQU00lTWx4ZoglzGy5agba57fDKFcrtWqo43jvpnvvSiE8CpRAYQ?=
 =?us-ascii?Q?yi5FbFSczrmLpHvabIK9cAjXBmaYM/nc/AW7g7eKcGdLkoxZRc6dE+LG6Fvg?=
 =?us-ascii?Q?C1JleCEmSkUK/pK3v9hgk8kPbc4XZuUKWjyQcWPyH9Xky2vZFBkWDw7kvGJi?=
 =?us-ascii?Q?SI/4NnKaa/upyGQRKdDfv/6IY4lAff8LGCXPtDYKAJKenBv8vFvDXnejdK2n?=
 =?us-ascii?Q?OTai2Hp+e29LBQTXk5sls9R3K4sHV/k0rnVED3BoQ0jHcK9ifKrPA9SjGmRs?=
 =?us-ascii?Q?sdxIYiKj1HCWzBPr/ibGq5p2fykYeMHKZG9CaJ1FS8ZJV+n2pBJ56GTkZyns?=
 =?us-ascii?Q?SHMxEyL9z8huHwTymz2L2okbcdBADLCH0+zsanQ7mOlmfS05sYPvGn87DYE4?=
 =?us-ascii?Q?e+EpiH91UUwU+B5WTzjItYi/UzJb0xJHcgfyhDq93VDzUN6OlBhMTMT4UVpr?=
 =?us-ascii?Q?9/64n0qEV6t1orCgICrYpvlr43rZlsoymnLcLo3H952aUQI73gNWYufR7odb?=
 =?us-ascii?Q?0s7UuWTc32FF8minpxIso8pP5dnVsIbHrvYt0fj6SOd4cN/3C75bPHZiSzbr?=
 =?us-ascii?Q?C6f5zx8IbQCXYzUjPVh28EL1bxxFIl2nN8EeqOmXHdyHI9LJ53Ssvw4UOYvj?=
 =?us-ascii?Q?0BW3mumFiD1vzfn7+wD4CpK51Zf8vAO6PIo6AovI+37zSW0din17ArIeYvps?=
 =?us-ascii?Q?tGGRQORLsAyN9GhWLtoF4wtAMa7rgLP9fh81SJALnlRS7JBAOcT9Xi4I3jTz?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?oRsU+DjUZN8Sg3ZSai86u4SNul03eKGQgSyLFTyPSKbpYhKwFo3CMgZIhnt6?=
 =?us-ascii?Q?AwWls8AKNX0hXVAeLpyZEjrXyVQJh3v9JQIDnOs8cxZ+j0W9PZTHD/De1g4C?=
 =?us-ascii?Q?Um1Rlx2qpazgBkTc3alAYk/MHtQ5J33Brj/E6Q/06TFuSlwykIKinubkhhEj?=
 =?us-ascii?Q?O47ecNUHtucMXw4TwMaXnLklMnNIOc8iXoXOc+VtE0IJpz17Cj8xB4j0Z39k?=
 =?us-ascii?Q?OaQINHsxl+mwL8Henl1TB27ALEMDR2PLcXTPkpqLkI+P/g9QwULx0B+iOOsT?=
 =?us-ascii?Q?S5tCUN8pOXYd5RWebrQ3CzBsS85OSxQ8PIl3lsK898cEyY/r1gj8/7oktRS9?=
 =?us-ascii?Q?561rdHP1QkzSElAks8xG/aH9VAFZtLpjQ0WeyPb/E8iIIsWQUf8t7Ebz0vmf?=
 =?us-ascii?Q?0dYIxVIUX79qKgaiEyVQo/wWLdoLv6bDSN+uLxn8MVPpZzj0NJYip2OTSEXB?=
 =?us-ascii?Q?UJZgxzKcSTR41tGvTU6BOwJtCZfFqMirqeyPzEF2Ktdc3S+koEL1w34rKNhO?=
 =?us-ascii?Q?5mtV8Fy2opSy1KmA6dlqud2Vo5gAu9MHjincWGUOswPrpCdiGghPshHTdjSc?=
 =?us-ascii?Q?M7/l3CFADsubYxLPOK0OU4zjKW3F/m8yjLdyFXQtQ6kYwkJPz8D8sOPqhXrn?=
 =?us-ascii?Q?qhnlEAMJZqTdWEx3Ltyr+mNwZNbbKNHEX25LMrPKJ0ySIM4X9Dnsl2PTOOK9?=
 =?us-ascii?Q?+qJoMZ1dCYifMtG/iQ/NWgg1mMgwNyzR4YCIr7QT0QLaNGXKXdGoYZiKcH0s?=
 =?us-ascii?Q?CNA/5lG2UhWuQPBtG2JdYoxWr+8PDblhNsVl9XtoM1dcal8yQz8j/l+ETxCs?=
 =?us-ascii?Q?gF7Qv/gfK9HMaPn8CxkqSPu+y0L32E186/fCQg8WBZsmgMKCzhlsYKBitiy6?=
 =?us-ascii?Q?Pr6GZ5AQa7Y6maQ/5gwY/6FhpXcf4zS1hJtKezQglc2KwWgsyj56mIm7yNxY?=
 =?us-ascii?Q?m6c7SFlyMERNjfjRG7GDf1weQMX7iWU/JGK0vBWyyWh9de+dh+ef/iQT0RA0?=
 =?us-ascii?Q?fcBZHA4W2ekAH+LLVL9gD6/LnXJxHCe6uipz3yXo71UuQWAgjwvSvBp+qh6I?=
 =?us-ascii?Q?X+bZ8W+Fi7x6HrZCxz5VP857Bn5uRqasCgBTFDOHlwrZy61dG7hPMLa0YQUq?=
 =?us-ascii?Q?a+ld8wPFwHtsNjA2ne3J0+gEeAvqnK+KjPtGTBFqn/AbbUZgt4ULpRk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6838ff9-c71b-404a-bb57-08db272d9f31
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 21:21:50.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4pSWli5FNA6OTnUhT2WkxZbx3Z2ufORVeoWSwmbELDM2a569yeYresd5G4m62KUNg8vRyDtc+SwRw4y7vz6Uhal9R8T5rvlmbOWcSkw1VE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_17,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170150
X-Proofpoint-GUID: 1IGPnSx0-6mOGM6z63ckCZ_Kxwecq6AH
X-Proofpoint-ORIG-GUID: 1IGPnSx0-6mOGM6z63ckCZ_Kxwecq6AH
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

