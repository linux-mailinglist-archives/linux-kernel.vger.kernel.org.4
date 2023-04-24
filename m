Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962BE6D72AA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 05:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbjDEDKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 23:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjDEDKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 23:10:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3972D6D;
        Tue,  4 Apr 2023 20:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680664238; x=1712200238;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kq1pYQNCljP2a00GSQYtHQMiV/wY4CWlGdHaxE5ZkTE=;
  b=HQuHTpAYY3JI5lmvxarI7sNQceYDkJHKEujXGUDzBN8KRIl47dTbrN3Q
   9W4TF5aYE5TSCUQgl7Zdbfbk9qRTBk/3T6f9cfgwJsanU/2S/no6XUqdy
   DnA+m5KqBXejvybngCnBuBwP+ozajGfhBUerrmULXMIp1WZOezTNngBBA
   nkuIzGPH6EqOvdwwNFhFGojue25j/zGd4uhQJYNgaPdOjJOqpY71xVu+L
   WIXG6rdAErc2f90X3NBBdLCUyYBsCipGLhS6Nkd+19Cac8yo8XhgYtYtX
   5XItOOTQ9ln4B81H1oK2y6IN+1EcCwvplHI7SExUfgge8kLeL39FzwIVf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="344933255"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="344933255"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 20:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="751124524"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="751124524"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 04 Apr 2023 20:10:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 20:10:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 20:10:37 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 20:10:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoV69xCPg0IMOtlbxC5bU3mzVF/aFyZNBYsO5HCGQIlRny7bE52IpmlpzbK/nr6OqdKhFBZKQmpHHxRZz+izWYZqCZPQjxThzJDXZvPKolSpJTrcJDiDC0IQEO9ymuL6tu7YtdlSZx84wWCECabDh9wG/WxP0AQ/975p1QVsvF+0VtgL9pagifaw8Z3FxinCX3f2Zwkq54g33Ox24L5Qz1zLUf1k5SYInakQKBRX0QRuNCs+g12pgTTDkRAkvFHRp5VX4C7D19vqtM8+Pt1Hr/P0HENQhwkpXYVItEg3aMJLTj+cHgUpMGbjwLKjWnf864lmXS1MdL5LZU4Pt3JV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq1pYQNCljP2a00GSQYtHQMiV/wY4CWlGdHaxE5ZkTE=;
 b=Tj8Dcdr540a+KjJR7qZCqjUlsMThDCU0Q/ReNbBqIzbo8FUqA/HNy282y4BTCM+zpnakmEsNQ6xlbYQNfol4TPc36rhtibsFyf8QqxlrDnHQe/pK5ZqrObIGkANLbWq0hChM1zDaRE1px/E9DEirbtyn5FxWsVpF2EWXd0xEbScigDllSUb5gaL9iqYaHlAWg9XtiByHxi7FjHEmVOqWNE6VT5IGQRX8+SO/lI5N9WpJuSj+HmJsV/qw9BfSLS0x1p7HTfkOWSn73G6a3HR61U/Zk5+gLTgYduGb2a/w9Osr93+YVpOQ6RYksdLfUUCYTgMiTOhbgHsCBrQIAXeXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH0PR11MB5443.namprd11.prod.outlook.com (2603:10b6:610:d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 03:10:34 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9%5]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 03:10:34 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: VMX: Get rid of hard-coded value around
 IA32_VMX_BASIC
Thread-Topic: [PATCH] KVM: VMX: Get rid of hard-coded value around
 IA32_VMX_BASIC
Thread-Index: AQHZYukap0odLrkeg0+eOGU79cgBka8b4n4AgAAwBIA=
Date:   Wed, 5 Apr 2023 03:10:33 +0000
Message-ID: <ab1919bf23058bfcfe0dc65c2fba53d86705e653.camel@intel.com>
References: <20230330092149.101047-1-kai.huang@intel.com>
         <ZCy+Wiehn9QYdgXR@google.com>
