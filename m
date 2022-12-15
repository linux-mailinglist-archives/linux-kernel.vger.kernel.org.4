Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6802264DFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiLORlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiLORlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:41:10 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1C632B8D;
        Thu, 15 Dec 2022 09:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671126068; x=1702662068;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yp2/SInLK3PH3Y/0H/Su0snROzoxWe13YxutKoQ+1a8=;
  b=WsRaWOTPeIogdjINv5Tcu6R83kN6MJxTUfVEc2yuHu8xi5kGblSr+SgQ
   zhaj+GjNlv4jAxjyvLWAbB4Ooco/LzUnIMycDWTYxk1k9SNjLhoOcmNxo
   C4rMwfV9t2wCoNVre/ice/kNkFPu5yK7AK+tEG4BorX3OIGWsVTRmyhsn
   0IWfhMO8uE9yCZ5tyVVpSvGpp4WEHghWjz0f71oEZoXTHL3dpTqlMiD8n
   rOYstk1AVwsVO0RmwjLtBy9gtH466vhuwJCW7UPDlHdYylkVuTmGQoBdN
   udp1coc6cBk7sZAhc9lUp5G6ZKfyirzbQC1gYEvYqnCfQqzYttytdtMhl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="380965171"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="380965171"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:41:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="627280242"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="627280242"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2022 09:41:06 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:41:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 09:41:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 09:41:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh/WKHY0OdmIYF9adgDnCBMiMCXoAWuEa+dpSuBUI9mCSMAESssgpE7CcdoVDOp0MBSCa5OaPawj2hDWeWlthb+y/Oy966tCG9zEKXG4xpSPz3lYAF+nsnSfo3YPMfQX+Mt789Ru7P+OHJpX0309W6e1XTY4U4kdpwM+ZWbumNMlSAbVaPu3Xh/Ryp5lxYX9wAOFXhQV7RfiQ3ww17CH7Y3Kq+3GfDBQMEok6edP1UETrnAwMJRdGDJbqg/qOOUyIHANsJQp+W6rrnrGDNSL047W1aLy3kokXgkRupn5Kjsv4HzFhM/U+jfIY8BoQPsdJKfpBHEc/YNZRYK037Bg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UwuyfVfkUS6RCn91HOuHFmrISSzJMbbjB2CBHU68Lg=;
 b=ab5+/686XhROWnsOVY9BRl53YiO2Vj9sg6YcMDkzp24KvXuNcQsDJ/gnTTghHivIg18OZiQ276JsFSmDOp3wckYDaP/58V6SEdz3UHbiJSbark9CB8T32NP8J33Qw4/oqMGk4Q7LHWRWEa57Rfqahh5PcQSNL+odlYl3LHrgwsxQoI2mgmEbCyZ8La98rnpTSmHT7zgcrbn6zoADghXztSGumV8jL3AuzoSaMXZRK7naIR4kWqcBJoW2+NkoKeAo+ksRQXAYs9RxXtDIHTEKI5g2BxU89fZWThhPuyUPOSO9e8OTF6Zez9LKEQ2INw+KdLUraAXp8DtD5wm9VptFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 17:41:00 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 17:41:00 +0000
