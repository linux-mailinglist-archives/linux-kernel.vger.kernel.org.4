Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1FA6880E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjBBPCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjBBPB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:01:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1228D222D4;
        Thu,  2 Feb 2023 07:01:51 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312DwfeS008535;
        Thu, 2 Feb 2023 15:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jrcqaJ3/wL7vrZ5Uig/yJ7dgLqOA0VgINNoHMAhW+xQ=;
 b=V2jnJb2LRPF0xt7Au17qLqRNhlh+JF7bdYPkkqWGvY2+ABMONbWnEMV4g7e1S4SEHrkI
 sYuxxI3fMV3tTqY/WsmLvYueRpDT3PjIjHsmGU4Kej1GHuayV2Y5hKbG5UotkdxPEUAb
 L+tcqBaeINVHGzHRoRX1+BFiMwWZ9wEd1wrqdk+Y/BSaj6K0CzZr5ota4iwFyN+/T8H7
 u1SqZ2Kl+mmV5mdymNR0sw3AEFsaSztWCALDdNuLnnyC1NHNETYGHkN+2utGnbO3I5W5
 Ll93HefHYD0CMbdjS2JcxFQcsdA1E/pUBDVk60GeZ4NdshQl20HmTcki6x7LVh9b56ak TA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq4hk1rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 15:01:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312EIS6v034238;
        Thu, 2 Feb 2023 15:01:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5fqr82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 15:01:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OngNN3aK/cnM8vhnI4B71imA3ZuV+ur2ApOnlHIufkpj8MjE4m83pKwzZkynDjBsEWdclUS+7Jdki6Uo6vLFtCvZwYCuSjYenzPzcvUF9VOxiBr93M4AlBob+mtxE6NxXWLEWW+OZHgR/QynRX+lE30P7a6S/sD0Whg8xrEf8ZKktU61GtpPPJHBwSWqMeoJl6i9hXX2kdttU1QlUU8dxV74l9A9addA8pDFuGzvrISM4LiAbUKpxBG+S9OQco0YB044LpBKjjBca1jL98rdDsIbLEUTOXDsaWu8jDXLCxPLe48bs86XUhxhwKD9UqPI8/O3NQxdE4vPl3l7Uc26EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrcqaJ3/wL7vrZ5Uig/yJ7dgLqOA0VgINNoHMAhW+xQ=;
 b=L31S6xOlqLJTMOKAGkf9TuXz/M1IOzBawuSfQce4+SGf7wT722bXL5WtFbk+jyc+KWXhrKsCbHz/0I/qMyGhJVbQTlS+K+AMxY5FhNaBLlZQIuadOLzEp4g2F/JBQowWQgLcpgb8o738FAbqaqMvQk+6K+1rCPg9yq7/t70VG6U9x5rqu0JG6AsiRx7TZ9VOi403MuoNNlxYGGeJHPOWovENOGJjw6SCdM2wvMuIYvPI7b2wympKHP9xRv/h9Uz9H2QCEkEE4xl4rLDmgtGq7dt05cJtjWMlkGuR1gXTr0QZHue95mW6iW/G5U5OayCMoVh7wscVkcxBMcGUQ6H9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrcqaJ3/wL7vrZ5Uig/yJ7dgLqOA0VgINNoHMAhW+xQ=;
 b=eXakX90YfbP1Y51zJ7MAxyW7M1F0Gr9xUtYuxmtZtRVj8P43uKGd94R+hadV5cZ4lNyYvgHniXzVa5iWO6Q5w91RJ4vO3WJx5MFDk9x14/o21AWeJMsY4reOaAyzd2YEHnKHqDKFN4r/YV6s8GVDVKOtByomFjwc9uYGCQczHbk=
