Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603EC73BA5A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjFWOkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFWOkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:40:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592461B4;
        Fri, 23 Jun 2023 07:40:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NAa0i4032096;
        Fri, 23 Jun 2023 14:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xSlQRiDDM0O0dahPwKNEzLpmgAC/3zzaCoud+q66i+8=;
 b=nsVpqPWghB4jxicslIBpxURFfnDv8tI6+XtnJzrWw0b1jDyRAxSG0J+PhRQ5UrYQwBCY
 1f46zlvbo9YPGGaRtgPUFE1TK5M63v5/Ep1ugImu6BRAB4jPt5Jjt7pCVt0AMQLcQSB8
 fwMIQM4A8nEdN4NONHTcg/MPynaIuIFzLOAFcWa0en3LqF1Lu77KfV3pCdVM0EBlnFeQ
 ghOl4oOdtDgGyCoQ0iiY0WInYmLWsjBRjfy2cAo2eJfH/MWlF5PYv4JBq3rbpfLiYuoF
 KPLBxNGFaGErfyEDikkg310o9yaxzAeBlVapbzaRrRX3uTmlJgTxS3MasfawxRAsXXp4 1A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dv38b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 14:40:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35NE6bVf008403;
        Fri, 23 Jun 2023 14:40:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9399eusr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 14:40:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGeJ8hqUViNBRvcJhmELv1mu5b/hrl77jjjWJER5ygt4RrKqLeH4UXujC6oBnVHayyOZ/alhJrn/vyBQbX4OruJtz6kLA6FtpdykOzivumw6IpS67/oS36ooKB/pNB/iO3yh6am2RyV4qwjYESv0aGHQ5cA16dOt3IeVBBsAn67Q8PS1FpkKVXHtUfjVeFWju7QV/cfhYfKjmDzqm+n1C1QQWi9VhJdOl1gLTOS6QcsQbIoc2wrXLlwjf3sG8n0XFyNMyfm+gzxASCEEyXsHGrq84IJ5URKevAF3ML2iZoLuiPPt0E0OHBrz5uQDaf52rvkfHxZ8kwLHnthzSytjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSlQRiDDM0O0dahPwKNEzLpmgAC/3zzaCoud+q66i+8=;
 b=HTjdRU+d5FqSV5mLpATDD6LF5hKLI5cbNHqX/VceaoXHHUtnZJe7hG9s118SZN4ohk7swGvb/Ow17p/v2QNfSj8PftXQxXJvvwysLYzVfo8ux/689bQybM80UhAai27UnY+tWQs3GxSmc0W8mAJLKBv/VMZ4mVgRI3Ev17SkYrWpDI838q1sQYfKzYan3LGVhv9gQT3hl1DtWFdQRKHZ8Wc0J5mubFJFphwmvk7dJ2e66ZC5R8MCBDlNeg58MWYNSHcNWN/Ds0J8J7m2v3u3AhG52rxC2265b4yIsa/PSFVgxsLdwEdYgndyQBlCxuN3vvb1ZmbN4Q79cvBizJGzKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSlQRiDDM0O0dahPwKNEzLpmgAC/3zzaCoud+q66i+8=;
 b=Uv+zUr1nIHQaXr7UqGozvNBLTqfByTUIR0lLL/Sp/b66mV7fSxMfXJx1giKIykiM4KKCsdL/AY4HS+z2nxtT7GCFPD8pdsO7rut46kjHWKDAOf0kUI4/p994ekTHkbmIknYEca9A4U5sRvAdn7NB+F6GiFE7HuaqaGFipBS1ya0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7211.namprd10.prod.outlook.com (2603:10b6:610:125::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 14:40:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 14:40:20 +0000
Message-ID: <3c5aac54-a986-c163-a048-77e364725f3c@oracle.com>
Date:   Fri, 23 Jun 2023 15:40:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 01/12] perf expr: Add has_event function
To:     Ian Rogers <irogers@google.com>,
        eter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
