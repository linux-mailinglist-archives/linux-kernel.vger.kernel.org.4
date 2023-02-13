Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1D8693B85
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBMBAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBMBAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:00:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F381A9756
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:00:35 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31CKGK7l015576;
        Mon, 13 Feb 2023 01:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=JyY3HlAKFr3Os6KFH4leQ+g7J5pId9CeZgcsxYtDMVE=;
 b=I7E5Tzy5iaS/d43IKOkZsBieVgeg+e5LiSc1/5RJQo7OSra8lTxjZVCkdLE6X18IR0Dl
 vPsi1WQ59y3gTmxuxKSHY9AvBCsbsMjP6ULTbiX4/t4R6W1qq+IoflKNhewpebBJx0G/
 ktGTCC8p1T4UXbSMJboAi1wfMeSTSVszhoXqbFQ0K76qzVLnHzXNyglr7/HyPfMYoLda
 qgwVRK2yhTTuLcCqfwrRGaY1ygsD4SsfFjM0l3/xQIEtSdGfXsMNjs63mYUfcAT/3Iwt
 Xak3K5mHTXIbOPipBgIei9mhn5LG/x2JAjxiTwJXgfwnMwmg+PH0nwV2mllg5BauAcOz HQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t39pjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 01:00:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31CNiFIp017820;
        Mon, 13 Feb 2023 01:00:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f3y2an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 01:00:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJR2cn6Zvp6Y8MDBr+loo7FNF8N6f2H+jCmFIYwJsW4T0yhSnNF3f91RPSJ93PTwZ4vvhfREJ6b8U/ASa4g4fgSWgAn8ULe5qMWJWuSWOkjCijGf7Qyr9DJjYiwLekZIVIDeEfhfgXZZQaqxUkxtbQRECXyI6fkX1TCjlb/Cn1nljMwmU4M+B4g9CKMufwyCXWIpJPb52GR3aFsUqWxtZf3T4j2GWZlxHoYcetmABllThgT+CKsjU/dqUGFKBXhq2kWDkWGwBvE+Rz5XhPY1ZL0GoWwfjk0OffNpa6QCpQsleRNl4FXd9ATUlU+nM7G7y7aLuoftjgJjynj8a0rnwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyY3HlAKFr3Os6KFH4leQ+g7J5pId9CeZgcsxYtDMVE=;
 b=V4mue2xQ08SJCmXqGvHSB0fDG+kxprTjrksXV3mFQSzKz3div3ADSb8WzNj2PYplNFmjpDWUEpreIjLhRHE2KhQykfmwLCSKSr2PUnKgJvrFBvUK0ATgHcHn8PL3Q20aYtz0Z6ObGKTtqPD4IegwKR3GqMmAvj/39fLphaNL6FMPAMuQamanfLt7KV1EJnlW1fWJGTEFNntOTMepexs21NWOKFFFZfkab+ta2mweu3/Jb2umBksWjsjArJITFqgifhtyiQNgXdWkDbIlY4P7FZAaELPPNuYQW/NOZsU1uhyUYCNzrIyrtx20O2bgPl+58ZWS199ncotu25JCIdwwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyY3HlAKFr3Os6KFH4leQ+g7J5pId9CeZgcsxYtDMVE=;
 b=z1tT+i5ZXJlkObZ9NjxHqvOsJBubHpXY1qRUPULI/heSJ2Ly8UYAHzG9B+HCxNqyk0GoNtfdAselE9pfiRmfmlidkBwPXdDeBH3WwVv4p7K9rad15s73SLMaco3xq6WavoSPdoMzC7AUBk67RsX0bGGgbnIx6+IvCSbLZYGnLF4=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CH0PR10MB4921.namprd10.prod.outlook.com (2603:10b6:610:c2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.10; Mon, 13 Feb 2023 01:00:27 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6111.009; Mon, 13 Feb 2023
 01:00:27 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     brauner@kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 1/5] kernel: Move kernel_clone_args's fn to new struct
