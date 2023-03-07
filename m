Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364BD6AF7F3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjCGVtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjCGVsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:48:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FAF91B43
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:48:30 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327JuDYh015841;
        Tue, 7 Mar 2023 21:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dpG+xGKacmMnCBzoNJgYKrMwSCPsPFa88o6cy8WxAgs=;
 b=egnNYG2Hs6t0y9RMgKhh/0oWgkZV+Jy9PT5xuigNT7q1yU12wxGfXpEW9C2EVbhOIgTp
 ilqtWHe36ZybsGaktZfz39zSzQhjvvXw3TRCwfyRj8Q6whp5eMtdleJ/Mk2kyBsD7owY
 R9AQuLqBo/ge74Hy7X3PW26s1Nt9md79p/STxW9OjGDzzJfVqmfANQukkhPuB27CJrE3
 HOjJgrF50RmxX2w5HnhwQ2oAOiWI3o9tdLsfJFdtnyEwNTXyIzlDFTA1CysCQs1/xw4t
 C8yTYdwvhY+Iax01JKHQeR5m42QVAVkJP9SU6xITDBDoEdD0ryEAcCtDLapndGGcAc2K 2w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418xxsy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 21:48:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327Kd5No027658;
        Tue, 7 Mar 2023 21:47:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u1fn1gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 21:47:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfWOKFSAmtaGL3ovHzMKtdWVfD1pLII8hS7OJO6sUJf+rGJslb0WlDCpVmqgIQd+T3EebYexDxFM7BgShRy0wqVSxMdc4yT6aGRxlTqF9wk7GmPfhOdhwx4KFt4Ry4G+dzGXRALOVNl35ILZJ2aN4Cg32jUOmpyxb34bWkQ7LV4Ajah5rdLPXhR/k9QAk98GjPuLgaAg48pF/9TX4E4pBxs7Vy6fUOnIFKkBEn1iLPKeuM6DenN9PAbe2TbWU3ZrTXQMs2xUta9xVk85QJeTPVPWgDrQsshtBJU2NipsCnIv73SrrJWyMiHge+Se+xFveSu3XqOe8Ibiao95vYpekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpG+xGKacmMnCBzoNJgYKrMwSCPsPFa88o6cy8WxAgs=;
 b=dRl5Hf/4Io3Rd70+DkSsYXPW2ZMmi7yCAN2caAjZPgF6sdQkUdqu8rJ1oD6UKzUUbaCteiYP3jt85cWkggkbR/FRzArLITiQMsqYl3Gb6/8Ijl/QDoRI8KVg+TeHcOTS+Hg9AoJ5AX+XC6w6sTlXXVyLBHP8MPNGJDGrMDyHgTLXBFB5KDHNjW7vPaI3nqf0c4GRigBW/GS50h5s/uCVxp9edm9hQ2AVVE39hDo2ZkCQSPfO0DHnTRJEW3cFXI98KjTec+Dk2C3BxRqgfEo1xw1tNSWqTrpujJRoP8KewnZZqGOudu6jUSLS7gY7EIOTJMRqnXwcQVP47y+GP3fCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpG+xGKacmMnCBzoNJgYKrMwSCPsPFa88o6cy8WxAgs=;
 b=rxKGW1Az2kbduPa6xao6G5HHyM/rQyZ3z1WJdGkt3J8JIF+kzE9qKHG7a9fPkHW95b8gWp5Quf0rJJKN8UUN5REJE0Wl4AUe5Er2Mm9Vw2IAi4o30/L16wcMVqPOy7JqhoYAvTD20G1O/mcx9gpmoyPD/4LHIf4KQQzqkcA9/Fg=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 21:47:58 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6800:e85a:3f21:6606]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6800:e85a:3f21:6606%2]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 21:47:58 +0000
