Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BB6738843
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjFUPBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjFUPAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:00:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0990D2681;
        Wed, 21 Jun 2023 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687359299; x=1718895299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IyQ6lbBu0GCZLbbfWjTWrvNoC/rrCB3yKMyS60KaXic=;
  b=HKxK9GKL/GLvTSFFaBBWqz5YeP4TYrqOwMcjsClEeSASYtQVeJ3K5kau
   9CEkGCc62sCOVTYoClWpQFyA+1XnfPNIQVT8/Ce2z7Ff8PKSh7rX1cmZs
   pSQnrprYlDL8h1NSKLwwp0tcfHcG755OyND9qs6vmB//8LpzRB+BQizBe
   68naU0gKa4bG5mELLL//ANYOWj6pHbPGzI0ouBa2r6hJFYdiJxv6BQPum
   z+eJQ3TVfHnpe3DASNKbvHCLIat1lbb+YspkIL6msFUqTf/TkyM+C6TOo
   emd35KzI9hE8rlFLd1TeN4ZheRSTN+x4cCEwu2BvImuR/cYms4WlkBs4x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="426148900"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="426148900"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:53:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="664693129"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664693129"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2023 07:53:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 07:53:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 07:53:50 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 07:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBlu7OJn7gNVU1w95YrDY8XuuMAvvAcuBbrLTT0QON4agzyJzd0TdBEcjn3Paw/vtwdmFisGWkHLh+sIxzstNa4H2fyFWF3gbjdls21VU2/1lqPLQ5ETxYAne+Q+s7cgOXhNqpqpxSItouE9eurJDbskX1Y4I1YhqYbtROpsbwrnQe3qsBRJuCqV4WjgDW8t5shS2x3idGd1MJEnU8rfeau/ZJ3tPYO7Li9orKaED8diK83s2dy9WsBnsH4DH068dflroTAYr/mP5bOdU22RWZbQ1Qu4jXFt6Mytaf6RRZaIh62t2zuk/DYquLwfY6DtO3uKC9PIxmXWE9WGz/b3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyQ6lbBu0GCZLbbfWjTWrvNoC/rrCB3yKMyS60KaXic=;
 b=BlCVKW//wL06G3jiDLoOV1M2aQ0H6v99Rh5QCP5BSUQLYQIVavECFjIE57Z3WndkwRxToF5El+xU1zts4Jg4ughQYbNrPXnG0M3U/IIAzXs0a8gia1dJLZ8bMsHSUiHkAZQbZMeYizJ6QpN9eEfsqXrDjdW9sUwxgUpXP/twJPkji/Qgl05XrjTTrUVlwbrUaW/UJUYo4HbKX824RQggHuQujK8y2Occ93654l5+MCcyJP9ScMZ3FZClun3VhuIKyZpeCA6weNksgVNEXvMV8ucPHadVyvcqfujpBwwGct4AodC1r+sSMs+g3e6kx63cyYKN6trOYklMq6f7oPYG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com (2603:10b6:a03:4ed::18)
 by PH7PR11MB7595.namprd11.prod.outlook.com (2603:10b6:510:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 14:53:48 +0000
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf]) by SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:53:47 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] thermal: int340x: processor_thermal: Use non MSI
 interrupts
Thread-Topic: [PATCH 3/7] thermal: int340x: processor_thermal: Use non MSI
 interrupts
Thread-Index: AQHZo8s5qC6nRCzyfUGuKM+M1sk886+VWLaA
Date:   Wed, 21 Jun 2023 14:53:47 +0000
Message-ID: <b692f9a983d45a50aeae43dce3082551059f6bfe.camel@intel.com>
References: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
         <20230620230150.3068704-4-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230620230150.3068704-4-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0SPRMB0086:EE_|PH7PR11MB7595:EE_
