Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B956373505F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjFSJeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjFSJd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:33:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9524204;
        Mon, 19 Jun 2023 02:31:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J0xCow028503;
        Mon, 19 Jun 2023 09:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5E/lgjAIyzhiHmuIcNdYHf2/XB8aFVT03426mkJsOkY=;
 b=gPw2gt77L/d5u5niAcDiqK90t6FxfbQ9a8sQuZRiMNVHm++/IaMuW+wx6uK0tTaLo+VF
 wMSp8JjLmfqM6ViD7Y7OYa09F1DQ5lYqQaxViCgMz1jx7z0oqszyVtRtZhC2bwRWZf5E
 brj3hgzQSLrtC6WXRnWjz1lJWeocLgSOsBFU+IbxwiJ0R/sv4VTgZ1ujg16pJmYG3jSN
 KZXlf04jE7Ye4j7y8WlArw8tVrzNEoOiYK85eKPyfc0zajHBY5pz/MdH9d6CAv5JzwgI
 Iv26FF2fwWIDnMwj0zEbtUN1clbIVBMg/amhfrLll6HMD9nhXGgIAUhC7ePbMxR7pv5X YQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qa2c85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 09:31:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35J8JMsk032965;
        Mon, 19 Jun 2023 09:31:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r93945hp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 09:31:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddN5kWemKAX2f7CMSb2plhOAt2HwB+uOaU6JAtEslUyyxP8pfxBJkb2BAM1zbvp+frO2o149WnpzaB/q3pCNNVC6SdwLC3UzyWA1Iay3WcGjdNj8ErN7K2O1zKBLl+FMypOlrSx1bssNUrTT4fyKdM57WTcUPVzBJ236uW0nhzg6keyaGLYMOgh4FVF8giSOKe9LurrVZRLJ1I73TsdaaPchrnvl6yEZq7muoeKud4rPawLAqzlGurl8xdvIbqzXh5hmFKwMSqQF5yfrWJAl4S0HiX4zcq2R6UhT8ccQzJWn5v6W1MzbT2pCAWGqCn4rVX7MJzNW8Rc6lQhUzIOYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E/lgjAIyzhiHmuIcNdYHf2/XB8aFVT03426mkJsOkY=;
 b=ln6uIjkMi8auSud5gCy6PnyLT2koAbOu+LjvMtXEIaCcbXfP1uymzjIyi+iApCHpoR+/EbmJLBt6anK28MWhid3bMhsTeUige7BxL09KdEkpmnMWLnEsM7dcajyGB4jzBz5LVVagIsMP9aoc95mJr3F0al/EADtMtXbk9ENmfaiN5fQZi5gblXtVF46jNND3PaSGdYkfWetEmvhmNYe9dE7iIP4hDrEjqyhhlAzQINvxykPQMbdAqVyS/HYs4kRECMPhrQAYOHBy9Y10ZhrxIlqHc0iKhGYnE7u2qj+hJ7YHaX1jmiAnssXDAn0frQbMqZvNbHcpRjD1Hr49dq3Klg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E/lgjAIyzhiHmuIcNdYHf2/XB8aFVT03426mkJsOkY=;
 b=v6oAxs+PLbHm1PIqqHsebsOqNPUmZy1yXYQfqnZ1mnPyT1EPQRI4VuYsEBS37BopaKtEU9al1Nc+U1E2xcb9TKm2jz1DKiYBfJHh0L3gQw0unK+czrBzb0JJhnKtsmkzqpWVfDhACAojZxk5qUGFmbjGyVKYLZw3I3jrrwxWDDk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB4890.namprd10.prod.outlook.com (2603:10b6:610:c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 09:31:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 09:31:18 +0000
Message-ID: <71c4ef1e-0982-1ef4-5135-001303b43cd3@oracle.com>
Date:   Mon, 19 Jun 2023 10:31:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
 <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
 <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
 <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
 <5f38ef6c-8c50-5df9-19dd-c3c9fe590452@oracle.com>
 <e4be7189-a1ba-7758-bff3-e7b8d8ff1419@linux.alibaba.com>
 <892f57c7-8ce2-634c-26f3-4d4ab8b2f2ce@oracle.com>
 <079d7920-2030-2e00-a833-5ec6d450f7dc@oracle.com>
 <552eebae-76bb-a2fe-ccdc-11e8a01717da@linux.alibaba.com>
 <045a49c9-b9ae-bf0e-c4be-858d905bcc55@oracle.com>
 <7c765e0f-ca76-d212-0496-f9c56369e389@linux.alibaba.com>
 <d1ab4947-6bdf-2b9c-5b26-52c572611ca6@oracle.com>
 <a6e1114c-b37c-6999-0668-039aa495db84@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <a6e1114c-b37c-6999-0668-039aa495db84@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2958c7-b9ac-4294-3a96-08db70a7ef64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/TIxfErVwuG34FoExUXXUD0oHra+C7ewNq8iHo/bJ1hdFRacdqM84+TBtRCILQCK6y04H/yS8zHZ4V2Bxom9dVtg9atMFUSCiDrqRwadbf6X86nQyw5wnxx4oTVfIYf+mdtEnadv9Tx4EUTEB6TWV5JLKPx2fOhdZhPT9swcGH8+LOX3e+hNeCz4IX+CszBZQta6Yx5GBGxiCh9g/cDeXCzdCSmiuFa0y44Fm3bPbGfDqZr6DBPJXVrdVaMH7PekreSENaTSsqBGXCQowbhAXQOso3IezAqgfKQq6o9MUfqqDyfLW6yxVEgyMK7YW5Ba9JFhk1r0F3RWzg+aOSs6MJQNTPKRCjMju/HyGT88LpH607medi+nt9MxHhojfQhF1IyuTOewy9shOFEg6HrpfyWUQMKQuOazrS2DWIa3AkQgHaHjng2CpUplX2TX1i40ggNbEikPYqqQj5vD+w1froPOkQJX3A9p8MMfnwGEx7i9BY9FzX+56iEY5r1Tmk9p9Y4qTAr1owEUVLw7i8SxR+FjKhsfJjRkX9IpFB5py5zKWs8Repz5jzca/5Kk2nwSC+zFEHBgxXocPpLX0ZjZDG0K8fRorF3x0ZpKwySsFjRnGaBmqYejGCsY0xyJfePHww3dwuB/Aal9Gn+D+LN+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199021)(31696002)(478600001)(2906002)(19627235002)(54906003)(36916002)(6666004)(6486002)(2616005)(110136005)(86362001)(36756003)(26005)(186003)(6506007)(6512007)(53546011)(8936002)(8676002)(66476007)(66556008)(66946007)(7416002)(5660300002)(38100700002)(316002)(4326008)(83380400001)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWZDZlpvTThzL1NLckdSbzJpU3FvSzRkT0p2R0FqaXhoVWFRNUc4QjJqQzNF?=
 =?utf-8?B?MXhPalcya1hVVGFxblNjaGVqamJxeklLRzFacXJ4OVQ5MHg0UWlwbTBzSkp6?=
 =?utf-8?B?WUk4V2lrT0JIc3RxSCtQUGFVVXRzZ1Q1UUkwRUQwQXc4NHZsb1M4K21KRTZF?=
 =?utf-8?B?d2pEamR1YXprS1c1YnBSMGZiWVdicmkzdlYwSVBDajcvOGQwdlB2YnI2QXU0?=
 =?utf-8?B?Q08xVjl5TXZnaytJMG1yU3kyU0FRMXZzai9LQW1Hb0hIWXRudXowWktpcUYw?=
 =?utf-8?B?NjhjYU16K2szU25SUjBiTWxDYTM1a0RoVWVJbWNnQ0JTMXhIdWdBZ2p3NlhG?=
 =?utf-8?B?WnhsV0xvd0V1blVBekllZGFSY0ZrR0V5bGM5SEFsYXVsS0NIUGZPMzdwM0tB?=
 =?utf-8?B?Sm5FNG5WcEhBYTNjR1pzWFZ4b0trMm5JNEsrWndXTXZDUTBDZ2RxaUVIL010?=
 =?utf-8?B?WXhMZ29pb1ExbzA1bFRzRUhuUjVYc09JMDFEUXNBOEwwQWFmNmdVMVRpWTlU?=
 =?utf-8?B?SnBRNkVHV05FeVJRQmxkUDlUM1pqTHNFRlR1MWxKaFNDZU5ERk1VS0JHc2lL?=
 =?utf-8?B?UDVHVVo1MDFGQnljcjV2L3FOZVR1SG5jZmlTNkJEU1VkbWxzUzdpbVdUTU1V?=
 =?utf-8?B?S1UySk5TUzBhMG1hZUNsNVMwRWRwOUhEWlRzUzRxZE9wdnR0azFMcXhTdEk1?=
 =?utf-8?B?VWRUYWcwckFJUmpmZzlTMU04TXRYQzl4U2JtOHZSRzZjd1NKK1JTSFpsM21x?=
 =?utf-8?B?WGM2UFBwdG1MWVdtT1k1dUlPQVBKcm9zTXUraU0wSFFJVU5zd3YvQVFLc0Vu?=
 =?utf-8?B?UmFiK3oyWFdWY3YyL2svOHVVand4eHFjOHRYZDk4bUpyMVhuc28yOUM2OVNB?=
 =?utf-8?B?RjFHdGIzVXA0SWIwcFMxQ2pqQU9pV1JzS0NNNUpRcWs4bWQ2a0VUSWdxUitV?=
 =?utf-8?B?R2NLMWZ6eWpSYVFCWC9IdStNZWNaSWFwVk5qOHgva2NlcDZZTWVqdlZoZkRu?=
 =?utf-8?B?UVdSRkpCa0xQQU1kWGFkTmFiR3NOTFpqM3Fab0FZc2Y3ZEx4anNGc29VeVo1?=
 =?utf-8?B?MUZ5SWZrZCt3eG5XaFFqL3VBUCtmblhnNVZWTGcrT1pKRGVIZ09NUmYwWVk2?=
 =?utf-8?B?ckRyRVlZMEhqY1paNVRHNS9LVU5CaGVVbUNYSE4xQkU5RU5Kejl0dkYwZzY1?=
 =?utf-8?B?U0FpZk5VVXQxR3JNd3pzeFZtRWpXWjQ5S28yTDhRalJkVDduSkFKMHpDeG9X?=
 =?utf-8?B?YVdieXhscVhyYnNIRjRQYkFMY1BDOWxGT2ZJMzl5UkpPNCtHLzA1bUJ3ZHM0?=
 =?utf-8?B?ZUoyVW52bURwaUh4bmp4NUhVcWVwTEN3RnpMNHFXSy9aajhJRDNxVzdWdytj?=
 =?utf-8?B?M09vU1p3VkVPVU1odFhmQmQrUXFpVTJkZnJ4cWVkM3RmYTBUUDJqOEFzVnJV?=
 =?utf-8?B?WW4vZDVCMXN1L2xBNzVydWdGbEs3UUhUZTUxdFE0dWl6UklRcitlV0QrVXp2?=
 =?utf-8?B?azc2VnVkTTFpUTNyT0RpYU9GTFkwcTVBMCtiT0o2b3BQOFQwVDRPY3lEVTc4?=
 =?utf-8?B?d2N5VTNsbjVzdzMyVTlhNFFKN0lacDNMbk82UjJ5b1ZNYlZqYTBsbUJjWmNk?=
 =?utf-8?B?MzRoZ0tqRG43TDRhQTgwM2x1RmtlWmpFTDdLUmI3TDJPUkRCL25IcUdWMFhQ?=
 =?utf-8?B?Z1lTd1hGVG1vQzlLSDNHaFczcWVjM0crWUxoRWdmT3plL0xaS2o4NWV1NUxM?=
 =?utf-8?B?QldZM29rNGdQdlMvK2FOa2FoYWhvNmVtSjNQZW5iL3FEL3RQcU9xSVphb2F6?=
 =?utf-8?B?T2FZakIwZHNEckNCZEZ3djlCdFVDTEpWeEI3Skd6aGtCYkh5d3htRWxSMXlk?=
 =?utf-8?B?WndDZ0dEd0MybEV2aHlkL1U1d2h4dHJWbEZRaytoWXVGOSs4TFBVZGg1SEc1?=
 =?utf-8?B?KzA5UUJGU01yNXlpdFdPSlI3WVRVd2VKaGN2NHQwNGxsZ3lQait0R2FrcU15?=
 =?utf-8?B?WWlxMUVSOEY4c3RzL25HU041VmhLYUVwQzJTTnVJa1JvdGlKNFdPR1RNeThY?=
 =?utf-8?B?ckl2VGlDQW1UbVlvNU0ybFVWQXFkamNvNTM3VFBIMXNJQzNjOWs4MXFQOVZS?=
 =?utf-8?Q?MApxYxrxWGmuYBPbwwLo03vEO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MmZlSTZyWVFueG16TVk0Mk1VeU1kSGQyaUQrS0pmVjVjM0hqbUZTdzFRQUEw?=
 =?utf-8?B?Q3Rrd0tJOHFGYXhPRjVBRVU3YXFnVjdnc21UMElEM3hPckgrNHoxdjJsUFU0?=
 =?utf-8?B?aGxjYytPbG5GTGVmR1RGWjQ1YVVIaHV0NlFoQnRrbzl6WTFKZEcxYjIybUk5?=
 =?utf-8?B?MEVNU3Z3MkxrazFOSHFXQ29TZFhUeWdsZEw1Wkc2bzhwUmNxQ2cxZDNCM0Jw?=
 =?utf-8?B?R0NDS09YbmN6RVhqd3ZrTDNwM1lkdnBEY0hrR1ptWUpJVXdTc2JCVjVGd2Fv?=
 =?utf-8?B?QWNXVUd5TzlNZTdvNnZHV2hqd1BOcWVVT3pNMXU0YXJLUmEvaDFWdGY0ZUxl?=
 =?utf-8?B?eSttY2pRVXo4VWtZY2lyenRzZWxYUnJvWjdQYlpBNmI0bU5HTG1nZEtoNmR1?=
 =?utf-8?B?NU9obXY0NXlxbDBnVWs0Qk1tTjNlUDM1NjhsSldIdGZkOVpYZElWUGQ4SEpY?=
 =?utf-8?B?QlVEYXRkS3RhU09QZ3F2NGJhN21BMWtoQkV0eEZIblU3YU5KR3c0NmdRV2hy?=
 =?utf-8?B?UkFHM1h1OEVyZ2J2aDFVYjd1UExiUFZlSUYrS01XUkNIZlAwMVRrdWJXR1VR?=
 =?utf-8?B?ZUk5dWVoelo1cFZKQnYvMGtlNnNLc1V2Qzd3dTdndnczVkRTQnJUS3NmQjcw?=
 =?utf-8?B?VHFNQjBHNlAxVlZ2UnVlNFVrSGNpNERzV3JrWHZjcFB5YzdFdTZTdlR2STMv?=
 =?utf-8?B?QXZQMTdEK0pXaHMyV3dCWUN3L3hKQnZpTlBpUnF0NXJ1akpWb0ZmekdkQnpr?=
 =?utf-8?B?UzEzZ2Z4bkQzaHNsUHBvTjRNbDdRVllCdndxYW5ERTZ4dVZkbHFHNDhaRmZx?=
 =?utf-8?B?ZldRbmI3K2tXU0EzbkgrNzBVYmJVcU9xR0NORzFjaXZzU3RHRlUwUkpTdlFq?=
 =?utf-8?B?eTVFMXcvVDMwVTEwRjhXNVdUZVFHTm5LTFJkVTlmOFBwV0lHa2V1bTIzUnRH?=
 =?utf-8?B?enhFclJXUXJVV1Nrd3ZlMnQxdit2Rm5qNkdtc0I4WmVvWW50M0R1NHhDMk55?=
 =?utf-8?B?WERqdDR3VXJxTnNQM2FVUTRKL1c3VWVqWmxrSC9qeDlSeXA3blRJaDd4bDFG?=
 =?utf-8?B?dndLTGg2RmVWV01Dc3NNWFFlOTYwMFByRmgzQ3dkUjBEY1dhY1Y4cERJZXFY?=
 =?utf-8?B?NDI5bnNKUEJBNkQwZjZlN3lIK05nWlNud2ZoZkdqdUtiYnI1UzhVcEJ1V0Zq?=
 =?utf-8?B?d0ZaN2hZZG96K2tURE9CSzJ3RUZVdEhFTXFobitNQkRLbTB4ejIybmZsWjFT?=
 =?utf-8?B?RUdZazYrdDBjSFk3MnRZblBzeUtKQVVzUGNSUVg5V1E1L01sS2FwMUJDTjBz?=
 =?utf-8?B?RG5iS2h1b3g3bFRZK2xjTzZadURlN1U4akh1ZTZraThtYVhkem9CK0Y1dk9w?=
 =?utf-8?B?OU11bzJBSEFQMDk2KytaTmZhSCtNT0xUbmc1bm1pS2VRa0dxdGZFMkl0NENr?=
 =?utf-8?B?NWlhTlRqUmE2a0duK3JieVhCSjRoUmFLUmxCbklQSDJXY2x4V2d0QnROUWdX?=
 =?utf-8?Q?S5DsHQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2958c7-b9ac-4294-3a96-08db70a7ef64
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 09:31:18.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gu1NzO/zq2/wDVkdqjUuUEj9Vb0sPWC7H7d3NUkkgolE8TCdtJcWqj3tLfT66um5zEIrK7KJFQtI0MDbA1wU9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190086
X-Proofpoint-GUID: 3GwVfPQP38P9AUe3FzJ3AsfmSvpbYx6v
X-Proofpoint-ORIG-GUID: 3GwVfPQP38P9AUe3FzJ3AsfmSvpbYx6v
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 09:59, Jing Zhang wrote:
>> Please verify running these metrics with 'perf stat', like 'perf stat -v -M slc_miss_rate'
>>
> Ok, it shows:
> #./perf stat -v -M slc_miss_rate sleep 1
> 
> metric expr hnf_cache_miss / hnf_slc_sf_cache_access for slc_miss_rate
> found event duration_time
> found event hnf_slc_sf_cache_access

