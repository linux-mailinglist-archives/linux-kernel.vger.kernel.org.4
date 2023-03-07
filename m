Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39516AE43E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCGPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCGPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:16:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D744C2B;
        Tue,  7 Mar 2023 07:12:55 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32783tSp007676;
        Tue, 7 Mar 2023 15:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oSB4EE8nzQQAkPaG0iVs4Z9pITn3b7EIhfQIfjJEIdA=;
 b=GVk+qnHmwZvBaQS0SpefdzKcxoQWnxhjNXRdC16RHSGS6m2u0/xmm/3D+rfhW0XuukwX
 Bf6YDFO4ZiTpBg/UKQt6YKgSZ1JQ2nx58fWkQlYrcJx8mD/SwTbOzBSnrSGFLIahZwdz
 MkoDejj5QGPIXGD76uVFMP2PoQzykHdkfhCxqraTURGvbdAMscMkwqzDaVgBnRmRHx97
 AM94PKdiutNEMMfCyzY3D1jkie5UQZuzi2oaLKDsqFbkkidiOCTeXWziChKxA5fDs/ck
 Z9mYgoPq98khUQDCME62eetn1CTYjTWXyTaJHSsw4OlzqUi54LbQGIVW3Du2JFOJYXyy ow== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn921bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 15:12:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327EUSQv025196;
        Tue, 7 Mar 2023 15:12:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4ttk4m0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 15:12:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBxIjgCsjaZFF5M+pLwpDluXD4ZVjYRl3L/onns1yIJUGEkavdqUBZz5cyMJx5fQ8CeX632S+/p9YzS/7Z6T3J2Xbhs1MYNs0+HXXHlpEwWZvD55NSq0kOt/fKuIjPiHVv7ZUozPCR46hVJNsAUq3R7gUsgkiLGi4biKfknaFFfjPLD0/NLv1SMgYM6KxRWKYqBnEL69/yD7E5pYfPgBdvOzER4l/Gapf82S8K0xNx8Z43gZzOe7ANHrDJaQTb1p0WfjQAKM+7xsF0QekQ9mUwuwUMxeaDsPF86J0+lFplpYIM5NEsZRMP9yndFXTYSmhda90/PumE3jnZsIcPkwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSB4EE8nzQQAkPaG0iVs4Z9pITn3b7EIhfQIfjJEIdA=;
 b=i59YGavWxV8ETjpFJZoejMpH0vvhq4zGm7Rm7oIA8DBsdWJ2xubxY4pWMGuII8eeLRQxjEXf7K0VHs+X888/vjgd4qgQqMNyn2/OI6BPtReSgWVW3aM4a6LmqNZnFm7jUugLIYJ7SeTdfK9lG1Ahonvnis6v3j0MwrgV7V2yw3IrIhkkWraieyw0vscMhqIPnVxTRbPIzkpUeSMgvFRqzHz4aLxsKz1TKELZ1BGpVkgHPzYorYtLQ1Hv+PdjK3Msyz8NvI8bqVgQ8ZX3mEmbPZvA6nabV+QZ5lyg6Um2AD2/aa06+8WmWBTc0urj/CAge+fEBF+zY75LBXRwrLd7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSB4EE8nzQQAkPaG0iVs4Z9pITn3b7EIhfQIfjJEIdA=;
 b=cKZt5KxBXv8wsR7624Y32Q0DANWi1VyOdWEurXBcu3hlpBe14mAbZIu0SV0dYXFp4DQR0eX1URxTnZYdkJv/2a4x63Yo1sSWu/scPi1xfok3yaMI3yV6kPVbaacwGtMlZb77oCc/9HQLOkuy5/sfPkPBoZoe4CJVi9653tZaeYQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4812.namprd10.prod.outlook.com (2603:10b6:806:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 15:12:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb%4]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 15:12:44 +0000
