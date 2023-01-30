Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03BE681D91
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjA3V7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjA3V7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:59:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47597EE5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:59:19 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UL3psi014361;
        Mon, 30 Jan 2023 21:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=iKZMhz6AHpORnDj//TUEEpm80AlnMTDxmpkmD2rCEyM=;
 b=GXiKUniLxjhB2sFx5eAbEiSVATIUXyw1FLzA+vtFj/2Acv3hjvn6beb07zbfH87p6iB7
 BYf3lK3tmksFWJ4U7/RZ3It4ePSPuNlRmohh6R1oBVW9IFGrdCARJ7xvzovuis0s79mJ
 NKJjNr+FjJPKKhWuxEmEKCn4n1ZJxJBMhs0pBXtxfIkKtjgcrHhj1tEvw6VdxiBLCTyr
 woLfIAB/okijLhuPgOQJK4UpSnk34druNTQ93euVMuWDIfolShYHd9VhOFnQsBnNn3It
 jnvlu0BU7PAnPHuVGEx/bwyW9uvOndInnOWnaWr+0JGH9kzhGq37WYMDJEaIFwqWpenH kA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvmhm3na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 21:59:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30ULvmvn039499;
        Mon, 30 Jan 2023 21:59:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5bh24s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 21:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+Lr0Vul/E8KtQQXbSzy1iVSqO84cSguV72Vbg5JyN9ZebsLMEUdLjoReCKfVpppT4cpWCr2Z7d3KVIjiG46pBaTlgt46QIZ6BZpDEhHiQegAZH8sOlH6iiNi5/ds4Al8iz5OwtVcoVH2Cfn3OX76ZuI573ClQdOpWhfZAelIOLjbbiWGtcAdthGa9gi1UOg0lT5PfG24qiw7HtJoaBIO8IBTT/QPEnrrCRspZ0DN7RgUaHgccIYWnw9gdP3mi7/y0U35jLQmHmIj3cV9Th4zELO+zcjM+zjdzvgTsr3j4AA9Y2M7y70Z6DBWt9AeqPy6xPeN4tBVnyCwOR3OcaT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKZMhz6AHpORnDj//TUEEpm80AlnMTDxmpkmD2rCEyM=;
 b=eSUxwFbr0+jo5hJM0yMI0FczZGvRAT6EpUi+KhBUgJZi/JzmA05dVLC9+n21Sp/pNyLmP4fyVrlUl9vRxSWZ4Oek/DyLAp7tT2z95Ar8491DYPQx8pyNmv375P7kSY3UxWtB85QCPX6r7RHPzK1v6mcV+uqm12GTKx7snCqqRBeNrA7zLAOktApicXKzaHUOHCPy6FzxK950SH+mdrh/W7vAD+rr9NNTNAqxhK+xJC0JhWnF7lKw4VPvIbB/XcIESLgJp4u/uqBbSB3bQeI7tvybSfeYU6h7GWIxR+3R1lT4fPEqog9+SLH4J2OLmQHSEu0eo9c4FJ1HZwQett4zjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKZMhz6AHpORnDj//TUEEpm80AlnMTDxmpkmD2rCEyM=;
 b=IpQzb4esmbkBEnB0Jho20fkPC0PCFgDsHHedXgBrpSLMWvwerWZkA0ufcqxH5fWgLlh6VmXy9n1K0FnUHxOYgHC1zRrqcFqhtmAmay4OKtXWEL8EfZ+Cm2tfIY1YuHTdWmTJKBW+nM9AHJVKMlEzGsu+PCmhWq1WHpM4USzS5Ow=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH0PR10MB4857.namprd10.prod.outlook.com (2603:10b6:610:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.21; Mon, 30 Jan
 2023 21:59:12 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%6]) with mapi id 15.20.6064.017; Mon, 30 Jan 2023
 21:59:11 +0000
