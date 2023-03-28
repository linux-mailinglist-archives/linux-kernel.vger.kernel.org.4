Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478A16CC777
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjC1QHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjC1QHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:07:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B67D9;
        Tue, 28 Mar 2023 09:07:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SFxWCO006537;
        Tue, 28 Mar 2023 16:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QWSOk9badoBRnggIEOfqMwlim14r4SZdEB5ZtGxpr1M=;
 b=mqsrEBdp4J6gLmLsFQkhrZnQ21x7EKFG+5qxVT4w5sIzNqsAhcGPa6xXPuA8L4dKYxoc
 lw41soegiFCETO6sUIJpCNo4w1tcWSuZS6pHnJ4deVU3NtRYVNsLmO5TIJg0gK8ddoij
 K633KAtGPX44qwrXEVNWfR3sxJRmp91xL1Rb1JQtKnru2c+OadQlq7aYkoQ+sRT4tFCp
 mhYw8l0Lqg/3KVr+PDMPUc7d9zsvabDDOksyAUjAM2LX0S2ZLnDoSCwAYD3YBuG/FTHO
 2lYkB97YI9xRda2Ohq/ggT5KWDhsejR8uQx2J+Voe8TcnU0lSiY7Y+mMPhvSHttTMoeq 0w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pm3byg17s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 16:06:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32SEnVvL027651;
        Tue, 28 Mar 2023 16:06:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd6kxnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 16:06:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMz1L2DIHH9u6/vs0434eRrzEbRjZGmefDN4u9jnsf4lsj7nZVMW40EPUylMcNR40iZ4T1KNUjpWxLemVwyFV2fraH9vsQQx1+scBCW3iRqxDjI2obBuLSkMlYS7EmXc0GMfM7pF0jiBsadzeNfyPNIzJGgJkAr1bgyszH15yKZn8I8insUDdJmGhzq3NWm8mgwKxuGouCYqQu+dSXIlGCG3v2yTJyesHkd9pxKHiiOl8OAWNS7BSQbciKIpsoksfMTEfVqVTHMF71rDZTxGRG302/7sEKszV2SumqEg9RVNMmbUhJuFkeN6VNLy60mDwIUTy7TZ7nDMjnvJXi3aWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWSOk9badoBRnggIEOfqMwlim14r4SZdEB5ZtGxpr1M=;
 b=nGLNUyRzDW5RK2Cj7wCqScxR52cFIhnzx/aeXq3/ASWWSC84ygzigQpYcl6Mwz0DYbpXMenzsBIOg48GtvwOp0voy5U/yoE/qf7DvV0v9lp1OP2acJThaBR5MsCI0fDMoRNYI2pegBh2XuxGpLTSHxOlgyNxOQk7ZBlQNnWLukjhy0LjjHRf83mAHZTe5+yHz9hZ2V9lzsGegZw4puoKAFEcgovV439KbDoZ+IdTeFkNmUNYFAXmaJT7xqCVaxqucPBz6Tzj2qlGbx1njbvTnZDoYm1tWlSIrVbzzMOmXaYKas1x0lsznDAMJrgQa6c/t+Yf2RU+dAXeLELTkCFaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWSOk9badoBRnggIEOfqMwlim14r4SZdEB5ZtGxpr1M=;
 b=q8QZDs7ZNlsBDXGsGor9KLIT8Pmgqt0DQXcGYjIXC0zlr8PJ8SMDGa96+vImVraW0ekuGozN2mr2JcjB8PFAEEviVWmSoH66irOat7Ffp0/WqBL1DiWBNHd0vkw5qUuM4mQ90zPEZHgrJpQbNJsLnkeZlGNYz//pSLyEzL0BV/w=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB4223.namprd10.prod.outlook.com (2603:10b6:208:1dd::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.31; Tue, 28 Mar 2023 16:06:41 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::dcf6:889b:21f3:7425]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::dcf6:889b:21f3:7425%6]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 16:06:41 +0000
