Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2532474ACD8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjGGIZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGGIZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:25:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F158EBC;
        Fri,  7 Jul 2023 01:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688718324; x=1720254324;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=imlbfSokQuKqmKDRmHF1+s4aY+g33c6y/TQaNZWmBbk=;
  b=jmEs2iNyzWgIv03r6XReOjoFA+ZLwJq3HFWCHa5qB9L2Tc4P42DuMb6U
   mUoaef6kKFe8FMP4GOaebn48lP6je8mMyYr7+XtOzbSAkb4PQXy3pci0r
   0KiM3gQOTQzI2SWXQcSBla8QSO4dhmtKk+S3Mp+O3cwY3Sywoje9yUaFi
   Q3/IP16W2dnEl0acRRK6K5C2mbLf8+/+MRyToEXTPNq2VIVkeTuxYPypD
   Ezc0TlMlHszwUNXYJv2jRGD6USwR+5WjBHCIbkjpUvAdUpVPaTeKMUWBF
   I3RtZH/SdCTdBsQvdRmz5ri5tkERm9JjDkUb253QIZnCh3KekXZZImV4f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="429900413"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="429900413"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 01:25:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="713935647"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="713935647"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2023 01:25:23 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 01:25:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 01:25:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 01:25:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuWG0p0KBHyPDAlQt4cqo1ZJl4Jl+JITiZLL4ibOEhZP20JltrMrLzNSElR76gyQ26xkO1Wfc88XvPI2L3jK15jkpeHrWNd3kKbtLVX+P+wQTgQFI9cyPdszSo+3jLbZIT0dFgSL24kwdea4coNk/v1TEyfOVFQWXq17kkQgsBurTzs9/LnzJIrHkh+h+ajq6HNln6fq/z+B6a2hoEtEr5vjn9MB0LcaTM9za5YQOgUmvlWDvdH7T7IKPrjDXh+yheJdtc16lDYw5MnkB1J8SLTuLeuO0qFA9qW6iQAoJ6aUCjqlyEuohMZSCX2bK5isIJ+tSgRAyUpTpWe8tVO9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYG26/uAg824u2xaUqhAU5/piXbEkvBZLRWu0ibaJeY=;
 b=WgZcP1ogoKyK8sk9AEllnwuF6hEYyUmWO2ZO33FoGLyKgNzxIVgJKcuD/lZaQxtOtgw5GJip0PJXoTanpvfsZ1KJpZEQSXK11X7Sg0i7rlUPJPdxH6lT/GCueiNBQF7gztqHnHhJmJgK3+1Lb58/VPCiDbTA133M1+202XGTFCeBkuE017EiMNjHZlYIXp6Ks37fP4OzmzTq48HWd437R97H6sVBvNLHrGqcWw0ByXfyZKkflRlpr0lrh9WppUthJmC4JusheDZwyjx3HXzH3EhD86DduXztMqwd9DChI9V7W7Mo0W4u7hKVavhN5Ci9POabpMhyTwXuwgscANbQGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SA2PR11MB4956.namprd11.prod.outlook.com (2603:10b6:806:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 08:25:18 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::9d13:9b68:918b:440f]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::9d13:9b68:918b:440f%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 08:25:18 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Baruch, Yaara" <yaara.baruch@intel.com>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>
