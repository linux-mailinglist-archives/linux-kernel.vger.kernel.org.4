Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695896083C1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 05:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJVDKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 23:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJVDKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 23:10:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EC225DAF9;
        Fri, 21 Oct 2022 20:10:27 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29M1VgJk024990;
        Sat, 22 Oct 2022 03:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=rHiDO7GscCPbebHIQZh5exOSutNG8iyD+NOytcqaZ/E=;
 b=oI5iXGhve6K49b7KQbqH3L333yj0bTj9QCDRIXGrPpB1qGgsWUT9OP+/ruGmOhZMFs6U
 AJR1ZXwwMj2PBGFjdHQ2dToRDah8uOZ60HKPJfLyvi2slrOOmL8clSuPQTgup5XFEDt3
 sxc0eN/nAb/mvqCrokjRNzsDKa5xlarftTNZH+8rfhZ8AFsKck55W51xTpfhRr8OV1RI
 TXod0ETYLzQ2dxztHA41yBQTP1wuIM/cnugDIUJdf+e+Jscp0OqH+aK2jfSQiJJwMq7y
 WXkQxZ4MXCnPoWojGzecAflkSiuJ9k6j6T//CrjUlnYsmSkW4SXAGUs8Ud3rKWLc8e5r Yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xdr20k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 03:05:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29M1XtfX003613;
        Sat, 22 Oct 2022 03:05:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y891ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 03:05:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUCEn6JqxCIMPfdaAWujAKUcou1cfMiAVh5SxAaEtM6nNJl8e4IAzipaHLF9eRjII/bEpynQA+ElKXplRxvJHQBUa1w6Koua6jW7WygOk2RGBySbnF4NoIJK/C0RsNsozfk/8bKvnJJMj3Y/n5oxFqxgQjNhsG39QNTTgbJXF/s3a8jLWtI15zY7eS2c6ihIFJXcqLVP+bfQtKpaOjfWs+PgYIZcUbylHPsrLVso8KWVBswFNKYSI0qpPwBdsKQgl6IjljAKU1eNwMebNHo3oXJSXg+UEsLnqTwzLsPdf+4rPsmPjo2wkFjpDHBU40NOH6Ff0RnvdKDbJbJIsw15nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHiDO7GscCPbebHIQZh5exOSutNG8iyD+NOytcqaZ/E=;
 b=dmraG9EqqNBrMuMAWZRo8sSl90FrZtUWM8LTapxPYacqwVfpWF+yV4CwUeZoa08t42Bodffy0I1UbWddPPVYyry46NOLBTHGutFBOkK8r1BD7yHqQZgF94+DSZYVG6bOKu2L4EbWJbS6zTlXqOekN7vHH5EUtSek1u3O2XFI7ACv+Pp9Tp9/hLeiqC0qwWZnNzTKl2iyAS/QBtCxiZH9Riw3kzqMaqPPHjLHG/CF6xWbf8mBMBd9wv9N/2xlebmLffMhOC9mSpNe4KPHWe8qryGfKSdYze5vjrFCrlA5yLjZdNRHJJDWbEUgm4kIe7WpiwuWMiseURBwrZ/3oACR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHiDO7GscCPbebHIQZh5exOSutNG8iyD+NOytcqaZ/E=;
 b=pmwvgEdo3mgn+t0R0euCzMWFWPpEAGii1+XpRx6rRF+M2Lenen3OFt2eE6UZXtAPVJyWps38DQnMvI3D6DT0G6BuenJrygS5BKeI56DEXbbjJVhhFc56ThehdYOapDhL/d+9oFBtfV2Xg24HswVpqErp//CP+0c2OOuJqeqEbRk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY5PR10MB6189.namprd10.prod.outlook.com (2603:10b6:930:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Sat, 22 Oct
 2022 03:05:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8714:e5ca:3c31:7bf]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8714:e5ca:3c31:7bf%7]) with mapi id 15.20.5723.035; Sat, 22 Oct 2022
 03:05:02 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@wdc.com>,
        <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>
