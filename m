Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5772B74E039
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 23:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjGJV2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjGJV2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:28:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC51DF;
        Mon, 10 Jul 2023 14:28:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AGol7r014570;
        Mon, 10 Jul 2023 21:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DFoGuaMoZu011uiC/LnP4ZBtt2qzQO4LgnEC3p+Qg2g=;
 b=wp9tcnHHvh9tQuX2Ov8EU4O53gd+bN+/SMHiCnDZjbwle3iDqGJOw5RR34HYF5yrAbEB
 VJbdMRAMw7I4UE19bfUpS3MNWi2E+LZLjTH9wA/DsvawCQ58okA5o37JkMQlSUGA0w6w
 iXA/pQrVMj6nIlJSG2z4ItVKVZtWtBx8VTpSSf1PaXqqMHRzxsjFf3SCaHJum+X0Iccd
 ITbNQOvT8xDkhDYfFBb7R9tX/N9/q+sQ7vAlTiFxXbAUZBGNt7/t+wVHPhOyisGYzop3
 1pQiVhXYhPB30KZJGxgP1SU81aWAVS8vz8QTJmPedv8f5m0n25DIiC+n7eKSzkbZFSfV TQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrea2sjue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 21:28:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ALKRON022913;
        Mon, 10 Jul 2023 21:28:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx841a17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 21:28:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rz3b5dPEn4KDxDNHZ5G4ptugeXQCpS5YzgrQoGsKZ8l+YbmEY1rI2C8E80iELlWGRDxizmugUGA8RPKnyoyq2yLSvu15eCMEjsCtD1aRT3U8ExIGlOZofuU/+zRrLgokrl5vrXWdPDrL+1tsq06a4J+/tzdXK/FpXbAAri4qrn3eksIuOW7fXC0qDHCyCJ5NoDaGfTZd/7Jw2iBSWkSb7lP0PGF3GVbBoJUUWOH1n2nuAAjjah5dMnLX/CndDp8vmxnjTOqM1wlzJqjTqIh+uOU0G/jQc/9iF4DQkZZUudk8aNSxlqOMDVJoLbZW/TbeKGoET83TzXX3eMR4ajMQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFoGuaMoZu011uiC/LnP4ZBtt2qzQO4LgnEC3p+Qg2g=;
 b=mdS7t11wDhmubxzwr5WTrjuzizrr72uyj2jQWcFQS9LUlCD3e5NQwvEjfy7rvxST0TeeWTVhdzwj57gIKms0Dg5TS+9PJR5ZlsZ3CgRREph+OO6OCerCbP3Qwg4vPWB2ugmnAEdbi3vEjhxNW6FQqaKMyhQu1aST3VrG/Kck/E3Y/jYbt527ZEQ4ZzPt6caZKcqYpT8hPZDuRwJsFBhdV385Cu3OiykmbctN6NjA3TbeP1hRn0bGEvVJHUvJnsV/NkLViny3AWdOE3nJKMTHkqmEmvfvDi8fHf61AnQ4gO5J4XVBMvR/yEms8NFEIz+gHIWxDxbZtBVcP7U6BcGCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFoGuaMoZu011uiC/LnP4ZBtt2qzQO4LgnEC3p+Qg2g=;
 b=mwbBLsTlUDtXq5MJXIcgNjjN5KfydSarmz+XwdQdb2aCe6QOxGay2GKYlIiIyLsJGVLDQVpZwuUbDpQzt9+02Hiu7QYSdgaEyXrqp+kmb8qe/KJcM9JmMjb4qaFNz8VkX9PgS94YcK6x7Vp4FyzuPifaoSIIl4CvrG1cWinzoHA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BLAPR10MB4866.namprd10.prod.outlook.com (2603:10b6:208:325::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 21:27:56 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4c83:52fa:a398:11a8]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4c83:52fa:a398:11a8%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 21:27:56 +0000
Message-ID: <903448cf-b333-cb75-87e2-4bee8d1d915e@oracle.com>
Date:   Mon, 10 Jul 2023 16:27:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: Tree for Jul 10
 (arch/s390/kernel/machine_kexec_file.c)
Content-Language: en-US
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230710113814.4a4916cf@canb.auug.org.au>
 <9536c8ca-a0f2-c4be-d705-2ac1054ebf7d@infradead.org>
 <8a848504-6e4c-ba7a-4777-3175c1fdc6d7@oracle.com>
