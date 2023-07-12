Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CE074FCAF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGLBZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGLBZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:25:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F7395
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:25:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BIDB8P010914;
        Wed, 12 Jul 2023 01:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=bSf3TKKUOVwE5aF9IdVgrGpviOxP/WGzyCq30JWxIJE=;
 b=CNAUdHjA6fVtKjnVqQdX21gIplleDHRJlmC0ht3NS7J1vQLVoNKiXmqmKbSNK+X65Lan
 ZqviadfpfCmtSNUYFSb/FFj5hQr8NtJqZ2WvPCS/fweFNiL6jPfvoGtKxW4ktwPwtJGS
 9h0IaeeyO7DGqpk39x/58fVWfuVVqLN27yByVzomU8trWBQvI+ZiVdGFGfZObZbtCaJo
 HPnFALySIhQSBUPSwJ7aIaz65to+YC0+1PgjEE75fTfa9EMNgeEsxspflP24gObRYkUv
 GUcX/y36RadKLt6+2bBK/jRg9i38MsBsTzuvHa8VmKahx26CiJliXknnL5PvABUulD7F sA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrfj644ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 01:24:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36C03OCV027002;
        Wed, 12 Jul 2023 01:24:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx85ru7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 01:24:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxELt0Shp18KL60HgcvVz4mhgDlXr/QXcHCIgCKfwBGh717aO60TvEM1F+8keMuZTx3oso0rzjw2Qh+BdYtbxw4PNJzndb7CumbMA+x3Dbt3UeyGfAMfNlADrRQ+o+MNYpYnwfpX8V39ekH9tqQHQjfMjQ5hyFuomk0nujOOyxzpl0DV/a+MErr0HsiVGXQFQ9anDyd+Yii2TGuPh2FmUIrJjlAlfxvfhjqu09EyRF0C+vSEoxIiZPEKSuNMlk5Fz473Z1ZAqzeP3c5WXl3rXAkIuo5mT9PyKBTAEsdnjQlsZuv36TfZrc0p9pBgCQbQq6FcuFR3v9fh/PHLdI0pjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSf3TKKUOVwE5aF9IdVgrGpviOxP/WGzyCq30JWxIJE=;
 b=DB1p3H1zp4zJjh4CoyluiXl+Fb/UjLIDFXv8NximGkgj/l/YquO6PXtQY7NxqINP7ORRVjVAYtUGhxELFupXIL/xd6TXr90gR2I9K332QTYD22fJGpdj8aAqcR65M2ooLi5MaRXMvQqCVnRV26DpapPQHgqH3UUojgFUc41aYOTC3QwYZNjtcoUz6BzULfEQXP4McDVHwS+aHHVtIA6tr9cSLFSr7eyLKgwDi5ctv7EEsva3rex6YtOHyeG2CteZmpt5DNIMkZcQbliZ+ft8SkcnlgMG4JwOtxeFUMqsui0k7TL88gCg7dd7piOISuGUWG4bqHf/Nrv86aj0ds0Mdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSf3TKKUOVwE5aF9IdVgrGpviOxP/WGzyCq30JWxIJE=;
 b=q9mLsMoTvyDMlMEd6Neivf02lVSoka8IzyaehEeV/M1rWR1mUQHl4QGoEaltLZb1vZCEUnu8Oy1roeuMFOq8sgAwZCkGHgFYmIr7T0sJou5sfIfjlJPhmft0ahLVUDDtb8jLWJojEywFMJli0DJ9p+fTLv2G3pdalPI9xIK/BZU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB7158.namprd10.prod.outlook.com (2603:10b6:208:403::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 01:24:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 01:24:43 +0000
Date:   Tue, 11 Jul 2023 21:24:41 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 5/8] maple_tree: make mas_validate_limits() check root
 node and node limit