Message-ID: <a78a6c1b-41f5-0791-979b-ef226a51a779@oracle.com>
Date:   Tue, 7 Mar 2023 16:47:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 05/12] x86/xen: set MTRR state when running as Xen PV
 initial domain
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-6-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20230306163425.8324-6-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0254.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::7) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|DM4PR10MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: e36ac381-fa8b-4925-7ec0-08db1f559daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SaBYOHzgsD0M3VKLUR3V9nwV6Wkr6fpbNruL5F+M8G3WlU206pkMFyLAXd3Zqu5ShhUKQUU+kogDIWUnv+NLKKKabOtC+o1aVIMns3JbonkAzfccWSZkF9KiR3unTYmAA7QsXXCgj1cbNftKuLl0oEZvbOEQooF6bwq3p3B8crNbeFfO952/ummSV9lFgBrsnk2gaOu1ifmU1f+G9+iYw/ch+kxESTWNMHRUasLXNW+0TpAim1q2tjRiZxSqijoET41lZ94iJX6vE9uboXKunFWnvICrL6UlURqTB/1Hx0ylKBvMLjUgHD7lBnhuOO9LboPTAhxq72ooedoT3MYvqitsvs4sbaSm/P1C8FHWqd+N06amlW6ARnyxx5VaRS5z6xu8vd5u4DGQDM6sI31c7zWMo5prYCPv4IsVW26UfQVV/uxQzwhis30vPrgBU7H2Wkq1Aztc2GyjlLy+NKQE64EU8ZFrMRoA64FtXD/mnCaZ45T7Sbo3phCKQuRMhMSNIJEai/W367bSNhinIIHI9XGGAYGV0updNSPNUOw5k+1chWyqdcFj0Hh8mW7osn7vnup5cSZk12FeQRTKkmWCEsG165F1JxBnPjkU+wmPQnXkKFE1mEfoMbXpAHs5BIvzEDgpkQN2RL9+lOBcHLpFSntPo8KZ6s3jXimJGDu/wBnJi3R6LO6+CRB3nT/N1sb76giWVkC3bGeQO1fGPw8vEyFkXBEZRauncAvE03d04MU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199018)(31686004)(2906002)(2616005)(83380400001)(44832011)(26005)(4326008)(66946007)(8676002)(66556008)(66476007)(5660300002)(6512007)(186003)(36756003)(41300700001)(6506007)(53546011)(478600001)(6666004)(38100700002)(8936002)(6486002)(54906003)(31696002)(316002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elB2a0ZUdk1nVnlVMVhHVnNQT1NGQXlQd2VzamcvOU1qaW0xaFlYMEMyWFZI?=
 =?utf-8?B?WG94YjlEQkd3OVJmYndWV0hTcUV2RzRNVXEvU1gzOTM5d2lHNDJaejdLSmc3?=
 =?utf-8?B?RGtVcmVRdDR4Y1hpeWFxWDZSRi8wOGhjMERWMDZwVlBwUUFidUFoQ1JtbU5K?=
 =?utf-8?B?eG1pUUVTVWFpTlhXTHNFWGlFandtRkVSVnM4Qlgvb0Q0MjBpRzl0NnhuVzlF?=
 =?utf-8?B?TzUyaXBRWk1vOTB4TG00RkVodGt2c280TXllV3VVY2FkZVB2cW9zS1RQeEc4?=
 =?utf-8?B?VW0vbzlEVUtPM09SdjZGQlhyaHNQVWQ3RnM1ZzRhVWlmSktHTktuTk5JNHNm?=
 =?utf-8?B?QW9GdnBnOG5teXNuVnFWTjk4eXdYd2tZSUxURVhCME4xVjhQYmxHektTc0tx?=
 =?utf-8?B?UjI1NXdnOWxQSWxTbDQzZzhqbnFMeGFGbjF5clFhenZjR1Q5NVJJL3NMeFJu?=
 =?utf-8?B?TW45NVF3YTdpUmlrcDA0YW9vQ21tWkV0OHdTeDdXbS9WUTRaNi92b25mcml2?=
 =?utf-8?B?Smpaa0JWN0N4bnViT3lsL0d5TzJGaUtPakNBZ0M0TkF4cGZJSGhEUVgxVXdY?=
 =?utf-8?B?emdQTFlwVkUzWHgwNEx6bG1JMnNCbEorOUpLNmhheFREclpQVXdtUTI1cmpS?=
 =?utf-8?B?bnRTU0J0OXhWUE5IbzFtNVgyN2greGN0YU1xeU9CRktzcllJN1dlcnAyZ3lD?=
 =?utf-8?B?eFJjalowZUFCWkVFcVRGMTQxKzVYREVGb0FvSzdUSG4wTWxVdjJCQVp3N3dN?=
 =?utf-8?B?cWx4SURISTNMcHd4Y0g0U2x5c2Z6WldGeVhhaHYrc0o0UkM1M1hZdDgvekcv?=
 =?utf-8?B?djlwRndieW9lS2pPU3czUEFtTTVoT0QwMXdXQSt2Q1hyVUtpZG9FVXN6OFU3?=
 =?utf-8?B?RWlDUWV3SVBTRm0vNVJreVVwdjlKWG4zSVVtWDVtN2NBZXhldnR1OXlKckx3?=
 =?utf-8?B?VzFFUkxGZUFKMXQ4RFBySnlMLy8xa3RRb0FJOEFlTGlkdzRNQ0d1bnVTekpJ?=
 =?utf-8?B?eWZXSS9CYnFkM2VtRllJNDlkZVF5VWRsRlVaaFVQaE5zWEwycWZQa0ZTWTJ0?=
 =?utf-8?B?LzhmVC9NbEI5ckhPaVpJblY1cy83R0NNUTdYY1ZQWkh5L3ZReldqYkU0YTRl?=
 =?utf-8?B?MDR0QkZGNVFJalpGVW5DZVN0NVpqNm0zdGdqY254Sm5XQVJWeWI2ZVVIUG56?=
 =?utf-8?B?OHBia1NZWFQ1Uzl1anA4dngyTit2WnJOZmhjcmZReG9BQUlMOXdrNkRSRWtP?=
 =?utf-8?B?eEF5cWdtYTdZL2JTVkxqZjcrRGh4aDYwNG4yd0Q3RlgrdW5HdmorNytWc2dM?=
 =?utf-8?B?VUFaTlF5RkhwbWJIeW52S1F3UVcwa1IvMURrVEFaZ0tOVzhGeENxM0U4Z3pM?=
 =?utf-8?B?RjdTRExySjlXdi90M0pJRDNKcWRPUmdvNkxnL0s3UGVmc3FnVWxjZC9oSVFW?=
 =?utf-8?B?Rm05YWhLL2RrMFgxejloeXVKMU82QVN2djFhd1hKUXlmYTJYbnpKL3FEU0k5?=
 =?utf-8?B?OC9ySGc1aW5jY0RoT1V0NWRyN3hWUVZpaGIvaEFQcVJDbDczNmFGTG9nWnNz?=
 =?utf-8?B?cFRiTkNBUW1xMW1mbzdNRWI4cnVWc1prNVBLRDRpZG5MNWhDNkUyZXI2RjhF?=
 =?utf-8?B?azdaR05XM3k2b1JIMUxtbmsxMmNSTmgwUlNrZHFvaklULzNzTHlMRGlObkpq?=
 =?utf-8?B?Q2IzRzNBWVRqd0c1d1d2RmNjSXJNYmRvUFFnRHpScjNrNzQ2bVNLSDFYRFZt?=
 =?utf-8?B?U2dmUmd2Smptc3BqN3lBZXAwdTJjenhyRHNMSE1SVUZISklsanQvbjFsbWdD?=
 =?utf-8?B?d2tGWWlsUG53Zmx4VCsxcGdBelNLUVFBcVp0TlZVazVLZzl4NXVJdVg5dlRj?=
 =?utf-8?B?RzZrOXgrV0hUUG9sM2tQY3pPemxjVUF4Qk1lZ1U3eGp4eGNYVjJvRWNIQjdp?=
 =?utf-8?B?cC80V2VmQWVwbW44ZWJ4dFFxQm9mNE1mczBRNXRKZzVBbnp5L2w0cjVpSWRv?=
 =?utf-8?B?N2JLRmNXakpkT0s2OVdOcUJWTWJ5ZjRYYUxER0hpZm1sQTZhZVVkNDhkWFMw?=
 =?utf-8?B?ZmxxcFhINCtNNTdkZkdmdUtyampjYW5hVWRrcUNCSkNhc0lXL0c1QzFKc2tn?=
 =?utf-8?B?VENoUGRaRk9JRllGZzdqbTlSNXlRRGREK2xNRjVrYmRlbDVLZlQ5ZTFOSVY3?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OE85TzhGQzE2VDBOc2thS0E2TlltQmJKV0thN3ZNVXo3Q3JKY3dNelZTMExw?=
 =?utf-8?B?czVyT2hKYzQvcVozYW56UERqeGZYclFTeTJiSVdBNVBNakt2RTdOL0UrUEZC?=
 =?utf-8?B?a2EzVVNkcG02UXdtUkVEaXBGL1dYdlVyVW53d0VaUkllYTJOSzMwWitCWlpn?=
 =?utf-8?B?TmZvSHhyK3Vld1FuaEIvSUJ0VG5Nb1VKV1h0bnAySEQ1NWM2bVZIQUgzMTRa?=
 =?utf-8?B?S3lGNlU1ZmpDNmk4OTNKOHJQVDY0TGFMTE1uOGhuaTVoWUxzcktlZUhGQ09r?=
 =?utf-8?B?aGZRZmhNaERxWmpKdUlJN2s3ajN6Q2ZBOTdDNE9EcjhIWmlGVFZrcHJXRFdt?=
 =?utf-8?B?Yzk2RjdDQ05DUXhvSTVYV1FmaGpNazE4Q3djRG44VlI5eWl3cU1jRXFxbzZr?=
 =?utf-8?B?Sjh6QTBMR2ZCaHN3TDBDZXFWOE96TEU0T0xhVFNhaCtiMHI1MWNHQmlNVTh0?=
 =?utf-8?B?NXN6aTNYNE1sdjZMc1cwUUFvMVJ4anNEeWpjWk5GZFVGRmo4NXRmT3daNDA2?=
 =?utf-8?B?aU9heHM2K0dWYzNwTU9qOUhxakljSHV3b0FLVWh4djdJV3cwbExxU1ArYklh?=
 =?utf-8?B?b1FDSEJzaGlXMGFsNGt5cHZ1QWVuanVoWWdqcDl2bFA1QWlxSGFMWUhGSWV5?=
 =?utf-8?B?R1dvaWtJT1BtRStjNWZtaVZza0VjRmI2NWJ6T0liUHRWQnlIUEZtSDJVRmRY?=
 =?utf-8?B?Y2FQbkJxcmJ2SmxqZ2V5dkdscktXZVl5Nkl5N3c3QktMVTI1Q25CMGtKNXpM?=
 =?utf-8?B?VDFaQk5DR0VnTGFZU09ySFJmOEdTQkJxcm5oeDVOVjVTUCs4UGYyc0Q5d2FF?=
 =?utf-8?B?Qm1QOGRXbXFFdmZjMFROaFF6aXgxSVo0OGNkVkJjN2ZaUWJuVjVrdFYwNFNt?=
 =?utf-8?B?KysyVHhveFp6ai9pQitUbUdaNWtUOUVYT3BINXl2bmpZK0Jsa2pwaXhwdGZ1?=
 =?utf-8?B?dE9jSHRxMUJMbUExU3pQRTNHazlyeXRvVFRqbEVlbGZReXR0MjhhSU5ORjFr?=
 =?utf-8?B?VndMSytwOTJ0ZWxuWEhuUkJKVjdFMWJZR0hkUjYvNW9ZUXBxSUFObFBkdit1?=
 =?utf-8?B?S1ZrYW9BRkpJREZTQnNRSi9GRm1nRDJUd0xrU2pPelg3YUNERjNtaGZONXlF?=
 =?utf-8?B?dmEvZ3ZoV2ZzY3czRkRDVGhpYlJYaldkTCsvNUpqQlFSV2pKVlJBVkZ3MmNk?=
 =?utf-8?B?SHdCOE1oZDhtd3hBUmpjdGE3RE9hTDVXb0RiMXZrZFZkd3VrZjhwc3JWd0tY?=
 =?utf-8?B?bkZESXRXTER6WVpxYjA4Uldwcy9ZNmlHcGR5VXNCWVlYS0RDRjZ1emF1WEpv?=
 =?utf-8?B?TVk5QTQ1c3NENEM2MTBodU4rY1JnNGwwcVZnbkpXbVM5ZHIrbUtrcnBSZ3Ft?=
 =?utf-8?B?c0hHUzlqTFFXWmc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36ac381-fa8b-4925-7ec0-08db1f559daa
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 21:47:58.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkuEivpDXDzAaCvPkhuFTCzoFCfskAp/Zr1U35cqGFM1k3iq5P+uafQ8GsxR0LhriNYGeIl5MEN7WKD2Xv1VZZT6NhAen3mhWm+WbucP6vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_16,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070194
X-Proofpoint-GUID: aoAoRyFfaGhH-ujFRBngzDCbS-ejFu83
X-Proofpoint-ORIG-GUID: aoAoRyFfaGhH-ujFRBngzDCbS-ejFu83
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/23 11:34 AM, Juergen Gross wrote:
> When running as Xen PV initial domain (aka dom0), MTRRs are disabled
> by the hypervisor, but the system should nevertheless use correct
> cache memory types. This has always kind of worked, as disabled MTRRs
> resulted in disabled PAT, too, so that the kernel avoided code paths
> resulting in inconsistencies. This bypassed all of the sanity checks
> the kernel is doing with enabled MTRRs in order to avoid memory
> mappings with conflicting memory types.
> 
> This has been changed recently, leading to PAT being accepted to be
> enabled, while MTRRs stayed disabled. The result is that
> mtrr_type_lookup() no longer is accepting all memory type requests,
> but started to return WB even if UC- was requested. This led to
> driver failures during initialization of some devices.
> 
> In reality MTRRs are still in effect, but they are under complete
> control of the Xen hypervisor. It is possible, however, to retrieve
> the MTRR settings from the hypervisor.
> 
> In order to fix those problems, overwrite the MTRR state via
> mtrr_overwrite_state() with the MTRR data from the hypervisor, if the
> system is running as a Xen dom0.
> 
> Fixes: 72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly reflect state when running on Xen")
> Signed-off-by: Juergen Gross <jgross@suse.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

