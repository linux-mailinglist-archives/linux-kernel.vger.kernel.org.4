Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6628700BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbjELPci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbjELPcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:32:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2F0DD85
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:32:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF484P017749;
        Fri, 12 May 2023 15:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=J8Wfp4UvJBEeVjihmAlwMLuQF3ftZ+nqaV4YhWv7bH8=;
 b=Y+GbUbww5s2ngf7UxxYGImhzsmTi26ady+GUrP8/Sj3uzfZKlDE26FDEeJ2IU9+dZ/qv
 nuK1ScRw0vjR/3DNg0dW387juTFMdZ7lJvDqg/2XoAYps3bnvJZIGYDIU2ra8IjasaNL
 e/u0QFzGZEKp6yOJIDL8+43IjZzhetS0B7vBz/ynEMD2YUzGVUdRFNjGyzNLJjm2SLdB
 FrQJOzAipCkhX4rcZoC2gR4pDJCVMNKr2r0O8PMj2q6vgroiY/YO3nOfaWzyjuznpa17
 ex+ZEGjFBIf08Hhi9mlx+vZ3qPBYYy8n43Cf50rOVJF002Ic5/GQntG/4MsuUAGifB60 fg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qhje7hc64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:31:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CFE01d024200;
        Fri, 12 May 2023 15:31:04 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7y8a0j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:31:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jguOFbvw81nBkxLfvCouYJKc672TKgPtaJ6KQEqm/fMBtoIOlSeQcgqyPBJhuNCYB7mXzNuKGobXtCHRy6DkWJI9g6Y4aw+eVdsP6jb7GyuVvhY0DN8rEbuxqn/570YReXSsi4kDSZeh+5ydvwA2zAKwxuFk2EHB07VKcY9RCMmlWVQ49zbB7SVdWHPIp7Jy+TWC6pUG3+qEIsAGCSydyS2oSujPyTnwbdKo8BRsHaCgweVbIdCrAqE3YWBmZ/SOSMjccfWJmukkcUajJCClYXCcJNQvw+ADT51QHa2Nn4ahPUAOQl6+DhpQ52XPuxUsIbCSFICZ6IILljbFMvRMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8Wfp4UvJBEeVjihmAlwMLuQF3ftZ+nqaV4YhWv7bH8=;
 b=na8pJ8sCQL/RixjT8ROPK7YAhlpzDwEbScTH6AdUA5LjW4G+BSzV1b20RYeto/lj7W45ME3T5D/FRQxW6aqxiozG5FmSiGF0QROxOQc7NGNHBMTQH2PzC0BJth4zv8p0T9WOZB/tOEfBOqaw3N841fBGXGH+3fhLYZHE6zzmizSiZsh+D1//dNNurJuWPnz5h6X7kFT93eQSr7HhPC99Gg1+EYIS3VIYix4gtlyPVVDppptjHXqph078kJgrPG8mAD+2qM3cplaZYV+i6OozLYIm7l4EOWNvkj/086J8sWFkganSd+kTit8lYb4777/xroVSW/y/vHHdIi1R96YbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8Wfp4UvJBEeVjihmAlwMLuQF3ftZ+nqaV4YhWv7bH8=;
 b=HH7HHGUsxhMt0rUTA+yNAE7iIAfEPM6mzWNYkPFTDZA/U+L5HVyUvfkMJmYYEIq3sAordhVBWWuE+OtNnpziIHDRkt5BkuN1pzS/bX23ToOv7HQdbbnjcvz9DMm9qoOEzwMIARYhaIzpEo56Ad/6CPphNDSzALO3dc26Qj8FtW4=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by SA1PR10MB7756.namprd10.prod.outlook.com (2603:10b6:806:3a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 15:31:01 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%6]) with mapi id 15.20.6387.018; Fri, 12 May 2023
 15:31:01 +0000