Subject: [Regression][BISECTED] kernel boot hang after 19898ce9cf8a ("wifi:
 iwlwifi: split 22000.c into multiple files")
Thread-Topic: [Regression][BISECTED] kernel boot hang after 19898ce9cf8a
 ("wifi: iwlwifi: split 22000.c into multiple files")
Thread-Index: AQHZsKyQVsJac0DEX0yOQldskAnw0Q==
Date:   Fri, 7 Jul 2023 08:25:18 +0000
Message-ID: <b533071f38804247f06da9e52a04f15cce7a3836.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SA2PR11MB4956:EE_
x-ms-office365-filtering-correlation-id: e1bfaa47-9604-47b5-344b-08db7ec3b28e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zJzEb5unOhmuZXAXjR1XupHP89Jivrh0b15jg/qERVCsmdlQIVm7n43UXAxud08VzviamU3CLYmxukrAFSYgx/tllwvaM4Z0HhbWdzaYWO41nAeZB/yZKp9QgRTezVe4aXrQit3sV4cjXYjUzteYZqQyMW7ZNu+Uv8RghjMSCBDRm071U3077b90UuEsmlOvE3AivX0/R4IsfcyIwJJsBH4BRc80z4blBOEnJq06LA7g3cFpUR2pCAJlnKikML66QzFSJthiSHIPihGsTqVHBLyFsds3wgcd6Ro7S8QEFykgWhQEe3RQfbX0V6NdqMLKUKF7oq9vFRMUFZ5IE6TrkcKElVZFiMTK19GfjCP+HEr2XfhQs8POGzVV1aQS21VYxNY/9INKD8pCgRBKU9+o6dywbrmuRkUWSWobq+88qSM5RT+X/UqluIVwaTZ2bsl7pH+Lo/Uw7Hp9N5iimpC3ZtPab80nJhcO+0q/HdsvibjIldrbAtObthnueivh71eDGDbrcEFOsCRWX9chxgzhkCMWCQX+efJVa+oPNH0FIidXs16iDYxS37BjlqScC5IEU4ONse9Ln+ugohGgozWNAu+DYNPTqMyOvsb++h27LDM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(83380400001)(2616005)(2906002)(66476007)(66446008)(64756008)(66556008)(6636002)(4326008)(6486002)(66946007)(450100002)(91956017)(76116006)(316002)(110136005)(54906003)(478600001)(71200400001)(966005)(26005)(5660300002)(107886003)(6506007)(186003)(41300700001)(6512007)(8936002)(8676002)(38100700002)(122000001)(99936003)(82960400001)(36756003)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aitFd0xRd0RWOGl3d3N3Zi84VmR3QUZ0MVJCVFZGdytLaXdYVG0wcCtFK1Z1?=
 =?utf-8?B?WmxzVFYycjFDWWY5S0Fnc0VqZ1JRS2hxUXgwcWdNWlE1MXdaazlaSC91cWQr?=
 =?utf-8?B?dkdiUHR2YUJrRFJ3SnZnL1djZ1A5ZVpDZmcvcy95cnJ3Z2RMejlKOHhmTmRq?=
 =?utf-8?B?U0l5MENTRUxyQnM5K0JNZmNLdVBvck1EZG1QMm95OUIrdHEwOTcrWXl6N21R?=
 =?utf-8?B?NVlaTmI0UkxOZ1E1b21YWmFRRWtKQURkQm4yOGQyZmRjNjFGNDNFSVFJZlVX?=
 =?utf-8?B?M3UwVVZ5ak02N2pkU0MyeXhnUVdPeFYzeGg2cFMyU095Z3g2a2FsQy9Ec0xr?=
 =?utf-8?B?bDE1bGNVM3BkSHZFdlkxckF1MG5tcXJnaUQ5N2oyS1FDZmhPc2VKa0dOZDR5?=
 =?utf-8?B?ZmtKRHNrem1XZjNPdHlaU0s1T3JIN2JMYWQ3M0FSUEZLNVpJa25wQWhJSFBx?=
 =?utf-8?B?OGpldVJ3NEZqQW5HQi9zY2owTm5peGFWdWxBVk9KVm1FcVN0Rkx2M1NNMWpH?=
 =?utf-8?B?a2ZuL3RsV3VqOUIzMlRyU25HRHZIR1IranZxaURPSGFrYVQzOTZ0Rk5Ccy9I?=
 =?utf-8?B?TVQ5cm91UGxWdjJNL2hCZ3RFcXRlaXo2SUJ5M2lGcmNacHloc1dHanB1czQ4?=
 =?utf-8?B?RENxWHF4Q0JuZnkxUUJ2UjkvcDJhUHZKNXdrWU0xMWVnOXFrQkxucm50ZTRH?=
 =?utf-8?B?cG5CTGlmOFIyR2l4Ynk2c09kYmFmWGtmU0NzeExldGR4KzVJR2V3ZTlyYzFK?=
 =?utf-8?B?by9OSEdzWHRiNHh5RHc5TUY1YWhGdlI4TGFZZDdjSmVTUldSYlhVTnRWMTEw?=
 =?utf-8?B?ZXdTeFEvUjdEODRmb3IxOU9OY3hnclFGOFdqZWRWdHhGeko1YUVJVWtzVWEv?=
 =?utf-8?B?OHhCRjhsWG94Q0h1VnZia3gvWndTNjRINzgydkxFRk13MzE1dnI2dE1HYW9i?=
 =?utf-8?B?RVU5SnVTaWoxSm9qRm5KVVFzUXVxQ2tSRVRJcDkySlJ1TlpRVldyNEZGN0tH?=
 =?utf-8?B?Mmpvb01vbE9lVncyaVMxb1h2NWNxTk85WDVSZ3V6alhsdnpnMHRuT1FuQ25p?=
 =?utf-8?B?ZUFZTFV0aWtCdHptZW42RFhScUVuQkJuZTJ4elM4MWxjOTFsZVFJWE90SUVX?=
 =?utf-8?B?dEh1a0RITHFsbER5anBkek50SnVidm5IWDNJejc3Q0tlQnc5ZkVOSWo0aTZG?=
 =?utf-8?B?WkVmS2FYK1hGVHE3bktqL09tb2tVS0NnNmFzbnVZdWQreStUWnlxekZWelJs?=
 =?utf-8?B?b1o4aTB0dUdKUkhNU00xTzVvdVVyZWtlaUpDdnhJcGNSNS9mMWVBa0ZiaExN?=
 =?utf-8?B?S0xNT0ZRdWIzOFJDSTkxb1FZS2hlM2Z3aEw5OExqWXFHK3JaUzZHK2hOZ3hR?=
 =?utf-8?B?Nng5ckRvWXE4S2VHQm83RGFEemN5MHNiTXpVeWpnc3k4UVB3d291enZxNzRy?=
 =?utf-8?B?SXo5WGpyWUUxOEhUY085YnMzVi9MdGE0QXNrTWRTT3F3RXYycW0yOFZ6anR0?=
 =?utf-8?B?RlhxK1lVYzMrdVVUbFdJRjlISHRYckhmcUVVTWNtenBvQnppUE52NTRoOGRO?=
 =?utf-8?B?MzlZUDVLdXhMaVBBU3kxZDhkLzdQNEdzSWc0U2hybnYyR1BxdWJERUVGTHdB?=
 =?utf-8?B?dFBKcGczQnQ3dlRYdytxeEFXSkJuazB5Si9EUmhmK1o3cFJJYlQxUHE3YVlO?=
 =?utf-8?B?dndzbTdmOXZXc2FCMGNmYXJrZmdyTmxFM2NkN2IvY1Evclh5U3RHK2RrYVE2?=
 =?utf-8?B?aXJIbE5pVnJLOFlGallLVFhKUDN0UGlLTVVOZHRocVE2N2FaQW5sam9EQkkw?=
 =?utf-8?B?WE8vbk1UeWxWcjlrK011RnZWYU5ySHlGVlc1ejFtRWNhRnB2REZ6Z2x3ditN?=
 =?utf-8?B?NmJhR3pXVms5d05mU3Z5clhRUGlQWkhvR2Y5d1dpbVNXakFyYkZmejlLampE?=
 =?utf-8?B?dUpySjViVDNrZVFKUnEvTFVpdWh3MzFQOXdtQ252VGpwY3RoOXFGUnk4U2Fu?=
 =?utf-8?B?dmFGSGNBa3BaNnV0RkNDTE1qbDY3M2w5R3E5UE1uZUxkWHhGcDVjWVZFVGUz?=
 =?utf-8?B?WUtTYm1QUWV4M2VMVkJCQjhFa2p6SVRkUnBaTnl4S2hZV2N5REx1eUV1V0Er?=
 =?utf-8?Q?R7q5GeNuzB79TKOnD4kx30n7v?=
Content-Type: multipart/mixed;
        boundary="_003_b533071f38804247f06da9e52a04f15cce7a3836camelintelcom_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bfaa47-9604-47b5-344b-08db7ec3b28e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 08:25:18.2375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TYOd/MBf3SuehVOAsf/G3t8/I6J9z6cJv3W9hkLuT9vnPE0xzysQEjbGTSwE0wjMCRql+Y8VA1OrKn7/hePhpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4956
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

--_003_b533071f38804247f06da9e52a04f15cce7a3836camelintelcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BC5934291535A41B3D55239CC13BB7E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

SGksIGFsbCwNCg0KSSBydW4gaW50byBhIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhbmQga2Vy
bmVsIGJvb3QgaGFuZyBhZnRlcg0Kc3dpdGNoaW5nIHRvIGxhdGVzdCB1cHN0cmVhbSBrZXJuZWws
IGFuZCBnaXQgYmlzZWN0IHNob3dzIHRoYXQgYmVsb3cNCmNvbW1pdCBpcyB0aGUgZmlyc3Qgb2Zm
ZW5kaW5nIGNvbW1pdCwgYW5kIEkgaGF2ZSBjb25maXJtZWQgdGhhdCBjb21taXQNCjE5ODk4Y2U5
Y2Y4YSBoYXMgdGhlIGlzc3VlIHdoaWxlIDE5ODk4Y2U5Y2Y4YX4xIGRvZXMgbm90Lg0KDQpjb21t
aXQgMTk4OThjZTljZjhhMzNlMGFjMzVjYjRjN2Y2OGRlMjk3Y2M5M2NiMiAocmVmcy9iaXNlY3Qv
YmFkKQ0KQXV0aG9yOiAgICAgSm9oYW5uZXMgQmVyZyA8am9oYW5uZXMuYmVyZ0BpbnRlbC5jb20+
DQpBdXRob3JEYXRlOiBXZWQgSnVuIDIxIDEzOjEyOjA3IDIwMjMgKzAzMDANCkNvbW1pdDogICAg
IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzLmJlcmdAaW50ZWwuY29tPg0KQ29tbWl0RGF0ZTogV2Vk
IEp1biAyMSAxNDowNzowMCAyMDIzICswMjAwDQoNCiAgICB3aWZpOiBpd2x3aWZpOiBzcGxpdCAy
MjAwMC5jIGludG8gbXVsdGlwbGUgZmlsZXMNCiAgICANCiAgICBTcGxpdCB0aGUgY29uZmlndXJh
dGlvbiBsaXN0IGluIDIyMDAwLmMgaW50byBmb3VyIG5ldyBmaWxlcywNCiAgICBwZXIgbmV3IGRl
dmljZSBmYW1pbHksIHNvIHdlIGRvbid0IGhhdmUgdGhpcyBodWdlIHVudXNhYmxlDQogICAgZmls
ZS4gWWVzLCB0aGlzIGR1cGxpY2F0ZXMgYSBmZXcgc21hbGwgdGhpbmdzLCBidXQgdGhhdCdzDQog
ICAgc3RpbGwgbXVjaCBiZXR0ZXIgdGhhbiB3aGF0IHdlIGhhdmUgbm93Lg0KICAgIA0KICAgIFNp
Z25lZC1vZmYtYnk6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzLmJlcmdAaW50ZWwuY29tPg0KICAg
IFNpZ25lZC1vZmYtYnk6IEdyZWdvcnkgR3JlZW5tYW4gPGdyZWdvcnkuZ3JlZW5tYW5AaW50ZWwu
Y29tPg0KICAgIExpbms6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNjIxMTMwNDQz
Ljc1NDM2MDNiMmVlNy5JYThkZDU0MjE2ZDM0MWVmMWRkYzA1MzFmMmM5YWEzMGQzMDUzNmE1ZEBj
aGFuZ2VpZA0KICAgIFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzLmJlcmdA
aW50ZWwuY29tPg0KDQpJIGhhdmUgc29tZSBzY3JlZW5zaG90cyB3aGljaCBzaG93IHRoYXQgUklQ
IHBvaW50cyB0byBpd2xfbWVtX2ZyZWVfc2tiLA0KSSBjYW4gY3JlYXRlIGEga2VybmVsIGJ1Z3pp
bGxhIGFuZCBhdHRhY2ggdGhlIHNjcmVlbnNob3RzIHRoZXJlIGlmDQpuZWVkZWQuDQoNCkJUVywg
bHNwY2kgb3V0cHV0IG9mIHRoZSB3aWZpIGRldmljZSBhbmQgZ2l0IGJpc2VjdCBsb2cgYXR0YWNo
ZWQuDQoNCklmIGFueSBvdGhlciBpbmZvcm1hdGlvbiBuZWVkZWQsIHBsZWFzZSBsZXQgbWUga25v
dy4NCg0KdGhhbmtzLA0KcnVpDQoNCg==

--_003_b533071f38804247f06da9e52a04f15cce7a3836camelintelcom_
Content-Type: text/plain; name="lspci-iwlwifi"
Content-Description: lspci-iwlwifi
Content-Disposition: attachment; filename="lspci-iwlwifi"; size=2634;
	creation-date="Fri, 07 Jul 2023 08:25:18 GMT";
	modification-date="Fri, 07 Jul 2023 08:25:18 GMT"
Content-ID: <2AB54029F54B044E83C64751281AF0DF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

MDA6MTQuMyBOZXR3b3JrIGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIERldmljZSA1MWYx
IChyZXYgMDEpCglTdWJzeXN0ZW06IEludGVsIENvcnBvcmF0aW9uIERldmljZSAwMDk0CglDb250
cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQ
YXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2
TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0g
PE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMAoJSW50ZXJydXB0OiBwaW4g
QSByb3V0ZWQgdG8gSVJRIDE2CglSZWdpb24gMDogTWVtb3J5IGF0IDYwMDExNDQwMDAgKDY0LWJp
dCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MTZLXQoJQ2FwYWJpbGl0aWVzOiBbYzhdIFBvd2Vy
IE1hbmFnZW1lbnQgdmVyc2lvbiAzCgkJRmxhZ3M6IFBNRUNsay0gRFNJKyBEMS0gRDItIEF1eEN1
cnJlbnQ9MG1BIFBNRShEMCssRDEtLEQyLSxEM2hvdCssRDNjb2xkKykKCQlTdGF0dXM6IEQwIE5v
U29mdFJzdCsgUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczog
W2QwXSBNU0k6IEVuYWJsZS0gQ291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdCsKCQlBZGRyZXNzOiAw
MDAwMDAwMDAwMDAwMDAwICBEYXRhOiAwMDAwCglDYXBhYmlsaXRpZXM6IFs0MF0gRXhwcmVzcyAo
djIpIFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVuZHBvaW50LCBNU0kgMDAKCQlEZXZDYXA6CU1h
eFBheWxvYWQgMTI4IGJ5dGVzLCBQaGFudEZ1bmMgMAoJCQlFeHRUYWctIFJCRS0gRkxSZXNldCsK
CQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtCgkJCVJs
eGRPcmQrIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3IrIE5vU25vb3ArIEZMUmVzZXQtCgkJCU1h
eFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDEyOCBieXRlcwoJCURldlN0YToJQ29yckVy
ci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0gQXV4UHdyKyBUcmFuc1BlbmQtCgkJ
RGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBSYW5nZSBCLCBUaW1lb3V0RGlzKyBOUk9QclBy
UC0gTFRSKwoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JGRiBWaWEgV0FLRSMsIEV4
dEZtdC0gRUVUTFBQcmVmaXgtCgkJCSBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbiBOb3QgU3VwcG9y
dGVkLCBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbkluaXQtCgkJCSBGUlMtCgkJCSBBdG9taWNPcHND
YXA6IDMyYml0LSA2NGJpdC0gMTI4Yml0Q0FTLQoJCURldkN0bDI6IENvbXBsZXRpb24gVGltZW91
dDogMTZtcyB0byA1NW1zLCBUaW1lb3V0RGlzLSBMVFIrIE9CRkYgRGlzYWJsZWQsCgkJCSBBdG9t
aWNPcHNDdGw6IFJlcUVuLQoJQ2FwYWJpbGl0aWVzOiBbODBdIE1TSS1YOiBFbmFibGUrIENvdW50
PTE2IE1hc2tlZC0KCQlWZWN0b3IgdGFibGU6IEJBUj0wIG9mZnNldD0wMDAwMjAwMAoJCVBCQTog
QkFSPTAgb2Zmc2V0PTAwMDAzMDAwCglDYXBhYmlsaXRpZXM6IFsxMDAgdjFdIExhdGVuY3kgVG9s
ZXJhbmNlIFJlcG9ydGluZwoJCU1heCBzbm9vcCBsYXRlbmN5OiAwbnMKCQlNYXggbm8gc25vb3Ag
bGF0ZW5jeTogMG5zCglDYXBhYmlsaXRpZXM6IFsxNjQgdjFdIFZlbmRvciBTcGVjaWZpYyBJbmZv
cm1hdGlvbjogSUQ9MDAxMCBSZXY9MCBMZW49MDE0IDw/PgoJS2VybmVsIGRyaXZlciBpbiB1c2U6
IGl3bHdpZmkKCUtlcm5lbCBtb2R1bGVzOiBpd2x3aWZpCjAwOiA4NiA4MCBmMSA1MSAwNiAwNCAx
MCAwMCAwMSAwMCA4MCAwMiAwMCAwMCA4MCAwMAoxMDogMDQgNDAgMTQgMDEgNjAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKMjA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDg2IDgwIDk0IDAwCjMwOiAwMCAwMCAwMCAwMCBjOCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCBmZiAwMSAwMCAwMAo0MDogMTAgODAgOTIgMDAgYzAgMGUgMDAgMTAgMTAgMGMgMTAgMDAgMDAg
MDAgMDAgMDAKNTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwCjYwOiAwMCAwMCAwMCAwMCAxMiAwOCAwOCAwMCAwNSAwNCAwMCAwMCAwMCAwMCAwMCAwMAo3
MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKODA6IDEx
IDAwIDBmIDgwIDAwIDIwIDAwIDAwIDAwIDMwIDAwIDAwIDAwIDAwIDAwIDAwCjkwOiAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMAphMDogMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKYjA6IDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCmMwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMSBkMCAyMyBjOCAwOCAwMCAwMCAwZApkMDogMDUgNDAgODAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAKZTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwCmYwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMAoK

--_003_b533071f38804247f06da9e52a04f15cce7a3836camelintelcom_
Content-Type: text/plain; name="git-bisect-log"
Content-Description: git-bisect-log
Content-Disposition: attachment; filename="git-bisect-log"; size=2887;
	creation-date="Fri, 07 Jul 2023 08:25:18 GMT";
	modification-date="Fri, 07 Jul 2023 08:25:18 GMT"
Content-ID: <B1F178A079A35048AB2F2AC929B5DA1B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

Z2l0IGJpc2VjdCBzdGFydAojIGJhZDogW2MxNzQxNGEyNzNiODFmZTRlMzRlMTFkNjlmYzMwY2M4
YjE0MzE2MTRdIE1lcmdlIHRhZyAnc2gtZm9yLXY2LjUtdGFnMScgb2YgZ2l0Oi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2dsYXViaXR6L3NoLWxpbnV4CmdpdCBiaXNl
Y3QgYmFkIGMxNzQxNGEyNzNiODFmZTRlMzRlMTFkNjlmYzMwY2M4YjE0MzE2MTQKIyBnb29kOiBb
Njk5NWUyZGU2ODkxYzcyNGJmZWIyZGIzM2Q3Yjg3Nzc1ZjkxM2FkMV0gTGludXggNi40CmdpdCBi
aXNlY3QgZ29vZCA2OTk1ZTJkZTY4OTFjNzI0YmZlYjJkYjMzZDdiODc3NzVmOTEzYWQxCiMgYmFk
OiBbZjg4MjRlMTUxZmJmYTBhYzBhMjU4MDE1ZDYwNmVhNmY0YTEwMjUxYl0gTWVyZ2UgdGFnICdz
b3VuZC02LjUtcmMxJyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdGl3YWkvc291bmQKZ2l0IGJpc2VjdCBiYWQgZjg4MjRlMTUxZmJmYTBhYzBhMjU4MDE1
ZDYwNmVhNmY0YTEwMjUxYgojIGdvb2Q6IFs2YThjYmQ5MjUzYWJjMWJkMGRmNGQ2MGM0YzI0ZmE1
NTUxOTAzNzZkXSBNZXJnZSB0YWcgJ3Y2LjUtcmMxLXN5c2N0bC1uZXh0JyBvZiBnaXQ6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbWNncm9mL2xpbnV4CmdpdCBiaXNl
Y3QgZ29vZCA2YThjYmQ5MjUzYWJjMWJkMGRmNGQ2MGM0YzI0ZmE1NTUxOTAzNzZkCiMgZ29vZDog
WzA4ZWVjY2IyNDkxYTMxOThmNGFkY2JhNjNhZGVhY2U2ZTI0OTllYTNdIE1lcmdlIHRhZyAnbGlu
dXgtY2FuLW5leHQtZm9yLTYuNS0yMDIzMDYyMicgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L21rbC9saW51eC1jYW4tbmV4dApnaXQgYmlzZWN0IGdvb2Qg
MDhlZWNjYjI0OTFhMzE5OGY0YWRjYmE2M2FkZWFjZTZlMjQ5OWVhMwojIGJhZDogW2U1NDc2ZjU3
YjMyNjIxZWI4ZWFiODkyYTkwOGRmNGQwYjQ4MDg4MzVdIE1lcmdlIHRhZyAnZ3Bpby11cGRhdGVz
LWZvci12Ni41JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvYnJnbC9saW51eApnaXQgYmlzZWN0IGJhZCBlNTQ3NmY1N2IzMjYyMWViOGVhYjg5MmE5MDhk
ZjRkMGI0ODA4ODM1CiMgYmFkOiBbYjU0NWExM2NhOWIyMDNlYWNjZTFlNTJhZTJlMzJmOTliODYw
MzQ3Y10gTWVyZ2UgdGFnICdtbHg1LXVwZGF0ZXMtMjAyMy0wNi0yMScgb2YgZ2l0Oi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3NhZWVkL2xpbnV4CmdpdCBiaXNlY3Qg
YmFkIGI1NDVhMTNjYTliMjAzZWFjY2UxZTUyYWUyZTMyZjk5Yjg2MDM0N2MKIyBiYWQ6IFszMWFl
YWUyNDQ2ZDUwNjY1YjZlYzUxZDU2NGY1ZTdmZTc1MWQ1M2Q0XSB3aWZpOiBpd2x3aWZpOiBjZmc6
IHJlbW92ZSB0cmFpbGluZyBkYXNoIGZyb20gRldfUFJFIGNvbnN0YW50cwpnaXQgYmlzZWN0IGJh
ZCAzMWFlYWUyNDQ2ZDUwNjY1YjZlYzUxZDU2NGY1ZTdmZTc1MWQ1M2Q0CiMgZ29vZDogWzEwOGQy
MDIyOThiZjAzY2U4ZDdlMjhiYjk0ZDIzNTU1YzgzODU1ODJdIHdpZmk6IG1hYzgwMjExOiB1c2Ug
bmV3IGluZm9ybV9ic3MgY2FsbGJhY2sKZ2l0IGJpc2VjdCBnb29kIDEwOGQyMDIyOThiZjAzY2U4
ZDdlMjhiYjk0ZDIzNTU1YzgzODU1ODIKIyBnb29kOiBbMDc2MDMxYTA5YWU5ZTkzOTRhNTY4MDVh
YWI5Mjk3MzYxMjc2M2Q3ZV0gd2lmaTogcnR3ODk6IDg4NTFiOiBjb25maWd1cmUgdG8gZm9yY2Ug
MSBUWCBwb3dlciB2YWx1ZQpnaXQgYmlzZWN0IGdvb2QgMDc2MDMxYTA5YWU5ZTkzOTRhNTY4MDVh
YWI5Mjk3MzYxMjc2M2Q3ZQojIGdvb2Q6IFswMGU0ODIwMTBkZmI1ODc5ZmM5ZTg2MDFkNTgxOTY0
MWZlNGFlOTI1XSB3aWZpOiBpd2x3aWZpOiBtdm06IGFkZCBFSFQgQS1NUERVIHNpemUgZXhwb25l
bnQgc3VwcG9ydApnaXQgYmlzZWN0IGdvb2QgMDBlNDgyMDEwZGZiNTg3OWZjOWU4NjAxZDU4MTk2
NDFmZTRhZTkyNQojIGdvb2Q6IFtlMTM3NGVkMjUzMjRlODdkNjc1YmRhNzM1ODQxZDg0MjRkODNj
ODFkXSB3aWZpOiBpd2x3aWZpOiBBZGQgc3VwcG9ydCBmb3IgbmV3IENOVmkgKFNDKQpnaXQgYmlz
ZWN0IGdvb2QgZTEzNzRlZDI1MzI0ZTg3ZDY3NWJkYTczNTg0MWQ4NDI0ZDgzYzgxZAojIGJhZDog
W2M2NDhlOTI2ZDAyMWY5YzZiZGVlZjc4MmRmMDZmNTExMTkwNGZlN2VdIHdpZmk6IGl3bHdpZmk6
IGRvbid0IGxvYWQgb2xkIGZpcm13YXJlIGZvciAyMjAwMApnaXQgYmlzZWN0IGJhZCBjNjQ4ZTky
NmQwMjFmOWM2YmRlZWY3ODJkZjA2ZjUxMTE5MDRmZTdlCiMgYmFkOiBbNTA4YjRhMWJhZWIzZGEz
ZjBiY2YzYWI0Yzk0ZGQyYzIxY2M1ZDM5NV0gd2lmaTogaXdsd2lmaTogZG9uJ3QgbG9hZCBvbGQg
ZmlybXdhcmUgZm9yIFNjCmdpdCBiaXNlY3QgYmFkIDUwOGI0YTFiYWViM2RhM2YwYmNmM2FiNGM5
NGRkMmMyMWNjNWQzOTUKIyBiYWQ6IFs1YWZlOThiMmUyOTk1YWExN2VmNzdhMjllNTdiMWQ5OGNj
ZDZjZDI1XSB3aWZpOiBpd2x3aWZpOiBnaXZlIFNjIGRldmljZXMgdGhlaXIgb3duIGZhbWlseQpn
aXQgYmlzZWN0IGJhZCA1YWZlOThiMmUyOTk1YWExN2VmNzdhMjllNTdiMWQ5OGNjZDZjZDI1CiMg
YmFkOiBbMTk4OThjZTljZjhhMzNlMGFjMzVjYjRjN2Y2OGRlMjk3Y2M5M2NiMl0gd2lmaTogaXds
d2lmaTogc3BsaXQgMjIwMDAuYyBpbnRvIG11bHRpcGxlIGZpbGVzCmdpdCBiaXNlY3QgYmFkIDE5
ODk4Y2U5Y2Y4YTMzZTBhYzM1Y2I0YzdmNjhkZTI5N2NjOTNjYjIKIyBmaXJzdCBiYWQgY29tbWl0
OiBbMTk4OThjZTljZjhhMzNlMGFjMzVjYjRjN2Y2OGRlMjk3Y2M5M2NiMl0gd2lmaTogaXdsd2lm
aTogc3BsaXQgMjIwMDAuYyBpbnRvIG11bHRpcGxlIGZpbGVzCg==

--_003_b533071f38804247f06da9e52a04f15cce7a3836camelintelcom_--
