Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE3D654B43
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiLWCrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiLWCrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:47:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CBD1A3B3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:47:36 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMLxA3H023077;
        Fri, 23 Dec 2022 02:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fYY5s6TvH0a59MCiEQSRZkRQnzFNQpbSJbu3nTU3E4o=;
 b=QLlQdoqE2RTzshwHznSzjdK7S9qPaNyazfVY/9xmQtsbZtv6oPE/z7xwtEBOlrGETIYl
 TaNPlAIa1/SfFViur4AgDmjf0YBogD1IqFqoNrEEBMgNxfgd+94448pSG+1+3sMwR2ZG
 FWpCCEmzyWwtAOEjtwRSxEKoc+UMbRFKm5/7bntU/W/DV2FkDe59edshY4KC6Iz106uF
 QjTbjd4vFOi9RtHrbDW1tHX1KemwHbrrZCE41am/qOsNOTPsp7H+cG0U4/03nE7b/YR9
 7urmO3WKI0M0IrGlUSi2yfLRrF9pn8hLUxsvQyq/7rg/S8XyR+chdxV1qVBftLHcfe+6 1A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tr51k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Dec 2022 02:45:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BMN0Nqn031828;
        Fri, 23 Dec 2022 02:45:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47f2hf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Dec 2022 02:45:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBL2/P0EIjTa0498O5umzTkTOF/HdqOAhu2fHZQF4DFaFXPetfsQNEu/K2cxUN35ur6Pm0SYKOXCIrBhg5ILRReZbfoMOt7UbC3jk4hMXuuloTQzKd0D9kTQUwArSY1X6F9a/uRXPaxjpW2hIaW/yPkhdfX1DWUh0aeEXEcSvs3GMfezhahpVEztPdc21Dv3D/kGdSLSEJL4vE/Ms+945OCx19jZrQ3jsJhg5osoEkGkOHhiz86rlxAPlkzOpoyh2M54dLb334MiAo6WbnjSUx5fYT+rRhPdn1rV6xvv1oQLAddYQtppy3FBf+z1iAHCol5TwezgsLHeGFePbeeW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYY5s6TvH0a59MCiEQSRZkRQnzFNQpbSJbu3nTU3E4o=;
 b=O0UGv/O7tgsYt35LgfEKgtncng0m4oM51ReWdMUG12ueK2eX4ePhHjTgdAC9QT1GGa4tpl5+sqMHm2hYkztAjhtCI6qE8o0q5dBJ03c+xqWdprWsqcpOa1zurv3/80T5RWcm/r/LxwHoPjXxxRynLyPkUOADSlFaiJovtJnxXSGqyDq/IlNMdzYHRhnCg1AbHJyrHxGgV3r7yi+oHkyyyv1ahAAs72IthgVLMg4SDqwYPBiLG/tfNX49wkjR+ETFlAAZJEl1lBgG6MR3spjbipbEoDAXnlksAGsVvZkN6eR3sCXC0y+OnbfCkmhSynupkALaDC+SDzhivr0l0sa0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYY5s6TvH0a59MCiEQSRZkRQnzFNQpbSJbu3nTU3E4o=;
 b=cQsjE9m0ugSpoQG3oM+llDk0aitWKiGCOhszls+zPlw+QMU/yGFmXt7xB0jtNSnXASi1eguWwWC7VwdrR/G3VRStXLdpmrsXP7coa7iSHTidSPVSz8K27yy+SqWk23YFVTQXQ99KoHnKXa/3fFRFkxKzopQgNqROatltma1jPGI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN6PR10MB7490.namprd10.prod.outlook.com (2603:10b6:208:47d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 23 Dec
 2022 02:45:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 02:45:17 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
CC:     Yang Shi <shy828301@gmail.com>, Yujie Liu <yujie.liu@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>
Subject: Re: [linus:master] [mm] 0ba09b1733: will-it-scale.per_thread_ops
 -21.1% regression in mmap1 benchmark
Thread-Topic: [linus:master] [mm] 0ba09b1733: will-it-scale.per_thread_ops
 -21.1% regression in mmap1 benchmark
Thread-Index: AQHZE51UwP0Giwy58k2/PTqdTN1BxK53E7oAgAAt8oCAAGBtAIAA7fyAgACPUICAAaqHgA==
Date:   Fri, 23 Dec 2022 02:45:17 +0000
Message-ID: <20221223024321.itxwvcdyckepnyiz@revolver>
References: <202212151657.5d11a672-yujie.liu@intel.com>
 <CAHbLzkpVr62M4dWCb9J+eMErDvxx0hiTF6DD6bp2qEivzZYXCg@mail.gmail.com>
 <20221220204845.ul2wf4bj75dl5gbc@revolver> <Y6JwkEraN79acHP0@yujie-X299>
 <CAHbLzkpF4tuuukmhqC1soeVUaS4D5XtDjNDugy9t9D77s_xG8g@mail.gmail.com>
 <ed6c9173-dbbd-6275-a285-04b21de26f13@intel.com>
In-Reply-To: <ed6c9173-dbbd-6275-a285-04b21de26f13@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|MN6PR10MB7490:EE_
x-ms-office365-filtering-correlation-id: 85b80242-988e-4e65-e709-08dae48fb9ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 95LFnBM16GmldpLqF6VYo93rwB11xjoR0C0U5H/ExCG0MTXJFPoi3KjEQVeY5PLVLV6yHRoglrs5IKUJ6uMTE8UIdl0zvdxYvI2d44QXz4DuY4lESP+nBYcPXqrZVkd/lTJkaSPazgHGCyf/jr/bkb8z/btH5Nehq0/CcbmytX1fzQvROiuSY5TCrdem13+FXnCeA4ia9T4iNWL8CGXIWalZYjrotWHA53p41PfPcc0/43tk94vRVg4SwreCvm2a6Sa0q5busoY/vl3KwPAW1FTuyp9c3x2rdEtG7bqCzaGQsYVqj+iOxpEn2HVbNp9II2+Y6WV5aPTlgPNUSgvKXe6RqS5qgmSHwCYeQ3lf2fhvVSwlZwBZloSz8EWxa8P+9KRmAzl+2rVYOgfVf9qbdLlFreOwPg4UXm3Bp/D/ocSpXW5REwgDyqXK79kkXvTiCUGE3CD/G8ztW9RP8CPG3hm/tRAZZWbJeY8F2EUCeOjOWB90rA79ZMIWg9QI3+Q/pqq+hW4ku0C/O9PXhnn6dvtf6q7FTAzeMPcId9gFSuRVzUzMiX8GyUYpWs7gSryCyqH1I+U2oycgkUv9UhJF822MbGhCmrmT+UXsPn/Gx4fSb8hA6N0x2yIjWAmu8flpAJCajMvmN+G1p/yEMoqzrYV1mlweN9LZlmjCwHgoeqkGIaMgO5FdE3fYReER34cLb7pu0BqQ2ErY4xGWS/yWKPUBj3A9BBIlEafNEJ+TS4ps/wUy5oPOLpQXRngTa1hsKXU6CskHXrhuGdx7vKNIpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199015)(26005)(6512007)(478600001)(6916009)(53546011)(9686003)(6486002)(4326008)(66556008)(66446008)(76116006)(66946007)(316002)(91956017)(66476007)(966005)(64756008)(54906003)(71200400001)(6506007)(186003)(122000001)(5660300002)(1076003)(8676002)(83380400001)(38100700002)(7416002)(3716004)(8936002)(41300700001)(2906002)(44832011)(33716001)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FH2BJM27Fn8O0Uidh/0r7w7kBhsnHMh1iyNT/7uQSV+diRmoFGKid+kL6hsK?=
 =?us-ascii?Q?/gwBOE7xB5Rx+I3B/zWv3+7/17a66H+8GfPfQYKArdCKKLDPTuzWF0/HcS2X?=
 =?us-ascii?Q?2ynWu1xPtB8CbuVHbe8BgX1pL7TgQUOqANdlgDPaFH7Gh6wnYE2nJgww5K+S?=
 =?us-ascii?Q?BiCkpqnB4CXci8Y82EFlrHzOZb+1Rxst0svxGsk778aPReICuzv35iy2LMpV?=
 =?us-ascii?Q?U/ukdAd5jO742UWspF+vdvyK8r51rFUzsWsifMArYPqFhc/3p1vFeLhhwg0H?=
 =?us-ascii?Q?q3P1IfRwzUuA9wZSV2SfOJpgljlhAQUvG22sPmj5z6h2YPv5F/XCArQ5tzHM?=
 =?us-ascii?Q?wDPurfBfTxoXNaqaUpHWSMlLIrHhIgx+sX7/YQn+dL5TBgqs/4fwDYFeGmMR?=
 =?us-ascii?Q?D+Ot/5Q7OyJ5Htnd8raQLNigWO/It49zaYZ2FjpzJrT3/zgChpRmcJDU23N/?=
 =?us-ascii?Q?ftM8LrenkvKc/DDdxhQCEKVYL6Y8x/FLvo4O/JT8mZnd9JX7vAIhWcBaQtCV?=
 =?us-ascii?Q?aHHH77CS3tys3TBl0wrumWVI8wwHPj2xXjPEUQhMKe1EZMM2KVOUj0camsew?=
 =?us-ascii?Q?kn6XWZPdTGXuHTiK8t6JlPUM+Exi0253to98pP9B4VXug29kmFS7ddZ9seAG?=
 =?us-ascii?Q?lBoko/NmdffjlSt7WtROGaEo1L/sZdNC/vt1JIjCX2VmP0u3Vyt6s45H+Kht?=
 =?us-ascii?Q?fHjsC0Hpl2PIp6wjp0NplyLnB7GG4YDZnQY/dD8a70smOjaWabvI6pQZ1aft?=
 =?us-ascii?Q?IyV7sv8A/cXyDq6lqS0ZXTeq0DdkmegenCyEoAhH4oafsSipYHPyFlqmXJlQ?=
 =?us-ascii?Q?foX52F1IpL8TdFtzXY8WXUXH+Rob4Q1Lp9pJ+SgHBK//O1M+/LWMgKWEVIvW?=
 =?us-ascii?Q?+0ccPN9O5hVjnNcgOLhgfEvYPj4E8oiL0J5gAwyzwF1YEfIkHdVN5jMQxpsd?=
 =?us-ascii?Q?XT/ao80w4ZFVZ2UgRobJL3wYcxthI0KrjQqUZ+LeBnqewnV27QYh/IKk8Zb9?=
 =?us-ascii?Q?AhdVsTmUC0AfSHY/Uxd9DfRG7F5i7Kx5k94BNHQ9gs6r4/WBRh7wZoXkYXIT?=
 =?us-ascii?Q?lFKELJhK6sC4XaNonLeUaBEGlsZ3cS4RxDdMNNT9WuhPGzxtqxk5XQJB3fax?=
 =?us-ascii?Q?rgWj1xyFRfdunW8zGwa/OfanLMi4NDgm9ZKyN+bzyCAziH6D5dLir/VI9BOZ?=
 =?us-ascii?Q?7dMw2rC+wKrWWfADytIhDurLCCoKiTX//LxJnLad9HznNhwxZ8pcbbtjDPpx?=
 =?us-ascii?Q?PNbgc+6ztQRNqHRqQ66ji6pI9fqIu4sXSeubFKcDFOzNYEasoQU/g4MZEdDp?=
 =?us-ascii?Q?rdUFhmrrYI5gtwIESOtNObL2DSH7k22zuGO0L4Gw1SoZvM7xj7qq0pLeL1GA?=
 =?us-ascii?Q?8a8Anz8FlsrF+1Ydh9B1h6NXplAh6D1WDvprqwFMcKU/0GEJ6UEgPtdwWNR2?=
 =?us-ascii?Q?fOB9UDHUXlPnenTcpsSpUaedtzwPf9j2HlCaiJZs7gqaYmZJY7FJvPx4LjUQ?=
 =?us-ascii?Q?lxA+PGuE3NT382WCyqEdPPXJK0Z8q4KTCi6qrVLTz87Jfdqb/4IcOb0bDNw/?=
 =?us-ascii?Q?wT/mhLvOovG0lb/JptWVwehlyACPFSiYZ74XxVsjmYdNbwAs7HFvhNVqudlV?=
 =?us-ascii?Q?ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FD078552EFDC04ABE0D5ACA79652D28@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b80242-988e-4e65-e709-08dae48fb9ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 02:45:17.2762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMxsl6jnGoKdvEqc7EmMHzGMvMkgjb+IaASyVlTNFK012xZRFPNr1/XsCvp46f5YNm8OMkNNwZ9n5Wbcv2jWZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_12,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212230021
