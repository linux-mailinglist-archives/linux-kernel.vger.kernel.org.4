Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627EC6ED9D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 03:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjDYB17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 21:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjDYB15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:27:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1925277
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 18:27:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P0iDef016522;
        Tue, 25 Apr 2023 01:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=gZXfFev5tQLw0xuHx6nlP79XMydgGQTu2LpKhux08Sc=;
 b=U/U3iqgo5zf6TwtC9VHYweBjMe27+04uUxHd0rQv9sZKc/bS6E5MB/hpIkDFD/YYiNEz
 3tLhOARvOh3+MgB6XvpFhykHULN1E4Y2pJSabAxoyjinWBz2pvCH9raNcLga4xavJoT6
 32eV66JKgccM3Qa0Cdv8E31NrbLgHzOa1ae/+Zc2Puv8ZqbZ1WTYNCQV/Pf9U2C8g9au
 QTF1i5CqGs2yF4bsRNci0LXWAAzyHNbq9nZn12jgd5ahjvK33wEFFZQG32fzT9TcDChV
 6ZrlDkW1nH05zNad3cCK5zQU4CcvMecN6H1PlgzwFV6ARgIZkkdEy57+7ffYNnR3dujG eQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fam867-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 01:27:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33P0UTGR008702;
        Tue, 25 Apr 2023 01:27:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616189v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 01:27:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHufy1jM4pOx3Www+H7PkHj1ugD9yzDeAwhcGOc+LQ4nxcV/aTDQJjl5JY0fkI8qfgL5t4yle4rOdJU0qFjeQ7ZSWGzhGR+zio6aa8SOu8OE5NDqOZkXCYhnxuZ1lmirywzio3k9t64iLDp1VZPb0MFvxShvbWlEebqkPf41X3tcntmldo1C1EbEAGEdJkR7RoX9c3Dlay5N3iyGRmp5PVKqC7MjsPNMkuHGyHg6u5Q/JGyNLkA+FdSsPtIlZZhEyKk7OeodbXY0XwFibMxVBFE6EgBXQu0wvH9J484X1vvBlf/8UfEsExXF/JJ/TLg15+cESUyURsnlRfIGejcabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZXfFev5tQLw0xuHx6nlP79XMydgGQTu2LpKhux08Sc=;
 b=QnYe1up0DcIIazfwLmzSTZGtfZV+MmQQDbjWV1PgvuYwqTCZBRZWfrEqDvj5OA0Ru5GKePnWZzTqOaM9pWg0ra/UbSrAJHafl0N1sJCU2H7RIMQ0XqDHicZR+AA4trujJXBfmFapq9VpErnfkgsNwwvLZjXXvtZtZqkqt5rpZQqUrsiWvdCZMpHLJFluU16IKw2CmsNcq6TlLuvOh/GKVVhheTi7UOAY9EZszNqshe+LWizclgBAW+shtiiLN8hSg2OJu851fUabvODsPBdaiuP2gT9iqROBvRXRB7PdOtcsK5Pmaj9jBCo5O7O3bwtVoc54+QI5hqfa+8nQdMx0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZXfFev5tQLw0xuHx6nlP79XMydgGQTu2LpKhux08Sc=;
 b=VU9PvQwi/p7LQm0soP+ucIb0zpOlLJqMtrScmJYhnFr+OC5nB0CzvQcn8g3YeLyMbEvq1CxXRz77idp4E9v6oAHiTKeDv3wAaOLXK2ao9ByafQu1uQ98q0O8Q6gnLSeqqsmiY7UCYGhv+S3Wh1n4hX4jb2A3QLxxV3f0C/rbt6g=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4168.namprd10.prod.outlook.com (2603:10b6:610:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 01:27:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 01:27:24 +0000
Date:   Mon, 24 Apr 2023 18:27:21 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org
Subject: Re: [RFC PATCH 0/4] change ->index to PAGE_SIZE for hugetlb pages
Message-ID: <20230425012721.GA6696@monkey>
References: <20230413231452.84529-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413231452.84529-1-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:303:8c::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b32a5a-f79d-47f1-5b76-08db452c3910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATkiEl+pcuAszOqkAMe62wv/WIZAsMr6boNbCH/PuIOmMiITc9KnVcpTH8zOuaHgHc1YHY/kLY7SeCl7Z1SPC7ZN4MMWNDpJMMnIzg+ANlBh5ObySh+4mFYBM5z0nVUlcjh+jGsEwb1Jfjj9Dog9EQzvu5p4JtcYITKHeAzeL//zx4Sk+k53cKj99HhyhjyzOFo5GpAmSajyA41dMZsTBu7nFjaEfPRah7VPX4JSA3QRSGv6Lzt7T+rGUh8tM6tDJiqLaDuTzkluldX9nqeUNxmbf86UZUNpK156Ez/jQxEhaTtw0E8xjvdBI183v8YW40qiru+MuBWxpeBRtkwQh0dLY/SHDdcpHPqk3DCSEXvL8Wveq5zko68U1O+biXI83X0+ruymrU9pN9ar/GPuFubQjjifHEqseG13D4dW5eo31rD+FAkwEI8iFfnWPIMA6uhsfC/SGOJ+dRGUz6P67Iuj6s5RBr6VONhqx0uCeUQkMOoXF8H+PIWnS255BbHboSJpMhvdon8zd4xcGyFFGiIeXlk6sWHuGNaRGLw9Hn241MfMWlPOoUgYHBwMMK50
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(478600001)(6636002)(86362001)(186003)(53546011)(6486002)(26005)(1076003)(9686003)(33716001)(6512007)(6506007)(33656002)(4326008)(66476007)(66556008)(316002)(6666004)(44832011)(66946007)(83380400001)(2906002)(38100700002)(8676002)(41300700001)(6862004)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lzcGwD0LBBe89pBZjiBRCuZqqukrZjsA4b7rfjr6msvyCkvxR6lM++LTnMkD?=
 =?us-ascii?Q?bYFto4HYrEB6TfZiM8ozDGtFiOyvJICE48MzM2HUWGlgJHgEJc6HFuV+8U/e?=
 =?us-ascii?Q?f7h5jF0IYjgKM//XhIg/1XRZ8LXpTXX9BCXIOIF/8yfBXfcTa0ZrR/909OD0?=
 =?us-ascii?Q?3BwGC+4n69PCxb4+G6QGG7b6Ye8abSnEIOJr29+dl8udiRc78eIluPffk/z5?=
 =?us-ascii?Q?BHD06rPllZYhocL7eAhqUB83AzbhVCkFeEAvo3Axa8rHZ6SUshxj489co/LI?=
 =?us-ascii?Q?Pp+gwBHUpQdKTxe7e51dE1SydhMh+zGQVcJO+sT5NpxACwM07bVPIcKyKR2a?=
 =?us-ascii?Q?V7JbXhhZJ8aBwdrwhOqx0MlqMZlcPmmBdxZPU0dfIu5O3cJs22fbFh1Aj2Fn?=
 =?us-ascii?Q?1CpczSd63NjE+2zABYwZoZnSrnZQRoLdU9SQJpd+UX+oEolRa7nodnprTLuZ?=
 =?us-ascii?Q?EtGM1WIkz6pJ5GNnHDjAZQ1nc/egz261fVKFYzHIetRrjCVNhDpiupd+XdXD?=
 =?us-ascii?Q?D+K1dZ+QWabiiP0OKauvj6fgpxn4bSmUf/MoEKp0skAd/AaqxWET6ATBDtF0?=
 =?us-ascii?Q?MmeygyBHovAXu0a3yfyTpSCBQStJzC6wEbFvgjGkOuum/efiZJwb00j7j+vn?=
 =?us-ascii?Q?D63Iif3ENWYt9jlDlR2n9Wbp5PshOe1tPnvFel8ik9ulVhTuSNdZCXDBC1Lg?=
 =?us-ascii?Q?4MV8GZBGHJsW2tmjFqhw8EJbJuapAgCUXUEDkaZOTyLrkEfqGkW/IOUtQEUZ?=
 =?us-ascii?Q?21Y4wncg3gbYL91tDUJiLZHHjQYsoJiTzudOedRV1Eh+F36Ad+him6z4Gey6?=
 =?us-ascii?Q?3KOsAY64GQ/lmcCAKXXGBurIz9BEY8XUPSYPZKdtBhTTQpSkAsIw8h8dyCH3?=
 =?us-ascii?Q?UhGNYt/9MhwC8812JGObLGTARWLoGaSyCCD153FDbf+0VEshMnBBj3bsObYA?=
 =?us-ascii?Q?kseso6hbfAduVoz0ZVtMCCzC4Nprplm4gDjlCxRXobxV7nrMLJu0/gPp8P7o?=
 =?us-ascii?Q?RKDVP762adVaunHUao4gDRggoz6zpX3V/f3PsWuJWZTTLEKvObY3pAVzIXqX?=
 =?us-ascii?Q?+hex7WE4anw7UBKdbkVD4q9aJLZ9wTis/xGqPfZ9FJaJ1wJvGHkk3UcLcu5X?=
 =?us-ascii?Q?h9pfT6NStK1vXuTaV+EhH01xOWhfhy82cIAbReYC2zaXLAoVztMuUkYnugPg?=
 =?us-ascii?Q?zz7v6QQRIR4sXVczNK+OiU8OBJhOPwssnGofZBWRIKkLy/5D/1ZTQYLO6ya1?=
 =?us-ascii?Q?X5BF31JoC2EBE63//ao/XL+TfNoeih00fxRYIlUvOmhDWJqdLAjgj88nzCYp?=
 =?us-ascii?Q?fRs9xF+Pc+iH3gFneZMVZ4ovrDiwe7sTC1uSwR/StoA23P9lqTQ5anh9JMNA?=
 =?us-ascii?Q?Z/SiNKzByeJo8LgWbMKYrli3Z+XDd3t1Upboegw8TW3wH2K27ibTTK5orBbR?=
 =?us-ascii?Q?HfZWgsV6KJtH03itg5yGoWoBGpWod1Jynhqedjf6TwPFzPa7/9rXm5/VoOVO?=
 =?us-ascii?Q?vStQ1kMUrwB4y1YTAnJawLcUjZFRThFssMPaAup7dnxinfKD+HHnVfCxPy1t?=
 =?us-ascii?Q?9eykMReF9c54QNACPPOtICOIpeiP6YWdEYKezTHj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lkouUmsXLDemmxvRxxFehSm8I3J/AP/CxQrOZyg0LFZlUxy2/pu3SyQBlStWBkJtNdj7hFhNPk/93mBmlVNjwdjTiOKEJfssD1EqklHbLubuAQTdXiPT9Wp0PTV9mXrKwkId0rRL03A3Tp6m273LtzXJNYWNo17wAU8VKipkeKbY6lNvTY6FssNaTfBaU1nBYG8P28DROl5YpkH0uzo8mC0nS8C6X6VHt5Y/KsXdhrOFxDxMIWlmqNPFDNZya6O/VY4HqYKJm3th5hby3/T5Y3Z17OWHxQ83YzM+SubrvCo+FFwdS0BdGVPSU+xM2s2JoVlYnvj1jl0rle35OGF5a+1rGF3Wrzz9kdU3TffJzQPhOVUYvIcbyCj3XS/VXTRkbbb9PkTScgTcYaA64N3jxHGydV6/9t3QKOdykw0MfKeedyy6YINBw/wVshGVpKmVo++TBrzcLIabmMwCGyHAQW1Ns+wvWGUoXDNeR2cwLV1vgn7VE1J93obEV6vjYRdKl+i9CHWAWhUxPP/2DUJ/+DWkbKRb1TYrUWTGLtSbB5I9NcWjqHCISwVQfHTLknLGtitGC2I71JpkCWd2uYWqhWmHK2QTHcCigW/KzdDGeLc6LUdpNIqZUYn5OdZ1mpJkJn+w938BvchaNuF746bfunfdulcxz7UFiQlcGR5JXYJeCQOuU10VvQeLJ7gX1bJTU2Pjj8jy07yLkhOZFbro8usVAtKYXlsMd591DlId4hLjc+MJiWH+Y7iMvdbuDCC37t6B30wEmWruqjqvui5vxjgfHxL9H07EYr1NqGHXF2OXvGk5bSKei3I2HyjxQ6ccd+tVlonqcA7FyQWF1fjTm+yIOcGvftldzwzqvQCh+bRbi4fjXNyS8fccrnKPC9yoNBTOMpzxwuzQ5jtjCuj6aJs0bHbMdRzZpDK8epVYBv0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b32a5a-f79d-47f1-5b76-08db452c3910
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 01:27:24.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HN9sUIIp1YqqtOEGYsAOSp2lrDm9r4Ppa2ZQJLfkrIq5a1Ci/tphx/K8aZLppory8MI8mZXrUHSYC8tcY7hE5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4168
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_01,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250011
X-Proofpoint-ORIG-GUID: -yY-KoH1sFvX2OriAeZRsbUsUCU5r9Fr
X-Proofpoint-GUID: -yY-KoH1sFvX2OriAeZRsbUsUCU5r9Fr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13/23 16:14, Sidhartha Kumar wrote:
> This RFC patch series attempts to simplify the page cache code by removing
> special casing code for hugetlb pages. Normal pages in the page cache are
> indexed by PAGE_SIZE while hugetlb pages are indexed by their huge page
> size. This was previously tried but the xarray was not performant enough
> for the changes.
> 
> This series fails many of the hugetlb LTP test cases due to bugs in
> accounting and I was hoping to get help/suggestions about why the page
> accounting breaks from my changes. The basic mmap tests pass but the
> advanced ones which involve overcommiting pages fail.

Sorry for the late reply.

I can appreciate the desire for removing hugetlb special cases from page
cache code.  As you note above, hugetlb tracks page indicies based on
huge pages size.  Page cache page indicies are based on base page size.

Within the hugetlb code, the huge page size indicies are used in at
least two places:
- huge page reservations.  There is a rather ugly set of code managing
  hugetlb mapping reservation maps.  Since a reservation is for a single
  huge page, it makes sense to use huge page sized indicies in this code.
- hugetlb mutex table.  The table is hashed by the values 'mapping' and
  index.  This guarantees that all code performing operations on a huge
  page will use the same mutex.  So, using huge page index is a must.

I think this means there is a need to maintain/use both huge page and
base page indicies.  huge page indicies within hugetlb code and base
page indicies within the page cache.

One approach might be to add the conversion from huge page inded to base
page index for all calls into the page cache.  This could be done with
hugetlb specific wrappers.  There already are hugetlb_add_to_page_cache,
hugetlbfs_pagecache_present, and hugetlb_delete_from_page_cache.
New wrappers would be needed for at least filemap_get_folios and
filemap_lock_folio.
-- 
Mike Kravetz
