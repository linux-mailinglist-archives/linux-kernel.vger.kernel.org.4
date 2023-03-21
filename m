Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FCC6C38A9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCURwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjCURw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:52:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525CC515F1;
        Tue, 21 Mar 2023 10:52:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LGnCr8024652;
        Tue, 21 Mar 2023 17:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tRDd97G8OFDQR5xF9pzXx77tRzQuHi0/D1ve66zesvI=;
 b=MSdiGZhhjmBtBSb9mhv+1hD2H5X4FSyiGsgbYA47jmV6FRrrnTis97BxkdjwTkiK2nTv
 9ilRulVp9w8+A9AV+v3xRjqt4PNc7lxkcjoEDJ0TKjx0AQftkXkJbVnWiBurJ1cAEyI9
 fFkOTi3ciUL/UEBwHQom1Nu2GQbzDMTM7+0sYi64A1fqfINkZrquawPpevssh5Boux8j
 gr4V7hARnqj3wlkN4WhWyabfXHE4JxlanEHCWLNztuMZtc0z3bnNiWMg+OAs0Mj+ANnn
 Ag+MkoxXlbZkR3qzXlGLfTR8qHif1T27RqYW92caeQntQPp5CRV3kgjNAEukaPLloR1k Dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wt71dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 17:52:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LHamB5036920;
        Tue, 21 Mar 2023 17:52:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3peg5q55vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 17:52:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJX5K208ItJHzu5HN4XSpeRP57U3E72sSkBJ8BGysLfl+MDM2SsuPR2Nc+MfyIVmjeHGq87/pO3rkabZGCNUenOW50tIEMv/HTizfqEAFX0/W1zLiTX8D8Y8RufiKvUghHXqg6/CGPRMjABiBNT/DB8RkFJ5pvpr09gkqltg3q9AXFnVdWZve8ci90zBUVek4wOXoHG1++sR2Rc8OuoBT63dQyjLCmzy9pr9aAGxaW+/Fl9gzwtF/cn4z2PoJudo9Vu4k8jX8UstsPHZfjMwClWejmebTVkFALSIGIIqAHBg8VN8n28i94X7oHCO9nqQW67KdsOQQxrmcAOst1SMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRDd97G8OFDQR5xF9pzXx77tRzQuHi0/D1ve66zesvI=;
 b=J5ViLmaolRYFhtDSYbJeOsUVNHxdEza78v6+Mu61DLkg1WyiMny7f8E/vq2UzYX+DrX/kcLgzeS7RM40KwQOlp0TD3A2W9YYqdD2Q0nqOu0TARAT2bTFLVWFV9Zd7XNrAWBQHiMTe3b0FIz3kfCtLF8JhBz2eoxcWxNW0el89Z2LEu+Iij/8AjjN2Swk7PUNT8Gtqdu3mnkkBpuSfFiHsd/DhVSrmtdNDNCvtMJf7KgdlzpXyNb2nGOaju3hRjycSP4BuQAsY+iijtEM18KBlBYoCAYL2LZ7AuZ3S52pJ6MsCwGQXWSKipUiwSYZqJPLMe7oeHjdxhGUtjMRBc5y2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRDd97G8OFDQR5xF9pzXx77tRzQuHi0/D1ve66zesvI=;
 b=WuyZWZDAtxXMXDhNda6v5UhpyExTjGiDN39Yn1TXTbSHVeEE8j0cRjZQ9bi+5yLRC/xTIozP7ntlf2A1OijqPUsyOhm5MHc+YSStdcS85a8mEIWv+FveI6Hdqr46JQqNQC+P8w9iHDgvdaE0YbjkyWowNGYrXIhcYvX8CIVKB4M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5322.namprd10.prod.outlook.com (2603:10b6:610:c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 17:52:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 17:52:15 +0000
Message-ID: <826882c1-a893-d325-7031-0bf4f7aa7f2a@oracle.com>
Date:   Tue, 21 Mar 2023 17:52:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1] scsi: scsi_debug: Remove redundant driver match
 function