X-Proofpoint-GUID: cV-N9PuhbBu2mBzvnA5fWdsxfK7BLlbn
X-Proofpoint-ORIG-GUID: cV-N9PuhbBu2mBzvnA5fWdsxfK7BLlbn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yin, Fengwei <fengwei.yin@intel.com> [221221 20:19]:
>=20
>=20
> On 12/22/2022 12:45 AM, Yang Shi wrote:
> >> We caught two mmap1 regressions on mailine, please see the data below:
> >>
> >> 830b3c68c1fb1 Linux 6.1                                               =
               2085 2355 2088
> >> 76dcd734eca23 Linux 6.1-rc8                                           =
               2093 2082 2094 2073 2304 2088
> >> 0ba09b1733878 Revert "mm: align larger anonymous mappings on THP bound=
aries"         2124 2286 2086 2114 2065 2081
> >> 23393c6461422 char: tpm: Protect tpm_pm_suspend with locks            =
               2756 2711 2689 2696 2660 2665
> >> b7b275e60bcd5 Linux 6.1-rc7                                           =
               2670 2656 2720 2691 2667
> >> ...
> >> 9abf2313adc1c Linux 6.1-rc1                                           =
               2725 2717 2690 2691 2710
> >> 3b0e81a1cdc9a mmap: change zeroing of maple tree in __vma_adjust()    =
               2736 2781 2748
