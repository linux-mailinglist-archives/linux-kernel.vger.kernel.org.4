Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734FA64763B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLHTc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHTcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:32:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4131FF9F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:32:54 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8HhlXM000805;
        Thu, 8 Dec 2022 19:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=MJ4KzAbKU5NR4ibkTJaE5s9hDV4KwkL4lU5BFqPMD/A=;
 b=qpWKvouLfBZeiAyji8RfpfilE3cXgJXLBEc39YtJRweVVLDjZPLFDxAmReTmpPD63fj1
 gy+TsnJeRG3PoPh6rYFUg3ZmUSs/9D4rvhzk784us+Px2r+/q2Z39Y9Kq7epmRSTlIMN
 ghghZ8p1sZfTd18mafBysEzAL7nRJ0KRKx2aKuHVBLHMOl1D3zKG6tMx9apmQvaBSFkv
 rhD+W+lejtbgpIHWls7JYMfWi11D8szw+wKH2F+BIC3Yq5NG47u2m3FoDYzc7v7hMmsl
 z1Y8hGy7Oh4zzim/5fGxiNO0b01EvNfvCbcoIGdvWHWBsc/x16bbYLnXXJsLYw1na2jm yw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maud73r44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 19:32:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B8IJUsa032667;
        Thu, 8 Dec 2022 19:32:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7eqe46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 19:32:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQI0PEWbWYEs6H6hL8S1O2HlI6vMagSk3dimDhE69+Yona3xBy3kqK4McHlPlqxDXJWh8YFCGGDYstiFGCTA40Jjd5374jF6hXmo9qCjBlg3bt5sAFxc0IhePxkJqNgg4QPAOD1JeT1PbDA4nPbo6dvQn20acydqvskaQPUytl9FbgDmmj9JWiwPw8gEbrEHbKRALr4cUmns+CbUaOxYIe76FE0hN7oX3eFN8MYTaLbRCP5zWtpVZD1XAOW+S4OQjQXFY+eNnjVNYi5+oQsJfZC5lxEZ9BbhrgLB9t3ODtkc3B2irtlKygGLssB87W+qb1M5/YWuoIiMC3jd9UOSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I23PxN/Gi6ps4uXDBvog/hPU3deMvGkeBwiTHNEQGsY=;
 b=GCcCLCnNQTwOW/ojMCvXs0T7exgORmDqZRhn83x3mJax5K3l45IjrhRDoi+mCzhcEK4YL3JRWbeqdgczj13qS0tBT5AWnDOg+PdFAjWHz4G4g+YqUNkRF5g4BC0K71WNufMcApshuMNGxoRJrLX14CueGz5TBawmErh6D+R5rRZz2oVMALHf++5f9WTa+frRV8RBkPBHpQCr+ASpUbhalg8aA3IzhibTdC9DtStXGz/PAbi+BaT6CcUEaaQBlFur1gihaC9v3RC+R4Z1qjChJkVyU08LLaCxFMKtRKFizEfsuStEFFXY4Cz3lergOxQeeiSq8UJeSi+PmCPoA/81zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I23PxN/Gi6ps4uXDBvog/hPU3deMvGkeBwiTHNEQGsY=;
 b=vNRpFzMUlOw5uVRm0SZt2AfmwFbPovd2uzU8M2vGPtwqDBg2iTto49wR7GiPkAGlGW2UbS3iEwrhLsoIH/Us/NCOQX4KxQs1DACpwPSGzvRrmOrfvJQWS5RijXGaYiP9z40expv8NiuhdwwBGFxmwaepusNUWtFUJYZmMjm2NA0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA0PR10MB7136.namprd10.prod.outlook.com (2603:10b6:208:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 19:32:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 19:32:33 +0000
Date:   Thu, 8 Dec 2022 11:32:31 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, willy@infradead.org
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        songmuchun@bytedance.com, tsahu@linux.ibm.com, david@redhat.com
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Message-ID: <Y5I7z3Kz4Bur4e6f@monkey>
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
 <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
X-ClientProxiedBy: MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA0PR10MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 6baa499c-9c65-45fc-99c9-08dad952f426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54pgwP04GwF/Nys2RIw8il1kMgJzZOyv3v6sqvXrsNZujzt1APiW+QD9C5PZIUzIm2JkqZygOStZFKHue49Mqmwm/b+srTH3qeURzr+90o6ujiNyhRzenN8TwEiZVU0fNFAio/xbmsN+uoIttjx+/PbGwF3vKotFcm9B5oBF81DoZIrugQxFc52Jerw+eonpkTOak5K5FNdfTNiENLJmzVngQznjJFvRA+DcogEunXgVBjSKmLDA0GHXOx0ThZlV+UBFv4gZrO3880HdgZPl6EnRcDV37m3lx7mlPp1mAj70tIxnynQEZTWZlxn5R90B1ieASTKzpCtamJzTagKP3Sv0Eyhhi5h49jxrapOwVy6+RrDJFpNG89QZw7EsFnxvdos9F9nsAyx1TCaReDpqkR+nPawtxncIZo+PDhkOGgeHm69s5/HvXjnu7XZ85EiQAddJHUHyL0LhkoNcEqEej4UT3SS/QdVnNCUu48bLt0cTtecsvHoxDcP4RIyhUpW7XP1EfPr37dXfiHzC6Rv1HMTtJ5iG4m97xvv0L52g6pfEZNkYV2d6crkXpTuwd2MbUhWaiLdpkQLVLsDbb7whiApfi+3rg4tGAH9BS91Mbtvf44386vIdSW0SwARDvIUK/dno77xXZ0lRbGNVtHbHXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199015)(33716001)(86362001)(8936002)(5660300002)(83380400001)(44832011)(2906002)(41300700001)(38100700002)(53546011)(6506007)(478600001)(66946007)(6486002)(9686003)(316002)(6512007)(186003)(26005)(4326008)(66556008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GE6+zEK7yN2rqg9WcICIChZP6YTIqrOqVKkR8p7AvLXQKorjCzXjOCKemL?=
 =?iso-8859-1?Q?jjPjsc2PUarDvue4+TNTTuFnlCSjatiJzmKHVJJIkcsY6M8rP9msczm/Mf?=
 =?iso-8859-1?Q?HhBQjgU3FbX22onbNm9iNIsiRv6OVpzAB5GAvlf2grpMVMWPydcaVpuPM+?=
 =?iso-8859-1?Q?CLbJy9nGLUFW8hhPu47CnbcCKvtpun04cYu1lmoSIpxDmBHMHeFkk/G24O?=
 =?iso-8859-1?Q?92NlFKVIqXXaOztE2T7XRDhMqWgXVee2ZUzU3OcKdE/pLxuykjvwde2AbY?=
 =?iso-8859-1?Q?98O18iR+giqdKNY6mMDCHZGA+uYnIVsjEvzFsRbP2KEMMIvNpWuU94E7DR?=
 =?iso-8859-1?Q?yh+3uKA9zTS8ITPcElE3VIPXDVFoGQ+lU0w+QranrpzTH6Ayauua4nl5HK?=
 =?iso-8859-1?Q?EyFmzMSXYKnPeEBPxM1OsMg3/xwCmmWcCNDtXvHazBJlph5Z4roqPEwFE3?=
 =?iso-8859-1?Q?6Zj4NvBg9WgY/CUfR6/0/eiy6K14Lq51NolYQT/Xn1+WnaZTFL3YfFC8b8?=
 =?iso-8859-1?Q?3RdDGq9lF6heS0m2zOR8kqnuiA+gwIvhEJxJiGEfSGjlij558XxVCanDqt?=
 =?iso-8859-1?Q?K9YnqBAvRf/Hkb2/ojm86W+fxzx4jJ7aftdgogTouwr9GQsEQWEZOcBMTs?=
 =?iso-8859-1?Q?MajZa28rrUwnH6XxLnNuxWXDFJPM07TLAXifZ52K9UjCfzkBKJ0fap5nTb?=
 =?iso-8859-1?Q?rf9LkzPDWV/cSYRv5NcApAzMq3yCpzbd474QBneBluvGVzP/+djg0i3KdJ?=
 =?iso-8859-1?Q?0PDWkz98xhEddWsZIXmG9Z6MO8KgdH9CY60y/5wiFTavTClDl0mCHn7e/z?=
 =?iso-8859-1?Q?KMAJAlU7wqg3c2MZAHZrJnrNhk+wklxFxaNq9krBW2fcbE4L7hwBfiJRrv?=
 =?iso-8859-1?Q?g7cYysTlb6N0O/uDXW+ax+40quT/nCsB0e299aUPrQsKm99IaiXdZ+m+O3?=
 =?iso-8859-1?Q?/ImUBWP9vwOeuLmprcOcyWO8Mecy5VeJlO+1UENHqgFNPH8/Hhowmhg8iF?=
 =?iso-8859-1?Q?N9eLmrzSapAevWHxSGIaRZS4gIaKrm+73mKUJsgm92khmO66nVb97RvlC+?=
 =?iso-8859-1?Q?421nEK/7cdqzgzEKrJEs9C9ermDAJGNwjEc2sHWc796GhvSYizAvSzCpkz?=
 =?iso-8859-1?Q?AfZXQx4ODexR6CF3XbXXndEwHFvKutEyb/BnQjD1PFXBEa3Qf2YAV9p2tW?=
 =?iso-8859-1?Q?Z6meGIa/LU1cMQfda8n08l8d5PYi6iHFxWqv07mxVvYVQE++tV0zOAeJMg?=
 =?iso-8859-1?Q?6CY2yjcwuw7y47LStyq+m2qEAgT/dMRXTE3odSsY2p9BYJdKvlvWDosCJE?=
 =?iso-8859-1?Q?/s3Oow6KDsVRLJD8W+Jn2O1buvV6LIpIW7jgiMXtRIgCPxBYvWRIl0nS/U?=
 =?iso-8859-1?Q?7sVV7NYyE7kWEpdb/NvRWfnim2Y//GWOkwahAwcuN21CyLSJeveGP3VGiE?=
 =?iso-8859-1?Q?7IUzIwlg5fnoLUixjnG8fjkf0Oa1QwpGPkGEF5JVNRLECV26uS8Q4UJ/wQ?=
 =?iso-8859-1?Q?c7ly4Yk/akfb8St8bxH2zIhU/ye2H9pTcJGCgh1H4d8Da3zYtCei43N/HI?=
 =?iso-8859-1?Q?/VB4M6irc1IK6syeKyW2H8oPR+PVvJZ8ZYvWE3nyeaGo/JjuuspPtRNZTp?=
 =?iso-8859-1?Q?q8dLr8COG4Hrfp8gYChtHDt2ivXYKuujGRPPj2Zx22Y5OelEFO6pnAjQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6baa499c-9c65-45fc-99c9-08dad952f426
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 19:32:33.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jz8LHNid9ynm2WqHz6X+0sqyfE68odmwPjWzfHD2HPPI3U29LI4ffSmmA9ovGQ9CKLskffE+42jp4KKiONHRwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_11,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080163
X-Proofpoint-GUID: 9eeY_mkQ5haacpSqz6Sw8UpcPHU_I1el
X-Proofpoint-ORIG-GUID: 9eeY_mkQ5haacpSqz6Sw8UpcPHU_I1el
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/22 10:06, Sidhartha Kumar wrote:
> On 12/7/22 6:27 PM, John Hubbard wrote:
> > On 12/7/22 17:42, Sidhartha Kumar wrote:
> > > > Wouldn't it be better to instead just create a new function for that
> > > > case, such as:
> > > > 
> > > >      dissolve_large_folio()
> > > > 
> > > 
> > > Prior to the folio conversion, the helper function
> > > __destroy_compound_gigantic_page() did:
> > > 
> > >      set_compound_order(page, 0);
> > > #ifdef CONFIG_64BIT
> > >      page[1].compound_nr = 0;
> > > #endif
> > > 
> > > as part of dissolving the page. My goal for this patch was to create
> > > a function that would encapsulate that segment of code with a single
> > > call of folio_set_compound_order(folio, 0). set_compound_order()
> > > does not set compound_nr to 0 when 0 is passed in to the order
> > > argument so explicitly setting it is required. I don't think a
> > > separate dissolve_large_folio() function for the hugetlb case is
> > > needed as __destroy_compound_gigantic_folio() is pretty concise as
> > > it is.
> > > 
> > 
> > Instead of "this is abusing function X()" comments, we should prefer
> > well-named functions that do something understandable. And you can get
> > that by noticing that folio_set_compound_order() collapses down to
> > nearly nothing in the special "order 0" case. So just inline that code
> > directly into __destroy_compound_gigantic_folio(), taking a moment to
> > fill in and consolidate the CONFIG_64BIT missing parts in mm.h.
> > 
> > And now you can get rid of this cruft and "abuse" comment, and instead
> > just end up with two simple lines of code that are crystal clear--as
> > they should be, in a "__destroy" function. Like this:
> > 
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 105878936485..cf227ed00945 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1754,6 +1754,7 @@ static inline void set_page_links(struct page
> > *page, enum zone_type zone,
> >   #endif
> >   }
> > 
> > +#ifdef CONFIG_64BIT
> >   /**
> >    * folio_nr_pages - The number of pages in the folio.
> >    * @folio: The folio.
> > @@ -1764,13 +1765,32 @@ static inline long folio_nr_pages(struct folio
> > *folio)
> >   {
> >       if (!folio_test_large(folio))
> >           return 1;
> > -#ifdef CONFIG_64BIT
> >       return folio->_folio_nr_pages;
> > +}
> > +
> > +static inline void folio_set_nr_pages(struct folio *folio, long nr_pages)
> > +{
> > +    folio->_folio_nr_pages = nr_pages;
> > +}
> >   #else
> > +/**
> > + * folio_nr_pages - The number of pages in the folio.
> > + * @folio: The folio.
> > + *
> > + * Return: A positive power of two.
> > + */
> > +static inline long folio_nr_pages(struct folio *folio)
> > +{
> > +    if (!folio_test_large(folio))
> > +        return 1;
> >       return 1L << folio->_folio_order;
> > -#endif
> >   }
> > 
> > +static inline void folio_set_nr_pages(struct folio *folio, long nr_pages)
> > +{
> > +}
> > +#endif
> > +
> >   /**
> >    * folio_next - Move to the next physical folio.
> >    * @folio: The folio we're currently operating on.
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index e3500c087893..b507a98063e6 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1344,7 +1344,8 @@ static void
> > __destroy_compound_gigantic_folio(struct folio *folio,
> >               set_page_refcounted(p);
> >       }
> > 
> > -    folio_set_compound_order(folio, 0);
> > +    folio->_folio_order = 0;
> > +    folio_set_nr_pages(folio, 0);
> >       __folio_clear_head(folio);
> >   }
> > 
> >
> > Yes?
> 
> This works for me, I will take this approach along with Muchun's feedback
> about a wrapper function so as not to touch _folio_order directly and send
> out a new version.
> 
> One question I have is if I should then get rid of
> folio_set_compound_order() as hugetlb is the only compound page user I've
> converted to folios so far and its use can be replaced by the suggested
> folio_set_nr_pages() and folio_set_order().
> 
> Hugetlb also has one has one call to folio_set_compound_order() with a
> non-zero order, should I replace this with a call to folio_set_order() and
> folio_set_nr_pages() as well, or keep folio_set_compound_order() and remove
> zero order support and the comment. Please let me know which approach you
> would prefer.

My opinion ... which is often wrong :)

I agree 100% with John about these being clear and understandable routines,
as well as Muchun's comment about the need for an interface for setting
_folio_order instead of accessing directly.

However, I do have some concern about two independent interfaces for setting
_folio_order and _folio_nr_pages.  These two fields really do need to be "in
sync" and having two interfaces to modify independently may lead to errors.

Any thoughts Matthew?  You introduced folios as well as the somewhat
redundant compound_nr/_folio_nr_pages fields.

Here is another thought.  Since this discussion started with a question
about "Can/should you really pass a zero order to folio_set_compound_order?",
what about a separate "folio_clear_order" interface?

We would then have:
folio_set_order()	/* passed non-zero order when creating large folio */
folio_clear_order()	/* zero order is implied */

Note that I did drop 'compound' from the names.  The more I think about the
folio direction we really should not use compound in the same.

Both of these could wrap a renamed version of Sidhartha's routine
folio_set_compound_order().  In this way the two fields are automatically
kept in sync.

Again, just my thoughts/opinion.
-- 
Mike Kravetz
