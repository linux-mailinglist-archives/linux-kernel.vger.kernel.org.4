Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9846115DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiJ1Pav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiJ1PaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:30:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B035C9D0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:30:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SEk28W030888;
        Fri, 28 Oct 2022 15:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=D8/o2CQp6qAJKMF1OBh5JDVy09iJNLmx79ZGTRQIRg8=;
 b=1ip5sJCc3xsYKIChlPIk8ngBL8Jr9GNRJy8QPo432fHGvMaVGUvjpIIWoZu/jUkJdxfL
 Vjlm7vOvoqHIc7RnpUyBC5WWOef+e3OjNFIJZrCWky1o//lP+VcOOs+zAsGCNfdTuZAn
 yKIt5Nnh0FBGBEdpEmVCgwwoQdh2IoMjKewo6FJY4/bAfc2IQExACzQR0VES62/DRQ5U
 wVs2wpB2ep+g/N9KxqWfrOTZENpm0w/iQnTBe/Ek77k2G5YdsFnn3EMhLj7sE+sHRY9Y
 nvnFoG1oljuav+a6mMwjyJMLbt39YknAlfMDISplatkXijfhZNpR5t1DqaWxSzwDUONr WQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfays5fw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 15:29:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SEZOoh006690;
        Fri, 28 Oct 2022 15:29:55 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagj5p1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 15:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQTXNjvT7hs5NQ3l5BDY+xL3KTJ+4UdyttMB3TeE51AKKaTxyWebMjkWHuXH1cwJyjRXr/486f6kKyAJh2jEHOyBiJJVbyJBxi6r4FRtuYxct/fmx1VgAzgw+eHqi425MaqV5/dqFX3utDpSeCxaotwahnvjDL2HhHYWMidZj7ohYks7V9fWJl0JIZn35pIcUuXZbcSbS4zc12nZIaj8upeqEO1bUPkY2ya4hLEpPHrOmJJzeNXvuBK4bC+SRaRR6uZkZrysg4W02OrDYt2M0r5pLlUXnw9dES7hXjJ1/71qYAxmpPS1ZxDVOKKXCR318T9LLWcD+7JPfjD+emampw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8/o2CQp6qAJKMF1OBh5JDVy09iJNLmx79ZGTRQIRg8=;
 b=EQXTsxCCP1txlsZL5y0wN/567Le9Q3MawjXadO01g40CL9wpX4I73+ukd292+R2yRSaNY1OfqHtjKQjU0+bBUDM8g1r3wXoLNMpS2NUE9fbPh1ab+MXY58VGkTT+mae7T6zenUm7Ix72I+SKPhbsRrYBrexBZ0CpTw/LoWTkSNtZPSmZ1MtcTaiZQJHfVmkGnA54vYdU0du/LLScHjUtdxsoPZCwK6apu3Kc35RKYQ4rVTUIGcFsqgz+TdT8HqIbTLFTvkVywOHIUQLGULUq3RcMXMzMMamv95NQ4nK8Bf16SWkydBWXAnfpi1sfQYy6DP4X7HaEo2x17BISqaY9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8/o2CQp6qAJKMF1OBh5JDVy09iJNLmx79ZGTRQIRg8=;
 b=KfGMe0agZocXj0FrTLsGH27meGjDyk+qQW/Kb+TnniLH1S38ZqFzB0G6BHhR3tKsGALD+oEGYXkszf9BRpVga/K+M5j9ivErewq0IHO1SL19MQ3y/By3xDjCvAYr6nxbAGAEM7jXENcLSfXQfuCWMVlpHCDxLVTfm7s4v6v2Kuw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 15:29:52 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.014; Fri, 28 Oct 2022
 15:29:52 +0000
