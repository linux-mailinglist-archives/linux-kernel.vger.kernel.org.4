Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC692703BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244269AbjEOSGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244745AbjEOSEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:04:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E4219F29
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:02:13 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGn815013010;
        Mon, 15 May 2023 18:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=0a+sSieAkIiVoJhgtXuhFqpaPdmRzKmitLs2SnsoIJ0=;
 b=fr8C68Rs0kEyvtciHVTOr9R+C4TSaS2AL6LRUmRhEG62bg24AM280tyOgzmy44ju8Ef3
 OVew5K4dK+Y3pXhIQzAxxoCUWOAqIqEUMazLf8CBPxVvL1Gznm9dXBRcbjN4R3XNUal3
 nXtp+ItNPLR2zkrszmEeakRhRQ8tA2Y+/cWxluMg4KVoE0y7M8jRL0bK+EqBZcXIvmzt
 GXn27Zya5V52+eys+8gqXw62pmgtPGnrtm8RorcVWgsaj2R23qMVOayqSp9wD6ZnQywx
 G2ysk0HejnACiB1cQ4tgbVmRnsdkOkpZjhT7Cur5c/Fjv2UUTcHFflJ0sGxcfhr5X38f ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye0kq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 18:01:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGtb2s022984;
        Mon, 15 May 2023 18:01:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj102rkhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 18:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DA98TGYsjAnaXsTUqG4ufxkWrwTbiaw7r7OcGvEFHodhiJ6vyYxnzQRB1BGI44iwxDlw7HEhz6tvdkR4Y6xtgPEYXkIDBpxFz8ae/bB9c9b6juGGcHKIAbyfCiNzhQmrj1I7XkwbjMtjIjT9TM3xFbo35B/gh9pgnu1jXSWG/pa3x70hfHj65aHtKYYU0dsVOuL0aSpk/UXpUCav6+qdbtCg7vRdLHyM9AVczZvUkGkZmwaOThav3geUl3eNw+yhGY/Hrrv2EQjqTmV2PkvB6qNSZN+X0/UR2vfIgbty+PC513SsqzvTl5WH9jfLjMJJ0oV8EXtgr2cZzhs9luc6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0a+sSieAkIiVoJhgtXuhFqpaPdmRzKmitLs2SnsoIJ0=;
 b=YA13UnLfw7xaQCHkGDoB/H/nEgyxed5XNCu5mDwrBnda5/F9IIEQJTBTz1TxFFgodPnd9sqy2e6basyOG+uzmANCFfJxhj735z1W0Bw7qSgXfp4Kbf1mXeI7gYr070hIO5R7ezaZ2L8oB2iz8V7vUuzMXSlgNTzcJqLf5L79BZw9EH/YIfKEvsuKsw89ogv7YEFYqpfrxTRA/nyNsGBHM7Ll0KVJGS+p4Qpsy/swKWGfjbP7coif0I2HV7Pm3S/Ylcuti+c/8LDLfKl9mBhKUVlO4jnWlHXNa3unTqJ9w4bUT+ED0tWIHD54eEfX7LIcROwnhjxLSJejhky+hvdz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0a+sSieAkIiVoJhgtXuhFqpaPdmRzKmitLs2SnsoIJ0=;
 b=d8eQCKW4t6/J2NIwppROLexxrK3mbsaWX7Vj4zQsJ86mM5Uk7sLK3oxvNnzic5KG0XtLSoGnMsRVgnrrg3QJbC/73AGfxg5jH1ovXJisNjl7nfCvghKTyDxm238LicNsYu0z4nT0BLUZA1ngBz92hHICPnYMpUxGtf6Tuy8YlnI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4311.namprd10.prod.outlook.com (2603:10b6:610:79::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 18:01:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 18:01:49 +0000
Date:   Mon, 15 May 2023 14:01:47 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 09/10] maple_tree: Rework mas_wr_slot_store() to be
 cleaner and more efficient.
