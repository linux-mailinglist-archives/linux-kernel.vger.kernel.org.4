Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DAD6F337D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjEAQVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 12:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAQVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:21:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC50E54
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 09:21:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341EJ3MD003665;
        Mon, 1 May 2023 16:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FabzttcS6y75TDdSDckPrQOuTZkPbNrDhb6ONvwI294=;
 b=V4ZKd1HQszMZR+yPbo9Q0yi1Y1oM4vLWPXE2DURodM8CSG5IPmB0BWFn5u1Lj7pH6IVD
 Lc6OhLdNFmaIQoRa3+G23bjqQMEbhxtowrSmt2h9uXGSS90HePjotQwt/CgNExulkBrK
 2fmljs3gQQxGWNvpZFuI1IljvdGdFWXD0EaHBuyrMrOwNSS+9oCKzj63AftpSkFQm8cG
 GtO3VGM3Iv6cLcOX8W7qpDLIzogF0bERFFjyvYs7UxS205fVmBCIdZeR3EOwJEB8Lwk9
 xwD7934O0JoRgds01LEAuP7txYS7YaGCYdt0ogaNWRRfDKlUgYyyvJaMVysSi5xhCtQq cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4ajqdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 16:21:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 341G6qll003364;
        Mon, 1 May 2023 16:21:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp4v2t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 16:21:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqGhUX8pyfzdYzcnzFdmagNjqSWyWIznbeCMnj4kVRh/w+oben0eqnKmG2bc+ibFqYXPl3TZYBOQ0eN5VVeUgi5xYoHGEepnoOcDcUzowzw34/3tXghVCZjxbCkOU2Y5x/z0PMDa3yF+MLjZKCRGLHQebNS9OyuGhAmpe48fjK365PDSpM7uMc02TvirzZaG0x0tqscLU0oiCIqGRwni0L5nm4C4hVvBKDFWkUc1qY668xuf4xJXu/K0M2cKIpG1HF6e12cM9562HwLFqg7DmFNaYUgQBSYfRMCG5lejQA9eh34QLgDnfnCSRXT/W7VWDKdR0ylXVI+L4smHySagOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FabzttcS6y75TDdSDckPrQOuTZkPbNrDhb6ONvwI294=;
 b=O33QnIoaHsbzhLrW+aCvzFRmkwbaQUgHEf+GRFuofbqLlSn2VkDh0ZdKbrxWZwmkX/ynon8ZjBtr0yo6qt0RJFWDt5EbcQKIhXI8lAqsxGH3NHLZnn1m+JRbhlD90zxb2nDCldLYgeeU6Wy6/lwzG0RPfseyCG6WXv9bWDQLl64sxe8AfDqU9hF8kR5XwP5QXjMa2PXlhxO8jWvTK5mPobNCPatH6QF0P2BfrlHiTagK7gpBsj7MAUQo9TOO5ApYVPBB9ZzmHC2JY0sZ+C4GaweUF1yaHiQ3vG2DbEky3Jjne9zco3Ldab38jYqRkshZX3ob2ZVUTJrAlK9g6Z9O1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FabzttcS6y75TDdSDckPrQOuTZkPbNrDhb6ONvwI294=;
 b=DzBGIU+SLoSrxvr8joVvIWst/+cMqUkQc8gzD2DDOKXOrtb3rZ6lAdAtuz6zNVvOh1nsjZuQ6KXiOoP2fMzg5SQcEn728UrEQFiL01Q+pawhTW4nUE4CYrIik7Y3ALIahip4d+w4Za04W3NGLKF5itXfqNAa6EzFRWNJa/eFUU4=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SA1PR10MB6518.namprd10.prod.outlook.com (2603:10b6:806:2b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Mon, 1 May
 2023 16:21:25 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3%3]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 16:21:25 +0000
Message-ID: <3fdc9c92-4a4f-b716-c8bc-056111feb3e0@oracle.com>
Date:   Mon, 1 May 2023 12:21:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4] sched/numa: Fix divide by zero for
 sysctl_numa_balancing_scan_size.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, Chen Yu <yu.c.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>
References: <20230406152633.3136708-1-chris.hyser@oracle.com>
 <20230429145635.GA1495785@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   chris hyser <chris.hyser@oracle.com>
