Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E875BD6F9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiISWOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiISWOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:14:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D2C1E1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:14:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JIjmXL015093;
        Mon, 19 Sep 2022 22:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=vW0RuRg7rWEdnM1mXD8Ouv13n8SeW30rI0X8uC9PV6s=;
 b=Cl9rvaJw88sglLD2fAYM6WypuUKhgtNoCSSWouVNBoE04HhhM5xhU9xiOmhelCXj2Uk5
 bzJQk9ciT194AQKLvsbuchDleXr7U5S2bZtHGwz+x5JaPAya6H8ooceUGsYNKO/o1XkQ
 ZesQspFefDAFRqU2iPAYS057LepRrM+aNDntNC9+a+t76i0GBzey9FZhs74z8pOfCQ01
 IiTsUgxIA0MkIheBlISvphgh2VG+3gdIFuPiliqxMj105ZuY0e37Op7HDakVTOmbDCLl
 Gr4qgKTTDdwqMwtBDME1E1hBE8TM9xua0Bet0EEAgEoBDzg+fEP9O16l50Ml6R7FVIZI 5g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m558p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 22:14:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JLssZi036496;
        Mon, 19 Sep 2022 22:14:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39jkr2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 22:14:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jne6T2v4babhe9VKk3BpLysNMeJT2eGHfDP1TtoL6ACi1qxjM4kzJ79TwAjPm3i9zPQdADEuG73H+TaGJ+7TxlUXwNw3E7XvgGrO3TTzfDXO3GAcYT+56uGOCI6v4IOmuF9LXb06mgowXNp2+mLlvgrON1AIu8Sw/5SNPE9y47wjpUvWiQQizzxs9TuTyrcsKC9xOEY/9GFTgdtOqKKKJqD2QoO3qormaXpIuSiX+NUfQsE920UCHT4Z/tsyJfherRCBiA1fpZ7xmWDnIWQQd7eqnpdsIerWe19NnWdADzL+kZlt8nO6jnihwBmqDfJp6M6Ip1VtKPI7T3ouWokgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW0RuRg7rWEdnM1mXD8Ouv13n8SeW30rI0X8uC9PV6s=;
 b=CoiCov+KH/+LjcwiBHU5rkqKJnsQoypYEUrPEPS1/V8LER7tMZ93BdE/EIaUgLb7P+Lk7XijgOSoLXUuygCyImkrunO39k0sdsiYgpZ6gtn8ZWn9SzwfnowDWtyqo8zy3dnIVtFiHDVS7G3OZ9rl9E2u2S84O/ejWPsmoSXByKiXpTpRtIWXNWEB2t4Mrh2ezWTN+OoIHUsVkw8e6AX+F6H1QIzfbFQ98H4PzC6vJ0DQLeSTHkOcppL+HYy7fC63rtn/aAkzMJ5+dQItskhfn991mcL3ACKeFyLQpfooIfE3l/2umJN0eE+FHSVgw0UgpVojEFjv0G3qfomFFRw5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW0RuRg7rWEdnM1mXD8Ouv13n8SeW30rI0X8uC9PV6s=;
 b=I0fxvkYlsVpe2HVZaqy2rnn+AKsHSghprnEzpEAnzbU5KyIMX5uXuwL1KQyBYwnbnhmsm86vctCBlZrN/V6dLJ2LxPZ3qTMa8UNoD4zuoCIEUuryq2c7MxhlgD36AzDqOf7DsF1Wp2L5h97zVVcdXCfMFm8JuQIDgJFW/58PvNA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW5PR10MB5827.namprd10.prod.outlook.com (2603:10b6:303:19c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 22:14:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 22:14:11 +0000
Date:   Mon, 19 Sep 2022 15:14:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, vbabka@suse.cz, william.kucharski@oracle.com,
        dhowells@redhat.com, peterx@redhat.com, arnd@arndb.de,
        ccross@google.com, hughd@google.com, ebiederm@xmission.com
Subject: Re: [PATCH v3 2/6] mm: add private field of first tail to struct
 page and struct folio
Message-ID: <YyjpsI9SIWCktdc5@monkey>
References: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
 <20220908193706.1716548-3-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908193706.1716548-3-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:303:8e::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW5PR10MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc20fb7-bbe4-4cd6-42fc-08da9a8c479a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDjW1cPpNktfvIdgMonrl3kzvx3buZGZo+F9xs0s8QXlMwnYsueiHCkDpcGGw/sh8+x518j/lmaTlLWIL2s1jyX6f/FtRE0m0GbBAPOracbEfkmMEoY0LrVPRbKTZ8z25miEY/JTT15PZ+ofnXN7l/zrhldN7tJFuwg4ajI79sdMGW6m2B2Pbnecign6oNMUSzMmBpT408/3bCEATCCVEJ9MWDxWUP5ed0T+pZEfK4vYk/kV2SvVtCS8jdtw5VWKU/PzIK3O6c9376S74sIvFDvlC1ByA6aX6wDZ++E8WNebIcLwje/cTunMZqTGGx8XVKiOi46J8MDmN4z6WnD/8Neyj7irmDqK0aj8d56k7XhavJ/sTlxa+M8GS1e+XYU60w6HbCzm+MYQlIe4kDCNkW+6k1zmNH48X/H+SMV8HfOTn5QMo6BmhZ7sFXkKIDphQocx8V6jI5C9auxaVXShYTV44xEo2r25GfUi1QY7Y32reMKfhobebw+sXnV+BSv5Q6pQE3QiQOxxFGtDSbig+d9RWqdjzwFDxZ9Ep0qLFTPSS5ZZrEwZCzJraGpoNCBWhdPjZBs4KyCvg8FD0tEmeFaYNPgVDS93ipHB89mIYUY++hctW+cWsMFpGm6cKVI9jyirPJGOx8bXHzIlN21GnPnNBivjI+EFGoA05P2xPNLKZhGhtQFlMMg69uCVb1FuQ5gqvMlM1lTKVWY16gFdEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199015)(7416002)(83380400001)(5660300002)(44832011)(66899012)(6636002)(33716001)(316002)(186003)(26005)(8936002)(53546011)(8676002)(86362001)(38100700002)(6862004)(9686003)(6486002)(4326008)(6506007)(2906002)(478600001)(6512007)(66476007)(66556008)(66946007)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vFkoGijpbFvKk5Szi+aMtkkspZTnhCbbGO6fyvv7i0nZvRn8D8/IbnBSgcKk?=
 =?us-ascii?Q?1vjXSiV6D+7mPND+9K+HUKnj92CTK/0IahTTqgfSX9AlY8x3JjRcEuycTatG?=
 =?us-ascii?Q?ntPY11WTBH6kn1++QjQdJ4Z14x17UvmSLpIFIC+vqBeZWEQNm8o26xEqgIqp?=
 =?us-ascii?Q?sl6pv43yNHMKdvCxYoyd92qdUiARMLG1hwjukEa53JA1OGTcoM9soJ6u7b7U?=
 =?us-ascii?Q?SailrI84i+VLi3VyhbkkQ21klttBXEVheuyclTSjjlMPQVHFOlYJN+yXWsZF?=
 =?us-ascii?Q?B/VIkDG4bkQqWSxivPJagNyfjBLoRnmjkNb5SxMLwKaPi29LvO3WF1Wb6F0D?=
 =?us-ascii?Q?8b8jgsohuVbQ/jJJXS/1A+mjSfszh1UMMiUygCvh9TM4aw+BKuwI6qvhTfIW?=
 =?us-ascii?Q?GfQ0fqDno/s6my6oSXttA3yMG+h1rRC0L1vutIhxdwJqa1W9JwqASQ+sVP7i?=
 =?us-ascii?Q?47G1Gbu537YuOFmZogKrEsn1dzNhkaPCHSJhuPfvsEevg4ngPmkkzZakM5Iw?=
 =?us-ascii?Q?9vw4YTRvTZxjnLPJIUTWKAf6o+343lXBY34UGSWKZhmphs68IBT7HPKeuc8G?=
 =?us-ascii?Q?7y5qpISqjfBlUpd/EN3cqB45NSGD3fcIxCrfieLJYfsWJOd3ayk9HErZVOVs?=
 =?us-ascii?Q?NU1luYDVCWWg+D0WbHtLSd7tknUbHAV+Miwsn8eik9+h6GZskpM9B0SmaeRq?=
 =?us-ascii?Q?w0zF0VFLKKU7VDjQQb320AWG14nzbYPN4En6jlHIT9YpkYE5I0Y1NWyff9xf?=
 =?us-ascii?Q?ZGVSBrF/a9NRdnPe4Z5rDNTpkpHq9l7rzEGUdcX2dD1k+mreYg23xpO2ropY?=
 =?us-ascii?Q?LxseU5WXoNqRkOaA0UGPkD5jAGIFCYQZ+KYP5P88CcI/oE8EtubgioBIY225?=
 =?us-ascii?Q?TSf0cAvwdfXI3BtBwOX2UI+yDYeS1bSviksEXUHtcueFQLybTM+eZOUD+2si?=
 =?us-ascii?Q?LtDOyhJP3/ciZMbPTtFw/3Mc4U0/IVuARHm2GSP6ugNYGzkB+3+mcmTzMRCF?=
 =?us-ascii?Q?LkMbafmeDBxs3Gl08Iyf9CJ2maH9yqggkqIWM7glf/myUopimVXurcr7SE1c?=
 =?us-ascii?Q?Ul/ebcHcuLwhzai6Ns7uZaQ+z8tSDLRjcI3BdHZbMlHEU2Di6fttI/DXOnhU?=
 =?us-ascii?Q?1JMJAD9XqoEGwxde+VM1LDWqSB9Bz8IX2vIU5eIxjxMdzSfKCoR2WAcQv1ec?=
 =?us-ascii?Q?b9xVLLJUrasuav/Ykk0UbEuFDomvA++B7QQZZjLRP7pD0HQCKmbrcka+Cwyw?=
 =?us-ascii?Q?EM1ov1IE+9kKRU8JtYmyirtq0XbkyILjaPuLmD6CbzX0zNYRct802sJsPYXP?=
 =?us-ascii?Q?k5TizK0S+gBuVdgYHfUrEdckHn9Ci00/avyOO7uUwsV2nfk0hNZ79Nu2A18+?=
 =?us-ascii?Q?wHLZQ/h9B3hQA0kJMZc4/IBYgsyreDGvX2JN0evy9mhXzkv1RQfLRIddvWau?=
 =?us-ascii?Q?EMxj2xMnOoDwj2uDvvVeSr2EXDf3qVn+A2GXbc2x3vJ5CXD9SQFY3AFQaXny?=
 =?us-ascii?Q?gli+7hXIKgOWYfjAUXpwbAq7Ibh8Ejupw9hWGc4T2+zhUOBirPXTIy/LbmS0?=
 =?us-ascii?Q?fYx05qblmnjP4Xi29zvXiIgLZ7vXbm2yDPBOaiJN+Zp2ubqWYrCWXI6vBkHr?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc20fb7-bbe4-4cd6-42fc-08da9a8c479a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 22:14:11.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33msdOsWmzvP/tzaCT9Ei2vKHesxAAVMgdUZAnLHy0P/mqUhSq0H+UT0wihAh4sRQAdawX5imrz1KQzvkyn+tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190149
