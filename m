Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3CA6D0C86
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjC3RSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjC3RSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:18:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4687271E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:18:38 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UEEckT021639;
        Thu, 30 Mar 2023 17:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YTrv6zBoJFOinIJ2RuX2B95z28Zo5PZNhEZtD0bbevM=;
 b=jopWF6iszsirhnXt6LHHwO6AeGMWjpjwER6zSiOe3HV1+QLBIdSaQPU0g9q+Q78b+jhQ
 GILK0RT7juuS/z03aRJu9MWUlUy3Yfnr/JIazf8gg8NNUtm8gJ14PZqLPLAu81a3W/He
 10+ztdzZacOS8cuPWCzh/3GWvSuYvJLOSjx1qMnQtFniAcpueCRmTdQFubW8mdMJiG0n
 +J3m31IxZguJuiPV+xNykNl6Eq0y7IeK9Pp78ZChyQnTAJz6MmdgHwhbg6O//qmmmHoe
 ko1tTabEw7MV3Djro69gYhi8SpB8oFHeIqELw0zxKA7a/rdByoolZI6RVS9hTdYBM81Q DA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmpc93ga9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 17:18:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UGLEJ5016622;
        Thu, 30 Mar 2023 17:18:22 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pmyvvnyyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 17:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2AQbutIVs99XPyQ0deMhdYanB3PvKa7IC8Vnc4e+bxeXPLDBEQXE6wpELOu/ZQ8R82k1xES1tTDmEOQK5+1UOj9cM4+r6r/vg67ZdcGA5xK+VQ+0qSihmfrZKgNnxcBFIdZkuV/e/FJQ6YH2olNia7hm6cSMNMcvjgC8ZnPCOhbbQnfDG7bprW5jW3jkDoS7hNa+Sw4xgBLZSVzXV29TioevuBoPfgh/lwZUcOHlv+U1czflHhH6ZqH6fy5HNprq+455EF5VVVFCVBgZMASaeE0kjaJySrsN7682eTjGY0+IIr0HKC45pWEhBQS74W/prJQvs+c1ih5IJQpVk+SrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTrv6zBoJFOinIJ2RuX2B95z28Zo5PZNhEZtD0bbevM=;
 b=TmtQvXbPjcvHY2Wcsx+apQiNzz1T7PKqkvhnc/M01mK2rp7SRc3gLGYwkh63jIgsJHwa7RoH7BB0U1tFEEkR+mImVgQ4Wb7uHgGtDQK1FThpteg2TUrFJpXefoyh5pV6bMAWxPrXIQwaVH6d+emGn1MTKKtOlc5yLTQNhq2shc6R5ICkGKQ6hCc0L6y2HbckEM2aFcl6LCKP1U0EZyJFyyXA70BLjG8kwZF4OmSTPFAPrZpAcgc0STjcXpconAkP3fJn+qg29nTP8mtNkZsiCHIvF9X/bprpII+eeVXqdx9Hm1ze0Iw7zOZejOItIph2uOZ2+ZigpvjpV3oz2+W6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTrv6zBoJFOinIJ2RuX2B95z28Zo5PZNhEZtD0bbevM=;
 b=JLNLu91nW2fXIjBQfZyL+bldEVfYGRs90yhOtdeOs9HHVBoXkMEh9TxNhGS8ZugPD9N1qWNV7v4Zs6dii11Svsa5GJql9Byel34ML6yXhF8veqX3yVR9w2hjdwfovGqgalum4lggMl9UVxesiNpXOzZNzjc22gJaMEhG7+k9H3k=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB4534.namprd10.prod.outlook.com (2603:10b6:510:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 17:18:20 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%4]) with mapi id 15.20.6254.021; Thu, 30 Mar 2023
 17:18:20 +0000
Message-ID: <17698a8b-b917-fd83-98a6-20ea0d8059b5@oracle.com>
Date:   Thu, 30 Mar 2023 10:18:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 3/6] userfaultfd: convert copy_huge_page_from_user() to
 copy_folio_from_user()
