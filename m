Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6640D6F30D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjEAMUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjEAMUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:20:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9870191;
        Mon,  1 May 2023 05:20:39 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33UN89NF011879;
        Mon, 1 May 2023 12:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=eGv2Q/+w9gmiScCo+v/s+5+Ma1L7qiDWMFvTmhZ8xXo=;
 b=K0ofomCAOobr3VBT6dEKirIZ8nbdNRqHfs8ADJDzIIfCoanda/AwfVtUf7tiMgtK8Uw3
 nmW8bXZwunFRsH1KT7n1EZTNjwzZZt18Levi+oged2EnRrglortz8RE3csGN0ZdmaxBT
 EhrFJk2QXiOxAchemxm6zIdzOwEwMf0UrP5GJD6YwObF//TjqUQ3VDgNjZ1Txf4tXa5d
 kUjlgCWebquoMQ8MBzl2kE+3spAGFik4jWE/L3oG26gemjYun+BAjsXkY4Mh+VAQcWPw
 uD6gl9L8dmpK/qVcluTId4HCXOxHgP3brAa6ffcQoaiQlrIkTrr7jWLXs5403Q/d6LHi 9w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sne29pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 12:20:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 341A6pEQ002389;
        Mon, 1 May 2023 12:20:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spancku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 12:20:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuVOy1QMSdRYSODKAMye64e7u1tA6c7Y/0Fo4q0ua6T69AfUdH0Ax8IwyRl3ezo1bljWMm5tTuTPQdeRlUdoBV1UcpG//07X8g51W+nwOf19hAByhlndy1/gymVZknHplg61LA2KfMtWEuRKn+WvBU44nfMXePM+fXe0I5WTpCzg0wI+2wMBXu8oF2tXGNbffa80YgC9wIWd5bc7xZxBw3AMMM9XXfs81LolcRBOAM/MruYfK5wiMS35Pd/j1GKLWoLA590R8A2LYefG7XW0iF2l/U7z5NXTuqHb2kV9of8L00/Z9DvH6SD5keeh8s8HMjc9EDb3me+l8VbWH3dO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGv2Q/+w9gmiScCo+v/s+5+Ma1L7qiDWMFvTmhZ8xXo=;
 b=fnohcCifgL0EXwaBlFH1bIj4tNQovNIOubVqQBpOyARJ/WMhGuy5PugZ/MQi9xZmF0Y5IkQEHKzlLc8Qm8tgBMfmR+hmQhuCOBvEl72WhpcsMiF02FIp9il6V28FdVbtMdEQK8UGUBv4rAeb2wSsH6TXpp1WQle2W4piINMZbzSTUC0cnd/r2b8UCvgLAM6MXPW2frYlfw6s399VsfgmITLeO8msGNmCJQH4H3bQAZKWzEkvKE7E1cOcd+X/WRr8KQOVe8iw1H/vEENu8Gv5nXjP16Mk/KUPhZQKrer2Nj3y+W9GTYO8IyCRO+pUbkQ5CnmKHbx38jLN72qsJGvj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGv2Q/+w9gmiScCo+v/s+5+Ma1L7qiDWMFvTmhZ8xXo=;
 b=jZSz/wQ9Lgeqjr+JdAiWjsnZq0bV+fHYD9TC3UtJzSv0cLh0Avi6TSPLBoxydS+vdZEXfWH+ONHQaigE89o84DknBLqkHsWDHXE3igsq2Cy2fy7scJuydaGBAy0LqkH8SCoqX79Lp11O5MQ/ALxb1TAk06wyCYy+aaclXKMq9rE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5120.namprd10.prod.outlook.com (2603:10b6:5:3a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 12:20:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 12:20:07 +0000
Message-ID: <509f8dde-4e93-b2b4-c960-d1ea7f8f9cef@oracle.com>
Date:   Mon, 1 May 2023 13:20:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf vendor events arm64: Add AmpereOne core pmu events
To:     Ian Rogers <irogers@google.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
References: <20230427223220.1068356-1-ilkka@os.amperecomputing.com>
 <CAP-5=fV-CwUgbKfCndJvMcnWpB7H3Z03sqiAjiFa1DsoOqNn4g@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fV-CwUgbKfCndJvMcnWpB7H3Z03sqiAjiFa1DsoOqNn4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0162.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce9f408-3443-4f17-65bc-08db4a3e66a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eY6kZbrH0XVDMNOX5Qy9obbM4jel5BUr91WTW4RM8dIfqCm0sCh0jPpVFzirew4jxTDQXmgfpNhwwLekqtJOjL2EM3NDBeN5w6FVouZ3KfUKMBxNsCC0I2xl1XME+C91jF8CqB1FhNeAT34Y3PWhZ/0NRAXPLqOxychSadLnLojY2pSBgcbDFa5i7K7VzedmibxkQeBfXl1YnzzWS9OD8dH1VWB6WLeoA4GSNnZj2mEZnpAhk6yodWey8QIk7QwZWGbl01vjmtwsL59zxcpIudU7X3G3qEDUi1Cyp6mNGwBGvwlhmRD0vP9V9AkRSMpdBw9rJzy1YNaPzVXMmGbnMVCP6j8wvfZkID8/EURe19mkANP0V3zDW5E2/gsC7DqqUHUGF/5UHiO4YUJmutMq8hZu7AnFqQuAqzPWAjyTAZcB+Dvyg+JwBPLyH+yeNjR72hRBwcAwnDhm4jimWf8QkxIfgh9ZmK5gMk+h3+G1nSUjoUP5WPnt+FMw6jYPs+TkPZfMI0Xc4MHXwYKKgzQb1XMIHiaJoFwkzQbLoZ9megvTEK7dT2LQrUJApJX74714wxKRhqPAtyAhnw2WzKkAFd4t1wByw8vAxRbkvouSJvzD7lsVmZxB1c3+Z5PFhTX9jZl4H6iCLOPAUvtjBK3Ggw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(2616005)(186003)(86362001)(38100700002)(36756003)(31696002)(5660300002)(8936002)(8676002)(7416002)(4326008)(478600001)(66946007)(66476007)(66556008)(6666004)(6486002)(36916002)(41300700001)(316002)(31686004)(110136005)(26005)(6512007)(6506007)(4744005)(2906002)(53546011)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkxKOVRJTmcyRnNIMEZidDNCWktPanRBbGI3TzhodE9GK0E0VGNpcEhaVCtR?=
 =?utf-8?B?cmhUVmxIK01nOU1ZSWFBc1Nzc1MvTDYzN3lXdkk2K0I1MXJyMHVTdzYrdnpk?=
 =?utf-8?B?K1BsR3hMZVp5N1FkQVFUMU8rdHFzODFVVWYzb2RsbXJMQXZJYlE2b21wWklC?=
 =?utf-8?B?RHE3NGc4OWdzMjcvS0p1eDJldlJ0OU9hV29OdHhjV05VVXZkcGxmMjBHR2lr?=
 =?utf-8?B?bCtPSmxWcFRyeVZHemg0SWRKNlJmTlNOY3lDL3NNbkQ0WG1DUXRoeFFTd3dk?=
 =?utf-8?B?Njk2cGZqZGY0amdkNWR5Y3lMNUlQVzFUSTJwejdHYnFlcUJ4cS8xekNQUmdu?=
 =?utf-8?B?VExUU0N0Y3dKMXFqQ2tGZ21PRTR2R3pkTUpXN050K1ZQSzB4NFVOakdEYU91?=
 =?utf-8?B?STdNUFIyaXVGRzJIWVpzRC8rKy9uU09KTmtyeXlFRkhVamVXaTRNVFZsT3lp?=
 =?utf-8?B?eHZIYXJoQWpkOTF0SENFc3ludW5UVWtYVzh2dVcwblkxUHQwc21SR3BMVWdk?=
 =?utf-8?B?WVZyQU8wVEtqc2lXS3RzRUZ6KytlcmdPWEkwMzJlUXBDZEhUT0JiUk1EdjhG?=
 =?utf-8?B?eVZjaks4NVNhcHJBWlpQclJIcGZVWGlla3VIUzVyVFZlYXpWUzJLZWZLMVAv?=
 =?utf-8?B?bFFwMFlGbTh2d0JodG00SC9GZnI1T29pVnRFZUZseW5ER0p5cVdLMnZKUlNQ?=
 =?utf-8?B?ejZuZC80K3NWZHE4eldWVUQ0SStldFNONUc0eHBKUGJJZjcrZ0k2TStCT1F4?=
 =?utf-8?B?Y1M1bUhodGpyYi9uY2hMR0UvSFN6b2R2Y3kySWpNY3VxRVI1aEV5RUg3TDFo?=
 =?utf-8?B?TUYrRW1IWTZWdDlTR2JhcGdyS2FhYVZnOXJqTVVHMzJIZU5sTmNYU2lZbTl4?=
 =?utf-8?B?cFlid1ZhZnhqODc5QXZKaDE0LzVBRUJmcUx3WUdBME5SaDgrSEtXYlRCaUpP?=
 =?utf-8?B?aDB1NzhOYlQyREtuT1c1aG1SNVhZWEFFdkdjMVJXa3IrdWRtenRZM0RTbmtx?=
 =?utf-8?B?b0I2VURkdTBydWZGRy9HVmpmVnprQWNtMzFJZGNjYTNkN1Y0SGQzVVBia1FD?=
 =?utf-8?B?VithMHBINStjTWhNNXNKOUtVWUF2TkJxRW9WeXYzUTJGRDZSYU91UVZoQW9j?=
 =?utf-8?B?SUdBOUlLeDQ5bzdocnV5UWxLUHpoSEFETnBac1ByRHdFWVd4UzRJZzRwYXd2?=
 =?utf-8?B?NjVmYzJsc3UxUFlwUGtNTk9UeFpHc3pLd3FHZWlRSUxJbk9kY3EvZVhzSU9Z?=
 =?utf-8?B?VVZKSzZZdVR5NHdRMi9QMlZUTUFVbDhwenhHUk1MRjhrSjdDQjc4TDFaS1hy?=
 =?utf-8?B?UTNCWDFyOTRJVmpIYWkyZXk3U1dkM3VJTW54Y0w2ZzNuY0xuaDgxVVhOclAv?=
 =?utf-8?B?a0ZaZGJuMTFOSHB0bW9Cblo4QWRBNHZnNU9vVEdNSnZuQUR6N0I3azVmVmk0?=
 =?utf-8?B?a1h3cDh5ZWk2cnVaZmNQWkZIbS8yUi96QWdCRmpDUmdSa1Z0ZUt5K2ZpTmZm?=
 =?utf-8?B?TnBBSk91NDIzWFpsUVpWSEo1WVhza0Nka3l4UHZpWi9Nd3BsQ3VjNGNRTkty?=
 =?utf-8?B?M041T2JKTlJzWjgwL3ZzM1MyRmd3WjhmcDc2MFJNcVJ2b25rNW1Uem4wUXFM?=
 =?utf-8?B?UXRmUndnMC83QlVnQU9ZUzFwYzVML24wUmltbWMyNUpwUm55Y1RRQ1lmbUVF?=
 =?utf-8?B?UWM3UGxRSGVudktObDV1YlhUdDZKZzlpek5uRmxJdWJPSm1RTTlXVWVPT1pn?=
 =?utf-8?B?YkhjbVlhdWxPa2FYMVp2UzBwUmpuVExSN3k3U01XZFE0My81NTlTUFhadi9G?=
 =?utf-8?B?M1cveTFwVk54b0VRWVJOMUdReWhnNGVvNU92L0pKUm9oZVM1R3ZPa0lZQ3N0?=
 =?utf-8?B?UVZtRE9kZ2JKK0Q0YWh4R2tPcG1vVEU4YWFyWjExZll4S0ZJMlVmVDhRcThW?=
 =?utf-8?B?cVh5V1RKNC9vWnp4UVRxSDB1K01ZUnFsUXcwWDBrNmpleC9UKzhuMGZTWFVq?=
 =?utf-8?B?QStkdmtxWnNERDcxS1Q4cW1weXhGYzNsSDZBWHFvSDlPa1BtKy93ZHFqSDB5?=
 =?utf-8?B?cWk0SmlUd1ZydDVrUWZzSzUvTmRaN0F5Q3AwMWsybnBzdTRDem9PYVB6NjlW?=
 =?utf-8?Q?Bb+9VeC4GjtNcLiJSB31IKWlU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OHJ5Z2VtMTExUDF5MHhjZm9yQXdJWjYwY1gvbVJ0K2x0aXpSTHVmc2Jqc1ZZ?=
 =?utf-8?B?azFvRDlnK1RMeVFoTzlGeUo1bS9NNHQwSWVTeThkb0E0RDI3WE5xcmwzTzZL?=
 =?utf-8?B?TzdUREZrTStnK0FteDA0WEluanBFSU5GbWhKd3FYcXlzbXV1T0dSM0dkVllJ?=
 =?utf-8?B?emdGM3pES0pwTkRiVEFkaklQYXNiTis3VG0zTUVXQkNiSlVDbGxWZExhNFZG?=
 =?utf-8?B?bHFWSzJLU3ZXWDhaRFU4YXJKRm85d04vcURWSk9Ud0RUb1I2eDNUOFcyd2Z6?=
 =?utf-8?B?UzczQ1ZaTWhCaHlOT1ZSOVdkMWhWdjU0Uk5HNDNJTHpodGlvTStraGFSejBZ?=
 =?utf-8?B?eHdYemJ6L1pGUzJYdXdWenFXWmluTTRkVkxqOXJaUVl2cFV2R1kwZ3V5K29C?=
 =?utf-8?B?cXIwNDREc0JDYlNncjZQUFJJc3BqK3Npa3hmckRWd3N5NVBGZFlGbE5BZWdK?=
 =?utf-8?B?ZjduazJmeTZ4emZET3N3TlRqNkFoT2lKVlhMTjUweElKRXZhVk9sbVpGbGNZ?=
 =?utf-8?B?dGdXV1JjSGpHL3I5ckhvbW1HM2gweGl2WUJ0bHZlS3RvMGtscVhadGRiYXVz?=
 =?utf-8?B?NnFUR29McjhNbkFBYjVQQUR5NkVqNm9Tbm5MdFFOaUpzeDVHdjB5d1NHSFJE?=
 =?utf-8?B?bCtPcjgwS3liK05LVFUwOG80aGdaRDJJVlAzbVp5QlI3ZUswS3RXanZWdmU1?=
 =?utf-8?B?bzkyeWtpdVNXSWpxRzNJVEFjZWtBY3pNV0hWVlRwSC85KzJydW1YSFREcFVI?=
 =?utf-8?B?b3hldEtGVHl0QlR5U0x6YzBpR3BRSEZJRkllWGdydTJvUEFiUzNrbjRubmZo?=
 =?utf-8?B?am11SVhvTGZqc1k4VGRXeCtSVnFsczVkUytHN0R1OUROeGl6clBKUldmOWo5?=
 =?utf-8?B?TS9aUWZZamVxVjRHNEZSckhHT1R6RHFYdGFSbFFCeWZ3Q3V2Z2dMcmhDREhY?=
 =?utf-8?B?Y3JLaUFCZDNiT3UrQWp1T0dpelV5UnEvejRoM1J4QmpWRGdCa0xDdmpTTC9y?=
 =?utf-8?B?cU1mYzB4aVNQUDVFWWZkU2ZJMU9TeFlxeVBBSm1UQTErWFlsSGptVW93QXd0?=
 =?utf-8?B?UzF6bVlzRUY5aDFNdi9lbFNxVi9RSkk2cmhDSlpFUDFMM251STV3QUUwWU81?=
 =?utf-8?B?d1o0OEdzQVE3dGw5elAxVDhROWFtb01PekNocDFXdVhDenE4a1RvcWZsZEdo?=
 =?utf-8?B?bkhaMXo1MG9ZVjhsSFgyRVNNZzlsNHRKYkt1dWFrM3RURS9BekwwM1U1RVFJ?=
 =?utf-8?B?RXdJWjAwZGIxN2NwNUFQZ0c1SVZpeFRZc1JnMFYxcEM2QXZxM3hpTzZwK3Ez?=
 =?utf-8?B?UlpsVEdvQ3JwTlJsdFZXVzU2K0RCZi9Sa0FnaGF3bzBWbVNWZEtJOVZYOXZz?=
 =?utf-8?B?a1NlVXZFUzZULzZ3ZkZSZWp1Wjl6aklRSVZzeVdCb3A1dmtLNkxxV3I0aEVi?=
 =?utf-8?B?Q1RIZkN4S3lkckFrUkY3U1JaU3FoUzlQTmlCaThHOHFkOHQ5NGlFRFgzbC93?=
 =?utf-8?Q?KD+hvwRAkQM6y28LNSIltJFEGpk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce9f408-3443-4f17-65bc-08db4a3e66a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 12:20:07.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOx7cZNHQxbOm5aKcBcIbl13V/5/0snZ1WZdwxqbrDC0yjcSr60VjJG7pVHIVSlLkTW4v7V84bwNwod7fAeOoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_06,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305010098
X-Proofpoint-GUID: Kgr55X2_l1lQkn4FUWa7NJSqQmaK25fn
X-Proofpoint-ORIG-GUID: Kgr55X2_l1lQkn4FUWa7NJSqQmaK25fn
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2023 22:13, Ian Rogers wrote:
> On Thu, Apr 27, 2023 at 3:33 PM Ilkka Koskinen
> <ilkka@os.amperecomputing.com>  wrote:
>> Add JSON files for AmpereOne core PMU events.
>>
>> Signed-off-by: Doug Rady<dcrady@os.amperecomputing.com>
>> Signed-off-by: Ilkka Koskinen<ilkka@os.amperecomputing.com>
> This looks good to me, but if John Garry has input I'll defer to that.
> Acked-by: Ian Rogers<irogers@google.com>
This all looks fine, thanks

Reviewed-by: John Garry <john.g.garry@oracle.com>