Received: from PH0PR10MB4581.namprd10.prod.outlook.com (2603:10b6:510:42::16)
 by SN7PR10MB6953.namprd10.prod.outlook.com (2603:10b6:806:34c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 15:01:32 +0000
Received: from PH0PR10MB4581.namprd10.prod.outlook.com
 ([fe80::9013:b768:5177:564a]) by PH0PR10MB4581.namprd10.prod.outlook.com
 ([fe80::9013:b768:5177:564a%5]) with mapi id 15.20.6086.007; Thu, 2 Feb 2023
 15:01:32 +0000
Message-ID: <bae235dd-6d8b-908e-1544-df0f1be3f860@oracle.com>
Date:   Thu, 2 Feb 2023 20:31:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [External] : [PATCH v2 2/2] spi: intel: Add support for
 controllers
Content-Language: en-US
To:     Mauro Lima <mauro.lima@eclypsium.com>,
        mika.westerberg@linux.intel.com
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230201205455.550308-1-mauro.lima@eclypsium.com>
 <20230201205455.550308-3-mauro.lima@eclypsium.com>
From:   ALOK TIWARI <alok.a.tiwari@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230201205455.550308-3-mauro.lima@eclypsium.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:404:e2::35) To PH0PR10MB4581.namprd10.prod.outlook.com
 (2603:10b6:510:42::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4581:EE_|SN7PR10MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 37eb1004-0c90-45d7-7312-08db052e5f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+v+EeZXBZp2K+C+hv8k5oqM2WUcbkHNstoC0dyD6nnmanZZF8oFEy9c0HDp0+D2EZJhn4dnld9ANdq7CF0qqpxJkFkT5SAu1/B3FmSnO+ozWqFHhHZY4JDLWBK/SXzgfuGwB3qMaigFOUEqs8JSAZlRTGagL+QEzocmIpWhtvaNKk8szSJ55uVyZioNjvJhJ/eKF0NN7mvohy0D/OcPMR6CxB0ZM+yv5xSZvatTSeE5vr0MbLmHEVB8EONhnICr1UE/T6pqVsTUXwRSjnQ4oO2CvyPkMAKpyeRSWbXxpzhXo4E4Qo0Z1CjruAOwd+K6o5OML8kNHzUHBfK3o6S+P/Kj/TxVMDm3koZDaNHAPxFrHWNhB2HSfG2v/OdXCwOMB+YrYoFoyxzjDBf7+YVGBd2w5AIO871sqnv8MiExAQTRDvvRoLJMkjWSHLvZ1aeU5UKMVE5Ol561tvfHQ7YjXnnThFUFUVCX9o3W847ZghvLHo7f636JcrYSPEeQRecG/9jVI+1nK/GLde8+u3KDlKGtSHYeQNsgN34CAOgLna3jdT+FxSlz1eLJZzk0TWsXyK899qcnhisq9xVCF75pedsUu5fntT43V6vIHCJCh7El8malZhYcg1oZTXlitG7UIdhTzt04sj+F6XuG2jysMfU3ShjRLalFe1/QQQugc4g7yAADNILmP123q9Hmiw4e0qmgPmfv+in3TYDFXFrTQOwQw76TSYMkX6l0FDjzLcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4581.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199018)(31696002)(6506007)(5660300002)(316002)(6486002)(36916002)(38100700002)(186003)(26005)(2616005)(6512007)(8936002)(41300700001)(66946007)(6666004)(36756003)(478600001)(53546011)(8676002)(86362001)(66556008)(66476007)(4326008)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2Y0cjVnQm1oaEJPcXpzZGhrSE15alcxNmhRZU5hamM2UzZQWGp6NThjNkgv?=
 =?utf-8?B?RTFyTUdqcW94OXNhUTJpTlNCeTQ5MzBockZNN0NZeFRLVzBlbU40eDV4NnZw?=
 =?utf-8?B?UERld1Z5MUxwbFN6MVhWWVZnVUgvNm5FYVd2VmNhQVRjTngzZ2Q3SFpGOXBH?=
 =?utf-8?B?VTk3c2lRZ01uL2RlMlBiakY3V2ViNDUzbTNtdzRST29RaS85KzcwRHpoeThy?=
 =?utf-8?B?NC9maGVnWVIwODlvUXdwaDM4R2F5NlBkbDB4YXpFZ2R0MEEwNG9sK0JDeWs3?=
 =?utf-8?B?Y2t3Qm93a241THlZekREa0FGckpUZzVCSTkzSmg1T2ZtYndwV1c0bDNpOXVK?=
 =?utf-8?B?a2ZqOU5yZmZVcEpLTm1FR2wwS1V2c1hUQ0hXSXY4OE9HL2RGSnJMeUFUS0pO?=
 =?utf-8?B?dTdWUWRZM0hpSURGUnpndDFwQVF6T2x0bjhJd1piWHc4SE9LMlRsZkpjQW9R?=
 =?utf-8?B?Vnp2UkZBdzQ3SXl0QmtCaXNNU0hwTGlEWlFFaERpMldTNkZnL0EvYU01MEEr?=
 =?utf-8?B?UkpOaWJQU0NuRDFHSGN4R05YYmhEOGl2WklsNEVnL0FwaXAyVWJwTklRR2V6?=
 =?utf-8?B?WGFycFdaZ3B0aXAxbkhkZk5abEVIKyt3TEdQNzErQWcrUUkwaDBHVGltVEll?=
 =?utf-8?B?a2FNNkN2cDI3eDI2QUFJSTd6OUxvWGhrb0JWa2JPdVVHL2EwMjY1UG1lMlZh?=
 =?utf-8?B?YU5PZlpsdlREdThhaWt4SUwyZEZYTmxhWnhydVNvL0dYVTVmNHBvaVRyVHFh?=
 =?utf-8?B?eVJrc0Zta2JnL3RuSSsrSCtMQ2ViaXZzdWkzOXRUbzVqNWRaK2tVZGlEcXFO?=
 =?utf-8?B?NmcyUjFEODNoVm1qSEZSSmMwdEZORVIzdnMzNmRONHhGcWtXWFJTMm5oYmw5?=
 =?utf-8?B?WTNXZFRBY0RxRjNwVENXWHFaU3Z5VDdyUVZoVXRQUTZicmlGcGlpeUt6V3l1?=
 =?utf-8?B?a1VWNGdvUEV3VEx3RWZoWHZBT2RTbmVuamF2VFNaTEQ0RFhEYUZPV3l0aC9N?=
 =?utf-8?B?RE04NzFaZ212ZTZmVXFMUHNXcG9tcS9vQmZqdm9heW1kbmF2Rm4zREZ3WGVs?=
 =?utf-8?B?ZGlLcXZyaXlRbHlNbFFHd1FDVGgvRkJDM0xLM2RhdGJsbllhWFdBNXdmdUs3?=
 =?utf-8?B?SVk0dkorQ1VnSElQbVlkQ1JGdSsvNjhKb0J3SXRpZW1IR1ZyY0JaSEVUQm5m?=
 =?utf-8?B?dmVJVW8rYlcyNDFiK0hpcjAwTmVvMzRkWWxwSTVMQWcxMmNHbGxwT29YNmJU?=
 =?utf-8?B?VGdvbTcxT01PWTlET0YzMFZBakhPSFZNRXVmV0txRVBqMnJpZUhYSmxVYkMy?=
 =?utf-8?B?RDdDSUV5cGZsdjRsbnJnT2Jld0Z4elB5VWhiUXNlS3dIU0Q3Vkk4RlNWaFFq?=
 =?utf-8?B?RW9JKzNhT3lZUHFORUtIVldaSGc2N0NNVkJ0azhBMG8zS0pJbVV3eTNMSFB6?=
 =?utf-8?B?elpNemh6SzEzWlhkNG1jWDlSZTkwU0huT1ltNU00ZEdYS2JZeHoyMjI0MXVi?=
 =?utf-8?B?RXNCdzA4YnVsMlBFdUVkWDdIcDh6eUo3ZGgzR2Q5VUI4WHNmSUc3QUVteXgr?=
 =?utf-8?B?ZWdwRVN5VVNacFErY09PVW1iOGNNOHZRUEZiWEtFVzlsemE3dENNbm5BdXAv?=
 =?utf-8?B?VW42bnBEaWlQZnhtQjBOY2l3R1lhL051bU5QaUF5YmVFaGZjYUU0eDFTaG9s?=
 =?utf-8?B?QkVhWDQ1OEdzd2VNampRVHRhU2Jyd3hZVW8ycEZiL1p5ZTRXOXZHUTBQQm5W?=
 =?utf-8?B?TWhrTkdqRWI5OTRDUXB1c3BheVZ3RldYQWxXOEdzRjRJNFR3T1U0TCtwc2hN?=
 =?utf-8?B?YXlRaXU5ZHc1NWVMRTVKRXFqdUVjZEQxOU15SG5IUU1mUmYwR1pjZUlhek9Z?=
 =?utf-8?B?dnVqakE2aThLQnJyQ1VVbm1XVXc1MFBuU2pxeHBkVVRJY2tTcnZhbVNvOHZX?=
 =?utf-8?B?NklSc2JvM28rdG5QOTVLQVBhSlVlOTdOM2wwd0dqOExZbk1keVZxaVZ6R1R3?=
 =?utf-8?B?TFU2ZGcxOTBnYzdMQUVLVDU4QW1mNDBKTGJRSjBtNlpBYXBkOFFEK2RTWE40?=
 =?utf-8?B?Skg0S0JOOVRTYWQ1NkhmQUt4UTRraVhQRXVRaUEwSW1hK05NaW5EVmt5MHJQ?=
 =?utf-8?B?aWh4ZXcrRW53L3QrbmV0aGtuZWFoczJDTXRxZ0c3NlQzdnR6eUpLbVUyc0Jk?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kMMlm0kMlAB+bY/e/wFg7WJPLacjDkjh2oCYoa5HlEWe3B3ytSXKlUeOJryfrGUKST+MP9LKNzuBMwz48+eBahzDSje/2+xhJISodbQK2XerOcvuAHJoHnuYRGcj3CX5CKPlHHKLnc5SUKDfI/hml80ld1u6wP4cfCsXOsSjH9cmIh1dZ0WrCP7doBU9PnXY0GTeXhNwjQdZkzgDe0o4LLCVR98oJhc6tupfp95PEMxWVtZbkKlJTf0S5YGLh7KLX4p7uu6K3Iz1XWp4+E+v181MwP5DmMoiDFOuXVdUgKqAzaI+ViOHDx0CHu3fWvczny1MTtgQdDlhvYLa6oxPdOk9hS7BXKDBGKUjpvtWLMFL+0PH/d9H0JXSAkGEwk0M7GP/nnCs/tdLBZtA0D8uIg0TjGTbTC7hK1GDwlw4wSbggBhOD5yzoGAy14LDQiNtwocCgtJggUEXC4tmWDrNQwcOQlu2tRAOv6Bsr3Itu0yBBsqJJVbiTSana1j9xLlVHy5Jh/U6ohBzF+n+N6Lnh2MmZS5K47IXAsI1LvWbZo2lW+zirv9KXc5ganCcFkpylysSIeME3VTOs+XtgNPldFrnvjXVgoKLMVaoyLQxfexZbNSTyVcxfJugyzhMQuuZwWyfJt23K15C1/UiV9RmtpFWBl6BH14pdr663vvTXXDlbkDbjpgFC7uockxJwyPE7dVDWcaMNIkFv5T0bjRoNmkk29BOH0utpir7Lm2XdtXijwc3IKUngYI063NbyV0nfEFzfgC5lJ/VhuH9i0lw7MCTcfF8frvSsc3eDgEWBFUboa1uJiCtTUynNZ75yc8c+P+h9GEHfmFs2YwbULD0allg/FRk6o48EHA9rovJn+hS29Izwaa+ePWFOYtEpOJj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37eb1004-0c90-45d7-7312-08db052e5f20
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4581.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 15:01:32.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98VM7E+EPEq/3QTHxL95lCIO1C2hXcOk2tFr8u0jalnMY07RSvoOpi4VH3lzyispYrSkcJU00HnI0Ssq10mC0B/UJfHWIM4Yj7qYTF7PPf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020135
X-Proofpoint-GUID: D8OcrpOo5E0cPHDvG5horUm9KAJD8p0G
X-Proofpoint-ORIG-GUID: D8OcrpOo5E0cPHDvG5horUm9KAJD8p0G
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

