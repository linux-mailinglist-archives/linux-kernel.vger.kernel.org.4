Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EFB6D092F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjC3PMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjC3PMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:12:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F412BB9C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:11:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UEE4Cr007341;
        Thu, 30 Mar 2023 15:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SC2kM9u7zrNDXZQmnNA4gwYyi/3Xetdec7hJ3LH54cU=;
 b=X6F1xe9gacmdBN9qzFnizVRXD2GB30kQ80bN1PRvkneFq7HERZQyqgRsIbGoFNENANXH
 YEpZVoQgIxU4RZrawCjjkFe/6VjMSbM3Ti3Uv6GyUzuh5sTqrmmJGY/LKpX2qlL3rTLp
 hqlXsEFP4y088oTwfHP/bJY7z9k4dW34SpyHAahn/7LEgxmPtZEMaeAwGiS0/5PmdCgK
 0Lj3wiPWibgYkxeqd9rp2zR/VLJKae/ryn2I7CMCyVe5El/QDohnXCLgzYY9f6AG0p9v
 JT8goKU+zptTbTMoA1JN59IClA1Zq45JHJRHfxs5VJ659UysO/qSiHxyoD+3R9CALx+u Ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmpb4u55u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 15:09:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UEQCna010664;
        Thu, 30 Mar 2023 15:09:16 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd9sucq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 15:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESpAJRx7ukeYTq+NfeFebC3AWbBErV9QjZt5XoYYYtyKQ648Sx2bopXVqsZzMPQQEHDeadKF2lT+5K/C2ohYaA0cTxVi07jHyrQCxoMhHfOO+FBHTi5WmdwLQS4Z5gjT76YSKb3bCWrg7ahcgJfAQdWFMA31tsIsY1nPy255+Pli70vcze3CawAyI4XSowat2m/e4ElVw38GNboslYTVNIEWWxd6CpWEA6kputsf7WGhat1nEPVGUalq2j/QGKa7oxPlTvYyydkxkJvo4XIJJg9t/JDLNcdGhokKv5ACsHoinD0LxQb/triHlKZ92PbznpTji3SgD76xJqpTEpD5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC2kM9u7zrNDXZQmnNA4gwYyi/3Xetdec7hJ3LH54cU=;
 b=fdS4G4tD0q3YKwNws/5L5h40ogdCDHEplDazbsQHxG5H71ufahS+3qeqMasehY3aAtwZoca+FC2wV1nqlCvgm6yxLksdp4X34AlLiyBRtgjfnn0ofEJyb1EUYw89ro2bBz295tIo5l+Guje+F3bTvR4ocGHX+SVZf+n81+VZtgw7trsJ0VWv+deduL9tFFGK5Zt6cvGAtpgx0YKUmmkDGXj5HzBsnzU8aIJNP220S2IKhxIDd1gWd8bq4LaAfyLd6RixKY0hRd8rllrvNmzM7gy5xebyt60SOCo/UtdcicRTiE8tKFWPDkMPoAd9J5T91qBB5t0+uDGVMviFoKtzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC2kM9u7zrNDXZQmnNA4gwYyi/3Xetdec7hJ3LH54cU=;
 b=IEqeJ/uN2nwe01CMCWIfi5qr+AZQh+TTz59OYKhvUXqHUt8Imcx89xwwwMGgecpis7A7qJB7h8cSK1eLjxgdSbBYZfai8IoUaQloiwyAhiWQbwt3kMF+kkb42vdkrNEyE33xnSxz6e+HkCA676r94MgGfAlyTn8qJwShkLvK0tA=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SA1PR10MB6319.namprd10.prod.outlook.com (2603:10b6:806:252::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 15:09:14 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 15:09:14 +0000
Message-ID: <376bc9b4-a4f6-dcd8-36c1-966704f49dd0@oracle.com>
Date:   Thu, 30 Mar 2023 11:09:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] sched/numa: Fix divide by zero for
 sysctl_numa_balancing_scan_size.
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        peterz@infradead.org, vincent.guittot@linaro.org
References: <20230329162610.4130188-1-chris.hyser@oracle.com>
 <ZCTrF/YtBLdLLdup@chenyu5-mobl1>
