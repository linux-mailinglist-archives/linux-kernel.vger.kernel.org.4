Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9B36839D3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjAaW6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjAaW6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:58:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7DE4ED23
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:58:42 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIhvhd013725;
        Tue, 31 Jan 2023 22:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Z5Yml8pBO/4eNWfIeYBssFI6hrhIBjwid65P0cqXlZs=;
 b=PvMWTx/Z25iL6s3aeXGrYPO7f7VxjropB6v9XMc3rKG+eObn5WOPrFyDn6lp9FNvaw9u
 iuTO20tP22xEWaUbP+FPdIIFMW8oqtgtA2krUa1OE311FfOLPUnoWVAbWGLvpeZN8Gb+
 vT5r4a0xUCyhs8S+EvGv27XaLDjnBX8SzmJEvhRCXN1PH7IRhEUeuP0hOfyBdYV3h7Ez
 BtuLBRga43UemUjb8OA2HA1w8dIq/x91RMxvHv4W7oqeHvLLutk3p7H+XpZU1W0xqlpT
 YLMYzZKAmLrJMnuBZr5vp6xEIXU/VurSrjdh1dDIKejC9xL7BFnrvk0F3M1HmH9Nduxy nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvn9xy5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:58:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VLE83i003590;
        Tue, 31 Jan 2023 22:58:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5dr79g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:58:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnZXdg+o2WUE7Tyw01X4iezZVi7E9U39U02m/+q3akELKC7cz9+VcCdBpoR0Oi2730MeIlTZ05y71n3IIUA98RMms6QHQRJ5JduIE+duNC47v0XwXFGIprG4ooQ94VXtIlxMxiqEzxkNA+ZSVrrbT7JYZEAKEeO/YdBe1IzqMC6haYrnFEmdqOQ/iyR04REJub5fTsWuNNZlTD1UQP57A4QJfYj/H9OSvdFUm3oNDMLAANVfIVinUROljQscE/Ab6qywv4MxOmJeEE45ND2J7l83Um9tSg73dPzfa0kXJ0xHpSe90o018HYg4cOGBEDbFR9xMoxgkDiFRVV3GMkjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5Yml8pBO/4eNWfIeYBssFI6hrhIBjwid65P0cqXlZs=;
 b=kQ7/bvVFqZHHYmMaVt4zy5H93C1lRwikg7P4prX2ZkZucJxp3nQnomLkyJEIaWEiH3uxq8hfZIBf7R5OYy+65iN5V+6QBxakJTR5ki4IYqZZ+KMMw5YbA0qbLfKkLS2yjwd/VrA0AzOP+450dvlSpwpiuWZS0UgeHEbxfHjaPebvBToNp9E+tGUdwafr0zNa+bdIOFd9ZRt5hXDP/eQ9SSmRdU6tbLTUWQP+VddkIOIziaYjIwlGnZpPAXWAKiN4jIJPTdx2rTVDYb82nSeSZaYfN8UgNQW9SLi7eOkHkYUfgTFdCsXzl8QJikFouKEC3HtWDrHqHAFL6MfaN4Hqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5Yml8pBO/4eNWfIeYBssFI6hrhIBjwid65P0cqXlZs=;
 b=GfP3Voaus/N3rzGNG+vRLTrZP4nMgkjfv10JqRRTjoPFCOIQOenkxhojfxrDkTTVlnlhFn/IZ9ls0KlQRXiXCwAtV+gUOyBPvHHhltmj/lCKUfQ/E7iX3VIFk/aeKga93541tyzytwqDDPCMffjXfbmQ3BLLlkEHxt9CBgYvj18=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by IA1PR10MB6784.namprd10.prod.outlook.com (2603:10b6:208:428::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.20; Tue, 31 Jan
 2023 22:58:33 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%7]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 22:58:33 +0000
