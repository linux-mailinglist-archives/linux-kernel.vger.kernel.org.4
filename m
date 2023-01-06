Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878D76603CE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjAFP7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjAFP7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:59:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6668A43E7C;
        Fri,  6 Jan 2023 07:59:46 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306AONxU015008;
        Fri, 6 Jan 2023 15:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zxGrFdZgxzLlE+Wy16KrcTPkwV3lhfxBf0MP+hSfmTU=;
 b=dtp/wwE44utfgvH/pT2JhJsJj61dGUMYeslNHVJj/eDXefCVil7lTX9t2MlL6p74/vIY
 h7EZzV7pRPxSslDdnhqxg1v3+iDKCr6EooeLRzj9lrHsfjXjiMtyWhuj+tb9PZ2VXX/u
 Xo5ln0RiKcrMJd6I3a6vezBl0QYFcRCWi9W+DMaRSel2no0O/M63sjfFLfJ0CqX0P/pK
 dEef85x2F0F3ckFM5BUtISPhtvZADcj2blELgXG59o63F2pfjXOO+kBfJnvp9YEBu4YL
 hgsVAsB6rOd4yF0b10aBqtjp3mdIQFgL8dWX46CFnOnESgr62x2PSv3DRoVwoU4HddMx Tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp13fec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 15:59:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 306EbuAj032559;
        Fri, 6 Jan 2023 15:59:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwft17nf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 15:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IC9peHsAkmH+5Tii3SH20GiB824v4C8ohLabzJaCki0i2Npj0WZLVIeUFhMjdMHMLLqQIG0EwOOrDkizlZZzvAEFIqP3/X3yW+jPSHttOohu8bgeaPbQjpudDxQoCE0dlhyPBxSmB70P6Ce4/fRZooNhTXbJdb75DzfOkTw3kGaLfqXjVLjXz6h0u/npCRnYdjubNQPy9GGKoCFvTs0z9/JXYj6ZGwzpwxfmBCih9ERf/sx/Ryh9MjUlZb0f/do21xdvdh4godW4SsEjwunECR4LfB0dNmohEjgG4njOBQtIt/ux3JlhG7Ijdc47jEFZmaE/Fhf2nHctBffEDgEHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxGrFdZgxzLlE+Wy16KrcTPkwV3lhfxBf0MP+hSfmTU=;
 b=VqedCciyWTTDEp0dVgtkTav8DndxTi6S8wgTf36qAbSI7dKUz0Ik9F039c7g3f/S534WoZzzqGMY4jBuvk4ClnawaKsR+sunT7iRiDZ0xTCiSgu/I0FH+7rOYQSKzpA0jDtCb5iJ4D4owbMmpwiIq0wSqub7wUpwAah9mhM5n4EjeNsYAGES+ewC4zIIaZewkZC68nmZY9iGD03BChTUJ5k4WO183xppnreqFnDuUNqExoTmm3QA5DQi+Ldc7OPMjfafLwXAdtyVCUW6mfqk5GrAAXzcvO+cXFb+CjnxCiIgjTAAY5AjAcSqgan+QHO7lu3wdWMNcwwpGAJ2dqJ+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxGrFdZgxzLlE+Wy16KrcTPkwV3lhfxBf0MP+hSfmTU=;
 b=GGAPhEOrlKLE3fUTOXG4xJwIxaDsMbG/TifVjz51YIZ7p0EuD8ye044fVlNNvLO490H892CMFMbXxiKblZkvtlyyuDVwuun2jsnp0i3d5ia8tutKSqq4qZUKHq7hDS+fhRKlhFJvDNQg5MoA9n+Tem1YVzRgg7xrk+3Esd6RVSo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4153.namprd10.prod.outlook.com (2603:10b6:5:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 15:59:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 15:59:13 +0000
Message-ID: <7f60c97a-18df-4f93-0e95-2a9a6dccbda7@oracle.com>
Date:   Fri, 6 Jan 2023 15:59:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 1/7] perf vendor events arm64: Add common topdown L1
 metrics
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1673017529-1429208-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1673017529-1429208-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1673017529-1429208-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0262.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4153:EE_
X-MS-Office365-Filtering-Correlation-Id: 550f22c0-2b43-4665-3821-08daeffef467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYudzk0b6dPhAzmPv2APB/+nAII9MQGlrtREDCsBJnyRtXBf89hVy19RkHw7sF/Pb5xiywao1lqHWX5G9abF4hL+ZEQ7GWg40l831BadrCPMVFMIl/j8RDgwbwDZcCxIf2R0Xomn4hW0pIA4N0GiK6WBdJR0udDs73R6MFGA4X3eXi0z6UwMIpkidCZVpZ794g8oW8pVrXIhLav6jsyZYKftPihVQ9xEEplIr46pkh63RlQgofbeyYm5ZPUrsnWfHxKTrIML4Y5z6E34XvdFznhuge4iWI8Yj+yWNGAquaahXmbc7aRWVenylznWvYUVuohf+U3MxqJIX8JPeyTxSZJozZULf7D1iSeARpGSHCU4JNOYKd+RFNvR7BuRbqIwevm3Y2mPRsJjmmeN08U7hZayHnNU2TGry1BYrklpm7oJ9MMjDU+0BhavZ2I5CFxq5BtpUCPiPgSSARE6d5WxQo3Atp5WmcVR4a/xM8yGskvGEKCd/v4trVg3Uae+s8VcdNsE830MRyYTJYwqQLuSYrB9IDsm+iGJHubLAN71FAvpnqbgcEvZIyRzo+frPRNp+0vVzPQ4vvJ62un/a6+UKnTwwQPVA/F50u5EbQEQyrMdbW95T79L8pMfs0OWhG1Eh25f7XhVBy2HJ3G9vy9KpCKZWA8cl0YDWuF1TYBDrDUyp7IHEjQu09qOnTxYxKwQ7zNijn04s6uldomjOG0++SLuln2BKb019RjAaD/cRQL8Qhfnmr1DAc/D6fpHZx/1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(6512007)(110136005)(478600001)(6486002)(966005)(5660300002)(2616005)(36916002)(38100700002)(36756003)(7416002)(8936002)(41300700001)(66556008)(66476007)(6506007)(66946007)(4326008)(8676002)(53546011)(6666004)(316002)(26005)(31696002)(31686004)(86362001)(83380400001)(2906002)(54906003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZRc2lEWUdFWmhvNExycUswaytydE5ScnlDQ25RbEtIeSt2dXBES3ZvQU9L?=
 =?utf-8?B?QXJHSHlPZjhYNDl3QkVZMThDT0RjYzZqWmJibFEyOVYwN3JHM3Y1NlJBTzNs?=
 =?utf-8?B?Lzl6L0cxVmU4UlZIZTN3eVcrVXF1NW91UFRraUZaTVhHdEV1aTRlRSt6UTdz?=
 =?utf-8?B?SGRLT0V4Q3lBR244cmxsV0NEbzlMUGpjZnVHV2ViOXlVR1ZDN0VzcWd0M1I5?=
 =?utf-8?B?YUZlZjE5R0wvbG5HemcxTWNqajVjT0VBNDdIOERySjNBdXJuaFJ6bGtqUWh1?=
 =?utf-8?B?b2U5bHJFVUNacHJ3K25QZkhuTG1DZFlQTjBQc3NnOU1TNUw0eitKWWU2ZTlH?=
 =?utf-8?B?b0RmUXA2M083QlhNYUVTVHVjR2FLOVQ5MkRCZ1pwY1JLMW5DaVRTVzBIWG1I?=
 =?utf-8?B?TnNUN000MXlGNTloaDVvZCt3LzltNFc5U0VjRGlSK3NtaEU4UlVORVFReWlT?=
 =?utf-8?B?VVVWVkw0cWRVZTBSQUZBT3dUQjVPeVRLMlpCVUc2Q2NOTTBlbTBNMU9lWXFV?=
 =?utf-8?B?akd2KzdGZHJCNjVWVlg0czR6Rkp3akowRERIM2Rveno0TC9XQmlWWWtzM2hQ?=
 =?utf-8?B?UENOZlBXZ0syOS9rS2N0Vk9zZnkyYk1aVUpXaTVSYThZY0sybW9vZzc0K3dp?=
 =?utf-8?B?emtYQi9lalV3UVFHMHhBa3A0aysrTnhpci9FYnloV1pyQVVaTm5UV0oyNE5Q?=
 =?utf-8?B?VFpXdEVNMUpKb1VxQzJuYk94Q1M5a01PbVgyYk51WjVsNGorSTR1ZGFJNWor?=
 =?utf-8?B?WUZ2Z0FpdkV3Rk5XU0lyS1FVNHhXb3Y1NTRMOE1VUGIwRnBQeDFQaGZhVVl1?=
 =?utf-8?B?UFErMUJob2dSTitIUDVkeWxPVEpVKzExVEljQ3lISG9FRndDa0dBWmcwUEYz?=
 =?utf-8?B?YmVtN0hHbGtnS0ZQUFQ2a09OR1pIUUQ2c25TUTk4TWdHYmNwZGxZdTQ0aFFw?=
 =?utf-8?B?Nm83Z29ZajR0b3NHQnhtdHJIK1ZYWVpheGZ0Z0lKaGNjNFlvWjIzWlBCVUtU?=
 =?utf-8?B?M2YzaVFmaXdxa2xoQlFWaWFZaEloZ1BDY21BdEZmTi9iTWFacDRLS0FGb3I0?=
 =?utf-8?B?dm9Nd293NHFjVlVCN0Vja3dBcXh0NWVXRjNlMlVrZisxM2x3NTZsalNQZ3pn?=
 =?utf-8?B?am8xOEFNZ1Y1VmlocXZXUmhmUk1MSWF4VHJ2S2ZkRUpzclZMbld5NUhyWXhh?=
 =?utf-8?B?b3pUdVNXZzhCMjV0MExMYjZuYnZ3NVVrcWpPZTZaVHk4aXc2cFBhbEMvdUZJ?=
 =?utf-8?B?SG5ySHU0TzZNWDVmNDNjM1VzMk1kNklrRnUyeW84NTFmZmNGd1UzUzlmbFB3?=
 =?utf-8?B?Rks5bGlSSlFweGsyd1haQjRkWWdrd0ZDSVo4M2p6UmhTTTc0Q21xMHZRcEtT?=
 =?utf-8?B?YllvY2lrRVR6aUM4WTRIYnMrVjI2bEFTbnFsdGErUVlWeFIvV0tGbTBkdVVx?=
 =?utf-8?B?TXcrQWtpcEg3d3NxUjF4Q3ZyV2JiZ2RMampIUGlIRzFEY3JNUmdaOVk5VlVj?=
 =?utf-8?B?enc0SWVnQVRYcGNrOXlud0ErNnhpdDFjdkVGUEtkdmIvd1BDS0NGTG1ITnJs?=
 =?utf-8?B?MnRzUHVabkpEdE1zVEZpMGIvQkxZR0RFUWFacU9mT1dNYzNjaTdrd0VXem01?=
 =?utf-8?B?SG95RllnY2RYTEV6bkU0UVRLd292bGZRdGFheVl5YUpCWFFwSWluWnZQS2Z5?=
 =?utf-8?B?Y0Jydi9RYmhWdTVvdDJuVEdhR3JBZnhLY2gwNGpXbnpPL2ZTLzZzb0FTSm1M?=
 =?utf-8?B?K21kdHduZXB6dnEyd3p2SFRSbjRFWUc4em5vTUtyMHRKaGlEWTdRVkFqcTNI?=
 =?utf-8?B?clhEeGlSRFhZSHp0c3hLa1JzMFloQzBEQlRTWmk3R2lIQ3N2ZlBpcmVJNlUx?=
 =?utf-8?B?aW9Kbi9kR2FsekUvQXVZWWtSQ0oyY05jcGZzb1BWL0xIN1d0WUN0a05FOTBr?=
 =?utf-8?B?ajlibG9DT3JiVDNLSlZLdk9qN1ZuM3RIWThrYWgyVTQ0YWNMSDVnMzNNeXg0?=
 =?utf-8?B?R1dxamMrbGYzZFRpUFFMbm1LdXpaSnhGRXJmbFlGemJaM0xIb1YzU3Q4Q1hV?=
 =?utf-8?B?UjRybFZiWXh0eHd4bFJ3eTFMU1FhS3JseVlGOFlYUWc5ZG1CRXprYmdndDdT?=
 =?utf-8?B?b2t0OC9xNkN6YzBCWUVRTEtLVjZuQXVoNVRZMVFPcGM5ZExKZ2g4NXc0d2dD?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L0NUMWdMeXJvbmh5QWh6RE8ydnpkYWc1VzI1blFsN2VVeVNiTkoxeXRLUEtn?=
 =?utf-8?B?T0dwU1NZbGdraTBYTHRmT1NUdTNreXN3UUMrcWI1U2kvMjgwV0c1bXJYaGZu?=
 =?utf-8?B?UkpuMzdMVk9udktGNis0RjJkZzhyaHZvb0FVU3pIWldYNHFIN3ZqR2c3aTZW?=
 =?utf-8?B?YS9ZZGlVeTdZVlBCd1dxYlVuMUswMVJaeUJSVkdqUlRsZ1dib0dPelNoWncv?=
 =?utf-8?B?K3lnQ1VYVS9BRDZWcnBIZWh0bzRrQ1Fxb3B6NVNsTnRxWWU3K3UvUjBJeGFG?=
 =?utf-8?B?VnJRUXhKNEgyYmpEK2Rnb1FOUzdIYjU1ZHl2WnZwVyt3YTkrMVZoU0g0aG52?=
 =?utf-8?B?RVdtdkF4eVdKZkFXcGJvck1RMzkwQkE5Q3hEMlFUOHYvVUk2dzR5ZjZGNVBG?=
 =?utf-8?B?VlZ3MDFVTUorSU9rQlV2cnhiNkk3NTZnb2lkdlp2K09GWGJ6b081UTRlbHh5?=
 =?utf-8?B?QTVxa3BlZERtS3FZT2loNWFrNU1yOGt1aG54d2UzTm9ZbkxKUWVLU2xNZFRK?=
 =?utf-8?B?YlRHTlNxbzVIRFdIVHRNYzZ2UTB4NTgzMm95Q25QUzIxWWZGMThVWlM3RUpx?=
 =?utf-8?B?Q1Z4ZDJySGVKTURkcEVwYzlDLzZPUFZmVkNSc0FpRUZ3L01aa1NrWEdIaTd5?=
 =?utf-8?B?NEtpcWtoeTRwK2lTdFBCbkN1MXNUOFVNYnh6Wm9wUkR3ZVJXeWZydlRjWmVk?=
 =?utf-8?B?TU9xbS9SQVlqRXdoUVByZXhQMFdLbFpIWXkrNEVtNlZVL2FUY3RXMmJTSTFy?=
 =?utf-8?B?bFhFQnkveUR0b1llZXA4OGovL2tBSzBWRmpoVHVYWTJlZGpZRkEzd1B6UFR4?=
 =?utf-8?B?V2cwaDBpejNPNFdpMWVDRU9WUnN1aWM4Z0Jkc1JJODM4ZVArMEFOVUt6SXVO?=
 =?utf-8?B?clhTY2hVTGlGSUdINFY5ZGQ2ZTlvSEFQaUNGV3ZuWVlzWGRtSjBHVVp4U3Bu?=
 =?utf-8?B?SGVLWjZsVy9ycU9HVHZ6TC9TNzhxL2JKR0k3OUZ5ZzlaUXdncHFsT2xKRUpa?=
 =?utf-8?B?Q1VVMmxMTVRWdFN1cTNhNEhNZFo1Mkw1T0JOajdwMmp1bnZEbWNvUGtUUysx?=
 =?utf-8?B?RW5oYlIwbGJWUUsxdE8wd2tPZnlURUNpRmZYeGRYQ3VVL0F3SjhWTDFJdDF1?=
 =?utf-8?B?VkZxQzhFdG9Mbnhtdk9TaloxTmlvYTFHNUNkVDAvbnB1RVBodkI4NnRIUTMv?=
 =?utf-8?B?dFlKNlZPTGRzYUJ3ZkVoTzVPVEJ6UUZYMnBiM2haU0FpUlk0a0ZDVVhFcXo4?=
 =?utf-8?B?MHVxRWo1SzFhUjgrWElQWWhSQVZ5SVJyMnBwU3U0NUVDRTExRXVwU3EzVWFU?=
 =?utf-8?B?Z3dWVDQwQTFNTURPdFFWRndJT1hPWkNWTjdONVh5akE5SzU1bmFoUjNEWU81?=
 =?utf-8?B?a1daVE1SeGRyMTkrbGdWcU8zNjMyUG1QQTdBTFVOOTdQWHdJeEZUVzgyM0d1?=
 =?utf-8?B?bnFuTi9JaUd3UTljTFJDMUViRHZ1QVJIUER3L2VpTHBjcERZbW5PUnRtS1h1?=
 =?utf-8?B?Z2c0TDVDU0pUSVYzZGMvTXRTaENUZjBLZlR3SXVWN2VacGx6ZEJ1SjdpRUIy?=
 =?utf-8?B?UktmZ1FUMkNISDd5N3BuWHlrMFhDTEgwRURvbVNGWFNmbS93QVBSZ3VMcnJM?=
 =?utf-8?B?a0YyNUMxamo4dTZxRkNsS3VkbGs5Ulo1aVhneCt2VjcweHZ0cEhtOTRUdUNt?=
 =?utf-8?B?d1IxOHN6dnU4d0txS1dydTdaUUNtV2w3Y2wrTFJNcVAxQmVmdDVhc3dLbHpP?=
 =?utf-8?B?emdXcEZLMHBrdk1KV1o0U1ZFazJ2TnlDdURaaGhxYkVOcklJNlBHTUljUS9l?=
 =?utf-8?B?QXozajJITnRXZ3FnbTBZZTJZQTYyR285VmY3MmVRSXAvWFJjVUhWNDZYSHow?=
 =?utf-8?B?MVV2MlhLYjVFNEJ4VmkrVzlsdFFZSTh3TGl1U201YjlOaTJFRDRMbTVFM3Z5?=
 =?utf-8?Q?pw/L81rZXd8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550f22c0-2b43-4665-3821-08daeffef467
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 15:59:12.9670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PdPgxcb3ZiIHGM0UBiZmhRAmFi01L0JBkqd8EWW0Yl070uQUzd5V4YYWv+tmjKldK/QT9kSKFwpNcg5tDmCsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_10,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301060123
X-Proofpoint-GUID: qhkBkN_FQ0x37FZRLjFqvWZhgX2GdsSr
X-Proofpoint-ORIG-GUID: qhkBkN_FQ0x37FZRLjFqvWZhgX2GdsSr
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 15:05, Jing Zhang wrote:
> The metrics of topdown L1 are from ARM sbsa7.0 platform design doc[0],
> D37-38, which are standard. So put them in the common file sbsa.json of
> arm64, so that other cores besides n2/v2 can also be reused.
> 
> Slots may be different in each architecture, so added "#slots" literal
> to get different constant for each architecture.
> 
> The value of slots comes from the register PMMIR_EL1, which I can read
> in /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots. PMMIR_EL1.SLOT
> might read as zero if the STALL_SLOT event is not implemented or the PMU
> version is lower than ID_AA64DFR0_EL1_PMUVer_V3P4.
> 
> [0] https://urldefense.com/v3/__https://documentation-service.arm.com/static/60250c7395978b529036da86?token=__;!!ACWV5N9M2RV99hQ!J5JW3y6GhaJUqLfbEAzWIy4GJOhUkHQN4D5hEv3Outpzd54fN1Nt4LNKGnuRtMAepS_Nit-KLSUW98tVfFR0TmMVGQ$
> 
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Acked-by: Ian Rogers <irogers@google.com>

hmmm... you have made significant changes in this version (compared to 
previous), so I would not have picked up this tag. That's just my opinion.

As for the patchset org, I'd move the JSON change here into patch #2, 
and make this patch purely about add "slots" literal support for arm64.

> ---
>   tools/perf/arch/arm64/util/pmu.c           | 22 ++++++++++++++++++++++
>   tools/perf/pmu-events/arch/arm64/sbsa.json | 30 ++++++++++++++++++++++++++++++
>   tools/perf/pmu-events/jevents.py           |  2 ++
>   tools/perf/util/expr.c                     |  5 +++++
>   tools/perf/util/pmu.c                      |  5 +++++
>   tools/perf/util/pmu.h                      |  1 +
>   6 files changed, 65 insertions(+)
>   create mode 100644 tools/perf/pmu-events/arch/arm64/sbsa.json
> 
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> index 477e513..227dadb 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -3,6 +3,7 @@
>   #include <internal/cpumap.h>
>   #include "../../../util/cpumap.h"
>   #include "../../../util/pmu.h"
> +#include <api/fs/fs.h>
>   
>   const struct pmu_events_table *pmu_events_table__find(void)
>   {
> @@ -24,3 +25,24 @@ const struct pmu_events_table *pmu_events_table__find(void)
>   
>   	return NULL;
>   }
> +
> +int perf_pmu__get_slots(void)
> +{
> +	char path[PATH_MAX];
> +	unsigned long long slots = 0;
> +	struct perf_pmu *pmu = NULL;
> +
> +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> +		if (is_pmu_core(pmu->name))
> +			break;
> +	}

There is a lot in common with arm64's pmu_events_table__find() - can you 
factor it out? I also prefer how we check for homogeneous CPUs in 
pmu_events_table__find() (which you should do, also).

> +	if (pmu) {
> +		scnprintf(path, PATH_MAX,
> +			EVENT_SOURCE_DEVICE_PATH "%s/caps/slots", pmu->name);
> +		/* The value of slots is not greater than INT_MAX, but sysfs__read_int
> +		 * can't read value with 0x prefix, so use sysfs__read_ull instead.
> +		 */
> +		sysfs__read_ull(path, &slots);
> +	}
> +	return (int)slots;
> +}
> diff --git a/tools/perf/pmu-events/arch/arm64/sbsa.json b/tools/perf/pmu-events/arch/arm64/sbsa.json
> new file mode 100644
> index 0000000..f678c37e
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/sbsa.json
> @@ -0,0 +1,30 @@
> +[
> +    {
> +        "MetricExpr": "stall_slot_frontend / (#slots * cpu_cycles)",
> +        "BriefDescription": "Frontend bound L1 topdown metric",
> +        "MetricGroup": "TopdownL1",
> +        "MetricName": "frontend_bound",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "(1 - op_retired / op_spec) * (1 - stall_slot / (#slots * cpu_cycles))",
> +        "BriefDescription": "Bad speculation L1 topdown metric",
> +        "MetricGroup": "TopdownL1",
> +        "MetricName": "bad_speculation",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "(op_retired / op_spec) * (1 - stall_slot / (#slots * cpu_cycles))",
> +        "BriefDescription": "Retiring L1 topdown metric",
> +        "MetricGroup": "TopdownL1",
> +        "MetricName": "retiring",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "stall_slot_backend / (#slots * cpu_cycles)",
> +        "BriefDescription": "Backend Bound L1 topdown metric",
> +        "MetricGroup": "TopdownL1",
> +        "MetricName": "backend_bound",
> +        "ScaleUnit": "100%"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 4c398e0..0416b74 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -358,6 +358,8 @@ def preprocess_arch_std_files(archpath: str) -> None:
>         for event in read_json_events(item.path, topic=''):
>           if event.name:
>             _arch_std_events[event.name.lower()] = event
> +        if event.metric_name:
> +          _arch_std_events[event.metric_name.lower()] = event
>   
>   
>   def print_events_table_prefix(tblname: str) -> None:
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 00dcde3..3d67707 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -19,6 +19,7 @@
>   #include <linux/zalloc.h>
>   #include <ctype.h>
>   #include <math.h>
> +#include "pmu.h"
>   
>   #ifdef PARSER_DEBUG
>   extern int expr_debug;
> @@ -448,6 +449,10 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
>   		result = topology->core_cpus_lists;
>   		goto out;
>   	}
> +	if (!strcmp("#slots", literal)) {
> +		result = perf_pmu__get_slots();
> +		goto out;
> +	}
>   
>   	pr_err("Unrecognized literal '%s'", literal);
>   out:
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 2bdeb89..d4cace2 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1993,3 +1993,8 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
>   	*ucpus_ptr = unmatched_cpus;
>   	return 0;
>   }
> +
> +int __weak perf_pmu__get_slots(void)
> +{
> +	return 0;

should this be NAN?

> +}
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 69ca000..a2f7df8 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -259,4 +259,5 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
>   
>   char *pmu_find_real_name(const char *name);
>   char *pmu_find_alias_name(const char *name);
> +int perf_pmu__get_slots(void);

I think that this name is a bit too vague. Maybe 
perf_pmu__cpu_cycles_per_slot() could be better.

>   #endif /* __PMU_H */

Thanks,
John



