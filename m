Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E2B6237D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiKIX6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKIX6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:58:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395C1248C5;
        Wed,  9 Nov 2022 15:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668038279; x=1699574279;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mvwpXK7BzRK0VSqlEvagIP8NyVEpVmS95qRNxQp5tWE=;
  b=aPKuKXhKldvAYoDsIOHU/UgbeJ2Cr5q0dV6TS5bFsTP3rR1ahXKAaa6i
   4Rq2BlMkFv7yCcxNTAme3o01GPFxSiN3NIW1jKv56AU/s6Oiw2Lwgs6By
   UdyEuLmuKBfH25uGx9l3qY0XfQscqaqLYNQu/EA9CuH7QJnKnfWvrV8lt
   CfiJPcR7+hfHp+Ljwc7VRZBn8olndzhV1q8AwQntcrSB3DADxO9IAdTyC
   ZVrGEygFBKwQrSr79PGu+SRXfcShaSu0ceNXpQJN3al0q1dNYewqvryy1
   rYa5T6SHlhm/5W3t1+95nl8W8yuBKUcrSnOPpVvATROszz2isCKC+hqyJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="308779669"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="308779669"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 15:57:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="811825100"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="811825100"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 09 Nov 2022 15:57:58 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 15:57:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 15:57:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 15:57:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WANrkhQFEdfe2nrNOndXwVMh+P4Igj2nDAZeUwLw1rqyGplL+35uds7t86a4bzcMY4Oejn4nW24CLuByz8LeuR8qgUXOZz0poPEOyAZSsxquFyFVvaQ7Qp0afn4moSGAmvJOiPU6efjIzDE+y9crOt4kLHT+vUEh1ows20xXV46Ul/WiPsZ4AC9rdw8FYcoW5YcaDIUCw2q4YghzS7xBiqoXVoGyX1wkn7VFcMJqzI6VJgtYpfvKj8Uk5Lk1c1b1xO/hFB6vS+p4+14aEHOXgmDxXSXxa14dhOTR6JWRzEpK0meD9DAtayPhDQFa9YHyEBxBI6NccWP470RXIENhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOBShEqUJudYo2zbHbBROgcchrf31h9nIwcYhq3UbZA=;
 b=XNDtRrihRX+SNGONp72irycX41GmOHzu66erYFBAAIQuJh4QNMb99PhpLbq1cKftXciw9qWfOfsTFP196cE0VdeRoWsMr1Kpb4X7cC38KysYi9oqr+Gv0XhlspeL0zIZSj98Nc+hyPoes+BGiC7whnpd+e6eI7LmGkB5lIGeVK5BC9rYI9uu+Qkrgu3yB2ZUYvG+TFMORR7OFZEVpzmbJhOt5w9bM0xtz7ZAxNi3qYFwSypdwRC6NRRJnCLFujebhTJ2LQxXTeiKNFn8gO3mVi/WQG98RsJJ4KZw0YRjfRLYZwzbQ7ZBdvbT9lqcS+nPv/P6Qz4DdphtSbbEwMA5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SN7PR11MB7465.namprd11.prod.outlook.com (2603:10b6:806:34e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 23:57:55 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 23:57:55 +0000
Message-ID: <7a54629c-54aa-e95d-3f81-e03ef1abf06a@intel.com>
Date:   Wed, 9 Nov 2022 15:57:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 14/14] Revert "platform/x86/intel/ifs: Mark as BROKEN"
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-15-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221107225323.2733518-15-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::25) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SN7PR11MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b1b6e7-3f34-452c-a75d-08dac2ae382d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqhlNoW9A6qjPSxbRncfZbCqU9yQ+xOxgFOJsUnrvXgNCKKaUwhDJ4AF4EMLZqEHBZaBvBbmd6NFiIqWdUldNxGbTzyeFj5gT4vTwe3fri348IesgkKC9R0yQCJaIjo/Yu4r2F5jHcwd9eoshnu0Dlxsd1HFceeZIm5vkEdahKAPX9qu/qZRfPmESjcccYfW36N1tlT2symkL4nzvvw7VYYjB8d7VbeA5MOdf7iJet/BmUMu0BCj/dW9F/uHO1erSZe/xWd+zjga6Zz3hf4mLvlNY53/15D817gyjWx5bJddFkqnmyMaH8iK5ahbDQuTL7ivB3QSkyU2DSQjK455DNGCrjqBeqlY8o7fgI6GpSDmrBA+gLgU5Sbyy615g9Xz6nulp36jMXxegbQdTEhWFyENfQWXDnD0vh/1IvWTjV0eEFDIBOGsDmvaI9Ewofd8XP0aIx3FiQ9oygj1S9K55/Hc2dLV95XlqSWCZD5pO82NKqW/r0m54yaRMIdd041l40sJvHxqyve1NhI0C5/5dG7gragvueQPa+qYhhk2vqQVt6xOwcotNDJGkatft5w4W3MOx//f/D/6dGJGx27qs77VMm1X1NmZP1VCypfPE3k6BCo6Btjh8iCD2gBN8/YC7Z5zggP+SDVpsM3yMPmNCj0+pKatGf5QGmYGKCwEsZoUyrIVLjJ+70lbGlvNaY8jIYs85K+ikLmXsvbHQ2cKNZmo4Lqi4Et0pWd3etrazG9jh3ldJOM6K6DDAQuVXChFIpm7XEWuWYY6+bGn9wbpfuD3Kmq7JnzXEh0MATATqa605LM78QzI9hgMkWZtyh8ymss+qDasCI75EjiFh9Etdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(36756003)(31686004)(82960400001)(38100700002)(44832011)(4744005)(86362001)(31696002)(6512007)(6486002)(2616005)(53546011)(186003)(478600001)(966005)(66556008)(316002)(66946007)(66476007)(5660300002)(8936002)(7416002)(4326008)(41300700001)(6506007)(26005)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXhab2s1dXYzaUl1MnB6eVVJNzhMdWh2TWpudmdpNGo5cm5GMkZodkNXTWE3?=
 =?utf-8?B?ZmdBc2dRSTJUbU1iTGdqRW1PL1E2UDNqOUtPeFFGZURYdENrTUlobzVnZzZ0?=
 =?utf-8?B?ald4VGQ2VEJTSmFneGV6RlljVTk5WXNvbVVsMDFVTFk4cGpJY3I4aUk0cFVW?=
 =?utf-8?B?WHZId25UZWtiekN2cCtsNTBEaStISkREbGtNYkU1Z015eFU3OW56alVnODZh?=
 =?utf-8?B?RFFPNTdWS3p5YXdOTGRIaHlQYWpzb3NkL0F2SGJZOEI2WWJVa3FTZ1pBNTAy?=
 =?utf-8?B?OHVOQm1yeUxlY3NxUXB5K2xaV1ROWlF4NXliZExLMUdDaGppM3NnQzBEQ3Bk?=
 =?utf-8?B?STljdmxIbW9UcnBUWmdYMEJxVTRlTHZTbEExa3MyMzlLeXNza2pSWWdKNDl2?=
 =?utf-8?B?OGIyT2YzcE9YL2RFMEF4RjFJQk9CVEdRVmdNTEpDVWR1UmxFb3lzdUhKaUk5?=
 =?utf-8?B?RXk1cXdmTlFXS0prcXkyZHFLVmpzMXk1L2tuU2VDczZWcHVEU2w0OTlJVWpW?=
 =?utf-8?B?Y0FXUFhZdXhjdjczZk8yTDJldEFzODhvRE5jY2FNU3ZOSmY0bWtHd3JmTnF3?=
 =?utf-8?B?bWNpdG9MZTRseGZxalJIdGZ6cnQ1K2dpTFY4aFRtZ3NOUFJtR2c3WjJDWG01?=
 =?utf-8?B?YlhFaCtOd1VZZ1pwNHQ2bUpmNUV5Vk9IT1BGdTJZZXF4cElUakpmTW02Nktq?=
 =?utf-8?B?aHgrcTYwVGlDa1RDVHB5c0hyclJBaVR2a0Y1K0l3SDV0N21KYm5Iak5WZWpu?=
 =?utf-8?B?Znd6TFQwWnBkWlR4SW5sRklQRE5zOXRNNXRERlJyc0pnR3lzdm9YUTZ0MEZq?=
 =?utf-8?B?YlY0WDhmbFZCRzhSY2taWDJsMTV5WVN5OVRScUZ2b2J2OVJUNzhzUlpTc0R3?=
 =?utf-8?B?UmlNWWlsVFgwdTRFYU1HZzArY0dreGVpU250VDR0WFhjZGYvQkt6RlFTdjl5?=
 =?utf-8?B?SEd4akFMaDhFRGFKQjJWVHJFUGh5bngzdDdTWm5adDRMYk5IVmpIR010cFBQ?=
 =?utf-8?B?QjdqS1ZmRTBnR3lMVU44akpRUXp3Wm80UXVKbXlMQy80bzF2Smc2aURSM2pC?=
 =?utf-8?B?TVA3aVlBc1h0MkUrVTl3Y0JwSnR4dmx4K3lKL0c1aDJ2c2xGS0puRkxWZG9y?=
 =?utf-8?B?b1NkemlIRHVaVlFEL29CcGVsUnJUaFBDb0VHZWJlQXppMUdQWTI3TGFyTXRU?=
 =?utf-8?B?VU5CWnB3UGpYK3VkV3ROMWs5b1UrUms3WUs5UzJwMXZ1MUVSWEJlYjVqUHRo?=
 =?utf-8?B?aDRWNHl3THY4SXl6Z2hBUmR0RjJ6RDNNOWQrcVlHc04yMFNVZlFXUVNJNFRG?=
 =?utf-8?B?UGRrQXBWd1h1VnJZcjZlRGJhRG1OTmVDODVrVUU3RE55OFU0UnpPUVl1L3dG?=
 =?utf-8?B?ME51RWxPeDNVTzg2NXRBNzdnZUJFeFY0REpleUdNR1FrUkxOMjJlUjlCRFpi?=
 =?utf-8?B?UFE1WldBdXQ1amtXd2ZGRDFwMnZ3eFBIYUp3K0RwdERHVUZpMk9FNWdmYlBh?=
 =?utf-8?B?bjh2em4vNkpydUdPN05jWUdZSmt2TnhteE5QYkJZUHE1QTBaZlRxVXBCUjl1?=
 =?utf-8?B?VzZMWGxnSG5CbnJQMk96WUsxZjM4bmJCd2VtV08wR1M3N1YwZnl0RU9FZVRx?=
 =?utf-8?B?VWQxak9YdmZHQkt4REtGbDBtSG9odnl2anpkclBSRkY0d3BPWTZBMWRuV3Ir?=
 =?utf-8?B?RzBBQlh2NVF3QThVRjRPWDhqR2x1Ymo2NEtWZHJiVWNHcWk2YTViT3NsL0s5?=
 =?utf-8?B?dG9YcWQ1M3Naa21vUXNnamRZNjNvTzRxdVE4enFhMEpQbEJ2M3dmZHJQL0xz?=
 =?utf-8?B?MTVxdzVOR0JwSHFmTkU1N3BTL2RueFM3ekFZVnpJWENtbktsdWR2MmNUaG5l?=
 =?utf-8?B?bnJFRXl6SlBhcGFxcm0rTlllQkMraGhSV3RNRGdPeXB1cjg4czludzN3T3Fi?=
 =?utf-8?B?b0lOTzhzdy9OeC9tTVo3SDJmdnJmclM4SHowWEtMU2ZXS0ZzRUpQeTJGQWZD?=
 =?utf-8?B?aVU5RysvWnRVK2dmaG83Vk1SWWYwd2FSZEVWNXdHeEV1NmpyTGhtdHh3a0Jv?=
 =?utf-8?B?cU5qWkhkUDVuUWMwclZFZFhORGRVSDZ2QXM1eWFtQVByMHd5NktJcFZCdmVr?=
 =?utf-8?Q?IrgiehpLxhHOBEurQcZIsDzE1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b1b6e7-3f34-452c-a75d-08dac2ae382d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 23:57:55.3335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +k1+CkbWGNpNof/Ymqp6/aiD3yF/4BzngX/2Y5JLWYnVbe4OdABQZGZdjLV1oBLW/U+88ny90fqG4jCweAVkng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7465
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 2:53 PM, Jithu Joseph wrote:
> Issues with user interface [1] to load scan test images
> has been addressed, so the following can be reverted.
> commit c483e7ea10fa ("platform/x86/intel/ifs: Mark as BROKEN")
> 
> Link: https://lore.kernel.org/lkml/26102aca-a730-ddf8-d024-2e7367696757@redhat.com/ [1]
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
