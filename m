Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89136624D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiKJWFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiKJWF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:05:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F401852897;
        Thu, 10 Nov 2022 14:05:27 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAM35gW025601;
        Thu, 10 Nov 2022 22:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=HmHFM6bmvrRaOkV+ZiD3LLU5Va5a8LVxmJQK1ed81Y0=;
 b=Vn1vb9giOlwuTiF15+KYTl6NAp8kBYgcdvJPiggKzun/59PbPdWMPxNXh2KKmlBzI6Qh
 kqVEiDHzYI+1PfuXN4dTwXCKlF/5kCe0FDn2/OTYQ0F3Pup6MFUQV0h3B5t97+VLOgNJ
 yXVhZlxdPUIapfeme8NTCqIEY9iMaFT5+3D39bj5dspMpbcExma9+g291ZNF0gOl5MT+
 vtstvQYanOa+4S7F67FXF3HVGN/1+YsiKmolEAE3fAG9nu/q4fiQRGWZAvzLVPRlA6g5
 ZONcPjH9ccJa9LlEw9rgPGevc29QbSqFe8oOsFEYCnbHcbEmL3UKnssZC4JSQjPPu6O6 +w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ks98xg2bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 22:05:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAKWLGO019841;
        Thu, 10 Nov 2022 22:05:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqkppbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 22:05:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lD0rQoP9XbuCq5vzhxo+j6gs0VyaQRYx46ACQ1xT7GxNrX01P4HyEEoiJWUEmcl4na5L38MlRADmR5BkvQUCN/901Cb7C7jZYRjtfuMwT26ogZHulW+8ezu+F8apjAmOofcJWtQgJfwXkMXUpdTsQUMxTDpJEuMkYj0mh5/knmIo/k2xscgbd4frfbafdiMLuMRtZsxDj3xX/E6sE24S4LowXsmzVDunq0kT1a+pseJPVMFkCXtPK35qpzDD7LYSRDGhLh9c9EabFVovOOpbkw5SlWqOOGsRfdjdR+8E6czPlDKsY5/eRPg5lFSiq5R6Adar3CjufFJ56qEhsYYNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmHFM6bmvrRaOkV+ZiD3LLU5Va5a8LVxmJQK1ed81Y0=;
 b=N2NNpiR4InnFZbO5TxWMm4d9ZFBr4osBGGx4VR6muCA+RqXjb7ttamHE6SrHxH5YL21JTJPZWfaCLqC9HPOJzc2xPDOoEA0f4HK8dO6yrQGw0loD/EfSqWIcJXbP4pi36/Oz8bh6kTaO9qMhyEfJNlMWX+OOL51YjkbP+X5Tjbyr3ckhPKNu7efRmH6cuP3nPvkWSG3VgPIWvjkj6ocMFGfo1LVCj3uETDlHTD+sod/0LSoY3jQywrXAvnglwp96uUXtfrK87HKZpByC6DRCU/P9racNGPmjWjfDqJJZ4L8q8/zAE++pAH++Rub32+ZNgZnlkTr1GNyb9NIyZ4TnHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmHFM6bmvrRaOkV+ZiD3LLU5Va5a8LVxmJQK1ed81Y0=;
 b=ejhwklImzzVvYBt/gfSDDqV0REpa/Oz5jqMwLe2hnkmIS+pprLqzo9PA++MkPCZczPzwYZQ7qiL0+/AC/erKuHpkcW0/MoPbG11L35MYI/1BG8kKWluuJchX0E+AldNX1TJm6dscG1o9gXKgDx3qzoWBSI1IC1Q3VrxCaiaVQXM=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by BLAPR10MB5074.namprd10.prod.outlook.com (2603:10b6:208:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 22:05:13 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e%9]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 22:05:13 +0000
Date:   Thu, 10 Nov 2022 17:05:09 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] padata: make padata_free_shell() to respect pd's
 ->refcnt
Message-ID: <20221110220509.cdymlc5lyrk7wsah@parnassus.localdomain>
References: <20221019083708.27138-1-nstange@suse.de>
 <20221019083708.27138-3-nstange@suse.de>
 <20221028143546.3xc6rnfkfcml373c@parnassus.localdomain>
 <87educb7rm.fsf@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87educb7rm.fsf@suse.de>
