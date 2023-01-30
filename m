Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BF7681144
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbjA3OLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbjA3OLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:11:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29CA3B660
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675087890; x=1706623890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tRs/FH7PiGpDnQN/fXnA9aKW1wNwcq0Pch2fPdjGPOo=;
  b=Vz4jeub0wpm6Yr0k5yFdMMOnEPzEMApdKrNTydnDcQZh92uKICY10xf6
   qwvACSFOxQCy0ldJhw6S1gnVOyf9/AzmdmRu8ZBxGrCTMfWcPLovcs6LB
   ScNFjYhMOyCMXDgsW8EKwGrEKnUc9n3CFCKmdMzSTrDQOJpRVAv7kQwGN
   StV4KtqvCeN5qzBKjuvhHDf9dMga8LdVNDlLbZltaD6+0dQV9jogVhCmY
   LEpS+zcHtkuKS1fjlNTVPrVGfb6tEMj/p3LrOUlak+kojMUtTdbdIX3Eu
   bVM9RLSI+0CgZ+53+Yz0bKuHiVsmorkh9Xl+pIKyZl/ZptpZwFf3Z9UkE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="354879833"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="354879833"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 06:11:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="641553701"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="641553701"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 30 Jan 2023 06:11:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 06:11:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 06:11:29 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 06:11:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYQ6+X5whWYUGcdw78zhzipyl/THSt91EiGydSF12MRjXmEa1tGyODFQ9WSXtNn7t/uhsg2P82HVhzQH5591fZ27/Y3nY4Vb8lqcVrzM6WbpIZagi12hHYYLtcO2DRfDAEvuuj4mPnWX7FWC/Z+QIC23sOCp8JfsukeCiT/xXPdldhSPoNUf/HPNk/2ZkE84hRpAxyVe3OIEU5J9rYsC/wl8CrmMVwPhcD0+pnZKC1ZEneY3OMl3EhUEtijhvPS1LE84O6zTKGMjRzMl7HxnqbjKMD7s/tiwNcJURZkuQ6rlu5F18KrtavTt0sZJcsBPeaZyOj468itWcBtMrPmLTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRs/FH7PiGpDnQN/fXnA9aKW1wNwcq0Pch2fPdjGPOo=;
 b=M7Q5DhSRg5hHPgEaRPK1v+UKPAvtyrF6dhAzVEC2OKOOP/LA5aa92coDgKYBMWNeNl3hbyY+gOTGYUKdEpC1Wr1bHqiMyZ3Y6P8xtiqz009AIih5HN82sC5T1GBfMMOnbQOByufB4SLDtzsAZdJikYlo4DGqGYi0ZDtYJXo2/lRPdejkNVcRHd/+ehgpQ5biiT2B0uIKy+Tj/wpchdNpsJNWMY+FPWJjpGme37gXOTWxBWpLR0oW7w1uLYdGsWtZnBsyuIit6sGByOrUvKWIhhKlRr6wzfeDCNc8fT8Q82vNBGpky9uWLQj/heBBtmmMbTvH/Htl14W4gri9nMgp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3240.namprd11.prod.outlook.com (2603:10b6:a03:18::19)
 by SA0PR11MB4640.namprd11.prod.outlook.com (2603:10b6:806:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 14:11:26 +0000
Received: from BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::c42:6379:b57f:4a59]) by BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::c42:6379:b57f:4a59%7]) with mapi id 15.20.6043.021; Mon, 30 Jan 2023
 14:11:26 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>
