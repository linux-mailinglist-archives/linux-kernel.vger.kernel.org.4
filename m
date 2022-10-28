Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05786114C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJ1OjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiJ1Oil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:38:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131E01EEF1E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:37:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBNtvU003779;
        Fri, 28 Oct 2022 14:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QoaQPJ+yxXPdouU8jppRR9DbDYXd/9UkcnVg0c4cnpc=;
 b=QvlJewJdjDZqqoLv9tqWQA2nNqttboqi+j9ahchqb/tRB5tAGZtizVfcq9RhYELubZ47
 h105J4tyVGPG3SgaaCIIVUx/5/WxNKgDq9myR9bvZFTZE6CIoH7GOY3uZbHPIaXI8XOz
 sNSnEkMJjdAe5DdRNYj/hR/++ciYq2JsVHsFH/Wnu2zdTSYy9cqyOqGN5WSfN5dzPDjT
 0PsLce+zoQE4ZB8Zd1TkeyAoQ+6kuXECC9Yhr3am0yMTO30KiS1Ps9P/59tdH8iHYRQp
 GCTeXKX+oIXxQzZxMVCB2An8PzlSDSVOgFin81HIwUlxLvjfkFnIX5urtzkYS8/bPDTP 6A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfb0an57e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:37:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SDUqCr006502;
        Fri, 28 Oct 2022 14:37:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagj46q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:37:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmhktd5L1x5OX2HvXZ7GTgz8HoicpR+6gNkHy8G+x3FU84RhfILaOEew7TnkhcZDFc1Q6/uVdoR0NWhlHmg/D0XLXQNglvukUclhLFAruxDyxbyzxdY1YHSZ92W7wmyGl0MwQWEeoTxxr33O/I5MlmDV9eKQ6std23nKGLHTc5mCByge6H4/KGPwtvolPj99/u4gZa3HYu3DRcYyM4RJwAbJB7/ahiIrU/RpEl76SvVf4nj5X0BRABGxalj8hjeZT4b/DitnPLP/+QXWndQxXJHlcmBE6gk3TRL79JuZmCjwf/P4K7R/8eLmsKHLXoVY1bx1HV19L10x7wDBGv9E6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoaQPJ+yxXPdouU8jppRR9DbDYXd/9UkcnVg0c4cnpc=;
 b=bjj2eOUzsNNiJZts+k9DCLOESVbwce6LSmjDC+wvrTBQeUk9YH96m1cDT/yLaPLYIMJ1v8vMfaYKQB2cdMr0n95RxEo8lCb5/LHI2129v6Zx43XVPwCFfyQCFCF9rqC1m+ALDqZQ4WNd9+URWsjiG67wgDbXN81+ZVud+yCDzfDUAyjkzIJWM9AfFJXrUZRk1IwkvEuIUPi45dRCpe/hBQOQAZKaI5QxVMitqjsMkFP9jpzu3YtbJdILbK4FamoXL5o/9rb0cpJgZ4vCdhSxVv8ATFhba+A6ueFIuqcqBgeTLO3gcVN/1wv+8OA8pSHj6gqUXGO3JQ/mR6XmQBPm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoaQPJ+yxXPdouU8jppRR9DbDYXd/9UkcnVg0c4cnpc=;
 b=GrGjeq2WM/f4cert+FvUbdpTy1iyC8hVXhcOVTdUQFq9qU2a3UzUFy4CewicI/CuvIHuIn6CF9hVfyqZhp/4IXiKWqZhlrv7dv5skMF6K4N1G2vdhFnoothW55RKhzRqkYYJUtCkpOr7hvWj9CWxSuYTIROatvhocOQ9gTxwPGg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5014.namprd10.prod.outlook.com (2603:10b6:408:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 14:37:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 14:37:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Li Zetao <lizetao1@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "cmllamas@google.com" <cmllamas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v2] mm/mmap: Fix memory leak in mmap_region()
