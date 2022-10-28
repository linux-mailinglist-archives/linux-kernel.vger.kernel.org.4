Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89193611C62
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJ1VYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJ1VYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:24:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F42E24B31E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:24:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SKxRRW005117;
        Fri, 28 Oct 2022 21:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gLusM3u6vYiqBq6AUMxw8NKxNcokMenbhoDGIANemgE=;
 b=dM8tJQcqUckmMT1uipckSS0uTV0oU2LUYQI9vPdYR/M+KEcWBj6dhu9lYt88TomR5K92
 uZ/POfqTJD1WLdb7Y1mYeu9h5pNIgHRwzXOiYknRxPlSbDf55q9VRwk/cb9dcrSllJ7k
 GS/sUDhnJMpf/Ky6/8U/TlcuWJuHAexLZEEoLnpTiGaJx2qnReTnnsgSeHddSxERIgO/
 OvIInzGCUpS8oS6Eh5g81ZtfhX7pwq98FHH6RMPArdmI/ADNrgJNEVIaSJK8cMO51+SL
 saCCdzOtuI/8dbi5Wuqk2UE75wn22hGBIPmiO/dQ7U3/PuU6vtScQ6UKkf226RCAMFku CQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfaheek01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 21:23:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SIx4MY011651;
        Fri, 28 Oct 2022 21:23:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagsfrp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 21:23:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GP5QX6BZ2T1kCta+QMCW5RJXvfjjGj56u73/CPI4M8uqyJ+vZq2DjIhPfzodlAi/gXzHIU8a52EFvLoB0Gv6hxtz8Dluwg5O/bI/XrX3cIdBYMMuAfkKqOVIe/BD2P8pZM0W5MH7hCFzq2QHwCi9oRKzylMtWwu18du3ZH2ACgIlKzNxbdcO5VKyIEFPiySdKVbV2Y4Z7Kd4lJkNfMd3rrCnY52MJM9RC61IneGJlgiPF4pMLyw5oi9F24RXWluhHZ0lQzStAhURrTAAnFWYlJWBvroKgjq4i/6rxknh8dzLzqb0VFXOgedDIRNdfaknIXFu/wsW9NIl1xTMAllo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLusM3u6vYiqBq6AUMxw8NKxNcokMenbhoDGIANemgE=;
 b=G8xo8onvVxwyfrGTGfsXvM3NiFS5jZpG00/VAyvZvSMyT5d9u48knPfzDIfWI3G18YVZ1hcyLoa37WmEH/xkRaDyrEhRj247S8PYE8E2K1IBieMhY7O60LCDy6X+rVwQvWeJjFrv808dElBSY1pGaGkyPytlfb5sDnOJmnUSUjFSLnKAahDNypGGTHywwoC6yNGnYJN/EL+DgQlGwT6euNergMVLbFwL1TNvwk1Rbyld0rBm17mKJBj8uuWjBGUkoumzoIAip89PYRzVOiBUk6pREjyRZeE/ySWGoi+NnYl60oQcSfSYGpAs5Jx7PRuxz/f71BjyPwIerueTaf49Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLusM3u6vYiqBq6AUMxw8NKxNcokMenbhoDGIANemgE=;
 b=ElNhBEN0Q45lVLqAxn3n5o+bOiKndP+i7efDWzv7YRNllbo2QCjxf5h7bDA7Sdd6zMJqrxL09TCmsAS96Vx2lO6omOyrqgvMSte9yIF8hEJ0ay2zB5f+YjiQD1AVhrpi0UR+w2x+1lv6PqPXRs1WpC8/dTE+EM2I8Y9Rjc3BAdg=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 21:22:59 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.014; Fri, 28 Oct 2022
 21:22:59 +0000
