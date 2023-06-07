Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5AB72631D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241177AbjFGOmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241170AbjFGOmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:42:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D5D1BF5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:42:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576JrPT011468;
        Wed, 7 Jun 2023 14:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7t+xQ5hc1SWMUG4RMFBx0d0auHC9ike/+kZEIGiIhqM=;
 b=Aw2Ky8iHkXekJZC/vvXbtdHs9qWwgVHPpv04BPkPKxLgCOkrWXqFWFuSihA9bXQQugcJ
 udDt1zedgkp6LNf78Fzee/DIfiNDQ6Sa+O5JScKiNLBE3AyXRC5FciGoi3aEpmXcNqtc
 dfcD+G8r0jUFwq7/wNwqIrJJtKK3lW7Y/78TfTWwXbDYpGMhwJrpYM1cELoM7gvrTEHv
 6QlptXPxF4xcw8vN2z708Umegi3Ta9KEtJ1sKsY/Y9qpuwkzaqtwPZSVXdM+qWbTPqKf
 LzXsA0ePmPr8KfUb6y4VQOVWQWHdI9ekigrCTswxja6k2yrMulzUmXFKGufPFEDK9y7z mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6usypb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jun 2023 14:42:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357DogA5015961;
        Wed, 7 Jun 2023 14:42:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6kudps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jun 2023 14:42:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j02hFdeM0eOWkHbQEsjmVdjvBDYfYWgwfTNYPRtF2gUWUqL/Am4Zhg1sR8jWCb7C78n1Cn3u271iwLYOs6rfafTy01pwRRVu61AV+jocI+CM7tOAP7GI4Vfxu40/KOfxog79kjd8VOsX/Ron6ybJLmQ1jtGBt0dTKcHJEH1tLrFHO91i1g+h0izCyLFxXd202bbpNsPHiloX3nWOmY6IzYTVBdjRhaJDr7cfkoUEf5MooFZdhu8gfyJqCnn6BxRAySJwIRz29MxcAbS0YPD1BAqZyo8nicd2MdSypfojVV+7e+9ytI0GQrPCN/6/02sWIb4Nh89VF1hoMzOICrv/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7t+xQ5hc1SWMUG4RMFBx0d0auHC9ike/+kZEIGiIhqM=;
 b=YNZ1n5zDjmyqHsvt3p6wuHi0GuSJm0J/Jfw6Xlosi9cKcsc+3OgtE+pTo/PjHSToKb28JMaMzuBChMjM1f77z1LPWJa5wuKaYETgS4vb1aTzF827moCiEfdlsOGQxPyIfwbMJIZWUGEhdjjchImOxQ4cUYf808PZ0z9VU7WPZE67ge4odlWEkNhM4UMbOm56poRtqe+HTlq74D6L1fkX1IHujoYCGUvkmALSL4ejXsC6f0q9/R64e7KrvW2ITsX6KZMXWXDn8P3xAqyxP6zwT8NIwa55dnX9O3H85pMISWpEFV2DIm/zIykfMZ/3Cu8JRrGeDNE6W/1XxBgn0lIKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7t+xQ5hc1SWMUG4RMFBx0d0auHC9ike/+kZEIGiIhqM=;
 b=n76bhRoDv8D0s7nXpfreIHbNGboklZekAKrG3YYd+FcaJSDotOeNe2is35Uw2WqFFqhbgkeSjMDjFumzEB4p33mrT6onT+5T7K/I63fEzZRktWlnh+4xPoGOk236KNrEVIjVuHTquHo6OhF9pxAaXqr00Wui6gm4w0dE3IwEtEQ=
