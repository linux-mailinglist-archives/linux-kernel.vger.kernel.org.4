Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6C70A2C1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjESWVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjESWVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:21:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EB4EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684534907; x=1716070907;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4puDT4yybigxzSFXSpJLHZSrKAZz+4/Nr4q0xMMSL54=;
  b=O1uhkP0BIWtPUeQBd9g5ehqHaHRl1x2+iRnO/9vT7PAyzTnFuZLOvhlD
   k69+G3YJXs21aEJa18ROXQbrr0YO19OICQZupGfK93k7WIjOeiaCDIl6V
   4viLbxRPX8RCFBXbrqcyAMB1ZHnLy881y+i9BTSqg1/BVzIZB05JYI+j1
   qSTXWH/Qn3wS5FvJ2AEjmic9qar9n5LvsUHrjJgJ+GdVTFbDHH4HsMfc1
   j8Myis3WBhyp41gvgRdzR75o35D5V+7YJ5AQu7v51Hb4AWbXmSyYjbsBp
   N62q1UmL7erb7JHZk9Lx4VMrbWDTcvwQWqUp80Ec94j6WGeQqk9lCXhCa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="352516415"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="352516415"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 15:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="847049688"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="847049688"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 19 May 2023 15:21:46 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 15:21:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 15:21:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 15:21:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUauuldc5lDIA8fbVJ3bF1uVBTpiM7Q9yOtLDNu3vOL07wg+UPJSknvbQCKZaMGNe0ZBR38zYmsFRMnuGR+GW0hszrcpbV33JwSc3irwxrufdR66HI6722J08GH9csG22XO3Kw+gWnh+bg8ASLlYlQzBm3PaB616ZWDDkooA2fkyMMZ9ECm5khS2Y2paDeCQUI3vSWY+ktTj1Xc7n/WLxc5Pw21gZ09QW9Q3c4iNTARJSZvweOySZAScdvR218i0hFAKSHXU7IlXuCArMoFh+ncHWyQOZdmjww88rqGtj3edvfjANO1qEwPmi1cWbbQ0bAkLNpzlrQJVe0Tcqd0dcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OGAzsDa7/fNItUuQQwlPKVFAVQKh9CYrytTifAF+K0=;
 b=JvZpI1sK3A7GQUsOkb4V55HF4Z4SwdZWxhu9y0oVLaZQixu0EuvL5JTXJb3OoLXLrkibDNS14duv/v/5Q91xPW7fuIYe+HYBspQc5EvuBxkhPEljDJUSGB4N2IUOFa6DUxhiMCrhRvhBEr7x7kWaerP/ir8Uh57pHJR61XoyOffqI9Vc96Qxqqg5FzAZuypI1rJXiARatT14wRsU6KsFfUElknvtUku+PPMvoVJi/KEJBKb3JoTsDOUymoowXFTyWv9al2T+7IILzT+DfHY5mfI7A9/MWSYPx3crBHUBgwraNQTGO5YT5oOusv2JcoosOSp1KogxMI5R1/YVOurR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 22:21:44 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::bad1:92a2:fa0a:1850]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::bad1:92a2:fa0a:1850%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 22:21:43 +0000
Message-ID: <42654300-67cb-254d-22c2-4642a4763ba5@intel.com>
Date:   Fri, 19 May 2023 15:21:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] x86: fpu: Keep xfd_state always in sync with
 MSR_IA32_XFD
