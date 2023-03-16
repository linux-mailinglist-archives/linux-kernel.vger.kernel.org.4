Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3808E6BD6CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCPRNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPRNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:13:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF961A499;
        Thu, 16 Mar 2023 10:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678986799; x=1710522799;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y8G7GKOptfXXqUw7WAgtD/COjObQK2lqSaiXm6rV1gQ=;
  b=AA3DA+F6J89jYPHoay3vTKhd4qWI0P0oCbwiXih8FiznMYuh1/B7lG3M
   2F/wLoQO9XHvfB/VficJDHnwcbk5y+49D/B6PR9Cvs93LDHyzz/9Kc7vK
   lor48bjb+8RmAN9CshF/hA07cMWCwArzN67a9DZMZgGWIFW7euwpQkpVM
   y7x2o86hZ3lIexL6o2jJG2Z0iq5dJTdH3+9oGc1aL1CAHOEtC/VwjDn1g
   aKUncwKlRtZH5T3fWUrxSRRvq5vckE1BcCyzCWyQhXyUOr185esbnudB5
   8NDsis0PUYJqVzksk59NYFu2WGC2YQ/pPtXHpIp2zb54tGlp8asqeK5zu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="317710950"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="317710950"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 10:13:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="682379979"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="682379979"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 16 Mar 2023 10:12:59 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 10:12:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 10:12:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 10:12:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COeVgEodxgu1lMl2rARIZs/fHK+2ZsdjCYQrCzshJ+SYOPSQ12beFe8N3+rIzeiGMFPKqLZBcnuRaKClkkn2Xtnm+bfpXRWNWxcGpnwDuD5dzNJKcb1Mcg+93Dm0M2egxY/mKux+r46Cm33+cdygQ6E0p4TJCpqgQjhh8OSUCpbLupuQ7gb2E6qiGV9Qja1YeIU0FaLZuAwFEv5eHy5PJZZ7cebAAIgo2zgt/kz5dN17T5Nqil/ocqJ9ldgzPSb7BoCBHAPpmStyLbyNHBnypaMlU0RY3LnQ2Sx/rFkcCgqJ1jtFi+2d/lQpgct0GyXivwFuFlcBI7eoYnyigPUT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcY7FPVzl8r5c0acyOGdY8/Sfr41n/uY8zMYnlv8Thw=;
 b=kdUbQKy8Gla29386V0uw043H5IypFgtHWzOSK1jootndSGuSvOuasrcg5EB9HXZR5N8ZKXSXqeLghEYB0GXzrtjSvhvOeeRfi0OLPcCb5hyw6x/UjcQD5vV54/5R14iWpTwB+TsQG4nYKRHY3CRrDo3fv7YdeIYeoX0J4bOMFdM820cX8xDBxMt6E67MwZILTq9Im6ROEE7fASAQpbuluz0vyNTPtsOy2DwTnMNtgVkunRv9eucs20voAPPE79E2IH46Pv3CIWNDNWu5zn1hzqc1I5vfYJTpcA28AxQ0RkhpgDOd97bQ+Z1X0Sxi945u2DrYKtgQKhRwuJLNijf7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB7998.namprd11.prod.outlook.com (2603:10b6:8:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 17:12:51 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 17:12:51 +0000
Message-ID: <71b58853-e7c9-b522-3f90-c3d84cba1317@intel.com>
Date:   Thu, 16 Mar 2023 10:12:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
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
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778866506.1053859.2329229096484796501.stgit@bmoger-ubuntu>
 <9af9eb7a-476c-d4b0-e114-3f5c2b45dd95@intel.com>
 <MW3PR12MB45537DC45130BB5F02F0F3F095BC9@MW3PR12MB4553.namprd12.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <MW3PR12MB45537DC45130BB5F02F0F3F095BC9@MW3PR12MB4553.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::14) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afdb649-acc0-4013-0272-08db2641ac55
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtDQH62VqOFg91lvV+UGlhWKww1ZtjIn0dQUttEGPhsrYhQPVByouugd7Rtnjy8qyoadDbLgGBnebWNkPaDsGV1edF6Oma0jsVurWLLXpfL4lp4AgEF4eRaS6Q/Jh+XHK8uZJbQgdicR/NmyIToMPWhW5oD8nmia5MfrZ0edbBVEbvdYrhmVEAo8yLXBalOGfZXgkbkuvq2jtE9dQdJRElN41WaWOMFn0oRN9/HVY71g1xbtkmCFJ+QPilnnSNYHD7GuGXtoEsu/mfgVrrKRxpK4mQfiPUM1i/jdkYGJK4PvT1N79VrpiS0kpEXUvmpW7U1c2pV90eRzXbdosJzN4AVvOvnuYr+yUTnp/jMuAbZjMdcMV9QYFWaefSxMYqG2EgYqktvbuAJpD34AlJ+l1Jfxc4V6npaPMNWTo0u3eK0zMtcV8mVP+5mYLQthERJ5v8CyMRcfYJsvab7TF5jpEKgxe/gJCAKnASyxAGBJBBuJidLrsqfFc+BLXOgvkegfJ2xmU1hkauWY91rAGH/IbzoXwlS8qDQ7NZVsmccwgOBGy5uzvgx5kQfVxEL1UnOICGVXJSKpXKH/mCoClsFnUhJpaqCwapnnxz3pSlFLL3JiX9ecwyp2ADQN2MfjvYdRzDuRFhg//lgIFpmBdIoKLZRi9/G5qvOVA3ZGP9Pg5kP20SX1Jgg6Kpq+cNpo0OQPflIyuQzmPk7CB4Cun4xv3/sd2Re4pNYrhBt5p87QJt4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199018)(31686004)(66899018)(110136005)(8936002)(36756003)(316002)(66476007)(66946007)(8676002)(7416002)(5660300002)(44832011)(478600001)(7406005)(2906002)(54906003)(41300700001)(86362001)(31696002)(66556008)(4326008)(6512007)(6486002)(2616005)(6666004)(26005)(53546011)(6506007)(82960400001)(186003)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnplZVF0b2pNS3QvdkNIY0pEbGdGYTRwcEcwUGdjQ3RjY090eHB4VGk5V1Nr?=
 =?utf-8?B?aHJqN1o0dDhlY3NLSFFoQS8vYkxza0lmeWVuQjNxWFJzYTh1a1RHNDV1eTVx?=
 =?utf-8?B?SEtXeHhiVnRNYjRuNjhKWitPOG02Wk8zdEZSMVpsT1lXaHlOQlFDaGRnbldn?=
 =?utf-8?B?R2dxMitXTWdtRndEbUNWVC96V3FFUEhsUXdhU2o2bGtkbHhucWJMeW5EVDNQ?=
 =?utf-8?B?NEhnWlplUUpid090WFB0L0cwMzRSL1NaNm1wZDZhUG1PcEV0cG40czBmOWJo?=
 =?utf-8?B?dncwU1dRaW91aEtBb3NMbjU3VGU3MEtHVmRZd2VVQWY5Uld5NWtrZ2w5WGJE?=
 =?utf-8?B?MXFZUmpjRE5ZNThKbXR2WVpuUERXZWJ5aDJCeERsZzVCK2xjM3pyUjA4N2hR?=
 =?utf-8?B?emsrYXBUUlJKR0E4TFBaRy85V3pXNVU1MmlFQUZ4ZmJrM1IzaDdvY3licDcr?=
 =?utf-8?B?cWxmOE42QzgwbnUwNVFZL1p2dGpIOE1NY1BOeThuTG5rRkU2amVBNCt5NVRP?=
 =?utf-8?B?eGJSK2hyV20wZFR6cTUvaTc3Z3hJQUFsZXpVOVpJY0E1MVQxcUxKNU1rQTUw?=
 =?utf-8?B?WDVsb2JFdC9NbC9kU3pBaXozcmp0dHlhZ0ZmU3pqRXR5OUdlNm9SbWdlTUZ1?=
 =?utf-8?B?NkJiOEFudW1yZkhnd0xxZlA4UUxtSlJ6OWN1M2VFSEpiMTQ0c1g3WmdpdE9M?=
 =?utf-8?B?dExoZERrYmc0eStTbGZySmNXbVlMYnN4MGVPK1hvenRxcTZzR3kxRXR0UkRR?=
 =?utf-8?B?d202bkRlelhtek9iR3llSkJDclU1dU0xRGlyeFZQTWN3K3BFOUwrdUpjNWJX?=
 =?utf-8?B?YzB6QjlZVUN1YzJZQ1lab0pUM3JoTUJ6bWg2dXRXZE1vY1BNb1RpQnBIRXhD?=
 =?utf-8?B?d1JIdUJWMk1CMThja2JrdjVqU3BWVjVXNUhSNlM0amxkUmIyNzdBSHFrck1Z?=
 =?utf-8?B?M1l6OC81blNBQ1ltMWJYR3BVUzlML2Fwdk1wdnFUOGRiaXdoYjV4bHgxSlZQ?=
 =?utf-8?B?NkJwbVpoSzdnYTN3TWtWQzJkanluVG1Idk1wY2RZNkltVnNuaDBka2ZibUlH?=
 =?utf-8?B?Q0k2NW8zcjc1MUI2UUp0WXBNbjVIcFg3RXJ3L0l2ZE1nZzZXSng1amttL0Vx?=
 =?utf-8?B?R0NwMlpHUE5OaUI1Y1gyaEQzdVhYeEVhclBrUDUySDBOS1A3dnZtTkhScEhF?=
 =?utf-8?B?TkRicHhaVWZNMUVTYUc1cXVoNkgzSVEwSFNzTGRmOFY4N24vNDRpbk1kb3ZT?=
 =?utf-8?B?T2VyZTg3Qk52Q2ZodW84UFA4K3VFUkdERFVwLzl4TFQzbVIzMTZkZ2g5WmVN?=
 =?utf-8?B?aWlVaHdRQUROaGx1MnJJWXpScHh4Nlp6SkhkQTVmVXdrVjFYckxiMC9hS1g3?=
 =?utf-8?B?ZWV6eU1xa25HOTVaY1VwMHpHeUtYcHJmeTRuK2RHelFkRWsyVnhZNUV3dkVP?=
 =?utf-8?B?aFFGUUJlZzJSajh3UzJpTGMwNmxNMlgwTGdPVSs4c0VXTWlXZlB5eFNsZGlF?=
 =?utf-8?B?YVAxQ3N5UERuREJsUVlhVkhZYlZjWDZaeXloa2d0bis5M1NCTmN3aFAzajRZ?=
 =?utf-8?B?RlowS1NCZ0hVSlFzOXpVM1U3ak85Y0Zxbk54MG8zT004UnpTSjZaVld6Y3Rr?=
 =?utf-8?B?b0hsS2ZmRGJSV01Icmxtb2h6REtjMzA2anpyZTBWVW56QlBja05wSzlLdFhk?=
 =?utf-8?B?ZXVuUE1keXpPVjRFUGVGaFlrUjE5MWwzT1hvVTBHOXNaKzRzYXp0KzkraCtF?=
 =?utf-8?B?cFIxOFFySmtJOCtmeFo5YWw4elVoOEZVZlRWYXM0TzZNS3dtb1UwNTFyampM?=
 =?utf-8?B?VXpkZXRpbjVxZTBwdWs1d3VQalBJSWFxeTB4VGk1K3ZqanBEZ3dhTWQwMFlK?=
 =?utf-8?B?Y09hazhuaEZjRDhpNzhjV3R2YUFNbkJnMmRNUll3MmlRNy85dFdpSHZKQjNH?=
 =?utf-8?B?VTFDVXI0Q2U3bkJrZFJPcXV3SHhmOFFQL0M5aHQ3M2tvSlZNRy9zVThrVVpQ?=
 =?utf-8?B?QnRjR09FVzhacE1vR2tMMkZaa3AzZkdOMzkrbXZ2MGpGMm1TVkxZSDBXbEZT?=
 =?utf-8?B?alRTY1pHMFk1Ykh3OThJbUhORlZUS3dFNXFRRmk1ZlNOUWd5aG9sNTJaRmhC?=
 =?utf-8?B?SzZTMUd3NmNuVzFkOUZPb09HTSt3bEwwZlVkR2hjcXNIdEMrOW9KUFZnMXFu?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afdb649-acc0-4013-0272-08db2641ac55
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 17:12:51.1539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhAiW9oMOakdxNQgGhSS+jeeqEvfVjSQyPrMPNyMiixSRv8gC+OS76otHjb5qSl4ixwMUYQEVRqg1yqMwaZsfsErS5wUCc08NtJ0XWD5eAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7998
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 3/16/2023 9:27 AM, Moger, Babu wrote:
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Wednesday, March 15, 2023 1:33 PM
>> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
>> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
>> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
>> quic_neeraju@quicinc.com; rdunlap@infradead.org;
>> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
>> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
>> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
>> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
>> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
>> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
>> peternewman@google.com
>> Subject: Re: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl group
>> at once
>>
>> Hi Babu,
>>
>> On 3/2/2023 12:24 PM, Babu Moger wrote:
>>> The resctrl task assignment for MONITOR or CONTROL group needs to be
>>> done one at a time. For example:
>>>
>>>   $mount -t resctrl resctrl /sys/fs/resctrl/
>>>   $mkdir /sys/fs/resctrl/clos1
>>>   $echo 123 > /sys/fs/resctrl/clos1/tasks
>>>   $echo 456 > /sys/fs/resctrl/clos1/tasks
>>>   $echo 789 > /sys/fs/resctrl/clos1/tasks
>>>
>>> This is not user-friendly when dealing with hundreds of tasks. Also,
>>> there is a syscall overhead for each command executed from user space.
>>
>> To support this change it may also be helpful to add that moving tasks take the
>> mutex so attempting to move tasks in parallel will not achieve a significant
>> performance gain.
> 
> Agree. It may not be significant performance gain.  Will remove this line. 

