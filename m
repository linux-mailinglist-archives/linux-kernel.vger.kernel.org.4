Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C442A6460EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLGSM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLGSM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:12:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2B2663C5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:12:54 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GDmAA010567;
        Wed, 7 Dec 2022 18:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=0tOOxgIhE9472msOgxwT8uvOnOPmErwSyc8XV2VICA8=;
 b=gthvfHuUqjBgPPOEgLk7RwuZj71bQSXirJtjMqtvtkL51gWL+AErNdZ3rtXXbg+rEYTk
 gtmWsNKz9p18vAlbIkfczV/TSruPbqN/galueuwWd3gogmrOyTrQEj/A960TqEOulww4
 DCd1cEdpyY0UdcEKvRagftIKgpJPz6EcKCTV535jYSFNu9Hc+zCVSarwSnNNZn3QyZtq
 4416yd7VE+DusLvQnMAnTz4bR5DcLMVoLY31ngXUVvtc4pzkzdxyNVFGPwJbcnR0551k
 euhuUQxFiC3I3FbQG3byGqrc5bon5B+ievC1BG9LY/fZtZFMxmlRifSeLD3dwIgl3F9V FA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mauf8gywa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 18:12:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7HSSAw021721;
        Wed, 7 Dec 2022 18:12:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa8g5fs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 18:12:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtHWmsLxr0eWvItVSbob8ZVaoZbSbuggvuySLHf1WkLueXmLKfQZKPwTE59/OZdc6GXIgjS4rhfOwKlxZlWHJ+QeScHrMszn5lZp5r7V/uBwRQx9sub9fbhcsCyIjEAggSPjIO2EeD6T8+GoSJakzG7oLxkCDBRPhC0lb5AlhuM9jS7x3kVq5fMcJWgb1+mZ98P214+ULiUzSG87Fpbc6olYUVueWyjykXtwDTVQPsSaZTy5pvUO72xTY6G68QjJe2rzFH7ars5lyVty4DU2NBPf6skFwTRaLaYxql914di7ZSaCSJ3v9p/K9bz8p51ajqNWhb4W6X7FX7/VDbOCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tOOxgIhE9472msOgxwT8uvOnOPmErwSyc8XV2VICA8=;
 b=TF7XDcQ0d3rTt1cJR8eNM0H8ODBfHi82DVGNFpcfu0lwHzzzUDfoip9wsEt3ne4VEmVLihS8g7LRlTwdyybJjZrd0VOfRWUuQrzHYY8YYbEOzzMk+eJkO2GjO5Wtd/E+US8cpH2lIZdZI1MdM8gNAgf4iTekvIu1gLApb7AzjVl0c5H1uXSUoNIE3pgk546Wfz53eneSXeD5ODyrUUnz9Y1iV6UBpHSDjuwSRSQ15yw1OeGCx2egRokYkoFi9aUtzYziLD91yeGT1fymb4oHn+TPLyAHkvGSP5FuEJdij2b5Z1r/oO42+8YD7Wg3MdmFvVSuiwP7NPD8iV+MYFIDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tOOxgIhE9472msOgxwT8uvOnOPmErwSyc8XV2VICA8=;
 b=BS0pO80FbEsBAVL5tX3ZrHTGwuTwkOCeBVxVEtyBxLSd6C5zZjnIGknFvtHnpPvx1LxhkPAqVYA3BP9hlVTCril7k9QJRtk6JHSU3g+rY47VVFW7jFyQuU6FpmFP5kXoQBT2xoMUcBYikCd95VugiRt/yXeosCpIaNqnBgm+M4o=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4134.namprd10.prod.outlook.com (2603:10b6:610:a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 18:12:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 18:12:30 +0000
Date:   Wed, 7 Dec 2022 10:12:26 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH mm-unstable v5 01/10] mm: add folio dtor and order setter
 functions
Message-ID: <Y5DXivFOA+bO0IYQ@monkey>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-2-sidhartha.kumar@oracle.com>
 <BAD34D59-187B-4BB3-B139-7983A8B62648@linux.dev>
 <Y5ALigw0kUO/B3z2@monkey>
 <4161AF1A-9508-4DF8-B756-FEB476EB32B5@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4161AF1A-9508-4DF8-B756-FEB476EB32B5@linux.dev>
