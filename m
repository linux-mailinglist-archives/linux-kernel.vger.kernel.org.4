Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C2A642BA9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiLEP1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiLEP02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:26:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D281CFC7;
        Mon,  5 Dec 2022 07:24:42 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5DXst2031678;
        Mon, 5 Dec 2022 15:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Sl9bcQ6BRg7JnPzxX3QcZtg/kzfDnQYDkec3NnGWq7Y=;
 b=Tfsefc4t/hDl51LcVZOvb3saDgoJHrEGteBnqC+ndE/LR61jnpNfvyiMqeP0BbUPBdue
 qmdPFXdVQkxLtp3ShkPU1IBNCpZL4BHSEZcqJxjuMY7KBKbfeosPta/vNJRVhRuCFOi+
 GvOseekWtRpa4m3jrYehhWGBeveZZiZNmjbgMBWxiFyFnqFOE9pkEFKf5qapH59WfMvq
 5UfOkBnHejhdSzthgunDXqnPjybX7+HosicR6d8I44RvdnRGcT5rf96tcnHC926aj4Lc
 L18qDoW5V2esso8Be1T8K/M5cwgnYdEaSbl13xGLTfVzZURizpJ9ZHJm8mFtharneefG /A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yeqm117-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 15:24:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5FKcQx039888;
        Mon, 5 Dec 2022 15:24:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ua9a4s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 15:24:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKyAJ0lUsPAk1ZxygJVEN54R9j4e/VnLWIw0K3P5I7gfp8qwgcvtZFnWpDB8LS7WJC/aCVjmUHQmmGhRoKXrwY7XEGyiumIGyga0T66ME3AscNw46ev+UBnJhVbjadXpBJKpwlxQ3lZXFmhywCHd3zNmmDJSkPvJRQAJMC6y9vwMHbXP+URsB3TpANon2KMIL/FhhTpLswy5hGEpTErquy93x9MBeobkW0c+tiA+bOGqmof6PpMYoITAcSl6z0wvEDHi65GpINi3lJPZu2aaiRuo2pew0fOd0VjzXUGkHmPfGSsa+DBDxvKTbLBr+YG1tsIaXVWk8Ept/zd2jzzKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sl9bcQ6BRg7JnPzxX3QcZtg/kzfDnQYDkec3NnGWq7Y=;
 b=nbp7tErbSYenHzPI9xFpJAytc9Z7oPHHyWMCBPIDoBQov9QVCQv+rR3OQsvG25qdNlEmVnRaY/rNBQU/p2iLAygothSMg3IzQpSbU3Aelle8JgCs/bXqkazg9LYP0jT0vgvGvyLb1NDntPOj/dLnE9VnxipE5Ponk1J6krpd/GqEtEBq/AJVu8sV90F1bQTUmCOzZy5NcncZPGocBVvwcTY5TArnRtWw0e2ruy5PsCnRKNgl8n5uy4iSpV0iwfR8hyGbf6gBcYK/6wB/2Y8o/YTusDe+1WtaVEvGQzvOvDz4byoHGRMNsmHHhF9VaIX3jC9HA/FmfvAAl+BEVqb02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sl9bcQ6BRg7JnPzxX3QcZtg/kzfDnQYDkec3NnGWq7Y=;
 b=uvXi1rArZ9t/KxjLxqjpwe0JcooUnOVe8QpoLMpATM0BsX+b1rpTXVpZtRtP8GBSmW8tTL4zIYO+xl7a5P+5hSGb2VYndENuhqfOfpM0YZmO0NJydmCBHE2q3IWULQu+7SzU4qKslP1qPRPjNWtq2VoxOHdOIM986u+XSdXDBts=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5111.namprd10.prod.outlook.com (2603:10b6:408:123::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 15:24:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d%8]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 15:24:18 +0000
