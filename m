Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721CE74B8CB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGGVqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGGVqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:46:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0BB1FEF;
        Fri,  7 Jul 2023 14:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688766364; x=1720302364;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=46eceIg5MsE/SDQtJ5fH5jx6bZF7s2GAuf/FoJwF7hQ=;
  b=dQNPrCozjkzy8i5I50rIQ3CddpUPOXTA5FRV8a4fhlgKHP9NyP6VZlhV
   hN72tuItexs+J/bbMUENcKiGFzu6gEb+DMcX/J7TysRrOcYDj/UzKfkI4
   qdj2OP0AYmMh9F0CA/GCFG5Q9S51BGIMgRw40v0ykSrYm1GS17riyXse9
   Gtyl40jE/lujAZz/z3VS51wqfOU52cXTP3EupCjSNa9jqksoq0mFCpJ3g
   cjuKqSyIMD53USDky93qd1P73r/7I6RTNKamLmMEPidseSsWehDCZ2OUl
   5IsCRO/8fZy4NjcUT9VcZ3U7iDdBWeDyzqkFU2D0W1HLWUdVrTn+EF/+w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="450345511"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="450345511"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 14:46:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="755331559"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="755331559"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 07 Jul 2023 14:46:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 14:46:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 14:46:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 14:46:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wrm9FuR8R8nxpzah4tpLdCAxVluBja2DyIqQ+9fcatRThO6ZzmcWajVv4sCFhnWPJdXxztKt9iBPTFysNg+iPwHcKbWGg/BdC1Nsdv8no78Zd9n7jFWRYPbHFJPnV4KUGn0mp+AVTqSjHz6ZcfF62QNovCpDQcR5N9SL1AMHdNjq8pcW57JB03IPGmRDSsefpjZxBswQU1DsdL/9kNEgBjvXum7Jus4g+oVwhBhLsSHN/eaPmYvVfNg3UAnuiSGbNizmvz1AB7WbOg6otWIcEHoWnXoCLXOVxFHyEA790R0G2mnyN+VIIfw27Mho+6ATEKYYzwq+l0cWJHrMZt1LjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzSwMSt5bU8n3FcTD3jbKrE7rZhTjpQRQKe3GgEV8o0=;
 b=mdlrDkolP6V9Znl2Uggp2/+F5X8DBodYHimJK2oGss3/W2iuNtslGe+4P124AeBBw3qvyoT08W3DoL1EQZOtalAGXxLbczdhsOZWpg92AyhBs0amFLe8fD8J51snuGO2Rlne+oHCtBuCn5m8FZ+SMWi0JLPL9a5uTbCVrIVg5TyZuJTa23u2f1zV7qi1S2siecY3RC4+qRs66uorwzNi1Di9dGOBsd2S4JsLB6eXw0ZH1NqlFfxfCmJyp4Tw5N7bKNRC1y1psCYFJLaO13opko6r5tOSTITGsYh5hcq1NYtQwpXf8NfngL5l6cWSv5B8zOLwf26ytzmrC64/FDWExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN0PR11MB5696.namprd11.prod.outlook.com (2603:10b6:408:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 21:46:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 21:46:00 +0000
Message-ID: <94694f76-62e0-3751-3791-936db8b7e3ce@intel.com>
Date:   Fri, 7 Jul 2023 14:45:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v5 6/8] x86/resctrl: Display CLOSID and RMID for the
 resctrl groups
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564611100.527584.7981937236207103115.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168564611100.527584.7981937236207103115.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:303:8c::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN0PR11MB5696:EE_
X-MS-Office365-Filtering-Correlation-Id: 380bce7c-9bc5-4825-1851-08db7f338daf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTzjytRPQDHfz+SyoVRrsnUPxeVgK+4j9jbEubnly4TrQe1Qtsh1L+vDUQ+6tPOyjGjBl/rANAKRJnEHawtP2wCbfxD0n97+YePPJIomYYY40P/4ePafhPO4zSaTYOUvmGji1kKLhfAxJrFXeQNWZU8Hk+4lGaCZto/+FHguADxY9Suz/J3i5/Zh+59CBKNn8Q6FcFUALtJFxt3BPWcFqe8YPjF2k0eDPo6ZlEEIulgsc80Y96+ruWHdOJKdfeinmi+zXiBMnrxPVzdVEKWTumYRqG4M6aL07zZn6BgorVlga7CR8IlB2PG3qXuhCt5NrhGmh/tFBHb55ht0uyI859jV5TA1njphvIrnzomgp/jFwXAm7sg2HMM+C0MhOenDustES2W4+0NYSxzj+hhJ43gLu5WPeYcfpat9zWHOnODxcnJJoLRMDVc9FvWx4c21IlPgKC7+u+mxvng5wyYRkG4D+z3QMFk5VBHCkEMnAxh99ooAloIMv3qvHJWnCsPuCZKMYtinCYW6Bd0biPyyNSiY3LjJMK/cxu38uPBlw8VLoR721ZIZCWUHUehQpThF2F59rGw8JHJu/Lgjl8MfTM7mKgNuFJHNEgLUO2mdbQNgcug82VpyF3edEnllEF0wTKdomj/3f6fBvjySxldbNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(8936002)(2616005)(2906002)(4744005)(6666004)(6486002)(4326008)(66476007)(66556008)(66946007)(316002)(478600001)(6512007)(186003)(7406005)(26005)(53546011)(6506007)(44832011)(7416002)(41300700001)(8676002)(5660300002)(38100700002)(36756003)(31696002)(86362001)(31686004)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGllSG9OSTYwS2YwUWs4ZDdSUHR3MVhUY1hDeTFwUDRJRXhSR1NqM3BoUVV1?=
 =?utf-8?B?cmtMdmNSQlZUN0kvbFpTMXNKcFFzaGRwWW1sK01XaExMVXFZSDNneVRrK1M1?=
 =?utf-8?B?UTZreEczczRTb2dkMmlNMDh6RHlORmNkZzZMTzZUZjdPeWh5VnNacGRDdGRt?=
 =?utf-8?B?QUFBT0VuWGtML1NFVlBVdm15NlZrM2ovQmp2L2plbFZjVUE5bldEVUx3TzlM?=
 =?utf-8?B?ak1YK3l6VnFqTk5BMHRlQSs0Wk5Xc2VtM0NydFdoN0h4SDNIcHd4d1FETGM1?=
 =?utf-8?B?bHJ6MXd6MTc4NGFDSGFmanYrbHYvM3h4UVczQmRoK040UGgzblhKcUl2cTR4?=
 =?utf-8?B?b3pocGdGdUtMdjh3RWxELzJtYVBMYS9CNXdtUXRBd090SFJXSXJ5aXhhSW1y?=
 =?utf-8?B?dEZ6T3RlK2ROeVVaZUZCNFVFRkdjWUtWdkljOE9DZ2xMZ3QwY0xZTzdJQTFX?=
 =?utf-8?B?RzNFNUJQOStRTkdTTmFCVVFybjhmVjdFd3JwSXBXYjkwVkNtazllL24yaEVD?=
 =?utf-8?B?KzJTZXhpNllCVWRaU1ZQVHFUeFRtVU1nSzRyZWhUOVFQZkpaR0l6YU4xUVpN?=
 =?utf-8?B?aENQN0ZjSFBiWGpGSit4Q0krWHhMZFRCQ0lOc0RDYUhFb1Fscm1rcWFpWURh?=
 =?utf-8?B?RjJnVVpyMGk0RXBjWm5ZemxFTVFzeVlhemZzeWFURnI2Q0Z3QmprS3dhbjJn?=
 =?utf-8?B?OGluL1RKQ3hXcVhTaWgyMGJlc2M4eDZmeGE1U0RBUUNUZytwd2hWQnBFUGhK?=
 =?utf-8?B?SFhmTUhILzhOTGxERWRNbFI4SVFOTE1PLzRYYi84d2xQeERxeXlsOTRMM3FX?=
 =?utf-8?B?NHBNa2txdGFPSlN0aHViWHN2R2hqdlV1NEpUUDg0L0RnY3paZnd3ZFA4RWdF?=
 =?utf-8?B?ZjVZSHRvYXczRExJWnQ5S0RvMUZzT0JwVUV5akplTFAyVVg2cjluaTgwY1ZN?=
 =?utf-8?B?SkFTeWV1M0dWb242dWpWbXJ2bVF2NEFibGJIeTVUYnBkbTlzdFRCUDFCeVJL?=
 =?utf-8?B?c2FNdGQwOUp2c2FyOUUwUm4zYTF4cVVIaVN1Vkh2VWVTZnRYb0FjOUwzakZO?=
 =?utf-8?B?R2luRnpBNjRhemp0VnpqdlQ1WHBqZEt5ZEYrb1IwMHMzS2RjTkxNZzhWWkJ5?=
 =?utf-8?B?ZDFXZ0d0SlJycm9KRG5NUno2NEIrdS9sTUx4V3VSU2xIQ1pUaWllQU5LMkYx?=
 =?utf-8?B?UDBmdFdGaDd4M1BkUUpPRVloemQxVUc3VVI0UGRtWSs1bjBOT1NQTkhHZlZX?=
 =?utf-8?B?K0VIUUFRVkNOYUN3NjRuM2Nma1hyaHprR3V2MWkwcTRLSG1SMnlRYS83b3B3?=
 =?utf-8?B?Y01hUWZtaEt6TFFydU1Rc2xlUHV6cHAvZGtCYVZTdUVZV21HSVo3YlltRVlS?=
 =?utf-8?B?Q3hjWDU3OE9KUklTM09PK1NudGVqOG1wcWJ1WjRaOVRhOHpFUC9IMVZEVzIy?=
 =?utf-8?B?VFMwNEZuS2FEL01TSm5rdWZaSXFtVUN1bFFqVEZvZVVvZnRXQVFpZ29OWTND?=
 =?utf-8?B?M3hDVWpZaUF5a2diMTVXSjFDV2tOalJxRUtxSG05UjhFVUZ3a1ZkSHBkYUU2?=
 =?utf-8?B?R2hjWGpjUnNQdmN4ODMxTWQvenh6NlBrUXc2TzFDYi82WHdCZGdyaUtWRkph?=
 =?utf-8?B?SzRlV1VGanQvNHhZUHRNRFdTL0xBNVYrZGttQnNoRUtYdWJxSk1ycDdDZ1A0?=
 =?utf-8?B?ODI5MUNtbHpTZTE5dzdHRzR4cVArSHh0ZjVWdnEwNzBEQmZocEN0TFdkSFJK?=
 =?utf-8?B?djNUWHlSQUpyeVdHam1aaEFUenJqS0MwWTZQMVFnL2s4SU9TTGVuYWFjMkRv?=
 =?utf-8?B?MG5VMU9neCtVbkJvVE9ZbjVKbklCWHRFbHRTSzQxa0p6Qk4xUXFLazFPUndM?=
 =?utf-8?B?SDRGK3d4TWJZck5BL2MwbkpxTWlMQk4xYlJPSExCUFdoaXdHdS9TSzNxNWY3?=
 =?utf-8?B?b29WcEc5SEc3dU1NVnRZWndPNklCQzJQWm1FMjNDbHExTW1XWkI4NnRQZ296?=
 =?utf-8?B?NHNTeWdXL3Z1anBGSWFZWDN0K0FPQjkrUUg5WXN0bldMMFZvZmJkYkZrRVZ3?=
 =?utf-8?B?akxLckxPOEpJRzVEZnhuaWhvWldWZm5jQ3ZIMDhaUDZTaTJRZVpxSk1HRFFq?=
 =?utf-8?B?WkhWclhIUVZFWFZzbUlBUUxYVXVYSi9JS3FRR3pFMHFIbTVNU1ZkMk41aXFq?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 380bce7c-9bc5-4825-1851-08db7f338daf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 21:46:00.2609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbVe7n8H2c7yIJSGnDyBwlnzWSljB//PZ7KQ6GjfLox98mfMcOjzOZgUKa3Tew2yu/myKcuvLjRQRiDWGRPyP31f4OS+ay5Ha1e6RU01Q34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5696
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 6/1/2023 12:01 PM, Babu Moger wrote:
> In x86, hardware uses CLOSID and an RMID to identify a control group and
> a monitoring group respectively. When a user creates a control or monitor
> group these details are not visible to the user. These details can help
> to debug the issues.

"to debug the issues" -> "to debug issues"? Even so "issues" is vague,
perhaps just "These details can help debugging."

> 
> Add CLOSID(ctrl_hw_id) and RMID(mon_hw_id) to the control/monitor groups
> display in resctrl interface. Users can see these details when mounted

"when mounted with" -> "when resctrl is mounted with"?

> with "-o debug" option.

Could you please add a snippet to explain the file naming choice? Just a
mention that this is done in support of other architectures that do not use
"CLOSID" and "RMID". 

Considering that, "x86/resctrl: Display hardware ids of resource groups"
may be a more appropriate subject.


Reinette
