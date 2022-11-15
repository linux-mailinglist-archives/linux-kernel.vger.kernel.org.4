Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3A629733
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbiKOLUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiKOLUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:20:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676ECCC5;
        Tue, 15 Nov 2022 03:20:08 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFAhpFj005438;
        Tue, 15 Nov 2022 11:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BM4j82h7mzxCoI7jy6KkItub0b7ny8U08wAwWD4y1H4=;
 b=qM/l0PUStS1waB+mqp3J+5uhI0l4DWvadLH0tS3cEeew4IdDYS7f2KWPxpcLNVM5otJr
 6sgDvpBY71QkdMUhxj8nTbOaWifIrrTXh++QNEOxadWyhBTXA4qnaGpWWBASeRiD4jTy
 J/CqeWlHZvVhz2rtG8EZ+eKGDP1SHM4b5N/7i3++YCVYISkoUGXpexYL4BZ/lbIRjxz6
 Ka2rUJk5B5daf6zTlxNv8aLqABVxokxl9YS8bkQ+NFILdepBSSk2saWRHRzDvcU9o2Px
 uFDcwMC53M/Eu3SdKjofd5TlAjy+6ShBjeL+v1qhIyUqBPlOlAZaBN+N3JBoQiyghI34 Vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3htrx9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 11:19:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AF9aF58001423;
        Tue, 15 Nov 2022 11:19:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kuk1vf49h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 11:19:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJh47d7F5QGlYqL/CXQ3d+MPvqp8DkrThVQ+6mfTwOapHx6V0pVGuOo0DPDnaSOGngXF8sVtF/kmtyBHhdRED3tBQoOp5lZ+Vfp0PdFimwqv4WpUKmEq8wTUAqmJ+u5Q/Ybd/xWKVBNfZ6KemdgZwL4HDSq1aKeQBj7E6aSJQk4akXrpnW2lpzsZIUHG/9dj1QUDUxoWpYT+aF0/Bsqi5W9X5GHuM5lKWwv/zEIsrT3pFgqKMcoRYnZgSiT0kI9DfvGxF01IZnFvWlUGGzEXxh0mtogRvRRD2wWAkvDOn3s3l1YCZ7VJily8AToipAnX75CcIYavXyBskJ6mUWUHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BM4j82h7mzxCoI7jy6KkItub0b7ny8U08wAwWD4y1H4=;
 b=R/pgaWuVP4wFgTgK1bATtPxeQpnFwT9+4wc0kYL9hbUNRQG2d8nclvZz0zsk9Ubh+TL2Xw/4IhtLNhG6iZXe0Hn54Q80xrSTLTomk54mGAgE4xbaOA78InrNQjGO6ma3HB7o9kIbwTxzgdh9ZJdRxDP8YxXHT3W7mj5lEq2MC43Wk3dZ9O4AmxUsEzUg/jSzj0ThIJb6kj9PKJUpq66tUY0iWtOtlV1dddtior+zeFqT6wiXt0UYu8Grv/JMWB4iNnuHqSQtPuL1enrENfzF4m3OIW9GFG6oNi75ZQXhOzpGr79+vVmUfLdWKvsuyGJeQiHiQgbrd2xBlYK8miQLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BM4j82h7mzxCoI7jy6KkItub0b7ny8U08wAwWD4y1H4=;
 b=aFASFJ8Tov1ZNSMXMve6GKAq739oIBIk2jRSXb6XOf13edwEmCdB2cpabFHkbCuO4HKayGlG32uZMghnEtvB9ObCEQ/p+2aAuqTThOkmVlCyRjT2YzebeAnpzf7A3kqoV6M5qNFCBCJn1t7quaMOUb8NVtKfzbv4AnPTXSi0W+Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 11:19:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b%5]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 11:19:23 +0000
