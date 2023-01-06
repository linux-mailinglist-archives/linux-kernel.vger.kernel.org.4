Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1DA65FE96
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjAFKPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjAFKPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:15:03 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6217068C8D;
        Fri,  6 Jan 2023 02:15:02 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3068PrPd015946;
        Fri, 6 Jan 2023 10:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=iRUpAKfDd6ruefZSFrPATDSWwjGi0E2wxyatIcxs+wo=;
 b=d5U1vPHiOa2SU9kBcQCABUEcJdI5Z85I+xAHWmfM5muLh3qscZJclMN4nRYRTsqs8ymL
 RqSuofpwrEMyVacYqEqMac43x82bvAiz4j34a4dvSUmdh1M5S2BgfW1HyBeW5dhDO/jv
 hdFQ7e3uBCyN3vxVKnqJzyxwg40taVZpM4rvmiYKVfHuD+K2EjtA3FZqi2DX8FjxCZZM
 yjjApdDirjtUrd0YwrGVBn/gIMNLEqRU+vS1ZVHlwqbU6HHltbOo8Pr90xweidGSPvOX
 xH2xJ2vfnRkffr08GuX1M2Gq/2TUXz3dnDXj0MAE7iaQLICccAkVMHohCCz8kVD2SJoO ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp12vsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 10:14:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3067o49g005022;
        Fri, 6 Jan 2023 10:14:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdf1kfr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 10:14:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lm9hKFPgeZrANQKnFQllu0tfN7vGCWBjKsSLBBy7gdvZvYKo9p50xLHJxAGW3hOVD4Dk/JAKTFux68IIdOy/SlS0IidaROTWR3v3TR6o/+pl2NdUQmfn8JI1zzpqLC5r20aahIc8AlSMeUWlfJVbd0WUcgYz+mGk39wMv+wjWUebH4oH98Rch99aF2aXtjB0U4BKV1T05HSXnCuznKsiOT+iStuTK0tRZj1mQfvYZqdsMVeRuoUmIclQvDfW8zcbMMSxe+CSL+EEk/CDTGfhJ/LbSHDpZt0GjrtKgD8jLdQQrwNXRbDsQ1iEBlu86cMJQdf72Rk/gIpQ/NnPD99kOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRUpAKfDd6ruefZSFrPATDSWwjGi0E2wxyatIcxs+wo=;
 b=g8twrQOCZtLnPpBadvjeCvTcwjPilttQI5awycqqEX/JLAHtKypIXXHOxnUBtnGvuBlU2DyUb/0FSfBcHUZTTthajY7tiEmLpP5X5GuvyHJ3wvTbGgBE8NmcEQpMIF1GWvxzPX4/akwiZ+NlFu1mj5PaPU+RPlAXU7kbbVX52fyoEvsMqMvOSOblQDVf/rF2Qf2hiXFu5bQ2PWvj7xF4/CAvKIcUOdRaC/Rgt6y/XO9ZG13C4ociABYCN7LrSSZrGY5CokopotNDIjQCvIQiVjO7uPrptvwLf2Z/95IYvb4ZqkPy6fzpX1q4yU7iLFsXxdtZIQqcICrAzxF5BZhuLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRUpAKfDd6ruefZSFrPATDSWwjGi0E2wxyatIcxs+wo=;
 b=a77W94+AKk/mwUf6skQwN82LIYUzFTotgPryMInPkSA83qTW3aUDEHUhGgBvkwfCtxya8V+axIyjajuAAyZDSeQLZ6uqiuiJ55QTgoetrf3nD7zmDVyy3Mlg80OLemjJ/1C+SfSU1Z/Zfa0ENFdos3OmTAe3gjKLF9pa5OKAh3E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6130.namprd10.prod.outlook.com (2603:10b6:510:1f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 10:14:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 10:14:34 +0000
Message-ID: <6971b848-2754-6909-d36b-ea80fe157e95@oracle.com>
Date:   Fri, 6 Jan 2023 10:14:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/6] perf vendor events arm64: Add topdown L1 metrics
 for neoverse-n2
