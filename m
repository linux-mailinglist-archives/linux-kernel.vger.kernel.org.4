Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6075174921A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjGEX4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGEX4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:56:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B110F5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:56:43 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365NfvkH010188;
        Wed, 5 Jul 2023 23:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ow9WZiQgY0x0CNzkREOC7NzUkV5mKPenqTSe9rVbxAo=;
 b=ZU7ipVc6lSj4CQz6+uYh2z04JGwx5UtXKu2c2JHRKKHWdqPdg7KlVbQQyW79fHRUc571
 ghgPv/c+q/Zu7/em2+dt0xS+DvxR3QR3vxVd9tW36nPwTb/aZaSr0hBiE/aPTyi1Parg
 idjnd7fOLpErVi1WHFktPUM+9kXELS2SGjAHPk0YWjX/k1rXn7fbKcEqh2ySva3uftHr
 j4Irjtcry3qlAuXTnHBe8GwsapgEx97UUo9T1yVUlEsGORsUG30mIsj1e1L/5foH0O7Z
 Ug6yn9Xq8AQI/htw0+KQPg8GZLg5udoVhst0OV4c8OaAtTKR3RNm1FG5SP0pk5SfgkUg lQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnjcyr0e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 23:54:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365Nfgo4007304;
        Wed, 5 Jul 2023 23:54:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakc8bkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 23:54:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGVvb1U0bg6B3sc6NdiN2wZPPJzkArvdo2+W3ecyYPSUUguhcij62a+hY1UpIgrhO0quk/SLWp39W+iPXLfTSNi8eAvseppLxVSWZ7JhWBhlCHD7/4PCZgergoh3fBtQoeu+qHBj/Zaf/S9hj2k27EqfN6V2cObGS/7fVsbss2Pj2IKK+VsXNckuacaBXPSmOmcUGRU6OUQvmoCJjqdjG6WJ7RQjT/FfqXq5LgRtXhEvyu/+yrCWtP16ut2fw9tChmsSy3WYKatHhSfqPgXcejP64Aqxq7bvcZrEj+38mW5G8bKAZCEi3fiMwgJgarKmqKh3OA2WvXZmZhDH7wsDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow9WZiQgY0x0CNzkREOC7NzUkV5mKPenqTSe9rVbxAo=;
 b=jUamy1HqvGOxUU+1X9gaZNtyKSJqfVfPduNMTrusmiXZEKlVsP/uZ2xIWq6A4nbKZ6t0ZWWoj0dGLkGvdtIgnD5rG0vaHE3Sfwwf3PB6OmgAfjPwLMJkobaR7U32zq34P2LIIyJXCDtPDzibP/b5mN2EL+3pztpsSJz2iGKYjo+0a1VbB/s/IPfuRyO0yZ3XOlmhHC7rSE6iJ1uOYRf0zcl9eHvCEdbdVc+ltbDN+5dwlSQ6/CDGbhwDoqOdMPXof9AEPlpy0M9jEQFthvMfGYue5tXZ9Y69UwKvEkpxr0JIGAO0oZlwWpIsZpvPrq0fHXc9lZQhqdBoAH3R4p1n6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow9WZiQgY0x0CNzkREOC7NzUkV5mKPenqTSe9rVbxAo=;
 b=XBl2AO8KH5IDrXQVXxnRvSYOv0Cd/5/Lz4g2n7N9ybV+yd9waS+vY2Dg/Uz5rL7frD/KeCr4VczkqZUqRkaexoI7m8WDOby7j6gcPuX+xX7nu95n018J0yRq8sJx3Bf/w/xRLPVRjtdLJk1WebfKo/BcB+b1bsr9AoxKRuA+LBU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5657.namprd10.prod.outlook.com (2603:10b6:510:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 23:53:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 23:53:25 +0000
Date:   Wed, 5 Jul 2023 16:53:22 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: mprotect and hugetlb mappings
Message-ID: <20230705235322.GD41006@monkey>
References: <20230705230808.GA41006@monkey>
 <ZKX7PerFpnoMT5Pc@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKX7PerFpnoMT5Pc@casper.infradead.org>
X-ClientProxiedBy: MW4PR04CA0352.namprd04.prod.outlook.com
 (2603:10b6:303:8a::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa6033a-a6c7-403d-c145-08db7db305ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFCP/3gK0/ONG/mSmTEHVxzEtBe3P2tVi8LPf4Si3+Urju/kjj+rYh9CIpoRTr8ND1tbqpDUp9Yyl5pTiOfWxt4pYUycr3hto0eCROyyag+T65GbM/NgKCAdS2J7PkLJDhAH4PTDbP90ebBTRVGoOLHw5aBo4LE8w0fxq+f7xRMGhePhbPd/SK13yujACmTlelHPjbYGMRJb3Jju5DcLE9dEytIfkH+pRkU1lrowXJNoRF7kae3q9+3sZXPG2z93dsufAHpP24R5j6V5NzXX6pwqx7N5h/bGsDj+t4ziF2X6Z3CUM6z7T9S1OGPHmOrgp0XoKWvule76nEwPscPFHkF/jxQtnoPMJyLKDkI4txVKiD08TiGJGDr+hXuOK0YwjozjqmgnKZEXnn8XX/jZH4Y8Wz0iuqTASdTZ7muJkyWD2xNTUPcUOJlRu5UbeaWTjJyDNU1J73g7SXclaFQzRNHdF1mVWaQ7MePTyqeDPhNCJqDL23lg1R1FtaSvrcz/sGF2ZPqQ87wfC9OitbmwaFuda+ICJjFmORYdg3vp0HU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(3480700007)(186003)(8936002)(54906003)(9686003)(478600001)(8676002)(6666004)(86362001)(41300700001)(33656002)(2906002)(5660300002)(44832011)(6486002)(966005)(26005)(66946007)(66556008)(316002)(38100700002)(6512007)(6506007)(66476007)(4326008)(53546011)(1076003)(6916009)(33716001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rMX1oKK9D4F6GHwCQwVCvoiKGM8WnoSe7JlOzqt58/Td+EZ6VdWMplhh/jmD?=
 =?us-ascii?Q?4Zo7xtPJAkfRirKHd3I+ZwV0daZ/LzIahRSg2iiNG+W+5CykapaaFVVQvT6r?=
 =?us-ascii?Q?b4gd4/6hCS58icSp29XuMl9FyOJL3e0hhjYwavoB3hFM036rk+xdMeWvPHLC?=
 =?us-ascii?Q?Jsn8mFuFaX2YdQdsgD/2jqTKpHAid/GEQoBt8eSmz/LT8XQ8yex4XCYBGVoh?=
 =?us-ascii?Q?V+vDFTaGPblNiSUoYpWDKX8gbS/AO2gmNmB7TjSQ9sK2N4bNly5ZRdN1+VnB?=
 =?us-ascii?Q?If2cW5wfYXahRlNzxM5D/Gj5DnkCAJB9ZFYz5+G0hi0Feuu2T4R+vnWOu9mX?=
 =?us-ascii?Q?+i3rUrDZcyiIaOULZvBDNMtKq9n+lHf8O0kROKaK/YM48lNVnvZr6V/K2o11?=
 =?us-ascii?Q?TXogGs5izLR7Gr9oiElu0Y+VG0id4Q/RwwqQykX/v/dCN6T5r2Hk1xUqqFiM?=
 =?us-ascii?Q?qP/YVsO5qi6GoDBmwrC9gJ2PQCuh+riHTrL4rnBmBuesPbAnV2ZbaSn4yMwL?=
 =?us-ascii?Q?H6vzQSTAanEz+eGpWl3le+k72QaWVQsz3Rwb6l4BSCc6Oy/La8+LRvTde7Qn?=
 =?us-ascii?Q?fN1OiLgMikIXoFELcanxuCvBmrd7w+0az4Tb/7twh7eOfV9H1RQiwYjGzinK?=
 =?us-ascii?Q?QkdujzFaOnFxeVeM/B/U3cev5BAiqWC0gPEPzYtVCtNblvcagwAia+AXyvGz?=
 =?us-ascii?Q?ACoV7GPnaYN1OD8WXN6u0CItkxuKjhJ0LMNy2YYje2+1eHIqWgO1XtSuugZ6?=
 =?us-ascii?Q?HknF9pH0+GrkUVBnzarrsrO+VOnwVd/YcyxzQy/GVhj36KHCdE6DMIUbXikT?=
 =?us-ascii?Q?ekrehGvZzinnJN/I59hhAfWPsqLmQchL+EGzFZX7f1RLjow6P3/sJXXChkjU?=
 =?us-ascii?Q?snD6kfU/OoKpGSJSzqoTN6DI2paOL/a2t1Hj4o4kM+CIp69agCnDgpvxu6cv?=
 =?us-ascii?Q?AA5xtzi2F7p/vc1L8VYEimIEDAbh8QB+0Spr/3WyB5JmYkNKlAT/Iac+wI6L?=
 =?us-ascii?Q?5c1ySpvbN9v0GiOBkX10pUcZJVfrbxrmL8jwV8pVYJG1qMBm/j0C2ph7OMoB?=
 =?us-ascii?Q?3Sv+vqYi7+pud7gX3nyWys3+IBJ3jwOUUtOPbB6HZ0O3maHwIWT/Wa3XA4+F?=
 =?us-ascii?Q?ewvD0IcaNTlaG4TwTGaPVDtw4kYvQBSODMitZ+G+N02qJcy7SG1606mB7viO?=
 =?us-ascii?Q?3ictf5STbVK9oewdARK7kOSzHGBB637KEWUKl0yIlB7PJ3vCdaCP6soz621Q?=
 =?us-ascii?Q?cEhLr+WDz9Qf4/U43Zk5HWpwCVCBgzXwlBxt723m/Ki7AjXDEy7sfd88Zrpt?=
 =?us-ascii?Q?H+CT+4DEu4eYFoJ/BCaOGfmXnIYBdIwsHlwq8pSpVZb3/bn+gQHAbbUbsOp8?=
 =?us-ascii?Q?pPJWurb2VyXaSjgUTMWupCiNK828p3S2gDFNBRvgrxSDAT1q1uaos7pfh+Mj?=
 =?us-ascii?Q?CdDSkrnzWV6X1pnV9TaU6KJ07f6rGdWioUXFBymN6qNbubwfGhOTh/hI1Xu4?=
 =?us-ascii?Q?Gb5a/Y9QllxZ2Dc3mu71nUNhsd3IljZan99qVwNh6El1BR+KylCIBsGN5Uew?=
 =?us-ascii?Q?bKac34hOn2A2hv0qYHyGqpE1kSzynRtZCZHK0whsJID7/zH18dCAlAWPGrlE?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Mh53zV7LSsT/a4DkLP5NUrSGoeWe7UZsUwnVOUtR4+ystAA9ZIIG+MGmtk+J?=
 =?us-ascii?Q?Bhj5+64+/a8KGfdqslEGWyVPIlW5wFeBF8ToJ2nV5dhsqXM3XLb0RSJLPGed?=
 =?us-ascii?Q?69yUGVeWdvQtdI3/ClqE/hBUXOHAcMqRK6s5nYeFsATKz9/v9EAsFX8mJwxe?=
 =?us-ascii?Q?p8ApLq+uH4o1HA2LyKAcEbkwi9olFPeN9gPWNw7XkP5DFlxXVHlHTq0Wz8iC?=
 =?us-ascii?Q?S0s4wD7RQ4k36MLlzhACm+eb/eerDSBAk6UceA2PxDxgbUAXX/XlCE9s2LRU?=
 =?us-ascii?Q?YLB7HXm4FDD+qCVKMWoxLmMj8OeSZ9OqeyOD6JZ0J7JK321nYvA/0Ru4tPIA?=
 =?us-ascii?Q?dhIiRHUT6fnVGTKfKO2xq1GnEUWzR9di8kX2AeNm9NRV75UtcSZHM9WYo2Ez?=
 =?us-ascii?Q?Vo4NSYjhsTjy2TEsu5t81OIL4sUa3lyBYclk57TMYuM5JS1ItTaxBv5lmaOS?=
 =?us-ascii?Q?pfAMaT45lXyPu1nao57rekoTKKb1FlvOlW0kVJAvmqxmufmrYXbqtc9mzlKk?=
 =?us-ascii?Q?Pq7Aulfif03ygShwZDrrhF/Z+RawFbcYjVzQ7lOroQucOVCe2gr75gMiOC7c?=
 =?us-ascii?Q?q+r94oBXQR0WOckuFdsFx5yZjBtOZ6tO1QhOkJgJFZWqmb0kXiUELg4cPdN1?=
 =?us-ascii?Q?stxKh89MfYxS9KPPo6QqHL/UUpu0N6togp4OYv7I1vqJaTfCR4Lytl+yUJW+?=
 =?us-ascii?Q?7nXttZUXnAWUY3L3GpTj03fLuZuKJgxhIKhb8O3+tqpJbQi40SqMrdudn+OL?=
 =?us-ascii?Q?MC7VrGltYK+/AnlrUaXpLluZNRTX57X3EpRrNwbbjPdoIlO4PhVmLKu7BzD1?=
 =?us-ascii?Q?IQgJYfauBP2lYz3o43e2doKQ+rfq5fkEfzm9PR1jhrFAw2AyLNU4I9RCn4sg?=
 =?us-ascii?Q?wRyj0DKtHpPqYM/E944stKr8oJ7e/7ZYBFpDO67SraAd34yds95mb+YQZuEv?=
 =?us-ascii?Q?FHr/fx8/Zc24hfRmxyfZ0A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa6033a-a6c7-403d-c145-08db7db305ed
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 23:53:25.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u34+niu9QJQy7uIBtC72/L/EEXu3LyTEF3E07lhWvO/+ZXDrCXtX7sIeLssdfKHnU8TDofdXTvW9bOrDpBhqbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=863
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050217
X-Proofpoint-GUID: TiATxN61q0JJYcbG79oq0Rct9srt324Y
X-Proofpoint-ORIG-GUID: TiATxN61q0JJYcbG79oq0Rct9srt324Y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/23 00:22, Matthew Wilcox wrote:
> On Wed, Jul 05, 2023 at 04:08:08PM -0700, Mike Kravetz wrote:
> > I was recently asked about the behavior of mprotect on a hugetlb
> > mapping where addr or addr+len is not hugetlb page size aligned.  As
> > one might expect, EINVAL is returned in such cases.  However, the man
> > page makes no mention of alignment requirements for hugetlb mappings.
> > 
> > I am happy to submit man page updates if people agree this is the correct
> > behavior.  We might even want to check alignment earlier in the code
> > path as we fail when trying to split the vma today.
> > 
> > An alternative behavior would be to operate on whole hugetlb pages within
> > the range addr - addr+len.
> 
> After a careful re-reading of the mprotect() man page, I suggest the
> following behaviour ...
> 
> addr must be a multiple of the hpage size.  Otherwise -EINVAL.
> len should be rounded up to hpage size.
> 
> I wonder how likely this change would be to break userspace code.
> Maybe some test cases.

My concern is that this is the approach I took with huegtlb MADV_DONTNEED,
and this caused problems discussed and eventually modified here:
https://lore.kernel.org/linux-mm/20221021154546.57df96db@imladris.surriel.com/

In the MADV_DONTNEED case we were throwing away data.  With mprotect we are
only modifying access to data.
-- 
Mike Kravetz