X-ClientProxiedBy: MW4PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:303:b9::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: b3487aab-f6ab-4c5d-7fec-08dad87e9a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbxvrZn86sEVxj/fj+1zfxYum4vV/ndz69D+8nyyZcBb9ORQI+BPrPsfayrhsHcsrYAFwIZmSgX45VN+YbEouV7LnxTZk4hB2OhEYPRjbV2a/gih7f5JrZtnp2HLoZge3sP0y0IhA8PNrBaJWW1D4gSs1ubqrKPcybnb7g5KajrY3xYs9QCyp1rtWbr3nCcvu5l6M+kYvIbvThkkLuMJj5O+7oGSTt+VARIo/+UUgNanEDvDPdQsvPMjfHmNad65YFR1DOYn1jgBuNZ7WiTNb029zvFm2aX7NBMOsiTHiwx5oiueaxk1Wu6OkZ2D33es7I49rQZWhcGMzUqNMZPxe5Z8/cXVSP7ou9tghmgQF2ShrXerBEq19TQKUwYpxeWszsaJFYdiYRQrbPKVf71hYhtmCiYLETHSl2Vjonvfbrc4H/cUU8W2Tf531VZn6L5qkgqSucJSnVjf5Jtk7/cI40IC5e06RWrS96xbHZ3YdpY7JJ0Qybj/03t7FEQCrIlR37/YdOWn28kjAdZ8SvKgYc5YH5mst+XzRe5rS+UoLnmEmZgieZrRWoErjXG8+0e+nkPNQQeL3pVyW1IWuZvLTmxw6yzKqxO128lMuMoEaPYeVnlySkAU+DR1FMM1hN5cbXz0RZP755g8yABPQ/FlOmsEFIozYqN5kt4Hy+r/zuv7asIOj84Q8QWNFwHQ5fbu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(83380400001)(8936002)(86362001)(44832011)(2906002)(5660300002)(7416002)(41300700001)(4326008)(33716001)(186003)(478600001)(53546011)(26005)(9686003)(6506007)(6666004)(6512007)(66946007)(8676002)(66556008)(6916009)(6486002)(54906003)(66476007)(316002)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wapR3vCnI+5wTOZhkd8tt0eSvwY82xCU3wC1C6IPHfKJMctC+TvSDujws7Z9?=
 =?us-ascii?Q?PxxNTQL2h2Zjtf9Jcvg8HC0shZvGTFDh/A9w4zkngM4FBd2fZy8v+F9qLnRe?=
 =?us-ascii?Q?rH8xqffJh20wSogOLH4hqZd7yJgLfvKFvSZu+3JzxqG01nr7E4dY3mGcULMk?=
 =?us-ascii?Q?1/BqnLAh81yX77TAXg8XBPtuA7rftGkxOS5icShk8FyGY+xjanPel9XFV5+z?=
 =?us-ascii?Q?mAYqb+C9IMhjnYAXym2w+P+ttzF6vzSsAelTxmRVMjI5YXspFshdKbcA/U6c?=
 =?us-ascii?Q?pAmliZ3EEQ1cOxf78/8FyFPztWRBBJPcX4XFy08kmD5cbhybyHvQdovDyClz?=
 =?us-ascii?Q?ofY9edjcVTN9cnVvkmQXf+Kfsn+iZgWng0nblanpM9yKXE8ajNuW5CWVHXSB?=
 =?us-ascii?Q?QJwteEY7dyRcDPrCqKV25I4yUsUEzU6PdQgP8FG6V/3JN4YmQEBPSeBc3fig?=
 =?us-ascii?Q?2gJqBsPJJN9qGZu73ASdv6hHokqqxi7sHXju9AQIjLtzC/BPeozHQDy53fFy?=
 =?us-ascii?Q?tOfzkjLJPxm+s5nhcFUKCVIE77t4vok6pBC6TLlUHYpgq9oUfTjtJgQ/a+6V?=
 =?us-ascii?Q?u57Lp/D+V7m5a/HFlaqmN2/M07bIrp8GxDO3sIjUEAHZNfVUiZDF8imNQptu?=
 =?us-ascii?Q?SKFFspZfsL10DR6wlzNNVIuIPAYK1CAAkBzY+WQW5N7LgDzwwilOfwdNXieH?=
 =?us-ascii?Q?ApDwuu6EldVnes43OCuR0d0eSlLQrbnXjSyR/8IXGK5Dh0CSeNoogNdBIfX3?=
 =?us-ascii?Q?blq4u/Iwc6CgG38oVHy9uqgtZTuHfpc7BSbgJph3VjEHKW3FtjhKlMAxOy2b?=
 =?us-ascii?Q?BfG2dNwiOmNvrpKVTy5noGLZBTCD0RMNGs2UFKkGrUGxd+UsLBjt3kyZpQVv?=
 =?us-ascii?Q?/rfZ4CB4VetxlBfNspe/LVDJ5GdK+/uLeTHmHKQRsURPBRZYTOpfK1uiZB54?=
 =?us-ascii?Q?XWUFGmubA5JX0yoAIWetnexaalmDdQTpzmU3+MyXyZV3WSikFId9YKYUixCi?=
 =?us-ascii?Q?KiUuuusLSGiAfbl028F4NM/BkxFxUfT+VrdCYJs/Jj672onyKHLxcZ+kf/oF?=
 =?us-ascii?Q?WQOLMIzxhk4iswQIQVgf5+XDS5udwQN29uaPh3PF9lgy61LV8PRp4WhC2BQN?=
 =?us-ascii?Q?lK0LSOnusWxVoZn1S4GBo5T3VwNka7h8rXXAkGt99Vo0MJ1PCT+6It6QIcz2?=
 =?us-ascii?Q?XKUmtnEtvScIKy2cAQU0KPJCPujhGBaiaRMSozBvUUjF5MqwnFxtBagUR18l?=
 =?us-ascii?Q?5r1RYZXysFLGLoSEEZjzY86MFW3yCI3OE+iIC9yV6FuZ746E3fxYwFTcRR4m?=
 =?us-ascii?Q?6McDqdmigFrMZc+S0CkbnLRr9hPGrdLixE2aKtfR52p1Yy+t7Fs7wsgPDCwl?=
 =?us-ascii?Q?C/p1cNljLnqMt08+7lDyGHLVpNesymZjVnZUfzQ9+7SdC1BTxZtm3jS6IxvW?=
 =?us-ascii?Q?XqWhiTxtSiw7De2iVXnMPFMAqSxSFs1xvkgwdUoxaXY0jv/VlgNuiEylga6s?=
 =?us-ascii?Q?00C7V1AP9vc5fX9UuzWY0cVdjoLyVMxqoa9SDehvl9AWoh8RLsbA210waGP6?=
 =?us-ascii?Q?XXki3NsqBsVyO7/mXVUnFVnU5ldpQIJp/cDH+bEXyIUOmYQnYB5nU63rqsY5?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3487aab-f6ab-4c5d-7fec-08dad87e9a23
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 18:12:30.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybnbiHCTIldo6JWprkGF5qHAtiArXeImTPRSY0n4R/ncAM7e6sCI2MI8tp8izEeWC1h+D+EG6TgxTFqvXI8BrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070155
X-Proofpoint-ORIG-GUID: idf7qgBJNGlmP64vYi4EnkCIvsbzhPIh
X-Proofpoint-GUID: idf7qgBJNGlmP64vYi4EnkCIvsbzhPIh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/22 12:11, Muchun Song wrote:
> 
> 
> > On Dec 7, 2022, at 11:42, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > 
> > On 12/07/22 11:34, Muchun Song wrote:
> >> 
> >> 
> >>> On Nov 30, 2022, at 06:50, Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
> >>> 
> >>> Add folio equivalents for set_compound_order() and set_compound_page_dtor().
> >>> 
> >>> Also remove extra new-lines introduced by mm/hugetlb: convert
> >>> move_hugetlb_state() to folios and mm/hugetlb_cgroup: convert
> >>> hugetlb_cgroup_uncharge_page() to folios.
> >>> 
> >>> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>> Suggested-by: Muchun Song <songmuchun@bytedance.com>
> >>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> >>> ---
> >>> include/linux/mm.h | 16 ++++++++++++++++
> >>> mm/hugetlb.c       |  4 +---
> >>> 2 files changed, 17 insertions(+), 3 deletions(-)
> >>> 
> >>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>> index a48c5ad16a5e..2bdef8a5298a 100644
> >>> --- a/include/linux/mm.h
> >>> +++ b/include/linux/mm.h
> >>> @@ -972,6 +972,13 @@ static inline void set_compound_page_dtor(struct page *page,
> >>> page[1].compound_dtor = compound_dtor;
> >>> }
> >>> 
> >>> +static inline void folio_set_compound_dtor(struct folio *folio,
> >>> + enum compound_dtor_id compound_dtor)
> >>> +{
> >>> + VM_BUG_ON_FOLIO(compound_dtor >= NR_COMPOUND_DTORS, folio);
> >>> + folio->_folio_dtor = compound_dtor;
> >>> +}
> >>> +
> >>> void destroy_large_folio(struct folio *folio);
> >>> 
> >>> static inline int head_compound_pincount(struct page *head)
> >>> @@ -987,6 +994,15 @@ static inline void set_compound_order(struct page *page, unsigned int order)
> >>> #endif
> >>> }
> >>> 
> >>> +static inline void folio_set_compound_order(struct folio *folio,
> >>> + unsigned int order)
> >>> +{
> >>> + folio->_folio_order = order;
> >>> +#ifdef CONFIG_64BIT
> >>> + folio->_folio_nr_pages = order ? 1U << order : 0;
> >> 
> >> It seems that you think the user could pass 0 to order. However,
> >> ->_folio_nr_pages and ->_folio_order fields are invalid for order-0 pages.
> >> You should not touch it. So this should be:
> >> 
> >> static inline void folio_set_compound_order(struct folio *folio,
> >>     unsigned int order)
> >> {
> >> 	if (!folio_test_large(folio))
> >> 		return;
> >> 
> >> 	folio->_folio_order = order;
> >> #ifdef CONFIG_64BIT
> >> 	folio->_folio_nr_pages = 1U << order;
> >> #endif
> >> }
> > 
> > I believe this was changed to accommodate the code in
> > __destroy_compound_gigantic_page().  It is used in a subsequent patch.
> > Here is the v6.0 version of the routine.
> 
> Thanks for your clarification.
> 
> > 
> > static void __destroy_compound_gigantic_page(struct page *page,
> > unsigned int order, bool demote)
> > {
> > 	int i;
> > 	int nr_pages = 1 << order;
> > 	struct page *p = page + 1;
> > 
> > 	atomic_set(compound_mapcount_ptr(page), 0);
> > 	atomic_set(compound_pincount_ptr(page), 0);
> > 
> > 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
> > 		p->mapping = NULL;
> > 		clear_compound_head(p);
> > 		if (!demote)
> > 			set_page_refcounted(p);
> > 	}
> > 
> > 	set_compound_order(page, 0);
> > #ifdef CONFIG_64BIT
> > 	page[1].compound_nr = 0;
> > #endif
> > 	__ClearPageHead(page);
> > }
> > 
> > 
> > Might have been better to change this set_compound_order call to
> > folio_set_compound_order in this patch.
> > 
> 
> Agree. It has confused me a lot. I suggest changing the code to the
> followings. The folio_test_large() check is still to avoid unexpected
> users for OOB.
> 
> static inline void folio_set_compound_order(struct folio *folio,
> 					    unsigned int order)
> {
> 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> 	// or
> 	// if (!folio_test_large(folio))
> 	// 	return;
> 
> 	folio->_folio_order = order;
> #ifdef CONFIG_64BIT
> 	folio->_folio_nr_pages = order ? 1U << order : 0;
> #endif
> }

I think the VM_BUG_ON_FOLIO is appropriate as it would at least flag
data corruption.

Thinking about this some more, it seems that hugetlb is the only caller
that abuses folio_set_compound_order (and previously set_compound_order)
by passing in a zero order.  Since it is unlikely that anyone knows of
this abuse, it might be good to add a comment to the routine to note
why it handles the zero case.  This might help prevent changes which
would potentially break hugetlb.
-- 
Mike Kravetz