Date:   Sun, 12 Feb 2023 19:00:16 -0600
Message-Id: <20230213010020.1813-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230213010020.1813-1-michael.christie@oracle.com>
References: <20230213010020.1813-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::27) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CH0PR10MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: f95e0ef7-da0f-4e3d-223e-08db0d5db1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZPmkzqJesbWHpEmpYKskue712umaVfRZPa1ZARep2CKJOcklPwrM9Qfwv1+fX85mDkhPAcWrfXWAosovVRVfxIGc8R/3UZoVaYlgQwRi1Oc/Tfump/HCe7aRYLBW11pNGf1KqRMW/yE8/833YXwdE4liiJ6n8Q+bGm1oaqMFpftyGKtlEZcMKQFDgdA0dg/8lUo/ftFSJwCeV9yz5DZ2yfhzpTRDWcgdGBFcvNZiicu+/oLYmeDIoAi2TLXl7Ht/5+q2+nbBM6UNJxd58CWOWV/CIqFzbZ9v6CtiDhvmPAulJUN7pcbXtngrD6aKfqBfJ7GQkTOPE8Ig1DRcfzMbs1LJku/6a1t8fXF0erlkxU0QahoqRhwo8egnGeCPHuMlSUMcka9Ufb9UWDYm5vtOmXcGb7oqYwhYBe05ijFa/MvGBgXfQN4QATyUC/XtmYrl4ASh710z/DbY8MPxcKdEX6J5TZmlzvp6IVE/VA1J/oOcWdTncKLnrfuyCFCJmSUW+oAWEUvTJGL17AuigdJmk+bUH5/QsavUBTALycKqViQ5qn0mncezXD6dXBfiztasHgucQTZ9QYyAaPDd2XBd/o6OyXtov91tkQdFCe6/4DCSryGed59/VIyEIUI3XgAIpN2DoNydYKbjNOTyBZe3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199018)(30864003)(8936002)(36756003)(2906002)(5660300002)(86362001)(2616005)(83380400001)(4326008)(316002)(107886003)(38100700002)(66556008)(66946007)(66476007)(8676002)(41300700001)(6486002)(478600001)(6666004)(1076003)(186003)(26005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FKpRXU6+OaFDPwvECOow1Y7P4LPnYE+H1ciPHWAmAOn2q7rOANLJdqbs/WWk?=
 =?us-ascii?Q?kEbtFTDyBMrwN5swyRe+vufxW4EbTZJB8nONSI7nke6+GI5xpmsU2P2I22I1?=
 =?us-ascii?Q?PG04TGOc1PAc0U1twcj+qN3mrquMeHURiT9T4nr7lTtUgvoJmWBJ/BTKQFoh?=
 =?us-ascii?Q?H9iLt3IyP4nOuVhEMGQw7D4yhKVkz2/JUAOhB71+glSPCuhVsFQidF0IT2aj?=
 =?us-ascii?Q?aaV8Qie6sQT5pE1/9Dwl1NACgD8TTNd9Z4lyepAzJgN21lt7v3+N2IafsdCN?=
 =?us-ascii?Q?MeSjA6nvR4vQZvYUCtgRpHztPaftSFfm4e2/QBHKUdo+lhytfPl1n/Ap7mYF?=
 =?us-ascii?Q?/kAHl9ewdKmZO/iDOQjUJx6RQbo/ZDoe1DvIIu52DJaJf0YRDJDHLwkBmkWy?=
 =?us-ascii?Q?smNXhecYR8CcF4QYNGdrlYuAsPYL0UQ6VYzuu0yjbzjSX/UE6ndOzjf6c/GU?=
 =?us-ascii?Q?uF5D5F1BeDkgSBe/maZExQJQu7m+krQk/GoMHVebZOfTwnKwXpklgp7y9fAF?=
 =?us-ascii?Q?fWPW97R+ChKFzQEyp60dxZic4mhK5Cv6MHImbnqav6qIO7rQHyvzqqJjSTAJ?=
 =?us-ascii?Q?jAq1L4+UodkYQLB76HHHY+qq/tQIZ3g0zknJqhzz2qIRE/MJDIlou3thYUHw?=
 =?us-ascii?Q?9ReOwB8yLhv8DIXHq6/+YSRqa0uGGfjmNwh6JSIHMSePW9NoL060bHrNLZlH?=
 =?us-ascii?Q?lMpOg8YLPOEo63V+Y4wYF3eB44rz5eB+wEJ6EYNYFAe/uehh8Ecajgx5trpG?=
 =?us-ascii?Q?hN0uY69P4k4BLN3o+XL/QUWaRD3e2ohDMKrO/zsTVSjXNCjpwrzce3tlIdDR?=
 =?us-ascii?Q?y8mWrtSh/Vy/5fgV82w52U1VRPKKYwfkY55lqgt2MsFm3n1KJqkQ7ek9sIqn?=
 =?us-ascii?Q?QDCaKI1/ZSd6p9B273D8TDYoQGlKFVInb/Mubrf1g3Pk8RZt1jhGotKaJMvo?=
 =?us-ascii?Q?bASG4INfaoSEu5whMp5J2cZbSlmpBwJWzaea0I7ttD0W8AFglyKPfDbbfish?=
 =?us-ascii?Q?XRulxqPG+2iThKmbhSDZROrQILjRDfV41jqzd04byfqD7br/4cV1NOc/IZKx?=
 =?us-ascii?Q?38ZWxRbdKw8/O4buMBjw/bg83ZKQByFH1lpNSK8xPiB9mvtqVTgxYg3MUjp8?=
 =?us-ascii?Q?mbC4v6u4jTUn16zOKrKt7DoYqs9T3MKoM7sGY8Ki5q2v336Bxwm2eXiT1h65?=
 =?us-ascii?Q?NhOQWk5N1rJbGSO9hyNSj+b6sNx43AoolNcxh8vSeZBMEYN0/bhrO2e8Piqa?=
 =?us-ascii?Q?SmN5LhYmxjyybcRkUF59GJ4aohkOw8j0r6cPn3oJ3IXYBHxKI9ntMh0yVuEC?=
 =?us-ascii?Q?9ZN7cdf0sZcCQqYMcm7Bn8f2o52Hc6GMHXMuDoAQDdikc3cU6o5WEwGKGO3u?=
 =?us-ascii?Q?jkMHNZI6SaOX0smU7F4Q3wIwuaMc3FUP/sedltT7s+jg7EcYgWqIY/ns12H7?=
 =?us-ascii?Q?06NkOxXBYoCixxbnQn6TD++jEHPGSH1TJokCnM5z30OjGdHJWipk1BnBlloB?=
 =?us-ascii?Q?qUP6XcnE8z7Skf8F9ADapO49cXSIq8/4BPY4EyO42J6EoDujFIeJYu6vtLMs?=
 =?us-ascii?Q?pV6P1ox1xwZL9DRNItpEzFwNMBnVFgpbo0Fw4//aRwCTYex6c44Ha596V9ll?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eLsbmMBNqldeYpc6LAke7OdH5fLGKqHyYeSQZJqFsDawFrOQ2Sp7y0ai2XVd2B4zUnqzHhWl2rI2wfo3CXx9JI5mOv3ujIqXr/baPDCFCsEHbSOIxSqmH0xXxJXqxyrjrAymPo+ySzd749W/i2NdLamQwpHHDSWtxDkO/leLzTYxTBmgd67NlCoZHW4qFbnUBYmAdsk98NrAVYonOCJbJiXUj0ekpkf/DcXFM+qwmfcPvCymkjm2PI8hVNlngPoZaLbsrCf7n+m1cjkseZQzXll2Lk8VpmF4pa5OuFHuvVZ3vULDwv8gDrEJQF/6+9JCTMLMOWiw8IOWwlKeMua4jCDQsy4dEm0ibYTRod/Ma0GmGnOW0NLcFbecmvGQQ1Ou26jq79OHED+AKA2PrAbu2SDWHtMRQom2lOJT1EeO4Ua2ca4m11SiyqitcuY03zpQtJChTIHuSrOTrgnI4Zaltn7qsIKPQ9tN9mA5/jiU4bBVOvYf1tbk+ffPA3ic3l6d95NaG1GWaclk6ZfZv9W8sLWlgJQtpp/wzoF3JYrPu7h1NYn/ynYWVZkPr0H3a4LDxeBUivYBnKzwuCjVZFFZnoG/rnnQlbUfPWC4PGRdmjsAp5aCmrOxpEghTOkSS6112rkIHij3gjArupVA2nkdCOAbFK/W8pnIaoVHOQBAz9da6ypm+RzAZT/HarCOH4zs/rU/KiYZ1OF7vhL2x5fpBHx3TOhfx+xNdkQ6tdOGNy/LnBDEhEfJTT/yqnCGqmDuMgsy5B1w/vYfrWZyLvMIoROz5TpzvaqSqNE2TvUeAqqopRNTQJXarbi7hyDWeD4GLAMeEQ5Z+8x+vSMzm0kVnalA/OfNYH+DvuhqdSVoAkE4Tr2MQinDCwATtDtdAYcT
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95e0ef7-da0f-4e3d-223e-08db0d5db1b1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 01:00:26.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGjVr+kwPDsRO1qIWjmciZNmVKf+GfOGp9ywrQX9vUGkMrmOla5mtS5sAiQYYpkxLCRgiACdPR2iHItM52b0vG8NMybieB1PCGbn4zHEJAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_12,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130007
X-Proofpoint-GUID: e_DCdeQ0kK0L0-h0rdLz7mn4Z65L5vFV
X-Proofpoint-ORIG-GUID: e_DCdeQ0kK0L0-h0rdLz7mn4Z65L5vFV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patches will add callouts to set the task's comm, and create
internal resources. This adds a new struct to for these callouts to
organize them and reduce the args passed into kernel_thread and
create_io_thread.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 arch/alpha/kernel/process.c      |  4 ++--
 arch/arc/kernel/process.c        |  4 ++--
 arch/arm/kernel/process.c        |  4 ++--
 arch/arm64/kernel/process.c      |  4 ++--
 arch/csky/kernel/process.c       |  4 ++--
 arch/hexagon/kernel/process.c    |  4 ++--
 arch/ia64/kernel/process.c       |  4 ++--
 arch/loongarch/kernel/process.c  |  4 ++--
 arch/m68k/kernel/process.c       |  4 ++--
 arch/microblaze/kernel/process.c |  4 ++--
 arch/mips/kernel/process.c       |  4 ++--
 arch/nios2/kernel/process.c      |  4 ++--
 arch/openrisc/kernel/process.c   |  4 ++--
 arch/parisc/kernel/process.c     |  8 ++++----
 arch/powerpc/kernel/process.c    |  5 ++---
 arch/riscv/kernel/process.c      |  4 ++--
 arch/s390/kernel/process.c       |  4 ++--
 arch/sh/kernel/process_32.c      |  4 ++--
 arch/sparc/kernel/process_32.c   |  4 ++--
 arch/sparc/kernel/process_64.c   |  4 ++--
 arch/um/kernel/process.c         |  4 ++--
 arch/x86/kernel/process.c        |  9 +++++----
 arch/xtensa/kernel/process.c     |  6 +++---
 include/linux/sched/task.h       | 12 +++++++++---
 init/main.c                      |  6 +++++-
 io_uring/io-wq.c                 |  8 ++++++--
 io_uring/sqpoll.c                |  6 +++++-
 kernel/fork.c                    | 24 ++++++++++++++++--------
 kernel/kthread.c                 |  7 ++++++-
 29 files changed, 99 insertions(+), 68 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 65fdae9e48f3..3008c9d39b0f 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -245,12 +245,12 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	childti->pcb.ksp = (unsigned long) childstack;
 	childti->pcb.flags = 1;	/* set FEN, clear everything else */
 
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		/* kernel thread */
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
 		childstack->r26 = (unsigned long) ret_from_kernel_thread;
-		childstack->r9 = (unsigned long) args->fn;
+		childstack->r9 = (unsigned long) args->fns->thread_fn;
 		childstack->r10 = (unsigned long) args->fn_arg;
 		childregs->hae = alpha_mv.hae_cache;
 		childti->pcb.usp = 0;
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 3369f0700702..edda86c54634 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -192,11 +192,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	childksp[0] = 0;			/* fp */
 	childksp[1] = (unsigned long)ret_from_fork; /* blink */
 
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		memset(c_regs, 0, sizeof(struct pt_regs));
 
 		c_callee->r13 = (unsigned long)args->fn_arg;
-		c_callee->r14 = (unsigned long)args->fn;
+		c_callee->r14 = (unsigned long)args->fns->thread_fn;
 
 		return 0;
 	}
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index f811733a8fc5..a1b28921f351 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -254,7 +254,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	thread->cpu_domain = get_domain();
 #endif
 
