Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988256EE650
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjDYRFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjDYRFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:05:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB44A5BB1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:05:20 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFxZF7016391;
        Tue, 25 Apr 2023 17:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=J1H6LM60cgVl6WSXdZTZRcYWO9FVta8H0qVGoDZHSzo=;
 b=0WHzxFuu3DDhdl9IYaV9RuwNiBe3JNP7xrAjw3c+KiTb/ef/f3IpyGQj4OgMq6QvPQsS
 jw2Dv9lLYiar5+eLSiUVqzBaO1F7g/VAom/0XYMfnPezVRl9ka96DwmKsNy+tT+G/0rF
 8BO/tvCYJLTBb5AIUsCWlBB4KeFUE2brOkHHHbuMte5sNR2ADSsVYNf7wXda9oefTJUN
 NRrcVlrYR4hUYtL24+MczfTgzTFgW+qoweRd7EHvvj9IN4n/gx/XFj6/8vQq8/LRsHtb
 D9bE95tikz/MtGI9KLwX0St+z+7A86+5VtS2HyV5Iq67QR2d+JCzh6zaEG4Sc77iOVj+ EA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbpf9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 17:05:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PH2GHr024980;
        Tue, 25 Apr 2023 17:04:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461d0fxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 17:04:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE8XTvrMCktqpujDXtCpljbFp5STK3q+BQRc1aHTSKwRSSjzqHTLO36bJdXoYH4KWmsjfDgu8vWPX/k2Jq1MeIXMrO4W7o5AvMKIDtaHP71b1hV0mb2RvXCMOt71fUfCAP98c3h80rfJc8PgwD9wgigpJofa9VtU6wjRl33h1RLIGjIIICHyiKc7J8JzHUuRPG7bUyh8ISootHYlHYSXxa5nV8jAwHbvixzkezbutaW6hoPn97BodGxl6r13g52RIvas//C/DySOTxnqAOJeUYOaCaGfiO5pgQy3cyzd6TaORBuX2rnGjnflP9zzQ9Tm0QfIoOezJwsYfcQzR9KWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1H6LM60cgVl6WSXdZTZRcYWO9FVta8H0qVGoDZHSzo=;
 b=gjr9p//zRWIi/LbP9p+ZBrzRuLdxT+zBy/UFm0p/t1ENKhjVk+U0ZyswLwfZlgr3XTxjOXyAv8iLiEH3aQzgyCdH0Ej3/tZz/o1Hoazjji6VVjcVfRIrxyJ5pwwT/0pBJTpYAqm9y6aA+GNcjwgcMKRQdI4cBOECQGyO2ai91wQ9vrXtZnOR0r7sJdxTVVyhA7g/Qmy8TTZRcRbr3Ev9Wnk89iz2Q0yEzKG7UCFX7+34HOFlKBaIn40eSIMzWs+MqNvIeD0W4qUewLAlKl8+kAQtiq6EP4PSPVJDupQJh7EIHE1b8DDG/iLQnSL1auPbe1Kr91nk22uQyO6kcndZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1H6LM60cgVl6WSXdZTZRcYWO9FVta8H0qVGoDZHSzo=;
 b=WooeX9UekjC20fEckOSzxfkZOVd+kMBIyF+pDGc9rvxgvTUXq6+ivFVBcO7wPQppJcUOW+qRnajGOJZcbPYlrC4il+y+cH+CAGE4PXV+OAtKHfAY27i7HNCY8HFoJnG4vi00qxnfAJHO8X/F/4r3S0udYXVJGEjljYLsBd2XtyU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB7108.namprd10.prod.outlook.com (2603:10b6:510:27e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 17:04:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 17:04:58 +0000
Date:   Tue, 25 Apr 2023 13:04:55 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 9/9] maple_tree: Move declaration of mas_empty_area_rev()
 to a better place
