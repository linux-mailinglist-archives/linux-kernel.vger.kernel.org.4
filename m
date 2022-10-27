Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CDC60FF8D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiJ0Rtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiJ0Rtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:49:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF509E83
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:49:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RHmpeN001412;
        Thu, 27 Oct 2022 17:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Lg4Tq0IRMyw8eR6FuTD1yRWQTc/5gQmKLYd4rJtMuPk=;
 b=3IO+DzMdty8SDsWO9SqzbJ5z2ijitqS8bPR0Yn7p/zpojq80oDM4hzJKJiZPINvZ9rvY
 wrgTOtO/7EETTh44sNrQBj0ZXByO0vcNFVH3ym8Mk11H32lg1AnmrL/xRHAr8SKXmtuf
 9bdpNUG4xBBKTaeeXnuVDVumGpT/NCAyOJft9kK7gLbjXEe68mMF0KvY1gX0CxyxOX94
 7xEUraPHwq7MzaRUKSuVX6XH3AQxwDnaNI0DcnrTdxdHsGHr1yp8KFUhUS2gA70BsQ8b
 vGTqBMCd4U12CKFuWrvJU3WKgiEyXVuzZGxxGW6C/pFOYZ8TP73gdhhv3BDYwRiS6YfY 0A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawrtvgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 17:49:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RG2xiN026553;
        Thu, 27 Oct 2022 17:49:10 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagq87mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 17:49:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG3hdf7jqVbiiUAgo8NiKXqX4I91F3hGMesk+ycFcewY6UW+vt/8qByN06rcDKvE3VebV8YD5l76nF2Yio1r+9RziTRg3tx8+4WhFAWHNtXzbchWMxnwkUfaWeE+yUVKbF0rUIT1ODdCipHUmnqkrV7GXW1+5zDWovuv1DgAisHNlwTZkzzbCxLKqNhgfYB/jdpKBOZJauFfCT0xA/TemujyJ4hudIFupBiyga1hVVOF+38TBPj8CQAJK4fshKid+jIqt+cYUbK1F7ev2mbJ7GRxFnQ7vtVSuYwU7MsK1gXSyt6333pNZc6aq2fvfwXi1woQcMI3wb00gQdGrUHr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg4Tq0IRMyw8eR6FuTD1yRWQTc/5gQmKLYd4rJtMuPk=;
 b=Bs5yseefc+CaV1REyRKofWP5gMdZIiS+j1OmC0sWOlzu3MkRmUuyf6aXtKBcbgRIEsR8re97eeGhmv/5ztQKxQVa6AV+0qmK66lRYqCAC4ZzIWLOSKzUA6Fs1yGk7jZNS6pW/XT5WDvpFhO/zasxEmGPaZhVPr/4ar56NkyovZ+EdOqpt6f9lvgkN2n+H+C8vGooP17BBpEqZc+K3ULdg1Q1ED24/Im2QnZyCkve1tXJuTmlnFLvLl2HqnSuxG8t/ZDqTwLALyMyUNaYuLd57jWSvucWXm2hjfzRH24rPUQW6vdPWTYOLwNI3P2yHTeyG2rRmYBTHRs0vecD6Gv1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg4Tq0IRMyw8eR6FuTD1yRWQTc/5gQmKLYd4rJtMuPk=;
 b=fux387cfJH8gws0gyA1yckD0IWCWkbepn3ZRZmosPP8eMOuk2SHTBbR0kgcd2UA+WInYVLf1qyNDd6oFxL0OijZJmmBNj2wJTwblslzg6Y+N/pd2Idxftz9ix/Al4gGtZeYC0PLKybftAJkIqwN4HqXREH8eGEIa8dUU4qUDjmw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5102.namprd10.prod.outlook.com (2603:10b6:5:38c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Thu, 27 Oct
 2022 17:49:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 17:49:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     kernel test robot <lkp@intel.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH] maple_tree: Reorganize testing to restore module testing
Thread-Topic: [PATCH] maple_tree: Reorganize testing to restore module testing
Thread-Index: AQHY6U7Gqbq/zvk7Wkezeap+J2Ws/64hSOyAgAE9QYA=
Date:   Thu, 27 Oct 2022 17:49:08 +0000
Message-ID: <20221027174901.glwsdvstiahmcufk@revolver>
References: <20221026152155.4041070-1-Liam.Howlett@oracle.com>
 <202210270657.e9evAcTO-lkp@intel.com>
