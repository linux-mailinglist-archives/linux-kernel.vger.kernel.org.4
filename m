Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09AC642CDC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiLEQcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiLEQcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:32:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06EE1BF;
        Mon,  5 Dec 2022 08:32:32 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Fg6TR031678;
        Mon, 5 Dec 2022 16:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=+PWnuWlUsPw7MWHnPVaAWUa0k6uSZaqwhUEVP7LTtjM=;
 b=nWklaZz6W6p7kUxmiAgWdOhxPoPKH70+bWh7v9+VA5vH/s7ShkY6YjNWmjghLupPqCp0
 n8nDwRtAFFKS63s+RYaBYj5CiMHUV720A49BFBHFntp/caMQvTRAdfCCyAt9WDCMUXI8
 L2G0OiCPKE3EG4RywfyuuHao4JRV7lM4rO1LpU2kHednvW036Mr/Z+OLiFOmuZoVvhAU
 V/lmD8jHsQxQAluGWe+eYNqzV+l/26MLvYWKInL61M5XmvdtTbmH/75wP+3ggtrRXNfV
 Xlya+4mkA/eXveMH91R6G7WKK5CkxPQDxnAfEs7OP0R5eVEsd7zMKZQZUt8JMW5biIud /g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yeqm9v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQwhx018886;
        Mon, 5 Dec 2022 16:32:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m8u9y57fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLRGq7cOlqa2IBMnqD9Ia/WoEeE0SbKvv1+BpDxGdBBdMOeMpi+mGIAny1wAU5GfilTol9CYyHVNNYMtFMM7dnHTO4b9R2EHRVtykgZ34gIf4QOjveWHh0aoAEdi4nvEBg+NmTw1yI9iLnAFy3EVy+yt8aeCQ8wat7ADphOYM1w6YG+Y7w/+OvjYxui/BVQv9Mjgl46ibP6Q3bwwRAtyxeOWuw4MVbKt3KZbDLTf7c6Z8BcSwPZwVMbWvtXrBbHaW1zBZGlHUDnQW6n5gnCYqkjn+E/AZWaG6tin4tmFQ2lh4CRhIfe0aN3nKgr6sqMJiebHzDXJL/52MvMfnszfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PWnuWlUsPw7MWHnPVaAWUa0k6uSZaqwhUEVP7LTtjM=;
 b=AedL+9akhWRQbn3fAFImZZ+GbXjzYAdsbWP7Ez6eFHTpcmqOUeW6EKkjLxDLe3leQjDbtrezhzHR1nLlu0eoMTdJTD42qns3Ls0W1R51jdt6axYHIBk++ROv4zbT4y8FSfw5/U2t83262SwFfcis2XP1EqEC4kNPa7ng/pjjOyarxLZ6JP+vBRuOL3MGwDar6oRWEM29I/221XtB+Mum9ZFBshv6tLQq0wRj7Il8TLCM5CYh9gRjQGwz9nwxfcrk7bM3alP+Ug55L07Yt5dycZMXBWTc3maGJUGptm8QqskPuSc4AK1WExgppJrS8JDSXclSFyxGuO3oQ/xrYOIiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PWnuWlUsPw7MWHnPVaAWUa0k6uSZaqwhUEVP7LTtjM=;
 b=NN7ZEPVFcsZ6YgFHT8fNgDwsgBNC1/fCFgvU1NaiR+sIGE+vFqe6yquJxDOs6IeEU364p6Q92hLiMU58t7Z+vB1bQBSDr0ht9lSbJ5AXgQWJUxPdfYLJeLECJa0di/H1IwGaxrTUHn0ZS6LJ3tgKCALgOr3R1zosHvGUZ2cKosI=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DS7PR10MB7324.namprd10.prod.outlook.com (2603:10b6:8:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 16:32:23 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:32:23 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com,
        Victor Erminpour <victor.erminpour@oracle.com>
Subject: [PATCH v10 02/13] kbuild: bring back tristate.conf
Date:   Mon,  5 Dec 2022 16:31:46 +0000
Message-Id: <20221205163157.269335-3-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0043.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::31) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DS7PR10MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0e7901-2be8-45d6-cc1f-08dad6de49be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQPdIko59298SyALpzTvo/kIhL0l5b0VbFN2nQA8leoM/qCxmkAFN7dbbmGLMtRUukvu7QiqL69QQ9jYJGbi/ysjpJlwihDCN2Fpu9IQ37Lz6aieQvOdsq4sH72DkhQgXzR8PkXu7+HNSTRIm4JD75jc0qJcjbC1ZnGgQ0u0+kpctHRH2BZtZ4RzY02NrlODzEc/jUJlZAPQt7swr12939OX3omGuKzQBqEdNY4+soehPZ4Cq73w4CXv377KbawPmpdeZx/byox+griZkbYh7LaGNkuOhlJA9lFU1U3niCQUkZBFM72IlGI8l0d4qhSUcmH3Dw3PepxlObTXrabSaL+ppWiHPkj3HvrRtYxR7aXhxuj1v8iQ9a3qLWygG5ECjmkod4LqSpktNTwgmf//iJ0ecgr5uQa3ui3+m2bEuMJG8aALOJf70aTxCrBIqFaACsVURizKucYK66dlrORJ1NsW8Yjfwm4xv/+j96XpNWTkOPsYdcs6alZDPgDwXCIIN4icvS/uamzLF01JAPRp2rAb+oAGWK81vGJDuzoWqkT1om/eRoZwlbapHmD7MBGmOM9tERr0e63qcc/EQp7937LW8qcU96T6Y9Bzy/kkHkpuAa9EHjyT4ggS96YVlyrAX8qCOoE4VL8GkTTRv6ey3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(86362001)(36756003)(1076003)(2616005)(41300700001)(66946007)(4326008)(66476007)(66556008)(8676002)(44832011)(8936002)(5660300002)(6506007)(6486002)(107886003)(478600001)(6666004)(316002)(186003)(6512007)(38100700002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JR+i6s30LK0a8QNy5qESuh6f0S5xbQHKIECi44EoFhQQSc7YjL+YhQkB0HOw?=
 =?us-ascii?Q?WUEu4yUdCord6g0P+eyZ8vt9VfbDFHZ7R5crBlIlAWeczXObQ/K/PeWh1VyF?=
 =?us-ascii?Q?moa5fMNFwMt+m+m0d71fSKHGOktcIYQHKW6ELduHplWP12H+FF4z1okRTJN8?=
 =?us-ascii?Q?WXQoMCINUzcKRnTSMvnVAo1tZdgrI/NoPeM2KNRCu2NWErTa5slPi3fiYjhD?=
 =?us-ascii?Q?UK4CvkONAYdocIacD58XroBfM1qSFke52JZvm5vgl0Ji9DXFHoH6ZO+PvbEW?=
 =?us-ascii?Q?IGVajkNFPVOZcaMSHPKSAqqsFqHDZoo7HwWF3FlAk0hzf+k3r1Q2k81yBibY?=
 =?us-ascii?Q?Dclgyy1wNlp2TWd/okgfU7YI0G8BziGbcEfaL7cZh/WGLTLRtEjrLz8G31vs?=
 =?us-ascii?Q?1co2E9F+53NgpNp5LruiWhQlMzeOd3vq1KOnU9KbmthxmUFPMDk8Ev9JVv6T?=
 =?us-ascii?Q?bW8D5pywyEApaH7KshVzX8hy9Pm6JlB5+QSZdASlGXAZ+HCrs0zkQ72CL/J6?=
 =?us-ascii?Q?gUS11Ag4SJ/5IcBdFp0IAYniPQRW7bgpxnCXoyxGMh6M5EtP8rN81pnexjXM?=
 =?us-ascii?Q?uQDF+xi9DCVyUUqDhKACI/DLU0LsGWUyBkRMvyU05q6uvT1wCX5Q5k5nNbGP?=
 =?us-ascii?Q?XBASzIuMU3sPJSHqaAqxUmo8QYyAJVYY36a9fM71w4M3orvtGTBKKGbU9hXK?=
 =?us-ascii?Q?jZjNfDoHoynYiL/561QNSaaj8xXFWnp7gr0b/y/t23a+7oGUhBR25EvSYxFv?=
 =?us-ascii?Q?WefFzpwk6BvOd5Zk/eO6jucssPNblbSUeJUq3JyDgmHoOZpwW4BD9dz1xcpM?=
 =?us-ascii?Q?6xitfHPSZQxw7MFIsK44bj0z6zo0cAlAaPOPs9v6AfmXR3+gFgNZ5u6EsVrt?=
 =?us-ascii?Q?TrX7RgZgKqpUZYs6vGYnqQUzUaj7TpGJo6e++66u7UeMusPto8oJjqIiyJIQ?=
 =?us-ascii?Q?ZXbbySdsIEOA4I57TlTz+jRdnZuFRE72z0FyMAQWmogyLcccX1VEkoZc+t1j?=
 =?us-ascii?Q?UwsKjp9YAhNO7j8pP5q+Hf3NO/+Z4m1UUOQ9IHsGqp3TxUJhn/PzWwR+4Abd?=
 =?us-ascii?Q?6+I/u6BsJUzpoPb/sv6AmNMTaS+5D/cKcEdPpKAnvsWCoVXKXtywmH5Dlp12?=
 =?us-ascii?Q?YPyQQeWDAeQla1u7NgHsrRS0Dmr2UVr4r2iFrfEGf3S2DTenlTOucsjMoy4U?=
 =?us-ascii?Q?pZPAciE2e8OSq3MJlfAxbThDqj43YrAUx+Cgkp4w5VQ45VuDgjy+dgEyX9lw?=
 =?us-ascii?Q?Ptj5RFxJngtG+Fbx2oWO33ReDy84DCDHzMo09E4x+N8zfMa85B0Wq7FeA6o7?=
 =?us-ascii?Q?v8BOyvbFiWG57hvCADO6c39mPfXlQaXVfhjrVt4/CJAJHiR0s23D+I0QNOPZ?=
 =?us-ascii?Q?MenEeKZLqwVuLpNyWBg1f7/0q4M9rviHNKiWNqhDRgUQHVHgN/TOuiWXei6C?=
 =?us-ascii?Q?u6tY9QR2mNzsCq1MnqJD9FsQc6ZR0Nw/rohK0aBZrA3RtH6dRGfFN/ZLbMQI?=
 =?us-ascii?Q?vknmOFccoZHMJaImGl5ciTNf3x9jzpfBTw8BExysBFFw4NaQ+wbE+EfB33Ln?=
 =?us-ascii?Q?EmAnjrdn3xyo51Oywj5C+Xr7lzgSO4YPk0/Lr05p6a2IsGnoJvpsAgbvFy3l?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1kpJMyRKAwz2ZbfhKGQGjyMWXHDu1YtPnb3BxujwCuhFGJLLvJdJZW0qFhiW?=
 =?us-ascii?Q?N8f2wGI4iEYY9nu9se1wyEWHBUIi60GXcVENPGC/OpVPnysVvT1jsVuisG7E?=
 =?us-ascii?Q?WFVJ16l83AZH+IqLBcmonrC5m4izhQW0uorVx5m4Jhv31O6gGCurragq3EHV?=
 =?us-ascii?Q?qykSY5TNnjBi3TU7OAWRcLAItHlv6/zOXnGrCrYn1nO1JM2sbHFEu+C3sIV2?=
 =?us-ascii?Q?Y6Qagy7w/DNyGOUsAq8fEOW0t7H6gpOpJHaq595CDcV0UDFJrir3WCwBd2LO?=
 =?us-ascii?Q?/Ufn0X0B2BcN/IZZZbpjbIt/efvvB/eOhh0Ev71PQg6vgMOqhWP3pTOPgeyp?=
 =?us-ascii?Q?9B5GG85THp60VmM3X87LJA+XdZfsI/JNsTcQrnTE6/VJ4a2mmyt87TzSMOdt?=
 =?us-ascii?Q?MPlc1NoN6gnqEa1OL+G64y5nN5QMV03TxZR6SeE1IfXmO3vl0Wj790aj0G6Q?=
 =?us-ascii?Q?+Kha3annInAgFusX5A8DfeAudWdhAdg5HrlyEhQ/ZMVlZTnqrSUR6OKTshhy?=
 =?us-ascii?Q?qHcuSF93ZGxdXU9yDND7zO46eNlfqgDnAINiSdjwu56yYpq8xVBqufNPt5QK?=
 =?us-ascii?Q?cXbvCL8j53bkqd13cf98VErCi0eZYy+rIEkeH858YQy5OuIlU2RoRBcf1YdN?=
 =?us-ascii?Q?GCiM09jgZFkVmLeCAF5dMC32wKaH4pb6BQz5Zq9Nxetm63Q3laJRjGPSBY3H?=
 =?us-ascii?Q?ehBfBpCMfnSDrhZhO6AZARdr3dVbYtxQIh8XAPqXPj2sSVptGUgQpRXaYL7/?=
 =?us-ascii?Q?cWUflYhMeOymcTjRtJFd8JdmMka95U231FPlCxR0jWdeSDHA95SD9qAB6Uh0?=
 =?us-ascii?Q?WgaEfH0s5DY7XE2wZMn7BylcKH4KW6WzghIa6srhVqQRtKfZta9nMmKiH22Y?=
 =?us-ascii?Q?WqwHq6yXTQKgs8paZoVx4kEmS7JqAQUT2Yti8ojEkiZOuH8z6aVo9qRcTgo7?=
 =?us-ascii?Q?8HO4J9FDJdoIqeLzH0SrXFgvzrhlRsh5n7qT60+Ex58=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0e7901-2be8-45d6-cc1f-08dad6de49be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:32:23.6390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVrHTGo7pdm0qngIkyzQ9FOK2G5M8UGQtPX9OcDOQSAxjq8HZ82LJ+s///tHq84K7AZeJ/DWok4sJNHYYHLlfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050137