Message-ID: <20230425170455.rhdyyexngpy43s7l@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
 <20230425110511.11680-10-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425110511.11680-10-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5e9916-7b9d-420d-88a6-08db45af32db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dp8EvAIE4moOtuFFftySXpAtrqWRNBxBBIyV514+MOlAdRmIx1THFpQ6QqmU5Y1VM/sGMXm2IfTqxFTvAzqcgzTBM/b80Mw7iLz/TXGJRVsoe7TOQa+S2l57RpY/xPvZjGG2jXNL2uA3toLTygSPlsb4r0n0Ik9cAz8aSlW3p7WXVTI5bqx9LIbNm4WaKTo8ZnOgDq5xlGtEgXgbnKMOnj/9hSUka2FllcvN2QiukZshQmLudqhEq99WjqqKyK6BIU7mjXr2mm4SVYOus48cXd0AEzT2aOzoKN6CZo6noSucUfgUW88tBIeWLeWSrCfWRMqL8aw7c83AUsb4NPkF9aWl41f0TKgY3rYzWoPdQKn/pt+0FVJ/sBA4u4GL6e2n2WBtWsRdezG6UoW7zsiz/Ua/eb7q9As0P6rY5MOh//v5y1cX6pmTnw9rlXMseP+k7dS1iZjo5Y2Di3I3fbHWyH7RfoOGTxv8Z2MhwQcp3sFUPc2MvMdUkY7nvHur4FhTzZ/Pl5bTUWHOOi6Upgslgc6652fB8Bz5gzvL28MNngfTTYcM19WiPFHzDW+bhB5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(186003)(2906002)(41300700001)(9686003)(6512007)(6506007)(1076003)(26005)(6916009)(83380400001)(33716001)(86362001)(6486002)(6666004)(8676002)(8936002)(5660300002)(316002)(478600001)(38100700002)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xw8UnkttnZPFMi2YuVimVeMzcZ2SM0NSAT+Oeop0V/qmCeDzMWb0GHrHuPd7?=
 =?us-ascii?Q?JY+cvYlrmDWVL9NIntVisv6MG549wCZ8HW6XK76WnaiTlFYj8l8LjLGMYAqq?=
 =?us-ascii?Q?oDDzSN+8bgn6HkGkk2zYw0lfbOTpNmtWGrE8m153GWcu5Azq0dNLABJDeZG/?=
 =?us-ascii?Q?WN6XLjHHggm+YZx1lss2eafxYuIqkN34FiENeDErRnbuAsWbstapPEN4GRiP?=
 =?us-ascii?Q?id3P5CaY0oddi8Lm8OA2hRssIzlXNeLRgY7wODYNP8D4nOrGJ8nR7BGBv8Y5?=
 =?us-ascii?Q?Vlq508JWRbA/kc0+ePLhGxtI0g/fQatGAsk0YPZW0ipbAiv5D0hIQXaO4MU6?=
 =?us-ascii?Q?q7/hSRXSM65ZZMOZAo+5y7tir63c8ywl8SvtW5RXEXSjEMrIoedrjyt+RKt4?=
 =?us-ascii?Q?A1QbHFFgXApnOm8nWJotRYi5T20fKVo7L76iI7Xy0Z7z6Jb3oN2HQbQa4P1y?=
 =?us-ascii?Q?L1dPuZ+fFs7YfvKyK/3ZyqLC+LGYnV8bRGs9gZc/LGHyCAbLfHzxXSJD3tYy?=
 =?us-ascii?Q?V7UuK60uq5MC0XDHyaswQeE1cAeNaQEqOyxaEr8bRp/r3qaB5RMvE83O+Wgf?=
 =?us-ascii?Q?O81tT2gM1V+wynJdOdSluvNS4Wi5t4Df37j8mHUyZiIpPsNS6pa4+2V8JWhP?=
 =?us-ascii?Q?lUVlBcanV8BAjbNxsLwtAT2HyCbSSJ6N6hmRuw34y6kRSAd77yTOjde0ynoV?=
 =?us-ascii?Q?kvpXp9Cpfed84q6ywIg5RZVtrRXPY6ADe3rgJJp2wbHitUMzjFvtymV51Sol?=
 =?us-ascii?Q?qwAbK+TOmv1AdYx0nyxJ1/KwX30BkmnYdJHiOy4vxluhCE3bRVpkiwBjkO/t?=
 =?us-ascii?Q?PeZv+zAKzv0C5jFJiJB2j+AO67Q9QD3FLgqK9YCF6Ojw7dvzX7k+1HmBAdFE?=
 =?us-ascii?Q?Fjjc6c4CeVSiOuPF/9rJetvadL0dTtv6tYfp52By3j/tvA4t13xEzmM0XyWG?=
 =?us-ascii?Q?2hJwlJbXMutwsTNNUZxnkKotle/4znwrzqTriMcWoFcjAwyYQnM53w6ofWLv?=
 =?us-ascii?Q?32cTUH6CieKgOJEgHn0NxTSBBC6Kh9va2Yr+/VA48WMPSlJDNo4R9PpOiUPV?=
 =?us-ascii?Q?av4ebhy9QVsQQwI6BOVXDG2Qs3oKppG7Krlj4agq9DDNyEucluDtYcPdUqAV?=
 =?us-ascii?Q?Ha6CXBnoebZOJRfd3KpmhUgKASsvbF3rATopd78M7YfBdn5Wc23v5p9zEw77?=
 =?us-ascii?Q?mAyGduOqwfLLXVkPt2s7h8h0GQa2qXf9CL+p5F0Ru8z8kImq1UJEykSCYjt4?=
 =?us-ascii?Q?KJNZhFMc237DRSvOoPQyf29fT2+LKDgMKjgS7rQ4ZA4+YUeVlNjjJ5D5Bkwj?=
 =?us-ascii?Q?7udqQPf4I+1rhdTjF6+BJ8ibuMhLSNw8PBujG2CU5OLOSwgeOh1n3yK8rUx/?=
 =?us-ascii?Q?7c3ZGmrFQMyeRcMKu/LzepveadpmVxn9fyHyvKdSm3c4hXkDmuc13LDg53J/?=
 =?us-ascii?Q?j7+G4lhRg/UVA+ZziKKQAHRcXX0Yu0cq5sWIMmhp53nj9isZ5RCO6SQARa3H?=
 =?us-ascii?Q?c6oTGTdhL11uOPXhyHExS7JHUXq1iusr+GxWB+5CpgWMVbdctFLaqVDgM3Bn?=
 =?us-ascii?Q?8WaaKdeKZS5wsAocAbixqOI/AC1qm5W0bNpgoBOKliWfFpD765fk/cJR/LB8?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pvgF15sLovaKtyM8G2MdAP912l5aHCKGgL8ChLu5Ls29RIGBc8TvU0qk7wAp?=
 =?us-ascii?Q?8t3VQZL1uDRtwaE+5qbbbrwjDLsV9WOb9FEX8RSfO9EhcTOFoohnPOX1vQMI?=
 =?us-ascii?Q?30w/EqrHSJYSN9vdcFnfpELlfsJJNkwew2a3EAHJcc7wy0jN8/QwP39X4ke0?=
 =?us-ascii?Q?JSNpM2hdXwgjXCpwWUlGBT4SZRiYFFTm6nqbMegkfzS5UI/4jKMd11hT7w/J?=
 =?us-ascii?Q?Yk3FxRJlWcO/ATm6IBQJqHq39mv8Nkl2Nhoid+ov+jx8Im32AZgtE7ZgQ6uM?=
 =?us-ascii?Q?qtGpErHSxDUHG1inuN/os2AqnT4/QMiiEhqJhmTNn0FdGmXpGkrd+atjWPaL?=
 =?us-ascii?Q?VL3HWuTQvWoQZbfj9g/HPOXH2VVkHYql06zm9ShqdCfBOiHZL6zapByDhooD?=
 =?us-ascii?Q?z9zNpZMJcoamXCcXtZu8Ka9w09HcrHdWEQ5nTiTmA9Z1BL/LkuS6MBRaUBvr?=
 =?us-ascii?Q?7i/rQmUR4ppnn9K2B0SpHnxi+mMi7ooOfGALY7uo+vvYYtpdOQUllvdzaqSz?=
 =?us-ascii?Q?bTjltUwi9pC+FfzcHpRlx+BVYGJkFYcF/Wdiqjpz3hfzd+Bu0rX9+4HuZd6n?=
 =?us-ascii?Q?c6IPSIZiHd69E/UvwwBUNudhTANRZS+vG4IzstLRERTJNvK2OGQ3X1r+x1h3?=
 =?us-ascii?Q?01w3V2w/TiX0oMVNE/xFos1V/LbymYWeKLBJFSEvCqciMWmKtFOZYUuoBKMg?=
 =?us-ascii?Q?+Kqr2c5U9bE2Zg0QV8p1CVD699JRv+l2gCLceQ059OT9fjm6rFbh9wCGDnmt?=
 =?us-ascii?Q?DUJyDV8SHPWkfdgp1l+0d+fizI0Zs/W6vGCUpm68VWuuteDIJwatriUjY4zd?=
 =?us-ascii?Q?IbhDHV0JGzTm4qTUFvT9cbnrx40jyu/c5iO2DcxttscZ5glmGXPv0J4JlBJS?=
 =?us-ascii?Q?3xF3N43ficlGm7/xFv4CApflqwCbdWnxB2fJi2v77uX+436icgiGlRcuufHn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5e9916-7b9d-420d-88a6-08db45af32db
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 17:04:57.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pp12KMEt3ps5QQyxJufiUkoVeHdIPp1zebaRTbnkX13dazcX+u13iixyAJoX1WzldxOahiz5fikvENie64tPfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_08,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250154
X-Proofpoint-GUID: F9foxN1FBmBTWUi17IEHS8c8vbAZLUaz
X-Proofpoint-ORIG-GUID: F9foxN1FBmBTWUi17IEHS8c8vbAZLUaz
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

