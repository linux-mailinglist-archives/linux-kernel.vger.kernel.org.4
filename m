Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E86658DE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbjAKKVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjAKKUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:20:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A54AE4C;
        Wed, 11 Jan 2023 02:20:41 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BAJ7rG008035;
        Wed, 11 Jan 2023 10:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=sC2cAwdqGw9OKA83Fg+t6RM+Zi0J9CyRSc5J9Ic+UEE=;
 b=AzKSctOzj09OmCyrf3sC+myqd1jevH81hltHpDS4jmvaXo6bzSX2MZbgztS2LSCcFgHo
 ZWeMT5itXoaNHXK3Lqy9+kF+04t//ieAmvakC/9jDqv+Z56V1smvfzEXD+XspZxsXEhP
 H3UR34o+AASyiRJ0zscEpaPA4t+jxBKjN7HNiDdiiiAOCqGIE5ymqagqeopi4fpfqXrg
 SqnWFEaUl+6hPDefU3FEMtAJq/dLhE3bUkqCrdwZjGNzxRMGgEJNhE8+2gXWU2Fls1Z0
 /CfcuN5WmyZY4PnvkUrPqzyh1U2xDfTMRRrdccJVGFE23zMAE1PjIZ2p3zISP45vN6Dn nA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1t0tg475-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 10:20:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30B8vwrK040371;
        Wed, 11 Jan 2023 10:16:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4dgtym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 10:16:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guSmH9ZOdzJMiHGi5X4zqri57vVL5mClnwuIVIOrVSpPYLgwqr6G7uIk1q2XtbKHNVzrxeJAtorUbySfJ3HQnPjlwNZFKuoBGtDWch8reNPtYGI4PgcyPWgNloTEiHvFPqYln3X0UmbMevkJkbv3HzhNGfHfTUYwww0hm907VJKAHOp7CoF2GN2p80VHy5E0BJxL2xZiKm5NCK/j+xgecSc03HJTUkMLn/1qo21zZpyYSHBXQgVwDcgWZIqMehnZc5KRoEmggKU3y5RJCZQPUmrvlgc6O0mYOBRQAmEyb8FmOCJB25osqWvWYHAZ/oE67Dwx7h14yXBxOUEyF8Hkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC2cAwdqGw9OKA83Fg+t6RM+Zi0J9CyRSc5J9Ic+UEE=;
 b=A8EPpxQetKOzoWUHk29bJ/716du5LV5Bb5ZzshL/z5JtIv/tksWjill6D74MbHMwLodb01tSlDSyQO1NRJ++hIN1/vI5yKl6J3smsrz2GK+2tkH39e4+79V05QpMooO/9iitxk0W+lSXyhzcXPshCWfkN60UKI3SA8lc4gXUNNhfICUhWdNa3XQxF2UOswGIpetaWWGAdkz3jAkhZTA6bHZhpEeVWW2Z7VzBiqdfhq0T680lp6WOPMVKP+pGmpSdcXdE1/rKpYEbVi5aIp4U604TiDmuXnZoO/Np18Mxk4/Rdad8k/B7wxwZoSSNE2BK5iE4cdz/ICf25uNenurIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC2cAwdqGw9OKA83Fg+t6RM+Zi0J9CyRSc5J9Ic+UEE=;
 b=KMuaCfgjY4tGe03yLDq9mPgSPZfC8shPpIgoP/SwUa/wjPE/z4DY0NYZ9okIkT1mrpBPL7XtNCaETF3PGfN9Vhb9hB2fHU7SCAPbM/RhD1D9hO58kBnI6A1Th2uEvYnxyZsQkUtY+/6faRYTB+5FvF5arOkq7KbJvbZ6mq/wHCE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7321.namprd10.prod.outlook.com (2603:10b6:8:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 11 Jan
 2023 10:16:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%8]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 10:16:07 +0000
