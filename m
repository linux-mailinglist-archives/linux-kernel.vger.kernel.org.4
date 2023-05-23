Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F3870D3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjEWGPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjEWGPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:15:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FBE11F;
        Mon, 22 May 2023 23:15:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6E8lk018845;
        Tue, 23 May 2023 06:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8OiK4hjXg2KRW+xS8qsVOifyZQRciGo8Nxn7P4/Gr4I=;
 b=vP/WPZ3Ume7e7XPXy1pAk8TJRp15SFK/cUcbr+tbZvzLFt1Rqf+QHy3HcEykE25C9mqr
 9YtCAYB2TUe7twNRwvjk0C2BYVFxV+8QmmZ5QN5YeozG5fkHThKS98jxMxMW1ZvZQ2Wl
 HZUkt0WYXEecmERcv6hXf5JOdyutduVlG694WTqcu6rHIdVcOp9DXRuBa7OVl7Z+ld2h
 4qsFJglS51zejNq28oH2vSFJ7cQ5C7J5v6HU73aQsVg3dAnJHeqFTfZ25u6I+b4t29XA
 ztehKiVUWBwLueBPVdQcwNvi9V39gljCTIgn9mNhBkx+JvS3zsL52EUGBPbG+4HWXz2r pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3qm9wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 06:14:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N4LEHj013663;
        Tue, 23 May 2023 06:14:13 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7ecyts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 06:14:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRYHuZaKTM4xZX6ZJtrF6akcf+euGJUH/rCg3/XhFP/ugRbeaQKwgGy4wGQigU12HJqpXL1IU/Jt1nhjeGARCIfDVAgbf+PT1vmDolrSK45Z2GFDdpY3Nq9ZVa0fux1bleLAbMST2CcPAdexRcIdRYZZGAqci3+fkIPi4v3muhrMBmZq6EYUr0hMGFOi9rI6k4Pp7hbY0o6+Dckqq19Jza1+TjcZv9uzok9fCbUpifMEZW1bmjJdzOGHNIszE0CCCFnxbspsBiVa9EffDKnhJC8aoqaOSoruZ1sff221VDrI3Lsv5oFVMCxPbhol8YLR/kbZpdK3dHKLH0MvUWxFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OiK4hjXg2KRW+xS8qsVOifyZQRciGo8Nxn7P4/Gr4I=;
 b=Xe4YJ7+sip+g1M40sR4rpKT8i/25H/uqjZ7cYjlLGV1+Bb1UGknzxSU9FfJbB/rtlmpdcSIiyl21AyobPEdfE9If++V+n3hEEq/QBVoBBEcYuu8wGCSZwijsRE8goeDkVqoVhRtYYDYIhia3Sp87SyknYJX1lGVrwaXoDuy44MjRyNeDEQae8mzZKz7dmTgh4ux6L+N4jV4JVXP3gcp9CfYgIiTck9U/HVp/AIWyPrBORUFCNvP0qJcaxsk5Myut8L70UwCGxrG5CDuIjPbP731HpG/O/RsMz0p1OlgFJ5HExX5ewVbHXbEG2eLaIfvWMYFRrwsUPL/nm6t2EG02iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OiK4hjXg2KRW+xS8qsVOifyZQRciGo8Nxn7P4/Gr4I=;
 b=GSBEUvkCRJw+davWeAUnD5eoJUycGaqarJliKM+5iDQprp+QgPKKYHPGh35r2uvCFWy8kFa13N1A0yuKETOaOU1OvgrTkMT0Ue8J1wl3h/VjMJYsDWivrClWD8h+OepgmWthREG+5P7CEXNvMo4KJAeAoQbmi+kWXK0s/yt9kvY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5408.namprd10.prod.outlook.com (2603:10b6:a03:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 06:14:09 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%3]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 06:14:09 +0000
Message-ID: <3009ee4e-b246-7259-cbbe-8bd636f354de@oracle.com>
Date:   Mon, 22 May 2023 23:14:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm/hugetlb: revert use of page_cache_next_miss()
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Ackerley Tng <ackerleytng@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        willy@infradead.org, vannapurve@google.com, erdemaktas@google.com,
        stable@vger.kernel.org
