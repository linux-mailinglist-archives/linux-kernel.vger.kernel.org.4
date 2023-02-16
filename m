Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746AF698B85
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBPFD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBPFD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:03:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDD034F5F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:03:55 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G2Ivv2011405;
        Thu, 16 Feb 2023 05:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jL3AmA3LmnkR5k7YFQdLY5n74U6mbPy/C7FpaOchGNI=;
 b=m3/eQTZ3+a6MsYSczSw9KcByaqC/+5JSRsEDCWQy3vF/vc8vzodb0uCWOjXa1eWOlzSY
 jSAY+4E7437RK9iWaojOFWlzYzp08f0szkJ+LLxypmv12LLXcm3pX0i34hcUaw4CHhgJ
 FN7515qwkM4cu+L2ucmflGM1oc+cuR9ZyEB6+9QP8ry1v2zJt4qxkGgaVOmImJGboLiL
 AeaQ9Ch/FS1gnxiV4ZK6f42ZffKxG80GJ3X45wTRM+zP/G2NGoj2EjqEtft/4JdVzRig
 kDR1SFrM2aylIUBmoF/TCOQ9TQ8BtTGyY98lqZg2tqUrDLX3JDsw6/m3tx8kAGRElh7S 2w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1xba7av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 05:03:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31G2NgGP024738;
        Thu, 16 Feb 2023 05:03:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f8mewr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 05:03:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxJ/XmQJ7aQB9QsSgjYo6Sd3aO6tofZfwx9KeEIdrZtGrhltX1oZvOjXURbmXr9JJlyIgOTWV5BO6EWpjyofAJZLyWuFkN7oX+f04A97cte4/efKpcScLzQA5d5wgQKWFucdG7ehdqaQyOH8yxIAbc/6lCrEEN3TvuR0DU6GB87rSVpkFE+b/MYPo+Pv9u4FtRT6maWN1fGFAKgxBzavStni8YjWJRZi1wXG0y+XLZHj+FtDW3rosqNLd84zbNnQ7oNdi49Klr+nd4NzgNh1RPvu+xVRSZQnKseqd3OTxuxv3Z/DL+CugOR+ksqanfVoRK7VWY29LF6DH+v+wEdEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL3AmA3LmnkR5k7YFQdLY5n74U6mbPy/C7FpaOchGNI=;
 b=ZcWjD+Ib5psHOAPyIYjuTdGt5kkS4/U2FBqAQIrjT4YGMWB+i+RWhPqnyo4y7q+MfxYOiTWS1vJ403I5yqmYE9tIlVqRcD81DF5Rtj6SbN/mlHqtuVzer9N+MAd6V+2ilHNKXtafAJ8sX5ozAREBd9p23SKebT4HQnfvZnms5T/8MrWBZMWITIajDs5t/u1SqJiVgkAzfQe2ilvnaDU/lPeuqY8V8bUneXskoPll9qjuftNsnwIUfRaiqH/EvucG2UYoJywZERmMj/lmo9MEQJhGYlQ599BJt/+YrziLK+GKmp/7Izz5ivISWGFeeZGm8zeYuZsllkH965VnmNrrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL3AmA3LmnkR5k7YFQdLY5n74U6mbPy/C7FpaOchGNI=;
 b=iKyXPMSszIn3mr25ykBoB5V7Y2Z6iGD8r1Scm9x+gKDRgjBPTEYyJiBiTYg/CM/b0FDix+bCCjJ6SiMi5UB60zo4eExddRVeFToEyttBcoz1im0argy9VZ4IlcpULVWsg5jhMJboV8kg3WKEkCIzXMO8H10Sa9JWu0gF0boo7s4=
Received: from SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8)
 by MW4PR10MB5809.namprd10.prod.outlook.com (2603:10b6:303:185::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Thu, 16 Feb
 2023 05:03:46 +0000
Received: from SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::9a30:b9fc:bc51:4934]) by SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::9a30:b9fc:bc51:4934%2]) with mapi id 15.20.6111.008; Thu, 16 Feb 2023
 05:03:46 +0000
