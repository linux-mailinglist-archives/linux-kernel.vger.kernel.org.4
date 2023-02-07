Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7A968DED5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjBGRYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGRYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:24:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D3010A9B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:24:46 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317Gmf4E023986;
        Tue, 7 Feb 2023 17:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cc33SqX7ouX3qN9kolw5NnlQkRgnhkj8IT6QRSxYwik=;
 b=g5xVgVBWYNfDTnvalSexar7JhtlJD5xMbH9szgxrcCqR5r3rYy7iszDwSbXTHUhh8Xw6
 njQQQHmA9rYOilY6ETartCk1V+bcakAlgYMaxFqa/BdbfzDUHj4fsHYlKqLciR+vw2/K
 SMKqAy/K0N8MDiuNzF4bcAheyI/c8SPFTaefUMU3cINaic68qaRl3l7pQH5Gte/+DLWS
 OrJNYH+1dIbuUpgb2nW6qrLI2FAP40oUT+qwMVHHMeBYVUEV2OgJIu2auwYjnCk41fOe
 m2PkUrxR94RiUGgANe4NP8f3esnho95LcfN3srzA9s0rjHyCfpk4VzNhidLxIIM4VBD1 bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdp6c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:24:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 317GVH1b025030;
        Tue, 7 Feb 2023 17:24:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbafunr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:24:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAC9jzwBEnCg/mxMlWhCgMwS18peU2CwyY8klUQ83O6JK5JJXBwBfPtFjpP81IB9Qa02lQEzS/JEtnMvw4W17nBqQk6PTJXYg0eNp0JykXBdmssV9ULzVG67bv7E74Rplw5FA70aV61MVRBwQeL/sHmfLEnlZoME9HMP+Ke1129rk4RZ1Pxp799HraNRMFBlObTtwZxSIIe7lKo4ipYdGQ86N+Z6FZ8+Qzw+bFxnJGsejJD2KMxz4eq8Oce2R+SCcyQV9IUvDcEvK97/dzUj3lIlA6qeUIIDHVmtc1mK7/4bIPtiihDo3hPQcWS/bd0dEDzdEscGpIgFFLMiPVVIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cc33SqX7ouX3qN9kolw5NnlQkRgnhkj8IT6QRSxYwik=;
 b=Vp/5sWik7WFOBibjgURkY1DRBVuIS8zmId5DOL4C/YzjzLV8gG5ONuBOllZkqyQ1NCRpqWo08N6ezxQxrMKnIaC/PoEegTKngS3Z5nXyriOIfbxhAvoEXb39OqHo+jdGrCcxvYqLT+EGo59B58VKCy1dsxQZ7AM5x8bhCopp7/Hi0KNS2XgPTxy+R9nJZzA9JhUb3a4f72HbOToDdXcQ4m4qest19kdBXvrphsGXbJ6fPz4cq95p4cNHuGMP83qU+rPaSx5qUcz9j12jfeW5EJaW3RPw+clKxNQA7odyAXlMPS5La9pBsebFzd64EreA/sbuQLi0TNIwlgywgXBRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cc33SqX7ouX3qN9kolw5NnlQkRgnhkj8IT6QRSxYwik=;
 b=b+mIzRz1S1diaAymMfai/Dl4mIPycJefHmTk0UH13zZoGbZhwAtE2BeLFpHbtiWCXjvhgnVvvs9UEVzwYxZ0BK9GEnAVjpf0lVsGFnIkY/wsO7FZDvHojonx35+vMHD7OewzE8JjbB8EIoU7VqFNNofy3bMlAINacl0j3H7ezIs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB5820.namprd10.prod.outlook.com (2603:10b6:510:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.11; Tue, 7 Feb
 2023 17:24:11 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%5]) with mapi id 15.20.6086.015; Tue, 7 Feb 2023
 17:24:05 +0000
