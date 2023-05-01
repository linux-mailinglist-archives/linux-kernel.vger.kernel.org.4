Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29F46F30DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjEAM2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjEAM2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:28:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9181703;
        Mon,  1 May 2023 05:28:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33UMnjOf029281;
        Mon, 1 May 2023 12:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ZCAo55p7IsTBQIH/NBHjCA/3qku3FfIala3Cdhoi7KE=;
 b=u2wKVcBGFW5Igjxdq2WTYkcZay4YEpfu4RpOL92HVBA5MvJAwuqrMRIktnlIlYFCXz3C
 iGo1zFe5HYuRiGEugPqaNUjaDWL8OZMRp47QJjs0nEjc8V2YSI71QDncTJ44LUDma3Nj
 Y/+DK08QxvoW5iYhwb1W1JzcS5PXMMUSpLlVL4zr748yxsnbQMRJbnjM2N9CaW9HTUTc
 6LqTPw4LoXJO3zcOqhMU8mnpf+i+P9S1tMpnAPppsgb/U/5Dth2NBSKT4B6Ktn7uj1i+
 VT4cs7+1At3zcE65nsN3SZz9mpzVvuQeAxh67/pumslJugCZaQScHvrI3iOMFCU+lUKr MA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1ja14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 12:27:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 341B2QXU013763;
        Mon, 1 May 2023 12:27:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp4wm6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 12:27:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIVPuW5+iFdHdcgTCab+5Ee0bp8suvXgDXM79V02PNCQHk013LX07IplQAko+Tbj9Jc1Wo0utwfGQI3fC1bC/8yLxuXxRF6ThMmxpANAWL07Bel6r0hdDB0L75C+tXtsHIcR9kYx0GLbpF2bYAwVuvlBkzuxWIDc6l+7/iiHsW87OOAV2N0VC7gpv9BPx8mPBIjh4D7aEO4m+XXl0AiSH6kyl/99g6sj06egPd6bwgMrFqKXLsTk2kB8eMzEf85HKK5uxOT+KU72wZUzCMaSUgG0SDevfxw5Px2DN2Gjq3/ovKSN8K8J7e00yLRg13BspMla1WI0ctjkUifwnl3rTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCAo55p7IsTBQIH/NBHjCA/3qku3FfIala3Cdhoi7KE=;
 b=NlGu/iy2HmRlMMT8aIt1Ztn2Fp1ZjIic9Ulx9clb3jWExzXLVWU4h66CKZ4tujoEstW6nFsHzLtMyuwmpxbeuYPYRC4SLaHd0n1/Omm+5iUJM99sIc8IRIM3lIyzKnMEuthgcwQzfZXm06Ea64urvicW7kQHQ/+IvMxx4bzWkcd7ABTFymI9rqdR7fl9QwfcVg6k9YPqRnUccEkZNIY01/743G/NimowopeAAPHkoyfKeCxzD/jq1P+g04sL+lGdhzLe/rK3yHk0sgbKWJcrXeWV7yS2RL9ksyJn+ZAiDVXbyTvB5IjS8j2uNVIiehB2e4Ejxh2afzaEKpaf6WK0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCAo55p7IsTBQIH/NBHjCA/3qku3FfIala3Cdhoi7KE=;
 b=VUFWeSdkcO1cr4Bud+cNGAOdEfZhCtBr43ouhapuUhMjvNbe0LNcOJO8GYZR0amsHdRzs6HCIuJCj/qAJ6cra6K6Tbj1P0L86TnIW9L7iTpHWOT7ikpC5XmLfnEtZcLnVFND8LoQRcNbPGS1nB2FO9wBHCF73Ujlg+Mn/nIbEMM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7029.namprd10.prod.outlook.com (2603:10b6:806:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 12:27:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 12:27:37 +0000
Message-ID: <75c36607-9cdd-42fe-b3f3-bb049b3eb223@oracle.com>
Date:   Mon, 1 May 2023 13:27:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/5] perf vendor events: Add JSON metrics for CMN-700
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
 <1682329456-19418-3-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1682329456-19418-3-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0c13cf-298b-4384-9600-08db4a3f72c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxU6ogwFIjb2DuCZoAL/0N9hAIopVUcvPOwWUmrnRZvEnow2lnngtH/Rq63BcLWY6Ee26nWpA7exfMWSY18InIc9mygb7fTC793vmAxvvsgQ36QqP9e3YfE15ISbPYMr1YcDUsA4w/u787mmoDfofAP77iopjI0WDDl39mAVn4/kN3BLC5wM4elL7yhEHogbjDtdMh54Kf55X99uKlgH/Vv2M0qxv5a9frs7CpcJ45px+uI/dEYLJmA8q1Ni+/u5qXjjjjfWUqASgso/lHFhrYAdfyK+toNEngCGy8RAI/DTivWxOdwqQRKJWX8IlsIXkk8xF1WuA1NQhASGiXeZZItXw4L0Gs9uUi64O4AG+3G/51q/sl1UQZrrNX9NEzkL8pUggEQxvJqhNPa9BnkFNagd2mjyVcCY8x6fpiRpIKxo3re+3J55vf0DMoieIB+nu92jBCoyjwKlpzDdaRRG9gQ/5k8CasLbxPbpB+H0cBPwx+MMBSsxRlKT6BRLxNfxNXabgygRF+Uaf6GJmrEC4vcktY/DVxfxMyxDC6tDqMNg0kXQ/iaV9NHdwa/tYaOZmwqHwfnQm6aWlED1n0nzdTXtarwleRfqR5mL9anEtaxan1Y/9kR4aYazGbULxPVRt3gAta3OlvzcFhxtQ7qWjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(86362001)(36756003)(31696002)(38100700002)(8676002)(7416002)(5660300002)(66946007)(66476007)(66556008)(4326008)(8936002)(316002)(41300700001)(2906002)(83380400001)(2616005)(6666004)(36916002)(6486002)(110136005)(54906003)(478600001)(26005)(186003)(6506007)(53546011)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eng2VE01UnNhRzRMOEllN1VIU010KzBXV0VqMVlYc3dYME1vRFduSG1Nekhx?=
 =?utf-8?B?WDg5V2dkVVh2SktKc2VXN3FJdEFTVXJGcHh5enZ5ZWkvckhCS2g2TFZUb0tN?=
 =?utf-8?B?VmR1R3BaMEl5eElPUmxDNGIraUxEb3N4Q2lMQ293M1laN1RHYTRzQm50czlC?=
 =?utf-8?B?TSsyQWJiY0RHTC83T0FaelFVV2k2MjU4bWEyR3RTZWxUNk1hb3VqUzVLNHh4?=
 =?utf-8?B?VFZIRnFvMTB6QmxjNExkM01yeERhNmpWTHFBQ0ZaSmRtOGttMVo5Y0d3VW95?=
 =?utf-8?B?MEI3UU0zVk1GQkNsclhNWWN5Vmo2WmhXUkxYQkxCWUloY3lRcEhGSmdzcGow?=
 =?utf-8?B?UFJhb1pScFhJa3l6dmZpV2YyeldpaE1pdUhLYnpBUU9NaXRVSUlqS2daNEtt?=
 =?utf-8?B?RkthUlN0UjFITTJVaVhFcVNEOWRUdklmaUNKYUhqcytvRE5CMVN6V0swS3lX?=
 =?utf-8?B?cjNKczJzbUJoY0NVUzN0MWM2M1FCOGhRaXZWcmI4aWc3aG1aRVdBM012eG5K?=
 =?utf-8?B?dU1xdTV5VnlaL2FNVTE3VmovbG1MaXVPYkJ0LzYwbEFvcFJrWVBmbVlNU3VP?=
 =?utf-8?B?eFJYcWY5ZTJiZG5XUk1oaXpUOVNPYU55d21VU0MwTUdZVEZBdENvSUVPc2lJ?=
 =?utf-8?B?dHM3L1orZVRLSHVwSHJYOHA1UGxXRGNIVUhDZ0Q2ZWM5a1JmOWdCWHNnQlBx?=
 =?utf-8?B?RVBIY08yMi9nTk1QUkltcXNQNDgxQmtWenpGUGVHNkw0VGcyaWhQRUw0VjFr?=
 =?utf-8?B?bnY5MXZHT2ozQUp3amczdXFYRjdTVnRFbGlHcE5kdjlQOXliQjdvSTRBL0R0?=
 =?utf-8?B?bFVubmxoL1ludjBvcEhDVlN1cTBDTThwTEZabWlQWDIwTHBIbzNWbUpkcllM?=
 =?utf-8?B?TkwwRlJHdUVZd0VnaGZGNlpGQzYwaDFGaUg0UDFnSDVrOXZ1WnVoemRpODNR?=
 =?utf-8?B?NnA2MzBoeThjMTBlRVhQUmVLUUQ3eW5wRmp3akxsWCtTYk1uT3ZCMlY4NUtE?=
 =?utf-8?B?OUQxZ2FNWnRSek5yM2JxaXJRdW5DUExSeHBBazVQcEFvaERoRFV2OUw0d1RK?=
 =?utf-8?B?NGNrcWMyVTd0THRqaHQ5amNYUDJiS1ZzeDdaT1A3L2k3MEVSS1VieTVHZ2M3?=
 =?utf-8?B?WjltVWszNkFLWUVjeDFNN0xBdi9SdXhDQlVKQlU0bEIvN0ZYNmlvNXk4eUdL?=
 =?utf-8?B?eFNRZGhXQjFQajZOTTZERjBRajBwZW4wNUdtMW9KcFJpcGpXUDM5R2NRNTlN?=
 =?utf-8?B?Q3pDd0hVS2NidFF2YmlGQkdxZThaRFhHdmdoL1oxR2VVeDlGdzU3eEVWaVdo?=
 =?utf-8?B?ZEhFaGk3YjYvelN0QzQ5cVVsdXlOYXpiazFpRWlKaG9teGk5UGdTMDdLY3Y2?=
 =?utf-8?B?YkZQcURYaE9Jbm4zeDJoMkRvSXRxdFpFVUsxVDdGSVdYU2MzaFhmdlJWVzc4?=
 =?utf-8?B?RkoyVThZM3NIWm1jSTNWMFVXVGIrNTRMSXhkWHdKZC8ydDVzd2lSaGNTb3BX?=
 =?utf-8?B?UVZSZ3hMMEMyWktUQnNtY3Z2cGVVVEFBcXRPU0lCTUM0V2xERGk0VnNKM2V1?=
 =?utf-8?B?NTJCVjRSb2VXMTdVem5ubWNwZzBPMDFSS0h0dEFNeDRPS3FBY2Z1b1JlUlNv?=
 =?utf-8?B?VUJYcWlKOE1LVm54aTRSR2UvK3BFNlBGaFNKaVdtNlNrbGt1MXRzbjNLRW5B?=
 =?utf-8?B?dzV4Q1NFNU5hK1ptQUJGK24xUTNOaithRVJPYVpFalZmR3JBaXBwTWE4WlhE?=
 =?utf-8?B?V3NNQStKZEwreDlabGh0ckF3ZGZPSHVlUkJWUldiOG92RTBjbnh2ZzBtKy8r?=
 =?utf-8?B?QkZSODlVUUVsK1EveDFXQUtLeVFNZTNOWVczNUZCUjBHZ2VMQWR0dHk2R2tH?=
 =?utf-8?B?b1Y1TlRjZHAwY0c3dnAzOUgyNVE1ZlI1VDROQi83Y0FEVk81aXlzOTlqc2Zu?=
 =?utf-8?B?SUQ0bEkwT251V25icUFhNUNneHkxYWZIRDQ0Y0FtVGpIaDM5OCtWdU5zM29U?=
 =?utf-8?B?Z1ZLQlVVLzd4WnhwMnRyTk9rby9RK0tCU2JMSlNoQ0dCaHEvU090cFJuczQy?=
 =?utf-8?B?bTYrdlRXaFBTSkFDWTRMV2hUeE1mcHJuRm15L0ZXajl4djdvZERFSG81YXNP?=
 =?utf-8?Q?aKFcawSAZ1xJHWiVdux1I5KjQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a0ppeWhnVUVVRGtuVGFsQ01mWkVzamt4VG5FVnYrZUVEY2E4UzZOZkpaVGg3?=
 =?utf-8?B?K1VPOU55eUdPRWhUblVxRmhRa3hVVGFERlVEY2dtOU5pdWpwVGxWVmkrTDBJ?=
 =?utf-8?B?YUxHM2FaM0lEY1o0YWc1eHliNllpeksya2dITnphbHo1VitvWGVJT1JFc25w?=
 =?utf-8?B?bjVsd1lSREdrVXlZTUtuQ0U2b3JzWnA5WDU0MEI4L1BKUmN6dDlUNVBaeFhG?=
 =?utf-8?B?Qk5YUzN0MkNGL2FyNTFtNkY3STZoMGpIMDA2QmNEQ3FYanZJVUU0dUNvRkpR?=
 =?utf-8?B?Y2NVTWcxdnlHWXZHMU9nQktkTkRocXpRL0d4UFNZZGtpODMzQVRpTTF5ZDN2?=
 =?utf-8?B?SmRwU3FSLy9WOFlaSFhHU1B0ekdKVXp0aFZlbHNrOVBsM2hXVy9zYlhTYnNk?=
 =?utf-8?B?Y0FPeDJoV0toRThkQzA0WU4zNGxGNDd4MUlvQXFuUjZBZmU2ZkJBQUJwMGVn?=
 =?utf-8?B?MFVidjBZODRDbnVaRGVrSW1KckNmVFpLTG13T2RKaVBOMEhZaFJPVll4SC9Z?=
 =?utf-8?B?b3RRRloxQVh6NXlFMEY3ZWRrbmZteHAvenBlY2JKVjlnWlhIR0hiSHhkV2s0?=
 =?utf-8?B?ZW1sNDI4VE0vOXdtZEluVEo5UFhOdlRDbnphR290ZmFDNG1FbWl2VDJJRHhV?=
 =?utf-8?B?RE56YTNVem9DanN4UFBsQnMrc3huWFo4Y0l6Tk9nNGZ2YjZZU2NENjNwUk5i?=
 =?utf-8?B?cTVyWE4wR1FEZE1rRmpNT3ZsQWIzSkRqSmdBazZRallyWkVTUGhGR2hqUVJ4?=
 =?utf-8?B?VjdtWDI3UjhxOFpIVmwwTmZyZlliUWRwaXRnQ1Z3cEFLWnpPNDFBS0VwQTE4?=
 =?utf-8?B?ak5rekFNcVF5YS82dkdTaVJYNEwrYk9lM2hUa1VrVm0yejNOaTFNeGFHeE9K?=
 =?utf-8?B?S2hMenhrdTV1SEo0YXFiQnpkOEdPVkE4bloyS2xmMjdRd3FIRzV5ZU9MejdN?=
 =?utf-8?B?cXMzbUk3elQzZjZoMFhvbzI3M3cwM3NLb1FrTzhKVFpYWVVaNlFkZjJpT3N2?=
 =?utf-8?B?N25EN3ByYjRITTZkRkxkNkJBQW5FNHozRmRFZi85U2xxK0dqRFBjakw1YU12?=
 =?utf-8?B?RkZ4d0ZlWjFhNnhYekYveDRja1ZkczlxUXZ4dTFQeW9UTmtZcHo4aXYxQzY0?=
 =?utf-8?B?VVZ4dmFwQVROL3NsWEtSZ1JEOXVrVnJnTXJrR0ZtUXRPSEtDMEx2Ylk4UC9n?=
 =?utf-8?B?Y1l6NGk5cUNOczd2NnNRMnh5ckIyOUY5cDNac2FWS2R3UTRQUWwwU09OVVVD?=
 =?utf-8?B?M2ZaZVpYTjlscXRIVmRtVTBmRHgrVHZ2VVFjSjN0N0RUTGtSUmNocmt0UUNy?=
 =?utf-8?B?UnhuU1FTUk9RL3VMZ3NMMkZjNU90NHVjcHN6eGhkelZkbm5BZ3pxRWlFZFN6?=
 =?utf-8?B?d28yYzFxaGQzVFhUbEhnNUh2S0M4WDNEQzRrN2JMeFhIQkZiZUNDZUo1clc0?=
 =?utf-8?B?bGc0ZUkrKzFFbjkxM1NWRVJmWGhSU0tuM1B3V2hsdEVuN1VrWVR6MFJmMERw?=
 =?utf-8?Q?2hblSM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0c13cf-298b-4384-9600-08db4a3f72c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 12:27:37.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeLzNupZxPy+8veqFSa2FSv5C+lkXyxCqiSNSeMwJa5m48kcv76mHozh5Rkh0YMwSoSIsfKUTBdBREuNgo4AIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7029
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_06,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305010099
X-Proofpoint-GUID: x6jZ7YzxCn4BOhk9zmUA8cyys8bUH9DQ
X-Proofpoint-ORIG-GUID: x6jZ7YzxCn4BOhk9zmUA8cyys8bUH9DQ
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
> Add JSON metrics for CMN-700. Currently just add part of CMN-700 PMU
> metrics which are general and compatible for any SoC.
> 
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>   .../arch/arm64/arm/cmn700/sys/metrics.json         | 74 ++++++++++++++++++++++
>   tools/perf/pmu-events/jevents.py                   |  1 +
>   2 files changed, 75 insertions(+)
>   create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metrics.json
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metrics.json
> new file mode 100644
> index 0000000..1577d86
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metrics.json

