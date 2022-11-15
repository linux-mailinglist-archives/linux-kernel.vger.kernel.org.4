Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DC362A075
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiKORgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiKORf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:35:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A27D18360;
        Tue, 15 Nov 2022 09:35:55 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFFqDIB022483;
        Tue, 15 Nov 2022 17:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SYSnzfaPC+SdO3CYvPNdFG+FCO2KaaX1MN8ydVn5fhc=;
 b=XrXsmgkRwdX1XIgurhVb8SOqe6oRHwpHe6VuPEiZWSUiKQvXcbnZuSJgfFidajPNUnme
 m6Uy63LgyQswEZRNDms2KiHEFQJAG5friDbgbcBV8V7WId1tXgIyNh4cDSIZlgPxXJBp
 l7SsN8NPeAoZGMaqBSExsZh4u0T5sQD45K/GW/sAUvStU+vSQCk+bY++r4p3ZFWg8K2F
 d22kmeC6f0Cvlm86Lykst6ZZVJOMfZIvcBAb2kjiW3aPArY5XQrmhuXXXaEWGQwcBh+/
 XRHgzjNkl1UTrxuGJ2nPAKmzuWW2enkBOz2u1tRtprY+IGsy1AUpSD/yvg4EhSh5FLPE 3A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3ns27ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 17:35:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFGgbIN010206;
        Tue, 15 Nov 2022 17:35:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xccwan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 17:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyhoO42KDvC2uPeDU/aq2dfKTNGLk9jPvnf62CLkUDdFe1qg/+ReIp3mRvNbsWk430X9+1J9T2jc3uzZzQWiShaIqkiMkPd9yvZyPlBIzSPXxrA6ZnTjYJn5/5aU7Zu8HxVrdVBKifPaL+vLlx8Ps9IMiB5q4F4Te26MfmU1EtxfBm41rqD0vE0TmnXQuLxGkLHtTHUDofizfeS6CkQ3o4mA+4Z+SLOhOahnxnQa/Tt9II7ZEQFfs3tgCC0kOenMZ8LZ2dlHkTWBB/4JgP70LofeZsv9NYGmoRs2xwOA/OtcFDPjhTZgsN44d7c1CWU9J4HzI7+rFo5AZqcsNZsgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYSnzfaPC+SdO3CYvPNdFG+FCO2KaaX1MN8ydVn5fhc=;
 b=O+cMDuRQtjwhj6p5m5+8msvvBBX5n8VSMV3BPSkd/To4XoWpUrD9fXkkychdYg3+y9jHX2D0oSSsZ/UgTLB+4Da77vWDGaIMNzS5obcqoRG7hMsts/o7Nf3VyO2ujmi7OPEwnBbXm4dtve1pjv25LAs5zy9dP46/pyphJiSxikslyc5yqq7PPEo7284Qltd49rlLA1qJATBRanpvntiv0vj5JDtSwwKyPxlyhSxf868ViYYkFMyTk4MDo7XxbmDF/f9HAoD+5yEmgn6YB6bK1Zbf4wXpf3+WxgiarzguXJG/vLfjrK/d9gLPk7Gy1IW6WGzL6OY1wVnH8TnT3cDIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYSnzfaPC+SdO3CYvPNdFG+FCO2KaaX1MN8ydVn5fhc=;
 b=n45uYNESPidjTLiOhA4PcXDmECTEiq0o3+zf4X1mN90WfnnXrWoZ4KX4u91Ac8XfhrzD9bP0ciCfKWrbbAcjJdlfIa4UcRM7if+zG/HsTxFcTy5f7KOcq3Vqt21KXzN9xoWpi6lJ7dw6UV1PzIAKEGW1ncihRUhW32O32E+GNeE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5019.namprd10.prod.outlook.com (2603:10b6:610:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 17:35:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b%5]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 17:35:07 +0000
