Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFDA7355BA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjFSL1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjFSL1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:27:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CCB10F;
        Mon, 19 Jun 2023 04:27:32 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J9n5pk004103;
        Mon, 19 Jun 2023 11:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zbRXVZjBArIyJ1JXlcq0bwlGxMtlun5LgR+jmi1/F9k=;
 b=HZE930h7OuchaUWUGi8cEzehsQSYWhFbatqhwHbv4dNPOa+aGh/pDPMS2v4aSgl0Z2lG
 tW7QbDF8nu1bmSI/VVTz2F3Mm+axxBDYrol5bngvUdnLmRyF/OZ4OmOzclMoxC/uoQO/
 HE30G6a5RELRxlqR52NOCCBb5GDIyPencuRnBA9XPJM42RCRVk8kQtF5j5/DIgpmRjjq
 ETMCcF0dbRWfmYkbWBChQhmtVsT17wz5VWfRjwVR1KFuYMYvxJGS//R+V1L6cleEvOlu
 yssOdJgayNHGcMvMqZPRQV9vbPX5vSFBnbBarvQQxGES0R9Wfc3ApF0bU1qwLRLs7071 HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vcjjfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 11:27:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35JB2H1v038756;
        Mon, 19 Jun 2023 11:27:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9393ad52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 11:27:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0p25yQmJcX8X1eVrpXSBedZaFIXESr2W0ZyzGBVXj+Sz46uOo4GpFBV+s8As/EXVKEF4t3rq11OFjgmuXXXAoAneMm1gfGpTNvcKba3/hFSlesFKP9BYi6v6bxvhJJJ9RIDNEKcMXJ8A9il5hx2x/5lkZoovhTlJarZwaIut/Ni7uPtFIK/3NLYQn6JqBY+dzpRjHD/SI+niIx9nEZ7ttPFO+MfJ04YmXK2lTx+wWERvlWxxUEUx88q/rCTZ1Xk8k3c0cx64zMglpr1m2U73ji4XjF8/k9jdILDmpHFVF12sSK9sI/+9tGEbD+ISYyuXN9q3cgL88p0I1XwvTvDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbRXVZjBArIyJ1JXlcq0bwlGxMtlun5LgR+jmi1/F9k=;
 b=gys5aFESBYh8cHKGFzVMPMP8tCrNm02+tl0tXDyxYkLPN2SKxbQTef+1qyYCkAxmCQXrelU0UVtcpI3JH13FQp+m/3B5v/hUc5h85Gi6u55W/iGy/9fnkO60dO7/nFrD5A9AQjCi2kUDAu4KaK+PYFBv9NHWUcyZifzMVbZ+DnBkRNzsEXmBi/TrrH7QyPhAawxcou5ftbQrkgJAoDUuAlpolaayZkThCgJCVxlX6dAyO8bbFODFnBBdO6oOlGrSKmWy/8Q2LUOGPry/NuTcK5iU9rWOLSDtVPUFj8dBpPIIPieGfuPNEe7zDUztgrR6xgxTF33DqK9RXBf+jUW+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbRXVZjBArIyJ1JXlcq0bwlGxMtlun5LgR+jmi1/F9k=;
 b=WixY329n8rrDy1PICFiIzJhd87+EtzfbKCnXKAQ9HB2CZNltItzfUI/4iQ0vUHEg106aTaI5lJozb3NVgbu3Yu4pa4epjPTGgGxvAnEl6u38EIIXufvLluQ1tJoLX6FmCiG8iDTtvEoudUQQw5Pa2usIQJiY7oMNj2YG7/RIcK0=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BLAPR10MB4883.namprd10.prod.outlook.com (2603:10b6:208:334::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 11:27:07 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 11:27:13 +0000
Message-ID: <c363779a-6ce2-57c6-6e4a-4618e383bd08@oracle.com>
Date:   Mon, 19 Jun 2023 16:57:01 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v4 1/3] ASoC: Add support for Loongson I2S controller
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     YingKun Meng <mengyingkun@loongson.cn>, lgirdwood@gmail.com,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Dan Carpenter <error27@gmail.com>,
        kernel-janitors@vger.kernel.org
References: <20230615122718.3412942-1-mengyingkun@loongson.cn>
 <cf2f3bc9-3141-8d7b-b57d-73eac70a21d2@oracle.com>
 <ad4722ec-0fa2-4bb2-879b-47bcbd96bb0d@sirena.org.uk>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <ad4722ec-0fa2-4bb2-879b-47bcbd96bb0d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BLAPR10MB4883:EE_
