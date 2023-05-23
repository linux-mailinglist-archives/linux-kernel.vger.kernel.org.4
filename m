Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BB070E0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbjEWPs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbjEWPsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:48:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEA618C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:48:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NFSkjx013467;
        Tue, 23 May 2023 15:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gmXOQdl2SOunsaSfI6TpKtQMku70+v4F00JH2b12tFY=;
 b=p+gw8enng6sQeH8bs/9ZlniWrie83yWHxPxpJ9Wq02ymXT2khFOibr7092fjlGXjvxNN
 5m3lUdBMA3z2NJJFuxLBMARVRyY9dgmN4iGiNMxAIRiMm4rCmETX2A1A9JXKdbJIaueR
 sNKer9iyfmdO1JaZYXWcW0+fvlJKYXi1yBGgv+zFWczoooAUT/ALAGr4SWo8aFlHNu51
 OBEdm4IvJp4JbyFRZoqOdNxBEiaJqZ8Jy+vM/TX4a3ZppnC98uv0uhUAHAuRG7RczV5k
 5b1gEy1Xs5l3Qf8BrjAUIZMnTTBdAD6XqdWmb/cePRjqVJBtwD2HchNa4XuUrJZgpmin kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3qnfuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 15:48:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NFhMjU015775;
        Tue, 23 May 2023 15:48:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk6jh67a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 15:48:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q03ogrDEC8z5x9j/BpaTnfX2/rImiyfjmQGvyRU5p1fOliz+hhoKFbhpPlc3YDjGQYbT/FuidQ0bEF/4pwtCuozFfE6cvUTK83xlwr4J1yuUfWOqNq0BR54Qv+yOU9LdipuHdTD7wnVzPIMK8xHjhOPFy7+KgmqAZ7yUb3lTTN8MruXs39OAXp3xvE5U8oaztpOmW4A5zuCCmINbrivmeyx3PS7bUT3jbolj9fAIuaRGGtDOpC1XxvGRV5V30+jvEOYjZnVZIsmm9pFNJbJT0SEnOe15ceBwCZwcnwfgRYSMQPCRhX9T5jo+1yIsMov6EGMtnOP6sIFivRT+o2ZEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmXOQdl2SOunsaSfI6TpKtQMku70+v4F00JH2b12tFY=;
 b=i0Z8NBBBlK4kosqP/Brg15hXTsGc3BOchtm3n/ntW0J9zG4bfaa14VfwnYPINMpDnA5fqqtROqSZMkfKvuhVpUCkDlHgqjW4wJV/XArcEerjyc567ZX3qcoM8EJEDNeptiEBfO0VQhC+IDa3AiboFm0ALi2ozl+ETr/EOaKDSxvpNBaQCohnhIFkmEsSiYDxB5waYeF9QejnFL02OANixYWEhzTN/tY7kUUdfE4maW3QiTZesALYyDuweWV151taT2i00qamprzALg3IdS6EpvmrBXadFEw9FJ4DYIXbZ8lcn5kpM4hJGfe+GJUVJV3cV1QRpUzoDoPrW1KLc8JNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmXOQdl2SOunsaSfI6TpKtQMku70+v4F00JH2b12tFY=;
 b=Ii/LGjtkrkTdd1yDRKt1YE6BMGYAdPfn9sY+F5whwDzipn5+ViYQU+6Sl1CF1WCTMvdql/EMP/HeeOzftY/xA3QtBqu6tUUHMzIwuLrVPBFFsgyeU5YgW5P1CWNVKaYYxUfYu5NZwxECyoZoo6sTSVQZZa1YD7bUZZfwEB1yv0Q=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 23 May
 2023 15:48:21 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 15:48:21 +0000