> >> 524e00b36e8c5 mm: remove rb tree.                                     =
               2747 2744 2747
> >> 0c563f1480435 proc: remove VMA rbtree use from nommu
> >> d0cf3dd47f0d5 damon: convert __damon_va_three_regions to use the VMA i=
terator
> >> 3499a13168da6 mm/mmap: use maple tree for unmapped_area{_topdown}
> >> 7fdbd37da5c6f mm/mmap: use the maple tree for find_vma_prev() instead =
of the rbtree
> >> f39af05949a42 mm: add VMA iterator
> >> d4af56c5c7c67 mm: start tracking VMAs with maple tree
> >> e15e06a839232 lib/test_maple_tree: add testing for maple tree         =
               4638 4628 4502
> >> 9832fb87834e2 mm/demotion: expose memory tier details via sysfs       =
               4625 4509 4548
> >> 4fe89d07dcc28 Linux 6.0                                               =
               4385 4205 4348 4228 4504
> >>
> >>
> >> The first regression was between v6.0 and v6.1-rc1. The score dropped
> >> from 4600 to 2700, and bisected to the patches switching from rb tree =
to
> >> maple tree. This was reported at
> >> https://lore.kernel.org/oe-lkp/202212191714.524e00b3-yujie.liu@intel.c=
om/
> >> Thanks for the explanation that it is an expected regression as a trad=
e
> >> off to benefit read performance.
> >>
> >> The second regression was between v6.1-rc7 and v6.1-rc8. The score
> >> dropped from 2700 to 2100, and bisected to this "Revert "mm: align lar=
ger
> >> anonymous mappings on THP boundaries"" commit.
> > So it means "mm: align larger anonymous mappings on THP boundaries"
> > actually improved the mmap1 benchmark? But it caused regression for
> > other usecase, for example, building kernel with clang, which is a
> > regression for a real life usecase.
> Yes. The patch "mm: align larger anonymous mappings on THP boundaries"
> can improve the mmap1 benchmark.
>=20

