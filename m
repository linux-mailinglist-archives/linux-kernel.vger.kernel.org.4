Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB167336BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345952AbjFPQyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343842AbjFPQxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:53:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB73C02;
        Fri, 16 Jun 2023 09:52:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCi6PN026586;
        Fri, 16 Jun 2023 16:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=MvPtIdqtkblsWmLhnaCzSE2w+PrEdx8opthDNTdWETc=;
 b=ZNVBtJjThbel379cFimJtlMPIHEEfPkddoYJkx2wWNJBs6ll9S8z5l9SQqIfmOketFnX
 DarTESIwnIvRLpbIhT6mqoYgSlmEgOKpU4F4tpo2t3Z1CtZ1R0GRs05CTi+G/UNmvX17
 sT4IvfDpdTaLRosphKHhJk9/acDX0wgoDFFJqZJTc+v2TTl3aLWXR15n7UNA3AC+ffQ+
 bmQ1hLrxXtCK66MGOJItGDnF2rFgEE2TVsLh+Qin6oFgf/iMjIXqnEHvYEg+DgPNS0W4
 1cHIWHUrJfc1FdAvd1UKud0835SWuxDDfUX9KChzc0M17md4h86D3BbKXfWZ31w0fqFV SA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3mnd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 16:51:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GFWuvG033513;
        Fri, 16 Jun 2023 16:51:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm8fcr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 16:51:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqN40R+N/0o4O1Llym+KuvNjn4IW6/5Z+YbyD1g6Dzorqng3NhF9YYATeLLXtcrpEQqXEPZyYfP9xD4En2IYC/aaLPM7qvALISs5O/7hbz7GekkHb6OZFoAQViI6GzTjJ3OJSUOaQRBaUgdvBcuvL8n+SbS8+FXN5xiT2qSsWare+X7iUUl+prR2zLxpct4T0U26KAZD9a+Z6AgY6TnlUMvnXRkTVN2iSZsyQzZR27kMYiEfuuC6aKLX3jAZBLpLHY6jHXSbEbICULMheJu2cqI4lRZuHKyagscBq9pD06v57/+uhTvlCNT6QI77TUR0s9a/oowTO+vx8PmmYS4StA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvPtIdqtkblsWmLhnaCzSE2w+PrEdx8opthDNTdWETc=;
 b=fTikW7ViTrBnUxzUilW6z60qYKsaacMfWM58qAU3wUJJQ8ltIHLvfK3g3batDV//8gVi1pa3YypumAY8BS0nsf51rwHeSG4YzCIiWEtRHwbqGJQaXcX73RY4hwWh+SvMG8RqkVV9UQnzV35p2tiYWp98VvP80spTKSoQ9AkkCQAG4z9M1vPUgvKXOPRb3Q3VQih0xRQeH8/nKPd6e3G24xd1X2Ae5NGvrFAtqhKujo1FVj5vijz+fKn2Ctum8Qn/cHoFTUR5rONfTHfAxZKD9WPzOn1qVIKC4uzTVlcG66wCQ7aLpNithcy8WU0eAvAhXhNcFf94fquOa+eTrMPHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvPtIdqtkblsWmLhnaCzSE2w+PrEdx8opthDNTdWETc=;
 b=zfXgLDNesmTjmsfiYLUVT24ZLqbRHJmhWdqd5ivJEVZhkzF72dXatWwMDC6hRIwx1WnpemjJY7mseNPP1icBtnXeWTruzV1gV3BadsRhO0PAOR4GtRKOGyODOru9q/5zfMFMYhm2BFES8lLbOHNwpvAMUrNWsDFlwjWtpxZK7rI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 16:51:35 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6500.026; Fri, 16 Jun 2023
 16:51:35 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zg4zs64l.fsf@ca-mkp.ca.oracle.com>
References: <20230615134334.1d81c413@canb.auug.org.au>
        <4aa13708-9318-fd2b-cc28-166f13c31dd1@kernel.org>
