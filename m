Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD65467F3F5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjA1CXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1CXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:23:00 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7287124C99;
        Fri, 27 Jan 2023 18:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674872578; x=1706408578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8nHgnY6PYGkwxHAl+bVkhrLhK6sXZins7gY3CRPF3jg=;
  b=dluww7MAgGxvTuqk9BmF2PxMQBtD+lxn6WPK0PIZ0GUM7X/uh/8fGyIp
   dzUcYLA2yxOxpoiMeBtoBasd2Ger26j6CUnmfSoUKy7ImduKIshsGQZio
   LKSoXYfrh46fdRJiCF4jyr1sFozkCHXPv07wCtlPvuOzhyf+DYNUFE7ig
   XbfI0rz0i7Pa94LvuBWvs+UcbSwHHfsMOfEbwPTbksrtRpoY6U3yJ6i1d
   a+GYFkjogT3KqAv4grfhvhgVaCl5Qu/Go4TFRkaTXJ1JeRUEzWaPOBgpy
   yW0kCd/Bb1bCwJ2HXwzFcpD/JTTJfOtmhRG2Ukv/iH5vqjKbaN43m4w9i
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="391805170"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="391805170"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 18:22:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="726891708"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="726891708"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jan 2023 18:22:56 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 18:22:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 18:22:56 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 18:22:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmew4dWCvlxK2sNO4rEDyT6xIYj4UuF7OjQ9139/rWN2sGTehV7Jvs/Fm3dexOhattGcEls72ru4TsASz9UzhLXixUeUGN0sdoWdW4ceYYKyPhvdvp7PVmXCrH1b+IQwbEdW4b50Ex7dRljRwEXn3DYOthxWhblrkjAxkpzkXRwdZZ1QRF5dWwL9nxRDGNzArcKsyTSKcdqK34ZaUAZhe0TzABqekHVTYPd++eGDIIKBHC5Pa8MrA0tpepLf/Qb4NUP84MRRKXC3MUFZLbzXr9PvP5MvKRqmBZlDlxM/M6YavpTJDxOKmAzg5K2nx1ZmPXxLoWleqenSJHqOjRpIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nHgnY6PYGkwxHAl+bVkhrLhK6sXZins7gY3CRPF3jg=;
 b=Y6nUaWCnsTelfJsUhqF++f8uU0EazCXW3PpXnPocLPsKTvLKAvjiRZvtAkEog0UYTzszm1MY5zr2cbVmvTdOVMPR25GYk95bHCI9pbtnpnGCXhmp83BpQkMoFtIjHCv2U3Dwh5YId4rExsN2tIM28hyqPT+PNWT1aX8h91GR71msLec4dZurnr7P3z6JwiTJAUz2Q9wvqnWWe3EpFXUWhFxaYKeMXUhVBWAjMwuexGZofdLYvWQobQ9RIFwE4iz9Ld0AwBTgUM5ugZPSLB3H449bpxt1xyDKqfdPP56Cx5bT6P0l2IGKT8NPGacF5tu3opydMr8Mjcnrz7ehRnDoVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS0PR11MB6398.namprd11.prod.outlook.com (2603:10b6:8:c9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22; Sat, 28 Jan 2023 02:22:51 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%8]) with mapi id 15.20.5986.018; Sat, 28 Jan 2023
 02:22:51 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 3/7] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Thread-Topic: [PATCH 3/7] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Thread-Index: AQHZMbXlA1Use0JcAUCVct/GPJuaw66yk/yA
Date:   Sat, 28 Jan 2023 02:22:50 +0000
Message-ID: <IA1PR11MB60973088DE64D7076BE889569BCD9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-4-tony.luck@intel.com>
In-Reply-To: <20230126184157.27626-4-tony.luck@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR11MB7296.namprd11.prod.outlook.com
 (15.20.6043.007)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|DS0PR11MB6398:EE_
