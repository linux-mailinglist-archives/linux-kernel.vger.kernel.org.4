Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EF065BF6A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbjACLxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbjACLxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:53:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8DD6572;
        Tue,  3 Jan 2023 03:53:18 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303BniEw005461;
        Tue, 3 Jan 2023 11:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BAfUCK9yGE9d8Z61WCgPOIouGfaJpHEf3LWuOdZXvDU=;
 b=mnch3EkuY8agCUoHGzm8lb4cAD+EYrKP02RSjpE+K7MNyhPZMhPdeqpPDMftdp4K1tsH
 3BmNAiAmMVN74ZUR2Jnr0vHuojAgfgVrfZd80zjIOsQK0KLaJU0Uh+vlVW9DXnjVEXXW
 HxegheRfJWic9/fsFi/6StpBdiwfKfQ7XF70SguWqcKf4W9jGXbq/SpH9EDlMmndi+L+
 TXySIcrbLdUIon1SCG8f4XQCZhkYPgQ9iLCvCHluUzwxEwB8662Qp00jzQyxD43HBx/R
 VkPlkpLhTgLCVNUx8Y/fRqwoVrJZctD8WjOuNTg8tzzn50hspXV2w8LoxXpmqnwT/O95 vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c3sx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 11:52:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303ANsUP034059;
        Tue, 3 Jan 2023 11:52:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbh4qvu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 11:52:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWAvFSVkWtMb8zCjw+mfZrj0E7eJAEahYFLtyG990dac6DLghxlmw0p4RsO67NrY+i88nZNrA4CcJ4XicyC5NPckToF0p7PZV1HhuGjskJBJBJEDvs3GfnTJ7CW4f6QK0Ofc2iSVSMEvIMxkpWy4h5AFPLq6QxsMeoJ1+gckcJ+TSXa8xnkVJr9T3tw2rkCtyaSMAO55HgbTKOs6ZV8Gq7IbVwp4F3rSr3VuW265VRfYFMJNVvNC/kZ8/GnELnR4MDC0N+E+iBbPSkaZ7SfbyaPX+zd7MtDluyy162EUyKoyosJHAqw2RXOqybH/mn0cqEyqx9Ldi1qisbtJmpfXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAfUCK9yGE9d8Z61WCgPOIouGfaJpHEf3LWuOdZXvDU=;
 b=hbCdWMZYZOM1wBseLvYKvrY0GquuR2707Zg+LsLqv7CSNnQmxXzez+aPEYhAW6XBgQyiy/eRlzQWLxetIitwzr4rAqPoOdfsEEuZiAEHZxVzNfsC9p0wSxYxhFTtj8hDLlAVETPcgaFenF14+NFZkQ6wOm9HT+fqTOI/EBsPOl5rMsttDtv/v8/CP/UY2ewS8uurN1EYY/jtu+EjJiujiO8gcAMv/U6TtC8Lyn6rAN5QJCjxVLwjLWG0thr+U2gFVorcoN4ujnk9/Mb3HWj7Cm9LWmgDPMfmtDLHXJ7M6e+rHzmMrQ8NoXmTz3DRDbQ1HKsBD8ccMhrLtbWNmm0oyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAfUCK9yGE9d8Z61WCgPOIouGfaJpHEf3LWuOdZXvDU=;
 b=xtcZ69CJtzD9zx+LJFcutQWKIMBJ0XP6fCcB1kob1RVCFVEym+wTiU5sc6YJsfQpFheTAgG/E/8QMlHIh/FP1QlDH83zcKecINCgVbAG56yYxWI17w+5ivP5UPSe0E4TdsZjP8zSWkFYFgEiQ3FUhuxqb43pVZM2w+UnL0HV4Tc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 11:52:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%7]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 11:52:19 +0000
