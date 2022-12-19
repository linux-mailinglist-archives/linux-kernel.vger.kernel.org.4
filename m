Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A5C651188
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiLSSKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLSSKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:10:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154F113CDD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:10:31 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJHx0rm026470;
        Mon, 19 Dec 2022 18:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TsfZh1xkr/F5KvjMAN28iYK3tAIvNZ832G8NjN41juQ=;
 b=orgzZLoB6YVE5ga87UUmyqs/dZdPR6hU4upMylYVkImabo/x5wUMU/hIVK/AqziuMYV/
 NDJDMwUgf2uKor57/QJAMMAZfbhYpl2BfARMbevTG1W543ouEdGTKac50vbTLtt5JNEc
 6uXob0siwbw9kpxDhKF1P6p+CmeXaL+3FMJ9x58uh8aQS6lHsb3JA77a522RdyGw59hm
 B3cpr4vrzcnfZxehvD1IEIrrV4yuB9iTq9v1AMdgiB+lWeQIc2+tDuWtw/+rrbZXGIzV
 CDE3r7H+S7C3w6G+36A15T9zp+VR3EcIyUDZiyPfbW3USmZIlNcKlMlUSRg182xLIH+P yA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tmuhbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 18:09:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BJHtAKk009860;
        Mon, 19 Dec 2022 18:09:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47a66cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 18:09:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE9h5TU8ra/rGfywW6cTAJHLXacN05TkT8JpZP9MGbwuhvWrLUme8hgIecKi7Z8H6uCfhEvOTS+Fm2b+zcK0Or+P9a0V66m91re/WnIuEV4nLuXM0XaQVT0eHQFlrQHLbE8CoPeF1UNLHp6lDH2RulIVIbROdYKBpT9BsPXqfOrxr06iG4ii85ucCzifiGJv0Q3CdmWTAxFgHMpiE87IcmxBFBgPfhbCU+5gHraqaJZBt/ftA5pSZbFDFsegs/KTKf+d+ncEcqY3I6tqxuicBu8g+ThonKwq9pg2zWvuvR00PsYa+vpo/6LRG4qC3nGhe/Rs2lf5O+zxVPBQpKrRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsfZh1xkr/F5KvjMAN28iYK3tAIvNZ832G8NjN41juQ=;
 b=B0V5BCkrRGS00U0VPM3ED1Al9Abjus0zDXE28SR6YpT9wj5cZnvEExebJyoRsqCHVZgD9/bEb47Gb8iyy6yr4HiK9StLGJKmbIWvxS/Q2qDmPwU9lR9fgXAQCTrH3w7CEim1uEbZx1z4aLprdUuZM/4RWDejcwfkheSSWVEDoAM7DjdySnJna/xtWoARpF18v1SWcgmFj0e+AJi6dcchJBlMgt8MMf0v0BR3F1cFa6QEtqWHf/586HBf8q22oQ+0Im7sbEt/zk8O0KZBs5V4A+k5nRoa8x46nQacidsm1503drRMdmJJ8zhTZAU3gQRssTNoVaP8GcDH3N0mMl8cJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsfZh1xkr/F5KvjMAN28iYK3tAIvNZ832G8NjN41juQ=;
 b=G7wS7iUAF/7F9DcI23/hKpEFHcMHgKp52UOd2KBEkn2Y2yNKRmV60mk5ZfENb1lRk+AhQc/7dZ8cP7yb4J5LzkUKNEBLeRCXBXl+pT4le7CPrbE5GLLlUBgcHyjjwnrbF6wB6BkoNsopVuWsAZEmThTO/OuYE4XkuMW+Rks8tbA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4161.namprd10.prod.outlook.com (2603:10b6:a03:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 18:09:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 18:09:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     kernel test robot <yujie.liu@intel.com>
CC:     Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        SeongJae Park <sj@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
Subject: Re: [linus:master] will-it-scale.per_thread_ops -40.2% regression in
 mmap1 benchmark
Thread-Topic: [linus:master] will-it-scale.per_thread_ops -40.2% regression in
 mmap1 benchmark
Thread-Index: AQHZE5Dg5PRNV+lkn0WD/IKH1tst9K51gsqA
Date:   Mon, 19 Dec 2022 18:09:07 +0000
Message-ID: <20221219180857.u6opzhqqbbfxdj3h@revolver>
References: <202212191714.524e00b3-yujie.liu@intel.com>
In-Reply-To: <202212191714.524e00b3-yujie.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BY5PR10MB4161:EE_
x-ms-office365-filtering-correlation-id: 88267418-3984-4797-bdeb-08dae1ec1f42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b9aUxsWRo6EBT6BRB+xaMPT+3QNqhx3l0mSdxGid2QsF9kFCFiy4vyfKyFlyM5tlSJK93DKgk4X0L5wkDZ5l+RfpS8CMxoChMnOOWj/T23xof6ni+qUD8Qko7GLwmvPrUCQvkhpOeZY4yszNTIx95HJcLcVUi5aoZGaBlOJnF42F/jP/j4+YF13NUjXFj4kdpIXm5Kiea83OHIpizRvTW7LGmjfdrPOVpUr8u2B8dB19FJcdBRSXy7l7uxlS2m6VjVBlmuSP5FtANthK8qcJOut7COszJHeawqrX4TMfuOvjJyaiiowlxwDizLJT2eHSTx4vzcYAaKwYCyxakyDkgKY33TqI3ndWDHGo6OfcUI71JcyviUxGZoabVk3XfrX/b3tRkUfOcurUzfVAkc+9rSdC+iVwMqwfBGAa9LRQvYkSeWnUbVaml3xAFOAabX5X7qaLGkQk/dEyv4wD+ZCIzgCBOYph8YzuADEO86kWXNKCO336+aK6NGQEaXCOWbE+epDPKKBiGWtKWdoSfFCAfGxQKHnBJDFBr08rWVzEuvqEkiKm/kb+npixoke7qB6hKvvjgBkJPIH50c2/7JkBffLBalK9bimnLU3hjUmdDZI/nDkxsK1HBT6qq7QJ5WVklpjkcjATOVOJeHSbOOtIbtpxCdNNCu4QPrzYEaLK03KCmqW+kmN/RBoSo8afRn+E8qz44dz9azyndspwTWbh+cmIQAbcwE8GINdtYnIHXJc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(41300700001)(8936002)(91956017)(66476007)(4326008)(38070700005)(66556008)(86362001)(66946007)(54906003)(76116006)(5660300002)(44832011)(6916009)(8676002)(66446008)(64756008)(7416002)(316002)(2906002)(6506007)(122000001)(9686003)(6512007)(26005)(186003)(71200400001)(38100700002)(33716001)(83380400001)(1076003)(6486002)(966005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FsKv921CgEWz6kQsudrpVDKttXyJ+ljqphaUbhnS7+ZQricSYKD0E8YmrSGg?=
 =?us-ascii?Q?VDtlYytzLTgREfSvLUxcp9tB96M4YWdvaM9lXO0lh7mK7LNWQxofDR+K/Lc2?=
 =?us-ascii?Q?TprTOpG7WXPOepMIpjfKCOg39CpaxyDXlKNA9Nn5YMyrcsXFwwmAcNBtU/X3?=
 =?us-ascii?Q?3iRge4w7mZzpLzkcDF3d9rigThsWK1ZFE73HRqoBB82SozouIgHr6kBKEsef?=
 =?us-ascii?Q?t/rETWoK5yDKp0d26J6g1QUD1a0+Bue1++Uh9y3AesBDYQ0t4ETgmrNz28AJ?=
 =?us-ascii?Q?weufDmlxgMDjp6S0Sal/UqBjzUIgKgewmcV/y9J+H+m7kFIykCScqJEpbOr9?=
 =?us-ascii?Q?34fK5a5R+JiaKSLvKumAOrH0CzBGwyYd+0GtRQo1HaWb3sIAN6Gi4jNjH1N6?=
 =?us-ascii?Q?6pXuzYFniMkmWDL71wRzGGfMGrJtr9XbfMbQ4OJUiG9Bei2TApQ+siTlV3p8?=
 =?us-ascii?Q?oznUJ3RVwXfQzZIUSitxZdKnfyew+F5oWHmxLrf8IjRaWgbmCFjbRcdgLoXP?=
 =?us-ascii?Q?OmNAnRhQuMcHvAlB+qlwW1FDWRFvV0dwqQdy4EppDq8ywUuQmbLF9nXlrx0R?=
 =?us-ascii?Q?qe4lpSOGR2FB7zpqh/z2IVVIEg4GY7Kb4kqjxCyzsXgtpB4UdnezgEMH8y4Y?=
 =?us-ascii?Q?hxPB1ZWj1c2g1ThfzwYk2DUTumegUOtmOkDMORKU8PYDougiGyI6fMvtEPrg?=
 =?us-ascii?Q?8nPzLBMHJL5V4RvTn7j/bYj34dUfh7l2GGMCV0gR5p1d/I0ZGdeMrryVD0Rb?=
 =?us-ascii?Q?oSBZWWOEhVouOYmFGejJeLfFa5rlL13qtfoFYRx4Nt+JDSkZw4dWIl8s1hGx?=
 =?us-ascii?Q?VLg31zJ6SRiJLPGyGIgJdJyi5PZ/Oc8is5IYD6KUc7vH34Z2J+sI2tJkbcnN?=
 =?us-ascii?Q?LmiyUuiV/B9x3iX26sV8IZ0ysqiMcAA7aQTCa/AwehztjVYFy8dTI3Rxwj5X?=
 =?us-ascii?Q?x+dhEKe1Rbn9DlbZCqyK6hGKWW/GfE1CMWhVU7Z2/dZKeOdYxoisg0Gkcxa1?=
 =?us-ascii?Q?98Z2A/mr7gPj2SPCC8SjuA5Hy93rcdtcG5eAbiCmMUC8+N7T71SSlwgAPgvT?=
 =?us-ascii?Q?h3wyO+4/f/FN/w5HjorzsmXNKffMorJKBlJeFQdk96NcJI9TQ+S5AbMWSnV7?=
 =?us-ascii?Q?FdsUwWogBwDwERPKk/WsdR4ATwmzvccnHsQ1K6r1XkVp/rycjHeyVf/RyU7Z?=
 =?us-ascii?Q?gOn4neM6MQ0xGSu/m8c2PXRiLxlZ0LSrB5cElIDoiTshr7WpLZvombcE5/Ip?=
 =?us-ascii?Q?FOJDOCFt6KUrpHfLz/eGZ9ybm/qX2IxtAuYf+aVo+6HqxEKzOZeNRvUTUnZV?=
 =?us-ascii?Q?QHbvx0vVs7ywbx72t9b4OFy4Kn1WsrhIQyPNgQoSXQdB+fkg9BysWkZoHRDt?=
 =?us-ascii?Q?8XOZxR8Oj1b/jy5FLdb3eCza7dSnSlWdKzntgcbRka+jGw+XEKTUIQdQSutX?=
 =?us-ascii?Q?Z423uUz5+IyjYyVFP2KEdZUx3tjuMoAYB6wtZcjDi4L1MBqzqy8QsqXjeN3u?=
 =?us-ascii?Q?O/b1XtGmL98DBQ/8LbYa3Y0EiCoLExY8e5fijvsD/lbefUD2n/a/EiWtRSn/?=
 =?us-ascii?Q?P95mtXBKXuKDkAm4hf4zfj3tAajwUtbAzBa87Z5w3w0d+FYS9otKbjfArNNB?=
 =?us-ascii?Q?vA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FF669F782FE5374A90DA084B3FBB2106@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88267418-3984-4797-bdeb-08dae1ec1f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 18:09:07.9189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXhOuHFznarZWk2RwmpQFKMfzxKjab6tap8zXF4LKXkVP6fffhKHrki0UMKFC8Ppm93BcRx4Q7D3cLn8MR0EsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190161
X-Proofpoint-ORIG-GUID: Dl0cA_YWP-Hnr8PJhtnp2og-soEusnJv
X-Proofpoint-GUID: Dl0cA_YWP-Hnr8PJhtnp2og-soEusnJv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel test robot <yujie.liu@intel.com> [221219 05:01]:
> Greetings,
>=20
> FYI, we noticed a -40.2% regression of will-it-scale.per_thread_ops
> between commit 524e00b36e8c and e15e06a83923 of mainline

Thank you for running this test.

We are aware of this regression.  The regression was taken as an
acceptable trade off for the gain on the read speed.  Applications
perform more reads than writes to the VMA tree.  The overfall
performance on real applications is either even or faster with the maple
tree.  This can be seen in the kernel build times where forked processes
are short lived and would be close to the worst case scenario.

This isn't to say we can't do better, and we are constantly working
towards faster performance.  Please continue to report on the
performance.

Looking specifically at mmap1, it is mapping then unmapping in a tight
loop.  The regression would be expected, considering the internals of
what is going on, but I don't believe this would ever happen in an
application that is doing what it is supposed to be doing.

If you find a real application that shows a performance regression,
please let us know.

>=20
> 524e00b36e8c5 mm: remove rb tree.
> 0c563f1480435 proc: remove VMA rbtree use from nommu
> d0cf3dd47f0d5 damon: convert __damon_va_three_regions to use the VMA iter=
ator
> c9dbe82cb99db kernel/fork: use maple tree for dup_mmap() during forking
> 3499a13168da6 mm/mmap: use maple tree for unmapped_area{_topdown}
> 7fdbd37da5c6f mm/mmap: use the maple tree for find_vma_prev() instead of =
the rbtree
> be8432e7166ef mm/mmap: use the maple tree in find_vma() instead of the rb=
tree.
> 2e3af1db17442 mmap: use the VMA iterator in count_vma_pages_range()
> f39af05949a42 mm: add VMA iterator
> d4af56c5c7c67 mm: start tracking VMAs with maple tree
> e15e06a839232 lib/test_maple_tree: add testing for maple tree
>=20
> in testcase: will-it-scale
> on test machine: 104 threads 2 sockets (Skylake) with 192G memory
> with following parameters:
>=20
> 	nr_task: 50%
> 	mode: thread
> 	test: mmap1
> 	cpufreq_governor: performance
>=20
> test-description: Will It Scale takes a testcase and runs it from 1 throu=
gh to n parallel copies to see if the testcase will scale. It builds both a=
 process and threads based test in order to see any differences between the=
 two.
> test-url: https://github.com/antonblanchard/will-it-scale
>=20
>=20
> We couldn't find out the commit that introduced this regression because
> some of above commits failed to boot during bisection, but looks it is
> related with maple tree code. Please check following details:

It is interesting that these issues were not detected by myself or other
build bots.  Perhaps there is a configuration option that wasn't tested.
In any rate, all of the listed commits were in preparation for the last
commit to remove the rb tree.  Regardless of which commit introduced the
regression, it is the fact that that the maple tree is slower on writes
that is being detected.

Thanks,
Liam
