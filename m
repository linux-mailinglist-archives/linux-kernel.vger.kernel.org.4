Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CA56E5565
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjDQXtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDQXtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:49:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F49272A;
        Mon, 17 Apr 2023 16:49:14 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLSxVo020216;
        Mon, 17 Apr 2023 23:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=a+ZuJiVASIbXOkn+PMcOkGzvO+raHC/aBN/YdhrCUqg=;
 b=FA7WUvXVB7nKSAqceSZX3ptXxqQX8rpZaDfngCSing6zPbTakwIcEoAMy4qBMEBRkwmh
 mS8HE/OboADn4eNu+0pkLrOXO6B8m1zZujj81pR5NRwm3ZcEQzLErX4ehfRo+8MASlsC
 QN3rOzAbscJxcwXoDq+sdAlvd+Jfx53D6zNXubNMd9r4EOmlPCBr+LhxlMrSFsBEk5jv
 Xwz1aZRDhXbL6raWOYeFw3Udh5ni0FLXZRZBKXXuv643K6icQ9W4ovDQ9u668KqnBfgR
 qm9IIlcLew9jcleKedhpcJUisD0LgDDN3PpVztTAdvPddCcE7tZC5POpRuq37PNKOF8j /Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykycvegt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 23:49:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLVSVF029899;
        Mon, 17 Apr 2023 23:49:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc4anur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 23:49:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfXotbMRBzaR3A2LYqehW/3BfH5pjqWeI2mAOhmmFtl7sJXiDpG/wXrnnqI5sPAfmTnWP10+ogkOW9ivc8x0FNwoR2MJonZIMN2wDOXmWcx+JODCC3xLRARMGuPQXWGVJHdulHl2LXBAvbVeDufTaveQOOGe6GLFtE1VHEdEFwDrGzetyBPdVsI5dj/mqBwwmNHZrnj5c9xIXJMohez/lszru3rPT5+r1IFUR03YGR/szr9naxXbJ3x54GQC+qjdNoj+r/lOVbiMCmI8CEAu9dJFVkB/WF8UHjOsrUI7lnhTvWKTDJcboNhNcu4/Js9QiTVg4xJ8HIGHkwi2yzkXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+ZuJiVASIbXOkn+PMcOkGzvO+raHC/aBN/YdhrCUqg=;
 b=EuFBtHeesfOg9NZNqo1oIr19QJJnHRqI73sO1DlNeMbsjzHt65Oy+6QRmOH5AYIAFxR9Sc6TmeaooWDwBTym09Pxgdx8KMoqbOQvVijNwXSu7QE+b2ngbhWNsyVLg36MSg7Uk8+iS2shBOnlzliCWC0G0Um+HldZYvJZpZTn3hxncoKVnKYvH1hUbzCa1n0AiegsEd6W7pjxJID9DgBTywZUmWdqsZIDmOhsJiB+gXLxZ+Ku1Q/VR2iTCeKVqvZRFze+ryk7H7nQYXeDjRyKcDTBxi69Ceoev5+n5F6LJQ5AoUNIhrfEhemD5BDd5yOE6+2QTAxgNR1NdpNSlvFkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+ZuJiVASIbXOkn+PMcOkGzvO+raHC/aBN/YdhrCUqg=;
 b=Sp8J8N+nerHEu4XoeMk5lptVsouGApU6fy3FSBAzU6jGBPddtHJ7yBaNfbRx65Brmhm/myPmPlmPQBazkbNslKONCfFAm+Hq/4KDJTy1f88ql1NYWv3kzD+dSVRskxaLEzfVub7LFmFJtXrzzOt/XNgbosChvcVzCJTWkNsZDfg=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by MW4PR10MB5863.namprd10.prod.outlook.com (2603:10b6:303:18e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 23:48:59 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 23:48:59 +0000
Message-ID: <b68c9e1d-71c8-adf9-f7da-1b56a3d4bfbc@oracle.com>
Date:   Mon, 17 Apr 2023 16:48:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH V2] debugfs: allow access relay files in lockdown mode
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        joe.jin@oracle.com
References: <20230412205316.7114-1-junxiao.bi@oracle.com>
 <878reqs0xg.fsf@linux.ibm.com>
 <CAHC9VhS3LpJ_x7ZfdV83KY3U49XFGMLejz7rsiEH19rzyUfD-w@mail.gmail.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
