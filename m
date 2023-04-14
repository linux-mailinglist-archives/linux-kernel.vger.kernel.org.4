Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A626E2AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 22:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjDNUHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 16:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDNUHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:07:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340F55B8E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 13:07:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGv4h9019418;
        Fri, 14 Apr 2023 20:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=kZdd97w5iXiNjTc3xyiMAaToXFqYsPLtOjx/pSolyNc=;
 b=UGg+NGxYV6Hl38t1EbikKQzlML6dLVjVPrMBtZzThZMjSphKdrk0iGvFEAosHH88udNH
 /ZVaOHX7C47CK6zZNPPylg1r36Ujf8QxKji3QxoL+JUJvQeJO6S3IJVQ/dQxuD66IEt/
 a5cnAb071xPnLKFEhUARw2w9lyvI76kwmZc+3xq8sNcVeTMRl/a9jysMQbbsFAGlTU8M
 C03HIRiSLkmCOFm5+U9tq+CNbywRTsE3Yk7mAQPvx/zFpjfAGENAoEVkLquyLhzz8vAo
 K9G/6PBXnr33npRxvzthJOog7WltI9KHXuhncgh/6YeW0XCVEaNfCEddjBDfbTqCPVWV Wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0hceu0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 20:07:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33EICIg9026949;
        Fri, 14 Apr 2023 20:07:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puweckts1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 20:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEnttIJmpNCD4DCSPgJgxk5YS/h143QQ/Vjxx9uPs1ML+/DDoHjvUnte3qNFmGrk9ZGQyL/CR7JmA4yO/J4I8JfPPyt/ByANDQgPx2AKSIdFQ+X02Er/qHBcPBVNaPi+JUdxsrPxWz7JryEHBNg/CLm10+maOtNd8u+qovAYniwClgpr0T2G3OxARIstEn8LmWTnBhEdtZ1rghXuCU+c2yfUO+/TfcuZHDuz2UDGOXFuBW1D+g3tIzz2QHsIwljoanMYzFiHyU3ooQ+FR6BI5llCq1umZbAKkCGhrQ77RdS/fhPMYcBIVFEZqk2u4sIM9ontBW0ukcsFdwEJMzOMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZdd97w5iXiNjTc3xyiMAaToXFqYsPLtOjx/pSolyNc=;
 b=DggKpL58Y4zbSXmFpwl+jwOE/SiBGkN1Q1hfh8wxyd2+qtSmqYCPENou5Q3Ncoa+85wsXsr6Yblmm8P6rPuuvLHGP6VGWWgW4otdHU/mXUiZPzOFsr8Q0s2+2B8YvZQ37ANL2w6A24iJmrDEHF0DU58Kk7f35F44S4kODfObzX0xSdsUu0AjioWLQjpjlCBEZ6DjFgpJCOtbtynC0hD13UWR2MlE6MdXecgRUdxQ3BMEYb9hNeHW5W4ds2BMGQF1K2vubsd3wWBGHSosfpgVRcC+Pp7pVclk+3m2r4AKxpLUwI3c4CzDajKZE/6+t1nkgqBqbALwV84HZVVhpJbyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZdd97w5iXiNjTc3xyiMAaToXFqYsPLtOjx/pSolyNc=;
 b=NXCt8VVcxp9ihWZR9MZgoeGg3Bru1uVlQBf5jiMENLgG0EGf4BLUYJSTigWaFhdgmgZsM50OqEL5J9mz1uVCLQT4a+SMN+bKPjpdjNdthUPTiKZLEGdy3GjmdefJK0X95Ld0vzkdK76kUjnbIWPc+6IPX9/EV/NEdGUNJOCWFhY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.48; Fri, 14 Apr
 2023 20:07:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 20:07:05 +0000
Date:   Fri, 14 Apr 2023 13:07:02 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: Assume huge tail pages are valid when
 allocating contiguous pages
Message-ID: <20230414200702.GB4712@monkey>
References: <20230414082222.idgw745cgcduzy37@techsingularity.net>
 <20230414190630.GA4712@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414190630.GA4712@monkey>