Message-ID: <fd703370-29be-2822-eaf7-77da2308ee19@oracle.com>
Date:   Tue, 28 Mar 2023 11:06:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/3] scsi: introduce 'blocked' sysfs api
Content-Language: en-US
To:     Ye Bin <yebin@huaweicloud.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>
References: <20230328143442.2684167-1-yebin@huaweicloud.com>
 <20230328143442.2684167-3-yebin@huaweicloud.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230328143442.2684167-3-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:610:75::9) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|MN2PR10MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: f0cb23fd-987f-47cc-b9fb-08db2fa66b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPoRdt46ixvXKtyV2NR9nkC8zECK+SbWafxyEgEkFLpdYsTQ5e6ohlg40rUaf1esrI/O28U3YAhZFuN5KgXL1BX30GDLS0IpAgGpFYbtY9/ksp8kAhr9ljvuhy+1DO4j7bQNncMynStQq3u6GviBHPjyjs7UHKWqK55XKlAu7KxVDV1vdvWDsDjJ4BEToZB/VtH+0M8CbyXHasuagnF8mxSVzFndIxzxVV1bgih/T6N++fhWFyIMMcoaqkMn94GoePvq1bCnVey5pWFy/D3EXbmR7xMHHvmPmvvtYAihK7ZGcRgG2WUT/j8pqDh+jpnLYNz1meNW0LUiIiSlTbRM4ELd7glv/zNgJP5AFXUIh3omp3lREYgZrdmY2kAsRTP4G/IwTELTf3OlhRQvmvM4MExU0KV12UYKiWfNZ36CEMQoioihuge+zK+cO8RqI9gytJlL5vQIILXqFUp2xVk6W3dtl7IyusrgFO9t3hEraFSu0sHaFIrbRKqEPRJUVvy78aj9XAdu6uxXjl6+Ld6sbGjL6artOO1SNJeY0CggGkzDezb2rY/j73vuezE1f1USL6R0yKnEpt7OKsAZHgex8FgneH5eVp4pfms8yohLD+rtffPANSUXEovq6CCy1lWcR9HNuC4wbzRO4lyEyPRRgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(2616005)(4326008)(66556008)(8676002)(66946007)(66476007)(5660300002)(15650500001)(2906002)(8936002)(31686004)(41300700001)(38100700002)(6506007)(26005)(316002)(31696002)(86362001)(478600001)(186003)(6486002)(53546011)(6512007)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFI3YzkzbERsZGVwZWVmd2IvMXMzZGNZVVFwYVFZNHVSVjNYcGttWG1wVmtm?=
 =?utf-8?B?MGFYa1JYSzBkNHpCQ0VpeEZ6MENTbVA5bXpJL0UzMDJhQWthNis2UTB0SlZH?=
 =?utf-8?B?czc3L2xVQ004Uy9BNjNIY3grS1VZbkFlOUFUSmVnT3I0REcrSTlLZWR0MXNk?=
 =?utf-8?B?dmM0K1QyYmpVU0dFRFFkZi9wOUZRZlFiRmMyazlGVisxRzdHRFZQN1c5anRN?=
 =?utf-8?B?VjhueERhaFVwaEZPc3pJTis1SEtCdW1xL0EzMnF0dlVGVXFvcHVUY2VTOVE4?=
 =?utf-8?B?a1F6MS9kb2VhUDlNc0hCc2kyMVhEVU10MEx5UTNPakZkd1krMEdlRmJOdjNS?=
 =?utf-8?B?TnVGM3dlVWlFajBOZ2phM3dGSFhDbVRrakhBTDRFWTVUcmRDUno2VTZ2RWVB?=
 =?utf-8?B?RldDTFdqS2FpcjdJTTFUT3FGdUZBUXlhWEM2KytMbTVWVlg0WGgwd1hBNk43?=
 =?utf-8?B?cmVxa3lNMjBicDZPV2VqMlhhdVZNM2IxZXI4bkxKRGkwZWNyYXdpOVk4TXYr?=
 =?utf-8?B?MDJtamJuVXlNNlhRMzNLTE5ia21jM3l3VmxvcHo1QlFLd3c4UjlqV2FPNEZu?=
 =?utf-8?B?d3paM3hMZDQ3RmlZbE9IekxWeGJjR1Y1Yk1IaHZNOTcrTFUyTEtYQnpxLzR0?=
 =?utf-8?B?WlNMeVIzR1Z0ZGt6bzBxUHhnTThvVVBMMHY0QnhRRHFrNE5UT0VRZjJ1OUlr?=
 =?utf-8?B?aTdzcElyK3hLRjJSOWpWTHFobXBJWEt4L3ZPWlMrWG92QnJzbkNaU0s3dmhO?=
 =?utf-8?B?SDRMSEp3VEV1QmdEMk0xNW9CTFdRaFFaM3FPOE9aM0ZHSTcwK2ZNRTlDTGlK?=
 =?utf-8?B?QVA5MlpiMG11VkVuU3E5YXZpYjM0U2ltR3p5M0JRRkxLcXZlL0V4M2l5cGpu?=
 =?utf-8?B?ZWhQVEVzcVlaMjliWFM0RndRV3pJLzU0ZDZ2OWFqN3dxQ0hZa092YVpKZGpK?=
 =?utf-8?B?WjZQdEhOM3JYRkNEaVFycWtpMjRZV1o5MGV2TE9XQ043UmQ5V3ZwQXRxdFpU?=
 =?utf-8?B?WkpOak9oMXdqaTZmUzNtYzJQelhHNlpiLzNlMnZjL2FyQnF0N3MzdVppays2?=
 =?utf-8?B?a1I5cGJ4QXpSYk41QXliTWo2ODFpOGVhek96RldJYXp5azlQanpzd3NaWkdv?=
 =?utf-8?B?L3NYeGtRRjBvY1FhRkhTODVFTGlwZ0Evbi9vOVo5dnZNbWFvdlQwamJsZUxR?=
 =?utf-8?B?V21HbDNaYUJRM3JqbWVidFJ3Z0dNK1dwRU5RQ2d4cjZJVFVST0hCenpZU2hj?=
 =?utf-8?B?Z1BXT3lNRnNOc0xGSDdLNHhUNE56V0F4ZmFvaWpvQ2Y1ZkxQTUF4NVhXMzFI?=
 =?utf-8?B?V3hLL1R0RjBoSGUxLzlPSTVldU5nQ0REMlB1VGg5WG1qc2sxRmgzdVVjZWtn?=
 =?utf-8?B?WWl3S09idGlFbzV6ei9VNjljVStCVTRVNkV2QlZkdEdXRTJHWEx4bThTNWVB?=
 =?utf-8?B?UkV2aUpMSDdmTjRWUFpYOEluZUd4RUJYUlpHMXdHY1N3b3RYZVZORFNYbmRN?=
 =?utf-8?B?YWgxeGI0ajJtUjVqWkRpazVaSnBPaXhKbXBQbzRRaDYzV2tFYnJKczZCdWE2?=
 =?utf-8?B?cC9DVHQwTElGK3hYMnptL0JJYTNaTVRSR09jc0dlOURqMEpXOFdLSENYRk1D?=
 =?utf-8?B?U2wzWTVqTExMV3pwdjQyV2NCa1pCZ1dWeWlHY2xjdG53RFNKUzRDbUlOTGE1?=
 =?utf-8?B?ZkxiNDFnNEtFOThaU2wzUnJ5cXlrRWpoRnQ5Y0VJMXZHMk5wck5hUzk5U0Zu?=
 =?utf-8?B?MVU5SE5ZY04wNnRETTNvRFBlNGpnVEZmaWN4Ni9kZk9UOU1BbUJ1M3BkdlBV?=
 =?utf-8?B?QUcrWWJUTHZxVUYwZ2FhNUYrOGU4SkZwOHQ5VDlENUYrTFJxaGJYRUd6a0hx?=
 =?utf-8?B?OU8xYkZ1R1J4TVM3TzJVQmdhaXNjZVNzT3VubXRRVlBxVjRjSDErQW5EZVpN?=
 =?utf-8?B?YnBTU0w0STl1TzRma1YxR0hQQTAxOUViZ2E2TGxhVExpNmxyblZBN0puUFlp?=
 =?utf-8?B?ZmcxbklZbTlneGtkd1JtdWFLaXR0SjR3eHFwcG5UamdReVhFcFdEM2luaWlP?=
 =?utf-8?B?UkhPWkZkbmpFc3VtbDBpQ3VvaWJQRVdubW05NjRyZTRhaVZCSjdLRjJZZGx2?=
 =?utf-8?B?UmpWdUFzQlc4QzJQd0p5VjRqTTNLS1hyZUZGWTd5WHlKK0NaOThPRkRUczd5?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sWcNOjLUb8rWw9olOokv9R3k6OB5FQMXEcPOW8CPmV64b4NtPHLMS9gRBP5Uu9VPKQ0PC5DxnmzYi/wj6GIV7LS+YAvhBt21GCOPyYf403GTBPax8pzVWWArffrVKZ1n7QtyO1tiECgBX88YM3/qflqtDi3uAt308TAG5jb9hlaCdPDcksI6K7ZDBCLDMwF+i8RmN+tAJKt9pLGcc6A5nvpVK78zi8ROQKoHY9F+gHSPn7IXwFynXbEWbstWDSnD5vEKGoF2LZkSoAsWQPkdANS+sQHHfKrqKZbL4rwwzpD3mso/DYAvVM0gXAuik2HRbVn+ustofczbWuGUVwsElQXGyFNNeUz2IxLKPFmn9apy+Es60ZFylFJnruayjQsQo1lnuV8HIBZ/yXLw7l9ZDtdQmF3U6qdRa5bPLepeFzG7kpnOh0c8y9NX/pR7LZNm5c8fB71qaeu8YkmKXww6d5LOdg3JjWpTa+ij4X+RJAPr8kohUGdFvnDPnLJEACgPdmO/0GCndvRiGZ6UBoddVKxIvR5phzmDj/odqpWpaln4lpU4IbTS0CgyK2RwrSA9YFWq2nBDlwnzuMtZI66EkW//hFbmWV2tjN501Ni8VuKgGSZSNH2XJchugVuVCQ/9E0z6u/cZy7WpuACrEioUMr2qudj0rNkwNmAbZTki8kjJ7VHikabVL0+vyRvP7vt3akZzpCK23rLZoJiJVtEg/D576h2paCqOgAZJ2P0+/a4c+jn3Z9ZGjKB2IknCTGfmy0755Om7mvGyUSdmq1xb4Ow+tYG2+e1Rkpirg+eib3b73AkT8OzBZXqR+wwPeNcE2XLt8DdH6bSsI12eg1Eh2I8gZFdW4eGxXSnAgqsU0RORbUMId36dYJ5AtUpH6UEQ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cb23fd-987f-47cc-b9fb-08db2fa66b00
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 16:06:41.1168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjY5b9l1QXClgDCM0HPGhUpIqofuFkfo0UsuuabZSde77J29rGllPYsR81prHy+ZG6L1E1FolW7nigT1wuFW3MDFgIUJphG/q83XInPc8HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280125
X-Proofpoint-GUID: piBhHXJK0ELHObT0fZJBhcoCoUSgMC63
X-Proofpoint-ORIG-GUID: piBhHXJK0ELHObT0fZJBhcoCoUSgMC63
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 9:34 AM, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Introduce 'blocked' sysfs api to control scsi host blocking IO.
> Use this founction for test. Perhaps we can use this to do some fault
> recovery or firmware upgrades, as long as the driver support is good,

If it's for testing only then do people like a debugfs type of interface
is better?

If it's for actual production use like firmware upgrades and they can't
handle IO while they are doing the upgrade, then I think you need to do
more than just set a bit to prevent new IO. You also need to handle cmds
that have passed the scsi_queue_rq ready checks and have not been processed
by the driver's queuecommand. Also there are some issues like cmds can
still timeout and so you will get scsi_host_template->eh* calls still.


>  
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 587cc767bb67..3e916dbac1cb 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -659,6 +659,9 @@ struct Scsi_Host {
>  	/* The transport requires the LUN bits NOT to be stored in CDB[1] */
>  	unsigned no_scsi2_lun_in_cdb:1;
>  
> +	/* True host will blocking IO */
> +	unsigned host_blockio:1;
> +

Maybe rename to host_user_blocked to match the host_self_blocked naming.

I would make the comment similar to host_self_blocked's comment but
instead of the host requesting it userspace did.

>  	/*
>  	 * Optional work queue to be utilized by the transport
>  	 */

