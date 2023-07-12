Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76F074FC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 02:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjGLAzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 20:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjGLAy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 20:54:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EEE10C2;
        Tue, 11 Jul 2023 17:54:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BICtFT015104;
        Wed, 12 Jul 2023 00:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=MvGoSHAzujejh3MbRC4Yg145l7D5zojFTDbyZT7sCgY=;
 b=imn6+SBzo1t85HY2Ie8Fj3nWyOHwWuAqks37xgUR4OwEn1SdXCnxcDNM7Nv8tEsLj4wR
 OTBxlpeOmwRrC/4UXo5k++nUQ0YXENEvV06RL4SqPIC29S1qxAUM7iOgvH/zKtAKZS/g
 lPr7bQTVZZ0+wLeQ7MqEL0quDS5UfnjkiVUO/lCPO6yGMiEBWedDO0bxifhpTkwK4+xD
 bxaatJdN8YpRuEsCRbsiAmwD9K9ghur5TafCHgUuB52zMz1DlWeX4lkecvY6n7Ytzm/I
 FUpMxtnssVesIFgEbPPg3isumsjs5hUO5ffHdyPxAMPz3/rB1mRASmlEtM7DuHtLQoK0 MQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrea2v677-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 00:54:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36C01Jj8033406;
        Wed, 12 Jul 2023 00:54:47 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx867jtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 00:54:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=be3Z5NEp/ZHHIviMyg4CW7VC8KdpPFFvOmdp9uoI/3XGj3s+jRxbnxAuQK1FgF/C3b2qOhPczcrBxb/NeVfJT/QKFEoHp0I4dE3bv6ivVJih+poMKKULn7596HGwCMO2qOOdk081oX6Kw4m7dvugRABCZ/LMCJPZUh3/p+rVo+6iA90dASD3l6+dkmghJl6QdhzJG4EiqMgNNBjk63X1jpTtLdliFnTDOVxZqkS30Jhbfu4vfKOStq03EHUwWHcJ/F6ExQs7Yo9Sbz+gmpeIe0/enPXTUN2wfacdzxQ7Ua4Ea+JexoO/jGxvjBR+9Xdpyca+vVAxNJEfYwNka0C5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvGoSHAzujejh3MbRC4Yg145l7D5zojFTDbyZT7sCgY=;
 b=GottKKkwch+fDJN1w5RhNIuV5whxh3L/DHFxpVKjd6aYaAG0w9To8TRPgORRESQYzgw13Y3YHoPdoCti+IL9xKF6KlQj5/le1aiqpBiZ7g11w7wnm8WSQVc7kcYrNfQSsLNJLykIykx2iVTu6VatoFp065FqqqmI0jgNyOSqbs2Ycz1gQydPmI2Z6kqMNpn2w0JAg7rdTTZe1E1fJWX46jZ7JYUXx+zQuFGinw27M1vHgwZfLpCVIwgFzM2vfOTHGPczeX4Lt4KVcH61MfUJT3KcuEiac6p8+Tn//v0glKc005yhqa+CNC+BEZil97fUZ2p5BtUxMwcnYhnf64Q3bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvGoSHAzujejh3MbRC4Yg145l7D5zojFTDbyZT7sCgY=;
 b=KRPhSdUuPYcMDr03PvjqyoJZ9ja/TEYF4YNwxsb/HJ7jHIHrKW9B7gpTusHPt5WaTJpid7NTEgZvzeEkHWqEkjRp7tggue1JkDcZbe3aL/vuvQFgQsNBVKV/WbqhxNRfk/FEqIIqGktef5lKzlDdQidgDUuhGXoLTpiqICifeCo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB7534.namprd10.prod.outlook.com (2603:10b6:610:190::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.33; Wed, 12 Jul
 2023 00:54:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 00:54:45 +0000
Date:   Tue, 11 Jul 2023 20:54:42 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hsu <John.Hsu@mediatek.com>, stable@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH stable v6.1] mm/mmap: Fix extra maple tree write
Message-ID: <20230712005442.r5ehzbkcxu73whvb@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hsu <John.Hsu@mediatek.com>, stable@vger.kernel.org,
        linux-mm@kvack.org
