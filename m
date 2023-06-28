Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E608F741853
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjF1Sxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:53:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40894 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230038AbjF1SxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:53:18 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SGwl4A011796;
        Wed, 28 Jun 2023 18:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=tEYS0yDl8S2sr5DunT4eYxKqOSSB+yq8j9ejKatbFv8=;
 b=NqrYM4K30qLVrv0o10e/ukoMS2qarFN6G/pdXtrPgDzXm3Hs5sZmSARqbT98CoC63LT1
 Ca+hhiz9jlvroJ1a4L8b3H074mF1bAB0T8xAEBgJEe9fQswxXrVw7zDfDeJOSq5eQXNR
 1is+0KHN8shxvIUhFxdbJUxIT0UI34B7SjSD+61kFV7lJOnU2SUPzyupVMySLwRidUcd
 2Dvrpvt+dSwo4PoK4DLw5uNxie4m0ZflXHL81kgQZ50s2wwHm2jxbdah29TCKGZAVDK4
 t+pG+clazW2ClfydVXSnNdQ6uKWxAuyV3mFxE1jEDqpKGA86jtRJKokenPuRzCDSUsXE 5A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq938mh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SHHbPT038244;
        Wed, 28 Jun 2023 18:52:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxcx3km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DA/eZmPr3z2dJIJ/QI/LfcOWHtzBg54lcPaABoz/RaikWjW3U9FL4j30t4WKiIo6eaq+fe8AeKWTlE6jWHahTikZyFSH9HYBwsL3cOkGTfnEXH6A9lJTFyJWViYfF2abH0W+TZIelxCMOTdR22K4Nc98NmJAEiTmzJZbDtsEsjaXERP2tUdVN6TFpoAr78Mo/EHGwhRNT/JCyY7p9F4g+nEfktLc+HXwTzytLNTPY/pTyfDE8COqjdAZiNQOTfCnMJkM5k10T2xdTY4RgwwQIvkYa89MHAxLxQG84RkCXMMGgPufVg8zrPaWtSqvviqGcvnkKRpQLTMhNoEy98t6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEYS0yDl8S2sr5DunT4eYxKqOSSB+yq8j9ejKatbFv8=;
 b=HQj5gwQ1Q9H2cmt3W7GF9LYPDpEbHb/6B5GIKPT99w2BHiyk3hS48ae9kcNgjz3wOjBRjLr1aSs2Idix64TsUWBGquwmaXQQ7lJteAD4Gwg4rFY4OATDQtaMOfyjm0r3L63G13FLxhRyApGRdzeYzpDJEyLNnQ+VWcaji3NpJDY3f0Zr3TsYWMddJ0PlRZ7qPsd69j/C7frqnvRA25kZFiu+4mImQfWiakrwueXIjnb2k9aiWsWuqG+pWkTcyX3DnLXl8yNN+7yCLj/5PhBkLBmM6scNQ4LfU6WwqSELRTFvc330l5ixFDWZW8EDjQijLFSWgFNCUqc9L+UB4lPfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEYS0yDl8S2sr5DunT4eYxKqOSSB+yq8j9ejKatbFv8=;
 b=vp3S16hpkktLxBi1OProO6E5kUjWscoKZl2kO6Yx51eAInxLI7iZJbjRfVKySCIVOmJjMvB7OP3A6Tl2cvOWctukuL+Uf8Nd1kmddKrGPuLp5FbXOn+clv7d4GKFOPndfoqmwh4WlbPOa9zpm55c494/ffbOraug2gKWaZT9SzE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 18:52:42 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 18:52:42 +0000
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
Subject: [PATCH v24 06/10] crash: memory and CPU hotplug sysfs attributes
Date:   Wed, 28 Jun 2023 14:52:11 -0400
Message-Id: <20230628185215.40707-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628185215.40707-1-eric.devolder@oracle.com>
References: <20230628185215.40707-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::37) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|LV3PR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9c7fa5-e45d-4c08-9473-08db7808da67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaGirDnm0pBp1aVwMOAh8uT4EmbmEiU+nsWb2SIuCWgg12aFttvtfHpXC794VDRktwRT+kjoLF3nD3vN+hAQv3MKu02eAZqIcI7rLEE7HwtBn6BGeBgdptSPHTYtP3JoYqjqnXkgwVjyEUr0D4w9V4oF8s7AcgBdaGz7pp6Hi3ns7SbvzZdz0at5JxzoGfdYtXmXeb+ZBannC0tQVpjKj5fpTQXyU1y0Gg5Rae//WvTrKrewwn/r7zevRV2lmYX1qJtkvwuc8oLRxzGFyvBs6dZ8ZvM54V5L4vFwPvCl4pMgA8/GIxgFeetdiw/Ls1RvXPwvoVDd8M0U+qHIBlTfHodnVhI366hXuFsMDCTTpk+mM7yQ59sYz7aRVRuikOS5Vd0wFt1gZohjbEZefTH2Nldv6XtS+P6erfqLxQlcB1lgHBD68L/FihgPExPVfWgXZH8EtnYYg+HNynjhNRty2h/why4WQXnbAKSWA7J8LWO1UsmkKxazzqtv1BHPPxVjLd+qV3Gx4QXwNWHdAxh+I9g15uWvlLNZvNeNWW2sK2JT8NrwEm7simNYJ4FKcIg4ob5V7ywb/7lt6FPTeajkQ9MI1i5f6MnQ3BfWfrtIE24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(2906002)(83380400001)(316002)(30864003)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(186003)(478600001)(86362001)(107886003)(921005)(2616005)(66476007)(41300700001)(8936002)(7406005)(7416002)(4326008)(66556008)(66946007)(8676002)(36756003)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PC7AmOTCri7Ak0GV1SXH+vea2N8voprshiRerM0GG11UhRMOzdvtQR0zVLTV?=
 =?us-ascii?Q?OWoZjvmV5Dg/Pq9Qu3EcImgHnCMnTRy0S6GNIjRN1IaNM5wLPA9aFf33SBn0?=
 =?us-ascii?Q?u91RDPcS7lNaBip8LkH19hI5+1TWDvHSeSh25EvlaNwTPatByPN4dA4XOxQt?=
 =?us-ascii?Q?xbhUf6pGBkKpVICI/iemIzVcsHjT58M1Ce5Q+him9q9lJWo3qHdnSDK7lr2z?=
 =?us-ascii?Q?z2g4BGzFxbG+7+6gHKIXqmQoe955x71EsXhZFINOK94w2ptuLkBW0z+jsxuR?=
 =?us-ascii?Q?mdp2akj6qE6yQk/Un2wANGjrH2ILlqdEgcdBgqvUlZ2p+pr09bZwp1OHGvPZ?=
 =?us-ascii?Q?EyxwiOI+X0UBMLAC/xNgCQkKzENDDbDIHqRJyL6PfTwOagwhXXoQkJlUwRpH?=
 =?us-ascii?Q?YWiWX6wGwDmvw8m2Y1jtKs3uU+TJb2xx6WN/2a6RTEVVrXDy/JEv+WcG6z7z?=
 =?us-ascii?Q?1SxYgK8HH/vaQcNDoLCxLc7hqpd4LypMQ4cMChTExO+/Q+ynU6w7ekumvqfr?=
 =?us-ascii?Q?5aTJCqU57J7MO+++0yLqQrV2ICPQQR5y56pWpdhV7DRfqelUBlvQ0pHWf8XW?=
 =?us-ascii?Q?KJlYlsSTUysNJR9WZpZhsuMTINM9JUNlfclp2vspb3w4gFJQHZ1g2YZlXWn7?=
 =?us-ascii?Q?b+EEYr76x6TyqfbW70Q+fTfFzphChlOSLv3W1w9kxHvek9+LMGD8KhFx77lN?=
 =?us-ascii?Q?IPxsVvPJvWaVUV+I+LQ93aQhZqfqrx5lwvtJViloYLt1P5Nii6CTV+5vYEll?=
 =?us-ascii?Q?NhpV2RqMN0xOrh6aFw9hSnt8RL5/DAdym/K1ytqNEvA/IvQj5NcS6e62mG61?=
 =?us-ascii?Q?67PwzzEjUG8xhrZ/+eHb0VTcEQglsMD7n/2fZ1w7WCnZuh6IeqfL4AimeLwL?=
 =?us-ascii?Q?LLdTvqhYyH7KGmLlnW9JDuKSdmWUmmwX7NyzKvNGGah04O1tujEstVGlhinT?=
 =?us-ascii?Q?r0Nz5/RXJMGCWpqnxBay3MhGNxJdZBrWOKibrQ1icZW0XyXneIV4GTkxG0xK?=
 =?us-ascii?Q?UDuFPEputvBUAHeGTmQIsjKtHwO5mPRPkp2Gq0/XJ1Zb8F/3OKTxxm8ySFIq?=
 =?us-ascii?Q?KTsjL7YS9ri+oLyQIafoe2jrhMO+Xm3CQbp9yIPBn3ReQR39c1HBl+1BiQWB?=
 =?us-ascii?Q?MFh7RD/0Puh9VnIu7vDDZ3iYB+EUoixX+Qq2d0KehMbja8jJ6YTq4iSytHUS?=
 =?us-ascii?Q?ytkAdAgzWS2lC6aGAIr/xP/XkCxzLYRTEo2VjIRWwxSKTHBJiUtxzzhwSYXz?=
 =?us-ascii?Q?iypgQImW9Q33vfUWXA4gznRWkWY6G+6PHCdoQCzGhBTSoB/Urp82hu6a4Z2Z?=
 =?us-ascii?Q?+Y5tibctiiIwTxET/QfEL4LQhrVHoFW5OIWVuXuYXVTrg7sfZLabUEs92E0n?=
 =?us-ascii?Q?zpGCa7XnpKMudKOtYmt1dL01FV/wy2Uw8O/mviFM4MgUENx3AOu4kRxMFlXq?=
 =?us-ascii?Q?KNy2f9ez1z04DWpcf7M7Qw7jAN5zLOHK9c3XdarYUnYY7cNX76lXelyXb9vH?=
 =?us-ascii?Q?1c+zRLDjmA7uOFPWnn0zeN8RAIgMkV32TPFM4c3qKIZuhrMpW+rkqpAW5/dv?=
 =?us-ascii?Q?pWlOMs3THRGgWkB6/nH+btgQn26yt40O8Jqgqh3mznQhDiP7VYbp7cCok+81?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pw4TCLEW61wznkqGvz7kPbb9ugNupHUabEWPrQ8P4YdwnIKo2r9jXhcdg3S9?=
 =?us-ascii?Q?lj0j4SYwafRGPzSUURaoNiKS4nwuhkTo9QnERCpEqJNj2lSbi7v8XppQ/PMm?=
 =?us-ascii?Q?35bgdMQ3Xc4ySL2Y6UqL+RPAE8S4yh7UQ1Tu+jZvvCcANv5sbjBgUBfWU5Nt?=
 =?us-ascii?Q?bEC4zoeZ00nzj1fXwS3dhoPTsqCoF8CenFME0F07sLKdI+vfHBZ3ZXweo6rx?=
 =?us-ascii?Q?XSM9L7+L3C4hw79TBKavoi562r8sLWy0DS3eGJpNo1+k4tkwNnnY9rxkQ9SO?=
 =?us-ascii?Q?XOKLJgQK2q17UskhexzNLOK3E3+RRjbTs+YQfmJdM5SYNRjWcr3D0/ZlvfrT?=
 =?us-ascii?Q?9nVInpsheI9wpJ8fZfSCB+/zJWL3cGFrMiSHsR2KJD3ybPEFHAKoLCVCF3u8?=
 =?us-ascii?Q?hpclFa4FHyuaKKRYxukSriuh/HlVbGkdwd6zvOX7QuknxTvxkOsYbnZNO72x?=
 =?us-ascii?Q?SmwlAWDB15W3dQniX+PDE89247EYSyekT1jPNG3oswgXtr2YGZT6yCFKvuG3?=
 =?us-ascii?Q?sdkXuFRtsa/0LVnJKCgIltJyu7Hi6h0iQP5oRqwIdZmosJ8qFrKXPa58X1ft?=
 =?us-ascii?Q?CD8SejcI9YBOqk+YivlWmPSZy84kp8eYwseqz2Tbp30Sd/ixyoKsOkAdU3pM?=
 =?us-ascii?Q?o1Hi8oFmR90Yfg1JFSRlb9+PZSbrelwDIh09RNPacx7vEZdsdqWj053uGnt/?=
 =?us-ascii?Q?cofjFHMYF0TMFwu3Q5L6PuRYyo4w4+sDaCJWLF0HYoML696x9VmtySrl/Ih+?=
 =?us-ascii?Q?mbyYZEXzcSNYJpR1y0iy10YoIluyYOQL/HOZIIPWxnWKB/ar0sx2i6vJ0yA7?=
 =?us-ascii?Q?R3MUEwIFJS9VVUbdkPzRr4NvGN1VqVfKWOgeqA7tk1vosZPhdXRmStLKisvj?=
 =?us-ascii?Q?A70KxUI4gMyf0bJy07jLk32kQEOYLs/WeMIFsp1AzUJEs96dhB0sDb7Atf1A?=
 =?us-ascii?Q?S6B0rbwAlmw6EnpvBTXDCkp8zIdCL9FOCt7JuEBI31iUTbww+FS0zay+5IMt?=
 =?us-ascii?Q?EbjvxpU5ogW8Aj2HG56lpxVrteaGdyyTlLMQtadiAgi3c9PppM2bc5mxNHD5?=
 =?us-ascii?Q?XQjLQpYrXlCPPJLbPYaymcjxc7TvqpNqei1G+/3TtsMP26S+TS8PGWuHBPhe?=
 =?us-ascii?Q?H/0arpuelm5MR0yRyC3ERDL8ZhV9YaCmR662JAwmovz2ZoJAm7dY2zb5SJKz?=
 =?us-ascii?Q?CFHjZCELF6SSXUpOWZgYKR8hR856vziKN/ClYtHsxwEcqQqNcD9YYlMMQ7rU?=
 =?us-ascii?Q?GVevO9vjUzXl4s7H4TRo/CypVoanjb5qxZfeBz7kDvgKu9pyBOHyvZwfzfYA?=
 =?us-ascii?Q?3PcNsAyleYb+3sj7Np4lhRaEwbv1OTcQMJ0Qavr3Cez1gj20DAWMWHAWlguz?=
 =?us-ascii?Q?0K9iI5y37KH+TPtLOCrBwb0hDnR38qMtdIPEhYlK4biq5Cwx7ND5Da1N12P6?=
 =?us-ascii?Q?VPCksZUuD5o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9c7fa5-e45d-4c08-9473-08db7808da67
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:52:42.3442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeDtKLvJDGZ2M2mCtivPjOkDPyH/imdw2hqDLkcKcufz2Xd1AHsHQVQOeQZNGZTFrafFj0QuBN2f5PV4SEulGAJdskwcb5Kh6a3feLaDYwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280168
X-Proofpoint-ORIG-GUID: wYbCvOt5bUjwjpVYwI7BR2yxDhXqcphV
X-Proofpoint-GUID: wYbCvOt5bUjwjpVYwI7BR2yxDhXqcphV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the crash_hotplug attribute for memory and CPUs for
use by userspace.  These attributes directly facilitate the udev
rule for managing userspace re-loading of the crash kernel upon
hot un/plug changes.

