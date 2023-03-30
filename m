Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E8E6D0B76
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjC3Qic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjC3Qia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:38:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0996CA1D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:38:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UEE7ka032275;
        Thu, 30 Mar 2023 15:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kEm9Ur8JpBiX2M08fuPFoH+GWoJCKVCjBoBeglJ4U7Q=;
 b=CGjZ98Q6pbP+Koe6o5dthVi6plmWdqQd+lXRl1KAZ9brfiTqsOm33ebN/5rJPjj3zvxi
 5CzX6Q1TEuM71b3BXAVcubZBbbOuolK0loZyt8Fkh4vDhNEgReTIVCDZvv/rZjWdH2xz
 U6i55ZgYHsU4N5SCFZx1v82DGGvNTG1TEPT3PRcqpB+gFbQMmvK0yhfVnIzwpbXwJo3a
 EXR8f0n7vh8sDPG2wSBj/dcv/wJN7uSwhl+K81QAW1fq+b1n1Z+7K3Zi/4C740pwCOmO
 /9CJ87G7BL7m4sHu2enSX6wnpZQgQE9Toys0Xfa0hwdrCmveIUSUvY/LNsEdIpDquRE7 fQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmq79awwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 15:10:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UDopHF016288;
        Thu, 30 Mar 2023 15:10:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pmyvvg5nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 15:10:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5ZX7kkIB7pMrWMird0ExVniMZr8DZvqeodQ+tPBZNWJdq7zZlwv51e5QDVDl1PdRd6OOiX5NLYIf6STxEVYt8487zMD3R9L32RPj/VhdjU/rcfyhyT7rHVO4JnAq++uoHLoEt+E/13Hb68oH+OwdWweAVq1hPq7Zp11HF8UEQAXLr99rvRixRyhzeQxZAwaqkZahboazknR8Uk48rk2CYn2TEbNiPB/dYWnVS24n1ny7sn85VovvnSr0T6yCnyt9DyhktKR+OVRY2QHmP+LHgQWDWHtcbnUvGTFzCKm0m23cFBhRcqDWJ3pRRrIDdHcHL8et5KrUYWsxUnEu2BHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEm9Ur8JpBiX2M08fuPFoH+GWoJCKVCjBoBeglJ4U7Q=;
 b=DYiaB4a3y+dodpabw/Vz9XxkKd6vgajq6qzHckJCCvWuVX2qLEwfXOtPqeg/BV4OY1Ijc4/eI2tldp2bbXfS9GHqJLeokb1TFIfeJZ5bLq63K/TIv8f75qC0TcfGlu+mP2ov2SpuXOOyKDY/SFsuutsJ+XGGW+wuqvD98euQmC96mRPtjnVOpZHSPgXIUeOzKZf+E3FZBNlGXCzcobB8BoLcY+ZhtE8+lR5WslnpQufmKq4/fpbJk8sCUuz10scS+gN08YLaJNda66mLIBVykN+dvXwfFyJi3uUWArWWCz+akOz05nOES9me2LsUz4GlzOc+LyRgnz1fJlCQwTbvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEm9Ur8JpBiX2M08fuPFoH+GWoJCKVCjBoBeglJ4U7Q=;
 b=QnImZeFav8cj3g7qdYttL1ViaiG07zLi0caVnNP4iJRUIcAWJpKmH98xuEeOJxA1Ry67CZAoeiT7il5SFcFrq9iOIAYjNvtq/z+fVjhGFCvCgl8UxwRkyaPEZrlTg7Z0DLghY8EdNg8fapP9nSSK3kociOpYs33ngIw2McD8aXE=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SA1PR10MB6319.namprd10.prod.outlook.com (2603:10b6:806:252::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 15:10:36 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 15:10:36 +0000
Message-ID: <d3ff86b7-ec8e-d66c-7098-138115361a77@oracle.com>
Date:   Thu, 30 Mar 2023 11:10:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] sched/numa: Fix divide by zero for
 sysctl_numa_balancing_scan_size.
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org
References: <20230329162610.4130188-1-chris.hyser@oracle.com>
 <d1fbf2d4-8989-effd-c908-2784f386fb8d@oracle.com>
 <20230330134557.GG124812@hirez.programming.kicks-ass.net>