Message-ID: <61e2f5b7-e332-08d1-7ffb-404cecd23ecb@oracle.com>
Date:   Mon, 5 Dec 2022 15:24:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] perf jevents: Parse metrics during conversion
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20221201034138.417972-1-irogers@google.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20221201034138.417972-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a46dfc6-8d32-4d3c-1dc1-08dad6d4c684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BaErxYWQwvEcJgZdoUXt3xEwXUxPUeXoK8poT7us0wmjx6Ojf8B/Pb9cWqrGREj9WLxfE9ib2Z1dyJE3gs5527SMLQG3ZN/868n7b/ADjJ10KlJCmuug5SNMfZpSxFYNaYYT9zAwJPv4vS0O7kOyuRc7B8ygBrylRd3OoH6ZGF2te1fxUSE0NAVx/8ZqVdiJh4pZ64oRPA5WRl0RJFZRNOFtR80YWDcEL9HNhg+UP2bQh/AZB5VqlHtTOfaYb7rfGUSI0SPZlnifG9nkcBqEb6Vri9VASiOB1p+ZFARBkKyzda9G7xbDLMS9Eakv0LRBlD0u3w8EGkqJWe366WX5DrP9yyTJ2QNJsbsZiP8z7SGgKz+Sctl1aHHI3YiwxC6gFtu7eF+X/kej7DKqT/MMXa2FW+dUj6wJgLAg6sVJxUa93pqgAnkYTx3O1ZkujMdeA7hfPrihONcP2+pKGJxOKF46vFpqsXoulN5vXDjdkGEXTEzOcGbf+sx2YhcO5jgmzqwVLhWX4Pu7E9hHXVO/3EkBoHmLJqns4s1lCVg8fZml12jQ14u/E0qt/ZKrQPJMpS/IVUg5cz0yW7hQNTIq5Gaui5xpN8KPZ+6CTKUTE/hjKGm3EDx7/stXvU5ieRbMOh+kdEVtAaVGLgUMxWPZVUKKqQDkbaOypjHsdN/0aJrR0pfKClLFtXwOF1kTSSm3+rlIPJT11EBAU1Fp2/b0Q8h96qThVPF3fiHAftS55vhpoB3KwHtgicNqQQg4EuKv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199015)(38100700002)(83380400001)(86362001)(921005)(31696002)(7416002)(66946007)(8936002)(2906002)(4326008)(66476007)(41300700001)(8676002)(66556008)(5660300002)(6512007)(6506007)(26005)(53546011)(186003)(6666004)(316002)(2616005)(110136005)(478600001)(6486002)(36916002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkxRaVMzZTFDektwRnMvL0xVY2RRTlBTYjg1QW1IdVFVNldIUFVnWFhOTUh3?=
 =?utf-8?B?VWxoMjB4WGhLNXBuN0x1TG5RWDN0ZGREaUMxOGtnMlhmMnhmbmxldGhCaDVZ?=
 =?utf-8?B?cnJ0UVVYamJRSXhqTVFTbnhheFRkRWl6dXo4cUF1RmVUaENoTkEwdWpUdHk3?=
 =?utf-8?B?TmZwdHM0WjFtYmRXYjRRNGIzZ0pFUGl2K2NnRHRJMmNxdlZGaXh5Q0lIWUsv?=
 =?utf-8?B?ZzNtcEtMakRxSHZHMXhCZDJBNmwwS1dSWlRMd1A0RGM4Unp4Nmx0RHUxNmlo?=
 =?utf-8?B?azIyN3pmM3B1STJHbDdMR0lrMmMzT3U1WGkwOEIwRGgyc0gwc0MwM1JVSTF4?=
 =?utf-8?B?V0Ziby9MUUNORXM1Nzc3S3VOUWtKaWV2bzl1QStYTWNjT1l6U2JoamRPM01s?=
 =?utf-8?B?RHk5bWZ1T3IrL3Uya2dweDN1MTFRODZYL0dEU0djL3J4NWdxNTV0UXlyeDBD?=
 =?utf-8?B?MFE0MllWOXFkZUhWVkpvRE1zUmVKTEdYMUV4WmxMcUlsVnFvVzVKaGtUMUsy?=
 =?utf-8?B?U2tla3J1WngxNSs4bHRGdzZDUFlicGZ2eGw3dW9OOGUweFZPK0dqSHlmNUd2?=
 =?utf-8?B?SzAxampJMEx1eXM4SWp5Q2kyV3VqQUd3KzRGNU5uN1lMRjhMMlUwWHlWbWwv?=
 =?utf-8?B?QWZESElYdURsOGxKRHkwVHpxMXNHT3JNZFE3U3Ird0pSS0hXWDBzWkJENDdC?=
 =?utf-8?B?b3k0enVvaFp6QSt6Y3FqcHUySk9BYmdpRnJiaUFQek8wUTdKeTlpemxvQm8x?=
 =?utf-8?B?V3FoYlhoUGRBUUVvcjVQeC9FbDV4Q0JMcGxmRXpzNEo1RmlnTitrQlMrM2dl?=
 =?utf-8?B?RnRLbGIyUENOcG5VaVVWWW5LbFFSYkIyYTQ5YnA0K29sS0hLUVJNeTJXRnNQ?=
 =?utf-8?B?Y1hXL1Eyd3FydnZIT2hPWnNXZHBtMHV5MHAyR2VxczdpZytieTBsMHJCTTNo?=
 =?utf-8?B?b2hGTXdjb0Q3dzUzNmVZMkZHeVpJMUdVMk52eU41VXB2VXdqMGh6bG9acSsw?=
 =?utf-8?B?ZFpGUld3OVBTNjlqaEpjZll3aG5oUkE0Qlo0aTNwOFFkOWlTTlR4SVN2YytC?=
 =?utf-8?B?UTlIRXNtbDF2eXJDZzh6TjJtVlhZUkdNNWcwK2ExZGJQWHhTOElxR3FSQTl4?=
 =?utf-8?B?SlM1NklpaFA0cHlKV1NTeWpzbjRjVmdJdDVQMEEzMDdoRWpnWDlSNWxMTjI1?=
 =?utf-8?B?SUZkSng3VStpdERqV1hXbjl0NDJiSU55ZkIyeVdLMHloSVk4ZzNmMThFNlFT?=
 =?utf-8?B?VWNzRWdhOS9oTVRsR0cwcDU5eDhlcmlYa3QrNmtGMFRJOExnWFNkME1uMVN1?=
 =?utf-8?B?Wm1DVDV6cmswYTRSd1kwQXYzUXJqSWhFNm9MVHNFUCtLOXhxdmdMTGFleFdu?=
 =?utf-8?B?K09nbUxJdkd2UFBTNVpCWW5ucDQ5WXRnakFMVEZmUlRhVXhhalVKMHRlZW03?=
 =?utf-8?B?M2ZwYWZGS3BsbStlcWxVcnpEVWVOR3NRQ29hdDNHR0EwaDFucHR4emJ2WnFR?=
 =?utf-8?B?RHVBdjFEK0NpaEZwcnI1VjVZMlUwTVZNU1Z3bnhsQ0NNWTkxbWVWNWM0RFZW?=
 =?utf-8?B?dXBxSkcxeWk3NEJqblpJYzVFQ3UvUUdZcExDWXBib0Q3YlZSRXVtUUJNWUJw?=
 =?utf-8?B?aDlYeVBONk9PR3M1bStMQmFIVDdLUkd1ZmI5blFwVHFIRVdXRCtnSDUwQVVs?=
 =?utf-8?B?L2NmbFNKQTk1TVFMaWxPaXU2L1plMFF1VUFuZ0lneGptcmZJbzVIY2J1TTdC?=
 =?utf-8?B?MFpTd2RBT3R2RmM5VUh3OTQ2RllWRmlDVGxXWEVvUnUxTVlrTVVUR1pqWjlt?=
 =?utf-8?B?ZWxDb3RHR3ZRMCtmMUEyT0NSNHBpZGFTZlE3TjloWVc4RWQyck0xSXpncXBM?=
 =?utf-8?B?VG94KzFIK2xwckd6N2pkR2t1OXFMK1gvSmQ5MnZvbXNSNWhxei91UVJPRml6?=
 =?utf-8?B?K2VidVhrR1BoQzF4QzRvL1ZqOVNSV05vWWxsOVdnaXRSQ25UaXlUeDNaNDdo?=
 =?utf-8?B?RmFNK3FMdC9MTDA2YVV6clpTTWg4MXk0RzhpdS9jdW8wVjlkQ1JxN0xmOHk3?=
 =?utf-8?B?NmUwcTJNRVpJdkJ2ZHFvWnM2MU82WkU0TXM5V0tkMjlWUzd0QWdoajJPSXZS?=
 =?utf-8?Q?9JfSFJxxm0yS3yfsqWM34D7JC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?c29FL01RZkFTVzY4TTlMVlNIb0hFK1JSVDVjQzlyd2hQdTAwM3F6NjByZUcv?=
 =?utf-8?B?MktNSVcwSnZjTjhucGhFZ25McHRjT3d1WjIxV3ZnS1ovZW1ETkJoY2RDVS95?=
 =?utf-8?B?V0tLS3pLV2p2bTA0bXBJc0RNZWRIK29wR0tRYmN5b3FqYmFZZEhxcnl5aE5H?=
 =?utf-8?B?VFpCK2prWDNPckdFWnI3UllxN295cmJPbkpXOFFVdnIya0VSeEM4OHJxWUtW?=
 =?utf-8?B?SGlvRVNKZTNiakJhY2JxZUdNYTlDS1B6Q0ZKZlU2ZFcxOUplV2xGbHJLL2VK?=
 =?utf-8?B?cWUraHhGZ2RNTEYxdkxXbUR5aXJVNXJ6R1M0U3NsM2hUK2VCbnlEejR5alZY?=
 =?utf-8?B?ZDlQVVUrcCtCN0ZRYlVyWXNEWWdjYWp0Ynl5SGFvUzFsTktjbzZrTllYUTZi?=
 =?utf-8?B?Wnp4cWplU3VZWkRjQm15SStjekhLT3dTUlVqWjRscTFNbWEyeDlweTZ3NG1h?=
 =?utf-8?B?RFlhLzJWdU1jR0NUNDMrcS8yd09JRm0zZFhmNWlwRU9GdXAwNWlHMW1YWnNm?=
 =?utf-8?B?TVl6ekNiZlVVMkNnN0pYakh5RFVJKzJwOThseTZRUnkwOTVOa2dvdGRsMUFk?=
 =?utf-8?B?WHY2NFlNbE5qNlFkM3MxcTJRNDFwaVpVZzJ1c3JyM2o2MS9YUHp4WldveHZQ?=
 =?utf-8?B?dHlKVGs1SE91V3FZWjczS0MzbjQ2dkh2cTl2TmdhK3VzeitCOFdjOHkzb2k5?=
 =?utf-8?B?V1VCSXA2WXdYVTM4K1VQdDhDQ1piWkw0NVk4WnFmbk5ieEs1c0JKNDhvZFo3?=
 =?utf-8?B?WDlDOTJsZnlRWUFGQytYN1d6VXhBWTR0TE1YQ0lFQXJwTnVVc1pubDlORnFZ?=
 =?utf-8?B?ZG9vODFteUN5L1FyL0pmVzg3NFIyMGlUSDNleGVWSERVblNCcUlSeitQV1Qv?=
 =?utf-8?B?QzlLK1ByN2t5VW9oazNJMXJpWGtTdFBvVlhZelM1bzVHb1VuZDdZdGdiSm1w?=
 =?utf-8?B?aUY2azZaTkxVdTlxQWpGRlpYL3lTTm5FSDlYZXVkVXNNazZoTms5YWVUdlo5?=
 =?utf-8?B?QzNZRlhQNGZRSk51M3Z2aU1pR01OMVlwM2hVOXRxQkp3cko0UWo5VnY0NlJt?=
 =?utf-8?B?bVNYK09qYVhSQTFmSkx4YjJ5OTk3U1lVeDQ3OWJuY3dWVjQ1Yk9ub25YSVRU?=
 =?utf-8?B?MmsrSnpTNEdrYUdLdnJJeDRyemZmN283djh1UXI2N1ZMTVNpaTVsSHB4a05j?=
 =?utf-8?B?SUI2cEF5VWNPUm1QTzNYYUNXc2hhOVBkUzZScDFHemFCaHBWckJrSXlTcThQ?=
 =?utf-8?B?QytkbEl2QkMreVBUK3FuenZxSWdBRUVkdG5kalo0V2dpWEZRaXdpLzlpaDZM?=
 =?utf-8?B?OGZrSU1SK3JWYWkrWDU0STlqc1l3MzVkek1UTm9HUFdiZlMyc0pIS1VwbWdN?=
 =?utf-8?B?S29KSUVmZ0o1U1hpWDA3TjhhNkpSb29ZRzdUUGF5LzVyMFcrVGd5dVdscVA3?=
 =?utf-8?B?dWVUWEhkck9ITjRUVkhZdTdlU0VPcTJjekUzZGwvZ0NsY2RaTXptTC9rSytp?=
 =?utf-8?B?UVZ3VmwyQlhrTm5zNGg4RW5qdlJUNG11QkpqRkw5RE8yQmlPRTFRbURSaFJh?=
 =?utf-8?B?N0hzZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a46dfc6-8d32-4d3c-1dc1-08dad6d4c684
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 15:24:18.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXbCafxlZa0ImVB0SK7Q4YPYHv/raqHVua81AwfTR3knYq+QOF6XgVV16iupgiixb8QjpoKBTkJmU8I7DuiXzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5111
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050127
X-Proofpoint-GUID: VnGFJZ64bFi6YEQlM9Sn8_9diqmAtqPb
X-Proofpoint-ORIG-GUID: VnGFJZ64bFi6YEQlM9Sn8_9diqmAtqPb
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 03:41, Ian Rogers wrote:
> Currently the 'MetricExpr' json value is passed from the json
> file to the pmu-events.c. This change introduces an expression
> tree that is parsed into. The parsing is done largely by using
> operator overloading and python's 'eval' function. Two advantages
> in doing this are:
> 
> 1) Broken metrics fail at compile time rather than relying on
>     `perf test` to detect. `perf test` remains relevant for checking
>     event encoding and actual metric use.

Do we still require the code to "resolve metrics" in resolve_metric()? 
But I'm not sure it even ever had any users.

> 
> 2) The conversion to a string from the tree can minimize the metric's
>     string size, for example, preferring 1e6 over 1000000, avoiding
>     multiplication by 1 and removing unnecessary whitespace. On x86
>     this reduces the string size by 3,050bytes (0.07%).

Out of curiosity, did you try the exponent change on its own (to see the 
impact on size)?

Nit:

Unrelated, really, I notice that sometimes we lose the parenthesis and 
sometimes never had them, like:

/* offset=11526 */ "\000\000metrics\000Ave [...] 0\000( 1000000000 * ( 
UNC_CHA
/* offset=11207 */ "\000\000metrics\000Ave [...] 0\0001e9 * (UNC_CHA_TOR

To me, it seems neater to have the expression contained within (a 
parenthesis) ever since we moved to this "big string". This seems to be 
a preexisting feature.

Thanks,
John


> 
> In future changes it would be possible to programmatically
> generate the json expressions (a single line of text and so a
> pain to write manually) for an architecture using the expression
> tree. This could avoid copy-pasting metrics for all architecture
> variants.
> 
> Signed-off-by: Ian Rogers<irogers@google.com>

