Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCB0681A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbjA3TWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbjA3TWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:22:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307683B0F8;
        Mon, 30 Jan 2023 11:22:00 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UHXd5r023198;
        Mon, 30 Jan 2023 19:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZWbAxiHVTQkMVphqMNqYk/5Y97Yx6BpOBcg/4wm1zzA=;
 b=hxEVC39ah0Zh50wQLHH8ex9vwUbhymJm30nxHkW4jLgasxjZqp+oIrnFaqQG1fXSFu57
 SX2BsANg8O/KtXzPCS2BbwfPykb/aw6HQYGO/krEerO/8Iucj9G9c6uJV+0Q058KiR6e
 qun+88t+tx/AsyijSvzMR5CPislUApk6oWTdgCA9WJ+WB+puk38PrqYuyIJB47EQpYpX
 NU0Y1UZLswxXC8EuG0OCNzPz2YzP5x4nt20/ZvFcUKtJtMMkskWrf3D86l58hUE2jyKU
 TKCt0/UxTZD65qERcMfJuY4GeKhoauUzy284k/5NbMhkv+P5o4OXZ6yLlLinTB5R4e8e uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvn9us5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 19:21:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30UIC5lm027600;
        Mon, 30 Jan 2023 19:21:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5bu9xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 19:21:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kzgol+1x8q4wRAs5Nbx+1x/8m2MUNdiJN4dewaepDsKSldb1ko8RegIC58+6eJMzW40G5w8syolRGQbMn8Y9WsZMTmrBjgYqrjmQ/t4pwgkEkz3hIk6AcxH7DPbMC12Wo0q2k9GAC1117JA2A4HGXfQ3d07W7KdtBvzgJVhliIQkeqKxiXd4whe7o2tYbQcCfjq/Ge9efp1kXJ95qU479aEgQWFCZTKScUhJxt16pBa/vK4rYgjmVSrs6nZGSvaiZ5tfMXrKjeFMrQsJc1XfQCQlM2/bh5B43vKPNJEYTCuTDbpujyHGdt9rNZeUiJEA9/QrXq/mlzoHFMV89+oLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWbAxiHVTQkMVphqMNqYk/5Y97Yx6BpOBcg/4wm1zzA=;
 b=X3DKR8td3kUsDeYJOZbHr0O5WcB9Yx9lKZCCJr/R1J0nS+xy5jSDtOJpyKZD1I9D/D56zjFR7kAw28EYa0nIXfnRdE7N/ZbWh9KW2pv23r+xZ5QUPs+wuJC0iGy4U5V9OER10J3XD3bhSNKMC78zeBFcTtiUKNZPdQzVff4/mNhlSsqB+jUd7r9pVRIaoG0lzIG1xbO8WnU5X6LKS3USZQkltcTypiiL7TeCOGBNcwHo80VOrZoguBe0AOY9zZ1WPD3dtatmOk1KNPUPMoVA/nnG81JH2lPEPdNaE6uLaRw8cBpLpPxHnAQ7U0BcRcdJiC/+u/0kFsAkJnTtBPU2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWbAxiHVTQkMVphqMNqYk/5Y97Yx6BpOBcg/4wm1zzA=;
 b=vZ+SU98cXT/+eZ6kOBVREmHQNwAYaStC3KCGYYwzFVCpld41KoAWAI6XnOeoytrtqhSskNPg+OVL557suOa4XcL5loN8PtmmnlCYeO3a91mcjofmquau8YcOXSoF0tyC/vWnQxBrg0ZP9F5f5+5oCpEk7tchj+R3+vlXjU4oTV8=
