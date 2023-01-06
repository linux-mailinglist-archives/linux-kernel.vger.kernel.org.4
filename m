Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A73660A81
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjAFX6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjAFX6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:58:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787EB7D9D1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 15:58:10 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306N5wRk028233;
        Fri, 6 Jan 2023 23:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=wV8kxBb+PrB07u7bU/Dd2/L5MJta1+D78UjXJCnE2Mk=;
 b=mmkIt0DiEB0kECgHo9y/62VfgoviukISoYT4XoadCWVVYva+P+SAeQOouGZKrp0NZVHZ
 JNMrk6Vl3S4wJ/NwYrhF+zFR06vgh6bFfDjt9MX3tFbTEHMitZKAQGPnAdvDFr/3ZyVN
 K+IUN7or0afSZqUZYF0NUmS/ravE22nCh3rM/3vfro1hSd65SPPKaD3K33uZjycoByh1
 qQlt90x8inv/CRXxKr4lToXJr3AsNmn/HwpVLG5V5VcCp8kyBggQ8ZOXxx+snFQ6OcyJ
 B19K390zBBEEcXkksGfPgXi3RVv8sc64Uo54XmIq8BqGLHJ+zzmRT8E1pZPkilPbjx/X 4Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmtv7vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 23:57:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 306NAQBT032481;
        Fri, 6 Jan 2023 23:57:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwft1pg0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 23:57:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFprOrvIwnH266WUhDW2vw6qGHliMPuheltKbLZmed5uhZsqC76yNgV4j9aIPnVZR1ZaKGKOlf7Ivw8jcCfURHYDTZJ6xM2EHReuSgJPRtAzxqRcJyjGg8xlNd9ewZYOUl1cFfSlArRYLnkj6/95yzPvnvlOiq9Euw+a8QojEA5kRX8eCfkHiQu7BTVCKNHN1ZHo4KDNLz1qcOJ2KGxLgP1919kE/e1Ugx+krCWymlWnwflzZ+xVMf/GGhqgHdCUjUQsvfhEon2BwXW6npvdiCXbCcvAGuJx8EDH0NrVcFqCWt+6a4Q9pGMcBBOy+FmJT/I6mh+6e5w6ZzCLQU8zPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wV8kxBb+PrB07u7bU/Dd2/L5MJta1+D78UjXJCnE2Mk=;
 b=SPyLRIXjBKn8pLEdfKjmJytjGSxHQlhC/aWZQzyLmIFTDXHi7NfJNgyBP3laIF1POKA1Six+Dbv7nOcoCe7GPBkAJfOA2+K2LEjLMYtkH+ru4hLcVQ460OIzl+kYau3tYCO+Klt3m53cKyATPPxPdvGRJBCPjoUI6WXR6usSlHZPyyz4HCdidTtv2Cb864iwBuQzKhoRieXK81GHnYILM60Rwdl59OmFZ9MmMWchBudFIB6sPLR/MavUu2MzH82qpl2nQDhEeVgtCQ5eX27K4njFxv67Hs9pnOzrx7W/83ByT8sGI9J0xqRFSs5xcfvdQLY6nCfA12aj77DC/AqtYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wV8kxBb+PrB07u7bU/Dd2/L5MJta1+D78UjXJCnE2Mk=;
 b=ULgc4xWXH+Z+lGqWOljwVOOkJz8G4gldXIHOBK/jO2SiL2oncKVzZuBsbIyGm0uCgWD8SYP06K/d11sAtXi+JpHwG04Nye0z9FGDgZU8ZlvRuLkvLknn9uHxEycNRG70bB7UD7aRK1mE0cAdXSUuxP4sBdCH3zWs3C90iLiUsmk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5817.namprd10.prod.outlook.com (2603:10b6:510:12a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 23:57:16 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 23:57:16 +0000
Date:   Fri, 6 Jan 2023 15:57:13 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable 3/8] mm/hugetlb: convert
 dequeue_hugetlb_page_node functions to folios