Message-ID: <f3e704f9-988c-e01f-eb40-13aa405e2857@oracle.com>
Date:   Tue, 15 Nov 2022 17:35:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: RFC Re: [PATCH v2] perf jevents: Parse metrics during conversion
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20221012164244.3027730-1-irogers@google.com>
 <CAP-5=fW5+boUZqJV6-6VVa2bOcTrErHU3K5Fz-Z54j8uq_kfdw@mail.gmail.com>
 <Y21Hdoc8KsvNMbTQ@kernel.org>
 <CAP-5=fXbjk31SvZNVzo5x0uDnVndw7Z=BFPah9Dgx=AULkTPaA@mail.gmail.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fXbjk31SvZNVzo5x0uDnVndw7Z=BFPah9Dgx=AULkTPaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 049b7398-da14-4854-247e-08dac72fbd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKSqqrKTtykphvPRkTYuECYzD22iZNW6OsrEP/VTz877PHd+cdq7B/pZKtM8k6IvECln0u1qGqeZ6HrLfYf5FamSe2fgCMeXcrgWuCrvMXkSvoGPaupX5JX0KnLQeyG2VuuI9dr87Mnx2v/ldIxB7F7a11eRToKsQUecVIt/IS1Iphg337kml+WtzYSyjqomnoutWc1k4XRO34LN1ClDMU4duRdDaOMxfxuAoMMjbUKOaj5mUKcpYUGF9ms2cZAsxQYU9OmaqVc5l2aZetDhzp4yj8o6WbR7nYBPIY+RulTpPnRhOE/Nz+b3K5dsOWo4KUlK5F0MJlUfC30e4eEX3X43+uFb/6Qr72/yj1n4dS7yCw/q+u/wiBWk3Hz4cBLlxEXIe8llT27MwS2hd4J2HABu/V10HnHBRe6yhVYzzT9X79OSQBu+1xb1yjkePpV+4UeHycjJOY9cHIpEGyc2A6g03htoBNRPvdZ9gWFSdMNMNtm6kLpCb8JDMGH+nte5Ss3/LVZndeELhqJteakgeadP5oemWWGPIIAqQu3oGlgenaEnv6aROAEeHSbyCshC6JEblGKLqfWfNc4hHHP6A4JEvixrDGWBApdocybWR+nV9Z+ankVQGrOEXsmN+G7eSv/vzvXCbhjHTc4N9RWPeP8cKmxm8Ud65hAiZoo13RqdpPqeDmch96sSOt7k1Qo5Q5Ml4hd9Hskp6JKTG0YFoUGnVv8Geh6Lls6Ty5CSo/IKFXkLOC5svQvEusBYtCxwKXKsxk365u9hjZaR4IxB/GCM2wQhWvAfJSbumqKZ+1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(26005)(83380400001)(6486002)(478600001)(36916002)(6512007)(2906002)(6666004)(53546011)(6506007)(31686004)(186003)(316002)(4326008)(41300700001)(54906003)(66946007)(110136005)(2616005)(8676002)(36756003)(66556008)(30864003)(8936002)(7416002)(86362001)(5660300002)(66476007)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEIzS043YXRKMlQ5eFRNL0grZGZybFZxcEkycmxxNVlLdFlON200V0g4WEZU?=
 =?utf-8?B?aFRXc1pKMUN6Q24yQk9WbTNEWk9sMjhPUktHaEVNV1N3aksxV2Q5U0pSOHBF?=
 =?utf-8?B?ZHNFczRKd3Y5bGxEbE9uc3lndDZmL1BEYXVSOXJxN20xNzhaZnBWK2wwZTAx?=
 =?utf-8?B?Wkk3ZjZJNzNXaEd2YXRnRjB0WXBrcThwaGdqSHNSODFUY3VXaEdLSStZZDlo?=
 =?utf-8?B?b09KWTdkQzR4aE53enBSZlArNWVvTVRPVE9oMmVsYmtycDVXS0FSQVhTSGow?=
 =?utf-8?B?ZzhsSDAzQTBzRVlDclN2Vml2MFVpZGxGTndTeTB5VG5mNUZGY2hWZlFFdjdT?=
 =?utf-8?B?MGRheGJOT3ljUXVFUk5pRzljMlJIKzY2NjBuQTRwTG1iRU9GU2NNZWpWMXZS?=
 =?utf-8?B?SmNlK0tDM1dSZ2N2VkVGd3BmMm5PWHNhRndrZzBJVXVKMFNtb3VrWXNNbjdF?=
 =?utf-8?B?bXRkbTZHVEJUY1Vuc0s4b01HblBEREc4OGJ1NFJZMi9jajMvWFJwb1BpcXlB?=
 =?utf-8?B?RGNlcld6TUlpdEttd0VzdTRLeHhidTd6YW4xUXJrTmlud1VKbmxQRzhuMFJT?=
 =?utf-8?B?N25EeGNueld3RGRjMm1RRlRLZzJiaHpTbUVzS1FtNGR2NFZUNU85aVJPYTJo?=
 =?utf-8?B?VkJNMUFXUXdMR3RMc2RkKyswNVBQRUh0RklXSUEvUERFK2RpeFJQZHJ4V3Nn?=
 =?utf-8?B?cy93bzFKSDk3U0IyRlkwYnZHbGpmUllqN1BHWVRrNUphaEZsVlYvMXFVN0o2?=
 =?utf-8?B?VGZkQzU3Z1hLK3BOdk1CMGpYU0kzWWRKUHcwandqckxSQUVSTEtzN0NnL3A4?=
 =?utf-8?B?VVJ0VkUybjB1NkN1elBJMEpESzBmSlhaZDVqNDEzblpxWXJtVk94cEtIL1k5?=
 =?utf-8?B?MWFRQTdHdHhzNU1ncDNYaWdnSm1xQlE2TEI2bEVscXpjM3dQbk1vd3lKa0NI?=
 =?utf-8?B?VWJsSjR5WGtZR0pSdWJFS25reE5qU0RLVlNadHltSy81dnVhRjZrTmxFNk9C?=
 =?utf-8?B?UUhuaHAvUEg5N25WUG1rbWljK2pJUVN3ZzBzQmE5UWpWQTRhRlNpRDY4Nkdq?=
 =?utf-8?B?ZTNLTFhSTTI4SXhJMGs2ZmNjNkppZmRxZ2lxSFI5YVdkUXdaMTd4cG1DRG56?=
 =?utf-8?B?QnVZQ3hLZm4wREpKM2ZmZU1VYVdqL2VZek0xM0orVnZrWjFGaEFjbHQzVTJv?=
 =?utf-8?B?cXQwWG9CaW51MHVYNEhTa3Urdmd3Smw4OXgyT1hPb2g0dXlvWGlvOUpJZnBN?=
 =?utf-8?B?K1F3ZzZxb1lERkhCbDRvMnZYa1IwQThmWkhZdVlqRTJyNkFwd2dqdTRhVGZo?=
 =?utf-8?B?RytuK2g1Z3ZqaEdFajFyWG50bm92UlhRRG1adWZjclBQRC9KUlQva29kaTlP?=
 =?utf-8?B?U0VrdHZlZllLcjF1cnFMUGkwaGdFcDdtVmpwL1lFMXpaUjBRcmM5ckpKNEZv?=
 =?utf-8?B?dUcwdXJtKzZybW4vRmVucW9PSEhzaU1nZ05MSWdjb2xqRHlvdGpJNTNKb250?=
 =?utf-8?B?N3RjbzJTV2hNTy9VeUVxOW4wOXRLWnNMUUJMVlVISGdxNWhPYkRzWGhhL2Fk?=
 =?utf-8?B?MUlrKzNacncvZCtHNnRtY3lEQkRNS2pFU1VJY3Vzejd1ODNmSllKRVhNRE9y?=
 =?utf-8?B?VDl5ZGdITHczVm1sMHY4ODJNVVZzckFON3N5OEJkK3hyRm9wcWJlVW9NOGpC?=
 =?utf-8?B?ODRKcU9KQTk2MU1MbmlLcjlYWlRkYU54NTQ3SVoxVW9kM3ZITnBwSEx4Rncz?=
 =?utf-8?B?RXNyMitwQVBwaU9vaHlvdnE4L3B6citwVmtCbmFJZ3BnTXZvSnNuUWdUYXQ1?=
 =?utf-8?B?ZE0zZzYrbllydkhINTZxaDdJKzdKc2xMY3FtK3F6RDA0amJ4QnZUZC80VFJy?=
 =?utf-8?B?RjB4NWRoeGhxMmZOTzBvT3NZTzRqbmlzYnBWMXBIWTdsWGhBU0JES3F5enVl?=
 =?utf-8?B?ajAybWV2QUtRYlE3Qk5YNHVLclRvK3JKWGI3ckxGR2pKQkZpRkNRWityekJ5?=
 =?utf-8?B?VW53UjIzZGhGWDNCRzZTSEIzRDhUM2FYdXZ6OEhpeFFUd0FXSGlGeXY4ZzdE?=
 =?utf-8?B?ZFFXSWpDTWczQXJxZEZQcWtrQ1N4QStsZXUwSy85MEQwcUNvWVR1VURVcnZX?=
 =?utf-8?Q?FUJcN3n17ZZvmnnB6oGzuSpmu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZUc2bGpnWE1TTTl2ZXZzMUZyR3VUc25CRFdUZ0RLeFJwcEZoRmE1dCt5angy?=
 =?utf-8?B?L0tpeGxWdzhIQmpaMGxwRUg5NlZLd3ROQXMybjdQTlFXYmxTMk54Tm5lbzZZ?=
 =?utf-8?B?RmdkK2hHT3dYTzZ5azRhZk5lSlpUQVUxZ1diUlVLc2c0ZkRGbFE3MGJ2dnJZ?=
 =?utf-8?B?aXYra3lNWVdzaTluclM4TmhaMlJRcEgyaG1FQUJ5QXA5dCtIL05QVGF1N0F2?=
 =?utf-8?B?U1J6Z21IWFRtMCtCQnU0UGJkQ1dadFE5UjVOKzJ1Y2NlZHUrUzdoTjJ2UlM0?=
 =?utf-8?B?NWlYbFRBaXFGTzB0Lzl4dVlxSStRNW0xQzFORTl0MzdhMVpjQjkvT21WSVE2?=
 =?utf-8?B?SHdkM05OMmtYc2Vxb3ZKd2VVbzNxNTd1ZVZkWVVWYnZXeVMyNDQxeE44dStD?=
 =?utf-8?B?M3YxeE5GeXFmRk1ZZTA5TzNkb1pHd3NQR1h5RWdKQlIwYU9MTFhXTWN6UHRP?=
 =?utf-8?B?Y0NrV0YxL0NWRHR0aEJuYUNjKzVERGZHTXVmUjQzVmpXRElCbjdwSHR5UUdM?=
 =?utf-8?B?VmpwcmZDbks0ajdKQ3o5OENTUEd6UzNyVEVta2NKRmMrYitRSnhQSFR4OFA1?=
 =?utf-8?B?TkF6ejl0RG1kTGR6Y1BldlJDU1BKS092OVF5Tld5TTJPTzE2Vk5mcFlyZEl1?=
 =?utf-8?B?aUxpY214TjE1NUtzU3R0TVRzTXdYSjg4TDJPRDRPV1lEZXN4NGlmd0p0OGp3?=
 =?utf-8?B?THlwMGJsbjA0a1U4SGpUVWsyeFY3MndPWmZvbHZHYUVDNmlkcGh3RVdBc2pm?=
 =?utf-8?B?YWVHelMwa3orVDA2d1R5QytLTDIySTg1Qk9OVDBIRklhc2RIWHdsQ3l4dlVt?=
 =?utf-8?B?em1MN3FFNjBvZlR5UnUzWnM5eFd0KzdJTVU0Q3dVRnF6WjVTcm1tTnp2TFVv?=
 =?utf-8?B?eEs0cHM4bzV0ZjJpU2d6bXB1Q1VhVnVXTFlYdkVSUUJxcWt5OVUxdkNqbC9s?=
 =?utf-8?B?Nm83MEQwYkZQSVl0Q0EvbzAvdjJxL3NDam1MQTRkL1NIUWJWVnpXdk5WV1Yw?=
 =?utf-8?B?bG1YZHJRajFCMFpPUndmY1kyQ04wT0V6cnMwSmJMNCsxVzR4QUNGNnBGMDM3?=
 =?utf-8?B?TGRlOTFSRFVTaFIzM2RFMUhHWW9ocWRDUjhSeXJGYnZ6WTBSQ1lvcmVtZExR?=
 =?utf-8?B?TUdobUM1V2poTWZPTnlydUFINWE4eHNWc21HM0QrY0tmL3dDU01LRjFWRlpn?=
 =?utf-8?B?aEVPdkpNQjE5eUxxYjJ3eDg2VE1RNWJOYVp3eXpia2xRVlZXSlMzUWoybDc5?=
 =?utf-8?B?dytDY1NZMkFtS2prS1dUd0NLRmxtdVZFUEVLTUxmdzJESGJoUnR3RmNxeEwz?=
 =?utf-8?B?K0FTZ2IxR3R2ZXFFV3h3NWNYTlBtNjR1ZEZKYlI2SW9SanJEc3FUckliM3Zz?=
 =?utf-8?B?VVhQUFplK1FLaktmeEl3N2Y1eDdVL2lVZ1J4NnBoK21wODlzckQyUDFFTjMx?=
 =?utf-8?B?c0tUeTFXRkFDcVhuQ3FKUXZMNkZLc0N4MDdJNXBoRUNqMmpoWEsvWTIzYW5X?=
 =?utf-8?B?QlNEdTlBODlmaWNMZ0ZBb3ZaSTF3QUZlZFNKcENOMXhSVzRyUHN3b0Y4N3l0?=
 =?utf-8?B?NDA2QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049b7398-da14-4854-247e-08dac72fbd03
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 17:35:07.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCh5w2Cgx6gPFUbp5GVwTxz+HRurW/vy4vUhOUrz8Hfkvb9hvktKUFi2xA8lk8pb2mC5UrcFkn5ELTUDFZHpBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5019
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211150118
X-Proofpoint-GUID: ONLV4Nx_5bOshY-jiseYGlxP-PsYNVQl
X-Proofpoint-ORIG-GUID: ONLV4Nx_5bOshY-jiseYGlxP-PsYNVQl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 17:26, Ian Rogers wrote:
> On Thu, Nov 10, 2022 at 10:48 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> Em Fri, Oct 28, 2022 at 10:57:02AM -0700, Ian Rogers escreveu:
>>> On Wed, Oct 12, 2022 at 9:42 AM Ian Rogers <irogers@google.com> wrote:
>>>>
>>>> Currently the 'MetricExpr' json value is passed from the json
>>>> file to the pmu-events.c. This change introduces an expression
>>>> tree that is parsed into. The parsing is done largely by using
>>>> operator overloading and python's 'eval' function. Two advantages
>>>> in doing this are:
>>>>
>>>> 1) Broken metrics fail at compile time rather than relying on
>>>>     `perf test` to detect. `perf test` remains relevant for checking
>>>>     event encoding and actual metric use.
>>>>
>>>> 2) The conversion to a string from the tree can minimize the
>>>>     metric's string size, for example, preferring 1e6 over 1000000
>>>>     and removing unnecessary whitespace. On x86 this reduces the
>>>>     string size by 2,823bytes (0.06%).
>>>>
>>>> In future changes it would be possible to programmatically
>>>> generate the json expressions (a single line of text and so a
>>>> pain to write manually) for an architecture using the expression
>>>> tree. This could avoid copy-pasting metrics for all architecture
>>>> variants.
>>>>
>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>
>>> Ping, PTAL.
>>
>> That would be really nice if people working with JSON, metrics, could
>> take a look at Ian's work and test it with their files, volunteers?
> 
> Perhaps John could help?

