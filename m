Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472B6743057
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjF2WU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjF2WUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:20:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9991A30F7;
        Thu, 29 Jun 2023 15:20:35 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ4JJp031766;
        Thu, 29 Jun 2023 22:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=aZA+SpgpMIVdPJLsQfEnr4rOxkNjt3q9wvKhDnEH0tA=;
 b=CSGgRqj6ztU70E8AzcF/QahZoKvmQZS0tGOz6bG4hvJInm4g9XOOk+xehHn9d7SuTIkT
 0gG+uh4HPuKbUNQ5DjxB+H8KZumhQBumhRtKY2oTMaPFHs5UQG5yZfjnxsTs44O9kx6v
 Ui/XFb8ux2RW1anwe8PeBnU1VeOw8YKm/f2HlFKGdPmdgHNJvidlG8KBrSjDUFy2hVzl
 eONhla5iDsZNEndghzHVXffsUYBmZTjgobVfr6rjHWHSuGn7rk5BBylbTaQNDMrgOHlU
 KQigoJZPr6qT3E1wcJI8K2thknL0caIg3hq0lJRYcW5xyKbt+1h/yy7MZgYOJ3HPQBtv hA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdtxcgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 22:19:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TMIJrt019933;
        Thu, 29 Jun 2023 22:19:27 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxdsme0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 22:19:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjPTqHd/I4oIOdaP1vOw8P89ZlzqlQOjTEmwI5+YJ28cCczOITZQnQvSHvOBAcfWjPn8jqA/a1IQp6A95aWbDEk6v1WrZ3EEEljNBd9SztV80miYb1e/FQPhS9U6mLax31ullenTpoBroTGNzGnkZ9atTbwCYiYgIhi10Xd+CUXGDTh0rUqwarz7242zloqJY8DanACMmaPU36ndzP6VNVjWF/kZndUwALwFZI08AorSDNjJGyKyE+a11t6rF0XGp2V73y1XHpooJcYCgcByPrGgpMTNo0HegEByC5/GW5jiM/wdFshI34BbsDeqLz6KCGMcE/v2tIgln9vdhGfb+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZA+SpgpMIVdPJLsQfEnr4rOxkNjt3q9wvKhDnEH0tA=;
 b=AdQq40zOrYtndaSJMQpF6iTFaapVfnRDhj+hrvVEj/L6gVwCMl6QESDJvACztbduYh33mrU6kkcnqMf3xShIvV8YkoFyrPJckFA/h50zZuhLTITEmkxnaJkLTbtSFykvRyxK1xulm+s6XnHmVTq9RJi4ix0CXzEm0kXmUqMoCCzFOEH9CsBfGamw40hO5TrCrpssVFqTxXHWt4T++Urd6XbntU6K147dRXi7Y/i1a35zT+2C6CZEss9x9ZZbqRpALdrgJMDd8q/Nn/nmf8uF7i3C06GYqMaN4VCJIova0ArSDngqSOjn76Kuu8G9qMBh1qbRc8/uiACJUMTa3JLCxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZA+SpgpMIVdPJLsQfEnr4rOxkNjt3q9wvKhDnEH0tA=;
 b=ztpIBbRs7sqL6LgX2yw0fwRwzb8fDFADXlZSC69AptazR9NbUZJ8nu9hg/IF71NLug37HFP6K1g//m/9LvHt0Dj5bS3gBYYLqPAXptwJaXM1Nn3Fj1I41l7BEJc2H2RgannZ/OasSIgm6oTx/x1YL64IP7X/m2jJ8QWNbZ75GAQ=
