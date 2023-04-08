Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B226DB898
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 05:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDHDXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 23:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjDHDXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 23:23:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23872D50B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 20:22:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3383L2MI018534;
        Sat, 8 Apr 2023 03:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=PA1N0IwIWiYWlLPSS747FJn/OyOPqNDAWsPl11cr8VQ=;
 b=LOntxK4LzDeo6lJHEpZvGgslgNGjZ9GQ3l8Q70Eskgmwr5wLsymITUniV2A7YV9dk1eg
 g0RsdcG3WyrTZ6U1AgWC+WHEiXNY2gCQ6VsN0jajPJdHraWkvh9px8b8TvctDXWf/46a
 T1Foj+O5CokSfaaGX+KwFvie449xRowW9d1XgSS2FUvi4lpomeRuj9pP9sHCpdSqYwy3
 +cCVXBk1en7/SFwfqNlzdC0rXRhvWnPSdz+fMnGzR3gHljq/tevewfNzbvdUp31hKxKH
 L3RQudeMck+cMLoVJ6HYBHhAlFGQM6sWC6D9MEFOiBkziuqi9cGug7nPUaTeWKysPQy0 2g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ptxv1g1wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Apr 2023 03:22:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3383IbSv023945;
        Sat, 8 Apr 2023 03:22:15 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ptxq1u1uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Apr 2023 03:22:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=na1Xo8ELjUzK7QXNzBKmP7HKKiWG2cxEZslApgZ6f3kJk7gWSPv5YRaCoK8S4WwZrSNNHhlrpiAs1I1MDOvDH3XCGOum4sfJ3QOyseLlljxui6bF1IUxSm1fiUpV+0MkTsItRBoSQ/hqQgnNoNDfxkl+FdCsv2GIetEmANFU5Y0K5GqXzl5M2UykwgTxVCZWPZDmsxKgd5zSZa0ulWE4eIe1e8Pnz5pLNSMUz6Txd5qg0V6gBj9Wpy9t64ck9R638PqukRBpHMce/QDDqQz+dEb4wojwBUzD2EvxtrHg0czv8TmHvhMqCUEYrNu0kEDnZhoAB+PYao76eXAUvEId1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PA1N0IwIWiYWlLPSS747FJn/OyOPqNDAWsPl11cr8VQ=;
 b=T9JIZgN3NCy86AFFbAp4hgRmLCClF36Oc1R9zSUWYhPDfmKUIYodCZHCMcBYdoPjOi1YPFgvcFUItiQ8Y0KQVEMNwQXQwmwGLFxPBava2gzD/80AnZ62XdBZdPTlXkepXC7LBgXHk6h3bPp1ZLDKdQxqEBhMT1s6aKrgAaRAs/yKqBTQeIL3iP3PFETZCvjNKCUj4TdLR1Gf50PdwI5l83qI5v3RiHG20amstFpLWA88givp0Ap/xqOaAifYOu6lOBLEv7aap8pGJojl2wCVxIqLgHeF1+LfSwGYNwfMpxm1MP8CHOTp0B1BNGUudVd5SzakV07vWSJCLZaq/ruluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA1N0IwIWiYWlLPSS747FJn/OyOPqNDAWsPl11cr8VQ=;
 b=BPFs8y5yhdIEFQ66eOB4pHsY7wzhBskIDxeidneLnJX8/xSwdO/N8zLZRzFI9LlEMuisLrT1+2pGIGXz/PET41wFJMp7M559lXa5VmIWka8ZWElqhV4BAz3Zuszi6R54FXBHv6OHTME/12iBYf31E2jX9ZVKVxX1zgLTXF1nA+Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA3PR10MB7093.namprd10.prod.outlook.com (2603:10b6:806:304::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Sat, 8 Apr
 2023 03:22:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6254.035; Sat, 8 Apr 2023
 03:22:12 +0000
Date:   Fri, 7 Apr 2023 23:22:09 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/2] maple_tree: Add a test case to check maple_alloc
Message-ID: <20230408032209.iiwr4s7htndudw3h@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230407040718.99064-1-zhangpeng.00@bytedance.com>
 <20230408031657.66fglyhaqds3unya@revolver>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408031657.66fglyhaqds3unya@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA3PR10MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd99180-d7dd-47f3-ddc7-08db37e071d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfowUFpFYfNoHEO6SMruADtafgNkVNRw0WGhGKDe95Dv+K1/CAO0Dt54ikdtc5ZGnJNFoZCWcNp89+eu4/XXhp7hqn212OBakXT8KPQtUL9yQ94Z/NNwh1m5MxJrT60BUO8M1hRlHBoq0sRU+MpXiPDyDVKGq5ZlcO9CAYhXDVjjdhZw9nIyIhuX8u60qwTPwryZ6Fk20AlpJby9N0NzXPJN8TBdGhtjHQtcJmoWL+EduUu9CRitLzZ/4vtbEOuW1c1kScK7uz/QToscCKBmIYdT0q2r86887YLOGhpamFqzTBVXSxKIHW3/2o3gBwF5uJg/f0e/Q1634SZSU5UzB8KMlMjByxhabYyK978CetVUmlko/P4SQiP4RwBnWkChUmjGE541xMZfSNWx0Vb92G2SAPjkbo4uUWfYiCufAc1q1TBvPHjZNf2PSbE3B4fXmSFNP5KK68ozqoTltUsIdoMAxfPJIcGHTw5fLxkOJv60BsqN1vMhYnPFPbncRS4rFpyghDmh091sqQwkg5x2CiK9gA//L3pfVBhL0aIG4PzdtrpqGXKNU3deRufjpCdh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(33716001)(6512007)(1076003)(6506007)(26005)(9686003)(83380400001)(86362001)(2906002)(186003)(5660300002)(6486002)(38100700002)(478600001)(8676002)(8936002)(6666004)(316002)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z+pcm2IR+SWG/G+NIdI/2SebxHZpNZGjiKsOIlnDfB10fX9ffcDVG63ABIBb?=
 =?us-ascii?Q?kFK1yv9FPw1rdjzKhT+X8ke6iawsJBvxeAslf//JyUtAfGAGK6hnPJPsVcRs?=
 =?us-ascii?Q?/RXVnAKusMTS2zfjgN19Q0zp3MY0wHAkafKl/ffszaEFZUdl4TlPoalqoFO4?=
 =?us-ascii?Q?Vx2+JIEsYhvi9C2uRxWjgDh9KS1Qn3ZhQEFvbPnutX4CO37UOVY1/k1b0n2Q?=
 =?us-ascii?Q?RkokxJB/e78ID+MI0MeAMQM7sECT40fzihyQwu3J0YXzIylq6y/i4BK4sEQG?=
 =?us-ascii?Q?S/ecB3uuyA6x1yTruU1lndiPEa1i/D8pvS+KCXqE8E8k6H59G/xKXlz1drTe?=
 =?us-ascii?Q?ZJqh5qenFupL9XgCkQL9Tk+TkPl6N3bj+BzLND9xCQqXHQXs9zw/4XnjYjdd?=
 =?us-ascii?Q?UEJSKL9WG0GvIO31AGVXkI25PFpWn/uN5lcvnDdNCj2nlI/lBWHkuLx4bIRR?=
 =?us-ascii?Q?PdogPkfz5L9JvGgIENLifDk3OM8WinL3DMulALfSi3Yjhte+YT2CLSLwAajx?=
 =?us-ascii?Q?of8UdmlOzPfjCiK8V+dGCciaEJIuS1n1Ll+mgDLsYUnFie8PElop6D7IafKV?=
 =?us-ascii?Q?p7qPae1RSNV+9T5sB6xFHnlp3TO+zjiTXJo8gLjqGkM2dDjMesPHS4rWTMnI?=
 =?us-ascii?Q?RkdEeDPO9etE8My3ggqgqORGBhGLdzGAVQs+UXm+DLCXmXJSisnDRZtAm5Pw?=
 =?us-ascii?Q?KbSr+5XL/HMh7aFOvNoIMzC5L8lTWw+XgFfAviVcNeQLwMo32VGoJiGky6Rz?=
 =?us-ascii?Q?igX4a1t6cYB/whRbr2am/a6iYqKK4NZz2FI47VIMUfQo0Q9nX0mmBxC7qRbL?=
 =?us-ascii?Q?8x2lIpbGRuREYodzOSpaNMFdmZCcw0Ja1PwETwLOfYib7QOyfF6AgRCbU/io?=
 =?us-ascii?Q?EIrs+j4ICbFBxOtKMAlDgp9qNfm7W40EsMR5gOlHzs8Hsljz8sBP2lk7svBm?=
 =?us-ascii?Q?81yNaC+RAWfFB5vFLlYYD7ENmHJmzRFLpdUIRJG30iLq+Oq5VzwjO1AMA+UA?=
 =?us-ascii?Q?iKW0cndEZlh0bvXwcVHlsx6Un860mLxu89Sg6DgtXxgaK+fLJhQt06iHMfqu?=
 =?us-ascii?Q?+ZGPIqTZNeAWb+OXYiQh1bYMq2TlmJTduRxV3BDrv/8E0Yv1eo10vUpxb18S?=
 =?us-ascii?Q?ZDRk/3pxFaunXHOSwXFtfKFnqCPzuTXGWHvHvCtwIYG70KZEz05kMkCy4T6y?=
 =?us-ascii?Q?iUfTx6QZeJoRnDhJhAJVuW35f9GGEiyRfA/NgZj4RFqJGFgX60AGSY3HizXd?=
 =?us-ascii?Q?UHh+6qde00K4l9DWSdamds7p+F3/AXL9mSWEJagdPTh8Ox6qr+FBZCdaXILS?=
 =?us-ascii?Q?XU4Yr/kXHxSU2dbSwMu5zqFsdc+awy3X3oINIlrWSzt9lLVv0bIWEOOsFc7U?=
 =?us-ascii?Q?Git3ma4//1bWnSFNYqW2bWLFKNsdWNFn+PaAYyPV/YrTqth/WgxD/eAPAJAV?=
 =?us-ascii?Q?hbDUCkyoWHEXJ1Nl3+8DzqO3Fgm5/KU0XNQGkJHAorVabzqmX+8/1qDiBmB2?=
 =?us-ascii?Q?22DtaGj6GoVhc+HidQAnK2YbP1QH43zeoNIZIPUeW+mqD+2SB6+eDePzTjAK?=
 =?us-ascii?Q?+NpCqvhnCymKC9jvOuEyO8LBGWkfI2O4ZfjkoH6U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?E0fW551i36I/pp4Z5WRD8Vhw0tnRZkXrQyVzmA5uGsarUUhv0rmH4x4TTyYq?=
 =?us-ascii?Q?M3ZVVSvXsMIw5Qv3zkuax+SgqJHArorcbC+91TI6AWmVlPNCJZLYVozKCDs4?=
 =?us-ascii?Q?sxt2tyV7EC0/rX4PJCyqF2j+2YsyeO72IhXDY7Xx/VdKAKGECjsnSqE3igAJ?=
 =?us-ascii?Q?Kl1/UyqYbJsrr3RjZXVFVWttcUlxw/hQgV1mmFqVZ5azwf+CdFgQv1af/1TK?=
 =?us-ascii?Q?T3fZxuLOwcQMj6fF5oJEQu8Dci5IO0MeEop5NYxlG95j+HZXNS2o64YHsi8G?=
 =?us-ascii?Q?6Fk9gxIViToSMoXD+wIQy7NSvF1YOKw9VzYgDVs+yJ5WzoQJEl+2J395GmYo?=
 =?us-ascii?Q?32BlpS6ppszoF0olfsyqFJVEKTCeEn0pzXFJruBhrCkAxyDXgbn6liZH0YFV?=
 =?us-ascii?Q?B5Qhe7bcTWxpRsxpCKsNJgav6Q/9OvAM/Jsb/SIMa7b/cG1uMXoFqVM3jrPd?=
 =?us-ascii?Q?I13SB3L+4utEzT0EyXx0Nk9hNBAK3C9kMrW/kSkDMudsuaCwacf507WEi1d2?=
 =?us-ascii?Q?xsAClR8XdVzx/k77NCj9nxah2B/UXaRmp5VCXMtv/TvbgtLpcFDSz9iv1Mqk?=
 =?us-ascii?Q?lUEdOhH6o2Ptke671J7p5Cj5npL4Kolcuq00Bz/+AtDs0udFe8u1Qrey4h24?=
 =?us-ascii?Q?b5x9BuKcOUAx96BEkyaqBrCkGRpPWTp8jXb1i+4HRAII8sW7Vx+Jyih2AXyq?=
 =?us-ascii?Q?Uc2P86j1NyNEqJiGqssoXBuPBSpoq1pgADEBeIgDMSANVwL+HQtENfwfzT3q?=
 =?us-ascii?Q?k/1NQZXuzmL/dFulWZm19wUEkZab5bCgxSD5Y15BgYMPp13gs/ah5M9j59AK?=
 =?us-ascii?Q?ENit1uCHQz6cw5p8XHMMr/5Mo2mYWKrzU2Kney0IVeExHsmCXqPwPT8UNCPR?=
 =?us-ascii?Q?0arabqJOlQbVSArwo65mv5IY3iyiKcg4qGlqrpzGdEFKsqh/sLg31/I4PGAM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd99180-d7dd-47f3-ddc7-08db37e071d5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 03:22:12.6318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJqnLY9Oid01p8hsqyr5J8lEGRWdABPjAd89Y7GVyngpBHh/PwxjG8sbBzL+87GS41aJ2Yxhq8q0ozrsHi0Crw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_16,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304080028