Message-ID: <ea8bdfc7-46b9-8510-0a87-1fa6dd5759a1@oracle.com>
Date:   Wed, 15 Feb 2023 21:03:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] vdpa/mlx5: should not activate virtq object when
 suspended
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, elic@nvidia.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com
References: <1676424640-11673-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuckWowpA9q+ez0-U4FicamQ+5zXfumtQMA25jXpvL7uw@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuckWowpA9q+ez0-U4FicamQ+5zXfumtQMA25jXpvL7uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0022.prod.exchangelabs.com (2603:10b6:805:b6::35)
 To SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6519:EE_|MW4PR10MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd14b5c-9648-463b-2a5a-08db0fdb2eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJDDficzqJyauhwIyT1UJtJT3oDoXP3+V4SldMoE7NX71EBLrLik3ZJcnpAlxYZhLyKVojBEn4XcVEFT0lJJgafmd24+LbvswPyi9knmKvHeIYxonABkw7+bY8YhJwYePONyWSWrbb5TNcH0UfROQ2Qcajms3PyCDWYEdHjAPfst2jJ7HKDlAdTIehvMq16YHzePJB44jsXsW8+X6TotZG89KFrrfZRcdjLj6EF7ajpwh9HdfsUmarg3qRoo9P/3HeCYrLo5lzYwFkPQo8t/SVJ82mWdSO+3eRYGfonv1ByK0lusXdyQgR3QDJLYCa7weBMkMzkvZJ89TYKq3JncRrUN/lcTCkEV65CCgUV3AA+vnRU1ucnG8I4atlFuj1WCFqGlWzoQeyq/+/DDiRa9EcLB1h9xBUseDcTAw+f6YGngYER2I2cDuRebydq/TZ82ADwN0djl8JIwKqLmqv/TOjhqumHBbHYYYs9ikwL1jWV3yvMaxiwsknF5I04wb8upCyRV+bRkRStN9XVCb+q9ct4A5386lnVwh3CEp7iGDfRk9M8RCVfiCTq6MV8bWr9T1OHGAMc7IIV80JnhnvoGApn58GGI2oAnEbq5Mor3RbSCSbA5YC9iLx3iVMkzdterDCkfYXqOE7fi4UCFDYH2IuYtzNx13w6RAldal7cwgZhVq3eRgTXENhvaP2dGxCuHq3ZHf3B9sNWKxOD1y3Pnz0EAWe/YZGb++vak9O7ArgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6519.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199018)(31686004)(26005)(36756003)(15650500001)(2906002)(8936002)(5660300002)(66476007)(66946007)(66556008)(41300700001)(316002)(31696002)(8676002)(6916009)(4326008)(38100700002)(86362001)(478600001)(36916002)(6486002)(53546011)(6506007)(6512007)(186003)(83380400001)(2616005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjVKS3VZcHVJZmVoVUpRc3JHZHBzK0h3czFhVGdYV2NGQ0o5eVhtWm8rZVJ2?=
 =?utf-8?B?czZ0WDBXMExwSGxBcnAwV0tvczJ3bmMzZUEvMGhLT0RNK0N4OTdpenk0OE1n?=
 =?utf-8?B?bXh2TzI4VERkQXVlTGo5dkVNcVlBM1BPY2VDTTcyZHZ5bnNCME54UndEcE0z?=
 =?utf-8?B?OFdEeXRnU05lQ2ZwaVBFclpwOXhRcHVOeVNhZ3BXZEpZRDdHWm40TDM5UzFW?=
 =?utf-8?B?TFNzVTVKRDZQOGlnS0hpZUtsbnpMUjZ5WjdnMGJORGxreXpRUUVCZkpNbVVw?=
 =?utf-8?B?d1NaaU9wa3RiUkIwc2E0enJjaU1ZaFQyZmt0M0dKaGZkZVF0aXVvYWdwdExW?=
 =?utf-8?B?UzgvS3F5MjduaWcybkF0TWFPd2RIN0Nhb3ZHN2krK1NFSm40WDU5YkR1dFdH?=
 =?utf-8?B?Y2lRb05rQURGRUczOTNaSDVjS09uQlJNaWNuZ2xvSGM2S1g2ODk1UXNPVGlK?=
 =?utf-8?B?UHZLUHd4VU1aRTk1b0FLa2VZT2FuWVlETlRJZ3FFVVVIMVcwQWhEb2VQRTJJ?=
 =?utf-8?B?WXp6eTgrYjBaSlpPcEtuRmlJY2FkT0hXN3hJMW94bERFTDk1ZFQrajk0Zzk3?=
 =?utf-8?B?T1kyUStLdlR4VTlsOUZQMm1kaWJVWGVLZTNaODNOVHhCNSsyQ2Z1WTd4bExa?=
 =?utf-8?B?Y2d4VGZLTkZOc0xCRzJUbk5vQ21Mcy9oeExWWWlXMUhZa0srWEorTVdXY0kw?=
 =?utf-8?B?Sjd4MXhVN01BRzFzSzFrMTdHaHF5bVA3VE9CbFlwTXN4YVJQM1BLR0RRTHRz?=
 =?utf-8?B?bzV3VXk0WVdDRkRaekZjNTFFOXdwK0dxbUhpRmN6WjZtanp4L0ZaeU15bVRp?=
 =?utf-8?B?Z2NtWHF5a1FRUndCTS9IM1IwYlJnb0xXSyswNTh0b1MxWHdFakN6ay9SRzlu?=
 =?utf-8?B?clQzeEZuVmdEMW1YVGs4Q3QybjdHblJBdmU5SEtHVU9menlvQ3hSRWhkTmU1?=
 =?utf-8?B?a25QNDVMY0NoRHNSUUdXS3d6Q0lqM2pFdm1LNWExaTVZMTVucHBWY3JwelBj?=
 =?utf-8?B?cVRFaHJJUkRYQ09NaTU2SHJIVDRNdHJ2SGl0dnR5bWZTY3J4aGk3WE1JMFVQ?=
 =?utf-8?B?RTNKd3g5RmtmcDB0RGt3ZnhFSkIrelc2aWhKcnNLREx5RmJNTFA3MG9jY24y?=
 =?utf-8?B?TEllQk43Z0tSbjVtdlVGUzdxTFBuZDM0K1hYckFrbklETzhKNGJSUEVTSDBk?=
 =?utf-8?B?eUw3UkUxMEF1VENlZXFma25yS2hacUl3aDdIeFdXQ1NzTXhBNFFQZTZibjd6?=
 =?utf-8?B?Rjg4QTE0Vk9yeko0aldZeTJDMmVuclpDelowb3Q5T1BCY3dFM0VYS1FHZ0Fx?=
 =?utf-8?B?RERNaGg2bzZaMzdLUlorTGxOV1kzMTRVZmhZWXd6STFpQlpGc0h4V09LMk9n?=
 =?utf-8?B?NDVhT0pjSlBiY3E0WUtOdWppd2FETWxBZjFTVlA5dTRyME1nSFcyWkkzcmlp?=
 =?utf-8?B?RzVveWFUbEJ2MDdJS2Yra0hualFoZHplV1UrK0xkbkFuaitndlc2MUVaSEZ3?=
 =?utf-8?B?eHNNUm91ZWRrTFdrQmQraVM2dnVRMU1DTzNyWWJFT29UK3NndkJPYnMyWFhG?=
 =?utf-8?B?VzFxV1FMVmEzWFp1cmZZMmhjYTh6dFovVmdyZ1JPREoxUi84OEZuZlJnL3Yy?=
 =?utf-8?B?VllMY0ZRQ2src1dNcCt2UUUyRlZrTkU5Q0JVY3kzMkc1V00wNENuV25TNUlT?=
 =?utf-8?B?blNybDlxN3ZQN0p0QmM1M1ZnZnE0VHdsbUFMK1hKNTRaUkhmMWNhS3hlUDNt?=
 =?utf-8?B?T1lVSkZUbFYxVGpKVE9vVVZkRFI1QXlxYjYrLzhLelNZL0ZXUFRlNDRYc095?=
 =?utf-8?B?Y0JiWE43RnVBWnhGd1FoNkYxdWg1MUlyQTMyVjllc09ndXlKdjc3Unc1bUpt?=
 =?utf-8?B?dE52bmVYZC9rNUJUSHdnQzVuekRubXRBUHVDOFh2dFJQVHFGdjhLenI4Nkl6?=
 =?utf-8?B?ODk4Rnl6VVRtUTVMNjJobFZOWEFsd3lXeFBFY1N6QzlZNG83NHpLYXExSGtm?=
 =?utf-8?B?WllGWFBFdU1xU1hDazd1ZENZMUIxbjFtb2lrcVM3ZzJTSHJWQVo2SW10bkpT?=
 =?utf-8?B?ZytYMTJ4Y2NIbklmY0JmdVFQbjZyb1hwM2dkYzRkMUU2ektJaTBVL3pXQlI2?=
 =?utf-8?Q?+36B7W72hlhKdkOvc+9/wASKC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bsUtN9sH8Zy/eQsM/KKMtIqt3Bt1axYDw0is0nTLFePqOhehHvlLa6eQb5oBRkPq1W4s3g0soImEDTTX7r1tjQ6CVB+NLrjQhkWU8ECnO75huTByRadiJrER8hhq8D0E1pP7Q0hInWPiWJPqdMnNF+imz9exTvPOoVuh1akckTdXaD77eQDYHuUsnCvjmKrT4d835zmsxXYUgm5OUHgH1oqEywVK5vgKemELV7V6Gon+tsAcLGKxUgPunVxqAa/ATM3bPea8OO+/YvACxo7w4QMeia3OC1lKOjeD3p996LT5iYR/poeNbU/3ZXx7t9KOPDGfHfW9L/yhNaR9Z1pNHnLw0E0hSLHTSP1CI85XVMB9zJ2rRL4Xwqkr0Dfhls1FmLPEGB9Hq7FRQb+g6mJM+U8RAUGHVWYpm9InJuX/wewJK7vFdSgFCsSHynXypqNx5JWLA1BosRoL/C84KlQukaN9h6Ta9M2fR8kfnu2gEQS9ffzTuZGRug2tYxRqEFEntbKLOd0DdQtZ7d00BwNIn5RKabICSNZmatfkCn6gFfgrzwjeT7l9dXyqYOsL9Ev/lWN56/wyt+LhvHA6WpoPsmK/nzeCOCVYCBLUbegU+5/dZelo2n0sxdXe7hCGdqPkual5ZZN44vi0lMSKWFrNj8WmchC6vQuNg/p1pegH09zaXl89HkK/dey8NhZq7fTpn8qW4rTloOee1zMCBPbA08BT3jS4KBX81t9F8dAvjg53ba8E2FwlAB4zQ4dgbpZbpqJNGpU79fKGvc3RGoruasAIqkqEHn+3UImqI6QX/dIRpMVhPPKtaYSer4YO53GBve2Ui7QMBBl+J4ILURVoTjxWRm8bnCPthHwkefOgoI8qP0SfpNIsThzii/pa5LQXMYfBIjAReIga+qPv7asHLA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd14b5c-9648-463b-2a5a-08db0fdb2eb6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6519.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 05:03:46.0251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTawGL/g2bRx5SpzPpDdcytwBdE8qp9mNLe94yCjDg1wxT0os5KRVssMCg/gNefgHct5nRvaZzgs5NvjMjw53w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_02,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160041
X-Proofpoint-ORIG-GUID: Ta7GQtJ74RLN4Jg3wfpERNupA_PS_P-d
X-Proofpoint-GUID: Ta7GQtJ74RLN4Jg3wfpERNupA_PS_P-d
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/2023 8:48 PM, Jason Wang wrote:
> On Wed, Feb 15, 2023 at 9:31 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Otherwise the virtqueue object to instate could point to invalid address
>> that was unmapped from the MTT:
>>
>>    mlx5_core 0000:41:04.2: mlx5_cmd_out_err:782:(pid 8321):
>>    CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status
>>    bad parameter(0x3), syndrome (0x5fa1c), err(-22)
>>
>> Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
>> Cc: Eli Cohen <elic@nvidia.com>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> Reviewed-by: Eli Cohen <elic@nvidia.com>
>>
>> ---
>> v3: move suspended to struct mlx5_vdpa_dev
>> v2: removed the change for improving warning message
>> ---
>>   drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 +++++-
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> index 058fbe2..25fc412 100644
>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> @@ -96,6 +96,7 @@ struct mlx5_vdpa_dev {
>>          struct mlx5_control_vq cvq;
>>          struct workqueue_struct *wq;
>>          unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
>> +       bool suspended;
>>   };
>>
>>   int mlx5_vdpa_alloc_pd(struct mlx5_vdpa_dev *dev, u32 *pdn, u16 uid);
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 3a6dbbc6..daac3ab 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -2411,7 +2411,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
>>          if (err)
>>                  goto err_mr;
>>
>> -       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
>> +       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || mvdev->suspended)
> One more thought,
>
> Does this mean set_map() is forbidden during suspending?
No, it will not. Instead it now allows set_map() to proceed even if 
mapping is shrinking while device is suspended. The "goto err_mr" below 
actually returns 0 when it leaves mlx5_vdpa_change_map().

-Siwei

>   I'm not sure
> this is correct or at least we need restrict in in the vDPA core.
>
> Thanks
>
>>                  goto err_mr;
>>
>>          restore_channels_info(ndev);
>> @@ -2579,6 +2579,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>>          clear_vqs_ready(ndev);
>>          mlx5_vdpa_destroy_mr(&ndev->mvdev);
>>          ndev->mvdev.status = 0;
>> +       ndev->mvdev.suspended = false;
>>          ndev->cur_num_vqs = 0;
>>          ndev->mvdev.cvq.received_desc = 0;
>>          ndev->mvdev.cvq.completed_desc = 0;
>> @@ -2815,6 +2816,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>>          struct mlx5_vdpa_virtqueue *mvq;
>>          int i;
>>
>> +       mlx5_vdpa_info(mvdev, "suspending device\n");
>> +
>>          down_write(&ndev->reslock);
>>          ndev->nb_registered = false;
>>          mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
>> @@ -2824,6 +2827,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>>                  suspend_vq(ndev, mvq);
>>          }
>>          mlx5_vdpa_cvq_suspend(mvdev);
>> +       mvdev->suspended = true;
>>          up_write(&ndev->reslock);
>>          return 0;
>>   }
>> --
>> 1.8.3.1
>>