Message-ID: <47dca08e-a100-1099-27a9-7c1d92ffa51d@oracle.com>
Date:   Fri, 12 May 2023 09:30:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm, compaction: Skip all pinned pages during scan
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Steve Sistare <steven.sistare@oracle.com>
References: <20230511165516.77957-1-khalid.aziz@oracle.com>
 <20230511204532.ceaf7adba0bc95d65372af07@linux-foundation.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <20230511204532.ceaf7adba0bc95d65372af07@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:a03:80::49) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|SA1PR10MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: b8011af4-d2cc-495b-cafd-08db52fde43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5HKM2R1AvTCf3gmNb+Dzm/hKpgFuh/CErJW3bMXu4Qekz2aoGmsosIwwz/RrsGJ3tg/YFBwvBSjxz5P9tZWWUTXoTxCr28ag8cVEVGIz622sa9QRe2GfoUVZ0cutkGfYJUdpr6nCN3AOwRLWwQXgpzsbRODpGcad1JBu5atTmV6o2HpgQ5dc+/HpSdV2oz5yLthRhRTV4jZpeBdYMbm0mQnfHsg4ax9OQLGmihg2vezUlPmp/FVv8qHktF7TuFO3UdLe1+on07uK2CnAl5rmSlqMNRjdwj7L2N6W5f+PtUjUPLdHpjmBrcPN/UYnvP2/86OUTllKGRmM183EmL9Hy1s/HCG4pXwmWuV1JH6ASH0kOjgCpmWDFD3QLmEL9vTXtL6MvAhmkUNeEk167aTPgVpld1oNTefJr2bzoMeyk22z+YgGOYUUPx4gu5HIWKHqZWXSVriDKRQrwwWHwtRaoZGMAqAGCLEGFwH1nQb1zh9TIbAl5Mo9FdM7kOWQtuDxAmvdz9rMH48u/61UA5DbW5oF0Zu2YBMchQCTif5liCJb7Qd3lFhFBp8/8M5Ls8Xr6OBSuBsK9pSY7bMeilYIHKdly5+t/na7IjgL5QRGkGxb7hD+WcqMZMIfJ5k8NdroXDVkAQZnUyQSFkRp+tzhTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199021)(41300700001)(8936002)(66476007)(316002)(66556008)(66946007)(4326008)(478600001)(8676002)(31686004)(6486002)(6916009)(44832011)(5660300002)(86362001)(6512007)(31696002)(107886003)(186003)(2906002)(53546011)(26005)(6506007)(38100700002)(36756003)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0I2UEZobXEycDg2bDhCQk9VUUE0TjhOR1Vab1hTSGthWmVYdTRTVWcyT0Uv?=
 =?utf-8?B?Wm9xb1ByZWt5WHhYa2VucDBROVk2cHk4TFZoaHdOd0Y2eUNXTWI5N2U3OXQw?=
 =?utf-8?B?ZFJHNWxISVUvUzlUaUxvSmFuTFZXbklTbHRsVFlObGxCd1pRZHBWTnhpREc0?=
 =?utf-8?B?a1RNMmZMaXZER0svN0laUkp6YmlqendLV3c1NUp3eEpDOEZ1UFdCSTRIa0RH?=
 =?utf-8?B?cnMvblU4Q0RDQnIxMkJBWHRMbTZ6SmpUNnQyQXcrSnBxQWw3ak5qaW5PeVpO?=
 =?utf-8?B?VU5KVGs0akRXN08reXpyc2JIRXQ5YllRTUpTaXFqS01zdldrc0JUOS9BWG0v?=
 =?utf-8?B?UTlNT0ptbmZrMHlwU0xRU2FwV0kxUnJRWWxpYVFONjZSREsrdlN1V2N1cXBi?=
 =?utf-8?B?RlpKT3F0ZnFhWHdCTmh0dzhjUCt6WXVBdTF2L0Q2d1FNeGdZN3JaVHZybjRS?=
 =?utf-8?B?R3hRd0tQekdrZDdnNE04Z3hJRm1TdW1BcDk4bXEyc0x5YW1HNTVBaCtRQUxr?=
 =?utf-8?B?ZFVLMXlaNHRLTWJYM0RwZ2txT0pvVUxQZmI1bW02WUV5VmF4N29sZXJ2ejZ3?=
 =?utf-8?B?THZnSGZsUnNDbERkV3VPa2xYSEN3TkdseUZhVTV0MEZsZVgyeGN4dGZQZ2tw?=
 =?utf-8?B?UzFreU5iRW9pUUNaVDd4ZUU3N2REd1ZRRlNXY0djSUV0VW1LdjRhZW9QT3Jq?=
 =?utf-8?B?QTIxcExJSjkrUlhPSHpGUGNtTGs3bk14NE1MZkdWOXRqRmJtSm5pUXUybWE4?=
 =?utf-8?B?SjhmdjFyNVA4Y3pqcnJXVHdoZGIzYWxJOXhOby9FRGoyTWpUTW9tL2l0bTUv?=
 =?utf-8?B?RVJnL3FWRnRWdXRNTWdsZEIrQmk5U2VBUE8ybVcwYXdaem96dVBiQ3V0WGM0?=
 =?utf-8?B?aWJ3czdoQ3FmTkE5am5XOTl5OTBrMnh0bFJXcFhpM0hrOS9tenMwcHl6SWFS?=
 =?utf-8?B?UW13Q2hTeUJLdENSWHBRWktzOGllVFl2czRBWnlKSUlscW9VOGxKSEw0S0R4?=
 =?utf-8?B?aHdWUEZNak43TEtacy9oaWhZem84dTVWMVFTdUFxM3E4LzBZQ1l0a1QrZ3Vv?=
 =?utf-8?B?d2k3RGVFQ3V3bEpkL25lUnpaUUN1S0lyOFc0L3RiODJyQ3N3TGlNSXJlTEVK?=
 =?utf-8?B?YlVoTDBNbWdJRmlxRU1ob0F3R1d0UHVxRlE4MWlEOHRBZGREbnp2MEJCbk8r?=
 =?utf-8?B?bjJQNFNDWUYyZzduMnhMZlZuenJZTWdhTXN0MjlJUGxuaXZhbStMMUV5YTZD?=
 =?utf-8?B?M25jYVlhNURoR0xTTzVENzVHbDVhaDFReEhXVDhQMEZPS0p1SVYxSE1La2tv?=
 =?utf-8?B?Z3NMR1ArWHdtR1NFSnRDYjErMmVWeDFNczZPdG1CcExyVUtscXJqOEdtVWVT?=
 =?utf-8?B?NmxOcHhvV0ozY01oY0ZONTAzMzM4TS8xUzlydmZtRXA4K0szbTRXRFN6S1Ja?=
 =?utf-8?B?QldYcUdLZmVINHZuVkdnanVzS3FjeXUzeTBmQzJLY1BaZFlHbnVWQllNMUx1?=
 =?utf-8?B?bU8yQmZyWFVGeFlVQzB3cVViTTNxbjF1SXdWcE1VZ3lLZllPdXR2UEpvajJm?=
 =?utf-8?B?RE01MzJZK2JBeU51eTZJMGFGRDZZbmJiOG1ZSXl6Mkh6K3gvL1JHWUx6TnNw?=
 =?utf-8?B?S0VzOWFocjNPa3hNb3FtNkJKWmNPbHZiWlRlMURYWVBVK2NtalB0eDJHZjhD?=
 =?utf-8?B?QzIrNE1EclNwUDRPUjNQeDBvQ2sxcURhWGpOSEFBcXdzeGVVLzRKdnBXaDB4?=
 =?utf-8?B?QTBWd2U5OFMxQnJEckN0ZzJrSy93NlRGSWlndzgveGxRMDFIdVIzaHdSaGNn?=
 =?utf-8?B?TWFDUTQrVGtreGMrWnFYaHlaWk5BMmF6K0lUK0JVQTd3NlFHQ0FydFlQaFpa?=
 =?utf-8?B?YmFFeko0cUJ1YWJFbkw3QVdwUTFZRVg4RjhkdjBuZ3dLT2NkeFZvT240MGE5?=
 =?utf-8?B?OGsrbFY3Y2V0a3o3dVhRWXRNNG9wQjRQdngxWGJ5MmtqN2NxcEZxU25ReHQ5?=
 =?utf-8?B?OFp3eHZDV2VFcGdHMGdMY2daSzdtRDV6MndUM3FLWlJDRjZycUlxNkFnNHBX?=
 =?utf-8?B?bU1hZDRENm5ZM2M5cDdiMzIwUGc4ZU5HMUhHSS8raVFweno4U0hMQjRJZ2FG?=
 =?utf-8?Q?73CTKaybj8VVF1Oz9hkSh9Mxv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SkuzWJFwRoWLwl41x4wDloaeRZasCcaZ03iYyy/kF+g8sDOEEqwm2EbLgAia/JQOlaKQNZTJYAz9DaTe29YY9I3H1NY1d7BcQIahuz/hgqW1mKmtddgdCmO9jUYxi78QND5QrZHoljhOpZ54pSdr7wDQ3yiuooX4B2oovBJyFD7YAdujkfLAHJ5maXnvU4zRol4aYrY8IDsHHT8bNtebIyborDSWKaKRiS6C3n5VLArTdLH8OYhCp2pMIBukPjPBpOdSlC941mQEB0k1r2+urJQ7Ejgba/WYhnJKn2pCHfq2YY5bc1YdIHATJgiladX9aG8ANc6pIyDkXRHAVSEa4l0VbV3adgb0uYNV0PCADHbZJGKVLunI0OybjQ4+/gisUjlKdOeVmpzPDQEFTiDN0AdQ1xHI/HHHmvfPtVnQcy4l2xDdiUlM38hhKv5pdlHObpSUhtQ3ontPa8zkbmMw8HZNt7MjdE3XkLQzWtFNyCPH2Y2W9f//1iHptaPNI2v3r0Rnao+chf1e+OJ/RdJjvvsS8KNW4Q0CogiqZPS4r/FZNwytAycRgdvXY91r5jvGJ7Rb+3RRNHbO2cWVGTfjFZu4UhYN+7+mjDOunZBUwyA6p8VNxg4Wa0PLK5BrdH9n3Y09nTJzxkpb0YbS58b90RhgNz6T+148LxgK8yXpKSqC71zoaipnTb3zEBD0fjvjoSpDNr9dlk9+FKQKh6VY4j0LDG9WIuNVTAEU8gjtft9j6YlU31yIrbXoBnnRJTrJQEnvczOs5wwNCxNJOaoTR1ScKw3Iu+8syqIpxxhqJTFJyaSTyC1XJyyJOHuHmxmLaCvbfA805AwP2EXyrX4N3g3Va1c1oaOUlx5yF1Sh3hdDv5wHaaMu3HYmirkhB9bF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8011af4-d2cc-495b-cafd-08db52fde43e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 15:31:01.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbXkuACexhEMGfz2AbeuTKSGKsf0tYo5tCu0e0NCKIcPsEjsjV2Nwm7MIZMilTs8eakgx94O4H+h5nrr6Em0Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120128
