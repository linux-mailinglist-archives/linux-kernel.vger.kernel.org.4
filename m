Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648CB6428D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiLEM5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiLEM5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:57:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084361B9F5;
        Mon,  5 Dec 2022 04:57:16 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5AOvgP009864;
        Mon, 5 Dec 2022 12:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Lg6UAlrRoH0kTAEncMyTA9BE/CL9TeCED7KFirob5hw=;
 b=ScD04uUFA49zLBlwJngy2rKBdWORmvRUwP+ZP8VKq7+pC9v6Ed/VtzxsYclxoV8vz95M
 V5Atq/Q0cK9meiL3iJ34+9Um0ZVh+S4txgRiXAV1CKYmlgeUOyuBU6e4gs8M1BPVgEn5
 /LVFHzrYstCSAwLwGbpDt7G/2cV+jFXbb2E1BccoZmO89H8d/rmUpVOYsRTflXcjN9HJ
 UXF0TSD+qca23uVNgiWkUhndt6Qsg/DTDLns3cb/ItvrXBsZZ6q1Y0AS5Eheo9r5ewYz
 Mm67GQ882lD3gmPG/XR3L3AYpZ8CgjoliXxTqBJ85G2c5HxMU7GGfnpQHqaI0a2bLzYp OQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ydjbrbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 12:56:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5B3uTD021930;
        Mon, 5 Dec 2022 12:56:52 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8uge2um5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 12:56:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALmOhWk5fBTJxpnw8OpFS2zk+olISR+I+uBbheF7LJ9g+HyumKhQpMSY8W+hX5dxO7dUN9dyA1b+yDA9zjdd2Q3FG9kX21/igDWyzQMTFqLt7B784Lh8p6WvngEiSlSHwfoRe7CZaC69vqRqimVPcfn8eOjT85AAjo72vCvL+pUA8LgZPstUvkJ6H1t7HWfIKMSgqb8WbJ+hBv8a/BLHa0LE+p6I/c4wIeN6rhTtRN3TIpkrOtsDOXuZXzBagkYntkxNAKzyjrSu2tPgjjgPGVIYLlRDXz314ld33dHwy/4+PP4jKXgEHA5AMwJXa0Zc/2wufN5YERAfu3nQVxf8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg6UAlrRoH0kTAEncMyTA9BE/CL9TeCED7KFirob5hw=;
 b=NSBXgr3XfAT9b5Idc9bgQRemcoepD/TD7jmXioWfoZwBzT7CJ7qsyQT4amCHCP5J1SCvJMjhOucB+qU63iqEAAStncul9aum4aOMC09Aujpg28GtgYypk8dAv449XUWD4bAyQvkh12t5RzIytYtgfF2wFmbeYKPn2LQ/v63ciR8XCMkq1TjSW0J//OpDxI+VWvRZ2BdU/sDONyg0DE/BSLo/ZlA3W7l4J8IIDKHTtXE/vUOADNobASQfn5IqpZvGFUZucl3SdsAyRBVB7N3zNs//Pz5k8QChflKUIdaEcyzEpKOw7zpwU8xuR7OxCmMu/k6688vD3y4XofWL6IEPFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg6UAlrRoH0kTAEncMyTA9BE/CL9TeCED7KFirob5hw=;
 b=lrRs3Zou87WqB9T9lVLjaelcRbLt7Z9WAPsHQno8gO1+VJPhaB2A4kbhcnU2zI0c4gdARWAkFAqIoXWyb5GfDS8hRxplAZ23exZVMXF3aM7R8+VXDGaRK7v0DGzv2mNBhjFQm7uEg7zQTlHbYRxMYEFR+5SOck15ynio+BlN5nc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4514.namprd10.prod.outlook.com (2603:10b6:303:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 12:56:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d%8]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 12:56:50 +0000