In-Reply-To: <ZCy+Wiehn9QYdgXR@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH0PR11MB5443:EE_
x-ms-office365-filtering-correlation-id: addd1e24-486d-4f56-4204-08db3583524c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DRS3wI2sx4KjSxkwOrobcFSzP6PtApCSMVY3rIHEakkYmIuohmLcCSASZsVMNHajpqXoGj9QwzRCshAU49AvGh34Ct9J2eM4vhE/HxcilUVJbB1EwyK0kAJCKUHlPLUAPEydJkpI0IX5HSKN7xQ2uO8mTk8OG02KbqyW6uZ9aeCLiGqE5hGicnjhsYoXkmer6Ty5ycN91YYam7ar6g9BnMSgwRZPkbBdq9tbqWAjKQxnIehRlY5+tFOv/tBlCt/+fhIFL6BPcfwS7371f0GYjHalZruT9Mnjfsdnl+sZIW43QfqK1iccc/wNOCayocq7UmbOlogHVGyaWGtO1yVTGltOCJVd8ymSwacEgAS4ZUSispdRPERzIgpksvRxLT8BvaWfA46OTAsTWHqwYaYsjEeJ51XhrO3KdyReqEQaW9JwReEzU4w7NLeyj7CNV83IBPgp08dTtG+ps5xaGwDaNj8gzvhiMKbFx6wk2QhH+zk4Mwzuf4udLZRNWwyQkSeZTsM7LcSSZpdNeoBZvIaXY/xn2RroVnxQSRGsQ3CtViJO7fcmJGAYtjRzEa6kHE5vd924XIqYULt2R49ApXeEJgOjDdhD8O2F3dUsV8CbrUIzqiHg4dsEfizU40JN6ic5OZ7zrFEB/paf443PSiOG/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(86362001)(38070700005)(36756003)(2906002)(2616005)(71200400001)(6486002)(186003)(83380400001)(26005)(6506007)(6512007)(41300700001)(8676002)(64756008)(4326008)(66946007)(66446008)(478600001)(66556008)(91956017)(76116006)(66476007)(82960400001)(38100700002)(5660300002)(6916009)(8936002)(316002)(122000001)(54906003)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzJNelJoRUdVSEpOSzkzcEpYenNUc01LWWlCNHM5TzJFMW12bzlnbTM3SnJQ?=
 =?utf-8?B?TUw4eDNtQXJXTlVVdWt5Q3NVOG9pZmRPZEwxMHU5WjNSWGJ3dlNFRFc4S3Nj?=
 =?utf-8?B?S1MyWDdjRFRTeS9tNWtZZy9RakU4NXNLbERSdXp1NlNvTzFrV3JHNDRhOW5H?=
 =?utf-8?B?MFZMZDZjam9NaE9NMU52S2d5b29WQWpqTzlGRGhFcTBJZzkyNFg0dys1c1Zw?=
 =?utf-8?B?LzNVMHlWOWk5dkRGZGVONjcxNmVVb0h1UVRXdWc2K3YzSjZCZjVaUldkb3lO?=
 =?utf-8?B?dDJZMEtveWJlUFJER05QaERzK2J1NGtOREpLN3Y0dTlxeVVKTlF3bjVDREN0?=
 =?utf-8?B?R3RWQmxXdGJiMlpzNVQwZ3RMNzZpeHE1elBBSkhibm5OWlJGUFJBcmN5TXRV?=
 =?utf-8?B?RmI2bHFtZjRyV1I1WkJ4QWFsUDR0anVPb1oySU85aXVMakJDdnlkdFd3QVBG?=
 =?utf-8?B?allIelFJQ04wdTRuQWVpT3ZOT1BNZ25veDdvZHhLMUxPY1ZxVGhiVUJvOFNp?=
 =?utf-8?B?cFd2MWJnYnFDS0JZRFkzNnVkR3ZuT0pDYWN1V1J0R3l1ZUpZd1QvMlBIVHJh?=
 =?utf-8?B?eCt3dTQwclVjTHFoajZ0cHh6N0tVdVJHWUY1NE0yM2d2dkVvS2NVekNIT1pE?=
 =?utf-8?B?U0tOVXRPRng0ZWkxKzU1VXUyblBzbld2WklISVMvU1FtQUJzWEoySUNMdWxz?=
 =?utf-8?B?cU9FREpZeUgrTUx6MVZCby9QdEJWVTlBalR1a2NQZU1Cd1FSTzJGRVYxbEk3?=
 =?utf-8?B?aVdVWHlkSmVURGVLYTJicVRVZ3liWk96RTV4emZtYUh2ZUZtOENhanNuZzdP?=
 =?utf-8?B?L3RqdzVDRzVGWmxvUUJaaFFMSTBlSm1UVmlqZ3FrMkJjL29TYU82VkZvaEg1?=
 =?utf-8?B?NWFCMjhyejVNMHNCK3pqWStwbGFJYnRJL1g5dGpmdjlMRTZkckU0bWdseDVW?=
 =?utf-8?B?eElzZzRpOTZjR0lxYWxMRXhPNHRobWJ2a2NybXhvRkRiSDNkTmVkYVBienRn?=
 =?utf-8?B?NDBoQ01sQ25QR2hWQ3FIdzFVa3daRnN3TDhwd3hDWW5lSlB6cEZtSlU3Tm5T?=
 =?utf-8?B?UVR0RTJCRFlNU2RZTlkya1d5Z1QzTnUrM25lZDdCMmlsYlYrZDhuSjd0bkgr?=
 =?utf-8?B?aU5qdk5TRWw1YVo1UHlRRVFMYTAyNXJ1bTRCR1JPcVhUNDlPSXVFMWhEWUwz?=
 =?utf-8?B?dnVoSkNWTTdDRXBRN2JRajU1ZlpOTkRNd0VjN016ZjNnQVVaQlhKZWlHVllW?=
 =?utf-8?B?eWYxZ1V0NTU1ZU10M2lEQ2crY244b1BrcHZjL1M3eFRXQjZ4QTg4UHNoTHZx?=
 =?utf-8?B?cmZJUUFFcm5LODFUWkhWamxydFdnSU4zQytyNjBqUmNMRDRmRndwemdtdzFa?=
 =?utf-8?B?dU1PUE5KV3ljVkRjMi83dXFmUWlqMEwyaEJGenJQSVV0SXYvRkttMk5HdDhF?=
 =?utf-8?B?YWtOc2VOS2FZdGp3ODFTdE1xeEd0WE16dzNoaHJybHUxTklUZnlnZDk1dlJS?=
 =?utf-8?B?NUxmaTd0STQ2QURySFFwVjltWW5XNms5Z2RvOWMrK2xjc1B6SEtZclovMWlM?=
 =?utf-8?B?R1llK1BXckFQVVlyUlh0eHRwandoZ0FrM3gyZ0ttL0QyUmxNODZ6Z1E3NFE2?=
 =?utf-8?B?U2piMEtUZmNXbGZHLzhFbFJleFVZaVBiSm5kajR1OXp2WGZERnJPQ3MxQjBG?=
 =?utf-8?B?dDlpQnNoUVZMYk0zREhxSGV1T3JRVFF2NW9iRzRkSWxSNmFmTGhIZng0THBD?=
 =?utf-8?B?cFpUSWo2Y2UzQzAxUDdWVDh6aVJjMFhvT3p4RTdZK0t4NjVxNlk0VVhMREdG?=
 =?utf-8?B?eDE4VEMvSUQzVnhNT3IvVmh2cFdoVW1DQ05RdE1QbTBKZWZMSktwLzR6aisy?=
 =?utf-8?B?eVc2S2I3ZmUxUmVMZlgzcXBNUGc1Y3dSZ201aExBRjJOU1NGZjZaN2dyNTZp?=
 =?utf-8?B?cjVtSjh2OEl5Vm9PRXhXRGhjQzI4VDN4b21LYU9wTVlWbDdscDZVdG93S1Yz?=
 =?utf-8?B?ekc0QWJ1TTk3TlMraTN4cnpWQ05KejlHUFFhWUxmbzFIK2ZMaEd2K1BJZE1y?=
 =?utf-8?B?dVdtNVl2YlFtc1krYWxqTkxoTE5KOW5aN01jbXdYTi9CM1Ura2RndWRsUys4?=
 =?utf-8?Q?DJKam2S+gcFY+9YrzH4wwNZFB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DAA566FBF988C41AFA1214302972195@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addd1e24-486d-4f56-4204-08db3583524c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 03:10:34.0313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PuNs2Oac5Ccj5GPZGQtdEev7RhZ1l0BFrq6f4ywFIIbJqTwNDE/8Zl/0f/qC7XJpgnxh0z1H7F7BniSnpISeZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5443
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA0LTA0IGF0IDE3OjE4IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUaHUsIE1hciAzMCwgMjAyMywgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IEN1cnJl
bnRseSwgc2V0dXBfdm1jc19jb25maWcoKSB1c2VzIGhhcmQtY29kZWQgdmFsdWVzIHdoZW4gcGVy
Zm9ybWluZw0KPiA+IHNhbml0eSBjaGVjayBvbiB0aGUgdmFsdWUgb2YgSUEzMl9WTVhfQkFTSUMg
TVNSIGFuZCBzZXR0aW5nIHVwIHRoZSB0aHJlZQ0KPiA+IG1lbWJlcnMgb2YgJ3ZtY3NfY29uZmln
Jzogc2l6ZSwgcmV2aXNvbl9pZCBhbmQgYmFzaWNfY2FwLiAgSG93ZXZlciwgdGhlDQo+ID4ga2Vy
bmVsIGFjdHVhbGx5IGFscmVhZHkgaGFzIG1hY3JvIGRlZmluaXRpb25zIGZvciB0aG9zZSByZWxl
dmFudCBiaXRzIGluDQo+ID4gYXNtL21zci1pbmRleC5oIGFuZCBmdW5jdGlvbnMgdG8gZ2V0IHJl
dmlzaW9uX2lkIGFuZCBzaXplIGluIGFzbS92bXguaC4NCj4gPiANCj4gPiBBZGQgdGhlIG1pc3Np
bmcgaGVscGVyIGZ1bmN0aW9uIHRvIGdldCB0aGUgYmFzaWNfY2FwLCBhbmQgdXNlIHRob3NlDQo+
ID4gbWFjcm9zIGFuZCBoZWxwZXIgZnVuY3Rpb25zIGluIHNldHVwX3ZtY3NfY29uZmlnKCkgdG8g
Z2V0IHJpZCBvZiB0aG9zZQ0KPiA+IGhhcmQtY29kZWQgdmFsdWVzLg0KPiA+IA0KPiA+IE5vIGZ1
bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEthaSBI
dWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC94ODYvaW5jbHVk
ZS9hc20vdm14LmggfCAgNSArKysrKw0KPiA+ICBhcmNoL3g4Ni9rdm0vdm14L3ZteC5jICAgICB8
IDE3ICsrKysrKysrKy0tLS0tLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vdm14LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92bXguaA0KPiA+IGluZGV4IDQ5
OGRjNjAwYmQ1Yy4uMmI0ODg4OTVmZTBlIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3ZteC5oDQo+ID4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdm14LmgNCj4gPiBA
QCAtMTQxLDYgKzE0MSwxMSBAQCBzdGF0aWMgaW5saW5lIHUzMiB2bXhfYmFzaWNfdm1jc19zaXpl
KHU2NCB2bXhfYmFzaWMpDQo+ID4gIAlyZXR1cm4gKHZteF9iYXNpYyAmIEdFTk1BU0tfVUxMKDQ0
LCAzMikpID4+IDMyOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICtzdGF0aWMgaW5saW5lIHUzMiB2bXhf
YmFzaWNfY2FwKHU2NCB2bXhfYmFzaWMpDQo+IA0KPiBJIHdvdWxkIG9taXQgdGhpcyBoZWxwZXIg
YW5kIGp1c3Qgb3BlbiBjb2RlIHRoZSB1Z2xpbmVzcywgcHVyZWx5IGJlY2F1c2Ugd2hhdA0KPiBp
dCdzIHRyYWNraW5nIGlzIGNvbXBsZXRlbHkgcmFuZG9tLg0KPiANCj4gPiArew0KPiA+ICsJcmV0
dXJuICh2bXhfYmFzaWMgJiB+R0VOTUFTS19VTEwoNDQsIDMyKSkgPj4gMzI7DQo+ID4gK30NCj4g
PiArDQo+IA0KPiAuLi4NCj4gDQo+ID4gICNpZmRlZiBDT05GSUdfWDg2XzY0DQo+ID4gIAkvKiBJ
QS0zMiBTRE0gVm9sIDNCOiA2NC1iaXQgQ1BVcyBhbHdheXMgaGF2ZSBWTVhfQkFTSUNfTVNSWzQ4
XT09MC4gKi8NCj4gPiAtCWlmICh2bXhfbXNyX2hpZ2ggJiAoMXU8PDE2KSkNCj4gPiArCWlmIChi
YXNpY19tc3IgJiBWTVhfQkFTSUNfNjQpDQo+ID4gIAkJcmV0dXJuIC1FSU87DQo+ID4gICNlbmRp
Zg0KPiA+ICANCj4gPiAgCS8qIFJlcXVpcmUgV3JpdGUtQmFjayAoV0IpIG1lbW9yeSB0eXBlIGZv
ciBWTUNTIGFjY2Vzc2VzLiAqLw0KPiA+IC0JaWYgKCgodm14X21zcl9oaWdoID4+IDE4KSAmIDE1
KSAhPSA2KQ0KPiA+ICsJaWYgKCgoYmFzaWNfbXNyICYgVk1YX0JBU0lDX01FTV9UWVBFX01BU0sp
ID4+IFZNWF9CQVNJQ19NRU1fVFlQRV9TSElGVCkNCj4gPiArCQkJIT0gVk1YX0JBU0lDX01FTV9U
WVBFX1dCKQ0KPiANCj4gVGhpcyBvbmUgaXMgd29ydGh5IG9mIGEgaGVscGVyLCBlLmcuIA0KPiAN
Cj4gCWlmICh2bXhfYmFzaWNfdm1jc19tZW10eXBlKGJhc2ljX21zcikgIT0gVk1YX0JBU0lDX01F
TV9UWVBFX1dCKQ0KPiAJCXJldHVybiAtRUlPOw0KPiANCj4gDQo+ID4gIAkJcmV0dXJuIC1FSU87
DQo+ID4gIA0KPiA+ICAJcmRtc3JsKE1TUl9JQTMyX1ZNWF9NSVNDLCBtaXNjX21zcik7DQo+ID4g
IA0KPiA+IC0Jdm1jc19jb25mLT5zaXplID0gdm14X21zcl9oaWdoICYgMHgxZmZmOw0KPiA+IC0J
dm1jc19jb25mLT5iYXNpY19jYXAgPSB2bXhfbXNyX2hpZ2ggJiB+MHgxZmZmOw0KPiA+ICsJdm1j
c19jb25mLT5zaXplID0gdm14X2Jhc2ljX3ZtY3Nfc2l6ZShiYXNpY19tc3IpOw0KPiA+ICsJdm1j
c19jb25mLT5iYXNpY19jYXAgPSB2bXhfYmFzaWNfY2FwKGJhc2ljX21zcik7DQo+IA0KPiBBY3R1
YWxseSwgbG9va2luZyBhdCB0aGlzIG1vcmUgY2xvc2VseSwgc3BsaXR0aW5nIHVwIHRoZSBiYXNp
YyBNU1IgZHVyaW5nIHNldHVwDQo+IGlzIHNpbGx5LiAgTm9uZSBvZiB0aGUgdXNhZ2UgaXMgaW4g
aG90IHBhdGhzLCBhbmQgY3B1X2hhc192bXhfYmFzaWNfaW5vdXQoKSBpcw0KPiBkb3ducmlnaHQg
Yml6YXJyZSB3aXRoIHRoZSBjdXJyZW50IGNvZGUuDQo+IA0KPiBSYXRoZXIgdGhhbiBkbyBhbGwg
b2YgdGhlc2Ugd2VpcmQgZGFuY2VzLCB3aGF0IGFib3V0IHNhdmluZyB0aGUgZnVsbC9yYXcgTVNS
IGluDQo+IHRoZSBjb25maWcsIGFuZCB0aGVuIHVzaW5nIHRoZSBoZWxwZXJzIHRvIGV4dHJhY3Qg
aW5mbyBhcyBuZWVkZWQ/ICBFLmcuIHRoZSBiZWxvdw0KPiBvdmVyIGEgZmV3IHBhdGNoZXMuICBB
cyBhIGJvbnVzIChtYXliZSksIEtWTSB3aWxsIHNhbml0eSBjaGVjayB0aGUgZW50aXJlIE1TUg0K
PiBhY3Jvc3MgQ1BVcy4NCg0KRmluZSB0byBtZS4gIEknbGwgcmV3cml0ZSB0aGlzIGluIG9uZSBv
ciBtb3JlIHBhdGNoZXMgYXMgeW91IHN1Z2dlc3RlZCBhbmQgcG9zdA0KYWdhaW4uICBUaGFua3Mh
DQoNCj4gDQo+IC0tLQ0KPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vdm14LmggICAgICB8ICA1ICsr
KysrDQo+ICBhcmNoL3g4Ni9rdm0vdm14L2NhcGFiaWxpdGllcy5oIHwgIDYgKystLS0tDQo+ICBh
cmNoL3g4Ni9rdm0vdm14L3ZteC5jICAgICAgICAgIHwgMjIgKysrKysrKysrLS0tLS0tLS0tLS0t
LQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92bXguaCBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3ZteC5oDQo+IGluZGV4IDQ5OGRjNjAwYmQ1Yy4uYjIxZGNkMTI4YWRkIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92bXguaA0KPiArKysgYi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS92bXguaA0KPiBAQCAtMTQxLDYgKzE0MSwxMSBAQCBzdGF0aWMgaW5saW5l
IHUzMiB2bXhfYmFzaWNfdm1jc19zaXplKHU2NCB2bXhfYmFzaWMpDQo+ICAJcmV0dXJuICh2bXhf
YmFzaWMgJiBHRU5NQVNLX1VMTCg0NCwgMzIpKSA+PiAzMjsNCj4gIH0NCj4gIA0KPiArc3RhdGlj
IGlubGluZSB1MzIgdm14X2Jhc2ljX3ZtY3NfbWVtdHlwZSh1NjQgdm14X2Jhc2ljKQ0KPiArew0K
PiArCXJldHVybiAodm14X2Jhc2ljICYgVk1YX0JBU0lDX01FTV9UWVBFX01BU0spID4+IFZNWF9C
QVNJQ19NRU1fVFlQRV9TSElGVDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlubGluZSBpbnQgdm14
X21pc2NfcHJlZW1wdGlvbl90aW1lcl9yYXRlKHU2NCB2bXhfbWlzYykNCj4gIHsNCj4gIAlyZXR1
cm4gdm14X21pc2MgJiBWTVhfTUlTQ19QUkVFTVBUSU9OX1RJTUVSX1JBVEVfTUFTSzsNCj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvY2FwYWJpbGl0aWVzLmggYi9hcmNoL3g4Ni9rdm0v
dm14L2NhcGFiaWxpdGllcy5oDQo+IGluZGV4IDQ1MTYyYzFiY2Q4Zi4uZDg4NDllNDJjYTgwIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0vdm14L2NhcGFiaWxpdGllcy5oDQo+ICsrKyBiL2Fy
Y2gveDg2L2t2bS92bXgvY2FwYWJpbGl0aWVzLmgNCj4gQEAgLTU0LDkgKzU0LDcgQEAgc3RydWN0
IG5lc3RlZF92bXhfbXNycyB7DQo+ICB9Ow0KPiAgDQo+ICBzdHJ1Y3Qgdm1jc19jb25maWcgew0K
PiAtCWludCBzaXplOw0KPiAtCXUzMiBiYXNpY19jYXA7DQo+IC0JdTMyIHJldmlzaW9uX2lkOw0K
PiArCXU2NCBiYXNpYzsNCj4gIAl1MzIgcGluX2Jhc2VkX2V4ZWNfY3RybDsNCj4gIAl1MzIgY3B1
X2Jhc2VkX2V4ZWNfY3RybDsNCj4gIAl1MzIgY3B1X2Jhc2VkXzJuZF9leGVjX2N0cmw7DQo+IEBA
IC03Niw3ICs3NCw3IEBAIGV4dGVybiBzdHJ1Y3Qgdm14X2NhcGFiaWxpdHkgdm14X2NhcGFiaWxp
dHkgX19yb19hZnRlcl9pbml0Ow0KPiAgDQo+ICBzdGF0aWMgaW5saW5lIGJvb2wgY3B1X2hhc192
bXhfYmFzaWNfaW5vdXQodm9pZCkNCj4gIHsNCj4gLQlyZXR1cm4JKCgodTY0KXZtY3NfY29uZmln
LmJhc2ljX2NhcCA8PCAzMikgJiBWTVhfQkFTSUNfSU5PVVQpOw0KPiArCXJldHVybiB2bWNzX2Nv
bmZpZy5iYXNpYyAmIFZNWF9CQVNJQ19JTk9VVDsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGlubGlu
ZSBib29sIGNwdV9oYXNfdmlydHVhbF9ubWlzKHZvaWQpDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rdm0vdm14L3ZteC5jIGIvYXJjaC94ODYva3ZtL3ZteC92bXguYw0KPiBpbmRleCBkN2JmMTRh
YmRiYTEuLjY0YTQzYzJkNzJlOSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL3ZteC92bXgu
Yw0KPiArKysgYi9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jDQo+IEBAIC0yNTk3LDEzICsyNTk3LDEz
IEBAIHN0YXRpYyB1NjQgYWRqdXN0X3ZteF9jb250cm9sczY0KHU2NCBjdGxfb3B0LCB1MzIgbXNy
KQ0KPiAgc3RhdGljIGludCBzZXR1cF92bWNzX2NvbmZpZyhzdHJ1Y3Qgdm1jc19jb25maWcgKnZt
Y3NfY29uZiwNCj4gIAkJCSAgICAgc3RydWN0IHZteF9jYXBhYmlsaXR5ICp2bXhfY2FwKQ0KPiAg
ew0KPiAtCXUzMiB2bXhfbXNyX2xvdywgdm14X21zcl9oaWdoOw0KPiAgCXUzMiBfcGluX2Jhc2Vk
X2V4ZWNfY29udHJvbCA9IDA7DQo+ICAJdTMyIF9jcHVfYmFzZWRfZXhlY19jb250cm9sID0gMDsN
Cj4gIAl1MzIgX2NwdV9iYXNlZF8ybmRfZXhlY19jb250cm9sID0gMDsNCj4gIAl1NjQgX2NwdV9i
YXNlZF8zcmRfZXhlY19jb250cm9sID0gMDsNCj4gIAl1MzIgX3ZtZXhpdF9jb250cm9sID0gMDsN
Cj4gIAl1MzIgX3ZtZW50cnlfY29udHJvbCA9IDA7DQo+ICsJdTY0IGJhc2ljX21zcjsNCj4gIAl1
NjQgbWlzY19tc3I7DQo+ICAJaW50IGk7DQo+ICANCj4gQEAgLTI3MjIsMjkgKzI3MjIsMjUgQEAg
c3RhdGljIGludCBzZXR1cF92bWNzX2NvbmZpZyhzdHJ1Y3Qgdm1jc19jb25maWcgKnZtY3NfY29u
ZiwNCj4gIAkJX3ZtZXhpdF9jb250cm9sICY9IH54X2N0cmw7DQo+ICAJfQ0KPiAgDQo+IC0JcmRt
c3IoTVNSX0lBMzJfVk1YX0JBU0lDLCB2bXhfbXNyX2xvdywgdm14X21zcl9oaWdoKTsNCj4gKwly
ZG1zcmwoTVNSX0lBMzJfVk1YX0JBU0lDLCBiYXNpY19tc3IpOw0KPiAgDQo+ICAJLyogSUEtMzIg
U0RNIFZvbCAzQjogVk1DUyBzaXplIGlzIG5ldmVyIGdyZWF0ZXIgdGhhbiA0a0IuICovDQo+IC0J
aWYgKCh2bXhfbXNyX2hpZ2ggJiAweDFmZmYpID4gUEFHRV9TSVpFKQ0KPiArCWlmICh2bXhfYmFz
aWNfdm1jc19zaXplKGJhc2ljX21zcikgPiBQQUdFX1NJWkUpDQo+ICAJCXJldHVybiAtRUlPOw0K
PiAgDQo+ICAjaWZkZWYgQ09ORklHX1g4Nl82NA0KPiAgCS8qIElBLTMyIFNETSBWb2wgM0I6IDY0
LWJpdCBDUFVzIGFsd2F5cyBoYXZlIFZNWF9CQVNJQ19NU1JbNDhdPT0wLiAqLw0KPiAtCWlmICh2
bXhfbXNyX2hpZ2ggJiAoMXU8PDE2KSkNCj4gKwlpZiAoYmFzaWNfbXNyICYgVk1YX0JBU0lDXzY0
KQ0KPiAgCQlyZXR1cm4gLUVJTzsNCj4gICNlbmRpZg0KPiAgDQo+ICAJLyogUmVxdWlyZSBXcml0
ZS1CYWNrIChXQikgbWVtb3J5IHR5cGUgZm9yIFZNQ1MgYWNjZXNzZXMuICovDQo+IC0JaWYgKCgo
dm14X21zcl9oaWdoID4+IDE4KSAmIDE1KSAhPSA2KQ0KPiArCWlmICh2bXhfYmFzaWNfdm1jc19t
ZW10eXBlKGJhc2ljX21zcikgIT0gVk1YX0JBU0lDX01FTV9UWVBFX1dCKQ0KPiAgCQlyZXR1cm4g
LUVJTzsNCj4gIA0KPiAgCXJkbXNybChNU1JfSUEzMl9WTVhfTUlTQywgbWlzY19tc3IpOw0KPiAg
DQo+IC0Jdm1jc19jb25mLT5zaXplID0gdm14X21zcl9oaWdoICYgMHgxZmZmOw0KPiAtCXZtY3Nf
Y29uZi0+YmFzaWNfY2FwID0gdm14X21zcl9oaWdoICYgfjB4MWZmZjsNCj4gLQ0KPiAtCXZtY3Nf
Y29uZi0+cmV2aXNpb25faWQgPSB2bXhfbXNyX2xvdzsNCj4gLQ0KPiArCXZtY3NfY29uZi0+YmFz
aWMgPSBiYXNpY19tc3I7DQo+ICAJdm1jc19jb25mLT5waW5fYmFzZWRfZXhlY19jdHJsID0gX3Bp
bl9iYXNlZF9leGVjX2NvbnRyb2w7DQo+ICAJdm1jc19jb25mLT5jcHVfYmFzZWRfZXhlY19jdHJs
ID0gX2NwdV9iYXNlZF9leGVjX2NvbnRyb2w7DQo+ICAJdm1jc19jb25mLT5jcHVfYmFzZWRfMm5k
X2V4ZWNfY3RybCA9IF9jcHVfYmFzZWRfMm5kX2V4ZWNfY29udHJvbDsNCj4gQEAgLTI4ODMsMTMg
KzI4NzksMTMgQEAgc3RydWN0IHZtY3MgKmFsbG9jX3ZtY3NfY3B1KGJvb2wgc2hhZG93LCBpbnQg
Y3B1LCBnZnBfdCBmbGFncykNCj4gIAlpZiAoIXBhZ2VzKQ0KPiAgCQlyZXR1cm4gTlVMTDsNCj4g
IAl2bWNzID0gcGFnZV9hZGRyZXNzKHBhZ2VzKTsNCj4gLQltZW1zZXQodm1jcywgMCwgdm1jc19j
b25maWcuc2l6ZSk7DQo+ICsJbWVtc2V0KHZtY3MsIDAsIHZteF9iYXNpY192bWNzX3NpemUodm1j
c19jb25maWcuYmFzaWMpKTsNCj4gIA0KPiAgCS8qIEtWTSBzdXBwb3J0cyBFbmxpZ2h0ZW5lZCBW
TUNTIHYxIG9ubHkgKi8NCj4gIAlpZiAoa3ZtX2lzX3VzaW5nX2V2bWNzKCkpDQo+ICAJCXZtY3Mt
Pmhkci5yZXZpc2lvbl9pZCA9IEtWTV9FVk1DU19WRVJTSU9OOw0KPiAgCWVsc2UNCj4gLQkJdm1j
cy0+aGRyLnJldmlzaW9uX2lkID0gdm1jc19jb25maWcucmV2aXNpb25faWQ7DQo+ICsJCXZtY3Mt
Pmhkci5yZXZpc2lvbl9pZCA9IHZteF9iYXNpY192bWNzX3JldmlzaW9uX2lkKHZtY3NfY29uZmln
LmJhc2ljKTsNCj4gIA0KPiAgCWlmIChzaGFkb3cpDQo+ICAJCXZtY3MtPmhkci5zaGFkb3dfdm1j
cyA9IDE7DQo+IEBAIC0yOTgyLDcgKzI5NzgsNyBAQCBzdGF0aWMgX19pbml0IGludCBhbGxvY19r
dm1fYXJlYSh2b2lkKQ0KPiAgCQkgKiBwaHlzaWNhbCBDUFUuDQo+ICAJCSAqLw0KPiAgCQlpZiAo
a3ZtX2lzX3VzaW5nX2V2bWNzKCkpDQo+IC0JCQl2bWNzLT5oZHIucmV2aXNpb25faWQgPSB2bWNz
X2NvbmZpZy5yZXZpc2lvbl9pZDsNCj4gKwkJCXZtY3MtPmhkci5yZXZpc2lvbl9pZCA9IHZteF9i
YXNpY192bWNzX3JldmlzaW9uX2lkKHZtY3NfY29uZmlnLmJhc2ljKTsNCj4gIA0KPiAgCQlwZXJf
Y3B1KHZteGFyZWEsIGNwdSkgPSB2bWNzOw0KPiAgCX0NCj4gDQo+IGJhc2UtY29tbWl0OiBmNmNk
ZTkyMDgzZGVjNWNmNDI0NTA0ZDcwMjlhY2RmZmJlNWJlZWQ4DQoNCg==