Message-ID: <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com>
Date:   Tue, 7 Feb 2023 11:23:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <87sffpzkle.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 485fc10b-fc75-43ca-25a3-08db09301ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbUt4WBEiEMn2O0Sh79a0chDQRnp/hJb94C8OuJpO5x7lhbRmej5b5wR9aC0nGgq8vI14CiLfDYmuVRzEzI4+TixHazDqGlAt4XftvOiV+BnP8ex1Ul/Iklq/AXM8aY62BybWRHAZgIhq2pWG+YQ931mPr8uqGwPp+F1XAmkyK4l4XTyWmuIyrDoZiSBaU+FvqIvBOTkir498CZRirH/d/SPW35yzWmrptdgZS5/QuQ1+YWO1xTQJ32eCuMlYrFCh2XkOGnU1QBbuw1boYgUrkTApY3kAz/eRvIUBi9SlVZ2pPT3uTW35nZTbnmg/LPY7oPelM2rZoXeEWGZT1IygL6OfrsuI3CfgyfP+AlKmZd2sE3phd5I/uYofBHqncnrb0/9RUfT+ZMQRh6lUp+zE+tS0yaIkUIkeSRCwugebmOTDDT62b7MXF/HxHRiRZMdBz711StZROVjqQ4TGaCZeyUvprM+sxj1nxNtPq17/oF+jbmqhABQjmkgRGYvu48fjUAvYCG3DfTas0shniCuaAzh8ueGHbqde2vqQ76YpGB25OkQ610TClnV8GTx6Y9cc0OUwAQU1CsQcHD058OK5jn9eFAirQDuU8rz4X27bZLhtfY+N5rhAxbwY+OGPNUGGkcj8Z6Zyxkp0SnanuzTP1aohyB3QgzTyN1eTATTvOhJi3YHquoVAUllSBPSRevSjB1gZsNgJ+GPTs/8hr4nRg9DptUtbVGEa7lByFI9rOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199018)(38100700002)(36756003)(6506007)(6666004)(107886003)(6512007)(86362001)(186003)(53546011)(2616005)(2906002)(6486002)(83380400001)(478600001)(66946007)(8936002)(4326008)(31696002)(8676002)(31686004)(41300700001)(66556008)(66476007)(7416002)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzRNaVY2UmtPZXJsRXlzUTFOSWg3Z3h6amNPWmlybUxlM3NOZ1lqK1BQQnRN?=
 =?utf-8?B?TmVJRHlEQUtLZ2cxaUM4Q1VUT0RHKzh6M0pOQjRodnMzUVpMeHZSeUlmcHJl?=
 =?utf-8?B?RzhsdkNHMFJSa0pvclBLTm90eHJBWGpVQ0pzcFpPQ0hyZlNJRndXZVVOQ2pw?=
 =?utf-8?B?K2RSd3k1SFk0OEN5MHFIY3RpWTZZOUNicGx5clUzQjJiT0oyYkcvbzB2azF0?=
 =?utf-8?B?M08rbW9veVhaSWJocXl0cTRUa01pQnRUTy9YT2FFbWVUb2RnWXpmR0FONks4?=
 =?utf-8?B?Z0ZWdVlWQ2tmS3JGUzZSZ2Z3Z2xWcUdGVTJmb2RpWFRwVXlIOWJmTC9pUWtm?=
 =?utf-8?B?dm5JYU1nakxEY1h6eXdveWFIdUZ0Q1Y0OHY1cWpXRWo0T2FReWxnakpCWlVN?=
 =?utf-8?B?T3NjYVlZSVJsSVFOcSs4SFQ2OGVqNFVGNnFGTTkrY0oxczFXVHJ6dXRtUkRQ?=
 =?utf-8?B?RURQSGo1OFkwMVRodCsxN1cvdG9nNENuUmlzNjNBWExOYTJ0VVU1RlZRc3k5?=
 =?utf-8?B?RXhLbFZ1Wi90TFN3eHNPWkF0Qy9hUUJ0dlFweXpEb1NEcTFhb0xOSjBWSktn?=
 =?utf-8?B?ZGNTa250Z3JlMEIxaUhPc3NNWGJwOTNLSnNkUll1T2lIWXlqVVBveG9ib3A5?=
 =?utf-8?B?TlJtRkR4TndwWW5YZjNCYzFyamJhejBzaUswa3BRNjQwanQrUzVpc1dtYXdl?=
 =?utf-8?B?aDdyaHI0RFJsMWI0RU4zZE9nb0c3dmR6TVVSeXhaOEFEdU94cGY3Sit0OUtC?=
 =?utf-8?B?R0hobkZsQXhPd1dzMXYveVlpZnBmK1RscFBiUGlaLzFqTFR6U1BWbUkzUUdX?=
 =?utf-8?B?Q0Y4OXdhUjdGRk5WQlVzT1l0b3V5dTl6cEcwcUtlUXB3Z1RMRUhSaDBsaEd5?=
 =?utf-8?B?TnUwSFhweEczNmsvVmpkblcyTXZDU2N4VXRqb3lrbDV4VkhoN0ZELzMxNTZC?=
 =?utf-8?B?RWZpUFpSd0VLQ2pJbjRWSzk2UFJ2T0NOak1idEVOb1p6VFNrNnYyNHpxZWps?=
 =?utf-8?B?cHlPYmdzNUVsVmpuV2lVQzZtTmwrdXkxSE5zZFJSNm0zTGk5NUZFZTk1UTBY?=
 =?utf-8?B?MWxUOVRuUUttK2Z4RmNqSkRreFlUcGNqRzVYS1NCdlV6OTJPNnZWbWdWQUxp?=
 =?utf-8?B?a24wR0twbVhrdHJmL1FGdmwyQ0tmby9hditKQk0yaFNVeFJBaFNGa1JOQms2?=
 =?utf-8?B?dGkxUk44ZnY3RUliUTYraCt6ckZMQm5QekVIYWd0NG55ZWNMb29lQlRFU0o3?=
 =?utf-8?B?NU9DNEVOYml0cFdySDVOT2VqeUFHbVIzbnVKbHhPTjdBbUY4d0p1NlpRbFkw?=
 =?utf-8?B?Z1NYenRWalVuOVIzVkVWeHpyR3FNMjhJUlR1YjFRV0hMS3QxQ0VsWUpraGQw?=
 =?utf-8?B?dm1janBCTkM3QUdQQnMxRTB4V21Gc3AzaWplc1RFT0IxT29mVUNIR2xVYk9l?=
 =?utf-8?B?QmtFWGVRdDBLbDhyeFhFS0Y0NURlb213ZC9JcHFQUC9uYVlhUndRT0wzSXNS?=
 =?utf-8?B?TEtSclAxWmFVc0JxK091czNqNUc5MHpqVDliZFBxdmc1OXVLUDVCOWY1OTRR?=
 =?utf-8?B?dzFuYUhkUkpFUjgxMEQ1TElHYkZDNVZFalhUNUZ3R2hEM053bHR5OEZJL1hC?=
 =?utf-8?B?a2RXOVM3eWhPeW9WQXRqWHJWL2RyTWVWWm1iQjBycGVmVlZNRXZjT0Yzb3ZC?=
 =?utf-8?B?ZXRlZC9FVit2d3JGNlJmZGtMZ0QrQ3YzRENCMmRwUE4yNTJydkNaaDBSUWt6?=
 =?utf-8?B?RGllT2Q3d1ZmaTQ5OFc4OG9zM3EwdENMcGo5WGZIaml2UGoxaGhlaDJHUXpu?=
 =?utf-8?B?Ly95YnN3MzkxYWgybWpITjBOaHcwMVBEUm1JdVlnclNQSXE1UXhpaDIwdjFM?=
 =?utf-8?B?K2pFRnhmbDhZNk5BdXAyb01JRWFHVTN5YnJiNVZVU2ZXZVd2Z2RobjIzWU4v?=
 =?utf-8?B?ZW5LSFlYRFVqS0hkWnBSdFBxaEFLZXA3M1lMZ3NsU0I5K3BWbmgwOWdaeFg5?=
 =?utf-8?B?ZmVZZzVTRjd2WWg2TDZhc1FRZXh4WlEyVVhyenlwT1FHUmpuZVNKUTduMktN?=
 =?utf-8?B?US95UXMreG9laGZYNllwL1BtNG1Sek1HdU9XWGxBdnh3S1B0TTUxK1pYcGEr?=
 =?utf-8?B?by8vczdVd0R2Mm1Yc3o1QVJRM25lcC94bDVsbDlRTElPdnVZQWNGWDVRbnM3?=
 =?utf-8?Q?ZHbWrFv+a53cfJtlFaf5eTA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TGY2N1dtK29WbGJEeHd3dlBCUkRJVzlCckorcE9Ic0Vwa2E1TWtyOElEREwz?=
 =?utf-8?B?WW5XZVovNlYyOWczK3h5Tk5yblZvd1JzTnc4WHg4N21aZzVpTktGMEFldlBx?=
 =?utf-8?B?c21xOWZVcTNLalViRlRjbktCQ0k3MXhKTWIvK0tMaHAzY0ZkV3JsSkx3ZW4w?=
 =?utf-8?B?eDhUZkVscjUzaUl4NmZGVU1EN3BPcE5mSE4xQjVWWjkvVi83V2t1bDNDbGQw?=
 =?utf-8?B?MnEzbTRiZ1hQS2xFVnU0SlREWFdMNXduUER1STJ1akxnWDJlWEh2UTUvdUVF?=
 =?utf-8?B?TERrU1h4WmMzU0paYlp2NFZRelZFTFRsY0k1VkY5bFcvQXFVVmVQODBRNTdy?=
 =?utf-8?B?V3JGWVpGZkwwU0pJSmgweHdsak5OSGtzWHR2YUpuNEl3Zm55d0NDQmRYRm02?=
 =?utf-8?B?ajloYlZONEJzblBGSWVxVU05bk10L2tUMDhkSGNQUTRYZnZhdmNkWXQrUzNS?=
 =?utf-8?B?eEF4OTlmMVVjREE1UXBIVVh6T1g4Z3NBZFpvajZyQm93aVU1bWFwWitObEV6?=
 =?utf-8?B?NCswc3Z0RUVyRE84L2paem9Ha0lYajRTS2w1UXl6akFZQ0ltMmt3djliNE1w?=
 =?utf-8?B?bVlSZWJCSy9CbjhTcHVmQjM0YkNyL2hoTHdMMjVVR1Q1cWlDaVRibXlaYjhj?=
 =?utf-8?B?Qm9zZCs4RHA2c015RTUvUDJyTFltaG1XaEVET3dCbFhZY2ZETnlhUXpQMk1l?=
 =?utf-8?B?VXR1K0taanpxSDVwTndCTnpxbGhlV09IanlmUWFpR1UvZEltR3FPeUEwNkNp?=
 =?utf-8?B?cEpiSWFqQk1pN1QwMDMrQW9EbEVlV3Rrd0EvdXFGSk9kQklJdlRIaUtUemhz?=
 =?utf-8?B?M2d5MG84Y1V3REZ1Tm1SMjhMSHVMazZ3NkhoRENGQUxQdUJjMW1wbVJkOEFS?=
 =?utf-8?B?RmMwSXJvbXVKeU5wb2FzdDBZaXhoVnk2MjNRK0hUSVUwbGVSd3M3VkhCVUZ3?=
 =?utf-8?B?cWxXc1BkeEVlVkk3cUs5Vk15UzNRakRCR3YzVnRGQU5xSHFYWHVwM2lDanBx?=
 =?utf-8?B?VXlLcDgwQ3M2aDFZMzJxUE1XSmxaRlZITlUxSjJjbFE5MmRsd3NuM2RVWm1S?=
 =?utf-8?B?Q2NDNVZxUldsdkI5c0VodXVkQ0ZkRElmeHFsclR4NGRRMUdvOWs2RjVWdXpa?=
 =?utf-8?B?S3JhcExxakpWL09CYzJOcGN0Q0R4dUw4MitST1BXRWVwNFp4N0JRVm5sSVc2?=
 =?utf-8?B?Z0pxSmxWS3Q0bHN2WVJERnREYW0wZHVCQ3Nrd3BoaWFKdElaYXVjMDhBR2h1?=
 =?utf-8?B?azlHckxzeDZaMVVGdEtzUjBkYzhEOThUb2RXRWtoUnlpZThNeEVHbjhyL3k3?=
 =?utf-8?B?cVVrNmZpeXhHYnVKb0ZQZDZxcFFTdnIveDdrak9XdTBwaExCbzY3OWZRUE5w?=
 =?utf-8?B?aVc2KzNTaGlKM0ZVTTJNTmtJMGlQM2QyVW9zNkJXRmc0akxnSGJHaFZpUXZl?=
 =?utf-8?B?ekdaY1dWaUpMUkErR1BzUk14L3Y4T0RpV0FPQ3J5QW9GbDRZR1EweXoyaExI?=
 =?utf-8?B?OXF4QXppbWlNQmdXbVNQNzBsRkhBZ0h2UXRraGp1cVFLVENXS1BrZ3c3YTQr?=
 =?utf-8?Q?G3Y3Ov8Dsu2Pv/xv91hdnLvBM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485fc10b-fc75-43ca-25a3-08db09301ca2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 17:24:04.9194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fC6ZmJXys/2JRRf/u3r/AJTbdf+papAXM7sd1jpp05ykHSBz9mVkAUDp39dTxcEm2omvUrlSWM3TGkHKqPK1GPGkkbgACtdBs60oMcwhgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_09,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070155