Message-ID: <d91f8728-6a63-415d-577c-bd76e69ec7f6@oracle.com>
Date:   Fri, 28 Oct 2022 10:29:45 -0500
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
References: <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic> <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic> <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic> <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic> <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
 <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com> <Y1uspLb7fLdtnQq+@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y1uspLb7fLdtnQq+@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:5:40::27) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 4280bd7f-c35a-411a-7263-08dab8f9423e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGDr/vn/FfcU/J7diLWBi9y49aG2OG1IrlZxTFSHFIb7ES394iTXJnf1mfzS+Y8zAsCfXuU3eHV3r3lR7KuABPBQM5eAickvLTxul2lw3xqlYsDyKxM1Hn1IGe25zSyFtfCdScSPF+I48fTRxuUFc8UCYWpPQYqPPKk+CzQhmw9QYKvoX4wjHXhwShb95R7UUjqkQxQzCZdWpMcsvDoFTOIxfPBk7RtWe2+aT/S2l519/PIqw15fdNsp0SUzuXpM3pZKqOjol9uzE/4Et4Z7RuMCyYKaWWprjlCK2AWvPrg5xV2kbydrmHxy4KU6D/skVXBjJHLy5yGQwogTsyU0GJ2WBRLV8e3vJ5BmafaUwyEXJ/LeFAbYC3CQTwGmgiaXxqYnSzJmvhQaIJp5P1ozWlTNYIx2kqKm5oN8Ha09AWPCi8+Jo9lh05NKc7csD7MrcMm6/CtGJmsCPSc1DIEnfgJH+l6MFES0gBSdjegOCT+b8a6DFunVMjcdwXMndBRl9tapo1LMoUadCaPuHxkr2Z9d6Sv/u7kXvi/PfQa70kzZ7HwRIY6/vdhom6El0IeLB+GYxBbYQRXSV2Z1IbTzVgN3TkvtyEu/zUhCDGmdtsq/WtIvjg7JIvg75ao0nvnaZG233bzVdFGKyF4ZNplM1Ysu4+7wft3Npy41Vz/l7Ixbmc4N4FTk0Nksv75wool2Ml9lFjyLBnpCORUcpXTkyZnRaOLRsUggtWP7Okum0+Stv2E2TlzD2LiTQikvYHdUgut+h8sAe9WebQSLXIiNvwJpwfTmCKURBiJFM2t1YUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(31686004)(7416002)(41300700001)(8936002)(5660300002)(36756003)(66946007)(66476007)(66556008)(8676002)(6486002)(316002)(478600001)(6512007)(4326008)(53546011)(54906003)(6506007)(6916009)(31696002)(2906002)(83380400001)(6666004)(86362001)(38100700002)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cCs3elVtVlp2a1REUTNMTHdkTzVUQi95Z3ZDblRZSy9iei9qWVpvNjVNT3hH?=
 =?utf-8?B?akczaHRSUWx0NElQUWkyYjV0UVNUQkFIRW43UDFuVGYycWpMeHlXNjAxMlgz?=
 =?utf-8?B?OVlYSHFRdTBjS3NINGxLanRhZEV6dUxiQmRDaEJYd1Q4K20za2Qxai9yRjh4?=
 =?utf-8?B?emx3V21Kck5EcTA0WEcyNmFJeEFqRjdWQmdaQ0FNN2RkUmxNcWZENWZDeGlu?=
 =?utf-8?B?bVFmRU9ITWpnMEdsMUFpQmFwUDlJSzVWaTdrWDJWVFBSSlZ3alFnSjJmaXRW?=
 =?utf-8?B?M0dCRFVvWjY4anZGRDJoWXNZbm5hWWI0a0w4dU4xNklQRmxnSExaZTRwSmJF?=
 =?utf-8?B?VDBQUHBmSzBDVXBYLzFKYzZqQW9IbW8vSnRJZHlmc3FyNENodldyUXoxT1pI?=
 =?utf-8?B?djVpOXpZSHB1T2lMR0VGcmpnQ1VQNFZCTnovSWJZaFZRK2dnelIvRHZmNmF2?=
 =?utf-8?B?ZHdETjNFbHQ1T1hESTNlWHd4ejZuckFsRzUvRVZlMVg4cHdoaVU4eTNDYi8z?=
 =?utf-8?B?b1ZjYkx0TVZZcUZhNEVVdlM0SEkwV2h0a2VrTks4UXJKZGZabFhBKy9Lb1pB?=
 =?utf-8?B?b05mY0RCdTk3MUhFc29UL2NISTRNZktRbUg1c29XYS9FVWRJT25mc0xpbGY0?=
 =?utf-8?B?dmczNWVSeVIyUTJvMENNR0JaTGV2cVdkaktQa1BWYUxWeHV5VmNNYVhTMTZa?=
 =?utf-8?B?OFpTbUU0Sk1ab08vdXp3MXI2b0tycGxkWnZiOWlRcUpIVk9UcjRRVEs1bFhu?=
 =?utf-8?B?MVF0T2Q1WmNWQkxiTHlwcFd5dVh3YkZGMUExaVFwL0psSnBtUHhDb0pjZzBL?=
 =?utf-8?B?QS90amJrQ1VLRnl3eWszZnNYeElTUE85ektweXUxQklpdytIalJtY2JnNjBu?=
 =?utf-8?B?ME9vQ1JlNFh0Q1NxTVVQR3h3QlhTaHAzMW9sSG1IR0JEZlEwb2h5eUVPNkpq?=
 =?utf-8?B?R1hTREIwN0VsQmZCbXNyalpydWZNekVEdTBKajQ1N0kwWE5nUzN5MGlQOGtB?=
 =?utf-8?B?ZmcvNE5pd3hEUkJvckQ1S2NaS2IxaVVSbC9xTzQwTmN4QVNFZXhFeHMwNGFT?=
 =?utf-8?B?SW9UOEFiOHY3U2NranF1czJQSFBoeEk2MERjTjIrY0pNMWpHT1BQS2NubW92?=
 =?utf-8?B?cFRmRURyOGhtTkdiWWFnTTUvWUxlWFpxM3l3MzN2VHpGNThSb0FDUDJhWWx1?=
 =?utf-8?B?U0FHVnBpaXdvTkg3Szd6RHdaNGUwWm91NTNmeHgxZXZFam5kbkN3MVQwZUpL?=
 =?utf-8?B?TThwMm8waWYvR1huWnYrUXE2OFZyQVYyanIycmdFdGIwYmZQZXhEaW8wcVlJ?=
 =?utf-8?B?TlFwZUtRT1R6NTd0SjJ6S1JEVnhxWDdzbkc4bVNPZnJUV2lzSkZ2N0gxNzVZ?=
 =?utf-8?B?T2YxUFluMnBHbnNxMmtDNExlUExydnh2WTJFdWVwY1Y1eUJkKzZNMkdqU1NT?=
 =?utf-8?B?VTJSUVUydFpEV2lNdDBqcCtwOXlBbGR6ajdLRWVJM1hZWWJhK1ZiWlVZN3pG?=
 =?utf-8?B?SFNiT1IrY1d5V3RINUhnWnpWRnZMN2o2R1grRVVvaEs2dDBDdG05QUh0Wnkw?=
 =?utf-8?B?aG1MalBPYzRaaHROZWsyUW1mTDBnRG9oRlRpblZPZVRlQ25UUmVZODJrbS80?=
 =?utf-8?B?RzZYNkk5cGk1dzlSendHRldTMWdYb1EvNFVZZnFqNXZqSTJ0ODBUQnpJLzVy?=
 =?utf-8?B?TVdGdjBRMldMeTMrcDdPZVVVTHNIU2F6SGVsbGtRR1B4REEreXR4MXpTcmVO?=
 =?utf-8?B?TjVVa015V2lmTFVNMmIxMU1leXJHMHZXemFHNWxVc1JwZVVDSjdCc2FzRUpr?=
 =?utf-8?B?bUVoek9JTnVqVkF0WjdUV3o0dWFpc0ZYWDRtMUdDR3J3VnFxajYwODJYWThS?=
 =?utf-8?B?bk9zK1BsRVFEMmxPckZiVExFbm1MYUF3SjFDdGpOZmxQREpwR2xRRTZ1S3ht?=
 =?utf-8?B?TllzMkYxMXJzSnl1Nk9hR1grcUNpYm15eXB6aWhRb0hVcGRRd1J2Y0ZCeUlk?=
 =?utf-8?B?OVhOSVFSVnJ4Qk1XcG40YW5zZzVTNGR2KzFrNWN3dFpRT2xGY0txNnBWd1NC?=
 =?utf-8?B?UlVUQmhVNXBaTzhvQVZrNms5bjdHVUVMNTE4eFlpdWtmYmd1WENtbDMzbUJu?=
 =?utf-8?B?WjVQRElsSTdtWWRZNTlUck5zQjdJMStLVG1OVjgva0lGWWdXMFplemNJY2dL?=
 =?utf-8?Q?496WeTHlv2eaXusEtCocKTY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4280bd7f-c35a-411a-7263-08dab8f9423e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:29:52.7070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wdwqZkHoRe2m2WDOl5AVmgDTPDTQKZRoJyzwJTeGXPUuKp/Kwl9not1j7i0SvzvRAeujW25oyg2wotSxAEvF/8EJAzXtsvh23X/nPWsnuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280096