Message-ID: <512cd6bc-d474-6362-974f-75a690d2fa97@intel.com>
Date:   Thu, 15 Dec 2022 09:40:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 08/13] x86/resctrl: Add sysfs interface to read
 mbm_total_bytes_config
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
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990901578.17806.14559688057407662110.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166990901578.17806.14559688057407662110.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0093.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::34) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ1PR11MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 36566ea1-0903-453a-b51f-08dadec38757
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJnguUPFi+/RMn6hQb/7GmQO+yIsC/XVBpE233YMewQBEw2ztkutYlsmNNnTnn4HcBZHdakcmBIoBahnKu6WUk8bdQnA1+S1pfHyDKwRrVlxE8JfLqboPQtiTaKEJxCgeLjzGMuC3WgPTP46MCEzwV78TrOzqB6kHwcKYEfuQ0xT5z1oQJknDlmlQQDqI2B5TmkcUwiz+c3Cyw6utrCo+dCgmH3nCXZBYm8ikQcdP0I/XW55btGjG+GxGHVhFG8f3AVpajvSYYwzRw/KqEIZ3C+YdqLqHTHzPMPunKetuiDy1Cu8FpXd+1qd5HEECEFeanCo9uZNB6e4Xmp0LiaaklflquwGFsGeeB729uKlDhH4KjYaV9hHE6zr//PxmvCurvfLJJLyON4B4MJv4G9pbr381ez3+XmBY1Fva/PeW448ZHGpJuOxyOZzBCm4PbP54rsujdhcwyBpYOwebsR90yPCtQwRJUSMX1eYPCLbwGploCfJXDthxREw9cMq+tdrmcxxfrS3xIMR4ZinOedrGMyGjhTaf+z6C6fU7r/BgPOeqoLov7Myt/DEzGV5XtBFFU6o4GJbqwdECYdOvtwK7UHUvqotZagMR/8t4SfD5n22cjKNNaSy02VZehP2uf7dwGZZkVPBSbdR97ybxmjQvn0LPhK3WujeOgpsYBf4Kh3IdkPjW7hNliSfDIwtqN2wLIvju0Q6uGT5dmQeL4fa+h4DLMLZtUcOo/UGRx7sivE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(66556008)(66946007)(41300700001)(7416002)(66476007)(8676002)(4326008)(5660300002)(7406005)(316002)(2906002)(8936002)(53546011)(26005)(6512007)(6506007)(186003)(6486002)(478600001)(6666004)(86362001)(83380400001)(2616005)(38100700002)(82960400001)(31686004)(31696002)(44832011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3FWSUlUNDZqUGwzTzEwNjVWcFBGZDlTSjJzbUhpOWZJOFF5NjFJYy9kWllT?=
 =?utf-8?B?OGVrTHhQZ252YmxGbXlGTGN3SUpiVjRJaVQwWklxWitzNTZ2a0QxbHlWWXAw?=
 =?utf-8?B?Ui9KaVI0cEhwTFJqenJDTmZPQW5RcTFIUUVUNTJqLzZ1VFVJVU0xd2pZRmE5?=
 =?utf-8?B?eng3ckJlV3djWXFrNUNWVmVGOTY4OEV3SUZHeFRJaTYyUmhqQ1dxTVlLQ2Qy?=
 =?utf-8?B?ZDAzRXFUdGhleEhDSWszd2kzK1NWU1l3a3NwbW1JMHlJVERrbDh2Z3hLcU9T?=
 =?utf-8?B?MVEwV3BIQjQvclNFUGRqejh5S2ZFeWJqTG43dVpkVW4vK0VZdzZtWVEwSkM4?=
 =?utf-8?B?UHJWWXJ0MFpyYUZ0OEgzWm9keExFNDYrZG1EQmZ3ak9sazRkTmJEZTdUUUJV?=
 =?utf-8?B?dWVMQTNIL08vOXZjd0F6bjFlUDlrY2J5WVNPeVJYTXhRbWtQQXdqQk9xUzNn?=
 =?utf-8?B?STdQWWNncXhQTVQ5OXlKclV6SnNnclZtSllxNVRFMGFpM1V1OWRDd3RjQlFt?=
 =?utf-8?B?cmRZS2Y5aDZNQy9TTndDdmdCQmgrclFnM2FTRTlORkl5cnNGekR2UG8wQW51?=
 =?utf-8?B?bERYdlFCa0k1NmhISzFrRncwUXA5cnYyMGtUbWNacmxHOTNpbGV4VmZNaXdu?=
 =?utf-8?B?bUV4R0w4Mi9jdzhQQzZZRS9FQ1kwSGdyajdHZEhRQ0hBVUQxbEl0SytkUUZn?=
 =?utf-8?B?aGx1d2hoSXd3RHZ5cDhqWW1EaEVVQ0ZuU2tITWZGNUl4T0dzTE4xRndJd2ph?=
 =?utf-8?B?bWJkL2tyUmZOeDgvT2pIN0NSbW92cExQTkplSmNVSFYvSG1xQlViMHhSaFU3?=
 =?utf-8?B?MWRtTzh5b2tvb0V3dktjeEN3eWVlNFRwMzhVOFFiTDJoaE9pV08vVk1VUUxO?=
 =?utf-8?B?ditkamlyKzIxQjk5UmFtQUppME1FaVhIZzZUVGJRUjVrc3hJSUsrNW50YytD?=
 =?utf-8?B?Q0pEd1Z5Q2dlUHduNlhGRHlxN0VzdVVaV2ZHS0pIYUgzdjJjVjY1elR2WHJw?=
 =?utf-8?B?MmZNTmVYa1oyQ0tJMnNlU3F6MTUvS3pDTXZBTTJzUEQ0TnR5QUdwMjZVdnhL?=
 =?utf-8?B?bGVickdIcDNnUndxeXVQR1dseHNhTEhGa2JvN0hCZ2U2UGl2VDRWODhZalJO?=
 =?utf-8?B?MmZRRlVYN2FYNjhMYnlIYklWeWY1L1krV0ppNThtdFdoQVNOdzIzUWwvSmdX?=
 =?utf-8?B?a3BPZ2dwMTIzU1JEd3JoSERidzZsTmdPNHhsSVdGcVlJeWpyTnpKbTFvU3ox?=
 =?utf-8?B?b01rVDd4Nk1DaGdub0lCcm5wUWI5WFNLb0NjZ0tVMWMzaDFRVlBER29YSS9u?=
 =?utf-8?B?R3FKNXYyajBvZGNpU2FvWmNPWlEzTndMdVVBcU5ZK2l3T2lBdXdBRldzRDV6?=
 =?utf-8?B?Y29oeUhvOEJVWVMvMEV3WFRMVG9meDB3YitvbGY1dW9zMnhibndhd3Y5NHRs?=
 =?utf-8?B?OGVrazBRV1oyU1JsVGsxZklKNFBUaUo0WUdBOGlRcTNQTkNQa1Z2MWhUZy9Y?=
 =?utf-8?B?cENITXpDaDViN0ZQRS9ISWg0QmJuVHRCelR1UFhVMlIraG5mSzNoZktySHVw?=
 =?utf-8?B?elcrdUttY3lXQTRmaVpOQzJ1WTFaek8xUUhrb2NLTjNUVG0vekRKMytxSVMv?=
 =?utf-8?B?WDJucHl4RE1lNi9ROXNYN2VzalRqbDRCT2VQcEc3ZnFYaHI0TkdvZWRwOUJ5?=
 =?utf-8?B?YVV0NUdwUy9Yc3hXdVlDejBBTkZHWTlONjlQK05BOTBMSW5qV1VIY3ZTMXVF?=
 =?utf-8?B?VlMvR1JrbkVLT1U2TzNOcGtVa2RFWjlXa2tZeFRRaXBYcVZ4MUJhcWtyQWQz?=
 =?utf-8?B?ejQ2ZGdKVDIyWGE1QkQyeWd2ZTVWUDRPQ1A3MGt2dUFDVmtKQXNSQTZhd3FI?=
 =?utf-8?B?Wks3enpMTitwbzFkV1BIZS9ramFOTEk0dk51bGVqSlYxdjNzYnBpNmpyWGgr?=
 =?utf-8?B?Y3ZjK3pSYzRLSXNHUEFGRUZ2d3RTVTJuR2NWN2krWTBwWEY2amZ4NlppTG52?=
 =?utf-8?B?bFgyS1NqcWhuR1czUzBVUUM5UitZNFdtUzN3a25vcnR1R0c4cFZkWG5FbC9w?=
 =?utf-8?B?bWlNNjMramtiSEV1MnpjTC9wTzFUT2VCcm9TeS9kVWxJSWYvYWtCaVg2YklP?=
 =?utf-8?B?bnY4S0JJM0ZDY3hWZktQWjRJZDc4UzJISmxTeEt6RmhmRCsyNXVMd2hQaEVG?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36566ea1-0903-453a-b51f-08dadec38757
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:40:59.9351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWPjPbWLzO21lnrOE0CDSEIZZ4JdS0sILXN6/4U3C+U4VWwwSQG1rjvo1ONmjfsO+Pmnq8EuDcU1X/SjlIdvaLy/lxSLYgO6xhKt2NHRFgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6084
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

