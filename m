Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF1F6525E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiLTSBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiLTSBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:01:07 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8919CDEE4;
        Tue, 20 Dec 2022 10:01:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKm738BRn9Vs6YKaOIrU72S1q/ee8pItnGDnlmy1uFL4p475nck3s1jyZPDbg9yubbhzR4XGVgnfk2fmh+NqI3410PfagtzhI5enZVG7u78NDXflBWPUM7n4+lXa2h5dRKwMmJ2TuPdIHp0eX6di7/lFHmQ+ePKck0PgLUvhoZ90FnQWzK4uyEYCvkXa0JwtAhBkUt+FIhPYsieP0w2zqEC1vEDXWCa9ZG6VvKa5kbAbCHPF41n9pTn12p7rFCw9mOEavzmU42k0vYD9J0SjWap11lg7OITviFAStmESm0ZqD4ZhBye3wq75sHGtu+l3lhGXtR2Rr/YRryFvfIOjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uy0v/DLH9LWmdojn1YzXwdQpEh9BrHoJypQe/wAA0q8=;
 b=Um6mFUvLO5aAisSr8Oy0uFSMCcrUtVTnTtn0BHG3zzF6HfkOjpWZfemlbwFx/qSZiedGtIfq1ku3snCyfHlVGslp0USazluBbMrHYsYaOwTE6CFR3AqJkc8/evxvzihTGO0QMZEX9XVX0OINjN2dbwZhj9ls5NIgXKGd04OwRDg7uhqQ/PdzwpCh7rsDrxaOXsbStry3RNWJttFCZ03xsxHUNvt23z/QCSV/46bx8YCYMkzN+wNGLQjPw1c6y1FBW1QW+iU6MNcwvsWn+Kx9FmzVZj+7v+i9t34huoVsOavoOVCuCzxd8B5Ci1T3ZYIP+AOeJwoc0qLmvRo91qhB/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy0v/DLH9LWmdojn1YzXwdQpEh9BrHoJypQe/wAA0q8=;
 b=Qy84rGAW7v2WRIyGmjJwkrZ5xGbRAkrqGCUuC/XgVps7tXYiYaYZpQ5bzM26Cb/ALMXdo2zI5bgSdD8u90RagC3CgzdDMrE13Ag6OLmTMuTn9R8dYS6XXI1eT1ZpimAGt0J97CuDgqqInNG6foVs5VEjcL6ug6C6c3Njs1ysGyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 18:01:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 18:01:04 +0000
