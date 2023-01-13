Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03704669BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjAMPZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjAMPZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:25:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86C3A1812
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:16:55 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DE287V022892;
        Fri, 13 Jan 2023 15:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TJoxEdURVz9o4IXt3n63CbhEH2ugPeBreDM2YByzG9g=;
 b=qBxV+dLJz5z3dtvZ4ycssjuIiNwmjaa0uMHkoRFYOCyYIJtoo+9kLMN+v3fY4jiSsqxH
 2swbHBq6IidG8LqWZ6dqHhTco5701xNF0xbJvrmbJuN1BpF5eL6z+eSWHbV+pG3uOyP8
 dS7tonRkaUbyaxuMhTOty7J9eLJYCdSPmLXDtysOr9eJcOzp5E6lKq9nvpanxPeIGq9q
 ctFli6lBWGqvn00BifSKGeMTExWmyqU7fTP0Cy5FKKQJxMDOaPU7jktuvGzILUmj6vUI
 GBAo2WZl2bZuDFwN+4Uxf1XWNQVMSASuceyQJgPzh4ypdFLmd7cED9VSLUmE72+K9gpt 3w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n362w8eb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 15:16:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DDfVpF033598;
        Fri, 13 Jan 2023 15:16:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4rsyk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 15:16:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNONgAbi2DH4JMe3tQtxcb/TmDcgSkcfJQ+CHQlyC4zmjK2jUZrUnSLWsZyb4IxBZfSRI8q+ka/6mkolsGFXKbQHcF7a7ZDfJPJg1yETZJJi96cVLKC8yMp7LCAEcqmByZz2udb5AfXEqwewlCNYALFZ6uHSU+NK8g0BY4xGk0BoSufX38r7ZWcr/0Q2ZRmXv+3LHSSfVuFSs736uzbCj85hIJ7aGePOvCOucPEUHjQ3oj6zgh/qE2Xx98tCbCY5wh2M3oxFoKP8btRatubocvP8Z27Rgmt2C7dWVOXiRyAKX3WbQ/CH961EHNjXZFxGhYI5c0QQHUuNGQrrdIFqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJoxEdURVz9o4IXt3n63CbhEH2ugPeBreDM2YByzG9g=;
 b=dcThWvG9TRzFZa1ALUhNYL5pDuWpC+3WFsytU2haR66Vm77HH46weF4UUiabsO81eReWPqjHqWOlhMed++eDpw8aQ/3EvUYtpl/eVqYwaE5g6B1ET6Qomifei4hMZL80E7SGDQhAG//32VYrzjTSFdO88RA18lBjlF5VZlugTup360iGKuF9VQtnIT0lvWPBO3S/FfGYxSy+xC+J87LBkJMZuepy6xcIRe+XlMYUC7T6q+Aj6GZ+tniJhYm7sM3G0PVaf7M9OO1oDdQUdzB6q9APT/zefcVvIW7Gsyf4L2h6yA8PhX5i2nVCfypUfuS4ex0nhm7Ud7gbQBh+wimfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJoxEdURVz9o4IXt3n63CbhEH2ugPeBreDM2YByzG9g=;
 b=jBsBXSi4uPlVKHjd0ezj3e+3+kJVM60Gd8WdFNfDRrBfZwdCJb3fNcvs/3H9qaJfczb77lTPLnSyNCpmfGCCaXqbhe8RayHhCi2/0JkjtNdKKF6EhkbOfuTRwNxFFDZnWSy59RK05paeC4+INXl/E0+9Xo8iif91xwOj0s+afb4=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by SN7PR10MB6406.namprd10.prod.outlook.com (2603:10b6:806:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 15:16:26 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Fri, 13 Jan 2023
 15:16:25 +0000
Message-ID: <2f9ef115-a508-090b-d804-23235a447063@oracle.com>
Date:   Fri, 13 Jan 2023 09:16:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm-unstable v2 8/8] mm/hugetlb: convert
 demote_free_huge_page to folios
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        jhubbard@nvidia.com
References: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
 <20230110212821.984047-9-sidhartha.kumar@oracle.com>
 <Y73bP5CFT/8T/DvO@casper.infradead.org> <Y738EQkRcgv1eO66@monkey>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Y738EQkRcgv1eO66@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:610:cc::27) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|SN7PR10MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: dff5c86e-9fa6-4cf0-0521-08daf57922a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dtJtDg/4B6fF7ZdCI/wyiK3z8sKmmycfImu1cuRjKYLoDJrDL7Sn8bUBNDptDvJlQvMhqEvfBDTMNbT443BT+p6oO5y4M5M5m+DZ6yYln5XcMOdyD/NRPhflTQLF9pUUolp1io9HqBIRnCBMaANaW/PGv8ULSuLGh9ZNEkuOH5k4Ca+rJRG0MZPjcmVM0w+L42K3dcZ55JEEiqISXdUrkcaBw1OVLEy3Gz0qMF4vJvVN2lZ+EbP1Cnc7gb5axmDUYDkRbI6Jvt/TVCBmAUWFx+x3SI5wzdEIAxRggNGdBTj2CL/yyFFOLCcMJm4nLYATdWqpdTebuU518UAldVmzWxd7zLk5yj80/ROmMd1+Af6vmi0QUaJiksMyP+uAHviCDqIx+B+4Qzn+420EfrZezcc+ecWwiDudHPKfr8a/SNoaRhq7ofOEj4wJ0eugs17wQfOdtUzTAxElpWGDgnpTytL7hjd4alDROETWIEbw1e3vD1IkD54Rk6zIiCDHUikPy3ALHO0Ub1UHfblifYwitpPCzbV9U+2IoDLw4LDOcSf5D4z6DoIeL9Mim0Q0FQrPlU/AjUS6Dc6xkJ+q2u+dmx/fthFbyAQ5C34oBFguo8/6oeY368kTFL7qzuF5OTbwX3WHpkGSpwmxmpDieqCl6pILVTHNSeNwcHiaMxS8LbWLBQ/SVjxFFfC+JMUZ4UkhoX8SlMueApPlLuigyBilH2i4CRasyMi/lI6qpmc8E647vgyR7JIVSnrACWYpUgDM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(66476007)(41300700001)(31686004)(316002)(8676002)(66946007)(5660300002)(66556008)(110136005)(44832011)(4326008)(8936002)(2906002)(38100700002)(6486002)(36756003)(478600001)(86362001)(186003)(26005)(31696002)(6506007)(53546011)(2616005)(6512007)(83380400001)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlltQmdLeUFzby9WRExncFZQdzdiSUtPNVFGZFdYd3dmaUhvRWZOeEJ0MFZN?=
 =?utf-8?B?ZWc3dm9ZVnRGdlBMbUhsTTlIQU0wRlNjUVU2VVJwdU9QNWl0dDR5bTNLYnJz?=
 =?utf-8?B?Zm1WeFJKbGVZclZzaFlYdlJ4OGZtSnEwL3QxOVBWTnBDVDBBdUlsU3pqQzU2?=
 =?utf-8?B?R01KNFF0Z3RQSFNLaktKVzc3S3h4ekgvUk81WlBHRHRHeURrMXdGUStIRlpQ?=
 =?utf-8?B?bXRHNXd6NXBYRG1iYTRybGQrbmdzOTRrV1JObTBna0lUT2cxM1M4WXhONEMr?=
 =?utf-8?B?S3JpclA3eUR6NHZzck5idEZRdzNDK1VJTnNqZis3b3pJRXpUWVFLcjY1Vy9Z?=
 =?utf-8?B?Yk5MUDZYYmpWdFFEZlhrSlZNTG9URXcwSWZ2Slp6c1I2elRzWlNxa2U1MmtG?=
 =?utf-8?B?VWFabkQyb3FvcU1zN2kzTWxlVE5SSkYyZWVIdCtCT1pxN2ZGZ21QNHZVWXVS?=
 =?utf-8?B?RWYyUXNhVmVFTTNuc21HZzBiSFFFSGZpYlNPM0dVNWszUU9WMTk3Y3ZaSHBU?=
 =?utf-8?B?NFJYYjhRdFFqcG11Vk0vY0tCOXBJOFpnaXpXcjZRMy80RitqOWVZcWlPdkw4?=
 =?utf-8?B?S2RRN2JMZXhFSW0zUTNuU0tqcFVscWdTNTJBYW9pVnpWbFRKdTBZNHRQMG9s?=
 =?utf-8?B?aFA2ZDViaGJzNmI5ckFreFZTRG01aHcyRDFLNFJRbytBSFNPWWpXRFQ4K0t1?=
 =?utf-8?B?R1RGKzQ0K3hkY0RkUzAvY0ZuSmZEUDh6YXh5SzNRb25PcWxzMHYxV09iNTVy?=
 =?utf-8?B?elIvUnBWbHVSSHRVOXh3ZThFK01ySUhBSXVzQVR2VUN5dHpFVWxQUEtxSGpW?=
 =?utf-8?B?aElKckxHVkRjS0VlaFJZNUkyM1UrcnlidnJQYlhCRnJLbk0yS0lMblc2ZGFa?=
 =?utf-8?B?RmRUWnlHc2RkSW1iUHhGN1MrQVZBUzdIQUgzRjVhdFR0a05meURrYjVLa3dt?=
 =?utf-8?B?S0taSW5aSExmSy9VR0VQS1FPZjMwK3QyWGpCVFREME8xR0dqUFVoVlk3TW9z?=
 =?utf-8?B?OWd4Y0pwOXZHdTE3S0pWcjJhQnRYUlNPWVN4ck4rOXNScnhnWk5QNnE0QnIy?=
 =?utf-8?B?SHljclViV3pUd3JkRitZeEFzUFVqV1BQSFJ5ZzltWlNaY2JVaUlhekgvZ3hX?=
 =?utf-8?B?SGpuMFFrTHNKV2h3OGFSNWJsRmxQWDRSK0VLSGxsYWx1TDFaa21JVytHNmJz?=
 =?utf-8?B?Z3Y5MzVYSlptNEo4SWsrOENqMzBwdkVJVHRtUXc1THNSejRGU0tTbXNlcmo2?=
 =?utf-8?B?dUJwZjNLVlM2cFc0RlhCaXE4VjUvVVJOU1VZbEN1U1lzb0k0Q0lPRFh6L1VF?=
 =?utf-8?B?blZFRUxkMUZTUi9MaUluZVNJOTFXRGUyZ05VeEJYRjdqUjFxNGROaEd5dGVN?=
 =?utf-8?B?U3BWTDVQRGptdTlIcDhDOWtDbzBiQWVJME00M1J3aFZ2MUJZaU45aldEWUF5?=
 =?utf-8?B?RldEY1FzMzJpdE9Udm5VYmhqMWs1TnBrNE9BRFdtQzNQaDFLMXZ6dFQ3QUdZ?=
 =?utf-8?B?NXdaR0J1d1haK3Q3SmE0eStqWjQzR0RxbERaRkpJVFZ4dkJrNWo0T01jZnpC?=
 =?utf-8?B?ODlqei9QY3JCVy9Lc2RNcmg1dXZqeis5U2c0QmhONHUxOWNwKzRZaU5WYTBn?=
 =?utf-8?B?WEY4QjZkQ1hidmczbUsxb2dydXVuTTR4TXVxbUt3amZMNHB6U0hjYkdzZkFF?=
 =?utf-8?B?UFRVcHBwQXNYVlg4UndaY3kxc1RpendnZzRZWUVGTUM0YWNtQ2hHWGg0eGFt?=
 =?utf-8?B?U3RqSEdXUkp5N1hSd1FpSEJjSmhKdEQ3YmpGTkdCVEdFcVJpZzhnbXlPSkZu?=
 =?utf-8?B?dFNkVTF0L0xmem9rWHpRQi9XdXVhRGw5cU91SU5RSi95OVd0V1ZnMmlGYnUz?=
 =?utf-8?B?NXNvYjBrZ0ZmbWhYVlFKSy9oeThHWVNFeTJvekJTSmFselJ1QWdqblJYWHdq?=
 =?utf-8?B?c0dmOG9BODdUVDZtclIzZmxvSFhhWjR2aktaSUNBOHRqM0hPTTBiVjRycyto?=
 =?utf-8?B?SmdSL3dSSy9oYTh6RUZBNVBVNmUwRldLbldLZXRSL1RKaDZONGI4ekdFVHc3?=
 =?utf-8?B?d3RHaDdiOCtnU1Z2Y3J6NVJMRnZWOXRKTEhCMHFFeEJHTGEvL2d4bm9aMFE3?=
 =?utf-8?B?Q1NXR2pvVWMrTzRjTkRLVUJnYitWNDNXMHlUb3JtUDQyUmMyZ0hnbm56c2lL?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZXR3MDZDTS9YdlA5bDl6MFFjTXlhMVl5WnNxZVhCYWpRSGNKVkFXUkF0RlVz?=
 =?utf-8?B?ejc4MGtKMmg2Z1NoeVg1MzFUdTdGQmZGb09LOXJRajVHV1lhMFVUREpxbzJ5?=
 =?utf-8?B?dUdnc01ERHAvLzRGWnd2dGpVRGJmNGZEQUxYQllvaGdSbDVnck5ZQ0JHc3VJ?=
 =?utf-8?B?Z0k3NUYxYTVDWVNzd1ZFRjlNYmJFUmEwRWlYaGZVZnlMcVNVQjhnY2U5V2Jr?=
 =?utf-8?B?alB3WVdWV3BPOHltc3djbWsyTGd2ciszemE5aHo4cmdJNFo5dHFES1hIa244?=
 =?utf-8?B?R3Vsek40NEFISHArUmRBaDFVNSsyNUszV3BuSngrM2FjdGpYZmZLaXJ0cVVy?=
 =?utf-8?B?UHlJSFFLc0xwbDFnUFFFdEVWL3kvSW9QbUFWdUhKTzBOUUJqZ0FJYkt3RUVz?=
 =?utf-8?B?TUtNdlNmd0FKVFVrS2JJcWtkRkpTdFg1SGdYQXQxblhKcUlqeVNSS3ByM0tV?=
 =?utf-8?B?Sk93N3pxb3VKU3VNL1N2U05Fb3pkQWc2NHNKN051WU1wNzI5d3k3OEEzVG1K?=
 =?utf-8?B?VHB1NGhScDhpVUNzejRJeEh4QnNEMzNEMk1zeWpXMVRTYVhYdDNjU3NiN1JY?=
 =?utf-8?B?QjJ2bHFHbzhSRHFKaE9FK2h1cnhaWGNXdWFkLzE0UUo3Qk5jdVRuTDVTdFhF?=
 =?utf-8?B?dW9UakNrKzBDUk9wYzhTMVJhNVh0S3M0eUM1U1o1YWcwM05EVm1RN0pLYi95?=
 =?utf-8?B?OXZlYmZ3NytaTjZxUjFQd21zVzc3a0hLY0krbXFyK3liMG5WWVNJaytNaXhO?=
 =?utf-8?B?NHQvVDhIRDY0emQvRnZkVSsxMWJvSDYxclR1OW4raDByb3Z0TVM3MEJKOGwz?=
 =?utf-8?B?VUZnQzhYMnFHNXNMN2dTc3Z0NFZVSFBiT2JtZEpMWUJyRHVYOGJTNHdCN3ds?=
 =?utf-8?B?R052dWhUSzBQc2hxQWlDRFk2QVNPZHc5ZGF2S3p2SG5kR3dBeFVoWENpaHQy?=
 =?utf-8?B?L0NkcmdYSFlodDROR1U2Y2pkYzYyd1RYenVjS1pSeG16Nkd3WXpTTzNqS011?=
 =?utf-8?B?QkR1RDMwUk45REtpTTg4YktYMnh6MGg2UjhYOUllZ3VXbEg5WlhaWmV2NS8r?=
 =?utf-8?B?aldidmpWb2JiM3pSUCtVTSszdEorRTdMTmZyZG9NNThSK2dxM3RERXZiYzFJ?=
 =?utf-8?B?SWxSOTNKSnRDdmpLR3h6aDlON2IxUDZ0ZE9vZEVocGZyczZQem4rWXp2Q1Iy?=
 =?utf-8?B?eGY0eWxQVVJxQWpUTktjcEk5N2ZlZDZ4b1JLVUE5aTNGMWFFQ3hVUXV5UWRS?=
 =?utf-8?B?cDVqOTJpb2dRSDUwTFh6d08wY2tmOGxpTnd2eWRoZ204NElnOWtjaXNiTk9P?=
 =?utf-8?Q?1uS2xfBkPxRE0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff5c86e-9fa6-4cf0-0521-08daf57922a6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:16:25.8592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRHi5NUHvCYuLVEsIypR4S3ibMosEmMp5HTwml2SUPoYwPPL14LC4SSUoprCd5KQPo3yEa9iSuoMZEfqLjwqm0hm1JMuznaZc4m41+dpI7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_07,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130100
