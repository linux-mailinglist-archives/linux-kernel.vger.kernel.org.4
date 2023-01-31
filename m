Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71D5683983
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjAaWoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjAaWnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:43:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9108A47080
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:43:49 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIiIW5021443;
        Tue, 31 Jan 2023 22:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=rdmUDSyMhz2W/a+vkSrakisRhiXl4iqAlBAA0WrriH0=;
 b=SKga3Yh3Wq4foOr2igtEnp8FHe0uOTssQ+uq5ZUX2pWqFT2DlUj7W7IdWla2uB17Jmzy
 iaKZ7k505c+D1H+5uVCz9g9Y3doNihV0pzUrvjctxstYgK012CevaOungMmt6VtLQuaH
 TMPBxTIHX16ftZXhx1s2ndGXLBGPmJ1rstxyNCl0Vc9ImCWZeSggRg7oqOsMPmP/BQgT
 JrNnGuhIJ/QaEjufdmTZ/z8QQQPskXHiVyYj+i3NA9cVZfn0P/InVfOrXMcyOAzM1fxz
 wUINtk7Ga9WzeSmWQldYowP9TJEeUre7bEnpWSikwiABdqZgcsocEc7Ht0d0W4l+zlvC NQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvr8q03e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:43:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VLG1Ot012963;
        Tue, 31 Jan 2023 22:43:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5d7q9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:43:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyCwaF/5D710PMzrORiD4eFamw6LAMSdGucDc9BOWEXmQc78DaaHzVF6ACyslzwm02mkZoPx3KrZ6/42Vx2sGmfYU0wQ/huHBb7XD1Eo09ur7coE0cGYmieW5L5c9QlS6RWfy8l/IqCTJEynEU7SR9ktkRdiYNCS9cUQGTzH+wXhZe/6EXBDpYZHM9mCPjVw5udRpAxUnFKUy7Sz1H/jMTGndp7x8iE1HWwoRpPr3KfHtwKuGJutkxTvyQgdEqP2op1mcXzrgsxRmcE61QDqLJN6WY6V/MD+989UGUeJmhYCgY/uczPV9vOcVYmizWVLjioHdrkPY1Vp4v8yZ9NLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdmUDSyMhz2W/a+vkSrakisRhiXl4iqAlBAA0WrriH0=;
 b=JA6EoU9LBEU0C7nAVdPzZb4t79J7XWTuDyhmmFYYs5SvIiedBFuAYJIL4Q5xOA0MLrA9IYJyTfvpmouxQWwT1E90A9JvEeZvtz0+9PrbeVkrTWp5h+kB3jwo8tam4wW46V5z5t8YCqwD4IIzk7/BTHwYAhAvrIAD36ZZX+LMPsC4QAiMZdYhTTCs88nGGum4LDBZIaDsbEDx23YwXR/3k4bwg3mNWboEOH4lxL1zYdFxNZoOoh4OZ1dml5ubPAKfmXiJZw0DQXfiVg061IMYiz1bdfrty8nBlg6DBdhXvG2G4FRTAOGUglQYKBhwV0iawya8GSEH7AIpjro4y8op0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdmUDSyMhz2W/a+vkSrakisRhiXl4iqAlBAA0WrriH0=;
 b=SLyAFcwibB8blGsoN0KzlQxskOhwhYVodMUTmx3e9S6IreT3ZionG09Zi9ZIaPWmzbelOzXuT5iSHCovhFvdjneOBCDORjQRWy6JtfDAJ3b8M5OQeDa48yw6vMmb3ISQnu3rRdH/ES4HSkDVyGnjR7rOXGYPWrE+xWRqvLCkBYk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 22:42:57 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%6]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 22:42:57 +0000
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
Subject: [PATCH v18 4/7] kexec: exclude elfcorehdr from the segment digest
Date:   Tue, 31 Jan 2023 17:42:33 -0500
Message-Id: <20230131224236.122805-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230131224236.122805-1-eric.devolder@oracle.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:5:100::30) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c18717-4ed4-430d-e3ef-08db03dc7f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jepb5nJJJJ//msmgyjg6Hid1+NO+3uft/C6Nf6gvUDmdFgcCGMaO4Lo9QDWW4zS1lxz3yzSvzWD6vfv4+Sz7vejUq6Xg8Wz+RNUeePgYHvkFvd9nyr5AXDoxYXnLirqak9gCRJSbPyo+2HnCseCY7VOCzsbcIOmaZCUnYcl73bhoGadolVEoeAFI34oGfGSnocVI5sjPWjAjYEt6U4WnYb8P2rTc1TaV+Sj5GpR7ZaDxetVQ13BTy/oQ4e42DWUGI2ZcZ6Csabki+gGS0tkp28dllNeSNmgi/WKWzxodGLyALYxlRkPuop9tkhkmpGeWuFXOuLB6OzRJ+CEpdABJ1jyyk7ke64rQbgiHD1SsdA0N4FVG4IO7+/vp5QK2dEMq8MSLHIO2mTdf7zxnnHGkYNq3jMiZ/t60ZDDHYnhcTvxmIWzttuF8AdV5O8TTNqWIXIUXqvS9qrUsks0eQGfExBFq2zRwysBGQEu4ctEiJf2WGW18SELMUopOmGJmwqp3jU89q72EeGnbbf/90v31ojmDX2pcIQBjV/xaGGrFu5yJ+afbnQM9AXpxzGrdB2yq8GhNhq/6Do13UhRQkQgUsjC74zlYoqREIT1LeAB3e8j72rERMY20m4/e45O2OopjJR2YK9F6xhsMbSxPlyOyZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199018)(2616005)(316002)(83380400001)(66556008)(41300700001)(8936002)(8676002)(66476007)(4326008)(66946007)(107886003)(6666004)(1076003)(186003)(6506007)(26005)(478600001)(6486002)(86362001)(6512007)(36756003)(2906002)(7416002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eaYNtiSmc1vbEtzt/qZGHbBvQsrkVx9xciVX3CY5xFmgjaYySMciUGDKsP95?=
 =?us-ascii?Q?cGjvKqhwYtEgoGjCHq9aKKm0d1KvuiA6vr3bKFvCZWaCsxk5HrrP9Gp9Qi/I?=
 =?us-ascii?Q?XmhS6h7c5PWWUZARCfI8DWIDBl5FBhKlBN+J7l7HQH9c41lzqy4szz9socYR?=
 =?us-ascii?Q?Svyrttea/vEVoPplaNk/5xrlDwdp9S2Kf66Yq3ISF2IPm/zaBefHuQmpqpXc?=
 =?us-ascii?Q?hIWGDvrNzCSyffue3fNPlizI6D/oSLoaB1wEmwe4B5YfmV7vJElK2Jt9XdIa?=
 =?us-ascii?Q?6MzLzpjx4pnD5MA9sVLGdMhuo/6eC4o5wrYAssZaTJJFRjqFTqpnjC86E1zt?=
 =?us-ascii?Q?JgK+drFMK9s3fyYI61MS8msxL2vjZCitBJUVmCcv4BE3Ufjj1BzPBghcITP7?=
 =?us-ascii?Q?mIqM8H3GC9xiAgxejKxoxQ0Wg/L1tHUBL0R5XZ3J6ULYDaGxfeXM82fkoPBd?=
 =?us-ascii?Q?e+wok88HePyLsySaG6DN+FYxTwc1oXIg53zht43h/ZhfDXiilOaa+zs3/qVM?=
 =?us-ascii?Q?XU5qXQhIA3N86XkS4giWvMg7GlV5jp9JTnCZDpP69xa9hCahoBda/nABgJPV?=
 =?us-ascii?Q?SpSMWg4I0fn9poR6QXGI576Sm/zxqmVDF85X2VACBBsYFQjc/wzEcYRM3bpR?=
 =?us-ascii?Q?zIJ5lwk4RSfBfthA0OKDIpYHqNmEmIc0H1dTVYfp8Jkz51FuLnL8UxisPeYs?=
 =?us-ascii?Q?mnBINXPiyruTnf/xEKJeltpv7gwdzEbcRHMiLVurgWYX10j5C2xXbUZRdHOC?=
 =?us-ascii?Q?1OQqMc0Fd2IjeXIoiGWXcNFKe/h+MdU2Sx1R2G/LYaltIORCkAmSEay0EMX/?=
 =?us-ascii?Q?yoolNsc2rZKUC1d+IF6MDECuBigNJcKc3uM7UvQIAPGh3vSAIbMHD9FGdTWW?=
 =?us-ascii?Q?Z6G/Fsuggmw66OjZyBwDXGsRhC58P/Ly5vkymmuM9oPOnGi5fjaErj7oDm2m?=
 =?us-ascii?Q?/o74x9AvOEPkHh00by8FGGAuPt3Y1oJ5y8WooYVfqEjymwjRE5PapQEdw0g5?=
 =?us-ascii?Q?OLyuGuYfPpBiQM5sQzemn1dBuzAXN06A7e4RRo/yJ6VRNUlOmc7IrEpJy8mN?=
 =?us-ascii?Q?d466mLFedIKyff7SBIjzu0o/tDeHxQu12zqHivH/sDeN1pJjgzJJZSctIbab?=
 =?us-ascii?Q?/w1pnKyBlGdZni/9WWHURPb+lYdbgo6sh8sqPhUYQCnAzG06hx0o/Sk18Knm?=
 =?us-ascii?Q?NH/lc1HzaineWZ1mGgkdJl2Inntn7RkhRM4qRZFKXmVNH5zJOeDj53QItFiW?=
 =?us-ascii?Q?t7GRq68rIhP1AhZ/2CpXlAPf6YvxZQdXjmlESFsCaPLydWToEWVRvlW2c/90?=
 =?us-ascii?Q?PvW+KP/5fNKezeW1yQ+RiP7oAPYEatGuRutaI+x6WDoOWLZN/4lE3xBP7QmR?=
 =?us-ascii?Q?lhy7QW9GfWEGpHSaNGttZfUt5Y0ACEAevTT4mwxmiK0rl2UqnJugojZpi+Li?=
 =?us-ascii?Q?cnIRH7onLiSjo1l8hRRdJPHV4WWXsx2RWOlbW4btbIQZSoBenAgO2/w80q2l?=
 =?us-ascii?Q?EnAaSIw62k1vxCadV3a0T7aocDKTiYJeRPMgo+f8cmfaR/tXDsRZdBNVIsMP?=
 =?us-ascii?Q?CANZscFf4doZLgcpYgZFgR+g+3XTazQ3Lnc/MGF5ELz6bi0ft5B7MXwQncMz?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ky1ShiU6YHTBnI6furvJ9miVslXC9XgW5xUviPPPSlqghlGUU9ggdZehDU+b?=
 =?us-ascii?Q?iDbEqGdy/HaMgL9xJk4jjiOdqr0CTL++5J00DKpkxeLDdeH5jTujZBHAlMvQ?=
 =?us-ascii?Q?7FNL+8yDHXXdZLqEZDerjUb0kggbiy+2H4fJL84nRQsVwNL6iz2HstNslqK4?=
 =?us-ascii?Q?SFpO2C/3TCQIYpJMVgYAufAHAoKvLKPBJdWc+GCCCLote7/HSyPJuQvhe6fc?=
 =?us-ascii?Q?3i727tWZ1WyVwNp1DRCEISrWfzcEqdTm21koW04eRI6vF3Zzx2mzJblRPZfR?=
 =?us-ascii?Q?Ydwafg801d+6hp1+ydu1DAVMyZhcse4lw1R1UyzwZcOP6HbTz7dErojWEbKe?=
 =?us-ascii?Q?5XVYl1ba2/crE87VuvPIg4/39Y/A2Gpr/woX8dhqzgWwg0zQs8VUMH9YCZCh?=
 =?us-ascii?Q?z5JvKNcepwXgI3PIykmVLuQeDGp0yTyQR6NB7gjsOgBDS6okqoKA7qI6xFvW?=
 =?us-ascii?Q?xPdMSCPOLQIjF/kYVlFr0GdOzaD9HxtIxyH6YuMFYDw1Q/+NK9Qkcn4FGNPO?=
 =?us-ascii?Q?4qleceF0MzCPajWjQpNBQGCSCDr8lb21d3hQAhURLru7QZRUJYw69Gi10KQK?=
 =?us-ascii?Q?OeIYQOh0LHAGtXjm1HfkBgExCkSk76ekJSQ+KvDbPlhCJzS7whpRzR0u3IcZ?=
 =?us-ascii?Q?KMNqCCdXDLn6DUcmyFvxFQL0wNBFdIdvFEJwlzVxnu8cft6VlFBA2DxXvIsb?=
 =?us-ascii?Q?8/yQviFpSh63td4DCBbZBp7B4v75eKTvFRzKXzBSrWhdFIkcD3poPSkzWusv?=
 =?us-ascii?Q?194x5D+P7MmvQ3DCgm+FpZivNyKyckt931MYKxSKGfI2lteNG8pgoWs75sIh?=
 =?us-ascii?Q?QYucfTSqx+JGBQdAvfLUwuFteyEQCnJXKqDRrYxE3gywwGlMy05pLULFIsea?=
 =?us-ascii?Q?yxjXPwwSpBeTjQ+FSF+4xsMEICNaQX10rv/gOBFguLwTPxKMm8oqcCCtip0W?=
 =?us-ascii?Q?Kk1876WgsrlQIkSko/zx1+gT0gqOt/k+J1lgOQj/tjlZruejnRqw5xER3fSw?=
 =?us-ascii?Q?CmoFnSfyGkxrZ1aPPyr+VoVI4Sc9jkx87Ec6VEoiuQTlcfk/ZpNzjXEhhIOi?=
 =?us-ascii?Q?LLn0dMtvpTeaDSRyT6nC461hi1w28H/ACmKfpzgJfG8Fe1g6iv+5NJLuhvoA?=
 =?us-ascii?Q?yF+saUDPHWznTnw1jcHUuHN3O1wih6hfS37brOYQHlmhUv8UOBYsHsU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c18717-4ed4-430d-e3ef-08db03dc7f51
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:42:56.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+cq4pzgVAqjFWK6wGV+Hp23H3xfIvfPgX41d+8TgL9qof3+5otfc/D8rG90qtLqqZqwLynquCz/dsatjwgOmBQ+RoR/ZSQLE9F7h3XGhGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310196
X-Proofpoint-GUID: KUBSU5FZOglZrqNta8C2HSXJlObsRoLf
X-Proofpoint-ORIG-GUID: KUBSU5FZOglZrqNta8C2HSXJlObsRoLf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load() syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. This digest is embedded into
the purgatory image prior to placing purgatory in memory.

This patchset updates the elfcorehdr on CPU or memory changes.
However, changes to the elfcorehdr in turn cause purgatory
integrity checking to fail (at crash time, and no vmcore created).
Therefore, this patch explicitly excludes the elfcorehdr segment
from the list of segments used to create the digest. By doing so,
this permits updates to the elfcorehdr in response to CPU or memory
changes, and avoids the need to also recompute the hash digest and
reload purgatory.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ead3443e7f9d..2f3b20b52e5d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -723,6 +723,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Exclude elfcorehdr segment to allow future changes via hotplug */
+		if (image->elfcorehdr_index_valid && (j == image->elfcorehdr_index))
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

