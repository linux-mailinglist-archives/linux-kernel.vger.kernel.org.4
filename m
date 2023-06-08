Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9607285CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbjFHQvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjFHQvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:51:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B5F9D;
        Thu,  8 Jun 2023 09:51:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358AMJHT001942;
        Thu, 8 Jun 2023 15:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kS599oJnQs/D9bzghIMo6umI21wV5POMWje8WvpUwaU=;
 b=mb7VEXzo93zqKS8bVLuuNKArtzcbXWUjwDD6PQpqz8U7LypwpIAyZgnos+H39MJoXwOk
 u79/5sC9WPbyWHHWWe2um0w1llGe25i0nir9TTbgDO0zYkhgDhsc42XGRqs/jrGCNaW0
 fUEOoMj/kvFmcRz2GgNTLteun9y8wf9tyebP3JWJMoFIUhv0mwnMXD62wLaPORjoXKTJ
 ve0EkYT/LmAPeRoohrZabYpPvmGF5hDcf28SFOC6AtMAzJvu+O84SQdvxjlk3lIVhZdG
 DnysPF0eiKMxKHgdKeWGWTO9xC2HRcSoBiawdsBgGiUW390oCCMdypcUcBO4gCTCHU7L aQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u4k8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 15:43:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 358EL3Jt036875;
        Thu, 8 Jun 2023 15:43:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6m9bjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 15:43:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCZS2w9iqBfi1QCoOau02WNGJL7HvzAeBGgTWVJolB8+H1MvjB1UubMiQd8Vv8ImqLGlrzkequ0t8RZ0W6UTH0QoeadOzK1SeiFfbs8ufJhiSBTD0HW8L2hfe7NAzKfDJzuzeRvMj7xQdIvLoIZQhHnjrY+K4TDmGf2+odbEKqgG6UC5EUwEn0T5fuTF32j4mcc4+p0kR6vUGjFBzVPi2DXcoedkNV/I1W0MTbyBnfcWunOUNY6ZxmyeYNk0A6l9E327IEjJVgHgqUC9CpvZh7vO4Cy/LFK50oQatsi2pAzDmV22nSwERw+n5/Onpjcso0F81Ut3VyImz84M5QlrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS599oJnQs/D9bzghIMo6umI21wV5POMWje8WvpUwaU=;
 b=kyXA1bs7Yny0gSxbntTTBI3baF0hBEein2WRaAEG5YvsdH9YZ08EuFHP2lP+GLoh7+FByitKBTNiIimgMm1K/G230KZh4eF9D6rV1Tvdrb/9WAuN9ZTMRdBS1d2TSZ2yNBxbSnTxr1nKYy62vqMPUg79wB7jBMqj03lXcNFNTe0iOQCsVU0RN3Q6plQ+EMG6ehe5+HGp6ljYrS83KNo++Fv6+I4q/vcA4dw0T7iXhHiUv/1LYMJ6oXUM3X7yWcHuh2jwsOQBCZqeAcyySMLT7JQ9Sgt3tNtNaCPLZTvks7EwfLPzs1JcN/WtcCi/jy9fOh5FzvJzDjwVzkJ7sAs4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS599oJnQs/D9bzghIMo6umI21wV5POMWje8WvpUwaU=;
 b=AK6yXLF7Ljs7E/MbraVktCBgndq8RNJdUXO5/PyLaL6E+rRkIU5MT7/VwZZ5Y9KE7bWY+AqZkwsC4vuu71Fbs9GroK3XDiVkNjFRxKsUu7bAvWwW7dDHsZ+RYv11IKzMtyrdmNDoxffQ8MnuxbTFK0a13hY7uUC7pN9k+NNv4H4=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA1PR10MB7682.namprd10.prod.outlook.com (2603:10b6:806:375::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 15:43:30 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 15:43:30 +0000
Message-ID: <7ecb80f1-c7e9-18e9-f21f-7005901796b1@oracle.com>
Date:   Thu, 8 Jun 2023 21:13:17 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 5.4 00/99] 5.4.246-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
References: <20230607200900.195572674@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::11) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA1PR10MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 5970ac79-18cb-4f46-abfb-08db68371bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8DsKr3UyIJELG3GjWFH9gsh718I9+FuULG3sRafTsq1i/tTkh5pcgWfJbVTt28N3ppP3PEqxbmJStRSNCOi/ByiWZbvBKGt55eurLG3MIyI8xbB/ZunFoVjC+7TNNEHIrE4Jh/JdDmvoD92cCcKBxdVB3fq4fZufMCvnqyUJvaShP6YICv+ARmZ0W0yR9gmL4GFxhjAB7fPIHLj5VziJfD3jtT5b48XQfsI/vBLRq6VrzMvuqAV56y8coKgw3A2WX5h6Hl0rVvhpCydZijArtRaJjpVUktuv4TH65AeZAVlkOfv+q7A03NNDoiUVBJhqUrSrk1YvLWip8H9Q+dKjt9VHa8AgnfRjF5iRjXOwkDs/RgM9GfYtw3pnA+30eSGMthMZYoFf6ULPn6Ezj79f86K7kbOa5aTy69tlSVtmoBWJnkoRUXqtWCzNy+JQe/txvCSKAoEl2mGpOtfpoYtUS6STWezIirpfNdd2LOqMgRKpOx5tDfzaMsgwiEa48JuTAcaqmKZyHROLTSVvsP7DM2GA8+9PawgP45VReD/+miu+0US+8E8yhyZtPfIv2n6VuNsrASUD9INlOBYp5EP9A0a9KAIoqZmiq9hQ0HmhaaZAaUGuAGohb34cHlyELSJP3fUC/0j4jrQI7Sdp0KdPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(86362001)(6666004)(38100700002)(66556008)(66476007)(66946007)(4326008)(6486002)(478600001)(186003)(2616005)(966005)(36756003)(2906002)(31696002)(8676002)(8936002)(4744005)(316002)(41300700001)(5660300002)(31686004)(7416002)(53546011)(6512007)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTJCdy9IQ3hKQUVhaVlYQjlQSjRwS1VnSjNOUTM1Z0hvS2grS2RGN240OXVK?=
 =?utf-8?B?Z0ZmMEJwRW5LYjVsc0xUS2ZhS244K3BmNnRsWEM5THkwTXdjRzdseXZ1OFZt?=
 =?utf-8?B?K2ROZjJJTGh0SHJQdHI5UGJrMmZ5aUx2RDlqaVQvODRXTlJSUDd1RHhKWG10?=
 =?utf-8?B?Y1FPWGM0eElOaW9nUm54V2FQT2hZTE1CRTNQWjRISFU0T25jcmdNVGlRcmRQ?=
 =?utf-8?B?Zm5YMGUwMHdKbUUvbnJvbHFCSmUvQXBBNmdScndFZG5OS1VReFJGSVNhUFo1?=
 =?utf-8?B?Zzh6eXhNRkdjMjZZdVY1eHJRdHU5MERmNmp6OEFuU29QaFFzRzh5dXpwQTFx?=
 =?utf-8?B?VDBRWUlBeTBUcXowQ0JCTmFOMzF3YWd4YzVPQVVIYTlWQVFPeDgxNkluNlU0?=
 =?utf-8?B?d2t3eS9YcXVIUWRGY3NBN3BpZG01Y2c1ZStsRitjdDRhSm5qanJrR1J6RXho?=
 =?utf-8?B?ZmY1SCtuNTlNblB0OFV4TnJyQS9VSnA1c1lBNXFlc1hiWEVKcGxTN2EzU3R0?=
 =?utf-8?B?cTh3QlAyTUZ1N3Y0SUw2UzNsVTA3VmRRbjVWUzh2dU9IODFudlpwWDBTUlZY?=
 =?utf-8?B?UkhGVVJyZHIxQWRtMXJtWURIWE01OG1JUDl0QWZWZ01MOUNRbm5kQVg0OFpI?=
 =?utf-8?B?UnpnM1F1UTJjMkowMlYrKzRvalJLLzdXeWN6MjhoZVcwQlQ1dktwMDJDY1A2?=
 =?utf-8?B?anFlKzZQM1VIejZzcEU3MTdKc2ZqbFlGamhXRlo2TEZjQUQzWGZoSTE3UC9p?=
 =?utf-8?B?My95Vk9tcm9lQmpPT2dtOEszc1hQUnBDZkI2clFXbXd0U09HM2ZzRGJueWc2?=
 =?utf-8?B?UXpvOG1RZ29EalRlZXA4aTlTbnRYTU1JM1ZoVFRGTm9SK3p1NXVwT0FKeEc2?=
 =?utf-8?B?WTZHN0JRZW1majJiQkZma2ZXaG4zVG5NV0NaV3RlV3lyMTlWTUFSQnBtM1da?=
 =?utf-8?B?KzZ3RUJ2ZU5PT3pqZEM1N1hBdUtCbUxGRmpjNjliNWc4Qm1GbEIvZ2lvNWVZ?=
 =?utf-8?B?MktEZkVpTTdWRS9XVW40ZEwzeXJoR0xDUGg5MlRBeFFyNndaWkgvSzZxcjM0?=
 =?utf-8?B?WGlXd05MQ0xpSEFLenZMN1UrTmUxcW1tWVlwMXRQME9VVktFTE10bmhHVFlZ?=
 =?utf-8?B?VCtWQ1ZkSmtWamRQNnNiVFZ3M0JTU2taZlV6Um44TTRaLzVRbDBraXE2SFJL?=
 =?utf-8?B?THNUeHhVQlhoUXlFSHczWXpkZHhKK2xJVnA0QlBGTURTSE1scndXcGFKNGNT?=
 =?utf-8?B?N3lyQkdyTDZ6Q002Z3dKMzA3aVZVZzZZL2RvWFluRVBoT2NNTnp2b2JXSGw0?=
 =?utf-8?B?cGxhR3lQaTYvOWhBS1JoNDVyb0ZCVVp0YTFHamMxMXpCSCtEbDIwQ21YSlVo?=
 =?utf-8?B?OTRiUHpZYWRaNUh1dy9tNVVTLzQ0eXBmeHUwa2lZUnIrVTd1RGdHSnhIQW9F?=
 =?utf-8?B?NnljMitaOXl6YmVvbVlGTlZsR0hZOEJ6dWJ6TTI5cllrSzZpTjNIVWlMQS9L?=
 =?utf-8?B?YlJrMjk2QmtqRy9aODBqd216L015UDF1bEdTd3hDZXgzbWdWVURTVW9GOGY4?=
 =?utf-8?B?WHYvTFBxRlJSdy9wT1FiVzZ5aW12QUlzWjc5M1VxYnIrTURaZHUxejI3UWVm?=
 =?utf-8?B?TE9rb0drY1pFdXZMbjhpQmJpb3VKdmlMUE9iUDdqdEF2L2hrL2lKL2VTQTNG?=
 =?utf-8?B?UEpEbmJac2tFRG5JL0MwaEE4MzNBdi9iRXdmaGo2MjByL1AwSVpIaUxVYnZO?=
 =?utf-8?B?RldzSlhqM0RLWlZ2M01sT0Zwc1JNdW1pcFhlQTVOSlp6cmhlbCtvNXdZTU1h?=
 =?utf-8?B?WEt4UDdwSW9uLzdnUGVpZ2t6QnFvNzJDZCtjYUk2NnVYeVA4bXl0RS9pek84?=
 =?utf-8?B?OU80YkM0T0ZHeXdzUXBaNXVuaWlTSHJudGN0ZE81MGtoN3BlWWhVT2g3QzVN?=
 =?utf-8?B?NWx6dE9YVERRQ2cwaFF3M2J5bUdDSTVuU3lYeHV3UFZ3d3JNUTJWTHkrL0gv?=
 =?utf-8?B?WkxQNmdEMEdRVE8xdFpVdWZTbXo3YUMxdEl2cXdSL3JNbWU3Z2VJTjJ6eHRZ?=
 =?utf-8?B?SnJvbS9WUXNjYTIrMngrT092US9UM24vMmdRQ093V3NzbldNTTgrM3lYa24x?=
 =?utf-8?B?clh4UWlubU5hSWo5S1JlaitOTm9GZGM0Q1haaEJpck1ld0FjM0sydVNnakRm?=
 =?utf-8?Q?mqc/R8pwBAsXcBLgQTMfcRo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WHAyNVRFR1lpdnZQazMrSCtnQThYS3EyT3ZrQUwxa3ZNdWZyc1NMUjdkTjAx?=
 =?utf-8?B?dEJHQS95NHhJYjRJYzlabGt4TXp2RWRYN0IxQWs0STIwTU9SQVphSGtVem83?=
 =?utf-8?B?cDJaOXdRcW05b1V3TUp1emd2Q1lRb0FNSitYN3NEMWNuUFRUaENnWk9sOWVO?=
 =?utf-8?B?aGlORTU1dG5hQnRsQWI4ZTNEVEdDY1JKN042dEsyVTdNYmlJZnVJc1NYdFBo?=
 =?utf-8?B?ZDJIdFZzVmowdWFpajVlWHhDb1FiMmtzRzFjTHFLQ0pldFpJT0VjSVlQYVVy?=
 =?utf-8?B?YzZlaE9jYThuQytzN0NydmE0SFA1T3V2MTV1VDRrdTlla01aeVF3cUhQQXFN?=
 =?utf-8?B?MDd4Y0FTeGI2MU1OQXFuM1UreGhCTndQMkVuNTlnYjk3SWJuOThha2lwYnJm?=
 =?utf-8?B?d2VGQ0o5QmRQWmk3VWpjbTJ0TG9yTTYzbTYrUW1GV09teG9XdGJGWkpqVmhp?=
 =?utf-8?B?QTU3RXJCc0NpQkdXMVZaUWxhODJHdjJXK29URDRnWXJKZ3V1TkpLUG1yN1d4?=
 =?utf-8?B?cjlPY2xVaXh3TkszYUdCdkxLZmo3SURxWHdjSGU2M3RXRGQ5TGdPZ2R0aGNV?=
 =?utf-8?B?QzZzbXNIbUNGb1hnL1RFTGc5aE8zVTNOUVdUMmZudkxmbDdPY3lkUFBrS0hv?=
 =?utf-8?B?RGhXbjAvdVFJQ2EvWVQwbXJYQ3RXbDNMcEZZUEZOTXBnMDF3bE1oTUhLZVJh?=
 =?utf-8?B?ZlBKM2ZPcXI2cXpIZ1k1d01KWjg2YWE0UURMbmh5d1psNzBmNXdWdXZDNGk3?=
 =?utf-8?B?VVNYY1hORm8yYWpNZXdzQk9vL1A5VFNtNU41OE5IM3R0U1U2YnJzZXJLdU1s?=
 =?utf-8?B?NEVaTUtuUUhkQnRPdDJxSnBYVHdDd3BGNTc3Z2luZE04OHpzdFM4NzU2R2Fm?=
 =?utf-8?B?U1Z1QkNEUEdtYWt0WW1wb3pYem9VVG85b2k3U2k2MmFSN2c1UFQ0dTd6Qmk4?=
 =?utf-8?B?Mkx0MXpzWitIaUhhbFNXNm1oU3ljTWR4cXYveTQ2QnVJc0NTWjNsZmwrRkwx?=
 =?utf-8?B?SEt4eVpUWVNJSjFMaVI1aDZ2TmxNOGFqZkdqRWkvV1YrTTNVN1VmTDFGNG5R?=
 =?utf-8?B?NWVsOTNyZ3luQVNaakVOMVdDaHFsV2RHUlJEUGhIT2lCYnZBaG4vcDZSUjlG?=
 =?utf-8?B?WlZiSURwVm1xeFZDaTVWTzlZMkt3dnJta2o1bDIyejVrZnVNdDJHd0ZLNkw2?=
 =?utf-8?B?am5Jc2I0L0MzeVhhalpDYWRNMHQ5N3lnU3d0a1pTODJBKzNNS0t4alBsbm9p?=
 =?utf-8?B?Q2NRUDVrdnVJV3k4aEF1aW41SEwreU8raWQ3YXJONUswTEQ5WEZWUm11aEZO?=
 =?utf-8?B?OWd0WHNoSFFNZEF6REV0Ymp3bzdBWVFrWmp5T1JjY1pDY2pLaCtzWW05b01r?=
 =?utf-8?B?SDJycDAweUZZK2pmc28ycWszbWx1aEZYQWZYaEhhVWtNcjNoOTJWV1pDYi9l?=
 =?utf-8?B?ZkxwYlZZUmk5Q3ViVzNVS3pmVGRLNWZKQU1kUDFOdTJ3RlVxRGMrVlRVRkow?=
 =?utf-8?B?TnJmbS9GaGxhWE9hS2FsVGQyRlptVTdTNWh6Yy91Z1VoYko1Rkx1RDdiR0Y3?=
 =?utf-8?Q?ZlDLK0f8J2GvpiEznPEGPP4Ks6xsyXYDxIDxMHh9QZaNdT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5970ac79-18cb-4f46-abfb-08db68371bf9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 15:43:30.7241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCcI8BSG5PLB+03wcFxv5W67DG/6yeyUAsT0D2vx6GOkTmhqr+BGiIBnD6VfA0+kslMrGrrmLzfLPeieU/S1JhpWjE7//bZbBIZmjCC5cGgmI0bboiWEXWduhjsAmvC2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_11,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080138
X-Proofpoint-GUID: bxwcxiH-MlGi2SbK20C1tXTsULXR-zSA
X-Proofpoint-ORIG-GUID: bxwcxiH-MlGi2SbK20C1tXTsULXR-zSA
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
> This is the start of the stable review cycle for the 5.4.246 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.246-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
