Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4DC6F420C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjEBK4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjEBK4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:56:16 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B3610F9;
        Tue,  2 May 2023 03:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGWLTqDk+2PTxIDLr2Dj4uvir0xHr4xj81tW/r19K4dPkhxQXwAyrNtAqg02VbOT3Q+DxE4QBaYA6yzU6W5tyxcsULtIgilea53Rge8FjC7metSvEpAoNYyMYk14Wmo534NDzACdPMVT+HQYqlbNFy+V3wCx24cxe1cxbWunDr+CHlno93DT8s1z1wuYkgsTNYcwspluB1qTrettLxehYMWLD+KDa29vEr0KZPZlBHl9vxwZpai5WAukhQhw5k2Wih/Z3i8I31nVf2pRJb2aCnQUOLDIu92Kk9aFFBMpMt3vVgT49+zkHdYViO4PzbxEsAFM/s9hlhBH1QjUF6owew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa0ZMX+ZqObQLpax97eQsxJyWp+62KNwOzkMua0w2QU=;
 b=JD6P4lA21yRBS/nc9vUQGcDSyAX4pnwI3TKMmvcHrUN1cVUE3qCWUFVNXlbw6ZcoF3dCXTHnMF6OZWXCyyLMCojfVrHBZk6lvlhE+z6byQEHXPoMRgTP1DqJ8wowjHb8xO/VR6to5+05196XgT+onzgYPLeAA6o23smE9SZ1r2x/AWBUkrJH8j/d9bimt/X8V1XV+NqATKInoJghNgfZtPP9KIM8HlaTaursH6RZUVlgMU8e34WQY4rXAgQOeg3XlW/m8XswI82AWT2OLAAwTtRbinvJS7DtOEeuP4U7rDIyJNGwjzdi60d2Ru98L7rKhIuezsgkD+u/VIyV0ldllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa0ZMX+ZqObQLpax97eQsxJyWp+62KNwOzkMua0w2QU=;
 b=yZRFcbi5HhQqsCguox8aWTZmZkVPIihDhiUojj4N0U1z/ve6WjYeT03XZm4uk6Wyxr4ZKq3YvYT9voqoBzuJUIiKSNLa4C27nHUR1igUqdesvpAFo5b2zxLqttieRkDySbJ+cZL5qzb0uDKhxi8Ty3W/PPAkHWXIJwZ+L/LNBmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Tue, 2 May
 2023 10:56:12 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%7]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 10:56:12 +0000
