Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CED86B4FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCJR7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCJR7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:59:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB7D11CD48
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:59:17 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AF4cWK030489;
        Fri, 10 Mar 2023 17:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=dEpN9iYh9+HJiXu2uJs5rvbdv0sTsrsi9Zn3/7YMJKI=;
 b=iRLnmLd4w9VAav0v7v9LY+QltMePo4G75UuJlTbfMqIW4D8MIg0GnFKLS3MwF3/lhbNi
 Au1QzFpFuxjaE5N8+I/taYiH4c3Wu9Q7LKmAEKeWRFBX3ai5dQwTdbBg7qvReNjPMYYU
 W+fU9AOTSLDytywfKsrpktBUcKk6KNLriSHfW//FvgxtvEgGRS0mAFq/dlit3mOA9LlJ
 KEZUxv5+f3juyotNv+UAZdF8FtjnixaWGlEj3Czjpeg1ZFqx6WHLP31d1fB4j4y1xZEE
 Dw18WezVVRi/Lfhh+kPdSbcLWB5B8lrd/pd5Ptqqjku2FR2aak3P+yjIaF6WPbWA9e4t Yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p41625r9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 17:58:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AHU1ds031530;
        Fri, 10 Mar 2023 17:58:47 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6feqh4ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 17:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci1KrmhLP2BjZIZACafHZISp9M4BxvSShHmBxE/+q1r4baGZ95mQH8U8ggntcEE3XUxxR1PEecHU0/CHgAAbPQ0K5SzmFdt8S89Cg+mDLxun26X0nM069R5+tFKwZvn3JURabLBidbgI621kl/ibPy5h9s+uHoErxBov0qlW+tL5sf7HG3f8wfVj0J8UqdwmFF2yI5Pgnufr4ItZdorREL5W4ZiBdBmb2JucVn2DVl45sCQDZjJSGEhv5VNlkyGasjSQOm3CVWrvJmC9OWTfzg3Kklb08rFXbzhiy05+6DbxgyeaG9AO8eX+NemGAscIl6Xm19Z4FsHIG38deLJxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEpN9iYh9+HJiXu2uJs5rvbdv0sTsrsi9Zn3/7YMJKI=;
 b=UJcU5xIw+7Dru6MVPMpEFYQsXwP9AZMXTWD+fOOrIb+1MMCMsh90/2AUWb5LJ3Yh/RfiKk3YAQp+n5pneWogTZm7yhfS3Pu3NSZVgCQJBlXgLCGUCpkYdV755fUm0IyTdggAoVY55C6oXuIbpllY+m6Mfzj/8g5Z9PKiX64oGSrxot1T+X/SxsDBq5AafM7CgkTJag44sxkwvKJZrqeK2ZwQeMvNby2+Pasvci3mHB0LQhHCgHyCfQaB9E7MVAzmtjwRjOUWzSxiIxJ0jUKQAL9I0an/drlcE6CCJgQZWrxV7bh30kICshWi8Q2WhgLAWGupt+i8rUVlQuXlgCSKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEpN9iYh9+HJiXu2uJs5rvbdv0sTsrsi9Zn3/7YMJKI=;
 b=FyyTXeE4KUvIdrIqEljg8BA5cflpQ6Oekr4povhZHnynK5j9b64iKFGNf19pQKkHDe8W9dftYrQh7d2g+p/ydNFZTh+aY9ApiqPebxwyMQcaBG7eGfay/OQzaqH+GV9XdJuRnvqVk9KoFDQ3haireWTGrCcU7Xcgi3Q9la3G2RQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB7351.namprd10.prod.outlook.com (2603:10b6:208:3dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:58:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 17:58:45 +0000
Date:   Fri, 10 Mar 2023 12:58:42 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/4] maple_tree: Fix get wrong data_end in
 mtree_lookup_walk()
