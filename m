Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA356D3F78
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjDCIwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjDCIws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:52:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4640B3AB2;
        Mon,  3 Apr 2023 01:52:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3336273V028354;
        Mon, 3 Apr 2023 08:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EyqCI+HBRuNaljF3uXc1EmVTrOqdlaWGQn6lqX4gHWg=;
 b=QEIq3DrGOfC0j3tOJwuzFBQwMn02DEZB4FHjgDXkYPoQIEU910xszz/skFRb3QNznglS
 GHiWoecG/0tg3V3dM/UZErl2GbICG+dddzilQ6GNQefnGO9Ua38ijNQ9nZhciA/jedwm
 WY2H+p9zQRqrRyTcvm50QTSKKsstVnhOWCY3u13EGi6Xh1TRYoiA83VkfJRkBuJYsc/D
 N7RXOjyl7rDCKhRNsmIH4a95nyqNyfAE7lMnMyb9jQ40ps23lowBkR6KTjPd47s1OV7q
 BQfQsTP+tRUoZNq3509mQGMrFPrGwWNzZs+Z/WQQymFV2ZHPXpdA0Pn67JSsKlYavjn3 Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcgajjyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 08:52:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33385UbN027948;
        Mon, 3 Apr 2023 08:52:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt24bt7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 08:52:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/110WlggOdE8oW6tNR4xoptriKqIYQfRe7VFjRmYTgsipN/4jil02t6w8Qju1dvFHUPc85m5Lihx2Bdn4YDyHE6GF4GjDxxtwNXSWT87vCk3t0etBzqyNmnESWT/dS9q0JmvvKN1iUvPFpJ9yzwoieAmXTKQ6kHR2sg2diBGAXGK8tWU+E7BKbVtD7IYWQUxIzRIz3D4e81KFqGrBIbUAAi7Izk+5iwEautTaLKDAi0/wgl6RwZTo0XOYB+gTk/CbI3AxW+zwsTqC4sLAbP2lF/I+U0Ql6W8Gsz/RRammnf9j75i5gipNSZH6BMCqQSWqMSubFNC9qqedgGunfnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyqCI+HBRuNaljF3uXc1EmVTrOqdlaWGQn6lqX4gHWg=;
 b=DqXFaxjnl2RBYXPxjBxR66cV7pFvvZjh0QO5gwSyk1G464fMC/egzUA9ZizKfodSK5hZUdXvuFp392m5+Pw2h3B/URmVq4AKGqudVVGKvfjvwE5WiUPNDHl16XSO63KwlsqPZVxEZ81Z8AElydZs31rXFlAKR5BuPIBjxu2CllAzfpRN8iuWZ9ifw+cd8ENZWO3vum+dvbZ58w90qGDT9nU8zugGmFg09nAcChx0UOqXVOpb4zdEVQpK2lgForFsWgdiYJ4gQc7YZGIn0dAgSkmqjKbJTJZndrSueZJVykzjc3zlJ2mgkaCbtb/Nx2zt2INvxQELEzOLFQ89lnpofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyqCI+HBRuNaljF3uXc1EmVTrOqdlaWGQn6lqX4gHWg=;
 b=r/RMH2c0mz2QQ9YX8uSi1FKI23KebmstkyQWTvs89bdaxmH4cDSQAaNFr3yUZMtQ+9EnuxJiLMj1tg1uzMmSaJWfKtDByAa9weusoALP7/8AGMBvO9xjzROmDlzWWCEqG96W3zHQ/9vhDr1wYgsS6esl1Mm0q4grcY88lT8NodU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4846.namprd10.prod.outlook.com (2603:10b6:5:38c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 08:52:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 08:52:38 +0000
Message-ID: <989d6e48-c440-5bf3-6fef-c0c76fdfc3ca@oracle.com>
Date:   Mon, 3 Apr 2023 09:52:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] scsi: ufs: mcq: Limit the amount of inflight requests
Content-Language: en-US
To:     Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20230331074650.75-1-avri.altman@wdc.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230331074650.75-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: 9091acc1-a735-4f61-d3fb-08db3420c700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gi3eiA+j4B9yzeqZBfe/lw1VUMdOdIOVLGw2GU0A2hdDspTKAvbb105UYR0uR6mB9s5VN7uLcLwnacK8Rr7UgwpcWNyHL+pO5V3BoRltHur/VYeQaJkFwi/N4HOsHVW/Yv2PQgS/U7zp5wijMUcsINLquCzpEL9FKNCDZ3WxEiNF9oohBjwuaSVFqDrENmCdIj6r0QY6Vkq4Z1ChQQV9EEbvQcj5MwT5s3V3UvreQVuC9cf4GIWCFR8VWH7nnH6OYAaj2ZFbtPRQI3CGMTITQi/BQG8GLuxLupOtk8s76QuZnAvqRMvdpr9PWsyuwN+wQAeDtcqEY6hVtvZhI5dqJLsW4lWi2A+leClGM54pdqAL/ju/APcPx2Czw8Iz9nBGv/51jFcol3IKOI3PQXvTwVDnZ+g3QJxZVmaoZjLFmXVvCnFDbM772zlHB3aXc++le5CHa0VGjRE85t59NBylbtd+JAfhbYyIw9qMAxCNlPQpVGUT/lFMhNxGDdHK5E3ysSSdYQaDK8D1cSqwgimJ6QX//lX1qZqHYH7kHjSln2Cfs1B6HEErvOBGldI4fXLOU7cyoib8nx1y3MOs9rJMT0mtiamV3H2jEKj7L1jPcyze8pv9xRpFWZJgEK09q/Pqhf9TOm8uTN6/otxoc3oS6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(31696002)(86362001)(36756003)(2906002)(31686004)(36916002)(2616005)(53546011)(83380400001)(186003)(6512007)(6506007)(26005)(6486002)(6666004)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(5660300002)(38100700002)(110136005)(54906003)(316002)(6636002)(478600001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVJjeHRoMGd5VlQ4ZGhOS3N2WEcwRnVWazBuWDRjWFdNcXVpSHgwU2ZyRExq?=
 =?utf-8?B?bGFFbFNURkV5bXhvZGxZNEZkVTBTUW9FOFF4a3FWUVorUjIzMnd5RXV0dFpl?=
 =?utf-8?B?Y1dQK2t1VS9HbzloMFRkS0c0OWt3UzNybW45SHYxSWVsS1liRFV6am1CUHVN?=
 =?utf-8?B?NGY4WFpTTWFNN3Y1UTFDUTEvVlF5OGEwdmhnK0hiRFp0dy80bVp0aU1WNm5t?=
 =?utf-8?B?NHB2azk2MDlUeTdXUkZsQkgrQTRHYTkwSjZzUnRJelFGWldKT1krOTUyMTNx?=
 =?utf-8?B?SkRyZi94b1h6RC8vaVZxaHN1YWpaSXkyVS9SMVE4d0w0YXRPY3ltaEFmOEdD?=
 =?utf-8?B?VG9mYTN1Q2JkZzJiZ1N1SkNmZEVaNVlvR1ZoSFRuRmgxTXZFZmNXbGc1OXZL?=
 =?utf-8?B?NnZRYUhQaE1aWTBrQkJBc2FGRStpaTZDYTRaM2w1SzFzbHMxYmlZZExNdGZM?=
 =?utf-8?B?SnY2b3dCMFJ4dzZKd0syNkJMZkVIUml1Mzg5aTIyb0cwSU1iekRHTGZPK0hU?=
 =?utf-8?B?dU94WEJYZWF4amtZY0VwbU12MkdjL3BGUW0rRDdKV0NxaFRNZ2VMRFpKS0lP?=
 =?utf-8?B?QTl3UG5hVlo4WXlzS2V6aFdVQjZwelkwM21NNUFWRGZkekZHMHhXakJiclhT?=
 =?utf-8?B?YUxhUmFCZmFhUTA5NnFncVh2S0Y0UmN0S2oyckkxZUNOT1lTRUd4S2xKOGRU?=
 =?utf-8?B?VHEyRkNCMlVZMUN4MUdXNWcxK2E2N0tYRDNhTy9KTTQwd09wRWJQeWNPOVh0?=
 =?utf-8?B?Vm9SS1VrMjMwLytNeHR5Y1RVSGtFWjI1MVNQRkE4T2VUNGp1OEFET3lmcmlE?=
 =?utf-8?B?U3MrZ25aNmpnT0dsRjdFbURYWXA5bStid1doMUZHS2ppVVdSOWZ0THNqN2ho?=
 =?utf-8?B?L1pkMjFqZ3dDc2RSdjVOVi81ZEJybWJWOUtMbHRYMW94TmYyaUtvZTZuOWFJ?=
 =?utf-8?B?czYxYzlQRG56TFNWcTUvOUc5VGdDZEl2VUJFRTRLVUl3eXVwTHZHUkhtVDIv?=
 =?utf-8?B?aXlmdXZqUi9vamFXODc4d25mRG9hSXBwRDMyM2dGa3V0aVRHZ3Jkdm5oWHpH?=
 =?utf-8?B?YnhzMVhveTIxeHhDMHJLaHU4OCt2SnRnQndqWUlWZTBqdUpNV0tmdkpoejNQ?=
 =?utf-8?B?SXBOVlQ0UXhsc1N3a2ptUHRwcVk0UTV1ZFVSTVdFL2lHb0tlWHpxY05hUTEr?=
 =?utf-8?B?RTNyNXFDNnRDN0tvbHNyM0Fhek1pUDRRYVlRMU1FenNtRTg5VlhSaUN0ZDQ0?=
 =?utf-8?B?TklaNStHeHFvK1psNXJ6Q29iSG9zTGpTQXFwcGZuaFV2Z3pvOGp3MTg5Tzcz?=
 =?utf-8?B?cVE3WndYM0pZWWdvMUJKQ2FyYTVoT1lTMzBhbVZGMWlGWXN5SDhNTEtYYTJR?=
 =?utf-8?B?R1R4QWxFdFhhdkd4ZVRCWjdXQUk2b1NwM0krTElzTldKV1pjaW5mTk9Fc3ph?=
 =?utf-8?B?enB4RHJkM2R0aVoySlo3UTlKbnlFTWFVTE9Sczh4S1p0Qkx4MmNzRTNHUnZW?=
 =?utf-8?B?NzljVDdNbU5palE4d2ZzV1RiM1pmT0hIUTI3Vmx0UWhOVnBxeWVramVtMXM5?=
 =?utf-8?B?ZVlneENoVW9lemJiU1MvQjNQVEI4U0R0eXNENVRZVzc1cFpwZFBUNjlFVGpW?=
 =?utf-8?B?T01sSmdzeW1Vd3NwaG9ueGIyM3ZIbVFLSjdxeDBaNVFtamlLY3RNUWFQZWZm?=
 =?utf-8?B?T0tQTWpCZnFpaU9FS0p3amxrbGxSaEladitySWtPWk1XVjdyRWJHaTUyYThJ?=
 =?utf-8?B?N0h2ajdGZk4wcnArY1o1eTVOK2tLczdoYUxOTGY2cEVhQjRxNXdtTEI4UHJt?=
 =?utf-8?B?K2dhMmJrZjRtdk5mQXZNMWJVdlZESGFlbSsyejVHUEF5Q0h3THFKRGNwN0Rm?=
 =?utf-8?B?QXQwQzVHNWFQSWZyYnRnUko2ZGFWMXRhS3JKM096amIrSDJUaHVmQU9Ga0FT?=
 =?utf-8?B?RTlOY1FlTkdiSlFqUUtiRFh0SVkxcjZ2RDl1V2J2L3cySGhobE1lZ28xQzVZ?=
 =?utf-8?B?TWJlWFE1VWJUS1dyM0xIeVY3MElKK3JoSWN6TnVUOUtlQ2JYNFh1ZUZyM0Vp?=
 =?utf-8?B?S0pSVkxWT211c3ZnSDVrYUM5NUxmQm9Qb2VuRDFYRHN0clpGYU5nVWxIb1Zr?=
 =?utf-8?B?NFdCaXUwK1FYYTVuYzdqb0V5SnFMM2lTY1M3RGVFR3FWWFJXbXc3VDhsYlE2?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AyH4s5gYXkOVk2XYOpc6Tzc3SfXTqFTJvmC0FRbSCYRfBc8l0QXN5VMnlkWagH2XaEKqC0olgXLEN9OqMT4UF7i7vVNJf2qFxIJZUdiACjAc2JJeAosvIWjdBJx3shbMdmwZQ0p25aZwf79umQAwhTxhd4gQ3h5rJWXkXcmWJf+hYcLy+0u3hxjL1H/x5DtErmbYQ1Tq52IWpwnpHnneWdJmOIdm8xTIwEYiF4fjxi90OmZA3Cw6aS7sjamB3iQ+/WYiNPLcTXQYKqCqNLcc7zUcTDQB+dB/88TaSg3TPTAmmxjknbWRX+8Q05tkSfx58KJduvTJKobbbLGzaxp6wrzQPHtneA8rxaoEItK9P1Ux84N3MAM55OTc0K4oPedtmeAU7i1N1xpl7unn/avQqTf3E7rDF/mEptfJocG7RiAjJ049M1WafKTLFPhUSZlBjnAgkHsnet2xIZjW7PBHC2xaHbBeijCKKGRuCzU86CgobzNgGYSf/yRictPsc/lTSJhH1LA4jlSOnx+R+Qm7eB/zq1vDy3rCl18ifvr6yFcZnqb+knofn2mU1GQu5GeeRbLerXUHQhfEEauOmvithApXT5mk4+AaR4Dyx3LT5lE1PM79LXn2LSffSS6ZcedV9gW91v9a+Jp4490Gwy6woZ5M0Kzk0N2pQbpQmq1lqjuriNS1HllnhSXXIG8PdwpEVLvFqn2uRvS7IyJLXaTmHKZZeY+vEMlHh5CtP2CvpdIUwaEJBkzKDOmdfrBTix6hLSKOJyDxcHzUl2lkmi0gQXbSSBOhmOWr/i1QhArm+RWDGqwY8qDeRndwOJ1jpMFIZlUVGxpbktoKWFYHjN1yQQfAw4mH6GT0VkI5P5Oz/OaRL1Z/XSKPpdnzDOC8dbB/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9091acc1-a735-4f61-d3fb-08db3420c700
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 08:52:38.7308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXAQ4+bq6LaiSrV0omyf1eOTPT1ZIYWRKIaWsVML5jiKFNr3IOdNj7Cv+KJekswP63N0l8z2WHO3EXVz9tgFSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_06,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030067
X-Proofpoint-GUID: 8uYEBOpx-cX9s1hImbBlLNF8bhY6UYAY
X-Proofpoint-ORIG-GUID: 8uYEBOpx-cX9s1hImbBlLNF8bhY6UYAY
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 08:46, Avri Altman wrote:
> in UFS, each request is designated via the triplet <iid, lun, task tag>.
> 
> In UFS4.0 the Initiator ID field is 8 bits wide, comprised of the
> EXT_IID and IID fields. Together with the task tag (single byte), they
> limit the driver's hw queues capacity.
> 
> ---
> v1 -> v2:
> Attend Johannes's and Bart's comments
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>   drivers/ufs/core/ufshcd.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 35a3bd95c5e4..cac7c9918c5b 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8468,6 +8468,11 @@ static int ufshcd_alloc_mcq(struct ufs_hba *hba)
>   	if (ret)
>   		goto err;
>   
> +	if (hba->nutrs * hba->nr_hw_queues > SZ_64K - 1) {

If shost->host_tagset is set - which it seems to be for this driver - 
then the number of HW queues would not influence how many IOs the host 
may be sent. Rather this is just limited by just the HW queue depth.

Thanks,
John

> +		dev_info(hba->dev, "there can be at most 64K inflight requests\n");
> +		goto err;
> +	}
> +
>   	/*
>   	 * Previously allocated memory for nutrs may not be enough in MCQ mode.
>   	 * Number of supported tags in MCQ mode may be larger than SDB mode.