To:     Ian Rogers <irogers@google.com>
Cc:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
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
 <7aa225df-af25-a6be-9bef-c965488ba43a@oracle.com>
 <d4d132d9-1513-6a4e-981f-aa4bc4ebbcbb@linux.alibaba.com>
 <00bf227a-75ce-c63c-c740-89b8d2b27e1c@oracle.com>
 <CAP-5=fVGmjFOZqOk0E1bcqeTHcJhEmoA-vrKcHLOs4B_ythT1g@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fVGmjFOZqOk0E1bcqeTHcJhEmoA-vrKcHLOs4B_ythT1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0661.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 644782fa-98cb-43cd-791b-08daefcecee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIVnOIIwmcVdUaaWftLFPAEFldTL0dKRyPEISr3fT5Ek81Uvv73IwfHES6leBEXCZhIY8uzwU9RuCBizlE1xQRzSSlRVoXmTZik2WCPvI6peDGEOKm0l5PvDVdLWP7Xh1l+0Bk0Yjdeoq4g6VyU6yKjdFYwwN8VRuTV0g8wQ28a4F5+ImGV4m+dD4a6iJGEUiFHNeLy10LESWasoUJHiMCmG/xKDGDtw2kAwKU8WOPsq70jdfKM+UtnNt7T/UZpJyzpgcv2x0keI3/mtOIRKY4UhZocSI4Uf30ZM17r83PjlQz8pZJkKQPv+mCruhmFAXxmgUCD6iL5mu34IIkYiSqL1qRlsrLj5hjzUK8zRtzeJLAA3mAOfvwrXADH881dhKfdt8sRbjsgSyFIh7H12EIjkKEWuKZd79F9KQnMucVOm3unalJW+EBdnTW9y/GY/PDkt8ALTqOKbY9uJotFP+dEgxYL+DDI8u+K/w3NMCBVV6R4LIVmvFmyJ4i4oVw/Vw+EzOpE2BhAtgEmu76xcJEkyyv/VFvKT/0vXE2NYN7IN6Ukwlx1Bvi+TlzNoL6+nKV0R05tcKn0j0Z/6ugeHymTB064tJQOAgGcpXWgzsNBTNy3YxEzVfjCVnZhdWqtXK+i7J4RoEaOeTogUmvyLCbTnvyNAI8IKCd6q0eomagxu+ImMobachwdmZbD1QvZGom0Gm0NLrLzduW9o6lZWLBWQ1HaPmR+1AHXocsIua50Nz1xLmxwnClEz13XXX3TI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(2906002)(5660300002)(7416002)(31686004)(41300700001)(66946007)(8936002)(316002)(4326008)(66476007)(8676002)(66556008)(38100700002)(6916009)(54906003)(53546011)(6512007)(36916002)(36756003)(186003)(6666004)(26005)(6506007)(31696002)(83380400001)(966005)(2616005)(86362001)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTR6N3RMS3FkZzlGU2J4MGxhZ2NaUjNwMUFuSjhpNnU4S3BETXVpbGY2WFdS?=
 =?utf-8?B?WHJMUVlaZDFOeElmd0pGcnNETWFjRXU0aXQrV29xQUZ2WDI3RUFKQlZ3N0V1?=
 =?utf-8?B?S2dVM3J5TEVxY1dBTVVPbEw2RDk0TUtsUHRnWW8wMzVkVE9nZGVYRkJpTVRO?=
 =?utf-8?B?d2JmdnU4cVBPNGtmS0lXL2dmaG8zN3p2aTBkYkdrSEZhSmZnalZJdWlESHNp?=
 =?utf-8?B?U2FpTTk1VVZoeDRHS0g3L0xQeStMOGk0QjV0dVljc2JRSmtEOGx5ck82UzBo?=
 =?utf-8?B?VTRlUmxBQVpjVDRJNU5SSncwM1UvWXRIa3hnSDAyaDlWbXpnTGgwN3U4R0wr?=
 =?utf-8?B?Y3hiWGRlTS9UQSt3dEdTN0xhU3gwbGdnUXZjeSsvckpEaDBMTVZHbGptNzQy?=
 =?utf-8?B?ODljMFJvQjhCQ1FRQU42alNoWXgyb0tVNHg3RytoZU50Q2RNNS9SNVhkbjlO?=
 =?utf-8?B?cjZac2hzY1Zqb0JJWjkwZngvZFRmRTh0NFNKQ0NXQ25sRWhZOHBBNmVNVW4v?=
 =?utf-8?B?Yk05SXdZTkoyRUtEbUZmTnhGaWJaUVFIeVM1WHFZSXd3MzFlcmJpTG9ZRnBP?=
 =?utf-8?B?dkIvaWxJMkF3MlpPRlBkMlQ3SlMrYUt3cnMzUS9mTkM5aHBsSUpaaFY4MmJr?=
 =?utf-8?B?Yk92RGN1M2laMUowT1ZkNlcvZjBUeXpXdnRLRG1qdHJTcm1FT3hhWXlwWEQx?=
 =?utf-8?B?b29zb1A0VXFOSmlJdndOWTV5dFZRQ1BxdEdhY20yY3RnUGEwRzZlVkNneGN4?=
 =?utf-8?B?K2UvcG1wdVlWZ1R6b0MxZjhSa1FXNXhDR003VysrcXVYczFaNVI3NGVNN2xV?=
 =?utf-8?B?QkdoTXFscHRXWklDeDdGeHNabGMycktVYUtDZlowYXJwNlBobS93ZG9GLytW?=
 =?utf-8?B?QUdXTk1XVllJWmhTVDNLeTQ0WWMvZWhTb1UwRFZ4Qk1LK3VkdkxwT05wNE9V?=
 =?utf-8?B?S1Q1U1pXazRsNXhCdzQ1QWhoOG12eVdBazR4ZVREVHFqWm9vTVpmOVdESjZL?=
 =?utf-8?B?cmp2MkVQYW5tWEtUTTFYbHlrVzdPaytoY0c5MEpBSE43VDhKb1NQbW5seUZh?=
 =?utf-8?B?OUxON25LVzdxYktIcks1TExyczdYWkVmV21IVmVCd3ZQL1pneGJYSHVqd1pP?=
 =?utf-8?B?aWUxL21xRUlHYlJtVzFweDZhL0tPSmc2c0grWHozTkQ4TVNQaUhDK3ZobFB6?=
 =?utf-8?B?S0xTWEx0QUxjbFM0RUV0QkVYdXBmSHV3clB1aWxOMkJZbzdMUVJaNzJkYnNr?=
 =?utf-8?B?MUNrOVNYZkJBR0JrOEkzSUJhZW1hY1MrZHozY3dNaGVTaTEvWC9BUEs4RFl1?=
 =?utf-8?B?Yll5S2FUVTZiNjBUUFE2VXhOYmNqM2NlSVJOdnJBZHZEbHc0QjZIcVVJcG82?=
 =?utf-8?B?S0tJRXRpTzFQbVdzVDBBY1ExTkRVYWhWSUgrN1ZaSlQvQlZ1UlhaRkVxQkJy?=
 =?utf-8?B?dEZIZTh4bWdpdVZ4OS9zejBodXlpR0VHUzRrV0xJdnJHVlFkVHE5SEV0U0N0?=
 =?utf-8?B?SjY5Sm5YOE1OK1ZXelZIRDYrYUhrU3AxdUlvRnZUNThMbmUyMXJCc3JPdmNI?=
 =?utf-8?B?clJ4MTRsTy9zNDRxa1F1cEptbDgzcFl3d2d6MWMwOTJubWg0Q1ZueldLZEZh?=
 =?utf-8?B?OUlrb1hJS3ZRR3NFUVkzbDhkVFo4aUh5UFdvb1Q2VDJUakJpUTFZeHhldGdP?=
 =?utf-8?B?ZUc4bDlaWFpzeGtsRzRkdWlsR2pRc3J1cFdtY1REUVlVRmJuRFIydnhQc0dj?=
 =?utf-8?B?L0w5VmtVZEc2S2s5NTJ0SFNNVEMwMkRxUGo3aXlDYis5TG8zSHRtTzdNdlY1?=
 =?utf-8?B?ekNXY2VTZDloQlJSN2lYcXBsMnI3eVRZOUpkTmxoeUh5Y0k4c3F5V2FUK2cr?=
 =?utf-8?B?WDNHbnhPNTVPakV1czFRZExndUlrRlBvRGl1cEJ3bVJLQ3U4a3c4bmhzQ0tL?=
 =?utf-8?B?TVFMbWU1WXZaUHN5ZkJlN2pYcXFxOTlyVW4yQWhkOUw3NGJGQkY5SVp0U2d4?=
 =?utf-8?B?cUdkbkNKN09aNitRQmhiWkszQTdEWlNTMERtVU4vWEs0cTdpOTliKzAzSFN6?=
 =?utf-8?B?QndNQzVCUEgzR1dHaFgyOXdhbEZNR0JDMWxhMjA3Q0JqUU9DaSs0RjlNcmF1?=
 =?utf-8?B?WVRKVDd5blF4UjVxZmFhcE5SQkZ1VTV3ckxZM0t2dHRKRW5nKy9qamh4MERs?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UWhUNkVhWUlOckF3QWtBNGQyYTh5MmEyYjVqOHVpZkFIQkEwNjBXSjl4TVYw?=
 =?utf-8?B?cGVzVG5DU3pHbVJRTU1LVWFnL1BVVzRrYkxHK1h3RHVUcml1bndjMWVOWERx?=
 =?utf-8?B?b3JQNXRhZ0FkdzZTbThLOGl4NFRoOFNScGtpTk1zMEVCT2pUVkw2dS9lVkFp?=
 =?utf-8?B?eE9oTTVrNjdBY21UZlNDd3hTUGhLV2dPVHpGOGR3bWU3ZnJQa2xUSUMyY2RV?=
 =?utf-8?B?bXlQZysvQUc4QkZsVUFKVU84cmdyeStpeEFhc1hNeXpDckdyRWU3cW51U0JK?=
 =?utf-8?B?MGZsdG56eDB5dGdhQ0FJR280ODJtb3hBQ0hzV2plVGluc3NzSXlDcENvUCtL?=
 =?utf-8?B?WUZFS2t2QVFkMWY0dCtWZTRkdGJBaFp0czJWK0pEN1hMTUpxZmZIWldPZUU3?=
 =?utf-8?B?Rm5CVUNWaUdyaFBmYVFvUzAzY1FtWVNvN2UrQ3JGNEVkdS9ZRWtwWHRYL3d3?=
 =?utf-8?B?cndVcVpFb3FvNkhZTVlEZHJBK3k4WlpPRWZkcG9PS0RpNXRvT1JqcC9oUVNI?=
 =?utf-8?B?NXRPK3V6QysrR2pQamx4VDFFUzdkMThQa2k3UnA1TSs1TnpwUmRqeUVvSjky?=
 =?utf-8?B?Y0RUcEluN1pkZ3o1c1kvSFo2NnVOSlNKWExHKzZldHlqQklURTVxM2dHS1Q2?=
 =?utf-8?B?WHJGdmdHVzd1VHFzWE1nTFE1c2JvcW4zQ3c4YnpWdnRPb2VDaFBsK21rczBJ?=
 =?utf-8?B?ZzBmNzQzUDRnT0lzUDdBQ0FGUTltbDUvY3JldS9pdzNleWxyV1NOQWwrZ1lr?=
 =?utf-8?B?UG1GYlVGMkVWSitFdnF0WE5nYzVJL1pCSjEySkZxMXJQY09pY2l5OU9wV3V1?=
 =?utf-8?B?QlVxVDVIQmxDd1Qxekt0MFZRN2VMbVh4TWVBT2t3eWFaMmJMdWhoUVJnL3kr?=
 =?utf-8?B?ekhsVXN2MTlGdDVEVUJNZUdMekRuQ0x2OU5rMXVBRHNIZG1BVSt1VWZaYWVX?=
 =?utf-8?B?YUlSLy93b05RTHNXZkFMc2RHWnZ4cWJocCtmMDlDd0FRS0JRYVdpdWdtQUQz?=
 =?utf-8?B?N1ZsNUU5WnVUTEZTOVlKejBGYTBPU2l2Zmt2VHhTdGhjTGNyRkhkaFZxZUIr?=
 =?utf-8?B?U1dDQlluNVZsazlTc3JLTkZhZldNczVOb1M1eGEzMDRvaEhSL0Q4THZKdEJr?=
 =?utf-8?B?MFNzdGdNNzVTQkhmb3JpeForZ0EzYm9XWXppVG9BckdRclc0bGlsTDdMVm1t?=
 =?utf-8?B?cnE3WEdpNFYyWCtNR2dNZk9xd2VHZ091V25lRDlhNTg5R2hXWUpPYVFReGVk?=
 =?utf-8?B?UnBiMTdSWnc1Z1M0aVRjQmdCMG9JbC9iU1BvVWJBbk9tVEVKOWxtcUVrVFJu?=
 =?utf-8?B?M2NvV1YxeEw0K0w0d1ArZnp5V05hU2wrd1d1dGVjOVhMY0VsS3V4a2h3aktR?=
 =?utf-8?B?RWNrR0hXckJFOFVXUXFnT1p3MEt1TTJrdEVHcGRLK1loT1owVUcvM0hwVUgv?=
 =?utf-8?B?Zlg4VVJvZms3ZXljdEJPWFdGYndVQzdhSEJNSDVUL3pwb1Z1bW92R2FUSE5z?=
 =?utf-8?B?MVFEMjVacis4NmlQZG0wRThxNlRXRFRYdW5Rb1NSVEk1dllPbFY1NXh5aEZO?=
 =?utf-8?B?T3lONkVMc2tUaDhzUVVOZk5La2ZlNVhnTlFYTi9VM2RuMHk0VTM2NzRhTElx?=
 =?utf-8?B?SzJMTlZXUkN0Z3NUQThreTdtYUpVbkNPaS83andJazBRTi9Pcy82MmNlMlJp?=
 =?utf-8?B?MURCemJ3N05vT05iejhRZ1QrK1oyeGpyamNjTExYcldDVzg0dyt2ZVlLZ2pD?=
 =?utf-8?B?akM3eGZEZUlhWS9Mc01jdFQrQnNHbFhUZFJCUGpzNzNNWXIwVWhtV0liZlZk?=
 =?utf-8?B?VHhBOVpwS3Z1My9xWWUwZEFZeUJMUzdvemNBMnVrU00wWHpuaWVsSjA4TXNZ?=
 =?utf-8?B?enpwcE51cHFmNzhrdmMwcmR4bTRCbDY5YjJXN2RjSFdwaDZuQ2lLYlFEMXpj?=
 =?utf-8?Q?0w0LbOGMcko=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644782fa-98cb-43cd-791b-08daefcecee9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 10:14:34.2086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I97R8rcmNWfl4n04mVprS+1wyrJzcb8/8tYdMNMrYp9KyxTEuU2e2fabEKk3QYEAKuNyCtgqAgp8+jpGsoAREQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_05,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301060081
