Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE675BEBA3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiITRLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiITRLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:11:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2215491CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 10:11:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KGJD1p028862;
        Tue, 20 Sep 2022 17:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=UtW29Sn4DwJn4Gd2gh31I5vc7GZr+rSUr/SZ+ZgYxJo=;
 b=XN0nk1glimldre5K5/j51Mf4fEBANmoAeO5bRoBQ/B1yMmR+5PC0/QCpo22IEFGIohmZ
 WXh/1t2qRTMJ96yLDVnwwMX0PtRm8xKUgFh4jeS3jFxkkHKQlH6IWgZDY5CfqhE0sz9R
 mFIEh0sUFTu0DDYxc62+BzYqkbS8jJ8mplRCVan1C1yNq5UmteNTN+iqhY8rEEgedhaF
 SQSPCA5Zxoc85O7MIqH0a1Xl6KwGzyqfylmtZzXM7mB1d0NNvdzl90QvWjbg0cxBiBAQ
 3bnoLVDM+ZYo19LFJGnRI2NYkGHUljUqTVujUB6g8xNSOYuVLm1bbCr51m2DUIc5kawI Sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68rfmpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 17:10:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28KG6eCQ035750;
        Tue, 20 Sep 2022 17:10:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3d2hya3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 17:10:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZX1TxpV9ILU1kOIVLUgO4Pn975vxgviosxXzCUftc6FxhJ78Cf2RLdtt5875O6A7rKi2yabESAh6fIoJovL0QGJrDifwXobbzGlEReyYFu5Wd831danjdsud6sIxISXj2tm5iFYkW/wTTtWx598Ds99KAIsUe7Iv6sX8wymv/yS6R0uVKbB/4wHTyMSRaxtx8QMyPqakkUPQJcrKt9o5G7d7cQeCJJYBAXgMg3ZKuV7FK3KWbEPRYvlWDDEllUv5eOQVx6jLH1BgfO/hrWgxWVPbCdxQq4/E8177We5t0Y+fY/Fqmkhuv/I24l3T1knKIjppMVm9lLXlmswGo974uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtW29Sn4DwJn4Gd2gh31I5vc7GZr+rSUr/SZ+ZgYxJo=;
 b=Xq31SGbfa0CkQ1GtrJA6cOvMV5xjGHRtQLj+9Zmh6D5A62mqHpKTxDtv4W4m9m2xxYGBW15LxXnrR+KcHxDfwRqG63Gu67xWy/zu2DXq/bq4GsfKfhiuhH1howgqUJhY1nKSej4gw0YNJm0x2sBYIVEWIgyndobA+dIx7iWdKRtQpW+TrJsybA8K2xHyPl1QM4vWMp9v8LITQj4aA0hmYZSdapgWCYMCKR/9IcKTC0ceSJF+PT7ZGRv+8a8kW63B+IciZLRCRhKgcFJ1v0ZwZROEY7UvLiz2CYNbhdMiUkK3W74NgWRbbs1a0FKFW6fM4a0c1ANERRylDffuvf5WJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtW29Sn4DwJn4Gd2gh31I5vc7GZr+rSUr/SZ+ZgYxJo=;
 b=OW1S5mtSHbafbnv9lBd+blHelxTW1ifOL9bkj24KgASvZlxNuzsOa1j5zsM9xqzgZpC7+o1u07jdbg4D3mknWSH01OmhOukej418g35hhrs3uai5yJ30B+m7Nj6eoJU7CyeHK/tAvFwWbuM4NOLGDvx/oO4lrcY1BA5O6SvNVLM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 17:10:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 17:10:32 +0000
Date:   Tue, 20 Sep 2022 10:10:29 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] hugetlb: freeze allocated pages before creating
 hugetlb pages
Message-ID: <Yyn0BZu1gNHG7pZ7@monkey>
References: <20220916214638.155744-1-mike.kravetz@oracle.com>
 <Yyk7cN8KhUlNFmM8@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyk7cN8KhUlNFmM8@localhost.localdomain>
