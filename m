Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349E46B5057
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjCJSqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjCJSq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:46:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E4B124E91
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:45:58 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AF4b26030430;
        Fri, 10 Mar 2023 18:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=6Mln8d3wWiaIDJSQ7oJpuSseTVcf5YKI2tP2D1jH42M=;
 b=l5/huqvKYmjwiXjpJuipiPgGFj+XBQE+xSvvvx1f2Bv1FszcsXjLotL+UhPGcGffUvxP
 jAAKX4lC8MNNxBCRxKwVvmTpAsOWjSUcftHfkVrIbu5nWuC1GOgTuTt7GhAKsZFR9US9
 z3Rt7HXgLalsrhqJYLFL7aThe8QopV9K5dDDQ10hZDUC6n1lzCJ8NWY+3yfa1e0c86Q/
 5kHYcZZrbXMLKitdOBW0TIUtxdtjPuZ+DdK/j3BRmqNt9dRU2L2RH8GiSeltdRPsMCv4
 by/2isEtwSYXYoCF9H2aMz+Si0dm1PbRiS9FzotFHiT7xEctyHtT7n5twcl2Gk+XGv9H gA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p41625u5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 18:45:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AHAAwd031570;
        Fri, 10 Mar 2023 18:45:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6feqjrm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 18:45:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G39u8CKsNH2REXmtJ7lbp7/HpkPc1/dSmLlMxa3cstV/ZBAYlX80LOJZQb567ifDxc3a1mfRl5gT2xc8E4Hj9ega479/JUWvCZqqFpjBqRcwQsUNWbh+n4tm4nnHOWR3BcKxt2EBUVIdjKcv+lobVvwSgjZM7gRcd7AGp5qHxtnEJsG0Rgb2ISU2zEq58OSzS3oyl34TelsqgJ+ytH1YXd97/1I2nchZu2k6q0KgNv4ROc7N8ZWlGUIysFPa5RJ7yC9Zq1ud/TARhBNQfQxKM2AiEafwPQHq8OJhct21MMW7bRmbhVM5H9IPvG9WBDF1QoUCXpATmkV8zaTDhrLvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Mln8d3wWiaIDJSQ7oJpuSseTVcf5YKI2tP2D1jH42M=;
 b=XRlHt/NVY73rEG1eLxpRhO0WLELYsjwh7TSo0yHoP2Q5iA1IFJ99K9RsLzAerjBGzOm673kjfxjFYRsf3TBTi8qPJ3kozh99ITYx7t8SjsKIImP00aDwgY68AeHZ9BiXySJLAFdQwtaVELgWNOn1Bg9XIlRvjdk8eNnSPQxwu2hQlsqWokIAo6HnrnV6XUxYZHQJiqWzZJ7L27EZ8JAnavsSCXj4duu545u+jdmK5l1hAsJExPaqJCSTGO6UoX1pWZ5U8YcqpbU2TTT4QuWUx+2i2gM0S5EYo+vkfq0lUdfMVLBTqELmrG9wIfzGMiSxYbnRV6ziDedZp7qM5MPQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Mln8d3wWiaIDJSQ7oJpuSseTVcf5YKI2tP2D1jH42M=;
 b=kcim+COmo6JOhMr9q696D0tYG0xdiQMRuIJfd732shK+EJT5xkcgKrcv8noa0+83jiaNpagH+/FwJBYdA2kEdWAR02ZhrtP+xs4N5Bphs+d3CXrMYLuqD9el6D6s9A0xtUZnoZDVnow6ETZ0DN+D4o6fX8PutvWQ5W8WaM/h3z4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB4866.namprd10.prod.outlook.com (2603:10b6:208:325::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 18:45:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 18:45:04 +0000
Date:   Fri, 10 Mar 2023 13:45:01 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 4/4] maple_tree: Simplify the code of mas_mab_cp()
Message-ID: <20230310184501.6cdc34ask7fqelxq@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
 <20230310140848.94485-5-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310140848.94485-5-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::32) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB4866:EE_
