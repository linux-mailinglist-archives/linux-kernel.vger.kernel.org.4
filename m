Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D8F625E42
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiKKPWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiKKPWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:22:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FB37B21F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:22:10 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABFLZtM022216;
        Fri, 11 Nov 2022 15:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=v8GPJ906G5eXXdvLkBzune0HNnmvKcA4jrF3ti5JJKU=;
 b=edhzRZ86BrekzH/atiFrtY4mstxs3g0rmO+MSfr07iQt8/Mja7jV1Z/fUqGcRp7FZKa1
 stqvPBZMfKaosBu4EtCCiv6tXmCImv3/GM221lyMuNwpCepfjgRZ1Ja+zSecGxCIdBkV
 Q7+WaxR+H6FURO4bB6tCYcokuQmsSnqT/0zRKhCGgsjjT+UcE5T3qsAQ7rNcIil5oQtZ
 IC+0eOvh26TGonGIjVzF5VrlL9TdlK+TV7ZSTOuL4AKqb0j0dQ/dBecZnSTBp/hBRGiq
 yfa1UaJDZV5LrahkGOQfactWOUTQMsY3GHWMSGEyIhWlZQDOEoZDSV9vHwrb2GVliyD2 +w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksrjnr1ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 15:13:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABDWpTO022406;
        Fri, 11 Nov 2022 15:09:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcytev6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 15:09:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK6vlNq76EXoI+txTtxLiqlGTQQJP3xZUuJWc9GvhLPfFX/qgyX4AjuFpgLgbV3k04G7e0BuGpQt5SIpdxX8NSjoc49yxkHoG1PH6ZF/JNvLq48P1sLj1CMJ6Kn/xrzBc0RhhzuoRwtkSGj6l4sn3r3XEKCSfsY5MFAlC48gi9y3bIJ3CSkDl+KZnOXyUlxrddaua36xXEF2/y+K6sgwmuKDlzBH6ymewQcm4T3dqgKyze16/9iyumyV8DG0B4ULHVkeacolcOuDEiiQqANmP/NyxqBTstJcgIhL+L2cx/CXnXbyxM+/+BGUobFCf2LmjqiKZiiWp2HYlYd1XhGB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8GPJ906G5eXXdvLkBzune0HNnmvKcA4jrF3ti5JJKU=;
 b=aA0OK1GN3vmFPgu7lyefSYGvZm5PTj0o7B4YxvwDH7ANRD5AhjTH9MWwbe058z+ysUkvTwy7Nes8lC8MdaVNkOZLcsF5Ilv+f26NEE1P5wneofGlgwRgVPJ/Sm8iaHYldt/fWmRDM/UcjyT2TlmNjcHM7OcX2kmmT5Puhk2BP2pTHmBJ+VeV6d/HIGdLjb6zMKfI+3wEHGi02I4fVPU9tKsaN8UOcuYbgl+FWZKf/LoQNHnIEf5Hnfx0CpSTWb/P3dJ8sSqQiTmyX1kLfmRP71MrykeYJnA1/qAI6Rmr8uoOBgJr/feTzVlXnWQ/kvclCHMSUWhvVSRsZzSkjLGBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8GPJ906G5eXXdvLkBzune0HNnmvKcA4jrF3ti5JJKU=;
 b=q5xu9ziJX8jB/DgZOv6ZeJyNW14kcbZTJA5Vdg+22cNKlP6QEZ5OlfwLx41WqkRgTKTRSjKm71RtX2e3J/tJ8bCyc1XqdP4DMWzUV84B+tPnwtq2nSqVx8GfmTcR+j41Kztk3/pvRTGrqTjMx8kQxEkDVd+XdH/LoGQmjEVlynA=