Message-ID: <91b218e9-1650-a032-3b23-be6134c33e4f@amd.com>
Date:   Tue, 2 May 2023 16:25:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 35/46] perf parse-events: Support hardware events as
 terms
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230429053506.1962559-1-irogers@google.com>
 <20230429053506.1962559-36-irogers@google.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230429053506.1962559-36-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2fb9be-fb28-4f50-d4b3-08db4afbd74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: caQqY0+gD0/WMDjZB934Vw8oJIuWO6AzVn2xLcXIw6d3Wao8ZdE2zk2YoKP+XNasyG0ASHQ+OxxSRweaS6+7pNz/zQFvQW6WqU7wdbW4yPXk7hseihBIzNGAcESmCeresnMWcj6w6wAK5XGLaKgS1R+fBQdV+4vWHAEeYHr2qNsIt7qKTE2Qw1L5jSLrSgk/waqPgIfMzOyixMXTTYlsx8Lgg7Y/hLZw+rIf9G3oMNIGmRlvpbPYSgV4esE3PafPylj7RYo01USBXP5hTg5B3JgDrdEa4CzMWdmgbMPxnDK+pi5K4iLBEEsrxLePN+Jw6rvfm7TYxUF62OPSKxhCfhD+U2X+tDvVMmoadNOCqBPjcphHK9fvkP19MYrDRPsN3rYnjToLjXnlMp1DHo3ZM3h/IVtj4U34yDQF50g7s6+DoYeZ7bjBkrIIfQ2Ui6gd6xjAcsRUpqUoZnYCh/lrRgYyBgsrBdII0B+rn6HGr2U+qX+2QF7SyChrsZscjfBMIBTkP9lgR1z9Usu2xbeWopa/FPaKV2jhoq8JMiy3okiazQNS2Qd1tQ5XGyU9qKieKIM9g3JS2PIPjsV4HH+CvYlAzFnhSk33BRlLUOlEAvZRKiHJryqv+fXZGYG38U6hFmXOnyv8nVThfjJ2kfoGzgOwgDPF0nHz1f/W0ovO06s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199021)(38100700002)(2906002)(41300700001)(8936002)(8676002)(921005)(7416002)(7406005)(44832011)(5660300002)(36756003)(31696002)(86362001)(31686004)(2616005)(6486002)(6666004)(478600001)(26005)(6512007)(6506007)(186003)(316002)(66476007)(66556008)(83380400001)(66946007)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnRMV1FXVWcyUytMM0NLVmMxTlFFREFZRWc3NU9PL0FpaEdTcjA2bkZkTGt1?=
 =?utf-8?B?YUFqL2x6NUZLVTdTR2lMOERDWnJmVnBPMS83enovL24zOEQ0YmZLNXROakNu?=
 =?utf-8?B?ZVd6VVNac2hzK2hDZGJGUmJQUXEzd2RGZkR1V2JmTWlGVjhmcmFmdHE1T1NO?=
 =?utf-8?B?Ry85QkRjNVN6K3dvN2hTdjUzNmJxQXhuRmRpT1dZNmFNTmg5K0pvaGZKSUdU?=
 =?utf-8?B?L3kybW1ScVpHY0tsU2ZpQzRYd1huTVdFdXVaanhTb01qcEwwbXBpRlYyMzAw?=
 =?utf-8?B?QmNzQzkwbDlnM2Z0a2tqcWFJVU1BZDd2K1BQbE41dkpjNThSS2JtSy9hN2hB?=
 =?utf-8?B?clZCakovYmg2MjRpQkIrTEsyeE5uckVUb0U0OGtMSFgwY1NBVERhS0lkaDha?=
 =?utf-8?B?ei9PTHkvNU53emVQVFJMMWlZb09jL0YwSWd1MVczdDZNSnBpL2hnTGdCRWJS?=
 =?utf-8?B?TlBTanp3S1lGWStzUndCNU9wUlFQcFJSM0pkbm1qVTJUQTcwamIxRW82Zmd3?=
 =?utf-8?B?RE5saXFBd2tVczFtdkJjZHVoMWtQbnE4NDlESDd2UXBpRmNTRzNFazJpdm84?=
 =?utf-8?B?dUVqUzhaMTRFR2JBaTRTMW82bW12QmdBVU53VWJGK1lBd3hLZ0RTQVRQdkxK?=
 =?utf-8?B?Qk1LTC9oUnF0bFlqUmNJazVxMjB4NGl3TXNtZU9nSVZsUUhYRFZoVjcrNnp2?=
 =?utf-8?B?QUJOZFBSckJYcm03NXpuNzg3T1FkeDFVbjkrVmJQR2hyTGlZbklBb1FJcVNs?=
 =?utf-8?B?eFcyTEFVbDJtWlJ4UHVPa2lNZmIvVG5iRzhFYWl6QiswelZnRlN3ZSt6TlR3?=
 =?utf-8?B?ZlNPYkRwbnNlc1Zsdm92OU5ON0djN1VtTCtSMW84dHRia1NaVm9CM21mKzJM?=
 =?utf-8?B?M1B3aGNvRmpMQkY4VjlZVXEwQTBqdit2eERVRStDRlhYaVpMLzZ1K1d3MmJ6?=
 =?utf-8?B?UGc4Y2d4Wlo2VU1JcWhrcUJhUDNUeWZJVjR2aFJHdHZiNVkwL1dmdFBidXAx?=
 =?utf-8?B?RVljeWpzVitFbEZKdnZqUW1VYVlKSFpkVmtlUVVLaitENDlnd2VTUUREUHRB?=
 =?utf-8?B?ZzlsblZsM1h5OTIyWGt3U05kbmVBMENBR0NTVitPVUdZYktQSU9OVGtwV0ZW?=
 =?utf-8?B?YWxjOG1aSVJjaHRhSmc2Qi94UTEyQ3NkU0FSR3ZQT2Z2cll5K2pUbnpEYUFs?=
 =?utf-8?B?d0YyVGVucmxoeGJiNUtMclB4Z3pCWUFlRXRmdGRSUFFJdkFHOFhMZDBXUnNZ?=
 =?utf-8?B?S2JWQzIybCs3a2pld2VqZHIwdTZraWpwM0dKS2pvMDlEMFl5c2UzcUlrR2xN?=
 =?utf-8?B?RUtBY1BQaG9GVkRJQ0FVOUlwSkRTK2x5M2FaUWVBQWdMdDl4QjZFRGdlOFI5?=
 =?utf-8?B?OHN6TXU3dDNLVUJuU0xXL21OdUxsZ0RFZ1RUVWxBbWw4N0QyOUxKbjJEaHUv?=
 =?utf-8?B?Vy81aHdXS0pGdGk0bkZVbHBOd0FxS2pwUEdrb2JDZjRVZXNtOWM2STd3NFEw?=
 =?utf-8?B?TUE5dXJUKzQ3bFZVU3ZBMGRJL2JkMms4SXZ6alk3blUreERmR3A5MlEvSmhE?=
 =?utf-8?B?SHJCclg4ZllWNit6QUVaeHJueUJGQllGanI3WVRPcXZKMXIxQWVobFVRVmRQ?=
 =?utf-8?B?WlI5L2ZFOGNsLy9qTUN6RWhvSWlrYzhlUE94b2ttYmUwY0Q4R2FJWlBzSTIv?=
 =?utf-8?B?YzJsUXgxMG5QYnppYkc3aTQ5SlY0Nlc5VzVxajJGZ0hleU1GTTlUK2RhYmpO?=
 =?utf-8?B?UUpqRjFSQi8rMG1tZlJkZEg2TksxL09qTElJVStvOXJVMHJwdjZadWlHM0w2?=
 =?utf-8?B?Vk1SVWNzUGY2YmFWZnl5VlUzQmlwZFQzTkNoWXN2c0FaN04zZUszcURmYkRy?=
 =?utf-8?B?emtSSlVKbkRRdGpMaFJTREtrM2RDd1BOY1F2cjY0dExzdjlsY01raTRUS01G?=
 =?utf-8?B?R2MzYjdONzRhZWcyUnkzanB6SEVsWGVQN1AwUU9LNnJ6eTNOeUF6bktESHZr?=
 =?utf-8?B?YlhDdGZudUg5L1BJcW9mWm1YRFBZUElucmcydlNxaVYyVnFnSkxrOXhPZ3Mz?=
 =?utf-8?B?cExoZDJraGVBWGxuemVBNldwWTZReW44NzgzWWhDWnRFSWJJSStwSXpRVk1h?=
 =?utf-8?Q?yGgGgXIXsW99Vu1VAx/UdXcyk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2fb9be-fb28-4f50-d4b3-08db4afbd74e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 10:56:11.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rP2AFRmUtyQctlF6rNlEQYO0ZOvs8eg9THK7lTXwSwmERBcvdAUx+vP6ECXxFQmXqYpYEXD0E/6uXZ/RtfaQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -269,6 +279,16 @@ percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
