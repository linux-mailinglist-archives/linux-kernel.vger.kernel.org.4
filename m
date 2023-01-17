Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C25670C24
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjAQWvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjAQWu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:50:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7675159DC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:33:56 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HLwbXl024563;
        Tue, 17 Jan 2023 22:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=D9Jia8Ckcx8xh1PjA0r0QV2AfZO8yjzpbwSI/peVwfw=;
 b=vwaQ4TBLzb1BG0irpzKvtNm4OJhwiuHzqczEfjvTsfHKkRGC6aH2FpR/SH2xvGMtJ4Xj
 WaaEWo9hW1xSyaSQT09fREiXnjzZWIWwQCURRUY2aX0yCohStoECWrzFC+dSSCVSScf2
 WlaRM9JiRi7dzF+I1s4IynZS517jQp+dM52ydw/PAiQSRoX0aAsYNsr8zQgmxd1DPTFK
 biuQQcw1KXwsJSUE1A/B+HGxv6jFsBoGfHUCYBBm5P/qsBuU4aTwODSUaMMynDBzvf88
 yGLi0hkvoPVomuAxbn9eeelH1U5oyOnNaxmNLv37v0bO8uhb5xiCwIrgxS+Z2B437Ab2 Ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaae7st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 22:33:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HM9Se1031048;
        Tue, 17 Jan 2023 22:33:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n647k0ucp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 22:33:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVhxuGKvui25teubT2S01tu9iHOk6w69yYbaSW5TnswHaenQeE7r3ug2QP2uUiOm3dvpoo6+TFO2V8Z4WZ/TQtJb2p04G8m7WNJxyc0OLp/eMJOh7TN5L0QLbWQ+ddhq0uBuKEjHNXDx9kb1hKJ0Gl3jfnDfc/HQguduzYIXYjVzVdiPOs7HmMuYcERow4Xz6JhzgB/A+6J4i6PPvhAzGhPD1ckPC4oF18XDdtkYJoe1ddLNG2V/QeBQcSNPdhRHxceNkGiD67jDRTLYWOMd1MlIMXyLNmTo8GwZOBXP6AJFrFIszMSBXMK8yfPmF8oZlvw+veLaaP9/7LUqz2lZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9Jia8Ckcx8xh1PjA0r0QV2AfZO8yjzpbwSI/peVwfw=;
 b=GOyTXKAK2bOycc7E8mmSVdyMBxeeAHW+CS7iOFXeE/JTXD1AkAfFXqVoGBWLOpInOlpU82WmR6jEvfZq3Hhno5ikEXw1RATCiPTSPb6E1+HjmtQs+naMfTO3p5RPdmyRWkFSsZe83+N24+AdBxv0gWAyBXmjfccrBveuHy8YYklsLWmJosx3XBfQVFMooUitGVkHj5O5+w4I1LJR0tVkcfjqx2Alo+44Ic79LHi8QMZ1gMBlDal1E2IP9BNfftsk1WzN6GCVAAOvtxa66Zaw/9AvfXUG4aMiEysTPCpMtOKd0LiEGn5xLJ9gWLymrHM17S0jX9I2u+r7HMqpe3AKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9Jia8Ckcx8xh1PjA0r0QV2AfZO8yjzpbwSI/peVwfw=;
 b=LBkbrIGvo0d4BIzJ7ZnlVOLbN+SXSrnXN8AAto2G3rf9cI2OsNADWyEiySjeh1PmetBbSVttHDMhAisNrrt95gW7JA6iBTbAgB6anfr8clEo37YT1dMN9ByZUAJ9w1iuEgKiQz8t2QHR0jXPKgiLycKyCxe9Fzo9Tp1nsgV1kzM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB4439.namprd10.prod.outlook.com (2603:10b6:510:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 22:33:13 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%5]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 22:33:13 +0000
Message-ID: <9b55fc08-f8be-b9ab-fb81-06c4cf846772@oracle.com>
Date:   Tue, 17 Jan 2023 16:33:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v15 1/7] crash: move crash_prepare_elf64_headers()
Content-Language: en-US
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20221209153656.3284-1-eric.devolder@oracle.com>
 <20221209153656.3284-2-eric.devolder@oracle.com>
 <09567e13-c5ed-d1b9-027c-9340fce6a0a8@linux.ibm.com>
 <b3f3a4e5-35e7-2cb4-f754-f425da094f28@oracle.com>
