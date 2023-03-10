Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3856B50D3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCJTUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjCJTUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:20:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D711219FD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:20:34 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AF4J4f030212;
        Fri, 10 Mar 2023 19:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Oa5oJl3fU4Z8UhpmWH6vuogsJzBAPvgC7dsf6u0mU5k=;
 b=eG6JYmxwMQp+E+L11NB2al3H616i1fr+PlTv7A7gJ+XzGk/ei+1U0JZfEM5U75VGQdaJ
 fdzCV3dMiEzclpGwkEO7biiG9CXEoxXv2N/Vpts86DrICdoir6MxWo4A8m2Yb8dT385i
 DjxVndOJzBpBDWUpVK4qKAbXD44evIra+KcQH0L45JJh3RA+zIujwGbBtXbSEG5CHGEj
 x+w/Sj2GEqtwjQRsy9nTOQuUvvQ4m6kpj64ybf5QDzADcBxIsRQh5jdbsWkvcAze1Kr7
 J0+5mmr8FkS/He8CmWR0w2K+dZNotLDGu66KESw0lqI722ubMr8KHi2mkD/goHgZPiQ9 wQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wx2e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 19:20:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AHXFPV034932;
        Fri, 10 Mar 2023 19:20:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fubacq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 19:20:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsDZGfQqnpME+/PMaoewkOhAWn572o8UO2R/oMeGcVM0LXNkQIzVZlf0rZYKDoNsLBcv+y8ekdDQSzyui9N7TJt4hCMjx+UlpQZkjjhjQUcU8gLXxI5+6DvWDuMCIotgu/4kKdj8SvKUvdJwrIkvTor54UTdzMhDelZaqh346mhD+kpcdYo8NxbqY7aQLarizQnq3rhA/Rkw8C8XDWEiqFfkPjWivVcX1z5HJNSE4t+lnIy6HWNXZqvHyfeIIaLN2pyRMIMSO3OnN4hHBGkuF/NLuIXUdkSqJ2b/sZa6GKLM3cVdN8Cw3yIkiSND7Wj9aOTqIo1uYibjQdAf4KDzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa5oJl3fU4Z8UhpmWH6vuogsJzBAPvgC7dsf6u0mU5k=;
 b=BtGskAnlLETf3+a59ClFmNN1mVaxujviWA1bM9OkaplmeRQneNhmJsuAKzHDeCyb+z1zSsEVMtH8FMGg4EnuBq7le/KVuVfsN017GdrqlCPyUvherdW0NXHxRxRrUTq5AzcAz8dOzZbxYTALe08/I4ARNQOUs1qZaCiUFZHwlFrpXj2wGuurhRYxsSy8qR2W1DgdR+hwkWGxEKCZ4+3THXHusZfJZjfbt7pp6G7AgWxJVsjrAcoYp+qdMZnywj9QgyfGKAKtrVXJypk/DpVgmVKYD2tl4G9Sm0o3Uj2RGDke4lyebWKritoGGhhFdji4NCOpc78VrSPoPh8W7pdNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa5oJl3fU4Z8UhpmWH6vuogsJzBAPvgC7dsf6u0mU5k=;
 b=YLVSMsXWY+n1/rL5CckG6ujlo53zDRC409PGhTNxLp9qpk4SCPsEnmxRXxr4fkJLcsxBE9mh0LcGDJep1MY1q7LFGtPKr6ERXc6K+Z5L3GMqAxPooQ3oy0QgW+7N7G6KtHeJLp0AsTZPdDwe+mYriZHkpRs5OOZSHMbZI8jryC0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6236.namprd10.prod.outlook.com (2603:10b6:208:38f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 19:20:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 19:20:06 +0000
Date:   Fri, 10 Mar 2023 14:20:04 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 2/4] maple_tree: Simplify mas_wr_node_walk()
Message-ID: <20230310192004.iruharoxh5lajg7g@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
 <20230310140848.94485-3-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310140848.94485-3-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0238.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: a516258e-de5f-4cd4-27f9-08db219c74e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wNhbisAWNWolfIkugai2lJc+RSgXwPh9PoAAaOqJ5q9DPiCTeYgMQ8Uz6XfJSIX2rbzltU9qElRw1CzRP8lL9owwQ1wl5p3vyAEvrr6QS1u7v1GQQoGRT4WeZAZ9xd6APEsk0EASNthL5pbTz3H6L0SDduiyYRCuR6i2qg+yeDQQBqXKyd5n+O0aa8qBEZXGZyU8S9Ip1M2IoK10Z2jcLucPVtEeDGulK0iOh46Qrkah7CZmmMHoaW1oM2//ERz5lCqngWv8/gkdzD77QP/+5BRNUVz5gR/fOsBTJuGTGWUOAf/aKGl2PLDDLu3jZEAE9Iq+NNQUfthI64TgZMOcCWJkcLKcGURF3WRp7TiuShKUvj+j/KnIc2n8pPfBzSbp7KO/Mg2JIt8T/5Y909Uwq2FvqiY6PDPi49uQcvZBDl0Jl908ABqe3V8B/D8MQdV8Yv3WuEbPpROPcXgzznMOqAut08+PdijkfAntf9vM5eiEussDCQD3mzFn7uRiO/C857hz2yeGK7odAChuVjmnTD7xjmRskvx0nVeQYFZvirX7z1MBGmofeM+L9ABOvIwMS3XNJuQAYJlE5igCRDENNWaALvcq51mX0Zsj7GfuaaUXyj1HteKD9grmO2hvj305qVN87/gZFdyTJxz421kSrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199018)(41300700001)(8936002)(5660300002)(4326008)(6916009)(86362001)(66556008)(66946007)(478600001)(83380400001)(316002)(8676002)(66476007)(6486002)(33716001)(186003)(9686003)(2906002)(38100700002)(1076003)(6506007)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8fdeuPkKv+9nOAJLZSyyzhvTqEwcTLGnWbB/c4SyH7LrYgQo1UjhYvMHNgYd?=
 =?us-ascii?Q?VzLVgJHovRuzBPcpEN7A20QnJQ2/ufzUBE6fQQ0eBIksocrVOnbiOQcnhbOb?=
 =?us-ascii?Q?e4WchHJziMIOwe+eynIASXLjDaBOGNvZCqfHPzWAEVzeWTK3qGl22LdZuYpK?=
 =?us-ascii?Q?O8J54MUGQ2MNGANhB4p7b91YwOzHSjAMAzj2/YkMfmBLnGu0rgev2UvY/Nms?=
 =?us-ascii?Q?p7mytKK7g3ZCn9w+5qeKUhB1Zpwk+7XLzL9EVNgnCUUeMlB/dFR2mUDxA1r5?=
 =?us-ascii?Q?sRewp7IaDHwhbE7+ftDkWTsp/62l8N845gStLHJSJutrUuqf9NhFY0Ac+1E7?=
 =?us-ascii?Q?k7eHrpr90uAPXPdVVxFx+xGJ6AmtPTa69fFmsHPyChQr+eTL50MkjWb303c2?=
 =?us-ascii?Q?OVzXCvjBefAS77cWq7BOwF9Q0ftwvCcJ7CjmWRgPSDprOsihxdqZNhYkuh6e?=
 =?us-ascii?Q?1hP0KMfXfy7qwtMIxogxIxru1r0XNn2aaDqun6GIZpx76CoOF+73qzRASc4C?=
 =?us-ascii?Q?YHk4yxbJOtgo1f7r36c0+3b+9cxWnlHrp17Q5qWtHuGvHTAvPL6pR05q6X4N?=
 =?us-ascii?Q?A/2WaMWn0bnW1GNS19WLNEBy2BRfjdglp+pXLIh2KgZm3E19iM44bNlfYKjv?=
 =?us-ascii?Q?YY/z1ccd5pa+0htABJ/JBTpJokFVxlo0xYfPvou3eNAeGc4t3JFF65Hlb/yx?=
 =?us-ascii?Q?9B2YTutsrJx42XjS8D541TFHbOyCBS4AvrVJCBp+hDdU7+eknJRJ1hLja43k?=
 =?us-ascii?Q?kaUFLCIDerxQrNb6qlddAaP+P2s5STLjZ+JPDp3eyKHWUiI+URwPe5evzE2J?=
 =?us-ascii?Q?Zbwu3QnY8c8pglLvkSklxplCV7Nf1GqN4LnHcdKMhr6RckMyS5/Mrc5uLgXF?=
 =?us-ascii?Q?2UMLuukW7VEiIVogs4UkH3twKU5aEhpkaXgiKezQE8NkrFCwSoiZwZ0gHl62?=
 =?us-ascii?Q?t6GqXtNd+wS6lo2w18xDIZEEandqLZHOwEZ65cqbdy31p927iWiy1vmkH11i?=
 =?us-ascii?Q?r/ABQQ7TNHcB3EG3dJdEWxAMxUkz4yWZt5+/KmcsHl13NKfxEITivqGpTb//?=
 =?us-ascii?Q?TgxPHD72S15ZEepc/PbQah0ExQHbz+FKeXWK2hRW1mPndTYGcYfek3oXfSEi?=
 =?us-ascii?Q?MYY1trFSVMkb1wn5LuEwoQFCXHrU4gT9r6jx42UJJTRrCSiHyk4QKb4F1aeu?=
 =?us-ascii?Q?eiTjGvhKX7HL6uAWYB6/uBpXfXDhQFwgDgAgUlsV14kdzapVcwzPkQNCjVNC?=
 =?us-ascii?Q?+ymZLXT+cWzgWZbHeMifi8vCr94knIzn+a3Rt7bDuQmeYdb4JIC7f7WlRQN4?=
 =?us-ascii?Q?rSdnAVwwr0O65yWM4zuKtgCJJobUKFOHJbBXTVaZBgPJD6q/tIObVKCBGTwQ?=
 =?us-ascii?Q?DyYGMcZK3sXQmIwpHI4SEnTHzNoQaohINxJQ1m/EFjP8bpY8FhFzPW/Y8cjD?=
 =?us-ascii?Q?iBqLZEtPVwewJemA23AJfJPcWF4nOC+67apkTFG/hevq/q914vzHb7+8WDEO?=
 =?us-ascii?Q?GXu2eekU3ZnYdOofh/ouTzxeVmFzt6PB8NN0/bG447u0c8gPzwlHC6xLC/JY?=
 =?us-ascii?Q?NHyV11fHFmEUXBjabjo+zFqlToDEju8ZvgKQkKTjPctAtu99lbKJ/5R3613D?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AlRtUbxRdTlwRJKBKTgiQMxRzDbQvk3geCIGTJEK+2QEX81lPvdPjDzNO5bsy1TlZFzRyRAngVyQCjFi/b39nTT88/6VsZHvxcrW63OZr73+WR3gMCMZjxTaw8dBKBveZnGuU5mgXlLb2x3uGJy7jJ8w/0gcGzhXXsIo/3+MWtibqETROygVq36QaOaszH+PzOd/4OjDealqK0TTCWy5Va9+bpicSPkRyEvGIKOcX/a/vBxQfBoT7qK3pjtUcgy7Eyebzi9rKkJOTLZtoC50MhbF7WvuHbJ9fivd2keZx1BC2gec9SwEa2bh2xr1LZwicsIn1/X6yZZJIWpp+rbzfbasVOsisupfJR326EWy3WxOMFkTh/JLxIpJLzuixrErD6qFNOLZ8JNbCgk575lOddO463G4BDcGHG4rdVoa55ykwHCIHvh8dBH9iOjAIoF2UQS0uBk0HwghsnFlQbn2ImBQ6Ik5l0opfNVBuJhrCS80UTtSt8VKvhKGF8RhL6ZigxOPrPlO97JgZ0L5msQVp9Z3pHbvvy7Yn2tkyMlIDXcdeYc5CBPsUY0gCJGxfZ5yLL9GKmDXle8/3PysOCccnIqIin5K3N70wR1Zv+Sq03k2YNoJGRPqZlLaG/JeaM7LcHV5cQ31NL3zBCA+Z52zGtlAGW/tUo37I/RjYybUc9cAx41uVC1//uL7qR/kLjVKcfeDXqKA1lCifkg43/aTgyQrNcyMyeiUBt/1LzjqcpRZhd3wDeuOwVobtToY+tr8pgq2R/NjqlYiqoh3TcsG/il6Iq9rQVTS+Z58pZfvZ+T6pX4pZMOE5x37aGu73W/HV35NSjC4Lbphpv/8i8LYpEoHudChcsWJK9POvadWXhEj3b56HMKHC+ykcY2DY+BL
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a516258e-de5f-4cd4-27f9-08db219c74e5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 19:20:06.3940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZJLzCPlUuIbqp/n8NfWZiz7+8oTX6GlaMBqOOQmTB4GQ+wVjzpaX9nC7AN+Fovy6ZjqndBI9vbjbsMrogWHcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100154
X-Proofpoint-GUID: jW-nx7-7sHPjRH2N-zeYNSpapvh5cbUI
X-Proofpoint-ORIG-GUID: jW-nx7-7sHPjRH2N-zeYNSpapvh5cbUI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230310 09:09]:
> Simplify code of mas_wr_node_walk() without changing functionality,
> and improve readability.

