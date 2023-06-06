Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3B3724886
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbjFFQIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbjFFQIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:08:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3564172E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 09:08:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356DE5oV027051;
        Tue, 6 Jun 2023 16:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=zJQHyF4cex3hKO6tuUrZpF3OMNVwA86mDEuy1uQX4SY=;
 b=umOQ/YL7gZBl9H1J9zhfgp0QMFT1z878kfhqv9PcyfhUDNs3hTHiCQYtzW7QG+QByY70
 rvBe48sP9evYOBMh298PTR77JOlWdEN93Uq8M2kEHGCodAk2Sset2ro0iYJA8sCyfMCM
 HVeMMWlcNbWXEZE0WIOhWweM93M2bGspvpap25iUeHhDmcJx9Tr9eu03B0F30JEhsUdl
 39DmgmvlNhfF7jwBOxpF+uzkuYLDke0U2jcZNt8CU9cbgyZ4Tf/XCYJuEx2umY819cRk
 d17Ob+dC53QmWlRb9viMqACXn1SE9bwDxqveK2yS9PDWW1G51Sf1aGpOeUL6El0fkemI Uw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyxh9npj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 16:07:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356FWsXN001654;
        Tue, 6 Jun 2023 16:07:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tr0ugt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 16:07:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBHrol5qDubCMkHuhBBAU2aTwT/+5hk1rVQN18sedT4itW3XWqRW9lbN4603/xT2TYkS6Db4jg4vQx5qVFvpWDiMU1bFf/8x854J2pz40HttqW1LvZA6Fji7ZKOOpwEEQBt07qQUMN79hv86yD5lGQLSUFwPfvehvKj9ivbJ/4Rea3X1d443G9A2M4tMSgz9XfebCNMSZ5NvkJoIJnXx30BviCM3PJHAx9vpSkb7Z7sHyJnZr6zyJOB6OFH3Nmj5qZTxf3lP0wB03+Rhg1JDJaE/FoWvOjxSQGK8cddNMhsX0X86pKHT7y7fnFWtGuDZGvYymh7k4/P1KC33XNTcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJQHyF4cex3hKO6tuUrZpF3OMNVwA86mDEuy1uQX4SY=;
 b=EaIPKmTnwax8HAZBhtf/G+KtqNWFGiLTMFp0xJYXYmXho/nirr+3wagoB/I/8A/C3oMRVaFwNiWAR0RtVG1yQ8oJtHoTer/R+y9kk+TDRPYw3t97KMSCGa2PiexrdLsucwDML6BTybqnTWsGLUIF92SbS8Hs/OaRjnysuWBPNOOEL8Mt0+Yd4Q1moLcSUwulXODGhEov0++WveYdBv5FI+n/08MzG5U1EFg3HGX6+CQoAZANmSjVuDhPvPnBVDmnpAhNvksS3NqHICxeVgHuFr3uBBupMWDd1WnZ9KOR0YCY5LZ0BnImmhGJModz8dAY0fYMHE0wrFTfe4g4+D6y+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJQHyF4cex3hKO6tuUrZpF3OMNVwA86mDEuy1uQX4SY=;
 b=PSQ6cJVOvRdWe6PdD70ArmgZysdH28vnvwnvEO3TCaSb/nfKtlIbh8bH2b0KV4dxFFtHRXdU3xPu13fcpjAJl+/1dZNMjunOGWEd5R2bBpe/z+psNYI5tAqSICbmeSx9OpEGPwykXvuEiPUS6yL6kJLBGigTgxPmKGgtYDWpYuQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5404.namprd10.prod.outlook.com (2603:10b6:510:eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 16:07:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 16:07:37 +0000
Date:   Tue, 6 Jun 2023 12:07:33 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Liu, Yujie" <yujie.liu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
Message-ID: <20230606160733.3bljcadb3j2zc4ei@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Liu, Yujie" <yujie.liu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
 <fad3c833-1ab3-2d34-aa85-dcc7c40c3587@bytedance.com>
 <a9d2ab1b-23a5-8c06-9f7a-6872c726db03@intel.com>
 <b5f2d527-8887-eb0b-d3f2-4e7cd8f3c022@intel.com>
 <4fb5f66d-c8c2-f857-7461-b974154dbc2b@bytedance.com>
 <20230605140344.66pwpdg5zgb6rfa7@revolver>
 <9f4c10bb-ee7c-cd41-f1b9-c1a7a1a562fd@google.com>
 <d4d7157d-1e5b-fc7e-34de-66def46a344c@intel.com>
 <ff754a68-4f94-e818-a31f-c8a1fd11b4b5@google.com>
 <205e7eae-fb30-1464-447a-5d284417c603@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <205e7eae-fb30-1464-447a-5d284417c603@intel.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a754c50-050f-4ac5-aa1e-08db66a82508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28wIgUbCZiyZYQHQ42TfbrYDX4BdbsULaw5GbEjSDf1sxPpQiAzc9ZufCaiUmRG0xmKHCGaSzK0wPW00vkbqYnjESHb3/iGTLJj2xlFiOh1C51KS36LHXIBIPeztz7BS00Md01olbU1DufdN6USuZgJ8jwPKzUj30VvzDmqcQZ/at7KkfH0NDu6XZoa76P8Pkxz54XpddHyRWo8P8LQIKw3OVW1B+sS950AllHzgBSNUeoHACIHyM/ltyRSd/KhSIBrCdnbuJ9joNowLu8BU6qDXytIERedaD79WYrNQrJGH369xRDioS38xrq/XMv1HeQ89aWetn8nVMoZrdPbNDMvUp9JPlMgMMHLhWZ5csmc3MK5/7gqOOYqgLaRJXekzEPkbynJbmg7ZToRoeUC1yZGqP6Kdyz+bM9a5KAfLhtN4e9YzCwWGa8MjZDIbz+ZWLfB5qLCsfF+0LtqoxfDrzw2roqOJB33p2ExFZIR+02vWeg2IhAVcxCnetTtm2w77Q62wzaYvr0PpEq7pCcK/4sN6IlNORwj8ZVbN658lUV0bzHMpWDdlrmUAMCSnphXU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(186003)(6506007)(53546011)(9686003)(1076003)(6512007)(83380400001)(26005)(8936002)(8676002)(5660300002)(316002)(41300700001)(66556008)(4326008)(66476007)(6916009)(66946007)(6666004)(54906003)(478600001)(2906002)(6486002)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vkjQuk57N8ASLF/5244PuNXUr80cCRil4AClAN/LoUK+dq9hC8mzoOysmMQq?=
 =?us-ascii?Q?+KnOLM+rK9eyfzIdZbxYB00F6k1DaNtah10+G/b329LfVmKk2NlXd6n8GqKP?=
 =?us-ascii?Q?n0fvP8W4sd/5POh2rW2bgWrtPj9JX6uz6bcLyYiwTHhYCBAQgRBnoo3NhUOz?=
 =?us-ascii?Q?vMnrTizpmwN2ymn+47QQNkTCoAfSnUxa8xW/WTf/kzgEz8q+2eU+DhMEAKr3?=
 =?us-ascii?Q?cKr4TIZUEaSfa6qjBBzowgDi+zIbuluVzTFz3rf55pKx7kSuLurUo7u2Hfr3?=
 =?us-ascii?Q?pOdWXApJ4o4d2AlHqss5M7z2TVrQIWAwk2HV3cG//s2BzbcBtt6xi8SoCeQ7?=
 =?us-ascii?Q?QyBChbfD8dU1xMBDHay1zcToPDDhzref87hOSk68WQ0RdVx65vq7KWR+nTgN?=
 =?us-ascii?Q?kv8I1dI15bO6UHR332jWIIYE5a6TXMqW+jWhCon5Sy4d9+zWHGFXu7wkRZSz?=
 =?us-ascii?Q?AxoPUgq6/RAmVzqo01n1maLQ0saFeOrFZEEelkUUmsuh2rVUNtcHyGvyK9fK?=
 =?us-ascii?Q?qVap4Ilqq5aGItSTeOUMbyQxB7IIopN9TDsK/fJt9bGeu54p4icvNpmykqOj?=
 =?us-ascii?Q?r3z+HPVulYW7AYOkCmqEApbPoOLLVmdvdwvr7/JJLgZRm1hBotVysKsIJyJo?=
 =?us-ascii?Q?6TRcpHeFNfo8w/Re11i/VnJiAvdluSXTyxOI7snpk7dtJ8XBnI4c44envE9e?=
 =?us-ascii?Q?pu+dP55gcA7yx/MSZ2UxhJihdxb8B5x/NvJky+eX4MXjNjRJ9pyCahdYtq/h?=
 =?us-ascii?Q?mCp9fD1oZXxPuy2HCbMi4BYtFtAul6EtkoRN77PMiLi9OcKTXisoK05G4aq5?=
 =?us-ascii?Q?lXIdVB41wtdvq2SJaxOmJzweBxFihNtFI84vhftU1v8xoM11DB4ar1Pgf8tt?=
 =?us-ascii?Q?IHf5dUHjWe1I5PfZWvj/AvEwEqSzehBPqXxLjI6/upwLyfotL1K7zoxUHTwO?=
 =?us-ascii?Q?j6igPeVAoxf2TW9VFYEJC5XE+Ly+F/hBILzqwvPRUZV3Ga5jPO3rIAbpdhqC?=
 =?us-ascii?Q?ZMEgcQ+oFH/y+iHivBv7zDpraEzpn+dHl9gVcVmJX0uiKuy8D6VbCdLI1D21?=
 =?us-ascii?Q?w7Um1JaXzdz6rFRJbvE17RTuscWW5rHBNb0AnjaaILNuKDoyVL8VConcxNYb?=
 =?us-ascii?Q?CDTus8W5UnQQ3zZctXJg9KquR2pVrZGRzEUylZ/zySwKGBs3/6XJ3iIrl1to?=
 =?us-ascii?Q?ZxN4735WSIMaFlo+QDzoJNYkJbDwFqiazUtyTpR/iK6zrP3xCAAQjWPQtXBf?=
 =?us-ascii?Q?ewmc78Uz6ltzXk8uw3rMP9LaNAPI5iZpYKAfJUOl0G66q5BpAnn5Pn/1hxPA?=
 =?us-ascii?Q?McEygf3Uhubgc2uuWEW7+ZkZ364UNKsTZL3MGqcex8jcCbmSgOGG2GndvKWS?=
 =?us-ascii?Q?c8cwfpnbhjguRM0K10c5SvCQ5Grmvf9hwTHklrPbz9NixANDsdk2N4ySF49x?=
 =?us-ascii?Q?gLHf5J3Liaa3QEP1+sIoeFGtm0+s9q3ZWztHIkmFEJe25ydgbMijeRythk29?=
 =?us-ascii?Q?zWlm814EUmiCZf13LalHdjQ/YjYBKaVjAYEI+sf+FweVR2JAwmJ02Ol23aKH?=
 =?us-ascii?Q?v8D4R+FjVhHPRwm1nSb3UIGaDhkhuLqo3ATzE9OuVhEBBWkMrcqZlzqnZVTr?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?drk8GCWHd9g3sVROp8zbXqWqZCdGFgsOyw4S+v6/VhgAQsI80QM7WxnD8EgQ?=
 =?us-ascii?Q?UYO2QxPckXB1YiLqK4y1ntiNckQxrEIEQNfRIcp3nLWaqJXvSuSiI/t4YRA0?=
 =?us-ascii?Q?XSpolaHIKRk2bj38UNrPYI9H5uGTzh820IeJe8E6XOPGSAbnvKWMLd5S6ADR?=
 =?us-ascii?Q?A2nG+2u2O0KquE7A5bb0WhJZI8OSgCSyEQlT7lnr4II1SHYGgBPBxIL3PJAG?=
 =?us-ascii?Q?CkmFdIZN+3PzroASdepbUY5eVUeGmRoZKtOb29/CeDmQi2jEvejdi/usjm/N?=
 =?us-ascii?Q?ZHhz6d5uc3d8PYi88Pd+8TWWmam37l+YuuRmiAZQbsgBfhiEKo4jB9eUmhHo?=
 =?us-ascii?Q?L1IGL/8SnP3y5PCkI5iVJ0kMqcP5UZuEsD8fHi4HmzFOFabHK1I7FXtXhjiy?=
 =?us-ascii?Q?O65JRW5fKy0+G+bl3uz+VJs1PPnJ/ecPdQnPPExTSvjXAlZaSvhejm57+12Y?=
 =?us-ascii?Q?WHPv0GBVk+rK7xDf1ClfQtOeOHltkc1p3BG55ErfnFox52bI9Ltlle+D8OQ1?=
 =?us-ascii?Q?klORtrSYij6pripJI5uf2PSfxMdeE7/j5HGbRaeOrGA0S/apYnVykyYbOJba?=
 =?us-ascii?Q?NWqhqllS33dvZBvhBNFiOBIRmIUuJZxilNeYBG1Mo/MM2edC/frkSegX+Fkk?=
 =?us-ascii?Q?tTSdHJXtfsyDoLm08kKoX5qGddTUz17pg0wOR2W36LpTpEDSUDskHNKvi2ZD?=
 =?us-ascii?Q?qXs6vqRqXhVY7V3GG1jz9Ul6auoU0WRXDQXNvy+iynH9p2Mna8DA6gDuIGVb?=
 =?us-ascii?Q?6tsmF5nuu66Cuzx8+cpI1q10DxQNXHaeRscMnxiSquWptWgbzhrTN8pkmWjV?=
 =?us-ascii?Q?pKHijHdARFzHRMAMiluhcOUQmcc5OxrFVQj+3jp9D2ITwUFLpemcHS0PbVZ6?=
 =?us-ascii?Q?ZvGpdO5v1frJP+bd9HednH+i1zXy6lDSm9AIyi86nCRV+c2+m7hTqYqE2pQ6?=
 =?us-ascii?Q?qtUyeQR8FyvvgekG4xvedVf/DrB0mEBkqeTOktWa+Fc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a754c50-050f-4ac5-aa1e-08db66a82508
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:07:37.5046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itXy4iNqVkXaaoRi6AhEtgR0Ym30BMQI+nrNSHmohZ4S2SKBANHH7gt5Is0LQ+clc+RgjW+/2cjVyZOevLruEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5404
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_11,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=699 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060137
X-Proofpoint-ORIG-GUID: OvNXvFar9dXLmdrSogxJds8kbvQ82RBU
X-Proofpoint-GUID: OvNXvFar9dXLmdrSogxJds8kbvQ82RBU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yin, Fengwei <fengwei.yin@intel.com> [230605 23:11]:
> 
> 
> On 6/6/2023 11:08 AM, Hugh Dickins wrote:
> > On Tue, 6 Jun 2023, Yin, Fengwei wrote:
> >> On 6/6/2023 10:41 AM, Hugh Dickins wrote:
> >>> On Mon, 5 Jun 2023, Liam R. Howlett wrote:
> >>>>
> >>>> You mean "mm: update validate_mm() to use vma iterator" here I guess.  I
> >>>> have it as a different commit id in my branch.
> >>>>
> >>>> I 'restored' some of the checking because I was able to work around not
> >>>> having the mt_dump() definition with the vma iterator.  I'm now
> >>>> wondering how wide spread CONFIG_DEBUG_VM is used and if I should not
> >>>> have added these extra checks.
> >>>
> >>> Most CONFIG_DEBUG_VM checks are quite cheap, mostly VM_BUG_ONs for
> >> Indeed. I had CONFIG_DEBUG_VM enabled and didn't see surprise perf report.
> >>
> >>
> >>> easily checked conditions.  If validate_mm() is still the kind of thing
> >>> it used to be, checking through every vma on every mmap operation, please
> >>> don't bring that into CONFIG_DEBUG_VM - it distorts performance too much,
> >>> so always used to be under a separate CONFIG_DEBUG_VM_RB instead.

Okay, I will update my patch to use CONFIG_DEBUG_VM_MAPLE_TREE for
validate_mm().

> >> So does this mean CONFIG_DEBUG_VM is allowed to be enabled for performance
> >> testing? Thanks.
> > 
> > I was going to say:
> > No, I did not mean that: I just meant that even developers not doing
> > strict performance testing still like to keep a rough eye on performance
> > changes; and historically CONFIG_DEBUG_VM has not distorted very much.
> > 
> > But then I wonder about certain distros which (wrongly or rightly) turn
> > CONFIG_DEBUG_VM on: I expect they do performance testing on their kernels.
> Fair enough. Thanks for explanation.
> 

Thanks for looking at this everyone.

Regards,
Liam