Hi Babu,

I would like to second James's suggestion to replace sysfs with resctrl
or just remove it. I am concerned that you mentioned in recent message
that you only plan changes to patch 10 while James highlighted that this
needs to be addressed in entire series. Could you please ensure that
you check all the patches?

On 12/1/2022 7:36 AM, Babu Moger wrote:
> The current event configuration can be viewed by the user by reading

What "current" means is not clear and the term could just be removed.

> the configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.
> The event configuration settings are domain specific and will affect all
> the CPUs in the domain.
> 
> Following are the types of events supported:
> ====  ===========================================================
> Bits   Description
> ====  ===========================================================
> 6      Dirty Victims from the QOS domain to all types of memory
> 5      Reads to slow memory in the non-local NUMA domain
> 4      Reads to slow memory in the local NUMA domain
> 3      Non-temporal writes to non-local NUMA domain
> 2      Non-temporal writes to local NUMA domain
> 1      Reads to memory in the non-local NUMA domain
> 0      Reads to memory in the local NUMA domain
> ====  ===========================================================
> 
> By default, the mbm_total_bytes_config is set to 0x7f to count all the
> event types.
> 
> For example:
>     $cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>     0=0x7f;1=0x7f;2=0x7f;3=0x7f
> 
>     In this case, the event mbm_total_bytes is currently configured
>     with 0x7f on domains 0 to 3.

