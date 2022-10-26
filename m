Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7EC60E346
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiJZOZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiJZOZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:25:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0C440BC9;
        Wed, 26 Oct 2022 07:25:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QECEjR009813;
        Wed, 26 Oct 2022 14:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=v4IElr1XVSmtDQp4qrq9wsnanqdMbHLRHjqiWbwPzWk=;
 b=EgtqblsdArmNsj8gBLf4oUjasF28gj1phLSJpPVytSGW23oq1Gf9o1XeONRR9lpRDZSX
 QO3Q+psehGysBMZ8k4x0t8er97Nfo5u3aZHLOQQVbc8oK25uuy2Ac1y28oJtcWDTLVdZ
 V08BzTVA4pWdExVMNt3Lb09Y6vPLyFJqvU3bU8vhneH8Jituz9PW/Kruysv+60s7IN/p
 Cm4gA82jaV2hnwYE7vmO3ZYVW7RMtlgsj4vdTH1Lg6pUkTo0OGIt/dA9Tr6GfJn98L4c
 LtuRD4vBNxP6xOuwUXVxJfA7qY17/JpGm3R6ENNl5rXoKYHLtoLqlI/tGi1rUp7vgFls TQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a36w8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 14:25:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QD1KIp020785;
        Wed, 26 Oct 2022 14:25:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y5t3qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 14:25:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzX5euYFCVm/ouIhmq861fEwDR4hqCKzuQlbhxj5TZ18gjN9La5Aqe1gs+br1R6bCu/ox0zy6HYSmjv8sMp3XydiSs3+mzjAIEQ1cpnmq21Lo5ct1DMlI9UMosPMObqrZAt3INDODG72HELHCDfpsVuQoE15ub3ro0HkN42ZCHwZPBD/w8kwohgVfRlTpulKDGYoa0iw5zgO2s4rS4p5BLQr2o3SrsObOPlpsvFbMzfiffKvgmaENTSJexwZPyrgNrv3XhCBfmbPZPEzoNplf4HZf5jfGVQHWFsbA1oCJad7M7gM+39QV7TlYwaQJOtQKZfU2ftvWb4GlePxYbrZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4IElr1XVSmtDQp4qrq9wsnanqdMbHLRHjqiWbwPzWk=;
 b=gQVSX9c1bauALa5ZKiBRa+7ZII1Cwn7GqPg3AvmT8dBv2JEKeyr1HeEtGpPwDq02wnW5YtbAebzeTFFi9JyJtlmkJg/m2D3cAUmyWeFAdfY2/ga67h+NKi8omNRNhJnD37hoYQM5GGTAawuJly9/CHGYSJsOwBnFj8jAIxhugmh0Txg1iGWu0lhWFgKdW+MxtKVfFbO9NRrKt01oKIyitmJSaxxvpQs2J0n5VeAC6mySBRBCg8voeAoj+i/9INHommvrC+L5m2EHj1lasicyn/5I23Pn+NLHQ7RVUktDGOeXcCJduitc9Ri3xVn2cdmz0XbijwIle9TMDdin+C2lfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4IElr1XVSmtDQp4qrq9wsnanqdMbHLRHjqiWbwPzWk=;
 b=RyFgnWbl2VT2tPNcrfKMu5Vp+AO3DEKYKXVqVTXbYiZ/k7vP3kFEU0UOWatL+qlQqmgc4boIu9Kafws82sGv89MrF3puxLeGhBpAyixv0pb/mAKX2Pp1g7DDZREc1z25S3svfeQkQKOotxC1lY7Ks0t5gIIVF8wQCMbIjMkCC9U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5054.namprd10.prod.outlook.com (2603:10b6:5:38e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 14:25:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 14:25:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] lib: maple_tree: remove unneeded initialization in
 mtree_range_walk()
Thread-Topic: [PATCH 1/1] lib: maple_tree: remove unneeded initialization in
 mtree_range_walk()
Thread-Index: AQHY6TKlbfwgc8LED0+rTJD3nSzgSK4guyEA
Date:   Wed, 26 Oct 2022 14:25:21 +0000
Message-ID: <20221026142514.ipe6rm6ekyh2rre6@revolver>
References: <20221026120029.12555-1-lukas.bulwahn@gmail.com>
 <20221026120029.12555-2-lukas.bulwahn@gmail.com>