X-ClientProxiedBy: MW4PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:303:88::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aae54d3-2c64-48c9-1db9-08da9b2b064a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6QMZmpBRh/zTFjx+08oKuQQThhcsNll6DobXPn7eLgNSNnUAkz8rnaOEtwUDC/HegSw9fCNenergNBN7FMIRqkTyUOeahUS0cwsyJaYV7lSZuPTkkkNKEVPqcivjB2Oot8Xc4NN5q9x2Whf9qKku5bgb/JLWnax3asuSZsLDK3Oz95e9lgbF7hFNNADxyOS7QPSLHtOjZfH3JU4NnbGrbM/DfYPxfzTjBL0Azd65C4/CL+oA2+M0phb3EnODdFKrztXO4edJmqtX20SNd+zbCXz56wjIIdXxf8fZKezSYHs/QPpp8j6YwdJ2mJCc+pV+36uQlWYOPaSKd7NfqybrDb5eoWUhAoBG5v2Iu9XIstdkwMIGi0N/oFZPcjge/gK0+1GGiZNVoUogC3pg667QmaHnACsR0TXPbXExOdYxwDHNl+oftW7Hz7XpKk4VJbka+nImzczVmcXLwbExePYPwgPdGukYz4gsSHjQSRAGC8a2lAP5whbbCAPOa7r5BIQYMrdRntuRU4Wnu34x/sxieb66oHiZMGS8dtbwbDbuzdowGpC3hSpkRjYbT9aukxp7XVI/IbjGOn+aEOfMXcONwx+AQ86raM0Yaxr332ouJzbGCrdrO1rMCJB5aIGxH0NITpsjjry31ETmhG2brHAMA0AG+MV9zVb6tKoqj8I6no2GFnPHgfM2eG8EnapfusNB/WabeHYOW+nKUUzp7wMogaf+MakM9A7SseaTAA5xqLY8vqRA7yc9gst1yrFDwtdaz9MiMj3YW+QEeubDBOL6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(186003)(66899012)(83380400001)(44832011)(26005)(33716001)(53546011)(6512007)(9686003)(7416002)(6666004)(86362001)(4326008)(66556008)(66476007)(8676002)(66946007)(54906003)(6916009)(316002)(966005)(6486002)(2906002)(5660300002)(478600001)(38100700002)(8936002)(6506007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X9PdIrc7DNqY1TgIlz7nrKRslOyWFBCjj/z239y6pcxtIg88HAqKZYhTql88?=
 =?us-ascii?Q?hzQYjRPZnI/ztQmQ/gtZrKiHIQgPa/0k1CwTsSUEeQ/dP8NYbosjTXSUvO/4?=
 =?us-ascii?Q?tjYL8lA8kV3dDm8FW92xFPpwLCeacvjb+15iMxKeolTRm69R+aotlAJ5zo19?=
 =?us-ascii?Q?SqBOuLvn0sgtZEb8eVQia3+n6Kx7TMaDFBxtfVdVqkiw8tlc9YUja4XN/E5Q?=
 =?us-ascii?Q?WUQRifA5KUMFBbOa2PUIsJw2sJIY1lxmsj0p0Hkkd6KS+SAq9XQBLFB2+Rud?=
 =?us-ascii?Q?jKeIP4pkwfIxB79Vbs89CivtQXSH4AnnpK1pOGDPS7IKBudjCkL+78qasatI?=
 =?us-ascii?Q?nOqcIZRsR4ILP579ZzCkFxdj0iRdXkV7SvP+MF0VmpDhRJCxh4We6TDzqOEY?=
 =?us-ascii?Q?0IDbkf8xX2pNltBfBcACr4wHUvPF9MC7UgZSKLF8NO+RJJqmB7qg9EJLiA1W?=
 =?us-ascii?Q?Vaabz6jqhNzgNEn1oEfFkM25Fuh/zPQIGvKF7RKS0ske+dw8YwXAI889ZDIe?=
 =?us-ascii?Q?ckGwYfFrIbJaMpsAc7MYoRukrG85zUwHkayVg+YZ5G3uLEInir31QTubRdNp?=
 =?us-ascii?Q?ZR73b2P7i388nFbXaY/m7m88R5+izJPtIeEgcUs7oFAnoARWEKrbfaN0iCb8?=
 =?us-ascii?Q?BdlPt8zVbxuylaJNCNm6UUtpRMegnxIHCiyiEl54PWteJzNTaLUMt2p5MY6H?=
 =?us-ascii?Q?k3Q0ydev696BEhYIYq3RIc6yake0MauiNnH+2UcOllTzjW1C9n7IhFBYV7Et?=
 =?us-ascii?Q?4nNS7rHUrBCHQ2VYeCIGnkT0/Y2phaJmBahgpGOd+w9lbmy5Ip4v2akPKQkO?=
 =?us-ascii?Q?KFnKSjMODYAMTsX0djZ5nco6lF2zuQlyjZt299iwVmetUFxv1XxjT7bKfmKW?=
 =?us-ascii?Q?hVxYf3mMCr2Eib+gR0qCyBzaMZzWALhSUd/NJONWwxuiBGhTEu/KjBPOtI1s?=
 =?us-ascii?Q?9JTpKlWSVOiWvjoGP8cpzaN4PiEuZLo8GopPFgetYX5vzUvGYA2YABkhfH4R?=
 =?us-ascii?Q?4WHIfx/khzCbb3PPMZNUHNidQiPd9Z9iVSBTeiQpoQ9nAF7KecOMndV8bL1e?=
 =?us-ascii?Q?wD6YLeq7hu5RZa7HFDJm7pgsx1wkiJMuLG8EZ1mmAx9IPuFAGqjP1WozEXpT?=
 =?us-ascii?Q?a+9OlpPzRbnuR/YCOBqKf4n4p+te6wxPJbhoz2FuFHnb76KAfonEGEW01fub?=
 =?us-ascii?Q?AfqN8HpLJtCDIXlGn/DgzlzlAYwfqjJ3oHfKarD4J52SLYC75U3U7xCdFTo+?=
 =?us-ascii?Q?hpeIGaw+9oq5BB3a0/7Kd2Rda03UDlb/A3pH/QC0zQtIZoubmt/NNfCBATgb?=
 =?us-ascii?Q?vidkxLlPoHdeNVhilfrlaczWTKwljRWvLacYTKf4KRKK5+Fdes1Wq3YiWT4o?=
 =?us-ascii?Q?jYV7dUe4HFhciEyMextJn7mA5AHWjbvLIK8YNs/1bL/hMbnqAriAB7sntNXy?=
 =?us-ascii?Q?YEbq4X7gcNHxUa5wnosc/aBhzojfJT3ICIBn7lq25OKeltpuoOjQFSH3pXC3?=
 =?us-ascii?Q?wO0vbQAl6nlYqI5aHkS3W3feQUZYU1e1ym4PBRII6A2z7YuiA3n30xDALPwS?=
 =?us-ascii?Q?HK3yN6nhi8tMSlFeqfsoueVmaX2/8lwUKVbSa7DrYOsRmvoO5Fo2nhjRMt4t?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aae54d3-2c64-48c9-1db9-08da9b2b064a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 17:10:31.9877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/wRHkQ0ddjYc08OtqXEG9RfzTgsI7eh6vbDIlbEGCGMrVM01/I6wvt5DV78uqmObgJeuYbjlzacA2iRPKDnHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_08,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200102
X-Proofpoint-GUID: 4vif7aqwRMZ4m5W8q0I0hwqj7iJqgoIk
X-Proofpoint-ORIG-GUID: 4vif7aqwRMZ4m5W8q0I0hwqj7iJqgoIk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/22 06:02, Oscar Salvador wrote:
> On Fri, Sep 16, 2022 at 02:46:38PM -0700, Mike Kravetz wrote:
> > When creating hugetlb pages, the hugetlb code must first allocate
> > contiguous pages from a low level allocator such as buddy, cma or
> > memblock.  The pages returned from these low level allocators are
> > ref counted.  This creates potential issues with other code taking
> > speculative references on these pages before they can be transformed to
> > a hugetlb page.  This issue has been addressed with methods and code
> > such as that provided in [1].
> > 
> > Recent discussions about vmemmap freeing [2] have indicated that it
> > would be beneficial to freeze all sub pages, including the head page
> > of pages returned from low level allocators before converting to a
> > hugetlb page.  This helps avoid races if we want to replace the page
> > containing vmemmap for the head page.
> > 
> > There have been proposals to change at least the buddy allocator to
> > return frozen pages as described at [3].  If such a change is made, it
> > can be employed by the hugetlb code.  However, as mentioned above
> > hugetlb uses several low level allocators so each would need to be
> > modified to return frozen pages.  For now, we can manually freeze the
> > returned pages.  This is done in two places:
> > 1) alloc_buddy_huge_page, only the returned head page is ref counted.
> >    We freeze the head page, retrying once in the VERY rare case where
> >    there may be an inflated ref count.
> > 2) prep_compound_gigantic_page, for gigantic pages the current code
> >    freezes all pages except the head page.  New code will simply freeze
> >    the head page as well.
> > 
> > In a few other places, code checks for inflated ref counts on newly
> > allocated hugetlb pages.  With the modifications to freeze after
> > allocating, this code can be removed.
> > 
> > After hugetlb pages are freshly allocated, they are often added to the
> > hugetlb free lists.  Since these pages were previously ref counted, this
> > was done via put_page() which would end up calling the hugetlb
> > destructor: free_huge_page.  With changes to freeze pages, we simply
> > call free_huge_page directly to add the pages to the free list.
> > 
> > In a few other places, freshly allocated hugetlb pages were immediately
> > put into use, and the expectation was they were already ref counted.  In
> > these cases, we must manually ref count the page.
> > 
> > [1] https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@oracle.com/
> > [2] https://lore.kernel.org/linux-mm/20220802180309.19340-1-joao.m.martins@oracle.com/
> > [3] https://lore.kernel.org/linux-mm/20220809171854.3725722-1-willy@infradead.org/
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Hi Mike,
> 
> this looks great and simplifies the code much more.
> I got a question though:
> 
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1787,9 +1787,8 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
> >  
> >  	/* we rely on prep_new_huge_page to set the destructor */
> >  	set_compound_order(page, order);
> > -	__ClearPageReserved(page);
> >  	__SetPageHead(page);
> > -	for (i = 1; i < nr_pages; i++) {
> > +	for (i = 0; i < nr_pages; i++) {
> >  		p = nth_page(page, i);
> >  
> >  		/*
> > @@ -1830,17 +1829,19 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
> >  		} else {
> >  			VM_BUG_ON_PAGE(page_count(p), p);
> >  		}
> > -		set_compound_head(p, page);
> > +		if (i != 0)
> > +			set_compound_head(p, page);
> 
> Sure I am missing something here, but why we only freeze refcount here
> in case it is for demote?

Hi Oscar, thanks for taking a look.

I think you may have missed something in the above comment.  For gigantic
pages, we only freeze pages if NOT demote.  In the demote case, pages are
already frozen.

> We seem to be doing it inconditionally in alloc_buddy_huge_page.

In alloc_buddy_huge_page, we are getting a fresh/new hugetlb page.  So, we are
certainly not in a demote path.  That is why we freeze unconditionally there.
We want to make sure it is frozen before it is put to use as a hugetlb
page.

In the demote path, we call two routines to 'prep' the set of free pages.
- prep_compound_gigantic_page_for_demote which ends up in the above logic.
  We do not need to freeze, because the ref count of all the pages are
  already zero.
- prep_compound_page is not hugetlb specific, but rather used in the normal
  allocation path of compound pages.  It serves the purpose of creating a
  compound page of the appropriate size.  prep_compound_page only deals with
  getting the compound page structure correct.  It does not change any ref
  counts.  This is desired as the ref count on all the pages is zero.

Hope that answers your question.
-- 
Mike Kravetz