X-Proofpoint-GUID: yC6XSEQWIfs6IS6wuwLurHjwfCy0aXjT
X-Proofpoint-ORIG-GUID: yC6XSEQWIfs6IS6wuwLurHjwfCy0aXjT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tristate.conf was dropped because it is not needed to build
modules.builtin any more, and doing so avoids one round of recursion
through the build tree to build it.  But it has one property that can be
obtained in no other way in the current tree: it provides a
machine-readable record of whether a module is tristate or not.
(modules.builtin.objs, just added, uses modinfo, which is recorded in
the source files themselves, but it is Kconfig that actually controls
whether something can be built as a module.)

So bring it back for this purpose.  (Thanks to the refactoring in
the 5.16 timeframe, this is basically a reimplementation of commit
8b41fc4454e36fbfdbb23f940d023d4dece2de29 rather than a simple
reversion.)

A verifier that uses it will be added in the next commit.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Victor Erminpour <victor.erminpour@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v7: rewrite in terms of the new confdata refactoring
    v8: adjust for changes in 5.17 merge window
    v10: commit log revised

 Documentation/kbuild/kconfig.rst |  5 ++++
 Makefile                         |  2 +-
 scripts/kconfig/confdata.c       | 41 +++++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/Documentation/kbuild/kconfig.rst b/Documentation/kbuild/kconfig.rst