For memory, expose the crash_hotplug attribute to the
/sys/devices/system/memory directory. For example:

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

For CPUs, expose the crash_hotplug attribute to the
/sys/devices/system/cpu directory. For example:

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

When examined in the context of 98-kexec.rules, the above rules
test if crash_hotplug is set, and if so, the userspace initiated
unload-then-reload of the crash kernel is skipped.

CPU and memory checks are separated in accordance with
CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
If an architecture supports, for example, memory hotplug but not
CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
attribute file will NOT be present. Thus the udev rule skips
userspace processing of memory hot un/plug events, but the udev
rule will evaluate false for CPU events, thus allowing userspace to
process CPU hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 Documentation/ABI/testing/sysfs-devices-memory |  8 ++++++++
 .../ABI/testing/sysfs-devices-system-cpu       |  8 ++++++++
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 16 ++++++++++++++--
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  8 ++++++++
 7 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
index d8b0f80b9e33..c50725ebebb7 100644
--- a/Documentation/ABI/testing/sysfs-devices-memory
+++ b/Documentation/ABI/testing/sysfs-devices-memory
@@ -110,3 +110,11 @@ Description:
 		link is created for memory section 9 on node0.
 
 		/sys/devices/system/node/node0/memory9 -> ../../memory/memory9
+
+What:		/sys/devices/system/cpu/crash_hotplug
+Date:		Jun 2023
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) indicates whether or not the kernel directly supports
+		modifying the crash elfcorehdr for memory hot un/plug and/or
+		on/offline changes.
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index ecd585ca2d50..598b0fa67481 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -686,3 +686,11 @@ Description:
 		(RO) the list of CPUs that are isolated and don't
 		participate in load balancing. These CPUs are set by
 		boot parameter "isolcpus=".
