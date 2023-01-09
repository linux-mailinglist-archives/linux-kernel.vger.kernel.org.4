Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819A4662931
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbjAIO7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbjAIO7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:59:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8AF186DD;
        Mon,  9 Jan 2023 06:59:38 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309EpwHY019315;
        Mon, 9 Jan 2023 14:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4a4fF2dmxQv4F1cNE8nX3R5TrAwdOhmaCsVW+0xp5I4=;
 b=CQVphm4yfAd3hdhd6H5mw5jmT6pNfh77U2gRs8SngS7eNsbX4py/9t7ZhiYFlNLAwaq/
 ZbAClRCGLedKND0iaPZ98w8MRn68oIWl9uFNyTdKq3DvI9lx8aRywuEj1aT5bMpUhRbc
 LVQWT0Hf2SGQVztM7bbPh0gz01u/0LPQmxupQolUCTtfqbh01lB0HPfiOECxll0Q4COP
 y4DiW3IQIdRc5c9xAS5/GprHEPCbSLD/tzJM/MRKvBUqcZNDow2Nnlm+u4V0i8IdGFMC
 jt4C7f8OwIP7dTdibZI29WanF6WE847pquJsrKbbfhoBT5yXgDPqEErFTX7ZEQs21lua 0A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n05w0h9ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 14:58:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309Dj6ku035330;
        Mon, 9 Jan 2023 14:58:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n0h8u8f2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 14:58:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGuEAQlV17NrdS0+HsBCNnhQGZLMc8jmDbZXsMEVoJxyNqTGFICzKVbK1zmpL74lAk295sJBeKaxtr2kjyXZnMxD5H0g6hTsxqPGG9IviLlpn1DcNzv3Wr4bdJCHW1UYp5RNZ23EjrsZYTT0FIvqsqIL0b913SGwC9mCcJoWNpdM0tEj23b3AFILGLxJatRQ5s0KPKfB9IVoH8oEcizZvEh2ihUOfJayT/2yLiRn1L6uGPpvMQbbSRto9JGCwCzTAm9p2MeABO3+wc53/6vdvf3K/GTLlCOLLacXH196oz8NoUwKnJAoucjokDzsXocnNabbw2WPAv4YahjNn3V0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a4fF2dmxQv4F1cNE8nX3R5TrAwdOhmaCsVW+0xp5I4=;
 b=YrpSBM4NbMQHVKXNVENexd5m8BHO++alwOj3TpBMTBqtcfgEpa04VVC4+9PF/fit3jrgD9Gnmo3xr2NoPqf/Kwbl6/heI2C33Btq+Z92nDNapoh57V1wCiOuWCiPjySo2cUJSPixQNmixVlq3efiRhz7jkn3D8IY5E80BwtBsDV3bdje25gFPyBQysOMtWQt1t1j35NIwuRmNmD99GONCXIaGxWN3o7Z+yVnLexElVX4PsUxTAgR48YWwCXAurkkoESUsOC8IVDWmR6F2uPb73oc3lPUuZjWaFdRqujzL/LwNpDzdCcGOsQNQLNMhmYpIu89FpGmfFVCAIi67OTuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a4fF2dmxQv4F1cNE8nX3R5TrAwdOhmaCsVW+0xp5I4=;
 b=Rljw5dZsLV8MY4fjXVV+Cqnrl1CmdYiRMHUR/DX1HB3Gnzzp92Tnp9EBr6byZLM5YqgLB1x8+cINLg3eiOhMOMh1ttBYLa7knIWUix+nRxYbLHT2G6WYX+8ONFZ0S+cC9FTpIPVJhJdAZHlf6acfsy3kCxNm58hSr3FlBFpbj2g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN4PR10MB5544.namprd10.prod.outlook.com (2603:10b6:806:1eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Mon, 9 Jan
 2023 14:58:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%7]) with mapi id 15.20.5944.019; Mon, 9 Jan 2023
 14:58:40 +0000
