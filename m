Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2818562CCF4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiKPVsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiKPVrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:47:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE80A175B6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:47:31 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGJEUXS021257;
        Wed, 16 Nov 2022 21:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=k+S3US1QVOIXz9YPu9hytw8EChpDp957kx8ncyBFyss=;
 b=J+yN0ietf02Vyv79a5SnbHJB+trjZjkQO73hewUyh0eLETvcV2HQSzylhPz48Ezo6w+r
 Wej7KjkndBQTU2UJD/W0rJVKMRTYN7JOE0TTtX7mYTUJ3S8zMhAYmAYnBmJKKqjzc2+m
 +9urfB3PR8e7TY+VroKJtKuMgD6pMJkbnJxAkx+G2tAS91OrDYkgKao2LlmdDzIi1Tat
 3Hk20K0oQmKv7xvnTl/9gIILw0egO4CRz0SmlwGihXVEhSThaISGYCOh3f2g4ZcWEeb4
 aWSk0AGouAWmLBFfObIplQwzLSIfIsWJAm/Bz6TVQrYV1cbKIRqxJvupgEDApZfliFys Fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3ns6pgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:47:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGKsXkE012465;
        Wed, 16 Nov 2022 21:47:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xeeetf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 21:47:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWyuq+qXjI/OnROp59jd4v5MiQkL2GkzpTrPVBngIq+S0oIuz+DYNCAMD0NP0Rb9sTFWm1V1vCQuqg8qIpNwNIhfwSYsYYcqstz2bMlAFsa3LWHXFBNG26igZLK1+t1iG4zRrj5wAFGR6ptxMo+LAb5Y37bd5n8L/eRihZmnHL/DF6hMzviZ2ClYyTKyWmjZo0FK8WlbpBDteTQ1nnqB4UU21KTQ2KZIRd/JJFiXWhLRPm0UygM4Oy2iaMRQdR5B98UVIRQ9jZf6Bi6tEIb9i30wRnMBbSB7oiAG9NaKyiRE8odxKvNRcJ4BCz3d0uPWob6K0mehjhzMWxZWRYyUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+S3US1QVOIXz9YPu9hytw8EChpDp957kx8ncyBFyss=;
 b=Q+HCoZHmwBSS01mqywzSU2KePS/u7i73rofwpYm5+wKRqCa5qpT/4cWEuOtxOeefDzevElD7gfyH4S41Jv0+M7BP7jN+Pynh2obez/I5S2Jm2EA7dw4bpn8Elhk0EIPeGnAMV1HZ0MTF6xPJ+wEwTgLF43tws0V9sLnQQm6670PctDLDObKcNOhAK88i+jLsLOMP85b0vjBb+l2jRsFq0aKkfVbJn62S/7SvgsRNEoNtf6M1Wbj4vsKG7iRbM6HjnxI6Cj3Icnc5pBYRfKpQjeMpvgSA8wspWaD42CAWlyVfXlrJxJdgQp6etLHrgncDTlKqtT+rd6B2aC0p+qKjdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+S3US1QVOIXz9YPu9hytw8EChpDp957kx8ncyBFyss=;
 b=jFAABFQHepYkOx9G8hg3nqSW0EltyWLjTrMl3FmtitJ5vqvCwl5rD5BjW8pogE1DTeUy+YQzp/KGKSY01GeHOS4uRqPfHlO34lntda9IS2T16+YRwUydtvWp1mzoBLFM67rkoEOo1vOY12InOw6BCoAA1II7ayRItyMfu2YhHtQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB6376.namprd10.prod.outlook.com (2603:10b6:a03:485::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:47:06 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 21:47:06 +0000
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
Subject: [PATCH v14 6/7] crash: memory and cpu hotplug sysfs attributes
Date:   Wed, 16 Nov 2022 16:46:42 -0500
Message-Id: <20221116214643.6384-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221116214643.6384-1-eric.devolder@oracle.com>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe27495-a4ee-49b3-a820-08dac81c1aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zenFeLhogTQXGqNPN8EzEzX4EwkbEmSIjCzsy4ucH5WVupGN3cxO0xjVIu5EYGj46r+5D1Xj6BE4SE6RMH/Auv4keUkh29uraAwVXLNZPtyvzCUXNEZTstZH803uHYWVBg60mH4b35P9r8IDzVWL2nSWbckj8UWJxVNF//MEgSRZ6/27sFYj1ONo0MSDBUmhZ0r+4u2kzIKXP8EFG9+EOyHQKAVa9LKsRiXZJz9dQ7COcpHiGuCcxlqG9EZ4wrNADNQddrAXJXG/gWPFJH/nN9nlFh+a53NnVHiIPR3LCTlNyZC++sF/0XWcC+T4q65W77/tNpfh8cnVx49SwShVoizeuv4BmH3UMkkRJfOplDqbsH5SNXigqJj/JkIzQBeQjqQuiDPxymQMEmJHdDpwOA4SCZTf8Dz7hUUXLP7si1IinGlJG2dJ7jECRGnALzd86r7A0kO8LvbdRCQNElfVERqWLtdIr0a+06MN/hrQCR7zMV589e4VQmbH6H1b0H6p4bqoEzoLW2hW9iZt69Taii+P2IS/YuLRxNF3PKR1Xlk4RYpZp58hVjZix7I9B9bTeYHn+u4hGAoLtm1rFflQHyGP6tv8sQgyP1NyZ920xvVKl3t7fYOASmsqQ+giOPV+qG6Esg0W7D9xtQgg6uv37ggi9fpyp2YqNWZiAQcwa0MyhsPscSP2Nq47IABVrGSxvwPtKzQfdtPDSCyL2LLgig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199015)(38100700002)(186003)(86362001)(6666004)(5660300002)(6486002)(478600001)(2616005)(8936002)(7416002)(107886003)(6506007)(8676002)(4326008)(316002)(66556008)(66476007)(66946007)(41300700001)(1076003)(83380400001)(6512007)(2906002)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1/SUjtfnEuWrcH6+jXEdDBm2eQvs9dKHHpUkKGQwZSMm+5PVuSVsBGrWY/MJ?=
 =?us-ascii?Q?cCOYrjUblG1SK/M3ApmbbceqG9ukbjeEIEO+HGgAW9pxkG9KnIkf9jiF9o4h?=
 =?us-ascii?Q?k3/F1mYbfdjL+1/qviVn85UbH4+q0jdf1LdhP/KrEPPEJIYPwJvEwl2shCRR?=
 =?us-ascii?Q?XAeikaSIzWcJ6YRbvxER/hDukYpzARO0TogpHNDZPSbzf7I8UuwNZQ7itzqB?=
 =?us-ascii?Q?qhgTqm5GhhGWYE2Ocf5UxNuW2am9GVCp182cDl4xv/o2RyU9vfnbf9M6dpqj?=
 =?us-ascii?Q?WEjqlxP+I8iVbZhfWBAwlfUJJdxVeVX6agRc/mKNUswXd4dKgrkre3qlLARX?=
 =?us-ascii?Q?7F0A/P1mOT8Rm7bTlogU0qfEkJa1cTaKSnh+CfhCOQEvhKBehTSGRp9/wj98?=
 =?us-ascii?Q?99PI7JQitXDExQ+Wv7/k0+jdTCOBruG/oIBzZG5i2fPKVyia8SK9W8dsekpj?=
 =?us-ascii?Q?zUd7i+7/qkGIAvWY/GhQD0usOIKLarcsT6DTidW+EIe9viScFp1blT3SuiV7?=
 =?us-ascii?Q?LwmM0OFistqXKy/GDHDzDJItuTqxNqMdrTXu/ZPp047Wj5teKOvIL6nWB+sA?=
 =?us-ascii?Q?lj975gdNqLEgZYXJqts34zPb3eurFoBbuW3BA7Wc7oYjgTA/qAS7f5lqkwFT?=
 =?us-ascii?Q?zUAh1yrD3Nyuppc59TIwmBHEtATRjHneQE6O+vNeFkMdLxwtQZPGkgLUEO17?=
 =?us-ascii?Q?E8MlfbNWJqZZGkTOAs4zvsS2gCa9bGFGfQMrBrqSyxTtHMIWVkafzmXkg3gB?=
 =?us-ascii?Q?FDqu1aE77UPc99LMK5DJ3hYvSMJJ4dQKccKiXmlgLQsDtKlNjNVwTYYvxl9f?=
 =?us-ascii?Q?7+Kezw2+1dXB7u/H1tpXfDkgvN7gGb1JySdl+9sq6TbqC8ajoZHUPeeRCenC?=
 =?us-ascii?Q?jvMJGvxyj/5R6sT4+0VtIMiNR9XDGfQOa0GWpxmcfE44NkwCEMDLrrQi7Z8x?=
 =?us-ascii?Q?iIlLO2Kpo6YZmJGhLSNyUcKWnwo4FtsVW0nzvEg0BDg722warR7xqNm+bbUF?=
 =?us-ascii?Q?MzYaDIHDxIsrrf71WtmRSMiUJRwBXkrCvti0lx5MiudEbfR0OBCzPfMkuJpV?=
 =?us-ascii?Q?vrp2DAgjJYieC9WkYB7BO6ao1qogCoEA+T6NahMhJTT2qCc/iPcDzHw63wwg?=
 =?us-ascii?Q?9BqDVMsBz7HUqZAMGd2hlST6snt1OD6W0MKMByNHa7A26lXyk6K170gOkneW?=
 =?us-ascii?Q?mxevsgy6GUEsO3Bji/q2O+3RN0aPhXJP5RDNz+rsC0+H7sF4f1Tm4UUeab/2?=
 =?us-ascii?Q?0C1xVRfFF/CFB6hcpCao48IwHxKvIDFzTjU21+FJgcsrK7fdAxUKXyZnnmV2?=
 =?us-ascii?Q?10x1AJnm5a/D5hxWxNNI5rbKG9jHv5SHKPY9vHf3VVi1dOa0C+naI1JrEwc+?=
 =?us-ascii?Q?+5lzGS73LS5eBxqcqifRGm3wx50wR22A95oCU3ymGGVFZDWCVe3TaOBDxjuQ?=
 =?us-ascii?Q?nd3mwr6Rc6O04xf0CkmTX7L8zIbO58VRZWgWYgw19fQ+qiQ/4+018s5jZdpU?=
 =?us-ascii?Q?uE+mR9DuM1B5UHCb0LlIxPUYQAEKiT1wSNr7wccGOG4S5rgI6jQkbOQ1NFLN?=
 =?us-ascii?Q?+K/4srtj2tJMdbfva+20I1xWxeMNIjEYbwTN+WI5SAC0LO+dSSqGhMzAemYw?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5q6rMkHRBCUNebDCYue1cbAvIH0fxrGp6e+QG6zYOPrLtmv4n+DebfxnNYE+?=
 =?us-ascii?Q?C4TzCH4f718UIQux7eUR1TwjgH57PiCXXuRqqDlDwLKEIRB4QHgycUvAk3MU?=
 =?us-ascii?Q?9z5Yd2RLlllUGA8IGVxadyKXzheYdmSlGIYHFsOm0+nEfvQecYiwvxsd2if4?=
 =?us-ascii?Q?gFLBQ449AXd8X04c81ySs3BAVmW6M9R6ToyTBIk1AjWMnzbO8AYGPA+IdDuw?=
 =?us-ascii?Q?LF1mUXzckA+CyccAz76kBS89bD9m3RJfbnl5cIM199bvEEK/G7c8XKWGzvXO?=
 =?us-ascii?Q?MwEf4ly2rhw0rcDKdK+QMcesM8fQWu6Zh1swWhXCOCTsJAgR8cCx8CZEY1O3?=
 =?us-ascii?Q?ua+LlV01fKC/LEpNkjIwTGNHVF+pxko8brfJrS/hYrK9FT8YlXJ+fZUKKw06?=
 =?us-ascii?Q?dDJ8sAngCBI6tTkQjy7YbX+oLocw9Kb+li7LSW6McOTr7zReMIA2Pp5KWPOg?=
 =?us-ascii?Q?4RfxxyTesCuMYkENNV3qqIMq8xobyMC6Kfdy6c10sVmZEaESf3OakdJIZAYY?=
 =?us-ascii?Q?5PuvoNNsCWb4ahTS2YgwIMFnxzMg22vUgePypA0XXOSp+QjDtRnKSpsWNmEW?=
 =?us-ascii?Q?l12t13fqkzzE/yDwtEFscoCU1zBFs0idFfwW4XH3ksqxvk7ytssXRN2NRnlN?=
 =?us-ascii?Q?9zYk328/1agDlr4uTig31R8r4GD+XCMb3bqtob6FPjnBme11+q/Ldo1aGEVZ?=
 =?us-ascii?Q?oTq3/IVbwLmYXy8s1t7JiYrnLFPwN5XvRG0WbGX9U65y9T/lXG4A1OLGb9SL?=
 =?us-ascii?Q?UuRbW4VsuOSDGzBKyPH8g7pEfvQd9Qlrdd9zc4GdSezIEBDUSH9e3WwQ/F0W?=
 =?us-ascii?Q?LGRolhpyd/Wn7/9KgX/HnRUN8VSzYJKODgXcwhzid0KszNvfJFqmTyK9kadA?=
 =?us-ascii?Q?dNs2RuiwhtKxJPoLs5z9Bbl+V0u1T32ljUGhvFeevaZvXXfGflnkdkDX3qzI?=
 =?us-ascii?Q?QMrXCdIZ/sXnXCMmFwkIKA8VN0NdYEMFBp5YxAgOAdylsb2lD3WRbj88Fe03?=
 =?us-ascii?Q?vWDU00zHk/+rfW/2u/cPSNMK21lfz4pKYO5OGX88ElHvoiHCLDc14iQ26vHA?=
 =?us-ascii?Q?Kgp94+id6zx1FMU0E4p6eDvPtp7No1+GenuxpqPwGnzRO13FYS3RRw3lknQw?=
 =?us-ascii?Q?4/x6C2o2phdcbqPUgzismt98QismPFcO9Otq/suECvwLENSus9a+dmCYuynQ?=
 =?us-ascii?Q?iqyR/5nhlA++b/4Hkv6Ex97hEmHatuP6r5LslE6kCX7oVqWlwrZYWi3jVAEY?=
 =?us-ascii?Q?9O84WkxxoqcbnjA+NSO4d3zw0hXZQwEQkfZhqipEZ3i/dnvM+9QdhXeu2/Nr?=
 =?us-ascii?Q?geC1Vb5uGSxhxEWP7N/Ixcrq8WzF5dPDqugR2czrvYSCnA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe27495-a4ee-49b3-a820-08dac81c1aee
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:47:06.5646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2j9/R7npCL4Us1Ms1kP4sMU+5LUva42gUWAezpiVEEbRXcy62E9nvc+KX2pAKO6qQbiLk/pDiU/Ajob0Tgf8XB7C4wKp6Mwosqb3Qebt9VA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160148
X-Proofpoint-GUID: 3BxvzJRdhYAVcElqdnq5uq7Oy337gKqm
X-Proofpoint-ORIG-GUID: 3BxvzJRdhYAVcElqdnq5uq7Oy337gKqm
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
rule will fail for CPU events, thus allowing userspace to process
cpu hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 14 ++++++++++++++
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  8 ++++++++
 5 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index a3c9e8ad8fa0..15fd1751a63c 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -293,6 +293,14 @@ The following files are currently defined:
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
index 4c98849577d4..fedbf87f9d13 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -293,6 +293,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
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
index 9aa0da991cfb..226be3134ffe 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -483,6 +483,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
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
@@ -881,6 +891,9 @@ static struct attribute *memory_root_attrs[] = {
 
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+#ifdef CONFIG_MEMORY_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index b4dbc21f9081..9bcb09dba41f 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -539,6 +539,14 @@ static inline void arch_unmap_crash_pages(void *ptr)
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