X-Proofpoint-ORIG-GUID: FmtAdf48vGl1VYw-bMqI1qrVRdBjTVAZ
X-Proofpoint-GUID: FmtAdf48vGl1VYw-bMqI1qrVRdBjTVAZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/22 12:37, Sidhartha Kumar wrote:
> Allows struct folio to store hugetlb metadata that is contained in the
> private field of the first tail page. On 32-bit, _private_1 aligns with
> page[1].private.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/mm_types.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

This change is fine with me as it makes the following patches dealing
with hugetlb page subpool folio aware.  I 'think' Matthew is OK with
this direction, but it would be good if he chimed in.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 8a9ee9d24973..7a33171a05b6 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -143,6 +143,7 @@ struct page {
>  			atomic_t compound_pincount;
>  #ifdef CONFIG_64BIT
>  			unsigned int compound_nr; /* 1 << compound_order */
> +			unsigned long _private_1;
>  #endif
>  		};
>  		struct {	/* Second tail page of compound page */
> @@ -251,6 +252,7 @@ struct page {
>   * @_total_mapcount: Do not use directly, call folio_entire_mapcount().
>   * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
>   * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
> + * @_private_1: Do not use directly, call folio_get_private_1().
>   *
>   * A folio is a physically, virtually and logically contiguous set
>   * of bytes.  It is a power-of-two in size, and it is aligned to that
> @@ -298,6 +300,7 @@ struct folio {
>  #ifdef CONFIG_64BIT
>  	unsigned int _folio_nr_pages;
>  #endif
> +	unsigned long _private_1;
>  };
>  
>  #define FOLIO_MATCH(pg, fl)						\
> @@ -325,6 +328,7 @@ FOLIO_MATCH(compound_mapcount, _total_mapcount);
>  FOLIO_MATCH(compound_pincount, _pincount);
>  #ifdef CONFIG_64BIT
>  FOLIO_MATCH(compound_nr, _folio_nr_pages);
> +FOLIO_MATCH(_private_1, _private_1);
>  #endif
>  #undef FOLIO_MATCH
>  
> @@ -370,6 +374,16 @@ static inline void *folio_get_private(struct folio *folio)
>  	return folio->private;
>  }
>  
> +static inline void folio_set_private_1(struct folio *folio, unsigned long private)
> +{
> +	folio->_private_1 = private;
> +}
> +
> +static inline unsigned long folio_get_private_1(struct folio *folio)
> +{
> +	return folio->_private_1;
> +}
> +
>  struct page_frag_cache {
>  	void * va;
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -- 
> 2.31.1
> 
