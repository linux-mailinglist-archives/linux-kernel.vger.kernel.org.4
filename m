Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1016D6B2F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjDDSFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbjDDSEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:04:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6E84219
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:04:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334DwtrG022669;
        Tue, 4 Apr 2023 18:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=vQVFlom304Zmzd+iNcoZIdmjn9O6Eur26Ibd7OK8M/Q=;
 b=nHamcrV5+h/MwQZ1VCO6D+57CzfEcuVGZvRuL7val7d1ny8mI7KRpXwuEYOCVXnC3rLI
 JHZ2/MvYBGb6fg4AeTCpT07NcvgVjC53YDgswNQH5/GHGJYDMGiEGjJBOROEyyeXxySU
 JolPjK9ESjpmd4rJzZdQZ5K57L0FMvmrkDgXfSe/weUaU3rnHKvFR9wsOfDe9Yw0lXak
 o11EPptzfarC480QMLGyh9nl1vD3Sz7qYxSc+m4gR+rNRSsr+erNTqM/9goY+UGMOT6r
 1wkMNpIur5/vH4TUjg/1Sbsphf7dfIhokP35mXvHrCTfJ9tpSTfNgpEmzbEk6UxNQvti 2g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7txg02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:04:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334GpFWU001253;
        Tue, 4 Apr 2023 18:04:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3hg1nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:04:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ao7GTM418pnlG8C8R/BkI5ci0li5km1J0HUqPY4O5JpzIC0YQMQedhnLtyNvwC0Pv2DBy+oYVDMW+UQN7E7uNIQ4kskuucbs123+0NTciVbc5udgPfg2A1vVucrI8yEmnoKAfQCK0tzF+ud2XTYgCZ48NutecL873f7CUvoGy4WjOVHgQLuzsYbqLeu86otlysgTKPAq6egt1PflcfypE/3vl7L8LuO/UBv2dkHSWUvDNzntTF0WxJhR3btKHXEQk0DqMgux9Mrf8BGFTKgxmLBLL2U2kRAPxCl7zXghBt4IvSQjkFVDOh4X3hGf10XIcZ5TjatuAoVD5YF35RWJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQVFlom304Zmzd+iNcoZIdmjn9O6Eur26Ibd7OK8M/Q=;
 b=bM7Pnl/ND+rfwgMVVMdZeBo7ffYm7dSISKz9GxVmclilAlvfQvWrX+0QcO1lRsz2XJDWFobpedpiayL+CgPkCgnBm9QuLhrOd9AE0aM/NTbF6ZyM+8sCDZDk5WNBq8tOd2Aji4HlVRkS/1IxLJdUxQKFefjtC5wGsKzZvogP47VqQY9/sB87IDe69rBvvYB8kZRSbCJuja32h+HV2dnUPU1yVkxU61hNiHPoNq2aGXATqVd4txyO/365r538nbcqULM9xuvWo+DKq0y5qP0R0/8FKFjFI2ZFkPja/W0Ulr/+ZUjcUYhIPRTjBzCjqwwdbYVDjXiwq5IjhB16NeQxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQVFlom304Zmzd+iNcoZIdmjn9O6Eur26Ibd7OK8M/Q=;
 b=c9tXgCvA5MdMXMkQTcniuqU9sCUnYdEJUXOoK/3YiLjpQscqc0fXZuqQkO4P2bPSBQcNpw35xha+VfdR9bBbeyDZ7HOs0OgrDf4Z6xihciJmxTcOBu1kl/3XYX1JPub+9MDT+I+GbHXo1Z6dHHNsrtymAn1hhWcHdgGcfo6cwis=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN0PR10MB5909.namprd10.prod.outlook.com (2603:10b6:208:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 18:04:11 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3%9]) with mapi id 15.20.6254.028; Tue, 4 Apr 2023
 18:04:11 +0000
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
Subject: [PATCH v21 6/7] crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
Date:   Tue,  4 Apr 2023 14:03:25 -0400
Message-Id: <20230404180326.6890-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404180326.6890-1-eric.devolder@oracle.com>
References: <20230404180326.6890-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN0PR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d353f33-25d0-4961-e87d-08db3536fe47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlZoRSIcBu40BwdWTiEEzcJMHzusPBoI/14bbXrj0vu5Uhj92+5twsezS8L8Y8iSl5Y5sfiMoNyfqEoqtgxEn8Jba+D5T4KeAlaOnyJTPUuvToTz2xN+rujjc/0XwhT+fbkdhFdgXHbRE5rENOLS3qFEesHywSIXOPrVVYMAOqy+l+UHNltll/ecthv7xkUI+dnGMy4E5UCf3xE98A9qDr4Q62WSM4jOptFKJKjvIQ+919NvcVdcIOAGYIbr4dtwhuYB365RTW1E94/WiQFVLCnQ0h6N+4oYqfNbjZkDOls/BUN7UwIjm8xdluzpIXWgcuiWeIvJv2NxaB5v096x5yc92Ukzo5Ekt2P6w6zM68sqs6im98uRAw6FNYRlv/iYW0DcnBnZrXhbvMiO/EWj3SQn0YtPZfLpyXbIkEyJq55Gx5MlnO394jxzgrCr3G5Te44tX/F2Ulna6U2K1I4WsbURX1zhrfZzwvEequWMqqIxDwLKbNCWNOZuvLjvQ0sVGIMzBbWnt7qH57eJ82MFN5aSI8qrb5K7AG+8E/FsKuqkQ1zx43lQ4SZBKcYiFCSY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(83380400001)(4326008)(8676002)(66946007)(316002)(66556008)(66476007)(86362001)(2906002)(41300700001)(478600001)(36756003)(38100700002)(2616005)(8936002)(6486002)(5660300002)(6512007)(7416002)(186003)(107886003)(6666004)(26005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gq0VzHEgaipGnUm7PPfhFSuRZJMdo6zNdD7FQSMY/bpKH/dxFrkzdfG863dz?=
 =?us-ascii?Q?QxQg7NHGFpX9Auc31tA5Ol4+7hAbQOXhcUEVwrNwZqvoP4v4q/LLpdlP9ehI?=
 =?us-ascii?Q?oQca5DoWPh8tjFMW7EqjTO369ghl85V9E0tYF763MGywecK4Vn1DjOAPDGjr?=
 =?us-ascii?Q?0TaEut6/ZVEvzHaEailX1uLw8YUbTqPQl18oydt4GJaNkQ3BPf7hRK/3Svxs?=
 =?us-ascii?Q?TmyLcOId5hc3v0PU8II4mcVYpoOZkTI4Y0q8Ez0jqbPMwhlae+ROvRb1mGOn?=
 =?us-ascii?Q?Z6ub1NjQXld4LDFzl4es0OEGzyBMGEG8V/FsGxSJHHPLixOKRQI3Ll72Vyq1?=
 =?us-ascii?Q?Lnsajfe9ujvUN2pXXEl9C36e+n28tUaSm2SyNqAFkwjIq4EzoFNgCkchcKle?=
 =?us-ascii?Q?a49qhqdnjx+9FQSAFX0AFHSv6wrCqasfnXOv0wQq5xFPZWd1XTYZlhUHrTM9?=
 =?us-ascii?Q?mOX0TMQATLy+MQunCsC+c3MG1h4laJCdgsMf/hBdrzpEAMAMjhSENr0eK6j3?=
 =?us-ascii?Q?MuyWk/OqLkUv7d6Dla4RqxfzLmwGVcFieCxU1o55c8xjmwrlAUAEb+0cQS9E?=
 =?us-ascii?Q?HkdlfOYk6jLpL+5L2Z4hVOyrhTIaST+dvGRUNcn9K4rICST19nnBiuwXRbbX?=
 =?us-ascii?Q?q+UqPBjXoy6wMNyhWld59jdwsF/BOhaL+fga//LQEFjzz4BzI53zPGSeF6ly?=
 =?us-ascii?Q?fsu0iP+wyuEPfwa4c1p6Vx03voeX0G+bGPK9/MogSV6onwX1lHFekUioJdTR?=
 =?us-ascii?Q?xSAv/y9NX6sBOzDhh/CAD+mFhpcJqhW5AEQTJzyfJu8NqsubSIXlw0pVxL55?=
 =?us-ascii?Q?B+vDe2czgmXTAz730yGSFmBPiQunfLtGjx62xxv4c+3q+L8dlRqyGKmvgH1U?=
 =?us-ascii?Q?qUjoSg/ENddSFGe6u23AoQamkEP2KPgBJ8MzDNt01YdpiM2BVxTcr24+rsJw?=
 =?us-ascii?Q?XrmwbPdRyoGTrcjTErm9xvjyz0JslRy/gT2kW3HDeey8Tr9zp4TLYv3W8qDS?=
 =?us-ascii?Q?S9GihdiGtQkm4LAe+1HkPRY9Bq/S16grjauZ4AFY+1UXvMjijlHIhu/a5ulD?=
 =?us-ascii?Q?ZHnp3H4Vy7K5azbe0P+Vql1aK5EZNqWonfLGFPsxaaXSrX1enh8dI1+7NSvM?=
 =?us-ascii?Q?NPUrLnY1HDn+ACCWz3B29bTYFzl4GAcR1fJDuv1HoAQLzzIPEK+5ZjL1bdl7?=
 =?us-ascii?Q?cwdfq3ynu5epZoYE7D3HZdzHu5rwFKfnl/ee6HLPVHiDDbcfBkcQNw86GJJj?=
 =?us-ascii?Q?Y58sBZ0y84WXQzptiuPCkB5oWm4ur9YkRKS6SYkhh0/q2UeyqUO9shkBFGY/?=
 =?us-ascii?Q?IuCsLAWbf0rBNNuO3wi9fXgm9SXkVszJ1psPiuQrt/v6ANKxCWENW61Qt3kg?=
 =?us-ascii?Q?Zzg+ySxwzw83k4jztEK8InK0ZB+mBtd6vWTr9trQzLwuLT+mMJMu9D23v7EB?=
 =?us-ascii?Q?XoqXmljif6JMQ/cuTjEF5/KcdcCjxaPDZkWFeBtFwkro4sQrIWqRormd2cbl?=
 =?us-ascii?Q?hW/LgzdaD+DVGFLQ3Dkp+Md4bpHZ2i5I1wHYxbcejVhMQcEb1BrqqRgZaZwq?=
 =?us-ascii?Q?PLQDrOXhedPqKk+zHwMTf7mv4xxTnhbI0zNIflwN/R88Va8PW57gFOJhdn6J?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KO5XiTF3Y/vhESntdPmIhlIlhQ2/QDfh5s8Zr0POE8riH8KES73Ygs4MDtp2?=
 =?us-ascii?Q?JUBjXcLEFwtgdUgHK/KEniTuFiO53tgC9TPPRs6kWSpanszJfWNeT7Z+/l8z?=
 =?us-ascii?Q?NMRS6bHL3rxV8bPyGlSZOS/fbYqo3MV5z2W9THE7tgiPJBWj/TsEso1ttqRC?=
 =?us-ascii?Q?l1nWRXIM2dlBlDAmU9E5ipx4azzfdOhFMAqJmUOC8ob0Ool74rKoay4SISmh?=
 =?us-ascii?Q?vZrvloPxCV4wCT58xreqbTCRwxE2SYYD/XfCXtKRPQ+N4dY9xDpNAv4LO+6U?=
 =?us-ascii?Q?Hgwtz+xEFZePa7cx7IT4uLNo5igOkcBnD3rFk6H3bV6ozO22yynGUem9C7du?=
 =?us-ascii?Q?wOnrieMNax8uGaIgRhaxCS3/n9Surno7zCJRVcQ6naiV0WQlizDUTP1PbBOJ?=
 =?us-ascii?Q?hTzqHaFglcf+DWVe48JfEIulYEDa3WlZns22+WKrX07V5kEQ/Q4DlNh+UfQi?=
 =?us-ascii?Q?ynQ1DUILr4hT5SC8ZUUyyPoMYhcEzm1Eu8NNFY/YWU+PdQn1pXFxyv95qVd3?=
 =?us-ascii?Q?Dj4Py7JoE5lJYFEBrucZWeq5UO9Ipi9cXf1aR8FSfHXHQosSidFBbVOmoHlt?=
 =?us-ascii?Q?8W9OfL9Ln6qucBACylAu0jIATd8gDRVau53oTqkGLBMAcpTjqGDvazvZbsHO?=
 =?us-ascii?Q?wde3sm60y3US3b21POyllD0y209pewNpmd5xi1xDIGnyCMrygEU5fuwdBDGw?=
 =?us-ascii?Q?WhnFc5Sz8afmp1Pq4ohsu+4WgPa6fTpikmjY6PKmrs265tYB3dMEnaSfX4Ae?=
 =?us-ascii?Q?S0iRUNx2q3U3c0pPz3CYUh3lc1m03OPPAzZ9SHjWgIRiPb4ZND0up/mb2H7/?=
 =?us-ascii?Q?WjyZSIZphkNZXFG0TYGj7NV7oCiAtJmBYWoQ6rgsqP9MWUMsn+yoE50nB9Wl?=
 =?us-ascii?Q?2HOKjkvQVhcnWGyxXnWf8iX9nwDqjKGv15SjffB/4TYwrJ3/wSy79qoZpweq?=
 =?us-ascii?Q?m5tT/FHsm0q6wjwYnnnJkcDIzONzwfXGU+YMYYbTm32Yxyp/WWGXa8t2PY0K?=
 =?us-ascii?Q?MEigzvU9grw/AIH87UUKXR/2O95EQGCRUCSH/StcUEmJLSA7XFc3UIJeNlcp?=
 =?us-ascii?Q?vgKMHNE5nbvH79JyzBZlmK19wWg49VT7d0Qw/U3IqnwPnqZqeiww410B1SNn?=
 =?us-ascii?Q?k0occEWYCL1DfvckEGyLCFlRUB3RdhLRtvNNOfrQ4JvW5eHxaGGjzbM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d353f33-25d0-4961-e87d-08db3536fe47
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:04:11.6432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eOW5BwqhNOpjrA9pL8ZgBCEf9BcsqkPqa1Ly6g0sng/sLD5PbIkJpxVmNOoMaQt366qL3KT0d5L+/qAxH8FGTwvLvhdwHSE4z4BSgeBrRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_09,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040165
X-Proofpoint-ORIG-GUID: C2l8KkNHT6fZh_5KIElbtnqsb5UOwgfK
X-Proofpoint-GUID: C2l8KkNHT6fZh_5KIElbtnqsb5UOwgfK
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function crash_prepare_elf64_headers() generates the elfcorehdr
which describes the CPUs and memory in the system for the crash kernel.
In particular, it writes out ELF PT_NOTEs for memory regions and the
CPUs in the system.

With respect to the CPUs, the current implementation utilizes
for_each_present_cpu() which means that as CPUs are added and removed,
the elfcorehdr must again be updated to reflect the new set of CPUs.

The reasoning behind the change to use for_each_possible_cpu(), is:

- At kernel boot time, all percpu crash_notes are allocated for all
  possible CPUs; that is, crash_notes are not allocated dynamically
  when CPUs are plugged/unplugged. Thus the crash_notes for each
  possible CPU are always available.

- The crash_prepare_elf64_headers() creates an ELF PT_NOTE per CPU.
  Changing to for_each_possible_cpu() is valid as the crash_notes
  pointed to by each CPU PT_NOTE are present and always valid.

Furthermore, examining a common crash processing path of:

 kernel panic -> crash kernel -> makedumpfile -> 'crash' analyzer
           elfcorehdr      /proc/vmcore     vmcore

reveals how the ELF CPU PT_NOTEs are utilized:

- Upon panic, each CPU is sent an IPI and shuts itself down, recording
 its state in its crash_notes. When all CPUs are shutdown, the
 crash kernel is launched with a pointer to the elfcorehdr.

- The crash kernel via linux/fs/proc/vmcore.c does not examine or
 use the contents of the PT_NOTEs, it exposes them via /proc/vmcore.

- The makedumpfile utility uses /proc/vmcore and reads the CPU
 PT_NOTEs to craft a nr_cpus variable, which is reported in a
 header but otherwise generally unused. Makedumpfile creates the
 vmcore.

- The 'crash' dump analyzer does not appear to reference the CPU
 PT_NOTEs. Instead it looks-up the cpu_[possible|present|onlin]_mask
 symbols and directly examines those structure contents from vmcore
 memory. From that information it is able to determine which CPUs
 are present and online, and locate the corresponding crash_notes.
 Said differently, it appears that 'crash' analyzer does not rely
 on the ELF PT_NOTEs for CPUs; rather it obtains the information
 directly via kernel symbols and the memory within the vmcore.

(There maybe other vmcore generating and analysis tools that do use
these PT_NOTEs, but 'makedumpfile' and 'crash' seems to be the most
common solution.)

This change results in the benefit of having all CPUs described in
the elfcorehdr, and therefore reducing the need to re-generate the
elfcorehdr on CPU changes, at the small expense of an additional
56 bytes per PT_NOTE for not-present-but-possible CPUs.

On systems where kexec_file_load() syscall is utilized, all the above
is valid. On systems where kexec_load() syscall is utilized, there
may be the need for the elfcorehdr to be regenerated once. The reason
being that some archs only populate the 'present' CPUs in the
/sys/devices/system/cpus entries, which the userspace 'kexec' utility
uses to generate the userspace-supplied elfcorehdr. In this situation,
one memory or CPU change will rewrite the elfcorehdr via the
crash_prepare_elf64_headers() function and now all possible CPUs will
be described, just as with kexec_file_load() syscall.

Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 0d87b796e5cf..4aa3c7a6b390 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -364,8 +364,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
 	ehdr->e_phentsize = sizeof(Elf64_Phdr);
 
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
+	/* Prepare one phdr of type PT_NOTE for each possible CPU */
+	for_each_possible_cpu(cpu) {
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.31.1

