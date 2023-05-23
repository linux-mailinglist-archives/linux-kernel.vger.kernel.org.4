Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8147370E45A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbjEWRxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjEWRxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:53:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CDE1A1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:53:19 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHoqGP020797;
        Tue, 23 May 2023 17:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=FsHhyYJCXwHaln60IOOyCOwvUHHqTfNoUQ91KYIxn1w=;
 b=R8qQG2hsp/ETyxzJqy1CEzIr1qngqGxG0mabYtKLdib/vsQzXQxYjkcTuxCB/XLbUI9+
 nrFTa70akZljhN+JJJe5mOXuj/2488xfvEAUhHDFwXyJ/547qO/Fovpq70ZuNtvHtw8R
 RbaBc5/kNlR5q2LyV+Bj2pmBmBCyd58Up7jIJ4SnLqsec7m/1dNNMxczT274nZD2eFNq
 15XABRs5HmO29IX4X74fb/A9Fo95WrJ3YTs5xDXHHgixsCHN1ZSVWsQA3Z4AmfL/PhwD
 VyUE2qAV9TP6wkv4s9K/x7OjrcSGUBVh/DH+qXt23zoOYweK68vixkMhh1uhzX0DgK1x GA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp425srt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:52:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHcBcF015827;
        Tue, 23 May 2023 17:52:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk6jpajt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:52:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5pwHMTbtRMr7At/v112+TcpZUPYODjQGxpjuHH3Of/RBha7ifKgYuRx44NePQjFKw4hOv0Br3OjWNCi9jfib6V2QTtaBrDtj4u/iRgbqpmnTtz+803j5qPdk7lGyNUQPheTp4YoA/nw+j1WIR/UcMrj9JolFIwPPC53RtJ/ihOE1r95AgHHiEmCKBeo+10lap0n2lnCb6svL8uNk9mcqNA6dl4hMQPZSd/WAtd1MiFLGPxpj93SjkmSCqZUBL4AJI2hc8pyz+yRIK3kACESOa9vhvz3m8dYQIFtKpsp4SYgDqJ/wEsIcAAxb7rVClERpsA47Gev9KnqJ3QeQDTAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsHhyYJCXwHaln60IOOyCOwvUHHqTfNoUQ91KYIxn1w=;
 b=XhiikKYQwTDQHSOXOcEBwX65fekjZG1yaaraSBa1/XhnwcBMZcvZYyI9fFhdDtWm74zxftfPfL7HLtG3fpEW68QBb/ule2Ajt6a018T58v6rItjcrVUaj/sRjSt2ig4bbvihgx6ZDZqY92BlSlVNnbfqoyZoTFJ3vhm13tq89ugdvH14chG2uI9KMuLUB4F6cT43ORO+H7RZYAmEExqicKKgV5i7Mtwvjt84qVp5LOfPjh/TMRTUbyjrKCaukM6CQqD5x4h/DuOYvwpIcpGdu/J4mb8zf7RyDkJeBMcXgUhTltUOCYE5uRYVvcusRERfMeRW//M3CjUKlNuIPXSwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsHhyYJCXwHaln60IOOyCOwvUHHqTfNoUQ91KYIxn1w=;
 b=ERn1r4fK4YZAvR3MO5StDOCrzhlP5la0rElxJBMol0u/qy52OTneA+kq8yv3trdA4BfJbqJrUVRFeI0NQ3rpBP4EtHZd20MU/qWgMn43oT8QtBPoy65t8c5begpJ0qhX3taeTPEdQBbYN8CoFmbTjO7RyyfnDfQwYzdRHvugyG8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4241.namprd10.prod.outlook.com (2603:10b6:a03:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 17:52:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 17:52:49 +0000
Date:   Tue, 23 May 2023 13:52:47 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 01/10] maple_tree: Rework mtree_alloc_{range,rrange}()
Message-ID: <20230523175247.7pbduzhlsc23vuo6@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
 <20230522050656.96215-2-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522050656.96215-2-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0462.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BY5PR10MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: e40b70eb-1b9d-4a9f-8ecd-08db5bb6862b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dsw5OnZkBcgPybMYH3isOKd+ScuGFdsKvAf893yvl7hC1+4nXis5U9G3zXlVb3YrPy9PiWtkHxK1pIfTqFc1PNXli26SLGQ/2dwTYCUiak/0A96nh4CuGuTgISlcPzCoH/gNW7iLQP/s8BtdadQIx6hX0aPlkHkF7nyXa5g52Ngy45QQQq0fcH9RM+k1sJR/VeSQmnaUUzvc3JlxbJMdkigKZxRcgsfZrnDxojBoFjmlanIbs5d/aI9G1KYfTbdPtsPzBKwDfCFfDEaKfIUWM6OHP4ui18RnCfRGdbgLyDl75Yp0zjJ8GSYP0DoWBGTX7QycmIvSEslV+3GepNmAWOjrjuqErsKo1BEExi4GZJUc09U1j982oq8ParUKVyxIqb8NMsPOI5Qgu9r/8AuA1CXWuwHfrKY2CyHoctZKbmbdWjuFWhPIuJFbaIuzllCa8e0kCj54uymYqG3dlifpvj7I7/xx+Ok6WaQYw/AZNn3B9ebybq9McbwIG8uCSO5UjszGq4eWHBtVc6Q4PvqZmFR6u24bVXHhKHwB/n1rIJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(478600001)(33716001)(66946007)(66556008)(66476007)(4326008)(6916009)(6486002)(41300700001)(966005)(316002)(5660300002)(8676002)(8936002)(86362001)(38100700002)(9686003)(1076003)(6506007)(6512007)(26005)(186003)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CArkGaDLaGZNlZ0UG7ULQgK0WZcQsaPFdnAoXfPq8BCd1bt12yxkL16OlfLE?=
 =?us-ascii?Q?J3Bq8dIXU9GDspm62Azt6rO5aLEfSHWmrW9uzZY/AdHldje/Chz7hyTvhsEw?=
 =?us-ascii?Q?1k3473lR72SIiNZ5LgNoFlD/DfFkN9v4muwr6bcm45GknJfQSkQdRXMN0uRE?=
 =?us-ascii?Q?Ncg14ywPfOyqNrPX6DfT3S6dhGc7EQGRLPndcGHmd7dzw0HP5XeYM8ZZdS2q?=
 =?us-ascii?Q?+JLMwZvACpzmnpwqvxP4rptwh2640e08HCHhGJ6uenLBfE4w/r/H+d31QU/R?=
 =?us-ascii?Q?t/4G5vtdO/91RhQ1xvtlTeEYzNS5dfFV3fC2J3mCWI22AHkQZfOo7Zz63ZVo?=
 =?us-ascii?Q?ikYd5yjN7kOW/ChbbqVMJ7LQuCjunqX1bgj1ZludH4btVr1RVkHDKoci5Ab6?=
 =?us-ascii?Q?LM+H4s7ORgsSQRTigx/Y2ME6R4iAPsL7hHdnU/2+uhibKHJNLT0lwL4pTs3X?=
 =?us-ascii?Q?xe/7Qa1tOC+nNUD8OwBZ9GOjp+a4pCiwXp+vZtMaQIddzKBCD99gB9sr6GSw?=
 =?us-ascii?Q?+ooMWi7xhBmycBQNCXkjc1cuvU1yvfhk2i4YMis703SZRzHAWQn4zmkqZ4t/?=
 =?us-ascii?Q?zAGJugAjlBEcVT7KMrGnIy9LXlGiE6GUs9QbLbAc/9SNnqlTVy3xrBigckXj?=
 =?us-ascii?Q?f3RNgO8m9ZD92yGiCyBfy1EHxUISFbpH1J+acTdlyz9zpsqUi8nhOpvO7jJd?=
 =?us-ascii?Q?O6lu3fPQQuEg8/xIahmTromI517JV+MQbEwdgDSPlPC6UaJd3Ue9+BCDhf+q?=
 =?us-ascii?Q?QAdljIMhIdee9oqObff2rE7yT9meoE29ipQjcgtN9m/vcfVaPMw03sA/N+aR?=
 =?us-ascii?Q?Tvr8N9ikvl5qJxTpw7CYPrJf/4P3VN6wzZIsrljfjgk+XhxAttgmAahGY1pj?=
 =?us-ascii?Q?vFGxdRA+jvZm0TOXOzBCElI18+THPJqFFIvbiT1oQpY72kqUI7+qZSvBsoA+?=
 =?us-ascii?Q?ZbwwBbSP8E8m1HRdYU7YDOI+zWAuRhXmabjh1mca1yY/1v2NiKy+z/HJh47V?=
 =?us-ascii?Q?k7cTonkpQhClR9EC5EMFZHllJ4m0pJzBjG1rQNcsX/ZAH0IUT0aKmIVaCFd8?=
 =?us-ascii?Q?xnvtQH3wL0lZQjPsGsyaIc5zwN5AEACfJxsEpY1jjI1PwJZQBP3wIJP1lBra?=
 =?us-ascii?Q?gtz37R6H0Xcrcy0g+gWq2+2JLaVqaRdobYX0oVhNl1i8y23b+RB/pQ7kVkLE?=
 =?us-ascii?Q?o6c80Q89CvGc1cJkv009+5hJTOoW8AFXPeqGCVTMpjmd5o0ZxhG6FcHMQ9Ke?=
 =?us-ascii?Q?tkokGuMV3fA7paLDEbFftJEpmI7HNSoahi0Gp8TGOniyTxhWeWt5jepyUnxA?=
 =?us-ascii?Q?XtnhFPrWQcKi1OILg1YWk1XQCzNYi1esbaEzUT5j+vxUJPaXzArMX0/5r/4z?=
 =?us-ascii?Q?GGmRMsJ9yDFTDKXnkgs5FvbsYDwNg2UZPoyia1PlfxJwgU0VyCSEkkYsC+Lb?=
 =?us-ascii?Q?PgRn96PBxdv8YSSLevs8IdwamAL7Ye8snGNnDmvJrqhiOo3Fb91MHpCxKz2C?=
 =?us-ascii?Q?WYonN2cfR17oUlzrZlbfsUW7HTtjib59OgPnGCqVboqeTvfa1s1V+YDc+80G?=
 =?us-ascii?Q?ilXSR6hWnHj9fEJ50JnUP2L8ceXUmYE10azjSGgxnh4We5sYWYqt9Vj2Ep3P?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?j2SjNdyEgN/VhvGyoDXSkgCea44N8YQNSzUXgnjxhR8pYiM8+GWHz9VeObFF?=
 =?us-ascii?Q?NigdaLYWEQ54KzcxrDXBfBQ0N4AYnorMdHkMvXxGraH6Vkkc8IfLLdtar6mX?=
 =?us-ascii?Q?chSMvrSSMScpyx4/SHAvWAOrmvJ9Mkv/1mwUv6KsLARhpYjvosIQCE2Pnlds?=
 =?us-ascii?Q?TPUNadHnFbTMPwJJQ4dzqZQQuXoQ10jLuR1Le/8YnuHA3bmsJwVRqUF5jXlF?=
 =?us-ascii?Q?Q7fRumOKZCi0PAAc6JW7M3yW34w0amZX4MroG6+hO+xhh0t7qajcnjLoIs7s?=
 =?us-ascii?Q?9RUTY5B+7QpNHBok6NcLlshEBkenWdu9q5AfqQT9/7IrcZdmFlhWwKZX9hbZ?=
 =?us-ascii?Q?kMt0SsDCTL8otR3jz2DsSX0tjRFTAUo9NH3QEF/LImUXZ7b3BVdFc9Xx8AdB?=
 =?us-ascii?Q?+b5DpjXiL0CVUmCicuhKh8NuKqpZWYvJmZoZR/yi6qfhRTczO1MarwjQBLOn?=
 =?us-ascii?Q?6KuQy6xO49shspXsL286L5L1vbJo+E/mLbugw+WyYBXOu5pR5cLQJLNUezyx?=
 =?us-ascii?Q?vInpIdzJVlNKfrVMEFMVbwFPaV54JSs/RxP2jnFKUTkA3beo9Tjn33obCC0c?=
 =?us-ascii?Q?Zg6pHJLLlUlKv/dpde4bFMe2VxCb5ludczUeFtMc0E00d847WHSwkLdWaOa1?=
 =?us-ascii?Q?BazHkviuTpmnGD4BWmBfVJN/feaTTUzxDaUDS9+Vves0Fpi6NJMAzJlTzfUO?=
 =?us-ascii?Q?UnYM93xHXT5Ckg+3LPgeP7bwZkDXigdlVXwJjRUFrZhZ+BlNyzUopia23knq?=
 =?us-ascii?Q?45fenK3oNkWGK1RJEdJalgKzazOrc8mlRYvwhTde8PSOXc+Xtgx+GTsJkKdL?=
 =?us-ascii?Q?SNpDaQbwFztPbqSRNZ/JEhD6dUgqAtwLNKq2agGblpuAh68vuRE6lP40Uuaj?=
 =?us-ascii?Q?aP9HL32ns88I63iHKtuXFsPEpFFuJmVvdWt6L9+lqLT+06q7bYxKBp2mknwN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40b70eb-1b9d-4a9f-8ecd-08db5bb6862b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:52:49.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8Tfr5XWBxH5imoC6FpXeNCs87mnECTnNFYfi3ySHZNuG620O50TefkL1jT3Pv3YDZWpr3rmWJOEbVsH2U2NRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_11,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230143
