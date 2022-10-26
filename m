Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA28160E33F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiJZOXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiJZOXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:23:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C4A10CFA5;
        Wed, 26 Oct 2022 07:23:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QECEiN009813;
        Wed, 26 Oct 2022 14:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=izoERQmGu7nq7sUEgPz9n7j5wHQf0pdAX8N3SJbLIog=;
 b=w6QfTxywRGBAGfyxM9lSqNojN3CUW3xSN9fElJNBUVr37wmFQtSSGCmzoCfA/RgMbAcp
 J6O7qNR9q7nCJRGsNNNfbSRmkaIWSOhBZ6chA+vdNEsoGVEMZSojkQnGQvTxwc1t7nLr
 s1iP+uD5WE3iH8YyqQkvYJJk1CRD4sYYaBJ/ngoO4cmwgSgQSElW32Q547wdBi2BC8dT
 IMCL6rIMV1lQKCMQSpz2NAue70NwL6VHCLY4ZbgtROdBkxozGcDTGohm7fCAKB0ZA/hF
 uanDjYMl17nO79qzoofxY42XoKniPwTaNxerMHXkPkD1GRDH9lp4w9aGlh/b7RYk+i0G ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a36vy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 14:23:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QD1Ou1018034;
        Wed, 26 Oct 2022 14:23:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y61n7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 14:23:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1kbVjXQRhlOPegNFoFdHruv9HQrz2AhtkNgBpqQQb/Twm+XQRXvbd+s15yu8Vm97mcZ3MBEmG8vcWKmdGIAB2OFSHpVMprOndTHzdQvYR655Vado4Qg2UI0eAwqi3rr7lDk/sxCZyCONV7mvxFg4WJZhcliYTN/63ToXHghdCVPUJZYeM79QWey92uFNQ0Nb4wEtTO2r60aeUQjECjSl3bksGfIhlrRrvOKbbB5tsH1VGNqvElK3tdLwdkOXNhmd40O61pUCdUgW8qNKJIp4CP3aeNOvDEnb+iF3nJP4Gi2JwUt1CfKObo3P3RciLW6Opu0cR9nfxhC/EB2K4R5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izoERQmGu7nq7sUEgPz9n7j5wHQf0pdAX8N3SJbLIog=;
 b=EQQWfeuo+roIhOyfyQe3VjM6cx/JOn0+zstiecb/xcVGqrZrIGkgbIISxJQwLOxH0AK3YBkOgdA80wwI7AQ9U0GN3FDWXVcq9uPLtzdYjG/knI9OHz/fuFjDkL2toqpP/cEYXUJuqxW9q5exAqhzWHPWMKZWxWUn2i9Br7mptJjhhJwgI8WcGw7SDr/9Kvfz1DDoaVIGp4CJqYoZo/fNedC7Hj1LFbBSgs/1Z3ynfVrSoBneC6aoS3VFzP2x6PMD3+wehkj7SwI/FErEL9gyj3N5nq5YyLQcUV8h57VdFGDJKcEYdpudYluIKt2s2OfMpVjJXRkemqvXwQ/Nx+LH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izoERQmGu7nq7sUEgPz9n7j5wHQf0pdAX8N3SJbLIog=;
 b=tXm7azWw7ZnwO4tMdCurG3MaY5DedtEOUZqkGKA38Ffh6yIgtMkDMm7adk3LunwtG01LLG4p2DRaJKkkNa5ixdD9Np+f46qgx+a9Ixtyi17JFZboTS/flUS/VT+XjuGvuO9wf04NTMmf4sG6gUmWBtfTFTq7Z8jkQPbme5Tsi4M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB4977.namprd10.prod.outlook.com (2603:10b6:208:306::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 14:23:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 14:23:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH 0/1] Dead stores in maple-tree