X-Proofpoint-ORIG-GUID: PeqdzYzqgK_Tn7yc2Z_MSi9cDu1tuHc3
X-Proofpoint-GUID: PeqdzYzqgK_Tn7yc2Z_MSi9cDu1tuHc3
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 21:45, Andrew Morton wrote:
> On Thu, 11 May 2023 10:55:16 -0600 Khalid Aziz <khalid.aziz@oracle.com> wrote:
> 
>> Pinned pages can not be migrated. Currently as
>> isolate_migratepages_block() scans pages for compaction, it skips
>> any pinned anonymous pages. All pinned pages should be skipped and
>> not just the anonymous pinned pages. This patch adds a check for
>> pinned page by comparing its refcount with mapcount and accounts for
>> possible extra refcounts. This was seen as a real issue on a
>> customer workload where a large number of pages were pinned by vfio
>> on the host and any attempts to allocate hugepages resulted in
>> significant amount of cpu time spent in either direct compaction or
>> in kcompatd scanning vfio pinned pages over and over again that can
>> not be migrated.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> Suggested-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   mm/compaction.c | 33 +++++++++++++++++++++++++++++----
>>   1 file changed, 29 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 5a9501e0ae01..d1371fd75391 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -764,6 +764,32 @@ static bool too_many_isolated(pg_data_t *pgdat)
>>   	return too_many;
>>   }
>>   
>> +/*
>> + * Check if this base page should be skipped from isolation because
>> + * it is pinned. This function is called for regular pages only, and not
>> + * for THP or hugetlbfs pages. This code is inspired by similar code
>> + * in migrate_vma_check_page(), can_split_folio() and
>> + * folio_migrate_mapping()
>> + */
>> +static inline bool is_pinned_page(struct page *page)
>> +{
>> +	unsigned long extra_refs;
>> +
>> +	/* anonymous page can have extra ref from page cache */
> 
> "from swapcache"?
> 
>> +	if (page_mapping(page))
>> +		extra_refs = 1 + page_has_private(page);
>> +	else
>> +		extra_refs = PageSwapCache(page) ? 1 : 0;
>> +
>> +	/*
>> +	 * This is an admittedly racy check but good enough to determine
>> +	 * if a page should be isolated
> 
> "cannot be migrated"?
> 

Thanks, Andrew! I will fix these and send out v2 patch.

--
Khalid