Message-ID: <Y7i1WTtnjEoGM4he@monkey>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-4-sidhartha.kumar@oracle.com>
 <Y7SXXF4sGEjR1um5@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7SXXF4sGEjR1um5@casper.infradead.org>
X-ClientProxiedBy: MW2PR2101CA0002.namprd21.prod.outlook.com
 (2603:10b6:302:1::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1f847c-bb1c-4a17-b27f-08daf041bcd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 63jTj4xH3MoGYAzUSpXAF1sIfqyyGRMmQsK0tqJ2oD+kWcQA7MPTXEU0nqtiGXJ0wd7gjIAlJkB3tUEOJTmFh1cr62/eweB+ivUiC2Lw9vKp//KhI2wpZBTzNZe9LTRIvOlz6Dp1dDNWQXvsCpoywUJCrrh6hNZbzuSDLm4nKe56CfLJ1C7DHtKbbynWgbkl1mRT58eukVlVK0NoXx/WuELPp2U+vl1n3eLPXdJBvx5BQ4dlbEYlsP8VKLsZ9KMwmRDz8BjHRWz4lv1NBPBEuxkxOM0hRpBLfIZK39VpquuGNYFGwAXIaCaBr+gBrP/9oubESyQ2qwI2EolK6/vG4WeDHBj3ZFWYNuqyennaimQ4OVa7ijNPSYZ8YznfpYE1CkJr06LR2NiNWWv0AW85E0bUDYLwCyUIFdIGakIwDLyrwhXRO7EfTgrHLAO8MIKRLnGqv4BlFToiL2iP83PotzO8rMTkXiEhpjNupAo+6uRZ1lOJnXJ/maBBf+deMRyKoVQu8tgPr0innbg3pQ5nDuhxycvYzwyGltRsOaVvvecAlk9EVUSzdOcHXIe928ofaRfq7Z+tCu+zSdVGmNYan2Lqyf6MdS216rTt4gycy7Xy1GvWQQ094gwsQMGezJNs+JueRV3Hr7M7AO89JUh35A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(186003)(6666004)(26005)(9686003)(6512007)(478600001)(53546011)(6506007)(6486002)(2906002)(83380400001)(66946007)(4326008)(66476007)(66556008)(41300700001)(8676002)(8936002)(5660300002)(44832011)(4744005)(38100700002)(6916009)(86362001)(316002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Nohz7l/QlE3RjDonSrGyR+paal+e9Hiht81S0dHU0+yfUn5sk21T9jXg8gf?=
 =?us-ascii?Q?LkRPKYTtMob4v14JYu2QeWO5kgPg1MXYrrTvVc/cSPD9Iy0nfjuhMj8AfdSa?=
 =?us-ascii?Q?OfkZYSkBqNg9opo4JXPciTiJruou4eNuoNZtKYeDMwcxff+r7+Ga3gCWG+EN?=
 =?us-ascii?Q?ireZCVFsGlITqb4rSDZ+CkT17y3JRyBlZrLSQpeVA0cdICaZrFdWGe8QvPX0?=
 =?us-ascii?Q?rKF8Ed4Z//PrDfcFUe3TP3J1xX/Jxhlh6dDoDBfQMWEqj36sEovMTQgGw7Ya?=
 =?us-ascii?Q?hU1Lz+kL0O/AHQeUX6nNGCk30ESjg4UJ401iteROg6nFGgFyOgrEbBTqHRju?=
 =?us-ascii?Q?fCJAhTeB7q0u7Ni2pJvUYf0GxJ63gDzy2O6HHTrCf98kVAVa6xzbjV30LsHX?=
 =?us-ascii?Q?LM2TPFXX3t7DdLO/HEYJt7iJAQ45yLiqqNBZ6aIp/H6OXM6CftkOaJR6UPxV?=
 =?us-ascii?Q?X/xprrzt6Lvl704cOVyMe52DFaT6+AVlYsIrCK6+frC7W9KayL40lYrRZpAE?=
 =?us-ascii?Q?joe7WYAUy/DxEhnX/Lx+Rr/4c8QpjqPQwCyx6134Gq7DhFg8FcHTUb/ybtQh?=
 =?us-ascii?Q?kP7SaCxZ2vV5RxOD33uw9OJSsNP2XfpRoJjyQ6agkmeydjsQI50H4SHDkCD6?=
 =?us-ascii?Q?wxdr8os1qT4v6n/bilzSEztvF84m9DsrsckhwOd732OIK7YESabm7bkyM0XI?=
 =?us-ascii?Q?04zrqIHcVGsCU1T4+2BTiZP9CSBtoX1bDq3SN589mjTbVp+AAWlmXeuGvY4P?=
 =?us-ascii?Q?F54lbmhPfBc3hOBzBx2hVi4fZ4KqwDMCmzyZbOxgmpoMG9mG7qu7XiuTs07/?=
 =?us-ascii?Q?peSX7MyryX7/GZ/FoysMjxXjNCglLeM2lzgrinv2L9i7Fdvd/Cd3z+H/+qPc?=
 =?us-ascii?Q?rdt2vaOU2R0VkgeFl5DA+IT7DVgDnHJS6KzmrJx9JpS3NyCeKAH2DBaGXQKD?=
 =?us-ascii?Q?HJvMD4q/QPTzzGgiulA/+7lj2kCJmNPTBNV1KwtEguRzhjB9veE58aYBAB9G?=
 =?us-ascii?Q?1xtpN9RpF0YBuUctY/7Nppzczs9cMT/Rqrof23ZtEf1pgLbBT1/afsfGyTnI?=
 =?us-ascii?Q?cTzlOqWbGjMz6lb4z0qfoMMYT63F6ZfNhE2yYgmLqzRdbnVI7kM80xkNrkOG?=
 =?us-ascii?Q?uw3aFDP+p++hGH+EQxDyYyrZiG+jPafKarhkrCMC3T0SIHiysdbSrv9P36Tf?=
 =?us-ascii?Q?c407an8//XVEvGgA01Pv2U12mh9FsEDcLcwgNR+DUAa1N+61EW7DUaNgZa94?=
 =?us-ascii?Q?qZqDvGqjDv3uvAkQM4Y6X77nXLceqCqViniFoh6PZzSO141o2EMCjx08ZbSF?=
 =?us-ascii?Q?yi26hwqlY1y/XIJw8y1bTFqgoNVMHvxN//8WU6MaiUzWqDaOd1z8rkdfVWPB?=
 =?us-ascii?Q?jkgrZ6QiWXO7i+69ZLFSXn/6QPj3wkd6q9uTDM0ZHNXLJ8ym/PJvhbOgZ5l5?=
 =?us-ascii?Q?/TwwNIGjus6o4UNqbBK+/4CV0T4+/zT8rwNLjNgNXVb/MXVgN8xa9INOybOK?=
 =?us-ascii?Q?s3Nz6VfhcW9OdaF4nTtMxje8oE4C8fC5uIuC5cw6fhbgVYw/MOFIj+QiJeqi?=
 =?us-ascii?Q?i7eLaXeiSLrew8sGcZjvv9+XAgafJ09OVZjXWQTFNfWyFgV4p4kvDxeBcNiG?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6gHNdrIUSyOymTkxiJGDNXkj1xtHZpZUT2TroGTHPytC2mGkiwkyzBG0J25i?=
 =?us-ascii?Q?0+4DDNmpbSutFZ2ZlWl2I+GIDJMHKXPmTs2ASPWgc5H/qU2PYlu2wB0Sg5U0?=
 =?us-ascii?Q?095tuviUUuDXslaLQ59VcgX+3kd5cMG0zUkh/KakPJW+E4MVND+9JIGwisLA?=
 =?us-ascii?Q?AccwW37wo6MyM8a4OfiVLpZQhzjfeYKdOdqDFMsNTEfgv/1ptu5rY/AMxZBF?=
 =?us-ascii?Q?MGHFoTyPguu6iIW6JOHoAxJF0SPsK7g1CySdmfospYAAtJ02C7Q9hp7YGU23?=
 =?us-ascii?Q?hRJiGPI1A6fltgMBV0s2W0xTksVh33hdMKXb3V1EZL9Eapu1xSrrsW8s0NIu?=
 =?us-ascii?Q?ckBeUjwzq/a+JUjWDhYrcz53/BC3YjfoVKTi+HDGpfXGa1RWrmQnp5cJKN3u?=
 =?us-ascii?Q?muh+HOaQmtf4hyeUCFl7VcVjSJR84+I94gHxcWnsIC9Jqu4oP2R12ROVs4ZG?=
 =?us-ascii?Q?sd3LsbBj+Fic7MWVW3qWVkgShJNWVOWR5UmB/2LsEG1Qy9aytlBZdcWNvso/?=
 =?us-ascii?Q?C4B35b2s4QUAGZlKaVo0uvsPRLF56GQ+VIFmcS5wunicGA+YTr0aK8uAQ8CO?=
 =?us-ascii?Q?eoLM4wmn8KTKtJjkd/bVeBm6ZnfHAcfd31q3uO2so1NO3Zdu1nsSCO43Kh/A?=
 =?us-ascii?Q?48BOgtkcGyvFmikGBIzqygVW/vyDKJ1ZHTgngGvOY137R6wYSWdI6oXcgViO?=
 =?us-ascii?Q?2fYDgF52htN9ZeoIge5uSG8irl4k98bVtDo9JOcuUSttVkohx8YHvByIwfDS?=
 =?us-ascii?Q?K4MDEuNMUsGX0KqB1gZ5Fm0GogYCrzhCBFZ8SZsmj35JVIPKJsEtCXvtgg6l?=
 =?us-ascii?Q?NzE+Pvwk5rNiAv45EQptPtZHaMlr8FvS+0cSZnlgP9hCrptRjvsqXIK9deyU?=
 =?us-ascii?Q?5K41HeuR7mYokHvo49x0XxkTbkYGVEajsRqXoig9hvwxg8RfALc+hXFmpmpR?=
 =?us-ascii?Q?dpY87yqXPoSMbjIo4wo06MBJmTbOL5XW4u3BxrAcfcE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1f847c-bb1c-4a17-b27f-08daf041bcd5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 23:57:15.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OsGuxu9/ps0Xtv6buuPl0EseDO89HQUZv5SEtxSOJ3WLpB1RO8MBVEUddn03G2Jcih9qNofoXUDOcErfGysCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301060187
X-Proofpoint-GUID: OqZHdekXBqd1uh95j_yAMRZA51Ts3fzo
X-Proofpoint-ORIG-GUID: OqZHdekXBqd1uh95j_yAMRZA51Ts3fzo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/23 21:00, Matthew Wilcox wrote:
> On Tue, Jan 03, 2023 at 01:13:35PM -0600, Sidhartha Kumar wrote:
> > +static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
> > +								int nid)
> >  {
> >  	struct page *page;
> > +	struct folio *folio;
> >  	bool pin = !!(current->flags & PF_MEMALLOC_PIN);
> >  
> >  	lockdep_assert_held(&hugetlb_lock);
> >  	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
> > -		if (pin && !is_longterm_pinnable_page(page))
> > +		folio = page_folio(page);
> 
> I'd argue that you can pull folios directly off the hugepage_freelists.
> Since they're attached through the 'lru', you know they're not tail
> pages, because lru.prev aliases with compound_head.

Yes, then we can get rid of the local variable *page.

A quick grep shows only the routine __mem_cgroup_uncharge_list() does
this today.
-- 
Mike Kravetz
