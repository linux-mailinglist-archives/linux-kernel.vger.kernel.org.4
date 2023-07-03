Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E9745CE3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjGCNJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjGCNJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:09:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE78E64;
        Mon,  3 Jul 2023 06:09:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363Ckbts014532;
        Mon, 3 Jul 2023 13:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RmlWlWDJ9QVgbz0fxC+FOtFIuHq0VIi0amdUYAeMqWg=;
 b=pqzY82wAteI4FowAEoGqg6ySM0mqDP92n2xbvc/RKev3w7O6CbRL5VUdR0xyJq9Z0UpD
 Nanqi+VHPmV6yi1y69zTKI/1sYSZlQqxYB+k2UAt/iAmUDzc1xQZKX7YBQIGZwe6rCY/
 6FbfY5Qe4UiiT2ydcCU6uDA/zid4GhaguFy0bNs8Pcgu0V6R+wO8W5+Lor/Ni8F/dSEX
 5HwDy0EZ+WQwrGVoeGB3Sb/nfEecAynDYFPjYUn96+LCMjm2/goc0cUh3fZt1LkJreFw
 AkC9LcQoyfcka99Qjxvf2LHuuIJm3do0ChzRZCGgjnNgE8E0wk+50T+RyIVUiKpAM99U sA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjar1an2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 13:09:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363BoiKg009663;
        Mon, 3 Jul 2023 13:09:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak92cbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 13:09:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+l+veNcSkbCR98J9zizNcf+QfJR4UyBip2axhM9VwMiB1TBhN4YczAKqPKEHwLu6kscn8s3VW6dk/erTAYcHI+dGqhhZq0GqFkYaqN6gtXn23+AVqiYuu9Ve7LAdpikOdbxi1jef43/NS0BihDNPRPyS6UuK/XCEwguh6E9234uzw2rFP7ULFfjOABeVWXYqakn+KYC2TraathsnSfHcly6icsugm5KxtuJs2eIBCO5AyBdr07FSeumpnVU76d/8/XXboh2/oORrN72SUuhsDC0qPFenDz5mAYQGYMEh+5h5X2T5XorSuokOpZpwPJ0hl0FSubLl9PzgBlD1hBqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmlWlWDJ9QVgbz0fxC+FOtFIuHq0VIi0amdUYAeMqWg=;
 b=RiTpebNYz0tCo7QkraDDGNbQF08K7Mc7YI/lOClsN3fHT89rgNFReoh4ZUHlY8KNmhHJWXcaMnm1r14DdfiMkU9lIwubiQ/5exGolgWSzz1s10FCeEbBbtWtvvUw2IYaTXP4+Y7NqxZudikHRpOocFF20ZuuOaPxUQRlg16+9GD0oH8pHSlufnO7oZXKtFxAU3boR8K2PhotuRdZokHDPGyGVne8+6uqtbQhw7WvHPNv9o3Lt7zJYNl1/TvyyP81TFIhzbVX/kAKafELCzuEtE7Vj3rgASbKHtVkqPD8WbMiPOfucpuUJesU2L+wEs/5mdsS6uRZT7QNvUFcjzt15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmlWlWDJ9QVgbz0fxC+FOtFIuHq0VIi0amdUYAeMqWg=;
 b=ICT8zEt50YgYOdT9uU2gcPbm7fUwYdP35KkDPXmelFRHHW12kJZxeIIJSit+Qd0huSCf5EiTRnnKfj7bQSGPblwNEoJSWMw2KLIFaRmefIGRSTTnJ+jBfmaF9+lcgkRWkmBS622X+Q9OiIkxMKPEMqViByEluNjUJQwWbqxffp4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB7339.namprd10.prod.outlook.com (2603:10b6:930:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 13:09:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Mon, 3 Jul 2023
 13:09:10 +0000
Message-ID: <bb828dd4-3c22-7383-008e-ab4f860ed686@oracle.com>
Date:   Mon, 3 Jul 2023 14:09:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC 2/9] perf metrics: Don't iter sys metrics if we
 already found a CPU match
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-3-john.g.garry@oracle.com>
 <CAP-5=fWB9H0KWrXYouepUiAbnfH3u29XuRVN6KXVw3CNbD4xrA@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fWB9H0KWrXYouepUiAbnfH3u29XuRVN6KXVw3CNbD4xrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e02f5c0-d1d8-40c4-9485-08db7bc6b098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAIpXSQIZIfU9MYKAsra3NUJ61+oGXhMH7YL710jT4CGzrEiGysMTG9ulibbX3dm9qd3aDw5BLL6luyJ4ss4I1jlV705IACBcDwofEadSBR1YivdjMrBFvV9B8vEd1Up+dF+BWuqDjmQg9xVDKhEA9b/KWnLLei4FVmOwW6hZHGwdf//wx05RRa36zs/AlR2bgCLwxIh8/TOGMle74xYklZlD1/Nkxc3xxbjIUOnVaZj/1uVqPDFP1KNChqhBw+KbjXOo7z+hkB/gHmVJZbgSlWJSou9osp2EywaWFfNKPj+wNZv4VkeuNiRpqSGhg8CfXOlt5eyBNbqUtEAhicQUarUx0Px7/MuQzWY4i8Qru9uxxrMxtqLKdTcS5G7cwoPvD//cHTYwqTBnws1eUcrVe8I0ro81XggnQ7rFehrM7syWoQDfGb36meYbI484JjuubzCPUtt90qCtljCkKRCQYOzwQqqVxcteNU8VVpq5Mtal9xjiNJ2QfTBNTeCIi0E6+oWMGrzdpqgUNTZrZCUWj7X1OGtIHgYIVt2PMYulc9reXplwIlGte09P5zzjY6uIj4c3Jxfs697YwQvVHVEPoelA23J1RUxIi1lVr4x+w+5O70/1S3W8Ook7tWtGIgWlenszevpPc3aFF7IC3ZEDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(38100700002)(2906002)(6486002)(36916002)(8936002)(8676002)(36756003)(41300700001)(6666004)(7416002)(5660300002)(478600001)(31696002)(53546011)(6916009)(66946007)(186003)(66476007)(6512007)(26005)(86362001)(6506007)(66556008)(4326008)(31686004)(316002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUYrYytSL1J5eEFiK3IzbXdHTVUrdWhKWVRtNmJYQktINjBEZnY3RDFKQlp4?=
 =?utf-8?B?NjBvaXo2ZmV2aHdpQjdLRzlleUt6VGxIcENvMDlmTXJSeTVYdE5rZmxWRzNR?=
 =?utf-8?B?WWRZdHBUOWY2aUgyRDVRN09qZ3VjL2tzakFUVUFQai9mT29ZcWJuMEM4cURK?=
 =?utf-8?B?b0crWUlnNC9Xa3dJTU9WZnBqRlp5SmQ0c051dW9hUDkvMGM0eW1XU0tBQk01?=
 =?utf-8?B?WTFVSThVaERDbjFmWnhiY3VhbkxKeWZ6bU5PWnJuTytIWUdNaC94dHFoN2FO?=
 =?utf-8?B?ZmNXM1pGV1QwQ3IwK2ttMjV4U3VHRWdVV1M5SE1JRUZTcWRzSVQwSUJIYzdG?=
 =?utf-8?B?dC93UitkUWNPYXJWZVZHMFpnVm05ZUpDYldmeWQxaGYyS29xTHpUdWpmYUk1?=
 =?utf-8?B?VmZSa1o4Zkg4NFJFa1BGY0pBU3BUeDJBc1NUS3RjUUhPZnpiQ1YxVlZIL29C?=
 =?utf-8?B?QXJHZjJWV3JEZjRlVnRmRjZEUnhCd3Fnd1BCSjFHdXFWclJraEJ4ZHQ1WWM4?=
 =?utf-8?B?b3dZNlNMQTVDaEVDRTFYVUduMTM4Z2l4UjlBcjlMTytrTnBNQjJqeEpwZ3VW?=
 =?utf-8?B?aCs3NFlCQndyVDZ4a3M2WXQwbzliN3V1dHlJTmx0bHVIRHNFQ25rWmNVT1NL?=
 =?utf-8?B?Zld2TzYrVDVPalV0Yi9NSUhoblNybzIrMXN4MmpIKzNkc21MNVk3Zm9tdzJu?=
 =?utf-8?B?Z0VJQ3lxYmw2RWpOMHNDZ1czU21IblVBTW5ES0ZMZmhYYUUzNy9adlc3dlha?=
 =?utf-8?B?YWdLa3hURjJWa0IzN0d1KzFkNWNtYm0veWVodUhOaGdpVHlIeGc1d1BKUFRV?=
 =?utf-8?B?UHhCdlhpbmpsYjlXSmhLZVhYaW81WWtESGVYMnhtcXl0U2lTQkNWQWV3OFk2?=
 =?utf-8?B?UkJqeUxBYnc2RzRSOUsycjdLZWtkTWdrYmtNTEJpNlV0R2NQL09MOFZrdEto?=
 =?utf-8?B?WkpyOXVhRGRreHdOQmtUM2QybnQxeTl2d041WVhvM1pjUi8yNGJ6YkpVZjVh?=
 =?utf-8?B?bUxQOGszRy9XblE5ak5UZHcvV25OTTQzWE50dnlzNytpS0I4WFc0VjN4UkVi?=
 =?utf-8?B?YnRzN0IwOHh0Yjk5b2tFaEFjS1RaWUpYY09BeWl1Y2RYbmdHNWFRaUpZZlBr?=
 =?utf-8?B?ejNtRWQ2MUhiTXJCN1pWdWVNUC9OMWY1OWVlZUFBNVQybVNTR2x4VHdEdWlR?=
 =?utf-8?B?YVlzaFYwck1vbTYraTJyNkQwNXpKRzk1cm1RMFZSVndHcDZhRFEzb28zNHhQ?=
 =?utf-8?B?MjJnR0VuSUNzRk8zNUJ0a3RoaWFjR1d3MmFEODlMaHd0cGJHL1dyRngzSjVN?=
 =?utf-8?B?ejhTdmZycjB5UHFpdThyTmswOXd2TmwvVUlRajZDSmFiYkJBcTZsRmppMS9T?=
 =?utf-8?B?ODJpdVhOS3Y0c24yUnVrOVcwdm9QbzlTMFJ4bHRWVGgyMlo0UG1wMk81VUFL?=
 =?utf-8?B?OEdKQTJQcWZ6T2U0dHBGbGg2L3F1V1M4SWg0L2paYWZXT3c0bkNWTmNLTzA0?=
 =?utf-8?B?T3RGSHp3TTUyMFFFT2JieVB2bGloZ0ljVzRoNnAwYWxYM08wem50NE9tSEJH?=
 =?utf-8?B?TU5HMGZMY2pNeFkra1pPemhDTjJBdmtRVS9NL25kbWxlZTNBenJRTms2bUJ4?=
 =?utf-8?B?b0ZoTU9xbnQ4WVhHNU9pekZ5VTN3MmoyNVdhbHkxSXBtQS9zZVBOTEtXR2pl?=
 =?utf-8?B?UjN0RjJoQXR5VjJoVnNocWRVR1dzNG92ZU13Vk9LQnM2cmR6ZXoxZDJHOTkv?=
 =?utf-8?B?QmJpbDB0d0grTEZZa25GNnlXQXQ5dTUxQ09ya2NRWStnS281Y1ZlVnVqRUZv?=
 =?utf-8?B?aGtROVRiM050bjl0WGorOURObTBoQ00zZ3Jsb1FMcEVTZUZSRDdPbDNYcWcy?=
 =?utf-8?B?WTc3NTlkU05WdStNOUFLd1IvVzBxVGNHaXV3dlpyMTd1VkVpUFRBS2JCSDc5?=
 =?utf-8?B?UzN6VWVudnZibStRdSsrR21tcHRKdVNKNHg1U1hZNFN0WC93UFJBRzhUcmRW?=
 =?utf-8?B?NGVjUjR4V2NxSXpGZ1RFY1V3YkEwSEt4ZnpDeEg2MUhreEk4MUZNRmpHbzVE?=
 =?utf-8?B?VkhWM2l4ajlEN2djRVVDa1NwbmppOWtoZEhtc21MemFrWE1tSmxIZFFqeTVw?=
 =?utf-8?Q?ae4RLlk2YIZy6rlk3eKBuCjcR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VzRHUnBUMHFycVB4U25HMWxYeCthc2NKQXNBSWtQSnRrS3hVWWpRd1JZM09m?=
 =?utf-8?B?TWdTMC92Tlk0QkZyQ3pXdzZDNDRLNHBkSkVMaDl6VUdzOFBaeldTN1VFNjI2?=
 =?utf-8?B?MFNQVytkYzBLM2x3OTA3MEc2RFdZaHdmcGpZTEZ3UmVJZTVqOTlmT284Uzhv?=
 =?utf-8?B?WUkvS3o4OTczZTBuMmZad3Y1Z1F2OU1kcXZ2VExEK3JCN212aDZsMitPZkp5?=
 =?utf-8?B?RkxsRWdmckpkZndVelh2YUt6Y1U2YnVSbDZjdjdDT3R5TzZrZjJwVHB3MDFq?=
 =?utf-8?B?cjAweEtYUUVtRWhMVms3clMvK3hhcGxIQ211ZVFGVE44a2hSWnQzV2MvYlph?=
 =?utf-8?B?Yk1mQlZNY1kzcWFydjRlZnI3a2FkZjM0ZXNsTFMxZkJiWTBCeDdMaHBIZS9V?=
 =?utf-8?B?SnRTbXJ3MG9qTUtxd3JvQ01hOGlvQUV0dGlkSUhtajNIandDZnRBNXF3b0hl?=
 =?utf-8?B?emhKNGcwMUJrTkNaazBoRHMxS0lUM1l5VFNoMmNRUm5kU042ekt4bHk5U0VS?=
 =?utf-8?B?TEpmQ0Rmd2E2OTY5eXZsUHdBU25vbXNlaUxyOUduaWRqYlVFYkJiOG1wbWlE?=
 =?utf-8?B?RGVnZk5yNkJPcVprWVBqbFhIUU9tSGRtRzVDUVdGYVlwaDh4VVBjZXE2TnZF?=
 =?utf-8?B?REdpYXA2a0txNHZ4d3RSYUsveWtJUjB6MmVPdzRJWm5XSXdDZElsVU04M2Rs?=
 =?utf-8?B?MDREY0xFR0J5N1czeWhPZHdiaUZJQUFpcDJGcTZUWmhLdGgwRjZIL3NJaVBy?=
 =?utf-8?B?NU5lNkEramRONThvckxQbVF4Y085OG4vb1pSUzIzekhYU0dtdVBFU25vM3VI?=
 =?utf-8?B?WHZ2T0RQN1NJaWJ0cDEyanNLNUhDa20rV3JHMlRHTUZoQ0lycExkZm1pSm9s?=
 =?utf-8?B?Z0VtU2M3UGVmL0w2VGdNWGZMaXVrK1MvdlhhZDQ5eWQwY0w2RDEzYUlpMFND?=
 =?utf-8?B?eVVkSzRBakJ0UjRtbzJSb2pxaUlUYVJzdnBOblZSZ3ZSemwrbmljZFkzT0JU?=
 =?utf-8?B?amdMdWVwL2R0cmhwdlRnNFVPbC96TEpYelN5bUJ5aklYSXJIYVZXakRWY2Yr?=
 =?utf-8?B?Rk55RzFrNXdvODBYYjBGNk5XaXdWWThTQlBjaVNmYkhZeW85RGlJdU1TL2xG?=
 =?utf-8?B?eFpKbFA5bk5DdGFDNGV0Y1FMc2ZlMmdSNFdCZHZEN1BMZDNnQldDTE5WeHdv?=
 =?utf-8?B?RWRLd1Q5Q1ZHSGxaQ2hqc0pobDN6c2ZNaVNkZVYxVEwvYUFXa0N1cXgwZkRE?=
 =?utf-8?B?TDNubjhJeVY1NjMxcXJ3N3g0bUxnY3hic0ZPQzAyckhmTk5lVkZkRVY3RllD?=
 =?utf-8?B?UGZ2N2dkMzhEZE1QS3k5c2c1UURzZGRPYVRwaS94Q3JuYWdMeUtuWm9KcmFK?=
 =?utf-8?B?S0tMNFlzYmFoamZYVVg2YTJLZUJkMkpFTW5LL2tMTG1hbTh5Z1QrcGRwZ0Rv?=
 =?utf-8?B?ZmdreEhVSUtRb08zKzcrcnQ2YmE3MTdEcGZxRDhRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e02f5c0-d1d8-40c4-9485-08db7bc6b098
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 13:09:10.1899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8VHg1nGuk9yqHiYfXdXj6RBcIf1iu2RGd0kZzBa36NltO3eSSECzSiNqD23NU8DGsU2bUndZqXwT2bqiA+e9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_10,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030119
X-Proofpoint-ORIG-GUID: JIxZczyvPcyTgQ4lVfDWo9ME_NeDgyWN
X-Proofpoint-GUID: JIxZczyvPcyTgQ4lVfDWo9ME_NeDgyWN
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 18:41, Ian Rogers wrote:
> On Wed, Jun 28, 2023 at 3:30 AM John Garry<john.g.garry@oracle.com>  wrote:
>> In metricgroup__add_metric() we still iter the sys metrics if we already
>> found a match from the CPU table, which is pretty pointless, so don't
>> bother.
>>
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
>> ---
>>   tools/perf/util/metricgroup.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index 4389ccd29fe7..8d2ac2513530 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -1261,6 +1261,12 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
>>
>>                  has_match = data.has_match;
>>          }

Hi Ian,

>> +
>> +       if (has_match) {
>> +               ret = 0;
>> +               goto out;
>> +       }
>> +
> I think this can just be:
> 
> if (!has_match)

But ret has no initial value

> 
> However, I'm not sure I agree with the intent of the change. We may
> have a metric like IPC and want it to apply to all types of CPU, GPU,
> etc. If we short-cut here then that won't be possible.

A few points to make on this:
- Currently we don't have any same-named metrics like this, so not much 
use in supporting it in the code (yet).
- Even if we had some same-named metrics, I am not sure if it even works 
properly. Do we have any uncore PMU metrics which have same name as CPU 
metrics?
- Further to the previous point, do we really want same-named metrics 
for different PMUs in the future? I think event / metric names need to 
be chosen carefully to avoid clash for other PMUs or keywords. For your 
example, if I did ask for IPC metric, I'd like to be able to just know 
I'm getting IPC metric for CPUs or some other PMUs, but not both.

Thanks,
John

> 