X-Proofpoint-ORIG-GUID: kn7zY1CJIREkOTjCqK13p-PDFIq18kdX
X-Proofpoint-GUID: kn7zY1CJIREkOTjCqK13p-PDFIq18kdX
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230407 23:17]:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230407 00:09]:
> > Add a test case to check whether the number of maple_alloc structures is
> > actually equal to mas->alloc->total.
> 
> Please have a look at check_new_node() as there are tests there already
> and see if it covers what you are trying to test.

Sorry, sent this too fast.  I'll have a look after the holiday here.

> 
> > 
> > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > ---
> >  tools/testing/radix-tree/maple.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> > index 958ee9bdb316..26389e0dcfff 100644
> > --- a/tools/testing/radix-tree/maple.c
> > +++ b/tools/testing/radix-tree/maple.c
> > @@ -55,6 +55,28 @@ struct rcu_reader_struct {
> >  	struct rcu_test_struct2 *test;
> >  };
> >  
> > +static int get_alloc_node_count(struct ma_state *mas)
> > +{
> > +	int count = 1;
> > +	struct maple_alloc *node = mas->alloc;
> > +
> > +	if (!node || ((unsigned long)node & 0x1))
> > +		return 0;
> > +	while (node->node_count) {
> > +		count += node->node_count;
> > +		node = node->slot[0];
> > +	}
> > +	return count;
> > +}
> > +
> > +static void check_mas_alloc_node_count(struct ma_state *mas)
> > +{
> > +	mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 1, GFP_KERNEL);
> > +	mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 3, GFP_KERNEL);
> > +	MT_BUG_ON(mas->tree, get_alloc_node_count(mas) != mas->alloc->total);
> > +	mas_destroy(mas);
> > +}
> > +
> >  /*
> >   * check_new_node() - Check the creation of new nodes and error path
> >   * verification.
> > @@ -69,6 +91,8 @@ static noinline void check_new_node(struct maple_tree *mt)
> >  
> >  	MA_STATE(mas, mt, 0, 0);
> >  
> > +	check_mas_alloc_node_count(&mas);
> > +
> >  	/* Try allocating 3 nodes */
> >  	mtree_lock(mt);
> >  	mt_set_non_kernel(0);
> > -- 
> > 2.20.1
> > 
