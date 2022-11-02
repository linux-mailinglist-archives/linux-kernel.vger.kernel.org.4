Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF7B616070
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiKBKF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBKFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:05:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376C822BF1;
        Wed,  2 Nov 2022 03:05:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A28J3jf004146;
        Wed, 2 Nov 2022 10:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=pAQMXe3kD7GEYKxaolQnH864TTZ2R1KEXidBed1/g1M=;
 b=XmB4n0svnEMsQK8ALQFVMjerXZAswsEqoDoL7WQq8IR3M42NKPf18QJ5/hyoPBi0wiqf
 UVxFfIeAXQKusMpznVTKMMj5byWR/4s5k10Tj/ynd4/TJXvA9JebZUiWWcNELEJ13yR/
 utOvaFolOzUBrcEuEgwzLQC0vTpSb7donqbgXoDUkmvrq+olrrzPYyksZGLFWMwJH6YY
 XdakvaJuBY67T7+R/pxQ0tbUgePj0oCm4yYlq4Uw/BLRUpqPuyuC50NTKLkGHacKf35z
 W7bKiQPI+ullvq+rtRYKYnbn/54BI3vj90GwQGr1e01w+2TMWXMQqjk2WDnJbJ2U98AE mw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts199wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 10:04:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A290AQE013946;
        Wed, 2 Nov 2022 10:04:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm5b89u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 10:04:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWVQIh49Gyht7exJddyoS1lihuMv8sTtJP+P3LfWyRvO2Yzs8YD1OgeNrKmHi1LJsluGVsEhR9Z1JbL058HmiFEC/gFc5TrS8BCQQDykmkL5d4McZcIBAZgGHElLVogjUv3+A/3gGn/0kk2W9OUC792TM67Inr9I+vEfnvqurX4HFoi5eDP+0EbdfwrqOQqjYJ3QmWfM9Ey77cYpszDlLLPr4aBPuc+OGlApxT57nAgfB2mQVKEorvuwLObD2wNN96Ux8er8++kOhcUVhJH2YdGcTt1D233g/5t2kfUDHXKA2i2YW42Fl2LvQZQQ9SRnnG16yP984Ry5f7Ki2LsjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAQMXe3kD7GEYKxaolQnH864TTZ2R1KEXidBed1/g1M=;
 b=nbBCSbklqmhl7CXiUstfUvKfo+ESau2X88ZjPdkgK3g8idqRcXEwv3qgDpfWnjdIXFfj+v3pDUhXrVYr58Otn5P4gBMvvW+rwJDQnxl/KdwTo07X/K8G8nH1AqQ/0w1+t4kZim+4egedTLv+btfHtFgfJX2S/VFNL6d096UXeGJsGe1jkju3fmtKN467i89aMdLQ+M5/AL9xgeqaAfaZitkMZxJ9uCoKuX9YDoZnD2UQYsI1JNs2CmqlG4GjWREjmGub2m01HsSLRBjoPBvUGnXl0Q1J/mPhvIcgC+WAzvEAJYactk0GgJecscqQvh4dQwm3zp9wuJsXxUD7uTpYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAQMXe3kD7GEYKxaolQnH864TTZ2R1KEXidBed1/g1M=;
 b=nQHu0gJkshOgA+d//hsF7b6nS4qEBWZru9bfI3ykihBJI9uuAHGJ61ceaAsv5gThqqVATUf5w+kWEWtgIFfNTzmr3S80lqJQm9zbUA/7bELarWO4IEyRMLU1Gmi30L2p6VexPZBohAlmLjOmQ3ykkesA241Bix6iY3q7g7W7LIc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO6PR10MB5620.namprd10.prod.outlook.com (2603:10b6:303:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 10:04:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b%4]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 10:04:47 +0000
