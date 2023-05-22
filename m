Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEA970CD7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjEVWH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjEVWHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:07:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916F512B;
        Mon, 22 May 2023 15:07:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKOUAc016159;
        Mon, 22 May 2023 22:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=E6+4aeLAPcoCScleLzhaB65hBgx0hAbiQNSGt3W/7U4=;
 b=0IUfTBP0ivNXDOoqMW9HQbCLz4Vv6oxTZXZKRTNJ2NB1Nrte/bSOXJK2p7QaLtgQBJdN
 AmkgWwIAFVoHMhisjikeJw2y5Xlbqgiey9L2WqlgwvKXskz9MrdNLgmnTjkDiKRa5vzi
 hxBMsK8iY1kgeo6oObAzruymsgKTPOXmYHbIVUaJWB/Uaj41NOy1IfFXC5WWnnLUk3dE
 qvdum1DM/sh4THGCV/q+wWKo3RAftF/QLzeFMxTwo1C0otbAML4E7W1bvzTfcT/iSsqb
 +HTS/BLuDdNeWklUg+S6RtegstZnQngPDSV5cSMgYHeHNGRxfqmWstoXYWoFtWCJkscx eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3mktcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:07:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLAhbs023583;
        Mon, 22 May 2023 22:07:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8thrm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:07:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIF7Sdeq9ioDghTM9/wd3FCKKzokSCWr0/+01ixtECV08u3WEwjLxa8kTTLKjkCciyu66iCVaOKQh05Men0zkVrOJ0Mfjnqs3UntlgL3Hc0RrdrPb3hHc4FyqyKMVZ3RG3whOAox06ELEtVqELxJFi9V6UXndiIR9+v4cUSGFuTr5ytX70rzWgfvhpGJfBw2CzbGJrcunB2LFBLs5u4fDbYlqvAXcPAHT/LPqnlHxfpBza6AneDOcRUQtDnGg376+Pq1cqZRSd4dM2I5GL81QVh8uNw8v4vOUnJXebwX5tIu7tH5mjR5EbTKCDdKOuT250ckI9wvf205qi250PHDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6+4aeLAPcoCScleLzhaB65hBgx0hAbiQNSGt3W/7U4=;
 b=Apxnm3DEuV2OQ8bX+zc144wZsQCB5l/bzlYDnPziluB9ymF+ExtX6sUAose+8RrcMGOpLHgoEr1dviQuyrfl7bDpQmBbVSPmdnCASbOLbmmHjN3liC071b7g0ev+fJEq5PhOS8hU2lDaRZ4SZpKGIyzWqrvmsSBfaTgWsvDQ0rryDBPLPe09zO8zJpo0iZdHgyPHtKnSGdfi4KQsFuV8xVKMn9Nv4jvKn0XhwQekrHZ44ekHLTibkjh39Fns4p0LFro9uYbWYGcuSl6y7FBnksan/58sK/FY9MHGyPuEYpS/w/pmDsgLaJBDKIdX8YlegQy0xPBeg68Nh1RSY2FIDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6+4aeLAPcoCScleLzhaB65hBgx0hAbiQNSGt3W/7U4=;
 b=Mvlm44zLIOflggxcNfookiLGQa+NuXj5C9jb+NVtLW1eSZMCsTzbEkM2kcIAdGmzIN40VMJ/dE31xdlTZdgHt9PWQ2ay7gvxcKpte07kxfjGz3aoDhU3BaIm6PnxjCRjPl/C6BQA77VLYFNrcdRfm8SlKzW1dSsQl45Hr+oK9Hc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH2PR10MB4215.namprd10.prod.outlook.com (2603:10b6:610:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 22:07:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 22:07:02 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH RESEND 01/13] scsi: ncr53c8xx: Use default @max_active
 for hostdata->work_q
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8gkm3aq.fsf@ca-mkp.ca.oracle.com>
References: <20230509015032.3768622-1-tj@kernel.org>
        <20230509015032.3768622-2-tj@kernel.org>
        <ZGmGZxYmN0En7wAB@slm.duckdns.org>
