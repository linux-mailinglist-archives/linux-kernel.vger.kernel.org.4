Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6848E64BE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiLMVFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbiLMVFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:05:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDB42181A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:05:12 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDL26sg023773;
        Tue, 13 Dec 2022 21:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=me4O0jDsHr/o5bSCPL+M2s1lY6UrcxVieFNMa+/b43M=;
 b=Kt3mrEm+abqs+2AIqnNykpzz3GKLXT4pPb6rwW8gmsWkAZi887OavwJm3aaXev8C9RSY
 6AdlB6ybH1F9F59g9Turs9Eylmnded+EjXDn5X3/QOgu25bLe/MZYykRYht6O8tfv6c+
 n3ePe6TLXChDk03Q96C2P6X7MbOFfo+EueS/wSDEgXsEUkdt627kDNJTRdo4pztZ7N3N
 wZS+5HdbxX2Igv5MW4izrx6/GlAU2HiPRYWH2r9ZrsZNIFyvl3nZBy3xdLpNtPCTl7TA
 6h6UfhQ5nZf5znZvGGqJtjtfUd0LU2CP1/h5/bEdXrKQ0QqvIiCnMknZcEw2Bu6P/Zv/ GQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyewr8fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 21:04:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDJIeeA037265;
        Tue, 13 Dec 2022 21:04:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyek4ya1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 21:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baKFTscUUD8TBQ9nDlHwKQt+dd75QwYndIG2+NJjcn4IQjHAibabClL1Ygc+G3DJUASd+u481AlmXvb2AmISx+iBuyPF9/L0k0/a0lwEhiTnn8LyLG5aDNejceneFTeHTlZilJqUxATY1B++sS9zTiDgEerrRok1VO16yo47KVyb9G1avVuoppOzR+5qe0th871hJP4QKtUedPuQoQN5liNguIVwMy164DaM2f67v+c5HA89nCdNwAmyn/VPfye9sV6IqpIKVJG40bkaynCWAn/f5lxeZSkCnyxCCMyHtOerX+IrOhgvXTvCLGePTOjJeHLouFZMe1ZyYw9iW4AnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=me4O0jDsHr/o5bSCPL+M2s1lY6UrcxVieFNMa+/b43M=;
 b=lTOhgAnRkka3G0UjdngIj3NNkqInV+DNFs4KOBF+clCdMsGi4eubUOAUgh0t7L4IVv8jKMTQHGWK+tWhjblNhiqXH17w9YiNwoX7zVioe7fXWByM1hpW//0pMW8NUr5ZyfT7yuXcw5FtrWKtDBWh7vjk6QVYERVkvhLXITgGl0wi926sZaubpxePYIN19Fxh6sCEeO0xr41ePIT7iKCTqUQOksngrxmD8j3A1/+EN4VG8dZYiXj+x3QuwLDvUOe4CK4I2md1Lp7KDg2q/vSpN/09ocAgOCPr3TpCNIQR6MevuTtjRK4t+R2kQ+Lt9c2Xt4vL35qgiXdVAlvgOk2Jxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me4O0jDsHr/o5bSCPL+M2s1lY6UrcxVieFNMa+/b43M=;
 b=Kr0RcG+b2tJne4kQE32yX62alOyR743ml7t6mIInHd3QWTF9SDRT4LAs20Idpx/DBETYnxlS67YJiwFPmmZBQ+4Zo5DJ6wciD6n6iFxc7cvc3eDVWcPIqhjXs40cAsIGqBRSw6RrbipeK8/ZYkd2rLBVheYKysnhfWsyKZdrv6k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6986.namprd10.prod.outlook.com (2603:10b6:510:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 21:04:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 21:04:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     kernel test robot <lkp@intel.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH 05/43] mm: Expand vma iterator interface.
Thread-Topic: [PATCH 05/43] mm: Expand vma iterator interface.
Thread-Index: AQHZBBHU9foHbUxMAEi8caFhrTc+a65Xq3sAgBS5Y4A=
Date:   Tue, 13 Dec 2022 21:04:44 +0000
Message-ID: <20221213210435.7y3bsjtffpztetoa@revolver>
References: <20221129164352.3374638-6-Liam.Howlett@oracle.com>
 <202212010046.MfphguMh-lkp@intel.com>
