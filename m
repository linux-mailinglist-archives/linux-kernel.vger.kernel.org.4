Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D187C65E8B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjAEKOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjAEKOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:14:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B48432E8E;
        Thu,  5 Jan 2023 02:14:02 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3051wBjH019682;
        Thu, 5 Jan 2023 10:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5spfX6vfGJxUtUu2tdG0fK/u2saknYaSy2QPav6srI4=;
 b=ZkQwih3vzKiKW41fGJWiTq6+HDdi49PsI/bIt/2eS0lcbiP2wyrP0XTb+7Eqroju+W6f
 /fiXACrzexFQO35XgUvNvSww4vVzjYKsgVPaEpVkNIlfcG/IiRlqES42GxVdWpwmJwFC
 NU5v4s117xHj2CxDK/5rCAI1GxENpRlPbqt4K97b7PZ6+TajmgXzsXiuM/ZoO2O95ECo
 2KY7P5O1MKPiqfI9KorPD1lFVDm6mjHhMO83NA2TYPOcl84VZ+JvjNnENveSBxHWmz5l
 MeBg50PHGyULWgd1cgxFAzFePouBYcR3V66AkT4vxe2k2xGmkEjWjil7oA8Whql0S+dr ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0arkhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 10:13:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305ABBhI033708;
        Thu, 5 Jan 2023 10:13:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwfsyfx42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 10:13:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3OjsaLYWwIVM5PgbixQmrrRXM0TYp+pKdLI+lJ/MYRxDGEuV8gUMLBZczAHOG0OBBtNDS5MefxDjQHSNfRtqCXh9hxK0rnAHUD9ulIlu7F4kF+IN7mxZW2DVnUBe55g0Bja7htJzk3AHpNyCtBl9WDGigkXIE5H0HK4+M4hlI93n6NcjhvKEJigRfapK2OF4MYVPjkULY4EIei4ZtGX+cYKqCdXRBUD3J+sFoxsVzo91+ajBVPbl07ZLQOc+AwBKxHyWrFEaREGXDD/PQSrIY26i3br5FvlrdTRK/Qh5vXtVL1lyQ2yK9P5+VNmrCgsce0sTIvheSjuLqXsjU0lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5spfX6vfGJxUtUu2tdG0fK/u2saknYaSy2QPav6srI4=;
 b=Dl3Q1bLB1K4Kkw/HwfV9ltvfMYx1j+INZwFU+iZ8DbT/mcfry6rXRBjZxxN3aCoRFvMYr3D1+Lt/D8iqr80Z7NkcPJjEg7TM7A0N3WuLcs//G2rnCwY5Wmpac0F+/AR9pY+NP/++2GXJuBE0+hWNYUr9dQNO7impzUAsXzV/KmC0VNPdTxx7IRaykujX+4pXTTmVR53LBTLa65sM3WSnDNE7gYSvMgb3C9BrJXmlNE7Rk2SoTNnXY4Sk9VynUj9/Aqd34LdX0J1riFQY5mJSqh/dkXqLxCUXjK+3LP0V3qJPapV1qKwnsFlireoLUW+t6uEmXic/9ANoMQJKCwiAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5spfX6vfGJxUtUu2tdG0fK/u2saknYaSy2QPav6srI4=;
 b=uMJ/YZAizp7I9YMO2GHCYRPQEL3c6dQRX27HKoI9SX5XSaKnHZ5wBuR4RH0nLwX88kkW7eGPMZnV5yUMM5A2W07anSzjAz+AE/TEuuAb2S2N60OkHqSb/MdEbNzRRtKELdJlNChRztlBEZqaC7I1nynw7Bi0LlT5vuTBSHsgjAE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4556.namprd10.prod.outlook.com (2603:10b6:806:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 10:13:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 10:13:34 +0000
Message-ID: <00bf227a-75ce-c63c-c740-89b8d2b27e1c@oracle.com>
Date:   Thu, 5 Jan 2023 10:13:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/6] perf vendor events arm64: Add topdown L1 metrics
 for neoverse-n2
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
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
References: <1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1672745976-2800146-2-git-send-email-renyu.zj@linux.alibaba.com>
 <5c5716e5-b2ff-67cd-b608-4eeffa7e04bc@oracle.com>
 <1f3d53cb-4160-e29d-3934-d6a488d9fd49@linux.alibaba.com>
 <7aa225df-af25-a6be-9bef-c965488ba43a@oracle.com>
 <d4d132d9-1513-6a4e-981f-aa4bc4ebbcbb@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d4d132d9-1513-6a4e-981f-aa4bc4ebbcbb@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: d658464b-d839-4a73-6b86-08daef0580ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLWnhBrdP5qMaaZ6I+Cif0NEXyBmkBdfDH27NUiomedVUJZpfC/KHtXQLtai9W20GeBxmChFr/9X1sWHBhcD/MMun5EU+AUXLdrcGriSUOlvPT/uA+qz5sjVQKOTMTRXUnEVc2gVI1IhEYsy7Lfjc7fQzQu/oUC3eh0cqLTmDbJ0TuKyeuLP/APxbe+dPb2PGIHo2bi+tovh4IEGN0r11v+60TqCtBs61usVIQ/MO+iR41MR1iuHxxyjEf9iULEEcVHX5lMvmbTerwey9QqY+/1A7KqPIlyIrX0lLOeRuCKeJXbdMt9dZKYr6cp2NceI/ZOjqHUAO5psRhDeTkBh3ARVMKzjh3BDbJ+gOdgxxIlY4l0EZQoA2Cs0JaEpAQ04zhjBiDZcN7HtU5EugL4/fL7nuj8HAgHOMyzXKQb8QHVlAQajp32MKpEKmdNfA1nsFjNgG+PEdJONGqvepOGtNtYvstbzXGp8GB1BALcP2Ze49nL/RaL9xw5Jk+1QYgwpFe5AFJpyrBfufWcMx947NU9lLuC3KdaBQuCtgpBlS9TPPnZ0+hI9kXWGkv52lQPU/D8BPKw1DPZJ76e1hGkBrU18W7NokjGj9Kp5PuQYaLxG5/6tQkcMhE6lo7+yEolzCbkRkJpCTCF8ckx+Ohvi7tFh+kOSYSnJFNkhcZnZFreMEnTGgG2hF+qtShF32w++PSZ+pCjvei1iTEx5xq8lI+Ozqe6bMa9z5sdzoMP1KIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199015)(31686004)(8936002)(7416002)(41300700001)(4326008)(5660300002)(8676002)(66556008)(66476007)(66946007)(2906002)(316002)(54906003)(110136005)(6506007)(36916002)(26005)(478600001)(53546011)(186003)(6512007)(6486002)(6666004)(86362001)(31696002)(2616005)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnUvaVFtV0hjb1ZKTGU2M1JmaEI0ZFhNSnNlUm1jNWEzNHF1WlZNdXZreXdj?=
 =?utf-8?B?YXRlT05RV2EvUWNUeTd5TFNhZWRYd2Y2T3B1UFJlcEVYem1qOU1OQUwzWG5o?=
 =?utf-8?B?SUZ5d2JDYWY5SUF0eWNBdmJNZFpMQ1NuOC9aZHBRYVdHcFNCNzhMMTR5K2dp?=
 =?utf-8?B?VEY2U0oySjBlUlZkUWpySmVVbmZrZnJsUVA1S1ZKQkY2NUJ0Rk9SZDNTYzh1?=
 =?utf-8?B?S1R5MHdHSE1ONlpVME15WWpUVUdoM2Y5VjFsRWgrMTROOUVUQUNYYU93Z2sy?=
 =?utf-8?B?VE0yKzd2Nlk1Wll3TDRyRC8xTVVkTWVCdnpWK2RyM1VwNFZyQ09KdG1zYndz?=
 =?utf-8?B?Z2ZNRjFIQVp3aXFBb05qWURoVlh5SGREc3RxN2RuOTQ2ekJtcW80bllZL1Fa?=
 =?utf-8?B?TEljMS96MmF3WFZJSFhKWFNRVlBibjhneEFJMFBlejFKT3lOWDk1ajROejhB?=
 =?utf-8?B?Z0UvOFJPSFFOOGxrV0l2WENQekdIUUxNVFcxaC8rK1Q3SHh2ZlAvNmdGcFlJ?=
 =?utf-8?B?UTZBdGIzVUc0RXlEMXRZV0YvS0dBd0xKT09WMU9PV3Rla2pSUEZWS2xwRE1s?=
 =?utf-8?B?R3grb3hSZytDZ1o2MWVSVFVXc00rWkNTWlZvRi9zdFNLYWQ4eGY4ckppT09v?=
 =?utf-8?B?KzJiUjBUVFJHZWVwWW54NStNLytMcUw1UVBtTXZ2dEtjMFE0dUN0NUNCbUUx?=
 =?utf-8?B?dStxQWlLZXdzWkJGQjdRUFdnMm9zS0x6WWV5SmlqaURSOTRZUXg2VFlLekpJ?=
 =?utf-8?B?YXdQT3ZyNjkyOU16aVE3cEFQeFpoS0ZMOWtFc1NOcGozUGV2dkhCYmJHc2Y3?=
 =?utf-8?B?SWdtL0oxQXJiUUFlMXcvaVMvVTlBZ0JpdjBLd2pJUTltYTNMQVoyN25XRytN?=
 =?utf-8?B?WU81cnM5R3RGLzRtTFFybGFrc21ZaFdKYmJSOW80TkFEY2ZEQ2JLdCtRY0x5?=
 =?utf-8?B?Nkt1V2gzSlE3SUFkRG9CQ0dPR1BOWVFzUFFpaXNRbE56c3BjY2FnNWhIMU9h?=
 =?utf-8?B?ZHlZVXRpbXY4V0w3RG1yZjhLR0hpSEVaMmVWb21ad0hqcVovQ21WVERJaHlU?=
 =?utf-8?B?b0dVeVE0ZHl0SkoveWNpVElMWUVSS2xPT3dTU2habWxHNXQwb0JYVEJFa0Vj?=
 =?utf-8?B?T2dJbGtZVjY3bnhjQXN0SldZNFpZMld6RXdqVXlibU9kV3ptVGI4MURpYnVu?=
 =?utf-8?B?bWtWeFpnekRKaksvSit3ZE1UU3ZGaWVMenBweUJhTmhtRmwzeXM5T2dXS2RL?=
 =?utf-8?B?UytkbERxbmdHNC85UGJVRTNCSHF6enRBM3BKK3dUdEhGWGwyUDZycFhYR1d4?=
 =?utf-8?B?U2hYZWt1QmJYZHI5clpHZ1luVkI1Mm8xM1I2VnNnR2Z2czR2am96RjJPUVdW?=
 =?utf-8?B?eSsrVFBRbGNKNStIL3gxVFUvbll3ak9NMFBNOFFjOHkvTytRWWp4Myswd0x5?=
 =?utf-8?B?MEluR094b3B1RnI3SlU5Q29RWkc0R0c1eFdVS2ZCcjB3R2l3alFGQS9PRXNH?=
 =?utf-8?B?QjUzUUEyNnY0V3hjTWRSMzFHa0RvTjU2MUNaaUVvVFBJMEM5OVNJRmZoSExw?=
 =?utf-8?B?blR0V2t1OUIzZGRpaHg3RlIxL2llYUlMUUc4emEralJVa2krZFZJMWM3NVp4?=
 =?utf-8?B?SytvWnBMaEpGTThkdXgwa3FtbnV0NzZaaUZzVUIrTCtDNE92SmpYVzZJUFB3?=
 =?utf-8?B?OXYzTEVCbmhHYWJtd2x5WDc2a3RJRWJUcnZqbTRzQ0l0d3QvalVTWnp1dU80?=
 =?utf-8?B?N01PVTJuVWNqMktwK0M5enNVZmYyR0xUcnlsa05kL3Q1M0FOUDBCMmhuT3Jr?=
 =?utf-8?B?a2RqRmk0L09MdmZ3MVBEWDlycmN5czhBZkhIMTdQc1E4cG9ObGVoOGo3dC9B?=
 =?utf-8?B?WUIrT256R0Q1SjNoMzV2RDdBN29JdG81V290eHp0ZGFGZFNTUm92bmdnT0Nk?=
 =?utf-8?B?R0xhZmpmT0lJYWlVZzg1UEh0eWF3ZUJoN2dGRW9tWUNvM2xNNElabmk3VEZU?=
 =?utf-8?B?M0NDdmljLzNTNVZXbWpVRVRXN1hEQlFHSkhmTzB2dWtGcVZFYWFGa1VoZzJX?=
 =?utf-8?B?VXNESUtJWEhNeHMrT3RYTld0NzY2Qjc2ZXhmM1ZhY0dxM3RUb2h4YlJXbVpn?=
 =?utf-8?Q?4Jg8LTEdOeHGQB42PZuBxs1++?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YURKemZhajRXVnBLeVErYll5Snl6T3BDc2VMNXBDVThMN2RjOWl4aDdUaEdi?=
 =?utf-8?B?NTRFRHEwZTZYZWpRR3ZSUnNQenR5eG9tVUlLNDM2dDUwd0R6NDVFL1o0eVVk?=
 =?utf-8?B?c3dzd3ZKNkN2VERkbHJKTUsvblR4WnRFSWxGNDMwdXJuNFNLSHd2VkVOOVM5?=
 =?utf-8?B?YlZKVURMd0xjVVdkYWwraDhvOWNxRWtvVFY3QzFVellwL3MrbVB4RWJjY3dz?=
 =?utf-8?B?cXl1UGdLbmRXM1MvR09jM3FUVkIwdSs1MkdmVU5OOThBa3lKL0JZSFdsNCtQ?=
 =?utf-8?B?L21YNzYwRUo3b01HZmRYWnpvSHlEK1ArOTlUamk0aXcydGxYOGo0aHFUWDcw?=
 =?utf-8?B?WDhMblFXTjIzY1NkVW1EajQ4ZVdQdzUyUjBSS0dQbGxGb2oyZXBQbVlTS1FE?=
 =?utf-8?B?VzBPeGRPemRrd3ppcEtjWjBJaEpwam5MT1BSRGpyUHo2MDVjZlY2UGdDeTJ0?=
 =?utf-8?B?ZWRWb0wrOHBXMXJLNmkrcU9taE9KbkxrMkdneGgyLzViRGtjbXh0cDFwZUFt?=
 =?utf-8?B?bVlldVBpSWZDSFZ5dUlieU5LbldqMjN6RHU1ZXFqa1p0ZmFxaStPV3VRMXhL?=
 =?utf-8?B?TnBGTVRoelVseC9Vamx5TlZCOFRndUpQeVFLZmwyZVpKV1FrdGt5eW93cUJt?=
 =?utf-8?B?UGFUN0lZS0hZQjJjcFExWDAzSGtVTEdBUUVMeWQ0dmVtNUtnQnJaMGhNelZh?=
 =?utf-8?B?blkwWTdwVkZMQjh6SVQ4eERPNlpsU2lFTEtDRGdLcXh3c3BGM1FrOXFoQU4r?=
 =?utf-8?B?emw3azJiUnM3cUhKRm1VVG10T0grMGYyS3VMSGdWcmprR1NSRmhRMlpmOFhj?=
 =?utf-8?B?N2dHZGNOMXZtM25jZzhNTjJzSnpOYlVqNTlPTTFETmZ0U1NNckd2c01uMHJK?=
 =?utf-8?B?TU11WXlSYWcveWg0QXJMN014bG13dnd2cStVdTlEWVpCVkZWV3pVY1RlRGtF?=
 =?utf-8?B?U1drZUp3V2tmeUJJL29zcktPaUN2dDZUTUNPZFY0UEErYzlHYi9tVHZrTGYv?=
 =?utf-8?B?cnZEckR2L1hsY3dURDg3V2NPWWpIQlhpUXl6OWdYeUZtSXJNMzk5Wk9XRmZ2?=
 =?utf-8?B?OXZ4cEtxZUE3U2dKci9CVUxYVVg2S1hpc3BaZEkwb1Q5cVoxdEZqejhqYldw?=
 =?utf-8?B?YVNRUi9sTmEyRWVNN0EzRjMwSEczMVRvcS9WN3kyL042MjlBN0p6bU5rMGlz?=
 =?utf-8?B?REdoTlJJZnovTU0vdXhWSitqb1IyVGpydWh6UEVETmsxdFgxSWZVUVFHN3hC?=
 =?utf-8?B?SVUvSTdFaEEwLzVBMms1bjNxV0NnZzJHZWdBTUo5Y3JoQzJsRGxjVzVsVEVT?=
 =?utf-8?B?S3Vnd3pnR2tlQm1NV3JMMEZTSnBFODd3OXJTUk4xQkNGanBndFM0WmxaWEFn?=
 =?utf-8?B?OFdiQnNQQkNvWVhxTEpGanVFVEp3ZXRzOXozZUVIcS9LZjhHS1JadVhXcXBG?=
 =?utf-8?B?c2ZPQjU5cTVNSDNkWTVJL0RHTnlYMUMzM0ZuaUE5b3RFUlgwMFpXWkZtbTVa?=
 =?utf-8?B?b3REZzlxZGF4SjlEMkNsb3B4WjI0M05qUG9LNFE4THh1VGVhUmhWR1pGeXZM?=
 =?utf-8?B?eWQ2Z3hmTVM3YmZQaWcyOU9hRjFJa1UxdXZGL1FXL1k5MlRlRGlnUUMwK2FX?=
 =?utf-8?B?eDlKK1k4QXBZQ1lVZDRkWGFFN0ZzZ1J3OUtTeGNPaWdvSUp0UHBvaHI2bWJD?=
 =?utf-8?B?eHRSNEpRN0xLS05NOE5USllpSzdjYkV2OHN4aE9DUXpGYUM4L3M1a3NFaW0z?=
 =?utf-8?B?SW9MUHQ0SHpTWUtnVFZodzJBN3AwMTVRM0J0Ym93SEVHdDhTWmo3OEZUZlU0?=
 =?utf-8?B?S1Jjc2dQVjkxMVVlYjQ2YWk4N0Flenk0SE1TcW9JSjFTSUpwRUY4bFdDRkM1?=
 =?utf-8?B?ZHpYQ1NWODFpSkh5OHJHeEtSeGhYTExKYWtEUVUxVzJ4YjJpcFAxdVJ2UEpn?=
 =?utf-8?Q?5UcNu4yMLT0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d658464b-d839-4a73-6b86-08daef0580ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 10:13:34.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rz0y7xUX+7CYzTArjxpDb0M5ifSL8DyLfp0ORKhKTSD5s9S2TFDomvSJFlJ5Dk5d2asxVq0KUhrXBCyo8iN7aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050083
X-Proofpoint-GUID: PXXaWx8vLHfjU7a9yUHnLQ34xVQ8BuXx
X-Proofpoint-ORIG-GUID: PXXaWx8vLHfjU7a9yUHnLQ34xVQ8BuXx
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 10:05, Jing Zhang wrote:
>> However, for this value of slot, isn't this discoverable from a system register per core? Quoting the sbsa: "The IMPLEMENTATION DEFINED constant SLOTS is discoverable from the system register PMMIR_EL1.SLOTS." Did you consider how this could be used?
>>
> 
> This may be a feasible idea. The value of slots comes from the register PMMIR_EL1, which I can read in
> /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots. But how do I replace the slots in MetricExpr with the
> read slots values? Currently I understand that parameters in metricExpr only support events and constants.
> 

Maybe during runtime we could create a pseudo metric/event for SLOT. 
This metric would be created during init, and it always just returns the 
value which was read from PMMIR_EL1.

I'm not sure how well that would play will trying to resolve metrics 
when building generated pmu-events.c, but I don't think it's all too 
difficult to achieve.

Have you actually read this value for the n2 core? Does look correct?

Thanks,
John
