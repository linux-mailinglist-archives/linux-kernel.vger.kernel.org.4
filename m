Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A8F647ABD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLIAXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiLIAXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:23:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC2582FAF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:23:33 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8MIpoO021255;
        Fri, 9 Dec 2022 00:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=pzJQRi+/wd0aVIuJVqT+3vs+tfpMIp/Ju1SnbmnQwHg=;
 b=mqJSukxZZ+3NqrzFlrhf8qJaNXiRMUKSyoktbiwseZ4y8HoRmkjx4oQGDEIoSL2SFGm5
 TOYo9pS6GYVsLjjyLSdO1qF1NYihb6rawMo/wsV6S8x8uoCbp6ZvNyvliwFe9KfV48mX
 4miC9E/W7PJDHZiEVSu0ecuBKTyGx2mORSyfUlnYpsd2/AMwcwyFSDK/oAM4Uz5iHQ9L
 7We8L4A4FkPfaSDGFWSDd/2kcbrQp/dHV+8EHD5WOHwVcsxN9Pzec3ospWpiBhJuRxaL
 1j4vh/ZLHIOMlsOWZ/P4EindK52hr31mhaEpOsAcqgE2I1wCK1Cq0gV561xKP6REB+jM 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maud748f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 00:23:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B8NmHN6025454;
        Fri, 9 Dec 2022 00:23:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa80f01j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 00:23:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCaCo8IvBFnqCBNRMFTT15ersn5UsQoLmgrp04ZwK7VUnBcYcEQlXUN18VsdX6tI7L9oxzcAPXTe4tMK920Eypz5ABfpDGTM9KIYbX0MZXTTBXZUZw5AEKeL1f40mCz3MQiWCvhx93bDG6gu2jkSfPD0da3+C4BbqbuRskFj+oPFKbOAnVRgU5UffsqJ8tNgqJgVyG9MZCEZiQcT77SQPG1eLLHZ4r/aCabpfstl96Xn62UqdrpyyUlqvn9Ur3NPGGW3xavoMOlfGLiTg6+U6sxcxpznW0vs6a5O3hSPkq2wLVM9ods+wi6FViV3S3RU185p1XV2cKFkNQq8UulLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzJQRi+/wd0aVIuJVqT+3vs+tfpMIp/Ju1SnbmnQwHg=;
 b=O7aF9hlMEEY3p4Qdn/uPXi+QxPvmBl4HLNffMMsx2xuOl/6SqM1go80uBSroGOOQRnRqNwZjez/jphhIW4Hhzwlpe6mCEIzi8OJqqIsK3VAPwL/T4WgLlEb10zBbT41ERfSyPMIhVW388ddX3G02gnEIBuMRYvs1wQpT61brK0mMVQcFIJW8R8CAdAbhvKv3G3eeK83/liysFHt+tYPSb+tJN6/5AzcaMamUbBbfFOex82JoOXMim6eZQIx34X4l8CkcIhuR0EcwN569BlGcDELLor259hyro6DFeoCCS44Sz2MiIJRFv+PheBVB+7PDJoMArzYJJ6+LT5rnqWWfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzJQRi+/wd0aVIuJVqT+3vs+tfpMIp/Ju1SnbmnQwHg=;
 b=QOlQ+3Y/5s2tV+d1Ll/WPM3VuoTwKi8JX1p03z3W0CYketRk7yq4g9Gl6WiENTZzSEdYn9VzUE4Js0fWgqhHok4xxssCzNmjH89S2ZYO/M/Nlfp/I1RZyVTq2WqtXD2Rj8IeQ1/ahMLg2O7FVY640D4gGggemd1Uy5rFn7pZ3P8=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by SJ1PR10MB5979.namprd10.prod.outlook.com (2603:10b6:a03:45e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 00:22:59 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::4786:1191:c631:99da]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::4786:1191:c631:99da%4]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 00:22:59 +0000
Date:   Thu, 8 Dec 2022 16:22:55 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 04/47] hugetlb: only adjust address ranges when
 VMAs want PMD sharing
