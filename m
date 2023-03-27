Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BBF6CACCF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjC0SPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjC0SP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:15:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B189430D2;
        Mon, 27 Mar 2023 11:15:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RIEDqL006168;
        Mon, 27 Mar 2023 18:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7UzAcSDdV6bNf+wutV/Qe519M4D0PKY8SnM0En4HDHg=;
 b=IPTeVkcAPOQo/+3y+jk+f3a83i68fmp1/IbnAveFHU8rp38NbscIoQHILFdleceEnaCP
 YvfT3ne2HYWIRdiM2VXTYduLA3qz6abXpkRRfCjpK37KrfCWaugTjgj/1B6D1hSQ0rb/
 Z8m9UvGE6FVIjdJfprW9GloF6jejjBiZhd8+awgQvXbMwjrYozggQAOJBfbtvZWvslYQ
 WNMLA7ah08zuWx0hP8w5LdonVoTZzgwYHAirXzWla+lShcdfkV9tE+dNWkbvpdw7orhX
 zDHeO0FyQKGbstmutCWLtBeu5gqteROAEB4sYViBGAZlgCS6ZErTVGVWaEYmRfmzfsj4 ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkg89r03k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 18:15:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32RHfPjo009307;
        Mon, 27 Mar 2023 18:15:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdbu0cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 18:15:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eot/T84V6jMLXXDmFLkkzYHc50eQt4ZjmnEME5ciN4TEQ6ir2wFmUm0vz6XRQyP35bbMSIF5VWQIsVitqUWG20u6QUuzCRvLL5A/dIniO3YeQNzcCL5wjyuvIpZYv3EsW5dusOOrk5vP4wSiG+1RobqtG04b+H7Emc+lR7qSP/VBrcaWXaZa1vCnPR2ME0jK75A5ryZAa6rfLp14m5G/q7Z9gma4wk5yFe+b9ZD9PLwU1Ek8FIUFGBKIascNCu4OcURtfjE2bcGKavIJ+4I2m1WNqSUc24nEG1GkSXulVktmRtjOfHqq/KnFnH2a9lO5/Fx3r8WKG2SyffcHwwz+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UzAcSDdV6bNf+wutV/Qe519M4D0PKY8SnM0En4HDHg=;
 b=F7c5zItghhmjhscOu6uvpRrpOBKjUp5JphsRt8MQuKbMG4HOi/xG7r0Ntl+5K19fJzJg8C3WIQaCMlZkE6rcNYJ0sxptHpvXgeEqpOsL9cFxmI8LimfVFALT4jaU7he5+Z8VRWiWbxXwNvZpG0O6psavxBEvwWiIradQVzDBCVbrULx20AgfEPmtkDQjh19ZvJOfe+poQOmwoxFuUe85mCvX7ortrxwlQHaE+EyiKnGGRmSfGYROnZ4FGwwEsYtPtslJphgBRZScARE+NtRsNpg/3Y66X3Q+uwCkMwmJ6BbN/SgwaGOru6M1jJiFusVTnXHKxHojNpKgheb328DqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UzAcSDdV6bNf+wutV/Qe519M4D0PKY8SnM0En4HDHg=;
 b=P0I1pGxqqSKQnaYA54FFV5HxlxJ8DewL3SGONAEfC2wQOoaxNw1TLwPtc/fCuOMYZzpAF/QK8vlZO8x0oQ29GnKdVql+t3Nu6iwqWdVah7U7PUsGWyRxRVUk5/q9tU7/QzDKdTkvm1tzxTjZk2inTROni0EKQ2ye4NvC4X9fKgk=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 18:15:17 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::2479:328e:902:c863]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::2479:328e:902:c863%5]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 18:15:17 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Li Zetao <lizetao1@huawei.com>