"currently" can be removed since it already starts with "In this case".


> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h       |    1 
>  arch/x86/kernel/cpu/resctrl/internal.h |   24 ++++++++
>  arch/x86/kernel/cpu/resctrl/monitor.c  |    4 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   99 ++++++++++++++++++++++++++++++++
>  4 files changed, 127 insertions(+), 1 deletion(-)
> 

...

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 8342feb54a7f..e93b1c206116 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1423,6 +1423,90 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +struct mon_config_info {
> +	u32 evtid;
> +	u32 mon_config;
> +};
> +
> +#define INVALID_CONFIG_INDEX   UINT_MAX
> +
> +/**
> + * mon_event_config_index_get - get the index for the configurable event

Could you say "get the hardware index" to help clarify what the index is
for?

> + * @evtid: event id.
> + *
> + * Return: 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
> + *         1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
> + *         INVALID_CONFIG_INDEX for invalid evtid
> + */
> +static inline unsigned int mon_event_config_index_get(u32 evtid)
> +{
> +	switch (evtid) {
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		return 0;
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		return 1;
> +	default:
> +		/* WARN */
> +		return INVALID_CONFIG_INDEX;
> +	}
> +}

I see that you copied my sample code here. My intention was that the
/* WARN */ comment be replaced with an actual warning. As a comment
it does not add value. Since the caller now prints a subtler warning it
could just be:

	/* Should never reach here */
	return INVALID_CONFIG_INDEX;

> +
> +static void mon_event_config_read(void *info)
> +{
> +	struct mon_config_info *mon_info = info;
> +	u32 h, index;

index can be "unsigned int" as returned by mon_event_config_index_get()

> +
> +	index = mon_event_config_index_get(mon_info->evtid);
> +	if (index == INVALID_CONFIG_INDEX) {
> +		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
> +		return;
> +	}
> +	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);
> +
> +	/* Report only the valid event configuration bits */
> +	mon_info->mon_config &= MAX_EVT_CONFIG_BITS;
> +}
> +
> +static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
> +{
> +	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
> +}
> +
> +static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
> +{
> +	struct mon_config_info mon_info = {0};
> +	struct rdt_domain *dom;
> +	bool sep = false;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	list_for_each_entry(dom, &r->domains, list) {
> +		if (sep)
> +			seq_puts(s, ";");
> +
> +		mon_info.evtid = evtid;
> +		mondata_config_read(dom, &mon_info);
> +

For robustness, please reset mon_config before calling mondata_config_read(). Since
mon_event_config_read() may (yes this is very unlikely) exit early then mon_config
will contain the data from the previous domain.

> +		seq_printf(s, "%d=0x%02x", dom->id, mon_info.mon_config);
> +		sep = true;
> +	}
> +	seq_puts(s, "\n");
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return 0;
> +}
> +

...

Reinette
