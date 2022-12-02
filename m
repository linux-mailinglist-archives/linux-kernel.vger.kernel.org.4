Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6D36411BF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiLBXyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiLBXye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:54:34 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38629CB4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 15:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670025243; x=1701561243;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uj47gCXedWT75BC27diRdKSGF7kExun8JwFcjpe7pdM=;
  b=OrnuzC0A4xtXVMF+EoJDmXOY83N44JSePSvbNqvLjKzcqLDIVa86OWrn
   tnNdgeECwJFNogVcB2FsYiC8LZb47uVQ8TIhzGS1kMmMQRjVQyuQ8KKoT
   CTb3CbfKX42O2xdrsu2fPCtbt5zglvaB1n2gNP4tvD+KKYfANbu1bw+0U
   fqkjcnGBA8YWujfyeC1URpwWwmTR3M5FTxlljd7ftLfP41YnuJlu2Cve+
   rX0NYaE4dpSWMvWvbunYMYbuTqSpYqJovxvz499KveIQ9Vynpx2AahuJ/
   bhqa9s8+lRNAUkPGYeXTd8CDev0+uNs96Y3/FAWQngz5Q5RDL3l+n8sDW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314777096"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314777096"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 15:53:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="595614963"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="595614963"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2022 15:53:55 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 15:53:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 15:53:55 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 15:53:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKolMweHpCJ+2bbrWeA1p8QO0ve7fg9SQoyybQ37YG86m05vWiF0aiOI/igq2n17TmtsRrXiBxwOZMjte5BeIc6m/P9Q8MEBrYAJrUJ7c4VjjFPAXJOIJJIDBkrF200w8XyWJqsDnjrDmLBBd6miJgo3L42Wkq6zx7FfMbDJ2/RyvARvjQzFxc73BcUzCTQx4R2rtk99G4MKd0rs0ohqahXiKyFtRjGdbfPZwafBUU5pedNNqjj67ZlAxEz+JhoKvhAM3LMLslEczBVYDNLepV7zAvMUi3/1930ztyDYkF7KjijJcyN6TR7SgSSqiI4MIQF3UC1a+gmFtlW2gs/99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOHhZagxBNWHheEDKUaVGrPOHZRfeY84vvwFjXG+5kY=;
 b=VnHWJqjF7e3XCjQmsOuTF1ebLOMMSWYbCZigN8knksZ/DXF6wGbvv4i1w5O7cZWQDh6v+BgskHr3VZNYUJMeIkf3J/lOhxJlqSgXpZ/eTtr3tUBNVf/iiKjnzccG8rSsukKhZ/yF6qt1QuXuafC7p7Q82KIOgHTT8XQPE7qrMeXUGa/0clxyaOl9D4AHSRp4cPoAuiwgI8bJkhLycSYiA5XD26AOqC2Z8t/kBqx38aS3GW7GFJvDyjQKqWpytxiy0o+q/X9JkFTw/tHg66IB5XEGEM8dxFBzrm4YlTXcQBO02cCqh5kI4hF29QJG0qwojqY2qQpVP7UBWJIktwoRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 23:53:53 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::df5f:dbe7:6f49:e5d4]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::df5f:dbe7:6f49:e5d4%4]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 23:53:53 +0000
