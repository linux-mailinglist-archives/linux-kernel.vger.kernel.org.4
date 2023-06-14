Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0707E730281
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245645AbjFNO4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245636AbjFNO4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:56:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B054F1FFA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:56:03 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EDDj2P018103;
        Wed, 14 Jun 2023 14:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=H4fYpS+78RL2i4rCE8TnBzAPcqLInIxF0GxbsgfSK4g=;
 b=xyHZTorVzWj63EZEJDzLct3g9CWKnaW/oxilp/9kWQDQEz4vHsh6YojU11fOMA8PrRlk
 bqlkLbaLmGujMZ8MtIcFn2edj8Fe016ETy+k6vfQA6KbP49iz2Ts2n4ZDwewxzexZVme
 DoQvOLbCfJF3OFHJyDfyUOa3QcJ+hWAKYPX0/mvKCjYiw7Ih0X5J/HfgEJHv9MkSK2GS
 ESR3J2/Lmq39VE4bDPpdIpirCZ+mWMwevT+P0NR4/Bn4dfmhuEfMS9vFaVnLbx2O5IW9
 /sN26LuIffMVt9xm1oXjRtUr579jSA4czn/EevfFlTLuV5YyDqFuYWRjKGAHdCld+xqS Qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d7tb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 14:55:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35EDkjxq021591;
        Wed, 14 Jun 2023 14:55:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm5pek8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 14:55:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQjRlpV8QrM+7fpYIYIuMfzR6tDg0F0JwdL8L37ZIFJ0ZQMAsZ1aicNah+2HEv4wdGYEn5gqpHsPl+QmslICev9pPvi9BNt8j4OkJE//942cjwMq9URlsH6JaTEXzRspmKCMmewCj0BgT7MkoV8FGRpFgZXuQQfKhflU5gyZNusLO8AuLQ18Ai6k0uJcTichv0O9CjXySuGFaZD1+JJIRa1g6sas7CF/YzHOH2OzSWfgX6bYjnYM2bSzeINmUD88X4DvolxrNtwGDKPuRpnl29HhschT4XcNE41bLOSqOkcxwp1qxgTM31h1HGorkEe6/4m6tOXbzs1kh4VNAHvCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4fYpS+78RL2i4rCE8TnBzAPcqLInIxF0GxbsgfSK4g=;
 b=AEbnvXZ5Hgz3mR8BflVsfQPRtGYm2dARZODDh11xXkG7iO9DcH/mCpGRQj9PMRyGMqiWwK2NdDzWUvSNYJISMiikB+2YwK8pjv2cpCI7xf07DvDHt4q5hEsSPtDKDKTctlAQDSVPaSdFY6qe8JYtL1QdjpVQ77n2U9TWmkPE4gSzur7QtV7B0uGJZIgjy7mhyn95esLv0ZGU3Dwm5duoUgLIE52pynJoNI8lRMCJut/x9ah0bglKVsnuoWfQkglYczcdg05sSIGBF7BsuzxOrgolOg+yqL/hwZYDWttEcU4672GJ8a6bTST/C2OFuDFfzCgpdhqN5zPG/H8DSEiaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4fYpS+78RL2i4rCE8TnBzAPcqLInIxF0GxbsgfSK4g=;
 b=YtQuDjcAuGiFiNHbGdYsFN9UWH84p9egnwdcVQ1nj2db5vQH4siRepc086wTtaX/R8yVsgRAkW5XsG58xNyZtt+vi5lB/Fm06hhcZlmYSbJKnsezVC1ttELHvGAg39kJL7jEWlQZ8EXFMmcL9EB2NxQP9sok/IRLLwecGsGQmZg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5173.namprd10.prod.outlook.com (2603:10b6:408:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 14:55:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 14:55:46 +0000
Message-ID: <5efa7af9-6347-a409-370c-b8b78b3d53aa@oracle.com>
Date:   Wed, 14 Jun 2023 15:55:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] perf/arm-cmn: Add sysfs identifier
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org
Cc:     mark.rutland@arm.com, ilkka@os.amperecomputing.com,
        renyu.zj@linux.alibaba.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1686588640.git.robin.murphy@arm.com>
 <b8a14c14fcdf028939ebf57849863e8ae01743de.1686588640.git.robin.murphy@arm.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <b8a14c14fcdf028939ebf57849863e8ae01743de.1686588640.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0100.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5173:EE_