Can you change the subject of the patch to remove 'to a better place'?
It sounds like you are killing the declaration and not relocating it.

> mas_empty_area() and mas_empty_area_rev() are a pair, move
> mas_empty_area_rev() so that their declarations are together.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  include/linux/maple_tree.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index 1fadb5f5978b6..3130c1f822ddf 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -470,6 +470,12 @@ void *mas_next(struct ma_state *mas, unsigned long max);
>  
>  int mas_empty_area(struct ma_state *mas, unsigned long min, unsigned long max,
>  		   unsigned long size);
> +/*
> + * This finds an empty area from the highest address to the lowest.
> + * AKA "Topdown" version,
> + */
> +int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
> +		       unsigned long max, unsigned long size);
>  
>  static inline void mas_init(struct ma_state *mas, struct maple_tree *tree,
>  			    unsigned long addr)
> @@ -493,12 +499,6 @@ static inline bool mas_is_paused(struct ma_state *mas)
>  	return mas->node == MAS_PAUSE;
>  }
>  
> -/*
> - * This finds an empty area from the highest address to the lowest.
> - * AKA "Topdown" version,
> - */
> -int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
> -		       unsigned long max, unsigned long size);
>  /**
>   * mas_reset() - Reset a Maple Tree operation state.
>   * @mas: Maple Tree operation state.
> -- 
> 2.20.1
> 
