Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD5B703929
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbjEORjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244327AbjEORjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:39:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8C813287
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:36:38 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGn4lu007100;
        Mon, 15 May 2023 17:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Ea5iBvSFDWD37txfUq6aZ7wsTZFTWsqGPnBpAoXtMeE=;
 b=K9ufR6q2PfZXZyQlxBUT1nR+ZlIs82bZrRUtKds6+vNrSWoYeB1qY0+y7hnimtPpbDAn
 c25NJUCksqAzoetdq2EQTlyDY3e7iDHtabCAXlA88d46o94lwRvq8x5SzB4SeUxSXydg
 gxZh3jSjWAQ1igRhqcYLT/2KMZFQPP+qCgO36VukPLTIo8HjGwGx6iIIEHRzUMAiMM78
 JANM62p3J3gkjbDViING050piWywGAothcCQ92vQ/d+kdKBC5psUCMgZEjTUFDy9HzGZ
 91Id6JyIu2ToTuxj4K5lOA12r74Ac3XLkvtILMj4VpcCntUhsg9o3Kavv80qzipSCyt4 Sg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdgpxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:35:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGprEb017885;
        Mon, 15 May 2023 17:35:21 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj103exv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:35:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpNjn4D6cY+XG2mpfk4XhjQ2vaXI9JkPHQTdf898YZy6FeJr52nv0h0Ukpa5lzCdlypnoQDthdIjFvW/Pb7OSlku/gp2Glq1NDkCSV45I+WHbXxdHlJDjiBUD0kcDUrYdxLIdbh0ZQ9TKgfvx7j/QSk2W9VkZx7L+FBcKGnm+0PqaT6DoFDbOxWrhWYXYog3gVGvhRTkTjMRtwKxzz/dQJDx/9DHVtFyzKntggETL4OAMUvlzV5Fnt9oozG9Kzla2nvmY+G29pE+zGUX4cBrVm7z9T7DMIiEHKg0zExil1638G9Io26gdhgpIbUvzlcgtJXiTlVRYKMUHZGdCfieCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ea5iBvSFDWD37txfUq6aZ7wsTZFTWsqGPnBpAoXtMeE=;
 b=Tot/gZtVrVOw1JsUxpYpz0pavD3lidA93IFssHL8WjG/+6esvjpTDoC0gI8o95mWNzFRem3eBnI6DT5J33sFoUw2lNe3811wKAtXFpBaK8hJSfdEqmha2S9ByRVIy656OfhK9maUR2p/winbpCE5qAdXAxug8osr8cPSu6RkPQ+Irl/XwyyR2c8DVkq+GurWZnTa2nHHYduSMC//Xmfp+vR++B4e0Sf92e/MCudwPtzFJnrd2cWJHBVcgkby9sTumPiJYf2EDAsmuhr4LSOCadSst3W9SIAK3yQOSjDJh6qgRpDAQgUm3o7baUsDkxlu17fz/45oA2dBUS0WMrklog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea5iBvSFDWD37txfUq6aZ7wsTZFTWsqGPnBpAoXtMeE=;
 b=J3F9cKVTlWvzfAZHzf/0CQkhBgUh50oyTx8RpK3cJo9CkItd6lTx3e8wHn4QAxo8543smtfg/950tR2ythpSEM6SOhwD9nAj54W2x4qMfYMrI5NG5UsyGJAzk1CydXPdTO38pvdVMdQrYwGqPPx4johnBKy/xY8yV6R9svVTl00=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7596.namprd10.prod.outlook.com (2603:10b6:806:389::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 17:35:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 17:35:19 +0000
Date:   Mon, 15 May 2023 13:35:16 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 02/10] maple_tree: Drop mtree_alloc_{range,rrange}() and
 related functions.