Message-ID: <8892c180-204c-f6d8-a166-fdf5c938488b@oracle.com>
Date:   Tue, 23 May 2023 10:48:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, brauner@kernel.org
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522153852-mutt-send-email-mst@kernel.org>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230522153852-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0025.prod.exchangelabs.com (2603:10b6:5:296::30)
 To CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7cf8a5-10bd-427f-0183-08db5ba5226f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBPE6mU/epMbSazedSYgHNQS/RdlQ7b/hCGB1WjuSkjAMkqNNnGZ0g9mxCdpfya5kdEnMzGRULPCUDzw5W0jPJXb1pSXHS+AaUKlGKdWH34klLF/809oPdbOD5NNEQnf9FZ1VkEn3hwk9OCYexazVsMuTpUHT53NDc3HK8LFB77EH9pB1mAkqmKJV48lPRlCyAKSWWENlQ09S47iP/DUja/JE/G8KP5xdtSB5EeSDOtwM+94kc/3XTuSOuhzZb828VR5vbnkL5YeW1Nf1ciqLLiSp6OWkeghOQxrYa31D6A9Xy0TleK+rHp446NwqdyWFEaANf6zDdCRzC6sm5pYFwPQXowFVV1VCCz2C20r5bvPDJzaqrX31kJ6fGpn5oKVpJmdPvhYT4MIcIvW+Kkd6DlXoqGxdDfSHGZY+lE7I9Y4ecZ6TYBuH4PucV00H8eyYBDhtCsYAVoDFGG9DRz9hduL7iAtZ804TLqU5gXpHK+TMMztWZZpm037uHR90YQ95ZpXtsvz5lcdlZOX5rDRdlu/6baDBlciP/ok/d6a5Du8S04HDD7JWDpcsJuGiKAPmft/llcZVnGDGO62aGJb/zLPlOJF5dmVE626M34tWrHidlJqjuxoUM5ZZj6Cm92E74b47eyLs85/G5Jo9/zN3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(478600001)(4326008)(6916009)(66476007)(66946007)(66556008)(31686004)(38100700002)(316002)(31696002)(41300700001)(6486002)(86362001)(2616005)(5660300002)(4744005)(2906002)(8936002)(8676002)(6506007)(6512007)(26005)(53546011)(36756003)(7416002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVBtMFg5NVgxOW8zNWtncmNHeUh3NWhlVUprTExVV1dkb1pCazI0Rmx3UE1j?=
 =?utf-8?B?NGNVWFJNS0xMcUVHeDZiNkt4bG4xeUc4RGJjOTZ2NGNFNDFLcENrdmh4aUR2?=
 =?utf-8?B?WVJoQXlhTmtuYXdvT3cyREgxYUNVV3JHY1FYendheHQ4SkV3aVZVcFNGSVJE?=
 =?utf-8?B?Y3ZJWHZPN1o5a3N1NzBjd1VPcFRPWEY5RDY0NUpMNFdqeEFCeVdHMzdibDFr?=
 =?utf-8?B?ZEl5eGV2dWJ4bExSY0VSbkRzNlNSLzNrdTJTYWd6R1VZTTRDSkw0R2hkVzQx?=
 =?utf-8?B?N2cyZExkS3ljMkl2WU5JQXVMQ01RYjJ4R3FwUnhFQXZYNDNMNUtYV2lGLytO?=
 =?utf-8?B?Vmc0L05Kc2VFVUx2TUEyOGw2bjc4T3RUL083aVRYNUdaZHpLTTY0R3haT1o1?=
 =?utf-8?B?T0lsMGx5OVhrbW1Vdlc5M1NsQ1pwTlpJYTRCWFhGeExKcFgxVXNQOXdGelZR?=
 =?utf-8?B?VmNOZTJxWWFNYk5iak4rNmFDdUF0QzRrb1dhNXNCU1NFVVdrb1BGVjl4WU5R?=
 =?utf-8?B?RlNMNnA1YlVmWTlLTmZ6M2U1cDA1WG5wWXpGY05ETkIxUlJMbTFoTWJoUFIw?=
 =?utf-8?B?azNuVWpFaVMvZDhzaExCcmdvQXJzY0Y2cXdXWDc1KzhDNGRaYWZZWElWN2l3?=
 =?utf-8?B?ZFFsT295VEhGaW5QOWlXS01oU2lJT0MvYlkzSnQvdUx1Qkt4M2QxSTA1N2dL?=
 =?utf-8?B?d2FlR3huczdiVHpjazlwcS9jM3RwaW5xcnhmVTRkQ1pMZE5vYVhYVlZlNlRM?=
 =?utf-8?B?K1h1MlZrc0RlRFJKSlpIcE51cVp6bmdXdFNzbTJpSm52MnY1NDlNTHRiMnRi?=
 =?utf-8?B?bGRxQWFEN3U2R3lwdEZuelFpOE9pZUtYLzNUQUlQVkNCRldEQ0dxYjhIemVs?=
 =?utf-8?B?RlEzN0ZiVmE2bWtlZUdNeDAyZU5oeHJieFd4MlFhMVZqYXFPVDN5N2FHZG9V?=
 =?utf-8?B?bGlZcUZNbERKTWM1dHF2RGFMbjB3VlNWRmRpaDh6TkRaVmVOd3BSSXhHblVI?=
 =?utf-8?B?QWgwY3lGRU1LVGNrL2NWeDM2TElNSDZTN3U5RENuRXRaMXdleHRQL0JDOTcv?=
 =?utf-8?B?YVMrdksvVTJSa1FFMlNPeFh1NUg3YTJJUUpsaDY1MDYyZWZFVnRTU1FnbTU2?=
 =?utf-8?B?OVBrdTJsLzVYZ0Nsb2p4c3BpUHJXaTR0ejlEV25EL3cxNmxHd1BXUVBvRU9l?=
 =?utf-8?B?ajBWQmlRR1BkbGg4VVNVd3h5QlZPejhCbnoyMjdzSlhnODRwNmZmZFgxWVl4?=
 =?utf-8?B?N092TXcyTytMY3lPTWRsbXJiY0RMb3U1dE5oRUs3eldOOWxEUFpjNVRFWVlq?=
 =?utf-8?B?Znd5dmVUb3NSYXpDQkpsYS94WW9YZVFUdGlRSGs0Lzc4dSt1WlF2QW5wOVcx?=
 =?utf-8?B?amNWaHNOdUtMTm5wRlhnbUpteUViNlJadVIwQitoYU4xYkNZZGU0dFZJd3Ry?=
 =?utf-8?B?MDRmc1pPMWpvRjVURG0rbUN0akZmQVF6aVJmTFlCSUZGMXE0bU1mMlMwZHF1?=
 =?utf-8?B?UzZvYVo2emNIS2YxRVE3SnpDc09rR2pYNjZKU2FTREdSS3pGRzdHdC92UDc3?=
 =?utf-8?B?bnJJRUhRbjBYRXBMVCttYm81bFBHRVpCczdQZmc3azYycXlZYThUOE5RdHh6?=
 =?utf-8?B?bDIvREhxQkcwN3l1RG1CYkRSS3g1cm1MMjFLZExabCt1Tm01R2lrT2NTNHVk?=
 =?utf-8?B?Tmw5cVpEdVdab25hOTV5WnpNcXdRaUtoaFora0kwN0lKMnp4YjFiYXYzQks4?=
 =?utf-8?B?cmhxc1JGZTk1bkFpTVhZckxpdThKNU12VC9oM1lHK2VhZklGSmM0eWdCMWFs?=
 =?utf-8?B?ZVBibDgyVGF4V21QeGE0aHVvdDJZTUExTllhdFo3Vms3UUthTWlTZG5RcEJK?=
 =?utf-8?B?WVhLR0xaMklmWmhlVkRRYXhJbytDY01jVG5XVUJUN3VvVHAwcUxMVDNLRmhI?=
 =?utf-8?B?dGdlUFArV1JrZGtJeC8wbXVkMzhxT1FvNUhCRXJVMGQvU1ZYcUtiWWxGa1Zw?=
 =?utf-8?B?L1JwOVNNQzVwZlBDaE9veGlxaGtiYUhVTUNUR2pDNWQ5RmlTTngvRTlMQXoz?=
 =?utf-8?B?dC81OGZFa2JlMXA3Qmk1TFR0bEdoaU1uYWJBaHRmdXhYeWY4SlpYQlBLcC9I?=
 =?utf-8?B?a2JCbWpTOU1md1hoR1pTTmU3ZzFRbGVuc2dQTlRYclFhWUx5SkZwTjhsT1NV?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bTc5c29Fd0VLWnAzd0FoYnNjd0FJQW43eXlia0pxOE1mWHIxQ1MwNkg4aElS?=
 =?utf-8?B?eDV1cXNVenpmM3dsUitrZkxCYmFKS1JLYlZLWm9SdnFucHpHUHErM2trQ1ZO?=
 =?utf-8?B?eTFXdjJ5YWkrZks3VUJmVUdOOTFTWnJ4ZFIwcmthcjRZclRkNGhmTSs3ckJ0?=
 =?utf-8?B?MExnbU9vUksrVEJGSXR4d1J0d2N0Mi9MOURQSGt5YlZ4ZjBYcTNhSFR5V3hi?=
 =?utf-8?B?eVY3ditNajk5NmlQdjhQR2FLNnVwcjYzTzI0Sk1lT3d4aElCS1ZPcW1GaU5F?=
 =?utf-8?B?dFpadUtKa0xnTGpQNUFpUWRFRUplZjlaaTQ2RDlwa3E5SFd2bTZycUl2N3Uz?=
 =?utf-8?B?N20rV1k4UGtYVWFWYVZicURZVXU3N0ozV1N4NEE5WFpYVWdvZ0NGZVU0c3BU?=
 =?utf-8?B?b01HRXI0TGttSXFJYnZMN2c5NFVPMUo2bVZQQngwTjhpeThtbHUrQzJ5djVW?=
 =?utf-8?B?M0pJOGtwOUNrVUtJMDlXY01EVkNldDFwcDZkK2tnT1pDTlFvdGgxY2RYckt0?=
 =?utf-8?B?Z21ORjVocVNhMmpZaUFFUEVrNWYyS1YxMkNEbzVqNjk2MFIwY2hlQ3dBV0V6?=
 =?utf-8?B?MkdkaGdFT0JTcFBQWk8zdHRqN3pyNUY4TmFBb1hRTlBSeC9TWHJJWEUydllM?=
 =?utf-8?B?UDNxREJxZmxjSElrSUNGRmZzS1ROK2pjSTR1ck9ybTF0VWsvWXZ5djhmWjFr?=
 =?utf-8?B?THY2bjBtWGVjWGt3K2hrZFVOQ1dyL090RjZhR1NneXpIZnlSNDAyZndRU2Mx?=
 =?utf-8?B?QzhlM3NyaUViQ3lOVDhKNCs0TzcweUxETFJGQU11NnJCbi9KOThDUVZacDFv?=
 =?utf-8?B?L3JuV3FHTHc3V2V5cEZzY0VSWTdXRVVZTDFTdm5zMjRQeUpuR29KK3YwNTg5?=
 =?utf-8?B?bE5ycloyTnpJTGZZci90OG9qU0xoZkgzU0RKdHNWakVwdFhvc0hGSkpya3hE?=
 =?utf-8?B?djdxcS8yZGZwYVNpbGZFQ2hXTHF5MmRIcW9yNHRDeDdzUmZkZmU2cVZjYXN5?=
 =?utf-8?B?MlRHNW1WeVN4bTNycTNZRHRRQUh0Z1VqSWFaelZCRHBacjJZYlN5V1JsSy9o?=
 =?utf-8?B?RkRWNzBRNVdMUXErZ1NGVDNrVUpTbFdNeGsrKzlWTnFGeERrS1U0bFlJcUJB?=
 =?utf-8?B?MDNlWUNxTHp1UGFNdVF2cFRqMC9FbGt1SDZkOG4vY3FEME9sS2lVNy9QWExr?=
 =?utf-8?B?bFNyYVZWRFgxSFpDYzZTa044VUNKYWNEb2tjL0wxd1pDQm9lYXBqbG9NcDBy?=
 =?utf-8?B?b0dNd1lMaW51VHV4U0k2QVB4Nm1iTkpRbit5bVVEdnA0MU93K1d0RDUwS1FD?=
 =?utf-8?B?SzdQZGlNQzROSFdjQSs5WkUvU2hZUzN3TzU5aGJucmlYU0NtY0J1bWZGS3JM?=
 =?utf-8?B?bjErbVRpOW1JUUI5LzZ0Um5VaDIySGN6VC93bG5QQS9TcGtadzcwZkw3dERG?=
 =?utf-8?Q?fy8XTyfM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7cf8a5-10bd-427f-0183-08db5ba5226f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:48:21.0268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqWDl/umEba28gcmU5LW/fuVboM8PhVszp6DB47//rm7F+S/z/IXo+mzkauyKCdmuh9iXHSEum7JTUzdHbVjV1q6y9R6OrWCweq1EKScflE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=949 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230125
X-Proofpoint-GUID: Og87taKYkGycKWjYv2HPZqhLQZ0roxAy
X-Proofpoint-ORIG-GUID: Og87taKYkGycKWjYv2HPZqhLQZ0roxAy
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 2:40 PM, Michael S. Tsirkin wrote:
>>  	return copy_process(NULL, 0, node, &args);
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 8050fe23c732..a0f00a078cbb 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2891,6 +2891,7 @@ bool get_signal(struct ksignal *ksig)
>>  
>>  	return ksig->sig > 0;
>>  }
>> +EXPORT_SYMBOL_GPL(get_signal);
> 
> If you are exporting this, could you add documentation please?
> 

Ok.