In-Reply-To: <202210270657.e9evAcTO-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS7PR10MB5102:EE_
x-ms-office365-filtering-correlation-id: b37051f9-077b-43d8-e1e9-08dab8438c54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HiDlll6+Z7kxvCy5PmM1n6Jzu4adUiNEEUW9cnFJ2iwQP8MFt86zn/3Tad8IKKbUn0+2wvCVILTP8MwJIAxeK6tz9V2mhX3TApwa1HaJdkgYUG6YSe2nylXYP4tNusCzHaW8fTCA1gc69B8SX6m5tsUok3th1Zr979V45o4wwNjFzTHnXyRTKIqcCSTlHmJBukim50unWmgi46UDTykDOkA5u4+J4xBt8Gdrl3q4kJdgLP5rP+1bra+QP4fDWDz6s7vsICmpgXsjoH898i/Bs1qS6+RTGrLbDpmc8UnDAncakS4P2rals15BZ4i04GMZyPnLTDTDKurZ6YFbS/bqO7/bY8kvd2JRAIEZtIF7zJ5Gy868EcKIETLVRUCnJ1VPAY3xdmRtnycniAU9AuFDOg5wDGg55BNv754RhrWlFzL7VLSj4aMVRNoDCVM1BePy5UTTVrA7X6fn2/DSa2GhXjgyGzEPC4wWP0gC6sqem51/1Q7S8FIS5A+y/edZSWvEZ9Oy21rDQDzvHKUs76Um4cGKyb32KiBRgFjtPAh6Svo5SYI+IFwKkzh3NWC+dXCKy6CKrQDH1CrSzoyWj7fy+IWi9eyO/TNTPVFf2+SfaQErTeR2XA2sgd4PXGDv2HCFDH8FSlmRYctDVu5aG3EoNb4ILkun9K+gqrM8JfpAs1SUmGVclfo4+NPr/fIFHQgWjw9DE+wCJ4HoJOGtrqLrUHxoEqM29NhtLxJEAWPJtEaLI4sexy3skuTiIE2c+Vae8j4048lpzCLk9dCsnwSO1mcY59Gu2YlgH8paj7MVP5dEdxSHS0tJCRz3FQF/EXZWx3hWB3HzvHh2twUZP6ldwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199015)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(54906003)(6916009)(91956017)(316002)(41300700001)(71200400001)(966005)(6486002)(33716001)(83380400001)(38070700005)(38100700002)(122000001)(26005)(6512007)(9686003)(86362001)(6506007)(186003)(1076003)(478600001)(3716004)(44832011)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7AMDnl+63NlLYW5SinyGtxZ0YhDpSsQOwSYwAV3lZS1oSBwbuULClyFkQl9z?=
 =?us-ascii?Q?99V5Twu0kwbl8XoXZrkGMOvXUIpeCy+ERmmYQYJJ6JZVidTXf/yrvT+D2g9l?=
 =?us-ascii?Q?WlUQzeN6RE4nDlNOuxNdtgpmKn6H5FbvPCUOgY8f5n6NEkPwCRgJqzf9raU1?=
 =?us-ascii?Q?gO0UbabImw5KrY9Iiy/fpC8KO9IuP9qH8XKLSW4ZacBP51bRndc2mLWxuE3x?=
 =?us-ascii?Q?lCndMwT9kUJwmHFBWeqrLFGA/Dv9u3rQnp08zU1R+0rCq6/4+7T7oerMFWOm?=
 =?us-ascii?Q?2dsvm7k6WLP9Yfo3mAYDbx6i6QqsVgR7CkTe2RxY4KZ/x89v/Ehd7UpDg+Dx?=
 =?us-ascii?Q?vIRjIyKzHvfBZOt4VLUE+xaOBEnQDc7ek4Q+qvxTmgaV2lJeUMqr1RXtjyV1?=
 =?us-ascii?Q?UtFqQOUpygJhHVhWsUHhgz2Kzwn24ODGgBL4IspnVtsBGBplkI1rJeTPkf3L?=
 =?us-ascii?Q?xY0HQZrEKYIIc0JxZatKKsFL+XMCoHiZGv6xsemQo+g8Hrsm95sXCMm0nbrk?=
 =?us-ascii?Q?LGhudSo/Rnu886YfmrYGd7DwttkeOGFc/Qo6eYiv9pbVbf+2Z6z8t3ZdKwNx?=
 =?us-ascii?Q?rIvGhvQNa3+Y4cE4mlwlFi/DUj5azeaUJGGeR/Kuwltnejvs/v7hKhG+IWdr?=
 =?us-ascii?Q?TgQaXoDvQJesuRawJcEQbLmkK6JyWoUuRIOJYtf45CAKCoTZXQhyMB/Fk4Ye?=
 =?us-ascii?Q?iyIQELxT4JnpluJimHb38UL3k4hR+WVYRQOmYosjV4mibSfmOFou6ksgvg8e?=
 =?us-ascii?Q?hw4DX1fo4ZpEeixHQn3YYwXoXD9I2a5leobTZVTAcx5YFjbvZOkedM+lfCnE?=
 =?us-ascii?Q?GThzz7Cfaxj/kvvVQntM+iTNRoZtQmfa32hBbIVSME3YcOJhz00ztAtMge9I?=
 =?us-ascii?Q?qg2Z3wvwXMoaVgYTIk31keZ3Pyr1SwLcAJ+gsQ8Z9Rvrt5hjGwgWeuY305jS?=
 =?us-ascii?Q?B2pQzO4fdERVzn6krOPO3QLATIGhyhafOJZuVHXu/PhAlQg40h9YyacuSs2O?=
 =?us-ascii?Q?wrSa2JiIIzYRQA+2jwqAIxLbHyRD0iMVntN0Q03sw2FBgYY25uMBYAx4GYoR?=
 =?us-ascii?Q?vTylRpwQAPu84dQJdagktpU/S7ZuPhPCUI1ILn5VjmN3hffaHFsMOV0iAVgj?=
 =?us-ascii?Q?OH6qEM7TWH8fI9hJTqv4zIGVw/xRnJAnEc0dKHUq9/QSGfW8vJhq0BC6NCzG?=
 =?us-ascii?Q?bO1fGgiCAl4uBkT12ebSvKv0MwA51+BkbSw48L81qztxO6z6LIQiLs6Vc4XX?=
 =?us-ascii?Q?+S3OA5NqG49kGnWaaCcM45W4j+O/VzMhl+C/Mg+lCA6c281dQSriaov9KuSB?=
 =?us-ascii?Q?wldDzbbS02waClXZduo5MWuDkZGD6nPUugHAqerxCw+OaEpnDfL58M0LPwUk?=
 =?us-ascii?Q?4hFn3lCLCTeBGJsxEyS5/cmQPV0OltT4AKEfN+HtBwUX0BSP9AkwIIGkAYNc?=
 =?us-ascii?Q?FEdMAz07YLcU2EAz3qPsCHd2buZWJvQonLbqAK7DhpV7qdzL3WQF4wzbqLtz?=
 =?us-ascii?Q?KsFkAAGQhWpGSl82Ov1Zsa0Jjcz2x7y/QprVl1sKNbhEgg5SX6AQWwFH1hsb?=
 =?us-ascii?Q?Q94Y8iV7Lg4sCfJv/0bNxxr+m65zhytM2W67yhWmrLrjtJOqu5ZbXUzjQBqO?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <175D5501AD5AB443B4F1E20E35F15B0B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37051f9-077b-43d8-e1e9-08dab8438c54
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 17:49:08.2414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cob6vcEbJknchewewblzBICcaGKCLudvnoSO96oPTkxEqS3TqP0hkM/FamriyYn0giKABfQPLWjIqy8IlzjcIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270100
X-Proofpoint-ORIG-GUID: MWEwPXQkTgrCq9t8GpzzQ_1vsiG4Mp5y
X-Proofpoint-GUID: MWEwPXQkTgrCq9t8GpzzQ_1vsiG4Mp5y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel test robot <lkp@intel.com> [221026 18:54]:
> Hi Liam,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on akpm-mm/mm-everything]
> [cannot apply to linus/master v6.1-rc2 next-20221026]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Liam-Howlett/maple=
_tree-Reorganize-testing-to-restore-module-testing/20221026-232537
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-ev=
erything
> patch link:    https://lore.kernel.org/r/20221026152155.4041070-1-Liam.Ho=
wlett%40oracle.com
> patch subject: [PATCH] maple_tree: Reorganize testing to restore module t=
esting
> config: s390-allmodconfig
> compiler: s390-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/253dbd44dc3ecb69f=
595258bca126a7a2a2cfbd3
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Liam-Howlett/maple_tree-Reorgani=
ze-testing-to-restore-module-testing/20221026-232537
>         git checkout 253dbd44dc3ecb69f595258bca126a7a2a2cfbd3
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Ds390 SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
> >> ERROR: modpost: "mt_dump" [lib/test_maple_tree.ko] undefined!
> >> ERROR: modpost: "mt_validate" [lib/test_maple_tree.ko] undefined!
> >> ERROR: modpost: "mas_walk" [lib/test_maple_tree.ko] undefined!
> >> ERROR: modpost: "mas_store_gfp" [lib/test_maple_tree.ko] undefined!
> >> ERROR: modpost: "mas_empty_area_rev" [lib/test_maple_tree.ko] undefine=
d!
> >> ERROR: modpost: "mas_empty_area" [lib/test_maple_tree.ko] undefined!
> >> ERROR: modpost: "mas_expected_entries" [lib/test_maple_tree.ko] undefi=
ned!
> >> ERROR: modpost: "mas_store" [lib/test_maple_tree.ko] undefined!
> >> ERROR: modpost: "mas_destroy" [lib/test_maple_tree.ko] undefined!
> >> ERROR: modpost: "mt_cache_shrink" [lib/test_maple_tree.ko] undefined!
> WARNING: modpost: suppressed 26 unresolved symbol warnings because there =
were too many)

...

I tested this as a built-in.  I will resend this patch once I have made
the necessary adjustments for the module working.=