-	if (likely(!args->fn)) {
+	if (likely(!args->fns || !args->fns->thread_fn)) {
 		*childregs = *current_pt_regs();
 		childregs->ARM_r0 = 0;
 		if (stack_start)
@@ -262,7 +262,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	} else {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		thread->cpu_context.r4 = (unsigned long)args->fn_arg;
-		thread->cpu_context.r5 = (unsigned long)args->fn;
+		thread->cpu_context.r5 = (unsigned long)args->fns->thread_fn;
 		childregs->ARM_cpsr = SVC_MODE;
 	}
 	thread->cpu_context.pc = (unsigned long)ret_from_fork;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 269ac1c25ae2..499aab54d56d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -361,7 +361,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 	ptrauth_thread_init_kernel(p);
 
-	if (likely(!args->fn)) {
+	if (likely(!args->fns || !args->fns->thread_fn)) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
 
@@ -399,7 +399,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->pstate = PSR_MODE_EL1h | PSR_IL_BIT;
 
-		p->thread.cpu_context.x19 = (unsigned long)args->fn;
+		p->thread.cpu_context.x19 = (unsigned long)args->fns->thread_fn;
 		p->thread.cpu_context.x20 = (unsigned long)args->fn_arg;
 	}
 	p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 2b0ed515a88e..50b417cca6be 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -48,11 +48,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	/* setup thread.sp for switch_to !!! */
 	p->thread.sp = (unsigned long)childstack;
 
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childstack->r15 = (unsigned long) ret_from_kernel_thread;
 		childstack->r10 = (unsigned long) args->fn_arg;
-		childstack->r9 = (unsigned long) args->fn;
+		childstack->r9 = (unsigned long) args->fns->thread_fn;
 		childregs->sr = mfcr("psr");
 	} else {
 		*childregs = *(current_pt_regs());
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index e15eeaebd785..8c57762202e8 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -75,10 +75,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 						    sizeof(*ss));
 	ss->lr = (unsigned long)ret_from_fork;
 	p->thread.switch_sp = ss;
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* r24 <- fn, r25 <- arg */
-		ss->r24 = (unsigned long)args->fn;
+		ss->r24 = (unsigned long)args->fns->thread_fn;
 		ss->r25 = (unsigned long)args->fn_arg;
 		pt_set_kmode(childregs);
 		return 0;
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 416305e550e2..22b3c75b895a 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -342,13 +342,13 @@ copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 	ia64_drop_fpu(p);	/* don't pick up stale state from a CPU's fph */
 
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		if (unlikely(args->idle)) {
 			/* fork_idle() called us */
 			return 0;
 		}
 		memset(child_stack, 0, sizeof(*child_ptregs) + sizeof(*child_stack));
