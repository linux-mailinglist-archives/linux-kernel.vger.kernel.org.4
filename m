Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1694F69EC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjBVBOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBVBOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:14:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E051258B;
        Tue, 21 Feb 2023 17:14:45 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LMiLcF005184;
        Wed, 22 Feb 2023 01:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=BitNqoprltpRoPCpcrnXdurigAf6HGffhnwcDfzNEYw=;
 b=NtM4N4/IIxKtCUA4oidULeTm4o9hKgypYSerKK2G9YmIi5aDD1BvXxfN9u27R2teItWa
 Jaep6s0mTkdkDvVJMorNW+HWA5HvzIEor6tZcWPpdFeVKJn74VFTda7b0ukaJ9JaV8/x
 mD98+LS00ZYric0VIcmdlYMvtmI/Ya+bj/oFjEm6iBW2j802lpiiFyOWqK0o/T2mKECJ
 TsqcfiUckfwHhcOr+tKhZmlZbzZSZkTtRhtXsXi6dL5nPzMubKU6reni9WL/5batTf4i
 /NQLt6CWLKOFU8t4acYaJ0prdAz/UZ2oEDwU/DG0w2GQEX5tHPPx856X44+rQeSvw1cW NQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpja6q6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 01:14:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LNpHVF006825;
        Wed, 22 Feb 2023 01:14:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4cg056-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 01:14:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1I5MZSkn+UokDD1G4qI9oHUHA5BdEmjwzR8snNOvw9dHKP571M4yi/KBrrDTPRA//3dggfBWiMzbBWPRvMdZ9c9VF/65iOanKqUlSEaxo148NzlPXeOJjtUX4RWvKvX61nJr2mPMDb8Qsuk19t3PylX590sUWCfpKMyVCxpRTFDzzbqo3zgaaXkApUt4z4L6re+zA6qCWZA3yNQPbCF2Sb7QjyftXMCgzKDZ1kGTDmLHDII2L4/QU/xar0+3OlTGNV99TgvelnzYQIKxoVy80EPvx46fn/rha3UHgOHzfC3XAmoR9/AqABSIG7reo5gorgQXBmk0gwL/MzcGARfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BitNqoprltpRoPCpcrnXdurigAf6HGffhnwcDfzNEYw=;
 b=QZxUXMGvWm0BgDVz+ZzzXnrZi7n/z19C/kU2pz+H9Kc3kWSc23fTcC5Jfamhah7DJ+UiPSeIKF23LszqucesqEIBGdRlEG7p6/StAW3XNiJA2t7Vk0aRWPp8gp7AYQaEWF4vi4Q5BBI3dhfHbCnVbapKQPaEeUMYXysweNkKG3Xb+6UqsL69Y4+y7yfLBh83dR14rMbi3GpyP8Sjxk4BXVSHjoGRBRobmRKyV+0TwXQqOv7lVc69aajAl6M1OjtihBfdZN3ReS+a4POtd8z4hQEbj6hOCvxE4lCSVtvIDp2/IiWJPAaFxW6AXFby4qWS/HqHmqQbkTkD6kI/TQqqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BitNqoprltpRoPCpcrnXdurigAf6HGffhnwcDfzNEYw=;
 b=lKTPSH+0zPmuF4Pdxmk1HJfzKZjTGpU7DSKSSAu/3xlMibjd0P9hS2fVikEFb/x+KbraWgzFekSs0IuX9tbG8zTKG6iHvd1mVL8DMOp6PUmSegFHJq5Ndf6q1MF04usMSNxkJSjHA8QfhByE5a7M6E5DhqpRp80jr0oyU9B3i3E=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Wed, 22 Feb
 2023 01:14:37 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::768a:9658:9df:701]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::768a:9658:9df:701%5]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 01:14:37 +0000
To:     Jesper Juhl <jesperjuhl76@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [Patch] [drivers/scsi] Remove unneeded version.h includes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttzepkq0.fsf@ca-mkp.ca.oracle.com>
References: <820137c2-decc-3d78-f170-7f1c0571fbb7@gmail.com>
Date:   Tue, 21 Feb 2023 20:14:34 -0500
In-Reply-To: <820137c2-decc-3d78-f170-7f1c0571fbb7@gmail.com> (Jesper Juhl's
        message of "Thu, 16 Feb 2023 01:51:30 +0100 (CET)")
