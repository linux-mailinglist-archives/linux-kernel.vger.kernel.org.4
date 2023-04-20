Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CCB6E861F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjDTAAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjDTAAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:00:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D574EF6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:00:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JL4CVD008061;
        Thu, 20 Apr 2023 00:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1AxPXYCaH3oKDEXeXLP3v8Qzfeq7UWLwFmNtrbvpiao=;
 b=MqYCXK86G1T0dtuMyjdrl4Wzl4VVPMmJWcr3ePg/Qk4v8ZzA5519E767jzV8IubK7usW
 2404gPZEKdjdGOATToS+XzJ/dIbRUe+E2JKVEWSLVU6ZSinifXOZXLoFeXSDiPjT8yO5
 B9LxtgyT9R5wntPcclyS91RUIo5yzYfxth4mlXrCz7sgqfpwvJE/ZbgCpC+N0IMKMzCN
 e2sshrRnwBRQfQQSsKdvHBNpGhJKfV1hOCTOE6Z34ZC0utlLQgrVOfywN5ij/YhLySwT
 r/HKHXcy1iI0nLTc0XYKPZjkXJklmm5Ww7LA84fYbB9uG0WkokjFEpd3izOo/wPfW9nI cA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjq49nqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 00:00:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33JLPCS8015815;
        Thu, 20 Apr 2023 00:00:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcdm0gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 00:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZO9cXmBJquYNQXgpRPCIs75LtO2PMqWSpHRoZ689jM6eHH3rY70ayPI0nZ8KqRH+NoFVQNUvio1+m3RYyEye0p7rEF7Z2sHO9RoAE2UCey6w2zFazzEiKfiy6aY1C1hiN7NQ+Q1uA25T83OJ7X+gtphHjudAM9KhNIhpIoJ6aZxxn+WYjGjZ/gnOnnXohWMu2rolo2SCti+/61lg2Bq47+bRVZRXdXJIIytwsYce5af3HRUsWe4YEF53rWmNMs+aFyT6LmLifRGXKz9nYB0saO19enf3Qwxe+LAGywoJJ0z5X4YMH5iEJw3/Ncs0Sx1pmVBtD2OPFGAod7UUHKpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AxPXYCaH3oKDEXeXLP3v8Qzfeq7UWLwFmNtrbvpiao=;
 b=SsC1zOhRiO1DDpsOnEtylE3KakygxbJYu8KaWUsze1ozHZuMF0/NLxeeCRnf+xhEb3mOZXeUo5e3/5BXPJKDZbErrNSURm74Wlid2U7LOCUtxiEqMNTy0bxXBGUK2ChQBFz40enp8F04HXr1HpJ1syGmOlo1JZwJe0lyTuQC3xjYowsRjTJuOIApK8bGm7M/QJCLHW1VKfV4+MmkRl/rIibzJWknHJA0HU7Ln2XLujhVBVdSCemIOjBszvSBxeDlXAHgR8ujPRKWCIGOvFDckYqDiZ3ZeYbEwc6kWzb7Ef4Z7MU0k7cA+/vKmv8RXSyRxJEb2BKgPaEHbKetgdeeEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AxPXYCaH3oKDEXeXLP3v8Qzfeq7UWLwFmNtrbvpiao=;
 b=Qw5Esq7M53mqkti6kyYJ//rUNKC+ju9ZDIuLcAo0grsMqK0QKNDQUbO2CzxE+/joC1qceINRVX2L2xk5X9E7a9RFVBRb4jPG9JfaQnpm33QobSc0EecS9VDp4XfVHn7eY5yFYhwPaFNXEqdgPPrNIH0Ma4aINNk5AInp3bAdbNs=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH7PR10MB6106.namprd10.prod.outlook.com (2603:10b6:510:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 00:00:31 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9%5]) with mapi id 15.20.6298.045; Thu, 20 Apr 2023
 00:00:31 +0000
Message-ID: <c1f0a1cf-ff4e-b7e3-958d-be08ffa22319@oracle.com>
Date:   Wed, 19 Apr 2023 17:00:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mm/mmap: Map MAP_STACK to VM_STACK
Content-Language: en-US
From:   Jane Chu <jane.chu@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Barry Marson <bmarson@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20230418210230.3495922-1-longman@redhat.com>
 <20230418141852.75e551e57e97f4b522957c5c@linux-foundation.org>
 <42eaa653-b63c-8c3b-4483-25765ea7a579@oracle.com>
