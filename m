Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB47607020
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJUGco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiJUGck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:32:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2E023B696;
        Thu, 20 Oct 2022 23:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666333959; x=1697869959;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JKFGCsZKEDUm88CfoJv/N/F32l+g4bppYI/dGUPvk28=;
  b=dNIBDs1j8PCQPmSysSFWnSNcMcOjsz7JycLS2JimFZmwPe6RyUdept2r
   1W9DLq+qNWaDZk/foO4SlM2mQsVgC8GmdYqzzBFvo5RMsB24+114020Wo
   k4FiPeTyfsoryuq6jzZwlD/A7CHn9CkmrefOOwwH+KySeYvgBXjyrRkYp
   MZG5+06HqHHQD6nnMsIAhU+8cy51UqiZ/nylcVejjnxBWSs1JZ7s7bXaV
   flDVWMdoJ1vidPDZ0qc3rKpnTjdeW+2XXhDMmhO2d5Y3ZZzZMh7FLWTvj
   edCV2pP6NiM3GIfYvsgUDurEYV6sJDpBVjtp9WZ4+jvvJ+bMFeQEVvpyI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="294322275"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="294322275"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 23:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="693512250"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="693512250"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 20 Oct 2022 23:32:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 23:32:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 23:32:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 23:32:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqalRgdtRNQbFKhcYvfNtjeGL3A5UyQIFQwnMunw7KOE1kB2tq7x+rW+1JYycksXcl6Rj/vFyQ9rMXBtTa1v5HGk0D7s56jT22gmfY04F4aQnLY802Jj/gpXbmhx5qdi2pSsFbpHeN6KGnXKG5LaHaOsSgC+9LSRcE6jITJOGiciJVs3fxN4U2+zKl2ALZfXdyewER8m1OORb+/OONDxTp8hK6b6yxf1wZ/o1s41jkaH/iYWo9P6uh/p++USILN1Sda6TlO8QvOkB5oKq28AGHvD+kjKFBS1c2DYMezwyf8b3LOpARIiA+vzitiLdxiTL+zwxX0aSVNZcz3q19Yi+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKFGCsZKEDUm88CfoJv/N/F32l+g4bppYI/dGUPvk28=;
 b=mfJ0440q+V47W78FsC1BZZLTOKD5q2lvP7untTJLYpsY/33YtX5i8XPcSlDBCzWEU28fVau/nB9nlNo1asp7kq48J/JTJFQJxYIwRJokMr7+LH318JG29c9TeC1h2MLj6SFPHJ2Pog0ZcTjm+0J5b7IXI5ZjArksDvPXb/eY9ago+BCtwTNbq+9vgtgdaJaaTFXHJE6joI2F5z+wWTTFOQbtGCu5fQ9qa7Xme+zrBDVNA/Nzw4H/i/hJDfiMfHgVxQDfc85cywOuz1MRm63biddXWhKVfSTKB6sxoqdqKJIy3RlE6K40eJzZJqKNaHvZFKVDJbonUokPdnbl//dQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by PH0PR11MB4789.namprd11.prod.outlook.com (2603:10b6:510:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 06:32:34 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e%7]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 06:32:33 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "rrichter@amd.com" <rrichter@amd.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [PATCH v2 07/12] cxl: Remove dev_is_cxl_root_child() check in
 devm_cxl_enumerate_ports()
Thread-Topic: [PATCH v2 07/12] cxl: Remove dev_is_cxl_root_child() check in
 devm_cxl_enumerate_ports()
Thread-Index: AQHY4vT7WbmQjilpB06IL8hToE481K4YWKmAgAAPOIA=
Date:   Fri, 21 Oct 2022 06:32:33 +0000
Message-ID: <552e105ca749fae4517ef053b0439cb3eecd1e4c.camel@intel.com>
References: <20221018132341.76259-1-rrichter@amd.com>
         <20221018132341.76259-8-rrichter@amd.com>
         <6352303b266c_24ac29423@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <6352303b266c_24ac29423@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|PH0PR11MB4789:EE_
