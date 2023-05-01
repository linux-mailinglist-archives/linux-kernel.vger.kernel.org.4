Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876826F30E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjEAMaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjEAM35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:29:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105B31AC;
        Mon,  1 May 2023 05:29:57 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3413N1h1025889;
        Mon, 1 May 2023 12:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qym70Y++p9/0E0u/T2/wvmTxkMaQn9P5lN6RqkOokDk=;
 b=RQSpPdmvvptxRWYhqB6aLr5vpFqchnrONx/EcEqAQcKIjadct75lPig06x+p33y30XHu
 xs0feykvdPiuf/+fR90yw3MgEFcVdRaXo2qXnqLZLtmPm0tJXzmBFhyujU5A/wwBU1ZW
 Oc3GkJbVcY5fpcDZwfuCa0v2HX2cqK66ml+P2DDNGZxf/pTOTp7hE58aMrWWBip5uClg
 2hfiJE7S6id6hBK4oe6ZMmyFm0HnmEfs5peYa1mPE4ooM7AHuGtvY67pgDBg68ulEYMo
 lP3w1AfJCp6MbEL2ddlJnSLWBsHBcfaaEWhlF4VGOFD//csjtXxR8iOaSk92645Rkc9+ Dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9ct96u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 12:29:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 341CGsdb003246;
        Mon, 1 May 2023 12:29:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp4n4pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 12:29:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQes16GWpCQB7IpwCwZcg984g2G13cES9RMPfgbHZnaoJksws0oRhx5qAZLfPHHam/6309epmmAQ8xv4yRDW8YU8OzpZq2P+xB/vO9KWV3NSuGE5Y/gSc0qSeJG7QQRJOLB6fzke22kgqGxYi/ViFfHOL2oiae17cwD+n7fcsahN8heWJ7IUDMTq/RInk1o/HepFRbZ1rN/Y9bTAXExI1h+cJYQI6E0o8JxuwHhlnE0wzUt3rYjOK/x6Qxrem9Kj6svU4kqlm/KHPNd+Q2ujbYsIC2T+VG7m5QpY9yTJazfLXyRBBvLEzNkIvyecETxMSNjdF29YWsktGP9u81wDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qym70Y++p9/0E0u/T2/wvmTxkMaQn9P5lN6RqkOokDk=;
 b=F/J9FNkXtEYeyEyOMeb2Rruj9twdIu3YMUs6ncUHVfRsSijDHkd3Ee6M0KgSMM40+XsMEk5M+6VpDOOnjwuYHV1wz4QI3oN//1GDjY6aHC/Z/DfbNLp6P1wyVldarwbQOaHg9E14TdhoF5z9NQS2USlcPIpnXkRJQ7h6qG3ZFFh2DutZNQnny6M2cV7Rz0iMRTQjXYh1a/8tkkK89Bhra5kjji2KqAMfpCOmmZ/gKMnCvebWK5fEKOk+hU/IH2vZEzlY1gEZh1xYrUfytFEGXR0pUMeuQp66UJJ99I1dJIuqxLhkyzTtFSahMfBHvASZ48KivS85v+4zzBVGlRg//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qym70Y++p9/0E0u/T2/wvmTxkMaQn9P5lN6RqkOokDk=;
 b=wbxRq5Lmpb1IHpbzW3YLi6aip/vmhuF/dx+F/Zv1+clISQpS4oCkeZXKCgYW4p+eaz2VV4L3r4hcsRDi25PodKw/b50wvAKaEiP0yP1UtNeksxuhsFqew70E0DU0C39/QR7HcBQEPxtbeJjbkn8tiz9cjgn3DxQMktFlTEDuBhg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7029.namprd10.prod.outlook.com (2603:10b6:806:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 12:29:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 12:29:36 +0000
Message-ID: <003f07ce-1aff-ebae-60a7-1cb47c564ea1@oracle.com>
Date:   Mon, 1 May 2023 13:29:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/5] perf jevents: Add support for Yitian 710 DDR PMU
 aliasing
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1682329456-19418-5-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1682329456-19418-5-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0165.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 89015404-0e8b-4b05-011a-08db4a3fb99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWNGGETd3aSV7Y97KmasMVPsgMIUbhUhUpNbvCSoAE7+zczmRKsHg4kTH/7B/+HRti25IKhz/pwB+ArTnk3nQnUi389s9WjeIqxhHCs0FTAHmcqPZ0LMHDCW6l2EidncoA3Yj0gMQoRo1Lu2+sEY92TqkKtubAMnWBj65+0EMY54zX/H/WfB6JVpan1al31YQa9HjnMwP6hcVlFZY5AjkVwVNZvGIrIyMJ6yD/weKz6TQwgD6T/IkdHsxsGo+uqxjEDoKNxaZSf1ZhVFm7DtVOTtxhxuvi5dcQFL2RnFbYs4guYrghYPLKp++7mfRS6IzWgPRKBYEcEQU9Cf9Al6D3LWAQ/f3re+bo00oUucSMkYuoWN1c9BHLMKB3FBLhp1pmZix7Ax6EyRVEmE1MjkuCZLreqjrnhnTrn3jWl8AIIfqtXwIYd2kBdenvprHvWtL3jX8QRtpT1rZsSiNUiAmBomkCIMYFyfvTh4ajmw+O9KY/u1ZrPVpMHtUX1m5POsJQDA5k1NjTrSl3pWPkSrWld1/462Knae7Cgbdrm3t2+y3UZg0+te+dSO3/pR8kBcnALXBWWkNuaQ0EDucG1+ocmxC/MFhyxwmB7IWkYTJjXDAGdnmyH5wtWh1XvzAw0Vx0bHk6YSUqKKvcICn5z5wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(86362001)(36756003)(558084003)(31696002)(38100700002)(8676002)(7416002)(5660300002)(66946007)(66476007)(66556008)(4326008)(8936002)(316002)(41300700001)(2906002)(2616005)(6666004)(36916002)(6486002)(110136005)(54906003)(478600001)(26005)(186003)(6506007)(53546011)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHUySFZLUEl6RlZCVm5SRnRydkE1S2JaNVNPd2lIaURCY0FNYk5SNDVKZ01N?=
 =?utf-8?B?aXoySnlMV3JHQ2lqRUFLYjh0ZlB4WnZza3oxZ2I0UnhpZ3IxU1RjaWZkMXBm?=
 =?utf-8?B?SXFvVlFrK3FaMnhZYTMvZHhnd3hPY2FwOE1WUDRVSXpOZ0VTVGd0SVE2WTFD?=
 =?utf-8?B?c0J4ZGdXV1JUNCtlYWJBQmt3ZFhRVTUvQVlvWFFaMzlGS01RT1dLT2VUQ2Jq?=
 =?utf-8?B?S2ZXZEQwR05lTWs4TVBRbmpMRy80SnQzUDJONlBjemFMNDV6TkFiVDF6bGIw?=
 =?utf-8?B?ODA2ZDdGaGZhQWVqNkIxYmZyV0Vndk9aM2U0dDVmdDFzTEtTeUpwZlIyVmYr?=
 =?utf-8?B?YU4za0ttUkRWUnhFZU9pbHZXSlBZYlJZNjg0VVJGbSs0WlMzRC9EZ3pMNlI4?=
 =?utf-8?B?Rnd2dUN0VDlyYkpieUl5NndjWEs0aDcyTkdORDh6c2FBc1JwWWpCaVRMMmVW?=
 =?utf-8?B?ZnpEVjl1ekZ3eTJINDNDcU81YXlOcjkzNWJtN1Y4OTc2d3ZwWUZaV1dsT0VW?=
 =?utf-8?B?Q2VHcUxRc2w1aEs5SVo1YVQyR2xWSjl0NDUrNlJKY3NDaUZLNWU1S1hSaktR?=
 =?utf-8?B?dDRQOUVUWUtMWUVMWnFmb1EyaHY4Q0M3cVlBeHNLMHJuYXgvTDR2anpOL2VW?=
 =?utf-8?B?clIxM2Fqc3lnaHdEQ01ndWtHTk1BR3JINEJiWHBkRi9jTWdHMlhpaVZkNVhm?=
 =?utf-8?B?NnYrajJJaVNjWUJJdHMyclg2VS9UbkV4US8rTTlXTFNia0JSdGdRUUpWVXRz?=
 =?utf-8?B?NkFXWTFFWDloS1BNMUd6bHVMZFdGM25ueHNmYXBwL1p2dEZHa0p6c3lLOVkv?=
 =?utf-8?B?VW94QnJEeEovRHhlZy9mOTNiT0RvT2F1TFcvZGY0VHpsYzEyM09jQ1lScTdw?=
 =?utf-8?B?QWZKZTZ0bUh6dHFwMXg0UHRBTUZsKy85NThHb2x6L3MzYi9MZzNwWGtQcGY4?=
 =?utf-8?B?M2Rzd2VRRUF1TStianl6RUd5Ym9ydWlXMnFFb2hzYXAzazdqNDAzZlZ1V1BR?=
 =?utf-8?B?RHJrVEF0YWkyRTNuNEFpUHlPRTZodmRUZE8vcVdLcjNzSGVzaHRiRzlyUDhR?=
 =?utf-8?B?QWFvMVdEYS9qc21qTkFMOVpXbFg4SktzQnZIMnhYU053YnR5WDBJdVJZYUVU?=
 =?utf-8?B?cnpVa1JLeUw3MitEZUk4MVFoQ1d2T2M2ZERObEdvVWlDVXpVVkxiNTFqVldG?=
 =?utf-8?B?UU9pNkJ6c0ZDSUNOd1gxazltLy85Szl6R2VKK3FVTFZyTlZudXFLWE5kMHY4?=
 =?utf-8?B?VzZwWEpaMlpSL1ozcG95Q0ZJaURjSnRXdytBQ3BHaHk4dTd1dkJWQjJJWUtq?=
 =?utf-8?B?YkYvcVk1eExTQ0w0aFg0UDA4VFRsK2NNZ2FKa3pLdGpqMkpLTWtKT2pEVzJu?=
 =?utf-8?B?TE9SSDd3a3RjdTk3ejVhM2VkYnU3eEtLTkJxNGF5RHdvems0ejVwQnFwakxo?=
 =?utf-8?B?eWl5RURpUlByVytrc25Jc1gzNGtpdWZYb05BUkJnbmhmYVArbXNKQVZ2Y2o3?=
 =?utf-8?B?Vzc3NzVsWVJqQ0htRVFyY1lDZUg0MCt6UDcxS3poSnNRNUtHNmFXUVdRVVpu?=
 =?utf-8?B?YzMvL0VLY0RDTDFYb0FHNWErTmNReXIyd0xpK3VTcGcxTkpUK01NVitRV25X?=
 =?utf-8?B?bnVzMDZCS3BUblU0ckg4Zi9yNW9Od3ZEcVVvYmZPTjJ6TDlyVVl1Mll5Nk5N?=
 =?utf-8?B?enBnYUs3RnBEYkJEYVgyM0FVS0o3blFMR0p1a2NORWRvY2Q0UFdoQ1ZMdlZN?=
 =?utf-8?B?SmZWN0ZLd1ZCT1FwY29FY05TTjNCT2N6dnpTTXE5MFFMeitZWWFnYmV5Y0Qw?=
 =?utf-8?B?ZXRZdGRRWmNTR01sN2phK2VYbHFvZWRxdFE2SWhFbUc3UFBvS1JjLzN6b05N?=
 =?utf-8?B?VEZ1NTlmR2JRQVRnZUtxU21BYndLcXpZalN0Wk43MzhwMWk3dnYwbWs2T01i?=
 =?utf-8?B?MzhnUzZIdnpxU0JNM055S2NEK0lNS1MyblpIL2FodEtnRWt5ZzVpVzZtRDRG?=
 =?utf-8?B?dHZ2dWlSZXF4K2RhWkhDQ1poZ3RvSmgySUpFeG1ndWpFOFhTcUt5ZldoMm5L?=
 =?utf-8?B?ZVVid2FGVERmTHVneElpK0sxMXJXUkk1bDh0YU1scjVSVUl5aHEyR2ppS0wx?=
 =?utf-8?Q?KuNQiDVoAxsxZbNFa/S1fnBMy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WWlGaGh5T0tyNk1HODVoK2R1NU9FbVN6dEZhRWoxSHdaRjdOdU1tYXBqNTdS?=
 =?utf-8?B?b3ROQjZXdzd6dFBjdnlYR1UvR3ZGbW03c1NPUzdXeVZVMDBlZGczSWY5b3hF?=
 =?utf-8?B?QWU0elFWaE45WWdzYU02VUxDU29ic1o5cWlMRnY1RFQ4MXpsS3h3QkMxVklV?=
 =?utf-8?B?SnlhZU1YMHQxKzE0enJRMWJTTjc4VGtjRzIvTktmazYwM2hMTUFMb2cyRUpo?=
 =?utf-8?B?QXJIeTY1eG9CbGxENjZvclhSaEl3ZENPK1FBR08rb0srV2Jrem53UjRqZjFm?=
 =?utf-8?B?cGxINVpkeStaNFhyV2k0WkQrc0g4UkRtMnhWTVFtUjJEY1FjTFpiTHJuUEFK?=
 =?utf-8?B?LzhBYVhyVDdTeWs3d2NoNWM1WlpaeVpibnlhRzF4ZVR3VUlBYzFhSUJUMDk4?=
 =?utf-8?B?WlNPZ0luRkkzQnRwRmk2UkV4NkU0bURyb1lQVUwyeWtzUWZuazA3SE1SekV4?=
 =?utf-8?B?WmhzbDFyY1l2cVNBeGtRbk1zUFVnVmtwUW0xZTFvM0wwaTJ6Z1crU1BNcGw3?=
 =?utf-8?B?TjhrSnhrajVJaW54SlJlSG9VVmxia1czbThIVGY3OUErOU9SbGxReG9MWkhU?=
 =?utf-8?B?MTJHWG1NQmkySmlvQ0pWSnZqZXptSUMwNkFSTkhhZWtSWnk2bk5FT3JSTUNX?=
 =?utf-8?B?NHcyZVdSaG9nOG5HdEEvSkNqdWx6eklIUU1uc2tWZysyS05FWi9Tb1ZidlFs?=
 =?utf-8?B?VktES0xzV2RJWHhHQ1FyNXJic0xzY2FzNzVMTzNBanl4Ty9HbXQ5Y2dQN2x1?=
 =?utf-8?B?STJYWCttSXZkZ1hzbUlXbDFnRlZYdStLSkRKSkU3K1JzOGxiZmRKS2lhcDkv?=
 =?utf-8?B?bmlnN3d3akZxVzY0OWFhS0lWeEpKSm8wU0FVM3JVTXJsZTVyai9UNUx4dEhF?=
 =?utf-8?B?OVRwclBiU0hJeko1UHRDVWZkYWRxN2tNRmhpUlRJQXlMMzcyd0JpRS9qQnRn?=
 =?utf-8?B?a0NSTVVPWmY1c01ESEZwRkNpcHMxOWJoTnRNN1Z4UlN6ckdVSlhUTmR0LzhY?=
 =?utf-8?B?QkE1MEdQUVNyb2l5TTc0QW5UaXI3b2hid3dKcm5HMW1wc25WVjJkbWh0a2t3?=
 =?utf-8?B?Zk1UYmgvVytOK2VZMDRaeVBKNmxhQTVOTmtCbG4xc211UXRHcDZ3RzJreW9o?=
 =?utf-8?B?b1RuR3l2YThxK21NSnN5M0E5RFh4VjlFUVBoZ2EzTFdybVRSZEJEL0RnSnFx?=
 =?utf-8?B?Qk53WkpRY0pKWml2bXFIblc1L3ZTbVdjanc4TkRxR21zYzdMbmNGcm5pSHpC?=
 =?utf-8?B?TzlHTk1qT0kzZnBLUWIxdGhmbDMra1pJMzVYcVZ4QnJ3enIyNlRxaGFxeGs3?=
 =?utf-8?B?L1JxazJWTnVvaitseG96d3dwRDZtNEMrQTBCbk9RSnpSV29BeXI0VmZQRGxw?=
 =?utf-8?B?RWxYNkxxSytid3p3QTE0Z3JYQTM5b3BiRDRHQzdvMnR6ZHg3STlHMUVpWVFV?=
 =?utf-8?B?ODQzTWNFRWlLS1l3MS9pZHErRWoyYVNVdWZDQlpaYithMDNHVG9Fd1hVaUZV?=
 =?utf-8?Q?Ys0Yps=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89015404-0e8b-4b05-011a-08db4a3fb99a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 12:29:36.2281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vI0HJOh7WGHF4s4aj7yvmIo/xCZM613DSVkA0lZP+YJbLjImYyy3+lO0proWUZLXXTV/mqiprnE2MZuEP5Rjwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7029
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_06,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010099
X-Proofpoint-GUID: blhiFA66ERbxL-k_VADOimkkz-eUXt6E
X-Proofpoint-ORIG-GUID: blhiFA66ERbxL-k_VADOimkkz-eUXt6E
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 10:44, Jing Zhang wrote:
> Add support for T-HEAD Yitian 710 SoC DDR PMU aliasing.
> 
> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>


Reviewed-by: John Garry <john.g.garry@oracle.com>
