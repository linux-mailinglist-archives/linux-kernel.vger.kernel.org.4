Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BA770C28E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjEVPgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjEVPg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:36:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2761CCD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:36:27 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MCwm4Y030648;
        Mon, 22 May 2023 15:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HQeC/84uKnkpdGHgTQeobR2R30NvRNK1zmokxjRjuLE=;
 b=K69M4/3dglZ6pX0B5y+KPfmFNLN8sm7L6VeyRRuw2sd/ER90aca4XJRnfxVtb8oYLjgG
 LMSEFMnlpddCutpm5icjn2WrHGcGJi0rczvWOYUAGlxAf9yARC/aDeXzGOt5TaRmGsgG
 RNbOLWIvPYQCExbN674zd/WXvW6TetgbGT7KupRdEZxBOnW3kJ7K6x/CyGeslQ6wy8sf
 gKhff2PEQwxBVMVoLi9+rOUk86nxXVBl4DBpI9j2RhvHBcnGY9zUbpmCPDibyO3gUzdl
 AHbgH5aSCPJmBSALJH6n1O2/hqJfbTtn9nclSiG63U9HnHGiKZY577lc04i/SgKW+wE3 2A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8cb304-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 15:35:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MFUxja027170;
        Mon, 22 May 2023 15:35:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2cc7yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 15:35:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5p8BMTzdjD6dZIodBGeGfCiMHXwpWDugWxo8JFohQxm0WMq1Qln3XNT4hgzoGrL9ch+G6hHhXnUykREkBbLZlhqUE5G/pHK3Y9Sm5FZkF/qKCWj6RWHL4ZNqRqDUlg+G2HuwxUn4/b2z2o++FWdeaj5KSYXk8hwtvlIpbLo16+vYGRoqQYl5/Tu6z/aWiKVrMCbOEdyR/v8i34BKLu8ENfFdzEecPf08Dej6Uda98l1idoZVd7MtR0YMAD6defFQYDegrvLQ2nGoHKZt9AZYMFDHtnHIfrVu3gmHD4c8alAnynVyPHZ+Lf8945gBLSQYHpr4WDd6vjOTWd//zfWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQeC/84uKnkpdGHgTQeobR2R30NvRNK1zmokxjRjuLE=;
 b=HKpnli/Gdmq0WruvwiC4dF89+/3Gp8ExLLn6gB5JXHRzcWfxK3ATeMRGaHAyA3VIa77XVldaGhBr/N2a5FRnu37ng9q7PZpY08Ylh5B4tAfT4A4Wu1psV4PfHDcbkzdM+R658HniwGn2i9GPHTp4oo7GGOBmQxyaRxnP/ReJD9uoqdFkW1T+u3PolLp2RCppcQ3El1tOoRg475DBGzQ8SMI5nFo5jEjec+eEK48nw9JKVRsN4AdFtyYfAkvbLVVWLJP3NEmBAW/b/7SUku3iIfTolhUsN9dnl3PNQTyls/6nvjLkIEwAVmIC2alWzDek1SECayMrOyFqh0Tp3tGZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQeC/84uKnkpdGHgTQeobR2R30NvRNK1zmokxjRjuLE=;
 b=AvDSKmw4QIz4gO3VRFoHMXrKJWckINUCLVZ0i//sU2VxNhz+EK2H0nwh3M/5Cjf5eW4vpMFgY0OeIHBIQEQMb/I5aO/73zEU8HxBV98763RBXHAQFzo8FByhQyjv2JfxpwSnIeQGtvXOt+GMDT6I+2E5HBjnPuTTb9ufbeVoxYQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6673.namprd10.prod.outlook.com (2603:10b6:510:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 15:35:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 15:35:39 +0000