Message-ID: <b228665e-223e-11d5-cf05-ff24a656c0e3@oracle.com>
Date:   Tue, 31 Jan 2023 14:58:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/6] vdpa/mlx5: support device features provisioning
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
        parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675110643-28143-1-git-send-email-si-wei.liu@oracle.com>
 <1675110643-28143-7-git-send-email-si-wei.liu@oracle.com>
 <0b1f2898-e49d-9cb5-2913-382c9a04170f@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0b1f2898-e49d-9cb5-2913-382c9a04170f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:408:e8::12) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|IA1PR10MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: b88cdaed-783c-4ab9-ccd1-08db03deada4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7YboQWGm8U+tZzCbun9greToz5pNq3WOn/zDAVvFpkl+iARk+Q37k8o7R3cbbKvOrdpC06wQuFfIquCtRJ6V733ESP2ig64pHaGUiNagNOTFenYOdOOFBP4E493av4Xf4GhvebBCJJZwy5ycrpnFSZ1xYtJWHAZnQ0TjR2rriWT7+Rfk4P29HOOlRlLdEhryH1/Q0UZhQb5ICkZc71t0zugmish4QWZ+bCQP1aEcnuRr3EwAkJDxS+bTg8CszRVTsYueZ7JrRbkapIlH9cQZGbHfcqkB8s8YRF61Wf4u5CNyol7FLTjpwb3MyQsxkmeMCRbSsvOEair+N7AdbcumE+qfNwEBHH4emTT7ZtDUjkNlq+cf8qANQiW6nT6zCzRuF0JHLyDPUnob6LjAJN/1vxYeFdsYUrE9VW//8axXgxdF7VIk+CNSWGAs+yxpzCcasHyf8QLHxiSTq0kQAayBwaIsfFeH9l1PA/aWzL+6ulnuxHgbNYJy9+5OtR70a1Qo7Y2EzL7rHviFlGkCjaMxs74DeSMGLi4AaP30Z1RhzgpAFcxJjIRXV+Avy87BwMEnkOgQ8WnoXmzl80QzgLPGM82QutHsH779M7EzJZNweup8xEaaIGkV5q+eOd/1UicQGZ00pXL9WLQiAwURLtCjFGPdiRO7KGSNBkqGAN73npbJmik9mcHQFXa/icLcI9uYjYuBGRX8D9SdXjcaMgL6etnG8Y01hLKF6f9U7CfXvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199018)(31686004)(38100700002)(8936002)(5660300002)(41300700001)(2616005)(8676002)(66556008)(36916002)(66476007)(478600001)(4326008)(36756003)(316002)(2906002)(6486002)(26005)(186003)(86362001)(6512007)(6666004)(31696002)(53546011)(83380400001)(66946007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnJlanFrTkRaZ1BoS1RVNVFvZjFjVjU0U21aTWlsODFpWERMNUtLckRaUFpO?=
 =?utf-8?B?MjYwRGcvVnRiT3RuMmpUZzdoUklKOHlIbko2aEFKUWNzaUtFUXUwQmZ5WUsr?=
 =?utf-8?B?N3Y0b0ltazVxdlhxOWozNjQrK2hFc3dpVTB0b1Q1WHhrenkxNUtJRGFpMk11?=
 =?utf-8?B?K0lnQVhzOS9HT1ZocjFVWVdOK1RUWmNhM2VFWHBIek9BSWtpcFJVdGRyUmM0?=
 =?utf-8?B?Nm1ja3V0cCtOSEdVZmlqakkzSDhXOHdxTi9yYXc3Z1lmRnRTUU1LaFZTWFRm?=
 =?utf-8?B?VmNBSndqai9EZ1RwMW5SK3Q2aVVlNDRXYzFKenUyaDh5Yi8zRmRXQkJCRXlG?=
 =?utf-8?B?RlNLUURqVFhoK3hkOGx5dWZzVis4cTZ3SWZ2aHhGZ0ZQSGVZWlZiRm5tV1Z3?=
 =?utf-8?B?ZXBBd29zZHErcU9GcGV4RmI0TVJRLzJHN1BCM1lVMEwyRGxoRkRWRyt4RklM?=
 =?utf-8?B?bzBLY3U5WWhkYXNoM0tzVHcyaGlCa1dyQU4vTVo3YlpNUXV6ZkdtVXcxeUx0?=
 =?utf-8?B?ejBaUTR4TnVpR3RRMW1rajB2d2dvYm5nTDlFUEU0ajZGSE5sL2pOcmU3UHM4?=
 =?utf-8?B?NDA2VmRMVktUKzZ6dFZDbnJpQmwxYUs5RzU1UFF1Ly91YWxhZ3F4cTN0Njc1?=
 =?utf-8?B?RFhZS2MzU3FubmRYVDh4ZTFnMFFVRS9rdDFuZ21sVGpNOU5VWnFDNlFZa1h5?=
 =?utf-8?B?VTRGazhXUXFvMXpkcWZBSm5VVXR5bHpvbEJSQmtobm9jTUowOVZWS3B3REhY?=
 =?utf-8?B?NU5KYjJLYWE5OHpmbVBCc2RLYlVGRUxJWmZSYmZCT2ZhUnEzOWgwZjZMQm5S?=
 =?utf-8?B?TVdZTEJVcitmODlKT1NVOUNUcTN2MEZPSnUyZHRxeHRIS3NwNnc2ODhxeFBW?=
 =?utf-8?B?b3NZLzdRUkh6U1dFbHdoRUM2cFExbmIvQ3YwMHVFUXpxUmZseGhSZmdmdGVE?=
 =?utf-8?B?bFVzczdTbHJOaW9FN1dHdkkrbTdMOTFkSmsrblZjOHlEMFh6cnRPWnQwYU9P?=
 =?utf-8?B?R2VQUG83VWk2Z1hjMWtzU3ZLL2FtNDhjRzlrM0ExbSs1SEQ1RHdLUjRUWmV4?=
 =?utf-8?B?RWFNczRUU0NxZDNaUUtBbWVyWWV5MHFkcDRDSERQSnJCOGpROUM2SHBmNmFD?=
 =?utf-8?B?alQybFZpOFRQN3FiZ3loblYrM1B5YTNPdE1sTmFZQWxEUGdOSGEzaWZwZ2dE?=
 =?utf-8?B?dGhXc1duRjRWajdYUHNzVTd6Y0s0TFRJY3FWM3NONS9KZGEyZzUvVnN1QW5I?=
 =?utf-8?B?SHZ4M1EvTUJibHpDS1BTTjZXUkFUczRNTnlXTXljWU5HNzJUZDNPd09VdURD?=
 =?utf-8?B?MzRaQXFBQ043RVJpKzNqVHRENHFRQmNCV3BvTEk4Q0JQbUQ5SEpOMWtWR25w?=
 =?utf-8?B?YlJwVWtlVytpeUttTW9BNmV3NW1VanFYc0lCNXpjVGhIVndXYU82TFI0NnBQ?=
 =?utf-8?B?VWlYSzRaQmZhMTB2ZjNTL0ZERlZ2UGRMaERvc3VORExHREZMR09iNHh1eW90?=
 =?utf-8?B?ZEVnUGRDa1dlOEMwU1JYelNzUjZHakJ6aEp4cmtXL0tZdVZCNnZNb2hYcWZk?=
 =?utf-8?B?UFQxNi9iS0JLSDQrcm1nVytOMkpYVFk5QjZ6NGIvQndMS0lGR1hWTUtCZ3VP?=
 =?utf-8?B?R0krWHhXaEx4czhUL1BXQnhlTDJXSnA5emhMZkFNalNYeTg2MGtiSVpTcDF3?=
 =?utf-8?B?aE92RzgvUFpOeVh2VzROemhTdFpPQVRNNHpmeFMyOUdnd2VVOE05RjRHYXZa?=
 =?utf-8?B?UFNtV2NkS0J5cm5ia2RJdUREdEU3aDh6ZTU5eTVHWmRVK3k5OTB3dkVRQmhj?=
 =?utf-8?B?Q1J3UExWMHNRdG1landXT2MyMmloOVZpem9qZlM2aERQQ29yTkEra0U3YWcy?=
 =?utf-8?B?QXBDR0ZFbGx1enFYZWpBVHY4c1NocVNlbTBTQkZvSGw2QWdHekpFS2JKS0tV?=
 =?utf-8?B?a24veHlDbUEzU21za3Y3czZQWVVMaDdncUtRdXVpSzlLdnRjbHFJTU03VWZl?=
 =?utf-8?B?N2hWM0RhL3VDWC96YkdUWXArQjFIYnpTQ1gyQkh4M25MeGU4MTFWVlRzTEJs?=
 =?utf-8?B?TTNNM1c5WnJOclJYV0xwbXZ0N2hDZWJLak93ZmlqaENUUGFoMEZPSzl5SHNo?=
 =?utf-8?Q?wASGnzwvNhDt2zwxGEpg0gTWq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F960bDIIxxUv5M1z9bqSHwxLYU9CCIgacpA50pACsXp4J/f9nsKbf/LFIpPp9ur+EJ2EqnFWpb1QitmjkMfcn0ZX0bWi3XDYvuNVMeiVrD3l0YOi7PSrL8Sc6jLQLWhLQu1c5+bgXfFpa+LIgyoJE9JG1wFGGRHymJIkdlQROCLs+SVcwwFmwJENfP2bUbBgHJ8cNUfFlBXY0EEvmGPwOrN5zTRtW7F0GTPmGZoZ1PiEMji89wYMSLvwRMJEtm89Oo6FW2eu6Va2r0D3J5368FVKa8dshBqlJOaEHQenOtqGsGHHaKrsEZDp2ix5hdBwzerEdb/MaWCCvbThpVUnCzxafQWoNCxrRqFAnSe3jTa/iXtQQlaUfivPIpqr6yiLJej7pDng7p3s8b6eFJpHlbn/rsCk3+gS1iR5Nw+Cl87i+w3UfhHkLYUTvaqI94TDQz4gd0YJJqeT2eM5wf3E+Cqmfj4zbWPsbOrnED5T7pU629sxr1IH75Vn2Zc84BAMznTBsGYd7DTiXwPNIpV0hgbtDWo8zkGn9QqWSlVCNiO1uERcZmI51p4bkqZRRUA8AoZ8i6/hYtjXcuLEi909VLYHJeo3h2KdfSyTT9xY4bgxi5iJtromKoK81TahjbtuJ0/qUjzMXEtrlBPylJYoY0gy8BI4P2in9CR3kggHq88VZDn4VrCAJCewtyskE9C4cROJAmxqrV2zSxaqfU2QbyLh1lvAX6XnMBQ5JLB/NEg8TOM81PzJYlxTS2SsYkky/eluT5p9PEJGowjmEwTPVi+hjqGgU6kE6EWK99KSO0hbY5D0E4/lQUTgn+SJgOcT038uvHKvaokiN8CV3kb9CwRXLASHKkXjCJHc76pzQSE7CK17ybVd0jQeHvMhXFfQIt26IB/KISEpHOizk4tQbA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88cdaed-783c-4ab9-ccd1-08db03deada4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:58:33.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybve0LoNyxZpF0WqOQ8YgPKhpauOg8MrhKpwOQdIFg9AErfsSYayqVczCc1NZicRAXYvNrfMk04TOrIrkjzb2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310198