-		child_stack->r4 = (unsigned long) args->fn;
+		child_stack->r4 = (unsigned long) args->fns->thread_fn;
 		child_stack->r5 = (unsigned long) args->fn_arg;
 		/*
 		 * Preserve PSR bits, except for bits 32-34 and 37-45,
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index edfd220a3737..b5022c0defd2 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -146,10 +146,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	p->thread.csr_crmd = csr_read32(LOONGARCH_CSR_CRMD);
 	p->thread.csr_prmd = csr_read32(LOONGARCH_CSR_PRMD);
 	p->thread.csr_ecfg = csr_read32(LOONGARCH_CSR_ECFG);
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		/* kernel thread */
 		p->thread.reg03 = childksp;
-		p->thread.reg23 = (unsigned long)args->fn;
+		p->thread.reg23 = (unsigned long)args->fns->thread_fn;
 		p->thread.reg24 = (unsigned long)args->fn_arg;
 		p->thread.reg01 = (unsigned long)ret_from_kernel_thread;
 		p->thread.sched_ra = (unsigned long)ret_from_kernel_thread;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index e06ce147c0b7..550a75b3d36d 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -159,11 +159,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	 */
 	p->thread.fc = USER_DATA;
 
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		/* kernel thread */
 		memset(frame, 0, sizeof(struct fork_frame));
 		frame->regs.sr = PS_S;
