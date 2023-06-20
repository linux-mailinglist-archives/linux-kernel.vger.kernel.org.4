Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF90D7367D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjFTJfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjFTJfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:35:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33741F1;
        Tue, 20 Jun 2023 02:35:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K0M4OF004682;
        Tue, 20 Jun 2023 09:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4xxAEWHkxFPZ9x8x1VjnBAjxUcdp/phlSGIZHspmGjU=;
 b=nst/e9K7IKXMqAB+LvsKNma2uO0TB7NOGMSXbPOUMHYpAZTfyLQ/mYjE15kreh/lcGWk
 MP2XHsYB/GelfZe7aKGsd4rUFIw7eMS1UYhPL8HvkwDEEki5a1pX/ivFZ5MP3VkARQQQ
 axolYwBVsro9Ch2yvdEKspzruQRmv668HrexfiVDf3V1GT4focjQd06YIMlafB7y2dbx
 3q9lL5zffmU2wsmMtLykepduG6UTHij7RBuebiw0P/MGm3zYWFRHPvR0wwfJi6tXEuz5
 wqJvAgpTEbBrjz7O7Id2+JsvPPD8JfnzF0H1AhTgo7c81nG2h+oQwR3iaPcAnJYE0owI yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dm8xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 09:34:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8bgY1032955;
        Tue, 20 Jun 2023 09:34:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9395ats1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 09:34:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHR2dxVCbq1rnmZlJH/BL4O32Jd0lBWME4vJxbWU2zki+5dhNyjC4YKjz0/j3wz1vpqW1G2hX/P4wohgwy6y/lT0P1oZs8zer360cq5/qyQs/F+jxh+PaviSKqbTq+XQviXLNHtKeyTlK+pEzqvOcaDLXmqSdoIAK4GlYlcFuG1Si9MvgI5+Rb5f/iwsmm6FqgAMwk37BFaBBr3EKlWNM9T192QabDs22pR0X6KwtJIOJHr9sy/Y0PxxRM0r6vL/K5uUYTPNTJW3yBdJSSIh/dZAdUy+zOAOPGP/CaKiwmp+0zQuB7hbwEHtlFz96h1gNF48YxFD1s5xFQ1kA2qS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xxAEWHkxFPZ9x8x1VjnBAjxUcdp/phlSGIZHspmGjU=;
 b=REWMQTTp7olNpInFKjCJrOalro4v2G4jwZtM/LIhofAt+zKvQEzsDnZrHDuYoZ+kBueIRmrUrjxyx4Eg2nogeOBJYqDGPXe1obxbOXvI2WcPEfiHwokNELOQeAvIJX6bj3z862Ni70a5Nkr4sY+8PaEbS5lIHyrtvoHkuuyYGMPh2bpD7cErSvRt+fr3ntonWRg1qfJFMnbDTBZZYfxwsYExCCc+wBUy47e1e0PWne/5EhKhtWJDfVSkk0sL7sgu4vR/74XnprcJPtZ5ksSrZr5b2HMh+i5VAh8Cq4xEkgnp9JaIXVrBKsNdv9wErWvHz3gytvg6qr5DxCoYF8tK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xxAEWHkxFPZ9x8x1VjnBAjxUcdp/phlSGIZHspmGjU=;
 b=VJhsrVr6ZFtJVF3gG8EEjY5fXEdpLrEvelUx9Ok9CPb6QwGx/vMsOX/DTZ9Oto0SEQ/bDdWi9AZV4cUG00JFL1kqG1nhpy7YZJNBqP8wHTPkGYiXN90ktg027IdmRXwgZjQb6e8RYmGTalfF3mSSzQmONDn4Gqb0DjXJ3FcS6tM=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ0PR10MB4461.namprd10.prod.outlook.com (2603:10b6:a03:2d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:34:43 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:34:43 +0000
Message-ID: <a39ce0d1-8ba2-9efc-1fa7-b6e83a76ecf3@oracle.com>
Date:   Tue, 20 Jun 2023 15:04:29 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 5.4 00/64] 5.4.248-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230619102132.808972458@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ0PR10MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a904b7-626d-4da2-cff0-08db717193d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dp/EPfieESoK5+Db/pCHogOcuLChOFlGx40DC3yok7BMf3tQsBJJEzqBFkJnuikP39IT2Tv0TIdwfpgVc+nxp8K+s4CV/ok9298a/4jPuM5lKECTpYpK4lgLzwQIa6nQol/LS1VCV0Hs0S3Waka75XyaaFkH5wSrRaT+X/G7SqgLbxd40MlGphSQntS2AmD3+WmxHszKX64mx7694Un2vGBpiFEUSiQqyWdOWiiEsvXefCNNZzQoJ1vBXvC3FRR47jbNfxNooFDfM1NL5ezMjXzonOI8a2SWhJi2CJkXzb24SHcMRtooyU7gjohq3gxUEFeB6Rnh5rfSw5Hqr4AhQYyh3l/9w2eYPS6fFyYofwyUXXs0wqZU1t5G6VqDfhe6ZkRebe8CUVPyQxeouXqL6hNmzqSfqBnTt6T4CZB44XIyfLU3AtkIVBm1j3vBsboQdzUKg/Cma3dkRwvQpoyUFs1GCow6qVMES536vyQu69NhIV2ZsnQ5omPxS2LFpwqIMJPUpi231dl8w3mSiaTPWu++8ZW5y+YF4UFIkAWEkZMA3JWAtfRcPPG+Bg1V0v9oRNIOR3tLWvijqV2K1l4N44r/9/+og60gQCmNYoIe4UThlnFuzqa0+7qiQ8tkYfgSf77s63LKujVOgUI+vLX/3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199021)(5660300002)(31686004)(66946007)(4326008)(66476007)(66556008)(316002)(36756003)(4744005)(7416002)(2906002)(8676002)(8936002)(41300700001)(6486002)(86362001)(31696002)(478600001)(38100700002)(6506007)(53546011)(107886003)(6512007)(26005)(186003)(966005)(6666004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajM2NDU2S3V1QlBId1VCOGU1QU44UnJLaU5UaDIxVG5YVkFZdi90dTFvOHNx?=
 =?utf-8?B?MzQwR0JsUkYyOVN4anRYMm5xMGlCMHJuSDlZaGR2djZGdnJURUlQemt6Y0t6?=
 =?utf-8?B?MGpXS2poMm1ZZE16cEVVZDZPRldJdTdGRkR4c2tHb2k2ZU9oc1ZZeS9hallL?=
 =?utf-8?B?NlMyTVJmeEkzRW9NZkNqZEtqU3k3QmM2RHo2LzZtR1FPVVZDNTNueld3cVJx?=
 =?utf-8?B?QXAyTWpVRGM0cjNpNXlBY2sxczcyZitDbHRhQ2RscGRQdXllN0hCYkZCYTla?=
 =?utf-8?B?VVJ6dGt1MDVNNFR6N0J5ODFOeXpDU28rUzNSOGRic1d4RU41WlJXeGk2RWg1?=
 =?utf-8?B?VjlnRmN5RW0wUzR3elFvaHVtcnBFbkhTTVJXUmJOTGRnVkJtZU1YL0lqbHM1?=
 =?utf-8?B?Zi92LzlWdU5PWlR0aEY5RVdaeFR1Z1MxRFN6cWY3Y2ZEQ3R6YzlZRTkwdGdE?=
 =?utf-8?B?MEpOVEgwdmY4MWg2SWdUbmZmTkZyVUtWUVFyMXlzOS9Cazhkekp2anFQa0o0?=
 =?utf-8?B?QU9sTzNHUytCUGFVSnIwUlpwSUtnQzdVcTZDMm54dGJwNklscmF5VTFqWXJB?=
 =?utf-8?B?eFoyWms0cHpWMytVdEliUURuTkFGZHM1RzA5by92cTZGTU5kOFgrUmhKUmo3?=
 =?utf-8?B?OVU4NmpKMDhWOVFMSG9RdlBSQVV3T0QxYzgzV3laYnhBdVFFSFJGM2tVQ1My?=
 =?utf-8?B?OExiM0ZRVVNUN1Y1ZEl4T0w1TnlEMEpDVjIvQ050ZG92ZlVQNWxBakhQUGxv?=
 =?utf-8?B?eFR6T1UzNDRXTHZDZzZmcitQRlR0UDh4K2UrWlBySlZjWTRacHZqc1ZjWUt1?=
 =?utf-8?B?VS84cDI4YTJEZXh5d0pOMG9JUndzUjlsQldyWngwUnRPU1VkdUVGME54RHJ0?=
 =?utf-8?B?MXEreFVzTU5DQTgycU9Ua2U5aTBRdVFTVUxHZXhTRFd2YXNQdjJVSEZRbXBm?=
 =?utf-8?B?Q00xdTE2NWE1NTNJbkJhd1RMSWlnQTg3MXRFRlNKVklucXNmcm9vbnFJd0NQ?=
 =?utf-8?B?a09TWVNuNm80akhqcXBUMytJWmJNbVBRMDZDaExrRzR4NC9HZjRRL1J1cXpB?=
 =?utf-8?B?a1YveTNCclFmRjBWeDk5YWsxdjJuNGNQaEVDU0p4QjNjN2V5Z1B5U2dZcTY5?=
 =?utf-8?B?dDZDNm9CRjM0UmtTOFhEeDd6dnlENURRbE9menduYXhXOE5uOHdkZXgwRHJD?=
 =?utf-8?B?QjNUSGc3SWJmZHQwOU1WSWpudzBBZ3RrbloxcG5KSDZJcDc1SGtYNUpqa2xP?=
 =?utf-8?B?SFZOdFRFOFluOG5ha1J3TWJsSWp4WUtlU2hMQzJNbnFlUTVybGpPZWU3TWZs?=
 =?utf-8?B?a3U5Y1NKa25lRlpiVDJMTUdMSmVDcXd2a1BMbVo0ZFFERjhLd3dOT3FxQndw?=
 =?utf-8?B?cXh6bGxyUXhaOGM2MEU4OXBIeW9HVnVhcmZkcUNzaUluVERGdHFWNVhQTzBI?=
 =?utf-8?B?a3FYbU5hTDNicUpYM1FYUTl4MThOdm5ZblRzeVBsT0p6SnJaYm0wMnp1d3Rv?=
 =?utf-8?B?Um1WUXZxUU5lQk5qdnpCNUl1R1hLRUhFUEFsWWNMWHo1QTRsVjF6MnhMWGZB?=
 =?utf-8?B?ZTZuVGZERnRwTlVkV1FRd2dHanJBd1VTM1pwVkFRK05rQmRJUTFDMlZCeEFL?=
 =?utf-8?B?WmJORVgvenpLOHcvMnQyM2ZTcnVLNWtrNnhNZ044S2hWVXRyWGxSeXZJengw?=
 =?utf-8?B?YTJIVER5alF1aklDOGNQSWlheXF0eXRFQmNLN3EydzlvbG1nQ3d1VCtldTBa?=
 =?utf-8?B?cWpOcUpSbTA3OTcrN1BYOFFtQ3pFY01sMjRpRmdlZSsxWkdvdy92N3dDMFgx?=
 =?utf-8?B?YXhiVkp5eVI0ZU5MSHF1VWZpVERLalZXNS9yS3NaOUlrdHN5UEJpTFhHRVlX?=
 =?utf-8?B?ZXdaWVNkRk9rRTJ2U3ZmV0FUaFN1WnVpaGpkL3N3Y2d2VjFZS0RJbmN6bFpj?=
 =?utf-8?B?M3V1WDUwR3dWMHo5eGpXVzJJTmYwZ3I4OFhJNzNEeEc4NjNDVmFwRXhUZzBK?=
 =?utf-8?B?cXlNMkM2d2ZSL2QvNVFDRXJMUzl1NXhzbzhTRjJlcWFDeXhRN29Ra0dvWEk0?=
 =?utf-8?B?V3FJbnJVZGNVUFBCa1hUbEl3RHo2MjZXa2NKVkZ6QlM3UEJOUDlUNnF2VGhS?=
 =?utf-8?B?SGYvQ3BTLzNMTEwvUFhpNzZvc3RtZUpIczNXZi83cVFpcjlJNDlKWms3U3V6?=
 =?utf-8?Q?QyP5SoG0LnelPcS7q2RCpYo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L3d3cXI2SEQ2c3BCYk52TmRReVFxNi81TnNtMytxcFIzbG1TL0IwdlVIN2xi?=
 =?utf-8?B?c2hUQmowVkdYVHpCcEc4RzVzY3MxQUUvek9UV0JhSDgxR3Q2dGc2WHpsNzYv?=
 =?utf-8?B?ZHMyS2dydmVoY0JRdi9XRTFNZVB2TkNMZ1A5YStXRXI0azgyc0h5cmRYdEZY?=
 =?utf-8?B?NHk3RVRDRzZ0dHlXVncwU3MvK1dtMzNHNWtXc0dNbXg2RWJnTjBmd1hLWTZh?=
 =?utf-8?B?emEydjNvTVRsUHZ3dWNBVFR1QkdOYmN6Mm5iZHJEaWxqZklicTFLanBFWVBa?=
 =?utf-8?B?NWNjOUthWDNsQzVYV1dWVG9GcXZyOThBK1hubStpeWZ2aGFxUW9Lc3RKVjZt?=
 =?utf-8?B?VldSeGdkY1o4bWtESGZKandlWXdtSGpsbWNNaEJpSTBwcXBHQW9ZbHhWNUZX?=
 =?utf-8?B?RFlHRCtMaUM5bXpQelNBQjBjTWxSOUFUOTNiWGFESFB1RENLMERvNWJsdHdq?=
 =?utf-8?B?NS94S0REUUFONDRRYW9WVzFiV2ZVVDRnaUovSXB6T1Q3Vjd6Qjg2aHNqb1o4?=
 =?utf-8?B?SFhhZjdqRHFYSEJsUlNyZGNMU1NoeTNnUmVXVTlia0ZkZWNnRnl6a3FhZ3F4?=
 =?utf-8?B?S1JWcEhoOVRxQTJFV2g3VmNBNVBUQVRXMUNBV1ZHbEpRTzNkdWUrQjZDQ25U?=
 =?utf-8?B?TURZcWpDdHJ6V0kyVEs0TW5POVlYOUhPZmxJbkRjVUtsWGJZL3o5OHdSSGgr?=
 =?utf-8?B?N1pVWWxmbWd0M25vN0JDckRmcFIwU0lwQU5CUUphb09EVTU3bDFvblY0Zi8y?=
 =?utf-8?B?NXNTdldzVGV0WkdXVmY0cGVLYnRFT3dnLzF1N1pKRStmdjYrajBsMGxwa2hM?=
 =?utf-8?B?QS9Sd3M2a1NXVFo4UDhvdkk2VDB5b0VmRlRTUFhMZE51UmhaQUJWbUgvVE5j?=
 =?utf-8?B?RTVaL3dqeVp6WGZ0aVhJZUVrK1BVTVZKTDdyNzE2Wml1TFZWWEQxSUJNVnZy?=
 =?utf-8?B?YXNSTHdwOUplUWREaUNXa00yaStHSUtxMkgxM0w2Mnc2c2FLNm9VVTVrTjdo?=
 =?utf-8?B?eGUwZWYwK0hKS2s3MUxzQVdUMUVQUFo1WDJaNGpqMTFCZUFYYnZaQWt4cXFw?=
 =?utf-8?B?dnFseURpejliVlY3dVloWE1aUGJOK1VDOVZPeXJnVDJGaHNNWlVRLzhoRm5v?=
 =?utf-8?B?MzJFcEFMd3lIaGMwNmtHeGR0M2pQK3k4azFCS0Rodm1EbE44R3p5dkV2T0Zy?=
 =?utf-8?B?UUhmcG5KWjJQSXRReGJKNHpjNVBXUWtxRVg4VU5JaHQ4R2NTV0diZWM3M3Zt?=
 =?utf-8?B?ZWtlUXNYMnoxQ21Yb3F4cERkUTBFWC84eUtZcktWUlRibCtValI2Z2FrZHVP?=
 =?utf-8?B?aDF2bk1yMjJCekt0SCtpZVpTczZFdHR0V1hRTUVpakRaRVVRNUZiSUNVeURQ?=
 =?utf-8?B?dURYSVoxR3dFOXBtRFlMVENJUEo3RVUycmR0L2RnNXduY0VSWVpabnFMcWt3?=
 =?utf-8?B?ajJMZ3ozaThKWW5HQUFxK3BIR3pacFFJZWpYcE8yL2pXOGxza3QvZ0ZHcUpV?=
 =?utf-8?B?MFNaNExBQmlpYkxPS1J0OGJrMzZNd0h2YjBobW9Ca3hLcXFpNDNLRWx6VzRm?=
 =?utf-8?Q?xOMi+s3GN1yEckrFCXN7DgIrwkQdZtt1ACHy+K0m/rbUPZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a904b7-626d-4da2-cff0-08db717193d4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:34:43.1449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 369Jhnfkn8rO6P/b6AC6nkZY62AgY53Zh7qfiplxyrLtChN8PGYQI416o3cERCPvSYYGSC+Nz56UHxBuBe+HRFMK8ZuSFKAonHk5UpGK7M7E2dBdMb2Cghs3mgzu2PU/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4461
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200085
X-Proofpoint-GUID: FyPFgS3z3yooYTXWMtVZo2r-hSWvxIpe
X-Proofpoint-ORIG-GUID: FyPFgS3z3yooYTXWMtVZo2r-hSWvxIpe
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 19/06/23 3:59 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.248 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.248-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
