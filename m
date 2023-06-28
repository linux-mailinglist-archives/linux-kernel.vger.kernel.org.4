Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE31A741860
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjF1SyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:54:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60978 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232259AbjF1Sxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:53:32 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SGx6o8006757;
        Wed, 28 Jun 2023 18:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=dQejAYGv2H1JUTWNdtQZvoo9JVQ3oX0sh3+sTuDyzRQ=;
 b=HombQ+eNOPsqPghdQwD6thsZEeQjBiNmyG7EnLYBSPmnRceKKM0rrWqA3azxZwlnTKkb
 uGokOVCSpAlk0HHNKzZDcviB4+fWRKKc6FBfuJsfS6IMmmZZjAz7PhfjAfFrb4CLRLpG
 Nph2Zf5bfo5QsApVU3b73ommvlDe/vTb/fBzYrVDfWDm23ozSxO68MhMjmEGjfBryFts
 x9oieIqm3qKvGc0Aw/sd3HbNi9GWB/tPrj2QBPUjgP4cceY/8a5tG6Yfhga3fQI5kqgd
 VAV7IiNH0N7Cr+pmszMw6dBV9zND20f2Q6SUkD1s/hgt/z4JCcReIQFVCBv83Dzx83BK qQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq310pef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SHe4Ke004035;
        Wed, 28 Jun 2023 18:52:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxce4mc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/33d++ySfunQFmTRdjPxGkX6dvU+ACzwnUMSvlicKP7/vxJosmCwoL2RjWnpBsHgX+HiqEKBF6TnovZj5EaDPpm2pEeBddoqB0QEDlPjIWJWeBHTBs7Cw41xuqiBlaiQekKLf6KQgZnXpaq2XgL3P75t13cbbVxef63a7IfX+DOZPTpDP9MYeNiByTptqkpv06jEnBE9AENGriCTMp4W15AIo2OnyL6zSF2gLdvDqES4yqmNxoCstQuXScBKRDiBkssbnjjlhb5dwtFhMQL7u3KIjC9TeS7ueiqMIigKV2wvwoun5/zJhWExi+01UAnkjwzIg3Cq2/4Jul23joX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQejAYGv2H1JUTWNdtQZvoo9JVQ3oX0sh3+sTuDyzRQ=;
 b=D9hQfYzOxV1x8kor0GnF/J+P69ER14i2f1jf21RXSg09cakDCrkGvE7ggp0BYGEYHnXEp27+8Egd1eeoepSxA8qdOd0pjGnvVyU00xeSzmiBPkx00b608IBBN+c3idU/l88aKOvBIPGDZ+Ehz3PIHWRThlbVm1sTGvnuGq6XaItFFwCrQC+14Oo7TQPG8hd8rL9gaFx0VneSOLnpYSnP3GlRY7Wlx/DkJxfB2AtaJSSuRg0GfxUvHi93lluUVvv8Eq0bMyNiBu/n2rebmVYoWpJYblU+eNHu+rfCafHlt4Kw8PWrYnsJrMC+ABqt3eAg1OjLnnpOHvtvVPLV8KGEJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQejAYGv2H1JUTWNdtQZvoo9JVQ3oX0sh3+sTuDyzRQ=;
 b=WsIme2FnQ9GzwhcnmcbqVkqCyjDBeC2ed5lectcqbnpsJ/rn++70gPFnyWAvVHPlVqR0u5oq3btxnhwTitxdB8J+SEM7epjgYc97M39l3KVZZbg6nFcWj4aR9En1T9NjU06SPEWrYc8F+ZShKhraj92X8L1c4M/xdfCPWPGh5NY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 18:52:27 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 18:52:27 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v24 01/10] drivers/base: refactor cpu.c to use .is_visible()