x-ms-office365-filtering-correlation-id: 313c3a5f-7754-4222-23a9-08db00d68e14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 75FRsaQ1Jl7sASVxu8wwAqiDwo+0VURR8XqmUClKuER3BleLknnPJM2BrF7gCYX8bAo8zXYTRHygGIaVCf3tMchzhV2JRMBOK9W3vrJBUBl/MnHEaQTblYRePc0XO288AOPoOx1j+WtWH5w+Jo29YO8YcYW9q4sZ8K14t+69UTp7nd+j3bngnUUIiIvwr1e368c674yBglqrnwmaJ6m9m+bANzuGPvWPcqPLPIk8FreSdRtljYTcNM+FIQP2OlBhasCDEVEjU7Ffdstmz5cs4wOBaHdjExvFWHfYIHzoEGEFuDnhI8qWntqhHrF3lrU43159FYDjnBtxB/KyNN/MYOWPcO5dtMgqbceuBBVXD0hwrU7F8UwLxokp4L89Vu8bE6jbPqHp27lZNaSL0CW4xVDZXPXB6IbWmtjhjRSEjwZ6fb9Z6VtyPzjgfCeur5Sa3bTSn02QGdNnS+udXp2FLkoY1fM9R1exdlVmPb1qgH8ZJB4qUzBtOobEEk6tvNzCDIFwSduHPjtPdRPcneHwzTGDCWpiOVDVpGx8teBxka9PPy/is7CYMxpqquPXGyhmRkydmPnpW3fHvhQRGaTT0nGyzLCvQANXTlArytVl216dhbVyAvADOWKWbUsAYwKa/4uFLpRTKOomGlJ2ozACjgiDTl1yxr3BXu4uhw1VmmwY/x1+crUTCs+nLYV37Dc464AVYgI8l2YbJHwD5/J1/zFxyT9lBuOPPRdYAKdXZVQnJiannvn/IdYl42l5Gqc6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199018)(9686003)(38070700005)(186003)(53546011)(26005)(86362001)(71200400001)(7696005)(55016003)(66446008)(54906003)(4326008)(316002)(64756008)(8676002)(33656002)(66476007)(66556008)(41300700001)(66946007)(478600001)(76116006)(4744005)(110136005)(122000001)(6506007)(38100700002)(8936002)(7416002)(52536014)(5660300002)(82960400001)(2906002)(65966003)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3ozZE4raFZ0UHhJV2VkeU9iemVHeGJ2Z2hab3JBNGhkY2dtTFJGTjZnNVJx?=
 =?utf-8?B?YlFSUytlNHh1TUdweTRmcVFKRWJ3aWJvUGk1NGdnYm1UR0k0Nmx1aDV4UUFQ?=
 =?utf-8?B?RitRK0luYU5lRUpNQmRWOW9KMDJEY2pydFJ0VGs0eUFvUWpnQkFxZW1pSHlF?=
 =?utf-8?B?ZFNLR1FKNWhYU1ZjL2NUSGg0ZnRXNTUvaVpXWHRLT3RRbEN6SlhnRXh5N3Jn?=
 =?utf-8?B?am1XV2d2SEtoL0JET1E4RGdITEJTUVA3S0tuZytxKzByZkIrVmwza3ZxK01j?=
 =?utf-8?B?SlBKUEdDSDlaaWtYc1BRUDVXYTUxQk56UGFkaldqSG9ZbzFmWDRmaHZQM3pu?=
 =?utf-8?B?dE90ZHNTWWJwQUc2NnY5cVRhWnRkeWo2RERUelVPWkFsU2NNc2pzUVlJSG90?=
 =?utf-8?B?TVJXNlJCWEtRc2xiWnF5Z0Q5VXFmNjNXVE1CTXd3WTl1MTgxSHZrdkI2cGlU?=
 =?utf-8?B?WEFqUkJ6ZXpkN1lYK0hFNnJCUE9RdzFIZ29lTVZpQnBadDVFUzAzUXYrRTA2?=
 =?utf-8?B?QTIzblN4N2R6M3l1ZlFZeDlUcjB4SThsK3lxb3dFcVUvdVUyZlMxMDRQTE9p?=
 =?utf-8?B?WDBsM2FTSFBwU21WSGFrM3VKUnEyU21JRVJSR3BJZWFrYUNWYXdOWXRFRVUx?=
 =?utf-8?B?UnRpUE5KRndwMi9MRXlhTDR4dGU1VjNMT1VlbHpobE9vT0tXNkNDbXJOS0U2?=
 =?utf-8?B?aEZpUlNVY3BrMXFMV1p0UVRCaEU2WGxMQ25oZ3NTRmhOWGhZVFFPRGhGdlRm?=
 =?utf-8?B?WE5FTkxJM2Y4YmVnMGpwMDh5M2ZySXNZckpnWVBkL3RNYVNRSXRTMXZtZVMy?=
 =?utf-8?B?ejdQWklsbkZBcGJOTmhrNnYzMTJEL2VLaTlZdFlleUhOcms1bkJNRWtRLzdN?=
 =?utf-8?B?MlozcWRLVmdxK0QyZzZVK0N5WkVkUENyQnI0RUNGU2UxZ0MzNGQ3azREQTNN?=
 =?utf-8?B?NVJCSENseDA1VmpDTS8wTU4rbW45OVRmRDlhd0F1T3NVdURoZ1ViZlpPQXRk?=
 =?utf-8?B?MWpXWm9Fb2hMMVY5MjZUN1NQUjVZS3FQQXhOZDI2bXJ3MWlLblcydHBlY0pP?=
 =?utf-8?B?aTBGTzFpSVV2Z0NOS3RabTg3U1ppRHVGZHZpYXpWQ0lHOFg0amw3b1FDT0oz?=
 =?utf-8?B?OTJoOEU2aEw4TVNkajMzdUpKdEhyU0xSRlYyY2ZEdzFpL1p0WHhMdGN5ZFNi?=
 =?utf-8?B?SWtONGE4V29KeWxlNGtTYzlHSm5xRVlYRFJsdlZUU1ZySXBxbGt4YW1QVko0?=
 =?utf-8?B?Wm8yZUEwT2Y2U2taRmxGd2pVYmwxTWpiL1JveVpUeGdENmlyZTl3dXU5cFU1?=
 =?utf-8?B?NmJIa3NBNWJ3M0xPVWMvTVRpRmlsQTN2WU1yT28xYno5Z0N0QVNKbHcyamJN?=
 =?utf-8?B?WWpmREgzRDU2WDcyaHFtb3hxUXNMdW55SXZTUlVyUHYwWnM5dFh0Ty84UTBv?=
 =?utf-8?B?UnB1QlF3YU5UMFhGUFRVYUQ3ai9uR2dpelB1QWpUN25WVFRQMlpPSkdQeWVt?=
 =?utf-8?B?NnNzVmFsQlZzZ1dBOEZPTi9vUEI1VENWL25uQjZCb1ZoazBBb3NFQlROZW9n?=
 =?utf-8?B?MFllRGpGc2NtaDBOa21TQ1plamkzd1Q2Ni9ZUlpPUmhBV3p5czFReTVxQ2I4?=
 =?utf-8?B?TkRSWVlqRVp6Wis3NlhBWVNJNi9lQ3dOVWpvbHpDNGxsQjg4ZTdUbVNQYmRq?=
 =?utf-8?B?K0lpRU8vUG5uOFVKNWpodEdZNlhhNkhjSHc3RjFpTFllY1Z2MnNFSUU0Nk9N?=
 =?utf-8?B?VzRPNEVRemM4bFg3ODVQRXU3cDRGV2Y0VWMyblQ3S0pSODZ6bm41VDM4Y1VF?=
 =?utf-8?B?bFlua05CMEJ0SUh1QU13cGo2Sld0STdBUG5NTWg3elRxQUMxL25lLzkxaXh2?=
 =?utf-8?B?elNkOGRqMDVkREtIR2NYdDJISHo2bFREMFlCYjNaOEtLMkJhczN0MHg5WU9O?=
 =?utf-8?B?OEVqeG1LVlhLYmt1MTRTODBmRjNmbm1oNElVMVpUUFNXTy83WWk3ZGtGdDJo?=
 =?utf-8?B?UmNDeW1WdE5VSm1WdDdWOERwY05aMGYxQVZkMHpMRUlONWpWaDVndjRleEdO?=
 =?utf-8?B?L3RkSzBONzV5NWJ4RHpjTmRhNEp5MU9yb0NXR2tndkduWkZZMDFlWk1lSk1K?=
 =?utf-8?Q?t6cq3oR99teBdlDgiEm5s70rs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE4303825D0D2445BA938432DEA01BCA@intel.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313c3a5f-7754-4222-23a9-08db00d68e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2023 02:22:50.9118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: miGh/I+8KLsXHXql26c6Nnrbc9TBlFbhQadpKRGRZ7iU12eJJhnUU4wzab4p8y9/Se8g4YB+0miwDKXCPzbHJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6398
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFRvbnksDQoNCk9uIDEvMjYvMjMgMTA6NDEsIFRvbnkgTHVjayB3cm90ZToNCj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jb3JlLmMgYi9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L3Jlc2N0cmwvY29yZS5jDQo+IGluZGV4IDY5MTQyMzJhY2Y4NC4uMTliZTZmZTQyZWYz
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvY29yZS5jDQo+ICsr
KyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jb3JlLmMNCj4gQEAgLTEwMCw2ICsxMDAs
MTYgQEAgc3RydWN0IHJkdF9od19yZXNvdXJjZSByZHRfcmVzb3VyY2VzX2FsbFtdID0gew0KPiAg
IAkJCS5mZmxhZ3MJCQk9IFJGVFlQRV9SRVNfTUIsDQo+ICAgCQl9LA0KPiAgIAl9LA0KPiArCVtS
RFRfUkVTT1VSQ0VfTk9ERV0gPQ0KPiArCXsNCj4gKwkJLnJfcmVzY3RybCA9IHsNCj4gKwkJCS5y
aWQJCQk9IFJEVF9SRVNPVVJDRV9OT0RFLA0KPiArCQkJLm5hbWUJCQk9ICJMMyIsDQo+ICsJCQku
c2NvcGUJCQk9IFNDT1BFX05PREUsDQo+ICsJCQkuZG9tYWlucwkJPSBkb21haW5faW5pdChSRFRf
UkVTT1VSQ0VfTk9ERSksDQo+ICsJCQkuZmZsYWdzCQkJPSBSRlRZUEVfUkVTX01CLA0KDQpSRlRZ
UEVfUkVTX01CIGlzIGZvciB0aGUgcmVzb3VyY2UgdG8gYWRkIHNvbWUgZmlsZXMgaW4gaW5mby9N
Qi4NCkJ1dCB0aGUgTk9ERSByZXNvdXJjZSBkb2Vzbid0IGhhdmUgYW55IGZpbGVzIHRvIHNob3cg
aW4gaW5mby9NQi4NCg0KT25seSBzaG93biBmaWxlIGZvciB0aGUgTk9ERSByZXNvdXJjZSBpcyBp
bmZvL0wzX01PTi9zbmNfd2F5cy4gQnV0IHRoaXMNCmZpbGUgZG9lc24ndCBuZWVkIHRvIHNldCBm
ZmxhZ3MuDQoNCk1heWJlDQoNClRoYW5rcy4NCg0KLUZlbmdodWENCg==
