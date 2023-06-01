Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8688271F6F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjFAX7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFAX7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:59:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D406C18C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 16:59:16 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351MLVQC008025;
        Thu, 1 Jun 2023 23:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1vRck28B72IdPmgUABTLokFsObGKW3UKhz/9Z8iq608=;
 b=FZWOJpLqrdYW0eY1Fbvcik/fOAk4PzQGuy1W2lXKX1tJPjP0BVgti7MWNqhFB7f5Sc69
 vroW5/xARmvdfL+08x+fdbM3r03DEwBrdnUchnqSA1S2dawWMnL/JzqloUBVINnB4/3b
 7fqraFqSdV0MoIDKEaar7fntX1UEGui04NvXuUWySQ1E1ZYGDavJTSdK3DOmLxAmMsgb
 Jyks7Buwea3EIQ6huFEfdEkW+/iBD75CRti9zHl4rr0JhRCxmgoQ6FED2YdMoFyi3xvm
 ZbBilcv8cS+mfkeYeNIeG7iwFWl3DKbfZX+wGVmhMl/4mQBxnRCgncqEVfvZffYP3JO1 Ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhda22cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 23:58:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 351NZHKT030024;
        Thu, 1 Jun 2023 23:58:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a8mdr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 23:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDI5eM12v/MfZ8gD+8WUPpf2hoMrUbtsvNnAmHTJWb4Xzb+3RXctmHMhiUOoWLn3RWLKEqnbZP21M3/oM1xgNiKptGoV9HtVmfkuASDLBDLheip2KdPxRu4b8MdsZddULZnSNf/qTWeG8OfEdkSpcJVih91G/aMKZVyPSN7etUg4VrEuRVIUfh3IEDQx9jP1RLAzdn9YG8JYhrGvlai+pawVOmNT4e7gCijnh4vbFxex7S4e4ft9/J+YxKc7oITiHF/TWIejWZsIO5RT9eleKbi55QIO4j1uTeVQBtkC/bA6L3i9U+XfpeY04wd/8GF0UavaMaXSrYlSnfTPEmYgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vRck28B72IdPmgUABTLokFsObGKW3UKhz/9Z8iq608=;
 b=MnEwIVLEAbzj10tCK8zRmIwOecyamNrhr4zqFMp1nt0EJV9EKqm5VsBRzGPM5iiVudHNHntt9X99GfkEWbTY+8xF17dgMoJ/Wxi4p0fo75x+4iJkOv8cWDtHXdUH69BlHfkA1Ifx74K9aqLvcLR+uzQrrI6Pe7cPpdJfglWBiS5lk8ELjMmntEaCylS+9aITx595neV2wd9nS2h/DG56k1G0KmkDkJAs6OTdBoPkOViqz6BBjm2ZqXSXhxtrdNkHu0DdjJxJj0UytdDZaTSc5oD+7MbPjLJ96hc0M1jeTjw0gp5wLUIrualYh0sLyTGIRGbUbMsxCaNBVo1safl7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vRck28B72IdPmgUABTLokFsObGKW3UKhz/9Z8iq608=;
 b=uxCKGKEj/KM9W3fIGh1DRSBu7SSXZJuInsDrSC1EFpNhgCG8iNZwzgjEvm/rWoXfS0XNSU5gNrP6uU0N9TQZiIu+ZwvP6CmnEIUi1MURlmsYhmhFqcoh4FJAHOLMBRV38Y2eZirU8GBU0fSE3mXod9GK/AKRKl4g5MQkiEXSmtU=
Received: from BYAPR10MB2438.namprd10.prod.outlook.com (2603:10b6:a02:aa::22)
 by IA1PR10MB6241.namprd10.prod.outlook.com (2603:10b6:208:3a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 23:58:15 +0000
Received: from BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::df1e:af95:f443:470f]) by BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::df1e:af95:f443:470f%2]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 23:58:15 +0000
Message-ID: <ffbfc4be-4013-574f-0ec1-f05982887775@oracle.com>
Date:   Thu, 1 Jun 2023 16:58:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC v3 00/21] Preserved-over-Kexec RAM
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
 <ZHf/Os9v2cx97Maw@MiWiFi-R3L-srv>
