Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F78F7430A0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjF2WdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjF2Wc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:32:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376EC423A;
        Thu, 29 Jun 2023 15:32:27 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ4JPQ031784;
        Thu, 29 Jun 2023 22:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7QtDlpPUjpQ7Gy3v2IbLJ+1M2cB5ZenkexjSOmejPR4=;
 b=DDJG1rGTFPAk1MX2eIluX18bvZc18WCM7yQWl3Xg4g/dqLtTzhwQPGXxm+Y5mRCguy9S
 DvjuEpGtUVAI8zWY0TMEUP464RpmTbDL11Bb/d30gx8v2ZwQBvCQSjRF2Rm99jW86jUI
 WGsDu0b7LyYiofNAXhb/7+q7CyG6J0voyMP7QnIZqX4m6Q0N0HC6Yr8GL0RpfU4JPpsU
 0nmTG8TSWM7dCHoFMUDZNubxE78wO7ZCJfNEgu83BynTiVVqDRpLdfnzJsYv2djZ0mIR
 Tp4fMle20MfGHK+Ou4ovdo/6cAo3358acbysNyzCP6JptrSBLQtAMMMp/rsuBaS3lV+/ 4A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdtxdpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 22:31:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TLAAFY008658;
        Thu, 29 Jun 2023 22:31:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx810r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 22:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwvzmzcV/wuopl4QFBp1j4FsP5Z83ZFRtLR87/ydDWp6nLkK2Glx0N/l8uhQ9Nb2lmES6u6H1exvqLdIpfnIJF58CGEH5b3P79RySSd9y8M3v+j20OkoJnTNnbIfFIoM3N00KHjHvgbCBwP+Wp7BpIBdNUFrRH67izMVwuNzzU/ktk8rZjGln7EQa/tpmjndeeTPCyKei0elRm9OGw4aY2b4p4NCoEoGi/PYUMH9Vo2Gm1Ax7ckudZ+l1ag20h7aoNfuBghv+Kpccj+YHEUVJKmm6js9WPAzDM9giIanCuu0FmV8+1oqtA5zyW06zKogMeQiCsS45aSQ43VTOKjPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QtDlpPUjpQ7Gy3v2IbLJ+1M2cB5ZenkexjSOmejPR4=;
 b=FWYM2F/mwQuLedtJ9arg24KrGXDWF/YDimYS6x56p4TCruxRvQN0R13+czqeCQoRuygAPqg1+7Eivlp7QHStzDr9krI8hPjju7gofvWgK8Gq3n+5L28S+VUBm+unTkGYF7kocXJHiwfKyD5qN7hpsaC72tBk1x4GWYiYaSkB/wFnpW1Ef8M2kkfKP+nAWcVA6MyNWs4K+/w4rtnfFzmI0RIe/kpnmaM23IfhiXIXNgVkfxjmoQ08LJIBVvfJTomvo9VxNF+mSkOLZU69J6H9v32EHO0td73v0xuU7QjvFfdsGQ3wnevJhMmmmjsDlN3YFt8a6W+CT8Wm6K9S8cz8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QtDlpPUjpQ7Gy3v2IbLJ+1M2cB5ZenkexjSOmejPR4=;
 b=QmskfCN6zDnIWY5l8TxNBjZQABClyyMSubrlmcJxympI+bucBF8uTSqxae9c/Uj28IDny9dYljACQ8RVJzu3NSxcbeET2jTY7CyHw/Ldsvy9sKY/VNiokSe6aGyLQboG8A0SutR1eSpj0iC93RBSYOX7W+7Nce9yN+9nqQe0A8s=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by PH7PR10MB5854.namprd10.prod.outlook.com (2603:10b6:510:127::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 22:31:39 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::1a23:e965:c139:b8eb]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::1a23:e965:c139:b8eb%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 22:31:39 +0000
