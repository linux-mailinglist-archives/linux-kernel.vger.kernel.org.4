Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B897A6B0707
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCHMZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjCHMZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:25:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A242499653;
        Wed,  8 Mar 2023 04:25:07 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3288E7uk012972;
        Wed, 8 Mar 2023 12:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JA8S8vpEPGSeNKb7VxNYhC1zM0dlGJlC5uhovnQqhKg=;
 b=C3TO0+MAEyvqHFRfY6s755pZ1T6gpo9hGYdf9va3p4K1Ff6azqhCW9a3LtvWJLtKTiAs
 rSdSz4xDFf+C1hFim6iFt88yC7ZZn8+Z+lJreADMN80Mxvv5UxXhKT+82mPKKnnQnYFh
 al8GLYb6eGAVJuNAlehKaxe8oXzjH87HKHmyVoWO48SXM0iaaXrM/GNMZE6lLgkz+7W7
 1dWWVI6xUkFJlWw9Rmt0KK6MEg1inUYCspaRvjNeZsBxz8R9YfnRvFKlqlC2ucLQeecT
 yFwmN7FZMTznQl8Za5NLg2H7vHpYOSpRIKwtZG9NhXc0/pRL8UBRZ/VWUUrQWPwIKwQS Ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn949d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 12:24:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328BDiV1036526;
        Wed, 8 Mar 2023 12:24:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g45cx35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 12:24:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQZ3L1DgK7HelbBnsacfl2xGzLxm42SWURpWrEZpuyNukpXmzddqmYYa9Gy8vjfeswYN4swnaQRHusW1bKAAXFG+iClg/9PQvkFFQ4p8kmi9GSJXi58HHS4MiXFONSap48r8ZlJpS9/34sRZO8dN8S1TDHqrK/WUhLGV2wlBr8pfGY6+sHsUT7o1u9n11e24dgPUbOWRr2dTXASeR6jrd+Jd94K3WP4pB/MALDVRwqqq3YoCPhdOZUylMUqKe4nEjgtA78L2JwhnA5m/KigrR+7kINHFcGLmOAxEEytUs+npXk9qC3InOJKlU+KfcgEb8VKOLKjOBVCoTVYUuBkTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA8S8vpEPGSeNKb7VxNYhC1zM0dlGJlC5uhovnQqhKg=;
 b=Imav6R4ij6e0CTdPqJ+WPDf7AvF/oytzzrDAjyho0XGy5lGKxrjgklLDP7iRaOdZ1NDW4z9qaCf3XZRRrMOoDZxsJiZTBxNdysSXDxSqfiOiPr1uNTuCcQn4F1i21ZFlFZpW0GdWc1jrPsIYvbctFW3jemZE0KTiuJnlr7Jycz/sFgr2RFZqGqrIIeZm6c1XfGF02EQWF1jVW/gpVy8FQY6XLMekQN3hbXmISWZnoR8NwCdtjHgfCdu6iEN7h5jIQkTIf+ZshqtcBhiG84VFQl+Q7056ZWM7rId5eVjFyzUyMXqsWCemGfnP20CfrTX56XyuIN5nt2CnfRJHGrq9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA8S8vpEPGSeNKb7VxNYhC1zM0dlGJlC5uhovnQqhKg=;
 b=siThQWx29ez5oGN6kGMEdHhpXtMTunyc3bsDKpuTFywOrOR3mQOeo/IYUrBV/QHEUnaPKzB3o3SEJXwVjDgTSPb7hasI+HRh79hiGk3Wj8zviv7KU91DMxXH/sBCzUxhbVj7sRnp5e0kPOBT8ORKfpB6pX0StZWKB8OwjcNDN4Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5172.namprd10.prod.outlook.com (2603:10b6:208:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Wed, 8 Mar
 2023 12:24:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 12:24:07 +0000
Message-ID: <2e284b0a-1ccb-dcaa-91bf-56dd9428ead8@oracle.com>
Date:   Wed, 8 Mar 2023 12:24:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 01/11] libperf evlist: Avoid a use of evsel idx
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>, Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20230308081731.1887278-1-irogers@google.com>
 <20230308081731.1887278-2-irogers@google.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230308081731.1887278-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0238.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9da876-7202-4aa5-411c-08db1fd00390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0ge75sZ9DHTp8JmRttUiwn3vHzS/pN57b8Su2sBlLTRF9fjtodp3tIgRsxqc/BEJj8XiMuulS2aQUieyeBUh1cJYrEIrYi+6YHauyLXeUJlJ07IWSfPVPSkt3bFPQaQgtElxh674InmSQnGf0hz3uTwMq+08NWQcpO1KbVNjXVzQrOFc4z+le+S+/kzfzxJFG+IRLGDF8GNLAVjKV+Ax6ipfOYRfgC32DhDtcUtHqMJqKtUizixQqxZDBeVp6SkgnL+OZ5O0PdhWJjtkUFm1IILzuJmxuTCbTVkeuc5zxY4C5BfY2S7Cwr7JhwmIYcwVbXrqIhBadBvIJoJiLmtv3AYuP+qINurHxMrP00h89sp3z2OenFBOxn8VYr/VfWm0ettdk5sOYaXZGDhvVIRapwnmIZvBoGJtJL00OKAqa0zlF1bd9CWvgxHP9FvxkVHp0Y27W8zWid/T3ZOApcPl6PzXnenNzpSIFB7/38qQG/gqnFeZVYoT/Tjls7oyFQMkto2FBkLbY7MfjIiChEC5wEGPfsLNVnzslTZwww9RPwjLFbb3eX8Xh6zdpXLTvNgTgP2cUFYoT+oq337teN7HwryxUMJDqPhJxIPcrfNEdYj11IxON1x1YG9WO3sAIb9X3WRr8zXlXeGtpPKmxXsoknd8Qkuto+yN+q0WlSg1uQXBRFBrzJADruoJNsIeAXxhyq5Mm4DXKcwOpjw+Z7K6AFUmz5aHRtYET/tF8v4Ut3mq18QpXqitfj4YXr0X+TH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199018)(31686004)(31696002)(110136005)(316002)(558084003)(36756003)(921005)(38100700002)(86362001)(6512007)(6506007)(53546011)(83380400001)(2616005)(26005)(6666004)(186003)(6486002)(36916002)(5660300002)(478600001)(7416002)(41300700001)(8936002)(4326008)(66946007)(2906002)(8676002)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW9DaGtuZ3FjcFpGOXNQZHlsbytOSHpscjVVRmpmaVMxenJTVUJQaVViaExQ?=
 =?utf-8?B?VnFUdWpveXh3TFpVRUFmbGtzN0NJWjZpdjhMdVRvN2gxdlpneWN5a1dQMTJh?=
 =?utf-8?B?NjBQR2RKNnp5cGE4K1dtQmJnc1VleDFTRTRZbzZLNUpzU2pvS3Y4UGRHbC9t?=
 =?utf-8?B?YStRR2tRV0tVM2lMZ2NSdmk0aUVGNC9iOXhnS3YzSFozaDJvUnlKNzN4dFUx?=
 =?utf-8?B?UFRvVG11Tyt2NnA1YmVyWlNheHBSSGFPb1F1T3BOVG5pVklqblY2MDVUdTVs?=
 =?utf-8?B?bmIzU0U3NDBkQkI2OUFuNjlMb2s3ZS9tcWI1eHpFSkpzZFFPOEh3TjcreEw4?=
 =?utf-8?B?UGdna1hZeUJFWmVzei9DVnpRTS9XeTN2d0xOSGYvdU05UTNWYytBelpyRVhM?=
 =?utf-8?B?bmJsbGdpbjZBSU8vZ2l4U25kNmY0a09wdC9xVlJPYkcva2tISEdxdUZ2NTF1?=
 =?utf-8?B?ZVNwVVFBTVB4L3hDM1ZUOWFPNGZ5UGw0UnhCVmFPRUhPVUNWZ3VFMUZFdW1H?=
 =?utf-8?B?VEhoYklpTFNma3I2ZTVjT0xqbkt0ZE9pZ3RZbldZSXFocGduZjJvRm1hRjlD?=
 =?utf-8?B?R2FGaWF6Uld3bVhtSEZEalJoZXlJVVFyWGdKTDhGUmZZM3ZlYkw4a1NsRFlS?=
 =?utf-8?B?ajdvS2VkeVAxSFJhV25ydzVqT2tEMjRPWUJDMlUxQVNlRWpLanY3czUwMk9P?=
 =?utf-8?B?WlhOUDg2UE5DaUtaaUJYdTEzTVdGbDFKdzVtNk9YM0VTUVdTVTVYRVU3TnJN?=
 =?utf-8?B?UTZJVjZ4TFEzOVZlSGxUNGdEMEZvcW9ld1g2ZFRoWmdVdUYycHplQWJheDV0?=
 =?utf-8?B?SDVWSUlVQnFOMk5QSTZJeVRKOHNoaEpYcGo4RWdNcVh3bVowRWJ1UVYzenhX?=
 =?utf-8?B?TmZ3N1pNUjV2U3NWcnNTMk9IY2F6WnZYcXR3TU85R3k4Z1dRZzRVK3JJb1JI?=
 =?utf-8?B?T3VVSHNQUFBNWVU3MTF3bFowOGxSdG56SHV3dEJmT2hUaThOLzNHVm4vYTdL?=
 =?utf-8?B?OW5XVmJ3QW9RMU1QSDFrZkUzSTgzNVMyUDU0RFpxV1JFQS9pU2F6a3RiMGNy?=
 =?utf-8?B?VG4rOFl0dVJOV2Z4U01MdFlKVUlNbXNYQ2dCWnFuYzdLdGRoWDhIWmRHL25l?=
 =?utf-8?B?dFhEdnJyemJrT1JVZk1xOVgyc2cyZVRQRC9LT3V0UHFPYkN5em1tZjk0QW9F?=
 =?utf-8?B?eHdXVTl1NFpENWt3NkRMd1NORUNTRVNUQ0cxTmQyZXFCVmE2MnpaajlQTk5i?=
 =?utf-8?B?OHMxS0dQVlZDTUpyNEJ1Zkx6cTBBck9aenhmVjNtalhTSC9rMVZJMTdrMzl0?=
 =?utf-8?B?UTZrUktWblNMam1hQVh0bHhqeUpyOFBSSVFTc09iNXR4dEprZFpUNCtnV1F5?=
 =?utf-8?B?a1VGWGxQb05sVWlLMUJyTkYyYnBQT0cra2xENVpkNDBySFh4K0RITkY2RFdG?=
 =?utf-8?B?eVVOSzBIODFLcjMrQ2tSRXMyNkt0VWlXNkRzWklvOC94aDk1UGZ0ay9IL0tm?=
 =?utf-8?B?WUR3enREakYwZ2pTWWs0WitRcEZwaGttSmdmY0dwcUtFYWdwazM1UlVHM2t0?=
 =?utf-8?B?WEs5blVsSmxKSk1kY2xuYnRIUWhKRjJESVRzS0RmbG01dFRuLzJVUTdvd3dC?=
 =?utf-8?B?Tmw5RmJRdTV6ajN5S1FjN01WU0lZVnpyUG14VDNzMHpMMDdvbWtMdmNER3FP?=
 =?utf-8?B?bjNZZnQxYU5xMkpJVWtGU2RacUFoSmRVVnhna2tnUno3czAvS0ZXSkt3b3dx?=
 =?utf-8?B?UGx1OHpRUzg2VEhRS2QrenZhekhBRVFkeWM0U0dmZjJ2K2ZEbFFtdldnT1Ev?=
 =?utf-8?B?YStvc1pwRTBOT0YxeEF5ajBiTUV1eG9oVVU0bGtGc05lY1NOekdiSlZabXVw?=
 =?utf-8?B?SFZHVTZXck9IOURLTUtMd2ZYd3VpTjBuN2I1dnVDYXVzUUcwSXVvL1g0YWo2?=
 =?utf-8?B?b2dxNEh1b2N1dnhScjNIcEpBMHpwYi9tb29MR2hGd2hPK2V1SlpsbFNWNFhT?=
 =?utf-8?B?YXQ2NUs1STdoU2JERFQ4bkIveFV1WWNDbFJMK3V3ZVZzQVJPVmoxWjA4WHRS?=
 =?utf-8?B?MEFKQnFDV0hvaU43NDhJQ3dRbEVvL1VoTW5nUXlNMmw5UXRjcWI5a2tOekEv?=
 =?utf-8?B?Mi9keXRoNzVDRGphR2NnNjF0M3JFTmg3WFg1TEo1QkJLVnB3eERBUUVDTWhm?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SVRUMVBRL3huYjNoZ0RxNEZ0aTlKUHd2NE5DQ1FsTzl0OUZQTklTSFdtY1du?=
 =?utf-8?B?OFpQeVNkQjV5eWNlT0xyN2w1TG5lb3pTN2ExRU1Iemt4bksxSWE1MmtWYkUw?=
 =?utf-8?B?UXFuSW1mZ1k3TThiWmpjdXRhUlRwYTZrYno3QlBQd3B2OWI2SVJmdGtqUTJG?=
 =?utf-8?B?VDFveVVOYVRUby9XR0Y0YXZLQ1dPU0dMZVE4M3QrSnR4ekYybXBLVDV3eVYr?=
 =?utf-8?B?K0h5L1hKeGJIQ0NhcEhFS1VZbjZVYzlYOGc5d2dQdW1XbitobFg1Nm9qclMw?=
 =?utf-8?B?ZmUrRlNKREZiZmljcnVCSGordnNXcE5kV242N2tsM1ZRUFNDam5sL2o0VHRn?=
 =?utf-8?B?QTFNMGlkUUlZQVQ0OS9DRWNHcUR2QnhSdXBCSCtNbUFBNFgvQVg2VVpWUWJ5?=
 =?utf-8?B?Wmw5OXp2Qk5KSzZ1cXl5clFyT0Z6U3ZOdU9tYVd3OHJzRVFsMkJQMlJhYk5m?=
 =?utf-8?B?RmRHM05GMExOZU5jdUwvdllNZnJsamV1MndQMHZhOUJpQmJKbFJPNkg1dlFt?=
 =?utf-8?B?OFJQWm5hcVRxWmNobUV2ZzdTTUJZU3ZEMURmL0lDVDE0d3MxYjBmUUdsQXVj?=
 =?utf-8?B?eGNGS3BsWWJxN0FzL3pKSlBUQkJOaWtXMk9uZlo2NkF2Rk91VHRrUHMxWU1J?=
 =?utf-8?B?STV3Myt5OGVKclRVL25oUEtsaUZNdlVIZFBXZUxPVUpZKzRrc2ZSdjJpcEtE?=
 =?utf-8?B?Wm9ZYkZLd2tGYjlqRTloSzY4NFJPdjJFdmdMOGlXeE9DYXVOMnJRUDVxTnlH?=
 =?utf-8?B?QmRZWDJ6KzZPU2JqMzUxajEvSHVnY1ZUOFFFaHhlZzlZQTE5Q3U3bmNrL1po?=
 =?utf-8?B?aklDOVdoQjVFcHFiVENUK0RtK0tlNmx1bktSaTVEWmJZNjVGK1NpRS9kTm44?=
 =?utf-8?B?d0psVmxDZGRuT1RiTWtZc3NsQk52Nzk0bHlIQW44bXdKcnZzOXE4RGE0V25G?=
 =?utf-8?B?MFN1OENGWklsV2ZvTXU1eWxBRXZxZFF1L29pUGxxb0VmODUwMWsvN09TU1pX?=
 =?utf-8?B?S2xIeHBWMW9xOGNFZU83SkZUY0RCa2NnMkJQK284eHVjV3ZiWnJFdkJFaUZk?=
 =?utf-8?B?b3IvYnhvbjYyNWtGelllRXhjOFJ6aTZaQTJ2RVB5Z0RzejJJekRrQUltOW1O?=
 =?utf-8?B?UXlIMlZDbmY3RHFNYmtyWE5UT1Q0QUpvOHZXdHhKK290U3lWT3JEY3BPQkRF?=
 =?utf-8?B?RHpUUitDNHRmZURBdTRqa3JsdzlScEprb1o5U1RCSngydFhrN0MzNXpubHFN?=
 =?utf-8?B?NEJURDN4a1o2YmUyL0JpTTRxYVkxUTRHRnhVMDBJam9NQUdENzNYVEY2Wml1?=
 =?utf-8?B?SmJ1M1VNaXlKUXlqTUV6RTZCZDI3Nis3bWVXMGtmVmQ3M2taek40MjhJMitN?=
 =?utf-8?B?NTZiWXJPR2VSQWVCQTR1VThzRXlaK200WDFUY3pzM1RmTFdNSStSdWtvQU5w?=
 =?utf-8?B?N0FEd21ZRlV2NlIxL1NxTTRJMnJreW1Qdy84TXkzYlJTNnQ4M0RxNmQ1SWhi?=
 =?utf-8?Q?kdHI1wfIh9JssDB4lBBJ7rz5ZCM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9da876-7202-4aa5-411c-08db1fd00390
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 12:24:07.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ST03xyvO3vCul/6HihZQ6VG/FMMkbalsl2SO5oPYlijlqj/Oh1OmozOZ7+R65dcMexLGbSjrrdoDnupD58Z/sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_07,2023-03-08_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080106
X-Proofpoint-GUID: z37wzl_9Ms5bC3UgI3ICsnD01UsKo5Gv
X-Proofpoint-ORIG-GUID: z37wzl_9Ms5bC3UgI3ICsnD01UsKo5Gv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 08:17, Ian Rogers wrote:
> Setting the leader iterates the list, so rather than use idx (which
> may be changed through list reordering) just count the elements and
> set afterwards.
> 
> Signed-off-by: Ian Rogers<irogers@google.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
