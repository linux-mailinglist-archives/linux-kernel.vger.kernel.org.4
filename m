Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32720711852
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbjEYUmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbjEYUmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:42:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396D31B4
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:42:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PKZMkJ001599;
        Thu, 25 May 2023 20:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RX5SW/tnVQ+oSQHJNdncdTCQytFKYHjZMDQOZHgF+HQ=;
 b=kpbWjk1uoDvj4nKlOLqe+oHbrwAN7CH7lg568Wcd8wwSEFhMHS40FyJQu9DzbNy2InD+
 FuMi1UuDwpfTIJheHdkqNzsIvLnp0Vzi4x24rSfhexxZZs9UXIWxWs4R5u0iLZbs55A6
 AgjZuBLqEGjMM1AHH3I70jf7QqbizoLP2pRrmRK05H92porcE4ia9wlCcGiy5gl3iTgN
 28Rhj0I/w+QN7r0+eO/3V33/llA0MAY83HELlyr407az1UAnOmClrMY7rmEq0R467HlI
 VWKR9MUOUd9pRMv0qpPGiqDAuph+Uk8TNk8J6KsXUMIt6TWumvJ7m4L0BtpytVk9XibH 9A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qteu180fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 20:42:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34PKUPMr015883;
        Thu, 25 May 2023 20:42:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk6nnqeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 20:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHZJVKsHoPIahfHYJEGQeq3CTCQqqFSrlI8pj4j/osi7kuFYqDncxnPtEiExSYTBzL0l9rpWj1KB1UxfgrxA9AGZizF3lIXUNp9Whr15toduSnNPjCCjPJGLplNRgLwZtj4feAviQi54/sLSMyDPl9l/S1fSFNY1yphSEDzjF514KPtLjk+ElllnORJfhdb+yNMInhwrwX0DgsBjl9Htk+CrBxIWGiI80usNPKYnyLRFQmyr5oBCF7Ti7tjBMIElG5w3wn6aCLj8+Ydnon9xpEKvgVSOiGKlwUTcTo08SBBYFKRQq7es5w0AHFmd36N49dLe5wNYmTZ8IiSUy3phQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX5SW/tnVQ+oSQHJNdncdTCQytFKYHjZMDQOZHgF+HQ=;
 b=GB/A0wXlZV7dfEW83EJiwfUtOwGQ6gAVYHEsxo90nX/YJv+H8MouBotQY8Ol8W1ttmaWiDMiAydQCxIffhoxEhOLq4Vp/xn/uq23M9Hxvje4+tK8AFMWlr5H8WOBPkSG+DFPLA+kZh5vZFn/DYQ9GwR+vSpQuj7OrPAxaq6DdTDdgtPoD5R9VkMXaTRAIFQgaDS8Pi5SRGzjIq0GSJiBB/wnKh5zAK77GUYwFyBrFa2rtF6waHVhvxh2NbnewNk5/R0MDLxp35OZPQf4VDaXqSa1/sze6992UFwDf6rlCc8kW8cxMgaCiefitpUKWnOlo3tp+CA8DtHoViANulpi2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RX5SW/tnVQ+oSQHJNdncdTCQytFKYHjZMDQOZHgF+HQ=;
 b=VloXOEnm/82p9KI709L7DPRwBlUP5CC3UEN+lZMFF+rF7OrPoXoU9SADK/u99OmZ3M7h+r7yryywK98R14JMrlt50Q4Y9yRpjEWDZ6heK9CmEx/XPlUKWPodDXPJeVaUdaRpDEHd30JSrVjHGUiv2bl1GmKiiBolXLP6uRY866A=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by BLAPR10MB4897.namprd10.prod.outlook.com (2603:10b6:208:30f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 20:42:06 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%6]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 20:42:05 +0000
Message-ID: <5faf6862-e3af-eb3d-0a03-0f8e58a08939@oracle.com>
Date:   Thu, 25 May 2023 14:41:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, steven.sistare@oracle.com,
        david@redhat.com, ying.huang@intel.com,
        mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@kernel.org>
References: <20230525191507.160076-1-khalid.aziz@oracle.com>
 <ZG+99h3zg7POIits@casper.infradead.org>