Message-ID: <43f16833-add1-80c3-3bf8-5a6a05e75be6@oracle.com>
Date:   Fri, 28 Oct 2022 16:22:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baoquan He <bhe@redhat.com>, david@redhat.com,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
References: <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic> <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic> <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
 <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com> <Y1uspLb7fLdtnQq+@zn.tnic>
 <d91f8728-6a63-415d-577c-bd76e69ec7f6@oracle.com> <Y1wL+ZrvD5gTZaKN@zn.tnic>
 <ca43bd5f-8a74-9412-3d4b-52c7d5e54978@oracle.com> <Y1w76RwZUKUvsS7A@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y1w76RwZUKUvsS7A@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0040.namprd08.prod.outlook.com
 (2603:10b6:a03:117::17) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a13515b-a1df-4b1c-63fb-08dab92a96a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGjQSZjT4X0MfgyrlS0BAPSmkiE2O1rySZG2BgP7f+aaCZTXzrUIgaI5whpy19IKGOqmaz+kS88UPqqk106RJRU+DYZ/Rsu6sAhkaSQ8NVyK23YCqJTVnwgeKfygcUqUc5VcCTq1ZLhbYp5dW9DoyG18voobBqsvgfJdjkowX67i8bfZeZblLIUl26q/ji+CKKDXffWlvqNMyO0Kov0KrIaDvwIfmDGB/6s9rCJhH+zhfN64gVAPqFxg72P1IlS3eOCLWdcQ8z0HC3HTJ1ntshzELd9tDE8VnJwKVihh59r2dA3n9ArY8QnWlTLRvVTkFOgsKW5MJEnyEQbiYvXP48WU9lQLjBsRyOSWGICzfhtgHUADuGM4SbSLJxlh9sBLym8Zvrcn95LhDBuIzQCiGlOPgd9zpRU16hqniH2/JWXyKoTXti8KnrH7zZti/NdzKTqCd8rajZ1OpHo08rUHF6rydeO1sm9QuCbhv6K9C3I5//3c5UH5DLBJzsffXdCfcwZsQWcdVCju/E6qnMIFsYY8X7bVujEn6+z52/bZ6WcYGywt7bPqO2S5SbSHoJYaMDF1LA/lBsCM6LjPT4BZLFnyfg4B4j3EjWA84DiaNTtm+ziT2lX3NZfTxf1yW0erZm+q3OosfYBphW9g64GZcP1O2r+cAhcZnIUruni1/mHyizr56sOPfJ+L/yIxMt009j3iIjnxjWDMKSrFDVa7XhZo45mb0Jg1T88Cm8ldF9UgtjoyjVxuyns8GNGmeb8LHLUP/GPre3BVcfsENiHYTVKDFQ2hV2mpL/1MYfQcAgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(38100700002)(5660300002)(54906003)(478600001)(6486002)(86362001)(66556008)(7416002)(6916009)(66946007)(31696002)(41300700001)(8676002)(66476007)(8936002)(36756003)(316002)(31686004)(4326008)(2616005)(2906002)(186003)(53546011)(6506007)(6512007)(6666004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFZ6SFRWcVRhMHhPK2txeGhaZUVlbGJ0SEdaTXlXcFQ1ODhUa2o5RUpxdFd1?=
 =?utf-8?B?bHRYOHNUOGtwZHVYZit2dWpBS3JROHhUY1NUc21JMGhMLzlDeUhUQXh6eXJp?=
 =?utf-8?B?ZWtXbHVCOXpZOEVmdm5jM2tMVDZ3bkxiTHQvMnp5TktNWWNlVjZzQ25EeGJU?=
 =?utf-8?B?NzVwQ1lobThQekxnYzdHd2w5SlFrc08zcDhQYjhBMWVzanBVNWJGdkkvNUR5?=
 =?utf-8?B?Q25ubFc2Y2lyRXlrdjhXRHIwWlJENm1LVGVtc3VYclJZZGp3eFF6MDZKQm9z?=
 =?utf-8?B?MnVJa1AzK1llTlNtaVhOUVBvTjlkbzdUT2w2ZUZPN3h5ZDd2eWRhcjZnaHlx?=
 =?utf-8?B?cjlOaG9yQU1Hakp6U1JVaXNGRUZXWnRoSWhqSnFHY1FRYjdUYnZKUHliamdG?=
 =?utf-8?B?MDVJRENvWnZCUzNVSXBMN1JmaVVsU0ZSbWpENTJDNVduR3JtM0REbHBzOW9Y?=
 =?utf-8?B?Nk5CRmdtZzB5V0NrWjdQVjdaQVRMVk9NaGlHRHlNY2QyenE4TiszQVhoTTBo?=
 =?utf-8?B?WU1CVFI2UUh6dkc5Q3dGd0JFUWdFMUJLUVhCekVCdjhPNVhFMTVNaEFlRDlH?=
 =?utf-8?B?Z0w1ZDV1L1cweXZRTFhGM2NJLzIrQVB5OVRRTW1lb3pEWW81SmJXTGs4MURx?=
 =?utf-8?B?eWw0bHhTbFBWMjZCZUg5YTFlampxY1N4RTFQRGdxWDRoQk5JbFdqSzZ4dWph?=
 =?utf-8?B?NmxGU3NmLzlmU3pwdmxlNThtU2JiMEFNdmovM1pqYXhvSGtjbkRDdnZPSTFk?=
 =?utf-8?B?UTlDR3BYbFlIZDl4ckZJTytqd0ZtditZWEdVSmRXd3FYdlU0NS9aU3FwREMv?=
 =?utf-8?B?STg2VXMwWnBhRG9wNDFIODJOT1BZMFh3RHVuWkNFUG1aeEV4TVlTWXNsejVx?=
 =?utf-8?B?R2xpeC9DS3VnaDA1V0NzckplVlcwa3R0cTZiWjc1bGdxamJWUGZkNVpNZ0pv?=
 =?utf-8?B?ZWFmUnNFdi9VUSs1L1F1Y1l4aVZjSHFrN3NXOUYxd054dmloYkZGamE2a2J2?=
 =?utf-8?B?L1Jvd3o4NUtlOHgwdjNGTXlvck5mdWtCTHdQdzN5YmwzZmhLZmdOUVgwMnN0?=
 =?utf-8?B?NDZJZkJQYk80WXlsaWY1cGNiMzFwUkk2M09UdXZJbWIvY09td3Jia2p4TkVJ?=
 =?utf-8?B?NnA5NlV5VDM2NHlYc1hqdTFaWUtINnI1czFWd2RGR0pOdmJBRUFyREVwZXJq?=
 =?utf-8?B?T3RSeEp5RlNEL1Z6UUFOd2FiR0hrMEg4UXpyUGpLM2lwenN1OXdiQm54Wmlv?=
 =?utf-8?B?alZBTy9iemFQdEpnRm5ubWRCMGtFeHlqRTZ3YnZub085a1hITmpDaE9uT2JY?=
 =?utf-8?B?cjdQWDZBcEZ1RTFPZTlBeHUyR1N5MU51cHdaS1JhNDh4N3NKWnYyVzVhVG5x?=
 =?utf-8?B?OXZIRXo0MGVvTmQrZkViUTJKcDdlQVViMHhZd2ZINnhlOWQ5bkZxWkdkR0ZD?=
 =?utf-8?B?cmZUQnEzMStiODY1UG90ZDFwZUpEU3IyRm41VFRKOE4zRU1mencxVDZJT1NH?=
 =?utf-8?B?QVlMTldLeWJ2L3l0SDFQbGJsSFBHUk5VTDVRZjVFQVlMN0txVUFzeTJjVFB0?=
 =?utf-8?B?YlViQ3hTTXI2NUdxNzFJbklTQjRpODNjMUIvd0huRjdQN0JuRTJ1ZEtyTDBW?=
 =?utf-8?B?YThORElUdmszRGRqNHcrQUo2YXZqanlDaEFtRE96YWJ4enh1by9rRUU4VkVL?=
 =?utf-8?B?dUlZWWdTT3JUa3pVdWdKMmZmRktoSHpPMlluMXRobWUwcU56Q0pRdUNyVVlK?=
 =?utf-8?B?b3Z5Z2N3dVRQcUJGMEZOQTF5T0ZtMHovM0poKzdYcGRiK3pPUWcyR2lkSVZz?=
 =?utf-8?B?UkM2bmtNQ210VTFmZUFlTWZsV2pCSytjQWp0ODQ5RFAxNE5NT0ZIdVg3Mk5I?=
 =?utf-8?B?dm9EY2xGT0hBeFo4aExrbng1cENQQXpoNk9vcjlNbklIM3hqaFlLaUlRQ3lF?=
 =?utf-8?B?dXVaZmFVd1hkbXdwQlZOaERJVHlJSmU4NE1rdHRYNDNmeXQ4ZG1DallVY3oy?=
 =?utf-8?B?Yk92V0YrdTFoZnR6cEVSWThFQ3E5WWMvWjdTME50S0JYTjhiN1ZTcTlTT1VM?=
 =?utf-8?B?UTd4ek1KU29KS2wzWUlpQzRoNE1EQTdCZldKRHRhcEFEaFhKWmRDengyVURT?=
 =?utf-8?B?TjZCeUVOTStKVW1qSWdFeGlIejM0MTdPV0tmZjNDVG1RK3FKT3hMdmxTQ09C?=
 =?utf-8?Q?Rflk3+U/6srbKTxryqnx4Eo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a13515b-a1df-4b1c-63fb-08dab92a96a0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 21:22:59.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLHjwK4Nnhtfl2OEAS9aqL7Xp94GZWdbIuQjITx4odopeL72+YPK9miuBRSgO/qCvrlMIx52rOLXmqK/XvfmMG1Q9ZjT9PdWSq7fc89ZGWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280135
