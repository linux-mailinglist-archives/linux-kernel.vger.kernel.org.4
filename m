Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5FB7478C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 21:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjGDTmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 15:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 15:42:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDF6010CF;
        Tue,  4 Jul 2023 12:42:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B7961655;
        Tue,  4 Jul 2023 12:43:30 -0700 (PDT)
Received: from bogus (unknown [10.57.76.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DAE53F663;
        Tue,  4 Jul 2023 12:42:46 -0700 (PDT)
Received: from DB9PR08MB6571.eurprd08.prod.outlook.com (2603:10a6:10:25b::18)
 by DB8PR08MB5481.eurprd08.prod.outlook.com with HTTPS; Fri, 30 Jun 2023
 15:15:01 +0000
Received: from AM6PR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::14) by DB9PR08MB6571.eurprd08.prod.outlook.com
 (2603:10a6:10:25b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 15:15:00 +0000
Received: from AM7EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::49) by AM6PR01CA0037.outlook.office365.com
 (2603:10a6:20b:e0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 15:15:00 +0000
Authentication-Results: spf=pass (sender IP is 205.220.180.131)
 smtp.mailfrom=quicinc.com; dkim=pass (signature was verified)
 header.d=quicinc.com;dmarc=pass action=none
 header.from=quicinc.com;compauth=pass reason=100
Received-SPF: Pass (protection.outlook.com: domain of quicinc.com designates
 205.220.180.131 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; pr=C
Received: from 64aa7808-inbound-1.mta.getcheckrecipient.com (34.249.187.16) by
 AM7EUR03FT058.mail.protection.outlook.com (100.127.140.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.22 via Frontend Transport; Fri, 30 Jun 2023 15:14:59 +0000
Received: ("Tessian outbound f22d9d9ce097:v142"); Fri, 30 Jun 2023 15:14:59 +0000
Received: from mx0b-0031df01.pphosted.com (205.220.180.131) by
 AM7EUR03FT022.mail.protection.outlook.com (100.127.140.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.22 via Frontend Transport; Fri, 30 Jun 2023 15:14:50 +0000
X-TS-Email-ID: 1c450158-0d99-444f-8402-93ff907888ce
Received: from 480107c08281.1
        by 64aa7808-inbound-1.mta.getcheckrecipient.com id EB92CAF1-A365-4487-ABA3-51501FF1A16B.1;
        Fri, 30 Jun 2023 15:14:55 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-inbound-1.mta.getcheckrecipient.com with ESMTPS id 480107c08281.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 30 Jun 2023 15:14:55 +0000
Received: from AS9PR06CA0567.eurprd06.prod.outlook.com (2603:10a6:20b:485::35)
 by VI1PR08MB9983.eurprd08.prod.outlook.com (2603:10a6:800:1c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 30 Jun
 2023 15:14:51 +0000
Received: from AM7EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:485:cafe::21) by AS9PR06CA0567.outlook.office365.com
 (2603:10a6:20b:485::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 15:14:51 +0000
Authentication-Results-Original: spf=pass (sender IP is 205.220.180.131)
 smtp.mailfrom=quicinc.com; dkim=pass (signature was verified)
 header.d=quicinc.com;dmarc=pass action=none
 header.from=quicinc.com;compauth=pass reason=100
Received-SPF: Pass (protection.outlook.com: domain of quicinc.com designates
 205.220.180.131 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; pr=C
Received: from mx0b-0031df01.pphosted.com (205.220.180.131) by
 AM7EUR03FT022.mail.protection.outlook.com (100.127.140.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.22 via Frontend Transport; Fri, 30 Jun 2023 15:14:50 +0000
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UB813J017009
        for <sudeep.holla@arm.com>; Fri, 30 Jun 2023 15:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=52j6xezjC5kV3UYWKdI5KjUl8FwD7l/HDkEP2htqmiM=;
 b=X/0uWtgMPmaJ2UBB83IQtbW2gsx7hibKYNKFil6A0nrvJVSdI/tSvNTkteoCkviaj+/q
 Nwv0SkBo7/3kKjfGN0PdWwjvNWgr3JE1DcXQDEavRLIn/jHjHIPjMnqCvFwRT05RWvc8
 iJpcWL3myUvTXsGwijKf4BPCdj18ZoN8UIbFYKjwU6EaFid7i+slwuyC53xy3iqVkcPq
 ZBdd9lAB7NNHS0ZMUlYxZVfhWVYcodVWfeeG8vJSLsZK7i22YN8j0tb6HrBdk9lVbHRe
 Pu9SsBIbabLW8svLOeeqzQKK5S0cEs+WYHv7h+S0UqhlV3N4r9ADthRwlMldbSCGCsfF Kw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhgpgt20e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <sudeep.holla@arm.com>; Fri, 30 Jun 2023 15:14:49 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35UFEmJS022867
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <sudeep.holla@arm.com>; Fri, 30 Jun 2023 15:14:48 GMT
Received: from [10.110.88.240] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Fri, 30 Jun
 2023 08:14:47 -0700
Message-ID: <0c9e5d7e-effc-6601-bc09-98ca74479833@quicinc.com>
Date:   Fri, 30 Jun 2023 08:14:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 0/2] Allow parameter in smc/hvc calls
To:     Sudeep Holla <sudeep.holla@arm.com>
References: <20230506182428.25343-1-quic_nkela@quicinc.com>
 <168553587753.1312594.1314699083240878506.b4-ty@arm.com>
 <110da0da-211d-1a3f-e007-ddab272aece7@quicinc.com>
 <20230630094441.fxwd4eagtj5wmbbg@bogus>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20230630094441.fxwd4eagtj5wmbbg@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HNW_87BHH3qF5ZV3dslczsXQU4qzECwV
X-Proofpoint-ORIG-GUID: HNW_87BHH3qF5ZV3dslczsXQU4qzECwV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=681 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300129
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT022:EE_|VI1PR08MB9983:EE_|AM7EUR03FT058:EE_|DB9PR08MB6571:EE_|DB8PR08MB5481:EE_
X-MS-Office365-Filtering-Correlation-Id: d35f2a60-dd28-4f49-be17-08db797cc530
X-MS-Exchange-AtpMessageProperties: SA
x-checktessianinbound: true
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?dmUyTXNIZkhJV0hEWXFtdXR1U3o1dWdTQThiUjNsdzVNOXhxa2FuUlJnVk5q?=
 =?utf-8?B?dEJDR1REY0ZySVBDSmJJREVqZVdUYW1rYVA3L2ZvN1VxcFl4TzVVQmZpdnRF?=
 =?utf-8?B?M2dMNmE3bWdQZ1QyZEZIajRWN3gzWC9XUGNTakZRZlZDY2VaZGVncEwzc3Q2?=
 =?utf-8?B?WWZOeExMOEptTW5QaUpnaEpDM0RyRzcyR0tYSGxsVVB6UURzaERGUlJQQXFI?=
 =?utf-8?B?Mkh5SndKbjJkNWJPUnF2em1EbEkraWxZVjU2UnlsQWI4LzI3RlpJbmNKT0pv?=
 =?utf-8?B?dFpnbzBLbWxCZDkrM1dUZHA0c1VZaFErRW1qY1F0eWVZbCtCMTdKMlBiY1Bj?=
 =?utf-8?B?T1VURGx4bCtDVUoyVjVld2RiL2p0ajVFVEIrTEdocDV6dHhWVmhMRHVtMTc3?=
 =?utf-8?B?bytXQi9XckthaFVlSkhsbVB2V2VDOWpKVlRRT0pTMnpIeXE0NlRRa0EwdGNq?=
 =?utf-8?B?RmM3ZnBqdUl6a3FBUzFIYlNrYWYxWUI3RER3VXFmWnB6Vk1DbmNzS3o0VDFa?=
 =?utf-8?B?MU1KT0dFSkRwSGF3bWJOSlRWVkorbCtpSUp5RTJCMGZkZlVsQ2F4dmtrcWNW?=
 =?utf-8?B?OE9MRk9sQldhSlZ1K0xKQWdOYXZqZFdnYndVUVl0b1JxNXFUUml1NjlvQjlv?=
 =?utf-8?B?UUM2c0pjbVZOQ1NzdWhpZis0MUg2M3VldXoyTDdSaG5xaTJTdStCUFlpUWdR?=
 =?utf-8?B?VGpSSk5WVkVTcHBXd0NVRFVIT0tQdWpkSWdMZ3dWQkkyY0NsTjNhVDY0QWNr?=
 =?utf-8?B?aHFyNFAxRVBIWXVaQ25QektHWmllL3lTTjhyNTk4OGtvVld2d1JsOHh0NHFV?=
 =?utf-8?B?OWhGcGVLVk5PZHhqbFBaZlhSR2xjekFqTk1GK1V3Wi9nbE1WdTgvTkMzY2RL?=
 =?utf-8?B?cko2UFdxYVU3VExWZUVUb0RyWmtnM0NzaU16NXc3NjkzeFpWRGFEdUdjcG00?=
 =?utf-8?B?cGZZZEpYVnIxRy81VEpnRE9QYTRSZlFVdXp3bHZNTC9zS2hwWnY2NFlUZ2FJ?=
 =?utf-8?B?OUwxL1pHUThrbkJkdjB6clpwNk8rUkdaOGxiaE5WV3pHMTZYUUN4Sk9yYzJS?=
 =?utf-8?B?ZElubUpVL0NiWWlKU1N3N09YL2NCWGwvWE9CcDNmZVB5ZTZaWlJWYU56MGVk?=
 =?utf-8?B?a2pJQjV1Yk1qZ2s3T3ZmMGZlbk9lNUlDQ0ZUODVwUEVJVVhTMG4vY2pBdVcr?=
 =?utf-8?B?Rk43NWlPREtna1U1UVErWTdIcGw1bk13S2VRQUtRNENrVzFPbEhyV2ZidUVE?=
 =?utf-8?B?R21HVlE1TVVEMjJqV21EZGRIZE04UCsrekpZWDZsdThZOG45S3l6NFRoTnRo?=
 =?utf-8?B?K0JZbHZIMFBIeE41ejV4ZGFDLytWUnVCdTduK3c4YmdsWXB0VW9TcU8xa253?=
 =?utf-8?B?ZVBpU0M1ZDZUZHhQSnVXVzgzUThkU08zOWpkSUtITjVuZ2hqVmUrcW9JY09D?=
 =?utf-8?B?N1VCak1INTU4bWc3L1FuRm5PZGhXcnVNMVpPVVR5UjZOTTdScXdrZW9zOTdv?=
 =?utf-8?B?eVp5c2FrU1ZiTWtmWTM2VUNwUGNWQjVIVEFWVmRGNCtjTkNjdzlkWGJna3JO?=
 =?utf-8?B?Y2hsUzNFcEcrQlJlYUlRMDFIY3pYMTY2aHNZUHVkd2FsNkplQTFYNEhua0Ns?=
 =?utf-8?B?OUl6c1k5d1NRNVM0OTUzakJieVU3YjdIdzExajZ4UGtIbXZmTjQ3WUFmUll0?=
 =?utf-8?B?cnZRMnh0OUVaVGUxdGVDTUlhWitPQ3dOamd6Y2o5cVd1N1NKM1REdzZvWEVJ?=
 =?utf-8?B?MHppZ0kyTnZqWkhEbCt3NDdnbk14SHgrR0lnR2dldVl6MzJjSk1mYzQ4T3k5?=
 =?utf-8?B?RTkvNW1UaDF0ektETUQwSXhqRDc1UTJCRk1tdXlmTzN6QXEvb2VWTHpnR0JW?=
 =?utf-8?B?VjJqNzI1bUIvaWdHVEd0TndQWTU0d2V6a3B2ZmpuVjE2OGJoc2tSQXphSUlU?=
 =?utf-8?B?Zk1OOTZrZGdyMHh5UDB0VVFlZEo2dHp5elBNSTZoSjlpZUxkNXpoMHNTbzVN?=
 =?utf-8?B?MkVuWTBuQ1JFVE5EN0RGcFhvcWl4S3pRUDNOcHNqY1lKdDN3ODVrd045K2o1?=
 =?utf-8?B?a2hRMythZk14TWFKWitlNzYrdkRZY1NMMkY1aUNDTDQ5TE9RZHU5REsrdUZm?=
 =?utf-8?B?V2tFczgzTVk5OC9FbVJsM1gzT0ZqdjJsVkh4aStwSHZ0cFcrZGNvRitaWGYz?=
 =?utf-8?B?NWc9PQ==?=
X-Forefront-Antispam-Report-Untrusted: CIP:205.220.180.131;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mx0b-0031df01.pphosted.com;PTR:mx0b-0031df01.pphosted.com;CAT:NONE;SFS:(13230028)(4636009)(451199021)(7596003)(7636003)(31686004)(16526019)(5660300002)(84970400001)(356005)(53546011)(26005)(1096003)(8676002)(2616005)(336012)(83380400001)(34756004)(31696002)(16576012)(36756003)(6916009)(86362001)(43740500002);DIR:INB;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB9983
X-OrganizationHeadersPreserved: VI1PR08MB9983.eurprd08.prod.outlook.com
Original-Authentication-Results: spf=pass (sender IP is 205.220.180.131)
 smtp.mailfrom=quicinc.com; dkim=pass (signature was verified)
 header.d=quicinc.com;dmarc=pass action=none
 header.from=quicinc.com;compauth=pass reason=100
X-MS-Exchange-Organization-ExpirationStartTime: 30 Jun 2023 15:14:59.4268
 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 1:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id: d35f2a60-dd28-4f49-be17-08db797cc530
X-MS-Exchange-Organization-MessageDirectionality: Originating
X-MS-Exchange-SkipListedInternetSender: ip=[205.220.180.131];domain=mx0b-0031df01.pphosted.com
X-MS-Exchange-ExternalOriginalInternetSender: ip=[205.220.180.131];domain=mx0b-0031df01.pphosted.com
X-MS-Exchange-Organization-SCL: 1
X-CrossPremisesHeadersPromoted: AM7EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-CrossPremisesHeadersFiltered: AM7EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Exchange-Organization-AuthSource: AM7EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-OriginatorOrg: arm.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: cb1a232f-30bd-4d32-dea9-08db797cc00d
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:34.249.187.16;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mx0b-0031df01.pphosted.com;PTR:mx0b-0031df01.pphosted.com;CAT:NONE;SFS:;DIR:INB;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 15:14:59.3643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d35f2a60-dd28-4f49-be17-08db797cc530
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[34.249.187.16];Helo=[64aa7808-inbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6571
X-MS-Exchange-Transport-EndToEndLatency: 00:00:02.4400832
X-MS-Exchange-Processed-By-BccFoldering: 15.20.6521.022
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;auth:0;dest:I;ENG:(910001)(944506478)(944626604)(920097)(930097);
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2xmeXFWQzdqRnBBYmZ0cmM0NGVlV1BlRVV6Q3EwV1hoM2dtTWtRN0lCamdt?=
 =?utf-8?B?YjY5cThNM2k0eUNzL0ZrUUhNU3FhVldHUlg2RWNSTm81NDNZTENYUVJqdDNU?=
 =?utf-8?B?czBhYnM1eVZZRVFYc0lUQXlOVWRzVXRFN1ZaY2J0MEE4RkVGdHUwTnB6cHly?=
 =?utf-8?B?dVdGcU4vQWNOQWJZUmJNNkQ3TlF6enVzNis4dXdFQnlJd25lSHNVR1BOVUJR?=
 =?utf-8?B?SlZUa1ByVGI1MEtaY09EbzdteVhCcjBRS0NDM01FMEVac2lrRHBWNThySUFZ?=
 =?utf-8?B?QkNtZzljS3I4NlJOLzJPNGltajRjeERrc1JkbVlPYkR3Um1DdkYwZDN3cURP?=
 =?utf-8?B?SThUM0RFMS9RZ3hrcDZ3dUJ3NWFtOE55ME1Rc2trbHlvTXVWR3dMR3pjTzlh?=
 =?utf-8?B?WXFDNUxBYVVvcGo2dmRiM1I4YmF5akhxWGNwUzVXZ1UrOXlsdkUzVlJXNFNJ?=
 =?utf-8?B?NHlMZCtzMVBsc3UrUzk2ZXc3Vmk1NFlqNWc2aDZKazJHY3prcjBpeEc3UXll?=
 =?utf-8?B?R2Y0bkNqQXFNT0tReWpoOFk3YkNuSXZZN1AwdVFwRmZkT01GVHYwbkpEVmdV?=
 =?utf-8?B?VnlUejlYdzQ2THQwYzIwYlZ0Y1M0V3FLMHFiMGIwWmorRjh3N0YyKzlmYnJS?=
 =?utf-8?B?Und3TnNrZWhETmdiVG9lZlZPSEpnVDBPbHVjYlpxNWd2dDVBSlFxQkFvVTlN?=
 =?utf-8?B?eDY4WEcwcmVhUXRJY2ZhT1RXeWJqZmFibGhZWnJmNTMxR1hCNHYxM1dpSHZx?=
 =?utf-8?B?b1VrY1ZwcGNrTVltaGZxZlBpWGJUaVR5K1c4NkFRbUNFdndla1FwOWNmam40?=
 =?utf-8?B?QWlCQ2ZlSGEya1Z5M1FYbFJybzJ4N0ZIMUdnQ3FkeGM0NDZtM3BGVmVOazkr?=
 =?utf-8?B?ZEVocUhKQmVMVER1V2kxcEVBSktTQ2VzZmpQdE04Y1NIcDh1cmgza0Y4cTk1?=
 =?utf-8?B?M2NWbW1JN0pLdU1QanM2dVM2cHB0cEQzVFM1eU93MG5zUHZmN0FkTHJLWDZa?=
 =?utf-8?B?eWgxa2hkN1NaQTEwYWhDL01lUXI4SjJOVFZVNmNPbTlmRldOMjB2anVPbkJG?=
 =?utf-8?B?OE9GeE5tdG03U3N5R1lzOUo5Y2lIVWUzaUswQk9RZHFmNHM5dEhrZnBCeDRo?=
 =?utf-8?B?OEgzZzJscFo1djV0Zkh5NnRHWG1vS0dhb0oyODJES2ZCOGkwWmQxUFZCam9P?=
 =?utf-8?B?UmUrbHBqNEFDcXh3UlhaN2JHaTU2UWRxbFFrZngzMU9IYURNODhuaXpEME5a?=
 =?utf-8?B?N25mc2JZVUc2OHNJN1BYaVVHZVd3dFBxZys2TVJFK2h2QjdZRksxbSt6OGtj?=
 =?utf-8?B?NGFCSnZodlVUbTVpVDZMYW9tV3A4ZFVYSFFmSklRRHJHNXVNeGlpVncwZDJU?=
 =?utf-8?B?TDAwOVlaU2NjWjdOVEdacmhTWGZ2blJGbmNsRUplSk5OS284NG9xbjduTGFv?=
 =?utf-8?B?VFptN0dSZ1d4end2dXhjYUJzVVhkM01zSEZCb0NFL2VzTjBHWjE2OVJFTWFl?=
 =?utf-8?B?THRxQjBKenVqSkEwaGZXT2ZNWUtlVTNSaTE0d3FiOSsyMGJjSFc2Y1l5UGhG?=
 =?utf-8?B?U29Nd3JJSjY4MmVjV2EvaXFKQnNJQnhHSGVVUXdwUVdpK3hRVU1nVmR1cTVs?=
 =?utf-8?B?YjZ1cmgwaDJCbzdORExySE5zR1p0NWd4cmZjb2dsVFR3M1o4ZGVMS0FWQ09y?=
 =?utf-8?B?bnEySU9yM3pYVVBONTdUTENJamRqVis4Qi9IVkVkbG43M0NWWDNETkQ1SjJx?=
 =?utf-8?B?ZldyMS9zdVVvM28yZG9HeDNBRGx3TWFjYU8zM1FYeVlMMlpHY0FZUkViMWMv?=
 =?utf-8?B?alJBQlB3MmdKTWNtdE5YNERLc1ExS3hvUVMyVzFaVjdlcytndW1vY2hvN1JI?=
 =?utf-8?B?UEFUZEZUWjJhMUpLUkw5TTRwZ0pGMlRmVzhTTmIyYXY1VnpVWWUrTG1Wb0Fs?=
 =?utf-8?B?Z0hBNUJ0ZkZNVldkT2dUSzhuN3hwRElQZWgwY0Q0dHI4bldoQ1MrYlpzNVFQ?=
 =?utf-8?B?YUc2UExFajhNZ1Bab05wSzEyc21KV1lUemdYZVBIQTJOZllKZk5RdmFkUmt4?=
 =?utf-8?B?bTN6UHZDSElqSElkVnFhblI2c0t3SWxKeEEycW0vMS9Ucm5EblZjY29meDhU?=
 =?utf-8?B?NDZVemtHenNLWTRtV2JmeW11TXo2blhXdmRtZnRLd0tVcDJtY3Iya1FDS1VO?=
 =?utf-8?B?OHJQbTlCeVlqdzR1NkJNL29rNHRLZUtyd1I3ajJENWx0MlNFTDBOekZ1cGRa?=
 =?utf-8?B?Q0poZ2Zab2JzRzNWcDhSTWxKa2dnPT0=?=
MIME-Version: 1.0
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/30/2023 2:44 AM, Sudeep Holla wrote:
> On Wed, Jun 28, 2023 at 01:38:32PM -0700, Nikunj Kela wrote:
>> On 5/31/2023 5:26 AM, Sudeep Holla wrote:
>>> On Sat, 06 May 2023 11:24:26 -0700, Nikunj Kela wrote:
>>>> Currently, smc/hvc calls are made with parameters set
>>>> to zeros. We are using multiple scmi instances within
>>>> a VM. We are sharing the same smc-id(func_id) with all
>>>> scmi instance. The hypervisor needs a way to distinguish
>>>> among hvc calls made from different instances.
>>>>
>>>> This patch series introduces new compatible string which
>>>> can be used to pass shmem channel address as parameters
>>>> to smc/hvc calls.
>>>>
>>>> [...]
>>> Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!
>> Hi Sudeep, our hypervisor team is evaluating other scmi transport
>> options(including new qcom specific transport) along with this one so there
>> is a possibility that we might not use this solution. If you think this
>> patch is not useful to others, you can hold off its merge. Sorry about the
>> last minute inconvenience.
> Firstly, not sure why you took this in private. I am going to reply on the
> list and from now on I will never trust or rush to take any Qualcomm changes.
> Nothing personal but I have to follow that to keep it simple. It is in
> Linux tree yesterday or today and yes it is too late.
I understand your frustration and trust me I am even more disappointed 
by the decision by our hypervisor team and that too this late.  My 
efforts on this series are all wasted. If you like me to post a revert 
of this patch series, I will be happy to do that. Please don't let this 
one example reflect whole Qualcomm culture. Again, extremely sorry about 
all the efforts you put in.
>