Content-Language: en-US
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <ZG+99h3zg7POIits@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0694.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::16) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|BLAPR10MB4897:EE_
X-MS-Office365-Filtering-Correlation-Id: d195d5b2-a8f3-4f9d-4feb-08db5d60805c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/eC4OFvqUXBv5SZEYLzsPFBCxxciUXEV7hxuC8s+CcBnAm+Iq3nnVGY9m3Fat0S5OUukSV5i94DOux8tTVtyHS/6BfCwTdivC5rgkxWEOlhEcWmh9ThXozTfIZNkx3viV3hUlWDsRLtCLO4PDEnH9iJ3J7heUCmFE7kZ3y9ehccvDbd06zkNbyiYrjn4Fro1XZHug0/vZMiQq8u3XoTNvaF3Zcyr22jlxi11qvJiZgo12C5WfxNvsRgZg+YH/wPmNgNJMgVxMSuot7tTSwd578356+DEm+9cMg8OS7mQpNMKK4AWlzQzvU5hmoo6nhecNrbsAxyejocywB3gQ9Ql73NSvYMCRVRJbHD+EJM+nhBSwyT5sBq/dgVoh1I3bgaB4A9W25YjFhBufrD1nyQ7W3NR7J27IPC/qkl9Me7EjFPKOfrJ20Aimc8Gjc+UltxOvHf/4emfFGP51QNl3gv6riNTwMhU5kdPaQ4jRnT2x6TaoNq0CCxzgdoCEzB4tbuRIK9N42svxdmmImwjSDzI/swB6LqnJ32UUzvfvhB7aw7AFLexjb+rfVj+aVEjy676mgSFsIj+xrO5AI5WFyAQJwRci5LSF6L4ZQ6Tui1pMSRLP0Si35FrPD82DmM5f1TSjtLdGDP9u8e9LaKBkoYaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(31686004)(6512007)(6506007)(8676002)(8936002)(44832011)(2616005)(26005)(186003)(86362001)(53546011)(4326008)(41300700001)(36756003)(2906002)(66476007)(66946007)(6916009)(66556008)(5660300002)(316002)(83380400001)(31696002)(38100700002)(6666004)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0Z1eVM3aUZoanBiT3RyVDl5ZjFGU2FpOVlCVC9qVEdQbytLcWdlMzk4eDRk?=
 =?utf-8?B?RG5SdktjcDFENHdSYlpmMTczV05ieVNPcURCc1BsTDBWbTJyZGZGMEVqY1dk?=
 =?utf-8?B?ZlJEQm9PRERpbmRPNEhmME9rT3FXQjlvY2U1dFRNRXhHWldROGZ3OHlyR3A0?=
 =?utf-8?B?WFhGTzJmUUlmV1lMTk5YWUZSQTI1WlFjUCtrR1FrWnFIZnpwOTNSdys4SVl4?=
 =?utf-8?B?c2ZmVHB2NzdycDNMbWJuMVUraXJnWTZ0clUrQWRiNTJ4eEtwMTJDemRzMDlN?=
 =?utf-8?B?QkpDQ1BLdlpPSjdpVWU0WE1QY1FnajAxOWcwWXdiVDhIU0QzUDZLNXFzNU53?=
 =?utf-8?B?Q0xoQ0pkcEJvUVdTYUkxdllXeDV5cjJZTC9yVlE3MnE3Z0xldUF6cysyMU9p?=
 =?utf-8?B?aXh4TUc3czFiVldvQUdZVFo3Q2xlSjhOT3hUTFpnZ3hLdUl0TTRpVkg5b1Nv?=
 =?utf-8?B?Y0xqM2trZm1kRmttR281Qmo3VXIyNDBUdkJEZVlFZkl1VWxLaDNXYjBEWVd2?=
 =?utf-8?B?RUdDdm9PdWYzMjRYalpENm9GY1VRMkw2TkxaRTVNQWRRdkFuNm1wMDVtQmlt?=
 =?utf-8?B?NGttaU5jK2VmTlBBeHJlZkNkVm1TWmp2Unc1dUZqbXExK3ZubDhyTnM4UTZK?=
 =?utf-8?B?ZHRLWERUanBxdXlseTg4WXc2UnlIQVBRY1l0bkx5QXZ6MW5xZFVvVmthd3JZ?=
 =?utf-8?B?WXg0YmtIT2hyVjdmSXJZVWNhY252YzQ2M1hqYWRBWFJVUzNqUFZIWFI4OFBx?=
 =?utf-8?B?Tkg5VWVHOUdEOWV1TjAreDR6cUJhbDBuVE1zczFRQWZxcFRQTE9ZT1FTSzRM?=
 =?utf-8?B?UnN6LzR1T2dMRms5TzJZV1BubnJkY29uOXJrV1dYZWU5aURmK2RROGttbkg2?=
 =?utf-8?B?VXAwTjk5ZitKYXJzYXFCWWh2MzJTU2sxVnk3c2JqQ0FiOERvczdwN01semZO?=
 =?utf-8?B?UXB1dVRPbXNTS29kWTZGWkVzUUhlbStEMk5XVENYWXhjWk5wcVhtdENzc1hp?=
 =?utf-8?B?b21laG0xV3c5Q3E5dWRNNlRKYWhFUXNmWGZxTDcva3RsRDB4d2F1MG9Xd09U?=
 =?utf-8?B?dElGVVVUU1M0RWdFcFYwdlNGNmF1ek56YUdETTFDcFU4aVFpd2RJTWY5N0hW?=
 =?utf-8?B?T0g1cExNMkw0dVF1K1c3OWlDcE4zTGxQbDVpdGRrWDFUdC9VVzR5Ni9wOTll?=
 =?utf-8?B?OElhdk50VithZjdiNVczQmJzWVZIbjNBaEFKZXVjY20yVVp3WGhRVlFQK1o0?=
 =?utf-8?B?SlpqenFaOXl1aE9YNytpOG9vampHZVdvR0x2VTYxbkdra2hxMW5lV2I1a1RC?=
 =?utf-8?B?OWtYaXZ4cW1BajhUcDMzSVMrcm9TK0F3blF5di84bnNLenA0YjQ5eXlNZnAz?=
 =?utf-8?B?ak9jbTdXZzJkTnB4SjBXWWlmQjc3Qk1tUE9yemJSTEtBZ1VGVzBNK0NoTFdk?=
 =?utf-8?B?aW5mUHVWK0ZEN0pzUlR2RUhFMkdlZXdVcWRqbGp1dENTVmlnaU5LckRoWCs3?=
 =?utf-8?B?NDlhRzEvb1Z0WU5UaThRL25ZOXNJRVlaekdLTlBuU2E5eFNwbG9XTXJkLzlC?=
 =?utf-8?B?MmxYdmREY3pnMlJkc1YxbkFYYVpNMVd5RTllcjBUSEwyVHJFQWdIMGtVckpw?=
 =?utf-8?B?MkxITVJhVTMzcWU1RWRwOWtlbzhQblRvMFFwK0RCZldWL2JpQzQ0NWowTEg2?=
 =?utf-8?B?V3ZZWCtZRENCZENQS3dsYlBGRU1hVDRmQmQzS2kzKzFpUTFpREt4Q0Y2L2lT?=
 =?utf-8?B?RVhEZ0JsaG55dTF2QXRYOVlDeGoxdisvRFNVb0w1VGdTMHFXazJKbHN2eDNw?=
 =?utf-8?B?RUJ1dzlCdWJIRXlMdUNEZnNkRDY5d3lqUjNjSzJadXlIS2FCZEpWc1A4RXhT?=
 =?utf-8?B?dm5xR05ndzJTc3JHSWhtSDVxT0V1bFE3Qm83aTY5M1FIWGRtY2lkMWdybWpJ?=
 =?utf-8?B?VHlkOThKaWlNVmNBVDZtTHJEOG5Oa010SEdlRUlTRk96NzN3K2ExanZZUC9a?=
 =?utf-8?B?TlpEQ1NTK0s2NmlVY1FZWVhNSkE5L2FYZ2VoNGV1MjNtVFN3WTlGdFB1ckdW?=
 =?utf-8?B?Qjc3YmwwTHhNNk8xU2w4Y1lRa3AxMStUK0xHanVvdXl4UzdFZXNxVE4ydWlS?=
 =?utf-8?Q?xGy45pL0jK4pd7RBgi1m0/1UG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V2VSNElGelhhUDZYdXJjZTBuVVVCeWRnNG9RUlRDUjNvNlljam9MZGRBNG1V?=
 =?utf-8?B?NE1VTnorUlhjQVZqNzFHdVZuUjZISUsrakxGWGxhZlp4RDVPNk9pOGVtUWpl?=
 =?utf-8?B?eHdJSmRMQjZ0cS85OUo3MzI5L1BRczNhc3dJT0t0a3BuNXdkd2w3NTNqUG5n?=
 =?utf-8?B?QkUvRm1JSjd3YlVGOUQ5M2R0c2xXRjJzdkdIOGdzWkFKT1B2NE0wYXREc2Fx?=
 =?utf-8?B?bFpCdUVKSWdpUG1nVjlBWWljd2ZyYlBuTjJ4dVNOS0phY3hxNlhqZTZnVno5?=
 =?utf-8?B?cmJ1YVozZjRnSWo4UVNZaXJTYXF1YVBDSGEzbjFpRDl3UDUxbVFOd3pnVG5H?=
 =?utf-8?B?aUJFdjd2TS9ZWjA5MGhSOFJ1N1F1OFZZaGd2NEFScVNkd0x2RmhqcHZYNDB0?=
 =?utf-8?B?K1haYmxyVVp6NGVIRnM2YWpyTlNXTjFHUlh6c3V5YWdBUEhrekdSTzNNb3FX?=
 =?utf-8?B?ZU5BK1loVnpmTWJIZTlJcFh6cHVuYmhYTHFwWG1zdDZLQlJDcHQ1aFZNNWs0?=
 =?utf-8?B?ajZyODFoZC9Ld1BuRlJRV2ZhdjB6QlNoQ2t0WElWMDFEcTFCbDE1TTBQb2Rq?=
 =?utf-8?B?RFJCdnV4dmN4emR3RzVTWHl1UkhHSlpsUWhyWit3VEticEwrTncxcmNpbjEv?=
 =?utf-8?B?eGJoZDFDN2ttNk56MVBVT0h4MHhpNGxkaUFZQ3kyYkZ0QUxzK0NaR2lMMXpz?=
 =?utf-8?B?cUpWbWxvRjFNTm1FN05LUWR3RzVvZGgwNEhqRzRYRnAyMWl1RkZUbDFXOVFD?=
 =?utf-8?B?NGJPRUtaK0lRM0pMZ1Z4L2MwVHYwVmFNUGtQaC9yQXVSQ3RNaEdOQ0s3MkFL?=
 =?utf-8?B?Z3BUQzRpODlsblBkMTNRU0w4aVNnb21RQ0VPL3pzM3ZNazlWR3o4c3JoRGxi?=
 =?utf-8?B?RlNtSHhqbjJra3V1NG51aW5lVmFSRWhVUEdJZEU5MXp4eXdEMmszQmpzeWhX?=
 =?utf-8?B?dTFHSmc0RXBFMU9SWEErWFU1SDFnV3pmS3Y1VzRPdXJzdG9TdWUzYmFhc3Rv?=
 =?utf-8?B?dmxSQ0tVZjM2QWJJM1FCYUdzN0U5ek5rTS9FbG1VdWFnM2xuelFPT1hqT0hw?=
 =?utf-8?B?MnVLUG5IQW9PbXZWYmVlN25hUk1kWGwrbkppUUU5TXVVSGN5cjFNVUl5ZFZS?=
 =?utf-8?B?c1hJNWEwMGJadThLYXBHY0hsVW4zRGQzbnlRN1R2cFlGWGFmZEVva2c3TSs5?=
 =?utf-8?B?UkxHMVhTSUNLampmTHE3Z3N2Q25pL3dhdW9jdUF6TXp6SHBtVzh5Ri9jUDQr?=
 =?utf-8?B?QnlRelhrYVlpdythU2cvVmtQOEtzMWpBU2FVM3A5TEpma3RHK1h1VHI2M1Yz?=
 =?utf-8?B?cmNWWlErZjhEdzJ3WWt0d1h2Q1YxZGt4UFVTZnZ0OXFlZytMOVhKY2RWMENW?=
 =?utf-8?B?THd4cHF6MGpaN0N5Ump3b2NuZ1orRXBOR2lWQVJuZGRiQkxTOXRXWHJwZzhk?=
 =?utf-8?Q?9PxJ9gUy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d195d5b2-a8f3-4f9d-4feb-08db5d60805c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 20:42:05.7718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4GutZHXymOLU89qlFDKsLmWxvwkrX+tIvQ3vxtOaJ4nRw3zKCOnrz7NW7GmdSGFDcl1FOzUik7Qy/isx6H0gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_12,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=956 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250175
