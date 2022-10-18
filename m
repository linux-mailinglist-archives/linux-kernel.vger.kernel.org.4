Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE25B602D31
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiJRNkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiJRNkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:40:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E884F640
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:39:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ID4M8u002230;
        Tue, 18 Oct 2022 13:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PsNAO3BGredk6gEuU6ghYOyhWrITY+lBl/0Vh1wga0M=;
 b=HFsu3xZriSG6WcB9bg084hqGZcHdE0zwWqXivme+Hl4LpFlzSnkuGs0nK2C2Yiih5NJV
 nfIV5Lz2NaNIdzKImSuLLtPbK4EA6Kx65gEq5Q5xC/1rErkqsG8GSERVBJ7DVYJFZxKK
 tGgfCUurZr/dZvThzwhqyUnZpk+RyrbRGfXQ+XyjMFS1mejQcLrC3+jYGvSgfH2atjF9
 CtPLyhnrej9Vs8THIOVXerxfZrxfgO0WCz+7D4cJzHAPAcPNHP05D9ebeIVZMIRZj0X0
 7/IpVgSs2MEwjtBs0WrzyqlkVCTjbhNk0bP8no2dctPV1D4BHGkECYKWi3vnlFFglcHj yw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntau6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 13:39:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29ICe0Qs031262;
        Tue, 18 Oct 2022 13:39:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0qee4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 13:39:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmkSM3g068g6L+J+ZeVLs4CHTBrOVAeL0bx0iBjWlGpzn/FlnN3XpPKArBfa8Dd3sgrIqSlCskpfADxbWvhiA/tY9bUmFseuClEBF4UVUgo1Oy8hyOYFfKg7e6iN3qel7pHfO+2H5Pw/y68Ohr/vjRaVCaliURWcpvKp7IpDP7i/1wFRFdTVhYduO2OKLD87Ue5gkuC2K+nvlHegusNpaMp/SXOu8PaMvdabqEcoCjt4AhXsnLavXKp7BmL2d+zzqlqNGAZya0+i2A1WiO/VnJbI0V/QzwH6VwJSEgTjL16an/UIMksTmkax0l8J+F5MHlx4SnIVuHP/yiz7Q98HLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsNAO3BGredk6gEuU6ghYOyhWrITY+lBl/0Vh1wga0M=;
 b=JIcjnYe6sx69dyjeME7GpmSOxzMEd7b8UKwZ1Mu/OvFWlHrsSOIDLFEC7Xdlnx1stp1n0aTtwMD2jiU+vTvj7VU9AN2uz+Dq0Sje2Ybz1BgiHbEKXj4NACXfhebc/5iHvm1UFJqtLAh3lI+cm6MRiIh1xNN9yH/JqLGrVVVb4MEnB8gdzXCr35L2F3OkDgFv78ReyB+bC1LTfZvq7WdCaaWJjjT/wi+0WVp6DYxs4skdNm2ZEBy3cY/ASuGViYRHHL9i0iCDeP8tDJVy8TxqTOTaTDl0SmR4Q996cSW0wSWqGymyHImQAbE/TF0TysvqhUs+G1rnRVueoF778RR/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsNAO3BGredk6gEuU6ghYOyhWrITY+lBl/0Vh1wga0M=;
 b=D+fXmMrKN4zLpeKh3HoCVVLVdeAIQg26ss5Br27ok3hHIYhMQG+rusdBVESMy04iKa94VtJzpbnZBg/CW0jyParW/0ivZdNkcU9hEjM/nAl+IVTzrSlEEUzvLTeFF2xyHAOlUPiIGHMPR2YuVK/0GY/3YgtReHI2/2y7fdtF45Y=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ1PR10MB5955.namprd10.prod.outlook.com (2603:10b6:a03:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 13:39:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 13:39:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Carlos Llamas <cmllamas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/mmap: undo ->mmap() when mas_preallocate() fails
Thread-Topic: [PATCH] mm/mmap: undo ->mmap() when mas_preallocate() fails
Thread-Index: AQHY4pxMcCelc1fN7UG9BNkvzJq7+q4UKNCA
Date:   Tue, 18 Oct 2022 13:39:35 +0000
Message-ID: <20221018133917.i2fn5vqfwqntauvk@revolver>
References: <20221018024945.415036-1-mike.kravetz@oracle.com>
In-Reply-To: <20221018024945.415036-1-mike.kravetz@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ1PR10MB5955:EE_
x-ms-office365-filtering-correlation-id: 3b568fa2-83e6-4623-448b-08dab10e321a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 84pXjGSB5ytTIZ+4p5MvOT2JmOUT1oWXGvQX710xNHXtJDadhZ3FmIIATC08cRbYsXe0B3NAgKEp5Xj51SvfbT3o5xu91sYE7C2tQ+PKwjubEjj4fIlgEJBI55aYInrn1rGC016xMhPY7St1vzJh+1wIslMdu0JCUXNeqA16DTnGiboLu9yXnL8wJ7aFrnp1Q0szD9/4JwQn5YpzZNrUN892X2XMQSp4nJjBF+ssYbcQod+Q0DsyGOlZDTPiEf0XgpBxDPGdLBUZVOsaoloQCuGGQjvJS6fKNuzvPWjiZQNbkFnY0+ptX84E0+9Aa/trPUAClrC4ymKIETvl4NaFdwM/nYQeeXcG4vy4VWQBrvtna/kVxcBc5zxVhiezWOZedtRJnCYgcZb06ipKfk10QSDS92f/ivrlxBh1QSa/9wohkb+/sJ73QCGH6BdOC43tuE1a0MNXa4R/tghIC/rtuA5UFDLNvpLb/jVMkq58K509+BJl0ilsm7L9Vh3ZHsRg2aKmKBWJlpBjp/nX/e8n/78dBZjsWdN4HUGeRW3rub/zA+FkGYLW4vJOS+cei0do59pM3I28sdAOSPNbFT8R0KGQQxi9ob1KFhuk1A6Vq694AAZZKOu1J0GLUVikWk4k+0fSbRaZBtaQmpPURT9KrAR3QyoDo9EIKTOm0J1i6TRjZEC+F7LF2O73kZYu1Mu1wkCsIyWWoFiqfxOpkq43PKtgfUsXqjNzDJzxLt61SZVU8d3Ln//Nq08Y5ccCylpYx03mwBusfdQsxKAcIsHPUajvSlBLmE6CIfkraSa31Ak=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(478600001)(38070700005)(5660300002)(33716001)(83380400001)(44832011)(966005)(6486002)(6506007)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(91956017)(76116006)(8676002)(8936002)(6862004)(41300700001)(86362001)(6512007)(9686003)(26005)(6636002)(54906003)(122000001)(38100700002)(71200400001)(1076003)(316002)(186003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SrDhUJywciwY9iKeaGt5XNgK5XvIRN6lbHo58ctAz/axZZmu1631H32/Rv6Y?=
 =?us-ascii?Q?yiegLIO5DHeQZydxfvh8mhwikwGmqXEr694G8luAmpONPOrvYDHipceRpODY?=
 =?us-ascii?Q?HlxQvij+Bl29BD0djEaqIxLQRUKfb9o6sktXcGdDUG6AQH4iU/Fi0HGMboV6?=
 =?us-ascii?Q?LC5659WKrZuv2mji4rhygUHu9b+2aDP/WNjf3AFDzEG6SqW3kWpyrH93EZdy?=
 =?us-ascii?Q?s6f7zI7IoBeNK0pMHKykXhkYcMVogJVMtra5aJFeEBQAhLsg3C5rPi6Hb1cF?=
 =?us-ascii?Q?/JtZICtnSr9/44rbiedMji15HSi9PBJo4tjcBxMEZI2tOddUFZV9cIKi1NFm?=
 =?us-ascii?Q?AgEtr3HbrE0Vt/tUk9A0ZnZebWsz60EOZSe/+Bnq7irEjJd9gtqTktVGDm0w?=
 =?us-ascii?Q?a4RR0dxOrjbi7uHg2nL8hbidEpAFujKP5Zz2ebm/2Jwy98yV+x5Aso66tOix?=
 =?us-ascii?Q?fi08AHmk7+PqaZ48bzba0l0n5X92rWXlJ6AYax7/jXB13pSD7ahIBteo1x1d?=
 =?us-ascii?Q?eOBol+siZCNBkVT3cwWzaCPupceQCY2Qsb+IMSbxfXOMJpZyVLqaVcauqvRg?=
 =?us-ascii?Q?b0zS0TXsKyrviCnmTbAUp1Cr4R/lUB4/KfEw9aIdvlXMVG15ImyNMs+8AX1e?=
 =?us-ascii?Q?sk8avQLh0q5LDovx0Ld+FVwpZs9nvLYfbrgs5xQk9eAaOIITzZYx7XEPDIY3?=
 =?us-ascii?Q?WFRoo5G2tnag6j2ISBbCbsYyevIfzG1ryrIMBr0b6c6eaW+r6I3dSI2EdEAI?=
 =?us-ascii?Q?2s7m3Nuef9PPWA4zVRPaARny01vFSAdrmYBd9djvIO9oYzDhkrztRuRNdroA?=
 =?us-ascii?Q?G/2mN1fAGjYRRKcymFm1oSv8HFJ8JyOEq2uDti1XX89gimVYyogkGR8BdWkX?=
 =?us-ascii?Q?64uammhI6l/0D+67yU/ZRDvxn2FS/dmm8A/Br2lwuLlaxAVsOlC9ISt7jv2K?=
 =?us-ascii?Q?6SoweqTWbDyHK79wqZEt/wkaonivUQher5ia6vNR7dO019hcQuEInwkkfMWy?=
 =?us-ascii?Q?wL9TSLZz6X2Xp7WgLWFaTKqUYgB2Dw7yqC1VQ29e6k7MX/ZkfAurIcNc3n40?=
 =?us-ascii?Q?o6wFY8sbU1tLR72C1TtWeOQ4dV8xeIdpPcWnVUMqHtbBHfEpcl2qDufYYnIe?=
 =?us-ascii?Q?Bj9PaLGTYaH7LM+AApMeQPBBpwZB0joxLoG2MifFbl0NHHx95SST5QFfWpJS?=
 =?us-ascii?Q?yw9OqVaBWuvd6CERzGfTZV497thunxD676B1yeMclWIovFaH62jehoK0fd0V?=
 =?us-ascii?Q?4yjltoZXA5q8Rq62Ey9KzdXAyPJiwCEZ465eEvFVB+0wVtyoicL8iKIhonJL?=
 =?us-ascii?Q?WA92TRD9lDmpROXeprUDilbyUBBQKsgzxtuPtZVFq5JiTkeIJH2U2F0yrw01?=
 =?us-ascii?Q?e4FoEYdOqJ3vJvroSJltJHk9SXMlIf/JXvGu7jX3kXOlB5tjAJWl21c12pEv?=
 =?us-ascii?Q?7ABnwNk0OtVAp+Mb2A+5ZqPa2Sahe2T35M9JWm/M3qjmLuGMHND9XPaF0i9x?=
 =?us-ascii?Q?XQVbu6kOoPjvcxPgHrglRrjHnzrKsTjT8Sg2z0FCd6spTDUSZc6QIhbccVbx?=
 =?us-ascii?Q?K9aWFN2z88UMeejGJK0a1a6EJkpHKtil/2SAmcUvsRrITbTPZOFVSE/eutph?=
 =?us-ascii?Q?Eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C2A9FAF5EA803C42AADCAAEF12CF60B2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b568fa2-83e6-4623-448b-08dab10e321a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 13:39:35.4431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKpBRQtLnxwlNNgu9nmXyf2+Pru+0wJ1+2R7IvTZo/lLpNcoOBELlONdj7TpG71iIYLbeogAJENGNyxtrnE5Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_04,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180078
X-Proofpoint-ORIG-GUID: b78anCqjG4eqMmrepXI2REyU39yrko8O
X-Proofpoint-GUID: b78anCqjG4eqMmrepXI2REyU39yrko8O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is for sure necessary.

Thanks Mike & Lukas.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

* Mike Kravetz <mike.kravetz@oracle.com> [221017 22:49]:
> A memory leak in hugetlb_reserve_pages was reported in [1].  The root
> cause was traced to an error path in mmap_region when mas_preallocate()
> fails.  In this case, the vma is freed after a successful call to
> filesystem specific mmap.  The hugetlbfs mmap routine may allocate data
> structures pointed to by m_private_data.  These need to be cleaned up
> by the hugetlb vm_ops->close() routine.
>=20
> The same issue was addressed by commit deb0f6562884 ("mm/mmap: undo
> ->mmap() when arch_validate_flags() fails") for the arch_validate_flags()
> test.  Go to the same close_and_free_vma label if mas_preallocate() fails=
.
>=20
> [1] https://lore.kernel.org/linux-mm/CAKXUXMxf7OiCwbxib7MwfR4M1b5+b3cNTU7=
n5NV9Zm4967=3DFPQ@mail.gmail.com/
>=20
> Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
> Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index bf2122af94e7..3c9890e443a3 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2681,7 +2681,7 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
>  	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
>  		error =3D -ENOMEM;
>  		if (file)
> -			goto unmap_and_free_vma;
> +			goto close_and_free_vma;
>  		else
>  			goto free_vma;
>  	}
> --=20
> 2.37.3
> =
