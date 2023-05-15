Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86D6703886
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244331AbjEORc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbjEORci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:32:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207E765A9
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:29:59 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGnnN9010977;
        Mon, 15 May 2023 17:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=lNeXrc4wj1+/doMJhXv61rjOebEcalVx5B4eWqAVzpw=;
 b=C93FLYwbhpe5Ygk714+81KGCdtgPSE95yB+GZyAugdij4G26B/BpkcQhCKWh8gEt+CfT
 /PxXNShso2rxwEbV/m0IGXAyRjKXk2xEDFZpamOQa8ynTFnWWVKYYVpXL6elG+G/yuGA
 u/UOXMzr5FV2PqeSsJcK+3iN4nEPBu66fsOwl8eBH/bFf7d+tJpGrWhYqRqH5cEqI0ft
 vVqX1GhYfv56SctNadAqdnQZALrbgj/gKNkqZJPSoLx411BmyKJiVOHz9YHRwHpPCMdM
 YVi5QbRsVqK1F+pV8maq90zSMFJJH7dhNVO0Ax4/d0J9fzPqyWKbKvE1E1pMCZvPKBWM 0Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc0n6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:29:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGfIhF023035;
        Mon, 15 May 2023 17:29:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj102qd65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:29:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJdrQlt9ExVlO3+ivUhneziyGh/EUcRNuipFWlD/O+0JrNiEl6wnTFpPU/cxM4Y1VBlUrCJ3VwPSFjBujr6l5lHaUqJ7+aSs/o+r1QSY2/Lrta5NKaqypcIXzb15Svjps1tsYQJqyVySJfVHiFkoBd5d1lbvi7r9HJ/jZyM+kfx1WRDej+7/o15OrU6F8tuq3Z/gFcGy+Q6YX9en7uoQAWB8LuWN4KcXb+e6zB6HtJHNI2GiquPveY69QLUJQTRAJv44YeowGZZTQG3BCLT6j1osi/SyjgrXQKMPwfLeWr/McqHw/4b6udvNwIJ1dtF4t/Ou08/3SPZDszJqQum8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNeXrc4wj1+/doMJhXv61rjOebEcalVx5B4eWqAVzpw=;
 b=Dl14fbELaMS1pO6UBVWl1njiFKmIExQG38PufLGuhHpuzosADvjOJmUpKYtsOfWJ73ny4Wnob9HHDQILqAciJIdyVb1B1WhqMuNUKik+q2quCSLFCkLV3UJfSUxqgymG2Ocae1dVTQFqGX/ur3Xk0WaQHLU2Y4EBX8vMJ8x3oyPnZAieRTjFqtmnEfQc8azvK/qtZM/8vyy7yXEUle5dzO+1n7RGhDWnnt2JjevTe1U67HU3Yfa5rKSl6sCSjzvKzZ2rV79RCHW/MN41a62pVredBLe/jD2DeM7sduWewwzli7uazn6ohtFx4iFocSTpg9/R8jLButgHrfi/b4W1fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNeXrc4wj1+/doMJhXv61rjOebEcalVx5B4eWqAVzpw=;
 b=Y+69qSrckzPwhC1ql6ec6JKE7Z4Bw+1Luj4gYIT3gnANDjSz6F9wJTcSi3168OZsmjfAz3sPx8DjGJ/Igp6d9Oh1jffVqtPx1GjEsm/eWK9fOqrZ3G8oi+3wKRxt43nAgxA3ojZER3GuItxjg6QARJbTgDaXlXopjQ7XQn2MQO0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ2PR10MB7810.namprd10.prod.outlook.com (2603:10b6:a03:578::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 17:29:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 17:29:21 +0000
Date:   Mon, 15 May 2023 13:29:19 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 08/10] maple_tree: Add comments and some minor cleanups
 to mas_wr_append()