References: <20230623003312.3981075-1-irogers@google.com>
 <20230623003312.3981075-2-irogers@google.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230623003312.3981075-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0349.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5c4677-e4c8-4620-389d-08db73f7c530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlyADzmufNPyYlSaojtwfKDaTXMTJ/gnDa9CgYF8ITLdYyBvJYF85ZTSvgXwk+e7lbc/kT2DQ7VGRE1guGiwpHGBb7TcM8DLo9X/oCg8BLoCqIPwzMwsQt4O7MXWdr5m5YdQHgSgyjGAGXJ+hebsjkxf8lDtsN/aJkQG68VKGMH0k9iOr3oFIwV8NTBZeTyC9b9isyXDw/4Jr5XotHAMADmllPOZxrJqhcHGT75Rjy/mzAfzb6ByXEqorIjwrvssW2Gu6t3mO3zhE3RogOiEfFbDgcsjTl3Nj0WuooJmg0x/hfvl/8N3EK7z58LUPgnKHnY/xIPCB9jHN+GYXBqB+d/0NxseScAQba4EA5CYxkeWmKMR+tmRZdIF2KA90mH6nVKXfr30M8wKPpyNbKcOHVy4RHgYH0ioa5zZgZA817pbY5J24S2roJQU5AkaSM9+S5jhQfXIUnVA/Ef8xk9r9BHJSv4EzzRvw2qK3G3Wy9j+QbIilQeNQBhRV2ZTqtfIehRLnOmaeBkz6FIBh1WVRnsWoixIUSgiQ3/OFJAT5L5WhjfvnzFsXA566BQvpdW4nwsq+nAkSqMtpJJDsE4wKPRBQj4PV31mU8MZE+P4+jDMvMzWCt/KFg+s/RKB9FtLrQD6y23p9IUyP33tve8/StNuU8JsDcotgBOYAjDyJSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(31686004)(66476007)(66556008)(66946007)(478600001)(8676002)(38100700002)(36756003)(2906002)(921005)(8936002)(41300700001)(316002)(110136005)(53546011)(83380400001)(36916002)(6666004)(7416002)(6486002)(86362001)(31696002)(5660300002)(558084003)(26005)(2616005)(186003)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czRKQ3JyQ3g3cTlHTExiTHpJbE1qV21xdVI2RVBLUkx3Q2dnR0VyL2IwRFNa?=
 =?utf-8?B?ZCtjNjh4cXJ3WTRBa0Iya2xrelUzVjEydUNFa1d4VjVnNmRZdEZDaytOMjdq?=
 =?utf-8?B?YnFucHhwdFlUdWFnU2YyLzdNa0hPMG9rb0VPczhkUGhIVWRSVmVYSkVkaWhs?=
 =?utf-8?B?dkJNaHY5VmhJNDNUZ0V1anlxM2lGRTNsRVlFU1lGaDVIdHc2WEw4ckpWSlg3?=
 =?utf-8?B?aytxa1ZJRUErR0pMMW1wa1ZVaUhrbk1waEtRaGJkSGpnanhwRUQvY0phM3Bl?=
 =?utf-8?B?ZlZ3RFRBVU1kSkxETmFweUNPcHZkVTJnOWl3T1ZCa1Q1NEdWc3R0VmdJblpG?=
 =?utf-8?B?ZytETks0UFRhRk9FTkVsb2Ryc2pSWnJ5RUIweWxqZ2xpcDJJS0N4ci9EdEhW?=
 =?utf-8?B?QzZzeWVkRTFzSUJvT0kyU0g1WXVOSjRSMWlqRDFxQzRxZ0NrZVhJbUphZW12?=
 =?utf-8?B?OWU3NE9Gcjk3WnJZTzJGUUorWmY2ZDhHM2tQTmtWRmtSZW9hSXVaMmtzUm43?=
 =?utf-8?B?TFJaMU5kSHFid1NZK1hUc2lpbUFOMzVONjk4Y1l3NEl5ZmZqWTA1TzBxMW94?=
 =?utf-8?B?OEFvTXFGNytYdG9sODBRMDRES3FGWFNDYVp3b1VrM3JJVGpPMkdZN3BwZnR0?=
 =?utf-8?B?czFDb0d1bm5ORDA0b2xrdzBYMFRBSStYZG5vem96VXFQMzFhci9ZT1lUUk1I?=
 =?utf-8?B?UDBDQ2NtRm5xbGFBMkdCaVhnRHYweDFEMVZFaVlMRnJYWnhuUTZ1bmFzOVd6?=
 =?utf-8?B?WkVmVDFjRHp4Rjl2MkNuVEt4VGFkRlZrZTg2cjE3MW15dUd4Y21uSjdEQ2Vq?=
 =?utf-8?B?ZmRsSlo2ZDNpYWlPRE9UVGFYQTAvU1ByQU1VYkxBMmpRdHlzeUcwcWRjempt?=
 =?utf-8?B?UHk3RzV3dXF6ZVNxWHlsbENIcTBhc1RrUzJPOVE0U2M2RkhxWkFHcDZZaGVv?=
 =?utf-8?B?Q0NLaG1BN01qZnBuN05jRUpHTFZjZGJDQWszSlQwWllHdm9MR2VaSjYwTmZv?=
 =?utf-8?B?MGI3SW1xcFowdXQ4b1BWZzFqamwwcTlFT0MwMVNDTDNVb20xUTk4Z3lVNUs2?=
 =?utf-8?B?bXc0bzBDYUh3ZG5mUG5ITmxOUWdpc3RndGdPOUVIbGlwNE9ObkpTQVBmaDRr?=
 =?utf-8?B?Y3g4TFFwRVFab05Pamx1ZUJsV2gxQ0t1aXVOUUxoRXM3SmNBWlFqY0xQQ3ds?=
 =?utf-8?B?SEloMWhnWHZhQmZHVk90ckFhRUVZMnNBSFhXUHNVMk1GUWtoNmdxWFBCdk5D?=
 =?utf-8?B?VURlNjJwRXRjNkgzVkhQZ0piTmVVMGJtem9aQXJ5WHhnZ0ZQRXpCc2RWR0Zz?=
 =?utf-8?B?K090VjIxUU51bTFCNGVGeHlqWmxUZEJhcmVkTDNlbEpzYWwyalJMWDhoV05F?=
 =?utf-8?B?aTI5VGx4Z3JyRGV3N040dDhvbGtlMVBobUpxbzFLTXVrZTQwYm5WeUJOS1BD?=
 =?utf-8?B?RmhqSjZLaDRLajlzZmp4QnMyV0ZJeGE5K2ZrNGhGY0JFWDJLTFNRYS9LVHdR?=
 =?utf-8?B?WUpGSWc3VWI5b1hIZFFHaUNSN29RMFpLRzV3OE5TTlZ4VCswMStCNVEwUVZI?=
 =?utf-8?B?RU1ySSs5MGZ3Y3FqOXN0Qkk4NlE0OE04d3J5cFc5SzZtYjRERFhpOGFDK0pT?=
 =?utf-8?B?SFJwUDlyak9yczVCVEZhN1pFeTM2YVlBdEEzei9ZMWZRVmJqbFluOHZVTXdq?=
 =?utf-8?B?WTVlZkNiQjI1VEQzTmRWOFFuTjVOLzZIZGdTR2NLY012MG85WG91UVJad1Yx?=
 =?utf-8?B?bS9jeUgwbEw3ZG82K042T0N4NG5IWUsrS2ZCcHU5NEF6SlEyTTc2OUtENnhW?=
 =?utf-8?B?TWpqeDA4c2xuUmV3aHhyc3d4ZllqTWhuTTE5VHBURC8yc2NZSXEzdklKckxa?=
 =?utf-8?B?KzI1dStHKytGaTRvem1MTGtMbjJZTzdDcGlDSGZYbm9uOWszT0MwVXNhM0JV?=
 =?utf-8?B?aGxibCt3V1R0R2JLYW04MkczSFNRajBCL2I2T0RYTmhzRHBHVmlINUF2R085?=
 =?utf-8?B?VXp4U2V2MDFYckVqMXRMQXVhZGNKRWV0dlpNR3ZJRFRQNXg5MWlUWmVYRnBI?=
 =?utf-8?B?WjJtYWd6RU50Y0tOci9DUFZSMVRrTU1qY1hRaUk3OFlMSXQweDJYcHlFdFVW?=
 =?utf-8?Q?wj2oOi2vLVsTqP2shTxcBAqgT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Qy9XQUZtUHRFMk0vVjFCQXNmczhpYzVSUDJTcElRaTUrR01odXdtYUVVS3g5?=
 =?utf-8?B?T1hkY0pUMGg4a3E4OTV5VGZ5SmdTZWdSTThtbUlqVFMxN1llQm1jbVhQK3U0?=
 =?utf-8?B?dHAvallKMHEyL3ZQWFhTZ0xHNzd1WURVNmJXazZjb0pGYmZYbDJDNVJ3RzFp?=
 =?utf-8?B?QmtKaTRaSUhUSUJ1UE1kS0lqTUxBNHlMTC9qNDlhZ20rYnhyM05ncDRlOGt1?=
 =?utf-8?B?TjJEWTFFTlNFdHBvOXpRZXhsTDdqS0NJcnNCckw3M2VUY0V6azlIbCtXaENi?=
 =?utf-8?B?ekFzY2NqdkdjR2Y1MzNwL0ROV2lITkRySEVxeWhZNTVON09pZUJ1eUxqSjgz?=
 =?utf-8?B?c2UyemNVZTNBeTkrendsRXQwOFZ1elBWcVFGRzhvZWlUcHZCSUhSYURMbDZK?=
 =?utf-8?B?QUprNWw5NGF2dEhkZ3dYRmc0UWdCTE81OHp1aFdwYzBtcC8yUncxRnZ4NThT?=
 =?utf-8?B?Sko4MkJiRDNBSHczYVpPNGZPZ3NnLzMvaVpybzVFNnAwSkM2eHBDWUpRL3Jo?=
 =?utf-8?B?YXNCVTNWRUpBUmFqR3RxdHdsWnZRTU5GZ0hVMWliZkF4OFdCR05SNGJsemUy?=
 =?utf-8?B?cDV6ZkErTkp6Wlo2QWJ6ZkptT2VSa3E1SkpVSWhDS2ozb0JidWw3Mm9yUURj?=
 =?utf-8?B?cXVkZlNSSWc0TkRTMVNjbjFBdmRTRzQ3R0l0OWlvYVVuTittQTd1ekpONFli?=
 =?utf-8?B?Y3B5cENrSlk5c0diYTJGeTh1eTVQZTdnMkczL3FaOEt6WnhZdTB1M1dvdWNn?=
 =?utf-8?B?YTVRb1ZyL2Z1M0VOdWVCeDBiQVRtaXpKSGlQVkQzckx4NDFYWW1GUHQzeEJ3?=
 =?utf-8?B?YlNEekVtWkpadk9zM1Z2ZlJpR0R5c2VMVmVvUGIwM2Fza3U3NVcvaGlUT1BM?=
 =?utf-8?B?aGpxQ3RUR2ljcG9GT0lwNnQ0UFphUVpTOHZKcTEweTJnbVhHUGd2eUhGOEpP?=
 =?utf-8?B?Z1IzQzMvS2I3R2NpMHdHc1h6aWltMlFPZjJhcHUxamNra0ZUbWZES1owVm81?=
 =?utf-8?B?eTQ1Vy81YjhWbTVEYlJGdHlnSzBFSWhzZzRoeGRCNStBdmk5V2hiKzltYy9P?=
 =?utf-8?B?V1dWekJ0RUtiVytuSFlxYXYvMlVkMTdjNDlCUk14TXdoRC9tZXkzMDFqemFn?=
 =?utf-8?B?bGV0MXdYL3YzZWFaNlBHdy9ZMEZmRlhKN3NLSjlpdlhCRHoxMWdVODRQUUw2?=
 =?utf-8?B?VEM0YUNaaExoYyt0VzQ3SXpmREtqY1lKS3Y1aEdaZkNhQ3BJUWI0dzM3N28x?=
 =?utf-8?B?Q2tuQlRyMUVvL0RwR0FTQVNBVjMzbmRBZ2RxZ0s5eGpSVFE3Uk1MbnZBQy9R?=
 =?utf-8?B?cE51ZnFJZFZqUk9GdmZwRXZmdGllQy9hNi85R1YyN3FnS1lrQjNQTGhjWlBR?=
 =?utf-8?B?UFVuN3dHKzg2ZlQ1R0hkTkhFZzFWbktPakR3NjAwOFZwYWFGSnM3UDhnT0to?=
 =?utf-8?B?dENYQk44NnhkMHprazZSWXFqUWhVdVFobmdiamJRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5c4677-e4c8-4620-389d-08db73f7c530
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 14:40:20.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMFP3iGh8nVgmW97BnLtvay9Y8ligUQnAp6RpZ0ZdrQvNW1wjYlG6IkN42qbXLtLuiw45d5AWm+d21gcgtbs/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230132
X-Proofpoint-GUID: AqaDXs3-xdLOVdcD70sfl_UxJ5EhfPan
X-Proofpoint-ORIG-GUID: AqaDXs3-xdLOVdcD70sfl_UxJ5EhfPan
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 01:33, Ian Rogers wrote:
> +	if (!compute_ids)
> +		return 0.0;
> +
> +	tmp = evlist__new();

tmp may be NULL, and parse_event() is not NULL safe, so I assume that we 
need to handle tmp == NULL

> +	ret = parse_event(tmp, id) ? 0 : 1;
> +	evlist__delete(tmp);
> +	return ret;

