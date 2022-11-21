Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2778C632B90
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiKUR4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiKUR4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:56:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B0DD06E6;
        Mon, 21 Nov 2022 09:56:34 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALGfV1F023934;
        Mon, 21 Nov 2022 17:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Xalmnf0T4ufTEZUkFPfOq9lOzWqq74AOkrTR219TTlU=;
 b=rx2VYF5C1aXzwYGJ/jixo7pqfa5r6Oemz5U4I/3kTwZDppHNvVJdgs5mNmI6cAJwh7AA
 RySB+djzGN/CZvr+WgsYnNXKXRhRS2wNT1t2o88ggtKcK1yum9oTXMf16J938QPSufHF
 j4ZTFn6Q8HbE74sET8AX2CHKg5SRUmEHx2Las/WAy6puCq0VD57eQxWRdroR2tSnJwUQ
 dUeKL/cWr2WN/SXaT63u1vdnbsR2cGcr6WOq7nlydRnoscW+J/IT9hzfAWow4WM1XvKp
 jDkSM6CfMhmi+kwE+wh0UySe54AipdXOX5TWIVCIkLyat7Iv6IXzv5X/k3PAEITe+BVb dQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m0ct1gesv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 17:55:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALHGO4M028919;
        Mon, 21 Nov 2022 17:55:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk9ur7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 17:55:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPdhcN9fBmV2CeXZfH3btoRbJxSU4dy8QvIEKG0eNiTG7nWkwfe+Gq2cT8xT/lPE86fJYNEBM8ztVElBImMby04AelX4lVhZV4apAQIcMp7+cbwqe3XG26vrGIS3xc8rBd21o6yxWpvk8vHiKIDgrZhN3OS+89p0frgV2xDdTILkDKjmR2sEW53kN30rINE62gj7nB+0RObhm8BDsOfDFQ7dsAEV/p9jtE3n+1Hu3BRIxaOTLwpKj2lpzn+LsM98gq+SzDIn+lhtURqztkkVhbpMbkFTzl4FfhoeulY0pPHB3gTUNPbgQ7pKvYoDf0FsDm7dg0nuRfyzx7LmpeGxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xalmnf0T4ufTEZUkFPfOq9lOzWqq74AOkrTR219TTlU=;
 b=nvwHhrr+uZOnUj5DgwSeYQYcozN8hGCVO4jzGvc8b7GpUJu2YBu/07E1mR7zV4uoyZxrnnriOYf/cgbclYkmAmZOLWIDi6TStvzHoLhffwi+H42P3Qw+C+2L5YohJlHZVMVpKwe+/DT+7bAr6FybEj4ukX96v18jY8H6TxwRImsPrgcnN/pCXQNlxVnm1UpiqHWl9JN530IqJ2+mRprD0+GWR/jccKX+45Wd6KFTek5UeCd63ANq+oPiVkVcbtyO3lQOb0ngvsxC+2wrCUdTPKdTzON7z3ux5skVLgE5XtvGNb7v0f+DDswT/cy4qzwWSpp2DmsXrROrJ5zzOE5Gtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xalmnf0T4ufTEZUkFPfOq9lOzWqq74AOkrTR219TTlU=;
 b=xUcmsGn+igsrvvcYZt3wgDwNi8ntHfOS8/aD3PydjluIViFclReONttRRIu3WPC5H3ZsQgaQojfM7VBbmZBJysMEwsuEikm/d+8LqemoipZj6H+NwVgflYeCrX/oOZTvn+yObiNDySyuexSnKCmwusmxDxEbLWqTfmEAB93yMSY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 17:55:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d%9]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 17:55:28 +0000