x-ms-office365-filtering-correlation-id: 94120b89-17d0-476f-73f0-08db7267518c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VWyXxCMgKaDuOQYRr2peogpG870lJUXs0EcAacdI/IHbNns+YPNyivBr6MphmpXoZWVqO8xoHA056Z/n17oi+Ki5ww0C833eE+EAlq6POjIPF8zHOsQ5ah/xQI5/i63UEFlib4hQNqIhLqZ1yAEFZ/m2grKrj4GiKnLTth4CxpgF39MlGC09xgOvDKdggdyfUvHbpjbfiqJXkWY3cbwFKgfi/LByl7lf4SS+EVB8dHl0v9KS0L3XWJOvfI8KCfY1WOIxyJnAmYTOISSwG94CSf21XMTHpbV/iEAyp5A0RoBQ5FGpTqK/jKoXWo/tkf0zdpuygLaap2KD8Gu0icE0E+Tu2O/2Enfmz7LTp80lIrlZw9N+u3aOccmN/gxkvq8edSuZpPYdyuo3hKJDhg6Bot7YzGmdlR0G9+AQSC2MxIyHWC4k0lgDlX7Tc8lL3+z/qAxvQLJyTAp3zxRxr7dTqFGEM1Cad1/TklsyTC+Abws89YXoPdzy4dxpoxnVkEftBJJNf5b+6uhTGr8M1tieH0eahWEmqMCIrIg7XuiHikzs3m36i3SkH7IgInQyh8w1340/3z2jtrQ9gYPLU2t70YXU6h6+uf/x1Uh62EqbR7+09Y68p749vNmIw/HO5zTy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0SPRMB0086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(6486002)(83380400001)(6506007)(6512007)(186003)(26005)(2616005)(36756003)(71200400001)(38100700002)(316002)(4326008)(76116006)(66946007)(66446008)(64756008)(66476007)(66556008)(2906002)(122000001)(91956017)(8676002)(8936002)(86362001)(82960400001)(5660300002)(38070700005)(41300700001)(54906003)(478600001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0hTRWVBNlFxYmRJQ1FYT0VURS9LanpvYVFjN3NPQ3lyUFhuOHl3R2p2SVpm?=
 =?utf-8?B?cnBoSGhqMnBOYVB0YjFTN0NjekVtOWNySkNWcHJ4RXdvMmhOdVYxSm85Qngr?=
 =?utf-8?B?SVJtYWdscGhCMndGUU02YjdKenN5MmZWWWFjRCt6VG1qNCt0UmY4TkhQeWFX?=
 =?utf-8?B?NGY2OGlkN1RuWHdjWXRSUXkyd1FkbFF5a2ZjajMxc2g3cWJjOVV6c2poRS9k?=
 =?utf-8?B?aUUwaVViekpORG4xbWNpdHp0K0srQ21ZSkVRdXJIVjh0a2VaZDExdXhMOE5N?=
 =?utf-8?B?VWhCMGg2MzRzWXZwbnZZZ2hNL3kxanppdW5PaDVHdTR3eHJjUXltbFhQL3ZZ?=
 =?utf-8?B?Z0F4ZmZ0VlVpTlJEcFlES0FwMlpLOFA1ZWMxcitpK1VJbThPVEpCSEw5OUVB?=
 =?utf-8?B?b2Z5UkpCZTRRVnFQYzNuaithaHJRUCtIY21XOFdCM3A0SWdkMlY5R2lqSTFN?=
 =?utf-8?B?TGNNNlNwS2lCYVJnUnc1ak1wcTF5Zi94NVVGVmw5NVBKVFdWNi9nK3ZhZDJn?=
 =?utf-8?B?Z2J2dXpVay9FODR0QmhRNVdDd3N5VjJSbmNRR3R1aWx3Q3dWcDh3R2lWSkM1?=
 =?utf-8?B?eTdvSmVqOFZ5dll6S2RQR3NvNTdOWXlvU2NnbXpYMjBvQ3VPbndsOS9FWCs4?=
 =?utf-8?B?b2ptWU1jM0JJZ296OWwwZi9GRmpXUEIxUHhjWWxNbmdWRnYxc0N2VGc2RW9v?=
 =?utf-8?B?Y2xRdWhOZUFDYkU2RXBQSi9hbExJZG5DRzBIRStGUkxtdU1SSUl4Zy9zM1hk?=
 =?utf-8?B?UU1FNytBeTBwR3hEUDVwLzZSUVY0cXZoa2ExVFBYWXBkT241VTZySEZrNUNG?=
 =?utf-8?B?S0tncXdXRnc0bmd2YlBIMkRTRmd4MWt1S3NRUUl4eDV0WkJ3K0dkVjVZSEN5?=
 =?utf-8?B?THNEbGIzdndLYitod0JzVjdRaFcwL0VkNlpvTnlZNFdGQWRGcDVzREZDSGJY?=
 =?utf-8?B?WTBFU3dKYzVXaHVWNjNBTlFFaXo0MnkyTzBtRGlIV0hJbGdMMFJ0ZXdoUzFk?=
 =?utf-8?B?b2RKc2NWb0NrTzBXSHRReGxQV3FBcUV3dld2RDd2T2dmNXBOSXZmd09Fcmpv?=
 =?utf-8?B?dWQzaFZJZzhWLy9Oait6NEhoalFaYjVweVJJRHVmUTJsek5Xam1FWGZXVm9u?=
 =?utf-8?B?YzZWbS8rcFE5UDBvbWNOWFIxRFg0M0RkK3FQRFJSdU5rTytIQnZ5V29VajNm?=
 =?utf-8?B?TWp4WEtCcWlWV2ZFcllZTkh0c2JYWU5VeVpzcnV6ZkNaR2ZVZ0NBNElJT0hY?=
 =?utf-8?B?WFRpUTRac2FmMHRUSnArSFlGZWJNYk1lODVQdkNSM2hCblU1bTZrT3Q0ejZV?=
 =?utf-8?B?YStCekc5VWFQSFhLaW5vckw5NmRmNnNYYVJBSUFrTDdZYnZwbnhUTG5YQ0dl?=
 =?utf-8?B?a0JEMlZPZDNaeUh1WEpwSXo3MFJWUEVGVEIzY29oeU1lZ3JTWkwvNVdmWkZn?=
 =?utf-8?B?SEtiYXRCMzZuNjluRnBXeUlJWU0yanZsSUZ2RERxNlpDcmVFL3BUMTFMM2pj?=
 =?utf-8?B?Z3crV2N6WUI0dVpNT1J4SVBxdUNJNjNFRVNxQXR5cDZ1ZGN1dk1mNXFHY1Q3?=
 =?utf-8?B?b0Q2N3Q2eEpmRFdkQkFJVFpLZWtkZ1VYcFZBaCtTcnV3TmcyYkVQelpHdDI0?=
 =?utf-8?B?eWFubC90UjdTR2tiYy9DVmlJZ21ZL1VSYzZQWEVhMGZ2aS9LN2dYVys5bmVE?=
 =?utf-8?B?TlUzOWI1c2NnNUlNa0Ezd204aDdPczBlb3pZNkpnTDg3MVc3M2dWclRsTUdt?=
 =?utf-8?B?ZmhDUkNxZkRwZVdKRFlQcm9rOGlNT21qNENwa0lxa0FabkF6bUxwSFhtSzgr?=
 =?utf-8?B?R1hrY1E3aEV6c2Y2dm9YK2hDd3d2SFlmenFCRGNYV2dMbXltTm5sUUJ1Wnhr?=
 =?utf-8?B?dHdxa205N3lxWlFialRYZmFRNXVGeE9abnpGR0FsZ0RmU054Y3Z4NWcreWh3?=
 =?utf-8?B?S25ZR2VqM1BkQk5QM2FIUXEzRTZDRWNLc2JBbVp0d3NQTDlHY1AxNWlNNFR5?=
 =?utf-8?B?TytrSUxrYlRHaEJwTkRJamRxN2hCT1UzY1RETXJGNEs0dTMvSlNrVzVFbUpu?=
 =?utf-8?B?bDg3UGZVeDRDMURlUmUzVVdKelR5cDhZd3FhZU03eVpZeFpXdDRHaFEzL3pP?=
 =?utf-8?B?WGVuQ2NuY25Jak0xamRHeEVvZm80TEorQUxBL1RscjlsK0lyTXRVTVNsOXEz?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F38D6EDA11B3A3409AA0090D3AA6EA01@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94120b89-17d0-476f-73f0-08db7267518c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 14:53:47.7860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QkUNlqPZDl/ju9bjM7Ozf/7jc81aC8jTek6IIC0Fda1LaYs8nm0y33G5NcY/w0CRElNXQdG2lfBfiZ1KjplpUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7595
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTIwIGF0IDE2OjAxIC0wNzAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdy
b3RlOgo+IFRoZXJlIGFyZSBpc3N1ZXMgaW4gdXNpbmcgTVNJIGludGVycnVwdHMgZm9yIHByb2Nl
c3NvciB0aGVybWFsCj4gZGV2aWNlLgo+IFRoZSBzdXBwb3J0IGlzIG5vdCBjb25zaXN0ZW50LCBh
Y3Jvc3MgZ2VuZXJhdGlvbnMuIEV2ZW4gaW4gdGhlIHNhbWUKPiBnZW5lcmF0aW9uLCB0aGVyZSBh
cmUgaXNzdWUgaW4gZ2V0dGluZyBpbnRlcnJ1cHRzIHZpYSBNU0kuCj4gCj4gSGVuY2UgYWx3YXlz
IHVzZSBsZWdhY3kgUENJIGludGVycnVwdHMgYnkgZGVmYXVsdCwgaW5zdGVhZCBvZiBNU0kuCj4g
QWRkIGEgbW9kdWxlIHBhcmFtIHRvIHVzZSBvZiBNU0ksIHNvIHRoYXQgTVNJIGNhbiBiZSBzdGls
bCB1c2VkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzIFBhbmRydXZhZGEKPiA8c3Jpbml2
YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+Cj4gLS0tCj4gwqAuLi4vcHJvY2Vzc29yX3Ro
ZXJtYWxfZGV2aWNlX3BjaS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDMzICsrKysrKysrKysr
Ky0tLS0tCj4gLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxMSBkZWxl
dGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0Cj4gYS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQw
eF90aGVybWFsL3Byb2Nlc3Nvcl90aGVybWFsX2RldmljZV9wY2kuCj4gYwo+IGIvZHJpdmVycy90
aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9wcm9jZXNzb3JfdGhlcm1hbF9kZXZpY2VfcGNp
Lgo+IGMKPiBpbmRleCA1YTJiY2ZmZjBhNjguLjA1Nzc3OGY3YmVjZSAxMDA2NDQKPiAtLS0KPiBh
L2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxf
ZGV2aWNlX3BjaS4KPiBjCj4gKysrCj4gYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90
aGVybWFsL3Byb2Nlc3Nvcl90aGVybWFsX2RldmljZV9wY2kuCj4gYwo+IEBAIC0xNSw2ICsxNSwx
MSBAQAo+IMKgCj4gwqAjZGVmaW5lIERSVl9OQU1FICJwcm9jX3RoZXJtYWxfcGNpIgo+IMKgCj4g
K3N0YXRpYyBpbnQgbXNpX2VuYWJsZWQ7Cj4gK21vZHVsZV9wYXJhbShtc2lfZW5hYmxlZCwgaW50
LCAwNjQ0KTsKCndoeSBub3QgdXNlCgpzdGF0aWMgYm9vbCBtc2lfZW5hYmxlZDsKbW9kdWxlX3Bh
cmFtcyhtc2lfZW5hYmxlZCwgYm9vbCwgMDY0NCk7Cgp0aGFua3MsCnJ1aQoKPiArTU9EVUxFX1BB
Uk1fREVTQyhtc2lfZW5hYmxlZCwKPiArwqDCoMKgwqDCoMKgwqAiVXNlIFBDSSBNU0kgYmFzZWQg
aW50ZXJydXB0cyBmb3IgcHJvY2Vzc29yIHRoZXJtYWwKPiBkZXZpY2UuIik7Cj4gKwo+IMKgc3Ry
dWN0IHByb2NfdGhlcm1hbF9wY2kgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGNpX2RldiAq
cGRldjsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHByb2NfdGhlcm1hbF9kZXZpY2UgKnByb2Nf
cHJpdjsKPiBAQCAtMjE5LDggKzIyNCw2IEBAIHN0YXRpYyBpbnQgcHJvY190aGVybWFsX3BjaV9w
cm9iZShzdHJ1Y3QgcGNpX2Rldgo+ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV8KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gwqDCoMKgwqDCoMKg
wqDCoH0KPiDCoAo+IC3CoMKgwqDCoMKgwqDCoHBjaV9zZXRfbWFzdGVyKHBkZXYpOwo+IC0KPiDC
oMKgwqDCoMKgwqDCoMKgSU5JVF9ERUxBWUVEX1dPUksoJnBjaV9pbmZvLT53b3JrLAo+IHByb2Nf
dGhlcm1hbF90aHJlc2hvbGRfd29ya19mbik7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcmV0ID0g
cHJvY190aGVybWFsX2FkZCgmcGRldi0+ZGV2LCBwcm9jX3ByaXYpOwo+IEBAIC0yNDgsMTYgKzI1
MSwyMyBAQCBzdGF0aWMgaW50IHByb2NfdGhlcm1hbF9wY2lfcHJvYmUoc3RydWN0Cj4gcGNpX2Rl
diAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBnb3RvIGVycl9yZXRfbW1pbzsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4g
LcKgwqDCoMKgwqDCoMKgLyogcmVxdWVzdCBhbmQgZW5hYmxlIGludGVycnVwdCAqLwo+IC3CoMKg
wqDCoMKgwqDCoHJldCA9IHBjaV9hbGxvY19pcnFfdmVjdG9ycyhwZGV2LCAxLCAxLCBQQ0lfSVJR
X0FMTF9UWVBFUyk7Cj4gLcKgwqDCoMKgwqDCoMKgaWYgKHJldCA8IDApIHsKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2VycigmcGRldi0+ZGV2LCAiRmFpbGVkIHRvIGFsbG9j
YXRlIHZlY3RvcnMhXG4iKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBl
cnJfcmV0X3R6b25lOwo+IC3CoMKgwqDCoMKgwqDCoH0KPiAtwqDCoMKgwqDCoMKgwqBpZiAoIXBk
ZXYtPm1zaV9lbmFibGVkICYmICFwZGV2LT5tc2l4X2VuYWJsZWQpCj4gK8KgwqDCoMKgwqDCoMKg
aWYgKG1zaV9lbmFibGVkKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBjaV9z
ZXRfbWFzdGVyKHBkZXYpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiByZXF1
ZXN0IGFuZCBlbmFibGUgaW50ZXJydXB0ICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldCA9IHBjaV9hbGxvY19pcnFfdmVjdG9ycyhwZGV2LCAxLCAxLAo+IFBDSV9JUlFfQUxM
X1RZUEVTKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCA8IDApIHsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIo
JnBkZXYtPmRldiwgIkZhaWxlZCB0byBhbGxvY2F0ZQo+IHZlY3RvcnMhXG4iKTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZXJyX3JldF90em9u
ZTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAoIXBkZXYtPm1zaV9lbmFibGVkICYmICFwZGV2LT5tc2l4X2VuYWJs
ZWQpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpcnFf
ZmxhZyA9IElSUUZfU0hBUkVEOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aXJxID3CoCBwY2lfaXJxX3ZlY3RvcihwZGV2LCAwKTsKPiArwqDCoMKgwqDCoMKgwqB9IGVsc2Ug
ewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaXJxX2ZsYWcgPSBJUlFGX1NIQVJF
RDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaXJxID0gcGRldi0+aXJxOwo+ICvC
oMKgwqDCoMKgwqDCoH0KPiDCoAo+IC3CoMKgwqDCoMKgwqDCoGlycSA9wqAgcGNpX2lycV92ZWN0
b3IocGRldiwgMCk7Cj4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IGRldm1fcmVxdWVzdF90aHJlYWRl
ZF9pcnEoJnBkZXYtPmRldiwgaXJxLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJvY190aGVy
bWFsX2lycV9oYW5kbGVyLAo+IE5VTEwsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpcnFfZmxh
ZywgS0JVSUxEX01PRE5BTUUsCj4gcGNpX2luZm8pOwo+IEBAIC0yNzMsNyArMjgzLDggQEAgc3Rh
dGljIGludCBwcm9jX3RoZXJtYWxfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2Cj4gKnBkZXYsIGNv
bnN0IHN0cnVjdCBwY2lfZGV2aWNlXwo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiDCoAo+
IMKgZXJyX2ZyZWVfdmVjdG9yczoKPiAtwqDCoMKgwqDCoMKgwqBwY2lfZnJlZV9pcnFfdmVjdG9y
cyhwZGV2KTsKPiArwqDCoMKgwqDCoMKgwqBpZiAobXNpX2VuYWJsZWQpCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHBjaV9mcmVlX2lycV92ZWN0b3JzKHBkZXYpOwo+IMKgZXJyX3Jl
dF90em9uZToKPiDCoMKgwqDCoMKgwqDCoMKgdGhlcm1hbF96b25lX2RldmljZV91bnJlZ2lzdGVy
KHBjaV9pbmZvLT50em9uZSk7Cj4gwqBlcnJfcmV0X21taW86Cgo=
