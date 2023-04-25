Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16B46EE5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjDYQZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjDYQYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:24:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C12316F24
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:24:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFx3Yq004505;
        Tue, 25 Apr 2023 16:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=TLqMBvuvyTxNKXfHglxCzX+AFLSDE0pykfLu+fn+1f8=;
 b=0BpRjychB3m5/fISrROUKXhc4WbnF/eb81tQ2NXQCjCcuJ1AoPKVfnrU7K4G/F4fNDRF
 20BaqDZjPudHlvmhcRx9ijmQyB67CyscL9o57aJ4BsjCiNdsdRy+4BhAKW1jYxplimbv
 WaEKuZrk/S/yuCE/YqR0BL3H+02yQItb+4i1xzrK/2C7kUHbmKZ5dDLqQ1Y8jpunGgjE
 bEW+x2BbdHAUQ6xJ4h8hSNKU/Pqe+LOsYRmCZamav/CcVy8CXFmfI6nJlk87Iw38kXai
 zhOTyba7dMjAnIM9j0rvWv/eBMM4+D2rWDVWVri3QNH4QJM6g9MoUD98T7ki1sbxIDFt mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460d60kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:24:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFBpux006839;
        Tue, 25 Apr 2023 16:23:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616pxwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:23:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIkAqUG+sGuXkeCmApMcw5umoJeOvXKw3T7CRv8djXyObqHP//BHb5eYhjSnGKEz6LCqZOr3b4TKEMlU+tQFf6sU2btl67YjpUgWq6vgWaOdgUBQTTWlMY/H0ngIRA6pucXwqReLdqPEPWMxR5DFmZYxdN/mlh0TYu3qXZ/yDQbe931UpDFjkGKxvukupsgxdlEo3uSVxUMv7dsQxpdcc5/0gfOJkswbxF1sSQjTN1HtpaWMiY053Q/f0Zo9eePqUY0AgjJF7bH0371C40CiA2JRlUbW51ufWlbnP8Xz/hopWKZ+7NGiXTpnpN5CKiVTOX0YVmhVPzrfc7KSGnljkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLqMBvuvyTxNKXfHglxCzX+AFLSDE0pykfLu+fn+1f8=;
 b=KCf1FN6efMbRtAOUuBfmmR3Rn52abZu2EUIq0oosxlpervvo6lVDy5ze4wM/9xDUzexY/m5yOMP4B9Luk2mCSUmLHGfkJ3U7l8TOsCZDqq0ocrjCW636Memj5jMumfP2yTw2S/OyR7e8QyQriHqMhAEKAy5BdqURNdwLANKwIOAJioPg+PAKHzbEk+9kdshdrm2pKrC3MxSttrVBWOPT711gm2IEpthdv4vvIsNtU2JkfApLItzlPRl/3rF3PrcIJIMgTZ+kJJ2zBfGYuIcqqu8jd0lL+cW3CZ2LN/HwYZSSsA82CXIAFeGIg2xaLYX7xdbUI72nW6trIJgdsBxbmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLqMBvuvyTxNKXfHglxCzX+AFLSDE0pykfLu+fn+1f8=;
 b=g1zQuyzsuXfC40xTiRPP8Gh/LUau23LPKpv+Ku5ZjRlEkG7mK/nwNWVE1BaLgv/Ag0yXUotqua+CbbVCuiG4Nr+1wcab4cplfk2HpD8KsIxv9Z/4CAvAn3BM9P3m3/VZ5xNOQdKr1XUDsQdWX4aQXpLKElmQiue60rkBLANZnPo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6142.namprd10.prod.outlook.com (2603:10b6:930:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 16:23:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 16:23:47 +0000
Date:   Tue, 25 Apr 2023 12:23:44 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 6/9] maple_tree: Remove a confusing check
Message-ID: <20230425162344.akgvzb2x5n6zsojh@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
 <20230425110511.11680-7-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425110511.11680-7-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::33) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: ee188cda-a9e7-465b-d212-08db45a97233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfMKZzJOxSiPht3yUGJ1ajF420kdYX/sO24JJISNkgJLgbbY1QWpDiiYfVhZEk06XORmgHDRB7vhEeEKUjHzyMEdNOQAoITjWSDX5VtMVxOKlz3jtGqSk8sZ7+wENE9e5nKqwysB9z8432fXvAKppkKTtTOee94QggVI79EWjd8WR1ffh/xE5aBE76a7lo0Dg/y8ERoekSDbreypRpz4IjrjtrvZbAg6o27KdTBzYYDauLDrorQrrN6FTtciubITYm0zM3OXBzCYoehedq6L6HI0PVSN+Q2vBHtJt8Jh8u5m+aPlsN4CpP+r16MimmQ4UdzySEGrzZjin1xWZ4DNYM6vsXdgdRy1hxeHJT855LzxVO8ZVaaXD5VwlPDW+uzvaa+zOlwEbwUiqHYagCowgUjZbSDPc5KUuiq+Hk5aesX9MhKYdlTW/ptUA52DMXOLA/TQyK9h78V8TSiIhm4C8Kt+R0/2La3jidif5wjnA2JU3L19sGUWtTaYEebmI4lVWJbxE8TFWzux+4RJW6Xy7i7c8DK/CNRDi68BlucaRLk9zJnl+jmB7W2uT0GG/RGz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(41300700001)(5660300002)(8936002)(8676002)(83380400001)(186003)(26005)(6512007)(1076003)(6506007)(9686003)(38100700002)(86362001)(6916009)(66476007)(4326008)(316002)(6486002)(66946007)(66556008)(478600001)(6666004)(2906002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?69TqQZrBTQYBnPU4WehYZjOPx5b3cf2P7cvCAFZK4vaPWkkmuyIULYFjubuU?=
 =?us-ascii?Q?GLYJYvWr3p2gEjbkLPGHMlfSuezbkfHRazJqNI64h+t6dzJpzevox4ZBOJGy?=
 =?us-ascii?Q?jqFhwGaTRhM7/wpPedhz3nbrAznmTLb7THRS+ZY0Q2L5kFnQbfAuBlmoJAX3?=
 =?us-ascii?Q?eYz77tw2+kENfVrCl2QHc5M6wvl60f3DONR6t6L7ohOQTOJB1z4OYM86rHIi?=
 =?us-ascii?Q?0fb7psnZShgzqyeq+gQw26+kebIPY9xRcUzS7fA1YRrr+F9OmlRcHZFYmjOj?=
 =?us-ascii?Q?BGMDQ2lrUFB9oIz4EMaOnzq49APrc4r9TKZR84v9SqnFTUcRaCognw3tZpyk?=
 =?us-ascii?Q?6bw6Gi5xB3o4/wyIizsNt3Tnj1vVHukiYkYXPodzCEG0zNtbdksfqjwlNLrJ?=
 =?us-ascii?Q?mlhSNHoxZKWglfYHsHJURZ7Znqtt4WeE1HaZdEQYj6CrTftZRAj/pruHaiXl?=
 =?us-ascii?Q?4GGed1eXMudHjQsQQWdsgtqUiDdMGTg5nghI/aqDG0Ad+I5XOR7yHGHFY68T?=
 =?us-ascii?Q?7XcSXu7kKn2tF4ateRPEkcNdfexR4V8kHBEVhF3+G/WIT8Qm17kYAjr2k/oc?=
 =?us-ascii?Q?t0FOqG63gmStiWIXI+p/0bW4uziE4lRikdGJ6AQuUO27BmrDp6SI6N9nNa1f?=
 =?us-ascii?Q?zImLNrisF8LS1q+ec9r34TEDurld1a4hY3eNQZDlmtGPwUeS+fzLY8gBLshR?=
 =?us-ascii?Q?9ab1MGVX21wgJJo7ygEv8CWuUPISx3EcUbN9wjg1aOu9oTLdkhbhdiV9z8dh?=
 =?us-ascii?Q?jSNnUg/l+42gXht5WCbwV7PsdSKQKxeQ/VhJoecRUb63rYItqeuljcxtdX7k?=
 =?us-ascii?Q?HuLiXr1d0MaDsmQYQt04dBQJ/H452InSMDi9/PBgr19g1PdGRknj4lVpc0k1?=
 =?us-ascii?Q?cY/R1y5ocn70ROqxHoR65CA5I29SqwZu/gMHczQdPPRLqdtAVbYrs4O8/hWL?=
 =?us-ascii?Q?Pp42ngNqPtDoGTRN3HBbDId1Y1D/QOcN7RSlGvGTQ6xVwZiK8A54jsOnaanJ?=
 =?us-ascii?Q?E6qczbPlhpo8wJIS7JQXfm4zQjUFJNfpnY/8gB3OHIxFgO9HJ62tG69RXErR?=
 =?us-ascii?Q?YnWxY4xZuitPAf1rR+hE9fgzyGtJvsocG4gf78P20yjUYdE8+o+O3XAaeG+E?=
 =?us-ascii?Q?lmKwJjnfRkoj3ud7mHME2QG0PMnv4HHYY8rg+Ip4VyH6XYWWD+AyUdMFY8bj?=
 =?us-ascii?Q?2oHSwKBuW4/a0okcAzqr0+KOznF9mANySFJgN6GDS3Gc20Dm8hBC3lNwGY1N?=
 =?us-ascii?Q?NELgRtuagaa++B4kOOQpTTSnibxt2BVbMJXJBg8n/W86Aspv/Z65o2J3G4p+?=
 =?us-ascii?Q?Hf3yn7dsTmt5TAoYeLRm9xfKT8zW9vGVcxsZCBg/4G9f5xImGH+qeolk3LeU?=
 =?us-ascii?Q?GpqqHPOxf/6K4lJRv7SV5989hNBncCYcfT07iYkItqUivoV5g82G/ROkoQtb?=
 =?us-ascii?Q?tDfi00n4GliXmhF4yu36826W02ucv5PcDetOoeH0pW4z0BppOJC6VlXJ2/pN?=
 =?us-ascii?Q?oWttWyk51smy08lMjH+jdgNrl7BS63ZKX0iWh80PkhDoKSMDLi/wkGPEkzfK?=
 =?us-ascii?Q?NdOIjku6O1k9xXc3KycmPNxiLiB/WUiCWAGzpqIGqif6NAMUabELqqStMEDV?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?7AKCj9LAhIfW5ADDYzwbDpMDSh39lig5VQePIosNQjVGy5qBzgN+epkbfMEM?=
 =?us-ascii?Q?goGH27g5T6dg+zG+3aFouQOXhr0JTISUziW4Am5OJAt8D0M8pQTkYOb8/8Kp?=
 =?us-ascii?Q?9+XeT/EAn/S5TbFN1iApLcg86D0Q9Hz7Z2A05xSkcnrCcXEJxnAznnq/UUFK?=
 =?us-ascii?Q?O88FDrJ9LYDIJ1I8zb3ST/1wiq3i4QXdEzjsyie/OKCearfodLbOn1l4kzXv?=
 =?us-ascii?Q?dbDK33PB5I89QsSk5/vvmFICSR0StxQPFbJXxtuGpFCWQQ23//QCQLDCpti+?=
 =?us-ascii?Q?8Su2pL+S5vBp48KAqNbSLaCYVclUdI7K34rW3z2twM3suygZC1FDvrUFaHFQ?=
 =?us-ascii?Q?vIm90/ek4VOi2SRZ8VcGCDy4lOeGXzj+SQ9mRrLZmLPAorj+qzsC7LZWuK/j?=
 =?us-ascii?Q?mcjuu/DxqAe2ZC6Vl88/tCx/AT38jVJgFtn0QoykzDxh2/GHq+NUWws3+uqb?=
 =?us-ascii?Q?dLynGmj3Ekoi3lUzWFkykdiZU8yBqj9j/TWaOPPLcqucjqwiwl6CW9K05qCL?=
 =?us-ascii?Q?WhMvEB03auOQAjAQWSvJ6gXia2e5U5BvAPY/gjPtFq/LCacRYmW+vojcpA3n?=
 =?us-ascii?Q?S/wSOm0KaXtN3nRj4tzezuPPdjS8zwkmMWWEeDoz9dhdADW8nmn4GviXaI3U?=
 =?us-ascii?Q?AdpDmboyTS1r6JB32WDBNQ1aWDWViwFTEgrORvz7cQxdo5xY0txYvUahVlRn?=
 =?us-ascii?Q?C9u9mw7mLARy9IGYh3SdLFqYcTK8mLEOvpNrK+wK2leDffZS4bWwpsQru0MK?=
 =?us-ascii?Q?e0m0Iw20ZIQuozXoMlpNGCncxRHquMTu4gLBZdvnd7+0gq7RE3Lefr6wlfLN?=
 =?us-ascii?Q?FIIyGMctUOePSHcfgezOVmVkgEBVZIEFSc1m5AamO/8N8GranyOxBg3pYTkU?=
 =?us-ascii?Q?nJjP7nSX9L6YTbtnWpwsReMNWZ7p1Jk/U+1fgsrPfqeJ1iQqHpUD5R2bomo2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee188cda-a9e7-465b-d212-08db45a97233
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 16:23:47.3383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmzPlHSFgP8ONPnvzFwb4ck+RGSHqENkXpKsCzz2w0+N9EN6lT91zCiMKXqggh2BYtLf4c/LiPlf1ApkYt/2/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_07,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=632
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250148
X-Proofpoint-GUID: SGOjbf50SyjhMe5SwlwoiALXLUrC_NkH
X-Proofpoint-ORIG-GUID: SGOjbf50SyjhMe5SwlwoiALXLUrC_NkH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230425 07:05]:
> After this loop, we are at the last slot of a node. Our purpose is to
> find an entry that is not NULL, but the pivot is checked here, delete
> it, and change to mas_logical_pivot() to get the pivot. Finally, only
> check whether the entry is NULL.
> 
> Why is this confusing? If the pivot is equal to 0, but if the entry is
> not NULL at this time, it will return NULL because of the pivot, but it
> should not do this, the entry is valid.

Please avoid titles that don't say much at all.. and it's borderline
insulting. I could go into the reasons this was written this way, but
that would be a waste of time.. which is another reason to focus on what
you did in your commit message.

I've removed this function entirely in my patch set, so this isn't
needed.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 7f4b2ce84ce61..83441ef2e1f57 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4742,17 +4742,13 @@ static inline void *mas_next_nentry(struct ma_state *mas,
>  		return NULL;
>  	}
>  
> -	pivot = mas_safe_pivot(mas, pivots, mas->offset, type);
> +	pivot = mas_logical_pivot(mas, pivots, mas->offset, type);
>  	entry = mas_slot(mas, slots, mas->offset);
>  	if (ma_dead_node(node))
>  		return NULL;
>  
> -	if (!pivot)
> -		return NULL;
> -
>  	if (!entry)
>  		return NULL;
> -
>  found:
>  	mas->last = pivot;
>  	return entry;
> -- 
> 2.20.1
> 
