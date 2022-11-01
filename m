Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A746144DD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 08:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKAHAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 03:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAHAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 03:00:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6E4FAEA;
        Tue,  1 Nov 2022 00:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667286017; x=1698822017;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sh9zyOczVdIerjGhNBs5ziD/pzEgMwogxOfbmkq3Z40=;
  b=T8a1m39pRKf/V6NJNk6gZkwqpb/uybHgRNMeqtt3Un3W/DE9uIVUDrZD
   j2/yB1qGeNwkONSykGjyL2gmyrjZ+ncLUC+dCtp2wr6EfnG8xMG3J/adH
   lbKX51MM/lfGM2q6W8a/p+vpGMZz9+I8mxn03CPX+5//bbd4XXGy0SIma
   TYKRzThDUmybZgxLR3z+OUTdaRVYGKMOONB62SwtYwZffm1GWZl844h5v
   G3FUXsYcYDg/4R1qlbj11XwkSrDlBchzy4UtP4X1W+UiJ/ouNWiYi1ioj
   F35DT0dtn8DY1csy/g93a6xOutwPhqgwj+RhBRSlquNOSLl6uxEnGx1sS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="371160556"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="371160556"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 00:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="665064293"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="665064293"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 01 Nov 2022 00:00:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 00:00:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 00:00:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 00:00:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uri2OeP+herQwvJz3tjBFFb2gCfTVh1UzNOkP+g6Rt4vUVZobfDJ1f+AsPAGj9jsbaViVHY6TkJu7ZkkgkP+yU0cuVBhrpU8Bqpk0qIBFvh9FKmQ37cOfyR1stRAg4DMzPDWBxHSIisDhOVSIrySl+g2BS7mSun4fdIG6JjwPOBzXzIFgUn2RIkTDuejkFLwCNH4g0QAECMUbFOxC7JE5uXx7oxRnqClBVCX3Inkzd+vjM1alpMki44ETI9csCPJu2c0RFKW3cIWhwglY8uvml+r4wR3OVXFEZXYVnBpSnFAInBubJ/YLttKAPgWe2sqSg3n822iH/LDkxmRBl6Wgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfLKIdh/UnNbx9kCUzHMWTwnYK9wM4UcBdHflNy5mAY=;
 b=AbxR358V1C198z8cp8/GRNfkgXBrEFAb/k5gY+t3l+d3Tw39qPMMK8QwudfoRgRmz6zioHd77cXkouBcpnvenOfSU7FSRHMRZnMpIa4+JMltvjCWYnZkuapDA1vHjBsfhohEEygZ7bu7iNzxrAz/yUWr8vcRDBDzzs9lqIpXPR+baNpEgGcUgMh954OnMpwbL4p1TENiZAA9y9efzsiwfuKBkC3J0w14QxQDBV0ph2QCGs9qxWwHfOo5UZi9JTyn1cJLd71UQ69fly9sP08OuGGJ2r1ka0TltnhjxaPmLqtuMDHo5sAJhkiUe9lxqY3SdxDX56UpI+PUAhc1qVGoLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BN9PR11MB5388.namprd11.prod.outlook.com (2603:10b6:408:11d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 07:00:13 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 07:00:13 +0000
Message-ID: <a301659f-9a85-5112-f5e3-5d043a855c77@intel.com>
Date:   Tue, 1 Nov 2022 00:00:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 04/14] platform/x86/intel/ifs: Remove image loading during
 init
