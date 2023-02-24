Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AAB6A152A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjBXDFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBXDFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:05:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC06D18143;
        Thu, 23 Feb 2023 19:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677207906; x=1708743906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zi528ZnOjQlg6r16DvoemLiwuWculY5jSJeSHPRM4kU=;
  b=DzDRQS8rZz7rxwJzRpHpq0Z8vCD8Mdi06+zdcM7vGafvlmsMZyH2rmJg
   xzhW/q2aWy5Ssy+DybvkYhqTDf5ywDTpq/OERwlmqF/syPIgy5JbLOC2X
   uA5IRLJBNp7z3c97bkq/7UDfU4dU93l9o94uVT/P8qPeUeu+Jsduy8efd
   5ZyADL1x9jZkLuTIaH5sAR7nHk4sTn3nunpEL6YqKeX4ayt/cuEGMkBzd
   6Nm3KpiyDsafQHTtSQZwPgslGEZuLcNRStLHiXwf1fsB/iBAA84mGX+GS
   YhGCpjdXiKA2NzGDn/gMkpZd6EbIYGWVr4iNwH5Cw1SiAVdZfV6RbIenB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="360886887"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="360886887"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 19:05:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="650213330"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="650213330"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 23 Feb 2023 19:05:05 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 19:05:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 19:05:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 19:05:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHn8qmAu5GlLegoIxx3L/xCt6wPXhRMjQ9D+aJgHi887xjh3tGkgncGmf0oYqKzdhssswhrjENHctp5/qi6JwDYm6xXjbX91AVr/Ds61mBBu5ASxtV3o5wD04T3VIY6fEu8SFxgcKkGOpF0OW/KZrktZUoJU8QeMRQZJtvSCtN/idH0J56WKP4d1vpZfkL61c9O/i2IluSG7RMWEGf+pvZdoYqqt1FTn+WlaVpL/fvP2YSC9rdSDn7DFGKPMYEe0cTjbLLOKRZ6bgHGbgT4xrg2Y1q34zJ6/ecg1N6KiwBQPQYTtXW6iBzZtyJBrg2+NM/CrjcfCXyGVHHhu49MQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zi528ZnOjQlg6r16DvoemLiwuWculY5jSJeSHPRM4kU=;
 b=igNI9B1vOw0f40U5YNjUQAMow1Rwmc0qsVyY18SnlrSk7kOin6GsI0/3Amkauxm8d3LCyLmp7mt47Xj2XDbsZofmA2Hq5I2kPxDoW8w/e5YhZkmckN9AjIIFJ7wd7UNHO4uHrEGm6VEcVk5pMv8NyNohcJLzhBZHciDPbns9U2h4FCx7c2AMMySxsZjyopqqofh2wga71DpUFCqnoUk7nGiPkGVIGTrnYabLSFOecVJXZeGRlseI6QGwAGLO9wbzyO1DZUVUGjJ3EAB4mT1/4zjNAyae/wMVY07261ln8YV6u6VFiVVhXMA9dvvfsm6L3BOQo/8CBBqh6XcWL60KmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH8PR11MB8064.namprd11.prod.outlook.com (2603:10b6:510:253::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 03:04:58 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%4]) with mapi id 15.20.6111.018; Fri, 24 Feb 2023
 03:04:58 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Thread-Topic: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Thread-Index: AQHZR0+ogcttGObez02wrCHslcltHq7cNR4AgAAAcHCAAH5tAIAAi3SAgAAgZICAAALLgIAAAHkAgAADrTA=
