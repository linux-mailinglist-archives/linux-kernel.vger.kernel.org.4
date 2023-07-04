Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253CA74678B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjGDCZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGDCZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:25:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0215913D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 19:25:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3641xQLD012338;
        Tue, 4 Jul 2023 02:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=B2yZr7PNBKIZobMAWi1safgdtbORW8FKdcX8MrnXDmc=;
 b=UR9HXzrM7KSGVzhHE+DfaYKuqpiBsnZ1eRd7lh28p7xP1ELhkoiDSJOvrOkJcXQzXzkT
 bW6TvV7DWL61N5EmwSjCVfJ5Ud/rNgEZODd+EpTxSuy5pYcs6slg/hsEm1gvn6zuL0+p
 2SjfHkg0D6Aa/68poeP/VOgjHKkuBfFZ1+6hkbB+3rS26zubZqbD9ME3EebRZ+G35eVp
 /uPYub8yB1u9DkY32aSU275wLkFm6LLQmt1T6RfXnYcszl7vQ+ZSKdjpO8Ow5dxP8kdI
 /4RJ0Spa90o8I1f0wh18l1XJAgYQwDDrFbF0arSyXZa+OT7u/ba/FjVEZiiuRz1+50Kt WA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpubmh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 02:25:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3641LgDS004233;
        Tue, 4 Jul 2023 02:25:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak48q1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 02:25:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg/quPuTXNewIiAB7+P+kIZv4PDmqRtBUrv6N16sjB2Q/Cs+6uNgFWVEdjzrsaWgr2uJRawnNtzfh5juU1y+qGx7b+rUf2iZiqYbVH67QvSaiuqcPpUzNMb06SHPx/V9b4LUU+WrJ8Es2Gyo9z27kSmpOldIMxf1IhD/GUziWkUCkSh2fRKINKIrQ6sf9B/FmuVjoUpvvvWaG6+jhfv7vXoduAH4uVgQKmnYrZtO8nhMLeML4zTE2ONx/tH4gjAoEpmCz1JhCNAkgxq2texObFNS4SqP4li5berw1ib8Agi06Vblh+Wq4StZIPq76Mv6362l1PPxkwpOzB/vViFhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2yZr7PNBKIZobMAWi1safgdtbORW8FKdcX8MrnXDmc=;
 b=UnZVdFtryWPsMpN3paN7e4UhcvJ9Aiu/H2VnNLApZ6er3mb2PZ9QEw23i9MeP5srzQ5ZYweKT0/apav4pKsOZ3ikqUXZhM96N7Jk41Nf3OtxJwfZtKCLDEUH6fnfdIGGjZk+GVnxZqidcLxYIsGxiSOwFoH2mnaRQkmZ74HkVtlUNOPcNE1TRdCy1h0+FrObtQYWWukrVh8E16yoKnAbcIeeXfl7o8j87s9WNErdeptobUZYuqRv7AbmpW5bxFk46R8gwpidGU5vhx13v+hG/tmg2TnFzvKVAY9qv4LS3XYRXsbmaOi3+wiM9RN+ah/zHaVRyE1BA1AdqEWNo8M2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2yZr7PNBKIZobMAWi1safgdtbORW8FKdcX8MrnXDmc=;
 b=dGaYp91mp8WFwtYW62/jFAteJt9F7vOmk/e7q6HBp3/c96igORuNDiYgWoatjjjdElz5Z7MwmYB/T2lqHOpRkQUKE8VcwPB17al3dNDNjUx7BZhx/zaz1C8e1zVlcxl1XkMlKGREz+SZP+GOpZemxOJgKTNpe30gPLOExocYbB4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6109.namprd10.prod.outlook.com (2603:10b6:8:b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:25:06 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:25:06 +0000
Message-ID: <946ea2d7-8351-75ae-4851-a7c6d1acbf4c@oracle.com>
Date:   Mon, 3 Jul 2023 19:25:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] mm/memory: convert do_shared_fault() to folios
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org
References: <20230703220559.1360-1-sj@kernel.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230703220559.1360-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0364.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::9) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d616ab-10a4-4f74-e2e4-08db7c35e153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGgXfGvjUZgQYZVQ5BLPOx7ei8U3GICbK0no6IZkLelYoc0/YK+R/MepOZ+J9mm9YlLdJ9Kn/vk1vFRAKDMu1TjZuQy5LUhZFA7rRw3IvLZ+WR/CpJCAod+68cRhzcKz7Q8dgIGYnyltDXOjsy47h06P+jzcwuYyFTYITZftNuECiFaoOT1+t0TuAc+/KUYA7og40S4nV0emknEyBl4pSvZfgFaWe/A13j/6xwceORWCGT4wtRESl3PxKG7yFNHFWREfIfQzPlnAGhjTpOiSz9WRuNsOV0Yi5YOu3dofKzupwYe2RLmXF6xpgeN4BFX+bF0iLAK+wWEgupySFhOQEyq9fpaYFw+iIqUIjBp71lxMXepgUWmPXlpkhIwKLmnQ1xTWKlObl+0GAhNRp7/rS12EOdxrSAaZ0ywhsK7H6b7fRHq85QjcMLwkblvYAN39NU37EB07TeZXDCm+0lU+Epi7nM6al5Acf02FXgBwf8Ekh1If+kU9g3gich59i+SUnyaUfhfh1X6u0Ay/53hrA+hKQ/H5huaBZmKPRtnAwCf3F5UnXoppZPecoc6kuG9Ad3ruVLQt/5QetMnALlgbibH94QRWuzQKZiuEwO7KjYB0py5yodlvmCwMPHipxrDqDpzjikeTiRycr5OGTAc2Ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(4326008)(316002)(31686004)(66556008)(66946007)(186003)(86362001)(6916009)(31696002)(66476007)(6512007)(6506007)(53546011)(83380400001)(2616005)(2906002)(6486002)(38100700002)(6666004)(5660300002)(44832011)(478600001)(8676002)(8936002)(41300700001)(45080400002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3NLMzNYNVFVTTJnT09LczJFd0RmVGtRaHNtWkdYQWFUK3ZOYWxqQXZiSG5C?=
 =?utf-8?B?bVM0N0ZMbnE2S0dWNnRRMS84ZjhrSXBDNXpJOFU0OG1BRG5FWW0wcmhkVnd6?=
 =?utf-8?B?YTZ4VXVTaldqM3JuK1kyRWpITllqdTF2aXJlbDlOMDNMNTRrQTl4Nkk0ZFpt?=
 =?utf-8?B?U2t5N3NUV2F6L04vQUF3Q0g0QXhrZEMveHp0MjdUamFhSURqNnRkeW5YTWdX?=
 =?utf-8?B?ZEhMYVkvM0dWYTBGWW05dWJjRHNERTRFc1lzZ094cy9OUjhXZG9mOW5hV25a?=
 =?utf-8?B?UkxnWXlOTmJhUTQzSHg0UWdFTjhic2ZGOFNKczBUVjBBMkRlY3JMT292UXdW?=
 =?utf-8?B?WUMwUDh1M3BvTUlrMjl5VXFISVhpRUU0V2sxNnVoN3hpcG0vajVRT3dvMHcv?=
 =?utf-8?B?OW1GQ1ZwQTU4dTFBZDZBNjdCY0FnMmNRQkVpbHBNVis5QUJ3bUVTVDVMMUxz?=
 =?utf-8?B?TFVKd1phTHhSdlozOHdvMzlmQlVhWVNMUno1RXpCMW5neWxRbnJNbjVZOGp6?=
 =?utf-8?B?VnFhK2M2UmM0Rmw5ZHhST2Z1bDJiTmVRSnJtSFgySmRab3VwN09zK1p3U3J2?=
 =?utf-8?B?UytpekVnS3FLSnVOYnBBWTZUaUw2VG13a1IwNkN4NEZ0aXkzZUFXekdsRWor?=
 =?utf-8?B?bFM3STdzMmtCOGo0OHVvQXBOMEYrRjBLejY3U3VYeWJhS21sQTlrTmVrQnlj?=
 =?utf-8?B?K1E1TnVieEtrVUJqSTNkSW5Obi9UaE5xNkNRN2ZWUllCWUp6b1h2R2pSRjIx?=
 =?utf-8?B?aDd6ZVliall3SUlhZ2hSZHNUYVo3NDc2cFNSOWRpdHZmTWxaYXBLT1JlNExS?=
 =?utf-8?B?U21HTjZEK2p5eEdHZHdIN2FrZWR5WmJXaXJKMktYZE4waHJiaDdaWVJpRnNW?=
 =?utf-8?B?blVhUzRWRFc4RS9Wei8rb3ZybzF1cVFrdkxROFM1OTlBdFQ4SzJNVERwQ0sw?=
 =?utf-8?B?SlhSc1ZtQjJZeFRKTkVpUDdTL29uMGU1WVFORFRFNDZmTDh5RDZoUFZGeE9M?=
 =?utf-8?B?V1ZPYXJUdVhVRnVsWDJLRFdNbzc0NXY1TXZOOXRhSis2MHFkMUozWmtHaDdK?=
 =?utf-8?B?SlFJUVV2L0FpUlZ2NU0yT3BieXlYUXV5bkVBUkk0eThGSHdmc0RVTE5RdDlQ?=
 =?utf-8?B?aklVV211UTlDcEZpZS9iR09UUUwxSGFoazZKWEpSbFNkOVU2cWg1RXE2OStv?=
 =?utf-8?B?aUxCekx4ZEk3V2pFcnUwTGIvOExuU2lGR0ZKbjI5bUNYVkxyYUc1YzFaNUh1?=
 =?utf-8?B?R2NuY0hlTkhyZFlmZXZUM215MU82WDNRV2c2WEFRRWsxdnUvOHpvR1dYelZB?=
 =?utf-8?B?dUhKcHVmVUdZaTkrWVY1dnU5OWEza2ZIbUc1MERyZ0RpWHJEUThic09TSFN3?=
 =?utf-8?B?S3VuRmo4T0loS0pOdGZERXRIR3B6Y1Y5blFJYnVOWUl3SDJjMVVobUZjd3Iy?=
 =?utf-8?B?bnpDeE5yQ0NoWExxbnh0WFoxa04wVi9lbUNGYVFYbGY5NmFpQjF2RmdXNFVZ?=
 =?utf-8?B?Mm82YmxrRTUrUThEeWlQZHpwR2pwZFAwK1BWdmdyd0NkRUFiRUYrMWdqekZC?=
 =?utf-8?B?c2t0UDdadGVFU1l1MGx2K1B4NWJPNVBKbVFlaEh6NnJxelh2WG9YbHBQTWoy?=
 =?utf-8?B?VWR5WXVPZG5Cd08weS9YZi9jYmJtajlNN3ZDR3JqTzE2aFpYa1doYXlrYzFj?=
 =?utf-8?B?SlpEV3JzV0pKVE0rdlZBVjJHdFFYd3BOZXNNUENqM2NPQnVPdS9iUVRTenlQ?=
 =?utf-8?B?eVVDemdFcVF4K01PNmNUTzZiS3dGV3QrWTdUeWhsbThzOUNFbDVma1NzRUlk?=
 =?utf-8?B?Mm51YzVZdjZuNk9YcElQKzBhU01nd2lqZzBBUFpGRUpOYUxLNk4yOWJFMFNz?=
 =?utf-8?B?M3h4ck50d055T3N6a3NNNU9McHVDWC9RSUdPN1VuMzFTNkNZTmNaQkZTdU45?=
 =?utf-8?B?TXdqSXppZ1MyNisrY2lCdHpmZVJjVTVRN3RUZ01UeWNmVDdhOUdWbGVuczZ1?=
 =?utf-8?B?M1MxYWlSZnUrRmNGVTZIWWVvQVlValFTUVVHTGlFZ1pESFl6N3RPYXpWcUEr?=
 =?utf-8?B?eHRzeW5sRGRCN1paT0ErR3JhVEpaS1IyNHFzQmtQRHluZU5ybi9aNGpaTDNR?=
 =?utf-8?B?YU9UaFJyWEtkRzYwS3QwVXp5blc4NU9FMjdYVkQ2dEpWWGZyR3hSWjVKSjU5?=
 =?utf-8?Q?g5yMHPOPO4BS6qeJQvI8qoQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J1zNfu2yI+Fp0BH9PMiFenJUBqpPy45jHzGqUr7H5i+2+d0TI/U38C/5yCuka+lYmmeOsl//ic9kF3fHc4UoWlKGqsPtE4sNtx1NzcUkugysvzG72TiFQPqq4voOQhj+TUlHwsc90KJz1Ie7EA3KZt4gab9V1qxBrZoqOU7aLJBnzq9B/BZ2C2jFlOskhqfyxW4aQnAaYUWgAn+GpdDJqTOQXYUOaqa558k6NfjfOKpna0W7y5qHDC0LphO4vPrBCy1M0JWUGPsgaITqRDpLVgIqsdZthHevYdyIBBBz5SpEUHAT6cLYT7/2yt8pktrXc34TGlIBY/pHDS4TUA5sh2aMX7ZbBqtOcqKR/C42sATzy7LmkH4/Cl0yV6Qjmf13B6pp3h8ToHUAQi5eT+uhM0/1hml3KUcAS7lRTUVZ0Go5y28G93Wr9G2n4raKtfv3E519xnhJfiU3vcTeJ+0Pomn/PVhuphLgnZ5VOFckhApYcvKjg8q2rbdBYRTX9FyRdCEpg3j2X7LjMkdPeucPb2BvRi5ygeYZViyBLrfH+uS2rMDTBZTBja/y4VkA+QfKA9EALS0c0I6+5QGOsxRUoKfcfVv8PXzFGcVP6xxobSfwOmbmduXpPZrnrsSjlCawuRNYjp4hWAIqIw7nP+C0smk7dcWvYZunB4jrk9tVm47p/3Ij8VgC2KSOYr0OHzcqDwdKEiUrZaW0q7Dd9rpD+4Pfmf/X2KcMYdpmNYoXqUvn3AE1cp0YUSkp4rHln3ARFCeb1OWyU6X6uj5WAfN/NS6ibFtrmBO68yaKFLcPBpOE4GgJI+hCGVRsuiQAW9YlNHr48dSqTUZQ6wXG5leePPTrJu2aCofevIGZuqT8/IgS/y1XVLppBfaN+fgMZHa+dNPT2/IKSw3kO6jzSjgauQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d616ab-10a4-4f74-e2e4-08db7c35e153
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 02:25:05.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9R3Pis1AuDXD3MBubmOl0EBD/1rpvD6jcYpkCzPLD0saxujJkxToU+Hdtj84kqOKXDvZvmQcdmuPTmJf/yj9SBpS8N5ky599OZtI2sVWBtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_17,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040019
X-Proofpoint-ORIG-GUID: EC_DrepnG5FhIm373bFMlIsZztb8PsqQ
X-Proofpoint-GUID: EC_DrepnG5FhIm373bFMlIsZztb8PsqQ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 3:05 PM, SeongJae Park wrote:
> Hi Sidharta,
> 
> On Sun, 2 Jul 2023 22:58:49 -0700 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
> 
>> Saves three implicit calls to compound_head().
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   mm/memory.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 93480e846ace6..33bf13431974c 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4594,6 +4594,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>>   {
>>   	struct vm_area_struct *vma = vmf->vma;
>>   	vm_fault_t ret, tmp;
>> +	struct folio *folio = page_folio(vmf->page);
>>   
>>   	ret = __do_fault(vmf);
>>   	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
>> @@ -4604,11 +4605,11 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>>   	 * about to become writable
>>   	 */
>>   	if (vma->vm_ops->page_mkwrite) {
>> -		unlock_page(vmf->page);
>> +		folio_unlock(folio);
>>   		tmp = do_page_mkwrite(vmf);
>>   		if (unlikely(!tmp ||
>>   				(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
>> -			put_page(vmf->page);
>> +			folio_put(folio);
>>   			return tmp;
>>   		}
>>   	}
>> @@ -4616,8 +4617,8 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>>   	ret |= finish_fault(vmf);
>>   	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE |
>>   					VM_FAULT_RETRY))) {
>> -		unlock_page(vmf->page);
>> -		put_page(vmf->page);
>> +		folio_unlock(folio);
>> +		folio_put(folio);
>>   		return ret;
>>   	}
> 
> I found the latest mm-unstable tree fails booting with stacktraces like below,
> and bisecting points this patch (commit a43f078c7a3b of mm-unstable).  Do you
> have any idea?

This looks like the issue that Matthew pointed out in the thread.
Andrew, can you please remove this patch series.

Thanks
Sidhartha Kumar
> 
> [    7.388551] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [    7.389149] systemd[1]: Starting Load Kernel Module pstore_zone...
> [    7.390101] #PF: supervisor read access in kernel mode
> [    7.392370] #PF: error_code(0x0000) - not-present page
> [    7.392372] PGD 0 P4D 0
> [    7.392376] Oops: 0000 [#1] PREEMPT SMP PTI
> [    7.392379] CPU: 9 PID: 594 Comm: systemd-journal Not tainted 6.4.0+ #8
> [         S7t.a3r9t2i3n82] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-4
> [    7.392384] RIP: 0010:_compound_head (include/linux/page-flags.h:245)
> [ 7.400935] Code: e8 35 b5 cd ff 5d c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90f
> 
> Code starting with the faulting instruction
> ===========================================
>     0:   e8 35 b5 cd ff          callq  0xffffffffffcdb53a
>     5:   5d                      pop    %rbp
>     6:   c3                      retq
>     7:   cc                      int3
>     8:   cc                      int3
>     9:   cc                      int3
>     a:   cc                      int3
>     b:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
>    12:   00 00 00 00
>    16:   0f 1f 40 00             nopl   0x0(%rax)
>    1a:   90                      nop
>    1b:   0f                      .byte 0xf
> [    7.405283] RSP: 0000:ffffb86140cd3d58 EFLAGS: 00010202
> [    7.406551] RAX: ffff96d3c19c4d38 RBX: ffffffffa103f080 RCX: 00000001019c4067
> [    7.408233] RDX: 0000000000000000 RSI: ffff96d2c0000d38 RDI: 0000000000000000
> [    7.409893] RBP: ffffb86140cd3d90 R08: ffff96d3c19c4d38 R09: 0000000000000067
> [    7.411457] R10: 0000000000000000 R11: 00007f2ae19d5fff R12: ffffb86140cd3dd0
> [    7.412792] R13: 0000000000000001 R14: ffff96d3cb7aa450 R15: 0000000000000860
> [    7.414139] FS:  00007f2ae0f40980(0000) GS:ffff96f1fd640000(0000) knlGS:0000000000000000
> [    7.415699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.416780] CR2: 0000000000000008 CR3: 0000000104830000 CR4: 00000000000006e0
> [    7.418115] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    7.419492] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    7.420830] Call Trace:
> [    7.421308]  <TASK>
> [    7.421722] ? show_regs (arch/x86/kernel/dumpstack.c:479)
> [    7.422411] ? __die_body (arch/x86/kernel/dumpstack.c:421)
> [    7.423113] ? __die (arch/x86/kernel/dumpstack.c:435)
> [    7.423716] ? page_fault_oops (arch/x86/mm/fault.c:707)
> [    7.424504] ? search_bpf_extables (kernel/bpf/core.c:751)
> [    7.425329] ? __pfx__compound_head (include/linux/page-flags.h:245)
> [    7.426171] ? search_exception_tables (kernel/extable.c:64)
> [    7.427084] ? kernelmode_fixup_or_oops (arch/x86/mm/fault.c:762)
> [    7.427995] ? __bad_area_nosemaphore (arch/x86/mm/fault.c:860)
> [    7.428891] ? up_read (arch/x86/include/asm/preempt.h:104 kernel/locking/rwsem.c:1354 kernel/locking/rwsem.c:1616)
> [    7.429514] ? bad_area_nosemaphore (arch/x86/mm/fault.c:867)
> [    7.430367] ? do_user_addr_fault (arch/x86/mm/fault.c:1458)
> [    7.431238] ? exc_page_fault (arch/x86/include/asm/paravirt.h:695 arch/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)
> [    7.431998] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570)
> [    7.432802] ? __pfx__compound_head (include/linux/page-flags.h:245)
> [    7.433640] ? do_pte_missing (mm/memory.c:4610 mm/memory.c:4682 mm/memory.c:3670)
> [    7.434425] __handle_mm_fault (mm/memory.c:4947 mm/memory.c:5087)
> [    7.435234] handle_mm_fault (mm/memory.c:5252)
> [    7.435976] do_user_addr_fault (arch/x86/mm/fault.c:1393)
> [    7.436786] exc_page_fault (arch/x86/include/asm/paravirt.h:695 arch/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)
> [    7.437517] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570)
> [    7.438294] RIP: 0033:0x7f2ae1480ace
> [ 7.439035] Code: 8d a0 48 00 00 00 49 8b 44 24 08 48 0b 85 48 00 00 00 74 28 48 8d 3d f1 63 1d 00 e8f
> 
> Code starting with the faulting instruction
> ===========================================
>     0:   8d a0 48 00 00 00       lea    0x48(%rax),%esp
>     6:   49 8b 44 24 08          mov    0x8(%r12),%rax
>     b:   48 0b 85 48 00 00 00    or     0x48(%rbp),%rax
>    12:   74 28                   je     0x3c
>    14:   48 8d 3d f1 63 1d 00    lea    0x1d63f1(%rip),%rdi        # 0x1d640c
>    1b:   8f                      .byte 0x8f
> [    7.442519] RSP: 002b:00007ffdfa53bc70 EFLAGS: 00010246
> [    7.443524] RAX: 0000000000000000 RBX: 00007f2ae19a7028 RCX: fffffffffffff000
> [    7.444857] RDX: 00007f2ae0f412e0 RSI: a3d70a3d70a3d70b RDI: 00007f2ae1656eb0
> [    7.446195] RBP: 00007f2ae0f40828 R08: 0000000000000001 R09: 00007f2ae19a7000
> [    7.447572] R10: 000055f8d50a1010 R11: 0000000000000246 R12: 00007f2ae0f40870
> [    7.448939] R13: 000055f8d50a7110 R14: 000055f8d50a2fd0 R15: 0000000000000001
> [    7.450277]  </TASK>
> [    7.450725] Modules linked in: ip_tables x_tables autofs4 raid10 raid456 libcrc32c async_raid6_recov 4
> [    7.454653] Dumping ftrace buffer:
> [    7.455321]    (ftrace buffer empty)
> [    7.456014] CR2: 0000000000000008
> [    7.456686] ---[ end trace 0000000000000000 ]---
> [    7.457576] RIP: 0010:_compound_head (include/linux/page-flags.h:245)
> [ 7.458440] Code: e8 35 b5 cd ff 5d c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90f
> 
> Code starting with the faulting instruction
> ===========================================
>     0:   e8 35 b5 cd ff          callq  0xffffffffffcdb53a
>     5:   5d                      pop    %rbp
>     6:   c3                      retq
>     7:   cc                      int3
>     8:   cc                      int3
>     9:   cc                      int3
>     a:   cc                      int3
>     b:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
>    12:   00 00 00 00
>    16:   0f 1f 40 00             nopl   0x0(%rax)
>    1a:   90                      nop
>    1b:   0f                      .byte 0xf
> [    7.461986] RSP: 0000:ffffb86140cd3d58 EFLAGS: 00010202
> [    7.463014] RAX: ffff96d3c19c4d38 RBX: ffffffffa103f080 RCX: 00000001019c4067
> [    7.464374] RDX: 0000000000000000 RSI: ffff96d2c0000d38 RDI: 0000000000000000
> [    7.465731] RBP: ffffb86140cd3d90 R08: ffff96d3c19c4d38 R09: 0000000000000067
> [    7.467114] R10: 0000000000000000 R11: 00007f2ae19d5fff R12: ffffb86140cd3dd0
> [    7.468469] R13: 0000000000000001 R14: ffff96d3cb7aa450 R15: 0000000000000860
> [    7.469824] FS:  00007f2ae0f40980(0000) GS:ffff96f1fd640000(0000) knlGS:0000000000000000
> [    7.471383] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.472482] CR2: 0000000000000008 CR3: 0000000104830000 CR4: 00000000000006e0
> [    7.473835] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    7.475216] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> Thanks,
> SJ
> 

