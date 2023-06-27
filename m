Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0F673FD94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjF0OQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjF0OQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:16:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3908CE74;
        Tue, 27 Jun 2023 07:16:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RD7927009777;
        Tue, 27 Jun 2023 14:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ptoUf+qLEH0HNT41koG1yGyOdIh2dmJbHLaq0ce3nt8=;
 b=UMY/9UceqLV5EpxI0Un8n8q7uzbZiaUvBHOmLknbjje7vUiYSC9MmZsGu/PVxG08fd+/
 ThKOy+Arc2ONzgM/k3cQTX13tzzE0S7a1CqR0sP9Wl+xgL8qYuLf/zp6i5Qn9DKjwrF7
 HZRpKOoZog457jjVr7amfZHKunopB3qzR0qyA4ITtpioZyglU1euJ+jLZY2tuxIX96lR
 kNPNKrz1buvkZ/IpaN9O8/gCboM9k28gr4U+KL+QP4yuQ4GXcWUlvFshHCq2jdmxOYxw
 tYRq9zA4qKKJ8b2Jt79xDP8V6xrULI+Z2AZTZcuuYvwElk5K47AjBHp834U/2tUSF71c Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq30w6s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 14:15:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35RDVHes004146;
        Tue, 27 Jun 2023 14:15:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxajtp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 14:15:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvDMozrwHQeG7hOzYB1Noadf+O/rRLcsdk+bACkBtbbkGPvLaUi++SAQTaRs8KANkCKNJ/b+GCVaIVh7N1JuAParyEAdVHdgGf42QeKg0mDtQUmmUxX/HOa+3YXpBTBsB6K0x/IM6QDFWBoLFee4yUj7foH5wGN8tQGk7sD7Tu3xcBdUOvjVjn6bJzlYUZa4k3CQib8Voy2h+RgFw4WbE2H4aPX/MeCoE5kgpcUkQ9NIr+fDI28EvYoZT1APuvrU9OLW2m7InZjKkMOWn2Bg59nNceI4+proBHiRAWW0d8WUZKFeJvq5Y2mNnjeqaN+kKk7OJg1zsDvj83FyTDJFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptoUf+qLEH0HNT41koG1yGyOdIh2dmJbHLaq0ce3nt8=;
 b=lkZFhp0YDSh0kCHFmX7j5cbF5qa4tS6m/wP3kjRi4Sf6qF0JZV8V41nFI3ico16HjVaAEqr1zwWODr/0zs+R39daje57KWYuQoqNKWxCncVSARc5V9T6Uv2Ba/XewQdF9TJ7oWtuYHuB/M6GlhjcykDN3IS2MQ7KK1x7zlGeJ3nHIdEHqiuojjV6L4iKr8mm17s+P+YTqmb59iloIo5sYXEbXEnPJiDAacYQgsebwee1X1mLxY7QdPWZSCvndEKIO8bgzEz8hJsyUdO9P/6lrRUEzFmty3nAl6q7Mwc4cSXm/NZN1Xfu1SI9wMclJXRXyjrG2UhR/L7h5UBoKPktdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptoUf+qLEH0HNT41koG1yGyOdIh2dmJbHLaq0ce3nt8=;
 b=ydAKQ7rOWdeKD2hJSFn9HgX1reH4oZToSZEn41rf0aUWxbEPz7jl9cQ1uc5y26SnmqR+gwSLY+jPqe8ZlWCkdqm38bw8wsW7clb2NrA+XWcxgyME6ruYkBLDsAax4DLEN20n29xj4WE2mUnSgtlwEipWQfpB8e1tOuVsx+ydMiM=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SN4PR10MB5638.namprd10.prod.outlook.com (2603:10b6:806:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 14:15:20 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 14:15:20 +0000
Message-ID: <a4e89d2a-003f-9dd3-d7be-b69b295c0a34@oracle.com>
Date:   Tue, 27 Jun 2023 19:45:06 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.4 00/60] 5.4.249-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20230626180739.558575012@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SN4PR10MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: bab6f925-39e4-47e0-1947-08db7718f03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ne/YzRz/ZlEN3QYKttn5D5Gt3TF7oQiHUrcZjmldvcgjJgUBoSJuy0xGUQUmIplg9IMr8NER5VnbUNDd0WBqVwAoDvbXTLwd7yt49LL2KL+Vqz8J/F3tzHpHNETx5U6IOXxmyg1df1pv32w1+27cKPCSuQYFqOpE7nDdkG/NXssdAj/F7QzksoTQ5CGBGFe6E34VqunqEqTmq6TwWgTiJtNZeciqAEI3CH8v+uWmMToNy+zM3+pFB5ZkymgzHUqHImvVhNE8Yv3ZFxF4vjW104NpX1Pi6cAjkgo+qyiKbdiCkdRK0VYhyKbGmU2wvIQoVJgQ/N8GBq/4o4tnMYxqMUK4e/7hGPC20KSsgdsX18ueCTmDIHaxfVA7QSddDeAFE/Plg653oGfsEX6FAuUcYrWtFFcQVoJJDC8g1FUK8MAHAcRf7nUuY+omERaCn0MAtAFjpoBuFFPSQL3pP/dIrIyuLKUK6dex4k5FnIoUxoeN3DgdxdFNtv2Bchw8ERNap3LtbdsFbDBLXgnHbr6vRDpdQoruZAIS5GK2UL/aXHom7noiE7EI2e1y79lTnNCndV1uoStzEk+lpG+ITEME4qWUExLtXznvGuN6wXW9KOyOi3Q6gIbSc0bMO+DJrbeEU6E47FyQsBvEHkoN1ZyxPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(8676002)(107886003)(4326008)(66476007)(66556008)(66946007)(8936002)(316002)(41300700001)(6512007)(6506007)(186003)(26005)(53546011)(4744005)(966005)(478600001)(54906003)(6666004)(6486002)(2616005)(5660300002)(2906002)(7416002)(38100700002)(36756003)(31696002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUFjSjFrQ2VBVjhqYUNGVE5XM3lJVHRTS04zWE11c1BGdG1vNms2eXJkeEts?=
 =?utf-8?B?YVpxTWlVS05iNUFHVG5DSExsMHBiWlFUQkg0NXRndldPNmY5bGxCa2czbXFm?=
 =?utf-8?B?T2lvY0wyemlablBJUUZCTlFndnRic29EWkwxSTdmUEpqQnlKMEVjeDd0bmQ5?=
 =?utf-8?B?YTNiYmFIWHNVYUtBOWM4bWRueU1UQ2tObnQ0cnIyQ0YrZ0hwZXlSR3VTUEdp?=
 =?utf-8?B?bU9KODR4WWtaUEk2TFRBclllZGU3ZzIvNHRMNU5DZFFSTnNCUTE5MWhpTjhI?=
 =?utf-8?B?aVZFWFNXQllGaWRGcldFQXVyL1RUTVpheWRvRUZZTUlnSlRQWTJvcVlWV2Vs?=
 =?utf-8?B?a2hIbGt0anppUzFKbjJqK3JPMkI2K1dwTjk3U3IzWEhBRjY2RkppYndyLzgy?=
 =?utf-8?B?YUdLYjVHRlJaaDlqSWJBRzBlK05hblorUDh3S2tvaER2NVBLd0JEYlFuc2Jn?=
 =?utf-8?B?YXVFZWVKZ2taK3l2dUswSlRtbmFqK1Z2WSt0bWFIRWF3enJkMnhKNmdmcWhY?=
 =?utf-8?B?WWFSV09wNG9KRTBjYTBBdG5ZZ0cybUdiOGhSRUdhNFJQTHRpZTZmMzMzRTdh?=
 =?utf-8?B?eEtZZkRHeXBxVXlpZkNrMTAzN3dmbnd4R1k4cUhQSXlFS3hDbzBCeS85NGlr?=
 =?utf-8?B?d0pzMXh3ODFuZjNwVDNVbGlQdXRpeXl2bU9KZjJYY1Z4NUJzYi94bHgyYzVI?=
 =?utf-8?B?Smh6UzhRT3pLc0NiT2ZLM3hCNldtTEdZRXhMckJJVERpOXc5dmhTR0w4Zmov?=
 =?utf-8?B?aFpFSjdlMkNFT2xHRWJ2UHVKQ1J1MXo4NUltNGEzT3ZDOUlYN0QxVytIOFhl?=
 =?utf-8?B?SDZPbWR6RFh5TlZwOXg4QzBzaGpmRmtFV0p6OWlhaGJkbUVWWHlsNDY4MDFQ?=
 =?utf-8?B?KzlSRWh5RnFyQk4zbzVncjhBSmx2VmJDSGc5M1FSYlYvMlJzUEwySW5xR1JQ?=
 =?utf-8?B?TElFM1pyMlV2UTFjbXV1ZkJwUUt4K2JFSUVKeEErNW1LMEYzUWZYNThmU29V?=
 =?utf-8?B?SXFURkw3UjhHb1dBS0xXeTQrb3lQSzh1dkpsKzRDSjYvakdCRUhONFVCQ0tX?=
 =?utf-8?B?SFo1dDdDamkrZ3cvbmc2RUQ2aGRTSWhzNkQ2bzY0M1JZNjRwYm9YSThBUkY4?=
 =?utf-8?B?WkhXOTgvSHZOTGpmRnp2cmo2cFN0NjdTTjhORlRrUmpuN1dLOFk1NldUZVpZ?=
 =?utf-8?B?bk5Ta0pTZjh5Vks3T1lmcjhocWRDdURKTFFrWCtveVQrRTJWM1VoN3E1Mmtv?=
 =?utf-8?B?WXRkekRlckFydG9UMkxaclQ5RWF6Z3hJUmNhYjVWTXpacXlaanVJSTg0SGVx?=
 =?utf-8?B?VXZ2SUgwZVh4eWZrMG9sZEZya3NYdkJwUm1aaUtIL0dlakRUb2x5RlMraTZI?=
 =?utf-8?B?a09RWFYvQjcrZlZ5UGhMMTBkeHh1eXZJWHpsSmEvTGc1eGg3Q3prRDF2VDhQ?=
 =?utf-8?B?RWN0QVJwNVpvblJ0MU5KMk9wcm8yOGl5Z1hIMkxxNmxYTDU1STJQVll2aith?=
 =?utf-8?B?V3RLbFAzc3dSOStEcXYwUll0SksvRGVCVzF3SWNLSXhidGVocmpxNW1IcTd4?=
 =?utf-8?B?UERKZkZZdTJxV1BDRytod21BRHNraE8xNTVwdG5veEh3Tm41NGNsQUZ1M21Y?=
 =?utf-8?B?T3VJTCtDSlRqNVFNTUp3dG9vY1Q4THlxWVpDV2Nlc1JzOGhSZWozNVpuY0pq?=
 =?utf-8?B?QzJtWkI1WWl0ekl3ZEhhWU80U3ZDN0VJdE5JejZ4NUZWUE41eVlQbFhsT0Fz?=
 =?utf-8?B?Z1I1SUtodXZMTjBzSDRFUlp3Y3dHTVVwdlppSllqWmttL3V0UVc5R2h6eGt2?=
 =?utf-8?B?QUhjZTM3TzhYK1NxZDFMR0hmSDBaT0c5WjZlbG55RldtTHc4OHVqZWEvOTNY?=
 =?utf-8?B?RHFmYlVLK1hqcVlJSzFIdW5veWdJWmZOVzJjeWpnQzBlcStaWDFVTUp4RVpl?=
 =?utf-8?B?dzhhenlWZEJZWUNwRlF3SHAzb2hNZ3FqSzJ3a0RXWituNkVyU3FPK1VCQjl6?=
 =?utf-8?B?N0xBUmNzUlhrUW13YkJWRVgySWF0VktVdzI4cnhieWNIR3ZOTEU5aWlQQi9t?=
 =?utf-8?B?b1hSTVZ5K0hBNC8wM1ptMlgzam5lREl0S0J4RGVJaDhVblkyRXgxY2xncUpH?=
 =?utf-8?B?eUx0MTZvZVoyZ1d1TDNqU2FRYWc2SUJ0OUVTdFpHOHQxTFZwL0hCUll0Lzc5?=
 =?utf-8?Q?m/QLqyi4LFPVTaEiHEf3sVA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MjhGMzNGVUxMaWhTRUhKYk44MDN4LzQvL1ZpUTh1MFVjVHJzZHpRcnVFVHRQ?=
 =?utf-8?B?dGRkUnZNcjYrSDIwb1QwWnFsSzBXTit5MVlQaU5LN2ZTUGhJcUhGODgyYkRa?=
 =?utf-8?B?SjlHcnlTd0xpZ0JLZFlBUjZUVG51TGd2aEx4UVp0Z1N2K1FMN1JWYkkwSFJy?=
 =?utf-8?B?eEVBUVRGTU15UTMzLzRpUEtSZkU2SHFURm1ERzBsWHIxdFlKVnh0Q3oxdXlB?=
 =?utf-8?B?K3VFRmQxY3I2TFJrMEdrSzFNMHNjamJHYXZGaVkrczlncStPSXFySUVlNGE3?=
 =?utf-8?B?ZEtIWWhFZmplekNWejNmZVhubW1rMEQ4WmxDNjNEazY4bFJVMFdxY09IOWgy?=
 =?utf-8?B?WHRZYjM1QkVVdzZxWitPV3hZVUlaaVdCVFVhaC9GQmswOGN4d1ZReXRqSnpJ?=
 =?utf-8?B?WWw1RU9VQlFBd1ZKZ1BReG5uRkZYNUs0aE43VmFybmpxRDhUdE9qSWRIL08y?=
 =?utf-8?B?OXBrQjEyUEdsMFlubWkvdDBQNHVCSnRieDl4VkQ4b0c2RlFuMmlTTUR5NHFM?=
 =?utf-8?B?TWJXZlIvZlZsbS9hZHZHT3kwWGhJcjhtK2V0NktJMzdMamlSZlRTN081U0dZ?=
 =?utf-8?B?c2swUk42a2RjbmRmc3RSdHZOdCthQ05vdE16amlaTndtN210eW45RUxaam8r?=
 =?utf-8?B?cmdEcE9oMEdXR2FVam8vWXROVk13NzlYYk54TnFtK0ZVYWEyNVhsY0FRNFMx?=
 =?utf-8?B?Z01ha05HdEYzYlZUMEl2QURpTTZyczZZejhwNENReklYZkF0UXVHMUpvMEov?=
 =?utf-8?B?UEcwSnFSa2lLb2NiUWttQTZQV2JORWpPUW1EdGNYbmdVa3NvL1ZxNWY3eUNz?=
 =?utf-8?B?QzRYakp4U29YZ0V5dkJQajNOWWJIZkUrZFlJNmZTVTlSNmFrcWR4OGErQ0Vx?=
 =?utf-8?B?N3hTVnRvMENyT1ZndDdrRk1kd3VHWm54ZWppdXh1TXA0TjViVUFlZ3pTWWs2?=
 =?utf-8?B?dTcybWt3dmYyQmZ5ZGJZTlZKaGtlN0ZMOXRqUXVkTTM2K0J5Z3J6Z2cvZDV3?=
 =?utf-8?B?VDVLYStIZkRCb1c3UUQ5SU9acXJqR21KK2lLNmliaUM2dGVUMUdycEJGOG5r?=
 =?utf-8?B?QncvbkU1WnFzYzR6bjN4K2lqK0NhQ01TSnZQSjNOWDJReXk4aDJlYlRrNG5v?=
 =?utf-8?B?dkFFZWp2cXlIdjcySUJWSHJ3UEhUS0ozMVBTZENZQ2IwSENmZ2kzQ1d6dGs1?=
 =?utf-8?B?NmNTS25ETm5lV2VTd3dYRy85dWRWMC96UDZXUllkTXh4TzJSSENXNk9PaVpt?=
 =?utf-8?B?VDdrZ045RjZVT24reG11RFRUbXJWSU0zZDBjWWFuT2E2SXI5clF0ZVAyRk1Z?=
 =?utf-8?B?MEROU0F3aUpLRlZHcHJjVEU5RFlQSWNpMGF5VStHaWZEUk85N3VNTmowa1NY?=
 =?utf-8?B?Y0k4eW00aDJmb1ZONkErdTYyREhiUEVZZGdJa01KWUxXY3FjT2tGYlRoQ0Qr?=
 =?utf-8?B?cjNzU2NXVXhXODl4OWFpQmR6b0QwTVc4d2g3RytJOWliOHluZG43ejhFZ0M0?=
 =?utf-8?B?OUNDakxTb3NYaDNjdUZnQW5yQkd4eWVyVC9kek1KeEJvSCtBNnRtQ1FNRUJK?=
 =?utf-8?Q?wu/L2vsgP//jyzt60PzzNkzGYFonAZnaD/vl9QC3NtvLdv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab6f925-39e4-47e0-1947-08db7718f03f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 14:15:19.9678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdHbC6DhOu8iVdv8paAgdFblbgAftF5qotQvSMlyyFJmExf2WGnhL3L7kNTD9kz/TEbAOvohOIY1yLZXPw6sVRmPKDIxKcyany1suNthwW/kMjFS0BMtzJW63sHIk30b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=997 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306270132
X-Proofpoint-ORIG-GUID: 64oW3_DtMsZ3pUDZO9-UrxX0vp7wXdkR
X-Proofpoint-GUID: 64oW3_DtMsZ3pUDZO9-UrxX0vp7wXdkR
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

On 26/06/23 11:41 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.249 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.249-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
