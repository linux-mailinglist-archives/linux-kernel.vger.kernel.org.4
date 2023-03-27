Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8120C6C9D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjC0IFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjC0IEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:04:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB7249C1;
        Mon, 27 Mar 2023 01:04:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7nWWF032066;
        Mon, 27 Mar 2023 08:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=iZdpxL6syHVn/cNJi18MFAsDdY3OUThEgJLdHNjLUYM=;
 b=03pxcue7tMGdUPPFI/Zpw67TPaVTvJeuGym+QSYbjswzVwfmby8qdJsV9EiOuBsTZSLL
 QyGLgwlzVqovxGWsUZg9X/iSH+nzG9rEaVH1qK+S6vHygUbAUmIbW/GYY+glVlnU3sQQ
 1NDAKLPqIdJafBsD+RiNvqklHj83/Hbi2cJFhTxT2MNdGh4Fvv0hXkaNZg0FeW2cR+tE
 hKei3WW/3rlbu5bgc7IoLLZFnr94E4Gsk0cQGnOhE/UswsFJ76TmtGDDjZMAH69RHKdv
 htJiOQbMTHJoNJW4kgg9kJzhGI9YQQmA1k1UsSsvLTMX/kmeY/yrKVCV4M0efP8qiIqX qA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk73bg2ch-26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 08:04:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R6xJ2u005343;
        Mon, 27 Mar 2023 07:55:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd4dg4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:55:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCSY321CW2NMi0dgJrqAXiRMcz2z78250F5IaVcDgiuSUea2BcJKJz93TlK2GLr1E6sa4ZgOa9PMxl8u3ZJbCXEa/Dlk1ldPbZ0Ly3xyRhfzmwlok3yaLXLu5igDZyKYAqRn3rlhgUzLYiw5s0sWIbtC50+QV2gWyD1JXTYTfhiL7OyTY1jiZI0i48q9k6NLCO1XtIlbE9bLDCEfFgQPb+0QqXTrzKUWkWON47ClAImhXuw+ucwiK0WGOq+91HIrNGII9Uv0baVe+CElkJYpSADZ2bN5l2vKK6KjHI2LTSHVdRbu7iQ5FyE8tAIfqF/psab5jpjDnUu+nME2mqb2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZdpxL6syHVn/cNJi18MFAsDdY3OUThEgJLdHNjLUYM=;
 b=OKYcqRWpMq3lEYBGJ9i1cCkNt7FZPE0pNY3djrsoar9PBwNaZnv/9P+jTSf+RJUl3My+Piwz8BfNuTlpNkOX52+hhAENmoWcbhn2qhV8dr4d78LM9CJy7Gh2nCe2SbblJbH9AnTOHxaU7vWeNW7nyqtGEuc+ZG9aPDidkqC4zeGyY03pQ6MS9MJxygRio3t3FGnOooj8Mp0j4ANU/LgQWWVILPSp8P0J4I+lY/2Ub+L3jrKJ5b2OK33UwqynK7r9U/6jBXuOtUCiwDD9J/yNn6o919P0NV2flRPj7PEUnQHKzAWfGCPap80ijrp56BUqNFbuElgIUJBuhxEXq06sHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZdpxL6syHVn/cNJi18MFAsDdY3OUThEgJLdHNjLUYM=;
 b=AZYqIMFTZnHL8P+f3k2xz7KnMWeB08p4ZXei5QRjg1PhzUnBAz48U9hpZxBTkHElsTICDKF5CiMhBAdOyQvFl3xqmcRwTYTSNC4S7Lj5SxKwVuGQaRIaeryf7IzOoGP2oZz+X/q05Ueayc6q8Psg+RpHiX1CRNnds7+KnnHYZUA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4631.namprd10.prod.outlook.com (2603:10b6:510:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 07:55:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 07:55:22 +0000
Message-ID: <72246c5e-6ba5-098b-a979-e90738cc7509@oracle.com>
Date:   Mon, 27 Mar 2023 08:55:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RFC 1/4] driver/perf: Add identifier sysfs file for CMN
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1679885172-95021-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1679885172-95021-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4631:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd2d110-db4d-458b-8159-08db2e989e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qIkWek5LqTS1/5vEJUif9GbdwrEjVxpM0oLbmtUaGG8a7rU9d9unicZxGpegUJ5pTvL7rg1t9TD4K7DiSD38MzWWTgj9a6QmJGAMv1E0UXS7jAxXcjuBu6vUgiBcGbj3M+YLLUozSdMsy0/ACuScsJfzoxBqbqS/b0p/XOL2b/cJncFbImrGoBZSmatvb8cJaKYfgVY/PdugKNOs6RcJQfS8SD5w7yG+Gw6Xd1CS1bXWorl2dn+GZ5i6Tziiexa88v0pWVGpwLfIyHKdU3vrezIS56Hm/6cQKjGBfdIzD1/bkgzefGfbpjuFcUy+FH6tlBjpNkTIO+0X6+QNfO69UAWGyv216VyVZb56vElOdKgYBXrOpnMqgllgtE4HmAx0YmspxIi2kurtdi5AwcucOc7MJybRNItz7mJ3bUPzur7X6XE+MXKONtXaVVNOUxnLTW1CbaIhkljN4m8Kx8ec6atfWM/E6rPeVOnqrBhb0f8ew0UHxUwpU3bQ7lxR+mN6Nb3A8pL8Bqgye19uYLsZTPwK0PuJ/OJl25PSDnwuRa2g7E2XxCqvqLw3xmt2a4+op4BXebcerLC+38L3kUf8/ynqyjnFFTxq0BihqhB2Rn+MzclGPPqaof64Jx/yZplzuU6LnVFBZCfN3XdgjjA9KpEfaExWPbb6ilkHqvwuvtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36916002)(316002)(66556008)(8676002)(66946007)(66476007)(478600001)(4326008)(54906003)(38100700002)(110136005)(2906002)(6512007)(6506007)(26005)(53546011)(186003)(5660300002)(7416002)(2616005)(86362001)(31686004)(36756003)(31696002)(41300700001)(6486002)(6666004)(921005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z003ZkNRU2ozYkFMZjVJYllXVlJ2TXlBNC92RGdQWVFnKzdNNW9FRHN1cm9I?=
 =?utf-8?B?ZHJlc2srYTBreWt5OFBiUWpPcGVxOTkvQVBVRmJEeHpVdGV0ak94MWVRRDBI?=
 =?utf-8?B?RUJVei9uTnN1Y2Q3c1orZ3ExNEJoQVJpMTRta3dCZk5jT04yUEV0dXRYMWVt?=
 =?utf-8?B?eHlMbS9xQ3pMN2ZMdklhYnQ3bmNYT0ZmU1FrUVl1QzVndVZaNVR5YmEwRjNw?=
 =?utf-8?B?ZlFOdVBwOFNydlpaTng1RTRRRVN4MllETWdQMUxCMHR5SVJ2dnpTSlpYQjZN?=
 =?utf-8?B?Q1c1OG1WU3N1dzVJYkRWaElhbjFWeTV0enQ2WmYxVm1HcVdsTnpTQ050NkNB?=
 =?utf-8?B?N1JFL3RGdWQ3YzNEdE9Vb0YxMk9HQ2ZzRUpyQ290S0VLcEN6OUFEZHQyNU0z?=
 =?utf-8?B?dG5LNnZHdEJqbDJyckw0MEcvVG1jaGJ4cGZoMzgzQ3dIQ3JWWnI1WldxTWlO?=
 =?utf-8?B?OGdvVk9vOVFDMU9LOTM4aU1tVVdhMEhJeGdMcGxSbXJCQy8ySktmazdySjJR?=
 =?utf-8?B?cHh1Z3hxazNySXo4b1oxTmM2NTBNbGJoRFhqTEdmT0ZDSXRYdVJEcXZ0b21r?=
 =?utf-8?B?L3ZMZ1VzMlhKSHhLN3lEeWtJVHNicFJSYnJmeGtnNnNWbXdrTnhuWkdieWt5?=
 =?utf-8?B?enhNSmVyZHRlelNIa29NZlNBdkFEMTJkY2FlYktydW1UZUNSWmNTWDlicDNP?=
 =?utf-8?B?NGkzVTF4UkdHSXRHWEljZzNIbklyUFY0WEJUVlRHRVFoMkdkamNERWF4Wm9N?=
 =?utf-8?B?YU5XOExKbEM3WHZ2WFlWUHdOWit5TDFhblRzWW0wQllocHNWTUNoWDFBMmJq?=
 =?utf-8?B?cUo4eUoyWWEyaTdMZHowUzg2ajE0UXlIVW93LzBOMW9CbUI3SzJhUmtqWTIx?=
 =?utf-8?B?d0dSQnNNYmJZdDNPM1VpRmVHVDlNSVJ4YUZuKzhwZVNmM1liOFJGTC9aRmc0?=
 =?utf-8?B?MXJaUy9CeG5jSnI4bWZ2NjlWYmJOTlhPdWFuS05iTEVOV2xjdzhFWnFPNDJw?=
 =?utf-8?B?MWwvd3VoZEtVaDlqeUk0ZFBzb2l6SmMxZyt0VFQ5SUg5bEt5c1BtU25sODd6?=
 =?utf-8?B?d2V5N1JGbXRhcHNiSGpHTXdMdXhmWWkzUHZ3N1NkZXk2Qnc3ZjFxcG5INXBM?=
 =?utf-8?B?bndtNTEvakkzTjdXd29hTUMzQmVOK1BUS1plaWdGRHcrd1Q1cy90UmdGQmlE?=
 =?utf-8?B?anlKQS9DeXpVSmkvc3F0K2FmUURUYm1xdkRuUDM3OEFIaTY2WmdEUlc5ZU9Z?=
 =?utf-8?B?N1h4ZEZ1Y0VhWGdKK2V4aFNxaWFRRm1OeFRhM2drTHh2U21wWG1yQVV5ajBT?=
 =?utf-8?B?SVNhUXM4Q2JXMHZ1QVAza0ozV2FJUUV2TEZ6VktiRFFDaVZpcUNxWGVpZ1ZK?=
 =?utf-8?B?MEJFWE1nU3NHaUl5a2J0eHhlcFdLSGJaT2hJYmk2cFpOQ0RUM05QbXgxYzF6?=
 =?utf-8?B?OXdOM1crVSszZ0U3TzdZejhhL1B2U1pJY2JDSTVCd3BxazRocTR6WXFIMW1J?=
 =?utf-8?B?ZTVpTVN0TkZ6U2JPZ1RJVUMyS3E2cXZ1YURIaWE2MnJ1Mnkwa1V4ZXhaU25a?=
 =?utf-8?B?V2VwcnFoY1lRNEhYQ0VIbnl1QXFORll3ZUxPTk1YUjl4NXhEZXlNZ1pFMksz?=
 =?utf-8?B?ZXFxc3QwWWJuZDBiYTJ1SSs5UW1scHFabGovNE5XUm5PRTRwR2Z0bTdvL0x1?=
 =?utf-8?B?NXBiRE40RFhicUZ0ZGxKdXNYZldKeWRjWW1mcnNQL1VqQXhXUks5TXRCc0NJ?=
 =?utf-8?B?aHIvNTVUb0RiRDIrN2h5dVY2eU81ZEtVenVDdU9BMmRPQzB4YjZab0tvWFRN?=
 =?utf-8?B?SE1pV0UyeVhaSFNIY1pxV0Y1d1VMaUkzUnE2ZkxhcnpqMVAyekwwUlBWdUFY?=
 =?utf-8?B?bklEK3FGMUY4bEVXVkE3UlI4N3BkUFZhMmZCODNVaE9xMllwdG1FR0NySXc3?=
 =?utf-8?B?MEFPYVcyclFYNytPa1dGdi9ESUl3QlVrZmszczh1dTlhUGNsbHlHVmFvS3ZO?=
 =?utf-8?B?emt3UU16UkhnbTRNUWdaRGZiTXVPRnZNSXBxVCtqS1RTK0dIM2RWNE9vcmZI?=
 =?utf-8?B?R1k2U0J6Y0RpMlRjb0F4MFJtWEREZTlOY1BZUzg1L0htOGhnNWNpTHJjejNw?=
 =?utf-8?B?cmoxQ29uYzFoOHVyaXlDZTJFZU9zNUZZbzhWUUtyMUtlMVBFbFVSVGlhcXk4?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U0FjOEZncHNSWDhKSUFmRjEvVFdJYlc1Z3JKMldHWEVQb3ZOWE9ZbnJIM1RO?=
 =?utf-8?B?WHlRdFNOOURRbWIyZWE4WEZleU91MWZ6czNSY1Y5VW15NEJzdjg0YmtBcHB1?=
 =?utf-8?B?Z2xlWTR1Y216elQwdG9VM0MrdHpvbjZmVStub3JGT09LSmVnK3AreEd1bjBM?=
 =?utf-8?B?aVRmbldWNXk0d3lFVldrT1Nac2g2N0FRRGJRNUdCKzhrV2xROWh3dGNnekdk?=
 =?utf-8?B?bUtNSlhlSEtNWkQrK2t0enJWWVF5RjRReFE1bmJWVXQxc2l1WU1Uc0Z1NWEy?=
 =?utf-8?B?RytxL04zRldvSzYxL3c0cUlDeFEzbHJURm9tSHl5U2dSUnZiSjY5bHdOdkk5?=
 =?utf-8?B?NzdmdXFRbW4vT1dvTUg0WnFRelBzSHRmalcwSnlMNVcvMGprUDdSRFB4SHl4?=
 =?utf-8?B?ZkYzSkhxcEsxdFJsdkJia2pXTUR2bkVWVDhzblgxbzR6UE8zRE1xOVZvbjJX?=
 =?utf-8?B?T1ZrTGRwTzhqS1JETkhDUlVUMkJnbTVBcGlwWWdDOXlNdXltQStkdk5pcUxy?=
 =?utf-8?B?Mmh6d2RmWXNFTzMwZGxwb2VYUWJ6azVadHduS3QvREhma1A3d0RONUJSQ3Bu?=
 =?utf-8?B?dTNxMmlEMlV4VTI1cXUveXZhdXpkUWNwTHR0c0tmcnorYnpsWWRCSmgyeVZx?=
 =?utf-8?B?bHJWYzVjVWR3cStkamtvV0FNb1p4Ylg5L2tkYWl6cUdJQ1hsWEh1RTJkRTNQ?=
 =?utf-8?B?Z0JldWRUTmZVMkJhLzVlVDI0ZzNvREFTSVZoaEUwWm02QVlLOTlCK0xnZVVY?=
 =?utf-8?B?TVloeHEyRC9USERqNkEvVVdXT3ltRjViaE1DYTNSSXpIa05uOHQ4aTA5UjZk?=
 =?utf-8?B?Z3VSM3hMVXhDRXZ1Ti9EdVI2bCtsWjU0a3gySHVEZTQ2Qnp2K29xbHNSUzlK?=
 =?utf-8?B?RlYvMSs0eXBVYndLRk5CakJMaUF0ekxHcFpLNXNyR0ZzeG9LREp6d2xnM0NG?=
 =?utf-8?B?VTgxNGEwaGtwWFZVSnUyT2htUUlYTWxsNHdmeURZNmdWK09UeXBpcldkdWcw?=
 =?utf-8?B?Q1JIWFBBNzRPbWJ6VWZvQ2RBVXJDSS9wT1RPb0VZNlJvcTJOSHVaRk4yaWpy?=
 =?utf-8?B?M0V1QlBPYXZoK1NEMlFXQ1AxUGdiMWZ5Wmk3REFOdXdNc1c5RUFZU0c0Y2VO?=
 =?utf-8?B?aEZQOGpuVk1SWlJuNFZXVUUwZnNQWWxRY0tSVzZRaE91QXhLVzA1Rlp6K3M5?=
 =?utf-8?B?M1ZCcThwZndyMzdaYUwxdldSd1pFTUttN1l3UG1pZllESkE3aXF4Wm5WZnBl?=
 =?utf-8?B?U0hPY3Q0MU5MZ1FVZXhhWEdack8rOW9BVklhTStaaUExSW5hNGVFeUhRY1Jk?=
 =?utf-8?B?N2ZtOGZoS2ZuTmcvVUtZaVRXQ0g3RW9SeTJaS0F2Wno2Y0dhMzJyOEswWWxM?=
 =?utf-8?Q?D3/QEiiAeF19exOMOtMEIewig4kIbAz4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd2d110-db4d-458b-8159-08db2e989e04
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:55:22.6871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6U4V/LMmcmbBXS1oUBFaEgWuyij3gtWbzwzsid8Pb8ykERyzpcA+YBqXEUIxTVlkYELtvCkG1EQua7U9OqW3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270064
X-Proofpoint-ORIG-GUID: qUcvNT7wGiKmordaGScK7TwtJqIxFPv0
X-Proofpoint-GUID: qUcvNT7wGiKmordaGScK7TwtJqIxFPv0
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 03:46, Jing Zhang wrote:
> To allow userspace to identify the specific implementation of the device,
> add an "identifier" sysfs file.
> 
> The perf tool can match the arm CMN metric through the identifier.
> 
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>   drivers/perf/arm-cmn.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index c968986..0c138ad 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1168,10 +1168,53 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
>   	.attrs = arm_cmn_cpumask_attrs,
>   };
>   
> +static ssize_t arm_cmn_identifier_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
> +	if (cmn->model == CMN700) {
> +		return sysfs_emit(buf, "%s\n", "CMN700");

Is it possible to have a pointer to this string in struct arm_cmn, such 
that we don't have to do this model to identifier lookup here? If-else 
chains like this are not scalable.

BTW, does this HW have some HW identifier register, like iidr? I think 
that using that may be preferable.

> +	}
> +	else if (cmn->model == CMN650) {
> +		return sysfs_emit(buf, "%s\n", "CMN650");

I'd use lowercase names

> +	}
> +	else if (cmn->model == CMN600) {
> +		return sysfs_emit(buf, "%s\n", "CMN600");
> +	}
> +	else if (cmn->model == CI700) {
> +		return sysfs_emit(buf, "%s\n", "CI700");
> +	}
> +	return sysfs_emit(buf, "%s\n", "UNKNOWN");

can we have a "is_visble" attr to just no show this when unknown?

> +}
> +
> +static umode_t arm_cmn_identifier_attr_visible(struct kobject *kobj,
> +		struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
> +	if (cmn->model <= 0)
> +		return 0;
> +	return attr->mode;
> +};
> +
> +static struct device_attribute arm_cmn_identifier_attr =
> +__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
> +
> +static struct attribute *arm_cmn_identifier_attrs[] = {
> +	&arm_cmn_identifier_attr.attr,
> +	NULL,

nit: no need for trailing ',' on a sentinel

> +};
> +
> +static struct attribute_group arm_cmn_identifier_attr_group = {
> +	.attrs = arm_cmn_identifier_attrs,
> +	.is_visible = arm_cmn_identifier_attr_visible,
> +};
> +
>   static const struct attribute_group *arm_cmn_attr_groups[] = {
>   	&arm_cmn_event_attrs_group,
>   	&arm_cmn_format_attrs_group,
>   	&arm_cmn_cpumask_attr_group,
> +	&arm_cmn_identifier_attr_group,
>   	NULL
>   };
>   