Message-ID: <e0f5adf6-4f47-75c7-5697-5e928bee14b7@oracle.com>
Date:   Thu, 29 Jun 2023 17:31:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v25 06/10] crash: memory and CPU hotplug sysfs attributes
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        david@redhat.com, osalvador@suse.de, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230629192119.6613-1-eric.devolder@oracle.com>
 <20230629192119.6613-7-eric.devolder@oracle.com>
 <c9d4e623-5c8c-885f-4343-980798647a0a@infradead.org>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <c9d4e623-5c8c-885f-4343-980798647a0a@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:806:126::15) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4542:EE_|PH7PR10MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5c5555-da55-447f-be16-08db78f09a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGta5FJHogeyc0E+QRtOnl4/AL3UD7MrtHI5JB/UN3+qZNxrbBaiE5w2ec6ythCRSsGFMNv+KW9J892YN2Tp6VTAXwOqcwAzlyA19b+PaCLz905dF+TDAdMB5fibcVESZOJYyhyq2XCv+RRLFXkhgTDhuKkxTxY6g23OmE6PZzMtTsf//65CAl0wrSt8JdbOBA9JE98E9cltq6NbICpffGQfPdlrcxepfjUhNblUX9J3a6HE1vIJzSYjA8Fx3uZU6blJWrMM5GTuv53ky8M+VD+0smANWmeA7KqBJITUdB9l8igS/GgJP5zR8wvQIq+cGizQJ9d5XJO8wQyvrUnTcBZYVA8lW1+Qfa6bri0XYhm0zrzJe3oysn8rH+GifTSnjsv7DM7c+4BvxrWIWVdB7DQ0ojm13KVHIy5bWIK29NgkCXWjtpSlp0VhC95m5GNeiS9C9GFUHpQmn2LaQNWz9XXBvsy94an2wBt0IYzFe+5LxIo1m8SFMd1XM0Mc21axqASLICgUyux0XFI2oj+ml36v7vjc3SecbKI9YVbLF0SEcWwXGNcbe9ZVvZcqo1Re7eV+n7D3VwXK6nnsDSat/N2reenoEIrFIIGBX9QwD4C3Q5IbG6i7Au1PbgPyD8DCnAgzW6Sg+37UzH9heZimRwUqyyu3dLXq6uy0G++LPeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(7406005)(7416002)(5660300002)(66946007)(31686004)(66556008)(4326008)(66476007)(478600001)(316002)(36756003)(8936002)(8676002)(2906002)(6512007)(6666004)(41300700001)(31696002)(6486002)(186003)(26005)(53546011)(6506007)(921005)(107886003)(86362001)(38100700002)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU9XOFA5RVJJc0V0V3F2eFRhc3ZJQnQwQzlrcFlsWWczdmpQRjZMTGlYeE9E?=
 =?utf-8?B?cjJWVlBnSkpSUnBNY3JRWWVZTEVoL3R5dzVtZHhMeThWOExTVWkweFRKMHV1?=
 =?utf-8?B?cVB4Z0tVOWlMU2Q5WnBhUE40bUhzMUFwWGFZQlRWUk5FOXYwU0FGMUVWVC82?=
 =?utf-8?B?NmZDZTNlSm92Vm1iLzBaUVdHdnI1M05zakVpN2JTazJVSTY2M3czL2s4ODBU?=
 =?utf-8?B?RFhickRWaHhsd3EzM3pDQW9hU2dQRVhxQy85MERpK0ZLR1g2aUxLaktyTEgw?=
 =?utf-8?B?d1VNZ3k2VW9MVEpLelJEbE93UGFrM2JGWGRhV2Z5eUZON2pkdzhTVTFBK2t0?=
 =?utf-8?B?RFRuUTZvQytaSHBqRFZtWlNpWjZkemlVbDhvVnRhSUdsN3l3cnY2SzgvRVpC?=
 =?utf-8?B?Z1FQSUI0amNxUnNyK0I2OEZOa1JhMUpmUHJCcjcwRk9ydVBySDlWSWNJY3Mz?=
 =?utf-8?B?NFFtdjVBWWh6MHdXRXFqN0svM1pNQVlTSlNST01IQzRMcFdUMTRCcXMyMnlQ?=
 =?utf-8?B?N1pEbkhObldVQ25rV04rTTB5V3FBOTVHSDRrT0c0eFoyMnRZRkoydWVhY3Z6?=
 =?utf-8?B?NXFuRmtsTWpNdFdBYURhMGZJNFQ2enhkYUVSMi9VR1hMZmlQcFhqcnBwcWlR?=
 =?utf-8?B?M2l3ZU9ZQmM0bmptYmV1N0tjckhtL0hiOTd2WkZFZnd6K05PRXZHNVFhaHNF?=
 =?utf-8?B?Y09Jc3JSbldTNm5SNEdTQVIvaWdBMWt6RFlWM0lhS0xDOE9sSHc4QitBc0p6?=
 =?utf-8?B?enR2cnh4Tks5OGc4L25zMWRWa1poMHEwZnd6VCtpNzEzUWk3T2RJdDZyQWRR?=
 =?utf-8?B?WUdUWWVhV2prQmdvcVVxdHJWMEtjNmV4bjQ2dGZGWERHemZmZ05yZXN6NnVp?=
 =?utf-8?B?cHk1RklBeDgvK3cxaWZ6SEtSZjFhbTRtMHNzWFh0KzhCTnpCMnA0bVlEWkVm?=
 =?utf-8?B?ZUlmbVA3TjNsSG5CdVdUMnNWR3lEb3pJY2tWclRnQmVJRytxUUdKOE5MSmdD?=
 =?utf-8?B?bFZQZ01CT1BUM2RJa3BkY0QrQmRaaitGYkJuUVp0RVlWUTR2WE5leWlnS0xG?=
 =?utf-8?B?TDdOa2hTQW5jV2VQSVhJa2hSWHU5Y1VpRHVnSnpRS0gyY0YvNXpZM0NzR0U1?=
 =?utf-8?B?MUZPS2IyVEROS1hDN2h5M3VGME1KWUg1Y0VOUDBiUEh4dzEvajdXSm5XSG9W?=
 =?utf-8?B?OUliK1BxYlcyM2EwVmxOZUxZSmR2TmNYbDh6QktOUnM3WGJBa1Q1cWhpVXpP?=
 =?utf-8?B?eEsyeE85ZXg4Qys2OXJ0aUxsdFY1VGpnS0FiejRJaEFhTlRXZ0J0eFpRcWs1?=
 =?utf-8?B?cnhRNnZpVEFJOXdlcHNSYzlVSHprKy9YYlRXYWZVWm8ydHA1MktmYlo4RU1V?=
 =?utf-8?B?ZS9TMjFKbXlObjBGUWNvT2ZWMlBCZGtETlF5UXJnOUU4aFFiS2FKd2FDSkx4?=
 =?utf-8?B?Q1UxUXNjTU9EVDZiT3pqOUhaNXB3UzJoRkFub1B5a2ZUU0NxQ1Q1ays5cEd2?=
 =?utf-8?B?bXh4bThrQXR5R1RGTDRwZVJSSUtCdGcwTjF5TlRha0tXdm9weFV2Nk1LOE9G?=
 =?utf-8?B?ZlMzRHA5YUwydU40dGl6V3ErYkJuMTRZcjhpUVF0VWpqRFpBVk1XSkxiNVhk?=
 =?utf-8?B?ejRNTSt3NGpyVWlyWTJFcWdwUDNNb1RuZjdqeDhrRk9adE1rMFJaVUhmaGQ0?=
 =?utf-8?B?MHBJLzRXUFdUeU9CVlNLZjhUOG0wUHRremlMVCtKK2taalY2aVhjd3hVd2kr?=
 =?utf-8?B?ZSs2b3Znd1R1NkpFcjZZS0NLZGFKMHl0ckJzejBGYkZUaGtEQTlJNy81L1NQ?=
 =?utf-8?B?b2h0TDZxL0t3ZEowT3dQRGt2OXZlam80eitJaFVUdVJ3UnArSTJ2SHc2VUl0?=
 =?utf-8?B?Znhhd1VEbFhlQUZCVTd0Q0xXVGU5aDh4R01EN0ozV0x2VC92NEJNYVBnUGFy?=
 =?utf-8?B?ZCs4Z3pzaldtZGlrd05HRENQQ3k2Q0Q1THBhS25YeVFJaWVDS2ZTdHkzSmFp?=
 =?utf-8?B?MFRqcnVzTnhURHRVSHdxS2VmdHI4OXRsYXViMFBhTkkvOS9KODNZc2pKd3Vh?=
 =?utf-8?B?Vi9JRmJFQmxrN3hCM3MvS2pmaUtaRERlZ09PaEVaVHY0SWtWd0w3SEtBNjRO?=
 =?utf-8?B?QjQxdk9FUm1FTUdZRlJKUWxBZ010bUF0MXUwVFVxR2JaYmtWLy9PaGVyRTBm?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eVhvd21UYm9ac2RDUFM1SmFjWDdQYkRNUXRPZnE4b0tubENaOWcyL0xFNzc5?=
 =?utf-8?B?eHFxanZldkVRbGV1VWR1Q25XSm5OYWpnbml6YklYckExcENnS1YvZHV4SkN4?=
 =?utf-8?B?V0s1aWF5aDVxYTB1VU5SQXBqd2U0YXFibjZCSGNzZ3ZqZWFsTEd4T3VmOWFj?=
 =?utf-8?B?YVBWWUZGazVVTzBzNlYzdC9UOVpycndOWXZyYmZTTmJ5aWlGUlRKbEFyS280?=
 =?utf-8?B?bGhVSkh4WXBYQ3FYTUY4eTVEeHRIUGdOL1MxcFNqNTBNQVY1ZjdQYmVPaWRP?=
 =?utf-8?B?ZkdFWDhPbHVFQ3JJQlFxTWFPUnVSNENNaE16UHZPNEZ4aVBUU3V2N0xZbmJZ?=
 =?utf-8?B?T2dBSm1GSVM4eGJvWnhFdS9qUlNaTjFPMFVTUGwvWURUUG10SEk4T0NKZ2xI?=
 =?utf-8?B?MGpBVEtRN2l6WXVpR1IxOUNJVlZyOUQwbVFmSWN1QlRtTFFlM3IwLzF3bFNx?=
 =?utf-8?B?N1NTZWkyWStySFBkaTgyQS9SOUhWMytQUHN1WTk0c2JTUVFyWHo3RUFjTS9p?=
 =?utf-8?B?M1BXU3d1b2tmb0JEWTA3L0hhT01TUVhBSFlyYnoyMTJVWGFOMDkybzhvMUdM?=
 =?utf-8?B?WnUveEVhR0ErbkFhc3ZPaXZQSVFmUVQwRG9wcWxCcW1sZHhDSTdjRUJBUnFk?=
 =?utf-8?B?ZHkxS2FRUTk5Z2RtSWpMN0tHQjBLNTRGRGg2QTZEc1VWZlZZK0k2bEJ3QnJE?=
 =?utf-8?B?UlNvWExqcGxxaUxjVHZjOUxOYTZ5YktwSFRlL2pnejdSMHlJa1did2pzQmE5?=
 =?utf-8?B?S0JqZzZwN3RITm9Ob0loWWN3NEFKZTVnS0dwUk1UTWdVQ2dlRFdYTHE3NTMr?=
 =?utf-8?B?MHFRbTMyaWlkV3RwUnBjZVpOQ3ZjZkdLOXUzVVFnOEJxdlgwenlqR05qTkZj?=
 =?utf-8?B?K2p6SHdIWTI1cy92UWY5cHEraDRJVnlaWEVaY21oYk8vKzFodnErWTBXQ2Vm?=
 =?utf-8?B?c2FSaUtwcGoxdmJhWGtuUFU4M1FKRHJOazVaa3hSeXluR0luaTcvUmk0bFlj?=
 =?utf-8?B?TU9uaEsxeGpQWVo1cTZSWGpDaWMzYWM4YTJzbFFmWUkzRHhhM3dVOGh0ZjBo?=
 =?utf-8?B?N0RxU01Lb1Y2NWF2ZXhwdVlmdGhsY3FWeFNSRWNIR0x5SmF0VyswOFcvRzBZ?=
 =?utf-8?B?TXdUWGZZNHdDNk9Da21qekhtY0YzTk9jdkJEMFUwMG9YSjhoa0Q3T1ZjRm5v?=
 =?utf-8?B?aXdIdkx4WGZEb20yYUdQaEd4VTMzSEJPZ1NUTU5CMWtaUlNtL29CQXhWbW1n?=
 =?utf-8?B?Wmc5elpDZm5ObDlKNDQ5ZjZtY0EyZkRPK09lN1ZMdzRvUm5leTBybmpneW5y?=
 =?utf-8?B?OVdCdE1Sek1Md3k0cHBWeENmSlZlOFpuVUh5OG9ta2RldkNkeE94SFZtc2pL?=
 =?utf-8?B?d1JFNVk2QndrWkpRd2NGaDkwRjRvdUxRcmJ2YVM3UlJFY1oyVVVQNkZ5dHlr?=
 =?utf-8?B?VjZPd0lieGJmamNJYWhpenRWMlU2RnNLZm9obk02cm0raXFGVkNxVGIycE8y?=
 =?utf-8?B?QmxOQzdNcnoxNVplaWc0eFlON0dBaGRWZVVldERNQ1hmN1ZrY0h1MEkwREVu?=
 =?utf-8?B?VG1IMkFqd3l4SVpvemtVWmhzYmVlL055cUJ3eURJQnJhY24yN0pPYWIydkRJ?=
 =?utf-8?B?RHJLY3pDbGRvSnU4Nnh4cjY1bTJNR0VQZ09GdnZRT2o0T1E3VHNFWDlnNmFS?=
 =?utf-8?B?dHo5Z2xKNjBsdUhnZkFQZ0lnZlBCanAwd0dhUEtmUnNZVHVhSE1Id3J0WXpv?=
 =?utf-8?B?RXVzQVlxcldZTVZpdlUzNmRqbkVtWnJLL080bTVJdjlZU0g1KzM5b0N1SEtS?=
 =?utf-8?B?dnFNcWIzUEsvWUtldVNNV21FOEJ4Y3crYzJIeENFekovK0NJSnJnVmlDdjBO?=
 =?utf-8?B?UlYxa0FjOGNVYmRuUXVLZHlHSFM1K3lqekUvM0pGTjNLazY1aVdLRHplcVVi?=
 =?utf-8?B?ejlSSDVJMEtBWEtESGpNZEcvTGtSYjFqYkVnbk1zOWpDMU1zU3g3WFpjM2Nh?=
 =?utf-8?B?S2hDL3AxMFFnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5c5555-da55-447f-be16-08db78f09a84
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 22:31:38.9496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3npSjDU1LZEgTEg50F3YhpP37hnC8xN5qiBdPuGHiJbVMchT7UNaP0wmlkHL9FzoNrExM33oHszcD1cuMdqDSzkSXr6utSYXrJHlVy38uWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_09,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290204
X-Proofpoint-GUID: lg7u6owD7SldWTyJ752AQmBPImAIewCp
X-Proofpoint-ORIG-GUID: lg7u6owD7SldWTyJ752AQmBPImAIewCp
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy,
Thanks for looking at this! Inline comments below.
eric

On 6/29/23 15:59, Randy Dunlap wrote:
> Hi--
> 
> On 6/29/23 12:21, Eric DeVolder wrote:
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   Documentation/ABI/testing/sysfs-devices-memory |  8 ++++++++
>>   .../ABI/testing/sysfs-devices-system-cpu       |  8 ++++++++
>>   .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
>>   Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
>>   drivers/base/cpu.c                             | 16 ++++++++++++++--
>>   drivers/base/memory.c                          | 13 +++++++++++++
>>   include/linux/kexec.h                          |  8 ++++++++
>>   7 files changed, 77 insertions(+), 2 deletions(-)
>>
> 
>> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
>> index 1b02fe5807cc..eb99d79223a3 100644
>> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
>> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
>> @@ -291,6 +291,14 @@ The following files are currently defined:
>>   		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
>>   		       kernel configuration option.
>>   ``uevent``	       read-write: generic udev file for device subsystems.
>> +``crash_hotplug``      read-only: when changes to the system memory map
>> +		       occur due to hot un/plug of memory, this file contains
>> +		       '1' if the kernel updates the kdump capture kernel memory
>> +		       map itself (via elfcorehdr), or '0' if userspace must update
>> +		       the kdump capture kernel memory map.
>> +
>> +		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
>> +		       configuration option.
>>   ====================== =========================================================
> 
> Did you test build the documentation?
> It looks to me like the end-of-table '=' signs line needs 3 more === to be long
> enough for the text above it.

Hmm, the 'make htmldocs' renders and views ok. Is there perhaps another method I should use?

> 
>>   
>>   .. note::
>> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
>> index e6f5bc39cf5c..54581c501562 100644
>> --- a/Documentation/core-api/cpu_hotplug.rst
>> +++ b/Documentation/core-api/cpu_hotplug.rst
>> @@ -741,6 +741,24 @@ will receive all events. A script like::
>>   
>>   can process the event further.
>>   
>> +When changes to the CPUs in the system occur, the sysfs file
>> +/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
>> +updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
>> +or '0' if userspace must update the kdump capture kernel list of CPUs.
>> +
>> +The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
>> +option.
>> +
>> +To skip userspace processing of CPU hot un/plug events for kdump
>> +(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
> 
>      i.e.
> 
got it, thanks.

>> +file can be used in a udev rule as follows:
>> +
>> + SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>> +
>> +For a cpu hot un/plug event, if the architecture supports kernel updates
> 
>           CPU
> for consistency
> 
got it, thanks.

>> +of the elfcorehdr (which contains the list of CPUs), then the rule skips
>> +the unload-then-reload of the kdump capture kernel.
>> +
>>   Kernel Inline Documentations Reference
>>   ======================================
>>   
> 
> Thanks.