Message-ID: <20230712012441.bx7f32qctqc47my4@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230711035444.526-1-zhangpeng.00@bytedance.com>
 <20230711035444.526-6-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711035444.526-6-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b62ccba-d838-4fd5-e07a-08db8276c5a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrFe4gPLbVdvKLzRM1Srm/uMQHUTXJ2/eGRiTmb1dR7O0gvvmu/nDzWfUlpeaTsDhdX+/6E5Tqt+hDTuVw5jDcBYxksQQVFh+pm7HYXnNeK8mnumz+HebxU4k+Di00LbFPoRv69A2d+SvWVynFEsMHDG/K7O2OnSGvMhxh7a174blJG4uJoGF3nBEVUqEkVx11kmRSNFT4EceT6rcBeCJ0Ho2bcsoVRYQnxtYzj7T8Jk6rg9M0oP1gpTqD9ou4AOUccG8i13h0Np82buT6+n3iG7XqLsPHp5OELvAJHx+/vx5YpaNowqtSYllFUfnW4210l9vikBMD7Oe+liktcM3HnV9/TJUnHtcGuld+9olkWQ/94zpt/l8/tXggnpK2QW78IA/56ATMxFkqBOz0Z3cfWt3zeBnlAghcfNdhtjnq5oJqvh7AyQL2D5unCUT+8hcDKtTRV8CFE4ptkgfHpErBdR5dQjcoUcvUK/Ako6ByoXwd7AMkq3dJy1VlvrrR/GemDawAyZxfDgjXD2O6T3+aJ4t7pfCnEpAHOLvIr5Q46uYcbpObPE5ReL9+0tpBgB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(86362001)(186003)(83380400001)(33716001)(2906002)(5660300002)(8676002)(8936002)(6916009)(4326008)(66946007)(66556008)(66476007)(478600001)(41300700001)(316002)(6486002)(6512007)(1076003)(26005)(9686003)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzC+5eOeTFWw2pMUySeyM3nMffZ8rTZkFFSH6eeDFAPTvwgcjoN+JLd7OAL4?=
 =?us-ascii?Q?+c+fjkS9Qu0LPFzPrMrIYnqoisEsz1sYMc6+A60zqtJKeyTJZQ4dZa756TzU?=
 =?us-ascii?Q?XQZ/mQH85g+SoSFijmcHP7oJJ291HU6cA6MjIsZDMMGhiQKknuIrmsQwQOKs?=
 =?us-ascii?Q?f7NJxt2BK27ekRsunS6Bs7M1v274SHtEM0q+HBtIZQyAMp65TQ6A/oci63MB?=
 =?us-ascii?Q?Sl/1pKuFjqGA9pVxXm6E+aiTnaJZGW6bj86Y8Zu53m7cKXjbrlkn1SkINt/T?=
 =?us-ascii?Q?BnLubge4pDivanqx3v5uFT4E/j0IM4woLCCv/xhpqYz3oPzIALbwkKyInUPW?=
 =?us-ascii?Q?KJopZexMQRJgBE/f7gmdZ5b+3LN8br3aii8c0h+d+m7BGaMpWZonDKr7E9F4?=
 =?us-ascii?Q?KURqf7bBs6SouyDXEmNZ7RvrOvFvjyQrWr8hECjkkQhmIIw/HNA+ApaoQ/lx?=
 =?us-ascii?Q?qrgXAUgFF/dIHLRJnTMySub3RCPTjGhbPZr9w/EpL+9Xc6eFkBD4tZ1VaN0N?=
 =?us-ascii?Q?0WE0Hg8357AQqIB+mWsb3nzkHJ2eYwNWPJy3iBVebd0pi20HLNbEBtcIb4D8?=
 =?us-ascii?Q?brg96ewjuJTYDFnrm7ZurRnGZjmijGAOccU9K44TjA/KKCPOWU3E0nywRg37?=
 =?us-ascii?Q?EAoIYRm/cA7+p56VSgMFMspRFRXKBPkOOWFH8qID4wZEprrtvs1nL/FTVioZ?=
 =?us-ascii?Q?DKi4rCm2E4McEtxhe0bZ1aNSxyQ1dDiz6D4xuL/AHpKTqdXU0Ja7v+vUXdH9?=
 =?us-ascii?Q?R3cGtxuQcR94VUfrwWnAPHteRe+wXTtB+/YUmRKOajbokavqwPazehxvIkbV?=
 =?us-ascii?Q?yl6JsSt+rYj3J/RlBmSXHnuyHEn9xtaGninPQgIFEV69Cv0ZoaReoSQ/uumm?=
 =?us-ascii?Q?057FljNSuEhz3p0iy21/CvwEgOO6wqkU975O5Q1RVHfqMU07W6H4vD7qlWEp?=
 =?us-ascii?Q?0CS/C6BKK/Ubfb4qn6u/eGuP+J5VLPUNyiXBgjXZ+P1+nQRCuBPNIk2lVzcQ?=
 =?us-ascii?Q?FDXqTJ38wYDb66Kim0dbUL0/kuT4tfoOMKdtg5YTBz38yy+iSjq/FmLjjEHc?=
 =?us-ascii?Q?a4Rl5cEOMc345ogxRTEr7f+EgTjBmV/5mGfciEeoiO5VDjYOnq3RqtEzt3pD?=
 =?us-ascii?Q?sqEJfk9aQuHXpRP579xgdt2jZrgeJq/IiMLuZyJ1EYmVWTlDFgl7a13+k7OP?=
 =?us-ascii?Q?l0TwWi6cEPuC/7cycQ7WcXTwL7GZ7Xu8AGiq7FETXY4BdqbVY3Ke5xUrzqlh?=
 =?us-ascii?Q?aPiuChujoGgNfpntNFftVCWbXN3NWf9oZlWKwOmKTHQvdtt1hjFxvMPhqgRE?=
 =?us-ascii?Q?9ZS8Qkqw1/iHFi085JXaksgo018kxrIs6CjvWtyWt6WgxtPlG+gNtwHt0rQp?=
 =?us-ascii?Q?G4fHAewQ9jUyCh8ECEOjo8+cvY16BJKzzZ+7/2crAhltih/OySxZ79aboPnf?=
 =?us-ascii?Q?n+Ikd/WBVRml+Z+psOsg99fbUycn7l6k3gb5sKJEx/sy3/q/UF7/bsJFJltI?=
 =?us-ascii?Q?hI78SuVOuwkmUfH8QE9Y6SZke4Z/dm0JG7A/VQDFjvamVGQR0oqLZgPKanhe?=
 =?us-ascii?Q?xYrhxGreDbxELqonoDNZzI9ySfcmOM09I522sGy2wy+YDwDr/dyWdp8kTOjx?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?viMsPjI8cqlL13q50FOvAd07Sn9r6ZfXVWtcUsclINcVLblNiv9R8tuLvtvo?=
 =?us-ascii?Q?Tk7L1tDzvg34fpsXp6zBLhr4gS7+bUZnBN8oKyyIZVEHe1ixjrfHvyWfBdbk?=
 =?us-ascii?Q?qBn0/B/mv4vg/yXF9v5nLb8+qzz4ZP89+CFCMi2Ckid0mbDwWv6doqwGq9qn?=
 =?us-ascii?Q?8tk2AeTv+C9ckwZYTrKRQdVMZzSjnPciyeuw31IoqR/8tUwt3O0csafdwJJH?=
 =?us-ascii?Q?13BtwPXfKQjcCElHRK+gHkXzvfc90uoLAv1eEtBEHSMrOyy+rIZU5COc79/O?=
 =?us-ascii?Q?dYaWVw1oBZU/1l/eyjKoEYtTeoWVas8lq+qPxIXypGytfKdhupidhhO0HTo6?=
 =?us-ascii?Q?2+W25UmUdF9WT6xYJbwsEjXWbC29L2gC1FU6ttZiiQquetiqbpMePL/bKfDa?=
 =?us-ascii?Q?l2Z1zOGEUgH8krHraYPUdGTHmGR9r3hBQPuuUdeuSDbfPgVmjwOo8jbgk3Oc?=
 =?us-ascii?Q?AavLQiwRzgVliywMGT6U2PeZe1hlQDbXp8ph0h7L4r6mBAiauwaIIIU6J5Z0?=
 =?us-ascii?Q?9F/raoi3w4Afg73IEeDfa1SVHkKnqaW9imIrscQbK0MFX0cs703p7NwXkooj?=
 =?us-ascii?Q?/gm+5JKJ6IFFVg3kHWEovLg8JoY+FrU40a1Jd7zIr/Pe9qWLAOHRCOEZjuHR?=
 =?us-ascii?Q?stzBATMUeOGS2U9BSeS2OpXzjS1Z9lYA3FrQ2EufaYalBulGPPGPf3/HiLV3?=
 =?us-ascii?Q?X6cAub6Xi6qi/iVfu3JlbmlFArS3xQYmpkYrn2sXw7M1/3DoAVN3MiJzuq4S?=
 =?us-ascii?Q?RaSglDZhiUN84h7CffY/ARdQ/qEQ4E/LWAMUlIsxsdW7FNimCtjh4rzuBEw6?=
 =?us-ascii?Q?7z/jwKSgxuyfoKZXMWREFioUeUmIB0RWyVmThuYjNvHuYGJyJUGS5HmtfvSX?=
 =?us-ascii?Q?1KgYZx31dJmmvCX2BoJHPU7bG7wMgiL3ydF0wn5xvQ5EWPu6CTf3DlVmkFzT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b62ccba-d838-4fd5-e07a-08db8276c5a7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 01:24:43.8189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfNMo+xmuZxvS/+K8i7E8H1a/9gy+9YfJ1/3IhFPnbEeTXOTMwO7xFNJ720RtKEs4UEIAfiSmvhWiakAnnS9zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_14,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120009