Message-ID: <60539053-419a-d8e7-79c3-d23c005505b4@oracle.com>
Date:   Wed, 11 Jan 2023 10:16:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V4 3/6] genirq/affinity: Don't pass irq_affinity_desc
 array to irq_build_affinity_masks
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20221227022905.352674-1-ming.lei@redhat.com>
 <20221227022905.352674-4-ming.lei@redhat.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20221227022905.352674-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0141.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 89135d19-1944-4c9e-b20c-08daf3bcda71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17phN1oOYj9+VefNBK7gob0pr2CHkragU/A3SCHZ4++OsVKFCw4B0YJN8lCNq+fdtM46vXHpKj8Pf6Li9/d+ypdCBal4N5q1R3WVezrn/CAp1AJbEk70v/Th0YTxlBKTXVNHki5CQu74963G5qeZdJ3J+g2FpoGvl5JDvP6FVI5cKX1Jv5Fu8f3YaTxeNjozOpvV2imj/iKtoGpLFM0VOBUZ4E+QzL8wkoYpScsnVwxzmGbvyPtENR6vNkjq6kmuAgyxlKUBY+xp0AUt+9ucrP5nutdKUclj2cZanEozQXH0gJTlWK/FPhDriOV5BWhA3c25j0s3IOPaMIigtdgz7/QdrIF2bABPa003dzcaH9ssYnT4tf7J4d1CaLPKiigmIofQW/aZTbNsy0ulAUxwJ2Pjijis0XLXKrPgociFH14wckCZYfufNFlwrBew4hy4b5Y/WNgMgg/oMRShx4dhz4CJT6v4Pu3TGBajs/45ER617bUa3wHDh8s2huEQD/6IzHdMQ6o+UW4KN6FxvXtV1e2ejJSQdxurI+2JbPidZ9qxSULcDVX956YWlcXDXB+ifVorqk164j1pDXlAswP/y/z3uCqEdosxrxfPjpfC2ufX+hhtjnHroifB5UojSRQF1gMpx1J3iH2OQo9fgwEc88PyEf6VSesW+Up729c6N9LV+3MSmF6Nxldc5weGdj/2VI75BGqjXInZwNcsDJOCGKea7d5NSmxR6Zv2ZC+UysE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(110136005)(2906002)(31686004)(4326008)(5660300002)(31696002)(86362001)(36756003)(8936002)(41300700001)(8676002)(66476007)(66946007)(66556008)(38100700002)(316002)(53546011)(6486002)(83380400001)(6506007)(36916002)(2616005)(6666004)(6512007)(26005)(478600001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3pCejlvVTFHdk04VlVMNmx4UGNBSytzS2g1TFJoNzI2ZUJseEJFaTVDendK?=
 =?utf-8?B?cVU3aGZFOW9DWjlobEFmMnJDM3Y4VnNVYmR3WjYveVRrVURpMFArUlpYL3ZO?=
 =?utf-8?B?bXpxZ1pGeEZNQnVYSWRuY1h0Tk14bDBaYnZWWGVZQkRGOWcvUXBiMDkrTlV1?=
 =?utf-8?B?WlRpNDZ1UjZtYUo2TWp1MWxyVmVCY3NFSVF0T3RyOEQ2MVIzb0R3ZGpYWXBL?=
 =?utf-8?B?NUJOZ2xXeW1WeFZsYlJvNzRpMDMycWFuY2VoNk42T2l1eHpaajlDa2lpbk42?=
 =?utf-8?B?MUNUcUFwQkxtcHFqeWFOaEVMZXdyVnhwL2Z5YkY5YW5FL0xXdG9rSWRTK2F2?=
 =?utf-8?B?UVhzTXdoMEVSWjc0MmJ4Zkk0cStiZzkwNDdCSHBONnozbTAxci9wZmRxYTEz?=
 =?utf-8?B?ZjhHem5TMUp4M2hPYWZoSUZ4WVBPL3kwT2RRVWxxTG5LMmd6N3EwOU4ybXIy?=
 =?utf-8?B?Rk5oZWFyVFRWcjFyVFRwd2gydWJpdUl5SWRmMFQxNy9lL0tCR3MzcHJvZUN1?=
 =?utf-8?B?anEvdnluNDJVcytVV1VSRGdJc1VnQUlOREVSUk5mVW5FbjRKOGdDTDdJRkxS?=
 =?utf-8?B?ZHE2T0ExWjJMb1pwT3Z2eEVDT0VaVm5FS2RzbTc1dlZKcEo5VE92cTl1L3BT?=
 =?utf-8?B?U1hBbGczVitnYm1RT2VidVFMMSsvanVHKzhXY1dpb2NYL3QxZVJMT29mWjBG?=
 =?utf-8?B?QWx5Z1NUYTB5eGo1STZMMGk0RnhzZmhaUHhOWkZtMXdnQ25TcFc5YWcyODg5?=
 =?utf-8?B?dDJ6a3NMWURwWXk4aDIvemdrYXV3Tkx2N0pRc2Rrc2FmaGxRaFduV3JGb05v?=
 =?utf-8?B?NVFFZnByYXR3dnVSTkh4N2MweHJJcGF2d05vaHlZSW4zRnJDaHBqZUpmcTNP?=
 =?utf-8?B?VmhiZ2hUYzdBNmZHcnFncTBKRlJwOTdvQ0tZYUpLaDZPU3BFZFVXVStGMndr?=
 =?utf-8?B?Z2hFNGNocWVXNFQ5QnpPNGRzMW1TUUg5WG5qdHE5RDlPTUd3N3QzbngxMTZC?=
 =?utf-8?B?UmpYOW51T1hVa0FGZ3FIVXpEMnZNTFE1THpIeEJFdFpTd2g5OW9nL251QVlt?=
 =?utf-8?B?d29Sbm1VdlMvWSs2aGNNT3VnZitvdXo4RGhLQ2RXSVFCL0JpNVlFb1dQdEhU?=
 =?utf-8?B?Z2xUaW5wellpZHpvcHpyTFAzRFVuc1h6SDBtamh1U1BnQnNxbEhkZEF3SEMv?=
 =?utf-8?B?K0U2MFdONUdYZFplS0RaRTF6c0NuZkQ4SUVBaFFtRlRMZ0FrcDV5VEFNSHY2?=
 =?utf-8?B?Zm9vL3BpdTYrSUtKdmphR0ExaFhCR2ZzZlhIRHRFd014alFJSFJvWWN0dThR?=
 =?utf-8?B?MUw4bmZUaUZ5UWdOZThTbWVFcnlWWks5dTdHZDVWdTNGSHpJTTIxSXNWUEJ2?=
 =?utf-8?B?U1RxaWVwWnpBSWpBZmlNWDdYeVdnRXpxTU1MVS92YjIzK3BkZ090RU4zUlJU?=
 =?utf-8?B?dTJvZDlWM3VIU2p6OXR6d3NUbWJBd005MHpOYXM2Um9KRnhLUkJDMnRrNDU3?=
 =?utf-8?B?bTlNY0tLOWwvMkcyYSt5dzg3VTIvOFRjOElncGRRUVlMY092cGh5NXdFOXhi?=
 =?utf-8?B?cEc3TjRsMHVtcVNZMFdZL2MwZmVYOGNBR0xYUTd2T3VvRDBFK1FBK3MrN3FR?=
 =?utf-8?B?SjFxd0lmNS9SOXpPTTlyWW5odlpFSk5GbDR3NUs4VmN3R3FWa3JOUlcwWGkv?=
 =?utf-8?B?OUVmUXhCSWJ4blh1dUdlYkZZUlVZRFo1Nit6YkxmaHlydktLQmY4a3BML0pM?=
 =?utf-8?B?TWJsUG5xeHgwUUU5dnQ0ZVpqd2ZKbzZLRDN2WGhlQS9UbnVrVy8yM21ZRzFM?=
 =?utf-8?B?Y3NLdTZQZUd6WEpvd3Zrd2IyYkN1ZHNZQTdhSHNxR2c1aDJvVExRMk5EaTZE?=
 =?utf-8?B?WjZkTFl0N05FNmRta2MyTlVza0ZURFR0b04zQlQ0bnpMTzY1Y3JhSFUwNFBM?=
 =?utf-8?B?dUdzTGJFZFVvV2NYYzc5bDlkR1VRTlQ4a0JDSlluTzJRdE1jOThlNElJNXc3?=
 =?utf-8?B?dTg4TDhqOTZNVTlBalFMdjlGRWh0VUdpNlVMYzBnTG05UUZQTmh3Ris1SUx3?=
 =?utf-8?B?bzc2QUc4YWd1RElybGJzZXZPcVhLSUZtclhjaXpBaFB5SWNVaUNXUkduZHEz?=
 =?utf-8?B?WU03bzJnZitkYlpCTWJibTBzYm4wK0pVTlB4eXFOT3FyenFEeDA0UlJicDlh?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uoS3VH/U4BOE8e6+QLJSRl+bTuEI/Wmv/hmRX+ObZ76Q8icvAwGhS7t4oJ1QiDCSk/9dkCxSe13veFF5F0NpdsZ2CWrd5mUdjB68kZhA/F7BCrNOFUALGGeBe3yZK5jI4RCMa8ExgMmTGBnC9V9ZRvhYKA64eTsIjREQ4/ghkuSYKDz19j8yxGShUHBLfvWW1vGgomkgCsjk2i5Y3+42mGXO4FvpNcruFj6c59bV1dWf0qOYC9Fxh2V2XrBxo1B74x7gF+DaxQ5j/AR0jMC74wTezgGpyjSG0Qu6m3ax3mTgFQYrtfo+Ql/7cCHgke9V99mwNmEH2OT0mEckA4MH7eArH0+pppRDjw/7i/JFM6W990UIukVxphDTenmYDDWMUoulQYKFR9zPwDArTv9yECQJoBiFNqkXVYlU/9vUEzu/etvgbywjHORmMu/FxaebvXy2gLXihgJqOe8CfoKHtevuZUJFS2DJFRoF2rjONSU245aOXZ18W9XC+jkpwV/Wp6j6R+2u5vBJdokLK6Ok83V58oHyWbQRy11DMuVlYe3uzHz8FG5fw3gVnnzE2pA8k0ZPnNF5AwVozspyH3g/2jNXUcCHqSFMTY+ITEoEsQI2Uy5HYTbekFAvHny6e/VQdNXaghFH1N7Y/uN3z0dhds2AThmxozy/lQb038b9SmYj9atz1Pd4ySIMg/ps6TM/j6WxGCcsy5Tmj5wBjXP69FOgNFifQ7jO5a04N03b7WlBKres84QOfkSr/LwsTN+P5ADjB7wjBU+/ns2NWkvToLznNTvhnvqvqP4GfNXLDaSbwobvtE2QSVGCUIkejLb50PTj2silCQt270INoAlQfAjCV0Vn0arZCiJjnpcx8MmYwipaLnnXaNFXepVFg61G
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89135d19-1944-4c9e-b20c-08daf3bcda71
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 10:16:07.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWZu5KlFkW4993qQZvet21hQYSEubvgX9IWbKrRnH5YHH7DBRIVnmw+eROOAFyZLFUuY0zxNZOoZPc8w/WY1yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_04,2023-01-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110078
X-Proofpoint-ORIG-GUID: Opesb6kRJVXut-mZ63dkvS2z2EWsrYW5
X-Proofpoint-GUID: Opesb6kRJVXut-mZ63dkvS2z2EWsrYW5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2022 02:29, Ming Lei wrote:
> Prepare for abstracting irq_build_affinity_masks() into one public helper
> for assigning all CPUs evenly into several groups. Don't pass
> irq_affinity_desc array to irq_build_affinity_masks, instead return
> a cpumask array by storing each assigned group into one element of
> the array.
> 
> This way helps us to provide generic interface for grouping all CPUs
> evenly from NUMA and CPU locality viewpoint, and the cost is one extra
> allocation in irq_build_affinity_masks(), which should be fine since
> it is done via GFP_KERNEL and irq_build_affinity_masks() is called very
> less.
> 
> Reviewed-by: Christoph Hellwig<hch@lst.de>
> Signed-off-by: Ming Lei<ming.lei@redhat.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   kernel/irq/affinity.c | 34 ++++++++++++++++++++++++----------
>   1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index da6379cd27fd..00bba1020ecb 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -249,7 +249,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,


>   
>    fail_npresmsk:
> @@ -393,7 +398,11 @@ static int irq_build_affinity_masks(unsigned int numvecs,
>   
>    fail_nmsk:
>   	free_cpumask_var(nmsk);
> -	return ret < 0 ? ret : 0;
> +	if (ret < 0) {
> +		kfree(masks);
> +		return NULL;

I dislike non-failure path passing through "fail" labels, but that is 
how the current code is...

> +	}
> +	return masks;
>   }
>   

