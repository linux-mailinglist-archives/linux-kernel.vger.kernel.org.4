Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B21262346A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiKIUTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiKIUTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:19:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFA0F00E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:19:17 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9KD1fS007023;
        Wed, 9 Nov 2022 20:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=HOG33FayzP7gLz4PKZ8I/oS6Gll2eJ7xthLQziQzksQ=;
 b=cDQBwqykMK8Vg+ExFjngjLFeVeDj4f52XUFP0omsAX1OB0mIdlPZWq70TR2faSefz670
 265u5qNZbFqsoQjXSoEIYrgqnoNbNhg43gtGL1uibBtqfC36pjm+ZOVpZ9Pq/ORYY7kT
 VE0ZwDJ99iLJHrNePuEud/DUGk/O/ZTkcX98P/lhbx2h/lMyxpz6LgWCe7s8f36Dvtb4
 9jGnmWU9m95XXKFynbGmNftHLqc/3dit/lJq0e949dM4k30laVjypesZDtqdgXl8TVk3
 KIkWJCvpFUEHMx3TzYzZNExr5/LXWe10GXoyZ15dfgh6TaLUMXjz32qenukUY3LUbOms eA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krk1vg10b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 20:18:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9JC88N004437;
        Wed, 9 Nov 2022 20:18:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq3wtvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 20:18:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAwj/jcozr6pY6OmAwmAOPOOMHUGCPwj1iesyxoHUH132YS/PFPyf0FhL9Krnv94rJ2unplBcz5WBe/uG+N0JrA3otgNiPfTahzfXhtF92cuQvKy9MnGgCIY1Nyw3LRDz4HE9XBbkgD5MSzwc5zHK2Q6NpdYZz8AVgmUSTEAD+0Drn+sK2bwgk8N3ieDu/qFgQyPLOTYj6Gla3HYEPgD9GMBtDrCLmz6UErr5SFkvB/wwj1+IIW0hSrdU3JvE/BvpMEwIwk49Z2z813A6NBU+LGBkDoPcmynXyAh2VU+eF3j1201Xpb7aShtSxy4YdIsm9UbwblAzi1wxhmYQGHUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99Jy8Y1DqH3BtOLD5xQRBepI0JEsi7qcRlkpp32HRus=;
 b=Tx11jjG4payOrQWHNYO6c/vjhkiWPcRqpLVhD+gU4P5xTyPnYDylKeN9rZSdf/aanrioO/WZP6j7gZL9JtOH6WURvcC267s4CvjFsb7/LaoLfECJPTxHgBYgJlRnPGkdCYK2tw/RxPl6Oo7YcEKsV/j9nhK51W88L+OZyl6CNlbXMfAUloa4onguMYYSAXNitbkskXWIumbadwSslf1M6gxB2adtAAi64XiDrpRnOawz9IkoZ9fO8R/GpuHjKtpSxvwae2yDylZ18yatHOSFbB6Vu4sm8fcUyD3AdwlBJr7zPWYqEqBbbWfYjjZpU7P7ovf6KdW5CdbyuQf5AtoAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99Jy8Y1DqH3BtOLD5xQRBepI0JEsi7qcRlkpp32HRus=;
 b=kCQ+fd5steO9mi+Y1bKR8s1zm8/699Y5dilaGQ2aMvOqg7IIsyMWUqqW8OjGxR3FMYPazY57bKVkHzv7yMfQdLzgO7Ak74Ba24z28ajDXUdwS/uBZYfrKPfIt2otv2YWve0gCT1DdshUszam3RDk2Su2hwEqDVOy8XMXWHHpAwg=
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SN7PR10MB6548.namprd10.prod.outlook.com (2603:10b6:806:2ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 20:18:08 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::93:846c:dea2:6743]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::93:846c:dea2:6743%5]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 20:18:08 +0000
Date:   Wed, 9 Nov 2022 15:17:46 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        harshit.m.mogalapalli@gmail.com,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [RFC] iommu/vt-d: set default value of INTEL_IOMMU_FLOPPY_WA to n
Message-ID: <Y2wK6kWHE1iah/IG@char.us.oracle.com>
References: <20221108125855.2984751-1-harshit.m.mogalapalli@oracle.com>
 <dc463b3e-2875-8aac-aca1-edacb90e5650@linux.intel.com>
 <76cbad17-ab5e-3dd9-cf94-df2b26748167@oracle.com>
 <3a7f5cdf-640b-f9d4-a25e-8be845abd7ba@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a7f5cdf-640b-f9d4-a25e-8be845abd7ba@linux.intel.com>
