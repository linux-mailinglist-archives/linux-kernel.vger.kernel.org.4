Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5407170AA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjE3WZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjE3WZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:25:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8B210A
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:25:04 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UKO8dS029875;
        Tue, 30 May 2023 22:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YtezkA9bPrAEBQ0CJ/CkSwHOeIyGbWuB+1RlyYW+uIQ=;
 b=wW2bA97jBDMY/P1O0/b7Id5Uh6p5biI2cGIDUWu09KR0PkVYAlGqsgzYzThaR6dXd5eD
 PNIY6Jab14rOA31ZPNAp35gU3idcrgj+BVCBeSjFml1jDw7PgYe7w75+JBB7vfOp/Ugj
 8jNM3vWVxyx/uyZC6oIECYhX7PSZhBb8ja3lA2yQgvpn6G0OUEbY+APISMGSXdJS1dcJ
 KNpxlu+COZZZ2j/DxoRSlouhd64UwjPEAuw+1HEiIIFHfxIi5gxdLQF9qhkJ4en3so5E
 2LQycdfdxQ4fXs9gZE2JZh7EkjJI2y6geygVDGN07hD9pcRU63RMlXyu1WpEunTLmIeV cA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9v6h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 22:24:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34ULO2Dc000353;
        Tue, 30 May 2023 22:24:55 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8q92dd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 22:24:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k68MgaD1TwEDV5Fjgh+fifUqOSyM8dSED8wZ4WDBFIvRjf1lnQ1x4tQOuVjqpAZE3wofk+Fa8Yiw4ScL8PmhY0X9TNqrOg5W+b0u/M9YZiGoulnb8pu8tTMCS3A9ozoozuoJRQa7demjpzs8ptfm2bqfiNi7WR3e60CQGnzulo5AzvUzZyx2yCZVp7Lo/KDjypkWXHFEafBDc7oMi6aN+x0mIRnA6OgcqiMkacU4EaMfYYHAPS81P7H51hnalcLDsTTXgIQgojRj9C9WnMaraWhgk3tRSkLZ4qCTmXpe9g5MhwEVE/ai9XwwBmUgmFHJJST+N4QQCpwWBHeaxCZUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtezkA9bPrAEBQ0CJ/CkSwHOeIyGbWuB+1RlyYW+uIQ=;
 b=MGnAjczfHW0wd1RZkShsWc0HcUF2AEIJSRQimGyISdUCQKpKaNFC32EQHT2L8+s9higEr97A4u64ACAWELf1uosW0LPcePz4Jhamhb2TlUidjXDL3oFvWR7RbIQX/nvzE1CchgDDXoCMWIP0diRI7ip40XrfhazPSUKrs663D75GcAZog1N9xJsUMPQWEL36HlWPi4KzbWURH+0Htu/DQSPBP4Nkck5mdkuhzNSLmUhHQaNweeRImn2yiLCPlGMp+kBXoniVPLQM1X69q40eADBybmKWhziJdxFVvEUICkAmfYrtQ3/XWYCcYswI4xoPmbeRdkTzwD3mNpb0sXHGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtezkA9bPrAEBQ0CJ/CkSwHOeIyGbWuB+1RlyYW+uIQ=;
 b=oruZLuklG7u8WuVNrdj14z8JfqNICvs19MEfqZBSvl3mr8AOXiE+pAM+94wApraP1NAQscOWQcjhEwXfa72s8jSnmCsMnurOXF305Cz1saV7OeoORo8YSNz9JZI52gJnH2BPKSMTzDmXs8EjuQGT5SRXHCSJSS2NGPdrB2eAcxk=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SJ0PR10MB5836.namprd10.prod.outlook.com (2603:10b6:a03:3ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 22:24:53 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3%2]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 22:24:53 +0000
Message-ID: <5d6db8fc-13ad-6cc4-16a5-65fc6cc2ff8f@oracle.com>
Date:   Tue, 30 May 2023 18:24:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/4] debugfs: Add simple min/max "files" to debugfs to
 fix sched debug code.
Content-Language: en-US
From:   chris hyser <chris.hyser@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230530194012.44411-1-chris.hyser@oracle.com>
 <2023053025-blinks-vexingly-60d3@gregkh>
 <77ad1a2d-fead-359f-d63e-295ec5791bdd@oracle.com>