index 5967c79c3baa..e2c78760d442 100644
--- a/Documentation/kbuild/kconfig.rst
+++ b/Documentation/kbuild/kconfig.rst
@@ -162,6 +162,11 @@ KCONFIG_AUTOCONFIG
 This environment variable can be set to specify the path & name of the
 "auto.conf" file.  Its default value is "include/config/auto.conf".
 
+KCONFIG_TRISTATE
+----------------
+This environment variable can be set to specify the path & name of the
+"tristate.conf" file.  Its default value is "include/config/tristate.conf".
+
 KCONFIG_AUTOHEADER
 ------------------
 This environment variable can be set to specify the path & name of the
diff --git a/Makefile b/Makefile
index 93bfaae45396..248f780cb75b 100644
--- a/Makefile
+++ b/Makefile
@@ -793,7 +793,7 @@ $(KCONFIG_CONFIG):
 #
 # Do not use $(call cmd,...) here. That would suppress prompts from syncconfig,
 # so you cannot notice that Kconfig is waiting for the user input.
-%/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h %/generated/rustc_cfg: $(KCONFIG_CONFIG)
+%/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h %/generated/rustc_cfg %/tristate.conf: $(KCONFIG_CONFIG)
 	$(Q)$(kecho) "  SYNC    $@"
 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
 else # !may-sync-config
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index b7c9f1dd5e42..160d12b69957 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -223,6 +223,13 @@ static const char *conf_get_rustccfg_name(void)
 	return name ? name : "include/generated/rustc_cfg";
 }
 