+
+What:		/sys/devices/system/cpu/crash_hotplug
+Date:		Jun 2023
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) indicates whether or not the kernel directly supports
+		modifying the crash elfcorehdr for CPU hot un/plug and/or
+		on/offline changes.
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
index e6f5bc39cf5c..54581c501562 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -741,6 +741,24 @@ will receive all events. A script like::
 
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
index 75fa46a567a1..26c85f3c8193 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -20,6 +20,7 @@
 #include <linux/tick.h>
 #include <linux/pm_qos.h>
 #include <linux/sched/isolation.h>
+#include <linux/kexec.h>
 
 #include "base.h"
 
@@ -132,8 +133,6 @@ static DEVICE_ATTR(probe, S_IWUSR, NULL, cpu_probe_store);
 static DEVICE_ATTR(release, S_IWUSR, NULL, cpu_release_store);
 
 #ifdef CONFIG_KEXEC
-#include <linux/kexec.h>
-
 static ssize_t crash_notes_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -290,6 +289,14 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 }
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 
+static ssize_t crash_hotplug_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support());
+}
+static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
+
 static void cpu_device_release(struct device *dev)
 {
 	/*
@@ -474,6 +481,7 @@ static struct attribute *cpu_root_attrs[] = {
 	&dev_attr_isolated.attr,
 	&dev_attr_nohz_full.attr,
 	&dev_attr_modalias.attr,
+	&dev_attr_crash_hotplug.attr,
 	NULL
 };
 
@@ -509,6 +517,10 @@ cpu_root_attr_is_visible(struct kobject *kobj,
 		if (attr == &dev_attr_modalias.attr)
 			return mode;
 	}
+	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
+		if (attr == &dev_attr_crash_hotplug.attr)
+			return mode;
+	}
 
 	return 0;
 }
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f03eda7e1c9c..f1b9d8fccace 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -25,6 +25,7 @@
 
 #include <linux/atomic.h>
 #include <linux/uaccess.h>
+#include <linux/kexec.h>
 
 #define MEMORY_CLASS_NAME	"memory"
 
@@ -494,6 +495,13 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
 static DEVICE_ATTR_RW(auto_online_blocks);
 
+static ssize_t crash_hotplug_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", crash_hotplug_memory_support());
+}
+static DEVICE_ATTR_RO(crash_hotplug);
+
 /*
  * Some architectures will have custom drivers to do this, and
  * will not need to do it from userspace.  The fake hot-add code
@@ -916,6 +924,7 @@ static struct attribute *memory_root_attrs[] = {
 	&dev_attr_hard_offline_page.attr,
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+	&dev_attr_crash_hotplug.attr,
 	NULL
 };
 
@@ -939,6 +948,10 @@ memory_root_attr_is_visible(struct kobject *kobj,
 		return mode;
 	if (attr == &dev_attr_auto_online_blocks.attr)
 		return mode;
+	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
+		if (attr == &dev_attr_crash_hotplug.attr)
+			return mode;
+	}
 
 	return 0;
 }
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index b9903dd48e24..6a8a724ac638 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -501,6 +501,14 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
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

