Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ABC6EE601
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbjDYQqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbjDYQpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:45:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC31D16F12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:45:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFxdKB026282;
        Tue, 25 Apr 2023 16:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=n9VG6MiWIhxFdx4S7ghdCZoskIUfSC7v2+7rdSWIq2E=;
 b=mzPzBXknIUaOmvWPEATdx7KmFM4Tb6lArZXnnIexc1J6wJOGrGUSNOkDDuEEUMGunkRQ
 jGQRaLPVGmeH/6zjfIkYL3RDN3dDJXjjkzCuvInQOEIHekNg99pbbmo/sjHgfCtwx2pr
 lsntiGCRlNyRbWj4aR2Lb8x/yUF7vL/qMgamrWdVtLS/4LAx7wulVzy275r2vwOd+LaW
 jvELAjx/meS7zPoZzdQcLcSmwXagTQckkiF2ZRus/JQC30CIkb0fmmPMJFQmhksOERcg
 IB4o03OaM/f2UBXqb+JQFh+8nriAfIP4pTlVr3cfBw+2UXKfNcdwfuIJpIWBrCDYY3Pk Cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q484up7rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:45:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFx6i9032806;
        Tue, 25 Apr 2023 16:45:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616xus6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:45:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkMkQzn38AudnTnSuRGwvhnhGoj0WCqfFVHczzYdahKlxv3btUYH2Cb4OwJn1vMbp+KxDkon/0yCk8GR/9zyNoelEnkFE+X0SubgIm2D81UznFA2QY1i/vgqr5hECJZrq8dDtZnFQVc1R9BaYIZBLmQHVObsuRaQAWHgHLXzL5J1GD5u108Wc68L/ouP16m6Maeo2XAS+eZYB2/WotGQaTeJRDKnRKSzLVBqqh3XiVWO8BZKCfwuMqd1iUridFZoVTaKipGee9T+JBYKL0+yTT35eSEQs6AbKoGLYqPEeTjRfdNhir8ZcFHSEh63fcmc5vgF4LoBiD0mCLjEVsdnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9VG6MiWIhxFdx4S7ghdCZoskIUfSC7v2+7rdSWIq2E=;
 b=GEK8Y+7h7Essgjvsoe4r31PanRH3z9gIRMm0E/YnybpBhhUpTc0QDow9v2Lp7W33Sz8clzf8su/IzE0opqV7Xg6WNrWnQ7uJQZcLAEwlD5Ir3pYkFy+RYQ8j42cuYHroKIFu9zFwqw9v6VpovgAtOs2GMFnCJObUeLnCRfzTzEPsnh45xd6J8IK0wzKF4Z6mQoN9Fn5wSPRbuSWOA0xPY2+MprAR8wI1GLVvmkevwW9725mpVh27uSetYXk7ubNg01+MDyWaVet2ZE7EvCxC/E66fL5fThD/NyDebnQOYQXgE0WHp7/COIIl9UAjSJR7RA4KwNL9OmmWBk05gkMLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9VG6MiWIhxFdx4S7ghdCZoskIUfSC7v2+7rdSWIq2E=;
 b=UkJLEx7uz2P+5U4r+uuQWOMCiTCssomfvP8/SaE2pQVTrVU3lN3+0bWiAvT9ZpZO53bf7DaWkH5pymPTkyi1HAwt2doXmQajUeJzGAzIhPD1kEnzyNEJAMXzDmNHmi2vx62ABEztZ7yHkO5bhR3RE9FfTKj713lSBT/20Gg6Erk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5363.namprd10.prod.outlook.com (2603:10b6:208:334::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Tue, 25 Apr
 2023 16:45:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 16:45:10 +0000
Date:   Tue, 25 Apr 2023 12:45:07 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 7/9] maple_tree: Delete redundant code in mas_next_node()
Message-ID: <20230425164507.dulntzwtkm5mp4ia@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
 <20230425110511.11680-8-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425110511.11680-8-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: e9597da0-dbb6-4423-f88b-08db45ac6ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjyVOeegrtp0H6Qext1C0A4BXiGsysK+H/b6ncq9qlR7/TBBJv89P44wX03QfaVuO7TP1v0TdyFvNrgzSxdGH9ja4brKUXkD4FcaISOInog4My8MsTrzV++/i9o9woxk/PIdZSjNcc13IAkduaU3iJ6IuMFp/P6M9g20rDvwkb/6Yi1yBbxbXvTxIALS6rPsIDaf6BUbkEWJeRTyqkkX6sI8HcJoCsEO347VDmDvQ+roxQ70SmfB+7UWy8RqPxIWoyh3sk5vckAuID082SPKeQRYf2uC9kvgVb7rqent/0W7PHs0VGr5piUuK8tk46gLSdJyLvkr4qmO4rSTych9nifoLl/wAGrG/OyQoqwmiehNuBY+rhuqPHponxCdWKKNcZHn+Mx+V5ty5weFFenDb0bIcevDoYwM2Hxhl0IU74mJ9oxzPAAHSVqA1MxfYAHIWJb4sxBHI7D9to0IplqyQ6r9djHWa7VjsMlRbmFFhgRnkurNDLh9ZYFYRIkDgIVvcJa7z67LlbEJSPiY4rC2elT3jAUoOUCMtUXi+cMBTdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199021)(86362001)(33716001)(2906002)(6486002)(6666004)(186003)(83380400001)(1076003)(26005)(6506007)(9686003)(6512007)(966005)(66556008)(6916009)(4326008)(66946007)(66476007)(478600001)(316002)(41300700001)(5660300002)(8936002)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FRP0qr2C7Q5HrHCb0YSjXspiVi3t3NuntG6QbdZ1OME1/gtaePyT6XSfoHq5?=
 =?us-ascii?Q?tRwghkG6n2SUDWNVePmItObeVZPfdKSTaBr9KFONuB8F6N5OOXqSxHAmlmEn?=
 =?us-ascii?Q?DQQfNdK4bZe6McDAxMwtoKSLMI+2A7DdtcYdmOVamSTZZtaPnmCBsiXUJRrd?=
 =?us-ascii?Q?h6BwoF+rr2lfwB77ehxOFYRILwgotnDqQ4+XN508EfSPg/uXp2vRdpvdjD34?=
 =?us-ascii?Q?9BRIbJEw8kcFOWfwuK3Jvq1jc4Paw8/zvv0zQkXepukKxe/cKPSPxai/A+8/?=
 =?us-ascii?Q?lQGASGd5MqtJxy/3DHMlLf4MfoOmm+Pe/1LH98UuCCKIxHcTZ3EOiBwzLm/m?=
 =?us-ascii?Q?ryCcFCCdPE8vgNyVliHpE0z9Tre7UfnH3/MAVnLxzQIQYyCHI4SKK3kY1P78?=
 =?us-ascii?Q?6qYPNaHoZ9eKETJO25qpoKm/ndOpKrQUY3EI9VLmvq/6YRcfM4P5212Vnxtk?=
 =?us-ascii?Q?X/tq7ORtgOFBQnUtMaSn58lVkyla80tOD6QqfSuqW6CI7GNzpj9pZaPzBgxw?=
 =?us-ascii?Q?u+nCj4PNHtpBH2ClAkK0OAxORh41BVimo/XdvVRzZgUI3/qHXSLj0Fdln+Jh?=
 =?us-ascii?Q?MCyq4W+7PV6k+db/DjqFbe7C6lCWWoR/byWKnjemYMNLg5LI1awzx0omtdg6?=
 =?us-ascii?Q?mwu11PvxlrmiU9FyUkNnpE2u3wY8mm5CFFGk/U3RjjeiMLn3IJhkhZHiXaxK?=
 =?us-ascii?Q?IruBj0F2iDD9njuiU+WSR9JfnPEVzlVKlepY9GJ2zPRNjhUufwDFUtX+E2ur?=
 =?us-ascii?Q?SYSHW8pHOjM/KsmlCeFS1HU4WGK4Me5X0hsc7DxwfKkHRyb9aXFLSdZO5PLK?=
 =?us-ascii?Q?Siz0uXRMZW3Z73ww2/eBU8561hOV7DlTX/SfofK1R997h+IstCCPMBcnCAOE?=
 =?us-ascii?Q?FmACU7ZK3w0KEy7rdST9WXRFSR0lvEDqW8wVqUMyi4vtIYxywxqThILeQmq5?=
 =?us-ascii?Q?DWmbvMiNDZaF/vn3b84rci0g0v6VuGjIdSNWxbX9sGKX3g9JWQVdiZNX0+jo?=
 =?us-ascii?Q?B703VtFLELlDMovAY2azXYao4xf7yIbA3XpQpZEevx5+kDEXDEL1yiVAs5Zy?=
 =?us-ascii?Q?321wWKQ+LrOoCdiKWO0xWfdyDwtM/9hjRhLkFcUYUFL9GxV5gPrXbz+CFL66?=
 =?us-ascii?Q?v8CJ95OO2Fzjzx+5O9m6r6ZAbTCcbDaTLCCHEyKjNWPvXuUqVdCHjwC5ygLM?=
 =?us-ascii?Q?RrWBlbd+CuXu93InjDtgFLluXPVirXWsvuDV1kl17gdqpgxFL+TBMOChv2H+?=
 =?us-ascii?Q?0D3AT6YMnIMORootbWUuC6I9QwLQjDOcrPlgMycO2fP7exh9oa0qg3N/nZbI?=
 =?us-ascii?Q?YvOO5RHBzvvHb28lRbA5VasUmpNVs8JPSAQjpJ1bpt8YWhbv4f5JfREdEQ87?=
 =?us-ascii?Q?pw3MFx5cXRPPgP7SZwywzmz8tkA7C9aPZ7wq+ZoUKZJ/6jWAxhwnveEXiLtF?=
 =?us-ascii?Q?nL5oH6h4a40J/O2SoX2MZHmMniLIY529K1AiKQ70W8srw1KyS8vuca5cKkuF?=
 =?us-ascii?Q?YkYufWEv05dYUe+GEABLDZZXnRFhxq0ylaCaGzpwXw0D9Rglpou2jnAb7kUp?=
 =?us-ascii?Q?looevq7PI0lHPbZ4mZygMzdOjXPFhixyXrOJ2xcMlthYKchNLF8NabfsoKrZ?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DL1eTuUZGcbnxWvaSOzmO/Ky4Yzx9paHHMmcANAC7fMy+HjvSnCydrKwGC0I?=
 =?us-ascii?Q?hMX5sX9Ha4Bz/6CFzFDGyVVYmelvD9lSz4QSE/k8iTZ84yZ/wI1yEqv7fjZT?=
 =?us-ascii?Q?l8Tz8bcj0NwHJZ16M6YEoU9HbvdRK0E7xs34EfFqFH3swpa8wfS4gi/lsv40?=
 =?us-ascii?Q?+p45jZfaPK4sekvvcWDnVpcMFmcAH6XwHeEh8Cfujp+tUZ/93ouqpUuFjYGr?=
 =?us-ascii?Q?zZca/keYWYcbypDiS4dLgnBWswSA2VZOmPN0lGUrAAAEQUXpBFavs5FuzuqJ?=
 =?us-ascii?Q?2v5Nb3MBUZdM7IcUxTWETny3NCBGwI6/umpuQOnOeH284m0tPBN+cYXeb9s7?=
 =?us-ascii?Q?Z/bZcttrftXqbvcgjJy4PZKhRjfTCKAIHtYh2p1UkiNAv+aDu6IjiAForIRo?=
 =?us-ascii?Q?H3QRlRPRKkV5C9Tjpns750k0jCW7KytZ+iO31I6oqhBkBpE1oqbRio5wvtEr?=
 =?us-ascii?Q?Z0/hgku/2QbRdWm8/m/pEi1YLMMLjrVf5I1XZlhXIrpNKcj2MIYs4WYpJhIJ?=
 =?us-ascii?Q?TFJQaGnWgLmTJtr1d7pt/3LVuEtgbj6CmM4/Hllj4r9z6oA5icr06CfFPDKd?=
 =?us-ascii?Q?KDBaBxgd4Agu8iA+J3Gt0JcaOjYKDo4b+bornaWAfcBVXWFwIZsYOpq/5I65?=
 =?us-ascii?Q?kapPJaD40xY0aVlyWtW6ecR9MZPh3IUB+d0tWmT8O0Ou376a20RkZ07IybKi?=
 =?us-ascii?Q?ZvsQVgFKgjogsTusLloGdvG86rNuPQGggdEKxNGiLFHlolD/wHR4HlHhlRZZ?=
 =?us-ascii?Q?8UFxHlZJLs5ms6LQM4AP1RMI8/WjwpGGoIH7+lwrzJZ1zAgcbb+VP+/hlgy/?=
 =?us-ascii?Q?0fiirWkUeploX+zMizmYyCpW9KvRMG8slopkcYhBgjn7akJhYqNtB7nynqs+?=
 =?us-ascii?Q?4ZM85zEtjFCWQw5UkOCbl4HdBt4uJSeG9D2CU2FdFC+S06gakCI0oQi7c+gS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9597da0-dbb6-4423-f88b-08db45ac6ecf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 16:45:09.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NeFH/gRwVV7ClSRGm6m8b4vbQ2yo56HgyUBHMcLcmd5iMZAVfEm27Q5eShbHhZhoNjW/KpQiN+kmk6Jld0S1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_08,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250151