In-Reply-To: <8a848504-6e4c-ba7a-4777-3175c1fdc6d7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0020.namprd05.prod.outlook.com
 (2603:10b6:803:40::33) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BLAPR10MB4866:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d5b8a3-cd0c-4872-aaa8-08db818c86e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/bQ/AQAWe1ScImXEXD5T5VWgDjFS+hK0MesAWG5yTToboQI/NP7v/NqHJuiSoh6oKaBeWIPGglekjD/Dlu+1VcqCohkXDSMW4cyIknlNEsm+Md9Lbnsgt5SI+f43K20hJkATNuRSOmmW8SNjcX4Tw7Krkae566G5mhv052633bOojfbcAokRiNaywqIxfEH/mbjnRAoQ3Ge+lCXd4SBdvk/Lt83Y+0WFjHJG5p3gkJuMKweRe5+WoVvKqOLmlH9OpPH/iqK3j/B04cYcmkeVbEJC0fHyeDe4tXOnyK5DtdBXshU5w6awhfBCMxTnh4y3h3a4acTAbOcOrsu4WLffdjTJrVDEUviNruJz154Eq+j61mRz5ZhXe1R8l37pKgIT/G9c5TpP82aW/fvwGBWUO78MffTvd9UNZ3gyypw0xGodFiyOO4MbF+ELVGY3LV4czqMgEORC1oIoBCXGR93e+UevFjt0zegyhNUucFEOm5Y3kl5zBdNIPkxFkARgVfNElSGyY8tIU0JuHtgKR2a6yD5YmTOc+GgRuA7AWtFgIunYD/5D2wbn9e0gQ53aYgvOONWDcHe1RCyNtaeB+IP5oNnVp0d2+llingKwVDsPXMo/K4DCq6vkf3VmHgHOU1xTcVaVpTvDGP1oNerg2Om/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(36756003)(31696002)(86362001)(38100700002)(110136005)(478600001)(6486002)(6512007)(8676002)(5660300002)(2906002)(316002)(4326008)(66556008)(66946007)(66476007)(31686004)(41300700001)(8936002)(2616005)(26005)(53546011)(6506007)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjFQeWdIby8vMjlmZkZka2VqdUgwQ29yUHl1TG5LNHVzRGZFY01kczdZQStI?=
 =?utf-8?B?SXZBcWRRaHgwaXJiRTFmQVNMVFVnYzVsRDZ3ZmpqWVY5OFkvejVnREdYb1pF?=
 =?utf-8?B?bjBWK0ZTUGF2QisvcTN2QVg4QnV0aWM0MU9DRmFERW9LbVZGUUhCVHI1K3J4?=
 =?utf-8?B?N3EwY2dCT3p4YlpocWprdmQxNTByZnpGd3lMY2JaaWRldmFHc3Q3UVBKdWhn?=
 =?utf-8?B?SS9hcXY4OVcrU0RJSjBhejdVK0YwcXlXWHlYdlM2dTNIUjk0cWw5WU9rays4?=
 =?utf-8?B?dUZRcitpb3pmbEVpa0J6d2g3Vk5iYkVKNUtWWjRWOVN4SGdreVUxM0YvVlZS?=
 =?utf-8?B?TnJMYi9qSVM1SW8zb0RvbDYyTGFVaUVmQXZWTFFVTyt3Q2FOMVdqT0FOOHpr?=
 =?utf-8?B?dU5lYVpOc2QxMGRVYVZwY1o1OUN2L0lLNWtlNTRubnlZeHltY0NFOGdRUHRp?=
 =?utf-8?B?MGhqNmUyMWVmbS9RSGJoZGxKZDcwOXA1aFBCYTVTYzl0MFVyWVdUdVRId0pV?=
 =?utf-8?B?MzREYW9HdjB0ZzJLODk5M2tGZ3dmV3MzaDVnMmJ4eWZFY21CZUN5cTl6RkZU?=
 =?utf-8?B?UDh4ZlNadnh6SjRlNHVNNnRVdmlzTUgxRlRxMW9YVHRVeG9ZODNwZGtHTk1Y?=
 =?utf-8?B?dC9lUXJFd1hTeHJ0Ri9PZDVEYmswbE05OE9LQnhXRVpaZmRrVzZCdUlQSzdW?=
 =?utf-8?B?Y3hLMmhMNkVtYVMxbDNFemNoZkJ5TkI0THRUUDMrUzJ1QURKbnNoVGFiaGFy?=
 =?utf-8?B?TGJBUjhOV1Z0aU03VHh3a2N5VkVlY3VzSzI5bGxQcWVvUzFNMitwTndxd1ho?=
 =?utf-8?B?aDJIaEZuanZtMllMSWp0T3d3MzB0cXltNVpUUHBkM2ZBOGxFd1NzOWJkRHox?=
 =?utf-8?B?bUEvSXhGRTBuTWFpSlVBQTFNdnRFZjB4ZGxtMEJxT3NxOVRRSEFDSlNydDFG?=
 =?utf-8?B?cmd2QnJtdC80UXBuNzVIRlFNdVBoU3pWUlNSWWYyT0hJL1piR1VJQUZMU3pW?=
 =?utf-8?B?VzdFT3lOUDAvWW0ydUFPVUhIcm9UU2lmQm1rUW9MU2hPMWJIRzEvRE5aVDBy?=
 =?utf-8?B?UEFoRUZ1SjBWenNGNW5Pajc4RjRyc2ZFcUJJWXpKQmxPNFBmdi9Fc0NMSXUw?=
 =?utf-8?B?d1hQODdSeWdmTm8yRVNuUk5uUktpK2lvRDNyUFovYVZPTVFIdm5WL1dISVNj?=
 =?utf-8?B?eDFWQUlDT0FiNmJ2R0M2MTk4bG9iZ0hzMnczVytrdGt1WGlLdWlqeS9EZldn?=
 =?utf-8?B?RjA5WlNGeHRYbS9IbWUrQVRFUFNHRnpwZk8va1AwRHJpWG41YmhmQUJBWUVq?=
 =?utf-8?B?RC94WmJvSWh6anlUM05URnl1Vyt6V25ieEUvYjg4c2RDMjNLNlRNcWwxRGdE?=
 =?utf-8?B?Z0hGN3BnQkZXcHhvdHp4QUxKTmFYN0hXUGhoZnR2RzBBWWNVSVNXSVllNGZv?=
 =?utf-8?B?SWpab1lsRVE2dTgxNTRxSFE2eGdjUDZFemhONEJhZTVsQStGdGN4UWN4QlBr?=
 =?utf-8?B?dnFWT2YwbVpnS1pzVjdIVHhOSVZabmRWN01UTjV3dnRVRGdWbXh3S2VRR3Fs?=
 =?utf-8?B?N3UvcGkxK0NnYWNjTE1wY01OUlRiS3FFcjhuWUVKRzA2RWJqb0VBNlZsODJY?=
 =?utf-8?B?YnVvbG1Vck1Cb2ZuWDN6eGk0Zk9kMXlPUXdJV1lleTFvb2o3N3B3T0hJc09k?=
 =?utf-8?B?N1JmMm1yd1dHNjQ5V2RWaFZuSlhhYTNRd1puSDFkUUpiT2crNUh6TWM0bUxP?=
 =?utf-8?B?V3RtOWoyK1BKd2NycmFkVFljSmhnQlVPOEhzV0VzVUZueXZRNnozVDBQcnRT?=
 =?utf-8?B?SmNtaXFBU3ovUjd5dWxGY1VmdmgxUjBhV2RZSTE1QVZ4b0tsb0xvNWRIeUtO?=
 =?utf-8?B?V0pqNlVDdC9Ucm03dThJWHpDaDllcTM5aXJzM25pRngxNnVNalYwSnNzRTRO?=
 =?utf-8?B?VzV5Y2R3enVZWVBGZTNnVkNtVXQwVUQvQUJmUThjT0ZYcHJnSmQvVXAvUzQ2?=
 =?utf-8?B?MEFMdWpuMzRLUWlKUW5ucExyWGZrM2xxK1orSjYzK2hhK3dxalg2Rk1YZkkv?=
 =?utf-8?B?cWhmWDdCeEdUekVsVGpwYW55WHZlMXNZanFnT1hNejlNemhrRHZpL2h3cDQ2?=
 =?utf-8?Q?hlZ9J1elDYshCKwExABZSaGZN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ruJTlOjpW71DoIrbvfTNgv8xXAovE9oykG8IlcZP8F1l89g+KzXHZaKwjiYnKZOf4FDYgZhk8vxE3hVLJpwba8nCG8bT2zGYIEFrCu9wT/jVgDSxujDyTlVHh9G9rWoFhyDT6lzEnxOXwPVcb6w48RM0MgJ52JcCBAyERhvEV3V8qg+PTiBoZ8tJ57hks4HFBmhtbD3bIc4tiPLRxL6OrcTgfgW61nwuw891CaaDRtsDZtw3o3R5nrGg7u0xJuifkN51mtEQhyL6XaUxUDDPvKANVeADZvmrEc1D6qY4Za2lmbDhBugHiawPcxMcMkXLmJTZ16DPzw7AQ7fcO2Eq4asltIKp18hq96JRFEBnJdZB342As3vikdC3FwCjb1zXRpUOzciq5aHNzpgst/1/OSgQ3/TCfD0Zr1h/tQOGycxY639TWOuc8H+iXYrZDrCovYMsaM+YRwumwELIGehvKk2/ArgBkAQR/FNgqPbKsXhgb6BdXzpnAEcXpibzuLkneQi//GtBw+SVAuMz9Hay+Bko+Hux5AyD3nGN9Et/l8mumkQJvsvcdkGmQDV5jLqLVb3i6PUYCljnw8q9alWVY1LTAFHOOybuz6QXNgO646HsFHGOeOGRBe+SrCSxt4+gBHvd7vQ9sOSlA1rSVs+e3nZqUMx1OZm1Sjot8fGkKi9vLOt6GkBNVZCv5JIpcAdh8bKvRFkQFFjTwwn3Rc8nQj5GbkL0tdzFgBix6blWLZhxgJEerCo6t7sr/iD2gmc3U0HudAuNCvcUBduRmyeqYczYbmsBO1+kF2F5KviMQ6Qoe16Vjz/IHkQ+KQJ87KZPmLs6VnR/RNb0g5UWyVfg8A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d5b8a3-cd0c-4872-aaa8-08db818c86e6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 21:27:56.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdCcGJ/HLyIU+09LYTVboF0wkMyM7SFzhpYyt595L+6qYUCodwCZgjqVBtZUSSMy4sQBtGJgr4WjY5llPa+b8R4Px/9UiEpyD94EPtlXeuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4866
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100196
X-Proofpoint-GUID: UQjXfNzPmU6AKhhZDATxukLu3AJRvnWl
X-Proofpoint-ORIG-GUID: UQjXfNzPmU6AKhhZDATxukLu3AJRvnWl
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/23 15:23, Eric DeVolder wrote:
> 
> 
> On 7/10/23 15:11, Randy Dunlap wrote:
>>
>>
>> On 7/9/23 18:38, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20230707:
>>>
>>
>> on s390:
>>
>> ../arch/s390/kernel/machine_kexec_file.c: In function 's390_verify_sig':
>> ../arch/s390/kernel/machine_kexec_file.c:69:15: error: implicit declaration of function 
>> 'verify_pkcs7_signature' [-Werror=implicit-function-declaration]
>>     69 |         ret = verify_pkcs7_signature(kernel, kernel_len,
>>        |               ^~~~~~~~~~~~~~~~~~~~~~
>> cc1: some warnings being treated as errors
>>
>>
>> Full randconfig file is attached.
>>
> 
> Randy,
> Thanks for this. This appears to be randconfig testing against linux-next.
> As of right now, linux-next does not contain the v5 that I posted friday.
> The v5 posted friday was picked up by Andrew and over the weekend no fails
> discovered, and the series currently sits in mm-everything branch. So hopefully
> it will appear soon in linux-next!
> 
> Let me know if I misunderstand the situation.
> Thanks!
> eric

Well the root cause is a missing SYSTEM_DATA_VERIFICATION. This was discussed
through MODULE_SIG_FORMAT thread. I don't think v5 changed anything with
respect to this issue, so it will likely reveal itself again.

Since it was agreed to drop MODULE_SIG_FORMAT, and my attempt to select
SYSTEM_DATA_VERIFICATION results in same circular dependency as with
MODULE_SIG_FORMAT, I'm unsure how to proceed.

The arch/s390/Kconfig S390 option has a 'select KEXEC' (but not KEXEC_FILE),
maybe we consider adding a 'select SYSTEM_DATA_VERIFICATION' as well?

Thanks,
eric


