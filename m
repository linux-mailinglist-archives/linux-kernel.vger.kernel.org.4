Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3EA6EAB70
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjDUNYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDUNYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:24:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D148C5251;
        Fri, 21 Apr 2023 06:24:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LCYoQh010128;
        Fri, 21 Apr 2023 13:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=V5UPJVKfO+QKtgb9e9lA9i7F6EN3vaQDdp2mYCDKDyo=;
 b=2G5vgS4o/DvsTOI506qWAflfkl0sfZZoOl7DgWk6JlR81SlaSBJTWnOhahzxk5c+AzYE
 R/mS7Am8nhvKeZk3z7DyuOWhApM60mxqkeWROPyZXpC+hVku5qNSzAp9PJgQ5oVp9bqz
 u12zMh72W0pIHZTmh4vxErrOBzbBAzCu7F4BH+mPhygs6PW4IlQmUM9HNfFvPUx8DLAo
 dMzxGfGS4tgl2+Th/D3FEKvYoUaR9hVlNaWluATORdtno8KRtUrdbY6EQOtPqOYUfZwo
 JnE2jwu+ca37ItAicJdwf8plSVXcn02VdVAvaed3tcUiV2qoABu7QMuDXNcWoHRA/e79 Yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyktaw5qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 13:24:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33LBq769015650;
        Fri, 21 Apr 2023 13:23:54 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcfnvrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 13:23:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVlAStClM1706IRN8EOiIMvw9kvFz7spzcmrGXI2nc4Qo73yoZCpQ0eVOvY3VQqy353syNugIj7/LGP/D8+hVeaAj1qobR/ufiW0tVX0yBQGWx3VVBj1cepVsvF99I3SGWeJ+iZmb5trtPZWH1iWYNuP4YAUluQOKT+wlj96vDVMfCDIRJTaDnlt6iHvhNlU/UFabszK/hRLO1moHtwQT4fDhX8rFA/rkCLnGtkEgpYKkqvfRXLtor4h9mIfjV12LPscy8RDowQ+L5kztHk1NEwKiz0exK87OQgTJZ/cE91MhRGIuFdfVmSihDAmEcGhwXs5Qu9K+Tz+V9zlHf3MLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5UPJVKfO+QKtgb9e9lA9i7F6EN3vaQDdp2mYCDKDyo=;
 b=KSh0UnRm5m5+W0Sfmp6H0NrqK+hmmvOtajkAzsAo6OswMLBCSc85ngSzh0pHC3wWjQmjMJ+T31QjFsqpv7JRMsr2L/XvVkei6MwnH9JqYXszD/AFeqU1A0qHXyvgkJJZaD6HZ545iS52sE4WW0WI85obv3ylucAXfAWe9Bo3QC5xakE6fURRNBGsCtGLxQs8yYveQj7FTlkzJs4vBrO+/SDqGP+pklAjErRLmhB+CBiOWMCt+FSeBqk5zQd1A7vAMISA38Jv54f7GLa2LDpt1GzLa8EbYmQ2PTKXL2CveMmGbJ8yO55YNUUJPi+g9ZDV/wtlRbjRhH60sqyGcCrfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5UPJVKfO+QKtgb9e9lA9i7F6EN3vaQDdp2mYCDKDyo=;
 b=FvBy7Spod5QUcfEii+1/2l3b+iEiAIDEWvvxNndfRtpUBRC6LUKSfxPCaebrBg7e1Rw+1FDSlp+P7S8akszwWuthN8V9vQ6yzSnZQiI0WPUkTDJq+CQjb9OJQtGbGqkqAafaOWrsKNNazNBo/mXwNHgvwv04EARRcrgO2lxePVc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6871.namprd10.prod.outlook.com (2603:10b6:8:134::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 13:23:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 13:23:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: linux-next: manual merge of the nfsd tree with the powerpc tree
Thread-Topic: linux-next: manual merge of the nfsd tree with the powerpc tree
Thread-Index: AQHZdE0QrQ6D8ATLREuXep4isulzwq81wGCA
Date:   Fri, 21 Apr 2023 13:23:51 +0000
Message-ID: <C26150B7-9DF1-4477-BEAE-E45FB1FE7C33@oracle.com>
References: <20230421123018.78201-1-broonie@kernel.org>
In-Reply-To: <20230421123018.78201-1-broonie@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6871:EE_
x-ms-office365-filtering-correlation-id: 7dae984d-c14f-429c-31c0-08db426ba61d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZTTvFJ4g1SuSnnBeGiCfJghT+zuHXGNIITD7mJybNZWnCCn+mS0/bG7tjrdDEH5ph4b6Wr7EYEFmtOOGd1e95doozagkFFLzQ1dv+zveA2NS0wDoELpiAzgoLbt8ChgnkKOohO8sSj9ukpRKKEHH2BPHbCc5MhuHcc0lQrgkZDv/BEWEXTdQzHvtkEqAtcRN5tgkCmuvRDz4Vyw54s4pqgFI3Ug0l2BQtT4YIEZJOPkmMfcdVKfZUfm5CZ2t7HmnC5ffmLrZ0rlJc80fhTtr+vJ8G/QECGKtv9qHrdtXv/Ukm32JUfFH9nQWzelTw9tyWQUf/6CBi2y7UwIEms6/CiqYfqYulWyfLnki0qCXJmTrf1knsftJNoSdAz2xvmuGwoYLLXQxzlkzds2LYsweL6xrpb1xU3eyP81HcBHsJSHoVVNAXRLwbIUOwjkMBGJOoJ5QEfTdpyF7VtsmSlq0KYBddqlbkCV0+DQmt0SG37VZvV5txhjEH4Dyx/6F3N6BKdHx3JL93Bbg4OBJvSsTSYxDouytEj+qNs/guPzljrXWMQPfJMkDWWvns/55p9jIxy68XXt4gGWLva04gVpog4gFJ5os/QwpKhssDM4NstrvqNI4gjHZYjKL68bc0w8/SynXNxW/Vm8OtTak/NefCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(91956017)(41300700001)(38070700005)(122000001)(5660300002)(38100700002)(2906002)(8676002)(8936002)(33656002)(86362001)(6486002)(71200400001)(6506007)(6512007)(26005)(54906003)(53546011)(36756003)(2616005)(478600001)(186003)(76116006)(66556008)(66446008)(66946007)(66476007)(316002)(64756008)(6916009)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1e9YQ6bRM2u2C2yhLoAoUwhclGElBgRkqAjaG5kGalVLIP+uRsIKuMHXisFU?=
 =?us-ascii?Q?fVQMHZ11iY40y2A54JxWTNNPK5d9qqkxPUNWpOrcCTUj2Tb4cx3VX7Dwd36G?=
 =?us-ascii?Q?imQuGJxUJqkp8PImKFvLhcXXtgBWP4YOZbygwgytP1caWqEq+UCl9K6JtXwj?=
 =?us-ascii?Q?srhODAQJ8wxhpoIoCzDKtxpCSq4xAfoRD2cCGRqYnetlAcKRthWRbRuoqIxA?=
 =?us-ascii?Q?9EGHsi4Ac91fVYQ/gfbgOOUq/WNvKlqB+iqxONEyVxIV/uOlJJQCfSTKubXS?=
 =?us-ascii?Q?XvnbBPU+RbbmCgmbRJfLA9xl3jh+MdEpbj38w8w46g0i9vkZbZwgNZKrcocG?=
 =?us-ascii?Q?4NDCuXu59ek5MULpwDsWSPmJ18ZcHZcRnFPSIOK3DskBMyNy3QaKdeCjMz20?=
 =?us-ascii?Q?cMCWOqVH00+FR7Sz8MmEqiiRxz7ltMuqyYB027COsrBtqfi+KvdciJvQXHOs?=
 =?us-ascii?Q?KK0U9I2uAiXn5j2+DoSGVR4IWRlysCZMNCILQ6f3RPNEubLskJzWkRg9n2VC?=
 =?us-ascii?Q?iImBGSodF3VC5JylWqrWORnd5XUvQw1GO5Qlig3ST4Zaf4x8ob9h+kaHcMhl?=
 =?us-ascii?Q?6ZxAZN6LK2ZrCgJZgj7E1QJtIknAJBkCFntgKXHySaK0QedYdGtJcGMSQlIG?=
 =?us-ascii?Q?Fv6dh/n6cALgJUV/DcHBs58hZaUXFZeM5kqxJnUXiqjtMCfNu+EZrZHZktPd?=
 =?us-ascii?Q?oJAkRiFCxEYzU0HUkVUL0E+wvwL52YzN9sVJjUOMSbNhZYfXkjLrPkZ3/+FJ?=
 =?us-ascii?Q?tm17HPkLyMh/aSw5w2Fhv0AmPffgAVkV7rtg3v0qtJrClLcBN4xOQjfKJ2iM?=
 =?us-ascii?Q?j0demq1iCm7ohbl8hjxPsZ8/vsYT19cHvmWeqkfjherUYurhN6pEHOZY3izx?=
 =?us-ascii?Q?Trag4MPaznOv/Ld9uGgykPz7BFBxhctMsFi0tn10rM+jf9nFgFPlLtn3fRjT?=
 =?us-ascii?Q?VW0/sszA1+mILVFvk3Uo6YNSRnp6MDVSOAoyBRxh45N0vPL8U5cAe2KggpFX?=
 =?us-ascii?Q?r1dfTRIw0SLTErH3N1Cc7L8wFAIIyIKM4BL/LAv/0jyBkvdvfFZBNyz76IMe?=
 =?us-ascii?Q?BhmFbhl9waz7Tbezjtc5p8gJq40o+lRiJnfLGpS2SeuNl73uqS8RsmX2UKLl?=
 =?us-ascii?Q?gVYV4wPsYZ6QoJfHjYPFjVStHFxk7e7oEUtDibUDBgWzn3MMNPnx5AfZqz18?=
 =?us-ascii?Q?WaQ2ZTJc3K03YlXoPx061Jzbta6i1mM0XytQ4lI0EZ/z/Qw3v8LtKTQk51N3?=
 =?us-ascii?Q?seAHjSPqwUZPU2J+StMZ4h7b5kHhyuYgrlZsaY9Sjb4FJ4POX2TglozIQN5g?=
 =?us-ascii?Q?L5m9DeHDfXn/OpCXfg1RcvZ7O6T8/qCK6hy4wKyvFuBGVwIPSzpbhHJZYw/j?=
 =?us-ascii?Q?baiEvA993dgpRc+hsSfr/7wNUcUH2we28qVulgsSPkHioAxvEJqhizj0gzH0?=
 =?us-ascii?Q?UQ1cY8IeRzk+ncdbeRzhDbXZ3x3fmLFfp40dN+GYAwDaXvfinO538uNE7u8t?=
 =?us-ascii?Q?Q9MK5Sb8NntbgIUd4rB/wkyS27IgpRx0du08+8YDOZYb03kdV7//Z6G85LMX?=
 =?us-ascii?Q?GXOidSJqueHJ5TMGigOvhPXou4YqRHlqY8fUkiuYOBbim5t/jhYCrASYh1fl?=
 =?us-ascii?Q?Ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3BB183467B3ED04DAF7BDCB6C641F0E6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3xPVsZSwll268Eu82ZZVUSyXlQqV15fNp1/5EwBEZjVn5LRIXg3CKw5vLQqykliM2HX/ukc807ciyGKfQ3rv0qx2XKR6TAQ4igTWE1Peo8p/g/0OcjZCP4NX3P2EcDpB4JffgMBIPHRqa+dfpAUgq8vgAvEcMmM15hZrwSRjMwsaQEjBoxa/R71BGIoKf9sSVqAlCG9loK83Wq8O93qdFTuykBTxwIK5lbvEYv3EjFYaszcDxSh174suqIWhJkoOKZ6OX5CYIAuhJ6evn0SAWjAGqyYaVm6dBaC6Yo27EH/WbssRROUtSbIE03XyaWnAII6fYaOvmJG4E6kU1pH90hWUtSt1YFcPPZ0lNiL9IXxS9T34GoyEIthd/deZibVlJwDuHZsrxE6AlfEjJxSdg9OCTngPYvuw30LnatWfqKNl9nJrSeTYSam5AThdbI+VFrK8UIa6loepGk4QFLHXgJDuuEYNo1S6wAY3osH9P8VXfkuHjoWXqRWaTTKAaeh0vWhIjxhUuUyUwMDvnY4BV6FjtpYsVa01PER/rlwQRU01TZxPa3ByK+348b9rjEJxdkEB52S5X2ixiP+Co/oLB1N18/awVop+hXEmKXhtJuE7Hp9nPaCzXDb3S67kpiSlqPGEjznAvDlFXd0nXRzwlZyF0WMHdcRX4SQ+clWvITtUZD1d81Ogl08SENOkix4mh9sc2Lkk+tEywLZvB3U4w/WF6JmUc+jnc1kzSUNP/ZO22SUfhlED/po5pDdkIqSFvGeUnzT3T7RUZHg+HjesLVI+NyHdSxArrfmbTtIWyOQjPWFYxQdAI0A3K2W55uNgIrKyOJz/Lljk08nkP5lpBmj/nnZYOn+7dAGP05zAJZPHGGeoX0wy5Mdpb5YRWdewVluTkYNBtaRChlvbFK9EqQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dae984d-c14f-429c-31c0-08db426ba61d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 13:23:51.8861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K03Ma6526NuXJtcpqahcoY8vgh9AoiZs3q811BGMTsAVs24fsDMP1lmtIG+FpVUJhbXjYUll/GTnMs2Q5BkKJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210117
X-Proofpoint-ORIG-GUID: 2y4oG6Fb7h-8YZZ0a7tP61E1XUsrMk13
X-Proofpoint-GUID: 2y4oG6Fb7h-8YZZ0a7tP61E1XUsrMk13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 21, 2023, at 8:30 AM, broonie@kernel.org wrote:
>=20
> Hi all,
>=20
> Today's linux-next merge of the nfsd tree got conflicts in:
>=20
>  arch/powerpc/configs/powernv_defconfig
>  arch/powerpc/configs/pseries_defconfig
>=20
> between commit:
>=20
>  9ecda934f43b1 ("powerpc/configs: Make pseries_defconfig an alias for ppc=
64le_guest")
>=20
> from the powerpc tree and commit:
>=20
>  e485f3a6eae08 ("ixgb: Remove ixgb driver")
>=20
> from the nfsd tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks. I rebased nfsd-next on net-next to pull in the
handshake netlink protocol patches. e485f3a6eae08 comes
from net-next, fwiw.


> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/config=
s/powernv_defconfig
> index 92e3a8fea04a5..f2a9be02a8d27 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -170,8 +170,6 @@ CONFIG_S2IO=3Dm
> CONFIG_E100=3Dy
> CONFIG_E1000=3Dy
> CONFIG_E1000E=3Dy
> -CONFIG_IGB=3Dy
> -CONFIG_IXGB=3Dm
> CONFIG_IXGBE=3Dm
> CONFIG_I40E=3Dm
> CONFIG_MLX4_EN=3Dm

--
Chuck Lever


