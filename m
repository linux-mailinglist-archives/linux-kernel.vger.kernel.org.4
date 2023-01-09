Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F54663582
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbjAIXnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbjAIXn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:43:29 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175F2120BB;
        Mon,  9 Jan 2023 15:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673307808; x=1704843808;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EG2QqFMy49sa+8D37aavlwILsm6Alvf+LIkqatL1yto=;
  b=AktfYrWtmCC5s7Ks69YXzW+q9IrC5DvqbfXo9oQ42saubYp0XciDbX0E
   3+2qnZwd4y3onk3FkWxxdTkvQ8BjpjtTki0c5IlaOSRLKbHXjoV/5Rlxr
   P3MMKNYR/23XlEkQkK0/sif3NBoYRt5ydPuoO2KvmFPzyCHvV4PYAev/b
   TFyL2TI+fO/IPS7STu6I1b1uuXEZOMW2VLbPR3BZBl80asFfgsOnh7WbI
   qG3UcnlNbR//I1VbNNnGERfz0XrWIOxngdkPPGATsa2TIwz8iI778UPSk
   PVeM4CvCbA7RZVNzXRP5aIJ3tDiojnf29k6hA5mMh3ljbiUY38VpGMlBl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="321712664"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="321712664"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 15:43:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="689218690"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="689218690"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 09 Jan 2023 15:43:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 15:43:24 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 15:43:24 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 15:43:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA4JDEjFNSYd8QHx8DbPsdsKV5jsOMTSCf6sOl7bltTJE0RtySDumNBFi8F+AvN6V7Njf9HEK8L14+F9kKhtY2a0DyHW+bLLL+fK8peoSTBr+4qz9pPkRo+ZQn2cnCvC2fhRmCp949lG5hp6RJeNlnkwge2OF9UWVtVqrbgvKgahfarQt1nltsIzBAYV4SesmAPPHaEszFCo9dtG7tzT5kFWl9F2hq7agE3t7W4U3aLRPCG2Gro/M3AuyQQRbEcnyZazHuRvx/YfpEfbxxdU+pW2KcJYceNbbL6fi5GR3QIr/xeAa2LXTFAwTwzEZSIFHZIMRff/hcytfj16i8KXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqJEXF35JXwQT+RgOlEijcTkkGLAA2HyDhlPsgm1j+0=;
 b=m8OkfQA4jHy1H8IP9WLgpn7jnKlepM2pBzy/itSaiDqUBB2PQ9aQlDQ4cbY8U8VJscDiLv+7za2Ceolmz+ZNLcxsA4C10YO7kjtRRfxWaOHZyo3ElGZWwWGJsZ2ijBAfzrfyFU81XttBVIP+WllbeHEtv0trihUikBshF55Qq1qK/lRXcnN9W4n2K05TgUARpO/7F3N0jHNGycXXGGeynQjoDSPLtK0R8G1AV/RQ/4Wr95qRHCxL8Jj9Dl3rkbaR8/yUbHAYE0Cob6UKoJ3OQBuQLhtRbXiBKxARy7QF28sQID6kG9jCfl1RD3LkaDbA8Sy8ZK+mkkQWdrWGYId4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SN7PR11MB7019.namprd11.prod.outlook.com (2603:10b6:806:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 9 Jan
 2023 23:43:16 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 23:43:16 +0000
Message-ID: <7d752c17-1293-ea3d-505f-046dce87c2bc@intel.com>
Date:   Mon, 9 Jan 2023 15:43:11 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC:     "Moger, Babu" <babu.moger@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
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
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-5-babu.moger@amd.com> <Y7xjxUj+KnOEJssZ@zn.tnic>
 <5afd0a7c-3fbe-dfea-f1b4-2fc35fbb4f13@amd.com> <Y7yCCNANVBnOOmxM@zn.tnic>
 <SJ1PR11MB608321F26D729A082BFC6FAEFCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y7yJq2lV262EPCQT@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Y7yJq2lV262EPCQT@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::18) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SN7PR11MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c995e6f-3116-440e-b614-08daf29b47a0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9oADikZL4NOTJ5dQDL5Ek/lVedjI+FQmgpQkTr/SAJWaWaWAeFjT9XFbun1Ly1RM7ngdlWU1W9LfGCpCLiPrwJ5kff9l+x2LSi/yd241Kpw6HIaoG0WUrMnAdivnvUwebVG7kSC0zpc7NCRSb76HmzEheks3SSOU9XuDgp4a0iAyAt1Z01XivUnTdmvqsp4MmL8TFuaehrFjbGC1FJ6ySDSRf28NZZoZdMIowQnXZLtFFvCNTHG9Qby1JW73XWFr6lBU348o9zws9my2gZjWqI7yBTpAZpzqoXLYMcYFMyatiAXkTVI9JJe+BeAMjKYeGJyzEh53F38UYzq20sz/Wqc6IVwzTCqmbIN/9hqaYr83Nis2huEU2EVvn/oMLVA373mN5NikINUXnRV8Lqb/jCruccj7ibvs83ffj+Rpmsx4NnT4RsuOKb9T+0rKcVEIIxSbocF2/nKPXD0+jqfpxS4OPjdyBbDURTdYmk8NrBWLfRTRMAA+oV12K2f6m7IlPD0pWmWgQVEQ3dV/1+8CLGoRUA+2DPP1E4XTdFGc9Jj0gjuS/zLeUqaLPvLZWICJuSatFc1Ux8tnLQRIS1LkNMGYDSxXapQwuF5vtjBeW/tnIrv7JsxIyK/WV7RAL7XFdHK4S6FHmNh6w0G486Y1atveVFR4lCfz1Y1V4b9ce79Lz7/9fyyo7YloHg0bqUpiMZ5dBjLsXfZvJv5G7r6ikYYBk+uLly6+ibiTs6IAkkNuK2M3IzRoRZKexv/AxvWENTB8WLCJjCTgu/sTGRor/EV9c7uZQbSdlB6RraJNHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199015)(5660300002)(7416002)(2906002)(4326008)(7406005)(8936002)(44832011)(31686004)(6636002)(41300700001)(316002)(66476007)(478600001)(66556008)(54906003)(66946007)(110136005)(6486002)(8676002)(966005)(53546011)(6512007)(6506007)(6666004)(186003)(36756003)(26005)(2616005)(86362001)(38100700002)(82960400001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTlrQndRNHNtbGdocERTUUpNVk1mNmZPa0E2cUtFemZ3TjdUdDBrUlJkRk5t?=
 =?utf-8?B?U09xVGYyYnZORCtLTTgvbzJ2VXZMS05QVXpOQmhPNjRFR251eHJpMCsydDZo?=
 =?utf-8?B?bE04UnVGVEgyS2Izb2cwamdkVm5Cd3ZZbEFMR2FZN204WURFUDB1ZGE4MGdt?=
 =?utf-8?B?UVVrQWdwaGlwV0J2Z0R0QXRlemZYSkVaWUhtRkQ2NERNdk1kQ1g5WnNkenYy?=
 =?utf-8?B?NmtsRWlKZWIxbnk3UDV2Z2FRR3QxSUIyMFVROGlwUzJZZmVqVHN4Z3dibmVl?=
 =?utf-8?B?MnJqeHpSWHNzb1dOc1NBVkVPUHpRck5rMnQ4eE9WaktTS3dqTFRDUXBNNTVJ?=
 =?utf-8?B?akVNOVp5clVRZWRpUXVTWUM4YkgwODJDRkJSMitWWjNlMnE3Zjd4aFI0V3dx?=
 =?utf-8?B?cVJmcnhPem84eWNTdFVSSmpQam0xZkJib1drYWEwVFVoTm1idDNGK3V2OWRm?=
 =?utf-8?B?aDVtVm1JSHliOWFsemIyZjB6bnZ2MEFKWmlYTzJDZ1huRE04S0ZxbHlaTk9z?=
 =?utf-8?B?YnJsQmorZ3R4WlVoam14VkdPWExoTnBIK0dNN1c0cGs1WUZRTmZaTTFLb3kw?=
 =?utf-8?B?YVRXeVgwdFJaLy96VWs3QTB1eFNGOTdHZzNFNXBZT05sbElaTnFVWC8yeEF4?=
 =?utf-8?B?aE9mUkxuZk5NV3ZoWDBwaTN2alk0TGdZMjFjcUtRSlM2TklSYUNHU3RCTk9F?=
 =?utf-8?B?dkJlTFhWc3ltWi94REpmb0VqSnBVUlZnRi9KMG5oZW1ZbThsYzFidVJ4LzF1?=
 =?utf-8?B?aHBrd3hpU1c4UHdVMUdKbEJJTkVqejdTYUZGNmVyaVZGL3NoWU85V3lTbk1I?=
 =?utf-8?B?dVVLQ0RLOGV2OWNnSnVlcTVYZjBWTjJ6SVlVd1hCci9IWm9Qa2FKK3VBSzMy?=
 =?utf-8?B?WEFJL0RzcUNMN1Z4QzBOb1ZMVmNxVjRsV1hvUzRwNU5HNXlBR3N2V3hsclhW?=
 =?utf-8?B?ei81VEtaS2cvNXlUOTE5b2NhSXVhYUhBNFJYcmxlUGM4OHJvbjVLYjNjOWJ5?=
 =?utf-8?B?bm9WaHk1ZUpKcGRnUmQveGFjajhWM3htR3pvOERuMUxwSXhMN3JiTUFWQ1k2?=
 =?utf-8?B?Y0VqaklFbDE1YXoyM2tPL0lwdk03cVViaVg0SFdPOE56SnVZSkd3ZTBiaXBE?=
 =?utf-8?B?VS9kYXFlUXZFZ0F0TVZvSUFLT2lqcjF2dlljaVJWbm13VXhIQWNzTUdIMVNE?=
 =?utf-8?B?YlpDUVc3ZStHTFlHNUM4bGJWbmRGQjJKUjkrZFljcFlxb1gva0ZFRDJJaWpR?=
 =?utf-8?B?b0dwV05OcFRoYzFzcDlYTkd3dlhUbWdJU0xFV3ZtNElqZUJxY21GRk1CQ01j?=
 =?utf-8?B?dmV6dDh4UGNPRU1nWitHT2U3Y1l1aGFMUjNQdGFVTTJJUW1IMVQ4WklqM2Rn?=
 =?utf-8?B?YWZtTWEyeE1GeTdNOXcyLzY5enVKNFp5cmlCb21wL0R4TUd1R3pDTEEzVW84?=
 =?utf-8?B?NEhyZUVHWnRESERldWxlaVFuc2lwdDhPZVh5UWx3R3YzTFZKZ2hFK0xKY3Jr?=
 =?utf-8?B?T2Uva3ZxNjBSV21PWVo2Mzg0VlZma1U3N1NmdVdRNlMwN0VUVHdPRG5oVytt?=
 =?utf-8?B?N3luWEVDQ1dUT1VVdkk3QW9xYXA5YnFzYllORDE1N0pNMXUyNU16OHAwdkFn?=
 =?utf-8?B?dWx0NHA5bCs5SE5PeVFtbXRyK1BhK2FlMnVPWUtwUXQ3b2tuSzllVzBwL2pI?=
 =?utf-8?B?MXhDQTVKbzFCc255eUxENTI1ZmtXeW5vYkg1Wjhyc0NGdW5JcnZ5Wk5FbXRF?=
 =?utf-8?B?cHhDVE5hb25XKzV1ZW1hM3VJQ1RabXh4aGY0NlBlVmJXMWpUaHlqRUk0VFk4?=
 =?utf-8?B?TVRhMGhOcmd4UFIydEdGUHMzVHdialQwOXloa0k0TVpSKzdiQjlqYXVZNCtY?=
 =?utf-8?B?VWZpZFExU0JocVEzRDNQY2lKK0YzcVJIaXVTVHdIbW1zUTl5dldOLzFDMlll?=
 =?utf-8?B?YUo1RGZiRWszdWlOZjNCWnFoRzBHMGZBN3A4cmtyZ0ErcVFhNWplMm5uRTZa?=
 =?utf-8?B?eTdIdTB1YUtvbWVVSndxNEN5cEp0VzcvS0VQSTFnQW1IUjdWWEJhZDNla0lu?=
 =?utf-8?B?M3hGSmVGSVIzRU9LRlBZRmZpdk1YOHpvWkliSmtSZVlwNitSSVpmaWtKOEd2?=
 =?utf-8?B?UFJCQVF0TVJ0M0xkSm9VU0dPaFZHSnJxWkJvZmZVZnRxbFJ1cjMyWUtVc2Vu?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c995e6f-3116-440e-b614-08daf29b47a0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 23:43:16.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6XT0Wx+/0k9qm+1HK45xt5voiRpAqhrXBdgh8TPfkfyx/JNa+seZqGGcYifgvNVVvFQ1GkmTEyWlcOD2Kqn/uIfTmKHanBXHsKKusO58Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7019
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris and Tony,

On 1/9/2023 1:39 PM, Borislav Petkov wrote:
> On Mon, Jan 09, 2023 at 09:25:32PM +0000, Luck, Tony wrote:
>> It feels like the old "rule" was "make it visible in /proc/cpuid" unless there was some
>> good reason NOT to do it.  But that has resulted in the "flags" line getting ridiculously
>> long and hard for humans to read (141 fields with 926 bytes on my Skylake,
>> more on more modern CPUs).
> 
> Yap, imagine every possible CPUID bit were in there...
> 
>> I don't know if we'd break anything if we dropped:
>>
>>   cat_l3 cdp_l3 mba cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local
>>
>> from /proc/cpuinfo.
> 
> I wouldn't mind if we remove them from cpuinfo, frankly.

I am afraid that I am not aware of all the resctrl user space apps and
tools being used.

I did take a quick look at intel-cmt-cat that has an active user base and
from what I can tell it uses /proc/cpuinfo to learn some capabilities:

Example of looking for "cqm" (although "cqm" is not in Tony's list):
https://github.com/intel/intel-cmt-cat/blob/master/lib/os_cap.c#L420

Example of looking for "cdp_l3":
https://github.com/intel/intel-cmt-cat/blob/master/lib/os_cap.c#L520

Example of looking for "cdp_l2":
https://github.com/intel/intel-cmt-cat/blob/master/lib/os_cap.c#L564

> 
>> Perhaps the "rule" should be written in Documentation/{somewhere}?
> 
> This started documenting it:
> 
> Documentation/x86/cpuinfo.rst
> 

We could make a rule that no more resctrl related features are added to
cpuinfo but I am hesitant to remove the ones that are already there. 

Reinette