X-Proofpoint-GUID: WCjIdNiqHPydPrBYotUrzMRwV6Trna9n
X-Proofpoint-ORIG-GUID: WCjIdNiqHPydPrBYotUrzMRwV6Trna9n
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

The title of the patch seems wrong.

This isn't redundant code and you aren't deleting it.. you are moving a
block of code outside a loop.  You did modify the check though, is that
the redundant code?

> When offset == node_end is satisfied, go to the parent node, mas->max
> will not change. So there is no need to update min on the move.

Please try not to state the code in your commit message.

I have moved this block of code in patch 27/34 [1]

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 83441ef2e1f57..8bfa837b7b752 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4616,7 +4616,8 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
>  	enum maple_type mt;
>  	void __rcu **slots;
>  
> -	if (mas->max >= max)
> +	min = mas->max + 1;
> +	if (min > max)
>  		goto no_entry;

What happens on overflow?

>  
>  	level = 0;
> @@ -4624,10 +4625,6 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
>  		if (ma_is_root(node))
>  			goto no_entry;
>  
> -		min = mas->max + 1;
> -		if (min > max)
> -			goto no_entry;
> -
>  		if (unlikely(mas_ascend(mas)))
>  			return 1;
>  
> -- 
> 2.20.1
> 

[1] https://lore.kernel.org/linux-mm/20230425140955.3834476-28-Liam.Howlett@oracle.com/
