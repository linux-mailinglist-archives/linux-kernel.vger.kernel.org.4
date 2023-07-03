Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DBE746012
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjGCPtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjGCPtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:49:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FF5C2;
        Mon,  3 Jul 2023 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688399370; x=1719935370;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ToNWxY+IGVHtNzmuOwakUo48QHx2RPUnb48z7JdmsFA=;
  b=lPyFwGFus62tzn9PyFI9ibUFycBbyrJgyyIk5ZKmN0Wa7VDaV31KR6Ep
   kEaW9i89JkiIv662mI2j1vqS9b6qee12PXrX5lMXYa0/nAo9n0uNhRzhS
   NYuaLLgGpWyljNq1ov/s8U/5DdwvOA6mHmxC3C9QQh40xT9F8T3tapyiP
   ltRB7/cOHA9Ko19eGdaGPEKc519X7eDHe/gYyqhxLMhJg5V/ztEdIVjWA
   bToottXnf4HqrHqW3b/T/BcOffjhIulJtf/WZVwoTqYCGJViUgqeIo9HQ
   2/TAnxvrnJyh6w4zxkTygk8nz6lKr4c0yH5n38aRTwbjR0PYnrDFUgw+K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="365487243"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="365487243"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 08:49:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="965224400"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="965224400"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jul 2023 08:49:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 08:49:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 08:49:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 08:49:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVsXfARbLgKhoxjTqSvH/UjD3VzKy0AZzrdDaE96Q+O3o4qglh6lfzYs466wfVNpxx16QyWS3BoyHixf/d+w+Ugb89uTBVwwxphL5NzBkq8uIJcbZD/ciz7t5rY2x/39SNjK/YhpMk5SYEIL2yzZHGgPYFzU89HlT9elzEeWN7p4zga0H2tzTV3r7ZSmZlSe+y5escKrfp6zhoeuh4bPIYOykGU8BY1Bl8n0siL2Uh3HiZB5lU3c08yR2zKx3qwsUIBX4BojsFHHmHx0hyXF4nSwG8b0w43cSCKK/B91vuXaz9y/+fxP6NW67IuN64XCThr9N1Sc0o62RL4Gpd2CNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1LQx7TNGrtoCQdth7NxHHeH5brW84EjOr4ibZAvpLA=;
 b=CkAaa8Wv7gdn410oeXTKp2pAil/P4qSJiXekQlD5OFgbAe5jKOuAyMVM6rR3bFWQ/b9HfSIzeO6sRxWCUs3JofYNBv1HDdpARnLNTkfVanXWGj0r304ywro06/E9TGApqNncHVi+PoFwqaOTydfpuAO4sIlkJIFTCSSdQtyVWCSTfswr/8t3OUReIcMyyOiWUZnvhEWCP0raA0bLaXIITOylDP0FEDgiZSA4AJmhtRE4aESXRaAO7Z0KbDJaqYFRyCko3BNYzF7j3UQRZpAHzpv9mN6e276Jd16NP5M/VzojqGd1RDR1vhtB0FCwWNkB1ez+uBlpUE42c/H9bqCt4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB6244.namprd11.prod.outlook.com (2603:10b6:208:3e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 15:49:26 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 15:49:26 +0000
Message-ID: <23a2d0a8-3a68-f649-51a2-3ebf401b59c4@intel.com>
Date:   Mon, 3 Jul 2023 17:48:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [net PATCH V2] octeontx2-af: Fix issues with NPC field hash
 extract
Content-Language: en-US
To:     Suman Ghosh <sumang@marvell.com>
References: <20230703122040.2151210-1-sumang@marvell.com>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230703122040.2151210-1-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba8594e-708a-4b29-1758-08db7bdd13e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLJODJ9sS7bJoulVmQtzqv1VMs5mXLjyJPSrqkSE64a8Hqr3yWRBm4eIxWV13NWOZ0gNXhCnP41fB1wuI9X8/UQF55AHxCB3EE8FJA2rUrRjtLYsKqksgrMm37Pup83TDH3SZPK+V6Fz0JrjEvewJ1zX0DcTnVr4qZ1M6JzVBfjMXCjgn8Xbv3diRgAIHVJmZbH4g7CBSu28PB6tHmgSVLx3vP7efORGorFm3mmtJTJvnQAtZz0NF+aW3m/43kQiPhhLMcWVUfpvsC3Ys0MDl7D1x9rhPj8BrUpAE8XLT4afyRh5AZjwqks6IZro7acIj/B6HqcmNy68Lex8rFivbt1TJQFVuAKvDm2TefUNh9g44ceqF3KQyRGjzBr+O3iDPznvAY2Z65uCBwHbBJbMQRSt3sN6FR2DI7NHwt4sKfmnubGTFF4CosbHNkDuukWLREfT8YxzeqqokM2LTmdx4tkvQsVRDURIvwtkngRWwJ5R7y0WgT83WXHPeGk1xR/1EL5S5gzDk5eda3nR2QZdOC1X/JN3detTB9DHIGsnoOvqGEJTXBCh2LefZL1yxbt028bhb89K/OTjnCAdaLicul0Jj3S7L1fUGtHVkRmRjWAJ+9Y7KcPVqyBscV88a+jPSd0L0KaeN6hOsKE7/uutpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(41300700001)(6486002)(4744005)(38100700002)(6666004)(82960400001)(83380400001)(2616005)(6506007)(26005)(186003)(6512007)(31696002)(86362001)(478600001)(316002)(36756003)(2906002)(66476007)(6916009)(4326008)(66946007)(66556008)(8936002)(8676002)(31686004)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU5lN2VJazM3WHNYREhtZThSaEhNeVpuaExNNzJGSVlHRFRjSTRzSnVSVzVP?=
 =?utf-8?B?Q2NmaUNOWFVFNUtQcGM1Tzkra1lGelVHdkFlOHJsZXNsZWRVcmVOTnAxOEg0?=
 =?utf-8?B?NjRPa2ZjdkJ3bHR2K0FVbk5ncU1KTUoxdSs2RWgzTU52emxlZS8rZ0lZUlBo?=
 =?utf-8?B?QjB2Sko2UTFFSXBRdEs0UzdQNlJJNjUvUG9KcnRvWlphSW9hWGRheUpldWNK?=
 =?utf-8?B?UjVjMjZzU3ZPazl5aTNUMmdTVVptSDBSZWpWb2xrOUVRYk8vUnA2MzZlVTZ2?=
 =?utf-8?B?bG40N3BOQUljNFZIVnpyZVpXdVFsT1ZCR3hZd3lLM0JzYVJkbEtIZjVSaHVs?=
 =?utf-8?B?b3ZGLzZYbnVyNHovNEU0ZFJnKzQ2SDVXakI1c284VEZNTjZ4MVN1UWVZRVZ2?=
 =?utf-8?B?VFpIVy9qMmpnanEvVm9tQkhLc1F4Q1Bjcm9Lb00zTkMzSGk5amF1RUJ1cDJq?=
 =?utf-8?B?QUdVS0IwZ2xDSFlyQTFnTWVXVVFWZ2NRUituUVRLV0lZdEhvdkRxenVidUZQ?=
 =?utf-8?B?VlcvZVN3QmpJV2t5VEFrU1Zyd1drM3d1Y204aHh4U3gyUFR3SjhqVnd4cHRC?=
 =?utf-8?B?VmtUcmptWFVpMWV6QmU2SmcvWlQ4VnhUT0F1T3ErTHBkT1BkamFNbXlPT1Zm?=
 =?utf-8?B?ZWo2NE9mRnNWL1B0bGVjcVNtWkxabmdXbDMvSFZXZmk1TklVQTYyVVlzTlgy?=
 =?utf-8?B?bWRMQWNPWDdFeWpDdXZUZVpzb2pTcTRKSFJyQm9PTHZOT0FIM3F2a3V4R3JV?=
 =?utf-8?B?QWdOMWFOUFJnK3RVVDdHelZMSEtmaVR3bFIreVVEdzlFVEtkdmZNUUVVN2Vw?=
 =?utf-8?B?UXVNc0dncUhkdXBBSjVpRmxaYTlhOVhzdE1qNytTdWxFdFhyMnNHMzNYWCs4?=
 =?utf-8?B?OVBVSDV4bXA5T1Z1QWVUcmt4Rm5VdlNZVGFrY29mNGIzMUh0TXc1Sm4zOWtY?=
 =?utf-8?B?Y3FnU1UzL1JkM0JrcmcyelViSXJnc1hUZy9XYW5WaUJLSW5aOWNQYjlSdzh4?=
 =?utf-8?B?d2xJcFRLZTJud3RHWHV6ZUxqa1krMmo3VTdOZ2REejVpcytZT2dOb1A3NkIw?=
 =?utf-8?B?dGFyOHFYdGRWS3ZLM1d1OHVST0VwSmtHZFg4cTNWUVZnVy9NQ2FwNkYrb1po?=
 =?utf-8?B?aUh2UDV5MTcxZ1p3MGhpSXFBUndUVkh3aFNMUTgxV21FZWVkcyt0QzN2aEhD?=
 =?utf-8?B?TnBhMGVaNE1yM1hvRmRkZ3JncThuZnpUSmpQbjhXOWpCS0hsQmt5NURpL3FN?=
 =?utf-8?B?ZllUa002eERBalNBU1F2dVRmT3VtQXEzR1hLSllpdzRCaVpsZXUxWEYxV3dC?=
 =?utf-8?B?d0ozTjNNTnZpSW1seDYrQ01zcWFvaWQyODE3T3ptc3k5ZGw3ci9Bb05hTlFE?=
 =?utf-8?B?OU5rSTV6TEFWeEM5UnNZRGsyRCt4UmpNYWllVUJQb1J5ZzRlcjVoaDVneFJU?=
 =?utf-8?B?cHhTWU9UZDFlRDJKbE5WRnA1aXkxMnBOZGgwVjdaaW1xZy8vbjNTUVo2OWxG?=
 =?utf-8?B?ZHhoSU0vL0IzUExLUzVNMUZLdGZXRmFXbGJqZDlNdGFTOWJ0elJLekNGVlp0?=
 =?utf-8?B?VW9kNkRCUkY5Mk9ya0ZpbmFqQUF5OXl4MjJCaW5URUIxZ2VkTXlqOFhrendK?=
 =?utf-8?B?aVhNRWRBaDFDdWdqT0h3aVhRRjFaa1R5RFRCUE10MmJpaUJDdk9XcGpZdHJi?=
 =?utf-8?B?VWtuWXRISGhDL08yM3l6dXc5cDQ3b3EzNWdSNnB5Q2VGejZETDRDS1ZxRENw?=
 =?utf-8?B?MUMydVQ3NmgxQmtaM3ZBdi9helMwTGJFN1BiM1h5TnJwVEkvQzNialdwNXM1?=
 =?utf-8?B?QmJYTDZmN1Fpd2xnZGVOS2NCakVaSm1YZTNNWStMa0RJZXZYTVdGbXI4MW8w?=
 =?utf-8?B?STY1bUY3eWRjQzVCRlJxMk5YY0N1Qm5kSWtjR05xYnUvdG1GM3dXKytucFFp?=
 =?utf-8?B?WG41VHhEd2VhbXBsSlhPallwMWYyZjNKTG1xRXBzcVMxTkFURXNZYVEzdmR0?=
 =?utf-8?B?dm9KcHZmQ2JiM2NmbktnNDYrNGNOeDhtRFg5Qi8xTWNRSEZXdmlISVVqYU1R?=
 =?utf-8?B?THlrVDBDOWw2MjFqUWlSQ0FsTnlWblVzbHgyaE5vMHpMbXRWTUdmTjVqcXdW?=
 =?utf-8?B?MUZnNVZxYURXRkg4UTU4SUdOWnZDeHEwZkJKbFNPdjJoRWoxOTdoN2ZsMXRR?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba8594e-708a-4b29-1758-08db7bdd13e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 15:49:25.9528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwzlGzAQq6lHvA6Vv+G5KUNy2PkWcjrEaxGpfUP/seiOnzxiUEQvZInmy1sF4IIquAIrkSGp1Jg+NEXxNS1vNO3n/iGARB47dUwa6w7ilFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Ghosh <sumang@marvell.com>
Date: Mon, 3 Jul 2023 17:50:40 +0530

> 1. Allow field hash configuration for both source and destination IPv6.
> 2. Configure hardware parser based on hash extract feature enable flag
>    for IPv6.
> 3. Fix IPv6 endianness issue while updating the source/destination IP
>    address via ntuple rule.
> 4. Update hash extraction mbox message.
> 5. Enable hash extraction based on the MKEX profile

That's a lot. Can't this patch be split? For example, one commit per
list item? I don't think it's atomic.

> 
> Fixes: 56d9f5fd2246 ("octeontx2-af: Use hashed field in MCAM key")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
[...]

Thanks,
Olek