In-Reply-To: <b3f3a4e5-35e7-2cb4-f754-f425da094f28@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:805:66::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a32529-2da6-4022-603f-08daf8dad14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3H+24+vImoZLmmAIzg6UpVhxGMqM2/sUX9/l5cFYDLKj3sZkwgNz4ogL5jIpesydqFzTZ+i3+UnDSZEiXA4YDVyh4yfdSKciXcKUzDpQmFRPtiNhdjZksirpLb2sB2jHIKSxYm87aFmnG82cFFbiK+VMJ5aoovoKBowKLKrt09xJWgEN38QfgbRV276jDsSB8oXQ4NyhRDatEYu0IUpyQ0MLS8fgCYLnHPqFEHMAt7uDhCku2yJgeZc1EIKUTD8JU0ZUU3zGjmWh2N9bbei3dyPOYce8iFPxsXwWO523fgPy8Wh8u5MSK+sqPMZ9ZbBmHCdfD2KMcrU6VggMFMsCkcX4zCuPQRko472mFkh2kqZkxJTuJCNWsT8xz9aBk66Y10xHr3YWm5OkCS0UmGA46u/lc/76TStc0LLJiZ/1V6IHXD4hcEukII4nY8MAOgAx0+Nb/SRTgAFDcoeIFs4dGF6ro6BGbgXxjalRjyz0c3s2JcL4VnFNHf1qG/ws6UovPzmaUcrXObCFxxVM1PkXQIbamBAKvBX8xvZt49pjeIVQ0bDhlzy48SnC01wQIsC/TZcevCBJQDBeyRaXTef4a9laIYcmVQTuWkrERLu4P5Cp2IYs4L+IOLNMeQq4ZG9jrck2v/ZszOwLV8VV25rehhRV/iC7cTFkwmLKouvXZMJ5eOMxmAaBgyv7rrZlejJi+SWzPYB/IkiAAWW8axIZaXK8o4IM9NJCaTS8SAczffs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(86362001)(31696002)(36756003)(6512007)(66946007)(8676002)(186003)(2616005)(53546011)(4326008)(66476007)(66556008)(41300700001)(83380400001)(6506007)(316002)(478600001)(6666004)(6486002)(2906002)(7416002)(107886003)(5660300002)(8936002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVR4N20vNTVncElmTVpyZFhXMDlqeDFoV3ZjNldYTDFHOU5Gd0NUWXdBMEtP?=
 =?utf-8?B?TE1EcUJwWmNwSkdkYUhxWkFoenYwZVV0R245M2VaaTdYMWxScDNiQ2Vid2Vj?=
 =?utf-8?B?LzR1NWoxL0VySGkwY01mV0tEeGZnMS9xVXJTa0pTb2FVejFZc1dKMVZkcS8v?=
 =?utf-8?B?R291bG5mdzYxVGR6UXBQTTFOUy9oK3pTTmYzM1FXNmwrMzhqMWEvbVhMWTB6?=
 =?utf-8?B?UTF2S1lPNjcrRUFIbGRicXpyVkU1cUpEaStqMjB1dFNlWldrNUZLMHhMTjQr?=
 =?utf-8?B?UDlMSWFTendNL2NENG5EckdUUGVOd2ppaHMwM2xYby9QeXBzZHZrZnA5OWkr?=
 =?utf-8?B?RUVNeGRPcHNCZDBPTGk2Rmk0dk9ua3h3Q29pME1LNjIyUmNqQldLbm5mMmow?=
 =?utf-8?B?NG5YcjJLTmNBWW5rWk9aVVBrd0JyOFQ1dlBURjIxLzhKOEtRVWExSjdocmdO?=
 =?utf-8?B?cjVKTTlHeWdiTlVJMDh3aUJ4c3ZsOFBJOHVIQ2FSUkExd3pRN2tiUmptZEJW?=
 =?utf-8?B?c2Z5RzhEdXRsS2ZCdG04MVNlQ3dZU3NiOFAzNU1aM0QxM0E1T0RMQ1kwSm9z?=
 =?utf-8?B?bnBYUzdWSDU2U1Z4U3M4azN2NnlsOFdmN2NxbW4vZkg3ZnFERTlGZnFrSEpX?=
 =?utf-8?B?MDc0YjBOQ0p4WVIyOEZGdkkzU2crcDFtMEVmWEprRWw1QjRDMzY3bnAxa295?=
 =?utf-8?B?OUQzY3BhcWJ0bjFzRTdpdEl6Y2VpZzBwZkZoeHNXT3RqWHNnVXQraldxOExX?=
 =?utf-8?B?VXVQL0VkSnE0MkJFSXdpd0VKYS91VkZOcWgwQjlkNnhDc1FNR3BweTJQOWkw?=
 =?utf-8?B?MEVWdXFXQWpuRHJoWjEwOUt4SVlUc3dzSHBwdGVnWE5VZ3dsNDU2MlhCRGdo?=
 =?utf-8?B?TGJGam5OWjByR1FGYjFLYzlIVkpQTjVOei9ySUNHcWRiU3BhQ2krV2R2bXov?=
 =?utf-8?B?VWtWZHdiaG81ZDZWY25zcEZ5S3U0WnN2Y1luRmpYM1JUbEZkMHJ5WXZJZEZv?=
 =?utf-8?B?QVdxRW5aalpNamFwcUpwdEFNcnRUN0xXbFhTSURnYUtmS2FoOW5ZVFc3TWtI?=
 =?utf-8?B?ZDZLNjdNZzB3TGxpbE1kanNzRmxkcFNsTnpMRFFHR1ZjVlliRXhKWng4Mmtx?=
 =?utf-8?B?RFFYSG94UGg2dU9FSDd3M1Y4QURGemllN0x2ak8zazloUGQ5bDgvRHBoY2VP?=
 =?utf-8?B?anRKR3c5K1QxdGo0YTZSd0ZITUZSR3hqMUN0ZWNoVE1nNmxYL01LSVFRcGg1?=
 =?utf-8?B?THR5TGRmT1g4ZktJS01aUGtmZ3FLOEk2WHJQY3RBdkM1TFIrYnd3REF4eEpn?=
 =?utf-8?B?MDFWbVJhTEJGT1NIekJ2Y2tEeTc1ZFdRMHdYRTdoM21NclBDak9PbksxZFRs?=
 =?utf-8?B?TU9FWlJOc004dXF4a1NwS2pJVlJXUXpVK1NBSTRSOUV5MVI5U1dNSjBESFIy?=
 =?utf-8?B?OFN4dUN6UG9Gc1ptdi96anB4UXZVWVB3R2o3ODRCRDVQNDROL0pRSWVmR05j?=
 =?utf-8?B?ZWhNRVo1MGkwa1lhM2lIbENKellxVlFJck1GRGNpeVNPOGRoWmxMRklHbDFV?=
 =?utf-8?B?c1crZVNobGZxbkxYdllwMUtVc29lUUhuSEs4MHdvQzRjc2dXVGlRWXdlai9s?=
 =?utf-8?B?aHJ1bXZEa20zRERraTMvR1A1azArbzd0WjNHWkZwamROSjdFT3JmVHBiUUlR?=
 =?utf-8?B?dXFUZ1Rod1d1dVY3a2gzWUNTUjRVa01ZYVo0ajR4YUd5WExrc0ZDTnhrMnFS?=
 =?utf-8?B?dFdhZzlvMVVKNWZIYzhRZFVjYW9SUnhBb3FsRWFIWXB4U0dHZEJjUXlmWXhj?=
 =?utf-8?B?WGN4U1BLdkk4Qm5aaVMzNGhvczY2ak5yeS9ZQW8xem1EQmwrVjd6S0MzUW5F?=
 =?utf-8?B?NitWRFBPMklTVDEwNm9hbHUvVzM1dnNhM2d4QWNlRTFQMUpVNGMwREl4OU1Z?=
 =?utf-8?B?Sk5mZC9RenJ4bE9Oc3E1ZDkvbjhhWVgrTUt5akNFemQ1SStpN1FwNnhXZ09t?=
 =?utf-8?B?dy9sVzZldzU1L0ZVUGZZN2JKRW5yeDJua2l4SlhwMTYyOTZlSnU4NlFKT1py?=
 =?utf-8?B?TjJxWFV3Q3NvODQvQmdpbFlhaEFtTXA2OUFGTzVnRSt0QVRjdlN0dzJOL3Nx?=
 =?utf-8?B?UzBybFNyT1lRdGc5MWtLOThGMUZ0Ty9nWnVVMllTQi9qbVhta3BBelNFYTlO?=
 =?utf-8?Q?bxsYK+1/mA60jUN7wDRtF90=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UVBPNGsvVmxvdVFvVVlWWEMvcWRMYjVEVFZsL0xXb2RLTWliUkxieFFmUUJo?=
 =?utf-8?B?T2dvcHpGa1hOY3QxWENBRThJVHVNbXRSVTZkdHpWMWlrbG5mVmU1Y1JoN2p0?=
 =?utf-8?B?SnNpbVBFcFlpbmVtR1ltWFVQVlNTS0p0NTRYaEhQM1luekF3RXB5YVBYTU1V?=
 =?utf-8?B?OTNpdlJoTldYSzJac21FSUJaYWRqbGdBOWVhby9UODB6elhQSjRMTUJFRW4y?=
 =?utf-8?B?bG52V2pBR2pWcWJLbnFZd2o4WVM2SG5yQ0hsbmhMSGUyb2phd2F2ZUdCemNY?=
 =?utf-8?B?S0o4a1Frb2dlTFNoaVdpZ1hBQWdlNVdKL2pIV2lQeXpNRlBRRFZIVnNSNVZv?=
 =?utf-8?B?YitkWkRFN2lyaVpMRjg2dmxUYTAxNHhkaDQ2QjlMYVA4c0VDQVNwSmpnTDJy?=
 =?utf-8?B?U01hdGxLWDBuK1o2MW4xTTg2N21WVHgyWVBjd1dlbUh6Q2dYNTUvbldGYU1w?=
 =?utf-8?B?dU1NbVFiUHFhTmovcEhZbHdrYVFieTZUR1Npdjl6U0JDU0QyNXJTS1J2L0Y4?=
 =?utf-8?B?dHhtNVFZV0d5aXpkV2kzYnA5bmt6dTZheVpwZHNUV0hwUzRPNitRdEQrdWpK?=
 =?utf-8?B?c0F3WStIVFR2alc1ZG1BQ3JPMjhGbFcyVUlJWEwvd0g0Vm51VDViaVo4L0dX?=
 =?utf-8?B?YTVnSkVVeXBhSWxjTGlUL1ZqRXJFN2tDcG1jblByM3pLVnhJVTltS0RCUVQ2?=
 =?utf-8?B?amhMVktJV1Fyc3lqR3RzdkthU3dERkptL213dUZLaXJrcTZxMW5qbVNpOVNN?=
 =?utf-8?B?bkk3R1VKRk40elVEN2ZCN29UVytybDE1RS9kZGtveUppelBzZFBaUlEzM3gr?=
 =?utf-8?B?MjhFUU5XTlkyb2svUlIvbzhhSWlTaGw4L2o0MHJxcG1Mb081TmFiZ1E1OS84?=
 =?utf-8?B?ckk4NUVZbFF2NVpqS3VCR0VHZkVQWTNtd1VYQVE4M29wZU90MHJSb2lBblM4?=
 =?utf-8?B?bit2THNnbHlxODNua1N6Ulp4MXRzU1FwOWtXVlk1eFhPSG0yaEJoNzAzZlpV?=
 =?utf-8?B?RCtqaXpEUlY5S0RuZFNHbHlRVnZGR2hCMGFJaXRnb3ArZlFCK1ZjWGZFRGt3?=
 =?utf-8?B?RlJ5SGlmU1dYZWxRZEpGZ2tGZnpDMXBGSG03WHgyRXRJOUllVEE2Z28vM3NE?=
 =?utf-8?B?TW1YdTBxeWdmMVA0V3pxMWlEa3pJYXEwTUs4K0thUU9tbVErd2VBTGtCYW9n?=
 =?utf-8?B?dE0wZlphb091ZklFM25DM1dQRmN5QzZUeHdhRTRlYTN1ZXBhc2s2YlhKVHJr?=
 =?utf-8?B?RmJCazlMT2lnN094L1luYnBBWHV1MkJQaEpjZDhGUG5MTlVXUEp4WlhORVhi?=
 =?utf-8?B?WGJHOXlPVWVyclFvZ29pVWpyc2JoMUxGMWRvdkVmM1hSYnFlRFE1eHZ6bHIw?=
 =?utf-8?B?d3cyNjJLMWdGT1J2Sjh0UFF1QzFpelh4QVhhUGlOWGR6U3BITDg3MnVYVVlI?=
 =?utf-8?B?aEFDQXBzTkM0c3pjNTFYalBNc3JUUDFsaWJUMkYzU2FUUVN1a1F2emZ3M2VN?=
 =?utf-8?B?djZWbkZDcXZMNWs3aU82ZkNHSDZkVlByM05UK1FmOStBOHBkc1JRK3JMeGd0?=
 =?utf-8?Q?1ZRmWcY5zGSu2V6zFS+DX+T2E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a32529-2da6-4022-603f-08daf8dad14e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 22:33:13.0429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfIXJtZIn7QaEYaxIaPSwxIUpVgEzt6p/lLUWv8XBrUD/LeC4/LLFSYrksSLXFN1uRMLa+vfLQVGK5y9QqqTYxvc81XcHThO3ytyIUlA7Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170180
X-Proofpoint-GUID: caZ5HGp8ZI6yCUCYfVSXZk-tY61NYThI
X-Proofpoint-ORIG-GUID: caZ5HGp8ZI6yCUCYfVSXZk-tY61NYThI
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/23 11:23, Eric DeVolder wrote:
> 
> 
> On 1/8/23 23:05, Sourabh Jain wrote:
>>
>> On 09/12/22 21:06, Eric DeVolder wrote:
>>> At the outcome of this patch set, the crash_prepare_elf64_headers()
>>> is utilized on both the kexec_file_load() and kexec_load() paths. As
>>> such, need to move this function out of kexec_file.c and into a
>>> common location crash_core.c.
>>>
>>> No functionality change.
>>>
>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>> Acked-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>   kernel/crash_core.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
>>>   kernel/kexec_file.c |  99 -------------------------------------------
>>>   2 files changed, 100 insertions(+), 99 deletions(-)
>>>
>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>> index a0eb4d5cf557..46c160d14045 100644
>>> --- a/kernel/crash_core.c
>>> +++ b/kernel/crash_core.c
>>> @@ -10,6 +10,7 @@
>>>   #include <linux/utsname.h>
>>>   #include <linux/vmalloc.h>
>>>   #include <linux/sizes.h>
>>> +#include <linux/kexec.h>
>>>   #include <asm/page.h>
>>>   #include <asm/sections.h>
>>> @@ -314,6 +315,105 @@ static int __init parse_crashkernel_dummy(char *arg)
>>>   }
>>>   early_param("crashkernel", parse_crashkernel_dummy);
>>> +int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>>> +              void **addr, unsigned long *sz)
>>> +{
>>> +    Elf64_Ehdr *ehdr;
>>> +    Elf64_Phdr *phdr;
>>> +    unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
>>> +    unsigned char *buf;
>>> +    unsigned int cpu, i;
>>> +    unsigned long long notes_addr;
>>> +    unsigned long mstart, mend;
>>> +
>>> +    /* extra phdr for vmcoreinfo ELF note */
>>> +    nr_phdr = nr_cpus + 1;
>>> +    nr_phdr += mem->nr_ranges;
>>> +
>>> +    /*
>>> +     * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
>>> +     * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
>>> +     * I think this is required by tools like gdb. So same physical
>>> +     * memory will be mapped in two ELF headers. One will contain kernel
>>> +     * text virtual addresses and other will have __va(physical) addresses.
>>> +     */
>>> +
>>> +    nr_phdr++;
>>> +    elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
>>> +    elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
>> Seems like above function is out of CONFIG_KEXEC_FILE but some of the
>> structure/attributes like crash_mem and ELF_CORE_HEADER_ALIGN are
>> still defined under CONFIG_KEXEC_FILE (look for include/linux/kexec.h).
>>
>> This leads to kernel build issue when CONFIG_KEXEC_FILE is disabled.
>>
>> Thanks,
>> Sourabh Jain
> 
> After looking into this for a bit, to allow hotplug without kexec_file would require quite a bit of 
> code movement. Why? Because hotplug is basically built on top of (part of) the infrastructure that 
> was needed for kexec_file.
> 
> I'd be inclined to suggest that KEXEC_FILE be a required dependency for CRASH_HOTPLUG, ie:
> 
>   config CRASH_HOTPLUG
>          bool "Update the crash elfcorehdr on system configuration changes"
>          default n
> -       depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> +       depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> 
> 
> If that isn't feasible, then it would appear quite a bit of surgery is needed to properly separate 
> out the items hotplug needs from kexec_file.
> 
> Thoughts?
> eric

I completed the changes necessary to move code around to allow this to work outside of KEXEC_FILE; 
in the end it wasn't too bad. I'll include these changes in the next version.
eric