Thread-Topic: [PATCH 0/1] Dead stores in maple-tree
Thread-Index: AQHY6TKh6tbAMlcsqU61BoheyERWyK4guoCA
Date:   Wed, 26 Oct 2022 14:23:19 +0000
Message-ID: <20221026142259.mvcbtmj3kde5y25g@revolver>
References: <20221026120029.12555-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20221026120029.12555-1-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BLAPR10MB4977:EE_
x-ms-office365-filtering-correlation-id: 95cc4f2c-5a93-4c5e-8fa5-08dab75da19d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SoFdmVhobn/IwtN/TPJgbgi4//Dwb+YMb/N0/8FuaxAdVAYL7vnM4k4FAJHc7mx5fYcotC0BSqoOU1VUAwHwsrtbgKiBcYbEqPijM2TBYh5SaskMHLjsWfaDD8gHHf5moIOSfcoqQcOAFYsti0225zzc5CqGAA97ETr6nHFlQlOpyDrXD7Aine+i2ap5imbmXu7+xJ4Eyc6K0vHZumUbCKiC6Lf0m3G5Xr3QYo/+N61HptgQotba8mlI1hg8dliPPYqwxepZuJZ46twt6a9zPfYOTgUW/e7G2xleiEeWGEkjuNm2cZhgiBGo4k4KXJfCSiugS8XVTwZNRR47pxmFKravJ6+xsFCCoA0NIX5BKlU0fm6J1Pa+IjG2+/rlCuTUWjCofWGE88MlkN3OSbpCpVi0bh16egfeOQt+Ud4Lzvaou+0NJ63ChHFP0dXTP/9bxfm18SuAZOkG3HBYHd/xKT6v2r/JK0brVfXPk4Um//xB6rKfdT6C9FYgHKtzMT17HhSoYMYjqF59r0r6l/tsXHYGLphL7HHjWxaLh9Sj5nE+Tc95YU3URPIT+9ZpuKgoQbpYzTf7rQOyfYO58XO4SCcZ35mwA3ErZO+yW8RpAiKQ4n41oH7lGgPWy20zPNecrIV8pqN8oEF2O3pw6AtpKH1bDrtImTDIOotxwXVKfzAiIoFJonBX1OZbFtgqwreTDYmBAsEXcSHPyHs3QjHUuluwSTfc96TisR7b19v5+kvq7a+Eflxlkr+mJAwy2HPY0IBEKatnmebf5GuNAEz2NQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(41300700001)(8936002)(66946007)(66476007)(1076003)(66556008)(44832011)(5660300002)(76116006)(66446008)(6506007)(6512007)(8676002)(26005)(9686003)(91956017)(4326008)(38100700002)(38070700005)(86362001)(122000001)(64756008)(33716001)(83380400001)(186003)(2906002)(478600001)(316002)(6486002)(6916009)(54906003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+l4kvnfMuMRYdqmKzOZt1l2R1nMqqafKsQtYM2HXm1qp3IKAREVhCHzdvGv9?=
 =?us-ascii?Q?rXgA8HaOET8829LVc5BV4aKjrxUfZYiU7gIASboS0r57kf9rm5hTKosWmQMm?=
 =?us-ascii?Q?yW/wcDPH7ZDpJVkZsKIO0kpr3EtOn+tnmlRr5/y8GccUz7CS9/kHU7plxPwL?=
 =?us-ascii?Q?GInKrGZVJMaYommGaOaxU9AcTGFnnmx/M2N/rSm2ErkD4WbKBEbij5AzkZ9w?=
 =?us-ascii?Q?5aTeHdb4wYSY+8QXQMg8sMNiz5276xiDZek3qcSiL3s4kxNXEs6Xu/osilTm?=
 =?us-ascii?Q?kcZwTVTGqexCdd0GWLoWXIcHTRL3siHhmma8IFvCQNImknuPmmROypY72AbC?=
 =?us-ascii?Q?C8SCFZ8BXzimtyVJ0ahlL7TCOkHdbhyCSrWMZY0FMmMUj5nRs1bvkcUF6VcZ?=
 =?us-ascii?Q?/SBdhhbM66LY+jnTOKLFlP9xLxzNqnUiMDP0fz+5io7hltFRKtaajAgjaRoX?=
 =?us-ascii?Q?lk6M7CICEVLxrKMyc8NurnHlxpdNBCodaqdGrrN5i/DD534EqiHKbhAoVmjy?=
 =?us-ascii?Q?Pm7bEXuVCUinWG3iI792cyov6FS/0RM+LSxtnEzeR8WbL2sfGCS/je4gXpY0?=
 =?us-ascii?Q?fL/oG9nPfkeIpstNNuJLY+6bsQKYijiuASi0EqjWzkLt0KBBBJXfnidg22aA?=
 =?us-ascii?Q?Pjl4YY2TUzoP6EiSFOvooMHv77FRtjo7HEX9WPNL2D5PxZgxh06dFqJlAgqL?=
 =?us-ascii?Q?Crw7IDNh8rSYObjSoMC6Ki51YHbvagRVnQynDs0byubKCT9vrlEOzHPR19ua?=
 =?us-ascii?Q?hwn/pWwr6s2pPcza/ELxGzwptiIMnp3FgjsCPzoEiRBN0zl621iZ+aEmh7ib?=
 =?us-ascii?Q?KP4CcHBVXa9L9VuUGoAJKxaDA2sEbeOq271EHiS1bhleJUM9gcED1lkvi54V?=
 =?us-ascii?Q?7odYlbPNgczTFPjzEsFTJ7/zRSEOeMJTOKf/cEx5AegUb8RELryhP+H+MmFQ?=
 =?us-ascii?Q?RPbL1/zBC9pLA4mW1w8G8zYvQg6Gi8zYRmhz2AsczqYn67PQubOlKj9p9Kwv?=
 =?us-ascii?Q?Z8BuS5kYsWNqm08Thg1CdVzzliJT8SOfuhipCj5j6S7BO7EvYTsxNHdyBN/j?=
 =?us-ascii?Q?YtWpZGkXf3VURugIbHdBY0OAPhpsNN/Y1fKMw4IQp11CNM+OAoyJOioeNoP2?=
 =?us-ascii?Q?TWbSKVuYYGkHjFoHow92hmTkjLHFKAIyCD4DE0JP4hLUG5bcbhQh+Y8XaE42?=
 =?us-ascii?Q?sbO+qA11d0YKyyzskSD8g0jIVXxEn2oYJVCtif9JAassnQj/QkhFnFRMNnRK?=
 =?us-ascii?Q?SeAV5KVgdGcPX3xbunOML7dmo3I7pf3+e1pFrt8Lf5P+xeX5/repEQEhIYwj?=
 =?us-ascii?Q?qRw4YvHIMD/5iKDqLj1u3hN7e9j/yOvg1uN59ob2tLEG+DjqDYk1Dv6Fpr+/?=
 =?us-ascii?Q?HncueebBPSTOrOdagjJiG2TJd4eNK+Mx24xDpqXErXDocJfb9F0EpEV7Mnzf?=
 =?us-ascii?Q?1vnfldzzvk1nAiuFcElJOIX8A2kXum0cF5la0yV8tFZXq3xdm1Bq1E0K4NEj?=
 =?us-ascii?Q?fpfwc+jhs/Y61w/T2TeXRghG4j/6Puv43/sbdBxUBzwGxVF4jc1u+v03TBqA?=
 =?us-ascii?Q?k6yTuoEk+5l6c75ILaviFyWGdFSbC3O4zQfxGgIHghd3nEuk/QXmZCalSCMe?=
 =?us-ascii?Q?Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC7ACBC923B28846AFF8F91FF17B3ED4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cc4f2c-5a93-4c5e-8fa5-08dab75da19d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 14:23:19.7333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ykqwhIz2SND24gINSv177cuX3HD6adC9IASrQ26I2YSHHLGVEoceXNwPuhqpODYnT46qe7l+meU1b6bm9aG8jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4977
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=438 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210260081
X-Proofpoint-GUID: aAY6wGqzLFd9qAqF3ZhZr1fE7HyAkgEm
X-Proofpoint-ORIG-GUID: aAY6wGqzLFd9qAqF3ZhZr1fE7HyAkgEm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lukas Bulwahn <lukas.bulwahn@gmail.com> [221026 08:01]:
> Dear maple-tree authors, dear Liam, dear Matthew,
>=20
> there are some Dead Stores that clang-analyzer reports:
>=20
> lib/maple_tree.c:2906:2: warning: Value stored to 'last' is never read [c=
lang-analyzer-deadcode.DeadStores]
> lib/maple_tree.c:2907:2: warning: Value stored to 'prev_min' is never rea=
d [clang-analyzer-deadcode.DeadStores]
>=20
> I addressed these two cases, which were most obvious and clear to fix;
> see patch of this one-element series.
>=20
> Further, clang-analyzer reports more, which I did not address:
>=20
> lib/maple_tree.c:332:2: warning: Value stored to 'node' is never read [cl=
ang-analyzer-deadcode.DeadStores]
> lib/maple_tree.c:337:2: warning: Value stored to 'node' is never read [cl=
ang-analyzer-deadcode.DeadStores]
>=20
> Unclear to me if the tool is wrong or right in its analysis here for the =
two functions above.

The tool is correct but these aren't going anywhere.  They are compiled
out and are needed for the future.

>=20
> lib/maple_tree.c:1212:23: warning: Value stored to 'nodep' during its ini=
tialization is never read [clang-analyzer-deadcode.DeadStores]
>=20
> A lot of pointer magic. Unclear to me if the tool is wrong or right in it=
s analysis here.

Agreed, this is unclear.. I don't like it and it needs to be removed.
I'll send something out shortly. This was refactoring by the looks of it.

>=20
> lib/maple_tree.c:5014:5: warning: Value stored to 'count' is never read [=
clang-analyzer-deadcode.DeadStores]
>=20
> Unclear if the code is intended as it is now.
>=20
> In mas_anode_descend(), the variable count is really just assigned and us=
ed once
> effectively. The second assignment is never read. So, the variable count =
could
> just be removed in mas_anode_descend().

This was probably left over from refactoring as well.  I will fix this
as well, thanks.

>=20
>=20
> Maybe these further warnings are helpful to clean up the code or find an =
issue
> that was overlooked so far.

Much appreciated,
Liam=
