Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8B469EB45
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjBUXah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBUXaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:30:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB15327D7A;
        Tue, 21 Feb 2023 15:30:34 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LMi4GC003985;
        Tue, 21 Feb 2023 23:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=JnP3E28kJ5v/dsJkxP4x2knQKJUsVjQidWRpZDsYEO0=;
 b=Fvn8uRFzs1AcsSE7QUy6swNazuPwRKZ4S9mRgkYiJGVhvvpbDhQSNqI/7mHFx2AjLfGi
 kvBOjmvLx9xAXAxqOer/N9mqlGpvCstTcJXPnKMWYjKtP3P0xUHGN9pRF00Yn0JYP6Qb
 nqUhdwSPNPGeDb7DhCGnhSxByFv2Xz3fKP5nBPJNo5/iYdmKB6teXwK3UB+yuDCorc08
 B+Qc/xdpkZ2Zki2AFJ2+gUWjGKRHKGAm4Clb/LFfrLkGGTd2lCw2Z2FLMjxb6aKs1rL2
 7VFR/kgVG4IwfE//kDlo/SWdNslQyYxnS72uriJ/3OQw+cA25VjE9N+zs1jDLfHdLVgX qA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntp9tpn26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 23:30:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LNFIC2023474;
        Tue, 21 Feb 2023 23:30:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn45vpv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 23:30:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TogIPrD+ehmJyIZ86P/8aErr6QGB5zS1E3jH0Zl88na7q218CWXqPJqmWYmfGLD6pxYQEDuMYn2oeKSGGt1a6jRRjmyqaFTs3ujOOG5BioEaC2Ppf3sPFjYKk+/Ca1Ndo02XuU7gzi3PsjsmyTYMfFwfQTJ3jRs/7Cwn5+TE0OgKSs6jbhDJUkzoP/bHNNXmP+Q2XlC3ZMocfrC1vg41PAjbti8VkHs6m0rWqFExMaPzfYLrLMeWfIISIrEQV9WcyrmGi2P4QErabDKQy3Yd8z0gM+tNemCzyoAuQEeTgIi3wub3g+M9xLWuV94ycmFjgT9xuByh03fonKc0KgAcTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnP3E28kJ5v/dsJkxP4x2knQKJUsVjQidWRpZDsYEO0=;
 b=NwQs1ZAMSppxwiKXxDH0g0AZh2tp7WYkXiaZuuFrD0rQhFtKA85ni3L+NsRQdTDfr8fZXgRzzo/zNTUSAhJzOox+Si8ZW0pi3fsd/CB1+U7uQz2DnXu+RXdndtV8o8lNzE11WtrMUQDUwl4EFHxKFSLqYCCZG5OWNn2eR73YDJ3nN1Fqg9VFE7QpdkywFcaGMcuWHpleiPPjveTDD8Ck00PGWIadMxWOvmiR4PPV1WbaUWIiJEH+sbCAM/+vqTWhCkm9GKvcFO3iSMg4LgqUw83IE33qXHa1X7v4fnRPmzuE/1mN2Pu1BRqlUhx8sAUB826W7wt67o+yH3h/Ww0aeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnP3E28kJ5v/dsJkxP4x2knQKJUsVjQidWRpZDsYEO0=;
 b=C5p4Er7D9v59klicrIFjOM5IyNR9pCIZ2areoVDUMf5fEnTPw8zuKAYqlAUrC/YywtUf4CWblIaqi8ZqMVSjM4YhhvkjYufzpPIVgtqAHwe0HKHLw28DOViTKU3pPF0+kBY7VNcqoGB8/ueCqUXRLYXXSQ7mz582GB8/0v35Lwg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.16; Tue, 21 Feb
 2023 23:30:15 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6134.017; Tue, 21 Feb 2023
 23:30:15 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] [v2] scsi: ipr: work around fortify-string warning
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6ver404.fsf@ca-mkp.ca.oracle.com>
References: <20230214132831.2118392-1-arnd@kernel.org>
Date:   Tue, 21 Feb 2023 18:30:12 -0500
In-Reply-To: <20230214132831.2118392-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Tue, 14 Feb 2023 14:28:08 +0100")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR12CA0022.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM6PR10MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b39756-f7bc-4402-90ce-08db146395ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzIR4X0E0ifWaqS/YbRuHU25LXQsrZD4noen/xkuwTYyjHlay49C0K8j8T271CVuSrfUrdKbh0Te55XoyAudjJHWDwkmr3BnfJkX7E7qmPh6pIkFd5gfOIxDMZqrVb4yShoihKwEUaCVx/u/2FYrj7s4UyZX195TQwf/+4liyzTrOthxc7B2Xhh704gpu9yAJTISnN4/26GfOMyF+yd2+jgXQMyUc6lW8gcr4p2ufvomfaUula59P4EgRvMYnX5Ri6mR+G8ikTOv2qca4xc0Ez/UWs3NQCzUSEKebM1DcgXt/LUEpm2k48ahq/bm6GM5+4v1QD9AavbuhJUxGksF0dAXhIxRRiQnQ2ctzBoQ5WD1i8xkwWcxJnMU0PV1BMoz6OXhIsNSqGGDqWNHUmGvFZiaOxCPl04QVoGjyPTF+/s+DSTlghAUYpZnHl/ZFUCdsW+9h1qaKhaxHKdF70uaOXt/pC6BKNYMYRBYELrQGh3rKfOL0ZWVN99uJz6jiljwl2iQ2PQp4czOEqIjKNiU5lb6QYfEFf3ph4NVH/hJRrzv+g1w8gKAaV1lSaUzmOMzVN5UrZXyJe3hImJ44HdOdR4y2sPoxR2SceCRgmT54f3gRI/fnWZWarqNzETmPg0uNJwxPoge/4hXBj8QtM1qMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199018)(66946007)(66476007)(66556008)(6916009)(54906003)(8676002)(4326008)(38100700002)(316002)(83380400001)(86362001)(2906002)(26005)(186003)(41300700001)(6666004)(6506007)(5660300002)(7416002)(8936002)(478600001)(36916002)(6486002)(6512007)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QLT+idgy5piXabXly2uSqp6uNY3fUyEkp/A0wnaf0SFCTPDwnlLCbpHc9Awc?=
 =?us-ascii?Q?psL1X4FKxPbNPdkJY1f8p0bqVr6oJdnX8JEYKlp4liVIKY/O1Ct5LpXWZla3?=
 =?us-ascii?Q?3+xI8nmdFuRym66lxwBCFlrDhIh4VsT1P5b/Lnhou2VM1N0d0TLW5W4vgKwF?=
 =?us-ascii?Q?Anc7OliIKJ+5jxaN65c7XOC0h/tmqj3AElquxxQv+hfyY/cKqcJlBmGrRC/z?=
 =?us-ascii?Q?lS77vdKSLW2aPYHIW37AlROGYPp7EJx+yE7OOXik7FWgjKJn5Qnx2gpAtBSQ?=
 =?us-ascii?Q?I7taJdKtJUn+KBujbhY8VEvY1JLImAgHcb4HC47lnXj80HAdsw8hGQk+SY5h?=
 =?us-ascii?Q?HFDZVmn/FFzA5WyRcJRjuFqAKZ4BBg4uNmpP+2AgVJkWv1IdBN9+DgFshPz8?=
 =?us-ascii?Q?D4OijHHdjXVuP66qJDe55GVvfrXcaIYlzlUVIYHIppMJ5lVBVUbzuvO7pCVx?=
 =?us-ascii?Q?gwe3WD6beJtQ/SZ+ONwGGtjix9qbtqDAewqw5EErD8J4hqHmyTkiu+swi3uB?=
 =?us-ascii?Q?sacvFBunyFEg6xjWmiuHGvx4Rt0BN8sGb8q+hkfFdctVdCP8cZc8esGU6VeA?=
 =?us-ascii?Q?J9ZEihh3HPj5Qo5cr++iWu+WG9C6GPI/Q8klGqTGe4lqT0vMns0Z7YHsskZp?=
 =?us-ascii?Q?a60jFcetaUEvnFAjxmAxSxHaXAo8B+TI8uV2dVE3agZo5uj6QTdjHdVV5tzZ?=
 =?us-ascii?Q?87h950AenKSmdk6QAoMF92zxuWlmIN4Hy7ULkLWVksQinUSIhWv9swMKB56A?=
 =?us-ascii?Q?rbp4rAH6A365czioy00JRrVz/MhYKibAH/2KrGzHNlM1Bst8AQ0fs6DB4NU4?=
 =?us-ascii?Q?6HTwliQfx5YIf2YYE+2Gc1jran/XgV0kEumwIm2KYbiaTH+DlEkdYwTXNZux?=
 =?us-ascii?Q?gMkOmHcd9m99GIw6PUisgFCUeYmARC4gS7fGb5XgdUZEiC2PLeEqU5nrvj+Q?=
 =?us-ascii?Q?b3mC29JdQ97U7ijGJmfv8wdrPOaa/l3ZEoDATVTWkgxGoLrszwiwHGH4dfWH?=
 =?us-ascii?Q?NyWyMqWSXd+/cD/Wa31i69uc8skX1NK+ok21hVYHI5YoJ9V1BBU9CgJBkeoA?=
 =?us-ascii?Q?x81xjVH9Un8f0UTbrsiqlQttuMrXPdbmtNqST/tr4gpWACYqr6zrZ3jHFRfT?=
 =?us-ascii?Q?sigycb+0zKf1fNr3bOwj+jIfw+5rgQav1O91kCBKD3AVFYNBwmL6X+MprPCa?=
 =?us-ascii?Q?LNcOMur4hN+EALK+rpX3KA7Keuq/H0ejjn1Q/TuGjxVYr1qC+qunTPvCJmei?=
 =?us-ascii?Q?ZFVgqgIefAXIqait/Zk1/xesN4jieyQBVxxYnqdEbxny6CxkYtrP78inZZb5?=
 =?us-ascii?Q?+3NqE+pGtRDnMiCdYb6sxf4omw0IY7g87N6iiJumdKQgg/ltXAv3Tk+U/y4Q?=
 =?us-ascii?Q?bvEDUx8lfx3WqqN8amw5bdmCTb5HtJKSbsi1rImrQ4YxRM7QrP9dYaKLwrFK?=
 =?us-ascii?Q?A6fBofb5iPcTKLJbTnL2wZ7IyPBghPCDOTyUb8JkIzU+wuNbgQyQw2n5jhhK?=
 =?us-ascii?Q?tOskcok5wm1hsCOqzo8QAy1uab0H7du22bUqAKNqCiAV7OUvIudj5FG4c/kA?=
 =?us-ascii?Q?CWIjQOJPPh9IP7AXIMB7FxMn/FiJsQsJdiheJfrOheVWs7Xo7mGvfw4NGvvL?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8w04XA/s1tor8x049dX79O+j8e8OZFJ8wQ6+Q+6I+Qc2xX3we1mpRPdNxtoG?=
 =?us-ascii?Q?ndaZTESbIzsZNznupsxe+sCQbff+mx1ZljdNHRYcwFALIhn9r2jgaXp2TirN?=
 =?us-ascii?Q?Y1fEx/aEGCPuujnKyNth6+E+6/ky04zLLdtO59CA++/0LNKpvEYCUSMG7DNv?=
 =?us-ascii?Q?XCvK6ONx5s0AYI+V4GlPP+rq3yVatVo8eSpHaCcx2+5s2Y6jDEQ3xFcfSf3v?=
 =?us-ascii?Q?cG4aQ2ckKVOBdsF08q9GyHnhjHxBsyTODTHpiiYDWQ42JKDcSPk1RwW4U5o9?=
 =?us-ascii?Q?3XXq3RQEiTwgis6qLeeR4e2x3Zm0kx98vv0wG1ZM6+cpuTV3VnFsKo7dXxWP?=
 =?us-ascii?Q?9u7NDhA3wCX6kDon4kqFVC20rsBNxyUcjE10lc1Y5R4Mvzwd2wTBwoAC/PLt?=
 =?us-ascii?Q?qkqeRtYxRh5ZbOI9z4zr6A+LNDcRuIo/J/KFl7wxbto7yAvA0cUXz2lyaQ+i?=
 =?us-ascii?Q?cjoBPcavwyuJ1dSdCmDE0jWv8sjyR7zoVzSbRKO2JctVtB1stquca2JjDvGQ?=
 =?us-ascii?Q?OzSF+459EOBfG/v0HCJ1iAM2XUf6YeD+7vzqcrDvxHyeZJnurZ3i0P/MCGpH?=
 =?us-ascii?Q?ik1dNm747N6BK/oZa6UaIkg2WvSzDUfehADpTO3nWX/nnFYx1gQmFKhxpAwI?=
 =?us-ascii?Q?7V+rZuwdnuiVZl266QcMMyPCPRtwXSbqzqqxe2rkx0ruF7vSv/2C6uL6xhDw?=
 =?us-ascii?Q?Vm8AQfVcizCIJiC9W9dhhqfPr+KcpFk9tUuTSFOXGOSHT+HeLSja+OIrU1Vh?=
 =?us-ascii?Q?5Cpk8WednO4HdVHxarpyufR65ziFFR3RZYxQlQH1qyTVTz86p1p5eUsjXWYE?=
 =?us-ascii?Q?efSgYr7SZtHjK3pP2bBqcEzkJ/trw7bZpZAW1xbe6kcIcjUthFsr35kjVgV9?=
 =?us-ascii?Q?Nugc+2GsWCNbgYwxuUrzURwlje3+d35f1AE17OirHZvIL6fJfzpjNu4Fq9Fx?=
 =?us-ascii?Q?DSYJTzUOMQJ888dqlwV15Hc6bh1jv+NXKFZ3AE/2S7mkMG+umkJouXSxY/WF?=
 =?us-ascii?Q?+MY464Qmv1z/7xebnGrG4OeiD0s7JfFwrLPeCNCXahWLJ+ufqVQiXEEGmTmc?=
 =?us-ascii?Q?xgrHF7QtUsFWk1eq1DCdvHPsSjwAtA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b39756-f7bc-4402-90ce-08db146395ba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 23:30:15.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrDlG1piMEQqnzkkVJBzSHhP0oSCJtHPEXy1NR8fsqywLr7b9KOjU+XCNSG7TyV8O+o521wh1K0UJPTc2rnCtZH0GStV9q1mfnxDnMy7YSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=973 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210201
X-Proofpoint-GUID: p8ovzeRCma8zmih1IYmxkzvtilbKzuTB
X-Proofpoint-ORIG-GUID: p8ovzeRCma8zmih1IYmxkzvtilbKzuTB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> The ipr_log_vpd_compact() function triggers a fortified memcpy()
> warning about a potential string overflow with all versions of clang:

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
