Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ABD6E2BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 23:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDNVgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 17:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDNVgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 17:36:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3A765B7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:36:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGusL0028740;
        Fri, 14 Apr 2023 21:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tWL1+WqOekZI8fOyQNduLpVUzthbPJ3Gbi5Yr9ONVys=;
 b=NDnV9Syikg+w6f9d89gglVQAcZY89QbCPld/4387ndZMtDdT9965zn9jmszXWPWS/NPr
 nLS/BSWmDp9RlyHpuBMOVK0DNdYSQxd/qz2cAHM0TDDNqdYbxQDRCgruLqZzCrq75IRS
 nn/IESx7zlO2UNRaEySYyNMwvYWn2xFU08pXCFvbP9nGU3ycb9/4bxK7++KH7soQXq69
 qL16o0HrWN9GO7JADmFjpdskn96VJqi6uVA5k44PqUQ/Oswqi3SZI54TPyve8nZ/S3sw
 8Jb81xttRP3ifJ0qTn0eTgPE+fu9QiVK3qOHYIgKu2kW/5Ze5VEz1xOMh2PoKoEMQJcu jQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0etxtw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 21:36:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33EKV1L8018829;
        Fri, 14 Apr 2023 21:35:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puwbtm6sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 21:35:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn/Hb0KC/xn7WqI/Nhyj5zIkpAiD4vVJ02Pj7nvP7Ec+YFAaSA4dSg5XJPatcvoCXs9be1eywfkcCfZ6xFLr6IYpn1cbfWFgGn0TpokLTiABsFvtINxslYVWj6uPPRztneOlZf5gV+L0JK2Ncwn0Oac09D/tgtfStHi6Y5QNDavkF+tUdu1z7p7EErKYHMdGepoV82IUPyy2TCHV4KOPY6/cWggCTp4ez6HdMbfN2lJ0Iosgj1UvSUdY5wZALRsArve4s3vdus8nhmgIYqzKxXhKU4pAYFQj+8nZ9nEii72LrJ46HVynBUBgYKiZi/w+4Dp56RYqkPt4pz8vP8OIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWL1+WqOekZI8fOyQNduLpVUzthbPJ3Gbi5Yr9ONVys=;
 b=UAW+SFtXN+ks4mgGbmtDWgw/4cgjqUznbC7tvIxsbfGJOsuffd3jxUo8debyho2ugKvfN2v5rE88kGfG0rrs3iu1lShipfCj72LRRuCr5XSOPKlNUa/Suuc0HHjGv2YbXmGiCGaoQfnRHM5RDWyPhz9lBT0uYgWckzZr8hL6fL8m3Am4j4WVinxdnHqdXh11JDiB67lC1nBCEWM3RQSppzr+/vSa5Bix/rKY8A+OjYU/v9AdGJPRCHk0LPuGZIsNFg7thJKUUlBOyDaDf6Jqa7y4VZ3lP3zegxyi6o8t7n7fmKV0d15udKOOoUo2hHrFO986sKSH6ZKxhAIbdHpzpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWL1+WqOekZI8fOyQNduLpVUzthbPJ3Gbi5Yr9ONVys=;
 b=qp2GIgRpeBeFY9UawuhtWsytRBL819ebmSjsl2XFfvFxL2zSCNZxrFL5/iKnHj8Ad1LxjOH6QEMnpxdsisiiLUGXPWQoGOlHk3KV9SXWE8yDbN/n73y03d/wMuIKi5H5hegsuwvNlV/fNhMpgwGbO9WJ0DuSPJcoqIg3VccFtxw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by IA1PR10MB5994.namprd10.prod.outlook.com (2603:10b6:208:3ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Fri, 14 Apr
 2023 21:35:31 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%6]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 21:35:31 +0000
Message-ID: <832d2b34-d18d-dbc3-1836-2d3e3381afcc@oracle.com>
Date:   Fri, 14 Apr 2023 14:35:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/folio: Avoid special handling for order value 0 in
 folio_set_order
To:     Tarun Sahu <tsahu@linux.ibm.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, muchun.song@linux.dev,
        mike.kravetz@oracle.com, aneesh.kumar@linux.ibm.com,
        willy@infradead.org, gerald.schaefer@linux.ibm.com,
        linux-kernel@vger.kernel.org, jaypatel@linux.ibm.com
