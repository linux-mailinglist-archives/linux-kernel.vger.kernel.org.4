Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED316CAE65
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjC0TRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjC0TRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:17:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90A1D9;
        Mon, 27 Mar 2023 12:17:45 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RJ55sl018498;
        Mon, 27 Mar 2023 19:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=VnpI2Gvi7Smh/3FsKX4dsYh/0s6PiNkODXYZWnTIp3U=;
 b=rsLp9ZQGRH37KTemYGZL6rtwHqNNlaFft1vE9Tc/kFGzJC0rznvUeZlby3NjD8KN/OOL
 LicuzmJx1s2RZxSTs0qPDesYRhH3vC4BnUsC0Vvw9Tx606L4DX77zWFJVfOLQjnQxP8T
 U06fopc1Vu6JQmTwY3PYCYPgP5GDkImufetAFxvX8jplXyRogYiKjYfKHbDwWTO91vnd
 GZZdkzJk0Fh4gFD1Lif+8g2ow0yPbirWpf7BdLnMZgvaibfeeRVuCgCrXsLjSLIqNob8
 9Rg/sMtZk4J5DnlKAQH8DNjv7WZillo0H6rhzehRCs6CJ6Y5j6YYl/qoYp2A4FBCQISd 3w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkgyt00rh-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 19:17:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32RIb896020336;
        Mon, 27 Mar 2023 19:10:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd5n06h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 19:10:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miTLfS97Qy33pj2nYiIK4M2mBR/TYyMDK9wFYCJHf/9XzyxsCf5fM2Hhf+mNrQ3KNbtHYgFt79mZo+Im8EbVvH6gcPuR7QUdAwXSKCL9GSyZqyCwUBIdWUWpD34NpnD3o8Nn7WxueDMRVi5qS9DnRpr2sceFDZbgUDpgKXZ3HHWa5AKe3pHP1LIlU2oIVp6Zh2DT03dEYFdzoxTHXdELRlvid6oSM9hkilQQwoFM5bvBhBRNmtfpjuKqExOKuYvKl0xBm1WtBaLlawb+9RKRAZd5cglStAb/lshFq/wFPwTHyZ4BRJ0CClX62Zug4aqlwc/x51xzq+S64cNBKpPnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnpI2Gvi7Smh/3FsKX4dsYh/0s6PiNkODXYZWnTIp3U=;
 b=XQ/tAk3BbSTAk3IiXazM83cE/NfaVp+k3Q8+84Fpj5Aek8FiCDrw8p1kqZqD7Vf2eNdOTY8YAipWTz02ilUbeSQY/TUk8qQ6pJfegnno/M+AXiBnebA79JQekVWNtECiN6eJu8Lrio+aBX8g0Gc3gHMiIAjoWoGm5YDWyCZXsNfMHPOLwOiatuFLkw2ihtLyboSgj5s5+AJdl+Mth8I51ZBNHyLWa/Ph7Q1QgcjLUmA+0XqN70eakjRcuNh1MMicRSontSR3tLO1qy0ciOiydw4hhkkPfYY1F00cPeE5xipIshMY0PywnbQPlgH/tMqlT2EMNcbiM1Y9molTyAkm8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnpI2Gvi7Smh/3FsKX4dsYh/0s6PiNkODXYZWnTIp3U=;
 b=urt2lQjTg2k3uxTRFHAWerCD7lWM3JNarcYmOBfUpy1iAUQzrMmMbOm4SCUqz3VT0Q0hGJUFRR3s1DWp1ZFEld+IwhI2vnTlAixK7DLg8wOvh+P1q6L/ShvYCqQ10tAHKZTSWDxmcZkB21FD12eOdbUt2gJEEjRqp40+HS2Ui/g=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4671.namprd10.prod.outlook.com (2603:10b6:a03:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:10:38 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3%6]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 19:10:38 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     rafael@kernel.org, lenb@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        kvijayab@amd.com
