Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4E966580F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbjAKJts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238325AbjAKJsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:48:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E0C12D1C;
        Wed, 11 Jan 2023 01:47:13 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B9aWNx027786;
        Wed, 11 Jan 2023 09:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=P8QMuEs/sOiBqno0WpuR+0I7G2zv2EXERbDMpKlzXJU=;
 b=X1mWfV9bz8qKxfyGKRdeW1lc9ChAe/op+At6NiIt9JZ2XM9jEk0tK2LhrgwRfKxLuwyA
 oLZ/BWS8VkICExAH9mHKFGkQh9Zry3l02vcEYjCDSog9aY/IoHkmJGzdOC4JxPePolkP
 njMrk/VGitKZdYgZh0661QVVi5IsUiYNhQXr8IIjoWZRF12tMHXtA6E47J34cuOzW2Zr
 AHntL3Tgi/Airj6C4mNX4UjmMXdStovkpyQTCu+zseTmWC7O3BjdUwUsU/WL95uTmz2t
 bPJy7TWYltF21f9pwZu1FCq3GZX7ueZM+ng+WG7XIEY61dxKyujgHk3WUQFWTyuoH7k0 Cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0btqc8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 09:47:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30B8cSw2039283;
        Wed, 11 Jan 2023 09:47:01 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4afj27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 09:47:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhfhbjSUTdA3M0tVR2NxHi1jX6OAWuJnpz0VoJI9mXkM8/zvzXopIbFzd54KQxNlwRsU5RIcbss93vylEFOqJmzXeEUXMdLgQVFjkgYYto3OZccZZTKNAlf64i7EWPtWgzQRKPAeHlXd9kTleOOf/GbiCmPPlPFZzP/HyK67wAGrbL0o43RMHz15yq4lT2h3djHzwGrCcTAXQxiuERMnatoN2stsR18aeDxykQ1cDFfWVuIKdB0pOFqJslOKRda5Sh4Qr+VU9+/U8ToRVIhVCKaMOYZiHQeUian222jKBgc6ymbO8ee+QeQFYoqQvdXCR/VZRVTMGu3z55bDd1QHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8QMuEs/sOiBqno0WpuR+0I7G2zv2EXERbDMpKlzXJU=;
 b=AeuUZCscySS0W7OQAINMkkTfVSR5/HH5ERm7nZXkAe2ZDXIMRWg5WaZXA3RnCFLz09X5COfgwCEOJTZcnYdMF4PVt5F1R15tA+zcDdSyN7InSiX0rwHtpljAUReg53Ju4Qhdw7PEBGA6wouDMSI45wuMMyv7FfpdISCHqejLLUwFLyTQP8eQbS/sLI1MFymZzKUFzz2BYUowQMlYElZ+VJqCwhc74GLJqLEvKKowdi56W8DyKvNvHDU22CUa9ZiUex0F/dv0uSSCjotEuRP9dP7oFr36jmDNV0GpOMfYQ2xN9y+vlAf+ms0AGZ9HmWFu2bcvdwDqhYzK+r+vE2IGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8QMuEs/sOiBqno0WpuR+0I7G2zv2EXERbDMpKlzXJU=;
 b=qGr4i9rxOLPB8zPrZ6bGmg3Y5R9dqln4KurMoVp0UN9tSuyQ9NWoQdbN0fjP77Q17m7Q8HgbJBuTsgLDWu3Hj2mTgsNZv2B6k6SbzMV6IQi3NESl8CUNg4XgtzfNf9+drS5qxyhoxV8vWsm7PcFHGaA1vA9gzvtuswLe0tbJGIM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6834.namprd10.prod.outlook.com (2603:10b6:610:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Wed, 11 Jan
 2023 09:46:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%8]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 09:46:59 +0000
