Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8E161DBB5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiKEPlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:41:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE98CE3D
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 08:41:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A5DXKhY015609;
        Sat, 5 Nov 2022 15:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Eboxik/8w+VXlgNm1Uq5NBRsstIRucrhviczN/MCKhc=;
 b=Jfe/hFo02SESVLoGI50z6kCVDF2z0KbRqA4GdKg52HWMxpyLv0gDjrHGBZnxHaek9FTK
 X5u09dZJD8csSIyDflbwUAT6BXYDLLnxT5wVLwjdafbUrANPa6MNAJ7yiVtpbaQO9MZJ
 pSVLUginICnS3YWUnSQ9Nkl+LE2ykpuZ8gxPZpxviunIBap9uitU4ggEZQx0Eugvjes2
 g50xSL/T717rY7FqZBeIel+vYrNpbvCdkKUlKsncP82lVYeTj/eF6SIL/kjQBLQrHpZ0
 niS0G/x+1UDgbopJ9nmh8Fo+CMu242ZI0XPJPQ4T00W6TPRxbKEljbzA6J0VvNLiMgOS UQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngkw0jeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Nov 2022 15:40:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A5BF3Lm013609;
        Sat, 5 Nov 2022 15:40:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kne92369w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Nov 2022 15:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IC9f5C++hi+xuCn538tIRCBqKFd2egulormdG8EO6p7TUxIbXWr32wZnZg2tx++xh/EfusMCQDznUvoGjLoT87TF1AYeTp95jupN/XM0+XGqqh4aF6oOTaN9AcBLfr6rJwfi/67MoI/1JOXOnVSA0ge7R8EsdR0NoLTMD/wb8fj+D0ZaIeL2c8PM0SoGISd/XG3NJEzb8KdtWwpV7l894Xv+l0hgMk05exzl5O3DP02Saunve4pM9ZWeMEnh/tcDPdi1A0qNtlIb5c7AEjq1L+7HpnlTCnLq6/mjsZVXtt4qjDi67wHA0T+SsBvl3GK4yflELMuOQhXgbUN9GF2j0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eboxik/8w+VXlgNm1Uq5NBRsstIRucrhviczN/MCKhc=;
 b=MHbQjVmNNl4aDM/czPyvG6dVBxoRVRDtRMcOYvBR1S7AQzhNUuI7xWCTcTmmPJCQl18fGPt9cpeijD+KGND2FqX1bvoNRVnQEkDL7TmA5nY4bJ1TBovb6RubtPn/Q8Vo8hntEnvFVxOfKJtc+kjg7eboMyG5Ekm9AkyHm0OTVPpn7uZfnA2b2uWFwv9YG7Gl9u+3t9rAJssMF38cDqYb5x8CxrRuytUwAGB/xkAsPlFbTkMvOCQxxonFveWNWXuVuW/IkMUKeRVPm51Hs6+rk+PAvUKSuMfATf0EgEow+WbUvKDmHdQIj5gMKlnLDk+R0U3ADrJXLnLoV5T1vPAq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eboxik/8w+VXlgNm1Uq5NBRsstIRucrhviczN/MCKhc=;
 b=C+tpanoDy3Do5M2AsjAH4fQkvkNGyqUVYq/uiM5KeXIVtOEFUh67aRCorSfausdkkwIB4zu4xTYEkLh82kIiASaCUDaIiQfU+yjvCTU7cXW1yd+jtnl8pWvAktfWpL6ZO7OhOs/Dh1GcmLsTEJINvqmekdKfw3okPL68YD3fjtU=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH0PR10MB4629.namprd10.prod.outlook.com (2603:10b6:510:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Sat, 5 Nov
 2022 15:39:59 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::e208:8886:f6f1:ab09%7]) with mapi id 15.20.5791.022; Sat, 5 Nov 2022
 15:39:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Carpenter <error27@gmail.com>
CC:     "oe-kbuild@lists.linux.dev" <oe-kbuild@lists.linux.dev>,
        Jeff Layton <jlayton@kernel.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fs/nfsd/filecache.c:1118 nfsd_file_do_acquire() warn: passing
 freed memory 'nf'
Thread-Topic: fs/nfsd/filecache.c:1118 nfsd_file_do_acquire() warn: passing
 freed memory 'nf'
