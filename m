Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7E9634BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiKWBCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiKWBCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:02:34 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC9E65AC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669165353; x=1700701353;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Oe+PUo+WgXOBGhni79dxlm6fAbZsSpMIVuRe2C8AD5A=;
  b=bBvKEeoDkqq44wMeeejQZBN1M14GtwWiiDVbejbXFUls4cRXgYEu+o9x
   micQFvlA6J3Tmbtmmb4iezOnVxcHBlZN/rYtpvHW52Thhzb7tQU0NJ3U8
   GjoGekKGdf0yXtohfnsH48rd4LJXZzPBoRkmThPXlH66VC9aIVDogG649
   y9fYMeBPUrABghsvm5QrnkycCHY/WNgfjFbdWok8A3KxW146GWryI8pCb
   kr1HyJao98R5qM1rE9cHOwEZWJLSMjUu7C+TNqvU9ZzmmLbidoVn/tsGh
   0KdpoPz1BCe3JOlkKpeFL5hcPnUPKek82T26JfDtmdMMrvj8p/UuHhOKE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="315104269"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="315104269"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 17:02:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="886745553"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="886745553"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 22 Nov 2022 17:02:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 17:02:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 17:02:31 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 17:02:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B10HD/+UcC2QCUj90VeEZmmt9ORUcbuG3B+qDCb3sCOLfZdFuH3uveTu6Api8ABDgPY5iXNtJRZx6OJgQLiHMf6LEOgTl4idaEzFzanbF76KsEZxummjYTjd2HVWZ9OudzNUf8Hai0DR9qpN9b2klfwDTTbzo1Wm/HWoAKJNG8L1uazBHM+uc/c6vPsu01N1jq36rHRAJ6ZWQvN1d9tWPmust7thYks9SqwBv6uQ+6xH0N21mu2T/84fPf2y1ax4hB4wsD7VKYC9JraWUFvbZ9Ye4KPlH/+sKcEn0M2SN1RH+CtINXqrEdeEfXOZZJyotV+U2i2MXmXsZkXVv3Y/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe+PUo+WgXOBGhni79dxlm6fAbZsSpMIVuRe2C8AD5A=;
 b=Y3h/oC5WfELnMadTj//MgXPZ/ia7WBeoINx6/E+B4yD1EePTB9kJyM5ByUzBA2gt1wGQOBXzwfhvUgmPeTUxwB4BWt5reMGwcr2rrcXRTNOFzN4DpxwSMIwwt4i4QkVkA04azDUObEyvGdew96GoOqiFQ8s0Ot0jAqBZcnTeIeqJVuX7Qv9PFuEypBT77SJXj4KX09YzL15aY0+SSGPgtfOW/tR1dHunoagg1QZUx1g6EQ+pdX1oBSQtYgWnCqiIbK6HqqnTq/PsK/RWp+8AWmS8K/nsbIBiwETr+g/G4oEi1UCDtxQcFA3Ku7HSKppvL/GlOroIEi2zz5nSMkPGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5319.namprd11.prod.outlook.com (2603:10b6:208:31b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 01:02:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 01:02:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
CC:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Luo, Yuzhang" <yuzhang.luo@intel.com>
Subject: RE: [PATCH] iommu/vt-d: Add a fix for devices need extra dtlb flush
Thread-Topic: [PATCH] iommu/vt-d: Add a fix for devices need extra dtlb flush
Thread-Index: AQHY/iRZ1HNxV1akM0yWbTOvvjHGEq5LOSEAgAB3ReA=
Date:   Wed, 23 Nov 2022 01:02:29 +0000
Message-ID: <BN9PR11MB527620902046A4339EAACD3F8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221122034529.3311562-1-jacob.jun.pan@linux.intel.com>
 <bc647ceb-b14b-dc5b-ba83-4f8befd188c5@arm.com>
