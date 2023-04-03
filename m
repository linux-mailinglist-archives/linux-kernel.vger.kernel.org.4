Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19196D5203
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjDCUKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCUKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:10:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D89E5D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:10:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333JoscY015277;
        Mon, 3 Apr 2023 20:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=tKjNvlSigDlTUgp5WRUAlDB9RRwTuoabUdxUQ9+3BCM=;
 b=F4J1b3DSpYWZCOhYaOeHhBGCkAyzf3/eg34sQUtjkA1JdaKFUxsNscBb6OGU7g4fDiEf
 cfG8x9gcLHU35X/fTiEQ6QuMJOZ0zLHZFQEAQ5eDLYe1aXx/AZU0Pl9bdQlc6ocos+37
 7l/zJLQGijyeRZfev+FboeOr2zkyVRmQEE+UNdTybNidHpO6lP/eLXJHKqD3jWGJWBus
 0eN3Kw4+Cx7AB+DYokYHHfxTsoGBWRjYMz6NcjU95pqs9XcLLn1Y3tefkkJZWxJaUkm0
 OHa9yVLvFQtxU1A8ZWhjOugKoFFvjzHY/GBk2tCC3P4C4N/vVfEWwB2nMeiqS/Bd7l+/ GA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppd5uc573-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 20:10:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 333JHKFQ028059;
        Mon, 3 Apr 2023 20:10:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptuns9n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 20:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INGW+IymEnMWkR9bEE5MUiI2mq0FHwMgiy4jBUUAC6bK5HAbZtR8s42j63xACxqpM5pbfFwcPFW/wuIomoCzrxK6FNGyrnegjP59UtjImX5xx8yvavQ2cvBQVw6O8y6LliRVpSY/HSBPbPYGizqX6u4Poh93/BVoXsyPYzFyLFrMg8oiitcSMyGZjpTwoz2vFSsXsjqWXI6iIwvELMvpxzojbg3A5JJgCsdQvWa8Y6jiG+beeWhCpFOsZRR6xWHpkMp0GIaatwznzHl3pac7Q7kTH4AxCd+93rUHe5/napgibsW8xPkOk0qDHFYQNcqAj3gMWfuHEuEqPxlkUg3FxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKjNvlSigDlTUgp5WRUAlDB9RRwTuoabUdxUQ9+3BCM=;
 b=UJGUiWFHp6TbczlsH5Vn95CfJJQjqWsNi/H9wSqjuWa6vFF9Xy4p1yu4gndEiBcypMSe17mepbnOLCRkpyCQ4O8do/U9vijsv+DxSg90cAj6ZceRN51TpqtyaZpmRe3cEr4YoKqvrU62vPoAa3s0o2IgDZ+KPr/+Bjfj/1MVufTrkItDMUFJDElHtFmrWLGJCN7vbcX4NRwmTwqTPeRNTa+fznioQ3/6XD5lms2OiGKawWE2DxT7O7yaqwbkfHSgxPGMloN+gL4om8Lysn/kAh0rfMNy7pK+AINu6PwEFIxFRNH2ylqNLlvI1kNB0RFUjN0DelTeBp09RUNLOdaDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKjNvlSigDlTUgp5WRUAlDB9RRwTuoabUdxUQ9+3BCM=;
 b=tkCUt2WUHpWMBmYgvdhUwH6dqy2i2m1JXvInA0Ne6S1KteqlIxUdF2jpYgVxH/6W8c9Dm8gF8lrFT9ZEgg3SFprFLfGjPVhxWaC/jryyqSfFFNzxT4kMsqf/dYS6nie1KQ5tpq3MPKqTlvpNDqAJSVh15ZWxLLVlx27QZmUe07Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28; Mon, 3 Apr
 2023 20:10:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 20:10:05 +0000