X-ClientProxiedBy: MW3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:303:2b::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: dc920212-686a-41f0-ac43-08db3d23d1b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3eAU7EmSPNxQMMbrC1WzFFzc6NmLK6MN3diUpj0kYCqrQZOC9aCHRjqVsuuVGQLe4EEalCbFpBhKHrdWy0+jJbTW/6Zq7MaSB4f/q82M3WLODnu4dHaNF8aqTf1HUKNSpc/zlEbYnq7KluLN7hj9U9wSm44N5Puz05PyF2LiiHdLTqaT6bnZqKczkLfaLUEjBZsxNxW04e2BQiq84Gp6dioCOqsyikAbiHjFOSj0wuTb+fZtfgoWoLKJz94Df6hKyXQ1rK3iR/b0B67kQNki3/QuoN6rTt3fnKsc3hxn3+fdeXDyRyGN3taxZq41Ea3o83fiKPx7c1LrqcduCTQ0qm9sZ+ZLi5rQ6ZNFmqmVCxyDozBtjjp6pUreONlCgqwTMz0oSshQW8ka9wOitNwRXQsmQ9Lis3KzO47W9Ks6sEzUiNFfC0zLy6n/Bt9rePW+kuU/Zm0c4j3IVXhgRu8yPG6rhvcxOSemkP8sPROe01RJO2udX9iJS0WnWf9gukDBFdbY1lifq33hFBHGX34B0/zuAX0RdEABlBPPFfcwtZzh+baVvYlmcjNIRbOo8fgRPw5ujjZZyarqt1znM9lK53RTaU7Uw/hiqshiSPDtI+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(33656002)(6916009)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(966005)(6486002)(478600001)(6666004)(33716001)(8936002)(8676002)(5660300002)(41300700001)(2906002)(44832011)(86362001)(38100700002)(26005)(1076003)(6512007)(9686003)(53546011)(6506007)(186003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iYZPoputz7LDl/lyPbVF9mpa7kEgLwXruA7OTHU6h+XpA7O4xDQKs6WvhiPf?=
 =?us-ascii?Q?61XQanC6wr1Fm0DiGBApALYh5dqj4j23/m5EtNNlgPQdP8s/FzCHsDHNwzlM?=
 =?us-ascii?Q?YvCxdUblcLJynZqJ0cpjY+PrR4DEZCXLQs7BZ2y2eJMY6Ycvd76wEWANxrlQ?=
 =?us-ascii?Q?G7fQTYWyt/Z5l6Rj2j7tqEwIyQn30f9oAVn4HZG0TOEJV/4Sh18TBlvnvdRi?=
 =?us-ascii?Q?852APjgSGEjSfDxjVwnpXb8Bg3IAISNzP/mEzEY2+47rJyYXBZpPS4Ft0PVZ?=
 =?us-ascii?Q?EQnafazYjHZOlUo6t4H95IBNaoAJOARffEmsrg9mwq4tezA/ixux2SivuLXM?=
 =?us-ascii?Q?WOkAcwIinqMvhrMPY7uOGB8zvzkGRqsjYMctOQvzR7DHi91Q0rM6mENwTS9l?=
 =?us-ascii?Q?wncCSr8NKZuLmWW95pfyToutrVaLThdsn0XZJ4Gcswiw8qk0PeloRVc9TlM4?=
 =?us-ascii?Q?ePPzFSVzSrz3KdiE9hEeNF7Eaxdzp/g91mf0y+d5ZCNEnKbU/UkV+F+ZPH28?=
 =?us-ascii?Q?srEePPVRSFA90oFPMyxFR+UZCJKTu0cmR2l9OcBno8E0b8VaRnpFMnUyr9cj?=
 =?us-ascii?Q?CFas1/Eh7bXIjDNValST5BCoDEo2p+2w1b2t398JRnJOE0gfosAe2YW2uHQO?=
 =?us-ascii?Q?Vmuk83lLsR+3lE04fw8zbpNOBbY5LRaM0iT436aaaGUC8y+I5w9rHsURSiRf?=
 =?us-ascii?Q?oTgDRkK2pjj5SUWH5Ffhv6JUa6qKD/lrv7GB/WNYQXjSM7SkBbEc4064CgqM?=
 =?us-ascii?Q?guu4VB39YHiUTZscfQNrVNoXOKws1q9TKHktRr50yhQs2yv3QrqH2vXFVkJf?=
 =?us-ascii?Q?cxKNxOMaTuJpMAwm6XaBgtJKec178chhq0f1jRUPcldhoZafhld+EeLfTJyr?=
 =?us-ascii?Q?EuUKHAzt174YLh4DNzB7PdJEbnLTwTcxZvbrWegMmdn9R/IpMAAKS9QqFrte?=
 =?us-ascii?Q?oyFOgaD6GblWQFspi4B82un5pjVA2MhN4CkjNdQoOVtr+YOwM8HxV7rgaHvY?=
 =?us-ascii?Q?4BlTtqZOeHgQ5hXrQFWFFZ3Y6yqenkbPz+VwXqNO7nmmJvhEEsVxkr9+9y7z?=
 =?us-ascii?Q?2x4JLY9lxyvHoOeTrFjTdP/yO4khBSHZ9ramn5lFoAmoNbtnNi4/TAONpS96?=
 =?us-ascii?Q?Fo86lOLz2sQSrh+KNSMBy6ldaJzMZYfy2e6VTJosxkccz1YaA/b6iBEQL4yT?=
 =?us-ascii?Q?fa0UNXHfqNwRKfkGX7yaav2QYHqj/fwFfTISDnrfCcuJ/8aRLd1zZiYfZjN8?=
 =?us-ascii?Q?KqsSM2o2nddrBQBMZFj6MHacuktbupJEOCvNyQY0F/wTkf74WdSZld44wg9u?=
 =?us-ascii?Q?nfMhFmh4FKN9pNWpBQUpf5SWmzjNXiy+Fkua+UTFBLyOBTyQFyjsf02omNn1?=
 =?us-ascii?Q?rH2zCDEjyofmrhb9FXN87uPlrd/p5YIVPesaJy03hxF4I01cBiVTDr6llzUI?=
 =?us-ascii?Q?4WRhSnUfi8fZQFXDyd3lM/x3v2Rhwkm1lDsEi9LFKX5JYZmDfjVCjmxo1q82?=
 =?us-ascii?Q?8F3YWQ6fM5BEGyv08TG+IZ3E718rDYeGKKj2dw8DVFE1+I6LxmwsNda3WGW3?=
 =?us-ascii?Q?7/7jjX6uRaxFNwdsnl4S2iYuXA2NEL1bHmgiH0ve?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yKWdMAJyCX2OptxLGGGdyOoxfnKdCfF5PabHUb+sULyFlOlSF7NA0vnoup3+?=
 =?us-ascii?Q?D9AGLVSEKxMQaODbJka65DoqSeUlB7I0V2FUSPHofZdJGpJWayXM8jNIXQ+m?=
 =?us-ascii?Q?AvnaBlJtgmTAJ4VxNEv/7NNgBamLdjVqpSp/bsGu/wjEv8phFJ/gHEsWzVkE?=
 =?us-ascii?Q?yYPrVsCkizwbum3QP56J0br1oVZ5nGtm6IKnaipeLdtEh+K4r5expD/HDHx+?=
 =?us-ascii?Q?lThTOL6EiMci/xceeahVaYTcOeU0AothwBNEykvpTtE6z5hzPyVeRIEhZauq?=
 =?us-ascii?Q?/xVKbPa8ECpyfsB92ZnZCAwdSZOBgFY5EYI1yhaHsP6w73/69t+O5mKpzowx?=
 =?us-ascii?Q?rjiaf27KVC60//00lHOWtjlcysppRCjMCqUZHpAUGzYXCtE/EmhOuYurr8hV?=
 =?us-ascii?Q?2IinmSOMnlPPwZMuaw25kEM3oRM9GuJDh0Tz6lbvxFZVhsvocSyhmRbARdoM?=
 =?us-ascii?Q?uju5AHsjxvHEOVfj0iFPNoJvPfQY4A3rOpiKVReV6hVo9cXVZ34Ph8/rUVyt?=
 =?us-ascii?Q?V+h61Fkzv+J2HEQDJcOVTjGsblEsaBu60uE/dJlJhoWPv5+uGYE8QHMRRstL?=
 =?us-ascii?Q?SDlreVqj3q0ld7e//giQX6H5gu5dl0EoVkPVzvnTacmZIAnHtuHuyRcB6ilS?=
 =?us-ascii?Q?2MdRKNoIPpiby5Nh2TcTB/Ypm0xlGXqIUFz+j3AS2nFiBDYHmzChe5ppHBFG?=
 =?us-ascii?Q?hHoO+Cgmi1Nu2t2WlgKS/FXI7xeaqVTEPwDnBC3uUhRLMkdxMQZRzBKkTg+a?=
 =?us-ascii?Q?MqF9l2Pq1W71Jo4uHQBp65zegSrVOsnzR9+WfDeNJZts/zHaAg87LaDq9BBo?=
 =?us-ascii?Q?erce6jCUJOwsbp2wbiMiDI557tuvRShwBv4xFxwCDUYD7VQg/i4IczD2/dMU?=
 =?us-ascii?Q?eyov8hobYnWJ+hHuDTVn/1DgmORFkMdmSUoLezIN1EM7jf1Au6tH4Bcp4o8k?=
 =?us-ascii?Q?gzaR4GRla7AccTeAeZkpgdaUIrHsy/DOkNZnXl3AygJoaQchOLUSb/BRadrj?=
 =?us-ascii?Q?QZVW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc920212-686a-41f0-ac43-08db3d23d1b4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 20:07:05.6839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukbkD7MNzS102WUKWSohSOr6wEjvvu1/Nn8L62lm664mM1iUDciKcCb+UMj3yMm8Y1DkGtbhQIQ0YC1lgVhNDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_12,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140177
X-Proofpoint-GUID: M8g-GPmGbKlXBGt2LglIIRLJcyjqRGvB
X-Proofpoint-ORIG-GUID: M8g-GPmGbKlXBGt2LglIIRLJcyjqRGvB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/23 12:06, Mike Kravetz wrote:
> Thanks Mel!
> Apologies for not noticing when the bug was posted to the list.  Otherwise,
> I would have jumped on it.
> 
> On 04/14/23 09:22, Mel Gorman wrote:
> > A bug was reported by Yuanxi Liu where allocating 1G pages at runtime is
> > taking an excessive amount of time for large amounts of memory. Further
> > testing allocating huge pages that the cost is linear i.e. if allocating
> > 1G pages in batches of 10 then the time to allocate nr_hugepages from
> > 10->20->30->etc increases linearly even though 10 pages are allocated at
> > each step. Profiles indicated that much of the time is spent checking the
> > validity within already existing huge pages and then attempting a migration
> > that fails after isolating the range, draining pages and a whole lot of
> > other useless work.
> > 
> > Commit eb14d4eefdc4 ("mm,page_alloc: drop unnecessary checks from
> > pfn_range_valid_contig") removed two checks, one which ignored huge pages
> > for contiguous allocations as huge pages can migrate. While there may be
> > value on migrating a 2M page to satisfy a 1G allocation, it's pointless
> > to move a 1G page for a new 1G allocation or scan for validity within an
> > existing huge page.
> 
> eb14d4eefdc4 was the last patch in Oscar's series "Make alloc_contig_range
> handle Hugetlb pages".
> https://lore.kernel.org/linux-mm/20210419075413.1064-1-osalvador@suse.de/
> 
> It seems bailing out of alloc_contig_range when experiencing hugetlb
> pages was an actual issue as the cover letter says:
> 

David correctly pointed out that I was confusing alloc_contig_range and
alloc_contig_pages.  Sorry!

-- 
Mike Kravetz
