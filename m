Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D877D65DB3E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjADR1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240081AbjADR07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:26:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF7F00E;
        Wed,  4 Jan 2023 09:26:57 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304FOWqK013330;
        Wed, 4 Jan 2023 17:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3GguwdnBiPRhJAjql3I6nyqieQoPoKL7T8jbGzS7N6Q=;
 b=i+SA6fYSPvoUFQOiCMXdfL5451cZF9J7Id/2qblhL5P6T7/CzwJYq4XKm1Qh75jbdOuf
 bZ7QoRz+W+TlDfOXc4NNcm89mTqwTY9SksgxC0FlVX0zN09xX4oHIHnV3YqES+ltZ68E
 vxkL3kGhKure8QZfcMggw466keQ96SHBXqMesxePv9D/KL8ktxFxYaWdOcKNomV1322w
 VAxkbZCh+e0k7Ex8QNpJEiMdgwDdvU7xGjJC/RXttUqeG5C8fn5/neh84ZH7ZzA5s14H
 QhKCzsIxwqctzKVFKYUppAp7zkgFfneu6u7jNrj/4aPyWVwxKE8P8GH4z34Pp1rM5/WK KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya70dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 17:26:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 304HQ6EM002613;
        Wed, 4 Jan 2023 17:26:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwcghkwj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 17:26:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APR6yvnDzuMeAMNdK67ZecbnJbqr/45a7uV6OgJH4+9LU7qoe4c82Bck2cF8YBwtk8iXZV/Je9i+/+IGCmFWL+D59gEjyr3UwNE/fktEAxgB0taTsjF73LA3K2G9WIGxqTwU0K78JSOYS0xNkxYWzT17PX2oolB/iSnV36ro+tOP8J6gxcu/4Rq7qmjUDR4ujQMhqHF2g5X27JumuWfLKSKSWfTq8tRVttTk4xUb4DggBdAyhXzcJgpVyzaLy91JwApLz8R3mD/8FZIXB+Pt/8uydjIepZOU0IO3HVYjfVgIjelB2xp6fPdytRJuj7SimqM/gf2x5dYpWrZHAGB0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GguwdnBiPRhJAjql3I6nyqieQoPoKL7T8jbGzS7N6Q=;
 b=Ff3nRzgbq3OxqulEkj6GWI1zz0J2yLDhEU04+hZKLLyHFow1Jyd7H4IDtLLX1CS0Q8YU4U68d0q/nlO0+iNRKFpX1h1uHzh9AMGmGu/nIWQjlVamFQ+y1JduUWcYibc9cKL1Yb7ercimBmNucDJO2MNtJ1CRHHgQPCbRlEgSH2g5Cf1aB1gq7C/Ry/zq7l2Ohjf66PFzmxffBEN/vMH+md3UeQyt4EICJAyuLmC3sbo8XsLpRUfXKUSSQ3oymcis0LK07hc5OylS3xuTFHb3sBcr+BmXgVmfbL9fUuKIKr2AFxw0pirOfTA4kf8Yka6Dy4Kqo5BnBn5GA0h3JJraPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GguwdnBiPRhJAjql3I6nyqieQoPoKL7T8jbGzS7N6Q=;
 b=KObmh5grPksayOlSGTd1ZCcvZRIVMHkwPEf9CIwE0cwJbhFNlmgspWsUQBI49N20KSu5f3uS3e0+P1JjY6Fnd/0iS5ROkmdt4oeuYirjWR1UZTTg8akbeEsHmXclDLTwzsv+EgVxF+fp9c+XkPXrZmychtixjKCp3Z+tYD8J1Bs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6987.namprd10.prod.outlook.com (2603:10b6:510:27b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 17:26:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 17:26:26 +0000
Message-ID: <7aa225df-af25-a6be-9bef-c965488ba43a@oracle.com>
Date:   Wed, 4 Jan 2023 17:26:19 +0000
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
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1f3d53cb-4160-e29d-3934-d6a488d9fd49@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0117.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 740e1f01-2b9d-4451-ce07-08daee78cf2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYwNIvlcJ2IaPxBmIU5tToUYiiD6GDayX71Sya0gqmsTrV53tqzjrqTrfshMmQzQfRybORAdGIwQDlxTlLSq842IL5/yIDwDGHKRPqc6G+UB994CEAQ96/HybmmrrHE2SsNNwq8w1mby8Lfw4G5ykmEKyst/+2SqRthvW6mnjogfvRbUh1uEpg4DeixWqRVZvgNwCRoCI3/UZSZw6YeKLw2DpW045yXJtcA2ILh9lrnOBKbPr55Hqaq/rR3ZQs2N6k9rHU/JwEeW/QN3AJj+lA++nM2Xe25XnG5zBLTaeYRJ6gd1C+CJtyaMfBor/l5RPflAiRxFgoJVRVd4ZQcdsKybPBipE9Qoth69Ob9dyHh7ZWX2e1BL6wTs1vuCYjPAlJgzdr0YMve0HMLTenP5RT2ds65sJR2WNYIutWXrmyicVCDwpF3XTPBpLQw0fwCpTBZf0yYv4f41zVp7MCUFSWZKKZDeTLvjOmTQsy0gSy8MbmSuqVR5eY2VKLl9jTGd7JQe/qmwMrMVWIx4i7D5tRNM0jt3eh4NT0EyemgmGmBD1QS2WYzkGynYV6OrDCHbmWa/97EN5c/6RHBBf+yngH5XWI3fb8TanjgA7b/G3NMqWXfgZxtxQIIUj6jtE3QjnD5Q0JfwdJWHYb4/uAw7YmR98RiAAj08XcwVO+Xfiz6wjTjJBc240m8R4sgrjx4fwDaC1KtNR5cKCGGsJtb7ButZiwjGFx5e4iZaH2TQJcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(2906002)(86362001)(31696002)(7416002)(38100700002)(8936002)(5660300002)(41300700001)(66476007)(6506007)(6666004)(316002)(478600001)(53546011)(26005)(186003)(8676002)(4326008)(2616005)(6512007)(66556008)(66946007)(110136005)(36916002)(54906003)(6486002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU53UmRUQlNoRDNuZUlXcG9zV3czb0dsd0FqVWtoZ0lYSE1nSGhLK21walFY?=
 =?utf-8?B?ZEtidStERDlnRmd0NUpCelBjWnNCOUM5MnFDdVZMMnF1T25yMjVUTTdqUTBo?=
 =?utf-8?B?emdzb1ZmTjRyNVdaNlQrRHpKSVJvcnJJcGlsMlB0ci9BMHppMElJQ3NUOWNE?=
 =?utf-8?B?cWRwY213d1A4WG9yQm5LdzNqVXI5UUtoZE9hSk5RM1JVT2tmRmhyQWkzcnZu?=
 =?utf-8?B?bFFqODY0cDRWOW9tUzQ4eWhVcG4weUo4bHV3STNDemNPUzdIWnBDZldRUURs?=
 =?utf-8?B?eWkwMDhIN0hGbjJncUE5Yy9Ud21LSFNtTnVReEVoOEdyM3dEaXBoOFYzcXlS?=
 =?utf-8?B?bzRadmtaOXMzc1B6N2tSYlRibHFhcGJCSGFmZ0NBZGZoaDZjc2FVd2ljN1JY?=
 =?utf-8?B?M2psTE1ib0Z0cGkzaWgreWlSSGtiSnhJaGhOdkdPcGRFNWMyb2J1SHNObExW?=
 =?utf-8?B?UVV0WlVxcGVNSHQ0L3hQbUl3cVVkeERkLzN5dkZxSGtaOXdseFFyWE9VNlFy?=
 =?utf-8?B?N09EUGpqd1lhaEoycC9hZmxSdHlFZkdZdjdlU0lzYUNZYTRvUnVTaVBFRXRT?=
 =?utf-8?B?amFtTzB3TWVZYjlBUWZ0eFBXaGVKUGxONXV4MFZkTlhGSUVxNWJkNDQrK0t1?=
 =?utf-8?B?MTJJZURPTWdjK0wxbWFSVVFKWUgvdXovQWZPUDc0M1Z3N3NBN1NMb2NaV281?=
 =?utf-8?B?b3hMVTY1TE1YNzdzOU11REpwb21VdzBLZndKeUNOZDUzcXVhRzh5ZVJlckVO?=
 =?utf-8?B?UDl4bFUxTzllVEcwY3JMYXNEOVY1M1RFMkd1RnQwMnY2K0xmTWw4SVpERUZo?=
 =?utf-8?B?SnFjditneVlnWS96am10SXRLZ2dUMXhUdjlsZkJuSUx6NHFDRnloQVo3cHVq?=
 =?utf-8?B?dWRGcmpRQTlpdVBzMjJ0RngveVNveWZsZ3JyZXhMOURBTHR0UHFCU3krd2Zh?=
 =?utf-8?B?WVpZRng0d1Rnb1llMWppbmFUcnl3UURLT1pRMWhTTlVld0RLUzNva0IyMTZE?=
 =?utf-8?B?WFMwTlgyQnNFelE2RzNSdmpFV0JIMG84Tm1mNnFnUXF0OFhtV3RQbjlKWGdh?=
 =?utf-8?B?aGJpaXpSTXZ4elZaRmRWUUF1VjJHTmxvV2w3SnVuNGJ6N3B0OEdFRjI0SFZV?=
 =?utf-8?B?OWlXUEFVVTUwcXdleUQzRDVKNmN5Y29Td0tkYWk5MUVlZVZudXpDMGtiTW9R?=
 =?utf-8?B?V1BuaGFQWDBqQWhJSXJwOUVpeFllR3FYa2pVTmY1bmhlYXJNMlRJakJQQmFh?=
 =?utf-8?B?cXhEZlpncE9GMWZ4RWtLNVJEdVdSREtOT200R0FodFlFeWdibXk4YUI2QTBq?=
 =?utf-8?B?OS9GNkJ5OHE5UGczeTJGdnhueHZ5aFI0OTVETm1kaEJTTkZlVzlCY29BbU1x?=
 =?utf-8?B?VkFNZ00zQXdyMDUxRWtPMFlLN1VKbjRyVDRJazkvcHppSHB1dFByZ1RoL2xQ?=
 =?utf-8?B?aXN3RjZoOXkyZ2VMOUNUQ1A1VFMxcjhYMGl5a2RhcDhjWnJlaE4veUJTU29S?=
 =?utf-8?B?SFJyV1N1V2k3WFlSeW5ocm5RWUpaNU5na2E1enVYSXc5ejEvaVIyaGJzN2ly?=
 =?utf-8?B?ZkU4eGtBUWZqckFySFFwUmpWbU13SmpNMldBYWZFWHZpVEJKekNreUI1bUhh?=
 =?utf-8?B?dUk4d1I3NFlmVytjL3VLL1Bxd0JGWVpWMFZjc0lZcGJVNmw5bFdLNGhpOGJt?=
 =?utf-8?B?cSt4VS9uOUpqNlJmdEJqOFdHQVdUL21iWllDeXMxSUpnWWxZbXZCWlBaVFZ0?=
 =?utf-8?B?dzhCaFozREJ6WEIzcmhsdW90Z0NlOHZpZUUrUnNOU1pFZ1J6UCttZi9WdFZx?=
 =?utf-8?B?Z0RXR3E1eGxmNVliT2RINHFLYnByelU1cTd1Y2NOM29kVkhkNWNlOU42NS9W?=
 =?utf-8?B?YWlmVWhFSUlhUUR2TlVxWVM5TDdrai9DWS9EUmJ4OExhak1ic3RSdjI2dVNP?=
 =?utf-8?B?cXA4bHp3RzZnWmdHOExnM3ZMcTNlS0VSbXo4SnRmSGE0QS9jczFiNlQvK2hF?=
 =?utf-8?B?S2VsRmswTmpaSDZIVFFKeDdYVUVDYjZCZjBhQ3h3OXBBWFI4M0JOOGJLdTJT?=
 =?utf-8?B?NEl1VjhabVk3S2ZMSWlLZEdtR3dIZ082Yk0wd1I2MExGWm1tdS9KR2VXMlNs?=
 =?utf-8?Q?ryuT/Bs4YzrIGyD+/7Ijci7UC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U2hpeHVHZndEWkVzQ0MxaEdteWFTeTlKaUVBSUhTaC9KWmJxMXcvT01KWjRC?=
 =?utf-8?B?c3NFRlpQN24yTjFnN2RrWFJmT1Q1emJ6cGNOeVZXWWNiSXlVMjVmUmh6SHFW?=
 =?utf-8?B?UzkxbzkvQ2NFQUVmUWdsd2ZoT1ByaGx0czBDUEJ3bXRhYlQ0dGV6RktwY3Zm?=
 =?utf-8?B?VXlwK2V1WXJscjh4WHRyaFhUYUNWUG1ickkwS09DQmc4UmNkT0hoakRUT0Yy?=
 =?utf-8?B?ZEhhMkpBMXVFUitWNnhZRVQrN2UxaStSYm14YnAxUkpFdnh0c041T2hMbmMy?=
 =?utf-8?B?enl1WVBxMU05ejNWVlZoczdlM29UOW5seW5DeXEwbUFlYzQvL0E1VkJjTEY0?=
 =?utf-8?B?dWtaVWJ2TzU0SHRlYkRlNFdxSTMrTFcxRDZXVndJcGdkOXhtR3V1cnJDaW5W?=
 =?utf-8?B?SXgvNzlZZzlqUytBTmlHTitNL1AxeWhUam5vOEQvcmtEOWRUaE5MbmlleDZ6?=
 =?utf-8?B?R1hjWGdkbFlCUXdmUHR6TitBRGtDOEdKQWQxMjl3R3FlditoQzZRNTJmNk9I?=
 =?utf-8?B?djZCeWMvSlgwM3RWMmFnUjNxOHlZNXFUR2NEbkh6K0w1dS94eW4vMERaWE5n?=
 =?utf-8?B?UE8yVERMek1ZWG9UVzI3cWJGcXdPSEZoNmllQWlHTXAvSEliV0FWRi85MzFY?=
 =?utf-8?B?a1p0V3FXb0g4a01WVC9yY2FENFpJekpCd0pFRGoxSVV1ZGs1N1E2ak9zODdh?=
 =?utf-8?B?ZCs0dkxwY2dmU1AzaG84MWp2UFR2Z29oN0ZldFljbFRyTkI4aGlQbzVLZ1NI?=
 =?utf-8?B?aHViL3N0eElvV0JQMjAvTEdRRWVIbGcrcFViV1hOM0o5YzUxK240ZE5iU3Fq?=
 =?utf-8?B?OWFEbkpoZ2pEQ0hrR3ZYbWgvQ2tTeGJiN0ZHR1BJdE5zZjQ4WjVLc0VzbmZ4?=
 =?utf-8?B?czVjZjM4cnV1cU9Id21SYkRJY0VBeklpWGptOTdmdFZvOUZXUnpuVElELzZQ?=
 =?utf-8?B?OXpOa1IyMzFnL3FWeDI3enl0ZHhmTjY5THVnWjR3eFFKdkFMQ2l0RnpONjhS?=
 =?utf-8?B?aGFRQ2VKSzVQU0VGcU9nWTNKNTlsekV4cFk4VWpFUm0rQXBDZGFQODZkT29p?=
 =?utf-8?B?S3lYUGtqV1pGZWNobkZTdEZnZXQ5RFVVTjFLRFp1cnlWSDVmQk1mWmxGMnJh?=
 =?utf-8?B?OUljd3BvaThTdmVOeTNDazlaQ3B0UVN0YlN6T0ZnTVF2YVcrSXE5ZGpDTzlP?=
 =?utf-8?B?elcveTQwRjdZelNleDBUbW5qUkdTT0hCOWdpQ2Z1SFNsZFYrcmZoS1N3NzI3?=
 =?utf-8?B?cTFTczVCMUpDZ2FiRFVlTmJyaDM5V3hMcHQzOUlEczlNRDRPRWRoVzlkMGFk?=
 =?utf-8?B?QTh5Uk9iQldMVjF1MGVubk5FcUw5S2s3YTZNTHNPaThKU0JoeGI4TFQ3Zzdy?=
 =?utf-8?B?MjRNajdaRjI1RTdsS0NtSERvVDcrL2hiVTFHV2ZKM2crUnpsN0p5Z2hTYjhG?=
 =?utf-8?B?R1Rjc1B5THhGSWFaRWR3Q01OSG5VYkV4U3J4SnlsbEZrUXYwbVRvTm93c1Mx?=
 =?utf-8?B?S3E2RlR0Q2R2S0s3VVdoZTVkZ0pHZU9TMlBZVXB4ZVBFcVdqM3IvT1o2c2Fk?=
 =?utf-8?B?cnVhZEdOZ2NhRnA4U0NVR1g0SWlCTG4yVHhnQ1ZyRzhnMTNJMmdiangwRWhZ?=
 =?utf-8?B?Vi9CUzFEZHlkbFVXVE1ncVZaQWlCdmNsUHlSK1ZSUjVxZnN5MUUyaFZtbyty?=
 =?utf-8?B?VmlyWk5oL2lBY1JDUmdKTXdYM1dqKzRIMmhHZ3ZMOVRrZWJkTFlPRWxyOWdE?=
 =?utf-8?B?dlhCRnh5SGpXYlNpK2twdkN0T0U4bW04UDFYUkp1VVZNMys4cU5Cd2FBYzZn?=
 =?utf-8?B?dHRkbzZUVzNSYUQ0VWhYeDNONHIwVWY5ZjdTbVNuYkJBajAvZlh6d3VGR05Q?=
 =?utf-8?B?cDk0dXdaZ1FoTmtqVSsxbDdhZ3E3YVc1b3RzZkRXMmV0TGlEdWZiZEwyNTZG?=
 =?utf-8?Q?aYeX/tqyndo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740e1f01-2b9d-4451-ce07-08daee78cf2a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 17:26:26.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKaCoWVXll7xnIC9si/LwIDhGKvmWQZr01pC00BTg6agSmQ5LZyMwInUWzelCv1UTq7LynS49nkn56PtXAmb5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6987
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040145
X-Proofpoint-ORIG-GUID: Fg0bcG08nZAwLOivHije0lZMZnBkY_P3
X-Proofpoint-GUID: Fg0bcG08nZAwLOivHije0lZMZnBkY_P3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 05:05, Jing Zhang wrote:
> 
> 
> 在 2023/1/3 下午7:52, John Garry 写道:
>> On 03/01/2023 11:39, Jing Zhang wrote:
>>> The formula of topdown L1 on neoverse-n2 is from ARM sbsa7.0 platform
>>> design document [0], D37-38.
>>
>> I think that I mentioned this before - if the these metrics are coming from an sbsa doc, then they are standard. As such, we can make them "arch std events" and put them in a common json such as sbsa.json, so that other cores may reuse.
>>
>> You don't strictly have to do do this now, but it would be better.
>>
> 
> Hi John,

Hi Jing,

> 
> I would really like to do this, but as discussed earlier, slot is different on each architectures.
> If I do not specify the value of the slot in sbsa.json, then in the json file of n2/v1, I need to
> overwrite each topdown "MetricExpr". In other words, the metrics placed in the sbsa.json file only
> reuse "BriefDescription", "MetricGroup" and "ScaleUnit". So I'm not sure if it's acceptable?

I don't see a lot of value in that really.

However, for this value of slot, isn't this discoverable from a system 
register per core? Quoting the sbsa: "The IMPLEMENTATION DEFINED 
constant SLOTS is discoverable from the system register 
PMMIR_EL1.SLOTS." Did you consider how this could be used?

> 
> In addition, James mentioned that if the units and names and group names of different architectures
> are not unified, it will become complicated.
> 

Thanks,
John