From:   chris hyser <chris.hyser@oracle.com>
In-Reply-To: <20230330134557.GG124812@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:208:120::36) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|SA1PR10MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c58c012-d516-44fd-173f-08db3130ea34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wh/286mkZxBH+mxHpxTAq0bo3epu/x0XYdcit4r5DCMSPKEVRCspuXNr/cmAKlFjqS9fg+ZEsqD+0XUha7sG7kfMqSbHiTaE1Kv/u82U+XNeC+TB/nyq2xJdKNTzYnTvgt/N751l13lsc0a/9T86GAmRRZXVEsz4goON5phM/Eh7ppNzjuDkEoAhmi7Oo/eZZe/lbsg9xcA90A2uTEJykKWpvX4/pQvge7KVMAsLZRnYJchjhDaM8jxXvxIRq3hG2U4xDpZsXeyCiWciA0SBG7C+HA81/tkFdq1RZGzwysikaWL3+L+McAvIsn/9quvT8sGZ3LtLp/bmm8ldd6yWI7nzupqZala0JWOlwUxSYm5JFNXv1Yiy133EW9WVbXMct+xpaSCM4rSeWeJDN1gY2hFzsdmwjKq/WEIld7C6lR66/KLMkMGVrkID8nw6iGS1tDgZgUj0zeeFs1l6DZWXWdvsXkrtkq0E06wiNL7OxO9pY2/HjHHDSi1+zgWNLdkT+zYvSsm7EMnlXFP6JNV2e9MeSTMeVjhlorIig9JpmClyXMyo1/g74uMcdsT8fIev3uWeJVmLIROsn6BTjDpiGJfEsY13NZ7beAeqheSQTAbNUCyA8UVu13Tek4nGNVSnJ7MGPym0ShNevKTa11QtvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(6512007)(6506007)(6666004)(316002)(86362001)(5660300002)(8936002)(2616005)(31696002)(66946007)(41300700001)(6916009)(36756003)(66476007)(8676002)(4326008)(66556008)(53546011)(186003)(26005)(38100700002)(478600001)(2906002)(31686004)(6486002)(4744005)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVJlUkdTKzNybVlTWHBzbDhPclJRMmxQMlFVMGpRNmU1M0VvNDVRQ1laQ2Nn?=
 =?utf-8?B?c2NSVTUwYzMrUmlQc2QzOUdrMEZNZVJwQnZSTVErVmlESGJVWlk5WTFGKzZ0?=
 =?utf-8?B?b1ZpajNKTjF3RHhlTHVXR3dOU2RUL3NCczB2T0NvWkZpaTRvQnNwQm1IbWFw?=
 =?utf-8?B?R053V1RiVHI4THd0T01VUTdDRHU3eVRyYktvOC8rcWVrVEVLeHJsdURWWlRh?=
 =?utf-8?B?OXV0dEtmTEhaaUNLMVV1RnZtaUpxd0pCWVppZmNLUGROcTFRc2RTTDFBK2g1?=
 =?utf-8?B?NGd3ZmRmQTFOZ3dEbElnQnhpRS85YnZhNEc3Nlo1R1JSQmlKYmYvaUU4b2Fz?=
 =?utf-8?B?ZkN2dVdEWFhqUCs5TE1WWHJadmdSVnBJM0pKSWpTUWRLc0lEaXpUeXMvVTd5?=
 =?utf-8?B?cExycTVuelRSZ1h4NUxCek9nQ1JmZWFEb0hYYlJ2L2gvRUhNQlRUQ21xc3BV?=
 =?utf-8?B?c1RkRTVxWVpXbUk0bllSalI1MS9LNmJycWFvbUZmaVFRWXg0Z29Qb1hXTnBT?=
 =?utf-8?B?QnpjTXZCTGhsRGdkdHlFNGRRZmtOdGk4ZTNIM1ZJc1pEMzVXSG5aOHhHL2cy?=
 =?utf-8?B?Q2gzWW9YeE5HUkVZcS9wZ0FIZnk4dUY3NlNwM2FQanhwcmV3azNIb2o5S0dX?=
 =?utf-8?B?MXpZc2grYTJKdjdOOW5kbUVseXB2UmlsVCtabmtlNTF2ZFB1SHVBL3dIS1hC?=
 =?utf-8?B?NXdoUmFEVFFIUEhobEt6TzJFUEdUUVgzT2xtaGhURm5sdWRXcjhmQ3JjRm5D?=
 =?utf-8?B?UVZFeTVOTmd1bHlyTzB3S0hXRWNYWDc1Y1YxVmhUbi9ZdWNsTzBxVUF3Y3BC?=
 =?utf-8?B?R0x5a2s3emk1blNQZTJvd1BGbTlKNkxic3crckl6M2NUVmZCUlkwWDI3UlZk?=
 =?utf-8?B?aWhmeE4zeDNGaFN6dFNuQjh5eVZXbE1IZFhnWDdBRjB4ZkNIODRiVFQ4YnNk?=
 =?utf-8?B?M0tTazdTZVZqbkMwV0g0VWtxWlFnaWx5N1drY3ZMVEFFQndzY3A1bm1QR3o2?=
 =?utf-8?B?QkdSTFdwU3g2WWVyaGcrZ2FJVGxzZDhRazBRdEU5NkxQc3FUbGxuem1OQ0RL?=
 =?utf-8?B?WTNMeWhZc1N3WlJYTEcybTVTb2tRME42a1hIZ1R2QmZVUWExQS83STcrTHZT?=
 =?utf-8?B?YXhDL0s0WDk4VVNJdlZDdFoyZDIzUlA2dXM4Y2Vzdmx5UkRFYUZyR29jRUh2?=
 =?utf-8?B?cVlzRFdGMjBjckoxTURYV3dtY1oweWNRZGVWMXJJZWEwUFlVRDhtREdMdlRS?=
 =?utf-8?B?V0tjMkh3SkNCdmpmdWNYTVVFNENWczZ5ODZEc1hMMVhZZHFaVlZ5ZTd3bGEy?=
 =?utf-8?B?clRGanNXQmdQMzFyMWFORFQwNlYrZ0EvS3V3WSswQ0NTYXJQUEJtN1BucDNG?=
 =?utf-8?B?cWZhckJoUHRmM0ljdmlpRzBHT1crOFpHamdGTlVlaE9tZ2ltWlZYVENNNnp6?=
 =?utf-8?B?d0Q0bVMzYVBoczFGS0t4ZEd0VnBEemlpMXNwVXZpc0dCL0ZtUzc0NmpuNE54?=
 =?utf-8?B?ZzFFNTRCWHBIUzNlZEZvdjd1TzVlRnU2amFMSE80VU94M2EyaCtLTmx2d3Rh?=
 =?utf-8?B?UUZJVWdDRWFUeTRpVGtJOXJVYWVvZ3ZZaUZiTUZUTWtFdzRCdnNOT3lzQXdn?=
 =?utf-8?B?azBsTHFoWjk3b1BMTVM3N1hCSFBZNWJrSUhSYUJVUlRibm5YY0hwMm5mczhv?=
 =?utf-8?B?TitSbnpQTGNOaytEYnFVREZNQnVON3BWSHBEYTY4UG84SlQ1NmhiektMTUN6?=
 =?utf-8?B?TEE0NUl0NmZoNWN4ZXgwY0JGUitQdWVGTEI3UHA5OU0zNEhGbTkzUnBmdHpF?=
 =?utf-8?B?ejAzRCtUS2tnS1l0azQzeThHc0M3NWxmY0dGNWJ0eUFCWWFURWVnL01YMUJw?=
 =?utf-8?B?a3A4MFVFMkdHMFhOUWEyNTUybDcrRVRsQjlFQTFtdUVuOWdCUTZmYmVjeXo2?=
 =?utf-8?B?V1hpRXM3OGFJY1huZWdYVHlVRWFGc09URHBHMzJWRitjOGttVzl1VGhxYVk3?=
 =?utf-8?B?M3grR1pNNlI2ZDdpMlVXaEw3eG83d3d5RkswRytnSDhGU3hXbXNIdElGNCtw?=
 =?utf-8?B?TFBwVkJTaER0aldHT1l5eElmMFV2dEtBeUovd2JlcUN2S2R6QVh1c2VSQ2Nl?=
 =?utf-8?B?VzR1aXRISUtFM1lZYzQ3OWRzYjFZdFZVdUxKTGNQK05FaktGS21ydmtqMHcy?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZCF7KwH8qL0fm/kKLqXwTGUVhe95mqn1gT5iQHo7/NxuziKgGN5zaTqdyklg9sH0HeQDRsXnkmUvtOW6K8BspgrjLlRAqgkBlj2m01rAS5O2wSTGYpCOT19BYCs01Dah0wW5ZNXSiUZP9VB7OqOTwAKjFT9MmkHn5x4iyu6uEGciTTeXeAVG72GaFWEc5bNmVrmZG8r2JcWS7tgNYWQFJek0o1zRlbVMKoHAkpGh+FWMfBaWUzocgNzcPF/QQcrZdAkzcLZ1Quwz2hI05QplfaqaTwgqqHqmYUBxdTIpIkIDIsIDpZjC7vI9PGEMG1shpIu40002oe4kayVS0pVZfBfvuzevzlctNY1BxI8Gj0lmQEaSbu5MQ231JTeqnmyfHsJUPGTiQOCJTuQ45EGUOxJO4pfQZC2IWn8VCX6zWnZse70uSBiwqLBdndNLeX0Lnm4s5vYWoDOl4G1tfsp3w5CcksipIkLE51bAsYEg71BPxA7tpxmXVj/XH8gjIEaogZkzUxfxe43HHRsFGuOYfBXOtntRztTCT4r9s+4lvhgIQ3/6xONR/oyM4BTzLQ/HQh+CZNGJtyxQuH98dwv4kTjzFVF8RcBmfssnRQQEvKQzaaS/+L5p0YfaT37I5ZDkrX+aXv1utD2eAK+HeQrFan+pXtOijLT30RkYnCqBanCnyPOJgxSE471vgCllWR3nXDXQPQLiHAYSw0ZG587loiT4aiufetongihn8pU6eOTgjaqb17kbGh+JZ864qzL9zWljwbisru2y5YmS38VGM8+iPpx4HQWsLGq2O0+GLEAOILSyIP2N27w2v29OPCBvcy90gu+pZf/HO4ajZimuLtH5/KgUzWXDFzSxya9XsMQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c58c012-d516-44fd-173f-08db3130ea34
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:10:36.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4xpTLuri/XXkoT0M2cibogTw9igftQgGs42NpARIWFZ1xVmL7/oVMmXFJUB+nGyT/u7nUsV/7dEfz+rKLz/Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_09,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=860 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300119
X-Proofpoint-ORIG-GUID: rYW0_EwexEA2faHVFuaWZJ4_ytFBVbXf
X-Proofpoint-GUID: rYW0_EwexEA2faHVFuaWZJ4_ytFBVbXf
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 09:45, Peter Zijlstra wrote:
> On Wed, Mar 29, 2023 at 02:28:25PM -0400, chris hyser wrote:
>> On 3/29/23 12:26, Chris Hyser wrote:
>>> From: chris hyser <chris.hyser@oracle.com>
>>
>> Apologies. Something in my email chain put this in, but I think I figured it
>> out and sent a version 1.
> 
> Not actually a problem -- all patch processing tools can deal with this
> since it's a common pattern when forwarding patches written by others.

Makes sense. Thanks.
