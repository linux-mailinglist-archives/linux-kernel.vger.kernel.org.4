Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDC3739E14
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjFVKLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjFVKLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:11:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06340DD;
        Thu, 22 Jun 2023 03:11:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M7plq1015048;
        Thu, 22 Jun 2023 10:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FMeSZoYSizp9u2PfklBnvyUkw62p9yDriWN6rllXbP0=;
 b=Y9cIEjv+dpxCxDGSOi31Q8EnDs1W9Vfs808lHeOgKSheou35i2IJx7XQJdvB0hc3BhZw
 BRrRo/xrpVyh6QYWChkbP8yUvFefYjYjZ5ZXG/ak2XtQfTjlOCM3WzdaC7hgxqHPI/bx
 jrAkQLx7LLZ2Ss4NrM95no6b4Mep8CWLZ7D12XEgvGLcELrtU2jq5jnFgJCRy9but3/7
 81NxoWF0VTt8xFo0lbnmPcFffWxUmnPER9ueZjnDgVsw00oj8qvj2yghNNDjGIqMKuyY
 4wIi90B7ojekt979HuHK2CAswH/rrS6CZwxc3bc8nCSjJBkgSq7PH5ZnwM6pWPXou0Z/ Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dsfk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 10:11:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35M9oA11038573;
        Thu, 22 Jun 2023 10:11:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9397aed4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 10:11:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/sHaUNYqk6Do0RunVErGQJni+LzWoEERuvpriZrUWSZqhAgK8NVZWAhi5BlC9fJnCLxda5KajQhaXig4Ci+MQtvjTvvNZIma/Ecg5Az4bBj45AfWVYYC3mLbKQ2Q2QcfaE4J5j5jTUBfG7DVUGoYml9QHD26o9N4vrKRx5IiuKblEVYNwZlRC4txXHbfXrR6AOVwHFSc72HSW3RzqDRlm0AyHbWyTPo5bo9QX5lt+u89xEsK45A96JQ2gWkmfBeyuA7r3w5pQXC2fXzbstZOGPD3pqYuecT1p4KJdXKkXyo4GYyOiFcFqQHVq2JdKNLWO+K7yukYziv4mevl/KAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMeSZoYSizp9u2PfklBnvyUkw62p9yDriWN6rllXbP0=;
 b=JxeXyDAgn14CfSAAP3RQ50jU79k4HH4Us9qy1lRzpZ6oh0uU5M/cVpnYoQXBkQ+itgbYVg5rEwm3LPMjuiDt2y7D//lSIbYnz6l305a/ekSvvfNoL/aH2RLdya3VxurcKkBoz5i8kSH5c1Jlp8y3QPdJMZO9RXVgGU5MqO3whu02ZTKsjjun5rFL/e+Jd6kXA29elqF7MzPJ5jMSN7n9YWzffOKKz2ZtqU1U3UonE/NFH1/ZxuOrF418GoeOAmBckAgGkSWgQ6lPQaS5aE33dPOndfJa405jXP5LPx3OF5VxWlquNY/NwJKgQUO25GQylw/a+sfOEfCZpCLh4GTTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMeSZoYSizp9u2PfklBnvyUkw62p9yDriWN6rllXbP0=;
 b=JoUIN6sj7skGR9wsARsrYsS6ioxvJRgiRxriUYAtEhYfa1G11D1xEZYOaCmGJPdnrk8wV5OuTdpSa+Zif791ksxTY0nLtLPWk4kZBsk9tKOs95A29lFb0q4yCsLZqvEuU352FRxbYmovBvXdjLH646XAkrOJyRAJMkinwujk2CY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 10:11:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 10:11:19 +0000