Message-ID: <9f72ff19-7e04-9ced-4988-aa88ab98536a@oracle.com>
Date:   Tue, 7 Mar 2023 15:12:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/11] scsi: scsi_debug: Don't hold driver host struct
 pointer in host->hostdata[]
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dgilbert@interlog.com
References: <20230307105555.3745277-1-john.g.garry@oracle.com>
 <20230307105555.3745277-2-john.g.garry@oracle.com>
 <7c66fd8e-78bf-9f3e-0baf-36a8fef27f45@acm.org>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <7c66fd8e-78bf-9f3e-0baf-36a8fef27f45@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4812:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d76ae2-d712-45ac-b2a8-08db1f1e66ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBPDEE///CN6hf5jH1G9Fh4I7R0JvC4JZA0z0SgQ5OXiNDDfYAkV6hsfVaw90PQc80zJqeXhmRECXo0W9FRzAKwsIN8c2dgr3o1YEWsycKk6sLXbzRiPmTkinW8p6DseTsKo1QIESBmhSknaKP+8fGLAE/6+UIOq2FqDxuPZHXsuGegksV8F/FAQykvKl7tvNapaqdfr5xREDku5nsXAUsJo28mmJ9RFu8OGpFBg57oUQ0XJfbTWPlMhuiJ/FYLl9DSSRVnsKhOwLoFIFEz8HUGwN7SIcfyr7TyzoDRRz7cLkgbbQ5a7uEXo5uTANus5Tz06OXT728ww4O35bXB4Fu+2ZdCBCPFvb+p/H3rqRwzjT8kCZUB9v8N6aRDz/Q6KyEFUs85iIsq4J3r3FEqA7NQWgUqQgVX8SDwvABfHjsnVl1yJBeplMnn7cYVj13UXMK7WFF1r02Poe2cmo9aup7yoX1zLQGfnQlucg+grSmF8lTE4r3CAssxD7+g86SuBC7GJqTovqOVlWo7B4ukk84jgPiC3wviT3wDN5s/wOg2OTn6GW3LRHtL0cn6MO80mU9cTDROOQ8SV0MD+YlQm5pTQSwOpAcvxgie/C+rWdUXa66oLVoUobZwmJ2ditUvcwq+NTSaiku7Kbq7D8gsMNo2zjXBD4GblCEn7+ggTn7xFiVdNOxNjBL1ooI/SAWryTPh2lK+wuzOI3jAuPFRbgHK+drAN6JYRo33yM4ft1Vo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(31686004)(6636002)(316002)(36756003)(86362001)(38100700002)(31696002)(6512007)(6506007)(53546011)(186003)(26005)(2616005)(5660300002)(36916002)(8936002)(478600001)(6486002)(4326008)(6666004)(41300700001)(4744005)(2906002)(66556008)(66476007)(66946007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVlxWUE1azIxdHVwY25oZUsrWXRwRUdKeEpnRFVKeWsrSmoyYjZmRVhCUmVE?=
 =?utf-8?B?SVJHcXByQTBoSTh2Z3M0NVlpS2JkdWl4VWZJV3k5ZGVITXlGb0RtVWduNTlX?=
 =?utf-8?B?bVFkQXVkQkY4VTkyL3hScHlybGJRUWRiaDlid0lZTFNxbFhONHRCZFhTeXZk?=
 =?utf-8?B?ckJIQVdmaW5zMHRXeTNPdWk0dnorNE56NkFlLzJqWnN3ZXRnN1E0bkZ2eTV6?=
 =?utf-8?B?bUVjOFo5TzhPTm9yNVByaGlyZnlWNjlacDltbTlQZ0hHa2F4NGJRTUlrdHE3?=
 =?utf-8?B?L1RpUyt0U0hKSFZrQUZoeUtuYUpTL3Y3R2pmUytWL0kzZHhxUFZjYnNnSzVV?=
 =?utf-8?B?aDNGYVZmLzMveXRuUkx6dEFCalFBdnFMY1Fzd05LUkdodStFTTF1eTJ0YUZI?=
 =?utf-8?B?U1h5a1kxQ0ZjcU9kenovRnFLZ0lhdjdlT3dHOGFaY3NqT2lZdGhKSVJjT3Js?=
 =?utf-8?B?U0dGeEJydTV1SVJ3bVRiTlptek5mbU9VMzVjOVlsNlZUYTNOVUo0TXhoa3BS?=
 =?utf-8?B?ajEzZE9MeUtqRlVSaFZYQStvcitGY2JRa0ZTejdzSnplSVlqR05jTERkVlFE?=
 =?utf-8?B?bFhXZndtVHVTYzRqZjhDMEJyUXVtSlJjMmFvcjFySzRuY095WFVmalJjNmZl?=
 =?utf-8?B?Q1hyWWYvN1hKWTN0aTc0QzRpQzM2SnBvUFNkdWliQ25oZU9LQ1A4TC9IQXBB?=
 =?utf-8?B?aEMyRVc5dlp5S2xMRzkyczM3OE40WXFMbUIyYVdNK2xGbERvek5PVC9PRTRH?=
 =?utf-8?B?ZWx6K05yRTRCTTY2WGNQOTRGUUF2Q245Q0kvemNsdTBDMDNVdEdqV09BODNX?=
 =?utf-8?B?dEZQVkFDaldwcU80Y3VpZ2VZeUF3NW5uR0VCWFI0VzRLNVRqRzNFTE4zc0VV?=
 =?utf-8?B?elZsOWF1RSswYmtEcGxaZnRCbW9nVjRYTzg1NFZWZ2VKQnZjc3VmSG1obnZ5?=
 =?utf-8?B?SEZJRERueVZCaTZ0eWsrejB3R3ptZ1JQeFRhZk5ucitJM1lET0lHdUlidUhk?=
 =?utf-8?B?YmJnUE9rK0pRNDdwNjNoSVF3UURWMUZ3anRwQk40K054T3VqVFQ2cTJmTjBL?=
 =?utf-8?B?aHpTRFZRU3Q0U1hOdkZZLzc4SVoycUlIWUVLMHQ0MnhDQzR0em9BZkVUNDNq?=
 =?utf-8?B?MHJTcUZ0VzUwTnVLNVUzQVZJZzNCWFBGSnlLMUpaSWN6Q3cvc0FHSXRGL3BL?=
 =?utf-8?B?dVlwRTZ1eWsrSGtKeFZleHBhaVBCaEZzRWdrSG9iMTNTMkI2M1UvcWJRcHZa?=
 =?utf-8?B?T3ZBWnRwVnlsSmk1VW45MHFGTTRsaDM3eGVpNkNwbUNKT3NPelZ4N3dLdnNL?=
 =?utf-8?B?cE5zR0haUjBROUNzb0pCTGJyYnpCQndiVGVYenZyWWRPTzBrQ2tnaVNWL01P?=
 =?utf-8?B?by9NMFo5RTV5WmhxSG5nMTFncyt2TnFLSzVjRFppSjVwMUp0MFpabXl5TU5r?=
 =?utf-8?B?UHRBU0JXTFJZMlQ3MWErR2NXOUMyK3lTREFDQy9xVlBsV1ZERFJkMFhQaGhh?=
 =?utf-8?B?cFVGUDI2aVZjMGxWek1JU0VRTURvVmRiT0hnd0tPd2dZMXNuNGNhRXlpTzRj?=
 =?utf-8?B?TzBDOW0wOGJHa1pablZIUjNlY2J2WktaT0p6a2xDd2ZObWpsRXlCdGZnVkRT?=
 =?utf-8?B?YnNzL2dQSUZPMHErSW9kSEpIcEdHL2lQdFJ4ZTk0VnZPV1grYUd1cWtBQ3Jw?=
 =?utf-8?B?a3NwMUJLQVZqL3lKUzRYdm5VQkNjVHNnRVlYWEFmRmVMcWF4MUY3cVB3aldZ?=
 =?utf-8?B?MU50bUdwY1h1d2JlcFdNVUkyVy9yUGdJM3ZQVmNmaVlQU3lYUHcvVUt1MWcz?=
 =?utf-8?B?V3hucS9zNjNOMktWNHlXSUt5K2hCdGVzN3VWUHk2V3JtR0lFSWd6SmhtbUZC?=
 =?utf-8?B?VlhFZ243dWdKNjhacDB1cENLNGwrVWZDWllzZlcvUFVTdkl1aWphYlpGQVgr?=
 =?utf-8?B?MXUvRnMwNHJRWmdTc205K0Z3OXUrU3B0bnh4MEUzaG94SWE1SUVLZFJVSVI5?=
 =?utf-8?B?bmR1YXNuMlkyN2thS0JOQlNON0lzZU1tZW5sTy9tNVlROVd2RkZ0WDB3eWl3?=
 =?utf-8?B?cnRaUzRxUHNtWnNad0dDTzM4cHErZWY5VFpjTTU1d09jQjNNNXBHbXZKREJ3?=
 =?utf-8?B?WVBNSFJ0OXgrQkQrYTYrRzdOUmlqN2dqRFphcnJ4bFdhQXR5UlUvVWNGZ3or?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6uczaB/fO8I0nu4VVf/BMmYj0YbOW3N7m7TbUsYLwQA4GUPnwmdSfN6U6bYYX+ySn59wRpJ+JH6RrjK7hkHgF3F+0WiOomKJprJ20L0lYrm0RmwTXosMe4lS4LPhTnTbg1I4yo39f6PbwqD9qxJ4iOeOj0av7ZqLIzVcO9zbyAxOWq+agcNEcT7q/I/Y9o42dQfE4H79Z/D1QeIz7Se3Gug2K1qzFA/gphuljs48VYLtwQthoDbqjY2JscNnUEeBAF5UjUFJk2tJTagHtKPGPtNCFqmjiR9HzDMxB4HDj2OZZNr8n7DLN8FD0AgxZ20tCVxEuazkJvwAI585erpmI8pLHf8EqkBOnUq3T+WSpxEespBKDmNMBSLUzhf1A21JqtDSWeq0cqkkcytZ9ucAXHWQerONo7EiaB+ubRGPG0aAJus4pDgWtCGJBKAKSncAFJR4Ft7mV2wcn9fsbcLyAG4B1sCa6pxfNvxbe59knVu24Iv+z7VH2AMoy4nwmiUikhZhdUIOGAV0NarNmdm4IIdefH4QmdUvcCIkvWIElbYvlp3oD7NKn/Ht8k7iMJay8bbyvPgWvFYA89CV8kIn7Qeogtb95nct6S7rbSEcpTj26i6tsnLYt68yi1No7asjN2mgcB8c2H/jMD6nslTiGi0HDlQ4Wwp2Y2aFYx84x/UIGzwVhcdPuZzJTO1bttEo/XC1mQTa8GhkwW6CBUcktrJHjAmCqa4WSzc82g5Hy1zNz+z3/SlElWpwI6l6UhyctgmhopB0UZFWQlhSkAz8KgpCVZ5DEkaOo8t6S0izO+JfcE1qAJDSvehRy5ruEkwKnh6u++uRWSypTj7IVkhL/DiCBGM0EA3DUiqJDrkZCZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d76ae2-d712-45ac-b2a8-08db1f1e66ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 15:12:44.1902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8ukJq2F0fL2r6BUV6xFtZoI1AqXo5eDRYxErKIbfTjCog5Vvo3J2e2qnfEB8+3CK4BvZQOCeWLGbwOgByJmNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_09,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070136
X-Proofpoint-GUID: 8cOAU-mZgKyrrIgECwUeC3l3NIF3rQah
X-Proofpoint-ORIG-GUID: 8cOAU-mZgKyrrIgECwUeC3l3NIF3rQah
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 14:58, Bart Van Assche wrote:
> On 3/7/23 02:55, John Garry wrote:
>> +#define to_sdebug_host_from_shost(shost)    \
>> +    to_sdebug_host(shost->dma_dev)
> 
> Please make the name of this macro shorter and following naming 
> conventions used elsewhere in the SCSI core. How about the following 
> name: shost_to_sdebug_host()?

ok, fine, I can change that. Maybe then I'll also change 
to_sdebug_host() -> dev_to_sdebug_host() to avoid ambiguity.

Thanks,
John