X-Proofpoint-GUID: oW6GakCTI1JwCqJznIIILpChzLckrQR3
X-Proofpoint-ORIG-GUID: oW6GakCTI1JwCqJznIIILpChzLckrQR3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230710 23:55]:
> Update mas_validate_limits() to check root node, check node limit pivot
> if there is enough room for it to exist and check data_end. Remove the
> check for child existence as it is done in mas_validate_child_slot().
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index f750ebef595f..072532fa18ee 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -7146,7 +7146,9 @@ static void mas_validate_child_slot(struct ma_state *mas)
>  }
>  
>  /*
> - * Validate all pivots are within mas->min and mas->max.
> + * Validate all pivots are within mas->min and mas->max, check metadata ends
> + * where the maximum ends and ensure there is no slots or pivots set outside of
> + * the end of the data.
>   */
>  static void mas_validate_limits(struct ma_state *mas)
>  {
> @@ -7156,26 +7158,15 @@ static void mas_validate_limits(struct ma_state *mas)
>  	void __rcu **slots = ma_slots(mte_to_node(mas->node), type);
>  	unsigned long *pivots = ma_pivots(mas_mn(mas), type);
>  
> -	/* all limits are fine here. */
> -	if (mte_is_root(mas->node))
> -		return;
> -
>  	for (i = 0; i < mt_slots[type]; i++) {
>  		unsigned long piv;
>  
>  		piv = mas_safe_pivot(mas, pivots, i, type);
>  
> -		if (!piv && (i != 0))
> -			break;
> -
> -		if (!mte_is_leaf(mas->node)) {
> -			void *entry = mas_slot(mas, slots, i);
> -
> -			if (!entry)
> -				pr_err("%p[%u] cannot be null\n",
> -				       mas_mn(mas), i);
> -
> -			MT_BUG_ON(mas->tree, !entry);
> +		if (!piv && (i != 0)) {
> +			pr_err("Missing node limit pivot at %p[%u]",
> +			       mas_mn(mas), i);
> +			MAS_WARN_ON(mas, 1);
>  		}
>  
>  		if (prev_piv > piv) {
> @@ -7198,6 +7189,13 @@ static void mas_validate_limits(struct ma_state *mas)
>  		if (piv == mas->max)
>  			break;
>  	}
> +
> +	if (mas_data_end(mas) != i) {
> +		pr_err("node%p: data_end %u != the last slot offset %u\n",
> +		       mas_mn(mas), mas_data_end(mas), i);
> +		MT_BUG_ON(mas->tree, 1);
> +	}
> +
>  	for (i += 1; i < mt_slots[type]; i++) {
>  		void *entry = mas_slot(mas, slots, i);
>  
> -- 
> 2.20.1
> 
> 