Content-Language: en-US
To:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, mike.kravetz@oracle.com
Cc:     vishal.moola@gmail.com, muchun.song@linux.dev,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20230330134045.375163-1-zhangpeng362@huawei.com>
 <20230330134045.375163-4-zhangpeng362@huawei.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230330134045.375163-4-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::25) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3b2df8-36d4-4259-706b-08db3142c212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqlOxwcH2/Glx3UBUbc31kh4dHUBZEbVUiidkrUS1XVzQME3OsVw1mG/dLWXcceLXPmDG0F8Q2h/2pP/n2FcLp05uIqivFRLmYDN1ikcFZ3SFcbtFkirHJ0qE42pwTPqV5nQStl6ZOiC/qx9EASTQhOmPOxIIMnTbHvqtvnmU5Cl0gZDQuVC8nYOvS54hYiVlF4eJVvZ2IMX0JSe+eX/E+AIel8xhKtpY3NTg4mg5yqYt5zTusg6gAMNc7u7zsCIBjIn+D2Lbx8eQQ1n0OwwECj+Xl0h1MNTcfyWRxDsN9Z01LUad8TVBOqqRQ/PgFwEAYUPExlcGFSLscqSuhsTccHdVhv6j1n4Bm+O1Rj5OqmOPLHxaV2ZJ9Sc/ARTgmGRTfL8nqPk2Cra5k4yXqn6YzhuJS/789Gqty8Fu3sfpDR8pESPhSeZLZA70HOTdSnhJmlClxw3qGj7Kg6A6pDnHd9q4LdZZwkByf009c4Yb29xPWkEpugaX+saszpfvz3Am/e1cRyNjdDIPoC2gA16a2qBLT745aDc/ljfmCIBfa54EehneziF5sjF/fR3iyzz1wGzj1Z2ItLrKmt1oJMMgzFcZuxkQ24iUzDGj6tDW3px+/8z5lhOZPTg9B0ZDFRei8cRPgv4iieDYt0+J92e28bzD3WUqrBGQzrHUwVWfyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(44832011)(2906002)(5660300002)(8936002)(41300700001)(31686004)(66556008)(4326008)(66946007)(8676002)(66476007)(316002)(6636002)(478600001)(6486002)(36756003)(2616005)(83380400001)(53546011)(6506007)(26005)(186003)(6512007)(6666004)(31696002)(86362001)(38100700002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTRoWVRIMnRDYkk3dnF6WWl0VzM5akhvSHNpMWc5Ykw5UkVMRTFwbzM3L2pX?=
 =?utf-8?B?NEphTDJMYi8wSjVSMlpIeUhSYVprR1RSQ1UzSVhWbmVhdVJ0R0s1ei96ODBF?=
 =?utf-8?B?NnhETWhkTHNxWnpBUjYxSytJM0hwdmVhbGVmcVRRcWFaSDcwVzl1dElCS3dT?=
 =?utf-8?B?T0RWWDF3VU5OcWNvS25VeDM4aWdOR3VRR2IvVW1LeGRLaDhNRjhSVTlsY2FF?=
 =?utf-8?B?R2lSSWpNSHBzT2ZFdnVmYWU5SEdWYklDUDVPb1NMWFFENll5M0FzV2tDQ1VN?=
 =?utf-8?B?cHpPZDJnUlg2RU85RElVd29yZ1lXd1EwK1l2S01kcUlhN0RjakQ1cVZQKyt5?=
 =?utf-8?B?UlQyZWk2aTVqS3F3cTBHSHN3NEJrcXJvbVpEM3dQVEFLMHdKUCt4S2QxWDJt?=
 =?utf-8?B?U1pRdUYrTGE5aS9TVTRqUlhWSHlWZGZVc2FhYUxZMDFkcGkrejJxMjJqYk1i?=
 =?utf-8?B?cWpxRkErYVpMeW5ra2RzSlZlQ0d2bWlBQlBUc3l3RmhvL1hoSTc4NDJ0K0xL?=
 =?utf-8?B?ajViajBsMmxQREdaNHhPZDdiVXZ0VWtwdHB6bDdhdDBKYWtBYmVRM1BKM0c2?=
 =?utf-8?B?V2Z1dHZwUXVvNTRyenZlaEdvTURmeGNEUzkrM0Fab04xaHk1SVZDVWx0TUxJ?=
 =?utf-8?B?MU5veit3ZzlCcXoxbGhDS1I3VHUyUU40N20wek9mdmhJM1lkd1R2M2ZINEJp?=
 =?utf-8?B?MmFFYVdkSmUwRVZJVU9sc0VuWExxZUJ3YkJHKzk0VTNyTHRuNkJVT0xmZjZS?=
 =?utf-8?B?K0VvL3NGWVZ5MlRUU2gwUDd4bWZBQjZnN1N6aGszSW5TaDlPWFpuWC9CUkFJ?=
 =?utf-8?B?K3BrL3JoZ0MxNm11b1ZFUnE5cWdOUHFuZlp5ZkEzdnZMVmxVYXkyY1ZSNUdo?=
 =?utf-8?B?U0Zic2o1VzdYNmd4M1k4U1F5WHB3SzdUQ0l4TURuUGFCN2xJY3kyNU8vTDZr?=
 =?utf-8?B?d3ZZUGdTOXd0ZDNsZVVHQldJVVlFdlJ2RktyZEhycVA0aFVqMzRHNHZPRDNC?=
 =?utf-8?B?Q2U0eXlaSDZQdGs1eHBHSTMxOERFK3pRSEZLNGsycExHZ0FRRmdKVzFyTFpI?=
 =?utf-8?B?aURGbXd5a2IvSWtPWGNhWVpzUFRIM3RzZWxCTVQrK29pYWt3YUVFSFlDZ1g1?=
 =?utf-8?B?cjY3WEk5MVJNL25QM1RmK3dsc0d4ZlZMR2xIOGxnUXliM212eE0xUjZ0WDJJ?=
 =?utf-8?B?Tmk3S3dURnY3MTF5NWcvWTAwR3lwdjB5TXZOQitZS0RYNS9XQ21QMXJOaStj?=
 =?utf-8?B?enZFa3RwTEs3MFlRQ1FYa3VYWmRZTmFFSmJLNWZJSll4dnVGcFdWN1J5YkR2?=
 =?utf-8?B?cHlidnBaVEdvdDNCMzJhU1ZZeVY1MFhEN0o2ak1RU1VEV1BCQjJpRnk4NnVr?=
 =?utf-8?B?ZmIvbW1OYmNqd0ZHQWxrNkJrV2Y1MUpTcDVXdFl1YXBsUzJHYnhqWHBhSVVH?=
 =?utf-8?B?cllndGZqaU5SSDNRQm1wRUNoaEFvaWZLc2hPT0ttaDNmZlNKb2lLMll1c0FC?=
 =?utf-8?B?aXZnNHdQSUdxK2RrM3BHb2oxa3FWdWdhYWxMNlU1d09YMWJZLzdyNldDT2hQ?=
 =?utf-8?B?ekZLbDlwc29QL0xnUjVmL0xnS0RiOUE1dnFFZWF2ZlZ1K0UzcDZVdkdWWHlB?=
 =?utf-8?B?ckJhdys0ZWppMzhuUE4wUzlWM2V0SWdBYTI2UktkRmVzZUJ3d3E0cU1Ed1dk?=
 =?utf-8?B?MTBMRkhjc3c3M3NzWlNnSHkxejRTdXYzWWF0aXZaTmtEYmRsZUJaajNHU0dt?=
 =?utf-8?B?bVloRnZLNndEcXliS21PdWdnKzNmWVcvcWk2dnBQek8yY3lKaWhCbkZyOEFY?=
 =?utf-8?B?TEI0V3lPSElUNC95bmN0dFZWTWtzRElMSFBlNUJuYllyTmh2dnZrVG5YWDZF?=
 =?utf-8?B?WmtrV3ZXek1vUzc2eEhOcUZUSHBxaXdrcUp4TEJLRzM3ZGJyOUd3Vk82N1Ez?=
 =?utf-8?B?WHBlSy9ENEJkdnFkZldxZFdlNlExaGUzekZSdWZoNllZZnpsOWUyQk1OU01U?=
 =?utf-8?B?YmJRMkRCU0V2VXE3WnRPTXd1T1E2b3dXNlZ3cVZKNGpSWjc3NDVoOHMwSnY3?=
 =?utf-8?B?SUxEekUrejhzQ3h2ZzFDazhqazhVSkg0cHVpU0JFNlVycmFVSnB0Z2dCNE4x?=
 =?utf-8?B?RTNteVJuZG1oUjJ3UUhqWWFWbHRUY2NqTzNINkNHc2o3dmVJVS9LenplMHFW?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RXdkUUZxdGU0QTZUL1JOdkYveGNuL3VsYU5KUEVweVZ2RmdhTFFpT080MDNv?=
 =?utf-8?B?K2dqT2tnRytzZHFMREJIL1hYV3E2dlNtb2luWHpTUmJBZU1PNzJ3NkNIcUdk?=
 =?utf-8?B?aUNrTzM1YXEwVm40WkdpQUs1VzRLK3c2SzZpWDE1Y2NtVjhqZ0g2aEQveHo4?=
 =?utf-8?B?RWZVRW5yQnNOSi8vOCtTWXlscXFmeTBtYTFxUzRsSXI2K005SmJBZXV3SVRJ?=
 =?utf-8?B?a1Yyc1FoQktGemFtL0dESVdpNVU1MXBtT3YvWk5za2NwN2M1dTZzdWJpNVNj?=
 =?utf-8?B?cGk3dnBXZzROUEV0R2J1ZzRtd1BBTjMrQk5hcms1U24zTG0wT1hnTGM1blVn?=
 =?utf-8?B?RmhvUXFEMEtZZ2JUUUxxaDVXL09RMGZFeDlSekFqR1FwcW5VK1c3bEJKY0tW?=
 =?utf-8?B?RG5lQURpUzk5RUdNWndXVmxROGx3UUlQTCtGd3Q4VnB6YTVjNXF1VGdOVHNH?=
 =?utf-8?B?N05Ma1BkREF0Y2didzlXK2xXZkRWbUxEZ0syV1lOWGlxTFRMV1Z4T1MydEF6?=
 =?utf-8?B?ZFhKSXI2U2dyWWlIK1ArSWk3OVFGeXdicGxUdFJaRFFkUTZKY0kvN202M1Rw?=
 =?utf-8?B?VXNXVVlLaUdWSzZCTjBndVBHdE54dVRCd24yRGNZZzRWOFljdUg4T3g5N3ln?=
 =?utf-8?B?YmFUTU1jcnlkNnlZcURqejhEZTNRUEFicDFGK2dBRVlSQ2YyZXNyYitZNitx?=
 =?utf-8?B?djFIMXgzdVBmTm94cUQySzl1NzQvVlFXNkorRVQ5N2MxYmNYOVQ1VEU1RHVK?=
 =?utf-8?B?WHlWYmcvcC8yZDBxZmY2OGYrRWhyVTV6UFgzaitVaDYzUVZMZm5hRDVkZW1N?=
 =?utf-8?B?VHZVUVZNK2NQNFZvU1c5eWpoM1hnMDhDQW9NRDdWVlhvQ1FaL3dYazJlU1ZX?=
 =?utf-8?B?dFdlbU5iQ1hyRVRzT1pjbGtEU0xDazFMRVJSWmJENVNrQzFlS1hqWXFvbHRY?=
 =?utf-8?B?RG9aZ0czZEUvRUhoU3BDN1llKzJwMHRwamZqSmEvSmpGdHI2RHNqeVNDK2p5?=
 =?utf-8?B?Ynp5eGo1c0pLSFFjVFN6YkY3aUFTSXIrZnFwYmxmSzJpamlUUlNjSmFKKzNs?=
 =?utf-8?B?cEFUTGQxVTNSTTg2QXQzN1dzWTlrV1R3czJLUTVFU0pCQVF2Mml4OWtmbUc1?=
 =?utf-8?B?bEhEZ2VoTC8wM1lrSTVsQWlnMUlmb3d4MWxhMjdYYmRGeXZPamhHeURBUXhF?=
 =?utf-8?B?b2htUmZhSjJ0QnpWMUEyWEppV2VpMmM2ZUJ5SDlVN1h3WEVMZEdqQytOa3Z6?=
 =?utf-8?B?Vjg3ZUkxRHZaWFRBZmdldmxvSzJoMjZySzhKZVBQZC9Xejd6dz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3b2df8-36d4-4259-706b-08db3142c212
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 17:18:19.9279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzT5UCbrMGluRlw7L/aMFxuignBYRTaletA2tOprcYx9S/jhnL+SyNEQxqsNIg3CzSbt/vr5fsJnpCusjNLY/Vk3OsXv4+V/X6kbdr25iYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4534
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_10,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300137
X-Proofpoint-GUID: -2HDH8TEortFK78k_Zh3NFjYRCtnyrBM
X-Proofpoint-ORIG-GUID: -2HDH8TEortFK78k_Zh3NFjYRCtnyrBM
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 6:40 AM, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Replace copy_huge_page_from_user() with copy_folio_from_user().
> copy_folio_from_user() does the same as copy_huge_page_from_user(), but
> takes in a folio instead of a page. Convert page_kaddr to kaddr in
> copy_folio_from_user() to do indenting cleanup.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>   include/linux/mm.h |  7 +++----
>   mm/hugetlb.c       |  5 ++---
>   mm/memory.c        | 26 ++++++++++++--------------
>   mm/userfaultfd.c   |  6 ++----
>   4 files changed, 19 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e249208f8fbe..cf4d773ca506 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3682,10 +3682,9 @@ extern void copy_user_huge_page(struct page *dst, struct page *src,
>   				unsigned long addr_hint,
>   				struct vm_area_struct *vma,
>   				unsigned int pages_per_huge_page);
> -extern long copy_huge_page_from_user(struct page *dst_page,
> -				const void __user *usr_src,
> -				unsigned int pages_per_huge_page,
> -				bool allow_pagefault);
> +long copy_folio_from_user(struct folio *dst_folio,
> +			   const void __user *usr_src,
> +			   bool allow_pagefault);
>   
>   /**
>    * vma_is_special_huge - Are transhuge page-table entries considered special?
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7e4a80769c9e..aade1b513474 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6217,9 +6217,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>   			goto out;
>   		}
>   
> -		ret = copy_huge_page_from_user(&folio->page,
> -						(const void __user *) src_addr,
> -						pages_per_huge_page(h), false);
> +		ret = copy_folio_from_user(folio, (const void __user *) src_addr,
> +					   false);
>   
>   		/* fallback to copy_from_user outside mmap_lock */
>   		if (unlikely(ret)) {
> diff --git a/mm/memory.c b/mm/memory.c
> index c47b8991410a..9d59dad319b3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5854,35 +5854,33 @@ void copy_user_huge_page(struct page *dst, struct page *src,
>   	process_huge_page(addr_hint, pages_per_huge_page, copy_subpage, &arg);
>   }
>   
> -long copy_huge_page_from_user(struct page *dst_page,
> -				const void __user *usr_src,
> -				unsigned int pages_per_huge_page,
> -				bool allow_pagefault)
> +long copy_folio_from_user(struct folio *dst_folio,
> +			   const void __user *usr_src,
> +			   bool allow_pagefault)
>   {
> -	void *page_kaddr;
> +	void *kaddr;
>   	unsigned long i, rc = 0;
> -	unsigned long ret_val = pages_per_huge_page * PAGE_SIZE;
> +	unsigned int nr_pages = folio_nr_pages(dst_folio);
> +	unsigned long ret_val = nr_pages * PAGE_SIZE;
>   	struct page *subpage;
>   
> -	for (i = 0; i < pages_per_huge_page; i++) {
> -		subpage = nth_page(dst_page, i);
> -		page_kaddr = kmap_local_page(subpage);
> +	for (i = 0; i < nr_pages; i++) {
> +		subpage = folio_page(dst_folio, i);
> +		kaddr = kmap_local_page(subpage);
>   		if (!allow_pagefault)
>   			pagefault_disable();
> -		rc = copy_from_user(page_kaddr,
> -				usr_src + i * PAGE_SIZE, PAGE_SIZE);
> +		rc = copy_from_user(kaddr, usr_src + i * PAGE_SIZE, PAGE_SIZE);
>   		if (!allow_pagefault)
>   			pagefault_enable();
> -		kunmap_local(page_kaddr);
> +		kunmap_local(kaddr);
>   
>   		ret_val -= (PAGE_SIZE - rc);
>   		if (rc)
>   			break;
>   
> -		flush_dcache_page(subpage);
> -
>   		cond_resched();
>   	}
> +	flush_dcache_folio(dst_folio);
>   	return ret_val;
>   }
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index efa9e1d681ee..b453a4d2a0d3 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -422,10 +422,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>   			mmap_read_unlock(dst_mm);
>   			BUG_ON(!page);
>   
> -			err = copy_huge_page_from_user(page,
> -						(const void __user *)src_addr,
> -						vma_hpagesize / PAGE_SIZE,
> -						true);
> +			err = copy_folio_from_user(page_folio(page),
> +						   (const void __user *)src_addr, true);
>   			if (unlikely(err)) {
>   				err = -EFAULT;
>   				goto out;

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