References: <20230414194832.973194-1-tsahu@linux.ibm.com>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230414194832.973194-1-tsahu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0045.prod.exchangelabs.com (2603:10b6:a03:94::22)
 To CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|IA1PR10MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6a3e2d-2109-43a5-da34-08db3d302bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRTz/nEnI+CaX2HE1swcldmbI6nh7odLI+5vUcSWMkcrgNvQUGTvd1GhQ5h3gXWaq/Jns4q6XU8CZYW5aOfXUbn1goZWOCK1iwucpTFNLRm15Y8v0fi1mD0E/rh3taK7U1hpXgQ3TiqK8IowdNvZS/K5/FHm3bsc5yIxwQ5WHgxYDFmpRD1GDJmJaq5R5SJyyMR/i3qKJrOeetddzxNfpzzlZ6Dv0UApHBO3JICt2BKE68m0H1ValtNSG+2yrNI0kEp7B/GG/1Ho49R5iKTREyhvesquFocLaaYv7/BQaRARt50wVCDajCCMFncgg2QUAGFbEj2YvNpsEJTX4RSKYQf5+Wc6nwbgL4dXB0S0xwC4K1aoqg7nKHmoBdKCrENxs5mK0uYqnZPVzDH55NsrOKU42dD+7/+RBSa7bXdDZmbEEI0AN/KxnpvvEVhvrl1Zb+4NdjefyQBe9lx1ms+EmSN4bBjMrNttA9xVqD6LAtOo5zLTmHpRuAy8TLfY18eLR70e06L/6s1EDdzKaVqhr0bjU40oe2WKvK+w2tezY4Gnc15xKWg9LeI9nGGOXI2n/qDUXGd/i04Q2oDe6a9ba+pgibmqT9n0VIlIMYtcUu/BpnXwWqDcACeIwNp3uTTomXILKeUG7S/PKeW/QjMeKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(31686004)(966005)(66556008)(4326008)(66946007)(66476007)(316002)(6486002)(83380400001)(186003)(38100700002)(2616005)(53546011)(6512007)(6506007)(8676002)(5660300002)(8936002)(41300700001)(6666004)(478600001)(31696002)(36756003)(86362001)(2906002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vnc4d3p1QjM3M1JKTVhJcjNwUXc0VDdSS2ZMZXpPU0pOMFQyNmhneVJoNWJX?=
 =?utf-8?B?L3oxUnYrRjdweUJ3K1daR0tJL3dWa1BCMWZ3Mlh4UVlsLzh6NURtNE5YT0s3?=
 =?utf-8?B?L2ErNEZwMlorZzEvdFZwK0l0aWpFVGp0ei9oYWVYMVpUWUxOTEpBTXI0M1Yr?=
 =?utf-8?B?VTNHKytlUXIraUVjRnJidTBvc1Z4U2x1aW14cWNHTTRBdTdqZWM1ZGt0TnFp?=
 =?utf-8?B?YnpnZHlTbE1yeGtWZi9wNVJnTURRQytYbXhWc3RtWTBQd21yemxrcVZBUVNl?=
 =?utf-8?B?NStYb2kyK0N1a3BTNU9RaCtJcEk5Qnl3OEZSQm1kNlVZcmFMSVFVbFpDaU5P?=
 =?utf-8?B?TW5zamZSVGM4bGZlOEpRWC96TWIzaG4rWmlsQ0oyRmZtdnprV2Y5NCsvL2hp?=
 =?utf-8?B?L2lEaUZMdDhld29sNjB0RHpFVzd3VFE4UWtOZWVjZEE0SERCRGFOc0w1Vjg0?=
 =?utf-8?B?bDY1TGthZUpZNitDRlBURDRXL1J6Sm53NXA1QTVhS25scjZHaGwyWEtKV0c2?=
 =?utf-8?B?eW5RTldBVU96ZjY1RlByMkhEWGtrdVZjTWtncjNyQTdMZWRLelRmWVlQL01X?=
 =?utf-8?B?TGw1SFZjVzNhZmhFYU1mMHBwbC9lZ0NzNzQ5VjNTWHZGeXJoVER6NGwzeXNO?=
 =?utf-8?B?Qm1MZ0RZSUUwdXNBdDlmdEMzazcyVFRqTTZhcWFNMlRpT0UzMFZPRDVUK3dw?=
 =?utf-8?B?Wk44akVFUFIxZERpc3ZaVzl2dkFEbGMwL1A2UTg0bG9kNjVlM0twTisxVTBR?=
 =?utf-8?B?NldMcCtrWDk4Y25OVTA4TkRjdXRLNXZSV2J6TWtnZVFrZk9TSGZMYyt3d3Uy?=
 =?utf-8?B?ckpLS0Y1UzJCMlVKM3dGV1NZSnJCTklqNWh5TWxRVzJLcEhzSi9oUnJ1emIy?=
 =?utf-8?B?clZHZkVtUzQ4SVRYak9ZeWMyL3A5bVh1SmdRcitwVzFEVTE1d3ZqZWVYWkZX?=
 =?utf-8?B?SFB0NWVRdU5GT1ErRlVtRytxMTg2WnUyTUllSWl5Y21tbytJREZ3OGRaeWYw?=
 =?utf-8?B?dHJLaFZkUjYzUGc3SVRiUjRQbElCdG9tNzBYdHkyN3VTZ1lsNDFWV25OUGtq?=
 =?utf-8?B?a2pHOVN6eFJkeFM2T3JVZjRuYUV4dXVGQzRxWjQrblJTQVZ2L2p5dGM4Rk51?=
 =?utf-8?B?RUJ5Z0NyS2IyWCtnYTc1TG50eGVhcWdyYm5KeEVkT0VuOGMwR2hrTXA3RjNN?=
 =?utf-8?B?UmpnbGNvTnpid1FtZ0l4NWsramNldlhqSzh1SjRLUFkxdlk3M3I4SUFmSGtZ?=
 =?utf-8?B?a1lWeEtaRzJvOHNmVkFhMWIyeWY4V3g1a3prMVI0ZWFnT0xoYVVadDJJWTJa?=
 =?utf-8?B?WmZUUHVJellQSlJZcUthZGZxZzdoejVzS1hSMkk0Q2VPRUF3R1BmRVRQNmE1?=
 =?utf-8?B?dzQ0MzFxZDBtdUdNRjh0TVgrVC9SZ043NGlWTzRBTnNqWk9WWGc3QWRMUGNy?=
 =?utf-8?B?UEZnU1RnUE9Eb0ordmUyb3ZhZU9yV2J2NjY1bGpPRVRNVXp3RDVsVlRlaFJC?=
 =?utf-8?B?WVVuT3JJdmp2V3pCK0RxcXd6b0M4TGxmUmF1bkdzM0JZNk5hNWdDdXBGVnN0?=
 =?utf-8?B?Q24zZEtMZmFkZ3h0MHR6MmxPcmVmSWV0RjlpaWwzMEZXTmt6ZVZneG9BZkZn?=
 =?utf-8?B?a0JNWHQyUWNCbFNQRmJWeGJWTFR1K21peHg1SU9wU2JxelBra0IvMFlLdm1F?=
 =?utf-8?B?VXR5eU90enR4cnFNd09KMllMdGxOS0ttcGFiRlpiWmtFNXgvL1NHU05CSzZl?=
 =?utf-8?B?QWZ5WmxiZzlUZmZxOUw0ZTNEdUNrekhnQm1SMEU3Yko3ajMxMlN1eFlLcjRt?=
 =?utf-8?B?dGt2YnAzQzFiejRyclB3dGlDLy9KMXptKzM4N1JlODQ2QWJOMWcxRk5kQUZp?=
 =?utf-8?B?SlVXRUE3aWg4aU5ucEhybkxuWlZVWnZ3YkFNTVBpanhRUkc4NFBIdXVZcE5u?=
 =?utf-8?B?N1ZOUjlhb3B1YzJGOFYrblo1K1F6cTM2QUlHWURDM3dSdXIvRkpxM09Mb2dN?=
 =?utf-8?B?bXliVTlhbDRxVnpzQXNBNy8yVU5jM2U0ZzcxdG5IektSUExvSFRER25XRTdE?=
 =?utf-8?B?dWdhSXhGRlpaWmtrTHZsS0p1QXYweldCTGkwN3RoVkd6WTVsVys1c01GOW1H?=
 =?utf-8?B?U3JOY0RnSlRFd0FZK2pHcTdCbFByK3N3WWtRSWF1L0tnR2cySnJUMUdaQUJR?=
 =?utf-8?Q?8vSOUtgyhp8ZRX93QSB9A2U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bmx6citlSUlFRjVxamU5ZjJVNlh6aWZ5N0ZCV3NUbGQxYkZMK3ZabjRFOG9t?=
 =?utf-8?B?YkdTazFESVNOR25iN3RuUTg3VlRBeDdkK0RMZnVucklHUVpZOUQ2M1VIUmdm?=
 =?utf-8?B?M0VMc0dvMFVacTZCcEVXLzdObkRxZHRZR0JCaUdqNWRGeWxjS0pwOXZBOFVt?=
 =?utf-8?B?VXRYUWd2eUc2QzdwcU9ybStRenA3MXk5eUt0Q0Z1N2lMbmplalljUzN4bzZr?=
 =?utf-8?B?cEo1eUZEV3ZMWG4xZW5rMk5aRmcrRlV2QXMrZVFTYzFhMURrN1lsTy84U0NM?=
 =?utf-8?B?V0lCUWVPVzBEajZwSGhLU1VFRks3TWhCS1Fic2w3bUU1K2tLRndwQmJhT2Q0?=
 =?utf-8?B?OVdROVZ5eEZZQ3FybTBHZzJTaGpZTC9ueU1BeExBclVLaEZybjRqN2FRTjlX?=
 =?utf-8?B?ZE82aysrUGZJM1hCS20yNGdjbUdEZkhYNU1WMjZhVFVXaTZMc0Zzdk5sMyty?=
 =?utf-8?B?bXpPazluOXNIWUFBbWpzeVZhcVFld2hxNytxdzJEcllaa0VYVGpubTBCYnFk?=
 =?utf-8?B?WkhyTzJ4ZmZ2emNHdUhQY2xKY25ZR3NjWlBnTGN2Q01SYlFnSGsxM0hlZEVY?=
 =?utf-8?B?U1V3aDA0NUxlTGUzYklnT1BJUi9BZXdJWThpd1ovUmVBNXNQMStRTThBSXlV?=
 =?utf-8?B?UFZXUzRXaEJRSmVBaE1KbEViZHhNZjFSNjB0YThVdHByUUJzRU5kcHRuQ0lz?=
 =?utf-8?B?L3BkMHZJWmFHMVFDMHluNWpXYnJ0QVpPdlNiZ2ZIWlZMbU9wQUo5VlU4K3p2?=
 =?utf-8?B?N2xNTnpubnQzUmlXRUlrVzF6R2hOYytEM3U3QmVCUnlpN1crd3lKOEUyTEVu?=
 =?utf-8?B?RzhjSHNoTnUvZXdCQ2puM3lSNnJKTnpncm1KRk5ING5SZmNTTGRibmZJN1NB?=
 =?utf-8?B?NGpBekh3cFZhY1ZhREdlSG5BalhFUWJxT0FQa0tzTEVuQi9EOGJ1RGlUaWgr?=
 =?utf-8?B?QWNudnZyUkN3clBwUmdWOS8rU3FLcHltWHBJMlV4b3ZGUDVOQkRFR0txb1FH?=
 =?utf-8?B?QnFQSUt1WFpBc2dMclI1aklMRlVkcG44bTFLdkVidUxxSGgyc0pZY1dNVHQz?=
 =?utf-8?B?eEdSQ3Z0eWFpN2k3amtyNGxDWVNhQkQyRmxFeGd2RXpIZG1qVmRCRDFXb3VU?=
 =?utf-8?B?SEZjdWJ2MDVVTUFVd3kxYjFwM1NMTlRDMmV4T0wyUkpENTZLUDhhMU1ZSWIz?=
 =?utf-8?B?NStoZ29KczROYkRxMitaL0x0WTQyUzlLbE9RYldEc1VLdDM3enhBK096RGN1?=
 =?utf-8?Q?eEqwPBV6xSQQlv9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6a3e2d-2109-43a5-da34-08db3d302bf0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 21:35:31.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2v9ncg1o59j5ggrGpKAPaQZow2BBVDb6bQUiDGrwsIiQOv/II1HVEtbnHUSemOO8p1r/t9D9KiiirPe4HET3sj0jrfT1fyimH/MXZCAqq/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_14,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140189
X-Proofpoint-GUID: 2gBuybhriBYwsLKLtGX12EMLMZPxySxx
X-Proofpoint-ORIG-GUID: 2gBuybhriBYwsLKLtGX12EMLMZPxySxx
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 12:48 PM, Tarun Sahu wrote:
> folio_set_order(folio, 0); which is an abuse of folio_set_order as 0-order
> folio does not have any tail page to set order. folio->_folio_nr_pages is
> set to 0 for order 0 in folio_set_order. It is required because

In the previous discussion of this function, Mike mentioned having 
folio_set_order() be used for non-zero orders and adding a 
folio_clear_order() that is used to set order to 0. This could be done 
to reduce confusion.

> _folio_nr_pages overlapped with page->mapping and leaving it non zero
> caused "bad page" error while freeing gigantic hugepages. This was fixed in
> Commit ba9c1201beaa ("mm/hugetlb: clear compound_nr before freeing gigantic
> pages"). Also commit a01f43901cfb ("hugetlb: be sure to free demoted CMA
> pages to CMA") now explicitly clear page->mapping and hence we won't see
> the bad page error even if _folio_nr_pages remains unset. Also the order 0
> folios are not supposed to call folio_set_order, So now we can get rid of
> folio_set_order(folio, 0) from hugetlb code path to clear the confusion.
> 
> The patch also moves _folio_set_head and folio_set_order calls in
> __prep_compound_gigantic_folio() such that we avoid clearing them in the
> error path.
> 
> Testing: I have run LTP tests, which all passes. and also I have written
> the test in LTP which tests the bug caused by compound_nr and page->mapping
> overlapping.
> 
> https://lore.kernel.org/all/20230413090753.883953-1-tsahu@linux.ibm.com/
> 
> Running on older kernel ( < 5.10-rc7) with the above bug this fails while
> on newer kernel and, also with this patch it passes.
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>   mm/hugetlb.c  | 9 +++------
>   mm/internal.h | 8 ++------
>   2 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f16b25b1a6b9..e2540269c1dc 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1489,7 +1489,6 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
>   			set_page_refcounted(p);
>   	}
>   
> -	folio_set_order(folio, 0);
>   	__folio_clear_head(folio);
>   }
>   
> @@ -1951,9 +1950,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>   	struct page *p;
>   
>   	__folio_clear_reserved(folio);
> -	__folio_set_head(folio);
> -	/* we rely on prep_new_hugetlb_folio to set the destructor */
> -	folio_set_order(folio, order);
>   	for (i = 0; i < nr_pages; i++) {
>   		p = folio_page(folio, i);
>   
> @@ -1999,6 +1995,9 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>   		if (i != 0)
>   			set_compound_head(p, &folio->page);
>   	}

