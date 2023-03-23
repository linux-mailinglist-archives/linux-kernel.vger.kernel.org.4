Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FA56C689C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjCWMk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjCWMky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:40:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E002726;
        Thu, 23 Mar 2023 05:40:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5i439011361;
        Thu, 23 Mar 2023 12:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tJHkTkcCPqoMn1K8mwbtT9BLWYRVbg7l9ui7kSLMgCI=;
 b=NoOmwtbTC9fEgCB+TexCcU9Nmaj1n1rcU1BZK+d97aZrTG2fKKPNNNxL3J9vo559KWcl
 GzpOCjULHPL2Mv3UdDPXfv1GMXyhV4YcLzVqZbg2D/N42UVtbDBI6Fa0otja80UqQkuB
 vO5K9kRDMUGfYb+Lyk0uaLynRwAY0vkG7xnHlK1Pcw0kimf/UVYzc12ZTqNzucHH8Ina
 PO8/p3XCwCRY0lgJWb+MIU9IAm1y0dDx6XaFGWKvOQrH9RKU47/ccWRmEAdaAjQRIzCV
 AHFjM1UHWPhZVgBcLg3UFF/Zr4tdN7YQYYGPBpluYpsq/9yIqwaQNRL4vOYaGJWWQNlx 4g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wtbk45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 12:40:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NCY0xN035974;
        Thu, 23 Mar 2023 12:40:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgpvvg7jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 12:40:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qs1b1CXJ79y75zfqyInMBMPPJ+P//qJgLOwyeIuRUaIRWNuzLBSfSeoPC4iuRwtbc/p8r/8RRpEiplMIcfXjTFlxIVUQMq32etOJvGOBtMRcoZeZWYea6W20RXhM/LWGBxVM+FTH8S9hz8nzxVPDzCcCVCq1r7WMRA++wR0UIOtjgBdIrmlc9rDtiB3F9jRJtAN57CqlAWtI4sFm8y+9fRelhZbVn5Jr9pktvcpRzHB7UeqqAAzoC8e5yLWhYyA4k7CZmt9MjaKjqPiJF7287M4gmTdSLc4A6gA17MPAEZMM3bessPbS1fBtVt9QGqxs8QwwsvxYy2b9iEFP/9fQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJHkTkcCPqoMn1K8mwbtT9BLWYRVbg7l9ui7kSLMgCI=;
 b=CZ/n1KYBmeUhka8xpxxSDRlYLeHhuoYDQ9q2bEsn+AlYe7jDqGh/APUt9mz7v0P1vtILQjEBPV1O+d6skWzq2APstGroXuh7nNOUDl1m3QrqWUtJO4ayQmvjeHWFRAs2J4ECufdLQGK79iReswVKAf2ajqmhomGbi2supWbKFg2fkK7HoJTX6qfpGN7ezA8MNzFt3Ewpv6Y/Kk14NWvbMK9LlMWATq6Bn51FyB6GGspsJXp8nGLFdCN/KEEiHrd5BBKHtFa6SAyiLdpS8ckwKq3yeBcoGs44qBr1P84tPpWwRNxp6QIIzO2t6RAIytZobuRWgg7DS7nfQ3ZAJ33XXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJHkTkcCPqoMn1K8mwbtT9BLWYRVbg7l9ui7kSLMgCI=;
 b=tVkwXlrNzInjkf0YZDDH7yVIB6TAqQdlj0FINkeqePBh7bJiS+VpJ+rdKNiyDy/RpgbBfyP7AqmyNVfHxzMXEaPQWxmf58gT/5lJGh0SVxfCsw2Xc2uL/FPtHIjFiKu6FuSlHExy2pBJ4/BvTWyZMGDJ79IbDpniyFB+EI/iJ1Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6315.namprd10.prod.outlook.com (2603:10b6:510:1ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 12:40:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 12:40:33 +0000
Message-ID: <b5f8240e-f46a-b83b-ed16-66c2d8c5571f@oracle.com>
Date:   Thu, 23 Mar 2023 12:40:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/5]scsi:scsi_debug: Add error injection for single device
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linfeilong@huawei.com, louhongxiang@huawei.com
References: <20230323115601.178494-1-haowenchao2@huawei.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230323115601.178494-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0218.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b9b9cb-95a9-4801-b469-08db2b9bcb31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMmdaT6trG8sF9sfMDXPL8NS3BrciacBOx2Y1cIOkXeLH9cctrOhzgXGobkKR9MRzs8IzaQmG2EGcpX+TKZDkVP61qUtgNHsxR9J8bzqA33Pr9mf7LsJ3IDw5dCTi2RR4barEOcMnjeCu07UDLD34i4HndKp4BA8FHG/dkuiNiQXt/xPOxZ4w7LVfQHW4uEpBNS7nb2AkSOf6/OWSPQVyb3XCV5bzS885pF+2AD1/lbRANDpLtfTeMPiHVQkfRKiS8orjDB9ajqdrUW00Q3prr8FRCPDnNO/o4IMVZUc4PPy7AZA07wsRV+Sl64YaOJWU8NyB/C1E66zrMZArQE6Fv9KxQMJg/6gNgEfTmcgViIgZ6b5/FvrHxelvqoMvwoFnYUSFGOYS58dCrUZWyE8nc3mKyxm45ORAeXCFC0zYKIoZy7VyEzmoA8n4zVoeOEleVs4wZxxvvFsH2QNHbOyIqGYNHZQ+eCH4f8gUw4cgwHinZelmqSl3GCAVXwOPwLyOvf6fbc6xOl5vqS63qQtV2mlRdiLCV/QB8ULvUU3koJSXjYfgo8sCNruFBhHS/WLZNhr2YiErs8wUQtgwinxR6P/wVF7bPQveU4x+wSETFx/7tdviVygHUnFm6zkGG/xsQItZsSfA1g3WwvKSNrdvuvd0V9rqpve3PtqVofiKunFbNBYMJO/Tw5GKqWKSw2cq1dJRVdm8jK8kXhzquPgepGC+WvLvlaBI2rNjbLHJvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199018)(31686004)(66899018)(41300700001)(5660300002)(8676002)(4326008)(66476007)(2906002)(86362001)(36756003)(31696002)(38100700002)(36916002)(26005)(6666004)(6486002)(110136005)(478600001)(316002)(8936002)(66556008)(6506007)(83380400001)(66946007)(2616005)(6512007)(53546011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUJvTWpyTFZIT0pKT3RiNE85M2tZSjRCWEdlTlFabC8yQ0NudmtRUmRJU2F6?=
 =?utf-8?B?OStLRi8yS0V4YytIZDJpdUZwT2grRGNHOGhuL3pucDRxeDd4aDQ4RWFEU2pY?=
 =?utf-8?B?amgrQnhnWDRNOFhIdnU0bTFCVDhzK1hXVFhrcXhhMWtHTGZSNEFEMGlsWjFn?=
 =?utf-8?B?eU56Yk1ZZ0syMUJpT1g3Q3g3cjZ1am9TMFpUSmwyOWd1MkFJcXprRFhuaC9p?=
 =?utf-8?B?Rlpmd2ZtblQ4S2ZaRndxUUJXYUplZC9Oc2tQMHoybnl5Q0RtdHVkUTdjZlNL?=
 =?utf-8?B?MWluQlBCRVlydXR6bjhLQm8rWndQdk9UQzc1SnNFWEdEd3J3SnUycVczTys5?=
 =?utf-8?B?djhHc2xFb2lBSTVabHlNOWc1NXJsbHNFdzljam5YUDVaQVBRdFliYnQxYnF5?=
 =?utf-8?B?NEhLQ3JlN2RzNk9rZm5aWDZRMUJhQ0JNNFZ6YzYrV0p4OExXa3dyUWtxRWZt?=
 =?utf-8?B?L25oaGNlYzZOdEFtcWNUM2R6TytIdm50aWFSckdFWnVwcGIzR200eWttUjZK?=
 =?utf-8?B?b2E1YlpzKzB0K3FGeEw5Z0xTdHFHSWhZM0JnUy9iMDdLSEh6SXZOaEJpWUQ3?=
 =?utf-8?B?SGdxZE0xNXhRdmc2ZmUxV2h5VWRrbklJVXdKMjJBblpHRTMrSWJibzA0cGVu?=
 =?utf-8?B?b0dQLzhmaDRCV2ZsanVwblBVeTN1andBYlNjWmFISVZSN2doY2dCLzNUZnF4?=
 =?utf-8?B?cC9EdUtna3BZTnQvb1BtZ3JvbmN3QUFwRUpwTUVBeGloeDEyTnpOWWduNWZ6?=
 =?utf-8?B?Q1hydmI1aHdDSS9nRW5Id0tSVkNZOHNCdDZ6cDhVZFJSWnVBdGt2OTlLbTda?=
 =?utf-8?B?YzlNSzRpQnhrU3BpSmR2YXlSTTFwdzk4VXgxNnNUYzJvNkpEMjN4VzBFN3FW?=
 =?utf-8?B?WE04aVdubWFqMWdUWGlHTi9xR2RPZHFPVFRwQUtoNnlaRnVoUmQyVzd3M2po?=
 =?utf-8?B?cHp3N1NsVFhHL1RYS2d2SERROTRGT1lrN2lNOStaNGpaSmVoUnZRL1F0L29n?=
 =?utf-8?B?NSsyYllHK3J3YUsvUHd1WlV6aXE1RDhOVmphSjFtWnhVT1QrR2VST1VoK3k3?=
 =?utf-8?B?dCtvbEpOS0RualBWVWhtSUI2RU10YWJKTGRGYU1YN1lRSG5lbEVPZlNrT25H?=
 =?utf-8?B?dmhFaUwwOGhRS2VQMWs4SE4ybHNwbHYyU3FrQ3g4RnQ5ekJpZnJLbjQrTFJG?=
 =?utf-8?B?QWhvRldaa0wvZXFYZ0t1Zi9vMEpwcWFYUThJNmN6OHFJSENIUTRtc0Y4a0Zx?=
 =?utf-8?B?MGU4S09KQmZBV1NnTGJPSWVaNGZUQkgyWk9PWmhrKzlXZGtYdUdkY3hOWDdF?=
 =?utf-8?B?WFMzaHB1RjZnbEgrMVZGRmFQaXRKQm9xRkFFeFNhNUxZZnJYaTlQYmJiaml5?=
 =?utf-8?B?TEMxMkJLVy9wMnlsTnA5WjljM1dSOHpQaUEzdy9lVGduYzl2QU0zWDA1NVFY?=
 =?utf-8?B?WW8vVjBmQ0xMZHRoUzFSdGJjamxCMDBXbnN6N01MdmxjUW9ZTFYwMmFyaENn?=
 =?utf-8?B?NStzSzkwK0gvbFE0UERmQUNWSFRUR2s2WUh2U2VvbTFPdnduZ01PMW5iQkdv?=
 =?utf-8?B?SkpMYzdlU2ZaY2pKWGRvdVZmNVp3TDBHTFpHWHZaRUZvQjg3RDdQRU1QWW1U?=
 =?utf-8?B?ZDM2d0RNMjBKR1hiOEpaQU13V3c1UDF1aUJHYTdkUUt2eFVUZHh1cHROV3U4?=
 =?utf-8?B?STh3Wjg3Y1l1ckJSNk9SSXN2NTlRVDJFeHB4U05qdG9ieXF1akVkREtDVVd4?=
 =?utf-8?B?NFcyOThRR05HUjJSRWh4VFdQdkljOThzWE1aeFdBdkg1YjNsTWY1YmFoYVhK?=
 =?utf-8?B?N3RUL0pFWXZMSTFUQU5IZ1dwY0wvVGNoQitSSzRCTno5WTQ5SDlmTWx5STBL?=
 =?utf-8?B?UjVHZ092T1kzMHVaNE1ieUQ0R3pIeUVzLy9ycjl2Yjh2a0xKaThGdStMYmFF?=
 =?utf-8?B?K2xmS1QrNFFaWlFNbDZ4ZlQ1MHppdWV4SDRFSmxnL293ZCttY1h3VnRtRkxz?=
 =?utf-8?B?UDZTcVFKaDY2eEtrYWJud3dEWWhpaTV0WWdsYjN6NVRqNmhvWmNzR0dCUStE?=
 =?utf-8?B?ZGsraU02QU43ZVlqZHQ4cDJURjFqVjZRUnVKMzVIaVE1dnhmZ0dKZlFsWGFE?=
 =?utf-8?B?OGlZeVNJUHY4Y0R5YThRMjNOZDlrOHg3Z1dQeDdBcnFTdll0cjVWaGFpcm8r?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6bSo7e0NGh90EZMffF5M9+05NfM8aictKbG6eOXRmhi05rKZLkaV7eo8/nsT4aNwYDbQ/tlhGdT9z6ws5Cmkcnr68AXoURMinGjqgGLULRUTd+pJUI1Nu4v6S1R9CCuJXbomzqvHbgG2mDMQWCgS1+U5EsAirLOu//1fOvSD6cAH+iCtSedoK1RP20Pu2FsKfoadRtK1PeJaeYHFK8TP/wiN/e70Bps7ty13cSutVFYi/h+U+RkR2XVKKB3A5tQbJh/kCt7ef/5DYluJNp5dykfZ9NPOZyXZAMGpBnsbQrk3n4gjj/m+hYUNI68ajDkNQKLocAH7/XASSLNTBWmMT39tJjx0krdoAhEQRSvoEjjPPCDrOOAB5bkxDfPX2a2dPzczUtGqP3kX8T8F8R9H5/vmRZQA9lM3CpZ/7nzlfh7NnSuFsVkOFwpzD2sWF9+sufJKRWB/dVz9jGwyrFmilAx+PZ5/YFOcp/N9vhrhUmaySkZqkcmh5tV+qYT7E1AVr3rxL3Y+z1fvcys7wpS/WZlL3PwJOUOXE6Htq2zvjrdJX7NmrtZG5/fPpM2zJF2Wm4VTmA7X3CUPoP5ssXMe2osiBexB3kj4OLkayFrpr1xACT/AP3LE6lTeWHIBFBTM3QQKGZO+cJbbUljpSKZEWvvHBOL9AfI9lB3yo02Ca8dfy7N+ad/Z0Wrvxf6byXu/5y4lC97N0Yw8mvqTVfkA74p52cCsLUyNg5aQN6QNlWZmGN/LARqCHGCOqLl4UCqnakrzOvbXP9qsED/dWsXlMux936kfwkhVAXA9C7CgpFlUuNF0WquPNpDK9Occ7AjeJp0b6qcqwSCTs+apAO+gJu5YRHAuoBJCZDBhiBLQ1rs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b9b9cb-95a9-4801-b469-08db2b9bcb31
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 12:40:33.4200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLdxyp20Qmy+sasTdrTghkOy0JyXWYSu9SKaVSu2MnpBK5xLtFZ322oBZWKaa3u2l1C5RY6gGI/yf+LEPqZuWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230095
X-Proofpoint-GUID: zocY_xPhVrLgz84z9dOma6JNJb3oHguu
X-Proofpoint-ORIG-GUID: zocY_xPhVrLgz84z9dOma6JNJb3oHguu
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 11:55, Wenchao Hao wrote:
> The original error injection mechanism was based on scsi_host which
> could not inject fault for a single SCSI device.
> 
> This patchset provides the ability to inject errors for a single
> SCSI device. Now we supports inject timeout errors, queuecommand
> errors, and hostbyte, driverbyte, statusbyte, and sense data for
> specific SCSI Command.

There is already a basic mechanism to generate errors - like timeouts - 
on "nth" command. Can you say why you want this new interface? What 
special scenarios are you trying to test/validate (which could not be 
achieved based on the current mechanism)?

With this series we would have 2x methods to inject errors, which is 
less than ideal, and they seem to possibly conflict as well, e.g. I set 
timeout for nth command via current interface and then use the new 
interface to set timeout for some other cadence. What behavior to expect 
...?

I'm not saying that I am a huge fan of the current inject mechanism, but 
at the very least you need to provide more justification for this series.

> 
> The first patch add an sysfs interface to add and inquiry single
> device's error injection info; the second patch defined how to remove
> an injection which has been added. The following 3 patches use the
> injection info and generate the related error type.
> 
> Wenchao Hao (5):
>    scsi:scsi_debug: Add sysfs interface to manage scsi devices' error
>      injection
>    scsi:scsi_debug: Define grammar to remove added error injection
>    scsi:scsi_debug: timeout command if the error is injected
>    scsi:scsi_debug: Return failed value if the error is injected
>    scsi:scsi_debug: set command's result and sense data if the error is
>      injected
> 
>   drivers/scsi/scsi_debug.c | 296 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 296 insertions(+)
> 