The change log needs to be updated to 

I like this change, thanks.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 34 +++++-----------------------------
>  1 file changed, 5 insertions(+), 29 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index b3164266cfde..4d15202a0692 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2251,9 +2251,7 @@ static inline struct maple_enode *mte_node_or_none(struct maple_enode *enode)
>  static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
> -	unsigned char count;
> -	unsigned char offset;
> -	unsigned long index, min, max;
> +	unsigned char count, offset;
>  
>  	if (unlikely(ma_is_dense(wr_mas->type))) {
>  		wr_mas->r_max = wr_mas->r_min = mas->index;
> @@ -2266,34 +2264,12 @@ static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
>  	count = wr_mas->node_end = ma_data_end(wr_mas->node, wr_mas->type,
>  					       wr_mas->pivots, mas->max);
>  	offset = mas->offset;
> -	min = mas_safe_min(mas, wr_mas->pivots, offset);
> -	if (unlikely(offset == count))
> -		goto max;
> -
> -	max = wr_mas->pivots[offset];
> -	index = mas->index;
> -	if (unlikely(index <= max))
> -		goto done;
> -
> -	if (unlikely(!max && offset))
> -		goto max;
>  
> -	min = max + 1;
> -	while (++offset < count) {
> -		max = wr_mas->pivots[offset];
> -		if (index <= max)
> -			goto done;
> -		else if (unlikely(!max))
> -			break;
> -
> -		min = max + 1;
> -	}
> +	while (offset < count && mas->index > wr_mas->pivots[offset])
> +		offset++;
>  
> -max:
> -	max = mas->max;
> -done:
> -	wr_mas->r_max = max;
> -	wr_mas->r_min = min;
> +	wr_mas->r_max = offset < count ? wr_mas->pivots[offset] : mas->max;
> +	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, offset);
>  	wr_mas->offset_end = mas->offset = offset;
>  }
>  
> -- 
> 2.20.1
> 
