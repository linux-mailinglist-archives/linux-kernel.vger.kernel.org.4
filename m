Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290786E85D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 01:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjDSXVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 19:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjDSXVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 19:21:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B462696
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 16:21:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JL48XJ008026;
        Wed, 19 Apr 2023 23:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dzjTrD1zTuq1A6tQUVsTjC0yNMiUbMLt17NMLDg5twk=;
 b=Ql5SpB3exx7tWosI+uamGV6feDKBeMWf1LNoMoXF5mJSB+qMB/SO7pRyQb/cQJYf1PRT
 u9jUKSxHMFSUBnBQ9UVv+R9HQ/R7QGTzF6MYVR3WfT0Gp3It8wBD+2es2+0TTavT/ng8
 vXpnkltdNbHr9vSW30wYbUXl5WP3fh8UIwhnb12S90WldX6OKdxt6FuHyIuB8j0Qto6k
 AEfgjnX8kOKtn4XfAvJBGU0P8dKk5NFKfiCbXwVJ/XKdhNh5eyRDwZKeCPmH7r22ot0L
 NgzKwwZIMjnGSBBU4QsTAy2OoTyAMF5uBx8ZgbDzDfR9tlTFbFpQQPWXzeTQ4HqgYhKw Nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjq49mcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 23:21:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33JLVHWE011080;
        Wed, 19 Apr 2023 23:21:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc72wth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 23:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNpe5h8mnuCs+pp4OsQTHxHcGf9fTArILYO+LWjQCHW1ZYMY71K5eJa6CZo+MJfGWIWA6GnbWTcG8dnzkymvTHFvKycZZIf1f9f6GvlfTt1qPUQXT4w1WcCAvXCxU1zUUhxZ5PUdxYUQou9E1HdH77QEHg4/gbwYCnFWUsyrOeuSw3IATk6ggfqZjgmdmFtfFiIpIsTvAuludLkqo1ywH4ZUi5NvgPO31jq7x/roFWDfBGblfxQUri15Ux471RwXCs3mRAVYQcRZri1TxodQSjNvA2ZmCFIDo6S90JsjjYsXWIvREOnV+yN6G/EZBkk0tMV8ke1DrPphCEGteZuwUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzjTrD1zTuq1A6tQUVsTjC0yNMiUbMLt17NMLDg5twk=;
 b=a2eWMSO441fGsAY4DqCtX/mda49ax9YF0h60QNLE2ma6pdxtRmLDK7m5JACSqzfqw2bC/WxKFi/XfbFskLwHc7jyQ8pbk6FhU/2ruO9dxX3KgGJeaxS/1yzhagGCNj7Ajhq3pel59TUqYM5rooimArurF3leKLXSTV7ayZBGvYnq4JGMGyefj733C2DRjlZ5mfQiTSLDna4F7xKE7Ldm3mq962Zqo4CpJiCuLxGqM2JhXwOHW9qpEGPgoXsLxietNuVU7l0X4O42R2ZY/Dc3dYprLc8wevqM7ByWSdLD+9Wy4EZsnYQfFFbjXecHqrGV4xURK4v+ffJXFBASRdv5tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzjTrD1zTuq1A6tQUVsTjC0yNMiUbMLt17NMLDg5twk=;
 b=EFhxYjukXYZqgMUJxWCyKAdNg1DEmubO3ie1ZY41zAgrBp05WS142DhaAnXyNJGkw+B47stK0bvygLU4UWQFX1YAGbLR3v17JqB44dZpYkqu/AunWlrs/5hueuEJhNRYGzQsnc93cDlswKQZJdNJkVPWqpp2dGYPLr6SpLZ2YEQ=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SA1PR10MB6366.namprd10.prod.outlook.com (2603:10b6:806:256::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 23:21:29 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9%5]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 23:21:29 +0000