Message-ID: <cd12d1ee-cc40-3d6c-3e7c-72723b548786@oracle.com>
Date:   Thu, 22 Jun 2023 11:11:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] perf vendor events arm64: Add AmpereOne core pmu events
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
References: <20230427223220.1068356-1-ilkka@os.amperecomputing.com>
 <76bb2e47-ce44-76ae-838e-53279047084d@oracle.com>
 <e8ad583-9650-2ad5-5447-a95ac9fb686a@os.amperecomputing.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <e8ad583-9650-2ad5-5447-a95ac9fb686a@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f44691b-bcad-4b07-b258-08db73090603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DtMQJIjeuNkWgJjsF+MyCc4ELRQlCc/DONHBVrjTp7DFt4/w5GcaYBQYzHTW1E0SjowMlPpSCo/aXMKrZoLl0FJj8zPn9objbKfmvoy8EylXCCQOtnkc6pDrQ4hHc0mvOUraUhEx24rsOHJ2h1LGXrk87Kv0UO+rf/mPpti/r9ie5Brmcld9vWnYEe7yC4ABA1ccUiOMDdEKrZ9pZ67eU3qP7t8eLlKUppfp+CLXgPgYBllDqphQUbBZEr91DYbUgCwJaRYPhQvxLovy8bUJAmEyreo++Ymmy2dC80uf2Y7/IBYsK40vpnxrHIr7zkgvXm8i/r+OHuqdaQrg37doAogl5WmXLOhodycg8vIn6CdePbopE7jwEfCb4QvNoZeoUf+YRyoUXC398FKWQ7hggTY4gJDHgGkva87pQu/IpXzsgGzcvwrzTj/Yh2LRO/bEqnB8m0FH7NrfzVQWnpqFGis9KXdtxZHInuJjFl8rzfhaUIDp6aWG+1TnVqsDaxL8dXUDjBx9bdze6PYjSztK5vb6KlIwhzoAs2GZ4Mdz9O0Yt1kx2MON3ElJZSIsxhqS5pzEhVKWaB8eJHkvfEf+S0+9WlFnPj2sNflZmx+2Ug8TZt/vqI1StOAWeyRAadGW+LMAgIPqsg9v8w9nqvRkAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199021)(6666004)(478600001)(36916002)(53546011)(83380400001)(5660300002)(6506007)(6486002)(110136005)(54906003)(6636002)(31686004)(66946007)(4326008)(8676002)(41300700001)(66556008)(66476007)(8936002)(4744005)(7416002)(2906002)(36756003)(186003)(26005)(6512007)(38100700002)(316002)(2616005)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHMwa1RsMDMyYkZERzl1aW43WHVGc2VXa3l1aEdpRHR4R1NMMGN2OGtDblBs?=
 =?utf-8?B?RjZwTDBVOXVZRUovWEw2dThBcmVjamdqZjJJcytoSUNwT3pRcENEWnN2NkhK?=
 =?utf-8?B?WEhYRTMvTy9vSTBlcFB3aTNNNjlSc1R0WU1OUDhHWlM2M0gydWhzTGtIbFVz?=
 =?utf-8?B?ZEFPcHo2QlVJSm9CMU1HQlR4TDlVM1BSL0dWcDNVY2ZKZ3hnNHdIY1QyQ0M4?=
 =?utf-8?B?cWZ3UlBTa3pwUnVGcm5uTEU3Rlc5RzBTdTdkb1MybCtNVnZJbG50L0h3aURj?=
 =?utf-8?B?eUxNSks3c1BwNGlJUkZIalpsRkVESXhRay9hbVZmS21HUU9SL0RQWlVxaUJp?=
 =?utf-8?B?QTNIQzFBaEZIZ0xaYjgrbExEbms4Rlh1bXdpR1VvSHc4ODhOaHR1Uk5UR2pn?=
 =?utf-8?B?T1VTbGlPRDBMVFFvcktHM1psRVRHb2JPbmFkclFwSWhZa1RwZU9lU1lWbXJY?=
 =?utf-8?B?Nkc4eDJzbzJncEE2NGkzODNuOGlsNnE5L0pNSWxGWkVCemNLYUY3VzlFYmFs?=
 =?utf-8?B?ampHckhRbXlZQnZqNEEwYk84OCtwc1NlVlJzeWh2WGlzYTdIamJubmg3Y3hk?=
 =?utf-8?B?bW1ZeXVLZXZGdkdzN1JHWkk0dllqRTRiampGRGV5SHRwNVpHYSs5VmduNTBk?=
 =?utf-8?B?WTVuVWk1SVZDSFFRVG9ZcDMrVDhQRkE5TVB3RG5yKzdMOXZqRkRoRUtDTVp2?=
 =?utf-8?B?Z3BLNDRua244KzdOSE5rSlhyVjY4aVpWVjV6MUs2aThBSFZLV2VUUXI2eGgx?=
 =?utf-8?B?RWtTd2Z0enpXNTFJOTIrRkFEMEdBSkM3cjVtYk9PeXY5eFpVdExSa2RMMjlK?=
 =?utf-8?B?Z3B1MWh1ODljNUxTMEFMaWt5d043RmR4ZTBGdjBWcUdKOUdHSi9saVhMekNi?=
 =?utf-8?B?bVRUckFFNVlnWUJMY0RTaXg0aXNKalo5VmcvNHZPMjZZaDcvTDJoRnl1b2Zv?=
 =?utf-8?B?QjZ1RDFXczJKUktKZHdCeHZYYk9Ha1YzQnBrc2EwSFZ6dkw2VGpFUXdTQVNO?=
 =?utf-8?B?Q3pOMWc4di9yVXFyWGtxeXlpZ1dsY0JDTVQxcERXQ3JvL2k2QkRtNkRkTit2?=
 =?utf-8?B?Y2Zzck4yL1AwdG1EdUZSNzZrOEdlQWxlVnVidGJEUGJ3d3lVeE9UNWpoa2ZV?=
 =?utf-8?B?Z0xoUXhITnNNc2Y2d3JuMVowL2RJblBaQVZ1WThGVVhKWXpEalFnbkxnUGp1?=
 =?utf-8?B?YThWTEt1NVNpVmxqcTgvbk5uZldQZDdSN3NWbnU0aC80YmN2VTBlTkhsdndh?=
 =?utf-8?B?cFlMWlJtTkVSL2lXbzdWZWliVWZlQUZ2cEVpWUxSVERqSGxseGdXQ1JXMU5H?=
 =?utf-8?B?OU02b2J1dloxL2xLWEx0MUd0aGxDNmxGZk1zSjI4dHdHYlFPT2hNRlg3NEo3?=
 =?utf-8?B?KyszYmtPRTdDSDY1aHpLRk4rd1FWL2hhZlhzVVIwWWM0amdaTE91WG9IM3VC?=
 =?utf-8?B?R3F4MDZUSU84VFpPZFV6WEJ6SGV5L0grMHB2Q1dCaHpEcDJIR3BHbWxMSml1?=
 =?utf-8?B?elJoK0JQNC9zVE9CNkhJRmZmN0twTFlYdktTZzhEN0VlQzIrZUlCeXV6L0pH?=
 =?utf-8?B?dmpuWTY4Z2JHSUFhclJ5cXVEZ0JsRmo5bXRHZ0p5UUkveDRsYjE1OTM5eTA5?=
 =?utf-8?B?eTN6SE44QW9obEJZdHhVSFpyb0F4ZjU4MFhVSlUzQXBnQjAwUzkwMUFlNGZW?=
 =?utf-8?B?dHFDMkZLZVRQY3RtQ2MrUXMwVVVPS2RNY2VmQ1FNZ3RHenJ4dFB5NWQ2ZC9u?=
 =?utf-8?B?dFFWMlZEUklUMTlOL0ltQTcxajlwT0Y1WmRMSWFkS1lpcWJhbHZLcHVXa2cr?=
 =?utf-8?B?T3E0dGVkSXZhcjgrbGVUbytRUUNMeVhsNnNuRGJFaW9zamlIUk4vdnRyWFJ2?=
 =?utf-8?B?a1hEelRxNTB4QmJZUG42NDNKZ3NaSkt5dzFOaVkzS3JReS9zQnQ3VjkvSXNm?=
 =?utf-8?B?emxLWWtlblFVeFp4aGdYeG9zM1Erd21hclE1V3NyWXlXdTJRNTVUKytSS003?=
 =?utf-8?B?dy9zb0FCQW92MGtyZWJFRksrU1BoNUF0cTVUM1I1SUtVdElWeE9UUUFXZ0xJ?=
 =?utf-8?B?dDZqL1ZicHcrYWlpNUI0YzNLdDBVUWhNUU13czJpQi9WVDdESVNaV1pNZno4?=
 =?utf-8?Q?VAvJrCRd0SW5K1ZCDUQnZkvSY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U0lQb2lVcFBPTTA1eXJrbmFKd0t3MUd3SEJSZzkvclJwMGFNVXVuamRTbGVF?=
 =?utf-8?B?NXcyT1d1b1VycmtFL3BpV2Jmc25WbEh6a1kzUHkzVzdFVHJ5L3JIQy9JWnRG?=
 =?utf-8?B?ZjJpYkxMV1dRTFc1bE9ydk9wTDZWbTU0a3g2WkdJMlc0RmU5eGhoNVRHZGhF?=
 =?utf-8?B?cFhnVlJUSUdicDFlRnBSaGdNN2pXTERtL2NISVh3Rm1ZYmpMVTZBRDFWYTE3?=
 =?utf-8?B?MUJZVmVSeHArNjRKZzNoaDVxRGcydlBSWGNLenJNRDFuQ3ZudzZnc1Ard3ZD?=
 =?utf-8?B?Q0Z5RzFxc3Uwei8wdVVFdW5xaC9kSGUzZ3N2NVRmVmJ4cnZpOHEvRlh0Q1o0?=
 =?utf-8?B?OXY0YzU2RzVhZlJXTEdPZGZ4clpHUGNtVFQwaitkOGZHZkltMFdNR1J2VmJE?=
 =?utf-8?B?NzM0RmtITGphbmcxdEljeHpYU09pZ2s1Y1VWcXQ4ZEJrWWdUNHduZDR5bnZ2?=
 =?utf-8?B?OWhxdVdKa2FLaEtrUDd2N2F3amVBRTlJL0VXZlFST294TmlPdmtwQjJGNkFk?=
 =?utf-8?B?VmpNVlhaT3lCUjkzcytRdjdvbDVoVnRDOHVzdm5DMTFPaGZadHBHTmZVbHhZ?=
 =?utf-8?B?RjUyeGd5YWxERU5RbzkreFNGOU0yczc2Skw4MmJtenVWNTllK0hOZ0swckd5?=
 =?utf-8?B?ajlPckZJdm9GY1F2K05sWlFoMEQ1Mmx0L2JGalNEWkhaOExwQzMwdmdBSUxs?=
 =?utf-8?B?eFprV1ZiM1ZRYkJiWlRoamY4SUx2SmlQeXpkWlJGNitvaXhac215VXZrVzBR?=
 =?utf-8?B?SzZ5ZUo1RkFPdmFuTUF2UjdXKzl3VXF3NEdoM01pVXkxNkdnRjJXSkg5QVlV?=
 =?utf-8?B?S1FWUWhVNC9hcGlYZTQ4S28vNjk4c3dxdTFxODl6VnF5WFZndXI4cTNIZzJ4?=
 =?utf-8?B?L05JbDl2MVhiWnRNcUR6Snl1SzRycis2QVZVSFJ6dUtJT3luckdtWlVsc3Zw?=
 =?utf-8?B?b0p4SW1ZbjVWbFBkL3R1dkhGSlFKRDZQUzgzMnIrdExXN0gzbDJxYXMwMmxQ?=
 =?utf-8?B?QlVFUm5Fc2dzcmxkVVI5WEd3SzVzTGtsMkNEdGZNRHN2V2JpMzc3a2VNYkQ3?=
 =?utf-8?B?QWZubHI4RzRTaUpkT3E4S25iYTI3ZkRCTUhyRXJWTFcvS25qRlZVRmJ6VlpZ?=
 =?utf-8?B?ZUZpVGxCZkRPMlRkWm1WOElMNnVQMWJMK1BSMXcxeW03SWdIbi84dE55b0xC?=
 =?utf-8?B?UDhNcmpOWlJ3RTN1OWRiUWpCdkgxMVgvZkxRdGdFbUN3WnNaVGIrQmN6cmw3?=
 =?utf-8?B?YVh4NzBLekJUMTZGRTlma2llMUM2QllLdEFiYW9QbFBVZUZCZzdLOG1KZ2VW?=
 =?utf-8?B?ZmNydHFpbnRPRUFRTHRKb3NJS21Pc05GaUQvTldXcWw0d3JSMmpyQnIrTlR2?=
 =?utf-8?B?dHJoNHI1K2N0UGpqRDVOaWl4ZXpBYW83SS9mZ3J3UXpsOHAvdERmWS9EU3Br?=
 =?utf-8?B?Zm9qamNONFY2RUpadzFiNjhhWExYV2EveGlPNHI4c0s2SGp5ZXRaK1dBNGtU?=
 =?utf-8?Q?s8GkgWlc1Ns0rGw8MG7dbZsH1tl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f44691b-bcad-4b07-b258-08db73090603
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 10:11:19.8789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwJpDlFuFlFYeXQj3M8jxih85bTiIcAUNPbLHpeyKYGwkVhRMfqiNgLbX0OITHwg6rZxL1FUzCC2I3/yoj6KoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_06,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220085
X-Proofpoint-GUID: RGeAAxepojblPpouoWR30IwwZAGvFlhk
X-Proofpoint-ORIG-GUID: RGeAAxepojblPpouoWR30IwwZAGvFlhk
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 04:27, Ilkka Koskinen wrote:
>>>
>>> +        "ArchStdEvent": "L1D_CACHE_LMISS_RD"
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE_LMISS"
>>
>> L1D_CACHE_LMISS is not defined anywhere.
> 
> 
> Good catch! I must have thought the python script would at least print a 
> warning of missing event as I compared the build logs with and without 
> the patch. I can prepare a fix for this and submit with another couple 
> of patches. I'm hoping to be able to do that by the beginning of next week.

Hi Ilkka,

Previously the generation of pmu-events.c would fail for a failed event 
fixup, like what we have here. So were you going to re-introduce this 
feature to fail the generation of pmu-events.c for this? It was not 
clear to me which patches you were going to prepare.

Thanks,
John

