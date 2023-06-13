Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50C072E2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbjFMMSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242365AbjFMMSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:18:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA6A10FE;
        Tue, 13 Jun 2023 05:18:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65kex030526;
        Tue, 13 Jun 2023 12:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ch5vs/nZi8Q/jTGyp9JbbYGaJJ67VRqD2lhnfnM1f44=;
 b=fYg9/Xiol5lUNHrOuqjM+epUa+Cv0tA/tkzJNowAyso5fp7Vq3U/bTiyWQDmdBZOK0hk
 LhjndokXj2NaSrLBPJR/pbSDIpHHbThdew+9ibEX2ked8Dr0PvrERHp4f23nY0vCwPCm
 jIppKYMrr+yhpViQ/WX8VfFrjABCq3ihskeHqqNerv2ioB2lpY5/a5iLbS7O4u/+nPeU
 LLpqILxFMxKjlbcNwVeBxX2h/we59cMWJj6fvhmLWK4Lzed6PFJp3T6pXWAYcHZ9Pdh/
 0PrZSkcVQFtgPnllU1INoQMsXbbZAAZfINF97vcfhNc6SyWQOV8BENW0ArR1Uyh1Smu8 1A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1w4q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 12:17:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DB1tKq017817;
        Tue, 13 Jun 2023 12:17:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3tkn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 12:17:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro6XPwkzUx+mDAJWGtl98frPX5Diheq2BRgm4BIUAymxZjyI/klEUtwWu5eqHdqoIznKlFV1NnBoV9bV7wZPBooe2gWwZLsUWmLUljb+H9vJnkJOBDY4AWOTaSWLu/IRqa4NRESR4j1Xq4XkIXO8icIDt+sW5ylU9jpymIqOfTBk7Z1jnDEZS1l+doT5CLiKsVXOsS0f3T52nEuqDhBl0BLFEZKiXQVwnrV8fh5gD28WCOJHWdyFKn7zuyAaB/tqATXCbQt6lX9FyjrPvIiVoySmOryfGGNyrcUa+jE52PUlCh4HG5obQ01KhkjO1roABSmt4pdusZbkEz9CEUexsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ch5vs/nZi8Q/jTGyp9JbbYGaJJ67VRqD2lhnfnM1f44=;
 b=a4ujOKmV73+mLMupyVWMvVKnYWxMe4o0dhzOsBCM4z88q8zFWMc3nh6Uck1B5sok1JQSIBiG1tr9B0T8HyHCgGepkSV/M1QPBRECzaG35Yu3avdCKY8r+guQmow0RvLfAw5IQ83y3YnpSAFOd7bFmKDkzb5bI1PsxUkRiqvIfgVs7Wd2YHaYVTpDsXsH+F+GthDoKrAHUVEynu9QiWeY+cNDCG1Z7l/YG9Xs48dvC488dEQKnUPD1R88INsi99ggku+Eey4Vfa/Ay4ggi0xjrzLo8g3mXwcrw2IF2mFJ7mp3piZ1NZKEeAkkh/reuq4AP73cliZaecv6TkmAZ0mhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ch5vs/nZi8Q/jTGyp9JbbYGaJJ67VRqD2lhnfnM1f44=;
 b=uqHNBcgWo196WR0O8E1yDj/9VMY5dNG/oaDz7hEDA0anKlmkJPR7/lDQd0/2+RA+tPgYiivGrKKRG6ker3XVSxZwZU3VVS27wQLJL/wwI3u05v+Mxs+ZYKhtIDaed7BfeQOaZjVeGy3+E/mkNbuTaND38qERpy0SnhKujs4Ljh0=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CH3PR10MB7434.namprd10.prod.outlook.com (2603:10b6:610:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 12:17:26 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 12:17:26 +0000
Message-ID: <bf53d696-603e-2a8b-a734-f2a7bd48c0da@oracle.com>
Date:   Tue, 13 Jun 2023 17:47:13 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 5.15 00/91] 5.15.117-rc1 review
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
References: <20230612101702.085813286@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CH3PR10MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c741b14-9624-4174-f06f-08db6c08265a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RU5l5fw1WaEAmYP1Clt37qxjnjQqxa43W2scbPHOy5MAAL3XTtOI2KDwTzQYvacNLv6YtNy1l3947/+BGXDJipb91PSboW3jqHlaJIuiSxzSA9vHw+i3Z1vjeGlhoOWV8/e60Uy4m8KPtgIe9cZV+81hVRnmihWX0kuHmYLKl3NQ2Tniui7oWZdHxRGE6uqQtQYH6frWpKDYp+rWlIYyyEbW7qSoRB12h40xFN5yL35ZSGC3Q/rF/Ia0uM9YxB8SLZ3xTbJb4ZG1zwz7PNf+qTPRnzJ+35ZGgzZ/SfGBNesOvmKxLHkWYXsGw7jDl8srR4kJI+g6trVdZKgrG5Y5Im2rfAM9J1Z/m3ZfF22OvHI/pJXmL26/rA1LVPXYnocyeNDDMmrDTreh6XgXe3D15Q1ZW6cdtYOS7AtU3vP3jXrZlEIJSum8WmZX+pTLPt7uEpUe7JJy/KeFZDBPY6LqXfBI6BaOne5LbZuvMMylscj71FeDZVdHZjZibjsfQBwHg+Wd2NUJ2JuJuQZ9J7G0eDpTQlwLWVndxtmxDvbTBrYr4LBUIezYpPCN0QrBHlFTXLhRb2MXBcqyaoHUC0B15Fr0idBbuHDegBCeMv8FhH5pvgqr3F0olf1CL/cf4NeQYgzmotlEyZSzIYhsOvqPcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(5660300002)(7416002)(8676002)(8936002)(4744005)(2906002)(31686004)(66946007)(66556008)(66476007)(6486002)(6666004)(966005)(4326008)(107886003)(26005)(6506007)(6512007)(41300700001)(53546011)(316002)(186003)(2616005)(478600001)(86362001)(38100700002)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SndQeVRFblAxdW14bGVRRE1heXI3QkdVUGpkd3NoSFAyYTNCZldRUUx3cnNP?=
 =?utf-8?B?Q3p3VDh3UzFmaWJnN3dhYVVKbmhUVXFjSDlkRmVkU2tzeVhOWlUwdmEydE5l?=
 =?utf-8?B?NkloVXhxYjUwanZ5N0ZKMFRwUW5qTEVxYk9uZVpwTzlyanFidXJzdHUzRk1s?=
 =?utf-8?B?NVRqVnNRTzd6WS9XOGZrejVMUXN5S0V2RmR6MjE0bTJISG9YMXBxTTVwb3hX?=
 =?utf-8?B?UmJuRE1NdU9LWllCakJQK1RBV3Q2THRGSXRaYW1BK3FRU3FyUFhDcjQ4WEhz?=
 =?utf-8?B?TlZJemxiSVozN3FKWGFDaENRVERKdVZYbDlPZE1zRWdzblN1L3Vqamw4bEZK?=
 =?utf-8?B?SG1hSHZLamdoRkl1Ri91NktQYkhEMmhKdXNpMzAzVzR4cDQxUnBZd245Y2RW?=
 =?utf-8?B?LzJLVXl1OFBCL2czOWpoM08zOFJZdldUeGs3TDhHcFBEcmhUbG9hZmxLWUUr?=
 =?utf-8?B?TUhlUFcwUmd1WS95d3dwQm5rbFF0VkxoRG5wVzlRSktENTRiVzBVWUxiczBz?=
 =?utf-8?B?K0RORnYrNUdsZlEwdTdMUHpjeTRXb0l6Mm9TcU9sVHQ4c2syNXJLNlFKVDdH?=
 =?utf-8?B?U3JtdjBhU2xmcE1JSzg1WDdVaDZtd2V2ZFp1OFpVeVhBOUJMc1hSNlpOVnhp?=
 =?utf-8?B?MXVBeS9OQjJnMnJhWS9YRWxCcjlNemp5MXdIRk9GRGFFem1kUTBxa2JUUlFy?=
 =?utf-8?B?SjVQOHhoWWNzWnFnRVg3R3RLbi9Na1E2ZWxuNmNiS25xaGpFVWZMSHRBLzhH?=
 =?utf-8?B?RHV0V2UzY1N1N3IyZVlETTZ6YVFVTDdtQjFUSGdMN2hxeEcrcG5DRUtLTDVa?=
 =?utf-8?B?cDZZRGRSOTVlNkovNng2eDZEMEhMcU1KT0RrRmR2aVFNaHAxaTUza0RzMXIr?=
 =?utf-8?B?ZFBIUEVCeWNoNjZhT2FVTXV4UWU3TlJoREIvT2tMWEk1V0NrTjNSYjhkZENm?=
 =?utf-8?B?WExQL2x6NDF6ZmZZMjY3K0xiR2c1Ym54ODllTDFaRm0wU1UvNzAxeGRQNCtn?=
 =?utf-8?B?LzY3VVJNeUpWa1M5bEdrMUpWOWpWTkYzaVNLN1lEZlg3UEVESkpZNXR2d0tk?=
 =?utf-8?B?MmxuaGNpcDY1aXNsS0FRQmtGTDY1WTNEU3JuOTI5T0FBZHJaQmk1M3ZteXVh?=
 =?utf-8?B?czJuTlN0ZWl6N1VXbmprUXFaak9wMXkwbDVrVTV2SWJKSGVGY2NKdllVWk82?=
 =?utf-8?B?VzNKS1BLZSszTEQ1bU02VWNBRXNnWGNFUjVvNWk5Uk5ydmJUNUJwaFBpOS9N?=
 =?utf-8?B?WlFJenF4dWZoYU12SVlSQ1F6dXl6WTlCQ1Q2RlBCMWYrZnphYzJCeE83dXVi?=
 =?utf-8?B?cGtRa2NUZFFLeHJZeVlYcWN2WWRlOGViQTBMUFVmV09wNnRXdk1yOWczaHhq?=
 =?utf-8?B?ZUhqRnFCd2ZLTXJkcTFDeU94MHh3ZDBSWUo4VHZYaW51WWZTYTk5NGpwd0ho?=
 =?utf-8?B?eXlJeWEzQ0pxSU4vYldHMDhjT3QwTlZkdjJQRGdVRmMreXFBT1JKUFUxaGVx?=
 =?utf-8?B?SGpYbno2dGtYamdLVEFGUzRkRkxaMlpGdzFBRGkyMHZFSWNEaDhiSEl2Qk5Z?=
 =?utf-8?B?cS9XakJDUVhLYlRBUUx2d0lMZ04yUnVCMVI5VEdEL2V3c2hMNWdVRXFZUktL?=
 =?utf-8?B?bHliYndESVJ6ZURtM2oxOUkva0JVUjArVDMvMTZuZ0o0TnpTcWh4Mi9tdUk5?=
 =?utf-8?B?RGVWM0syc3Q4cTlJR1JFQkRHRWZYcjVXbU5VS0pISHlVVUVKRzZRQ3hjTUtQ?=
 =?utf-8?B?Sm9MNFFBOFk2b1pMUTZtZDJvVFdNMGNhN29VK3J3ZVdNdDlnUVRIc1NPM0Fn?=
 =?utf-8?B?L1Yxa3cwbXpvWFVtRFhUa0tGZkpCV2RoVUwrMld0RzJrWjJUN3Bsa01qenZM?=
 =?utf-8?B?QkR3UXdhVmR0dndvZUV4UkNmUkR5U1g5bnJuZnIwNGl1bzN2VmhubnBDb1VO?=
 =?utf-8?B?Smx3T3crZ29TaHljaWRBM0tUektZQjZ0Ujc4eGtRL0FuNlZLd2ptUDZvemZ5?=
 =?utf-8?B?YjhHM2FnNUMweVlURFg5Q2xadWcvSU1GYjFxeGR0UllkanhFZWYrVk1JbnZ5?=
 =?utf-8?B?Um5BVGtGQXJBbndXK0s4WVBTRzM2L2ExbFJkcmw2ZnZTaS9qaWhGbGpaQ0Rh?=
 =?utf-8?B?SG8vR29iN1hiT2xwUlR5bGR2YW5TbTduL0NzZXlQamovdXhsRm5YU1V2UTZN?=
 =?utf-8?Q?kXxZR9ArMpUccZE7tdX07FM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?c3hweDFuaDF4T0NSelNTMkRKUHpPT0kwdnhDblhYVDZsaVVJd2kxTXFrRWs1?=
 =?utf-8?B?QTgzUnBnNVFmM0RQcGxQUVlkeVFzMW05UmtKV0U2dEM2dFZOOVpHNEFqVys5?=
 =?utf-8?B?TGdydDh3OG8wakZyVS9CMlgyYnBNbHNTMitCTnVDQjlTZHZwWllMVEZmTFU0?=
 =?utf-8?B?RzBTUzJ4b2dBWENQZUtlSUg5Rk1KcHB4OHNQcnpsUzVFQmIvQ0o1Q3gzN2tQ?=
 =?utf-8?B?UDd1ZEVJL0FsRUZlWEF6Sitna3NWQVZvNERtV2FzcEJka3Y1dXlFYlY1MTE0?=
 =?utf-8?B?MStYa3d1eUlLR2cwOEpHMllyWldnWGZrbWYrZ3p1YTRBVG9lbjhzZ1QxV0Rj?=
 =?utf-8?B?cDZ1bkFjOUw2UWo2eExTOFZ5VllVOFUwdWR0MjNLWlB4NG9iSmVlcHBZMDYv?=
 =?utf-8?B?ZG9TRnB5SlJJa3VJOVNPWVF5NGxncnhLZ2oxek9yeXkyU2dkS2MvVzRPUFNp?=
 =?utf-8?B?cVBnZWZObWZTanVVZFZUM2V0eU1DUGZldkZRSGpQZFE1N3Ezc1dRajhVN2xY?=
 =?utf-8?B?bGR1c2x2N3YrSEZDVWdiK2lLNUVwN09hZ2lTR3hpWHZ3TDg3N0dManFUMUdN?=
 =?utf-8?B?ZVJPRGFJQ2VQRmhMRHNoWmtENmpvUHpTQjZjeDIvRHptaTVjUFV5QlAranps?=
 =?utf-8?B?elAxdzlHdkVMTW8reWxYemJEeVVzZXBCSUxIbHJacGVkaDl1T293SnRLcW9U?=
 =?utf-8?B?Mm93dHM2L1VyS2tyTndOeVR1bCtxbTJiSXVNN1BLY3V4U0V4SWZET3NtYktR?=
 =?utf-8?B?VWVUVzRYM0JKR2tVUlBFTUpoZ1lsNmo1NUF5T09LTkVjajdWYkptWnpqSmdY?=
 =?utf-8?B?NjNwWWdMNm5UckJ4Q1NiaWdRNFNUbHY4ZmlwMmtVaUFkSm1qVWdtSkdUcVlv?=
 =?utf-8?B?SnlXNE9TL2crdyt4MkRWSDJCT0hVczVrbUExS0QyVkZGNGlOS0ppUVhkbURa?=
 =?utf-8?B?WGpZeEhGUnNDK2I1MTVtU00rK05xYU9tSGo3RlhaY3V6TFRsQ0JwVDNidnlG?=
 =?utf-8?B?cjkwbTdubVo2QXY1Q2hmdUpxZ3E3bjZlcVpHdEdDb2Y2VmdWYmU5QURWc0N2?=
 =?utf-8?B?ZGdoY0dxbjBubGdHbjlGamlPKzdTZUlUNk4rZ1cxVENJL0JsaVBXbHdWM3Qx?=
 =?utf-8?B?c0dSdjVGZGxRcnhORG5GSlZFbTFKU1lMeWVaalpnM0RQT2NQMHU2QURyVGZW?=
 =?utf-8?B?VjMvOE50R3ByZ09ZSmVOamI1aWVQa245c1l4ZitDNEtVeHozc2JVZmN4Sngz?=
 =?utf-8?B?elRtbkprYVpQUjhJbzJ5WDlrWDZXVkd0MGdEelFQT1QwQnZBL0VkbWpoNFVM?=
 =?utf-8?B?VENRc3h4U1JNSm9nT0hqSmJvNmFzZXZjaW0va0Frb0d6Q2lIVzFYY1dKV0JU?=
 =?utf-8?B?eVVvblFNUWd4cGRwWVdUUnRnaDZXNnFpSUFiS3NvWCtuMmFjVmVzSTJWZTdO?=
 =?utf-8?B?S2w3dktGbGNYYXBZQlJOZGgzUmtCdmpmMjIrbG9ES0N5b0psaFBoM3d3Wjkz?=
 =?utf-8?B?M0VNOUNadDZGcjlVOVJLb0tKcjMyMnNqeEVmQWJ6MmQ5d3J0QlU3UE16Y2hK?=
 =?utf-8?Q?lO4uHX3ktwVYiw7lLLXKFwNe5xuUrFSfxaIwYDnh5I+lzc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c741b14-9624-4174-f06f-08db6c08265a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 12:17:26.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQ+Kn1Cx0wswXNJINnIoUydbwijVojTpJztRLr5/sXSCYRfOpi2hiAF4P3T0XvyUN+WLPFGHgoSA9p1zBt6i0C/xfw76B9rkM05xQBouNbJziFaunCSzotMEweivLwqs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130108
X-Proofpoint-GUID: SQu0_F8YpaeoBLLDW4OFLEUOyyMTWohU
X-Proofpoint-ORIG-GUID: SQu0_F8YpaeoBLLDW4OFLEUOyyMTWohU
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

On 12/06/23 3:55 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.117 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.117-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