Message-ID: <20230515180147.hgwk2vccsph7poxa@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-10-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515131757.60035-10-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH2PR10MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: c4acd190-212d-446b-477f-08db556e74b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfQpUnUqmihv6lByP62a6JRNvbfP+DWxf98RpkOhCF6H/VnvY3/kgT5MkKJHR+hjqeAYkdR+/kjEirAmgzdzyp8ai1QTHj0qRdSFjRL9hawcok4Lj8Iu9sBwe8cdaDb+JBD+f8cPvRN1ROTUiQHwFAcSCRQ3+B12sbNRsr0r9JfAti2b0RUx4vIckXFJh1E/Ak8kKM+gxjjBRq9yqpiklDoPxRUFOI/d8RvcfEJdrYbyjeR+QsaV4Ys4aT8Fz6iJU8lgiYAo2S3AESAxwBUn0FkJ5Bb4oodA1ye1XSDIIpLmUo9n77SSfYGbMIIzn9WmxewK7wdEd6JHCjjcKbgWNbvubvvz4ch3u+tVut8pQ3HJg7GwavJlk8Odg1Nb71hIyr/GuiwB8imSNcS7GifAHykGbvs2qy2SkuiSvbPSSxM8g94OoNqUZ8TaudztKYi4+wby2ErlhYmQ3mXTIeqz8n247Z0eXdCwR9HTY6eI5oIPOYQVyfYDrcjs1373GfpHusrj95pE/Utp1wlwX/tJkbp1lnXS42q8Q7dhozIY+7oGUr6ywa1TomHrYNRg4RsN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(38100700002)(1076003)(186003)(26005)(83380400001)(9686003)(6512007)(2906002)(41300700001)(6506007)(5660300002)(8936002)(8676002)(478600001)(66556008)(6486002)(66946007)(66476007)(6916009)(316002)(86362001)(4326008)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AhuoWNol+Wm1trI4EU3qS8o7TaBG2AwsU2HWFkeX02U+dEZFxLxq7B9SIm7j?=
 =?us-ascii?Q?MLalNsZNneFwqVo9/gXRl0HTaxoeS+gobAdmLXrswQDcBeDFa5PAIzUzZyNb?=
 =?us-ascii?Q?tzsw34SWb95ZTXbVSaWIg3u6EuA3U2PgFIJELH2y+BhknVlE4ACcmblyQR04?=
 =?us-ascii?Q?Es2Uq2Bfxe4yl5u32Hx2MNsesdKiXAMnanhtX9CyiiFFtH3ZYlymMbN9LwvL?=
 =?us-ascii?Q?I/6I+pY4f0bVUpuLG8ukc7/QqLTZatpGUds/NB4nMXdPm9fTLqpsTFZWrTY3?=
 =?us-ascii?Q?n6TLM3z0IHuUMw40KZA0k/IoiiRb4s8Q5Ckx3CvIEZ2B+QpmWeChVHwtsIj8?=
 =?us-ascii?Q?MWSEHH9Dg8OkhhTksGLLCOlFK1OIGqLwqoLrkGgxBADs8WQmZ5m32RIlzmxb?=
 =?us-ascii?Q?RjLF8CK/jAMNr4vuOgPfwIkBCgFDIRBniwRNcZMXO36a50h2fPW6OhgKOzKR?=
 =?us-ascii?Q?SEZ5DNSRVYnn2GBFvTxl/MdFwOdv+unOM35SArVLcbYd+dCFNT4yzNtEFrgY?=
 =?us-ascii?Q?N2dVaHDJD0HWQ2/PdglPyi6nIAikm9z+gOvX0LxGkzCn68awUeGYX4JhtnEZ?=
 =?us-ascii?Q?39iLLc5E3hUFyO4Lg7FWi3mpeHfD8bkUEc/jvY9WUUvotVnv4psGGOuv47rN?=
 =?us-ascii?Q?NWMRAJeXAOLoINckjaVpUxKMhCNh6hobnslEGpPpKrwITVOd50de5pNN7jo4?=
 =?us-ascii?Q?ZyJAooiBBMIvDgzlJq/rcm6V4UJCqezvtPSDX8ewcEj1yfLvRC1ny1u/n80+?=
 =?us-ascii?Q?2PJgThhTd5o5qwVKaIqWIHxK4YqMS8PS8CrZxHrJtIt9TRpjFTgNBRyu70Z+?=
 =?us-ascii?Q?VlaxrgjLtqW5PZGmVLZ4fQtvGj3+dvo/xn27wfccAZ4M1DRpEqZgZeqFTcYY?=
 =?us-ascii?Q?2RfLOS5L473UWB5I4WZ5T1eiKdIj94ltT/ZF2F53FEFRzbUlY8BE065jQS4i?=
 =?us-ascii?Q?6aWFkkP4z+WP7yC9mA82Bhtfn2qFHngZDDVQgWAxTQBBdt7xLnMp2auilPvt?=
 =?us-ascii?Q?nmUnDShnVeBIOj2Uq01roc42UaSjN/ecxZU2L10CcV66sMSK2W6xR9c3JBbN?=
 =?us-ascii?Q?GxuvU3gU0PT0tWsIeMfxib6QM2ZgHiKfPtN2Voc4IO1n+H0OS9yFtHNNpZ/k?=
 =?us-ascii?Q?vFsvgEPsSTa3ZiaekzMfUUmKosL7qmZeiPqTNfztj7prrsaB7qTOfu2ELXDQ?=
 =?us-ascii?Q?pI7v5jZi3+Rrd9g5JGq+rXt7AHUxfrh9ncDRmslQ2MCSM0PCsFilO0ESuCgA?=
 =?us-ascii?Q?B9h8sFPU++n8b/6V+jBEGQEorNHV++nuXfvleUGyXKnswzVEwwRpsDSH0ULA?=
 =?us-ascii?Q?N1eVa8bN3JrtyVaGrOOpoa+90SvJtB8qhkna99mQRuVvL7PFGHJWympunSrD?=
 =?us-ascii?Q?hqWPCYKGWqwyxoGO4yaNpZU9oUtgNl+HvOmw6Mv3m1vfWR03x8mu+gVSV0Jn?=
 =?us-ascii?Q?OGEPjm/aIUrc0qCwZHpx0CmHJpz+H64cJpamwWuUb2+BKnD2i9gdVnBlZjTy?=
 =?us-ascii?Q?mrjO7pbMS1Zc6f22FhhXxPfAsdPrpPYEA1eMZe9Cy+eADPyHEwAJX4RncrKU?=
 =?us-ascii?Q?3IR3NUhgwEZHEPEYirqAnYUQPfpQQ0iJCMXsBLy6aJ3TP7c0AlKaK55NDVjH?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yvif2ifD3hew3XDDB3/3cE5w3XlJkzfqPcE2h31/wbZy9YrYm9+Qi6s/Ltca?=
 =?us-ascii?Q?xNSHUBO0SIATMePrb1PKGzEKFY+gygTkRlADRYFrC404lE2wxFlUyTyhniRI?=
 =?us-ascii?Q?zQGP9I4m+s7RlaTrJ0cGDAUBxWTYbbjBGs+0BR6XmmVxomHgBATkJgAPCW+v?=
 =?us-ascii?Q?AfXO/XhutunIKbbL8pBiOxu+iG+rF726gamS7L2Vx+X7m/KplQeETSpQxKB9?=
 =?us-ascii?Q?PC50P5qlX++TOWAlFb//+2jam5IElqvaFD7M2KV5NQdGQX4e3KV540htH4rM?=
 =?us-ascii?Q?Z5iz7YJcNSBxEcjl7kVdTu87qqWxI+j36P5TQ4LzMg8k4LlAzOcE9WKXilDt?=
 =?us-ascii?Q?DmCIWWcy0GmFFtJ2lzAq2JXyu3OnAB1y+rIfG4W9IzOW119kq3ZsFesXdpJo?=
 =?us-ascii?Q?XjJhk8Bo9nhNJX8hAy+NuZo3xLZ1S5ly3dSHRGbgLLq5LTCnFr6SDZkDT9su?=
 =?us-ascii?Q?x3bnSMLgTdHddAW3PiiAgp0EfegCQwzNg2OF7amZdcd2YOw/Am3BZQ/+H8TX?=
 =?us-ascii?Q?sG1v+SNEJ7mVzfv6JX92pfDwxSugPH4gl24KUaEVpcTbRNYpAa3p/mHwVNb5?=
 =?us-ascii?Q?UYdEakE201mfsbKRnmG4C4+zhPGPb977JWbDKeSkWiNq89v6awxOC4Ku22A9?=
 =?us-ascii?Q?P3YvtA/ULWiSqS3vLaUVDCJTu1QdUzSJErRTbUYTL7MJQ1jwdXdzo9Zgr8fF?=
 =?us-ascii?Q?TkqQFkcE0mRRBhwzgBYKvJfoDiWBAN4f3tnVODo+bOFAvbyDePXltqThS55Q?=
 =?us-ascii?Q?r3X+l0BgPWGDXWDYWLljVAEYDNP2ac8vEp225aIpvJtjrkuk1qlBYd9/Rpii?=
 =?us-ascii?Q?QYy2jUszOpoEeaEa8fop2skg6w1+iwPpjJjXkuQebpGLEXRp22Kzn/8VZ9dE?=
 =?us-ascii?Q?edz1+iLYVe9MPyrwoy/zB/AKtpwSjw22KrhPHAhOGZVlKE+h701MjeTXoraR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4acd190-212d-446b-477f-08db556e74b6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 18:01:49.7263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wl2NnU9BoXlNCYtHO2M+HmuO7etEXuHCRrh84Bp5qcvyuwRfih2Qnn3ChZSgsRgxfO+pkI6mcW4GmpDzbYQqfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=867
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150151
X-Proofpoint-ORIG-GUID: wqHpTMvL8PCjL1I2fimWAWaS5ZjG_DO3
X-Proofpoint-GUID: wqHpTMvL8PCjL1I2fimWAWaS5ZjG_DO3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
> The code of mas_wr_slot_store() is messy, make it clearer and concise,
> and add comments. In addition, get whether the two gaps are empty to
> avoid calling mas_update_gap() all the time.