X-Proofpoint-GUID: 9Di5sQ36XF9x51L9nloO7Afhsl4_FTYf
X-Proofpoint-ORIG-GUID: 9Di5sQ36XF9x51L9nloO7Afhsl4_FTYf
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/2023 4:56 AM, Eli Cohen wrote:
>
> On 30/01/2023 22:30, Si-Wei Liu wrote:
>> This patch implements features provisioning for mlx5_vdpa.
>>
>> 1) Validate the provisioned features are a subset of the parent
>>     features.
>> 2) Clearing features that are not wanted by userspace.
>> 3) Set config space field only when the corresponding feature is
>>     provisioned.
>>
>> For example:
>>
>>     # vdpa mgmtdev show
>>     pci/0000:41:04.2:
>>       supported_classes net
>>       max_supported_vqs 65
>>       dev_features CSUM GUEST_CSUM MTU MAC HOST_TSO4 HOST_TSO6 STATUS 
>> CTRL_VQ CTRL_VLAN MQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>>
>> 1) Provision vDPA device with all features derived from the parent
>>
>>     # vdpa dev add name vdpa1 mgmtdev pci/0000:41:04.2
>>     # vdpa dev config show
>>     vdpa1: mac e4:11:c6:d3:45:f0 link up link_announce false 
>> max_vq_pairs 1 mtu 1500
>>       negotiated_features CSUM GUEST_CSUM MTU HOST_TSO4 HOST_TSO6 
>> STATUS CTRL_VQ CTRL_VLAN MQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>>
>> 2) Provision vDPA device with a subset of parent features
>>
>>     # vdpa dev add name vdpa1 mgmtdev pci/0000:41:04.2 
>> device_features 0x300020000
>>     # vdpa dev config show
>>     vdpa1:
>>       negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 72 
>> +++++++++++++++++++++++++++++++--------
>>   1 file changed, 58 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c 
>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 3a6dbbc6..5d6dfd2 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -2183,6 +2183,7 @@ static u64 get_supported_features(struct 
>> mlx5_core_dev *mdev)
>>       mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
>>       mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MTU);
>>       mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VLAN);
>> +    mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MAC);
>>         return mlx_vdpa_features;
>>   }
>> @@ -3009,6 +3010,8 @@ static int event_handler(struct notifier_block 
>> *nb, unsigned long event, void *p
>>       struct mlx5_vdpa_wq_ent *wqent;
>>         if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
>> +        if (!(ndev->mvdev.actual_features & 
>> BIT_ULL(VIRTIO_NET_F_STATUS)))
>> +            return NOTIFY_DONE;
> Does not belong in this patch
Yep, I can split the patch. Though feature provisioning on mlx5_vdpa has 
to depend on that patch.

>>           switch (eqe->sub_type) {
>>           case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
>>           case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
>> @@ -3060,6 +3063,7 @@ static int mlx5_vdpa_dev_add(struct 
>> vdpa_mgmt_dev *v_mdev, const char *name,
>>       struct mlx5_vdpa_dev *mvdev;
>>       struct mlx5_vdpa_net *ndev;
>>       struct mlx5_core_dev *mdev;
>> +    u64 device_features;
>>       u32 max_vqs;
>>       u16 mtu;
>>       int err;
>> @@ -3068,6 +3072,25 @@ static int mlx5_vdpa_dev_add(struct 
>> vdpa_mgmt_dev *v_mdev, const char *name,
>>           return -ENOSPC;
>>         mdev = mgtdev->madev->mdev;
>> +    device_features = mgtdev->mgtdev.supported_features;
>> +    if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>> +        if (add_config->device_features & ~device_features) {
>> +            dev_warn(mdev->device,
>> +                 "The provisioned features 0x%llx are not supported 
>> by this device with features 0x%llx\n",
>> +                 add_config->device_features, device_features);
>> +            return -EINVAL;
>> +        }
>> +        device_features &= add_config->device_features;
>> +    }
>> +    if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
> This looks redundant.
This will be handy to rewrite the conditional when legacy device (non 
VERSION_1) is going to be provisioned which may support in future.. But 
I can remove the check for now.

>> +        !(device_features & BIT_ULL(VIRTIO_F_VERSION_1) &&
>> +          device_features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM))) {
>> +        dev_warn(mdev->device,
>> +             "Must provision minimum features 0x%llx for this device",
>> +             BIT_ULL(VIRTIO_F_VERSION_1) | 
>> BIT_ULL(VIRTIO_F_ACCESS_PLATFORM));
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>>       if (!(MLX5_CAP_DEV_VDPA_EMULATION(mdev, virtio_queue_type) &
>>           MLX5_VIRTIO_EMULATION_CAP_VIRTIO_QUEUE_TYPE_SPLIT)) {
>>           dev_warn(mdev->device, "missing support for split 
>> virtqueues\n");
>> @@ -3096,7 +3119,6 @@ static int mlx5_vdpa_dev_add(struct 
>> vdpa_mgmt_dev *v_mdev, const char *name,
>>       if (IS_ERR(ndev))
>>           return PTR_ERR(ndev);
>>   -    ndev->mvdev.mlx_features = mgtdev->mgtdev.supported_features;
>>       ndev->mvdev.max_vqs = max_vqs;
>>       mvdev = &ndev->mvdev;
>>       mvdev->mdev = mdev;
>> @@ -3118,20 +3140,26 @@ static int mlx5_vdpa_dev_add(struct 
>> vdpa_mgmt_dev *v_mdev, const char *name,
>>               goto err_alloc;
>>       }
>>   -    err = query_mtu(mdev, &mtu);
>> -    if (err)
>> -        goto err_alloc;
>> +    if (device_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
>> +        err = query_mtu(mdev, &mtu);
>> +        if (err)
>> +            goto err_alloc;
>>   -    ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
>> +        ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
>> +    }
>>   -    if (get_link_state(mvdev))
>> -        ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, 
>> VIRTIO_NET_S_LINK_UP);
>> -    else
>> -        ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, 
>> ~VIRTIO_NET_S_LINK_UP);
>> +    if (device_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
>> +        if (get_link_state(mvdev))
>> +            ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, 
>> VIRTIO_NET_S_LINK_UP);
>> +        else
>> +            ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, 
>> ~VIRTIO_NET_S_LINK_UP);
>> +    }
> Doesn't belong in this patch
Will split patch.

-Siwei
>>         if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>>           memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
>> -    } else {
>> +    /* No bother setting mac address in config if not going to 
>> provision _F_MAC */
>> +    } else if ((add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) 
>> == 0 ||
>> +           device_features & BIT_ULL(VIRTIO_NET_F_MAC)) {
>>           err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, 
>> config->mac);
>>           if (err)
>>               goto err_alloc;
>> @@ -3142,11 +3170,26 @@ static int mlx5_vdpa_dev_add(struct 
>> vdpa_mgmt_dev *v_mdev, const char *name,
>>           err = mlx5_mpfs_add_mac(pfmdev, config->mac);
>>           if (err)
>>               goto err_alloc;
>> -
>> -        ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
>> +    } else if ((add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) 
>> == 0) {
>> +        /*
>> +         * We used to clear _F_MAC feature bit if seeing
>> +         * zero mac address when device features are not
>> +         * specifically provisioned. Keep the behaviour
>> +         * so old scripts do not break.
>> +         */
>> +        device_features &= ~BIT_ULL(VIRTIO_NET_F_MAC);
>> +    } else if (device_features & BIT_ULL(VIRTIO_NET_F_MAC)) {
>> +        /* Don't provision zero mac address for _F_MAC */
>> +        mlx5_vdpa_warn(&ndev->mvdev,
>> +                   "No mac address provisioned?\n");
>> +        err = -EINVAL;
>> +        goto err_alloc;
>>       }
>>   -    config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs 
>> / 2);
>> +    if (device_features & BIT_ULL(VIRTIO_NET_F_MQ))
>> +        config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, 
>> max_vqs / 2);
>> +
>> +    ndev->mvdev.mlx_features = device_features;
>>       mvdev->vdev.dma_dev = &mdev->pdev->dev;
>>       err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
>>       if (err)
>> @@ -3243,7 +3286,8 @@ static int mlx5v_probe(struct auxiliary_device 
>> *adev,
>>       mgtdev->mgtdev.id_table = id_table;
>>       mgtdev->mgtdev.config_attr_mask = 
>> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
>>                         BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP) |
>> -                      BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU);
>> +                      BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU) |
>> +                      BIT_ULL(VDPA_ATTR_DEV_FEATURES);
>>       mgtdev->mgtdev.max_supported_vqs =
>>           MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues) + 1;
>>       mgtdev->mgtdev.supported_features = get_supported_features(mdev);