From:   chris hyser <chris.hyser@oracle.com>
In-Reply-To: <ZCTrF/YtBLdLLdup@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:208:120::30) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|SA1PR10MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: df05a841-b5cd-46cc-745e-08db3130b923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VB6+KTrJybr9qZoR3Ow57u4GXEVIbKpjofNLwOPhIcxVniNV2EXnTfyvq5Ervzz7pPvUhIXGoY1aGARe0YlTHRuN+9UltXisleZccCLh13awgIK1lYAcm3KuZUgR2vdx2xyfxF3KVoKM/eXaNcaOJvQcxBQ8fNxRjCTA2gT0uUZx7lqTh8e68QkNeN9QqIKqlImUoaGAmbQRFIIfoQdhu9jaCvl2KCrA+mizea3OMR5eK82nAmy/X63gfL04maZWxtaZ70w0WqHUcFdtAk8cZlTKgMbKgLvAGxG/zbv0ymaYBB5gNm7S/+KjriOjR11R1j8He2BUhcc2P5hYbBgJFJNAEUGQNcB85xRu7xt/6UiUgcegNDu35CMe0ySC0y5GgJwOataC+kkzkNrSCpclK9+1mTiGcKKTRtjZzhXTTnXCq9k3LzoLv3UwsuR1o3Wkzx2UIIFAAQoTZ7++FIJtNNheb3vHKwujzf4gJa5HeRXZN0lag5/qVEhlCVhPV0yVAb2CLd4eJv3Xhb5DIzwQ9HLWsViYRDvdJ1fNWwV+qktsOM8vrHzHfoSvX4zapqWPUvkapxGta48FVGCsti6Vx4DHE7v4zvHnaWpm0HInFujyPpgzY0YMyCpqD3PoZ8s075m3dLwU2a7bltxwALEFMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(6512007)(6506007)(6666004)(316002)(86362001)(5660300002)(8936002)(2616005)(31696002)(66946007)(41300700001)(6916009)(36756003)(66476007)(8676002)(4326008)(66556008)(53546011)(186003)(26005)(38100700002)(83380400001)(478600001)(2906002)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFlQR2pDU2N4VTdMOTd3VTFaOWU0bm56WHpxZGhCWFZPbWFQYXlobmVDUHIx?=
 =?utf-8?B?MmNPYkNYWCt4TzRTWXFZZUtHMVd3Z1Z5UzVDZnNPR3doSkNwRVV6VDE0UzNZ?=
 =?utf-8?B?dndlZlorb21objBhSzdnMjVFV0cyem5TWU1LS1ZMcHVpTnc3NkFEbFpDa3lr?=
 =?utf-8?B?RFFibVZ1Nm90aEdhb0RIZE5JeDhEQS9obEtMSWV1bnBhRVQrK0R5NElSUmNp?=
 =?utf-8?B?Y1lJTXFRZFcvTWsyem9IYUJrS0oxN3kxbmJ3alp3M2xYNVZsaFcxSVo2a3F0?=
 =?utf-8?B?ZlgySjNHWnF2ZC83YzZlV0l1REx5MHNiVTVWT0lHbWQ3Y2plbE5rL3FhcFBo?=
 =?utf-8?B?RUFNOGxLU0dST1I2RDAzZUVUbmtIUisySVpzQ2R0VitUWlljeVpINm9NbkVB?=
 =?utf-8?B?UGlNdmlnTVp5R2Fjc0I0SkszSVZHUmRxeW5yYWcrUkMzYitxS0xFZ1p1UHhl?=
 =?utf-8?B?Z3FrYjh3OGZZK1JoR1dzYTdueGp1Q2NTN1I1eTJMUm5QeitlZVJEbzQ1YVNJ?=
 =?utf-8?B?VkVycy9vZW41MjF6WEkxQUpQWG1qdWJuU1B5NGFtd1FzdFJQdnVpdXNBbERu?=
 =?utf-8?B?SjJ0WW56bHFzQWtPSEQwaGxJVTVwalZtR3I4RGtGcGFaaWtyeFRjU3VFWTUv?=
 =?utf-8?B?bWQwY3VIV0Q0SzBsN3pSbTlicUtWMDZOb2ZIaFhTeHpjanQ1SjRUeWptZEdr?=
 =?utf-8?B?QWpNbHdYQkJZS3VqRnRCMDUvZUFCZFVSMDIvb21aNnNIRURrRm9kbW91OGZh?=
 =?utf-8?B?RlgvQ0tCcWV0MGJhKzZHVUJ0K0l4bFQycVEwOExpaFErRzdKYVEvK2EvTEJX?=
 =?utf-8?B?MjhPaWVMVFZLSjJDQVMyb3U2aDh6TUJrN3hyMEJTRU9keTRnczVkSmc0S1NY?=
 =?utf-8?B?L0NLamVXUTk0ejFQdUhKTXhxWXZqbEFOY1RrRjNSYTY3NGFnYU5OdW43MHI5?=
 =?utf-8?B?YTRCQnJkQW9EWXBXbmlRR1VTVXBzeU9xNmhTSWFhZmM4MU9RaEF3S2w0ekw5?=
 =?utf-8?B?bkh0WDFMTVZPRzh6Zi9BU2hia2hZd3RUZzZOeU52eS85QUg1MU03ZDN1QTBE?=
 =?utf-8?B?MTVxQlJVRUROS29lZXlMTUxHMWsvOEhEcjhIQmsvUzByYmw0dUc4ZnAwalVQ?=
 =?utf-8?B?bU5BTHhGWkxDRW5GYlF0U3pEMXJpQ1Z1ckpDeUVhZHU1R2c2cG9oZ25lbXFQ?=
 =?utf-8?B?dGV3RVBqKzZQejNPQXNhM2daUGM5QnoyaTdmWkZjVlJJVkVkdVhaZ3h5NER4?=
 =?utf-8?B?VGJZV1lBK3Zxa1ZKb00xSXVtak9tVDBpMldmRElnNHY4dkUwS1dQZ1VCVjVs?=
 =?utf-8?B?S3FYckxNOFhqL0tVaGFYWDlzMzZJWWRsWml3SWhhMWUwQ0ZldEFxK0dhL29z?=
 =?utf-8?B?VkZLYW5hSGhNSk5LWGt4ZUdPcDZuci9iUmZ4Z3dzWmc4eXBzTGVVS2JmTWs3?=
 =?utf-8?B?bzlSYUgrc2kraHpBZncvbUoyZ2JsZXI5V0VxdEpaZ0hmWk4vYWZkTW1rTHhG?=
 =?utf-8?B?R3lXNGdjU3VXYWlEbThTTmwyazhkWUNKc2QwMWluRUxxbkRPQ0Q5UmNmWEJ1?=
 =?utf-8?B?N2x5Mkt6YTJJdlBRL05jZ3BOUnNTL3IxQUNDMEZiWXhubnlCbFJsMUV4cURs?=
 =?utf-8?B?cy9vSEFhR1B2c3pERjlnMGZnM1ZDUysrM21xaGJTZGt4K2h5TmFBSmp4NENC?=
 =?utf-8?B?elRWYUo3Y1hjQTVISjlMQzFhaGIrdmxPSUhmTmdvemZuUDFaQkU0QzV3aWJw?=
 =?utf-8?B?dnNMMjl4R2tOdGNCand2RHFndEpZMUFqRGlhalFpU1FFWmR2TlpzOXh1V1p6?=
 =?utf-8?B?YkswRmhLZmd4eEV1QkVIKzVCMlZ0d1RrYitHR2FmajhvTVl5dkVQaDRnVWMv?=
 =?utf-8?B?MzFzT0h1UlBVOE1EY3NMdDJLdExyQjg2TlI2MWtVZVhUdkV4dzZtSitnSDMr?=
 =?utf-8?B?M2FhMDNKWmo4b3N4SVpPdzN4VjFDaUppTFVJZHVTejJrblhXS0IweFJTQWR5?=
 =?utf-8?B?UUIyRlJDY29RL0ZqclpHdEw2aDVmc0JaYmRDL2RwcndVelp5bkN6d2Nybmxa?=
 =?utf-8?B?UXJaeU5VSnlVVVBsZUd2TkVXVUYvR3dlMXl1elE5VlNsK0ZlMEhkUmRYWGdZ?=
 =?utf-8?B?Z3RqNW83MGFLMDV5SjB1SDlIVVkwU3BBaFgrK01EWXE1dmY3T2dWcEV1TUUv?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HOaeNs8ZLFDtLY/6uGmxQOhUv6HbsodyiGIzfoknQnekf8sn0r9vbv0qZNzMjDnllKzbXQ+n9iw6ISWOqW2s2QdKgW8yCjUT2y4B/H4nhjnoxNdXfBy7nMCBr1/lVO6xYz85D+sWHvoKTxj+GWcZzrHtLQ3xYZ/Epm2kQ8kz5NwgVHHjVFL9rryzriwK4ehFoBvGNVA5BBB1AWB7L+bh9gx68a3urq2EB00vrK0GhT4krVxdhRMW7U+FRXgpGwGGtWGm0dOiZN2Z6jPFeYZoRKRlkdAXpx+biABjffLFkwU+Z1rYQLQ2S/zvANzh01rY/C/InS231JZYiqMwXnis16z3ZPra55lP2z3uNYC1IzrNsOQMRhuqn+S42iV4E7Opu4R5wzbSucXZxVTn1qYwbXSV7joa5Sr6CYe5opQobpI8qpijRr1jo5AfkLDJmpeabvTPH+DyJXdXhO35tzU/Nv0wdkh42vnaPsZ3NeYDMXRQGphDo1LYpfEntCrlHqkSEktewK51QDDVhWZT1dOFuJ4eUMVKfqNGJyHY2h1fYoe9eAEjEMm+RyxiNW91zfPTw/PkWONU/Helb0o96g/hysir85ND0FVPl+dmTwAhVZVs8TGSRVsDdt9ak8IjUtvFIz4ZojEv6LY/92agiS+dlVfSV3eqZpVBKI3pbOATSPoRCZ5FYUImSJQna/3lukcr21s9CIzWClgvN+USUY1g0WuqJceGyD7CBLyDqndqtiVObScQEX9xMTP7VC11m8/b3cq5/ZGEjDKEZboYkneNYrWzbxPNtsTgyHp2keuI4MED6BlfDV3I0wV34t+kXHUvGTTtXcY9VV+sxBkrQ94F1k5B5++pj7Tde/jl5lLHF3hplZuQLo9Bn5Cu6vRy0HNc
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df05a841-b5cd-46cc-745e-08db3130b923
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:09:13.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeWxuiXp66bGKtaocdE96bfkeKzw6PZraBSJM6yCIw+pUHc+uw7qr5k5H1VUufvdj3TrFOEXZPslEl8ibHc08Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_09,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303300119
X-Proofpoint-GUID: 8pk7ReDb8SbOWb4LLtxjFKUyfeRpd2xD
X-Proofpoint-ORIG-GUID: 8pk7ReDb8SbOWb4LLtxjFKUyfeRpd2xD
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 21:51, Chen Yu wrote:
> On 2023-03-29 at 12:26:10 -0400, Chris Hyser wrote:
>> From: chris hyser <chris.hyser@oracle.com>
>>
>> Commit 6419265899d9 ("sched/fair: Fix division by zero
>> sysctl_numa_balancing_scan_size") prevented a divide by zero by using
>> sysctl mechanisms to return EINVAL for a sysctl_numa_balancing_scan_size
>> value of zero. When moved from a sysctl to a debugfs file, this checking
>> was lost.
>>
>> This patch puts zero checking back in place.
>>
>> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
>> ---
>>   kernel/sched/debug.c | 50 +++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 49 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index 1637b65ba07a..dfd0fe6123ec 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -278,6 +278,54 @@ static const struct file_operations sched_dynamic_fops = {
>>   
>>   #endif /* CONFIG_PREEMPT_DYNAMIC */
>>   
>> +#ifdef CONFIG_NUMA_BALANCING
>> +
>> +static ssize_t sched_numa_scan_write(struct file *filp, const char __user *ubuf,
>> +				     size_t cnt, loff_t *ppos)
>> +{
>> +	char buf[16];
>> +	unsigned int scan_size;
>> +
>> +	if (cnt > 15)
>> +		cnt = 15;
>> +
>> +	if (copy_from_user(&buf, ubuf, cnt))
>> +		return -EFAULT;
>> +	buf[cnt] = '\0';
>> +
>> +	if (kstrtouint(buf, 10, &scan_size))
>> +		return -EINVAL;
> error code of kstrtouint() includes -ERANGE other than -EINVAL, how
> about return the error code directly?

Sure. I just sent out a v2.

-chrish

> thanks,
> Chenyu

