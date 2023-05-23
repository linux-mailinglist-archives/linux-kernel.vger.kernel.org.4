Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472C470E443
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbjEWSAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbjEWSAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:00:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DCE5B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:00:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHx73K009796;
        Tue, 23 May 2023 18:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=0/cY4fNFLYCrJFThtBVqckFcrpsGIkLUjCOF7gY7Qw0=;
 b=xH2mnIV6pbVW6ygiAuivdJ2dy6r4hKB1y9UmARYz1L7hEOenwafb4M+UBKypGKJca7OW
 n3d3TAk8tfc2kesCLG41X4vs/heyjMAGIu4NF/tTXmkExKlcrQElOu62telAUa4xGJdp
 xUzJUD2kPSNLrffmnh0Fdf0BEMlu8XMKZg2AbU85vP259AWFuFWAyMAMxWDggtOkAWFK
 whwhXTcfWOb9eExCL0oqNzwsk+eSPcpoVBEgFA02aUupSoS/iDb7hzmLP38WAwo0YpPe
 EqZTCOPF1qWhGG0tTA21Fj56A0mgsW1e8zimTx0ZAy7vDMLlQYAAKi9S6wqgKwrWIfVZ UA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp7ywt85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 18:00:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHUBAr028536;
        Tue, 23 May 2023 18:00:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2rdwqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 18:00:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRY/CmITdHoAoZY0lSrzTg/rqtIvh1KB9MTJS/qNAeqEAG71pLnxkdLeRmhuc1ksRScEI5F+NtywIqE3fXKZ29wZogL0sJbZClxD0oLSEpEv7mDIyZso/ItM4tmPPFDxRhNb68YwgBsGMNIsO1vwBCn8uKFSxZexwxFNkLm7zbrYVPJX4ms/rV3QUslXarM4qKC+fd8ixRwr+cnI+zbFyE7M1qlKgYOfzXWbF88HvB1h1xFEYKiCHTG8JhfvJJ2/jgr2pmqhlQtW827r2KCaWZ1Jo7VVgYzD+IEA4oZ0xbetmD9imZlfVRuG29D/7tzbAvAu4ilOojyl0GmrobB86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/cY4fNFLYCrJFThtBVqckFcrpsGIkLUjCOF7gY7Qw0=;
 b=LuuEbR7U/2yMUfrbj+dW4/L1dt7FteJiR+RxfPH77XspvKbGtXMkHQZ1kKDUaj56u/X7NOV1dEtgELuBqIUTyk+LN+1Ti5a2VTB4TbvOM1jO7oSmZPKKCkZHVRcFx5FcjD+BS7KbanK4WDfEcUaLfjLX98aRIbptu2ezM2eSGdyxChz4jQRycvz/+tZCTb13BNOqBgLYpa7jwIugKtE9kjqAkXuManjt2qAgXmtnd5GxmMpWo3HDs1rrlsGwEG82Bp5YyulS8FLxeP8NPyi5RPUrfoXNkCEBGSHHrDv8h2xT5jguwjed5JDM4DR/FtK18Wzi/zRxLzM3+13GgEMOZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/cY4fNFLYCrJFThtBVqckFcrpsGIkLUjCOF7gY7Qw0=;
 b=B0SdwZNd+5BI6y/ipiA2xEoaPZJf3t+46Ktf7IQ1CadqH4efPqRCwuCHKxPSj5MOBYds6IkOtADHFQulyHoguyvNBFxims6HwsInRTGG/2LHtuYvmYLBrhK3AUaWvQluMKZkAEt59bUZQW5KXUannSypYS5uY4TdmdApqlOdTbU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ2PR10MB7787.namprd10.prod.outlook.com (2603:10b6:a03:56c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 18:00:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 18:00:17 +0000
Date:   Tue, 23 May 2023 14:00:14 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 09/10] maple_tree: Simplify and clean up
 mas_wr_node_store()
