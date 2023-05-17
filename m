Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0136706033
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjEQGeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjEQGeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:34:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4294035A0;
        Tue, 16 May 2023 23:34:03 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJxVmI010616;
        Wed, 17 May 2023 06:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7HlQ/hvjBTYxfxKMf9QB/NrCL4m8My7K0TH53DzhVWU=;
 b=DTalULefyVPaT6SYbkWQ6ueEsup7RXnl0aFt6cgaYihLlRVsOmX70IbkOw3xKoBeh99C
 GDVvmjHbKddk+4jnGe2qu078vv3DBOhuC+mS1R9LtFvzu4xbT/eAfMjfc286m1UC2u4X
 k10mcmZjQqwcIUKEuc/Bl0JtyBfz6fz6G00W91csdMgXmscShH1kWN3MpR3zZY307now
 UK0bZ7cz6nj+20sVigG5Sq9SRHNlzaC5rIixitAZxJHmAPMjI9B05RPobrZAYdn+aMub
 KAjj+X097sK842UU7weTWXR3uTyvKj+4e/gUKBtCCNZcAnLe3MNnDA/rQ1TZ6Qch0n1o xQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc50k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 06:33:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34H5r7YE036503;
        Wed, 17 May 2023 06:33:51 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm0211hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 06:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmuYgFnLqqo1VVN16ACD1hZroDmEHB6OZciBuF5UDpel3L0ldBHFo7zOTA6/nx2SQoqtWF0UmZNPAaGSn1So7Aiz/gFiU3kuFHaQV7Mvjyl6IkL5EB4i6FV44nvGz/6S8ntj83ueQU4ApmiYsDesvIxQEczTHuQfe3nYe3F/Fa3BG7piuAcAyIp2KubZp3IjNgRUKDSE+WtXGXAIdO9msBswKBa3ptqTmVi6jP7iQWO2MrVojgUdbQGEmj4RqZOipOo/zEFUzgSs5g++XGlHin7/zb9SBj88MHv31Wa+AAAyOdiCnuMKBJIkE0sYEr8CJRQR9pwcL82cHubKJwK+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HlQ/hvjBTYxfxKMf9QB/NrCL4m8My7K0TH53DzhVWU=;
 b=AnwKQ8vWHTNZoAsr6fK6uthBdMvp72rqdylHSOQOU7O5cVeCIjIUqfUvGwg8bMacUjCwd0xgoDnywDolKuJa9gshOixOIdxHbkqqcYlmLoG39Pp96rr6HlwjRFFLxktrANbnBGI05EVv+hAaSQcLkXaS9eiLcL7ad80bwEsDG22i39ZtJ7KKgTzA8yF7/XLofu194QrRkcFxx5SCvQDZcki8kyPiJ7OYonHIkSMJwSHDb7Wiw63XKb/4C0d+HonfQse6jJC3qOt2siku1RAkLeyGURZX3alw3vChGZsL4OtdRUlvo31ZTA6zCRisF0fyG3rckO8n2JpYohfxxLt2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HlQ/hvjBTYxfxKMf9QB/NrCL4m8My7K0TH53DzhVWU=;
 b=lsBc+rA5ssZvptLo6vsjn+IRrYDLaQ2XRgBmd26Qi6r2FFcZVDWfigc0bQY+uiKXleNFp/Q6mJZKYJKic2zr2MJ+7JO0J0yxU5rc7/tkCeBw7Vvbz13jQG/7iOOpy3skfHiD7ZuuyQ+gsJaLV/cw4H8LCtvFk375zb2wuNl3rio=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 06:33:49 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 06:33:49 +0000
Message-ID: <c7253c5f-248c-2f01-c518-f7dd747e274a@oracle.com>
Date:   Wed, 17 May 2023 12:03:39 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] module: Fix use-after-free bug in read_file_mod_stats()
To:     mcgrof@kernel.org, linux-modules@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, error27@gmail.com,
        kernel-janitors@vger.kernel.org, arnd@arndb.de,
        dan.carpenter@linaro.org
