Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDACE721AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 00:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjFDWCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 18:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDWCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 18:02:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EF7AC;
        Sun,  4 Jun 2023 15:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685916162; x=1717452162;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r4L6PvwHHQEqJtSDM2WXEAs244XGiUO97z3If5aOXfQ=;
  b=hcQ+orROcQ8T03HobwxwRGquZqm0HnggiMIw1efszCyEJcUaqmNpPoOc
   BHhRqTCo8L4YCwnRODty4+lBa9xU+PVQufBczUdN9QQ2kiHEKkx2VHbZJ
   snrmuccJ9MvDpr6FjwAXdD3L8QAaH7IcUETrKOC6m8DxuG3M0E5tbs/LW
   vAoHgz4l+DnF1/0ar+OFZC3Ty3YvRucEpBjyxFk5oCwhrqD0B7bQbAHQR
   wjITzrxAElTLANMo0ffP5Mjn7ZZweUC+Ym5ps8WGiP9QZbRKmZpQiKsQ9
   W434ubiULrSCZSC8uGB+Ngq1Vssr5Ljj85e1Faid2wWxJL5mfFKPPKQaI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="358679133"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="358679133"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 15:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="798194741"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="798194741"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jun 2023 15:02:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 15:02:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 4 Jun 2023 15:02:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 4 Jun 2023 15:02:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtEciQKimILEvT2iilxw35fsky8BgGZuQ0iMcIldZlXYHG38yU6vxYM9NdPvq9I3elZV0zhYJdl7XRhxTwnEEnLrQhe2p9CxqU6sNRxV1c5xWhGsoDTy9AuDVyhhU6Z/p8kEfTiEgUmsD+QnUNhVTi9HnW7KvICxQtEcKz1FDUgPRx/iK6tsjowIuDYqSr+sYXwkKRmOzMckUOovkh35npK+RU3F58yPJ4Avv+Sdj6hl/8PK8r3DuEOpDKu7TBdhcwa/u5mcPouf0bkq4NqkFvaQa+sjapMG0fuisX030m4TXW1lm8G1Mr089RXPGSBbzeVU9wsVLjV0bcOyzI1G5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30hjvfId+aVmccgMJSMaLYdHyn8xrjg6yx5q4/ASRXI=;
 b=NEWItExaGkZDGM8OFT3j0WLvKEZWD88gVyqQiVVSKsGBs6y+dwUWqXhU3n3Yxjz4MZLhCuo2rYTzf7TMzC13BdAywAm3J8ZKy1ixCRIvW6fMzb5WQ1j7tqvSO3cqQVyXQW1/fF8pll8An/kfYcmgvyT3i0tsnibywUJQjpwoXEEcCEIuWr0J+Z8fGC0mfI4ck/mlEgVic9ySwxQ6fZwZJUAdD4n0Fquf53DmOs4qTuOEsZwZpjnnpka4WoA4+g0gzCt8dch9AOWUlv1oGt/qA/sQYl8F+Nc2jeWOls6R9N+m2DByP6xpoNqLVKndVB8jdwlaYgLOERLOgfCenyIfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by CY5PR11MB6485.namprd11.prod.outlook.com (2603:10b6:930:33::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Sun, 4 Jun
 2023 22:02:37 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a41b:1b6c:8306:7644]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a41b:1b6c:8306:7644%6]) with mapi id 15.20.6455.030; Sun, 4 Jun 2023
 22:02:37 +0000