Please drop the cases from the comments.  These aren't that complicated
to need diagrams.

Case 1: Overwriting the range and over a part of the next range
Case 2: Overwriting a part of the range and over the entire next range

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 79 +++++++++++++++++++++++++++---------------------
>  1 file changed, 44 insertions(+), 35 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 538e49feafbe4..d558e7bcb6da8 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4190,53 +4190,62 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
>   * @wr_mas: the maple write state
>   *
>   * Return: True if stored, false otherwise
> + *
> + * Case 1:
> + *                       r_min   r_max    lmax
> + *                 +-------+-------+-------+
> + * original range: |       |offset | end   |
> + *                 +-----------------------+
> + *                         +-----------+
> + * overwrite:              |           |
> + *                         +-----------+
> + *                        index       last
> + *
> + * Case 2:
> + *                       r_min   r_max    lmax
> + *                 +-------+-------+-------+
> + * original range: |       |offest | end   |
> + *                 +-------+---------------+
> + *                             +-----------+
> + * overwrite:                  |           |
> + *                             +-----------+
> + *                           index        last
>   */
>  static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
> -	unsigned long lmax; /* Logical max. */
>  	unsigned char offset = mas->offset;
> +	unsigned char offset_end = wr_mas->offset_end;
> +	unsigned long lmax = wr_mas->end_piv; /* Logical max. */
> +	bool gap = false;
>  
> -	if ((wr_mas->r_max > mas->last) && ((wr_mas->r_min != mas->index) ||
> -				  (offset != wr_mas->node_end)))
> -		return false;
> -
> -	if (offset == wr_mas->node_end - 1)
> -		lmax = mas->max;
> -	else
> -		lmax = wr_mas->pivots[offset + 1];
> -
> -	/* going to overwrite too many slots. */
> -	if (lmax < mas->last)
> +	if (offset_end - offset != 1)
>  		return false;
>  
> -	if (wr_mas->r_min == mas->index) {
> -		/* overwriting two or more ranges with one. */
> -		if (lmax == mas->last)
> -			return false;
> -
> -		/* Overwriting all of offset and a portion of offset + 1. */
> +	if (mas->index == wr_mas->r_min && mas->last < lmax) {
> +		/* Case 1 */
> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
>  		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
>  		wr_mas->pivots[offset] = mas->last;
> -		goto done;
> -	}
> -
> -	/* Doesn't end on the next range end. */
> -	if (lmax != mas->last)
> +	} else if (mas->index > wr_mas->r_min && mas->last == lmax) {
> +		/* Case 2 */
> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
> +		gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
> +		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
> +		wr_mas->pivots[offset] = mas->index - 1;

These two lines need to be in opposite order to ensure a reader sees
either the value or the previous value.  If you overwrite something with
a new value, it is possible that a reader looking for the next range
will get the value stored at offset (but not entry).

> +		mas->offset++; /* Keep mas accurate. */
> +	} else {
>  		return false;
> +	}
>  
> -	/* Overwriting a portion of offset and all of offset + 1 */
> -	if ((offset + 1 < mt_pivots[wr_mas->type]) &&
> -	    (wr_mas->entry || wr_mas->pivots[offset + 1]))
> -		wr_mas->pivots[offset + 1] = mas->last;
> -
> -	rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
> -	wr_mas->pivots[offset] = mas->index - 1;
> -	mas->offset++; /* Keep mas accurate. */
> -
> -done:
>  	trace_ma_write(__func__, mas, 0, wr_mas->entry);
> -	mas_update_gap(mas);
> +	/*
> +	 * Only update gap when the new entry is empty or there is an empty
> +	 * entry in the original two ranges.
> +	 */
> +	if (!wr_mas->entry || gap)
> +		mas_update_gap(mas);
>  	return true;
>  }
>  
> @@ -4418,7 +4427,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
>  		return;
>  
> -	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
> +	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
>  		return;
>  	else if (mas_wr_node_store(wr_mas))
>  		return;
> -- 
> 2.20.1
> 
