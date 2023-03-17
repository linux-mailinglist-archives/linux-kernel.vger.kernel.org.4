Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF96BF3BE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCQVWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCQVWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:22:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE480C6DB4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:22:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HKeYYv014378;
        Fri, 17 Mar 2023 21:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Org4+NnKw6uTV1agrqqdx4KYgAc/VaNJCq4DuJhC63I=;
 b=svxmm6d8ksgcoMmBY83snfwe3hIrq0mcEBtxJOm/VdNqwgfN+dwWVIxg0g1Q2n3BzruT
 pdqAa6vEyHDSlqD+HRWLHHt490SR0f2DnhY2dWBO6EYAqx0f2aTyO468fdPa+bsiP9qg
 LXZnO2+EBg7FAlIvHOIpb9ItdZOwGo+QzFKGZRgI9Pl2sywS8rLWRtM5ZvSpSpwDxl3o
 jgfh3VPSeb47kKNGiG5YDGYs9PfqUrElG7udxA/Vm/N7XvLKMlwJfsS/uZeGIPa85pci
 XSaauKs/xXzL92yoAcieRab3XACsB+bz5Br50FUmYywnKO3yIA1SHDhTYwRHRtMbMI79 QA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29vscq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:21:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HJJNJ8001238;
        Fri, 17 Mar 2023 21:21:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbqq78jgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:21:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi8sgPl/2RerOAY55VMe9YoOiSALGBRVEeIt8b1+CDFavCap7ShXNwvXzU+S1B4C6OMBgJzUHf+5OYYb4BXDSFgUKnsoORvwWb2u08Yu1vChDvg2GqGa/t/K7+1Xun1XwcSK/hCdQQYtYAEXGCfl8eYHIQB2NBwZIQcwznp/amdlkYQht6mzu7maH8gDTVLpa+RhWKSh42God0XuELKEJiP6ow2diUj8+3V4WbDO7plzTXNtHXPgt+KJaPJzg0mMRHlOVpLawbPEUfP9Z/iDWrxjAY5JZtXyfXyZnUzeheXvK89KFiEB5hIlbODBZLK5T/2sAVDUFqPb3O2XGjwetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Org4+NnKw6uTV1agrqqdx4KYgAc/VaNJCq4DuJhC63I=;
 b=NSLc3k3aoZvgKh9seDSBeZZRbaDFlJXtdRSgnyLbLrefhKKAkycOZpZVQhZVDeuL6ZFT42aGoOBp+9ILyujug6dwjPh97xXu8YgY9Rb4XloHjgdcuajY8QrhVf00rxSHSqIegBSvIG3t/2/JfXEp809qVPuUmRJyH+ppv9/+9kVWUKiZHhuK4w3aldk9hddCD+KuDr/rXtmtzxnK6uBUBq7aQdkvOynD7O/2a5jkVXKHNkL+7yC4RF1elaZkb7Z+dU2qjSxxn5BEr/YupW2m9G+MQsR3qEXfO5qfgSweqNtaJrzTIcaDKUQt+N3dusanvkLi9VMHMLhmeJy+VgtH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Org4+NnKw6uTV1agrqqdx4KYgAc/VaNJCq4DuJhC63I=;
 b=NEbmkqQE0twYYLAGHe6Aai3CK/ONSRnaRuQ45vvEem9rhtm6lkRtra6UresKbyUVQW/G0apN2fJPfTeT8iIZSAYEzv2TBXNEJb3b9Gz9OwTFWur1BvpZDM1xikc27f5cbgt1wJN6Cj0iVEHnDybc/NS+q9t/d//hS3yCkqpKQ6s=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB7483.namprd10.prod.outlook.com (2603:10b6:610:18e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 21:21:47 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 21:21:47 +0000
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
Subject: [PATCH v20 3/8] kexec: exclude elfcorehdr from the segment digest
Date:   Fri, 17 Mar 2023 17:21:24 -0400
Message-Id: <20230317212128.21424-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230317212128.21424-1-eric.devolder@oracle.com>
References: <20230317212128.21424-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:5:74::43) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH0PR10MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c25d7e-7f65-497d-386d-08db272d9db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIDtwoZJQPn9IOIHF7dk5d9jNYj2h9+Po5U4mlRSFxDcndgxvMsBRm8nWOeXQkHEM+K9D6tAh+5hN5fwgXJ2dgEd3N422IO53keujJXXzFq7IfuBrQgdausPVLRbCz745LAvRKvfFsxiTl8G/jEHycTPNgvAskqPdWC/WY5mPfZxz9s44BnBNt2xQcalE71koKl02sKJDoNIpNHJhY52n9BON5p+/SlpbwoIZ+moT6KUPGIUmGObGqKgcfdybmSNd/zU/2HTkirU2Er0Z/JpNf5OnsPSSuGOrMS4vmJfYwoixDTASBm2W1EjHal92rtibjrjlck9ONqRCOrQsKQ6JyqhgSCc9HZXgBqtb2aKY+kolhTCH5zs5blupvgQdeFNgLru2k8JuZbYjlfUF55DR5uUB/bzcqarg5iFD+0jJtfbAict0/YYjt3FVCHxQiKmyDg+zog4JbcfpLVqOvIoykD3enIImbsQu+tBRIxFfYqbplFCThPb0P6toCQV3JXAYtR8AyLMcLkder/IgNN6Nyh/vnE+YtmYTQU4cOQQ6gLaNp5nvNTJmowQfhyiXtsqK1VM7WW4VcjcwhuFb+kR6mM+y+sWNswHoUdiC+gf5eYluwjgrMmxD0UxgLhmgo1Aue8NcTdjqLThoo93Ya6fNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199018)(86362001)(36756003)(38100700002)(2906002)(41300700001)(66556008)(66946007)(4326008)(8936002)(478600001)(66476007)(6486002)(2616005)(5660300002)(83380400001)(8676002)(107886003)(7416002)(186003)(1076003)(26005)(316002)(6506007)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y2Spgv7qrV+PFHRrxyaI1jiBZOPf6aMDEJ/wFjAo6A07JPqFM0gHVb84rgv2?=
 =?us-ascii?Q?a7ZqbpmEH661rE64epej7ZLKU1DeE+C1Ah9skmQv+fn+IUDhGZOSULaLUQq6?=
 =?us-ascii?Q?dPTyN+sFqzXDBg4ctIqSPGt6HSosa/B/XiZlRpavVZv6BxDUBxf2pid361pD?=
 =?us-ascii?Q?Veiw6IwetgITdUoMVS19YYZyMzVpsShPLe5SoMk6I80iE+wSIqNuuOZaZVOx?=
 =?us-ascii?Q?KBcXwu2Efa6uVh0EwsE6vXqy4nm0I2CV78ai/D84kY/dmhNvC+tQUWOLSH9I?=
 =?us-ascii?Q?6ZuAzOplEyNgL/Arq6RVPtpc9odLADRwLfABOH2hlHQ7L1k2uUeHhd4UFon0?=
 =?us-ascii?Q?9okA+JBPmTb97Nh26UTUycCknTNh5z5kXbNrkLtPMq9umqaecKBEV8OLOHxH?=
 =?us-ascii?Q?RHx2sQ0PBBibz1ol0JzBHYffbAj1jInoj60P5OCQBulz2nu8amhXoeOTyuHc?=
 =?us-ascii?Q?246X0RYthitZZ0nc4SUsrbrz6BbuTsdjdNzrqzl1DlDrsbSogluzh1K+bOwG?=
 =?us-ascii?Q?bZXc9Gu4+nvBXEjsMaF5ovKwQ5CKvDM+s56PJRvDxIDjt9Y7Tzc4Zko7lNtO?=
 =?us-ascii?Q?U2HcjqHRX4G1F51WUdKiAEopH/XWueD7J715JbAnDocPGVMlK+fGJNtb0HUF?=
 =?us-ascii?Q?CA6ckXFopvP1BR5di3tEQ+iuCQhnp/J6SI2vmbzYMGyF25KGRq2PK+0G5ALD?=
 =?us-ascii?Q?6wAk+qCiIhRXwFsjloj0M9M4wfyXgaC3ifTeqXwmFYd9lAeg6anTeazTgKsz?=
 =?us-ascii?Q?V3LgWWrx1qLRXfztkTm+m1U8Ipg6bRGodo99Y6aRQLXUdnrq+9CZn1ZqW8gA?=
 =?us-ascii?Q?7MFPDJkDXxqqEpKMTfLgPibbaAYfz/ErOTxO1nSGWI45fflvVHXLZkCXd61E?=
 =?us-ascii?Q?//dSwzGHfJjOhTDoq9P3ULP35MZVXQPOgJ5gsdRwPQABq9epxJ7SOxiaQ2Ff?=
 =?us-ascii?Q?IsmyqPV4cKXH2TuuWWaYAjFO71E0JhigVfQtW4Dpz+1GQHjNr7JL8m3BgEIK?=
 =?us-ascii?Q?yg1ZqC1uV29JsqHAxNjXbMIyFd82BA3XUVNB5FyQCMxq0kC+O7XARkPk+9O/?=
 =?us-ascii?Q?zxbNeQWi9A5UYQwibT0COALHOwFOF7YkkI+kNXybuDTg9orXHQ9vOTmpRVne?=
 =?us-ascii?Q?PsMCHm5MExH4iZb5ftRl+9Dq2rTm1EYBHHzHi6OBugef5xtTnE3MBJ2t1S/l?=
 =?us-ascii?Q?OwraUBa9Yi8k/pGkc1Nl1aFZV+y2vQ9XM4jxHzF7UYixKilpdTIuWQTVRSjj?=
 =?us-ascii?Q?OSShLlfrP4WQtLs0YIPJPUJDKNGO6hUolWnFyatswp4laU7mZQQmWeG2QAl9?=
 =?us-ascii?Q?fOXLzenUK6DdzbfmLSX5ym/1SoTfiWgsYSyrrjWAkFNRsGXJUhmkEDAWSzH9?=
 =?us-ascii?Q?bpH3RaKdDl+h0tOk8FnCSUhEb4LTt5a4p00H48rikOB//gCmxUoitvUoPcIc?=
 =?us-ascii?Q?sTgROZ8/H/pTZiu3z3ouawHpOIFHGIqoET1fsVehiRyzCR9he8zyAuNkj1mN?=
 =?us-ascii?Q?2AOWutJG8f/boHPfoCGf5mC2q5+KZZFfgnZz3Hs1C85guCKhmHTSpdDSsLkJ?=
 =?us-ascii?Q?yaewoV/5jnZkWF3oxo3/n6ap+4oOB657DYfUdN8cqU1ibgc2VUNPVT/V3wmy?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tUp2mLLv4qDse+2pqFav1k4Ej0TIiFkY/80SAP0bKcH72L/Aj7rCsem9fkWR?=
 =?us-ascii?Q?UkStv8+p8K8IHqjaKVH5Iqo0OgPBNQcJJvZO2QMCnhfcuFF+Uzly1dbvomJr?=
 =?us-ascii?Q?q4ke58B92IhWyVSrKMLWANwKcKflqjzObrkPiVoI7HGuMTME6S1WQK6IslJR?=
 =?us-ascii?Q?6Vs8hKrDD2JboHvV5WD+1+MtHIBQPSRGzhknIUkrvK5JapbULbj1f2J7hCQu?=
 =?us-ascii?Q?CK2rkZFaZ8r/PxArEJseXgEE3URrGovCAjPGc1RRy5C92H4LivD+imV5C+8i?=
 =?us-ascii?Q?EnTiDNd5sbuW6ydEw4nIhM21HkB5BF0TkpHImOfNISIGRGVZgFlMuR7S+wdN?=
 =?us-ascii?Q?Oiym7g2zZ7uSZ5baAaITGMTBjvn5+QaMozpWq8kmNMY816JNQwZB9VJ0N37A?=
 =?us-ascii?Q?VnODBc/vz94Rsacz2MOIuZn5Klb0i9GND/EBZ0OY/3qpM2RVlJmYH7SN7nEN?=
 =?us-ascii?Q?86pGBU2otarTMYad5ImGhcnxKdHVWInzVVd7cM0txz0jodrQwLgWNhsR2S67?=
 =?us-ascii?Q?rIarNcJtez5lQbhFBtR6mosypoiVEvNHHJcNd99bHkyKiLF2lryh8unYR/gv?=
 =?us-ascii?Q?b9ZWuFeTq/DN/l/2r+KA/NEtWM9OVRnGXIZWpiJPgTf/slE0X15l/weGqpfC?=
 =?us-ascii?Q?BpxMFqFtEqFOyBpF2I379gRfgUiBv7Nm2VXe7yBFsDRt3r9qq9l2brZu+ZxP?=
 =?us-ascii?Q?LgBaw0n0I1CKlHhDWTihWVuIKdOCcC71/J4bHOLF41/OblUbjm7o7xyzWt9G?=
 =?us-ascii?Q?UUcxejTrpUzp72ZzWgnxwpK2pNW4jpc84RTTV9vaA+2IzB40Ppix+IWhKiYR?=
 =?us-ascii?Q?uXIj70LEFXwjaVZ+cMuYCQ5mRPyft6e5lWUffo5bzyZia5KUG/bGA0WV/EqW?=
 =?us-ascii?Q?o1oj6L9E1v5fkg2waLe8tGXGBbp2g6jFA7JOw+MZJmrrvbtOD+fQpeo4u4V7?=
 =?us-ascii?Q?ZnfsjUjJVPLC7PZJCb896n/kwLLQQl/cEeYF8hqhjPzcTwD7CAzMRMvdC79M?=
 =?us-ascii?Q?q5Z0qLg2RjKLWABZkFSStfVkIT9ejFyK8TzOnGeTxUytikeGsYxDtXTwyd1k?=
 =?us-ascii?Q?svsd+njqcyrKdP4hcrMiiy6vOijhkU+A2kETy4O2lf/dM97sKv8GVwSR/qFn?=
 =?us-ascii?Q?ZqERxB+6plpxcB+7SdPWuu2SSYCZvANKtpSooHqbEElrBTY13WNGe4s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c25d7e-7f65-497d-386d-08db272d9db9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 21:21:47.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GgpIK8y06i2/cJ+KssW2hfVqUZ5cx8Ns19JUNzeZvZMICelEINcr+QywVi4NlMA/iqAx4dCOkd5N5f5/wGtyOpzXeECqTr6dHJt+KBvcag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_17,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170150
X-Proofpoint-GUID: KpjrLRn2iQ3FpcsC7QLqUXhMVWTV7H98
X-Proofpoint-ORIG-GUID: KpjrLRn2iQ3FpcsC7QLqUXhMVWTV7H98
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
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0b560064579e..a28f01318a47 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -726,6 +726,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Exclude elfcorehdr segment to allow future changes via hotplug */
+		if (j == image->elfcorehdr_index)
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