In-Reply-To: <20230429145635.GA1495785@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:208:e8::39) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|SA1PR10MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: 18139961-04a1-43e9-835f-08db4a601bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qaoI/Sx0ZEu6zix9Q16ulzD1j88ofZlaU6uypo/v4PuurES5KV/SsniGcf8RzxHYIYUF5EaaB7uQKkSFEWgvupaqt9GOIpzF82IErRZ70P3yzhrcpJBpXjaZjAYy/daT3oRAWpB+QzHUW/ZfPz6kdteZ3qsAj6H4G5TmWTSDXw1hDjhsQQPWk061Q2+Yh3gYnTBYhRJAiBV8ivQB87s2GdSvGqzoEjflsvA7SOpKlGkQCO4dBW3Fnj4hkQ0yV/sSet08QFJwMSmenDZqTPvUNjGlITNzdz3VJ4trHhQcWVs/26+1o0ESCCIAOMamfWJUMy9rZ4Df6ZFjp91OihXND+EiQubiVtPIQitnSdi82+sDOTfVnu0sPtWAQzzwePqxMmeJN5k37RzRbytetLjysCyT4/iEwXUvS/6lc4fji4pA9obzoJjCNtGrRt9XOjaTa1eX4SoP2V/XFNYq84GDAvIgjPEfjtFKvpurKGk0yw+hu4rFJlhiroj096TKESixP/Lb/4Jhp43za3DkNsKxJz7CxNb9vn6onPDCCeuf06MyAQBrWhFMvXpB2cjJw25SZ68Ok9o6x0l80a3QvxfCVuMUfk/E/a6IVGlKI2jQ14Dvx6nhl0+6gVwqb31w0ze5oyM41JAijUKy9yapXjHFKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199021)(38100700002)(41300700001)(8936002)(2616005)(478600001)(5660300002)(36756003)(2906002)(6666004)(66946007)(66556008)(66476007)(54906003)(8676002)(6916009)(4326008)(31696002)(316002)(26005)(53546011)(6512007)(6506007)(31686004)(186003)(86362001)(6486002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2UxQVdWcjhZR20zQkRiL0pHeUFkVDROTWZtWGpoK2hSSi85QzNDa1ZmM1VK?=
 =?utf-8?B?aEtzUStpSHk4M1BWNjVrT09pRno0cmtDN0ZnT2VoRmxPeWlqa09IYS9zNWp6?=
 =?utf-8?B?NFhwSm5JUmQxeUc0NlltZVFDYTIrak9kYnZKd3R4YXRrWERPaUdVQkJsRW5m?=
 =?utf-8?B?YytOQ1E5RmlLdDZqM2FHTjRobFhzN1dXY3pvRTUrNU9Yd29MaGl0ajFYMEZa?=
 =?utf-8?B?eFl6RC9JNjZDL0V5YlJ3MmRROHNSR2JxYXkwNWFBUmFKb0RBRi8wUzAxcXBL?=
 =?utf-8?B?NzJJeHRlZStacHNZcC9HZENKZm5NdjdUaDAvWnZic3ZvREJkbG9CR1k2R2lY?=
 =?utf-8?B?QTRRdGdwdW1LZU4rOHZtMVJ5c05DZWpzQURuTnJuYWowTlpGRXhZZUM4MVdE?=
 =?utf-8?B?Y0U3U0NKdmVYanA3MTVOVzlvdkF2cnJSTm5hSEJXdXIxUnZZbUQzWEVjVjdo?=
 =?utf-8?B?djdnUnZkdE1kdGxncWxHaTdzSC9CNUZ6d0pxRXpLL0hDT0tZOHhlNk0wRVFv?=
 =?utf-8?B?WjVoSVhGZTFCQ0htalk5UGhUMDN3Nk9CV1dldEdwelorMVNlblFFNlBXL0Fq?=
 =?utf-8?B?RFoxZGx6OWdnTVFqMnZWcEZKUWM3QVM2YTdDcTI1L2lDalU2c0FvcDdRTHRn?=
 =?utf-8?B?alArMUVNbXRKcFh3cDNLRTFzTlBuVGE1RUwvK0hVMERTTzF1M0ZKY3YyU3Aw?=
 =?utf-8?B?ZnBDOHdmOGdld2ZXQ0pTSXJxMWNrbHo4SUdoaTd1S2FWVGR0REtqR2dvK1pI?=
 =?utf-8?B?Mnowd0xtQURRUTNDczFkKyt2VzhIM1lXN2NIZFRDclBEYVFvRkZkeUxTdUNr?=
 =?utf-8?B?akVpN09LRWNob29kdGpsdW9sUmZ6QTJObkk0RlJxb3psbVNwRGpxNzRib1RT?=
 =?utf-8?B?RUFIdHlyRHFiT0lkZG1LM0NPemE1aDl6QmJOdnZqWHRRNm9qWjY0QjFDOEZv?=
 =?utf-8?B?MG5iV1QzakJ3UllUMmxpNWMwSXJqQk5Td0Via2Z3UTBRTERWRGNyTnFjZ0Nm?=
 =?utf-8?B?YVZIaFBwYUdDdzhzeTZ1R3BzSm1xWXRYMmRTQ1Ntc1N4Szk2YWViYUlDc2o4?=
 =?utf-8?B?bS9iRkk3OUt4UFFMallEUllwY0NCb0orRlpxNXBJbXpsOXEya09mN0p6WEVG?=
 =?utf-8?B?Z09CSDVXRWFVZTV6OGc2ZEpFcDgzTTRocGhQMlE3TGVsR0JVbGlvOUw5djJI?=
 =?utf-8?B?alAwdUk2NTBmcFZqTTMvc1UrWEZiV3l2aFcvVXlCZWFKWkY1MndLd3p3REhY?=
 =?utf-8?B?c2didFE4a0w0NG5XdlZWRWdEdmdvY1dyNDlPOFFod3RHaVRPRktBaWxocnd0?=
 =?utf-8?B?aEdLVUFlYmpKZHNPTSt5dDJPejNCeHFVZ1Nib0M3dFUwcWwwRENxYTRZZFZY?=
 =?utf-8?B?L3RKWFh2aEVFd3J1WXpmejFacFNkR0ZuT2h4a1lDRS84WVE2cmFFT3NtdnpF?=
 =?utf-8?B?T2I5V3gxNWh5Uzk3dnNJc2tnVUh3U2gzRDRPdVVFM3ZWOW1abUM5aFVPbDNZ?=
 =?utf-8?B?ZUwrUUd4cVJ5RzUwQzdVbHBvbWovNkxKR2x0c28vNlBOazA3MmxRbTJ1N3ZX?=
 =?utf-8?B?aDQ3b0RkVlRaVEtHekVTNWtWem9TQ09xcmxXM1FqOGdhZ1dFTkVmcFNrd0pv?=
 =?utf-8?B?S1ozSmt5RWM0dkk1dFBaaERsS3FqTmgzREQ0UlE3aEpaM2hVVnVXVVorR0Zz?=
 =?utf-8?B?aG80K3hYOUFEQ3R0eFIydUVkOEk5S0RHSnd5a3p2U3RjbkdYeFFGU3ZpdUF3?=
 =?utf-8?B?MWc1TXNDQjYvejFBMzNyK2NHUHJrbC9qL0hIWHQ4UUs5Yjh1ejZXQjJDMnZP?=
 =?utf-8?B?NUtRbFB5SEo3RDhxUWpwdzcwVTg0bDJKYjByVjdsWnlzVVRBS3FXZHBTdDV2?=
 =?utf-8?B?amZ5UFU3SlZnclZjRkMxaWJraXluUk4veE1LWXN4c0VzTVZ0TDJVaklGek0y?=
 =?utf-8?B?ditsRFB5MlRoZXRGWDRFb1RFY09ZTkl5ZHVDUjRNdjQ0V1VMakEySUxKeGxm?=
 =?utf-8?B?OGpnMHljeTQ0WjRucytlSnNwcTBmMnVoMDdtUWNLbWdEK2RORk1EaHFlUWFW?=
 =?utf-8?B?aUhrQnFnMFVJYUdnUTdVY0Rna2R3RHVQVGdyV0pxUkZJZHg3NHM1VXdMUmcr?=
 =?utf-8?B?QStqY2lKa2o5Q2dBZFFMNjlvdExTTjA4b3JKS2EyUUxSMndZME5sOE9tOTk3?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NFJYBKxlveqA+/wwzjjXuaUS7YFRxCc85cgICdIZT2MNUOGIHyGClWJh2bYZsg8ptMrd/Uaj4SBHJ7YTh8DA7mqWf4ZnhR/vKc9uQKpY/5X6Ts8DoeGTBbJoXotLsJq/53woviBakxwykbh4HyeV1saMkt0r8wGAIU8SgwNW8RfmZYtdrE8FLk7mpgAkyqn7d803hMqnzeBny2x0OiW78XPcliM0dRCkg341YT3wgeAngiuVzNAA/WKwT/x2jISBwA/ouJAoseov5ZuFPW3JLCCk/351fDrlbfT8nGXyPpwuLQK8zI3R01tEsJ7BAtQgKtmd2BuxrLjNWqmMMKV5bGk8nTTSjG3s9OJXytNovDukQUOE54bPsL202jWszUpIWZYZmE3t9OsGFBxY1F/d46GDWkHUQz6vh9gunhX8kMLq6+DXPeGskBkPG0GLW9u3S7SIJYFAJzO8cYqCtwkEY1t4WNkTo5IGJw6OELxzp4Nsa2/cRB1V2uOZveA7iV5vp2pn2etM6Ge+OPypJF/03cywdBcvznUN3O1azG2bH/nrDHY3VLRgeyxBmSGX5Thn0D2UkMplISEreZ2W5a11/+YgJzUzIbzo24FgxWV+RozPeq/mB2cmU44p8HHtGUYlxJpyuHuZGFAh4HzJ3SzQoxhBu8X+oqPH8RiEv+oAoSES8E+RVTjephjD9HmIbWKfhcvtmeTTFMQv5s+ueJbonI1QzZoBwXw+FYlbOU5PADqooSDveMGoktFCgSpeS1quG9V11EdpSYcOfMMGJY+TvZVohu/QaClJURjo+OZeHQj/DqwXp9Sm7jcg3ev3RmBKAKR8hJtzXtM6TJg6L5rp4QiX7ig0nmuRJWXLkcqXZ622GagL0qkIFJKr6Od7VOf70sdJ6yiZkyIPcJaSpiLOjw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18139961-04a1-43e9-835f-08db4a601bf3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 16:21:25.1659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzTUHHVATT0oBz3E5iF7hDl1r//U4mH5UKx4ODgYYsnO00QpOKYXnbi8mtUfuG6sa7XOv82pAc5Oi8fCmSghVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_09,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=854 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010132
X-Proofpoint-GUID: Fln-JxEoBgyXsnqI-KoZCgcU0JLQLUmH
X-Proofpoint-ORIG-GUID: Fln-JxEoBgyXsnqI-KoZCgcU0JLQLUmH
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/23 10:56, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 11:26:33AM -0400, chris hyser wrote:
>> Commit 6419265899d9 ("sched/fair: Fix division by zero
>> sysctl_numa_balancing_scan_size") prevented a divide by zero by using
>> sysctl mechanisms to return EINVAL for a sysctl_numa_balancing_scan_size
>> value of zero. When moved from a sysctl to a debugfs file, this checking
>> was lost.
>>
>> This patch puts zero checking back in place.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")
>> Tested-by: Chen Yu <yu.c.chen@intel.com>
>> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
> 
> I suppose.. but is it really worth the hassle? I mean, this is debug
> stuff, just don't write 0 in then?

My understanding of the history is that this was always debug, someone 
found the divide by zero and a convenient sysctl mechanism was used to 
fix it. It did also cleanup a little compiler weirdness. I did not see 
any justifications in the discussion of the inclusion of that patch 
other than showing the nasty stack trace you get when the machine dies 
after writing a zero. It is a major inconvenience, completely 
preventable and technically a regression, but as you point out the new 
fix is a lot more code.

In terms of actually wanting to fix this, I'm a bit confused. It clearly 
was worth fixing the first time around (it has your sign-off), and the 
only thing that has changed is that that fix no longer works.

> 
> If we do find we want this (why?!) then should we not invest in a better
> debugfs_create_u32_minmax() or something so that we don't get to add 40+
> lines for everthing we want to add limits on?

I will look at a way to greatly simplify the bounds checking here as you 
suggest.


-chrish
