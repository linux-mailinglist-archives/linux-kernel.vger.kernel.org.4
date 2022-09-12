Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C8E5B5511
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiILHPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiILHPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:15:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7771C12096
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:15:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28C53x8e027206;
        Mon, 12 Sep 2022 07:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=P4qfE3fR605ZG22Ons9zdm8k2jwI9iccOJgw+U65mbY=;
 b=kUSkPxHeDMxNHtGNVn7NxyE83FQBk/R4l9Ob1S9HopjBstjMysSRDOVq8BS35EXukNN1
 10hc2/EPnuJ6XTqHn0I+VmcwHKNrkRNs0UDfdR0AnBJZ6s2wxeXa1WsPF0V7bf7CbiKW
 3KESB97TEVzTD9Bn81KOJ/uGxbNZr9f7aI9om356JJ8By5VhCv9JmBWmLsF5bgkjSPKK
 XX8WtaB8WCgsF1b5fdbpAKFHP4Zrzp4YWbo5H/4ciGQmFrwKfRcSouyypelXa2lD7C+o
 D1DDuN5S+pWcmN9RcXEEjoIHvSHDnsrqYmMwerlrd+v5uzyGeRhFrU3dbleZCQguzWx+ rQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgk4tajr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 07:14:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28C708IW012914;
        Mon, 12 Sep 2022 07:14:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jgj5aqkxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 07:14:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPlLv1m6xEnQICrdgM8M06PMslQXPYbxSfLz8rRFVElWFsItXQsOdACfzi1TCRZj+qv5+OQbvNPiwMK+ZrNt+d8wsyFmCublDbi5YIQnyhm9AFe5AW9kg0GhDzH2UVu3365xzNvjTBLkrEmIH+AFZiZuaAbvrbBK0LTMHMMvbpLxQ6FV+riYTAohqBgVGp/AGd8n5bffVs5WJ6nX+hKacJEhzFCYq6NHG+3xb9eYCmLz1b2ZQ0pd1eB8kgjkDla+TcXjYzbtC2hu/4/zu9GJKUz3hQn4hrKg/ACWrJSUn/Uh3sdHyfarUnGp6cRH9m3qq890pT4vNNuplDFrCXIxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4qfE3fR605ZG22Ons9zdm8k2jwI9iccOJgw+U65mbY=;
 b=fPoWARSETxefA06l4XGjZKtdqM1vZf9et6jXValSWw6Z7UvnPS5w7u6ZoeYqOjR7t4Y2Pw7zWjibs2paJpsBZudpzVmusRvBuhmlr03raz9QBl+oarKrMJ21jLorCWXVFWmV4YNLioBsP/KAScr7peVFNt/7vRE6iOdruBi6krD6AHUqP1GlvSxP3p2xqg6Sr1c0UJ866tBLlPb3tj5DGPiv/a4R694SomOK2LBDRf7ZSiCbpiRg0UwEMjSzAAxKt6IGvoqPoAcp8kEiFxmy1b5pzDGeKTUiniwV7DdUmmgEtQ6flru8wgnFp6Qa5N0ins64t64e8HzySi6ELmuf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4qfE3fR605ZG22Ons9zdm8k2jwI9iccOJgw+U65mbY=;
 b=gU66+4J/WgiNkMHCAsW1R/oiE7oNVz+Kywh9mqahEyUKuOL4vWryxXdK0gVZM01owN6y9xlskfAOMrV1eEyXmgjBBEIez9Radbor4dzhVgmgjWwmzDTVmJg9rb0HX9YAzoo+lory2EF6COO4cyJBk/lOilFYVkFeFXjnnqRxpmQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4114.namprd10.prod.outlook.com (2603:10b6:a03:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 07:14:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 07:14:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v14 67/70] mm/vmscan: Use vma iterator instead of vm_next