Message-ID: <37acb14f-0535-c26f-4bb2-c2d7cb43c2d0@oracle.com>
Date:   Mon, 5 Dec 2022 12:56:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] perf jevents: Parse metrics during conversion
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
References: <20221201034138.417972-1-irogers@google.com>
 <Y43p4Xmitg7dD1B7@kernel.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Y43p4Xmitg7dD1B7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0587.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 32864a5c-eae3-44af-c159-08dad6c02ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KSwVxmkvcQgWxHvg7HJpYf2xOlUoBOWHGC/C6fO8Er+kNhJHg+GypFzbpehYSWdy321k37FeyP6l+eGVvjq/ZHami4Tf1FaXrp1Yuer1LKKiQRtBsn/NlTSZEdIkbiXNkEg0LSVL8jkmwUG2peHy9OFTquL+0xlpczyjGB5UqDSXwyP99Sdof84kW+y9boiHkQ8fDX+p4FqMMGU1L/3MAGR5yiyRavdmAXxBBwcKLxtoWAIjNVura/P7gxAYpaAZ4lE+mcg0T2KD2C9q1l5y8/NzgMcfFAquFIAFYwQmusGvkaumkJ6YxVjHiUnstEzqe/E0r6RW6xciDpXN8RZ8Lr4ZTpFtvSosdxte9juZJfGwMHeu6+GG7oYvVZnoLlANFYkyg5Kr5OPk2RxX+OHUSBFYkow8h21JxuqKFgAklgLG2TxP4ZKuOYvga0Qu+RzDI3egDh+4wcGF20iCDr+3fkDvIWf0EdxlknZ+zVllh/QhqtpXbljxXjZ3zj4rBhe6fQVd+2AW17DHMTmo/T3NTcAosfP7cB0DoPWDRXgRo3gqZJo5sqUkIdF1SMlqiHVyxIdhE0oJ0cHQaAwKslsMY5i935sqwlrShQR1M7KWxUNthZ77VPobnWDdGkaLlO5x6CWPNkGwOJKUWlyNftyOZVqdG3HuLt55/FJb3Qmew0TTN4ONAGA9kpMst5YK6e4Fs58TzDjtbmHh6L0Sh6+LSSPnwhbEP/DYSLNtEiBSSGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199015)(31696002)(86362001)(66556008)(36756003)(186003)(41300700001)(66946007)(8676002)(4326008)(2616005)(66476007)(8936002)(5660300002)(7416002)(36916002)(53546011)(54906003)(6506007)(6486002)(478600001)(6666004)(316002)(26005)(110136005)(6512007)(38100700002)(83380400001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWVhc3JzQ3Q1K2hKc3hGenVwOWVlTmEwcmRYdkkvM2xXTUFma08rQVRZcmI2?=
 =?utf-8?B?U2pNZEVOVjlZVnZYaEppMWZmUkpPKzlNb1NLVUc5amZMU3d6WDNXSmN4SG5y?=
 =?utf-8?B?OGlOQTFDbW0zVnBJNjBadG5uNDRuQnJ5dU84cDR6MDRsL0VVcW0vQlN3UU4v?=
 =?utf-8?B?U2lKMkRGTmwwQU5IYVRGY3ExRHNtbjBoRGI5WjVQbVgzNW1OWTFiVkVqUFJV?=
 =?utf-8?B?R3FJcHVJNUNFWm1FbzJ3VGtCMHlDQUlJUnJ1ZVNvdFA0ckpjREE2WkpLWVRF?=
 =?utf-8?B?RXh6NG9iTlB0b09oQWd0N3BlMy9GNXlXcGE5U0ZOV0tXS1R2MVRNRlo0bzNW?=
 =?utf-8?B?UGNoSU95TlUxUmYvSkw2S2FFWk9lMmQ4SWRDM2xPZ1czdTZvQUNDajZ5c0Iw?=
 =?utf-8?B?ei9JRmUxbWNqSThEMGg4N1BZRm1iQjIyUXQyY3VOeEJPOTVNTEVtcWVsUy83?=
 =?utf-8?B?cUV4aTFmd2ovNlNLSzBlVTJ2VlErU1NRSHBKTStHa09Ja2NVK3FDT09pRUdZ?=
 =?utf-8?B?UkkzQzd2L2FQV054VDR0ZTJRU2gwTUpORnVCbFNxdUdHaVF5NnVNMVEydFk2?=
 =?utf-8?B?cVZ3Y2N5R3dxRFgraDc2QTBmdGNRcittUThoZzFZVmhsbWQya2tjVndwaHo2?=
 =?utf-8?B?aFFIRjI1OVZYdHdTK0FrVEEvVUorSjNZS3NjczdGNEZib0lFMVUvdjhJM0RP?=
 =?utf-8?B?WGVKS3hNbG5pS1lraG1BV2g0dUdKT1R3Wlh6cDh6dkZwaHBGTUUxNWwzbCtn?=
 =?utf-8?B?R240dk96Zm9mN2J2ZHd0NHlQYS9EdUJSbzduelRWMURDWkcycExCVzltd2Rz?=
 =?utf-8?B?K2tuN1cyS0dYU3dIMkloVXBWcW13UE1CTTJzVkFna05MMEJ5SzZjRzFCK0oy?=
 =?utf-8?B?ZitlZkY3YnJRQllIZWc5WitaVi9SVEI1dUF5WVZuTUtuc3lLTWtoYzl5VjBV?=
 =?utf-8?B?bDZNM2hCd2lMT3hMRXpqRHlDVFVvU1lOekp6dzVGa2xZcHBaL2hqa2oxdDJk?=
 =?utf-8?B?cWFJQXNqRmo1N1FYOHpkRE44ZDBIWE0wR3I0VXl6bGhQN2J4MHliSkY5UUlL?=
 =?utf-8?B?TWhBbTYwcWlDRkg0THdqWWNaazY3SzVia0pwRlQ1TzBVSnBPTVl2QjlMZTAr?=
 =?utf-8?B?TjZ4UkFUbEtSR3dQbWM4RHF1U0NidHZNRFBjcnVTOFdkODM1UnQ0RFpIcHNW?=
 =?utf-8?B?MlVIeDhYeWUycGVUZWdleXFuZVlDT0xnaGVMT0VhMEZyY2ovYWdtSitEOTIw?=
 =?utf-8?B?L3kzTzJhd2hsbHN2L2tHRXg4NkkwOUM2YTlIL3J1QU9VTFVtdGtLdkJjdGF2?=
 =?utf-8?B?bmNmTTRpZHFOdDhHTGFMQ3d0YzZRSzNaWjY0N1Qza1R2VE5iR2dSTXZxZVRu?=
 =?utf-8?B?WTJHM01zMmpBaFFHQUNlWEtRRjlHQlduMUpaWjAyeTIyRDZ6MGw1TzVyMHdT?=
 =?utf-8?B?Q3VSWUhwK2lmRzFPVWVWZEo0VzBXRlZOSEZrUFMzSlc3enpOREVKWlRjczJJ?=
 =?utf-8?B?K0NSOEhGVXhPRlgrSnlzWnZxS3N1ZEY1bi9UQVg1SitVaW1xdmdrWHdMUHBa?=
 =?utf-8?B?YS9FQTljcjJrblNFbWtaUHMxWUZtTlZVVVZrUmxkOVJlZ1NwelRDUTFaUFh3?=
 =?utf-8?B?dzl0Ujh0bnFpZXp3Y3V5NXAvNXRaZnhNMjJDUm1YdlZBZzBsSlpWbzJaRGhE?=
 =?utf-8?B?QVQ2U3RSV0tmS0luS1poTVk4RnoweUN3blRLK2NncnZ2NkorczV1bVcvbzFr?=
 =?utf-8?B?NnRSOTlPSHpaejF1WXJXeG1wTW14dXhQR1VwNnNFNU5xa29ZQkRUMENCSERh?=
 =?utf-8?B?V3BSTTJ4ZlVaS3hITmIvcml6QUxCVEtqdHZYc0VMUDdzN21KbFhzdnFibDl4?=
 =?utf-8?B?a3NhWDIrTWtKcFBVcXlVWHVycVVUN1BobjBtNjlmaEEzWUllSzJ3WTI1ZWJW?=
 =?utf-8?B?OWV4N28vNzRsSDFOZkxJYm9hYVQ4ZkJ1aHR6Y2JTYkZYblFYZmZhdGhYbmVX?=
 =?utf-8?B?ZnpBS2VTSk1HbmdYWGp4eHNPY3BKRGUwZTFjZEhNbmNDN3ZLUkNQdjBhYi9J?=
 =?utf-8?B?d2s3RmFpaVI4bHRNYnV0eHE3TFZoNFFQMFFnNzlZZ09TbkV5K2taOEtVMmhu?=
 =?utf-8?Q?MynzmS7OAbaIrldFla1LZ1Jvy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NGhXZUFxMWpNNENCN3FzeVFsUno1dmxXODJlMDVseGVOM2lzYmhqYVcwWGMz?=
 =?utf-8?B?Vy9pWFI0TVNJbmtrcjllMkV4RU03Q1grVVIvTy90THpTUkZkZWN1dE43RGRO?=
 =?utf-8?B?bnRkVlFtV3FINVhSRE9EZVd5QnhZc2d0WHFEa2VoRnQrdVNFUVVtYXN6YW0w?=
 =?utf-8?B?NzhJa2ZuUTdETjJ2c1RaUExjWnFsa05aUUZNQ0ZKZXhYN0Jpb2VqTk5oRFZl?=
 =?utf-8?B?K2R1bENVMThKQmU2bElCNlZJaWxKUjF0K1lodjBaTCtGUWE0VTA3U1FidGw1?=
 =?utf-8?B?SnRxZ2xFT1djN0VidG1oNzZjODZBRTFITzM1em9YSGx3RCtVMVVxYld6eWlX?=
 =?utf-8?B?UTBuNEZyK1NUdW5kalBGMTF1cENYaGduZVNxekhKMUNWd0J0dnhzcDZPZlZN?=
 =?utf-8?B?S1UyVVBFWHJHbllJYXJ4cVRDNzYwbDY0aGo4L3U3S2FkK084ZFhSMTlNMkhv?=
 =?utf-8?B?RVJkZEV4OU9KZC9PY0xLbWdZWDhLdkUrTysrK2I4SkxhTnZIYk4xWFd4aGxY?=
 =?utf-8?B?d3RFSSsvNVVSOFZQMlRPNXZabGl4QXg3TkNLb3NvSkNMSGFPblE2Um54d3NY?=
 =?utf-8?B?YlRmMkRXYUpDQXhDMzdpbFVYNzFXUjlUNFAvR1dDb3VPY1ZQV1ZLdzFYakc1?=
 =?utf-8?B?K3h3UThQUlNuQVBKWG83K1BLMnpmaFlqRTZpSlFpdUZmWU42cGsrUi83VHFG?=
 =?utf-8?B?YWtHaHlBaUxPN2ZlTWNTcnJVWVI2d2JqdXpuaE9zcXVsUllCWWNna1NaWVFo?=
 =?utf-8?B?TXI0a1ZCcFAzNFFML20vUlF0a2laenZWSk5tVUdrV3o5L0NrVkVZYytzYi9S?=
 =?utf-8?B?Tk04NEFZbmR2cmszSk1KdUxsSkhkSWlzY0cvYWhscTFsTk94MzY2bUZ0Zkxo?=
 =?utf-8?B?Z0RrV0FOWDByeDlnMzEySE5aQ0QzUklxWHF4ak1LN0c4eXBUakplSnp5c1NB?=
 =?utf-8?B?ekp6MmtxK2MrRFpIVnZHTjMxS2tuZ3U2ZzNGaFcyQnNkRlZqWkhRVTVQZHpH?=
 =?utf-8?B?endiZU03OEVYeEFpMEtkL3R1N1RHVkM0b3FwMEliazJRbFBBcVJjOW1tSEJv?=
 =?utf-8?B?bGhxS3JsM3M4QjlQSDhkWld2QmFyQzZrcWwyS0pjUGRRT1hlQnhvTkdpRkRu?=
 =?utf-8?B?RjFjQmwzbjNQbkZMaEp0eWJDMXEvQk9MQUVsSFVYNXBXVmJQSFVSWEVPR0ZR?=
 =?utf-8?B?MzBKbjNQVTFUYXZVaVczdTNEdUpEYmV2VVRQbnp3SG51RmJUU1ZwTndKdWV3?=
 =?utf-8?B?elBTUDBwWEUrU29XZSttR3NkMGlzUXJuMkpHOTVScTdXNW5wTDRWUUgrYm5o?=
 =?utf-8?B?VEpvWUdqRkZ4dEVkMWVyekNzaGxYQWtydlM4QmpmUGJqaFhxYmJSdHdhM2E2?=
 =?utf-8?B?ZFB0VVhEWkY3eCtTdGREV1VkUGZSU1plVFE2dXc2cUYyUzZEalBSN2twcVBh?=
 =?utf-8?B?OVlSM25wcXVZOWFoVlc0a1FFV09FV0ZQNEVJeGRWb2poc1ZRR2lZcit1ZVZQ?=
 =?utf-8?B?Y0NiSGRaTW1JNDBTOGRWcGRTMHd1MkZGRDhsM04waC9UMXNRZzVaNTBsNHFG?=
 =?utf-8?B?SEdzUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32864a5c-eae3-44af-c159-08dad6c02ce7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 12:56:50.3672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpKrwQ4RY2DdR51EOdc4l5GqVZHKTVcafWJFv1xanQDDygZC+nt8RBU7/Wu7Z+oU71LUuuIqn9ItkTA2YHVBew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050104
X-Proofpoint-ORIG-GUID: AtTWCsazPMVxMfgCi1IdFe1iqk8GPgrL
X-Proofpoint-GUID: AtTWCsazPMVxMfgCi1IdFe1iqk8GPgrL
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 12:53, Arnaldo Carvalho de Melo wrote:
> Em Wed, Nov 30, 2022 at 07:41:38PM -0800, Ian Rogers escreveu:
>> Currently the 'MetricExpr' json value is passed from the json
>> file to the pmu-events.c. This change introduces an expression
>> tree that is parsed into. The parsing is done largely by using
>> operator overloading and python's 'eval' function. Two advantages
>> in doing this are:
>>
>> 1) Broken metrics fail at compile time rather than relying on
>>     `perf test` to detect. `perf test` remains relevant for checking
>>     event encoding and actual metric use.
>>
>> 2) The conversion to a string from the tree can minimize the metric's
>>     string size, for example, preferring 1e6 over 1000000, avoiding
>>     multiplication by 1 and removing unnecessary whitespace. On x86
>>     this reduces the string size by 3,050bytes (0.07%).
>>
>> In future changes it would be possible to programmatically
>> generate the json expressions (a single line of text and so a
>> pain to write manually) for an architecture using the expression
>> tree. This could avoid copy-pasting metrics for all architecture
>> variants.
>>
>> Signed-off-by: Ian Rogers<irogers@google.com>
>>
>> v3. Avoids generic types on standard types like set that aren't
>>      supported until Python 3.9, fixing an issue with Python 3.6
>>      reported-by John Garry. v3 also fixes minor pylint issues and adds
>>      a call to Simplify on the read expression tree.
> Cool, John looked reviewed it (may I add the tag?). Applying to my local
> tree, will do some light testing.

Actually I just got as far as testing v2 (which gave rise to this v3). I 
will look at it further today.

Thanks,
John
