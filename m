Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969B260D576
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJYUX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJYUX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:23:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E534458EBA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:23:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PKEcWa026177;
        Tue, 25 Oct 2022 20:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=pgaqK2CBxLuiIVsatbefuH6vooOASRU0EQwiLtFylvE=;
 b=hzTvXS8kigZ8WWr27yeaBSmasBsKdjClxNomMdh7+kFjJlo0c1IEzdC4vMZEHCS8f8KZ
 601HdxR3R37+ER/xf69hrTxN9EaQ3rFzH30jLB+DNy6kaEYSCnuAUBSgN6/1q8Ulq6Bq
 REyY19Na5FyJHfqHYEtHxB9c50wQyeRqlZJMDI3uIqOrGUEFcAbXBPyOB5U3+afvtq3Y
 OWanCTpiYjK77M/m9EoqDbtoFrWdfjbdAARKikNozwj3UENQiMm/K4SUujeJVbuf9Xok
 OlN7rrcxL6cuHeSTUA+kTIH0LzU5xTh6KJasWkHvtjWEuN1tQ7EU7+zmaa5fLnbGdvrb pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc8dbmfhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 20:23:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29PJneZg012739;
        Tue, 25 Oct 2022 20:23:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y50a4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 20:23:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYLevTLqh4Ae05tZK3SMY4e6EAGeVhAigKpEjw6+STp7+kVcgMFW5EPuiJwN16l29m469YCJCYFJCBVLnMKQBwebF1J+PcaySvDXpUKb+XrwKlzi5U3I69mK2xtSjdFmWAvkQy9BorvaZNcZbqIDIeA7nR/hs8JQ9tHNB5ED6nJdFf7gexSSaMS19Sbob/bz0XmlB37FNuUxpfLv54ICnbn84T/5L1eT1i1/GknSM52pZ3Nq7L2tDvXV8BS/AHB6UEslJGQO698g+u4VZslASPq9mhfvf8SEvuXAP+b+1upDzmG9EZB7MDTNEONKQ4j1F0u037VUq9+HWxZLCDRm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgaqK2CBxLuiIVsatbefuH6vooOASRU0EQwiLtFylvE=;
 b=chcKjUfZ+8S5rHkjtMGzocMX5+YVZRHEzSlvgkgJYe8jjJRoIWXDDoaoTK7eZXWZ+F3KSXn7ZP+RxN2A4cV9xtjqthVk4oyyFllgcSShx+cavZh8PAsiBNivcmaB9RwrJ+x1hnromBt5JqXPI/gIolZPPS0KMh09HudDRlIxhcb9KeLBYU1jJWP/mf1qvmXxT8G/sRKyUIeqtIGCesO+pvBSRDymMmp5FIbTeKhIVqpul7gXyAKvMhEK4vRfNPwcYDn/I6El2mPp7TwQ4HnTAVrCpL/UsfKxs4fHYYeNP9yKU1nN3U86xH2WdkNvC2r6LdB6NqMq/70388w0lY0LIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgaqK2CBxLuiIVsatbefuH6vooOASRU0EQwiLtFylvE=;
 b=UA3HMSMXj7/IrTVtIfLQYogTcPh4OZdstydaPeV1cQY3tpZSYC+pNB8TEAMkexF/qxAbIrl+RW6dPLmp98rM4QrJ/pAcjjp+4AILAAHW0crX+Io1oaYsCqnk5iw9u8z13HAdfSflh/OaZNkWYe/4uJLhg/KdaseEgYD10kzJIXo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4227.namprd10.prod.outlook.com (2603:10b6:a03:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 20:23:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 20:23:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Joe Perches <joe@perches.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] maple_tree: Update copyright dates for test code
Thread-Topic: [PATCH] maple_tree: Update copyright dates for test code
Thread-Index: AQHY6JhxlS23wAlQEUOvY7yAFvPva64fZ+SAgAAmGIA=
Date:   Tue, 25 Oct 2022 20:23:13 +0000
Message-ID: <20221025202305.pyzau7vzvkizqbir@revolver>
References: <20221025173709.2718725-1-Liam.Howlett@oracle.com>
 <8d8a291b5237750827d6847b29efde5b750a28f7.camel@perches.com>
