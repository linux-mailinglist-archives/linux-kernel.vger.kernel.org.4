Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7C370849D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjERPGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjERPEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:04:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1010E1FDA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:04:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IofS006514;
        Thu, 18 May 2023 15:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Aos1AVGdjWHn059SwTHZWqwGUJ2ZWPZD+J9sqHzXxyI=;
 b=HyFTil8CgR+7thQNpSUu317aRZ0Id8qltjZpaT1VK+pwHiUUdyWShYsPdljyfYTeND5q
 eAA8Fni6hwdwvIdowKiOfkZZUOcmxDXYIZ7rSIiScHcOwElP2wDj6A6UugQOcEXNTV+a
 Frw/t7vPk7cLTpzyQQvS6sHNPZsTi8qbNm6M3B2JMMwBvkqfEbE9GolQVpVuEi1F6+jR
 HmMr2H1jB6lJ+YwwJ/DklE+a19OzSPubt1yaBZkj4JbyJ+yuN+jEpt+8E8HcgX3aPCf5
 7MP11w10l29A6MQ+NnSw2JLKxprNcUeWu89utVhszt5OHzWARN2ipQpaNJFFAmCb0WKH 0w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye8371-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 15:03:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDop4n004223;
        Thu, 18 May 2023 15:03:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10d6j96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 15:03:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xg9MAwbFWKhkILYBnPJw75bBwZxAOIgWM9lWvAwvBoxqQqyBiOUD4UdRCH57Zs2l5h1DdOiVejcgD80zTBapHswJWEYnww/SyZy9Pzm3JJggl2Y6DlyPpaBRM1s/MYPT9MPT7WZDZCFDOR3gydWjToD6v4SdRoAqH9Z4PnuZh+OFjDyA1+sLuvqwtXuqGpNKCTFSj/QUcLkv9DOnG38ZHzXgPVA/x7yNHFOToz8FGjzZowjrp6h0gzBVjs6t8NStHMsZjszOdpVxJiL9Yu16MsmqcHFrIOX0Gt5yk5P2JnRFl42KTTDNOsBh1cKyaZgFFptCsUHatQI5zzO2jINc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aos1AVGdjWHn059SwTHZWqwGUJ2ZWPZD+J9sqHzXxyI=;
 b=HYketEKRjnXF35SPRS1sXR9A1Drbb/3IgtQkQ/CvdVCkIk/e5enGMLdKvWqEa/5QLCoE8lQ2MbIPUyfXm8Qz+AJ8pDYZbafH18LnVnZjqDMR7s+F5PFy7Mulx+Ea05WBOcRMoHYm9FuNq8WoXAfeUJm1En9L/eDwAPcv+myGCgR4c0jFmEtKnwLDC5FTreav+FWyXIJh0F8f0OO/mD+4eMlyFcVtJrWLGoiAErh9CCmBiaSo8tEdUFoLGtt5g/wntACJafaddimfx7r96Q1Pa+EZHc2WUKsee9rtpHQkVt85ZZrryvKrxNMn6fRDsUmdb4y3QvpwU2xTAQjxhUaAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aos1AVGdjWHn059SwTHZWqwGUJ2ZWPZD+J9sqHzXxyI=;
 b=TPW7f4k+841u1SgGoqt5yGrYdrQ9acf7n8sB3Wt8JqTsQAsPwjRTEuMUXV7Y4eWn6NVdRyfcSHzBudNwYn2ZFBavIfE3AB+SqeK0Wf4o7HIxZcsEcZxtWBp98dp9HzCbyvuiLzpdsXV5reV9JihwJUWtISfueMBaVYoEtNYR69w=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH7PR10MB6986.namprd10.prod.outlook.com (2603:10b6:510:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 15:03:34 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 15:03:34 +0000
Message-ID: <81e1a94d-531a-2e43-baee-da4b35644e87@oracle.com>
Date:   Thu, 18 May 2023 10:03:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 5/8] vhost: Add callback that stops new work and waits
 on running ones
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-6-michael.christie@oracle.com>
 <20230518-lokomotive-aufziehen-dbc432136b76@brauner>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230518-lokomotive-aufziehen-dbc432136b76@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::6) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH7PR10MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 406a05c9-3780-405d-8248-08db57b10cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMVH282xQo0EfcMX4IHGzxLBe5qmq7FEQuZEt8O5bSTBWP0iJspOGrH0iV6w5rCM8jpbr0M6u/QEPBf4g4HE1Pz2kpX5T5VJqWHUgS7YAlncbTueKO722Uws+KbEiFU1R4c7S3AeI1pl6Jl28B+rWalQRYBdjYSYDyFC/pnYAkOHFz2UT7ydQRBX9f9eFMPEyhxDLif/VvzovKX78KXkAX9yY4N3KBXaE7GkJYMFyFg0m7dJpjGNKeomg+gE5xGvvzf19nl9kT0KPMBpxSv58TwVj6R6xf9u7hyGr/o+sbB006G/4KT46WvyXaCFnn7DFLzuK/ajpThnwp17xDtZk8+Tfz1425JxgR3+CfPfoPwUjiSHdeLpkfH0qHWoIdtykcLLTKJD24tzMKCm41eJKX4ZcgtFz4EREQH/mf1K3DDlKfArg2uWeVpSd1moaIMcsyAt2ZzeaolJ8hVqLCOJ3RAMgLWxXNSWXN8iSOpGobBm36Kb6qmTnCJ2wsGd+mo7JQ/KEkDk+FFs8Yz/RJRBUdWvSHBw5AY/xojIVhbYCX5PGdj0vkmarz0rvIQd2hxTRNDXMIxGdMtnGiSYHM2ovSgVnV+LFipgJHBJvyhz+IPm30zib2woM2F3MOJc6Y7Kj35wsvy2+GiY/VGo7eT5CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(26005)(6506007)(6512007)(53546011)(36756003)(31696002)(86362001)(2616005)(38100700002)(186003)(6486002)(7416002)(478600001)(2906002)(316002)(31686004)(8936002)(6916009)(4326008)(8676002)(41300700001)(5660300002)(66476007)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjNRY2xCUnZWZDBsSW5kSUl4dnFGaXN4SFJFZXRMTVJ0eGo2ZW9OYmV4cXF4?=
 =?utf-8?B?N3JKc1p3OU1hZUNwT3BJZGh3L0xlRGJWS01HQWNhQ28rZVVoNXRmVDBYdisx?=
 =?utf-8?B?bm01VFM2cUxWYUFqZSszUXRXZk1CVVYrQVczZU1kNmwzdFI0ZXVCWFVWZU5a?=
 =?utf-8?B?SmQ2MWxXVmNCVDRMTVE3T09NRFgvT0Z3SG1QdUFLL3pzeDNuWjdBWlAvTnNJ?=
 =?utf-8?B?VHp5L213NzhLMlBRdXkvZ1NyaElKMXUweWFwRmNtMG1CSHpkakJTL2paMnJX?=
 =?utf-8?B?Y0F6RzBqV3BxckkwL0cwV3VCUGxqOFlFeHphazNVcjFzcUtzMyt6c0o5dDF0?=
 =?utf-8?B?bXZwck1vRFFkSmxKVTFjMVN2VlA3UWgzR0t5TEp3K0VyTzFOR2FyWU9IWlhl?=
 =?utf-8?B?VFpOTDdwSXlWSEdlcTg4WUF5T3lodXE3M0NzVm94SXVhOTNPNXdvNFhsUml6?=
 =?utf-8?B?KzFJVmhTR09KeFNwQUhQd09Gc3JwNEQrcFlBU0xrN00rcGRRdm54SjRnWkxG?=
 =?utf-8?B?dkdUbVVSY1NhZ3FIZkRQd0o5b0ZQbThOY0h0WEpkcmprQUltK3pHR21uaWJU?=
 =?utf-8?B?dVpDRjRIZjc2NEZwbVd3dE1vTldHTHY3YitCaUdRcU9wVXZDdVVoejZidlpI?=
 =?utf-8?B?WC9JOFc3aU5TZWs1VHpwencwMVgxVkRFOXdFZWt0bTZ4NDhEdEpzMTMzV0Ni?=
 =?utf-8?B?YW1ReXM2SW82SWpScjVraUdXOENEUTJkSUNzNlZhaUYrakNQRTZRUWdMdmM0?=
 =?utf-8?B?SnhRSkhvdGRYNFppL3JmYXl0VVc5SDQ1RkJXS2ZhQ1YwbFY2djNBOGljM3My?=
 =?utf-8?B?dFBYVVlpZ1VBdHMrTlhwdmZpS0srL1hDaWVTWWx1ZGtBeDY3MHZoWlE4eE1p?=
 =?utf-8?B?Mk1IaFMvQWg1SmpYOWtCa1hnSURSQ1RrM3NwZzJvb3pqa0hiVGo0K1hmb3Vl?=
 =?utf-8?B?ek9BSWZNQzFzNzlnUWIxUTN2UHB2VU9mSTBTTzBxamlyRSsycm5UUkdWZVF6?=
 =?utf-8?B?UGJlcDNjWkhZa3dHUVg2Q2N0YktPMEFsNk5OelRMTHhWTzlnZUlxQm9JYkdh?=
 =?utf-8?B?YU5CVWJGRk80ekZDYmg5WHhkaEcvRjFLQkV0VDU3TUdKS21jR0M5WnpZYnY3?=
 =?utf-8?B?YzJtaEhPU2p6cGQ0c1NyeDg4SGFlM0tLa0JsUnoxd25ybXdDazVXUzNOY2Rz?=
 =?utf-8?B?UmFrUkNGaVNnZDh5Mzl1VFk1emYzQ0VwbHFzN2JVVitkTHhVUmQ5TjNmOUVa?=
 =?utf-8?B?QXAzeWhMQ2tnbmJwMkd4NmgxT1RERnlaSWZwUUdqano5OE92a2RYYm5XTXFj?=
 =?utf-8?B?VzlVYXZ2S2hlOEpvTU91WHJJc1VIZkt4amZVMjdOblZSNytrR0tObGZKSnU0?=
 =?utf-8?B?NDdkVmZUYXRKaG1DdlFWcGFrL2FQdGJBa2hHeDBTSGhGVGMwL2ZyRXprcE92?=
 =?utf-8?B?NktYNFp4ZU0vV0RndzdIK2lqeXhWL2xkeFFDb3B6WGNPdStSazFrZkFoc3Ez?=
 =?utf-8?B?TVhtTm1BbTJQemlZblZuTjRocWtmeTYyTHNhdi9yYVljMU5WS1dXM2JLMlpl?=
 =?utf-8?B?TXhmTm5uakxubVF5citqekFuU3c1TWh2UVdwSTBLQWdrVE5ZL2tjejNhZ0Nj?=
 =?utf-8?B?WCs1T3l0US9udHdHV3BKVW41L2FjVjdqb2pqZFBZUkMyaS84NDVwT25PZFRs?=
 =?utf-8?B?bVY2bDZUeDNKZC8vNkhOZ0o3aUVzNUZUWGU3VGtjYVdVOFVHL2Y2KzdyMzU1?=
 =?utf-8?B?VWkycGM0NU1IdDB2KzdvZEFYMktoL0x5N1hyVkw5TUE0STU4aS9rc3pFa0JB?=
 =?utf-8?B?Q1ZyRThoNmJydWhmeDBabi90MkVDa1A5Smw5TDF4cDVjclFqS0V6WEkwSmQy?=
 =?utf-8?B?WXVUNUdkYktDUWlObXRKYXozb1ZnQ3pzb0wwUGN0NWNvdTV1c2YwdkZ3dFNz?=
 =?utf-8?B?WVVibTBVN2ZIQkJZVitiam8wY29zbS9qWGpNNHRtNkpKNWhqV0tnSnZJUVFW?=
 =?utf-8?B?TS85cjJTUmpuR3hpL3UyekJNYTgxRGdoNVdMbEpCRHo4YThJRFExeG14ZHQ5?=
 =?utf-8?B?aHZBUW5zdEMwSkVabmhXN3FNcDBXd3VnQTJJSEk4T3R5YVYybk54Q2ViVkJr?=
 =?utf-8?B?NVdoTDVyTklmMUVrbVpyQm54dW4ydUdSNWZIbDQ2bVhmYW5pUCtGN0RNbnFJ?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b1hBSnQycnVyNy80RFJjc0lCanZ0SFN0a1Q5TW5JMG9EMWdzUDZPMzV6WVJp?=
 =?utf-8?B?YUttUG0yeVEwamZtd3hvNGdKWTN5bXkvT3RycmNjUEliZEdXRUoyWW0wTXI4?=
 =?utf-8?B?eFBWM3BSLy9mS1JXYTdGM2RUMVJMWkhURndFdE9iRVlJc3F5Sk0wRGpVay9i?=
 =?utf-8?B?OXRLZmkwQ0ZmY1FTY2xnSW1pQXNvWmtqbE9jZi9kZXdlemdWYzZ1a0FDV1Bo?=
 =?utf-8?B?aENnNlRVcVQrdDFRVmVuUXRQVkZRVEhLbjVvTEQ3aUtWWlBoSTVWanNKQUhy?=
 =?utf-8?B?MlhsRkp3SUVkazNZZm9ZOUJYOGpIQWJqUXU5RE5hYis0TGcyaGhIclVtN1Fx?=
 =?utf-8?B?bXJhajd4MHVpdHE1YWRxTlhQd29jdDFHcFFVL0FHcCtsMFBoVnNlRE1JeVNQ?=
 =?utf-8?B?YnJVMXIwRFpId3AvbUFaRWVZSXhicFhuV0Z5eGdVckFzUjZ3VGVuTGxRQWpy?=
 =?utf-8?B?L1pKTE1oYXNaVTM0WXFOSVdWL0NzazVKNDcxdGY1aUVneVVXYmY5ck9TRWww?=
 =?utf-8?B?WVZNRU1qdnhqMG1DYkRwQWFnRjIwV25sU2hLOHU3Unhoa3dIWGxVZXVsaGJG?=
 =?utf-8?B?Njl6cG9zVExKOXlxaHpWQnFwc2VraFNBd3JOcCtHMVEvKzdpbFJBQmhHVmZ2?=
 =?utf-8?B?TEozV1dVUFlaTVZGQU9odnEwa3dhOU1Bc1pBMFVZNnB4bld3YmJKM3Z4WHg4?=
 =?utf-8?B?NzRORG1BSzBhV2ZqaGlsL3pSaGJ5cThsMk80Z0J0RzdUZXVXU2ZPb092NXNj?=
 =?utf-8?B?eFlmZnM5TXdUMlRJVk1lV2JsTWRqNm9MUHFHcTM0NGVvOWRGN0dZWGpmcU04?=
 =?utf-8?B?a0lxeXFsRnVJdkJlWnQyYnRIRWZnejg4RlBqVEY3K3ljNVlmYUo5ZkMrVXcr?=
 =?utf-8?B?Q1l1bTlwWWI2anFONUR0OGRiNmE1V1JHSzdGcCtuYkxOUlZKSVJKdFhIMVgz?=
 =?utf-8?B?bDRQTGxJQ0hnZElGdWRBV0hxUHcybVkxY1ZPajVuWVQ2UmRUTEtIWHJkbzRK?=
 =?utf-8?B?ZjM4N2lEZ3JiZHdXcXZ4dTYySHdHV2pMSGd4VUo3NEtETFJxeVZNK2w5d2JU?=
 =?utf-8?B?cmVpWTcyd2xONjI1cUw4OXd2dWxhamNnOVpwOHFIdzV4clBNYlJMM2t5ZFAv?=
 =?utf-8?B?czN1U29GU0VGS0IwTXhTdHZ1a0F5TDNPeFdlZi9ybXpQSWdHUmk5MDMrcFVY?=
 =?utf-8?B?emZOazNjNUl6OTdzdVZFdjk3ZVNxZHl5aktLaG92S0czaHJlT2ZLQjlyUXdR?=
 =?utf-8?B?UHA1dGZjZUw2M0JiYVpxMDNpR0JTeDF6bzhIYkwwTkplbllzQUdDeExrYUk2?=
 =?utf-8?B?WERPdW9hZmZTWWNWVDZiekUwb1ByNmo4ZTJNVExzWUsyTU03NWNEVE9QNkVV?=
 =?utf-8?B?eXJ0M0thbmV2M00vTC9SSkhJaXhUTS92UG81aGVrK3p2d2Yxa2w5VHBWcFF3?=
 =?utf-8?Q?yBuEgPLI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406a05c9-3780-405d-8248-08db57b10cc2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:03:33.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRKmQ6QC6nazCGWxEhwgECDf8Fq0dJDsx9AIR/H5HgbI1B+Ajex2qXMD8IbvH0Qx7+cskKL/WsS6mxxaGJ/I99ZROQUpN+qUVGxAawHm+xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=555 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180121
