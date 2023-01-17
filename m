Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FC066D888
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbjAQIqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbjAQIpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:45:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3C82DE45;
        Tue, 17 Jan 2023 00:45:35 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H7W7lS021541;
        Tue, 17 Jan 2023 08:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Y2K+ZHcF5vJcK9ED9DzKWatX3kewCDh1d3rijI8/ldE=;
 b=cHAt69VA8/IsnFv2Hf0nUcQQucUMOlSjPGZ9AjFagtWb6MU8CpqyHBjiKxgl4OyAdCxw
 mIf+kh094VQRmf/AEgFmR81BqzPqopTGIjilce14KtHxUkoE4JIfznqnvplyWAPFDTrO
 UTYp6HVeFs8u7QBZ+RIa7LDYC5JCJP1bILGyJY077wxLe4TqHuRTeux6AyWkqDAsK3nv
 Aw92AHmyeOs426m4YYm15YbZ7H/l+B1VJc1aDtaQxzh8FVBVhyvrMt7LZt2ht84aSd6S
 4l03Z3B7ABJxR0gLmODhoHaI+YIjFPzmZx8RKxdy6KSTFOg+eGlAmvKzE/gKj7QwaLSK Qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaac6e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 08:45:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30H80DpI020656;
        Tue, 17 Jan 2023 08:45:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq3gwsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 08:45:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bpa+hefH64jgHFiMj2zASd9NSaIdI4ZUvhFjEriK/2caqNMPQqDdRDdEcnk+qRZoHsgLiUtyJq2+zjm8SF2atjkwHw5TUcUFYBulI1+cxk+qGrHd4VWJriZCJyHNlixt7RpjzAfDqsHzyRRgKLZnNeLYsJka9UtIFjrCwGMAi7FSSGRt6XVqNZOOf/c9ET7u04QMRXYcDLbENLcDm5trx52AXLWTGf5d5IOVefnOdOgfC8ZkTcAAKlXYeRhnw8X1JncwG+30+AFDXtrln/ONNP7xnXzmgsfH1ZqCd22xIdlskqB+SBLvUlJ+vuVZoeGRplvUnnrnPTuJ0gqpOxh0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2K+ZHcF5vJcK9ED9DzKWatX3kewCDh1d3rijI8/ldE=;
 b=XoXtHt6sDFoxydagSS9XQqtuLdkwG1Xelmb080Ox71qoO6fYkx9+sQ0idMSITluAqATeuQ82jFK0TVKH6rYs9TyXcaoxYIZVSYHOU+OjUyEt/ihm5bSSV8H7TlozKe3Ti8MI2zxMCTxEruHfpB4PL5DiHtwWDgxWyqUEQ3GAUXs1J4by9Ui83WiP3PiE69gENIwuC9ASymmh5/lUt5/BiJg99Mgyy0gaGsI/dmVfN494cWFC/6oW12w33LCYRBCc1KjZsm0DnuHpWN0KfinxTELlHsvcrsBmUZli12tbCHi9Q7hew7O1RQb79qQBjJsaeHaFE7snN4BAwR5VlknbKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2K+ZHcF5vJcK9ED9DzKWatX3kewCDh1d3rijI8/ldE=;
 b=RaRIB9u/9XfLsepNgEhGgwHgeqkFUoU1z68nsXx4+QlOX8w3HORGb0xSOBmG9+rzNKA2pXTYiMLZ8dDEMlL1vhARiLIoQTKV1iuiFPKG88+PrWipqjR5Q5D+RU998wWq2VS9hUbqIryJE4HpRG365DKWPppFy9c58KWKWrJhVFw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6696.namprd10.prod.outlook.com (2603:10b6:8:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 08:45:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%8]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 08:45:12 +0000