Thread-Topic: [PATCH v14 67/70] mm/vmscan: Use vma iterator instead of vm_next
Thread-Index: AQHYwim41qFX4NT4hEKplpVufplZ2K3bZN0AgAAFc4A=
Date:   Mon, 12 Sep 2022 07:14:50 +0000
Message-ID: <20220912071439.wjg2qiyrfslsdusi@revolver>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
 <20220906194824.2110408-68-Liam.Howlett@oracle.com>
 <Yx7XzNBMbcdgTxa9@google.com>
In-Reply-To: <Yx7XzNBMbcdgTxa9@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BY5PR10MB4114:EE_
x-ms-office365-filtering-correlation-id: 54e36a9d-47b2-4773-05bf-08da948e7b6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8CBtXA4Tcaa2XJBxTekLjqt+JVsxRUJSWMGQwCnBZWexoRX7HYTdDbyvrl+TRJjrcoh5/VIvWSbQggDlU8Vo8eY5kbugS4hqdRZiA9D9CzKbHlhtt/5CpZzl6dHGWtU1YaFmSH9VC5R5tD0SP/zqRMAuOnWamQFTK/X9AMsZ/XZr4LpL3uYRoMo/cSzgvAAXM7gnssRTOEGJOkNSJIMm2JqcVzaye8GR4ERtJsX7rHXbxfC2K9fXS14NhrPEX6Q35RWq4fQI8cRT4dTeYnuhaqZR1gLc5G56Rv35h3S1Gxi+8NF391wtz+0MHwVZZAJsAYpYVb01E1jMIVzHowAnnjusSvfAe6tNRsopOPnDHOL00OjDMpmzmHMJcKvuCRmWSwsInGZTpVupwPWqbZj0/uNzZcfSb/OEjMpjlu64Vv+QYBmWazPWFmrY8YDH/d7x6FwJcR+2BJ6AmAzN9hZkOrrhXXG/WP5WxUyI28pZVIAZ7rYhbeXlZ9Bm8c/jJ9XAmoq6IejKzBaKlaUz5gVZ7Z8al4LpNVYMb+owA3ApZkZUHg4D8YTGH9dDlpEYLrjBDtQVgyJLbtubPks1Tp12CvPG1a/HM0P0WYVhghxDpfWx/Hkit2G/jh2Jrc+z2PdL+6ZgwtpXe8m84Zx1h+hXN21PbQ5l+CQoWDAxzcFLt8Vzq7MbYVLk3jlu5gPFmhIVlKV6VbggS5iIWDIZRne3k6H6mS9ju2coUFVT9R/LjdvlU5b6EWfIn73XFNO8vCf4pzfKNa5ch1tXVAfm4vDWuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39850400004)(366004)(346002)(376002)(396003)(136003)(186003)(1076003)(83380400001)(478600001)(122000001)(86362001)(38100700002)(91956017)(6916009)(8936002)(66556008)(66476007)(6506007)(316002)(54906003)(66446008)(38070700005)(9686003)(6486002)(6512007)(4326008)(2906002)(5660300002)(8676002)(44832011)(66946007)(41300700001)(71200400001)(76116006)(26005)(64756008)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nfyBtQmA+UV9buJkyisCCxs1FfMpYbtZuKILnLLNzBw6ULXZzSWecLzZy+c1?=
 =?us-ascii?Q?x7IKZ7JLaaJ4C1uVT+IdJHU0jJ9Ya11c71LHPJVkcrxydjGFsnCgXmUbl/aM?=
 =?us-ascii?Q?fUfvDTY109ZUfFsm6G/IwV8c2CMV1zfMonSFOjobtZKyLf96XMvcbPxA/jwA?=
 =?us-ascii?Q?TkFAVj82T6Sr/v8Aud6njb4+duhwU+BeaKMbh713dReF2xKLBExoASQmcGnb?=
 =?us-ascii?Q?G39vZ/VShZCz1V7BQZViSA0EOBfTnd0oRZtZ1jQuDns5Gkj+0Y1qkEaRsMrR?=
 =?us-ascii?Q?feDnuFv1PGWNvTB6jIOGyS/449umK9530CxmGdirzkBzROqBocuXzxRbhd6Z?=
 =?us-ascii?Q?vUY/Y4pZBJnnUpmdk3NoHqzr70YeaiZTI9kb9+koZ3Z3jB9ocfZfy9B0Oc+C?=
 =?us-ascii?Q?Ze3a7hwAoYNKBcL34qR5qEBWOiLqSj/+OCe72biphBC/ll4M5fhGO3jMnoS1?=
 =?us-ascii?Q?3WFvffL3coWdoWnUvZZ6gmvs79NuPtiNIiTVh6MrwdLjxksk45Oqjm8T8lGl?=
 =?us-ascii?Q?9/hUKJmv70wGOSOVFUF7MDTKe4nwjpLu44V9UDOIaZDSYr1fXu/Z0kbDVTgK?=
 =?us-ascii?Q?UA3wWG5FZfDQCQg2cyz9s1ypfh0Ta6qz3mv82qN+VpwjyxOqbi7PEyuAu7I1?=
 =?us-ascii?Q?h8tvdQrWEb1a6vbXISF9xdrrdAlGemBugyeYNJM4L5ZDCrW0uA/IFkuodPAQ?=
 =?us-ascii?Q?dUZQYtfgIuWOzr584yRFJ7s/T4DKIXyCtQbqygJWATpbbnHYJs2HymAOTGWB?=
 =?us-ascii?Q?9of2NvqRfR3nn1QLbJYMCg6Cez3E3MP/XOJDjAjd09HylBX47PJTHugq2pZq?=
 =?us-ascii?Q?WbSVFnGraXktm1SfDBH1q55FiimDvXHRVuHvtlr6Qu0OdiK5Ak3e/O1LQ5j1?=
 =?us-ascii?Q?EXBoVS4vC4HaZmpKRidSeeYhkKjbMHzdAax9GgV82+g99XY7kMSVSoJBbQIo?=
 =?us-ascii?Q?Eq5fy9pDq1473NVRqBn3ADxryFhv49tEn3VFU9oLbeNQ+zTAjGWUlHVhiNC9?=
 =?us-ascii?Q?OAF5bouURleAE+X8CewlKJ9pvETOIEuTUX2kwBKf33U3IVTAFLanoXLruBzN?=
 =?us-ascii?Q?ILiZRqTX9G4NJLmxKsTUaXtWpDprR47flYZB87D1QpjwaeXf5o4777siZ1B4?=
 =?us-ascii?Q?0CU6jNQ8aU/TUgifHAXobVH1L0VkSRoWz+yERBIsL/GxTo8Gwgm7AgYokI5V?=
 =?us-ascii?Q?W6JSaZiyC/ZR+3K93F/EmHc1AEEVwMA71ZFqhgMBHIOs1HE+UaYj/JNed4MT?=
 =?us-ascii?Q?VpoUa0eoKTY9GWLEIo9dewEyUMaIeKM/EHHZoVAzQ958KDwwZz8UNyAjMQLc?=
 =?us-ascii?Q?GxzjNAgqZCuTX7cFo7hrMb31WZXi9AlKFOIBE0AsW+UobF4TpKH6EqSMwidM?=
 =?us-ascii?Q?qdX3smExNU8+8Qeo9ju7ZcUNaj7+O6UD1fQaVcV1m9gp8ThEhIJy7/yztb5V?=
 =?us-ascii?Q?EMBISbfkQIZ8mf6I/7QaVBFeKsG3da1L6nYlq2IREQblXICQMQtWx26EP2I5?=
 =?us-ascii?Q?VNkBXQ5cWG9kamzXA//LHrAgdyCoWry6pcwlu9oNqmH5zyM++MXo2Tt+cRic?=
 =?us-ascii?Q?LdKlHenbajhxoejL2wiZuxAdPuOTYGzs7XLdVSjZBNlo6BSXqWzdgEdYvncC?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5B8354C7949074AA9B2FC8F8EBEB5CA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e36a9d-47b2-4773-05bf-08da948e7b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 07:14:50.2690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YH8O8xPTMZxm6e4IZnJLODzEL50R5k7HdkniRV8br9aAwEinH6PN4+ytTAh6G51iwY0UZr7EevrViXKPZEQBgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4114
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209120023
X-Proofpoint-ORIG-GUID: zfbt6PFr3C48NQHaCJytEMT3Ii_HqZhp
X-Proofpoint-GUID: zfbt6PFr3C48NQHaCJytEMT3Ii_HqZhp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Zhao <yuzhao@google.com> [220912 02:55]:
> On Tue, Sep 06, 2022 at 07:49:05PM +0000, Liam Howlett wrote:
> > Use the vma iterator in in get_next_vma() instead of the linked list.
> >=20
> > Suggested-by: Yu Zhao <yuzhao@google.com>
>=20
> Apologies for the bad suggestion.
>=20
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3776,23 +3776,14 @@ static bool get_next_vma(unsigned long mask, un=
signed long size, struct mm_walk
> >  {
> >  	unsigned long start =3D round_up(*vm_end, size);
> >  	unsigned long end =3D (start | ~mask) + 1;
> > +	VMA_ITERATOR(vmi, args->mm, start);
> > =20
> >  	VM_WARN_ON_ONCE(mask & size);
> >  	VM_WARN_ON_ONCE((start & mask) !=3D (*vm_start & mask));
> > =20
> > -	while (args->vma) {
> > -		if (start >=3D args->vma->vm_end) {
> > -			args->vma =3D args->vma->vm_next;
> > +	for_each_vma_range(vmi, args->vma, end) {
> > +		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
> >  			continue;
> > -		}
> > -
> > -		if (end && end <=3D args->vma->vm_start)
> > -			return false;
>=20
> Here the original code leaves args->vma pointing the first vma out of
> the range [start, end). This allows the caller (page table walker) to
> resume at that vma, if it chooses to.
>=20
> With for_each_vma_range(), under the same condition, args->vma is set to
> NULL. And the page table walker may terminate prematurely. Apparently I
> overlooked until I was told MGLRU in mm-unstable is slower than itself
> on 6.0-rc4 yesterday.
>=20
> > -
> > -		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args)) {
> > -			args->vma =3D args->vma->vm_next;
> > -			continue;
> > -		}
> > =20
> >  		*vm_start =3D max(start, args->vma->vm_start);
> >  		*vm_end =3D min(end - 1, args->vma->vm_end - 1) + 1;
>=20
> The following should work properly. Please take a look. Thanks!
>=20

Thanks Yu.  This looks good to me and the explanation makes sense.

> ---
>  mm/vmscan.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 11a86d47e85e..b22d3efe3031 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3776,23 +3776,17 @@ static bool get_next_vma(unsigned long mask, unsi=
gned long size, struct mm_walk
>  {
>  	unsigned long start =3D round_up(*vm_end, size);
>  	unsigned long end =3D (start | ~mask) + 1;
> +	VMA_ITERATOR(vmi, args->mm, start);
> =20
>  	VM_WARN_ON_ONCE(mask & size);
>  	VM_WARN_ON_ONCE((start & mask) !=3D (*vm_start & mask));
> =20
> -	while (args->vma) {
> -		if (start >=3D args->vma->vm_end) {
> -			args->vma =3D args->vma->vm_next;
> -			continue;
> -		}
> -
> +	for_each_vma(vmi, args->vma) {
>  		if (end && end <=3D args->vma->vm_start)
>  			return false;
> =20
> -		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args)) {
> -			args->vma =3D args->vma->vm_next;
> +		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
>  			continue;
> -		}
> =20
>  		*vm_start =3D max(start, args->vma->vm_start);
>  		*vm_end =3D min(end - 1, args->vma->vm_end - 1) + 1;
> --=20
> 2.37.2.789.g6183377224-goog=