I suppose putting these here is ok. Are all these events a must for a 
CMN-700 implementation? Is there potential for impdef event in some 
implementations?

Previously we considered ARM PMCG events would be put in a per-SoC sys 
folder only (and not in perf/pmu-events/arch/arm64/arm)

> @@ -0,0 +1,74 @@
> +[
> +	{
> +		"MetricName": "slc_miss_rate",
> +		"BriefDescription": "The system level cache miss rate include.",
> +		"MetricGroup": "cmn700",
> +		"MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
> +		"ScaleUnit": "100%",
> +		"Unit": "arm_cmn",
> +		"Compat": "cmn700"
> +	},
> +	{
> +		"MetricName": "hnf_message_retry_rate",
> +		"BriefDescription": "HN-F message retry rate indicates whether a lack of credits is causing the bottlenecks.",
> +		"MetricGroup": "cmn700",
> +		"MetricExpr": "hnf_pocq_retry / hnf_pocq_reqs_recvd",
> +		"ScaleUnit": "100%",
> +		"Unit": "arm_cmn",
> +		"Compat": "cmn700"
> +	},
> +	{
> +		"MetricName": "sf_hit_rate",
> +		"BriefDescription": "Snoop filter hit rate can be used to measure the Snoop Filter efficiency.",
> +		"MetricGroup": "cmn700",
> +		"MetricExpr": "hnf_sf_hit / hnf_slc_sf_cache_access",
> +		"ScaleUnit": "100%",
> +		"Unit": "arm_cmn",
> +		"Compat": "cmn700"
> +	},
> +	{
> +		"MetricName": "mc_message_retry_rate",
> +		"BriefDescription": "The memory controller request retries rate indicates whether the memory controller is the bottleneck.",
> +		"MetricGroup": "cmn700",
> +		"MetricExpr": "hnf_mc_retries / hnf_mc_reqs",
> +		"ScaleUnit": "100%",
> +		"Unit": "arm_cmn",
> +		"Compat": "cmn700"
> +	},
> +	{
> +		"MetricName": "rni_actual_read_bandwidth.all",
> +		"BriefDescription": "This event measure the actual bandwidth(MB/sec) that RN-I bridge sends to the interconnect.",
> +		"MetricGroup": "cmn700",
> +		"MetricExpr": "rnid_rxdat_flits * 32 / 1e6 / duration_time",
> +		"ScaleUnit": "1MB/s",
> +		"Unit": "arm_cmn",
> +		"Compat": "cmn700"
> +	},
> +	{
> +		"MetricName": "rni_actual_write_bandwidth.all",
> +		"BriefDescription": "This event measures the actual write bandwidth(MB/sec) at RN-I bridges.",
> +		"MetricGroup": "cmn700",
> +		"MetricExpr": "rnid_txdat_flits * 32 / 1e6 / duration_time",
> +		"ScaleUnit": "1MB/s",
> +		"Unit": "arm_cmn",
> +		"Compat": "cmn700"
> +	},
> +	{
> +		"MetricName": "rni_retry_rate",
> +		"BriefDescription": "RN-I bridge retry rate indicates whether the memory controller is the bottleneck.",
> +		"MetricGroup": "cmn700",
> +		"MetricExpr": "rnid_txreq_flits_retried / rnid_txreq_flits_total",
> +		"ScaleUnit": "100%",
> +		"Unit": "arm_cmn",
> +		"Compat": "cmn700"
> +	},
> +	{
> +		"MetricName": "sbsx_actual_write_bandwidth.all",
> +		"BriefDescription": "sbsx actual write bandwidth(MB/sec).",
> +		"MetricGroup": "cmn700",
> +		"MetricExpr": "sbsx_txdat_flitv * 32 / 1e6 / duration_time",
> +		"ScaleUnit": "1MB/s",
> +		"Unit": "arm_cmn",
> +		"Compat": "cmn700"
> +	}
> +]
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 2bcd07c..7cff2c6 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -256,6 +256,7 @@ class JsonEvent:
>             'DFPMC': 'amd_df',
>             'cpu_core': 'cpu_core',
>             'cpu_atom': 'cpu_atom',
> +          'arm_cmn': 'arm_cmn',
>         }
>         return table[unit] if unit in table else f'uncore_{unit.lower()}'
>   

