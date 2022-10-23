Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E8F60910F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 05:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJWDWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 23:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJWDWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 23:22:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C577C1E2;
        Sat, 22 Oct 2022 20:22:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29MKvmmV027181;
        Sun, 23 Oct 2022 03:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=84nTQa22sKdI1n+DRAb8jtu74zSMoHc1mKYoZl3lhao=;
 b=lgH0CtprMz9ryjRAQKFGuN6Ewxu3jGKl8bCUGa/Pr++eaHdrZKRvYMi9j0IPmxunnjfx
 uLtfBN2kyIM3l0nX1pw40hI8Gvy/B5mbVkBeJl8s+fwWzLX89bqslRqEUqe9B0UHHIGW
 70Q/u2vaF9CoOpTbOhGKNQejsz0CROSSgdKnulydyLEGfRWi8scKDKpmKy8wM4IgGeew
 RvfPxtR0HgtB6kVnNdjEHhLfLU/i1h6QohHx6Sb1Y/HfCBw5kR0w5OAmatXWmLDC9myS
 klZ0zlzfyZ3OQqgtpRj5JjZu+DEpXLpPjQCL8V/tbWpcF0e78NV3DJ/9vX5NiD1ylgdx iA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc741h8wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Oct 2022 03:22:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29MIS59V040416;
        Sun, 23 Oct 2022 03:22:05 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y8h1ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Oct 2022 03:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al9vP7kH6uS+dzLk3QUWfnEhiXXU2Mc3OBimYuFgDehFtxJWlhcCj7HEijPzu+V+vbAheX/NRjzyyOniYt1sD7QEzvfI1FatRUEZaq8jYtY1HNDuVLc1gAAlZNeCu37EA3x2gsX2QKP7KEDU/pwljn1WzdBCfam3svoLymRHUoTo3tDqfaRDWZsAaI/lr2vp4wcaTwmrHJvlxHCjg8lVyxr841wSNHsaOzQYSEClDsoYvzkBRgf+k2eTKniFo2aBTK2/3Le1UOzuLWCUktbwhoytq116fmu6KTim9RkPaykp39isB790EPer8v2DkAYuR1dxFqjoCPIA2IrSbH8paw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84nTQa22sKdI1n+DRAb8jtu74zSMoHc1mKYoZl3lhao=;
 b=ltNpTgLGdncNGO8TNcDQ64ejZI9HPaJQPurKB6RahsHw7AjV3KL8BeR23dgLXUSArLVxCOb1bGl2jN0OWaMaW1ngmlCAcHEAQCOP4nKHFQSvfuDdo9Ee0as087eOL0dqm0m4smvHSbN8oHH/1vZJuGATmndagBIi0vYTKIkRoMcTv4tkooJ/4OaymzhD0TcPL7jCPvsXKYiQ1GiGTN5Do3vm9oxyTz/004FUXgbyG0Z+lwTPplVeYwkz3uIXx3LXh94j0kr2fIrBQok1jI+DWxHD0LzhfpeSr+41wSq9hnnUPIFT/jdkJksmfuoTw3QzK4dhYcGGi3C2McD+kBPkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84nTQa22sKdI1n+DRAb8jtu74zSMoHc1mKYoZl3lhao=;
 b=gc+1Z91T7eH0QXgTiiluqQhZnzkwcU7kivtV1b1lFPZ8wxLjID+mVSWv5XLW2/c83SrJDhQz56bxTGpl32M0c+PFqM0+bSm9fvTrJLtcEGKfHSX9GUtemA0dhVCvehS/tu8QHJxwLcvmMg0VNSTKKG/u6jU7wcVcSj/Y3UUO76o=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BY5PR10MB4324.namprd10.prod.outlook.com (2603:10b6:a03:205::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sun, 23 Oct
 2022 03:22:02 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5746.021; Sun, 23 Oct 2022
 03:22:02 +0000
Message-ID: <64689ca9-62eb-27e1-63df-e2e8c1a59cbb@oracle.com>
Date:   Sat, 22 Oct 2022 22:21:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steffen Maier <maier@linux.ibm.com>, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
References: <20221021235754.1968981-1-haowenchao@huawei.com>
 <daa60cf0-0dde-ea2d-211a-70a9e0efc1b8@oracle.com>
 <2adeb439-646b-ebb1-b266-c3ed4750eac2@huawei.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <2adeb439-646b-ebb1-b266-c3ed4750eac2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:610:e5::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|BY5PR10MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eef439d-f7a9-400f-aa28-08dab4a5c09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wmoGoGBNEkGqGiJncecUSImS/hWZZlhm4L2KElnnc/8GkzD4noro2X2b+3BQ4P80TRMH1m9sDwXhX/dwIRB0ZGD2ujhlG928lhfeEqx1XC2fqbethWTLnd/+hjQIM9nAMDue5rBtEEJSmCOjZHUX4X/mwXoq/mlK1EIK874ef/T4y2RI3e1lKmJaiNrYeHG+yPArgb63GnMNIWHUb1HX6umFPxz7OhDcN8wcL6LwFhd3u7YU1qBUDT4Cz+xblrDlOvDo20KJP/lZTwnGE1Sz53okNBgC4tbbDbn667G12hg5YaOLMtWbYSzuhgwdhokzss/dRatySdj9QQoxO6d+ZymnVElqOccs/mgZRMbxgUtq7EdlX5KZbTIYwQzp4SPYAw+rf+SlOdiBBW2QBYoAmQ8KFEUlSCWYClvBR6nuQGyilVTB4aodh1TgnOGiCGb1mZ7D5LQ5+tgNDaM8RXm5U82d7BWoIeIdD8Wfv5wONs43Cr3F2xahnIiOL45XWSx71nK0SdNgtbO4h8DfYfixcllD5d3t0dNnXSpgFhTQsqwiCIBq8ZqYwLxp3qvgebH9DQQ+naL1sCiYx4iVbX7LRzEyeQIJlz0opIG18UAV6RaZEntRvuTpJGXLRCxtnhNRTZNXIkoEyu03u0VsmtV/OtZOB9+wddtbNko48+1NcCHxUvfCFRS9RhvFQyKoVc5hszeSZU+muQJdJrLfGr4w2UR3XrgWoykafBopmIYWo8M9tiWGJaWGdFtnEV2NsPt9pzljYP+vZ82I5Ibua9UJDb+Pm+01OlfsdON/yetfdLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(366004)(39850400004)(136003)(451199015)(110136005)(5660300002)(66556008)(36756003)(2906002)(4326008)(66946007)(66476007)(8676002)(41300700001)(31696002)(86362001)(316002)(6506007)(6512007)(26005)(53546011)(38100700002)(8936002)(83380400001)(2616005)(186003)(6666004)(6486002)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2NMN0dsaUZReS9EWmtYelZaNm1wQTNuVFA3OTNCT0VaWUJWWGVuTzR0Y1ho?=
 =?utf-8?B?Y0psdS9pdEk5bVRRRWxXcUcrN2x6MzBvSUM2aU9ENkFKQTZkRVVFdXNEdHgx?=
 =?utf-8?B?bjJGVmxvajFmVWlTaDF3bEJGUXRtL0xld3dIUy9rUDNtUW9nSldON2UrMjJ6?=
 =?utf-8?B?VGljRkZrVzJpSCtCallrUVp2ampsSU1WYldva0FDWWYrdGFwaWdVRHpWaFdR?=
 =?utf-8?B?bE0yQkhscytNRFlXcVRqUy9tL3UrWjh1c1NpR0xGd1ZQeStSUDlQb2NabGNn?=
 =?utf-8?B?bkNZSi9Vek5LdmhzcHR1OHNGSFZpbmxPZklDOFpKQ0Y4SjJaQ05oS1NBYTM5?=
 =?utf-8?B?SkVDRkNJSmluS25yT2MzSEZDcGJqM3BUZFJZb2VmQmZUSGRxSk8rOVArMGph?=
 =?utf-8?B?dURvRy9jK01TOWFHSnFVOHNOdWdqZHU3c3BGVU5UWldpZzFzaVVvb1BCRTcw?=
 =?utf-8?B?d1hDcFZ6Sm9pSGVvbDZOVkQyM1RqdVB3a1NwVHlGZVpyUnRBN2FxQXduTERX?=
 =?utf-8?B?UU4yNWRraWFkWXlMMWJNNmRXN1B3eWFsNWk2dUFRRksrZUZoODVaR3FqOVQz?=
 =?utf-8?B?OVpoOFFScGUwYzVTWEZ6QUdNVVRsY21FZ1lPeE5QVVZYcEVNQnU5cjRmM1lQ?=
 =?utf-8?B?VTRpNUtRSTA0WmdHNnBzdHFrbDlPOFAzaVlPSld5Q25zNjNsUW5wRWhIK2Jm?=
 =?utf-8?B?YlBOOU1NaS9hR3JrV2pyQ1hRR3lZb3RyQ1FRV1JqMFloSkg4TmtZU05BYW51?=
 =?utf-8?B?QitwRXgvVzRIUUhpbkZRNEZjbVZnWVpnN0VJdTVmNzF2MFJ3bzVRazF1REVC?=
 =?utf-8?B?bTllWFFzN2QzQWtpN0YrNmxCQ0ZFQWUrU0h2Nnh1bGlHTzZWeDQ3ZlNNR0ZP?=
 =?utf-8?B?T3RhTFpNa2xzdWJFL1JyRzNJcTRPUSszd1hZOW4yZm9SZDNOS3dLb3BhUUUr?=
 =?utf-8?B?MnhqMHRLektBUHJaV3lPU25NNUhTZmJzZWZucnZ0R0dja1F5QXpKWjV6dGdT?=
 =?utf-8?B?Q1QxVXNUUDhaZzJEOU1VMW15d1VaSStlRERlV0RvZ0dGd2taY0RFRWgwQ0ZG?=
 =?utf-8?B?TVoxQmdYQ3NIWGdnQXBaQVZMTzJSd05LZElLKzA0UkVIeHFoUVVvVDBJUlVq?=
 =?utf-8?B?THltQzhKWnJZQ2lQZHpGVEdnRG9HKzJla1d2UUFveHhJMTVCZ2J1L3JrdS9D?=
 =?utf-8?B?cjhhUGEySzFQaDNaandhQWxPbmdqQkVTMHI4Nm1rU3JSV3g1MmRYdjJiM2tS?=
 =?utf-8?B?SnBnTDZIMXBmM2UvRW5LS0hKUUN5MDZ0bXZXN3R4S0JOemQ3WWorRWtKRmQ2?=
 =?utf-8?B?SjF5NXpKWUVVMzJFeGlqMW5nV2Y5OEsxaXluM1VoSHVIRWVTU3J5ckpxeWRs?=
 =?utf-8?B?WnViMHVOUm8vcU1vamwybTd6eWx3RTQrRVpVVy9kZGhiRGFraXhBemhxZDRH?=
 =?utf-8?B?UXpsLzFRMFBZRjlGandNMnVVd0lCU0V6SXE0ZE5OeGRCTTJUREV4dVI2R1RJ?=
 =?utf-8?B?R0NaTVFrbll5Y0F0WTJoTWZCWm9CVCtEcnE5ZUJ2QTV3dVJKcnkrK3AwT3VZ?=
 =?utf-8?B?ZndWYTRZS2t5VkYwTjZwVXo2Z3RKRmxCck1wZmlib0pMWkZpZ3Awd2hqT0xy?=
 =?utf-8?B?SUk3c3B3bjdQbSttT05uVWhhWEQ2TUExaGlBSkV4bXZQK3VGK0ZyUXhYQjg1?=
 =?utf-8?B?WW12ZXlNWTF2cG40MHpWRlBHaHdaM21YanVMQTk2Y3o3RDdZdEFEcTVBMHI4?=
 =?utf-8?B?eEQ1b25XbmhxRGNSVXUyeHFaM1hjQXpRcEdqRWdtVTF1bThPWWdQSnNFMmQ2?=
 =?utf-8?B?L0J0K2JIamFUMDk2amZhWWFvemhBS1d6K01DcWRUUnUrR2lGeVcrWWNEeUNV?=
 =?utf-8?B?SUh3YWZhTlRwMDgyR1J1SzBTVjRtUWJaVnhQM2ovbml2dDdsV3VCYlBXSUZF?=
 =?utf-8?B?MjJOS0NUVXJ4Q3NIUk5NVzY0UzQxbE5laXByR1A4Wkk1NVY3ZnlXVXRBMmN4?=
 =?utf-8?B?enJJS1hHWTJPMTlsbm9ydkZDK0xZNUxVTllEQ1VEcXBocG8xZWJlTk5QYUV2?=
 =?utf-8?B?SCtoajAzNjN5NTFHaVJDQTU2Sm1oN2IrZkN5eTFoa09aMWtjZ3VXYjdtUm9N?=
 =?utf-8?B?UG52SE1hQlduWTBaZVM3eG14RzNlQm5XNEhEcnN0Q0QzeG9QeGM0dHJnTFM2?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eef439d-f7a9-400f-aa28-08dab4a5c09b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2022 03:22:02.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Km62iMzz4lh0HNJWbiLvInom7H03JWUFAmrIzFYWHTu2fwgLd7cSwDT0Gq6HNtFdQjmoAoK4tAhh9HK/Kj1GasuWnBWlmEF34p0HjMQRPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210230020
X-Proofpoint-GUID: bMGQgHgWUrDWN1LgXgv2lbaeJMAVY4DM
X-Proofpoint-ORIG-GUID: bMGQgHgWUrDWN1LgXgv2lbaeJMAVY4DM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/22 4:40 AM, Wenchao Hao wrote:
> 
> On 2022/10/22 1:24, Mike Christie wrote:
>> On 10/21/22 6:57 PM, Wenchao Hao wrote:
>>> +
>>>  int iscsi_session_chkready(struct iscsi_cls_session *session)
>>>  {
>>>  	int err;
>>> @@ -1899,6 +1922,7 @@ static void __iscsi_unblock_session(struct work_struct *work)
>>>  	cancel_delayed_work_sync(&session->recovery_work);
>>>  	spin_lock_irqsave(&session->lock, flags);
>>>  	session->state = ISCSI_SESSION_LOGGED_IN;
>>> +	session->target_state = ISCSI_SESSION_TARGET_BOUND;
>>>  	spin_unlock_irqrestore(&session->lock, flags);
>>>  	/* start IO */
>>
>> Hey,
>>
>> Sorry for the late reply.
>>
> 
> It doesn't matter.
> 
>> For the initial login we have not scanned the session above, so there
>> is no target yet. If iscsid is restarted at this time, then iscsid wants
>> to sync the session and also do the initial scan.
>>
>> To handle that case and also better match the state names with the
>> session's target state we can:
>>
>> 1. Move the above line to iscsi_user_scan_session after we have scanned
>> the target.
>> 2. Add a new state ISCSI_SESSION_TARGET_ALLOCATED to reflect we have
>> allocated the target_id, but not yet scanned.
>> .
> 
> I have some wonder about the target_id like be2iscsi which allocated from 
> iscsi_sess_ida. Should not we get the target_id from iSCSI target?
> If they allocate target_id with an random value, how to handle the
> iscsi_user_scan_session which would check the session's target_id.
> 

For iscsi, that target id is only a number that's used on the initiator side
to track the target. The target has no idea what it is and it's never
sent/used/passed to the target.

For example, the qla4xxx driver uses it to lookup persistent target info it
has stored on it's flash. The other use is that we need a unique name for
the target in sysfs and that target id is used as part of that name.