In-Reply-To: <77ad1a2d-fead-359f-d63e-295ec5791bdd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0028.prod.exchangelabs.com
 (2603:10b6:207:18::41) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|SJ0PR10MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: e17ef57f-cf3d-4b11-cd3f-08db615cb0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4pUcFYFTIR2R7XRKJW3iBujooAKJ7zrUra5CZwRqV31EyJw4nMwNge3VoV/orqFrbMdlVq3Bt4aV6yUVvevwrJW5RnwJDjpD0b7Grawy1MrKM2qqfhIEygAd6zj6FOkzgXmGWkuhBOBfR7SmDm3qkFd10hn7w5yXJ7jtOh6a8C8+5T0SFeqmREqkfseDku0HTAtIMQ5LUrZI8z52bvdkoXR07Mo+VkCaJc8QbIKHR+kgLj4P9AQxJrHuZMRvdE6GgoDdiWlzFkG3wco2Fw4K45sXv3ANPhuLU2myrKNSONhQOYyftO8GTvK5zBm2ax/N87VOLiuq8hJvSz8Y3glE4/+Jf1zz90GtXApE2b4VB7Cl1sdJPHvdK37dax18la2fiqNgR8PlXfB6kTRA4C1dELQg/XidZGUWX+GHvFLEXg5SmQytuS66sSVHiWpuoGnSTYDDDLe4Tn1J3joR1ftGX81FOtnbz/2m5KAJ3zGe4xdR/nOX053BYpk8hYE24dfUKpRoh6AVDrhXz9RdSKyF2qUSmwgCKRmud2sGhyQ8ecP1pTb28KgwDUo86DpifZ4BUTl7NQ7n37+wperYbgIOM6iFBM380J+/+ANPMZ7EJcjfE3VOzmCWxDexjcSr7zDgMRwWLjvZKI37lfNviJstg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199021)(31686004)(83380400001)(2616005)(6512007)(6506007)(53546011)(26005)(186003)(5660300002)(8936002)(38100700002)(8676002)(2906002)(478600001)(41300700001)(86362001)(6486002)(31696002)(6666004)(316002)(66946007)(66556008)(36756003)(66476007)(6916009)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXVGYVY4SDRKZFROSWxRMVV0cU1EckdvNTdVazNpSER2VFhYVHhnU0d5eHFy?=
 =?utf-8?B?dkVCZHczVi9XUE9DeDkzTkVoelBtRjEyaVdEUFkzWGFtNTlJTk9lb0crakJN?=
 =?utf-8?B?dnhZejUvVmN4YTFCVWJNUHZqWDJ5YnRXRTZicDdySEJFSmlMcjZiZ2gvcHFK?=
 =?utf-8?B?WmFFcXp0bDRDd29WZjByNVU5MzNXY3ZXR3RpWm8wdkRUNElsSHhjNUJRWVRv?=
 =?utf-8?B?MWtVWnovaTlLS0haRXVXOXJFQUNZUkdKU3A1akZHVEhLM1U1aW5TWkxNSTUx?=
 =?utf-8?B?MkdjS0l3ZEV6ZFMzdVV3RlZNOGozT0c0dXZqQlVhZ0F0eDdxZXBLYjFaT2F5?=
 =?utf-8?B?RHJmZER2ZnhDWGdveUxQNWhDUzA1MVJhaXdtbnQ3VWI3NTVLUzl6Z05pMkNx?=
 =?utf-8?B?em54ZFBFYnd5bGRVbi9BeThHdExJNFJxZ3pFVHhZRUMvZlhGcW9EeVgxN0Vk?=
 =?utf-8?B?eGliZkFkR1NUWnFQNTljT1NxVnZaN0RIS1k1dnE5bHB6SEZDUXB6WkYxWWdv?=
 =?utf-8?B?ekVrRXMzUHVvV0ZmZWNIdmdvK1pVeEtxYVY5WmtzTSswYUY0aVlUTDNkSFd2?=
 =?utf-8?B?SEx3aU9Xa2VqYnN0cnR2ZHdDR2J2S2hJQzZEV2RqNUQvQWJwMjJMRVpYdnhh?=
 =?utf-8?B?a2Qwd2NuQXFSekNkSkZoK3FKWnFaazNrNnRrY2YwSnNWR0pPcE5BWStoWTBT?=
 =?utf-8?B?QlRzYkphM2JVaEhud01PLzRZRHR5UmdmM251T2ZJWXFoWUdXK0ZlTHJmbjUr?=
 =?utf-8?B?aWQ4SnMwQlc4c1R6Y1FXU29SOVErRy9vWmkzNE1Pai9uZkpTVXp3NWc4Y3Vz?=
 =?utf-8?B?S0J5MldQYTNXSXZVQTh3Z1QxeWwwcllDTWtFdUMzbi9wODBGNjJOeXpXbGti?=
 =?utf-8?B?aktuQTF0Z2ZUaVQ2QzNja1hnT2I0YXVTanNwMnh5NEVWazI3WHRkdllTaWtH?=
 =?utf-8?B?N1BZR2hNU3lENmlncUc2bGNpYmROaVQ1UTBvYlVkSnJIM3FrdTM0TWd5OStk?=
 =?utf-8?B?OTdseENDR3E4VjEweDdwWWdheitVSUFyY1ZiK3QrSjBVNTZKQTdpck5SM0Y3?=
 =?utf-8?B?VlRLM0wwUUxud1k5Qy85U0VlU3MvaTFrOUw2NjVBZFg2LzdYVVQyaHhSRHBo?=
 =?utf-8?B?eG5PSUJEYmtWdlVrNXBiMWUzRHpLSHlVajdsRjhRa2x1MURteGc0RVhJTFRT?=
 =?utf-8?B?MG94NWpvZDc0eFhLeE1laXJjeWdCYk9JeFVvaGk2cjM2d2Qva1JnUEZySlFQ?=
 =?utf-8?B?djlNR2NsOTlmTkNhMXNKcUNHQStxQld5THk3M0Q0bW5kczh5M3hIb3phdXFR?=
 =?utf-8?B?dHN4bmpUVGQ0SHhJWUxRTXN4N3FsbHBIZFJjY3ovQy9vVlExZnFRRkxTT1F4?=
 =?utf-8?B?SE5TNFVoMVB2QnlZc3FYbmpyakhrSjcwaVpBRXpzOStkM1hhTGFaMDVnWHJM?=
 =?utf-8?B?L0FkVzFRYXhEMGRvNmVGb0dmYzF0UThxaDNHTGVPLzVUQmx1MWl3RzRDYXpF?=
 =?utf-8?B?L2lwdmpDTlI3MUNFTCtpQzBvRWZYajRMV3NwZ1Z5YUh2WTZ1TEFobEp6RjhT?=
 =?utf-8?B?SVZBY2pld0x1VlV3K2xzeUE5eFQrdlZkY1FZQ1QyVm5UcTFUcSs0R214TTlX?=
 =?utf-8?B?NUUvMXROQXZKSkIrWFFqMXhJZnVWbFBkUWR1eUNadExuV0plQlNTcmNaeGQ4?=
 =?utf-8?B?MnltQ0xzNG1LY1VlTUNHNU5FbWpEK0oxRGNpcVpuZDhMUnBkeEJwOXVVamVt?=
 =?utf-8?B?aTV6YlIxdTIvZHYzLzZ5bDRVQUdybmU3QUxjanFLWmFURVk1NUo3Z0I4dGFC?=
 =?utf-8?B?S25STXNJK1JNdW95WXZsdnJscEx6R2xRcE8rVlZjc2l3Tyt6RHNOM2ZjRTU1?=
 =?utf-8?B?L29YSjFBRVBRcTBHRHRTQ1BWbzZVS0s4RkhCVzFtOXhZTW9YSlNVeEh6K01r?=
 =?utf-8?B?UzAzU1c5Q3lDMFY2RVRWQUFIWHJLSW1tcjdGSVphY0RKLzNZWURhbjVZeG4w?=
 =?utf-8?B?QXZDVHNpQXBja2VKOHdZZFRmVUJjVGY5eWZacC9HM0FiZkxvNXBZZkEvUUVG?=
 =?utf-8?B?ZWJjbHFsdGsxRUxMMjBVWDA1Nks0USszenZtZzg0UjNnUVptS1QwWEVsSHZj?=
 =?utf-8?B?c05aTW5iaDJoNjRlWWVqYVZSMVFJWnU3Y1NCV2lBVDRQcWd3dXRCWERLV1g3?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s10qcAQiic6oxksHEjJad/oATJGAHB5+gp7H55Z08+I+Kkzq8trZQdRKa8h8KHhZWfyIUXvqIvceocRQGXsOIRZrYemhN4sca2ttV+0NBfEX8jJS5jWifK3E17PvIwqs3Zbs1vw3h+q9YznmXj9cylw+M8Uy2gI9JVmIVEHX332BgnmPg54jY+EUl1xEbPGT9uPIPP8JRdT/+t2CFXJRNnHuD5GpBo/Zzc4F+N1xWx6coHtJyqCVLR+xkogzkvQwz4ZKz7n7rLfTXa2IgBNE5m6UShlyjn+TltYlVBfJDxDDqOVo5pp9cYU3xMU4p/B0rZvN7RPGALx+Lanwawn3E5/fyDo8fcHZ+pNt5D80CKVOIRpxgygOWlgqdM85Blqh8VqA3stX/NjFgXBE6uYGq2mgCEL5xtv4/JIU6BVEzuibwvzfHSnngl/Z5UGnIagCrHdipOO0RGWsiVKiF75RraMszJS+JThYaYfXA1o0+RY1aRJriH+eamhiEz4Qex8hrF/SGXMCFVBQjxLo38oXr6fj3gPQNwPgl/fxAym6EGmDuhZVod6JPcV43URQjvUcHcXa54rWlnGws4iX4i+oLpG81rWFIOc5QHvUa+CKKAtdzL/a+Ce0jhGnm22p5bBoLFHGT38dLI0Fku+WmLg3wXpGFGc6+aksBqgAMvkrL0krXQ9tolmK461vCyXe6g/kSTNL7axbF/yGAbIvYC3ZQ6HMA1sX+jy1AgU+Xnc70itYcUBT4L6ITabsXyOM3orjFqflrzeSBmfV7C4YpYzcY21YVtkKPPb+yDKhFvef+VtzrcT8SAha/GtpP+N6xZMQQu5nxeKy+aD/O/vbGvMcQvetVjmnDFzHpA9QBgoX4/IdeYjuAFsuSzDbqOP0dw9Q
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17ef57f-cf3d-4b11-cd3f-08db615cb0d7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 22:24:53.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRZ/ecUAtPMOHY3TSjJXftWw+pPvZeybFsbXsn9uzR7WEQ6d8XDTWTscZ8YEmYIeABgaiUeXQF4KYq7UoidCPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_16,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300182
X-Proofpoint-GUID: MBpPRe2M0l9MestdIQ_NCfVPlbTTs5fa
X-Proofpoint-ORIG-GUID: MBpPRe2M0l9MestdIQ_NCfVPlbTTs5fa
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 17:41, chris hyser wrote:
> On 5/30/23 16:18, Greg KH wrote:
>> On Tue, May 30, 2023 at 03:40:08PM -0400, chris hyser wrote:
>>> v2:
>>> Apologies. I sent this the first time without including lkml.
>>>
>>> v1:
>>> This originally started as an attempt to solve a divide by zero issue 
>>> in sched
>>> debug code that was introduced when a sysctl value with non-zero 
>>> checking was
>>> moved to a simple u32 debugfs file. In looking at ways to solve this, 
>>> it was
>>> mentioned I should look at providing general debugfs files with min/max
>>> checking.
>>>
>>> One problem was that a check for greater than zero for say a u8 
>>> succeeds for a
>>> number like 256 (but stores a zero anyway) as the upper bits that 
>>> don't fit into
>>> storage are silently dropped. Therefore values greater than the 
>>> storage capacity
>>> must also fail. Getting an error when what the user wrote is not what 
>>> was
>>> actually stored, seems like a useful requirement for the other simple 
>>> files and
>>> so I moved the check into there.
>>>
>>> To enable easy testing, a test module and test script are provided 
>>> which can
>>> validate the new functions as well as check the new limits on the older
>>> functions. This was stuck under selftests, but it is not currently 
>>> tied into the
>>> testing infrastructure.
>>
>> This is a lot of new infrastructure for a single debugfs file that you
>> could just check for in the file write callback instead.
>>
>> I'm all for cool new features, but wow, this seems like major overkill.
>> Are you _SURE_ you need it all?

I do want to clarify about the size of this. It is 4 new create file 
functions, 8 static get/sets, a new struct and some simple macros. In 
keeping the style of the new code similar to prior, the lines of 
function comments for the new creates() almost equals the lines of code.

This doesn't seem to me to be as much overkill as say the xsigned 
version of these files which consumes 12 struct file_operations simply 
to provide a different string format.

-chrish


