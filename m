Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986E970E451
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbjEWRzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbjEWRzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:55:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDAA8E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:55:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHofKu025921;
        Tue, 23 May 2023 17:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=LLM3QcfVrNCsbNCafuD5QCArc6xg7aKy/reo3nv+6y0=;
 b=Ibtxd1KrHNfYP3EZgkw9bffNh0r+nieNWjaIFbSuXqwKBId4Ix+zF8siRRzHKeYPHsuU
 xcQlcHhViL24Y0ZPuFNEYc7JGQwISIf3SaCGREgla3tlgj0hs44jqkEXo0S36ifsteOz
 bUPXL1slPQbjMAA9oEsYnQcd1xzNKNnMcPx5ErSqR+kArh5quQWlVbo11IlOvcYaP36h
 HMxdLz47bjx1lmstSIOAp4qrlRWriY2EbpEGx2idg86evehwbv3hsxaAGppE+e1Je1QY
 ckeK43jdRyAHBpr6LiR+G7bYhW51LCAieo8Ya+0zK4IZEARrVNCKYMGtV31nCywMG9dS 5Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3qnsgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:54:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHk3G1012830;
        Tue, 23 May 2023 17:54:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7f6e77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:54:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEThHWGoCr8FH9Pt97uATXyLFFte05YGLnTyP1XYToaDpw/eNwfwPTF7TzkZW5IqKm22SJmM7mN87HiZkWVC+847kgj5d80ZZxp7FXRFywKHgtqJT8rtNKNVjHcOpL/cJJcEQIyZM7ouQwhBe0TBkYEI6/30QL5QVjNYsNi0sxGYHfSUkwagcbUNTLMvwFujqrlfryo0HNQHzPW+hKQup/6j4uUPQ0G/0WCEqfZJzwZlmkd3qQzj2kh1gyqXTaAtSgFlrwg9pS361l0IoPSUc1q9Etcz21cZQiC41yGJOcHA48b6mXlv/IO0hwJQGGFZj5yBDANk23iy2M1rjGwRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLM3QcfVrNCsbNCafuD5QCArc6xg7aKy/reo3nv+6y0=;
 b=kjtU2efDmLDkQWMdG4Zx5OpzIZa9YNdX7CgEmv8ob2H+I+wurz6T24qy1ECbd4XIGtFj7IFLSfaIJW0C7fgTxkIumno3oZ2cYABvF1Ne7KJWaNhgD4+USNjaK5epdG3ajrZ0Ng1hsy1N95j0zpI9/OyNE47LT7cbtgZ/yZBDT+jvsG+yx1uxOuWVQCvkoF+hiRpN+gsTufZZNo9firxLkauwS4kC8r/kuZ5QCMwaJi/Ceaulk73GmvQ7BrKLoT+wmqkIgRwvYs2s1t56WS+cMqDwtgo/BWlmZI4w0KeynUCjwoy+eOg8ufdC2aYMBizlUa1xA3qsnNIEGDbmlIhelA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLM3QcfVrNCsbNCafuD5QCArc6xg7aKy/reo3nv+6y0=;
 b=zTSNMPN6Nrn6z/xhBva08VtznsqrjujfvhJakb41lVvpPhV9u4+B6Cw24Q4RPIBYarhIxwhPp9iS4O5RdlKm5EeEXrMpN/Sk0+F995LCGcnsOhRd2INnHGmZf+7v251sv3XnWCM4e3X/Cv9xB45OCfeYcKsqJ9ZgJDN6aPqL0Bo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB5990.namprd10.prod.outlook.com (2603:10b6:8:b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Tue, 23 May
 2023 17:54:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 17:54:54 +0000
Date:   Tue, 23 May 2023 13:54:51 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 06/10] maple_tree: Add mas_wr_new_end() to calculate
 new_end accurately