Content-Language: en-US
To:     Adamos Ttofari <attofari@amazon.de>, <tglx@linutronix.de>
CC:     <abusse@amazon.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Kyle Huey <me@kylehuey.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        <linux-kernel@vger.kernel.org>
References: <87y1ltbtkh.ffs@tglx> <20230519112315.30616-1-attofari@amazon.de>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20230519112315.30616-1-attofari@amazon.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::19) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|SJ1PR11MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: f218175a-1fbc-4a17-4e68-08db58b76caa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/aZAMQtgppztpar4n/aSdRHoFfWDcwU5zlPgigO+8WID0sT6Txh2xon0o7pgcIWFPd2a23vRQxhvTq1xDs1uKqiC03fkH4W87qURDfGU3UUC+aajbedeAXgswh+kTST85Xar8citu7AnAei3FfPV/v9eWEv6/u2CSUmi8MrA5YNBqE1tuUjgJfeyr4JQMJ5OQFbl48/bICuIteQIHo/K9ifUXaRUzIVWcOjd2kCc1eEmVlBbdQ8WZKuh6N8OrfOSn+/zUycwNDuT2NIiKfL/uRp47wfbK295uKDudpZKY6/RZkaq/DZKPcEpynG8NEfXvli85fB6eIVi+86uS9M4PmHIB0r4UNE4wt1RTcfRBvjozq+6LOL4yUp5hTehHvRcrZ2gWn8ML5/MQSUmznVM3qr29McoeP9WSJBCTAM956TEFvnSp0ZRpe595F3aVl7xvp3SlxxRmoO0pPCD7HF+i3hOcXFeB1aiPjTghhlfQQLzGzyZ4D9xf+uuar7Z+L9TfHlBdjA5zUs34fmQcgSbvUFrrTVHsr2kEETksTAwsN9bt8BYUZC6XjiQP1yCRD4MIhoFzSFgRwViNye/xe/jJ6d6sHzm7xpCUiVtWXoc8Vezev9hrPGaQ7Oo7vipswBgAMFil38j8aqKnY0eQ2DGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(31686004)(316002)(66556008)(4326008)(54906003)(966005)(478600001)(36756003)(6486002)(31696002)(66476007)(86362001)(83380400001)(6512007)(53546011)(6506007)(66946007)(2616005)(26005)(186003)(7416002)(8936002)(5660300002)(2906002)(8676002)(82960400001)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1VCakNHU1dRZURFUnVhM3lJV1ZqU1RwcU5QMnpFS0M0b1ZNOGgyYTNsVGlT?=
 =?utf-8?B?M2RDTk4xNWN1RHlsSWFwRUdGQStBVmRVOFpJUWNkNkJlaGU0Wmt4aHFLQ0p5?=
 =?utf-8?B?cUU2MGhvQXBiZkJSdWNCTWdQaFhJYkRsNExaQ3Q5aUhaNWhtR2tBRmZ0T3dG?=
 =?utf-8?B?SnRvSEdwcGtHM0JYVGJ2QnphTlhWbFVBTHNSMk1Tdm9KcWNNaWI3YkFvZVJ2?=
 =?utf-8?B?UHNDY25uSGJBbDE5OTRZNWR1YzdmM0tieGlINC90RlRIT2NNZHNrTWFnZ2p5?=
 =?utf-8?B?eUFlM245aDFFK3FtN0c2NHlmakJGdElKVkl0cmhXOXY2MUtWc1BIMmJvZXZ4?=
 =?utf-8?B?aUh1SFpQOFdIbXRlV2Z4a1JGdUplalI2UHdObDFBY21YK3VaQ1FOMS9RZXRC?=
 =?utf-8?B?amZNTmZZQU56UFhOVi9vN2I3dXljZFh5cEI1R1dYOW9UaEpqVE1IWVBndTVW?=
 =?utf-8?B?WCtxK1BNWlJCM3dkZThFS1lJQnRwSzhkMVphUlpwVDFXMXVUNGo5ckxHRis5?=
 =?utf-8?B?NGlLMkhPTnRpQ2RzQXd5bmllUHBhUW90SnR4UTY3UFBDQjZYWlBXWW9ZRmNl?=
 =?utf-8?B?ZC9NVTVRSnNmczE5L1FmZVhmREoxRUpobUVIdkhRK0pKTEhmUzlqMC9XUWFN?=
 =?utf-8?B?QWhCN2R6SEZIWDM4L0FtNVFzRi9SdjdWWmxLU0crWVdPOXJ4azU1YjJSaVZ2?=
 =?utf-8?B?ZTFrU0hXRml5eXdrMWJGbDdIUjYyZGhJZmd6aHRmeVBrOXFoUXZ6QlRJL005?=
 =?utf-8?B?V2xCL2QyNWhONzVGTXFiSjBwVnJMT21ZS29IeTk0NndvemJDZ0FCNjZEVUtG?=
 =?utf-8?B?SmU1ekRGV1dpcTNUbFhqSVA2TzZXM0NIS1lMc2xFdSs4UEJOZVVINlZzcnd2?=
 =?utf-8?B?S2FyTGdKMWFXNExWSHMvV3pzRGw5SjRUME02YmpwUU85MDUrVVVLQitTZ1JX?=
 =?utf-8?B?QitXdXl5Y1hJMFRnSkhFYmlVdXRuUW82RUphWVpwaHJQc2NYb3pjYzd1K29V?=
 =?utf-8?B?WHI0TkNXcnRVOExnZFprTVRSN3NqS0didzByUU1scy9vb2RtaE5VL2tEanVp?=
 =?utf-8?B?Z1EwbjE5RGw4RkNORHJsSmN4SzBOOWgzOVhHckh2T1hhSXZlKzFBcFJjSWVO?=
 =?utf-8?B?dGV0SVJJRmVBNTFKUkNaWmxodTZFUFdPVHJtV0JRUVMzRTJEMjltWkxaRFd3?=
 =?utf-8?B?ZGlsdm9wYUlBeENONDBJK2hUK24yU1JmOFlTOUdsTmxyM05jRTlGanlUcVY3?=
 =?utf-8?B?OGtNejRFcFIzMEdYb3R4YXpua0tJQ1hXMUtDYnU2SWtTSnpXMGhYMXFUb20x?=
 =?utf-8?B?d1JmR1BxZkNjL3FLUUJEcEZOZ2VNQ2Q3QmdKN3p6Y2sxR21QWVRHa3M0Wkla?=
 =?utf-8?B?czNtaVJWRjY0SGtkUEd1UU5YQ3d3Tzk4RWNSMXRyZktPd2FUeEs5ZVFrbGJ3?=
 =?utf-8?B?d2EvUTdEcEt0L3d1Ti9ZYWY2SmhXYlJsS0lnR2c2OUUrNzhFUzBDblI3d2Q3?=
 =?utf-8?B?MFlrL0hOeUo0eEk3c0FSQWhVaVFFazBlS1NjclNTVHZpYWlSR3hQZktxMUVU?=
 =?utf-8?B?ZWRWcllKY2toZVA1ZHdOR1Y3a3Y2b0dUTWRKcytVSUJQMnBhT3hlUmpQQ1Ni?=
 =?utf-8?B?Qks0bTVRVHdRR2xyMVQ0MkJYUnNla0lOTVgxYkVyZGRkSHJidUpUZWFwZndz?=
 =?utf-8?B?M0dlZk1UYlE1czJXc2Y1UWltOGNicExaaFllaG9IdTV5dmdzUkZvSExCWFl0?=
 =?utf-8?B?NUdQTXJ5ZEJpTmZQUFRpWGk5di9JYWhIL3RSSCtwUHUwMlpzdmt0UnhrUjVP?=
 =?utf-8?B?RWV1blBqRzgvdUNDMGNHQ1lDbEhYaE5JOERUSEh3NEVkWE1sQm1remJlY1FW?=
 =?utf-8?B?QVdYZ3dsQjE4ZVNQbTlHM0o0aDZFQ01aTjZaa2pOSERsSng0aHpYYXFEZ0ll?=
 =?utf-8?B?UlhkdWUxdWVIT0lhWmdZWE1COFhaMHpVYXdkem82QzU1aXZPamtsWkwyeVpZ?=
 =?utf-8?B?VEo1eDk5Y2poalUrV01ZRDZkUlg0Vi9OOTlFU2o2clZQUVpjcTczMXZLSmFs?=
 =?utf-8?B?bVVJblV0ck5mT255STJYVytUT0lqWkMwcmpaM3RaeXJiNElzbjdMU28xOGw2?=
 =?utf-8?B?dHNiamczSk1VU0ZWL3NWWTRNTmdneERPZFMvOUl2NXdqdHd5MGNXV0h3S1Fj?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f218175a-1fbc-4a17-4e68-08db58b76caa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 22:21:43.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5d/OH8YCGzduFgR0sErOwKteTxFHYUYcjjN2Jop3CauwDwKiMaVIULsRyKPIWZXOG/jsXhHyMlVUg/LhtqmfMWtF3oYmnvZCSuokd1FG70g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/2023 4:23 AM, Adamos Ttofari wrote:
> Commit 672365477ae8 ("x86/fpu: Update XFD state where required") and
> commit 8bf26758ca96 ("x86/fpu: Add XFD state to fpstate") introduced a
> per CPU variable xfd_state to keep the MSR_IA32_XFD value cached. In
> order to avoid unnecessary writes to the MSR.
> 
> On CPU hotplug MSR_IA32_XFD is reset to the init_fpstate.xfd, which
> wipes out any stale state. But the per CPU cached xfd value is not
> reset, which brings them out of sync.
> 
> As a consequence a subsequent xfd_update_state() might fail to update
> the MSR which in turn can result in XRSTOR raising a #NM in kernel
> space, which crashes the kernel.
> 
> To address the issue mentioned, initialize xfd_state together with
> MSR_IA32_XFD.
> 
> Fixes: 672365477ae8 ("x86/fpu: Update XFD state where required")
> 
> Signed-off-by: Adamos Ttofari <attofari@amazon.de>

Tested-by: Chang S. Bae <chang.seok.bae@intel.com>

With this test -- which I may follow up to be included the AMX selftest:
https://lore.kernel.org/lkml/6ab71997-8533-1828-7c62-717e2821f147@intel.com/

Thanks,
Chang
