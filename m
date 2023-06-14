Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DF073067B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjFNR7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjFNR7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:59:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120F10E9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:59:29 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EDFdFG011578;
        Wed, 14 Jun 2023 17:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zNSL/XWVwwOUthYe6RdTg+H7LVM5Xj6Zsx3mY+W1EuY=;
 b=dHIJA3W6ME1COeEYqW2Wniub5jKYmArK0GZu03X2IyHudnKrp7N388mObGVgaDhRZ29L
 veQAB/f+Z5P/EkYY/gEjxUCKJCN7m0UsA0NDdw+CxDu1lfMKCH9htp2RAStohBdvplVn
 aRptnVYI5ys0ijSENChdwVkdagIxx09Pt/qikj/f17iuil3AhcsK8PkOfzSIKiWCurcw
 5+kkdTjCtxV+9gnYokZSBNGpZDgtN99XS/yH/VXktZTZYX5a7V/7AyBapf7UweRLbzZA
 w/ZCEQwb2rMrOML8Av2AfZzYQFQ6wVrRvPbmpMxOIHaaom+WGttWomauqbJrTDNq0FQS Mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hqur9b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 17:59:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35EGeq5L009049;
        Wed, 14 Jun 2023 17:59:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6660e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 17:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QshzApt648K4+N5Wm8snnJBRNGw+fwe8VD4gCDj3kt7InLT8hN4cHl2YAoh9Rj9lAdLBBBZcoPm6KjYLrudjjXuGNbghBRDso3HmhQSTG0IOPBCkgMig7QmGkO0RN8HqkNRrdw4CG0LoX/kP9diV+3Kcj2bsZluM1HPVNQyLWoRNPhG+/8yb3kj9lFOBQaflsGB/nP6O3ikT2BjqLz9n5tFJAUZq0qYoYQo8S6L5fVoYVXFywNlnDtrso0bsDQb56L/l7hKMyNmMYQ9BTH+3b4GV9U43EDrf4wmiNeDt8UyRNQt4Rp7zP4o7QEAbXFD3R+niq/9aP9GeQ2PTHctiqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNSL/XWVwwOUthYe6RdTg+H7LVM5Xj6Zsx3mY+W1EuY=;
 b=ODc7iZg+3zNZoaaS9v6R506zzy2ofLGd6GW/NSeGkD6OuOo/5HtoLYUQNkkasP3T9kBvFzuZkpnBNvnBOuc7P97++0zPxwdpaRNUMq7nk9H0gYfMqsVuhl+cL1xwnJ2bSP7LyfmV97WifqhON+wv9p5YPldyxSLi64FqlnzzoH4gWOBchkvxdCfgLiMovYh0yPjJIzixK1hvW83prX2+sn3U+qgHhSbg9mkHIfvdMxgAUujG1WPSlQyG/2i7978Tn3cvB4aTvVd4icRDux8MHC0LmieUaQDnXJkK69WJug3ZnRGXV6m10/QBy/xsM4rT1/ruwv3CvqZ3blZxgjuwEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNSL/XWVwwOUthYe6RdTg+H7LVM5Xj6Zsx3mY+W1EuY=;
 b=i9j7W2tRuMWcrmeqoV8XPuuDcpmoRJIZP3dYZ/XLZPEihscBSQkJndcdC94w78apxU2zwiFoWh6af4ZAm+9Hjomc6AnFS0rpQuovTlqjmiae556rleOG9QwPWjDL2CIFuovL4moj4qlYDbqGxXtFFafClR39ObSpPkwDzYdIyZs=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by MN0PR10MB5959.namprd10.prod.outlook.com (2603:10b6:208:3cd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Wed, 14 Jun
 2023 17:59:11 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Wed, 14 Jun 2023
 17:59:09 +0000
Message-ID: <53991bdf-bff8-6d94-77dc-c8aba70eeba5@oracle.com>
Date:   Wed, 14 Jun 2023 12:59:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Can vhost translate to io_uring?
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
 <20230605151037.GE32275@redhat.com>
 <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
 <20230606121643.GD7542@redhat.com>
 <39f5913c-e658-e476-0378-62236bb4ed49@oracle.com>
 <20230606193907.GB18866@redhat.com>
 <cfbf1a0d-5d62-366f-f32f-6c63b151489e@oracle.com>
 <87mt12oa25.fsf_-_@email.froward.int.ebiederm.org>
 <f65f9809-7f52-5bb1-7e78-f22b813500c2@oracle.com>
In-Reply-To: <f65f9809-7f52-5bb1-7e78-f22b813500c2@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::21) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|MN0PR10MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfca5e9-1cb9-4d00-1b8c-08db6d010d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTxfj8ORLmgPGmdOt7u7a9K3YAl9+7Y5MBp1Op2HZoCrjpu2O2ICQte3dL7luWO9Ze5u7QONxvhXMo1BPYFg9e1W3Y13t+8M06GMs0fZUhr87G0kTw9N5IKbbcAHV+JLRIXakxnLDNZQn0AdxTL9DF/5iKQh6bMXCl/X5Sm80N3GeDmg3pm6zNbbFEMXwKVzTGqIL/ij4PxkrLDTmOzcXHGOHH9DD56kZ51XBbpN1+yyR0ZVcD343n4Bj9KUGtc1ojP8KNy9jKdTLb+i8gCNR539gQCbopnEhbAFuQBPW1X7G5UCQ3H2yNDhq8TnXkpFPUBbF0RUcWm634cedNnW4jEOnn45pubaLuW7Z7ObbqP6HBkbh/Ymf0vAWCYFucXz78LZys8Gf+bTc/USvO/5Ti4HGFLbXTIIyoOe2IsFm2BLuFcteJ+PAQDQdM9prW7rXqY9XL0XgrraSyrKyf8dN4LlE5ThOgKDqm7eWzoJXMpVnYb6+10VM15GhSUGBGVTEJcJ51FSeHpfrdR+RTiDsJWQvukTKT17+ErUsm/GzdM4BMckW577t6QWW8Q7mbhnz+le+VuE/Bcysfw+FFZ5nmyMz4IxnPX9EO0Kf5PTytJxdaFEBy75vBF3CTqchGG7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(31686004)(6916009)(4326008)(66946007)(36756003)(66476007)(66556008)(186003)(478600001)(2616005)(2906002)(316002)(8676002)(966005)(41300700001)(31696002)(86362001)(6486002)(7416002)(6506007)(53546011)(8936002)(5660300002)(26005)(83380400001)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVFiS01INHRyVWVuSG50MXVueTZ6elhaeGJ5TUFWK3ltcHh0NHVaT29mOFB6?=
 =?utf-8?B?MytDNDlqRjZLNDU0V0tGRVNRbUFmSDA4aXEvM0Y1L1hNZThjeDJDTDlibjF5?=
 =?utf-8?B?UlA4YklIWlNEZFdnNWtLZW4wdEVXQXBkSXhzVGthSWFCcXRlQ0hyUEJzaERP?=
 =?utf-8?B?Z25Ma0tMcmR5Nmtjd3Z4dDVTWm81dG1CQTlIVUt1WGVCRHlMNVhNYkJtVzlO?=
 =?utf-8?B?ZTFna25sT2ViM01WNldMdzRFQXN2Tzg2d0lDRXI5TzRwYUhGaXhDZVpOOS9s?=
 =?utf-8?B?Q3Z4L1E3U0lvOEhLajMvZ2tzcHh6Y3p1Q2FDa21SQTRxL3k4cGYrbi9WY1cy?=
 =?utf-8?B?ZGpNR3pqZ21ubkRlWElVem9GUW9GN3VMNjNUdzdBZXdha2NqS1JZWm5RUnJt?=
 =?utf-8?B?UHY1QzNHeUFMbkdnMWtmWERKTlN3T2xrWWRSMC9yRUI4bllKNSt3cERLcjR3?=
 =?utf-8?B?amdlVE1rby9UMmtXMWZPWmdac1hnVTZvTC9PQ2s0VmF0WGoyako5M2ozWmtE?=
 =?utf-8?B?Q0VGcSt5eG8rdHFrc2xpN3grZlYyMHpNbzhDaEcwYXIydkgrc2FlSWM1K0hp?=
 =?utf-8?B?ME1IbVAzSHZ1RHVjR3ZhMUJpSzNPeUZVQkVRMTRhaHFJbkx2cS9Ta0Vud1Bz?=
 =?utf-8?B?OXdRS0ZaMElwUGhLdHcrMzZwUHVqVUs1ajFZV1hoY3RxU2kyYm9DWHFhTVlm?=
 =?utf-8?B?NG14VFY0cU1WeHlNVWVTd0VBL2VTRjQ1SWRMVlhlZVFrZGtIV01CUkt4U0sz?=
 =?utf-8?B?UDBzSS9uUFFvbDVwRENWQWlBeHo2bDA2SDN6VGgxRkxuYUpPTkNhMEp2T0dI?=
 =?utf-8?B?c2dYVUNQaDZ2QVl4UEJ6eUxiNXFOV2dsb2d6ZTVUQjBtcW9Fa2F6UWNOaDVm?=
 =?utf-8?B?eFBpNTRxcndBRVdLQUhjK2RBVzlFaUFHSnZ4K2swNHBCK0Nobk8vSlNUeHBL?=
 =?utf-8?B?L1JhcnJCa1hDR0FOVm5Uc083QW4yRlVud0grY3BxWlQ1ajJVbmlwRmUwT0ZH?=
 =?utf-8?B?ZUR6NTFlYk1xNmJGVVptaGllOWliVC95T2JYcDEwTWMxbU1VUnh1cmFFQlhK?=
 =?utf-8?B?ME05ZDVBSDZpRXdIQmxRSmh2VytNR2tCcFhjcEg4N2hHYTZKNmdibDhGSkFP?=
 =?utf-8?B?TTBDZXhGMjViT2hWZW10MnBER1RKTk1zdXpXbTZRR051WHVZMzYwdlpXOFFo?=
 =?utf-8?B?Y1pwZlUzK3dUN1VsZ2wvWk1zRUNkQkdzRit5M2hYR0kzNUlVekpmQ2hDMmVk?=
 =?utf-8?B?MDlaeXhKczdkOW5WV3N1bkpEVXRKek9nRnhFQXB1K2E2VVloWnBxcnZvSFc4?=
 =?utf-8?B?LzdsSE9lS3oxckN1dysrbVA3S2ZOSituOTBXVmdvQ3IwMWcvbHlQMDMyZjYw?=
 =?utf-8?B?VTdxMG5IZG53eWM2V0xxUE1iOTVYTjlZTmtvU29hZnhURmFIWEhRQWY0aUg2?=
 =?utf-8?B?aDNJSUp0dmtRWUJXSEFXWXdlSTNSRXdIc3hKQzJ5WitpdTNad1RLazI5LzY4?=
 =?utf-8?B?S2lnMitybG5WU3drd24zN0NwbWljbmJVNVJ6NUxXN2ViNjNpSTRpUmZidnkr?=
 =?utf-8?B?czNFMFpXY1RaNSt5aU1HNkZXSFVOQ3MxeklqRy8zQ0tYMCszVVlMRFJGSFhW?=
 =?utf-8?B?dnhiVzBLcTZIWFU5MXVrYktlZUNZVzVXKzVXNHBncTRYMTA5ZEFzZ21XdmZs?=
 =?utf-8?B?MHpqaEk3Z01GUE5ZTkIrcGN6UHArWTF5WFVWbTlmQVRWaVA1Vm9taHhmVEpx?=
 =?utf-8?B?dWFueUN0QkVXUTdsdThGRyttZGRUZDE3bHRUcEZuWnFnbjdIeVV5VFBhVU0y?=
 =?utf-8?B?ajlUdElFckpYcjdjMUczRWFUamJrTm4xUHhScHpPZ29vN3FkZlREVEozcmgx?=
 =?utf-8?B?dk9GYWpKK2hzaTBFQUdRRDNEeVhpdFBVamdYMlVOVGh5a2ROLzY4aHVOTkhM?=
 =?utf-8?B?d0JNODRHYTdNQVdEYTFUVUZiSGQwZWhiTmtjWGVRbnpsQVRkMkpjYks5ckRR?=
 =?utf-8?B?bXFUb0J3M3pVcldKNmZ5dW9pSDduTy9KODUxN3BWRTdlZ3JKTnN5eDIvZjYy?=
 =?utf-8?B?RWVrUjNicWs2QWRETFJZYzliTTZuQWdDMXhPbElRdHNsU05oWEhEMGpzUlVY?=
 =?utf-8?B?Y1FpdGNkTWRpQWZ0NytYR0t3aXJIOEpiY3R0ZldFSmpzQnZURmJFY1hxSWx5?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UDh3Q1I0MzVhUjFhZlZ0TlowelVyUlhIS0QrdHgxQ3BvazRDbjZPVVR4V1dZ?=
 =?utf-8?B?akVIWUFXc0o4aHVCQzFwVm16L3pINS84dXBDdFJEeS9uYUQwZElhRXBmUEJX?=
 =?utf-8?B?M2U1eEhrY0NkcUdpbS8xMmozYmtqc2tDUlU3M3lhdGI1K21rMTZWSzZCWFZC?=
 =?utf-8?B?UnMveDAwQ2RmVmV1dE5hWjBCOXZ0cmgzSGRjTzluT29LMlRTQzBDR3dpSHBE?=
 =?utf-8?B?WFBaN3NIODFpMk52OGZiSnZKOHhLZVY2U3FTSExhQXh6cTZJS1M5VmFQRW5E?=
 =?utf-8?B?bnhrSW5NTnplTjAxeGJJelhja0x1UGR2ellCZjZNeGtkN3FLMVRCMlVUTDkx?=
 =?utf-8?B?Q2taSTRpT09tNTdrZXg5TndMYXkwNXA5Ty9OTWhobjVYSlRNRDNyM2ZDMXkr?=
 =?utf-8?B?WmVqU3RIOXZGVy9GYW9pWmdJdmpSUEgxS1VnS0U3bUJ2ODBnSFRmNmQ2Vm1x?=
 =?utf-8?B?dTBTMkdnMlRoQnVabnliWWVic3BneWdWVW1TemRyMHpaSkRKTTF6V3kwS2l0?=
 =?utf-8?B?amNlMnJzQVZkNDBVMmdmRVNNeWJ5VjhZeFZRcDVHbFZzTmpUeEpSRDQrV0hQ?=
 =?utf-8?B?MjM4MDhYUXhLQ0ZlMVlsTTkzOTh0SjVEUjhROWlDdWZ0UHhzZHV5U2M0UUlX?=
 =?utf-8?B?alJoNmNwZVIwL1cya2xMU09LKytwcVZwUlBjcWFBYlhUYXhkTUdlOUowTm4r?=
 =?utf-8?B?dGpHZnBzOTlvZGVWTWF6U0liZGRIbUdIMnB3bEx4RTUzTm9RWGNoeGZxV0pa?=
 =?utf-8?B?Z0pXTW15WXhzYmpEVmREOVIxUkdTQnBjOHljQkt3YzBGNmVuOEJTYmhhQ3B5?=
 =?utf-8?B?S2FPZWs2MnIxUGovVWFuRjhPeldaT0NLTHozTHBMa2gzajI2eHhXWEhCU09n?=
 =?utf-8?B?cTZZQmxISEsyNVAzcWdKNHFPNXdQSWZBU1BIeG9SZUtjNFFjb0pjTXI1eW8v?=
 =?utf-8?B?eWhyaXJBc0U2cVZvMTQ5NTkySDJuUEs4OGxuNVVNL3pJTkxPSHYwQzJsUHFI?=
 =?utf-8?B?VmpSRktTaDQzMWVrSjlFUDZOMkRHQWhvUFFNQzlRL0FuQ0R3TUUrRHhxVGlI?=
 =?utf-8?B?ZE9NeDltWjVpREhXT1YrQWVrdy8yRHlCRjJPK3YwOEIyc3ZsVlptNEZyLys2?=
 =?utf-8?B?KzVXeTVabFBuVmRDM240TWl1VWQxQ1VxdGZRMnI0bE5zSEM5UG9xZDFPUTho?=
 =?utf-8?B?NGJJdlZZcTh5eWpkQ0oydC83Wk83THFrY1ZYY1ZscnhPbTRDOVVPbFlDcDZQ?=
 =?utf-8?B?UU5uNUtjUzYzYVJJRTVQejJ0UXQxZy9qRktQOVUvWFU1RWNXcnppekRPdHNG?=
 =?utf-8?B?RU1vOUZuUkxMbXplTkJBOXR2UnpNdUxhOUpXNzdRdGRXSTNJdm0zYUdramdX?=
 =?utf-8?B?YTZVbmhYSE1iNEwxQW5YYVJ4cE41ZlBGWEFaanBDZE43NFdQRlVsZUtEUzg2?=
 =?utf-8?Q?Y9vu5zC2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfca5e9-1cb9-4d00-1b8c-08db6d010d99
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:59:09.5341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wDX6oeWxgO/+4B4BYyjvKWhDHkZH1suDuZR+wdG8A0w4HpidKNfsctiwR1vzXsBTmHeHuRY10w3XASrn87VHVgg+rw38jG/5qH0FnsKICE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_13,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306140157
X-Proofpoint-ORIG-GUID: 6y1S32Pa4BiY_i2GGAiMy-aa0UhbkIdQ
X-Proofpoint-GUID: 6y1S32Pa4BiY_i2GGAiMy-aa0UhbkIdQ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 1:25 AM, michael.christie@oracle.com wrote:
> It would be nice if the vhost layer could use the io-wq code as sort of
> generic worker. I can look into what that would take if Jens is ok
> with that type of thing.

We could use the io-wq code, but we hit the same problems as before:

1. We still need to modify the vhost drivers like I mentioned below so when
the task gets SIGKILL the drivers fail instead of running the work like
normal.

2. We still need some code like the patch below so when the worker task
exits and is freed the vhost drivers stop calling io_wq_enqueue and
don't access the io_wq anymore.

3. There's some other small things which seem easy to change like we need
to create the worker thread/task_struct when io_wq_create is run instead of
io_wq_enqueue. The problem is that we can queue work from threads that
have different mms than we want to use.


I've done #2 in the patch below. I'm almost done with #1. Just testing it
now. When that's done, we can remove the signal hacks and then decide if we
want to go further and switch to io-wq.


> 
> For vhost, I just submitted a patch to the vhost layer that allow us to
> switch out the vhost worker thread when IO is running:
> 
> https://lists.linuxfoundation.org/pipermail/virtualization/2023-June/067246.html
> 
> After that patch, I just need to modify vhost_worker/vhost_task_fn so
> when get_signal returns true we set the worker to NULL and do a synchronize_rcu.
> Then I just need to modify vhost-scsi so it detects when the worker is NULL
> and modify the flush code so it handles work that didn't get to run.
> 
> 
> 