Message-ID: <758b66bb-6f9e-8a9a-8b0f-10cd79a65613@oracle.com>
Date:   Mon, 9 Jan 2023 14:58:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 1/7] perf vendor events arm64: Add common topdown L1
 metrics
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
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
References: <1673017529-1429208-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1673017529-1429208-2-git-send-email-renyu.zj@linux.alibaba.com>
 <7f60c97a-18df-4f93-0e95-2a9a6dccbda7@oracle.com>
 <c2e5f9d7-c6d8-c70a-8eff-a8e1c5fcf0af@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c2e5f9d7-c6d8-c70a-8eff-a8e1c5fcf0af@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN4PR10MB5544:EE_
X-MS-Office365-Filtering-Correlation-Id: 59bd12aa-4e9e-427f-bf2b-08daf251fe3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MGSD7BqQPpJh7yFFl3CfE2fC1WCqGWLj6mzB1sS2e6GqPbfEqjE24Hb/99LkhSffpAzq/XQeGDY0Pet+s1FS39oC9a0DwMqSdxgMyJodaU5dfy6x3897VMLLuwmUx7P8Gqg1cFF1EqxNECFuw3JXaMbUqdliB1abk01Wkcvw50oswpiAXjePrfJDv9pCWYr0hdTo8eKdEUXXRL5B18KmsW+vMQ7hRor1wKtQxXJAoJaREAHTOkcpmI0AtpMVTGSMD1Wr+KskYjk33wqKrrrzuh59EV5ihbxCjcXfSfsuEbVcbT1LeuhqobSBDVsLI3E3vg4TAVMKOuWeP5rGGUJC2kqtXEAEeIaxmwxlKAxgWrZO3i3d3kdo/kzaqCpIId5TvAsbr05zVGtkax0l4CqHrksKHP5WJa9NLlK5He0SVo6Ed933ypZTidu0jmPp/s6e9lJJoNoGtivQTZJuXHWCok5w95OLbf7CrQlsIZ/lrVKYbFs2LLou1HE+9+148oz1CiLKTnlQJ4R7nHC/fHTx1GusCpUNPBXhi5pKa37jJqR6/YyjbfvQHj8w+n5kB/K/L+n+oD1JycXj+iKyayvCsOosTMTGJIpcKCWTrOqgXkchxItEyDWw+4S6SKQkyVTvM+dtzHwxTfLQed29d3ujPZthWwAanYMxtBJuhtynHAzUD8hC/cuvpwbVxhmHw/yD0VL0XGdbqWJnQpt9yWzVVxPj0MiMHpDazIVqE2uPw0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(38100700002)(31696002)(86362001)(8936002)(2906002)(5660300002)(7416002)(8676002)(4326008)(66946007)(66556008)(66476007)(41300700001)(6512007)(6506007)(186003)(26005)(6666004)(53546011)(2616005)(110136005)(54906003)(478600001)(36916002)(316002)(6486002)(66899015)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHZkTjNVN3R0Q1FoOWo0VjZKQjRmb3hPeUhoditTMXk0azBLZUh5TFFmV1Nl?=
 =?utf-8?B?QyszV1haZTAyMHIrODQ2QTJnd3dCTHc4c3NaaVdlOTEva3R2aTZzMlh4dFY1?=
 =?utf-8?B?SkE2T00wdHZFWFhWVjBGRkd0ZG9uYVcxVDFHb3R6QTJGV0F2R3J2ZVgwNGMx?=
 =?utf-8?B?QXNXK0tyblRjMFJsSXpOU0xWTW9EMFArL00rVmJuRndlU1pmZy8wazRDWTNy?=
 =?utf-8?B?YXZiUUkzaUJLK0UvWW4rdmIxK0Y4N09iZ3FOenVzYlIvUWtWaWFmSUtiUUJi?=
 =?utf-8?B?VnpLeXFrb1c3MHJJSEF6akpLZWR3T0J0anlKUkhRb2dtd1gvbHZhbFp4eldx?=
 =?utf-8?B?MkJaZ0p4SWd2c3c5LzZQWlJpaUZwRFo0cTREc0tXOVM4eTFzVTVwV3JjR3JT?=
 =?utf-8?B?VG0vYzNjcEV5eFhkdXp5by96NE1jbzZBMndZZFY1TlFEY3duWTQ3aWVDTU5Y?=
 =?utf-8?B?dnFENTZISVgxcWRtVlV1Y3IxZ2lBNFUyN2YxVHpPN3hNVGk0eVVzZloyV2Jw?=
 =?utf-8?B?cXdyZVBESVpFZnM3Z3JoZzRGUzkyc1FTVDduWWtib0ZTZm05Qkw3eExZdmcy?=
 =?utf-8?B?dmoxa3dMK1ZKR1ovNlhMSkpyNVRlZmhZUVVTNExvdlJCbjVKTlJzMmpTb1M0?=
 =?utf-8?B?ZjUrODduS1B3ZkZMRTRNM2pobWFkbzU3eUFzd0tBU3R6TWtZR1N0c252bzl6?=
 =?utf-8?B?K015eUtqeGlGamlNU3Z5MUFKVVIrU2xIYlk0K3BkWUFZOE9FeE5tYXFlRDkr?=
 =?utf-8?B?RUpqdHNlMmdJaHM4R3VVaXhOQ0JYUzJrT0dqZ1ErbmVFWWY0aHJpNHZTeGlh?=
 =?utf-8?B?bGIzN0xlbitjcmlXak9PUUkxdlQrMk12MU56dHN4S2Q4bXpFblF1a29RQkZY?=
 =?utf-8?B?YWNGSjhPbG9lSVRpVEpuV2xORkdtMXNIc1BmQWdKTGF0U0xDWjlaYjFXT0tv?=
 =?utf-8?B?NG81a1VmaE9iQUs5eEpUUGJ5aTVmY3VjaUVobHg3N01tM1NFZzNWWVVxa1I5?=
 =?utf-8?B?SUZKUllmNFNCYXhQWndsUDZ4NThoS05zN2k1NnZWMWtOVWdmek4yOVpTdU1S?=
 =?utf-8?B?UVR6NUErVnFja0JncDhUczM5M0llNVBGdXcvR0dDN2x5NWtvQzR2VmRJNEpY?=
 =?utf-8?B?NTY4MjlpRElCdVBHa2VySG9oZW14Um1YM3p1N0NpMG40bHB6UEowZGRncEJ6?=
 =?utf-8?B?a1M5aTZoL1FHUkFyVUJEZTZwRVMvZWpVUjllTFdPTkIzUzkzTDVTNVFWNkJm?=
 =?utf-8?B?emEvZVZUbmlmWjBQaEVqQnh0WnNsYzR3azVZaG0yTnI4OVA1cXloam9LNHQ5?=
 =?utf-8?B?VzJ3OG9XMWRZWEVwSGh6eWJaSStYRUM1OW5oQlUxd0h6SDJVYjBJdUVoTmlq?=
 =?utf-8?B?Z1lsdWpDWmFkRTg2UXZlblMrTUxIL3RiUkZBNGgyNGJSWDRyYnpxMmNOODBY?=
 =?utf-8?B?OFQ0dUJ4dWFhWFZvTEdQU3FESXU2ZjRhdi8vcEdTTy9EMjk2Z2dSakhKcFJH?=
 =?utf-8?B?RklTN2lsRDdVc3dmbk1SUlRSL0VKQi9rSElCMVVvaTVqUkZpZWMycFJBUzJo?=
 =?utf-8?B?Qmx2VTN3ZVN6WnpUSWxTWFhjcDgrS2hNZllxZ0ZWb1haaXRiUXUvVG5ja1Rr?=
 =?utf-8?B?MEtyUW1zYWZZc3pJRHZaa3NMRXYrYW9qQnBpQll4STdESjJ0VDZSc2l6ZzYx?=
 =?utf-8?B?Q2VkVGx5eHNueTcrZTNjWjYwSlh1RjhReGtneWREUHpqdHFGeU9GOHNWRjdQ?=
 =?utf-8?B?N3dKeEtDQnlpd2JEV0g0cDQyMllZRlVQaGRhRWZpRTZmZWpxOFVBYmp3eCty?=
 =?utf-8?B?eDBkMjByMWY0TFFoaDA5aWoybUFIKzRzdU43Qm50bzhzUGoramQ0M2gzWDVl?=
 =?utf-8?B?L0hOYWZjWDJTZkxoM3h0MEdhNit5SkZySlhHOVYxQ1B0YTFFSEduMUJsT0dP?=
 =?utf-8?B?K05zbDIzbG5RaGdqc2Uxb2FFMlNINW9Bd3Nnd3RockFpalJKclRKL1E0UHp6?=
 =?utf-8?B?Ly9GdkxkeC90MnQybHJaWjlIMklBVkRlUUpBc1ZNVDdkV0Y1MDAvd2lzUy8x?=
 =?utf-8?B?NFFkcThLWVRUa3Mwa1lmam9DYm5hZ1FHR3R3Q0I2cWxPVTFXQ2R6R1pUOGsv?=
 =?utf-8?B?a2doSkJXYld5TFcyeXNIcnFCU2F1MGMvaXFldjhUZDdLK2djS2VGOTVMYTlv?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZGFMRWVEMGxaVXVZTlFZRld4bjZPWkpoZjZoaklHTThxSExyVzFoVFI1cXJt?=
 =?utf-8?B?bGpSZzBOOEZCb0RQVWhrL0VSRHlRa3YrZDI4WnFHLyt3Y1VPZVRmUE5pL3VE?=
 =?utf-8?B?V1Bia3RPNkg5cWlFWmd1djJUQjUrNWQ1bVBDS0ZzMVRneUY5cGhUQmhSczFw?=
 =?utf-8?B?QTFpVGRZaUxYaVhBTzFIUWJjOVZLWVYyUTZlSjNJYlpDZWhsWnRJa3J1bHRN?=
 =?utf-8?B?VmYxVjF6SkszMXkyQVE1Ym43ejdXUm5YSU45ZGtVVG1wazZ4RkcxZEY4UlJy?=
 =?utf-8?B?bTM5YkZ6OXkwcnQ5N2p3bDh2aHF3MlFXNWxKeVZiMDN0QXZIVVM2eG44VVRE?=
 =?utf-8?B?ZUU3VWhVbEtxaWhRWjc0TFExK3BPek8zbTRNQVNPZ05yZVB2VTdBdkNEdTkr?=
 =?utf-8?B?OTVMVS9KT2pHLzh1YTMyUjlucDNTelZEUEllUVZnNUFzQW4waDlNK09hRlRK?=
 =?utf-8?B?TWJPVlpabjNweUpINXlzQXV2VDFGRHBsd2hFV0QwSEJ1NlNRWlp2K2RDSTQr?=
 =?utf-8?B?UkU1R2NkY1M2dmhKM3Jvd2tuQThuTkRuY0UzM0c2d01mN2xnTFVNYVVXZjFX?=
 =?utf-8?B?Yk9zZlhCLzFIMG1BRFpPZUU1aHlkVWRQcm96WTNyTjE1QStKd2I1YzA1TjVS?=
 =?utf-8?B?TG9FU0VHSEpIRllZaWNpbEV5d3Bwa0E5dVRINXVnZHYra25sdk1VTGNpLzFT?=
 =?utf-8?B?aU54Z1ZiRVRLVVU4MmNydDBOb0IyMGNycElyNG50UVhONDBiZWhRbXk2ckRJ?=
 =?utf-8?B?TzQxMzhuRUgvVDVONWFHYnZnUDNHZFhINzlQbWx6SGRZakxkS09sZFFwenNn?=
 =?utf-8?B?ZUk2VzZpZmVvK1BnWk1uTHIzL3gzZ2NUcXU2WldKcm5iRXNmNzVqWldSMmdi?=
 =?utf-8?B?TktsUUdnTUlYaFo1bWlHN1R1ZGVGTHozVmtyYldES1NzTHgyVmZ5TVFhdlJz?=
 =?utf-8?B?dXgrSEJ2aUdTcXY1YVgyZGZzOERwZnduVnltWGNtWmhzbDhQakw0RXNwcGs5?=
 =?utf-8?B?U2YwTGsyY2t2YzBCNCtROXRJUmhpNDVuaWcyckIxNkRsNWIzdTVnbGpmanIw?=
 =?utf-8?B?WkVpRzE4WVN5V1QreUZENUFWRTNUZWlwbnlrUERjRWFhNzc0WXRwcWgrY0t4?=
 =?utf-8?B?U3htdDlXSUhBTE51L1hvc0ZHLzRRdXY2NXNKQXg3Wi83L3kwbjVoN1NidWJ4?=
 =?utf-8?B?UWl6QjhsQldlVlF5R0RPWWZiejBpSE9idVhHVzBOdk94S3gvL0F1eTlVV2dN?=
 =?utf-8?B?dGZaejRia090aXZ4TEVCNU5rVVZ5VUxlNkZGdTdZMTdKNlBxNWx2dXY4emsw?=
 =?utf-8?B?SFB4dENzUzlaSU53VmV4TVRwejZPY1lwbEJZdWVIU1lZNGo1NGpEb0NBWmdi?=
 =?utf-8?B?ajVYOFBVbk5wc2xzNlF6Z1RhRXQ2K3did3BvTzBudWF5eHJjUStmR0gyWGhN?=
 =?utf-8?B?UGZqNVNSRDd3bGV2akZNK3IvWk5ZTzlkMjI0QUlnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bd12aa-4e9e-427f-bf2b-08daf251fe3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 14:58:40.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIXm1owHPPRTd68x5vYnvrWSG6bF8+KJn181bRav4iBHO0dcDOWdHq8FOlIfqs8Zi3ew/ytwibnOXZG/Uj92vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_08,2023-01-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090108