Message-ID: <152bcd77-bcd6-ea75-0572-01e0f16902aa@oracle.com>
Date:   Wed, 2 Nov 2022 10:04:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH RFC v3 21/22] scsi: libsas: Queue internal abort commands
 as requests
Content-Language: en-US
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        hare@suse.de, bvanassche@acm.org, hch@lst.de, ming.lei@redhat.com,
        niklas.cassel@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-22-git-send-email-john.garry@huawei.com>
 <0cbc86ea-09c9-2654-a795-9230e4b00a1e@hisilicon.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0cbc86ea-09c9-2654-a795-9230e4b00a1e@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0067.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO6PR10MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 251ededc-da51-43e7-c064-08dabcb9ac60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRttI+ezXGg21+afNbBRKAsFnAIphMhN6uTHD5tgwjL59R1dZQlqDeLhp0VxJKnKQJ6hxkGLxEttU6qlYo0Esod0Eg95/EvqqpndlQoHWdQohE2/utO8mWVDt5pC7ql9dJmWJbzCeqSWEpqBHK3VKq8lBttZQYucIy7uYa6Kdjau6TURLEG3LqU7e4w95OjKf9uVPeMzBaJ5vzPDsWk1tYFqaFFKEIJTGqw5gUtcByJjINgEERB9394uk7btb/upGYbkXMTKRoL26j3Atr55Gw6umiwoIDXLnIXio++97IvXjA0xsfOYqsQJ6XXVFxL2hUvvpmrQ0jU3AT+JyeeMiamGp6FAMETqsDGwT8FBkPgo3M2VFFT7v90ivcb0D2SG46wHYnDiKcaM5Dk3ShMaOQrO1ZB6zbaKJgY8YF5taHNt15JQ4AJzdWvoOkAdFLvVMPh7NY1g+FPP4532E+N0+pFdINFdXPJYaEuORuzou2NOYrdB3JycqfAvd8h/TNaVkTGqQmkZWfDfuJcIETcnF+2J9M46Cwddzwd036M4l7pFBpgD91CYwwFSKGpgE2r/B7fHy2UYeyP/6FNJfWmArFj8b70YXUPIfpFfXwEsXyjEZVWLxxao5U0KoAjxVom+SQiYoLsvmgNkHE4kSe3w3GpqZoon3KgnoOAdHGq4QH0tQl6Z0GMxGwKtiE9LcGa9vXhBt3fJ4LHGk1m8tYLNudIk6vTUxwNR4zfxUsA4MuxNKpEA9Sen0CipmlDgjqNHno4AxllrTbw1yHMQHsGg6YKQLs1D4UfertPNBvFwzwo0yJiF3NEfcVKl+JQKf3Dr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199015)(921005)(2906002)(31696002)(8676002)(110136005)(86362001)(36756003)(26005)(41300700001)(66556008)(66476007)(6512007)(66946007)(4326008)(186003)(478600001)(8936002)(5660300002)(6486002)(2616005)(7416002)(36916002)(6506007)(53546011)(316002)(6666004)(38100700002)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHlLTE0wZ3JnKzNHVE5TWVBkWFJ2bEN1QVd2cjZCbWh6MHUyZUNFM2tiSTQ5?=
 =?utf-8?B?ZjdaOXZoZUNESVNycDJDNExVQXhEemtwbTZoZEVOcGN2ZHIvbzhGQ0hyaVdZ?=
 =?utf-8?B?MHYxOTFoaE5pNWl3WUVkQm5MWG51S2Z0S296cGVJQVZTbXBkS1NGZ05vOVN1?=
 =?utf-8?B?QjdqQW4vU2RBdisvblcyT3pHclkzSW1YbU9yZVIwanB0RG5yVnZJYkYwVkxs?=
 =?utf-8?B?YTNEdEtyTXRuYk4ybmR0ek8zT2RvLys3UHJVSkVNNnR3cFc2MEdUbTM3Nys4?=
 =?utf-8?B?TnZvTXVnUEdKblM1YVVsakVnOHgyeDR3VG5ISFJTL1VkTWFwaWM1OGRNd2F1?=
 =?utf-8?B?bXZwckVqQ1haK1lsekNybXVKQlFxd2tkZG1yZjRtemNpUEM4Yk9XMnFCemJs?=
 =?utf-8?B?Vlg2MWlkS1lRMXBuR29GM1VGSTQ4SjNzT3ZtbXFTNnFTTWhGclovUUZ1Ylhi?=
 =?utf-8?B?aVh1TjRBRStsMXdVQk5ub0YzYURhMStoZUFXM0ZrdytDbzB6bDBzdlQ3MGR4?=
 =?utf-8?B?bnRRbjFwVkF2Q2RST001SWJNbS9NY0M2eEVBZFNjQ2RncGpZSVNTRXJVclp4?=
 =?utf-8?B?VVByWE40WVF2NXdyTlFSbndWbXRNT0w4emFQSjhpa0JWTnhQYzA0aGtFQU82?=
 =?utf-8?B?ckgxemdLTGVhSFRqQUdlbFYyQnM4ZTJMREdiYnpIeVdiZXVlaS9Td0FCOXBk?=
 =?utf-8?B?QUM1V2p0NDV2MzlheFlkOWtpNk5CcW9yVUVTZ25PTVB2RU04Rko0TzhUSkZn?=
 =?utf-8?B?Z1NoNHRwVWQ4ZUxMS0wrTjhQdTBPdXJuSXlDRWRRMFVoVWUzNmh2L2dPakxK?=
 =?utf-8?B?YWFqQVRGeHRENC9nSUs5WXNFVjFPc3grT0M3UnZQcEFYWTcxczhiQ1VRQkhS?=
 =?utf-8?B?bDVobGplSFE5TEIrYmFYZHArRi9WZDgxR3RFME9kekM1eEhrUk5nSGk3R2Rx?=
 =?utf-8?B?dm1QUXZQQnh3Z25xMENYSnVlR0NoeTRlaitiZFhianUvM3diMmVONnRiemxy?=
 =?utf-8?B?RmRrY0ViZ3lKTDA0YlVVUWxyQkM0aWJMUTMyUEZtbGNyOHg0UmU0T09JSGR6?=
 =?utf-8?B?dmJrcDlFUGl3WWxJTjVFYklvR1QyMWtJdFliNkVFM0J4OTlpTkZvaC9JdjFm?=
 =?utf-8?B?bjg5K1VTbzBJVjV2Z0JkNGR0RGo2YmROekFVTTRMQUR1bEwvMVZIYUxsb3A5?=
 =?utf-8?B?YkI1elVZNkJ0Tjc4V05KbmtSRHVaZ3lIdlp6SDN1cEtQRUZhZlR1RllJWGlh?=
 =?utf-8?B?VmlRaTJkNGZieXZKcWFyMEEwVUU3TTgrVVZKQU9tcUl4d0JlVkdDdHBqeDcz?=
 =?utf-8?B?MHdXeG5sTkxjTEptUGwwNXhnN2JMSlVsd3p1bFk4Z0pjOVhKOURtSmdqaFNF?=
 =?utf-8?B?UWsvaTNFdk1vUkkxdnlaWDBFUitCS2IzcCsxOEd3SDYremVkTk5SY2ZjNGQ1?=
 =?utf-8?B?d2lKS0Vpc2RqckV3OHZJSzVLNkNZVkFoWUx0bnRLY2M3bTRoM1h2NlBBaHBP?=
 =?utf-8?B?bW5ZVW1ibm13cGJ2cEN6UmlVTzNWdUdQNU1ZN1FlNWUrei9DQ3NKQk5Ha2l0?=
 =?utf-8?B?RXBqNVZHR09IeTN0TWZCZmNxRFZZNERvWTk0Y2grVGJleCtLQXZHOUE4MUtE?=
 =?utf-8?B?VVhnMlJudlJjZnc0c01OelYzcDZDbkRDeFZtdjNRbFBzcCtMUnF3Tk4vSDVm?=
 =?utf-8?B?bDc3dDkrWGR4SHg2NkV5UEI2Y21abHh6OUg0ZHV3MVpmTFJFUnRyUFFucFNv?=
 =?utf-8?B?VjZ6aVF2aGljUjI5MHJGV2VGTG5lODlqZGxwcDdNZ2RSLzgrTXBoYzcxQzRG?=
 =?utf-8?B?TUdidWZTemxneDRBeW1TVEZYLzN4UmY0RVhMR0xWdmYyOXVNRGpIaVMrMWto?=
 =?utf-8?B?QzQ0TXJHVFlEcm5Gc1h3RFBSeWx1QjhhZUJ5SEZaME5NNmNSaXpWWGJDeEhL?=
 =?utf-8?B?RUl6YzhtNkxlTTl3UGRoWHpBRmVOazJ0cm0xd1UyVlY1MXpzenBSazUyYlBD?=
 =?utf-8?B?L2E1UnhOenpFRDlFTnNTNHlEeG5zajlWUld2WmVlMER4dk1PRjN1d3N2SzJp?=
 =?utf-8?B?UDgyZnNZbHVid05jZzlKRkJFRm9vdWZSRGwvVEJKSCtoVEFqNnBjdEFHRHQ0?=
 =?utf-8?B?cFJvTEZGaHo3enJwUXJhYTFxWUl3cUIrSzZIcVZFRFVqRzVFR3FBVlRJYk5u?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251ededc-da51-43e7-c064-08dabcb9ac60
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 10:04:47.5214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PJ9nrJvpOr+THZUeqtMTZcWwQhTpHa/ZMU53m4OAGU6PRSCRpvquHEEn4k0TExrl5IiuuX0A5JKJLl53TdZVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020061
X-Proofpoint-GUID: YHYDSal3wmaC2V2BaeheOMuMsg762lzm
X-Proofpoint-ORIG-GUID: YHYDSal3wmaC2V2BaeheOMuMsg762lzm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2022 02:15, chenxiang (M) wrote:
> Hi John,
> 
> For internal abort commands, it allocates and deliver requests through 
> sdev->request_queue.
> 
> Is it possible that we still need to send internal abort commands even 
> if sdev is freed?
> 
> I  notices that in sas_destruct_devices, it calls sas_rphy_delete() to 
> remove target, and then call i->dft->lldd_dev_gone()
> 
> which will call internal abort commands.

