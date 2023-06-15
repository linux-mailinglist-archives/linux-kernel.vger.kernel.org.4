Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF787323BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjFOXhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjFOXhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:37:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3959B2948
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:37:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJgLb001324;
        Thu, 15 Jun 2023 23:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=dNZNe5U6S+3bNvzedYoR7aF4Sb96r1hyexDVr4MUSrs=;
 b=ojBWOoe636U4NlpEEdj+RtVNk1LGQfbAGxTVwhBTI/vHnW9hqmPB001eJjyI6fUHSWB1
 lGupVDF5E4m8rscWkJbaswlBT+UyI6h7R8TJkrFkUcJeU+hG9PqVKlC/iY05k+6cBvsJ
 0Q8VaQFwKfm9IQAy/1fDQzc3sZiuCmRuw9WektTKB7co7Asw/5quq8ZhH4teUr1sANAG
 dtvUa5fWZGUmBvG2deFXSZVeDx1jQ/DhN3Fl23pYGNbMCeThseYLbcT4YzfWXjClr8n5
 b57b/z8CRSByGyMwR++UvSMy05b8Y5MF47C24BQ1nUAA79X7WNjj33lnppZ8em0uIj3Q JA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs237p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 23:36:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FMDWJ7033603;
        Thu, 15 Jun 2023 23:36:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm7kb2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 23:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=herAND6WN3IqFfgDF5MkS3N6dS7gHlKCFVtgkAsMyvwtVRVvK3QvzYEB86dkThuDBlrmeZXubiS+QCF5Ze5uww2Kl5foXUDfYnRHJqQ/rA46AZWjapyQ63H2MmZCrye2I/chqbxSsYqo/usmQyq1gUrYrjevaeG+Y8VgVqqvdWRXa11hzBINAjNNIwG49j1LuLmS49EDqj6S9EiOpvKU1bRoH6wl+tRcM1cuxncUwxqJ2sBFuoGEQSXEbU9+8MOx+TJRd+1t85RI6nJOeMQsqnLA7SJxwFEMrWq34zaRTMjoJMfwHtjUAEYORcYqWpSz67GB6OjIfFgRu//ZrzNSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNZNe5U6S+3bNvzedYoR7aF4Sb96r1hyexDVr4MUSrs=;
 b=KoC9/yQ5yN3WSBV2P/K55mYG62M0fW/PJOFTW5ZekJ1BVp5nytsDcOpF+7OvPVGxY2pNHfcsowh2IUjj/DpxH3LTJVwmdydD38Rqj8PAvxu2s7AxC4DraJ+Edc2H5NXdfvM0zY4eGM2RDrX5KChsFNCJ59DJYlVZurWZiy+HRPWplFWSdPpf2xnbCuub2b4r9+OqBSQYotmqgw2nNHOM6eoqqksqPznDBuwhjjlCUhMr84EgEnh8fd7BL8gE9PWKTIxdpzPLkx/4fMNnr05qNnT3d/dO36nosTYA1KN1VC54G6asPoVlhns9V/WEqnD/XRrdec9f1XFP3OSpEhv49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNZNe5U6S+3bNvzedYoR7aF4Sb96r1hyexDVr4MUSrs=;
 b=vKtajjFCwJ53OgN4hAmXs/I1icjkW+QsLLrJraq6SGlC2w7k+D7wFJBRDXzgcz0j0phOiw14vmtwG77A9t3rGBeuHTOe4g09G2MxHNbfM0WcE+79rE9kJ+bO7OM5t8H7wCQVzEjgg5YuRswa6BjPo8C0BgaYkg7hHqHjRIoamI4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB6055.namprd10.prod.outlook.com (2603:10b6:8:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Thu, 15 Jun
 2023 23:36:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 23:36:26 +0000
Date:   Thu, 15 Jun 2023 16:36:24 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, david@redhat.com, nphamcs@gmail.com,
        jthoughton@google.com
Subject: Re: [PATCH 2/2] mm/hugetlb: add wrapper functions for interactions
 with page cache
Message-ID: <20230615233624.GB29046@monkey>
References: <20230609194947.37196-1-sidhartha.kumar@oracle.com>
 <20230609194947.37196-3-sidhartha.kumar@oracle.com>
 <b3faab36-370c-1635-3ccf-33d51f53859c@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3faab36-370c-1635-3ccf-33d51f53859c@oracle.com>
X-ClientProxiedBy: MW3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:303:2b::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f04912-0259-423f-0566-08db6df95650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IegVuZ/ehqhYFLaGF/UyjPV9rd25GChnWmNWGml6qhBX6M+hymU0cY7Sqcoi/oFuVDuPzZ0McwPZvdh0q/UBMMyXAwdoqFjeevhahNXBtCQHCFqLb7ikYtqcXlqCvzEbS4hnCTkBHQb12+hhDDmZ5vwkIqCnEE02QGQf3jp9Do+DFfR3mFCBybl0RFZq/l7UJslviB1BP84pu4JXwT9xYKqzKgM0At83jFXo0qiW+L8wYCgyE2oViksgjSbRezLQ44VObNDqbICHd7iiQolgc+dlQhlDbqy/2y4MxCNIVsr9zuzRv/EyB+bIPPrlyESc9vUEpDSDfvw55Np1r4xILAf9xOx8jA/W6xQOkm7kkaDRwU5tNOErXBogR38ssvh0Eap+0ZJ09nTIdT1bmuPO/8prsnz2wDZQn6tBwg9na9jOEm2j7sbgepeFG5TEWs6Twz6lBWurk6oXmfE3DfoR8BPI+9FPxnDbzrAsbFVRAi8ZmczEZ29MCIZG6lyh7fepdVC1ZOzJi5Dqsf3zwBJM/hgpeM/0lYs/5RemILLXO+2Wgu3LdXTFIK3/RfqKiLoo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(6506007)(6512007)(9686003)(1076003)(26005)(478600001)(53546011)(186003)(6486002)(2906002)(316002)(33656002)(41300700001)(33716001)(44832011)(86362001)(6862004)(8936002)(8676002)(5660300002)(38100700002)(83380400001)(66899021)(66476007)(66556008)(66946007)(6636002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eexEWJdqulKKm468BmbE2gC0f1CpST7oE6m8VUyAhycn2TOiH+Mtb6xhNzeM?=
 =?us-ascii?Q?QybPPlrcK4zsumy0TAxTP1xZG+XLaQZKyIk9ipG+0INngRQZgEB/x/R/o24L?=
 =?us-ascii?Q?mKMATocFKsijAiYbKoXbvuDtwYUAdIoYl8oIAlUV3PMmYIQERRt2i6pQkBSp?=
 =?us-ascii?Q?lzkG7XCe++UssdIa9SIJjuuwv+z5TM1qM55oLk16gzoP+gM//ZfZO/pUkeZe?=
 =?us-ascii?Q?5CR4BBM6oECu/PCJorIGjdD9Lg8Rhy/QoUntQoxRRR6iMFsKxks22mie5zkx?=
 =?us-ascii?Q?XK99VWK2kxBM4IHgrN6sYvkUXBaBrKbhg8ds4FzsMiP/Ink/3fN4w7/C+52k?=
 =?us-ascii?Q?T+uG6FcEKyNQ2giJy3gbF+3GFZ3vQfvueZHHy/2CMriiZiFEf2922So0uHsL?=
 =?us-ascii?Q?FwlU8PFAE98D1QSDktGf2B3ie5+rxjB3JAWQsvrNWgUHVBYpH+GTA+RLkLoi?=
 =?us-ascii?Q?tHTE9pngaeH7rCT9xaCEQubFqboCgo7nx9BwCYvfhUhkm1EOXtHq4ze4MoEw?=
 =?us-ascii?Q?8fow+c9TSUj5C/vIJf4yN9oULpzS3pKoDKlF3y78cB1G43G3jVeW/kx94+2T?=
 =?us-ascii?Q?9x/xO5XVlfESEj8KGWXXF++2ovqo3PjlMcm8y2/GoftTagSTLVsa8xxtaIu2?=
 =?us-ascii?Q?W/eZZNFu02ObwRGLxEDJY77Dov32qrsOu6EOUt6unIHNWHEEVImWibuKbZwc?=
 =?us-ascii?Q?TuWCrCPFbMZzfbXQgIkKlND2ZqViUECjRkw279ct0lq2BVWnGmUVP8BN8OCF?=
 =?us-ascii?Q?utbLvzFleG7dI/o1Ljyd9GPmmOnZp9XyPOv771XD7zgZ9vDIGSWFAmkAZnNI?=
 =?us-ascii?Q?gpNFU3/4lzeIJ1g/rbFRTJppbafOLQgVXgEgVRXk60kOUDKFYM31EZoMF7Sb?=
 =?us-ascii?Q?kkkOqlXjzNKiypbcvygVZ/t1Wu+S8Izs8xCyJZ0BWYzl2gCsd73n28kYAXF/?=
 =?us-ascii?Q?wRDsJjjtCLwv5lGTispES7KgW+7Bb1KP8ZEzQPG2+fvRnwmMOkV18zOqBqW0?=
 =?us-ascii?Q?xubEqmNgfhrydtF02C/mNmzamB8eyPlHbtdQd7WNZ2v42N5MEs9zUQrNyEwr?=
 =?us-ascii?Q?2I3l6HEVWKAuFuBBsKAuxClMr3tSZsBskaeYVZk3Dlx1N3AwyfB0UynVyb3M?=
 =?us-ascii?Q?8vysyxisOvjkwbbZeUpYrO3HQu8i7Zh34+6PpgDmUqBsUU7qrn6wqUiuzAeX?=
 =?us-ascii?Q?IEtip1l6OwDMyL5XWcddf1rArC83wP6Vq5VwIWBYoSJ0K3H5dCrZ/FvG03a4?=
 =?us-ascii?Q?CQMGRHtZ5i4Qe3z4dXOanqaekMDFD/9eP8i9/oBvbbj++RSmHh50redH3hMV?=
 =?us-ascii?Q?vZPglybJEkEOKUUHOkfqymGH5pPN7mwNLAtZsJlbQIEoED0OI6703nRqa2pe?=
 =?us-ascii?Q?8dtnj7KifKN0Iec2CfHtC+R29jvfxfDPNvRhovezio02TE7zHExv9MfSglNS?=
 =?us-ascii?Q?KtadnXrywhCCyFcXJ/jOWv7I62uYqD+dVJ+8+twAp0e6nqbHPaYs79IWlfap?=
 =?us-ascii?Q?x/CJMInf16k1cstdi1arnQvcwGLHiJTgqVmsWMvx8cApw5ODhrVyTQNI954h?=
 =?us-ascii?Q?ea0wyNIPy5/j9yLHl1Jx+Wa19cT49EczaGLnNBCK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0N6s4YXD/yBVXWQlxKvWu6FKmmqG/lCKZAtWfwlpNsku/R8AXKq0YX7JBTrQ?=
 =?us-ascii?Q?zg/mkGYkkZ7UoasQmi6flQyOH4J7E/oOkzn0fPMjI0MPG6R61JlQyMzYJCbB?=
 =?us-ascii?Q?5pPtzwmdzfPpArrI3sF9ndvcqLgushhGfJQrLxxKFsVqi1eEUKfK+cXGYsjG?=
 =?us-ascii?Q?MRggM/DVRQH+6gj61tWv6vE35DCNv75gLTaBuJapWH3y/u9kYxZo/glInZOO?=
 =?us-ascii?Q?HGf2dzAmKw8LdUbFCuuZFmDs2Rzalb6xgLKCzrZF5GnMeGaNiAwADX+n9AuO?=
 =?us-ascii?Q?uE+yBPyYT6YHtWLvcHQ+yYQt4lBy1+PZXkFUZ5HZEb49LWpCK/u/JfyyYIRk?=
 =?us-ascii?Q?xka+IpWpmblQ2wZxXkpzczGnH4fq2vFtzy4esGOoASEwQbRJz6NEHsr+AnCK?=
 =?us-ascii?Q?YdgK79binH9rPjbJcR2rpE26lb7Mzh/34Slq+Oiy8EN2n+9s197iicddSiAD?=
 =?us-ascii?Q?NbUIggL5TjCwEp+GjmFprzLe0SvrGJAK58JGUSHHUBZcQojZFoOFIbC8G8Qt?=
 =?us-ascii?Q?Thl57fp2nZ4Vo9NYnuMb4SlNRYgM9dWs1pshB4X4ol/8ZDTW0nO9ZpLyqijP?=
 =?us-ascii?Q?deHg7kU+RiMFrEQw81FXcFwQ00ih0/UcQolOZ8CZAK8BnmKYJ2muDpFHybnm?=
 =?us-ascii?Q?zVwNQuN7BfYub8pZleQn4dISRZYAfHqOT0WyQBa4NKb8WOnaEiU+gNYVuj3a?=
 =?us-ascii?Q?GexVXlNpWlQ+wfrkd2emFNkaQ9AM9c0PHzPPVQYwLy7Y7XS1KwN/tMonXY92?=
 =?us-ascii?Q?h8Uhd8m+jY2NIOIouj9lIEyUunyLeIweyv0O6hGQ5yRAfTSBLMenBjL/LPI2?=
 =?us-ascii?Q?rRjMi3FoPl2U/VCTX6/gFrftIm3YweppWdIeBE2AZyNp88lnS/dvJ5yLCBHg?=
 =?us-ascii?Q?Ikz8itp2ni9ubcSfbzkoQbNQpPFtSROTIm8wDClABapTigP696n8gaX9G+ik?=
 =?us-ascii?Q?0F5wiJjABV5ERb7i8RYxB6Gn0QPKEWY9KVdVcVQi97uyUTWmqu7uIgT994sQ?=
 =?us-ascii?Q?kRXf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f04912-0259-423f-0566-08db6df95650
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 23:36:26.7612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvwRGXYUwk3SE9tJHs4dQskDrXek5P5rI4eszmsA+EHKGmtfjCS14zZuy6OM+hF/z8ZFqEMjgndHHB5za8t8mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_17,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150201
X-Proofpoint-GUID: VMNGyfNoyKJYxPYyBdKD4gGbGTSYGhzh
X-Proofpoint-ORIG-GUID: VMNGyfNoyKJYxPYyBdKD4gGbGTSYGhzh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/23 12:52, Sidhartha Kumar wrote:
> On 6/9/23 12:49 PM, Sidhartha Kumar wrote:
> > Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> 
> Sorry, I missed adding the commit message to this. It should be:
> 
> Add filemap_lock_hugetlb_folio() which is wraps __filemap_get_folio()
> and passes in a linear page index. hugetlb_add_to_page_cache() is modified
> to also compute a linear page index before calling into page cache code.
> 
> linear_page_index() is modified to perform the computation on hugetlb
> so we can use it in the page cache wrappers.
> 
> > ---
> >   fs/hugetlbfs/inode.c    | 14 +++++++-------
> >   include/linux/hugetlb.h | 21 +++++++++++++++++++--
> >   include/linux/pagemap.h |  2 --
> >   mm/hugetlb.c            | 22 +++++++++++++---------
> >   4 files changed, 39 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index 90361a922cec7..90d27a8af4b6a 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -617,20 +617,19 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
> >   	struct hstate *h = hstate_inode(inode);
> >   	struct address_space *mapping = &inode->i_data;
> >   	const pgoff_t start = lstart >> huge_page_shift(h);
> > -	const pgoff_t end = lend >> huge_page_shift(h);
> >   	struct folio_batch fbatch;
> >   	pgoff_t next, index;
> >   	int i, freed = 0;
> >   	bool truncate_op = (lend == LLONG_MAX);
> >   	folio_batch_init(&fbatch);
> > -	next = start;
> > -	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
> > +	next = lstart;
> > +	while (filemap_get_folios(mapping, &next, lend - 1, &fbatch)) {

This does not seem correct.  At this point next == lstart which is a file
offset passed to the routine as opposed to an index.

I would think next needs to be set to 'lstart >> PAGE_SHIFT' here.

> >   		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> >   			struct folio *folio = fbatch.folios[i];
> >   			u32 hash = 0;
> > -			index = folio->index;
> > +			index = (folio->index) >> huge_page_shift(h);

Here you want to convert index from the PAGE_SIZE index to a hugetlb
page size index.  Correct?
I am terrible at arithmetic, but huge_page_shift already includes
PAGE_SHIFT, so it seems like you want this to me.

			index = (folio->index) >> huge_page_order(h);

> >   			hash = hugetlb_fault_mutex_hash(mapping, index);
> >   			mutex_lock(&hugetlb_fault_mutex_table[hash]);
> > @@ -693,10 +692,11 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
> >   					loff_t start,
> >   					loff_t end)
> >   {
> > -	pgoff_t idx = start >> huge_page_shift(h);
> > +	struct mm_struct *mm = current->mm;
> > +	struct vm_area_struct *vma = find_vma(mm, start);
> >   	struct folio *folio;
> > -	folio = filemap_lock_folio(mapping, idx);
> > +	folio = filemap_lock_hugetlb_folio(vma, start);

Here you are passing an address/index that may be associated with a
tail page.  I assume since the hugetlb folio is multi-order, the
returned folio will be for the 'head page'.  Correct?

> >   	if (IS_ERR(folio))
> >   		return;
> > @@ -868,7 +868,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
> >   		}
> >   		clear_huge_page(&folio->page, addr, pages_per_huge_page(h));
> >   		__folio_mark_uptodate(folio);
> > -		error = hugetlb_add_to_page_cache(folio, mapping, index);
> > +		error = hugetlb_add_to_page_cache(folio, &pseudo_vma, mapping, addr);
> >   		if (unlikely(error)) {
> >   			restore_reserve_on_error(h, &pseudo_vma, addr, folio);
> >   			folio_put(folio);
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 21f942025fecd..55f90e051b7a2 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -727,8 +727,8 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
> >   				nodemask_t *nmask, gfp_t gfp_mask);
> >   struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
> >   				unsigned long address);
> > -int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
> > -			pgoff_t idx);
> > +int hugetlb_add_to_page_cache(struct folio *folio, struct vm_area_struct *vma,
> > +				struct address_space *mapping, unsigned long address);
> >   void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
> >   				unsigned long address, struct folio *folio);
> > @@ -755,6 +755,16 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
> >   	return folio->_hugetlb_subpool;
> >   }
> > +/* Wrapper function for __filemap_get_folio*/
> > +static inline struct folio *filemap_lock_hugetlb_folio(struct vm_area_struct *vma,
> > +						unsigned long address)
> > +{
> > +	struct address_space *mapping = vma->vm_file->f_mapping;
> > +
> > +	pgoff_t idx = linear_page_index(vma, address);
> > +	return __filemap_get_folio(mapping, idx, FGP_LOCK, 0);
> > +}