X-Proofpoint-GUID: zQz9AM0kQz-IIzjo5ILXyWkXxf-QsqhU
X-Proofpoint-ORIG-GUID: zQz9AM0kQz-IIzjo5ILXyWkXxf-QsqhU
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 21:13, Ian Rogers wrote:
>>> This may be a feasible idea. The value of slots comes from the register PMMIR_EL1, which I can read in
>>> /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots. But how do I replace the slots in MetricExpr with the
>>> read slots values? Currently I understand that parameters in metricExpr only support events and constants.
>>>
>> Maybe during runtime we could create a pseudo metric/event for SLOT.
> For Intel we do this by just having a different constant for each
> architecture. It is fairly easy to add a new "literal", so you could
> add a #slots in expr__get_literal:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/expr.c?h=perf*core*n407__;LyM!!ACWV5N9M2RV99hQ!IHcZFuFaLdQDQvVOnHVlbbME2S4aW8GohWUkydlejpi7ifFz61r7RutGXReRt0d88X_vDfkTySCiuD2PqOA$  
> Populating it would be the challenge 😄

Thanks for the pointer. I think that the challenge in populating it 
really comes down to whether we would really want to make this generic.

I suppose that for arm64 we could have a method which accesses this 
PMMIR_EL1 register, while for other archs we could have a weak function 
which just returns NAN. If other archs want to use this key expr, they 
can add their own method.

Out of curiosity, do you know if x86 has such a capability to get this 
slot info from HW?

Thanks,
John