Date:   Fri, 16 Jun 2023 12:51:32 -0400
In-Reply-To: <4aa13708-9318-fd2b-cc28-166f13c31dd1@kernel.org> (Damien Le
        Moal's message of "Thu, 15 Jun 2023 13:19:56 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:806:122::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: 018ce40d-008f-405e-53f7-08db6e89f1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXa62YJDuKCebReQe4NQVL9MM1DKG0TZJ0uYw+UziMhppb3mO1jBFXuZBUuIIN/ZQDwP3REv9seKl7n+3m6GlOhdfEljTdMvvOTu0hDmfbNRvYIrpsN5GUL9hjrtj8eRXNBP/56+AtEPzVTg4+nC9r+Osmmzn7aXYCg1rf1wqNWx5mPoVRo9RnxniJ9P+6lD3W5YTv1ZiTot0H/Xz5i036i75V5pd7UNsuwOkomQ+AiNmD4c3M0DEdIHgR0gjO+5Lfpr+LaBrUD1Us0upc/PE6e5+4BBllqS3QmqkcM3vxzgvBAjgfRQmxyVweeKDbr3nEeQoiGxti6p4JTbJfVfCt7inOIgAL1WhPqDea+LvQMDbNQzDeYbrZrlOUPrjaxeuEdWqiVBTPQwVAGG91598VAj6UAYZ4t66y3QF54CxwFHQh+JZywU114/4k1yNWUenATDhR6LRYt4zx3PpJL6xGE2rwqbDdygrCExC89EWfDtDRiwgmBFJgHYfynDZz6tLA5sebEBaYHRsBa+IiwWc/rI2DlTXXRTeGqBCrLWkGFsTaj0tJglIXWF/Pc29oFg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(6512007)(6506007)(478600001)(26005)(186003)(6666004)(36916002)(6486002)(2906002)(8936002)(316002)(41300700001)(8676002)(86362001)(558084003)(5660300002)(38100700002)(54906003)(83380400001)(66556008)(66946007)(66476007)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cdvl7ozdpadn9l9RC4hd7UPYlZ9LZKdUj4S3y89V8OFtfpJKM+3maOOiZCL9?=
 =?us-ascii?Q?JWP5InVNivQU0iglzeR6sQQv4za8MVOdq9qzQxtSn11KxXEv6fUalDzGATil?=
 =?us-ascii?Q?mO8BK8212YFznq/v/W3Iw7bpa9c6iNotcpt1518f+eXNTKgGB2WZhJbk6Xax?=
 =?us-ascii?Q?iZNwx3t9k10DbfquxJhWUJT6rxIeV82SfnQWVpvv0bVo/s52eLErhTEgpHlv?=
 =?us-ascii?Q?yG5sfDUZbVVLEgmnovQrahpFtLFnQhYHES1IyaknjzEaw7hvTImhzuwMBkew?=
 =?us-ascii?Q?0yMmba6CkBNKlVq5GFH2SgNBrTDRf/pdxHjSaTkDh1iQeSFNQ/p+oFiXHfUX?=
 =?us-ascii?Q?+wzauN8njAa87RiXrMqRwU4YBfc6WPxMiPDl1ZPmDeu+ooq1eaR9fupftQpD?=
 =?us-ascii?Q?VaSUM+lb7xBkpv2tBvbIoQxL34hlqGvxba6hMXaHkV5zGUHV2HZXnW1cqkwY?=
 =?us-ascii?Q?16WYsH40GYCoWZJEEj+rXUQvv16k5IZVYRl6tleylqAo7GFSZl0q43v7McGI?=
 =?us-ascii?Q?B49Cr+vxzE0HPYNfLU52yO15x2WQfPLpFYizRdKT4JXfgCPG+0F+SHnu6SmQ?=
 =?us-ascii?Q?mykS25I7n0smpnZ7tsNMhvKTrkjEU9kDkT2jvPukXp0N6Pqiv9G1nucnnSB0?=
 =?us-ascii?Q?vwdD1qzdoxAgG9ZNcaPR5CGKqdYXJ0Jm/qBuge6bDTtgW1qp5yJEgWqTCIia?=
 =?us-ascii?Q?pgJxfCmkPFHP6f7MnXMQmUgz6jM/2q+2G8xbNCoX6AcOQCPQbZyPM8jj7pdm?=
 =?us-ascii?Q?9AJqhxxj5DOn7uvVwKfEtV9v2EfbBuvonv2ngGnfmIndsQbBKX9tgwR1peyP?=
 =?us-ascii?Q?WXu/7qRHPZbJRr4Fk6yi6SSdUw1yFPpW/BYvMFsUKm0kOnKlrfPgnHsKY5Ni?=
 =?us-ascii?Q?y9A4gxA4PpmoF91FWU+moPyIWm2fswPibD7e8pjUI8P8jwnIfmihpdZb+mUK?=
 =?us-ascii?Q?DTVnkpEChEh1Qx9MdWc5X76uqJjrhdUmF9+cz56USMpTHMhBP8BENolsuhQs?=
 =?us-ascii?Q?8mGzT+joXF9m2zWEov7+tIBtb2BJ9QeGdW335N/Oxg6V+uHNP1gzr9K0hFS+?=
 =?us-ascii?Q?BC9sz23Hd0uO5uUmBHuA2BwvGQ0cxh/kWmGn7Tvr/mI7hD8L30BEFzq5PGVI?=
 =?us-ascii?Q?hEdTGhmIVhLyNahD4/IBjtYlmJ7UppSVQpPvphXyHaoYvI4+m7iBNpLejRWi?=
 =?us-ascii?Q?QpjBxttep4Z20SYF8m5uIHJ5uZL5jwBWKJp/tl8/KL/w6cIrYoDVFzTqObh9?=
 =?us-ascii?Q?zSdFpZWtd1U+irFBR3fVR4JRvu6lX5F4sNpSSTr+bm39Zx9f7BTeaH9jDvTO?=
 =?us-ascii?Q?vl9Xnwb6X2MI6+IW7DE4udBBXpJQ2CJC4negg6AKFNKvuUXir1HDO5pbjriV?=
 =?us-ascii?Q?nNIKwCD7xysh4onpCSVppo1DMjFXl4/yNRPHPirhXF3Yyxq2VX2N8ndugYyo?=
 =?us-ascii?Q?pwr99bwyyBWuxkRe03PqbHzF5ATumzEMw4MFM9LUWMJ8f2dKjgsG/zd3kTGN?=
 =?us-ascii?Q?ZgDlsjHd9GL3JXKMXj6C1YO1CPsgMO63NSOHfvl4A8IyoYTb2g9jwpzILAP8?=
 =?us-ascii?Q?oV6H+1jRNWHBy87fN+XxEYxgyn+h+MzYStEpDeFfaH3oltBJS9NnTXbJAbxa?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bvRWrnEaGFpJHR2qbUtbJmYAsy0Oz8pifVyFWOhpRIIftzgpajupNcLsN0tpLv+A4UF3xc5JfgJCorZuaK7pcViNdDOgWOg9XYWtgwbsew4cV8X4rGIBkmGXYawfUXII4QQqcQ4pbTaeuku9BVOsZ9iP+Zmpt/04jpWWJM+Rfv2SS6kJH88MIt+q2AfZmL7e0bhqnlgj0LYI2q+v2aDt+7UExi9Qhf/ZXJ2NhnPEUH9mM5MUT+f2uu1//vRX8Z703OHJ6gxiDl8tjCfr4mKJbSznBXJD7g8QJUNJZHv0codRVQ8w1/q3m67cFNwugoE6fsUHTxcKKyekZRVp/shb9W3T3HUzSHjgxDaRmw9g9qOEd4vDWl/+eMnWld7kWeb+gAH8HSyjCBsVIfS70H+rF1toUFNJT2Z86Id2A/1bCIy9Ie+enRIWOtdN3qfnlzw/vdeCHtZWqowM4smE4CPwzO34QLVbhdk7lKAydGMjuXEFz9BtgrTvyuYQSOdDd/MzYmhEMyYDYjHD62rcC6AYPOJuiWUSM7KYpz+w6TQ81/qJZFheFP60EBzk5dHvMntl15Bwv2Lk7iHE6mCKFex7n4CCvk1PZCo0tO+JEuHikDbLf9GzEdDwTQLkt2rIFK+TiyJHvDfi0ql9BB4jNi4LQL4yTIk/GT6WbnOzg5vnt/sHO7oppOHAGcY2AdTgELyg8Y1jWbC88trzF44RxoiNyD70G8ratijmkxkK970dNuhJOuL+oKyKV5WjpIBF2IOevBhUHh/AmxqX9XzIckwNvF4tRguSl6yR0P6wqmqvP2UAOp6eMHQxcOtZUQVO+Je5RHuV1QVb2enhKuxEK/PyiQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018ce40d-008f-405e-53f7-08db6e89f1b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 16:51:34.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9q0EBeRKRAR1Pflv34uXp7XnNR0pG7FiTViXrRHPXIVvsOrB7vxwn1YZwNLgfoCdRr3/jQXzT9BpIWQHxkXAE0QSQXynQeCNpmrRgxvnvIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=774 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306160151
X-Proofpoint-GUID: ZJpujFly2ANYNnwX9hTA-bNwFI6B4wlx
X-Proofpoint-ORIG-GUID: ZJpujFly2ANYNnwX9hTA-bNwFI6B4wlx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Damien,

>>   bfaaaa3d9d09 ("scsi: block: Improve ioprio value validity checks")
>> 
>> I have used the scsi-mkp tree from next-20230614 for today.
>
> I believe this should fix the issue:

Now fixed up.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