Received: from DS0PR10MB6847.namprd10.prod.outlook.com (2603:10b6:8:11e::12)
 by BY5PR10MB4161.namprd10.prod.outlook.com (2603:10b6:a03:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 14:42:12 +0000
Received: from DS0PR10MB6847.namprd10.prod.outlook.com
 ([fe80::e072:679a:c1ed:6c09]) by DS0PR10MB6847.namprd10.prod.outlook.com
 ([fe80::e072:679a:c1ed:6c09%5]) with mapi id 15.20.6455.034; Wed, 7 Jun 2023
 14:42:12 +0000
Message-ID: <3072a9cd-7365-cca3-b9cb-07baf35d902f@oracle.com>
Date:   Wed, 7 Jun 2023 07:42:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        briannorris@chromium.org, nhuck@google.com, agk@redhat.com,
        snitzer@kernel.org, void@manifault.com, srikar@linux.vnet.ibm.com
References: <20230519001709.2563-1-tj@kernel.org>
 <20230523111818.GH4253@hirez.programming.kicks-ass.net>
 <CAKfTPtB11Zwt9bgOJrNVDfs5yY7Dws_vnQBuXZHErSsbn9Edhw@mail.gmail.com>
 <ZH1okIz83ELfjy4o@BLR-5CG11610CF.amd.com>
From:   Libo Chen <libo.chen@oracle.com>
Content-Language: en-US
In-Reply-To: <ZH1okIz83ELfjy4o@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::22) To DS0PR10MB6847.namprd10.prod.outlook.com
 (2603:10b6:8:11e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6847:EE_|BY5PR10MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9e44b8-3e29-42a8-b8b9-08db67656104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJWvJU+wyHx7v+pL1i2FH4Qqf9G+3Bj9E4nv1/pdpJwRMt9pmHTgKNqPdq/61limw5d8Ke886+L/8CqZqgExSsLGf4idsdviZnFBugMxl84yLVpTtliD5QciE+g/gXxdu8paj6uXreWyNDF/CsxIz7I2SRzrALrCKSNFqci7mIqfODNaxtcPiV0Td9grJpwYN9Sxnpp4ix+JkWkZdB2B83hRQlFC39K8t8qd0wO62JHQ7r1t0GstAP/jbVspGSHqrKyuA0rnliqNvR5Bx+Q8mibejBeO2IZUm7foFs7dPQapqwhX4hDY7VTWgQsu+qhxe/OiuOzqNGFHt8Gk6zRD6P/gnG0j1td+uCsbPoYAa5X8fpxUPrYACojxWybYxrAvzNdc7X09TIpKTnyp2xYFl+g1R/dYFu+GEr/eE1E5dqHiYYy2/pJfJSKzN0++M8ILI+KSLGPd0MgBChlQw+Paao5Mu51CU5BfVyJBMzO0WtizMtS2LG0mQPsLos1ulg1l9a9yyNezdLvDGFlm3O4mqBu4DYlq5snjLCI2E7ZygTJC5pLSz9m9MVoeU08r8+xM+Hh8BXY+IfqZuoi7pqSnLdJEzdIic6FSexAzKJYKfjCaiIDX4fQdtNNV/sUpl2ZOuKiSRBTB2MXS4mlARbZccg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6847.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(6506007)(53546011)(966005)(6512007)(36756003)(83380400001)(31696002)(86362001)(38100700002)(186003)(2616005)(8676002)(4326008)(41300700001)(44832011)(110136005)(478600001)(66946007)(66476007)(2906002)(316002)(8936002)(31686004)(5660300002)(7416002)(6486002)(66556008)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3lONzV2Wmx5WGkvNmFCcUI4WXZYNlQweG1kbWcwT09nL3N6MGlVUmZVUVRO?=
 =?utf-8?B?UHNybFlFbkxkcXpxVDN4TUpEeU1RUWtJbU5USG5OdVFGTHRHcHpuMXpENmhw?=
 =?utf-8?B?ZDFPanlHTmF1dUNOSnl6QmlPKzB4MkY3RWFqUXRLWVQzb3F0QWU0dGFYQ2dO?=
 =?utf-8?B?TlJLWGFPaE9BYmVOMUY2bEhRNWQ4QTQvUEsvcHNTMUNkcTMvRjdNZTJYeDZu?=
 =?utf-8?B?WTh2ZDN2RWRmU0YxZXJtT3pLVmR2Yk9LWTRpVDNmN0JNQ0tNdUNSeERKSkFP?=
 =?utf-8?B?ZDh5TXNCZHJSYVBWRFNlaEJuMHIra3g4Y21lUXF0TjQ4T1Nqd0tiaC9MRS9M?=
 =?utf-8?B?NWxjVE1aS1AxQlpVc3JKMlBrR01ESGE4Q0YyVXR0MUoySEg5ajlSUy9EbUZ6?=
 =?utf-8?B?NWZJOHI3NHlFSktia2t1VEFuVnVqZGNNWWxhUFBHa1ZWYUg2YmhFakZ5R0NJ?=
 =?utf-8?B?eDFjRVdPYUFRcDZuQ3lpMFJnK2xkMkxGbjBlejJaY2RGWjZmWStyTkh5ZitC?=
 =?utf-8?B?Y00zKzZVb05lY2t4cDRxZm1BdnM3QUlUYTRidzluTmhjMTdKT25Cc2RQeDZI?=
 =?utf-8?B?UE5GbWZTNjhQc0tZOTNxYVJPYmJ0L2VpUGo3L3RFcEZJNE5HMHc1elE5Nm0x?=
 =?utf-8?B?OVNMREh0d2dnSmw2M1RUVDh1d3VtLzhlTlNHWGZCclkxa0VqNmY5ejkrSUR2?=
 =?utf-8?B?RVZOWGYxbEVTbTVJL2NvZ1RmMEZlNjhWcE5ZQWFkZXVOYTVtTit3WklyOUs3?=
 =?utf-8?B?dWo4WUZjSm5yZ3RnL0t6a3ZWT0dsMWJMTHErNm1HM3FPMmF3UXJRU3U0cFph?=
 =?utf-8?B?Y0JtL05WLzRvaTBzd1YrdVFpbDhPVWQzM3JMV3h3WGhmdVpqSEhHaGxoUmZz?=
 =?utf-8?B?aTRNTGVXWjZuanl1NVc2QTEwV2tvdkpvUTNZMzNrbXBHRmFialRoOFl3QVJZ?=
 =?utf-8?B?dHhnSGhFWnlEKzFuN3E1MmR4Z2V0aytFNnFreUNMRDJUS3k1ZlBZQ3RCRVh1?=
 =?utf-8?B?b3hCMkk5bW5ZSjIrb3YyWG9aaE9MRDhCU2VjSFFEOGNTK0FjazhSb0VwQlQr?=
 =?utf-8?B?MzJicS8wN0NFeE1SWkNycFNtVUFxY0sxQ215aVVIdGtTMzYyTG5VMUFUT2Vr?=
 =?utf-8?B?TXJRb3FmS253ZVNqZ0UwYm4yZHdDMGtRS0ZQbCtuKy9uMXB5V0dyRTRqRWZv?=
 =?utf-8?B?MU5GRURqS0xxRUZiZlAxSzRPTkdaRjkxbUg0anBFdkdpT2hMNHp1VDEvOHZJ?=
 =?utf-8?B?SnBacTNHU0ZxaGsvN2VLQTNWTVhLa2hKeGhPU3J2S0o5WEhVcXg1b0RhVnpq?=
 =?utf-8?B?M3hDSG1LZmo2SVBQczhUd1NtN0c1cmdvZEZ0RUw5Ri9QNzZ5ZFB4czZkdDZU?=
 =?utf-8?B?UDJpUzJ2L2dNcTlYZkVxbFp5alNyNm1GYXNIUDNzRmI0aUVtQVJuY2ZTSUsz?=
 =?utf-8?B?R1ZWY0Z6ZnBEZXozQjZBWllSTWV6MlNqcUxOYjRKcmVLbW1RK1RLclY4bGhP?=
 =?utf-8?B?eElJNDM4bTBRWmw0bkk0QUc1TnlEd1dnQWhTL3pZbUh6R0ZuSFJxWnVzNnRN?=
 =?utf-8?B?eDkzY0diYnlxMUxjMXZFRXJoZ3RQMlk3aFBJZEwwcnovZFFDNnFmR2dlb2dX?=
 =?utf-8?B?OE5MRzR2a3A5RDNGQXovQmNDWGY5TE94R0dEL3VGUktoNmN0bFE5SlFUSkJX?=
 =?utf-8?B?NklpVGlCVzZBLzlTN3drMEo1alJtMmtqNnJYYjE2UkNTS3lXUmp0R0J3dGg2?=
 =?utf-8?B?UkZSUlpYcFVuU0J3VHhMTEo2Ni9GQlBTdWpHRThwTUtyYkdTZ0gyelcrMjlv?=
 =?utf-8?B?VG5sQ0dzUzlrQi9pZ0hzLzJkenhsYnBBZTFDZzF5NDdWQXpVQlV1M1lYMDFs?=
 =?utf-8?B?akpVajJFZlUwNVk3Ri9KcFlmQTdWcXhJbTZXbG9MQWVjNjlQWE5TMFhQbWpC?=
 =?utf-8?B?Y2JnNHlKM21sS2JzY0xlOWV0RHNEVllkM3RkYUQ4T2N3RlZRc1R6RDZtQWRv?=
 =?utf-8?B?Qk00SmxUa2V3VFN3c0dWQUdpd3hydUNvMDBjdTgra3dqS0p3KzdiTmxMdzl0?=
 =?utf-8?B?Y29NU21FS2Z2eGd4U0V3Yi8rV3hya3k2ZGk5L08xQlJUYnZKTlozblVvMzQr?=
 =?utf-8?B?NVROckRMczJlSXN1ZGNBdHNsb3dKcjl0ckhqa3dPRnA5Lzkxbkx2VHRMdHZp?=
 =?utf-8?Q?WEfQ52Rv5jOJ93yKSKe/ss8xqk6WYpkvroPTvQHiJa5W?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QWwxNWduRHF0dzREcG14QVBRZFNQdGZhc3pDdGhTcUpTSk1LWWJJUUhIaExs?=
 =?utf-8?B?MklLejFZTko5Y3VmSUR5WUFLZHlIS3pidHRMQllHV2t0ZFgwWXJLQ0dFSTV4?=
 =?utf-8?B?c0RHZnFiZnhvK2MrSUdiVE82cEdpSHkzR3o4U3YwZmNKUlpZRTByWFRtcE95?=
 =?utf-8?B?eEJNTHZyanZPTWlidS9WMzZiZTFMbHhLckJmekhuNW0xZmFXYlkvYWMrRmxM?=
 =?utf-8?B?aGdvSFBQNndhSThkOWpLeVQreGRacytRMXZQbGJwbXQvTXR1cDBWeEZscGpj?=
 =?utf-8?B?aTlIR2hXMHpzbEt2YUFFQlNYV09MTW5KQ2dsSWtYMDdiVmd6aVhBaGUwb3Yx?=
 =?utf-8?B?M2hHaFArajJNWU5XZEI5VVRuMXBWRkdwMWxrekRDNEM1ZlRYemNVa0pmdE8w?=
 =?utf-8?B?TnRBRW5oMjVZWEFCU0toakM2QURkdUpDYjNJZHhjTjJKclBBazZvdGJ2aWlu?=
 =?utf-8?B?bzlNeGNMdDM3VHhQaklsbytJeGtWdkhCaGdleFRidFhReWt0NzF2YUxLcG1n?=
 =?utf-8?B?R0tNTXk1ZFhLNWlDd0F0SnRsTnhRalZMNGt0Vkdpb3dmWWlwczA1dnNkNUY3?=
 =?utf-8?B?aCs1eExDRjdMeTlHWElubHpiaE1yMVRrZGR3ZVhvMFNCWG1VQ1U3TTlYMklp?=
 =?utf-8?B?cUw0THVIYmZGWU1sc2d6SWZNU2R5ZGpJMjF4VHZoakR6dnlFc2FZbTJJaFVa?=
 =?utf-8?B?NEdKSkdqVkNwZDYxb1NoZlZyNWZud0gya2t0R1doeXc0RjY0c3BnOXpQM2VB?=
 =?utf-8?B?ZE9VRVk0Vm1SOEFVcmkzQkVFb2E1emZRdk0vRDdNVER0ak1JWUowOGhqU1JT?=
 =?utf-8?B?U3J5VkY1TUpKeUZFQnRqbVBhM2Mzck91dVdqQ0lYTklDUlJ2aVN2Mkk5SU5K?=
 =?utf-8?B?YnhDc3Urc1lpc3NCTnZWMFd2Q2dJVmMxZFFQb25aZXhqczF2d2Y4ZlFONWdr?=
 =?utf-8?B?V09GWmkyc2ZnaGpTMXFpazJoUTVSV0kxc0plL1NPSFZzd3hqZmdvbUFObVhZ?=
 =?utf-8?B?amJXZ3p0bHR3aUxmSmFuUGYydkpwVG5uZHlKdDY3TmxObU40cHZ4TitJNVp0?=
 =?utf-8?B?UDI0ZHBhR2swaWxPMFM5SXM2M0pPTGhVYmYveDdUQndsN0lPU21XUmt4Umky?=
 =?utf-8?B?cVc2MnBlSWdsYmcrMG5aSjU4alZZdkRtZFEzQXo4UWdzNmI3cWtpL0Z0L1kw?=
 =?utf-8?B?MXBoKzNPMklSa0I5b3lkeFkwTFptYVNtdllyMmlCaTBFcU9scGhDTERvN1VL?=
 =?utf-8?B?LzNpWG92WkQxSWNEUGFHZENSQzRUejlLaFBvaUhRZDIwSzRFSTVaU3JxeVZF?=
 =?utf-8?B?MGY0cWtaTXJvR2R0L3g2SnU4UWpCUFQ4U2JWcjRUR095Ti9PcGpRYWN6RHhW?=
 =?utf-8?B?SHpGMm41WjNTMEkwdEdFa2Z5eCsxd0NCemlnQUh5MTdNQ2p5bEpuNXdBVXNy?=
 =?utf-8?B?dmxUSjV6emNPSmNrZ05hS3dzK2IzUlJTYjNCWGhnbkxYVjJIVWxHUS95M2FV?=
 =?utf-8?B?Uml6NzE1aGNBbE1iaG9lUE1aWUVrZDlqdEgzMDRTM0h6M01QSFNlRm04K0Yz?=
 =?utf-8?Q?FRikvtL5SThUeAHgCFMaoIFDw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9e44b8-3e29-42a8-b8b9-08db67656104
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6847.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 14:42:12.2261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwrOdGDAYQHk6PMA55cNYRZWWcFJoYQObOwM9r3D+OkzCzdXqvbSnHdMqYp8MagRP2SlfoYlTAMA+HXF9GQCfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070124
X-Proofpoint-GUID: kRpYee9l0fuc1MR_CbCmB_ytpesRukk3
X-Proofpoint-ORIG-GUID: kRpYee9l0fuc1MR_CbCmB_ytpesRukk3
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/4/23 9:46 PM, Gautham R. Shenoy wrote:
> Hello Vincent,
>
> On Tue, May 23, 2023 at 06:12:45PM +0200, Vincent Guittot wrote:
>> On Tue, 23 May 2023 at 13:18, Peter Zijlstra <peterz@infradead.org> wrote:
>>> So wakeup based placement is mostly all about LLC, and given this thing
>>> has dinky small LLCs it will pile up on the one LLC you target and leave
>>> the others idle until the regular idle balancer decides to make an
>>> appearance and move some around.
>>>
>>> But if these are fairly short running tasks, I can well see that not
>>> going to help much.
>>>
>>>
>>> Much of this was tuned back when there was 1 L3 per Node; something
>>> which is still more or less true for Intel but clearly not for these
>>> things.
>>>
>>>
>>> The below is a bit crude and completely untested, but it might help. The
>>> flip side of that coin is of course that people are going to complain
>>> about how selecting a CPU is more expensive now and how this hurts their
>>> performance :/
>>>
>>> Basically it will try and iterate all L3s in a node; wakeup will still
>>> refuse to cross node boundaries.
>> That remember me some discussion about system with fast on die
>> interconnect where we would like to run wider than llc at wakeup (i.e.
>> DIE level) something like the CLUSTER level but on the other side of
>> MC
>>
> Adding Libo Chen who was a part of this discussion. IIRC, the problem was
> that there was no MC domain on that system, which would have made the
> SMT domain to be the sd_llc. But since the core is single threaded,
> the SMT domain would be degnerated thus leaving no domain which has
> the SD_SHARE_PKG_RESOURCES flag.
>
> If I understand correctly, Peter's patch won't help in such a
> situation.

Yes, you have some ARM platforms that have no L3 cache (they have SLCs though which are memory-side caches)
and no hyperthreading, so the lowest domain level is DIE and every single wakee task goes back to previous
CPU no matter what because LLC doesn't exist. For such platforms, we would want to expand the search range
similar to AMD to take advantage of idle cores on the same DIE.

I think we need a new abstraction here to accommodate all these different cache topologies,
replace SD_LLC with, for example, SD_WAKEUP and allow wider search range independent of LLC.


Libo


> However, it should help POWER10 which has the SMT domain as the LLC
> and previously it was observed that moving the wakeup search to the
> parent domain was helpful (Ref:
> https://urldefense.com/v3/__https://lore.kernel.org/lkml/1617341874-1205-1-git-send-email-ego@linux.vnet.ibm.com/__;!!ACWV5N9M2RV99hQ!MWwLTGkdtGeyndhqBm2g_RRyVZQP9lTDPPEawQldKgmaE0QL20ET4F_2mpJcd_ghyOAGyvrk3Blc5FWXCvKbnFk$ )
>
>
> --
> Thanks and Regards
> gautham.
>
>
>> Another possibility to investigate would be that each wakeup of a
>> worker is mostly unrelated to the previous one and it cares only
>> waker. so we should use -1 for the prev_cpu
>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 48b6f0ca13ac..ddb7f16a07a9 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -7027,6 +7027,33 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>>          return idle_cpu;
>>>   }
>>>
>>> +static int
>>> +select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
>>> +{
>>> +       struct sched_domain *sd_node = rcu_dereference(per_cpu(sd_node, target));
>>> +       struct sched_group *sg;
>>> +
>>> +       if (!sd_node || sd_node == sd)
>>> +               return -1;
>>> +
>>> +       sg = sd_node->groups;
>>> +       do {
>>> +               int cpu = cpumask_first(sched_group_span(sg));
>>> +               struct sched_domain *sd_child;
>>> +
>>> +               sd_child = per_cpu(sd_llc, cpu);
>>> +               if (sd_child != sd) {
>>> +                       int i = select_idle_cpu(p, sd_child, test_idle_cores(cpu), cpu);
>>> +                       if ((unsigned int)i < nr_cpumask_bits)
>>> +                               return i;
>>> +               }
>>> +
>>> +               sg = sg->next;
>>> +       } while (sg != sd_node->groups);
>>> +
>>> +       return -1;
>>> +}
>>> +
>>>   /*
>>>    * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
>>>    * the task fits. If no CPU is big enough, but there are idle ones, try to
>>> @@ -7199,6 +7226,12 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>          if ((unsigned)i < nr_cpumask_bits)
>>>                  return i;
>>>
>>> +       if (sched_feat(SIS_NODE)) {
>>> +               i = select_idle_node(p, sd, target);
>>> +               if ((unsigned)i < nr_cpumask_bits)
>>> +                       return i;
>>> +       }
>>> +
>>>          return target;
>>>   }
>>>
>>> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
>>> index ee7f23c76bd3..f965cd4a981e 100644
>>> --- a/kernel/sched/features.h
>>> +++ b/kernel/sched/features.h
>>> @@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>>>    */
>>>   SCHED_FEAT(SIS_PROP, false)
>>>   SCHED_FEAT(SIS_UTIL, true)
>>> +SCHED_FEAT(SIS_NODE, true)
>>>
>>>   /*
>>>    * Issue a WARN when we do multiple update_rq_clock() calls
>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>> index 678446251c35..d2e0e2e496a6 100644
>>> --- a/kernel/sched/sched.h
>>> +++ b/kernel/sched/sched.h
>>> @@ -1826,6 +1826,7 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>>>   DECLARE_PER_CPU(int, sd_llc_size);
>>>   DECLARE_PER_CPU(int, sd_llc_id);
>>>   DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>>> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_node);
>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>>>   DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>> index ca4472281c28..d94cbc2164ca 100644
>>> --- a/kernel/sched/topology.c
>>> +++ b/kernel/sched/topology.c
>>> @@ -667,6 +667,7 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>>>   DEFINE_PER_CPU(int, sd_llc_size);
>>>   DEFINE_PER_CPU(int, sd_llc_id);
>>>   DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>>> +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_node);
>>>   DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>>>   DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>>>   DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>>> @@ -691,6 +692,18 @@ static void update_top_cache_domain(int cpu)
>>>          per_cpu(sd_llc_id, cpu) = id;
>>>          rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
>>>
>>> +       while (sd && sd->parent) {
>>> +               /*
>>> +                * SD_NUMA is the first domain spanning nodes, therefore @sd
>>> +                * must be the domain that spans a single node.
>>> +                */
>>> +               if (sd->parent->flags & SD_NUMA)
>>> +                       break;
>>> +
>>> +               sd = sd->parent;
>>> +       }
>>> +       rcu_assign_pointer(per_cpu(sd_node, cpu), sd);
>>> +
>>>          sd = lowest_flag_domain(cpu, SD_NUMA);
>>>          rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
>>>