X-MS-Office365-Filtering-Correlation-Id: 75635fb7-27f7-4e47-edd4-08db21979046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZrzEeFvHQIpQOyKmEaPXYr127u99NMznQGyrVL1O0gJy3qZH0UJDZEDIcvUJNBtzKCrYw122HRRW1Oh1v9yq8MiX3RpaoZLG3gNJX0gpzj6UjqZRW/PF41kcuS6BqElAVr4i9rP7mbMuFGh6U6Gmy7pKrjB/BPpapYsknxfQt8KOpmdS7gmtRAXHTGzgWNWLCB8hBONOImpAVZ3cFExeLhtRd2X4pmspjCnXXQ6pNZ5ARpmVSQqcW+Pe3PT7b0lb1tSWtL0V6bPbMdS3sw7VH2luuWYMK8FRaA2XClLJHkIAyJRjOlOscbB7hjz3QPtSFl9MwP1fpbKHCggHPbASQ0JRqA3Y379QSNZH45Ifv9wtL7Cq0wfEs2Ei4Ac/umgGaARlVKX3I7obvARPhukPQdFLSduZoKuWNyvGH78JlUoauolBtxYp3tCr2SleSC/cvH/888Ufm5E3qW2zvOlG9elxReEF0gjSMpOFG2kdYdUep7tqHbeywphSd8+GAp/ofnFLNQzTlTufEf3xPm9pWenkY0pcUaOHlGTkcVLiMinB6n6LEXXUBKL4J/nards0kDv6aYBsY5KsnEk8P0ItsV334i6hVBokVRo5kYYLTu2Mh6lrC1+nWTOl02RlS6Y6FQ1rU8oQEakpLXft+A9fHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(83380400001)(6512007)(186003)(1076003)(6486002)(26005)(6666004)(6506007)(5660300002)(86362001)(66556008)(66946007)(66476007)(41300700001)(6916009)(8676002)(2906002)(4326008)(8936002)(9686003)(38100700002)(316002)(478600001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZQmSCwV7quwcUCrTf9SOk/B6V2fPMHCcw5jUblV2uKEJZRuvj8D6yxmzpOHm?=
 =?us-ascii?Q?98vxjOfU9uwKYwRCvprMJoSQjoEYvj7CXWf42a23Uoz17MNa8Njr0hur7aGh?=
 =?us-ascii?Q?0IK6Sh21dS3Hgsvz2Q/Ue8StXtAGp7efKbtbQR9f7NkGo31Y+B2xGuJD6i2v?=
 =?us-ascii?Q?cR1bfOXA8mO2TIKE5mLUy0JW1onT1/3M6KFZhphobg+tt384EBEn6yq3LSPZ?=
 =?us-ascii?Q?29oAM23ea7eMrirGcOHiZ37UMm98diDz0zhtaeNZgTSDTgBb3TexEPThq+/v?=
 =?us-ascii?Q?NCvNAyZnkJyPBEzOHYZINCi8ynJKrLg16NiG8vEKNGMUFg9m2MjmncJ9PIHP?=
 =?us-ascii?Q?cTkpiJGGMqeSzCVExC78EfYOe+LgPB/ujBEUaL/BiN4xEi8N6GbUp4teXzGl?=
 =?us-ascii?Q?2avHGcmVvFUh9aujexmziqcN1P/mu80rCP8YS+A+FG3ide1PvvPtLadYkG5t?=
 =?us-ascii?Q?pFf+56R6dJNeBjLRHRHqqcyxGbbdajIj8o91chkT6MBDZbwK/OOeXZcSp/g3?=
 =?us-ascii?Q?+DDwqMko5TMOmlDWIDhegU/k9LLLF6jhQaPxCMPkgp3XR+jDuOfLJ3p4tqQM?=
 =?us-ascii?Q?/B5nJVp+DMJr0JiHbwiDImbV/0lLMCgUUQ7JMG7dpXUeFNyABc7vsxYMfQYH?=
 =?us-ascii?Q?F8WSdQFnr7SwYDazdoxAwbHThRanm+pGQuV1JWtiv5fLlikqBakZ/p/w90JJ?=
 =?us-ascii?Q?rF+n279bcDLmCjDLVSjy1vzPzRrfYEWj6AEWkK7wpESwpbeuSQ6xDhIOu8/d?=
 =?us-ascii?Q?fkULDmQgJAkOD3fRiWXFV2+enpPitWu+2dvH0aW36iOR73bpno7y7wP/AY88?=
 =?us-ascii?Q?ZR3uoMT587f/pT0n72+gJVXuRsR3rTaHHWOivWm5GMzFRHDuesFYvKNpA1dV?=
 =?us-ascii?Q?Fn2pQWCuH4MB/g4KdOdlj7KKJd3DQlSB7ftpiVXUumTo0RvTL4pLqStu4YQJ?=
 =?us-ascii?Q?YVZ8GLojui/JxSV5t26cMASc2ySXOw0Shtnhj/WAeSq+OhX1m87P/h+W+KjB?=
 =?us-ascii?Q?s2N7i3W5wGRCugDD5S04uwpvcQjLq3WMD6ZpQRvUELeIO9oxqcQeaPjQYQox?=
 =?us-ascii?Q?jGzhAYwIha9Ot6igHLPIPphcpvunhSA1EwMWfEOdrq+y25hJ3j/i2wEm89hx?=
 =?us-ascii?Q?0QLOEXy/+J+0w40bClxwuwa6gwjZaagGkt6Dw1Q39j/N79Z2bJV+R0QC2U4T?=
 =?us-ascii?Q?pQ2ma4HzFvjR7yOQp2GoBcglmYDBj8XdWcEuxEysYGvRLVmZDfGtYKaJhnFx?=
 =?us-ascii?Q?F5hFtKAKyAQKop/L+/0Is3EGVIIQsnfyVeBWkH1woo7mz1fiWs/+dlhdfs9b?=
 =?us-ascii?Q?YwuKpK/gBv4Vtty0GWg2JFaiZw1Eyj4ImG33LCl4sdjvaBqNT2Aq9yLgKx9j?=
 =?us-ascii?Q?ed7bPp0EbYb99KdXSBDs/jS5wLk+JQYz9+1gdfakQLRI7SNGrzDJUtpWVzLV?=
 =?us-ascii?Q?X9kPv7379Om5ehSmNf8hV+QOnNelkL70Ho6jaR43BC1wYipFDBCu4ooPdGJ7?=
 =?us-ascii?Q?6wJUC1HXV6b/iuZTEoE22wniuo2SCYZYGkm5HclAlAl7/RKktREUsnDoAxfV?=
 =?us-ascii?Q?FyEbY50znvmGZUBFYAk8vkkGeX/qJxyXy6888lmHPIuQtYtvf13OLLD8ehvf?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NTAqjtY24YyDcSOK/bcvHeZgdokyh9SIAUmk1Kj9o5f+9GLFiAM8EQFEsEVZwx6/AGyImiGaVKp6HzYFauOcDuW5gwEX0D/8Q3BqOxs+oIfYpjgCsduMtrHmX+bvPly0ESxJwPo7myLknQfZkuu6pG+K5/Ox1KCiKcoiwJ693Dii40ZNkVm141OZjA2heBMdjgHehsnUYeFSvgoti7AslWYc9zB7vU0Wh55rpxtpicJlDMsJovXODSTrPYtyIfzYLE5bUlnhl5P0fHqsGm9mba6bbGKnbsAvemIB82cMnRmh+AS12opSDWmKZwMFz346IHXOMr6l0xEINi77wjL7L2FpQPV2oWAeSkc4B5E3mjFwNxqbz37B5/x37BqvYJbS1WDxVoD4XCiHpEzdLtOJnJaw7iPD2KVxS22VUq9f1Lx9mCPRxYxrIq3AxgVkKcXAdb5I+ZK+tVBt1xladS6pySll2aU1022hwuhsn/g464+yok1zIIVvRUsOwgwHGHxanApRdAYtdEdVDK0942PS5zDS7itP9hNBBZAQ+7zHgYfw6V4rXHFeQ5QQqZhUIsIo66Z1rL4kkhkwLy178Gy4BE3z5PhcckY1U/OyBU0T9azNxJGQc4cgdqY160RzmVp3uBC56Dm21w+iVmieLYxmDdkzbYjDzn1is7q2TO6mjRa9C/Slv8AKJsdZgMwK2A3L3KueobFU96VOMh4teVztIxdYe1M2fRYTEONM1nz65xRWTeprNy5bZDCmaSPKWevAzFbOBX2nJGFO4vyIDyoKXRopMltMED8jryM9oK653JAcWRNywOnptCgcTLuDXRQOvTShHHXS5NzXkxWKN2uhCiCLAL7MQlnWFPzSTzHkwHRRRIa6ifSqWUMCeZsjzGtQ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75635fb7-27f7-4e47-edd4-08db21979046
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 18:45:04.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJZb3PuBsL8fM+4SUn5SvFgUPhhuxCV5W5URMn010CNrH9w1U8jEJgOxJAZFueQ7RaZOUTZsgiTB/0AvKM+fdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4866
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100149
X-Proofpoint-GUID: xVVcs-C7Es84vREw9bIt-mEjsNsBADSV
X-Proofpoint-ORIG-GUID: xVVcs-C7Es84vREw9bIt-mEjsNsBADSV
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
> Simplify the code of mas_mab_cp(), and improve readability.
> No change in functionality.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index de43ff19da72..688b062728a2 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1914,32 +1914,18 @@ static inline void mas_mab_cp(struct ma_state *mas, unsigned char mas_start,
>  	void __rcu **slots;
>  	unsigned long *pivots, *gaps;
>  	int i = mas_start, j = mab_start;
> -	unsigned char piv_end;
>  
>  	node = mas_mn(mas);
>  	mt = mte_node_type(mas->node);
>  	pivots = ma_pivots(node, mt);
> -	if (!i) {
> -		b_node->pivot[j] = pivots[i++];
> -		if (unlikely(i > mas_end))
> -			goto complete;
> -		j++;
> -	}
>  
> -	piv_end = min(mas_end, mt_pivots[mt]);
> -	for (; i < piv_end; i++, j++) {
> -		b_node->pivot[j] = pivots[i];
> -		if (unlikely(!b_node->pivot[j]))
> +	for (; i < min(mas_end, mt_pivots[mt]); i++, j++) {

Please don't inline the min here, it is not improving readability.

> +		if (unlikely(!pivots[i] && i) ||
> +		    unlikely(mas->max == pivots[i]))

By not doing the special case outside the loop, you have added a check
to every loop iteration.  I took these special cases out after profiling
the code with perf.  I get they aren't as easy to read but they are
faster which is important for something executed this much.

You have also made this if statement more complex which is not improving
readability.

>  			break;
> -
> -		if (unlikely(mas->max == b_node->pivot[j]))
> -			goto complete;
> +		b_node->pivot[j] = pivots[i];
>  	}
> -
> -	if (likely(i <= mas_end))
> -		b_node->pivot[j] = mas_safe_pivot(mas, pivots, i, mt);
> -
> -complete:
> +	b_node->pivot[j] = mas_safe_pivot(mas, pivots, i, mt);
>  	b_node->b_end = ++j;
>  	j -= mab_start;
>  	slots = ma_slots(node, mt);
> -- 
> 2.20.1
> 
