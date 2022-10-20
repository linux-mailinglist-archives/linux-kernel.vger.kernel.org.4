Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAADE60648D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJTPbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJTPbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:31:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63241109D4B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:31:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KDwvEM021229;
        Thu, 20 Oct 2022 15:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bqxI6+sbMdbsiw6r00zEtd6bQS5mF0HtoacOwtGBYL8=;
 b=mfMx2nI3Ku+OjIqlqcK+DkLgU+WcN3qqcFZ7xBudohhvJ0Y8IzpuwoZGPa9pZ8pstKCh
 1xfhKikb/PQ88puE7su1Lk1xkzq06GfT6NZ4TWEKBFLhQ2ufgBieh2FSg1KdBhuWTGIc
 297Nk9pABugkdxoiqMowoh60Kaze45Uyz3h9t7PM7tMg+YMhHMAqKt8cDE1wF1HLUPXV
 iUAPkDjOde9TZEG1avWnFg/q4eDlRul5Av+0VPYQNejDApFY4I+4xX8xOeMn1xfSh0tQ
 xje90YtsqzWan4Argw5ADQXw18K+pza0vg8IzthaK1Q4HTjMMnLRdYvBOeXP9B0QSLgz Uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mu05vhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 15:31:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFQuCW007219;
        Thu, 20 Oct 2022 15:31:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hrcx51h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 15:31:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJMmC0e0s2HT8YNkuRj203uh57+LQMseSAdzl6sBUvynSBEMsrqMBHvaYgRIqLDU9yTYPaDvYad00V9p0L636ibYZXMnBxfwb31dvXwyYPyeDUs4V7EIE76snpop0XfPIzDWpyzf3eVHVrDHjysHifYwo8cATb19DX760apek+yjRVz3Et3+oPPmRCd27JZZ6Sl2/Now1Dg2a9ORdQ0XMzmqATta9TsdzRl/OyxwV1BjMgo6rO2OuLb8aeWhxFxAaJFcZrH6rOnjBzC0SJ9z9NxsI9vsvYstetpz0IXXy+71hpKZrRor0uvOJOwhWtcRUirscfPGxwFqVD7owHEqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqxI6+sbMdbsiw6r00zEtd6bQS5mF0HtoacOwtGBYL8=;
 b=nqDVP0k4irD0EFlFhOQ7RmS3c8QRZBhdBKx8VsY3ZWeFHTmFY7iEMaCtCMrfWtiGhtajV03iHiDJIisaa0xqYn5KND1IINnTVK9FpP8Si5O/ASFdHap9skGLHQWWXUPnZuBh91BqF/7b7d786KykFOc43Xu7SRCr4w3ijEOCrLiujJuJJSr1jdk8cXdu6pgCBSxfvEUqk3mud7zQRK4zuurkRa0jM2RpwpraIzHc4QAfHL+Ml++bUOQmJLJ+1OStBS4MoSEH1CF/Pyf2qttS2iOd7DlfzNBEV1iJvbSK0xc+b96YpcDhO3D/AI9amooAZNk2zofhSj8PZBczN62lig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqxI6+sbMdbsiw6r00zEtd6bQS5mF0HtoacOwtGBYL8=;
 b=bmJBtgrZjwsp9LN8RVbLUxENimP9M2a7aSD8igKGeuKrSU+MaAkosh1Ky78nHqsz2DTWzTTj9+ykLi4yLkBX3wGyRNDPnczIxDcyjshM1iath+oPmA/zb+APSVvP8YQTTOqkSK22JCIaCtiZp3jMtTMRX+vEUbOKPS+r83LPPNY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW5PR10MB5716.namprd10.prod.outlook.com (2603:10b6:303:1a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 15:31:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 15:31:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Seth Jenkins <sethjenkins@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: /proc/pid/smaps_rollup: fix maple tree search
Thread-Topic: [PATCH] mm: /proc/pid/smaps_rollup: fix maple tree search
Thread-Index: AQHY42mFCi5Khs8xZkmIrV77ByCJna4XaxeA
Date:   Thu, 20 Oct 2022 15:31:25 +0000
Message-ID: <20221020153101.425njbgquuu6ezv3@revolver>
References: <3011bee7-182-97a2-1083-d5f5b688e54b@google.com>
In-Reply-To: <3011bee7-182-97a2-1083-d5f5b688e54b@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|MW5PR10MB5716:EE_
x-ms-office365-filtering-correlation-id: b864b222-87ec-40ab-7519-08dab2b02633
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ImkM5lyMmLWn1L83vy+RGnkQ68njN1nZCH4cZzvoKENl/mQDEbVgl0Bb202opib5YY2RAWZUbLR99WhnEQUQAQKbrtI/Q6m4AMDdQEW0Xd9itjGlTLF/uDEDs4CNdCaBVHmS7TwdnafcCnkp3MJIEaD4Bnc5YYBvLzNs6GE/hMYzGeFtTdhwdBhoHz2gZqSKplmEGKnkVRI9fEk7Ywija6kbw8vtdqzRvcFnbVwc51ZngJTXNuR6jkK3pPIUzogoGqqJSx1yTsIbxezbWcTdP+vCXhwnqhVZe+ltk9aIV/y1Vjy+HU8xk+rwu8InH5zsrx3HbSidnxkAlqDvBhGF1uWcjpXYAu7DuuRYsvEhLEwKLGxKjx07hHDzcn89DvS5F6kJOjcMHjnFNsUBX02jZRPRkJ5lebeoZKGZA6FHgX/n0KwPnKG2gD2/LtbpHiGt1t1/FV60L1C2uhZCTCG2jAWRf6jcNUagFAURPY0H5j6rl2lP8rUhWmh4Nq59+Rn+zhJS+jIUXjmZ0RjhS0jhiMD7GRF8z3o309o+BW2qCih8gsKr9r7BHf3B0WjeaWU3nSgY+AwVcbaPPrQMktGGijIGmOOXcM/tkmgDbVkEcPG7EdJC1gCEt74Jje++ZrgBIW/KMtqzc9w0rXODL9xhhyTESAiS+IiveE7RL5K4aMUprAtK3VuKug5aTSLmvnWCFPlUwibKj3EwJrEVSEsNOkRhxkLcXJv5KD2tc49aK/ZPY2t8AqzvEMcL3pRnczIKHYOmktvBAqhy+5fohjlq1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199015)(6506007)(38100700002)(9686003)(41300700001)(26005)(122000001)(6512007)(1076003)(478600001)(6916009)(2906002)(186003)(4744005)(54906003)(316002)(86362001)(8936002)(33716001)(83380400001)(5660300002)(66946007)(38070700005)(44832011)(76116006)(8676002)(66476007)(71200400001)(91956017)(6486002)(66556008)(64756008)(66446008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QPnsR4S3P45IU9dKJJ02GiP9SGrg59uCFAlFUiwXdZ7dCMLhN6pltcLoebds?=
 =?us-ascii?Q?eS8x+GCtoL2Wj1orAtKv6qM+CvOwVAK+j7I97cBnKenfyveTqC/+zN7pDl7C?=
 =?us-ascii?Q?C7ZTsLUZC3Ze3zBwiG/K5vndRE8zu7W39yj12mK3/A5TnIcUJUdxFe+OmRMR?=
 =?us-ascii?Q?shm9cBQ3cmCw9ZLqRQ6u2z4cQl6IOBIU/yVeX3pD90odrGai3p4ij3HgBgGT?=
 =?us-ascii?Q?/C9SgoKYRjQ0FplYduKinXuL8xWKVsd4iJfcorQ71zp9pwIfVHDbUEgPGJb1?=
 =?us-ascii?Q?1X/5+KAqpIDXVj151hrOXIEtGpC7GF/gTBFraX8m7OZLU65rNt9lDlNbS4nn?=
 =?us-ascii?Q?ODEslqb8wzkxq4a+49P4akU3GaYH0jO2l9bN3tiark81vjswJwo1vpiNEzrb?=
 =?us-ascii?Q?WOHrQwED785/PquUcB8WBYk1IOl+oC8HPuemqApcqU7ONA29dmXbQ342X0hg?=
 =?us-ascii?Q?zKdz/ZLi7R20jyaNmC/aCEdlSSZYNfdsGtISTbTy/tuEgkOhkBssegiU1IiF?=
 =?us-ascii?Q?zf8JJxRVYHBqa89/3/NBz2npIen+ZqZxUZvnG8fr0VVGkVy9eA2ioHySsBNR?=
 =?us-ascii?Q?r50AHSX1XzgXVTTbTyjTeR2oVPm5qC+VPfBOw30129ZRYsNLCJQOm5+hmi17?=
 =?us-ascii?Q?7vjd7xLyC8bTbQXPMe52+ftXD7tOZld4NvXCjKSE3lo/Y3m5Rv1oLtjACcF/?=
 =?us-ascii?Q?yqIa5ABLAtJdzlnD9jNhbfu9IOW9ytnKDRdcZLt4sK0Uxr38PZsHQFFPD8C+?=
 =?us-ascii?Q?pPae2xxwzODqlbWNOSaMV5lj+68cX72xQFsejq+5Jlk4Wy1UJXvYM7iEzME8?=
 =?us-ascii?Q?odltXs1bZXZtNtd0HFH06Y1fx6pnrOZxKT7yOlzs1NjfujDpi3I+Cem9YZU/?=
 =?us-ascii?Q?NjvqNfmsX2blyTH9YehC7FyK6haR0Y5uVTT6/Ze9R8JJaeLIrDdDPNPDfKYL?=
 =?us-ascii?Q?dCIMQawBZQ3Nz+yWkv1pNCKBhDkQGwqfygMG/y2PMihh1rWuQZgAsoJMrVtW?=
 =?us-ascii?Q?ieY3KA2jFFzKRYEf5PkS0X2OxuuqLJ2cMqV5C+BlF+R9n9yrxtFDZ9lHrKCF?=
 =?us-ascii?Q?w7Z35HKKhY12aGEsCEj9ybv3T/CV1B/3xPrhUbBxD94flW1ISFO4msTxK4lJ?=
 =?us-ascii?Q?MhBkl64+SagyMR2ayDXb7HmJMHc1hlyB+Kq1z8rH+Y9jeUtW6rgjGADtlQkP?=
 =?us-ascii?Q?NtMj5Y4z3vR+uBINuX9O9DZaKHgEAKV5gHtbjR+E0SSjJh7VHxbwE50Ff1s6?=
 =?us-ascii?Q?/qk4jXWN4g5gaVYcX8rcVm03Dqnn5joLFEewm3UB2/JiyPO61fPVqCfBRchu?=
 =?us-ascii?Q?ft//ZbMMDzaD2jBZwW0FZf2bUZ+227UtOCcW74jD9CxvlaY7qm/0Q31gjkH2?=
 =?us-ascii?Q?FuUAfFG3555rFa3fllJ/m8of2MluWXiGgw7lWVLcw04OrHG4aQQYlmNftriZ?=
 =?us-ascii?Q?5bRL7bWa8H4kPsIvwnrjs+lDDRxL25ZUYUF98RimMAfUyCxHN/pb5n44DIzd?=
 =?us-ascii?Q?zKXyDczogC5wiBiZT6+eMmOO5hSCM3Y3pm9akejnPX+QIUAuLGGpJZtnGbAa?=
 =?us-ascii?Q?9N00dE9VOAWGdbAtlkCdpGuwId7SaK67QKssRpzk99u/3CpXKJwbvLwVKNVX?=
 =?us-ascii?Q?CQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E571B116599C3A4EB6BD1A2FB8DE3D3A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b864b222-87ec-40ab-7519-08dab2b02633
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 15:31:25.0928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wkpUSQkbdR98Ea/+572nnTK7IlhIqyIJurMWcVYIJsOxf/v13i1ZhCsJwW09f+UnkbMYAVi0UrIK+UC2QTTCjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_06,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=894
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200091
X-Proofpoint-ORIG-GUID: M-vMgeBLikabjTFQr6yoS85bXXiPH8qW
X-Proofpoint-GUID: M-vMgeBLikabjTFQr6yoS85bXXiPH8qW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Hugh.  I guess this 'optimisation' was a little more aggressive
and a little more buggy than needed.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

* Hugh Dickins <hughd@google.com> [221018 23:18]:
> /proc/pid/smaps_rollup showed 0 kB for everything: now find first vma.
>=20
> Fixes: c4c84f06285e ("fs/proc/task_mmu: stop using linked list and highes=
t_vm_end")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>=20
>  fs/proc/task_mmu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- 6.1-rc1/fs/proc/task_mmu.c
> +++ linux/fs/proc/task_mmu.c
> @@ -902,7 +902,7 @@ static int show_smaps_rollup(struct seq_
>  		goto out_put_mm;
> =20
>  	hold_task_mempolicy(priv);
> -	vma =3D mas_find(&mas, 0);
> +	vma =3D mas_find(&mas, ULONG_MAX);
> =20
>  	if (unlikely(!vma))
>  		goto empty_set;=