Message-ID: <Y5J/3+cDZ8Md956A@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-5-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-5-jthoughton@google.com>
X-ClientProxiedBy: MW4PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:303:85::29) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|SJ1PR10MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: a93c5944-2839-4b7e-6203-08dad97b8660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UgcBB24649rMPcKkSrsak07Lcuroye4n8qZioE9qSh5wop26cAqYqEOYt1tS0nSfgH9BnCWyBz8MhLt5LohwAB1XQdscgBvXWTmNFrEmt9caOObIOCTplhGOIE6E04NLFG0cQYZFcubbca6S/XQTFwrbd0FRM+GzeF0rbwH7dzUP2srSypvYd4U3MVXcYfFI/PKNS5tp6voQmHlt8T29Mle2V/xkRIrAHyQqNrpwjBjLoZKKhktaZEmyJZ0JlZIWAAz6Myr9qgyblNVUFGzEGtQKj5s28ID6l7CgmYqwYTrAsNlm/DQMOfBg6YiThgSl9dPICorNCB9SV6ibuhSp9mzskLPSFO15QH8VMjleuMrIexs7xY+oHm7ySwGCpnr+SYWmZTljuGjB6lZuQl/6TmTlRjTaciFn+83KFOAeMUrZfkl6uPqsnbt38Ci8ana8UUlMCLxRDdszfla6UbGTp6OuBRih7NK2/V/HV9UrcW751tO2cTRUCr5EraIG7Md6aOg34rn8ah58zSxXiF4HAsBDP/6CU6hBh29T5rVB7ar7o1bRtIZGhZeGcEGoWCVlV6O8yafb67mN4z5HcnhlJXuwrUNU+RSo5A3Zw5i1O6/BOOjBUDz5MkrRF1BtZlTPjt9l+p8tbo9jYm3zZpddRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(66946007)(66556008)(66476007)(8676002)(5660300002)(7416002)(4744005)(4326008)(6666004)(2906002)(44832011)(8936002)(316002)(6916009)(41300700001)(6512007)(478600001)(6486002)(54906003)(26005)(9686003)(6506007)(53546011)(83380400001)(33716001)(186003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uu8Iz+NKeI4eOXGDC3VyZBlWveUuyRvfTGpfMU0BgiByAsjjxP1QPSIhEVso?=
 =?us-ascii?Q?rn7xsW5JagU8jwZtSD+S/d4jB7sw1FGzirl7Kr18jg2uI5onfddvFOIuJ1+7?=
 =?us-ascii?Q?0fcj5AJ8reN9fXeQjFH7w/kuIR32vl2xcd82shuHn8KMjybXn1z0N0wIz7ra?=
 =?us-ascii?Q?EP9jQ2IeDdVJptpYPBg3VsEHhkc/CrPOap0LoyuwKpp6nEshJelZ6J8Bwz0p?=
 =?us-ascii?Q?JWrkjJrLGFxhYXKamSPs2nZMdU3xMvJM98iPqNA0FEewwdAJvpmHy8jxr7C2?=
 =?us-ascii?Q?HTiw2xIDoVFMOSgimVfgIe/cFBrDkOw5Jn38JFBetfxCXTNnTFbTYzVUaLJm?=
 =?us-ascii?Q?kJLW8MUnn7lCigzo7uj5/IedmZZjRCLKcKQ6EZnVQxhOrb1CcK/i3DBc68lC?=
 =?us-ascii?Q?xvbjsfBReMg6pt51SeOR48DacgiCKIs1ijUsONF7R6x+g06zxSdFHflY/CY1?=
 =?us-ascii?Q?ytnm4LoNqQWG8OL9MvsH0C/fp0dpkYWBlJDzmVy+iW7a4B9q7XsOwXVEA6H4?=
 =?us-ascii?Q?/AOS247LTcVD+4WFLLgJXi5fNgEBUXCY+jjucPPDANJTemjsa2+bvMsujntf?=
 =?us-ascii?Q?UmRLwc3drQtEryFWTBRy9IKiKOnTGzbYX8CDx8lLtnvVQ4LMUjXx3AwAgdF8?=
 =?us-ascii?Q?xWXod0HtOZnYDm5OAO7x8aMeNwpvF1aJYmRw97oN2dXfJBPFJkiiz/PdCqxs?=
 =?us-ascii?Q?cDj5GAx6jVhiikaijuHe4XOHjzYh/UYLfE1++gYjDe0rQ0qaLlyHMRRgwuu0?=
 =?us-ascii?Q?uiIMQpK6f6xnxFk6MY9gnRUGZ0dGMg6oCcV0SzQulPnGtU3ZYoc5avdDvFve?=
 =?us-ascii?Q?9kxmnfh3nHwqM58uxpG4R+Q6MKGh6ruSCA4y+WQ+UeG6WmmD4y0i8pZhdJpz?=
 =?us-ascii?Q?3Gs2Iz4xh/n57sdHDO6mX4SJ1KwXCKOW3tEVEnhad7SNgP31zK4qNndm0+Cy?=
 =?us-ascii?Q?8ZHGa0tm2GJi4kA9OaXseKzp0pmMdeOUEmWG1E5vujLfFk19YYauaGqXNES2?=
 =?us-ascii?Q?gWtB/YiF7iX8L9bCqAy3bRDimA/atANgtDCkDvI9ebApGL6xeq21GPqGXkaU?=
 =?us-ascii?Q?1q9mgoSPO9a6XfqZX3enELaGYFJmsDRTmzf91O9HRu1roBhNq+H51V/GeOab?=
 =?us-ascii?Q?PES0KLL2OQEFVpfDYvWArODn/gVRkEHpgGRU3ID3wo/g1bHzhoTv8OtdtxOG?=
 =?us-ascii?Q?6LRIvbT3V2I7aLEmtYlJakskoBgAIYfmRYLV5bMDmhFkbS9rmPVrXb1ZSGV6?=
 =?us-ascii?Q?IGFd9jH4u28C+OFhlt4QNyRxjODQ7D/3dgFLzLy5ol0c+mkrHYutk7mEPyzm?=
 =?us-ascii?Q?Yj6pb+ZAZaw0trgJZWzKDv3XsV3b4BcbNug48nyF8Tf/wGMChBh+RGU8h3ux?=
 =?us-ascii?Q?W6h7J1PDMDMBZ0uAJ5pxqtfmLM74MVMHFCP728wAsSphpuvypAMpkVLQhuU5?=
 =?us-ascii?Q?0odaMAlgwzElXgmtQdPhoY6zJ6tZOM2x/n2x5rvXPUR1bPDj5X41hqd2jktq?=
 =?us-ascii?Q?LxDRr5uc6m6PCVpgAiu6+/MvhvFgKWWBNFyOe44hxnhaCgq+rVF4ZyYcBzRi?=
 =?us-ascii?Q?JBe3Zf2wOl6zXv3otlOo0P89d/w+evI3yL7AfqeVkP9ncRPVW1DMpuc/Er1b?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93c5944-2839-4b7e-6203-08dad97b8660
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 00:22:59.0638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aA40ZXM/vbfQQ7YbFDhNDDoPrkdkAaH25WAPtdAMuF2/tA4VcKSDWNHPYtVmotzhzaMOiHq+OJOoadFk9A4Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_12,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=901 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212090001
X-Proofpoint-GUID: R-dm8ness_-HkrrA-k9eOf2rxhTFvOW5
X-Proofpoint-ORIG-GUID: R-dm8ness_-HkrrA-k9eOf2rxhTFvOW5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 16:36, James Houghton wrote:
> Currently this check is overly aggressive. For some userfaultfd VMAs,
> VMA sharing is disabled, yet we still widen the address range, which is
> used for flushing TLBs and sending MMU notifiers.

Yes, the userfaultfd check is missing in the code today.

> This is done now, as HGM VMAs also have sharing disabled, yet would
> still have flush ranges adjusted. Overaggressively flushing TLBs and
> triggering MMU notifiers is particularly harmful with lots of
> high-granularity operations.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