-		frame->sw.a3 = (unsigned long)args->fn;
+		frame->sw.a3 = (unsigned long)args->fns->thread_fn;
 		frame->sw.d7 = (unsigned long)args->fn_arg;
 		frame->sw.retpc = (unsigned long)ret_from_kernel_thread;
 		p->thread.usp = 0;
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 1f802aab2b96..94138f7aec4c 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -60,13 +60,13 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct thread_info *ti = task_thread_info(p);
 
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		/* if we're creating a new kernel thread then just zeroing all
 		 * the registers. That's OK for a brand new thread.*/
 		memset(childregs, 0, sizeof(struct pt_regs));
 		memset(&ti->cpu_context, 0, sizeof(struct cpu_context));
 		ti->cpu_context.r1  = (unsigned long)childregs;
-		ti->cpu_context.r20 = (unsigned long)args->fn;
+		ti->cpu_context.r20 = (unsigned long)args->fns->thread_fn;
 		ti->cpu_context.r19 = (unsigned long)args->fn_arg;
 		childregs->pt_mode = 1;
 		local_save_flags(childregs->msr);
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 093dbbd6b843..45bc4bac3ba2 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -121,11 +121,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	/*  Put the stack after the struct pt_regs.  */
 	childksp = (unsigned long) childregs;
 	p->thread.cp0_status = (read_c0_status() & ~(ST0_CU2|ST0_CU1)) | ST0_KERNEL_CUMASK;
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		/* kernel thread */
 		unsigned long status = p->thread.cp0_status;
 		memset(childregs, 0, sizeof(struct pt_regs));
-		p->thread.reg16 = (unsigned long)args->fn;
+		p->thread.reg16 = (unsigned long)args->fns->thread_fn;
 		p->thread.reg17 = (unsigned long)args->fn_arg;
 		p->thread.reg29 = childksp;
 		p->thread.reg31 = (unsigned long) ret_from_kernel_thread;
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index 29593b98567d..87135a1b64af 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -111,11 +111,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	struct switch_stack *childstack =
 		((struct switch_stack *)childregs) - 1;
 
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
 
