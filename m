Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F128372863E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjFHRXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjFHRXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:23:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293411BEA;
        Thu,  8 Jun 2023 10:23:35 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3589qGfM001986;
        Thu, 8 Jun 2023 15:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Zd9nVfKCvGPkgIG/V9s3Jd3zI0UJ9gqh8C1QYWs3pkc=;
 b=okhaBXGNUjImistg825EpgwypzWPRsgaHA6QbBrWksgQYQrczlKEXkwdeDYuLU3xr+e8
 DHytCsXSBBY5KZgJuco0ae31yUsRcN/bHX+6hRvEAMjM2wEPEy/jcRD9AghU3jOMIRlC
 Gux2DReJBAPo3YCivISo/8OT+0aLUPunB1GjoIz9ZAsVp/nrJ31axZhkJyIYS4thXV9V
 TXFb6tPys6wxws3tlXq8ka8C2KnaqHdQOA906YTdO+3VfDL+ob9jUGFwaI+KeizmLvgb
 NL7nlSbuAY3K13z7MFfN2XnhlYErDurp/X8poH7We5PrCTxIKExFYlAV4ySEHnOWMLkQ +Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u4kad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 15:44:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 358FWEti011111;
        Thu, 8 Jun 2023 15:44:21 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6s2d58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 15:44:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPacT8Mmc/PSCyzjsRMtooYGgjKBsWOZkoGu3niHucHTqXxVF2y9fDnM5bs4Oys+6mZgdow2mQ9NmSxU3FQp8fHDJNTOkoeaSkQ7Cabfxgr/AhIqBBWmoSnWI3qGx0bLjCHf+xW0YzB8RFcLnbzSX19IZAmsPxHUtYjoxSgNxycZ13dj3x2mG49mpQ0O10PnGGoOtwxP0Nfsqe9J5A3IBMJ6antqdM6A0vVma3KxPNkqCqtmdhUOcpbjjDOBIavXUJcJ8kvwv7kMKmFFZ86VWQjeN4woGUsY8FKv1w44FtmU0+CyOujKckvPvp/zthsC6pMlnkCPeCgc/iGsrHGpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd9nVfKCvGPkgIG/V9s3Jd3zI0UJ9gqh8C1QYWs3pkc=;
 b=TAW4pEfnvW6bTjrwNGiRpHtV1ILvaMwtMQzkYtKc9xOWWKa8zarb0QpLxRTEwxZUnZx59B37eFJWwamcUCF6xoHyi/92OuFS8t1p+EvuL5XqnFyc/YvbfWXJPLFoTm2sFpc1okuOy9nl00yIqEOSf/vCkYqTxO6AXzPNuvrAMLcnJFdGgsQz65kX6xjj0Wpg+05ylW21Et0AtplhAlwBGs5V/uYozaeNz4ScZgMnkDDZ32qAtiKgNn0H+pJuKbwbCjSQn88lAten7DV7mlZU/UNJUWWrlzSgBfuZVbl0diT2kqQiEXw+8s5PrJ3u/4FPZu/hs8NCCpRxeusQSEapNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd9nVfKCvGPkgIG/V9s3Jd3zI0UJ9gqh8C1QYWs3pkc=;
 b=x94QthlJkunrY1HtYdCeCWgMXx6va+jntrkuDuKSb7QHO/dNdT1gAF8OwRaUzogtD24qM+P27ymXKSqU4dktDk2urwmKcFBJo2CUX0is6t9JRcBKiFbTqUfo8YpWgfEGtRYYyIU/Mhz4idhTJN2xAv14pA1maRBoD5ToGUz3+/Q=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA1PR10MB7682.namprd10.prod.outlook.com (2603:10b6:806:375::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 15:44:19 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 15:44:19 +0000
Message-ID: <ee0ed947-b61b-47a5-a9dd-24775e980d49@oracle.com>
Date:   Thu, 8 Jun 2023 21:14:04 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 5.15 000/159] 5.15.116-rc1 review
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
References: <20230607200903.652580797@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::19) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA1PR10MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcb7637-0b06-4596-ea5d-08db683738f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9Oqc43dMkcZVub55l0ZLWcH/ymY3dTQCfONLFHwjdNtPU109gDrKjMMN3Wes0tk8P40QDtSguJbUpKw6W9oSCcSieVHfiifqvDlmTNGvMOPoTNHpq3ZFk0+dz9Nf3uVsfuzdkJlltRbyZQokREVW8FDJNxeeMLlylrXn/KSNJYJKTLRuon8BwzYO2SaW71Ie3PjV+d5ylcmOe3rN+LLYRRJZwctEe5PKOw5dwtP9MrjGeq8AY5A4kWmHDyt6DyL7yvzWvzmZ2eesuYGzyYVKyJP8yfyvNiA/tSHP5qX2ElnhYbAjkgdbTCuSiDtXR8ezsqjpsEhI+8+jw2Q5w9dm5mxuGIlO7hrGoiutY3hJUezriTP6uMTaQviPmIFP8qEldn2SxbofvGL3ff5QqI19iITcxgDtO+1PYgTWciAjj19DjIih40hHuAcuKqgizcSoICrZe19CTUsH7tStqCIzxRPnz4Ucx7WpHqqGofSR1DnfXoa7C8HOyKSMUGsE+XcukkdYzG1vQO3xZ+L0AcSB+Nx2UFYAA0SRBFQzo2e9+SJbSFkSrZHvyP0QtI/ocfpAnz3ka6QFC28bOP3fe0EBax9t6eSQHfv0VvCSgNjOwEypuc5EwHQWVNFC5tl07YRoAnCs8zxTwK0CIqPgmZLDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(86362001)(54906003)(6666004)(38100700002)(66556008)(66476007)(66946007)(4326008)(6486002)(478600001)(186003)(2616005)(966005)(36756003)(2906002)(31696002)(8676002)(8936002)(4744005)(316002)(41300700001)(5660300002)(107886003)(31686004)(7416002)(53546011)(6512007)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmIrelBZd2MyY0hMYjNXeTJDY3BZMUp5NVNzdEtsWGFwT2s0RFFOaDBnVTNG?=
 =?utf-8?B?bjVRaWpMSGwrdW5wZUdsWFZWV2JDMCtmejNSM2xZL3ZTNUdlaVNlYjROYmhr?=
 =?utf-8?B?RS92TWozdklHeDBUZ2tCZGJUR2F5QkJPendUc0J1bHZuN3g4aXhaZWJTWmkz?=
 =?utf-8?B?V2NtUUd3UFpSOXBrNWxLWWpoNG5tSVBVNHZUUlpWMHhPckgrYUh2WXk3bGhU?=
 =?utf-8?B?VitzWDRQWUN5ZXhISURhRXVGb3Z4SVFxK1orME5aeDhUb3BOWVUvRXcvL3lw?=
 =?utf-8?B?eTlYTVAyV0l1YWJJNlVJQk1ZYXBzS1pvd21FS1hMcnEzNEw3aC9PUEduVVRB?=
 =?utf-8?B?dVVBMjNoN3dseS9WRlpHd3VIZTRSREhKVVZaQ2lpSk1pSEJDeVVUSlJtZjVV?=
 =?utf-8?B?aExuYVVjbHZ5TzNOY2dxdkxuQ3hXRG5ETWxBRHhoOGFLY1g3RDhoU09lZHNq?=
 =?utf-8?B?bERyckVhaStyeW1XRmw4d1NhL1JZUXc0MUZxYVZGVHJGbkFINGp4SW1FN2p1?=
 =?utf-8?B?VmVTUXJnY1k5UmR4a2RjdXk4NHJYSGtzeUk0ZVpFNHl0TjFPYUY2RXN4Qndx?=
 =?utf-8?B?R0ZacE1GenBpQU92MnZ2QnFyQXYyQzI4SzNJNmlvcHNsQ0ZOUXlLeTNxclJU?=
 =?utf-8?B?NkVlN0NNbkMrQWt4SkMwY2tpSHBydWFEbDRmR0IrbzM1bkxyRzg1RWRpRXJH?=
 =?utf-8?B?T3BrVm5HQ2dDSjlVUy92TnVTRngxYUIxTis0UnlKSHAxd2xBUHB5d0E5TmZq?=
 =?utf-8?B?UG8rRmRvMTZ4cnE4V0RKTFcva3RWbnV2Nlc1clVwbWJPWkNVcWVLUjZwcG5w?=
 =?utf-8?B?NWh1VjVyWWtmVmx3Nm92S2FMWjl2N3A4MVlnUlNLcEUralQ2WnNRNFlZN2xD?=
 =?utf-8?B?bUpuT1dQQ1h4M0dPUlhGMXJVRm9DMnk5T1g5aFpiZDlpRG9XUDRYeStMKzFC?=
 =?utf-8?B?UEFvdFlxMWZlaDhmN095UW9vTmQ1bWxUeENtb0RGcWptc1M0UjZ3NWpDMWdX?=
 =?utf-8?B?czk2TDhnZTMxcXA3dERmVnpXMzErUkJVeUFTMFN0SVpuK1g4cmVLVkx1ZUxo?=
 =?utf-8?B?bE9HRHJ0S1VReUVLNWpEZ1VNQWRMVlJEaG1HRzJnbjNmWEhOYVRJb29Rczg0?=
 =?utf-8?B?MzVtTXhwSEFlbnM1RUF4N0RzcnJjSXB3VTFvSGt4aW0xbWRBWXdLSGtaUEc1?=
 =?utf-8?B?Njl4VTBQeGdNbVJuV0VRRU9QR1NSUURXc1YvS3ArSmZNY2pMM2M1N3RUTEdK?=
 =?utf-8?B?VUtwT3NWbElZSk5DQThFK21GWG1UNVRFTWN5NGV3UjcyQkdWK0F5VDZvR2Vk?=
 =?utf-8?B?bnc2VmpxNWdPQk5hR0EvbXJyWW13bVBNM3RoNWUvZlVnaDNzWUNab21pZGlJ?=
 =?utf-8?B?dmU2RGVwVkdqbVBRUk56elJ0SDVKWVNUYjlNNG9NWFZiNVk5bzlFWjY4R1VS?=
 =?utf-8?B?eTRTc3JkdzlUSDArN08xU2N5bStadkZ1eURKNng2c1llZTBsMVAzMkdYSk4y?=
 =?utf-8?B?Ykt5NmZQZjhmQ2hwWHk4cGVMYVdrenRZU1htRk8xSzczeFozc09pR3F1YjZo?=
 =?utf-8?B?ZkUrTlJKVmlyZnQwc0NBckRmYm91S3JRa2N4VTNXaDNBa2M0ZW9PQ0M0YStR?=
 =?utf-8?B?dEVsem1SQmlIRXZ5WVc5QkJGRkwwQ3kvT3JDS1JaOFJkVUdVYWlCdjFZWWlG?=
 =?utf-8?B?azJQZVBRUmhUUzhMS2xiZFBNdnNxdldPZlRZek53blhDK1JEeVQzeGZ0aCs3?=
 =?utf-8?B?bDc1aXUvUzhhWStBSEdndUhRb3RyajBUZnd2ZFEvd0lpMXZIcWFUc0ExbnhI?=
 =?utf-8?B?bHlJa0YzYXN1QUROc0Yrb0JjSW5tcWQ4NGttclVQcTVIOW85dXo1OGxxbDZD?=
 =?utf-8?B?bHptTnRZMnFNSGJUY2V1UXhvRXZuK2tiSWpYR0lvVDZJRXBNQkVIZ0trMHJx?=
 =?utf-8?B?bzR3UEkzMVY3b0J0UjRBcjRjbi8zcEFoTFhyOEd1YmJPOFBJNUdaNEhMbHZC?=
 =?utf-8?B?b01sK2JQWWpKWDZ3Tmo2VnFuMkhEYnV5WHZRUWJZZ2VNWUFMeGdTV2RETFVn?=
 =?utf-8?B?RGpNNm56S25aeGJSdFNsd0FoNUhiOUtJSDNsVE1xekJHR2ZkN3FVbFlGUVRi?=
 =?utf-8?B?VjZFR2FlWERwMFovUUV5Tk9LNTIzWlFySlJEQzFSNTVFVUpLdWgzUWJ3SkIv?=
 =?utf-8?Q?b8c13G1q1MQS6cEKgYjIDcg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eTZONEFHWlNVc3d5RE8vYytYdFRxUllUQlZMaUFFOFZYd2tzZ1pEZTVOcHRI?=
 =?utf-8?B?aStrenlWcGNneG9MVjhzU1RHM2QwTmVEWWZmNlNaNHdKT1MwUUlITWsreWU5?=
 =?utf-8?B?Y1lTb1J4cnlic2FsMVo3VmJnQ1Z4bE0wa0VPbE5ucFRnTm1ZSCszdDBDb05T?=
 =?utf-8?B?djV6VjdXRkhoaUprNGw0NC9ndHlWcmN0cXFXZVcyell6NDkxL1FqTUhDbDJG?=
 =?utf-8?B?dWdSZDBteFBDSUZZL3F2SFFxZU9WaFhFS0o3ZGVuNlc2czlVVjk0RjBvVWN2?=
 =?utf-8?B?K1BXU2dzd0YwTFFscVc4VHJIVUtWRHpDWU9OSUEvZ1EwTENkVHR3ZFh4TWF1?=
 =?utf-8?B?UjJuS0lBMVFXa1llNm9VOCtIYjRwTGFwTHJpbjg1VTUyOFNOZVd2SlMzeXhC?=
 =?utf-8?B?L25XYUdvM29ZL2RYRGl0N2xWTXZZZy94byt4Zk51ZHFMcHhlNDVPM3JDSytT?=
 =?utf-8?B?MEREVzR4M2lSMEEvdzJoWVFtVVBKdjFPUmFQaDhsRmxuVTd2WE1pZ3V2MVI1?=
 =?utf-8?B?NkZ3TGdvVHhCR2R4N0hvMHFSVWdrUWpTM21GTXpGUkdCUXdlaFY4WFVxRU9R?=
 =?utf-8?B?cnVzN1ZnakYxU3RRZ3lYOVhZZU9BMVhuR1ZnTkVVM0tMYUtpVUFUYkc1TVlr?=
 =?utf-8?B?eEVvU01LWHhZSkFncTJBdS9LMEVxTmlzTFM1UEQyODZNZW5LakNxaXRUTjBr?=
 =?utf-8?B?bXpiMWhzRDlpN2ZvM3VqYVQrZXRuNGJuZWE4MENIRm1JaFJQdUFzRGZCN1RF?=
 =?utf-8?B?a2N5VDMyYVFnQUJRSU5iVS9NbkNIY0JORFhha2MvQlJuckZDeVFDQ1E4WVJn?=
 =?utf-8?B?T3lzVUFOMDc3TWdiK3dDYURhWGl0T1V5Q3RRNSt6ZHdBd0JEaGs0STBjbnRT?=
 =?utf-8?B?NWY2TXlicGxvUFZ1ZUxYNHRnM2VOQ3F0eFdKWUg0SHVLNTdxTEROTjFlSWl4?=
 =?utf-8?B?OUM3V0JzZGRDNWw3YVpGZ2c2MkN3NVF0QVVNYUgwV2RZUXdEVGFuRHdiTTlH?=
 =?utf-8?B?SW1oS1M3d1pFWjlNKzdIb2dXaGwzMDJuMW5FU2JoUFlTUW1GNEVHemthMVNZ?=
 =?utf-8?B?NkdxWXpLcGtlZlNtNTdhOE5SZUlUa2VVanpMbGl1ZW9idDBydmJGVnpVNkth?=
 =?utf-8?B?bmh5SlFhVFZ1MlRMY2tYdzg5RjNQQWljbGE3NzhMRkNLMThKMzM0VnV4S1Jz?=
 =?utf-8?B?VVpJam9uMmZlWGZOdEdjNGdhNmlCbjk1NXp2UEltVmFhS3NRVVdSclZiVzdx?=
 =?utf-8?B?bHh6Z2RJaitWblZsZzZocFFBS2NqVTVrNm1NekpYRG9MUmVnYkRTclJHL0dn?=
 =?utf-8?B?bUUyUUJGaE5ZbkNkVVlPMHYzdnZocUZDTGozN1RzUjhlTnZrdzZmc1ZrNnNL?=
 =?utf-8?B?UmtlWGtsejFmK2R6SEQra2FaajNFMnh6Yk1sZzdkTlpTVU13a0RKMnlBeVMz?=
 =?utf-8?B?TmZrV1AyN0Z1MGFvRGw1eGg3Y0s4elROUS9NOU4zaGlKZElYNUZnS1lmQ0lL?=
 =?utf-8?B?bkZuYmZEcEJmMjlWZ1lXOTVodFpQZGNYYUtDd2JUK3VWMStiTEtsVDBYRXBl?=
 =?utf-8?Q?n8w0dVyrl2FtQqR7L2l10YlxLc2L1snGJfj9mQKiRNvUbi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcb7637-0b06-4596-ea5d-08db683738f3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 15:44:19.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/iIWFG9dNM7bg/fxF27c2IZapqUYvvaZtk5JoFxYHzUdsmxc266dJuIINpcJX4/3Pe/pe0U2E1t7QuGI5qCKiNRlAGP7gY+6PXsb5bp6gT5dQTnJLi8T+3pXEPbJPlA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_11,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080138
X-Proofpoint-GUID: vnbRiYOxZ7O5BxQ0QB7o-SKt_ZWxiPNp
X-Proofpoint-ORIG-GUID: vnbRiYOxZ7O5BxQ0QB7o-SKt_ZWxiPNp
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
> This is the start of the stable review cycle for the 5.15.116 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.116-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