Message-ID: <20230523180014.m5fdtth6s6vinrwd@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
 <20230522050656.96215-10-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522050656.96215-10-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0368.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ2PR10MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f09446-7e53-4ac3-b512-08db5bb790c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZ5OvyYG+Bj6q4RrWE87k1T+XFeabG7tNEaIgHk1tVmJ+IeZ8J5uBmcZdtowIarMqHF1AL2ZGp7Gx6GwuLse25i9+BqeDTHZp5w1rtBX0nlTmELICF1vHEcA3lfmPwDRRdRMcFSjFYodWe/YwWiXYC50U+yE/Rdp2Bbz7RmDJ/uQZqjaKhsrtLlNFbONFywPudD5Q4DOQ9WtGal8C6IbUtlop1iNFGfe2EscWQx8kJWMBY3l/nHuDxD3cpjSteavVwYJycT3a1bBrUVdRsA2Ihbu24qzd5AzwE5kt+ASpRGoyCi8OBtBzZPfepEJVE4ZajOIhngxewain2tAd0kwhhnc2HpJ5sbnG8EaswV/izhVWkbg8v/y8OIg4uaBqts93KOWIqXLjAZU2aFLaiqPegHHDuaXQFZ1kKE1w9Da8otn/kvXfyNh2EcJIpr0x78o6h4VbvWF1z8wZtSsTYLRV/GO7VXPdxpiOD+TbPoAVYuHhYCBGW95kMOIB32tjdCprv5NLoGWxD1hLu6Lz6+sAQhijb1m1NNLct+39PwOOFvEkaXhr4+U+v/uY+dNe8yt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(186003)(2906002)(83380400001)(6486002)(478600001)(4326008)(6916009)(66556008)(66946007)(41300700001)(6666004)(316002)(66476007)(26005)(6506007)(5660300002)(6512007)(1076003)(9686003)(8676002)(8936002)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8bs/pxrgJBBVNu3mKkFIYAud08iWkG+GIzS/PnmjZEX4Jt9XQOFHEpFANxQ?=
 =?us-ascii?Q?00OjTtJ+p3x8+JO9W/+WLoR+QtmI5fhaGsTZhcGfHw5CMdDMA6E30R+vJXGl?=
 =?us-ascii?Q?idQNCU5S2PBoYEBry5GmPCovL9VEJyovpEJXfpkdAaslMXAYmbVazSJ+wzwK?=
 =?us-ascii?Q?XlatDeweaytlp8wUmtiUTStsylaul/oeULlJngC1zJl21p+k2j86nwKR8h5y?=
 =?us-ascii?Q?q0gyWpXoICrmekwA/DGs1sTJakvg4PRtKeOq1067cAYcD6EQOk/Qr9+KCzFx?=
 =?us-ascii?Q?xaUz1KrMq9pzwCDDQGqoh+LJyBm8jctL9a/Kj3ubMlVLC30ybGuab3gIZg6o?=
 =?us-ascii?Q?sx8sRJTZtm/LnvFwnIyUfvpIpfZXyBdmE3NREG+g4Em3W1Z0KdcT7qLliLej?=
 =?us-ascii?Q?MXYoa/RUyjz3jPJjmzz51ooa/WAAliJkWCjOvs6Al2yURtgJy278HA11ztv9?=
 =?us-ascii?Q?/3sVIF4HIsr0SaLyp/6xTbNnEztp1cVFcrevqWwjgZuwTnt+F2XVz4s4R/5c?=
 =?us-ascii?Q?74TG2c+y6DnC3Ro98ECR1Xxosbm1cTWc+zagYMhdHAdc7GysZrncsb6Sbn6p?=
 =?us-ascii?Q?CQeEycAo2x7t2I9XHMDHXPB9h/CQ9U9tf6JKpkstTItCpd/xjvercCD3cvEz?=
 =?us-ascii?Q?uj0cz2ZANfRVuzhjdovSnuVopct+VcMtnMz56wia6uwPGSaeM9nv3MS04ngD?=
 =?us-ascii?Q?G0UBbblrB/MTzGRjBi8lBEY3QZPGXQa3g3z8EN8FCXrUtZhpwNnQFitHgTyU?=
 =?us-ascii?Q?xgDl79EfXeTW3ZQivSdGork5gEfXT3Hx4slyPboEbsnefrrQcp29hWUqxYQm?=
 =?us-ascii?Q?VYRI1GsZ/KWQb1f7BsDWCDX0ixzc37SUtmIAWBEq0dS7+cgXGJf4yjszYLkB?=
 =?us-ascii?Q?FRfpp9fg5updV143lct9gJRHIWxIXP7jFJ2RjUdRuH2t7kVPG3r8YDe2HdLy?=
 =?us-ascii?Q?pm6NmMisU/B1EkuOnvsezrCH4ZYW2ZG1k7ONpBlbHsCbyqu38UDCMUv6qLic?=
 =?us-ascii?Q?nMpzTHStWQCoEtH0tz0YMpHg7naH8FLQpiz5dmldLIbKAcy64u1IktQKAW42?=
 =?us-ascii?Q?mQ+mEdZUaTTMEGBsLgRj519xxjF0QoBawIjAwZYcy+YtY1JZMO9NUMqY4j5U?=
 =?us-ascii?Q?xAVUBPephz6sGhWV7aYmMsUjyL+jVwvU4/tuI9NFvxAFhXbmesKsHMaF/qR6?=
 =?us-ascii?Q?Vdenjpfh6go2SYKvUIzCqrsXt0uksSZBhSY78zri3CDq6h2WaRaTR0KkOIO1?=
 =?us-ascii?Q?ggvTxXZBTBZMVYeLKMeLcTdkvUhICE9B01k8O2OJj1ObpaetZYox3Ah2Bk56?=
 =?us-ascii?Q?VcTAEZODnAPXAvFxn2Wx1nwH1SDsIgpnbVZSkbl5ge6EdrUM19+/4gFagwHf?=
 =?us-ascii?Q?sJT75shPY+nXJ254yR+A1c+JQHjJmcNs2jd9SM8PdSGxekT4Ty8E/XEiea5+?=
 =?us-ascii?Q?71DQP9ycO9oTlPF9W2FTk66kedurG1sbN/s9PjaMnN7bgKdcEfJGg2d9z2FN?=
 =?us-ascii?Q?VH51puS+zsa5iPNLOMl9Bt+rNIJz9n8RVq5vMPecgeu94IpdgGYJZK+86oq1?=
 =?us-ascii?Q?GELMFaQ3wXE/lW87SOFjNRqQh7+s1g4L0C1Bwiq1EjllL4HhcBqeF30kyDVa?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fSqiq6GLLSvC9aydaETo3ggrtKyT/VwNmYLMyzCL7/dVIFtSGHoC/kJcVx/e?=
 =?us-ascii?Q?KIZ6AcRiJ4rwOvmJtSBFlZtzo0fHnupn2rhYjD6Za3OZATI9knPLacnIYfWu?=
 =?us-ascii?Q?XeCo5gMp9Fw6Qas0lulTVgP9poXez4wXjS+6pfwQERZIjCjyBZxfb/nt6RCV?=
 =?us-ascii?Q?7Ej1iExXv8neM9+s8+9oh0zPICzmOk3Lu9wjiviipFf+fUhWv7Me0FtYOfAH?=
 =?us-ascii?Q?CYoLFtVC6GfqH5fZcWLMI59CqitabQDMBwvqIMRZapoLKRBxl9kbNxZTF0z4?=
 =?us-ascii?Q?xou9tjtRyFm0FYwRNDF+iLRv7ktc1HNxb8S47uc5bkIKojXGvMOrUdoxvszJ?=
 =?us-ascii?Q?AyP7hT4IuLAN4XhvnfGTRlN78fiFY0h6szKIOAZH2eGENkkS1cA9/V0BzvTo?=
 =?us-ascii?Q?YhbuSHj2SR71T5ZknbjhclrRrHfZXI/oxykGueHNDQuEk9dehbahDY5mbOrL?=
 =?us-ascii?Q?GuDT+iVQfQIYQ1HrkxuRHPXu1TQUd3FNxcs2T0yRPv3vP9eEtgb3CFU0cpnX?=
 =?us-ascii?Q?blpWwpAP2k8b/BV3Zzwkuuz/imFEo+aQgsZSmJnG9zAztEFWFyOJw9UmvUlF?=
 =?us-ascii?Q?e4mc0hSDe8x836tJGPHRDyoMurDywPjW+SL621QttIjte7nfxRNpNDT6qBMS?=
 =?us-ascii?Q?+OXaIA5YpWhu5npYsG33obV5uQOydVQC0COhjp2xZ8/3sLitQWS2FMwNYmmY?=
 =?us-ascii?Q?UXNPIFHzgCsyoNr2oSYNcalRu06PZeR76SXF4ajDqHbvCVe9cxLMPjb/EmFI?=
 =?us-ascii?Q?cmy8JRuC/DtHArETuDcFwcpEe6Sgz4iFFyEkBGNp0myEN2UO7vhKtJdXoO9L?=
 =?us-ascii?Q?eRA80GsIFxcBLTGYrZ4H5+EfftTb7TtUK3yGgaXhunV7xyIFz69YSVehU3r2?=
 =?us-ascii?Q?Akwi9+sJ2pRkFJeGbc0OnZ5k7Q1XaBS0Xuen5niMtNBjinpiMsv97pk0+FaX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f09446-7e53-4ac3-b512-08db5bb790c0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 18:00:17.0147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yiFO2JA5QiDkx9QTSNL0eS+iOYXAUxqbmvZdcYguaIHXmDNt2MgT0tXUJz/JGs0iQvMZdWeT8ZlbtKFLEz2Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_11,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230145