Thread-Topic: [PATCH v2] mm/mmap: Fix memory leak in mmap_region()
Thread-Index: AQHY6plVbpPXZKIO4UK8w42gtZfMYa4j4GeA
Date:   Fri, 28 Oct 2022 14:37:40 +0000
Message-ID: <20221028143727.boymlu6n7gx7kdda@revolver>
References: <20221027073029.dyo2p2kearlutizq@revolver>
 <20221028073717.1179380-1-lizetao1@huawei.com>
In-Reply-To: <20221028073717.1179380-1-lizetao1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BN0PR10MB5014:EE_
x-ms-office365-filtering-correlation-id: 38836ddc-23f3-4b8a-a3d3-08dab8f1f7bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZzZe26Pu4fV7KpoN9dAUb8qpw63QP/9NMwlcnLtyISGYOkaCprEtoMRZXTGKOs7nJ/lUcji9YZ3OsBp1RG+id8AmArez4jLgsibaAF7/szY0OS60DFy602k0iDOSgjHj/2YGf6Ja223g+t69PZ0mqnWopkIIiH23Z3M7AdbkgSRnBrp7g8MvGMwr6MP0cAppc06WribZGYAFUfS7Mwku57FiOpqyxtOziH3okSk7GI3OM7Yskile4cWR33uE+CWD3ntLhsBIwu+vLeuWo6OEK+In0Q+U0Dn1BgHVaI+7w2hCP8Tmf54MvvRaaxDtFuPdBLKTtlxUl3GaxWsJaoQ6yX3sG7lQAyietMgadPqFHqhOM3QMtmGnF8RvC66+O0LOsRj1ye5wiOK1DPWddu3o9KUf/rg549s04n2ciy0h4VIZRtjtAbDaoOWXTc2ym/eRhGyo2GQNGNIIid05onb/VjU8yMEUeWO4+ODH6tKpOav4AMqJ4jBtWampxVKVLDG0h+wwXcPK/X9lIw5vyNbhWwnY9ZSMXM3fPHfbec0MBbinpVjESPSlVGZrXbsAxQYAgiNKqSKa7O6q3vJ3ChgLbJMtNsyi3cT63WFDqjYpovC0h0b7wyKkJ0Q7IHLO4w5NIcMwU6lweKBHdkvZ9FDJFJn7DPS4LTlKSW7Oe+UAuS/96iYkbYMffDnyQsx09y23WhuDT7sR/WvP6cVAPNV+H9NbjegFNSbuC4sfLD7xqIqyjg7j+AzPZbZ877xUh+5fMkwasgkeMr/JnCYY/1EIo8iFrz59JPjYzYuWtRFYtCzrHm6uN6AeDtNyc34fk3x4Nhf/JcWHAV4CGTZAb31hgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(33716001)(316002)(6486002)(4326008)(44832011)(966005)(41300700001)(83380400001)(91956017)(66476007)(8676002)(76116006)(54906003)(66946007)(66446008)(8936002)(66556008)(38070700005)(5660300002)(6916009)(2906002)(71200400001)(6512007)(478600001)(186003)(1076003)(9686003)(64756008)(38100700002)(122000001)(86362001)(26005)(6506007)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?caly4yOQVQU6rvc3I6koEawMrcV2t5zW8yaFkyh0JVvTYrooDI1AojKd8VBq?=
 =?us-ascii?Q?010TOegiidL1f/OfcCNA5aad5vpEmXSbxhD5OrrFePr5uMV2tQlCZApgnepk?=
 =?us-ascii?Q?H4bAgWriVtLUCjgl77CrCvYZtpI9JdDcwRgdHx70H7cuE4p34TnzXYKdDyln?=
 =?us-ascii?Q?YUp2exrDoWoi7inW9AFlKCfhhH/qQ9nA3cul5o/neYn1PfauvW2XLaAmD48J?=
 =?us-ascii?Q?aLxP0TFy4gdaUn0H0vkEs0W5cQDRfwVDqVJeYRHLD4wFjNSWQIR59xhiOegE?=
 =?us-ascii?Q?2AHfSbFBELFPeL3TPJ5FtTb0JijOLOlDejXvZB0F6dWz0MC7lsTETLy0fd3W?=
 =?us-ascii?Q?X4Xky64ajxlLucyxBduK7o0v6nOYXR1sH+LHpQb1X/U22XmwSS0k+BH8DfYX?=
 =?us-ascii?Q?7EFn68AqJy2IPbesF393unfdnSZJaWGRen0ifjzKgLCEqDXgzUm0tHpzJvQU?=
 =?us-ascii?Q?Pf+mBjTfxBLX2WqjdGSXF/iR3KH9n30soBSj3nn34TIKC3n4QrlXWH6t2coX?=
 =?us-ascii?Q?lO2eGfpMa+/7thwXcvqzewBpk9wg8ZwQv9d0vkDbM3H5bhrfOLbLAihKHzDU?=
 =?us-ascii?Q?77q2oMh9idQhxmrRg7Ef6mUZHNmuTMN0EpcQImarekHPN1BmW1J+JAMbxJj3?=
 =?us-ascii?Q?WIrBH6xa8imskMokpSIBJDDg/FYYCUUEIkUp0VCKj5WuDUXMY79ZskyXfene?=
 =?us-ascii?Q?l9/8u7kIEArVEA4pzdSt9NmDHkbci3KKXQ9o+ZpewrktBFGD6QXmG4fZF+mv?=
 =?us-ascii?Q?KCBO051nvbuEc1wDJDYaQgqJJhspcIN7V8vp9Y+fWzCr84Rxz5kR/5EyLzre?=
 =?us-ascii?Q?D8+R4y0sRsw6tvyad/boMvaKc6che6MVdSBadGlpT6mYQ2YCWc6nFUTVL8dC?=
 =?us-ascii?Q?lIV+1aJsPE5Viul9rYQlxZOYtP/k4j2UV9XZjSEShak368ti+IWrEoNwZLV8?=
 =?us-ascii?Q?Til97ViZOu05GBVko0onUOMqlVgb9cFEVvJz4NhCNUPvpXIPipt0U+XxyY2c?=
 =?us-ascii?Q?MnH4v3NQdUy2Fgz/CJkExkcxKbtjlAZp9AimbX9pv5aIwFEuI1vBXuCAXYWZ?=
 =?us-ascii?Q?6A205o5XQmEhByAbvjZdbLtQhNthPPE60Q7YrP5ibs+yBe9a8G9ZmwLKQs5x?=
 =?us-ascii?Q?4H9Tv/GD1wFoffif3YOvQ4TvOtxSNqiO1jCxUaSlRvXY8dl5QcyOLOyydV3d?=
 =?us-ascii?Q?QpRqTBqL3DkgIY6uloz5N5nPAjpaflVziNyGFoiLeEN9ALdNyYSoyphMEtOa?=
 =?us-ascii?Q?cI08mRm5MGNF1m7k8j4H2ZpVZLapR9BtVEaZWKC3/JSaZK/6v8JWHPDxd+Pe?=
 =?us-ascii?Q?waspm/KaoLpEEmGWSDPpFKrxW9vzUSCtsAPtSu9nGbvFzWgrW0Ov/UNbdHNy?=
 =?us-ascii?Q?4CZ2THpb/T5RbgnIRaWExHbMhVJZ58O4mLq6a8pvtrjzBaaQRlsWjW86Xdyl?=
 =?us-ascii?Q?qlUwMEDl+AD2LR87aKIEGDzz85NEfD9NtTJyprKw10FPXZqX3oT6NDU1Mrin?=
 =?us-ascii?Q?xMDGrAw2+rLb20WBuygdbJQEji/F2wfGBDqK9Hj+dZ7G6yeyf10KzKRmAOtm?=
 =?us-ascii?Q?+1sPwk2qnGCPOkR6/1xP53RLR97QoW6S/ZygMOg1KJG8Y22hwO4FgggVsbFg?=
 =?us-ascii?Q?iQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F457F923482A9245B774060264B3E94E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38836ddc-23f3-4b8a-a3d3-08dab8f1f7bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 14:37:40.8751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wW0xai0FFFA0/ZbM0tAPAHxchFd/QxRseCTzyuqX67UYDFy50oHw1BUkiXZc/60bUo7T3DRa2HFs+0vPfeKG3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280090
