Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB026476E7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiLHUBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLHUBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:01:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F89A6FF31
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:01:39 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8Jfi7b030387;
        Thu, 8 Dec 2022 20:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=8ibZI6w6jOgvs0iT5b5tabROpLNcaDeMMsPI6hkcI6Q=;
 b=WC+RcQMRvhusNLgj+kMI4gg23Dz3ZDGVKwpAp4O/iAh5t6k9x1mokXk6ZLRx7OXefVEd
 N6GeEbZAHS2tyA/qiZDXv7AK0F6z1d3QNh5L7Pdt+hOlljBNe+ygTlMjn/OAFuiEsBN4
 ndVfB8Wq5XeqHsXD9BZc62qhh4masQGP/0FBrPbWgyIFyaIqhzh98Amb0m5OQCApCfB8
 BXWi/NKWsppho0Tz9E43jZwH3xenvJcNdb+/19zugdcNIRVU1IcNgCZt8oIVLG/z51TJ
 lUEQTdHdf3f9mjQteUKFQ/8BiOHRcsXRWUJrRYzYlKYgbZmSA/pyc4s5LYX+0xE3K23i tw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mauf8kmvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 20:01:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B8IMSZO019626;
        Thu, 8 Dec 2022 20:01:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa8j92md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 20:01:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jovk9T+07bvlFSkIGYqaAfaEOoPIQeE4FBMyb/jcB/qZb5e4GBQCdr4+A5jXfMXHcQSFLHJILrhIKk9N4yLsVAokmBvs2EgnOp/8+MJWLHBnEpeMH4AoAi7gHp7dvOujEZP+mJPO55WGY7CPWAyFJrYO8EtdeS12V9jjG1oVtEvDzAPaTaTBrAlSFvnrhxCLejamHeUtCDYayxftkFtBL8btaPeWtb0iX/iJH2MKrHdUrxxj0W8SlctjoA4lwX8q6HV8CQnMVyQhDoqwAJjt4MJLzQV3CwYq/bWSj7h2171OYunSWFM3xSsdijUSt59aQZe9FjhnErq66jRSB6QcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ibZI6w6jOgvs0iT5b5tabROpLNcaDeMMsPI6hkcI6Q=;
 b=QhDp1f+cj3ASHDFPxJQisYP1m2VhImN0ykflUatSMZ0yZK2tIg+tWL/DX73ry/uG3Y+ySAJFjWzzLCMomFMHCLgQHwtnDkEtNElAurC+G5+ly+v9ozF8q9nvmA8xPwd1MWk/PFVhhC4DM6uqORBVmR9S76dxNXes4Pl8ZfLCTXGKDzStjN17cB9wPuGXeairUstx1N/C/NdlN1m/l6nfBj8LmdUkIKuIn5F5w0xXUcNO29j4NxiblUluasX+t9hpvxYrnikPsSxMqz6Rb6o0ffE3z6pmkFPDyZ/vHYTAYdTRV+WXCgM0nLxnOxOGhxUFJDkGRivaHJi4nINsTzG2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ibZI6w6jOgvs0iT5b5tabROpLNcaDeMMsPI6hkcI6Q=;
 b=V2A8SOLtLoYrpFsBYeCnJUNVuLrMF1ixN5qFpVVfyg/fAUFvk5wmKVibFY2I7ZuZ4myzJoy9FYrvR4ifyrkukMmRecvM5o6ibm8zyhN3fdVuhLU95bqmWpkBj6A80zeshG02TyNr8V9U3MhsdRwpPfW/WlDMhKNBRytLp0gSht0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4740.namprd10.prod.outlook.com (2603:10b6:303:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Thu, 8 Dec
 2022 20:01:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 20:01:17 +0000
Date:   Thu, 8 Dec 2022 12:01:15 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        tsahu@linux.ibm.com, david@redhat.com
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Message-ID: <Y5JCi3h8bUzLf3cu@monkey>
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
 <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
 <Y5I78soNmAFv7pi8@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5I78soNmAFv7pi8@casper.infradead.org>
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4740:EE_
X-MS-Office365-Filtering-Correlation-Id: 100a85b5-85fc-44aa-350a-08dad956f7d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RaB9jzrUVkfUdaiblBn/3CaE/R4fHEiFluPQz1Qgj3vQb6f9MuULN93+Chzp56SVtShUI2fFcyM9BqgEwrAmeKyr2PHm7ZdpY/OBAZq2AVVEO+mrqvK1vH1w2LYib9MbLgTYym8MzKQDELIK16PbNL/RDYxR2SrAdmmnqamltKk2xFHB9Hm5TDNVRz0Dnst2urXTIbVLzhoARUbVbYDmfPe26fgBlJSrMaiguMeqQbQTVaUH7pBFsMchOQLSKMoaENUY+4f4C7zOCuZK82Q4Uli6U8Vp/1D/8GWFZlSJlx3xgjGQzUHfKPaiisWUA7Lzk1isxcNDaK8uZaJ6kjLD1BToi9baen/uGyvcbatcWTv5EoAxC1wRsLSTw4PknBWzEpcjgYdwcsngViHa7ljOSTL9ccIVJ4nGjkPYRKjoZG9O9Z6LpIKLiAilj7MDJhD/m1IuDIBqMSznG1G0N0bsAbffbA/rSWqexjRt0KppFnoTPPC3UnaL6yKE+fe+KT+ZBvK2KkGjUeOho99xS3+gFPZIakuQU4OICce3xtztGsIR0ch8dB2eyAyxQ/4KspLKP/AMIQBGpd6JzE0ZemQsbr0dRUO8jrTiFzek357MzQi4E/MwINjJQFIKr1Im8OmaoXID7FL/3esQEqAtHAO36g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(478600001)(53546011)(6512007)(26005)(9686003)(316002)(66476007)(66556008)(8676002)(4326008)(66946007)(6486002)(54906003)(6916009)(8936002)(41300700001)(83380400001)(5660300002)(6506007)(186003)(44832011)(86362001)(2906002)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oTq45sw3fA57AtuYrZYxXNryJnpF+CrKrEaoCBOqg4rFR/7yoOdJAPtolGSn?=
 =?us-ascii?Q?aFrzVH1QGwmg1Mo47ukUTx7LKgvziRbYtadiqLQRTGxgnP6wCTzV/lN5KLn/?=
 =?us-ascii?Q?MgdSr8wzQKPNHNEKBhEZHzQc/BOXaYGbOyHBlc2OfOJCFyFK6O+SXDhAP+GV?=
 =?us-ascii?Q?Tntvmp4Zzafx+1ahvc3ygjd+7DlG1rImGYt0ZVfRFIXIl4/RuHsAwXeSqI3O?=
 =?us-ascii?Q?siqhsad6WyF8rPzBysmv5lwFoN32lGQSy+q/YAGPebiQ7rGnZmLQPcRCGoGY?=
 =?us-ascii?Q?/+M6BvLT1pbyjRkW8nyAWsHfaL5umonawnAje3FbT8VrOmaC1x6nPEMtgvoR?=
 =?us-ascii?Q?UDFnurJucPxDqM7vFitRBv9qc3HCpO5QsrfAMNdpYUzXWyz/Ck05jh6ABokB?=
 =?us-ascii?Q?I1qk5Ak+QuurKOUwdUsf5uSECVcGz4pVG+mbCKsvCBqzFTEQzoDbVhs0n3gd?=
 =?us-ascii?Q?j6gsvm88wQgQiNP7+iGe1KHd02qeaSva+eLCLYW5iRSqLPnZEREJ+aFOuaox?=
 =?us-ascii?Q?yF2dnGR+1pF4TGxl18Htce65U/BJtO5jSVNdsjG7A/gu9dMoq0QL93IcnGUh?=
 =?us-ascii?Q?ewrgzkNVfY9VQeVRBQeOvns8ZxG0fNLJFydMihfXaYrZpRuLo9CPTWXt7d8r?=
 =?us-ascii?Q?A0g6+63t4AAAaEs+qwXHS39YMSvv/RldjyvWk+TW+SeyXIFXGE3q1FRBoTVO?=
 =?us-ascii?Q?aENNEFrHD1mcRwRqUkKBGEVqpRyyg18o7S51RreFDhm6UBLYn1aOcVK1taWz?=
 =?us-ascii?Q?uCJgeuFCjDYySi6J2PwRNbKkFN9dOV8uFx+tNthqGodS927k44HIVcjxyjaN?=
 =?us-ascii?Q?ceMMEWqCc4Gvtom28ebzGmv1QyCcBS55CjOy9R23q/f6/i81VlaqW6So606Y?=
 =?us-ascii?Q?zwxx2AFwZdlAdrzly7KhKTBJ+AWZwlrb2qMSKXnuFmlrjeQxC9TJh56xcDN3?=
 =?us-ascii?Q?3KYvnhgj7af0vLJ4cIGtO52wDxJokWtLCkNpt0b0d6EA+F3ru8nZqBSia3Wl?=
 =?us-ascii?Q?9Zlx3XtTQ18LvvWoznEPLXh0P44SUoxYZIfv8h45WTC6tTx6LmtzvYMylsFm?=
 =?us-ascii?Q?pRZghF+QAgTJfeRXDgrNG14rnCu+2N2HNVIc9vBC+b6jhe8Ozt+uqe2crYIN?=
 =?us-ascii?Q?EMIHDwIQvuFd56DKUCN1ZHw8BLa+cExvv9cF7QBMVrEYa3USGuK4uAg0uQFK?=
 =?us-ascii?Q?rtT7ACQS6fgDoDY3cpq1CuVLm0T2KggRLeYibEK3v3s8yq6lrLnS6D8pxbDq?=
 =?us-ascii?Q?R5/4cRPWC+11BBG4t/Um0tgs5jMMhNKBIvUAgGUvBmKy2qk13W0TZD7myA3O?=
 =?us-ascii?Q?Knm73EwvLdRos9wn7aHBs4c4cuStegkWBv6rtSKZyU3ca2y6h3QMsNqI8R2e?=
 =?us-ascii?Q?8UkWlWg+xB25KCr5lw+FYpTTbIWxo7EBgodWrx4H3xmanQWxMHSKplFPbW3I?=
 =?us-ascii?Q?IgFpJW+P4Tb4+kmEPo05XkdWu0Tu8+jgWhojdEnJvZKzndTHXZIYnSssSr1+?=
 =?us-ascii?Q?boZyFdiasaYEY68vnpvYDXuNbnS8eVs4vzHVOWyFTZg5cjT2/bPVStb4Wivi?=
 =?us-ascii?Q?iGUDIAew/XA58Gd/mHXA7otDmIqDoxYrYgyOY9m0zfpNIJB6ui98m4RQ+eV5?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100a85b5-85fc-44aa-350a-08dad956f7d4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 20:01:17.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtBSrUdrP9uylq9TNWqHUl340szalFj7u9ubj5HB/v9g70ERdcOXC+AuWv0wzqUZxiDczD7iQwHpltrHRQQxrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_11,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=932 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080166
X-Proofpoint-ORIG-GUID: sGPOXi5xc3mS1UANPsodj5sfqx1KG9AX
X-Proofpoint-GUID: sGPOXi5xc3mS1UANPsodj5sfqx1KG9AX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/22 19:33, Matthew Wilcox wrote:
> On Thu, Dec 08, 2022 at 10:06:07AM -0800, Sidhartha Kumar wrote:
> > On 12/7/22 6:27 PM, John Hubbard wrote:
> > > On 12/7/22 17:42, Sidhartha Kumar wrote:
> > This works for me, I will take this approach along with Muchun's feedback
> > about a wrapper function so as not to touch _folio_order directly and send
> > out a new version.
> > 
> > One question I have is if I should then get rid of
> > folio_set_compound_order() as hugetlb is the only compound page user I've
> > converted to folios so far and its use can be replaced by the suggested
> > folio_set_nr_pages() and folio_set_order().
> > 
> > Hugetlb also has one has one call to folio_set_compound_order() with a
> > non-zero order, should I replace this with a call to folio_set_order() and
> > folio_set_nr_pages() as well, or keep folio_set_compound_order() and remove
> > zero order support and the comment. Please let me know which approach you
> > would prefer.
> 
> None of the above!
> 
> Whatever we're calling this function *it does not belong* in mm.h.
> Anything outside the MM calling it is going to be a disaster -- can you
> imagine what will happen if a filesystem or device driver is handed a
> folio and decides "Oh, I'll just change the size of this folio"?  It is
> an attractive nuisance and should be confined to mm/internal.h *at best*.

I suspect it was placed in mm.h as it is the 'folio version' of
set_compound_order which resides in mm.h.  But, no need to repeat that
unfortunate placement.

> 
> Equally, we *must not have* separate folio_set_order() and
> folio_set_nr_pages().  These are the same thing!  They must be kept
> in sync!  If we are to have a folio_set_order() instead of open-coding
> it, then it should also update nr_pages.

Ok.  Agree.

> So, given that this is now an internal-to-mm, if not internal-to-hugetlb
> function, I see no reason that it should not handle the case of 0.
> I haven't studied what hugetlb_dissolve does, or why it can't use the
> standard split_folio(), but I'm sure there's a good reason.

The hugetlb code is changing the compound page/folio it created from a set of
individual pages back to individual pages so they can be returned to the
low level allocator.  Somewhat like what page_alloc/page_free do.  split_folio
is overkill.  split_page would be a closer match.

It makes perfect sense to put the function in mm internal.h.

Thanks,
-- 
Mike Kravetz