X-Proofpoint-ORIG-GUID: gC1aYA9ZWHR8J0V6V0r7n-hwpOYJNjYv
X-Proofpoint-GUID: gC1aYA9ZWHR8J0V6V0r7n-hwpOYJNjYv
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 9:18 AM, Christian Brauner wrote:
>> @@ -352,12 +353,13 @@ static int vhost_worker(void *data)
>>  		if (!node) {
>>  			schedule();
>>  			/*
>> -			 * When we get a SIGKILL our release function will
>> -			 * be called. That will stop new IOs from being queued
>> -			 * and check for outstanding cmd responses. It will then
>> -			 * call vhost_task_stop to exit us.
>> +			 * When we get a SIGKILL we kick off a work to
>> +			 * run the driver's helper to stop new work and
>> +			 * handle completions. When they are done they will
>> +			 * call vhost_task_stop to tell us to exit.
>>  			 */
>> -			vhost_task_get_signal();
>> +			if (vhost_task_get_signal())
>> +				schedule_work(&dev->destroy_worker);
>>  		}
> 
> I'm pretty sure you still need to actually call exit here. Basically
> mirror what's done in io_worker_exit() minus the io specific bits.

We do call do_exit(). Once destory_worker has flushed the device and
all outstanding IO has completed it call vhost_task_stop(). vhost_worker()
above then breaks out of the loop and returns and vhost_task_fn() does
do_exit().