Message-ID: <75c4f0e6-3f28-a748-e891-7be6016ca28e@oracle.com>
Date:   Mon, 21 Nov 2022 17:55:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [External] : [RFC PATCH v2 1/6] perf vendor events arm64: Add
 topdown L1 metrics for neoverse-n2
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1668411720-3581-2-git-send-email-renyu.zj@linux.alibaba.com>
 <590ff032-d271-48ee-a4d8-141cc070c335@oracle.com>
 <f3823c3e-d45e-40ce-1981-e726b4b6be62@linux.alibaba.com>
 <f6e26e2d-2f10-e973-6c9f-47594da2fc99@oracle.com>
 <cd016aa9-d43d-c585-0b77-a2e112777ec1@linux.alibaba.com>
 <abebb42b-62c1-30d7-ad9a-5fbf6c0edce1@oracle.com>
 <d904734a-e7c1-ca8e-7705-63fc4864ac4f@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d904734a-e7c1-ca8e-7705-63fc4864ac4f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0048.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::36)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b782572-c6f6-41b0-759d-08dacbe991bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PgVAeCCstCsW7jomt4uTc+EzP0+ozWBbT2Y2EE3ET3iZcLJB+F6y0dcY3Xgw7eXrlFZPpjMeuPKNnLngxdNFcUVCQGNZrcUhCAqewJrIL/zuWdZ7FG+by7KdrWZA0s5W/pVCbnjVRl5f+OzGAEpObzR+/fIIh1d7OR0Dai0q7BMD5Dxn31bH5+kCMZ7u/ktM9i5EtDJHHZxJB+sKbFDiYH7PWAMJwdlUKTqDGQYeZYC7Uau0groQKOncu2M8unhmVk3jNlgkB+XuFoKiaDe7H8iG8wtVuF0buJUypRpqWfcoviMBrgYFNumCgjx5F/dD/nvywXPIL5h0sCcx7bpNvgC7KYrH0I4nGVW0HB4ZlWFfds1d6FXZpiutgu5VxaZxBkkmxgl/d7g1i3g3g2OxJsTem9xRpz8PtRUi5rgLpgB1ZUcmzokP0UklkEDIM7ureoPJmXMSiTS8WnQjrZ41ccPnxy3f+YdrH63HesWmG0psN+Xc3q4um1WqffnjxlLvah0ZsxXEuGqA418x0483ExRUYbj7ZYNsTzI2LboHJkESxKrw1fGICTVsegtXP6jDp9FQmUijlOQBiu04COaKD3HGJ4EFaPRZG0wYX0NXulwNyyyFMECLhX+0iueW3bg08ygsRcjJDgP4uujF4cKO3bMBt1zDW2KYRJmXzKvFIWgH04B59ku+vCCs0eBlGAyPBQckusKrfNQ81E4cdsgnjw51L1LHfnkEZY9cNET3Yzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199015)(38100700002)(110136005)(31696002)(86362001)(7416002)(8936002)(4326008)(2906002)(5660300002)(66556008)(66946007)(41300700001)(26005)(53546011)(6666004)(6506007)(6512007)(2616005)(186003)(316002)(54906003)(8676002)(36916002)(66476007)(478600001)(36756003)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTBuamtXUjNHYU9xSEdBZ2thQjgwSDZnOUY5Znh0Z1Zxdy82MW5JVnRuRzBo?=
 =?utf-8?B?dWh4a3FHd0hqQ0M1aGx3dWxSMCtPYlJUNkZrTHFNaUpaekkzb08wTjM2Y1BR?=
 =?utf-8?B?STJaUFNuNDlINzJ6ei9KNTM1clo0bWhSaVh3dncwQmpLRkkvMUVBbThFdld6?=
 =?utf-8?B?Z0MxZnFDMlNKeWVRblVJeXRadHo0eXJpMWVVUnkvMjlVTGhZMm9ia0RYMjEx?=
 =?utf-8?B?V2FuWExXV2pDcHRJRVh5UGcycy9sbVpUYWpObnRiOWg0V3AxOGpVNTliNXlk?=
 =?utf-8?B?TjkreWVKYm5aWVpDRGI5Z1lvNDd6dVFRVndLaWFNVDE4Y01zWXcwUFQ3RGlX?=
 =?utf-8?B?M2tGMGtNMEhnM1UrdWJYUUhrSUdSeGZXMmtwUDBRdmdsYTFiM3Q0WlpvYjlv?=
 =?utf-8?B?OUZOZHRrSDk4dFRUeGd4ZTNCR1ZOelVSbnd1UmNETFFpK3o2RlFwQ2liaDdw?=
 =?utf-8?B?dUxlcnM3SWU0TmVVdkNlTWdidWZhdzd1emhaRm9zQVNyTE9vWEhWZmlmcHFk?=
 =?utf-8?B?TVZ4dzQreUZkTzE5amJTbER4NjdiQzVucFBGMFp3aFNZMklmOWdjRHV4QVVp?=
 =?utf-8?B?NTFnTkRCb2tIUFcrWThKcFJZK1dtbUhza3JqNi9uMzg2NlUvTWRMZmdzdUxP?=
 =?utf-8?B?WFdkYXEwSWFtT2V5RWJFazZLVE0vMEgydWYwcjBQand2WisrbkpvTE5XVFhG?=
 =?utf-8?B?NmgzNXVwK1IyaXhVZzIxd3BWdjQ4RW9NUmg1a3pLMld2U2tLb1laK29wTjhW?=
 =?utf-8?B?QkUxNDFpZ2hZdUs0V1R2L1dqMWVhakwvSnllL3ArWDVXWkN0TVpVMEppcFZ0?=
 =?utf-8?B?VEdYNmFjRFFFdGIwckZJRUVYelFZa2kxRjY1K2dyN2N6K2dOZ0ZNMHVzVW9s?=
 =?utf-8?B?NnJLL2N0WmtDVFZIejVVSHExSE9WbTFOLzdKWDVxZUduOXoreTN5bkdHaXpy?=
 =?utf-8?B?TkliTTZmRWFiVmN3dE11MDVDVXZac294WHJEenkvVjBmS2RZU0pIK3gxTU1Q?=
 =?utf-8?B?K1RzeVhPNGlDdm9td1pvWHY0NlpmNkJBVlNWaG5ubFF4MTJESld4bUJuZ0dP?=
 =?utf-8?B?WDN6bnlERHBaWHpiOE1JckM3UE5lTWlGb0p1RzhqTDM3Um5maENBUnVoYk9n?=
 =?utf-8?B?OUpIN2ZZTHUyemN4YTAvRzBMZGpzZGtkdWxCelNIcWJhTUdYYmFvOFlqVG85?=
 =?utf-8?B?UHFpa2VyZnFtL2krR0QrTnlKR2NvcEdVR2liSG03c3pGVVI0clh1Y2NVRmpn?=
 =?utf-8?B?YnZGNWJzRTRHUXJ3WVNUSmZiRXpZaUh3OWpiUmVodXhsN0dNc3JrWkxIUDVk?=
 =?utf-8?B?Um8vOTg5Q2wreDBJNXFpcFdLRDlIaWhaU05LUjRIT0xyd0tFSWpzYzU2d3NQ?=
 =?utf-8?B?T2pIeTkxb3BpK3FFQUh5TWFKWk50ckx5c2hnY1U0NGdRWWlvelVVdXdzVUJQ?=
 =?utf-8?B?eFVoYS9VNStmRXdVamFBZDZSUEZXUC9CWFdKdTdjbVZ5RFE0QXZhLzRma1R1?=
 =?utf-8?B?eEo3WXRGU1U1ZFhFSzRLS1hKMDNvVUVLNFc2S2Y1VkVkdHU2UVgzY1RxaXFi?=
 =?utf-8?B?aUhvaURjZXdiVTBteWtSYmZCVk1YaFRLQjc2M1VEY0l4TzRjUHB3TTNpS3pV?=
 =?utf-8?B?K0phVHYrNDluZkVLUkw3aUg4aENvVEgxbmlWZmpoNzd2Z2tSVWR6ZWE5K2lS?=
 =?utf-8?B?TzNuNjVQVlZSQlBHZEt0VVl4YzViQlJ5Zm5PVXdmNmY3YTZ0SzNQcC92OGdW?=
 =?utf-8?B?NUJOdTMrNEdDL0tZOFJuZHlOM2FkS3ZQUE9jMzZPZlpDUlo5SHhDQ0lEcXZK?=
 =?utf-8?B?dHgyK04yRnFLOThEZk9DOU1oWjE3cm9YSEV0WU5YRUpaNDhkVGdzMWcvUE9O?=
 =?utf-8?B?M0I3Q2FRb0c2eGpMOHN4bk52SHZpMDM2OVd0Q2d6NmFXdS9vZWc1R1dNS1gw?=
 =?utf-8?B?S2NMRVhDVm96T3ZxSU8vaTNGM0x4RWM4b0xQaUI0anhyRFd0WmRSMUMvZmxF?=
 =?utf-8?B?QmwwL3VLUlpIU2JZZTZaWFF1anJIQ1B1N0dzT3FKZGRpVm14bEhTOVF4Q1J1?=
 =?utf-8?B?VDk3R2J3QTQ2RVM0RkN3MEdKd2VoZTAxcUhUQlJ3RTkzWnk3cERqc0dzVllI?=
 =?utf-8?B?K0NPR05UOVJrN21iSk85QVNRclMwcUU5dHhBdzFyUlpCTmVRbkVrNHJyc0hv?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NVU5cU45TVBGQ1Jqb0w3ZWlNbVAybXVCYVdrMDhLa01ZakZaeEd0bWk2MUZn?=
 =?utf-8?B?ZGFHVGI0YUpjZlpxZ0kyS1YyY21JbDJIcHNBeHJGdmZUbGdHL05sR3ZPQ0F6?=
 =?utf-8?B?a2Q5SlVmN2hlQ2NWTndNTzZUS3lub0hVMlFlUEZabnFrZHpCdk8reldZT0VK?=
 =?utf-8?B?T0d6SlMyYnRkSURRaENkLzdzVTlUczFvSW1rYTVVbndWcFU5VjBXQUtJMWx0?=
 =?utf-8?B?Z2E2VFY3YjFKRjJzMGYyY3FUOG9zUkdoK2NENFpHN1Q2RkhvUGdVbzlIZGps?=
 =?utf-8?B?M09nTU1aT0FPVmRPYkt2bFU0bk9mcitHQURPdGRrSFFDMk5Cc1M0bUNoRlg1?=
 =?utf-8?B?K25ybEttOWpMYkNyb3BpckttOVI2eEZFMCt6OThaU3lIbjJRa2VDL0JNQzdj?=
 =?utf-8?B?TFNzU3Z1a21FTHhmNUxlTmZRUklkOXluZU9KNkg4OHI3bm4zL3dIUGFqaS9z?=
 =?utf-8?B?bE0xakVTenZxdEYxM1QyS3JkUzhTYTk0M1dlTGEvUWpPdmY5bVYzdUlGS0lR?=
 =?utf-8?B?M3d3ODlOT2hpeHdsMmR6WGRmWWFrY3ZYMGRmNnBaTkw5VDFYUDZ4RWI2d01q?=
 =?utf-8?B?TS9mY0I0VHJtZzhOemQ2bnZGNVBHWmZ5RE5NYndWc0hyRzhqemtkck5GbjVC?=
 =?utf-8?B?a1pSN3Erdk1yZ04yTkszTC9WUHZzRFRBV1ZrVldSZVJhSFJhMW52ZkZQUCti?=
 =?utf-8?B?Z0dhM2h3NVlzT3VBY0xZc1Q1L0tMR2tLRWlHU0tiQWdaWHFXOEpLSXNVeWF1?=
 =?utf-8?B?a29PcWdnUDg3R3RyZ1dDenNaWUxvbFFPRWZKajZCV1ZESk81RVN1WXVMY1lk?=
 =?utf-8?B?bUlDR2JRUDNCQVBoZy9aZy92V1hWZ2lTWml0eWVPVWtyNWUxdklrTUxob3ha?=
 =?utf-8?B?bnhPOTNWZitTYlJtN0o5SEhEaSsvZkhRa1RqeFUxblJ3NTJaTUp1d2tTbExQ?=
 =?utf-8?B?SEorVHl6RURuODVSbStBR2FTQXZpL0tTRG8vdzNuZXJOZGFEYUNJTGc1bTRm?=
 =?utf-8?B?ODlrZDE1Tjh4REFLM1ZJVHN3d0g4SGxlOW1Yb3p5bDZvb3dtYmFEL0dkTFdC?=
 =?utf-8?B?aWVtcDduVUZuTWFKYWF0VFFSaUsxS3dIWnFQV3hNeHhMZ2xIRVFnOE44aVpm?=
 =?utf-8?B?dHV3NDhmNXYwc25JVWdTaExEM3ovVC9RTmk1cTBBSjBkcG50QjcvUVdmNnl2?=
 =?utf-8?B?YXdpQURkTlZQampraEhCcDIyM2M5N1h6bmd3WE15VHFIS04ya05VQU9TTW9I?=
 =?utf-8?B?eTd6Y3FENEZjS1RGYmtla1ltbmhkQzcxRzJVcUdmUTZEamlMTXdJZnNVM25s?=
 =?utf-8?B?cm5KOHdORkY5NjNsckdpYWo2SmxkdlEyaC94NFNDdzhvQk9BTDRuaTU3SHQy?=
 =?utf-8?B?eVJVOHZPN3p2M3BXbVRRZmxISEpUVFZiYUtkbWFsMXVINXBHZ1N1VVI4dEhW?=
 =?utf-8?B?LzJKZzJ5Ymhkak1Kbk5DTnRBR0hWMUpHUHJKQTNsRnlOc3UxSU5Wanh1c2Jt?=
 =?utf-8?B?aHg0M05aNzViV3k1UkI1MjVRNmRkUDQ5WU9tZEFPOHJJdFhuUTQ0aG5yQWs1?=
 =?utf-8?B?aUFEMUFtZnRqY0t1eHMzUU5XUXNXUSsySER3RmZNOGZxOXhJZ1MxdVR1MFlT?=
 =?utf-8?B?UWxYZ25BQmY4UnNhajVwcVhaOS9pVkRFdnBwNFhhTFo5SkUwNHdHbUpTRWdC?=
 =?utf-8?B?M0lYbjFLdk5Fa285SXMvR0UxYmtIZjdUbjJUMDN6TGVNM1AxUzNvQlJxVFAr?=
 =?utf-8?B?VGVvYzFrTDZ0UDR6N3A4VkxpLzQxR1ppQXFFd3p0RjJTSTNCZHY1dVZTck1L?=
 =?utf-8?B?Ly9tNHVrdVowT09ia09ubTcrd0lIMllhOXNtalBSbkdmQkhIa1J4ZmNrSkZG?=
 =?utf-8?Q?RCgu9ORdzsDAX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b782572-c6f6-41b0-759d-08dacbe991bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 17:55:27.9838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ysvi27vwxt3mIgvRCQ80Eg8aG+Sc+UBVfZf3EQ2LyIX0sS2HV1zzpUyia4AaYP3KKJitnoke+SAvhj2waKfY0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_16,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210138