I like the wrapper idea.  This is going to replace existing calls to
filemap_lock_folio.  What about something like this for the routine:

static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
					struct address_space *mapping,
					pgoff_t index);
{
	/* please verify my arithmetic */
	return filemap_lock_folio(mapping, index << huge_page_order(h));
}

In this way, existing callers would only need to be changed to pass in
hstate.  Perhaps, there was a reason for your wrapper not obvious to me?

> > +
> >   static inline void hugetlb_set_folio_subpool(struct folio *folio,
> >   					struct hugepage_subpool *subpool)
> >   {
> > @@ -1021,6 +1031,13 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
> >   	return NULL;
> >   }
> > +/* Wrapper function for __filemap_get_folio*/
> > +static inline struct folio *filemap_lock_hugetlb_folio(struct vm_area_struct *vma,
> > +						unsigned long address)
> > +{
> > +	return NULL;
> > +}
> > +
> >   static inline int isolate_or_dissolve_huge_page(struct page *page,
> >   						struct list_head *list)
> >   {
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 17c414fc2136e..ae8f36966d7b3 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -860,8 +860,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
> >   					unsigned long address)
> >   {
> >   	pgoff_t pgoff;
> > -	if (unlikely(is_vm_hugetlb_page(vma)))
> > -		return linear_hugepage_index(vma, address);
> >   	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
> >   	pgoff += vma->vm_pgoff;
> >   	return pgoff;
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index dfa412d8cb300..824d6d215a161 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -951,7 +951,7 @@ static long region_count(struct resv_map *resv, long f, long t)
> >   /*
> >    * Convert the address within this vma to the page offset within
> > - * the mapping, in pagecache page units; huge pages here.
> > + * the mapping, in huge page units here.
> >    */
> >   static pgoff_t vma_hugecache_offset(struct hstate *h,
> >   			struct vm_area_struct *vma, unsigned long address)
> > @@ -5730,7 +5730,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
> >   			struct vm_area_struct *vma, unsigned long address)
> >   {
> >   	struct address_space *mapping = vma->vm_file->f_mapping;
> > -	pgoff_t idx = vma_hugecache_offset(h, vma, address);
> > +	pgoff_t idx = linear_page_index(vma, address);
> >   	bool present;
> >   	rcu_read_lock();
> > @@ -5740,13 +5740,16 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
> >   	return present;
> >   }
> > -int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
> > -			   pgoff_t idx)
> > +int hugetlb_add_to_page_cache(struct folio *folio,
> > +			struct vm_area_struct *vma,
> > +			struct address_space *mapping,
> > +			unsigned long address)
> >   {

Like filemap_lock_hugetlb_folio(), can you just add hstate to existing
hugetlb_add_to_page_cache() arguments and do arithmetic to convert index
to PAGE_SIZE based index?

Again, I could be missing something.  But, IMO such a conversion would
minimize changes to the current code.
-- 
Mike Kravetz

> >   	struct inode *inode = mapping->host;
> >   	struct hstate *h = hstate_inode(inode);
> >   	int err;
> > +	pgoff_t idx = linear_page_index(vma, address);
> >   	__folio_set_locked(folio);
> >   	err = __filemap_add_folio(mapping, folio, idx, GFP_KERNEL, NULL);
> > @@ -5854,7 +5857,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >   	 * before we get page_table_lock.
> >   	 */
> >   	new_folio = false;
> > -	folio = filemap_lock_folio(mapping, idx);
> > +
> > +	folio = filemap_lock_hugetlb_folio(vma, address);
> >   	if (IS_ERR(folio)) {
> >   		size = i_size_read(mapping->host) >> huge_page_shift(h);
> >   		if (idx >= size)
> > @@ -5913,7 +5917,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >   		new_folio = true;
> >   		if (vma->vm_flags & VM_MAYSHARE) {
> > -			int err = hugetlb_add_to_page_cache(folio, mapping, idx);
> > +			int err = hugetlb_add_to_page_cache(folio, vma, mapping, address);
> >   			if (err) {
> >   				/*
> >   				 * err can't be -EEXIST which implies someone
> > @@ -6145,7 +6149,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >   		/* Just decrements count, does not deallocate */
> >   		vma_end_reservation(h, vma, haddr);
> > -		pagecache_folio = filemap_lock_folio(mapping, idx);
> > +		pagecache_folio = filemap_lock_hugetlb_folio(vma, address);
> >   		if (IS_ERR(pagecache_folio))
> >   			pagecache_folio = NULL;
> >   	}
> > @@ -6258,7 +6262,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
> >   	if (is_continue) {
> >   		ret = -EFAULT;
> > -		folio = filemap_lock_folio(mapping, idx);
> > +		folio = filemap_lock_hugetlb_folio(dst_vma, dst_addr);
> >   		if (IS_ERR(folio))
> >   			goto out;
> >   		folio_in_pagecache = true;
> > @@ -6350,7 +6354,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
> >   		 * hugetlb_fault_mutex_table that here must be hold by
> >   		 * the caller.
> >   		 */
> > -		ret = hugetlb_add_to_page_cache(folio, mapping, idx);
> > +		ret = hugetlb_add_to_page_cache(folio, dst_vma, mapping, dst_addr);
> >   		if (ret)
> >   			goto out_release_nounlock;
> >   		folio_in_pagecache = true;
> 
