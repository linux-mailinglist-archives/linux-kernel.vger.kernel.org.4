Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D876461CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiLGTfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGTf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:35:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABCE4385D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:35:27 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GDmOX010578;
        Wed, 7 Dec 2022 19:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=cNfLDNcXYpqs5vZDDCbzBZ8Q4HDoXszZFzB5KnIVMyQ=;
 b=GY1Jj8RHGKuE92gYaSU1Ykl+cgTvXVahqsGl1glemfcjwHaesH05iuJjMh+sccRb/ukW
 EwE+HOER8isqkfJAg4AY7IQ6pkuNCWfm3OubDGhxa+nVRw6/YXvdfA4SgTMWIOtjh6M6
 JpF3A+zkhUEybX7vciUNnm5eDTo0T/5aM6wPv9t2YZs3pgiopfIrz1jPwokNvFl0vFm4
 VJKOU3LFKCOOKfwqRNUIlEMVQ64Nrih8ovybKM+EaZ0wwXOeXBl5p4bnejOdqoVfFVld
 fosbj6IDKrhYwGoAlhCFjNViVmohXlQ72Jixl+nirZY/VeqauAwhkpjRVr6R2g3dU7A8 UQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mauf8h65u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 19:35:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7JDowu001933;
        Wed, 7 Dec 2022 19:35:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7cth9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 19:35:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaLzts+W1CyFTMyL47TpIMypfVTkJLvBdrFqTxBpMjAS3rab9mfGgwr1btTRsWqiczucMdIaPYbUMuAGwGy/w68g1NMOIjme0aVhP7S5xfGBWeyweFRRGZhqY4LW4X03CWQ0TQ4Iln67+21CgzdTMQO2eUe6QaaNYeX/IfqPiiQwCi7zLqbAcj8e33YRJF9egiPcVzZByuh99H4cWAPt1oL+3aZp0NSBtntnHddH6tpeouPKi4TjwupPloPP9wcOaQmrSddTP5gOVk18Ze1CMApyLiZke4yHh9vHYRaXUXuTWjW0OspDE42aofK6j8NgBT4igTLgKCFE8AxwDTBLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNfLDNcXYpqs5vZDDCbzBZ8Q4HDoXszZFzB5KnIVMyQ=;
 b=VzqlEE2POH7AngaV/Mebec2sVfaZ24jRRmx+OhX22CmArM4TB96FE+gW+MzZC0kYIEg4ONwCQcr8p8jDDH+XPyZdv2WLq33ZZO9qthM5GLIDwc7M4Jujy7Ys6BiommnHtXwKUtBk8JaVCQVWf/9e6e55ZJvHYFCbxaDUZEBjv424Ss0M1lWYucRLc+rUyXSOi3b2B5cf2N6dT5cwistv9WR+G4u8f5J7v0nJlFiO0ideWKpdQrLGbKZXh7EGYERSHQtiM5odL/xL86mIEQ9C1Q6a3CXIsS/Mdf+4OURgXUacPpTNZO/LTrrWeGulgY3OAWgYGhvVpDQW/9eHpQuhzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNfLDNcXYpqs5vZDDCbzBZ8Q4HDoXszZFzB5KnIVMyQ=;
 b=BNWamXMOHDsYLAiGycjcPehf0ra3K/8ppHOfGlWFTXCzxwKUxwvCj8oHx66eOiiM2tOUCd37Eb8S9hn+sN56zySSfAwd1TZ7TiFCqW5jFTKvkYdeiRSWBsGxYV620J0aD3vAbpobMfp+qbwjXnOSuqR9thOJ6UddTxkiiWSDpkM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4677.namprd10.prod.outlook.com (2603:10b6:510:3d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 19:35:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 19:35:06 +0000
Date:   Wed, 7 Dec 2022 11:35:03 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        hughd@google.com, tsahu@linux.ibm.com, jhubbard@nvidia.com,
        david@redhat.com
Subject: Re: [PATCH mm-unstable v5 09/10] mm/hugetlb: convert hugetlb prep
 functions to folios
Message-ID: <Y5Dq59ivU1I2Q+8l@monkey>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-10-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129225039.82257-10-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:303:6a::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4677:EE_
X-MS-Office365-Filtering-Correlation-Id: 64adf44a-1ae5-4aa0-5cd8-08dad88a2515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ha+530qWpcxPEqYrX7wF01DDTZ0BIMoK9B1aZbgbWH8xi+9/N5e0fBkpqRKLrmn3FbHV2fpms8WtGzHRZyz99T5lk///ZuRs/B4lKqvwXsZK8z4xUlO8WiTHkj2WHbClAHYyUjeJ4ui5zN/oWDK0d7q0zb8Wrn8X1MNdrhioFJfVXtMEsDY1bux11F6sN0Fdy+D6oEhKQdZqZBKkcP2t8pjMff801IXNWAdUNlkL2gXe0FQ0YCo9i7Fb+xHxjq8VgOst4Hruw+gD+RTTYO/8s4hjX3Pj1nCHHRc30tsRXjClQG/4TMzetC9qT4kwfl7m3w+WhV4bEwVvkBjaqRKQhRQx6PQGYH9gbJ0lAXkgrGo2669eRYBT5cBuO0mJs0VRS0Jd5LA+mj/e8E5xQV5eUwGZOmRRjWBugCZrfHmOLjHdxbGBgOFJ23YF8f3umHUBnBef0RN19Iig5VYTYv7UDg7sXJjUYIPFlfMDkh3YOubYoBqNwhEo4WrDMrt0Ba1gYXOo7KKKR5YN/q8mcB7D72DgAdGN1KZp9PyDUUFYgrN6iTvRxwLl3p2hqoq867PTTZMEW4oryIXDZXzMicVSFEfAQqwZwMcUIFOZ7W3G6EXubtz0JwHzQsgjR+5c7mGvQCNLEJ4XW46lQTmS17kWZ3WJpDxWxHtsIPdHiHgq2Mk+b0c6MnUCAE/s2eWDy9tM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199015)(66556008)(66946007)(41300700001)(186003)(86362001)(44832011)(4326008)(8676002)(4744005)(316002)(6636002)(7416002)(8936002)(66476007)(6486002)(6862004)(6666004)(5660300002)(6506007)(53546011)(478600001)(26005)(6512007)(33716001)(9686003)(38100700002)(2906002)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9KzmR7YcHqDmH99IAP7yfdBmYRT4BE5NFkGxqy4NJmX4fCs4+2Wl7L1z/rsB?=
 =?us-ascii?Q?Th8oMPyOfSSIGCJP8Wtsnn2sBUxvLjrOfY6VF6SVpwA9CeHsdOpltXyq5+Ck?=
 =?us-ascii?Q?5L3Af6CwrEwcU4qUce+MtmmR+XpfAMhBKvKJF/5YUtsmW/O+pLPQwbPLtHpP?=
 =?us-ascii?Q?+lZ09mzKj8oJqY7fBV8GD6JrsrZznQ8y3C+XaOZzRxOuOQh8vnv7QFB2xQmY?=
 =?us-ascii?Q?MMd4JJLmKqabYaApe6NZ3eLMfUH+W0Lup+f8ip+7KQOCo41kFHm5ymCpeV/u?=
 =?us-ascii?Q?HSXFUl3HxyfjqBWs4lOUJT36JEEskPYuFdw1POI6YCqo14X8nIfxr6K+GYou?=
 =?us-ascii?Q?lz3reBadgBCiztkJ3xUR7+2BxzVxAHZX+QjwbNhMAvjYYSOQSg15l2tV1hUp?=
 =?us-ascii?Q?vJ92LZrjHQgJHYoFbUH0GjrG622i+4/lRsDiRsUoJWYdpUKR81MB6xM7ZrYA?=
 =?us-ascii?Q?FD/5RubKvjRKJyXazIWnt2BwT2w7Hl7GghOsFE19MZLH5UoSOyAsV2OmE7OC?=
 =?us-ascii?Q?kVoiP6EQaSpcJeXE4dAFYX2S42iygTZsMPmxe7ylHUD6MQd7fLzhBEwlxZ3E?=
 =?us-ascii?Q?4cGvJUlLh06AgIeGHZADqzlT3PBI2U3DFxzxVCX/KnUjgE+mtuJjmtFfvcXg?=
 =?us-ascii?Q?9SBa84k2JrfErjuiKEZAN4cqOn9P7ScpPITF0O2R1L3ZddzxNf6r+THkUARH?=
 =?us-ascii?Q?UR99IRbOZh+dBIm2p4t+1wNQGsAO1ia/H3hEzPE3jzWX2/U8sEHYBl134xk0?=
 =?us-ascii?Q?tzwsm85WYeimt6zqdTBf/6YBaaztn+Rdpf29pBgzOtHwCl02Y/fiTCRUq9RV?=
 =?us-ascii?Q?vRpqGXBpqQTF2WCD1TLbR6Nuie9OSs/OqqT5gyMyoJ26TDHagChE/DFZ8aYp?=
 =?us-ascii?Q?0aUW48ygEVHltohY7OXZ5FlxbHO5UZQaCgYT+GmsQPPszL1CWxmWCqySoEdf?=
 =?us-ascii?Q?/0R8txW5J2Sp6GTNRQPBkDbjNmsJzYplYVDCMkIW5OELz6JWw/7vYlUzaTI3?=
 =?us-ascii?Q?4L0j1dWL/6f6m+UVsHcDciEjk7gOT943lM48XXaA0JbiDghH1Wgo2aycNus/?=
 =?us-ascii?Q?A3WDrsYOIbbDaiYB8QbwiubNdoXEj3c4Yh3o454UynagjYRyJP1jvOjFFLNa?=
 =?us-ascii?Q?qVpnBCtbwm1ERX4qE09OzdvpX251sFjEoykngfn4uNtnAcve87YlsKGRJSvo?=
 =?us-ascii?Q?3xdfYAYoqY1rTuGwo3vZlb5963ihDwhAUua4cGuNq80CXCieTCFQKoBs8tA7?=
 =?us-ascii?Q?drOG9GQLq18ze15NtrCFMXDrIuFzR5ckgNiv2dq/1IywSbSfPPAXhdIecriM?=
 =?us-ascii?Q?mp1R3JbfZBX5m6ND3bM5ZPOdq5EsT1nYt4m41sfGguw7hBIRG1iicUJ5wO+b?=
 =?us-ascii?Q?dg0btwqp4dAv1vFW+lDl3oBVdLo2KDa0gi1+46cChNGibmo3XunSW4DJb1K0?=
 =?us-ascii?Q?k/DHubMDmFGtk05wGaG4aHdYnrQ1AXqwOgFPjMHwTxz2ozgwt7jU6Z8pO3GX?=
 =?us-ascii?Q?T+OTDETCrg5K2hXWPAieHNzuEgeg6rf4coMLK7f3pIZEdQgPp/cjkiD5KxiD?=
 =?us-ascii?Q?s8e2To7NyOiTvN/kKzRdnou/FXntlqx6SQaolQHEfxooLEY/nD23m3P2RKmu?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64adf44a-1ae5-4aa0-5cd8-08dad88a2515
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 19:35:06.8089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8WWTNlGb5SFjoZgl5u43PWs7DaNevFi7HHc70hXKzU6RO0VmsxjmiTmNYLH+wDBwNKMkIO1DbufH15wqhd5yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070165
X-Proofpoint-ORIG-GUID: vdlxiUIXO8jqd87QlJoFXKyD9EFM2JU5
X-Proofpoint-GUID: vdlxiUIXO8jqd87QlJoFXKyD9EFM2JU5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:50, Sidhartha Kumar wrote:
> Convert prep_new_huge_page() and __prep_compound_gigantic_page() to
> folios.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 63 +++++++++++++++++++++++++---------------------------
>  1 file changed, 30 insertions(+), 33 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