In-Reply-To: <CAHC9VhS3LpJ_x7ZfdV83KY3U49XFGMLejz7rsiEH19rzyUfD-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|MW4PR10MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea7c674-4832-4329-10bf-08db3f9e50b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrxTP4myNsMAx59M4yLI0DGBPtgTPlWvSZSrEqsWpuvOdTgE3L8Kxp0uehwbxBkUPPhXif2NNvgG1Mm3rjJpP50ngabV/hIBNCtGfBbnYEe3VaaV7CkI/THmoet6itclFfcjk4R+GoM4JjA2KDI2FEYV4EIUZXfhXJBiE9NFdizAm37U97WvOROh7hosauWgBtipXlgIjsRDhm4mNSXp7KjsWaCGmm1S7MsPO6SNepY+MHLoeiEu0YUqGvSjiZXwqmDD9gVd8nBXOZdRwPjOUqwidGc+XONRBbS2G7bIBvzW0j+BlmURda0ttfiFhsRHI1P4dGng+eCrRfuNFM/i6ExGVAJvEUjACHgWwPMJz4k72oCkWx+tKRZ24tG1Gz9ZfEYtbVU1YjkNpVrbgMg5ygWNvEZHxpPOLZapLYlBpRPT8IE42RUnDYmgnpDwi5mboDVK0dRatvQ0k+XyFvzUbxHTbiu0ibr+jadzPBpYPP4bpQhnE4vOQK4gKbTXm35eEkfJv4GVxtcVAQYcHGzqHktZtbxhVbdV7UGCoxunSvzl8wPi2A//qF8lt4J+/8hZftCd69clkZgtRCozE10vLPj0VLctaNfQ73sOCm06yg3UzWALwmjuff5CcFX50DpycA4bKKPpLTxk98HJkJvOnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199021)(110136005)(31686004)(53546011)(26005)(6506007)(6512007)(186003)(83380400001)(2616005)(107886003)(6486002)(5660300002)(478600001)(38100700002)(41300700001)(316002)(8676002)(8936002)(86362001)(31696002)(66946007)(4326008)(36756003)(66556008)(2906002)(66476007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0hrT2JrV1FhN1B1MlNVa3QzRFpZcUJiZndzbE00MzJRNkZxUWJ2Q2xpemFL?=
 =?utf-8?B?QjBoWjVzM1JlSUlGOFRYV1ZXVXRiV1pMSGxKUVpLL1hCWHB0cUVxL05sSEVF?=
 =?utf-8?B?dkpWb2h1ZDZjTzNGMVhkZnBEdGhoNjdyd3BhMEgwOXBYUE9aYVJVaW5CQktX?=
 =?utf-8?B?M2pXdjZhbHhNT2FPbnBTN3FLSnM0U0J3SFVodnYwcG1VVEtKWDgwWGY1MXc0?=
 =?utf-8?B?cVNtVnliWFU5VU5HYU54SmUwdHgyK2Jxb2dHQkcwK0ZJaWVzU2lubFVXQVZp?=
 =?utf-8?B?cmU0aVpyMU1sOUZLMTlBQThTVnAvTU0yWmNyRCtSRjZGSmFJdmtiV1g3TmhR?=
 =?utf-8?B?S1BLN0o1eVRwMVdvYjlHT05rZGRoQklHOTZRd1czNzdscllmTHV6S3l1bXJN?=
 =?utf-8?B?Y0lJTTZML2lKRnhkTEdsM2lVV0szdGFLUzFkU0w5S21OY3Q3YTRwTHdQenZT?=
 =?utf-8?B?Mm9mWXNFeUhLUW5idXNsbzhNSHZvSlRjdWhWUHdMZXBweFlWSG1XRVZ4Q1Nz?=
 =?utf-8?B?TFBuN3M4YTE2NU5zU3Mxa2RJMEpPa0tQWmtVZzFvVXFhSjhXWGwzK29hYWsr?=
 =?utf-8?B?SzFRcmJadURPY1NnR1BvRDNpb0ZkdWErNnVOSnF3R3NHU2VFL0dzYjBlZXIr?=
 =?utf-8?B?dVJvbEp0ekFkR1VVZ0dmd0NsRzBIeVdBN1FLenB4amhuNTFvcWo5alI4U21x?=
 =?utf-8?B?UnFoYzRDOFNEaXFrVkd3aDJKWkRDNExsOVNaT1dzanAwNlMyR2FCNmR1ckpV?=
 =?utf-8?B?U3NPUW0xSGlRSHcyMEwrN0RhRVFxMWJFK2pRbzNDaHk2VDlGLzBmVXVGMDYr?=
 =?utf-8?B?ZEFaYWdrYkZ3dEkzVmk2T081eFMxNDhucXFxRG1HZmFNK1dwQXFxUFg0bnlp?=
 =?utf-8?B?T2JxbDdUWGY5OU1YZk9uZE44SHFqN2NCNTlaQWp4TXZrSkhZKzRad0lubW0y?=
 =?utf-8?B?Q0ltT2xDNnYzYW5iWGZmYmlQRmN0ZGJoYmlIb3V6ODNTdSt2T09LRnZkemw5?=
 =?utf-8?B?NzF0OHBSeGljR1FCMDlZU2pBMlJLOHhPREExUHpvM2MrVUt2QnlBT0RSV2Fs?=
 =?utf-8?B?QWRQRjIxVVM5SFpoeEc0NGdDdUhVQXMxVGNvMmVwK1VsT1FXRHFYTkNNayta?=
 =?utf-8?B?VnFBZm1ZMTVBMGxSMkdVZE5lUmJVY2I3SlZLejBsa1c5czlWdWFGM3BsZUI0?=
 =?utf-8?B?c3Z5TmpDRkM3SXVRNUYyRWdYaksxTUpCVmlac2NySjhta1ZZVEIwd2NCR3V0?=
 =?utf-8?B?ZjVVQ1NuU1VyVnJ1YmZSai8rNXg2eUYyZjkrcEdPL0VlVkx6QWc5Wlc5bGIx?=
 =?utf-8?B?b3pQcGJ0NWRUdEZDL2drL0xDYjhhOStuYnlEQ0VROFNyYTI4RGVsOVZ1UEFx?=
 =?utf-8?B?am04QklTcjV0V3NNMytSOUl2Wi9NWDRyVWV3N1M5ZE54Mm8vSXgxYzk3aDNi?=
 =?utf-8?B?ME9IQ0ZXVXVsc1Q5ZktDQXdyNExOWGpWWjk2RXRpSmFoWGsyVW0ySmlVOXRQ?=
 =?utf-8?B?QUZYWkNXbkFwNmtTZkxLSDJuZjVCdXZlSUg0UjR3VzlGYzE5TTU2NE1BU1pn?=
 =?utf-8?B?WWEvRnArUmZKRlBuTDhVTkhBekEwOWZZOUMwS29NV3h1V2JicnI2UDJzcGZQ?=
 =?utf-8?B?N0NoN0VRb2VMbHY5ZEVmMlF6QUplVXVUUzhYUjNxYXYxSGZwTVZMV3FHRWNz?=
 =?utf-8?B?RlNWZTNlUVN4dXE4a0lYaTVLelc4eGduRUhobDBGSHJqRXVpSE9jTkFsL0RU?=
 =?utf-8?B?MitGbzVzYk5rM0JhS0Y2SGxMdDR0b0JnTHpSVzNSU1pHVk9EcmRydGovTzJ6?=
 =?utf-8?B?bWMveGpnQjE3d2kyOTdkYXdzdzlnMnRUcS82TkVvY1RyNENBNkk3WGFOS3hH?=
 =?utf-8?B?WjRkZ2NILy84OXNLc3NJTUJoRDE1T21EeTQyYzhPZ29SL2VVMTI3TkozUklJ?=
 =?utf-8?B?UWk4V1RWRWUyb290THpEMTV6SE9YU05nSUdsdXJMY29Pc3JVbGF2UmI4WmpC?=
 =?utf-8?B?Um5hQ0ZKcEI0NHV6Z2IxVGtYK1hSZmQvN3VCd0JQbWFUS29yK282K1J5YmpL?=
 =?utf-8?B?cVJyN2xUSnZHMFk2TFRsU1dhMFJOZW9YY1RoOUFzYlJaMmM3eUJnNml4Y1dj?=
 =?utf-8?Q?Z+jUnVTCgTcIKAjsNTg/lgN5r?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JjVc2Dh8tv0WkZJkDzff9stlrEVnl1ksFGT67J4FvudzRh2sz012aOMxBIQ2TPZvomzii69mFvsooQ/RCQY7B4DeGWgEREOyQRAj5G+aBxnHsQELD2ZvYX40xDtiBtIhySCgWbF+YaqnH6KEXlPQvhnU/1iufRFYxC+iIZhnyFtloZebUeaC0c8OnBtI7sIeR8cMJvqQ8wluFUrGsN0BL/2YMn3zgc75Mqi8AK3ct668+bRv3Hh40AHLZmkRg2l4HcbSigz7IldBOUwEucNPgiRmJbfn7tKtdwLDVi4/qP33ZhuUK5y24jpEd9JyOsOJMMzFNnmaYhrT7Wo92q3Meigp9OTPw9xU6UQ/E7GPQansqaQ2V1sGYhKJUF/mOoArKT+qn7qsoXn2dSyP6KViTxYSoZDpaQsFNUDxp2hyY+ZgPZlV6RWyNiF5H02UAsHD2w1IrbAiFNKBV2mYuB6GgJPZQWDUtDzhGBaXCiEUS2Lzab7f5bzXHjKZpfGCFrvhZRAQKGl8qeCKHmaC0UsQFn/VgArdtKsKXYb2cfiwmOLTXm8d7H53ZuPL03Z2QkzITmpviJtbW9ygthbF4hgxeP62PTyi0kh9tQ2g502UTZnlHtDKjXQqOKPm37x022YGotyAPRGzqEUxqfMa7k50knjIrzo7jUSDaga16K2pg2hIznsA/+rI+LYoY2f4UqEQwSjNV8Rl3cy3Nltj4v9Yu5JSYiUhC9S3rM84ut+cEtssiUGLGK/i0mtCqryzIn444MsYy75ORn99H+9w66iDCQPyzdbD+/c4jVHdLVmrjoz1LdqUpJiEo1lbUtyHLkA34ZcMJsXJTvVQOZsFHswW52i2gFDc9zD8nSuMsx+CeA/9VKMDi2d7FTm9AKMXXtb0hkSc/8p92KdTKWI99ivoinQFFwMfDrCzTrIeu7Ylf2M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea7c674-4832-4329-10bf-08db3f9e50b5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 23:48:59.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvDhta89fDLFXrG/8wbDf/4UqS5PYT4JIxOcL1qe+ZYjRHZZBPAy8tKZHYWD1KkTrBfjNZqOBvbir+VlPgi3zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170210
