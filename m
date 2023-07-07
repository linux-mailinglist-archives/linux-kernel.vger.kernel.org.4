Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86F874B8BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjGGVjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjGGVjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:39:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE811FF0;
        Fri,  7 Jul 2023 14:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688765949; x=1720301949;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OU5ET1Yq8NhQEa6+Tzjt9uKEhouKUerXRrPITb6mu34=;
  b=GnEcPGcaUDWmkDOgdwfWjMQoSpS50TlVcBHRfy9o1Nd20Qxf+/87iRRg
   fhJ+aKiAH0kNyzqIedtlEgIl9sNJ1Y7/fdTmBildS+vLA4gRLZIf0N1SW
   UHYOP5/NC0sHnksyI3r/oKjL76VDGmh+gWXN6M7JbWJHCxFlxFinj+7rb
   o6QLMk0crf9Ktb0p5/fbwthks1CSFfB9I7dQVS+AE1Ch6140YJ0ZzgABm
   cUmQDOJ5YEHtAn0e7EXa0he+giOmc5QCF5YF6wQiQkwyX17BCDsUGaITu
   BxJyzMqWc95tGkm99nuoKB+r9YL0hE1KvxEGJ+7ukePtGEiOIKuX2yX5R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="353836194"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353836194"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 14:38:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="966759580"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="966759580"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2023 14:38:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 14:38:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 14:38:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 14:38:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvOfeonBiIgqFjeiKgmu+ORFzoZo19LhfIrRdwX9VyAYQ1k7bzCGy9Emwf5ACGAvYdTC3DKQZmRa5Uo1IX28Rl7LL7d1O5WtZ6ppXzizMf6g6Cv0jDJ/U/0fT0d2IQdPNfSy376RjnowbFjDwyyIaFOOO+Pvgx997Cl5CueJBedLYT4crjIN7u8FgOVo6bUBXHvHG7lkKvTFarz7JnIXoKd1MY/Ee2Rh9o9aFpgZENcXcCYEhYTcWh+/+cRO6BgsufiMMEWseFM+EDVg7jbwivZ9dsEUJHAyaEtzTfIFSpu7SJy0Qz5bmjOUkD5/2aaVCcGyEgAkS9slRH9v9srcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGSSGt0Rxfr/kdU7dSNjR7LjIKEh6PFIaceaCI8pfjM=;
 b=FOq26mU868KxLwh7Ow7zsHaAOn32N9hPpiiEQ6cWi1y2D8h6GniHEWbq4piNyoAG9Ot2QSfMkJhDWspGuF8soWmi/ti3ArEOIbUXjzbP+YHODrHhOikUtDzyXTFOd7ScsfHSrDbMgIKr4i0/1EZWlFBm/9v2hp0AUaWnegN7P70TJXfeurAAit8byyHvCK0G7AMLnLDoiQvJAG9xHwBJ9j4psdNKjZqKMky6Yq+fTb64tHj/FUShge/l1xmWUb1kGPsg6Ws9gJ6FpGoPk6V/PrSp+vYgycjG8UCPKCnq9/FQqvID2B3oIMNyaTEkrfqzmDsarZ64Lo/ugczddrNhig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 7 Jul
 2023 21:38:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 21:38:52 +0000