X-Proofpoint-GUID: 0mpr-sS9gOndEbg6IVgJuGN-13HgliY5
X-Proofpoint-ORIG-GUID: 0mpr-sS9gOndEbg6IVgJuGN-13HgliY5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 15:17, Jing Zhang wrote:
> I'm sorry that I misunderstood the purpose of putting metric as arch_std_event at first,
> and now it works after the modification over your suggestion.
> 
> But there are also a few questions:
> 
> 1. The value of the slot in the topdownL1 is various in different architectures, for example,
> the slot is 5 on neoverse-n2. If I put topdownL1 metric as arch_std_event, then I need to
> specify the slot to 5 in n2. I can specify slot values in metric like below, but is there any
> other concise way to do this?
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> index 8ff1dfe..b473baf 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> @@ -1,4 +1,23 @@
> [
> +       {
> +               "MetricExpr": "5",
> +               "PublicDescription": "A pipeline slot represents the hardware resources needed to process one uOp",
> +               "BriefDescription": "A pipeline slot represents the hardware resources needed to process one uOp",
> +               "MetricName": "slot"

Ehhh....I'm not sure if that is a good idea. Ian or anyone else have an 
opinion on this? It is possible to reuse metrics, so it should work, but...

One problem is that "slot" would show up as a metric, which you would 
not want.

Alternatively I was going to suggest that you can overwrite specific std 
arch event attributes. So for example of frontend_bound, you could have:

+ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
@@ -0,0 +1,30 @@
[
     {
	"ArchStdEvent": "FRONTEND_BOUND",
         "MetricExpr": "(stall_slot_frontend - cpu_cycles) / (5 * 
cpu_cycles)",
     },

> +       }
> +       {
> +               "ArchStdEvent": "FRONTEND_BOUND"
> +       },
> +       {
> +               "ArchStdEvent": "BACKEND_BOUND"
> +       },
> +       {
> +               "ArchStdEvent": "WASTED"
> +       },
> +       {
> +               "ArchStdEvent": "RETIRING"
> +       },
> 
> 
> 2. Should I add the topdownL1 metric to tools/perf/pmu-event/recommended.json,
> or create a new json file to place the general metric?

It would not belong in recommended.json as that is specifically for 
arch-recommended events. It would really just depend on where the value 
comes from, i.e. arm arm or sbsa.

> 
> Looking forward to your reply.