Message-ID: <20230515173516.5tmytjvnzvdogfm7@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-3-zhangpeng.00@bytedance.com>
 <ZGJrketUDnGkWw8b@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGJrketUDnGkWw8b@casper.infradead.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0291.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 8206a87d-13bd-4bc8-4814-08db556ac0c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMlncAWkjvtsaEvgouKZL6ulB1EMlHY1n4MzZG2w+JFkWiVTKk3+YxwkhTmiRu6Ev+TE10Pc1YiTNb5fmbK2uOxtGP5+cBNqWv0IgFq9tKGfPaDpHjVzCCVLM9Z2IhzmggvI+2KfPynafPf3joMxywdiYerhv0eZKoL+QS8xo+XRIngHvl2/lFJAe4pyOgO00HAvc14yk8FEaW49+NuTZPck4GUTT3T/12PEOPkqCq5yFbbIyk7gECiQcV/x6lBG9bPQoGM+9p+G5N7ZqzQ53JjZdBqR44cDHKnY6m5nOKaroK2OP/276Zxbr3bbGQJfgDv76VDDvvjahE12FFVT4ZmYFBNOz8ayMfF2VSiSiNJvNC9FkMXdD5EXgbQgpbEVN3crF/RwWt5JkVn5RLbTzfFHqsn9CT583+Y0s5rs6tu1//628e8UFjJ9QULbA0rDq3QFwqDATEgMlNOevMzP5TJHU4dtrYELivh2iz6CtzAPcdqCo40khrPWZ/kZLwmh6DnnGCBiBxZRivUUQ0ZO/pbWNGfl3e6Mfo1+Eq25ya9RbOEhvWFyqoARDn8Yl6cR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(186003)(38100700002)(41300700001)(6666004)(6486002)(83380400001)(1076003)(9686003)(6506007)(6512007)(26005)(478600001)(66899021)(6916009)(66476007)(66556008)(4326008)(66946007)(316002)(5660300002)(8676002)(8936002)(33716001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I+DDceGW32FPRohciGr8tZKRFzbSRywNmgmw5nXnzUO6gcgg1PZl02Oyl0yN?=
 =?us-ascii?Q?L5PIcm8I29XFLiCD0ySmGVy6legQvxe5dMN/XmHARUKwrsmjXGzvKDXU7CIV?=
 =?us-ascii?Q?sHIVUh7a7CT3Z6ZIdgogAHyhEbn0HYbyzXl4L5bo8xIWii/UdRLEdbAx0QUg?=
 =?us-ascii?Q?r0gdFVqr+JF9BO16My1OZK7LP8fSj8TEIP4+TJC2VvvvoElFhxB2ZWIvD4WZ?=
 =?us-ascii?Q?NM3S+Q5vtQq37uqW+3nFOm2PKAkl0OZ1D4CzGnyCArBR9ok58QR1YTsnDaIo?=
 =?us-ascii?Q?vOcyKUI6kjqzbeWdUPHKCDtI1ZQMmz3nxypfXh2ZUI3/A5CCTViwf/oVVXrM?=
 =?us-ascii?Q?Fcz3cnVq5N2NX4l//C09NoESyrwjmMLNHh8X3hx37pm5twfQ86ISr8HXVYri?=
 =?us-ascii?Q?TcfUrz4VYTf3bqgqvAiDttftJteDeKmdTaMfcvCkzDu7gYV3qm6ZskxTxpu4?=
 =?us-ascii?Q?v8ETycdZN/l51ccDXPbqfQaKsCFGFKaHsojmZCl0RzYAHBD4cUzEwuTKoWt+?=
 =?us-ascii?Q?uhJIF8q+DzhBh+95qW98B8ZT2wP+NcTgt42Z7nJ39MiwTVA6V3p+cVDhVQbb?=
 =?us-ascii?Q?VQ14TCdjRIZD1kdqcShcnGLqXm1PGk72QOy/1Onst6/TR1H6yVJrhL3GvwWj?=
 =?us-ascii?Q?/SGoGqY6o62c+5fn7TZn+6lLC1xcaXGqDrMlZHz1mbjNbB2G/jELKmydHpD6?=
 =?us-ascii?Q?dlzVP1CvZuqX1Su6D6gnMVGO1AmykaH3I82Xb9ZAgchKGZSWPFwsK7Zz/IHk?=
 =?us-ascii?Q?RnEGf2CEM2zTrSzb13OwbwTagDf4SMywFIMxAQKhvBL4gvonNpp7mhc9jA3+?=
 =?us-ascii?Q?jHKa2DDS2ZZJeMZgRhqSk8i6K/7nFBtIi8zfa6HWOuOeY9oMKWv5MoS2E9c7?=
 =?us-ascii?Q?IMncw+k5ehee1aHZjk5CzRre3al9vk0tSXWJ4q32vN4sPzNIEwMdfcWro7sT?=
 =?us-ascii?Q?57QnDgXa/jz00YMj0ZIQUYZY66LFt5jkNVBGDbuRdecZ3fdGAuFeOiyF9AeG?=
 =?us-ascii?Q?1RDrd67CQmlbMhFxHDO/mGXYrNtmkM0t+KATLPo5IQvpu5q040qYLTg9z2+D?=
 =?us-ascii?Q?3MdFttD3SDLPr+BgvRB5XvAoZPHppCMUSNGLod866RUmaLrwveRpUoAzsvC9?=
 =?us-ascii?Q?/ma0dzhpB5+OWRjz+pO+puAwqEEH2zbs4TZgi+0jdHqiTmHzMJ6EX7yNglHj?=
 =?us-ascii?Q?2XIpitGKNGhDzg4ViTiLlyZU+XfZvd4pqZSmWWIET+TJhemXaOUPqYbh4r9u?=
 =?us-ascii?Q?drmWXQkb/GMoiFItZ+KgkLcopMbou5GjM01OQPmwkx87C0F0DqoaKs4YuXhA?=
 =?us-ascii?Q?XQ1Mh/fS3KqaoXAn4NuQ4BSLVR3CCZZllr7qLarT+nhni0UpC2FgHbe+uoa2?=
 =?us-ascii?Q?8OwrQiMfDLt6uOp1p3dv7qzKPPwzAu/gxL5vvMobAcX8id0fI4S3hBez3GFT?=
 =?us-ascii?Q?YUi+Z1vOlGeoqEro0hXC/rIgQeT/A4nyKIXmsUZD/bI+Cpu8FcgiYEzQa53c?=
 =?us-ascii?Q?2+4K5bnH8eRh1mY/HOB8LhdP+ajjRufCrCP/GyzCj6cAFetN4CX+PqPPiPlz?=
 =?us-ascii?Q?JEd1XI85ZBjb3VdM+5BfcZpNYlVBGbxP5/o7OnSE5EF5fJpc4+GpbzWrj4aG?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cG8f2Ob+sm6hqwQhvA/sNbcM64jp02JUleVTl4PhN1STgvkxwY1gagBwUy6J?=
 =?us-ascii?Q?lQEDOR1DbcRk+A6sZLNvop0IA4RktApLzYP1LY+juz3Bu5xAnEE9D2ufmEAc?=
 =?us-ascii?Q?qXHI08ugS6JVUb700umyJnyQip5HdSp8yAwaf8IreT/8QqQNVF9md8ZlmKZw?=
 =?us-ascii?Q?eKrS5Y5r0agAPKxRjAFg/3dWAntFijtBCSdiLjZBVrA2xZxasRL9fC5d2rp7?=
 =?us-ascii?Q?dmtPgcbeToJZfotouprevGP4un2jGBgM3A0IamE7dis++bQlOZwMK+tIWzwn?=
 =?us-ascii?Q?w6dl0dFU33daZ5VpQQfgOPHGLNd1cNg+gntQVWwJgomfpmmNZpVvKib5zHJO?=
 =?us-ascii?Q?X9gS6Dt+30bt/UbYqo4YdEAj93vt7inJpevq40kTFKr//HFEOplHmZezll5W?=
 =?us-ascii?Q?KhvbQm188Dfh8TRJqCC8bln/lEDPdsQ2ny99FsxnfQV8Q6CMdUuw1lHhqJN0?=
 =?us-ascii?Q?AfYiWRmW17sCyVt+X/QiLIDb2L4EPWmqdtgSkKVwj/KbviZg5LvkRyz0hZ5e?=
 =?us-ascii?Q?Y+WTHkM5SobCBlubIYL7J3erRNbseaVnZBvHFhrNGxStFkhSYM6KtvcDecjm?=
 =?us-ascii?Q?xMDe3uBp2Y+CYFynKMh1zG1heawOwK39mmQq6iypoJr1K8BQDoV4OZp4va/7?=
 =?us-ascii?Q?2BKbL1WlvnZQV6FDpqgtXHuiiJQZL4spS/nUiouAtTOtfftj4tjwtYHScFzp?=
 =?us-ascii?Q?pYXo0IehYBVZO6Opr2exCjlFT6eAZrIsh8bvlG5UayCC1EXlIAu+4gnEDQio?=
 =?us-ascii?Q?yJwmhun6gFgmzmW4urP9fprj8M+6GW8Lwn3eNd7w2OhOA3Wb8vOhtuqLDplc?=
 =?us-ascii?Q?jwdNFD/HRk+jxRYb6CLfTXhY7CsYjF9IDpNYZWlZoEXsCSSPlDmxb+rK80BP?=
 =?us-ascii?Q?s9YL7NrBiEBywUr2MCjJomv6B27JmCvOxhQ0zUWinbMj33XEmKiF/fJrhF+R?=
 =?us-ascii?Q?EKdfB5Xn+g8ms/zUmdoT/g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8206a87d-13bd-4bc8-4814-08db556ac0c1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 17:35:19.3006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+LMBQZvj9t+0G990nyWGKwbTgfzIAkE9CtB8hkiXKnmUfhktVIbijfNk38IgC2/xlcvP9oB91ZZFNDWm+T37g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=516 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150148
