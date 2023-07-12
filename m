Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70C2750C43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjGLPUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjGLPT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:19:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9962700;
        Wed, 12 Jul 2023 08:19:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CEiDEW013196;
        Wed, 12 Jul 2023 15:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=uy6P12kLayHKlLCtyvKc2sK+XoDwNQW/Q3FK6vU1yRA=;
 b=xp0JgqM9FKrW3YoCkbEV/Wsdnd5ATaewl1lA63Up7saRWeGc6UcGAtBGiCGG9YArw4lg
 ksiK4YTAD1I2Lf2CO6kd/AjcM/nmrHkQTWq1pDJ5/tzSEvpdjOi3WPkTE7HzPbfZjomG
 ZNolez9eoxEpDaItyAd9UbGkZpDWQ8wry5sAtdInjL/w3GhMaqEGKnN6Xv9YSjvcArsu
 G8n18xOryoNsLJG9Oh3m/7elDJpg5rwxjMTeJnB2+P+62XEtRAGTnMmOMhirM67bbWn7
 DfaE0oL62JocWX2f1NR3+upfWny0Hb6D1QWJX8sdHy5ojMXvm2x/yholilTs0vZb2VM9 9w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr8xup04d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 15:18:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36CEtktE004194;
        Wed, 12 Jul 2023 15:18:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8d1nyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 15:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAFiL74RU5dbS3rmvks9aqq3WD801sV9F1RqeLCY/JEgdqizzVm+wJFkrnTg0zxP0I9O3WJgPShqfbZWxgEqgW72oDk1ozPBwlOaZ+cjh2S/rjeLE7E1XqRRsU5onCQ9MEJN7hUFaDy77JL8LvKCvlvasy+ThctU8pdSJQUTN6TMZCANj6ssF3vTq+QcZJrZ5XzW2Vxkm/kPisSgzwfugcefDUWiwAvfqmYl6zqFrQAqyITSgQ0ecc3GmVxiZvtWBETpOkh8ae527ZEThgZIelx2M88EwmKHrivpHbZgrz9pxQxhIAiUSzmG3/Dmb9M60+Vmcj5BjzQJxFviiBkykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uy6P12kLayHKlLCtyvKc2sK+XoDwNQW/Q3FK6vU1yRA=;
 b=noalxh4UZSTEpyQvCcRTzJLliSJwyzSv7BcIHv4qOzqHwcATLRuxNG/WZQ5S9qfBoV4832e2sLvFlHiYDzMszoyO2UpA432JEL6TjXy9oh6hjFUsAtsV4Qss4eCoh9KzOaZyJcpbjSxZCmDltOgfZUjFTad0c9neodYzijT3LIbOtxOPry/9HTxg7DAPDS6LxybcKuLXQFlQG6u0IWDqnCjL3FcAx+syPpT+rOTFR1VCIGmI+1nyzG8DZECWzc19maqUV2IXAIbv+SlUoItvoGkC47W3xOt/sVrPLmyKWwlRGgIdhh/vEIZxrOXvmKVRjVi4uf/v4doOV4wVupT/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy6P12kLayHKlLCtyvKc2sK+XoDwNQW/Q3FK6vU1yRA=;
 b=HDxImPmQjRHF64q9J2IBPC2vZBdjiuX6g/7l7v7qVqfFUuIzILKutIrn3Vv/OrF+HP2ccs6EBoeYPVbbHsZTLau0rljIPPifXhznSuA05lGbSWXmTJqesfPQbLRC4JzqttU+ZxVsn2vUedbN2xtALdjf8H9kQrgzHJwwoAhDDN8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH2PR10MB4120.namprd10.prod.outlook.com (2603:10b6:610:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 15:18:22 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4c83:52fa:a398:11a8]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4c83:52fa:a398:11a8%3]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 15:18:22 +0000
Message-ID: <51b18c04-c5a2-885c-c987-fe6e48f5cacc@oracle.com>
Date:   Wed, 12 Jul 2023 10:18:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: Tree for Jul 10
 (arch/s390/kernel/machine_kexec_file.c)