Received: from PH0PR10MB4581.namprd10.prod.outlook.com (2603:10b6:510:42::16)
 by SJ0PR10MB5584.namprd10.prod.outlook.com (2603:10b6:a03:3d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.10; Mon, 30 Jan
 2023 19:21:51 +0000
Received: from PH0PR10MB4581.namprd10.prod.outlook.com
 ([fe80::54a1:30f9:c42e:d74f]) by PH0PR10MB4581.namprd10.prod.outlook.com
 ([fe80::54a1:30f9:c42e:d74f%7]) with mapi id 15.20.6064.020; Mon, 30 Jan 2023
 19:21:50 +0000
Message-ID: <4bd7788a-bf6f-40c7-4439-2a300045c5e3@oracle.com>
Date:   Tue, 31 Jan 2023 00:51:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] scsi: snic: Use sysfs_emit in show function callback
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y9fvsSJrflcIHm7e@ubun2204.myguest.virtualbox.org>
From:   ALOK TIWARI <alok.a.tiwari@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Y9fvsSJrflcIHm7e@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PH0PR10MB4581.namprd10.prod.outlook.com (2603:10b6:510:42::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4581:EE_|SJ0PR10MB5584:EE_
X-MS-Office365-Filtering-Correlation-Id: 1757e3ae-6b5c-419c-93e9-08db02f73cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kszYVziDRJzfbDBGavl35VqVx1qVl9IRjNK1rc0S03WZuxqnX5wZSLLmn6wjBeQDaFadCe1ronofYfrGDu/wZsB7heFrxjuJORE05S94s5tOCJKPKULMrXtmIeft6YRtMTrU9tx3cyci8r46b9YyLfS1vuF0kMaB8KVF8Y+RnKdjIY4XiPCRhJ/3FrprDAOomahChCtU3o45q+ZeccUjo6KuZKWAy76F/kgVMIiwr4Ypjy3s/fET9RQ/qCBiIGRO2wyQUVFYpt0TYH1G57OVBYbesIpvTc9DA3JEIsYgmDpXENzO+kW9ubtvzJHml/7hRJyQNfUed3gj+Os9VLTCGxUwaneDl4DkpvxzjYU2Ky3nl/uF7e4ZcIS0EsW0SUalTpbz60HbPHNgz/AkgwXUfY7HS1Lk2UURldGB0aCD18SMw1tl+yga4srwqK44QjXejx8J3Ok5JcxIZr6dTwtntRc16I2D2LKQpje9gXszPoRTXRFE+I8m1VvxXZjD/ulsJB4yTMu6pnbuhP/FcZnpjEWgF9O/e8uWVznMewfpFuTwoEvFfSxwcGTVpT2T8TYDrq6aiseD3FzAP4+rG+n8Q3H19BqdHzND0+hgR2tg5v4Z4TWa3gLE2jVYDZo/lWlTZOsVGogRsnuZ0gft1j0ABCt49c7BQ0JpjpZPB4DPdD8wBsc905Le9g1vTo+RNpfJPFrv0TkROTzm7F/sQ5PEmG3p1+vgX/T2Z+Hn+q2vCew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4581.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199018)(5660300002)(41300700001)(2906002)(66946007)(8676002)(54906003)(66556008)(110136005)(316002)(66476007)(4326008)(36916002)(6486002)(478600001)(6506007)(83380400001)(6666004)(26005)(186003)(6512007)(53546011)(8936002)(31686004)(86362001)(38100700002)(31696002)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eS9XckFRNllVQ0tCTTMrdjFrODViREVtaHdEZVkvelF6MDM5N0lKSUw1Y01K?=
 =?utf-8?B?STdaZThnUDZCcW05U1FVbk1jdjg0OWFUeENvM2VFVWNoQUJWT1JERXR5Y1pB?=
 =?utf-8?B?UFpMRWJzdVNrR0J3dXJQRTg2QThEUFRqNldIZUQwN0VYVlZZaFdaNlJILzZ3?=
 =?utf-8?B?ZjNiQkFKZ3RKejNEY1c5VU5kczJsT3l4OEx6TVR2ZktvKy9TZzFQM2RoMjZi?=
 =?utf-8?B?UEIxSGNPMHVZcWljemp6US93VGRQTEdqZ0VMYWpjcjBkclJIYjkzTjNNSnRO?=
 =?utf-8?B?bVhPbVlOdlEwaFZsczRnWjBJOEZzSm5uZEJvTmhndDF5QlVONlVsNHRDQ1o5?=
 =?utf-8?B?SEhIekFONXhoeDkrWHFxMitTU2pKaTc5VjFYWk9MR0V3cDYwOTE0em1ZVjZB?=
 =?utf-8?B?QnZsV1JxRmhQQ2pBQ3h6SW5mc1Jva0NseHJHbFAwL29DQ3NuRmdWem9JS01q?=
 =?utf-8?B?YXZFdDBPQ1cvYURac1F4NmdhczBKdTNwQXhaOG9NYnpVYnFaZ1VUUTNHbXRv?=
 =?utf-8?B?R1ZnM0NYeEkvNXFTZmZMZ2JudlZZT1Q1dmtaUkY3RzBJT1gyNURVeFZCS09R?=
 =?utf-8?B?U0RhSTZRUWF6S2cvb1JnM2RsWXdNMmFUUkE5S2V4cUJlNlhCZ09WSUhpaG9z?=
 =?utf-8?B?aUxWeUM1b1QwVGM0OWFOU3JkcW5MbGlram1YbjM4SmVPYm9pMVlmQmpDNzVY?=
 =?utf-8?B?SHBlU0ZUM3pjY3hQV2FEY3dtYTFidGVuV0RHN05XMkNaMnpLRkRKakVobXhH?=
 =?utf-8?B?bzF5cm1iRnQ5U3dYby9wZjdVSGphaWhDMXZQYUFhN3RUUmx2dkFSREZwTWFj?=
 =?utf-8?B?dXh6NTRqdENtRnRTNU1EM1BiUkdBd3N4UkVnMk5FcWN5bVlnOFNhTUU1VFVZ?=
 =?utf-8?B?TnYzMDYzeXorQ1crdWs4cEsyT3NWR3FoVk15WG5Xc2RZVXBrcDlEL1pmOEli?=
 =?utf-8?B?UFA4MnIxeHNXN3dHYUlaK29uZ0YrZzBoUWw5UHZPUmJnOFJ1UVo4V0k1U2RW?=
 =?utf-8?B?L3hhWXFMYVpPTXpoSWxyWHZtM2R6UVphSlc0Qk9TN3UxcktYUVlhVGs4d1Ey?=
 =?utf-8?B?ZGptUFA5cjNDcTdka3hPVUt6QTFRVlZlYm5ERUV5djBQQmUwK05qQm41RHBE?=
 =?utf-8?B?SkRWTFJPWTZaTDZuVzhuMGlZdjFIV0EvY2xvbnhaVXEyQjNoa0c3WHVqT0N0?=
 =?utf-8?B?SXpTRDlDTG14cFd5L3JyVWNXRUh4TzhQR0liZjluT0ZEVGxKRm9KcGFoUEZ1?=
 =?utf-8?B?NmM3WEdpdGhDcmNIY1RxRDAwbXBwZWZ6YjBqUmJHdlZmUU16Yjk3eW05RGFR?=
 =?utf-8?B?c2o4K3ZzNGo5NlZNM0ltTG9vZ0V2RXFxcWxrVkZpdUJ5TkhDVzFzWlVNTm1a?=
 =?utf-8?B?YVk5alk2Rml4SVJGUVY5Vm5pTmsweXNIUmR0bkhDTy83OEQ5Tkh6NlUvM3pC?=
 =?utf-8?B?eWptckNNTURjaEQ5RXRjWHJvVllHR0hkTjRTSVUxN0VNbW8xVmhTYnJCaXJL?=
 =?utf-8?B?Rloyd0x6RHMzbDlrNWhUUVZmc2NRTWFmNXJnS05taC9TUVdiYytPcEpFbnVy?=
 =?utf-8?B?WDkzNnZWalNnZlJaMDMyTW03N2VKSXBJWTVyWHRCNWgzb1hUVU1TZ0ZSbk9q?=
 =?utf-8?B?ajNoeXNmTTYzMWNhVFE4L2t2S011bm51VWVOS1poaXRDaUdJZlZheCtlYXd5?=
 =?utf-8?B?WXUyWXhYU2thSi8rQ2NhUEpUVDlVRmhocUtWN2tmakJhQnI4SHcvTGRCY25k?=
 =?utf-8?B?N21OL1ZDakhpK0xmZkxzY2Jrb1pETGEvSi9vRlNoeTZoU2hVV1hQMFZHWkhQ?=
 =?utf-8?B?Nkx4dDMxcExuQm5GQVd6VDFhR1ZST0F0aDZXRmNNaEFTZWx3TnZrU3JGelJU?=
 =?utf-8?B?b0xhT0VKRHVsM254WTRkdHI3ZTd0RG1aV0Y3cW5YY0VncllrdTA0Y2IyMWpR?=
 =?utf-8?B?L1hGN2RvenM5dWxtMGFIUnF1Ynp1YTk4em9HbzRmamFXOXVVaUk0OGt1ZS9w?=
 =?utf-8?B?emRFZ3VDaDBnL2tXWmo4eS9UNGhLUVF2QW03RzlaMTh3anJjc1lldjNMLzZ4?=
 =?utf-8?B?ZzYwZHkvQmRCR2VQRWx4RzVvRDFsSEpSTGRzUXZHUW40L0xNY2lmUjRnN0Fn?=
 =?utf-8?B?NVZhaVJvczlNU2ZPL3liKzFNQUs4SDNyTmd4czF4d0RkV2ZHY3d4YjdmWnBK?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Q1ByUy95ak53M2NmU1p5RGF6eDhnRWhhajMyTUhCLy83U3EyR1NVdTFTYVdq?=
 =?utf-8?B?T2ovNHI2ZDEyTGNsNTA0TDdyU0pzS3RmTnhjU0tOemNjWVkyZVB1d3lwOURT?=
 =?utf-8?B?OHpLOVJCVlVhdTJ6dWhKZGRQekZleVZiVVpvMk5CUjdjbHRQWm5CZ2xQamJ5?=
 =?utf-8?B?eEV6RjZzOHNGeWNnblRtOGpldkdDNkFGK2FWYlpwMXI5MGZhMFNoWXhINmIv?=
 =?utf-8?B?OW83SEpNWkUya3NxUnliY29nS3BLaEU4TlVaNzRCT09aamtrcXNyL3FHVmt5?=
 =?utf-8?B?TFJpM0o1NjhmclBqZ1o0SzhuNzZhbCtPcFdYT0Ftd0xiczIyWXBHamdMYkIv?=
 =?utf-8?B?bmt0aHVPWXQ3bXR0K1Fja1V4SVRBWm1XelhiVk4xVFlpWHFERHFmZkFCZUt1?=
 =?utf-8?B?MmJOSCtnMUdGR0pWOFZkcTYzNXczamJ6clc0bTB0THVnbmxleXo3UWIyUjdz?=
 =?utf-8?B?K0VMUjVYOGZITCtnNWppMC9XQ2p5Zy9xZmd6dTZ4VHFoMzc4ZTF1REd4WWpt?=
 =?utf-8?B?RHN3VDNCZWRDclNMdnpVYVlQSEI5UDRuQVJ6dXZVcmc4dCtJUjNndEI2cUNl?=
 =?utf-8?B?MUxoTlFoQy9aejMyempZcjBkTE0wVStBK0pEeW5iQUdxdEYwSGN3ZEU0clBV?=
 =?utf-8?B?MzRHOTB5ZUgxb2ZPNi95Q1ZGc3IwUHdnaC9LTFNhancwd1IyUFhXSklObGZY?=
 =?utf-8?B?NVBLdXFyYktqN0UyalgyNmNTdGM4Y0VVdzQxUFhsQ0QxU202S3ZjWG1Gb1dq?=
 =?utf-8?B?WkcxL1N3VkFoUE4wakswalV0N2xiMFQ4bjE1NXlsUGhwWktsTEZ3dGN2VGtK?=
 =?utf-8?B?UzVvRGVvZGV3QW5McGV0R0JKckY5V1BIMU1FWDlkWTBVZHNrQkJaNEc3b0lF?=
 =?utf-8?B?RDJmMGtQVzk1Z0F6UHRmeDduSlJDelhqalhLV3NWajh5NmFNSEcrOUQ3VW54?=
 =?utf-8?B?aE1VTHFVQkQ5T0kxcUZXbjJVUVk0N01qNThORVQwSHJIOWY5a2dMUjlLNk56?=
 =?utf-8?B?dzA3WnRTeXNvSDVoVEtBRlBBWXZ6Tm5NbzNLSFV3SFNzSkpDNGFXTnlVTkFO?=
 =?utf-8?B?OUh4ZGNSaEo5aTVkYXQxV0dqTkJaL2lweWJZeUVYNHpnSWlFOWdVcHhWWmNt?=
 =?utf-8?B?QkN0akkwZjVDVmlpYWNsQVNldmNSd2pia0ZQVjRPbFVMM050dFlYZXZZbWw2?=
 =?utf-8?B?TEhhMVZNaFpTSEJBUklQeXNOUmpIcC9NVHZDb1pzTFpoRU9raUp0cVpzb3FY?=
 =?utf-8?Q?djusxb3NCtd4Lwc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1757e3ae-6b5c-419c-93e9-08db02f73cdc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4581.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 19:21:50.7760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUBygVPYFwsYRyVNmsT9EjHHaBCVh65ipol/bZ5u51Xtw/GUoRExfLALuW1SXyijfEllkNcBuawLAHYVNPBm63Xyz53jP274vErP/aDlY04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300182