calling set_compound_head() for the tail page before the folio has the 
head flag set could seem misleading. At this point order is not set as 
well so it is not clear that the folio is a compound page folio.

> +	__folio_set_head(folio);
> +	/* we rely on prep_new_hugetlb_folio to set the destructor */
> +	folio_set_order(folio, order);
>   	atomic_set(&folio->_entire_mapcount, -1);
>   	atomic_set(&folio->_nr_pages_mapped, 0);
>   	atomic_set(&folio->_pincount, 0);
> @@ -2017,8 +2016,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>   		p = folio_page(folio, j);
>   		__ClearPageReserved(p);
>   	}
> -	folio_set_order(folio, 0);
> -	__folio_clear_head(folio);
>   	return false;
>   }
>   
> diff --git a/mm/internal.h b/mm/internal.h
> index 18cda26b8a92..0d96a3bc1d58 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -425,16 +425,12 @@ int split_free_page(struct page *free_page,
>    */
>   static inline void folio_set_order(struct folio *folio, unsigned int order)
>   {
> -	if (WARN_ON_ONCE(!folio_test_large(folio)))
> +	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
>   		return;
>   
>   	folio->_folio_order = order;
>   #ifdef CONFIG_64BIT
> -	/*
> -	 * When hugetlb dissolves a folio, we need to clear the tail
> -	 * page, rather than setting nr_pages to 1.
> -	 */
> -	folio->_folio_nr_pages = order ? 1U << order : 0;
> +	folio->_folio_nr_pages = 1U << order;
>   #endif
>   }
>   