In the earlier RFC series you had 
tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/cmn.json, which 
describes event hnf_slc_sf_cache_access

But that JSON is not in this series. Why is it not included?

The cmn kernel driver exposes event hnf_slc_sf_cache_access, but I did 
not think that perf tool metric code matches those events described in 
/bus/event_sourcs/devices/<PMU>/events

> found event hnf_cache_miss
> Parsing metric events '{hnf_slc_sf_cache_access/metric-id=hnf_slc_sf_cache_access/,hnf_cache_miss/metric-id=hnf_cache_miss/}:W,duration_time'
> hnf_slc_sf_cache_access -> arm_cmn_0/type=0x5,eventid=0x2/
> hnf_slc_sf_cache_access -> arm_cmn_1/type=0x5,eventid=0x2/
> hnf_cache_miss -> arm_cmn_0/type=0x5,eventid=0x1/
> hnf_cache_miss -> arm_cmn_1/type=0x5,eventid=0x1/
> Control descriptor is not initialized
> hnf_slc_sf_cache_access: 127615 1001344900 1001344900
> hnf_cache_miss: 36829 1001344900 1001344900
> hnf_slc_sf_cache_access: 131526 1001343540 1001343540
> hnf_cache_miss: 40587 1001343540 1001343540
> duration_time: 1001381687 1001381687 1001381687
> 
>   Performance counter stats for 'system wide':
> 
>             259,141      hnf_slc_sf_cache_access   #     29.9 %  slc_miss_rate
>              77,416      hnf_cache_miss
>       1,001,381,687 ns   duration_time
> 
>         1.001381687 seconds time elapsed
> 
> 
> 
> #./perf list
> ...
>   arm_cmn_0/hnf_cache_miss/                          [Kernel PMU event]
>   arm_cmn_0/hnf_slc_sf_cache_access/                 [Kernel PMU event]
> ...
>   arm_cmn_1/hnf_cache_miss/                          [Kernel PMU event]
>   arm_cmn_1/hnf_slc_sf_cache_access/                 [Kernel PMU event]
> ...
> 
>>> In the past, I always thought that the function of the alias was to explain the meaning of these events in the perf list.
>>> Or maybe I'm missing something?
>> Event aliases do give the ability to describe the event in perf list. But we can also run them for 'perf stat', like:
>>
>> ./perf list uncore
>> List of pre-defined events (to be used in -e or -M):
>>
>>    uncore_cbox_0/clockticks/                          [Kernel PMU event]
>>    uncore_cbox_1/clockticks/                          [Kernel PMU event]
>>    uncore_imc/data_reads/                             [Kernel PMU event]
>>    uncore_imc/data_writes/                            [Kernel PMU event]
>>    uncore_imc/gt_requests/                            [Kernel PMU event]
>>    uncore_imc/ia_requests/                            [Kernel PMU event]
>>    uncore_imc/io_requests/                            [Kernel PMU event]
>>
>> uncore cache:
>>    unc_cbo_cache_lookup.any_es
>>         [L3 Lookup any request that access cache and found line in E or S-state. Unit: uncore_cbox]
>> ...
>>
>> sudo ./perf stat -v -e unc_cbo_cache_lookup.any_es
>> Using CPUID GenuineIntel-6-3D-4
>> unc_cbo_cache_lookup.any_es -> uncore_cbox_0/event=0x34,umask=0x86/
>> unc_cbo_cache_lookup.any_es -> uncore_cbox_1/event=0x34,umask=0x86/
>> Control descriptor is not initialized
>> ^Cunc_cbo_cache_lookup.any_es: 14361103 1853372468 1853372468
>> unc_cbo_cache_lookup.any_es: 14322188 1853360415 1853360415
>>
>>   Performance counter stats for 'system wide':
>>
>>          14,361,103      unc_cbo_cache_lookup.any_es
>>          14,322,188      unc_cbo_cache_lookup.any_es
>>
>>         1.853388227 seconds time elapsed
>>
> Ok, thanks. If I use events without a prefix, such as perf stat -e clockticks sleep 1, will this also work?

In this case, yes - it would work for uncore_cbox_0/clockticks/ and 
uncore_cbox_1/clockticks/

But you need to be careful to here - if another PMU has same event name, 
then it might also match.

Thanks,
John

