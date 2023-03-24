Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FFE6C8799
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjCXVoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjCXVoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:44:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107951554F;
        Fri, 24 Mar 2023 14:44:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OLf7vw025847;
        Fri, 24 Mar 2023 21:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=m/zfvn/lUIq0IQLf5a7tSUftzdZiGNaZsa+vUPRGS3E=;
 b=DpT/mJ0r6Bxcu0J2vGcp5f5kt7b9pYqVW49WO6t29FVzX7Oua2gopEg5rpl+nwH/TUAt
 NntGk7QzEQzQ4GxJxypkSk5HACPj1yE1FnopuMN4HneQ3aC93t0Qbyr9baJCYUE5inJ9
 IxT48wSTC2yjPntLLrNBr3abR7PfqDPv/UzajvOOi5Htm7MtjVaQKPUdqLw9Mx+RLjIy
 qRfdyyZRYTBaf4F7wGELVo7YqecnwoinYNya0ZmncoSFqHGVQqnPXNlEpc5gT4kK6F9F
 0xmQkjnHP5+LFNMdoSHNXPP/tEb7LsFvCfhz2sYabJF+WbXz7BdchnHGetqLEwsZkLSX rw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3phkw1g0j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 21:43:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32OKB91H001293;
        Fri, 24 Mar 2023 21:43:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxk4j12s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 21:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EO4neKNbUYjMyf0HUUDhMEBYm289fhwtSCOlyk/5XBLB3bq65KjBQa1TQBpWGg+adZaeXvp2ZqUaLPLrJHi/Oi5jbZ2ZLNiR9vqFyf/94fQQGW5o5w80VhUoai/6Lep3JxwZ56jbvIesc4L3rg6qqRyPq4/OK+9DTIu6J7YwMFHh85LC+l9vmwczKOzGssVNkBGyCh2GjuOcsQi1/6zpshu90hqS7fLUZp2h0s029rNo0y1Yrs9R0s2TSBMnOk/kK8VyGMoFN5CthVk20KTcaHWo739lVxdzSEMK0bt3YTJcPW9etMLFcbP+//d9WQOZ3aHjVxV9wfZKxCI8/c8c+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/zfvn/lUIq0IQLf5a7tSUftzdZiGNaZsa+vUPRGS3E=;
 b=CDrDLFqnbsaDk1h0KD//SWZweXJqtwKa2WgR4x56y6QxJfxnxvNwuULh5tWw2CmAI/W9wXeE1idUYnkdCn4RUSB1+iX+03G9lznIzj237JXQej4L0EzFNRampjvAV+0vG+Ddcl3q6uL1NvtGDIlNXrjQi49snNxqHBIRiRQwTEBh6ZQZi2WELGOmFsF9wceeyS7qGOIJ30E9oT2VAmPhB3ShqJ6Mtm9Xu+3CC+A/fXFPpsJo4hfwJZPzdiVcTntRwm6gU+h9He7Kzal/8tFbibmvoF4CwdMg6fV8+myiDRjJkEUjhaJHp64GINIt73FPRUp2kSfq/WA+Nwr3wh8veA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/zfvn/lUIq0IQLf5a7tSUftzdZiGNaZsa+vUPRGS3E=;
 b=H/rG2aNycse1pbgDRSy/P580hvyXEJlrSuisGoxFy2+eoI1twZtc+z8fNnGGRkKhrszXcnWLYgBq0KPy6lqehEDVXus/EjbLo/gXvNtxlXIJ9HkBtdG44gfrQVWEcdUqYQv4jAqCNMuYabsAoM/GvSfb8HzLAF/+fZxU9cH9nBM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB7213.namprd10.prod.outlook.com (2603:10b6:208:3f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 21:43:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 21:43:48 +0000
To:     Lizhe <sensor1010@163.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] scsi: scsi_debug: Remove redundant driver match
 function
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8ipj055.fsf@ca-mkp.ca.oracle.com>
References: <20230319042732.278691-1-sensor1010@163.com>
Date:   Fri, 24 Mar 2023 17:43:41 -0400
In-Reply-To: <20230319042732.278691-1-sensor1010@163.com> (Lizhe's message of
        "Sun, 19 Mar 2023 12:27:32 +0800")
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0089.eurprd04.prod.outlook.com
 (2603:10a6:208:be::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: f8194030-356c-4cbc-16a0-08db2cb0d9ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/zARXpESIgSD49TCWXHC3IwlQaxH2Ml1Ju0abqL8pD5MrkFsPqGkmvqGUHOKdobl7WbMmtYerg+mRb09OLnGlfAdW7lc+ryXoiyShNei7rtj+hVQ3xMagCSyKGHuzA6OoCNbx3cnuHnaNwHY9k3s65cAaYRWGN85kOdDJVbICIBFzGPLMkD41WQMXnbPU2r9Ig125nxatHoFGlOVZNI4lX45z5zmYzlFiEaSw4zel5CQcHCnvVTCwQ/kaM6D9Eh5TSqQq4Zg8FWDxVyBQH0RMmCSM3KSv6kiM4XMSHoZ87U0y3DKRxJfB/8phIp+WPuNrhkWnIVqYJ0xWLfIQRCX4W6Wen08Ru+MC1JnnDWe0ZiSplXq9syVCW2u1eplLjXwBQfA7ZrpdB6Jz2bZgLLtpECyR1xVppTnLxrb+GXXOmwrjmTYLUQkbtxz6P4Z2Yb+9OCK+PnT8XO9mFJllpwNUEAlKVSdHPIGFI35qL5V2U+ZwlkmjmFf9lCILESjX05jtP2yHJEsu2/Jt7jcmMoZceMVRMn55LLPih4PhOY+6FqFSuBVCt6ww4/JcYKaGo7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(4744005)(8676002)(41300700001)(66556008)(2906002)(316002)(38100700002)(4326008)(5660300002)(66476007)(36916002)(66946007)(8936002)(6512007)(6506007)(86362001)(6916009)(6486002)(26005)(6666004)(478600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lU/AvONElKKsBHyTPJsKuzFBKtTOp0dP0bIf4o4q8hUIy8gXnQYzFYoj3lEv?=
 =?us-ascii?Q?+1C0kxnKdOSxc41i2ukBz83d66rt8qcOGMIK8R8TLO0xsXGRDTGRfLNLhdXT?=
 =?us-ascii?Q?ROxLFY144hX7nVZ2WSshLHD5F+rMecWzVX6fFsyr78mK9QCZ6mgD3bLmmyUF?=
 =?us-ascii?Q?wjxjeqRzSdDxL4uxSxGF7tIQpo1Nl9ocEUnRocDj1/oZa0RDrjURM4rRPLpc?=
 =?us-ascii?Q?AejKnDvegF3Nw/KkHYmUS4Jkgzur/7UmcO05QTcFHoQy20sMida9v44r7wQk?=
 =?us-ascii?Q?4tifnpWMTYqhJkNW7N8UCH5XfL8WWBXRrKi5Z4SHkTWn9vd3q/ecI9lp+Tsq?=
 =?us-ascii?Q?qUTFKRQle+/DNtkcs8x3UDOEgt1dhsuq2br/SQ/AmEd3y1ljrKJYnXUbQsmp?=
 =?us-ascii?Q?Pdw8V/g1E++dAutkutUTKePHJ4NZ0g2heGD8rv7UZvDyZZoXyHMhxQvO7hv6?=
 =?us-ascii?Q?SELLaUNXt+7JfpORijjE/CImPnRcFtF1kF+tyR0x+/4e/H8ckiXGWe1Y3xQM?=
 =?us-ascii?Q?IZIf31PVfPbvVwByh4IO52iqdqaSOX9PSICpVhe1eLCAbKHaIZyz61+RmJIS?=
 =?us-ascii?Q?KgPdzgglhksAyki1a20fkhQEG4z3pvFmrkW+9/0B1DXJKuKVakxjsqyE+g4W?=
 =?us-ascii?Q?Qv4l8EtxvNNdgfrIliURQFbfhUVuOeO2DMtrJN5M5c7OjjIuYQizFsO8oTgZ?=
 =?us-ascii?Q?o0uU/6RLDHlNKTuSQmrEelplqrisK+QJU70Nd46jEDLKMJ0GPm6nhwdQROW9?=
 =?us-ascii?Q?p+1bOLDcqR1zXcEGc4jMSI3i3Y3R4fMQcJDbKFe+0TCoQNhCTYMpb4EU+z1b?=
 =?us-ascii?Q?xzSg0TsUdsXpk41WAzTXNC3SYAD+UPjQUjlFDEwxrdtT8oGnxuIruQnsh69P?=
 =?us-ascii?Q?Q/AmJe5+oetSrY+opGgxXWyVaE6lwCh5lSv0f7pRxKr1miSBku+3px9TsiLM?=
 =?us-ascii?Q?vigrILxzzF0W4VC7dorphFcehO5SD2A+sk1jcI5Eo5CfJy8LB92pHLOX2B2o?=
 =?us-ascii?Q?JAIgDylYWqNd0oZTnZGTxWJfHee0cDS8+8aq1nFZ17kcajOgxKZ51PTi0afF?=
 =?us-ascii?Q?e4i2GbHd2279M1ZwABEg70pxcwCijOYur6tmhyLtOzHRdoa2hi+P1o6WcSZH?=
 =?us-ascii?Q?sTXf8MHNWxTe9FSCLcJmCxrV7KVeAuQW7+4Uv0mx2so49T+FtpgL3dA9BwHL?=
 =?us-ascii?Q?wVWrMXfuRDO1YTiUWCBWGnduAMZLUa4c6QDwwJ/mlZ+uLaOo9Mie17G6rJEm?=
 =?us-ascii?Q?rC0mxEYc202Dn3QZl7aNU4wkJEjektwex5juG4XMq8zWKfhQmMoAD9W99XMs?=
 =?us-ascii?Q?V/qjibh632y5mz4pooFehHJGg6fFIMf9VqdzolVnTo6mc+v0ADFPNvuXbquY?=
 =?us-ascii?Q?AC09jW++Bl8DiwmkRftgejMjo/lEsVzf+VdYkheNrr+toQbEtRCm10j/7Qtn?=
 =?us-ascii?Q?Zg9saADuMKSlv8ALt/7JNJxgLjMVN7o5A/MhgTGZuQF+yqAFLMhLq06qYXlk?=
 =?us-ascii?Q?nREJ8W++1kGXfkCnOb23RWZGujALx2nKXeKrYqLZOleLdYaaC27EZ50hcrk/?=
 =?us-ascii?Q?jeOVegTbvqv7P6cewU6+OpkYzwxmQ8315J35qS1mGAu8q2GDIOxlpTIuLDY3?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yTPFuA3RJwZrIUlARMowvWn9E4wnvPNTbP0UWf15+fRTGEn+EIBmCZKEnbcOS2pFAIfHTvOUiXANjXBst5E8Lr+4sYezcOEqneA8j9KkDX504XI4I7kHz0cOrF5yGkaEBTPcbQdvoOPNzzdz4RGeboDwUA3P8DGlmpTzF5X5JwOFicv5azVRrL/RhZDv7gPWvduQYBNzxwBbRf0sUR3rxkNmgsdjKJH4nkTh8Am4jEtTKpquHz+twhbBIjaoVhv489G/0Wqv1gt9foTOJ8EB3+cZjeDhfpkwdhYPNIDX4pQkaJlXgtF76qT/vhrrRtPUrZm4rvmpzdg4l+xygd8rYgV6HiLMeU5Kd57bnpKomR0ETX1PbOpOJ3qtvRgS5XqMVpRjBFG0fQGZcohu+fa1QzKnuFADQfr1oHs7JVOv+H5+fn3iiFTFjk1XW7akZ4uTTePjIyEXZS6yQle/kTjiC1jVOWnHhDmQ/D2d7wOC49cd0N2yFMP23FKH2AwnH23yF65IC/AR1so1itt/ViN2+LtNSwN7soIPjd835mquIohbp1fXFYaOwkLZhgjIx4DqJFhyq0qG/Nbc8NBt6k4adgpW2ZOWp88MRIMa/kvz1KmXlJMYclQyANzjk63tzPywx5YLy7srYzpPRI2Msu8yOXfjl+LjxDxjNCUhIgXhiO9EbNKSQnu77qoJ+uUVgh6DMaeWm3ZNA4Tg5cIvtdfHhmimNim8TnHhd25cSLnUaWTVbi57wm7E3+Aw/Ms28DeOYvP65vndabXU5BIeskeE80Z9ojBdLGtqAOJZZ6rq/kN6ki+ycUztH/JuPaWZf6Jk
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8194030-356c-4cbc-16a0-08db2cb0d9ba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 21:43:48.3649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HL2+UsdaZOpoZ/bjozI8RVBGkS+0lnmfHUhEMvlD+m5UMXRCnFr2tbPB31g1hSelftJ3829o4gzpqdorLJ1TgPZlJ/UfYP9cU55K/mVy11o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=895 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240166
X-Proofpoint-ORIG-GUID: qPpzVKbMK-KrsdWTEyioNn0ppP8xCIpd
X-Proofpoint-GUID: qPpzVKbMK-KrsdWTEyioNn0ppP8xCIpd
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lizhe,

> If there is no driver match function, the driver core assumes that each
> candidate pair (driver, device) matches, see driver_match_device()
>
> Drop the pseudo_lld bus's match function that always returned 1 and so
> implements the same behaviour as when there is no match function.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