It does not sound as though you are actually responding to my comment.

>>> --- a/Documentation/x86/resctrl.rst
>>> +++ b/Documentation/x86/resctrl.rst
>>> @@ -292,13 +292,20 @@ All groups contain the following files:
>>>  "tasks":
>>>  	Reading this file shows the list of all tasks that belong to
>>>  	this group. Writing a task id to the file will add a task to the
>>> -	group. If the group is a CTRL_MON group the task is removed from
>>> +	group. Multiple tasks can be assigned together in one command by
>>> +	inputting the tasks separated by commas. Tasks will be assigned
>>
>> How about "tasks separated" -> "task ids separated" or "by inputting the tasks
>> separated by commas" -> "by separating the task ids with commas"
> 
> 
> Will change it to " Multiple tasks can be assigned together in one command by separating the task ids with commas."

I would drop the "together" since it implies that this is
somehow atomic. It will also improve reading by using consistent terminology -
note how the text switches from "add" to "assign". Something like
"Multiple tasks can be added by separating the task ids with commas." I think
using "command" is confusing since what is actually done is writing
text to a file.

...

>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -683,16 +683,34 @@ static ssize_t rdtgroup_tasks_write(struct
>> kernfs_open_file *of,
>>>  				    char *buf, size_t nbytes, loff_t off)  {
>>>  	struct rdtgroup *rdtgrp;
>>> +	char *pid_str;
>>>  	int ret = 0;
>>>  	pid_t pid;
>>>
>>> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>>> +	/* Valid input requires a trailing newline */
>>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>>  		return -EINVAL;
>>
>> The resctrl files should be seen as user space API. With the above change you
>> take an interface that did not require a newline and dictate that it should have
>> a trailing newline. How convinced are you that this does not break any current
>> user space scripts or applications? Why does this feature require a trailing
>> newline?
> 
> I have tested these changes with intel_cmt_cat tool. It didn’t have any problems. 
> We are already doing newline check for few other inputs.

You tested this with the _one_ user space tool that you use. This is not sufficient
to be convincing that this change has no impact. I do not believe that it is a valid
argument that other inputs do a newline check. This input never required a newline
check and it is not clear why this change now requires it. It seems that this is an
unnecessary new requirement that runs the risk of breaking an existing application.

I would like to ask again: How convinced are you that this does not break _any_ current
user space scripts or applications? Why does this feature require a trailing
newline?

> 
>>
>>> +
>>> +	buf[nbytes - 1] = '\0';
>>> +
>>>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>>  	if (!rdtgrp) {
>>>  		rdtgroup_kn_unlock(of->kn);
>>>  		return -ENOENT;
>>>  	}
>>> +
>>> +next:
>>> +	if (!buf || buf[0] == '\0')
>>> +		goto unlock;
>>> +
>>> +	pid_str = strim(strsep(&buf, ","));
>>> +
>>
>> Could lib/cmdline.c:get_option() be useful?
> 
> Yes. We could that also. May not be required for the simple case like this.

Please keep an eye out for how much of it you end up duplicating ....

>>> +		ret = -EINVAL;
>>> +		goto unlock;
>>> +	}
>>> +
>>>  	rdt_last_cmd_clear();
>>>
>>>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED || @@ -703,6
>> +721,10 @@
>>> static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>>>  	}
>>>
>>>  	ret = rdtgroup_move_task(pid, rdtgrp, of);
>>> +	if (ret)
>>> +		goto unlock;
>>> +	else
>>> +		goto next;
>>>
>>
>> The documentation states "The failure details will be logged in
>> resctrl/info/last_cmd_status file." but I do not see how this is happening here.
>> From what I can tell this implementation does not do anything beyond what
>> last_cmd_status already does so any special mention in the docs is not clear to
>> me. The cover letter stated "Added pid in last_cmd_status when applicable." - it
>> sounded as though last_cmd_status would contain the error with the pid that
>> encountered the error but I do not see this happening here.
> 
> You are right we are not doing anything special here. pid failures error was already there.
> I will have to change the text here.

What do you mean with "pid failures error was already there"? From what
I understand your goal is to communicate to the user which pid
encountered the error and I do not see that done. How will user know
which pid encountered a failure?

Reinette