-		childstack->r16 = (unsigned long) args->fn;
+		childstack->r16 = (unsigned long) args->fns->thread_fn;
 		childstack->r17 = (unsigned long) args->fn_arg;
 		childstack->ra = (unsigned long) ret_from_kernel_thread;
 		childregs->estatus = STATUS_PIE;
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index f94b5ec06786..cfd377832c2c 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -185,9 +185,9 @@ copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	sp -= sizeof(struct pt_regs);
 	kregs = (struct pt_regs *)sp;
 
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		memset(kregs, 0, sizeof(struct pt_regs));
-		kregs->gpr[20] = (unsigned long)args->fn;
+		kregs->gpr[20] = (unsigned long)args->fns->thread_fn;
 		kregs->gpr[22] = (unsigned long)args->fn_arg;
 	} else {
 		*userregs = *current_pt_regs();
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index c4f8374c7018..a1f028dbb2d1 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -216,7 +216,7 @@ copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	extern void * const ret_from_kernel_thread;
 	extern void * const child_return;
 
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		/* kernel thread */
 		memset(cregs, 0, sizeof(struct pt_regs));
 		if (args->idle) /* idle thread */
@@ -231,10 +231,10 @@ copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		 * ret_from_kernel_thread.
 		 */
 #ifdef CONFIG_64BIT
-		cregs->gr[27] = ((unsigned long *)args->fn)[3];
-		cregs->gr[26] = ((unsigned long *)args->fn)[2];
+		cregs->gr[27] = ((unsigned long *)args->fns->thread_fn)[3];
+		cregs->gr[26] = ((unsigned long *)args->fns->thread_fn)[2];
 #else
-		cregs->gr[26] = (unsigned long) args->fn;
+		cregs->gr[26] = (unsigned long) args->fns->thread_fn;
 #endif
 		cregs->gr[25] = (unsigned long) args->fn_arg;
 	} else {
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index c22cc234672f..627efd7a5179 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1761,14 +1761,13 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 	/* Copy registers */
 	childregs = (struct pt_regs *)(sp + STACK_INT_FRAME_REGS);
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		/* kernel thread */
 		((unsigned long *)sp)[0] = 0;
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gpr[1] = sp + STACK_USER_INT_FRAME_SIZE;
 		/* function */
-		if (args->fn)
-			childregs->gpr[14] = ppc_function_entry((void *)args->fn);
+		childregs->gpr[14] = ppc_function_entry((void *)args->fns->thread_fn);
 #ifdef CONFIG_PPC64
 		clear_tsk_thread_flag(p, TIF_32BIT);
 		childregs->softe = IRQS_ENABLED;
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 8955f2432c2d..2b8cf2f8ac4b 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -167,7 +167,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	memset(&p->thread.s, 0, sizeof(p->thread.s));
 
 	/* p->thread holds context to be restored by __switch_to() */
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		/* Kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gp = gp_in_global;
@@ -175,7 +175,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		childregs->status = SR_PP | SR_PIE;
 
 		p->thread.ra = (unsigned long)ret_from_kernel_thread;
-		p->thread.s[0] = (unsigned long)args->fn;
+		p->thread.s[0] = (unsigned long)args->fns->thread_fn;
 		p->thread.s[1] = (unsigned long)args->fn_arg;
 	} else {
 		*childregs = *(current_pt_regs());
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 3f5d2db0b854..b4cda7f71488 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -144,14 +144,14 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame->sf.gprs[9] = (unsigned long)frame;
 
 	/* Store access registers to kernel stack of new process. */
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		/* kernel thread */
 		memset(&frame->childregs, 0, sizeof(struct pt_regs));
 		frame->childregs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_DAT |
 				PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK;
 		frame->childregs.psw.addr =
 				(unsigned long)__ret_from_fork;
-		frame->childregs.gprs[9] = (unsigned long)args->fn;
+		frame->childregs.gprs[9] = (unsigned long)args->fns->thread_fn;
 		frame->childregs.gprs[10] = (unsigned long)args->fn_arg;
 		frame->childregs.orig_gpr2 = -1;
 		frame->childregs.last_break = 1;
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 92b6649d4929..ef7d7fd6a78c 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -111,11 +111,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 	childregs = task_pt_regs(p);
 	p->thread.sp = (unsigned long) childregs;
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		p->thread.pc = (unsigned long) ret_from_kernel_thread;
 		childregs->regs[4] = (unsigned long) args->fn_arg;
-		childregs->regs[5] = (unsigned long) args->fn;
+		childregs->regs[5] = (unsigned long) args->fns->thread_fn;
 		childregs->sr = SR_MD;
 #if defined(CONFIG_SH_FPU)
 		childregs->sr |= SR_FD;
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 33b0215a4182..a035775c47d5 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -298,12 +298,12 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	ti->ksp = (unsigned long) new_stack;
 	p->thread.kregs = childregs;
 
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		extern int nwindows;
 		unsigned long psr;
 		memset(new_stack, 0, STACKFRAME_SZ + TRACEREG_SZ);
 		ti->kpc = (((unsigned long) ret_from_kernel_thread) - 0x8);
-		childregs->u_regs[UREG_G1] = (unsigned long) args->fn;
+		childregs->u_regs[UREG_G1] = (unsigned long) args->fns->thread_fn;
 		childregs->u_regs[UREG_G2] = (unsigned long) args->fn_arg;
 		psr = childregs->psr = get_psr();
 		ti->kpsr = psr | PSR_PIL;
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 6335b698a4b4..332253a742c9 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -586,11 +586,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 				       sizeof(struct sparc_stackf));
 	t->fpsaved[0] = 0;
 
