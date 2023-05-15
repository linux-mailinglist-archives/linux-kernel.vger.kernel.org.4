Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729CA7034E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243162AbjEOQxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243200AbjEOQxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:53:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748C465A6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:52:58 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGn47L007037;
        Mon, 15 May 2023 16:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=JDDpXR1ybM4KbkHVafRgDIqgO7cEfzt1eBUnB/m0O04=;
 b=Uf1TzEIRPH8aqBiKZJwsMrx9l4ELdgXb/QsV5TTyPVtjuv8OlhNkw74Y1oIBM6G4tZZn
 bRtadX40YF+qsKHsnVd3a/AgWmwWZVZCiImfXHnZQh5Wsunlw2l5y+GywT8s/a0xhMMA
 p77+ReCDUF4aa83I6FdYf/C8ct3s5giI0EidzTyBLteM90lSV/va6GbOIAPIJdJtLgGt
 bPACwZOomaghK8dfipVtCu/nNXtp+MlC70gIIv6HoQ6y2pj1syTFKTIPRzs5mQ4mpZce
 YJzvkC4VNS8hNboexmz+gXzUdMsHWvFRIZwYiXvkhDHjdNQV4Dus0RUAq8v12cCnzym9 bA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdgkqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 16:52:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FFDpjr036934;
        Mon, 15 May 2023 16:52:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1095vbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 16:52:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Itw+ytZPlUU2+JH4ntY8GYQyIy7L5+rR9Lb0dz8fojeNYa3dJf4TTAx7TkaMWaCoGWpUyJXfSs22uVoDUY/ys/YAAOA50ojBw9HG39d7w8TJhXd9ZAr4lEa6ORwjLaMK0pwO1v5Es36A7sEJoo1Gt13JvEnRyd2rjuaqNIzgDMvZ1K+KYrrYoXclLf3EMCZ20gQKPgGcg+s5OqdFxCsNhtHz2wE9iu2c2wqh0mqpt6R1wRnY8+kGapYivTMdjzu/Z7OacURA7YdRdAq8xxVUmQFX9Hmbrv7To5NyHawUrIXSl6Fw/7DM/aZJls/84GsAbnyZo0awdNvnncQH2+r/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDDpXR1ybM4KbkHVafRgDIqgO7cEfzt1eBUnB/m0O04=;
 b=OH3MhAMn45yntX2BycHABwOfOSJ6VQT0ErryuJBQbTE32vLWAdNRXJ6v+d74wuj0tkUfbZ5KMIoxEFUeDuDbh03EWJpaOJU5oHDeWP0yc0jhYjkj+cWSs4Q9frnbWZzPwstb79/xvFjK9eVY39kuTy4B1x9bZJzqT9GNe5YfAcCEjPNAaLXgZg3khpBITYesmplJOaloe7vht7+w9IYVxOkVnzBu4+eo1BO2UAGFrPyxTjK+988Iuf0B6wWxHFJMJI/o5XuEyy5rbry7xPA6piDdnoEB2fAT2rHGDHMCGY1L2ycR0jC50+U0T5yaK3Cgf+6LuoqFYO5rcKwBZkqgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDDpXR1ybM4KbkHVafRgDIqgO7cEfzt1eBUnB/m0O04=;
 b=qOlv1mIj6qrN61WulI7ReIyjn4dMnz9hqxnfXaWFrhr9oMIl0y0d4YUwkgfa27vyZujx9d/Khj7fjXEnjaWFljy5m7LtVSmr/kxfLUpPmpu9C4MZmqmvtZ4yIhNPNiSzFL3PVJsJXeYCmz/8+TM6VsoVEbcF3oX9RoA9ckTHm38=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN6PR10MB7442.namprd10.prod.outlook.com (2603:10b6:208:470::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 16:52:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 16:52:24 +0000
Date:   Mon, 15 May 2023 12:52:22 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 01/10] maple_tree: Drop the test code for
 mtree_alloc_{range,rrange}()
