Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283AA6A5F99
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjB1T1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB1T1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:27:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A1415541;
        Tue, 28 Feb 2023 11:27:13 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SGwllp000925;
        Tue, 28 Feb 2023 19:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Up2Tfsq2GxoYOQtE+K7DGhrCLlop1jNHXQuYBC0gvpU=;
 b=nsxYfWkhg9NGU29pB1gtKISwQnb333ibRXzu8JgoYJwlc2iMbX2qP87I7e0kP4Qux1Do
 GwczOavSPVQqEjw3MeEBD94OKHxYhfWvMCzIVKGXnnS/QGVaYGSy47zUOz7GXD1v0oRm
 /6splHjUHtU8W46iEX49kepWiHgyYnl+/aU8kJt17qJqnWrcUDkPPRUc98cfm9/sZi7R
 2yeqNdZPgKXh+grd4V1OH8VNkltf8GA/JR7SYcbU+NjqepuGSmpR4bFHQIwbDOSDYluT
 gaMzpx506im8kjz5BAD7VPoPDHX5L1tnv9pjX+DEGGpmATgXoRltMPRsWVz57TE9xX4P og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72f5hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 19:27:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SIAhcL016077;
        Tue, 28 Feb 2023 19:27:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s7k0xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 19:27:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7t0vR3yQ2WPfami5NjExb3xtwjNsln7HHxpR5u9MFewbyIG9ysiunNK6DveYv9Bm+zZS/sOS5dWzAzMSyF5JluQydwGctBB4buTL59TG3XLlv7MP3/lrVoQ4SS3H/jGzOudT6n0K2/v1GywvsRuqa5M5ujkUa/PMBnwWOMQ4QEGqSTfuPuUW+hMdWSCpSq5jjAhuHYpRnJzfd4a9UdMCqkqJRcglAzjMYXRqqxMP8GbmQ2o9HjV01j4eIpaL/slPyx4n6WvgP8+9FwbueKcVRmS7K0BbOmgv+mqP3yX0VhjUC5cLypmeD7eqf+HyqTdrmT4g78o2y9O/x38vKkxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up2Tfsq2GxoYOQtE+K7DGhrCLlop1jNHXQuYBC0gvpU=;
 b=eH+M68//I7ILr7S4YgiwEmFziI7wd0Eg/A0ztCP5CB8wsp/8SnAZC7xRaRKYcD6719GOBOY3J0r0dP+UmN0b54IjvdnIty/TMXTxnK+FHkdqLXoDPQD+AWPpNAxMUq2t8aKtMZgvub58MWPRcjBw936V6b2pKB1242KxHaCKUpcYL5JNPdUfvZCvf7yGKjsFyZ6bAvldP0FJFgIdSXOesCd+D7FstZ3pzDP+XnCpl0Fzq6bIz5hsU00f9+HBwCbJwzOc6ifSLSFZ4LxmU/ADgxb2myRYu1QN+9vsyRrMjCyRJfmSKc2ZKF/rMhq0pV1ZdNacp6Koip33J0+ycLAzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up2Tfsq2GxoYOQtE+K7DGhrCLlop1jNHXQuYBC0gvpU=;
 b=yGF9uAsPS/bsVZFGgspWJO2Kybi/pCm5LidQnzYA20MJHY1rgN8Nx5gTAnLVYVOjV0XMhxxRw7EY9ab+7p6QL347IWXnZE/lFZQE7BNUP1VOZ6En6vF0y8+RvGgd5RmMXDYtJAA8/PFPdQxlUfbFfN9uAkBfX4Dshp5rx4CZHYk=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 19:27:00 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 19:27:00 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 13/20] reset: remove MODULE_LICENSE in non-modules
References: <20230228130215.289081-1-nick.alcock@oracle.com>
        <20230228130215.289081-14-nick.alcock@oracle.com>
        <Y/5TU/gxAxfVOedg@spud>