Received: from MWHPR1001MB2159.namprd10.prod.outlook.com
 (2603:10b6:301:2c::24) by SA1PR10MB7740.namprd10.prod.outlook.com
 (2603:10b6:806:3af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 22:19:24 +0000
Received: from MWHPR1001MB2159.namprd10.prod.outlook.com
 ([fe80::18de:1885:20b8:f5a3]) by MWHPR1001MB2159.namprd10.prod.outlook.com
 ([fe80::18de:1885:20b8:f5a3%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 22:19:24 +0000
From:   Julian Pidancet <julian.pidancet@oracle.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Rafael Aquini <aquini@redhat.com>,
        Julian Pidancet <julian.pidancet@oracle.com>
Subject: [PATCH v2] mm/slub: disable slab merging in the default configuration
Date:   Fri, 30 Jun 2023 00:19:10 +0200
Message-Id: <20230629221910.359711-1-julian.pidancet@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::13) To MWHPR1001MB2159.namprd10.prod.outlook.com
 (2603:10b6:301:2c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2159:EE_|SA1PR10MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fd98d0-6c77-4de0-1895-08db78eee535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8w55Wxtkzo3Dr2RBkz8tvhWBxlxFRRDXKnfPE1ck5BPrFC22EtyuJPg7Me9TsfeEZRFSy77lJt1VqJVHXWc6pQ2BJBGT4wd7Yb/R3uiY0dScI4EZBmqABqORkeonXBbpHtqwq5l/JQZqIRA//LO1QPJk+RwoAd3Gzhx0218Vanq82veJXjI0WCVxGP5p3cp9ZVOvDk3Ce5e98CrVbET4LKzkx6qX+fs0SiURw2iLPF2I3aWqk5rSok0Fa61Hz2Lls0KAjPJUSEp4L/LvtoEt1kyTBdgp4oYgLyNQgM7DcXo2kzbVkenlSPmvRtuRO9oqCqTBSR09iutYZP8SJG+YHStadRz4n/09n3+LSm3v1zlM4ojsdL3OMu3T/ykpAh2aIe5M4zk6ERtQ/qEAVYqlHsd8ClwKSYwgeZzpsiXwi6kMI/BkTqFFC2oCgWmWJVxpMHij9xN9a9EUcImctM7+duz52GAoVRbBZwdqbTQFu2D3qS4rApUHeG6GalHXzE1OAsP7a4voIlCAJ+pNPYMV8zY4Fxq9/Bu3ZBCjp3D3uk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2159.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(36756003)(66556008)(6506007)(66476007)(86362001)(44832011)(5660300002)(316002)(7416002)(41300700001)(8936002)(4326008)(38100700002)(66946007)(8676002)(966005)(6486002)(107886003)(1076003)(2906002)(6512007)(186003)(83380400001)(478600001)(110136005)(6666004)(54906003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2NuVWZKUTZYNndaWG5rdWg3bkhCMmdTWExGQzhkMUFHemlZZGM4OWVpVVNJ?=
 =?utf-8?B?djVkUURyZFI3S05lbUkzNXlGRHdqeW1rRm9MQ2g2VDJscGdCbGdyTVNOWk0x?=
 =?utf-8?B?SUhtMTltKzRTcnJXOXZGM25nVVNvRjNQTC9BVkZSOG1qSDJCYkRMOXc3TFA4?=
 =?utf-8?B?RHBtNy9TR0VSQUZFc1hFY1drNCtINUtVRURWMUpyb3QrOGlra0ZjV0lNWWpL?=
 =?utf-8?B?SGR6MzdkSDF0ZGFJVlBuWnFpUFpicm9nWmZCRHd6WUpQOHl2bUNjamIveWVo?=
 =?utf-8?B?Y2FZeTJvS1g1Q25Ma0xnaWtGdW9uQ0pkbGhlbEkxRS9JeE9oaGlPNHNIeENy?=
 =?utf-8?B?TW9jZkM2akdnQmhNaG50REJqbEFjZUVMT1ZqSFZnOUN3MzNhanEyZEIwVWtX?=
 =?utf-8?B?VDFaSzVjaE5rWUp1RGdEbi9HclZPZ1NKTHJMSHM1VTZvdnhZdkFyaUJ6ZzJ6?=
 =?utf-8?B?UmlYNVRoUGZNYU5lUGRCT1l3TE85RktwaVROYnI4bitEaEt6V29VaTlnMk9E?=
 =?utf-8?B?S0NITDI0czdLZDRXRTBTUE5wTHNWdWZOU0xaN0V1RDNlb1B1MU11WHhSY1oz?=
 =?utf-8?B?OG1YN2RHbFdVR1pFNThTN0MrcTVlaThhWStaWWdpVDhuVFFqZEFFaC9CNEVC?=
 =?utf-8?B?RnZ6alNFcmg5Mm1KL0hPKzNldWFjTWhERnVrVlhwdHhUb0M0MStSNnZlb242?=
 =?utf-8?B?VVRYRGlPSVNvc0NUSGViV2c1M0hDL3lOUk9naHZUdUptbXRyU3czSGNkakVO?=
 =?utf-8?B?dkhMcjN1b0EzczM3ZGpXVEpNVXBPUk9MYnJmMEN3a25IUFhCRks5RHV6T1ZT?=
 =?utf-8?B?UDZEMDlxV2JjeWFVa3c0MjFQUWpEQnBGamp5MGV5elQrMDFQV1V2dThWNDU4?=
 =?utf-8?B?VkZ2YmJ5eWEraHlEVlpWc3U1UFFaOE9ndkVSd0pPMjdZdVdiNjJuT2dGV0t6?=
 =?utf-8?B?Zy9BZ0dVWkRleG5zMHQvb3JNK3ROZmpkS2NJOWJXQUhwSHlaUjlwNUJ3Q0tJ?=
 =?utf-8?B?NmlPM3NXTXl1VjRJb3FQMTdkMDR5ZGxvVjQzQVA1TXZzZjdib0lhdEEvWXFY?=
 =?utf-8?B?ZDJIYWQ5dk1xWnhEcEJWdllaWVpNTG5EVXV4Zkw2TVBBaXJWckloK2FkZmNv?=
 =?utf-8?B?aXgreG9uYzRRM3NxVUVla1JtK3VIUndUQXZmemRZbTBERWFUaHN5NHFmUFAz?=
 =?utf-8?B?V29DbmJYaEtBUDlaOUxXaTJ2cVpWNHc4cmVDTHFEZjdUYlY1cENZNUJ2NnBF?=
 =?utf-8?B?YXI4ZUJxTEZrVDlSTkRKVTljeGlWZ0JOdGoxNVVVOGs3R2hXWERCMEFIUmhG?=
 =?utf-8?B?S1NTM0FuckVNNzM3T3gveWR3N3BWUXVPY01MUEEvY3RIQ1NSOTlzMkF0VURl?=
 =?utf-8?B?WHJIeHd1VVo0WG9ZU3M1NjdkOXpybFlsREJMY1B1eFdXRGZvQ2VvZHNLSTU1?=
 =?utf-8?B?VGtWY09tcUVNQVJ4dHhkQTE3Vkd1TTV6L28rS1Q3U3AxemRiLzFPUVIzU0I5?=
 =?utf-8?B?azExazZpUTdOU245UmFiQW5nUGJPUjlJZzRUM2toUjd4QlN0eFdlYWVkb3ZO?=
 =?utf-8?B?SHFkVWtPR3ppWFNTaHhPOC9ERy91aUU3TjZCQWJrNU01YnJ1dnIzZXNzN29h?=
 =?utf-8?B?WGVpRWVnZ3FUYTRiUDdqMHBETVczbmZjSHNtYm4vUE1ZelNHbHc2WFVRdFVx?=
 =?utf-8?B?b2RLbDh1TkNNaDRISW9CbXJQVXVvd3NMOE5aT3dTKzVNYlFtcDZ5NzBIOENh?=
 =?utf-8?B?MEFXZE1POCtuUnlBQk9EVkRsNXRsTDY0aVhORXIzMDUrcWJHZ003Z0xvaHp4?=
 =?utf-8?B?L2tHV3dMUWhSaDIyVUhhRzRsYjBhYlJkN25QVlVLcDRjN0tOVlFTVmlwdjZG?=
 =?utf-8?B?ZnZ1OUhDa0ZPN3p2blNXSXBubzVMbUUweUtTWjBRYUtYZWwraTVRWFUwVzd1?=
 =?utf-8?B?UHdOWjhmSXlpWVlweFYxZVlacjFTemZiYytza3Y1MlhCazkvQ1RrV2RyYjZq?=
 =?utf-8?B?NzFtT0Y2b293N25VRllYb3p0Ym0rREhmbEpUVTNWSktSUlZLcGRaOW1abUpr?=
 =?utf-8?B?SDZCZGxEQ0w2NTIxK1phY3RPcDdHYlE1MktkbTFTSFYvd0NyV1N4V3ltdm5O?=
 =?utf-8?B?alZudFBiQytKb1JjRmxNSHUvU0ZnSE9IV05lZ2lQWDRHNDdXK3k5SmtUTnJz?=
 =?utf-8?Q?AkhZln5hiDsrIdHF7SPx5yI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZzlLTHdiaGZmUzhIcmNsaFN3OXM0d0N3MVVLM1ZscHYwTjl4eEMxNHlXcjlK?=
 =?utf-8?B?RmdzRWVHS2ZTbUJBcmlpQnpxT3BheGRBUVB2dXpaRmlhOHBPQWxXaVpINUJl?=
 =?utf-8?B?Y3VqeVZmMGVZNDViWEJiangweVZKU2p2dDNJTDBQdC9BRlE5R0cwS1NPUy9r?=
 =?utf-8?B?ZTUweURiWXBJVk9idU50WVRXQlI2b3dKMFdVNTFQcmRZb3VxUk5DbVdSMHJH?=
 =?utf-8?B?b3FidnNlNVA5Z1JWRnQrdVRXNkw5Z2VscVZXZG1IQlpIV0MvVUxYVmtEQml3?=
 =?utf-8?B?ZW5UYW1wR29lTnd2MlhQOWlpcTFDMVpjaExpWENWMXp5c2lIOEYwTjN3WmpZ?=
 =?utf-8?B?VEd5VkQzdS8rRkNrSFdZMWphVSs0RzR3KzlOZ0xxL1k2bEN1Q1NTakpYV2RP?=
 =?utf-8?B?a1NRVmZjeG9ieHFIRXBBTERETytXaldsUUp3TGhBQXA3MWJHbVBTbnkwc08w?=
 =?utf-8?B?UlExWml2b3B1VjFSdSt1RDJSRHZyODlETkpKZVVKTW5kMVFWOFFBZk50cDB0?=
 =?utf-8?B?cmJtd3ZrTTRNV1Z3ZUpTTzR4OUIraDBjdGk4RmxucTMrNms4VmV0aTg4RE9v?=
 =?utf-8?B?d1ZHUHpHOHllRjEwQkN2Y3V2V0JEWlBMOGpxNncxbEVzeXVMT0lBYnZvTzZo?=
 =?utf-8?B?Z2lkRndPeDk1U0I2bHpHYUxlaTJjRktDNWxSTFZDb2h4cVhtbWVmWmhoaVcr?=
 =?utf-8?B?eis1OVdUVWg1RE05UTF0QXA5aXhqZFZiQjNWRUFRTzJScHlCMFlSTElkRnRW?=
 =?utf-8?B?b0NIeVpEWmNaSXc2cFlEckhJTVJWRHpLRzhwbG9UcEIvZmpGeUx0MlZqYmRl?=
 =?utf-8?B?SU5uQ0IxZWNUUS90VFc1OVpXemVDWi9iOGxiSE5vVnpqakNMOFI0bXBHcFdS?=
 =?utf-8?B?cnEwMlV5S1JQWUZTTHI2b1VmbCtuL2xNZWhTbVEycVlkeW5PNE1TUVpQMXBO?=
 =?utf-8?B?cTBFQ0g2Q0JhQXJGZ2pyalpTVmc2SzhYZVI2SU9CYWNxbTdsakhWanZjd3hX?=
 =?utf-8?B?QlZNL29YLzNqL2FZT0lLZFpNOC9vTlNFWGZ5SGtUak5CMjA5Mmh5dE1FdHln?=
 =?utf-8?B?SXVrTFIvdEFLNEU3VmVzbnBKMmtrVHd6ZEZ1eDVNWllqeTdzcHQ0aDJud3lT?=
 =?utf-8?B?QmpYM1l1OWZGQVhJM2pQMWhPdVBycW5qK1B3ZGFKNHE0aVlTb1Aya2djQWl0?=
 =?utf-8?B?Wmk1L2RYTi9QYXdvbTdnMVRNRVh5OGNVR1FYQnlqbDRqNjJuMUNveE03bVhx?=
 =?utf-8?B?R2F4cTNMRE16MHhNRGYxMzJidTB1eDFPemxpQ3hLRUxRWGxCREdUWjdCOUV4?=
 =?utf-8?B?MUFBNVp2TGpWdUlhY2VxSWJhczZlUDgxRzYzeWNHYlNPMExIS0RjZFBrODM3?=
 =?utf-8?B?RFFpSHlGQzEzc3Q1NHkvRFlIbFRRajEyTjBNd2szMG1zdWZxZ3VyV2IvN0xG?=
 =?utf-8?B?dTBjTnVjeUZ3ZlBFR2I1a0FCTTZRbjk2Sm9DMWM1RFVtcTd2TzdsNGdwYUdm?=
 =?utf-8?B?SC9JUGV6RzkxOVBYQlpIdnhhK0J1elVSbS9kTjV1K2RIZHF3TEowUFpsYXFU?=
 =?utf-8?B?NVFyQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fd98d0-6c77-4de0-1895-08db78eee535
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2159.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 22:19:24.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+YRVSJC64403jfHSMDtN692P2zHmhbw3UEh+lzGXX4wrWwWISgxNjvKe3z9rDi6T5HZeNYT7vGt/kuLYOFQqTT657WVbqXLEHch6XwAbBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_09,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290202
X-Proofpoint-GUID: k41Uf5jr5mynM8jngzhi3iUX7m3hP_-o
X-Proofpoint-ORIG-GUID: k41Uf5jr5mynM8jngzhi3iUX7m3hP_-o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make CONFIG_SLAB_MERGE_DEFAULT default to n unless CONFIG_SLUB_TINY is
enabled. Benefits of slab merging is limited on systems that are not
memory constrained: the memory overhead is low and evidence of its
effect on cache hotness is hard to come by.

On the other hand, distinguishing allocations into different slabs will
make attacks that rely on "heap spraying" more difficult to carry out
with success.

Take sides with security in the default kernel configuration over
questionnable performance benefits/memory efficiency.

A timed kernel compilation test, on x86 with 4K pages, conducted 10
times with slab_merge, and the same test then conducted with
slab_nomerge on the same hardware in a similar state do not show any
sign of performance hit one way or another:

      | slab_merge       | slab_nomerge     |
------+------------------+------------------|
Time  |  588.080 ± 0.799 |  587.308 ± 1.411 |
Min   |          586.267 |          584.640 |
Max   |          589.248 |          590.091 |

Peaks in slab usage during the test workload reveal a memory overhead
of 2.2 MiB when using slab_nomerge. Slab usage overhead after a fresh boot
amounts to 2.3 MiB:

Slab Usage         | slab_merge | slab_nomerge |
-------------------+------------+--------------|
After fresh boot   |   79908 kB |     82284 kB |
During test (peak) |  127940 kB |    130204 kB |

Signed-off-by: Julian Pidancet <julian.pidancet@oracle.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

v2:
  - Re-run benchmark to minimize variance in results due to CPU
    frequency scaling.
  - Record slab usage after boot and peaks during tests workload.
  - Include benchmark results in commit message.
  - Fix typo: s/MEGE/MERGE/.
  - Specify that "overhead" refers to memory overhead in SLUB doc.

v1:
  - Link: https://lore.kernel.org/linux-mm/20230627132131.214475-1-julian.pidancet@oracle.com/

 .../admin-guide/kernel-parameters.txt         | 29 ++++++++++---------
 Documentation/mm/slub.rst                     |  7 +++--
 mm/Kconfig                                    |  6 ++--
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c5e7bb4babf0..7e78471a96b7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5652,21 +5652,22 @@
 
 	slram=		[HW,MTD]
 
-	slab_merge	[MM]
-			Enable merging of slabs with similar size when the
-			kernel is built without CONFIG_SLAB_MERGE_DEFAULT.
-
 	slab_nomerge	[MM]
-			Disable merging of slabs with similar size. May be
-			necessary if there is some reason to distinguish
-			allocs to different slabs, especially in hardened
-			environments where the risk of heap overflows and
-			layout control by attackers can usually be
-			frustrated by disabling merging. This will reduce
-			most of the exposure of a heap attack to a single
-			cache (risks via metadata attacks are mostly
-			unchanged). Debug options disable merging on their
-			own.
+			Disable merging of slabs with similar size when
+			the kernel is built with CONFIG_SLAB_MERGE_DEFAULT.
+			Allocations of the same size made in distinct
+			caches will be placed in separate slabs. In
+			hardened environment, the risk of heap overflows
+			and layout control by attackers can usually be
+			frustrated by disabling merging.
+
+	slab_merge	[MM]
+			Enable merging of slabs with similar size. May be
+			necessary to reduce overhead or increase cache
+			hotness of objects, at the cost of increased
+			exposure in case of a heap attack to a single
+			cache. (risks via metadata attacks are mostly
+			unchanged).
 			For more information see Documentation/mm/slub.rst.
 
 	slab_max_order=	[MM, SLAB]
diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
index be75971532f5..0e2ce82177c0 100644
--- a/Documentation/mm/slub.rst
+++ b/Documentation/mm/slub.rst
@@ -122,9 +122,10 @@ used on the wrong slab.
 Slab merging
 ============
 
-If no debug options are specified then SLUB may merge similar slabs together
-in order to reduce overhead and increase cache hotness of objects.
-``slabinfo -a`` displays which slabs were merged together.
+If the kernel is built with ``CONFIG_SLAB_MERGE_DEFAULT`` or if ``slab_merge``
+is specified on the kernel command line, then SLUB may merge similar slabs
+together in order to reduce memory overhead and increase cache hotness of
+objects.  ``slabinfo -a`` displays which slabs were merged together.
 
 Slab validation
 ===============
diff --git a/mm/Kconfig b/mm/Kconfig
index 7672a22647b4..05b0304302d4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -255,7 +255,7 @@ config SLUB_TINY
 
 config SLAB_MERGE_DEFAULT
 	bool "Allow slab caches to be merged"
-	default y
+	default n
 	depends on SLAB || SLUB
 	help
 	  For reduced kernel memory fragmentation, slab caches can be
@@ -264,8 +264,8 @@ config SLAB_MERGE_DEFAULT
 	  overwrite objects from merged caches (and more easily control
 	  cache layout), which makes such heap attacks easier to exploit
 	  by attackers. By keeping caches unmerged, these kinds of exploits
-	  can usually only damage objects in the same cache. To disable
-	  merging at runtime, "slab_nomerge" can be passed on the kernel
+	  can usually only damage objects in the same cache. To enable
+	  merging at runtime, "slab_merge" can be passed on the kernel
 	  command line.
 
 config SLAB_FREELIST_RANDOM
-- 
2.40.1