X-Proofpoint-ORIG-GUID: jlbVogpr_SuM8FGJL-DUDoiTddtuX9Jo
X-Proofpoint-GUID: jlbVogpr_SuM8FGJL-DUDoiTddtuX9Jo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/22 05:19, Borislav Petkov wrote:
> On Thu, Oct 27, 2022 at 02:24:11PM -0500, Eric DeVolder wrote:
>> Be aware, in reality, that if the system was fully populated, it would not
>> actually consume all 8192 phdrs. Rather /proc/iomem would essentially show a
>> large contiguous address space which would require just a single phdr.
> 
> Then that from below:
> 
> 	pnum += CONFIG_CRASH_MAX_MEMORY_RANGES;
> 
> which then would end up allocating 8192 would be a total waste.
> 
> So why don't you make that number dynamic then?
> 
> You start with something sensible:
> 
> 	total_num_pheaders = num_online_cpus() + "some number of regions" + "some few others"
> 
> I.e., a number which is a good compromise on the majority of machines.
> 
> Then, on hotplug events you count how many new regions are coming in
> and when you reach the total_num_pheaders number, you double it (or some
> other increase stragegy), reallocate the ELF header buffers etc needed
> for kdump and you're good.
> 
> This way, you don't waste memory unnecessarily on the majority of
> systems and those who need more, get to allocate more.

