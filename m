Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568CC704A12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjEPKIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjEPKH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:07:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A94F19BD;
        Tue, 16 May 2023 03:07:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34G6Tcff029999;
        Tue, 16 May 2023 10:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cw3PhTmEdrwZcmVL1nd7UG8XgGpqNjCh0IMM/zrPtaM=;
 b=XyekH/TwrI6SPNtb4TPJbElyOgwyAYG89BOCCEcODj+bjhPQ8MnyLjC17E9NNj8z+JP4
 vfG5ugfjLp+TASz/2o8Yv38q1wqEIdSXq6vpZQA+kNINlZxsXT/a00xNwjSMTeU9C1he
 ExzVkwrRCNgHeP19gkSN1nVxv9eVH46Nm/hU+0cSoy56Ysrgniop3LlUZIP3Ju/KRf/3
 /Aj35vw5fNZkAiFKYXW/xTspnT9Pj1YXU6bFFkHNZ2fQdRuZJLL6735IY/vaexyIsuDI
 +onmKAkl7oDKB8XjbHRokQR8qNfExgbnUILQ5rsPR2jBFyHxT3Y8NioYux/qMkMTOaXZ ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1522pe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 10:07:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34G8uqla038912;
        Tue, 16 May 2023 10:07:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj109v2pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 10:07:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mP/URb6S2g7fuDaM9ZMy/wnJl0+nGd4wqwGqPDeRWxDsRBg3S0iSwYssFZmQFO+JsPxbDBjXLhIjD3OKFLJwcGnStVjY1oOjLso5gIZQQ6Xdjkrc44bC2w34z83vno61jzNgq6du+bSCA05s2bgUf8qLE9Zd5xs55F3H+P3jwjSTD7X39z3r4YpOBAXZVFGHVV+KQ+n5sH4u3GLVk8MYdGCLo+RvlwiYZ17mXz3k2z/qaSnz3DOCEqoLXao5NbkuIwgATnNxC/3ijwf1kaFOd24VEc2G/ur54/dHH7QbOycvWGXlB0a+/NPIH2GVzZwkMZKb88kPFsMKPJwftQ0dLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw3PhTmEdrwZcmVL1nd7UG8XgGpqNjCh0IMM/zrPtaM=;
 b=ofF0jSqckoC4rTmejgjSDmABH2fowzEt5HF91OFiD8mS4QPsjw/2uc2sk+tgsjT4L52vvOkNdakSvgqLRXhKGTq5YGBGWj6fX8ljK9Hig3nzgVMc6xxtwq/HHq5LDf2e93lwC7C6ToH+deSLELG0X8lShxG2/vHnNDy0mRnW9fao7+m4PRqR8uCsJ4VAkgv6Cw9GPg2a22hTHtKd7NIYKjCXJO4XPff/Anp6cQmJdKFPwbWh8V1I5SONG3g0Caw/1KHbMXceyXfdvzN2bNk82InBjsI+jh9Y0V7Z4tI9Kd7NlOk5upBkj5pygTVgrha3jO3F6qTgyj9zTcxxrjvrTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw3PhTmEdrwZcmVL1nd7UG8XgGpqNjCh0IMM/zrPtaM=;
 b=Ai9HxEv4DqdEMnNHdDNv/IMjc+EaI1Tbu6Ki7uONLDnAwbIynVKTUSE8TMRC4HYxZ0PzlXMpjNwEnn5ESwfkWmsoY9OYk1As7MFSPXERGyQXjCwiwgymS9ZX7aNx6Wk6NfsK61bszbO0mbPiWJD/qfbuKMwtdy5U1iuwh6KHYiY=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SN7PR10MB7101.namprd10.prod.outlook.com (2603:10b6:806:34a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.27; Tue, 16 May
 2023 10:07:14 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 10:07:14 +0000
Message-ID: <7af16e19-0a1e-126d-a2df-f96bbeac9b25@oracle.com>
Date:   Tue, 16 May 2023 15:37:00 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 4.14 000/116] 4.14.315-rc1 review
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
References: <20230515161658.228491273@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SN7PR10MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1cc76c-01f9-456a-840e-08db55f5520e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bz4HQDb7LSZMtP8BwaA52rbai07fOPdmqtTlA09jW2icL6XXEfCw4L6V4BWvOwZ0L2rEMVF7oBUpsrkPD8AARnsAqAxZh+V+F1T3SPp8W0cWGp9nRM7PkJ7qIHtCpH48QLb0rN+VZFc/qN1ge3rwpBvM7GFcwvDoR5gT9VrpEwhr7s+URKg37w3H6pgkaH1b+qz9o+xilg0qln18DBAL9Hgw9tPlYc8jrlJdkUy9dgZSWpIQOJPeQUp3rXm6QXAjCyvsQ2QgBpkBntLahWGKtlWvfF/PGBXEzQPkjpRV+Rwcacu5TUpaV4D18b5FrPNrqiMlUiyN1UKEraM6sFNkIH1KvOe53PCuWCpaiew5Ry7bUkbAm0Eetfn2GvSETXURdMG3+1sVISL5jS1Jn2Ip+jaJCgd5fINbh5s913YXaYoCw+7YYWhtxyPp8enJWzwxKpBRVnAb4m2lrFeYoJea7SKztpUpvnbX34HMQS2OS3YTXN6fO33cLtCh/vBoXQV2j9JhYVto5OdWOwpe7RvrtYapZYxR6XJu/wBLh0yXgYdrChiA1x9XMb4yBo6eICt7bcJMHtXF3hcQYYnblRMs6Eu2XIdCEcGP6pWr2d7FvkaoLTUVNpllwE5lWJ554/t4x+qc2CuwZ/+V+aULIhwnUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(6486002)(41300700001)(4326008)(316002)(6666004)(8936002)(8676002)(54906003)(7416002)(31686004)(478600001)(5660300002)(66946007)(966005)(66556008)(66476007)(107886003)(26005)(53546011)(6506007)(6512007)(2906002)(4744005)(186003)(2616005)(38100700002)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R282VldvbFRMYTQwYWRoRHp3SlloK0gyMk5Ia3ZqeXdtaE8yTjJ0WUppMkMx?=
 =?utf-8?B?YlM4VE1RNkc0NEk3OTk0UEpTeGtUbUpQOTI3MTZZdGVmKzZzTU14N255Ymsy?=
 =?utf-8?B?elVRVVFMUVE0Z09odkJabjhIWWFXcGtlRUFhaDdnU0UrTzdQNEJaVlFqV2hT?=
 =?utf-8?B?dTYybHdCTlg1S2toUmtvQmlNT2psSER2RFk4b3ZRdnlnaTBKazdDQnArOXNX?=
 =?utf-8?B?ZEFHNkJ6aXYwK3c2a25vSDdtV3NUa2NYakRwbUVwQ3RVS0hsTjF1ZHIxZVNL?=
 =?utf-8?B?NTI2TWdpVUpXQTFaSmgvdUhJemNOeDFXYWhKYlF6b0p3SS84bXFGKyt4K0ZL?=
 =?utf-8?B?SjQ1SkVWc3UxNDVUUFdpbXUwUklIYi9KWjFYWDZSeUJuODEyRXZRbXl2NlBv?=
 =?utf-8?B?WDY2ODBvL01oNWtndXQ4WExOcnBxWktadmZhWEQvVndyaVltbzBQQzFJRTZ6?=
 =?utf-8?B?RmpsZ1hQeUxkZFlVeWN0WTIzSnNRV2dRS21iS0oyMU5PSDg4TkZpdjF5UHZM?=
 =?utf-8?B?K09pZ1FqbzJOeGQzY2dZZ0lEZDl6THVNRS9nOXBxMlR4WUZmUzFyU2RPK0dB?=
 =?utf-8?B?Qng2VkpiVlF3ck40OGJ4S0xRRkRNRmVSYm5TMzkwQU9BWjF2RGlNbDJCMUNJ?=
 =?utf-8?B?dXhqN2p4K0s1RHdFUENKczY1alRIOEJvK2c2UWYzSlgwSEROMnYySXR5SzVz?=
 =?utf-8?B?SUszckljSVNUMFZYTlR5TkZITWRpbGZiZUNOU05UZ3Fpd08wS0ZGbllMbk5u?=
 =?utf-8?B?VVVzOVlpSzluTTV0VVBRamJIQVUvSGdxemVIM3AxbnNUc3o1cjhJTXZBQjAr?=
 =?utf-8?B?VHJ1VHo4Rm1NdDIvOVA4azVIQ0YzVGJISTBmT0lDU1drOUZnUEFHakFsWkVZ?=
 =?utf-8?B?eXRiZEcyWTZvendwdzdKSy95Sm1OQVgwZzZ2akxydVFzSkplTHZrVzBYMGg5?=
 =?utf-8?B?aTR3V0VCWkgyY1ZxWTZpL1ZmaDNqOFJOK3BQYVJnTjE0N1kxT3RwYVRZV3dJ?=
 =?utf-8?B?WVVLMkhHdEluSk9uYlprWWVJWWRGNXoyVVBnSytacnAxbWI0ZkwxYXNubkJP?=
 =?utf-8?B?ZVc2RG10NWlvS1hDN3ZEbjNzWWo4ajZhTFl4V2V2dmZSa21tWEtvUzFHL05w?=
 =?utf-8?B?MFAwdnBqOS9TcmMrazRwTFovb1hNd2xENU5tMXlBY2N6TXppcWtPc2RSM2Mv?=
 =?utf-8?B?Zk1OMjVjc3ZMUm5Ud1dvSFZjeE9xM2tGN09MTzJzMHFCVWNmNWxWNFZ1b29Q?=
 =?utf-8?B?TlBDWlNMUWR2dVJ5ZXhwQUZUeU82a09uU0Y0M0lkQWloSk41WExXeGlUeEdV?=
 =?utf-8?B?TVpUalNpZ1kyVlBMS211Yk83ZmkydlgyeTZaMkJDMXFjL1FiNC9xandxcXdy?=
 =?utf-8?B?OTZ3SVEwN0Z5WWM0T0hUNmF0bE5nMzkxbndPOENlVWRsUzYxbkdvUzB2Wlh6?=
 =?utf-8?B?Yk9TM0luSUVrV213OWkwRWtYLzRKSUpDMEFKdHFZNjV3bmE4WDRVWU5TNTUx?=
 =?utf-8?B?UW90cVE4b2tDTHFoQW54UmxlTTNOTWxrcTBaa1oxTHJtZ3czSmNCY1ZNN1NV?=
 =?utf-8?B?bVUxb0NyMjZrRXZ5VjFKUUJWblhXNkhOdHp6Nld5VmRLaVhZSHZYeDJJWkRZ?=
 =?utf-8?B?VEl2VXZxTHM1SEpDR3ZoWXZjRmNRWkVRVStVVXVCVkp2VzRpcWZISFlmekJ3?=
 =?utf-8?B?SzdpbC9kSUJZVGN1MW1nZXBzS3dVV2s0NVJiK29VOGJYWWptWm9pQkFBSkZC?=
 =?utf-8?B?TVdsalVqelJYMi85dXpwV3pXVVRub0t2Z0xUSWNRY3RDVEhZdTBhcmFjT1hV?=
 =?utf-8?B?TW42K2RVeUgzK0d5a1Z4aG1jb1lRenNvekRFUEVBR3dnWjRBOUdXaWFlMmQx?=
 =?utf-8?B?Z0RZZ016MGxLSVg1c3QwMUozWTJpbXJxRzFaTnlzOVhHc09CTWVRS0pJQk1C?=
 =?utf-8?B?ZzdtZEFwU0VnYUhuYVRyN0VsN3hESkhSSUp0ZUxrZDdGVktGWUlwbDF4T2lB?=
 =?utf-8?B?THJwV1lnU3UvUzE5dW5BSm81MXB1eFR2ZHRYSXZMK2RZaXFCcDcyRW1pSlN6?=
 =?utf-8?B?WGJBTk52ZHVXVlhldVBsaDRWN09DWThhalkyTUt6ZVZCT2VQZGpsOVhBcWo2?=
 =?utf-8?B?endVR0gvblJ0RTF1NERVa0xOa1FpQTc2VUhGdU5lb0xSdVJkcnZ2QjFhcXFj?=
 =?utf-8?Q?QmGg7So4G/zRWCVQEcCnxr0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V2IwN1pCdzZYSGU4Q0V4UEpDK3ZTdmowOVhwUG9WdEdYODcvRkw5VHl0dUwy?=
 =?utf-8?B?aVovcDNyNFlUdmJzODlVRFY4aFhDQmdOUkNlQUVwOElsUFpDTnJ1QkZVRFp6?=
 =?utf-8?B?N1VHVXRrR0wzZDBia1FZaFJnTS9KNmFFbXhubTBSbjFwN0FYM0F2U1BlblVU?=
 =?utf-8?B?U2VFdHkwV20vTWtFSXNDVEZxUG80SGVDQUR2VkYxOWowUjFyeHg3OXpZNkxJ?=
 =?utf-8?B?V0cxN2g5eVNPZndOclJqekdyeWpFaSs3N3dLenIrenQ4STZ2VDJnK2NNR2Qx?=
 =?utf-8?B?bStKZllOc3hWWUFVVjd1cmVwcWlMaXBwVzRpcXBsd3lKbStNakNEODlVbnV2?=
 =?utf-8?B?NzRSbkM0d2pZeXo1bldwM2hIclMwRHpvNFdaM0NHc3dxYzF1dEJSbEFFTHhJ?=
 =?utf-8?B?UmRXVWhTdVhNMVMvUGh3d25QUWdUOG1WRm9JZ29tYWZaOFJlUE9WS0xPMDBa?=
 =?utf-8?B?TkY5b1hWaDNuMVlzVVBoci9mK1YrWUVxMnVBTFlEd0c0VVVRdXQyWEx1akRs?=
 =?utf-8?B?cmFRaFBKWi9SdUsyS2thMTZySjczU2Nqd0JEei9UUkJ0Z0VxM1U3b3BnWTU3?=
 =?utf-8?B?b3d6Z2VUWkd0MkMwNUFGam9QbWJpd3lPMTdvRjZNc1FiQmUvTG40ZWl2aEcy?=
 =?utf-8?B?NjVET0E0MVF1RVoyV1k4VUxxSVZTU1hMVFVOalBweDdkN21oSVhOdzdxTXpu?=
 =?utf-8?B?bm11RzNTakhtNXRsbUMrdjJ5czlaMTNMK2ZaeEh3QUVQMjF4TzB0SW5kS3lS?=
 =?utf-8?B?WVhpTTJ0Rlk1UjlXeUpjVFI0dDd0M0JUY0hRTFdiT1Z1QWNsTHN5WDlrNHAr?=
 =?utf-8?B?YjZ3RTNCb09POEFDblNHZGh3UDZSMFZ6bXZHdFZTb2hkWGZhdVplYkplYW9k?=
 =?utf-8?B?TDg4TGRUS3F2dGkrYnhaSTZWUVhORmlreEhuVUkyRlJXMzh2NTVYazd4aFBQ?=
 =?utf-8?B?YU5uN1Vad05wT1N3elR6ZG91L2VXNVZudUxzN1NoQVZPclhnOW4rbHB0NjdY?=
 =?utf-8?B?N0NpSHc2aXQxTU5IQ3EvNXdHRThGSEh0UWhFeHRIV25Fa0pMd1Mzd0JnWUhJ?=
 =?utf-8?B?dU41UVJPMnJSYnRlSzdlMXJoaWg5MlZDb3FQZmkzc2Y2akFGMS81VlJhQkR1?=
 =?utf-8?B?bzNIeWZNT01UVnR6S29WR0FpV1dmbG5mWjgvQWhEZVdCVlAxejlkVjJqRDhl?=
 =?utf-8?B?NndzQ2tnbHh3NGphdE0xa2tGTDRGWTRiQU52VWZrb3Vub2tRc1ZiV2Rqd0lx?=
 =?utf-8?B?ZHJHSzcyeVRyS1NlS2liNVlwYUliK2g0c3ZhV0tjbVdrWXZkTEtWSUdMZkdS?=
 =?utf-8?B?ZUUwc2NRWUZ2bTJKVThKSXU3N2E3TXlDeXR0WWRpdjBPNTVwN05RRVhuUXd6?=
 =?utf-8?B?Z0EzZC9ybFhXZUlqT21sSk5rZ3JUemRPL25JaU5yUHBPY3BzSSt4aTNjUVpY?=
 =?utf-8?B?aHdPT3poNU05QnJUa2M0aFlHODBHUzV2SEI5ekRVOWJFUTVEWm5IMDRaSUJo?=
 =?utf-8?B?RVE3VHBVSGxZeGx2c3RrNDEyakgxOFVJOXp3akx2dE4zOUovR25DR2F0WTV2?=
 =?utf-8?Q?lILrR5blZWlAOv41rpkmmVqBRmRLQ49p36Vdcbr9t4Y41G?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1cc76c-01f9-456a-840e-08db55f5520e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:07:13.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6tR0OkDAZ99KPXcEgVt2iLwvSjlt1xNToogjvEzH7Mn+lWcMTFZw9dqH434Oj67XjDFxuN2RQtnTBxJDJOxkgdEzXImAVFv7JiNBEJv52uUClvd8CZR/JM9BfgkjSbz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=998 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160085
X-Proofpoint-GUID: qd-Jy1EzCwV3qZIOpdNlwOltMn7aIIIq
X-Proofpoint-ORIG-GUID: qd-Jy1EzCwV3qZIOpdNlwOltMn7aIIIq
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 15/05/23 9:54 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.315 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

No problems seen on aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.315-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
