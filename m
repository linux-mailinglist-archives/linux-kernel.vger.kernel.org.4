Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA2F66575B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbjAKJZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbjAKJYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:24:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A1EB7FF;
        Wed, 11 Jan 2023 01:24:11 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B7NpAC021536;
        Wed, 11 Jan 2023 09:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bkE1IxzQJ0YzxMAV9ZV0xQgB/oEHkYIZxkPwxLGcsIM=;
 b=3YuvsmMGqBWjSN7sQMASll6ZF2IADAcu4gy9N1Egg7CGAu8x+gnwHnVVLgOsr9JjGoCk
 oeVpUzSpOe755jR6Y7FgYld69f2AchE2Rf8nYykKAKWZdk1sUtlu1R+RRvGBINUJ24/I
 JevRRMw/obtm+RsyNwA5bCxs9RUmwbca5m3Mixgb9Zx0/yp8gBrO2uYevzWILM5MlHut
 wrGKX+x8gT09OM+64j2g9S2MAbgTKpDUcNdgBQstm8gS+jsHr23BSMAgtvDTCfqTQSj8
 hh/aAmZixwXB3X5cqkpEHpGXn7D6jacx5QZNfHTVWsv/3n2P4TJ0j3dbgfIFyQ1YlqoO DA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1g850un0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 09:24:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30B8UIje018227;
        Wed, 11 Jan 2023 09:24:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4neve1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 09:24:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqdEvaTGoUR6JEByG5ql0SvWy9bySEvjOv23Kt9cSSa2wbTgsQ5k2UuzhFKTkW7jKUnddWoXOWi2uHQKDEZG1eDWQ+E5lSvsLhecsjR8KUm72AHpNfwItcLNUcsYC4+9TmC8AuO4OiQorIB0ZEZ0czpxUrYtGJvr40erKI7OlqvX4wX/mebnuzFzDfABol6UZL/A6up1oFc+ZH1vibm/pzdVRYng0AFHt/Au5H1WPrsLPoL1041+3+ecO1K85DlHJMgzP+Fgn+qQyYSV8g2ztd2k1uE9min3EQHHOkSlsZHoFRisMOOFXBxegbdx/eOyLF0PHK98Mp3+Tmz/vyenRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkE1IxzQJ0YzxMAV9ZV0xQgB/oEHkYIZxkPwxLGcsIM=;
 b=FcPuevazpws5+sDiGo1Wt4jM3fcBkYO9GC+GQlQQZ/wvgDzEbK9WXGfG5YKMDuKOZjI9wN0/sl8oDjOZzP6ELC7Xv+e9s0OnYjhyP3Pyr53/X9L8wV0UiPlKs0aTmXKw/dhVnoVe7CFtoOPKIRXP1fxjzufBZR+kG6jUs1l6KoJCt9Rs+/wDRBZv5PGZbkEAZS2RLyvChSsju6WZWsPNoQHwV1eThSGiIjWUTEt7fhqV3qJ5vYpLHFvKXyB2DdR5JOUp1JdeV1ElA46VQwng4oPZezK+IaMIY+2I30wL0pnNSE4zCyV406NeC8ErMDq+GhKQbwfkcYffW8CbflE2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkE1IxzQJ0YzxMAV9ZV0xQgB/oEHkYIZxkPwxLGcsIM=;
 b=SNVOvniga6jsB3siDS1RU7/jj8QmRELym9WLaslHAyQIoHF8aMJKte1Msl8YLOS1vhaNc6K81xpMl6v3PnJcKAncC9r3NW+2XxVfAEUtO9aFeSIa0kfoEr0YdBzhxHrcg91IBAkna94YnguU8Yr5W+B71rXWRhmwbbCLudEMPKo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6310.namprd10.prod.outlook.com (2603:10b6:510:1b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 11 Jan
 2023 09:24:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%8]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 09:24:02 +0000
Message-ID: <8f9b615d-d4cb-149f-1838-c4c13b57c074@oracle.com>
Date:   Wed, 11 Jan 2023 09:23:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V4 1/6] genirq/affinity: Remove the 'firstvec' parameter
 from irq_build_affinity_masks
To:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20221227022905.352674-1-ming.lei@redhat.com>
 <20221227022905.352674-2-ming.lei@redhat.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20221227022905.352674-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0675.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 6965d39d-2fbd-4302-3ac3-08daf3b59427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RnKb9CxChMvyUC8bTB5YrWpSPWWTYlKflnxK0m2ZXX3MNxyc74wuXS70TtV4Gdb/ZGG+lWh2OSVD77biOKwxoxUevPMNCM7rYTJiZTTzo7xllgiaGLGQ1LDIIRjZaNQdF2knw9zeI0wsWyQj8gnwTTQF+xbkArsDzegPf6Db3FrRpgN8eHyPbU6WxAffTZxTGQxmUdVIlHIzZtGOhd9FyGRGgQNguXklfxjHkD/lQUAUItZJhzBTZ9iB9Pv+IkeFn8mfM41E1qXSkNja7Wh0T9GMTBwsLPkD0srmjIu8jV2sBHUegeuu/NCkmOAaNiipHiz8lu+3kdZii8J3hnswuFhajlUQLa2qG8GzbvY1a4YEVX+oyZLD5JMaz7qs9hCvWBUi5ijkVRUmnreEEki58nlaNRbUOHrrsngpW5M5ncGxVl9TY9MFUw0m89QyJ4zcKxeklHRKhuI0wavRK68Vr0vibbAFTngThJdKFTQ/XAEZG0ilZEI32ZLx/9Ba63ih47/WlrWDSKjKfoPN0thOK4Fr5MUVpiqV7y+aH+IiHYob+Ne7072wo4u1CZRhb7R/ZjoB17tc4A9nZTv5AKN0xMN0KqHnyJhL2CLGDvj9aqwVJU2/EbA+fv/8G2KLgHmUTKsQQgPS0leOWvnERA6i9Kpg//QccsvoGyeucEZrA/+sWjGWGs0haX/f+7qQEgvoTv8DiMa9r/uBcvR5AvCtwCTIiuTVisRAW9yWOiK+ffs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(110136005)(31686004)(2906002)(4326008)(5660300002)(31696002)(36756003)(86362001)(8936002)(41300700001)(8676002)(66476007)(66946007)(66556008)(38100700002)(316002)(53546011)(6486002)(83380400001)(6506007)(36916002)(2616005)(6666004)(6512007)(26005)(478600001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFpuNDRPNUE0N2hoM0EwMmZPZ3AxajZ2eWVraTRBbWRsYUpJTWdUK3JMbkpF?=
 =?utf-8?B?OUlZODFKSk9ocW9tU1QyZFN1YnJUTVRqVFhDTnpyL01SSTFTSnF6V3IzdkJP?=
 =?utf-8?B?M1RjWklQMGgvVklZd2ZrUElkK3JxYmxkeDc2cXk2cGc4amtwbTF2QXQ4VTFB?=
 =?utf-8?B?c2I3d0E5OENyV1JCd3BkM2F4M3NXaVNsazhvNFdLNTIwME9JazBuQmNHaHNk?=
 =?utf-8?B?bzFrSjU5RGM2R2hmdXBPbzJZME5Za0FIWnlwOG01bTdCcnhWSU9NMUFJcTFm?=
 =?utf-8?B?Ull2ZHd5VVUxa3RrUGFDa3J2Nmk4OTNmV2t3TVE3VmVnc0U0MWVZWEFYOHZy?=
 =?utf-8?B?eElRYnhET3h5SWJMRjFBMjc1WHM0YVI4YlBQZ1NPYmlOZ2lmd1RYSHJrdkZE?=
 =?utf-8?B?YXdZcjVwZnNwYVBGak80d0N1T1RZOFFiUWhRZUJhZHJnekpEWnZodG4xMHpG?=
 =?utf-8?B?aFJoVWdJdExjeWdoUFdsNERiZWFrd1FjZnFkcHVqV09NR01DYmtjZTBwZzUx?=
 =?utf-8?B?WGJkbDBEVWtrZVhpb3kwdCtvME8yYjN6VHNmclp0OUpNVzJMRlhUc005SzM5?=
 =?utf-8?B?UFZRREV1dTFFSmtyR0twZUt3YThqRldaQm9YOHJKSG9VRlBQUldpRWxLc0Q5?=
 =?utf-8?B?SExtMkl1YVo1K25SS2tqYWQ3MUsrOFZIVnY3Ti9saDlxUlRiajJkQStXd2Zj?=
 =?utf-8?B?aGNyMHhqMjM1SlpZYU9NUDhyV09SRWIySUhiMEIzanJ2TXE4d0NMcytxWG84?=
 =?utf-8?B?V1ZrWVNNNUdtYkxaYkt5bXJ4UngxaDkvLzhEL1VyK3Q2TitTLzZmS2Z1NmFk?=
 =?utf-8?B?Y1FZbytJWkdSMTI1NUpmczB6MzE3VUxtcEh6T05kdUFaMHRFa3lqWWp4RkM2?=
 =?utf-8?B?UGVIM2FYVHdydWRLMGEwN0o0ejhSRGQ1QmpIeGcrR2Fic0VCeGxMRlBscW5N?=
 =?utf-8?B?ZG5Wdk5MeGZuQ2h4RGNBd3VHVDJhbEJlWXBVZGJhZDBXbjRjNnM3Tkp4VFQx?=
 =?utf-8?B?R3NhVHJzSitNVExMb0ZYK1hrOGg2MUpLTm9wK3hRNmRYK2NYY2d3MlM4TVVt?=
 =?utf-8?B?RUU3UFBydTh3bWs5K2hVamRTSEl6Q3J1K0hSTGMrTXU2UnZRNWpHSFRFcEpu?=
 =?utf-8?B?T2M3dTk5RXVNL0dKbzM5cUdUVVl4ZE9oWS9BTXBDZnVUR0FEUHozSUJRcUJR?=
 =?utf-8?B?cTBNWmJWdmNvZklqb3VoNHhyY096S0NYYndaMEFab1ErdnFuK2RsaGUvV0lr?=
 =?utf-8?B?REplL2k2aFRVSGZianZTTW56OGhlMWFQTGtDbERTYjhXc1JHWWxseDlXWitz?=
 =?utf-8?B?ejZ6alRSVEFWQnhLdFFxbTIzWkJEcTN2YnhqSUE1WHltWlY0Ni8xUks3Ny9Z?=
 =?utf-8?B?MEtJbWZONHNMY2l6RXNrRmlBSFAweUlaZkRxU253ZEx6ckw1cjA5SmlMdUR1?=
 =?utf-8?B?aVErVi81TUhyQXQ1OW1nSTVKbDU3VHFDbjRpS3BWVTNUdVdPSnZmNnpsMjVY?=
 =?utf-8?B?QWJ3Uk5GemlVMml3aHdFWnphaE13N09JN25xRklhRytRa0xCQ1ZvN1I5WWg0?=
 =?utf-8?B?Y1d3Sk5KTTVyVC9jb25YTG5UOXNzdXFvTlArSUczNVVlMi9tbDRNYWFBUGNl?=
 =?utf-8?B?NlJzcU1hZUxod1lLeFNIWDZNWVZsMUtiOS9qS2ZYYlU1Z2JnYSt0czJxRTNY?=
 =?utf-8?B?OHZrcUd0MkFtN3ZpUllDWmRrb1FmRXNCNldtcDJCQ2ZGa2ZseXM3OVBPUHp0?=
 =?utf-8?B?cG9Ucnhkc3RuYzlTNGFuWEIrRzY5V1pWWHUxZzBNTG9CS3hyZDFUTCtzSlFM?=
 =?utf-8?B?V0tveXo4TDRHN3R5QVFsVEZwa3h3VllvYWYwLzJuRXVmcWE3Y2FIRzNvd2lz?=
 =?utf-8?B?M2I1REVKTmVXOC8wbE51WDczdWowNmpqS2hiWlR3V2ZXRlVJanIvSWFiVzlT?=
 =?utf-8?B?clZVcXJuc0FnaGpoeTltblZOTHNjK3g0OGRCcjJFMC9TbGExUjJNUGE0czlw?=
 =?utf-8?B?TzhVSEZqQzVwbzRmbWVXQ0JsSzVKRkRJN0NEaGVxWCtoU3U5ZUhIeWpIbXg1?=
 =?utf-8?B?NGJQQXFPZGNGN2ZRdVRtTGVvRXpmNXRqd01LYURlK1VOajJUL25wb2NMYWNG?=
 =?utf-8?B?UXRCUW5QR1NDTWxRc1ZwQTZqMUVBMnp0anpIQlR5Sjd6Nmk2T0g5aE1ESWlT?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZZ0J0X6/7v2wJgZYPHtJ7pZbDNphLOzfGhNHhAh7KMzVaqLJ/pKNswde41wnXGMdhhSBD+6IdjQetzWme4J8ZZfshXR+kkY7Iz9SzIgcOck9rDCNlUC53spSZC28YM4OC3tV1WoAPgdk+VUm8fr4a1iFDIQ4+8f62z0Taj81K3M742dXi5dzM81v87F58UqHLLjeTTiPWPuCwsK9f7CToui/IweY5W4o6n2vIW4gjm+Pe7QDSHBSwEMQIbpWS5Lp3cHBf/wffhHJM9BEQAUNdbHd4CxOtM6ny3vUCsbwgzmfU5gKyNE855Ig3jOJESFIJGm9JLspsKR+Yvpj0N3PU5V0lON4s48Lm4torP19MFlF1whnhdvtMBXDcSMFYMHQiYD3LqGo4GYpqSgxJJAksjXQOHtBVhoK0C8ghlPT/t0VbEI9mnJQxQ1vIZJlYM/uEmFyNKGHGWpT8MxOSl2peTkN9qE3n3DeDiQg8QqbEOkHMeO1kr2wbYEg1K3ughe/60nzc2lx/ME/CHGowwuKvNn9nI8n+u7dmBU7d4/WkB6ffqquMU/fKuWrw6LC6n9bRa5Y0eFDEDf2I4ZmohtAqzAsF7DuEQmhDanaYUD1xtr1Eexd+uz5TQ27u/nGU5tRCHf3tcJ+BSQH3X38xiiAl2cHddFZH7ynu37iesfzlmE4dIiAZK1r9awdLeQwDQTa5Xn4QAnZBP/wijDAfWn2NFZE5C58egqRihnJ82xzVsjivf6m0jNdfn3Wnx64RCtxsMVgyeqNaCaksWs9QF1OSVXVaCMe0VuWfw70fFnm0M78qfaXiI/CL148T+FfSg0hVkQsy4WQmtbmAMI1ya24asWztsGbNyVDG2hFAZvpAUAi8/p80N3zybrAAEv0Tczv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6965d39d-2fbd-4302-3ac3-08daf3b59427
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:24:02.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9+UrYCk2Gpm/as8JiKoUSBgZCONCKpkkIO3/7lsgJCNJeJKnMZ42XQvZNioQbMF3Y6iG3/oLTD/pAWb6CYIaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_04,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301110071
X-Proofpoint-ORIG-GUID: g1k88QRADgkAZZ7zU1Z9mF7srEgLHFHy
X-Proofpoint-GUID: g1k88QRADgkAZZ7zU1Z9mF7srEgLHFHy
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
> The 'firstvec' parameter is always same with the parameter of
> 'startvec', so use 'startvec' directly inside irq_build_affinity_masks().
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I also note that local variable firstvec == startvec always in 
irq_build_affinity_masks(), so may not need to introduce firstvec 
variable at all. However that code seems to be removed later, so FWIW:

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   kernel/irq/affinity.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index d9a5c1d65a79..3361e36ebaa1 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -337,10 +337,10 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>    *	2) spread other possible CPUs on these vectors
>    */
>   static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
> -				    unsigned int firstvec,
>   				    struct irq_affinity_desc *masks)
>   {
>   	unsigned int curvec = startvec, nr_present = 0, nr_others = 0;
> +	unsigned int firstvec = startvec;
>   	cpumask_var_t *node_to_cpumask;
>   	cpumask_var_t nmsk, npresmsk;
>   	int ret = -ENOMEM;
> @@ -463,8 +463,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>   		unsigned int this_vecs = affd->set_size[i];
>   		int ret;
>   
> -		ret = irq_build_affinity_masks(curvec, this_vecs,
> -					       curvec, masks);
> +		ret = irq_build_affinity_masks(curvec, this_vecs, masks);
>   		if (ret) {
>   			kfree(masks);
>   			return NULL;