Message-ID: <20230515172919.47rkp77cbtwy7pvn@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-9-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515131757.60035-9-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0436.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ2PR10MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb4ee73-09c6-43ba-2713-08db5569ebb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1x+9vUe5623STopO/G9JzAn0+PjRynaqHgI6fs5tF/VPKLY6dO1J+WwsgDk8gy65FcWulOt8z5C2N85mn3Xf8pHM7YHjQIZ2MVvrQpvNQdj170NMNfKXuvTQiuTThPoIjrttoPsOXzybfRN+qSox8hyobqXDo4k1Qb+WWxeQUlw8zpMPmJiRoQfu+vLyteXMo40bsc2oJnewGQZteTLqLXMqPvIrZMZ6pJdB7WCgMgz566QPTdg6oeYFpL0p8t1c9ava8lKc0ZWseXu+UJGrJjLKus0CsmHrX9Ol1kG9NEmnZAT7s35OWy36WyD+pCMcNgf1iaks8g7zEVaPervH4jH+o77v7GuSZpwoASPxxw9czKhuSACuGfTMPDoN9l8f867QrITJeIi6hPckUy+6JkZz25nZ/eBlKvwsWOwxw2Ua24fNNbisN6+PSNYO3s2CkHhrP1hYTmmIDPoIKWRKYLfQL/8x1OkdN0E3ltPxhYUdcV6maUjD+X9Ol12oB3AjjVhezUQrqS9/SP05/Jb6z7OG8fKQwTNcPQ7snxyHdt4yjW8TeKE2ZFlfkaihXfmx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(83380400001)(5660300002)(33716001)(8936002)(8676002)(316002)(86362001)(2906002)(186003)(1076003)(6506007)(6512007)(9686003)(478600001)(26005)(38100700002)(6916009)(66476007)(66556008)(66946007)(41300700001)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UM9NuCCa+PqGIYScmLd7Z1zXxkZ/BHn28FW/Tjt5cPEGJfUeaTrzULPtPbEH?=
 =?us-ascii?Q?dylzdsTF10mPBkJECf9LKaiczDYpf3tbpt4lt1Tqn8n7mgiHHmTBQSKY2loI?=
 =?us-ascii?Q?CKE+ipNrg9j9Zvg/FH5OwDrWMNGavZik0RTSlemdPDTsG8GzObqpu0OE92Ia?=
 =?us-ascii?Q?WMzBZ7TIu6cOsrdX9EBfle92ZCrsD8JWYfG2INNrifqk90wON8MRKqEE2P2E?=
 =?us-ascii?Q?JZsFke4uKEAlIhzBkW/p7CPMD2nirC1C4pTwXbDikgaJJ9WXMZCo8rPkMWbq?=
 =?us-ascii?Q?nRNd0TVyr3n5AbudbRnXqdiTePDDA9mGPxQltQHgBBI0i7DMkWkAsNPra3io?=
 =?us-ascii?Q?gkpqI6m1ZjzBKE1Fi8oxQbuLJqyW7hRef9S52tMJz/9Q3GeysovOkssi0nqJ?=
 =?us-ascii?Q?Tls8gqn1jkiKryiSKWAC/U3/1vCI7rETC4Zlh8trsi82MApJq+kEDmmurrwS?=
 =?us-ascii?Q?zBdAm5jY9wiZ3GmQV24MDOHD9lB2xFZkTE6BBiV4u3kurDo32C/9Um72LMSz?=
 =?us-ascii?Q?fYHucDhu5+SRj1kK6QhSdONdMMMxw5Ee0KY+GTorL9dDuLSegrImV4OiOfS0?=
 =?us-ascii?Q?pxAlbuIwz0P/oNjTwQJQ/EyisqkzP3BJF5MvqvABUJYCjcZAbWSeP2p1og6e?=
 =?us-ascii?Q?BZwY6sT8IRin3XbV/ipEy8ln3F5EzB4/H0p98P2uxh/2k9UvuCQnB85sNcev?=
 =?us-ascii?Q?i0ugqgK0FskMAQyBxEk5FFyVOqminxSdHJTzld2dhy2QOM5RaHkvr9hdsazd?=
 =?us-ascii?Q?I7nLQBWyGS2XhtnYxC71BceSd1IUCX3q7kSWp4t6oVo1tpGsh+PdqlEMNjti?=
 =?us-ascii?Q?fvnc9pR2wdkYsN3ZFREYEsHFkFUj/MU/Y7+5AIH2rldW47MveBGRlZNjZtlm?=
 =?us-ascii?Q?E0yXCTL2AgZcGN0iZehRHRtiHwNxRpQVDM0/sUmwXY45k0OXIytBio0WLw3B?=
 =?us-ascii?Q?C2RwUbJTyOCD6jLlXQAPaf54V0WSR2SBAm+lm0frd6QnXYrA+x2IpOFhgGwA?=
 =?us-ascii?Q?6fDTdj7izfCttJSgavpp2lNLKt0olxEAZDndqzjWldPClr5QSzutfss+JNKq?=
 =?us-ascii?Q?WGMp1nO/80VOUi+ZNSzlAMhnXKHRQqRVS9AhCkUV1378UAB5iAH1yIquqJOK?=
 =?us-ascii?Q?YAnmMpIs2hWvJSAK84EUO8CYXYN8zCPvLOHONTHatdx3eUYkYlp00I33i58x?=
 =?us-ascii?Q?EOJ7aWWdC7yHTSUiSQUVc8u5eqvpL7YbimDzKtlh/hHHPZN13PqGTh35Cze5?=
 =?us-ascii?Q?eDu9KmdqK0EcNj+rwwa0p2VvTIe7AZyIFQVjuY1OwN3o1AcDBm0uBkTVYAMd?=
 =?us-ascii?Q?b9kkqHxi0pVyLJCPcBt6QTIGkaCLNrznZ9KrHK5M3qv3waNe7zm4xIwPORlc?=
 =?us-ascii?Q?QcOyv52bA7kNJ+gJmVXwf1I/Mznb/vXQjDgSa+4/cmaMb5ecyBaEc3dpkdho?=
 =?us-ascii?Q?YiIzDWrpXkp+flxDXNY6o/F6K3wGKFHg8HuEwYs2Jth0yzmFgKDaCD+L8TeS?=
 =?us-ascii?Q?im3379qts9lJzRSMu0riNxUXv0R8MuTbWchSVSKMOb3aymPMyWy7wKiGbt8n?=
 =?us-ascii?Q?F+7Py74s10yyKE5yGBUczewjkQFBtynA7XDxqrz1Uplgwq50Xa6tNss9O1bj?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YZwKB3SV1WeCVq1/Fmx01Nm24rBESLj1YhGXTq5f4wGYhyeFbh0S6OUzaUBY?=
 =?us-ascii?Q?ha0YGc70cP2q6R9GzRSYOM4+iZP+Wv40TuZphLoOC6dp5+ESVOeKZYnWg9Ud?=
 =?us-ascii?Q?DqxVC28GkMB5vqSc2QQFfr9H6s7BKgWa3wR/+vE+3PyfsJOpdR8fawBi8fQH?=
 =?us-ascii?Q?XS0lMcXE1tzr7fk5ZhEfE0XpY9J4Q27d4GyjyyzA1KkRGAnlQwdxmD98qIPV?=
 =?us-ascii?Q?Cs9VOM8wYWFDscblpb//CwfLgxuaDOOHUNTfqTofu4T9snBqXOKjqp6qBOFa?=
 =?us-ascii?Q?OPDg5ut+qgXU5lHLNW3w99Ui8feTr3e2aNv6sxQL/L4wdbZ9JWSc0RZy6CfG?=
 =?us-ascii?Q?6sXg8KEhl8UzS2wlDQwgXN1mKHPjnx8CwHW/AwvM1/ke/DNJfrsrv2rT7L20?=
 =?us-ascii?Q?WXPRGayQwvM/IQHDT6IXLQ7BQZInPaa6FKdkaNKtciFzFS7PDGlcByUdpESO?=
 =?us-ascii?Q?irVkZvXoR+eknv+boKmD95VVUo4OITKxsar6e61khFk2Sk2iHtfPLv3mo/e4?=
 =?us-ascii?Q?/PTe6rp4R1ELeXbf81WvdMlupI+IQfBg/m5h3LHkYcdg/nx/8Kqv7yCVCdw7?=
 =?us-ascii?Q?cmuYOW1IHxrI0Jjiy4UFWwS3lKcOM0HpUquALNUIeGrBvdNUkyqF14dxHuta?=
 =?us-ascii?Q?zSv+RC8j0rBn+ozv+eJFvWEZStiKoP90X8sfbt1/ox+n5Lk1Hr35pkXU87bQ?=
 =?us-ascii?Q?7Nv3osro/HCjKFeGdonHHf8soGd2Utp9gavprRx+mFPGfQ0z7dGp6RXPcDeJ?=
 =?us-ascii?Q?3gPY/z2f55G/NpzUzG8x3ZI1SGmCcsdAA+yVPKBOsw7ic1GS1l+pJVd/puWL?=
 =?us-ascii?Q?zH7I7ajRq8GqSEIq2gzmjPo96aT5SeSNT+0CugB5RwT9wLZUhFV5//+LiGPW?=
 =?us-ascii?Q?4lYwqPhDdjnTLTmv9VUjE7uKz3B7fUFgns0NWQFZQADo/YI1I6horsgNebkV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb4ee73-09c6-43ba-2713-08db5569ebb1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 17:29:21.8639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWE7qnO5/mF522YGdng9YUehwzPjJVTBr6Aq5nNAS4oIVq7be2/YxFeTp1iKl28OEI9Ivv9LIT4QEDQCgngFFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=839
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150147
X-Proofpoint-ORIG-GUID: DpI-OhVwvEwvQPF3NRjWM0QgD3b-Fo7v
X-Proofpoint-GUID: DpI-OhVwvEwvQPF3NRjWM0QgD3b-Fo7v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
> Add comment for mas_wr_append(), move mas_update_gap() into
> mas_wr_append(), and other cleanups to make mas_wr_modify() cleaner.

