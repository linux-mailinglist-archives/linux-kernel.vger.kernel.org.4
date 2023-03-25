Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C251B6C9149
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 23:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCYWpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 18:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYWpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 18:45:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F21CB3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 15:45:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32PMdvIc032009;
        Sat, 25 Mar 2023 22:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=G21OEEA12ddNyJGv/1tdnL3PFaVVkfieFScDSI0bFvk=;
 b=c2bwpYfLDQp2Vbm66w9kWQ9il1p86Qml3bf8SHATazJdoEm7TB39eyI4T7Kkwn5t3ggh
 TL5oba5ojN1omo3vHWBP9Gg0uzWWuBH0o/+uqk4TU0T+MrXsNicHpywKAdF7xxg2sRvf
 xFQ6twmHWb6v2q1DIwipbt3HKJdCdXtA3HIUxohdZ4/KNkZ711oB1GSMs4rD69fZkg/I
 9fjesY2Oodm+81PYVvquyXzsfNljohDleUtILuQ0o3hP/t+XUA0fTTVbUABr2gbgEeXi
 u6KfBQQPsPZucVzbNX6BvG3I+KEaSUgTyI7c0ZaPhrnyYNX6P1BK3DVAP740PS63JFID 6g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pj9xhr03h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Mar 2023 22:45:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32PJbHME027808;
        Sat, 25 Mar 2023 22:45:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd3bagt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Mar 2023 22:45:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnwWddFbSsmQx69Ljt04dPcP9yvxauuPeAT8kcXANRhh8xVrJ5vuUIvyw015x/6ug5H42Wef4Mx8Vp+7UEPgsCRK2cCQTPmbg3taCJsnchWtUW3vtNqE99Z5SMJDRJxlutjmVzkN4XjFjpMzCrlFvpTIlSop5VYK/u9YKpXlctZgtbdPGTQZE1NnkjI0Z4ApW5AewV6CfYdXgkrshvJyfgYd1UvoDUiAK8E/LGoJ7af58gUqbi7UX2+JZRHVRz8lnHhA+tVSmZ1uNev0uPNJDa4trNsSNVziT7mp/O2CXLAjJVPYjdA2vlP65FF9lbta1UwfxOJdU9tG92N/P2Haog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G21OEEA12ddNyJGv/1tdnL3PFaVVkfieFScDSI0bFvk=;
 b=WBxcDB+gKSmYviP2cBe6Cx5rbDb0tLKSN8aWUv/Dbd2HO91LqzsxC9VDy2OddmkSBwrLXA8x0OBAOjrkoyT5hznnObwap3v6Hd6UoBGWDhRjO6DRRu/hDs+TPEwPgMU5AnvLhKPQi/oBj8ZzTHCwV6J2+P5qGtMijyk4VCVylM7+V4jRB2NmaP2rR4AdN/ri/O5+nvhZukpr9880XUpP6NXngvbQoKhznAhfidXgdgkDiDVYNd7lIaTMEv+k6Gr4huqpgeKn2sFWgOJ4fJfGuarKQ7hJ0IopH9wSPCR4bl8y6zSAvNKG+KxSMefPix9leBk9qsQrQs9FnHiS2LE2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G21OEEA12ddNyJGv/1tdnL3PFaVVkfieFScDSI0bFvk=;
 b=KWFdzo+86gjM8YxOGJhCXG7+BeGgt6dU8mdsIuzHdexSNWtHVLp6GRl61GS7Ch10XkAGPlxBCUonF1sc7nGkdNTC6qMcFolgrUMaRm6DVb0Wgr5UNIQKIroHAwACfnycZvFXUDapIlhhTV5puqxX4Q/7rEJmNP3dlirdKBLE3cc=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM4PR10MB6814.namprd10.prod.outlook.com (2603:10b6:8:10a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Sat, 25 Mar 2023 22:45:29 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.041; Sat, 25 Mar 2023
 22:45:29 +0000
Message-ID: <7ab00d3c-3148-93b5-072d-e6ee6ab485b6@oracle.com>
Date:   Sat, 25 Mar 2023 17:45:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com,
        syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
References: <20230322185605.1307-1-michael.christie@oracle.com>
 <20230323033557-mutt-send-email-mst@kernel.org>
 <20230323104445.qidusxeruimeawy6@wittgenstein>
 <20230323073918-mutt-send-email-mst@kernel.org>
 <20230323115049.vsrnufcaqstpxik3@wittgenstein>
 <20230323084648-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230323084648-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:8:54::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|DM4PR10MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: abc580c8-2960-40cf-664d-08db2d82a1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8p9Vm/PClMjhbv9qPXGsw360PW+sDwCrgsFsJDnXp1cXP7gGfhKbK7yhcKAKC5Weg3lujQXDNMraAIG9BXcrzPhytanKAjVVXNxdAN9a9ivrN4TAT1nY7F+KF9CF3fMht1u8EFIBNWQxIaCfPB/fDshGdEBAfXAos8FfWr+e0MgtI8RrK6LdSrg1uQs4rugCco+0eG/RzVejL4YPads/QZmWbtViB0bgE63gO2ngKgtZpdWMwckzBdIeS4MNW7xzTHrLU+CaIdnXeMtyaoIxZMCbFpXGjcgqEaz62RZ+TE0UgDJTpKm+ASFHVNsBeKYl5JsbMglT5vYZSoU0xss3RudTqg6oPXGt+YtE2LWCyGJa8zkwIqoXb0UGQn9KqRPgCNqEBwYCZqMjpnTIAPEYSULyMl8k1JP/H9xPoIsHNVdXfhO5EWfeOj+2UCEjXJwdywAQoUB+qwhW0K2E6f6AECSaD6y6cxBgYYvGWNfvu1HIXskujQ67kFYxQ9N4i8t1CvEgAbiX4UF6qU2co8IyOqVn4x1PqcMJTqtM8YEShfNHEtGJE+o6cOKHcZEgm+5kFSo04akVsz3ThI7ZYegeLKO5e7z0zdNejMTJpZhb5JOe/tWphbKHXYKTiepge3h7A+v0f5C7iFsf/Q8dEiSxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(53546011)(66899021)(2906002)(36756003)(316002)(6486002)(38100700002)(6512007)(26005)(186003)(83380400001)(31696002)(2616005)(8676002)(110136005)(66556008)(66946007)(86362001)(66476007)(4326008)(41300700001)(31686004)(8936002)(478600001)(6506007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkRKSGFqYkpCOUErZEdsc2pPL1JDMDdtbHpFbTNRQ29NVnlGRzh6U1llL21F?=
 =?utf-8?B?NVNHdUh0N0FGYWY1TzV6bng1dEloWG5SR0pIdjV2WFFWbnk4dkxBbmxjdCtl?=
 =?utf-8?B?bjlmVGR0NGFYNnlpajB2bHk3MVNDdFpaSFJDajdjTHFYOGFvV3NZaHpabHpR?=
 =?utf-8?B?cFkxL25PQXBJekUwMXhIbEQ2K2hWMUVjQlVTUHRlNzB3a3k3dGNOaktVOW1i?=
 =?utf-8?B?MVF5bHlSTGZ3Ykk3TVV6b2FzamI3YmR2RHRuWi9RcWRDZHlwdHJjcGdROUpr?=
 =?utf-8?B?ZGpmL0ppUHBhSzhFSjZNR2ZKRmxReHZ3bzFldHVweUtlZjk5bGIvOHJOUzR4?=
 =?utf-8?B?OGQ3d255Zk9yNzBFcS9saG02cXZ3bnM4QTNvQXIwaC94Y2ZIT3p4Qzl6Y2l4?=
 =?utf-8?B?NEdGYjBJSEhVWkZ3bWMzaWJsTmhITC9Ta1hHMmxBVE1BdHhaRkVKRU12blBU?=
 =?utf-8?B?eFA2ZzY1czRjVUtFaUtKREtRQmpXY3lkc2tNOVQ3ZHZvYWUwTWVsWGtjVXJ6?=
 =?utf-8?B?cHZRa2lBdlNWZnpTYzdpK0duSGlCK3p0WWtsbWxzRGhyUGhxc0Zmem5JS2oz?=
 =?utf-8?B?am1SNW5CaVExQ0p0Q0FiamZhN1UvRzNzQ05YZXpmQ0VSZTEvNTZJZVVlb1lE?=
 =?utf-8?B?WkF1OUVFaUg4QzB3VTd3RXVnaEMyMUUzTHNmMTN4TVk4N3dMcHZJNTNLNWJU?=
 =?utf-8?B?dVhCU3gwYnZPa003RWdrSkpiRDFTY2x6NC9uQThQOWZLbHZQYjhjb1NZM2tI?=
 =?utf-8?B?anVvUDhXYTR0aXFNSXdLRjE3K3RtNSt5aWlTZjZIbWl2UzlsbGtzSm1PUWZL?=
 =?utf-8?B?R3BONWdYVUErd2k3UVBqbC90QkpYcXFISkdVUm9ReG0wMlFiaXdkWG1wNWdt?=
 =?utf-8?B?N1RSOURTeFRJYkpjeU95RS93SjVLTmZ6dzNIZ3hhTGNtSUNPelg5cG1VWHJG?=
 =?utf-8?B?YnNQWEtIdGh0c2ZGdGM1RzVPL1RsQ2prdjBPam81QzZJSFRhMDVxTldQYStO?=
 =?utf-8?B?akpZQUhkS04wK0VPaTRSYWVaTXBqNTJOaWJHVk10cU1OUlVBM0FaMi8wbkF0?=
 =?utf-8?B?TzBpVGtnS1BWb0lvWHhWTlEvQ1dubGdpN3JRaE5mT0psL3JpWlBzRTFrOThZ?=
 =?utf-8?B?T0VFL1RlNHk0bFVpMmMxeFNFcTZpSk1hQVNrOHBiODg4RkdjNU5FWks1Mytz?=
 =?utf-8?B?bmg3ZkhNaEZSNXhBR2d1SHM2dFlkWVB4OVMybU5iZS9sQnQwVS96RmxNQ0lt?=
 =?utf-8?B?Ulh4UU5qR1Z3N1FGL0dqL1lpOFZRVU5TUG5qSncrQTlYVGV3aFNkb2JESWNL?=
 =?utf-8?B?RFlENWEwQ3RvNk5hVGdBSWlWVEk3MWw5OUZCKzk3eE9lVExzazA3dXNueTJu?=
 =?utf-8?B?M3BYdlBwVWIzaWdPSnd5R0t6V2pZNWVISXJZWUU3bHdCRHdHc0NONEhSNnB2?=
 =?utf-8?B?ejlEOEhaODJ2REhkdDliR1RSRzJ4bTF5aEdQZVcvUjJRa2ZrWVAyWWhEM2x4?=
 =?utf-8?B?WHA2dHpzN1Q3YTdqVzdrWitpQzl0WVhBNklwcCtWRXhaYzM3cHZETzE3bkZV?=
 =?utf-8?B?bE1MK0w1TkNlTUt2Z2s1MFVKTHRqUTQxNG9XdU1UZHFxQTM0V2RDTEg1Y0E3?=
 =?utf-8?B?RlViNzhOT1R1K1FrVnV5SEg1SWxoZ3B0eHl4U2dITXQzOFhiWGoyd2hNMUN6?=
 =?utf-8?B?YjlTY3ZjQXFKWmZXN01YNXUzNkx4c3hTWmNPakM5RXd6TlR5M2NYWCtxL3hB?=
 =?utf-8?B?U29vK3hlbkFoWVhKa3RTSExNaHF4c2xzU0RjUEs4bjBsdStxWlZTZDRldGVI?=
 =?utf-8?B?THhEanI3Ny83TG1HR0FvZVdaS05yMENoOGdrY0dkUlR2TWtFS3RZUlRON2Iv?=
 =?utf-8?B?Ynk2VVRwbVkxKzAza1Rma3RFcTNHRjZLbElqMXlQcFYxOW55SWk3ZlB4S2wx?=
 =?utf-8?B?UzNkU05OSHRNVDNSOW5kelY3NkVldVlTNW8yYWJJdy9IbENvWVFscjZVQkNP?=
 =?utf-8?B?RjFtc0Rwd0FndWRSM3EwOXBrTzYyeXRzUEFkMGdiYlJqWHdUUjlLM0haUGo2?=
 =?utf-8?B?WUpyS05taURUdFlIK1V6OGM5ZkdGQ3NOVG42SDREbnNUbGV4bEN6aTNSM2Zv?=
 =?utf-8?B?YlFjMHdyL0Y4cDM1T0NYZlJwU243NlFNWmQrVEJWNzVQaWNrNGl2NUpHbFlR?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?c05sN0ppWWM5bTk1VFdSaDBPRXdHckQ0Z2psNUMydEJXSG5DQ3p6UEI1SVNO?=
 =?utf-8?B?bXRZZEhyeWViNGs3TUovaGdydkpkek5zSkNKY0tQZ1lnSXQ3Vzg1NFZqcTJn?=
 =?utf-8?B?SE9maXVPWnNRT1J0ak45WVg4dFNLWmlVMlhIV1FkbXVKbUZZMzd3Y2VwU2hN?=
 =?utf-8?B?OWFHUmg4SnNIaEhMeWJMbkFCSEFCQ1RFYng3dzVGMGM4WjNPUjF5OGNqNjdS?=
 =?utf-8?B?eTY5eXJKM0trcUg3TUpHMi9qb2hzUnM3TVBOaUlrRExTQU5Xb1NHdWZFbnh5?=
 =?utf-8?B?MUVUdllFRFYwVjNZS3UyL0krbkRrVjFhUDZ2UEV0NC9CKzRwOE1md3FLYTJs?=
 =?utf-8?B?UE1FVk4rTmRwTGtEWHl4dVFZdWJBUzIrWjZYUnFCdE92NVpYN2EyRys3V3RF?=
 =?utf-8?B?M3JzVC9hNjVESnFFTTRlSjd1cVZwOTJ2RXAwQnd2NXFBT3Z0OTkvdVZWQ1Rn?=
 =?utf-8?B?V01SQ2ZFVVNNRmhnQVd2RmpaZTRkL0hPRkVTNmpkZmVweVNqRk5zMk5SdS8y?=
 =?utf-8?B?NGVENTZvU0JhUW1lVkMramFtNmxQSERLK2l2RENSV1NYNzhRbEpUK2UzSGMr?=
 =?utf-8?B?STZTUmZZRVQ0Zk1WOUZEWnljck9QWHBpdHZlRm80ZGxIdjA1YzFPemF3dXVo?=
 =?utf-8?B?dGYrUjdIUzVBMFIxR0h3UGpSWVdVWktsbGpBOHBpUWdVQTRLcmNKbEphdVRk?=
 =?utf-8?B?eDNNblhXdFdSeHJZZldVd2pzR0E4Z3BnYWE3YXFBTEIzMG1kMC9SaWxodkl1?=
 =?utf-8?B?b08wbFBhYzJTVjRnL1BqbmhLTXkrZHJFUEpOV2w5TzBqY3ZDdzZ3dGd2ejdR?=
 =?utf-8?B?ZC9TekhYc2NqV0lOazg3YS8vNEl5aTVneFAxK3lVNHR3b1ExSlE4L1dxQUZR?=
 =?utf-8?B?TEoxdDJJcHd3RUNtM2g1Slp4T3U1dnV5d2xuNkRaUlp1VW9uSEJ5VkJJT0J4?=
 =?utf-8?B?M1ZNVE10L3FISDg5Y3JTQnJ2ZDgzT2FTWE55K3ZxYnhSUzhHbTlXMk9lejFV?=
 =?utf-8?B?WkVpbjZpYUJqTXh3TWZwM2pPSnU5RkgvUWIrdWxpY2orbzRYcHptTVZRVGpH?=
 =?utf-8?B?Qm8xZXFXd0YwZ1drbVN2a2xEbGc1TTFXZ1lTQTNTL09kdDJxUUxBbmVtMU1E?=
 =?utf-8?B?dWRuSVZKY2g2MUFmTDNOdU95T2xlV3FNd2xFZ3luMTVzeE5GZDUrS3ZURlpP?=
 =?utf-8?B?bEw0UXYxWDBYTFRJWTRRVFZKNXFsTERGNlB1V1FtaEFKemc3V1RjTyt0K2hX?=
 =?utf-8?B?OGEycDd0cTl0RTc0d1JvNnB6WFBvbWR3OFJiUytCZ2hhNGVVUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc580c8-2960-40cf-664d-08db2d82a1ee
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2023 22:45:29.1154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSgl+f+I2y5bAam6XazXJ30TQoUkTYOyalnzzHqqQu3rGws9XP2oL4797uaSARYmeU4Jko8Xdd6/8Au6YsqdNxOUozAITHZt/HaSXg1p8GA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303250189
X-Proofpoint-GUID: hxtapYoXLgrAOCeG4G0xU0FOIwd8ETzO
X-Proofpoint-ORIG-GUID: hxtapYoXLgrAOCeG4G0xU0FOIwd8ETzO
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 7:47 AM, Michael S. Tsirkin wrote:
> On Thu, Mar 23, 2023 at 12:50:49PM +0100, Christian Brauner wrote:
>> On Thu, Mar 23, 2023 at 07:43:04AM -0400, Michael S. Tsirkin wrote:
>>> On Thu, Mar 23, 2023 at 11:44:45AM +0100, Christian Brauner wrote:
>>>> On Thu, Mar 23, 2023 at 03:37:19AM -0400, Michael S. Tsirkin wrote:
>>>>> On Wed, Mar 22, 2023 at 01:56:05PM -0500, Mike Christie wrote:
>>>>>> vhost_task_create is supposed to return the vhost_task or NULL on
>>>>>> failure. This fixes it to return the correct value when the allocation
>>>>>> of the struct fails.
>>>>>>
>>>>>> Fixes: 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process") # mainline only
>>>>>> Reported-by: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
>>>>>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>>>>>
>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>
>>>>> The affected patch is not upstream yet, right?
>>>>> I don't know if the tree in question allows rebases - linux-next
>>>>> does. So ideally it would be squashed to avoid issues during bisect.
>>>>> Still it's error path so I guess not a tragedy even without squashing.
>>>>
>>>> I tend to not rebase once stuff has been in linux-next but I make
>>>> exceptions as long as it's before -rc4. For now I've put the patch on
>>>> top (see the other mail I sent) but if it's really important I can
>>>> squash it after the weekend (I'll be mostly afk until then.).
>>>
>>> Hard to say how important, but I'd prefer that, yes.
>>
>> Ok, fold the fixup into
>>
>> e297cd54b3f8 vhost_task: Allow vhost layer to use copy_process
>>
>> the series is now at:
>>
>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
>> branch: kernel.user_worker
>>
>> 1a5f8090c6de vhost: move worker thread fields to new struct
>> e297cd54b3f8 vhost_task: Allow vhost layer to use copy_process
>> 89c8e98d8cfb fork: allow kernel code to call copy_process
>> 094717586bf7 fork: Add kernel_clone_args flag to ignore signals
>> 11f3f500ec8a fork: add kernel_clone_args flag to not dup/clone files
>> 54e6842d0775 fork/vm: Move common PF_IO_WORKER behavior to new flag
>> c81cc5819faf kernel: Make io_thread and kthread bit fields
>> 73e0c116594d kthread: Pass in the thread's name during creation
>> cf587db2ee02 kernel: Allow a kernel thread's name to be set in copy_process
>> e0a98139c162 csky: Remove kernel_thread declaration
> 
> Thanks a lot! Mike could you give it a spin to make sure all is well?

Reviewed and tested the patches and it's all ok.