Message-ID: <20230310175842.qkw54rj6zg7dkymd@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
 <20230310140848.94485-2-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310140848.94485-2-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae0e1dd-6929-4f8d-1dae-08db21911785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIjIE70q7/P1bIKd3snNFydDazG2Zye8pQlSK6i7LZ+K1NQl8uDt8hVp+KXIJ4piSvSl38RJyeMZZfglUnR6APrbO0SpHJ2o3rqmpDEiASABpF4fpKoSLYkhfeUgKgbJynv4qH2OIaOEIqNTFWUNhmW3MWANOtgiwTvoyd5iilXJi/JiLUWefN1t/+21vVL9PiDTcyYwnSRBw9K1n4EgQL2jcZ5+B+u9BN5/NeuV3DSN0Kv/UoN2KRGqTt0TqYiDXptoAqMMdH1wFBp1hZA4gg6D584uFF2zBRp0OXwXvFgJEtUEP8BqNbV3D1gBG4o5igpo49PUuY0fAmXdz72SsmdWoaASothN/a1O0uAlDREUXjMruoLfg2gK+DhTOQAyjNrUR7jJ5heGC0jGTHIJyHoBA/uoK4g2KoiGq68AyTARqbFGBBnVI8UpYi1b5iIRG22y4fMyHUGc9o7fD0mKrnVUYKfP58x81IBXIRBwbIc70svl4WLQVcxnaFA/jZnQSdWCxwhpCth//ELKCF+o0VI8rZNTR/R7hdkUCknGskG+QmoVb+lZh09VIflvQLoXIEfZsIcQ/e07PtUgUmngJCXyZOqKCIht63HawZbTs6ckm+32OyfIhvKnblcc4x++62KFhxMb8rNj00CG7IN3JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199018)(6506007)(26005)(6512007)(1076003)(6486002)(9686003)(83380400001)(186003)(6666004)(316002)(66556008)(66476007)(8676002)(66946007)(8936002)(41300700001)(5660300002)(4326008)(2906002)(6916009)(38100700002)(33716001)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?agKxnoI+twNdKuttUPikaj4UnlHEivRw2kQSN4KWA/5Uf2WIdq5N27+KttpA?=
 =?us-ascii?Q?NFg2a0rJfzH7eqPYGgqNb1OQQhAS3yfi74w8Aj5fbcvhcSqcs+pAPut9rsHU?=
 =?us-ascii?Q?eL+NzjE5PzAqZInmozZYKq9a+VYCnAScCQpASLvhvDbAzN6MDUXdbUk9G/Dz?=
 =?us-ascii?Q?bxQf5h+CAnQhQ6sjIzVDSnFgWYNl9qtkqs+3liCvTmVaO9a9qw0Liod+lYVZ?=
 =?us-ascii?Q?GQ9asTZgmRduwxcgR8oGq12lAyAn5pY+Cyqbaxk5WXm9Tksz5gtJNlTPnTDg?=
 =?us-ascii?Q?OpFNIfzFqllXi96bXyuXrilcjZon5n5TrEYWO0+ryNCUJV4j8rW+KuRMMTBL?=
 =?us-ascii?Q?ZVPz9Y8gmxKlzMSe32a7OMYjlroeQCK5VR3zaGlgTsMwqEl6SbpfX6pMv2TH?=
 =?us-ascii?Q?QGGpTI6BWZz/WnbkxdG1l2ldIS7liZr6Fc7SSf6RCyo6YGzZNFTA+EOQZHir?=
 =?us-ascii?Q?yZlk/bVEyK8z7ktHx32ghVpyHxk1cymVwhGIqIXEdPKhGQ3yK/mi2hqlPuFF?=
 =?us-ascii?Q?zjrcp8OWX2wqPVRTZnWFeoRJkd4nNs6F1UZ+yqOpiJ3DKpyfSVTY3S2cd4lv?=
 =?us-ascii?Q?QF2MGXicK+/+LJR4Nvz1ITlaYiShkps0lVclRrZgJ5Hhguwg3bNv2VlY6Wzl?=
 =?us-ascii?Q?Sa2hYLAsgccF2WbRtCGHf6FTcjykkmCj2gJmwodPmbnzA87so+BInlGvdUH/?=
 =?us-ascii?Q?lJUBG7rCui+6aXH0YOmp0H6lP0vO+/U8DP73rZe+le95bm/Di6YmnbjxV3qK?=
 =?us-ascii?Q?SzXRGvtJUrda97weGvpfl3oZ7TYfRTYojnKJZYnIz2J3Y/Z+nF5eDoVuL8oz?=
 =?us-ascii?Q?wN6dePQkoK97lSUgpz1IsvxKLLy7rAc6jqy0dqAo7cLIpyIU2ebdEWKFNmiE?=
 =?us-ascii?Q?ZM+Qa9mrrAUoKqAQxxleNcsUH4a81X6LMcRPCxL1T4M0CFmHM8gUDIWc/dzl?=
 =?us-ascii?Q?EdSRwUNPIM1xK1daqsnzmqCOF9lFy5Xn1Bg8bWLo96TjUmwZUEOj5iLs5Ibb?=
 =?us-ascii?Q?pzFxcLousOHIXs1F+x3Ij15ax/Sm2Mz9eH2xqYOATLTikZv+6VgexbLx8K+d?=
 =?us-ascii?Q?q8kOI3q5g8zb7r89QVb4QaCGbMx/dYtVQX5KHO/d9vL+OHPsUUCL64F0J9Lz?=
 =?us-ascii?Q?VOvq9Cs6TRhHiwbYv1XBbueK0tEOLauSQlx73BuB1eYT2YjAnKgr3jTzofTc?=
 =?us-ascii?Q?EohBshiOxGPbq1rfkQmM1xu1yzkgImfjxO/z96drRwi17memntnjttjtldYu?=
 =?us-ascii?Q?zwZCHTmMEKwPGtg0FEEe6MU6jz2bQHUbyJ5yE+uOLa48y+51LaXufP9XVq+v?=
 =?us-ascii?Q?Yx7d5rOFtA8WSV4nngrzJ+gK35+oDMhnIJtqhuOyXwhwqiyzSY5tffVw7NEU?=
 =?us-ascii?Q?9p9mu+Xk23VEJYpfzALtdlJKW1WfxYaZFHZ8xLWnEpPtfkorSYeyvuegEDJA?=
 =?us-ascii?Q?QA+Bjo61STTBfjyarnIXhB4K79jnsLVQoLB/3NhPWrp16EYDNt33LJz6vRU0?=
 =?us-ascii?Q?RUEZ/6NDTQFduOSf1xemzNtCno7ueoLwm1j7nXzoLu8sPt0tvQ2/GZ3poWcD?=
 =?us-ascii?Q?B5flXndYW4wxQTIs9dW/0BfavLa+lvFbNf/inV/gwVgFc2Rw1NocLVHxHX0M?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TO1cPS4/BxJPu4zl3FUKL/eBfCuizfqOymtxBPGtpTHYl2smTwCTz0L7Sxa+HSulmb+5PFtKbJs0ucyfnWJhIK/Of05uEa6Ui4FhDM2prWKecQvdLze9uuGe58BYIvgec4NzhI/z5ivN0ZPD0XVj+rVnk1+1gGZR1luHSHR56zOtvw8wEBra+GREoKT2PAnw0ALxPTmzRJjc/fbiUZ1v/WHfhT56FO8cxa8T+di0yYPQGqMqCThZ8x7XlZgKniL0Fq1fFjO1aQ+quwppHSkX+U62crsdYeOTcr1KFS4FIqNuxRGBg35oRd4sUgDBNhDf3kasAoIJhVQJ+drgemla/b7T6bO3/LjTORhnStGyoIt2or0kaM0wnAFRaHAIjiMwxMK6Bfia2aQ9JaGps7z0fsUxU9u8+gZxptoJfjbPxbhRsWaBZoRcBWaoW9V74HQXA9mS45qbvTQriODfKSZXDyNOBL9lOzLqHX4ZhjiliXtSHiXXn/K5NbrDrcUGP5zDp7ny3fCyh3em6d4Ds2q/sJj2v1mbdl9WsQiAyUeJ5UEpyo+no7RKHmMuE90F/19NS/GCtrx9ft7TibFKrP7xInPcAhGbASUHO3U527T+uNpckMOgiMh47LyS5UuV43XVg2aGUm5EFlAu9oCHF67r05YIaLY9PDsaN44fKkOqsXszylCSw2ySqDa24SRS1bWRIiAombKQ1YETSzSTShTUFZ8Y/Rt4MX3KKgMzxSPB1ydX4f+vpiB2LK+HdH3lyOs124P44lzo/Ax697lQiI/j0FGxX1nLvmnNDm4A+XNTsSCz0dVHxn3WhOt0FIeSbhVrDEiMg70s3J7K+bx+dyXj9FqCX1hQfNFD1+xhjI/Fm3afGKb1eZ5SmC8vFUqyoD/M
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae0e1dd-6929-4f8d-1dae-08db21911785
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:58:45.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4Bi6oqJr4YKjfsHRkcOGkAI62M5jIuUK+DDEtdcMK6SA5FzKXQ9O+TNKPUCsh38hEvjwxdYLkfSES0Ahc+vsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_08,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=857 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100143
X-Proofpoint-GUID: MkIH_ZVdrlgwUGFDKVwsqN7xAcJr33q1
X-Proofpoint-ORIG-GUID: MkIH_ZVdrlgwUGFDKVwsqN7xAcJr33q1
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
> if (likely(offset > end))
> 	max = pivots[offset];
> 
> The above code should be changed to if (likely(offset < end)), which is
> correct. This affects the correctness of ma_data_end().

