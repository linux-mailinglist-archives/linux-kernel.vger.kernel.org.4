Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C56F678AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjAWWfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAWWfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:35:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748661EFFB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:35:33 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NLhsgm011300;
        Mon, 23 Jan 2023 22:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=FNXq1KeQarvI9P3PTIEOfcS7T0K4jKuVg8ljX0SmAoA=;
 b=jmexWNwRLKL2Cy+jCA2bs9fv46ASeIPiZ1Ngc4x/jcuNABjj1iffTjt9Yk/KCF316QX0
 w2BvxK/MY5dVDrRr7dkNMdagtDAlByPmjMdg+Vr57H8MyW03FQsbctUcdziVysVGtPpO
 51Di+hkT5UoXYkKg0qJgG3B7K5MjkcGlPojwm1nSG3kdslT8WanySyQdhL/pjJ3922zq
 x+kkKzfYtSXCiQVSILL75+35/gtRmbmtQREpycmetaOEx8qgX5tQANlDgIapJviRi/3w
 6UKCKv4Tp9Hy/Jqk5OT0EtdSvOvRRXTrLt1EP2Jf9nZGnzEysemg7l7c+mYJA4sTUdzn QA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86u2v3vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 22:35:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NL7Lhi040198;
        Mon, 23 Jan 2023 22:35:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g45rnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 22:35:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzLcNh/l4aZVWLbRFRfYPdFVLbbqEdkItYWL8Pa9C86NM0S/KqcaKcodAAnw7E1PsE7Po3L5YVF/WgE4HZIwCGvEnW0g0hGJ7F+Qf2SDYpGL2YYYKE6bDdJ4OvB6VBLxQdk96dqGT0C4KeBYjGJiSSh1tkyoRq6HUauhuaAXnIxICO3jyO+5f2Wwa2fJZ0l9C5Sgqz5a78oBs0uuVUBsK9u8Onn91cA+WoM/lTO8JvV5gVtA+N7X51ijEYmCVKYfUPim6Jr9+xODGDUTY/Y5o7MsJMn42p/7LAd0Af/KnqM7EcBit4JeQlnzK+8AamUHA9DqBCJZTH0SvnKC4LDAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNXq1KeQarvI9P3PTIEOfcS7T0K4jKuVg8ljX0SmAoA=;
 b=klIy1TLiQYD/Jx56BcKsizOaF+bm23hPygcpSUDT5pxTVUBybqnL4WsaEDjsjLIp9pFJhve2PeJ/5RAOVY30mlZGFqyAlmmyIZ3z9hkt5kWfc7ymqHSl2fNHV4xX+PHCQxPORtdnz1XGq4JSlhMNbs4hEXuw0Sa75TOjgOWGOjJNySlMrGqHPONjRf/1LUSUMqB0jg7EqMPdYJYklSNFhr4mzv8jM1exMno7ZdxWY3G5pdIiw+McI2e0hP7/peBO2UdkbRGWzDcUnB5qw5MW+pe2kC0MyCpxSUdV3MAWWRmrA6U7u+WLPaJA6QzKE524EuNIGofiZLPCGvlJJ73voA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNXq1KeQarvI9P3PTIEOfcS7T0K4jKuVg8ljX0SmAoA=;
 b=YNwZ7N7vkb3ST/i9yVtczqo5BqYiKt9j/ntfwLSkMMZkU2uU9jMrfG7GfPy6J2ho4U9SRI6gXTRiGmyG7lk/WQ9cixWy9M95o/ZDjsjpn9hLOIuglw6aCbel8vXCnKEfPvR5MVycc2eQ7LwfQZqCFO4odT2bKgGkXH+lik0cUT4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB7055.namprd10.prod.outlook.com (2603:10b6:510:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.14; Mon, 23 Jan
 2023 22:35:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.016; Mon, 23 Jan 2023
 22:35:24 +0000
Date:   Mon, 23 Jan 2023 17:35:21 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: should get pivots boundary by type
Message-ID: <20230123223521.4eacmsmftmwddjfb@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221112234308.23823-1-richard.weiyang@gmail.com>
 <20230123134341.2514c269a07ad9e7989921c6@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123134341.2514c269a07ad9e7989921c6@linux-foundation.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0014.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d99cfd-275e-49b4-a2df-08dafd921e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N8QHLBIN8y2HMT8YpHkjaBVCwBze6on3eOXFCk6Hg/mmDIuxWb1+H0SrpWbd1AgXMlUhspoDMcZgOxf2bA836bkXFKyJGIegxf/ys6NrRdi1M1/LDVyNjieMIDxH/0zp6ffG2ax/ykaYjCaly1iljoMTu8UcPaxNlixGkHHEVgqv6jPwpI76Nb08mA/HxqXLOASxyFMR0uSNitXl1LSbPANJnjuDG1nYdgIDsFTcIcuAtJvm9dt1gLxe4/CFWaS9fYmY9T5uBywTBEtin/d9K4gNBJi1MJ2lfLySkFh2y/ajH3Ww4vNP3r4EUGuI7mT69ltO5jGg1PFMZeqzWdtmYsz/hcPnGyge+MaOSFJrKyvkpNuidFVjkq1o+qgYSGjCrLCq4RJtFIeb/gnM3OWvVJpLOFRfWGUVJ1f012Dn78FSyg78GNaBRxc3fq57z1C7+DecevV5zdI8p6LXJmDFJXbnmo6TepXwiCaB5azzdYj+6sKZkGZ8a1XCDb8affVEbjkEv/R7GTkGNEsGyle9I7RiBrB0siCwA2g5/UF6hbC77iq5HSCPKkvOO5USBQvX6HmwtluwAExol50G8JsWKXdJpZ01yA6T4lQ3NLYrTS7xx/rknB8hR798MFVNUYRZnTAixm5GnV0lpDZLDc5P2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(86362001)(38100700002)(2906002)(4326008)(5660300002)(8936002)(41300700001)(478600001)(6486002)(6916009)(8676002)(9686003)(26005)(6506007)(6512007)(33716001)(186003)(66946007)(66556008)(66476007)(1076003)(316002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vlLLZwcHn0MRvyM/gpF+yUSvg4+2ewx2enYwypmT/u0UxHqXDg4TVFY2jnUs?=
 =?us-ascii?Q?kUlCdbBaozU113Szw1xoZaYQnLrbrYmne2BCixNJZCYMGf7+05wOD7a5pXV3?=
 =?us-ascii?Q?orUlzvALHr5qlSc+QWe5hP6GJM931TgvypHGjwtgKstiIOZsHKYW0Xn85Q1Z?=
 =?us-ascii?Q?4NwHEzgWvZO5MsVDMY/rcRmqTyYkm24mN06YYvtk5DWUqCn7FBDjzpLh06Ya?=
 =?us-ascii?Q?l5zouX2oGHmknVB/a4zqxCrvRYjjekE1EYuI+PgTvsBK+zy7lh+f7tS/uAsH?=
 =?us-ascii?Q?9PdaN0HqFJknm6bCq1tdeR0omOnqWPC4sPWSDngEvBuKdtto9liX7X8xczuF?=
 =?us-ascii?Q?cqgJQYSOGrInC7w5VarVr8l6sejvTr2rkeDVkI78tKRY6cc0wbrQvzgbqCoR?=
 =?us-ascii?Q?3j+i3Yd5zzi9ttKJ6JXiTyF8ZC5jHjV8O+PqA8UlbXwmYfNj9OAmzeQpTbPn?=
 =?us-ascii?Q?xLya3jC9O1wXgJCo8F51AX8R0JYaj/ebND1XqN9mU4Z8s/JchBWHknxAdIvG?=
 =?us-ascii?Q?MT/kuNXi4sg0tUvBOyG2JdxpsZYFS5fPrfHgtNCeEq81+sN6poNqU9HdIoJi?=
 =?us-ascii?Q?dXe3l9J2e2/ydaK+2P1rInlrAjllwEmHZs2BDjOit1ZnmGadYFgDn2aZcRCu?=
 =?us-ascii?Q?B6CEglX9eOQxQ16Xi8HMsvFNHSeI+JwVbH8pgwGdIG8k57eGoJqXEvimKAl5?=
 =?us-ascii?Q?NXaQmreVwQEGu5BHeYDWuLe1dce7bnsaOlPL/24OQEtNPAqDRpZglVYnZBgA?=
 =?us-ascii?Q?SpoxcqjL5YeMFAbctG9FgoU7whfwbYNqkER9poO5C6c0iHeFrALlsZuIIs3V?=
 =?us-ascii?Q?T07PwuaQYGYleuVsCkbtDcoCqusysyfOE/F+U/zmmwptURj1KFEOAijI1veK?=
 =?us-ascii?Q?q+aowM3yOPuSau+MoKtEx2PHUpwP9W3Xwtcthks2rpjk9sxP3H9voPlR8Glo?=
 =?us-ascii?Q?Xk9tK5XFJhKRxoMFXGNDYDC+g6nSJAon7X/fef3A+5yK62YFviTpVRHLxIOP?=
 =?us-ascii?Q?0L3tI1lnxZDFsEJc3vYO9RECZNs6bjfwoAKMB40v+/2OexHBBBkN0J+j11SJ?=
 =?us-ascii?Q?aY/wkox+3UQjpq5qqAy18NzmiEmTcaZ5n5YKLxxLH2YCoVIrXsk36yVt5VTq?=
 =?us-ascii?Q?OFSyYLHZtd7HlFmdLUi5maemkMi+/TrGmfKw/kNul0uB2ZEUsrxtUwi1jtBm?=
 =?us-ascii?Q?UwTSk+fDQY167yo+a2ALlvJXovx9InUaJ+Qkh7oTgiDsFt2uQt18/fHHQHI0?=
 =?us-ascii?Q?5ew5UxFjmZVLy/Z+7EemF+J2nGizaTDuHwaMUgVgIxWyNSu1HZbtKnY3uCN2?=
 =?us-ascii?Q?jNfDbQlhVakOg0WU4S27OIwos6eKRokgez3FbpVZO3cM1Tr/oTen3WX7FILO?=
 =?us-ascii?Q?dihVWekYfaWZKkrBbPIcNfxlIGeh5kTX35uBJruGKNh6JF7RkXP2JQVJzWDf?=
 =?us-ascii?Q?RhEzabvxY53OPZX6u3uioX/4NOTmT8WWWGv1FzN29cnhJTcKUx7ntZmlz+Dn?=
 =?us-ascii?Q?4FKjKTNL9WZ1SWkkt7l5hOTSHcD7DctABtv47r2QcOrJQs1ekiXx2m/p/ZXo?=
 =?us-ascii?Q?1dBV9A4bzGR0pNdD5DmPOD6IwometlHBqgwzOPDAyCmQhjYrRvzsfOrYYE5v?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YIbAR8xZmZMl/kWMC7MqYa/v10hkVEd4vAnTwSRPkjizB0JlqBZ2T0lJleZf33jD+gLlF76i+Eerujgekl00xiqqZ8Ukb58i4GkFx9OO+yra5g71okycm5H0OFHSjO9xPMY2r4mW5VtnGEN4qxuQylD+G8VDk+mnhiYO7dL+CAzieMxdNkLF3ez1dWm/U/eSVrt5W8XKzVJNXO/ymuuxoNZNFsIftxDG4vbwj/NhU4Nn8NO8EGG4VOUIo/rn1boUgBWwUoPaECxqMl2SAqTCUzPQqe7+pj+aLbnEb6SI9TjxD70ZlAft3xgwIzzNKyHVTtSE90xnLWAVFctAmOy3zCdeLOakHgaW+ZlV+xaBZjHvQCUgqZT62XQupqPsoK1U8JA8makKEqneacy+IrxCRL1Soief4RjrgJAa/K9+H9B5/HM/R4iR0NP7/9M0C7BkjFE3z+YwIAc6ptzej4Gjxk6KavvqWujWI1AgR9NL4QDlCSf2WYvYMboca+m/pZx/7QYsDu76NWXu9QBVzOX//yJEHn/ZF8dgjleVZzjdr5NY7e/yzCoq7kWSdTZZitvZCvqTePuwLqVQ5TW/1Zaz62lYowFN1ynfPGh0mp0iCpn+4DowGlxvdDVKJhcG4MkEiDU1yJSh/knoBRsYCuRYRVfKTncBK6TNk4WUs6ODmjbbv1Q5zdMPyj3JXd9QlzaqOQ5m4ZL93WuSCzxPNlPnbvUCfDABLqGX5FQTl3to2AWSqXTsO4woivHENlsEgrSWXEezPg8DbqkHeJxjNuzn26qJp86X5JArrTvNt1R86Rqt4MJJ72SB1JMXnDyKkEro3lFgkKZL+ThQNA2apPTBvpWdmpzL1yMNxzPIjjw4JIyrDz1iNODiF7OGWnTAhy32
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d99cfd-275e-49b4-a2df-08dafd921e11
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 22:35:24.0058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAkQqxfKH5fDPFZO7Qhw7C/Rv7SEB0KhN4KdY3lnwSZe+yx8wml6YIT1cdiO+685IuQS2bViCeoh+hLQkV2hlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=832 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230214
X-Proofpoint-GUID: ZvG7x89ChuQckAFL7dAAmsnUn7QABA5-
X-Proofpoint-ORIG-GUID: ZvG7x89ChuQckAFL7dAAmsnUn7QABA5-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [230123 16:43]:
> On Sat, 12 Nov 2022 23:43:08 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
> 
> > We should get pivots boundary by type.
> > 
> 
> When fixing a bug, please always fully describe the runtime effects of
> that bug.
> 
> I see from earlier review that the bug could result in overindexing
> mt_pivots[], but Liam says this code isn't presently used, but
> mas_alloc() calls mte_pivot(), so I'm all confused.

Correct.  The function mas_alloc() is... very much not well named.  It
is called from mtree_alloc_range() which will put a temporary value into
the tree so that you may store over that value later without allocating
memory later.  It's about allocating a range, not memory. Perhaps
mas_reserve() would have been better, in retrospect.

Anyways, it's not used by the mm code right now, but it's certainly a
bug.

> 
> 
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -669,12 +669,13 @@ static inline unsigned long mte_pivot(const struct maple_enode *mn,
> >  				 unsigned char piv)
> >  {
> >  	struct maple_node *node = mte_to_node(mn);
> > +	enum maple_type type = mte_node_type(mn);
> >  
> > -	if (piv >= mt_pivots[piv]) {
> > +	if (piv >= mt_pivots[type]) {
> >  		WARN_ON(1);
> >  		return 0;
> >  	}
> > -	switch (mte_node_type(mn)) {
> > +	switch (type) {
> >  	case maple_arange_64:
> >  		return node->ma64.pivot[piv];
> >  	case maple_range_64:
> > -- 
> > 2.33.1
> > 