Received: from BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12; Fri, 11 Nov 2022 15:09:37 +0000
Received: from BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::267a:b63c:66d6:e671]) by BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::267a:b63c:66d6:e671%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 15:09:37 +0000
From:   Darren Kenny <darren.kenny@oracle.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        harshit.m.mogalapalli@gmail.com,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC] iommu/vt-d: set default value of INTEL_IOMMU_FLOPPY_WA to n
In-Reply-To: <370142aa-8eae-8424-826d-c1fc21e4ea0f@arm.com>
References: <20221108125855.2984751-1-harshit.m.mogalapalli@oracle.com>
 <dc463b3e-2875-8aac-aca1-edacb90e5650@linux.intel.com>
 <76cbad17-ab5e-3dd9-cf94-df2b26748167@oracle.com>
 <3a7f5cdf-640b-f9d4-a25e-8be845abd7ba@linux.intel.com>
 <Y2wK6kWHE1iah/IG@char.us.oracle.com>
 <0f1ad424-18b0-c27f-dbf6-745801182bd2@linux.intel.com>
 <Y21mitQsO2RG652t@char.us.oracle.com>
 <e03aaca5-b62d-451c-85e0-53c28e8eea82@linux.intel.com>
 <370142aa-8eae-8424-826d-c1fc21e4ea0f@arm.com>