X-Proofpoint-GUID: gl3rGXDQmBUtEDokbJaKcEw0536OlgyI
X-Proofpoint-ORIG-GUID: gl3rGXDQmBUtEDokbJaKcEw0536OlgyI
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/23 13:58, Matthew Wilcox wrote:
> On Thu, May 25, 2023 at 01:15:07PM -0600, Khalid Aziz wrote:
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 5a9501e0ae01..b548e05f0349 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -764,6 +764,42 @@ static bool too_many_isolated(pg_data_t *pgdat)
>>   	return too_many;
>>   }
>>   
>> +/*
>> + * Check if this base page should be skipped from isolation because
>> + * it has extra refcounts that will prevent it from being migrated.
>> + * This code is inspired by similar code in migrate_vma_check_page(),
>> + * can_split_folio() and folio_migrate_mapping()
>> + */
>> +static inline bool page_has_extra_refs(struct page *page,
>> +					struct address_space *mapping)
>> +{
>> +	unsigned long extra_refs;
>> +	struct folio *folio;
>> +
>> +	/*
>> +	 * Skip this check for pages in ZONE_MOVABLE or MIGRATE_CMA
>> +	 * pages that can not be long term pinned
>> +	 */
>> +	if (is_zone_movable_page(page) || is_migrate_cma_page(page))
>> +		return false;
>> +
>> +	folio = page_folio(page);
>> +
>> +	/*
>> +	 * caller holds a ref already from get_page_unless_zero()
>> +	 * which is accounted for in folio_expected_refs()
>> +	 */
>> +	extra_refs = folio_expected_refs(mapping, folio);
>> +
>> +	/*
>> +	 * This is an admittedly racy check but good enough to determine
>> +	 * if a page is pinned and can not be migrated
>> +	 */
>> +	if ((folio_ref_count(folio) - extra_refs) > folio_mapcount(folio))
>> +		return true;
>> +	return false;
>> +}
>> +
>>   /**
>>    * isolate_migratepages_block() - isolate all migrate-able pages within
>>    *				  a single pageblock
>> @@ -992,12 +1028,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   			goto isolate_fail;
> 
> Just out of shot, we have ...
> 
>                  if (unlikely(!get_page_unless_zero(page)))
> 
> This is the perfect opportunity to use folio_get_nontail_page() instead.
> You get back the folio without having to cast the pointer yourself
> or call page_folio().  Now you can use a folio throughout your new
> function, saving a call to compound_head().
> 
> For a followup patch, everything in this loop below this point can use
> the folio ... that's quite a lot of change.

Can that all be in a separate patch by itself? I tried to keep all folio functions contained inside 
page_has_extra_refs(). If we change part of isolate_migratepages_block() to folio, it would make sense to change rest of 
the function at the same time.

> 
>>   		/*
>> -		 * Migration will fail if an anonymous page is pinned in memory,
>> -		 * so avoid taking lru_lock and isolating it unnecessarily in an
>> -		 * admittedly racy check.
>> +		 * Migration will fail if a page has extra refcounts
>> +		 * from long term pinning preventing it from migrating,
>> +		 * so avoid taking lru_lock and isolating it unnecessarily.
>>   		 */
> 
> Isn't "long term pinning" the wrong description of the problem?  Long term
> pins suggest to me FOLL_LONGTERM.  I think this is simple short term
> pins that we care about here.
> 

As Steve pointed out, vfio pinned pages are long term and we are concerned about long term pinned pages since no matter 
how many times we go over them, they will not migrate.

Thanks,
Khalid

