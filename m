Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EC468B511
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 05:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBFEyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 23:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBFEx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 23:53:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E02D77
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 20:53:56 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 315N4mkY018938;
        Mon, 6 Feb 2023 04:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KpBka6SXZ8VOU406/sM8GjDPWDzgnRAvTVc8ccaY6Ns=;
 b=0vh2NCcz2zgQPmVcXGqpEta/nOVyLz/yJqwtFbMuiTl8dij3JZR2g/f6PGERklOtNB5s
 CKxkT2dzt6u3ElVcTHAVGNnQ9Rd02F+bM6TBaAu9psvKx8KAfBp1sqToZfLfQlTEuz6Y
 DY0qJ7SCmDYGfWVeKmJn9nSF39XsvMEFUW2kKnjSN5JDPRON7x3AKDWT3ZY543kcD9bn
 nqPQ83Wy9Ujgzb9bhPRSb2d4fwPe2r4EqRVLY18dd+Frfj6SD6U2L0aTwip8xhhGiMpX
 n7hB+0UEXNfN4Nh87uBlMc1ynEIM7XyyqdUz9HC9x6h1nhmhYqCk5n4VnjN8ds//aA2S 6g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfdca0fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 04:53:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3162X3vA011584;
        Mon, 6 Feb 2023 04:53:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt428ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 04:53:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVdxv5EQJSvYIHoqY57fJL9hi/OTSGVgNMlFZbws76RXUMfcnvCBfDTvNMaP9cRm3fxu855Pt6CS58eDLEB6YXyG8HsRXbzXyESwoEXOeTdB68XJfvLh+wtRQZL5QSowBC4gCglqqkZiiBqUICca7LBQCEPOC+rEWf4nEhb8B090p7RAjpE1qUFwXrTvtXLLfFLSXfOGnUSNLijTJVGDCNvlhDVpsgRQu/jo76a3XKzFLmU79RZ9PRSxJJrg/NPxCkM0czocitsQYeZAWjQqL/w2ADKQygsKNV6/RPNxL976WgEhFh5DDWGJHj2WQdLnEfUxE59rYRVtnuFUKMQnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpBka6SXZ8VOU406/sM8GjDPWDzgnRAvTVc8ccaY6Ns=;
 b=BIQ/7yKvteNb7MOvjTGkvq0NEEt/eGQvapjADKJVF2Cd/zyHk3ER6O/jacvKXDM4amJDB825j/8l+EQkbT8jPgLYz6FgpMrKTh/J1tBFwI9PkEM5r6YTr2KORa3jXcNuB9mwmI9z7JMA1l/cCisYOHyIJ6rIOwr3IhKtb/zMrJIKI07G26giG6mBG+GR/KX6n/HSicBdJgY3GYFPn6Olx6JcdM6iVB7rfbYnHuS9OIF6grDDl1B96055IISLTuQWoNh9MOyBveTK5f22E+CIQT+obiWUjF528Bu/iULq5qHcnZ6q+xQ+jUSH/HPzhWXxuxt3sDbz1M2JDPTspJQz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpBka6SXZ8VOU406/sM8GjDPWDzgnRAvTVc8ccaY6Ns=;
 b=fS54worMHBtT/iDEKwL+zsa0GdpstGDk1zzcQDQp360znQLNCywtUm1HM11COkdd6vhF2iWqiKZYUcD0i2PfkkWNbYMfpzWQEK980XV8lNqkan49tbDAxBsA/GeC5I1O/NRYRelcHHGsMNI6EBKZpDahHeB8hK21EevdFTZaxL4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BL3PR10MB6164.namprd10.prod.outlook.com (2603:10b6:208:3bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Mon, 6 Feb
 2023 04:53:45 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%6]) with mapi id 15.20.6086.009; Mon, 6 Feb 2023
 04:53:45 +0000
