Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8006E727F99
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbjFHMEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbjFHMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:04:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6C51FDB;
        Thu,  8 Jun 2023 05:04:13 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3589cnnK017139;
        Thu, 8 Jun 2023 12:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pM3KQmztQZ4OsrPPirot07xwlQwMJ62TYOjlNpCY5m0=;
 b=0qjWWwIWe1XXudIWTEPlItdMbzxgVQvDmFMmExZL9e6StRRGP9b9Jgr41aIFn2bv2lm/
 kX1g1AAtiT6eL7pNWihEtxbEfy6sNwAW/EOC4pA0MeR7qTq5Dfhs34IupVZJAHXNvs/l
 Poywj0kH1LSYJY7vHkhxP5/ZAU4tuLJM2Tb99aA/TPt/xWKdjSiwBJFIFOkNDpH15IKx
 KH6k5kC7WiYxF3z6lcVtwykpWkRzVMZ5S1xZdwH5atW/boT/oM2jcKuEgj2TRPYlXrIz
 /qn01nAn9gC3Vy6ajVjwxL99PZ3AkmmMtgH+BGmIzU0/BOfKBKsaaFF8i6nayzJGejvD AA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6pm5ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 12:03:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 358BBRMJ010413;
        Thu, 8 Jun 2023 12:03:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6rsv48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 12:03:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFQ74b7oq7+kQy3ldHUj1yo2ucFmsf4Yr0C8pDS50/2FOAEhFWjvzWopWGICy9URPCRjZPa9E9U8NQO3X7T4ffG1wqf/09tQx62yhCTYRtqgo4wSv4DcQlX4DWyMf4cpWe8uDPNxPkUpsdvFrA/9aIlBSxvXYu5FQlmRfqGk8E1dgZXlEzcY+HnNSGu14hvP2PcVhTNSDXtmtQhfgvAwSGs2KJjN/boB1JNgE2Pusp9BYNHf/kORjotcmVlCpHGod60w/sn8N4wY4ZyrmHvm5f15k1fBtkD/540NZhcVYgnuazWzgdrZBQ4GnYjhFrisybAIMVlmyNOZugADyeewzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM3KQmztQZ4OsrPPirot07xwlQwMJ62TYOjlNpCY5m0=;
 b=W1+bB76ADaErRgCnrnEUoB8IHjzY2uyUMjGqi+ST3v/j7QGAvXKOiKfoZSTZaYUyCkl94JnxsLvk9O14GFWT/7x/39sOqbD/GOTCWF9LjAR4FSLE8HshTky05o/B5dMEwlRkQAbuMlVbQYzYakmxovFOtax/jDvM4SqZS5cmlFiKM+2u9FSeo0bzV71zh5ZC3LwAJhmvfwX0utUDdcePz+AwK8dF2gegeB/P8lPu4fDCXvm2d7Mef2IxZ2aI8qHL3hCJY7ecX0VvV2y/rPK6HDEfsnk/1lo60A6Vamjlm2HHZhoFVAp4DrNBbR8pS6Dzi1qcSsHzjKbMIutmed++bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM3KQmztQZ4OsrPPirot07xwlQwMJ62TYOjlNpCY5m0=;
 b=du6tl8A9H+ywWtMMJ/HJsu3BpbwN9A9HwqcxDIK1vd/Aadwk+eRxsO2os3cF8qr4TCxT47QrwftOHXW80MT2LodEGl9rBUDYVtsKPEk/TvfOfKInbeNLmzyqLM0th2PVeNQPG909JA/yI/jpoZp1I+VpwOZKX5xv8XT4ofy7YKE=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by IA1PR10MB6100.namprd10.prod.outlook.com (2603:10b6:208:3ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 8 Jun
 2023 12:03:18 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 12:03:18 +0000
Message-ID: <464b8d63-f18e-8229-0370-78861536d371@oracle.com>
Date:   Thu, 8 Jun 2023 17:33:01 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 4.14 00/61] 4.14.317-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20230607200835.310274198@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230607200835.310274198@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::25) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|IA1PR10MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 941a494c-7921-45a2-424a-08db68185893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DL0VYD7/GDjjVNEuU+/D3YZG0Jofmxfas/9+IyThUFq4JcTM6PZ17iqC3k5nAQsvjrTrYniLhTavc2+b6yALiJl0+lmrHYAV5vyGtOdlxRY4vkH9rLU1urMQJd2zto+C89JPvGMXRwR4ueoAp/sUEo+da9qTN4tWCuYfjkEVdA+9aSPLXcG9s3eEo4BHpZtiZBzsw2mIRH3VWm7/up/4LhrxyPH8+qwuFx+5yulHwn2G2NXDw59Ud2p5d0WfIbCCrk61mHpiIrom5Og/C9O4ozjeBEUJdDpgt0wnPF8E0OH+VqyzH0I1Hup34a8ybrVN4WWzo+fbgYgvOgDBFipZas/zpiPg207yHzNs8puhiTVfQkFyVvJw268R1qH1Tb7qfDcE3S1fiXkh5AYIKzqaqhxflmMlbM7/Jd6uDdDZTAGcA+JwSzAgGSAqUJca1OgS1JPpsqjxiiViqjNzKriR1ygMDPFgwXBi5pzyRjZLFkDgO/5YTdE4ifYEC9Zs49CTPEt4R5YXj7w9QpHHUhTiO5n/yqkICHIkUTmmVIGWWe+wVuTvVbAOF8e1pNAOkLQjw6mlwTrj86qQmEeR9/08YN/B4Yp9ZT7SmOhsIyUhxg75LL696LMZiw1tfqMHgkeoYhG+Y2il0CM4KBXmjcu65A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(8936002)(186003)(2906002)(54906003)(478600001)(4326008)(2616005)(66476007)(4744005)(6666004)(66946007)(66556008)(8676002)(5660300002)(107886003)(53546011)(966005)(41300700001)(6506007)(6512007)(26005)(7416002)(6486002)(31696002)(36756003)(86362001)(316002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3BSbzdaNm85WUN2cDJQdUNoYnNDc0ZObXhGSE5YOHRpaXFoSW1NYnNjdzlV?=
 =?utf-8?B?VVFIMDFJdnl3ZDJpQ2tsNGU2Y1pNcHpwSmZsUVlFK0szQ0tmbEY1ZldwcnYx?=
 =?utf-8?B?WEo4TlZwWG9ZMUFOVERYRTdiU0UyYVJ5L3I4cTdEcDdOc1E0azFGR2E2WFll?=
 =?utf-8?B?OFdrQTNmb2pNVVRXaHp4cTF1allDN2NpaUk5a1JPMVJ2enBuN3RWQ2V1VDZY?=
 =?utf-8?B?ejByc3hrT0h0SHRLSlN0bm9mcG52RnFoNm9SdzFZMGRQMVRlNU5scG5FVDIr?=
 =?utf-8?B?c3dxdjROZDJkcUFrY29hd2pKWk04RCtVSkhtY01weWhTMUdCUkJLV2d4RWhD?=
 =?utf-8?B?emZBalpDNUJTQWFkVy9OMDRnTWVCLzErQlZlSWQ0bTV6RE5RYkU4bEJwa3VP?=
 =?utf-8?B?czhJMktPOGNUSzNjUXJQcHBVcUFVcDBRN3dpUDB2bWo0R2JVenlkYmtpSVpz?=
 =?utf-8?B?Qy8wTmZ1WHRMcUU5MkJRWkE0elBvNGZVbVVpUDhKYlFWVmhVUmtmd09ZUUFE?=
 =?utf-8?B?V0RBSWd3RjNrMmhXV3JLOFlVWGpoOGsxTkw5aC9WTWRsWklJbnFUSmdYdHd6?=
 =?utf-8?B?VmVFT1FVZWZjNU44d0krZ2lJYXZMRU5HN25vYm1NUEdjL3F0Y0xGZmJDMGV5?=
 =?utf-8?B?US9GZlhaM0xDb2d4cmc2WXlSMnltVndVcmdqdGg3MXlVcG9LSFp5d21oOGtI?=
 =?utf-8?B?ek1TSlpnNGZzWEZQc1dJazVxdTdqekJ1YjlYMm00S2Q1ZklyMnFESjlzWmds?=
 =?utf-8?B?bk8zbis5YWgrYTJaT0JHRyt2S2l6cXNpd3ByK2gwMENBTXNZTWFCRzZXdFl4?=
 =?utf-8?B?QytlVXdYdlVCeDhDajMrbkdTc1F1amt3VFBGWVdKTXIwTGh5NjM4cnRYMmFR?=
 =?utf-8?B?V3IrdWdNelJMUkwzcnJuUzlocGRXWDBtTGpPM0RXYzUyaDhuMWg2bGpJUWpS?=
 =?utf-8?B?eWxKNk8xUWdCa2FLREdYOStUa3Z5Mm9NREszNlFYK3FWbFplRTY3ODZoQjlS?=
 =?utf-8?B?YXF2WVFIKzh3MGhSTFZlc2ROMVgrSEZaYUFDSHAyTW1HNEowcjdWV3pmeXdJ?=
 =?utf-8?B?b1VGcWtTRkRpQXRiNmoxSXVCZE5VSk4rQWhJSkVRLzRicXUwamlvLy8zZUR6?=
 =?utf-8?B?d2VoRUM4KzR5ZHJUSk1EQ1lIM2xtMm82cGtZZm1XSjJSa2JRemxtYlNkSkdH?=
 =?utf-8?B?OXJ2eU1oVnhCeVhiWmNIc1pnWVM2a3lkNjJsQ0YvS2MxNWU0cmN4Yytaek50?=
 =?utf-8?B?aU05b2ZaTmhFaG4weW5PMWZGTTBoVUc3akhEaEc5SWd0djBKWnJocUFGdFpN?=
 =?utf-8?B?eDMvRHNSTGVMV0ZNb1lublpKWVNidndyd21uMUc1cE1BTHBaS0RYaDEzdC92?=
 =?utf-8?B?aTZzMTJxalVDR3FXT3Z2OE1KN1A3dTYyeXBIMElIMzBvMTFBSVRUYVdmTndt?=
 =?utf-8?B?alViWnByUGFBR3hLTzVnL3UycDBmTVJ0SDZINjdMaFV1QUIzTlpNR0hQZ2Mw?=
 =?utf-8?B?cUhJSkpkb2lyV21hTm5STkZjSGhnblBudjl6WktOd2M3Z240dFYrd2EySmJu?=
 =?utf-8?B?bkdVeWJQNFgvdFhLNHQxeE0vQURLVWVNRTZMK2VaQzRUaDQxU1JwVG1OM2g0?=
 =?utf-8?B?OU1vTldTeG8rYU41VmpZTXNqZFJwejJFNnJhbVFycndkalRwZDR5K0lLcnZz?=
 =?utf-8?B?TDdVMDFTZkRWMVJORHNRMXVJMW9yYnRVUlF2NnVFL2FzU0FiejUrZnB6T3Fs?=
 =?utf-8?B?LzZPVVFZNHBwcmRnK3FwWm1KcmhFTVJPU2R1ZFNlOXo2MmRldFdweXNyTGFo?=
 =?utf-8?B?dm85YmpZWGlSY2wyTTN6MVBGM0UwZno4dEtJNnBOZHZPelN0WjBFZmNpbGxC?=
 =?utf-8?B?NTBvZFAvMzJnQnRtakkzNUs1OEdxeVdFYmdUT1FXZ3Q4QlRHZzV0QjdSY1Uz?=
 =?utf-8?B?NmFLcytuQkFxUHE5eTgvVVF0YkhWL1RWUTRJSjdqTDF6aE0vOVZXbmhoM0gy?=
 =?utf-8?B?ZTBSVnJnQVRDV1hMREljdzhyRUdpcFNjOUcrWHZJWkgyVkNnQnM5bmQ4VW1q?=
 =?utf-8?B?ZFNFd3ErYmo2NXIrNG1abjJaOXdra0t1WTh2aDJTQktlaDZPcTQvd2krclUw?=
 =?utf-8?B?bjB5NEdwYzFkRXFNWlJQUTJtTGlubUVuRzZWNmVyR3VmSDJGQUowZnd3MTk3?=
 =?utf-8?Q?TdsyL+qtyCbaJ8WnEZDTVik=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OGxDVi9uQ0JFWHNZMHdOWDBsenI1OFk3OGZoL3RIaWhsY01KL01YR0tIVTMw?=
 =?utf-8?B?aCtlSVF6V3N2KzcyanpLRlhxOTJJSXJYRTFQdlV0SHVzVGIxSHZpemNlNmZp?=
 =?utf-8?B?RzU4Q0xnRStMRS94NWxsRlBnWE94ZWFXS0hwa3dKS3lYQjVDdnc2eEtvVkha?=
 =?utf-8?B?SmdCeEVNVUV5YW5zS25GZ1V2OVdSekNJNGFjMU9OYjYrcGkwREFEZnJmaE5v?=
 =?utf-8?B?MC9qN2pWTkhobFJyUUIxek9FM2Uzcmp3bFAxTktqTVcwTDRuZStnb0xMYVp2?=
 =?utf-8?B?VGNOamZYNFRwbG9hemdwY0cxdGlMKzJ6MUJENDNJdG16RUZTd1U5UmtPZ1k0?=
 =?utf-8?B?Y2dZTHUvTUh5Nk9MaVlJb2QrQWVKZHVqMWpwTThvZWE3VGNjd2hSSXF4Mk92?=
 =?utf-8?B?cTJlOGVuVFcxejNqNVJtdDZja2QzS3lIVjRtckN4bjNkbEVFd1czT0xrU05Q?=
 =?utf-8?B?ZGZmV0hpV1JRK29SUU1YZTZlTUwrTHlJSmVmRjdDU3RTOUZ2SjhobDIxRGU0?=
 =?utf-8?B?dTVjYlplckYvVWF6OUdhSGlGTFFsbEtHNlZDcXZhbno0am5MY0lVdDVaYTYv?=
 =?utf-8?B?M2pKK1g2eVhoeVVxdnVJWS9CT2pSdGRDTEZWVDQvYkR5NXc2dmpjekVLajRw?=
 =?utf-8?B?TnBtOVBZTldiQ09FL3UwOE14bTZneU9kbmZZMTYyOUtEY0dKaFVualcrL0dh?=
 =?utf-8?B?SGVMbnlMM3ZaaUk3WXN6VndEWmhGWU54SnZHY3hESEJLdGZNSTNwYnUwS2hS?=
 =?utf-8?B?UmF6ckpkM053T0g3QjRod1NCcjNoLy9vQ1ZSQm0veXFVUnZKd3B0UzAwbmZn?=
 =?utf-8?B?bTcweGNiREZCTW5oVUtGNHFFdVgrcFRrM0pZVG5McHJnRlhCN2haUEFxcmtj?=
 =?utf-8?B?QjBnRDZzQmZlYXNhV3NWMTlmZGFxUzdSSmMzMFJaQlFMbWdKQXc0c3FnSkxK?=
 =?utf-8?B?bVJnSG85T1JRTCtTd3drT2p6YW5ZcnZRUDJHeEFQQzFvYlFFWi93Z3RCcXcr?=
 =?utf-8?B?RFBFdTVHdDZ4akxpcHN3Z3dlSFpyRmVtUkdKTHpmMjhxd3lQcE1lRm11VGhZ?=
 =?utf-8?B?NEZSd043Y3BWUFNSeFZSUTk0djZXUGNQNnM2SWVpM2tOMDAxYndhcEorMUFy?=
 =?utf-8?B?Y05BdzlyQWw2L1lXZ1VZSFdiWnUvS1ZjeEpKbTlUemZ3M2lOdC9aZkVxeUo1?=
 =?utf-8?B?U3ZTNDRma0hnZy9vb1huSWlkNDZkbnVVTk1TaDVPTEY3S2hVVXRGNGxHT0hP?=
 =?utf-8?B?b2xtd1RwSDZwNHRLZHRuV0J2eGNyUjNLTWlRdjhLd3N5eTVwR3BOcWlwb0Vh?=
 =?utf-8?B?Tm90RlJsUHdJREs2L1FnSGduSjN3WFFmY1BlQlExNUhCdkxDNmxZY1JlWno1?=
 =?utf-8?B?OVhrcGtyVm5URHlVV1dWUWkxcUxUNndMUjA4Z282NzhGQ2lBRGJTZlArTnF3?=
 =?utf-8?B?THBEL2FDcnBlV1V3aFBxOUxUQ3k1QTd5NGJxOG1QYnJxWExQSExrTkQ3aEJP?=
 =?utf-8?B?VGpCMFQ0cmN0T2p0NkZIeGFVZ004NGlxZlE3SDdoaHMxMzczOUpqMm1tVzRN?=
 =?utf-8?Q?InPryf2Z8/5bB0xGOxeP8c8r389f6vvQu2LYhj3qzRrlOu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941a494c-7921-45a2-424a-08db68185893
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 12:03:17.9123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igDIcY1QIzNz8HjmFtG8MBG5OGCW1gV40/CJYeHpXgqe0NDjFFZ1JAWT84Er3YGVCiz1qqYFxxFq+30YTIlc7A3VPiIkVfhOw0c1N/dPAiNovVs00Kde6QISqhWoESD3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_08,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080104
X-Proofpoint-ORIG-GUID: LGOlhOkfj2jf3RClNT0D5g2xxGJ08qoU
X-Proofpoint-GUID: LGOlhOkfj2jf3RClNT0D5g2xxGJ08qoU
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


On 08/06/23 1:45 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.317 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 

No problems seen on aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.317-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