X-Proofpoint-GUID: 2uR7xkdntdsUWOtDxY4x2Izofqp4-6eA
X-Proofpoint-ORIG-GUID: 2uR7xkdntdsUWOtDxY4x2Izofqp4-6eA
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

code changes look good.

commit message can be more simpler like  "show() should only use 
sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space."

and in place of kobject attributes , device attribute is more relevant here.

Thanks,
Alok

On 1/30/2023 9:56 PM, Deepak R Varma wrote:
> According to Documentation/filesystems/sysfs.rst, the show() callback
> function of kobject attributes should strictly use sysfs_emit() instead
> of sprintf() family functions.
> Issue identified using the device_attr_show.cocci Coccinelle script.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>   drivers/scsi/snic/snic_attrs.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/snic/snic_attrs.c b/drivers/scsi/snic/snic_attrs.c
> index 3ddbdbc3ded1..56c46ea06e60 100644
> --- a/drivers/scsi/snic/snic_attrs.c
> +++ b/drivers/scsi/snic/snic_attrs.c
> @@ -13,7 +13,7 @@ snic_show_sym_name(struct device *dev,
>   {
>   	struct snic *snic = shost_priv(class_to_shost(dev));
>   
> -	return snprintf(buf, PAGE_SIZE, "%s\n", snic->name);
> +	return sysfs_emit(buf, "%s\n", snic->name);
>   }
>   
>   static ssize_t
> @@ -23,8 +23,7 @@ snic_show_state(struct device *dev,
>   {
>   	struct snic *snic = shost_priv(class_to_shost(dev));
>   
> -	return snprintf(buf, PAGE_SIZE, "%s\n",
> -			snic_state_str[snic_get_state(snic)]);
> +	return sysfs_emit(buf, "%s\n", snic_state_str[snic_get_state(snic)]);
>   }
>   
>   static ssize_t
> @@ -32,7 +31,7 @@ snic_show_drv_version(struct device *dev,
>   		      struct device_attribute *attr,
>   		      char *buf)
>   {
> -	return snprintf(buf, PAGE_SIZE, "%s\n", SNIC_DRV_VERSION);
> +	return sysfs_emit(buf, "%s\n", SNIC_DRV_VERSION);
>   }
>   
>   static ssize_t
> @@ -45,8 +44,7 @@ snic_show_link_state(struct device *dev,
>   	if (snic->config.xpt_type == SNIC_DAS)
>   		snic->link_status = svnic_dev_link_status(snic->vdev);
>   
> -	return snprintf(buf, PAGE_SIZE, "%s\n",
> -			(snic->link_status) ? "Link Up" : "Link Down");
> +	return sysfs_emit(buf, "%s\n", (snic->link_status) ? "Link Up" : "Link Down");
>   }
>   
>   static DEVICE_ATTR(snic_sym_name, S_IRUGO, snic_show_sym_name, NULL);