+static const char *conf_get_tristate_name(void)
+{
+	char *name = getenv("KCONFIG_TRISTATE");
+
+	return name ? name : "include/config/tristate.conf";
+}
+
 static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 {
 	char *p2;
@@ -670,8 +677,12 @@ static char *escape_string_value(const char *in)
 
 enum output_n { OUTPUT_N, OUTPUT_N_AS_UNSET, OUTPUT_N_NONE };
 
+#define PRINT_ESCAPE		0x01
+#define PRINT_UPCASE		0x02
+#define PRINT_TRISTATE_ONLY	0x04
+
 static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
-			   bool escape_string)
+			   int flags)
 {
 	const char *val;
 	char *escaped = NULL;
@@ -679,6 +690,9 @@ static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
 	if (sym->type == S_UNKNOWN)
 		return;
 
+	if (flags & PRINT_TRISTATE_ONLY && sym->type != S_TRISTATE)
+		return;
+
 	val = sym_get_string_value(sym);
 
 	if ((sym->type == S_BOOLEAN || sym->type == S_TRISTATE) &&
@@ -688,29 +702,38 @@ static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
 		return;
 	}
 
-	if (sym->type == S_STRING && escape_string) {
+	if (sym->type == S_STRING && flags & PRINT_ESCAPE) {
 		escaped = escape_string_value(val);
 		val = escaped;
 	}
 
-	fprintf(fp, "%s%s=%s\n", CONFIG_, sym->name, val);
+	if (flags & PRINT_UPCASE)
+		fprintf(fp, "%s%s=%c\n", CONFIG_, sym->name, (char)toupper(*val));
+	else
+		fprintf(fp, "%s%s=%s\n", CONFIG_, sym->name, val);
 
 	free(escaped);
 }
 
 static void print_symbol_for_dotconfig(FILE *fp, struct symbol *sym)
 {
-	__print_symbol(fp, sym, OUTPUT_N_AS_UNSET, true);
+	__print_symbol(fp, sym, OUTPUT_N_AS_UNSET, PRINT_ESCAPE);
 }
 
 static void print_symbol_for_autoconf(FILE *fp, struct symbol *sym)
 {
-	__print_symbol(fp, sym, OUTPUT_N_NONE, false);
+	__print_symbol(fp, sym, OUTPUT_N_NONE, 0);
+}
+
+static void print_symbol_for_tristate(FILE *fp, struct symbol *sym)
+{
+	__print_symbol(fp, sym, OUTPUT_N_NONE, PRINT_ESCAPE | PRINT_UPCASE |
+		       PRINT_TRISTATE_ONLY);
 }
 
 void print_symbol_for_listconfig(struct symbol *sym)
 {
-	__print_symbol(stdout, sym, OUTPUT_N, true);
+	__print_symbol(stdout, sym, OUTPUT_N, PRINT_ESCAPE);
 }
 
 static void print_symbol_for_c(FILE *fp, struct symbol *sym)
@@ -1207,6 +1230,12 @@ int conf_write_autoconf(int overwrite)
 	if (ret)
 		return ret;
 
+	ret = __conf_write_autoconf(conf_get_tristate_name(),
+				    print_symbol_for_tristate,
+				    &comment_style_pound);
+	if (ret)
+		return ret;
+
 	/*
 	 * Create include/config/auto.conf. This must be the last step because
 	 * Kbuild has a dependency on auto.conf and this marks the successful
-- 
2.38.0.266.g481848f278

