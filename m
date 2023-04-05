Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956FE6D716D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbjDEAjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjDEAj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:39:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A151705;
        Tue,  4 Apr 2023 17:39:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334KogAb005663;
        Wed, 5 Apr 2023 00:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=md87xg17eCjChDin2Bz9xkUjpdMVF73sSkB7gj+Ldz0=;
 b=t7LjtiPI2D1tA0Dstw2oyh5F7Hx6hbH4qEkwUEoN5gDa+4wV2Nx41qGDsiQdltdhoYtd
 ExeYz26C1rn0wYrw0uvgBZQGVwAe/Mz6WZAAgBuKxNNeHnZRTtiTh1+F8GJXAh0cSFts
 GhhX9LBIPeccFL3/RoOkWDCJkgDWfpyBYrFWxNlPSuD5sp1CQ4HVxKDmLp/nI8RD3Vv6
 0On6Zkl1+V85cb1fhy6jU2s/7oMur2Tgc7C/sTJrF1WvZG+wYDxJg0UQ+cMWEKtW6HIZ
 zzFMiMwTFP+DcM6+2HbYSV3TRS3QGvwyCtoJiqKPCf1mXVvj67zab65GCPllYGY2zFnJ hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbd3y7um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Apr 2023 00:39:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334MhT0M017734;
        Wed, 5 Apr 2023 00:39:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptp7w0kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Apr 2023 00:39:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aft/SA6LtaojgtIDVgNBye8Lp68hWdYLd7/dAYm6SfbTbg4Rpc3I9BIL0O0HI9AXNFx7wgJ6uLYJk1gajhNE+scRJCRF9jVElTAR4nyRzD+P5cCyrMhmY4DV+o2/pD9LJTllIQcvz9J67D1cU3DqzeviOFXLRmx5Hl1ODE9B3wnShzzza0MDTEnF8ZRrKO9sSxIozedcZsIO1/qnHGWGm+y8k3sMSBPce6LBzU0suJtxu28PnN5+700yOJa6Jc9CJar6q4KK5AqrPcm1fyd2Gpbl03Y4y8tyrZbjnupeNWsA8TVhX0mv5eAzBaiarephoV7pz2h75pybPLHmJyXVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=md87xg17eCjChDin2Bz9xkUjpdMVF73sSkB7gj+Ldz0=;
 b=JitoGHIQGYE1DaAyZ6M/eytR5QSafEI253R6APXZQmimor6PxCpHR0xJYABpxTVu5PaLHnd1CvETvk8a81CNvSY0pIa6MFJyWkPJUAAIAu++znAQPXW7y9f0kGioR8rNyA1ce5mydQv3y9QueXPrmZyohrRG+3xJq3Giy0ZMm4AjLH5UW5/jCwMfv2wmt0NtLra/5G2cQfBnWOtcRyzRqfhrMIUkhVDtAVCmVww4Nxuqi9vkT5w2sb5BpUA7jG8rOM3TFP7CEXxkmZuYNir7fYKxargEyEXS+UlgmXvZZLIFy53MX2MSHyEIGKmKHF1zPh7mQqx+WFgTOK98QlEBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=md87xg17eCjChDin2Bz9xkUjpdMVF73sSkB7gj+Ldz0=;
 b=rRkjNvW5xitcMQsVcIS+QnPXS9gQlawzVc8V84h9oL3w40z624C2No4/ps3MYOLhCnZpKLQip6SUCLEc+XzVHTTCqLsqrF2JazLnLASUOYhnlL1tNd0r7+qf70HIlCncQmWjmXZT7+wcyZI8HHQH49MgG6uTmbWiYsKDHmfktYU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6251.namprd10.prod.outlook.com (2603:10b6:510:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Wed, 5 Apr
 2023 00:38:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 00:38:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the nfsd tree
Thread-Topic: linux-next: duplicate patches in the nfsd tree
Thread-Index: AQHZZ0RqmYxFHTU5K0CHb7PeWyIT/q8b314A
Date:   Wed, 5 Apr 2023 00:38:45 +0000
Message-ID: <EE984D33-B092-4EF2-95D3-5C6071BB9E8C@oracle.com>
References: <20230405082539.3e8d1ab9@canb.auug.org.au>
In-Reply-To: <20230405082539.3e8d1ab9@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6251:EE_
x-ms-office365-filtering-correlation-id: 02d51221-f46d-4fe0-1821-08db356e1d26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4qpXqWGYpY1LJpAjtvksQnvyXW54qyrk0AVcjFJWSnmhqdP5A5PVv4ILBstKabzNHfpSdB0vLCP+JDxdT2qo2mYGC23OzOestVumOmT/llITM/TjkFOkjEr6oRhNQPQCRLbS5oe7LtVgU/zxdwFAPH+tspprz1t1ZVip6s5Ns+h0mybjcO3pFvteOyHLSftQ6xmQPyJvqG3rXB1ENTTBka1UF6+IbSkyHNDQyk4cSGz9W0leXI+3ZQEk7Pj1ffqsf5p2NQ8inZ17YHnIC7FCcN593m7wFzChs9KdXxXm6Ls2qUL7zIS6rpUNgLGqG1HdxTC7bAGFnTR/9O/ch/BDZDqy1PRKn/k+XZl5g89gcd0K1hcnvbuGBB5M7r+9KkcMzNsMzvpNU4x8hCbAGt2acbIAQ7kG3tX1LySUAqQTdHgJVbSD+SETEbhr/EkKm6ejbrYsvlgJRvo2/5GfqufFwm1FofXW0WuIdVwb55YLL74Piif7OJ3kx1LVAcf+8JeOKwxWXdGyNmSCxADXRQvrqBE3R1l3ohB6ucNIuqguYZOjgK4mWA+39NPGGGaRBaHGtelJgzTQM9dSP0QO9PNkHyJ/4VLGpVsiS3AmyCLhAM2zMyZd97FecehnybrDVDoAkVksUTfm7AaPQSgT+zE9/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(53546011)(6512007)(6506007)(26005)(186003)(54906003)(2616005)(83380400001)(6486002)(71200400001)(5660300002)(41300700001)(8936002)(86362001)(122000001)(36756003)(38100700002)(478600001)(66556008)(64756008)(4326008)(6916009)(8676002)(66946007)(76116006)(66446008)(66476007)(91956017)(2906002)(33656002)(4744005)(38070700005)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2UDkfSxolTVwQxKEmSuFm+eUrWY/C18u+B4+7ypkJaDsk75hOtJcN2Y51OsM?=
 =?us-ascii?Q?Nr6rbt/AvRTiCqa6v7o2TF9/Dm2o47o8/n4fobjQEjArld96S0vPAM4O06z9?=
 =?us-ascii?Q?Uo9DZs7vWnQOOMA5psXhc4J5NQou3MoEx03FropPgX5KUUeNd4+ptt9uCvDt?=
 =?us-ascii?Q?qXPZS+3xsT37Si/PpJZob4jE2n9WvH5RbZsHdwDdtVkQ1anlaJqzQ3qMBXmi?=
 =?us-ascii?Q?XoDcZ3MS6D3ZFmaYvUypSXg14KBriDfIM3mW0dStnLCL11XT+enUHknC8jeN?=
 =?us-ascii?Q?dxPiolyyr7ZC2h3IM7lzQDd+S4SYx1Hh14UokFDXGeBbIAgtTKsPm/TksIhh?=
 =?us-ascii?Q?cq7OfRkfI7yS5aYLKSm2M4HWgDFwvr4Y542+OvpNzTO3kdjPQkHUJcUGYlx9?=
 =?us-ascii?Q?G7n+tmVjD1M6YvJdkD5E/FEu6VZVy9CDHjt4LYMaot0Iz68oBwfuJ0xCFA8G?=
 =?us-ascii?Q?uklLS2Lh7SW2bpg1nRuj+4kLaAoGp8kd9XuJPmfwjP27QyWemPhYb+ucl/hO?=
 =?us-ascii?Q?r3qZoGBxBsULBdEin7AMWvDAy/MmbiFEMDHlFDSXSwZy9l5uXIUjReHJSoaC?=
 =?us-ascii?Q?AN1pdJIUqxQQiXnBPMBUsniSYmGokxAsRC3eRUW1akmqcvReVB6AcoUcaf7h?=
 =?us-ascii?Q?0XQ4Z64mbLxRggSERiPthzqPfs9qx16CSEwotZS7f7vbJ4t1qFKDBMmu9Ti0?=
 =?us-ascii?Q?QNW5lfltyaZfFp5sAQ437PL4rt8wW1bKteeimXEdkjV+WirskzUjfZk+2XoE?=
 =?us-ascii?Q?sZnE24V4p67dKYPM7oH6S7ijSqwdG556yw2ggXRDRZBl3mM+veBezaKxAwWb?=
 =?us-ascii?Q?5QPiEVhYJDp1SfHFcQZnRjlmvK9nCc25idZKmUjLD8kg0le2lL01Nf+BnA+x?=
 =?us-ascii?Q?1uGbjQV+/HDX/vvD5RtoPLiuM8DK6u70UNEzoX+qT15giK2pypo89OvQA7Od?=
 =?us-ascii?Q?zVyOULkzQ5LbaQPVjOWT8vESBWg9m61+Kz2sMiXJ5mBOyM1GLBFZREKLPKno?=
 =?us-ascii?Q?oU1oKha6yg4Wv6p08g1e6iDZ+gxbyA/KVWFfA6Yy2khw+UgD66SbAViPyJ6B?=
 =?us-ascii?Q?nLk5ObOut6lFaAF5x5HSAh2Cs706YpTH1vufxitjgv5SgPxNeTTLmbICxIM1?=
 =?us-ascii?Q?yZEguNPWHXpKYNnbRsgNPmT3O8Id3WkDejrX2EObzOfUrBmsKMyV+i9cnPTq?=
 =?us-ascii?Q?hN4TvlJxIc2omseKmfQuGB6cWyIZROpJtncOr8v2lbY0ahplA53xO3Wy6LbK?=
 =?us-ascii?Q?jyR4C1fGlQwq7DfWIaZudr+hfp3Gxdlyt6C8Jg4t2rbNhsKKcAyOOx9dhigf?=
 =?us-ascii?Q?UB99VFNkA+H5PhJGGcyzYNJNIjiD/ktX8Cz6L2o0H5gmjK0cK2RQSoBRNjcP?=
 =?us-ascii?Q?x0nfH3V6Kr+ZC/jMHKU9lBl9AwnU01DZfaA8RIamnEioA33dLuEUvGuGCjM3?=
 =?us-ascii?Q?G9RODp7xvbR1VRB8AhMmzjdSBhSqvhENEZ2PgliW2g6o2xa16B0+gYD/ES1f?=
 =?us-ascii?Q?+xJNBkE9O1e59wTinbhZ6/Xm22M94xPIa+Q/IgHPifLxpTR/tVG3XMVPD5Bm?=
 =?us-ascii?Q?fhCF6SlRDWnl+IAyovBiV3AMnqwY0f9xwzaiCN/dt2+cJZs2iRyDsGuaaeiL?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EE39C73D4D51CD4B9D629DE2BC84258B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FzK94SuF9RaHOt63M6Xd7lMEJ6MdWP+HB7eRz3Q+PLTsQkaSjGWIGp9C6uLYUrAahKtqok8iEs9fj64SaIsszXa5EZVbC2/Hx2c68FV5eA45XJ8KgJi7BsMjuVIF/twv8D3REOufgKoFIxA5KIlGYl4Q3jnA5KS2CssaJnSWpxHuYI5D58F6pe5amoz7GM+oTOT4tdlKl6T4MW0r1VPxilX4bSs5uW24PmDiQtS9AQ2luzakmxYT8UWNd/YDDBxpcfOwfWoq8WMRd0N6a6OFEMTXIVIl22/XW3bQi0o6eaU45ViZTme73P2glTcG26zFL/6AEb4aHGv/IkLCxcoECq4U5S4qAle4AVYmA35Nci3BhlJNVqnc8CYypKGNm2xVGN4JeloZ12huExnsUlUW8lG9zFhX5GoctEppHDBbSZc2WZb4EXpw1pa4Iaxr6C5U5Hpr+p8iPUcj3rHTAHzQgEYq/pniYd3Nu+pyQ8Faaq8L7oz/kIl5DHkuOsJlySaCJP11i/shGU0Xp6v/ssvPS+tk5gkN5AWUxgChqao+//2WehUqiXcvTYlPVchaqgpjHU6yAEyzVV4XE4kCA7dt2PUQLZ7ebT/+k594/3nMn+G2x1DmLomXn9V/B4BG6yU4IjUATQRP7MjTaJaPxR3NVsKLWgpEdL/EnXQ16/KPdKvpnF4iyAlj+ba0iopsxkjI6nEEiuaON8qxGaQY9j7e4DaNAgTNFX0DxjpoGItypmffkYr5I+1WlLiztd7jjgMVf0K5U9CE3gkwFtziuPb6wxDEra2yqLyn9Mu/8aOJuU9ZsDkMReg016wzAEmVl6V+
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d51221-f46d-4fe0-1821-08db356e1d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 00:38:45.4716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QL1gKjEVAcapTjwc1KScx2qRTyhlksPpdq+nUrXrSNB+mA2AUEkKKJLudffA59IqzQywRWDHlOn3CyXbrJqbDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_14,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050004
X-Proofpoint-ORIG-GUID: ff9L-t8F3W9tENUbSHh7D_AZEqZ1k6vK
X-Proofpoint-GUID: ff9L-t8F3W9tENUbSHh7D_AZEqZ1k6vK
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 4, 2023, at 6:25 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote=
:
>=20
> Hi all,
>=20
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
>=20
>  a98c27281895 ("sunrpc: only free unix grouplist after RCU settles")
>  691a90426c2f ("NFS: Remove "select RPCSEC_GSS_KRB5")
>  64208e19495c ("NFSD: callback request does not use correct credential fo=
r AUTH_SYS")
>=20
> these are commits
>=20
>  5085e41f9e83 ("sunrpc: only free unix grouplist after RCU settles")
>  8be8f170e838 ("NFS: Remove "select RPCSEC_GSS_KRB5")
>  7de82c2f36fb ("NFSD: callback request does not use correct credential fo=
r AUTH_SYS")
>=20
> in Linus' tree.

I forgot to update nfsd-fixes this morning. This should be fixed now.


--
Chuck Lever