This patch series sizes and allocates the memory buffer/segment for the elfcorehdr once, at kdump 
load time.

In order to dynamically resize the elcorehdr memory buffer/segment, that causes the following ripple 
effects:

  - Permitting resizing of the elfcorehdr requires a means to "allocate" a new size buffer from 
within the crash kernel reserved area. There is no allocator today; currently it is a kind of 
one-pass placement process that happens at load time. The critical side effect of allocating a new 
elfcorehdr buffer memory/segment is that it creates a new address for the elfcorehdr.

  - The elfcorehdr is passed to the crash kernel via the elfcorehdr= kernel cmdline option. As such, 
a dynamic change to the size of the elfcorehdr size necessarily invites a change of address of that 
buffer, and therefore a change to rewrite the crash kernel cmdline to reflect the new elfcorehdr 
buffer address.

  - A change to the cmdline, also invites a possible change of address of the buffer containing the 
cmdline, and thus a change to the x86 boot_params, which contains the cmdline pointer.

  - A change to the cmdline and/or boot_params, which are *not* excluded from the hash/digest, means 
that the purgatory hash/digest needs to be recomputed, and purgatory re-linked with the new 
hash/digest and replaced.

A fair amount of work, but I have had this working in the past, around the v1 patch series 
timeframe. However, it only worked for the kexec_file_load() syscall as all the needed pieces of 
information were available; but for kexec_load(), it isn't possible to relink purgatory as by that 
point purgatory is but a user-space binary blob.

It was feedback on the v1/v2 that pointed out that by excluding the elfcorehdr from the hash/digest, 
the "change of address" problem with the elfcorehdr buffer/segment goes away, and, in turn, negates 
the need to: introduce an allocator for the crash kernel reserved space, rewrite the crash kernel 
cmdline with a new elfcorehdr, update boot_params with a new cmdline and re-link and replace 
purgatory with the updated digest. And it enables this hotplug efforts to support kexec_load() 
syscall as well.

So it is with this in mind that I suggest we stay with the statically sized elfcorehdr buffer.

If that can be agreed upon, then it is "just a matter" of picking a useful elfcorehdr size. 
Currently that size is derived from the NR_DEFAULT_CPUS and CRASH_MAX_MEMORY_RANGES. So, there is 
still the CRASH_MAX_MEMORY_RANGES knob to help a dial in size, should there be some issue with the 
default value/size.

Or if there is desire to drop computing the size from NR_DEFAULT_CPUs and CRASH_MAX_MEMORY_RANGES 
and simply go with CRASH_HOTPLUG_ELFCOREHDR_SZ which simply specifies the buffer size, then I'm also 
good with that.

I still owe a much better explanation of how to size the elfcorehdr. I can use the comments and 
ideas from the discussion to provide the necessary insight when choosing this value, whether that be 
CRASH_MAX_MEMORY_RANGES or CRASH_HOTPLUG_ELFCOREHDR_SZ.


> 
>> I'd prefer keeping CRASH_MAX_MEMORY_RANGES as that allow the maximum phdr
>> number value to be reflective of CPUs and/or memory; not all systems support
>> both CPU and memory hotplug. For example, I have queued up this change to
>> reflect this:
>>
>>      if (IS_ENABLED(CONFIG_HOTPLUG_CPU) || IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
> 
> If you're going to keep CRASH_MAX_MEMORY_RANGES, then you can test only
> that thing as it expresses the dependency on CONFIG_HOTPLUG_CPU and
> CONFIG_MEMORY_HOTPLUG already.
> 
> If you end up making the number dynamic, then you could make that a
> different Kconfig item which contains all that crash code as most of the
> people won't need it anyway.

It is my intention to correct the CRASH_MAX_MEMORY_RANGES (if we keep it) as such:

config CRASH_MAX_MEMORY_RANGES
     depends on CRASH_DUMP && KEXEC_FILE && MEMORY_HOTPLUG

CRASH_MAX_MEMORY_RANGES should have never had CPU_HOTPLUG as a dependency; that was a cut-n-paste 
error on my part.

> 
> Hmm?
> 

Thank you for the time and thought on this topic!
eric
