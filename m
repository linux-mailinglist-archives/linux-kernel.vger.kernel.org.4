Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C7B7070DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjEQSfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEQSfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:35:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9953F59F6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:35:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGwB6024625;
        Wed, 17 May 2023 18:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=FCX4sq9GN93QJ0lnQOp9MqK3uLDzxAK8lJ32HvSpTrw=;
 b=EpAh9xsKCfq5k5ysOx6XvInOrg73Z0j+z9Bs/87lQBTqGJz+AEXS2q2d82YIMyizv0fT
 ujv8zWlPLhJ/gNZQRwLwps4S8h0CwQVLMU31GXIwEc41B9pG6pjSWWk5WvTFrBuvSCKG
 2rPnTZtzcqmRu4jq6x1u8AdN3hUz+1Wp7fC6LHr7R2gla4DNM+Mt0aOC0ayo1tN21h9a
 qpYuMIaRxGszwXzE1FTEu7DH6zBAsw7UGx80wN/BybMbg88iynOgk/jK/PKeTPd12pKz
 WhlPuVaG9g4a4gsSZPDPgZMxJaViV7z6rYhGamzqcEoavCf09Mil4k9Yw1NBIu1R0YVA Ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpgvcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 18:35:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HH3Rml039947;
        Wed, 17 May 2023 18:35:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj105j5cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 18:35:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJ34uFyh5biCjs5iixSAowGXk4b6xmVp2lNPO1jmI17HfcItS9ZzRw6TWsQlhp+2LSuSgk6kmc1IiqEGJOd2jJ209rccRuxcKCdxVbcoWAsBMC2KsF7Kyk1D0HJGt0a6x3uSguYi90cngWhPN5LiO5MNjEwXt1RGPVU1cAgO9P5Uj9XaqvkRHdAH2awcjTqUG33HWQH19HhueCXSpkj6xOQbx8cocxBIsExgWM4kkW2hVLGScyTD+ZMVEmJ71xZ/M6zeN0liXvN1JcpiE0ZPgxbqtXRSXSbskFuJqjzps740ZhMsSrXRKwxvIIbaLP+dNIYrEMeolMzAH93m1bwPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCX4sq9GN93QJ0lnQOp9MqK3uLDzxAK8lJ32HvSpTrw=;
 b=Re5qbJ304u2qK1plUn/PbMIMavnPf7kW5MF2rchYRkBiyJD7yYtzbLzplAEZgL15Gx+9PFUSYzq1zouRm2xWd8jAumg02sIV5a7cSX+G7J+Wkg4OXQbiLOrIFwV/mlym6X3bri5iNZvgx1N+BaxEG9LRQLqyMyGJdiij2lBInWI1SitJg5Vfnh6RTWWyVR7XuObCO6B3qyYHT7ay0VU605o67cM2Q1HZc7MxsFL0ULcUggS5sgdXREXLLZDbBRhxhzLQ5ADARYWCiyMlVlFCauFcrvc6JbigobJDImxFfoeuN4DMwlX/jIgGRhga7GwkHPs7YqBd0im2DWiqS2TyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCX4sq9GN93QJ0lnQOp9MqK3uLDzxAK8lJ32HvSpTrw=;
 b=XK6bWftF1ri5CMP2YBmCIYCmHXYwg0172VtQRzShYVsyT1s7Sf1vJ4tlryO/AKgPEdQajQlvTn226BVLFwSujj/oksszD5Km7UG16nGJMGOeBq6dzMtvcJ295gXUa9S0vBs3qZzsNqzsb6ddKBle7WBJkFKeVv6ebw2rmbfM5H0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4416.namprd10.prod.outlook.com (2603:10b6:a03:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 18:35:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 18:35:30 +0000
Date:   Wed, 17 May 2023 14:35:28 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 04/10] maple_tree: Simplify mas_is_span_wr()
Message-ID: <20230517183528.wikjxw6dup5gt7ln@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
 <20230517085809.86522-5-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517085809.86522-5-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0183.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e07ba1-5cf3-4a75-e7e3-08db57057e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2f17PbIm9/a3gfXrv9w7wMVy5At/16qZLpGr0KBwPu5842Ttnoby18IMVowAOKAYdyN9MUuSghSiTquLFYFfCApRSX7mNXh4HKAC3FHrYmTdI+xzf9NFGWSDWUSUdgRhzxazZgpV9OR4xw+nvjVm8wJyTU/n2ittN7HpxaiMYwImKBXqyrI56AndfpiSaYuIbqhefCdv8pTAwdb6PPvqU99b6/AR6fteNSINp2Y9yBvz/Fl7+MazaoZxkOamTRp3isImCLLl8BnkYqYt+jBEsJaSWwGR26x0n3RWZ5bxcSHQXzj3ToQ9vmaKA/HQp1YgqSpKglH5swVo9mcRtoGCaWH13N6wWwhy/e6aHvwbBll6iChmPnluPeOKKZNVWytEsFuXcNk0GnrAfvCIYh+jWLWWKrST9Y6cwIaTcDQyUzXD75QZ2mgC2JaTWGk5ggyE/mxDkXLvQK7iCXgwQ3d5oGlxhSE/VaFplpWnGOJsifWpBWE9TWD//f3GzIQUDid7Hw01EPQqmGDryd6Ppm94aAa+0HAMPhIxMPiJ4kSNGcDcVD7tyCMH6dFJwMxJ4y9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(9686003)(66556008)(66946007)(66476007)(6916009)(316002)(4326008)(6486002)(478600001)(41300700001)(5660300002)(1076003)(186003)(26005)(8936002)(8676002)(6512007)(6506007)(83380400001)(2906002)(38100700002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U9vv64FnSc2cJRbNXrJ2SxjTftdRDXD9t3xUB9cMvIBNFkJlm3GSzVQRRDoc?=
 =?us-ascii?Q?rXRY2fL0b5VObC08/IcFb1PsgPFU6RzK8RXVZlrmq7xBtdncvKWdS4BtOEXa?=
 =?us-ascii?Q?u5nA5JQuB2/799Z779wtccJGW4JRXHzSrIpal8SwAJY7Lf0+1r/Rog0AH9FA?=
 =?us-ascii?Q?9kZTb1OtaDQt/GLdP2+firxHsa/4u+bIqGeOA6qQnOlhHgbLp7ZtVlzzsBzv?=
 =?us-ascii?Q?vIjTTRLKZ+lpcokcBjQ0GoKx1GkjwrYlTBxNu1ZKPYU87SKMsovQsEtwk7cn?=
 =?us-ascii?Q?OZxdTtD649y+1gOtXzdKRkT/7Ewr3o4szE3Y/x9A47iXtJGeCnzCLfnXTdT3?=
 =?us-ascii?Q?QlOoHWXltb67ymCj96vmZ84l2GQDbVdCPmxur6R/Bfsn26bog0+GukKZibUZ?=
 =?us-ascii?Q?7Xo3J1QowNEfA3FZNfDThcVAQ118P1dWqITOOTx6b8FhtJ/YStAtcDbl35Yq?=
 =?us-ascii?Q?0enXEyJlsR8/jCIGZM77ITvfBms1O6LmZsNaCOBgeTDsl8+s3A89u0+DvO00?=
 =?us-ascii?Q?rR0ZnQYma/QlvJQrTCY7tf1dHbu7qTZ9FYoylrGpUiL6ucZ2xqDIUc+o+uea?=
 =?us-ascii?Q?pgWWE6bscoqQFFpKxhgocmedO3tbnLyRtbq2BlGliIULKKZLNm6xjLGBdiEa?=
 =?us-ascii?Q?b0WZCywX+nJr2ytbsVEsy4ySgHudyffeuNQjJiBAQlQ6epuPk14RIhBLdjbI?=
 =?us-ascii?Q?YxCTYmuoEhwPCbbmTZ+FXOlUacNdPOmSQ1eC5hgn97+y2pMiXHP7OziGr6/W?=
 =?us-ascii?Q?0byerfkWfRJdWbkrqsjk4Yo8TynnewKlPVXA7XziL6DnbLeMoHD1o++pe0PM?=
 =?us-ascii?Q?ukF02bTjwq8vGEs9yV9as9W8nvLBZ0N57U8ka5u9jWGzMQIQWpAfAotcsM5R?=
 =?us-ascii?Q?Kr9Oc0wgmw9hFVAv/rtDG/t7weTbv7M3nQ1orghkD97IiVzTcw/4YAANOsUq?=
 =?us-ascii?Q?PqzE8WaXqV8olFu93QlJlJA4ADjhHUGxPYAVVfLPj0zfoptmFdbp88Kv4D7n?=
 =?us-ascii?Q?A+wGT/4mXMJM5DoyCLwumWyIp/MMZvtmqo7sDtNn08FidZUaK60CmOgW1TBi?=
 =?us-ascii?Q?WHgwHDHf8o2R535R3INNA4anSf2AnlcikANukE1BzTB7mYJyvai65yfyEeCU?=
 =?us-ascii?Q?VOkICkk7PJlCXFeJAmAdBkOp6ueonNxKPkM/hF2Ft9rYDh3Jfxl1dz2aNhIv?=
 =?us-ascii?Q?lp3iaPqJl8ANOPXAK+f6e3C4E/HUuyVHhs9FNJXduN7km0N6Ec8KrgxzAS4+?=
 =?us-ascii?Q?UNep2IibkP+YTP0Lkartkf/BpfCse4m2WvICKdjlPa7KOv0sHuHcq56m/sqE?=
 =?us-ascii?Q?pudoDZHIUM/akdUmFuOJrpYgAlYW0X3xQ1WE7EFBeglTQcaoEpu3UdWj+hEf?=
 =?us-ascii?Q?0mSzu5DUPqKp42LPPeRfe219Yo/Mbc7DZiR2D/8VFDFIzPp1J8pPrgVIxExg?=
 =?us-ascii?Q?0Wbqjv8TbpGmaDZB+unTYcbQz2r/f61r6kpAmvkx3fGJ7l+jf//PG1/qi3tH?=
 =?us-ascii?Q?8LDaAWUpkROuDCt8KwWdx1lVCcjU7PwSRccFIkpRuWAf0xQJpbRSIcZFuwlh?=
 =?us-ascii?Q?6aeY6ke2qL4RKaSXN6R/7kiCVwIOj7Bx7MB2Xs+iqzUi5VwYuE+cCvbMlo8S?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ay2Rilkk5r+l2yhhCY3fS9MkIB6UiqxKdDFpUqwle4veGjpLaGqfXI8p1Ihi?=
 =?us-ascii?Q?NTYAUznjfQaswT2RdhjOOwcp8zE6r8KNdyJOn8gCZfdtunNbw+kweBIuElAB?=
 =?us-ascii?Q?zVzk6/uGusGWTVI8RVVrFMxWoSMoTJS5BWeqYQp1+VuGYxxUCUbWqqtAXsF/?=
 =?us-ascii?Q?lwNfF990VSx/b/9Vj6kmLHx8z12/BJ8kn1tAD6JO9bOclVVYkq4vFAg1asju?=
 =?us-ascii?Q?rQS0+lVCEf3UHagETK+to+QRWr9nMSqvpCfXfGm1lvJchlbl087QQJfh1e9w?=
 =?us-ascii?Q?CwcfTeCJZ3BD5pyarfMfoEtkwCXWMSdNMiI9ejmnIxkk+OQRNHnhXB2kg8Gj?=
 =?us-ascii?Q?wMu6JEmglTkrAhbfujXqJBObGhhx1cgURuwOUfZ0stPpuzFDi/PktLfZrjIu?=
 =?us-ascii?Q?CeO7HNnPJxXyk/we1GX00/7QSojaRTLER/o4RMfIZD3c6bVc1IqSZivuehWW?=
 =?us-ascii?Q?9mJM1Fd3yxRrjpG4Qgl3xNuzp1IcvzXbbr4KvUgzFCXLDF/+Z76/1rcbt+Fk?=
 =?us-ascii?Q?2h/MuzuXcH5BucD3Ewr+qqZBQBbtTY2wopO8z/q9Mrjf1ifeDX8nmoXmvZfS?=
 =?us-ascii?Q?ta+zfSIDxifXtLKVAiziLJrc8BZmmwKPgkWaNjfR06GkO8YtXBbNQ71BlWuj?=
 =?us-ascii?Q?Al3qcveFLNxUN0NaV7q2sExykVQUm94ydk4gFxqh4ULrO70E8CHE7mFS7r7/?=
 =?us-ascii?Q?NajbJ5jhtQQTe/rIpyKHFhSGGKyi9c8air5Jkjv4Mcsuc0E5oFX9jo4tjbjQ?=
 =?us-ascii?Q?OaC/OFsMGqna57j6D67YZQjivoRgVYy/LOVFUead9b+KZBr9TQj2ctyxaZ4g?=
 =?us-ascii?Q?/LW17HtPjdWiFiCxEnZRz7vjpQ2FGwlWj/irfzsioUr1cwJtU8HWDMMx9JOD?=
 =?us-ascii?Q?ZQJHUGkCHOqAiDq3QMGJ9WJaMt87e1/73PgZ2AOOP4004yaGPYuWeR5SGXoK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e07ba1-5cf3-4a75-e7e3-08db57057e1a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 18:35:30.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2gWcTtebqisvTykrksFfXHqI86VtiHOaftOrJPciaO/Br9KJ92eJH+IfA5Hq9siwzbsUOFF232M+t7I0EH0rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_03,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=298
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170153
X-Proofpoint-GUID: Jj2MXIamSzcmBklX0IMMlEdRCwUaDuw9
X-Proofpoint-ORIG-GUID: Jj2MXIamSzcmBklX0IMMlEdRCwUaDuw9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230517 04:59]:
> Make the code for detecting spanning writes more concise.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 42 ++++++++++++++----------------------------
>  1 file changed, 14 insertions(+), 28 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index bec9906b0c8c..82dccc660889 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3728,43 +3728,29 @@ static inline void mas_store_root(struct ma_state *mas, void *entry)
>   */
>  static bool mas_is_span_wr(struct ma_wr_state *wr_mas)
>  {
> -	unsigned long max;
> +	unsigned long max = wr_mas->r_max;
>  	unsigned long last = wr_mas->mas->last;
> -	unsigned long piv = wr_mas->r_max;
>  	enum maple_type type = wr_mas->type;
>  	void *entry = wr_mas->entry;
>  
> -	/* Contained in this pivot */
> -	if (piv > last)
> +	/* Contained in this pivot, fast path */

Thanks for adding the fast path comment here.

> +	if (last < max)
>  		return false;
> -

Please have new lines after an if statement

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
> +	if (ma_is_leaf(type))
> +		max = wr_mas->mas->max;

New line here too

> +	if (last < max) {
> +		/* Contained in this pivot or this leaf node */
> +		return false;

Since you have the last < max check earlier, this is only needed in the
if(mas_is_leaf()) statement above.  Making the below else if() an if()
should work.

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