Emacs:  no job too big... no job.
Date:   Tue, 28 Feb 2023 19:26:55 +0000
In-Reply-To: <Y/5TU/gxAxfVOedg@spud> (Conor Dooley's message of "Tue, 28 Feb
        2023 19:17:39 +0000")
Message-ID: <87edq9h9q8.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: c5493df0-2b7d-4f8f-c043-08db19c1c3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSyOovYzcZrFuOqE5iJMCzqVMKkqlRHnRcsIdZ3pGhYlwU65UwB+F4DmGnF/lHzoA36b47PgkpyQuzABPvIYDRP2T8DnmaPQR2IabH3QxAWx1K/pCRxlg3xZoCEdahK83zKukoZzV1BB9nkg3j/wsM1b+wlyLa7q+rXPvpCArqhDlYuZ0nG3ZSX1kGcWSQ0Jcs8pBvo6s0qdB5SqpKHalRLihdKx+mISBtz9UOpjQ9SZSjjWPIMjyFK6JjceMcMhyxJqhp+/Ao6tzH3k/Tkc1OrwII+TN5aiBf51WU80kuzfpFQfkKhcjVOkGONOXVejjjtHk0zaHb4q+o97d3ErIdHhILE+Wgb6Rby2OjpPpQIgIanbeH+OZHSByxt/JLwrsoQIyYZR1kEoFW9TF4FdMWAmhfZlgKK20MFXiP3MQ7Wd5Zrdn9wx8kTUDFzJOibi8REgT1QOXSBbRHckkI6Pkfj+VAqpj6IgopVTCCc9p2GvRtelZrvaRucIoain7ehZD2hP5N45v0+IUx7O9ZyMe3nvT8RQbfPNB050PAeVSRd9EgGoOg9rVhQQWj25Vjm5JhKoLidKalLf8RL7QiAjq6ywbMijERFLEttgky7iOQCiwPRlr2Ye424qHk2BOKPgmNVpsRcZyFYat8B/We1C3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199018)(66946007)(66476007)(66556008)(36756003)(316002)(86362001)(6486002)(478600001)(9686003)(6666004)(6512007)(6506007)(186003)(2906002)(41300700001)(8936002)(5660300002)(44832011)(6916009)(38100700002)(8676002)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5C+h3LJr/rWX3JSlscwCxKyBkooNBbOYO1tYScnedgrGd82tVSFu95n5ZNXh?=
 =?us-ascii?Q?w4LhOt3tvMNawn01lb46/mWuoqG5KzY45KOZnLwiPxQvFHchP0ydwXMbwJw0?=
 =?us-ascii?Q?KwzPz3QvVCc8aMfQDIb1wskUQey2eaP8n5sH6tywndvWoTE0JhgjTtxQapZ/?=
 =?us-ascii?Q?tmZi1OBaOKW/h1e2sL3R11BtEN0SuwIj/dQZBumBG/2rouPOhpOqU/O2PoaO?=
 =?us-ascii?Q?ITvVeEiHxsI0XwdZAVfOVii00TGFW/FoLwdD0wM+IwEnMGHtnQ+pRhR6zAY1?=
 =?us-ascii?Q?2y4rArEjmfmpAvZ46V69Q/enhYyl8Nwsd9aUWBC5ryfQXIxn/f5+ahos0gNX?=
 =?us-ascii?Q?j75A1dnqnKgTnuAP1S1mEiFNplJHfjuZNtFgb3GVYs1Yga1WTVh11hgImSqP?=
 =?us-ascii?Q?3qc5kRPQxGnCK6ygqPCB5nXnE1IiZCIZqdy/V0ThQJLJsLvYjLvBf/VNitJs?=
 =?us-ascii?Q?KRjqVSaVO3WtCQVYGKfMTu0nuYuLBFacsuelZu/yKMpHSfyoU32xEp+rKRjf?=
 =?us-ascii?Q?EEmvQGxhMbYiIO9RWBx80gl8WHqux+e/sUxN06x48xIOJ/CqusHejbozkiJI?=
 =?us-ascii?Q?Q9z1MAeXIyqbIR/Ct2e4JouRI9bQzeSsAOIFKXM/E/lHUqVSBiGEKcNLltVj?=
 =?us-ascii?Q?Z2pG8SDRHZLmGKUym3kQMt8FytckZPKjsrvbJOXBdG2S9zkTITQ4Ya1TmPVg?=
 =?us-ascii?Q?IQJdU0uLqWSAPWhKVIVBWVI3pf+jVDJvSjpLUmuw44bD/u5LxBSFTrLNQ65p?=
 =?us-ascii?Q?xlwKDwTZNmSn6ds38jMKTBvFvG+IQ/Mtl02Zd9dPicxbxMiz/E4O1BSUKTTK?=
 =?us-ascii?Q?B2aqyjFjGU24BdWExDzbu44crS7bbragvTLJ68LO6KKFiL9cVGzFFBafpG6n?=
 =?us-ascii?Q?1G3gkqJmNvCJvj0E0ZtdgQ3Ckav647x7wygnRm19nln6wXUtSsitYojuPGv8?=
 =?us-ascii?Q?qM9bnZTyQKW7ctSCa/0AB47QiT5EGBSCuOAMMtTwP/6OKDLr08mWy/6pZowz?=
 =?us-ascii?Q?L0l9q95j4MNX05vdf7+QgCpL5VXD/y0ehrBY5MVWCUo+MfAOYfTKaHqovrdL?=
 =?us-ascii?Q?XaeB9cZQfUwoxI3sSu3P8mA8nwVsRSTzySP/hMFiFa3wVYx9eLKH5iAnnyH1?=
 =?us-ascii?Q?hKEGp+doq7wp1FitfuxXpx2vMYPqdsH3mMim+vOMx2NeFA61dLpEwZEvvpcJ?=
 =?us-ascii?Q?fpKlWZCjPGwQxOABc/KI0tPd0UFeqh1LDZQEkIFCx0InCGFogmoprk+AtKiQ?=
 =?us-ascii?Q?htcrMl/FKpQLPHkMowY058rGXznuDiBaHlGfsRn9HYyXiasfUn5ipWdw+0OZ?=
 =?us-ascii?Q?bZfi2PNsrbyRr2I0P+8ynntctBD0g4mz1tV4GNQVREF8MKZnZiRELAd9Ne5R?=
 =?us-ascii?Q?duaYh5ffwAkAabpRNJSSxHFePxWezs0orD3QdiM1cuH7ij43cRW3VrsuA6+a?=
 =?us-ascii?Q?vUaBZ9QdMcUK1VQ6TVuOCij1+VyrkA0rx1TRLMR7r7u5+4YblPJPJCVEJk2/?=
 =?us-ascii?Q?hYfykI6GBZgoOvuEAepGR5OJxcG//I8v9plXX9ExkQ+PPBNRf2qXzMlbhRgZ?=
 =?us-ascii?Q?3zJduhYYGDKqXw5yimXYwamGR8HrcWLWiJCtR+fwgqBfdx+esCiqc5hHLL6I?=
 =?us-ascii?Q?V9aEIB37vZ3NnQZs+o8aA3Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qs+lqqXQuY8LadH85iDYtQUVcXPHWNfwCqfmB93xd8tEpWQbU2FoDQHY5WGnDIsxSn5SzByJ4IiHHmOJ8ghzYjVq1+UlXFgKL3HRIj81PVXlDMNaKfnqfhMd20z5uNfCr4oiTVtS7ycEQ4kI0lYY/9ykEvcOHCJoBidQmOski/Q3hpgY3c+fTQ5++1H+oTV0gUWNumkiuK2NqXGAnuOYsGGQjmWHGN/iY+Z1ZnMHf3k0VsljE5J8MnO446BTkzBEwE43leAXDunZiLpO0WvUy0lGLeZItkEO0QCbMZf5T58v/AWpfyJL4FTG5hs0TK/kFofFBZ7hDnBR2ntm138JXvebV1YjZqW1xPpzOemN+xpbXeraTDumd3mBz3vHsNcSF5+T6o2UJRBFyK0OD/YSGCLNJdmYSMGST/M4znhwGsxCEeW8zADPU9gPXLr4hyLrQiLJrH9lNeuoYRQTFPDDYRnwO5A9g4VyqQ4GdRZXhfVNbWZcet1cIdJFzzW22GYfNQzzgfmMJP4ra8U6oRKzy9LN3odC+AuDkaxM0pKrU3K1IuCKs1RMUmv20P6zdRylsB+KtmsoRWoCC5ky8U4RQLH0Nu1rz6VsWzxn/RRCyf8fAFMV2n5dWWYFPSFbiBUotX6AyEAQibM5RUHe634YeLyHfSeB1/p175Db2FUbCIUyERMM9BnjVoZk6VIcqPjeQ1eZYvD12eo5qmCS1B2/5g0H+99dlSxN/j6Ntqux3sWhNKPU4MxHLirjSD+b/nPcsvjRaaDRKbadn7eDMOe7K+ivGdWPJvEjX+xLr2x5ZPSsV4rpHCd6L/LLaL2G6Dm5Z/OAmocWW66aIQFWXQ7wAw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5493df0-2b7d-4f8f-c043-08db19c1c3c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 19:27:00.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vexqPffTGAD7m14ILMZT72OsbLCWwbCE/s9wiegyO6v5CciR126CkCfvmlelMMCJNxloD6UzL3FVgWZacZZcpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280161
