Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C5D6068A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 21:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiJTTIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 15:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJTTIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 15:08:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4551D5549
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 12:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666292929; x=1697828929;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VmhNPjPQgog29CGSTtxh7COgETmlYgbHpKKeeYi1AwA=;
  b=SaTKkl4hg6dF30fu64d/tBsocV3UeZoDK/s+xr7JGeF9MUZ64edekwhs
   hUmnMo1xP48IAOJEN7Ef1pyrjWBDkRA1/7DCc/Tr8JCQro308n1NXuIEZ
   tYM4ckJN9yv5jw05vqwfEStMU+zTFrY3UEAak0HXAaZv9KrzZFWpAHuBL
   wAUtdpSTwwAwrw2+LLxECrZclc7lys+pui1BR0uoQlYNcHoYj9K+p6u6k
   CJdpmG/hkRVYRceTg/XKkRcl3CW9apdghSNc8yXnlXalJjqDr1dmq1/pg
   LVFqUm55dkNCbxA47TRCTyk2vns73N3xXKSJ7IkgJTtGxc1qn626NKWr+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="286534713"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="286534713"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 12:08:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="693190516"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="693190516"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 20 Oct 2022 12:08:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 12:08:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 12:08:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 12:08:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm047j7xoZfOEh4MJL+3m9hGOaMWSzWYLcQ8FvPlvv/qn4tbi0xhBSQTphTbuoLa6etHcz3HLilmtGc/vrXjxvIgf2WJma8v+vLLNtINgqb5a9e1tNJs9bVSqS66gHXwmXjORXMculwui4L0rFiE9xqwhMt5dvHdghFNTRdcl/+MPKbYSw497MOxI5ehiIdYq+HoD3QGGAA0Q+gtwvGJ9/Ibm3qw09VxHOsy2hG1EcRGqPHHHPGGTkWiG8Z3E+bxyRtgc5JUPAVP27Gc0B1RzB7nCbiNwJg/4f708QzlcwP4hhS1al8MYDcL/z/5mrEJ2aguwNDJlip2wKleQvUJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8vFDi0YhKPyKeMIwelp/URif9U0aodr2/MELQwk780=;
 b=IMgx4inMAq5TYgrcXzJrKBnbaHiRNPu7R5cX8BWzT0jImKy6kZDWBYbeLVaaZzw82JSdzejSSCBiJJR8kfh0kanSrbAiXLdj9NVWMgZxxD6byXA/kjBM1ndOxeLDBq+ytAksmifx/PFIXIB+9EjV93v8p6z7Hin+Gt7uKCz7xYftk/VCGYF11Ulz5H9XX3UUfsXjmnUH1oDOBNscTYXa5hTycPwY8MAnkxLZ7VJULITX6fBRSa5Fuj5H6j6eyIw2t12P73ShWZ/VK0Dno3ta1KpaTmLYK045rpHhtB3zX+zWNm/ekLNMuYP3OWaHXee7kefWnTU277Ql8+WCtS9fxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA1PR11MB6075.namprd11.prod.outlook.com (2603:10b6:208:3d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 19:08:45 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5723.035; Thu, 20 Oct
 2022 19:08:45 +0000
Message-ID: <da89ea90-8453-f848-38d1-a14195faa95e@intel.com>
Date:   Thu, 20 Oct 2022 12:08:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "James Morse" <james.morse@arm.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com>
 <CALPaoCg4zrODVoXF2y2b+LRYq_+jnV8yv5qB+T_3Z264cV82GQ@mail.gmail.com>
 <b931062a-1a70-2331-03cc-6bfa69a51bee@intel.com>
 <CALPaoCj8ps2YRH5T1eCRY-8MLwGi25cfbd0KNtjYXTq5baAXOQ@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCj8ps2YRH5T1eCRY-8MLwGi25cfbd0KNtjYXTq5baAXOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA1PR11MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 60512188-80ba-4065-a7ee-08dab2ce82f7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lc39VIiZlvO0eBfV6iMu6iORHWFXx/wKPPw5LHDVipXkKzHV6cHA/m69EVGB2EqjMWb/pwIjxOUojigXMYlerPfVQhieHxUPgL3K8QRTwNmqeuegCTe/LUXbEXhZhAPfRVMQywMUICSDIjjoEXDo1fewpO5cJfXAN5xutmiXJpy9l7EnQ6rYvnv+J0CdBIhjHAjARkr6AGMG2PgfuGxffLurkGdzzPCw+AhjAqv84wKwTr/2O415P2zhOn+OkFicRedd0LCtR/oNIHdiVk/eqECEj32Jh+kh95zYjSUV8JsfU35lDKfV9OUZAatpRgP68yjWVhLtUcwRhBiSXgy99aTkGyIfL2HbWozERGj4DL/4MXOxMJ9bgiNPBAefsdM3NAuSADTlJiW6y/yx54MyaJw/EKnBL1561aVIueUrUjqy2CJcj0ZhyoUoU20UIiPtDh8mcEvcXUQU4hx953WnSD/biMW+PJ/07TYfgsyxNdRiBSuyf22ri39G/34Gm4mYuGt2VP1U2YHgbt+4zEFTvUTon6AO5WZ52sJnQwAeFQtRgclDvSB8LJLQ3PkFsy/kvwTffxKww0V4iYPeCrlUE3qVF3sxAfa706pxQUHADsCFDd7pxd5C/W1aGBElkAFbGBF8u3oeSABbP/63AXgpSq/gxKSoiicEzBexrH8S19Ew6Z6ttiH7VXNlLLWR3GwX3WyBT2LfJT+eCCLAatmnv/ltXYdRA431TAwGu2BdmuDCiCIz2NVDvx5nDeqcZD08EGxMYHXCUt0IYjgyn/r1ETM7Cb9OSEUtOnpN+N6Mm3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199015)(41300700001)(6506007)(53546011)(38100700002)(8676002)(54906003)(26005)(6512007)(66946007)(66476007)(6486002)(6916009)(66556008)(86362001)(316002)(31696002)(2906002)(478600001)(4326008)(82960400001)(36756003)(186003)(83380400001)(31686004)(5660300002)(44832011)(8936002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJlUGJaQ0NNNUZPdlRmS1BITVMzbXp3aDVZM0FuOTBQYXJYaGZFQVQ5VUJp?=
 =?utf-8?B?MjB0M25EUTFWNm04QUdicGRDeHVMOXVOY1lEZHVLR2xwa1cvUzFPU0dvM0dN?=
 =?utf-8?B?dGJJY2RsZ0E5U2xBYmpBbDl1UnFsa0d0Q0VteGt3ZU9STVEwbjd3cjd4LzZ6?=
 =?utf-8?B?WFVWbHBwMmp2NU5WNlNaRnhSdXFLMDg4bmd6dXEwV051aW1RZDJIUnJSRVdw?=
 =?utf-8?B?SEhXeW1oV1VYeGszY2hkOEF6Zk5ZcnUrdW05ekFHTXA1bThaRjNkWkQycGli?=
 =?utf-8?B?SFRka29GKytNNGJiSk9VR3hCNS8raFNsS3BzcGVkQXk0RWU2OERJUWs0bVp4?=
 =?utf-8?B?dExlbkRaL3RTS2wvK1pYeWdqUUJLdGNoTnlOZlZRRGFReHhENURFM2IyUDBI?=
 =?utf-8?B?eGFFZ08rOEtzT3pHZ1hCdDR5V0hGT05UUUhzS3NlcGpSTWRZejgwSVVhVEJh?=
 =?utf-8?B?bEt4a0djckdBYk8rWitZTVErL2tDd016SGtEYW5MQ2VUajkvZ2JjMHdqaEox?=
 =?utf-8?B?SlBweThza1ZwMzc5aTRLSVVteHJDOE1NMXlqVG9leFNuYytFV0FkbUpCSlJE?=
 =?utf-8?B?S0pSOEtUbFhLWTIrREJ1VVVaNjQ4TWhhMWx4NVRPSFpJcXVESGRZSGFjNlVS?=
 =?utf-8?B?alQrTmpkZXRUMUVMaU1nazNPa0w1aXdaNStYeGFrQUF4NTh3WWFGcHhPbE5I?=
 =?utf-8?B?TE5ib0ZvazJYRHdSa21Ucm90aGdnT3hWUkV6SFAvNkhWTTJVUXdXbEMyakEv?=
 =?utf-8?B?dzJHQlBrMThWWm1GK3FDbjBNb01MaTRIZUEvR0tyWkQzQlNhVWJkQ2dLbUxD?=
 =?utf-8?B?SmhSOVhxYmNzVk1CaDRKRVVPSjUyQ2ZtWmlwSVFJVnB2S1h1Snk3YUxNTG9B?=
 =?utf-8?B?ME5ob2NBekdFYjZzdDRQamxPRHlTNnlWYzN1eDNUME90bnpqR0txZnp0N1NP?=
 =?utf-8?B?ZWYwZWU5TzlQakF2anRZSUZpWHArZjBHOFZoOUZMV0lIS0IySy95OEM0d1cr?=
 =?utf-8?B?c2dPOW80SU1jS3pUdTNXUFB3Y0tlVnIzVHNlcDNjUE5nbFZxcEM5Sm9aV3Zj?=
 =?utf-8?B?WjB5SnFoK2VPOVFvQ1NaNjNseXhlQmFLMENLM2FGZDVsc0pDdTEyempaaUZU?=
 =?utf-8?B?c0YweVJXZkpmTGRMUE9BS1pKNG1VaFNISnhVQW1TdFJ2MWIyWFZxUHBCQ2Ri?=
 =?utf-8?B?NUoxQ3NVb01rTXFmaFJoVU1Qa3kwRFpwUFZjT0Ryc3JLaTRVcDR1dERLMjVM?=
 =?utf-8?B?UzV5dEJUQUlzTUpwV3B2eU5wbEV0ZkY3QUcrUnZhekJwRHY0VUVvQjd4RTNw?=
 =?utf-8?B?eDZrb0hxKzVWWkViOTh2YUw5NldYYU1XQ0dlZG5SREROZDdVNzFPUFpIcWVw?=
 =?utf-8?B?ODVUd1RXdXFTSllMa29DQkdGR2dUWXltaFhHRWp4Z21nL2c2bDhvcllPV3pN?=
 =?utf-8?B?K29uek5hTGlXWVorRGxKcnZHQk5QazJ1WGE3eERDajVsNUttblY3Q2ZsTWtq?=
 =?utf-8?B?dE00UWlMcHZqZElBdHNPeVpwU0RpbGp4OW93VnBPZnVOMFFQREl5Ym5HUzlV?=
 =?utf-8?B?SEw0bjgwT3Y2MnRYb0x2dStwZkd4WkplbUdlcWprTUxNS1A5R2xIZi92d0Rv?=
 =?utf-8?B?QzdKbzhDc1BTZkJZMjBuU1U0aVRHQ21VNi83U2ZiYlN5L1YvdllpVFFWcWNK?=
 =?utf-8?B?ZFB1WEY0SWZvM2paTDBTTXVsYk9MaEtGS1FFelVDNFROUE5TKzJTdTZ3eXVJ?=
 =?utf-8?B?WDl5RFB2SmgxT1FtdW9nQTN5M09hdng2THFLWDVOTkFIWkxPUXFZbzFlcU5P?=
 =?utf-8?B?QmIwNHNOZ3FuS0F3UlR4RjZUTElja3RaczdnRjJvcFlTMnNmL2k0WWZldnZY?=
 =?utf-8?B?U3hHWTFLeDR4dDlEbnJoeDczakhnVFA0K0NhQXEyNW5ZeDZLaHBMYnB5NzVU?=
 =?utf-8?B?VDZSZXFvdkhyY3p0Ti9HK1FHMzVzTEJNQUpoQmZjSWU5c1dBNXZudnpwUTN4?=
 =?utf-8?B?NktLM3NNblR6QnBhKyt2aFpiMHNMcC81SXZMSVVnSFp3M2R0akw2UDNYeGsx?=
 =?utf-8?B?Q29Jbm1Cb2ZmU0x1WXd3bFdLY04zTnVpZFg3bVpaZGYyM2lOT014Z0t0SGYw?=
 =?utf-8?B?dTBPNXhOTkRQNzBNWjc4WTdtYkhYcFY3b0Y0S1dMZzlvV3NCZUk1ZXlPaGJa?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60512188-80ba-4065-a7ee-08dab2ce82f7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 19:08:45.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wr9quJWU7B/89F9qqbOr7cWEisIKAAWbXqNGhLBJ5V/gvPkj/zBS56IkSS+4brvStZgeMD/HdTTgJZ/TgugZwSr4LvFJmZd0a4ZSZ1i5sDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6075
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2022 1:48 AM, Peter Newman wrote:
> On Thu, Oct 20, 2022 at 1:54 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> It is still not clear to me how palatable this will be on Arm systems.
>> This solution also involves changing the CLOSID/PARTID like your original
>> proposal and James highlighted that it would "mess up the bandwidth counters"
>> because of the way PARTID.PMG is used for monitoring. Perhaps even a new
>> PMG would need to be assigned during such a monitor group move. One requirement
>> for this RFD was to keep usage counts intact and from what I understand
>> this will not be possible on Arm systems.  There could be software mechanisms
>> to help reduce the noise during the transition. For example, some new limbo
>> mechanism that avoids re-assigning the old PARTID.PMG, while perhaps still
>> using the old PARTID.PMG to read usage counts for a while? Or would the
>> guidance just be that the counters will have some noise after the move?
> 
> I'm going to have to follow up on the details of this in James's thread.
> It sounded like we probably won't be able to create enough mon_groups
> under a single control group for the rename feature to even be useful.
> Rather, we expect the PARTID counts to be so much larger than the PMG
> counts that creating more mon_groups to reduce the number of control
> groups wouldn't make sense.
> 
> At least in our use case, we're literally creating "classes of service"
> to prioritize memory traffic, so we want a small number of control
> groups to represent the small number of priority levels, but enough
> RMIDs to count every job's traffic independently. For MPAM to support
> this MBM/MBA use case in exactly this fashion, we'd have to develop the
> monitors-not-matching-on-PARTID use case better in the MPAM
> architecture. But before putting much effort into that, I'd want to know
> if there's any payoff beyond being able to use resctrl the same way on
> both implementations.

If the expectation is that PARTID counts are very high then how about
a solution where multiple PARTIDs are associated with the same CTRL_MON group?
A CTRL_MON group presents a resource allocation to user space, CLOSIDs/PARTIDs
are not exposed. So using multiple PARTIDs for a resource group (all with the
same allocation) seems conceptually ok to me. (Please note, I did not do an
audit to see if there are any hidden assumption or look into lifting required
to support his.)

So, if a user moves a MON group to a new CTRL_MON group, if there are no
PARTID.PMG available in the destination CTRL_MON group to support the move
then one of the free PARTID can be used, automatically assigned with the
allocation of the destination CTRL_MON, and a new monitor group created using
the new PMG range brought with the new PARTID.

There may also be a way to guide resctrl to do something like this (use
available PARTID) when a user creates a new MON group. This may be a way
to address the earlier concern of how applications can decide to create
lots of MON groups vs CTRL_MON groups.

Reinette