Message-ID: <a7a184dc-5428-28d7-6f9c-f0b18c126324@intel.com>
Date:   Fri, 7 Jul 2023 14:38:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v5 3/8] x86/resctrl: Rename rftype flags for consistency
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
 <168564607296.527584.16017427105138548499.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168564607296.527584.16017427105138548499.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:303:83::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bef1d1c-c835-4c4b-d4cc-08db7f328e74
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WETmY8MJHs8W9FnM9sZJXUW/LGTP6ew8yt194g8LujiykusICV3fuURPtOBArxeT3JiTXV1gmOCbXb0Vwvv+39cuPP9yH+9Z/xphklHWQtHz8kqkxL78EEAyPf1idSH9j2FKxzPKQm3xfyOWjpZSabJ+mdKpMS5dEgZClP7sfmqKEI3oB/djiDjkKsxo+Ew4UN7MxUwNYMwRJpXG+ghm2EWad5RuFbZA/Tfs/8b/tIvPvpInAJSrZcyTQ/Ml2ftBPxXXGsilJUYtH0x7AUpedscsPP/6sBqkH182CMQCB2O7WR9BP1A2YFO/+UfhvwqTQVJhMENwPlK9yLduv1o5EwBMd0fHum0TZIV8dLNRm9ChA/WAPWTZArit1oMAV3q1gK30nFkD1prXYUaHCOjANh9b/q0zhSfk8RCx3wAtIHaYrs0VcnTMr90q0mf0VyrMn0fyMmpTCGoO8arYeBmepowNAFPi7mdOFb2hL/cp+i6EtSrHpRkCk7hMYnlDWo7Bjc5EjZa0vFxkVMXoegf+tHbtYCMMSVL/N2I8SowYCaRx9jMDsBZ4Mjba7OqW2lWIUN9AGiZtyqM6bU+BcmsI3A5qygblkO1ci9BroCy886fFiylL4NjrM8mgxRncuk90LbL66Zu4FRSn9nN+hZJlwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(4326008)(6506007)(66556008)(66946007)(82960400001)(66476007)(478600001)(41300700001)(38100700002)(316002)(2616005)(186003)(44832011)(53546011)(26005)(6512007)(6486002)(7406005)(31686004)(5660300002)(2906002)(7416002)(4744005)(31696002)(86362001)(36756003)(8936002)(6666004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTBnU2tLeElLMCtWNXA4ZC9jMTViNWNFVUl0WG5zVFlZY0RlMDRQOUdTNURJ?=
 =?utf-8?B?TGsrQ0FkMWJZNHVOcW04a2pJUVdXRGdDSGNDL0F4NFBTcHU4OHN3UlhhQjlN?=
 =?utf-8?B?R0doYngzK2s0OXk1a29CbWJoM29yZXR2Tjk3N3lWM0YrVjhYK2MzYlV1N3F4?=
 =?utf-8?B?ektJL2c2YXNRZU1UeDRsVmZiRUdsdDVKTnBUZVZtZ1AwdFM0RkEwN2F2RWcr?=
 =?utf-8?B?RmpxYkl5RGwyeFNPbVlzNUVjalRUZys5ZFRVY1dHSkkwQ3cyTmd1QzZaQlFX?=
 =?utf-8?B?bTBZRklOdUZ1aE5tOWp4bDBrQXo1TjRKQ1hWeXBlZFE2LzR0K1RzYkxTTklx?=
 =?utf-8?B?ZVJDUG5ZdlVVeUVPbDZPNWFCVDQwY2pWci9nVE9HMEFqVUllcEFxREQrejcy?=
 =?utf-8?B?SFdmT2xpWEJIclNVU01GSUxqWUUxbE1qUVlvbDlKWmdzRWNISi9aM203Z0U2?=
 =?utf-8?B?dkJkVVpWTzRBRGRFR0pUMW96K2FhUHg3a1cyeDdCbUEzTzF5QnB2emRkazQ0?=
 =?utf-8?B?MjA2NFVvbkZjaUh2dFg3Rm5SR2d5U1dxVkZNbTU2Z1ZXZHh2eXNGQzBVNlkz?=
 =?utf-8?B?Y3hkTkxaV0ZGcTZwbkZuWGF1aVFVSzFPK1VnYURKWXlLSlp6YnhjNlRuVkVB?=
 =?utf-8?B?Wkdkc2JEMEJnZGlLeFBDRlV1eVd1SkZPYUhwZ0FXSnQ1SkZxN3RJV3hOYnlB?=
 =?utf-8?B?bVh2R1JMNEM1cnlTZ1hCQ1ltY2hWMzMzczhreVo3cXRYbG5GZktNYWEvZ3dJ?=
 =?utf-8?B?d1FYWkZvQmcyY281ZDFoQ2ozai84eVdzQTJWZHRla2hOSmFhdktyS2xOMDZS?=
 =?utf-8?B?WjVXaytXRDhWOWhjNmM1VVRNNCttWlVBdkpBZU5mT05IV3czRjAxVTFic1BZ?=
 =?utf-8?B?WGI5aUZjQjFQeXRXUDVKVC9lUzdPQjNkVU5QWU9DQzU0VkRkenhHQTlBQVly?=
 =?utf-8?B?RWpNZHRmSzEzUkVUUGt0a3E0VXRnOVlHVUhDalBSeHFpZjNmZk1jVWh3eHFO?=
 =?utf-8?B?M2Z2RytKbThHbm1GM3hDeXVybjlkWFhETE1sWlJpZGVJNXZvd2tnZGFzTXVa?=
 =?utf-8?B?WnRqMzFlWXBSNERpSzgxSXdrRDM0cVZYd3BQdTI1aFpjVVIxYXNmQWN3eU1p?=
 =?utf-8?B?UWd6Z0R5M245blZxaWZlSG9BS25QaW8relRhQ3g2NC9kV1RKZi8xNGxPVGRr?=
 =?utf-8?B?M2NzeXFRNzlvWVZSMy9XSkVnOUQzaU5EcVZSb3hLK2tNdEVLcDg1cnczL2h2?=
 =?utf-8?B?eXk3MmU1SWtMRzVaQWRDdTZ2L2VtTG13dEZCaUMxWllDMHNuUmM4SXR3WWZk?=
 =?utf-8?B?R0tKY01qUHVVZ2VLLzZWMXB4eVA3MkZKZ3ZLMEJQSlNFSHpBN1pSa2FVUnZ1?=
 =?utf-8?B?QTlTNzRBNjN1NlVkcWhob0psQnVIb1EvY3dRQ2pzK3o3UTQva3F0WmNJUnZH?=
 =?utf-8?B?bjJLeXV3Sm5LZXhuM1hGWEVvTFZUNm5ZdFBzRWNLOXBTVVdPRmNwK2NGeTNi?=
 =?utf-8?B?RnJ0aHVlVU9aeEVqVVpISm5zckdlYVZSZlRPdWxzN2hVUDJXcXU2QzFrYUtr?=
 =?utf-8?B?NkxPbWg2a1VFb3JtRXREdFBPNU9hQnZtdVd1c3hwSElNWEw1aWFVSXcvRGlR?=
 =?utf-8?B?QTlPcUhXL2E4ZzYyUWtYbDAwRkliem9zSVh5MUhaNDJTWWh0NVpZOFptemFi?=
 =?utf-8?B?UlVvUkRjT2V0NVFNemNPWk9SK1BDTjd1TU56WEwyUUtSSHpwUVhENDFrd3Zw?=
 =?utf-8?B?UTdLVTJ3b1ArZGtTYVJzS2QwdE45dXZoRldGUFVjYVp2TmhoL3ExVUwyYmZy?=
 =?utf-8?B?TDBaTEdzd3lHYlV2QXptSXRNRHpXWXJBcVI5OGZFS3kzV1ZDTGhFcVl2Ziti?=
 =?utf-8?B?Ni8rL2VobjFEN2lmcm1EeDdmTGErM2djaWpyRVY4ME1BYUxQRzNWUzVFajA4?=
 =?utf-8?B?UUEyQUxhMElHMmVSVi8ySTVjMTFOdFoyWWtxc3NKdXpJcjRGQjIyUnZKcFE4?=
 =?utf-8?B?bE1McjBtbi9RdXNaTkFneXFMdlhHRkVOUTJQTFJ5S1YxZ1A3RGJwbkRLWkF3?=
 =?utf-8?B?S0h1amRYY01haVRLNVorS2Fybmx4VTltRjNCdUJmM2RpSEYycFVIR0V5UHd4?=
 =?utf-8?B?VHVQc0V4Wm8rK205cVRGbkVEbWNYNG5lWGI5a0FrTWJTY3FzaTIxdmlkcFk0?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bef1d1c-c835-4c4b-d4cc-08db7f328e74
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 21:38:51.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdDWaPiKO3RT1JTB7a+ZY+pVmcvbaVvRHjbB2roz4QIsdUSQT7REK7/yt3LPsobub3mBr31BkofVTnT7dVi4ym6vWgZAKLLhXQRgukKt1gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 6/1/2023 12:01 PM, Babu Moger wrote:
> resctrl associates rftype flags with its files so that files can be chosen
> based on the resource, whether it is info or base, and if it is control
> or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.
> 
> Change the prefix to RFTYPE_ for all these flags to be consistent.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