Date:   Wed, 28 Jun 2023 14:52:06 -0400
Message-Id: <20230628185215.40707-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628185215.40707-1-eric.devolder@oracle.com>
References: <20230628185215.40707-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|LV3PR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa4aea2-2df9-4640-a24a-08db7808d1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+eWqSd0sy/pq0RONHW0oOz12baVBf/3tA1Oft+a0v5lij7YM2nf0YfFA9b59cTBGS1CyL75vaWccnSt8g6j9sFA3CsGBZI+BVKwCnU+8bWbhGiHTZKKJMI4bpn7k2j6/f+NCwJbKpkhkzYoEs5fGXWUf+7kWTb9JSJNlvUJz5Q9NXo6fkaZdUAnsS3CYHpAo4eVlNJMo/rZMpucEUF1LmN5qNjE8fXL6viLRxK6VN6APAa4sZl8R/+ZCrdwltoKeBXqbMwLoNKxg1I+4/J8DpzprbzCTW1Hy8W6FuOI0L6vplaF7/jnSxEQemBaiZdD09wi6NX/mGVGjkWit9+QRO54JY21/+Yiw8b+RilmUDsrUOK+TiXZEpjjUrWGdLCwsVII5cb0Is6G9WDDCWjVYPgtoQV+1DMD5l59XflgCdOILJG/0bDbZfdgfFLDcDVwe643eqnlNzIvPk2pTpgYnNUAsN9qRupFtxDyl1aMD5RorUfDhEJOTwISigOPIisjYQp6iXguYGF+1qByg6BI6w66jhFLaxtnA2CFDnA/4vkNt3dPaEopqky+/Qa0RtfriVcewFugtOkoHzzLOyX5SBtstxQUazGtivKE5OByiWCyGHFZmlXs/gHmEz9DXTWw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(2906002)(83380400001)(316002)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(186003)(478600001)(86362001)(107886003)(921005)(2616005)(66476007)(41300700001)(8936002)(7406005)(7416002)(4326008)(66556008)(66946007)(8676002)(36756003)(38100700002)(5660300002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mq3drL/U4UjBiuoIpOg+pJ5ctcfc1o6YTxu1x2j75t9ZDxQNo4170nX0HaIH?=
 =?us-ascii?Q?KjSILMAVS3yag6OGTU5SJanpQ1GQ2vfEssfmg/ou2Caac2eAqFoXDpuv0jFj?=
 =?us-ascii?Q?vup+yPvnT6hqNZH1ODxdR8h31KS0zYGsPoPG8jhG11rWnICjZKC3banepKkJ?=
 =?us-ascii?Q?5pK3whmsuxuZQp8XZ7eX5Bp5BshcyRIpdqyJFnCrMkCWnsaGlG4XOP2hSvQL?=
 =?us-ascii?Q?2Xnck1Z1YSQ417dmhX0W5dnJRBtgOP1gZxPqR6DISFV4WKLS4smOA+T7hPrK?=
 =?us-ascii?Q?lWTNM7ZyfH7M5uLgTWf8DUfVO0+cdCtBxbMmJvZ8g/OuEeumSc7+G371lIrD?=
 =?us-ascii?Q?1iRpsf6qVQ6FXnq24eBF0ARXSL9PFWXzX1nNJrp1Wnf9FayaUWS7M8hAbAXH?=
 =?us-ascii?Q?BpTqh9XJebSUk3JuR7TIdzYR5xo2FHe0kcXagSXM7NxmEL3yDUvUWFQVQpvS?=
 =?us-ascii?Q?7QPJMei8k/ivXrV3P0CKJPms5zNo574DkwUtAwj1bkn/mG5Ach8dsu6Rn1Hb?=
 =?us-ascii?Q?BOMtSIpiM7GpWBxvXVOZ/dMdJwn0YVe0gWLcmKHJ2JJueBOgII9YPEB67i8r?=
 =?us-ascii?Q?ZV4oL0dtxZSpybE1UHW0Xs1iULh5IcmOjR8GhQXWJr/DENf9SyJS2wWOgnsK?=
 =?us-ascii?Q?in7XMXMWUvdcgfDTdtRvZ+AoEaEJHm+kw2Fk5Bsix09MWkQOtkJetUeWCxVD?=
 =?us-ascii?Q?mnO0gP173SEB/CoPAPGKE7evbvaTl0KEBVvV7j6FnaaEebBcGcAXntTefZMa?=
 =?us-ascii?Q?FzRXMQGdDLsDXEjZogEOQZRyIa4bQuR38hElT/LjtFq/ljjKHLog8YxQEAkH?=
 =?us-ascii?Q?lkPBZVBt9K/b4gIGyjNTOKLIB80KBYEalKxTW9AwlFdEw4B4zipQe/xC1cEQ?=
 =?us-ascii?Q?ITEna1JtP2/WVj5D1RbNlLlARwWuOK2ldNTT5gevhcOTyYNX3rG4YV+RtgMk?=
 =?us-ascii?Q?QPGCVek+qotCXq5O89MpWgnrYmwGmbGI68lvtE0O4o5YftA/VSwkzorvpqa0?=
 =?us-ascii?Q?Wn3Yt5h1IJAqwrhuMwdjn+t1HOQNuu7vqySo6TPsa5xTihlq5kQq+iLYJ9AC?=
 =?us-ascii?Q?JQ6aABKe1yzSu5pZln3pUAfmj/u0NSKxuRfZlyVmY8CU3d8s4G2QmwFTDbF6?=
 =?us-ascii?Q?0y7guhfvb6QObpHO3/y3vnkMuAwYsFuFeX6S1WbM7k4DlXtTxEm6K5XnE5IZ?=
 =?us-ascii?Q?ReCoo3JMhZulFTK6oi+OY3z8LVvmoZZdX8vzEayzF6Roq1DHPTN3ebfeCxDe?=
 =?us-ascii?Q?Pzpd2VaWddp9h+TvwNKE9AwHaBi6oZsG4vCOPN8Pz2h24HAKc51C+GBpNNZv?=
 =?us-ascii?Q?vsH55JBA3XijWQu/MsfgfTw1b0zVB43lc1yE/w86S9py0xrDBd2BCYSkHpJw?=
 =?us-ascii?Q?ra347eypRkc0/31jSolHDkWrCqJ1/G/7jH+ylg7S2qU5B1dZV1UxW67atYip?=
 =?us-ascii?Q?MfUCqkMbF3jbIfY4a5OQ9XTPwW26WnKaWvo2qU60G4pwZodgXhsAyD52uLrN?=
 =?us-ascii?Q?ezyup6zMm8Jp8XcH8TDf7wn5TwN83obl2tQGdyFoM9kXfe87UVUJV1YQQX8h?=
 =?us-ascii?Q?SgDGVY+yYsXdVgIpbxFk9C2LhmMgTQ84XwdsLfTX4UFf+K9RQuVfKeUSRD+z?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PRvJOnj9PCd0Bo92zObOYNIP//zaq1+AIpHBbwTDCAZ37D/fVyYHbBsbotgL?=
 =?us-ascii?Q?C7R2t0PQ0m3L31nx5Goz6SENmu7T3KQWjnN1wPTZAsIxC8asrnTgSuR9s3GC?=
 =?us-ascii?Q?ePDajXZZVecPIxp1kMNqu08jQ/lnFxj9ZGKTdJR6wpDT0pqNBT4KUyEBqhuU?=
 =?us-ascii?Q?gZH+ID5sjhPNqqVb98JnF2+VAhIbDrD0RaLi83iYGXL4YrPg68sJAr97TEfH?=
 =?us-ascii?Q?YubMC+iTX279/EBfkU21OfF1gWpNvUSnrrL9u8vqAnrZw7LlhVk82wgh6iR3?=
 =?us-ascii?Q?To9jkdM5ip6x0eKZufh9T3OBVGRHi6yIjuztlB8y4RepS2H9XYW/QMQvp1SY?=
 =?us-ascii?Q?jcdAZmmZlXuWVKHyis1D9Cuh0o8+oItSWd4pcy9kG4M/NyP0EjlfpyZemMWw?=
 =?us-ascii?Q?uM+Iti1vX1ZWBfRbmiHgwkqXJfkgghYWD8Z6k0vicKvhpy4vsokv3h6/pyev?=
 =?us-ascii?Q?D/92ugcDIq2SOngIGE86ddxC/3tbItgO5tXoQpLxfbprqhugYGukJaijgBMw?=
 =?us-ascii?Q?VSFGJoX0Spyzt6wwcox7UwA4ptgVh3OWFD5DG8GdRguj3ssBPy/6rwgRUvBv?=
 =?us-ascii?Q?3nrlEIRPW32TcmVGOYsu5DnmlXqEEFA3J8j/ZBqMGHps/C1/ZKIQIh8l4Wm5?=
 =?us-ascii?Q?oCZNSuG30sQVNE0vczXCKoSLGGRmkpiwQD5qdXB73lUQgfKQbzVaOFnbSRxU?=
 =?us-ascii?Q?wrgaxtFiU4TGOSUn1bQmLIOHstJEE5KizzgfVFNBhZYfxoUTSn8efXISGH4W?=
 =?us-ascii?Q?IaZN6aMDIWLs8zkkyRmiySUvZPG47FIApYWvzPAvv0Y15vOaGGJ+L7Pwgk4u?=
 =?us-ascii?Q?VWXPgdKkZHgOlPX1AfyWlrOOvh1MF9IAMcNs7xsj3hjNnU+oDP2WtK4axuzA?=
 =?us-ascii?Q?qpP7/q7Ek8Iet6jlKbU81hT/pWyx4h6A0P3E6B4q5n+N1OBPFdwuGenOjwjk?=
 =?us-ascii?Q?MoEJy+/gC7hXSfimYQZtqfZ/jiFOTznGLBzeeZftzn2ZQC5N7uqWhsA/dGYM?=
 =?us-ascii?Q?5oDth9Xa/rkG+t+Lpt3DwPLwF9AeZXsk67iCENyhOazMUmHsJCl1ViRMMVs2?=
 =?us-ascii?Q?830NrNUrG8ElEXlRt8TOhcPegWFtCgykKsnsoSvZvsTnm01gprMcL8GUp+h0?=
 =?us-ascii?Q?4GyxDaj3wP7nFk8C+/cqyx9tY6kLVnK1H02fepJQgJhehBXE/4LYR1kuTOyA?=
 =?us-ascii?Q?XmGWHVG3xsPmqpkPh6q4hamCH+AS5XF/8/qBtsD0h3Ks2/f0EwJOMjA6bGXy?=
 =?us-ascii?Q?1XMtpCXXrBW82k66Uc3rXCzVCsM1sadxsP2IYJTRukuAqNKJHUZy6Q2eg18f?=
 =?us-ascii?Q?gpxwAU89q4AOm/Kp7CakOmuqOsFLCJeofEqjJa6d7iMfxzSWciTDhYMAOqTF?=
 =?us-ascii?Q?wxJCpkm8NLQ3H4A60yDD4jC++ohTofedVGzq98QB0rwbwklNJYWB9aC1BCtl?=
 =?us-ascii?Q?aPOeT9HcPRc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa4aea2-2df9-4640-a24a-08db7808d1ab
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:52:27.6903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcdwKapL7HyiDgESvQl5GsFgMPIqY9BCOiLroShHr1HpKIWw77EssmSurKac3mc2ZGiopKhh2fikCwTtyCmlK2/LeY98uIvIERguDhjXj0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280168
X-Proofpoint-ORIG-GUID: oEXffXnd2Y81TX2BViXK3FOWUDQGyxbc
X-Proofpoint-GUID: oEXffXnd2Y81TX2BViXK3FOWUDQGyxbc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman requested that this file use the .is_visible()
method instead of #ifdefs for the attributes in cpu.c.

 static struct attribute *cpu_root_attrs[] = {
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
    &dev_attr_probe.attr,
    &dev_attr_release.attr,
 #endif
    &cpu_attrs[0].attr.attr,
    &cpu_attrs[1].attr.attr,
    &cpu_attrs[2].attr.attr,
    &dev_attr_kernel_max.attr,
    &dev_attr_offline.attr,
    &dev_attr_isolated.attr,
 #ifdef CONFIG_NO_HZ_FULL
    &dev_attr_nohz_full.attr,
 #endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
    &dev_attr_modalias.attr,
 #endif
    NULL
 };

To that end:
 - the .is_visible() method is implemented, and IS_ENABLED(), rather
   than #ifdef, is used to determine the visibility of the attribute.
 - the DEVICE_ATTR() attributes are moved outside of #ifdefs, so that
   those structs are always present for the cpu_root_attrs[].
 - the #ifdefs guarding the attributes in the cpu_root_attrs[] are moved
   to the corresponding callback function; as the callback function must
   exist now that the attribute is always compiled-in (though not
   necessarily visible).

No functionality change intended.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 drivers/base/cpu.c | 67 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 14 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c1815b9dae68..75fa46a567a1 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -82,13 +82,14 @@ void unregister_cpu(struct cpu *cpu)
 	per_cpu(cpu_sys_devices, logical_cpu) = NULL;
 	return;
 }