Message-ID: <20230523175451.unnpbm5ye35h2jbl@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
 <20230522050656.96215-7-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522050656.96215-7-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c597670-44fb-45a9-af31-08db5bb6d03b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anlh6I35HPqDqKIgakKFZZ87gasftLcNSsXNzVle2ziuwa6t+yt2X0sPnfH9bkUS6AWMFs5kjo5d6BaFeTFy9LTPs0NjAwx2zEYW8jFh6c7mm8B9vsTFVPnN253R3xBqrgP12fB4zUHb0dlrJq6pjTdzUAbUnCWhiv9yPYwE/cjpGoq3xmA81pWKFQ/wy3zvrUl8MAHXpYEJH6RsBcUV2g6wgkyg5DWFl9xViKOVzmFV8ABFe1TSBUN6/CZHZBM5Et1c5vDtyIa8ChCYMWsb0UmHn8OCwrMEFAMZjHKXPIQTn5myr7npIh008/x32dIDm2qUT0VBVO3s3d5ZYdM2+RwyUUqHp4rQQ6VLp/7/MzEmIRdUli6JttmA4TplI1QEY4pBmzzur06IcAP/70tzQta1YfMunEk4Tzgbh23XWCNoIq9uuYAJlJDcJEtCmRCsZngPm6OFsudo5rMcvogJFmq5DqjlDuXMfFejuhwwSIHcJIVpOxWKcosNfY/3XLoCWBYkdYHt+jGwbv50ZNpB26j3K/8kzuzitU/w7qkfEW/GOJMXjLQbTkPiiizuFxyB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(41300700001)(6486002)(478600001)(316002)(66476007)(66556008)(6916009)(4326008)(6666004)(66946007)(5660300002)(33716001)(86362001)(8936002)(8676002)(38100700002)(6512007)(1076003)(6506007)(26005)(9686003)(186003)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wjtlBzcvRk/sueFDZZXhERHmkMFC++39CmTzcNqk2miLQaIoTtSo/3r31vVG?=
 =?us-ascii?Q?VVhQ9jhQHXx4E3XbUwSHbSt1SM3A8x8K7PutJBn2h06vAJA7ciddPhQNrTmf?=
 =?us-ascii?Q?VuWPtPUuaxKDLYq8Dky5aJIGNWmB+CjHTKvdkJURha+sUw12g3Hw43geoCB9?=
 =?us-ascii?Q?5nVk46RACVYzhuVnDLGXnwrAQEOOEVuZwQi5Y2csFE5jDVu5BvWBHMsE8ZJV?=
 =?us-ascii?Q?lECAVSJRNw0eS/OUSB07DyP34GgPUSA4LCTRZmUBJr4jR4B90vnGYR9KDKgP?=
 =?us-ascii?Q?LhUaui0Ki7KAl//wfSu7LV6Rb1/EGextZa9mUtW7LTSuZ7Eo6Cq2b8oxErej?=
 =?us-ascii?Q?U3AzmKJeMgEUPjO71Wb3OCmQrkREI8evjukrUA4UksRdiBUUV5HaNxtvJIul?=
 =?us-ascii?Q?q2pVgzxbjU1M0d1f6kcdpzVpBonR0cnRFSVNDHdgrPUnF1/WxtN6emIBFrR9?=
 =?us-ascii?Q?sjIjWuLaXHf6MO1OrcKU5k1TCvpCNVASBU30SqC0iZslh4NCYakneAoPslXk?=
 =?us-ascii?Q?xGZxEw2CdeYHfOW1P4ObXv/ll/6bS48a8kV+DhRkFqq1VCxvdUztcosr+FhP?=
 =?us-ascii?Q?9hrOTe1V7jnp0kAchUib16wFFhjKnlLKlFqX2hCHMfwueUsK7kLz89/ywKzs?=
 =?us-ascii?Q?bSb1Xk/nzCSrUd+5EYtgku7eNCH2d5rZVKoKvqbOCSdaW3v3hkxdlDeMDh/P?=
 =?us-ascii?Q?s70niZhtDqpE2K2iL9E7PF43ilKZswqgeQyIv7zS5eBaNWIocNC7PIPAXT7Y?=
 =?us-ascii?Q?zFiq0swZ2rGyIslj8gdalw04/6zN5KCVXZkfFZEE3Uf9Ag5J4M+FBAHRyhRi?=
 =?us-ascii?Q?vYXgdxdnDq9xfosHg1D27a/DL2c4u6Q/5LJe/e8g3G2O3iMfE+9TOQLJM78z?=
 =?us-ascii?Q?t5OcfEtJEFN3KlMDqhb8yUAkujgvIiGGnJT8d/opyQwvtqwjh5tzGnsm5Klr?=
 =?us-ascii?Q?gH0+sZmh2gLJW/jCfVd4KhVybm/Ei4XW8OKxmcpDr2f7YBucGoK4/2bNLK+g?=
 =?us-ascii?Q?vKGfm+Q0QNOCY1d6pyzw2GsdvRkib8AU002porKA3G+VCzlu03v1svsEWbwx?=
 =?us-ascii?Q?co24H93fYnLhkWx8E066sLw7LlaIu0yLNMn2LhwZZi7ynMsH8ZHARkuVW/5p?=
 =?us-ascii?Q?6vZh8QKXI0VrdcJb+xIx9R6hKKD1OaVa8OzMmQWYguyjuSLMjrE1fevH7fWP?=
 =?us-ascii?Q?cv1/FpXqEQ0ukgJXfnfnFQoNhtGbJcwweQpL7jmH/mNbFHMz4a21t390R7f6?=
 =?us-ascii?Q?rrAlhCAfWNJ/MWPuNrynQPouXNpHYN52bPkjH37+jAy0LtcNdcEyW0Fx+cH9?=
 =?us-ascii?Q?iKk4vy7UI8gLKwUVouhX/S0RGE1Ap2Sy7Sb9DeQD1hDmEF3J/fIAc1L4zR33?=
 =?us-ascii?Q?btbgyMp70DUVR0Yu3oMpInUjYGCS2Mb/NZP8fXtSUBmIyWtuC1FX2afDE8xK?=
 =?us-ascii?Q?o5DItwJB4uU/l+4CHcAAzFyyMKlv4sNF2QC1SteewJ7Gj8hFN/cERYOftkGj?=
 =?us-ascii?Q?H0px+9hHdx268HVXuVGOZMplVZlXkOZFp3FJrbkCC94UdqzKsf7RPlnvh8ht?=
 =?us-ascii?Q?GmTiGjSldWRqrBhyYpmVhYQvF63cF9T0UYgoTka48ygUalxxQaI4ws1efjFM?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2XRVQXSJO5EuKts2RcyBO7onM9iBHro38qGiRfFo1rJU36/XtomgHMPB9uz7?=
 =?us-ascii?Q?wmnN34NwygpuDavjg/keGmlw8IbIYY2NfS6aDWO/CkihLMFYtVNy8gkuzRKr?=
 =?us-ascii?Q?gda2CDsIY2A82hmgWkA5jh7t6xeQxeMb0FIwGcSMQx3ehqiGXMVKLjqHqGI1?=
 =?us-ascii?Q?062Fiqa2HUz8vKT175nocpYDZSILvxlmRfX4TMOdUo7fj6dT5JAFGeMOl/2x?=
 =?us-ascii?Q?ZegiJdDSkOyb6m7LMTpHXvJhxZRm4+hXJiCNz0TfBAy3n/6oqRKmWDXvHJNa?=
 =?us-ascii?Q?RbZAKnVK+osr53FmQ63dq5CxEv6iFOyUpCk6d9yv0lBCWU0eRJaWzov7Ty0L?=
 =?us-ascii?Q?z3BErqIu4nWQhpGkAeT6y27a3l6pZLM9Jn7kZuevtJ4ccQA6RJ4Cd3n7rAW+?=
 =?us-ascii?Q?hCjKfTeEdByVAcE9yUEh1Mcm5bDAB5ZagbY/H4+0qS9/f4sF3zxrYdnHDjlh?=
 =?us-ascii?Q?xuA9nw1ilQWjq7m/22ynHFAQcPRGF4KCxIsiyttCZHHgXc1veVFnGjji6yc+?=
 =?us-ascii?Q?Br4qc5GBUrhd2vVpBSLyxNO1/mxxIVroaBHAuy1yRP2anKkk9UVwktZw7n3H?=
 =?us-ascii?Q?CVpuoyKXawziQZB67z22QOMAJEWPct3po9qtVer91fhPYzZcCbHBI1UU2TWp?=
 =?us-ascii?Q?yhv2RxQTeMp/meuC+AtEiCNiv2rGaxLTq+stncftTIitnHBS5idrhlllcaHm?=
 =?us-ascii?Q?QLeBGkW+CnLBXlWlSMkntZxU3vbQo5UsDiuGU219xxj15osgxKMtTJFo1K1G?=
 =?us-ascii?Q?gvsZjJM1JadQbw2DrUgIVQDnGACVCLVjKrCDbV0F5RQRpJXlDJLQul0N7hyJ?=
 =?us-ascii?Q?JPJV02lqLvVzT+NA59muUsZ7wjCzRyoJlBD95QAgCNQwhVob1/7EZm8J73o/?=
 =?us-ascii?Q?MOWSbxDM/bSHqKQME6fEEMMROdCtRhWtFPBxIJTt3/kKlCV7K0MzlWrtTlfW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c597670-44fb-45a9-af31-08db5bb6d03b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:54:54.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFz8NHBpicG+q/jpHhwH+P3w+i4tUMDBT6gcbmjOi3tbM82y18GdQnldQXZwy0K7HWYKmbhw8Va/Q19Afr7Guw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_11,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230144