No.  The way it is written is correct.  If we are not at the last slot,
then we take the pivot as the max for the next level of the tree.  If we
are at the last slot, then the max is already the correct value.

>Now it seems
> that the final result will not be wrong, but it is best to change it.

Why is it best to change it?

> This patch does not change the code as above, because it simplifies the
> code by the way.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 646297cae5d1..b3164266cfde 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3875,18 +3875,13 @@ static inline void *mtree_lookup_walk(struct ma_state *mas)
>  		end = ma_data_end(node, type, pivots, max);
>  		if (unlikely(ma_dead_node(node)))
>  			goto dead_node;
> -
> -		if (pivots[offset] >= mas->index)
> -			goto next;
> -
>  		do {
> -			offset++;
> -		} while ((offset < end) && (pivots[offset] < mas->index));
> -
> -		if (likely(offset > end))
> -			max = pivots[offset];
> +			if (pivots[offset] >= mas->index) {
> +				max = pivots[offset];

You can overflow the pivots array here because offset can actually be
larger than the array.  I am surprised this passes the maple tree test
program, but with a full node and walking to the end, it will address
the pivots array out of bounds.

I wrote it the way I did to minimize the instructions in the loop by
avoiding the overflow check.

> +				break;
> +			}
> +		} while (++offset < end);
>  
> -next:
>  		slots = ma_slots(node, type);
>  		next = mt_slot(mas->tree, slots, offset);
>  		if (unlikely(ma_dead_node(node)))
> -- 
> 2.20.1
> 