Message-ID: <f6e26e2d-2f10-e973-6c9f-47594da2fc99@oracle.com>
Date:   Tue, 15 Nov 2022 11:19:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [External] : [RFC PATCH v2 1/6] perf vendor events arm64: Add
 topdown L1 metrics for neoverse-n2
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1668411720-3581-2-git-send-email-renyu.zj@linux.alibaba.com>
 <590ff032-d271-48ee-a4d8-141cc070c335@oracle.com>
 <f3823c3e-d45e-40ce-1981-e726b4b6be62@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <f3823c3e-d45e-40ce-1981-e726b4b6be62@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0038.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e0994c-6a7b-4688-6dcf-08dac6fb3fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Yoc5k+rVGEmQm1Z5ToF302Z1POrJtHMzMirI92Hf1P0QrTxKPNLY0FYZuoQl07uWYMBMoGsJpFXjIomOS0GLilFf00r472IqlI1/AqsZRHAcv9Broagu/7iVzOJtO8Xes7WXtOFLWbO4tdFcsmo+lX0ikuQ+4hOsHIQHQBeYkHpr3LsAI3BY/+LBaFPglg83W/MQ68rvNxcy4yNWZI2rDNniE6xKGP1BrbsVob9HlsZ8347nT5f8vNhP5e2ut3FdETF4NTkJ0ukRjDu6jV3nnvXDPdjLXgec57XfHjZHQXGr/KGlFVzvWELxy0n/JKIEwdADXgc7/qtPkJmalLDtrgFh2zl84JnBWjRHiPIAKEOWr4/pvGrizg92H142oZfJBlm2ddbeDmd74yrisxuSCMGikZwyIAlZTOWB0T4QVY/HJa+R8w5qEqj7z21kye3dYMrgPyamYJSS6QodPTXXPqS4E2CIncGobjXvGaAOGLvn+1PT6DcOpEeM7Td5ag5hrmuRjn/eR9ih/74B7Vkzwm+6jS1CPCb7GkrAUtIvKzT+o+KRTiwVqEE9ZbBg5qIMreD05+M0adYasmNGxluBGYbylY9gN89Gu84jZCsqH9ZJ8L+BQ8HwQTAG3xWJqGA5032p3FoAICGF1Up51WQbUaP+EFCw0BDs/1YaQHIlnDxELQAWONz4jjNBhUq4TRlR/9wWTAvehvD5n3etHFfFt9WldLK9Mxdh4LAs6qr9BvDhQiS6Khd7SLibCYhABVQ8kEi2E6yYIv1s4x7+GftQ/jsl/BL4vjsAO5KvFMp6A73V6Z6xTsuTD1E/pqVegCh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199015)(6512007)(26005)(53546011)(316002)(186003)(8936002)(41300700001)(8676002)(66556008)(4326008)(66476007)(66946007)(2616005)(36756003)(110136005)(54906003)(36916002)(83380400001)(6506007)(2906002)(31696002)(86362001)(7416002)(5660300002)(38100700002)(6486002)(31686004)(478600001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVJLK2d0aGx2YldnY3QwRERXME1Hd0k1MER5cHZDeVp6RXZmWGRtR0VjK1RH?=
 =?utf-8?B?ankxd2JiaHFnUzR1RW9MVjFXYnVEZFBmUXVUV1RtRG12d0NFUWsrUzBKTnRp?=
 =?utf-8?B?MTU1ZFVHWmpiUGdVUjJlOURjZjJ1R1FPQjFCay9XdGpkYTQ4VHJxdE1lenJy?=
 =?utf-8?B?YjNxQnN1aFNRN2tXeEZOUHdRMkFZQXNZS25OVEh5c2trWFY2Y2l6RFZTWGZG?=
 =?utf-8?B?eGZJY3o0ekMrWDJFV2RPNVR0TFhuKzR3MjY1ZWcwaHAxaFV5RVZCT1hQN2FJ?=
 =?utf-8?B?VHRTUWRRUzQ3YjlNak5RVXQwQXl2bnRIUEhhNFFkYzZjUGdRWFRNSnhJdG11?=
 =?utf-8?B?TnpxbldXMnJBZ3h0eG1TNk13MjNKQnY5RWMzMFRWSU56UzVnMTl4aVNqdXlY?=
 =?utf-8?B?ZnJQa0c5VDRqbnNidE15Yjcwbkh4dGZCSkRJYWhGNlhYSXhLV3FrRENBNWs5?=
 =?utf-8?B?YUQ0ZkZXYlVZQzduQTBpQkVBMFljMm5vWWRVdy9GK1NnRWUwSHptRjNhNEh5?=
 =?utf-8?B?N045TERpZHFwY1NnMjJJWlFaMmFJcHA3WlZyN25KcDVpRW1tanJtT2F3N0dY?=
 =?utf-8?B?WXVxdW5mU2NPWFNzeW9LcVFqcG9GWnRBWjV4U0k3K042enMxditOY2pyVC8w?=
 =?utf-8?B?amtvR0dYNDhyWG9sSDh0U3NZTlBaLy96a216WHp0YjdLVkJXcDNjS0hCTkk5?=
 =?utf-8?B?RlRoeURuTXhqQm9HcnVraDVwNFI5TzkxUjVxYTh6UjFLL1plM2VLTDlTYUZC?=
 =?utf-8?B?UlpEMEhGaWhQdERyZG55WGFqRTJQa21JUVl6MWRUbUdPSjRMQTd4YWRRb0cv?=
 =?utf-8?B?dEoyYWw3bVNtVUxPSkNRQ1UrT0cvOVkvRTBZWk5qSEllQU1CaDM3SE1KQ3Vs?=
 =?utf-8?B?czZmRm5ubTAwOTh2Ly9zZ3EvVXBxS1czUW0wQUhrMDdWM3RWSFNzWlp2NFND?=
 =?utf-8?B?aEE4cGt4ZU9BZHNTT3lMWk5ZMzBydCtucW96NHExVFNiQjBoL2RJdFl6RTFl?=
 =?utf-8?B?bk1SNklpOFNQTUxETVZPVjRqSmZ6Nm4vb2VqdjBQbjdaNmFsTEtYSXVHYU13?=
 =?utf-8?B?TDh1NlBLUUlEZXVCaVdWWU1melJPUE1ZOUl5aGNVTFNFRS9PWERDcDFMYjIw?=
 =?utf-8?B?TmRneHdteGFNcmRSdnF4ZFgzZnRJc0NJNFc1MS9Db1M4NWY4R24zc0VyMmM2?=
 =?utf-8?B?S29ENFBBYnN0TnVNQm9TMVdHZ21aem5ob1A5UnJ1YUFWakpSajZjV0FKZzc3?=
 =?utf-8?B?cDY1VkhTL0V5SmptekNPc0pJNnBRTURTTGUzcy9weENGM0M0Tk9neXF5bDFu?=
 =?utf-8?B?V1R6U3Y2Q2FIZXI0T0N0TGlaeUZNbytYSmtwRWdrVGl0eXRuVG05djRQaC9m?=
 =?utf-8?B?UkJ3bEI1cDNneDd4T0dPc3Z1NHAwcHVkYzNHU2hvQXliYkFSQ3ZnMzNOWW9k?=
 =?utf-8?B?UkFrTm5IT0VSS1VpRUJ6SjBiVGxNL1h5clBSQWV1S3RGRG1IaXBLcXRISUtR?=
 =?utf-8?B?SE5UcmdnaDVHK3pEd0NSMEt5U1dVMktrSWpoenBPZTk5WFNvMlRvUE50N0Rx?=
 =?utf-8?B?RFNxemhTWmhERTVZUks3NGRsbUxxZU5Md0tBM2VvRUp0MlBiNnpmSmhpWGNC?=
 =?utf-8?B?NTRHQXBIRCtWTzBaTCtMQ2VLMzZpK2puM1Jhd2RpM25CVVJuYTZqajZUUWpo?=
 =?utf-8?B?K2puNFhKQVhhU2ZQZXNLTXJsVzRGYTViZDFROVBsTFZWbGwvYUV4NThHemJm?=
 =?utf-8?B?VFFWVG1OMXFyTlRZN09WeDZxUXBOM0JpaHdiQU44RmhUZFdwcEUyS3MwZ2lZ?=
 =?utf-8?B?NmwyVkgvM1RlSXp5NlZ1ZmUycGNXcEI4SlJSeXg2S21wcS9DN2RacWVBSE9l?=
 =?utf-8?B?aWlTOUdWMEVvcU8zSjhza1FkdmpHOE1GakJNdlIwTTczNWw2NStGcVlJcVBU?=
 =?utf-8?B?TFVJYUpoeXYzMHpiSm5ZNzlDMkRGMzBESlNoSlY0cXRuZm1qcXVYcjVOZlRO?=
 =?utf-8?B?M1RFRHNPLzY2U0R6WDYyaUlLQ0VQVkYxaFQvQkVFY3I4Y3lVQlVYWWFWTXRC?=
 =?utf-8?B?QXV2bVdhWVZ4eFdzRWNnS3lVeUdLckY2ODBtRTV2RWhkazNaVHJDbDl1Uld5?=
 =?utf-8?B?amFtZHRMOTRLOXZ1SzNoK0xUbEwvUXovQitRNTFoWTdvYXNUQ1Y0SFlRb1VQ?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aWYyU1p0eEtjUGs1RHVCaXlRL1RhVDYxb0djSHVzMFV4a3IxdWRub1JNSFdE?=
 =?utf-8?B?MDZ0ciswQTFQWEZjRFZFakFwZ2QyTjZZaXdoN0s3Q3JLMXlsbEx1WDMyVURu?=
 =?utf-8?B?NHlnRHEwQ2NjdEEySUMyT003akRFOVBIQVdFaWFzQ2xucTRkNmtaUHBaOGd0?=
 =?utf-8?B?aUJhQ1NNZ2g5Q29CWjZ6L1hjcVdabEh1emtDK2JuVmw1S3VXbG1KVUpqMlhI?=
 =?utf-8?B?ZkgxREhDeHE1ZlJyeVBFd21Dc1RObGovdzBuMk9PRmVEWGFvUGhLYVVuVmlU?=
 =?utf-8?B?MXlsdXFyMTNFZS9ONUVFeDZGK04zUWY4NENSS2xPLzFoaDk2dDdsYnVFdnBL?=
 =?utf-8?B?WS9SQTJ3eWNzQ0ZzQnNBQ2VHVXdaNm1TbkJIbnp4RHE4SDFEZERjUmRuSVZC?=
 =?utf-8?B?S3UydHNWSjk4a25NU2Q4ZG9kT3FRaytUUkhvankrbVluU2FOYjZPYkJuLy9n?=
 =?utf-8?B?ZzFsMVNYeGdXcEZlMHJWTFM5NTJyYUZQY1hOZmNYNG9xZ2xtNUJyUVNqWlFC?=
 =?utf-8?B?Y2d3dURrQW0rRDJ3K3FsSFhZWm1VVUt4Wk04Qnl3eHg5ZkN2bFBONDhwWUlu?=
 =?utf-8?B?RlA2MTNuZWluTXl2V2JOcktvVDZCc0JkRzRmdzZJN20zOHloM2ZyalJFT1lx?=
 =?utf-8?B?Nm9TNXM2QmdRYURFcXgxcFpGRjFWL2VRWXpCY0R1cWoxUVZGUUdJc3dieGh0?=
 =?utf-8?B?OE5pbmtSWmdIMWhKa01SNjIya0U4eTNSYWljWTE1WUhHM2Y2ZlRVV0lycVJM?=
 =?utf-8?B?bm9sWXY3eDg1dHU1V2hkbjVOQnlJN0VYWDJrc3VoMHBualU2UmRPU1RPUTVj?=
 =?utf-8?B?Zm14VmxPRS8wbTJoTmpSenVNdzQyeEVSQTM3dTlLalVyZURIMnAvbG84NmFs?=
 =?utf-8?B?cEU1cS8yTzU3dE54S3BmZzhtaVg4ZGZHaXJ1UGxyVmV2bG1veUhZeUpiODFq?=
 =?utf-8?B?R0VqVmUrRnNIb2d5V3lRSHJsa1NIWFlNb1BHcm9lbnRvSWE2ZndFUjlxN201?=
 =?utf-8?B?YzB6d1FWME1jN1NmanlJUjlHRlVSYmZJcTNkaHhwaElGWVl0eGZGWldzU2RZ?=
 =?utf-8?B?RVdQYmxWZ3JsVFdNNndvN1JKaEUybkYxM2VDR0d0SkpkNm1FRTN1MzFJczdh?=
 =?utf-8?B?TVBSVWQyZVU2MVNpTTl0L0lleUM0ektiSWpidWdMaEpBSjhvandJTkJWSk1J?=
 =?utf-8?B?TkM2a0dmZlZUUDl2eVpwYTF5ZHpHRE9TKy96RjZDL1ZlMUJDV0FUU3d2WW5r?=
 =?utf-8?B?UEs3QUdidW9maDE2bzQzN3NHWm5taUprWGlNeEtzaHFEUGVkZUFtODhjVUtZ?=
 =?utf-8?B?U3cxMmdDYmEvVjZSK1hPK3BFa3E5Rlh1Nk0vb3dqNDAyOVQrU01ZdG5IamlM?=
 =?utf-8?B?YS9XYURWbU9PM3NkNGh5djlEeWtoeGJlRHFzOXh5VmJFdUFHR0g5Tm9jZlpY?=
 =?utf-8?B?SjZCK2VHUmpnRW1pbElzL0phRWMwcFk5WkIvZ21vQnlXQ1Z4dkZRdDAzU1hp?=
 =?utf-8?B?akpFYzFNck8wMjFDRi9GRFR5RWJwZmtBcmpaT3lzNGt0SUVJdG1oeDVSNFlv?=
 =?utf-8?B?Y2M1Qlc2UmNpSVpRWG84RzIxc2Nra1JEOFAzQXo5Y0NtTE1maXhkMEFqTXRL?=
 =?utf-8?B?OXVkdk4zMlZBeURUeVhkYmNaTDk1Uy9sL0hxaGxFYmRRZVd3bmJxNzk1QURx?=
 =?utf-8?B?RjJUZXhXWk5PZ1hManNKNUplKzBLTktOL29aakQxaWZsY1N0ZUJsU21jeTlD?=
 =?utf-8?B?RFAwRzhzS2NmU2l4OVVLT2ZYL3pIZ2FTc3QycEVtS21ZOVFvV2UySm94SDFZ?=
 =?utf-8?B?RkxKNTdQQWV6UElmejVmNy8yWnNRaXFkM2JlREZzMU9oZ2VFQVVHLzduWHhY?=
 =?utf-8?Q?OHt1ZN29dXWpl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e0994c-6a7b-4688-6dcf-08dac6fb3fdd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 11:19:23.8944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiF9oH0U6xd9WJTgyph9HA3QkYcES8J4bkkNalrdWhOR2KwdLoIJTFY1C/RtwPWuNKKsQENwit8x+46yie3+6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_06,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211150078
X-Proofpoint-GUID: AHBxx_4b_ckUljj1sDHTv_vIrwBwkcVz
X-Proofpoint-ORIG-GUID: AHBxx_4b_ckUljj1sDHTv_vIrwBwkcVz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 08:43, Jing Zhang wrote:
> I didn't find out how to put the metric as an arch std event, it would be best if you could provide me with an example in the upstream code,
> thank you very much.

As things stand, I don't think it's supported. We only support regular 
events for std arch events (and not metrics).

However we could expand support for metrics.

For the example of hip08 and FRONTEND_BOUND, we would have:

--->8---

diff --git 
a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json 
b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
index 6443a061e22a..5b1ca45224de 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
@@ -1,10 +1,6 @@
  [
      {
-        "MetricExpr": "FETCH_BUBBLE / (4 * CPU_CYCLES)",
-        "PublicDescription": "Frontend bound L1 topdown metric",
-        "BriefDescription": "Frontend bound L1 topdown metric",
-        "MetricGroup": "TopDownL1",
-        "MetricName": "frontend_bound"
+        "ArchStdEvent": "FRONTEND_BOUND"
      },
      {
          "MetricExpr": "(INST_SPEC - INST_RETIRED) / (4 * CPU_CYCLES)",
diff --git a/tools/perf/pmu-events/arch/arm64/sbsa.json 
b/tools/perf/pmu-events/arch/arm64/sbsa.json
new file mode 100644
index 000000000000..10b9c0cccc40
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/sbsa.json
@@ -0,0 +1,9 @@
+[
+    {
+        "MetricExpr": "FETCH_BUBBLE / (4 * CPU_CYCLES)",
+        "PublicDescription": "Frontend bound L1 topdown metric",
+        "BriefDescription": "Frontend bound L1 topdown metric",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "FRONTEND_BOUND"
+    }
+]
diff --git a/tools/perf/pmu-events/jevents.py 
b/tools/perf/pmu-events/jevents.py
index 0daa3e007528..77049853c0bf 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -352,6 +352,8 @@ def preprocess_arch_std_files(archpath: str) -> None:
        for event in read_json_events(item.path, topic=''):
          if event.name:
            _arch_std_events[event.name.lower()] = event
+        if event.metric_name:
+          _arch_std_events[event.metric_name.lower()] = event


  def print_events_table_prefix(tblname: str) -> None:
-- 
2.35.3

Note that this is for illustration only. The frontend bound metric for 
hip08 does not really belong in sbsa.json as it does not adhere to that 
spec. But for platforms which do adhere to the spec, we could pick up 
the metrics values from sbsa.json (or whatever we want to call it).

> 
>>> However, due to the wrong count of stall_slot and stall_slot_frontend
>>> in neoverse-n2, the real stall_slot and real stall_slot_frontend need
>>> to subtract cpu_cycles, so when calculating the topdownL1 metrics,
>>> stall_slot and stall_slot_frontend are corrected.
>> Is there a reference to this? It would be indeed useful to pass a link to the n2 doc as these metrics are not part of the arm64 arm. At least I assume that they are not there.
>>
> You are right, I need to add a doc link. ARM has released the n2 ERRATA document about the incorrect count of stall_slot and stall_slot_frontend,
> and provides a workaround to get the correct value.
> Link:https://urldefense.com/v3/__https://developer.arm.com/documentation/SDEN1982442/1200/?lang=en__;!!ACWV5N9M2RV99hQ!I3rCI-RcuDmpfAiWhA_SAxRrq1hCyhA9am8YmrwizljPz9X_G4H_odm_4aRgRo8VswDeC3TATbylxf_vhAJhWbJrlw$  
> 

Note that std arch events support is such that we can still overwrite 
individual std values in the platform-specific json (or at least we used 
to be able to - I have not checked recently). So for n2 case of 
stall_slot, we could use std arch events in the n2 json but overwrite 
the metric expression, like:

+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
@@ -1,10 +1,6 @@
  [
      {
          "ArchStdEvent": "FRONTEND_BOUND"
	 "MetricExpr": <insert n2 specific expression>",
      },

Thanks,
John