X-Proofpoint-GUID: qPlN1RvZeZm_qtu9mqTq53TMHnEmhoUC
X-Proofpoint-ORIG-GUID: qPlN1RvZeZm_qtu9mqTq53TMHnEmhoUC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Wilcox <willy@infradead.org> [230515 13:27]:
> On Mon, May 15, 2023 at 09:17:49PM +0800, Peng Zhang wrote:
> > Drop mtree_alloc_{range,rrange}(), mas_{rev_}alloc() and mas_fill_gap().
> > mtree_alloc_{range,rrange}() currently have no users and can be easily
> > implemented with mas_empty_area{_rev}(). mas_{rev_}alloc() and
> > mas_fill_gap() are just their internal functions, drop them together.
> 
> No, I think this is the wrong way to go.
> 
> Most users should not be using the mas_* API.  These are the advanced
> APIs.  Most users will want to use mtree_alloc_range().  Just like most
> users of the XArray use the xa_insert() API rather than open-coding the
> xa_state and calling the xas_* APIs.
> 
> Please read Documentation/core-api/xarray.rst and maple_tree.rst for more
> details on Normal vs Advanced API.  The real problem is that we have so
> few users today, so you haven't seen that most people don't want to use
> the advanced APIs.


Peng, Apologies on the confusion.  Please do as Matthew said.  If you
have a way to unify the functionality to use the same internal
functions, then I think that would be a welcome change.