X-Proofpoint-GUID: mewFo1YGaIg96syJkZ4rSAWYV_bkOB7J
X-Proofpoint-ORIG-GUID: mewFo1YGaIg96syJkZ4rSAWYV_bkOB7J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/22 15:30, Borislav Petkov wrote:
> On Fri, Oct 28, 2022 at 02:26:58PM -0500, Eric DeVolder wrote:
>> config CRASH_MAX_MEMORY_RANGES
>>      depends on CRASH_DUMP && KEXEC_FILE && MEMORY_HOTPLUG
>>      int
>>      default 8192
>>      help
>>        For the kexec_file_load path, specify the maximum number of
>>        memory regions, eg. as represented by the 'System RAM' entries
>>        in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
>>        This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>>        size to determine the final buffer size.
> 
> No, do this:
> 
> config CRASH_MEMORY_HOTPLUG_SUPPORT
>      depends on CRASH_DUMP && KEXEC_FILE && MEMORY_HOTPLUG
>      help
>        Help text explaining what this feature is
> 
> this thing will simply get enabled when the user enables MEMORY_HOTPLUG
> and CRASH_DUMP.
> 
> and then you do in the code:
> 
> /*
>   * A comment explaining how the 8192 value has been selected.
>   */
> #define CRASH_MAX_MEMORY_RANGES	8192
> 
> Thx.
> 

How is this comment?

/*
  * For the kexec_file_load() syscall path, specify the maximum number of
  * memory regions that the elfcorehdr buffer/segment can accommodate.
  * These regions are obtained via walk_system_ram_res(); eg. the
  * 'System RAM' entries in /proc/iomem.
  * This value is combined with NR_CPUS and multiplied by sizeof(Elf64_Phdr)
  * to determine the final elfcorehdr memory buffer/segment size.
  * The value 8192, for example, covers a (sparsely populated) 1TiB system
  * consisting of 128MiB memblock size, while resulting in an elfcorehdr
  * memory buffer/segment size under 1MiB.
  */
#define CRASH_MAX_MEMORY_RANGES 8192