X-ClientProxiedBy: AS4P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::6) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2999:EE_|SN7PR10MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e31cc6-e023-4d15-1275-08dac28f83cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFDDdtodN8CaAxJQVXEil22UhGpBLQUhfHaIfO0hdMaY1PDytFjPsMwtmhX+eKzPLiQIysz6Pr0wGU7i0e4ah4DBjTQ5tRgLeSE+tgrYRnzfj5CAeSy7QhauyOchWZ8b87X9TcO6Wmt15iplYOlvTkcuXH5a/Fh9Ojhd742j+qNyU/7jSirwSYxII2K5OgtmPZ9fAzLPFnK0cAt9zvIwkz9L+8cVoQJjHiNp4rZgTUwf48pR1RDdn/Mf7SLO0b5N6n07WYd6Fq5iq7TO2LEVCiNag8HTRPHeR+mgMRyA/f7d1Jx3p1Qdf4GPgYB3BJpamxS88yA2v03cJD3gBV+aJMZQvEpe4w/2MjTDS88RzW8BGxTh7XnX47lmPdET3kT9BLJOE9d43N43wvcGzLnvVwiFTHNIylCiWvEIlWoDrePYXUCf6HYS1AF5VnKWKBxr6gw3ZuAXVL74Pp4u0TRZQrKArc1nRjK0cX4qudvj8E2WGwPwQsAJzomGzdtO8YD0ZR4HcVzZGeSOSX5hyFJeutJ21wiwccJCzuwihOnUMwVJm6Dcd6Cdak8GOxyy7XGYtrrxPQdfFiYaTp0+3v3gBUhFz1ICcehoE+Y0DQ8/AzLXHdv5o61HX0MgFFUIeraplXN0X3rfywZYmdcvC7Z61IUVhanR/8fDplpCMWbiWddxoeoXrWVy80x2t7rVgEkN+hD5V9vFeih4bpcdFGyn893h3B5okp70e6BYlqEslgbCv6RU8CulehYoQMP2PpsvTu+trjMre+Jie3aDPsGqUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(6916009)(186003)(6512007)(6666004)(6486002)(54906003)(6506007)(86362001)(83380400001)(41300700001)(53546011)(107886003)(316002)(38100700002)(2906002)(4326008)(66946007)(8676002)(5660300002)(8936002)(478600001)(66556008)(26005)(66476007)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ly1flugez/WRXrlMHCtKTCNl3YTB4zQY3qQ9I4o4ephevBdX5lDRkcFjBm?=
 =?iso-8859-1?Q?7Z8sgk/fRXBweJE66uAe8fH0heEThr6y1O0kp070ZOhTWZfaWGkhZJOnHL?=
 =?iso-8859-1?Q?yF4AntAsgNZqLZdzBwsdJu6JWkIxRG/V2A18JmY8bN/4NHwWuPWpQGLwmq?=
 =?iso-8859-1?Q?J+b9/RSTL3FEAPgXtoWFnXENqWyyHZ4J6pYtTd2/A88DW95R530jQu/rMI?=
 =?iso-8859-1?Q?Ng4wW5fAUAeJXLpGBGXYCHuBh/EXqikJbjA4DQI3paMfDV15a2admi+rOd?=
 =?iso-8859-1?Q?2CT5RvYRKeZr9hMGaBB57I+LQslxgX9nO/wUXf0v7Ujy4FfDGnrDGQeHiL?=
 =?iso-8859-1?Q?NxLeXsuLY+RN4h17qxVHnppIokPxrGkx5UYpCjv7OIoeUGR2CwnuYGn7VW?=
 =?iso-8859-1?Q?odunq48xeNcoQcQ0Sco9yOVgMy62BKFN5/NYq333LoLX5VrVpQEgjA0niC?=
 =?iso-8859-1?Q?wZdjVgo5/O6naOfB27/8bZfY2Yod7f+24Iphobv8dPmEjoPl7HXWx2RjQV?=
 =?iso-8859-1?Q?yRS6ckF5LOPBBW6tElCOy3Wk/lqekYvt2n++CSPBW9wKuRn9LsYq5xhuuO?=
 =?iso-8859-1?Q?xeZzFSJKdqMSzL7K9OZ5hz5Fg7Ra0aP28BAxSC50IGtXjAmetycA/BjbWw?=
 =?iso-8859-1?Q?dHk1N1dCJJoQ/4z//LWD7a6Ozu5R2nQrW/g24wQvFeBl9t9wowMVHQNnGb?=
 =?iso-8859-1?Q?n9Je4IGOStP/DDMLb2FtlLrbJ+I0LPUYSUni4vISn6s5HvzzI6bmv3b5Wr?=
 =?iso-8859-1?Q?6sCM0rNVOkwNtz0nC+j1nNAZdbJKx8mdkPg5DwYHxK9IWO2zMY0Igno1HO?=
 =?iso-8859-1?Q?TNceqhtL/CRfb0+hUziOtso4gjsa4O0kxt3SK9Eejt6XF+i8O1A05az6wN?=
 =?iso-8859-1?Q?Nb4LonZYmrbN7ST9NM7V3BYQSP6R7OxOm+v6r1RjgHPVP39bnob1ZN63bW?=
 =?iso-8859-1?Q?qguVjAT4vKLVDq+DEQOz3grzraNZSJkPA/q9LI+ZkRHtG3NxH8ueJpKxcT?=
 =?iso-8859-1?Q?pnbigrXWb3Y7GJarDHrv699euYHzH0QMQLgfRi5dQD05K0y4IG5G6eH8z5?=
 =?iso-8859-1?Q?s7VXxcGUGp/HYRbdOlqOLrOOW8UOIaMcKSzrAxDtP8sA1Zp6+A4hEHCtdx?=
 =?iso-8859-1?Q?vqNCe4L05n96R33KLHhJlHlzTLLoJQtQDiDmvMSZOC2ir++A1mZdQawjOI?=
 =?iso-8859-1?Q?bABc4C581AfnX2LjqT0KDkzCdmxv6JkYgIiBfbovJ/iiBSwuIMlrnB+EqC?=
 =?iso-8859-1?Q?AOBP/M0sNNwGB5QFc9PWABrxlSMJ6U+sOSPE7fRPPs1azBSOmoP5NaZJbv?=
 =?iso-8859-1?Q?M2anwE1UvoCs+fW0JkItjI4F84/BDjxY6vcS4NFHdRN1+n8Si+c3wsNmlA?=
 =?iso-8859-1?Q?SXQTdEoyDAliRHm0TGJWYuFgMABZmutXVke0BoGPuzYJJecyrhZltAAViX?=
 =?iso-8859-1?Q?XeiNgSigsW/y2BnEsQUYNadtLIr4n6VPL7iNuQJ23mu8kN0sR+BP3SlmQ9?=
 =?iso-8859-1?Q?/UoNiVT4ErZhBKfDnqn+NB3c9tEI/4wbtti44x+8RM9tgStQYSPTo0rUJD?=
 =?iso-8859-1?Q?0bEJj5KrVCCN2zR9kNSacXl4fiXXEwWXHem0dCM+0jzHFLdjUTIZMVxRCF?=
 =?iso-8859-1?Q?SvpPagx/4xQcd4PPTWKhHpP8ly5Oc8YEU9bpDUSO+sH9e08GOKUjdYiw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e31cc6-e023-4d15-1275-08dac28f83cd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 20:18:08.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRQmKuFi4D1ofMsmEnmbu4U+tgdMQrJLipnguFPLZT+fVOhlrOWyBQ7u83viU1ToBxGMCvpHgl/tUGwZQLLozw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090153