Date:   Fri, 11 Nov 2022 15:09:33 +0000
Message-ID: <m2fsepedea.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DB9PR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::12) To BLAPR10MB5138.namprd10.prod.outlook.com
 (2603:10b6:208:322::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5138:EE_|DM4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 9910f82e-ec08-49e3-1406-08dac3f6bfcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9r9hzIfVnKeExmm62Zmr8b6S5Q4v5pf4jAMfmK7vUTp001nQaZjUpNj19p1+pL3dIyBFJueqHKedpDHUL6px2q9Xg+vP0ir2/eah7039fm4Dlx51OdavnTBxd4Anbr9eMDsOzbk4q6Tr4oMBcoXcITHSH0crgdyQLpp72EIjjENHI7HtV+8AoLuvM3o1n2O5u/E1cr77E8aOvQ8A4K2pnLv8pFaHyWYgG94FImr6GOnVrajQ/pPwWYNHmVxIeOZsP7/229UewD+RCx4gsBLKfGKPp5/PTlsQ5Kc8sJSCpZYD0LNY1VWxTHyzk9wZS81G1s0s61XCh7wM7jc0t8W2txt9JXgHc/voBFN6Ry4MmGO07JbBufx3NiAP0HB15DnOG3HCETsuTrfSyh9xdj4ohvhVfaSgZ1PkUdhkYvWzMdCvEXFDoPsBOMaX7r+bnMaox8huT6alqPkBWSMpXaCx3QgqnHwdGbvYdKQAAt50TqfqbKttApudVRh+4vh8Nr5QQgmMrEvALvrVbjQzWaxZb/e6dasOuHzKZEtMUIGRc94guC4ogd/3V47WKB80du1pcrt7bTKU7YDK4onA6Vg49jm5aMlSjPKjfoNh7oQJ079hp3ogbeeorCjlvgMbI68wasyzowPYjHU9mZSSL71GqAsXkZwtpStoKaSuRGZH9J/+9s3qJgMMJaFPr+K/RmThc/s6LdF72Ji3DjWpQgsyrxwvbrjonTcwSxIlqnaQL5xSPDEknXKReKlVYBF14UAy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5138.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199015)(8936002)(86362001)(6636002)(66946007)(110136005)(54906003)(5660300002)(41300700001)(2616005)(4001150100001)(38100700002)(478600001)(2906002)(6486002)(44832011)(6512007)(36756003)(6506007)(53546011)(8676002)(26005)(66476007)(4326008)(66556008)(316002)(83380400001)(186003)(6666004)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk1tU1MxWm84eHA3RVFmTGdRQ2hVQ3Nrd0FpZG93Nlh2UkJDdStER3pyQk42?=
 =?utf-8?B?NURSQ0FIRGFsMWJ2a0xMQzJaZjhJMHd5ZzRLODdlWmFCVDY4U044dkpNeGZr?=
 =?utf-8?B?RHVNQ3JNeFZLUlI2ekh5S1MzOVFiT3RFbnZoWlFOK0g1VXBHZExKeHFFbXl5?=
 =?utf-8?B?aDE0OWxlanNXRy83NlNWbXZFT0ZhZElhS0dSaXpET1Q5ZHhJRFhmRGhIU0ty?=
 =?utf-8?B?R2VTR3V0ZU9HYUF5Rlh2eWZDcU1EK01ta2dDWFpTUWxoQ3VuUTgvdHZESVlt?=
 =?utf-8?B?ckxuaWcvcm9KdkRvRXpINmJNUnRscm9uSUh5UTJBM2d4Q1RmcFBOL0FINy9W?=
 =?utf-8?B?L2hUMUhTcHRrWEgrUUVZZ2QydERwWTY2cnM0ZW4rUUNUUEtRampKdG5FSnMw?=
 =?utf-8?B?SzJLa3NDZWZWK1V4ZWl6d0NmdGJSTUxxaWRMS004aEVISFNqNUhHNFRvRzFB?=
 =?utf-8?B?dWtjcWhNTCtFbUJqRGNueitrSHFxcGlQN1ZmWGloK1IyR2FJSGkzcTNFWXZq?=
 =?utf-8?B?cDBtcS8waTJiaUl4NVVpdnlUWHl4eWJtMnRxMlFiNDMyTERqcks2eWwzWDVS?=
 =?utf-8?B?UFduam9SdzQ4ZnFLV0pCclVIQ01DSGZpejA1dDh2WUg2dTd0eDN6OWVpQmZI?=
 =?utf-8?B?bnFJOGYwdUVkUXJyZ3FMZjgzVHNHVHVpT00xUmFjMk5lQnBIcnlBMUlQZVUy?=
 =?utf-8?B?NDU1cU5YRE9tODZJZXUzakRKZ3dGcG8yOSs2Q2xOVXhPbFEvWWxnelNCS0dR?=
 =?utf-8?B?a0VuN1pvZVEyQUNzY3ZEUzRGR3dRaEpxaXp0dlE0T082UWtjSWdTaHNTdXdw?=
 =?utf-8?B?VVBKTUowVnVqczJubmxTbGIvMVo0aDlGVU44S0lFYUlkSTlOSzVPaTlTZ1Fw?=
 =?utf-8?B?OTZVOFZYa3hITk5Sb1NEeDJlZVlvQjRTSU16T0VnaTlqNkNuSXJqbEUxdFM5?=
 =?utf-8?B?VWVkMVJmOWszVWIxMCtMWXR4UllFT0Y5THZUWlNYSGtQL2JiMXZXSFo1YUJB?=
 =?utf-8?B?M1FjbTNWN2lhWUNKQkE3NjlNTmJiQm5XcW5Qa3lPWkc3UFpiWnJxZFZyUlJZ?=
 =?utf-8?B?dFBWcGVQZ3VDaElSdWhZak5RaUNRYjNXeEJxNXZiSzFtaXVaOHJvMUVWQW5Q?=
 =?utf-8?B?OHBhbjUvNk8ydDRIS1p3MkdoZVVsVUhvbWVUM00xVmtzSXlWL2cyUnhHbWVS?=
 =?utf-8?B?NmZlZnp3bW5xM0d6RCt1Snl3WGNaSVp6aDZScElSNkRxUVN0TWJnV0tKMThx?=
 =?utf-8?B?RGxZdjc4QVdwSGwrY2lDcFpKc2FNdzNOd1F4aVhpYVRqOFR6amZYSklzRjBr?=
 =?utf-8?B?TmdlZ0g5TzFUcFRXeFFDSUJtZmlWSlJyOVdROHIwZG1VNW5xMnEyZTFud0RO?=
 =?utf-8?B?L0tFUThDd3ZBOWd0bkliN2lZSUJybzVpVEpwS28vN2RLTm1rYlpNTC9oRkRu?=
 =?utf-8?B?dmxrQjJhaWdTclM4R1hGdFZCMkVQM0V3blZsSkN2T0ZtUGNXekwyOTh2azFO?=
 =?utf-8?B?U3hMOU5qdVFZV0RCSFFlRjlsYnYwbzVjWW1ObmlGMHI4bFVuUmF3Y0ltQldX?=
 =?utf-8?B?Y2pGRXFxOEZwOHI5Y3craGdUOGtzbi81V2dHOVpPRlNNVFFvclBqbTVLTUhY?=
 =?utf-8?B?TFBRcjRCZzMzWG1pa3IvVUFZNUE5aHVGYjNDUkNraURWK05OMjcvWncyS3pC?=
 =?utf-8?B?RzJnVUtHYmlLekxyemNSYmR3TyttRzlrNnkzQzZoTURKNGFvOUs2WTNNVjEw?=
 =?utf-8?B?c1BOMXRpZEVubFQzek5CMjBlK2p3WU0xL085ejJKbFZKUzhGV1FtODdURlhZ?=
 =?utf-8?B?Qk1PWVh3SDN4b254ZjBwY3YxNDlZeVRRYktHdXYzRmtOZkxzYy9ONSs0b3My?=
 =?utf-8?B?REE2OHg2eDVtajFwTnVabHBkdG5oeVBLZlhIeXpxNE41bmdYN3lIQ3FaTjJy?=
 =?utf-8?B?NU9aZHFTNWdLSDM5NGZHK1gyNHY1Z1lka2ErQTNVcWpaSVI5clJHWSsrTFpk?=
 =?utf-8?B?SDdHeHJ1alZwQSsrZGNUamhRNUJVbXgrTzNnL1lVdHQwb09EUmdUWGRWa0hG?=
 =?utf-8?B?L29xTlJSVWNqc3ZSRU9QRE9SSWJIT2paWHpkTFNJc0YyVTRBR1pFckcrd2c3?=
 =?utf-8?Q?D/7b8VDXIqEuJvr2sGUR7pnDt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QUJiZzM2bGw1c3FKYlNxaVU3dFpmNmdNdmFGcWVGN05PYXg2TEVuMGtRb3Bu?=
 =?utf-8?B?TStPTlAxa21GcFc3SUppZUg1OU1tUkluVDExdUM1NzdIT0ltbUhsMHNFamVB?=
 =?utf-8?B?MzlGajFuZkg4SnVtUzdPRXlPNGlwQW1idlN2MHNKeGlhd1NMNWZ4aHV1T1FS?=
 =?utf-8?B?NWFHSlZyVzh1YTE5bzRqVElzUDdQc0hCTm1sakY3dUVrSHNDRXRqSGVjL2Nu?=
 =?utf-8?B?TWxXaHIrZnZHSVpJVmdMUUEva2pvdmlveUpTVmQvRHN3ZGF0alloZDJkQmN1?=
 =?utf-8?B?Tjl6Z0tNUDIzSGxLZ1Y1VkNTTzcxd29yY1NCY1VUWk43dmM5QUtmM2xkaERJ?=
 =?utf-8?B?Y3AxWlpjdmxuWS85U2pSK0VVblBvREswdFVCMEozd3BMTWEyNUxrdUZHRWRI?=
 =?utf-8?B?aEphVSsrd2ljazQ2ZUFMYTNwTUlHd2xOeTdTNnI5RUlWenl1Q0QzcERZUkp2?=
 =?utf-8?B?ZzcyMVBLWEdGMkhtSCtzbzU3T3ZmK1I0NUFKZS9HeERiTzNZNEpWaWJzU2pu?=
 =?utf-8?B?YlhGbnBPckgxd0Z2TVRJZ3hGamdXai9wdUxHcXIvMVh2SkJ2NUE5TFBLellZ?=
 =?utf-8?B?MFhtQWtqNVU1TzFXcW1Pemd6b3RERm1adUFXQ2E4VzdzSk0vcndsWjZSekNs?=
 =?utf-8?B?eTY4MXlSeWlEbGpZaEI4MmwxbTdscW9PTUQ1bndMNWVtNCtadVFTK2lGcUdo?=
 =?utf-8?B?UEhVTjlDbG5SY2dSUmJVYkZ4eGtmNEJ6dkdQQ25ZOUZsaktOMENoWEZFbHMz?=
 =?utf-8?B?VDVPcytRWGZsblJvQ0p4VnE4RHlobHdja3BIWlU3OTVXSS9DcXhOVGQxOTA4?=
 =?utf-8?B?UXViUktaWUtzUm9nL2NKZ2pLM2J4ejVvUkRnTHRXVEJxWFVEZXNPNTJiYXhu?=
 =?utf-8?B?RXAvOGQ5aDR0ZnFvL2Y2TGV1cmdUd3c5WEN5dWpJNVVmVG5zTTlxbUp4UUt0?=
 =?utf-8?B?anBYVFhTd01PTG5Wd09wWXNhb05XdHJXNDdzaWJCYUI5TklXb2NOZktZRlNh?=
 =?utf-8?B?OVA2eUVVdUg5WjVrK1VsUkYwVE9zVzBMQXdmUUd5VXBmZ1JCTEQrUmF4V3h1?=
 =?utf-8?B?eHJhc1NGNExmcDEzYlV6aEMvWWpMY0xIKzdJc1ZTaTE3OHZkVlU2RmwxQitY?=
 =?utf-8?B?VlFwNEUzMGl2emJDcjhzSk9vTFFjQnhMQUZPU2ZENWdnZGMzTTY3bXIvZFFT?=
 =?utf-8?B?MlFkTlJVb3h0aXY1R0J1VmtzVGJLWUVyVVZ5TjlTaXZlNHBVVmhlZlh2WGlH?=
 =?utf-8?B?Y3drRlRGNzQ1VGJaQStuV3VmSzU0bFNhOUpwdDNvRzN0ZmcraVFvRmFFVDdS?=
 =?utf-8?Q?VNt43cRxMfOBc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9910f82e-ec08-49e3-1406-08dac3f6bfcd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5138.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 15:09:37.5636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4e6HhIzow46xsk1ESlbIxl3sC3aA8TOo97Q4ajxsQrefSKBiJPOb5nAPA51LdOVpQoCkU+w+yAH2Ta6T1gfaxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110101
