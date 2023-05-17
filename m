Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBACE7069AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjEQNWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjEQNWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:22:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551721FC4;
        Wed, 17 May 2023 06:22:08 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H6iuZ9016168;
        Wed, 17 May 2023 13:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=f1/cNQXGV8puQj8x2qMuzeJz5OUMW+0+gmzkQrZSxjM=;
 b=dk9tcFmFMzAMMCnIjpzF0Ct4eCOjW8mP9dyF47iIt2QLKTkJ4x5QFfjDBsEY3a1PQG2v
 ZRCOvdNksFmh94EfmGvUAmNLb33P7I15+KKvfdDthb5fifROPE1gQlrgLqaYWlrQbWzs
 KBA5iwyMuZDgsikwbpkRDTYX8SAKJDd9Qaj8m8Q1DbTvHnie1VuHXNzjxFPpZ5vjYmb0
 PVOcLsm5WhJh31kgp2raO0kclLiwNSp74/CA+GcBm6TGbL4cC4vHFQiNz3rYUIA2c6ld
 SvKezhPKg7j+mfmOzh4EZdRpZiBAcBHBIoFBBan9rV9JNgAH+qK5ceg9Xg6EzdsQmegu YQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33uwet0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 13:22:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HC01qB032227;
        Wed, 17 May 2023 13:22:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10beqds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 13:22:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWVphNNIZDGtxedIGXUacmCb0sX0BgdRyQ55VCcTN7etXS2QJBYVorjXeJOuNNji1kf5u27w++kP/bE+UXgLY2m/COMpDuBN65sOd48356PjQuHEpwrPAvi6H5i6T2EdYuCgwKg5NwZ4TzP8Z+F38qKrdbYnfPEsYSm64J6oNaA8PNTZ76+YsG0/8HcehlVqxTY0chSTafUCM7xM7A3y35ieuekdXppnxUxONOs+yoEp1UtcCqKG3cTQVX7L1kGPZ/HH3F320WncT3Up5UZTpc3FKUcSMhUF2pejGUgFmipw5Y/aM9oHAymLWG1o8pJOfJtv0wCXeKpjzDOV2UUhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1/cNQXGV8puQj8x2qMuzeJz5OUMW+0+gmzkQrZSxjM=;
 b=l2TgY8yJ8j8P0mMBoNu7hKBzLNNlWAhdKSzL0uZ02/kJ4sXRYhpncca+FWN3hASnDYC+hx86dWyGlu3hu3lNt6mWuJOdlb+11adD4g5tzblWLE80jUWXw8BNXAvA9sDv2ijf3RBQ9DMV2dF2/JxQ76ZjsT4Uz/470f7952awYHxonQRLhZ0AjALp9sOTgc0qv0lL8Iqnrij3QrItraN0c/9G/NYkFcHtS63O7OghUUasKp+LtPpYpg42/xUl1aRWrO6ohviAs/aot8xut6DGc58WEE3D/e3mGfvtQF8D+B7XXndnippy7rjeoRgrBcldQbvsyROmV9arDQ7lsrQkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1/cNQXGV8puQj8x2qMuzeJz5OUMW+0+gmzkQrZSxjM=;
 b=ljChPSGx+lBq7NBUr37O6pL0dFYz8py5wnkctguMsIpuGg3wEKKbuFMK1RFp7JeiS5fWAD2lgh/rghPz1pmPhuPvIzOgKt3eQmeOteyJODc7H/yso4mKI58jcGR3IjMJBcDDW5seTpX6/+e59UEgHcyorFblWp09mX6Im3sH+HM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4640.namprd10.prod.outlook.com (2603:10b6:a03:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 13:22:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 13:22:00 +0000
Message-ID: <bf541b4a-8ec1-f291-b579-c0d1e0f64a83@oracle.com>
Date:   Wed, 17 May 2023 14:21:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] scsi: pm80xx: Set phy_attached to zero when device is
 gone
