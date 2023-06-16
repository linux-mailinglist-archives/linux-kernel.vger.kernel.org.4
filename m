Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70667733C9B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 00:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjFPWwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 18:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjFPWwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 18:52:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9A63584
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 15:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686955922; x=1718491922;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TafAXJkayhMPn7sspk2cBqBFKs9fWLh07m/LLHQh4xc=;
  b=fK3IufVApOIjkzV9aghl7wt0TALymkUZjsI87MaUMg2jB4Muc+LvbvIH
   8YvhbhfybgRSw+U6kxRH5RahGJgOibhf+wNN9yz8hzevihoxWDiB7pLvL
   RPzeBm71QwitQm7Uq6kRbOBYuvP2yYgMtll4MgfObobaPnLHFYznjqXel
   vNJM3NqdcdoIMtiTRE9jSEO92DXEsHelg+D9P897Hicw+4xIKiM73IeBh
   kd7XLdmSA3s7HpoaQbzJf6I5vGT8CHhN2R/ZRMxmxdcV5EXMMLsHinWiq
   jcK41bFdQ7/Chu5cHEGkby8IN2U5hrZGGPM7MajAx74CvchDLrnguc5hK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="349038215"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="349038215"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 15:52:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="707254177"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="707254177"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2023 15:52:01 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 15:52:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 15:52:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 15:52:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJCvI0F1lILisvFJLq3liIbZLbnQg3lkKDOZVwn829icTN492u0iTm5TUCe5pVl/q6E63WgkYOiyT/wF4Ig1hPQpBAYoHtmaDFaubHL3Vj4NrRVf1I23RWsRe8epzYl4gCn0f5QeKac4gMqfDS4o7wqf8mGzCZ4fa5d7mJNHzB5xegBIrfB5GRWRxYhA+H9gVQuzEk02bFbsYzrXYVakx7h4tBAoMhtxDUZDNW5FYPsr7UG85Oh3CHH9s6PCVGKmD1jKrAsUtO5gUAr4g0Fk9AMR6MTuo6AFpUO2ZLZRT0Dgah5CuZShkQYFVRry157H7DIjJpJxYfRmfjF/fo3m1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TafAXJkayhMPn7sspk2cBqBFKs9fWLh07m/LLHQh4xc=;
 b=ZzZlTBuh/Ol3djtC1OF5kw+djUIox4voVAtMcSXZvujh+TCUVMNFAgobMhwI8v3O4+QydS0c44PoqOgfw5bQZoW8xYs1prS25NsqCEM38KvRaxdEjTEK61W0OWIlHe8o0+ZoxnSgLOHBlvH+r1GrUqrVFxhqau51QVTVVaW/9YsiImxXohlkYLQxpi7W++KmgCwqwbBq9bdS6tcgs4gJua+xSJpl9Qc5Il3GD4cflrHw7GDBIeYzu0tbVwQG2fgvnAZ9SV8+SyRD4PZK+a1YjjdMR7GHUM0YauIv+qYrV8fJcbv8URX1yQADH/zdg+19puc+5Cmf4VjvY1RdVjHQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7)
 by SA1PR11MB6918.namprd11.prod.outlook.com (2603:10b6:806:2bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 22:51:59 +0000
Received: from MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::ea27:a8a0:3e6:db89]) by MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::ea27:a8a0:3e6:db89%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 22:51:59 +0000
Message-ID: <7e556c50-a98c-a715-9b80-209dd79cdc29@intel.com>
Date:   Fri, 16 Jun 2023 15:51:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [BUG] _regmap_raw_write() - divide-by-zero
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Jim Wylder <jwylder@google.com>,
        "Gerlach, Matthew" <matthew.gerlach@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <02da121f-d6f1-73de-1805-4b331ccbc547@intel.com>
 <648e22d2-d455-4439-a00d-4042077a8571@sirena.org.uk>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <648e22d2-d455-4439-a00d-4042077a8571@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:303:b4::12) To MW4PR11MB6763.namprd11.prod.outlook.com
 (2603:10b6:303:20b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6763:EE_|SA1PR11MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 36dfba93-abe7-4aeb-f170-08db6ebc4ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tSGBzZvl+HcUc6lJEZNzDFzkAWiGxYFIc4iCHOluTwVeWaDL5gByRmfhIUrZeo5Cxb/I5nOXf9C2tTU5ecWMLY0wrebZ/6iPkkN9Y9MSpeVwcoBJC4IDGuwUSBoFhG+EBwUUZeHBCF6KpF/Nj/dasfbaiyrSLzdMvb41rSXz5F5GtbGw19sIxl6yn2FsEjC/Y+2rrmDdQpQ3XYtDi1VbvC2++ofA+mABtNVM9A3nQY+gSOE5gGiMHLpMmiZpzF/nkuuWYh0ATTXey0wYbOi1f56kValK9oFhxgDyA0kjuYcLzPv0E59jTSrmGw2nHPZJIS6tfaYQvt77ea9xnMOgnbi5Q5woOY/u6SUc23O1JsYI5tdeZDCY371PgYOoC9/2Ya6orwckB7XzUngLfiH0dbGHrxOJWmxkRTJSxwOY+rlFniYsaI8il3tQp5KLNBlIjI5ONdkraku+KxObg3IsMgTmzTxO8xvMVHtdjkuJ4Mbmxzva4/Hj3YEH2CF+S6HPXnQ1HSr9dGlocBJ4Z+1K3tc01TiynhN1nfd2Bd8yXXNmZdTLWC38NWgzo2QhnIsrv6oAfNMZ+pgUSaG+bJXP+ClruVJAjEnfN5p+GIlwhxclKZ1EGZgqVkma0qd2BeNfs5DEavE3NNQBX1UsKeL7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6763.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(31686004)(5660300002)(8676002)(8936002)(4744005)(2906002)(82960400001)(41300700001)(38100700002)(66946007)(4326008)(66556008)(66476007)(6916009)(2616005)(36756003)(186003)(54906003)(53546011)(26005)(6512007)(6506007)(478600001)(6666004)(6486002)(316002)(966005)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU5oVHhQRlV5dGMrZkRSK1V6VXhqWk8rNDFCVmdEdGNKY2x5QVFlQ2tWZXpG?=
 =?utf-8?B?ZFpnRHZZZi9yTVFsQS9GWTc4cjA4TC96bjhZOWo2dC9TMFZtbjhWbUZkYW1t?=
 =?utf-8?B?V3hZMjZpbi8xL0tsb0pldVI5a3VZWlVxWTZzMXh1T0I5Y1BRQm16L3FGWS94?=
 =?utf-8?B?dXUxZHFCbHNONW5TTG5QUzZUenN5bUlMU0lUR0NqN0tJaGJjaVpONnZhVHVp?=
 =?utf-8?B?ckx1SUVCcW9yUXl6UXlWMnFmVDh0ZFY3MjU2OVI5RWlOYkJZbFR4MGhlUE1V?=
 =?utf-8?B?QlVvT09kUklrL0dzYkJvbEVPcGNXeUkwK0tKZHdwR1lnclpmQ0FRenRxcHF6?=
 =?utf-8?B?MzFuRjhZdWVLWWthWS9ZNjhxR1dPQkdJVTJhOGZNbHJzTkFNR1lUd3Y3Mlg1?=
 =?utf-8?B?eEpLNUFSNllTSjlLSmRHTVpZOUlTM2pVUWR0TDZLVTFzRG1qYmt2VVJlVnNp?=
 =?utf-8?B?WG5NUjlCK25HVHN1SVVneTBNYXI5MHdWREFneGRGN1BTS1gvaHNpdVluNitE?=
 =?utf-8?B?R0w1ZDJvTjN6UlByYWYzYjV0c2RONHN6UGtqSW9qWm90U2ROY0xUNCswc0Ry?=
 =?utf-8?B?TkpDZlRnZFVnQ1Fic050Vys2bE5lOHNtcHVWaGhydU5qaVhwZ1ZQaUhrQ1FF?=
 =?utf-8?B?MHBOS0RGRmxncHBqS2RzekFpSU5xUFNXYkt5QllpSGJNVnRDK3hBOVBhOWlP?=
 =?utf-8?B?SHdOWHBYWWFIZnlpUTIzcjlhN2pUSitkZGtlRGY5emJOOHI4OEgzYmxzZitk?=
 =?utf-8?B?QzNKV2Q4QlIzUTZITGtTVUJhNTVTdm5iU21JSGdta3JyVUpxMVo5WDREUVdR?=
 =?utf-8?B?UjFBZVV3TXkycGprelcxUFNiSDVwb3dpeXdKcGV1cUtGbUdOb1pWM3FVMVFJ?=
 =?utf-8?B?RE4zTzNTcU9Pdld4SHFiYkJmVkJpTnhabkR4UHpLdVBGRjY4V055YVBIRVFI?=
 =?utf-8?B?ejlrdVZEQVF6bGw1WFVXY3NMQmdaR2pzTnFkclFrc3FWTDZqK2pibnZlTDMw?=
 =?utf-8?B?bFU4ZFZPVnlkc09mTitwcmpTeVY4bDRVaHhud29XVFlaMGJNOGVidGZ6dTMx?=
 =?utf-8?B?aDVjMjZuQ20rOXZ0Q1FCTEljZXo4NEExSjZlWngrV0ZGSzBzNnNhWEtpSWxp?=
 =?utf-8?B?MnJGV0hONTZNWFk5WTB3SjJWWFBkWWZsOWNmOGpVVDhUV1RQVndaVURxTnpy?=
 =?utf-8?B?SVRVdGozK25taHExYXhneElPQzAyMXlqVUx0bmxlL20xWlEvb2lSM3BzOEpx?=
 =?utf-8?B?T1FiQ3ZpZlRGWUdzeEY5eXZpU0xhbmpPU3VpMk8zMG8reDN5T2lEazRTNmx1?=
 =?utf-8?B?L04xeHk5RXpDaW8vb1ZhZlJRNGdqaW4xYjBzQ01KOFdMRUpnOUJpdlQ1NjJI?=
 =?utf-8?B?VXBRRnRSS01WL3paOVdyemtUMzI1NlNOMWVJN1BrOVFmSHVpek9yTDdUaDJm?=
 =?utf-8?B?enZSdU9zRXVZV0dBVU8wcTUvb21pK2xGWHpEL2NEZGtpdG01MnNoREswVVdE?=
 =?utf-8?B?ZjhzSU52VU1GUGlydVgreS9VMlppMkkwZk91cVloL1RCMXdJT1pTV3hHbC9n?=
 =?utf-8?B?UHdhOFlsVmVDTmk5NXFCZTAzNVJLYzF3MEFwelVlRExDd0hKYVVWN1BoZFFr?=
 =?utf-8?B?TnJzQmVSZk9mV3c5VFYwcnVsdGU5ckovRFZ1aDh3MmJteGNqTUl2bkZXT0dl?=
 =?utf-8?B?bG8zQm5sU2lTUW5uVlQ0d2VWcnVqVHRhcWVpVUF2QXQyY1pPdEZUeFNxV0pT?=
 =?utf-8?B?UkE4eG1aZm9RYVArQVdiQ3VXUzFJbmtYeU5kazUrUWxyYVdYa3V5WlJ3dlJ3?=
 =?utf-8?B?WW44VnFQZHJqRGNSWXhJZVBlZy9QUFduY1laNFY2MXN5ZDJpQWdyNDRzNG5M?=
 =?utf-8?B?K3RLZmJkbVl4WFNrSFVTamx6YmpJTEpXMkdmWEJHMG9wallybGdqb0FRd3BL?=
 =?utf-8?B?dk0zdzZ6TWlyb1BZdEU0NnVXS1R6b3BRSU4ycFNpaUFVYXlhTmxoN2lGMkls?=
 =?utf-8?B?K3g3TVlCVFp2bGdZQ09LODZwelBPSjhUQzNrQWh2dGJTNnp5VUpwdXVaeDVB?=
 =?utf-8?B?NnVaVXU0QWVhbXNXVmhhZ1kzaVhwbUJJTTFGWWxyVmxhcS9Lb2FTVHZSVk9D?=
 =?utf-8?B?WU5zZTFNdlVnbEZIOWlMZjJhc0NQSllrWkprM0lKbVJKUU1ocTRIVGl6SS8w?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36dfba93-abe7-4aeb-f170-08db6ebc4ab5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6763.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 22:51:59.0454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAxMDUT1OqX99X57SPAIPKCjikZvmRmBM30uo+X0yPITKMtQYqC1sevyShCbRVmV5CjJItCF2B02dRDSWpIiprGTgktyWjxP+4zm0bbkg3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6918
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



On 6/16/23 15:14, Mark Brown wrote:
> On Fri, Jun 16, 2023 at 02:58:24PM -0700, Russ Weight wrote:
>
>> The origination of the regmap->max_raw_write value is here:
>> https://github.com/torvalds/linux/blob/4973ca29552864a7a047ab8a15611a585827412f/drivers/base/regmap/regmap-spi-avmm.c#L663
>>> .max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
>> SPI_AVMM_VAL_SIZE is defined as 4, and MAX_WRITE_CNT is defined as 1
> This should add in some headroom for the value too.

Thanks for the guidance, Mark. We'll put a patch together to fix up the config.

- Russ

>
> We should also fix the max_raw_write comments since it's a bit confusing
> between users and buses, though AFAICT nothing outside the core ever
> checks.