Thread-Index: AQHY8QhAgfUG5bljWk+vlS5eU1Ez/K4wd6cA
Date:   Sat, 5 Nov 2022 15:39:59 +0000
Message-ID: <6F00D08C-6D94-486A-A3F2-B11C9FF5E9E2@oracle.com>
References: <202211051543.2bnSgTQW-lkp@intel.com>
In-Reply-To: <202211051543.2bnSgTQW-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|PH0PR10MB4629:EE_
x-ms-office365-filtering-correlation-id: 0c410c9f-44e0-4e3f-99a7-08dabf43ff68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ixpiHvx2Cjd7x0YhHEnPWXqjXzN7/HUuACN7bWq3XBmdU/4zXEVRJY9TY+JbJz2t2HqX3HRzlOMSDq/5NOSpGUPZMj/UvvlvNQdmzYbNXSQ9s5+UbMIcyeEQpMWxr1SNac1WLtjaTfk7q9hhnI5UUbWYQmfz3iLBXAx5DuQP/jytiUk7i55I2R9o3+xyxUOOYDwfpW2cLhkpzLGuhqVPgjtnlzKlfdsFw/+sQlkY/3Nj7uakJlVPu5oOMQsKUSlJBCZq8tDOJwpY+8hfoJ7yI03RlKSMbkGLZ3AjzBt93T4YXVBxcw3GBLol8CUyfmbq05NsJnPm8neF47yas53h1VCSYpyZ3NqwLI08ZlpXFKTIA+hKbTDAtQkTUNMTnkF8/ogOTohEWq4+mO7MscRJe0wIC+caFikML5XuxvpKLXRFH/kRWPjvhISMqvfbyTCSraHcUN8Nat4h7dT4FePaPtbqmEQlqGa+xd55jWE7z0tGZuAD7pBbAaPzmFhVtUdvRIhgFA0lv6hySQYgb33iJii/fCYunqiFbFkOzD4CwYONKhJisfdf6vVbo7RIEuuZBBpfNCOpZHpN9cb3MKmqfL3X5AiHLoFQ5FlNJpwM+KTYrNTJbkZSlzDpNzl9PLT+T8usj/fwe5qWVlDNzRNtgGEgd7ENfGVOrGSNr+8/3j75fhNF3tUNqYvmbRasXuAEXe1YsdtJF0JpX/gE0/SvX0FDfxM0NFWkW8ixBFEWqx8QAJgTJYezdSfasVnzt6AA0IhZ6bYJeGxjAc42vR3UOWiYhjKDrYe48iS6SD2OTnBottrcPhWeq/6ElnfoJrxuYZoNJGgT9xGK+RRGuZ++qJl76HfeDZOgneVuUPpZhHw1lYapJX2NCYPp2O7zthg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(6512007)(2616005)(36756003)(26005)(86362001)(33656002)(6506007)(54906003)(53546011)(6916009)(186003)(316002)(2906002)(8936002)(5660300002)(38100700002)(122000001)(66946007)(76116006)(66446008)(66476007)(66556008)(91956017)(64756008)(83380400001)(38070700005)(41300700001)(8676002)(4326008)(478600001)(71200400001)(6486002)(966005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CJvV8qiJK1Lfj1LirvKWvFNvmPpD0KQyYl8co1W9B3wFgKi74Tqprn2VOIKh?=
 =?us-ascii?Q?Tt38AX1dkFy6Ul9VlNMiGeR5vs8s6lq00Gnut9Truc+OIMgqE1N1OjuWgt+W?=
 =?us-ascii?Q?w91rACq/mThO/vxl3VYI6pm5bNIPj7m5TIwER1S9PoOdISexN8dgon1LRRHN?=
 =?us-ascii?Q?RuB14PPSJcJpaKotP7JxBp4O/GmIWC98pXX3IW+9a5qDT+tf2FlUd4Oxw0i0?=
 =?us-ascii?Q?o6XAwYXNxjx/XyJXdBwis7kTJmoLCosksbpXcMFy2hBQMGzQ9G8tNDnpgMOS?=
 =?us-ascii?Q?uXI2HIjfjt6+MvuXsXhn9IMob/isSSfjAX3Xo5gq/e9KCt9vvq+1G+jH5gQS?=
 =?us-ascii?Q?l8UsatdSLglk9o2R89wxbj8Cel/lXobs3VKdiXry4qhUAG3Ue8IFkhXYYOjQ?=
 =?us-ascii?Q?kRofRrQmW23Sj37yU13R0JJAFAB6RHQN5IfuvNvfg4DCzPD4Ztj3fDnc9YOz?=
 =?us-ascii?Q?Z7T0e0QCxiGzv7km4F1HJiCOcuCzmW+AOYChE/YguteAFVOEiY001JQcdlhO?=
 =?us-ascii?Q?bqYcj2F/Y6EVco1mUzhheQB2bY6GYkFh7fhvXkPdz4DdhkC0oz6gnRgY7c5i?=
 =?us-ascii?Q?NPXUQcvfEY/zyQyNcP0QTkdl8ma6JDY9mt1LUm8pjFbyzCz9UMKH3SCv+4Ew?=
 =?us-ascii?Q?Pn7P6Ud8QyxTAJ/xsBOgkbCkUvXO8bWQwGILpKeLcOCegfQEK3a8SCUMEshJ?=
 =?us-ascii?Q?JdQNFV/3j2GJk5fdE4v+urcAN52H98EiL0ViRmvL/VsU4BGtCctj9Clfvqlt?=
 =?us-ascii?Q?DmpEl9Rsu/G4g3mxKWbK19Yiiz2mHP/8l5z0VDkZ+zx66GeX9N1ZEV573rBq?=
 =?us-ascii?Q?7vrhc5yfT2d0rwrrFuvNqrYT8iVVXsBSLO6ezrH7cVVxBMa8ttDqKm6LhsaK?=
 =?us-ascii?Q?hlVFznKtigjva6NDwqSD9MTabxSDnf43u+fU9Lc19FIUZE6t8leZL8vXEKxy?=
 =?us-ascii?Q?Bzr7fjKWborigKSefH8VJBLYZIDDTZgQT5WCqML9//njq8rh4RI7p2Kw+/DB?=
 =?us-ascii?Q?ZVqsX0p20URzDn8rUHRNoBQPjQsLYOEEe0W0wIOxkWgrJzoJqkMLIKfjPgfW?=
 =?us-ascii?Q?F48X65YwJXnajjAV27iw7wuahT22X+8rcCoWTTYgP+psD03gxd3qYRzA36tJ?=
 =?us-ascii?Q?NcfnH7gZM+PJkXVeGlsXciXnvuynpUezm4R9+YsJL57PysOLWpsHfRaUs8sQ?=
 =?us-ascii?Q?6PpcFLyNSfJ1ZWyHX5QwEy42zk/9i5G56k2ZX6EvIu6skOgIPwy6h5re3mzF?=
 =?us-ascii?Q?80ScMv6nt2pv8l7xzD9kWp8KZwdLVa0iWIjIOagbNo12cwtXCA7MnvTDy37G?=
 =?us-ascii?Q?VDh8fS2onCnuYErCsNAUEhXO8/ApSMQLls+g+Rfx7NhW7Zf7E7RueG1CM5qB?=
 =?us-ascii?Q?D9yy3wOQMzSsX7cEgf8KkO3bPYVsssayjMtRSjK34XqY4GvJXiKskYeXh74J?=
 =?us-ascii?Q?hXcpJ0Ve/23SGgPDDakb/rZsBh+xvhpi4aNRAxIBi5JtzEQumIOE+1+Mn3gy?=
 =?us-ascii?Q?xHqXHBilePRhs3dmSV6JDeX51h/JvHbLJObaYH0xbLLeGx3anc4m3g5mdWTi?=
 =?us-ascii?Q?GR/0aMaO6foTu8ha1y0xMzNytqxhptb4/aDDmyffgPHIT3b/gm1UAIne8kaB?=
 =?us-ascii?Q?HA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F421BAED72F1464D88F54A47FA980653@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c410c9f-44e0-4e3f-99a7-08dabf43ff68
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2022 15:39:59.4637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWD5bfOznHFNDHw0w0PxVqeZFoXBtGZyPE1tIPbLy2/1gNk7z3SM0Yguui5JrgtyFFQ3MP3nrhomVzFnVoe8pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-05_09,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211050118
X-Proofpoint-GUID: T4kSSNc2umpjt2mhjJ16gIEpIhhtzUug
X-Proofpoint-ORIG-GUID: T4kSSNc2umpjt2mhjJ16gIEpIhhtzUug
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 5, 2022, at 7:17 AM, Dan Carpenter <error27@gmail.com> wrote:
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   b208b9fbbcba743fb269d15cb46a4036b01936b1
> commit: 243a5263014a30436c93ed3f1f864c1da845455e nfsd: rework hashtable h=
andling in nfsd_do_file_acquire
> config: alpha-randconfig-m041-20221030
> compiler: alpha-linux-gcc (GCC) 12.1.0
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
>=20
> smatch warnings:
> fs/nfsd/filecache.c:1118 nfsd_file_do_acquire() warn: passing freed memor=
y 'nf'
>=20
> vim +/nf +1118 fs/nfsd/filecache.c
>=20
> fb70bf124b051d Chuck Lever     2022-03-30  1036  static __be32
> be0230069fcbf7 Chuck Lever     2022-07-08  1037  nfsd_file_do_acquire(str=
uct svc_rqst *rqstp, struct svc_fh *fhp,
> fb70bf124b051d Chuck Lever     2022-03-30  1038  		     unsigned int may_=
flags, struct nfsd_file **pnf, bool open)
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1039  {
> ce502f81ba884c Chuck Lever     2022-07-08  1040  	struct nfsd_file_lookup=
_key key =3D {
> ce502f81ba884c Chuck Lever     2022-07-08  1041  		.type	=3D NFSD_FILE_KE=
Y_FULL,
> ce502f81ba884c Chuck Lever     2022-07-08  1042  		.need	=3D may_flags & =
NFSD_FILE_MAY_MASK,
> ce502f81ba884c Chuck Lever     2022-07-08  1043  		.net	=3D SVC_NET(rqstp=
),
> ce502f81ba884c Chuck Lever     2022-07-08  1044  	};
> 243a5263014a30 Jeff Layton     2022-10-04  1045  	bool open_retry =3D tru=
e;
> 243a5263014a30 Jeff Layton     2022-10-04  1046  	struct nfsd_file *nf;
> ce502f81ba884c Chuck Lever     2022-07-08  1047  	__be32 status;
> 243a5263014a30 Jeff Layton     2022-10-04  1048  	int ret;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1049 =20
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1050  	status =3D fh_verify(rq=
stp, fhp, S_IFREG,
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1051  				may_flags|NFSD_MAY_O=
WNER_OVERRIDE);
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1052  	if (status !=3D nfs_ok)
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1053  		return status;
> ce502f81ba884c Chuck Lever     2022-07-08  1054  	key.inode =3D d_inode(f=
hp->fh_dentry);
> ce502f81ba884c Chuck Lever     2022-07-08  1055  	key.cred =3D get_curren=
t_cred();
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1056 =20
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1057  retry:
> 243a5263014a30 Jeff Layton     2022-10-04  1058  	rcu_read_lock();
> 243a5263014a30 Jeff Layton     2022-10-04  1059  	nf =3D rhashtable_looku=
p(&nfsd_file_rhash_tbl, &key,
> ce502f81ba884c Chuck Lever     2022-07-08  1060  			       nfsd_file_rhas=
h_params);
> ce502f81ba884c Chuck Lever     2022-07-08  1061  	if (nf)
> ce502f81ba884c Chuck Lever     2022-07-08  1062  		nf =3D nfsd_file_get(n=
f);
> 243a5263014a30 Jeff Layton     2022-10-04  1063  	rcu_read_unlock();
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1064  	if (nf)
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1065  		goto wait_for_construc=
tion;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1066 =20
> 243a5263014a30 Jeff Layton     2022-10-04  1067  	nf =3D nfsd_file_alloc(=
&key, may_flags);
> 243a5263014a30 Jeff Layton     2022-10-04  1068  	if (!nf) {
> 54f7df7094b329 Chuck Lever     2022-07-08  1069  		status =3D nfserr_juke=
box;
> 54f7df7094b329 Chuck Lever     2022-07-08  1070  		goto out_status;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1071  	}
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1072 =20
> 243a5263014a30 Jeff Layton     2022-10-04  1073  	ret =3D rhashtable_look=
up_insert_key(&nfsd_file_rhash_tbl,
> 243a5263014a30 Jeff Layton     2022-10-04  1074  					   &key, &nf->nf_rh=
ash,
> ce502f81ba884c Chuck Lever     2022-07-08  1075  					   nfsd_file_rhash_=
params);
> 243a5263014a30 Jeff Layton     2022-10-04  1076  	if (likely(ret =3D=3D 0=
))
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1077  		goto open_file;
> 243a5263014a30 Jeff Layton     2022-10-04  1078 =20
> 243a5263014a30 Jeff Layton     2022-10-04  1079  	nfsd_file_slab_free(&nf=
->nf_rcu);
> 243a5263014a30 Jeff Layton     2022-10-04  1080  	if (ret =3D=3D -EEXIST)
> 243a5263014a30 Jeff Layton     2022-10-04  1081  		goto retry;
> 243a5263014a30 Jeff Layton     2022-10-04  1082  	trace_nfsd_file_insert_=
err(rqstp, key.inode, may_flags, ret);
> 243a5263014a30 Jeff Layton     2022-10-04  1083  	status =3D nfserr_jukeb=
ox;
> 243a5263014a30 Jeff Layton     2022-10-04  1084  	goto out_status;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1085 =20
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1086  wait_for_construction:
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1087  	wait_on_bit(&nf->nf_fla=
gs, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1088 =20
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1089  	/* Did construction of =
this file fail? */
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1090  	if (!test_bit(NFSD_FILE=
_HASHED, &nf->nf_flags)) {
> ce502f81ba884c Chuck Lever     2022-07-08  1091  		trace_nfsd_file_cons_e=
rr(rqstp, key.inode, may_flags, nf);
> 243a5263014a30 Jeff Layton     2022-10-04  1092  		if (!open_retry) {
> 28c7d86bb6172f Trond Myklebust 2020-01-06  1093  			status =3D nfserr_juk=
ebox;
> 28c7d86bb6172f Trond Myklebust 2020-01-06  1094  			goto out;
> 28c7d86bb6172f Trond Myklebust 2020-01-06  1095  		}
> 243a5263014a30 Jeff Layton     2022-10-04  1096  		open_retry =3D false;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1097  		nfsd_file_put_noref(nf=
);
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1098  		goto retry;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1099  	}
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1100 =20
> 4a0e73e635e3f3 Chuck Lever     2022-07-08  1101  	nfsd_file_lru_remove(nf=
);
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1102  	this_cpu_inc(nfsd_file_=
cache_hits);
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1103 =20
> 23ba98de6dcec6 Jeff Layton     2022-07-29  1104  	status =3D nfserrno(nfs=
d_open_break_lease(file_inode(nf->nf_file), may_flags));
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1105  out:
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1106  	if (status =3D=3D nfs_o=
k) {
> 29d4bdbbb910f3 Chuck Lever     2022-07-08  1107  		if (open)
> 29d4bdbbb910f3 Chuck Lever     2022-07-08  1108  			this_cpu_inc(nfsd_fil=
e_acquisitions);
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1109  		*pnf =3D nf;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1110  	} else {
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1111  		nfsd_file_put(nf);
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1112  		nf =3D NULL;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1113  	}
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1114 =20
> 54f7df7094b329 Chuck Lever     2022-07-08  1115  out_status:
> ce502f81ba884c Chuck Lever     2022-07-08  1116  	put_cred(key.cred);
> be0230069fcbf7 Chuck Lever     2022-07-08  1117  	if (open)
> ce502f81ba884c Chuck Lever     2022-07-08 @1118  		trace_nfsd_file_acquir=
e(rqstp, key.inode, may_flags, nf, status);
>=20
> Passing freed pointers to the trace code is a border line case...  Not
> sure if we care.

Speaking only for NFSD, let me echo Jeff and say yes, we care.

In general, I think Linux users/customers and of course our fellow
sustaining engineers want to feel confident that enabling tracing
on a production kernel isn't going to result in less stability.

Thanks for the report!


> 65294c1f2c5e72 Jeff Layton     2019-08-18  1119  	return status;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1120 =20
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1121  open_file:
> b40a2839470cd6 Chuck Lever     2022-07-08  1122  	trace_nfsd_file_alloc(n=
f);
> 427f5f83a3191c Chuck Lever     2022-07-08  1123  	nf->nf_mark =3D nfsd_fi=
le_mark_find_or_create(nf, key.inode);
> fb70bf124b051d Chuck Lever     2022-03-30  1124  	if (nf->nf_mark) {
> 0122e882119ddb Chuck Lever     2022-03-27  1125  		if (open) {
> f4d84c52643ae1 Chuck Lever     2022-03-27  1126  			status =3D nfsd_open_=
verified(rqstp, fhp, may_flags,
> f4d84c52643ae1 Chuck Lever     2022-03-27  1127  						    &nf->nf_file);
> 0122e882119ddb Chuck Lever     2022-03-27  1128  			trace_nfsd_file_open(=
nf, status);
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>=20

--
Chuck Lever



