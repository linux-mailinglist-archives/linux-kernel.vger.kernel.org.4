Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E72160F151
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiJ0Hnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiJ0Hnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:43:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5BD3121C;
        Thu, 27 Oct 2022 00:43:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R5m6I4014921;
        Thu, 27 Oct 2022 07:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=01hv93ny9/LrP6MCMlMJ5Ayjw5ZlLwm2uq1UJPEWKSg=;
 b=LrTqtj07aBebYm3Gtm2tCzpLxuPKhBsJcCZ8txmrpZOVySBVvqdPWxl1JdZDqlYK62CF
 Xzy6TZe5/NgSeiG8/PG0OcrApdA63ThObgJGDatGbteo8Pht/oiOvXgJL67HV42wiHmx
 +6hq7HVz73MkvrSEz9DLx1jgbMYDtQjbxLy4IYew04Lp/tzVARURJC/yLRdxiJHoFrxF
 SAE4Rw9Uo3jnao2s6Cyz3HGvJi4NYyayCPFl5KBUji2rAd08PKevJJ0a12RQM3tySMYS
 ckvKLe78CErn76zWzHap7cUIDrWYlplP1fNPDXr2RErCvNJ54prcy8hVl7l5GuG7qeW9 eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfb0ah6tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 07:43:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29R6vPuB026565;
        Thu, 27 Oct 2022 07:43:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagpq3bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 07:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RetOMc7WHhVda2EIYbUEbzwJdacsmyNMU5G4do+BPrIulBZtM/+pydsJvKDPlYg/jgi82JQ4vRctF8BD8tkKBwh66KfT/MKaUpOKiYIUu36J0ivutPStCqYsjrgu2r9tnViMithjYs2wkb/bZu3elTvWT20zV5/fJiE9FHT5mTx7kIjnlB7nEm9d7wMRbtIKI23DhZ9EivJGUmiCRvTkliHnB3BFsmSOAaaNL0H1BA1hXFlXhohSxsdmQ3GMfXEJpax3FbFvFkw5/CvqCungImDJQZF6eAcvanTNSSD6O8Mz5BgmP8KA6Fw/zzezBrwdsKm8S0pIzqIqyny38BOOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01hv93ny9/LrP6MCMlMJ5Ayjw5ZlLwm2uq1UJPEWKSg=;
 b=PFGovXSM/Grrnp+xznslmDBqZsHNj4dJYgsRRNM73iC8fgtgg1AwS4xJeFZylNeYCGofA7Jhti9p+Lx1U1cEo182VBD4NCA2FyuJyDwC72e2R/9m1VtqP+HYhx8VoVvMq5fDQXOiGff8x25jST6JsvCajUtqlINY2mbAY18ifqFGBxEXpKpLhYieXJc3XGLBiui1fjhXoa7vejWEwxkrRIqb+brBFD43ph1gBGoVfrjk1JI1ssCDTiu7x/+WqpG4TOqTU5Vlw8N/vJ2p61VrlBzQSrx8PtuGkfcUZcf6U2PhqYHDa9iihKJgFACIIptwSxFNUcdKeX+yOdyJpa2+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01hv93ny9/LrP6MCMlMJ5Ayjw5ZlLwm2uq1UJPEWKSg=;
 b=bi8CfKsZB7F8jD2Uap/RWXFsM7zeqdaIwhdxLARh0Maqsq4ZrEITSwQjSsejPWw5Z+bj/1JtbxyjQDwQZClC3t396MX0h6/LHp08FUq33h6wQY2MBrE7FgFjtNRTfoCJCAgGKO8TuKJ/VcuSE2nHDRbsMRD+1ebx5KfsZKOoeY8=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by DS7PR10MB4846.namprd10.prod.outlook.com
 (2603:10b6:5:38c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 07:43:29 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::7dee:dce8:921f:d623]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::7dee:dce8:921f:d623%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 07:43:28 +0000
Date:   Thu, 27 Oct 2022 10:43:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH 0/1] Dead stores in maple-tree
Message-ID: <Y1o2k+2PTMJ2X9QA@kadam>
References: <20221026120029.12555-1-lukas.bulwahn@gmail.com>
 <20221026142259.mvcbtmj3kde5y25g@revolver>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026142259.mvcbtmj3kde5y25g@revolver>