X-Proofpoint-GUID: CJ05WZPZ7LtEegI8fPDH5LKG_3gKfQpv
X-Proofpoint-ORIG-GUID: CJ05WZPZ7LtEegI8fPDH5LKG_3gKfQpv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 02:53, Jing Zhang wrote:
> I'll factor out the pmu_core__find function in tools/perf/arch/arm64/util/pmu.c:
> 
> static const struct perf_pmu *pmu_core__find(void)

maybe name as pmu_core__find_same() or similar to indicate that we're 
only dealing with homogeneous cores

> {
> 	struct perf_pmu *pmu = NULL;

no need to init to NULL

> 
> 	while ((pmu = perf_pmu__scan(pmu))) {

1x superfluous level of ()

> 		if (!is_pmu_core(pmu->name))
> 			continue;
> 
> 		/*
> 		 * The cpumap should cover all CPUs. Otherwise, some CPUs may
> 		 * not support some events or have different event IDs.
> 		 */
> 		if (pmu->cpus->nr != cpu__max_cpu().cpu)
> 			return NULL;
> 		return pmu;
> 	}
> 
> 	return NULL;
> }
> 

...

> 
>>> +}
>>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>>> index 69ca000..a2f7df8 100644
>>> --- a/tools/perf/util/pmu.h
>>> +++ b/tools/perf/util/pmu.h
>>> @@ -259,4 +259,5 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
>>>      char *pmu_find_real_name(const char *name);
>>>    char *pmu_find_alias_name(const char *name);
>>> +int perf_pmu__get_slots(void);
>> I think that this name is a bit too vague. Maybe perf_pmu__cpu_cycles_per_slot() could be better.
>>
> Does cpu_cycles_per_slot mean "cpu cycles per slot"? In the documemt, Slots mean operation width.
> If slots are 5, the largest value by which the STALL_SLOT PMU event may increment in one cycle is 5.
> So, maybe perf_pmu__cpu_slots_per_cycle() could be more accurate？

ok, yes, fine.

Thanks,
John