To:     Lizhe <sensor1010@163.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230319042732.278691-1-sensor1010@163.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230319042732.278691-1-sensor1010@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5322:EE_
X-MS-Office365-Filtering-Correlation-Id: d2268660-8953-47f8-d540-08db2a35014a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezAyaLN1YSbJn3sX1p4cczZbkxTXkoy0kIWHbusPonODFm5bT9ua6NdJjSvyQiGSmkOUncoqNetXtCk0YeFXuLpepAJrua7wHHRrC2Tj5NU7Map1Y1wPjgFFXpdaNxKmLyxXfBuQ3btKH/K8r5hts05JPPdt5jxq3x2NZKHlhe5ffNOEyRgPHujtwipBLBeoErYGJSXoSu7AAR/lLMJy5GfFskfqyzPA1rMrqqaUVErNVEwjy6oUtaW0zz3GM0dOnSh+OaxRRmSny9raZweNHmuGzLcYfCjNgoIDZuFZF33cORIJDGw3eVb6YiYDe/BsrwD7CKMTxkHS4v9uTL/dQhM1yWRxaM4heVoIEFIsdxENOcT9ywqAA2thfDcfCYjlfcYIebH4n7RVjnvaVrCL/VU6qwP4tNtN8NZw0/95GQb867m5s3ckjaZCEDVuZri8nGCGOsPPzJZrNlQDKlHIS6lnWygcCLAGYsuTk8e7AyQbCXruM2DcVT3TAomwNVuoF/J9WoFBlMHxws56dL2Ne730h60hR0b/4cPHNJceC9/PDIZk6xKmv2yTTA4NC7gifLq6nP1DU40Q27yraSGjP+uFN0CMQ6CwulSyhztZcCuWIg005AF9NeOO6h1xu6nJZ2XXrPuXChfjUWeFpTCH8LY0fAlatiShAoccFNIbdDGa2c3r7m+BqDU2JWUgpiQUV3A1lqCVUmR/EbMHE0I5NRSb11oHAtiB/keENPX9d/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199018)(36916002)(2616005)(6666004)(6506007)(6486002)(4326008)(478600001)(6636002)(186003)(66556008)(66946007)(8676002)(66476007)(316002)(53546011)(26005)(6512007)(4744005)(31686004)(8936002)(41300700001)(5660300002)(2906002)(38100700002)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1Q2bmltL0lDUmlPM1p5dmpjSFQ3RUF1SVUvTDZORlZJWFNRaVg1TDdnc3VD?=
 =?utf-8?B?NjVmL2JLMnFTVjNpMlRuWDhEWUo3Mk1sM29ieUgxMGYyS2VWUXYrOVUxUnkw?=
 =?utf-8?B?RHNSRk9lRXY4WFpTSVJNWXYxOS9BZ2FaZXpYTEdHMjFSWVhFNVhKdFJpMEpC?=
 =?utf-8?B?SktET0FVNDE3UHRGWXhjM0t2UUFBS2VQbHVXb0lBa1RYakFoMm5meElTRGs5?=
 =?utf-8?B?RTlBVXYzTW9wWjJxVzczdm5KbExYRndvaDNod1oxd1VITFlaTkRSM1NtTzFt?=
 =?utf-8?B?UGJMREM0ZVJxMkQ2TjFrcjlJZWQxcDdTNXBaeURVamVraUROKzhlZGMwWUla?=
 =?utf-8?B?Y1B4Ri9SV1M1UUFkanFRMEVTMk5FeVNPM09QMmlaZlVsNzgrYnUwZzY4RitC?=
 =?utf-8?B?bWlrZTFvUjRpMW9SUE1ZQ09ETUtLVlFLaDg3cVdISkJDZllKY1NVdkRZSldC?=
 =?utf-8?B?SUZ3bDZpL3FoMVkxd1hFMmNpOVA5a3lnaHlHTkNQZ1VKNkE4UHk0SGxqUEg4?=
 =?utf-8?B?eGdRS1UvMTdlaG14RFpNLytIbDQxeDBOaThmd09wMzhHaWtDdHZUUHM4SnZU?=
 =?utf-8?B?ajNWQVUxdXA4L2dpSFUzOWpxSHN1SDBtcW5PaDZYRnlJa3ZZeDQrQldRTGxG?=
 =?utf-8?B?TGhwWVNkTHh6alR1SnBxcjRQM2tBUDQ4cXJTV2REcnpUUFRDa3oxTmNLN21a?=
 =?utf-8?B?dEgxUFpUNjN0eWp6L1dBM2lkZkNYTkpteWJIUmZGSWJqc2RHTU9pc2paNXA3?=
 =?utf-8?B?STloclR1UkJSYUVhVnlrelozK2wzV0xJVVlqZ0hDNE1CdXg5Z01SSE1PU1pK?=
 =?utf-8?B?RDg1MmFoY1RNd3VtcFVyUTRSQUtFSnJOWlJxNHViK2lvY2ZDZUZuQllFN0VN?=
 =?utf-8?B?bWhqL1lSU3pPeERtZVNNa25QMFZoRWMwYUtmSFlpSVEyZVdaaFplcVNsOElY?=
 =?utf-8?B?UE9GVHptbnJNbm1QZ2R5SlQvN2lvMkJwejl2c1YzUG1nVUc3aEdjUlZzSmFw?=
 =?utf-8?B?dnNiajh2Mys2RG5DZUpGMTNEQVEwVUNwWGdqL3V0QmwyZUNVdElWcXpuNHZz?=
 =?utf-8?B?UUVEU1pDK3V3TXJ3SGhKMWkySUU1U0U0NmxEaG1ISkd6OVk0WlRjZ2FQUENv?=
 =?utf-8?B?TG1QRTRtU3Y5TzNUYVpRN2M1V1d6SmNqeE5kNGZJYkRZWUd3SjBGUEJ0bGtP?=
 =?utf-8?B?dGd5WDQzYVQ1Q3ZaQkxDUUN6VEMwS3dud1R6T0o2RHJHWFNwbGdHT1NiWkpL?=
 =?utf-8?B?UVQ3bmVqSkoyN3diL3pUQ2VNOXA1ZUZDR2g5UnZLSGFhQ1hjajIrRyttZkFy?=
 =?utf-8?B?a1YyRjA3NzFRelhrbUEzNkpQNzJtOHdQQXF2d2w5VFh3NDdSWlQ1VE5LVXFY?=
 =?utf-8?B?MVg5MDJOZE55Vzd3YkZkSTlNVHFWdTJObUpUTmR1MjlvdXVWcXZKdWhiZVRK?=
 =?utf-8?B?WGNiWVdpbGdjdnF2RnZ6N3RLdXhiNktNQTJaRk1KRkFUdUg5enkzRTdzbkVD?=
 =?utf-8?B?dmNaQlV6a01kUGNOUWwxMWVjd3VJc3c1MVhHeUpSM0x6YUJMWUt0eGlsTVE5?=
 =?utf-8?B?MXdQdWZGaEx0WjVUdUhQRUhhUG9hM3ZjSTkvWWttY2pTNFRhbTh3bDF4TUlR?=
 =?utf-8?B?QUpFbHhFWXNOUjhqbHl1R3VwL2grcGVoSVcrMEsrSHRhR1k2TWVycGZwM3FI?=
 =?utf-8?B?Vmk4SHV2TFBKVHdzeXIxTG41UDg4Mlg5Y2dQNDVvWU9vZDc0RlFTODRncnpz?=
 =?utf-8?B?MC9vM2JoK0VCdHphREc3dk00WkpxQ0F4TmV4ekkvcStLdm1WcEUzWldmdjVI?=
 =?utf-8?B?dlgwdlFRSG5YY25GOGNQWkFFMWhJUVdiYTdXOGcyK1Rsb1hhc1FCbWRHK2Vz?=
 =?utf-8?B?Sk5FeTFMLzRubndGOW05LzlCKzhpbHhNUDBKK2hXSUpuRk0wcy9scU5hWFc1?=
 =?utf-8?B?L25waDhEMDBWUHNtM2VqUlJBWnZWdURyb2JMckFjU3hKK2J6S0hxdTUwTWY4?=
 =?utf-8?B?WkFaeWNQMUllTWFpZlMzRitkTXBwV2F5N2tFaWtYcEZ2NllGOVNqMkpTUFZM?=
 =?utf-8?B?TmlnSVlUS0Z1b1o2RHpjLzR6R090b3l1ZHRuTGJKMUZ6Z0VOWU1BOUVpRDhM?=
 =?utf-8?B?VnVidFVhQTV1dGVyNlJoRmRCS0dhbU40SHg1clZIOE9GOTZLbGIwamNRak9m?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WgczDx8LdsLZYW2fBismvhOzFVENTrk8lQSWgaya+eVXkmsnLW9nxxWdt5Rm3e/09f3x80sjIR8/n/+37Di46DRG0wjhWRAFS4p4N26c8K/ArCcx3eHM3RuTzHezPGJbj2OjFRFyk5zivQfqFa+8S58uo3Pu+iqUFPBaMnbu5iAHmum6uL5nvSQ9r+hNMLoMRQmqZ+YXrwDw0kBUIxDVGJiJqNTEX6D/2s48mAdPaHB24bCQZxdszb7uv55bx6fJVJsWrb8RZf+8cv5viI7lAKaCkNYRlaQKd4eo9mfOgBob/Ihj7Ec4G03nZskHtaBj0OUnrdJ74/twrwbRhKWGmq9L6LHlIv5xrkMBs6UlIG8QokdlMziZDyodhq9CtO6KdWEdvvJet4JYQacTWwTQglbgiNO+FAN+/Xnb7CVcbVHba+gRWfh6tanggzAiAqnBiXNBcZdImH72sQpqFEx6mwJEU9m4sd8gkA8R9SGXRhDIzTqL6bncxTz3gRdCeugFzBILqj8lSV2DTXVw7IvNKVfq4rWwYsTgGXRRTHKwcaA91Eh8mNr6i8jJ0rh7PHjucUooY80883M555iFN0pcELu+mjfVyTaFoUmbgGX9jjosbBpEH9BffP4IhpKCeiYbM/FRW3XMo61h7ZdELPboJbwN4ialjsKktcUt7nLU/sLQPYfCFEUkitUCOBrQu7X0Pp5nO2V6YYfr7WzgI7NCfFfoI1P+4zmNFvhH1ISoWYOtzhYyP9MkXwyWfqX0GvK2eQZHSE0jInKgpgZNp6gdi1cotkMudzNgIRVDxPb9NWyDt+PmJ+F9hIvXxCKQ8kbJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2268660-8953-47f8-d540-08db2a35014a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 17:52:14.9340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRfBW7s/GZfDS3ni/kUeJBfxyT+mtPwksErR/T1OHab7piGVj3ZAkBO6Ljigpk6nFSTT43k5iZA6r2gwOtQHuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210141
X-Proofpoint-GUID: nH4rQkL4KiM1opHLf4NOsDEX-dzMR_-W
X-Proofpoint-ORIG-GUID: nH4rQkL4KiM1opHLf4NOsDEX-dzMR_-W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2023 04:27, Lizhe wrote:
> If there is no driver match function, the driver core assumes that each
> candidate pair (driver, device) matches, see driver_match_device()
> 
> Drop the pseudo_lld bus's match function that always returned 1 and so

I'd have "Drop the pseudo_lld_bus match function .."

> implements the same behaviour as when there is no match function.
> 
> Signed-off-by: Lizhe<sensor1010@163.com>
> ---

Reviewed-by: John Garry <john.g.garry@oracle.com>