x-ms-office365-filtering-correlation-id: add37c88-7962-4727-5322-08dab32e0939
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7KRGGGQNLmkvS/gwZ53nPqmr9pj35oLrrNpqarr+okKJ54c6p90zUTnxJJ2hA5rueGGJ+BI4uONvaO2awIyCob/+S/Sk6t4E8oJ40Ocsl5dQ70VTkA0W0ZaPlv4FEyE4431bnQb296OPH4TkAHNMqMaUoV1/XcBRSkaQIrKuOncnufWunBkXuKKSNPepmeOeSm4LSREuKMUktsUB3POEg8XrHjuwaz8BsRic7xM4hlmuUvqVGp7v4H+/LlI7PCwUHIpcziJxsG1CCyOTVrJfK2TI7XhqrWHphHaUFhSEN3qpcKFMQZaeo/uP9WmNYslkt6LcNQJVJ4Iv8cWIgkhRG0JwN7S96RpDYPrnspFa3Zi87KmcBsUwMBRhKh+xVMVoyfcuXoVUjNqItG6rh56I1C3kyTRrNhSLWO0mti4pU5aDX8QOwAMb7s6fiDKT3kOmCh36zkemkvLrj8RBpIo8lklDXBKXHTsiNDpn6u9z7NFLDUHFrK+01l2AhNHv1j/ze3/Ehg2QAnmaMVKvwoRb2EkPlQ8VNDDBY7pa/gxz4ERz6yi5mqCuN6bmAamNSpEW8+FSgZdPjQ1pGHfv4H1xw9BzcItpAHLvr3Bqk57YVJS7TqBnax3mo2CdPMW8/GuubkJBtHUSrh6Z/9vsSFOT3gXmvGq+Bn2SeS6HnIwA+yQjPCcPyh3HOxh7DOWiDLB+0HRX3AL+rp8hpgOZTQnOBNuLBtKOhLPF2bIWlYUh5J96vl2p6h86fTFEPFMpG7NENoSEZaC2zb4rRk7nF8oy1C2unLPEz97vOxl8ZCDsBfA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199015)(8676002)(110136005)(4744005)(966005)(4326008)(5660300002)(6636002)(66446008)(91956017)(66946007)(66476007)(66556008)(86362001)(71200400001)(478600001)(36756003)(2906002)(4001150100001)(41300700001)(8936002)(6506007)(76116006)(82960400001)(38100700002)(6486002)(54906003)(186003)(316002)(64756008)(38070700005)(2616005)(26005)(122000001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1NKd2g2UktQZFp4c3d2cHpkQ2oyRWg4NWpjWmJBNnBWQ3I1NWI0aStOeVRl?=
 =?utf-8?B?L2w2SlFDaXhaRzBiL0FkU2E3TmZFQzFsTWdrWHlnb1ZqdHlJN3hTQjFNS3lh?=
 =?utf-8?B?bElENDZuRGEvQVJ5RUVmSFRPRkh2NkFjYXczR1Y4YlJNb25QS2FCM20waWxG?=
 =?utf-8?B?WU5qM2YxMkJqZFB4RTlzVzRhdWV3NlFqSm02T2FJb05NTWRRVnprZUlGMjU5?=
 =?utf-8?B?b1BYU25CV0ZJNjEwbTYzcDVHUnEwbi90R0hmNlF5VWx2QUd2TmdGRmZ5S2JJ?=
 =?utf-8?B?bXk5UStRUHQ1VEJ0R1d6Z1hyb3c4NGtjMW1jZG53dGV2aHR5UTNrc0lmMTY4?=
 =?utf-8?B?VW91T0Q1QzNGS2NyMmdDSTZ2M2tlWldLU1VhUHRweWNDVnQzWFhZVHVNVDBU?=
 =?utf-8?B?T0Y2VTRUVHNOMmovdzFqRHprTXFLdGw0T3lLa2dkTzF2bzRJcHZKMnY2bmRY?=
 =?utf-8?B?R3Y5WkRDYURIc0x5UFQ3MVJKZkNSYW1uVUZ0MUd3OWcySk9LQ2ZDY1ZJWCt4?=
 =?utf-8?B?NFJ4dmROM05wVDdmVnBFdVF2dkV4VHJrWEFqLy91eHh1VmYrODZaOXF2bWFs?=
 =?utf-8?B?aUJGZW5QbnB0d25ORVBlblRWaVFqTE5JanlMOWJhTnNhcDl0ZVAvU3BpWW5r?=
 =?utf-8?B?OVNMRjI4S1pHcStQUkxkcnhqNVNEY1ljRE5BN3NsWUdVTHBqcisxdHV3UXV0?=
 =?utf-8?B?b285Sjh4N3dOOHBEMzZCcTJVcWF4UXorSXhWak9YKzNBalQ2STF4bHZxc3Bt?=
 =?utf-8?B?ajRleXU5ZVgyQXFuT09YY1FvcWJ2ci81U3o0UnNzWmpIblI0clArUmgxN1dQ?=
 =?utf-8?B?V2dGRnpHWHFibW5nNEhHNEZpSVdYVmZwaXZ5WDJPZGVHQVBiK0tKakhxbnNa?=
 =?utf-8?B?Ti9lZXpCZXF4Z0ZpUkx3Z2NNVm5RSjJhKzJQNlBsMUt1RUVZajJrOU8xRkVS?=
 =?utf-8?B?SXV2MmltVnhxM3ZyMjhGWE1laGsvT1VsaEdQQVMydWZnQ25NZzgwVXZDTUhD?=
 =?utf-8?B?VXdhOHMxY0RxTERoNHIrd0hiSm1DVjVvNm9LZ25HVWRIdWQwVE5TYXRzSm9L?=
 =?utf-8?B?bGM2ZzVmRnZqVFNwTGo5YkdiN1JIeEsvUHJKeXo2ckNnelc5amptYUxydmxy?=
 =?utf-8?B?ak82Y0dTbE95VHROTk05V0kveVQrdUNoTW1ZR2FxR2FJUUtHbllBdGN5UWVv?=
 =?utf-8?B?V0E4TkI1SithNEk1SGZsVTdZcGo1SUluUmt2dWIxV29kYmVhQVROd2ZpZ1ZR?=
 =?utf-8?B?QitKcFpLaVRzRy9pZUZxWjdoamNQbGxqZEM2ekx5VEJ1cmJ6U1VUQTE5cTRz?=
 =?utf-8?B?SXRJTHMzeVhnbjdhbFF1MExHMklOWTJhTlZucnNRTjZSbEQ2WVlPam4xc1l2?=
 =?utf-8?B?a0NtOWRNOHZTWEhBTXpYa1Q3OEYxSHdHblI4SDU2RDJtbkxhUm1lcEJtczFY?=
 =?utf-8?B?RmNQWFZWQkw4bDZBblRFa29XZENQTE5rOFNrMm90Q2RWKzdINlBEMG5TS2lK?=
 =?utf-8?B?VjlXWWdIUUJjUFY2UHVTZnZQRWcrTmxSSTdUSUdDYmd3RzV2bThLaHdqZHZq?=
 =?utf-8?B?Q0ovTUZwUHhPNU1mbWIwWlE3S2NkNGNaTG01WE9lTVQxWHNGNFpicW13dlVJ?=
 =?utf-8?B?L3M4YlBOWnFDU05ad1dIZDBzTDl2Q1RJUnRYeHp3aDZMem0xUGVlNHhnTGNl?=
 =?utf-8?B?LzhRSFd5akFwRlVOajI2UnlZdWRxRUY3aE9ISWxKdTdPZUE2eU54SzI5TkNw?=
 =?utf-8?B?ZktGa0Q1c29TMTN0MjhhUE1aMDNLeUora2s1TXd3WUhJNnpTaktLekVMRWZC?=
 =?utf-8?B?SGF1b3FCZDEvVXNTUU1uS3pWblM2bXNUNUhpczE2ejk5dHZKNzRhRll4Tm5Y?=
 =?utf-8?B?YVdDVkU5Tm5CUVRSOHZGNnp2bi9yRFRxY2wvUitXZ1Y4aFVQOHIxdlh6T3dq?=
 =?utf-8?B?cEY0ZWJ5VHFqVGpGUDdrM25nem1MS2FoZk1jaGExNlIwRWlXMy91VlVLZmE0?=
 =?utf-8?B?ckM0SSsxZUtvMWlFbkdGU25lRUl1TkI4bE84ZnE5aTU1L1VoZzh5cUpZc2hr?=
 =?utf-8?B?NzVGcSt3bnYvZVFKWThCcUJ0bEkvd0lkNE0zNFFqR0J2cWEwUVJLSzdReVps?=
 =?utf-8?B?WEFuQWFPQWhNNVp1dUlZUjlkWXFyYWtwVjdwamVnbnlPR09lUlRqSnA0WmIy?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F317F20F8D1F542A3AB36AEBDA1BFDE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add37c88-7962-4727-5322-08dab32e0939
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 06:32:33.0653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MScX5221Uu76R6JeeAMKOGNd6LaDJCJhqoyA5xNcXsFq+SNYA4nIQ8wJKuFueD0N5czBF8UzNOBe6wdomO+Leawv4ygcuabp9MUX7h/RU3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTIwIGF0IDIyOjM4IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFJvYmVydCBSaWNodGVyIHdyb3RlOg0KPiA+IA0KDQo8Li4+DQoNCj4gDQo+IFdpdGggdGhhdCBz
Y2hlbWUgaW4gcGxhY2UgYW5kIHNvbWUgY3hsLWNsaSBmaXh1cHMgZnJvbSBWaXNoYWwgd2UgYXJl
DQo+IHNlZWluZzoNCj4gDQo+ICMgY3hsIGxpc3QgLUJFTVBUdQ0KPiB7DQo+IMKgICJidXMiOiJy
b290MCIsDQo+IMKgICJwcm92aWRlciI6IkFDUEkuQ1hMIiwNCj4gwqAgIm5yX2Rwb3J0cyI6MSwN
Cj4gwqAgImRwb3J0cyI6Ww0KPiDCoMKgwqAgew0KPiDCoMKgwqDCoMKgICJkcG9ydCI6InBjaTAw
MDA6MzgiLA0KPiDCoMKgwqDCoMKgICJpZCI6IjB4MzEiDQo+IMKgwqDCoCB9DQo+IMKgIF0sDQo+
IMKgICJlbmRwb2ludHM6cm9vdDAiOlsNCj4gwqDCoMKgIHsNCj4gwqDCoMKgwqDCoCAiZW5kcG9p
bnQiOiJlbmRwb2ludDEiLA0KPiDCoMKgwqDCoMKgICJob3N0IjoibWVtMCIsDQo+IMKgwqDCoMKg
wqAgImRlcHRoIjoxLA0KPiDCoMKgwqDCoMKgICJtZW1kZXYiOnsNCj4gwqDCoMKgwqDCoMKgwqAg
Im1lbWRldiI6Im1lbTAiLA0KPiDCoMKgwqDCoMKgwqDCoCAicG1lbV9zaXplIjowLA0KPiDCoMKg
wqDCoMKgwqDCoCAicmFtX3NpemUiOiIxNi4wMCBHaUIgKDE3LjE4IEdCKSIsDQo+IMKgwqDCoMKg
wqDCoMKgICJzZXJpYWwiOiIwIiwNCj4gwqDCoMKgwqDCoMKgwqAgIm51bWFfbm9kZSI6MCwNCj4g
wqDCoMKgwqDCoMKgwqAgImhvc3QiOiIwMDAwOjM4OjAwLjAiDQo+IMKgwqDCoMKgwqAgfQ0KPiDC
oMKgwqAgfQ0KPiDCoCBdDQo+IH0NCg0KSSB3YXMgd2FpdGluZyB0byBwb3N0IHRoZSBjeGwtY2xp
IHBhdGNoZXMgZm9yIHRoaXMgdW50aWwgdGhlIGtlcm5lbA0KZGlzY3Vzc2lvbiBzZXR0bGVzIC0g
YnV0IG1heWJlIHRoaXMgdG9wb2xvZ3kgbGF5b3V0IGlzIHNldHRsZWQgZW5vdWdoPw0KDQpJbiB0
aGUgbWVhbndoaWxlIEkndmUgcHVzaGVkIGEgYnJhbmNoIHdpdGggdGhlc2UgZml4dXBzIGhlcmU6
DQpodHRwczovL2dpdGh1Yi5jb20vcG1lbS9uZGN0bC90cmVlL3Z2L3JjaC1zdXBwb3J0DQoNCj4g
DQo+IERvZXMgdGhhdCBtYWtlIHNlbnNlPyBJIHRoaW5rIHRoaXMgcGF0Y2hzZXQgZ2V0cyBhIGxv
dCBzaW1wbGVyIGlmIGl0DQo+IGRvZXMgbm90IHRyeSB0byBtYWtlIGRldm1fY3hsX2VudW1lcmF0
ZV9wb3J0cygpIHVuZGVyc3RhbmQgdGhlIFJDSA0KPiB0b3BvbG9neS4NCg0K
