Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D96D70CB67
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbjEVUm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjEVUm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:42:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9813110
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684788138; x=1716324138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WKQXYFDt3VNCQ2PYyEt8xTzRO7iT4j3S5VxXn2y8Qbs=;
  b=Fwmqx2WrdeW+ubHRC1nZHY9JTff57H5aufbhoMlBbD+/HxTj/dMd/hgo
   X2ybrCldnKPtHUngvH3PXNtaON1ou1H2YLSUjO4U0YkTnGsip0chX/eKA
   OvfzqE7X/gzaoPEeWh4gdwv7aZ4do9a/eNvM9DOLVCp4CCIhVwsyi422p
   /dh89jp6x/3mlTwzBKQ2gUJfzNF+h715G9eFiUNGoPEyQ1BESRYmzPvh9
   JZ5KxZQC3mDshEFewUYJPK4hEXW/nUdWL1YyAlPArDN4rNF5xPBmuGpJa
   wdGHR5O3e9dT+6N/8VCFhx/F+FmYjsWiG5DLqou7Q35msUJ3zVNPSmC6w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="350546012"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="350546012"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 13:42:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="773508311"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="773508311"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 22 May 2023 13:42:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 13:42:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 13:42:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 13:42:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIdgnEqRhYDG33C2QeSLQU2vUQDvLyk/UIWY71+6HR3HpWImaBlGeWh6JB7TLtbztwPAwZGbP6KJOjI/I25UalywK7VRiI1mPPXRPi5o2+kW/1YuAKeXe6Drzq4CDs/lt7Es0Kz8ifWUcfEdfYYjEijRH4aMS8KMmSYs/GL06aDhcx4DKPu+Vx3xItmbn9R1HxXXlA618EuKuZSaG2RflVwDEKFhWkq6s/l8PGiFG5eXxlUDLoxQJK1DpHAYXIjxlnuObQsU3+xtK5AqkDlV4zOTGIHF/6cSkslArWAZDytfmqe5/KOsBW1Vxf2p8d0I2XEp+jVie56+h8NLPmwbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKQXYFDt3VNCQ2PYyEt8xTzRO7iT4j3S5VxXn2y8Qbs=;
 b=f9HQsLC5ECNqJ1oMF6NdE+JtPOTWhHuna781dcDee81+jJ2FbBu5DnS6DAmiBzqPLX/KfgVXtQXUm7EDPkyqILWa7SspIDhKIg4W2EHXHul/n3bSKOrtKbftbp3Y1oEUlpdksmx29ujzoSPKFnTpTH4E8AZEmP1EJdK9I4UjhhDYTOMKdPrRGMTXHyPH5obx1P9f5Q44EIUGPnH4LaeB6RwX9gh6kTPpyBjAEH+DbM0VWlXvgk+uGDVWIOnaRSJiHc29KlpqQ0021YboQf8UNebQyBQwrppyZJxG/9dtvLZXbc5RTvWmXKjxPpuksm97rbHS7MrMjqnDHZXOtikLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB5155.namprd11.prod.outlook.com (2603:10b6:303:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 20:42:15 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6387.029; Mon, 22 May 2023
 20:42:15 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "alexey.v.bayduraev@linux.intel.com" 
        <alexey.v.bayduraev@linux.intel.com>,
        "Zhang, Tinghao" <tinghao.zhang@intel.com>
Subject: RE: [PATCH V2 1/6] perf/x86/intel: Add Grand Ridge and Sierra Forest
Thread-Topic: [PATCH V2 1/6] perf/x86/intel: Add Grand Ridge and Sierra Forest
Thread-Index: AQHZjOvilcELal0kyUWRoqbVSrXbL69mwPUQ
Date:   Mon, 22 May 2023 20:42:14 +0000
Message-ID: <SJ1PR11MB608304B3764CE30681B81DC5FC439@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <20230522202659.GC3334667@hirez.programming.kicks-ass.net>
In-Reply-To: <20230522202659.GC3334667@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB5155:EE_
x-ms-office365-filtering-correlation-id: a9c1d4ba-585d-428c-f45c-08db5b0506c6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KJE0wwYGc23DC23daqrwOmdgUPAFk1+ebqbjU+AQA7CwH/WyswUlmD6BabG+HhHFz13KxThA/uC5x2vl/HOxWvkvI+4lHl78hZSeozsBVYUhTbY1GZhDa5cdcjJAaSpCOkAmd1XkwgAoXOCi8wSdZAUG+tidhD+DjuSzDzc6fNJXH7MZ8yGbZY6r7rFm9dfWxoGgbKAmnRVwKBd4dT6YkEpOgYCNnHPX6+AcurfJscthCHgq/jL3/BxJv7qYW9UsrsHcyX42iTDOLFiFdq/6iZ4sZb5x3IyRhGrcii/CtqdsH1M6nQ64zp+ZrcZoRs2oUb8bdsqahufGH8eTVDt6Oi/CI3fDr3rxuLFB4R/JVPGGm5qCbHA9g7I/wE+JuO1d9UmSAYOgs4JRUmLbMSW9uJlgcra1K46K0Uw+X+oINRqrT8W7vK93LTPWFD1Wo8uliaz7OtKjj9Z14BHc6HWDqsEjpsV8kBSlziDLVt2JsYXe6T8Qc/iL06b/P7oKuqD2QVJ8G6EbvLEvPNXmNPj17obCi4KdhSAFTCfFQIV8KPaETnLvZykSfn2mKkU862HrMXDiOzNsVELixRdfWRRfOBXsGFXQuVY7QjDtZYabn3YyKBSKWXRTA1sDgO4LI+6x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(186003)(4744005)(2906002)(4326008)(66476007)(76116006)(66446008)(64756008)(66556008)(66946007)(41300700001)(7696005)(316002)(110136005)(54906003)(71200400001)(478600001)(7416002)(52536014)(5660300002)(9686003)(26005)(6506007)(8676002)(8936002)(55016003)(38070700005)(38100700002)(82960400001)(122000001)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YYTpoesA479YIpV4mYHj2TQ966T/TUFWf/NrHNx1oA3mXtC18olbPgsxacIV?=
 =?us-ascii?Q?/QUjMWpGWQmwqcv5iQzvHd7VWGZG+rGHCJnQ0Yd98Z4eTGwQpTHcvnPM1y/f?=
 =?us-ascii?Q?znwJfCFD2XZiuDlXjap5J5MhFMmxGPXz//bxU8CGxCetnU1z5TFqL5AUq2X7?=
 =?us-ascii?Q?Be8QkpW8dpmTTGmnr/IPmBtIW6RATrk1FJg/g29NgdwDzPoqNq36fcECOdC5?=
 =?us-ascii?Q?m0IuKhQw1C6KR+CMltgjw7p7E548kQSzYG/VXR9/9O7w9h3k6eZMihR9LrLo?=
 =?us-ascii?Q?hSco0vouX/vlwX9dpgnA9ntOXc2iTSC8x8o49MbT/qPeBf4RezDF7ajaTYeK?=
 =?us-ascii?Q?6GvOolGl0zqA+DcUS9WOSyn53wr1NJVUNTaXMttCZuoIPo/1gl1lLZKfINZd?=
 =?us-ascii?Q?lJeoKzgjVZIQjR/4ZQM2H9reLshzOFqDu/Bl1HWRtZFKQ+Mc8Nqspq1ODQX2?=
 =?us-ascii?Q?ZAX1mogfTdELbF2XG8aV5wt1gD1Q6CEN2JLEIOJRkiJu3iwbelbH8euaRD5s?=
 =?us-ascii?Q?LSc5RlvXogHTdV00j/bXcmeYhFDdeA7r37KouIUh+OMXG7OjZ8d8YWvLxSKQ?=
 =?us-ascii?Q?Gj5dRU1P+uusZTJ4CDfUPC5vJ/ewKXP4HpKBq2ADBfb+7UFnFxSfI6p6pOBo?=
 =?us-ascii?Q?1L5l3oakyx3E5PHWuv0l1JzI0ybIUYxPUqOsD/lwIK8hlP31Cx/zcEbq81Gv?=
 =?us-ascii?Q?9BG2sWXCgatae263SvZl+EHYBitBwmKHD5SPjjSvrJbfrrHUrAyEbE63r5vN?=
 =?us-ascii?Q?hp+YoFZkILi+El+WOhk7TvQAqGiXnxmVWbMj6v0tD2UDe2qvK6yAq0NrnKvN?=
 =?us-ascii?Q?k3jOrzSyLXQzMGap2D/Mwzp4vH8byax8dR51xN8+r2zvIWvSLzSjbA29J8hK?=
 =?us-ascii?Q?ReE7PNU5STa43L6y+5PeG9UqEqoISApdndQo0IZNhD7+J5u0dYQCvxfjQm4S?=
 =?us-ascii?Q?BroeFtonCJz+T6SZ+07N2E5hNOXQZR7hBKCn651/1IrUajxzNI66rIrRelA9?=
 =?us-ascii?Q?HTRKyfuPnN2EoXh/fPAJ7nq7tAC1+Gogl51I39D6vTne2s4J6ZSmiAklIeIb?=
 =?us-ascii?Q?tfr96gFcUyI5RP1FSyL6J+qT2Q0/rzdcDu+krd7oLAN9cyC/+Uvr/JLm9hy8?=
 =?us-ascii?Q?yb28B8p6G98X01nn9pH2jWENcf/wsqkV6B8CV3EI/rDCQ2jFzqxLcZcg74W8?=
 =?us-ascii?Q?I/c1Qk+b5KmpsDtuVW2B9S0KcbhBRmgZ6ipiYDL/47W6Kyo2tdAIKIxWjnZB?=
 =?us-ascii?Q?5B1wqL0/eyy2gMRXQlbB9JB1ET5Nk5GkwnBGlCBVX+h9Wk939LanTmn4L6Ps?=
 =?us-ascii?Q?Ecw7DPFoX2uJAUKmVKgilNTYyPnq3UooO01zE5My2EWCoO1Sc4fV6pFbrtN+?=
 =?us-ascii?Q?DsMgw0DGjbLnL6EML7UZioZpbQ6PcPzme6rrSUeVCjpyTah7XLbemCFKuh3i?=
 =?us-ascii?Q?pug7nMrpMxxNLCqXoPRJrYEuAFrf2p5E+2fMyK0T1wlgSrIDuT/rOu2h6Weg?=
 =?us-ascii?Q?f4jULZ1Z23hFkRDVdHX6n7y6Shzky8FJSAx3bTpEKrKp8ARkF8xZmFC6cVRY?=
 =?us-ascii?Q?PH3G7LQOFUSfvJmDqDM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c1d4ba-585d-428c-f45c-08db5b0506c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 20:42:14.9250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPHPsIjg4e7ZgdfRsT0fTp1huTrcz46H3PBYbmFA0A0tQtgqNgvUyPth726rPtOvoX+LV1XfKF0/ECHrSDf4Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5155
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Moo... Tony, did you sneak product names instead of uarch names in the
> intel-family thing again?

The difficult part is that I've finally got Intel to release product names =
reasonable
time ahead of launch. But details like which core architecture is used by e=
ach
lags behind.

But I think you just announced the Crestmont core.

-Tony
=20