I'll have a look soon. I have to admit that I have not been tracking the 
jevents changes as close as before.

Thanks,
John

> 
> Thanks,
> Ian
> 
>> - Arnaldo
>>
>>> Thanks,
>>> Ian
>>>
>>>> v2. Improvements to type information.
>>>> ---
>>>>   tools/perf/pmu-events/Build          |   2 +-
>>>>   tools/perf/pmu-events/jevents.py     |  11 +-
>>>>   tools/perf/pmu-events/metric.py      | 466 +++++++++++++++++++++++++++
>>>>   tools/perf/pmu-events/metric_test.py | 143 ++++++++
>>>>   4 files changed, 618 insertions(+), 4 deletions(-)
>>>>   create mode 100644 tools/perf/pmu-events/metric.py
>>>>   create mode 100644 tools/perf/pmu-events/metric_test.py
>>>>
>>>> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
>>>> index 04ef95174660..15b9e8fdbffa 100644
>>>> --- a/tools/perf/pmu-events/Build
>>>> +++ b/tools/perf/pmu-events/Build
>>>> @@ -21,7 +21,7 @@ $(OUTPUT)pmu-events/pmu-events.c: pmu-events/empty-pmu-events.c
>>>>          $(call rule_mkdir)
>>>>          $(Q)$(call echo-cmd,gen)cp $< $@
>>>>   else
>>>> -$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY)
>>>> +$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY) pmu-events/metric.py
>>>>          $(call rule_mkdir)
>>>>          $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) pmu-events/arch $@
>>>>   endif
>>>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>>>> index 0daa3e007528..81bcbd15c962 100755
>>>> --- a/tools/perf/pmu-events/jevents.py
>>>> +++ b/tools/perf/pmu-events/jevents.py
>>>> @@ -4,6 +4,7 @@
>>>>   import argparse
>>>>   import csv
>>>>   import json
>>>> +import metric
>>>>   import os
>>>>   import sys
>>>>   from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
>>>> @@ -268,9 +269,9 @@ class JsonEvent:
>>>>       self.metric_name = jd.get('MetricName')
>>>>       self.metric_group = jd.get('MetricGroup')
>>>>       self.metric_constraint = jd.get('MetricConstraint')
>>>> -    self.metric_expr = jd.get('MetricExpr')
>>>> -    if self.metric_expr:
>>>> -      self.metric_expr = self.metric_expr.replace('\\', '\\\\')
>>>> +    self.metric_expr = None
>>>> +    if 'MetricExpr' in jd:
>>>> +       self.metric_expr = metric.ParsePerfJson(jd.get('MetricExpr'))
>>>>       arch_std = jd.get('ArchStdEvent')
>>>>       if precise and self.desc and '(Precise Event)' not in self.desc:
>>>>         extra_desc += ' (Must be precise)' if precise == '2' else (' (Precise '
>>>> @@ -322,6 +323,10 @@ class JsonEvent:
>>>>       s = ''
>>>>       for attr in _json_event_attributes:
>>>>         x = getattr(self, attr)
>>>> +      if x and attr == 'metric_expr':
>>>> +        # Convert parsed metric expressions into a string. Slashes
>>>> +        # must be doubled in the file.
>>>> +        x = x.ToPerfJson().replace('\\', '\\\\')
>>>>         s += f'{x}\\000' if x else '\\000'
>>>>       return s
>>>>
>>>> diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
>>>> new file mode 100644
>>>> index 000000000000..542d13300e80
>>>> --- /dev/null
>>>> +++ b/tools/perf/pmu-events/metric.py
>>>> @@ -0,0 +1,466 @@
>>>> +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>>>> +"""Parse or generate representations of perf metrics."""
>>>> +import ast
>>>> +import decimal
>>>> +import re
>>>> +import json
>>>> +from typing import (Optional, Set, Union)
>>>> +
>>>> +class Expression:
>>>> +  """Abstract base class of elements in a metric expression."""
>>>> +
>>>> +  def ToPerfJson(self) -> str:
>>>> +    """Returns a perf json file encoded representation."""
>>>> +    raise NotImplementedError()
>>>> +
>>>> +  def ToPython(self) -> str:
>>>> +    """Returns a python expr parseable representation."""
>>>> +    raise NotImplementedError()
>>>> +
>>>> +  def Simplify(self):
>>>> +    """Returns a simplified version of self."""
>>>> +    raise NotImplementedError()
>>>> +
>>>> +  def Equals(self, other) -> bool:
>>>> +    """Returns true when two expressions are the same."""
>>>> +    raise NotImplementedError()
>>>> +
>>>> +  def __str__(self) -> str:
>>>> +    return self.ToPerfJson()
>>>> +
>>>> +  def __or__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('|', self, other)
>>>> +
>>>> +  def __ror__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('|', other, self)
>>>> +
>>>> +  def __xor__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('^', self, other)
>>>> +
>>>> +  def __and__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('&', self, other)
>>>> +
>>>> +  def __lt__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('<', self, other)
>>>> +
>>>> +  def __gt__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('>', self, other)
>>>> +
>>>> +  def __add__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('+', self, other)
>>>> +
>>>> +  def __radd__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('+', other, self)
>>>> +
>>>> +  def __sub__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('-', self, other)
>>>> +
>>>> +  def __rsub__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('-', other, self)
>>>> +
>>>> +  def __mul__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('*', self, other)
>>>> +
>>>> +  def __rmul__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('*', other, self)
>>>> +
>>>> +  def __truediv__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('/', self, other)
>>>> +
>>>> +  def __rtruediv__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('/', other, self)
>>>> +
>>>> +  def __mod__(self, other: Union[int, float, 'Expression']) -> 'Operator':
>>>> +    return Operator('%', self, other)
>>>> +
>>>> +
>>>> +def _Constify(val: Union[bool, int, float, Expression]) -> Expression:
>>>> +  """Used to ensure that the nodes in the expression tree are all Expression."""
>>>> +  if isinstance(val, bool):
>>>> +    return Constant(1 if val else 0)
>>>> +  if isinstance(val, int) or isinstance(val, float):
>>>> +    return Constant(val)
>>>> +  return val
>>>> +
>>>> +
>>>> +# Simple lookup for operator precedence, used to avoid unnecessary
>>>> +# brackets. Precedence matches that of python and the simple expression parser.
>>>> +_PRECEDENCE = {
>>>> +    '|': 0,
>>>> +    '^': 1,
>>>> +    '&': 2,
>>>> +    '<': 3,
>>>> +    '>': 3,
>>>> +    '+': 4,
>>>> +    '-': 4,
>>>> +    '*': 5,
>>>> +    '/': 5,
>>>> +    '%': 5,
>>>> +}
>>>> +
>>>> +
>>>> +class Operator(Expression):
>>>> +  """Represents a binary operator in the parse tree."""
>>>> +
>>>> +  def __init__(self, operator: str, lhs: Union[int, float, Expression],
>>>> +               rhs: Union[int, float, Expression]):
>>>> +    self.operator = operator
>>>> +    self.lhs = _Constify(lhs)
>>>> +    self.rhs = _Constify(rhs)
>>>> +
>>>> +  def Bracket(self,
>>>> +              other: Expression,
>>>> +              other_str: str,
>>>> +              rhs: bool = False) -> str:
>>>> +    """Returns whether to bracket ``other``
>>>> +
>>>> +    ``other`` is the lhs or rhs, ``other_str`` is ``other`` in the
>>>> +    appropriate string from. If ``other`` is an operator then a
>>>> +    bracket is necessary when this/self operator has higher
>>>> +    precedence. Consider: '(a + b) * c', ``other_str`` will be 'a +
>>>> +    b'. A bracket is necessary as without the bracket 'a + b * c' will
>>>> +    evaluate 'b * c' first. However, '(a * b) + c' doesn't need a
>>>> +    bracket as 'a * b' will always be evaluated first. For 'a / (b *
>>>> +    c)' (ie the same precedence level operations) then we add the
>>>> +    bracket to best match the original input, but not for '(a / b) *
>>>> +    c' where the bracket is unnecessary.
>>>> +    """
>>>> +    if isinstance(other, Operator):
>>>> +      if _PRECEDENCE.get(self.operator, -1) > _PRECEDENCE.get(
>>>> +          other.operator, -1):
>>>> +        return f'({other_str})'
>>>> +      if rhs and _PRECEDENCE.get(self.operator, -1) == _PRECEDENCE.get(
>>>> +          other.operator, -1):
>>>> +        return f'({other_str})'
>>>> +    return other_str
>>>> +
>>>> +  def ToPerfJson(self):
>>>> +    return f'{self.Bracket(self.lhs, self.lhs.ToPerfJson())} {self.operator} ' \
>>>> +      f'{self.Bracket(self.rhs, self.rhs.ToPerfJson(), True)}'
>>>> +
>>>> +  def ToPython(self):
>>>> +    return f'{self.Bracket(self.lhs, self.lhs.ToPython())} {self.operator} ' \
>>>> +      f'{self.Bracket(self.rhs, self.rhs.ToPython(), True)}'
>>>> +
>>>> +  def Simplify(self) -> Expression:
>>>> +    lhs = self.lhs.Simplify()
>>>> +    rhs = self.rhs.Simplify()
>>>> +    if isinstance(lhs, Constant) and isinstance(rhs, Constant):
>>>> +      return Constant(eval(lhs + self.operator + rhs))
>>>> +
>>>> +    if isinstance(self.lhs, Constant):
>>>> +      if (self.operator == '+' or self.operator == '|') and lhs.value == '0':
>>>> +        return rhs
>>>> +
>>>> +      if self.operator == '*' and lhs.value == '0':
>>>> +        return Constant(0)
>>>> +
>>>> +      if self.operator == '*' and lhs.value == '1':
>>>> +        return rhs
>>>> +
>>>> +    if isinstance(rhs, Constant):
>>>> +      if (self.operator == '+' or self.operator == '|') and rhs.value == '0':
>>>> +        return lhs
>>>> +
>>>> +      if self.operator == '*' and rhs.value == '0':
>>>> +        return Constant(0)
>>>> +
>>>> +      if self.operator == '*' and self.rhs.value == '1':
>>>> +        return lhs
>>>> +
>>>> +    return Operator(self.operator, lhs, rhs)
>>>> +
>>>> +  def Equals(self, other: Expression) -> bool:
>>>> +    if isinstance(other, Operator):
>>>> +      return self.operator == other.operator and self.lhs.Equals(
>>>> +          other.lhs) and self.rhs.Equals(other.rhs)
>>>> +    return False
>>>> +
>>>> +class Select(Expression):
>>>> +  """Represents a select ternary in the parse tree."""
>>>> +
>>>> +  def __init__(self, true_val: Union[int, float, Expression],
>>>> +               cond: Union[int, float, Expression],
>>>> +               false_val: Union[int, float, Expression]):
>>>> +    self.true_val = _Constify(true_val)
>>>> +    self.cond = _Constify(cond)
>>>> +    self.false_val = _Constify(false_val)
>>>> +
>>>> +  def ToPerfJson(self):
>>>> +    true_str = self.true_val.ToPerfJson()
>>>> +    cond_str = self.cond.ToPerfJson()
>>>> +    false_str = self.false_val.ToPerfJson()
>>>> +    return f'({true_str} if {cond_str} else {false_str})'
>>>> +
>>>> +  def ToPython(self):
>>>> +    return f'Select({self.true_val.ToPython()}, {self.cond.ToPython()}, ' \
>>>> +      f'{self.false_val.ToPython()})'
>>>> +
>>>> +  def Simplify(self) -> Expression:
>>>> +    cond = self.cond.Simplify()
>>>> +    true_val = self.true_val.Simplify()
>>>> +    false_val = self.false_val.Simplify()
>>>> +    if isinstance(cond, Constant):
>>>> +      return false_val if cond.value == '0' else true_val
>>>> +
>>>> +    if true_val.Equals(false_val):
>>>> +      return true_val
>>>> +
>>>> +    return Select(true_val, cond, false_val)
>>>> +
>>>> +  def Equals(self, other: Expression) -> bool:
>>>> +    if isinstance(other, Select):
>>>> +      return self.cond.Equals(other.cond) and self.false_val.Equals(
>>>> +          other.false_val) and self.true_val.Equals(other.true_val)
>>>> +    return False
>>>> +
>>>> +class Function(Expression):
>>>> +  """A function in an expression like min, max, d_ratio."""
>>>> +
>>>> +  def __init__(self,
>>>> +               fn: str,
>>>> +               lhs: Union[int, float, Expression],
>>>> +               rhs: Optional[Union[int, float, Expression]] = None):
>>>> +    self.fn = fn
>>>> +    self.lhs = _Constify(lhs)
>>>> +    self.rhs = _Constify(rhs)
>>>> +
>>>> +  def ToPerfJson(self):
>>>> +    if self.rhs:
>>>> +      return f'{self.fn}({self.lhs.ToPerfJson()}, {self.rhs.ToPerfJson()})'
>>>> +    else:
>>>> +      return f'{self.fn}({self.lhs.ToPerfJson()})'
>>>> +
>>>> +  def ToPython(self):
>>>> +    if self.rhs:
>>>> +      return f'{self.fn}({self.lhs.ToPython()}, {self.rhs.ToPython()})'
>>>> +    else:
>>>> +      return f'{self.fn}({self.lhs.ToPython()})'
>>>> +
>>>> +  def Simplify(self) -> Expression:
>>>> +    lhs = self.lhs.Simplify()
>>>> +    rhs = self.rhs.Simplify()
>>>> +    if isinstance(lhs, Constant) and isinstance(rhs, Constant):
>>>> +      if self.fn == 'd_ratio':
>>>> +        if rhs.value == '0':
>>>> +          return Constant(0)
>>>> +        Constant(eval(f'{lhs} / {rhs}'))
>>>> +      return Constant(eval(f'{self.fn}({lhs}, {rhs})'))
>>>> +
>>>> +    return Function(self.fn, lhs, rhs)
>>>> +
>>>> +  def Equals(self, other: Expression) -> bool:
>>>> +    if isinstance(other, Function):
>>>> +      return self.fn == other.fn and self.lhs.Equals(
>>>> +          other.lhs) and self.rhs.Equals(other.rhs)
>>>> +    return False
>>>> +
>>>> +
>>>> +class Event(Expression):
>>>> +  """An event in an expression."""
>>>> +
>>>> +  def __init__(self, name: str, legacy_name: str = ''):
>>>> +    self.name = name
>>>> +    self.legacy_name = legacy_name
>>>> +
>>>> +  def ToPerfJson(self):
>>>> +    result = re.sub('/', '@', self.name)
>>>> +    return result
>>>> +
>>>> +  def ToPython(self):
>>>> +    return f'Event(r"{self.name}")'
>>>> +
>>>> +  def Simplify(self) -> Expression:
>>>> +    return self
>>>> +
>>>> +  def Equals(self, other: Expression) -> bool:
>>>> +    return isinstance(other, Event) and self.name == other.name
>>>> +
>>>> +class Constant(Expression):
>>>> +  """A constant within the expression tree."""
>>>> +
>>>> +  def __init__(self, value: Union[float, str]):
>>>> +    ctx = decimal.Context()
>>>> +    ctx.prec = 20
>>>> +    dec = ctx.create_decimal(repr(value) if isinstance(value, float) else value)
>>>> +    self.value = dec.normalize().to_eng_string()
>>>> +    self.value = self.value.replace('+', '')
>>>> +    self.value = self.value.replace('E', 'e')
>>>> +
>>>> +  def ToPerfJson(self):
>>>> +    return self.value
>>>> +
>>>> +  def ToPython(self):
>>>> +    return f'Constant({self.value})'
>>>> +
>>>> +  def Simplify(self) -> Expression:
>>>> +    return self
>>>> +
>>>> +  def Equals(self, other: Expression) -> bool:
>>>> +    return isinstance(other, Constant) and self.value == other.value
>>>> +
>>>> +class Literal(Expression):
>>>> +  """A runtime literal within the expression tree."""
>>>> +
>>>> +  def __init__(self, value: str):
>>>> +    self.value = value
>>>> +
>>>> +  def ToPerfJson(self):
>>>> +    return self.value
>>>> +
>>>> +  def ToPython(self):
>>>> +    return f'Literal({self.value})'
>>>> +
>>>> +  def Simplify(self) -> Expression:
>>>> +    return self
>>>> +
>>>> +  def Equals(self, other: Expression) -> bool:
>>>> +    return isinstance(other, Literal) and self.value == other.value
>>>> +
>>>> +
>>>> +def min(lhs: Union[int, float, Expression], rhs: Union[int, float,
>>>> +                                                       Expression]) -> Function:
>>>> +  return Function('min', lhs, rhs)
>>>> +
>>>> +
>>>> +def max(lhs: Union[int, float, Expression], rhs: Union[int, float,
>>>> +                                                       Expression]) -> Function:
>>>> +  return Function('max', lhs, rhs)
>>>> +
>>>> +
>>>> +def d_ratio(lhs: Union[int, float, Expression],
>>>> +            rhs: Union[int, float, Expression]) -> Function:
>>>> +  return Function('d_ratio', lhs, rhs)
>>>> +
>>>> +
>>>> +def source_count(event: Event) -> Function:
>>>> +  return Function('source_count', event)
>>>> +
>>>> +class Metric:
>>>> +  """An individual metric that will specifiable on the perf command line."""
>>>> +  groups: Set[str]
>>>> +  expr: Expression
>>>> +  scale_unit: str
>>>> +  constraint: bool
>>>> +
>>>> +  def __init__(self,
>>>> +               name: str,
>>>> +               description: str,
>>>> +               expr: Expression,
>>>> +               scale_unit: str,
>>>> +               constraint: bool = False):
>>>> +    self.name = name
>>>> +    self.description = description
>>>> +    self.expr = expr.Simplify()
>>>> +    # Workraound valid_only_metric hiding certain metrics based on unit.
>>>> +    scale_unit = scale_unit.replace('/sec', ' per sec')
>>>> +    if scale_unit[0].isdigit():
>>>> +      self.scale_unit = scale_unit
>>>> +    else:
>>>> +      self.scale_unit = f'1{scale_unit}'
>>>> +    self.constraint = constraint
>>>> +    self.groups = set()
>>>> +
>>>> +  def __lt__(self, other):
>>>> +    """Sort order."""
>>>> +    return self.name < other.name
>>>> +
>>>> +  def AddToMetricGroup(self, group):
>>>> +    """Callback used when being added to a MetricGroup."""
>>>> +    self.groups.add(group.name)
>>>> +
>>>> +  def Flatten(self) -> set:
>>>> +    """Return a leaf metric."""
>>>> +    return set([self])
>>>> +
>>>> +  def ToPerfJson(self):
>>>> +    result = {
>>>> +        'MetricName': self.name,
>>>> +        'MetricGroup': ';'.join(sorted(self.groups)),
>>>> +        'BriefDescription': self.description,
>>>> +        'MetricExpr': self.expr.ToPerfJson(),
>>>> +        'ScaleUnit': self.scale_unit
>>>> +    }
>>>> +    if self.constraint:
>>>> +      result['MetricConstraint'] = 'NO_NMI_WATCHDOG'
>>>> +
>>>> +    return result
>>>> +
>>>> +
>>>> +class _MetricJsonEncoder(json.JSONEncoder):
>>>> +  """Special handling for Metric objects."""
>>>> +
>>>> +  def default(self, obj):
>>>> +    if isinstance(obj, Metric):
>>>> +      return obj.ToPerfJson()
>>>> +    return json.JSONEncoder.default(self, obj)
>>>> +
>>>> +
>>>> +class MetricGroup:
>>>> +  """A group of metrics.
>>>> +
>>>> +  Metric groups may be specificd on the perf command line, but within
>>>> +  the json they aren't encoded. Metrics may be in multiple groups
>>>> +  which can facilitate arrangements similar to trees.
>>>> +  """
>>>> +
>>>> +  def __init__(self, name: str, metric_list: list[Union[Metric,
>>>> +                                                        'MetricGroup']]):
>>>> +    self.name = name
>>>> +    self.metric_list = metric_list
>>>> +    for metric in metric_list:
>>>> +      metric.AddToMetricGroup(self)
>>>> +
>>>> +  def AddToMetricGroup(self, group):
>>>> +    """Callback used when a MetricGroup is added into another."""
>>>> +    for metric in self.metric_list:
>>>> +      metric.AddToMetricGroup(group)
>>>> +
>>>> +  def Flatten(self) -> set:
>>>> +    """Returns a set of all leaf metrics."""
>>>> +    result = set()
>>>> +    for x in self.metric_list:
>>>> +      result = result.union(x.Flatten())
>>>> +
>>>> +    return result
>>>> +
>>>> +  def ToPerfJson(self) -> str:
>>>> +    return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
>>>> +
>>>> +  def __str__(self) -> str:
>>>> +    return self.ToPerfJson()
>>>> +
>>>> +
>>>> +class _RewriteIfExpToSelect(ast.NodeTransformer):
>>>> +
>>>> +  def visit_IfExp(self, node):
>>>> +    call = ast.Call(
>>>> +        func=ast.Name(id='Select', ctx=ast.Load()),
>>>> +        args=[node.body, node.test, node.orelse],
>>>> +        keywords=[])
>>>> +    ast.copy_location(call, node.test)
>>>> +    return call
>>>> +
>>>> +
>>>> +def ParsePerfJson(orig: str) -> Expression:
>>>> +  """A simple json metric expression decoder.
>>>> +
>>>> +  Converts a json encoded metric expression by way of python's ast and
>>>> +  eval routine. First tokens are mapped to Event calls, then
>>>> +  accidentally converted keywords or literals are mapped to their
>>>> +  appropriate calls. Python's ast is used to match if-else that can't
>>>> +  be handled via operator overloading. Finally the ast is evaluated.
>>>> +  """
>>>> +  py = orig.strip()
>>>> +  py = re.sub(r'([a-zA-Z][^-+/\* \\\(\),]*(?:\\.[^-+/\* \\\(\),]*)*)',
>>>> +              r'Event(r"\1")', py)
>>>> +  py = re.sub(r'#Event\(r"([^"]*)"\)', r'Literal("#\1")', py)
>>>> +  py = re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
>>>> +  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count']
>>>> +  for kw in keywords:
>>>> +    py = re.sub(f'Event\(r"{kw}"\)', kw, py)
>>>> +
>>>> +  parsed = ast.parse(py, mode='eval')
>>>> +  _RewriteIfExpToSelect().visit(parsed)
>>>> +  parsed = ast.fix_missing_locations(parsed)
>>>> +  return _Constify(eval(compile(parsed, orig, 'eval')))
>>>> diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
>>>> new file mode 100644
>>>> index 000000000000..3909ca773ca1
>>>> --- /dev/null
>>>> +++ b/tools/perf/pmu-events/metric_test.py
>>>> @@ -0,0 +1,143 @@
>>>> +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>>>> +import unittest
>>>> +from metric import Constant, Event, ParsePerfJson
>>>> +
>>>> +
>>>> +class TestMetricExpressions(unittest.TestCase):
>>>> +
>>>> +  def test_Operators(self):
>>>> +    a = Event('a')
>>>> +    b = Event('b')
>>>> +    self.assertEqual((a | b).ToPerfJson(), 'a | b')
>>>> +    self.assertEqual((a ^ b).ToPerfJson(), 'a ^ b')
>>>> +    self.assertEqual((a & b).ToPerfJson(), 'a & b')
>>>> +    self.assertEqual((a < b).ToPerfJson(), 'a < b')
>>>> +    self.assertEqual((a > b).ToPerfJson(), 'a > b')
>>>> +    self.assertEqual((a + b).ToPerfJson(), 'a + b')
>>>> +    self.assertEqual((a - b).ToPerfJson(), 'a - b')
>>>> +    self.assertEqual((a * b).ToPerfJson(), 'a * b')
>>>> +    self.assertEqual((a / b).ToPerfJson(), 'a / b')
>>>> +    self.assertEqual((a % b).ToPerfJson(), 'a % b')
>>>> +
>>>> +  def test_Brackets(self):
>>>> +    a = Event('a')
>>>> +    b = Event('b')
>>>> +    c = Event('c')
>>>> +    self.assertEqual((a * b + c).ToPerfJson(), 'a * b + c')
>>>> +    self.assertEqual((a + b * c).ToPerfJson(), 'a + b * c')
>>>> +    self.assertEqual(((a + a) + a).ToPerfJson(), 'a + a + a')
>>>> +    self.assertEqual(((a + b) * c).ToPerfJson(), '(a + b) * c')
>>>> +    self.assertEqual((a + (b * c)).ToPerfJson(), 'a + b * c')
>>>> +    self.assertEqual(((a / b) * c).ToPerfJson(), 'a / b * c')
>>>> +    self.assertEqual((a / (b * c)).ToPerfJson(), 'a / (b * c)')
>>>> +
>>>> +  def test_ParsePerfJson(self):
>>>> +    # Based on an example of a real metric.
>>>> +    before = '(a + b + c + d) / (2 * e)'
>>>> +    after = before
>>>> +    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
>>>> +
>>>> +    # Parsing should handle events with '-' in their name. Note, in
>>>> +    # the json file the '\' are doubled to '\\'.
>>>> +    before = r'topdown\-fe\-bound / topdown\-slots - 1'
>>>> +    after = before
>>>> +    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
>>>> +
>>>> +    # Parsing should handle escaped modifiers. Note, in the json file
>>>> +    # the '\' are doubled to '\\'.
>>>> +    before = 'arb@event\=0x81\,umask\=0x1@ + arb@event\=0x84\,umask\=0x1@'
>>>> +    after = before
>>>> +    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
>>>> +
>>>> +    # Parsing should handle exponents in numbers.
>>>> +    before = r'a + 1e12 + b'
>>>> +    after = before
>>>> +    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
>>>> +
>>>> +  def test_IfElseTests(self):
>>>> +    # if-else needs rewriting to Select and back.
>>>> +    before = r'Event1 if #smt_on else Event2'
>>>> +    after = f'({before})'
>>>> +    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
>>>> +
>>>> +    before = r'Event1 if 0 else Event2'
>>>> +    after = f'({before})'
>>>> +    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
>>>> +
>>>> +    before = r'Event1 if 1 else Event2'
>>>> +    after = f'({before})'
>>>> +    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
>>>> +
>>>> +    # Ensure the select is evaluate last.
>>>> +    before = r'Event1 + 1 if Event2 < 2 else Event3 + 3'
>>>> +    after = (r'Select(Event(r"Event1") + Constant(1), Event(r"Event2") < '
>>>> +             r'Constant(2), Event(r"Event3") + Constant(3))')
>>>> +    self.assertEqual(ParsePerfJson(before).ToPython(), after)
>>>> +
>>>> +    before = r'Event1 > 1 if Event2 < 2 else Event3 > 3'
>>>> +    after = (r'Select(Event(r"Event1") > Constant(1), Event(r"Event2") < '
>>>> +             r'Constant(2), Event(r"Event3") > Constant(3))')
>>>> +    self.assertEqual(ParsePerfJson(before).ToPython(), after)
>>>> +
>>>> +    before = r'min(a + b if c > 1 else c + d, e + f)'
>>>> +    after = r'min((a + b if c > 1 else c + d), e + f)'
>>>> +    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
>>>> +
>>>> +  def test_ToPython(self):
>>>> +    # Based on an example of a real metric.
>>>> +    before = '(a + b + c + d) / (2 * e)'
>>>> +    py = ParsePerfJson(before).ToPython()
>>>> +    after = eval(py).ToPerfJson()
>>>> +    self.assertEqual(before, after)
>>>> +
>>>> +  def test_Simplify(self):
>>>> +    before = '1 + 2 + 3'
>>>> +    after = '6'
>>>> +    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
>>>> +
>>>> +    before = 'a + 0'
>>>> +    after = 'a'
>>>> +    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
>>>> +
>>>> +    before = '0 + a'
>>>> +    after = 'a'
>>>> +    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
>>>> +
>>>> +    before = 'a | 0'
>>>> +    after = 'a'
>>>> +    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
>>>> +
>>>> +    before = '0 | a'
>>>> +    after = 'a'
>>>> +    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
>>>> +
>>>> +    before = 'a * 0'
>>>> +    after = '0'
>>>> +    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
>>>> +
>>>> +    before = '0 * a'
>>>> +    after = '0'
>>>> +    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
>>>> +
>>>> +    before = 'a * 1'
>>>> +    after = 'a'
>>>> +    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
>>>> +
>>>> +    before = '1 * a'
>>>> +    after = 'a'
>>>> +    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
>>>> +
>>>> +    before = 'a if 0 else b'
>>>> +    after = 'b'
>>>> +    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
>>>> +
>>>> +    before = 'a if 1 else b'
>>>> +    after = 'a'
>>>> +    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
>>>> +
>>>> +    before = 'a if b else a'
>>>> +    after = 'a'
>>>> +    self.assertEqual(ParsePerfJson(before).Simplify().ToPerfJson(), after)
>>>> +
>>>> +if __name__ == '__main__':
>>>> +  unittest.main()
>>>> --
>>>> 2.38.0.rc1.362.ged0d419d3c-goog
>>>>
>>
>> --
>>
>> - Arnaldo