look good.

Acked-by: Alok Tiwari <alok.a.tiwari@oracle.com>

On 2/2/2023 2:24 AM, Mauro Lima wrote:
> Add Device IDs to the module table for the following controllers:
> 	- 9da4  Cannon Lake 300 Series On-Package
> 	- a2a4  200 Series/Z370 Chipset Family SPI Controller
> 	- 9d24  Intel® 200 Series Chipset Family (Including Intel® X299),
> 		Intel® Z370 Intel® H310C,B365,
> 		also Intel® B460 and H410 Chipset Platform Controller Hub
>
> Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
> ---
>   drivers/spi/spi-intel-pci.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
> index 10fa3a7fa4f5..4d69e320d018 100644
> --- a/drivers/spi/spi-intel-pci.c
> +++ b/drivers/spi/spi-intel-pci.c
> @@ -75,9 +75,12 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
>   	{ PCI_VDEVICE(INTEL, 0x7a24), (unsigned long)&cnl_info },
>   	{ PCI_VDEVICE(INTEL, 0x7aa4), (unsigned long)&cnl_info },
>   	{ PCI_VDEVICE(INTEL, 0x7e23), (unsigned long)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0x9d24), (unsigned long)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0x9da4), (unsigned long)&cnl_info },
>   	{ PCI_VDEVICE(INTEL, 0xa0a4), (unsigned long)&cnl_info },
>   	{ PCI_VDEVICE(INTEL, 0xa1a4), (unsigned long)&bxt_info },
>   	{ PCI_VDEVICE(INTEL, 0xa224), (unsigned long)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0xa2a4), (unsigned long)&cnl_info },
>   	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
>   	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
>   	{ },