+#endif /* CONFIG_HOTPLUG_CPU */
 
-#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 static ssize_t cpu_probe_store(struct device *dev,
 			       struct device_attribute *attr,
 			       const char *buf,
 			       size_t count)
 {
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 	ssize_t cnt;
 	int ret;
 
@@ -100,6 +101,9 @@ static ssize_t cpu_probe_store(struct device *dev,
 
 	unlock_device_hotplug();
 	return cnt;
+#else
+	return 0;
+#endif
 }
 
 static ssize_t cpu_release_store(struct device *dev,
@@ -107,6 +111,7 @@ static ssize_t cpu_release_store(struct device *dev,
 				 const char *buf,
 				 size_t count)
 {
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 	ssize_t cnt;
 	int ret;
 
@@ -118,12 +123,13 @@ static ssize_t cpu_release_store(struct device *dev,
 
 	unlock_device_hotplug();
 	return cnt;
+#else
+	return 0;
+#endif
 }
 
 static DEVICE_ATTR(probe, S_IWUSR, NULL, cpu_probe_store);
 static DEVICE_ATTR(release, S_IWUSR, NULL, cpu_release_store);
-#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
-#endif /* CONFIG_HOTPLUG_CPU */
 
 #ifdef CONFIG_KEXEC
 #include <linux/kexec.h>
@@ -273,14 +279,16 @@ static ssize_t print_cpus_isolated(struct device *dev,
 }
 static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 
-#ifdef CONFIG_NO_HZ_FULL
 static ssize_t print_cpus_nohz_full(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
+#ifdef CONFIG_NO_HZ_FULL
 	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
+#else
+	return 0;
+#endif
 }
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
-#endif
 
 static void cpu_device_release(struct device *dev)
 {
@@ -301,12 +309,12 @@ static void cpu_device_release(struct device *dev)
 	 */
 }
 
-#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 static ssize_t print_cpu_modalias(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
 	int len = 0;
+#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	u32 i;
 
 	len += sysfs_emit_at(buf, len,
@@ -322,9 +330,11 @@ static ssize_t print_cpu_modalias(struct device *dev,
 			len += sysfs_emit_at(buf, len, ",%04X", i);
 		}
 	len += sysfs_emit_at(buf, len, "\n");
+#endif
 	return len;
 }
 
+#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 static int cpu_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
@@ -451,32 +461,61 @@ struct device *cpu_device_create(struct device *parent, void *drvdata,
 }
 EXPORT_SYMBOL_GPL(cpu_device_create);
 
-#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 static DEVICE_ATTR(modalias, 0444, print_cpu_modalias, NULL);
-#endif
 
 static struct attribute *cpu_root_attrs[] = {
-#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 	&dev_attr_probe.attr,
 	&dev_attr_release.attr,
-#endif
 	&cpu_attrs[0].attr.attr,
 	&cpu_attrs[1].attr.attr,
 	&cpu_attrs[2].attr.attr,
 	&dev_attr_kernel_max.attr,
 	&dev_attr_offline.attr,
 	&dev_attr_isolated.attr,
-#ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
-#endif
-#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
-#endif
 	NULL
 };
 
+static umode_t
+cpu_root_attr_is_visible(struct kobject *kobj,
+			       struct attribute *attr, int unused)
+{
+	umode_t mode = attr->mode;
+
+	if (IS_ENABLED(CONFIG_ARCH_CPU_PROBE_RELEASE)) {
+		if (attr == &dev_attr_probe.attr)
+			return mode;
+		if (attr == &dev_attr_release.attr)
+			return mode;
+	}
+	if (attr == &cpu_attrs[0].attr.attr)
+		return mode;
+	if (attr == &cpu_attrs[1].attr.attr)
+		return mode;
+	if (attr == &cpu_attrs[2].attr.attr)
+		return mode;
+	if (attr == &dev_attr_kernel_max.attr)
+		return mode;
+	if (attr == &dev_attr_offline.attr)
+		return mode;
+	if (attr == &dev_attr_isolated.attr)
+		return mode;
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
+		if (attr == &dev_attr_nohz_full.attr)
+			return mode;
+	}
+	if (IS_ENABLED(CONFIG_GENERIC_CPU_AUTOPROBE)) {
+		if (attr == &dev_attr_modalias.attr)
+			return mode;
+	}
+
+	return 0;
+}
+
 static const struct attribute_group cpu_root_attr_group = {
 	.attrs = cpu_root_attrs,
+	.is_visible = cpu_root_attr_is_visible,
 };
 
 static const struct attribute_group *cpu_root_attr_groups[] = {
-- 
2.31.1