Message-ID: <23b27c18-b843-9767-722e-2392af676afd@oracle.com>
Date:   Mon, 30 Jan 2023 13:59:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/4] vDPA: initial config export via "vdpa dev show"
Content-Language: en-US
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <20230127031524-mutt-send-email-mst@kernel.org>
 <bbaedcb9-2290-d559-31db-def09363fd0d@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <bbaedcb9-2290-d559-31db-def09363fd0d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:806:125::29) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH0PR10MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: fff3438d-46cb-4ba2-7098-08db030d383c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EacaaRHSD6oLjpRj2gYJC7fhT29lGyAXXZINiWYn2Cks46g5V02LlnlMFcqvHnzT5M+YJwkyODuVpw3uaS1jRNUStktdUE1hP1HIV6UV3S2u2/t7KM22HJsp/7QvRbAcrbPF8O/aV724K7XExGK/BMaLDT/xEWhrO/uI/Ydo6jxi8KZ5NJmK+eNqDc8/8zDNIjR2VEDoKbeTd5PiiMDAxeo6pgKxIeyPfxi50PyciXG+3NQG4wUItybOfmgl0Glk4jtGb7hf6co4x+lGIU42Yo17CEPd3Fei3c4lnAMrvl+vmDR+S/qXJMTdBAccDn7JzIO2IPUBQREdevpIWpbvPSsXRWNHCaQTuz/kiw86IdKyt7ag6Wwy3fbmougt0anC6s1cTsTUSPcjIzG3bi0tmslpwxKA98PWBrE7lE2vyNZ6iAdpailAPWJvySIdYO7HHntRkGG4XIW0/MsQeHUNdppIfRvz7Naycp6Rnu6F1s04TboH4OGn2s/LlTW3SORhL6fIVzoiNBmzQqGzCreh+NeBs47WSdyyMvxA0JW/VDwr8OiAsVA3m/GF4/gn+fYaTCNYkc6Dpujf0nR/Y6uA8vPFrWg+Ddx05UaJDW7c9xhAKcKA0n6LcpMAWyAFx6rtv7IY5O9ljFu/gY1AreosdHP26oj3T02rRk38/bgErYULeWV7KhxzyTmvTXeQzLDXIBt9ech4col2VD4wLWwopKJu0tjLp8m99turSwFo4W3t4evEg8oUcfm/HCVHRtLtsq7sEmu7qO4xkBVywxkm/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199018)(83380400001)(66556008)(66946007)(8676002)(6916009)(4326008)(316002)(66476007)(5660300002)(53546011)(8936002)(6512007)(6506007)(26005)(186003)(86362001)(36756003)(4744005)(2906002)(31686004)(41300700001)(38100700002)(31696002)(6666004)(966005)(6486002)(2616005)(478600001)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWQ3d2JxV0tLMm1GR3VjVUI2V05pdFI5ZDFJaFlPTW11eEE0ODYwMElTTWQw?=
 =?utf-8?B?UVZnT2UrMndCS2NjV2ZPZUgvTHNaL2NPUEtDaDBiZDZQME9FSmxKOGZBWDkw?=
 =?utf-8?B?b1I0NVV1RExrbjNzb3lYd0xXTnluU09uVFpnKzRQVEY5Vm5YMk42dXNMK3Ay?=
 =?utf-8?B?azNTU2Y5Y2JMby9OQnBnemlJSkIyVDd3QmxLZ0NRSTZGQmkzRTNURkFEWG9X?=
 =?utf-8?B?bWl5Rkh0TmlyQUNadWFIY2hpNE9BNUhMY3k5c0M2REwvRkd3UHk2cWhDMU92?=
 =?utf-8?B?eVQ3cVFLT1N5L0htem12RmJCcmZRRTRyeWNUVGNicHJ1Y3U3dDBqTVdzTmtq?=
 =?utf-8?B?U1ZuVHVMYkxpNC9OSFc2NTRTZHFuak5nTGJka1RYTWRVU3BLUkRnTzVodmdu?=
 =?utf-8?B?eXZ1U0Y4bmJwTU1zRUpiQThRM0pSMzF0VCtKSnBvdStYY042TlNDekFoeXlm?=
 =?utf-8?B?QnljdzUxUVVHOXNJWWpyczhKQVRxVlA5Nll3NGhUWmZvV2plQmZETVFpTHI2?=
 =?utf-8?B?cE05dURyVzgwVlc3aXMxMnQvOUlzcHVacE5GMGt2QS9JTjF2RVdQSHJPQVMv?=
 =?utf-8?B?SXBsWVZKM042bVRXQUZHME9tV1JDV3E3QWpMcXZpa21QWjlYcm1ML3JqZ0F2?=
 =?utf-8?B?enFVK3k4NGlhT1c3ZXgzandSaTMrRWg0ZVpyZjRtbFhUVXJzNGdiTDV2bE5U?=
 =?utf-8?B?VWtzY2tWRnYxSnNzcjhrMG5Gc0tXbzRIK3VPc0N6dTBGR0RXTWlyeXJCd1pk?=
 =?utf-8?B?TWo3K3BzcmxkRFp1YlRkUTZxL0lOOVY3RW5ZNWFhY0VCRTNyMThIYWtmcGFh?=
 =?utf-8?B?RmphcGYxOEFMbmV4Z1RTTUdsc3dLRDFJN2VjY0xIM1hFdjByd29KZUN0Zitx?=
 =?utf-8?B?aThHOUgyalZCWHFtd0JpTTB4dHVJZXRYb2k1TXhOallaYXJiN1RpZVlQUUhG?=
 =?utf-8?B?b2xyS0UrUmZCVmsvQlpaMzBPRGc0SE5maUFzeW94WUhSZjM2bjZWeElab1gr?=
 =?utf-8?B?TGxlU0pOdy93aDdzM3JHZTllQ29vclVhT05rMU1sMmljY3ZjRktrZENteXov?=
 =?utf-8?B?K2RSMnMyUEFyNWdQblBRNDEydVJqQWVDSEJIOUpuSXBZLys1RCtFTE12b05t?=
 =?utf-8?B?emlLQTFGbDFXeldTNzd0c25ndk0zRTN5QTlTUTlCQk1LaWZjMDFBemtrWG9R?=
 =?utf-8?B?WGt6Qmw1T3pnZFdzTnpqU25ZN29qQmt0YjJyOEdtQy81bFlHazN5Q0xlSHJy?=
 =?utf-8?B?SVFBMERSeTRqdDZ4a0JYRlkyc2J0OHZPaTYzTjc1VWNwMWlPU2syVjB2R1Y5?=
 =?utf-8?B?SWxjYU9vcURUb0dBUEpkenM3RmFFZUNtMU9hU3haNkl6UWdMQ0FmbkMzQXdF?=
 =?utf-8?B?N0NPdHpkMnpyRXRxaTZPeXdCc1p6OHNNSlZXczc1NS9zbEN5WGE0UURBU2tZ?=
 =?utf-8?B?MVFwbm9kYWp4UnZlUjR5dXVpRkE1cURRVlRUYytXcjdiUi9DeFV3ZGE4Mm16?=
 =?utf-8?B?M1QzN0lmY0N2ZDNjWlpiNW0xbGY1UFhUWEVsQjdBZDdSOFpLVnBuL3BCNy8x?=
 =?utf-8?B?L0M1Vmg0cjBFZVU3dHNXQkllRExTSEhZMzAxTys2M2FwaGZzdHIrZ1crdW1j?=
 =?utf-8?B?Y3B5U0JTUEFlSjJTelExYSt3eWxYaUZqTXJ1d0tQQmFwcDF6a1ViQm9DN1JP?=
 =?utf-8?B?Y2FhR2dGY2MySlFVOC9ld0hpOGRNTHZjMmhTSDZRdHQ3NFJzVHRDUjFIQnNq?=
 =?utf-8?B?QjY4OUllM1BQcmt1amtqK2NvM2dEdGRCYStIakhYcytoaW9RSVlwK3VNTXBM?=
 =?utf-8?B?V2N0QTQxZWZSMytRYS9wZXFoMXJkUjF0YjE4cWFKbGU1YjlCZ1NOV3U0U3JI?=
 =?utf-8?B?OFJadnlEeis2SzYrL0tSQXVxMzVONEUxekt4SWI3dU5pcXZra0dZZ241N3U3?=
 =?utf-8?B?b00yNzk5MEpMMVhrM0VrMW1DWUZRKys0SU9Pdlo5N01qbDZhTWxOSmplbWY5?=
 =?utf-8?B?T3BRTitwK0huZXBaaW1pVDc3Y1pPTE9BbFQ0VUp0eXpRL0crLzJ4S1J6M1N0?=
 =?utf-8?B?NmRYdUYxY21wVENqdjk0dkdRK0lTNkdtd3FaeTlYVElmd1Zkai9UZ01QMC9S?=
 =?utf-8?Q?wmghOVsVWbdmOemN928pmmvWQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CqYEn+5DEP2xWvmjl5QvuNkxHRrBBoiUoUAph8wkdC97lbUvDnpkdmrUt+we7MDd7G4MtFo7r3Sg1T+klaLF1AaoQbIb3NvJQaV6zb/lGw3jRCObvCyjH56gbB2Uvb9fgAubyzWXjNnWomFqlo6HoGh8FZbuhJy45sxvwwenu0SZjzls7s7Dn0oGi+ITMVVC9jlCfmS04tC4ePcoL3fb7EMgiRhVfTiyi76xMz/uMM6Z/bFYnKObx7Ftwb13Ht3GIzZSAeFWEWSQLd/IX95Dxeju2vMINp5UO90TjpLOAaHxOgyzjCP2Db+SbreOABEr2HW/yHgOiNgUqla6Vjf4w32pt9adR872VQOM09g3VXrsziVhLUcCcwtyXHvVUPpFmXB7lrRvA0zeBZF5GWBVIohmlVpB/eoQpfL98ZPakMviiC6JOXK7/YYlVJl6lQlgntmS6WkB5fF+ZdRcnWq9FAFuuiLUSONRlYBI3alKHIHB9qnU7ZoJ3pluv6DCvF/Ty2dlCNZYr10xNSkSPm2GPL/ejyzJIap7uHD14bh1VSMVs8PZZkbel5JYaYjN8ppsnbWvL/c8WStyIbZbeYapB5mp9QfUt3pt8IspmyJ2HHKeuroUrvfGRugDcTGnU+/9p9ksAU7xokHDY9Glg49teapJbI3mjhz4Sh3ADfMzqlbybuM/5VCV0Z/BLDmT2bweGaOIe7Qt/yVwNx9k2XMiGJexrXoCpTc8qQp3tUUJXi1mSYsPnLIZ7Nqg4qOs3yb3SbU5hgEKC+xS02boPcfJiQQhkURvrOGZo5lRZXj6WD0CoXGPrYrnWjV500magCqkBjjVvEUE8/cC19A1+X4WF9/9Ca6COeEXBkiwJyE5zSnAA0sYWNIQXmoNYueGCLqLKvnTianlV8XuP1JVo082gg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff3438d-46cb-4ba2-7098-08db030d383c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 21:59:11.7875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6cU6PPQKVUt72Lryfit3AvemrqIQm4a1mBtFXsN6BpOnWQjTN+9WWHALCPXcqHaFTGpyActsSxh72LgYPL7oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300202
X-Proofpoint-ORIG-GUID: Bu9UlcEkzjtfy4Bws5YVGUxLnP6AXRH8
X-Proofpoint-GUID: Bu9UlcEkzjtfy4Bws5YVGUxLnP6AXRH8
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/2023 1:05 PM, Si-Wei Liu wrote:
> Apologies, I was over booked for multiple things in parallel, and 
> there had been urgent internal priorities popped up at times for the 
> past few weeks. On the other hand, there were brokenness or 
> incompleteness identified around features provisioning while this 
> series was being developed, which makes it grow a bit larger than v3. 
> If you are eager to see patches posted I can split off the series. I 
> will send out a prerequisite patchset for this series shortly.
Patches sent. Please review:

https://lore.kernel.org/virtualization/1675110643-28143-1-git-send-email-si-wei.liu@oracle.com/T/#t


>
> Thanks for your patience,
> -Siwei
>
> On 1/27/2023 12:16 AM, Michael S. Tsirkin wrote:
>> Did you say you are going to post v4 of this?
>> I'm dropping this from review for now.
>>
>
-Siwei