In-Reply-To: <8d8a291b5237750827d6847b29efde5b750a28f7.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BY5PR10MB4227:EE_
x-ms-office365-filtering-correlation-id: eaeba142-393d-4a9b-cb5f-08dab6c6bde7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QIpHQFxjHquNBsNKEro6alezfjmhc+V1maqeg+YmwylPqqikzdlt5f/T9YO8SaecZQyQbp++Pc4znIHB7jxmfLfpdddPrYJDjtNg9f+vlDIxWsLrUGVMecWI1Xk6ObZmH9AA3BVlgloxhikNQoVeKTNpIwt9GcPYk+RahpF3Qo1CGF/lM3lygPT7OYdVc/dhriYD8cHoQ1zDEkvZCp7xFU1u7RhIhYzLEnrVTH4UrBb8kaBkPniwtpNK9f8I5NV+ZiAZ5O5e8gD/1xdKb4tkJDEN2z7pFRvHnglaqRIE2iKO631hT/fmDcEu2oXCG4V4sAYUDruWZuyuBnt9j4ypHpdlgGGF7gd3TPsWboqlgHYCJ4NHjFlm2F+KFhh610OCS13ATbFM6GUN/3Z/QUbQJZudLkdEuLt1RNhVcJaoHT9N6uA4aO2Bd5ttLsgm2E6nSVxmat2p1bUcM2tdn2mT4MTDa3EFOKVjkJLJSw5GYVroulDwh4jJK8x2T1fU7BJrezHiVPSeGqkDkDvPCJqVYt0mnxrcJJgHamiesuAUMEJlpjUuJkwFZmV1gG3VRgo4VCDesMC6SZZm8GNlljXDtsBJ/KD1P9BPkfOKjal0xpxOXmrCt4Bzv3dgDCIxMg2oBX/IXoIJI5jFUE8VEC5IBC8tYDSeUCQrmuuH4synyj8rO0/Ph8TDqdR3P3cIOMkI3hUNGMgcYvO7xGDcn6hhBaIZF3HZPDZsC2ckmXOxhoJG1tS0X6F+rTY0YdWLP8O1Q3Ya6YBsEjd4ibGOSbVKcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199015)(71200400001)(86362001)(83380400001)(6486002)(478600001)(4326008)(66946007)(66476007)(66556008)(64756008)(8936002)(76116006)(26005)(6506007)(8676002)(6512007)(41300700001)(5660300002)(9686003)(6916009)(44832011)(2906002)(38100700002)(122000001)(1076003)(91956017)(186003)(4001150100001)(54906003)(66446008)(33716001)(38070700005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u31mI4OIUiU0uU+KPiMkAAGVg2lfZq69cbnXGicp3OI92ICLivmxSjWZmcg7?=
 =?us-ascii?Q?/DR9Vnsqlig0U7ncQRd/pmxQlAbKAynAQOUUz9UNUnia0zZUcJhq+3zWiLjg?=
 =?us-ascii?Q?WD+P7/JhCE+dLon06IvbY3PgTlJ85aFFy6nsIt0zcJsQZXICuSoT7HEAtfgJ?=
 =?us-ascii?Q?L9yetOYILRhXxaKKliXkzRBbuzT39D9CAg/WU4MLegv7MQdimVWxaZxTplMs?=
 =?us-ascii?Q?iQjrSChCZycrdA6M39BLVsdLsG+dFxq/G5sIbPR2wNMaG8/gMyjsQgEn6+zE?=
 =?us-ascii?Q?esLNE8CdFqDWYW2g1DnXoxeK1FqDheLS4Ogu5vCrN6tWNlrAWTS/kWqxsjHc?=
 =?us-ascii?Q?H/gHG5eCUbguWlOxhUrBOh90wiKQYm+NRpAAgf9HaZmdTWbFk6gj5fHEOCAj?=
 =?us-ascii?Q?gqhCrvRlExR/P2FQTLln+7fneFrLnC2y3cK4bb1uUhXbp9O7mKvs4D2V/bp/?=
 =?us-ascii?Q?pOn0IBIQikI+pgpoQ3C4GbAqwqFlukcxJvOcXJqVBphcriAK2vD2ayHxNqCR?=
 =?us-ascii?Q?1wua+MrPFXrZ7NIc0uxUpcRg6iGX7QcmjkfXY+mxclnI2TQTR9JI4xujOPsB?=
 =?us-ascii?Q?zH/DJh3WshCUgd7yjA4hj/3fMIJjqWmwoUUuAGP3TYO2tivvsz/leLigaXbg?=
 =?us-ascii?Q?j5SrpmVpPfyUujrwVHC7fXLNgf+3oErOx43C9KlB19kf01Sw8ojenqTXWmTI?=
 =?us-ascii?Q?NBI2ZrAmYejcNmg5chMr28wpbtQ5oT4gb5iuQc66k1ubRUL3FjZBUpV7I5Fu?=
 =?us-ascii?Q?WZ/QGW9495VIJLrB3D7HPQ/8gUUQOUsGAYSwaxSIjUFCD58UO4cOZiuMySKU?=
 =?us-ascii?Q?Zq0jsPSfKn3qjJPfI/6cTUBF6nh8IlXtnCxHugYObatqwUAeu8AhCO7P94R4?=
 =?us-ascii?Q?uF3Xe/wPiSvNQF+1NwfJ/BuZuWh9GviqRCGxZXy8cNDaKWkG24MxUeBHkTIA?=
 =?us-ascii?Q?dNO+nE0xoUq3bMND1rUhmKJctPEo8ELSBpBAPXXH/10J7MkW6jFMZUybsAy6?=
 =?us-ascii?Q?wIT+aras1ThPz23NXwru91Yd/SkAmL/qkx5Ei9Tq+AAGm9cfn/UupeQF3EMa?=
 =?us-ascii?Q?lZtMkkG6AXM5/Li0jkrejp4nGn6kUKE5BiIdMahX4iEgX+oX2SHzlG8HDTqi?=
 =?us-ascii?Q?CF36FDdsPZNXk5lAq7WWjX/jG5oXMHw2lWdMKRXAQQONoSMxPwZjibjWsHwL?=
 =?us-ascii?Q?gpgjbfWmQ7q3S5LPm//94Rh6siChzl4YGVDLf0Kx0vMs6yvABJPnHTEP0IkV?=
 =?us-ascii?Q?IYGPqm+RgtvSriN2qA0x4gOTytreK50NUR/Oak6OP8s1ET0gKZMV6j94nmvl?=
 =?us-ascii?Q?jBemDKVq/NWvz7dJzegcvNHIDVO8eE4CI81L5uMF0ATlA0BFPT6dKtmtswx/?=
 =?us-ascii?Q?lQmGzBps4k0j/MU/d68c8EwUOep1ZtRCnFOBScxaPeNtWcgNYpH0xGKvUcr9?=
 =?us-ascii?Q?OF8/ra6QFsLQ350ALp6si39/BJtp5HazEoUC1DU3+JaXG+UFZtreKYGZE6/M?=
 =?us-ascii?Q?jEAjN8O5SlITCCCLCCBf89dHnHjAgWctnCDqiFeSVVlsBOd2TWpWwWTz8AmZ?=
 =?us-ascii?Q?2V0Fy/UqlyLa31gH/ZpDeEMOPr8iSjUSpksYmZoCxjoqHfiL5q7egLrG04Hf?=
 =?us-ascii?Q?jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CC4CA8946139494795C0AAC560049C74@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaeba142-393d-4a9b-cb5f-08dab6c6bde7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 20:23:13.1898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NonGhhwh04gtsMqjPEBQg21E+TuejL3qPLOsFa2gsOoTEtMN9nxixYKovAh2Cm6UTIZNYitd5ZdLfjS4bRbyFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_12,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250114
X-Proofpoint-ORIG-GUID: uOvcbILxXfkxWNj66wL5gb5PTJMl6e6Y
X-Proofpoint-GUID: uOvcbILxXfkxWNj66wL5gb5PTJMl6e6Y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Joe Perches <joe@perches.com> [221025 14:06]:
> On Tue, 2022-10-25 at 17:37 +0000, Liam Howlett wrote:
> > Add the span to the year of the development.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  tools/testing/radix-tree/maple.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tre=
e/maple.c
> > index 35082671928a..3620c9e5f7c5 100644
> > --- a/tools/testing/radix-tree/maple.c
> > +++ b/tools/testing/radix-tree/maple.c
> > @@ -1,7 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >  /*
> > - * maple_tree.c: Userspace shim for maple tree test-suite
> > - * Copyright (c) 2018 Liam R. Howlett <Liam.Howlett@Oracle.com>
> > + * maple_tree.c: Userspace testing for maple tree test-suite
> > + * Copyright (c) 2018-2022 Oracle Corporation
> > + * Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> Confused here.  Who owns the copyright from 2018?

2018 should have also been oracle on this file.  Note the email
address.

>=20
> And what happened from 2019 through 2021 ?

Development continued which is why I wanted to extend the date to a
range.  I also presented the maple tree and spoke to a lot of people
about it.  Also a pandemic, I hear.

>=20
> $ git log --stat -p -1 54a611b605901c7d5d05b6b8f5d04a6ceb0962aa | grep -i=
 copyright
> + * Copyright (c) 2018-2022 Oracle
> + * Copyright (c) 2018-2022 Oracle Corporation
> + * Copyright (c) 2018 Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20

Right, this is what I am correcting.  I'm not sure what you are getting
at here.  Did I do something incorrect with trying to fix my mistake?

Thanks,
Liam