Date:   Fri, 24 Feb 2023 03:04:58 +0000
Message-ID: <PH0PR11MB588021890119CA76AA5BB848DAA89@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230223063022.2592212-1-qiang1.zhang@intel.com>
 <IA1PR11MB6171F5F6B525B6C599024C9D89AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <PH0PR11MB588084641FFB675A102BA503DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y/eP4h/chB8J0rAj@google.com>
 <PH0PR11MB58801B94B0374865394E9F8FDAA89@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y/ggCdoMEhMO8vs+@google.com>
 <CAEXW_YRTOYu5ZR6aX7AaTGyCQJwjB2aEmuPMYExYD4A2csRP1w@mail.gmail.com>
 <CAEXW_YRH2amT0K3f9c4tEzXZ46GsKHwGkjaznPrH5EOL4ay+dg@mail.gmail.com>
In-Reply-To: <CAEXW_YRH2amT0K3f9c4tEzXZ46GsKHwGkjaznPrH5EOL4ay+dg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH8PR11MB8064:EE_
x-ms-office365-filtering-correlation-id: fad8d5a9-ca24-4c93-af8b-08db1613e986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DVcw5/mgMGDUU2sd1ZxKrVpyX4ZPstzokewL/ryrzc8UrtkvSH29RcGoLYTtEtApNDomttZVh6CbhHaIaXXgg1PltEVSDL6D8qSz8LPer2w9msAv0Nph9TqCngGZA41W7j1M9yaOfOog20rn5MneQjwyqBij8g2QchgY/ZaA9+IA001nJPCfz/NBFYlK48YTPRqWxKf798GODFsvek+SIAiVjoqsZB8iuOaT8sJvbQIUmX6MtK2uuzJ+rvhSnWsJ/Al2lZCSIt0g2ObqUcSbd7bbnlhIJ67wkfyJEmqIqEH4L+DfpWmp9ClEtzHlzrezS+edHA9EWKQvgtVFnyRIKIA6qdSe+tKhaY2pbeZV+qUNir8V88YI4F+5+VJi8U69MO9P2G4YA7wAMbf7S3iPyE1KHNRwflVFxsV9hCPfErlUaBvSU7vMgUIbf6m9wGj/IEfIetTuMtq7Y+CaJtKG6BpkA5Jo5fkdgm3Nj5/8R5hBSq1ciIcIiwQL5Pn/3JDpx++VCjBCeMPqB6uiDh4iErRNMDCAvxxkYeSK+nD5o3IWUKCB4hh58NMi13UNJatG6DIV2QOXItGQAvWNfdHOt1qCtX8e1zLr4r2nelFLgwNgq/PUXqTQI9T6IXm29WMbv52lEydh4gb1B5r9flKpGzlrRPA0MoCSrcLEYy+GHNAGHYsyq/Api23eYq8FamAUzldrstLc4hp6Ok3qGgwTlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199018)(122000001)(38100700002)(71200400001)(2906002)(6916009)(82960400001)(83380400001)(55016003)(186003)(6506007)(9686003)(53546011)(54906003)(966005)(316002)(41300700001)(26005)(5660300002)(4326008)(8676002)(66946007)(38070700005)(64756008)(66476007)(33656002)(7696005)(66446008)(66556008)(52536014)(478600001)(86362001)(76116006)(8936002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmpwMmFwa0VNS3dmZ3o2TWpJa29mb2dqeUlkM08wTTVIWVFRUURKZzczNHJu?=
 =?utf-8?B?bjUyVGZ2MWErS3hodjdvYkpVYmhkK2dtM2V4bUdQK2RBYVlGaW5WZXBhTXBp?=
 =?utf-8?B?Qy9UL3pjdCs2Z1h5ZFBkSWZjSFVDOWplNm5ScDMrNzdMMXdOa3FvYld1YVVU?=
 =?utf-8?B?em1uYnRPV2RvSnFXRllVV3RPU1JJVCtNNFhZdURDSjd4Zm9tQjh1Q3RrTmpH?=
 =?utf-8?B?SnoyaC9PclBZWGxqemp5aTM2ZkorbU41eU1rZWFpSk1uMDJEK3Y0MWYvOFli?=
 =?utf-8?B?SEFta2NreGozdGwvYXVEblNIUnRoQ2R2OUVzOTVFNkRHbytLWGxKcHBoYVRO?=
 =?utf-8?B?R0F0MVFUeU5VWWRRamdxUDJ1YmFkOVRCVGhYaXhwemF4NGd0NDZGalFnWXpG?=
 =?utf-8?B?RjFadjRWYXhVZmZLVkJiZWZZMVREUDVScHZ5azdCeFdQZ09xSThHS1JVNDZm?=
 =?utf-8?B?OXpBWUtqNjdXdDJUSWY3bllXYjZUeGQrSmVGMXgzbE5tdWJBUWtHV295blpH?=
 =?utf-8?B?OHRZeGNPUmxnK3lVWWJjZzJGRTJUOUxjY1BJMXNsK2I0NUhkZ3FOM203Skds?=
 =?utf-8?B?K3N0anp5UXRsLzdBd01VeVVmK1pIZ0JDTVd1RDVYTURpZFdtU0FrOExxQlhY?=
 =?utf-8?B?YnB1WUd3WTRHOE9EN2xpWVdQbENZWWp0Q2VBRXRnRDB2ME5XYyttTDNGdDdu?=
 =?utf-8?B?aXBLczdmTTA1SDR5ZC9XUXlLWW9XUUtYa1kxUkg3REZZek5rTW1va2JzdzYr?=
 =?utf-8?B?TEorR25ZQklVMjdEYkhHVzdNNDExcmwxM004R1IySmdadDRSeUhQSGd1V2VG?=
 =?utf-8?B?UlprVUxnSjJQb016TDNVTGNUTkxvalF3UE5tcnpFWFhuWmZTZktjbVdubHVl?=
 =?utf-8?B?Z2NtbjdKeEkzS3c4aC9YZkpsTXg3dkZuKzhJcHZOWUN5M1RybWNud0ROMGla?=
 =?utf-8?B?b0lkcDBVN29oU3Y5Y0pKV1ZmM0Q1T29nR0hHMXJqaVBFaEhuaEFBcXhpQ0Zm?=
 =?utf-8?B?bllDbGhST1dvTDdaekVCL0kvVFRHQ2d4cTI0bSt2cVFPMm9idjE5Nklvbm1t?=
 =?utf-8?B?ak41cHJGdTJjQzlvZE9pOHFLdGU0SU1abDVVSzJ1ZnNManNEZTBTNHVYSEpz?=
 =?utf-8?B?c3R2Yzc3QkE0bnYyeGd0akpqdWZiSTZidXdWblkyZ2RsajN6QmltcS9YT25v?=
 =?utf-8?B?TXdhRlRLYXU5Y2V2U3lkVEIvTHhkTDMrdnRmMHZoK2ZlRVBMY2NicjZBVGFW?=
 =?utf-8?B?ZkNlMGNSNkl1U2YzSFdJRnJtODltaVh5YkhJQTNScStIYUZrUUVQL09kQllk?=
 =?utf-8?B?MEhvQ0FMZFNvSFUyTmxpZFRvb0ZydHhLbWl3ayswNVBha3FoWExJMnUzZi96?=
 =?utf-8?B?dDNTd1Z3akRMcnRSR0pxalJabTRpbllNRVBCRzM3NUlMOXRicDhsODJBVHhG?=
 =?utf-8?B?bGFCT2puMStBVFBqelE5TS85aXk3NVdHMzhqWVdFaGk1dC9NN3V3YVN6T3ZF?=
 =?utf-8?B?cHdXM09XbkdkZm1mVVo3RmhQNkpOYUZUYXQzTVA2L3M1TWo2REc1U29ra2U3?=
 =?utf-8?B?MDRKNXgrZ2ZlL0h6RkY5Tk1udUIwaVp1RDJDdFNxRHEvMWNTL00vcmlQMC9o?=
 =?utf-8?B?ajMxcEszeWx5ZmZGYS9qaThBU0NtT2F6OGFZbUJBeWkxTlFqU0FHTUU2c1Jk?=
 =?utf-8?B?OWpaQ1B1dE8yRVdxeUt0Y0wxaTBUbmE1TlVtUnZvRVFzUjJyRDNQZXZrVVRS?=
 =?utf-8?B?b1VESXg5aWFKWEtjdE5BYlhBaXZUN0wwa2pKR29BNU5RWEwvbW9qNFk1VEFL?=
 =?utf-8?B?NHdhc0htQjcxMnpPbkF0c3MydjNZc3lpejc4bFAzMWpiaGNkbnhTelpKMWE5?=
 =?utf-8?B?c3ZHQTI0YWFQRGZsWkM2OWMzUGRwQ2RxZjRLZThja3l2djc4dkdYUXFmNnU1?=
 =?utf-8?B?UStsdEYySDI2cmZNVGNtMEpiYlNleUE3ZUw2UHVtLys3aGZIb2VDWXBwZWY2?=
 =?utf-8?B?MTExblh6Q1Y5YSs3SWRMdHFvMUJHZGtmSHd0WWJlR1ZQY3JRY3FzanlZSUtz?=
 =?utf-8?B?Tm45a0NZUy9yNW83MkFodUQ0em4vdjNYSDFKUHZobkpHYUVhVVhPd29FMmc3?=
 =?utf-8?Q?CYKyYxNINAH+1FnF1iuYgLyZI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad8d5a9-ca24-4c93-af8b-08db1613e986
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 03:04:58.0852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B9JI9vcN7XQBHWKZYmpIawAjHxXny2U2Cg9njv3yMSNBaILnTpR9Jqal4mb18uXhDHVeyugufKz+eVyoMbLK2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8064
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLACK
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBGZWIgMjMsIDIwMjMgYXQgOTozNSBQTSBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2Vs
ZmVybmFuZGVzLm9yZz4gd3JvdGU6DQo+DQo+IE9uIFRodSwgRmViIDIzLCAyMDIzIGF0IDk6MjUg
UE0gSm9lbCBGZXJuYW5kZXMgPGpvZWxAam9lbGZlcm5hbmRlcy5vcmc+IHdyb3RlOg0KPiA+DQo+
ID4gT24gRnJpLCBGZWIgMjQsIDIwMjMgYXQgMTI6MzY6MDVBTSArMDAwMCwgWmhhbmcsIFFpYW5n
MSB3cm90ZToNCj4gPiA+IE9uIFRodSwgRmViIDIzLCAyMDIzIGF0IDA4OjQzOjA1QU0gKzAwMDAs
IFpoYW5nLCBRaWFuZzEgd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogWnFpYW5nIDxxaWFuZzEuemhh
bmdAaW50ZWwuY29tPg0KPiA+ID4gPiA+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyMywgMjAy
MyAyOjMwIFBNDQo+ID4gPiA+ID4gVG86IHBhdWxtY2tAa2VybmVsLm9yZzsgZnJlZGVyaWNAa2Vy
bmVsLm9yZzsgcXVpY19uZWVyYWp1QHF1aWNpbmMuY29tOw0KPiA+ID4gPiA+IGpvZWxAam9lbGZl
cm5hbmRlcy5vcmcNCj4gPiA+ID4gPiBDYzogcmN1QHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+IFN1YmplY3Q6IFtQQVRDSF0gcmN1LXRhc2tz
OiBEaXJlY3RseSBpbnZva2UgcmN1d2FpdF93YWtlX3VwKCkgaW4NCj4gPiA+ID4gPiBjYWxsX3Jj
dV90YXNrc19nZW5lcmljKCkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFjY29yZGluZyB0byBjb21t
aXQgJzMwNjNiMzNhMzQ3YyAoIkF2b2lkIHJhdy1zcGlubG9ja2VkIHdha2V1cHMgZnJvbQ0KPiA+
ID4gPiA+IGNhbGxfcmN1X3Rhc2tzX2dlbmVyaWMoKSIpJywgdGhlIGdyYWNlLXBlcmlvZCBrdGhy
ZWFkIGlzIGRlbGF5ZWQgdG8gd2FrZXVwDQo+ID4gPiA+ID4gdXNpbmcgaXJxX3dvcmtfcXVldWUo
KSBpcyBiZWNhdXNlIGlmIHRoZSBjYWxsZXIgb2YNCj4gPiA+ID4gPiBjYWxsX3JjdV90YXNrc19n
ZW5lcmljKCkgaG9sZHMgYSByYXcgc3BpbmxvY2ssIHdoZW4gdGhlIGtlcm5lbCBpcyBidWlsdCB3
aXRoDQo+ID4gPiA+ID4gQ09ORklHX1BST1ZFX1JBV19MT0NLX05FU1RJTkc9eSwgZHVlIHRvIGEg
c3BpbmxvY2sgd2lsbCBiZSBob2xkIGluDQo+ID4gPiA+ID4gd2FrZV91cCgpLCBzbyB0aGUgbG9j
a2RlcCBzcGxhdHMgd2lsbCBoYXBwZW4uIGJ1dCBub3cgdXNpbmcNCj4gPiA+ID4gPiByY3V3YWl0
X3dha2VfdXAoKSB0byB3YWtldXAgZ3JhY2UtcGVyaW9kIGt0aHJlYWQgaW5zdGVhZCBvZiB3YWtl
X3VwKCksIGluDQo+ID4gPiA+ID4gcmN1d2FpdF93YWtlX3VwKCkgbm8gc3BpbmxvY2sgd2lsbCBi
ZSBhY3F1aXJlZCwgc28gdGhpcyBjb21taXQgcmVtb3ZlIHVzaW5nDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPlRoZXJlIGFyZSBzdGlsbCBzcGlubG9jay1hY3F1aXNpdGlvbiBhbmQgc3BpbmxvY2stcmVs
ZWFzZSBpbnZvY2F0aW9ucyB3aXRoaW4gdGhlIGNhbGwgcGF0aCBmcm9tIHJjdXdhaXRfd2FrZV91
cCgpLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID5yY3V3YWl0X3dha2VfdXAoKSAtPiB3YWtlX3VwX3By
b2Nlc3MoKSAtPiB0cnlfdG9fd2FrZV91cCgpLCB0aGVuOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
ICAgcmF3X3NwaW5fbG9ja19pcnFzYXZlKCkNCj4gPiA+ID4gPiAgICAuLi4NCj4gPiA+ID4gPiAg
ICByYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZQ0KPiA+ID4gPg0KPiA+ID4gPiBZZXMsIGJ1dCB0
aGlzIGlzIHJhd19zcGlubG9jayBhY3F1aXNpdGlvbiBhbmQgcmVsZWFzZShub3RlOiBzcGlubG9j
ayB3aWxsIGNvbnZlcnQgdG8NCj4gPiA+ID4gc2xlZXBhYmxlIGxvY2sgaW4gUHJlZW1wdC1SVCBr
ZXJuZWwsIGJ1dCByYXcgc3BpbmxvY2sgaXMgbm90IGNoYW5nZSkuDQo+ID4gPiA+DQo+ID4gPiA+
IGFjcXVpcmUgcmF3X3NwaW5sb2NrIC0+IGFjcXVpcmUgc3BpbmxvY2sgIHdpbGwgdHJpZ2dlciBs
b2NrZGVwIHdhcm5pbmcuDQo+ID4gPiA+DQo+ID4gPiA+SXMgdGhpcyByZWFsbHkgc2FmZSBpbiB0
aGUgbG9uZyBydW4gdGhvdWdoPyBJIHNlZW0gdG8gcmVtZW1iZXIgdGhlcmUgYXJlDQo+ID4gPiA+
d2VpcmQgbG9ja2luZyBkZXBlbmRlbmNpZXMgaWYgUkNVIGlzIHVzZWQgZnJvbSB3aXRoaW4gdGhl
IHNjaGVkdWxlciBbMV0uDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+IEkgaGF2ZSAgYmVl
biBydW5uaW5nIHJjdXRvcnR1cmUgd2l0aCByY3V0b3J0dXJlLnR5cGUgPSB0YXNrcy10cmFjaW5n
LA0KPiA+ID4gc28gZmFyIG5vIHByb2JsZW1zIGhhdmUgYmVlbiBmb3VuZC4NCj4gPiA+DQo+ID4g
Pg0KPiA+ID4gPkkgcHJlZmVyIHRvIGtlZXAgaXQgYXMgaXJxX3dvcmtfcXVldWUoKSB1bmxlc3Mg
eW91IGFyZSBzZWVpbmcgc29tZSBiZW5lZml0Lg0KPiA+ID4gPkdlbmVyYWxseSwgdGhlcmUgaGFz
IHRvIGJlIGEgJ3dpbicgb3Igb3RoZXIganVzdGlmaWNhdGlvbiBmb3IgYWRkaW5nIG1vcmUNCj4g
PiA+ID5yaXNrLg0KPiA+ID4gPg0KPiA+ID4gPnRoYW5rcywNCj4gPiA+ID4NCj4gPiA+ID4tIEpv
ZWwNCj4gPiA+ID5bMV0gaHR0cDovL3d3dy5qb2VsZmVybmFuZGVzLm9yZy9yY3Uvc2NoZWR1bGVy
L2xvY2tpbmcvMjAxOS8wOS8wMi9yY3Utc2NoZWRsb2Nrcy5odG1sDQo+ID4gPg0KPiA+ID4NCj4g
PiA+IFRoZSBwcm9ibGVtIGluIHRoaXMgbGluaywgIGluIGFuIGVhcmxpZXIgUkNVIHZlcnNpb24s
IHJjdV9yZWFkX3VubG9ja19zcGVjaWFsKCkNCj4gPiA+IEludm9rZSB3YWtldXAgYW5kIGVudGVy
IHNjaGVkdWxlciBjYW4gbGVhZCB0byBkZWFkbG9jaywgYnV0IG15IG1vZGlmaWNhdGlvbiBpcyBm
b3INCj4gPiA+IGNhbGxfcmN1X3Rhc2tzX2dlbmVyaWMoKSwgZXZlbiBpZiB0aGVyZSBpcyBhIGxv
Y2sgZGVwZW5kZW5jeSBwcm9ibGVtLCB3ZSBzaG91bGQgcGF5DQo+ID4gPiBtb3JlIGF0dGVudGlv
biB0byByY3VfcmVhZF91bmxvY2tfdHJhY2Vfc3BlY2lhbCgpDQo+ID4NCj4gPiBDb25zaWRlciBB
QkJBIGRlYWRsb2NrcyBhcyB3ZWxsLCBub3QganVzdCBzZWxmLWRlYWRsb2NrcyAod2hpY2ggSUlS
QyBpcyB3aGF0DQo+ID4gdGhlIHN0cmFpZ2h0LVJDVSByY3VfcmVhZF91bmxvY2soKSBpc3N1ZXMg
d2VyZSBhYm91dCkuDQo+ID4NCj4gPiBXaGF0IHByZXZlbnRzIHRoZSBmb2xsb3dpbmcgc2NlbmFy
aW8/DQo+ID4NCj4gPiBJbiB0aGUgc2NoZWR1bGVyIHlvdSBoYXZlIGNvZGUgbGlrZSB0aGlzOg0K
PiA+ICAgICAgICAgICAgICAgICBycSA9IHRhc2tfcnFfbG9jayhwLCAmcmYpOw0KPiA+ICAgICAg
ICAgICAgICAgICB0cmFjZV9zY2hlZF93YWl0X3Rhc2socCk7DQo+ID4NCj4gPiBTb21lb25lIGNh
biBob29rIHVwIGEgQlBGIHByb2dyYW0gdG8gdGhhdCB0cmFjZXBvaW50IHRoYXQgdGhlbiBjYWxs
cw0KPiA+IHJjdV9yZWFkX3VubG9ja190cmFjZSgpIC0+IHJjdV9yZWFkX3VubG9ja190cmFjZV9z
cGVjaWFsKCkuIEFsbCBvZg0KPiA+IHRoaXMgd2hpbGUgaG9sZGluZyB0aGUgcnEgYW5kIHBpIHNj
aGVkdWxlciBsb2Nrcy4NCj4gPg0KPiA+IFRoYXQncyBBIChycSBsb2NrKSAtPiBCIChydHBjcCBs
b2NrKS4NCg0KSW4gcmN1X3JlYWRfdW5sb2NrX3RyYWNlX3NwZWNpYWwoKSwgdGhlIHByZW1pc2Ug
b2YgYWNxdWlyaW5nIHRoZSBydHBjcCBsb2NrIGlzIHRoYXQNCmJlZm9yZSB0aGF0LCB3ZSBoYXZl
IHRhc2sgc3dpdGNoIGluIHRoZSByY3VfcmVhZF9sb2NrX3RyYWNlL3VubG9ja190cmFjZSBjcml0
aWNhbCBzZWN0aW9uLg0KYnV0IGFmdGVyIHdlIGFscmVhZHkgaG9sZCB0aGUgcnEgbG9jaywgbm8g
dGFzayBzd2l0Y2ggaXMgZ2VuZXJhdGVkIGluIHRoZQ0KcmN1X3JlYWRfbG9ja190cmFjZS91bmxv
Y2tfdHJhY2UgIGNyaXRpY2FsIHNlY3Rpb24uDQoNClBsZWFzZSBjb3JyZWN0IG1lIGlmIG15IHVu
ZGVyc3RhbmRpbmcgaXMgd3JvbmcuDQoNClRoYW5rcw0KWnFpYW5nDQoNCj4gPg0KPiA+IEluIGFu
b3RoZXIgcGF0aCwgeW91ciBjaGFuZ2UgYWRkcyB0aGUgZm9sbG93aW5nIGRlcGVuZGVuY3kgZHVl
IHRvIGRvaW5nDQo+ID4gd2FrZXVwIHVuZGVyIHRoZSBydHBjcCBsb2NrLg0KPiA+DQo+ID4gVGhh
dCdzIGNhbGxfcmN1X3Rhc2tzX2dlbmVyaWMoKSAtPiBCIChydHBjcCBsb2NrKSAtPiBBIChycSBs
b2NrKS4NCj4NCj4gSSB3b3VsZCBsaWtlIHRvIGNvcnJlY3QgdGhpcyBsYXN0IHN0YXRlbWVudC4g
VGhhdCBjYW5ub3QgaGFwcGVuIGJ1dA0KPiB0aGUgY29uY2VybiBJIGd1ZXNzIGlzLCBjYW4gdGhl
IGZvbGxvd2luZyBoYXBwZW4gZHVlIHRvIHRoZSBjaGFuZ2U/DQo+DQo+IGNhbGxfcmN1X3Rhc2tz
X2dlbmVyaWMoKSAtPiBCIChzb21lIEJQRiBsb2NrKSAtPiBBIChycSBsb2NrKQ0KPg0KPg0KPkFh
YXJnaCwgb25lIG1vcmUgY29ycmVjdGlvbjoNCj5CIChzb21lIEJQRiBsb2NrKSAtPiBjYWxsX3Jj
dV90YXNrc19nZW5lcmljKCkgLT4gIC0+IEEgKHJxIGxvY2spDQo+DQo+IDstKQ0KPg0KPi1Kb2Vs
DQo=