X-Proofpoint-ORIG-GUID: Qvy1M96sjJZuZejIPhBGUZclDZWJlxec
X-Proofpoint-GUID: Qvy1M96sjJZuZejIPhBGUZclDZWJlxec
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230522 01:07]:
> Use mas_empty_area{_rev}() to refactor mtree_alloc_{range,rrange}()

A bit of a short change log, but looks good.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 57 +++++++++++++++++++++++++++---------------------
>  1 file changed, 32 insertions(+), 25 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 4eb220008f72..96d102d60b4e 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6493,31 +6493,33 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
>  {
>  	int ret = 0;
>  
> -	MA_STATE(mas, mt, min, min);
> +	MA_STATE(mas, mt, 0, 0);
>  	if (!mt_is_alloc(mt))
>  		return -EINVAL;
>  
>  	if (WARN_ON_ONCE(mt_is_reserved(entry)))
>  		return -EINVAL;
>  
> -	if (min > max)
> -		return -EINVAL;
> -
> -	if (max < size)
> -		return -EINVAL;
> -
> -	if (!size)
> -		return -EINVAL;
> -
>  	mtree_lock(mt);
>  retry:
> -	mas.offset = 0;
> -	mas.index = min;
> -	mas.last = max - size + 1;
> -	ret = mas_alloc(&mas, entry, size, startp);
> +	ret = mas_empty_area(&mas, min, max, size);
> +	if (ret)
> +		goto unlock;
> +
> +	mas_insert(&mas, entry);
> +	/*
> +	 * mas_nomem() may release the lock, causing the allocated area
> +	 * to be unavailable, so try to allocate a free area again.
> +	 */
>  	if (mas_nomem(&mas, gfp))
>  		goto retry;
>  
> +	if (mas_is_err(&mas))
> +		ret = xa_err(mas.node);
> +	else
> +		*startp = mas.index;
> +
> +unlock:
>  	mtree_unlock(mt);
>  	return ret;
>  }
> @@ -6529,28 +6531,33 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
>  {
>  	int ret = 0;
>  
> -	MA_STATE(mas, mt, min, max - size + 1);
> +	MA_STATE(mas, mt, 0, 0);
>  	if (!mt_is_alloc(mt))
>  		return -EINVAL;
>  
>  	if (WARN_ON_ONCE(mt_is_reserved(entry)))
>  		return -EINVAL;
>  
> -	if (min > max)
> -		return -EINVAL;
> -
> -	if (max < size - 1)
> -		return -EINVAL;
> -
> -	if (!size)
> -		return -EINVAL;
> -
>  	mtree_lock(mt);
>  retry:
> -	ret = mas_rev_alloc(&mas, min, max, entry, size, startp);
> +	ret = mas_empty_area_rev(&mas, min, max, size);
> +	if (ret)
> +		goto unlock;
> +
> +	mas_insert(&mas, entry);
> +	/*
> +	 * mas_nomem() may release the lock, causing the allocated area
> +	 * to be unavailable, so try to allocate a free area again.
> +	 */
>  	if (mas_nomem(&mas, gfp))
>  		goto retry;
>  
> +	if (mas_is_err(&mas))
> +		ret = xa_err(mas.node);
> +	else
> +		*startp = mas.index;
> +
> +unlock:
>  	mtree_unlock(mt);
>  	return ret;
>  }
> -- 
> 2.20.1
> 
> 
> -- 
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree
