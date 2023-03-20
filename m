Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620C06C1860
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjCTPXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjCTPX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:23:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF3033CE2;
        Mon, 20 Mar 2023 08:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNW/NMZiCRlai16FOB1iMVzrwuwX21tA0Tal6dFjAc9VFLp6el7gOuczYfhwgO4HTPm8kcfPakVUUJmSHSu6d1nsShbAcTX51sI3pd5wmVGBeNd4YZzyUoFznIEBnibU12lf4ixTv+TRKiUHz/XTGQv2d06X7+88Z69pA4zyYKrJqYWyMrEdkZIiAF7LU0zAfM/p5G412b4TUSqyIl9A08p75O9h/ZirtYOL+3tloJvaHZ2BVR7XE2lWxiQ74rZ3ZLNKJDYefB6m1bI8dB03FwdTolxqaZb8crHz2YlWcVOeE1jQ5DHKKfljep0eQ4y3xThyAttEQfQNigcbn9u2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5U0yKd0t9d7cS3AepyrOwTcs4oQHbVCj9Y6yY7dLKM=;
 b=Ja5nVNm4mqcmsmE7NJJky2fcqis1q0msLPN9Ud10y/pcR0yCpaASAYwvKdKY1ECFVSqTYbbVDTrte1CMQ1ZR1PeTxAQGniFc7nOL62uVT0vPFAgK/8b1kFdymzsrETq070izFoOmeQunrChNt4E3604YDVDykGu9Q4sGq5UkWbSiJRwP1j4GD2Jd96Kv8iRcDsyKoC3Q7n8vtaLYIhxUsuJ5+ciZ8sujP3c3tezu2BCB4GLh1NGtnfpqTGqEK1hBZ86Rt/xBybvdoDeBTDfXrlxTueu/q0J4UC41ffaJGL4MXwQ/dbWOqoXfI/rTUvdX6CP8SEM8SL9QdIwG2Mc1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5U0yKd0t9d7cS3AepyrOwTcs4oQHbVCj9Y6yY7dLKM=;
 b=kOpf9icS+BqM3gtFE0e2DxkLm5w7Wb59+q5wHblOXAmqXIL2nvrAxxrmfPqz6pLXV5mpAklMG2mvfbKysbf2RIQ2p/IygWMlozr2Ojx6uUQlqsUKt2QtCv4kzB9V+nyEemhY68FNXr1TlOmaQBMbQ6MvHFbCD4r5aviAMCzQC0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 15:15:47 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 15:15:43 +0000
Message-ID: <0d9775a3-8b5d-d30b-c473-b5364a4111fa@amd.com>
Date:   Mon, 20 Mar 2023 10:15:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
Cc:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778866506.1053859.2329229096484796501.stgit@bmoger-ubuntu>
 <9af9eb7a-476c-d4b0-e114-3f5c2b45dd95@intel.com>
 <MW3PR12MB45537DC45130BB5F02F0F3F095BC9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <71b58853-e7c9-b522-3f90-c3d84cba1317@intel.com>
 <39c85927-9c34-0284-86c6-724f417423db@amd.com>
 <7a71ac36-d9dc-c2d8-31fc-127225d21ee4@intel.com>
 <044fd84b-257b-d450-2b4c-f6ca5ef47f7c@amd.com>
In-Reply-To: <044fd84b-257b-d450-2b4c-f6ca5ef47f7c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:610:50::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH0PR12MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: b4bd485b-717c-47b0-2bb2-08db2955f8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EymomfUDm0vI5KzCSFIZyOvzMX8KOvoMyiLQ9ufHZJ7egmaqKNDWZQ4WtZ5k4HQs2TnHllyOkbwQdvJWHTTyKnuA/pi4ACgc0/1vFUbmQWVQectlejVF+5//aStw2jP+wfxa1Tvq7SUli1Jba9DQVeO3XBZTc8kkV3aovoQ+kjh1vGqUABSo2J9pOOEK/6xY12qKe/Smqd3FdNXhe3Mdt9DrEpxgX0SXp7SUk3Jjgi9nBphzJuVuAenRtP2c7fzUWRdKEJzI45TwlQoLD4eIsAk2fFUornKWI2vw7tK/zmjXETJqwaaN/np9AaKAqr6Ik153474sQp0GzdrvVF8BhHZ6u0LIYrR3jHLwVs10/Yj61wQmpNu+nP+MFJezjshPBo2hK+QzFcTdShBtZzMIpDtK0rdJZ9apZlnR7oE7oJNYyWr6+iMBc+Qf8b3xb8f1xw6irOV+q7swsG9OO/s5ucVXlNZRHFDCR5VApmSSIlOWRyBwq+njtviOPBeOBGX0ml8Ce4CxKGQ0YNLB4MS8Va6XWc9gWjF8EdRP5rpaZa1VFPkkqBlc7TJPpjduW1L7HEriVLCF3mBLNdIIMuM6OTOQbCh6LClmF3o+baTLLAtfMHcps4garx1nJIb04qSUiryP4DqHJQN0fKuRQjWd8htPtmfqrOE+pBMqcMk1DMZmyk769IbRsQzFTBXHrXqpkNVTHp1kesiGhloFvvNF0ARRVs1FJQD6xXDfDEzu3tU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199018)(86362001)(31696002)(36756003)(83380400001)(316002)(4326008)(8676002)(53546011)(478600001)(66946007)(186003)(54906003)(66476007)(26005)(6506007)(6512007)(110136005)(66556008)(2616005)(6486002)(31686004)(38100700002)(66899018)(8936002)(5660300002)(7416002)(7406005)(41300700001)(3450700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnJ1Q0xwamJCSFhRMStVUkpaVmJkUGUvc3habElEYWZxcGxxa2lLZkpzeC9P?=
 =?utf-8?B?M1oyRVNNQ05JMlEwemQxUnY0c3FlcVh5Q2daWjBGWVhuTjBWRVhicklxYUNs?=
 =?utf-8?B?STlSb21oRHN4cUhxZzhWcUZRZWF4dnp0VHpKUlVvdmJBVmoraitHckc5ckxi?=
 =?utf-8?B?bnBpRU1TSGJiUjlua2JVYkZEaUsxOGYzbXl0ODdNSjlaSmY5SUZsaVBkYTdZ?=
 =?utf-8?B?ZzdaOUQ1NkdDclE1MUlVY0szRFhZYzVrcEtSMGlFOGRaMXFhcUxrMmp2WnNX?=
 =?utf-8?B?emVaRWpVdkJFME1UNFhUK1JVZmhheFlvMThQVEVmQlBPWTlNSkhSakxtZDlh?=
 =?utf-8?B?ZUJiTnhTcU83QkF2Wjl5OEQrZEYxUUJ5bHU1bU5QVmVvVWd1ak9tQTYzY3dK?=
 =?utf-8?B?WERJMVFYUXF1eldoc2hrSmlVVFhnYXFpbnhHdlJLKzErUlRWb0xMTEE2TldU?=
 =?utf-8?B?bllBMi9OdnJtblZmNnAvaVNUenJVaGw3Tnc1S09teEkrLysyNk1IYnQxbnFL?=
 =?utf-8?B?UHpPV2ZEMEgveUNKd3IrTE83V01RNVdEdUNXTS9NcXBiRldSRWhFdy96WUMv?=
 =?utf-8?B?TURsNWdTWTgrNjNvaWxZUHlEZmdKZGw4aDZLRW5KbSt4QUptUG52bEs5STdy?=
 =?utf-8?B?R2FXaEp6MysxdmhVYjV0TVFqYWRXZERYTjF4cWh6by9VUnFsb3ducTgvYWJZ?=
 =?utf-8?B?bFcyUGxTQTlZQXNEWmNaTVFMRTR0VElCRnRCR1Y1bEtPRUJ4VmxTeE1xLzJV?=
 =?utf-8?B?WHlHTFBleWpwZzJJWXlZT2JBTVhLaWhVYWVRS1l4MEtsUlFTaEZWUGtBRjVv?=
 =?utf-8?B?MTBFaTl2Z3o1c04vbWR2bXJaYlJzOEx2TXkyREx2UERHNm1XaTRMcFFzTm8x?=
 =?utf-8?B?NEo0VjNrWWJQendqZ2JVd1gyRHA2b0oycFhhaFBKK2xWcHhlWUo3MGRHSHh6?=
 =?utf-8?B?MUZ5OThaVWUvTURmRWdZamdXNXlSaURXaXlUK2lTTk1ER09YTXd5K0U3Mm5S?=
 =?utf-8?B?NkhqSmZwbUxaUXc5YzRKQjdRK3JIdjJaaDZ0a0ZtckxTVHBDc1E0WlNKQWlD?=
 =?utf-8?B?L2t6UVFpRWJvNzhhZlU3MVFrQytzVmVDNzNnRHBvb1Z6TFp1V3FCOTBtWlVn?=
 =?utf-8?B?ZFVKYUFKaEZ1OHJDUFRXcGVFaTdpbTUrWXpHZXFIbTFVeVdTUDN3TWllK1dh?=
 =?utf-8?B?aVpZL0ZYNm1Vb0ZQUW15RCsvcjgvOHZkQU5uNzMrZTZLYmdSODE1OWwvNm1l?=
 =?utf-8?B?TFhzMWFqcEh6NVE3RTYvekFaajNPR2ZhVEdNQjlaN0p1UmdnUzVPT2ZjTytJ?=
 =?utf-8?B?OWVOa2E0Y0ttMURiZ1VrbUJGcW0xR1g5VmJzQmFKZTBLTkM2MHVraWJIRzJ6?=
 =?utf-8?B?dmJ1aXhldStNbkZGb0hEcitha2pUcStXMXV4TnB5WUxsSUNmaEpIVm9GbnBD?=
 =?utf-8?B?QzZBRHFxaU0wWGx1LzlMdmNLVTFtckY4aWhsODRBRWRyT2l5Tjdwcnl3K2xh?=
 =?utf-8?B?MytlY1hPOW9nQXhlbVR2NFJiK2V4NjdVd3NkWE94VFJsYTZ0NG9HZ1AzMVBv?=
 =?utf-8?B?U0N1RUF2b0EyMGJvM0ljVUtSSjhReEhyZVNPNWZJUERDRXQxcUF2Y21za2VS?=
 =?utf-8?B?RDdkREVlc2xtY0tkNnoyenBsclJkSmZRaFJkRXo1amt2Tk1aWVhYUm1YcEtC?=
 =?utf-8?B?eHZYcTRZY0FLeE5DbkNYL2FERUQ0ZC84VXVRZFpDU2oyMlZxNmV0RG9uK3ZN?=
 =?utf-8?B?OXcxb2x0ajdXWXJVT1dvSFY4dTRQTkQwajRLT2ZQK3BMUG9BQ0tUc3RkUlBz?=
 =?utf-8?B?Rk5jVEJ4WFlHRXJjeTlhQ2lPenVNTnY5MEFTNDJobERvWW81UEovTjNDeVJt?=
 =?utf-8?B?SjhoWHlPd1hMZGl1ZThTeGEyZVZ3b05zN0xHQVhYMm5kUmtwOTc1M3RzaGxu?=
 =?utf-8?B?YVVFaWIrcjlQZVBXWkJPdE45ZEFTSFFBbGd1UGhoa0lVdlVaMkJjY2ZIY0Jq?=
 =?utf-8?B?dzF1Mmg3M2RsQ1k1NXE2SnNRcWdibndTNXh6YzhnZ2J3T1B0dzF1ZUV5aVNm?=
 =?utf-8?B?TTlyN0gySTl2MWRYc0ZES0ZKdmRmcUxpT0xwR3A5QlhObTc1QUJQUUJmNnlU?=
 =?utf-8?Q?vS4o+uItZe5ZY/+Z1AlyBQ58k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bd485b-717c-47b0-2bb2-08db2955f8f3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 15:15:43.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4elnePwb++eQvx+DSmC1YUss0sTJ5mkSaqoduEONfoarnPUO3PWmbpcyAVUgsCj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/23 10:07, Moger, Babu wrote:
> Hi Reinette,
> 
> On 3/16/23 15:33, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 3/16/2023 12:51 PM, Moger, Babu wrote:
>>> On 3/16/23 12:12, Reinette Chatre wrote:
>>>> On 3/16/2023 9:27 AM, Moger, Babu wrote:
>>>>>> -----Original Message-----
>>>>>> From: Reinette Chatre <reinette.chatre@intel.com>
>>>>>> Sent: Wednesday, March 15, 2023 1:33 PM
>>>>>> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
>>>>>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
>>>>>> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
>>>>>> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
>>>>>> quic_neeraju@quicinc.com; rdunlap@infradead.org;
>>>>>> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
>>>>>> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
>>>>>> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
>>>>>> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
>>>>>> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
>>>>>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>>>> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
>>>>>> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
>>>>>> peternewman@google.com
>>>>>> Subject: Re: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl group
>>>>>> at once
>>>>>>
>>>>>> Hi Babu,
>>>>>>
>>>>>> On 3/2/2023 12:24 PM, Babu Moger wrote:
>>>>>>> The resctrl task assignment for MONITOR or CONTROL group needs to be
>>>>>>> done one at a time. For example:
>>>>>>>
>>>>>>>   $mount -t resctrl resctrl /sys/fs/resctrl/
>>>>>>>   $mkdir /sys/fs/resctrl/clos1
>>>>>>>   $echo 123 > /sys/fs/resctrl/clos1/tasks
>>>>>>>   $echo 456 > /sys/fs/resctrl/clos1/tasks
>>>>>>>   $echo 789 > /sys/fs/resctrl/clos1/tasks
>>>>>>>
>>>>>>> This is not user-friendly when dealing with hundreds of tasks. Also,
>>>>>>> there is a syscall overhead for each command executed from user space.
>>>>>>
>>>>>> To support this change it may also be helpful to add that moving tasks take the
>>>>>> mutex so attempting to move tasks in parallel will not achieve a significant
>>>>>> performance gain.
>>>>>
>>>>> Agree. It may not be significant performance gain.  Will remove this line. 
>>>>
>>>> It does not sound as though you are actually responding to my comment.
>>>
>>> I am confused. I am already saying there is syscall overhead for each
>>> command if we move the tasks one by one. Now do you want me to add "moving
>>> tasks take the mutex so attempting to move tasks in parallel will not
>>> achieve a significant performance gain".
>>>
>>> It is contradictory, So, I wanted to remove the line about performance.
>>> Did I still miss something?
>>
>> Where is the contradiction?
>>
>> Consider your example:
>>    $echo 123 > /sys/fs/resctrl/clos1/tasks
>>    $echo 456 > /sys/fs/resctrl/clos1/tasks
>>    $echo 789 > /sys/fs/resctrl/clos1/tasks
>>
>> Yes, there is syscall overhead for each of the above lines. My statement was in
>> support of this work by stating that a user aiming to improve performance by
>> attempting the above in parallel would not be able to see achieve significant
>> performance gain since the calls would end up being serialized.
> 
> ok. Sure. Will add the text. I may modify little bit.
>>
>> You are providing two motivations (a) "user-friendly when dealing with
>> hundreds of tasks", and (b) syscall overhead. Have you measured the
>> improvement this solution provides?
> 
> No. I have not measured the performance improvement.
> 
>>
>>>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>>> @@ -683,16 +683,34 @@ static ssize_t rdtgroup_tasks_write(struct
>>>>>> kernfs_open_file *of,
>>>>>>>  				    char *buf, size_t nbytes, loff_t off)  {
>>>>>>>  	struct rdtgroup *rdtgrp;
>>>>>>> +	char *pid_str;
>>>>>>>  	int ret = 0;
>>>>>>>  	pid_t pid;
>>>>>>>
>>>>>>> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>>>>>>> +	/* Valid input requires a trailing newline */
>>>>>>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>>>>>>  		return -EINVAL;
>>>>>>
>>>>>> The resctrl files should be seen as user space API. With the above change you
>>>>>> take an interface that did not require a newline and dictate that it should have
>>>>>> a trailing newline. How convinced are you that this does not break any current
>>>>>> user space scripts or applications? Why does this feature require a trailing
>>>>>> newline?
>>>>>
>>>>> I have tested these changes with intel_cmt_cat tool. It didn’t have any problems. 
>>>>> We are already doing newline check for few other inputs.
>>>>
>>>> You tested this with the _one_ user space tool that you use. This is not sufficient
>>>> to be convincing that this change has no impact. I do not believe that it is a valid
>>>> argument that other inputs do a newline check. This input never required a newline
>>>> check and it is not clear why this change now requires it. It seems that this is an
>>>> unnecessary new requirement that runs the risk of breaking an existing application.
>>>>
>>>> I would like to ask again: How convinced are you that this does not break _any_ current
>>>> user space scripts or applications? Why does this feature require a trailing
>>>> newline?
> 
> I dont think this feature required trailing newline. I may have carried
> away from similar code in the area. I will remove that requirement.
> 
>>>
>>> I do not know of any other tool using resctrl fs.
>>> So, you want me to drop the newline requirement for this. I can try that.
>>> Will let you know how it goes.
>>
>> You continue to avoid my question about why this requires a newline. Until
>> I learn why this is required, yes, from what I can tell based on this patch 
>> this requirement can and should be dropped.
>>
>>>>>>> +
>>>>>>> +	buf[nbytes - 1] = '\0';
>>>>>>> +
>>>>>>>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>>>>>>  	if (!rdtgrp) {
>>>>>>>  		rdtgroup_kn_unlock(of->kn);
>>>>>>>  		return -ENOENT;
>>>>>>>  	}
>>>>>>> +
>>>>>>> +next:
>>>>>>> +	if (!buf || buf[0] == '\0')
>>>>>>> +		goto unlock;
>>>>>>> +
>>>>>>> +	pid_str = strim(strsep(&buf, ","));
>>>>>>> +
>>>>>>
>>>>>> Could lib/cmdline.c:get_option() be useful?
>>>>>
>>>>> Yes. We could that also. May not be required for the simple case like this.
>>>>
>>>> Please keep an eye out for how much of it you end up duplicating ....
>>>
>>> Using the get_options will require at least two calls(one to get the
>>> length and then read the integers). Also need to allocate the integers
>>> array dynamically. That is lot code if we are going that route.
>>>
>>
>> I did not ask about get_options(), I asked about get_option().
> 
> If you insist, will use get_option. But we still have to loop thru all the
> string till get_option returns 0. I can try that.
> 
>>
>>>>
>>>>>>> +		ret = -EINVAL;
>>>>>>> +		goto unlock;
>>>>>>> +	}
>>>>>>> +
>>>>>>>  	rdt_last_cmd_clear();
>>>>>>>
>>>>>>>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED || @@ -703,6
>>>>>> +721,10 @@
>>>>>>> static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>>>>>>>  	}
>>>>>>>
>>>>>>>  	ret = rdtgroup_move_task(pid, rdtgrp, of);
>>>>>>> +	if (ret)
>>>>>>> +		goto unlock;
>>>>>>> +	else
>>>>>>> +		goto next;
>>>>>>>
>>>>>>
>>>>>> The documentation states "The failure details will be logged in
>>>>>> resctrl/info/last_cmd_status file." but I do not see how this is happening here.
>>>>>> From what I can tell this implementation does not do anything beyond what
>>>>>> last_cmd_status already does so any special mention in the docs is not clear to
>>>>>> me. The cover letter stated "Added pid in last_cmd_status when applicable." - it
>>>>>> sounded as though last_cmd_status would contain the error with the pid that
>>>>>> encountered the error but I do not see this happening here.
>>>>>
>>>>> You are right we are not doing anything special here. pid failures error was already there.
>>>>> I will have to change the text here.
>>>>
>>>> What do you mean with "pid failures error was already there"? From what
>>>> I understand your goal is to communicate to the user which pid
>>>> encountered the error and I do not see that done. How will user know
>>>> which pid encountered a failure?
>>>
>>> We only have couple of failures to take here. Those failures are already
>>> handled by rdtgroup_move_task. It logs the pid for failure(using
>>> rdt_last_cmd_printf).
>>
>> The pid is only logged if there is no task with that pid. How about the
>> error in __rdtgroup_move_task() - how will the user know which pid triggered
>> that error?
> 
> Yes. These cases we may be able to report the pid.

I meant "we may not"
> 
>>
>>>
>>> I can say "The failure pid will be logged in
>>> /sys/fs/resctrl/info/last_cmd_status file."
>>
>> That will not be accurate. Not all errors include the pid.
> 
> Can you please suggest?
> Thanks
> Babu Moger

-- 
Thanks
Babu Moger
