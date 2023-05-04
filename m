Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB46D6F6971
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjEDLED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEDLD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:03:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042C759E0;
        Thu,  4 May 2023 04:03:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34444K5b032618;
        Thu, 4 May 2023 11:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qumFA43jzQS+6QSd/gfzPZwhbK7V496XBWbqAT0HL8U=;
 b=q8c5Ig03DKq2w57HLiFCcFv0IYdwK7U6lyaP7uMJ4lzZ29vnMvVTcZWjf4B/vV36mxji
 kD0ecnSddZvwSKle1M9IP1J9SBo4sJ6nFuBv/NaUGxbi5BAp6JdvKB/s7a5YoTeSxk/N
 muWk9AUaYqjUqVA8E4pQT0ETutOy1udUTz1YkpET08FTynQQ1uJpuMN653SoaSMZp4q9
 kmaqC3Kv0yrZsqHBQf/SPAmcEiGXAJ/YyXJjxKYRxhecdUa6cVl3tufLnDjU6gIty88w
 9/XjbPwldePfEiKP/6Ifo/pa2W3lbwj53SxkPR8+wmAaqQIjHqUmxFAmnLAG4ExMb+Pm UQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qburg9msv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 11:02:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344Amv07020732;
        Thu, 4 May 2023 11:02:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8aqsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 11:02:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqlEG3f+fgnBklZS3KtydqbgWbZA+B0PRou0OwXbHca9pi/YZbVbVjky5F5Ti8vwTsbQJ5PWDb2pwAIYQVAVhKi/GQ82p1CHKNgOvOeprgPROLo5UC4LUzRSh/5x0tHzyHGoOrtrdUoMI/WRaYDaDtNP5HMIwQNRKNj46gyG5i73HkjVWjiY4E939YzshnBUf3tlH1e5TJw3XrG7ckhmhrHn9JUut+HjrKXO+Thz0h/yf7YpSZpWhFI5GdA8PF/QywtdQTvKNuM/age8IflPhRPr2IoZkBv2x+7WOssgsqO962PPkR/HEMKk7jtoXQ3OWWbwHg3mEpzQm6PZU0MBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qumFA43jzQS+6QSd/gfzPZwhbK7V496XBWbqAT0HL8U=;
 b=h4q4yK0wclfiu5r9K852FWPXS0TNB6/ckLOXRdWUlvMnhbWOi5+UIbQm3LDzAn13A+o4i0609EUoD2zjHqkc/71w43iiSUqyJhd7cOsy3kKElIzPi+8QvOk0O5zagqzaywDd6Jc54fled472MVopEgehdp+HMbcWIuCGwi7p60j9YnZ/dkY2BBAhsAQzIpAMebKgY8/LdHo0nEI3lTj5zVsEKJL4TrZIZonNpRUz29mC/kUzj22XZvb6XcFzXXwUTTImJ6CgXIm800A/TaRlp5fm+Sh0HExNX/99+PxvifUd+g6Iyk+Zuo0z4JlBR59/CvFQmD3VKXwErxCtsvL/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qumFA43jzQS+6QSd/gfzPZwhbK7V496XBWbqAT0HL8U=;
 b=shAkj65QQ+t7FGsBN2axVRP/NNrj3v94jL3pvL6c1sdX0ADNZcyWStZXXq3mwH/HA9KlHdXHk9VoJrT4x+5OEWH3/OvZkSO/toyHMMpJbq5B5h6eO0WcrfCaQ/FPdF6NAE2vA3qHoBFv4NXMThvhRi/E2wOCDfFWnZ0k8RNS0Jw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7156.namprd10.prod.outlook.com (2603:10b6:8:e0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.22; Thu, 4 May 2023 11:02:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 11:02:52 +0000
Message-ID: <da55ef21-e199-79c3-5b65-d51edb2e754b@oracle.com>
Date:   Thu, 4 May 2023 12:02:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/5] driver/perf: Add identifier sysfs file for CMN
To:     Robin Murphy <robin.murphy@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>
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
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1682329456-19418-2-git-send-email-renyu.zj@linux.alibaba.com>
 <df63b597-4355-b9fc-6002-5a390b1a56f5@oracle.com>
 <12bf4a7f-e99c-47cf-e8e4-e2700db6c5c9@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <12bf4a7f-e99c-47cf-e8e4-e2700db6c5c9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0010.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: aee0f6ca-3947-430c-f64c-08db4c8f1b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eo8+p5ATOmiNxkriTfSldc0KrxHbtQOa7cjpB5xetPeRmIHbVzR/F9XA7uSi9V18LFHvJW7eF7uHEoL/Ae9I+R/os+mNZnQiwZDUoqQqjnS8YwEagaCgXyRhM3welGcVi/U4bNGVPkDasBAO2g3/GRY7/F9Od/ej73iFrV0ri3tgf+BqG5YAOI56e2iZN5wUUOKNDPjdOT3L4M4tF0sITMbzmLbsJp7BH9i/nEY98WYcyCT3j//PIqcdJlWPGS0h5jWgVbXVI6RK/4iNDSkFO6gFWvj9B6vED+xiRxQCjQC+xXfmLpDL4DWxXBifxUi1lJpT5uQXzGl+EAVt8hYy5c+H59OtrKSKVDwsWcMAXOh6Ja6OkyiyAB2zjzYrB1u4JzIYonw5bMW3/gF9o+K8J5FY8Hfe7zGznG8nj2WW1pEd+VW5jfwN4O+GSStUZ50Kekyts0Wx/s9B1khZVakH+d/3diItVZ3NlxBt+nQZUkD5I/35cU8UfcyF4GKLUvhmThRVCkDLGlv3H+scuUHo8p1rxqcJGRE84ZxNZY2ociNCVpEfNRaltra08DlH1xhS/GIqddGPu+OfIS5jfd7d+LPJVcFxXo/YqK40d5jlQ+FnI1vwYhte6cbEJ06BGsr+L8b0KJ/uCitQYp7s1A/Zzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(86362001)(31686004)(31696002)(36756003)(38100700002)(36916002)(186003)(478600001)(83380400001)(2616005)(53546011)(6506007)(6486002)(26005)(6512007)(6666004)(2906002)(110136005)(54906003)(5660300002)(7416002)(8936002)(8676002)(41300700001)(66946007)(4326008)(66476007)(66556008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEsweldrMWQ2dW1sU2NDTi9FMzVUNnRCcVdldTBabE4wc1dHZ0RuQ0pFcUV1?=
 =?utf-8?B?d200cUlRcjB3NDNOL3ZGYkNLSDRMdFpxeTg5UVc4YjIrUFg4RGdjcEt6N3Fr?=
 =?utf-8?B?VUZoVlBYTHBkWDBwdERIaUZ6TkhCMGhZakhKMFBqZ2tHYkR0bGVQNTVMeGIx?=
 =?utf-8?B?enRpVlpIb1dReStJS0d4eEtkN0dDQkZFdzltOGp0VlVoRTY5aG5SaVgzamo3?=
 =?utf-8?B?MUVIZGs5aHdLb29sRENlc3ZtTExDcXM3eERtOEpENFBMeEIwSWFNQ2o2VkFN?=
 =?utf-8?B?ZVdUVVNxRUd3QVhDdmRSdDJySEloY0pSSkR3NXh2c2NKRmM4OXl2ZURWUDlQ?=
 =?utf-8?B?YU94QmE4U09hWEZWRC9MRWJXbHdXaWErUFlzUDUvejgrTnlQTjJ6eDNzV1B2?=
 =?utf-8?B?WFgwREhqQWtnTnE5dkJlZmVlVmxkdHdKeGNNUHJOWkNGN2Nva0lTMkUrc3kz?=
 =?utf-8?B?UTVBUzZaVUk3bmFLdGFqUzF4SDJzbnZsUGRudUh6VnVuR0Ruci9ZVjhzakVQ?=
 =?utf-8?B?S1hlZnVCWXJNN2hqUWFDVlZKSnRoV0lEeTYvbEorakFIR3IrMUZ0aFgwV0FV?=
 =?utf-8?B?NnB2cU9tanhNVW1CRi8yMC9zejY1NmhtamFDRlB0dEUzRnVXZ0hORlRuUlpq?=
 =?utf-8?B?S0UyUWs1a1B5V01xSkxlR2ZKOHRZMndyUWROTlV2TEE2L25JWjRnMHNxR09F?=
 =?utf-8?B?YUxMakJkOVdrV2tMcWhVMXJUK0ZnWHU2YVlxNVlMRUlDWHg4SVFkVVRMT0JC?=
 =?utf-8?B?dGdnb1VRMDhJdml6R1VkOUFsN0o0VzdKc1NnNnhIdnJkaytsN3BqVUZXanZn?=
 =?utf-8?B?TWxVUE93Zi96bTJVUjVYZzBEbkMxTmtZUFFVQ1lna3kxWi9SNjdrem1vTCs0?=
 =?utf-8?B?K084dXE0MUdHNlBkS1dta0Z1VWN5N3MwYnlFSzJRZEFESkdpS3NiSmtQWFRz?=
 =?utf-8?B?dVZzRDZpZHl4VERKaWliWGpQeW1ObnhlNDBCWUZtaGZpelhpYlp1UlNxbWpV?=
 =?utf-8?B?YXZVcHNUVllVbXRUSnhOUGlSd1g0azBHZzliVXNSekloa1FoMnVORlJXdTRQ?=
 =?utf-8?B?RmxRN2xucFVWcjBtOVFLeUFTVG1wWWg0V2FWTm82cEVkYWxwd1VnbldqSDQ1?=
 =?utf-8?B?T0xqa1NuK05iZXBFVG5tRFJnajFlYXNzWFRrTDBJamJKRnphOUxEMkNYV3JC?=
 =?utf-8?B?TEtUZE1CSUNKbzl1VDdWUzFwR0pPQ3hUbEJkbSswdW5yNWZ5MlBFMGVuSGIx?=
 =?utf-8?B?SEFyeHU1dDZURDBhRnFoeVkrdDZURnJEai9lajhSTGNYZnYzMDJOQ1hHQzRr?=
 =?utf-8?B?SzJvQkZ6YmRhMERudXZvNG0vcUpWMnZwdVpLMFNQS3VsZHlNRnZQOUVWdm1V?=
 =?utf-8?B?eDIxOVVLekZtNEtaRFMyQVI0RkdlR1BSNm4rSk02cG42dUFjWGZES05iQzRI?=
 =?utf-8?B?ZEpDNDdES2R6T2RFdCtLdm9PNEQ5aGMvcld2VVFiS3hXMjBCbVl6UElDTHY1?=
 =?utf-8?B?SWtWTXY1dEVhV0RLVzd2T3NjK1RrMkdObnRST0dYdkVvTGFQckRNekxqTEl6?=
 =?utf-8?B?M3BsS01HTThvSGdFdmVsSFo4SHdWNGZ3dll6RExMZVM5TWJKTE5MRkRWdXV6?=
 =?utf-8?B?WUgzMzhUNjA4YUEwSVhlNWVEazUzV3F3aVhXRVFNTnZ5TGdwQUN5M1F0TGJm?=
 =?utf-8?B?NHdienc2Q0JsZWhYbHhFS2Q1eHpOTHZWemZiQ3ZSQzNLQ0UxbXRWT2hHcUc0?=
 =?utf-8?B?YmFhM2Y1YnhOYjN4VTBEZ0MxdjlqQ1FRQVNSZkFjZ0tyKzJFc3lYeEsxeVJt?=
 =?utf-8?B?azFET2l2RCs5Z0RiVlRDZmRvVFZGdmpyZSt2SVBJUTY0SDBPQ2YyZjVPajNk?=
 =?utf-8?B?cld4NmdLNERYWmlIY0F0M3ZYdXYyY1B4ZzduVzgxVkUveEpJbnlqYUhkd0hX?=
 =?utf-8?B?cnJhVkh6YlozTlBKMU80d0FpU2xXYmlVbDFXSHNva1lkQ3JOa3BVQ2VTNEI4?=
 =?utf-8?B?SHJ2ZXMwbXJpSjlSWnJUbTdYRUtzVTkxRVMvNE1PVm9OYXB2bmJhakZJVFNG?=
 =?utf-8?B?S29TMEN2bzByTWxScjlVNEVrZGN0WWc3N0s3bWUyVjZXUkhXQUdzQWhtOCth?=
 =?utf-8?B?dzZoOHhIZkJvSHdDZFVLVUhDSHlOV0hzc1g3SGR5Mk5vMWszeXMva1hsZnV0?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WWQ3dDBVeGtCckpxRjNXOW0vVUlrUEd2dWU5Zkk3Q1ViOHAwY2ZhMFNSZzRP?=
 =?utf-8?B?d2puZi9VcytKQ01QK0FkL0o4bHlIeVNtU3cxOHFkZWphc2xXSjdOdHYyWmdh?=
 =?utf-8?B?RmVURjBZdWRCTW00ZUJTUkpidTd2QUM2V0hvMHEvL1E0SDJZc1lsSU9YZEFH?=
 =?utf-8?B?NXpVZDBvOW8vTW9EQ0N2K0t2R2VKejd1dmNFdFA5bkRyWE81RXZpNXFyTlMw?=
 =?utf-8?B?azE5dzNzZHBkenZWcGUvaWg0UHByb0hoRlFISGxUZ3liMEFEeGIzMFdFNE9P?=
 =?utf-8?B?bDJCeWNnbmh2VUVPMjk5em5yMDhvMmpYNXIyWmdaek5DcGR2eDhnRXNhQkVr?=
 =?utf-8?B?dVlKUmpZTlJSeGE4RDhoNThFMjlYdHBuL1dNbEpSYzNGbTJlZmI3cUw3T3oy?=
 =?utf-8?B?TURrbmhTZmtBWUs2MWQ3cXEzbXhLOTdreDk3dzhYMGtXVnl6aXlTRHB4QVhI?=
 =?utf-8?B?Wnh3bkVRNW4rT05KTmdHK0JXbkdMM3B3eGk2YTQwSko5U2lpdm1QbHQ1OXR4?=
 =?utf-8?B?b0NsT3RacHVHcllybDB3MDUzOVFMUWdaVE40Wjd5OUxNMUlCblVNa2JreWJ5?=
 =?utf-8?B?YW9VVHlIbGFQeXhkSUY0QWxoKzJ2bGFmck0vbTJ4M2pGME9aTTFFRHY5R2hT?=
 =?utf-8?B?eWFsRDJ2VVpjbUNGMkZFMnBha3BramJ1VXVEN1g4Mm5tVjNISm5lTkFDNjFV?=
 =?utf-8?B?akQyZlI5Y1FQSjhGOHlQUGc3c01GU0ozNVFGeWtqK2FoWTRlUE5kSldVWENB?=
 =?utf-8?B?VmU4aFFoZDZqUmVRdStxL09POHhHOElDMFdqaVdDME9nUEVoTld6UWhrNjJN?=
 =?utf-8?B?cDJ0TlNSWjhrOW1KYjl2dlVvcUNWVDFQdFhjeVBENVk1Mm9ZVGdSNTRhOFB4?=
 =?utf-8?B?bWd5TDdEK3FuRjlldGY3dmdHUUs1OGNzNFlpQ2NEc1R5WkdqVjMwYUNGd0ZY?=
 =?utf-8?B?YzQ5a3Z1ei9oQlZPRFd2eER3bmFDaWlYTm5KaWlzNnlFNWcrc1d5WFM4RTZD?=
 =?utf-8?B?QTBlWlhhK01LMHg0clRESlNNaCtacTEzTG1ZRE9aM3Z3YXJlajAwWENxMEhO?=
 =?utf-8?B?OGtRV0I5cFhveDZHN1lVSkFVN3czaGVRTUp0WnVqZXB3OElKZlVmR1BEOUMv?=
 =?utf-8?B?clJQd1VFUlpYN1RXZGovQjUwamJyVTdNQlpzUXNEMWhGb1lCUVlPSFFrZUZD?=
 =?utf-8?B?UDQ1THo0NU1SSk0wcVBkb2NvV2xOd01yeFdzWHJZRHpqdUtUT0M4b1FqK3dj?=
 =?utf-8?B?TzkxRnFNMSt2cHZFd0JRc2RKQ29pTkdlSVJWNXlHMVp3eWxna0RJRkV5ai9i?=
 =?utf-8?B?Yk9pOUJWbVRYMm13Szh4dWc1Yi9POGYvSjlrV09wUEpyeFNzNkRLUFNoSHZJ?=
 =?utf-8?B?dG8rT3ZCdXEzb1pFdXRGdk5mNEY5eWg2akRiQ1I2UEFyS3ZMaStxZkpUV1Nn?=
 =?utf-8?B?ODQ2K3RncDRkS1krR2l4OFBwV014UFNlRE5GWlEzTDNyY3NRSWYwU213d3Jx?=
 =?utf-8?Q?NeW5lo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee0f6ca-3947-430c-f64c-08db4c8f1b6b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 11:02:52.8864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzOsRL7QIcHg+pqaZGfUpdaXTuR73AmxEgoZaxpuXLdRNHt+bo/B5RpOba8703BRHa+VrI5K7OaJbxKgpLUicA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_07,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040090
