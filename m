Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEAF6F730B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjEDTKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjEDTJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:09:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500E2900D;
        Thu,  4 May 2023 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683227319; x=1714763319;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hIRx5S2AvMdxpcSHL4QwUTL/llzzmNZzp6s9Vr8pR9M=;
  b=i5W2Jce1vBVAI2k9RMzTFhyXZzzguE7vqMnCrTcbWZuUnxOiLlJuqolW
   0J49zL7r/16EMFoewlopDfozfEavmX90jGbmCd2VZx0V01Dp8voKiD5Zc
   +An8P4wjTI8zHACPqNGg14AaeHzTveGkSd9wlvY/THg3ixKHGQ68SQsjW
   Q52mGZfEeJ3JCU3pC9CQsdjTxw8u2PYXK38x89Rzfr5Yy3ymApNlXwl5g
   RjT/F//VT0VJDslmeKzNJUnrY0/Kxo2W68HUVfjTgsdcN3TlBoDJ2Sm9d
   gY3pGZli/cKkXLUx/cCTauguV2pJy8KBaDxZfkbGmBkCv4MtyJlxUcD3+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="414543706"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="414543706"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 12:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="808867153"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="808867153"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 04 May 2023 12:01:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 12:01:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 12:01:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 12:01:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQ0q6lViYXRl2jS0Vc72Bkjg2lGDkJeV+DP0cAEjwinDfjUeQyQFqUfqa7bm28z8NWH86oUqrpI8VCYQflLUkhDoJA8YKdSuC7msSKzH3/84j0N0CdxCinxoaQmHrJh855Xv4Rp9TzbWJUiSxF/XZzF4FmVxfeAoM87VTapmrtkFjSxhPxbXZ5gJSWle9wWajtClh3SRK0kk7Sps0I34B3R1icTcE3kDTKkiT7AUHGsXqcQ/jd1qZkZoQpCAwcMZTEJHutqzNHRKp95TXaL4ROQ16YKmJ0ybkEiGFVa/aYhJ2yDtkAKhwEybsIz9yb6aFRVzfAlYX7PlSOz/1rekbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIRx5S2AvMdxpcSHL4QwUTL/llzzmNZzp6s9Vr8pR9M=;
 b=kYo/3DaE+ZoBV5OkmqKvtqeTMyAjNCqlRT1pZ6qXUOidRNQr24SQmGxU1feyFraqxZaO2bR1+/OlyN8oY5hmg/Q0flzbFuAotGO+K4G43fJdOajoud1jnEhebZIMukwWsS/gEUi28N9U0DMDqEDrKkaWqSBSh6xsaNb5AhqnXnmRnZdBajtkh2KZnEYtTkbd5mtu5d1w3Yv+67RWHLiMNNm26Qd1FUaz/2jOjFW+nezYly7cPxJEwOjerHBbJddQB2DAPUHUtoqRbsC8EUM3s1xawDZlaTdxnkuGgzd3QLwWKuYlLK0duM7zKWY+/NZ/9G0nmcgOBit7MQ12jsIMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6947.namprd11.prod.outlook.com (2603:10b6:806:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 19:00:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 19:00:46 +0000
Message-ID: <67e00f1e-bbb2-59b6-fe34-758d5b268324@intel.com>
Date:   Thu, 4 May 2023 12:00:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v4 4/7] x86/resctrl: Re-arrange RFTYPE flags and add more
 comments
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
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177447844.1758847.17789021842152864417.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168177447844.1758847.17789021842152864417.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:a03:100::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 2060d22e-ad93-4208-5a50-08db4cd1de2c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yjzf8Su/oseb4QYvmW1XoUNMzHmf3z7xvEu+A83ERmVGZx3rqf92JaxgBtoB/3YTSPfY3ZAogZevbhJMvVuJPmC1x7HgF89K/9/NIK4oAqVWF9yJ7LJuFeQYGJbItk2zY1/A9XGOWbcvZUV296/7CPLYQNegVEQgxAZLrc0uQs1eQX9Z0xh5tv3wAil3MBf02BXw8ZJYRktGx/jX6ntP79ZDpttpe59VAfrudPru2D97N2cYVRNsngAyPsIYiFZHLLEM7o8eYiA3+HFeuawvrgKjYXeHXxUhahpedQCK0qhWL9YhZZep3gjy9ZKfrZK6PQcqRL2fMfYoNaIQqWieITUaHfNYM/FysLjO94GkS/Z2Ezvs7fmR1n475gqndOUstgTZaWlg+02SCpbjP6Ve9B1Dp/gShL4p2TZTiDwhM0JlaaQSyOEReLUFJF2lytcsAJc5TSorGJ5lMgd+ZTI1W5msf2ou7Bsh+H7sdqANfeCbGXGY9ogyJsiU/JxDJB2Z17KqHk77o6SrsRX7GGVmYYY54u8csXGokTK05nGqwLknj/ncftRIdQdjg5ztbG7BltMFEb4j2JE0QevHpg/euhEOS6nQICaUvMblIaFSG507WL+nsnRivMGW6GU08KjE/7l56rxQPlRH6UfYJjGGhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(41300700001)(6506007)(53546011)(6512007)(26005)(478600001)(4326008)(6666004)(31696002)(86362001)(36756003)(2616005)(6486002)(66476007)(66556008)(44832011)(66946007)(558084003)(38100700002)(31686004)(316002)(186003)(7416002)(7406005)(5660300002)(2906002)(82960400001)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFRzR0FJR3ZxM0F0UmhudWtkazNxR25kWmF3dDF0QWZMQ1FrRlEyU3NqdEhr?=
 =?utf-8?B?dERJY0l6ZmVrYWp4WmVSSEVqUnZMcVZ2NWxBRWNZTWIyVllTdS90ZFRjcHVI?=
 =?utf-8?B?a1R2bVgwc0lpYkxCREZVQlNKUFY4NG1qK0QrWW8vV01EemtUMjRRek5uQXFZ?=
 =?utf-8?B?OHNuR21JZXVxYTVpS2Z0MlNFcDdBZVpkam9YZWl2ZWVmbVhRYzlFNVFNTWRj?=
 =?utf-8?B?aHBNbXNEQTBXaytsS3NVeXZVNERqV0JxMC9HeEVoVU1hZWxXOHZGc3Zlejhu?=
 =?utf-8?B?S0t6OEgrRGVNbGJROEVOcDg5dGFDejJWUGNqQy8ya1V6SzV3MjlJSmlWMHpk?=
 =?utf-8?B?ZjlVZ1lUWWQ1ZkkyVE5xbHU4dmRGTzQvaWw3TWdsWVMyVW5xS1BybDVVUmdY?=
 =?utf-8?B?YW85ZVJxcWxTR2xZNzhCREw5VXdIblRJWmdYN3lTSStBdU9weUovNTAxNXBx?=
 =?utf-8?B?bXQxOUFjbVJReDNXN1c0THl6MkgzWE5jWDFWK0lpM3E0WlNZT2pEK0RKdm5V?=
 =?utf-8?B?Q0kxdmtJMEFNSXJIWDFTU2Jxd0JibTVOMDRqVWl0MUwzZGVkeHpyWDQ5b0hm?=
 =?utf-8?B?bU1HWnJkWVROUnNySVc3dmY4RXdtb3RFWGNPQ1FtOUN5dVdHR0VpSlFYY0xY?=
 =?utf-8?B?RjZHaUlpcXRLZmhzQXNBcjFYTXlBQmhXamN1cllQYThDRys5b1RVWlhsU3Ro?=
 =?utf-8?B?QytlNURPclNrZGxJUTd2RzYzL0JjdEtCeHNMQTV5S20yVzgvNmRsZHVzQ1ZL?=
 =?utf-8?B?eWtQZlJrelh6aXBmNnBMcE5VMFEvR043dHNsendNeERucWxOTHNPcDk1WlJy?=
 =?utf-8?B?cWcwTlFCb21MSjQ0S2owcjd6UUVwKzJlZ1RydWo1VEx6ZndzdlJlUUJmaDNK?=
 =?utf-8?B?aWsxbWRMb01NbCsvWVEzYTRycW9ka0tCYUFqMUc5dTVDOTN1MllCc0ZNL3lI?=
 =?utf-8?B?dS8vc2RkWTg4VE9DZzdrNzIvVjFrRyttcVc2VU5wcFRvMTVqSTJnUXc5K0ZP?=
 =?utf-8?B?ZXBYK0FUTEt6OHBla2QySnA0YWVwY2FlU2dpQ1VBZFpMR0ZRaU5tbGkwd3ho?=
 =?utf-8?B?VFZMZUtTMG84Q0JsY0lvSkRKSXRIM05EZGdQVkhLSlVOd3h5blVtVHZhSG1Q?=
 =?utf-8?B?aU1rZjNIY2tWcW9Qbm5lRHdiUVV2TnFLQ084RlNpa2VmME1tSS9tMGRDbFB2?=
 =?utf-8?B?VHNMVlJsTysxUEhLL3lVYlMraTVURSt5S1R5TDlnaVFzOFhNcTFBWVB0TkRK?=
 =?utf-8?B?Z252RWRnZHQ2MVRGdGlHbzFJeWo5NWhYS2RneTYwblF6cXYvU3VvcW9QOFlU?=
 =?utf-8?B?VXhYUFhuK3JibW82YytISEN6Y012cS9hYlRMVnRocU04SENZV05EYnc4RzdT?=
 =?utf-8?B?QVJVdXhBbTEzMFowQjZ2WWlDdC9SanBMZkhtZ25aeHZneUM0Y1VoMVFWTldX?=
 =?utf-8?B?aGwyV01zaWlaRGxLYksyeVZXL2doYlQ3L0wvTzFqWk9xWkdJZ3B3amRlb2p2?=
 =?utf-8?B?WXlGTGdoMUp1Y2I4TUpWWnZ4MjhERXVLbThQaVNnYkFlTTlGRit2UzB2VWV0?=
 =?utf-8?B?REwxcUFLeGZIVkR4T05MNmlBSVloU05wRkI5TnVTQloyQ25ENlI0dGtpd1F1?=
 =?utf-8?B?d0NPazcyNDVvWDRaWTljcmNoaFNsUWZkamZMZzN4UUsxak1WdWhPSWhXNEdZ?=
 =?utf-8?B?L2lMYUhhZnJFdmNDVzFqRWR3bDVTeG96Rk4yMGtzQzNEMkhsY1ZDajFUNHYr?=
 =?utf-8?B?aHdiRlUzQU1KTVpLU01ETUxHTEZnSy8wbWVqU0pWYUxYUzNVdGNXbTRRRVZ0?=
 =?utf-8?B?b0JoL2xYVGRlNTlnQXNuWkVzdnlTOEVwbUFTS2RabnVIMEVhcmgyVk1LQk05?=
 =?utf-8?B?Y3ltbEpGOGYxSHMyYzRDcUZ5d3ZSUGtvTE8yMVdtdWpnMHRleWRSMmJDV2NL?=
 =?utf-8?B?dHlrNC9WZVV6SDZrY0pENWJVdFVzMVZvOE9sdko3QVFYc2Q1dkRIY2hmbWJx?=
 =?utf-8?B?WnRwbGRPWmRVUCtpRFRibW9iRytiZkhNQW5NYlBwb1ozRi9jQ3JpQllOU1RU?=
 =?utf-8?B?YVl0a3VmU2pndFRIRnpQKzluT3FoU2V2d0dPK0VaMDBjb2NLb3ZMK0MrYjhu?=
 =?utf-8?B?QTd6L3VBdkVmQnJ2d1lKY0l4ZUxCdVUrUm5BT00yZmZOOGlBZW03NmZTZjgw?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2060d22e-ad93-4208-5a50-08db4cd1de2c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 19:00:46.4062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Si1ldaqwZ56P7JSgl0JP/rHrrFaHUZzZ25jOOAwg1Vala739Gn9ceUvPbXx/gKAsEvN4KFKYMRuYb+PUMA/Vj/FcZg7i8Fp5fLIJCxUu/M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6947
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 4/17/2023 4:34 PM, Babu Moger wrote:
> Remove gaps in bit definitions of RFTYPE flags and add more comments

Why is it necessary to remove gaps in the bit definitions?

Reinette