Message-ID: <e9964a9e-92df-e8a3-427d-18f713ae8637@amd.com>
Date:   Tue, 20 Dec 2022 12:00:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
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
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990903030.17806.5106229901730558377.stgit@bmoger-ubuntu>
 <084224cb-271f-a1c8-6665-1953b2574495@intel.com>
 <MW3PR12MB455337B3EFAE3A0E37D042AF95E59@MW3PR12MB4553.namprd12.prod.outlook.com>
 <e7452b29-8e9e-a3e2-a870-2c251e48507d@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <e7452b29-8e9e-a3e2-a870-2c251e48507d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:610:77::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff544bf-f904-4446-e4a6-08dae2b42928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hu9X8qeZco797ZbE2+r6A3PwIJnf4xqw+jYSp9s62YuwfS+K6m/Ldi4maQrJ9KctFKyZlvvF3wR+bQBLoFoGLP5DXiQ5ge3IdB2wpP7iCGO0ddRa1DQKIXqqZ901WxvGa2j2ScAONr4hgvvKlcpire8sArV+pCUHBCnWY1Emx5TwowCl33ULmT8c0Uf7WTJSluLbk0c46aClAQAJMHMGJ2kbeoMb+XN18UOTIkJV9fu4QAHyn3VloBds+p75o3qgnaLqyT/N0oL8cm/ulRv5m2xshwUfkz60XULGgjys1lcJ59oBBfyOms1AQsf9qdtVmVY+xu8oAS1ad6w8sDnS/CVcHOjzDVJvR1N6ucxomxK8/Peewd4pQCyWROQcQf011yPed6X0iBrAbdfiIeG3FMAOyCRn8M2acqKAyOtouC8zCblc8BuaX49oM5eczSwCOVeNwYtdhVu/J1xdWJxhX451rkiFvXh86aeitq88EpxYhs9aDdkFzPPlPVTr0RqzcB8SSZ/m18gdBLQV10VA8LVIWce6lhSdECH7Hhefguq5kAz6r59+cmbDwU0HKU9ihBcTGA57qsM0Lrj41vlCrDFN8JE+cicywyQVqynER0NtKhQ+uRA5JS8FDI3XDP0JbIUiCCZlcgqIJaFVFmYdTrgW8sTVieXJkiJxS4kaSCFf2pyAr2RLNFoh7xpcI0Vfgn6vvnWuwhJFnSUxhTcmRyjbct7rtNeXn+s7aWiN7zQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(2616005)(31686004)(86362001)(38100700002)(6666004)(26005)(6512007)(2906002)(3450700001)(186003)(110136005)(478600001)(6486002)(36756003)(6506007)(54906003)(316002)(8936002)(53546011)(66946007)(4326008)(31696002)(66556008)(41300700001)(4744005)(66476007)(83380400001)(7406005)(5660300002)(8676002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEY2WDR3NHIvT3dhVXpmNk4vaHEyVjFUY1R3c2hkUzJkSFlYSXhiMVRiQ0tI?=
 =?utf-8?B?SmhnSFdlWCtuUHFlbFRGTTB5aCthZW5uZ0Y1cEFTdzhxTGZnbE5DYnFrSmVW?=
 =?utf-8?B?VmJoMXJwUjNhL05qL0tmQ0ZuOXhFZWMvL3ZOODRmbHNaSmZGeHd3SWo1dWFy?=
 =?utf-8?B?SCtoK1pjbFZkNzdrN1p0bHFpWGo1QnkzbFlrZ2FMZ1pvekFBaXc1U2s0dVVz?=
 =?utf-8?B?aEFBSGhhSHZzZm1GTzdQelFMVE1kbTVZNjZOckVWVHU1aUpIb0RVUXRPQWF1?=
 =?utf-8?B?OXZRNHlzc0IwZmFtaGFLUHc1NnFYaml6a09Kc1c1dElLMU5ZdTlkcGpQbVdU?=
 =?utf-8?B?R0kzaHNkelZaTWxIdVU4eHVoVm00d0g0OU1XZDU0OHZNS2FMUU44alRPdmtv?=
 =?utf-8?B?OFdCalBGNVNmTXVRVlNOV2ZHVjFlVE5yWld3M2QreStpWThwZk4rQXJtY0xL?=
 =?utf-8?B?aGE1bUEybGtxREtjanVTU2NreUd1WmZKeDhvbWZFeHByWlJVV01HZDhVY1h2?=
 =?utf-8?B?NlVScys4Q0FrUzQyRUp1aExvZDdKR284aVV3bzFCQVBHY081Q0w1eHV2ZGUz?=
 =?utf-8?B?VWh5aDdtN2pNbHlvN1Q0dUJOaVFMZTdaVGtQN1V0Y1FST1VXSEJWN2w5UkVE?=
 =?utf-8?B?bnI3QnAxL0Z4THlyNkpzNHBKVlhkOG5kYzMrWnJKTnQyRlU0WTFVNjRMeTBE?=
 =?utf-8?B?M1hxUTE1b2tlV3BCaHVPR3ZyK1JYSFI5elBLMTJ1VW1iR3ZCNnZvRzBIamx1?=
 =?utf-8?B?RGxEdDZJb3RROXo1ZkdkZ1RDWVllNFV1dHppckFUSjZ2ckJZekpWOE92bm1w?=
 =?utf-8?B?NzF0cmlSNWtVQVUya25uSXJCb2hZL1l6amVnSmhKQmFwdTd1N0F5Nk9ZQlZ4?=
 =?utf-8?B?UlkrNW5MdWUxWUpKdCtwOC90dTVrTXpEdWRRMkVNK0wvTFZtWmJlajNEalA2?=
 =?utf-8?B?L2NINzNnSlk3VmltU0ZuVGVXbGluaFNkckRzdGpJU2x0UkVraUs4RFVTUWJJ?=
 =?utf-8?B?Y1RBdi9pa0FISEIyL3pWZ1RIcFg5bkVIV0RYaG91VEVDZ3Z5ZlQrTTlPWmtp?=
 =?utf-8?B?Z3B2dm1DdlVQVkxiQk5ZOXFnNExvREFBN2g5ZUhOSWJXaUJjN2NSM1YrUjdv?=
 =?utf-8?B?aml0ZHV0N3Q4K1ovWWg1OG1HYytnb3dNMlM1YVFyT3FqTWhJYXFNeklQNmpV?=
 =?utf-8?B?MC8wSjN3Wk9JQUlVTlEzU2tqYjhCOVNLYkJoOG9aSEZhYTlJa1J5Mzk4Tyth?=
 =?utf-8?B?SVBHZWtUUHRjNUpRMjNqT2FaR1BGc3BZS1pRWE45QVhmVWZic0VJWmpENGpy?=
 =?utf-8?B?Z1B0WHh5SXE4NmlMckprN3Y4WmJQV2hISWtWZjBVMHphYi9ZdUdlOEtweDZF?=
 =?utf-8?B?dmlvNmN1WXlNSmZ3ZW45eitFRkZIdVpPMzFZd3EweVdqZ1RUUnpIN28vY3dL?=
 =?utf-8?B?ZmhpUncwb0RZU2pyNGZ1WkFaS2ZWbVJub2xtaDA3U2lXMTV0Ukt2dnpzNDlX?=
 =?utf-8?B?d3VDZDhIcG5tZmpnK0RZbTNITjVzY3BONE1sSDZoQnZ5T1pRVmNnc1hVczFE?=
 =?utf-8?B?S2Y0dGpiZVQxdVZXdVBHelR6aUY4SURuRGd2RVk4N3ZuY1U3ZWVzdTVEcGdF?=
 =?utf-8?B?Ly9INk11aVdBb29QTXBJWmFFbk1zY0xUUktaK0ZWaGRGSlZwZ3NOSk9EeG5m?=
 =?utf-8?B?YkQzRjNKODlKYytYRnhHOEZrOHN3Mm5UVEpZbG1SN08wN1lxc2FqTkw0T0g2?=
 =?utf-8?B?cVFFMVg0UjdaL2ZFNUlQNE1RN3loSWNCM3FrNUFtaHhvdlNEcTVXUGQzQ2Nz?=
 =?utf-8?B?NnZWOTRQSXcxdXIwLzk0b3h3SXNKWlZpR0J5T3BBRXlLQWRFZEFhbFMzcnJi?=
 =?utf-8?B?THExaStVTnJVaXk1anYvZGZRV3djdm9HeSt5RFFQZFB2eWRxc0FyeXpWR3lo?=
 =?utf-8?B?bFlRUWNDc28yTXpUcmx2YXBNVzFINFFqN1lWRzExdWFzUkVVNjFoVnlGc3Qz?=
 =?utf-8?B?SFlxRjFQZE1xV3RwQXZiWkdnck01Um04bmRpaHFGcXAzbTJ5QkR0cDdqY2hx?=
 =?utf-8?B?ZFlZU3JvY3p0ZmxEa1ZCSld6bVNvYVo0REltVnU3cjk1ZnZjVnpSektaSU45?=
 =?utf-8?Q?cgY6XFBydztNZDNBMXmxQFbDo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff544bf-f904-4446-e4a6-08dae2b42928
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 18:01:04.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECQebwTwem8yi8zEb78tS/qFjngx1odL27cQShWRiEvkWaC83TtW+oBxTFoH0PtY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 12/20/22 11:32, Reinette Chatre wrote:
> Hi Babu,
>
> On 12/19/2022 11:50 AM, Moger, Babu wrote:
>> Forgot about this.  This snippet is going to change. I have tested and works fine.
>> How about this?
>>
>>         /*
>>          * Update MSR_IA32_EVT_CFG_BASE MSR on one of the CPUs in the
>>          * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
>>          * are scoped at the domain level. Writing any of these MSRs
>>          * on one CPU is supposed to be observed by all CPUs in the domain.
>>          */
>>         smp_call_function_any(&d->cpu_mask, mon_event_config_write, &mon_info, 1);
>>
>>
> It looks good but please drop the "supposed to be". If there is any uncertainty
> then the data should be written to all CPUs, if not then that uncertain text should
> be dropped.

There is no uncertainty. I will drop "supposed to be".

Thanks

Babu