Good question. I did not properly check the removal path and, indeed, 
the sdev would be gone when we call lldd_dev_gone -> 
internal_task_abort_dev, so that should fail to execute.

However I do wonder why we really need to call internal_task_abort_dev 
in the lldd_dev_gone callback. At the point lldd_dev_gone is called all 
IO should be complete - indeed, it is now accounted for as requests 
associated with the sdev. If it is really required to be called (HW 
requirement?) then maybe it could be relocated to sdev/starget teardown 
callback.

Thanks,
John

> 
> 
> 
> 在 2022/10/25 18:18, John Garry 写道:
>> Like what we did for SMP commands, send internal abort commands through
>> the block layer.
>>
>> At this point we can delete special handling in sas_task_abort() for SAS
>> "internal" commands, as every slow task now has a request associated.
>>
>> Function sas_task_internal_timedout() is no longer referenced, so delete
>> it.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/scsi/hisi_sas/hisi_sas_main.c | 36 +++++++++----------
>>   drivers/scsi/libsas/sas_expander.c    |  2 +-
>>   drivers/scsi/libsas/sas_init.c        | 12 +++++--
>>   drivers/scsi/libsas/sas_internal.h    |  3 +-
>>   drivers/scsi/libsas/sas_scsi_host.c   | 52 ++++++---------------------
>>   include/scsi/libsas.h                 |  1 -
>>   6 files changed, 38 insertions(+), 68 deletions(-)
>>
>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c 
>> b/drivers/scsi/hisi_sas/hisi_sas_main.c
>> index fe2752d24fe8..65475775c844 100644
>> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
>> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
>> @@ -465,7 +465,7 @@ static int hisi_sas_queue_command(struct sas_task 
>> *task, gfp_t gfp_flags)
>>       struct hisi_sas_port *port;
>>       struct hisi_hba *hisi_hba;
>>       struct hisi_sas_slot *slot;
>> -    struct request *rq = NULL;
>> +    struct request *rq;
>>       struct device *dev;
>>       int rc;
>> @@ -485,6 +485,21 @@ static int hisi_sas_queue_command(struct sas_task 
>> *task, gfp_t gfp_flags)
>>       hisi_hba = dev_to_hisi_hba(device);
>>       dev = hisi_hba->dev;
>> +    rq = sas_task_find_rq(task);
>> +    if (rq) {
>> +        unsigned int dq_index;
>> +        u32 blk_tag;
>> +
>> +        blk_tag = blk_mq_unique_tag(rq);
>> +        dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
>> +        dq = &hisi_hba->dq[dq_index];
>> +    } else {
>> +        struct Scsi_Host *shost = hisi_hba->shost;
>> +        struct blk_mq_queue_map *qmap = 
>> &shost->tag_set.map[HCTX_TYPE_DEFAULT];
>> +        int queue = qmap->mq_map[raw_smp_processor_id()];
>> +
>> +        dq = &hisi_hba->dq[queue];
>> +    }
>>       switch (task->task_proto) {
>>       case SAS_PROTOCOL_SSP:
>> @@ -519,22 +534,6 @@ static int hisi_sas_queue_command(struct sas_task 
>> *task, gfp_t gfp_flags)
>>                   return -ECOMM;
>>           }
>> -
>> -        rq = sas_task_find_rq(task);
>> -        if (rq) {
>> -            unsigned int dq_index;
>> -            u32 blk_tag;
>> -
>> -            blk_tag = blk_mq_unique_tag(rq);
>> -            dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
>> -            dq = &hisi_hba->dq[dq_index];
>> -        } else {
>> -            struct Scsi_Host *shost = hisi_hba->shost;
>> -            struct blk_mq_queue_map *qmap = 
>> &shost->tag_set.map[HCTX_TYPE_DEFAULT];
>> -            int queue = qmap->mq_map[raw_smp_processor_id()];
>> -
>> -            dq = &hisi_hba->dq[queue];
>> -        }
>>           break;
>>       case SAS_PROTOCOL_INTERNAL_ABORT:
>>           if (!hisi_hba->hw->prep_abort)
>> @@ -543,13 +542,10 @@ static int hisi_sas_queue_command(struct 
>> sas_task *task, gfp_t gfp_flags)
>>           if (test_bit(HISI_SAS_HW_FAULT_BIT, &hisi_hba->flags))
>>               return -EIO;
>> -        hisi_hba = dev_to_hisi_hba(device);
>> -
>>           if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, 
>> &hisi_hba->flags)))
>>               return -EINVAL;
>>           port = to_hisi_sas_port(sas_port);
>> -        dq = &hisi_hba->dq[task->abort_task.qid];
>>           break;
>>       default:
>>           dev_err(hisi_hba->dev, "task prep: unknown/unsupported proto 
>> (0x%x)\n",
>> diff --git a/drivers/scsi/libsas/sas_expander.c 
>> b/drivers/scsi/libsas/sas_expander.c
>> index cc41127ea5cc..e852f1565fe7 100644
>> --- a/drivers/scsi/libsas/sas_expander.c
>> +++ b/drivers/scsi/libsas/sas_expander.c
>> @@ -50,7 +50,7 @@ static int smp_execute_task_sg(struct domain_device 
>> *dev,
>>               break;
>>           }
>> -        task = sas_alloc_slow_task_rq(dev, GFP_KERNEL);
>> +        task = sas_alloc_slow_task_rq(dev, GFP_KERNEL, -1U);
>>           if (!task) {
>>               res = -ENOMEM;
>>               break;
>> diff --git a/drivers/scsi/libsas/sas_init.c 
>> b/drivers/scsi/libsas/sas_init.c
>> index 5f9e71a54799..c3f602bd2c4c 100644
>> --- a/drivers/scsi/libsas/sas_init.c
>> +++ b/drivers/scsi/libsas/sas_init.c
>> @@ -56,7 +56,7 @@ struct sas_task *sas_alloc_slow_task(gfp_t flags)
>>       return task;
>>   }
>> -struct sas_task *sas_alloc_slow_task_rq(struct domain_device *device, 
>> gfp_t flags)
>> +struct sas_task *sas_alloc_slow_task_rq(struct domain_device *device, 
>> gfp_t flags, unsigned int qid)
>>   {
>>       struct sas_ha_struct *sas_ha = device->port->ha;
>>       struct Scsi_Host *shost = sas_ha->core.shost;
>> @@ -86,8 +86,14 @@ struct sas_task *sas_alloc_slow_task_rq(struct 
>> domain_device *device, gfp_t flag
>>       task->dev = device;
>>       task->task_done = sas_task_complete_internal;
>> -    rq = scsi_alloc_request(sdev->request_queue, REQ_OP_DRV_IN,
>> -                BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
>> +    if (qid == -1U) {
>> +        rq = scsi_alloc_request(sdev->request_queue, REQ_OP_DRV_IN,
>> +                    BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
>> +    } else {
>> +        rq = scsi_alloc_request_hwq(sdev->request_queue, REQ_OP_DRV_IN,
>> +                    BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT,
>> +                    qid);
>> +    }
>>       if (IS_ERR(rq)) {
>>           sas_free_task(task);
>>           return NULL;
>> diff --git a/drivers/scsi/libsas/sas_internal.h 
>> b/drivers/scsi/libsas/sas_internal.h
>> index 9b58948c57c2..af4a4bf88830 100644
>> --- a/drivers/scsi/libsas/sas_internal.h
>> +++ b/drivers/scsi/libsas/sas_internal.h
>> @@ -54,7 +54,8 @@ void sas_free_event(struct asd_sas_event *event);
>>   struct sas_task *sas_alloc_task(gfp_t flags);
>>   struct sas_task *sas_alloc_slow_task(gfp_t flags);
>> -struct sas_task *sas_alloc_slow_task_rq(struct domain_device *device, 
>> gfp_t flags);
>> +struct sas_task *sas_alloc_slow_task_rq(struct domain_device *device, 
>> gfp_t flags,
>> +                      unsigned int qid);
>>   void sas_free_task(struct sas_task *task);
>>   int  sas_register_ports(struct sas_ha_struct *sas_ha);
>> diff --git a/drivers/scsi/libsas/sas_scsi_host.c 
>> b/drivers/scsi/libsas/sas_scsi_host.c
>> index e6ee8dd56a45..a93e019a7dbf 100644
>> --- a/drivers/scsi/libsas/sas_scsi_host.c
>> +++ b/drivers/scsi/libsas/sas_scsi_host.c
>> @@ -920,23 +920,6 @@ void sas_task_complete_internal(struct sas_task 
>> *task)
>>       scsi_done(scmd);
>>   }
>> -void sas_task_internal_timedout(struct timer_list *t)
>> -{
>> -    struct sas_task_slow *slow = from_timer(slow, t, timer);
>> -    struct sas_task *task = slow->task;
>> -    bool is_completed = true;
>> -    unsigned long flags;
>> -
>> -    spin_lock_irqsave(&task->task_state_lock, flags);
>> -    if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
>> -        task->task_state_flags |= SAS_TASK_STATE_ABORTED;
>> -        is_completed = false;
>> -    }
>> -    spin_unlock_irqrestore(&task->task_state_lock, flags);
>> -
>> -    if (!is_completed)
>> -        complete(&task->slow_task->completion);
>> -}
>>   enum blk_eh_timer_return sas_internal_timeout(struct scsi_cmnd *scmd)
>>   {
>>       struct sas_task *task = TO_SAS_TASK(scmd);
>> @@ -978,28 +961,23 @@ static int sas_execute_internal_abort(struct 
>> domain_device *device,
>>       int res, retry;
>>       for (retry = 0; retry < TASK_RETRY; retry++) {
>> -        task = sas_alloc_slow_task(GFP_KERNEL);
>> +        struct request *rq;
>> +
>> +        task = sas_alloc_slow_task_rq(device, GFP_KERNEL, qid);
>>           if (!task)
>>               return -ENOMEM;
>>           task->dev = device;
>>           task->task_proto = SAS_PROTOCOL_INTERNAL_ABORT;
>> -        task->task_done = sas_task_internal_done;
>> -        task->slow_task->timer.function = sas_task_internal_timedout;
>> -        task->slow_task->timer.expires = jiffies + TASK_TIMEOUT;
>> -        add_timer(&task->slow_task->timer);
>> +        task->task_done = sas_task_complete_internal;
>>           task->abort_task.tag = tag;
>>           task->abort_task.type = type;
>> -        task->abort_task.qid = qid;
>> -        res = i->dft->lldd_execute_task(task, GFP_KERNEL);
>> -        if (res) {
>> -            del_timer_sync(&task->slow_task->timer);
>> -            pr_err("Executing internal abort failed %016llx (%d)\n",
>> -                   SAS_ADDR(device->sas_addr), res);
>> -            break;
>> -        }
>> +        rq = scsi_cmd_to_rq(task->uldd_task);
>> +        rq->timeout = TASK_TIMEOUT;
>> +
>> +        blk_execute_rq_nowait(rq, true);
>>           wait_for_completion(&task->slow_task->completion);
>>           res = TMF_RESP_FUNC_FAILED;
>> @@ -1069,7 +1047,7 @@ int sas_execute_tmf(struct domain_device 
>> *device, void *parameter,
>>       for (retry = 0; retry < TASK_RETRY; retry++) {
>>           struct request *rq;
>> -        task = sas_alloc_slow_task_rq(device, GFP_KERNEL);
>> +        task = sas_alloc_slow_task_rq(device, GFP_KERNEL, -1U);
>>           if (!task)
>>               return -ENOMEM;
>> @@ -1251,17 +1229,7 @@ void sas_task_abort(struct sas_task *task)
>>   {
>>       struct scsi_cmnd *sc = task->uldd_task;
>> -    /* Escape for libsas internal commands */
>> -    if (!sc) {
>> -        struct sas_task_slow *slow = task->slow_task;
>> -
>> -        if (!slow)
>> -            return;
>> -        if (!del_timer(&slow->timer))
>> -            return;
>> -        slow->timer.function(&slow->timer);
>> -        return;
>> -    }
>> +    WARN_ON_ONCE(!sc);
>>       if (dev_is_sata(task->dev) && !task->slow_task)
>>           sas_ata_task_abort(task);
>> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
>> index f02156ccd376..60543d8b01d4 100644
>> --- a/include/scsi/libsas.h
>> +++ b/include/scsi/libsas.h
>> @@ -565,7 +565,6 @@ enum sas_internal_abort {
>>   struct sas_internal_abort_task {
>>       enum sas_internal_abort type;
>> -    unsigned int qid;
>>       u16 tag;
>>   };
> 
> 
> 