Message-ID: <06d33eb8-d2a9-4792-fa83-c64059ab7326@oracle.com>
Date:   Tue, 17 Jan 2023 08:45:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 1/9] perf pmu: Add #slots literal support for arm64
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
References: <1673940573-90503-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1673940573-90503-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1673940573-90503-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0268.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: f8492c9c-543d-4d1c-da89-08daf86725cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MwLlIGTutZtl1/KXbUyDdkeKY1MonwWu1ecnJBFVOeWWnMuodXfXD5IQS2cLspoahTU7lIhid3qqSJcE48vheC0YqeYlKOeWiGewPcKQjaRlZV+I/7TKyHB2MZbMChqIqopxvv0QVEIwhY5OQcvt5F27mALbtRuEg9QZ3TwG5ImppiV0s0Z8/OCy++J4SF2fV+X6tpF8jldCpD8/azdWQcSwY9Wg7mXJPQp3hbe+nU82urNvlpDIkAfhMzR5XMwjp2xWRLuaXCeRSurvdp6hjHNt+p/4/AkL7slmwc1JsES+9HuRAwkyvaR0KHQfV9hQ1fVGPLPxA/DlRgAEIuDi4yjQNtqul5CRhV0X3tN2mjnkh+C4TjUcX1ZD2YPyHE0kt8Ml03rVfMM0mDiiJO51y+8axiuKq8aWKego6DJtIUDcRjtNXepNtIGjNfdGabcpxrrfvbWFc7+GFpyl9JDcWbgwQ4qprG7gmHrTNQQIVymX1m/azhYV8XJ8NJAiXRCmXgjHHF2vHuHnD9qdq21r4SDnG/Q235gU0v00GZGdADTcgDlr5fB0VV7NHgYBnCz0bDWLP4cZQNZCezonjQmLZso3oMdUx6cgerH8NI6hWTv0dp5b5No4dHBOPfFlRxUnT9jVQE7FMyWdMem6G7SUFf1fF5tcZ1h+NTbkOSH6sYRzFVYgpcwSdPQkh2XoawsE7aKjjDwPKkL3RBaqqBG7MSe1wTufK6DQpHwp+pbsFew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199015)(36756003)(31696002)(6512007)(478600001)(36916002)(6486002)(54906003)(110136005)(186003)(26005)(4744005)(6666004)(53546011)(6506007)(2906002)(41300700001)(8936002)(5660300002)(316002)(66946007)(8676002)(4326008)(66556008)(66476007)(7416002)(38100700002)(86362001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGFNeWhoT0QxUmpRbnAxa1B5N2NYeWMwWmFMU2pQbWFOa1hMa3pScEFobm5h?=
 =?utf-8?B?N0VXaVEwck5tUGRoWmdsMVJ0MzNRSGVuZVNrVWRmVTZRRytEajlKYVorSFFI?=
 =?utf-8?B?N1hPaWtPQ3BaenQraEtvelN2VXJUYkIvR2tMRHUyUDgvUnJNR2lMNkFveE55?=
 =?utf-8?B?TE0ySStxdlNRdDd2b3hPUXFUeEVWKzYzNThyajljY2pFeFE4djg0WDlOVFJT?=
 =?utf-8?B?ZVNOelRpWDl0cWJXd1JpcUZZQndNQ2x4UlBDQStYZTBFcGFURkM2WGdFMWZk?=
 =?utf-8?B?eVFicFBkTEgrN1NQb1hTOXVERExvL09FOEV1VEJwcUp3Zyt5WGswRm84dWlv?=
 =?utf-8?B?djRubTQ3bjBkZU5WWEFaekhqVU00SllCMkNHMVdVNUk4M0E2QURyeksxWm1W?=
 =?utf-8?B?Z2FBMFZtWlFTOG5ia01hMUpMbW01Z2t2bVJQNExSZXluclRUTVdUSUJrUXJ0?=
 =?utf-8?B?KzZ0ZSs4YXdBYmJreHBYdkxZSVIwOGNhbGgwKzlxMDV2ZFBMTWVwZWZnVkdr?=
 =?utf-8?B?NG1hbVRiOHJQYWd2b3JYYWFKTys3R3BnSE9MNkxNZnRvdXZreVNYNzA4YmVO?=
 =?utf-8?B?aUpkM2pQY1BReTZKTStaVW8yYlJJbFRwcktLanZVZFlLZXRINm8zTmRYU1Zw?=
 =?utf-8?B?RXFUVTUxYWcweXZaamNIeCtGTkJRUnpWRG9BeU9PQkRtQmZHSXp0dVo1bk9K?=
 =?utf-8?B?QmJKYzJpdUNxdWVydlFjQXQyYXdPSVdvSWhTcmtwQ3VVZGhRWVVvVU5yMFMx?=
 =?utf-8?B?RnFCVXc2THgxVEZWM2FmdXBhRVNaeEdxQ0VBWGlzK081WVdwdUxPa1IwaVR0?=
 =?utf-8?B?ajFQQ3I2KzFINE9NVnhzSjZzMDVmNXcvU2xRTGdKRkNoZjNwOUdFdmRnN0hD?=
 =?utf-8?B?M0VSNjg2ODZUVVhwNXEyRSs5VVo5WThZaUZZbFkvM2xwMlV0YVBsY3JQc0xG?=
 =?utf-8?B?R1hzc29LUzBzNHBNMjJsRUtnSjJLR1haMTR5ODEyNzhGSjJLUTNiZlg5YzV0?=
 =?utf-8?B?enEzWXVOcm40WnBlYjIxdlc1MnlMUkgwVHlZbDdTTVkzZEM3SUtmakZvVTBN?=
 =?utf-8?B?bHVUZjVrVnYrMXFqbUh0U1JvZG81NytHZWVzZm1yTDNER0J3dU5OVWNMUHBi?=
 =?utf-8?B?NFg2d2pvWWZ4QzJ6MTJMTWxnVmJmd0lOZ3Vra3FDSDhaU3h2ajM4QlF3QWRV?=
 =?utf-8?B?dGdtS0M2L3FUS2ptYU1FV2xPd1R6ZGd5YU5TSDRYbjJyczJuUmFLYWxNV3Jq?=
 =?utf-8?B?RElmSkN3TTRpeGVIS04zSkZCLy9WeVRQREFRYmNHQ1U1dmZESnZSUU5KaVBt?=
 =?utf-8?B?MzFwM3J2NW5laVExd1JTYlpKNThDYTcyNklUS1J1UmdJcWtrNkx0YjZSSTBK?=
 =?utf-8?B?WXd2M01vN0Q2Uzc2STNXMlhUUlpnRDZ1MFNnYWM3Tm5EUlQvdlVob2NHcGJw?=
 =?utf-8?B?TzZha0QwUzlvSU5UbXIxNXdLYXhIVGVmNlM0NUxackJ3MFNzRzRhMEkvQ3lt?=
 =?utf-8?B?cVk1SmhzZGlIYnRYRTJGeFBtTzFiVHQzMXV6d2xkWUdCQWs5TzZVT0lSUmRz?=
 =?utf-8?B?dkNmN0JRWndCQzJqQ3A3azZCYWUzNnZmUGtrOVdmQllMNSthejd4SkJ2QUhO?=
 =?utf-8?B?MGtTZC9Ea3VMbCtDM202bURkbHE3OHQxN0xhZldqWDFqQnprOTVYVWVyKzNh?=
 =?utf-8?B?aFZNWWpwMTNMMHp1MDFZM1RnU09mUmhLUENJUVJQV0hBTU9kbDlUMDZnMnRV?=
 =?utf-8?B?TFJBaGNjajhVT2ZBbzRTdkdPN3FqUkRKL1BBNlFxYXppeDZ4ME1IQnpqaCs1?=
 =?utf-8?B?UmpVWERFbWpnK1JxeklHQzMzZnB0R0lVdk0vT2tjNVA1M0xYN3A0OGJQVk1v?=
 =?utf-8?B?TVlsMnd6Nmk3Q2tYTHo5Q2FXcm1HK3NJS3paWFA5UnR1SnBqZk0wR1poMVM3?=
 =?utf-8?B?aStwQ1k4SktnZm0reWxDNk5mT2ZZU2U1M0RTRzFWZm9VMmVYZXcxM2pOTVdu?=
 =?utf-8?B?UXZkdFA2R1Jwd2l3VzYvU0p4eGtIZUFWRitGUmRZcGtZSmRSUHRkKzNiV3ZB?=
 =?utf-8?B?RTI5VWFRVnR3Uk0wR3l2LzBKWC8yTXZDR0JZamFZY2xtUU5wOGRBUHR2T2Nk?=
 =?utf-8?Q?sLaR9zgfZc4o8rdFu2yluUnHq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aitUclRhSzNEVE02OExKZ3ZBcnlQSDR5S3U0d0d2VkdycXV5SDdteWxtK0l3?=
 =?utf-8?B?WGt2UnRWSXRqZWhKS3dBbTZmWFZkeGxUU3Jnd21SdGg2by9wa1JHN01mS3hl?=
 =?utf-8?B?TlZpR1JuaUFRSlNCWk14TnZTejI4VStkMUxkdER5cjJMRnhVKzV0VkFSODA1?=
 =?utf-8?B?VTUrUFQ1MDhrV1pTaGZtNW5sbmVWS3RsMWtJZVJSVzhLU3g3RzRDeUZ1ZUo5?=
 =?utf-8?B?ZS9tOXRKU0FldS9SMDdzUDFtRStic0tuS2x6RUxKTW9lSjNZa21jcEhqQTZI?=
 =?utf-8?B?Y3hJNjFDc2h2RVE0NWNvSWV2SG84Z1dDT1gzTnphRFFRTHdqdklQR3JhVGlV?=
 =?utf-8?B?YUVhTjllL1p6RTFkdHF3MGk1cG5KdXhXUC92Wm1tN0VCUkl4bTZ0azNOdnJO?=
 =?utf-8?B?U1h3M1dhYk5mUEZwWktLclAvTEE4T1ZIYVpRcjNPWTIxL1ZuSytaZ0t3cXg3?=
 =?utf-8?B?NlV2WTFPcjBrN1dYR2xnMG01LytmUmFaVVdNQlBTakI3ak9QQ1Q1Y0pTb25v?=
 =?utf-8?B?Uml5djg0UHhRVmEvTmllRXdSMXVRdWQ1OHVudWYvN1lxWGRVbDBQaXJQQncy?=
 =?utf-8?B?cThsY1BHWXhSWHJYanJEMTFpMVhYc2F3anVFWG1YdU9LYlNTNG9FT0VtR2R3?=
 =?utf-8?B?Umk0RFVhNTl0bHZvMERPQmJxcm5UVXp5bEdqQTN5K0lOWVdVK0c4bjY3QVVG?=
 =?utf-8?B?Q2hEUk01SUF3YjV0WTc1eURwbEZYMEwxWWd1Z2t6VmptVUtFVTREeGpmRGN1?=
 =?utf-8?B?QTFIbFRwVTBndzl6RVN5ZFJySDdSNk1nK3lhT25RdXkyOTBDMXNKOVNJY2VS?=
 =?utf-8?B?Zzg3bXdaSkI2VFF0VTlYZnNYb2RxVFM0SmVoTWxUcGhMQUlsQ0NESms4cWgz?=
 =?utf-8?B?MWgzdjVhakFGRXJmcHFoT0FMWjd2UW9jTFphd20waGxtUWRGcmtiYS85YU5H?=
 =?utf-8?B?WHF6Z09SUDFjWU1UbEQ3VFdoZkNoYnQya3ZjSmIyZmhiTGoxa2NrM2ErLzk5?=
 =?utf-8?B?TCs0NG12dW1xSHlVcHZaVm92RU9JTFpzNjFqMExXdk9USC85MGQvVGd6bnRw?=
 =?utf-8?B?UVpENERoa0YzNE10OXVpaUhoWC82TERXckVLVjNZOTJtUGx2d2RCcStnOHVK?=
 =?utf-8?B?MEprNUNLY0lDK0hHVWp0ay9ERlBqUWVUM0w0NDEyanAxakpZdjV2VWpaa1Ix?=
 =?utf-8?B?bmZKRnY3bmg5bHhaUXpQako4OUh3QmNJdG5sdW5MYU5WRWlXZkFaUEpqeFdt?=
 =?utf-8?B?THVJUXB0TE4vOGRnUWlvZVpZQVl2VU81aU5HRGJPTU1XZTlLdlBWWUxlWnly?=
 =?utf-8?B?cFg5VlZJZHRrcXFNNEltQ2VmbFZyRmFhZ1lPaldianp2bmFjNjRJZ3hVdHFX?=
 =?utf-8?B?NFpnYTN3NHpPSkR1c0o0ZXJHT1hpN29jS25oNkRkaXd5RFZCT1FkWHZOMDRl?=
 =?utf-8?B?QVZPSWs3Z3ZMREd6S3NULzNnbHRvV0ZlalQwOFVnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8492c9c-543d-4d1c-da89-08daf86725cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 08:45:12.8101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/z8qUPoLV1glLZRXPjDDv/xdF4Y1e4B5tPiyE8UyMQZVwzKKEewyq1FaQmpkSFC9bqtfi/M8Pe6MP+TccNXNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_04,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170073
X-Proofpoint-GUID: rwX1q6YOP3JBBlMF3ZfKLSvJXETmP3V9
X-Proofpoint-ORIG-GUID: rwX1q6YOP3JBBlMF3ZfKLSvJXETmP3V9
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 07:29, Jing Zhang wrote:
> The slots in each architecture may be different, so add #slots literal
> to obtain the slots of different architectures, and the #slots can be
> applied in the metric. Currently, The #slots just support for arm64,
> and other architectures will return NAN.
> 
> On arm64, the value of slots is from the register PMMIR_EL1.SLOT, which
> I can read in /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots.
> PMMIR_EL1.SLOT might read as zero if the PMU version is lower than
> ID_AA64DFR0_EL1_PMUVer_V3P4 or the STALL_SLOT event is not implemented.
> 
> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