X-Proofpoint-GUID: 2dQa8tYIXJutLPChMAUgPsfdwiSuBqHI
X-Proofpoint-ORIG-GUID: 2dQa8tYIXJutLPChMAUgPsfdwiSuBqHI
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 10:47, Robin Murphy wrote:
>> nit: generally if (!val) is preferred

Hi Robin,

> 
> Although either way it can only be NULL in cases of memory corruption or 
> developers making broken changes to the driver, neither of which are 
> worth pretending to defend against.

If there was some broken code for setting this identifier, then we would 
just not show the identifier file, rather than show it containing "NULL" 
- that seems better. However, there may be other implications from that 
same broken code, so you maintainers and contributors please decide.

> 
>>> +    return attr->mode;
>>> +};
>>> +
>>> +static struct device_attribute arm_cmn_identifier_attr =
>>> +__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
>>> +
>>> +static struct attribute *arm_cmn_identifier_attrs[] = {
>>> +    &arm_cmn_identifier_attr.attr,
>>> +    NULL
>>> +};
>>> +
>>> +static struct attribute_group arm_cmn_identifier_attr_group = {
>>> +    .attrs = arm_cmn_identifier_attrs,
>>> +    .is_visible = arm_cmn_identifier_attr_visible
>>> +};
>>> +
>>>   static const struct attribute_group *arm_cmn_attr_groups[] = {
>>>       &arm_cmn_event_attrs_group,
>>>       &arm_cmn_format_attrs_group,
>>>       &arm_cmn_cpumask_attr_group,
>>> +    &arm_cmn_identifier_attr_group,
>>>       NULL
>>>   };
>>> @@ -2241,6 +2273,22 @@ static int arm_cmn600_of_probe(struct 
>>> device_node *np)
>>>       return of_property_read_u32(np, "arm,root-node", &rootnode) ?: 
>>> rootnode;
>>>   }
>>> +const char *arm_cmn_identifier(unsigned long model)
>>> +{
>>> +    switch (model) {
>>> +    case CMN600:
>>> +        return "cmn600";
>>> +    case CMN650:
>>> +        return "cmn650";
>>> +    case CMN700:
>>> +        return "cmn700";
>>> +    case CI700:
>>> +        return "ci700";
>>> +    default:
>>> +        return NULL;
>>> +    }
>>
>> nit: I think that it would be nicer to have this per-model string 
>> stored statically in arm_cmn_acpi_match[].driver_data and 
>> arm_cmn_of_match[].data, so we have a straight lookup
> 
> Again, I'm not really convinced how useful this coarse per-model scheme 
> is - for instance, in terms of many events, CMN-600 r3 is closer to 
> CMN-650 than it is to CMN-600 r1, so what exactly would "CMN-600" mean 
> to the user?

ok, I see, that's what I was asking about in the cmn-700 JSON review; 
and from what you say, it is not the case that we always have the same 
events for every revision. So we need a more fine-grained identifier.

For DT support, I suppose per-revision compat strings could be added, 
but I would not be sure what to do about ACPI.

BTW, My comment was more about coding style of case a, case b, case c, 
... case z, does not scale well.

Thanks,
John