X-Proofpoint-ORIG-GUID: M3HhgIOHmV0j2TtNlhCUvzANKGhYfiMP
X-Proofpoint-GUID: M3HhgIOHmV0j2TtNlhCUvzANKGhYfiMP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 09:16:53PM +0800, Baolu Lu wrote:
> On 2022/11/9 20:16, Harshit Mogalapalli wrote:
> > 
> > 
> > On 09/11/22 12:35 pm, Baolu Lu wrote:
> > > On 2022/11/8 20:58, Harshit Mogalapalli wrote:
> > > > It is likely that modern intel motherboard will not ship with a
> > > > floppy connection anymore, so let us disable it by default, as it
> > > > gets turned on when we do a make defconfig.
> > > > 
> > > > Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > > > ---
> > > >   drivers/iommu/intel/Kconfig | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> > > > index b7dff5092fd2..c783ae85ca9b 100644
> > > > --- a/drivers/iommu/intel/Kconfig
> > > > +++ b/drivers/iommu/intel/Kconfig
> > > > @@ -76,7 +76,7 @@ config INTEL_IOMMU_BROKEN_GFX_WA
> > > >         option is removed in the 2.6.32 kernel.
> > > >   config INTEL_IOMMU_FLOPPY_WA
> > > > -    def_bool y
> > > > +    def_bool n
> > > >       depends on X86
> > > >       help
> > > >         Floppy disk drivers are known to bypass DMA API calls
> > > 
> > > Nobody selects or depends on this. How about removing this bool? Only
> > > less than 10 lines of code are impacted and are not in any performance
> > > path.
> > > 
> > > diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> > > index b7dff5092fd2..5e077d1c5f5d 100644
> > > --- a/drivers/iommu/intel/Kconfig
> > > +++ b/drivers/iommu/intel/Kconfig
> > > @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
> > >         to use physical addresses for DMA, at least until this
> > >         option is removed in the 2.6.32 kernel.
> > > 
> > > -config INTEL_IOMMU_FLOPPY_WA
> > > -    def_bool y
> > > -    depends on X86
> > > -    help
> > > -      Floppy disk drivers are known to bypass DMA API calls
> > > -      thereby failing to work when IOMMU is enabled. This
> > > -      workaround will setup a 1:1 mapping for the first
> > > -      16MiB to make floppy (an ISA device) work.
> > > -
> > >   config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
> > >       bool "Enable Intel IOMMU scalable mode by default"
> > >       default y
> > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > > index 48cdcd0a5cf3..22801850f339 100644
> > > --- a/drivers/iommu/intel/iommu.c
> > > +++ b/drivers/iommu/intel/iommu.c
> > > @@ -4567,7 +4567,6 @@ static void
> > > intel_iommu_get_resv_regions(struct device *device,
> > >       }
> > >       rcu_read_unlock();
> > > 
> > > -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
> > >       if (dev_is_pci(device)) {
> > >           struct pci_dev *pdev = to_pci_dev(device);
> > > 
> > > @@ -4579,7 +4578,6 @@ static void
> > > intel_iommu_get_resv_regions(struct device *device,
> > >                   list_add_tail(&reg->list, head);
> > >           }
> > >       }
> > > -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
> > > 
> > >       reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
> > >                         IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
> > > 
> > 
> > Hi Baolu,
> > 
> > I have a question:
> > Shouldn't we remove the code between ifdef-endif statements?
> > 
> > I mean something like this:
> > 
> > diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> > index b7dff5092fd2..5e077d1c5f5d 100644
> > --- a/drivers/iommu/intel/Kconfig
> > +++ b/drivers/iommu/intel/Kconfig
> > @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
> >            to use physical addresses for DMA, at least until this
> >            option is removed in the 2.6.32 kernel.
> > 
> > -config INTEL_IOMMU_FLOPPY_WA
> > -       def_bool y
> > -       depends on X86
> > -       help
> > -         Floppy disk drivers are known to bypass DMA API calls
> > -         thereby failing to work when IOMMU is enabled. This
> > -         workaround will setup a 1:1 mapping for the first
> > -         16MiB to make floppy (an ISA device) work.
> > -
> >   config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
> >          bool "Enable Intel IOMMU scalable mode by default"
> >          default y
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 48cdcd0a5cf3..2c416ad3204e 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -4567,20 +4567,6 @@ static void intel_iommu_get_resv_regions(struct
> > device *device,
> >          }
> >          rcu_read_unlock();
> > 
> > -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
> > -       if (dev_is_pci(device)) {
> > -               struct pci_dev *pdev = to_pci_dev(device);
> > -
> > -               if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
> > -                       reg = iommu_alloc_resv_region(0, 1UL << 24, prot,
> > -                                       IOMMU_RESV_DIRECT_RELAXABLE,
> > -                                       GFP_KERNEL);
> > -                       if (reg)
> > -                               list_add_tail(&reg->list, head);
> > -               }
> > -       }
> > -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
> > -
> >          reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
> >                                        IOAPIC_RANGE_END -
> > IOAPIC_RANGE_START + 1,
> >                                        0, IOMMU_RESV_MSI, GFP_KERNEL);
> > 
> > This code is introduced in Commit d850c2ee5fe2 ("iommu/vt-d: Expose ISA
> > direct mapping region via iommu_get_resv_regions")
> 
> As long as floppy driver exists in the tree, we have to include above
> code. Otherwise, floppy drivers don't work. At least we can easily find
> drivers/block/floppy.c which is still maintained (check MAINTAINERS).:-)

But this requires a machine with Intel IOMMU and ISA:

> > > -      16MiB to make floppy (an ISA device) work.

ISA device? I don't believe there are any Intel machines with an IOMMU
and an ISA device?
