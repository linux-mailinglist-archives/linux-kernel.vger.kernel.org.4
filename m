Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DBB733280
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjFPNtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344976AbjFPNsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:48:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8893A92;
        Fri, 16 Jun 2023 06:48:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCip8O004492;
        Fri, 16 Jun 2023 13:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=i8eZLcMqRhNuAfctc4M3C5eIlS9stGSKnPtUFnxUqCo=;
 b=lA2HeOTrW0eQFAQ+QpaHPSUWnA2QMizmeelWMJNVvw1M8hZ4l5JMHYpAjthocMUV+DVT
 DK6bSp3Ov6/e3+yiu3nvm2+FxsQtzJsGT0Mh0CH61/HKHUk0cVtmw8BQOIWptMdFx85Z
 fkCG3jE8IybTNHYCTNaWrWdMG/tLG/xQb19Tv7Rj+/Q3CVwDsIu9NA8oiuRsE5KhDU4l
 6KKBW/db5qorBwnwQHi2P8gzHxkuUgvFSrJ+MUcu4T90W34iSX/9vk+eiLK6uEdSu3IW
 lbr23+0exHuPd/t4i+tKmwwCgkQ4Ch5TUA8YTUSk0azVnCeQdn+7hPJ3b+MJPUGlS9AU XA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs24an8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 13:48:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCIcdG040511;
        Fri, 16 Jun 2023 13:48:16 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm7yg45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 13:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkHMcA9tsMdKm7YPXMPmGOvhKb+YsUD4HpsuHR66iogLlksfCL/cAwEuyuibm8GU1Cq4vZ4oSRP2TfxjnsyLEmgg1TbrDlLj2oayavYWB6UZVaFTee6r2HXjCgEGxQ/anz8n5jkkyWTocmrB/VLfRLfSF0HvwRvMaUaBJr1yvE4qGhytJ9ug9dVBcYpwdwWsNwRmIiEmHqKbeCGJ/9y1i/RtFTFTYecfB9wBOGniS9SFYwK6heidYRsAltw2B1YvbUwHwAtobcc6XK2yMKbXQ2KqDrKsR567HdSWZ24JJ4AsYXN3jpkpaowj7+pCgzuk+Vpp8avFEpDTjIl+wo0XZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8eZLcMqRhNuAfctc4M3C5eIlS9stGSKnPtUFnxUqCo=;
 b=MHpYJpaAGoT/ckvu5PCYdJrrHRzN5ubNo35D5YAVZJTUg/Ad6wXS5kVp8GQZXDn9gYhMcoClR2xgl9uO7HyFvMkBlN3uRAo91A2FT31ONWEj1NJmAmAMI4opIoHyHE/LhSZnjJiIsdiH1goPQZpfM92LMOvvK2bovTA5rFZNeOMHOOB1MLOTVjCX0Kens9BHBOzd159pPQdSJPuzgiGa8YeedV3EzwYDlmiYNILhhl1DZSNg15sM0tucD7xaZ5HXPrYGnz6mddtaiLoCgRYx/snT2FBTn+zB9tI5j0ZIRTMOk/nKeyQ7yOjxUUqSEzikGPgZfwg4eH/XpshsemxmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8eZLcMqRhNuAfctc4M3C5eIlS9stGSKnPtUFnxUqCo=;
 b=mcbJJKPgGmLtKcURerSh9w5AkXESbufl7tLHQ5+zEIxBlURUEocmY4gZnAYypGEOnuH/ZQimTBisGQJU4uukQyGak+bHF3+r3bXCH4B4zVW10l0YisPEjOMjGFxrmcnmFU1hdvjE9DyJjZJW4N35WcxTWYIIhL4GCP0Qu8poA8M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4422.namprd10.prod.outlook.com (2603:10b6:510:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 13:48:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6500.026; Fri, 16 Jun 2023
 13:48:14 +0000
Message-ID: <d92494e1-37e2-36d6-6edd-a2f1093f63b9@oracle.com>
Date:   Fri, 16 Jun 2023 14:48:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V4 5/5] perf vendor events arm64: Add default tags for
 Hisi hip08 L1 metrics
To:     kan.liang@linux.intel.com, acme@kernel.org, mingo@redhat.com,
        peterz@infradead.org, irogers@google.com, namhyung@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
