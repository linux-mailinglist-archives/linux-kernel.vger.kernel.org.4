Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9047A6A5D01
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjB1QWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjB1QWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:22:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09C22BEC7;
        Tue, 28 Feb 2023 08:22:40 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S5rJBE026844;
        Tue, 28 Feb 2023 13:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=GwLSeAwMdwHmoyImE/D41CmqibV3Oaat75HYqpuvf0k=;
 b=dNX5F1/pAugv6upSh2qs1rq1iKPp88K1/5YbirrH3rpvPoBNtMaHkl5VqapmPfweRha2
 SXvBn1YlvCvhj25Iau8LYZR8/y/XrbnjZwIeU8mY3Iq39VM/RGLD7whx0aSirYbAYMzb
 jlt/ysi7kncJe6sCD4paVXNNxrSrbYlYodchjko89wymcA8FztF+A9OVulD2y/RXcfpe
 cXvZN+QgLoea34Pp9ylvWIj2F02PSnybWSWWVF4Mo4Vv4QHhzc4u6IchzB5HU1JLljkP
 34cLb5PwugRDvZ4CKjUs8eEI8VCZ0SsWTFImEL/Q5hl4jqbHsL3f+GnPCeim2QmonETE Bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9ae37v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SCY4sW001116;
        Tue, 28 Feb 2023 13:03:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s6gfp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbGGS8e6Js8SgLUEkYDYOlXX/Ojvn6hVi+NtPY4Tm45Crkfu+45WTpsu6GYA7RtGW9R1Mb0PUxHwhEmLSgGGab0FJ0STpvrsXg0WaL2j9co0SSQkcrcg2DDaj3Dnd5N5W9fsXiR8nBkWHzZZ3LCUVNoXNLBgLo1RnAXCXqAjBvLkCGhwz88b756IEHDn0b3TOgMlKpcBbNmcZJN3p7YPsS0xMClFJcdykmsh8jLReVd72/8ZrBHAuRxJ9xl03H+ShHlp16Q94xkKUICzJFw6DEtNWldeeFqIJhdrGgXWgTXoh965dgV0fDIQIxxTLsAeCCcAhSLcNO02AqQ7MUXXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwLSeAwMdwHmoyImE/D41CmqibV3Oaat75HYqpuvf0k=;
 b=gJQjHzEqEJmwODEh1RpXtVf0jlL4G8Qr6965Hw73lmwtS9ii+NV6O2DZVzPzvb30HXOsh6lSh2j//Ic8z44zcjzlRPPej2TjBEPML9Z62WcbrZLVmaTvh2n+6Zym9HX3SqRs8wWmOwLrZYrLuwU8oLnmR9J0pSpn0k1/rwKVJzXcMBVJUdKdBQz8kqAAlYwAPMCrQa19foDT5cu07uxQGGR+hZ9cvc8BWwDJIlvtC9YdnY/i+NXNLVSHwVDE1cUfcCtERrSsnX5QVa9cvDnxCZovnue1I8sdGl0hug0fKz+r0FZqOmUSyagia92HjwkGdqRvSAktDtEyzQ0wd5F1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwLSeAwMdwHmoyImE/D41CmqibV3Oaat75HYqpuvf0k=;
 b=Rg9MgZIgGqg1s217hGZQNoJWqmO0qtkivljeE51Q//lb8qxoJYrX8BesT9CQmr/3S8xJzEBs4qLXkc1r2evLHUtjD9gniEeHmUPb+1b4qATgcvmugL5Ctei/NoQVBGmVWdOKFfB9ITvPWsyUUFlcpjA8exa0DowETL0Emo2Zq/s=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 13:03:33 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:03:33 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 15/20] tty: serial: imx: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:10 +0000