Content-Language: en-US
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <ZHf/Os9v2cx97Maw@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::15) To BYAPR10MB2438.namprd10.prod.outlook.com
 (2603:10b6:a02:aa::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2438:EE_|IA1PR10MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd7372a-1597-409c-e7f7-08db62fc1034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwIKxRVYQYL9vwBj19Rj0cUpvgLYPv7r+KN6SL2Xm/adnN/OPZCXM69zhjuCW+K3UX9fDBt21Or7hsznQTWaovk7wBZBDXnP1xxo96EiN1M5YfgIEsda8MGx/5SHCSXzg5CGRzQ0yKhsLt9hMkIAdSVGsCxc9WyACcIfLgEueuDFAQxnORi0HAsqBMUsdkrveAnKpIH1woz9bRxsEgO0Tj9/LeR+dmoZSp6dmMUXOdCFRyNtmgLxtebrqQX1gOP8SUNA4ptEWOE+/+D6F0M7jlXqb0a8piE5ldmbeq2wZOdbKBdvDpALB0rqlmUS4WIPQ7F4D9b8+s4hzKipWFBa0J2Y++iOD3LGLezNg3AQhL9Z1E6RHu7F78SV9ClwNKGKW2ES5vKyi56uU6W+ejfr4UhOKm6xJNfnLvodQWQrSEe150vkKJMUNYJ90Ca4rbbAb8JQmGY5zySbmGiTGBqRO44oI2xlcFWCoAbwLF+/ICRow5kvrMurAi1zLmaz7IsHlqMCw9+b7qKhIHR1xJerwqjbY5GVQxttOLCe55LqLUU5YVXtHYYqA9BNpRO9zblEiwVIr80gU4qdLQlST+3eHPdwNXp2l4G0wRiLjrNRjTwDiSvuaJ/RpS05bmYZPYplTH65H53J0h+rl2bBdJdnBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2438.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(451199021)(6506007)(508600001)(6666004)(6486002)(36756003)(186003)(53546011)(83380400001)(86362001)(2616005)(38100700002)(31696002)(26005)(6512007)(4326008)(8936002)(7416002)(6916009)(31686004)(66476007)(66946007)(66556008)(44832011)(5660300002)(8676002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZzWWtDR1g2MnFvQTRLbHN5YUJjRm5KSjVHdHVzdFFwTERQdnd6RVJxN3Bv?=
 =?utf-8?B?VkJOOUYwM1dNVTAvTEhoOVdTKzJ0SDRJQ0RNUm1iWll4RXdEYjhFVWMvaUNB?=
 =?utf-8?B?WjMrSjdscUIzUnl2eFdhbUhkSHdjS0JtVHlxS0pvaEFKNm5jNmFPWVNmL3J5?=
 =?utf-8?B?WjllbHZKRmo0SWtQa0dGY0dzYmh1T2Y1a1huRktNNTlzcjBYSXhxb0tpSnpS?=
 =?utf-8?B?N0tYWXBUZTFtTVVUWDVuNk0vOHNLS2g1bU91NFUweithTWYvOXZPYnhHLzZC?=
 =?utf-8?B?MTRGaDcwTTdZTUF0bWw4WHV2VkRGYUl1M2NnOW04RDNnaEhwYmZEQXF0MXIv?=
 =?utf-8?B?MmM5QnV2dHplTmtnMURNUVA3emorc3RXV2NsQU5BMnZTOVhCVnJMK0ZSYVBK?=
 =?utf-8?B?SFlRMHJ1MzVaMC84dnllejRpWmx3STBGcVM4aXVHdENYSlZPWkJVY0FvMkV3?=
 =?utf-8?B?YXR2U1ZBZzl3U0k1QUFacnBZemxid3pBK0F1R1dzT2hjZzc2cWFnV28rUWVE?=
 =?utf-8?B?S0tzRGJoNDJXK0xVcjI3WFdCSEdiQTM3RHNZQ1RMZlcxZDFmNUVMRi9hM1pV?=
 =?utf-8?B?TjV3VGdNZHNFOVhmUWt0MityNEh5UzY0UWNhR0VXcnZ1N21FMXNGZWNjc1FS?=
 =?utf-8?B?TnZ2TERDOFd1UUlsRDZaeE1weGp1WmZrYnJITmlkTkg0SUdHdlhmWDN4Ky9s?=
 =?utf-8?B?YWN4Mzg1YWhoWFRkdjNJTXNhWHkzcXA3dmdSNmUxanZtamcweEtaSmUySlBG?=
 =?utf-8?B?N3VQNVA3MkV2TmdvQmtMQWVjeUR2dFZmUlI1WThOeWxQRlQ4dnZ6UXFRQ3Bp?=
 =?utf-8?B?a3V0WUpicFhna0FqcEwxQzdoZ1RXWk1UUVkzYU5IOG9RWFdBRGtDY2pxdzFH?=
 =?utf-8?B?V2llZ0hGaUF6N0tZN2FzMURIa1M4bVFqclFlcWx0bFlDMkdqbEZncTRNRHFO?=
 =?utf-8?B?ZitFWW93WFRFREw3U0txLzc3QTRyNEMrcEhPV2lJOEQyNWJBK3k5dFpibWY1?=
 =?utf-8?B?WlovaVI2UEJxZXl1c0dDaisvQjZBc2YrZksvdUIrU2dhSy9ZM21qKzZIMTZU?=
 =?utf-8?B?by9YR01FQitkOXU4QVBkUlV5blJzTlVjWThueHV6WkFnbUNON21td1kzOG85?=
 =?utf-8?B?elFjdEJDendNcElBb0VESzZmc0VjbEpDS285RGRnY1VDNXZDcHQ5SzJ6TkZz?=
 =?utf-8?B?Zmt6M3c2WEhzQXB2TGp5T0xyMWdrdU1YOUFVSCtENVdqSWpEYU10OGxlRzRj?=
 =?utf-8?B?eHAvZTJIaXdkNGlreUM4Yk90aFlBZmJWMVZpVXpWUnBJR2dCa29ucmJ5K29E?=
 =?utf-8?B?K2NIYVhNdXhjMlFGL1RLMWFTSU5xbks4SHRSQ0ZKM29XdnBmaUl3TzR1aU1w?=
 =?utf-8?B?SHUvYzd1OXNUZ3h0UERaS3J1N2RBTjhWanpibkROQXBSMjU3QWZwaDlsdFJX?=
 =?utf-8?B?ZDVRZXRqU1dEZXlMcGZ1eVNnRFAyL2JSMTFNWG0wY1NSQXJsYWhETVBvUE04?=
 =?utf-8?B?OTB6VnA0Z2htU0pIUWtuLzBldVhWQXcxeVpURDBrUk9FWENaNmhMRzl5WG9M?=
 =?utf-8?B?K2t6cG96THEwaENaVVhQZ3dCUnc2NkdVVmdEbFZhVnYrMHA3RldPZzJHczk2?=
 =?utf-8?B?RU55cjFrcXVzQisxQWZneWxybkU4WWUxYXdTc0FNdThQN0VsZjBzZEdvYUVR?=
 =?utf-8?B?SzVRaFdXd29XSVpZdTd2Sk41S0NzSHZxTnRJaVlwQ21BUy80bmYrQ2FObm05?=
 =?utf-8?B?c0N5Vjc0VUcyU2VVSTcwT2tBd1hveVFOcDkrSSs2Sm53cGVsVXE4bXVyVTBK?=
 =?utf-8?B?RGpJNWQ1OE5mOEtpNWRoVlJDR3RFTW4vNzJINWNxUDIyWE9aWFlkeWswdjd4?=
 =?utf-8?B?OXFoVllpT243SDBxZE1FS0RzRWE2RDl3SW1vRUlkSTk3RmFmT0QrdnIwNkZr?=
 =?utf-8?B?SlNjK0JFMFpieEdiaVFLSTZ3SjlPNUo1MWIwVHRpWWF1dmVYMldiY2F2UWhz?=
 =?utf-8?B?eEJKVGdBVW83T0hzbWFpT3JVSDg4U1U0dElxdUhmRk5IbGlhcXh1WWNtL1Jm?=
 =?utf-8?B?c3VlQU5vTjFoODJsNTRaWXRmQjZWUlBSekFLdDZYeTFxaEp1eDVTZ3EvZ0px?=
 =?utf-8?B?UXFsY3BMR0V0enQvZXREbTEzTXpDRjdsSXBVMk91YnROUytlL3dPQStMaW9s?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K1ZZZ3cyOUVRb1lYQVVTUFZIWVpOdnFSUFFYUzB5RHQyMjBNMG91WHZtbFNL?=
 =?utf-8?B?UldUNmV2cmFmNG5XNE11UGZIemQ0bHRmRGMwZTJWZytQMzd0VmxLd1dseGMr?=
 =?utf-8?B?OWovUXZxM0F4VDdLVk53bnhGeFc3SVJnaDJxRDJvc1NieGtFanhRMHNUMkkx?=
 =?utf-8?B?TkxBZ3c5NllaVms4QzhmUEtzRTVIRHh1THNSWS9vb2hjaFJDYzNnYVFuaWRT?=
 =?utf-8?B?dS93dlV5ZjFGSTFKckkvT0VLdkk2bHNCS2RGMEhMbkFhamFjVWZBN2JTYjYy?=
 =?utf-8?B?amp4U3hzVGorTGpkR0l3K1NJcVBoWWk3VnRtZ2RxSkpPV1kyYmhqUFg2dW1R?=
 =?utf-8?B?WFpRZmpJTFV5U3JYcHFqOCt5OGdZTGN5TmNHL21BMTRiMGE5NGF1QWhGVnlK?=
 =?utf-8?B?N2o4MVZmNDlIaUI2ZlVkVFdNRjMvcU42QmdHMW1jalA5Ym1iQ1VHd0d2MEVW?=
 =?utf-8?B?V092dVVGWDRtODgrYTRZak9qbzhLMXdiVWZZdGxsRk80TXR2UnhMbW9NQUxj?=
 =?utf-8?B?cC9CRXlTZml2YjQzM25oS1Z6VVJuS2toTUpzK3ZWbVR1aUpJNzJVbllXYkIw?=
 =?utf-8?B?MEJtdFFpNWdaUXN6ajJuZDE4YnVmMmNGekdRblE5Y0tWVWIrSVNRdnM4Z2w0?=
 =?utf-8?B?bDhnMXZsMUg2UFJFb2VVRW5XOVgzcmZWYTE3RlJNd1IwK21RYWxNUUVDMEtS?=
 =?utf-8?B?UGJEekU5TjZqVGoxREF3aE0vNGlhM1QweTk1cnlUQ3dtZkx2TXFjcnNkT25L?=
 =?utf-8?B?OTFyY2VmbjY2L2QxQU9Ia2lSMTdlQVQwTDVJTmJ2RGVwVUV3Y1p2bk5ZdUVz?=
 =?utf-8?B?NkxqQlpYNXF6MjVXMjNpZUErZ082SC9Ub2x3cU95cUlQaW94VGF6Q052Zkh6?=
 =?utf-8?B?amM4d1lkaGF0OStKdHpUMnNldVZLdzFlSTlMaTlXUnlEOU9QcDlwbkV6V0xD?=
 =?utf-8?B?dDFFaHZ5MVUwV3o2NlJtYVNSRDlDdDBRTWpjZjZ0djBGVWVWK1RXQXFxb2N0?=
 =?utf-8?B?eTBmNjlYK1MxbnVhOEF6MjNOUFQ2VDUyYm15U2hYU25XMFhZZlg4OVphRFVt?=
 =?utf-8?B?aXdYUElIbEFQaC91dTZPa3pGbUdlWmNGZjZEZ3dEUWFNeUhOa3I2Tlk5ZUZD?=
 =?utf-8?B?MVJaMEZ0RXRQeGkzRjFoZWNWMUhLQkNqQkViVlFSR2Z3MGNTU1JhV2JxSmhV?=
 =?utf-8?B?bE5MS0NYSjc4Z2cyakFjaGppVmc4emg0amRVWm43VG5PUm1xVUZNYmtUazhY?=
 =?utf-8?B?dVF5RC91bDAvSSt3RlJTQVB4WmNSQTRlVzBpSnVoeFlMOHkyRXphc2NYUXFK?=
 =?utf-8?B?N2dQMm5LSC9nZmhoK3M3OUlRNXVmUi8wSXVlcUx2dElsdzZjbFo4K2xYR1hP?=
 =?utf-8?B?TGp6UHlFSVlWOXNYbTUvREl6OFNpcHY5KzA4SGpRcFJKMnI2eC9zYWlteVdH?=
 =?utf-8?B?S1RyOVNBNUlXN3BYOW9reEw3L0JheFp3TXpkMUVIbzR1bVJaZkJKMXBkV3FI?=
 =?utf-8?B?eFFSYW85aFVJNXpnVTk3T0EvZS9yNDFyYzVBcklDN0FEVWJlNlR5R1hnWUgv?=
 =?utf-8?B?aTFQRnhVcUdHa3VBeXJFcFd4cFVnZGNBek9DMEUzNGhXeWo5Z3p3UGl4L3dx?=
 =?utf-8?B?Y2ppNjY0SmpBaTdGenNPT2xENktxSFhsQ0hqNms1YkhqZDZ6Z0IzSHdtbFV0?=
 =?utf-8?B?aUVCN1VoSi9PK3lTRWZXQnNZTXhrZjNNcHlPMFAwSGNEckFBL2NwalErblVr?=
 =?utf-8?Q?nL7M36q4GuA+hY7+6Iz5IUSkOyLKGtzw0cYTXHG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd7372a-1597-409c-e7f7-08db62fc1034
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2438.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 23:58:15.0417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erhsGZt7rHJWHlQ0jXPqrV57JelAW3CKab3+WJFR4sI4NVRh81XliBVYUheAtvIMqTuY/blAUQopYNVq4S4VEzKPKZqluTXSMl35Ux6m9gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010206
X-Proofpoint-GUID: z3GtW8Vr6caa7NvLKmdKfHXirhhJwEl0
X-Proofpoint-ORIG-GUID: z3GtW8Vr6caa7NvLKmdKfHXirhhJwEl0
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/31/23 7:15 PM, Baoquan He wrote:
> On 04/26/23 at 05:08pm, Anthony Yznaga wrote:
>> Sending out this RFC in part to guage community interest.
>> This patchset implements preserved-over-kexec memory storage or PKRAM as a
>> method for saving memory pages of the currently executing kernel so that
>> they may be restored after kexec into a new kernel. The patches are adapted
>> from an RFC patchset sent out in 2013 by Vladimir Davydov [1]. They
>> introduce the PKRAM kernel API.
>>
>> One use case for PKRAM is preserving guest memory and/or auxillary
>> supporting data (e.g. iommu data) across kexec to support reboot of the
>> host with minimal disruption to the guest. PKRAM provides a flexible way
>> for doing this without requiring that the amount of memory used by a fixed
>> size created a priori.  Another use case is for databases to preserve their
>> block caches in shared memory across reboot.
> If so, I have confusions, who can help clarify:
> 1) Why kexec reboot was introduced, what do we expect kexec reboot to
>     do?
>
> 2) If we need keep these data and those data, can we not reboot? They
>     are definitely located there w/o any concern.
>
> 3) What if systems of AI, edge computing, HPC etc also want to carry
>     kinds of data from userspace or kernel, system status, registers
>     etc when kexec reboot is needed, while enligntened by this patch?

Hi Baoquan,

Avoiding a more significant disruption from having to halt or migrate

VMs, failover services, etc. when a reboot is necessary to pick up

security fixes is one motivation for exploring preserving memory

across the reboot.


Anthony

>
> Thanks
> Baoquan
>