Message-ID: <7b3af822-0075-889c-911c-b79860fd5ce2@oracle.com>
Date:   Sun, 5 Feb 2023 20:53:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/6] vdpa: conditionally read STATUS in config space
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
        parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
 <1675400523-12519-3-git-send-email-si-wei.liu@oracle.com>
 <0f158916-aaab-0afd-6cd0-382f54ef26d9@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0f158916-aaab-0afd-6cd0-382f54ef26d9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::34) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BL3PR10MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b98560e-077b-447b-d9da-08db07fe2056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8Im6U5zrJYazRk2L07PKH79WXnrL3hk2t9Gxds1a8l2FEMA1aOanK22FoxH3OfCfISUnGVPq8AQ6EfOsNqCmCfHMjx607fw1KqlaA2MyWz+qOzW5ZNH9xDCNoZJlvk5uWdOHBWgKiP1SMMgNJYCrGfWVSXAnjd4AoeXkacPejlQ9H2Y8N9pgXSE5dyaOYnxaBfHv6Rm4XH5fQaLkVOI56o92Q3tQWxlngRKglAF1Q38odsmUolJI7t9XxP9CzGIyHE2IEv1vdTUjPHghXVZ31KP40aU/djSUxj0F6dqJqTgC/nklj0y7laBdXt52vdLRqQRsWTISgvuhWS+3y2rMUFtRHk2Dab1km6G1lRk9S0wzTXclOYTKuJvYuIoAtrw37zbl+UgGSO9E/S9yqo8SJE8ik54kpxdd9xuckDcUVbAU7//KX23hxrzWQSCRT7Vwf6x6GOQqWjhtKpw959cbkz7nwpOJG3ZhhsCU46mHSrMBBu3ic8AYKUGol5Ot0gCLyfoHGGIOXMZq1Ujxg46Of2vxCrLIgcIElf1ljsY+OnnY0+7S7oSiAaqrIq1NjoNp/cJCrUPGn3o/InMnmdE1OST7Rs2/NeOzvkfmBFTHNDwS5Vn2cuT8lmD4FHUIJlRDVduw/3NJwSlKWlyOf0GZgDw8ITgUWioS2U6jFn9EEJuz/dTqwHFYeOzcHf+tamHBMqAHQkJFxgM/PRbnv/9KhwYaxXBTHDiO3KUxS17jbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199018)(2616005)(36916002)(83380400001)(41300700001)(6666004)(4326008)(316002)(66476007)(8936002)(66946007)(8676002)(6512007)(86362001)(53546011)(6486002)(186003)(6506007)(31696002)(66556008)(26005)(5660300002)(36756003)(38100700002)(2906002)(478600001)(31686004)(66899018)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlQ0cmtGY3kzSCs2Z25EMHJqZ3J2MWVKMEVFaGtXRTc3Z25FYU5ZZXpHb3BQ?=
 =?utf-8?B?U1hZZFAvcytKMmhIbWtTSVdmeWdpT1M0S1VpdTR4VVJTdFU3R1VUd3U0RXc2?=
 =?utf-8?B?QjdaMmRtYnA3T1dxZCthMnZpYnpxRFo5RDY0MUpkL0hHUkNwTjN6SFFrQ3Jk?=
 =?utf-8?B?NWJldUFuSDRtM3g4WnpjVy8vWVFCVU8wRUtlSktzRWhXQWc0UlRHNE1NeXpX?=
 =?utf-8?B?RHhlMmV0UkhLaUMxWGZ3dDlsVS9EVTZyckV5dzRwTURDbk1DV01USzk5UVBr?=
 =?utf-8?B?cmtpZTk5cUp5Y0pNR2o1MHlCVW56akw0VjV5M3pLbzUwdVpIYzBJZnIvcU1u?=
 =?utf-8?B?Z2Q1OFpPSkNOUFIrZytmN05lL0RFTDl1eFVxTkwxOUJQVi9yZURudVl2dVkv?=
 =?utf-8?B?amF0LzhZL3ZzRkNXOHBiQzI3M1BobnRMZnJwbWZ2YUVZMnpCVFVHbjJLcHlm?=
 =?utf-8?B?NXBOTUg3YjlpSjJjU2xQN0dVVkFvUDdudExRNW5vUWg3ZVhhODF6ZUNqc084?=
 =?utf-8?B?bUtpdEhvclUxa2pZNkRSeUJGdWZoVkR0NEJvemRaeWkvWTNyZnQxN2h6L0Vp?=
 =?utf-8?B?WjR5Z2NVZHhPWVJvZVJBTnRCM3BJUU8zR0xpZVVHWitZdWtDNWdGbFU5QXlB?=
 =?utf-8?B?YzQ5WDF5THJjMTRkKy9LVEcyUlVjVzNiVXFqNS9QbUlDYjdIQUdHSEpvY0RI?=
 =?utf-8?B?V1RyTWU4MjZLVnk1aGhiR3A3c0dPNHh0V3N4Rnl1R25kRGxvb05wVkZQK1di?=
 =?utf-8?B?ZGtad2VsVSt0bFUrNXUybDI3RlpxUXJWMWlzeDNrblRjOGZwK0RzVTVJcHJE?=
 =?utf-8?B?bkNnNGI2bEIzd2tSN0VOU3VVRFJ6VGZnWERHR3VCY3pRM1FZZ2h4Z1JoRmlO?=
 =?utf-8?B?TTRYa3FLU3lOQks2S2RNNm9lL1Yzd25uOHZRWU1odGNYajVSNm5yLytnTllw?=
 =?utf-8?B?M3p1RC9VZmdkcVhsU2lGbk9wWVNGdlZWVklrZ1FHVHhOd3JGVTFSTkp5S0sy?=
 =?utf-8?B?ZGRpUXNHV1ZBNHcxcXAzMHk0dTZ6SFJIY3B1V1E2L3FNRm5ITmtNWGpLdzdt?=
 =?utf-8?B?NDlZdjNwVlVPeTN6UzRBVHgxZ0xEY0VQcVkrT1ZtakFVNitTbmNwbGZYd3FN?=
 =?utf-8?B?eVE0bW1jaW55VXo0YzY2OGhrK2Y4WlBXQWxUUTRaM25BNlJkeE1qQTAySlA4?=
 =?utf-8?B?YnlpUmlGWURhN3NCR3duVG1hMEpLYXhPREFHYTdGSkxHL0RGVGxrcm10V05m?=
 =?utf-8?B?V0gvMkROa1JrR3VOVlp3ZEx3ZHVDam5IZHR6UmdHbTRSL3hEVmV4cnBrTzQ4?=
 =?utf-8?B?K3hhTk1pbUxKYnZBa1BrK2ROTmptazUvUGhpQnRvVm5WeXhPL2tWTXF0dkx5?=
 =?utf-8?B?K0VUY3loYWdpdWx1OGFML3EwWGJ0RUpDVkQ5N0RuM2ZGejBCV3dGTU5IdW1D?=
 =?utf-8?B?TkprTmJlNDhWV0szR0ZHM09DK2dDMDhKZ0lyc1ZEN2tNK1RJM2Q3VkZheXdw?=
 =?utf-8?B?QWxMTkdQcGZmLy9GaFVWZlh1WUVBR25tNEZXTE9SZ3dMVXVwWldkN3JiR3Vj?=
 =?utf-8?B?UmRKWXdhUE5IUVBuZUMvN2dIanJ5QzRncTBCWC9JMUdndUx1eGhkZWJMQTJI?=
 =?utf-8?B?b0tWazJLTWl6YUdDU1hxb2lQZHdtZDZBbTRvYmNyL3ZWWXU2MDJYZWN5Y0hS?=
 =?utf-8?B?MmUzdnE1N0dzbEE2L2tabWFiSlhWMm9FbWZpaWwybDEvdzVaN05UN1VPZTFC?=
 =?utf-8?B?YzlscmczNnUreUswdy9NdkFlTzd5N2ExRmpHUlFVUHNkNWg2eHRPNXdwelIv?=
 =?utf-8?B?SWIrT0xoaEs4M1pSMHhGZk9nbGhiVEMvbExLUExKM3A2T2taQ3pRcjhWMTZ0?=
 =?utf-8?B?ZTF4MjNXN2Jxc2FMQ2VQNnFMd2dWQmlYcHo0alJ2b2l1UDJNdmZEZGozZTc4?=
 =?utf-8?B?NWtzWDBFL2w2S05tU0VMZUNaL21IM2JHbC9jQTZZMWl3WDQ3OGw1M1ZuU0l0?=
 =?utf-8?B?STFQT2p6UWF1RWRKWlQwckRBV2xrbDkyUkJjMFk5Y2NNMkhCdHZlN2ZETUQ4?=
 =?utf-8?B?Z1AzSm5UbVh4MUFiRDZVdWZxUk55QkwyUFBLWVltbHVhQkNzZTcwSGlaYnhr?=
 =?utf-8?Q?/EKJ3RXcZeXu5hpDr1ElfL0HY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: phtO1eFTP0i5kSVEUEiHLsO8kYauoMKO8bSvLq7g8YgmdoIhIKmsF7GtckZJB9F9ao0/yZf7TsVe6mNLZheDHwKEPoUXz1qPoEyspC4xpyuX/p9TRLLrdTGucdNGy/VJLD63T0aPosJxYq07y0qtaqQGlQtOxUjracPA0ITy+zi2W/ie2r5FyBMCmIaXT8Is1jHJZSQr6/Q0c5vkA3pENH0EC3dvwIvK9OM596s3Im3YgRDES50tFOjaU34HDh9rW7UTqmfCJ12qn6PrfdZctlP3+MU4MDNh6tog7XCVs7KCdS5viJV9KEVfd83WqJyTwAtl2CODDaXusyftKAl2jaXwt8Rpc6EFDa8d4XJcIjpXNJs/37qgm4u/U6Bw87CYBTBZJyIOu76sSCGItRjIR/CA08lLQQIJwzq7sb9ZTSLMkrl52OrB+WoLqD5utx1mY3x40g8blNwqzl2NyN1hF7eOF7cj213wc+yumUM0yPcYu0HweU1vt7ZMw7L+n1+HPewjdUjvOJ+8FjUaFYHpfM0YoDIY9aQ0hvyJsgiXCIUEMZBQI2RAVqzPG+vgQYZ7/qgbqG42dpvrY0ClARGst7pR/enXdm8XPtTRO300KTmsw2eC6nu085Xp5uvNwAEarowCJHDJGQkM+6fG0rrGLIcRnAssTSqSB//eJXEKSV+fEHC7C9b4pHaYzw8HaAXxKFlcw/1OcRl5K+CBxK9xO7acSJTgBuUDbtdOgcuazBU2V3h5Xa5JJcEgr/showMSDXosQ9SqVr2m3inH3fkskaJvJdJaQlfN2WQlzMzhruZKNJu26g9TCiBZE5OAGBI0TrQc5Bd05j810NS9BRSsieqLDCM2bdk/8qL2onPnLKMMRIvzwtiOVko5KSRseasg0qg6HKpoRhgI764AQXS4gQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b98560e-077b-447b-d9da-08db07fe2056
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 04:53:44.9957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6vFcD8vOnFeZ27PznhVbN1pxT4pC47X2cZ0RFjNuGet+lLNWS9OIBvzXMsBYGipNhpKPEGzs99rlJu7AQ8Jew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_02,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060042
X-Proofpoint-GUID: QhWH9t5b--WOmZ1LULG6tPBmXSHAGw-R
X-Proofpoint-ORIG-GUID: QhWH9t5b--WOmZ1LULG6tPBmXSHAGw-R
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/2023 12:26 AM, Eli Cohen wrote:
>
> On 03/02/2023 7:01, Si-Wei Liu wrote:
>> The spec says:
>>      status only exists if VIRTIO_NET_F_STATUS is set
>>
>> Similar to MAC and MTU, vdpa_dev_net_config_fill() should read
>> STATUS conditionally depending on the feature bits.
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> ---
>>   drivers/vdpa/vdpa.c | 20 +++++++++++++++-----
>>   1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index 3a82ca78..21c8aa3 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -843,18 +843,25 @@ static int vdpa_dev_net_mac_config_fill(struct 
>> sk_buff *msg, u64 features,
>>               sizeof(config->mac), config->mac);
>>   }
>>   +static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, 
>> u64 features,
>> +                       const struct virtio_net_config *config)
>> +{
>> +    u16 val_u16;
>> +
>> +    if ((features & BIT_ULL(VIRTIO_NET_F_STATUS)) == 0)
>> +        return 0;
> Instead of returning 0 here, it would be better to explicitly put 0 in 
> the message field for
>
> VDPA_ATTR_DEV_NET_STATUS
In light of commit 41a2ad927aa2 ("vDPA: conditionally read MTU and MAC 
in dev cfg space"), the userspace must now show the config space field 
presented by the device *as-is*. If the feature bit is not offered by 
device, the relevant field will not be displayed in 'vdpa dev config' 
output. For instance, MAC address won't be shown if the MAC feature is 
not supported/offered by the device (note this has nothing to do with 
negotiated features), even though the vdpa parent may have a non-zero 
MAC address of its own. I think STATUS should not be different from MAC 
and MTU here.

Regards,
-Siwei

>
>> +
>> +    val_u16 = __virtio16_to_cpu(true, config->status);
>> +    return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
>> +}
>> +
>>   static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, 
>> struct sk_buff *msg)
>>   {
>>       struct virtio_net_config config = {};
>>       u64 features_device;
>> -    u16 val_u16;
>>         vdev->config->get_config(vdev, 0, &config, sizeof(config));
>>   -    val_u16 = __virtio16_to_cpu(true, config.status);
>> -    if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
>> -        return -EMSGSIZE;
>> -
>>       features_device = vdev->config->get_device_features(vdev);
>>         if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES, 
>> features_device,
>> @@ -867,6 +874,9 @@ static int vdpa_dev_net_config_fill(struct 
>> vdpa_device *vdev, struct sk_buff *ms
>>       if (vdpa_dev_net_mac_config_fill(msg, features_device, &config))
>>           return -EMSGSIZE;
>>   +    if (vdpa_dev_net_status_config_fill(msg, features_device, 
>> &config))
>> +        return -EMSGSIZE;
>> +
>>       return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
>>   }

