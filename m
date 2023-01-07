Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CB4660E6D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 12:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjAGLuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 06:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjAGLul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 06:50:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8346E271BB;
        Sat,  7 Jan 2023 03:50:40 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3079KnLR021610;
        Sat, 7 Jan 2023 11:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=rBmCydcnAgVKTHY0qRTmTfb99FluPkybj7uwhwyGFtc=;
 b=h3lSJY8yEFb42qkgoGm+GP0ky1EruKtRUDHL2g0L2o7ASUxCnAc8yeL2fRJCtv9mWEsd
 lj6QrpcncVwLqs6RUaRPcTANX8QlxuGfwCGW0J08/eUYLetKA1eTChxqb8IPCj1WJFOj
 KmydwyhMplJ07qxEw+gz/Jf31WytlX1Gd7/jsrDL4J6CL0NnYiEl3mwS589FZTBKauLV
 Aj6n/fA2WYtHyiMjnr9Oxg+RVU0fuPodF41unKg/JmsjvIuacsjUrHV1/WQBswp5MxL3
 5hennr7T0pTyjWO59LzSfQaO5eYL25Rxl9orYEHsjadeTDQOqxHzeepiAw81mYm4edW9 Ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mxyb18d1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 11:50:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 307B5mEs017969;
        Sat, 7 Jan 2023 11:50:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy62b24e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 11:50:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjRTT+5ThAu2TN5d+M6h/XmwQqH6i4nVr4HMTXxlCoxWfRQHNHggeS5s0lcN/be1ADWvtRlcCQBEdTVvp0bjSA4kToR7FUIrrp/HaGJfsE/XMdhauBTmcdwkPKW/oO9TRO03bKxf13GYBmTa4A5f3M1eXqWvzqwoklG7BmDR19Q2sZwL48OshcgoaHk1Xozo74Q8Kx8Y9q/A3liCpuO8LnFyIu3f68Ghwemok869vNH/m56Qa/akKCIEwWFFlN/+cJMLZxxV0/BTaXlkqkNEqWfC5KzRgXbhCpehLsEBz50f22/yk/hI2+A7kogU/Q2jH4kS/OT1c41PaYWFLsKhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBmCydcnAgVKTHY0qRTmTfb99FluPkybj7uwhwyGFtc=;
 b=aZvDXbhBbYQKGB0pOXMdXCKrZqvFiktfClQUe3M4KKG7strT09pB8Quem+CO5f6vYBaWUlnU0YYDmbklaG3tFPS2k68OStZyWPf7inujVlYU6ct0KFLCSzWNLcqZKlFDrfUjCj8gKb67NNFjzXX+HrEiViOXCodT4AzYkbq2a3i18q4P9+skosoJha2TgjeLq3B7K2CcfTWz8TbRtxQiT8P9CorgUnyzg0D9s+ZShAgAuG2fQTOSLuq/+mPFgkhinDvr6slQN0N8C3YRHxUVWiyHhvr+kZTcjK4LOT6J5kROlxqdSnNwTEEMVjJklke/NxYvkwakRuUPNeV0o/wHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBmCydcnAgVKTHY0qRTmTfb99FluPkybj7uwhwyGFtc=;
 b=q1wy5dPXH0lnPHoYaszUvST+ng28kJCO0tBaploB0Kok7ZtSn1pFS00LIzaPpDUBhFf3V4N8YxVAliOKBh52H8iUXH9iG7RtnarmMLsMERCqBamq/Uiqhpne1JKaLCqUk2Dj9hnlaC2lFvV0wYRV1tT5A8rzZytwd5znxVrPBro=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by CY8PR10MB7339.namprd10.prod.outlook.com (2603:10b6:930:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sat, 7 Jan
 2023 11:50:21 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::c594:e48f:b26d:f0a]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::c594:e48f:b26d:f0a%8]) with mapi id 15.20.5944.019; Sat, 7 Jan 2023
 11:50:21 +0000
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] SCSI fixes for 6.1-rc2
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6x2zj3f.fsf@ca-mkp.ca.oracle.com>
References: <f0bc7090c04bc6c0b08471494324a3a577c2d2a1.camel@HansenPartnership.com>
        <20230107182826.1ae7b32c@canb.auug.org.au>