X-Proofpoint-GUID: DABTDW8gmj15-X3I7x_SzPWsbEDa_pZ-
X-Proofpoint-ORIG-GUID: DABTDW8gmj15-X3I7x_SzPWsbEDa_pZ-
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 2:56 PM, Paul Moore wrote:

> On Mon, Apr 17, 2023 at 4:39 PM Nathan Lynch<nathanl@linux.ibm.com>  wrote:
>> Junxiao Bi<junxiao.bi@oracle.com>  writes:
>>> Relay files are used by kernel to transfer information to userspace, these
>>> files have permission 0400, but mmap is supported, so they are blocked by
>>> lockdown. But since kernel just generates the contents of those files while
>>> not reading it, it is saft to access relay files in lockdown mode.
>>>
>>> With this, blktrace can work well in lockdown mode.
>> Assuming that all relay users do not expose the kinds of information
>> that confidentiality mode tries to restrict, this change seems OK to
>> me. I think that assumption applies to blktrace; apart from that, there
>> is a handful of drivers that use relay files (I searched for
>> relay_open() call sites, maybe there is a better way).
> At the very least I see an Intel graphics driver and some network
> drivers, but like you, that was a quick search and I'm probably
> missing something.  At the very least someone needs to go audit those
> users/drivers to ensure this is safe to merge.
>
> However, regardless of what that code audit may turn up, I'm a little
> concerned that it would be all too easy to add a new relay interface
> user which isn't safe.  The check in debugfs_locked_down() is far too
> removed from the code which is using the relay interface for it to be
> likely noticed in a future case where an unsafe user is added.  This
> looks like a vulnerability waiting to happen.

I got this concern. I will make a new version to limit it to only allow 
blktrace trace files.

Thanks,

Junxiao.