X-Proofpoint-ORIG-GUID: p456Cj4ojsC4-wueAyXY0noPAvzL12sv
X-Proofpoint-GUID: p456Cj4ojsC4-wueAyXY0noPAvzL12sv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 2022-11-11 at 12:36:48 UTC, Robin Murphy wrote:
> On 2022-11-11 02:31, Baolu Lu wrote:
>> On 2022/11/11 5:00, Konrad Rzeszutek Wilk wrote:
>>> On Thu, Nov 10, 2022 at 02:39:53PM +0800, Baolu Lu wrote:
>>>> On 2022/11/10 4:17, Konrad Rzeszutek Wilk wrote:
>>>>> On Wed, Nov 09, 2022 at 09:16:53PM +0800, Baolu Lu wrote:
>>>>>> On 2022/11/9 20:16, Harshit Mogalapalli wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 09/11/22 12:35 pm, Baolu Lu wrote:
>>>>>>>> On 2022/11/8 20:58, Harshit Mogalapalli wrote:
>>>>>>>>> It is likely that modern intel motherboard will not ship with a
>>>>>>>>> floppy connection anymore, so let us disable it by default, as it
>>>>>>>>> gets turned on when we do a make defconfig.
>>>>>>>>>
>>>>>>>>> Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>>>>>>> Signed-off-by: Harshit Mogalapalli=20
>>>>>>>>> <harshit.m.mogalapalli@oracle.com>
>>>>>>>>> ---
>>>>>>>>> =C2=A0 =C2=A0 drivers/iommu/intel/Kconfig | 2 +-
>>>>>>>>> =C2=A0 =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/iommu/intel/Kconfig=20
>>>>>>>>> b/drivers/iommu/intel/Kconfig
>>>>>>>>> index b7dff5092fd2..c783ae85ca9b 100644
>>>>>>>>> --- a/drivers/iommu/intel/Kconfig
>>>>>>>>> +++ b/drivers/iommu/intel/Kconfig
>>>>>>>>> @@ -76,7 +76,7 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 option is remov=
ed in the 2.6.32 kernel.
>>>>>>>>> =C2=A0 =C2=A0 config INTEL_IOMMU_FLOPPY_WA
>>>>>>>>> -=C2=A0=C2=A0=C2=A0 def_bool y
>>>>>>>>> +=C2=A0=C2=A0=C2=A0 def_bool n
>>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on X86
>>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Floppy disk dri=
vers are known to bypass DMA API calls
>>>>>>>>
>>>>>>>> Nobody selects or depends on this. How about removing this bool?=20
>>>>>>>> Only
>>>>>>>> less than 10 lines of code are impacted and are not in any=20
>>>>>>>> performance
>>>>>>>> path.
>>>>>>>>
>>>>>>>> diff --git a/drivers/iommu/intel/Kconfig=20
>>>>>>>> b/drivers/iommu/intel/Kconfig
>>>>>>>> index b7dff5092fd2..5e077d1c5f5d 100644
>>>>>>>> --- a/drivers/iommu/intel/Kconfig
>>>>>>>> +++ b/drivers/iommu/intel/Kconfig
>>>>>>>> @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to use physical =
addresses for DMA, at least until this
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 option is remove=
d in the 2.6.32 kernel.
>>>>>>>>
>>>>>>>> -config INTEL_IOMMU_FLOPPY_WA
>>>>>>>> -=C2=A0=C2=A0=C2=A0 def_bool y
>>>>>>>> -=C2=A0=C2=A0=C2=A0 depends on X86
>>>>>>>> -=C2=A0=C2=A0=C2=A0 help
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Floppy disk drivers are known to b=
ypass DMA API calls
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thereby failing to work when IOMMU=
 is enabled. This
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 workaround will setup a 1:1 mappin=
g for the first
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16MiB to make floppy (an ISA devic=
e) work.
>>>>>>>> -
>>>>>>>> =C2=A0 =C2=A0=C2=A0config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Enable Intel IOMMU sca=
lable mode by default"
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y
>>>>>>>> diff --git a/drivers/iommu/intel/iommu.c=20
>>>>>>>> b/drivers/iommu/intel/iommu.c
>>>>>>>> index 48cdcd0a5cf3..22801850f339 100644
>>>>>>>> --- a/drivers/iommu/intel/iommu.c
>>>>>>>> +++ b/drivers/iommu/intel/iommu.c
>>>>>>>> @@ -4567,7 +4567,6 @@ static void
>>>>>>>> intel_iommu_get_resv_regions(struct device *device,
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_unlock();
>>>>>>>>
>>>>>>>> -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev_is_pci(device)) {
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct pci_dev *pdev =3D to_pci_dev(device);
>>>>>>>>
>>>>>>>> @@ -4579,7 +4578,6 @@ static void
>>>>>>>> intel_iommu_get_resv_regions(struct device *device,
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add_tail(&reg->list, hea=
d);
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>> -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
>>>>>>>>
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D iommu_alloc_resv_reg=
ion(IOAPIC_RANGE_START,
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
>>>>>>>>
>>>>>>>
>>>>>>> Hi Baolu,
>>>>>>>
>>>>>>> I have a question:
>>>>>>> Shouldn't we remove the code between ifdef-endif statements?
>>>>>>>
>>>>>>> I mean something like this:
>>>>>>>
>>>>>>> diff --git a/drivers/iommu/intel/Kconfig=20
>>>>>>> b/drivers/iommu/intel/Kconfig
>>>>>>> index b7dff5092fd2..5e077d1c5f5d 100644
>>>>>>> --- a/drivers/iommu/intel/Kconfig
>>>>>>> +++ b/drivers/iommu/intel/Kconfig
>>>>>>> @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>>>>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 to use physical addresses for DMA, at least until this
>>>>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 option is removed in the 2.6.32 kernel.
>>>>>>>
>>>>>>> -config INTEL_IOMMU_FLOPPY_WA
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def_bool y
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on X86
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Floppy disk drive=
rs are known to bypass DMA API calls
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thereby failing t=
o work when IOMMU is enabled. This
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 workaround will s=
etup a 1:1 mapping for the first
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16MiB to make flo=
ppy (an ISA device) work.
>>>>>>> -
>>>>>>> =C2=A0=C2=A0 =C2=A0config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>>>>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Enabl=
e Intel IOMMU scalable mode by default"
>>>>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y
>>>>>>> diff --git a/drivers/iommu/intel/iommu.c=20
>>>>>>> b/drivers/iommu/intel/iommu.c
>>>>>>> index 48cdcd0a5cf3..2c416ad3204e 100644
>>>>>>> --- a/drivers/iommu/intel/iommu.c
>>>>>>> +++ b/drivers/iommu/intel/iommu.c
>>>>>>> @@ -4567,20 +4567,6 @@ static void=20
>>>>>>> intel_iommu_get_resv_regions(struct
>>>>>>> device *device,
>>>>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_un=
lock();
>>>>>>>
>>>>>>> -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev_is_pci(device)) {
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct pci_dev *pdev =3D to_pci_dev(device);
>>>>>>> -
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if ((pdev->class >> 8) =3D=3D PCI_CLASS_BRIDGE_ISA) {
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D =
iommu_alloc_resv_region(0, 1UL <<=20
>>>>>>> 24, prot,
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 IOMMU_RESV_DIRECT_RELAXABLE,
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 GFP_KERNEL);
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (reg)
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add_tail(&reg->list, head);
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>> -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
>>>>>>> -
>>>>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D iom=
mu_alloc_resv_region(IOAPIC_RANGE_START,
>>>>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 IOAPIC_RANGE_END -
>>>>>>> IOAPIC_RANGE_START + 1,
>>>>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0, IOMMU_RESV_MSI,=20
>>>>>>> GFP_KERNEL);
>>>>>>>
>>>>>>> This code is introduced in Commit d850c2ee5fe2 ("iommu/vt-d:=20
>>>>>>> Expose ISA
>>>>>>> direct mapping region via iommu_get_resv_regions")
>>>>>>
>>>>>> As long as floppy driver exists in the tree, we have to include abov=
e
>>>>>> code. Otherwise, floppy drivers don't work. At least we can easily=20
>>>>>> find
>>>>>> drivers/block/floppy.c which is still maintained (check=20
>>>>>> MAINTAINERS).:-)
>>>>>
>>>>> But this requires a machine with Intel IOMMU and ISA:
>>>>>
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16MiB to make floppy (an ISA devic=
e) work.
>>>>>
>>>>> ISA device? I don't believe there are any Intel machines with an IOMM=
U
>>>>> and an ISA device?
>>>>
>>>> This workaround was introduced by commit 49a0429e53f2 ("Intel IOMMU:
>>>> Iommu floppy workaround") in 2007. I can't remember what happened 15
>>>> years ago, but I believe there must have been corresponding hardware
>>>> configurations at that time, and the Linux kernel has been maintained =
it
>>>> to now.
>>>
>>> At what point can this be removed then?
>>=20
>> No floppy block drivers in the tree or all floppy drivers' DMA going
>> through the kernel DMA APIs.
>
> Presumably the point of the config is that ISA bridges aren't expected=20
> on IA-64, so a tiny code saving can be made there, but at this point is=20
> anyone really that bothered about any more? There's already tons more=20
> code all through the driver to support newer features that aren't=20
> meaningful to old IA-64 hardware, so in my opinion, meh. Given that this=
=20
> already won't affect systems that truly can't have any ISA devices, I=20
> don't see any issue with simply making it unconditional.
>
> Note that plenty of chipsets still have an "ISA" bridge to an LPC=20
> interface, so ISA DMA is not necessarily as dead as one might like to thi=
nk.
>

Based on what you're saying then, the fix that you agree with is what Baolu
first suggested, which is to remove it from Kconfig and just remove the
#ifdef/#endif, but not the code that it contains.

Is that correct?

Thanks,

Darren.
