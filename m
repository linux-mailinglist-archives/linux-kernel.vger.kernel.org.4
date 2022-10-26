Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4267160ECC3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiJZXyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJZXyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 19:54:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02139EE887;
        Wed, 26 Oct 2022 16:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666828447; x=1698364447;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T+LgI1JUlHvc7tjHSxOCdtnk59V9xJoU1Dej0xncIs8=;
  b=RCHpuCxzj796GdnQoLmPaUlE6HWAIPQRgSN1VPJPxYhp8JcpV3MeA/XI
   8cKn1G9W0DOCsLSzQVTCbHGTOuNxjvNduwRYmBzRS1HAXl+0t0SZdTGmC
   AtHxSyc37iZQd5CRhMgS11umjsEsHomdP/FQDtHlcJAFsob2I9VGzIwwH
   Koq15Tp9B0FnzcOOoxSNq8fRAxlWRltz3pT43oL9E8pSnUtrWPyKpQx7S
   hrHiG1+GW7/elcQ8M97DYOTz8y7+6rfbJkq941FGhuW/lM6b2asj7+1fe
   XHWtUFYRlGeNgKxPsIZSbUUMFXqTUzjv6B8VowkrfEp9kf0hVVZgYg6H9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="309784096"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="309784096"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 16:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="695581286"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="695581286"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 26 Oct 2022 16:54:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 16:54:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 16:54:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 16:54:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHu8FlFvuYWbBGjvuuG3+aYzazR9UKk27RDy6+oqPVeAmrNHJlAtv77Bc/QRANtGf86OKYLzBv2xL6F3h7kzyKvnQJfV3qbEgB/06GX/ajE9HWnusDrGDOqoV1147tFK4vL8znuziWS98nn07wGjDBSO66xWnYFs1CR2FMjYwWzCShiZb8tiyJQceRIErRNRBZvm+ZQCnNO92pGr3ibITOQNyhKSRpU8vwlOrp8nWB0ALc0lI+cM0068pQN3cy0u6GMyfFU2RSQ0ne7WRribD/2XNctBHxc45j6GuiR/M1mv3KEIGmUt7Z3/3ncUey5kyroK2FhFXFhUEeXGs2Yosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEzKrHIqc7tLSA3zzUhwux9BT5S2BunDy+9kUGHiKLc=;
 b=MlnLXWItq1nBXnOAba6S7xduTSfI009bD4iqHDIAdWSMwethqx650SFT+Jdqb4yrPfGS78VHeO9lRX2nSO2eTM2nTGWSu56XEGHRtod9bj2Ncyq1zposZBITpidFCTIFm2StQ7hmNfl42csiJ1/ls8YfMEuIvpQQUbrJiG+o9OzrpxUpL6Fu8qc7kAAT/6EjpZWeFD/xyQfMXdF/KWs4j3vODvm8WdCVtD4jg4OehMw/Hsm8LPjXXJFnPKSZCeOAetqqwIZdgh6ZsSADYrmWa8zJdCpc+Aubzp7tybHf2w15l7YE9GBqDW8BAepYN3uEqbFTqoGUYYHN6jZK0NwTsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by PH7PR11MB6721.namprd11.prod.outlook.com (2603:10b6:510:1ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 26 Oct
 2022 23:53:57 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f98a:551a:1689:d091]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f98a:551a:1689:d091%7]) with mapi id 15.20.5746.026; Wed, 26 Oct 2022
 23:53:57 +0000