X-Proofpoint-ORIG-GUID: GmpDzJ4ncGd1p4Ck6me7m_0FSussiwhT
X-Proofpoint-GUID: GmpDzJ4ncGd1p4Ck6me7m_0FSussiwhT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230522 01:07]:
> Simplify and clean up mas_wr_node_store(), remove unnecessary code.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 87 +++++++++++++++---------------------------------
>  1 file changed, 26 insertions(+), 61 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 1fc872f7683c..aa1472c45757 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4075,52 +4075,27 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>   *
>   * Return: True if stored, false otherwise
>   */
> -static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
> +static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
> +				     unsigned char new_end)
>  {
>  	struct ma_state *mas = wr_mas->mas;
>  	void __rcu **dst_slots;
>  	unsigned long *dst_pivots;
> -	unsigned char dst_offset;
> -	unsigned char new_end = wr_mas->node_end;
> -	unsigned char offset;
> -	unsigned char node_slots = mt_slots[wr_mas->type];
> +	unsigned char dst_offset, offset_end = wr_mas->offset_end;
>  	struct maple_node reuse, *newnode;
> -	unsigned char copy_size, max_piv = mt_pivots[wr_mas->type];
> +	unsigned char copy_size, node_pivots = mt_pivots[wr_mas->type];
>  	bool in_rcu = mt_in_rcu(mas->tree);
>  
> -	offset = mas->offset;
> -	if (mas->last == wr_mas->r_max) {
> -		/* runs right to the end of the node */
> -		if (mas->last == mas->max)
> -			new_end = offset;
> -		/* don't copy this offset */
> -		wr_mas->offset_end++;
> -	} else if (mas->last < wr_mas->r_max) {
> -		/* new range ends in this range */
> -		if (unlikely(wr_mas->r_max == ULONG_MAX))
> -			mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
> -
> -		new_end++;
> -	} else {
> -		if (wr_mas->end_piv == mas->last)
> -			wr_mas->offset_end++;
> -
> -		new_end -= wr_mas->offset_end - offset - 1;
> -	}
> -
> -	/* new range starts within a range */
> -	if (wr_mas->r_min < mas->index)
> -		new_end++;
> -
> -	/* Not enough room */
> -	if (new_end >= node_slots)
> -		return false;
> -
> -	/* Not enough data. */
> +	/* Check if there is enough data. The room is enough. */
>  	if (!mte_is_root(mas->node) && (new_end <= mt_min_slots[wr_mas->type]) &&
>  	    !(mas->mas_flags & MA_STATE_BULK))
>  		return false;
>  
> +	if (mas->last == wr_mas->end_piv)
> +		offset_end++; /* don't copy this offset */
> +	else if (unlikely(wr_mas->r_max == ULONG_MAX))
> +		mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
> +
>  	/* set up node. */
>  	if (in_rcu) {
>  		mas_node_count(mas, 1);
> @@ -4137,47 +4112,36 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
>  	dst_pivots = ma_pivots(newnode, wr_mas->type);
>  	dst_slots = ma_slots(newnode, wr_mas->type);
>  	/* Copy from start to insert point */
> -	memcpy(dst_pivots, wr_mas->pivots, sizeof(unsigned long) * (offset + 1));
> -	memcpy(dst_slots, wr_mas->slots, sizeof(void *) * (offset + 1));
> -	dst_offset = offset;
> +	memcpy(dst_pivots, wr_mas->pivots, sizeof(unsigned long) * mas->offset);
> +	memcpy(dst_slots, wr_mas->slots, sizeof(void *) * mas->offset);
>  
>  	/* Handle insert of new range starting after old range */
>  	if (wr_mas->r_min < mas->index) {
> -		mas->offset++;
> -		rcu_assign_pointer(dst_slots[dst_offset], wr_mas->content);
> -		dst_pivots[dst_offset++] = mas->index - 1;
> +		rcu_assign_pointer(dst_slots[mas->offset], wr_mas->content);
> +		dst_pivots[mas->offset++] = mas->index - 1;
>  	}
>  
>  	/* Store the new entry and range end. */
> -	if (dst_offset < max_piv)
> -		dst_pivots[dst_offset] = mas->last;
> -	mas->offset = dst_offset;
> -	rcu_assign_pointer(dst_slots[dst_offset], wr_mas->entry);
> +	if (mas->offset < node_pivots)
> +		dst_pivots[mas->offset] = mas->last;
> +	rcu_assign_pointer(dst_slots[mas->offset], wr_mas->entry);
>  
>  	/*
>  	 * this range wrote to the end of the node or it overwrote the rest of
>  	 * the data
>  	 */
> -	if (wr_mas->offset_end > wr_mas->node_end || mas->last >= mas->max) {
> -		new_end = dst_offset;
> +	if (offset_end > wr_mas->node_end)
>  		goto done;
> -	}
>  
> -	dst_offset++;
> +	dst_offset = mas->offset + 1;
>  	/* Copy to the end of node if necessary. */
> -	copy_size = wr_mas->node_end - wr_mas->offset_end + 1;
> -	memcpy(dst_slots + dst_offset, wr_mas->slots + wr_mas->offset_end,
> +	copy_size = wr_mas->node_end - offset_end + 1;
> +	memcpy(dst_slots + dst_offset, wr_mas->slots + offset_end,
>  	       sizeof(void *) * copy_size);
> -	if (dst_offset < max_piv) {
> -		if (copy_size > max_piv - dst_offset)
> -			copy_size = max_piv - dst_offset;
> -
> -		memcpy(dst_pivots + dst_offset,
> -		       wr_mas->pivots + wr_mas->offset_end,
> -		       sizeof(unsigned long) * copy_size);
> -	}
> +	memcpy(dst_pivots + dst_offset, wr_mas->pivots + offset_end,
> +	       sizeof(unsigned long) * (copy_size - 1));
>  
> -	if ((wr_mas->node_end == node_slots - 1) && (new_end < node_slots - 1))
> +	if (new_end < node_pivots)
>  		dst_pivots[new_end] = mas->max;
>  
>  done:
> @@ -4379,7 +4343,8 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  
>  	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
>  		return;
> -	else if (mas_wr_node_store(wr_mas))
> +
> +	if (mas_wr_node_store(wr_mas, new_end))
>  		return;
>  
>  	if (mas_is_err(mas))
> -- 
> 2.20.1
> 
