Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C235F62217F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 02:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiKIB6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 20:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKIB6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 20:58:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806B767F68;
        Tue,  8 Nov 2022 17:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667959091; x=1699495091;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xZDuz5+euWyXt94A7xnrjedx5k8FB/Z3kSHqHXEjf1k=;
  b=bAlUvDlPiPZ89pxi2kcrZL/L6CqVI1qeotLn+qyPVUgrTlekzhyN1iCJ
   fqyXoY+fJiWkO4Xp2nVwUHSzWYXUhDqQFjxbSLSnTkocC1mbAn7cojEU+
   HkoMlDSKToGVrUHe01TWvc/hFYutxPZEAPPAycaUzkwrA9Tze6Jdkq4E/
   aevX4FgIM9BrNibmdabQyj6V0DPOQDhMSTcX2Mo1u1qm5NwqSLSOXIZzS
   Q6+6g2GosaZRogqIZfzaflfJxBrbBVxut9ToJ/XTsiaBuJmPa7AbJ9Jyk
   tU9r6IVbM91D+1a+/IjshPy/6rpu2tYZhZ+KO1gZZZmXg7Y7cKV3N72CE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="397155128"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="397155128"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 17:58:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="631078067"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="631078067"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 08 Nov 2022 17:58:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 17:58:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 17:58:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 17:58:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjfT5QmOjA9K03n88eP54p+tUAQHyeirg9cMtw/FWOjZ7yWhnUK22s4a9wjN/+QlYE8cXZQmOQAuBk6LsdDkFVjCkVIl9zAb5EjRKbKo71mxz9IlvZ3SWSuOBoyHJ2euMSxT7WwHPfgcbCGhZZsbr7yQsCz9PD7vNh88tpEhivwpGPv2Avcx6nHEWSyMQuz/KnYBSOUYXYgpLSENgB1EPtACgDJcW1rxIHezHCgIDNXzBrcKVoloKPFFIF8mlPcEK7YW4p+VmHIwRSivHCUDvws7Wa2YsHNPRtFyJ2vrE8+iA4bQstIGEGQgoHFCVr6Ukfk4+eZ55tA9Q5z6QZtwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ypt45sCarFEzZ7rpXvx+wtRjG6FQghZdm7ORxiWY5E=;
 b=P4M2viktCAauXKl5Um9kwwrE5Nn128oNnvFKjCiNa3LsBRNuCrFuIyEA09FdNBX8WAZrLZ3mNcIY+eBl3hGOlkBmMx6NgTeL7T+NAGBR3wLXWuBi07m5jecQuV7S3dkcocmaht2J11A9kSBuvDNkoO+CERmTWM49025XiRxoAW7L0h/gwOc4wqT01iRTaSYCstY2JKDOh01AqJMXGluNtQMuKd+LyNUa5CSe1vk5K0vxGoWuOyQJSRjfNqxx0voXIu1pzwp4scqy0+JYh9meO4JYWTOGaHHFFTVS/Sxi7sR8PwxLKhA4P56syCkJzRA1vitEGPrvUewBZ1q0zjSoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Wed, 9 Nov 2022 01:58:01 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::2720:c97:3346:ede4]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::2720:c97:3346:ede4%7]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 01:58:01 +0000