Subject: RE: PPS functionality for Intel Timed I/O
Thread-Topic: PPS functionality for Intel Timed I/O
Thread-Index: Adk0qfZfZVvAvtJ8SP+qSzpYuQsN4wAByXCAAACHHGA=
Date:   Mon, 30 Jan 2023 14:11:26 +0000
Message-ID: <BYAPR11MB3240801F21598EEFAEA79605E1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
References: <BYAPR11MB3240A86B426158623DB9983EE1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <fa3f1765-eb59-bf69-7f7b-14621caef6ea@enneenne.com>
In-Reply-To: <fa3f1765-eb59-bf69-7f7b-14621caef6ea@enneenne.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3240:EE_|SA0PR11MB4640:EE_
x-ms-office365-filtering-correlation-id: a75b190e-3aef-47b5-f8df-08db02cbe004
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tU+eGWLVyPUmB6GE/Vb9klMC01fu7MI+3uUcvNZVC87dcTt61kDiFJPLFC5zRmrwgKKv+OIPFSgR9NsADmjjrYtvzw6Ohl7dRHYR1E+AN7QVDs51K8K0+XJS2Sy1IMSIeqrlQ03jC8XWP3F0STrdEg7kUjLnQnK73GImGOX1rpLHMl9mGhBQPl7EtwzhN3ATjmzOKzliF6d/eHmuDZKNl/NhgMurbvAUl3X2TY5Oph4h4sTMwKcKAVPHQTdyGkgCwmTwWFTVWt/ZZvCMhStof3S1zg6Bh4BHGFNnT42FyQ1TrE0VCHcT5GF/wJcpe/MJx5T7nsUHoKGDWY2nfieJtSN7QOlkU3UNsFFtEk2Ou+lXc05BoRRZJfp5E3oh/QFmVVfjXTI/tBCexpO5rS9fUb6KbnsH4SE7csoGZTNzDT8b66JJ6HxIAdmD/P8sXPd8Fcm2IOXVum3BW/bu4Q5786rHrnfSxOZIK0+9oyIHaNOZIi8m1WQWLM81qhH5UIRTisC9090VGqdiGHK66KibOayqO/vj7y2BnWtFI2wuJ66VLUVJGVIk/N8ms8khrNZW4zZe7rH2gR/BZ7s8s9WByGl5C0I17GvhuYdqhSFtVxxj819PL17Zud5Jd+Nvad2qUX/0oUHjHM8hLm5lsdk8OtY89FeSUX++oR/39k6Npy2wP1wWXa6TJjfRbF+YLBOyTujyfVaaDcmhlR7cr3NSfhYqNpobXRVQWfIze1kF2Uc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3240.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199018)(86362001)(38070700005)(82960400001)(38100700002)(122000001)(33656002)(478600001)(2906002)(54906003)(7696005)(107886003)(966005)(41300700001)(55016003)(26005)(71200400001)(52536014)(8936002)(5660300002)(66946007)(316002)(66446008)(8676002)(76116006)(6916009)(4326008)(83380400001)(66556008)(66476007)(64756008)(9686003)(186003)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzlZM1RvanFYUHVkVGQ2L3lLaTYvdnhiQjJ1TXRVUzA5QlpEeEFMS0lwVW5q?=
 =?utf-8?B?VUpCbWtHYlpOaXBkekh2TCtwWkVKcENVSHB4SHdoTWhDS1BQcEZSWVNZL1h6?=
 =?utf-8?B?eGY0ekZ0Z3VvNGpwSlluMmNNaHB1ZThaNmlwZkxNMjNNdXpadyt6bkJneStK?=
 =?utf-8?B?UGR1QVRlcmVCZVN1cURUWmdtd004R1A1Y0JEbTM5amJBQ0lrblNQeWF4WDBK?=
 =?utf-8?B?RTlub0Z2RFliOVBPWm13Y0hwWHVHekFrTFcvQ041SlVmekdEUEJpYzlEb0h1?=
 =?utf-8?B?SGVqc2RQV0JpT0hoMVk3bWlyYjk0Vk1ldjB5MHVGUll2RXJ1Rk1zL1oxYkd2?=
 =?utf-8?B?VlRVMnREb3ZnelF2eWJvaExOOXRtdmFoRDAvVi9nWFZLTnVXTzg0NmVBNVB6?=
 =?utf-8?B?dVVyZFNtZGZKUGZuTmY5a2tNNExUUlZHczJhcWFQUlJ3NksxdVMvTWx5UGF0?=
 =?utf-8?B?YVFtdUJWcUdXOXJiUjJQZkY3c2RxV2k3dCtMTytSbGt0WCszSFJuQjlRRXF3?=
 =?utf-8?B?NVJ0eGdQbWNxdFlvVEs4VjF6Uk1Bd0s3bTUzYndVZ0xramRFcGJSbVBhZEJM?=
 =?utf-8?B?V1Y4S28wUmZ4SmZhTHFjbFUzSFVkVDVkS1hHWXQ2emNwek5POC8wZWkyR1dQ?=
 =?utf-8?B?Zy9mMmJ2T1B6aVVBVTcveXgvUDZqZmJIdEZVMWwyWEpCa1drTGYvWFNVMjlM?=
 =?utf-8?B?RE4yODhUK09ETytWSkpNcld5ZTNtRDAwYk9OZU85NUpJbzF1bmRDdGozbkFs?=
 =?utf-8?B?ZS93MHRXSmNlNC83VjZjT0ZrNTJYSGVaOUVKcXk4M3dad0V4dURoMkZNTkpI?=
 =?utf-8?B?dm9tSytSVjVWNi9hdXFZcXpZdjVyUWFrSElaOVJXdzVoQStNdDV5dzJlQWx3?=
 =?utf-8?B?VWhYQlRSSE5yWnNJR0VCSjU1UEFDaVJBcEVUbDZVbUZpaDNudjV5Qlc1RzVI?=
 =?utf-8?B?bldqWHppRUhUQXVRNlpNZlV4VlNFWnhhMGtqbTdOekF3WUtITHhwY3crUmFl?=
 =?utf-8?B?Tk9OYUgrTHMrL05WR29PSmtGcW9uZWhnWEkybWcxWkVNa0FPaVk4cWNpQ1By?=
 =?utf-8?B?NlhDQzJMZ09nd2ZkbERISTEwOVdqV1VoRjRvTmJ1RkxWK0JLbGJWaTFHOW1G?=
 =?utf-8?B?KzVRZklPT09MYThTUUJDUW94WG9IMmxqdWtTbnR1bjBPTEZLeWFKaFEwYlVV?=
 =?utf-8?B?V0Zxb2NGRGtNMTlUTkxSUU56SWFaODZRMmRmODVDMG1yTmVBaFFmSU9tUjZS?=
 =?utf-8?B?aGRtMWFyYUdMbVhkNHh5Y2dJbTBnWGZFZGJDejJUaGNzQzBQQWxOLzFiVG9k?=
 =?utf-8?B?Y1NMaHJRdGdYZGE4YVU5YVB2WXBhS1FHendJVHhFUEhDRXhMYThHbmdiKzFq?=
 =?utf-8?B?UVR1d0tKRTZNbWQxSXArWitNcWNWNUw2VE1iNDV2NXRrdGJuMGIyT2hib0hR?=
 =?utf-8?B?MmM2L0xpVmluUU9leVVkSHRmRWo5UEU2MWlNMC8xUWJhUUFCTFNpTTJEQW9C?=
 =?utf-8?B?WGdDMFQyUGJxMC9abVkwWnBHSXJ1YjBPcVYyV2srWTBWY2tBTEtGTDNzVUdn?=
 =?utf-8?B?ZkZtaWVXNHpTT3g3UGR4anYzcjdVV2hyVFl5a29tUGZDUW1JdDNWTFd0dHFi?=
 =?utf-8?B?VVVMSmxOejFoMXZ4R3lkazN5R1NXaCs5VTNDdzVpdXFRZ3lLeVVkWlFINFJV?=
 =?utf-8?B?Zit3ck5aYnJFT1IwZTJPVC9UcEVCZyt4SFNSOEdmYXJPZGR3VnoyTHoyS2Zm?=
 =?utf-8?B?SnQxQytKZDFDRVVxWWEwa1UxZ1lhcStlOFlTMlREQ0NyQUI0b0l4eHRVTStu?=
 =?utf-8?B?aldjMTloMVhuQzhSTlFwNXVibFdzOGxPQTNnVUZGZ1NWaC9RTEM5eUpuODM5?=
 =?utf-8?B?OSswbjRxU01VOEJJVVE4OHBLREF2SmxRbXpwVGw2bThTVDJGc0NZZ1oxdmhN?=
 =?utf-8?B?ek51OExsUGJ6R0hRZTVjRnZ0TE5SemtDUTFGTDl1dWwrNlVMcCs0cHdPY1oy?=
 =?utf-8?B?R2x6K3pycWtnOEkxMUR0WE44UmxScWZETUdOQWs0WGZEdTlxTkExZ0k5Mjdu?=
 =?utf-8?B?aVZEYVgxblF5RzZJbUErUzR5UzUwZGt0cEg2Nm9YOWErZUpMY3FzSVJNc1la?=
 =?utf-8?Q?048+CS3DOBPetOKYnlWccB3Yx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3240.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75b190e-3aef-47b5-f8df-08db02cbe004
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 14:11:26.2627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOtu+K2xGGe649EceyhSq6HlIZAulLEq9ZhJtxi/oHoBiZ65b9TLO3JT+0Rlt6kZpKsg3JeZ2pRNPzEpsOMLWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4640
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9kb2xmbyBHaW9t
ZXR0aSA8Z2lvbWV0dGlAZW5uZWVubmUuY29tPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMzAs
IDIwMjMgNzoxNSBQTQ0KPiBUbzogTiwgUGFuZGl0aCA8cGFuZGl0aC5uQGludGVsLmNvbT4NCj4g
Q2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNhbmdhbm5hdmFyLCBNYWxsaWthcmp1
bmFwcGENCj4gPG1hbGxpa2FyanVuYXBwYS5zYW5nYW5uYXZhckBpbnRlbC5jb20+OyBELCBMYWtz
aG1pIFNvd2phbnlhDQo+IDxsYWtzaG1pLnNvd2phbnlhLmRAaW50ZWwuY29tPjsgVCBSLCBUaGVq
ZXNoIFJlZGR5DQo+IDx0aGVqZXNoLnJlZGR5LnQuckBpbnRlbC5jb20+OyBIYWxsLCBDaHJpc3Rv
cGhlciBTDQo+IDxjaHJpc3RvcGhlci5zLmhhbGxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTog
UFBTIGZ1bmN0aW9uYWxpdHkgZm9yIEludGVsIFRpbWVkIEkvTw0KPiANCj4gT24gMzAvMDEvMjMg
MTM6NTUsIE4sIFBhbmRpdGggd3JvdGU6DQo+ID4gSGkgUm9kb2xmbyBHaW9tZXR0aSwNCj4gDQo+
IEhlbGxvLg0KPiANCj4gPiBUaGlzIGlzIHJlZ2FyZGluZyBJbnRlbCBUaW1lZCBJL08gZGV2aWNl
IGFzIFBQUy4NCj4gPg0KPiA+IEludGVsIFRpbWVkIEkvTyBpcyBhIHByZWNpc2UgZGV2aWNlICgx
MHMgb2YgbmFub3NlY29uZHMpLCB0aGF0IGNhbiBzZW5kIG91dA0KPiBwdWxzZXMuDQo+ID4gVGhp
cyBpcyBuZWVkZWQgaW4gSW9UIGFuZCBzZXJ2ZXIgYXBwbGljYXRpb25zIHRvIG1lYXN1cmUgb2Zm
c2V0DQo+ID4gYmV0d2VlbiBzeXN0ZW0gY2xvY2tzIG9uIG11bHRpcGxlIGRldmljZXMNCj4gDQo+
IENhbiB5b3UgcGxlYXNlIHByb3ZpZGUgc29tZSBVUkxzIHdoZXJlIHRvIGdldCBmdXJ0aGVyIGlu
Zm8gZnJvbSBhYm91dCB0aGlzDQo+IGRldmljZT8gSSdkIGxpa2UgdG8ga25vdyBob3cgdGhpcyBk
ZXZpY2Ugd29ya3MgYW5kIGl0cyBpbnRlcmZhY2VzIHRvd2FyZHMgdGhlDQo+IENQVS4NCj4gDQpI
ZXJlIGlzIGEgcHJlc2VudGF0aW9uIGxpbmsgZm9yIFRpbWVkIEkvTyBkZXZpY2UgDQpodHRwczov
L2xwYy5ldmVudHMvZXZlbnQvMTYvY29udHJpYnV0aW9ucy8xMzg3L2F0dGFjaG1lbnRzLzEwNTEv
MjAxMC9UaW1lZF9JT19MUEMucGRmDQoNCj4gPiBXZSBhcmUgcGxhbm5pbmcgdG8gaW1wbGVtZW50
IGEgZHJpdmVyLCBmb3IgUFBTIG91dHB1dCBmdW5jdGlvbmFsaXR5IHVzaW5nDQo+IFRpbWVkIEkv
TyBkZXZpY2UuDQo+IA0KPiBHcmVhdCEgOikNCj4gDQo+ID4gCTEuIElzIHRoZXJlIGFueSBzdXBw
b3J0IGZyb20gUFBTIGZyYW1ld29yayB0byBzdGFydC9zdG9wIHB1bHNlDQo+IGdlbmVyYXRpb24u
DQo+ID4gCUlmIHllcywgY2FuIHdlIGdldCB0aGUgUGluIG51bWJlciwgb2Zmc2V0KHN0YXJ0IHRp
bWUpIGZyb20gdXNlciBzcGFjZQ0KPiA/DQo+IA0KPiBOb3BlLCBQUFMgc2lnbmFscyBhcmUgc3Vw
cG9zZWQgdG8gYmUgYWx3YXlzIG9uLiBIb3dldmVyIHlvdSBjYW4gc3RhcnQvc3RvcA0KPiBwdWxz
ZXMgZ2VuZXJhdGlvbiB3aXRoaW4gdGhlIG1haW4gZHJpdmVyIG9mIHlvdXIgZGV2aWNlLg0KPiAN
Ck9LLiBXYW50ZWQgdG8gY2hlY2sgZnJvbSBQUFMgZnJhbWV3b3JrIGlmIGNhbiBwcm92aWRlIGFu
eSB1c2VyIGNvbnRyb2wgZm9yIHN0YXJ0L3N0b3AuDQoNCj4gPiAJMi4gRnVydGhlciwgdGhpcyBk
ZXZpY2UgaGFzIHRoZSBjYXBhYmlsaXR5IHRvIGNhcHR1cmUgdGhlIGlucHV0IGV2ZW50cw0KPiAo
cHVsc2VzLCBuYW5vc2Vjb25kIHByZWNpc2lvbikuDQo+ID4gCVRoZSBzYW1lIFBJTiBjYW4gd29y
ayBpbiBlaXRoZXIgaW5wdXQgb3Igb3V0cHV0IG1vZGUuDQo+ID4gCUNhbiB0aGVyZSBiZSBhbiBQ
UFMgY2xpZW50IGRyaXZlciBzdXBwb3J0aW5nIGJvdGggbW9kZXMgPw0KPiANCj4gSSdtIG5vdCBz
dXJlIHRvIHdlbGwgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLCBob3dldmVyIGEgUFBTIGNsaWVu
dCBpcyBhDQo+IHBpZWNlIG9mIGNvZGUgdGhhdCBjYXB0dXJlcyBQUFMgcHVsc2VzIGFuZCBhZGQg
YSB0aW1lc3RhbXAgdG8gdGhlbSwgd2hpbGUgYQ0KPiBQUFMgZ2VuZXJhdG9yIGlzIGEgcGllY2Ug
b2YgY29kZSB0aGF0IChwcmVjaXNlbHkpIGdlbmVyYXRlcyBhIFBQUyBzb3VyY2UNCj4gYWNjb3Jk
aW5nIHRvIHRoZSBzeXN0ZW0ncyBtYWluIGNsb2NrIChhbmQgbm90IGFjY29yZGluZyB0byBhIHBl
cmlwaGVyYWwncw0KPiBjbG9jaykuIEhvcGUgSSd2ZSBhbnN3ZXJlZCB0byB5b3VyIHF1ZXN0aW9u
cywgaWYgbm90IGZlZWwgZnJlZSB0byBhc2sgbW9yZS4NCj4gDQpJbnRlbCBUaW1lZCBJL08gUElO
IGhhcyBib3RoIGdlbmVyYXRvciBmdW5jdGlvbmFsaXR5IGFuZCBpbnB1dCBjYXBhYmlsaXR5Lg0K
V2FudGVkIHRvIGFzayBpZiBpdOKAmXMgYmV0dGVyIHRvIGhhdmUgdHdvIHNlcGFyYXRlIGRyaXZl
cnMsIG9uZSB1bmRlciBjbGllbnQNCmZvciBpbnB1dCBhbmQgb3RoZXIgYXMgZ2VuZXJhdG9yIGRy
aXZlciBmb3IgUFBTIG91dHB1dC4NCk9SDQpIYXZlIGEgc2luZ2xlIGNsaWVudCBkcml2ZXIgYW5k
IHVzZXIgY2FuIGNob29zZSB0aGUgZnVuY3Rpb25hbGl0eSAoZWl0aGVyDQpQUFMgb3V0cHV0IG9y
IGFzIFBQUyBzb3VyY2UgdG8gY2FwdHVyZSBwdWxzZXMgd2l0aCB0aW1lc3RhbXBzKS4gDQoNCj4g
Q2lhbywNCj4gDQo+IFJvZG9sZm8NCj4gDQo+IC0tDQo+IEdOVS9MaW51eCBTb2x1dGlvbnMgICAg
ICAgICAgICAgICAgICBlLW1haWw6IGdpb21ldHRpQGVubmVlbm5lLmNvbQ0KPiBMaW51eCBEZXZp
Y2UgRHJpdmVyICAgICAgICAgICAgICAgICAgICAgICAgICBnaW9tZXR0aUBsaW51eC5pdA0KPiBF
bWJlZGRlZCBTeXN0ZW1zICAgICAgICAgICAgICAgICAgICAgcGhvbmU6ICArMzkgMzQ5IDI0MzIx
MjcNCj4gVU5JWCBwcm9ncmFtbWluZyAgICAgICAgICAgICAgICAgICAgIHNreXBlOiAgcm9kb2xm
by5naW9tZXR0aQ0KDQo=