>  aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
>  aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
>  metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
> +cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
> +stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
> +stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> +instructions					{ return hw_term(yyscanner, PERF_COUNT_HW_INSTRUCTIONS); }
> +cache-references				{ return hw_term(yyscanner, PERF_COUNT_HW_CACHE_REFERENCES); }
> +cache-misses					{ return hw_term(yyscanner, PERF_COUNT_HW_CACHE_MISSES); }
> +branch-instructions|branches			{ return hw_term(yyscanner, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
> +branch-misses					{ return hw_term(yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
> +bus-cycles					{ return hw_term(yyscanner, PERF_COUNT_HW_BUS_CYCLES); }
> +ref-cycles					{ return hw_term(yyscanner, PERF_COUNT_HW_REF_CPU_CYCLES); }

These are generic terms and thus can be added to _any_ pmus. Ex:

Before:
```
$ sudo ./perf stat -e amd_l3/cycles/ -C 0 -- sleep 1
event syntax error: 'amd_l3/cycles/'
                            \___ unknown term 'cycles' for pmu 'amd_l3'
```

After:
```
$ sudo ./perf stat -e amd_l3/cycles/ -C 0 -vv -- sleep 1
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  size                             136
  config                           0xb00000000
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
Warning:
amd_l3/cycles/ event is not supported by the kernel.
failed to read counter amd_l3/cycles/

 Performance counter stats for 'CPU(s) 0':

   <not supported>      amd_l3/cycles/

       1.059391819 seconds time elapsed
```

Here `type=0` which means perf is trying to open event on HW pmu instead
of amd_l3//. `config` is 0xb00000000 where 0xb is amd_l3 pmu type:

$ cat /sys/bus/event_source/devices/amd_l3/type
11

Not sure if this is expected behavior.