X-Proofpoint-GUID: paDFW_4AoL182ZFgLAvQRGylH60WAmi9
X-Proofpoint-ORIG-GUID: paDFW_4AoL182ZFgLAvQRGylH60WAmi9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Li Zetao <lizetao1@huawei.com> [221028 02:48]:
> There is a memory leak reported by kmemleak:
>=20
>   unreferenced object 0xffff88817231ce40 (size 224):
>     comm "mount.cifs", pid 19308, jiffies 4295917571 (age 405.880s)
>     hex dump (first 32 bytes):
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>       60 c0 b2 00 81 88 ff ff 98 83 01 42 81 88 ff ff  `..........B....
>     backtrace:
>       [<ffffffff81936171>] __alloc_file+0x21/0x250
>       [<ffffffff81937051>] alloc_empty_file+0x41/0xf0
>       [<ffffffff81937159>] alloc_file+0x59/0x710
>       [<ffffffff81937964>] alloc_file_pseudo+0x154/0x210
>       [<ffffffff81741dbf>] __shmem_file_setup+0xff/0x2a0
>       [<ffffffff817502cd>] shmem_zero_setup+0x8d/0x160
>       [<ffffffff817cc1d5>] mmap_region+0x1075/0x19d0
>       [<ffffffff817cd257>] do_mmap+0x727/0x1110
>       [<ffffffff817518b2>] vm_mmap_pgoff+0x112/0x1e0
>       [<ffffffff83adf955>] do_syscall_64+0x35/0x80
>       [<ffffffff83c0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>=20
> The root cause was traced to an error handing path in mmap_region()
> when arch_validate_flags() or mas_preallocate() fails. In the shared
> anonymous mapping sence, vma will be setuped and mapped with a new
> shared anonymous file via shmem_zero_setup(). So in this case, the
> file resource needs to be released.
>=20
> Fix it by calling fput(vma->vm_file) and unmap_region() when
> arch_validate_flags() or mas_preallocate() returns an error in
> the shared anonymous mapping sence.
>=20

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
> Fixes: c462ac288f2c ("mm: Introduce arch_validate_flags()")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
> v1 was posted at: https://lore.kernel.org/all/20221027025837.136492-1-liz=
etao1@huawei.com/
> v1 -> v2: Drop the new goto label, and jump to unmap_and_free_vma "if (vm=
a->vm_file)"
>=20
>  mm/mmap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index e270057ed04e..77846d8cf9d4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2674,6 +2674,8 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
>  		error =3D -EINVAL;
>  		if (file)
>  			goto close_and_free_vma;
> +		else if (vma->vm_file)
> +			goto unmap_and_free_vma;
>  		else
>  			goto free_vma;
>  	}
> @@ -2682,6 +2684,8 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
>  		error =3D -ENOMEM;
>  		if (file)
>  			goto close_and_free_vma;
> +		else if (vma->vm_file)
> +			goto unmap_and_free_vma;
>  		else
>  			goto free_vma;
>  	}
> @@ -2751,7 +2755,7 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
> =20
>  	/* Undo any partial mapping done by a device driver. */
>  	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end)=
;
> -	if (vm_flags & VM_SHARED)
> +	if (file && (vm_flags & VM_SHARED))
>  		mapping_unmap_writable(file->f_mapping);
>  free_vma:
>  	vm_area_free(vma);
> --=20
> 2.25.1
> =