References: <20230706185135.2235532-1-Liam.Howlett@oracle.com>
 <2023070748-confiding-abnormal-b7e3@gregkh>
 <20230707164507.mfekysya2jyupghp@revolver>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707164507.mfekysya2jyupghp@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 670ff1a7-3abd-40f7-d3bc-08db827295a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDnJyoZOr1LJp29yf1s23B0u7F4C0rvVtfamJHqZ2wJQDTpgxizQi67Ct2UxWtHZGBrK6nlFr3NVA8KJFqynbOXz6iL/wo4zrjLQYdrpHFIfGuN4VZnxqZGJBG8/AF0xEYApGLc0KM6gysWOD4ZEgMF0jnH19ykApCelwrYkNzGVMzNi8SjvC3BEzLJeJ9PY7Jmi2dNZAlM4Sj7ng8pjdUaYHOiPB3uukU9KfC5DRyfkEmVQM8vnZm8dGbuSSm3fiAhOQQE+c2t3Xb1ruEKLolU+U2X4AHiKsuvoC70laiK3+B1NSUXMZeGSP0zbQW0d5K+R/lWsBQje5dIr+tazLTSojy9+ARLZygrLOBlZlkZqnptCOlaRzpEqcPhbXZHRzFDTCjOf29HbJeKp7bHR6CQbC2qZ5TktWBxIAaH34OtoYEDTRApET6n1oC4azwFzST/TP2lCC/mJLMuk5rscOniQ9YwoKfTvSKxZQ+CR3a9HaftA/Am2szMiuT/5p47H/y9ibMg2Vnd1Kx9wbfY2yJ9BjhSTPDiEcYCWvFAkBz5o3B9meQiZBgGVxPyJ6QKZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(6512007)(9686003)(316002)(6666004)(6486002)(110136005)(38100700002)(66476007)(2906002)(66556008)(66946007)(5660300002)(478600001)(8676002)(8936002)(186003)(33716001)(41300700001)(86362001)(6506007)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KMxq/8yF2Vi5co9feTUEMClrFucdytLC6BxR8QhWCMdBatOoMnp2bL3Y5HES?=
 =?us-ascii?Q?HA1IVekZKOhY1Ka89klJWDhlRcYx2kSKI3xLyhbxUNgB+gRDNzpO+mQ8gO4O?=
 =?us-ascii?Q?7lhS5zH4LYYCctOADsUtdAE35J4xLyhOB8PLp9Gd7sKIfkIXMlzxj+3wk27Q?=
 =?us-ascii?Q?mp6fTE+FjgN+Re/oiFbr5eqghlI1zNRnk4Kh9vaQbZODAKQaEsP1jMbkmP/H?=
 =?us-ascii?Q?diMTlvLVCjX7gJAL3HMeJ0+1QU/Z8BH1GTnXUh/7y9Yj0IB0HsAVA6lpdFVf?=
 =?us-ascii?Q?ETGlTWHiZeDmMnKwww1z/4j8jikMqdWIahTQR4cifqN2AETE1q4RmCN1YxJQ?=
 =?us-ascii?Q?iKHx2cPKPSrZk1UffduoSa8zZZzzoytU7oNu1GFAghwOvM1bPVG+2i0gAHRK?=
 =?us-ascii?Q?zhwYmkPWx0Q7qcv1zMgsGpv4OhjqCmv8u6pMNtXmQYUMBU7eLJA0zVWMbpXC?=
 =?us-ascii?Q?Zlah6Sq0Ap7UkLfDtace2deJqp+tu5RHt3wGoI3WPeOiS/gzbZXOXTFPp14T?=
 =?us-ascii?Q?Q2ejnXxn9PNMU4f95ZH2AzNFYvK/+jSHSJXaVEsTxcplhEG67omXh/oX9pze?=
 =?us-ascii?Q?Ujb7mnHXm+6t38YOGjnuzhBxV7Nj8RqOEWXNZ90rL/bluzrYlPWkAdolNPdw?=
 =?us-ascii?Q?iWJCT5iqdXT9iosLvhw0ZE8LEuLxpfbKT8W8pFBKun+cuw5+BBkKIeM1f/U4?=
 =?us-ascii?Q?zRF/ATVcg1wKHf6o6JNaojh5unOrTDEPAJjKkbRZ2WT1KD31HeK+u+Tqhzzn?=
 =?us-ascii?Q?t7RpysuaqU4KjYB9C2fpSjSAHFUOwi6NIX+p8bG8utdLlR2oDX75WeorTnYS?=
 =?us-ascii?Q?v3WwTbWHHzNQjUOvXGblbFJbtLzpHsNYOhc9/hxSMlGH9bjB99GGLsyU1dyC?=
 =?us-ascii?Q?uxbFCe7/kirGg3vlxTwuedYcbpYLYudpi1a9jBjpPrEOngdGqwI1jME9i1KC?=
 =?us-ascii?Q?EkZVgfAGdTvQRFR95EN2bioZAZvSMVytEfxGSaU2y9Xcv37AnDsmwQyR83Ow?=
 =?us-ascii?Q?7rrr99L7ibILkCM7uBRjw4W85Yb1V8+LHH/Fn6dAsj3ORTzjQElKPnkE8wuE?=
 =?us-ascii?Q?PVmw4pLH3VnhGRPbnA8xqWnSZ9fCZXSxCBz33PjM4/rP9+KBA06PWVkL9H02?=
 =?us-ascii?Q?YPYsc0eEdtSzoY9SQoywEVFIZdo07bv6vMGpSFq5v+enCAw08/TNczL2Y40F?=
 =?us-ascii?Q?/DAvSGF6saVEjC/aw1BD2I7j1bp8D0OkUfQFLIpZO6QTTsHR/N+qGKdiQzIx?=
 =?us-ascii?Q?DlBUoplU95HwJzSC0HjKJUgc1Y6IijEqcWwuiy72bOICZtC7PGxdCOsk9by0?=
 =?us-ascii?Q?fep/eo2v1mcTjpsM0yvqEhUNqPsi+K3d1+lUOxqCLRuwq/cYVXax2LCIB2PM?=
 =?us-ascii?Q?NiMlmXRNVJ3LhO+ITvz9kgZDuyXvuv6di0kEClQcbhI3kc5kOaru4oeaBd/j?=
 =?us-ascii?Q?Ba/9Br/qmfmZCAf40liFcE1aQ7Bw++wh4H6/b+GNJexrTf7AHrOeCclx8H95?=
 =?us-ascii?Q?pDWiN2h+MDDGrInYadnL84BkthyIFOlUL70lxIKzSDul/3z/aiAxJkz3MtWZ?=
 =?us-ascii?Q?9FMzyKz12gY2KU3si7gCyVB3+Utb+iKMUkiURdKwtBf9q3GK39PGil8LlUlB?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3s5I6i6IufgsmdJLI/pS1QOnk9O/uE3zaSO3ZmRHl6b3vQ1GTHv8TmSPft3z?=
 =?us-ascii?Q?5LbKV7oPkNOTvC7ukgDX3GQvJXAHL96ZO8R++ek7d4h0V6Hvn6L1QBBESpsL?=
 =?us-ascii?Q?RyufsPcMOlycvtSVGKaNLSTmuwlLUq0lQxgqsK0HL6W/qymRNgIQQUe+MGd7?=
 =?us-ascii?Q?i56zLDR/q+o8ZNclNPS1lelhGf+SHne35a04Lz80wmY13ofismeqbUcbT8Ao?=
 =?us-ascii?Q?2lQQJ/A2eu2fCylo3DktbqTFB5BQsb85wpcmyTteIw2QpAuYYoLeDBkErE4T?=
 =?us-ascii?Q?hysRc+oABKO9A21IH8r2vdrDY3luXn+7zN9CQnq2hDnwa5OEgug+W0CNLtxg?=
 =?us-ascii?Q?hL1WJ5ovwmLZ0S8h8MDk5r8c5pCzYoeZpHW/py1xCT32Nvjnoq8hNDY3N5GO?=
 =?us-ascii?Q?YzexoAqa7TKD2Bfj3At3hw5RHha5Lz024evq2tJ8Om2NlB1f05rJ6lJVdV/8?=
 =?us-ascii?Q?4+aKbCIL/Mg4syXzi3B1ploPlttXGbmmZFgU9gChyxxc7rpqD8V4CVg6T0V0?=
 =?us-ascii?Q?tvXHnGI9F2cAxngf/+FdMT+P/r2RzIm8aAbfxwsJQrTMHS/UCLMhm1sq1SL6?=
 =?us-ascii?Q?EavdXKeo9f3ywiqRltOTZP+uQ2SR2AwHaqdIb1BTQUBs8WnjDhxKFPNAcDOW?=
 =?us-ascii?Q?I2QgBdJ/0WztabxmALmAPvpjGKM0q9FR3E0Zm3UsvVH2djh8axTIhdHEsw02?=
 =?us-ascii?Q?qxrZWkAwZY06XElJJseMXvQrEspmfokCxJyfhAA+WXTuDRui8jxCVuJV4IEh?=
 =?us-ascii?Q?yIOIGUq+DTSI687RxzxyARcbZxlSBd59MuMj8DEj+Wa5jof1a6Og+URX+ML6?=
 =?us-ascii?Q?S8KQaJmP2X/Fp4QYv6l9l69RDI2cSs/jqctr7RUk1d3zCXPu2G5La1LJtuGh?=
 =?us-ascii?Q?JCY+pjLz70r3g3Vl8Ph1JWWuTHNjphbnwhV146RWf0qHW9qp6K9Fj5APUv91?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670ff1a7-3abd-40f7-d3bc-08db827295a2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 00:54:45.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04maT3div4bJ/WmJCgfTHBmhzTIe2RNnrwe7JPDt/ykweKFNNDeSpc2ZdbPdbsBfXkSu/NuS9UuSdJ+pP9x/nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7534
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_14,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=872
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120005
X-Proofpoint-GUID: Zo9nULkzfFC624Owi2V4BL4XUpvdcSZu
X-Proofpoint-ORIG-GUID: Zo9nULkzfFC624Owi2V4BL4XUpvdcSZu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230707 12:45]:
> * Greg KH <gregkh@linuxfoundation.org> [230707 11:55]:
> > On Thu, Jul 06, 2023 at 02:51:35PM -0400, Liam R. Howlett wrote:
> > > commit 0503ea8f5ba73eb3ab13a81c1eefbaf51405385a upstream.
> > > 
> > > This was inadvertently fixed during the removal of __vma_adjust().
> > > 
> > > When __vma_adjust() is adjusting next with a negative value (pushing
> > > vma->vm_end lower), there would be two writes to the maple tree.  The
> > > first write is unnecessary and uses all allocated nodes in the maple
> > > state.  The second write is necessary but will need to allocate nodes
> > > since the first write has used the allocated nodes.  This may be a
> > > problem as it may not be safe to allocate at this time, such as a low
> > > memory situation.  Fix the issue by avoiding the first write and only
> > > write the adjusted "next" VMA.
> > 
> > Are you sure this is the same git id?  The one you reference above is
> > _VERY_ different from your 2 line change below.
> > 
> > And the changelog text is not the same.
> 
> Yes, but I am not sure I've indicated what happened correctly.
> 
> The bug exists in the older __vma_adjust() function, but I removed
> __vma_adjust() and inadvertently fixed the bug.  So the bug doesn't
> exist upstream *because* of that commit:
> 
> 0503ea8f5ba7 ("mm/mmap: remove __vma_adjust()")
> 
> My comment after the commit id indicates what happened, but the
> documentation wasn't clear to me on how to specify what happened.
> 
> Does this answer your question?

Friendly ping on this one?

Thanks,
Liam