In-Reply-To: <bc647ceb-b14b-dc5b-ba83-4f8befd188c5@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5319:EE_
x-ms-office365-filtering-correlation-id: 9741ed89-d658-41fd-1f0b-08daccee6549
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ie5/v2mQVgwwtUE6BdZw5HIKfDzNvXXZGbx3wBxJDwPy7wjWYcJdCfOjLQkPadCfUenCk0R8J03yQlJMx5B0mQx6NobSKxCOevPxm35sp61r/rdnQZU4fkL42Lcjhae8d5QVldUpH3vCg3MjDcOAAkHvRu7PKicLtBmcBzmL3bwFiIfolEdSPZ18NWdND/Phh5s4XsxoYPzeZ96sKZTG6NGDH6qpoMwdPIIp5zxEh4uf3yM6oo5XHSsDUUmIe1YAsdFASOde3paz03OVUrnXsIdkap7/D04LvVOrL+uHRUIpPUL8EoVKZylP3VSheNpj6Y1/tJtipa0u1yRJGi00rm09RTIuLXy0ut+ZBPax21vI5YTr22d3ZOBbK4LbI7IWJvBsBQgV6AZ7CqyctY47wxccEzDYJVWKa0yuDY0Md0hOkP7Q7ihYxMRUyHCqDWoRjN8LOWPKFsY3eq80h0K8ry1zIvOnNEl6WjC2sva/GXKAM33TuNk0wDnED8fxI+aVcdZgik1y4V6B7ZFu5++yc+l7EXjrjNnfM4YjZWFhtVVf06PPMnCf3WnziDixZrcKALJ5BK0K8kVahKt7SuFz4d2NOV5F7GfAkkvLseoY+cSFeKPfmTFiAf60370ghI5u7ePI3Gbn/Yxh5MUDojXeuXGE14YUAqBToMYwtngyXv0a+WeUgmvAVrcuINsu0q6hqCYx2lFnbxvlKuJybBsuUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199015)(8936002)(52536014)(4326008)(5660300002)(66476007)(64756008)(76116006)(38070700005)(8676002)(66556008)(66946007)(66446008)(86362001)(55016003)(41300700001)(54906003)(82960400001)(26005)(2906002)(33656002)(110136005)(186003)(83380400001)(38100700002)(71200400001)(122000001)(478600001)(7696005)(9686003)(6506007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUxINVdmU0swSFFwendiVmdZWkg2VW5zR05tZ0RvZnVMSDJFbytiMHZFQ1pr?=
 =?utf-8?B?OC9Rd3JDVWxweTdzQXFJYzR4WVkvZTBTeklTY3J0MjdVVWN1ZC82enBMSm5N?=
 =?utf-8?B?QVBOcC9SK2Z2dy9vaHJKay9CQWN6czlmSEpIYmhnNGNXZjZBdFhINFM3V3pP?=
 =?utf-8?B?MTNaZk55VjF4b3BKWG9PZG9veitJSTkycWhMRkFiZnZFcW41ZUUxZk1Vaksx?=
 =?utf-8?B?cWlYSGZ0V01pZFBZci85VWtIakVna0k1a1JydTU5eUZrOEp2bnJMNk5sMEla?=
 =?utf-8?B?UUw1dm81SkthSlg2OGFnbGVaeEFxV0ozQWROWFVkTEFhY1VwNkVnZzFkY2cv?=
 =?utf-8?B?Ym8xeUJndktvNlBrdGdVcVU2NE9maWZWZDAzSWVXeE5JNitZaUR0RTZjSGRT?=
 =?utf-8?B?SE5SMEgyUFlpUUdKZHNDMkMzMzZFZWs3dEZYcWppNG9KMXdnaDR6YXZmZDZ2?=
 =?utf-8?B?UTlYQThaVnRRWG9jb21tY2NyQU9Ob2t5RFVhdTh0dURSbmh2c2U5SHJPckls?=
 =?utf-8?B?NkJCZ2FtUUgzYUFidXI1dWRaUjZDREh6NGlEYmpTZExtc3o1NW45aTlKY1ZF?=
 =?utf-8?B?VS9tSnBhMnZPZ25YMGx2V2tWelhEVkxxcDVtVUZQWm5rblBRMWw1Tk1DSXAr?=
 =?utf-8?B?Y1lDSGFKYXMybzlpUVpaanBHMjQ3djNjb0hyaGxuM1FKQzM5ZTA3YkFXK1JR?=
 =?utf-8?B?cVRjQ2xRdDRwRUN4V3pMR0x5M1RYcVdLNkVhSDhQNEZuNGd6QVMybWNsZ1NP?=
 =?utf-8?B?ckRSaG1Td2xnVnJNS3lsaFN4cXJuUEJ5d0ZMTEkzVzd6QVM5QzhBTGd2K2E4?=
 =?utf-8?B?cG1nMjArUnh5alZkb3IzSExMSjRKZU5qTWhYZFNUSEFhWkdCZlQ3RmRmYUhp?=
 =?utf-8?B?bFptWlVjU2ZvOGY0NU53TDFxSXZLdlM4VWhKUHgrOFBPOWhnRWhBSHRGN25y?=
 =?utf-8?B?UEZEeU5aRkxBTDNyYVlPcVFCMzB5Q2loZ1ZNdWNqbWFqYWU2dmh3Vi85OWFj?=
 =?utf-8?B?WkhhRERzbVlTOUYwWk03cW43cnRJT3VoUGN0bzhNbk1KRXA4bDhpK0hvVURV?=
 =?utf-8?B?UUVnZCtGZzF3QUl0bzRHNnhmenNyNE5SRnVvaHAxenB6MWxKclpWN1hBVGNy?=
 =?utf-8?B?SDEybUxXc1RCMlVObzRSR2RBaHRSNTVZNWhoc1JRcTZmTFY4c1pHaFdVNEhj?=
 =?utf-8?B?SWI1VnRWZkJpRzVmRjJWa2gvTnpXZzV2M1lvazI3b0hnOXQzOUhqRTYzR3ZY?=
 =?utf-8?B?QlJmTlpNU0NPSjN0SStydGpOQ2dmNXFQU2JPUkdldXQ5YmVDcVhuWVFyRjND?=
 =?utf-8?B?STBGazdqQ0hKN0JaMjlWVVdaTXQ0SE5SbWpzQjg1MWxvQjdXcjZLS1lLMlZh?=
 =?utf-8?B?UmNLUkRIQmZFOGl1S21WVWlibndMR0R1eDhRK0NGT1Ryd3VFWE9Ibis1cHNS?=
 =?utf-8?B?bU1BSFpFN1ZvQUlSTWlHR0RIekdZQmN4V21BYXRSeERZOUhsS3BOTXFsd0I0?=
 =?utf-8?B?S2pLcVFkTUx5VEhjWG4yMDZUMnpCeDdkbUt3azV3S0hQenJqSC9WWE9Db1c0?=
 =?utf-8?B?bFo0TlJPWXRnbk4wQ09jdWkvcEVvaDBUVlc3UGwxRkZVVEwwM0Y0Sy9WUVg4?=
 =?utf-8?B?OTJCNzJSVCtuRzBkc0lUYVY3NnRnTUxwaFpJMnBDSG9pbDJMOUZiM2Qyak51?=
 =?utf-8?B?bFlUZkpKajRVMjJjQThMdzEwM2crL0UxalRxdUdKT3FoYnRoWDdZVlIrZkEz?=
 =?utf-8?B?a2NGbU5jUk1sSVV5RnJDdDhtQWJTaU12OWVJeTZvbTJqbjhOaWVJa3Y4VW16?=
 =?utf-8?B?VDBDc2dDSjBPR0lmNWFpdmVOdzQyK1Y1OWhrMmdnN2txYkRxSEVyN1U5YldP?=
 =?utf-8?B?b2p1ZTljQzBucEVJV3ZBL2pnazR1OE1LU3cwem5ocDkvQitxNEthOFd4NEhY?=
 =?utf-8?B?d21YSG95VCsxdS9BSmkxblRLSFBaVkdqeGtMTEtrYzQ3Z3ZJcmxrZnlZSFZP?=
 =?utf-8?B?YkwzTDFtbUhKZXRxOTlEMzJ3MXg1VFhGK1ZUK2VhazdWdkhqT2U0ZFY2S0pF?=
 =?utf-8?B?MlhPcTVlMzhIdDNYUmRiU1ZpRno0U04vNk5BRmh2U2orc3oyNmRjdm81OWIv?=
 =?utf-8?Q?ZwISkAEigVF95jrFF48/Rmta1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9741ed89-d658-41fd-1f0b-08daccee6549
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 01:02:29.9451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XvyYJSR4b0zoM8iHqG1EGFvSj8+GZ3MxB0MK0X8TL98K4lhgCRJxRTNIgK6ciZYwwUB/16PSYVHewAkhb6xlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5319
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE5vdmVtYmVyIDIzLCAyMDIyIDE6NDkgQU0NCj4gDQo+ID4gKw0KPiA+ICsvKiBJbXBh
Y3RlZCBRQVQgZGV2aWNlIElEcyByYW5naW5nIGZyb20gMHg0OTQwIHRvIDB4NDk0MyAqLw0KPiA+
ICsjZGVmaW5lIEJVR0dZX1FBVF9ERVZJRF9NQVNLIDB4NDk0Yw0KPiA+ICtzdGF0aWMgYm9vbCBk
ZXZfbmVlZHNfZXh0cmFfZHRsYl9mbHVzaChzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gPiArew0K
PiA+ICsJaWYgKHBkZXYtPnZlbmRvciAhPSBQQ0lfVkVORE9SX0lEX0lOVEVMKQ0KPiA+ICsJCXJl
dHVybiBmYWxzZTsNCj4gPiArDQo+ID4gKwlpZiAoKHBkZXYtPmRldmljZSAmIDB4ZmZmYykgIT0g
QlVHR1lfUUFUX0RFVklEX01BU0spDQo+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ICsNCj4gPiAr
CWlmIChyaXNreV9kZXZpY2UocGRldikpDQo+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiANCj4gSG1t
LCBJJ20gbm90IHN1cmUgdGhhdCB0aGF0IG1ha2VzIG11Y2ggc2Vuc2UgdG8gbWUgLSB3aGF0IHBy
aXZpbGVnZSBjYW4NCj4gdGhlIGRldmljZSBnYWluIGZyb20gYmVpbmcgdG9sZCB0byBpbnZhbGlk
YXRlIHRoaW5ncyB0d2ljZT8gV2h5IHdvdWxkIHdlDQo+IHdhbnQgdG8gaW1wbGljaXRseSAqYWxs
b3cqIGEgZGV2aWNlIHRvIHBvdGVudGlhbGx5IGtlZXAgdXNpbmcgYSBzdGFsZQ0KPiB0cmFuc2xh
dGlvbiBpZiBmb3Igc29tZSBiaXphcnJlIHJlYXNvbiBmaXJtd2FyZSBoYXMgbWFya2VkIGl0IGFz
DQo+IGV4dGVybmFsLCBzdXJlbHkgdGhhdCdzIHdvcnNlPw0KPiANCg0KQVRTIGlzIGRpc2FibGVk
IGZvciBzdWNoIGRldmljZSBoZW5jZSBubyBkdGxiIGF0IGFsbC4NCg0KYm9vbCBwY2lfYXRzX3N1
cHBvcnRlZChzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0Kew0KCWlmICghZGV2LT5hdHNfY2FwKQ0KCQly
ZXR1cm4gZmFsc2U7DQoNCglyZXR1cm4gKGRldi0+dW50cnVzdGVkID09IDApOw0KfQ0KDQpTbyBh
Ym92ZSBjaGVjayBkb2Vzbid0IG1ha2UgdGhpbmdzIHdvcnNlLiBJdCdzIGtpbmQgb2YgbWVhbmlu
Z2xlc3MNCmJ1dCBhY2NvcmRpbmcgdG8gQmFvbHUgaGUgd2FudHMgdGhhdCBjaGVjayBpbiBldmVy
eSBxdWlyay4uLg0K