Message-Id: <20230228130215.289081-16-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::32) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: 792acebe-98d2-4bfa-6744-08db198c3246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wm9FET6fkdXM7rs3Adl9//QCqjWLYqjdbhgH+T6Rttspo39feBsx2OA08QS3NfogzdHhTUpCfNVrVrsmc5iyhb0kCbD8ObcGi3PG4k/N2rkFe8tARjGoblgHbjKldcXyNqLYiS57eT9Z9AdC8OpFX8AL/OqhdFwHyRGPulc2QImjURp50JfNvdIng0RapqAjRh6XUqhtwD0T6jumNkxbISK7jCJdLMg2zfzbBQu05CkqxWn+1vPWVBSKNU7AOoMAGn9Wscd/KmuVqTDZ7w1dv5ti3I4Y6/3GPfDv6+qpiGxEhnC3fccTcV/eh3sId2kuaUabZFvX+CMejXQWyKsgvdfKS4If7yCLlUTML89AOqAamofias2Ok3jNaChBUbZ6eBOLza3aHMmB0LlaFiaTtbww2Fh2MVnLyVEdimjA1I6SWV3CCeYIRG5QTAhQQkjnwPLDIbnm/gOm967z2II+37s7xfIejo7bu2jhm/hdlcvuw82U86E4L1FCYmhNUiPrCLlWwbRTd4/t4MfqEvmMtcUxjTwu7RMhdggiCMX7eLG87P72uRhfAzAKk6nnkzGOCGUJjXwCNVoqU4KdYdJMJgO2SoOyu/mjsTa2PTwPvek9XLi/e3HsDv9jCC1at0OUDAcG1UmTC0APZxcZ6doMug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(66946007)(6506007)(66476007)(66556008)(6666004)(316002)(6512007)(1076003)(186003)(54906003)(2906002)(478600001)(86362001)(6486002)(36756003)(83380400001)(5660300002)(44832011)(41300700001)(7416002)(8936002)(8676002)(6916009)(4326008)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MG/BNtb4oUUZkNVsov3EXiU7RW9C3yUnc/sd7ltN8x6Gz8vamkPLXVEGy9pE?=
 =?us-ascii?Q?mItyWaKrgmuEDX0k0wJBMvLiQmVDXCSHJU30mnk51fFp3yIyQnne+QhrJQIG?=
 =?us-ascii?Q?YZlWxKW/eOvtpOyqJMubqeG/bm+Bkp82sGZEA68JWQXAom9lPHLMN6lKwCbf?=
 =?us-ascii?Q?NMVjI9UmrN1Fy/GzSiO7pLQz7F1gEJ9dwtEhSs4aceTJxI6gtqojg8gpwBE5?=
 =?us-ascii?Q?xMwlYmvd7aCFXqYumLTzpUacCGhvofoH5OIjp/VF2uYoxybVUholrGAbchHT?=
 =?us-ascii?Q?5fq/INMUbE5tScYBmVjcTM5n3r7POnmByyEmvnS2P16WBYHT6dlBbObMq3xI?=
 =?us-ascii?Q?/celEpBuOqcYJ5qY7W9SCCgjsa/Dodb0T8kPLd1pU7SMaApjT7qLi/ROLchm?=
 =?us-ascii?Q?DVjgDjCG+dZRiabKTauVTJSIR1C07X/frQBIfF0J6KUg29x/Ijyqm3/ESa2Q?=
 =?us-ascii?Q?v249hARHVjmvpUDC0U22rEN96JDuIxphNRPNUpyENFy+8RhJX5G+lbE04abe?=
 =?us-ascii?Q?ClJvsKKe+QdEBrU0fCnLaz3J1P4JeJbzaAXFCTsv/JG7nCQG5PR1EGaKfWoi?=
 =?us-ascii?Q?mcy2APTEjgdqF8IGl2rcZYggMc5sGCY7OcdK/raUxskqL02N04x9PmzPnAsC?=
 =?us-ascii?Q?rVP0jJGjgigO65GxqkiyGk0F+djHTeP9Gc+OXsP3jExrbNggyGJf82nfRHfd?=
 =?us-ascii?Q?Cs8N14kt7Falhhkh7L1g7leJ9V76dCo+YS+AKVDNpiG6byQdtL7p1A+Ch8gA?=
 =?us-ascii?Q?IAuF9P1fhwM4hp05A0f8upQ5Aq4uNBGEqphoIYFkCWYoUJrK5jcVu7yjMfyQ?=
 =?us-ascii?Q?z7bxk63Fi1qDWO1vsdq6DF+FAEoH3zYnuBcdPSX1/Rkb1fRQg7gQEX1dS5wv?=
 =?us-ascii?Q?4E0FckE5nCMQ2iHEEPXOAUKGWc/bR1acf3zLlK0MCJ7WSs+rQ3OKOYUoiL4X?=
 =?us-ascii?Q?FqUUnpK2QCGkavaN9TbY6uYqpuDaeRcg0oaSIc7ATyc1CHmafITZr75khQLL?=
 =?us-ascii?Q?ZxK0T/MUv9k2IN26KqlFBlM6AAtMHrF+iVEm0J9wEbsVf1iiZsJtQuf1oIi7?=
 =?us-ascii?Q?NexTR0ZKTuP0idseoJtQhpWTTMdGI+liPYkFBES3Uvy+cqSsigVUIbTnBWmk?=
 =?us-ascii?Q?AVRwUhIbsLYfrGwxvDlBhZVC4L47FvR1KmWq4ZEhojnDUUcPLx4o40wiLuLN?=
 =?us-ascii?Q?AMErVMc4ZauEqlJ51PfrkH6nG7Kz2vk/FiuS+Xvc5XEFNakUvibVqX3Q+CBX?=
 =?us-ascii?Q?68W3e1PjzjEo+917xA6fgvBbyUxYFQjJx6o6dxia5bcWmdxGMHJ9Ozagc+hl?=
 =?us-ascii?Q?hmKqs7p35rGH7B1xi9TlmUPbBBM8KMaNWmAfIFZl1xBR1FiQ6AwFgd3zJVEk?=
 =?us-ascii?Q?t+j4pUNQvBeUTiVNAY/gwkP5gnZRTtf5rOVbdzwJ+nbfJafTF+R1KQ5/Rerx?=
 =?us-ascii?Q?k8161ZUJiqNugR1f2dGG6QYxNiWaJKjdg6irY40rMaz6LWkZmNahlvR+X48X?=
 =?us-ascii?Q?cMlX7ZwQtcZzHgQ46is9WfBYI2yFlzn5OpUFKmm2udUc68+RuLFHldWlgMHe?=
 =?us-ascii?Q?OhOXhyljYyYfnwCtz44IZ57eSPl1OgQNbv5WkZ92BEnE12nglg64kSH4ZbqL?=
 =?us-ascii?Q?nbdda/BCbubi8vSdQS0xWos=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2siKtF215UKSjVD60KChcxZWBbGPCqqpL95qN7m042y04SXpPkgXea9L5D83?=
 =?us-ascii?Q?pu94yvIKL0JslSxjIQMsCrwrb2ENJy0D1zHVTkyvm5UajlpiNyRzLLQ/oZ4u?=
 =?us-ascii?Q?GOs8wohskmXlO393wmwNr47ixkX+0RmPWN3/R/EBBtMirrwv7lFSwxKDNfD4?=
 =?us-ascii?Q?0eAL3Fz5tOFeltOgaXiUy/VmwPOi5/f6UC9V2mo2dI3Pujw56Qqo66/gtTlv?=
 =?us-ascii?Q?1bck4EoZvcR8gHFUCxwGWO6tFisM/+wjN+ouHsvV3GKM2XTAf1SxMlRHQ/du?=
 =?us-ascii?Q?1N7qyGezK6hh5yEb2Lh5NM2dFUIVV+JWLYsU3PGCg5x04jmiWNhf/tWfBI9l?=
 =?us-ascii?Q?ye/3HNuoN/7DlPnx82gfMLiGZEb7J3fYDjwbK4Bp9TBD2YEjQo4vc59mo33O?=
 =?us-ascii?Q?7bVMPLd/9bQhFNmuKB8fPTmpFn8GNcFue34ZxpHJm3zasTTcX1ysg1cDO6zF?=
 =?us-ascii?Q?PhMEI8KWZs9CX+3hSyXU6inLzC3Jz5/m8yez8jzPLTm+a7Ntd99+WGZ0qIlA?=
 =?us-ascii?Q?GZ0MM+s2YFJLqOC35Lwx042WfNw6pmzLpso3EsjrZMb/pC4YbgB0oBoZpO/n?=
 =?us-ascii?Q?tcBPXOoG0ndHl8TxUbhSHKTbYlWMAx2Je4rinaRhBAxAtkiS6FzDamGR93lZ?=
 =?us-ascii?Q?Hj3X++zgqxHE2PE1K6ERHwao4OgBcqJq7aK5CUA+KvdynCW5b7QiGjDlqH6y?=
 =?us-ascii?Q?l/js0gyP5ru7fsol0jZimkBFWXiEZTiopwYOZBZtcXD2Yq6D+q8Gmom0kPE1?=
 =?us-ascii?Q?kS49pEoRoXIY7gQBhJkEuEgCKd6mbFSEjL5QXILFTybmen/BT7Akr9TVBRAh?=
 =?us-ascii?Q?H+QnroCBpg3+Lr0qijxeCKex4EU559+bMkFZ0emLyaQCPG7w76lFgC/8HecG?=
 =?us-ascii?Q?KSDD9pebwroWRYCzXUq6Az0XImFeiLy2AgKzFm+jKZ8Cqe2yqRnwQn15t0z2?=
 =?us-ascii?Q?sIodSxxsXs8us5MbU6CLvA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792acebe-98d2-4bfa-6744-08db198c3246
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:03:33.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpLdDon9UncR7TSbeBbaudr2kQQ2hsWSvK5/FA/yITN4VVipA/cB0D30TQQvaoz73olDW0YC4qqRF8987UDvKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280106
X-Proofpoint-GUID: DwlO9a1wlkUMw-sUiWQGF6SegLvAlu2g
X-Proofpoint-ORIG-GUID: DwlO9a1wlkUMw-sUiWQGF6SegLvAlu2g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/tty/serial/imx_earlycon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/imx_earlycon.c b/drivers/tty/serial/imx_earlycon.c
index 7aab38b2bd8cb..2dacd7ae63088 100644
--- a/drivers/tty/serial/imx_earlycon.c
+++ b/drivers/tty/serial/imx_earlycon.c
@@ -47,4 +47,3 @@ OF_EARLYCON_DECLARE(ec_imx21, "fsl,imx21-uart", imx_console_early_setup);
 
 MODULE_AUTHOR("NXP");
 MODULE_DESCRIPTION("IMX earlycon driver");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

