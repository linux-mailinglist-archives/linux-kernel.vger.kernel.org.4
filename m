Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD306703255
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242587AbjEOQIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242563AbjEOQIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:08:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6FDE5A
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:08:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FCPcI8009553;
        Mon, 15 May 2023 16:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=N+3vXPOlvWLKidfgu+ggEr3oeuzYQ/rIVPhwBv/SRYU=;
 b=DApfqPDADRG066nzsSXcotjNnyv2cc96CbMfj8PDFTIqpgyNRQuPCYl9g+gD0/eWxkbX
 HwtWyxtx3U9aGvg4MJPPG6RV7//PXLzPSJpTTCnjN6h8zoSoG482lqYz2frmDORdyfei
 5fj+L1LgoaDJlic6O/dFXQ2oaQaheBXb6HjfQGrV4WI/SrOhXVPI4xexSnvnNiHCn7h0
 XKsqrwkAgb9DezhQMPXYYrdtAZNPWgxCl2PUuQBFgwaD0kdrAS7bo6jKAM8vPyhDgOY5
 j5j/No1qGiS0HqrHL4rviZ5IhWaGka2Q7yiklQR2IVzMwPRhm6zSB9jxBvLPW+8Y89VW bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye0bd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 16:06:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FFCNjD023021;
        Mon, 15 May 2023 16:06:49 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj102mbjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 16:06:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvIwzmuvvutYtm1Bx97v0TpXtYSUpHQ2bgPbCrssfmcCV1rKG89ts/QjjN/bQKuVBSPxOHQK+Bkti3sy/llGCGtA2NdG9UxRKfAYU7jCqIYBIlgreiteb6LD1uvos8wla7QwrYhcmFaY72c0IE1OaL6noCRcDx/YA7ir3Tq9IbFCnsKpkE4glhipBkC7q1LlGP7alL0Yk6tLADkZ33NVRKbFufqRcf8Lto/qdM0cmR6Nfi/PxZLoRG3oRLqJsrlWx4c4OkiBadpmbCWr283UiJ27ik8kyZj7QQNv5//QpO0zne0qrwUWM4Cl/oF2UdK8yVT3GouPYHB5EWpHeEjbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+3vXPOlvWLKidfgu+ggEr3oeuzYQ/rIVPhwBv/SRYU=;
 b=LlTaZz3xe2Zu3i3GFwWkIfymuiXfdgkoDoQl1d+vpMukTrmdEgAas1UABeddQ6AJrvX60FT/l8zeSncbPb520cfCLj98k/x/++RrEXkCMtoXEpg5ONLtmPgtlJUgnNf8OjWSOsosRgAjCBd8VFb+L7a25ifdzTauNtRGSEW07LnkUm1GMAY966WytNuOylkOvoBmVcQxDvilBl6UKbhQGzURfNlsFuCOugxabCMPYAdJQtmnSefJTSn+Zbh5jYUU8Oyh8n5imWVAW4d1JBtg0wSoyLccBykt4JSOy7rXHIMkCMxz25x0cm0d1NohQB9aAQ0LVlsL5drgrVEoghapig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+3vXPOlvWLKidfgu+ggEr3oeuzYQ/rIVPhwBv/SRYU=;
 b=OwveZgdAsU4dCtqhhMuRgffMmHwmKzucRUTMMC7Lht4Y8GqVKpW9mhvXrTYJK3Qn+4BORqb51PsLUjoIQRNRukw5Y5iX6V+C5Sg0Qxh3f535HgjBvftGpS4og01nK+IjzK9HosZbHSU9aqSFF+Tyat8LB20Gv7p6+MBJdssYgKQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5769.namprd10.prod.outlook.com (2603:10b6:510:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 16:06:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 16:06:47 +0000
Date:   Mon, 15 May 2023 12:06:44 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 04/10] maple_tree: Simplify mas_is_span_wr()
Message-ID: <20230515160644.lqhrclw3kcutsafc@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-5-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515131757.60035-5-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0333.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 0642db2d-a06a-4db9-5879-08db555e6255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBWB8YwHOVAT8Yi69Scnu2nMMwYZNYKPj6E5Npug77roBhCAJ5jPa/PH7VBQNL1KGcsY2lZtiC8MLgfr0+grjkNqEjrzJFMUJqEiSxo2vNAdtfuW7x/PBoauI3WS2sGCEDDgtF4ITpDgS4OjHInld+7z3rAVLSC8uWpPmVKYZ50SDTji7PZUPVQLnGNPcKtFvM343bme0BHWKKzWKVBCORdjES5G03lOIx4KYimXFx3Jgku+lII5uc5dyG01ZiAH7b5nE6wFvayaJPoAYZnRBSULM2RTmt9AMxbG1BDRTEEw1cuFBcryMOiygtDM/qlwz+6riMlNI0qh1iMIBJUeyu3d75JT+OhTl13vbYglMLOv4UKOe8uFn+WFZnUzkjtf/L/DFmXm4rvoQIejrRcyY4npMeU6s2dolhlb/CS2rr1MqSnMCeOkiUA01akpfK5bXz/lAlatmIZpVx6LgWpLMj7EChZ6sgUzk1O1Kx/3Wk4fGRKzdyYFm05TC9qkzDTlHVzVuJdSZvXwyFC4UU/k3UYPORoQ1dYhVI9Atwk432sDySdvyigjbhn9IC3AEdF7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199021)(6486002)(316002)(66556008)(6916009)(66946007)(66476007)(4326008)(478600001)(6666004)(33716001)(8936002)(8676002)(5660300002)(41300700001)(2906002)(86362001)(38100700002)(26005)(6506007)(186003)(1076003)(9686003)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gZom5m0xaOXoTEyfL9P3fmSfIXYCT8aFR6chxoxdwV5g/XS9gCyhZIoUgWlB?=
 =?us-ascii?Q?yTvEoy9at1/bCMXD0UPyOjbUN28B9fcLRHEfx+qEHKEZ5Q/pMzb5NHm7JUSh?=
 =?us-ascii?Q?f3lBGIahykae+LXIQcEIZnu5rtYnMWyrwqLBIir71yDfCypdTdiDU5SbOtEd?=
 =?us-ascii?Q?y8RQk8s3yB6lzyb5SuPw4SvxAFClimeH0TiBmpfQqYkOvbl4eMRCkmKjmia9?=
 =?us-ascii?Q?+sgVH7zpCZ8lt/s6ok6SFCbZlh+sjyn9kodtCTJ0meiNPz0/5P0PbEf14JYd?=
 =?us-ascii?Q?zWbsDlLLbDnbLabG8zJJ0sY8+aX1Tn8pP82GwUlU8QiFx3/dr+EZ/r0GBzTk?=
 =?us-ascii?Q?FPL0T8vfUB3izwH3wNM63reFI3Fra0C96ZEdQYttl6ztOUQ3KpKLQlupMBt4?=
 =?us-ascii?Q?PEtriu6aYyO7i49/DDHVeNCDMIf8vcWCwuOwscW+AD5bIxCErBqWO0Ae5Mm6?=
 =?us-ascii?Q?9nnBMZIUk0SRjgiU4NT4xkzu34lkg25XO+VTbsxzxmLdnLj1M+dOowGUaVwC?=
 =?us-ascii?Q?bgrLSwSw/WeA3ovzYT812gPU0weBBJA27FLF3F6ozRVo1H1IMIUlU3gSFuxY?=
 =?us-ascii?Q?2YMLkZoBK7CFs1K0kjCUIwaO9gWKaIJtqoj5l++HK2mHAVmtXPSdsj5Z9KMB?=
 =?us-ascii?Q?7EHc7hQYcXD9n7k6jNW7265uIAe0qdrbhW9fufk377sArue78/3WQL5cj43Y?=
 =?us-ascii?Q?qmlNkOGQzD6VuaXfJRyowvi7PTGSFavtClc4vP0MEIlWHlNz4T4BUlJoXFvc?=
 =?us-ascii?Q?kIA3DZ1qdoGPIX8Czt4+Bd83ej0f1QGXfJVCh8mwSfIQyxdU8/pOIbUVD+qy?=
 =?us-ascii?Q?Te9u6BOMWlCpknExK58C15QJ+LZwyeuO3792VBj4aWjwnIV31ovN1hfP/kMQ?=
 =?us-ascii?Q?uexanrzVnigBtXZw1pzxtlJ9qhgkz4/zyrVqud29qoYVwTbnwHEfUfr6gfHj?=
 =?us-ascii?Q?jfeKUjBQZXLZgHQOhxtuNM0ZDymIF2Sl9Sbg3FUY1kUThvKN1cnMab418kiW?=
 =?us-ascii?Q?bMen07mI/LD/YxTny9cD0jWwo1mYi4yq/IKrb4B7cs4D57B8F/Eh/88mgLlY?=
 =?us-ascii?Q?IgsgASgqtAMv0dwZJPCYDdGzs/KDr/lDbAXrgAAoLaGXVrw1D3D9pMXMxcvI?=
 =?us-ascii?Q?XvBJhTfQ+Q89s46Yh829TB45lkh57cKKfhBp8FuoMNRG367B7Nm34XdvK9rV?=
 =?us-ascii?Q?YRyGGZihSvV3hdBkNE7dvTEQMd+lVozN0QTsiKxwow1wbj+PzuINLMYh68gg?=
 =?us-ascii?Q?V+6itGcktpfRlxSc/BSr7eCSRAdlhdSBBvks/GpJxkSTgdu1i8u1FBEv3vqB?=
 =?us-ascii?Q?9UEfisjTda7Oxmj0UxO1TthZHo9SiiFZFAZHX5s/GuFCwAbNxTnn/Rtmg9FR?=
 =?us-ascii?Q?Rk680pmEY72vFzZ2CPYtinvjWu6kECmYO1VWKXwe3kgeQC7hunPwTUWrVJ5s?=
 =?us-ascii?Q?v22u1ttqY8PHK5XvGdJSKf+UDud7KPKU4Rh52T1BupXMG7DRuU58GvTd7a3m?=
 =?us-ascii?Q?8kqrf1AQUDVDtqzHZK/vAI7noDNuUn4qm8Py2ctRSi3d8Vk5SZRk5r9eqc3z?=
 =?us-ascii?Q?CYS2ZjdV0ANMKXNHSKr4HGt8E0AMNvEkSDzZxesU2OcfQK1qv9a6vbmh9N4y?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ey4vtaRuUIW3awQEnBV2ynvNcEqDdxbG+7tAD24623uDXexl8v3AYuY5j+Jw?=
 =?us-ascii?Q?1t5ACwX1Vk8Ieyq86WgL9N+vHzcu0Su4J8iW1CDoR7YFaHgXBKSXe+gB3Vfw?=
 =?us-ascii?Q?bjtrECCmAs6CCfiyjFy73dgG08iS2Mv7QBOvB0QWZpWwovIfROyQtKM8m7ps?=
 =?us-ascii?Q?pOhbzdu3WG+xIfGoB/AfSUdhWWVcIV/3hsK1v+6ds8pZGTIfLoxYT6Jd3qZD?=
 =?us-ascii?Q?Ie38lojSuEWZt1Z5c6slo0Vjg548yPnwBNKU0/YHRIw3XbltdPe1v1htKehb?=
 =?us-ascii?Q?KnVWPXYrFX07pTB2G+Fcow6B8f2VI8mafZkmWgd5w+ng8eU40ditq78XhVxB?=
 =?us-ascii?Q?2u00muWw+8IKERfDUZIUGmr06wG3bfi9QKFrYEqltM73hNKqwkYYO1M3Z5OF?=
 =?us-ascii?Q?51vV5VVfXDPcQ3ONvlyQ6CSabEsYIfb1F83aMY1oUhBMqGjsdj/RkJmTfMDx?=
 =?us-ascii?Q?iwF+CJ/1a7tvZte5owq9EgV8r9TP5mywB5lacbMHwHeGADl2jkpPNjWPwPDn?=
 =?us-ascii?Q?r7GDh6p0PG3w1VLc0Qhgc86NgIWwugqjTnmZrxd04fL82uluAxPayKlvIqAB?=
 =?us-ascii?Q?N1qjuoGwkT6bb5Zmmqzx7BU6rfI++BOAStqSoVV92D5ZCdux9FVV1oLQy9lv?=
 =?us-ascii?Q?9JYXLDkFrMbnPDhTjrZyrj3dTHLzM0kE1FpQHwQpzsQQFFwU/qu2qlQPBncz?=
 =?us-ascii?Q?5eUvAwc3FruJYsHWl/MME6DTvLPXRwKzV3D8wlZ0gUeCguP5gP6tQd4yz1nU?=
 =?us-ascii?Q?C8kcYRO3/L5DuZN+20TQsMzz6pu2qtk71BK1gRaiYM3KSKngpF8FXX6OSDgS?=
 =?us-ascii?Q?OOCd8we8SyT/7pW0QfnMNgjpIStujQgjBCPTd1UiTSnlQLxGzJ9hy15JvEjL?=
 =?us-ascii?Q?vOmB50SF+NRUF8Yw2Vr0C+bHEN4Z6m7Trf20qIhHEesvQw4Eenof/Yh/+F0U?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0642db2d-a06a-4db9-5879-08db555e6255
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 16:06:46.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VdHjg0O2s9jSy4U73i7mVdjUn0yQQs1xkYmvoDWvPxVP+egrADcuiFLQPbr1065bQ7pzq5bR8UwPKMs6F3u7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=515
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150134
X-Proofpoint-ORIG-GUID: lFhB06pVtjE2MS5nD7xdbuz8o-ZTklpj
X-Proofpoint-GUID: lFhB06pVtjE2MS5nD7xdbuz8o-ZTklpj
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
> Make the code for detecting spanning writes more concise.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 36 +++++++++---------------------------
>  1 file changed, 9 insertions(+), 27 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 43a25d3042c1b..fbb6efc40e576 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3728,41 +3728,23 @@ static bool mas_is_span_wr(struct ma_wr_state *wr_mas)
>  {
>  	unsigned long max;
>  	unsigned long last = wr_mas->mas->last;
> -	unsigned long piv = wr_mas->r_max;
>  	enum maple_type type = wr_mas->type;
>  	void *entry = wr_mas->entry;
>  
> -	/* Contained in this pivot */
> -	if (piv > last)

I test this first since it is far more likely than the rest of the cases
in this function.  Most writes will land in a leaf node eventually, so
this will be true most of the time.  I'd like to keep it as a fast path.

> +	max = unlikely(ma_is_leaf(type)) ? wr_mas->mas->max : wr_mas->r_max;

Please expand this to multiple lines.  It is better to be more clear
than compact lines of code.

> +	if (last < max) {
> +		/* Contained in this pivot or this leaf node */
>  		return false;
> -
> -	max = wr_mas->mas->max;
> -	if (unlikely(ma_is_leaf(type))) {
> -		/* Fits in the node, but may span slots. */
> -		if (last < max)
> -			return false;
> -
> -		/* Writes to the end of the node but not null. */
> -		if ((last == max) && entry)
> -			return false;
> -
> +	} else if (last == max) {
>  		/*
> -		 * Writing ULONG_MAX is not a spanning write regardless of the
> -		 * value being written as long as the range fits in the node.
> +		 * The last entry of leaf node cannot be NULL unless it is the
> +		 * rightmost node (writing ULONG_MAX), otherwise it spans slots.
> +		 * If this is not leaf node, detect spanning store wr walk.
>  		 */
> -		if ((last == ULONG_MAX) && (last == max))
> -			return false;
> -	} else if (piv == last) {
> -		if (entry)
> -			return false;
> -
> -		/* Detect spanning store wr walk */
> -		if (last == ULONG_MAX)
> +		if (entry || last == ULONG_MAX)
>  			return false;
>  	}
> -
> -	trace_ma_write(__func__, wr_mas->mas, piv, entry);
> -
> +	trace_ma_write(__func__, wr_mas->mas, wr_mas->r_max, entry);
>  	return true;
>  }
>  
> -- 
> 2.20.1
> 