Content-Language: en-US
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230710113814.4a4916cf@canb.auug.org.au>
 <9536c8ca-a0f2-c4be-d705-2ac1054ebf7d@infradead.org>
 <8a848504-6e4c-ba7a-4777-3175c1fdc6d7@oracle.com>
 <903448cf-b333-cb75-87e2-4bee8d1d915e@oracle.com>
 <5311ed1b-ab09-6e9c-4ca6-061fe0201de6@infradead.org>
 <b6595438-bb85-4a08-b491-559bcfc30376@oracle.com>
In-Reply-To: <b6595438-bb85-4a08-b491-559bcfc30376@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::21) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH2PR10MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: 8023dd2a-db7a-498d-b5ba-08db82eb3b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhFb18IiRyA6dwP8YnfWE6Wus7SlqY3AsFXeLJ4+6BQdzYoG+LKBgC7vrDMUVFAA9hf/+/QRoo4G47nG5aeiJwl/3QEu0K6tOwp3ORBJKHShScPQwJHbYHJpzOc+DZMtqmN57tLQgZru3zBVk7Lym1DBy+A9HCPo1UJzdkUy5oXzFB73UDZOCX63IfuU1xwtO2PnvrbQO7NsyB2nJmHQPeD1Ji92L4RAntvGgQyjSzyQbZ+5VlgSr7d0r/y/0mxbw0p6QXd48Vo4yzBqWDUGrsAxTNz873NOkO2Phg+4mfch1ECtNmnp1aH4emMixCHOHvcp6/PGsqsGQ+W5/qsjPNcpGel/sS9Pqx26thTZHLHycrZV8P1j4KEtpt+cTnGAnAEBWEUQq3a7Et6bb3/06PEVTD2HewyUJWrEPKLgoz9DVMaQ9ExUBVLTief8n1NyNFoL2N8xmy26JCtcMg34cPo94tGYyLmwWFjLlVLaKgk4M45tI/1mZBmZglatN40KcqWG7irr8pqXlFIsnTURRZ1S7+exq3y8nc7Jrk6nl9XOXGQv0aMpjw5/VKyppPOzVcNQ8xFoVnmGKMGqLCOLWJUo5NytG4n071ZK/zuTHJy50Sl5PMWL5veoz+/VHTq48/9L8zhE8yv0Ja71WwEx3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(36756003)(2616005)(2906002)(41300700001)(83380400001)(186003)(26005)(6506007)(53546011)(5660300002)(8936002)(8676002)(31696002)(54906003)(110136005)(6486002)(66476007)(66556008)(66946007)(4326008)(6666004)(86362001)(478600001)(38100700002)(31686004)(316002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXd6YUQ2TVpDazc3K2JnWG44Z0tLcmRIL0g1bU5sSFFjWlRGV3V4Y0Q3Nlk0?=
 =?utf-8?B?TEV5bFpIS1NFblF4c0dHTmhzcENudnJxQkpGR00vSzRaQzR1c0tVa2dIa3lX?=
 =?utf-8?B?dzc5R3JCSHpUbmE2NEVzOWpNLzcxNlJYT2xHTmc2bkpYdFFtRWNoU0FDdFJB?=
 =?utf-8?B?QWR0U05mcjlGSEF3M3BGTnI0YmlYTFA2QUt1OHQzRWUvbmdsVnJkRGQ5RkJS?=
 =?utf-8?B?dDZFd0NqNDRTeTZYMVdBamdyUGp5YnNjd3NhWEdydVVvUHd1d1U5QWxlb3Rw?=
 =?utf-8?B?ZW9zalczRzRSZDhIYWZJNUN4OGlZUXMzTmVqSXEwbStaVlJqRUhYODdmZkJh?=
 =?utf-8?B?NmgrMUJsT0RqQWlad2h5TVpMcy9RZUdDNjFPUnFiNllOQVNhYXoxQ2lERlBO?=
 =?utf-8?B?RXRFUGpDQy92T3JCWU1haXhBNTRQcWVBYjczUzFNOFpYaDRlK1dFRFdCUzA0?=
 =?utf-8?B?aXdNN2w5anFPV0JtVVJlenY4ZVZXd1JSOHFhTXpBS3lTdmdCQlBMQlhWRVFq?=
 =?utf-8?B?VVA4cHpQL2trbUJ3OGtYb2NlWHRsYUFOSkVJVU40TG9qK2pXRmlDWkh5L2px?=
 =?utf-8?B?Zy91TnZ1T2paR0YwRk1keHRNYThCN2V6T01FVkdHRGh1WWVFRDdlcVFhTXJ2?=
 =?utf-8?B?eE9PNGhKdHBybWdOU1dPelVRRnhJQVAxYkVhU2IrSm5YWnFpaXNCU1o2RXkz?=
 =?utf-8?B?bSs4eit6U0pZWUh6NE5HdjdvRFQ1c0Qwb0lvYXo4N09iOC9idW1RdzlzR2dw?=
 =?utf-8?B?WmNQK3F6aVlZMWVPT0lQaVl6a3QvS0I3TlhLblorTVQvUjIxb0xuak5Va1RZ?=
 =?utf-8?B?UXhFZlZFRStLVXVncGozREhjbzRiSUxobUg3Wk1VS29SbndZTzNSY1Uvc3c5?=
 =?utf-8?B?ZkZmbGY0b1Z3TmpwbkFJazNvZVpuZTJkN1N6elY1Nmhxa2prZEVuWWJjYW9S?=
 =?utf-8?B?dFVzd3QwT0dlMCtPUklOSW16OGlWZnFMQTAzRDZLc29lejhaWkpnRmpENFM0?=
 =?utf-8?B?N0FUZUltV1hJUUY3YmZEUWUwbWVlRUt5Zm5UMVMzQUkxODc3ZDgxcG1ZQTIy?=
 =?utf-8?B?UnBYajdtL2ZtYlM5cWNpYVlUNTRPNjJWL2pkMml6Szhvb3F0TThXYVVTaytD?=
 =?utf-8?B?VFNnN0w3UmwxUTU3YU9pblV5RDJQcXRldEtCWHFCZllwbVBZUE55VEZWYVZH?=
 =?utf-8?B?REYrY25uWEl4YjVjNTN2aEpnclQrTUVGb29WT01STW8wSnJlRnFMc0R0dXQ3?=
 =?utf-8?B?bmxZS0IzcWo2R2ZkcDkwazhlaHppMlJremsxektzTGt2bzVraHlDM0pwaDNL?=
 =?utf-8?B?dE5INVoyTTNGNllBdFlSV2VOWEQ3VTR2b3hqZnZWTDlSUCtyNFpqeHhGWG1X?=
 =?utf-8?B?N2Y4VER4V3AvZWNhZENwdFVxV0tTQ1ZuSDF0MVpSRG1QTjI4aXZuOHhPYU9B?=
 =?utf-8?B?SkswTUVwRE50SEh1dEgycGVsTjZSa3NXalYxWnRwd0JHa3hheDZYL2oxQzgw?=
 =?utf-8?B?WXQ2RjdzYXBwcGYzNGdXN1dMR1BXNUpTdGhKZG9JNlR6S2pOTEwvVzRpOTd5?=
 =?utf-8?B?MlMxRlIvU0lpMXJsQkJYK3M1RyswRk1OeUpCakxkTnBXZWE3NmVlaEtySGdS?=
 =?utf-8?B?YjYwMGpGamVKVVpqWm9GNTlmMG9BMTVMd1lsYlpNQ3pETlJHZFdMSTV2dnQ0?=
 =?utf-8?B?b29OZ1lnK0xKNkp1bE9Ydy9QcFR5a1orSFVNa2QvVHlnSkNrLzhvbllyVkxG?=
 =?utf-8?B?SlU3WS9ITmM4MjJHdVBmM3BYOUgyM3oxaUl1SkpldlpQRzREamtjUWNjVm41?=
 =?utf-8?B?MTYycXMrL2JZT2Z3cUJHdUxaL01LbytXd2VVelltWmNkeG0ydVNaL0p0WE9v?=
 =?utf-8?B?dHBNdmVKMHZ6U3NhbDl4TGxReENMdHRRdERyWHpuM0tYenUxbThVTmxDUDN4?=
 =?utf-8?B?a1VCQjYrTmpkMm9pOUJHVE5sS0FDcUJ3a0dFYWw3TWJvdkVZSDJ2NjgrQ2s0?=
 =?utf-8?B?SVJlMWFQV2h2SEIvY0tKbVkzb1hRZGpVTGhCRm5NSTdSOXRCUkNiY2d6c3JD?=
 =?utf-8?B?QUJsQ2RaeDBoVG0wbUkrdzZ4aUp6NHErbUFQN0xHQ1ZydVFEeXpCUFBickUz?=
 =?utf-8?Q?tZdH7Z5QLWERenSAm2sOkoPR6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QoRsEmVzjNTfoyvG70iUcE9IzGbZ08hmII955LxPwPVTQJRyOKvkJy+Dh08Gpm8E6py9VPCfFfT+kxFW9QGcB2BqevY5L35RW602t+9nTNRd3/iEKkNU73Ux0zXDnb3vjJsk7DARU7mXz2bfFQ6zRYCvEYqOXqOHobkU7Xdi2fKnFBA92I68twz9lns77r1iZ2uCzDfZOYYRC2NRx8nrRVaRQDZYDO8poGuCdt1gC73S50eo9KbdvEqOeOOlNhCgRfns8DobEUDwr9ce61hOQFbXPzE/KOBU7HNknSh5BeekXrNPzLr+wUU6/nyriWZP6gpiIgCcW+frLXMjvs7uMkqKKHlWWOnHibo0E93PbTRvPcWGTRc/kBg4N7YnLr1YRH+i4HTEuW/eKkVp/E3RZdLcUbhfMo3Jl30LMtBrrWQsx0hNpLqPbSrLNzG812tGeo43IX/HalCgL+uZ09etoWIjb0ZwcdGYwxL25nlpXmNDnqdZtmS9N2zx72vhyLn9fMZZthbyHF8SvKm3jpCdut67Qv722kX37J/E/19tLht6OzRe0syHhbkdHEpMJx7npw7UrgWCJyVZd+/WrRUdBPr056IhgAqUgARcvOZaLfy4xbwR4rdgqcWI+rkPR2C0T+dR2XnKqQhI+C2vXSVQyo7ebt5r/e+k1il3zD5Q1CIUlo68IO/U/ViGAgXpCVd01QLx8iIXQVq2lYqdkIHmLyn7H3OYkY0VKo1H9mn5rCHPyFqLVUVZx4xJS4pvWf97E/eVrOc87mylskzmQFJhGLkWTEi2hAhV33mPUtr/iWsolLG4VYVrwOlNSAMbSjcOV3YJHSoKzmF0SiFHr9pJdN/rtWjvtwg/pw7Kqxt1hGUv3dyLrPc0HKohTmUdQndNgOrvyUApypI0KDYfRjIkVQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8023dd2a-db7a-498d-b5ba-08db82eb3b00
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 15:18:22.3990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2+MIodhJh/01wtwezhcIgdPfWJ51hXEFfziCeaSJtRyYN6GQ7/GtoO3i3q+nNiTAY3LarON0QxmFs29GEeosm0H2PGGXRbWXyzAg7C/Egc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120138
X-Proofpoint-GUID: XMtS1AuIE9vYSwAg5Hd16Ud1rY2km4oY
X-Proofpoint-ORIG-GUID: XMtS1AuIE9vYSwAg5Hd16Ud1rY2km4oY
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/23 13:49, Eric DeVolder wrote:
> 
> 
> On 7/10/23 17:15, Randy Dunlap wrote:
>>
>>
>> On 7/10/23 14:27, Eric DeVolder wrote:
>>>
>>>
>>> On 7/10/23 15:23, Eric DeVolder wrote:
>>>>
>>>>
>>>> On 7/10/23 15:11, Randy Dunlap wrote:
>>>>>
>>>>>
>>>>> On 7/9/23 18:38, Stephen Rothwell wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Changes since 20230707:
>>>>>>
>>>>>
>>>>> on s390:
>>>>>
>>>>> ../arch/s390/kernel/machine_kexec_file.c: In function 's390_verify_sig':
>>>>> ../arch/s390/kernel/machine_kexec_file.c:69:15: error: implicit declaration of function 
>>>>> 'verify_pkcs7_signature' [-Werror=implicit-function-declaration]
>>>>>      69 |         ret = verify_pkcs7_signature(kernel, kernel_len,
>>>>>         |               ^~~~~~~~~~~~~~~~~~~~~~
>>>>> cc1: some warnings being treated as errors
>>>>>
>>>>>
>>>>> Full randconfig file is attached.
>>>>>
>>>>
>>>> Randy,
>>>> Thanks for this. This appears to be randconfig testing against linux-next.
>>>> As of right now, linux-next does not contain the v5 that I posted friday.
>>>> The v5 posted friday was picked up by Andrew and over the weekend no fails
>>>> discovered, and the series currently sits in mm-everything branch. So hopefully
>>>> it will appear soon in linux-next!
>>>>
>>>> Let me know if I misunderstand the situation.
>>>> Thanks!
>>>> eric
>>>
>>> Well the root cause is a missing SYSTEM_DATA_VERIFICATION. This was discussed
>>> through MODULE_SIG_FORMAT thread. I don't think v5 changed anything with
>>> respect to this issue, so it will likely reveal itself again.
>>>
>>> Since it was agreed to drop MODULE_SIG_FORMAT, and my attempt to select
>>> SYSTEM_DATA_VERIFICATION results in same circular dependency as with
>>> MODULE_SIG_FORMAT, I'm unsure how to proceed.
>>>
>>> The arch/s390/Kconfig S390 option has a 'select KEXEC' (but not KEXEC_FILE),
>>> maybe we consider adding a 'select SYSTEM_DATA_VERIFICATION' as well?
>>
>> Sure, since some other configs select it also.
>> And as long as it doesn't cause a circular dependency problem.
>>
>> thanks.
> 
> Randy, all,
> I did the following for s390 and it "works", but I don't think we can use it.
> 
> Changed:
> 
> config ARCH_SUPPORTS_KEXEC_FILE
>      def_bool CRYPTO && CRYPTO_SHA256 && CRYPTO_SHA256_S390
> 
> to:
> 
> config ARCH_SELECTS_KEXEC_FILE
>          def_bool y
>          depends on KEXEC_FILE
>          select CRYPTO
>          select CRYPTO_SHA256
>          select CRYPTO_SHA256_S390
>          select SYSTEM_DATA_VERIFICATION
> 
> and this essentially passes my regression but for the following:
> 
> FAIL olddefconfig arch/s390/configs/defconfig
> LHSB {'CONFIG_CRYPTO_SHA256_S390': 'm'}
> RHSB {'CONFIG_CRYPTO_SHA256_S390': 'y'}
> 
> which simply means that the CRYPTO_SHA256_S390 is always built-in, whereas previously
> it could be a module. This happens because 'select' is always =y; overwrites if
> previously =m, as was the case with this particular config file.
> 
> I still don't know how to close this gap. Today I see linux-next has v5 in it.
> eric
> 
> 
Alright, I found the solution; somewhat obvious now that I see it.

The current s390/Kconfig for KEXEC_SIG looks like:

config KEXEC_SIG
     bool "Verify kernel signature during kexec_file_load() syscall"
     depends on KEXEC_FILE && MODULE_SIG_FORMAT
     help

and this caused issues with my original conversion. I now have the conversion as:

config ARCH_SUPPORTS_KEXEC_SIG
     def_bool MODULE_SIG_FORMAT

(where previously it was simply def_bool y). This works and passes all my regressions
as well as the reported fail here.

And it makes perfect sense, now.

I'll be posting v6 shortly.
Thanks,
eric