Cc:     miguel.luis@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH 0/1] x86/acpi: acpi_is_processor_usable() dropping possible cpus
Date:   Mon, 27 Mar 2023 15:10:25 -0400
Message-Id: <20230327191026.3454-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:806:22::11) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB4671:EE_
X-MS-Office365-Filtering-Correlation-Id: b17c69bf-cb7a-428c-e67c-08db2ef6f377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 53mJSqTy6P9uuAu3q9LPOtwGdN4jJYvdYzJrEJWY6hiKebwZOxV6Eqv5KV7jJiwwqMq5md0zTQYmRFVahOMWGjKskbHbbRsv6dhzjgLywcJWGRK8GhLHZqfKLGuo8ZLQCWS7a5XslXgUTENaJ4Vxm+CHxkcGr+DXzUQAVJ5u1B9J5owZvg7uzTwZc72TEm/cJ7joEqkGRqlID+Ne/J5ezDHXB+X2dyPiuG8OhUkp7is8l/3I8I19B3mpchQjJe1rkzmbtBlkqYdUWUSoJJZtHqOypzylOoCo35hwG6TxCJ/K4Z4KAlTuhgJEwcJ4w7zB8laFN7atwz4fDRPiwSK0i68Tp0+V5Phdrlj+L7FrClSh4AS2xtZukKGeYHIeMVYK4HaEPUa8jCUwQSgasqGTacTJzX8RuhAsQZQEZ6YU1A6+vaef4m8rvLAkBsISOez49DGpG9D0oSFvY1NOqH+DkhoB59AGrq+C1R0oPgcocJPOqberwEBTSt5bZE0LoEL1SI+zSLwg/crO0gNl5s53i91EOTXyoIs57iRjCp5pJtxCH3qIrzvuKNsltUUvIqlykDfzYJQwqqpxbRDO+D1Umfctn1+dc+tIO3k15tChKw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(921005)(38100700002)(36756003)(66946007)(86362001)(66476007)(66556008)(8676002)(316002)(186003)(8936002)(7416002)(5660300002)(2616005)(41300700001)(6666004)(107886003)(478600001)(6486002)(6512007)(6506007)(26005)(1076003)(4326008)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r8FzJGzJKWtV1Kha8enZMEFQysd8nq3v4IsthHdz8tK5xhiWHxTvYuWQ+aYK?=
 =?us-ascii?Q?GpthMLHpoC9I9Nf7/RUUlknoMIelKNHPoLsMp4uIu27XaiBf8zTCVYBg+Zjp?=
 =?us-ascii?Q?kvVjgaYKeUD/2/OIfLRpIQhZb/JM29VnFTnnSBpRrXf2X8lYaj9JppahBfjt?=
 =?us-ascii?Q?xGab1TqiIC+1MvFkN0jDSGigWgyVS2SJTi45pdvo2fyvN4uymykPrQkAJRCa?=
 =?us-ascii?Q?RYseKv6c3qaMkI1YbNmEBobHV/pdEuIdxS0hvZ9arLX9zFQfRRmuOvDccAnv?=
 =?us-ascii?Q?PSD9bDq4NZCruTueYHgGO82iU0rBIrer2IeGQ0pgDW9ssXw8ZcRkKl8tXZf/?=
 =?us-ascii?Q?5rHgyLRtEiO4EaqyCqOcE0FkpIorpnjLenpi0cKx4gcfrDHUL3pujchxfWQq?=
 =?us-ascii?Q?9FrtcAYSwazxSN9FKBbPGlJHoMlU1gffBxESOTWviFq1GnJsd1O53+/00gPh?=
 =?us-ascii?Q?WADwZlMwCq3mDR1KHYsiBBnQ+e7EtHvlGLxmQCq7L3Mls4y1U9IpB09pvpR6?=
 =?us-ascii?Q?J4DnLXsXQ6mFyBRqO3iJm1pChma9MOpW7Hi/X0j2jWaroTSpLhQHqeAlQ261?=
 =?us-ascii?Q?m4QpW26I7sqF+H7CcBkdbmf3XM/+djRfcmOn14t9UIrARJfLxvPwyAH/XUaX?=
 =?us-ascii?Q?sV8AekDWVtP6CBm7LEIPGjPdS8yJeYd2Kk9xnW6N4I3g16j8Ex+n7AxtARey?=
 =?us-ascii?Q?raFeXzHNcBBUGvZOOa+B70691T8xIBOYCrGSiXukxi5O7O8TE4VM29MlrKrP?=
 =?us-ascii?Q?FtbWSk9XJM2e4AV6Si8K99cTRZcJgrPzsGcWF48lUWcpaIJdSoI11yr77xAE?=
 =?us-ascii?Q?3+yF+FgPZ02lG8PVc0Ra7xLBxAN7YZOGbrglSaH98g0AO69N4MVO3OuCTaeQ?=
 =?us-ascii?Q?ul++DRZDas/OoKzCwebrmgiEBtqjfYRiuIDL3uvnALx8BHyRQj/3GbXyZ3MC?=
 =?us-ascii?Q?pQR7EnLv6cgVrlgv0mfQSHLUkwE1RUwhLtB4nj+5uUyAmncKKJTjUJcT6q+H?=
 =?us-ascii?Q?7hUYkrApcxteOQCOFpeR+5KQqAwmFOoznoQrl7ib+RCOQlQjsP07+aU96ch9?=
 =?us-ascii?Q?LcZmka9dPaqZkSO3wMgjYegy6JkYvxQRsSYXvzZCt8s6Zf9B0+IoT5+zxXCx?=
 =?us-ascii?Q?m5VR0Oo969RqnxWrygB6x+5pGJEvIk/bfrVKDLUdadr5aCZYBojojVbkTfzf?=
 =?us-ascii?Q?mC86rot9utWthHffBkLxAILg8nL4ex/iT/XtX2+kSvAyUhohSQJGhTia+oot?=
 =?us-ascii?Q?8IvPXlUgkjzwL7ZEifr8+EREFHvTLWtcyv2sHGSmmCyjpigh7kovn0zAOX3V?=
 =?us-ascii?Q?dWKoFfui8tbP/NQeA73E+QBQfCHcOBemBdPoMnjyM4hiWIk1tdJueIJlslbT?=
 =?us-ascii?Q?i0oOGBnnFo91FTrI9lp7eLHrzfcdgpw+0VpHMz4/3wgEYyQdwekvx0a3KQX2?=
 =?us-ascii?Q?dGzfTx7Kp+iDF7nDhg+20rq2Ibe29+YU38Cq/jYCyN3uuCHJWO/fViCSsOYj?=
 =?us-ascii?Q?sqi+gU355Mq6Ssw/+990Pqoq9vuF5I5h+Vw7wLMCy24xG6YovKW0OQjEb7Kn?=
 =?us-ascii?Q?sOtaniLLEN9gGi8s+KLbqjF3IEOyvnbndphheKFu4eOh+y07KefuDnxR2asM?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YZbsClHb8x0nqYlYQmRG9yFa6MmP7oXBOzbofesRNULRL0qlsYBbdv74QxLX?=
 =?us-ascii?Q?hCPmmKvdFblXmuRn7ZUZXxhqmoIUeVhA1CF+kP5OP1cMtQ8cyrrhXmsy4Ud6?=
 =?us-ascii?Q?XG8LfN2VIE6Om55jYy1WBndpOo2BNzuS4wykv1GQvIBvwfcs7MZ6dr2ZDSXM?=
 =?us-ascii?Q?V3SBGEA6jrrtCqUEPJ4k/a9L5d9KbqQXOHfxGlLfH7VkTDzzHacoZl3bXyd9?=
 =?us-ascii?Q?0o2fi41mpP/PIrjeGB5aTLA7CvAY2hlgGY86q/kTdK9b8sQe9zxVSK0FiELt?=
 =?us-ascii?Q?Jh0NuXYHrPcJsHIcBDtPS9zuQTazLqY8xLpEv1q8Rh+M5U4KJnFvCgRACOPf?=
 =?us-ascii?Q?lvB+xnGvTegprE0luiNqkFQcU4dTmmuChxiWY9leXFGAc8goa+40F30Uli1+?=
 =?us-ascii?Q?kEP7NddPQf/a3IiwgGM4c4haDP8/+A5dyrBbGWRFD48G6JeV1lAE28qp88Q1?=
 =?us-ascii?Q?59HCcg5M6VvlOyf5zUZSjmT7IjSVL0R7aAfFsenV1UjgloGpL8ZPUFN4aUUs?=
 =?us-ascii?Q?kh9ki7YDdwm8rdcz4FPfCEj72B18EGTznAliFOKtwK2TVIIVTcy0VeZa6BwR?=
 =?us-ascii?Q?dioRQHZXYpatqlCWoz/7C77X02ND1eoKhKmLaNeN/dY9+Zdn/Zx4vNHuqAcL?=
 =?us-ascii?Q?ymIowIbb+r6fZdZwGvjkmsg+JPj2tAZtFVowbzDOlrHRGNDjl8zqyTP8GIyt?=
 =?us-ascii?Q?bnENSSZgGgvwv4ltPBU11pJtV07cfGqrpCUZ0Ix94EEMq29G/ShqsVFWDx0E?=
 =?us-ascii?Q?IY52ZLE35o9+pdWKQ3/KloHm7aSl4kuHUm7SWDR3eDY1PaA/7QET70uqoK6J?=
 =?us-ascii?Q?akKrn34z5hXI2tHQUhOTx2Lxo/Zul/iDmTRGz9mKyirT5Cx9YxNAQdoIxARL?=
 =?us-ascii?Q?vgigSYnCKIwmCH4G7Ly1pj+rCQF2vKnGkGa7SZRJeKB7CL/W+tAAgdJxVldw?=
 =?us-ascii?Q?15O5rAX1t7LrE75e7vcFHJFDHuOyVoXE1TZFuyZjagw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17c69bf-cb7a-428c-e67c-08db2ef6f377
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:10:38.6353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUSwZ6wn2liFCkocVPkq2Xo7Z5MZFI6qQ9o9an0qyTEgjCllBLZye3BczjJ3IFznwECrA5/jEd0y0wOPrksvwHOceqr7ChMXEF4+ygZoAyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=476 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270157
X-Proofpoint-ORIG-GUID: OPscfHbNHUdHHCwlpR_YBb2eFD-oyUeT
X-Proofpoint-GUID: OPscfHbNHUdHHCwlpR_YBb2eFD-oyUeT
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been working on a patch series for cpu hotplug and kdump and
noticed recently that utilizing a QEMU guest to test cpu hotplug was
causing the following error messages:

    APIC: NR_CPUS/possible_cpus limit of 30 reached. Processor 30/0x.
    ACPI: Unable to map lapic to logical cpu number
    acpi LNXCPU:1e: Enumeration failure