Message-ID: <0925dd9e-3588-38da-8dfb-0ac2ff568655@intel.com>
Date:   Sun, 4 Jun 2023 15:02:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 10/12] crypto: x86/aesni - Use the proper data type in
 struct aesni_xts_ctx
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <dm-devel@redhat.com>, <elliott@hpe.com>, <gmazyland@gmail.com>,
        <luto@kernel.org>, <dave.hansen@linux.intel.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <mingo@kernel.org>,
        <x86@kernel.org>, <herbert@gondor.apana.org.au>, <ardb@kernel.org>,
        <dan.j.williams@intel.com>, <bernie.keany@intel.com>,
        <charishma1.gairuboyina@intel.com>,
        <lalithambika.krishnakumar@intel.com>, <nhuck@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20230603152227.12335-11-chang.seok.bae@intel.com>
 <20230604153434.GA1212@quark.localdomain>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20230604153434.GA1212@quark.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::33) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|CY5PR11MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: bd29dd8b-c05f-43bb-6783-08db654767e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: loz69B3Zf9z2E4FOKyx4hG9YGpOcLFjyFCHJJvsdHI0obVohIP/OJ1StOqevSkS8RGn1gC+WL3QeJ1vah4RT80mqMnssaSyyBPvZuVVsP8pqQ7O0gM3moBpH8V77i2UKVDbnhHOfuQ+WlLXiqfrk+FVazsbHrea++5wGqvCG/GnG3lxlg8m4aDW0/+7KLBqsHuYFatQUfcfncpOKMzwtsavhNI840H9F0nB/Ys3MSPigRlAVlw/2YEBNGoqg3CW7zDSuuFtAl4GRVfpBlR6yzEiT1g1ziGPZ0K/hef8S/W9MTKN/1uAKzpz93AitupXTqGMrnstW6RCet7E9y2aZJKq28b4XxKjln7/jmL8M1k13u79QiFLwPGEMvvxaC0rloromVvszlAHLtUH39MI+yroT+4W0uO+LkihxcTuo+4rD7cCwy+avJpqphDK5N7T8niolpo+QxsvXp7CMfeHG7adp9RhAVfkdMWb6wod/4nVjIrFAZeenpgojHD28VsaP5ajVpfWe4t8w2THUCzRkuVMiAjD9d6ONN3Jq/Xr746/hWZTUeGRzPpZM9bd72M3LNwMARRhEdfIpiAlHxJ+vRQqEqz+CF1gyFZQ/CZiNM5qU94ADVZ+9H35iusDYguurVxQXG5iQch3w+cuicKFV/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(8936002)(8676002)(478600001)(54906003)(41300700001)(5660300002)(6666004)(316002)(6486002)(26005)(7416002)(186003)(4326008)(31686004)(66556008)(66946007)(66476007)(6916009)(66899021)(6512007)(53546011)(6506007)(2616005)(83380400001)(2906002)(38100700002)(82960400001)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGlrQU1seVNLQnIyS3ZXeExUNHhDdXR5ZHB2NHIzQkh0anFhYm8xNVRmWHRa?=
 =?utf-8?B?eGw2TU9RU1BFeDlTanNCdDlEdVRWeWFOMDJEM2F0ekVEU084MFUza0RTUHVJ?=
 =?utf-8?B?MFNFVnpURExON2kvTCtZUEdWc2N4NklNRDN4U0tkNkgrYUE0TlptZG9VanFM?=
 =?utf-8?B?ekpkeWRGYmhncnpQaUV3amNwRzZURm5PTzVwd3U0WkgxZjdZL2tPSno4WkU1?=
 =?utf-8?B?cUJoRDEwUEErSjhZc05UUlhMTVAzcjd2QnNVTTNoanpjZWdpcG5aQ2ovQlBj?=
 =?utf-8?B?WUloYzRXMTRvZm01Qmw1NEVCNmNENTBqb2hyQ2ZMUjdJOC9ydW5TOHBtZWRD?=
 =?utf-8?B?V2xSV2xGRno2R1I3QzdtTkF1dFEvdkFnamJoTmJFYVIyaUlnMEtZQ21KVFZ2?=
 =?utf-8?B?c0FwNGpBRWJqb3c0ZnZMSFR5TkNUbTFGVC85U2FnZTlYdExJbUFGejJoLzJr?=
 =?utf-8?B?V2dqQ0E1dUI1Q3A1VVZWVHVBZ3VMRUZtWDF3aGNLWTRIRS95RGtzTzRUaEoy?=
 =?utf-8?B?Lzd3cWtkSlZYQkU1OUVkb2JsWUtUb09BSFp2enlIUkdHQVB4Z2MwMXpSRXNC?=
 =?utf-8?B?a2hxamFTczVndlJqWFRzMGlwME93VHlxVEZJMzdJbHhNL0UwejJvMC83VHpQ?=
 =?utf-8?B?ZHhKS21SZzBkZC9uZ2tRV0VJU2dEbWZzbityc3lrNmhaZ2pOR2s4NlFVeEpM?=
 =?utf-8?B?eEV2azZaaEM3U3hVRzlYL0hpc1R5bElxRkdua2xjVzNzWnN5cktsd203THhm?=
 =?utf-8?B?N1JXUUpoQVRMWndNNXdUME1lOUlYVVg1aWNlbitMdjE0WDdMZzZ1Ry9mY2p6?=
 =?utf-8?B?YWV4Q0Fpd2cvSWVtVElISHRId1QrNGhaZWxjZWRBbGl1VTdoaS8ycUgrWGlh?=
 =?utf-8?B?ai9xWVJhZVN5UTRGd0NtbjdUN0p5YnJIbGMvVFh3bWFQK1l1OWQ2OURacjBX?=
 =?utf-8?B?cmdJT0xQaWN5b09kVFJJNWZNVCtGYWZQOGJEZXp5WHVSNGZBTjFqejFKVXdD?=
 =?utf-8?B?V2xpV0Q1T2JaejMyd2xaUFVsaXBFYVByRWZrVE9OSUpPNTNhRi9HL3BrUnlN?=
 =?utf-8?B?QzNLenMvSHcwWTA3YzUyNFFraFVNdlNEa3NMRTVYYUZsZlVHQkFsQ3FETHhi?=
 =?utf-8?B?TUxkcGk5ZVB1QmRybHJ1YTlZdmdleno5V0dxOGp3N0d6M2ZiK1N1T2gybEpP?=
 =?utf-8?B?RHZzNWhobXdhUVZTKysreDkyS3lqcjc5Y25PNCtra0hSSUxITGhDbHFPZnU5?=
 =?utf-8?B?WEY1WEdJb01zbUhlUmJFM2xWbU11bEgrYkF1YjUrVDdTdDJ5bDdoZ0d0T2VN?=
 =?utf-8?B?TkFkVmFkbFc3alRFNUJldWlRLzBIelpzczhGR1lwWGRNMUpPUW5NOW82RUdV?=
 =?utf-8?B?bTNpbHJCWktuRDF3NGFhZk9WRFJwdUxxeWhqUUZkY2xFT3UyNTNGMWdjempw?=
 =?utf-8?B?RkRaVjZQYzNtVTg5TS9kTURROXYySGxqd012L3FKWmExWTFNZUhZb1BFODBZ?=
 =?utf-8?B?UWJtYXhFVndGYWdpL011cS96ZGdNK3cvY29ISXZyQVBvSlZ3MmZ3anQ5M2ZS?=
 =?utf-8?B?bWFOQnhTKzNwYlFaZURkNmRINWVxai9EbmEzd1NqelV6V2diM3FhNmtCd2M0?=
 =?utf-8?B?WEw3ZDVVRlRvRVJWSm8wODBlQ3RaZTk3ejRrWlVTWFJWQmwxbTRlYk9EOUxu?=
 =?utf-8?B?Y3JQY21zU21lKzNTL0xHUGk1M1Q3UVhtY1oxWGRVK3N5WUwyN2M3RUF5bENq?=
 =?utf-8?B?REVlcHFPekJkZGVNc1FiVlZoTGNrWUthVVFkMjZhcFZORjl4bFJBZjNzcjVC?=
 =?utf-8?B?TmQ0N2xWaFVCRWJQcUtoWGJOcnNSSWp2cVRncmJaTmJhMC9kUXFKUXRIek5y?=
 =?utf-8?B?WXFZTnY1Y0JoTWs4VCtnUVc1ZzU3Q1BNMStBdmFNRkNzeitYVmxwY2ptV0g4?=
 =?utf-8?B?TlJSaFZwR3pKQ0J0MmZDMEZjckZ1RWdqdXRTZGtFQUZKd2lxQnc2bWJIWlB1?=
 =?utf-8?B?dnQ5RVhhcmFBUkEwZ3dta05rMDZuM0w3d3pabVBOeGVjSTZkZTVGOVJuR284?=
 =?utf-8?B?ZXFFcVpBeWR2emN3anE1dFpMTUlUQ08zQk45K2RBNDhYOWR1ZFdvbnErQnpX?=
 =?utf-8?B?b3ZNZ21JVS9VcGRMSlJPdUpzTThyK0hsbmpmMTh6QmRMdmloQ2xnL0RVc05T?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd29dd8b-c05f-43bb-6783-08db654767e7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 22:02:36.6341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fo+B/aRvxooAKI0Qt8PsLojdE6az4x2y7xRWsWS271kO7F1Fgc9hVxZT4OhIjQzHW7EzRIyFMrrqgr12zaswZCZivCeDqzoiAdejJu5tQoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6485
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

On 6/4/2023 8:34 AM, Eric Biggers wrote:
> 
> To re-iterate what I said on v6, the runtime alignment to a 16-byte boundary
> should happen when translating the raw crypto_skcipher_ctx() into the pointer to
> the aes_xts_ctx.  It should not happen when accessing each individual field in
> the aes_xts_ctx.
> 
> Yet, this code is still doing runtime alignment when accessing each individual
> field, as the second argument to aes_set_key_common() is 'void *raw_ctx' which
> aes_set_key_common() runtime-aligns to crypto_aes_ctx.
> 
> We should keep everything consistent, which means making aes_set_key_common()
> take a pointer to crypto_aes_ctx and not do the runtime alignment.

Let me clarify what is the problem this patch tried to solve here. The 
current struct aesni_xts_ctx is ugly. So, the main story is let's fix it 
before using the code for AES-KL.

Then, the rework part may be applicable for code re-usability. That 
seems to be okay to do here.

Fixing the runtime alignment entirely seems to be touching other code 
than AES-XTS. Yes, that's ideal cleanup for consistency. But, it seems 
to be less relevant in this series.  I'd be happy to follow up on that 
improvement though.

Thanks,
Chang