Message-ID: <20230515165222.dqlazo2lg723ael2@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-2-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515131757.60035-2-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0084.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN6PR10MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e9e932-7d57-4d0b-6bc4-08db5564c237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLr+5w7qFWTRafGu7kWo8Q0VPjhRRpvbc1EaDL/TIgtYAcoFLcGVC7A+T8N4bqvvdOGKFT8b1XLkkalWH3CWPY3G9ePUW0WCYvakRfLpiISCKGTxc7VlfRN6RT7y699Pa5X7wIS/HhiiPBH/ZAYRuQe4/9shSF3d0hfoBo/LjN3COSl9o2eVLy+DDdcRPD6E5z8KRnhGGTRSY/7y7ETSKnZm5gkpMDuFChtXNR+VqehmqqG2vvz225hru7YHjRCRDBA1SqL3DWfHV7sVBNq7u8BfGqT439vrOCGUyFBb5x3/yhWdQ0C80/a4sSmDRUpp0ce3DHbKXDKyqdk38fzSb8Atx6KLvQNSgCLQamJYgNQVCSjkJvysqX28BtDrNhDW0K9lgKy85z2fezVs3+mOXe/w2kSZYslc+5cm/GygNS3jPI/CtF1y/KGoWhC0jdyf8r5cSzlxCKjm7Z5gVYrphcv5qVxsB6FhsMgjwYgUMJNtSnK4C+8llFU2Rm2MkZh46m2BXce75eFn9moifh6QuMhpYl+iNgKbBJyD+/3eJvyimN5AormAaJeYQ/rKXpLa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(4326008)(6916009)(66946007)(66476007)(478600001)(6486002)(66556008)(86362001)(316002)(83380400001)(26005)(1076003)(186003)(6512007)(6506007)(9686003)(41300700001)(5660300002)(8676002)(8936002)(30864003)(2906002)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m9iTzV+8PLNknInsWUOAJCFuxJ/TK/nFSOjHmvYLLL2RghFu/paCjRqDE98k?=
 =?us-ascii?Q?K8TIYnpABM+N7Bhb6cHuVzkeJZGq8/U6ocTB/jJO4L7b3KvZosN7X6V8oTBp?=
 =?us-ascii?Q?znFwQNKJ3RG8Xp46GxTF1e/m6L9I/FapyYfQoKx976Jv8r+N8hiqYvs8xgnY?=
 =?us-ascii?Q?y8hkN/nh2SJkvtSSfAOIxj8jVeRWmUA0YKI0n15kkcwgYCW8T0bOAhPLiEBA?=
 =?us-ascii?Q?OSRvlRxopxDk9gzEfpQGB4IQzZZ8KrFPsqyHEsbhu1q4DM2pVxJoAi8mU2pw?=
 =?us-ascii?Q?K5oS6HimuUvOhh/0YRBGU/22WwdIs64gzh2cEnzuCWvbZZqw6MFNTBD31Ws3?=
 =?us-ascii?Q?I4MCVD2IY88YenIjBKm/98t5Wa1jqEzZC1+eTwjF/btKzGqOmOboGIwHWPtY?=
 =?us-ascii?Q?OzKaTc4RUFFSvDimYj99gwElxqdYZ29kZj4D0PLG3knvBXmTVbs9cf8PKRyo?=
 =?us-ascii?Q?aW+F2MqKX9s3KbL+vTSaF9PHqZqmOs76jx4Re8+IeP4fpRrDT9eJb3bOrXSp?=
 =?us-ascii?Q?OR4Z40s1e7L8efqu+ILoy73v4PtdCPvr6GmVzNh37FeRiFTiF4Ga+FvUu5Y8?=
 =?us-ascii?Q?V7ASKeTw3SIk87H+iAJ8lCEKdpWNA6CCOY5HmInJ2pspsCQpOf4Mtb7ClIml?=
 =?us-ascii?Q?AO5eXBHF2iJPhyKU3xF5zfQCRqAsbv5LPi7G/tP+FmaFolqKzn0RcSrl6gSL?=
 =?us-ascii?Q?BJ04b/5m4iCTOjdG/6xQ4+UUGammNLHw8m4KKfexgjVsBWlRlVow1S38HCOQ?=
 =?us-ascii?Q?/fkIIlmeX9OUAmik0ervUYNjD4Il5QnGeMgkzaMukYt+8iQp9nWQgpx6busr?=
 =?us-ascii?Q?qBs0O9LOJkYlU52GgVnT80kr5kr3VlgH8KOnBkmUufnd4hIruUUMcsoUPTbL?=
 =?us-ascii?Q?XXQ4nz/wIsWaSlG1erajRpT4uZYe8HE5WT+Ra5WVy8HQCWzZybJD7yO33Tp5?=
 =?us-ascii?Q?VMwZrvF22/iDB6v5CHVD8gyfPWezGnw9Vb3b0dTBscwnuqZawecQl4W/7616?=
 =?us-ascii?Q?H/T0nqUZHqmRti6IVgWuJf5Wez+C3V0Hwknn1+TQDl2mu+BzhULwmrYucCBe?=
 =?us-ascii?Q?gXEzdiW2CP1A1wWuIUcOBkPmRg2nZ33HzdKKbMb2cHG5YNnlTC4e3ptIfo8H?=
 =?us-ascii?Q?G/7b3y6x9tweIX2FPHFd/IeySrpvtbsKwjJKSTExdZCHU91R6bjBrymSisMz?=
 =?us-ascii?Q?qXc3nApADlHCHx0xViBg8JGq/tLjz9U8fZzPLP2CTL8ATIYNDg3z9GuN1/wb?=
 =?us-ascii?Q?f9sx9DaVO1zQ3K7lDgPV/NQV42fsWl/vokWYRXgcnhZcsf8lIeYC1/W9dEhG?=
 =?us-ascii?Q?NKvDzfb0cC0T/s5gJ3H7s3x590xwc3OXJurIiS057r1v8NZU17G1Y+prdLZi?=
 =?us-ascii?Q?ds0oygVqU2HtY7QlFneomjG8nKOcNTe3n7TRe5IBVCLzSNmA/eyUFqH4XVQd?=
 =?us-ascii?Q?hMIw+03s77H+dI5RU8q1TFulo6B/PlCfhbvkNqWJAQiEfEKL3dttpZnIKjbX?=
 =?us-ascii?Q?BoWUmKDcsYXBRTw9QoMlsJP5xSTwTACMFkyS+4lC99zg2l10MtMIq76iqyfR?=
 =?us-ascii?Q?gej1YJwpKHLXIglKliI09N8mCau/biz7hIvr8C33FwsqBX6a0feEm7hhLOyl?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UPru0v/iYV0F6pD7CurDn/5pDgC9qgEbRFpMFs5oa9ryV05ElB4e192e+qyc?=
 =?us-ascii?Q?NYQ3xq0fImTSbaIPjeiUNxgesYWpPAsvX0BlTl0Gi/THglcarkOCmp9AgGri?=
 =?us-ascii?Q?RlKfx5YU9Ygjh2zjhCCtnR4+K6WxjqJQfjJSUAzz1XS3cahCPzGaDABLSj/J?=
 =?us-ascii?Q?KjKZGvSoKjIJi5FqaqpMV5mQCgUwJ3HeDgeV4W+ewKZH9J2PglLcPT0dc7K+?=
 =?us-ascii?Q?GOUWtpQHZeyyLwuICgBvHpES5jEMVlpgtqKqKVKfZ2UlGiHR4AJY56O3UOBZ?=
 =?us-ascii?Q?xdpyjCLFKCIjFZgV9ijSe5SzzGtmTAa6zj716jsDbUTOFC35FtjBu4CwOu3P?=
 =?us-ascii?Q?HSq4ujyoWVOedzghA7UZn/OOJutw3f9lfCL/0IDLqGuyu/CsiAxfvsEbXPxK?=
 =?us-ascii?Q?uByKVorNV4sDkVrTTXTbXKWlJBzniSb73Yv10VBbo0eQHCFp8/OXdK/snQ3u?=
 =?us-ascii?Q?zsOpGIKi5h1wuEzSimMNg6gWebXvsIFPKHdCdByzp/bQ5eJgvgUubVFEw4qG?=
 =?us-ascii?Q?7OJOURORx8PFMP1VhOsnmColvaf3eBvCJ6xunvM2cewcsqxypW2Z4Dop23sa?=
 =?us-ascii?Q?2oynFixSYZZ+3kbY5fVDVPgUccwAtHKhwwEl0smiGCIleS8D9RSlqYK7Vcy0?=
 =?us-ascii?Q?sGM85Dhqx/VqHVneKAukd3UGns8FJdMZV4tA+9MsDcQHw6zlu6ywV5GGrNHe?=
 =?us-ascii?Q?ISfkipZbP/toOKjsh/J5iLqFE6Dl8HO4eP3JciNcOuwj4EBQL73AGhpBqDNj?=
 =?us-ascii?Q?UUGF968XDakWJfvv1ZrJky4awumkngypLRuzDX/BtueB/bo3osh5YCqYc9dV?=
 =?us-ascii?Q?5KGQh4tP1/UNn8m10vgQGUrUW0egIiKgclrKOf9/BKl7jT9yXU2tM6zcCQjj?=
 =?us-ascii?Q?i8Lwpa9kNTDvN/yiDXOTIABkHWtRZvVr4P2c3EVuEzW4iJQlAJwBNw7VJsCg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e9e932-7d57-4d0b-6bc4-08db5564c237
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 16:52:24.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwJyMRB37WkW2TXfeIGfM+chTeJPuwsqHI8vcAFoPoDwsiS2oUkqqXI/QLAYqRmU0yIlqwwiG+kwnh9qG2uB1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150141
X-Proofpoint-GUID: Rgt6h1tIuOKPQOYbj7SoL9nvhetuDMnB
X-Proofpoint-ORIG-GUID: Rgt6h1tIuOKPQOYbj7SoL9nvhetuDMnB
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
> Drop the test code for mtree_alloc_{range,rrange}() because we are going
> to drop them.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/test_maple_tree.c | 389 ------------------------------------------
>  1 file changed, 389 deletions(-)
> 
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index 9939be34e516e..86d7f742d243e 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -97,42 +97,6 @@ static void __init *mtree_test_erase(struct maple_tree *mt, unsigned long index)
>  	return mtree_erase(mt, index);
>  }
>  
> -#if defined(CONFIG_64BIT)
> -static noinline void __init check_mtree_alloc_range(struct maple_tree *mt,
> -		unsigned long start, unsigned long end, unsigned long size,
> -		unsigned long expected, int eret, void *ptr)
> -{
> -
> -	unsigned long result = expected + 1;
> -	int ret;
> -
> -	ret = mtree_alloc_range(mt, &result, ptr, size, start, end,
> -			GFP_KERNEL);
> -	MT_BUG_ON(mt, ret != eret);
> -	if (ret)
> -		return;
> -
> -	MT_BUG_ON(mt, result != expected);
> -}
> -
> -static noinline void __init check_mtree_alloc_rrange(struct maple_tree *mt,
> -		unsigned long start, unsigned long end, unsigned long size,
> -		unsigned long expected, int eret, void *ptr)
> -{
> -
> -	unsigned long result = expected + 1;
> -	int ret;
> -
> -	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end,
> -			GFP_KERNEL);
> -	MT_BUG_ON(mt, ret != eret);
> -	if (ret)
> -		return;
> -
> -	MT_BUG_ON(mt, result != expected);
> -}
> -#endif
> -
>  static noinline void __init check_load(struct maple_tree *mt,
>  				       unsigned long index, void *ptr)
>  {
> @@ -635,348 +599,6 @@ static noinline void __init check_find_2(struct maple_tree *mt)
>  	/*MT_BUG_ON(mt, !mtree_empty(mt)); */
>  }
>  
> -
> -#if defined(CONFIG_64BIT)
> -static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
> -{
> -	/*
> -	 * Generated by:
> -	 * cat /proc/self/maps | awk '{print $1}'|
> -	 * awk -F "-" '{printf "0x%s, 0x%s, ", $1, $2}'
> -	 */
> -
> -	static const unsigned long range[] = {
> -	/*      Inclusive     , Exclusive. */
> -		0x565234af2000, 0x565234af4000,
> -		0x565234af4000, 0x565234af9000,
> -		0x565234af9000, 0x565234afb000,
> -		0x565234afc000, 0x565234afd000,
> -		0x565234afd000, 0x565234afe000,
> -		0x565235def000, 0x565235e10000,
> -		0x7f36d4bfd000, 0x7f36d4ee2000,
> -		0x7f36d4ee2000, 0x7f36d4f04000,
> -		0x7f36d4f04000, 0x7f36d504c000,
> -		0x7f36d504c000, 0x7f36d5098000,
> -		0x7f36d5098000, 0x7f36d5099000,
> -		0x7f36d5099000, 0x7f36d509d000,
> -		0x7f36d509d000, 0x7f36d509f000,
> -		0x7f36d509f000, 0x7f36d50a5000,
> -		0x7f36d50b9000, 0x7f36d50db000,
> -		0x7f36d50db000, 0x7f36d50dc000,
> -		0x7f36d50dc000, 0x7f36d50fa000,
> -		0x7f36d50fa000, 0x7f36d5102000,
> -		0x7f36d5102000, 0x7f36d5103000,
> -		0x7f36d5103000, 0x7f36d5104000,
> -		0x7f36d5104000, 0x7f36d5105000,
> -		0x7fff5876b000, 0x7fff5878d000,
> -		0x7fff5878e000, 0x7fff58791000,
> -		0x7fff58791000, 0x7fff58793000,
> -	};
> -
> -	static const unsigned long holes[] = {
> -		/*
> -		 * Note: start of hole is INCLUSIVE
> -		 *        end of hole is EXCLUSIVE
> -		 *        (opposite of the above table.)
> -		 * Start of hole, end of hole,  size of hole (+1)
> -		 */
> -		0x565234afb000, 0x565234afc000, 0x1000,
> -		0x565234afe000, 0x565235def000, 0x12F1000,
> -		0x565235e10000, 0x7f36d4bfd000, 0x28E49EDED000,
> -	};
> -
> -	/*
> -	 * req_range consists of 4 values.
> -	 * 1. min index
> -	 * 2. max index
> -	 * 3. size
> -	 * 4. number that should be returned.
> -	 * 5. return value
> -	 */
> -	static const unsigned long req_range[] = {
> -		0x565234af9000, /* Min */
> -		0x7fff58791000, /* Max */
> -		0x1000,         /* Size */
> -		0x7fff5878d << 12,  /* First rev hole of size 0x1000 */
> -		0,              /* Return value success. */
> -
> -		0x0,            /* Min */
> -		0x565234AF0 << 12,    /* Max */
> -		0x3000,         /* Size */
> -		0x565234AEE << 12,  /* max - 3. */
> -		0,              /* Return value success. */
> -
> -		0x0,            /* Min */
> -		-1,             /* Max */
> -		0x1000,         /* Size */
> -		562949953421311 << 12,/* First rev hole of size 0x1000 */
> -		0,              /* Return value success. */
> -
> -		0x0,            /* Min */
> -		0x7F36D5109 << 12,    /* Max */
> -		0x4000,         /* Size */
> -		0x7F36D5106 << 12,    /* First rev hole of size 0x4000 */
> -		0,              /* Return value success. */
> -
> -		/* Ascend test. */
> -		0x0,
> -		34148798628 << 12,
> -		19 << 12,
> -		34148797418 << 12,
> -		0x0,
> -
> -		/* Too big test. */
> -		0x0,
> -		18446744073709551615UL,
> -		562915594369134UL << 12,
> -		0x0,
> -		-EBUSY,
> -
> -		/* Single space test. */
> -		34148798725 << 12,
> -		34148798725 << 12,
> -		1 << 12,
> -		34148798725 << 12,
> -		0,
> -	};
> -
> -	int i, range_count = ARRAY_SIZE(range);
> -	int req_range_count = ARRAY_SIZE(req_range);
> -	unsigned long min = 0;
> -
> -	MA_STATE(mas, mt, 0, 0);
> -
> -	mtree_store_range(mt, MTREE_ALLOC_MAX, ULONG_MAX, XA_ZERO_ENTRY,
> -			  GFP_KERNEL);
> -#define DEBUG_REV_RANGE 0
> -	for (i = 0; i < range_count; i += 2) {
> -		/* Inclusive, Inclusive (with the -1) */
> -
> -#if DEBUG_REV_RANGE
> -		pr_debug("\t%s: Insert %lu-%lu\n", __func__, range[i] >> 12,
> -				(range[i + 1] >> 12) - 1);
> -#endif
> -		check_insert_range(mt, range[i] >> 12, (range[i + 1] >> 12) - 1,
> -				xa_mk_value(range[i] >> 12), 0);
> -		mt_validate(mt);
> -	}
> -
> -
> -	mas_lock(&mas);
> -	for (i = 0; i < ARRAY_SIZE(holes); i += 3) {
> -#if DEBUG_REV_RANGE
> -		pr_debug("Search from %lu-%lu for gap %lu should be at %lu\n",
> -				min, holes[i+1]>>12, holes[i+2]>>12,
> -				holes[i] >> 12);
> -#endif
> -		MT_BUG_ON(mt, mas_empty_area_rev(&mas, min,
> -					holes[i+1] >> 12,
> -					holes[i+2] >> 12));
> -#if DEBUG_REV_RANGE
> -		pr_debug("Found %lu %lu\n", mas.index, mas.last);
> -		pr_debug("gap %lu %lu\n", (holes[i] >> 12),
> -				(holes[i+1] >> 12));
> -#endif
> -		MT_BUG_ON(mt, mas.last + 1 != (holes[i+1] >> 12));
> -		MT_BUG_ON(mt, mas.index != (holes[i+1] >> 12) - (holes[i+2] >> 12));
> -		min = holes[i+1] >> 12;
> -		mas_reset(&mas);
> -	}
> -
> -	mas_unlock(&mas);
> -	for (i = 0; i < req_range_count; i += 5) {
> -#if DEBUG_REV_RANGE
> -		pr_debug("\tReverse request %d between %lu-%lu size %lu, should get %lu\n",
> -				i, req_range[i] >> 12,
> -				(req_range[i + 1] >> 12),
> -				req_range[i+2] >> 12,
> -				req_range[i+3] >> 12);
> -#endif
> -		check_mtree_alloc_rrange(mt,
> -				req_range[i]   >> 12, /* start */
> -				req_range[i+1] >> 12, /* end */
> -				req_range[i+2] >> 12, /* size */
> -				req_range[i+3] >> 12, /* expected address */
> -				req_range[i+4],       /* expected return */
> -				xa_mk_value(req_range[i] >> 12)); /* pointer */
> -		mt_validate(mt);
> -	}
> -
> -	mt_set_non_kernel(1);
> -	mtree_erase(mt, 34148798727); /* create a deleted range. */
> -	mtree_erase(mt, 34148798725);
> -	check_mtree_alloc_rrange(mt, 0, 34359052173, 210253414,
> -			34148798725, 0, mt);
> -
> -	mtree_destroy(mt);
> -}
> -
> -static noinline void __init check_alloc_range(struct maple_tree *mt)
> -{
> -	/*
> -	 * Generated by:
> -	 * cat /proc/self/maps|awk '{print $1}'|
> -	 * awk -F "-" '{printf "0x%s, 0x%s, ", $1, $2}'
> -	 */
> -
> -	static const unsigned long range[] = {
> -	/*      Inclusive     , Exclusive. */
> -		0x565234af2000, 0x565234af4000,
> -		0x565234af4000, 0x565234af9000,
> -		0x565234af9000, 0x565234afb000,
> -		0x565234afc000, 0x565234afd000,
> -		0x565234afd000, 0x565234afe000,
> -		0x565235def000, 0x565235e10000,
> -		0x7f36d4bfd000, 0x7f36d4ee2000,
> -		0x7f36d4ee2000, 0x7f36d4f04000,
> -		0x7f36d4f04000, 0x7f36d504c000,
> -		0x7f36d504c000, 0x7f36d5098000,
> -		0x7f36d5098000, 0x7f36d5099000,
> -		0x7f36d5099000, 0x7f36d509d000,
> -		0x7f36d509d000, 0x7f36d509f000,
> -		0x7f36d509f000, 0x7f36d50a5000,
> -		0x7f36d50b9000, 0x7f36d50db000,
> -		0x7f36d50db000, 0x7f36d50dc000,
> -		0x7f36d50dc000, 0x7f36d50fa000,
> -		0x7f36d50fa000, 0x7f36d5102000,
> -		0x7f36d5102000, 0x7f36d5103000,
> -		0x7f36d5103000, 0x7f36d5104000,
> -		0x7f36d5104000, 0x7f36d5105000,
> -		0x7fff5876b000, 0x7fff5878d000,
> -		0x7fff5878e000, 0x7fff58791000,
> -		0x7fff58791000, 0x7fff58793000,
> -	};
> -	static const unsigned long holes[] = {
> -		/* Start of hole, end of hole,  size of hole (+1) */
> -		0x565234afb000, 0x565234afc000, 0x1000,
> -		0x565234afe000, 0x565235def000, 0x12F1000,
> -		0x565235e10000, 0x7f36d4bfd000, 0x28E49EDED000,
> -	};
> -
> -	/*
> -	 * req_range consists of 4 values.
> -	 * 1. min index
> -	 * 2. max index
> -	 * 3. size
> -	 * 4. number that should be returned.
> -	 * 5. return value
> -	 */
> -	static const unsigned long req_range[] = {
> -		0x565234af9000, /* Min */
> -		0x7fff58791000, /* Max */
> -		0x1000,         /* Size */
> -		0x565234afb000, /* First hole in our data of size 1000. */
> -		0,              /* Return value success. */
> -
> -		0x0,            /* Min */
> -		0x7fff58791000, /* Max */
> -		0x1F00,         /* Size */
> -		0x0,            /* First hole in our data of size 2000. */
> -		0,              /* Return value success. */
> -
> -		/* Test ascend. */
> -		34148797436 << 12, /* Min */
> -		0x7fff587AF000,    /* Max */
> -		0x3000,         /* Size */
> -		34148798629 << 12,             /* Expected location */
> -		0,              /* Return value success. */
> -
> -		/* Test failing. */
> -		34148798623 << 12,  /* Min */
> -		34148798683 << 12,  /* Max */
> -		0x15000,            /* Size */
> -		0,             /* Expected location */
> -		-EBUSY,              /* Return value failed. */
> -
> -		/* Test filling entire gap. */
> -		34148798623 << 12,  /* Min */
> -		0x7fff587AF000,    /* Max */
> -		0x10000,           /* Size */
> -		34148798632 << 12,             /* Expected location */
> -		0,              /* Return value success. */
> -
> -		/* Test walking off the end of root. */
> -		0,                  /* Min */
> -		-1,                 /* Max */
> -		-1,                 /* Size */
> -		0,                  /* Expected location */
> -		-EBUSY,             /* Return value failure. */
> -
> -		/* Test looking for too large a hole across entire range. */
> -		0,                  /* Min */
> -		-1,                 /* Max */
> -		4503599618982063UL << 12,  /* Size */
> -		34359052178 << 12,  /* Expected location */
> -		-EBUSY,             /* Return failure. */
> -
> -		/* Test a single entry */
> -		34148798648 << 12,		/* Min */
> -		34148798648 << 12,		/* Max */
> -		4096,			/* Size of 1 */
> -		34148798648 << 12,	/* Location is the same as min/max */
> -		0,			/* Success */
> -	};
> -	int i, range_count = ARRAY_SIZE(range);
> -	int req_range_count = ARRAY_SIZE(req_range);
> -	unsigned long min = 0x565234af2000;
> -	MA_STATE(mas, mt, 0, 0);
> -
> -	mtree_store_range(mt, MTREE_ALLOC_MAX, ULONG_MAX, XA_ZERO_ENTRY,
> -			  GFP_KERNEL);
> -	for (i = 0; i < range_count; i += 2) {
> -#define DEBUG_ALLOC_RANGE 0
> -#if DEBUG_ALLOC_RANGE
> -		pr_debug("\tInsert %lu-%lu\n", range[i] >> 12,
> -			 (range[i + 1] >> 12) - 1);
> -		mt_dump(mt, mt_dump_hex);
> -#endif
> -		check_insert_range(mt, range[i] >> 12, (range[i + 1] >> 12) - 1,
> -				xa_mk_value(range[i] >> 12), 0);
> -		mt_validate(mt);
> -	}
> -
> -
> -
> -	mas_lock(&mas);
> -	for (i = 0; i < ARRAY_SIZE(holes); i += 3) {
> -
> -#if DEBUG_ALLOC_RANGE
> -		pr_debug("\tGet empty %lu-%lu size %lu (%lx-%lx)\n", min >> 12,
> -			holes[i+1] >> 12, holes[i+2] >> 12,
> -			min, holes[i+1]);
> -#endif
> -		MT_BUG_ON(mt, mas_empty_area(&mas, min >> 12,
> -					holes[i+1] >> 12,
> -					holes[i+2] >> 12));
> -		MT_BUG_ON(mt, mas.index != holes[i] >> 12);
> -		min = holes[i+1];
> -		mas_reset(&mas);
> -	}
> -	mas_unlock(&mas);
> -	for (i = 0; i < req_range_count; i += 5) {
> -#if DEBUG_ALLOC_RANGE
> -		pr_debug("\tTest %d: %lu-%lu size %lu expected %lu (%lu-%lu)\n",
> -			 i/5, req_range[i]   >> 12, req_range[i + 1]   >> 12,
> -			 req_range[i + 2]   >> 12, req_range[i + 3]   >> 12,
> -			 req_range[i], req_range[i+1]);
> -#endif
> -		check_mtree_alloc_range(mt,
> -				req_range[i]   >> 12, /* start */
> -				req_range[i+1] >> 12, /* end */
> -				req_range[i+2] >> 12, /* size */
> -				req_range[i+3] >> 12, /* expected address */
> -				req_range[i+4],       /* expected return */
> -				xa_mk_value(req_range[i] >> 12)); /* pointer */
> -		mt_validate(mt);
> -#if DEBUG_ALLOC_RANGE
> -		mt_dump(mt, mt_dump_hex);
> -#endif
> -	}
> -
> -	mtree_destroy(mt);
> -}
> -#endif
> -
>  static noinline void __init check_ranges(struct maple_tree *mt)
>  {
>  	int i, val, val2;
> @@ -3448,17 +3070,6 @@ static int __init maple_tree_seed(void)
>  	check_ranges(&tree);
>  	mtree_destroy(&tree);
>  
> -#if defined(CONFIG_64BIT)
> -	/* These tests have ranges outside of 4GB */
> -	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> -	check_alloc_range(&tree);
> -	mtree_destroy(&tree);
> -
> -	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> -	check_alloc_rev_range(&tree);
> -	mtree_destroy(&tree);
> -#endif
> -
>  	mt_init_flags(&tree, 0);
>  
>  	check_load(&tree, set[0], NULL);       /* See if 5015 -> NULL */
> -- 
> 2.20.1
> 