X-Proofpoint-ORIG-GUID: 6SILpwpYtmmF_ggeSTo4N-NuT7zvWLjZ
X-Proofpoint-GUID: 6SILpwpYtmmF_ggeSTo4N-NuT7zvWLjZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[dropped non-lists to defend innocent ears from my flaming pedantry]

On 28 Feb 2023, Conor Dooley stated:

> On Tue, Feb 28, 2023 at 01:02:08PM +0000, Nick Alcock wrote:
>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>> are used to identify modules. As a consequence, uses of the macro
>> in non-modules will cause modprobe to misidentify their containing
>> object file as a module when it is not (false positives), and modprobe
>> might succeed rather than failing with a suitable error message.
>> 
>> So remove it in the files in this commit, none of which can be built as
>> modules.
>> 
>> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
>> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: linux-modules@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
>> Cc: Conor Dooley <conor.dooley@microchip.com>
>> Cc: Daire McNamara <daire.mcnamara@microchip.com>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Cc: linux-riscv@lists.infradead.org
>> ---
>>  drivers/reset/reset-mpfs.c | 1 -
>
> I assume your script just got confused here w/ $subject, since there's
> only a change for this specific file.

This file has had no commits since you wrote it last year, and the
subject for that commit was

    reset: add polarfire soc reset support

so, er, yes, the script used 'reset:' as a prefix, mimicking the
existing commit. I'm not sure what else it could have done.

(Regarding the rest of the subject line, I suppose I could have arranged
to detect single-file commits and turned the subject into 'in this
non-module'? But there comes a time when even I think that maybe I might
be overdesigning something, and automated grammatical adjustments to the
subject line was that point!)

-- 
NULL && (void)