X-Proofpoint-GUID: iiUrNoJ3UqeRvWhNyjR5XFvQCD9tl3bE
X-Proofpoint-ORIG-GUID: iiUrNoJ3UqeRvWhNyjR5XFvQCD9tl3bE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 6:00 PM, Mike Kravetz wrote:
> On 01/10/23 21:40, Matthew Wilcox wrote:
>> On Tue, Jan 10, 2023 at 03:28:21PM -0600, Sidhartha Kumar wrote:
>>> @@ -3505,6 +3505,7 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
>>>   {
>>>   	int nr_nodes, node;
>>>   	struct page *page;
>>> +	struct folio *folio;
>>>   
>>>   	lockdep_assert_held(&hugetlb_lock);
>>>   
>>> @@ -3518,8 +3519,8 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
>>>   		list_for_each_entry(page, &h->hugepage_freelists[node], lru) {
>>>   			if (PageHWPoison(page))
>>>   				continue;
>>> -
>>> -			return demote_free_huge_page(h, page);
>>> +			folio = page_folio(page);
>>> +			return demote_free_hugetlb_folio(h, folio);
>>>   		}
>>>   	}
>>
>> Can't this be
>> 		list_for_each_entry(folio, &h->hugepage_freelists[node], lru)
>>
>> which avoids the call to page_folio() here.
>>
>> I think the call to PageHWPoison is actually wrong here.  That would
>> only check the hwpoison bit on the first page, whereas we want to know
>> about the hwpoison bit on any page (don't we?)  So this should be
>> folio_test_has_hwpoisoned()?
>>
>> Or is that a THP-thing that is different for hugetlb pages?
> 
> I believe it is different for hugetlb pages.  See hugetlb_set_page_hwpoison()
> where it sets PageHWPoison on head page as well as allocating a raw_hwp_page

I agree, this line in hugetlb_set_page_hwpoison (which is now 
folio_set_hugetlb_hwpoison) sets the HWPoison flag on the head page

int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;

so the correct code in demote_pool_huge_page() would be:

	list_for_each_entry(folio, &h->hugepage_freelists[node], lru) {
			if (folio_test_hwpoison(folio))
				continue;
			return demote_free_hugetlb_folio(h, folio);
		}


> to track the actual page with poison.  Note that we can not directly flag
> hugetlb 'subpages' because we may not have the struct pages due to vmemmap
> optimization.  Adding Naoya just to be sure.
> 
> Do agree that this could be list_for_each_entry(folio ...

Will make this change in v3.

Thanks,
Sidhartha Kumar