-	if (unlikely(args->fn)) {
+	if (unlikely(args->fns && args->fns->thread_fn)) {
 		memset(child_trap_frame, 0, child_stack_sz);
 		__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
 			(current_pt_regs()->tstate + 1) & TSTATE_CWP;
-		t->kregs->u_regs[UREG_G1] = (unsigned long) args->fn;
+		t->kregs->u_regs[UREG_G1] = (unsigned long) args->fns->thread_fn;
 		t->kregs->u_regs[UREG_G2] = (unsigned long) args->fn_arg;
 		return 0;
 	}
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 47830ade35ed..8e56c8c85707 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -165,7 +165,7 @@ int copy_thread(struct task_struct * p, const struct kernel_clone_args *args)
 
 	p->thread = (struct thread_struct) INIT_THREAD;
 
-	if (!args->fn) {
+	if (!args->fns || !args->fns->thread_fn) {
 	  	memcpy(&p->thread.regs.regs, current_pt_regs(),
 		       sizeof(p->thread.regs.regs));
 		PT_REGS_SET_SYSCALL_RETURN(&p->thread.regs, 0);
@@ -177,7 +177,7 @@ int copy_thread(struct task_struct * p, const struct kernel_clone_args *args)
 		arch_copy_thread(&current->thread.arch, &p->thread.arch);
 	} else {
 		get_safe_registers(p->thread.regs.regs.gp, p->thread.regs.regs.fp);
-		p->thread.request.u.thread.proc = args->fn;
+		p->thread.request.u.thread.proc = args->fns->thread_fn;
 		p->thread.request.u.thread.arg = args->fn_arg;
 		handler = new_thread_handler;
 	}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 40d156a31676..0bbf55b90c0e 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -134,6 +134,7 @@ static int set_new_tls(struct task_struct *p, unsigned long tls)
 int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
+	int (*thread_fn)(void *) = args->fns ? args->fns->thread_fn : NULL;
 	unsigned long sp = args->stack;
 	unsigned long tls = args->tls;
 	struct inactive_task_frame *frame;
@@ -173,13 +174,13 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame->flags = X86_EFLAGS_FIXED;
 #endif
 
-	fpu_clone(p, clone_flags, args->fn);
+	fpu_clone(p, clone_flags, thread_fn);
 
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		p->thread.pkru = pkru_get_init_value();
 		memset(childregs, 0, sizeof(struct pt_regs));
-		kthread_frame_init(frame, args->fn, args->fn_arg);
+		kthread_frame_init(frame, thread_fn, args->fn_arg);
 		return 0;
 	}
 
@@ -195,7 +196,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	if (sp)
 		childregs->sp = sp;
 
-	if (unlikely(args->fn)) {
+	if (unlikely(thread_fn)) {
 		/*
 		 * A user space thread, but it doesn't return to
 		 * ret_after_fork().
@@ -208,7 +209,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		 */
 		childregs->sp = 0;
 		childregs->ip = 0;
-		kthread_frame_init(frame, args->fn, args->fn_arg);
+		kthread_frame_init(frame, thread_fn, args->fn_arg);
 		return 0;
 	}
 
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 68e0e2f06d66..015720ce6e19 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -287,7 +287,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 #error Unsupported Xtensa ABI
 #endif
 
-	if (!args->fn) {
+	if (!args->fns || !args->fns->thread_fn) {
 		struct pt_regs *regs = current_pt_regs();
 		unsigned long usp = usp_thread_fn ?
 			usp_thread_fn : regs->areg[1];
@@ -339,14 +339,14 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		 * Window underflow will load registers from the
 		 * spill slots on the stack on return from _switch_to.
 		 */
-		SPILL_SLOT(childregs, 2) = (unsigned long)args->fn;
+		SPILL_SLOT(childregs, 2) = (unsigned long)args->fns->thread_fn;
 		SPILL_SLOT(childregs, 3) = (unsigned long)args->fn_arg;
 #elif defined(__XTENSA_CALL0_ABI__)
 		/*
 		 * a12 = thread_fn, a13 = thread_fn arg.
 		 * _switch_to epilogue will load registers from the stack.
 		 */
-		((unsigned long *)p->thread.sp)[0] = (unsigned long)args->fn;
+		((unsigned long *)p->thread.sp)[0] = (unsigned long)args->fns->thread_fn;
 		((unsigned long *)p->thread.sp)[1] = (unsigned long)args->fn_arg;
 #else
 #error Unsupported Xtensa ABI
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 357e0068497c..7a61ebbcdfe0 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -18,6 +18,10 @@ struct css_set;
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
+struct kernel_clone_fns {
+	int (*thread_fn)(void *fn_arg);
+};
+
 struct kernel_clone_args {
 	u64 flags;
 	int __user *pidfd;
@@ -34,7 +38,7 @@ struct kernel_clone_args {
 	int io_thread;
 	int kthread;
 	int idle;
-	int (*fn)(void *);
+	struct kernel_clone_fns *fns;
 	void *fn_arg;
 	struct cgroup *cgrp;
 	struct css_set *cset;
@@ -89,9 +93,11 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct task_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
-struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
+struct task_struct *create_io_thread(struct kernel_clone_fns *fns, void *fn_arg,
+				     int node);
 struct task_struct *fork_idle(int);
-extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
+extern pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
+			   unsigned long flags);
 extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 int kernel_wait(pid_t pid, int *stat);
diff --git a/init/main.c b/init/main.c
index e1c3911d7c70..d9889b67d9ee 100644
--- a/init/main.c
+++ b/init/main.c
@@ -683,6 +683,10 @@ static void __init setup_command_line(char *command_line)
 
 static __initdata DECLARE_COMPLETION(kthreadd_done);
 
+static struct kernel_clone_fns kthread_fns = {
+	.thread_fn	= kthreadd,
+};
+
 noinline void __ref rest_init(void)
 {
 	struct task_struct *tsk;
@@ -707,7 +711,7 @@ noinline void __ref rest_init(void)
 	rcu_read_unlock();
 
 	numa_default_policy();
-	pid = kernel_thread(kthreadd, NULL, CLONE_FS | CLONE_FILES);
+	pid = kernel_thread(&kthread_fns, NULL, CLONE_FS | CLONE_FILES);
 	rcu_read_lock();
 	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
 	rcu_read_unlock();
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 411bb2d1acd4..455df0c0deb5 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -739,6 +739,10 @@ static inline bool io_should_retry_thread(long err)
 	}
 }
 
+static struct kernel_clone_fns io_wqe_clone_fns = {
+	.thread_fn	= io_wqe_worker,
+};
+
 static void create_worker_cont(struct callback_head *cb)
 {
 	struct io_worker *worker;
@@ -748,7 +752,7 @@ static void create_worker_cont(struct callback_head *cb)
 	worker = container_of(cb, struct io_worker, create_work);
 	clear_bit_unlock(0, &worker->create_state);
 	wqe = worker->wqe;
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = create_io_thread(&io_wqe_clone_fns, worker, wqe->node);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 		io_worker_release(worker);
@@ -817,7 +821,7 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	if (index == IO_WQ_ACCT_BOUND)
 		worker->flags |= IO_WORKER_F_BOUND;
 
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = create_io_thread(&io_wqe_clone_fns, worker, wqe->node);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 	} else if (!io_should_retry_thread(PTR_ERR(tsk))) {
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 559652380672..8d60b9775798 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -312,6 +312,10 @@ static int io_sq_thread(void *data)
 	do_exit(0);
 }
 
+static struct kernel_clone_fns io_sq_clone_fns = {
+	.thread_fn	= io_sq_thread,
+};
+
 int io_sqpoll_wait_sq(struct io_ring_ctx *ctx)
 {
 	DEFINE_WAIT(wait);
@@ -395,7 +399,7 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 
 		sqd->task_pid = current->pid;
 		sqd->task_tgid = current->tgid;
-		tsk = create_io_thread(io_sq_thread, sqd, NUMA_NO_NODE);
+		tsk = create_io_thread(&io_sq_clone_fns, sqd, NUMA_NO_NODE);
 		if (IS_ERR(tsk)) {
 			ret = PTR_ERR(tsk);
 			goto err_sqpoll;
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..f308a5ae0ed3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2590,9 +2590,12 @@ static int idle_dummy(void *dummy)
 struct task_struct * __init fork_idle(int cpu)
 {
 	struct task_struct *task;
+	struct kernel_clone_fns fns = {
+		.thread_fn	= &idle_dummy,
+	};
 	struct kernel_clone_args args = {
 		.flags		= CLONE_VM,
-		.fn		= &idle_dummy,
+		.fns		= &fns,
 		.fn_arg		= NULL,
 		.kthread	= 1,
 		.idle		= 1,
@@ -2613,7 +2616,8 @@ struct task_struct * __init fork_idle(int cpu)
  * The returned task is inactive, and the caller must fire it up through
  * wake_up_new_task(p). All signals are blocked in the created task.
  */
-struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
+struct task_struct *create_io_thread(struct kernel_clone_fns *fns, void *fn_arg,
+				     int node)
 {
 	unsigned long flags = CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|
 				CLONE_IO;
@@ -2621,8 +2625,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.flags		= ((lower_32_bits(flags) | CLONE_VM |
 				    CLONE_UNTRACED) & ~CSIGNAL),
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
-		.fn		= fn,
-		.fn_arg		= arg,
+		.fns		= fns,
+		.fn_arg		= fn_arg,
 		.io_thread	= 1,
 	};
 
@@ -2727,14 +2731,15 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 /*
  * Create a kernel thread.
  */
-pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
+pid_t kernel_thread(struct kernel_clone_fns *fns, void *fn_arg,
+		    unsigned long flags)
 {
 	struct kernel_clone_args args = {
 		.flags		= ((lower_32_bits(flags) | CLONE_VM |
 				    CLONE_UNTRACED) & ~CSIGNAL),
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
-		.fn		= fn,
-		.fn_arg		= arg,
+		.fns		= fns,
+		.fn_arg		= fn_arg,
 		.kthread	= 1,
 	};
 
@@ -2746,11 +2751,14 @@ pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
  */
 pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags)
 {
+	struct kernel_clone_fns clone_fns = {
+		.thread_fn	= fn,
+	};
 	struct kernel_clone_args args = {
 		.flags		= ((lower_32_bits(flags) | CLONE_VM |
 				    CLONE_UNTRACED) & ~CSIGNAL),
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
-		.fn		= fn,
+		.fns		= &clone_fns,
 		.fn_arg		= arg,
 	};
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index f97fd01a2932..5e7c8f3f184f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -388,6 +388,10 @@ int tsk_fork_get_node(struct task_struct *tsk)
 	return NUMA_NO_NODE;
 }
 
+static struct kernel_clone_fns thread_clone_fns = {
+	.thread_fn	= kthread,
+};
+
 static void create_kthread(struct kthread_create_info *create)
 {
 	int pid;
@@ -396,7 +400,8 @@ static void create_kthread(struct kthread_create_info *create)
 	current->pref_node_fork = create->node;
 #endif
 	/* We want our own signal handler (we take no signals by default). */
-	pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD);
+	pid = kernel_thread(&thread_clone_fns, create,
+			    CLONE_FS | CLONE_FILES | SIGCHLD);
 	if (pid < 0) {
 		/* Release the structure when caller killed by a fatal signal. */
 		struct completion *done = xchg(&create->done, NULL);
-- 
2.25.1