X-ClientProxiedBy: JN2P275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::35)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2358:EE_|DS7PR10MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: 631d752d-1d9e-423f-a343-08dab7eef017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pohAr5zVMW6jI8knbYEcsF0hntSvSWyTyVDRhfoANoO/YMHdcY+11rpjiwIIIHm/Hr8oY6lAlux2sW0Pz8A4ho8ihzdshAvaNphQ1EOjj1mAVfnQMkYMECGOuue4PY+Kbft6p0Cu9rxc+H1vzdLe8TleFTZ4tK6ax/lq5JFIDQQYP/6UctNAb5pZ+m46loe8DsSqBRduOgYYdF6Du5mrHrImjE64/w2wxUTb2atd/9AnrfQo/JjXBlYP7MhHkDwG/lIsYTUto3tC6+Ew44BsxkviMnZ4oohoPOJWMkPhvcOJEOtwH2TG7uHGTH2JxhihcEpWSiaKCsguXRF5k5apNM2edzlfJqGqvb7IJA9YAOgb9Bqi8U0MtewenM2uc2J+tazcAlfqDbuh7ZJbAuTCojdmj3M1FMfxJH5djguCAZx+dwPYLAtvo2ShGwE3TYRZDvFHsnBboYQ7WeHZIVn+HZzgfzLH6rAaINS1SZ9sYXJl6LKmwoc8KSsqJr2iPB9xFl00Sm4+HXmDvWXAdrDrslewCipQ1gJw3gRY3CISIIJyfqjk7WaBc2ChvNVcGTtjJTDj2N/795h1baA1kpNvf3Fp2whjyZE6mArWqO3YnUeGPtqhFfP4L3KnYTfKhU/ajpwhjdjIBjZALZkSrevhArxJXRa6O8vuL5xiuAbY02CICttpAFTUfOgjzroGnl/n28xA1FAMc0KzbRrqlUMnrGdyCLT/LRPLXX32KwvrMH8z25aEEifa7YemrEgKSQ9g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199015)(8676002)(2906002)(44832011)(8936002)(4326008)(66476007)(41300700001)(66946007)(6862004)(6636002)(6486002)(316002)(54906003)(478600001)(5660300002)(33716001)(83380400001)(6666004)(86362001)(66556008)(26005)(6506007)(186003)(6512007)(9686003)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/gRPlDURX+Zt5uQCd+sR40TwjWt17kLWYD2JLsvapc2S3WEKkG7sbdQSz/L/?=
 =?us-ascii?Q?VeYuipXggS4v71u3rjW/cYuKWT3Rrrm2cypre/jRIN6lW5Nj2MdoJOkPGjV4?=
 =?us-ascii?Q?TW/SrLk7lgAs0vR50yvkVpwZQMlQz2BfIrSqWoltfpIfHT3fbERXhN1I4A7D?=
 =?us-ascii?Q?aJVi7Rnv8oXD5ZL7W5Cp6eLXVbuq9jgn7cabKFty9reLIk29F8DoEzkyzU6t?=
 =?us-ascii?Q?CP3gQnUX1utC6QAPInHny5mzO/2srtFXcVaqiBULMLOj7dhevWue2Rv23KOZ?=
 =?us-ascii?Q?uuEhX3yJrHYXUjcRJm9TTjOtzvuES4jkjblhkZxd5Qd0PnYJCsRA++Q5ku3K?=
 =?us-ascii?Q?m499sQc/BpHKdukfodmuUrL9GWQ5WDFQ4lK4hTufWXGMhHYotfh5L6+i6W/1?=
 =?us-ascii?Q?hEjkF1eG9wHHFv5UziRPsu7BDmjSu3YCVsTbFNeBT8Ip4TggWhr0367CaCAH?=
 =?us-ascii?Q?rwPPwBjdxGTwvthqy7xKO1h5rE7Au7iQI4LH+swedsX4TfttBB+aiHFE/mMH?=
 =?us-ascii?Q?74kuJWh0eylqpXUpifIFq262/F25J6PeE1o9NHokfXsIi8qZrPcSG6EECO3u?=
 =?us-ascii?Q?a2IgSjDaFvkYGYcjyzqYhHKx0RENLRlFY0HA5NdyoRk20j2ZXhifWj3OaC9s?=
 =?us-ascii?Q?OD+WVU/+F4EOwIClhbtApLz1tV+Mj1c6c4UOWg+fU8V55PuaNf45v8tIp6ek?=
 =?us-ascii?Q?glqEIDwhuSvpUuqaqIHqalInkQlLbzw0ozlbtHnbw0/VILr8/AFqRRO9Iqn2?=
 =?us-ascii?Q?60bllSaTCTpB/0ilOemGnqFoWjN7llCpcTUUHrw5RsoFM2ftHYxySlIWh11E?=
 =?us-ascii?Q?SsIoONoXZD1dBWq3Bt9W/XHBROmOvwf7DND70RyA8D3ghiN2ib48KxKeqFrI?=
 =?us-ascii?Q?juGJIt8D70YkmeTFJnDDXXbsy3BkE2+qRBAvFoV42dPmdEqELxXOX60/PXku?=
 =?us-ascii?Q?CMupPk3v7aJl7jvnP1NHGqTHhCSTHJtNkRfXq5we0lHJM63Q9gPN010qgWxm?=
 =?us-ascii?Q?9WzEqftii6OCZ/vSwqT9l83wAiTve+qCAvDgcx6Dn94vrO3S0rq38r0e/Qdt?=
 =?us-ascii?Q?S+O6OqRb6VEEeC6foPt8pk6BEaQZwqpFUdsSnMhzc6K0apFbOASIhpbuTFTG?=
 =?us-ascii?Q?BQAcVuR4z4G4/aOE+iZUjZfCwXnFipYyg4NiEn6nZ2tTZwN74gIRe3Hi0yKG?=
 =?us-ascii?Q?7mwRk3dDQU4InkNYWOjGXhsCUQ6FzZ270QJgiJjiiNJdpNHT+i0ixTL2KD8U?=
 =?us-ascii?Q?LF6E6sxNDW3Kfv5PqqjglRHrslPUCqrymCKVx+74FbrKphp6WQ1K6ID8JUwU?=
 =?us-ascii?Q?0JWIi/+tLRj1hToOJkwlJC5d9qHBjB6tNXe9RCM1Glt2df8CaBL5JZmuTr2r?=
 =?us-ascii?Q?b2mDFfZdePNnVW58D+gWg3T3eZmyfoLk8Df+3Cop2CbKOP4qw+h9w69bcZqq?=
 =?us-ascii?Q?vk7q3wVcICOh0e9GsyLQmMZCPi+X4N2RtkkxpXB5loHEnqbGugn75SaDFt2m?=
 =?us-ascii?Q?uGKa0GNjuaRqmO7yaj4OhWbHRjlbU8Nhi/2sOvNYRzFI7V5OVw06BeoFWika?=
 =?us-ascii?Q?NMjkUXXTcAq4nNi3P/tg8gbKjHC9c/5cSJOvHo176IU9JDIZlp1aBlnHuoQF?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631d752d-1d9e-423f-a343-08dab7eef017
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 07:43:28.6558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1K28hQguFfANkTowP0ZT90jas+DemJhi1CRW/e8NZ97XxC7/IB134gTkE1Xcfme5ps1GnU3SdIL3G7R4BJwiPcAGcNSO2K8UF9/m6oOuHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_03,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=768
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270043
X-Proofpoint-GUID: jmu-ySgYOcT0KfFZJqGyFaT_1RTNEVM7
X-Proofpoint-ORIG-GUID: jmu-ySgYOcT0KfFZJqGyFaT_1RTNEVM7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 02:23:19PM +0000, Liam Howlett wrote:
> * Lukas Bulwahn <lukas.bulwahn@gmail.com> [221026 08:01]:
> > Dear maple-tree authors, dear Liam, dear Matthew,
> > 
> > there are some Dead Stores that clang-analyzer reports:
> > 
> > lib/maple_tree.c:2906:2: warning: Value stored to 'last' is never read [clang-analyzer-deadcode.DeadStores]
> > lib/maple_tree.c:2907:2: warning: Value stored to 'prev_min' is never read [clang-analyzer-deadcode.DeadStores]
> > 
> > I addressed these two cases, which were most obvious and clear to fix;
> > see patch of this one-element series.
> > 
> > Further, clang-analyzer reports more, which I did not address:
> > 
> > lib/maple_tree.c:332:2: warning: Value stored to 'node' is never read [clang-analyzer-deadcode.DeadStores]
> > lib/maple_tree.c:337:2: warning: Value stored to 'node' is never read [clang-analyzer-deadcode.DeadStores]
> > 
> > Unclear to me if the tool is wrong or right in its analysis here for the two functions above.
> 
> The tool is correct but these aren't going anywhere.  They are compiled
> out and are needed for the future.
> 

lib/maple_tree.c
   330  static inline void mte_set_full(const struct maple_enode *node)
   331  {
   332          node = (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
   333  }
   334  
   335  static inline void mte_clear_full(const struct maple_enode *node)
   336  {
   337          node = (void *)((unsigned long)node | MAPLE_ENODE_NULL);
   338  }

That code is really puzzling...  How far into the future before it starts
making sense?

regards,
dan carpenter

