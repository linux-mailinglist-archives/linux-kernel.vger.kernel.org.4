Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429C660F125
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiJ0HbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiJ0HbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:31:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54598D8F6F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:31:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R2QpSx031689;
        Thu, 27 Oct 2022 07:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ajDqkRP5FTbtGWkK7+7DqzurzasoDagKiTpOE+MN+yk=;
 b=J/5fPKnGxS/wj4ncqi4PUkX1fLc76Z+DCaWcHUqlX2jBVgY14glnk3jjZUiwpAYsiU2p
 yqwByaQ2TZxN+2Zd43aDdBI7FND3k1zFziCWIa/wM0SnwwEnUxa7AAKEk+f+wfDP37Lt
 zE9r47SclBg3UTWMVCphJY+Lu2moPLiLDt9K7p8VDdw5r138AtvBKS7NWkjVEAqWaiCV
 qjEH/N2sorD7M7jwzzOs0A5Ntl5ADXGbnS7+ziCWVk0OwdiAjc1IuttOGutZLx0C9923
 DyicuHlz1y0iF2uEujrSIZ4FjerAYHkAb5kfNWY2Um+q5zJDQCzk5MtAcq2cYDK5K5mZ 4w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv1840-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 07:30:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29R7UEn5032848;
        Thu, 27 Oct 2022 07:30:46 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagmpurt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 07:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSKweF74UECbdcst0j6/XqEV/SzqbYRfxRWx5lty/ton4VzpdmBJGSJJXHKDlFGb2xMGWiH/3lmLlcCoR5InydBdMtBJf5H5vlIIoJCBuIDKhTXmW/v+4nmi4nepe9a8tjTNuQcSKmJxcZRjpV6ZS5vHwVYNI8Mg3jP2nDLW+xbPea8L3D4rU7J94sNxGw77LYRhtKN0cuNv/gVbXfc+7HjxPSXt4SZyPpmmC+ONtCkC2IpXrsG7AHg5C9LDBbnvct50IWD6sktHF1INlYV5pFUHT5nKEo4QrGDG0AbCXnpppZa1CUwvxfTiX+g17E18mrIPSccjTgqszkkNyni8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajDqkRP5FTbtGWkK7+7DqzurzasoDagKiTpOE+MN+yk=;
 b=m4O8shPogyy0QoiSCqAHK6g5XFicLgZR8uHe/6JosZNFMyMbIhMgWGs10oIWv8vTiJ2xHrX2qyNv/tv3fq+gFdS22aEgDJBpl9OJkbYSDvS6SLigaskepkilgBDjuI516dXO26VnfsXILskrtQoEZOslFmOey/YchJ9bmriSKCKD64rGOIImdMX1bF81F7yhoFDv8TdqCCrnqjWr+JkM9b6kdCfCmfirOsV0VC6TMz7yuHhLz7/dpNQNtwD/pEz1PYEY7PYpCE824B6j/MxF+IFRQ24wqqSI19MBaIFBkFuH5UOeAZSvCKbTog6YISnkbXdPua3ew5XfxwDKis8PRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajDqkRP5FTbtGWkK7+7DqzurzasoDagKiTpOE+MN+yk=;
 b=r/t2pmdJaE2pdumDJE4dYS+UCUttZJKqsQC3OcIiqg78bI9e8XnumckMMI0F5qnMQayexi++gl8MqySSRM2gDLge5if5PFy3kqnCiKtrqIRE0gAP20nk2AZTR337Ld6mU5lTj4Kle/mNpdy7Y6DTYCTatRbyS3Nh2hNhn1L9YFE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB7004.namprd10.prod.outlook.com (2603:10b6:806:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 07:30:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 07:30:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Li Zetao <lizetao1@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "lizetao@huawei.com" <lizetao@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "cmllamas@google.com" <cmllamas@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/mmap: Fix memory leak in mmap_region()
Thread-Topic: [PATCH] mm/mmap: Fix memory leak in mmap_region()
Thread-Index: AQHY6ac25Z1iEvRtV0CDMyzjjpSBZK4h2KuA
Date:   Thu, 27 Oct 2022 07:30:44 +0000
Message-ID: <20221027073029.dyo2p2kearlutizq@revolver>
References: <20221027025837.136492-1-lizetao1@huawei.com>
In-Reply-To: <20221027025837.136492-1-lizetao1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SN7PR10MB7004:EE_
x-ms-office365-filtering-correlation-id: 9d156f98-4728-46de-1819-08dab7ed2882
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AkMajKC5KX+DKfjV8yonG8sMgvRuEYDifazSJubCA9HlIJ+YzD4jArFx+MrCdxVosMFXq8LRlsWE17Vna75Q01Dn2D/imPUXDgMpua5DGE4ti8N2/8gxTw4o9xIlbDIJNroCVXyzZtn1tOSTaB6in8cLRBu+zYZt1GIw81XMalZHkJNgV4JSQiKuHZ+CjkD32SHF5iuc9IMJmURcYu4UFTISVxrXMmGydEIp7UxqpGF5bH73MJY/oDJZD9szd+sIrG/ixD5fJExGYhqtRfW9twl3PBnrl6ILafHupmfVMjjGVdcCbf5BKFCpcpWmEo0zkwZXDy1XIH9tIKAKOsxeoJfH3taknQJdYsF1MmhBQZnAwRTgS1lOwaAZbvjswe1JlVM+bc9JuI7jeC0XouUlDiLxb++xGSRlYaSEbj7m1rxZ6S5srUIgCaK85H4NXxjR4crrzlr1ym8T9CdtpuvGtsCXluZQhwt/pMYSRzqSW8CJb28kj+tISdsPpG4e105MMgqBiCMGcnkY5yXVgXasQKKnfdWZMWIlOjs2To9rzll8aZT3pJFxkkdiWeErtcrZvb+VAahDM+349w4c5bJee11EIRTaW320ggAfOotdA/a2co8B95pasmnOb7UpFrUi9Aep41SYWGmMu0xB/Db+U5Ha5Iv/d8ZGhjDokRlY+a1KZWt37akiWhIT/XePLiFK55y5gXwRG9bbN0uWBE16LcHGxzXO7sm/kAX3HhRlhr5B2CMhA94pmAn09qt0wEpGcF9w4eBq4ka5v5DL/pR94UY3yuBg/wUxjjELVnh5y1s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(64756008)(33716001)(4326008)(38070700005)(41300700001)(86362001)(26005)(9686003)(6512007)(6506007)(66446008)(66556008)(8676002)(66476007)(44832011)(8936002)(66946007)(5660300002)(478600001)(76116006)(6486002)(6916009)(71200400001)(91956017)(316002)(122000001)(38100700002)(54906003)(186003)(83380400001)(1076003)(2906002)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b1jH1S6gr+yROvDSP7XKDB/VKJxACuG1UYuXnNmOPlZvN1E9pUvXGzoQWXOo?=
 =?us-ascii?Q?hbUZOl621mykiMfeLGFN/zUxwUIH3Jl4IQHxMjt4Q/zDKyHDnCp6OhKIBfFc?=
 =?us-ascii?Q?kAQ05chF668pQeGzBahvpfH5/miL+bGcxyzgcmaPBKZi0N5CQxg7VYecpfso?=
 =?us-ascii?Q?vwzLx6OIhxbyV6r4Z7raBCLN4MWMCfnOa9rTp+PH4NvrE85cSRV16rVfK3aT?=
 =?us-ascii?Q?YdZ6ih+fCGuUhpJxBT5BZ9jv8TzGV3L6xFme+mguY35oPpHYOWqMGpjbLBL9?=
 =?us-ascii?Q?Mv3WCXW28y3jwvKrHwPsxf4hsHtLIEVKpPEi73wb2dprQ+FLweewywzSgLEb?=
 =?us-ascii?Q?eKREunjMKRxGB+LWcASaBTpRbH/HYj7Tq1MIMyeYW7axjKgGrvqQe34ef8Ag?=
 =?us-ascii?Q?rfXwJAH7OibJUznkMaLJQfB2bPU+jqJeHquBp3/hFk2YrDlv6pq6yhJAgrpJ?=
 =?us-ascii?Q?jh4Fh9Rv744SF9pFGG7wSsX8MaNQ6obz4k8dtFXV10qvhQKs/8Hd5bm3lCOW?=
 =?us-ascii?Q?rkxU7oKObYI1vfRjD2BePVfwJMff/SuCogvy2/7vLf3havgpXzdAuZpDXBQT?=
 =?us-ascii?Q?ufAFsykdVcAIzPeKcm2hhYvOhiG5HB9qRPVrqdVvy48Ak89ETiDdruUL+eo7?=
 =?us-ascii?Q?d6yZaUPYytmz4u579jJM5vH+P8apJwwqW0nO3Lweubj6reJWQw2Z3W3l+ub9?=
 =?us-ascii?Q?u/o2KxxxMsQ+TsYQDzBOsgNIjDRf2QD2FP+cmEvQymL4qX+FdyS6aSkdptlv?=
 =?us-ascii?Q?Ptn5tytHbkOFkcMeMUZ+ZXkJBsj+vqHjZWRSJCNRcm+kA0kXxo1UvB03Qu5g?=
 =?us-ascii?Q?a6OFhjGbahefUPSWgm4hZBZ0WJbYWLKAc0c+rFPdR1L29vLETIh3a9JOrqys?=
 =?us-ascii?Q?yLB0DX2naGqmXFauxbzPSuceSDcX85PYxeGmhIFRAVEgWbu7CiYuxRqq4Lmn?=
 =?us-ascii?Q?pZPf3tbAz6aNIYMysBN2TAeYo19lW1CAQ5pAOFrff+KecG98nRQY8ttP6GS5?=
 =?us-ascii?Q?NwnM3v/ZzXCSEHSV6ylnJ9X5o5KCMnOp5Tn9h2tFD8tEqem6fFxuaGegloBp?=
 =?us-ascii?Q?00TgAbezpcEBfXdRg06HD/QrlXBbbIsLyqo6xgYEPM2lAPWiPtpZE/SxOPXf?=
 =?us-ascii?Q?Gr1qx0c+tV+ixM2mGJc2TOPHC2TBZpul7WvkPvRbEKAn9bxyR1Ch//GyPoMI?=
 =?us-ascii?Q?NU+n+VmNASJ7/fo/yuB0kXc37gEKFQlLkOhbfJSWtcl0AVyvScTQ9A8YigC2?=
 =?us-ascii?Q?zHabxg3v7gwJJ+49plwF61eREsSaWe6J6Ysyz8XH2sfu1p0pTuukPrd3wzyU?=
 =?us-ascii?Q?2nHVis5G4oGqXBUyrjYu7x9DoiVPioF309rWxlk2E3ycZbAR6TfRHg4Kdnef?=
 =?us-ascii?Q?/MzrbMv05atrIpVrxihWIy+Ukr4qpengLY4sGgh1c/7+9kD2q98rJ3mdHNRD?=
 =?us-ascii?Q?Eluz5EnDmFuEyjegHb8Zf/YZisRulBCYrS05Qmw3Gh+OJFpIWgxFwWQhqnyM?=
 =?us-ascii?Q?7xwF78M4lhnLu8lxhid1oXX2AgpJb024HtzjaQsUea+iRChbHhkJt5rG235w?=
 =?us-ascii?Q?MyZUvu4STSNzYRT8TRSA6bFlXy/2OY8CtedaPskKj8QdvNh5vMIvCb7vhuOt?=
 =?us-ascii?Q?iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C013221BAC643E488838B3FB50A6E5A9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d156f98-4728-46de-1819-08dab7ed2882
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 07:30:44.0780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8LBBTJAxNsZgcHd4d3jHQMtSvaa1iJxV4d9QMw9SpF//WLWYnlPTTjzILa2nKT0BZ1iiwMS+7WnvK5QNCs93g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_03,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=995 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270041
X-Proofpoint-ORIG-GUID: oBtlmwyJqT_G_tHfNlnd0hHsFjh0VxDD
X-Proofpoint-GUID: oBtlmwyJqT_G_tHfNlnd0hHsFjh0VxDD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Li Zetao <lizetao1@huawei.com> [221026 21:55]:
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
> Fix it by calling fput(vma->vm_file) when arch_validate_flags() or
> mas_preallocate() returns an error. And for the beauty of the code,
> put fput() under mapping_unmap_writable().

It does look like the unrolling is in the wrong order in that section.

>=20
> Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
> Fixes: c462ac288f2c ("mm: Introduce arch_validate_flags()")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  mm/mmap.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index e270057ed04e..8530195b3ec5 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2674,6 +2674,8 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
>  		error =3D -EINVAL;
>  		if (file)
>  			goto close_and_free_vma;
> +		else if (vm_flags & VM_SHARED)
> +			goto put_vma_file;
>  		else
>  			goto free_vma;
>  	}
> @@ -2682,6 +2684,8 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
>  		error =3D -ENOMEM;
>  		if (file)
>  			goto close_and_free_vma;
> +		else if (vm_flags & VM_SHARED)
> +			goto put_vma_file;
>  		else
>  			goto free_vma;
>  	}

I am not happy about this getting more complex as it already duplicates
too much code.

> @@ -2746,13 +2750,13 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
>  	if (vma->vm_ops && vma->vm_ops->close)
>  		vma->vm_ops->close(vma);
>  unmap_and_free_vma:
> -	fput(vma->vm_file);
> -	vma->vm_file =3D NULL;
> -
>  	/* Undo any partial mapping done by a device driver. */
>  	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end)=
;
>  	if (vm_flags & VM_SHARED)

Could we change the above if to "if (file && vm_flags & VM_SHARED)" and
jump to unmap_and_free_vma "if (vma->vm_file)"?  We could then drop your
new goto label. I still think the reodering is correct and worth while.

Or am I missing something?

>  		mapping_unmap_writable(file->f_mapping);
> +put_vma_file:
> +	fput(vma->vm_file);
> +	vma->vm_file =3D NULL;
>  free_vma:
>  	vm_area_free(vma);
>  unacct_error:
> --=20
> 2.31.1
> =