Message-ID: <115c2f0d-3adb-cbf4-9047-32eb0b461341@intel.com>
Date:   Tue, 8 Nov 2022 17:57:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 02/14] platform/x86/intel/ifs: return a more
 appropriate Error code
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-3-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221107225323.2733518-3-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0069.namprd08.prod.outlook.com
 (2603:10b6:a03:117::46) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|DS0PR11MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed9d9f9-e42b-4b25-8959-08dac1f5d512
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDWjdE5uj8136upN6grkgqw8FqRq1d8D8johEWYez9ZQfjNd+ubV6IM6rIpq/TsMMarsk/QzzZMMdazTxpfAMw1KfP2k1tKfmRULwF7t1mm/u1riI1xoRg2ZXsHmlxbiOKvbUqUAZOza1prq7Qfiy2Hc8+ZR4n5vjoNZr1+1EJTT9pVjBOMPNJ7CtxrduWNy48Pb7+tmDMGZFBBCEG9hIebw6N7TQ2PRdeeR4TlOlRlcn9wYjmxHhxU8El0cWppHXU1EwX/F01zLmIsCYYvAH6OkrLOrWQHE6MCi5aKBtVf9pmso+HvwGwakfemIPUjnDKNZyuXiAS3zAmF41ab0rjDH85VHa6fh7Vh6O9L1RPmUUdElnvEggC+MEZ0AXA1JX03P2ciyrsAbXER19MKFu7qUnhA62xJZE95bgXMEnkknbeRvNHkKxeWsIJ8eUf4xymjEEevfzzXUI1iVAnAbokUgzoGHduf/2q/bICwWhRsexW9NdsBRG7q+8/QEE/y06johT3tj1+Edf3DJwzZhfQ5+uucU7fyOHqBiwuj166TTY/XBYMGblb0Rd8recnbo05qszxkX/N0bcP8Lm2JyYK0NQhGOBNHDqKMoYtSwpLL14m5QX4tHGxmAPVw6StKFIJatYlTgO3DP8aer1as/NRSFyMqFA1d1jXUCTDoQQP3euZti7toevkeurVPTilgyUSqodd2HD/i8jMLVsegPB7tY+/NbBcr1SNhEfsLf4fHhqz51jkRjljhHn5BNmvLbzLI2nzS/k4kkb0l5lLbgBvXM6CTMGeZ2W5+DDUwka60=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(6506007)(5660300002)(53546011)(316002)(6666004)(2906002)(7416002)(8676002)(2616005)(44832011)(31696002)(186003)(8936002)(36756003)(26005)(6512007)(66476007)(4326008)(66556008)(66946007)(41300700001)(4744005)(86362001)(478600001)(82960400001)(6486002)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3ozd0E1VVZUb3RHRHpPYnNYMklPaDhkU1ltbEJKU0RTbmt5Q2NRMEVQUUxs?=
 =?utf-8?B?a1pOTXB1STFPN0lwb2RKcmJQdzA3RjRWV3RaSU5od05rUE1IN2JnVnh3TlNF?=
 =?utf-8?B?eGZOWTZFcnBVSkpwa283MVFPYmxVeW53cUtHK0FHYisxalVXVlZLdVlhQnUy?=
 =?utf-8?B?ZGw4aExTQU0yQnpkMGxFSEZEQkhucGZOMW1jYjBaaEJrMTl0UzJyU0todExU?=
 =?utf-8?B?K1djVlBjOTJxNnVkelNWZGlIdGNCN0hrV0pwMnYzUllJbzlNRzFuc0tCM0Vv?=
 =?utf-8?B?MHB0Um5EOWJ5S013S2YybExiejYvNlpYckZUOWJLWXZoREl3Ymo1OTRHRm0x?=
 =?utf-8?B?ek9QUHpyMHFxc3ZteWExVHdRR0xCSHN5SlhkaVNhZEMwWXRFbFlQTjc3Q3M0?=
 =?utf-8?B?R1VXTDRIRVpDVlRLQk9kbU5ablBEaHpycmo1ODU1N0g1cGlQenM2WStKa3pY?=
 =?utf-8?B?dzRZekNnMyt3bWdUS1FxcTRxM1k4aVFVaUJZSVFVbE5vd0s4WC93NXZwa2JK?=
 =?utf-8?B?N251WVNZVEgwME1ocXVyUEMySGM3TXBTREdOdy9RMTNWTGtrTU9xSVZLZG1h?=
 =?utf-8?B?UzErNjhFTmVTbEVXM1EraVFlZERvdWtPcUJVQy9sRnM0NzF1MndFY2xnRHZa?=
 =?utf-8?B?OFhMb3EyUkNsZlBjSWVsQkloWGFaTHp3SnV2QlNzT3RzM2pUL2x5NmpnTHoz?=
 =?utf-8?B?elVBZ1p0WnJyYmJYTitUaUVDVjZBeERhL1R0Q0h5bW04NEswZUFXSDVMZmd6?=
 =?utf-8?B?TTBOVmxiaHlNWE5vZWZOanpkSlA4eU5EZVFvVE1VVHFsMmdNck40UjJhT0E2?=
 =?utf-8?B?MzRtM1Q2ZTVTMTB2Vzg4ODg0NzVaK1I3ckcvMVdGSDF0cUdLN2s2NjM5RzFO?=
 =?utf-8?B?ZXZVNkVFcDh5K3cxY3BoalRjMkNOWDdlWU92bzJHSVF1aTJwaHRJTjFNenVZ?=
 =?utf-8?B?M1Jtb2JBUmtjcTFRd014TEJ3SzdwbzNoNjVrZUhUblNhNVpiZW5zTVZ0dXYw?=
 =?utf-8?B?YWFRZU00RFJvZlNGRnlVWmpGZHlITlI0SWF0cUR3d0RtMFgwWllMU0E5MTVh?=
 =?utf-8?B?Nk1wOHRPNlVrbVV3bXp4SEpaWUppSzQwRU1SWDdCbXlYa2ZGUEFROTFZTFZ6?=
 =?utf-8?B?QUtmRFo4OFFHWnRSWXBPcnhsdGlaWVE0amNiRmErZlBJanUxNHJuL2h2VGFl?=
 =?utf-8?B?eG9YRnBEb3VuRERqRHhvbjRUSS9jUXFlRGRDZm83TmI0VU5TWG5SVkViOVZq?=
 =?utf-8?B?SkU3OWF6V0lqcFRvRzNwS045V0RnekQ2U29pd0l5VUthQlYySFNGV09HcjUv?=
 =?utf-8?B?aXU0RXlWNUxoNmFYWGJUemY5MEpIQ1dsdkorUVNvVUZya3NwTWJYTWRXS3U1?=
 =?utf-8?B?QWpJQlpLempvYmRrWm1wMnk0UW1LeFM3YnpjWkVSVTFtQklwdktZbm5NMTJz?=
 =?utf-8?B?NzBObTUwcmQrZUZ3M2tnRE41cmc1eEN0V3o2dDdEcm1ReVRMMmNjbW1XbW4z?=
 =?utf-8?B?T3ZLM1JvZndZbktPQldEcmlHWFc2QTJXNHVUY0pFQkgyaVBRTW0ycTNwVm5U?=
 =?utf-8?B?amxvNC9WTmpsVWJqeEpyWldJZGsrMEhVbUUveVBrU21hdHVTMUw3NURVUXNY?=
 =?utf-8?B?UWlXT01QNjkwYkNFMlpoZEdrd1ZwV005N1FLS1dBdFVRd2ozb2pVRVVDQzNO?=
 =?utf-8?B?R2dxKzVFNVJqaVpPY0t2MXNHRG1CYXlhSG44V1NNYmtuK1hLRHN2bnhEclp0?=
 =?utf-8?B?VzRzZHlxNlprSS8zOUpSa2U2a3ZmWjdBa3YvY1QwaURrMzFPbG1SZUV5c1lt?=
 =?utf-8?B?b1lTRE44dTk3Y0xjYW1SbzlkTzZHR3d1SVJVRGxsU0paeXAwc2hiY2dhVkd3?=
 =?utf-8?B?TllYS2xCYkJYWG5HdGl2WjcySnNtNkpJL2NJYXM2QVhTS1pvTCs3Yk1hbkxY?=
 =?utf-8?B?dGpWN0NHUFFsVkFjZ1k3RXlGSlRSVUFQRzJMVzRBTHM4TEdBTDNWd2w3MlNF?=
 =?utf-8?B?eEU0bkkvVzVtT0pGZHo5M25rVm91TC9CQlZUR2VNbHJOTGl1cU1LYVBFcStv?=
 =?utf-8?B?VVR2dm9VMjJlZHZ3RzdRZUpsMjJTRnBvU0VGWW02bmhUUmdQZC93MDJHQ1hF?=
 =?utf-8?B?NFNVdmhPTCtHSldPUXZlajMxelduYktNREpTTnpxU0VhYklGa296c1dYNWk4?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed9d9f9-e42b-4b25-8959-08dac1f5d512
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 01:58:01.5225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2P1dGMh2LXiFL2vav8FUWcCo3BJhNlfOtyKrPk/aDvk4I0dgtuoOEdbnHxrWGwDrkW1W1t3ICiS4oFi64G8VzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
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

A nit:

s/return/Return

It might be better to just say:

platform/x86/intel/ifs: Return appropriate error code

On 11/7/2022 2:53 PM, Jithu Joseph wrote:
> scan_chunks_sanity_check() returns -ENOMEM if it encounters
> an error while copying IFS test image from memory to Secure Memory.
> 
> Return -EIO in this scenario, as it is more appropriate.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