In-Reply-To: <202212010046.MfphguMh-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH7PR10MB6986:EE_
x-ms-office365-filtering-correlation-id: 2a498a63-5fa1-48aa-4322-08dadd4da8df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BPTLm0FDVl3oociZ7jDnNApFrCWvPyNrUh4gWUHL6vCK8GPSiy2tB/3tUWM5WvhSVcjG+lNGJZPCHCYFXTdcIHmnZriwYQzQTt+9njsLh66tIDOdyUhbWC6we3Keyc4TcMX6mnG2pw3eCi7XzXPvV3RHdWyKepHPEYL8/XJrBVDYaRtVLljAP2lDfTMARFj7bMy5g85M/V5q7D5eh6PUi0Hqgoht4/8LiL+DVXZrWOrzA7v+W3JHc4I31TlQEbPi8rLSaKMMNQlc1m6wZkzvuF6HicEpSxFoq0VnS35My6rY8sxiW9emB9NTrmuQ5GNsA8IF/YYR97WTR1LzDS6gVMMzzj7Z3Cz6Zd+maCCMp294SAV7aPlCNmW+V0NADhFCj+yD4k9HE374VRcATLFh+Mrcfw1oopaanZxqafGhtQT/xWkQ3Bg892uTTCym6KzZ5gn19Z63pP4jgSc/HkjJ84rWyuzGn1TdLxVyLxqP5Q7hAT4B4Y0Hu8SU2l2WOgwh6twoP5cv5jvN8Nrnn2oDRqrPO30PSMIurDQSWJ7rC3ew6hHbEPquLfydYlbUARIE+/APRMtwApCpQZvlTwFHZzlOYi7tU/beobLbPiwLnpvh7j2RxzKSlz+JT1ARIKt3I2/66JHH1myZtqU8w+CZc5OTfc1eF/M0yyLddivza04OguOo36yg6sndgmR1MKKBy17pgKrN8abJsPAJEm+QFkUY91znFl1beZ1P1B7ZREmDugi7CF/9KJsKygCutOgInOP6bupe2Tw1rv96zRjTfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199015)(41300700001)(38100700002)(66556008)(64756008)(76116006)(122000001)(30864003)(8936002)(5660300002)(8676002)(66476007)(4326008)(66446008)(83380400001)(186003)(1076003)(71200400001)(2906002)(33716001)(316002)(66574015)(66946007)(6916009)(54906003)(44832011)(6506007)(38070700005)(91956017)(478600001)(966005)(9686003)(26005)(6486002)(86362001)(45080400002)(6512007)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QMJdj+IVn0GLV7tZYHXi3JVHRJ9JWGGBEQqLlj/+qITF0ZmajyUhLE+0Xc2B?=
 =?us-ascii?Q?YznCs1KEprxuuRLuhoZSVi81aUwNlNPdfMYCmryNUfQq817lWn1ONa1ygsgp?=
 =?us-ascii?Q?R8y5ujQAHjhTY7pmdemJbbrPIMbElLVHHENe+WKW0LCM7FYhlQ6wF5zbWSd7?=
 =?us-ascii?Q?sMg1sS7xXusWVGNArhDg11S/9vEyA5UrBGUuQItolweLo4MwLp4ZtukFHiwi?=
 =?us-ascii?Q?W3E+lhRjGaUqy7IVxF0PQvBum6ra7rJa8wM9POWvXtbjqJqTmUmJHuWlduIb?=
 =?us-ascii?Q?tc4VrNAKgIGgz2Y7I/uWLj2i7vD/w38+g/7BlL+qLe2SDqgUG5P6dE6FKURs?=
 =?us-ascii?Q?BO5JIHs/0DrPqVHA9lfaP2iHdAX5e8u9gDVnkNZhZsfVlY2lfsIprggkxEup?=
 =?us-ascii?Q?sV2qu871KHMejrrLiyVE0dOAkRFShJt/j6ttX+XZ4XBRKSrWaWEf0aknE2uF?=
 =?us-ascii?Q?t1EWW0qgp01gq2PqXmU4KaL0jnulnF7NtG1puQPytSFIQHubp+GYSyAQv1je?=
 =?us-ascii?Q?Rdx2Kz9fTKSI67pP64v8GqK2hx6xerzt/vJClWDO5bR118K9y4CmFgG0FLEE?=
 =?us-ascii?Q?XlpkjOyVTCU5n+5JSV4qO0p//66a1m8M9N3ic7NeIofUBIaIssbomFncIbmM?=
 =?us-ascii?Q?R4wcIPM+eDXcv9FBmTi1sWXM2eiB4tJpqqxjfGXw9i/1b40ugv1MzehQ36Ds?=
 =?us-ascii?Q?tU4HNtz3Ppj9d93kIDIdMEyBmaeZQe2WBaHss0msqygCeGQ/+clIjBxEnNjR?=
 =?us-ascii?Q?H6GEsqCfl0fxjIT+ilNRA7fFWqLLl9WR4Sa8pHmrVnFbO+/J2Ua/YQmFkUDJ?=
 =?us-ascii?Q?L2em3Rmo/n0fmchF6Mho6ZkNzeM3Gv2VmeDbnWEQwy1fVYrTY+JqSmbZ5XWr?=
 =?us-ascii?Q?YZlwDEb0rTBMgkdMN8fKj6O9NC6AEbevCZaPOQ5CE7JSu/vQCqkyWfXrr1oF?=
 =?us-ascii?Q?mjJkqdKgJL5ZR+MOlMAg1OoCGxijBt4mMApG/V9eG6rRIienF6Rw5/PVY5Np?=
 =?us-ascii?Q?8fNsCXjvNffEC/qmUpLAL2eUwzQIJ3HazezNEXiOPgGckwUX7Esk+OoXlTsw?=
 =?us-ascii?Q?vWcqt4c2Bw1u2emIdgc3CFhoA5tsjUqnJ9t7tRtD4QDHZhA3wvIr+93JaeB+?=
 =?us-ascii?Q?SKM6FrmjP2Eet+NE1wzM6dpR5Ox51cKOM+SjmtkHcik8SQ18D3KlR5/39+J1?=
 =?us-ascii?Q?ZCa1fPA+7EOlWzht0ssokURk9hB+N6+wVleRdaLb66jbLQ8ZTajunbB0k8JK?=
 =?us-ascii?Q?S0PVPza1AYOPlmSrypxhydxC3DHBL9W/QBCPbpb73WsJTer9/0lpH/Q37Wlt?=
 =?us-ascii?Q?3z+E3ER40beT28+cLvTAKE7VyCY9oM+OaY8rXOA82Yx+9wr+x+ggMhiJfYCJ?=
 =?us-ascii?Q?lB5RZdaFGoqiXtu14lJQB7ZCthMlTVQg/jjPDRftYRwFfUbE8D3E5NULY7Gz?=
 =?us-ascii?Q?c2z6BOTsoEUcL3OHwCNFg6MQcZKWK5qtLoYAfJM+v8d+QjxtGaAB5tfXVgoY?=
 =?us-ascii?Q?6GNgH0YOjQPSwT7RS5ikhJNLytZ/YAsYgy+RBVHh1TgBEKmEdRhyD+WLrbce?=
 =?us-ascii?Q?D5RFkY63uk8hrWXM//SojmrlhIP2y37BEZLJmjMdB8jo2y+cF7BDrvNa9KxP?=
 =?us-ascii?Q?dA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5C866F9E112E446B75EBE2749080B6A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a498a63-5fa1-48aa-4322-08dadd4da8df
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 21:04:44.1458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bSnx41iCICoU9VgmNPXpr1BPl43OYzPTL2LSdCNsS9rDrqRmkdEQmduZJ4t8g+gUtuBqaBlGEug+2wG/qyjAkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212130184
X-Proofpoint-GUID: t0TO9F1pqOiy7wJ-Qxw8Ir4omCaZKyy-
X-Proofpoint-ORIG-GUID: t0TO9F1pqOiy7wJ-Qxw8Ir4omCaZKyy-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel test robot <lkp@intel.com> [221130 11:36]:
> Hi Liam,
>=20
> I love your patch! Yet something to improve:
>=20
> [auto build test ERROR on acme/perf/core]
> [also build test ERROR on linus/master v6.1-rc7 next-20221130]
> [cannot apply to kees/for-next/execve tip/sched/core tip/perf/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Liam-Howlett/VMA-t=
ype-safety-through-VMA-iterator/20221130-104546
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git pe=
rf/core
> patch link:    https://lore.kernel.org/r/20221129164352.3374638-6-Liam.Ho=
wlett%40oracle.com
> patch subject: [PATCH 05/43] mm: Expand vma iterator interface.
> config: arc-defconfig
> compiler: arc-elf-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/cca685c9cb2e968b4=
246a2f376b1213522f09fc0
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Liam-Howlett/VMA-type-safety-thr=
ough-VMA-iterator/20221130-104546
>         git checkout cca685c9cb2e968b4246a2f376b1213522f09fc0
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Darc SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    mm/mmap.c: In function 'vma_iter_store':
> >> mm/mmap.c:172:17: error: implicit declaration of function 'mt_dump'; d=
id you mean 'xa_dump'? [-Werror=3Dimplicit-function-declaration]
>      172 |                 mt_dump(vmi->mas.tree);
>          |                 ^~~~~~~
>          |                 xa_dump
>    cc1: some warnings being treated as errors
>=20

Thanks!  I had already added the necessary #if defined() wrapper for
this issue.

>=20
> vim +172 mm/mmap.c
>=20
>    163=09
>    164	/* Store a VMA with preallocated memory */
>    165	static inline void vma_iter_store(struct vma_iterator *vmi,
>    166					  struct vm_area_struct *vma)
>    167	{
>    168		if (WARN_ON(vmi->mas.node !=3D MAS_START && vmi->mas.index > vma-=
>vm_start)) {
>    169			printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
>    170			printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
>    171			printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
>  > 172			mt_dump(vmi->mas.tree);
>    173		}
>    174		if (WARN_ON(vmi->mas.node !=3D MAS_START && vmi->mas.last <  vma-=
>vm_start)) {
>    175			printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
>    176			printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
>    177			printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
>    178			mt_dump(vmi->mas.tree);
>    179		}
>    180=09
>    181		if (vmi->mas.node !=3D MAS_START &&
>    182		    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm=
_start)))
>    183			vma_iter_invalidate(vmi);
>    184=09
>    185		vmi->mas.index =3D vma->vm_start;
>    186		vmi->mas.last =3D vma->vm_end - 1;
>    187		mas_store_prealloc(&vmi->mas, vma);
>    188	}
>    189=09
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/arc 6.1.0-rc6 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT=3D"arc-elf-gcc (GCC) 12.1.0"
> CONFIG_CC_IS_GCC=3Dy
> CONFIG_GCC_VERSION=3D120100
> CONFIG_CLANG_VERSION=3D0
> CONFIG_AS_IS_GNU=3Dy
> CONFIG_AS_VERSION=3D23800
> CONFIG_LD_IS_BFD=3Dy
> CONFIG_LD_VERSION=3D23800
> CONFIG_LLD_VERSION=3D0
> CONFIG_CC_HAS_ASM_GOTO_OUTPUT=3Dy
> CONFIG_CC_HAS_ASM_INLINE=3Dy
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=3Dy
> CONFIG_PAHOLE_VERSION=3D123
> CONFIG_IRQ_WORK=3Dy
> CONFIG_BUILDTIME_TABLE_SORT=3Dy
>=20
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=3D""
> CONFIG_LOCALVERSION_AUTO=3Dy
> CONFIG_BUILD_SALT=3D""
> CONFIG_HAVE_KERNEL_GZIP=3Dy
> CONFIG_HAVE_KERNEL_LZMA=3Dy
> CONFIG_KERNEL_GZIP=3Dy
> # CONFIG_KERNEL_LZMA is not set
> CONFIG_DEFAULT_INIT=3D""
> CONFIG_DEFAULT_HOSTNAME=3D"(none)"
> CONFIG_SYSVIPC=3Dy
> CONFIG_SYSVIPC_SYSCTL=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
> # CONFIG_WATCH_QUEUE is not set
> # CONFIG_CROSS_MEMORY_ATTACH is not set
> # CONFIG_USELIB is not set
> # CONFIG_AUDIT is not set
>=20
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_SHOW=3Dy
> CONFIG_GENERIC_PENDING_IRQ=3Dy
> CONFIG_IRQ_DOMAIN=3Dy
> # end of IRQ subsystem
>=20
> CONFIG_GENERIC_CLOCKEVENTS=3Dy
> CONFIG_CONTEXT_TRACKING=3Dy
> CONFIG_CONTEXT_TRACKING_IDLE=3Dy
>=20
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=3Dy
> CONFIG_NO_HZ_COMMON=3Dy
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=3Dy
> # CONFIG_NO_HZ is not set
> CONFIG_HIGH_RES_TIMERS=3Dy
> # end of Timers subsystem
>=20
> CONFIG_BPF=3Dy
>=20
> #
> # BPF subsystem
> #
> # CONFIG_BPF_SYSCALL is not set
> # end of BPF subsystem
>=20
> CONFIG_PREEMPT_BUILD=3Dy
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=3Dy
> CONFIG_PREEMPT_COUNT=3Dy
> CONFIG_PREEMPTION=3Dy
>=20
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=3Dy
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> # CONFIG_PSI is not set
> # end of CPU/Task time and stats accounting
>=20
> CONFIG_CPU_ISOLATION=3Dy
>=20
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=3Dy
> CONFIG_PREEMPT_RCU=3Dy
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=3Dy
> CONFIG_TREE_SRCU=3Dy
> CONFIG_TASKS_RCU_GENERIC=3Dy
> CONFIG_TASKS_RCU=3Dy
> CONFIG_RCU_STALL_COMMON=3Dy
> CONFIG_RCU_NEED_SEGCBLIST=3Dy
> # end of RCU Subsystem
>=20
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=3D17
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D13
> CONFIG_GENERIC_SCHED_CLOCK=3Dy
>=20
> #
> # Scheduler features
> #
> # end of Scheduler features
>=20
> CONFIG_CC_IMPLICIT_FALLTHROUGH=3D"-Wimplicit-fallthrough=3D5"
> CONFIG_GCC12_NO_ARRAY_BOUNDS=3Dy
> CONFIG_CC_NO_ARRAY_BOUNDS=3Dy
> # CONFIG_CGROUPS is not set
> CONFIG_NAMESPACES=3Dy
> # CONFIG_UTS_NS is not set
> CONFIG_IPC_NS=3Dy
> # CONFIG_USER_NS is not set
> # CONFIG_PID_NS is not set
> CONFIG_NET_NS=3Dy
> # CONFIG_CHECKPOINT_RESTORE is not set
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> # CONFIG_RELAY is not set
> CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_INITRAMFS_SOURCE=3D""
> CONFIG_RD_GZIP=3Dy
> CONFIG_RD_BZIP2=3Dy
> CONFIG_RD_LZMA=3Dy
> CONFIG_RD_XZ=3Dy
> CONFIG_RD_LZO=3Dy
> CONFIG_RD_LZ4=3Dy
> CONFIG_RD_ZSTD=3Dy
> # CONFIG_BOOT_CONFIG is not set
> CONFIG_INITRAMFS_PRESERVE_MTIME=3Dy
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=3Dy
> CONFIG_EXPERT=3Dy
> CONFIG_MULTIUSER=3Dy
> # CONFIG_SGETMASK_SYSCALL is not set
> CONFIG_SYSFS_SYSCALL=3Dy
> CONFIG_FHANDLE=3Dy
> CONFIG_POSIX_TIMERS=3Dy
> CONFIG_PRINTK=3Dy
> CONFIG_BUG=3Dy
> CONFIG_ELF_CORE=3Dy
> CONFIG_BASE_FULL=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_FUTEX_PI=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SIGNALFD=3Dy
> CONFIG_TIMERFD=3Dy
> CONFIG_EVENTFD=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_AIO=3Dy
> CONFIG_IO_URING=3Dy
> CONFIG_ADVISE_SYSCALLS=3Dy
> CONFIG_MEMBARRIER=3Dy
> CONFIG_KALLSYMS=3Dy
> # CONFIG_KALLSYMS_ALL is not set
> CONFIG_KALLSYMS_BASE_RELATIVE=3Dy
> # CONFIG_KCMP is not set
> CONFIG_EMBEDDED=3Dy
> CONFIG_HAVE_PERF_EVENTS=3Dy
> # CONFIG_PC104 is not set
>=20
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=3Dy
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
>=20
> # CONFIG_PROFILING is not set
> CONFIG_TRACEPOINTS=3Dy
> # end of General setup
>=20
> CONFIG_ARC=3Dy
> CONFIG_LOCKDEP_SUPPORT=3Dy
> CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
> CONFIG_GENERIC_CSUM=3Dy
> CONFIG_ARCH_FLATMEM_ENABLE=3Dy
> CONFIG_MMU=3Dy
> CONFIG_NO_IOPORT_MAP=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> CONFIG_GENERIC_HWEIGHT=3Dy
> CONFIG_STACKTRACE_SUPPORT=3Dy
>=20
> #
> # ARC Architecture Configuration
> #
>=20
> #
> # ARC Platform/SoC/Board
> #
> # CONFIG_ARC_PLAT_TB10X is not set
> # CONFIG_ARC_PLAT_AXS10X is not set
> # CONFIG_ARC_SOC_HSDK is not set
> # end of ARC Platform/SoC/Board
>=20
> # CONFIG_ISA_ARCOMPACT is not set
> CONFIG_ISA_ARCV2=3Dy
>=20
> #
> # ARC CPU Configuration
> #
> CONFIG_ARC_CPU_HS=3Dy
> CONFIG_ARC_TUNE_MCPU=3D""
> # CONFIG_CPU_BIG_ENDIAN is not set
> CONFIG_SMP=3Dy
> CONFIG_NR_CPUS=3D4
> # CONFIG_ARC_SMP_HALT_ON_RESET is not set
> CONFIG_ARC_MCIP=3Dy
> CONFIG_ARC_CACHE=3Dy
> CONFIG_ARC_CACHE_LINE_SHIFT=3D6
> CONFIG_ARC_HAS_ICACHE=3Dy
> CONFIG_ARC_HAS_DCACHE=3Dy
> CONFIG_ARC_CACHE_PAGES=3Dy
> # CONFIG_ARC_HAS_ICCM is not set
> # CONFIG_ARC_HAS_DCCM is not set
> CONFIG_ARC_MMU_V4=3Dy
> CONFIG_ARC_PAGE_SIZE_8K=3Dy
> # CONFIG_ARC_PAGE_SIZE_16K is not set
> # CONFIG_ARC_PAGE_SIZE_4K is not set
> CONFIG_PGTABLE_LEVELS=3D2
> # CONFIG_ARC_FPU_SAVE_RESTORE is not set
> CONFIG_ARC_HAS_LLSC=3Dy
> CONFIG_ARC_HAS_SWAPE=3Dy
> CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS=3Dy
> CONFIG_ARC_HAS_LL64=3Dy
> CONFIG_ARC_HAS_DIV_REM=3Dy
> CONFIG_ARC_HAS_ACCL_REGS=3Dy
> CONFIG_ARC_DSP_NONE=3Dy
> # CONFIG_ARC_DSP_KERNEL is not set
> # CONFIG_ARC_DSP_USERSPACE is not set
> # CONFIG_ARC_DSP_AGU_USERSPACE is not set
> # CONFIG_ARC_IRQ_NO_AUTOSAVE is not set
> # CONFIG_ARC_LPB_DISABLE is not set
> # end of ARC CPU Configuration
>=20
> CONFIG_LINUX_LINK_BASE=3D0x80000000
> CONFIG_LINUX_RAM_BASE=3D0x80000000
> # CONFIG_HIGHMEM is not set
> # CONFIG_ARC_HAS_PAE40 is not set
> CONFIG_ARC_KVADDR_SIZE=3D256
> CONFIG_ARC_CURR_IN_REG=3Dy
> CONFIG_HZ=3D100
> # CONFIG_ARC_METAWARE_HLINK is not set
> CONFIG_ARC_DBG=3Dy
> CONFIG_ARC_DW2_UNWIND=3Dy
> CONFIG_ARC_BUILTIN_DTB_NAME=3D"haps_hs_idu"
> # end of ARC Architecture Configuration
>=20
> CONFIG_ARCH_FORCE_MAX_ORDER=3D11
> # CONFIG_PM is not set
>=20
> #
> # General architecture-dependent options
> #
> CONFIG_KPROBES=3Dy
> # CONFIG_JUMP_LABEL is not set
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
> CONFIG_KRETPROBES=3Dy
> CONFIG_HAVE_IOREMAP_PROT=3Dy
> CONFIG_HAVE_KPROBES=3Dy
> CONFIG_HAVE_KRETPROBES=3Dy
> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
> CONFIG_ARCH_32BIT_OFF_T=3Dy
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
> CONFIG_LTO_NONE=3Dy
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
> CONFIG_MODULES_USE_ELF_RELA=3Dy
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=3Dy
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=3Dy
> CONFIG_CLONE_BACKWARDS=3Dy
> CONFIG_COMPAT_32BIT_TIME=3Dy
>=20
> #
> # GCOV-based kernel profiling
> #
> # end of GCOV-based kernel profiling
> # end of General architecture-dependent options
>=20
> CONFIG_RT_MUTEXES=3Dy
> CONFIG_BASE_SMALL=3D0
> CONFIG_MODULES=3Dy
> # CONFIG_MODULE_FORCE_LOAD is not set
> # CONFIG_MODULE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> CONFIG_MODULE_COMPRESS_NONE=3Dy
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> # CONFIG_MODULE_COMPRESS_XZ is not set
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH=3D"/sbin/modprobe"
> # CONFIG_TRIM_UNUSED_KSYMS is not set
> CONFIG_MODULES_TREE_LOOKUP=3Dy
> CONFIG_BLOCK=3Dy
> CONFIG_BLOCK_LEGACY_AUTOLOAD=3Dy
> # CONFIG_BLK_DEV_BSGLIB is not set
> # CONFIG_BLK_DEV_INTEGRITY is not set
> # CONFIG_BLK_DEV_ZONED is not set
> # CONFIG_BLK_WBT is not set
> # CONFIG_BLK_SED_OPAL is not set
> # CONFIG_BLK_INLINE_ENCRYPTION is not set
>=20
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_EFI_PARTITION=3Dy
> # end of Partition Types
>=20
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=3Dy
> CONFIG_MQ_IOSCHED_KYBER=3Dy
> # CONFIG_IOSCHED_BFQ is not set
> # end of IO Schedulers
>=20
> CONFIG_UNINLINE_SPIN_UNLOCK=3Dy
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
> CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
> CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
> CONFIG_LOCK_SPIN_ON_OWNER=3Dy
>=20
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_ELFCORE=3Dy
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
> CONFIG_BINFMT_SCRIPT=3Dy
> # CONFIG_BINFMT_MISC is not set
> CONFIG_COREDUMP=3Dy
> # end of Executable file formats
>=20
> #
> # Memory Management options
> #
> # CONFIG_SWAP is not set
>=20
> #
> # SLAB allocator options
> #
> CONFIG_SLAB=3Dy
> # CONFIG_SLUB is not set
> # CONFIG_SLOB is not set
> CONFIG_SLAB_MERGE_DEFAULT=3Dy
> # CONFIG_SLAB_FREELIST_RANDOM is not set
> # CONFIG_SLAB_FREELIST_HARDENED is not set
> # end of SLAB allocator options
>=20
> # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> # CONFIG_COMPAT_BRK is not set
> CONFIG_FLATMEM=3Dy
> CONFIG_SPLIT_PTLOCK_CPUS=3D4
> # CONFIG_COMPACTION is not set
> # CONFIG_PAGE_REPORTING is not set
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
> # CONFIG_TRANSPARENT_HUGEPAGE is not set
> # CONFIG_CMA is not set
> # CONFIG_IDLE_PAGE_TRACKING is not set
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
> # CONFIG_VM_EVENT_COUNTERS is not set
> # CONFIG_PERCPU_STATS is not set
>=20
> #
> # GUP_TEST needs to have DEBUG_FS enabled
> #
> CONFIG_ARCH_HAS_PTE_SPECIAL=3Dy
> # CONFIG_ANON_VMA_NAME is not set
> # CONFIG_USERFAULTFD is not set
> # CONFIG_LRU_GEN is not set
>=20
> #
> # Data Access Monitoring
> #
> # CONFIG_DAMON is not set
> # end of Data Access Monitoring
> # end of Memory Management options
>=20
> CONFIG_NET=3Dy
> CONFIG_SKB_EXTENSIONS=3Dy
>=20
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_DIAG=3Dy
> CONFIG_UNIX=3Dy
> CONFIG_UNIX_SCM=3Dy
> CONFIG_AF_UNIX_OOB=3Dy
> CONFIG_UNIX_DIAG=3Dy
> # CONFIG_TLS is not set
> CONFIG_XFRM=3Dy
> CONFIG_XFRM_ALGO=3Dy
> # CONFIG_XFRM_USER is not set
> # CONFIG_XFRM_SUB_POLICY is not set
> # CONFIG_XFRM_MIGRATE is not set
> # CONFIG_XFRM_STATISTICS is not set
> CONFIG_NET_KEY=3Dy
> # CONFIG_NET_KEY_MIGRATE is not set
> CONFIG_INET=3Dy
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_NET_IPVTI is not set
> # CONFIG_NET_FOU is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_TABLE_PERTURB_ORDER=3D16
> CONFIG_INET_DIAG=3Dy
> CONFIG_INET_TCP_DIAG=3Dy
> # CONFIG_INET_UDP_DIAG is not set
> # CONFIG_INET_RAW_DIAG is not set
> # CONFIG_INET_DIAG_DESTROY is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=3Dy
> CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> # CONFIG_TCP_MD5SIG is not set
> # CONFIG_IPV6 is not set
> # CONFIG_MPTCP is not set
> # CONFIG_NETWORK_SECMARK is not set
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_IEEE802154 is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_MPLS is not set
> # CONFIG_NET_NSH is not set
> # CONFIG_HSR is not set
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> # CONFIG_QRTR is not set
> # CONFIG_NET_NCSI is not set
> CONFIG_PCPU_DEV_REFCNT=3Dy
> CONFIG_RPS=3Dy
> CONFIG_RFS_ACCEL=3Dy
> CONFIG_SOCK_RX_QUEUE_MAPPING=3Dy
> CONFIG_XPS=3Dy
> CONFIG_NET_RX_BUSY_POLL=3Dy
> CONFIG_BQL=3Dy
> CONFIG_NET_FLOW_LIMIT=3Dy
>=20
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_NET_DROP_MONITOR is not set
> # end of Network testing
> # end of Networking options
>=20
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> # CONFIG_MCTP is not set
> # CONFIG_WIRELESS is not set
> # CONFIG_RFKILL is not set
> # CONFIG_NET_9P is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> # CONFIG_PSAMPLE is not set
> # CONFIG_NET_IFE is not set
> # CONFIG_LWTUNNEL is not set
> CONFIG_GRO_CELLS=3Dy
> # CONFIG_FAILOVER is not set
> CONFIG_ETHTOOL_NETLINK=3Dy
>=20
> #
> # Device Drivers
> #
> # CONFIG_PCCARD is not set
>=20
> #
> # Generic Driver Options
> #
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=3Dy
> # CONFIG_DEVTMPFS_MOUNT is not set
> # CONFIG_DEVTMPFS_SAFE is not set
> # CONFIG_STANDALONE is not set
> # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>=20
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=3Dy
> CONFIG_EXTRA_FIRMWARE=3D""
> # CONFIG_FW_LOADER_USER_HELPER is not set
> # CONFIG_FW_LOADER_COMPRESS is not set
> # CONFIG_FW_UPLOAD is not set
> # end of Firmware loader
>=20
> CONFIG_ALLOW_DEV_COREDUMP=3Dy
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> # end of Generic Driver Options
>=20
> #
> # Bus devices
> #
> # CONFIG_MHI_BUS is not set
> # CONFIG_MHI_BUS_EP is not set
> # end of Bus devices
>=20
> # CONFIG_CONNECTOR is not set
>=20
> #
> # Firmware Drivers
> #
>=20
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
>=20
> # CONFIG_FIRMWARE_MEMMAP is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
>=20
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
>=20
> # CONFIG_GNSS is not set
> # CONFIG_MTD is not set
> CONFIG_DTC=3Dy
> CONFIG_OF=3Dy
> # CONFIG_OF_UNITTEST is not set
> CONFIG_OF_FLATTREE=3Dy
> CONFIG_OF_EARLY_FLATTREE=3Dy
> CONFIG_OF_KOBJ=3Dy
> CONFIG_OF_ADDRESS=3Dy
> CONFIG_OF_IRQ=3Dy
> CONFIG_OF_RESERVED_MEM=3Dy
> # CONFIG_OF_OVERLAY is not set
> # CONFIG_PARPORT is not set
> # CONFIG_BLK_DEV is not set
>=20
> #
> # NVME Support
> #
> # CONFIG_NVME_FC is not set
> # CONFIG_NVME_TCP is not set
> # end of NVME Support
>=20
> #
> # Misc devices
> #
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_ENCLOSURE_SERVICES is not set
> # CONFIG_SRAM is not set
> # CONFIG_XILINX_SDFEC is not set
> # CONFIG_OPEN_DICE is not set
> # CONFIG_VCPU_STALL_DETECTOR is not set
> # CONFIG_C2PORT is not set
>=20
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_93CX6 is not set
> # end of EEPROM support
>=20
> #
> # Texas Instruments shared transport line discipline
> #
> # end of Texas Instruments shared transport line discipline
>=20
> #
> # Altera FPGA firmware download module (requires I2C)
> #
> # CONFIG_ECHO is not set
> # CONFIG_PVPANIC is not set
> # end of Misc devices
>=20
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=3Dy
> # CONFIG_RAID_ATTRS is not set
> # CONFIG_SCSI is not set
> # end of SCSI device support
>=20
> # CONFIG_ATA is not set
> # CONFIG_MD is not set
> # CONFIG_TARGET_CORE is not set
> CONFIG_NETDEVICES=3Dy
> CONFIG_NET_CORE=3Dy
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_MACSEC is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_TUN is not set
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> # CONFIG_NLMON is not set
> # CONFIG_ETHERNET is not set
> # CONFIG_PHYLIB is not set
> # CONFIG_PSE_CONTROLLER is not set
> # CONFIG_MDIO_DEVICE is not set
>=20
> #
> # PCS device drivers
> #
> # end of PCS device drivers
>=20
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
>=20
> #
> # Host-side USB support is needed for USB Network Adapter support
> #
> # CONFIG_WLAN is not set
> # CONFIG_WAN is not set
>=20
> #
> # Wireless WAN
> #
> # CONFIG_WWAN is not set
> # end of Wireless WAN
>=20
> # CONFIG_NET_FAILOVER is not set
> # CONFIG_ISDN is not set
>=20
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
> # CONFIG_INPUT_FF_MEMLESS is not set
> # CONFIG_INPUT_SPARSEKMAP is not set
> # CONFIG_INPUT_MATRIXKMAP is not set
>=20
> #
> # Userland interfaces
> #
> # CONFIG_INPUT_MOUSEDEV is not set
> # CONFIG_INPUT_JOYDEV is not set
> CONFIG_INPUT_EVDEV=3Dy
> # CONFIG_INPUT_EVBUG is not set
>=20
> #
> # Input Device Drivers
> #
> # CONFIG_INPUT_KEYBOARD is not set
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> # CONFIG_RMI4_CORE is not set
>=20
> #
> # Hardware I/O ports
> #
> # CONFIG_SERIO is not set
> # CONFIG_GAMEPORT is not set
> # end of Hardware I/O ports
> # end of Input device support
>=20
> #
> # Character devices
> #
> CONFIG_TTY=3Dy
> CONFIG_VT=3Dy
> CONFIG_CONSOLE_TRANSLATIONS=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_HW_CONSOLE=3Dy
> # CONFIG_VT_HW_CONSOLE_BINDING is not set
> CONFIG_UNIX98_PTYS=3Dy
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_LDISC_AUTOLOAD=3Dy
>=20
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=3Dy
> CONFIG_SERIAL_8250=3Dy
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=3Dy
> CONFIG_SERIAL_8250_16550A_VARIANTS=3Dy
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_NR_UARTS=3D1
> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D1
> # CONFIG_SERIAL_8250_EXTENDED is not set
> CONFIG_SERIAL_8250_DWLIB=3Dy
> CONFIG_SERIAL_8250_DW=3Dy
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_OF_PLATFORM=3Dy
>=20
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> # CONFIG_SERIAL_SIFIVE is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_XILINX_PS_UART is not set
> # CONFIG_SERIAL_ARC is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
>=20
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_N_GSM is not set
> # CONFIG_NULL_TTY is not set
> # CONFIG_SERIAL_DEV_BUS is not set
> # CONFIG_TTY_PRINTK is not set
> # CONFIG_VIRTIO_CONSOLE is not set
> # CONFIG_IPMI_HANDLER is not set
> # CONFIG_HW_RANDOM is not set
> CONFIG_DEVMEM=3Dy
> # CONFIG_TCG_TPM is not set
> # CONFIG_XILLYBUS is not set
> CONFIG_RANDOM_TRUST_CPU=3Dy
> CONFIG_RANDOM_TRUST_BOOTLOADER=3Dy
> # end of Character devices
>=20
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> # end of I2C support
>=20
> # CONFIG_I3C is not set
> # CONFIG_SPI is not set
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> # CONFIG_PPS is not set
>=20
> #
> # PTP clock support
> #
> # CONFIG_PTP_1588_CLOCK is not set
> CONFIG_PTP_1588_CLOCK_OPTIONAL=3Dy
>=20
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks=
.
> #
> # end of PTP clock support
>=20
> # CONFIG_PINCTRL is not set
> # CONFIG_GPIOLIB is not set
> # CONFIG_W1 is not set
> # CONFIG_POWER_RESET is not set
> # CONFIG_POWER_SUPPLY is not set
> # CONFIG_HWMON is not set
> # CONFIG_THERMAL is not set
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=3Dy
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=3Dy
> # CONFIG_BCMA is not set
>=20
> #
> # Multifunction device drivers
> #
> # CONFIG_MFD_ATMEL_FLEXCOM is not set
> # CONFIG_MFD_ATMEL_HLCDC is not set
> # CONFIG_MFD_MADERA is not set
> # CONFIG_MFD_HI6421_PMIC is not set
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_SM501 is not set
> # CONFIG_MFD_SYSCON is not set
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_TQMX86 is not set
> # end of Multifunction device drivers
>=20
> # CONFIG_REGULATOR is not set
> # CONFIG_RC_CORE is not set
>=20
> #
> # CEC support
> #
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> # end of CEC support
>=20
> # CONFIG_MEDIA_SUPPORT is not set
>=20
> #
> # Graphics support
> #
> # CONFIG_DRM is not set
> # CONFIG_DRM_DEBUG_MODESET_LOCK is not set
>=20
> #
> # ARM devices
> #
> # end of ARM devices
>=20
> #
> # Frame buffer Devices
> #
> # CONFIG_FB is not set
> # end of Frame buffer Devices
>=20
> #
> # Backlight & LCD device support
> #
> # CONFIG_LCD_CLASS_DEVICE is not set
> # CONFIG_BACKLIGHT_CLASS_DEVICE is not set
> # end of Backlight & LCD device support
>=20
> #
> # Console display driver support
> #
> CONFIG_DUMMY_CONSOLE=3Dy
> CONFIG_DUMMY_CONSOLE_COLUMNS=3D80
> CONFIG_DUMMY_CONSOLE_ROWS=3D25
> # end of Console display driver support
> # end of Graphics support
>=20
> # CONFIG_SOUND is not set
>=20
> #
> # HID support
> #
> # CONFIG_HID is not set
> # end of HID support
>=20
> CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> # CONFIG_USB_SUPPORT is not set
> # CONFIG_MMC is not set
> # CONFIG_MEMSTICK is not set
> # CONFIG_NEW_LEDS is not set
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> # CONFIG_RTC_CLASS is not set
> # CONFIG_DMADEVICES is not set
>=20
> #
> # DMABUF options
> #
> # CONFIG_SYNC_FILE is not set
> # CONFIG_DMABUF_HEAPS is not set
> # end of DMABUF options
>=20
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_UIO is not set
> # CONFIG_VFIO is not set
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO_MENU=3Dy
> # CONFIG_VIRTIO_MMIO is not set
> # CONFIG_VDPA is not set
> CONFIG_VHOST_MENU=3Dy
> # CONFIG_VHOST_NET is not set
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
>=20
> #
> # Microsoft Hyper-V guest support
> #
> # end of Microsoft Hyper-V guest support
>=20
> # CONFIG_GREYBUS is not set
> # CONFIG_COMEDI is not set
> # CONFIG_STAGING is not set
> # CONFIG_GOLDFISH is not set
> CONFIG_HAVE_CLK=3Dy
> CONFIG_HAVE_CLK_PREPARE=3Dy
> CONFIG_COMMON_CLK=3Dy
> # CONFIG_COMMON_CLK_AXI_CLKGEN is not set
> # CONFIG_COMMON_CLK_FIXED_MMIO is not set
> # CONFIG_XILINX_VCU is not set
> # CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
> # CONFIG_HWSPINLOCK is not set
>=20
> #
> # Clock Source drivers
> #
> CONFIG_TIMER_OF=3Dy
> CONFIG_TIMER_PROBE=3Dy
> CONFIG_ARC_TIMERS=3Dy
> CONFIG_ARC_TIMERS_64BIT=3Dy
> # CONFIG_MICROCHIP_PIT64B is not set
> # end of Clock Source drivers
>=20
> # CONFIG_MAILBOX is not set
> # CONFIG_IOMMU_SUPPORT is not set
>=20
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
>=20
> #
> # Rpmsg drivers
> #
> # CONFIG_RPMSG_VIRTIO is not set
> # end of Rpmsg drivers
>=20
> # CONFIG_SOUNDWIRE is not set
>=20
> #
> # SOC (System On Chip) specific Drivers
> #
>=20
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
>=20
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
>=20
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
>=20
> #
> # fujitsu SoC drivers
> #
> # end of fujitsu SoC drivers
>=20
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
>=20
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # CONFIG_LITEX_SOC_CONTROLLER is not set
> # end of Enable LiteX SoC Builder specific drivers
>=20
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
>=20
> # CONFIG_SOC_TI is not set
>=20
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
>=20
> # CONFIG_PM_DEVFREQ is not set
> # CONFIG_EXTCON is not set
> # CONFIG_MEMORY is not set
> # CONFIG_IIO is not set
> # CONFIG_PWM is not set
>=20
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=3Dy
> # CONFIG_AL_FIC is not set
> # CONFIG_XILINX_INTC is not set
> # end of IRQ chip support
>=20
> # CONFIG_IPACK_BUS is not set
> # CONFIG_RESET_CONTROLLER is not set
>=20
> #
> # PHY Subsystem
> #
> # CONFIG_GENERIC_PHY is not set
> # CONFIG_PHY_CAN_TRANSCEIVER is not set
>=20
> #
> # PHY drivers for Broadcom platforms
> #
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # end of PHY drivers for Broadcom platforms
>=20
> # CONFIG_PHY_CADENCE_TORRENT is not set
> # CONFIG_PHY_CADENCE_DPHY is not set
> # CONFIG_PHY_CADENCE_DPHY_RX is not set
> # CONFIG_PHY_CADENCE_SALVO is not set
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # end of PHY Subsystem
>=20
> # CONFIG_POWERCAP is not set
> # CONFIG_MCB is not set
>=20
> #
> # Performance monitor support
> #
> # end of Performance monitor support
>=20
> # CONFIG_RAS is not set
>=20
> #
> # Android
> #
> # CONFIG_ANDROID_BINDER_IPC is not set
> # end of Android
>=20
> # CONFIG_DAX is not set
> # CONFIG_NVMEM is not set
>=20
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> # CONFIG_INTEL_TH is not set
> # end of HW tracing support
>=20
> # CONFIG_FPGA is not set
> # CONFIG_FSI is not set
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> # CONFIG_INTERCONNECT is not set
> # CONFIG_COUNTER is not set
> # CONFIG_PECI is not set
> # CONFIG_HTE is not set
> # end of Device Drivers
>=20
> #
> # File systems
> #
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=3Dy
> CONFIG_EXT2_FS=3Dy
> CONFIG_EXT2_FS_XATTR=3Dy
> # CONFIG_EXT2_FS_POSIX_ACL is not set
> # CONFIG_EXT2_FS_SECURITY is not set
> # CONFIG_EXT3_FS is not set
> # CONFIG_EXT4_FS is not set
> CONFIG_FS_MBCACHE=3Dy
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_GFS2_FS is not set
> # CONFIG_BTRFS_FS is not set
> # CONFIG_NILFS2_FS is not set
> # CONFIG_F2FS_FS is not set
> CONFIG_EXPORTFS=3Dy
> # CONFIG_EXPORTFS_BLOCK_OPS is not set
> CONFIG_FILE_LOCKING=3Dy
> # CONFIG_FS_ENCRYPTION is not set
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=3Dy
> CONFIG_DNOTIFY=3Dy
> CONFIG_INOTIFY_USER=3Dy
> # CONFIG_FANOTIFY is not set
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_FUSE_FS is not set
> # CONFIG_OVERLAY_FS is not set
>=20
> #
> # Caches
> #
> # CONFIG_FSCACHE is not set
> # end of Caches
>=20
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> # CONFIG_UDF_FS is not set
> # end of CD-ROM/DVD Filesystems
>=20
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> # CONFIG_MSDOS_FS is not set
> # CONFIG_VFAT_FS is not set
> # CONFIG_EXFAT_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_NTFS3_FS is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
>=20
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> # CONFIG_PROC_KCORE is not set
> CONFIG_PROC_SYSCTL=3Dy
> CONFIG_PROC_PAGE_MONITOR=3Dy
> # CONFIG_PROC_CHILDREN is not set
> CONFIG_KERNFS=3Dy
> CONFIG_SYSFS=3Dy
> CONFIG_TMPFS=3Dy
> # CONFIG_TMPFS_POSIX_ACL is not set
> # CONFIG_TMPFS_XATTR is not set
> CONFIG_MEMFD_CREATE=3Dy
> # CONFIG_CONFIGFS_FS is not set
> # end of Pseudo filesystems
>=20
> # CONFIG_MISC_FILESYSTEMS is not set
> CONFIG_NETWORK_FILESYSTEMS=3Dy
> CONFIG_NFS_FS=3Dy
> CONFIG_NFS_V2=3Dy
> CONFIG_NFS_V3=3Dy
> # CONFIG_NFS_V3_ACL is not set
> # CONFIG_NFS_V4 is not set
> CONFIG_NFS_DISABLE_UDP_SUPPORT=3Dy
> # CONFIG_NFSD is not set
> CONFIG_GRACE_PERIOD=3Dy
> CONFIG_LOCKD=3Dy
> CONFIG_LOCKD_V4=3Dy
> CONFIG_NFS_COMMON=3Dy
> CONFIG_SUNRPC=3Dy
> # CONFIG_SUNRPC_DEBUG is not set
> # CONFIG_CEPH_FS is not set
> # CONFIG_CIFS is not set
> # CONFIG_SMB_SERVER is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_NLS is not set
> # CONFIG_UNICODE is not set
> CONFIG_IO_WQ=3Dy
> # end of File systems
>=20
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> # CONFIG_SECURITY is not set
> # CONFIG_SECURITYFS is not set
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=3Dy
> # CONFIG_HARDENED_USERCOPY is not set
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_DEFAULT_SECURITY_DAC=3Dy
> CONFIG_LSM=3D"landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"
>=20
> #
> # Kernel hardening options
> #
>=20
> #
> # Memory initialization
> #
> CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=3Dy
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=3Dy
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=3Dy
> # CONFIG_INIT_STACK_NONE is not set
> # CONFIG_INIT_STACK_ALL_PATTERN is not set
> CONFIG_INIT_STACK_ALL_ZERO=3Dy
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> CONFIG_CC_HAS_ZERO_CALL_USED_REGS=3Dy
> # CONFIG_ZERO_CALL_USED_REGS is not set
> # end of Memory initialization
>=20
> CONFIG_RANDSTRUCT_NONE=3Dy
> # end of Kernel hardening options
> # end of Security options
>=20
> CONFIG_CRYPTO=3Dy
>=20
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=3Dy
> CONFIG_CRYPTO_ALGAPI2=3Dy
> CONFIG_CRYPTO_SKCIPHER=3Dy
> CONFIG_CRYPTO_SKCIPHER2=3Dy
> CONFIG_CRYPTO_HASH=3Dy
> CONFIG_CRYPTO_HASH2=3Dy
> CONFIG_CRYPTO_RNG2=3Dy
> # CONFIG_CRYPTO_MANAGER is not set
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
> # CONFIG_CRYPTO_NULL is not set
> # CONFIG_CRYPTO_PCRYPT is not set
> # CONFIG_CRYPTO_CRYPTD is not set
> # CONFIG_CRYPTO_AUTHENC is not set
> # CONFIG_CRYPTO_TEST is not set
> # end of Crypto core or helper
>=20
> #
> # Public-key cryptography
> #
> # CONFIG_CRYPTO_RSA is not set
> # CONFIG_CRYPTO_DH is not set
> # CONFIG_CRYPTO_ECDH is not set
> # CONFIG_CRYPTO_ECDSA is not set
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_SM2 is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> # end of Public-key cryptography
>=20
> #
> # Block ciphers
> #
> # CONFIG_CRYPTO_AES is not set
> # CONFIG_CRYPTO_AES_TI is not set
> # CONFIG_CRYPTO_ARIA is not set
> # CONFIG_CRYPTO_BLOWFISH is not set
> # CONFIG_CRYPTO_CAMELLIA is not set
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST6 is not set
> # CONFIG_CRYPTO_DES is not set
> # CONFIG_CRYPTO_FCRYPT is not set
> # CONFIG_CRYPTO_SERPENT is not set
> # CONFIG_CRYPTO_SM4_GENERIC is not set
> # CONFIG_CRYPTO_TWOFISH is not set
> # end of Block ciphers
>=20
> #
> # Length-preserving ciphers and modes
> #
> # CONFIG_CRYPTO_ADIANTUM is not set
> # CONFIG_CRYPTO_CHACHA20 is not set
> # CONFIG_CRYPTO_CBC is not set
> # CONFIG_CRYPTO_CFB is not set
> # CONFIG_CRYPTO_CTR is not set
> # CONFIG_CRYPTO_CTS is not set
> # CONFIG_CRYPTO_ECB is not set
> # CONFIG_CRYPTO_HCTR2 is not set
> # CONFIG_CRYPTO_KEYWRAP is not set
> # CONFIG_CRYPTO_LRW is not set
> # CONFIG_CRYPTO_OFB is not set
> # CONFIG_CRYPTO_PCBC is not set
> # CONFIG_CRYPTO_XTS is not set
> # end of Length-preserving ciphers and modes
>=20
> #
> # AEAD (authenticated encryption with associated data) ciphers
> #
> # CONFIG_CRYPTO_AEGIS128 is not set
> # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> # CONFIG_CRYPTO_CCM is not set
> # CONFIG_CRYPTO_GCM is not set
> # CONFIG_CRYPTO_SEQIV is not set
> # CONFIG_CRYPTO_ECHAINIV is not set
> # CONFIG_CRYPTO_ESSIV is not set
> # end of AEAD (authenticated encryption with associated data) ciphers
>=20
> #
> # Hashes, digests, and MACs
> #
> # CONFIG_CRYPTO_BLAKE2B is not set
> # CONFIG_CRYPTO_CMAC is not set
> # CONFIG_CRYPTO_GHASH is not set
> # CONFIG_CRYPTO_HMAC is not set
> # CONFIG_CRYPTO_MD4 is not set
> # CONFIG_CRYPTO_MD5 is not set
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> # CONFIG_CRYPTO_POLY1305 is not set
> # CONFIG_CRYPTO_RMD160 is not set
> # CONFIG_CRYPTO_SHA1 is not set
> # CONFIG_CRYPTO_SHA256 is not set
> # CONFIG_CRYPTO_SHA512 is not set
> # CONFIG_CRYPTO_SHA3 is not set
> # CONFIG_CRYPTO_SM3_GENERIC is not set
> # CONFIG_CRYPTO_STREEBOG is not set
> # CONFIG_CRYPTO_VMAC is not set
> # CONFIG_CRYPTO_WP512 is not set
> # CONFIG_CRYPTO_XCBC is not set
> # CONFIG_CRYPTO_XXHASH is not set
> # end of Hashes, digests, and MACs
>=20
> #
> # CRCs (cyclic redundancy checks)
> #
> # CONFIG_CRYPTO_CRC32C is not set
> # CONFIG_CRYPTO_CRC32 is not set
> # CONFIG_CRYPTO_CRCT10DIF is not set
> # end of CRCs (cyclic redundancy checks)
>=20
> #
> # Compression
> #
> # CONFIG_CRYPTO_DEFLATE is not set
> # CONFIG_CRYPTO_LZO is not set
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> # CONFIG_CRYPTO_ZSTD is not set
> # end of Compression
>=20
> #
> # Random number generation
> #
> # CONFIG_CRYPTO_ANSI_CPRNG is not set
> # CONFIG_CRYPTO_DRBG_MENU is not set
> # CONFIG_CRYPTO_JITTERENTROPY is not set
> # end of Random number generation
>=20
> #
> # Userspace interface
> #
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> # end of Userspace interface
>=20
> CONFIG_CRYPTO_HW=3Dy
> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> # CONFIG_CRYPTO_DEV_CCREE is not set
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
>=20
> #
> # Certificates for signature checking
> #
> # end of Certificates for signature checking
>=20
> CONFIG_BINARY_PRINTF=3Dy
>=20
> #
> # Library routines
> #
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=3Dy
> CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
> CONFIG_GENERIC_STRNLEN_USER=3Dy
> CONFIG_GENERIC_NET_UTILS=3Dy
> # CONFIG_CORDIC is not set
> # CONFIG_PRIME_NUMBERS is not set
> CONFIG_RATIONAL=3Dy
> CONFIG_GENERIC_PCI_IOMAP=3Dy
>=20
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_UTILS=3Dy
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=3Dy
> # CONFIG_CRYPTO_LIB_CHACHA is not set
> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=3D1
> # CONFIG_CRYPTO_LIB_POLY1305 is not set
> # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_LIB_SHA1=3Dy
> # end of Crypto library routines
>=20
> # CONFIG_CRC_CCITT is not set
> # CONFIG_CRC16 is not set
> # CONFIG_CRC_T10DIF is not set
> # CONFIG_CRC64_ROCKSOFT is not set
> # CONFIG_CRC_ITU_T is not set
> CONFIG_CRC32=3Dy
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=3Dy
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> # CONFIG_CRC64 is not set
> # CONFIG_CRC4 is not set
> # CONFIG_CRC7 is not set
> # CONFIG_LIBCRC32C is not set
> # CONFIG_CRC8 is not set
> CONFIG_XXHASH=3Dy
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_LZO_DECOMPRESS=3Dy
> CONFIG_LZ4_DECOMPRESS=3Dy
> CONFIG_ZSTD_COMMON=3Dy
> CONFIG_ZSTD_DECOMPRESS=3Dy
> CONFIG_XZ_DEC=3Dy
> CONFIG_XZ_DEC_X86=3Dy
> CONFIG_XZ_DEC_POWERPC=3Dy
> CONFIG_XZ_DEC_IA64=3Dy
> CONFIG_XZ_DEC_ARM=3Dy
> CONFIG_XZ_DEC_ARMTHUMB=3Dy
> CONFIG_XZ_DEC_SPARC=3Dy
> # CONFIG_XZ_DEC_MICROLZMA is not set
> CONFIG_XZ_DEC_BCJ=3Dy
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=3Dy
> CONFIG_DECOMPRESS_BZIP2=3Dy
> CONFIG_DECOMPRESS_LZMA=3Dy
> CONFIG_DECOMPRESS_XZ=3Dy
> CONFIG_DECOMPRESS_LZO=3Dy
> CONFIG_DECOMPRESS_LZ4=3Dy
> CONFIG_DECOMPRESS_ZSTD=3Dy
> CONFIG_GENERIC_ALLOCATOR=3Dy
> CONFIG_HAS_IOMEM=3Dy
> CONFIG_HAS_DMA=3Dy
> CONFIG_NEED_DMA_MAP_STATE=3Dy
> CONFIG_DMA_DECLARE_COHERENT=3Dy
> CONFIG_ARCH_HAS_SETUP_DMA_OPS=3Dy
> CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=3Dy
> CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU=3Dy
> CONFIG_ARCH_HAS_DMA_PREP_COHERENT=3Dy
> CONFIG_DMA_NONCOHERENT_MMAP=3Dy
> CONFIG_DMA_COHERENT_POOL=3Dy
> CONFIG_DMA_DIRECT_REMAP=3Dy
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_FORCE_NR_CPUS is not set
> CONFIG_CPU_RMAP=3Dy
> CONFIG_DQL=3Dy
> CONFIG_GLOB=3Dy
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=3Dy
> # CONFIG_IRQ_POLL is not set
> CONFIG_LIBFDT=3Dy
> CONFIG_SBITMAP=3Dy
> # end of Library routines
>=20
> #
> # Kernel hacking
> #
>=20
> #
> # printk and dmesg options
> #
> # CONFIG_PRINTK_TIME is not set
> # CONFIG_PRINTK_CALLER is not set
> # CONFIG_STACKTRACE_BUILD_ID is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=3D4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
> # CONFIG_BOOT_PRINTK_DELAY is not set
> # CONFIG_DYNAMIC_DEBUG is not set
> # CONFIG_DYNAMIC_DEBUG_CORE is not set
> CONFIG_SYMBOLIC_ERRNAME=3Dy
> # end of printk and dmesg options
>=20
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_DEBUG_MISC=3Dy
>=20
> #
> # Compile-time checks and compiler options
> #
> CONFIG_AS_HAS_NON_CONST_LEB128=3Dy
> CONFIG_DEBUG_INFO_NONE=3Dy
> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_FRAME_WARN=3D1024
> # CONFIG_STRIP_ASM_SYMS is not set
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_DEBUG_SECTION_MISMATCH=3Dy
> CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
> # CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
> # CONFIG_VMLINUX_MAP is not set
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
>=20
> #
> # Generic Kernel Debugging Instruments
> #
> # CONFIG_MAGIC_SYSRQ is not set
> # CONFIG_DEBUG_FS is not set
> CONFIG_HAVE_ARCH_KGDB=3Dy
> # CONFIG_KGDB is not set
> # CONFIG_UBSAN is not set
> CONFIG_HAVE_KCSAN_COMPILER=3Dy
> # end of Generic Kernel Debugging Instruments
>=20
> #
> # Networking Debugging
> #
> # CONFIG_NET_DEV_REFCNT_TRACKER is not set
> # CONFIG_NET_NS_REFCNT_TRACKER is not set
> # CONFIG_DEBUG_NET is not set
> # end of Networking Debugging
>=20
> #
> # Memory Debugging
> #
> # CONFIG_PAGE_EXTENSION is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_PAGE_OWNER is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_OBJECTS is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_SCHED_STACK_END_CHECK is not set
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_VM_PGTABLE is not set
> # CONFIG_DEBUG_MEMORY_INIT is not set
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=3Dy
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=3Dy
> # end of Memory Debugging
>=20
> # CONFIG_DEBUG_SHIRQ is not set
>=20
> #
> # Debug Oops, Lockups and Hangs
> #
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=3D0
> CONFIG_PANIC_TIMEOUT=3D0
> CONFIG_LOCKUP_DETECTOR=3Dy
> CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_DETECT_HUNG_TASK=3Dy
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> # CONFIG_WQ_WATCHDOG is not set
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
>=20
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=3Dy
> # CONFIG_SCHEDSTATS is not set
> # end of Scheduler Debugging
>=20
> # CONFIG_DEBUG_TIMEKEEPING is not set
> # CONFIG_DEBUG_PREEMPT is not set
>=20
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_RWSEMS is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
>=20
> # CONFIG_DEBUG_IRQFLAGS is not set
> CONFIG_STACKTRACE=3Dy
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
>=20
> #
> # Debug kernel data structures
> #
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # CONFIG_DEBUG_MAPLE_TREE is not set
> # end of Debug kernel data structures
>=20
> # CONFIG_DEBUG_CREDENTIALS is not set
>=20
> #
> # RCU Debugging
> #
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=3D21
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D0
> CONFIG_RCU_TRACE=3Dy
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
>=20
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_NOP_TRACER=3Dy
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
> CONFIG_TRACE_CLOCK=3Dy
> CONFIG_RING_BUFFER=3Dy
> CONFIG_EVENT_TRACING=3Dy
> CONFIG_CONTEXT_SWITCH_TRACER=3Dy
> CONFIG_TRACING=3Dy
> CONFIG_TRACING_SUPPORT=3Dy
> CONFIG_FTRACE=3Dy
> # CONFIG_BOOTTIME_TRACING is not set
> # CONFIG_IRQSOFF_TRACER is not set
> # CONFIG_PREEMPT_TRACER is not set
> # CONFIG_SCHED_TRACER is not set
> # CONFIG_HWLAT_TRACER is not set
> # CONFIG_OSNOISE_TRACER is not set
> # CONFIG_TIMERLAT_TRACER is not set
> # CONFIG_ENABLE_DEFAULT_TRACERS is not set
> # CONFIG_FTRACE_SYSCALLS is not set
> # CONFIG_TRACER_SNAPSHOT is not set
> CONFIG_BRANCH_PROFILE_NONE=3Dy
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> # CONFIG_PROFILE_ALL_BRANCHES is not set
> # CONFIG_BLK_DEV_IO_TRACE is not set
> CONFIG_KPROBE_EVENTS=3Dy
> CONFIG_DYNAMIC_EVENTS=3Dy
> CONFIG_PROBE_EVENTS=3Dy
> # CONFIG_SYNTH_EVENTS is not set
> # CONFIG_TRACE_EVENT_INJECT is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> # CONFIG_RING_BUFFER_BENCHMARK is not set
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> # CONFIG_RV is not set
> # CONFIG_SAMPLES is not set
>=20
> #
> # arc Debugging
> #
> # CONFIG_16KSTACKS is not set
> # end of arc Debugging
>=20
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_CC_HAS_SANCOV_TRACE_PC=3Dy
> CONFIG_RUNTIME_TESTING_MENU=3Dy
> # CONFIG_TEST_MIN_HEAP is not set
> # CONFIG_TEST_DIV64 is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_TEST_REF_TRACKER is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> # CONFIG_ATOMIC64_SELFTEST is not set
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_STRING_SELFTEST is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_STRSCPY is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_PRINTF is not set
> # CONFIG_TEST_SCANF is not set
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_MAPLE_TREE is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_SIPHASH is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_BITOPS is not set
> # CONFIG_TEST_VMALLOC is not set
> # CONFIG_TEST_USER_COPY is not set
> # CONFIG_TEST_BPF is not set
> # CONFIG_TEST_BLACKHOLE_DEV is not set
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_KMOD is not set
> # CONFIG_TEST_MEMCAT_P is not set
> # CONFIG_TEST_MEMINIT is not set
> # CONFIG_TEST_FREE_PAGES is not set
> # end of Kernel Testing and Coverage
>=20
> #
> # Rust hacking
> #
> # end of Rust hacking
> # end of Kernel hacking