Sorry, no.

I won't accept cases in the comments and referencing it in the code.
I'm not making any vma_adjust() or vma_merge()-like comment blocks.

Please change Case 1/2 to "Append to start of range"/"Append to end of
range"

This path leads to chaos.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 52 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 20082ef8c396c..538e49feafbe4 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4315,6 +4315,31 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
>  	return new_end;
>  }
>  
> +/*
> + * mas_wr_append: Attempt to append
> + * @wr_mas: the maple write state
> + *
> + * Return: True if appended, false otherwise
> + *
> + * Case 1:
> + *                       r_min   r_max/end_piv
> + *                 +-------+-------+
> + * original range: |       |offset |
> + *                 +-------+-------+
> + *                             +---+
> + *      overwrite:             |   |
> + *                             +---+
> + *                           index last
> + * Case 2:
> + *                       r_min   r_max/end_piv
> + *                 +-------+-------+
> + * original range: |       |offset |
> + *                 +-------+-------+
> + *                         +---+
> + *      overwrite:         |   |
> + *                         +---+
> + *                       index last
> + */
>  static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  {
>  	unsigned char end = wr_mas->node_end;
> @@ -4322,7 +4347,11 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  	struct ma_state *mas = wr_mas->mas;
>  	unsigned char node_pivots = mt_pivots[wr_mas->type];
>  
> +	if (!(mas->offset == wr_mas->node_end))
> +		return false;
> +
>  	if ((mas->index != wr_mas->r_min) && (mas->last == wr_mas->r_max)) {
> +		/* Case 1 */
>  		if (new_end < node_pivots)
>  			wr_mas->pivots[new_end] = wr_mas->pivots[end];
>  
> @@ -4330,13 +4359,10 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  			ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
>  
>  		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->entry);
> -		mas->offset = new_end;
>  		wr_mas->pivots[end] = mas->index - 1;
> -
> -		return true;
> -	}
> -
> -	if ((mas->index == wr_mas->r_min) && (mas->last < wr_mas->r_max)) {
> +		mas->offset = new_end;
> +	} else if ((mas->index == wr_mas->r_min) && (mas->last < wr_mas->r_max)) {
> +		/* Case 2 */
>  		if (new_end < node_pivots)
>  			wr_mas->pivots[new_end] = wr_mas->pivots[end];
>  
> @@ -4346,10 +4372,13 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  
>  		wr_mas->pivots[end] = mas->last;
>  		rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
> -		return true;
> +	} else {
> +		return false;
>  	}
>  
> -	return false;
> +	if (!wr_mas->content || !wr_mas->entry)
> +		mas_update_gap(mas);
> +	return  true;
>  }
>  
>  /*
> @@ -4385,12 +4414,9 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  	if (new_end >= mt_slots[wr_mas->type])
>  		goto slow_path;
>  
> -	if (wr_mas->entry && (wr_mas->node_end < mt_slots[wr_mas->type] - 1) &&
> -	    (mas->offset == wr_mas->node_end) && mas_wr_append(wr_mas)) {
> -		if (!wr_mas->content || !wr_mas->entry)
> -			mas_update_gap(mas);
> +	/* Attempt to append */
> +	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
>  		return;
> -	}
>  
>  	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
>  		return;
> -- 
> 2.20.1
> 