where prior cpu hotplug would typically result in messages similar to:

    CPU30 has been hot-added
    smpboot: Booting Node 0 Processor 30 APIC 0x1e
    Will online and init hotplugged CPU: 30

The QEMU guest incantation was:

    qemu-system-x86_64 -smp 30,maxcpus=32 ...

A simple guest with 30 cpus and possiblly up to 32, meaning two hot
pluggable.

An investigation lead to finding the following relevant changes:

   commit aa06e20f1be6 ("x86/acpi: Don't add CPUs that are not online capable")
   commit e2869bd7af60 ("x86/acpi/boot: Do not register processors that cannot be onlined for x2APIC")

The first patch codes the fact that ACPI 6.3 now features an Online
Capable bit in MADT.revision >= 5. This Online Capable bit explicitly
indicates that the cpu can be hotplugged.

The second patch refactors the first a bit in order to apply the same
logic for both lapic and x2apic. However, there is a subtle change in
the logic to this patch that breaks for MADT.revision prior to 5.

As it turns out, QEMU reports revision 1 in the MADT table for x86.
(Technically QEMU is at revision 4, and I'll be addressing that with
the QEMU folks soon.)

In looking at these patches and understanding the logic, I can sum it
up by stating that prior to MADT revision 5, the presence of a
lapic/x2apic structure _implicitly_ was used to determine that a cpu
might be hotpluggable, and it would count towards possible cpus. With
MADT.revision >= 5, that implicit assumption is now replaced with an
explicit indication.

The manner in which the latest patch is coded, it essentially requires
the Online Capable bit introduced at MADT.revision >= 5 be set for
present-but-offline cpus, else it excludes the cpu from the possible
cpus. Thus for MADT.revision < 5, possible cpus are being dropped.

This patch aims to restore the behavior for MADT.revision prior to 5
which facilitates again cpu hotplug for QEMU guests.

Regards,
eric
---


Eric DeVolder (1):
  x86/acpi: acpi_is_processor_usable() dropping possible cpus

 arch/x86/kernel/acpi/boot.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.31.1