CC:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Quinn Tran <quinn.tran@cavium.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: qla2xxx: Fix memory leak in qla2x00_probe_one()
Thread-Topic: [PATCH] scsi: qla2xxx: Fix memory leak in qla2x00_probe_one()
Thread-Index: AQHZXsX6QC491T7GkEey324tK7jUIq8O8pEA
Date:   Mon, 27 Mar 2023 18:15:17 +0000
Message-ID: <1BD44DDF-18AD-4CC5-8F11-AE6A4EA677F4@oracle.com>
References: <20230325110004.363898-1-lizetao1@huawei.com>
In-Reply-To: <20230325110004.363898-1-lizetao1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|PH0PR10MB5593:EE_
x-ms-office365-filtering-correlation-id: 839c1822-9c4d-4772-acee-08db2eef3814
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GOakBXUr/ENpJ2kFjCJK3/6YeDdC7eYNBeHl0SPXWH7lJXTMm4RBbiZc2zhmL8Sgvu1E3z8TtM3v9/b8NSDZhOusOEjH24iQqTeLzh4sMeMAuDePJ5o/M/QGt852beJiFlprVrPjE0fn9pE4K7awOzakBPmGqD49ezYBX4DKtbx+hMO39N4lssgaviCDb8h8mVaXHFS8VloSElBYtcLbdnb++MpY7RtGQCSMdA/iG+WN4oUWBKWo/Zf5yhO1zASYUzrwCOZSDQugQEU9+KUKuGwwndjjGimJAYxaC7mAujptsdZUVOTGp+HqR2QRakzPqPmaJXpVMgLMXyB20U1ywlRIRXk+/JctTbYlrdCKE/23YihLkOxSrpT0NVvkVdaeEg8j0Jh9YnCoLpMbCC08jfYcp+tX7DcXt/90bayP1cpKRNJZ8nnPBM9X+FoxTWHi9jonpsSO7P71Wpx2kebWXS8qfLr+hIWRj832XVNvu6YeP5iViarvIfV4PuctyPOFl0Y+/bi9kGFvDGnNG3ZaGVVn/JQIrU8TnR2esmYl9IOc1tRz9f3HqfeZGzRbPGlySFZx+JWo16GxKo/Dz0m3I2Uw26PKvxJc+Im2S1Fg5oItLH6k0yRLB+QfyurhoeGykbTXQMulCJKKVm6dQSA8aX2/GbwUjRCfWkgNVau1uYYwDefSgt7N3OhXIx1IGrvQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(2616005)(91956017)(41300700001)(44832011)(36756003)(86362001)(5660300002)(38100700002)(8936002)(122000001)(6486002)(33656002)(66446008)(54906003)(478600001)(71200400001)(76116006)(64756008)(8676002)(66946007)(66556008)(4326008)(6916009)(2906002)(66476007)(6512007)(38070700005)(53546011)(6506007)(316002)(186003)(45980500001)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qSlNvnPc2GjX6+yZFc0XCXFMJePqgUmeJALzHPOBQcIn4XWfbacaeAiUCO5w?=
 =?us-ascii?Q?7XjQpBgqvkqw6e5cBp/mGnQz+pMbfTNeinuwxscPl2fgaDyDE/gFgt0usHKo?=
 =?us-ascii?Q?QtSO1GlCnIxZqMBu+2scZRcpWSI0xKgA6nYR2lnxLi7cYeyRvwVBPzu5/b9+?=
 =?us-ascii?Q?jNUwYq4dQoJI/JXvtU8Wp8GOpSD1M+H/H/mgVZME4jer8SLvqRmF6Vo8+uWO?=
 =?us-ascii?Q?wpE6r3VWia0Xplomkdc+EAtpbJxVOhpV601w8xY6WtSFjKzoMtgmDydvxJIH?=
 =?us-ascii?Q?2+fuXbwC4hOiZ7s0W547QOPLV0pSgtUOlTTDI4Vm+ETCDJQ9OPXjuoWMQgeY?=
 =?us-ascii?Q?l3SjwDqJ2/8KKQpV3X/mxYfMbl+xBpIIJqMTSwDydNmU8AuWy2mvWLVWtdLS?=
 =?us-ascii?Q?DpAugMyFlhl4uebY35Iqfm907aNJHDXjwOg29dl6v2veZUe39UR/OoNSaS6I?=
 =?us-ascii?Q?u4HvQZ4HAmtUYUUzLFatklE1kPogocuGzUDEZ6dG5Bpt3An88o1qBL9/arJS?=
 =?us-ascii?Q?HJwJJpa6fIZpP5C7i5fW3CO7NpC6uVyj11/eoE99f8SlwNa0acBaSgw6eTqY?=
 =?us-ascii?Q?PVsCxOEsXMchAm+XWWDfIYq9X07MWTQ075YB9xGr2VV4qPNn2jkIJHD/GGub?=
 =?us-ascii?Q?/pip+PwV5Vg0FixRmfWh1USaXX4lwVGzCJ9lIDN4G78K21E+Dmitxp3ZZos5?=
 =?us-ascii?Q?l12vAfaSKJsch47jhg4Hvl7e/W6usxY9K0vZmiRV51w2vB3od08sp20cjQna?=
 =?us-ascii?Q?iuCIFComZvv7fIM4n/RNEtk1U6e/7maaYWwKmdbzGV0FW/p7HsYcJl/WCWMg?=
 =?us-ascii?Q?Ma1ojgLXesVhiEAArmVBHPEAMlq+bwAH7Qnf2394K/aeQP+FDpDNDNVRH0Hl?=
 =?us-ascii?Q?VkBncjlgdvKiaWN+0Wqs7SLdwfAPde+FnFGpFAz0Y2NQWlJ1fKOrkXCb4frq?=
 =?us-ascii?Q?lHr383bBWgiFnS7YZ95GEA8Sby8O1XJi8y4Stj9Iht+2zXDlTvWn1C9WjNvi?=
 =?us-ascii?Q?lf2IuBPVhHxEsFmCtWxJgt/DgYKdyi45WTiSWJ/XTI1H05y/94ihMZWd4lbR?=
 =?us-ascii?Q?5Yq0ALXNeIit75NApx0klZfgMHu+CS9qjGl4hKS7a628FebsJEkg77Sq/KFl?=
 =?us-ascii?Q?RGiHzADW53GBSzeh6ahvR4FidGHMN6Y6w7n+nX26Q8cqIRxGHIdIHIHEqOqD?=
 =?us-ascii?Q?9De5x/kc+I57gjCo0EdFKK4z/ODQoe60K6OjuePurMhGP0DiayDBGGgZiABc?=
 =?us-ascii?Q?bhEbKjAWMIenNMlqF7m8NX5F6QonjtIlECeTR1NA5SlOLGBNR0Hh/CwOdAJH?=
 =?us-ascii?Q?qObY5Nf10S5JmORh3yrQO15bVw4/cCyJSJwd8E35P9tc264DqyxNV3M8gIwG?=
 =?us-ascii?Q?OrvLn9vGEYqNnAq5ui9FblN1eajPj7C/5TR2gfkYyBC59XG0U5FqHwlxXK3+?=
 =?us-ascii?Q?GUvNEon/yC6KX9nhvVMWNZ0QoJQDwBp2dpPw/DPbcQCNkjPalvYDufmGAFTK?=
 =?us-ascii?Q?ljIfxieWdqqW6gmJr46oji5v8Fj4ZYSDVDiwt9/JDhnfKncQiKX+kVc6hp78?=
 =?us-ascii?Q?zFV5SS4piRBRU+JeorAx47joHsQPJVs4IwJMLGQleK2X/lJ4ShvN6kgp5YsH?=
 =?us-ascii?Q?Vauo4P+JMWAdjkqGn0sZTUkuJLmrTjYKtfEchNlugnxP?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A6E69D4156752747A8F03A6922152A71@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PaK3EE89NtrlERRTNv7A9iNiAx4NCCzI8kNiqpbiGuRkCXU5DYGWEoGJWiCf0M8iUvFfFtlsC1ej4dEiNFBJeqbXnGHSckcROQ1RYK7UY8Wd7r/MkDG0V2eqFM3GItF8mEQ7jghhzXR2vuYHtelf7ph4Ji19DQzdk/KWcKdjsggT4R5QBbz9jrPju0mLpxO9yHMkE4FMLlD1gp0T9Gmzb6tCUANB1wEJujn5geLOYQNK6hvxx35y3lSEl9SJ8NZcer4eeTIlPtOVBAPhOTpOAm1wQ/6YR3RfOMj1CrAW5+s51fQbz2LLo2a68Lvcw0WjONNxXdHKaVuodPFEGlOjhC7wBWGb0ggz7Q5sKPKo18DiW5PVFXv5na7DvWC8Z6+JhEugvJ2K88VA47SBO/S/gk1UddtW1aIq5PMi2nGhk95DBFr+myF1LoXeCVdGrKUCe3KzSzcSienkUxZTnj0Elk17Jzw07vd0B+UA/K31xjgn7563kBQwPKz/fcbQqlZSsqJTi6597VbEXRHUbL1/aT7+l8ZTWwCSP+pIEl+lss2q4a8jgmtdNfxIVON1GMCMWFxxjdhFVCoV0ZlQPd80hV63qAxz9E682TkPJ/BH9g1vd3o8oEkH5G37ZJ6wtRXjIq1SkTb+SDgpb4tZg5BkEtA8UT2MaX3O8PFef2Fo6ofWA7wYEenJOxokXJmvq0CctxIh6lOvPaIxY1+dpVQXRNRSZpEQd0aZVXIgEN/p5mN5wGXpoeYv1dJHijSWIWv+rRPhSlIPPjgm76bMiFFL5H4RJBv9xQtJ+tr7N35lRZqE+h/x2s5F3Ug2onuXXjsRJ9+jV/7g/c+D3vVzRifOVhtQYfzduAaCT5/3BzBIuWbEw4jWb1YYMbJHORHu+PJbAmVnCvFBBMckr2misA2jUA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839c1822-9c4d-4772-acee-08db2eef3814
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 18:15:17.5707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MODtRar2iy0+zw0RzRz4tjVNHWjUlRv4LEutH8U7receXzASCwqnQf1fKyeNgRIKfj+5ezztlq/MS93x4lAwCdOf4g8+dLULcegDgGVxfYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270149
X-Proofpoint-GUID: vyn3uGoNd1fqMX42my5URa6mFOI8tWaW
X-Proofpoint-ORIG-GUID: vyn3uGoNd1fqMX42my5URa6mFOI8tWaW
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 25, 2023, at 4:00 AM, Li Zetao <lizetao1@huawei.com> wrote:
>=20
> There is a memory leak reported by kmemleak:
>=20
>  unreferenced object 0xffffc900003f0000 (size 12288):
>    comm "modprobe", pid 19117, jiffies 4299751452 (age 42490.264s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000629261a8>] __vmalloc_node_range+0xe56/0x1110
>      [<0000000001906886>] __vmalloc_node+0xbd/0x150
>      [<000000005bb4dc34>] vmalloc+0x25/0x30
>      [<00000000a2dc1194>] qla2x00_create_host+0x7a0/0xe30 [qla2xxx]
>      [<0000000062b14b47>] qla2x00_probe_one+0x2eb8/0xd160 [qla2xxx]
>      [<00000000641ccc04>] local_pci_probe+0xeb/0x1a0
>=20
> The root cause is traced to an error handling path in qla2x00_probe_one()
> when the adapter "base_vha" initialize failed. The fab_scan_rp "scan.l"
> is used to record the port information and it is alloced in
> qla2x00_create_host(). However, it is not released in the error handling
> path "probe_failed".
>=20
> Fix it by freeing the memory of "scan.l" when an error occurs in adapter
> initialize process.
>=20
> Fixes: a4239945b8ad ("scsi: qla2xxx: Add switch command to simplify fabri=
c discovery")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
> drivers/scsi/qla2xxx/qla_os.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.=
c
> index 80c4ee9df2a4..38916e11684d 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -3606,6 +3606,7 @@ qla2x00_probe_one(struct pci_dev *pdev, const struc=
t pci_device_id *id)
> probe_failed:
> qla_enode_stop(base_vha);
> qla_edb_stop(base_vha);
> + vfree(base_vha->scan.l);
> if (base_vha->gnl.l) {
> dma_free_coherent(&ha->pdev->dev, base_vha->gnl.size,
> base_vha->gnl.l, base_vha->gnl.ldma);
> --=20
> 2.34.1
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--=20
Himanshu Madhani Oracle Linux Engineering