Message-ID: <4661da30-7e0d-8cab-ec55-9f963df5a582@intel.com>
Date:   Wed, 26 Oct 2022 16:53:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 04/14] platform/x86/intel/ifs: Remove image loading during
 init
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <markgross@kernel.org>,
        <hdegoede@redhat.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-5-jithu.joseph@intel.com>
 <ec2a2799-9db5-8810-7a41-f9f6ca1b360b@intel.com>
 <2fce55c1-20cb-39c1-52ac-d9b3e2247296@intel.com>
 <8cc37fe6-86f7-bc0d-8bec-e17b061795b8@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <8cc37fe6-86f7-bc0d-8bec-e17b061795b8@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::34) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|PH7PR11MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aaa8ce6-60d6-48e5-5af9-08dab7ad58cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6UxcZVWNyBjCZR6fqR1l0UkzycUE6wVsif72wATHuOhGNqwg13wy8mWCMfYCcHXfBIU7m2HAKK+oAeHypXkYahszyHS90Y3Q71ud4pty789Ge16JMQmJKciTHpif+hHiLi6TekwyFYFSR0TjOLDNT1Is/8gln7Yy+DGMnp0hOk4abxt8pl59VGkh0N6aVrIN9GmPf/uc+4aipNsR4ELpTHX+DOObHXoQ2kM/e1a7c8CSRoJkbIdGr5ARZWG7DVO8iXQEc+SxzDVH4quqbmpREi1SJFTTLVy8sw9TfLFGVqA/mOcM3811QgxmorZ9paCsh5VeYDUxhsPzgFg/tIqWMk+2/wsYSTVwiDBuh7iZ+9KeTmjhZpV36L+u1Ey5u2BdwFU4VL3TT1eJJ/z95xBL4xbzqOEIZwVmhWoCthlZNR611SRUQ1C8S6bhPVT+L1Gj9oeN2s6j1ldJ/jQToRbEwtkyT+s8lHlkppefcvJpJMZPSD+dOKr27ss0gQzAqUfbTOSdwLgHlGhopOQh+tc/ep4EywHH7/BINgoB5Y4sVnx52l9XEPc1PrrzMf07LhnABV3ciFLpxfZ7D9AULkFF8BQIL1hD8aqGDwfmdtBdwmHSfg85RtppjGAAuPvhbIjjfHlWWG0hRa11KZyeMCwTNxD8a5Sfb2Pwxec8C+iFIzpY0PUQU/QKRC3XIogkEd6+juSPAc5isK1fRNl/YG4u2XxxEoh/wmt7Idc6TYFOcncTxGM9nL0i3Ha4l7Mi3JcCI7LAzjzGjQ99cUm0Viz3uL/UG4xyyKV0B40u8+tlG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199015)(31686004)(36756003)(82960400001)(5660300002)(66556008)(8676002)(66476007)(66946007)(7416002)(38100700002)(8936002)(6862004)(83380400001)(86362001)(31696002)(6636002)(37006003)(316002)(186003)(2616005)(6512007)(478600001)(6486002)(26005)(41300700001)(4326008)(53546011)(6506007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjhTYjVaUkRaamNwa1BLVllmdDBZY2ZGT0dSMzJ1aHBVd01uTFkrV1FlUEgv?=
 =?utf-8?B?cnNqTkxrSXJKMDhYNkdFZkIvNXBQbGZQWEFZTm1sWlVQOTZHaEk5Z3ovbG9h?=
 =?utf-8?B?UnYxK3paN1g3aU9ZdUlNQ2xiK2hvVklpUjB0bDBudjRVSk91RGFNY2ErbUdx?=
 =?utf-8?B?VG94VWRnQXVqZFZWWlRRb1RjUExUdUhKNWFqQ3ZjVEZRR1REcW1Da1RXV2k2?=
 =?utf-8?B?ZEcrTGlRY0lBbFFPYU0yaEZoNWxieGlpa2VqVStGWEJuaVlBaFVCaGRKN3Bx?=
 =?utf-8?B?Zk5aUFYzL0tma21XMFNNMHNJaFhQL2hUK05rU0p5a2d5Q3Jac05nT3AxYVhI?=
 =?utf-8?B?QVY1TkVURzlSdUVEcm5MSzUxRFNSTEUyQ1RZemVYdWwxOHgyM1YzcmdVV0ZK?=
 =?utf-8?B?aDBNR3BtQVNKbDdWbWFoelV6d0hsb214ZlZ3TklEUitIYmEzWElaMVNlM251?=
 =?utf-8?B?UTBhblRDTjFvRnJCeUVxUVFJYUFlbjRUL0hqME03VU9ubHoxa3VUUXhUWmxM?=
 =?utf-8?B?a0drTmZhUzdheVN6WHh5Nlg4LzVVcWVSWU5lS3FpdHArN3g0MEFHQ0F3bjBw?=
 =?utf-8?B?c1RGTkQ5d1cyTVFmVjBrekRXYlF4bXI2YU91RDRVT0lOZ0sxSTRYM1pkNk5Q?=
 =?utf-8?B?VE9OWThtTG1qS01oVWpFTjBhN1NKdndPR2hNSXllemlUdk1LT2NGYU9qTTdB?=
 =?utf-8?B?a2ZTc2NnYVFLYmYrZ3dIYy9JamZWTTFmTkM5ai9JT2x1QnlsK1RPUWtSRGNG?=
 =?utf-8?B?bnIxTVpQbHY0K082Vk5TbXpOVmlJV3VGeGlWcDlrNEVTc29aT3NmR2c4TThN?=
 =?utf-8?B?SllxQXZPZ3RpZGZGU3ZpdDFVVFhDVlprWWx6UTZoQVN1eG1JblViN2JQZlUv?=
 =?utf-8?B?UVp1ZDB1bkZMdnUzVG5qWVZoaGFFSEdPQVgyTDB4QUtXSDNUQzNmczE1RzRV?=
 =?utf-8?B?ZmdKQTN1VE92MEdFT3ZVYmN4alo4RHdJcGNtUlZUWW4zTzJTRGt3dnRyZFll?=
 =?utf-8?B?VkRWUEJQdlVzdVBnLzNIU2FsZXdUYjAzdXJqcVV0d3BEeVVmUmt2SUVrV0lZ?=
 =?utf-8?B?cldpbHJzWmYxTVg4YTVIZzFZSkVxcGJBRGlWL2laMEVIbkhpcldIL0xHbldD?=
 =?utf-8?B?SEI3NHFZYlJUbTJDRVN2azhhc2tmVlI5QnZmNXlJWHpiVFR5MUJFWG9zRmlS?=
 =?utf-8?B?VkdoSU14RUJTZ2VIQ0xETjhLUnBrd1pQTEZweXFwTWpiYmVPbEVQMjNtZW8z?=
 =?utf-8?B?R1BEZjJjQWJ2YnhjUUcvc3BnSThYdUpTdkJPR3NJdWd1WjlHekhETkhuakpQ?=
 =?utf-8?B?OERzNlkycERXamZwalowUDJ2eVVtam12TVRoWDlRdmpzTkpvT2VJbUcxQ1lY?=
 =?utf-8?B?QkQvK0FpZ250Qzd6cDg2VzQ1NCtmVm44SVYvVCtDOXIyZkhTN1pkVHlJbVZN?=
 =?utf-8?B?SU9oUHQwYS92dkFhTzdTNHpJQVppbEZGNHdVN2RzcWNlS015UW0yZHZYNStj?=
 =?utf-8?B?blVkd2orOXBlV1FOeWdpMCt1cDIzKzBtOXUxeldadjdYam4xSEdYQUJyQUIw?=
 =?utf-8?B?NWZZMkpuSC9wTDlPWmFSZ2FpTDVpWDJXZ2VrdlYzdTdpRmxzWGNvVDBPeVQ5?=
 =?utf-8?B?WVFWV0ZzVjNpQ0ZVNTVURmJQclN3bXEycWFMWFdCREFleVZOK1IvaGhJQi9x?=
 =?utf-8?B?OG1IOG5JYWFVSHdVOEJhcWg0dkFsanJmeG41a2szVWlvU1lNSlhmWE1EU21I?=
 =?utf-8?B?bkxyeEJtbnJrS0h0NjYwZTZSaTlCNVYxaUN3aVp2ZHkzSEFtL3JKd09SS1lm?=
 =?utf-8?B?TTJqWUlYaFZTN2E2Y01nd3ZKc2QzdDBMSm1GWnRPTnNYdUdBZzBSdXlWQkcx?=
 =?utf-8?B?NDZBTVYvcDdSNlVqTTR0SEIxby95Qi9ETGRtODN1eWVrWGhQdGRFbGRabDZY?=
 =?utf-8?B?R1gzQ0M2aUkrZW1ReTdiYjloUUY4ekUvNzJHQXNRNHNMQWtnNTViSXRYT0ZF?=
 =?utf-8?B?SThtQ3RQS3BhdVZtanZCL3lBZGhwRVVVMWlVSVpZaW5Salk4YTZUeUw4S0NR?=
 =?utf-8?B?UlRQTnBtUHI1dDd2ZVpkUlVBWGszcjNDU1VNRDM1MGZFWkRJU1YzZ3hucnhw?=
 =?utf-8?B?ZGFlK0NmcHMrMFNxSmJNTmNJUXlWOGNqTEhGbUhBMXB1andWOE1Ud2RuYU5u?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aaa8ce6-60d6-48e5-5af9-08dab7ad58cc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 23:53:57.4609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQgnc2p7Qko96saJIvDvd658K8JYL6XHjZPDyzGZIzQK/pohSxOYABIQnhrnYvoIpu+MlAJPzCbmk8AhgR5XHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6721
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2022 11:06 PM, Sohil Mehta wrote:
> On 10/24/2022 5:41 PM, Joseph, Jithu wrote:
>>>> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
>>>> index 27204e3d674d..5fb7f655c291 100644
>>>> --- a/drivers/platform/x86/intel/ifs/core.c
>>>> +++ b/drivers/platform/x86/intel/ifs/core.c
>>>> @@ -51,12 +51,8 @@ static int __init ifs_init(void)
>>>>        ifs_device.misc.groups = ifs_get_groups();
>>>>          if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&
>>>
>>> Is there a reason to store the integrity cap constant in the device.data global structure?
>>>
>>> .data = {
>>>      .integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
>>> },
>>
>> This was originally added so that, when future additional tests are supported by the driver, support can be checked using  the same if ((msrval & BIT(ifs_device.data.integrity_cap_bit)
>> Different tests would have different integrity_cap_bit assigned in the ifs_device[] array  (today it is just a single element and not an array
>>
>> Note that the current series doesn't introduce this
>>
>>
> 
> Sorry, I am still not able to follow.
> 
> Let's say you have an ifs_device[] array which has different integrity capabilities, there would still need to be some logic in the init code to differentiate between the resulting action that needs to be taken? Currently, the init function only registers the device. Maybe some example/code might be helpful to drive the point.

multiple devices will be created if support for more than one is advertised by MSR_INTEGRITY_CAPS as shown below

static int __init ifs_init(void)
{

 ....
	if (rdmsrl_safe(MSR_INTEGRITY_CAPS, &msrval))
		return -ENODEV;

	for (i = 0; i < IFS_NUMTESTS; i++) {
		if (!(msrval & BIT(ifs_devices[i].data.integrity_cap_bit)))
			continue;

		ifs_devices[i].misc.groups = ifs_get_groups();
		if (!misc_register(&ifs_devices[i].misc)) {
			ndevices++;
		}
	}

  return ndevices ? 0 : -ENODEV;
}

At the handler side we can branch to the corresponding handler by looking at this bit
Say for e.g the following function in runtest.c could be extended to something like

int do_core_test(int cpu, struct device *dev)
{
	struct ifs_data *ifsd = ifs_get_data(dev);

  .....
	
	switch (ifsd->integrity_cap_bit) {
	case MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT:
		ifs_test_core(cpu, dev);
		break;
	case MSR_INTEGRITY_CAPS_TEST2
		ifs_do_test2(cpu, dev);
		break;
	case MSR_INTEGRITY_CAPS_TEST3
		ifs_do_test3(cpu, dev);
		break;
	default:
		return -EINVAL;
	}

....
}


Jithu