Message-ID: <486ac5fc-9b9e-8591-0dd0-0336dde72c34@oracle.com>
Date:   Wed, 11 Jan 2023 09:46:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V4 2/6] genirq/affinity: Pass affinity managed mask array
 to irq_build_affinity_masks
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
References: <20221227022905.352674-1-ming.lei@redhat.com>
 <20221227022905.352674-3-ming.lei@redhat.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20221227022905.352674-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0245.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba7f553-9a7b-4f56-db3c-08daf3b8c8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iovck29wOqD+ZgNH5oRWpfV2b+OOxw5xCKozQ1+BcAB64OS9hlsc9xBF3Mc60BCIzSLUJwXMk8I+Sw0730CbjdIafJ/j7prdTphv0gAPlI/tqDX83iXb05EXdWhIHhdww9A4BXDs0o30/tg0VWk20fnrvQIsFaOExaA79FrQHa/gBHxpV/v1GJq5Ujg/LgATOGoSy6D4MOqSOKaXEjVodBlwR9xIoVqvpSvqGeI9wKCk9Jer67LMyYMqtw28b5S/g7UQ3YPlsfk3FWajiZPE3gTkwXrxKK+0eTHmo5sYZt0uCySEd4AQub15SXYV+jcGwmDzrv3MCCckqBgmp8a9Ztg4fBS246UvSnYbgJtuEIiDyBcGxPtmrdXuwFfcU7TxzuwdOjY0taidZICnRl2PsIljmx7JbxLWNpanXqizApoVCB5f30l4SxAcCDQEWWd/1a92V1aUna9FlW9Lk0yfbtRuBMmO5zOkgVnVCEwA+es3HATQU/0REtutWuYmZoiGBKNtl0m2i7HNjllsv+K11RNCjsWBX7n3wdttRWMFm1IRY8Gh3BL1amEPLdisaL3TEV2bTXHpVnktyQmq2nPYkuj+bgW9aztWuKdLAp1VrgNoTuuojk7F1Al/6729gdO5KWzLMg/2maLM9dl5jjI8mNSO/fmqI1+c3XmrRE1x/IQekXLbVagwb0oAODg6iJ/zBhddeJebCWkXDSuFqdXoKgow9hmZVIjTnc3uNMbdqdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199015)(478600001)(6486002)(2616005)(110136005)(54906003)(36916002)(38100700002)(36756003)(6512007)(66476007)(8676002)(66556008)(66946007)(26005)(186003)(316002)(4326008)(53546011)(6666004)(5660300002)(31686004)(6506007)(41300700001)(31696002)(86362001)(8936002)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTNPMERlSXZsbXZ1bjRabys2dDZsazB6YTNjV1lqTTVXK3FzbFdXeEIrSDlr?=
 =?utf-8?B?QXNRK3lqem9MV09sc1R5a3NyLzM5Y05rMUlTOTN4SVhPekh4V2JkeFg5U0xV?=
 =?utf-8?B?L3JUUjBzV0ZPcTgxWjJkQmJwNTJmeUhZMzgxYm00ZklkQnZaeGFnazlDMkRY?=
 =?utf-8?B?V0FiQUpzSlc5ZG9vWVlKcGhvbXUrYUpHTFdmYUkzK29STlNMZzBaVkJ4STFY?=
 =?utf-8?B?SUw2MDNUa0svSzZHSU1jN2ZMcWJjZG9EY2FMblRyaGlyTGgwV016V3pKOHUw?=
 =?utf-8?B?citOMWk4M2IzYXE3elVyeElHYnFBaUtpaDJ1U0V6UFhyVXhlYUt3My9rTFU2?=
 =?utf-8?B?ZHpYOWN2QXJhQXdkUnA4bzd2aHZ4aGhaZ3MrS0k5UzZXV0NLNndpMTl3YmZJ?=
 =?utf-8?B?aVA5RHRxY1M0QTNQLytlM3Z1d0NNWUY2QlR4Z3ZiRW5OenF5QzhOVm5kdzVC?=
 =?utf-8?B?WkVEVURGbEQxMGFnaFhFdGtxN01rYnBQTDR5NGlYVVJZMFpDSkpYdklid2dS?=
 =?utf-8?B?dnhhbmF4VVJyMEhLRVdoTWJieitwTWpUWXIrSUlBelpyd0tHMmQwVGRKSlF1?=
 =?utf-8?B?TWxNdGVoSTQxR3dFc0g3c1NjZkZObHAyeStSQldqU2p0eFltNjFhc0VyVUhZ?=
 =?utf-8?B?SHJJZVhKWVFSazZPbXdjTDRFU29Cb2dueEIrQU5EWXNTVGU1MVZzcDlnYjZF?=
 =?utf-8?B?Um9CY2NGUzVSZXJDZUxBeDgzQUEzeVJNN2E4ZVNoNi9GcDZjeVFmSHFaR0dM?=
 =?utf-8?B?WWRwMW1pQzR4NUZ5REovb0FLeW05WlRWcVVZY3BRaHl5UG5YNHpDY0UxY1dT?=
 =?utf-8?B?OEVaYmxkbDNpdXdSSnN1T1ptWnBtY2IvekJUUmZOOW9uZU1TRXJmUXRQRWpI?=
 =?utf-8?B?NzlsMTB3bTg0d0tzb2U5Z1Z0WW1iaHBPVmJQbEl2SXorektvV3pGcXRnTTZn?=
 =?utf-8?B?NlM5RTRSVjUxa3VmYjkxN2w0QmpZaTNVODdhbzZWV0Q2dFBTb3Y5VlZrNHdn?=
 =?utf-8?B?M1RsT0dIdzFWaFRENFVxSFNrcC9JQ0htYk4rQUNXT0gyWkF4K0VtaG9BS25Y?=
 =?utf-8?B?QW5vck5rYmU1LzRKN2pvakNubVpxMnpzVUtBa1RRQ1M5eDZrR3hnd01tcnFX?=
 =?utf-8?B?N1RTTjdIS3lDdUgyRnd6OUF0NjA4MXlucWtiYUZSWmp4b2lIWGMwd2Vwbnhu?=
 =?utf-8?B?dnM2bWhXN0FHQkp5QjV3M09FUW9vc2VSNjFObk5VcnBuTWxicGlWV3oxU2hw?=
 =?utf-8?B?WXVWc0ZDYXlUMHlTUTZZb3R2bFpSb20zU2hadURONHkvWVNqZDZ3c3Noa2R4?=
 =?utf-8?B?UmR0RDhhV0ZWYXlsZks1Z3hoc3dmWk5xWE9GYjh5OEhmQUdXOGxocVREclhB?=
 =?utf-8?B?VHBEYVVQYnI0U0V3Y2t6bXNsU2xzZE4rejk1OHhOM28xTUlkOXl1SEpwdU1t?=
 =?utf-8?B?c0pOUThqbFdpczZ0R1VNVEJKNWl3UC9wY0pQaitsOXlUYnFCcFZDNGswZXlW?=
 =?utf-8?B?SHhvZUE3M2ptQm5DYXExMFJ4MitLTWFpb2JZL3NaWHl5M2ZwUEJPVFZPUWs1?=
 =?utf-8?B?d09rODRIZXFjRFhIZVNYczJ1enNweHkrbUlhMHIxL3dIbFd3SUpvVzc2Z3VK?=
 =?utf-8?B?SDArT1dYYXF4YWwwelhCSHZCUVp4a3B6aHMvQWtPcUI0TTUyeVZ5QlNTQlJw?=
 =?utf-8?B?SXFyTDJwUmQ2Y2hEaGxzdnZ4QzJESUNHS2xRNGhRL290Z01DV21XbFRpQzRS?=
 =?utf-8?B?cy9HRzM0Sks4NERSTU0zWlVrM2Q3b0NRL3dlaFlpbzZjTDdNQ3Y5WEE3ZENI?=
 =?utf-8?B?UHcvaGREUGtjOGRPQ21nbEUwdUE2LzVRVUVIdFpoWWpVYWV1d3VJVnJIZTVH?=
 =?utf-8?B?N1ZWSVZSeXdMZWNOUzZZWW4xMTZ5TW9tZXBnTGtObmhvayszeDY4TkgybFhQ?=
 =?utf-8?B?NkZIcm52bTZzN1dvTG45dVA0Wm9vaXQrRld3UWxpSldJQklzenZYVFBZaHR1?=
 =?utf-8?B?UlpnQnFaOXE0dWRtNmY4cjFVOHZubVhhS2c2bUNOOU9MSG1PL2svRFkvUHlx?=
 =?utf-8?B?R0h2YVdNUHhoK2RPN1I1MG9ZWkJ0ZzZiWlRqc0lkYlEwU2N2WXM2YTJkRis2?=
 =?utf-8?B?U2E3MEZob2ZIK2lVSk1HWHZreXZXU2gzaHVEMjc5Q2xDYUltaEFlekRjckRF?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hAghqCmUq28y1k/G1hPjmPNSD26DHvksohaqQXheC+6qjXI1GGd9vCrPZrs1eF8adbb23N8S9L2Jy7+iHqnRSaCDCucUHXpZK0wOavEwaNodaaSAvKrY4Uocw4Ydxi5LHbxmJU3fbWSmIqY+p/+e6WY/h7KqbzImF7i10Wpdv+IM0zmvesLQlVNCYEj6l/I1lS7VSSuzCPSAx8vXIyLwLHN9khUQZzLOTq2VikCsFAF3iSaswDW7FtJu7LgAP0L6sfrobyd1Eit2YbtJUHVqcFYH+KuDnYtBmKVGUM/hJ9gfkVFMOXSdvHZOUL1CQRf/lpJFVPSLScBb2LJLJOv4VTQwYJWa3wnkiqGXZraOP4Z/IJxyAbx+g57f15Y4Z/CX3Vwj6m1k+0qNNG3oi7Ln8qDHQGxTEkaIXaQNGPZN2gZBuMWByqDIt9OPuD05TFuoMN8Jo6PNZ8ahGt2JB7e+utHmgXymACoj11eizQKumFG0EUNJgSDXpwBUGKSu3KY42hHLgXlkJTOnf9NEL8pbZPbDExHVl1dpC2qUxTULnludImBCmJBaHoH3kVaPhIQ3q4vp7KJOo41QOObXMSuH7uWtsq1tXcYC4fuXoCewdxvL24OAVmxZ2qPmys1qDCGGuKQ6Lw2vZxbF/pdNwhhy/qkq4EMR2e6M4LjYber9Dxltt36Dj2gAQ8oXy9lPJMRRHzGLK5gz8hFfP6xtKE/28jMQQ/mYCZ32wAJbyAVRRTY5P1WurOAE1YHXdnegS44MvF0wbRTEBlaEc6Foz1caf++q0ByRMbFUSRZv9eB/cD7aNWUBQR7DTKQJczc8iL4rVVfULd2gVGbEJ376XV6soG7IS8+90fwG+2OAsFAbX/ER4ts/vnQEZH/JSHFq6/rmVHcEjjVHqp4sEmyx6eIPzQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba7f553-9a7b-4f56-db3c-08daf3b8c8eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:46:59.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpmAzrQPAHRMHWuR39aBkSLtdamdAAWbLvWt+clSyyY/avzt1EQFk+cGYeFc/B75nCcSdY5Huy3UA9ELk1YjTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_04,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301110074
