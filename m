Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA4A6AD538
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCGDDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCGDDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:03:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727FA39CFC;
        Mon,  6 Mar 2023 19:03:46 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326NxCn3026290;
        Tue, 7 Mar 2023 03:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=KFdWgqILWHYdXuNrEEp5qfPxVaFvDCK5ls+5aNXc/0A=;
 b=HHunyD0ZUUwFdapEBpsWWyaEKA7VRlng2q9JBGbmY6b8LoWU/8c1mQajpDQ7XI51pB4G
 JBFZqLbZDt/B+MGlXZlFnGbZ5YG4x+Uv3WdZuvGw/vHXA8znM7+cjDe7P3bmPLVR79yL
 CbnyHjcQyvoR2MUrMnwEmzUPr0voWl0+RxFLg6lfyNKfYCpMIvOUKdqPRdtiaaT6MuwY
 QVNxAZTcBCYm+I3/6M1uO0FVIZVg9KzPlIVNLv6NsyDal1CdWDrwwpaqvbz1WSZp19dp
 MeHe+P/+08jzskXMtfcm7Lziuz3mnQdm24DUQatFzynbr8zhE8hNZKNvLWvp7TBHLo8K nA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn90tut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 03:03:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32729E72027088;
        Tue, 7 Mar 2023 03:03:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u1ed4n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 03:03:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cpi5RgmescCBFNgJu5R5nv7s18chWkvTElHut/UoCO7QKLXS4jOM8P7GzYU/MaoHzBSxSDm6Dbg4+wf1MesSkX0epMiaqmIW0rkHYe+1kLayJidTUMmZv1buGMLaJUYeLYnwyZmdeHnN+kBBlcZAm4JhRXuemolfWtUJNCY/YDZkxs+nuVgi128EZDwfk2dhGnqT7Pbi1SjxWsz8HQE+/WNbXBo511QOx98foeeQngsgODIyv/+HIylCvkaInDJKIT4A0I6K3NS5b3VEqgcA2Z7+nsz9UexyP0METZHAMC8zjaLYxBlPEozDjivg7bfZjBgFAZH/3epj9CQCGDpwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFdWgqILWHYdXuNrEEp5qfPxVaFvDCK5ls+5aNXc/0A=;
 b=dLIGfQWtYZnR5IDY4vad1OtDH7/gL/mKOfUpNxGJq1WVz0JAIKH0CavBBTam+PQ41m2b8M1UCUnx4xnr1/JZRIcwy2kIm7ZKca44x8Pl8jQcEBd8FxkUuB3ggQmdN0XdhnJlr8DNKEZfM30PQzWj/4EE9zUeh6ybI1kk8kDbVxG7xS6Ejbv8yN+cmyq4oyvTTNAruByRI1JowUyH0WyYH0nsfXwSxCMJPmN95dIW8gnGw7lg5mb/9Q8uYFtCcHkmqa/I5nHmP/yE535CNwCsK0nAirlvmxJ5tvNFrzawyHiSoc7gDV4jgjPva0PvSqY9opFxL1aHYq4uqfxC+sqw/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFdWgqILWHYdXuNrEEp5qfPxVaFvDCK5ls+5aNXc/0A=;
 b=Z/4oQdeON2+4d9T85Bt7+0HuyYn00KFb0UqoRsICFcm+T/Nx0WfcPVBwc6xaUrOJpatEl+z8eVtpNvoyOXP/YRlHbzHgi+XYh0V/+Q5xXteAj0RePyh3hYW+frFF+sGXply9DN0nfx7ZhscpWcxkWoJFzeKylNEhmKdb3e/8kos=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 03:03:40 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 03:03:39 +0000
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: message: fusion: remove unused sas_persist_task work
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7p5l0u7.fsf@ca-mkp.ca.oracle.com>
References: <b2ca2164-5347-8ec1-d8b6-3225df864173@I-love.SAKURA.ne.jp>
Date:   Mon, 06 Mar 2023 22:03:36 -0500
In-Reply-To: <b2ca2164-5347-8ec1-d8b6-3225df864173@I-love.SAKURA.ne.jp>
        (Tetsuo Handa's message of "Wed, 22 Feb 2023 00:02:41 +0900")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::41) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 73876d04-8b65-46f2-0fad-08db1eb88d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvzIYxLnpNPI5auQ2CNvTgCI1GgFOPF9OIPCa7YGucdc+dKo+tDiWbntWvq/6xz8n5nLW3OVZ9GgF/tYplZYsPvoWIzMUg1V2/Lp1yZtV07TD83EZwb5gFZIjhBzeKE9WgNCI19WbK1eR/dXZRpGyjMFeMJuNyekUuf+RNT3r5w47WqFzvlouYwRWnff9dfbGUTLQeJS4hDYWPtLgIDbWzY1NYgvP1TM5cCkGsHKQSljnAetjUwwAkqGEt0bOvVZ6UpLl7at0+QmAUYGbR/7UyF+21UHvRpQaS/EF+En4wDsUlIJ9TzapCvz93Vr2eJPFm0xopAc2HfSPNi9VMaftolAUPyQFmQhWNcM615CmEWTFBNbvLCkd6YisBtN4HYg+XybJpwJws/bpAQOa+k+Yl4FkhdX3PkdiTmmvh2PINNWlpN6syRNvQPvBX/KUCnLy9nmV+EPkea6fQp6XOZwCm8MfnwoREaNdMHO3p0/rB+U+K4Nj9D5JDDfpyDILwT3l8AoieDN8nums/MLtT+46u8uhn+tfQngCFHVPA6jrhe3+OtTzHF67w30POtH9iEy1BTL4fd5pP5WiIU5dZkemrtpdd+rKG0JF/+DddU0yGxXdA1C3ePQtfvKqMR75ySOQCaqniN/LgPPe8K9xA8PkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199018)(26005)(6506007)(6512007)(6486002)(6666004)(86362001)(558084003)(38100700002)(186003)(41300700001)(66946007)(66556008)(66476007)(6916009)(8676002)(4326008)(2906002)(8936002)(5660300002)(478600001)(36916002)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0u2b34DOgTzZWf0Yg5ZcLV1Xo7x4czOUdcXbRq7I5qMKr97aTGvWX2ozzgVd?=
 =?us-ascii?Q?jyzREuk6Q6gJY5X/ZqdVs8z7TqqteTU59MOaxKqwJs3dIBBBQhNJgwJx0bpP?=
 =?us-ascii?Q?66uH4BgLC6LR/5bJqX6FZmSMEIXNtrw1TY8tsrm1vxbCX1GzbzhgjEbCAG7t?=
 =?us-ascii?Q?wfDjQdudWlVxiardlOvEg1kKbkHvGgv8fQWjd2eZHRqRxyh8pjGnuBY1lV+k?=
 =?us-ascii?Q?+qd9GBdK1q90DL9Ees3kyu86bWdqIJcX76GAT9VVkomiVMfdjM8BluKwvHYp?=
 =?us-ascii?Q?tQdMFjl5bja2h1W8mHYLe+mEWpleEMF4DXsRR4y86iWQNHcUJJ5CZkpImKvb?=
 =?us-ascii?Q?VKVK5ZvALjcRXkOw9SCAaDSAuFzaKUQZqpDMZVLydeqM9JPaBq7zyz9gfu7n?=
 =?us-ascii?Q?LC5Hd96BWEaJ1Jj/NB5SP0RGnOvCtu4kHfy5HDTPP1D7+l1dP/BZkYUQeTYK?=
 =?us-ascii?Q?0e4nPEk7bs1wJNos6Bklklwc8LikOIL01ENgGW7iGQ65U6fXTrWxf5/G3N5U?=
 =?us-ascii?Q?RY8Ra6/LrkYZeZWV8JF1niXFgaPic6lCDPgYr7UEOgDCjGSmlQVNU0vuP8Jx?=
 =?us-ascii?Q?umrFfdyxIdrsF1ju/QIgHgmfDALBVWaEDXRmnKALSOFX+Xz6dPi5w7HIdDeY?=
 =?us-ascii?Q?i5yqyOwmd41lKVwj4tm/9sDLaZs/PeIM07DFpmaSU8Om7kl708mfpDQKBhrR?=
 =?us-ascii?Q?LZaHgUkvAv46gJnLjcvZpmKNGAGz+CNZVDa+aaZBwqshgzgx4+orhI12s7nH?=
 =?us-ascii?Q?miRl5BKLRZ5bb8IhsFPE2cYGPiN2S+17QvD/PK6I7MECrL/KLkMgdIaNiIcX?=
 =?us-ascii?Q?+dZKt2ZlnikFRej82qtmjQEhF3z+DYRDmfSa5wbBHDCjfEc7qQhSLJ+eS+UZ?=
 =?us-ascii?Q?sW1B9nEUqMwbszbUAeP37QYUGLIbdgAXrvAKnv/CiBeT+JCIHzCtf07W2een?=
 =?us-ascii?Q?xgVkOTpg5aA04RFRf7eZYPVwdPaLzB8trjj8DwZiLXdxkGbX5RDIGFsy2D+6?=
 =?us-ascii?Q?KnMBOV3C/V+zpHkSbvc1Bs9qfFiyrivj7KAEHQilAG25Mxbd96ZXyR+4E5iC?=
 =?us-ascii?Q?JcQLCKcsDeCQcCYAN/Ebeoqk7bzIlQBipqfGJWcPPqyb9dvK0EfOOZeWJ4cB?=
 =?us-ascii?Q?KHVBIISKfdbvW3YPek9ta9pRSBAyGhC2QdGEy+SebcdpwUh6C8Hx+HahriYK?=
 =?us-ascii?Q?Tg6d14l1kxKGS5c7EdNVnzDNKLwVH9ptxbkE/6mBNCeSfELay8tDm3JfpG7X?=
 =?us-ascii?Q?m9jULNv629QO2WiD8AqmnSyeyk1sv+qXBcrajqAv9qDQ+KaHGRvhNwkY1AxF?=
 =?us-ascii?Q?ZIpvV8rcf/mrYPglx/7OLJJnY+xa4IOJmvZ5PqIEKtwTTIb5ghIQ9WexAPzv?=
 =?us-ascii?Q?7MXmd03t+oKMfW8esvEpxfqMDsnnnSdUqXHRkIF8NBTG1+w47q006KcB2JTG?=
 =?us-ascii?Q?nql5/ufCdsWQ6jOUWT9895DDE7ZxSp2ln3dlbNmcGwKgJ/U6bxQaVgElKFfM?=
 =?us-ascii?Q?QJqjbx/1u7UkcOzX1UorI9RGdvNIun6sfj/dDv3uZQD6QHCTndzx8cia4HYI?=
 =?us-ascii?Q?z3LEijYdbTpjZp5SmHkYmgI/JPEK9UGBMdVMY7Klxvv2K6rSftPR4mQ2A6xK?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UYSwpk0POMPP7zpFXhsAOgWBHhvKf8nvVxOwUk1doNUuPgg599SQ2lsPkNUKXuBeBjzKBaOu2mBM7fn4Dxx65NWi9PHZHkB1PklPpVMSQtghUb4nxkcRoQ27a85/BEHtV7rqGBM4KoHYdkfPGA95y2F+HmoCEsTeIKH0Wp0zDahReuZJeYJ7OskAirSb4+QjSUR4LgQ1Z3QrJNOQPdu7/rQDTu9WP+Qaw5HXutC25qksySnDa/9GqW1E0RDgOa0BABeg0gdZIAFDJ8itbqWZrUzT/RdumaAMclBLTCENHTD+gGj1Rqszenr5ra7e1K2X4vyyLK/qS5pfUZCIVqOE4X2n0U7QHjrkRPhZmRDXcoEKPOegmuiTthAmBTIUWaPLQoa7V9QZ6s2kM+b1DZj6eLsuKy+UHhe8uUdzEtenxcMVb2dTIEielNf9+fkD9GkfB4sxDidZUhDTamAbrVIP+0/zONVeF6y2FqSkn6mFujlFtSr6vLXhvdj/koJtJVtGLs3NliXBDDxFC+CGRd3FXdF6gug7L8aZHJFr5awoX7zLLmTGkVoPjrJd9dKtIDKO9v01X1pn5mliP5te1e9XFlJhB1uK2gF3MAtNaPLDt3km+f8cBWSNS5lAuZcpONFuhutBKmzy1EbPtKSspyRGSEqT/LOOaZFtHzK6Nizlg9vtindrtDTBXgy242hzYftMK2qbQNb4yUQ9PTreaZqnUn0SSZppcONfLySHUINj73v4Ex3QA8kJyUo9TkKUN7IC2J1g/q62oflju0U4RKM/lBHfEVz3LuysDG36QyNzSHb93egm9vS+ZvNCk7MDON+YqTI153izb+CSZOf1+zNszEE52kUfi8KhrolQ+xXyNrc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73876d04-8b65-46f2-0fad-08db1eb88d50
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 03:03:39.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: np3fCxOXJ8MkgTVbpVqiASMXd6CxI51naESMdQBhSMEsxOmLP+SMouM2VRycscFwljMBZkO4YCf/HSFDVV8RToM1RMO4TI41eO6wjkoKSSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5749
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070025
X-Proofpoint-GUID: 5zG0sEe8CAsMPy9vOOd6HZwj0JHOLVIq
X-Proofpoint-ORIG-GUID: 5zG0sEe8CAsMPy9vOOd6HZwj0JHOLVIq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tetsuo,

> MPT_ADAPTER->sas_persist_task is no longer used since
> commit 3eb0822c6740 ("[SCSI] mpt fusion: Firmware event implementation
> using seperate WorkQueue").

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