Subject: Re: [PATCH v4 0/7] scsi: libsas: Use request tag in more drivers
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mt9owodi.fsf@ca-mkp.ca.oracle.com>
References: <1666091763-11023-1-git-send-email-john.garry@huawei.com>
Date:   Fri, 21 Oct 2022 23:05:00 -0400
In-Reply-To: <1666091763-11023-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Tue, 18 Oct 2022 19:15:56 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::6) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY5PR10MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b088a4f-5a01-41fc-6e8b-08dab3da3651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQVZA3SNssUHu3joLRw/0rfc75Hym92dlZ3z7MT97D1K8m7TMpWC2FZInx3sqlLuXSrM+9t95fCGVEWMyRnA1WTqCDhqWfDhOu4f3i7hkfavzSxczc38beEPwBiPH51o1upJAGBcbMkOFQpjpdywwKMEOwHlSuj5tbUPwE7T1MVpleNxdS5uEnN8AeY183Dxix4Cx5Lg8bRLgR525QaHeTr4Xg44A8Ey4g1k1PgAZY52kOcQl6SF1f1IQEFVUPk93q++3iLMtOaisdnEYU9NSV7xoylOTUY5MNG/SWOa5IeoXKzS5kduAasPtiInRK1x9HkXJ/6w7T6A9OvkHnbQvqV28Cv71G+lFR0x914982/SpAC4SNUdorkpDO3wcqazLSmHSgo/sVXrCHnqPqxJWOyWtVOkQ6rfxLvLMxs9JLtXfA5Kfo8vKB12CL2zUvQqVjPCD28rRyGg1OL2bM8pydT9nIK6FiqTvTtvYglAEciJ895AOaA7FFk0n2h8NqXtmGkhLdqzUK049OY2Qg7QT+CJw+PqFPGL6tvFAr59B1vlaWM1+NkhKlMbPToTVGLVY9tkhqcwWUfnouAh8cJHw2A/6gxPHZcRLKNX6XzaIiBbZowe1y1OqsSNAc6cdtVkCa4ApB8lTf7tBk7CpGm+oDt0mSibuCgxBdG3M84YggiBkE2QgN/C1X4TnaXWppUZPLXC3adOsHEtw2hw6Bbt2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199015)(36916002)(6506007)(7416002)(8936002)(5660300002)(4326008)(86362001)(41300700001)(478600001)(6512007)(26005)(4744005)(186003)(66946007)(2906002)(8676002)(66476007)(83380400001)(66556008)(6916009)(54906003)(6486002)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1fpbawOE52zgOi3JnxuY4Nwofr3Azv4W5U5n12sDvH9MQW9h6opumR71yf/Z?=
 =?us-ascii?Q?Qbe/4l4YyS1UTbp3SFV4LyPKCP7ZLrFuMO87KUQ3Ua2i86BVb14M6UFd2I8e?=
 =?us-ascii?Q?8BHbMJFEwkIJiCRQKJOBEKE436Q0sQdDmxQxERT0+2oeU8EyavB2D1xh7HPw?=
 =?us-ascii?Q?+wRdseS6pNd1+gvLXwDHVFKEd6Do+7r2QvxcoBX2cNXFvADzpVsDXFduNjrg?=
 =?us-ascii?Q?h/5Mp6re2D9GFFzwxO6Vy/EvaEtj2giQjrGfKpYx7bDfWZif3ZvsBYlLqwg6?=
 =?us-ascii?Q?gODiHmQS2MgJuwFfo3EGWip1TIeHgCC25SmbjKkjKYrMx7qUZb5tIay1L3eg?=
 =?us-ascii?Q?ORZjL03DrTFq15956dxq53Fu4k2eRkW9Iwto1Lf11DyqxKkwVvgePg7o/+yZ?=
 =?us-ascii?Q?MkddWmMrUY+osyg57GhfOAGKyXB7G4pkHp4N5RcVok5QMVLOguDgXZJjSJks?=
 =?us-ascii?Q?tUYLzgrVqzvknFqRl2uo0Z6uwlS4qI6PIT/zDu35i9iRgoW2r545TboJCSTi?=
 =?us-ascii?Q?/A5ETiSNtUiOy5Va4s4OzrhcI3fb/gB0Nefevh3CYe2guX1QK/Hz+45iIAgd?=
 =?us-ascii?Q?4+lOOsostXIBFwT6gK7yLT+WGGjsE3dj971tFgsqeGlowGLavYBPkO/xOmp7?=
 =?us-ascii?Q?/n+6VVhNdTiP1jv2MJ1Mhukd2QyaAmQ8FuIzxP4QuUOChueqe+qnIEsvsV3A?=
 =?us-ascii?Q?QnQS0RHG+Y9qBFFC8IoNkv8PBCo6pMzcvc+UDSIv5gXlxnUJgBWGctSU3yDk?=
 =?us-ascii?Q?wRwYVwlBu5rQI2xRywjdp//Bj+3WU05bwAnrPl1rSzjbcVD9eG+LgwH6P7Hn?=
 =?us-ascii?Q?nX0nS46vpK5yRvp9u7OruJs7WUSZRCJDMe4XNGHy0+l5SF4q23+EyEUIMvek?=
 =?us-ascii?Q?lqOoe01tos4Vc8FB/LqV0+ak2VXU+rHE+FpQ4v+p0fm7k8pF+cGWOQslcTbK?=
 =?us-ascii?Q?yhEmanpbogEVUIfqmxl16ki0Gbfis7Rg46FYomFXlnZUWjXWGt9woMdtVy9n?=
 =?us-ascii?Q?v3/PagqM9IRga05j6JB3ZZklrwgFTH0HHOXt57EciRxh8uBb9yY+ZIy2V2Mp?=
 =?us-ascii?Q?uPUTKNGMmcFmi1Uw6VueqNpXRwHP5qvmA/YWHMBdKYvk4dtIs3guTn2tFNgr?=
 =?us-ascii?Q?2dx7Eabm6XJangm0T1aGzAf5wRoug14qEYCZHav0RkJKaRpGBtMG0TkUqOnq?=
 =?us-ascii?Q?1GjKuN3TGiwnwthRHT+/Eh1Am2jtxgbQk4rjRJ2VsdiPV0wSf+LSWvfKE8vs?=
 =?us-ascii?Q?kuUzIJwSuafp8CQg7QcX0yQS3xuQCdejphGTU6Kf52BRD8BuPuPgp7hIR3CO?=
 =?us-ascii?Q?4RauMptlmxlL+KW9Nv5zUEwecmLeacd5lyfGmqQi2/ewkNuTsqTbetSqmtxN?=
 =?us-ascii?Q?mTPFUm9gOah6nCNgs9PCYBpDDXqduu2A9qO2+UznX+hWb46N9RJ4xJMtLMv5?=
 =?us-ascii?Q?cfOgoZWMjSpN14Lu2E3ZsgOln6Uw8nLzEt0zWIuzSD0b0uDYr4cVPxW7AYys?=
 =?us-ascii?Q?EBaNkiOXTNVi16JKc+UUkeR/98OJC6+dBlzsgWgYUskznvZwFwuRdNizQj00?=
 =?us-ascii?Q?645G9Xzy9xs8pWnkNeT7YMnkUiOTsb7a/ILSHnaq5bGRq96Oe2mwFot/sz0H?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b088a4f-5a01-41fc-6e8b-08dab3da3651
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 03:05:02.3469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77DyGBfGeoO/kPG1TjhjWeXJFVDyNEqa8dulhxh50WJu4AflegzKT6ocVy+92KcnyDRv7HItjKY/5RaqXyp4PlQohuM6NWSDQJIltjfIfpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=738 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210220017
X-Proofpoint-GUID: Cd4i_ME8SGJORTjUHhyBN-ssJQbRnpXr
X-Proofpoint-ORIG-GUID: Cd4i_ME8SGJORTjUHhyBN-ssJQbRnpXr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> All other libsas drivers manage the tags internally. Tag management in
> pm8001 and mvsas is currently using a simple bitmap, so use the
> request tag when available there. With this change we still need to
> manage tags for libsas "internal" commands, like SMP commands, and any
> other private commands so reserve some tags for this:

> - For pm8001 I went with pre-existing and unused PM8001_RESERVE_SLOT
>   size.  The value is 8, which should be enough. It is greater than
>   mvsas, below, but this driver sends a lot of other private commands to
>   HW.
> - For mvsas I went with 4, which still should be enough.
>
> isci and aic9xx have elaborate tag alloc schemes, so I'm not going to
> bother changing them, especially since I have no HW to test with.
>
> Helper sas_task_find_rq() is added to get the request and associated
> tag per sas_task when it is available.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