In-Reply-To: <20221026120029.12555-2-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS7PR10MB5054:EE_
x-ms-office365-filtering-correlation-id: d35abe2c-6293-4a9c-c8ec-08dab75dea77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z1Z5Gfdf6Ay/OKlUlKoPYC/fChDVUzhFvz46b1iQA8t1Jf/MG16RqBNSsXgnQzk2uZ0RATiGkvitqwAXl+jV02HqvxihA1dkHGnW8B0wdtw24sz5uzOL0ehWi53XDSCDmf8iw1oc1jW+cTkNVgRr+CrwcIb+b/8CuaPRt1z4fSPiEFcec101MeqPtt1Xz63aP+cKoE5rTXAbAmHZ1pQda5F11rANFcMcg1ELv2X9KkSdixhFOqFZeI8jy5OF593CGw/XYLdMzS5wmpsBg+vzMxOyRyi2oD4fo/lWxml6l7Y7Z5WnC/C+cCdzUVw6nU0ZzEnLW+ssFhDj26p4QHbW0Nu4PGZ7K9HraWUBCqlCwgUWFGtM5YqwbH+PYUs/p8dbPOgl5ys9JGmHiUJD5e6IT820b704jq1s3ITaGSSWDnUcvljX/LAz8fHQEe7O5ZtYbZgW6STD39QgQpabZnUvI5I8OJ+C9BjaYRd1NhoPjvtRUEU5cSR47NzPNR3655ag+4lNDvPljlQBANpyEHbTQf+mcDYnnLJQaT6Zh4xhrgRm8ilA8S8PA4xcoITjvP369jCz8gGMiZrmh6FuYC0VWqWuaWyypzXhfP5IuRKI7g2WC6QYM8AITly3R813sIriLHFgN5bVJx0ENeunp8233U4hh/X1evxuVGBpOLeqAtmZ9qCxTWqkMfKLUkVfaJouu8VQH7WmryVpEcG+c+g1wgfh7D0alZ5uZ6dvrEmqg6Ns9ZGL7umgSkl0J99YDW8BrkiNr0K9bG5eDzuvRFZuhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199015)(8936002)(33716001)(44832011)(5660300002)(71200400001)(38070700005)(6486002)(122000001)(478600001)(91956017)(4326008)(8676002)(2906002)(316002)(86362001)(38100700002)(6506007)(186003)(1076003)(26005)(6512007)(9686003)(64756008)(54906003)(6916009)(66556008)(66476007)(66446008)(41300700001)(76116006)(66946007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NFDz2jY9XySTQjR4nOIW1uzp1Sc+rmfZ58PZXPu5P7Co5HvT8aXv6TBn3HbP?=
 =?us-ascii?Q?gf2YmjABj7tO4eQVKhFNHkdPcqkIZFxc9hTaT4EugIv/fLiEo9Ex17J16Hnx?=
 =?us-ascii?Q?+Y0Gvj4f1YHAq8WWKPCVNWNojGbnLY5Xwxw9myDvYQhi7+tUl013YOdnHdmj?=
 =?us-ascii?Q?TgDXlP41PRLUWBfpZR92BW5rMHJWcyfZKzWYuhundP/0jnNIiJXFRR6PS68J?=
 =?us-ascii?Q?cqzlRdjNKqtY5ulSZnLMj09w7m9YnjmmDWxh3GakgVgkzn00vKlQ9x9YCg9A?=
 =?us-ascii?Q?RN7iVWFbZjI7BG0QkJ7Za+/rFhz4XAEJ+EpN2G/FD6259QeAJFpRNvD7BAMR?=
 =?us-ascii?Q?4ZQQgw1Xa6Itche75Qyr5m+cvAAp/nwfWAUJewljxiaPzXX9VS/Pcc6hQvPE?=
 =?us-ascii?Q?yIVrllLT4c/9XbNPegMH/ZRc+m8XIIDn/i8AH5yjGtIdLnr2qaPvD24Lsj/g?=
 =?us-ascii?Q?RqkaHCgkGvGdoxL0qMLOPRnW19hCkTfPnmDBLF6Ehv88C1O3rJZIXbUzxteN?=
 =?us-ascii?Q?jup+p1Kq8oDOp0WMSuQZdYaHBXrhYSzUojPnEjtdJfRkmvN/lEeHP9kPPa88?=
 =?us-ascii?Q?K1WT74UGL1ETZhHmEEs/4xc0Q8CDaV6vgvL+DqbdTP03DtayOY1IV4ubn5PT?=
 =?us-ascii?Q?Bkohk9ePK8Jzx4FLJkD6W6en8aH1jb6NciZdZUwxuZBgvYC3pUS4pjOyuJP8?=
 =?us-ascii?Q?prrRCOZNUFR8VFdSH48THsPaFacAQ4Qjw3yuakJQ7iPG0mYKDXNez5FRqdRM?=
 =?us-ascii?Q?1rS9VDJMxj4MnSrZ+6T07XKdgqI3z5ZLdebEqVV2E8b3+P4pSGIZLapkI0kz?=
 =?us-ascii?Q?rrgeJK8TFUB2ae19JNL6olq5ZDYiinvRzwywTwk3sGThUrzotQw0JIhKtPaG?=
 =?us-ascii?Q?T8CradMZGrFomdFPRM9kygBWLPwgpHJ1o0iOIDh7qk0e128gEb1nhnSk4Ufd?=
 =?us-ascii?Q?gZEc7I5CWXrKmJgLeVvdX1zktffJT51G8ts0rCtVCR1UseUNACHCUcufBkLk?=
 =?us-ascii?Q?dSlWd4xVMC+90EV9te7dn+hJW82X8MKBWL/lhZ19CoAQ98I63A8f8Km+MgAD?=
 =?us-ascii?Q?indAk961FvESxBGj3uoSFb8j8tsacewycJIqSOST9xHBv9vGax7yKDa6xXLg?=
 =?us-ascii?Q?aTamMcoARIzY0279lM+RzGIkdArB5eThh3jXLs8et9ZzXACLftWT1bC0WlTg?=
 =?us-ascii?Q?0Coo8z5rEk96nArO6m5KT7nFnLiB3vzaPE2dyJC4Jwhn0f/00vimw7Up7gEG?=
 =?us-ascii?Q?1IR698TLUKfIHYI19SCrqTrBTxfxaXLyF2mnLIMFXK7o4ukejLN29kCBYt7b?=
 =?us-ascii?Q?ko5abjQ8DMRCd3Z0BIxvH9SOwX89bNgiw99Hzm7mseh2lUh+p4nEsRZGsWxm?=
 =?us-ascii?Q?vHIfG9wn+sUtt1RdT7HX+XIxB0oUZ6F/IaquyJ4sGMub/WfUxIfrUxiYlwWV?=
 =?us-ascii?Q?xwm+s01KnQb2zW//I7k7R83XPdpDpYiPQyra2wTjG9t6aCnG2VyV1Ys2ukks?=
 =?us-ascii?Q?I1lPDb7dqZmUinPyO/NtKdLamCAyYVcn/A5ZuSRndbeJhG1g5qD8MJ2YUYAv?=
 =?us-ascii?Q?thCXWka+qQqVaI+NHgatRECIampcT+HM4lgJ+tNsAuZEP0NwBLkj91+fYbo1?=
 =?us-ascii?Q?Wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3D1F52706904043A61686E1E121055E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35abe2c-6293-4a9c-c8ec-08dab75dea77
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 14:25:21.9438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qTt1tWpMzh8OFZPmCr6cm2uU8ZCzCyJFTIhJz2YShlVKPam13O1oZYe29t4AG/mztZk4jjYPT3ehUmAPBkvPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260081
X-Proofpoint-GUID: -Ubqoq1VW7KkckeXP7wtsuc9den59WmW
X-Proofpoint-ORIG-GUID: -Ubqoq1VW7KkckeXP7wtsuc9den59WmW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

* Lukas Bulwahn <lukas.bulwahn@gmail.com> [221026 08:01]:
> Before the do-while loop in mtree_range_walk(), the variables next, min,
> max need to be initialized. The variables last, prev_min and prev_max are
> set within the loop body before they are eventually used after exiting th=
e
> loop body.
>=20
> As it is a do-while loop, the loop body is executed at least once, so the
> variables last, prev_min and prev_max do not need to be initialized befor=
e
> the loop body.
>=20
> Remove unneeded initialization of last and prev_min.
>=20
> The needless initialization was reported by clang-analyzer as Dead Stores=
.
>=20
> As the compiler already identifies these assignments as unneeded, it
> optimizes the assignments away. Hence:
>=20
> No functional change. No change in object code.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  lib/maple_tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index e1743803c851..fbde494444b8 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2903,8 +2903,8 @@ static inline void *mtree_range_walk(struct ma_stat=
e *mas)
>  	unsigned long max, min;
>  	unsigned long prev_max, prev_min;
> =20
> -	last =3D next =3D mas->node;
> -	prev_min =3D min =3D mas->min;
> +	next =3D mas->node;
> +	min =3D mas->min;
>  	max =3D mas->max;
>  	do {
>  		offset =3D 0;
> --=20
> 2.17.1
> =