X-Proofpoint-ORIG-GUID: PVTFhFpuezdX68546ieoYYKgCwzzLmnX
X-Proofpoint-GUID: PVTFhFpuezdX68546ieoYYKgCwzzLmnX
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/23 05:33, Thomas Gleixner wrote:
> Eric!
> 
> On Tue, Jan 31 2023 at 17:42, Eric DeVolder wrote:
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -366,6 +366,14 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
>>   
>>   	/* Prepare one phdr of type PT_NOTE for each present CPU */
>>   	for_each_present_cpu(cpu) {
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
>> +			/* Skip the soon-to-be offlined cpu */
>> +			if ((image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU) &&
>> +				(cpu == image->offlinecpu))
>> +				continue;
>> +		}
>> +#endif
> 
> I'm failing to see how the above is correct in any way. Look at the
> following sequence of events:
> 
>       1) Offline CPU$N
> 
>          -> Prepare elf headers with CPU$N excluded
> 
>       2) Another hotplug operation != 'Online CPU$N'
> 
>          -> Prepare elf headers with CPU$N included
> 
> Also in case of loading the crash kernel in the situation where not all
> present CPUs are online (think boot time SMT disable) then your
> resulting crash image will contain all present CPUs and none of the
> offline CPUs are excluded.
> 
> How does that make any sense at all?
> 
> This image->hp_action and image->offlinecpu dance is engineering
> voodoo. You just can do:
> 
>          for_each_present_cpu(cpu) {
>              if (!cpu_online(cpu))
>              	continue;
>              do_stuff(cpu);
> 
> which does the right thing in all situations and can be further
> simplified to:
> 
>          for_each_online_cpu(cpu) {
>              do_stuff(cpu);
> 
> without the need for ifdefs or whatever.
> 
> No?
> 
> Thanks,
> 
>          tglx

Thomas,

I've been re-examining the cpuhp framework and understand a bit better its
operation.

Up until now, this patch series has been using either CPUHP_AP_ONLINE_DYN
or more recently CPUHP_BP_PREPARE_DYN with the same handler for both the
startup and teardown callbacks. This resulted in the cpu state, as seen by
my handler, as being incorrect in one direction or the other. For example,
when using CPUHP_AP_ONLINE_DYN, cpu_online() always resulted in 1 for the
cpu in my callback, even during tear down. For CPUHP_BP_PREPARE_DYN,
cpu_online() always resulted in 0. Thus the offlinecpu voodoo.

But no more!

The reason, as I now understand, is simple. A cpu will not show as online
until after state CPUHP_BRINGUP_CPU (when working from CPUHP_OFFLINE towards
CPUHP_ONLINE). And a cpu will not show as offline until after state
CPUHP_TEARDOWN_CPU (when working reverse order from CPUHP_ONLINE to
CPUHP_OFFLINE).

The CPUHP_BRINGUP_CPU is the last state of the PREPARE section, and boots
the new cpu. It is code running on the booting cpu that marks itself as
online.

  CPUHP_BRINGUP_CPU
    .startup()
      bringup_cpu()
        __cpu_up()
         smp_ops.cpu_up()
          native_cpu_up()
           do_boot_cpu()
            ===== on new cpu! =====
            start_secondary()
             set_cpu_online(true)

There are quite a few CPUHP_..._STARTING states before the cpu is in a productive state.

The CPUHP_TEARDOWN_CPU is the last state in the STARTING section, and takes the cpu down.
Work/irqs are removed from this cpu and re-assigned to others.

  CPUHP_TEARDOWN_CPU
    .teardown()
     takedown_cpu()
      take_cpu_down()
       __cpu_disable()
        smp_ops.cpu_disable()
         native_cpu_disable()
          cpu_disable_common()
           remove_cpu_from_maps()
            set_cpu_online(false)

So my latest solution is introduce two new CPUHP states, CPUHP_AP_ELFCOREHDR_ONLINE
for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for offlining. I'm open to better names.

The CPUHP_AP_ELFCOREHDR_ONLINE needs to be placed after CPUHP_BRINGUP_CPU. My
attempts at locating this state failed when inside the STARTING section, so I located
this just inside the ONLINE sectoin. The crash hotplug handler is registered on
this state as the callback for the .startup method.

The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be placed before CPUHP_TEARDOWN_CPU, and I
placed it at the end of the PREPARE section. This crash hotplug handler is also
registered on this state as the callback for the .teardown method.

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 6c6859bfc454..52d2db4d793e 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -131,6 +131,7 @@ enum cpuhp_state {
     CPUHP_ZCOMP_PREPARE,
     CPUHP_TIMERS_PREPARE,
     CPUHP_MIPS_SOC_PREPARE,
+   CPUHP_BP_ELFCOREHDR_OFFLINE,
     CPUHP_BP_PREPARE_DYN,
     CPUHP_BP_PREPARE_DYN_END        = CPUHP_BP_PREPARE_DYN + 20,
     CPUHP_BRINGUP_CPU,
@@ -205,6 +206,7 @@ enum cpuhp_state {

     /* Online section invoked on the hotplugged CPU from the hotplug thread */
     CPUHP_AP_ONLINE_IDLE,
+   CPUHP_AP_ELFCOREHDR_ONLINE,
     CPUHP_AP_SCHED_WAIT_EMPTY,
     CPUHP_AP_SMPBOOT_THREADS,
     CPUHP_AP_X86_VDSO_VMA_ONLINE,

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8a439b6d723b..e1a3430f06f4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c

+   if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+       result = cpuhp_setup_state_nocalls(CPUHP_AP_ELFCOREHDR_ONLINE,
+                          "crash/cpuhp_online", crash_cpuhp_online, NULL);
+       result = cpuhp_setup_state_nocalls(CPUHP_BP_ELFCOREHDR_OFFLINE,
+                          "crash/cpuhp_offline", NULL, crash_cpuhp_offline);
+   }

With the above, there is no need for offlinecpu, as the crash hotplug handler
callback now observes the correct cpu_online() state in both online and offline
activities.

Which leads me to the next item. Thomas you suggested

           for_each_online_cpu(cpu) {
               do_stuff(cpu);

I've been looking into this further, and don't yet have conclusion.
In light of Sourabh's comments/concerns about packing PT_NOTES, I
need to determine if my introduction of

        if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
            if (!cpu_online(cpu)) continue;
        }

does not cause other downstream issues. My testing was focused on
hot plug/unplugging cpus in a last-on-first-off manner, where as
I now realize cpus can be onlined/offlined sparsely (thus the PT_NOTE
packing concern).

I'm making my way though percpu crash_notes, elfcorehdr, vmcoreinfo,
makedumpfile and (the consumer of it all) the userspace crash utility,
in order to understand the impact of moving from for_each_present_cpu()
to for_each_online_cpu().

At any rate, I wanted to at least put forth the introduction of the
two new CPUHP states and solicit feedback there while I investigate
the for_each_online_cpu() matter.

Thanks for pushing me on this topic!
eric