References: <20230428055933.2699308-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230428055933.2699308-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CO1PR10MB4769:EE_
X-MS-Office365-Filtering-Correlation-Id: a10ef531-5ce9-4d21-00f8-08db56a0ac4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GH9vm1KQ1ygWHLPO2QJCbJ/gvaaA8S7qE+x13DAa8lRKgZebTkrwACvYmwMOvYsEZbFVWv39nFC4IW4+DSq5ub+K+0LwgUQVdIHt2B+7pN+SVZ2kInbgyuzpZ5KYeO/w41835JsM4gbvW1vZu158d/UjHIFL6klem5HlCPQ6RaJYL+JUZtzT4dd1KxtSgBg+ENeGrVO6b/idgj78Y3YHb8enIHNfdKCIvp9LWAeoWNX7Xy+OgclJAg+58MOOxw4mhyGOZSC++QqDtk1vwyykbsgQgvUJjtre7jUr8RrtA4Wb6cpkEh1/23jndL1Du3oSHKQqp5H84nHYUFyKNNO7yNI0EmAe8BSwZ61neBupuutlmMSThhn0qI/j5+jGOc43sLr2JNyYkctde35QYIVib6fqj74UC/+vODN+kfTNRm89eCHuGn/qetJ2GZeKlUlhN6lT2zbooKAR/s4IsYF3hPhasqYtIqheQnW8IwndjPbjVzOSV/A7OuB920mYadsW2ZbiWgV4/WkCjXZvqtWhgUPX7lffT7+kacxmsbeiey1q/UMOup6xjmO7JWeojCkMAARmd0Dao8XnxtLcm01O2ATeke8i6pr5zkxmw4QVl3Pq3Qr0b96u24LGgDP6yMXaR3x3KjYsiSUmZ2d5MDZ9EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199021)(31686004)(66946007)(4326008)(66556008)(478600001)(66476007)(316002)(31696002)(6486002)(36756003)(86362001)(83380400001)(6512007)(6506007)(186003)(53546011)(26005)(8936002)(5660300002)(2906002)(8676002)(41300700001)(2616005)(6666004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnp0Q0VKZHBJL0Qrc2w1MjJEQlZYN1A3WVF0aWNnNU12WmtJVXlrWFlyNENL?=
 =?utf-8?B?dWtlbU1WYjkvVExGQ1hHUzIyRVRLS1RYdEJOanhoTGpQalBjeDlPMWU2MDMy?=
 =?utf-8?B?U1l2RkE0WFZ2Vk1FT1VHL0lNb3VvQW8xZTF4MmFxRElUaWRKUGNvOTg2N3BY?=
 =?utf-8?B?NEtqUE9XMFpWcUZOODIxTU1pWXhaZlc5NURQVVlIY3orM0xnVjFjclhLTzNq?=
 =?utf-8?B?R3IzUis3QWZTQjh1N2hCR25vVm4rWW1aMVVKL1htdDBaYXJ3aEpIVHZJYk1W?=
 =?utf-8?B?ZG1BRXZEemIwUzc1aXhEbkw3NkkwS2FPcmFzN3hSekU3KzdKNTdBeG5ZdG1P?=
 =?utf-8?B?NCs1Zzh1SzkzSEVQMS9rMHlUaTEwdDNQWHJGSXQ1OGdUZ0pUSkgzUEJLZkU3?=
 =?utf-8?B?aUg0QVYzQlFGOWUvcldyU3QxYWtvTHJxUy9qZWFLaDFVOVl6dWk4endwb1hO?=
 =?utf-8?B?THkxMWliUGdJNWJVQWRhL25jUExqT2J3L2g2dUFhZDhXNDVqZDRBVnJ2L29z?=
 =?utf-8?B?b3dRWEZoMGdrSkFZbjVRbThUb1ZEWFk4UU1YMGMzbnZBaGRVeldzak5sZGZC?=
 =?utf-8?B?Zy9tRzFnODJNL3NFMXNYQkJRR05IY0lSNERKYUZjL1BtR1ZRQVVpMmJ1RERj?=
 =?utf-8?B?NWJwQnRDc3ordkIxc2NyR0lhYU9ObDBESTNKYTZ6RzAvc29FMUxrdU9jcG5J?=
 =?utf-8?B?YVpLOXUydWRrMUxVR2lkR0tXVjZuZkpYbHpwVUI5Nk1JZTVWeTlhaTNXMEhM?=
 =?utf-8?B?aDR3Kyt1NlNEVmhFbVNKdWN5ODNrTkY4TWxsVEM0c3BuNFVsSndSM29ubVJL?=
 =?utf-8?B?aTFkd0N0R1VXQ2ZSZFFTL1ROMDNlclFSekl3alV2OGlxWmFydEV5UjVKd2Iw?=
 =?utf-8?B?U25MdzB1SzBOZXZRNG5aY3JnSU9sN1lJTTVmV2hpS0hwYmZHVlZ5UUpwbFhs?=
 =?utf-8?B?VmE4a3VROERMK1o5S3M5NFJJRlB2WXI3RWJLVG1HSjV3R2xPdzlReUNkb3F6?=
 =?utf-8?B?enJiZVh4Yy9jZkQrNEhjd1lGZE12b3pBV0k0Y2t4eG1PTzJUMTNlcE01WXpm?=
 =?utf-8?B?REhZMmFnM1ZITi9VakFZNTRsRkoxNzMrRzJXc1N3ZmhZUU1tWCtiOUZ5M0h2?=
 =?utf-8?B?UmhURFZhVnF6UlZBaTB2SHl4RFJJRzZNdGpDTlVTaFNMbzBaaStOQkkrZFlY?=
 =?utf-8?B?d2txb3E4VEw1NldoTHBObHY2MmVQZkd0MHZRNDM2SXFiRjFNTXNOcWk0WTc1?=
 =?utf-8?B?RVZ4VmRvSjlYY0NlWFQ3VmV4cW5kZXpZL3RjVlNRNnVyeTc0UWxjZTJSeks4?=
 =?utf-8?B?RFhBbldqZ3pQZUFXRVM1ZmpDbXpyenZzWXRPZnJzWTJobGRNYmtocXdiNG8z?=
 =?utf-8?B?bWpQWU5SRnVaeWdzNlowNzRjOFRpNzBhTjFHTmZVSy8zU3BNYjAxb04rTjFJ?=
 =?utf-8?B?TEZKWDN0SWVtWGxxeUtpQ0lkY3JicTdBU09PVFpwUXljMWQvOU5NOHNxV0J5?=
 =?utf-8?B?Ync5N3lqaDdPdTVSMG1zell6cW01OEhBUThTT3V2cVU3WnI3RGJuakJjeTlB?=
 =?utf-8?B?OUNiYzBGSFJmNFBpSGd3WlFJRVJ0cXFndU1nTGd4ZVVtM1FGT0xiSzk2VkI4?=
 =?utf-8?B?Nm1yM3ErTG0yY1loc1lwWEJ0QS9aaWVUTDNwYlJQOXR0Y0FLUGpKKzBMN3Rr?=
 =?utf-8?B?YSt4U2M1YSswZWhNbHE0MUFaR3NNWi91YTdtSUN3WFZldEtwYkVjdEVhMW1m?=
 =?utf-8?B?MS9ROW54WFZDbDFSb2J4QXpnLzBSbGlnZTJST0w5V3lDZlh4TnI1L0tWdDho?=
 =?utf-8?B?YjdaTHBVYXFVRjlXcVVWZUFnRWNSRkhJS2crcWh2c3lXeHpDNE5KMWFpMGU5?=
 =?utf-8?B?bElyYy9pc2h6d3BLUU1FRnBBTENrYVNyaTlZVC9zdEVBYzZKWDRTRm1BRzdh?=
 =?utf-8?B?U2IvcnpKL3AxL2prTjh6eUdyOW4rSUc0cVN6M25ja3dRcW83VzRMRG5xeWlD?=
 =?utf-8?B?aml0bXc2UE1WNndzanJzaFdQZnB5SGdFTGxHRFowTlR1Q0RmTEJjd2hKUDFG?=
 =?utf-8?B?Q3hWUWU2VGRlSk5RQUpnTjRHZHo5SFViOXFCV3hsem51N3V1aGJ3UjlZK1Zv?=
 =?utf-8?B?Z0htZ2pZaWdCRWRXeHpxci83NzRFV1FFOWNLd2dzNXY1WDJoQ0lyOW93ZE03?=
 =?utf-8?Q?2szRmwu/A0ZFvRZLEt9FaDc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OpxOG5YWCuS2NKh7wzsye14RFtDnGpCsAkgwSttAvziPmVir0/FjaRIAbwIeDvbpRmcEMFWJcTNgZQ9g+L/5afbNjv+545KHRgoaGp969qer/mWuafN9sAynvIzRHonzloc2tdJRNlCfhAoZCJZoLaYeHpgFJGtF1O+HEZ5riUxdiNdkknFl00vdbRd2i/+TFYkNSWrRVVHE6P8P/4jfh2zhZHlFyqvllggdSFP4TC8GWocRMmyzFliLcmzf/ajTjror1T8aHLd/JpUEGdLYJDdOKraI7BsHpFsm34/nWZuHCt4t3lE/IdJrZ7YRzTDQEs7+8/97I2dkP0tEWbLIdA7pTlQzH6a4cqhlIBBVgr9e2ZaAr+gVasFOCbLQXufH7erQKDdaGHpXPxZE7qCby4cIESEGns/N+C/s/AZ8t+Wuw/vFklgATsp3fa2xE28xpEAEkLgZRtMn9rjCgJvIrj989JEN3z04gPoiNIVgNHnD15GWOkktcL5TnmyNAeY5CBbE2VwY6aQvlK60C5Hawk9uNQLOhgB5X9095YIeUkc7jNS/xgNz53ZQJZ9aCg3z2kuJIW48YkkNjtc03+phIcR56MICCGhUGgG8jO7pFp7y0hK5SlgvPr/ft/EKsXsaNQuiG1+m8ZftefrP4pvR6IHP+s17plZeJjIyWLo41vLznRvmflFjoPLE59BKVFb19UJNJykUMSVVLI+J5hygZgxOMbwf7QIQkgA4Ad7rOv7DWRVMp+iQaXVgrrnkn/IwKPKdYzR39xXzEMTU7LGs/tdyA+5qM+PV3tWLcMCLrcRgTUhJ4+67c6xRSPxlwSRt9WBBVQmVds+oUMunZFEXnVOknW2L0Tn5bJLmhoVYvrU4mn1Hc+ggcZaT3NVM+2lU
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10ef531-5ce9-4d21-00f8-08db56a0ac4a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 06:33:49.2062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oriB9lVz5zbglsAFxTU56A6zvf5Vbv1bU3wREZuKaOOBVpRDOHqI6YCtYm03Rmh60Fuj/qsukUu8XDTNLhWf12gSEBjaK2WQ075p57SVs9ovv6iFm7JzIDNrZ5tZNeQ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170054
X-Proofpoint-ORIG-GUID: 8rh6YiQC9MrEQxFgr3eQMoAVYfjDPx4y
X-Proofpoint-GUID: 8rh6YiQC9MrEQxFgr3eQMoAVYfjDPx4y
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 28/04/23 11:29 am, Harshit Mogalapalli wrote:
> Smatch warns:
> 	kernel/module/stats.c:394 read_file_mod_stats()
> 	warn: passing freed memory 'buf'
> 
> We are passing 'buf' to simple_read_from_buffer() after freeing it.
> 
> Fix this by changing the order of 'simple_read_from_buffer' and 'kfree'.
> 

Friendly reminder to review this patch.

Thanks,
Harshit


> Fixes: df3e764d8e5c ("module: add debug stats to help identify memory pressure")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> Found with statis analysis, only compile tested.
> ---
>   kernel/module/stats.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module/stats.c b/kernel/module/stats.c
> index ad7b6ada29f2..6ab2c94d6bc3 100644
> --- a/kernel/module/stats.c
> +++ b/kernel/module/stats.c
> @@ -276,6 +276,7 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
>   	struct mod_fail_load *mod_fail;
>   	unsigned int len, size, count_failed = 0;
>   	char *buf;
> +	int ret;
>   	u32 live_mod_count, fkreads, fdecompress, fbecoming, floads;
>   	unsigned long total_size, text_size, ikread_bytes, ibecoming_bytes,
>   		idecompress_bytes, imod_bytes, total_virtual_lost;
> @@ -390,8 +391,9 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
>   out_unlock:
>   	mutex_unlock(&module_mutex);
>   out:
> +	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
>   	kfree(buf);
> -        return simple_read_from_buffer(user_buf, count, ppos, buf, len);
> +	return ret;
>   }
>   #undef MAX_PREAMBLE
>   #undef MAX_FAILED_MOD_PRINT