Date:   Sat, 07 Jan 2023 06:50:18 -0500
In-Reply-To: <20230107182826.1ae7b32c@canb.auug.org.au> (Stephen Rothwell's
        message of "Sat, 7 Jan 2023 18:28:26 +1100")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::30) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|CY8PR10MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 031d6a69-1fe2-4b23-8591-08daf0a55ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xr/MPg6EP8vu9+q6by1TaM7aVQ5v/XQJ0wO5RUSgzX2kNr6fNZPCXOBtBRnJzCaODw7MLa21NBXR9fpGuIcVG2GEjGUHM2X4r+gao9bvjxVCKJn66YOXIkHFt0xdKMjTruKm5s5m/2YADJNFb7VKMw+VTSnPoGkTBExWrxIH+ThwfniP4NEi3Mo91bHTS4nBLM+5ll/YGLCOTwS/EUsLbvABqjGHhtYO8slnMpfy1O7o7YlgA2zCcYYTd1etGQolauFgy64bER94JJ2Lxt6wNwEnUx+nyh3XNO1j4QTj/hXHms7jz+q+KmCYyRaB5DDlMzRKW92y4qmMty2KRAnb4IaRwU41BvyO+OkMvTOBiEeGUgc9SYYPOCLEFxWQ7IJdFPe2urXNOp6wvvY3aqle1DMNb+jDcfrqDO3CNsezTBO4CiKNMBOxWSlgQDnlxWZIBlkD9czj8U/K4WxA0R8jnAlO85HgeE9CdjKJ9IyVpQfQELfOu5xJfVS13iPE/V7aV4iwqgzqvSWONxW1+u0iRNCglvue0/Nl0fny3ITJbB3KOMRYMH54GGiX6w5w/74aTMEbGmciywwThYXLleatZ71caEm63HgKuVEooeLLnvbEEnZdQknSYFtDKnXfnCdYBvIk8nicdoVIBcX+LPCi7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199015)(5660300002)(8676002)(4326008)(316002)(66946007)(66476007)(66556008)(8936002)(54906003)(2906002)(6916009)(41300700001)(6666004)(6506007)(36916002)(6486002)(26005)(6512007)(478600001)(186003)(86362001)(83380400001)(38100700002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pV5d5WlEQUoiSMOh/W/wliB+5h9Xdm0p7Bi91nE+wag6Fh1ckG2MufrIPmN/?=
 =?us-ascii?Q?mEdrfG3CgYQ7/liWYQkW88p2D+OWd7bsKDhw8pBrvQ3v2eC3wK77yhQck2kc?=
 =?us-ascii?Q?RHu0S/kW1GfZ93ZDd7vt6f2b5xrKjZPL7Z4qdQ3oBp17dpF8XhvvRYjh3CLD?=
 =?us-ascii?Q?mS8ojNs4j8HlAZ1Vpk44issCZFTv5XabLwdZOoFmTMD9bvzt6xnKCeYxidmr?=
 =?us-ascii?Q?3sTJtbaAskI8Ezz1oHr7QbwgLUv9zg0lSYootXHouqvQqGKSt2nHMj16LDMY?=
 =?us-ascii?Q?CHW+n+AqW4BCHSSLZFlE5Jml4oNSs+rqD5UoFKS6acYYdqKXCh9SCG4Z2dJM?=
 =?us-ascii?Q?DMIbIlLz5ilbQpz1sNRaBiHbMBXBnQKhCkJt082fQ5Gkb7tr9ZBbPSYsHkwG?=
 =?us-ascii?Q?AUKfkkrk8Gjh+iolTYgFDlJUqN66OCy+NuZOxtf17dNoPJD4oJk6DTflymXN?=
 =?us-ascii?Q?smh+Pa4n7AgsXK5G8o3DAtfRjVjbUsr0uwncR7MFBNM5jb+1r1Kcl6Usr4aU?=
 =?us-ascii?Q?Fte3ZZ3O4S4m8PPbp7se0JjgT8UMIJYoGk1AT2ZZhS46ocuS0Al+dEkIcp+d?=
 =?us-ascii?Q?fpRC4K+eNsvQSDMBwcg9TD8AH8IaXxHsGIpTjXXEkf9/XaT6mcTVHF3VAuhr?=
 =?us-ascii?Q?FCVnZWPcKohdOqqQ22coU0oHybukl+2pNWSaWIMa26deJoNKE5RC6IMSzPLg?=
 =?us-ascii?Q?I1QM5NV54yDmX5z37eOhIFFFSn2fXkye6RbZ8U0SV6x72ZAmjtDGP5rMav/r?=
 =?us-ascii?Q?c5AUO9A6dX0OZHsxahGcvK2UyWUOZWqHA07uzfb9tqRtIfRggnDrZwsztZ8f?=
 =?us-ascii?Q?loBvZWGZ1N4HP8bE/uPBxKC9++ubP9wDijx95lk2Xw72IZq4jef2shlmlN7e?=
 =?us-ascii?Q?nLACSXK1mb3uTXUmg1HKgOcZtTzUUI3/uw/m/nIXWz5YX5D93KMT9lJCnyqe?=
 =?us-ascii?Q?4vMfSXrOuAeJ0aZTF09K3J+RyiXezBuBu4n0SWVhtG1lh3YFhfBRHn0oXN3S?=
 =?us-ascii?Q?rQU9Xyl168m9Upx5jyagneKdoyOFOIdpd+xjhULIESH5tGfdmNH5aZ9yW1/K?=
 =?us-ascii?Q?Cot4mX7qpV0x2uou3rCM2DlRcy7/OJqcZ0BRtvG7MlDPph8Swg3Rwv17DbLN?=
 =?us-ascii?Q?ahWdvLwXRpn7jcXOwhbE7UEoOrTX6PmHKj/0cDCa3jw6ebp0h5i9t1etmK1d?=
 =?us-ascii?Q?EZvr+i1SytsZZyJozVMe2S4cVUffXH9I9unmlk/Cq90HEtJsOxDQYuFLdVan?=
 =?us-ascii?Q?CdEa5OR58SuikKoQbYyEOuLYxYNXaSbSMEpOVS04uM8jc6REsvYZdRarF7/h?=
 =?us-ascii?Q?thJTu7pZPC+cPv6jwmlUiYTbox7iVWloooGn5QIUW9iZ8N1YggLLuhA0XBF1?=
 =?us-ascii?Q?/WMiiriTzzmuTSBCj6eGrlH53LTpRIijvmV2prTJ9rjFlNvulCZjiesbk1u+?=
 =?us-ascii?Q?KRA/A1tmxofqrl9DP6yxLMzke7veIHpOdqgjAIjRNihnOcXZpS5/h8X1WM1K?=
 =?us-ascii?Q?2wSpxfXG+KmPnwh8xk/FBtKT2a07um/C/LL9FImcj4fgjcxALrhb0EB9W75C?=
 =?us-ascii?Q?r8MAwnPndXOIRHyRk6hp3UY7w/pJHKQ29utwLcZLZX/YpJHrLgB6Co3qQLIG?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PoQSEbOBWhg6iw8S3bzxXekTOLilV4Tmm9gyfSW8aNzLnRoSP6wYjyXhqhvv?=
 =?us-ascii?Q?EhCK+jLJ5+ZUpx94kHat1Ug5uhMiCFnTczEMxlbTb96WArNf6/qC/HKkRfgr?=
 =?us-ascii?Q?Ski37eXGx6y34+Kd6kVx7vh+lBSZ9GLfhW+AB4vH3WzoDiMZKYV/RGBdj1x2?=
 =?us-ascii?Q?6kOX2qkB6wh4KLhRiWjBxwA1ondGSmxBP0JUr3jD2SyR+zY5pT2gZrxadWq1?=
 =?us-ascii?Q?dPVa3xe8NR12ltEW9xyL5DmY7FrvKT3HI9AvJbZG4jwGADLSrsLS5oNeO3zd?=
 =?us-ascii?Q?f1LRpDR4VUTApfLA8gylEF0AKHtl0DFApdKdqNNlc8Jqia2hBJL9J2qoLRJ2?=
 =?us-ascii?Q?WggN+czWYr1GhDjhhufoD22BClw7r9jIMIbWiL5QQLXiOtC2P0T7RNMbwOA+?=
 =?us-ascii?Q?3naR03wRhjiWis/IpQbcJ4ApfYuBH1zl8ZfjYqlK6Kr/ylcogSgD29k4y0Bq?=
 =?us-ascii?Q?UpTbkfXPO8iIe80q7P+8buUFPkO9I7vimK6fDdfMo2JiezjAoYgXUmu5Rj70?=
 =?us-ascii?Q?vyB/LivHllq1NQ4YDsxcdb9BImvrExMtIrzr2yU4/kj6eXhEdugn7thLlvfS?=
 =?us-ascii?Q?jegFlt+VlIFvkxx1D+d2ElKuqSXP/tfVQ/dDUAIezMqfB3abBuUa65GBZjJk?=
 =?us-ascii?Q?ni8NGQSmRRvrVqAVTf1j2FYoyrOy35vrCwy1o1evtiy9NT/Dyd61y1MKA/DF?=
 =?us-ascii?Q?GSuOeShIMxbGfFxU9MprtEaKgppQjkDCxJyHbpv3W64i3n5iXoNIsD9+53vX?=
 =?us-ascii?Q?R1/upvZP0GLUlrUksJi8k0dQIFxLZQsoW0Yj0NPtZdAvVXC9qvCZMGRIwqE7?=
 =?us-ascii?Q?K23EwSByH2hGc65OjKYTIfLCLbYfojgmKNuA/OxOdAFoOmJj7uwtsa6u7Vi0?=
 =?us-ascii?Q?chEVaAwMKLAiqMvHGKE8Yuy21TAv5KGLPLBZB5uWi9gEtZ86FO1YBKUYsE/E?=
 =?us-ascii?Q?nLTp0qCbWophXgU8EEsnkVGKsmDH9WFDB3fa3VBJITGVfLX9xPcbhA9b/PIN?=
 =?us-ascii?Q?3g003UhBM85bgyd6OiBt7WR7QvA763feXvCnev1Ox9Qaqz8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031d6a69-1fe2-4b23-8591-08daf0a55ab1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2023 11:50:21.0543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97HQK92SWrggd7LhnrMWrZLWJvhjmnSCO4DrEz2DgZiuo1X1dVyMVc5zoNTszWZJGkWEJpJZgaRicIFAKyku0XgFHIkh66Ij2Bnzhe8kETk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-07_04,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301070093
X-Proofpoint-ORIG-GUID: eK_wJanl0ntz-boDoYUswIcHAVrEgkNP
X-Proofpoint-GUID: eK_wJanl0ntz-boDoYUswIcHAVrEgkNP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen,

> I thought that this one was to be removed as the pktcdvd drivers
> removal is being reverted in the block tree in linux-next (and the
> revert caused a build failure in linux-next due to this scsi commit).

Yep, my bad. Got sidetracked debugging a few unrelated issues yesterday
and didn't get to the point where I finish up and push my trees out.

I have dropped the offending commit and pushed 6.2/scsi-fixes
separately.

-- 
Martin K. Petersen	Oracle Linux Engineering
