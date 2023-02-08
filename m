Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9530A68FB98
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjBHXvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjBHXvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:51:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B5E2110;
        Wed,  8 Feb 2023 15:51:09 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318Kwn3r002969;
        Wed, 8 Feb 2023 23:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=OyBit0aOhHF+ChjZHPRIKhw54cjKUPKgY9X6XLeWoGA=;
 b=hYKQjS5OBlRlh2h2pI5biY2qjSriNFmtVOGul/sllDS88izkFzv4V1a/10Q7PwAsF6gu
 lg0cup1Va0KLcSYaWvzGxGh2Ad45+TijTbxo0S0uCt62X4DFdOiLyK7pdEJFQ0NUdAef
 Nhh5yDdNnxjJDenVmBQ2RHErji3ZXGHkqj6PXJGdPk01V6n1JWIKczVX6TJkRtve/Ipp
 7Qqd5GLYuepOlElsTwIFkn2B/JSqdgDdiUFLl23cPjezBMz66r8nZB6RDkoUQN0d2amg
 UoOW3SaUeDfvIhz9cuTi5/N5jml9qYxuqcFpc0DN6+6Fejg6vzK4Dxdb8DmI6PuI+R+D bA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfwu9h7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 23:51:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 318NN6FQ036291;
        Wed, 8 Feb 2023 23:51:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtf0q9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 23:51:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MT/Fj4KGA2h0xwgordU5pMZfZFS3WtSeHrMBeIQRM0xqUnBKcM+jgMAPTbmv4tTNgQPuopsLsgQe4NyRH9SiypUbWc3JDQ6ENCUNRMPx1m3JQiep/C11/s7Zln3cSSKwY/yZJlWqJzSMxe8kV5SAhzqgDe3vHZ4kgoV1+19u6nuhhAx5pZ00eSaU5cAY5ZXxHD8va5+l6VgjnoIltTmqulYEFmMgD9h9GsYPn9r6FeMRxEBqWaYD5vqlEkDLFnjT9mkkxG62zA4lEcGc8B9ZU9tjrO+T5UeTgPD6I93oTEDZF5LJPuJ8ClymvUXg+c9+PJkXwjB+TSuQaxu6gwJBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyBit0aOhHF+ChjZHPRIKhw54cjKUPKgY9X6XLeWoGA=;
 b=hq/PfSwV+J9ncs1PnmbdsiwzAzioTJx9vYIKz9rxIJi0buKu1wdlwjzzTyIn9OVHFB+Opa7VFiQJL/FB570KjdJBoSYjsonjS0YbM4OohG6sedV/LxlKvVuUYw2LhE5VIYfrC30n+RozAjUVyF5ZY8H6vCaKmRMigEC22OMJn8CE77/Gdaw0cEWIqjjgba3+az0mxHupU+p2BifqC7DmtXBNC2wOu/9JDH1C7zItKtvgNuHtzI8i31+fH32U1sgGKtKcSeabXM0AwbFKmWmR2xNCIMED8Mobo2cnzrrxXVYLRy1nMdG+pE8UkU0z0vXKaS5Jj02ibl/nZrrO5CSPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyBit0aOhHF+ChjZHPRIKhw54cjKUPKgY9X6XLeWoGA=;
 b=lb2Hd5+UxnLr0JX87aAVGmC3x81ftQ5QtRT1f7a+H+Y9ooBWAuvyClt67lwUpMgAoPHb4Q8qz1/HCvH1agevgpcHkygETnaifKRhLKVsEwkWh7QsjJ0H4eshxq7cLQHjZpeVNa85KZEXTgm6Gq2Iy1QZr13P++drkm5Z1pe4T7M=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB7226.namprd10.prod.outlook.com (2603:10b6:8:ed::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17; Wed, 8 Feb 2023 23:50:57 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%4]) with mapi id 15.20.6086.018; Wed, 8 Feb 2023
 23:50:57 +0000
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-scsi@vger.kernel.org, Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: snic: fix memory leak with using debugfs_lookup()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15ycbzphb.fsf@ca-mkp.ca.oracle.com>
References: <20230202141009.2290380-1-gregkh@linuxfoundation.org>
Date:   Wed, 08 Feb 2023 18:50:53 -0500
In-Reply-To: <20230202141009.2290380-1-gregkh@linuxfoundation.org> (Greg
        Kroah-Hartman's message of "Thu, 2 Feb 2023 15:10:09 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0048.namprd17.prod.outlook.com
 (2603:10b6:a03:167::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: c13a0a69-8ba8-4805-2071-08db0a2f52b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJ0q5LMMGOtXIz5+yrMSKCtGuj5yEB8PwGZitkthVI+L7jpf55YaLmFmQzAgY2XdMxPG6kyL0MJTYOfIeA3IcJ+bAt6cYXY27YHfNwLmv1lwx9fl6OWZuO+M/gVzjWtgWqF4iSrTjkHQ7udv62MdLoup9v5Y2cA0jpibt3ZXELH9vPSSekSVgdQ8URaUWjLd01xU/hna8Z4SuwjvR/Jj3zswUwyZmPLq5zf79ZdJuuMdvs7DEuTCXpPQDf1+2GDOlskMX8m5mHwGegKy0GTf1CBLZdTUeWZpqmeuq9+fDy/YWI2fGtUu2L8SRe7DlRIA5KjPHeM87ZZ9XSYgEWS6bH2w0QyM8pe90Szd7tRIjV47t0xpOqNq/cpGL3alo4B4G/r5mP0TVUNIXyF9BfLQASUWz8M5fvzQMt3mdCCpKwsoCOKD9IHF2lYOCbzNSMviZHq+FTq3gaWeDa2rRSpZbOaguvAAcuYCK6vNp86SuJieP3H1YKl2kY65sZkgtm6iPJZcDlyPoxd56bmBAZ4TlGoAxzYHieQMgoVr64yY7DekCSvsqZ6HM2ZFR2DV+kibWdfwIjKQOhiBavaxLxe9yVEgyKutvY3sspRGhzl5sPTqKSo7Ac5zv2nyEviK+Gs1Dh448neaQuqCXHS6L6m1vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199018)(6486002)(8936002)(6512007)(186003)(5660300002)(26005)(6666004)(66946007)(66556008)(6916009)(8676002)(4326008)(316002)(41300700001)(6506007)(54906003)(2906002)(86362001)(36916002)(478600001)(66476007)(4744005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9fJXW3qVLkGbLAprlGj4OPVj8dqcJJawlwOdOCIf2ilf+YJsMvKmfLT7KzdJ?=
 =?us-ascii?Q?wNjx4VPHKTXFtl0zyoUFIxQIUv1A3M70M9jofPlfOb37jBanFj1gAaEVCKJ5?=
 =?us-ascii?Q?8hfMh8h2W72yKbXnEkbAl3P+RDl7O5OUlHd2Q9+L/MDvVLWoLrHUtTzgb0g2?=
 =?us-ascii?Q?Kv9DXRz33IqB5Fmr38dAYWL4zqGP1GkiFqZBS711yaaZjpPEkBPGVED+01dL?=
 =?us-ascii?Q?sduK9az49XIdSInESkoar+xH4VBwdY2IkIOKbzdeD5MpPAM6iEq4S9El1OCU?=
 =?us-ascii?Q?rZ6+vyBE3R3KMzyIgtQkKeLf/6QayNluZohCmLkl8dv/D2idfRHteBt/x2Qr?=
 =?us-ascii?Q?CZb4BLjmEysfIiLxy4IR/USs6hphP9UnWhX4D45jXdMV3x0SKbwPlWDdlA4S?=
 =?us-ascii?Q?A+E9We6D6H+5tfcnmbqCIKfHgfHdChGc2Ee7s6xQfpLGf7X0GwH6Ar+8vUmw?=
 =?us-ascii?Q?dwHS2CIvJlXTQUbPuR8vsuf3zP2CAxk4TH+6cemnq3dtOkz0MDCpuDnZKcLw?=
 =?us-ascii?Q?Zx93RzPth2OqSmg/LAIgeSfBAUpHG/oOXSpKRsWA7fmmUpkUqicz/wZXIEXr?=
 =?us-ascii?Q?YYQZ/jnTX77xoiIryMHgTBrZy7YhPKH1m+CdRmLH8Wcg+kZn4fE0HQ0hIsFE?=
 =?us-ascii?Q?wEcM/ELIvS1zvFT2RftUXHVInSuu0cpFEw1/9UEVHbFDXvxEzt8zjOIBZjJe?=
 =?us-ascii?Q?IphCD+s164qFG7ETlWO/iX6uAaHfsZVCe+JLgXwaERqctAF4Cie+fu+eyfMj?=
 =?us-ascii?Q?HpWP4SlaizUDOcIWHCLbPzuaUPuO20kstl/mVw6LEYRmpQJhgEURUWsE4AeV?=
 =?us-ascii?Q?g+sYGxbXPyLSf+9EQuK7AfKCvDD2noQQNWVIwnVc9bOnLlJ84r2Yg3szO5we?=
 =?us-ascii?Q?2NL0gJYVID7hBCDHfglq8oLu4mNTmSQne31pKwnpaTZYbqXINpycEKIEC6s4?=
 =?us-ascii?Q?LGjCg7yRPmQHmo6xcFPCVpJlB7P1O9rATfZuNN6GTmsl4ixjVHKo7FBs18gT?=
 =?us-ascii?Q?qGoUJ9EEnEc9KB22Csd88P8lHmZv8HuYKXTWFX2ZOCUhn2vSbpxxNpnkQFa4?=
 =?us-ascii?Q?mPhKVfAr9wELNlhLSIjuxsLwInhYGq5sBUt/VntNHQEyvQQbtv6K/vC8zgkS?=
 =?us-ascii?Q?8ee1QIOlMNZit47hDxPc/r3XL0lNW4j55fphj0J9m31d2Bv7hfyLReDYLqOP?=
 =?us-ascii?Q?RfAG0swgzKS515aiNxAqaksMx/UjJmpyg2XHbFD/p72gSpp4Ve06mWACVrgW?=
 =?us-ascii?Q?g2pp54futbjArnZLDUF27H+X21QxvLXJinm1rD7ljkloCKsuObGCCMapsfAA?=
 =?us-ascii?Q?gcOF860ZprW7MZM7n8pYa/wohVpH6x1nNJ4Drtz3IlQ/ToiaVN33XsHDXC6R?=
 =?us-ascii?Q?emoirxm5xaZWqVOc2yiq9jhcX39NU4qHuzscavNTKLxM3hjxWt+uyR2HCAkb?=
 =?us-ascii?Q?cFENVHMptCvVwlU4gdVOOjqbncO4olXojNGNekxf1UwYs2qYc7SWEvTFPCbL?=
 =?us-ascii?Q?CPtY5V1+r7KUqHdF82thB4G2cWWZsFLQMx1wZgmStK6vnMLnFiVslX01ScR6?=
 =?us-ascii?Q?x0p7xbHNNbJiwFpVpLgj0/2pCUIAmUn4Ty0qA9gQi+/D/sCgYA/zNb8WKiY3?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RbB0SyGlgvBg5dnEa11e8+4oc67xeCk4QsSm7Cjh2GYGt4KuDbub24ZYZclg5By22opmqV/1EA5ykdEFFa7klhRJFbyjSlo328QGKbJNlbZF28K6URc1Yt7EY/IYeTjSa0JKZDCksolQmY3iHM63ypDd8lwe506+k9LJLT29uoFE4/MNWXY9eTs8aaBB9nsPLz91fG5YBZgn7NYN1XZA3e+MsMiUZkLxj6AlDis7IboiHlCgVApSwtYoeT8sv1AF7e1aD8CJvNCuI4QqD4s7fS42XOUnmwVZqsv3VDzAirBxleSMhVoor9XgYxYNHK1Jv3RroF0MfwZXCy1isikJaPmhbJbjJAUR0+Cgi3kKzi80315U/lTSgG/J1Jfl3NgKeVs0fwCIss5NVMtekaGVwkrK7DFtB5i0Kzazr37J3niTLacbC4f1Ul58OlJKSnL3Ht3gbE+3m2fTGZnXXMiS9mOoaA7bom+QLEjIWY8IuPwXT8B3dgr4Zuv6V9ccitUmFPVOK8deCCqfoLw2FLmLl/Ir2+JqI4bUpfcnA4nhJGmwz+KvAeob7jb8wgApYr+OuEZm7SUtLcK54SWNT4dIqJ/3mMdQhU6AQ+0MYMcDDJ8cyya6wV3TNG0ewqlRLCvuJqqHCX3Jn8PD00hsX/Wev/4jS04u9ebHcWGu6tHx1gnRoDVtHD12vJiCU/r9U+vyF68TX8p73fFkCS1K64VVV/2lR2bj1Z7NUdQ7z1MQDv302lOCrRtm5Scyfv+lBXQiGAsQpVs0gNMAThJH6U7hFCfjgTrW4pW0RQ3EyWWfZHUAGDMSPF63J3FBywzp48qrYEeFKpoGS5Fw3tL2DFhJV+tdMnKibW8CBzpwAzQqzNReIIshP/It0iDBB+XNnZyH
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13a0a69-8ba8-4805-2071-08db0a2f52b6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 23:50:57.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAKxlRaGxI8yaispRnUAfSuvxtX07UOeYxUVw8muRSNHzJ5E1gNrlDG0CnObYcVYFw35j/ducidO3SHPYzCB47fWBDYgL3akrcRz3eOm+98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_10,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=774
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080201
X-Proofpoint-GUID: b2cG8rS5HLJwP5rxAqH1w3u91_R3kkVQ
X-Proofpoint-ORIG-GUID: b2cG8rS5HLJwP5rxAqH1w3u91_R3kkVQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg,

> When calling debugfs_lookup() the result must have dput() called on
> it, otherwise the memory will leak over time.  To make things simpler,
> just call debugfs_lookup_and_remove() instead which handles all of the
> logic at once.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