X-MS-Office365-Filtering-Correlation-Id: b08c4672-9f8d-433f-e400-08db6ce76f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8/kKwXU4+q+Pw/lf3ioXgQeI0mwjuMRrEJ3XyUcDnpfXwmCqewehV2XTmm7kaORGBwwfclcqmsMxtHOSNRiQF614HGXURTZ70GFtwh4rm7byVeUasbRD4Xyfhtb+RnQ9/P2gQzPIQUG/o/vGZw2UZfjAChWpGP/FYK2Nz+HDkBbYaMpytCWVpGHh3zfvjNJvi+Lm/GhORmyCjNPzBoKs+hWoFWSgI7fsIeq50TEGUfSFR5qL+gim+uBclzWYa1bKZvUYx0ki3Phek9K+Ht8jFLLXDE7cx+Zqn+TbU38Nn40p/MEwUknWs0dM0mHWQdbRDEhPVUkwgBLnu2xjJmKkaAap0kGD7Z+lNUr44lPG2hjrN4y97YLXpUM/y4fiJXjYf2ERxeAzg7x0lcrARL6kBgmrThqFzXrwWBfcA7+YQbB0NkZvzMjGCdTLqnCw89S9N4W1VvA5tEJB+A38JpW1eck7cLrExYxJusvIQ+IeCfEu1THpfWAGpKB0JMeizdUtpGQoQ0GViUFISD7cQkjNdpUHCMApdg6zoAHaf4M07zWq8LjGmLzqATsn6uxGckH/OOVP14lI6m+aJT/XnJd6IHICyOX5P4rzvGYYH3HmgSvMdmZlxrdrBzqwxIoaXLXYSDULjA8HvnpOp2NYB6gjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(478600001)(8676002)(41300700001)(8936002)(4326008)(66946007)(66556008)(66476007)(316002)(38100700002)(2616005)(83380400001)(186003)(6486002)(36916002)(6666004)(53546011)(6506007)(26005)(6512007)(5660300002)(31696002)(86362001)(2906002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajRRTW91L2hlbHZIQ0R0aFRqOTF2eURUcko3Q2doSlpvYVE5SS85T2VUdENU?=
 =?utf-8?B?di9pZ3F4eFlWdEJxWThuR1VLdHYreUtnTlhXTzI0U2ZoMnJmSE5JbzdsbXNk?=
 =?utf-8?B?cVAycytEcUR6N1E2ajcwNks4dXV0VlRyOWlPN3psOXFsSHRsTjNOckE1YU1M?=
 =?utf-8?B?WkJMWS9WRnlkb1pGb05GbWtCSEQwRGpodXBneHRaTzBBMHRRb1pBcTR2dG9p?=
 =?utf-8?B?RitIK2tDMkMrTTE3VStsK2k0VHNrcFhoR2hYK0Q4amZDenM3NmE2ZUZFREhj?=
 =?utf-8?B?c2trRlJIUi9td1dYalI5SEJ4UEE5UUhpZmpjcGpEU29UeHRrUElUSCtINXVz?=
 =?utf-8?B?YTZlVUlia2RNZ1J5MWowcEY3b1VSRDVVWUVrb3lFMUQwNis3a0lxbU16ejF1?=
 =?utf-8?B?TkhRU1FxcXQwQ3docWh3NW1zUzhGLy9nSWYyVE9xYktQd3JzUDZodGVla3c3?=
 =?utf-8?B?dVNLVlFDQll4aTY0VXk1R1NVbWJjSE1saFNISHhzcFRxcXZiUWRCblZ1cHJa?=
 =?utf-8?B?Mjh4dFBNK3M0cHNWZFJTN0FiYXBDVjNocHl1aWwxNmV0WFdsQWQ1Q05kRDBM?=
 =?utf-8?B?NkM0K3JReUNaUjltMmJqVnNUMWIwbUMvMVAyRndtemJmR2RRZWcyRU9DRFBq?=
 =?utf-8?B?UkVOY3BHOUNVaURIK1N4NGdNK2s2cElJd3hjV1RoNWdVTUROaWJTWFdSYzJQ?=
 =?utf-8?B?QjJxLzl3ajFaSGxOZDl6bEFRR3hTa1hvdEUybnozZWdoNmFWeUFMbVdicnJW?=
 =?utf-8?B?ZkE4dXRjenR6djFiQ3lBWVBEbGNIR3BzMk1zZXNKblF1VWpDTzk0WWlHalln?=
 =?utf-8?B?UXd0c2Q1d2NmbEk5azM5bVk3bUZ3YmhHZnZVenpyME96bHlxUXdpNjM5b1FQ?=
 =?utf-8?B?NHFZZ05LNXRoMmt0TldnTHRPNWN6NklzdHRvM0Fwa2VwTmxhUjhQVGwwZHZr?=
 =?utf-8?B?RUNKVE42eHZPUUpseEVLZ0YrbzA2V0JTaUVpSVVaYkoyWWhDeGYrMzBUOTlD?=
 =?utf-8?B?WWxmV3k1WHM0cVpEKzc1clBQaTY4QXlZWjJweDRIRlp2V3NCL3d4SzVjbDU1?=
 =?utf-8?B?RUtyaTk5Nnh5Q0gwWGFyODlVUDlqNy9xcjdaalBuajNiZVNoYm82aWFHS3pu?=
 =?utf-8?B?dm8yODgvVnFBditvakJKb3NVdnZxRkR5Z1NTdWxhT2lyWVg0c0VDVE1ITHVi?=
 =?utf-8?B?N1lERUZxeTVxcW1Ua1djN0lGai9uLzR2NnNSOHcwWFZxMXFyaHRWbkFkWmwy?=
 =?utf-8?B?MWNVWGJYc3NJQmhNdm1uYUdaVW5qZkVLQ2tSc2YybVFUV0gwVzNOVDA5ZzVy?=
 =?utf-8?B?MTRmVlhhN0FrUjFUREgyVTE5Y2hkL09QM3JyUVdieis4b2RHVUZkeFVhcXpn?=
 =?utf-8?B?SkVwV0I1TVhqa3dzbXhVblhjUWNNdVRuZERFNFhQcVRudGtvQ2FWeHVWeXVq?=
 =?utf-8?B?NFF1NnZHay9mZU9EL2JVZVZIaGkzcjh0RnZJZjNNODBOclEwaUs5SmxIQ3E3?=
 =?utf-8?B?S0FmeGw5dW9sNmhpL214eWNxNFVSYWJ5TmhnSlpLUDg2bjZJUTkxeW9rdnpW?=
 =?utf-8?B?WnFLWUd4Nkh5MENycncxSmUyTXh6QmtjT3QwdC9Hdkx5dnVNRjVnV1c0MU1Q?=
 =?utf-8?B?NjJEdEN0ZlkyaVhhenhUMDY3dFdYMWtPVUN0UTZveVhiVjN1dnNRSG14eE03?=
 =?utf-8?B?R2Y0YTdYMko4V0d4RUFQemJ1YTA2c0tyekxWUGFVRVd5R2krTUNKZDE0UVo3?=
 =?utf-8?B?Ukt0WVVBbmFMWE1Kbmd5Mmg4eWRPbDVaSHRUYzJzdDdkL0M5RzgxK3kyZmo4?=
 =?utf-8?B?a3lUWjAxOEt5Q3hFcnRsUG5ONDY4Y3pNdTV2ZTM5cW1SNDlYT0x1M0V3czgy?=
 =?utf-8?B?Vjk1YlA5Ri9VaDQ0OXpyNTFVaFVzNUZONHVjYzlIci9adEQ1QTFCSVRsZGdN?=
 =?utf-8?B?N0FrSEk1akhHK0dDWFNQS3JEK3JRY1RveXhYNFpsejRGUHMrT0pBRXZ3S0Fx?=
 =?utf-8?B?TnBmdzlrVi81ZG9GK00yTDdYK2g4Y0dDeVB4Tkc2WXBKRWMweUVjOEhYOWYr?=
 =?utf-8?B?NFFxb25XWGNub3hFZTE5S0FkUUpiTGwrTnh3eGpOTlJLUExqcW51Yy9HWnM1?=
 =?utf-8?B?OUpJYkY3cmVXbUt3ZVFKdng1NWZMNUE4NW82bmpwT1FGRUdhb3lrblE4cGFU?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SVlPN2V4ZTZoL0wrTEdGelFIMFBSajFJbUdjbkVIWkkzZFh0SnViQVp3S295?=
 =?utf-8?B?VjA2V0dZMUs1MUV2MEM5bkg1cEJPNGVNY0N1aWtuNmdLWldUekI1OTViZjMw?=
 =?utf-8?B?SHJWVUZFaDB6Sy85eXl1ZUtJeExmZ01sTnlMaUxpV0g4NXhBSjdUV2FnNk5N?=
 =?utf-8?B?YnNRSE04UFBHSnE2d2Q1clAybUFNMktoWTBXa0ovdXhFVXJ2cnBQY0hKRiti?=
 =?utf-8?B?Tzl4bDZBNmZYYW04VDZ1U0pSV0psd3lOdXcwUllUMEVRbnJlL1FPb1hpazlq?=
 =?utf-8?B?Nk4rOTNWc0NBNFhVZnF1bWdueEVSTDd5elZWUHZVeEhDYUlSSlp4WWROZXJC?=
 =?utf-8?B?cUVJanhzNWdGRnZCNXJHVHZkblEza2FXemZvdWpNeHhpU2kwZlhCaUVxWnpT?=
 =?utf-8?B?OWZXOVRLdDY1N2dCWEQ4aDVMWUZYMzYyT1NUcEdSTFN0UFh4b25qcjZQRVBU?=
 =?utf-8?B?V3o2djhheTJNUExEbzV6ckhrTm14b1hyeGhrbkJSNXZHZm9PVTNwZEVoMm56?=
 =?utf-8?B?aTUvTDltSDhGbjNTVzBEbVFjRVBzaC9CSGZUYmJ1azhDeUFKTW40SmxqUlBw?=
 =?utf-8?B?VUdrelplYWlMQXBjT3RlZVk2OFVUb01KSXVYb1NsRSt3TS81VlVROWhqaG5X?=
 =?utf-8?B?ZWs4SDdtby8xREJnTWs2ZDhvS0M1YXJnMi9NbjhCWnI0RVVJVC9TNDJiN3B0?=
 =?utf-8?B?VjVGN0NsNXZ5NHplUllxNVNPcjV0WTFjV2Zoa3ZmbG81cEV3Q0VOL1l5bHlM?=
 =?utf-8?B?Y0JDWkVpTzFHeFk0WGp0dVNyQTUrQWV6SmF3YzlITG9pVTlmOXBoZmRaK0hW?=
 =?utf-8?B?bjRLQjNHR1hINERndGU0SnpOajQ2ZFdxcXJSN1R1Tk00OExsNVRhbWtCU0FW?=
 =?utf-8?B?bUx2ZzFwN3pjTk5pSkg0UzV0RURsbWNrVDBOMnQydGE2bFI4RXZlN2JQZFU4?=
 =?utf-8?B?WlU5Tkh1RG45Wm0wdGFUSjRMZ01la3plZUt4dXhkSm1udXYxNXd0OCtWbEZz?=
 =?utf-8?B?ZXBrS1hwWUU5b3d4MlZBRHpPeko0YzN6K3JyWlN6MWhlVGhDVUxzT3VMSG9R?=
 =?utf-8?B?a25MN0RPNDBTL2dGWWE0akdYanpYdTBzY0NPTi9ZVXdCeThTTXZXRm55bUUx?=
 =?utf-8?B?OW1yQTFWbjlvV2E5SzZXK0kyTWU1RkRFTWM4d1Rqb0lkcWNycXFhQWZwbkNn?=
 =?utf-8?B?eUJzVWJ2RjhEZEROYUNiL3dFRlZZSUtXVzhJeEJ3Y1hGMHZwL2RVOEZKYVNK?=
 =?utf-8?B?Q2pLR2o4V1l0Uzlkb0Y2NENiVURiZFM4MDUwZ0QxRlBKdGxXbXVkOGpReG5s?=
 =?utf-8?Q?mDUh0mdtM850o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08c4672-9f8d-433f-e400-08db6ce76f38
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 14:55:46.4029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRb/e8Ftk6ppLdQZqMKSpnJzP/LXgxtKmP9LeDtIlsEAvhpt4/PdcgCV9tb/Uf953UA+m8FF3rSx+CLxK65DQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306140130
X-Proofpoint-ORIG-GUID: XHF5jAz3SJ4kr2AltFdbEhFAd0kz9b3o
X-Proofpoint-GUID: XHF5jAz3SJ4kr2AltFdbEhFAd0kz9b3o
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 18:16, Robin Murphy wrote:
> Expose a sysfs identifier encapsulating the CMN part number and revision
> so that jevents can narrow down a fundamental set of possible events for
> calculating metrics. Configuration-dependent aspects - such as whether a
> given node type is present, and/or a given node ID is valid - are still
> not covered, and in general it's hard to see how userspace could handle
> them, so we won't be removing any data or validation logic from the
> driver any time soon, but at least it's a step in a useful direction.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

FWIW, Reviewed-by:
John Garry <john.g.garry@oracle.com>

However a comment, below.

> ---
>   drivers/perf/arm-cmn.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 8cf4ed932950..088dc5c690a4 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1199,19 +1199,31 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
>   static struct device_attribute arm_cmn_cpumask_attr =
>   		__ATTR(cpumask, 0444, arm_cmn_cpumask_show, NULL);
>   
> -static struct attribute *arm_cmn_cpumask_attrs[] = {
> +static ssize_t arm_cmn_identifier_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "%03x%02x\n", cmn->part, cmn->rev);

I don't think that this gives the "0x" prefix, right? It is just an 
encoded string of values, so not strictly necessary or even appropriate, 
I suppose.

However, if userspace wants to improve scalability by, say, matching an 
event for all revs of a model, userspace (perf tool) needs to be 
programmed in the JSONs somehow since we have no delimiter.

Thanks,
John

> +}
> +
> +static struct device_attribute arm_cmn_identifier_attr =
> +		__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
> +
> +static struct attribute *arm_cmn_other_attrs[] = {
>   	&arm_cmn_cpumask_attr.attr,
> +	&arm_cmn_identifier_attr.attr,
>   	NULL,
>   };
>   
> -static const struct attribute_group arm_cmn_cpumask_attr_group = {
> -	.attrs = arm_cmn_cpumask_attrs,
> +static const struct attribute_group arm_cmn_other_attrs_group = {
> +	.attrs = arm_cmn_other_attrs,
>   };
>   
>   static const struct attribute_group *arm_cmn_attr_groups[] = {
>   	&arm_cmn_event_attrs_group,
>   	&arm_cmn_format_attrs_group,
> -	&arm_cmn_cpumask_attr_group,
> +	&arm_cmn_other_attrs_group,
>   	NULL
>   };
>   