References: <202305231207.35d53791-oliver.sang@intel.com>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <202305231207.35d53791-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::26) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5408:EE_
X-MS-Office365-Filtering-Correlation-Id: 89443b68-4617-49ea-f594-08db5b54eb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uS/bXRYndfgvxHmfqE5y4725GWbdAOiZ2i4jUdD9tPt2LAPGmZaFGHaJG8obIZsWKcLMRGrA0IBkp4+DjU443WDlNJ2ke8led7Eaq/1TECqTlMObZ0rMFb2UAMaAhzC5yQDuxDZAvS1YVhgmbSQg+CVT8uCrbQaZ/dacu7j+pNDlheWfHM9ThSlgRcdfyw0eXUawVZpeONQx3Aoux/ihyyXfdsgHsAEPJZGX/ENEENRs18FAvS08zp8PhMU+eHS46eeWDGIasfUBAoiIIp7Gtc241fq9eH7+yoyhXVQ0J7qtnwYP4+sAOCzw4nhVhZe+4qaLnGCa11kbCtgkkQ6xM7rDva+aHQ3eF5kQTMOaQR269KQjwDrOPO11mO5S324lJ9rrTkZ9t3deNDO3q1wtTX1EeNHewOPBVhWFEU63Dr9FaxoDCZX4DGTd7ptC6LihoqE1MSPiCsWYJnamh6QYC6esT4VeBoe1+KowHISJk/T9VmjRCev5Ev+4cg5F/7ujIfeIH2myWYyhMptRDmzxd9KSdOy6mMHtGK+nEvBuIJe69i9DfF5zqAUab9OdwlFQufNv+i7re3KS52BoSSza/aRU22sK6ddhdY2FYMVHUvZVTYRiPpy29aMoDCK7BrLa8XO1EPsr+chv+xYObuktGefMDRv8SwxT7grSJdsjRJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(6506007)(6512007)(7416002)(186003)(53546011)(38100700002)(44832011)(2616005)(36756003)(83380400001)(2906002)(6486002)(41300700001)(316002)(6666004)(966005)(478600001)(31686004)(31696002)(66946007)(66556008)(66476007)(6916009)(4326008)(86362001)(8676002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2V0eEVXUk9xNDVjcmFyRG95Y1lLQzZMOExSM3NlcEZ1OUxpc25maUR2dTJh?=
 =?utf-8?B?eDBOOFVTbVkzWG1NWWp5blMrb1FKNHloL3U4eVhFazZVQ3lMeWtFYllEdm5O?=
 =?utf-8?B?aE8rejBoQnhjVG9YeGlBTmZ2ZnBuL1lxRFFaT1E2ZXRqcHJtWTFxc0FNUnpT?=
 =?utf-8?B?MnEyRDd6WjhqSDF6eGFTaE9rdzhXOGZRMkJNWEtKWmRkcU9sa2c0Qk5uSm9s?=
 =?utf-8?B?T3R3blRkYVJkdUJRYXh3SDc0M3p0WERxbWhWL3FpYUhUbzNrUy9qZnpvSVgy?=
 =?utf-8?B?SjZuY0Z3eSsvd05mRjV4d0p4L1REVGhsNUt0aUk0M3BhbU02UjR1cERsSVFM?=
 =?utf-8?B?S3o0L2ZINnJpN3d5dHBwLzNzell3TTllUEN5SjJYMFhLWUwrTjEwb0xXb0Ir?=
 =?utf-8?B?cFl3dlJmS01GSzNFZ1Q5bStDZEJ4SWcwaFdMT3oxT293cUhEKy9oWHlvRWlv?=
 =?utf-8?B?dDlhQWdNVHArd2VsZldGOG54MnNwQWw1alEwTFd6MlVzVzNxQ3JIVUsrSnow?=
 =?utf-8?B?TWVCc3RZK2d5M3dObkVSNExMZWQ2elhlMUIwOWs4bXQxN1h1VlM5cnVBNW1v?=
 =?utf-8?B?REpocjEyaU9lVktEaXpHd0pGeUV1bjFwakRIY3BaeHErYjR3YW1XaFNOUXJ5?=
 =?utf-8?B?Ry9pV0FPZWtteTUzSzhMSG5XTVAwYkVrVEIydndHUU9lY1J0MUFKRjAwb2Jj?=
 =?utf-8?B?TW0wMTF6M2JtZWtzVnN4UHZrcmgvcG9UVjM1NjZIWlg1bG1PZ05HdTE5R2hr?=
 =?utf-8?B?OHI0SWNxZlY4Nm9WbzlCcUIxMkI1VUpoeS9OZm0yOEhGcEhCS1oyR0dla2hU?=
 =?utf-8?B?Ny9ZQnZZKytrQkpqVTF5Nk5lZitoYks4dk5Qdi9jQ3QvWGhvZGwzSFNncTV1?=
 =?utf-8?B?OGpUQnZMMnZpOGZ1ejBXb2lGQXlzcmtLNFVDMElDWVE1MnZmQ1EweFhqbG1N?=
 =?utf-8?B?MUNIaHE3ODcxOHVXTXBCR1plcjZ3WlZhbmFQbmtuVmlNb2xsUGRKbEowUWJw?=
 =?utf-8?B?Zld1QlJEQ0VFWUxKREZMWUk2cE9oOFozUUpKb2JqREVpMDFsOEhDVE1pNlJG?=
 =?utf-8?B?KzFZdDVZS24wb1pmOWRxS0UxYWtmdEdlRDh1Y1htRkZuUVJyWXNucWV5MnVJ?=
 =?utf-8?B?VmJlaEZ6MG1BSnorQU5xZ1dwQ1IzdFVYc1Z1eU9SSFB6WXcrTTE4dHo3b3Ax?=
 =?utf-8?B?OVJ3bVJQOTlCVG5jL2RQdHhCMlFVbG9Jam9rZEkzdTBid0RpaFdLL1RhRzVO?=
 =?utf-8?B?Q2srMWJ3VXJpWUdZN2JLeDlQVzNRRVRMUFBTK3ZmblBMNDJNMGg3azQ5VWEr?=
 =?utf-8?B?Z293R3B5dFZRR25FTnc5MjBFR1NMTGNzdGd5cGhITU5nS0d1VW9Ra0kxQkQ5?=
 =?utf-8?B?UE9vNmtUZWtlTC9WYTMzL2hSdkRRK0pka1FPUXdWZlc5MTJWYllITi9iZTFQ?=
 =?utf-8?B?MmRUcFQ3VWZIZUwxNUhzTzliZ1pMUm92My9INFJzaW1uS212OHdtUEtURkN0?=
 =?utf-8?B?eG1JUnFMdktsNTdRY08xMjRNVGFOZVROekNyMERRNWNZWDdCRmxGOTh1M2Q0?=
 =?utf-8?B?MGpEbzlCQys2RUY5aWh4NU1heDBuNXpLTGhQRkRqNG95R3FnUG1Cc3lyUFlP?=
 =?utf-8?B?cVhDQ2oveC9JcmUyOE1qTzRZeXZlWE1TNndwRDRFbkp1UERIMXlwMFNSWlc1?=
 =?utf-8?B?Y2g1VWxwNTRidll4K2JKSDUrUldZYXZYNUV3dUVpYkhpZDZYL2tlUGFZNEMw?=
 =?utf-8?B?YjdTVkw4Vm04SjdqMEFlYzZWd2NjTkdySzdyd3ZiTGM3L2J0bFU4bVJKbVd6?=
 =?utf-8?B?UmF2dXFGS2hFUU15OTlieTBNd2hQandaTUxMTmVpUHMySXp4K1VweGc2T3dP?=
 =?utf-8?B?Kzk0YW56VVN5N2x5QTFVbTRVdUlwU2JjbnJVaXZ3KzRVQm5Mc3FGZFdOMXp2?=
 =?utf-8?B?TEdkQXk5TkxLcWFNR3FRdHlpVFplUHdLbTdtTUx5RjlFbW8rWlJQUy92aGNB?=
 =?utf-8?B?VTZqV3BNbFI1Z01Qb2NOeGhLa09kMjFaV0ZpazF5cXpYUUlFYmtNUWwwWFRx?=
 =?utf-8?B?cFliVEVaWnF4dHhnN3ZuL2xRMkFTcFJpNSt5TzBrc1FYRFlicm1icDBZVWt2?=
 =?utf-8?B?dElLbHNHSkNYQStrQlIxeStHaTMxRTZQRE5vZXZvQTVKR1R1NWV3MGNuajdm?=
 =?utf-8?Q?4PRLrmMUm/ZXNggVW/QZQLE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VVo3VGtLRHBSbUJad3BCY09EUjc0YzVHTDhOUS8rSEdDL2dUQUw1SGdmMElt?=
 =?utf-8?B?RGs3TTZSMVo3UDk2K3pQb2IyTnd1cG9LZE1zWlVseit2WW93bk5tRXRia3Ji?=
 =?utf-8?B?MFEyZXZ0Q0J5Vk1PbFpvSFF6dkZKYWE5M1JkWkNXZEJTb0l0eHZrOHkxSUZl?=
 =?utf-8?B?dTRSMFNSZzVEQUZQc1BMbDNiaHE5b05GbkVVTE45Q3crUm5YWVFSQlpMRDZx?=
 =?utf-8?B?UzQ2WThzOVc1QnV1em9adEprSndKSnM5aUlpRWt6Q1VZTGIxVkxCb1RmL00w?=
 =?utf-8?B?NGRJd28xcGhZVHpocDFTVUx1Q3FvQkVUV3NmcExHOG0xOFdHbGxRSzdRQTdD?=
 =?utf-8?B?b3lJWW4rY0Mzb2o2NktZY0d2dFAyWnlUTk93bGVKeEJ4Yk5GUnJFUDNOWVI1?=
 =?utf-8?B?MnhoMFRLb3VWcHNWbGRxaFJBQ3NQUmNOc1JDSkdsdmhEQTNnRG9yVW1tOFBV?=
 =?utf-8?B?QzN3UjFNem9xaDdBUjlrYk9WTWJibFpINllXOThhQ2pmcFFzZTNmUjR0UzVk?=
 =?utf-8?B?WEh4S0UvSGVzR2R5TTNkNHREZmppQkNYL3E2ZnUveGNsYW1SWnhOR3U3WmlD?=
 =?utf-8?B?UDZUQzB1QW1oQ1VxaUpFZHljUjFCdUtyU3ZBYmRzQUY4bVFEOWY2dU5ucFMz?=
 =?utf-8?B?Q1NnMEdXamFtVW43MXNXTVFvTzVoUFNpa2J1ZzNTcElhQStTRDJaeURVWHQz?=
 =?utf-8?B?SU1CV21zRkdHZE5HS2NBKzl0ZXZkaGdENU9zbnhjWWFBUHh5dGpyMW5QaldN?=
 =?utf-8?B?MDhZc05XMHFsbmNQQ1dvSWUvZFFQRStlZFNDNGFEOTRIRDI0YWxrTHJWekFH?=
 =?utf-8?B?eHEvaEl6OHAyeklnSjJHbFVVRnIyM0lJQklYZVE2MlN5MG5xcVZVdEZSZzMw?=
 =?utf-8?B?MFhYYWRpd2I0aGtNNldBUTVHcVJpbXd6a3VIeE9FVGUvTitKZi9nSFFBcVVU?=
 =?utf-8?B?b0QyaTc3REM0TUFxN2VDQ0w3ZVJIa2RGeHZGY0RYSytiajBtODg1ODRhbE5t?=
 =?utf-8?B?TENObVJRd0w3cXRWc3QrVTZKNWdEcWx0S2Y1ZEdWYk4yTjlHNFYwVXlzRzBP?=
 =?utf-8?B?RWtsR2JCQitWWWs1akRObHFmWjZZR0hIZHdZd29VMnl5NXZ0c3FhRS9wSWFX?=
 =?utf-8?B?M05BckkzNlU5ZkEvSnI3aWZmOXMvTkZRd1ZDeWV2NHNkZSthcVdESktNc0Qy?=
 =?utf-8?B?aUJDUU82dW92aGcxWXVRN2NzNXdZYktKSVBVUVMwKytVTWZEU0RXZnFhVEVj?=
 =?utf-8?B?aXlNQXdHamVYM1c0VG1JQ0N5VEdRR3ZlakE4YWcvQW9XOU5NVTdYZktLTVZ0?=
 =?utf-8?B?UjNhZ2x5Y1ovTVVNNVI4WTZxdXZZZ2dqd3pyVmc2aUIyOGhBRDVJWll3dXBU?=
 =?utf-8?B?TGNXMEJPeHdIa0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89443b68-4617-49ea-f594-08db5b54eb77
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 06:14:09.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4KyuI6Vvc1wK6ws/P22Zzcm49g5mFbX+Zspl7lAWTpiU6tN7ZT1bnm+w0nvJs5HdYMdgZ1QzGB1GzzdS/zO6uGeajT4rpC4Mi/h5A0C4aM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_03,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230050
X-Proofpoint-GUID: wpEV14zTKLVQw4s3XxIvorFnigKlA3G5
X-Proofpoint-ORIG-GUID: wpEV14zTKLVQw4s3XxIvorFnigKlA3G5
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 10:00 PM, kernel test robot wrote:
> 
> Hello,
> 
> kernel test robot noticed "BUG:KASAN:null-ptr-deref_in_hugetlbfs_fallocate" on:
> 
> commit: 1f944358dbb5e9a6493fd7b1f77ee64376d2bdf1 ("[PATCH] mm/hugetlb: revert use of page_cache_next_miss()")
> url: https://github.com/intel-lab-lkp/linux/commits/Sidhartha-Kumar/mm-hugetlb-revert-use-of-page_cache_next_miss/20230506-025434
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 78b421b6a7c6dbb6a213877c742af52330f5026d
> patch link: https://lore.kernel.org/all/20230505185301.534259-1-sidhartha.kumar@oracle.com/
> patch subject: [PATCH] mm/hugetlb: revert use of page_cache_next_miss()
> 

This test is using 6.4-rc1 as its base where __filemap_get_folio() has 
been converted to return an ERR_PTR() rather than null. I believe this 
report can be fixed by doing:

		if (!IS_ERR(folio)) {
			folio_put(folio);
			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
			hugetlb_drop_vma_policy(&pseudo_vma);
			continue;
		}


However, I was targeting this patch to be applied to stable 6.3 as it's 
the simplest way to fix the current user visible bugs mentioned in the 
commit. Because it's unclear the direction upstream will take to fix 
this issue, as there is also the option to take Ackerly's patch[1] 
rather than using this fix, I'm not sure if I should send a version of 
this patch with 6.4-rc1 context. Please let me know how to proceed.


Thanks,
Sidhartha Kumar

[1]: 
https://lore.kernel.org/linux-mm/98624c2f481966492b4eb8272aef747790229b73.1683069252.git.ackerleytng@google.com/
> in testcase: trinity
> version: trinity-x86_64-abe9de86-1_20230501
> with following parameters:
> 
> 	runtime: 600s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> compiler: clang-14
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202305231207.35d53791-oliver.sang@intel.com
> 
> 
> [ 144.098719][ T1547] BUG: KASAN: null-ptr-deref in hugetlbfs_fallocate (inode.c:?)
> [  144.099404][ T1547] Read of size 4 at addr 0000000000000032 by task trinity-c1/1547
> [  144.100071][ T1547]
> [  144.100282][ T1547] CPU: 0 PID: 1547 Comm: trinity-c1 Not tainted 6.3.0-13165-g1f944358dbb5 #1 1f0cfaa9708c3e99bb7e2ecf8f7fd22c51fc3e3b
> [  144.101310][ T1547] Call Trace:
> [  144.101602][ T1547]  <TASK>
> [ 144.101858][ T1547] dump_stack_lvl (??:?)
> [ 144.102269][ T1547] print_report (report.c:?)
> [ 144.102655][ T1547] ? start_report (report.c:?)
> [ 144.103044][ T1547] ? hugetlbfs_fallocate (inode.c:?)
> [ 144.103497][ T1547] ? hugetlbfs_fallocate (inode.c:?)
> [ 144.103937][ T1547] kasan_report (??:?)
> [ 144.104270][ T1547] ? filemap_get_entry (??:?)
> [ 144.104656][ T1547] ? hugetlbfs_fallocate (inode.c:?)
> [ 144.105082][ T1547] kasan_check_range (??:?)
> [ 144.105503][ T1547] hugetlbfs_fallocate (inode.c:?)
> [ 144.105921][ T1547] vfs_fallocate (??:?)
> [ 144.106317][ T1547] ksys_fallocate (??:?)
> [ 144.106702][ T1547] __x64_sys_fallocate (??:?)
> [ 144.107121][ T1547] do_syscall_64 (??:?)
> [ 144.107521][ T1547] entry_SYSCALL_64_after_hwframe (??:?)
> [  144.108022][ T1547] RIP: 0033:0x7fedb9a039b9
> [ 144.108398][ T1547] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
> All code
> ========
>     0:	00 c3                	add    %al,%bl
>     2:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
>     9:	00 00 00
>     c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>    11:	48 89 f8             	mov    %rdi,%rax
>    14:	48 89 f7             	mov    %rsi,%rdi
>    17:	48 89 d6             	mov    %rdx,%rsi
>    1a:	48 89 ca             	mov    %rcx,%rdx
>    1d:	4d 89 c2             	mov    %r8,%r10
>    20:	4d 89 c8             	mov    %r9,%r8
>    23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
>    28:	0f 05                	syscall
>    2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
>    30:	73 01                	jae    0x33
>    32:	c3                   	retq
>    33:	48 8b 0d a7 54 0c 00 	mov    0xc54a7(%rip),%rcx        # 0xc54e1
>    3a:	f7 d8                	neg    %eax
>    3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>    3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>     6:	73 01                	jae    0x9
>     8:	c3                   	retq
>     9:	48 8b 0d a7 54 0c 00 	mov    0xc54a7(%rip),%rcx        # 0xc54b7
>    10:	f7 d8                	neg    %eax
>    12:	64 89 01             	mov    %eax,%fs:(%rcx)
>    15:	48                   	rex.W
> [  144.109953][ T1547] RSP: 002b:00007ffdf492f6a8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
> [  144.110612][ T1547] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fedb9a039b9
> [  144.111233][ T1547] RDX: 0000000000000008 RSI: 0000000000000000 RDI: 000000000000011a
> [  144.111870][ T1547] RBP: 00007fedb839a000 R08: 0000000000000020 R09: 0000000000000090
> [  144.112514][ T1547] R10: 0000000000000800 R11: 0000000000000246 R12: 000000000000011d
> [  144.113168][ T1547] R13: 00007fedb9ad1580 R14: 00007fedb839a058 R15: 00007fedb839a000
> [  144.113814][ T1547]  </TASK>
> [  144.114073][ T1547] ==================================================================
> [  144.114752][ T1547] Disabling lock debugging due to kernel taint
> [  144.115284][ T1547] general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] KASAN
> [  144.116161][ T1547] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> [  144.116830][ T1547] CPU: 0 PID: 1547 Comm: trinity-c1 Tainted: G    B              6.3.0-13165-g1f944358dbb5 #1 1f0cfaa9708c3e99bb7e2ecf8f7fd22c51fc3e3b
> [ 144.117939][ T1547] RIP: 0010:hugetlbfs_fallocate (inode.c:?)
> [ 144.118431][ T1547] Code: 84 9c 00 00 00 48 89 c5 48 8d 58 34 48 89 df be 04 00 00 00 e8 d5 83 ca ff 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <8a> 04 08 84 c0 0f 85 d8 01 00 00 83 3b 00 0f 84 3a 07 00 00 48 89
> All code
> ========
>     0:	84 9c 00 00 00 48 89 	test   %bl,-0x76b80000(%rax,%rax,1)
>     7:	c5 48 8d             	(bad)
>     a:	58                   	pop    %rax
>     b:	34 48                	xor    $0x48,%al
>     d:	89 df                	mov    %ebx,%edi
>     f:	be 04 00 00 00       	mov    $0x4,%esi
>    14:	e8 d5 83 ca ff       	callq  0xffffffffffca83ee
>    19:	48 89 d8             	mov    %rbx,%rax
>    1c:	48 c1 e8 03          	shr    $0x3,%rax
>    20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
>    27:	fc ff df
>    2a:*	8a 04 08             	mov    (%rax,%rcx,1),%al		<-- trapping instruction
>    2d:	84 c0                	test   %al,%al
>    2f:	0f 85 d8 01 00 00    	jne    0x20d
>    35:	83 3b 00             	cmpl   $0x0,(%rbx)
>    38:	0f 84 3a 07 00 00    	je     0x778
>    3e:	48                   	rex.W
>    3f:	89                   	.byte 0x89
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	8a 04 08             	mov    (%rax,%rcx,1),%al
>     3:	84 c0                	test   %al,%al
>     5:	0f 85 d8 01 00 00    	jne    0x1e3
>     b:	83 3b 00             	cmpl   $0x0,(%rbx)
>     e:	0f 84 3a 07 00 00    	je     0x74e
>    14:	48                   	rex.W
>    15:	89                   	.byte 0x89
> [  144.120027][ T1547] RSP: 0018:ffff88812ba3fd48 EFLAGS: 00010206
> [  144.120545][ T1547] RAX: 0000000000000006 RBX: 0000000000000032 RCX: dffffc0000000000
> [  144.121198][ T1547] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffff8a927100
> [  144.121864][ T1547] RBP: fffffffffffffffe R08: dffffc0000000000 R09: fffffbfff1524e21
> [  144.122535][ T1547] R10: 0000000000000000 R11: dffff7fff1524e22 R12: 0000000000000000
> [  144.123214][ T1547] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000fffffffc
> [  144.123947][ T1547] FS:  00007fedb9ad1600(0000) GS:ffffffff87f0a000(0000) knlGS:0000000000000000
> [  144.124701][ T1547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  144.125263][ T1547] CR2: 00007fedb95005fc CR3: 000000012dfd0000 CR4: 00000000000406f0
> [  144.125925][ T1547] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  144.126601][ T1547] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  144.127277][ T1547] Call Trace:
> [  144.127584][ T1547]  <TASK>
> [ 144.127848][ T1547] vfs_fallocate (??:?)
> [ 144.128251][ T1547] ksys_fallocate (??:?)
> [ 144.128646][ T1547] __x64_sys_fallocate (??:?)
> [ 144.129072][ T1547] do_syscall_64 (??:?)
> [ 144.129460][ T1547] entry_SYSCALL_64_after_hwframe (??:?)
> [  144.129972][ T1547] RIP: 0033:0x7fedb9a039b9
> [ 144.130359][ T1547] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
> All code
> ========
>     0:	00 c3                	add    %al,%bl
>     2:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
>     9:	00 00 00
>     c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>    11:	48 89 f8             	mov    %rdi,%rax
>    14:	48 89 f7             	mov    %rsi,%rdi
>    17:	48 89 d6             	mov    %rdx,%rsi
>    1a:	48 89 ca             	mov    %rcx,%rdx
>    1d:	4d 89 c2             	mov    %r8,%r10
>    20:	4d 89 c8             	mov    %r9,%r8
>    23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
>    28:	0f 05                	syscall
>    2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
>    30:	73 01                	jae    0x33
>    32:	c3                   	retq
>    33:	48 8b 0d a7 54 0c 00 	mov    0xc54a7(%rip),%rcx        # 0xc54e1
>    3a:	f7 d8                	neg    %eax
>    3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>    3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>     6:	73 01                	jae    0x9
>     8:	c3                   	retq
>     9:	48 8b 0d a7 54 0c 00 	mov    0xc54a7(%rip),%rcx        # 0xc54b7
>    10:	f7 d8                	neg    %eax
>    12:	64 89 01             	mov    %eax,%fs:(%rcx)
>    15:	48                   	rex.W
> 
> 
> To reproduce:
> 
>          # build kernel
> 	cd linux
> 	cp config-6.3.0-13165-g1f944358dbb5 .config
> 	make HOSTCC=clang-14 CC=clang-14 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=clang-14 CC=clang-14 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> 
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 