Date:   Mon, 22 May 2023 18:06:56 -0400
In-Reply-To: <ZGmGZxYmN0En7wAB@slm.duckdns.org> (Tejun Heo's message of "Sat,
        20 May 2023 16:48:07 -1000")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0113.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH2PR10MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e707575-bd5c-4fed-49ca-08db5b10decb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1dMo4spthSDSXI+7P7c6HV0G+fKnZKdxZxJs2VBtKDmjTauO/hWzW5hL3nwpEbwXwO+fE/B5PMwHLPy5Qz4Qq8IreHKSyS+WEaPpscZ2wGHRgoY5kF54iaTqc63lJwQZZ7ibgSA+VngCVbkNrSSbUk4ugwnjWzebpZ9WHwV2FQaO5Kqt4zNf3rP7LpFqRoXdg5gNkesnTkLbBwW1YdIJVkJR8oG8v2/eaUZbkPdhPiSk7bxHFCJC9I4MOodrQRjKQOaMwn7DgMmjOc0twu9OOGqK5uI1eozlKLsH2DfwQda3iEPl9gWyV3c9v5+N+oHoKGFb00l4Kpx1AirNy6GuZkzKX8BQ0z0oj7hxfWTiZggSDiQ8sEEWZaKexorhACvRPoKzOIaegsS0QaejbrVa3Ia8BwUXpCM+oAAZBZdcvjsmDlu5AgoeFSqeIpaVCRmrRhzMTY7x+gHI9s/QF7kacz758nx09HPG9aABiEnIqltkOfO9wYYBalCTFMVI/sJ83O7ByAMrHPPrCKyfnOYFgT6DGNGbrDx70JGWwO9rbenFIhZNLk2NvHJ4JxIbp9P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(8936002)(5660300002)(8676002)(83380400001)(4744005)(2906002)(186003)(38100700002)(86362001)(6512007)(6506007)(26005)(316002)(66476007)(4326008)(6916009)(6666004)(66556008)(478600001)(54906003)(66946007)(36916002)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3IaLx8PHP1EKwZq7EFBU6yB6H2azOCTs8kyHFm/ESiDCpqx40VCIlzN5yYtI?=
 =?us-ascii?Q?wz5PMnYwpiQXOWq2c98Wf13BwKwNHB9h/7V8opa/dQFXqc1YUSWSZ5TTIiBF?=
 =?us-ascii?Q?98mRP6jvRCzzsBH2ofpwGMoSEcv8+EitRS3kZVcH8NDnwzv8ZqGi6AZrtNlm?=
 =?us-ascii?Q?R/50jbN0SBe9vy1Kqm3eZ2qiU++MK5rocfYrsQBYrQB+Mc6wodezQeMKUI0N?=
 =?us-ascii?Q?1kXx23Qvw3jzQZHf7gIXTXAsxSGegp4+VQ1q+Bg0z9Gxk8v1ADXQfWOHNh0Y?=
 =?us-ascii?Q?7pvn07v0gHfCL5I3lr0m6ksN05TuBOJT0PBtwqDhCds3mQ09JkiHopEmPdKT?=
 =?us-ascii?Q?BWhe7JLf4gfnBDQZ0QFhCoIWd7AYD5YVIwLJHZ43V27s9d2b6Wzh7IHFC8/P?=
 =?us-ascii?Q?7djk67yiBAF5OF7zUZ115I/MkxwsTd9Pwcul62Ku3thV36I5S3FFVia/4e7z?=
 =?us-ascii?Q?sEt9mRzFJV4QaiwR4+gObXt8fF+DZVS4LdOq2V/sCbn2Rwytl2Lm1V7+kI2i?=
 =?us-ascii?Q?rBHLvsN0/jDpRknFs/pHZZPlEUDZHpJM8kJXB/Se+ubTDkJtsG6UiNn8mZ1C?=
 =?us-ascii?Q?8EpFCyIlE4Uzzyz5A9Vy6mUcwM9MZBbHB9buIeyAIZaHHkvk89iLPtlR7byg?=
 =?us-ascii?Q?rduhj4pXXS9yAaYkLfyb06DZSoHQax7RKscEw0Znb1NOKfrYx7hcV7jYWlsD?=
 =?us-ascii?Q?q1X7+ChcmY+X7HckCDJz5EPr3Fm6KConWPUvlifvznTttzopKQj0M2ZRKyVR?=
 =?us-ascii?Q?yDB/lsRC5C2tDCeNYYtUrLHpeZuMCOaEsrHgJDOgkrKc/dsaMZwpX0PWlXvh?=
 =?us-ascii?Q?LmxyOS4m8TDXAdr35VI5u2Pha47dCofSMPqF/ao31StN182RwvEf+a8C1/R7?=
 =?us-ascii?Q?x5NCXGsscRSEJVgyjJR4+bsQTvQSb004oe668uvNh9O4apSTxJiXRS62yTp/?=
 =?us-ascii?Q?UaezZ0LuhvGHNOonT/MoUYCQehf6zOyS6axdDQGhq3TpAeQRzWrIonTxGNlv?=
 =?us-ascii?Q?DB/hftF/4TFULqd8PTB5/Njz7yCaevVr41LlbcaPWxrAHCmfBSH/rMutrgPS?=
 =?us-ascii?Q?aTWrdJmFYVsOyaaYNvtU/VghKE3TU22Udq0wkYA1OlvDgzOFkF5WFN0HlFyz?=
 =?us-ascii?Q?lZAtY+7fvBaeDvZjKhQpmDJeGEp/bprni56hmW7x+W4f0JOT25yb9apTqGxD?=
 =?us-ascii?Q?Plw5p7+b0FCIcUnzK0V03vSVvCFCzkfa0tHKmyGBb9b6PbCIv87gxjibgs6v?=
 =?us-ascii?Q?2ol476gLxpRAzk8EXjZu9A+lLyr9TKVDxW3CyLQjqmSG6vIIZEp2SD3EMGdK?=
 =?us-ascii?Q?eA1gcPBFnyfGtdBZ7Av5G1w4AphPLyc4G/IhN+PUdo+/NrjcnRweOZHDNQhf?=
 =?us-ascii?Q?aO75DrZJo2S/kRQJ7TZ9w2p+ufR5271hm824wh8277szCjrFMl4PSMBvtluM?=
 =?us-ascii?Q?0q813X5uEbixs+YBXlDQ25rNLMtxd/+kkPOpIZ3z19Gmo4BMI889LpG3eEx4?=
 =?us-ascii?Q?UuRbI4JWQD+WIfH3aou1SXOIbCKy/TjEGbFuCg9mmVxtjL2iTwgA27PABRPI?=
 =?us-ascii?Q?3wknhBqGf28ywuIowEjTvW9Z/WrkzYtJAjVvRDgv4T8oOfkWCOTkzP1Y34lg?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 309HPZR5/YEvpQ2NZfJKbp29iOQGS5xMKrjnENkS8LnVg9e4lWdxxiiRxO3X5K1XXHfarPh0lvmU11tar1n8y3TuvtcnK94DxObr/jdL3Cr8CBT7qrf9BDXfcqLRxLH0/zY3qplek7/NMLJLcnLyc33S+5jRJrS9MLNaZBi1JbtEW8lOC36oA0kcUNwwbQ2/ECYn1+sD55gFd6OyiorddYErpdacrvEnJCItfFI4mBTyx5fxgJHW1F0+ajjWdVO7ZKzRIgT6STrFKbknv9ZtKpLG/ve77RND44z9ae6/YYI/U92rSJcrfobNr6fb3kdM3/U4DJdBLWTg+xVK5tiqhZwlG+XNF3JQ9oIRwgb0QagDFQ+gLkUQHjC3xrMfoWKCRdwZ1j4FnbK8K3xtjgMKgQkQeGDuEfGwCTqAdg5E08uISst6UDAUdGzhlUedsRgi91DpqOHGKL3JQBptbgiYB7JtWD9EXto0FTUWAhLvoLXLECUvesVpjw1RbstbqkIcI0foxXFwkxlcrB4+Y/gkex8ACeDNkIuxygpFQUCIaIJThwpJwjAN2G7Ogoat4MZALXcssGGQt5+rKFh5DNSayUb1/d//6qbHgn7NIeI8xUNhf82lWIW+avaR/cxUHFqEKUwwEWra/uOLgL/72c9JT5GF5gGbj+7Z2sv9DX6tUZ2JjLypVXaqJr1ysz8rFXz0Nq1O7Rqr9gwpAUVFySDOTxdHjzigRxblyc5ijnYrB/BsqhqTU/4Bg1dYYPbgkSGyDVVIynqHDK8uAdTTrnsmt6vx3zTmDJ76kv+k+uLOqEpNNANaT9Ma36mBdff/Vw1y8kdxEJz752XgpmuZzyNbM+ZvxHa3MNPtQstiY9MGtUH27gKcZ4RQKhxZGrSU9Gp3X3g/isUoEdOlVpw/2QrMWtj/mTTbA/naLw9f9/6Miss=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e707575-bd5c-4fed-49ca-08db5b10decb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 22:07:01.9636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqD7UAZMu7d5CZYp+mUmODYki5A6jvHGF4fjzbRifdtqJ0J//Z+fSXKUDgKEVo5a1S4xEi98zLvNCJIVDhcpEVSzqzRBBSJGARKDcTOH9zE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=849 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220187
X-Proofpoint-ORIG-GUID: P6LDsU2eM1o7WGt1bKOONOCaXbK9A974
X-Proofpoint-GUID: P6LDsU2eM1o7WGt1bKOONOCaXbK9A974
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tejun!

> Subject: scsi: ncr53c8xx: Use default @max_active for hostdata->work_q
>
> hostdata->work_q only hosts a single work item, hostdata->main_task, and
> thus doesn't need explicit concurrency limit. Let's use the default
> @max_active. This doesn't cost anything and clearly expresses that
> @max_active doesn't matter.

> It's not a must but it'd be great if I can route this through the workqueue
> tree so that it can go together with other related and followup cleanups.

As Finn pointed out, please make sure it's tagged NCR5380: instead of
ncr53c8xx:. Otherwise OK.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