In-Reply-To: <42eaa653-b63c-8c3b-4483-25765ea7a579@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:5:100::17) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|PH7PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb59622-331c-468d-e632-08db413241de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZwkFia+BUnzSQhqXGwMXXINrScgk/+6RG6xKn+GAPjNdmu+tLMYFVmtfM4XFUcsu4sdRK1Y4wVVuCL+w7Xp1oK4VxiHXrXWgIJoFJlrVmkkYVLgEos7zC7U9Y8aJAvrm0nSaD6vuECuayfMh72ihRe7ExLuKosELzqW56JGiyczh6SruoJCHCYypFm6g1OFIrwPl24qZUw7LrX0cD0N+n1P+FQiQeuoIzdDIAori6xtFurMiOURLOppfrs2gsPwVQ8/NgpczRzJFGf/OGbtQOKqnoSPKoAi6YYXuuvK1dWPTDHCYEJiv5UKCHQ2UsIlvXjBDC8zuNInaEtHU7Wxm2O8w0VUe4x2E0pSo9j5zzPiar9syYyLpHs/QhMLQScilHxPRZq6qWAGGCPpY8rQ/5EbEpyIRgV+qAAIbIXT2+/BRvtezDmsbQeUUS1867swM/nkp5PYpZTU8Uu92lBhmznBi6CpL0mivavGsSgltg+s5DlTaXSaSP0NWy6Aae7xaj1WidwA53I400xZ7g+/oqu+4xRN7O9V66bi4bE2hfPhRxuksDO+hDvH09RDMUbsiJnhCdGebcJlip5Ffk7rwZuYtrhMHoTcWffoMgOlQVk77WHVUMdhKzuCnkVr1TLKgjYE/GlQ7Gx14b+Z1mVZagw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(6506007)(86362001)(6512007)(26005)(83380400001)(36756003)(31696002)(186003)(2906002)(53546011)(44832011)(31686004)(5660300002)(6486002)(2616005)(6666004)(8676002)(8936002)(66476007)(478600001)(110136005)(54906003)(38100700002)(41300700001)(316002)(66556008)(66946007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWZpc0loRVlwbWtoYnBPYkp0RjA2cFpYYjZ5Vys3ckl1RG4yeWFWU24yTWdZ?=
 =?utf-8?B?d0MrQzdSV2cwMVhrVitKckszc2VLRE80MDluS0c1WHhGdHNqdDdKZGc2dVZN?=
 =?utf-8?B?N2UrSy9NZWI4OG5tYzhKcTdsMTE0dXpQRlB3aXJycEk3S3JLbWM0aWl1YWw0?=
 =?utf-8?B?eUlRRWthNWJPU2YrM3ZNL3VpaXRXMkNCa0dNWCtJckFJM1Z4VzFxN0FBWTdO?=
 =?utf-8?B?Sm81UEZoMjRYTVA3YTkyTDZDZWhzK29VRGFzeDdQc0JweDNsU080RnkySi9N?=
 =?utf-8?B?bjdCR0tidURwc2lwUzNzYi9rKzZHZ2t6Vy92Tml4cllBM1ozWkFxZ3pvcUVN?=
 =?utf-8?B?REFvV3B0U3ZpQVo2Nko2NlV4N3VEUUpxSXQxbUVjUHJ3UmdHOE52em1TV213?=
 =?utf-8?B?ZTNpSGdZNE1Ed3NZOTVIWC9OQklqbE54OS9DVFdjTnkxZVNSUXBtMVE0c2lX?=
 =?utf-8?B?UjVtcXhOMGlqTWMvdDRkZ3ZCdkRvZCtRNGoxNmd0c2lMbUVZd1hzVWRBY2dy?=
 =?utf-8?B?RU9kYTFpTmVqZy92OXZaZnlzU25NTXRJWUlHcUxlZDFYN2dUd1h4YWs4R2ZF?=
 =?utf-8?B?QXE0VHNKOHN2N2FvM05CRGFtT3FUc05UMFEzV1l2bzBpc25kNnpHLy9YVXIy?=
 =?utf-8?B?YXpIZkc3MTA5MUU2WENHNVhFRkhxRkxReCtjeWc4dzNMWm8vRWF5dE5vc1lG?=
 =?utf-8?B?Y3l4NjA4aitBeHZWQlB6a3g2Qm14WTRveVhSMFlBZFo0ZDVsUW8rY2dlcUxt?=
 =?utf-8?B?SFdQK0FNdnZFSmpzVGQ5WEFxdUJXS0FFaEJkMEViQnhDOGJncCt0aENNcmZM?=
 =?utf-8?B?ZS9WV2dKWFU5YTBtUVRua0FxS0h5RnR2ZzRvOS93bXdzdU01cm1FSittT1h2?=
 =?utf-8?B?WDNhRzUzMjRTUXpQeFVDbmtEbkp3TTdYai9YT3pZZVJuRWp3Rm1qWi8waXh3?=
 =?utf-8?B?bmUwYnF3dC81QmJIclB4aHdyeDlIQUhFeXNEM2NOYWFKZlJSZi9aTmZ0T2ph?=
 =?utf-8?B?UlBxeURGVUJGYUN6ZUVETmIvSi8yRnZJQ0VtRXJlVnBuS09aVlJnYnVqaERH?=
 =?utf-8?B?TVA0Ly9yVDZpWTNYU3A0RTc5OWk0NDRxYTNRZk5VSndqMS9uOXZqdzc3RUsr?=
 =?utf-8?B?K1Z1MnhwRnlDV2tsWXoxNGdQZWUwT1gxUFFycWlYcm0rY1NmTEFOM0NDMGJT?=
 =?utf-8?B?Nm5JdXkvOGo2NHVLWXdNVzI3TmdjZjJzdmdWMGROUXQwOXQ4b3pQRHJCY0sx?=
 =?utf-8?B?TGRqVnd0NEpZd2VlenRuemRPWWdGek44ZGFHNnhVSUppNnpHa1NrekNmRTAy?=
 =?utf-8?B?VEIrb1cwVVNNeGtqUFF0U2p5TGRqb3V3cHNMeEhWRjRWWlpwR2lsS3dqbEFW?=
 =?utf-8?B?dnVrZjFrNGpKM05ON2VXVnlwdkNxblRpTlhzcGZUOVVUalJCYm55SWNjQzlW?=
 =?utf-8?B?VVQxcDZHTTBab1c4ZWJndis2eVpvM3JOZU51YlBmOVIyWXY4M1JkOWoxTXBk?=
 =?utf-8?B?TFgzQzNWQWd1emMvZDNHUTFZMm50bEFydUhMUE1VTGhIbmU1SHhMS3J2NWM5?=
 =?utf-8?B?aE0vdEluK1lTeFJVSXJFLzdlWGJodEJxMVdzZ1lKeUw0R3c5L0FDcTVQOE0y?=
 =?utf-8?B?Y2dtMUs2VmIwcmFjSEN1a3E5WHRabytYZ3BCZTdWRUl5S0NDN2p1U3laNS9S?=
 =?utf-8?B?cGFrd0lIcWtWZHByM3M5VjBvR2Z5eWJWWXRjQW5HNFU3Z1JGZ2pOcTRuQzRl?=
 =?utf-8?B?MUhGUW55K3pObCtONnRGY2ExQmpEb0E0K3VSSHlWYVBvNkFiSVEzQllKQW1O?=
 =?utf-8?B?WHRFUVpoeEhkZUd1c0wxd0s4SzYybzJWb2tPdG5LV0N2SjRpd1RDeTN4L1dn?=
 =?utf-8?B?N1ExT2I5TW1qYWVob3ZCOTB3SUR1aENJbHBaMFJMSGtJZUw4dXo0d1h2VmZy?=
 =?utf-8?B?bDZ6clJRQjVkRTR6RUQxd2ZjL2RKaEw0NlZnemVwSlNhSDJtYW9EOHViNjFO?=
 =?utf-8?B?TjMvR3I3dFdZY2xCeE1LTzJ3RmZkazB5ZlZrMmNrMTJuNVpKV2htRS94RVlT?=
 =?utf-8?B?QTloeXNwVHl4TE5mWTA0L1RRK0kxL1BvcFNvS1RvbGtpcHdwdXBGWWNMMGRE?=
 =?utf-8?Q?cKO7j79U/LyJw0D0GUbmgSkIM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ReZliQg2h7jwp6cxPW6GTbwnQNhFUpwB/AAbJCH6YJKQ+qDyS98qaWTpJMlOMwG2HxDys/2Ds2fFkWfKyK0LqtMfHwLYohMDYdjvqm8/JCNiktNhBmkvNYsWkpBshiBx0xWjqeCDsFBzqPvECyDjvuPRWQmqSrAIkEBjuQf0yTl7K7wmRzsnNDX26p1FrGa9D/BmAU+FX+vz9ZgrvqsZVmyIjO1e5NysZZXo2Oj4wvRmezUsoNdHA8pvCiQ8837PfvrEzMriOJRQyXIuASz0LBLxxKsi/T9YsYu6bjSDJ53PhcbX1Ac0nfgqhJTz0IFSk6OUKXF2lz1d3rIpW2Sq9qWffli51qQd5mmmn8j2YDipLy4ajLMRzHiST+qwFAuZAQgN0NYtSO3Ty4omqT4zQu5oo+teAuLDFfT4M6pUdNSDV0Wb2pEdh+9/GVkvQU5xCd2QGNGCV033LoqwMn6nk8psdiKsLvtQjYp9/Ji5KxOUu47bgiNPDaZ05+6gVB7tVFsPRAgcW4s4p3B8UXDRPy78Wb1Pf9pr/hxEqD3IHF0ZeGJJWeHHzChuQ6hOrS6KshZQrsyIxofCGOqiSFAqDZToPQQ+efzKmt5mIBF47SMb/CQEy3DI7ajhpG8woCwW1JFrp2UvJaj5hSg+mFYW8x+KuU/CUxiywVzktWYjQFAb0ap7iR/UTOgxqPkuxzLIQ2kl4Vsy8XtTxa8NaMJrumTP3xiZ1h+Db1v76mXmiR1XVgX3IOQp5X6v+QhncS5GtJuUkYX/Cl3O2Bjf3/ZueSc4b9Z/bm1M4FG4cQeukUYHsXA7Y334q1FlRP8Ub9qG8DyPdAU4qseBSJZb7OHJsJ/jORhBjzX8mHNJjtvzfk/Go8OhZMuViqTr0fX0ZljE
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb59622-331c-468d-e632-08db413241de
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 00:00:31.3939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LfgSbBfsoMOJwZ6dVKAA7YdVN+OIonRJLYcfdQBgUXDaqA1/apJlJq5x/AddffUQ3MLUB4xpf1xIylo2nXvKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_15,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190207
X-Proofpoint-GUID: 8v2F_F8_-Hik6YjF4LGCo3Evuj4pG_dU
X-Proofpoint-ORIG-GUID: 8v2F_F8_-Hik6YjF4LGCo3Evuj4pG_dU
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/2023 4:21 PM, Jane Chu wrote:
> On 4/18/2023 2:18 PM, Andrew Morton wrote:
>> On Tue, 18 Apr 2023 17:02:30 -0400 Waiman Long <longman@redhat.com> 
>> wrote:
> [..]
>>> ...
>>>
>>> --- a/include/linux/mman.h
>>> +++ b/include/linux/mman.h
>>> @@ -152,6 +152,7 @@ calc_vm_flag_bits(unsigned long flags)
>>>       return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>>>              _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>>>              _calc_vm_trans(flags, MAP_SYNC,         VM_SYNC      ) |
>>> +           _calc_vm_trans(flags, MAP_STACK,         VM_STACK     ) |
>>>              arch_calc_vm_flag_bits(flags);
>>>   }
>>
>> The mmap(2) manpage says
>>
>>    This flag is currently a no-op on Linux.  However, by employing
>>    this flag, applications can ensure that they transparently ob- tain
>>    support if the flag is implemented in the future.  Thus, it is used
>>    in the glibc threading implementation to allow for the fact that some
>>    architectures may (later) require special treat- ment for stack
>>    allocations.  A further reason to employ this flag is portability:
>>    MAP_STACK exists (and has an effect) on some other systems (e.g.,
>>    some of the BSDs).
>>
>> so please propose an update for this?
>>
> 
> Just curious, why isn't MAP_STACK implemented in Linux kernel? what does 
> it take to implement it?
> 
> Also, could there be other potential issue with the vma merge, such as, 
> the user process start to truncate half of the anonymous memory vma 
> range oblivious to the fact that the vma has 'grown' into its stack and 
> it might be attempting to unmap some of its stack range?

Sorry, not 'oblivious'. how about a malicious user process get an fd via 
memfd_create() and attempt to truncate more than it mmap'ed?

> 
> If the vma merge is otherwise harmless, does it bring benefit other than 
> being one vma less?
> 
> thanks!
> -jane
> 
> 
