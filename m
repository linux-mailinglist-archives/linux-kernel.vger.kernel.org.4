Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B765259E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiLTRdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiLTRdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:33:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EDC1AA01;
        Tue, 20 Dec 2022 09:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671557590; x=1703093590;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iDcnwBY/TSiCHuWfnsxR34lbi0Mczir51/FF6X2mfik=;
  b=IUQoUAqVCQMlzTIwfKnKDb5Ni59BlwmviWUiw8uvfR6N/K87i4LFQVJ5
   cKBNoHJYI0IPN7tPnFRflgDy8XOEgtCIIOXHufVcbQ/aYewh4u2zy51wB
   1kLbL61naJdbhJfitd1xQ+m7wqws+rjWqj/SEq5eEAdv5/tYnOsINVWJw
   SPKGK8+0Ziw2HTNNtrgI3CyIzmgNvYMEn0cuMd3H0BCzhZXRbgwscjkGT
   5evkjDOXM3Q5Eo21nNRbplDEG2N2QmmNNXvKXM7xrEAIMDrxzRxQPrx/z
   L3Rhe6wTKdnhRHvCrmTblDqqNCPhV4v5AX84r7iZj9ukGROV+atpU3mWD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="346782913"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="346782913"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 09:33:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="681743373"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="681743373"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 20 Dec 2022 09:33:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 09:33:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 09:33:08 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 09:33:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSRHYjiowjT+ranN/QmwluAhglkymTFg7oVfbESwmkidc8L9AIny5ffEpjrQTDr9OQnsNyDoGb90ZGPTFqDPdYjPVz+pC7vi96iduKDYA9SRdT/t7+NSFei8wQsBX1/vhCN1MBF3LAmJO7ewlZrYCUcYUz50giMFy8bNC7qTgxgx02FpReCSfcJflRt7+UVZNg3LXM07Bmur8OManMft4C6ptJ3NCk0vMj+EEhGbvg5gqOjqEr/WFJmkz+pteHzOSsRRYfrfEPSwESQsCL1IYRbZCGdbWysaFdHEqA6gN52uR3LqWXdEiAvydn9Ukg0X415/rT+7GpBPeNV8Une86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuWrcFn49z9AszlaRBTeSnk9hBMxfMLHJZgIBlaASPk=;
 b=npyFrkaCEvslGv9EYYveNbQXPedU3fQbF++PuN7QRxkxnibqMxLnSGx570l0X8QiNA+NuvUU3KAfMTpT4HdaowrZRhx4mD6vtVcmf9/bmMzKKxMsBYQvXrmDgeqq4EWpr2AVOD9BJjJFTckOCg2sjMTKoUgi9YzgRGsbvsLPUwIWfhhygcEWRgy2TwSJiO5+Jp1DVNex4yWD44zEjtcXICVWc7wettVJZFBmWKgvousDSacwNaNYomNeoVtoeknt94J9WvadGfTw/YOdZlqyuKvtxb2ode+ITuRlSs63hyh4aT8KDlDCPLE/6G3Qr1TUm2F1HOvp/5FJbtOz43wBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SN7PR11MB6774.namprd11.prod.outlook.com (2603:10b6:806:265::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 17:33:03 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 17:33:03 +0000
Message-ID: <e7452b29-8e9e-a3e2-a870-2c251e48507d@intel.com>
Date:   Tue, 20 Dec 2022 09:32:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
Content-Language: en-US
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
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
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <MW3PR12MB455337B3EFAE3A0E37D042AF95E59@MW3PR12MB4553.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0166.namprd05.prod.outlook.com
 (2603:10b6:a03:339::21) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SN7PR11MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 12efa138-9419-47be-9006-08dae2b03f4d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YopwBd4bMnNlSI+H5houZfRnaJdbooZ1Rb3iiPU87ZRH2LpiV4LQkgrf7qDVGYCiTVBoO1GD6ggNV/x8dZIVUz/e3s8hlR3AnoDJ7IswzqV0zd4/fyr5/doQC5tFUOdTrUcQuJAGb2XvtQvigTI334aVC6+mBk/ezhDumOst449d1EgVoUAw4uN83HRL85yWkgaHpeKxtHsQ0p/s0f6N5CbVNlTd/jPH+DPgT+r0wNxDVDJL87Cop1QCMyU/qnBhVKeru05j91e6tevo9RSA7I6ut+k1oOnzX9rzSpHlgBgRly9WQhoY93ot+xyvXzLM3Iy7pPXoyUpYvBaDSrE+iwtegoru7yBhOjVvhPZwqxTEaD5mLCeXWejxn0jFfkNP35HgaJWOEywcPUOoPFt3itj+HhZXeRdKRJdNJIupxJ87SGUL+gwEdZc77ZYLewaRSQAAamBALukd3Uv9g5GN/jaQ8yWYpYhDCThcpvlI47peXUct8ehg3mOaKoOw8pPBpgPnlV06DxYW7LOHYp1YLy5zeQ+o8pWIifC3OvapkN9/5dDJI8nrS8BunQUHe+FjldoaWzzfYf0Su1jFzeNx9T2U2MqoZWp5HopvJh5j6aTHiH81Tl9066k/WYaTTE//uU15aOuda44nqZaBF/Av57QFMZ/WockB/Ld2nSn+bs4dQvQKRiZdKcyevi5C5zDlKyB4H6oWc5yA0ruAP2Vo0jl13sUfsyu1tnFbvLTbsfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(36756003)(44832011)(110136005)(4744005)(2906002)(54906003)(316002)(2616005)(83380400001)(86362001)(478600001)(6512007)(26005)(6486002)(38100700002)(31696002)(82960400001)(6666004)(186003)(8676002)(53546011)(5660300002)(66476007)(41300700001)(31686004)(66556008)(4326008)(8936002)(6506007)(7406005)(7416002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXBTZy8yNkQ3cDREN0Y1NStXVzJ1RHBRd1c4RGVLUWtlbDMxWHBmZlJyQklS?=
 =?utf-8?B?VVVsNm8vblFYWUNlbnVhUFFiY2tzN3RlUkh6Z0ZaM01LUmdBT1UwVUhQVlpG?=
 =?utf-8?B?SjhSNHpNVVVaVXQvaEhCMkFzRFg3eUVmQlRvYmcydzhMaDd2WHlDY1BseHRR?=
 =?utf-8?B?ajQwNUVkd0lvaHB5Y0tCZTlIVXM3S216c05EdThnaFB3MlpvNGVGY3FkNWlO?=
 =?utf-8?B?Sko4QVF4M2xaajNKK3QzeUVubWFyN2hFQW1SaGdPU0dQWTQyY2ZrYXdGZ1d4?=
 =?utf-8?B?N3BISVZkOEFxVHFRdW1UTm5zL0ozS1ltc0s4V29mbVVhcDJoWFVpbWlqdUVE?=
 =?utf-8?B?ZmNaQUJObk83WFpJV25HaC9GVFRWQytzamYrb3Iya3NaZ3ZmeU1pMVlrcFJ1?=
 =?utf-8?B?eHJvNjBVN2F3UTRub0RaWmFhd3JwditJRXVUNUJvVmhLWEk3MmdhV1U4M2ht?=
 =?utf-8?B?ZmdOaVN2RkpiVWo5ZzFjd1ZhbDMxRnV0MDVBdkhudisvZkZ1ZWV0SFBqWFJr?=
 =?utf-8?B?ci9DcUFIWTJPbSs0RkZ2M2VsWEUvUkV6K0V5bXlRb20rMHY2R0ZVVk11cXpt?=
 =?utf-8?B?VHJ2bGJ3eFo5NkNGRURIN0RDZWdva3BRRVlueFBYWHM0MFI1R2hQYTl4dVlI?=
 =?utf-8?B?cXh4NVRKWW5sSXdNQUlSYTNrSjJwS1Q1MHRKdEdKcVNIVk80UlU5cHR2eHk2?=
 =?utf-8?B?K2RkekhKV1pXc20rVkNKQjB1SUxKc0tUc3ZmOTkyV3FFRHpCYlVteWIxMk41?=
 =?utf-8?B?cVBFZTFVN0tvVll3NEdDY2gyTkxPb1E3SnFtVTBVcFUwV29ablpsUUd1OURl?=
 =?utf-8?B?a0tpRFdGYWVPWW9HMGVyQ1lHd3p2Y1hLNkZCVjZwZGtHNmlqRlNVMnpreUc5?=
 =?utf-8?B?UzhEU3hhYk5jWHlDSE9ZWFE1YTlHckRpbXBaOTIxdjZrR1NVV2pqQnQrZE8x?=
 =?utf-8?B?Y2dyN2RwN1JOdWZNeVh2SHljWWNTOGJjYWNKd1hTRG1Ia09jQ056b2JRcmhP?=
 =?utf-8?B?ZGRBWHd4NVUzWThLZ082MnBtdHlHZEpPWVBwc2haSVFCMzNaTmd1eXZxM3lJ?=
 =?utf-8?B?a0ZvODZheUIrMTNoVFpUUkVZclFzcDJocUJjUWVxNVhMemZYZ2M4Z053T09v?=
 =?utf-8?B?clJ4aUFSTTVMK3lRWmxNc3h2Zm55THR1MzJ6eGkyMWRmcjZCUVMyUEV1OG14?=
 =?utf-8?B?SzV2Sm9oRm5US0duNGZWT0J1NXRTUXYxLy9IOWFjbjhaZkMwd3hEblYvelQ1?=
 =?utf-8?B?YmMya2V3RTEvbkNJRzlyeHNDKytIRlJCak9tdFFwM1BoMTZOMURiN21Jbk9X?=
 =?utf-8?B?bHFTVGoybEJqWXBqalFsa2pjTUhWYVdUVDR5WDFqMTJiVy9hYzNpeDQvQkZq?=
 =?utf-8?B?enNuZWVpZEVFcjYxNGlUekhBdFladGltUUo4NUpJWEx2ZUdYRFB5ZjBoTjJj?=
 =?utf-8?B?UWIxMkJMYzJKM2tScEd3VGRRRi9OU20vbklnLyttKzYzK2pudU5scDF3RXhZ?=
 =?utf-8?B?aHFOcUxVNnVnd290NU1NdzV2YU1ndEp4MXlIUDB4c3ByY0hBQU1jbzdyRUsz?=
 =?utf-8?B?QmJmalhjZ2FhUGtiOTZPK0pkYzdHdjhGRlJYT3hxUURUeDd3NUk1N2xaRVl5?=
 =?utf-8?B?VWJWVkdCdDBGdHNGZ2phQ1N1eTUxNmdzT3pVbEhndVk3dG5HU3FiOVhoMEJn?=
 =?utf-8?B?YTVqaTZHRkd2aC90UkpSclp2dDh1WFdiTEJpR1hMQzhrbW1JWkdKdVJ5T1cz?=
 =?utf-8?B?ZEJ5WmliMmZZbEdMZk16L0VGa1dDZFc1MVBTQmJHMmswWmRjUkk0b1EwMm04?=
 =?utf-8?B?NTRRb2VZa0hWNWdlOVhzT3Y5TmRXd2hOcVNmWEtqYk1KNWhkU2lnOG96SVFF?=
 =?utf-8?B?TW44RDgzSWtBQkRLVFRxRzIrOCtyRjkxYW40Und3cEhsRDBTTGFVS0J4OVpI?=
 =?utf-8?B?UERnRTRFVWhqbFg1dFpnMTVOSnowdzgxRzdsVEtKQzZnQTd3WWJtdzVpWGVF?=
 =?utf-8?B?bFNpcGF4U2RUS281dDJ5TStVZWx1QkNITXBNWGtNa09BK1J0VTcrcGpGLzVL?=
 =?utf-8?B?UmhJdllKMkFRQXdGUWFLTnhpRHRKNHo3SFhlbmJIUG1aOXJuR2JUTkd0YmF1?=
 =?utf-8?B?aU9nakE5Um1UYzZrWVdaRTNQQVp0ZmpaU0JLTzVpajkxNzZQMmtFUnVacTIr?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12efa138-9419-47be-9006-08dae2b03f4d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 17:33:03.3015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYS4jZRU+BMa5v8B04YkdawFMVnNv3XaND4u9scptCO38XxwS8k1IT1fIYRivEVq9DPucMoGFkTdfzmE2E+Spw99Qhyv68Tn1f3+SVvIGJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6774
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/19/2022 11:50 AM, Moger, Babu wrote:
> 
> Forgot about this.  This snippet is going to change. I have tested and works fine.
> How about this?
> 
>         /*
>          * Update MSR_IA32_EVT_CFG_BASE MSR on one of the CPUs in the
>          * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
>          * are scoped at the domain level. Writing any of these MSRs
>          * on one CPU is supposed to be observed by all CPUs in the domain.
>          */
>         smp_call_function_any(&d->cpu_mask, mon_event_config_write, &mon_info, 1);
> 
> 

It looks good but please drop the "supposed to be". If there is any uncertainty
then the data should be written to all CPUs, if not then that uncertain text should
be dropped.

Reinette