X-MS-Office365-Filtering-Correlation-Id: 34de6c27-8566-4964-e3ae-08db70b820c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jf9ojm+pbJ38JgiHYUUphmKVIl8qZvaBOYFdqf4doXDFGZXOzWVbZxpA3KUdvW6bNcibi+TX+GcGXVaT0zHaFAjrpgM0g5RWm7aNIsFqr+zVlVrHMSEovN7bMcCFYexhHAwVfgHsdrmPQb0n7nykSm3OBViU+at9caTJ5uowbWNSSPQUYwJ+skto3SHbH+9BVVXL547aKA1f+tW5jHjM4IwhdxwPVlBck9QU63h7HDWhKz+NDi68B2vUSDTtABqiZiRUxx9oJcUpbMQhqPtuDZX7sClgalQyj++Xs4cCFO1EipUc26hMqWN87AtWgXjxIaHmCSX9hNDhn/DmAl0jhTLUnQ6dZubhIfRvC7wjVMZ/WhsIj4gqLzfbPaq+KqWjxGl8ukortMcaLq162Y9AayDihyXqL6E0A/FlB94thZqHwhOGNxiDTmeCJU0JQrQhNQJSrHrdGFMDVl19l5diGDeyKTu/hG/C8KTb6ZXfe2vHW0mp5upZ1R7Z3ZMMVVED4Kpr5JfCA5ts6KWr0OsMHsUlt+IkzFroXnEMGRecyATm8NYj9AY9MEGxCr5feC4+Dlzr8Ar8EZHEA3mEKblLusY/aEskehLd3pHDtC9rxYcxWaF7I55yPKuhmpADJBK46uheUduQ62vI2eyn3VXHzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(7416002)(31696002)(86362001)(41300700001)(8676002)(8936002)(5660300002)(66556008)(66476007)(66946007)(316002)(6916009)(31686004)(2616005)(38100700002)(83380400001)(186003)(36756003)(26005)(6512007)(6486002)(6666004)(6506007)(53546011)(4326008)(478600001)(54906003)(4744005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3RHUkM0T2M3TmJ1V0drY1g2dXhFek5RaFR0Tm9xRHJ6MzFFTmtZUEY4WjRJ?=
 =?utf-8?B?c1M5RENVZFB3SkJNMmNrdVorVVVuZ2FsUkRrWjdERWZHY0VXcDFieUJ0aVlk?=
 =?utf-8?B?ZmdaNHdPSy92MXExbVpmR3FKZnBvQ09GMFhybjlKYmZheCtjRTNHaEFiZWRT?=
 =?utf-8?B?Z0grZHBqbEE0dUc3dURQaUZITzZTVTlkVGNRZ0lpRldDZTNoWVYraUxlbGdX?=
 =?utf-8?B?d3lPd1FTbUFlQlFwVXRFRm5veDQwTDRjREtqNVR6RHRKL0U1bUdDQTdnd1dz?=
 =?utf-8?B?Q3hvZmNnTDBnVzA3YTZ4L0lqTzZEYVprTGNkVmEvTldwZGo2c2x3dlpnNlc4?=
 =?utf-8?B?RzRmb1ludGp3a2haUTR2RHNZNWpLUHJqVHpCRjBxbitNM3hTS0J2bjdTLzln?=
 =?utf-8?B?a095ZVZtMG9QUzNuTG5SY0FQVjNMLzBNc3dPTU5CZTZPNVVCQ2ZwYmRwbU1I?=
 =?utf-8?B?QUxvSFo0VHpwQTh3ZWg3R2x2SFd2UHVIM292WE9OMk1FanhiZ3pXenIxZkEv?=
 =?utf-8?B?R1hPbDFUUEpJQkxRTElTTXFxVXVOYmtpWEFlTTJOOGx1K0J6V0xOWmxUNk5J?=
 =?utf-8?B?ekdRVS85SE5GQ21JTWdtVjlJT28vd0JwT0Y4SlpVVDZmTnBMSVdJV3ZkS1RI?=
 =?utf-8?B?dS9lUlUyK3NLbDBBVGYvVmNXMEZCdm53cTZveFNsbmJ1cmc1bGJHL2lncTJB?=
 =?utf-8?B?Yk9nRDhHY2JETmJkcERhZ3l6bzBWNlpieGowOW1oTUxka281bVd1ZEJGSVRP?=
 =?utf-8?B?MFJYbExzMnF2NjNJd1gvVjZXSXNUWjdKWldJUjI0UmdWMm1KY2tlb2lGSExW?=
 =?utf-8?B?V2NaTGpORzlEakZ1Z3p0Z09KcVpiNVhYaTI3djVEWGtwSFNGRWFrb1ZkNjFD?=
 =?utf-8?B?WjhQMlRSU1R1VjNQQmdBVHhQaFZuRTVtV2JMYklwMGgyZVFmem1leU1hSHQz?=
 =?utf-8?B?UTFDSmZEd3VaSlBUSGZPTjdyVlZYT1VHeWFNblFYbS9MQVoxUGFsM3JCQlQv?=
 =?utf-8?B?OThFWTE3eGk2UXBmeW5DNXEvTUYyNWlwUTd0bTJTakJUbmovU3NTUHVnRjJK?=
 =?utf-8?B?Q21zYXgzVDFkaTRUVGpHeThpZjFiY0VvMllraU4zeGxsZHV0VGFJZlMyVUI4?=
 =?utf-8?B?WGJBa2hYZ2hNYW5KYUZHUGRMdTkxdG1rQi9TNllBdlRjbW5QbTc3OXg4VURs?=
 =?utf-8?B?dUxDeFpsV3UyZ29RMWRWN2czREc5WCtmNjlXaWthS0dIeXBxdjNSM0I2ajVQ?=
 =?utf-8?B?T3QwWVBkVGZ2WU5CTU1IeW81bW9jbXhSS09aTHBOeTVzYXA4djRXelpRSzE1?=
 =?utf-8?B?cEM5MkcycHVrL3R1Tm5ZZWZNcG90ZWRUTmRveTBsRWZrRHJtVkNFYzBneUd2?=
 =?utf-8?B?UEhQU1RBNEJSZUIzVi9OblllSU9EUlJOZUpwVGlEaHhkUE41aXN4YkJnNnI0?=
 =?utf-8?B?SStmK2I4VG5PWVR2aUMwV2RHYW1lQXZxR29ZUjBNNXpScG1MNDM1VWNuREFO?=
 =?utf-8?B?dmY0eFI1T1gwV3F4akhoeUtURUhINkxOc2lrSE94bzlLUUg4VEdqK082dmp0?=
 =?utf-8?B?R05LMlQyaGgyRkhmMjZsVDRsNGlRRDNPa1NZTEh0d0NRSXJndlNPU3owZnp1?=
 =?utf-8?B?RFFZM21xVDhuZUlVRkhmUnFLdEVCMm1RRzdoQllFRkg3UEJSV2MzWGZtZ3Vi?=
 =?utf-8?B?N05pTy9jQS9LNlNtSW5QUVlMTnhrblQ5bys2R1lUY1JMK3BGbXBWWEwyUHlI?=
 =?utf-8?B?aEs4b2ZkWitYT0pPcHA2aHFHTlpGb1lWU00vVng3Y0lPcTl3QnExNzZ6cmR5?=
 =?utf-8?B?ZTI5dEFSWHM2SjF6L1hpdjRkalBGSGEzWUczdUlNaTZSTUNVendPVWV2R3I3?=
 =?utf-8?B?cW9VeWlRakVOaHFKQ0xDeHR2SWQzbUVkWHluYU5DZVFuZkRJTWU2OXQ1dFlq?=
 =?utf-8?B?bmdQQnBvWVhJUy83NjJJZUpqYVlIa01mZmVYODRyV2tjRWZGZnR1YkxkYWtO?=
 =?utf-8?B?YU5WdEdueHQzeDRsYTdZNU1sVElHdzdTaG8zcFdSaHRTTUdTc2hISFBaN0Zm?=
 =?utf-8?B?Mmlkd0hNK1lnd0cvVGVoeHl3UXZwRU1VVG9CWFdLVG9oNEo1bHQvdElybGV0?=
 =?utf-8?B?RVJLNUZ0YXVwWFdzQUo5S2grVkpzVEVSMkhkNEVlWUMwYy9qejlwZS9nTlJV?=
 =?utf-8?Q?dCfJLjXPtu0+/YuVOJ6LJwo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OVBvWXJkUWJLUzBjQ3RGR0VIY2ZKVGZVQmRJSHdRa0t4S2RuaURybkcrL0l5?=
 =?utf-8?B?NXR4L2dKV3FqRzN4ZGgvZWlOeldaV0xlQUpZNDE4VmExckVYa1Z1QnVzYjk3?=
 =?utf-8?B?ck05Q29pOUQ2ckNYQS9IcTBUSzBhM29sT09vUk5pR3FwNXQ3OWtTNUxzcTds?=
 =?utf-8?B?akNFUEpnV1dPSUhSQlVndnJ6Sk1MVWZiY1FIZndsUThLOVJCMWdtTU1XRjlp?=
 =?utf-8?B?dE0yUHhpZXdTeU8zdWhyaU5GNExLdDQ2SzNxYWlnNnVtSXNyaS9IbjEzWWEr?=
 =?utf-8?B?QThRQmVqM3NsQ3l5cWhhelR5QjM2cm5nWnljY0tsc3ljK3pvdVhMek4yZFZt?=
 =?utf-8?B?M21MN2JScWM4OUZEL0UweDgxV3d5TWxUZVhiOXd4Y04rLzQyc1hFQ0VIbEhC?=
 =?utf-8?B?STdoQWFIVEV5bFh4aW9yYTdrMHcxUzJxMnhIMmgwVUdSYXlSU3VDeHNmY0d0?=
 =?utf-8?B?ekRsQlZqNTh6a3NrREV3WGF1U1ZEU2ZwU1d0T0VNZmFQREtRbWtYQ2dmUW9Q?=
 =?utf-8?B?aFVFUU1Ybkw4bG9lN1FDckJtMjlCN2dmcTBGeE0wUnhJSDZIT2lRWDJJeGh6?=
 =?utf-8?B?ZkhhTEl5NHlVRDZwNmkyRDhUbnYybVRseTBWUU8zc3Z4b1BnaWp5dHVOU3VT?=
 =?utf-8?B?RkxqT2tzdm9Ubm5yR01yVzRCcVpqRWFLQUt4SE5TS0NaSmcyV0M5d1NNYXND?=
 =?utf-8?B?M09jRjBSSnI1eTJqZmZ2dm03UWp6N0lYamx1eUU1WVRyTW9zdEhnTEJRNVFK?=
 =?utf-8?B?cXVlZlhyVnEzMjlNVTRxYi91L2lZQ1N5aEdxYzlEZXVTRTM4SjdnRHB5RWNi?=
 =?utf-8?B?K2szSUpFTWEySUJ1dDJ6R0laK09McTJtdGExU3d0MC9WN2U1QU5YRm5iNmV4?=
 =?utf-8?B?UFF0cnlSMm5FUGhrSjZ3Tk1NcnRQSDZYelVtd3Ewc0hxM1JFUVFQbVhpekxW?=
 =?utf-8?B?YlpBT3dTbWpBZ3Bia242cHJWeGRzWE11NXB5Z0g4djVVMEVTUmJFamRoazl1?=
 =?utf-8?B?VERVWXFxZ24vOUdDZUVVNXBCd1FCT0pvYjFqMy9uMkdOV3FMSkpDMTN0eGpO?=
 =?utf-8?B?YlJIR0tsN1FxdVFKUkwvdnZDNnpLVUtRdkY5QTRKWkxwcGVVVHdURUpRZHpz?=
 =?utf-8?B?eWErbFRDOHJWalprS1E3akk4Y09oSXlrL1hiRHRJazVwREpSc3VCQ0ZmOTda?=
 =?utf-8?B?MjlZVllPRXAySDB6dzJNalJITWJ3b3hoMnNKSkVNRzZXY2tnUEJFMm9hczNq?=
 =?utf-8?B?dEYvblI5T3RTR1dLdlNnbVA4R3dpeWhBYXliTUtWazV4QVF2dlp4bVN5N0V4?=
 =?utf-8?B?SDVZNWFDdTNId3c2bEdIYkZQUHM1ZmZNdGt4b0N6WVZDV08waFpjVVV2Y2lZ?=
 =?utf-8?B?K25QRGNTaWIycGc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34de6c27-8566-4964-e3ae-08db70b820c6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 11:27:13.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjYJ1zyrjcZNxamXFnYz4GdIJHpAYYPJ9bgcNu0PVo0GEAuzy1PKgEZQQEqQii8IoqqO+xO74F7SOisN2A9mD54psiWOy7+wjjkI3unbCeBNKSv9yK/kazxp7fXq1XZH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=962 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306190103
X-Proofpoint-GUID: UaEDTebOJwK4EPFBCYczAL87is19K-Ah
X-Proofpoint-ORIG-GUID: UaEDTebOJwK4EPFBCYczAL87is19K-Ah
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 19/06/23 4:50 pm, Mark Brown wrote:
> Please delete unneeded context from mails when replying.  Doing this
> makes it much easier to find your reply in the message, helping ensure
> it won't be missed by people scrolling through the irrelevant quoted
> material.

Thanks for the suggestion. Will take care of this from next time.

Regards,
Harshit