X-Proofpoint-GUID: XNXKauHHGaHC6rlVyAk-L8vK6k8iTWBY
X-Proofpoint-ORIG-GUID: XNXKauHHGaHC6rlVyAk-L8vK6k8iTWBY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2022 02:29, Ming Lei wrote:
> Pass affinity managed mask array to irq_build_affinity_masks() so that
> index of the first affinity managed vector is always zero, then we can
> simplify the implementation a bit.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Apart from a couple of nits, FWIW:

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   kernel/irq/affinity.c | 28 ++++++++++++----------------
>   1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 3361e36ebaa1..da6379cd27fd 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -246,14 +246,13 @@ static void alloc_nodes_vectors(unsigned int numvecs,
>   
>   static int __irq_build_affinity_masks(unsigned int startvec,
>   				      unsigned int numvecs,
> -				      unsigned int firstvec,
>   				      cpumask_var_t *node_to_cpumask,
>   				      const struct cpumask *cpu_mask,
>   				      struct cpumask *nmsk,
>   				      struct irq_affinity_desc *masks)
>   {
>   	unsigned int i, n, nodes, cpus_per_vec, extra_vecs, done = 0;
> -	unsigned int last_affv = firstvec + numvecs;
> +	unsigned int last_affv = numvecs;
>   	unsigned int curvec = startvec;
>   	nodemask_t nodemsk = NODE_MASK_NONE;
>   	struct node_vectors *node_vectors;
> @@ -273,7 +272,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>   			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
>   			cpumask_or(&masks[curvec].mask, &masks[curvec].mask, nmsk);
>   			if (++curvec == last_affv)
> -				curvec = firstvec;
> +				curvec = 0;
>   		}
>   		return numvecs;
>   	}
> @@ -321,7 +320,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>   			 * may start anywhere
>   			 */
>   			if (curvec >= last_affv)
> -				curvec = firstvec;
> +				curvec = 0;
>   			irq_spread_init_one(&masks[curvec].mask, nmsk,
>   						cpus_per_vec);
>   		}
> @@ -336,11 +335,10 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>    *	1) spread present CPU on these vectors
>    *	2) spread other possible CPUs on these vectors
>    */
> -static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
> +static int irq_build_affinity_masks(unsigned int numvecs,
>   				    struct irq_affinity_desc *masks)
>   {
> -	unsigned int curvec = startvec, nr_present = 0, nr_others = 0;
> -	unsigned int firstvec = startvec;
> +	unsigned int curvec = 0

nit: curvec is used only as irq_build_affinity_masks() startvec param, 
so not sure why you use a different name in this function

> , nr_present = 0, nr_others = 0;
>   	cpumask_var_t *node_to_cpumask;
>   	cpumask_var_t nmsk, npresmsk;
>   	int ret = -ENOMEM;
> @@ -360,9 +358,8 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
>   	build_node_to_cpumask(node_to_cpumask);
>   
>   	/* Spread on present CPUs starting from affd->pre_vectors */
> -	ret = __irq_build_affinity_masks(curvec, numvecs, firstvec,
> -					 node_to_cpumask, cpu_present_mask,
> -					 nmsk, masks);
> +	ret = __irq_build_affinity_masks(curvec, numvecs, node_to_cpumask,

nit: maybe you can /s/curvec/0/ to be more explicit in intention

> +					 cpu_present_mask, nmsk, masks);
>   	if (ret < 0)
>   		goto fail_build_affinity;
>   	nr_present = ret;
> @@ -374,13 +371,12 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
>   	 * out vectors.
>   	 */
>   	if (nr_present >= numvecs)
> -		curvec = firstvec;
> +		curvec = 0;
>   	else
> -		curvec = firstvec + nr_present;
> +		curvec = nr_present;
>   	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
> -	ret = __irq_build_affinity_masks(curvec, numvecs, firstvec,
> -					 node_to_cpumask, npresmsk, nmsk,
> -					 masks);
> +	ret = __irq_build_affinity_masks(curvec, numvecs, node_to_cpumask,
> +					 npresmsk, nmsk, masks);
>   	if (ret >= 0)
>   		nr_others = ret;
>   
> @@ -463,7 +459,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>   		unsigned int this_vecs = affd->set_size[i];
>   		int ret;
>   
> -		ret = irq_build_affinity_masks(curvec, this_vecs, masks);
> +		ret = irq_build_affinity_masks(this_vecs, &masks[curvec]);
>   		if (ret) {
>   			kfree(masks);
>   			return NULL;