Message-ID: <57017dea-c453-82bc-18b1-79663e77552d@oracle.com>
Date:   Mon, 22 May 2023 16:35:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] iommu: Avoid softlockup and rcu stall in
 fq_flush_timeout().
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Li Bin <huawei.libin@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20230216071148.2060-1-zhangpeng.00@bytedance.com>
 <edvxk47ok5dhlif5mhntrazzg57vxpcwqncjtr4n3ts2zvp6ib@o6qvqfmvxmlt>
 <7bede423-690c-4f6a-9c23-def4ad08344e@amd.com>
 <21f69b43-a1e7-6c84-a360-dae410bedb3f@amd.com> <ZGuDGftmxsF35C9P@8bytes.org>
 <vxxh3laqaavyxx3f2c65k7zui6wkahm6fspy6hvwpofsxtialo@ne7za5hvlgk2>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <vxxh3laqaavyxx3f2c65k7zui6wkahm6fspy6hvwpofsxtialo@ne7za5hvlgk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: d3122ce5-076b-4666-f37e-08db5ada3241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tH7OpqE+gpmO98j7pygTcUUDF3xAjU9HMRJZBjsUicb6x93QnNkKG3ShRyeMvCJkqvaPkW7xQVWacfe33tgOYvvc3eYrHxI5C9j8jODUK67gY7UgPvWJEDmkbGWcTF/5Awznoc4BGFwV/odNeK+fs+cF35h16CEMKWfbed9c0D3yyrposo6JPoQpl2WiFHwAGaVupjWUA8OTLKJQszsmLil0WKsZLc4Q+QZcacN9gQx7yAYejLCEM9+tA14bwKuwfvgc3oDmhj1u8wBUjcoRtesDCGDVUWlcq4IDXheQAvTRlB4OkRuwl+XUHdY8ehtDESW6KlpiKt+f9NgmQSY/Xmy7GNPHwCTlmFMOzLKnLp+O7aMoB5A92YS0FU95Pcr3ncXU8jA6/O6PoG6TkAVgkAd+GgniE2o4MsJP3YngMqIUa9tM7ZsatwRI4i9cPXp2fPRKh7HHbkeE0AAhceZiT/Pab2anpHnKTQftQGunbRW45ahw+JPIoJyvfmR9zlBClSGl7UiOng7GxADfB4HbSzkJCEoWtPGKPOzw9M0RQivWlkGp1EgkIZQrYuT2NYRMmY3D6JqkScQGeEBF9AgxkFahWOgFzC6coG+6N4+n7kcmdK28of/kbaZcFTMrUwbAenggCaeHDxjdIcp9jG0oCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(38100700002)(478600001)(4326008)(66556008)(66946007)(66476007)(110136005)(31686004)(54906003)(6666004)(6486002)(36916002)(316002)(41300700001)(2616005)(86362001)(31696002)(8936002)(5660300002)(8676002)(36756003)(7416002)(186003)(2906002)(26005)(6506007)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnRBTHNTL0RxNUxVRXl2VkJBRDROY3NOWXhxZGxiOGoyTFJvMC8vUFlSOTkx?=
 =?utf-8?B?bDYyaWtXZVZkWDJKUXhvTkp3VWU0UXVRejN3bnR5TXJXYXZUbzZVRVdFYVVB?=
 =?utf-8?B?a3JOZFEvdUtxTXlPelRvenoyeHhxL2twYkdySDc2cTJSM2lRb0RRN3g3VWZx?=
 =?utf-8?B?M01qVG5abjdiWGZJUFlRUDJOU2cwRWdTdU1aTUNmS0hBTWV5azIyeEoxRk1t?=
 =?utf-8?B?cFZpUjN2cU55YktOSm9SZTVPVzRuS21xRTlaT1ZmQmpSN0JlWGtSYjBqcTJo?=
 =?utf-8?B?K2JEQWNKc0FOdkdsYXhXUFdkN2RwRGN4d3F6bU0vQ3Y1eUxwTllESFZuV1dq?=
 =?utf-8?B?U3BmQ0E1VEFzcnNreWJSMUZib2luQS91SGVwdkp0aFZOeks1UUNMTUoxOXlq?=
 =?utf-8?B?MzVNRVZ6b3BzNUtXRWVoS0N1NncxUXZ3U1VwZHNXSkdrUjJRQ2dHbElUa3Q0?=
 =?utf-8?B?em5XQndRWDNWM3RkT3pJazN2NGk5Z1RmUzhrenR1eVdlTmhvM0xyT3AwMUVF?=
 =?utf-8?B?ajNUTUNJM20zWGYyYWg5NlRJT3JlZUtBQTFkdHlTRXMveGtsK091b0VELzBm?=
 =?utf-8?B?VWRNdkkwYkR0OEpQOXdlRllMU2g4RHVqMGVwb2hybHRkOGxFdFpwUEQyb3JJ?=
 =?utf-8?B?bENqUGFsdlZFVS9vNEZJR3duQUtoN1pKSlphQ1JkT3Y2enFNTmkxK1UvaHVE?=
 =?utf-8?B?Y1B4WnFFSm5jVWlxRnY1akloK0xsck5hNFFGbDFteTdqN05QSlVDcVlHNWpC?=
 =?utf-8?B?dFFEY3ZDdWdrZ2R2ZUlqL0Rhd0JKMEFOcnpNZlloa3dObnZScGZxN0d5Rnpr?=
 =?utf-8?B?V2ptSVVYNC9SR0hPYmxXclRYWHhBUjVHZnNUVkd5bkdGRHZGenhwNmFpeFhC?=
 =?utf-8?B?YUNoVzNVR3hHU1hBa3lKK0tPQlI4bjl1a3VsSWFhbFBTTXpsMTllbWRaWUgw?=
 =?utf-8?B?dGJxYlhJRjgrRVdHNW55KzhLM2RYckhaRStSU2xLdWRVVG1BenkxRDM1a3Bp?=
 =?utf-8?B?MjF5bm0xckZnS0pnRW0vQU9QUDJRTW40OCttLzlidEsvWVJWUTE3emdhWWM5?=
 =?utf-8?B?T0FSYU5QUTFXMGVTbkdIR0VmZVhWSS9kbUpJQml4QXgzeG83Q2syYW9IYlpq?=
 =?utf-8?B?UnlRNURNQ0ZNQ0ZBQjdSb0FlTGJUNC9LN0IrMWNqNVYvdzBLTjF1eVZqSW9F?=
 =?utf-8?B?eU9aMk4xZGJWYi8rNzI2a3lLUGRsTTErZGkyYVJHQStiVUZEaituYXRmZGpM?=
 =?utf-8?B?TFNReUhVTlA0V0xzWXlOZ1QrZVhjWDFFdHpCN0lOZ2RtOTNvd3VFaHA4c0Z2?=
 =?utf-8?B?OC85bDhHbmFBem5jT0VCVjVabWlwU2JVR3NueUplbHh4VXF1V3RsQXRWZlNN?=
 =?utf-8?B?SkY2QldPRDBXVU1ESTJZWkVhM1R1Mis3dStkK0RDM0s4bFFtcXNUbURweUQx?=
 =?utf-8?B?Um9jTFYwK1p6eUxqdi95NTVjRUFHcHNuTUhZa2ZRNjMxQy9ydXExdHRFc3JI?=
 =?utf-8?B?OVZ4UmV2bC9ZbTVoZEE4ZUxHNDZ2UUg1TUdDQVVlN1lIb0c2SWJQRUZ0VFBC?=
 =?utf-8?B?YzAzR0ZpVzdZcXhSSjAyTXg5V2p2aGxLTWtUOXIzelpWT2NSOHVEcHlNYTE3?=
 =?utf-8?B?OVVzdUFlSENBNTBvZ3FuclIzK0F0ZWVhSjRrZHBYTEY2ZTMxeDN0Z25iQWtZ?=
 =?utf-8?B?SGJPREVrUGI1MmJISUl1RG4rNnlYcERZeUIxOG9NaGYvOXBNa2crSkEva3FG?=
 =?utf-8?B?cGVMTGRuTzRXdXBMcmFMSlJaZytBcG96c2FoSmFiQzlvKzhqQjljV1B2U3NI?=
 =?utf-8?B?Z25hRURSZFpTQ1gxNlJHTTZqekxkUzhYNDUvM094bjdxMVhCcmJPY1dIVTA0?=
 =?utf-8?B?bDlIUUtZSzVoRUhsaFhGdkg4LzBxNGFiY245Y0w0T29VQkZkNUFqZm04cVV1?=
 =?utf-8?B?a0R0OHJ1S0NaRFdzUlNwbG5jWVlwc2VIRW9mNWhKRHFYdXY0d1llcmN2NlpU?=
 =?utf-8?B?T21vcDA0a0tncDlZWWtKVHlOV01tb2JuQitwZzBpd3N5NVVTZHI1MW1OMVI5?=
 =?utf-8?B?ZGJwQW1ObXQvK1pHa1V4WFN6QVRTYXhxQUFhTkFFUXRRa0RjU0wyUm5XdVZ0?=
 =?utf-8?Q?WJj3KoBR9xMcLNNkjUomqN0Oc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SnNNeEJkd1hSS1MyL1RDUDhWUWkwS2t4NkVxbytzMHp0NTJ5VncyN1dnUFll?=
 =?utf-8?B?SjFjcFBUdExZNURHYzEyWVp5R25hN0RvNm9BdVNyTW5rODg5NEJRZ040YVdU?=
 =?utf-8?B?Vm01cHhaMkRzUGpTeTdoaUVRY0dueE9OVHlOb2ZnVTM5OXRaZ2ZUVzNFVnpx?=
 =?utf-8?B?NGozUWVkT3ZBZXF2eVVub0pCRDNOaWR2L0xudEFOSlNFTmsvcEFpYnRrTW45?=
 =?utf-8?B?OVBTbmNYTGdid2h1UDRGbytIS0NNTVo2K2tudXBXTGFUOCttTTA5aWE2dXhj?=
 =?utf-8?B?Vnh0UjRYYVlWOEhKeE9adUJFeXJybDVYdEZZL0VMQmxnVEQrSkx4QzA3VWEw?=
 =?utf-8?B?RzFqWVFoalJaZC9KTjJjTDlyUmt4OHhlSnVGaHNXQVFmYW1hd3kxUWhRVkRx?=
 =?utf-8?B?NnI3ZDAzc3FMV3djVE5OcHV5R2JBWFNVTWZWY0FESkxad1QwRDV3RG1KT3pw?=
 =?utf-8?B?Q3BmZlozZ3BmVm82azF6ckJSOWJVWlNSWjdWTWRtU3BzTEJqOTNiQXJrWThu?=
 =?utf-8?B?YytsRGhuT0w4Z3JQbThML3ZXRGc1ck1LeHcrZFowTUM5MlRpcUJtVzhyRnBy?=
 =?utf-8?B?Ti8rQm1TbGdNS2ZOQ1BjN0dIeHZkMVZXcWozLzBhckNnS3daNW1yTDRpS2hm?=
 =?utf-8?B?cHRweWRFaDRPZFlQU0xIZG95OStTU3lKMWNDVHJTcnAyVUpKV25DU3FaUlBL?=
 =?utf-8?B?NjdaNVJhaGZaVkUwYUFMRnpiN2F5aE9HUGgydVdGcGk0VS9FTmwzRjB0dTg0?=
 =?utf-8?B?czRvbVdPaDNQa29xSGJ2ZzNzeUFZbEJaOUFibHc3RmhIUmI1OW1JVUJ4VXZz?=
 =?utf-8?B?WkEyTFN1bUZnNVNnZTNqKzM0SExSTnFrSzM4THQ4ZHFIaGx2WE1ZMHA4YmlT?=
 =?utf-8?B?TVV2cHQ2MkNtYU1ZVVIzaFlDS2d3ZWhwM0k2NDRnalFwbmpzWmxxRDZEbjd4?=
 =?utf-8?B?NG1jRkpaMk1JMVdnNG85d2MxNHJ1dlhpdjRQUnNBRFltRUx2dzRxRXpKTXBq?=
 =?utf-8?B?UjIwU3VkakZhdFVlQkxGY2x2cjMxKzEwUmpLTnB4NjJPRS9aaEYvaU9OWHpK?=
 =?utf-8?B?ZDAyZi84T0hPL1paK3JoMVB3NHVmSGxLQ25UK281WnRJamRWYnoxaHcwdmN4?=
 =?utf-8?B?RHV1SkxYbzBaUmhhQ3ZrRDkraXR4UGFjR1pDaDlKNHBCSTJQWFNKTXdJaFJQ?=
 =?utf-8?B?TUMvVVR3bGxsaE1LcG1YNU5GdnFhTFVvcWRjV2pIV0ErU0lKOW0vVGZMdys4?=
 =?utf-8?B?ZjVEaklMcVRJV3VCV2pXRS80cmprYWZBY29ELy9kWWJWTHZycHJnSjIveHJO?=
 =?utf-8?Q?pWFw9vv3coxSywqCDuXWu3ARM+FLo0S7kn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3122ce5-076b-4666-f37e-08db5ada3241
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 15:35:39.7740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTtweafQ7OzxN4albHr12N1MXq6mwFXjhFcmcXLCSHSjumuDlgLLrs9+Y6xfNkubqWVKDcNGdwn0iecuLX9I/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6673
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_10,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220130
X-Proofpoint-ORIG-GUID: 7Srw_jKv_Oxfxo9j5Ve6iP2FJsYfcNaR
X-Proofpoint-GUID: 7Srw_jKv_Oxfxo9j5Ve6iP2FJsYfcNaR
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 16:18, Jerry Snitselaar wrote:
>> My guess is that the allocations are too big and not covered by the
>> allocation sizes supported by the flush-queue code. But maybe this is
>> something that can be fixed. Or the flush-queue code could even be
>> changed to auto-adapt to allocation patterns of the device driver?
>>
>> Regards,
>>
>> 	Joerg
> In the case I know of it involved some proprietary test suites
> (Hazard I/O, and Medusa?), and the lpfc driver. I was able to force
> the condition using fio with a number of jobs running. I'll play
> around and see if I can figure out a point where it starts to become
> an issue.
> 
> I mentioned what the nvme driver did to the Broadcom folks for the max
> dma size, but I haven't had a chance to go looking at it myself yet to
> see if there is somewhere in the lpfc code to fix up.

JFYI, SCSI core already supports setting this in shost->opt_sectors, see 
example in sas_host_setup().

This issue may continue to pop up so we may need a better way to turn it 
on/off for all drivers or classes of drivers.

John