Message-ID: <42eaa653-b63c-8c3b-4483-25765ea7a579@oracle.com>
Date:   Wed, 19 Apr 2023 16:21:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mm/mmap: Map MAP_STACK to VM_STACK
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Barry Marson <bmarson@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20230418210230.3495922-1-longman@redhat.com>
 <20230418141852.75e551e57e97f4b522957c5c@linux-foundation.org>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <20230418141852.75e551e57e97f4b522957c5c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0381.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::26) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|SA1PR10MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 4511231d-6865-4f54-ff32-08db412ccda1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVnp24OyoyB1QHdQw4cLjZHo4FKOU1G+tHApVSntSnTQubhv+TR8FCv9V9v+jZdzxDZKR9YRt8U4SjwS3rvPkd4lSuWkftF+m9/IVLxDtNGMs7+OqXwkWY2KaZgbqKPubVuOejl3ck8khuzmEcgRJ1YF2SGAZ0jUXplj7Qhp8epK9BW5jovZHyvUAfi0eThQ7N8NrKhG6Td8O91gids/PiVM2nuNpDvs39GRDXrZOBSK4BikB7PyrRJZQ6XTk2Ekqy8eUFgvEuPnuLbAfSoAtb87cvejV3r7/7dqDqdUNjlsxRlK5G3q9/f7PNSnDr4DVBWq8rnHqagYd6EpZtLGetmuaoz21oaqusQuMOBeOvopka4Y6qC574bMM9uqYJ4jatHpwf9zEwn3Lw/EHwjxY21B0lNTi/XY8PJZHPYPjdrbIRQVMERCoBuoIw0aTuuOEI5JBc9rnqWU/ul0MkuvvEmGAOSKAZwn5cJPIY9q65RiSANUbMfhv8PlJ9J9WgMzT9EprWeBHiPZZlB8cvcAmwIK06EFCVCXm4DHdZpMRr+oD4fmZBmkdJnH4RfCEL2ETJIu0ullxhbqkdBhOpi2x/40yik0+ak4OIbhKc6kOWM/ALNDj8geQRejRvd44UkDJ1s2s5w7HcWmdf3ErD+6Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(4326008)(110136005)(54906003)(316002)(66476007)(66946007)(66556008)(6486002)(478600001)(6666004)(5660300002)(8676002)(41300700001)(8936002)(186003)(2906002)(36756003)(31696002)(86362001)(38100700002)(2616005)(6506007)(26005)(83380400001)(6512007)(53546011)(31686004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekd4Y0IrVVRLeTVSWWxTNm1DenFvVG4vMDhSK0p6UkdFL2EzOWRVNllYRmRn?=
 =?utf-8?B?UzZ6cXFwU3dWOUdCZkJlRitqYmwrRlBQbmRXSS9wcml4ZGg5aUJKUE5yUlM0?=
 =?utf-8?B?RDZEdVR2eGVuTVJoQ2J4KzVwQXhYbk03dEl2RGMzY2NmU2d6MHRBTHNrUk01?=
 =?utf-8?B?TGQ0a0Z0UWRMREpwVk45SUpCdHE5cWhMSmwzY3grM1lLWjluaDAyV2dOTWNr?=
 =?utf-8?B?K0ZNdGl5L29TYlpnd2hBWTJFRys3L2VtVkRlN1NMQVdpU3lZMlduRU9rbzVa?=
 =?utf-8?B?R2dyK1puZTV1MGx2TCszOVdqTVlJb2RFWmpXZlUzZGNlQTh0RExuWkJYYjZH?=
 =?utf-8?B?UTFha3pGV1ZxaVFYZmZDTmVRQ1dFZXVWbVZOTlJpOHZJa3dGZk16SUYyQkRY?=
 =?utf-8?B?RlZKUjlDdGdUOC9pTit5cmlQR2IwS3F6c2ZZSVp1WnZhcGtaRFlaOEYvWXR6?=
 =?utf-8?B?NlBOVXNMdlJQMmpHM3ZkM1dPOU9qNVNyNFhCMzhwd2ErUS9EUmtwMHYyUmpU?=
 =?utf-8?B?K012dGdRdyt2OFJEeXZXRVhBb1BBVk4ycnkyQTVvNEtrZkIzREc3TktKYWJz?=
 =?utf-8?B?R1Mrb3gwZXJUYysvdG1KNzBJeDRVS0FJb2o2LzNwazNXbnRuWU5Ua3ZYMitu?=
 =?utf-8?B?dUsybjJYZEFEaVRpTm54d29JODU0WFhIYkh6alcyRGxnd0xuL0pWZ0FUMTg2?=
 =?utf-8?B?NUxxVnlWQVVZWjlXS1RaMEhlb1VaM2tYaVJUblk2OEV2aFFGbUVCTkVDYXFK?=
 =?utf-8?B?VnBWV3dGVHh1bit5TkQwblE5UmFhOURMVjdSRUVCbnpuYUNKT0ExZzFTc0RV?=
 =?utf-8?B?VVJxQmV4QXQySlZHelAvbStCdEpnSVJKSDF5SVJkQjlUa1M3aHQrdnRWMmRs?=
 =?utf-8?B?NmVzcU5SMElxd1NoaGcra3JsNGVqS1VORDUwL2tWWUlmTkYwT2pRVnUrSUJD?=
 =?utf-8?B?cW45Unc0OWdsTGh4azdMblVwczNablAvc1Y3YitvWlJPR0NoRG5wUHZwemwz?=
 =?utf-8?B?Smd0bDduUzhpTlBqYnFqTkNtWXdZaTlZbGp3RXFjVmIzY3h0Nys5RUVldUtR?=
 =?utf-8?B?RTBtYm9uU1JGTk9XejgxQWtjZ2c5RlV3eS9yWnhTMk5jYi9WSkh1R3BVWm5v?=
 =?utf-8?B?SDBCc3ROSVhyREZSWmNPZCs1TnhUaWFPM3hxdkxteU9xRVE1MGRtM1VpMjRo?=
 =?utf-8?B?b0JkUUlUT01qdkNoWmYycC82QkhybUVaSGlTNkpOd0NyYlZLa1luMjh0c0w2?=
 =?utf-8?B?ZTl2TlQ1cFd3anRLUFB5TkU4T29CejkwcFJNOGpmR2dNaUNsdXpjbVdXTU1l?=
 =?utf-8?B?bmk1bTMwQllyajRTSVZNaTl2RkUxUkE1eHNra3lqVkx3K0p1dDQ3a3Vhb0w3?=
 =?utf-8?B?elRGOG5na1NHMGdwTlFzc3VXT1BldHd3eDZ0YlRrQzB2a2s2c016dXZlbGxt?=
 =?utf-8?B?QzBtbkpKYWRNS2ZlRld5UUJZamswK2UzSTdtN2RJQ21tb0MxZUwyTk9mTHVM?=
 =?utf-8?B?eXNhSWRLSlNYR2piZWszM2tKcVQ5cjd4dnZ1R0hlQmtLOUk0WlVmLzFPNGdx?=
 =?utf-8?B?enNiRzZRMGR3S2lYaVBLKzFIR2xnakROck9lVXlqVFBmWGlteDB4dlY3dkZG?=
 =?utf-8?B?bGxlc3lrUjJnQ3dHMGhKd0tXbFdxRnl0ejVJOSttNkIyK2FFcTVPVXU0YWFL?=
 =?utf-8?B?cmJyQ3F2VUhyQmNtRWl5OU53VGJnNHRFM2NrbUtqSitXQVNGbGM5T01LVXFN?=
 =?utf-8?B?VXlrcmNucWthbDVhOTJ5OEptTjF2ekYveGNWMURFR2Ftd3BqVmFOTWlySnE1?=
 =?utf-8?B?WktIZ2FaQ2VUL2pNcmNGNTRvcGkyakRBN3BnbHR2ZzNZQ1lXRHVNTDdoUHFt?=
 =?utf-8?B?anJKaWQxRDdET1ZjQzNQdWtpeGJsTzVhTkcvZTBFdi9hTXFQNDh0U201cWk5?=
 =?utf-8?B?RU1KOXh0K1F5SnNPakNGeUpGcmxLV2RYd1RUb05IMnVIZDcycHJ6dTBLTEEx?=
 =?utf-8?B?V1FScDZMS2pHNHpGVk9YTGVmWWtwZlJUbXJINk1xd1c0cC9WY0Jnb25YWlJR?=
 =?utf-8?B?aURFWWhmRUNpN0QwYm5YVFlnUGl2NUFVS012Tzg5cTlTcEpSVWZzUG1yN3ls?=
 =?utf-8?Q?xqmKUPzq4rf6ZRIEybAhl6vbd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XIn6HQb7FfN+NzHKey+Hr+5kOGkHOOoRhfPYA2cS8eaqPQJrTE+s7QUCGAgK7LH3GieUoYkAVddDksaBH8T2FLJbZeRDXc+g8B8KhKQINGyCs7STtYiV6/anreTXolaHpO5jTI5hVKoDjSQ3xxfB6Qczh+VcNyEMwWlULYXR8reHSG2qfpHxA+PqJjp9fzt7Mnt34Y0rEl+Tq+B2mh/+s/gNm3r4D1V/P488A02OV2Y9lcpwc+WxSPaO7U2uy8ky2Uy47P2080iCWk+acYpckFal35FCxPzYLfbWQ3+UPU1SybmNA2JuWRxjuN4NKLairbGYSu1ePnM9sw3dPA2t4pL/LRzVFPCHKc8es/jta6giLbDf/NGjWiZGI2zYAL2OSzxWkrHuxr0IG0zsbVZVJJgroE9t9/GFvL/TPoM/J7YgPxORGJzlm34ZXwEHgsstUJ3Kw8tgwLNaHBi3dlsaqwFijmnfI8EGC7U9RuFOyNf1Y2avg5oTtC9/xw+AMbwX90nDitV+K8Rfq2frNF9bq7ysXWyeDP/E4JtLoCerau5Kt8cGCPf7IqR54lQ553OrCiYWQT9aRUwBCDXPFq3pW99jsrapMD3hIopOrHTPunP+cMcsocMQQegICCfjkni9a+Btofb9Cp5ZO6407418LfnU/rdqJ/LiU1NAHRmnQwYEjtjahUsEGbL3gq0OyXEB33qMIJEkOrYg6yrmsjU2kekMrqCGDmy7pqgIl2/MFUMRQB3n5xqLeOoJi2dLeUs3tiDn2xpK6wF2nPpqzKvYNf6+4/0jVN1xEDqjImupY0JM5sDBkeWDCS11E0eV7+MGH80P1hRLDucrI9REvoj831EWXN1c4WjTW3Xocwj2zNVHGVgsL1lMQrEgkLJqaXtN
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4511231d-6865-4f54-ff32-08db412ccda1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 23:21:28.8765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Te7yRkO061q3OWZuk5PVLjeyDzHY2slBVZMyuib7wHlFnYiKZioYq/K1cXr7oS0yfeZ7ihZMMXB4FbYEPwNmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_14,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190202
X-Proofpoint-GUID: qbbjNmrmei2xK7F-43wIGOnj7wPVEL2I
X-Proofpoint-ORIG-GUID: qbbjNmrmei2xK7F-43wIGOnj7wPVEL2I
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/2023 2:18 PM, Andrew Morton wrote:
> On Tue, 18 Apr 2023 17:02:30 -0400 Waiman Long <longman@redhat.com> wrote:
[..]
>> ...
>>
>> --- a/include/linux/mman.h
>> +++ b/include/linux/mman.h
>> @@ -152,6 +152,7 @@ calc_vm_flag_bits(unsigned long flags)
>>   	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>>   	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>>   	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
>> +	       _calc_vm_trans(flags, MAP_STACK,	     VM_STACK     ) |
>>   	       arch_calc_vm_flag_bits(flags);
>>   }
> 
> The mmap(2) manpage says
> 
>    This flag is currently a no-op on Linux.  However, by employing
>    this flag, applications can ensure that they transparently ob- tain
>    support if the flag is implemented in the future.  Thus, it is used
>    in the glibc threading implementation to allow for the fact that some
>    architectures may (later) require special treat- ment for stack
>    allocations.  A further reason to employ this flag is portability:
>    MAP_STACK exists (and has an effect) on some other systems (e.g.,
>    some of the BSDs).
> 
> so please propose an update for this?
> 

Just curious, why isn't MAP_STACK implemented in Linux kernel? what does 
it take to implement it?

Also, could there be other potential issue with the vma merge, such as, 
the user process start to truncate half of the anonymous memory vma 
range oblivious to the fact that the vma has 'grown' into its stack and 
it might be attempting to unmap some of its stack range?

If the vma merge is otherwise harmless, does it bring benefit other than 
being one vma less?

thanks!
-jane