To:     Pranav Prasad <pranavpp@google.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Pylypiv <ipylypiv@google.com>
References: <20230516175737.1831575-1-pranavpp@google.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230516175737.1831575-1-pranavpp@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0031.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::44) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4640:EE_
X-MS-Office365-Filtering-Correlation-Id: de7a04a4-0e67-4937-90ae-08db56d9b282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xapL1TiSmCMqZ6FVLCpzI5Yo2HWfmzeFN8X/71JfFE6a2EfX86yxC0fvyG0tUyiyOD6IXlYpSBPo+ozGututP7RXBz4aRbFFSb+nFwyYdGQtaRSYw8pTjVEpus4YKCjDwxvnbJOXo7NFUCQBA3KGcNfOD6V5uYkG8JSf86BVZtO362ALWo3Tb2+ahYhTwPNPGMmSo4lp0g6JTqzI442z9e5Unf4/tiUUG+KCvxhVD37THMgdgIRaH4+0TSfPAtt4ADShvq7PX3CR6Hg066fOjFBSw4FSlOxVPPgnZ0i5ZKwjkXPmkO09D2a6AMEvju2W6ZXNgffDfI4IlDgvVrNnSlWSm87G5f5r3PphU0lQ24GmYBUokKU5lEfZORe7fgPn+s8T2evHZme5xivZTTjR7/QObWdHcE9BbhposemDHb9ItQj4c3oMrS5SyzCBmAhxhgG8pZUu6oPq6otY6Wbd5RGbSFO/9AKcI4PHJ2hRHT0lUmRKcksAhPYMIsp6kWh7K7fn8IXJViJg3URoldMAxtpFltMXZ1V1NuoykiJwoKYVCPGLIRWJ/T3IgmovEJsc96hVpdq8JX0hpkRMNuEMJHhKyKe6SinJY9bdCVeilbUUJ5APfEjP+SfIHOMORevoS8BQMssH6rCt8I7k4rPkFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199021)(31686004)(2906002)(8936002)(5660300002)(8676002)(41300700001)(6636002)(66946007)(66556008)(4326008)(66476007)(110136005)(478600001)(6666004)(6486002)(36916002)(83380400001)(36756003)(2616005)(316002)(26005)(6506007)(6512007)(53546011)(186003)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXROUlVPN0FRMWU1SEFTdHRhVmx1NS9OUnRjVzBsT1J4OGdpQmg3SWpMN3lM?=
 =?utf-8?B?OTlQY2dwVi9kTFZJZjFPbWxJTXk2OC9YVmREK1djNnM2YjMrWDVaVndaS1dD?=
 =?utf-8?B?REY1U0U4emZYMzBxWXU3UnMwK1VENGNJYUtudUJWc3RSVmFHbGhrakdRVE5F?=
 =?utf-8?B?SkxRdERwS3BjbHZXZjBNZ0VJT3JPcEhZNzhuVUFkd1Q0VENWbFFmOUpaYndw?=
 =?utf-8?B?djFJdngwRlljcTg0OThZVXowdSt2VXZSQjJBUnZmQzdtS0M3WFRFTWFka1N2?=
 =?utf-8?B?cFd3WEJDemI2bVdUNUhETUFtWDFQTVd3a0xoMUppY3k2R3Jtemc3bExWUlNX?=
 =?utf-8?B?MDJ2MnNDMVFyZ0J1a0NmUG1hNEpSUEtSNU5OYyt4eElVUDZOK3FIdFFPYm1H?=
 =?utf-8?B?OVBZN242M1F5RktxM2tQaGlHSmtNQ1k2WFU1VlJQRDV4RDZrbG43VU0ycFor?=
 =?utf-8?B?aU9jR29SeXhOMWNxaVdCN2FyalEzcGljb0xNcXlJSEx2QzQrOXBJZ3NWMEdM?=
 =?utf-8?B?Q2xvZG5MUDRFYlZmWEQyVWFzMlNxQ3BlQzRtTW92QStHY2o2blcwSXB3NUJp?=
 =?utf-8?B?MjE3Z1RJaFNhUzhUZjlFcVFtd3p0Mng0czVMT1lIZi9YeUtXZzg5Y3pVNWlR?=
 =?utf-8?B?NStPTGdrcGpab20rbGJJUzZsUFFMd1lBdk9CbHhNU3JaTEdCaUVjek1qeTFZ?=
 =?utf-8?B?bGp6MllLNEh3dC9IcVlva1FTaFh3aTlkZENibjlnRzR3ellCT1VWZVhOS3BO?=
 =?utf-8?B?aUpiMk0xeHdyV0g5U3hsQUQ5YmtuMHNsUVRVK2dhdS9uQzdsb2ZBRnRMRmpl?=
 =?utf-8?B?MW5aUTRUWFd1Y2k2Q1RXcWZYakVpbEs2VkNNV1UyRWo0dmUrS25VQW1mV3Fh?=
 =?utf-8?B?eDdQeHRwMGNTR3AzQ2xWVlA5UElPVEVRVmJodTZobktncXNSak1Fb0ExUVJQ?=
 =?utf-8?B?ZkpsZmZHVU1pdStDNWswVE1BUlhwbFBWM1MzTlB4d0RzUHg4RG14NmdEa3hR?=
 =?utf-8?B?TE9UNkU4dUl2RFFBQXJRZGxlaFo1VU04WS9wWXgvSHZrQ0FxK1h5aWEwM3Rl?=
 =?utf-8?B?QVFwRU1oTFhrV09OYUxJeXY1UlVudXIwQXhNczhJV2FpeWh1MzRCYnIvRFYw?=
 =?utf-8?B?RTJjVk15cjdDMkRMOEVMVW9qYjNXakFWTi9LMDl0ci9uZUhVRzV3Lyt2VHdU?=
 =?utf-8?B?UXZidFRjVDJhbnpPT3Eya1RNMXVuaEFqVVZFSDNSbmZDNDJkVjZGZjgwTWVM?=
 =?utf-8?B?dnlZcjBWV3BNdkNHRyt0Qm9XY05CV3ZTVndKbG15T1R6RklneVJVQUdwNUE0?=
 =?utf-8?B?cFd0Qjd2clYxWjlzODJ5S2xQZ091SUczS0tXbkhzN2VLSmljdzlGYkc2d0NN?=
 =?utf-8?B?MkVaRlA0RXZENzEzcm1TUGtGQm9lYnVhQW9iakswMFdVR1JTU01Qc2IvTjZ6?=
 =?utf-8?B?UUFLNzhyZThqYVpQMzJ0UklnWEVHS3AreWJTR29DbEVQVFpla1hSV3c5NGRr?=
 =?utf-8?B?TzNKd1ZNQkRtYUFlR1orZElXTktUME4zU2VnMCtCajh2VTlmSVpOODNXd0xt?=
 =?utf-8?B?NEtNb0ZDQ1RORkIrTjR0SExGcTZKODFqK0Y0Mkh3TGUxaEkvZUJsQW5wTkVD?=
 =?utf-8?B?WFpOeGpjMitFRmF5SHY3ZTVCbko5WWlFaFd5T2dTR2YyZ1BMU3hFajRpM3dl?=
 =?utf-8?B?UHJ3SS9jSWVuMmowNWdhb1ZQMHZrMXc0V2RKR2liVHM4MkkzVFpoSEQxYTlr?=
 =?utf-8?B?c29mazU4ajVxc211d29ZR1RoUzNsa2tXcUNqWEpuME5TNDZTaHpxc1ljS3RD?=
 =?utf-8?B?dzlxQ3dSZ2xMRnp1Z3htczJpZ052RWkzSEN0SUV5WnErVG9JOWtkZ2poVE83?=
 =?utf-8?B?MWdyajZUN0MvcnR1VjU2ZXFUNGdURW9SWnZkZXVqQlh1c3RpNVhyaDhObU9a?=
 =?utf-8?B?bFk0Q2V5YVNLbUxwMUt3VXFXdW1kLy9lV1MzTjVnYzZsYlhXUlZNdVhSZHVo?=
 =?utf-8?B?L0J6QXlKcjg5OGJOT0FsckdJdkhWTFZ3K2JMbHhGcXk1U3kvQ1ZsdlFUbFNx?=
 =?utf-8?B?ZTBldUV4MmxUd2xQV3BkWU8xUDBjbmV0ZU1nQzQwL0RET0x6N2U3THoreExm?=
 =?utf-8?Q?yg3K9SNTSk0BC0T3NodfWFlCh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9M3zsG2d0OSIWTczFnhba8rFesS+KobTbDOre4ID8HCUaoBiySWFNuFbe4p8ZPU7WrVY+2q0FaFuXI8wXQf3NGaKixJ11YRsDVy8iuQqELPkqT3ggjPzQcIGLVKmgHwkLxEAQUy3WWiiq/g1931FU2AdzpqRzFNp6RHfVi7I+IiaWhP58YANQOtAwF4yjjZba7TpnG6te7Quks9kjaJCTa4/Cgf5fp5pcBYOFhbPh+GAddJQJdcHJctI2fP46dnNAEOsnG9CxuPuPF/hgWU1sr2r4MF7xBnoramNwRJMY9rnT6qIT/i/lp6395YfuDOR32zmXqleauSGS8V2esV+IHyiEHruNjUDHfexvb/gHU/yd7AAE5CTfPKSlQ7FuJ0M8hK0RCL+a+Z2EVs9vvpUf2oNUFfQrprCkQBj/O9/8G0nmKYhbpimBgX+JLmjZOjSI3VPeqIhxe2pefnL59nZl0q5I21Ff3tAw0gipjgB02vzuaT3SsitH6nG8ruZC5rKXBXUQW+i07ggUuMxVcrY32Y95C2KLlUjU7w5dY6f1lca/3NmrpRa1P0wHFbSbM87FwJYvYlZ71FMqN2MJWPpiNyP804e765mI10euSeS/hInp8zG09YqYjVg0enKC3DHd5bf87QSVu5b4S5U4IG36h6wvNL+7WSU3xjYGsuUhhGbAX+s8YlfVaYg9WbZwSgrZbekwhZSKhhoHFciUsRzbyIL2uFoqvU4IfFGvZl/jHMvEk8Bn5jnkEpukawbTnnPpbhl4rxV/I/2Gzm3dZ1Gmo8jZSItzvVxHDUE4dOiZnAswapVuFJsj6qQfA8gtAZXT7XKQFjz/FAe/1PGhR+PpYHD2KgPDsNwxAIZBXAqLplqoql8Y05m8qkXLzHqoQJN
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7a04a4-0e67-4937-90ae-08db56d9b282
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 13:22:00.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95fksyMmm73Tz/DMP0pdYuV76Pgy1tVFCEHXvWsUXC+A6zUqxbcgkApYBFU0dfoGEvBLiU/khiDKd+F/viMBLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170109
X-Proofpoint-GUID: DUe-aVe1ZdwiULiZxabzHXpgHudnLmU9
X-Proofpoint-ORIG-GUID: DUe-aVe1ZdwiULiZxabzHXpgHudnLmU9
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 18:57, Pranav Prasad wrote:
> From: Igor Pylypiv <ipylypiv@google.com>
> 
> Set phy_attached to zero when device is gone.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> Signed-off-by: Pranav Prasad <pranavpp@google.com>
> ---
>   drivers/scsi/pm8001/pm8001_sas.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index e5673c774f66..c57fc671509d 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -706,6 +706,7 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
>   			spin_lock_irqsave(&pm8001_ha->lock, flags);
>   		}
>   		PM8001_CHIP_DISP->dereg_dev_req(pm8001_ha, device_id);
> +		pm8001_ha->phy[pm8001_dev->attached_phy].phy_attached = 0;

Can you factor stuff like this out, so that maintaining these values is 
easier and less error prone?

Check this:
~/linux/drivers/scsi/pm8001> git grep "phy_attached = 0" | wc -l
21


>   		pm8001_free_dev(pm8001_dev);
>   	} else {
>   		pm8001_dbg(pm8001_ha, DISC, "Found dev has gone.\n");

