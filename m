Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681BC73A2A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjFVOEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjFVOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:04:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E318C;
        Thu, 22 Jun 2023 07:04:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M7pnCI016194;
        Thu, 22 Jun 2023 14:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CWdBFx2MY2rEIIpwXl64SZ6vJ8FuNTDzeEyEKpVuVdQ=;
 b=iMRkNWnERSQAwrAYuR8KxRV/aU7LxyCvPqcS1SXIPUZo0pNPOPcphnNRfnZChEbCjMLb
 y++2bB1MEvseoNW0G9TSdZt+ycG03PT0SHhq9Dr022mCtU6AiPFtGyEfykKu0WkOg+12
 R+Vyy1R923IBZq6OMefFNwaiN/QqTFRuf7JcNXJilofKjCt39pj/9GO5EWd6lJdev4jI
 WGoUILCswsxIg9jTLu736Kgbkt1nq44AYjqmDpgPrjKnLSUYlsgsy8wpv++mXSLpG+bf
 oTV+OiHAxgZmYgOwRmX8wFgOw42EtgrPjYlMBMtWv+wrJl6ULlJegfQ4Fr8Z+2pULOTn ZQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qa9qsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 14:03:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35MCecTg008185;
        Thu, 22 Jun 2023 14:03:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9397vpux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 14:03:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4D5AWv/ihXI5MYBoJomx732Ykvc0gkRtvIKinI4dW5seo0eQz+FN5LKXPzIYxP3GK0ftxSAwGXqJXcaVaHW6IAemGUlycMg4wgQkJdvRpKDyWs3ycsd4JWPA+a1zsb5o8C7lT1vol6VrFmDFFlM5U345Tpc9Q6OxU9ksEjnYqnfEpM4eLwztt0regIPZKxLiyKQECdwPw3ZVWqO65KnOvwNoK3HsrmBkCBxmaSrTOhjPY9+BxVhLCM1w+9CBteWmpRxeyYxGFNTZVo9ewDPgMlFZOQzB3g2WOhxd3QdxUaOqtv2ylNUhJABt/xCYtoet8aJqkAw3bNaVFiIO6ucnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWdBFx2MY2rEIIpwXl64SZ6vJ8FuNTDzeEyEKpVuVdQ=;
 b=AqIHqZfZxjcBNy31t8U24D4hp7WHrMdwiLrFRXEH4QybP2ENnFpE5+8OSZemK4IoZgSehGGrL2MIZvEqslQPt28RcdQxyfJygLv7xfv51EArQxMYd5pxJXykd/YPHb1BzjyzAHvjU9mRsdBHdPltulpNayl3OFd6xyUuImO27V0nLp/2MbUbr2atyfa0n3cy2AzfcwVyNEVC2nAZGu93pHJDkduAeNpoPwM7mRpYsjZOEneX9XLXHl1SDLilhvWFN1zCh5zC7a387D9eymcpP8UgOpTKrYUVLqg6tKzj29UExYBxCJPhlBk1/X9UTJltVIz2S2nzC10xes0xf5n6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWdBFx2MY2rEIIpwXl64SZ6vJ8FuNTDzeEyEKpVuVdQ=;
 b=CTmvmYRTAymlEw8zuxj38ew3viAvjNtlDUoU+/BSg6bQug2gXahls/hAnFAqMmn0oQbSmwInPHMD/CFNu7YUKC0o2saDk8cBilkFby9TwFc9cHFhE7NxGoFqybsgqTg00vDTiegC1wg79t7QeJTxEfF1QRtPp+tTfuELGa1Glfo=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by BN0PR10MB5256.namprd10.prod.outlook.com (2603:10b6:408:121::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 14:03:18 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 14:03:17 +0000
Message-ID: <288ff2b0-6642-3a46-6df1-92d4a29ea944@oracle.com>
Date:   Thu, 22 Jun 2023 09:03:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] perf vendor events arm64: Add AmpereOne core pmu events
Content-Language: en-US
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
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
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <e8ad583-9650-2ad5-5447-a95ac9fb686a@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:610:38::18) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|BN0PR10MB5256:EE_
X-MS-Office365-Filtering-Correlation-Id: feb1d78f-d88f-4ea0-2cd4-08db73296d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azgMYcDDklY1YiKqz61lVz6EOYDad12RIdvSNFkxUecAbPPVxepWxna86qPBJrtl9jmYq7Dedm0fklhtVyx9w5QVGA4DrA5JVCW7JcyUPatzIh4obpwoXj/p7zi+fTjOAJBMBlMRIsW2WTY0SywZpcI2MEPQYPQNB4EHxFNcnp+kiheIB+8UzJYz213khcELFq2hyNCPWkx8c1uJ4GMjZh9URG0/iX2ynq8w81oqd5x1QrPlw4vBd+rkgQISXQMPOqwpi7l46VB+uIyn7PPTf0yC2TQLEOjEPibszX0nc/zn/m2N+apvIr68LWCb7/HepFHVd4dQ89+oiOVd6vhji026IhwZgmPA9VIfYMjgF0hqwjkaQHwl9KOTlPWWEbpJbUQ3Ur4vmkHEC1a/sc21S/mnz2Ut1qWgCPh/vtlfPGjcH8ifIi6Ovi76G/NjN3UCA7GwHZP7eLm4eiznpE/oVFGSL4dgj4AC33+qqe/8j78Ri1jWjhIiaj+oV/cAu34/vp0JWQKg/twfdDhRlaojy307jT8T0MJuIgGmojmhLSQcORTFaimCTvVbxi2RUcQwuDGoFdHI0clKh1rgWFs5iKhdsTVZxI/hyxrvaIdaNpHw/J36x1nQq2xUg5+PLKlR6Wg1H96aSQq1ajZg+JKolg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(7416002)(54906003)(478600001)(8676002)(5660300002)(316002)(8936002)(66556008)(38100700002)(4326008)(6916009)(66946007)(66476007)(36756003)(44832011)(6486002)(6666004)(2906002)(41300700001)(186003)(2616005)(31696002)(26005)(6506007)(6512007)(31686004)(86362001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjFtQkNKdDZ1VnJtK2RPMDZBckU0NkQ0bSt1YWVldThpUVdMRlBYTExtS1pF?=
 =?utf-8?B?ZlpLSXZESStYUFlYQ0h1Umx6VThmWmhWdzNNd2hLZnN0UlBSMGh3WGdXQmZX?=
 =?utf-8?B?bDY1T0ZXYzJmZGtvMGh5dGpYWE4xRngyOFY1TC8yYy96dm15M0NHRDVwOWZO?=
 =?utf-8?B?OVhlSlVSMkF2T0dUK1FiVzRVa3lBUGZLWVBybzRTcTdDMExPa1JWbjgzeWFr?=
 =?utf-8?B?eVpPNUJMTmpCc21uSjh5TjhmZk5BaEVUY2NRdFdkWmJhRCszakVuaTRjekVr?=
 =?utf-8?B?dU5MYnhxME5kaGNWSFNIVnRyLys1YzF0czQzZEFjcVBSSWFrYk9OWnNCdTha?=
 =?utf-8?B?emY2QXkxZ3IydS9XcFJLT2gxSk1uZnpna0xzd1hGcGZxUXlySk4yaFQ3M1hU?=
 =?utf-8?B?R29uME1NV0kvK0V0MVc4b3RTNXRzU1VyNUdPNkxhMnhGeksrcGt0RndmSXRQ?=
 =?utf-8?B?djBkbzEyY3VCN1piT1hPaEllWjA1TXhWMHk4bjhEb2crY0hTaVpySmtwZVVw?=
 =?utf-8?B?Tklham5NUWYrM1g3OGw0TjNUd2hXcytqenIrZmowdFJla3pWUEVjMWNVV2tF?=
 =?utf-8?B?K3FYaHVlRFBvMU1paVBGeE01S0JlWjc2UHNYRHVPNmhpWFNIVjlWT3FGeHhv?=
 =?utf-8?B?MnlTNXI0U09BWGpaTnZKWWdWeFBiUUNjK1RVU0tEeDBmOHVKeHF6ZTNld1o3?=
 =?utf-8?B?MEtLM1Y3UUVFK3dLQXFFTys1N3B1Q2ZuckRnd05kREFEZXoyZEl6SjNLOTh5?=
 =?utf-8?B?ckMvYTE1R0o5WGE3UU10QmU1ZlhWeE83MXdYNlJqbytHZEwyc29IbGV1Qm1Q?=
 =?utf-8?B?dDRxRTZhbHU2cDA5VVg3MjZKQ25xTnViTkh5S09ra3VTWS9rbWc5eWlEUkFD?=
 =?utf-8?B?b2dHWlQ1UXBzc1l5NDRiNVJ1ZDhnSGRVMmltczNERUZCS29XdytaK3dmVklB?=
 =?utf-8?B?UWZMVmF3d2Ridlo2WlRmYUhFY0dDV2VQeDV2R1k4U0NnckR6UFhQUWRSQ0Vh?=
 =?utf-8?B?OHlIMktKdzdoMnFnY3FZNVBIQXJWN2xXMXNiakpKL1pETnJQeHRXakNoQ2h6?=
 =?utf-8?B?RjRMMVl5aXdMbFQvalRXdnZCOUMvUTFQeVE0Ukpyd3NkNUdNeTNFVjViOGsr?=
 =?utf-8?B?MExpOVkxU1NIc3ZaOHB0dFhydnNYSzJ3YTJqbkZZd1VqZEFyY3BmVXgxZ3Ba?=
 =?utf-8?B?dS9Mc3EzNCtGdFkvNW94ZW41ZXovNjdwSkZpSHo3MzBEUHdHWEdxTHR1b001?=
 =?utf-8?B?bm9EaS9vSGx2ZHZOUktyai9yd2dzS05Rd1lCb2IxQ0gyRCt1Z3BFVmdrQkx3?=
 =?utf-8?B?WkxwUXpqdG1pc0htcXJkUk9rSWFMcmsvYUVjdWRtU24wNFhBaFlJOUpYT3lD?=
 =?utf-8?B?U3AxVytrQTgzRzFIQ0NkcmFFaStBSzNTNkswbXJkZ2FLTWgwbGZ4QlZtSnBp?=
 =?utf-8?B?VjdEeHZLNjQwNUpnOFJwQVBoSGJidkFOQ1JRVGJyTEJFVmF0WTNvZTIzTk8v?=
 =?utf-8?B?TkJnVStpcFp6WmNQRVpWaERMMnFUaFdFMkp2U0dFMy9qMEI3SEt0L25PTHN0?=
 =?utf-8?B?Uitra2ZudkljTlh4Y0N1ME85dTBDZTI0UlNDWTVHVm9XZjZCeThEdGpNY1JV?=
 =?utf-8?B?QXZ6M2hXTG9jdVBiZ2gzRzJyd3ZZdlNjbWFQQnIwcU4wdnlrZmoxQlZTbmxH?=
 =?utf-8?B?eHV4TDY3Q0RTUUROYndDSDd4SDhlUkZtKzZ2L1FNRWJnaW1DWjM2QUo3V0Nw?=
 =?utf-8?B?MEhKNWNkVUhuek10QTBrTnBHUEp4eS9xU2ZCMEtyRUpQekpNZkowb2NRb2hx?=
 =?utf-8?B?d05ETXR3WE1pMFVHT0V4SWlTMHZSYU1GaUI1dCs1NFlTVjl2cUc4QSt4RWhF?=
 =?utf-8?B?eXF5Zi9sdlQ5K3M4WVBqRlJ3akhXa2VPR3lWOTNjb3hoTW4wNjVUd3NpL3o4?=
 =?utf-8?B?cDNKOUZaN0paZUxlbWZPQms0MjdoRFA3aWhBN001eGtjNEpodE4rRHRDb2ZN?=
 =?utf-8?B?SS9kWXdDREJuYlZZdXRnQ2xOMEFXTHVKd05xY1I3Z1NDU2tXT2M0dmpmRFdY?=
 =?utf-8?B?bmwwVGVyMmdkUE82OTVsOTBZVld1TERWWXRJR3pSUFNxdFFQODg4UU1OWkxS?=
 =?utf-8?B?MWFwZEFyRmJPUlhGUlVoOEw4Ry90REdYSlFoWUFoUVRUZHVhMmFpaGd0dGRt?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dnhGeWp2ZFRldUM3L1Vrb0UreVRWTlFJVzBxYkl4dmluNWVna21JUnpFOVlv?=
 =?utf-8?B?dzJvbDVYTDllSUZKMEh3R015RVpzamU3WDB3YUZralFJOTJFUml5NXJIdmJT?=
 =?utf-8?B?V2FRWUFCWVRmNWNBSk9QWW56T1kyaUhxT0lnMjNXaGUxbkttSm5Bc0Z3WFRH?=
 =?utf-8?B?TFloNHREMHV1NFRWVkFDL1JyZ3FHckp1MG1PbWdBRmsvUXAyV1k1RGw1L201?=
 =?utf-8?B?NWJUZHBaSllYeWppNTFsTTl2V0xETHBaelhCRSt0MEp1SlNqRHRiL21ESnpT?=
 =?utf-8?B?NWdyNWsrd1oxUUFGOUl1ZXg1Ly95MURXVHMrYWo5aXlSeXVNQVNVd1hjY3Js?=
 =?utf-8?B?OTV0N2VRWVRLTGo1STNGR3dQSmtzcEYvM3BkU3k3ckNNMXNwa2VhYk9KNGQ1?=
 =?utf-8?B?OGxNa29OQzFubnQyUkIxdTlESlBnZnNzeEdaVnc2b2xtZmtxNUo0enppUkd5?=
 =?utf-8?B?NFAzN1VxZjFkYng5YTE3aWtSeERoR2FrdjhHNHU4SVQ5ZjhJV04ydHljdlN0?=
 =?utf-8?B?dmRFZWtjN0FNa2ZVRW42ejJBTVlTWnpkQmJnNFY0V2MxRHlmSnRXRGd2R3hH?=
 =?utf-8?B?ZFJmcmJjSDNrWGRDNUVOdHd4QWNyOEdyY3VVM2dpQUE4NnRwL1RQV1FMeUhY?=
 =?utf-8?B?QmcrdnpWZlNvMWJ2RkJhNU9JQmVySFdGWjlDRFppNElQd1pGd2kvR2ZiNWI5?=
 =?utf-8?B?MkgrSUFxSHYrNmhlczZCY3BySTh1VWx5ZkxiSHhDcXhwQUdHM0hKeEFoTDVr?=
 =?utf-8?B?UjhldzYrM1o1NGJDdlgvbkgrYTA1QmVkLytpRWNvcWY4UGY5YnZwak9uS2FB?=
 =?utf-8?B?NFVGenFaMXF2RTBoeDNUZFpMTzZQZm1FcWhyNFFHS01HNEVhZE1VLzVXM3ln?=
 =?utf-8?B?aTZPNkZlWnFqdksxZ1NvUlJDdzFKS2JOOUIrMEc1TlNYbVV2Wmo2OUZIS2ZS?=
 =?utf-8?B?Q3kvUVpvNE9tNUZ3UTd1QTJ3b3FjS2V3ZFJBZloxNlJoNWhndDFWaEt4U25Y?=
 =?utf-8?B?bkQ0RzdFYjcvV2xzRGZaY21Ra2svZUcvVzJVNTBlWnZvRHJBUVNEZzZkY2NT?=
 =?utf-8?B?VGVrR1JyQ2srRGJvWUwySk1WRHl4MkhNOENRTVF6L3IwVVNoNUFYNU5Fbmt2?=
 =?utf-8?B?aWE1ZUd1KzFuM0RMT3IzQ2d6bnhEYU1qcVIxY2JzTmNrN3BHcmI1bkZqeW43?=
 =?utf-8?B?WkpnOXJpaVR6UEo0aFFIWlJsVDRzby9iYUhNa1VVU3pOL240bytCM0xvKzBC?=
 =?utf-8?B?RTU3VHpaNC94OWNrNzZoaUhqRCtDalRrd0FYdkY3bHBIN0hKUnlPMStIRkU3?=
 =?utf-8?B?V1d1NkRreGlhL09NMHhEMnZhOHVBcHU4Z1pnOW5WeGxFOExpZkE5OUs5OXRy?=
 =?utf-8?B?UmhqM2VvL202SCtqOVpSQ3BNSFIvOTVlaUt6Q3B6SE9nTXZESmJReTAvQmgz?=
 =?utf-8?B?b2NqMlBmVndabDdKRjFraVErcjVWYndUUlJNYVhHeGhPRHkvNGV5Z1BrbnRw?=
 =?utf-8?Q?i0o/9GTgKZ+4oGSCWXFW+KG1e9C?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb1d78f-d88f-4ea0-2cd4-08db73296d78
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 14:03:17.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HXzAFsY4Sf73hsaVlte9WN/BLteHh1SP73imSHJfPLAJDqBLbWWFGoapdgX8vo1FG3XXWEUcq2bZ3+TOhDWEYIN76rD0ck5Hn9yOI4eMvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5256
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_10,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220119
X-Proofpoint-GUID: ySoUAnG0FCADWoikDf_NZqrW0K-QZYSK
X-Proofpoint-ORIG-GUID: ySoUAnG0FCADWoikDf_NZqrW0K-QZYSK
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 10:27PM, Ilkka Koskinen wrote:
> 
> Hi Dave,
> 
> On Wed, 21 Jun 2023, Dave Kleikamp wrote:
>> On 4/27/23 5:32PM, Ilkka Koskinen wrote:
>>> Add JSON files for AmpereOne core PMU events.
>>>
>>> Signed-off-by: Doug Rady <dcrady@os.amperecomputing.com>
>>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>>> ---
>>
>>  CLIP
>>
>>> diff --git 
>>> a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json 
>>> b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
>>> new file mode 100644
>>> index 000000000000..fc0633054211
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
>>> @@ -0,0 +1,104 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "L1D_CACHE_RD"
>>> +    },
> 
> ....
> 
>>> +    {
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

Thanks. I found it trying to port this to a 5.15 kernel which still uses 
the c program.

Shaggy

> 
> Cheers, Ilkka
> 
>>
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L1I_CACHE_LMISS"
>>> +    },
>>> +    {
>>> +        "ArchStdEvent": "L2D_CACHE_LMISS_RD"
>>> +    }
>>> +]
>>
>>