X-Proofpoint-GUID: D42mBOz9uKrUqdkMJamNz-xs3fo_-H01
X-Proofpoint-ORIG-GUID: D42mBOz9uKrUqdkMJamNz-xs3fo_-H01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230522 01:07]:
> The previous new_end calculation is inaccurate, because it assumes that
> two new pivots must be added (this is inaccurate), and sometimes it will
> miss the fast path and enter the slow path. Add mas_wr_new_end() to
> accurately calculate new_end to make the conditions for entering the
> fast path more accurate.
> 

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 562507979a4b..0550a07355d7 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4297,6 +4297,21 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
>  	}
>  }
>  
> +static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
> +{
> +	struct ma_state *mas = wr_mas->mas;
> +	unsigned char new_end = wr_mas->node_end + 2;
> +
> +	new_end -= wr_mas->offset_end - mas->offset;
> +	if (wr_mas->r_min == mas->index)
> +		new_end--;
> +
> +	if (wr_mas->end_piv == mas->last)
> +		new_end--;
> +
> +	return new_end;
> +}
> +
>  static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  {
>  	unsigned char end = wr_mas->node_end;
> @@ -4352,9 +4367,8 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
>  
>  static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  {
> -	unsigned char node_slots;
> -	unsigned char node_size;
>  	struct ma_state *mas = wr_mas->mas;
> +	unsigned char new_end;
>  
>  	/* Direct replacement */
>  	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
> @@ -4364,17 +4378,15 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  		return;
>  	}
>  
> -	/* Attempt to append */
> -	node_slots = mt_slots[wr_mas->type];
> -	node_size = wr_mas->node_end - wr_mas->offset_end + mas->offset + 2;
> -	if (mas->max == ULONG_MAX)
> -		node_size++;
> -
> -	/* slot and node store will not fit, go to the slow path */
> -	if (unlikely(node_size >= node_slots))
> +	/*
> +	 * new_end exceeds the size of the maple node and cannot enter the fast
> +	 * path.
> +	 */
> +	new_end = mas_wr_new_end(wr_mas);
> +	if (new_end >= mt_slots[wr_mas->type])
>  		goto slow_path;
>  
> -	if (wr_mas->entry && (wr_mas->node_end < node_slots - 1) &&
> +	if (wr_mas->entry && (wr_mas->node_end < mt_slots[wr_mas->type] - 1) &&
>  	    (mas->offset == wr_mas->node_end) && mas_wr_append(wr_mas)) {
>  		if (!wr_mas->content || !wr_mas->entry)
>  			mas_update_gap(mas);
> -- 
> 2.20.1
> 