Content-Type: text/plain
X-ClientProxiedBy: SA1PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::12) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 240d4084-1947-43bf-1c02-08db14722a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUehTIVGJ6FNbI+t50jD44dDVG/SjyuPzzAvLb3BJH9DdUbBHYblijk7yu4h6XXmnHcvEicKwrb4aL5nWf3befqKFqn21c1QIshRHPIOpf047wgFNeMUyspNv6UYAgS8KoJFPpAhDCJHM6Ac0z5+t8JhozvGiu2WkCe/XRTRn2Nz4ZLu7B0W+D/QC1RqlrsV++3wGl7WcQZBIvsDHJjz2+jcVVS9xtQd52XTx8dmO+Gas6eIQdfdKNnWdlcSOjVoA4ZSTbbyRaZS+yhJAfn1XpvAM3q+0+TfxTC4EeVzKcaUE098EL7prR3wPXvuHDSnGRmXiYWQPFwAqhRUMSZp1ystXgfc3wpn2AUHxKNC+Jq1jfn4NDCeHKUq1xj4Vv5Cvhmpa/5vjvapii48IYxYaJK7+J2bTz/7YJMfIdL+9gRY4xhPQvW5i0M35Lq/9y1WiqNa7i9E61yJkTaSBLyQXTwnPQ5xsy7owMH6T3hRh/gXYWA1Hne96I4zvsC9ggGmt3JJsfsKb2Kivq1VlYysW/9zSOkvoHuCFjggxFA/4UhW3+R3mZVtgBQLD4R3jN/QVFH+8NK2ScwKTHLRnAMxqwpMbWFpF/JLUAq8mDNKaurq2cfUMSjVKNIwI+1AZg8E6T6Fr5pV01sDDZQZRTZwuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199018)(2906002)(53546011)(6506007)(38100700002)(6666004)(8676002)(8936002)(6512007)(4326008)(66476007)(6916009)(186003)(26005)(66946007)(4744005)(41300700001)(66556008)(5660300002)(316002)(6486002)(86362001)(478600001)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C9gLBCE4+C25OMQd7zsRhTwkAbQ7sm4DOrkqJnSiL3AX+2K31/uYzoRI8ozB?=
 =?us-ascii?Q?/rs9/7gchXmsUgFi0m8zoxQZwIhe5P5gA7qAG1CVI3iUW72q/baoeSC4GpsT?=
 =?us-ascii?Q?YdsHlG2eYYW0/V+HSAO80+47yQYqT6ht123PfqyY417NbCVRDvo+x4jRs88M?=
 =?us-ascii?Q?e/DlgBsPC9qWla7f+yUXWwa056MGNfx9paDoc1ENVgEUTgmmVRpRE7Z4W+Oq?=
 =?us-ascii?Q?IoBkkfR78aLimf31+3bkU+R4J5v5ygf34Z9m5p9RstHecvMKC8e5CrU9VDUV?=
 =?us-ascii?Q?lN65uComh4JnKorn2rM5DoRbmt6HmdS53afQbEtPMHXqn7i5Pi8mndHczunX?=
 =?us-ascii?Q?sDC93K51uMcg93nBQ8KbEKBBfOounx1ayk4rmAtbaLosN3vZMnBDqsUUQyyH?=
 =?us-ascii?Q?TmJPRVmFCYnVPpmQm3Iq/O85eu/UTNG+i0wpDpn0sNZZNfF6pKidY5YtHnoi?=
 =?us-ascii?Q?zmCHaqMnR7tyez0QHjugZH1LAAbCv/lpwTNQefB0u2ciUKRHApxCguJx40Xe?=
 =?us-ascii?Q?8Qk/LR0D7pmoJGInP0jJsDHbQIMcjmbInfrYmfkyoW+vl1I3hcwy0zgUIEa7?=
 =?us-ascii?Q?lu6GmNOA8tBgf5tlYcYrBgnyndg1pQqM7U8Gzwu4p9McB60cEgZaFgyX7VRQ?=
 =?us-ascii?Q?25+SYFSmHFY0xhec5H9UIYIBXc0nmjn+xe8HIa5DAUm0x4Djn1lWUNvFYOyC?=
 =?us-ascii?Q?u+Z4X6Kmu+blQkgELCRFkx1/Pkr7ue07nqkTyUZ3YlEuvbmiAJBtcPXSs++2?=
 =?us-ascii?Q?S7L9Oc5dIV0foxLKiazGxj6A47mF/ddi2LZ6IjSLgQw9XGkT68JJOGF/HA+u?=
 =?us-ascii?Q?Kj8iCVcGf6jfRzSSu2MwwZ5PmR0rxWzo0sBNhgSVHywRk35lmywExzQa4Rn3?=
 =?us-ascii?Q?YsqsduVnddel9ddUFnC9GbteGI58Q+J8KVler2KwwRKIZGU2pxKskia77KU4?=
 =?us-ascii?Q?iUYBemgN9SGTkFZ+Ir025udtajZQZTJ5jOoZLO0sTgDnXTEGcIIeCN8ddL06?=
 =?us-ascii?Q?0fknxcnO6tH1kr4f6ckwrzydhHXzrYde6/NWySDsGrA1BFfPu19unju1X+YQ?=
 =?us-ascii?Q?rScULt1nGuDNAbaAAh65y8zPfLuyeri9sfcQ+VRF5+sMXamZ6Rff9T3aNsnm?=
 =?us-ascii?Q?kYy4hHqc/Bo1oF7arN4F0j39WDi0LXZ9PIHjMM7uIE1/DLMJFatlwQVr5fv1?=
 =?us-ascii?Q?467ZmFUo7fODJ7YAyOuLH/53UjGY2bTHZKIGGaJvXY1xczNJA/ix8c0TZVz+?=
 =?us-ascii?Q?v84oK/IFY3zDufIvB4gX/CvhuyihcTsAbL66gw1ouJysCleYdKROCyMqLa7T?=
 =?us-ascii?Q?qi9x1d5tzxl1Rb+PAp8eVig5OmwBYCrz/xwxVBE5OEchnvLh1tDHNDQC/oBL?=
 =?us-ascii?Q?vz58B3xf56CUGt1WuTGpoCwMaGqqr/9hZ9St+ZyX61Qz9xeZ8ByYMvy8B98i?=
 =?us-ascii?Q?HLZVY+LEyOsQ6OE1uJL4MkPNnySiTpkwbGpM4X0denaXgnFHSwmAUCaHWn35?=
 =?us-ascii?Q?mNNc7auggY9UcUHPaTnX5+RNE07pOL2LnqfdlfSurd6S+UFvuL59InjDMfwX?=
 =?us-ascii?Q?svtPpzdXL5SIh9cGMhz09cbebcNAQBwyh9HFWq599P/U4GTldizhFvdA4dqI?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0stz8H6/QvcH4PE8Utx+gVLSH16jNU3MI6OkBrCQUsDyCXFTgyXSeaar2kTPADiraQvSbgNYvqOhGBuLY/SwFuEpGV0/NS9riUC+++XM/6+9c2s1AHYN5S8dNAAzxkvAL0guZH9aStVEy5ey0B+7x7pRnVPfvoxlzbIb8az6ClzQ0OOwXJZO2q3PRTKbMvWpTneHacFCRqBUC9gvIapN3MKfX0xUvA9Fbl18p7dS8+Tdc9Ox9gZKmkSG1UfVxqUjVUwizIy6lckuXDqJ2wasYGHBTyVY65rCCt/4Z+kia0FVQ+Kk2TF6DSXaPrehGcE+vSNzZJePpVfAzjR9VnisL6AOffjriLl2xOgyWJQM/32HMHsQovMl0sXldmEZ8lDVaswQU252JJHfAg0iiBe/XdV+TXScmuEBGoy2hewtK01ForLsQGfLkp4N4QbQ4MXCLCbLfo0vdlQG/ynggM/SRE0stQgvt+dz0T4oNJno963SQ6BlNTc6hc++9zkBIuNQltcxZ3vF5F8E5gsQmCU9m/nAa4HGpo8zomXgatChXVjBKO2+zLXiEwIWQRDmKEDu/e8FTqq7nN5GzvwLva51L/uHCFnBCkhJwLrC5EMQSkwlkjVN/W1C6SLe4KNdoR/f42EcayWCfmhQCba1unEdSmpTMSEi9b12IDYrshS3e+NBgIQxNeStx4S6nPsfacU+xb7fIXZHybUtCFBaQYhQ088q+oXw5iEleg4/nbk3wIoFTLeJAbATFUguslrwn+mKGB9rkCV+4vGEtHSej8jP5DSJ1hCehLtI2eA6s9zRbwbpQPXmjJrE/JSxXuDJm74CVCVRiHRek/y9V756it8a6s4J+vX33DR1yXK4RTJUMW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240d4084-1947-43bf-1c02-08db14722a64
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 01:14:37.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wLCalijvQAhYSyaytxbHt4YErpdFj9YKnWB1i2e3mjCA4KUG6gJl48E9sS+K6ENHL8zzj2nBiDhZjCn0qmxVQTQcYUzKKSREv1cn0lqUx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_14,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=743 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220007
X-Proofpoint-ORIG-GUID: 0Xx1wjINX-XSOn3o2vp4gt1pNuT045yB
X-Proofpoint-GUID: 0Xx1wjINX-XSOn3o2vp4gt1pNuT045yB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jesper,

>>>From 141c4edb27491e75d63d3e38ec904f36439c03e0 Mon Sep 17 00:00:00 2001
> From: Jesper Juhl <jesperjuhl76@gmail.com>
> Date: Mon, 13 Feb 2023 02:48:17 +0100
> Subject: [PATCH 03/12] [drivers/scsi] Remove unneeded version.h includes
>   pointed out by 'make versioncheck'

Your submission was mangled. Also, please post one patch per driver next
time. Had to fix things up by hand.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