Message-ID: <baf496c4-afb5-bb89-02eb-17a319618833@intel.com>
Date:   Fri, 2 Dec 2022 15:53:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [Patch V1 2/7] x86/microcode/intel: Remove retries on early
 microcode load
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-3-ashok.raj@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221129210832.107850-3-ashok.raj@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:74::18) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ0PR11MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 07080afb-d7a9-4a9b-dfb4-08dad4c077c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9uMG5BLondJ3Tsu/M+fCNOZ12II7PodUFdrQiWNHoCG/2j1/lnCGL9qVl3N9MGcUukO6+DutrFT5kN4TGAkg5v7iKCmPE3A2Ob94CcombcCsLuAdLvaoALFTh89pp5vzz4RYhCPLrXz81+8kPPivgM+Wv54i5onMIF2n6cgJaeZhErEDHkCcM6t2D12I+aZ02N2FHTYJcOUQWCev8NDCbvZRPtiBIgx4oaQCkdOlje32jdINYiKVtbvZ7Eb31jXem+wgDi3N5iU7C0sv9823koxtLAooi5M0qoZtOBl5V8qua1IceDI75A0udCzC/NIXLXRdoxqCY4FQmeB+Ji0RGkAa0h36eVmIgSnaRUk4+ni6ul1MTSrV6zX4K72TWa5L+qhSCBiYBqmJEXnjT8GdQBFFh0yM20VWtILGtko81SqCgwAUOXHHzSCZctZayp2VzaBi00ofxLurYL6l2t0p87xd3tyqMI2VlBaTs6rAco5+5L97ME9NUykR4dxclaMFfZlHSUcXDZ1AQ1BtkRGz3kb2P3zA41qhYYapGTzmDpzNE+LVXujIoMcsnUBNLpCJyjQpnvX9fnfrbZ7x6UpXukcYodbmpX6HJW707WSEmqC+/GsXa8oyqg2r4HoSYA7Ya5ukurMKEtkFoE+Tx7SCeBLcTqd6NTEVE0cUP4KxpYTarc1J5VKHQrHIl++OQAf7f0l9mW7P2TxpOTTwimRlTVgiTicAON9ZOBt5jTwbehA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199015)(36756003)(6512007)(82960400001)(26005)(6506007)(66476007)(86362001)(66556008)(31696002)(6486002)(41300700001)(53546011)(478600001)(66946007)(8936002)(54906003)(316002)(4326008)(4744005)(44832011)(110136005)(5660300002)(186003)(2616005)(38100700002)(8676002)(31686004)(107886003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MElEKzNnc3R4T1gvenFZYUhPUkorQVZmUXV5ZTRldFU4ODc4OTB6ek5BMllO?=
 =?utf-8?B?c0VVTUU2d2lFYlUzR0tpWWlYM3d5ZlByUWhnT1RRU1ZpNmhjd08yZXA4ZmRj?=
 =?utf-8?B?VGRHckZsQVdRMGJCeTJrUmN1RXNqZnYvWTUwZHZBY0NVN1BuL1NhZmRacnl5?=
 =?utf-8?B?bERIdndGRVJ0SGlDeEZBdjZxZmJIdC94Z1pmZUxKNUpCOXZSUDRWU0txNmZW?=
 =?utf-8?B?MWxBcGduVEY5RHdQL3VmTGRFZmRNeGpHYmUwSmxGSmVqRS9CMHlMOVlnT01L?=
 =?utf-8?B?Y0EwZUxGV3RFWmJueXAvb3BHM2c5SHl5QmpDL05SOXJTcTE3MTEwUjdleXhE?=
 =?utf-8?B?ZVd0aEM0SUdjMUdWaUN1aUp6YmZwNkcrbmZpbGpyeWZpMzRNUlROVUc3ODlQ?=
 =?utf-8?B?bmpQKzBlK3lHS0VNQWJ2a3VkM1hFUkxwRmYyT2wyYmlDSVRZL0ZJVXg4RW1F?=
 =?utf-8?B?ZmJ0ZDYzd0hZR0htNVhXck0xTmx3UTROMVhmL2VpeDdGbEcvQ0N0Tk5jek8x?=
 =?utf-8?B?VWtZVzFnQ3V2Q0hnbzNWOFpNQk9taGIvVUxMbWRYUWZwbTJFaXBLSis1NGJq?=
 =?utf-8?B?YXhjZDVUNG1sWVNUNTNrUlVaMXFDMzlJNGxiOGNvcG9oWVRVaUtiRU1LWU1I?=
 =?utf-8?B?cnNPYit0U2hVUEF1K2FMVXBkVFF3VG1TemtJYjU2K1NrN0kxQjkwVGVIVjJx?=
 =?utf-8?B?dCtJS3BCMTlGMmdvazFaUFMrNWNhclk3RkNKWkJvTm0vc2tLRUhqbEZrS1NP?=
 =?utf-8?B?bHk5RzZSOXRtVUpiNGNKVEl5R3Q3ZEp6cHBSWmZMZXdwellUMTFxeGxwd3RE?=
 =?utf-8?B?Mm1KSzJCZ2I4S1ZuVHZUU05yVUJBVUMwU29wZzhpaWlJR0tnRHpVM2JtZXpp?=
 =?utf-8?B?L2NXamZXNzJ1dkxLUjhxSUFXZHhHOGFGSjIyQlZoSUJiM1gxdGpLOHJiUk43?=
 =?utf-8?B?a0YxWXpNc25KU2tYcDVNazdXYjhIQTFmeEp4b3gybzJHZzF5K3hMb3Vnbm54?=
 =?utf-8?B?Uk4yVzYvV0RrcHoxNUFXTFpLdW9aU3llR1hyUU4vRUdjWEdnYjczL3FrU2xR?=
 =?utf-8?B?bldBa21CZlBLS0hiVWZ5Tjl1TDhnTG5GTTZXakU5NEtiTTErMjNlZUV0TFFG?=
 =?utf-8?B?WllENzI3TW5HNG5CUWEwVmNKUXVrcWdWck5JNWtqdzZOSklxaGJScHBQUUZD?=
 =?utf-8?B?QVpOcXpBTkg1c0dZY1BnQ05YQ1R2eXh4KzBDQU5oZDZNd2VBL3NEbGhqZVIz?=
 =?utf-8?B?cnBlMW4yT0IvUHVMUy84ZUhLbzNhTFUvaDBNYk96dHV6aWR5NGxxSksvU09Y?=
 =?utf-8?B?RUpPd2xUeER2L1hqNGxWYzJ3VXVTWURweWVuT3hiQzVkRG1ySDRGU2F1dFBk?=
 =?utf-8?B?VTZzMTV4YXkvQ3RLSVZXcFJJRnFidkVtZVFmVTQxcHlIZkVYODBFNkk2SUMz?=
 =?utf-8?B?WmJSa1FmZkVkdVpEVExUUTRzbzdUWkluZVE3QUNIczlCem9PdWF5eVI2aitr?=
 =?utf-8?B?ZkNmTThqRGU2dllaSU9ncXllelo3NmZsV3N1ZG50RFAyUUdNRGhGZUdFb2ht?=
 =?utf-8?B?cktDQkZUaVA5T0Y4dyt0Y2R3WStidHM3RjZBRFl3dUEyTDYrTldOdHA3bXpJ?=
 =?utf-8?B?TWhvSUxlTVppbm9IaWtkem12ZmlwQ0xQQmpLOWh4OFNCc25jbDd1M3M2eXZq?=
 =?utf-8?B?c3JEeXRncEJYRzZXa2d4VHZFVHBETFFhTFlHbE1pWjFYS1A3d0h0Znd5SFIx?=
 =?utf-8?B?RDFDaXdMSjQwYnpXZmVIQ0pnd2N1SWdINzl5a01Wa1hwcXg0NUxUZTVsQXpP?=
 =?utf-8?B?djg1dTF3NGZPcmtqR1ltQklMOTJqMlg3SXFWUFlEdjc1ZkMxeXZPSFNkcWZH?=
 =?utf-8?B?L3RWbFJ1OWRnLzcxRmJpZ0xBS01QZ3k2Q2M1ODZveG00NVdRcDlkM2xiRlVU?=
 =?utf-8?B?cGlpNDd1VWFGYUhaMVk3bHcrKzNCMjVCZXZ0dmhUdnhWcUZwaU1WQ2xuK3dM?=
 =?utf-8?B?SjNtcFlXUk9BK0hHSjV5U2JrdlNHb1pLa2wxYzJPczlGTnc4YXpRL3FHMjlS?=
 =?utf-8?B?cG9kL1psRmlSSThrdlEzZFBNRHRTYWo3VTloMWdzTVJ4aTR3QjY1aXNXVEx6?=
 =?utf-8?Q?XD/rQSx0FEPoShEm2aFSp9seM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07080afb-d7a9-4a9b-dfb4-08dad4c077c0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 23:53:53.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UA4Xd6+DiQNpvMtKBTDAXeQ8jE9vIWfBPbBReQ97uYzngKPYHDVcVicTfX42kUxInFpGXRjLtEaI1rDuFYzuwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5866
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/2022 1:08 PM, Ashok Raj wrote:
> -
> -	if (apply_microcode_early(&uci, true)) {
> -		/* Mixed-silicon system? Try to refetch the proper patch: */
> -		*iup = NULL;
> -
> -		goto reget;
> -	}
> +	apply_microcode_early(&uci, true);

After this change, none of the callers of apply_microcode_early() check 
the return code.

In future, do we expect callers to care about the return code? The rest 
patches in this series don't seem to suggest so. Also, the expected 
error printing happens in the function itself.

Should the return type for apply_microcode_early() be changed to void 
(in a follow-up patch)?

Sohil