Date:   Mon, 3 Apr 2023 16:10:03 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: Use mas_walk() instead of mas_find()
Message-ID: <20230403201003.5eqmsq7k7igkhzhx@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mark Brown <broonie@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230403-regmap-maple-walk-fine-v1-1-09512dd51e50@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403-regmap-maple-walk-fine-v1-1-09512dd51e50@kernel.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 233bd372-30a4-43a6-af62-08db347f6a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQTMFdSDl6oWXuxwgaUQOFyzE93YChQKCkf8HO7/G3nuPeof/eHvO04OhZIpipoOG2UMS6hbYy/GmASswQ9VR8nrvZnpwf3niL/E1CwIMWKbdyOC81Fvy6Sf2L9pT0uRFZ6zZP4p35MW1evTmW9NZPKqD4fIn2d8F062UN3akLTObN+T5yENPT9aRWpjdTPQlTiEUcXn7a/uOKPV3ZaQX0b2mHts5jebjrAW2D8+4TVDfNJQT2iwp0av3WzxEOw6POFcdyVitJnsWlj0Aw0FFFL9iCW4RZnmruXmW/4bdoHyvCmatt2XaYaAnWF+vU8OOoPVWyhVQJHtfyQfyhb4v+J/suKtbRrMS5tjpg1Ip36xxULAh5F95cLVf5Djt0SI02mcEKRxsC63C/bQzUL1wXdZoOzc8PU3TX2BoAi6hS3VE9LdBq6tJzfNQkE6OGkrk0q0kgw9DD9lzVSzCMRdXQBQ09BAaCvL7/dRpHGLS0ByiLqEtRJscDBqPxLFVozOIsShiLjrtAYDX1/MGJvBIsaFzdWBI39Iuy0Oppx2VOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(84970400001)(6916009)(6486002)(41300700001)(66946007)(66476007)(66556008)(316002)(4326008)(86362001)(478600001)(6506007)(26005)(83380400001)(1076003)(8676002)(8936002)(5660300002)(2906002)(33716001)(6512007)(186003)(9686003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C4TebyjXCknQJnDTBqyhkdgyck3EUqs1n3SjYCckCluWkHNNh0olre6y/ijJ?=
 =?us-ascii?Q?lBbN/q/9LlpTLbogkcnV2r549zfT1ABgLoW2sI5CM9A9MSMZqqvrt/PDwEWy?=
 =?us-ascii?Q?3lHSPKjwnvcz7ot6DXj6iKAcn8ap0VldwxeOBqpvDyV/j8U4IvyvIvctPTbu?=
 =?us-ascii?Q?CNSIL+R+EvPxZ+3e5XepvD+ymDxtNCEFggEs3r4BIBWImc+TGSeqQkVxtbV/?=
 =?us-ascii?Q?YJdfGzXx1lIen8jNpw85L2DFAGEcUuxpeii53+7bdqI0Nn32XvihiIF1duvh?=
 =?us-ascii?Q?GbDz0zkL0ofwy1h4bJunSj0/IX9LpYp8ACQlTVsHdCr2jHi0DRmZRWnlhbtH?=
 =?us-ascii?Q?D67rP2FIx1JZNAQGlbq43KylTuKJJz5Gi3i9F/cmtbhIqcBMUQfwDXt3kc5K?=
 =?us-ascii?Q?W26tI3NCWI8nerN/f7ereBq/9xR+jLE7k+HZ2WkIu6/rcnbz+5COUEnkiSd8?=
 =?us-ascii?Q?9m1/z7skYiuI73K86ZXtox8R5/wTChNVuY749SeulYlzR24hFl6O8LIezxDn?=
 =?us-ascii?Q?8iGIvaiEOn9ye6uTe65oghl/9bvW+1BQylKwerzNlyJUy/2m6gaJq9QCJ17v?=
 =?us-ascii?Q?jaqUldjHHlKZru3iXx4AcJ3lMg8id2KLVhiAGa+edgU7NhQYMO7vYTnJR3zI?=
 =?us-ascii?Q?l8tatauAbIf+saWFEK/WmqPzOyuxvkblrttgms2JS0OCr7Y7VBw6lpkUmRAm?=
 =?us-ascii?Q?19G4D1tT1fciEwHOfbVJEmzpWiNC2F0GOLyfJloGIoL6zGr5eidaaVfUqyTL?=
 =?us-ascii?Q?Fig8r6NVqJzkIDQLWMGFIt8nSGCSR5unw3TiNZwfzbJfKqO7IfhnsgKfwEFD?=
 =?us-ascii?Q?uMKoCJ+T0ofDQBJERsfbZaPdRoMCrZ/kNQdhL7yXp1roGjPtvi7RK0kTJr0Q?=
 =?us-ascii?Q?Z+VSQxe43vXaSdAeo88+tbuhPb7HIStERey/kt09B2kZLnRtpec2t4L7MGN4?=
 =?us-ascii?Q?aWa2cyYvHe4TpIyvUenk8wq5RiXWj78QOKr5n7H6gAM7No/ONV7CHns/DeX+?=
 =?us-ascii?Q?zcaW9n87T31NZHVLszJ7k2zAsmgd637Z0Daup0fgkU8nsoXOa55GpPs9viSJ?=
 =?us-ascii?Q?c3GSztED2lGJRG4O1Ua/+LU0Pzm2Qe0H2YlfhXUEFKdYnSDftSTwYm6bIIdo?=
 =?us-ascii?Q?jN/gDcGLjoz9AnhcqXVy+OtR/T4pR6epigMNZzqLP/XPv7xMrUXeuMKjRVRa?=
 =?us-ascii?Q?2iKJCKbQDlgm5SZ1sFrVll7ufzKjGnwwSYdgcrwAHoDhfrrA99WoVtode/rO?=
 =?us-ascii?Q?KgFDM3lnkEdB/pKbaBOtTQWT6hMNaANisyJWbo7+K+fDQwXB78yLUDBWSsfM?=
 =?us-ascii?Q?bmaDHu4hfni56dvmzxREn4mrtaR+lp4EIwJKCDRelFwNfblfnwOKDKTgkEBi?=
 =?us-ascii?Q?QVqsE3ODuNarHIm3ldNMjgiHCywvSdWGeIAv1Mk8HiUDOdW8OrNJM3+3P6yj?=
 =?us-ascii?Q?syfb3lv+X3bbGqOmIgF98FV7njIjwMrTFC3VCoMrRAKYVsjo+Gi6ryZwuGc9?=
 =?us-ascii?Q?0IfOlkn9hsrCesRGYYBN31GrQgLfc/cYgmqOEBzP90VAqnlg7SD996Hz0JtQ?=
 =?us-ascii?Q?/XCLV2LZJdK8uAfuR/9t+D64rgX1E12l/ykegJhHvn2sF8p5QjC3fJlcPGYI?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t+51nGZ/LguEwuAdbir172Gxngsorcg/oGAdxuey1qBCzPNJbXhl7qwBwciJeaFvC7BGU/48WllHIYWe0je/4ptDiaz0OHlf+AoQJmgQrOzE4B4/AvTu+C1MOvfH0Du2cB8jhmYwLceJQuCOj0o0KQRFM3/gFoxJxtN2IZxiNgCITosrI/WIr548fadgc0lqPDc5kZZlI1fK8aYao3wFcs4rWHCLns+PNeTjlTlIbPYdKm7sLYoRu+awba3kc2+evxEKgbdkmkxssAG0DYa7rZUK9wRkfbQ+8cJOSJTYT3cTWdWeusRzOu97JjYZFp8y9I4vR4TJo/HWEWs2RkRI+S8Sec2cvEnOpqy+i97VFyglD5mpMmGeWl3QnzfjQGuuENA5OxaF1Z5ddP/DX/XVEWg2Ur2mhoM11tbUrsNzveSotXtb9/v7kpJHXYt9OLrjMK9KwwdLtCjqaqn5ai/53EdZZW4LNmgoCEpL7ndvagfF12vd4aBNLKjRrwclJ5eDsIgpd++nKVt/IC2Z4qNddIIBWgnVrDgwGCF0lNN6W2KN3Zq/fBAFLcl6Jnn1YxxVkH9/HOUHxsegivhxg/l1QxSL7lgKRUoFJhFG95I0tAYSL+ZO5t8pYTJQ474xqt15VU3+uyW/FBbDuCzQPFUXFsUwE2SIYn+yARDNGr9SK3r2p48CgSrum8OpFP4uvrFI9PlHK+r95Hqa3D2WysEOhKr+70XbaHvR6EmHFaVZTYipxPRWNBvkW2+4UAMkN8wz3H43O28kzBkMU5v8T4F0iSmHRIv1H6aWmdh+BxliF9Tzja5mMK4PBmUEn3lmK6ee
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233bd372-30a4-43a6-af62-08db347f6a6d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 20:10:05.5444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+xrvpKC8BOKS0mj9bpQ/ZyHYPTwTr6mvKVd20pH99IWbAInZflgr5x3yGGUGFVwqpPUEhl5OnL09NDhTHV+kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030156
X-Proofpoint-ORIG-GUID: glS9-QGbv0c8xePI5URt3M9Zyc_gNGti
X-Proofpoint-GUID: glS9-QGbv0c8xePI5URt3M9Zyc_gNGti
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Brown <broonie@kernel.org> [230403 16:00]:
> Liam recommends using mas_walk() instead of mas_find() for our use case so
> let's do that, it avoids some minor overhead associated with being able to
> restart the operation which we don't need since we do a simple search.
> 
> Suggested-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/base/regmap/regcache-maple.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
> index 497cc708d277..5d1bc3691830 100644
> --- a/drivers/base/regmap/regcache-maple.c
> +++ b/drivers/base/regmap/regcache-maple.c
> @@ -22,7 +22,9 @@ static int regcache_maple_read(struct regmap *map,
>  
>  	rcu_read_lock();
>  
> -	entry = mas_find(&mas, reg);
> +	mas.index = reg;
> +	mas.last = reg;

You don't need to set mas.index/mas.last here.  You have done so with
MA_STATE(mas, mt, reg, reg); above with the last two arguments.

> +	entry = mas_walk(&mas);
>  	if (!entry) {
>  		rcu_read_unlock();
>  		return -ENOENT;
> @@ -47,7 +49,9 @@ static int regcache_maple_write(struct regmap *map, unsigned int reg,
>  
>  	rcu_read_lock();
>  
> -	entry = mas_find(&mas, reg);
> +	mas.index = reg;
> +	mas.last = reg;

Same here.

> +	entry = mas_walk(&mas);
>  	if (entry) {
>  		entry[reg - mas.index] = val;
>  		rcu_read_unlock();
> 
> ---
> base-commit: f033c26de5a5734625d2dd1dc196745fae186f1b
> change-id: 20230403-regmap-maple-walk-fine-982bbd2dcfe5
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 
