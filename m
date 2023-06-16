Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193AD733035
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344394AbjFPLnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344011AbjFPLnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:43:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD35430F7;
        Fri, 16 Jun 2023 04:42:59 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G6P0Es019638;
        Fri, 16 Jun 2023 11:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DnV84vsDa1MeQ+sk28fo2b4O0+HVMtrd3jWdPwDB4hA=;
 b=o2lYbW1LIbwBDdbFE6G04ELYwDdCCR2uIKakCGGsrkZQPeUzZOuSuRKA8Fmdk8SzotoW
 8SgbL2rT/8LeCYtiJLu7XbvCc1Oy8gz0kFEEGyrLzcJAnRf8FDH6Xyeq1ka862TD9Ols
 6G9ayxECee15zKhhxD43AxvMO2UQOhbFTpwPKPtAsd5FEHXJZluYdTSnb4+dPR9vnCZE
 q7JXNrgh3/8wjkcdl4m5UdIbFtLm8UQb4kpkYRgcv290qzACD7IxrOjDnLDfIgxd7814
 DPDLMS0XqhRaWrORlQsC1ZWUytBf733nNdIZ+23jVjbYRQweCvz9jhVXuj6ebuCB4iO8 qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bv56e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 11:41:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35G9JMrm009578;
        Fri, 16 Jun 2023 11:41:49 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm8eje0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 11:41:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDkPgXDo8PusYp9KsD6zOtTajmNnGHvgyK4ArArANLZu+VpNt8iqqsLOCmMxRJP3YF6PzXM0X+3nUCKU9d63yThvIpf2JS1N56dj8T8/wrlvnvdDc+guQ1DYs0S86QZZKuVxZJ4STjAswhdgBV6WPB7Ds/QwitN6ZlSh15oFqQ6quuppNZLeU3miphuRFQkgfIEgQWc4yTHoXTHd8ASUQEJ752UZPDnFWSh5JZEDajzbwLz4vIWE/0ALsCnf7cGWR4ymEXQ+GP9DfIcgoiLtwzhIfgM2pmNqltyLRSp9fH7l0HN3XswVtjGNyLBKU1ajvbuTbi0V0jBzr4S6yzCrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnV84vsDa1MeQ+sk28fo2b4O0+HVMtrd3jWdPwDB4hA=;
 b=M+rrB7VJsG09jxJwaecy4HsDqcpS14XxogVcFHgUeKxn5+oYZ/hSv+BYBHd6uP7OVrYafFSOzOwQ8BKWwlq6uTbxsLkIx/NqSLfPt1Ft1S6okeJol2lcCuLaAk+HBVn1BM8jyBt59xeGHX6lInSouru+wMUyC2RJU2sW6CJCfYgynP2Qn01esEUabRcLPDZUAplYD0ZPMiL8VQOJ51dvWjsY9rbOuYpVadn+BHhJXn39i0JYkbiRm5vx/8mjyBhd4407iEbM3r9UjrE47Qc5lzSAQNslUOdifhNnJDW428PR/97PsHmi9gw8BVgrO0+DGw2RRSRmlXVsnoN3Tabtnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnV84vsDa1MeQ+sk28fo2b4O0+HVMtrd3jWdPwDB4hA=;
 b=ZEg2fRGfyShSKm/B9C68xmeyaNDVXh/GYm1iKxs2aFvU17MS33pKV/xaI9tOFi6OPmT3qRFG08J8qnw9/hDWJ/4quKkVCTVzPl/cvyw97t1XAgqWvGP4AMoQiCPoU/5wo3ULPKjKkfmwR4nyVcySNXf8lPCVblXMSp9ViTw8RyQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN6PR10MB7542.namprd10.prod.outlook.com (2603:10b6:208:46d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 11:41:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6500.026; Fri, 16 Jun 2023
 11:41:46 +0000
Message-ID: <045a49c9-b9ae-bf0e-c4be-858d905bcc55@oracle.com>
Date:   Fri, 16 Jun 2023 12:41:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
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
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
 <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
 <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
 <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
 <5f38ef6c-8c50-5df9-19dd-c3c9fe590452@oracle.com>
 <e4be7189-a1ba-7758-bff3-e7b8d8ff1419@linux.alibaba.com>
 <892f57c7-8ce2-634c-26f3-4d4ab8b2f2ce@oracle.com>
 <079d7920-2030-2e00-a833-5ec6d450f7dc@oracle.com>
 <552eebae-76bb-a2fe-ccdc-11e8a01717da@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <552eebae-76bb-a2fe-ccdc-11e8a01717da@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN6PR10MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: efa7e95a-9f37-4059-45b3-08db6e5eaa19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xyuc+q9KxXYtM8F0z5kjVD9D8jSnK9hgQ8D/oYB+3Qm2RozCXwrFwdYO+UoGqXyIXP55dxlrAy4vqRUBjThJRWWsTz976JdDywNFhqLyR9lrKcVkSJDb1hVVOfTksnWaq9mq40ku5YYJYst+fdSGlKUsOn+c1uPWDZhlZIc56feUUHrNk+530k2FRuVUr4k8uMIXSxDEQumwSbYwxmOWtATB6Yn2KUCXbQZAP+wuWGntR8FT5v2cdhqbg/rkMew/ulJvHTlUl0EGPoRrEZZILXTHwLhIymoRqo9laHiWQDM9ntcvV21bdIs/sQgV99MghNeyUhLbfiwV6u8F6Ma6SbGxC2GbkBMHkcQJo9p+50fKrPyp5NHhulusu12oSFEJb9tSU1jkGn8h4HBMLqSRi8vcK5x3KVcs3xlin0KUkutJ91w9c3O8iX0W5swuOzWpXx0KUq8/XsLu762+pWA87JuQGRh+SHw+ql7GS/piAiVFm5ZbPLR/gzD4I2r49MRj3UKSUkXS+5wdA3a12cK21tVg4eAFXMVlbmEkvJ8ryHZWEFSeN8M8kH7HfXlWXNli7lx+41nv7dHOXW6Ek2ml8l7UL7gXkmcie1Qfx6DWHkfp8e3KnXxBqXG6oAdm7YQHpGsuw17c28n8y93oY0KsIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(478600001)(110136005)(54906003)(6666004)(36916002)(6486002)(5660300002)(8936002)(8676002)(41300700001)(2906002)(36756003)(31696002)(86362001)(7416002)(38100700002)(66476007)(66556008)(316002)(66946007)(4326008)(26005)(53546011)(6512007)(6506007)(186003)(31686004)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2QyaFdLT2s0MmlvaEtvTk9WckNKeXpaaXlrbWRWUGIxbnROYXdMcjdQTm1C?=
 =?utf-8?B?dm05ckZMQ3BhNFpiN3NubDhwK0J2TjErWEdrZllZSkhSclVrZWtzSWxzWFNy?=
 =?utf-8?B?UVZscGlxNnZ3ZitTWDVUenMrYmpGdWp3cXNHbSttZi96MGRaUnRvVU9yc2NN?=
 =?utf-8?B?NVVzdlhrazRRc2RldkhVUkZxYnVvMkVFKzNicUhrV2U1QmxHTkdSeG11Um5r?=
 =?utf-8?B?T2VRZEtTc2xtUXp6cTRjN0J3aUhtZFJQWFVmekxsdzAvMFN2WnVreUM3Z1Zn?=
 =?utf-8?B?VndtbnE0akZkd2N6bG83S0hzbUlsZU9WTHlsR3FZNEZPWWtIbEgwWm1UVis1?=
 =?utf-8?B?dDZKSExETWpFZktTVTRmNkxnL0lJOVZ4cSt5elhFcUhRRVIyZERXUW1aVVYx?=
 =?utf-8?B?Vy9zK3FWZ05yamFZSURXY1hjWWZLWnAzeEV4SHlJamNTaFdlak8vRjhtdk95?=
 =?utf-8?B?R01KRjI0ZDgxSVBkcUxOSE9tT2F2QUNFSWphQ3FYNDI2b0dKeGJrRHNZUmNY?=
 =?utf-8?B?RU5lbWN5Z3FNM0tCcFhEVEVvaUIwMmRLd0I5Z3BCYVpYbHZYTFFnMVUzSVhh?=
 =?utf-8?B?TllqeDBWTjNTN3VWZmRmRDgwWCsxeUlueFNtZlR3c1RvQkR2am52bXZYOURq?=
 =?utf-8?B?QjloZW9raSt0bjE5ZW41ZnRlaGQ1Wjk4dyt3MkJPSWlIbE0wZzFNQnNBSDdy?=
 =?utf-8?B?UkVvcVEvQ0FOL2xxM2dDRXJ6aEhYVkphTGEzZHpuZFJZOEoySDBBL3FFQmpW?=
 =?utf-8?B?TmxNYUsyREM0RnBXdmRSVjZ1cVBtK1BISjdOWVYzMFgzWG1YOVhGQkd0YWNT?=
 =?utf-8?B?and1aXVOeFRDdUVob3k5em1FN0daMDJTK0d4c2QxRDN2NW9VVzJIZWhPV215?=
 =?utf-8?B?VjBaMWtiVTZVeTBxQjV4cnJLR2o5dkNmRmVVRWFYRDBBV2sxWmtEelZtY0FD?=
 =?utf-8?B?cm53bWlLY2ZtWEY4NFROWGNzZVFYaGpPbks4T0NEN3l1ZmN3bG94bXhCWmMv?=
 =?utf-8?B?MnpESVVFbW1uTlgwdlI3a3ROcW9TVDZ3aGs4bExVRXRrK2poS0MwYmNzQmU2?=
 =?utf-8?B?ekpUSDNCN2R0OUtuMU1wNWIzRS9jRmlwRXVoMC9ycGhGY2NHMmJZVGw2eTJK?=
 =?utf-8?B?cFNEbmRCNHd0ZFdJaUF6U1FnamcvemJHTjRNdkhvM2VKaDBVUGxKTHRyMjBx?=
 =?utf-8?B?enBGTW5aT3FScWVXSmFGRHJyS0dkZnQ5UlM4ZkFTRFgvNTQ4NUxjWmt0Zzh5?=
 =?utf-8?B?b2lRQjkvVUg1WVRzdVo4RGdrTnJFeFcveDRNTTVSUkZQYzJMSTFRSEMycTNm?=
 =?utf-8?B?LzRDWFpqYlJaNDNvQWJzbWVTb09BaSthYys3dnpiWUlXWnhnRXp0SmtWaE9I?=
 =?utf-8?B?amJVclUzSGNzUGxLQzBtSS9Cd3BCTys3UDZlY3FFZkpiQXpYKy9Cb0laUWtU?=
 =?utf-8?B?Lysya3VzNXpLZlBlaVpjVUhGVGk4c0h0OUkxSjFlSE1wcktHTXNhZlgrQ3p3?=
 =?utf-8?B?Tm01VTlBb0VneW9TNm5ySldRb1c1dWp3WkUvMm14NUhZTCt5aWFmUEtVSzgv?=
 =?utf-8?B?NmZpMWtqNFZxRUE5WmxXTFBoQ3dmbGNXWWVuaWhxaGtsK0RRb3BhT2tmU2xh?=
 =?utf-8?B?NGNpNlRmRVRHbzgvUlZ2aitMbFgvUjNMd2dCd3cyMkpDcURrdFhFQW9OUzV1?=
 =?utf-8?B?aWs3TFFiaUtsU2pzUUovSUhoa0tvUUhnMkhBNVQ0SVc5Tk83VHJLWllZOEtL?=
 =?utf-8?B?TzhVdU5tdW5iOC9JbWdaUGVlM3NxOE5iRmxuak1pNXkwVkZkdXFseHNYRVZT?=
 =?utf-8?B?ZDhwTmdmdFdwTEVsTmhwZDRZODBYc2ptRjF4ampUWW9TdHNaa0hNT2k4ZmNG?=
 =?utf-8?B?UVJWNnpKa0JLaVZMUnZSMWk4VFdsR0g5dnE0Wkh5YVNEaTVzWTlTNkduRVJP?=
 =?utf-8?B?d0JncGNOMTFia3h1dU82Z3RMb1QyTm4zSzJUVEtiV2p5TUk0MDhzN3czVVVG?=
 =?utf-8?B?d0Vobmd5WUlQK3MwUFkveUNBY3ZLbE50emhkcGI5SnFUdzcwTDdobnFvcklR?=
 =?utf-8?B?SDZHbXJLZVY5Sk93R2U1ZUp2NkZnZm5TYlZHa0tZdmZIOEhJa0lOb2dNKzc0?=
 =?utf-8?Q?RwGbvvVlcJOQtvAoMqz0D/xR6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RUNnaHB3K01XMzlmdER0MkRFNHdPdTNUMGpDZWZLQ3NKK2lnUG1XUVgyMXMz?=
 =?utf-8?B?RnRyWitvN0lTdkxzR1JlYW1BdGF5cHEvSVE0TDdHRUVYNU9kblFLVnhST0w1?=
 =?utf-8?B?S3RuWmRJMUZDOFJINHVQSjFNSGNoRDlLUWVWS1hzTVlqRlBwbDI1VTFObHJw?=
 =?utf-8?B?WmtIS3hpVmVpZzZQTVZUNWpUR3c1RUtvVjk4VEdEanpUS1ZtMzVLMVRsY1pM?=
 =?utf-8?B?T0pTVUNRS293cVlNbVp3N2M1Znc1MTVpaTZOREtVRlAwTWNvRDVxZm9VeGlR?=
 =?utf-8?B?TTZJcy9zSWJLOVBTYTdEVFV2dzZSVzI5eWh6Ym5wSHFHNFFWSmNXYzA4TEUz?=
 =?utf-8?B?MThKdnBpS2M5dUh4U3prOUNxTTZhNFcvZ2FKRGtKbnE2eXBydE14UW1DVnN0?=
 =?utf-8?B?SU5FR00zSHFGZ05ySXQzb1VobzZ1T3dIUjhVWFJoUTQrQnVCWm9wRE4vYzZm?=
 =?utf-8?B?KzRyYkw5azhoWG5kOFhIWHcwQnVndG96RnJLUHpETHJ6a3Y1R1hlN3dsR254?=
 =?utf-8?B?TGROVHBsaW5DMUd0MEdhdW5RVnlHa2R6QVpVZVN5U0p3SWlkMTdtSlV1T0Zo?=
 =?utf-8?B?ZDdpL3JPbVBJQ2hacHkrcmF5N1JmREhrVTU5M0ZmMTJLdjR5M0ExMldBYXJt?=
 =?utf-8?B?UXNIMmZ2WHVWMDA0L3NxRGtwckRVWStTS2pZNS9BSmROY3lmNTdMb3F1NE5L?=
 =?utf-8?B?UjNxdFNXc1dvVjVHY3dmUGhhNGZSTFZ4WUxUS0ZCdWxMcVFwQTZWRDZ5U2wz?=
 =?utf-8?B?bzhmTE8rU0pFT2hFaWlqTWhlUEhCOFUvazBGamlmNW5hN2JsZHUvNzU4UTBw?=
 =?utf-8?B?RVk1T2ZybUxBdGJZSXYxN3VPa3VISUtTcjBIT1BpN3Jta2lIMnJwRFhSdmpq?=
 =?utf-8?B?NHVIYU82Tld3TGJKZEFxbUl1cGo5b0JXRWptZWlmaGF5NXJWaXlSZWZXWmNB?=
 =?utf-8?B?ZjkxRTl4RTJ6dlFuZ3RsYXFaQ1dMdEtZajBuRWlkNmpLWFZROG9mV3FvOXVR?=
 =?utf-8?B?eXZWKzdnYXJoKzhZbzFIK2ZwSzBYV3RBMEhhMDRtQmpMZmJpUTl4bkdHT2x0?=
 =?utf-8?B?T0dGUXVKMWlvVGVTWXRXVzJFb3RHTG1xNk85a0w2SDJNNTV0OVcyT2M5QjNz?=
 =?utf-8?B?eDZVM0h5YXhrcDRVQjlRdWlTSXplVlRIQVptWUNnYWdtUk5NK2hEVXRiVWZN?=
 =?utf-8?B?bTIxclYyUVEvQkZDd3NhZW1jRXA3cmZJckhoTlZDYlBTeVdXR25RSFlESFRX?=
 =?utf-8?B?T2tKOUtTeFdlUUU1dWJXaTN5ay9hV1dCMmVTdDRyOXFtL2RtTlUzTFA2SUdF?=
 =?utf-8?B?SzhQWE9hY29kVjBqcTFHS2hmemhyT1dMaVJvYldyVHdPQ2pqdjVEY3hheEho?=
 =?utf-8?B?WkR5VGpqRTd4cTRTZS94MzgrOWVTcVRiOEhRTzl2OHBUYm1iQVFuNDhiWkdi?=
 =?utf-8?B?MFE4bU9LRktIeWlNeGRia0QwYnBLaHZENDZKUDNtTW9QK1lmRzZDRkF0d3Fw?=
 =?utf-8?Q?kuVGFY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa7e95a-9f37-4059-45b3-08db6e5eaa19
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 11:41:46.7268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvUhskzSAVl4EYOAN1l8Swvg3CCv1V9acJbzPrvkpypDWY5n+1qLI98XEPa7PuvIxgigKjTsGb8EFT//sxa4pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306160105
X-Proofpoint-ORIG-GUID: AZ2l9RNwFE4uhIKXB6uizcf54Vr2E46z
X-Proofpoint-GUID: AZ2l9RNwFE4uhIKXB6uizcf54Vr2E46z
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 03:18, Jing Zhang wrote:
>>>>> Unit is the format of the event_source device name. We should match based on that as well as compat. I need to check the code again to understand how that is done... it has changed a good bit in 3 years.
>>>>>
>>>> This situation only happens on uncore metric. I happened to write wrong Unit, but the metric still matches.
>>>>
>>> I'm just double checking this now. I think any possible fix should be easy enough for current code but may be tricky for backport with lots of metric code changes.
>> I also have code to re-work sys event metric support such that we don't require "compat" or "Unit" values for a metric when the metric is described in terms of event aliases. That code is 2 years old, so may take a bit of time to rebase. I'll look to do that now.
>>
> Sounds good!

BTW, I am just looking at your cmn JSONs in this series, and we have 
something like this:

index 0000000..e70ac1a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json
@@ -0,0 +1,74 @@
+[
+	{
+		"MetricName": "slc_miss_rate",
+		"BriefDescription": "The system level cache miss rate include.",
+		"MetricGroup": "arm_cmn",
+		"MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",

So this expression uses event aliases hnf_cache_miss and 
hnf_slc_sf_cache_access - where are they defined in a JSON?

I could not see them. If they are not needed, then I may be missing 
something...

Thanks,
John