X-ClientProxiedBy: MN2PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:208:19b::40) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|BLAPR10MB5074:EE_
X-MS-Office365-Filtering-Correlation-Id: 44282508-de08-4f30-307b-08dac367a473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVGyBZxCKBv8lUb6pkNnyW7ORbzO3NgrGCpkk0bAhIRUvt2wxxAEupYIcBZQpBPaXO0cMJinTYeUGS/xfFoAHZJ1rx7Diie8OThiYm8LWeqd50ZIdiuYBPTbJmoMlp4NDV+RqqPZbm7marrl5UYTAGR8jFnHOKATRIAfijuv7mQ+SOMMtwXp1SVIqn7BIPjRTy35ACjAB74wMEUqNjnxRVbFwpnaOiWkCfgye4n4VZdqh/5r/qwwQHcw0PI6OrhkL+YgI+6mrjPOmRcCRaUOo56+53JN2dwyBpzVauo4f7liODtCTo7fvh3YbiUBZP22Uj/tmIT2D6NhWusJiLfSNoRTV2bEywo2P1yVCYzc60aLc0jAHD1Jdi1La62FtSN4F+nfa0C+AF4gNQs1J4DtPyUkLRGzIIhoUem5HB7QE4mCOL1W7ZZa1LN4KO6Ptbz5RK8O1ZlFHkIC6902ZYLbrkqWX3AheShmNAisbG9Hh00kFlacHKxumt0uPSskI5H0osdLYcp2sIlQs2SOKtMBvkLtiVhNGHju8x8ZJ0xPtc2Xqm+AxAZCVkbrgKzcjk9OVzIqMvFVZF0EoFzRLAYpRo4YcB5KLCDMED3jMXQopX/OItQyQq137NignZp1AGbvfGBf29JsWqxXANXT1l05TEXlhcwz5iVMJGcCYUBGEDVAK5Yr5/vBolx0RHef+KRPS8dICdLwW6gzJmKXxEQvtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199015)(86362001)(6506007)(66556008)(2906002)(5660300002)(186003)(9686003)(26005)(6512007)(83380400001)(1076003)(38100700002)(8676002)(66476007)(66946007)(316002)(6916009)(41300700001)(6486002)(8936002)(54906003)(478600001)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WgZEKTNsRNu1IWFVo+jDqh5LNXST3BVZ97yl3j6X3bFK4LSBrCIezDU1KXWg?=
 =?us-ascii?Q?rIL/g3AOsLA8I7dQncggWnurhR3bCFDmjBDUXBOnxpoOFkdQKyhufS+94+UF?=
 =?us-ascii?Q?eT5fJgZ7Bel5ZEb6G2Dohsy943Qc2e6bdwuaEPq7wK95L9cl88iIw7I8W1lt?=
 =?us-ascii?Q?WOnx1JVPa8C1aYxvUnJYUazSDmBPnpS5wOziXJhD0tyGWHvNNkfzs3J3TfUV?=
 =?us-ascii?Q?4GDY4y+So/bmWlpmOhlt2Q7m6JQ2uzZrwmFDvdDX+pFK6ZegjtOCKOJ1EF1F?=
 =?us-ascii?Q?9d9tFw2EG6u/lg2uKcsT9V7rYz2MFqdwkpuW5TmrvXmUyEI58fACh9FNPlty?=
 =?us-ascii?Q?iYY3hCQpjVuLQqb8yP0+WLPt6fcJ/5URp2wcI61ih56EegJXuucBHs+jqEqJ?=
 =?us-ascii?Q?940tqr3oV3tiXnMCgKIPcgppEkQSDwmTZ/MM9WBRDFqGKbI41YbL6ZmEyO4r?=
 =?us-ascii?Q?SCQh4+Nz6OBlifMjk0x2ghVttjYnk37H5CYyyvDuaQWJc/iBnACh2jZzC5aR?=
 =?us-ascii?Q?/Lw3eX2TCI65wqNgT7tUwJI769Fo3jl2QYq9+jzKVMRvAr2UdhH06P26SBBt?=
 =?us-ascii?Q?LDsVTmC8IXgkUrfLW1e4BixREuN0KFNzp2aMrCW+wC818P/nKNiskbmG6Ird?=
 =?us-ascii?Q?01kLst4w+54hc4I8zNGP5bUBB4+S20c/e+Sxsf3e+k/XF6A61RisdYwn316/?=
 =?us-ascii?Q?epgB9MrmSVIv9iXVVkIN46bcdwt3FwtdAQ9WANf4dhtZP/Trcl3CvZKZiNjf?=
 =?us-ascii?Q?esAIV/nKs3HdT4YqSEr09FtcS5JYnp/NmPsI+vy83RuzhROjMRR/uzn3B2Y2?=
 =?us-ascii?Q?PPIVmPcwvIjCnctY75yh3aJ5PjsRCekAMiwfLAidlZg9TC1F3FABi1AyCGv5?=
 =?us-ascii?Q?iZwRfOJIzYZ5lcNo68pKfNq9EdOagDRK41iXXxfd3TFU44a3SzN4y46JnTDn?=
 =?us-ascii?Q?sJ1t2JGKwFBdowyvMWHRY0JPf2S2X23rbQOUIq2M1kjWaXMxPCkAzjvmZWwF?=
 =?us-ascii?Q?tmmZMpScruhioxnEPVwlbygPWcnJnNfqEpVqLdAI+KHGlHX22w8lwnaY9ir/?=
 =?us-ascii?Q?V/4LQEg5Y0PvcUXHl6eciS+3PCl0AQ/hjPd2ijaftcDB21TJAEzYUOnNQ99V?=
 =?us-ascii?Q?MFlwjfDMXOWCL5GLUxaBKfn6Grxt8vO65mtwjR9BEsh+gVj2fwLAz9xO2ctH?=
 =?us-ascii?Q?6dVSXbyDuzJWUlSpYnwA4D96QEy/G222mFO9vLqRktH8gSi6zdqUIzD9j8k9?=
 =?us-ascii?Q?jk1xOV8X/lyp8T1I32kf6A7nFT1nL9tCCwLjZa46rvdDnzBKfc4QKayqYN7x?=
 =?us-ascii?Q?xYSRpEAJxEUdM2IbzLr3vAdnqYcDvCuFfI2C4WDV9eDs0pagwWK/LRjjx02X?=
 =?us-ascii?Q?D/D/OJUqMatoqis6fata9WH16dEQ9UakIUbeTRp3cuovEYNAeQ5JaBaKL9nb?=
 =?us-ascii?Q?Ec2YsKQl+xJJetOQSMWJjgb1hmjFpdjQU5512Rj6ZTbU/1hITGr63xE39d+5?=
 =?us-ascii?Q?+Es6ExcS00mSPL7z40Tp9kcsHkA+T4xH5xiDkx/VTkGDcmG6q3hz/Hbyg56N?=
 =?us-ascii?Q?lvKwJ40ebD09iXNpQOPnW4dYBHvF1rFxXST+RrW/EZmfOTYS77U9dXZsBfvH?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44282508-de08-4f30-307b-08dac367a473
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 22:05:13.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imc8rfQIYJt+reQJZ0tEVbRWMkhOhgE/COwG8GO410phZhOFuME0TH8CdpPTBs2IJNWoZb/wdFe28mKI+5RNQJH58E8N9z9vsRfZ0QlWsjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100155
X-Proofpoint-ORIG-GUID: iJke6fu0Gmf01f94CmwDx6H9ACB2892P
X-Proofpoint-GUID: iJke6fu0Gmf01f94CmwDx6H9ACB2892P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 02:02:37PM +0100, Nicolai Stange wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> 
> > On Wed, Oct 19, 2022 at 10:37:05AM +0200, Nicolai Stange wrote:
> >> 
> >> Fixes: 07928d9bfc81 ("padata: Remove broken queue flushing")
> >
> > It looks like this issue goes back to the first padata commit.  For
> > instance, pd->refcnt goes to zero after the last _priv is serialized,
> > padata_free is called in another task, and a particularly sluggish
> > padata_reorder call touches pd after.
> >
> > So wouldn't it be
> >
> > Fixes: 16295bec6398 ("padata: Generic parallelization/serialization interface")
> 
> I chose 07928d9bfc81 ("padata: Remove broken queue flushing"), because
> that one reads like it fixed a couple of much more severe padata
> lifetime issues, it only missed the relatively minor one addressed here,
> in a sense.
> 
> Or to put it the other way around: if one were to backport this patch
> here, 07928d9bfc81 should probably get picked first, I think.
> 
> But I'd be fine with any Fixes tag, of course, I don't have a strong
> opinion on this matter.

Ok, makes sense, your Fixes is fine then.  Please put that justification
in the changelog for the next version.
