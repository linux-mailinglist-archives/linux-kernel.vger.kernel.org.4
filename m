Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BCC705452
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjEPQrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjEPQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:47:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9FC6A57;
        Tue, 16 May 2023 09:47:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GG4BTE010949;
        Tue, 16 May 2023 16:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SY4OnLXjREU64NZKMME87FpqbViYP1EqD3HB/r2dsMg=;
 b=jWJVHlj7G8ZfdgfPI3WGoug6gP/pWQMsqeeb+jBMF5/SPw80Um3EAMoH8VssFtmZ2e9Y
 F9CCCumWL30BcCn+YC9l6xAZzKlu1CUsfjElyL4ZYRWjO8R4FkSFigawntjPv+CM0QjR
 CYyBOHm/LIHASgELDGIPAsXjBmd8JnfqxZxO6VZD7tCzWaGO4aLoJv3s8p+xvt2Y6Z3f
 nJwTnK7PD3D4CdFX0+OAiC+Jk5EPpm0ts1HXuSLEbUQULdnbjPy1FvO0slpOYHOPaIp2
 0MMRVau9WT5Q+uxtRWR7nJMc8Kh/Qt9Iid4ml+zx229q23fGmhK4Rg0m/A/UG/Vqm6Ae Sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj25u3gbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 16:46:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GFLBub004244;
        Tue, 16 May 2023 16:46:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10akn8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 16:46:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtY1OfJIK1X0HlBBPHcgNwOAlWin1TEW42MpBhADZyIk2wnEr1OobmIilWiOVlNuzrqDM500JmSyKsAabI0iW2TPksPjGds/hrq1pJJeX4OBUosujf8+zL9CU85pNmnPeKpko4CLWZqiwmVLHyWLs5jF/25RGg/xZvBge8DGFyYTNFZ5MCM4F91Cu9O/JSu6p6F3BqRiIYu5z8emNJlrl0xRTMTXPRQzLOd0a3Zk790jBdiGgS28ehbg/O1PjNjixXjcXTri2ozfMKZ5G8LePH9vG4Zk+5AICMYjIYfv2EL48R8IlnRH7MX0ytSgOu5/JkT6RtLLZKWWENvDwE9RWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY4OnLXjREU64NZKMME87FpqbViYP1EqD3HB/r2dsMg=;
 b=D9VPcY0oaagchQztiQV9MxxOyfqgDgxlt0ge1c32kSN5zHYELP5pBY1MSeeyTVx4Y5PhlXA4fB6ZXkZMr2kGsEq2uTWcg35AGVS3tifNwhowTjUYtVcBNfMmBQ54BjfztCrd0kg/O8aO69GzrtNxqAMUcrMvlCGMoX24xlQsypV3a5gbc6fTM6Le81jv5teXHTi67CCO3BaUCfp/eJIs1K0FudW7II0nrVoKRnqCTQ58RcyX49RGlo6xtNJ1WZZx7b3fakOoIiNFUWtKRnt4QGNji8bmjRkNHK/et2pjJ6aF3tUZEwl2F+UlX3sxD4IM/XtIJR9pKiCRVSCTJGcFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY4OnLXjREU64NZKMME87FpqbViYP1EqD3HB/r2dsMg=;
 b=yJrEqJKI7Uq0+qexiI0AGocS2ic6fimSpWOeLfWce9gDEudUwhawG6LKtsALUtJtwJQJ8WYSI02Fb2Egtq/T0XiJeqoUKp0swEpoQyBEn6NbuaMDKaixamwa8h6Q/wPyHnyH8h2hrrlymgEhcMhABf2FqHQhWm485Df/CCnyBkk=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CY8PR10MB7146.namprd10.prod.outlook.com (2603:10b6:930:74::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 16:46:50 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 16:46:50 +0000
Message-ID: <761cdedc-ec81-99ca-a890-5058b0d2d372@oracle.com>
Date:   Tue, 16 May 2023 22:16:37 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 5.15 000/134] 5.15.112-rc1 review
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
References: <20230515161702.887638251@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0016.jpnprd01.prod.outlook.com (2603:1096:404::28)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CY8PR10MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ec79a7-eee3-4152-0810-08db562d2540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2aC9pGmsaxMKSutBzMpLU4xJlf2j1xQySfDyENQHMtkpjMTXiEiUu47URUvN8imanOpyzlFE2BYLosHFFz/FsBXj0ERvS4ll/ejYjwJ05QU6Cht97dGSn7fXsIVR/ho+848nheCaVL60Cvm5ugHD/O06FQTjeo8r+B9WJGst87OPcOlGa4sdEH+1Nvx4SfMxC6ZuyKn0Qh8c1yHo5ZD9IHe7vXHxxBk5XxofN5yH8TY2fkj0GesHtRQfEx5Q7oLGnk0luDNsLgCvKi1DqUnJognDpWFmZCmF6ZzM/yimHopYoiG8dw3Ej1oJ7SlFvSsq+Ro9bJQai6xIcrk+4z6t8vd+XkI2oHqbF9kkB0DmPru931oBMyj0HUKXZ7KhkyziIgtweOd6MhOwZiE2A4Ij8wG6zq7qqoMJWpcjurv2WytXqJ0Gecd98NyQMl7Xc8IwiACkR0YD1i4NzvdvVFmO81JgNQhlXZzxfv7rmKC1vMFhkpTNfjZpvUKaaMvn1vMHD7XUvg26L2hjjAotanIf5N+493kaIW32PdByuf8zm97piqibMZ3qkV4hhGmb+L6XgIIeu6ewnuvk4gmpfWy8CijL5PR3zAZmdcNaCPIE+7u+iqMpB6+NMfyE0AgaR/vuZu3PO2QziC/GxARFfM+9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(4326008)(36756003)(4744005)(2906002)(31686004)(7416002)(8676002)(5660300002)(86362001)(8936002)(41300700001)(66476007)(66556008)(316002)(66946007)(54906003)(478600001)(6486002)(6666004)(107886003)(26005)(31696002)(6506007)(6512007)(53546011)(2616005)(966005)(186003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDhDTmVodzE5NHhCNXZROEpDcVlvaVFveW95RFdlQWJlVG90UDVjeWNab2lk?=
 =?utf-8?B?SG13bHR6THhBY1h0ckZpTm9uYytHLzg0clg4cVRES0w4dkxwVUtkcVRsMno2?=
 =?utf-8?B?ejdMWkVLS0dVNi9LRnV1emxGa0ZDTkVwZUZsb3JVNDdtaG9JeG94Vkl0eGpP?=
 =?utf-8?B?KzJuS2dLZHdSU3lmZGRvbk12UjQ5UHZIRDg0THNMVVdudWVMWVhwSTBXZnlN?=
 =?utf-8?B?VjFXbHZPY1dxL0F4anlBQ1ZhTzlBMmowNGt6U1NQYUJveU90czJIU0ZVY0lk?=
 =?utf-8?B?cVdQZTEwbzZod00vQUlHczNtc0VWTDhkOFBuT21QMjJWSWh3MXRSWFRwM2dq?=
 =?utf-8?B?RDRYMy8zdFVzNk1sYWpCN2l2Ym1Zam56czNCT2pSNUxmYU12bFI4NkFhTGYv?=
 =?utf-8?B?UlBFczJkVFBnYjBHbURGWGxmWW9uVU9Eb3FXM1hVU1MyS2pJSDQ1RGNIL3lL?=
 =?utf-8?B?ZjdzQ3ltMlA2RldPdE4vSzFqRTdLenAxSWhPQkdnbHRYSkxPSTlHTnJxRXU4?=
 =?utf-8?B?ZlRRRnhBdTR3UkZZcUZQeUROYmdMY3l3S2V6eFBYMEpYQzh2a2xROFdMQkc2?=
 =?utf-8?B?dzRDQ295UzFCOG5MclE1bVk0ZTNZb1pNSzdFTW9vajllY3NkSUdERUNVS2ZD?=
 =?utf-8?B?clE5UmEwRWN3bDBZbjFxeU9vKzR6a0pHc3VzdmtaSzF5anFzRGVsS3AwV3Ex?=
 =?utf-8?B?NyttWEhYUm1uS055ZnFCZ2VzK01QUEJrUDc3RmE1SlRHNm95dzNCM0JiUVpt?=
 =?utf-8?B?Y0p3ZTNldjhRdjFwSDBMT2J3d0VNQWdJNXVkQTIzSDZHeDYyWXNOWXFoaTY5?=
 =?utf-8?B?eUpaSUpTbzdHeXJQOElwbUxvOTRsYWNvTzJTZ3ZuOEdGN3A2MGxUVDNGaVJM?=
 =?utf-8?B?aC8xdmkrem04WVFNNHUyQWhDZ0tFZWV2d2JRc0FzSmo0WkN6VkMxUDdaNytP?=
 =?utf-8?B?eUVBOWkvR01oVjJLejA1NithUmFFWmhUZk1aUDVkaHFTK1hOWWhqeHVqZ1Ay?=
 =?utf-8?B?YjVaRERFM2RIclVHN21sZ3FHVkwxY2VsK3h6N0hlTjl3RXJQZUJMdDlQYndx?=
 =?utf-8?B?WWNVcjZYTjhGbjJtdkpZWHI5MTYyRFFPbmxUejVFQkloMDVyM25WcGZOMmox?=
 =?utf-8?B?bEdMRjNKZ295WEw0cXNkYk1VUzZOeThFL1JFNVZiWDhIcWpGdmdaL3ArY1ZH?=
 =?utf-8?B?RXlNUk8xc2JWQ0N6Z3Q2Y2d0RzFMbnA5d1J2Uit1RXNOTkV0akZxWFJnWXNk?=
 =?utf-8?B?VHpjZnFwVHRqNVFYQ2Z3NzBVY2drRFpDQVpTTEprcEhtQjRkS1lISzF1SS9m?=
 =?utf-8?B?UHVvVEhWcTk1ak1JMjVkMU5IS01Vd0xWVlowV2ZiQUVnVEF4ZzkySnpLZnkz?=
 =?utf-8?B?TUQ3WVZuNVJnKzV1Zkc5Mmc5ZzF1VUxEK0FqZW9PUjNrYzM5SnkvbU9PSzk2?=
 =?utf-8?B?WkZRVWxPQWlyYVFCOWtKZ2gvb3FSVTVJZHdpWU51bHRHTnJxUW5HR1FJR2l6?=
 =?utf-8?B?dWN5b1VnZnorQi9DenFxUkVWK0RwZ3d1amFHNmVMVUpac0t6RklTN09SRmhC?=
 =?utf-8?B?YStFeXNHY0R2TStaZVN5dUJ0VkJmK08zWm12TWVQWmh1UFBVeEhzNFJNelZq?=
 =?utf-8?B?cWpjditnOUd1MCtKcFdJUHBtNzhFak8rQ0hBR216R1I3WmJpR0M0QlV2cGNQ?=
 =?utf-8?B?UkUwVXBIUk1KUXR6RlFRMlFuQVVLKzhUM212VkhraGo1akYvT0xkQnZDUk9D?=
 =?utf-8?B?TmdvUUEyN3R4T0JRYmx0ZVFzbnhFRFFxRG8yWkVDZWlhbkRtdU1RWExKZnRM?=
 =?utf-8?B?aFYxQ0FBaGVJbzAya3pCcVZrMlRyMDAvNTRuME16aWcvY3pkNTV3TjFGMW91?=
 =?utf-8?B?cTcrR0xnazV3R2QrR0dnQytSRk5QYmMwOVVIMGpYTjFrZVowKzJ4a00zRExp?=
 =?utf-8?B?RGJZempFVkZlSEFKV3pNMEpKRitYakJZVVd6dVkwbm94T1Nhc2tRdUZsL0Zw?=
 =?utf-8?B?NGt3WTF1Y241bWNxYjV6dHN6YUxtVlNpRHF6YlJHZkdTak82cUlDQWd3a1VU?=
 =?utf-8?B?OS9SaVNPWXE1Z3ZRdTU4bUYvSDBheDl5b09ib1R2R2dqTytZenJYWXFSWlBK?=
 =?utf-8?B?eERoeVF1bGk3NUVOdzhCNTk2MU00UFhlenNxMkx3UlBlLy9zRDVkam1DOE9h?=
 =?utf-8?Q?6Em6/U0iDL7Cy5M5e4iCckE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZXA4K2kwbG1jOTdaY1dYczVqdHBNSDhwek0wUC9NdDBWQ1p6ZVhWWGZLenRL?=
 =?utf-8?B?TWErVEwvVDlNZSs4QnFFSTVCNzdJa1h1YUxQc3YwUDFHeWc4QWYrUkVWMFp3?=
 =?utf-8?B?d3NEQ010eXkvUXFnUmYwbkZMQ2RkS1JSY3NoK1NuWFZwT2pPOWJOUDFxWnNz?=
 =?utf-8?B?Z0YyNVVNbkc1RngxaFRjNDYzVU9UdC9vQ3pFdS84MUd1V2dzUE9nQUE4RU9N?=
 =?utf-8?B?b2lSYXZHSlU4Y2Rzc21xV3JZZlBhTG1aNm1NV2grMkxmYnB0RlM1Vkl6c2h4?=
 =?utf-8?B?NTJxK1c2S2pmNmdUcVdJSDh3MmNXb2RsWHB3bnlGdWtCSXYzb29xUnhLT0c5?=
 =?utf-8?B?blhSaUlUZnhQelZLVEVCVVFJc01PbU1wbWJxUFZzd3hQeVoxVjhLR1ovSVBt?=
 =?utf-8?B?RHVJSjBmaWJhdlBaeXFpaEZXMk5jOHN1clIwTWZvT1AzRk9rbFBEd3dHeDA5?=
 =?utf-8?B?VFdVVzUwbzUrNFZmUTl6SFJmV2lMM0dDVy9scnBkOW9uYXIvUmJkYmZzS255?=
 =?utf-8?B?RkdkQU0yVlhJTnpCS2NPNjhHVE41QmVwMm0vaW0rV3BiR0VYZ1BHdEk4VmNC?=
 =?utf-8?B?RUtmeS85emgzYlg0YllQU2xTazNJNmc5enVQdm1Oc20wL2VteEZIYVViWG91?=
 =?utf-8?B?VXJ1Z3hEMDVCaUpETnlTaHM4S3J0SFppdGNqbllkekRSakRQMlc5UFMvRi9Q?=
 =?utf-8?B?MjBkSDNQQkx3MndBQS9tK1ZucWphdTBqb0dZaCtpZjNqUWZlZEUwV003WmRn?=
 =?utf-8?B?dHBWQ3pMRzNCYU80c1ZFOU9ZQ3J2a0Uxa2wyM1ZXcUFmWHI4LzFaVVgrcEpV?=
 =?utf-8?B?SkVCVGFjRE84QS9ZdjFvaUJRWko2ZEhKKzB0Y1d6ZUhBN1ppU0JjZzgxdTZr?=
 =?utf-8?B?WTZ5dng0U2NoS3BTbzV4cmNIUTBBS2NwZE5NTk9EQnBhdmY2ZVVTOE5MNkpV?=
 =?utf-8?B?WHhKMDRiNktOTTMyMXdaMFBhV0RKNzVqSVE5NEhCbS96Z1lJZVdaVWJHWTBh?=
 =?utf-8?B?a1dxa0FreVhkaXEzeU1zNmp1QmV5cW1aV0FJYUtVbjVMaWxrZDZQWlh1MnVE?=
 =?utf-8?B?OWJadVArT3BCbWY4TURraUhYTlNIaUlSQVpndTlFUDZON1l6ZUdiRWdmUklP?=
 =?utf-8?B?QThpV0ZYS2tBbExMbjlaTVRMcGxzMHVsOTdmQ3FxVXp4a1U4L1pySm0xb2xK?=
 =?utf-8?B?bDRsMHJGVHJZMUlQM2ZBUFV6cDhqcG1CVnRQclgwak5DUmVVQzZ1Qy8xWVNy?=
 =?utf-8?B?ZFl1TUlzMlYwUHlZc3hGQW9vM2hCQVZMck96UCtEaWh4Mitsc0V6RjdqalJp?=
 =?utf-8?B?b204Y2NJWFpWU1RxdmdPSExzcW9aejMyTXRuS2l5VlVTQ1U0azRCNlVUSzcr?=
 =?utf-8?B?S01PQ0Q5eTJyZ1FqK2Nvam1SRmtKT1hJdnNoMnFaaFJUSFVmZ2ZqWSsvMnB4?=
 =?utf-8?B?S0RrS21jTk5VejZHVXgremNLYnYrSVp4b0gwTkY5WG5BNWs0b0dWWm92Qm4x?=
 =?utf-8?B?QjJYaGxhOFVaWEw4QS9DaHdiRndPczRjWkhKdm1tTzlPekNrdXBUS0l6aVpp?=
 =?utf-8?Q?EtreI442hA7a/8uFtHbwn4f4NHVokviLkjUx5h7v1g4Zqe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ec79a7-eee3-4152-0810-08db562d2540
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 16:46:50.3441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BS5NIhlVNdEZQFfamrHfju0oEbAgqAW9uCSbt+kcAKMtshiSDFLicz36AdQLbVZ4cE31WxMVyN5Mi+7N6TdKRBuOrckiQZDvV/gSzBUb6RZdaRXLl8k8vp5wkff+llgn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_09,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=998 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160142
X-Proofpoint-ORIG-GUID: KpDVYeAUXavOK668KgsqrVUDqOkc14cy
X-Proofpoint-GUID: KpDVYeAUXavOK668KgsqrVUDqOkc14cy
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 15/05/23 9:57 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.112 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.112-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
