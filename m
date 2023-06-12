Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F88872B552
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 04:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjFLCQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 22:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFLCQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 22:16:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2058.outbound.protection.outlook.com [40.92.73.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF891B8;
        Sun, 11 Jun 2023 19:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2J+b0vdYqkB6YPFepAuhdjj3DsMboiqoizutHNnV5TzQHGKxjvgMM1YW4OJ+bg+y5uLHibV0Fuhkw4kHdFlHU71EBQorFhbaQFb6xGqvNh02y5ujYwcAnOXS8HrjBG0N8l1T5lJvdTCFljAae0hMSLplm/wpBMxkHQPwX70tQ3NA3jqDR5SWKyDuXLud827M8zeXuqVs2kbjkKxos1Ppq2LuSkwkyL+SramArWXjSgGr28TCB7TUhVlRIqaYdUyxAHMtU1H34hxty2Jg3pCgDs7crnM0MrO0AM1MKAYWVnHUspa5JPBagkGwp7qlytpMqmUn3fQcGHtlu1L0OCT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBLd7KdQCfOOyvK4UM2GCbHHYivuqymItDssFwI4X2o=;
 b=PwNXXscR5iHfaI8E8TJfDGCZCrxP1cHNX45L+mAuIZxFFih9rk2kdWOGcE7Nn5W4hYM7ZOrWJYDaH1STkAXW++1YzjEbb6BFG5HnUFjX0gU4kMNIukU9pkv7Bz7iF3C1xgvR4AbgbmYy/wotRmu2xJ2qAjQ1YQNx8wtTX4GKiekSR2suPBS2kCJU4PCBE26qWI/wec194Ag1wuUAgaLLWjCK52APtmy54Rv1iSb4p1838l5NLy9ekvUsI1Eih5Z7zPM2Gc/+hRsn4NRnjRzcLlZ1ji8wNwpLxWJUuWRYA+t3jOVUh3EXwtyoBCQp9cciWl/HVKe9mMWpTgdVGUYvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBLd7KdQCfOOyvK4UM2GCbHHYivuqymItDssFwI4X2o=;
 b=V7KJ5hCz/YsqCsThlkA3RD4uYQHPUkasqLvG43uR9g6FKEPNhDobmETGX67smTX5IuNB8Xv9z5u79EZxsnf24IVq4bv+vvT43+zNP6Tyr+xWu18TdmqXdq6DAm+sapcUmoSs1OOOVddhcjiraakIi8MPVfv6ddxwqVtoQzdfhB94+7ojbPRtamraD7ihyiiQmhT8q1bTYqcp07M5SxLAzA1twevaPX2Gw0iv72XKaHEg6akTwImnmi5d5Ab/3ZB+2Z7Nt3bgNDvBCEK0IkwuG3OF9yCmTnSHibkaSqXC7MbZNTN+RYmdbcfu/TuDUsgdWyNUIR7V74cpB9FHOnQv6Q==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AS4PR10MB5173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 02:16:20 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 02:16:20 +0000
Message-ID: <DB4PR10MB62612F917CF1BF8FB03927609254A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Date:   Mon, 12 Jun 2023 10:16:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [RFC] sht3x code modifcation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [vZmGsBdGRSCJFA2w9D3beEpA2aYUtmx7]
X-ClientProxiedBy: TYAPR01CA0227.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::23) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <29238a02-b259-e834-a710-22b417bf4322@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AS4PR10MB5173:EE_
X-MS-Office365-Filtering-Correlation-Id: cebf2c11-332c-4bd8-e084-08db6aeb02ba
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcTN7haFzfBqJxKKABahAFkSrLHollO1pN5Va44qWYbHJ/1DtdZxaYefhZzRmN5QjWBJ8PRls/jm6jCxe7xpFGPLagD2s/64m9uhYRdBmuNOvMtbnr5VR2z2YdyTSTPiXiEaYrODDedb+ARhQFqaHXGD1wCrb9cbWLYL/IV79Dve+mBp7KgI+P3p1cLVm0B3D2y8lTYsGUKqovWLKr/PFS+k0bEhkmse8XeQUah7hAaBYxHMrTS6h0MxW3Om3lKWHtu7KW48kk7PdnnYXyuKpyQr22R9k9AfjPseASrScGlX2XocEFR/c4O2sHasf5FN66R9Np+5VGHtUD2FdxB2pkQLpChzZ8hup8DQDDlUGezfZun2tRnD2XYKwPG46o8SpdotxLU2v9hpCMrWYs6GckdTQMVdME+p1qsqBp+qkA6pooyt4iCaEKQjeTQRQcVDyBO0RRbGJGPq8+yh+1ua96j04SXTimig3B4FVps3kosG76MXBqZtSJC4el+/i+VA7ZQh59GZ9++9MiD6aCJEAj4/xEP9FHKbDVIuBng6UIBB3Fsnebh7oCmKgaU7PlhI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG1BaU43SENSTUZGVUhCai84ZkZMbk8vK1phMXdrOGN1Wi8vOWIvUlJDUXVD?=
 =?utf-8?B?NE9LeXI4UUhBc0htZzBCU1plNytEeExCQ015VjF3UnJTS1hPYk5sb3hzSjEw?=
 =?utf-8?B?NXhoa0RJbFd5OGxKaGNSL0tqNG90Q1hXaWZqbTk2aE9UZzFjTm5kTTNvVzlT?=
 =?utf-8?B?dlM0eVhZb1ZWSTQ1M2dlSExaS0RkSitRT3FkcjhneitIcG1MLytsMmI4dlAz?=
 =?utf-8?B?UFE2SlZyZXp0SXJ1cm90Nm1yQXBscmFNcnFrMGxxdllCU0ZLUlNqeVlPbXZn?=
 =?utf-8?B?ZUN1ZmNkc09ENWhleVZkTmlpaTQ2WHh1d0dmQWRSYXkrM3NXb2tCNlh6eUl2?=
 =?utf-8?B?U2xCakdVUS9mR0l2QVRwYWpXSGRQTGZYOG1ZK2JBTjBrK1VSTWhHVWtyZENw?=
 =?utf-8?B?UldTR2cvWGMzTzV4bGRiV095dFowQ1BhUEdHNnNOaEd3V1c1MjJoOFRjbmY3?=
 =?utf-8?B?S1RPQmRUTWUveGM1NTc0L043aFVwU2Y0SHZ1VEdaditXQmNjaGYwUUVDRXU1?=
 =?utf-8?B?RXNyWUExWi9XaE0vL3Q1ZVZnS0pGK1dtQXVlc2Nybk02dEIwVi9qVGE2QW5t?=
 =?utf-8?B?STV5cW5Ja3dZdGlBVXhWUXREN1I2dTNzaHkwYStxSm0ycUFLRDdIVmhtYWg5?=
 =?utf-8?B?enpzMVlNN0pJeExPZUJlcEpUQ3RxcjZtbnZtZmxMcGRzQi91UjQreVpCVUFR?=
 =?utf-8?B?cjB4RmMzZ1YvOVBveVJwTTQ1R2FuMU02cW40ZkE3YmJsUDd2UkFacGlwbUVP?=
 =?utf-8?B?YmZidUVaU2ZKTmFUZys5TGx3U1ZGdmR0ZnpiUmNTYmo5eTBJSkdkRllOTXpZ?=
 =?utf-8?B?NnY0c3VoY0JyUXI2NFlDK1ZEUWxTL3pSdHJFSU5wTS96ejVpLzRzZkdYYTJt?=
 =?utf-8?B?TzYvK3JsZVR6eVF3VUJaRlo0bGhOK2hTVytodWEvSGZiaU0vNmtCdzgxSTRh?=
 =?utf-8?B?RlNLODhpWEhpT3lXM0owSTUwUE5JZU5vUkpQb3d2aVhoNkpzU04yN1loY0dx?=
 =?utf-8?B?cHFlSGFTdkRKYkcwdVRIWXFSczNCK0VWOTQ0SnQ5TFcxb3cyR2x5OGYvYlNY?=
 =?utf-8?B?Tm8vb0RFcE1odzVkWmNiRXFCR3lZSEtGZFVyeHRoOWFCRHpCRlBLdlZXdlV2?=
 =?utf-8?B?RllacmhjcGJiYjllNUtBSzhrTWZoVGZVUTROQTFqckVsWHVGeEdHZzFrZFRZ?=
 =?utf-8?B?bTdMd0p6MXdJVU9ySDQ1QlkxNDhlZFJMbUxRU09mUE1MQVBQL1dLdlM3dHN3?=
 =?utf-8?B?eFkzaWRGdU1VVW1uUThwZDVNTFlpellMdm5ManVCc3RaZFltQitRUVhHb1BJ?=
 =?utf-8?B?Y2w5YkRmVnBBOG5RYlphbVVFUk5CMWJPbC9BTUhQdGQwSjdySnFDWGYrZmJC?=
 =?utf-8?B?cEY4OXFEOUlMTzlCZjhxZGZ6NnloVGdaMlN2aUxSc2xBb0xhVGJETmxIaGo2?=
 =?utf-8?B?eVhOZWs5UFpFWlo4dUx6eUNuM1UrQ2p2UVBoaWt0MWxHdXhyVHBRMy83K3Zt?=
 =?utf-8?B?d2JpNnh4Z1hGWFhzcERLemx6clEvQlVkNE43NCtZVUdXcDFidDNVM1dUYW1C?=
 =?utf-8?B?cmtmdTBKclNlM0xYSkJSVVBBc0U5Nlg5WWxkUjViMzliK3czNkFHRHBSQ1Rx?=
 =?utf-8?Q?npqT0LaNsrWBk3SkznGHDpqIVfOO2FKoXWV49TNJd2ng=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cebf2c11-332c-4bd8-e084-08db6aeb02ba
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 02:16:20.4247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5173
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I was using sht3x driver in my linux device but I saw that it should be 
put in IIO module properly.

In fact, I am going to add medium-repeatabilty and device-tree support 
on it, and planning to add more sysfs interface "repeatability". The 
orginal version did not support to modify the repeatability after device 
loaded.

If there is any comment or idea, kindly show it.


Thanks

Juen Kit Yip