Content-Language: en-US
To:     "Joseph, Jithu" <jithu.joseph@intel.com>
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
 <4661da30-7e0d-8cab-ec55-9f963df5a582@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <4661da30-7e0d-8cab-ec55-9f963df5a582@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::15) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|BN9PR11MB5388:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa4b20d-f670-4c66-4dd1-08dabbd6b8f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xQspPayXKfYzU187S3vf+TPU8/I8cickz97gK9R5F4zBmXYy0uYn6D6l+wn0ykCbdMeZ82pTX6bfJBK0NROoLmLQHwKOWbom1h864ojXZ/8c4oiDTutvXhSAFSrNSlKuW3lp1tc8IS5tAcJhfaCBh+WqsU6fcxkSqwGTWkvJEEKSL7uk97XEJnssxTZyCEWurtcGhYq8DF18m6jRv9RmYqqkQa91sHIWnb2xAil15lHSaUfb9j0DTuCka+G1uzPoOhaNNq9KM4u7uRmcEaxI5pm+i3I/EpxPPKyHcbujva9UmkJkQKyAYAWS9MdSgq6hQmLK/jRy03HSq0JADQ4cUWDvACtgfyvk07YN5zNdnHaafqDqJv18Ha0Nu81uTdKCoBsiXre+vK4vNhYsIst0harTX3vIXr57BEw317cEvpGU2AQgRCeHUwyhhQIrubRqT7TH79W04wIzb/HB5XSYURQqZT9K0ySot7OtO7Y3fSCkZEd8xZiIxhE48/+B5xx5k+Jab+OGGbjDFw56NnC12dvtYYhm9gBOZC+7XfB+6JRR1o/qzFvcgiz6/oVc/9C5ovMBovbzrcYkrZ20S8Pt4RwNLupnHi0dHdNXQlD1UlCWX09AxErhw7Q7rzWH7lDx/U6m8B/dSsR3QME/ixRolwuBDWUAl39bvO9+yHiScVBdRVs/u/7fVLedLIXzZwZMAV/GH14zmHGTNRiXZUVGHpEd3SJ8WhToZnxM6zG3vG0X2Fz9yhL8vLh0GF/U6JRnZnPkKWswmxTpmCqVMH/EUbBFXi+KVDejJnhAWeyTGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(37006003)(36756003)(8936002)(6636002)(41300700001)(6862004)(5660300002)(316002)(6486002)(478600001)(44832011)(7416002)(86362001)(31696002)(2906002)(38100700002)(82960400001)(6506007)(26005)(6512007)(2616005)(4326008)(31686004)(186003)(66476007)(66946007)(66556008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjY5Z0RsbEhvNDkyWGtYbkgyZXlFTkw5VUlIcDU0NkkyN2FNRFNmMjhiRHN6?=
 =?utf-8?B?VSt3OGQ2MDEyQ1R1RFNqWWVtNTVvMEN1VStUaVVWVmdvT3B0NmRhWjF6aVZU?=
 =?utf-8?B?c1FaUnVGN1pmNmlBakpBZi9xck1Hd1NPYzZGVmpEUHlQQVk5U3dod0RIcG1p?=
 =?utf-8?B?UGUzUkUvMjRRSVdWSExmZ1k5bWh6OFlUMS81dCtCZHhhWDc5d2lOeGhPbnBh?=
 =?utf-8?B?aGxtR0VIcFg3dkF6N2RrS1ZVbUdHcmdNWkZDOGJGNE5wZHZMWDhnaFB0K2hj?=
 =?utf-8?B?bTRBbUkxL1kyZE4xMzZVMjE3Ry9qMVNtZUlsTTZmQjhDMi9QdU5vOVNzQ3Fr?=
 =?utf-8?B?ZTMzZGhtMVgvL2ZsOElpblQrMUN1dS9Ma0QxeEh2TzJhaVBxU1k3MWc4VG5a?=
 =?utf-8?B?KzRKYmV1b2tKaXhROStJK0hmM1V3Rzh6WDFwMTZYMDFTbmZ3VnFMRWhxUjQ5?=
 =?utf-8?B?ZER6RlkraWdteWNRUFdxUVdDSG4vdENvSzBkR0pyTnlBUi81ai93NWFhU21Y?=
 =?utf-8?B?cG5iR1B1ZEdZbFA4UWJXVDZuUE96UUNIU1R3VlN2bFB2RkRWdFgvOTF5WWI2?=
 =?utf-8?B?TDMwOHc1Smk1VE9zOGVhSFJ6QzZXRGRGQ2k2OTQyTDQxM3YxeFVycGtudzlr?=
 =?utf-8?B?dDhpaXBUKzd2eFgrcW1GOTFrRUpGV1AzUFZ4L05CWEx5V3pETkcvU3BXbmo4?=
 =?utf-8?B?TjBUUU5FV3dmaWFNcjdaR2NKSVh6MmNvaVB2ZjNDSkI3ZmRpMmFVTURwbEVn?=
 =?utf-8?B?Y2J1dlZaajhjdC9ybGRHWkdFclg4b2k4ZkNZdDltY216UDNreXVyNE1tMlAz?=
 =?utf-8?B?ZkNNWlpjWGN2aGtacXhqWHZwNExsQVFGL29qTGtIS2dGTEorK3FnUFNtS050?=
 =?utf-8?B?YjlPcDBzbERTUE9xd3h1bHQxMlgzSWZ4R2Roc0U3dVBDTSs4dkU0SlZ1M0tm?=
 =?utf-8?B?REF4VVlva0RtTVBQTHBWeG10ajYrL01yMUZuY2xabUY0UExUNnVKSjA2cFJC?=
 =?utf-8?B?eUZxK1pjUWxsODFDUGtuM25zK1J2TWU0azFYbjU4RjhtYUVoS2JDbFZ6MlI3?=
 =?utf-8?B?clpNei81QlF5QkFtVy9Ramd0V3k5aDdwVG52ZzVrb2VvVndoK0IzTER6ZkRt?=
 =?utf-8?B?SHIyRlRjQlhVVDJuclhFZTlSU2g2UnlJV3BSYi9aVjAvR1pvMFpVMzhLcSsy?=
 =?utf-8?B?YUk1TmtZcFNUT2t0MysvMS9DbnBuQnB6K3N0QWNwRXFDUXk5UEEvQnhZVmhB?=
 =?utf-8?B?UlAzanpWVmxxQXIyOTgwQXFCdjVxaXFtc0N6QkhCdVhMdDVUeHlXWjRMUmZG?=
 =?utf-8?B?VjdST0JlM2xuM3BpTmNPR0ozNnFEUDVnVU9FYVVFbVlVUFBqKytucklFTFYr?=
 =?utf-8?B?T3dVczAzRkczWHlLNjlrc0RQMU1BVHc5bmNpVUIwbGtuYWFBdmt1RjBsdmly?=
 =?utf-8?B?Z0ViSTl0dGJVZUdkd2NISEFzSTVUenRmMy9jaEJ2MmxGUkNHYUNpaDZEL1pp?=
 =?utf-8?B?dkkvWDVKd0tTYktJVU1HU2JHL0FFYTNpc3p0eUVNc3h0VEZOWURhMEptcjF4?=
 =?utf-8?B?SlplUUNMeG8xem0ycFRYN3pqY3lFV3JqMU51eXgxanpOMGFQZkdlVlJsZitx?=
 =?utf-8?B?OXcvb0ZUK1FlTVJNRDVrSnlMcW95ZnNEZklZYVhBd2w2R0hKTGRrd0wzWnFG?=
 =?utf-8?B?eFlKdnoxSm5TZ0ZVT1BDNjBhYktFdUFBQWZRakhUcVN3S1V0SWdnM3Z6ektL?=
 =?utf-8?B?Vk9RQzFoSys4aDhtVFl6L3JFYytJeURFWEorbStnM3lPdWYyS2lOTWtYa24v?=
 =?utf-8?B?cW9SVThFcjRsL2pOQzJLZ21WbTBocVh3aExVYzh5bm9CMmdMaFJ3Y0pETDQr?=
 =?utf-8?B?VTR4VmNEc2ZaNzlFMnIwRW1Td2lMS09MSHFKeTlML2U2cDBMRjBnKzhXNTRp?=
 =?utf-8?B?bmV6SXFIdGo0amt5NzNsTkhDUHpYbk9uTVhaSUZXUzM1ZVBCOFl5LzczZW5R?=
 =?utf-8?B?VWNpRXlUUGxsUElKVXJFeTFidDc3VEIzOHhoY1FSUC94b0lMTVEydksxd2NV?=
 =?utf-8?B?V1IrM0d1ZDV0QS9zTUlvMllOWWo3L25QLzFiUjNzR1FIN215d2RsY3BOVHYv?=
 =?utf-8?Q?uBwYOYGrh66/GGZMJmOSZHnJ3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa4b20d-f670-4c66-4dd1-08dabbd6b8f0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 07:00:12.8216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuhmHEnascV66feyoFnG5l9VcfH7SD4Em88wW4/+GQ2/p53251nJ639YRkLZ0dVBbNYsCpttP7eurDEvcvWi+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5388
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the psuedo code. I think I understand the reasoning now.

There would be an IFS device array created for each type of test that 
exists. Based on the capabilities supported in MSR_INTEGRITY_CAPS the 
specific IFS devices would be created to run the tests.

> multiple devices will be created if support for more than one is advertised by MSR_INTEGRITY_CAPS as shown below
> 

Well, it would also depend on whether the currently running kernel has 
enumerated that test. IIUC, older kernels running on newer hardware 
would only create ifs test devices they are aware of.

It would have been great if the above statement would be true as is :)

> static int __init ifs_init(void)
> {
> 
>   ....
> 	if (rdmsrl_safe(MSR_INTEGRITY_CAPS, &msrval))
> 		return -ENODEV;
> 
> 	for (i = 0; i < IFS_NUMTESTS; i++) {
> 		if (!(msrval & BIT(ifs_devices[i].data.integrity_cap_bit)))
> 			continue;
> 
> 		ifs_devices[i].misc.groups = ifs_get_groups();
> 		if (!misc_register(&ifs_devices[i].misc)) {
> 			ndevices++;
> 		}
> 	}
> 
>    return ndevices ? 0 : -ENODEV;
> }
> 

Nit:

The _BIT extension is probably unnecessary. How about?

.data = {
      .integrity_cap = MSR_INTEGRITY_CAPS_PERIODIC_BIST,
},