If the aligned VMAs cannot be merged, then they do not need to be split
on freeing.  This means we are just allocating a new vma, write it in
the tree, removing it from the tree, free the vma.  We can do this 4600
times a second, apparently.

If the VMAs do get merged, we will go through __vma_adjust() to expand a
boundary, write it to the tree, allocate a new vma, __vma_adjust() the
vma boundary back, insert the new VMA that covers the boundary area,
remove the new vma from the tree, free the vma.  We can only do this
2700 times a second.  Note this is writing 3 times to the tree in this
loop vs 2 in the other option.

So yes, merging/splitting is more work and always has been.  We are
doing this to avoid having too many VMAs though.  There really isn't a
good reason an application would do this for any meaningful number of
iterations.

> For building kernel regression, looks like it's not related with the
> patch "mm: align larger anonymous mappings on THP boundaries" directly.
> It's another existing behavior more visible with the patch.
> https://lore.kernel.org/all/a4bcddad-e56f-cedc-891a-916e86d9a02c@intel.co=
m/
>=20

Having a snapshot of the VMA layout would help here since the THP
boundary alignment may be changing if the VMAs can be merged or not.  I
suspect it is not able to merge and is fragmenting the VMA space which
would speed up this benchmark at the expense of having more VMAs.

Thanks,
Liam=