Message-ID: <5c5716e5-b2ff-67cd-b608-4eeffa7e04bc@oracle.com>
Date:   Tue, 3 Jan 2023 11:52:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 1/6] perf vendor events arm64: Add topdown L1 metrics
 for neoverse-n2
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1672745976-2800146-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1672745976-2800146-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0233.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 302881e0-f2dc-44da-bcd1-08daed80f777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z32biJKNooKWMC2/Hm+YN9rVDNaWqcCQLkjxFY8r3kpopH0DC1zle0jPIIRC2TAfxMDvEOmvHkuPlCE2TSPSFcqMcmHDj1W5GSDj6mvg5wPH/IQ7kbzTRfSZs7roufAlAYWo8OdwLWBQp/hqrsL3Ok7tLSuuvucZDbuz6+JGeSGCPImGNboZA8WbLqA5SBk2waDlJ4VVD5cMzXYm/bhcDIvbQrFzs//VqKHn33L0L5lF0uG1i6K2LjT7Yyeco3LadvhP8SAZ0+5iITYT462egLlo9pyrvHOYeRzb36Dfu0O91xzLWb7xO449KRfUutsF9Ho/s/bacp3hopZ/VD6dDN0OCpphVJ0Jgl/cFcDhXrEughh2OTCR77mwD9PKNDFAMv1ySruPZhLIH8+Wvi5JUnQHpsag9HJioU0sIouUj2uMSjs83vzdbsLvhA/csRw9+CktUybkxJsxKwQXeSLYqYHY4SEfNZ+wNxQ810yyWVSTRls5rlTxTFKZ+zbPTMKzj0Ps1Rs1ElEiU8iO6enzrPnKzvjOWYqFkXUdvvb/6jgr1xXgcHLFM8AXs2DCTVvBWKYpPUQEhxgIc9JimEzxh8tlQEMfdBU0KV2s76UVFO99jgswetAy2fvXt1C0QmqfaKgYW6tpZC9MQKwQgYVwIhPJ0V5jbQ9WBq49JQtCtbIyvZKNTqVfchaedj7dZ0WDhQWJKdCBl2BmMfuEHbb8CBAbIfZaFQfT5hMtJNmDBFqV+i0SRT4divQAV9Kq5yWWwa1GsHna8spZ8rnjI26SHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199015)(38100700002)(36756003)(31696002)(86362001)(6666004)(66946007)(66556008)(2616005)(53546011)(316002)(6506007)(66476007)(478600001)(36916002)(186003)(26005)(6512007)(6486002)(31686004)(110136005)(54906003)(2906002)(41300700001)(8676002)(8936002)(4326008)(4744005)(83380400001)(5660300002)(7416002)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTBMeGkyK3BBVkIyK2ZmYTZhd09DbkQxVFE0V3lNMmExV2tRdVZxQW90cStn?=
 =?utf-8?B?RjNrSEljdExZRXNJZER3dUhveGFUR3hmS05WS1JYckRGTzdNMFZsOXVWSkk0?=
 =?utf-8?B?OXUwa1VoeVVPY0Q1bFhma3ZWL21ldFZVU3oxS0xhYWFsYzh5ZElweG8yT0J2?=
 =?utf-8?B?TFlWak9xemJOcUZheGdjdDFZUlpQY0lEOEpUS1NhSGxhQTRpT1piOVpwa25v?=
 =?utf-8?B?SUcxYXA2cjNCdzR4UWdDaFk4M25KTFJhWEdsQmEzSDZmSVFvRVNNZ091Q01U?=
 =?utf-8?B?SjNKUEJUcHdQK2xYOHhLOXYzSndpQ2RXN05nOTZKUzgvNkFCcmdxNXl0bFQ3?=
 =?utf-8?B?blljNEYzdThMQ0NWYUFBcHBkN2FhZzMzaGlMeThTYTRRMGdJMk5kS25oRlBG?=
 =?utf-8?B?dzNVVVpjeDN3VTZwV2ZSYVlTRjBEQllKYUI4ZjFwSXFVMzAwZGFpWVp6SUY5?=
 =?utf-8?B?NWx1am5oZ0hqbEFkTjE1VExIeENnTlZKbHJHemt3UWxvOHBhTkRVcGlYakEr?=
 =?utf-8?B?SXhhUXpiMjh2L1Izd3c5TXNDWlcza0dINGErUXVDUEswNHVITUVCYlhIV3dz?=
 =?utf-8?B?VGxHREpyZGg5UTlOZUJ6dmt1U2R0S3hYd0F1b1hZZmJsRGhxWGxkWXpOV3R5?=
 =?utf-8?B?M1NtaFB4SWVJMU9hbldnSXkwVTI3VzdySUFkSG8rT3FlVTBzRlMxN3MwL0ZE?=
 =?utf-8?B?OTBzZUZEbDFYcVN0c0FoN0hMUmgwZ1BRakRySGl5d0lYQ05ad2t0Zk1uS0I3?=
 =?utf-8?B?a1ZvRnhhUnhMUXlMVjcva2tuVExydVpJdWNRTGdIWjV5OVlqaGhiUUQ0Q2VX?=
 =?utf-8?B?NUl2Z1hEc2V6UUlkN0xXTGoyUXpxVE9RaTRZQ0UrNUw1WnhPWWNGczJaRUU4?=
 =?utf-8?B?L3hTSGg3TWpoekgrTWdZWWwzVi9PanpTZDNMR01MdDZQTHpCUFhTbG1LV2lP?=
 =?utf-8?B?NHNxdEh2Nlh4QU91U1pwRDB3QnFnL2d2c3EyWlFhcHZUNjBlRlNiWVZaK1hl?=
 =?utf-8?B?akVPZ25ncVY1cW5lTjhlbDNMQzZ5RW56TW5nclJVVjVBZEQxUm1sOVFRYTlw?=
 =?utf-8?B?ME8wUFVrWTJ3OUVuNUVESXpmNWZpdWhpeldadGpxdDBhblhyOFA1aVlWYVly?=
 =?utf-8?B?aGxUdEhVa0VVMjhnRUVUMTlUbTRlOVpQNU9qbUpOOHBoWEtqcHFVdUxQMDMw?=
 =?utf-8?B?cjI5OVprQjJ3dHpQSlJycGx0NXhMTkJqZ3JKWHpnQXk0cytMdjRpMVhLVFll?=
 =?utf-8?B?UXcwUVJrVzJQQ05oR2ZaZlJwblFKdGRsT1hVc0tueHpsaWFIODFZbllNQWZP?=
 =?utf-8?B?WUdvVDBSNXQ5TWVzTXFiYmU2Rmc3U1JzT25Kdkp3dWMveUZlWlZHMmVyZkZx?=
 =?utf-8?B?YXNKUURyWTJaS1lxU1R2ZHBTVTNST1p2Qy8xbDlOdHQ0aWZldlk0ZjBXbnNO?=
 =?utf-8?B?OURuMjg0am1QQUlOMDBmdUlaZTYxVGNrcjlkS3Z3ekJROHA2UjFLL3d6OERQ?=
 =?utf-8?B?U0l5T3A1SFNiUzQ2Nyt3V0RiaFU2T3JyZG9BaUJoaXVBVXpITjY0dDBHQ1J5?=
 =?utf-8?B?eTYwQkFjdW0vK3hFMDBWalRpSWhxekV3Zko3VHVoTXc2Y08ySk1JWm1tZ0E5?=
 =?utf-8?B?cCt2YW9CQkxMWFpCYWFzUkVQem9SK1lVRXlUL2JGWVpjYm5xZ3pwclhva0Vp?=
 =?utf-8?B?TzgvZThDZzJPQ28xNTFjYi9jTzcvWjFncE5UYjZjWlNnYmtsK0tOM1pNTU4z?=
 =?utf-8?B?dTh5S28zM0d4eHNOQnp3YVBpejBIWHRzbUhQbVc0TVVBQ3lLRVRFcytHbWQz?=
 =?utf-8?B?LzgrQ0ZYTW85VWprMlNIb2Q3MUF2ejF4ZmVzM1pYZGlLVEwxUWMycTNHbmJR?=
 =?utf-8?B?anN6ekVjQk1tZEUxc0NsSjl0MnoxazBZS0dmWFVsT2lob0JtcjhOZ3lBR050?=
 =?utf-8?B?VVpZQUlhcElBSUVoR2lwRkM1VnUyU3JiZ3Q0R0ZFSktKVnFzeGw3TXdvMTVn?=
 =?utf-8?B?eUpiTlVnbHY2TkN4aTFMS0hPb1poeXpWZnFSOXUxaVJrTlhsQW9yMzlqbUF3?=
 =?utf-8?B?L0l4ZjdNZE4vclFUREZ3VHFaMm1lODlSUllRWjJYZTRQZ3ZwdmJDOTRjZ3Zr?=
 =?utf-8?B?OGEwaHRQNlhnUXVxM3lsLyt4MDIwL3gxY0lqQ2tHK0NqV0tFWFZoYm00eE1u?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dXZpSjEwa1pqejdoeXpYRUExRmJ1SnFOWVI1dVhhMUNtZnc1SFg2ZWFWMWh5?=
 =?utf-8?B?aUQrZVZRZWxNUk0xclV5UUpvVFVFQU5KREVzbVRaUXdlQ2tkbmJXVEMzZGlv?=
 =?utf-8?B?SERVejlpcHhiUzVJS1lFUE1uR3pueVNudjkydEh3dWFqb3A5NDl0Zno0RlBL?=
 =?utf-8?B?akdIN3hmdTlKQ01iOHhQZnJMMzBSY2E3VkRKallhTm82R0hvOHhCZmlOSXRT?=
 =?utf-8?B?Wnp1OFVtODFvNFQzbURHbGUvejBIckk3R2ovcllBdFNxSU50M3dib3UrbVNN?=
 =?utf-8?B?SEx3bXBKOEJrSHJtd1kzdUl1bmM0NVJkcjdaRzQ0a21mMklzbVpSNkVNd0ZD?=
 =?utf-8?B?UE5FMU5XRWVKNXFpMU1PQURUTGdTNjJFNSs4bGtQRk5ENEVqdnYyM0hkengx?=
 =?utf-8?B?OUdDT21tZzdrMUJ0YzF3VHFyV3RYdG5teVEvZVhOVlRMd0M4OEYxWHNJaVJD?=
 =?utf-8?B?Q3VkVGRzVnBtcGdPM1ZycGZUU0FLTmFzaks4dVJMbUdEOFVYTkk4WUpESmth?=
 =?utf-8?B?SWJSZjVhRFNrY1BPN1BOMzArQzB5UDVzemk0Z1ZkT0ZDTVR2cVVZZ3FnMU0y?=
 =?utf-8?B?WkFUUEovOXZJSzhhV0hteFpDc2ZLRC9nV1VEdVpiRDl4SmgxV3lmN3p2RDdM?=
 =?utf-8?B?V1RibXBxMXNqbW1NRnN3THMzOXFXdk01WmhxVUJqdDgrcE1DWGR6dmRzZnMx?=
 =?utf-8?B?ZUx3NkVvQUhiTmJwZ1gwQ0o1bnliSTYwcXIxVUlUYlhKZ1kzTTFHd0NuMTNE?=
 =?utf-8?B?aU9wVUxJc3FiZGJlRzZxbnB1SmR4OSs2MHNhT3hTWlN0ZzJ1dnhsZVlrQTdG?=
 =?utf-8?B?cWNVOHlHK0kzbFRFUkhNV1UyT2lrZURVeTNGZDZFUHh4MlBmZWU0YjJoSElV?=
 =?utf-8?B?d0xCMlZvRk1TMHFOckZyZHI1QlJSdmx5ZUc2Q3V5eStBbTd2REpoN0RIWEpw?=
 =?utf-8?B?QktvUWorZU5PN2ZxUDYyWFE4dThhckRhbUlUNFFtejh3RnVWc0pzUngzSHlt?=
 =?utf-8?B?K2hPOXZaOWE3Y2FMMWU0bERVYmhkenBCWlR0ZGRuMXJmZU5nR0I5VjNaL2xv?=
 =?utf-8?B?R1hVZDN3ZGc1L1htSEtRS3kzZW5JSXFrTFN1NFdyaXFFMlZndG9KVlNJdWpu?=
 =?utf-8?B?U0k2aDU3SWNTQXk2bXVaQ1pzMGovTHVpVGdWN1RtMWQxY2luM09TdDlXKy9E?=
 =?utf-8?B?U1grb2lGYjBOZWV1UW1DRnRTSlV3dEwzUU5GUUx6ME4yUXloNldybElENzAw?=
 =?utf-8?B?ZXlHSDY3OXBtVWF1cjBIMGh0TDU4YTZBTkNhUjlQT0NVMlZ5clVDZEVjZmNk?=
 =?utf-8?B?ZW0xc0RzMEI4NGdpbDJxVFdITlB6NFlNc2UrVkFSUnhKSE8zOXFkSVByOURl?=
 =?utf-8?B?NVh5TnkySkplb0hzSERyZUU4b1pwaUZ0NmNEN2owN3ZObHRERlVQQm9PaEs4?=
 =?utf-8?B?czVQNzYwWXhtZ3JHNmxZUFZ0WjFHV054QUViVTE0emc1djJiSVJrZnE1aTRl?=
 =?utf-8?B?UUNyK3hNcDBFVVErczB3QnVwQ0N4UnJBNE9CejI4d0NWeEN5UCtnM08xZHZE?=
 =?utf-8?B?b25TVVJxYUxVUmE0WWZleTBEV0xMcXo0VEVQWHZPZWRHNzQ4NDFYcnk2VTBI?=
 =?utf-8?B?eFVUa0gyRGNyMmY1TGtLRXFCL25DRXlDR0xLVHVXSWt3VW9WM296bnJCaUFI?=
 =?utf-8?B?dkFwb0ZzR1BCUHVHMEhhdGF1QmxzTk9DbUZTQWVBM1AzVndHL04xTEhlekFG?=
 =?utf-8?B?UGozRXRkWElwOER6bjd4L3kzU29kUEE3VGFsd0NVVFJCQkJiQXVGeEIxVzBl?=
 =?utf-8?B?MjNJL3EvRGkyckhTUWFSN0hOT25aWGdzcmZ3b2pzTkprMFlFQ1lEZXlBS3ph?=
 =?utf-8?B?K1VOOGsxc1YyZWdnZkdnZTZXc1NZRWRiekVrakJSSmM4Z2tEVTUxTWJPUzRQ?=
 =?utf-8?Q?8fDwMJeKBaA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302881e0-f2dc-44da-bcd1-08daed80f777
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 11:52:19.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9R6AFj79s6aI9MSyuE13qxtIohuUdbrQI3gKclWcxAd7hUn17qFP4JQ51Xr4pwHUA3Qq2ztVnLjYRAEDi3Qmvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_02,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030103
X-Proofpoint-GUID: xGkS03vS12gEJaKRayBCLgCxdn8V40Zg
X-Proofpoint-ORIG-GUID: xGkS03vS12gEJaKRayBCLgCxdn8V40Zg
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 11:39, Jing Zhang wrote:
> The formula of topdown L1 on neoverse-n2 is from ARM sbsa7.0 platform
> design document [0], D37-38.

I think that I mentioned this before - if the these metrics are coming 
from an sbsa doc, then they are standard. As such, we can make them 
"arch std events" and put them in a common json such as sbsa.json, so 
that other cores may reuse.

You don't strictly have to do do this now, but it would be better.

Thanks,
John

> 
> However, due to the wrong count of stall_slot and stall_slot_frontend on
> neoverse-n2, the real stall_slot and real stall_slot_frontend need to
> subtract cpu_cycles,  so correct the expression of topdown metrics.
> Reference from ARM neoverse-n2 errata notice [1], D117.
> 
> Since neoverse-n2 does not yet support topdown L2, metricgroups such as
> Cache, TLB, Branch, InstructionsMix, and PEutilization will be added to
> further analysis of performance bottlenecks in the following patches.
> Reference from ARM PMU guide [2][3].

