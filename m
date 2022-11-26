Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BDA6392AC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiKZAVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKZAVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:21:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC8052165;
        Fri, 25 Nov 2022 16:21:43 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2APNQ4Am018651;
        Sat, 26 Nov 2022 00:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Y54jsD6eI+Vg9mFGC6RLRYINPV06wSTAehLy83pQj2E=;
 b=oeM4BWqjhd0ViSebK2UrqGI7bIN4iSN4A5/+Zvqa3pY8mXCnNYYnmDqQ3I0lMXhFzkEm
 ssb1qWgnNfmX4lwRhUITlrFkOxNpUXMIHgsnFNOpfacVlKa7IeUbgNT+Q3HX4Ntbet5K
 W34YkyTIQE1mjOC+y0TpuV1J6cqGf+Z9HKs0w913E8A3Imd3/gJErRWQK4i8ZNquDcnK
 RduQJkS//GDl58EJ8vhKLthpdQ7Ny1BNFfl/AEo+ZdPRPEPSWGMAGJj0eu9N36fo31Lg
 M3iylo8SDZpRMkuEy8Gkl8Guz5LqmpZMLFa3YiKGgMUbCU2npw6iMzvefHrnzqzx7dHF xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1nd8dgww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 00:21:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2APNH2TT011410;
        Sat, 26 Nov 2022 00:21:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkgw88w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 00:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCxXy9qbRNd1A/g6IFzSDFCY4iDrDtTMaMPM9Sz2iERFyv9FniqDQaJkNBVGdJCw9fEu35+g3IEqle9aFo5fOfUGyJK7nY3PDw/QuafoinXBIqfBCfYU+2+m1sK6wgeLoZaB4lfOSFOe1l9RqupvrUuNUnk7KLnxPY55bwAhHttlamdzdr/W/KI+SPbGqjJpzF1JtTyfz99e7GL3UkLixBN7QJ+bh5XyFPRgY40FDqP+55Gk58gRHB3AFXtn6KRZkmh7hd8nuALYGUB01eSuF/YQQgAIaCooUUZJQOpuLiT6ax8Kctg0aPtsqp2CuKSTQQ1I6ZlXPBs2X+qMYfw0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y54jsD6eI+Vg9mFGC6RLRYINPV06wSTAehLy83pQj2E=;
 b=SG+NAY8Sb7D5ARw6bTrKp1aiwzP9Iy/Hrcy0ewp1IrVdHBwBvb0YYYvUKnrmEKOtPvsUhCWHMev++YYKwqgJhd4zgUYwnXEHPjysQhD4GXJzV+c9zxszX9TmgyBxm4OzovZsWjgHL+Mvr/Z7OIUNnggTF956RndEbpTj2iWHhKaV0xXzZPCkuBpSOeE1T9RcSP2t9gy/+LS/0dJeZKjZ2fGpG6+iYk/7ExEuOEj2lv6fE2cvJrgNwNqlLLrzonAqc/7IC8WrYsH7BDlIb2sOA4TsHW0WUyTCw46nRCaZEJGY4j+bmvVWdrQ+dJ2C9DC/DSoyyoydamQejlYrfXWscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y54jsD6eI+Vg9mFGC6RLRYINPV06wSTAehLy83pQj2E=;
 b=E4mpMTFEA9+AKV/ffHH6tCGYKuJFOVo5bFKt/6dED8vOnxDy3IHo1/NYgUR4u924X+PXYvwLO4nQWJ5uUfW5h6rnBwvtD/UaPimuPXGoE1tngwyMV3wDYsbUgG6MlFN9rlfTiWhaq48ZVmGwiZbG66TaSlkPtVF64h3aAIg/468=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BL3PR10MB6164.namprd10.prod.outlook.com (2603:10b6:208:3bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Sat, 26 Nov
 2022 00:21:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 00:21:30 +0000
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <hare@suse.de>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <robert.w.love@intel.com>, <yi.zou@intel.com>,
        <James.Bottomley@suse.de>, <bprakash@broadcom.com>
Subject: Re: [PATCH] scsi: fcoe: Fix transport not deattached when
 fcoe_if_init() fails
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lenypnul.fsf@ca-mkp.ca.oracle.com>
References: <20221115092442.133088-1-chenzhongjin@huawei.com>
Date:   Fri, 25 Nov 2022 19:21:28 -0500
In-Reply-To: <20221115092442.133088-1-chenzhongjin@huawei.com> (Chen
        Zhongjin's message of "Tue, 15 Nov 2022 17:24:42 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:806:20::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BL3PR10MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb6705c-ac97-4a7c-1be3-08dacf442a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxRPZzQDtQbOYZYhyddJITWmqYkpz8TJtm5QT2EL/GgYjIPSpZREqrjbyuVz5YyAJGgasbU7XYNmk+t5e8cPjav+GP/NyFkKXCn+K0WuTbZsP7By78gFcPx1RAJkZgw+D6CSJ/yhn9Im10r5YQucZ5Bdt+xoplQZAHG5g4WkcbT5NmFlCzGjiqZIW1H4dFarjm4gyZ3EbOuy6rzUcLymO5vqSQ0Ah7DQQx0uEaZMLOuhrK+JJsN/W1/WXrzx8oWThTodxcRjeacpXemLHhWLLFBLaVWzx4ddp4GAtjfbkAMLomvXMXr6Vys09Jc1iW2DWtxYli8Z5GMcmS/ckrRojzfFGOsWXZMbrUMLMBdobLyUJmzFhnhiwO1P0Foa+RILdztfc4XfFp99SElZwd5YylYIUCoi7kgKH1PJ6hlZq/UkdTxrsJUYTstP2LWhDVTYtkdNYGVs6i6XKH6IR+8zJCoVJgmXMeBy0+bhjgS/JuBj6v5GlFNj+HDBPSGfdp8BE7c8dAAZDij7QfsUwgPEf4FzIQ9BrBOgegD6wLrs8q6lRCuBEVcTBd2S8enHS30ajk89k1wvrgQKKH9abQKCXZ8D8Gko+I+vNVLFijdBWS02ZG7ct7sT4GJ/7iEz6+6YrooEzLx3mDWWYC1xN/E7uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199015)(86362001)(6506007)(6916009)(6486002)(36916002)(54906003)(6512007)(186003)(4744005)(5660300002)(26005)(478600001)(66556008)(316002)(2906002)(8676002)(41300700001)(8936002)(66946007)(66476007)(4326008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D6JSWjjCp1hQ0sU5p/xVRpXI1XiY11nS5SblZq700bu8QInkuxfp/yXCcmGz?=
 =?us-ascii?Q?b2/Vm7Dt5KFDzyzx6dgnxTMz3OnEu4HPtjUAA0V361llwWo45UNnkakH15vP?=
 =?us-ascii?Q?bC514+TvRNsOPzQsc1qbXdl288BjVYJuT8RXKvPA9/X04x9vEc52NbXcxWou?=
 =?us-ascii?Q?Ej3zrk6sJS3AsnZr1doN4yiWVEbf9I+zJLSOT5E8VHllmudiGpLF60/BU5mi?=
 =?us-ascii?Q?Fy2akv20zxXEchNEmRaDViOglP3xFlNu4VMoy3CVPsmvQMKoIKJCRtyVqd3e?=
 =?us-ascii?Q?ZYtzwgczMcO81RBhgl+8NtAVg4eT6BJl4R5VwvOP7jXov26LGB0JnKInRWCK?=
 =?us-ascii?Q?UmVocPsX0V+OkI2bfV3XNYBrRFeOvScCqkICMohe1/F9TpxDhPobs6ur+jNZ?=
 =?us-ascii?Q?Lou9ge9kgTS7eCRth5vDZE5CCUvqmJAXFIlIyfwJ9w+ReA/D9w6XEfoQlVqC?=
 =?us-ascii?Q?hooZFbKaqcF0JF/EG2yka7KJxvX/id9fXxEFF5N5fkxyZj1Uj6uxNuy21Qs7?=
 =?us-ascii?Q?9584wXnnEAaPb2ztJCoaULiAsZeBIRfv6MKxOgJyCw8aNNerFVTmSDGthpj3?=
 =?us-ascii?Q?+E92IVcBFXWyU73YyGxb7alP6Z6YKvophA0p2GPvy+2QeoiWMFHqBJY7jPzG?=
 =?us-ascii?Q?X6w46RfoN+d+Y3J4oBjFc7r7vILWYdyaTXoOpulC6mSMxslerHziA3YJBNfU?=
 =?us-ascii?Q?G77f/ZVnfDy5jpSKMByAVHD8CUDDSu4IFnwwhgPIch2GiJ6wk9XvD/bNGEk8?=
 =?us-ascii?Q?Q5B9F3zl1ik6jkQXFB+cU2ATB/ikiRg6sM/0Tyyi17g0c8rileHj4SB53/5v?=
 =?us-ascii?Q?B55A4BFYgeZMDGrM0hRP9lKxd2U41Nxx1eqytSJB3x0K3RWUspW0si8fBG21?=
 =?us-ascii?Q?CmUvIVRFFaMoBnbw6uQKBTGhucTCLR5CEXw7vagiiIsfGXELusRwzGgkZWh8?=
 =?us-ascii?Q?5RSAognY/2mP1GVRjvP3R7xvWUxxR+eO6+UusXk2LycrqsFA4oJLy5R/BuWX?=
 =?us-ascii?Q?YPxevNoUfBVEnnxCq3T7B8VpIWfF8p22h+iVMs7K3FtuAi8xvV/1HdgMmXQt?=
 =?us-ascii?Q?3/3BlF4vProGivrIHu+UamREkSaNtEfIM8q3+ukgkaSH6xwtEoqiz15xboHL?=
 =?us-ascii?Q?lW7XbqLK2g9hVugJyCnVdRXBvT32G4E2go2AQZiabMudnfMYS7J+g8BeQ/DJ?=
 =?us-ascii?Q?BbIhBzhmHtBQi1xEA58K8HnhHhXix54nXTxS8hClm4U89PtH7+nzz+MnPPf4?=
 =?us-ascii?Q?tlZsdRKa8p+0KMJiAjCHB0b1Zvq86k9BGDHk1HrfamTJP8sMzlh840AUtTDe?=
 =?us-ascii?Q?EC9zDDyMQrRvY8Hz3pSB1L3JrApsMRq4XMw6U91mnwNsntHGtVhct80dKeKb?=
 =?us-ascii?Q?I8Y1xvVmf+12IIeUhwiywkCHLXtx585YVF9N1q9ZAQC7UqEeFPZJp79QoEaV?=
 =?us-ascii?Q?j1AYuop5NR4gWlG4VTDfJbLMdwDuOGaDGzyCtyJQiyMh530EQRTCp9cvaTYB?=
 =?us-ascii?Q?O/v3Bv30G9NgBS+iPLJroIpKZ3eoyJmfaGOomkH5jyrqdbwV2LXQ8rtB+ak6?=
 =?us-ascii?Q?OzwgTi9HR/e2m3+ESonBCmkjSPPXhECRo+n176/4N9xAXHyanO/GA7s6D7Jh?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?A349/42ORzAU+BZoDvtsmvOQONyJhNtprcejz5fjZDI2PuAM8z9xh8+1KOtU?=
 =?us-ascii?Q?plaO0hMoGOgEkexTFZXLtjfhmQmhbkak1bes5lGoIsnXa4aCngs8fb0XK6xP?=
 =?us-ascii?Q?ZcUctV8o9kFMERhZYo7PzL/l+fd8SFdlTdVOtuUCODW7w/Iw0uq0IMnhCuoU?=
 =?us-ascii?Q?VqpQ5bEC8/5H6ppVgDByCdWlO0bJaKaRI8vKP+IBw1ffDMSl/Toeb4g08bsW?=
 =?us-ascii?Q?uFG06jR/tY+zLVD4OtSbDBywuEqoV032MHUn2/mbZh9Jpat0gBxWOYPA4+TJ?=
 =?us-ascii?Q?2YswmBaT01oPfYIvZzf0PNK4xpMeZyV8knsYjScPf1NpQOGjWqutSEze0ota?=
 =?us-ascii?Q?9dDaBqmKx2k1CgqlUhAnCLkQXExV0/l7QqYkWMNLhucMBeHfda/654XqN93O?=
 =?us-ascii?Q?Ky+lCp/rbxClmjyiDxg7xzfcxH+dCqKkoEp2FWS+i2uDYWADcumQk9DkifSq?=
 =?us-ascii?Q?ijcVYmrrb9RvNT2iQMoAfFo9siV06FYE/6+DLDyDaGd8lHzAFX19xxUkVSX9?=
 =?us-ascii?Q?aS2TgLBWg2mOZbWq4Z6NAVLKkR/TjQgahX+FoP0bzWfPVnR5r9Sxv/TJ5Kpe?=
 =?us-ascii?Q?6HMZMl741LdabD4iAzd3SFDV52maSpOlgSyQXgo0HCkBHkTrk9MaTedBLBjN?=
 =?us-ascii?Q?wj5V52rGkN9jyQ6ujz6XpivlLmx3qujC7iQtzCM7ktOfk0Hij3hb+2Qy6jUu?=
 =?us-ascii?Q?yOvfHFG4u1Wls+BZOVO9jdzf76LT756YrAQMfW+q9AumJGR/H3VccbzBq0pB?=
 =?us-ascii?Q?TGEwshRl0mMPeCPlacNGhXNvBT+G4LP5kYT+ALRscQKAOX0EyEZ1cR6kRyiz?=
 =?us-ascii?Q?F/0soOCBaxrJ3zSEEU9ymIbatjsLCspGRA3FfehFiYnJ3GafIFQBFCihrIxu?=
 =?us-ascii?Q?/7S1y2AGVcosG8Xwh6uVCa9mcZ87bhHNbZ7OGgaRGn9rqn9ICyNrcPRe2dBd?=
 =?us-ascii?Q?b6SBtsc/d5pqwCQy7vT3BCs/6B0rx7s8od2tLs38K7Y0htF6rXtRi8joBgVR?=
 =?us-ascii?Q?8jxN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb6705c-ac97-4a7c-1be3-08dacf442a4c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 00:21:30.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwJpCHqbflNHQVki2pGTG29azx3YWq4Rq+Uy5UgogaOAkAyRBPwMT/71feExj81l6Gafjz1Xm7DDBhGF4eJe3wMtwH1Eg4pmX6kliUq+6Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_12,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211260000
X-Proofpoint-GUID: ZoyKDTlhMtkqzDc5cz92YlRNGv5RrcD9
X-Proofpoint-ORIG-GUID: ZoyKDTlhMtkqzDc5cz92YlRNGv5RrcD9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chen,

> fcoe_init() calls fcoe_transport_attach(&fcoe_sw_transport), but when
> fcoe_if_init() fails, &fcoe_sw_transport is not detached and leave freed
> &fcoe_sw_transport on list fcoe_transports, which causes panic when
> reinserting module.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
