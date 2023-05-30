Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EACA7154DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 07:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjE3FTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 01:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjE3FS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 01:18:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835AFF0;
        Mon, 29 May 2023 22:18:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34TLO1EN011215;
        Tue, 30 May 2023 05:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=10/XIOK1WJoGjHB7eA8c+Pb/ezvTYNUiTvrPJ84M5JM=;
 b=VsOezotQ0dHR/ds8sFVkoj8n9MgZS7kfQfuBdML9jg0y+56UCDm7RFMNyFZTAkYJ7CD2
 9nKyMFIDiUnFRSLE57n5saajO/zULrR9fhlHvuKjOgiStPqre3eSUQXGndDdM/CICLht
 4Xd4iFOvAgg+ZFyxq6iZxpYeCXlMqaGmyRHE1btqzUjIjCVMWMOahICWb5aO/KJi3VrX
 VKdiGq54+5KYXRB4Y+new597hVKjB7w5m+TJ65A60CSidetP+0d8c8TLU43fvR+CIbdW
 y4ZD71G/sI+r/uXQEU/R0/VPQBDuWpy/JS9CrD1L1RZUH0SaLoovyRoewkJQDbWF/zPP gg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmehtnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 05:18:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34U40jwR004414;
        Tue, 30 May 2023 05:18:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4yauaqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 05:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADwrpSN4bHGQmkV08IRE/PQL+4ZAQaJhiwSBXWV5iyeW39zhpq/+379Wtc5yOC+yDLLCYeBQ6RPxpt9Nu0+xTe1Cd4/04MiK8ZzIZrXSZJKx9SQIU4bjhZ8skc6TcvFqoqUQTFvShKLq1eE9Ep8ngu32UPVR6ARwhbTAU+Yai8d0aAJIQdSMfS1EXLgXxlQ6aRsZWAGVT5OJ30lvOvMA5RyH6jg0v6O0iHwVscS3JZ9Z9ai/p+mr73HwSPo/HAYRdWYpHtX89e9gmwZTid8pH/swn8sbZvwxnKPFm40ejVnh4vmIf3kz5YouFWEJQTlNTsAcEy+dgjHy5zLXR/y6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10/XIOK1WJoGjHB7eA8c+Pb/ezvTYNUiTvrPJ84M5JM=;
 b=QmRycuSlSp6aPfrj4F0fyWDfCPAOP78M9WZH+oh/EE0x4FKqATljoJ8F6XYNcZwqLO3iK5gB7vkzIn4ch6XVMcO4ZT8+P4mkyVQ2rCKTg8B7d6e/O2w0+QkH2VAQZ0CgJZNea6GNDEi6lQzcOcg3SXhj8n7UViOypUfwTSred+m6W2zzmMJt0LeUfOaPfPu2Eq6vwMtYASXOzA52A3jM9NvgVsWcfEwd0u3B554dBHF3PNyur1KmMD2Ox1ocmRAqNHksWDiiILZkrBiy60iLrz418h9vdX2d1KLXPw6TCIB8kBkMor08AeXkYYmSAB1I13rogMa7KHiqjfz441hD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10/XIOK1WJoGjHB7eA8c+Pb/ezvTYNUiTvrPJ84M5JM=;
 b=bNGFzLXdbh3ZZkXmNyXkIs43wKMjc4S5mnU2RWWF7gO9th2cKpQtWH4fuT39uQtXpQFs0jetmvdB19aYwacUI2bewzNwYOweOo1aV/BSUFUgzAjkTVsuZKzmAOUtM2L5n2lpbMz2tw5TjC0Yef70LksR7vwWTNB8ghnVqnQh5fM=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by IA0PR10MB7383.namprd10.prod.outlook.com (2603:10b6:208:43e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 05:18:12 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 05:18:12 +0000
Message-ID: <d1045faa-a4aa-6439-983d-4f4a18e38f9c@oracle.com>
Date:   Tue, 30 May 2023 10:47:59 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 4.14 00/86] 4.14.316-rc1 review
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
References: <20230528190828.564682883@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230528190828.564682883@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:54::21) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|IA0PR10MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: f07427b8-846c-4907-3532-08db60cd4373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdm6Cg+bDIU5dQZkbNS2vuo7PolLVIwC7a4ugXJ59cCKPpGuzrllJ1ZbvtsRq+Lww5Ls//AXpifKi+AxxuJOlQoHbpH+EOtBbNKcMuHLvLU7LBZAL+ZJhGYhwRGgR0H96weihRGyumtHFBRmgfPXhxYdaOGwm2YKtYUVg/C3CbghaWx2k8tKhO1VdYcCA4w+szuEEpVmEPR1P2gNtSvaIq5ZbByrquj/4AwCwSW0BIQy3hqSXnNaY6Y78KfN1E3WSpCp714CqNAj2AwZapQX40lD0ipkucFY70MSZAYPP3gnau6oFzjOnxS+VzOW7i9LkWvGZ7SVViEh0OE3noDyNLQh57mnQZN9os7vVfu8Mv2qtQzimllTKMY4ruIuBHZ9Ickk0I7m6PeLyyzYYdlHqbLSmWa8KvPpnkL+2WEOOv2aLSdDKCvr28OpIYNMa74VHliTEKOLAm+W5pAGq48NU5XSwfnNUzcGODVWHNXxVt/6Iqf66xwdU6nVsk7nTvPJR3fbkiaUIY9VPwx8tqxE2eJCoa8llJy+xj4p5ijs5mXJXrJ3B0Fsmv7lGZl0xcfamf9rIgin3ZB+SuV0stOz2BzGyMpAZrMQdcaNXFwQf3LE8QWKNgr+Oz6pb3wCoAeK3SbbjAlf9ogtBxrevFdPpu9OLHLl/YT9uJN7u31BypbDgSqTGBYi9E5KDiQi1Cbs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(966005)(478600001)(83380400001)(5660300002)(186003)(4326008)(4744005)(86362001)(8676002)(8936002)(6486002)(2906002)(41300700001)(31686004)(38100700002)(31696002)(6512007)(316002)(6666004)(6506007)(26005)(66946007)(107886003)(2616005)(7416002)(54906003)(66476007)(66556008)(53546011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnY1Y0ZRT2RVYnNiUU54SXhXdzNNcFhhMEJEZ2pzbnNQMFU2K2dGQTN2Ymc5?=
 =?utf-8?B?R2lMcDFFWHZhRTU1QkJCdUpyZVF6Q3FobWRSSEZYMUo1TWE2RVRuejdwcFYz?=
 =?utf-8?B?MzFJR1d2M2VUSWFZV2Z5cHVaSlhTRTFUaUFHZ0tZZVppZHgzTkdRaHppT2pH?=
 =?utf-8?B?UjcyZjFhWklRcERHMVFCTHhUKzV4WlVURUJSaEtLc2tMVjZnZmNEYThQaFQ3?=
 =?utf-8?B?ZzczdkNGaXpudU5kcVZrQldMRTdUK2NXUHYxMURQeHArOVFjMEV6MlB0bU9N?=
 =?utf-8?B?QnhVdFc2M3p3dTlGRWwzNU5ndWhpYXc0ZlFERXVETkw1bzNDY2ZHb3NvWTN4?=
 =?utf-8?B?UmF3OG81TVBEVUlMRlowMndWd0hseit5UkRXYlcwNERYeWpYam9MYUROMmVn?=
 =?utf-8?B?a0pvOXJTS0VSaEVNU1U1VUNreXViQXhXMVE3c3ZmTkRnUzZKME9GQk9QUjRI?=
 =?utf-8?B?SzBZVE5RY2duN1k2MkZwbjd2OXFjQjJiQlcvT0ZuMjVBVnMrU1J5c3BIamdh?=
 =?utf-8?B?OEVJNWlzaGorZjVHMGx5YlhZZSt4R002RnVMUmwwMTlGZ2pkd3l5MmhtQ2FS?=
 =?utf-8?B?WTVkNE9DVUY3SCtqMUJxb0hoSi9ScHlrOGZpZWYwVUZweDdzODFFSHliOTJi?=
 =?utf-8?B?NUZSTHdhcE9Xb24vQWx3VFFqYXlaZDFjaUJmQUczNUJxWmJpR2RVOHp5UFhG?=
 =?utf-8?B?Kys5L042ZmpBNGhYWmRqN3FjMHIyQW9zeDBFaFNxNGJRZ2w4OGpyZTFZdzND?=
 =?utf-8?B?SVRNcFgyR2VvVTRUMVRNbHNPNVlReW12UWI0N28yd05FKzNTWHpYWkdCdkpo?=
 =?utf-8?B?OXhHbGRkN25Bc1g1K2VwVDZJZmpnbTkva3A1OGRiUmpNMVQ2Szl0b1VyMjZR?=
 =?utf-8?B?QWQ1bW1mbUd2OTM5aUJ5MnE5R0ZxZm56alNDMEwzdnBtVUJLSU9IM2xiZGRI?=
 =?utf-8?B?SUZwc0Y3V0hDRERZQ2V5Qm9pNkpPNG1HNEs3ZDNTTVhtbE5SS29iMVZQRnpP?=
 =?utf-8?B?ajl0a2dvWmttNytIZ0tmd0Z5SEE2NHl5b0NiWThLZFdLbkhHZmlPVFVZc2ov?=
 =?utf-8?B?OWlsZEwxc2o2bXhNMEJpNXh4cFVWWkJrUXd1SEhWTjNRRElJczNjbExsZnMv?=
 =?utf-8?B?NVlZSVc2MDRkaDFGSm94eXhtM2p6ZFZzTFNXWFcyMmsxbmJ5Q1VlejQ3UWpo?=
 =?utf-8?B?THRPR2toZm5ZR3I3T1M2TnpmTHc4Y0h2aHd4YnorTVpoSkFvVUo3YWt3MnA0?=
 =?utf-8?B?QU9zZThNWU9CT0VQdkhIM0ZyQlIwcW9SY3luaWYrNTgrcmVaS1liMndxcTFm?=
 =?utf-8?B?L1VPc1FHVmZJdEx5WWJ1VFprWGMxaUd0eVRIYmxpblE4djViUXFpZ0ozNE9o?=
 =?utf-8?B?NVlESHcrTEo3V2Qwa2dTaWcvM1FGUXJkVm4yQ1lSaWxPQ2tFdGlJR3c5eHRr?=
 =?utf-8?B?UmtOeFdnVUk5WUxEYnhSZyszTU1BZXFNaVdrZE5oS1MzMmk5QVRsSWE2UGcv?=
 =?utf-8?B?UWxWVnpSR09JUkF0U01yYm5lbzVxMjhBZnZWdHdNNE40d01IYlo1STJxdTZJ?=
 =?utf-8?B?M1lFbjNiMWVEcFZEbDI0S1BlTkhzNDJMWitUNkdZYzhTNjI5MVBMODg3eTZr?=
 =?utf-8?B?akhma2JMRG0xNHRiQ1kwUUt5c0xMWGl1Nzg5REZicklWS0p2NUsveUFqUjd3?=
 =?utf-8?B?S3NUUjRJNjBid3plaHlyTVBRSWhrNXNhNlprak4zQWptandvbjhKcXc0aHBH?=
 =?utf-8?B?MFIwK3BocTUzd2trV3JBNVdmTUdabjc1OHlIc2hIUXBZQnd1NUU5Uk1mU05q?=
 =?utf-8?B?Yko0OTR4TnRMbnZ6MThsV005bExjekx5bStSNUV1Z2d0Mk8valpzN203ZWd4?=
 =?utf-8?B?TE5qV0tpNC9jcGptM1Jyd2JxN3R4RDBGamFqcEY0MmpmbzZwME80RG9waU5I?=
 =?utf-8?B?VkVjZGY4czB6TzBueWdCdWtMbHpUTEVaVEx3SnF2Tk1NRm9odGgyUElaWURx?=
 =?utf-8?B?NWxPcUpZSmtWYk92b200RHhkYzBacVVWY3ZRTEYwYmNQOW5wWThRWkpNWHBU?=
 =?utf-8?B?Znc2WXNXcWJJRnBGY09lS2NsQTlNL2RMOWgzOEJlWHc4YXo4Q1ZoVzc1NERr?=
 =?utf-8?B?QW5zZnU2eVl5QXcyVzB4OWFXaVUrbHIrd0ZwdnJ3ZitCaEE0SzkxRE9ZcmFh?=
 =?utf-8?Q?pZK09x83gk+FZg27M960srk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bytKSldLUXlBTi9qZXMwdGtxQk5ZS01JYWJVMnJPazVNTFRWYXFUZW1lUkpv?=
 =?utf-8?B?K0FzaWVudFJmd1ExTXg0VTUzNzZjTWpHL2NEd1A3MERTalpBa3oyRjAyNWNX?=
 =?utf-8?B?ekN6cU9KdTgwSzFxYWtpZmVKeFJ3RFpFV25EdzJhK1VPM1hvVXRnUThKWjlZ?=
 =?utf-8?B?NC9GNzlRNkxvRjBMTVJpNkpiKy9EMWxnRHYvOVVrRUZENlIyTVQyV21FM1Vn?=
 =?utf-8?B?cUFkMURnV04rRWFBV3V0cWdLUC9HQzIySllIVWY4WWx0S0czZGM0MzZ6WW1Y?=
 =?utf-8?B?dGdGeDhlTG01Um9oYUtYdTIxL3UzQVBmcWRGSEtYQXdRakwyK2xMSCs5dkNK?=
 =?utf-8?B?aFFWRlNWVVNrZ2RJaDVLSDBGdFRoTGEzTXhydnprY1F4cE11ZG52VmVsSFpy?=
 =?utf-8?B?ZEZZclU2RUNWZlAzV1ZocTRlRlVkSnBaU25vQVdVaG9TVjFnbU5PaDhtSmNX?=
 =?utf-8?B?enVDY2FkbnFqNWdhQ1NSa0M5M1FlMlgvSklQazVOV3JQa0lOSGFCWTU3aC8z?=
 =?utf-8?B?aWx4QzBTY1UwUVNHZThZY2NLWVk1ZU5Dc2R4a0dtTHRMaXhscGZNUXhjcmIw?=
 =?utf-8?B?V1o1dFNidURXZXFneUZtM0UwYW1LSkdDWDg3c3p6K2lxVTZSTTdUNjFSa0cx?=
 =?utf-8?B?YVFtbXMvNTVBeUZtbkJCNDIySEI1RnZyclJyMGhuREswNG1vRVpkaTdORmZv?=
 =?utf-8?B?RENtdUU5MnVJWDJYb3FCeVcreW9yckJoQWpmLy9GWmJrMWpRa2MzWkFLR0Iw?=
 =?utf-8?B?QmRQS3pXb1p4NWJvSGF0elVIKysrWlZBRVZ0akRuazlPRzNndUxIaWVOUGkr?=
 =?utf-8?B?UmI0OHFMd3RmSU1pUFdsLzYrRU1tdklMNTJmd3RlNVBEMW9VVk5wS0dDUG9D?=
 =?utf-8?B?dmZyL3JWUDAvWVNZTVBVMDlOUnJLU0F5Y1VKd01ITUFpTkl2V2dqaENqTk9F?=
 =?utf-8?B?amw4UTVPYk8rSzVpRjh4bUJGd2RJWGJDeXZIcTIyVVovKytPRC9BN1hmTkx1?=
 =?utf-8?B?N1NYdktXSU91RkR5UUZXMzFHaS9xR1BOb2ZVVFFvdTFLQWJPSDBSSXlKNzZk?=
 =?utf-8?B?ZkhaMG1iY1l2UkJhMFEraUsvY2FjRDdsemVzamVXRHM2ZWtUNnV6cW1GL3ho?=
 =?utf-8?B?NEI4R3lvS3lBeGdPTENmcnBxVC9iNnZSb1hsTFNmWTFJSUZBdHcweWRjZGVP?=
 =?utf-8?B?R3lqZWFpclJPTEFTeUM0UjI3TFpHM2gwYjBKZEhtVnFPMmwwY1lORXNjRm9n?=
 =?utf-8?B?cTBTVEJQYTNvb1hPUzVpNUVUa0ptditPa1oyMGN5RFhCd3VybS9OajZleCtx?=
 =?utf-8?B?QkZpNTczUmZ0ZXhyUnUyOFNRZ3B0ZDZlWDVnRXJ0STVya3FUUXRQeVQ2QXNo?=
 =?utf-8?B?a28yZVVEenRQY2l3VEF0d1hHVkRVRFB5RnNvajRtZGVKRWc0SlpXa05UMUJ4?=
 =?utf-8?B?ZGZTYXFQc0RBbVlleXE0UnkvVHFkV3NPcGMzT21JL0tTNlRkTlZIV3VZTUtH?=
 =?utf-8?B?Z0M0M2xpMFVsdTc2MlVWTGw5OVFqY0oyVGcxZklad0xibWVXWkl0OWJSeWJI?=
 =?utf-8?Q?2H9rGuzkCoPaliRNSfoXjBlPTYmsji5KeJyK+SA6/94DCv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07427b8-846c-4907-3532-08db60cd4373
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 05:18:12.2620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9cTJnNZG8xSDpHLVuuRGg9lW7V/KtZlOlu6yHR7ut3Z4+wO2zQP0ceGCgmhXqujMg4Y3VxqunIrZHtIF7+p28DXuKty3tuulhtZymCcoSfGRdnzB6Sq9oal6EwWLrZX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_02,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=982
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300043
X-Proofpoint-ORIG-GUID: uEQ0MSw-8CejUsux1qwfHxBMRIldfXXN
X-Proofpoint-GUID: uEQ0MSw-8CejUsux1qwfHxBMRIldfXXN
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

On 29/05/23 12:39 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.316 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 
No problems seen on aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Other than a build warning reported here:
https://lore.kernel.org/stable/2023052919-jingle-pang-082f@gregkh/

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.316-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