References: <20230616031420.3751973-1-kan.liang@linux.intel.com>
 <20230616031420.3751973-6-kan.liang@linux.intel.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230616031420.3751973-6-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0504.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f77cc27-8953-4a5f-bc53-08db6e7054a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hp/gV+MHoa8/1ULOK20eVzY26j8T2N+brYcVM617cqP9++diRTiuFv0eURNU0RsFWqrRVv3ZQi0u0JV7FMvj0R9wxgjJBoACy9oMmKbcpJc3UO+SWY7uj8pd8Wk8g/DGwUmXnDKQ0+c495EE5nsdUNvyEH2me0yAB68P82x6F6bAy4+yd0MPNoJrf0e9TOdIzWdpwpCPfhRFshpsVi5muSYLcYq8gd2VRZAZrdTspPUBQYUPEjt5003qMxNNhYIfePJxXshZNM8TMik940MnwqhFu0rMyltRGMEd3REGfRw+RtCrNXsN9brfsRLMY8+YkBF0Dxbi1bW2gV4DRiXbluikUTiBlv1tbLil3zDOQyeHNacySYTuMHBeGr3O6WCKgVBi/vFN+S9LKEyg00pW5Pmq74HXembYbBHhimZn5mviHW/HadMNRW5Clo73bnjJMNAWdG7aUPX/XjB9EhWjv9is9GhGX3+Ps/2sW/SmfKQ77rA/aWMwKJlZ3JTQJQO5YZXwz9me6KdUHSJ9dHKFyLxHTwE1f7ftO7kvYbGHFMWWJUZVHy6Prf2m3p3EgYi9hT47bxczDQIrbN2xB5apNaOMjrXufDqhUkOM4uEDKO0rmL4T3HupbWihpBeIWLxvi/uzagyIjrfDSy+LH1+1bGvl8PTNU2doHHrkjh4XD0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(53546011)(6512007)(6506007)(26005)(66946007)(4326008)(316002)(66476007)(66556008)(2616005)(31686004)(186003)(36916002)(6486002)(6666004)(921005)(478600001)(38100700002)(7416002)(8676002)(8936002)(5660300002)(86362001)(558084003)(31696002)(41300700001)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWdqNnF0b3BQQ0h1T21kZE4rTnA1MFVzcGRwbS9lWlJFRWsrVCtFM1dYR2xM?=
 =?utf-8?B?em5hQmZZR3o1cWc5NkYzNXVENnBPMDBiZ2ZWRkZ5NzJEelQwVnR3Y0cyTE81?=
 =?utf-8?B?MlpwMFVCUW9GVC9tZEFYa01hbklaVFFtRHh0cXJjbENFVWZyT3MvQjVZUEZ2?=
 =?utf-8?B?Tm03QjZjTm9nYWpwTlc2YUlTYlRkQkNwd1c0dlJOc0dnZzNUUTR3KzhHN1J1?=
 =?utf-8?B?WHJwZzdwVFZVT2lFV1h2TnhnVHJRRVhWclVrK2FudWk2cTR6MFdDeWljZUQ0?=
 =?utf-8?B?OGllSmhzNkpiRWdBU2M2Mk9WcWtuTFM0eDRMM2R2WUV6WVZvcHJ0aFdETlVC?=
 =?utf-8?B?Q21DTWYyUGRTSnRRVFRYeDA5WTJVV1dqMGNvell3MEF1K3BKK2pTL1JZVnpj?=
 =?utf-8?B?NlJPOUJ6ZEtUanltemV6dXNQQ2pLNEZXckxLVEg1T0ZuQ1pJWUlwRGZOTWZa?=
 =?utf-8?B?RGgxVzBOUi9JOHB2cTEreEl5d21qTzJsbVMxc2xlOVBIbG5BdWNVMWU5Q2JY?=
 =?utf-8?B?Z2V5YmhhZXprZndCOFZLa0JKc1kvKzcycExBdExwdnRQdTB0MFRRVXNvWHJs?=
 =?utf-8?B?UlRjNG9FSG1BclBsKzc0ZklQZHpPZm11VDkzNUx6K2xTaFN6bVMvZkdqQnVP?=
 =?utf-8?B?ZFIzaTY1ODdsUUJaNGxiTDlBcDRTMmtXMTlNQm9RcXFFZkRMK1plUE4wVDVo?=
 =?utf-8?B?VEpPK0drUTBJdTM3WFE5ay9Kc0lJSXlZNmJ3MURBRTlqNmhFUG1SL1hFak80?=
 =?utf-8?B?VG5Ybk81eE1Kb3Nia09nS2FVTmJiUjd1NXpZN1FSMFZnakRvdHBDdStFNjha?=
 =?utf-8?B?SGh5ZExrZm4wQmI3cjNmZ1RzalJod3BxQlI0SkhldGhLNVJyMkhQb3RJTVlS?=
 =?utf-8?B?T0swMTdNYndMU3JRSzJVT1NZcGpWOVZYQ3pIa0ZvcDdTVjNWZDVxcmRBNTM0?=
 =?utf-8?B?WHdDbHBWYVlkR096VUsrclFIU1FvY1VWeXBVb2U0bmttS0RVYThHbUhtMito?=
 =?utf-8?B?YXhLQ1grc0hlaFBwZ1JrbHFydjk0QUVoeVQ5SVhmWkEyVmdiNFRsSXFmdU0v?=
 =?utf-8?B?T3VWTDdKaUpRRElHSkN5R3B0cldpdHJQeUhYT1AyRkovU1oxU2FyckJzRkVy?=
 =?utf-8?B?Mi9RYnZESE1ZbUtqZmU1QlVNaTRWcW9oK2l4amlTMjFPc3RHQlp6eS9tVUxX?=
 =?utf-8?B?cUl4cUZkdURneHk0ZGpSVzlKVERnZUMyNmc1NHVOTndPTlJ2OVJGODFzUnpG?=
 =?utf-8?B?cERTVkE2UDNBcElYd21icXNsOHNsZC9QVnJ6bXNSMDdSeDdUTFRiam5CUHNl?=
 =?utf-8?B?S1M0WjduMmR4RW1xRkE0Rmt2dkVYd0ptU0ZqaDNFc1UvcS9EV0I5Nzk1aW9Q?=
 =?utf-8?B?eVovNm1mMEord1JTNTlBZVo1TU1XRGJCQXpvdWNzSEQwYUdMWmpja1Rwdm4v?=
 =?utf-8?B?SS9wTjhHeHZhU25yZnFnSGRBYlBZbEYvZXJGOFRibndtVkJIb05aS0FNR3d5?=
 =?utf-8?B?aGlGc2xpTmtSSTRaZ2hSTTFzYWNlNVdROFRERXIxaHRJTjB6L0dac21KK1pH?=
 =?utf-8?B?R3ZCNnVBby90M0ZIZGQ5ZXhIMk5YNEg1dVl2RE9YOU1nckxwcFczK2pDOWRR?=
 =?utf-8?B?ekhYeUlzeDMvTDNma2l6U2s3SzlOYSttbWhENDJJSXpOWHFQOEFVL1RVUDhY?=
 =?utf-8?B?TFlJaVExdE5yUjVGbnUwM1NMbkZHYkt4NFJRU3RMYy82eWc1bTVOWlBwdTJW?=
 =?utf-8?B?b2FUaXYvNTU4T3RiWTJmVTVHMTJsK25VdGJSMEdCZ3R4d1N1VXkwWVJpV29E?=
 =?utf-8?B?V3J1K29PRVFVWGFDbmM1NnQyVW1DWnJIaEdsb3hwTTRnUFpUb0RJL2g4aU5m?=
 =?utf-8?B?UmdiYTJWeGdyMllveHUwNGxhTEYwTXZuT00zNlRmZTRZN2ZEYXl4ZDMyVnBn?=
 =?utf-8?B?MmJkNEFFRkJObkh6U1NPaXdaVWZSazNwcDJiMUN5WlROZFB4Y2UzclN4VWk5?=
 =?utf-8?B?enF2eHVqbU0yV05lYStwendleXZLNk1naHhWMTAvTzkwK2dsTjZyNXNqamVL?=
 =?utf-8?B?ekhDSFVFQTNpY09aNDlDZUgrYU9qSExXNkFkNVBxUzVmMDl1VG1ZM3o1Q1hm?=
 =?utf-8?Q?c6Vxm554K2h2W5TkcNQsUHVVj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d0VEOWptbW9yUWRWSlA4anc1ZjcwSG96bWZiRm1lU3NIcHBuRHNBWThld3ZO?=
 =?utf-8?B?U3l1MFdjd2ZueitrUVl6eXJhMXY5OVhmdHUrcUd3UU45TGRia3o2ZVZQTWtN?=
 =?utf-8?B?ZHJFNzMxSGRWcXhNbDBaU1ZQYUZjSVZHWmxQUzQvSWdlYlh0WTFZa3kzNkV5?=
 =?utf-8?B?eld3d094Z1VGRDYrcklaOEdQdXUzcWVsOEh4emhWbzJmeWlSWjdTL3lOdWpn?=
 =?utf-8?B?dDdNSE5hQ3YyMmIycnpnYmtybkI1LzZCMGRlZU84Y2Y0NC9MR1hLK1RRNzE0?=
 =?utf-8?B?VHJRVjA1RElpbzJSaTdPbkZ3amNtbnZoY1hRNHN0NERGTWFsSmk3ekZBeS9a?=
 =?utf-8?B?UmxZNTcxVE02VTNqc1cwZFlOV2JDK2tBcXFHeFZ4UXNWdFNZblJ5NHB6ejNi?=
 =?utf-8?B?SzZZSmZpUzc2VFhYS0l5UkhDQ1h3MVNJWWNvZXhiZDIxRU1LOUFkZDFQRDdw?=
 =?utf-8?B?TlhjTHk5MnkxNytJOXlhLy9XU0xGR1U5bUJQZlRZRDg5b1VmWXN5WEFkRlZU?=
 =?utf-8?B?UmQ2R1lLRGdQSUFGT0dYRmdqcUlGazUvV1dodGNIVXRXZlY4eEg1S2t3Q1Zp?=
 =?utf-8?B?TmVmRWtKVVNOZHoxMkNueWYxUTlldWlaUWhOaWt3UWdYRGZlM3ZxdWFaMEg4?=
 =?utf-8?B?d2hYS3BpTHdNM3ZyT0tRaWt3bmJSemRYdjF1Z1lYTFJiemVMNlY1MjFoMktL?=
 =?utf-8?B?WUtWS3dxZzVFNUYyQi9EMjhuRGMzVC9KSkVJekZxNlVxaXFSRUV5aExIRTNX?=
 =?utf-8?B?QXd6OHoyN0RCaEJuQmltM1JMemtyeE5vUTg4NDlzQ2pnd3ZUY0hKSUNYWHZ4?=
 =?utf-8?B?M050MXloSmJzY0haSHF1ZEVreG1xNFd6QU5vbHF5MEp3bFNrZ203dFk2Ykkw?=
 =?utf-8?B?WHMrN0lZS2w2UmVDNVY4bS9SSUt4aG0zN2lmM1grWGhNSUloeGtXZkRySDNG?=
 =?utf-8?B?bDR5aGdXLzUvNXU4NzZaTDBhRDRHWHhrTGlSYnNYWVZ4NFlJdzNVTFREdG11?=
 =?utf-8?B?TWlmd3ZaZi9TN2lzbjFncktIL08xRFBVN3R1QzN5TjNLdmlFK1dybkk1SHhF?=
 =?utf-8?B?TjFBY0pPVHBTeGRtN0NvZ3lnUXdTU0pzMmF3MnZNaTVmUW1Hdm41MDZkZGpD?=
 =?utf-8?B?WW0xZC9kMlZDNTQyUmNOSk5lbFdzQlc2cVF3NlcvVjRhZHBTUFpEb29ZQjR2?=
 =?utf-8?B?S20zYnFkUG5lY0pwcVVDT21lY3lFK2wwLzBxQXREU2ZyL1gzLzZqVjRWdHFT?=
 =?utf-8?B?TU5UN3c1S3VLMWY4NWtHZXJ2cmJsM1ZOTnUxMGJkODFNb3VYUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f77cc27-8953-4a5f-bc53-08db6e7054a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 13:48:14.1308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51POcw8hnUxhG/8vEMRqiug2jmSj77MD3kyTx559UzKPP9JLPcVVvzEzyP2xT7YaFLeSMq9Rin4S5RukCfcb8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4422
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160124
X-Proofpoint-GUID: DrImtSe-i-cW-aBPRzUicznaNn3zQaJJ
X-Proofpoint-ORIG-GUID: DrImtSe-i-cW-aBPRzUicznaNn3zQaJJ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 04:14, kan.liang@linux.intel.com wrote:
> From: Kan Liang<kan.liang@linux.intel.com>
> 
> Add the default tags for Hisi hip08 as well.
> 
> Signed-off-by: Kan Liang<kan.liang@linux.intel.com>
> Cc: John Garry<john.g.garry@oracle.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
