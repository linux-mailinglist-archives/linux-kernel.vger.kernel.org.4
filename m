Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1193573475A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjFRRnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 13:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFRRnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 13:43:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795B8E64;
        Sun, 18 Jun 2023 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687110197; x=1718646197;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dhmTL0Gpn2HI+EH73dITjGly/oxutnQRgyJBPPpHVB8=;
  b=IrglBjvHCnjD0tYRhyMbctfGpLvJUHE9j6fJLtJ9oHqjk58mzX39kypt
   SKC1DvFrWQCdsm36ApGDXGK2lb1OQz61caNW/tdlq9jRwWzvj5VsX/PIX
   KODu2UTgteKO1wKuAjpmo5op8l5qUhby1mF5alS1/1suOqNd6zY1+/mjh
   GRtDrIaJABkZPLaKJVEE+RsRDQaIr8Ngau2+NpOOLLRs+HgiRGKzZcsPN
   XRsJoj1TJHeSyNAGh2NTlCjBA3AJ6hm5hPWN9xrTrScc+gybfKRKE/QOy
   Lu4qPG+AD0q3vaYkr3glX9cqT++y4oiBsSibNHSOZlQofnn4Ukmw7ZMZS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="349215127"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="349215127"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 10:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="778758394"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="778758394"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2023 10:43:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 18 Jun 2023 10:43:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 18 Jun 2023 10:43:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 18 Jun 2023 10:43:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPlyAtyT41U1byz+MunDBThCohlVoENXseNUjFVmNzXN/xrSoPMG7T24pA10T7MZ3wFmzevJDMCDZl/30svWwTFS0cZ3LEpg04vkTDd9QObdyfdN4WWX7FK2+379emTeb2EyEE5vfNnwwB9bDg+UqjlzEQsQPMjsICephjrNBjdSo+w/o4K7G4fU+HteAF1030WZ4Jb15ocyCHpIXCn37IlbKOs+wl3GrJGzNQGyYJd+PB6g1xWkn/M3yWe+RfHQKyULidtmHHxWMdHVwp7ZAHGZQzXiO4EOtk5UDc4WP4zzR9UQQRLxQE4WHTI+ry4dqPEAWnMlLhL3FJodZ2b3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhmTL0Gpn2HI+EH73dITjGly/oxutnQRgyJBPPpHVB8=;
 b=YNc+PuigC0k4qXUtiQcagCbx6Esy8CM+sCMdjH0ur8MXvnA+rb5anescs69QbqK2Vm8XQNU+RlEP3XVhTpTXsG23dZWDD0t7WxHIdgK/oUlyes/Tg4nxsvj1JelxhoQxUFMQTXmTE+R5lFsEuKNB3h6yOFi2x4bXu3WgVQDDjajZnZ2xaN0txZcy0+aZlg5QPW0ehOCdXIRSw633lML6drjZvTC970v8J/cxnejm/xTo3QFMWDW1QSmrhsjMswz9v7WwHTcarvSSSogKTWV+KPHymJJ4T3/BGakezzSrZiAJhg5715/cZArBp14vjImAsSrDpl8Q24zSJtz/ACnMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by DS0PR11MB6518.namprd11.prod.outlook.com (2603:10b6:8:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.41; Sun, 18 Jun
 2023 17:43:12 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::fa38:74b:6e9b:744e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::fa38:74b:6e9b:744e%4]) with mapi id 15.20.6500.036; Sun, 18 Jun 2023
 17:43:12 +0000
From:   "Wang, Weilin" <weilin.wang@intel.com>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
CC:     Kan Liang <kan.liang@linux.intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/3] perf test: Add metric value validation test
Thread-Topic: [PATCH v3 1/3] perf test: Add metric value validation test
Thread-Index: AQHZnwBBh3GJHpkR5E6ouxfcPkrxlq+NAxMAgAPTvDA=
Date:   Sun, 18 Jun 2023 17:43:12 +0000
Message-ID: <CO6PR11MB56353207BBD7BDA6C530EBDEEE5EA@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <CAP-5=fVixzBLLiWnim8x6qcDOKH7uVfEWojTCP_H531Fhy7j-g@mail.gmail.com>
 <20230614203824.2895333-1-weilin.wang@intel.com>
 <20230614203824.2895333-2-weilin.wang@intel.com>
 <bc18bc42-3df8-30c9-10ff-8a4ba3d3d9f6@amd.com>
In-Reply-To: <bc18bc42-3df8-30c9-10ff-8a4ba3d3d9f6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|DS0PR11MB6518:EE_
x-ms-office365-filtering-correlation-id: e896dfd3-e63c-4335-95bb-08db70237cf6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cokl749+biRqjkG0XyiCrP7o8gI6WPaAuW3wMw27JPyDgyW8XXPaEdPlhuJNgH37WnkcvYwO8a8GMmILoileOROosPhInvs2vqHxYCGlvpFxa4xRpb0jv7eQ1KW3+xp2NtjCe++4lal36B97eZM4wlsHpKGu5iJkZx5VU7Nx5g4ZC54DF92HT4bdACMkymBpDr2c2iUpHaDtb2D5oRq4s5vxFE0n1upW2VTNhsA9+hZU1jFW6Ofc1ImCkQFeVLyblxHSFk8qQcDOrrm+lNcDRu5BR8EGry7i2zySHZa+08KE+UVaepLR9PcsuUC8+1F9g+YmiSKu8fIAR8iUNTMcW3flMsZzo2PczLO67iDzTgMmdFHzT7u9lHQ14Id2JvWi/uDMeTAo4h1h/LUEJlqQPqPsqrDSGu1BNDlRIT0e+Gzp9WWnqE24dief+WtETvmDmvdnDnb+8K8eE9pzim3T9y1jXQEr0mYX2zTcVHoLKjO1WTL1XWUuk9Lh4YC4nX53gn69sR2FzvZOOVmP4vwi+gFztlCMioQDt7mkRIC41c6hqnE/gkw8xXYckhOJsc974JnJ43e0Ide1gywHxWWQe0BXks4aMgQ4eaN9x0yTJToxXPOcMUqgj2GEO55b2cve
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(52536014)(5660300002)(8676002)(86362001)(82960400001)(54906003)(7416002)(8936002)(38100700002)(83380400001)(122000001)(316002)(38070700005)(41300700001)(66476007)(66446008)(66556008)(64756008)(6916009)(76116006)(4326008)(66946007)(33656002)(478600001)(186003)(53546011)(9686003)(6506007)(26005)(7696005)(55016003)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tkt3Y1MzZUZZb3RjK3FLNUx1UFRab1ptM2g4OWJEQ3RKV3Q1TFp2L0xJS2tk?=
 =?utf-8?B?aXZnMk9vYzg2ZGlWSzRUYWdHalExcnozWmhPajhNVGxFQm1XQWxvQlZKY3Jp?=
 =?utf-8?B?RlhNL3lsUWtmaVQ1QlA2UVdtcXI0d3FiSGJ0KzZtVnBNcHRIZlU0NHlJa3gx?=
 =?utf-8?B?YjNzbTBrMjF3TEpOVGk0VnhoNXFnRGFjMHNxR1dMdXdmM2RTSnREa0ZXL0Fx?=
 =?utf-8?B?VUwwSEtrZjZtZDZGL1BTZ0dweWptWkRlbmI2Wi9qTkg0SStuWUtBV0pjMVpw?=
 =?utf-8?B?NVI3OWJ1S3pWUENWMFl0NXl4RDduMkhaU1BRcFFYTnlYVFFuODFvcTZTVEk5?=
 =?utf-8?B?YmhIWmJoUktMTDZvOWJrSjlBaWhMTE1semp5a0lCTGVzZGd3YTRldUZmWTdW?=
 =?utf-8?B?Mjh2Qkx1VUR0ZHBvWmg2bVJzbmhuWjdGV2ZZa0E1V1JmaE1XZlpRSmJTSldt?=
 =?utf-8?B?TnpZcitPcW91ektxei92eXJpTUhpZWNuU1d0VS8reC9jc2hTeC8wVFI2cTlk?=
 =?utf-8?B?cVV6cER1eHJKbkw5cEI0aFhOQWtpaHNzbUtwcHcwMjM5SENieGVNc29VbUNy?=
 =?utf-8?B?ZnJoWWllL2xFalVjbERtVGt2bmxiNUdoOWUveHF5aWlMeWlaNDVLVWpkNGFP?=
 =?utf-8?B?emQwZWYyTnBFK2hLOU0xQUthc2NYNFNTOTlBVjl4RnRpVEJIb25jYmYzV0Z2?=
 =?utf-8?B?UGc2MFFFS05MZ3pBV1pIbkMzYWhXUmlndktHS1ZRMjU3bC9idEEvWWhJMXp2?=
 =?utf-8?B?bStJWk5FUWVVcWNrREhxMVAwVXJ1Y2dJeis5YnRkRzdNT0FZVFkzN2dYMi9W?=
 =?utf-8?B?WHdZUitnYmhaNUhsV2sxa0RycXh6STFaSitvTVUwR1BGSTJjWjFoQlFwdkJq?=
 =?utf-8?B?cFpRM2ZPZ0FZZU9NeWFpN25FMGpzSzdmUnJLSEJ2ZjlHRVpxc1RLa1NhV1ZM?=
 =?utf-8?B?eWt4OHpicXlaS2ZnR2xZdmJCeG5LODU5WmVMOXlTNUhMTTFaZkQ0eFA5akR5?=
 =?utf-8?B?LzhyS3g0SVp5SHZhdmZYT0FlSTlPdEZzb2tJT1ZqZ2ZHTHNuOURaelN4Nnl1?=
 =?utf-8?B?WXVEcUVkNjZ0V1BqempYYzJqQW90MG1RT2VScU4zck1kK1psWW1ud1BiQlBv?=
 =?utf-8?B?a1FkVjFRZkZvR3hYaktvV0RGQ01hc01lazBqL1hIeVJranZXWjRTWXd2cVg5?=
 =?utf-8?B?bHB4cTNZcTYzNnNqaEtNQzNDU1hYQ0tGYk40dkpadk5iODNPdFZyL2NLaUFF?=
 =?utf-8?B?dHRyM1ViREF1QlF1QU5rL1VXbC9OLzhHZlAvSDRQVGZCYmFmcHVTNUFSNzd1?=
 =?utf-8?B?b2EwTkNteHlTd1VTWlNaQUFPVXhCOGxqOG9HSFJ3dzViQnpQeWRQVzllQ3ht?=
 =?utf-8?B?eTVPbUhHVW1hM3dERGJpUjJCcC9BbFA3MFRtTDVRQWlrRWlCZXNsanIza3dR?=
 =?utf-8?B?bnJ6M1ZZN0NNbGVBV3dTb2kxWTE3RG9tdHJpK1B3TmdNbVVjcU04Q0JzS2g0?=
 =?utf-8?B?aWYrYStxcUFpb3N3VSsyUldKL0hZdk5GOTQvUWZDZkhGakVCa1VCZnU0RWdo?=
 =?utf-8?B?QzZTUDdzQUVJcm5xYzhHRUxiWEgxTGZMZmxYK0h2M2l6WjIxVVVnZDRzVC9R?=
 =?utf-8?B?MWdORFp5VWNZYTFjakxXckpIZzBvNU1MRXJod05PVDJSamVYOG0zYS83WXRQ?=
 =?utf-8?B?TmY2bGxCSU4weGVoUzBrN3NYQlNFVW9ma2Z4cU1mc2VodnNoWW13anBaZ2Ro?=
 =?utf-8?B?RUFxYWNzRURiNVBQNnlaWGxLcE9xWkxIbk5iRitnYmo5b01ZY3lMR0N2Z1B3?=
 =?utf-8?B?SUt0R2ZCc1R0djV2ZTkzNE0yVUtnNWdxRWdmdEV6dzJZMmhsMGZzUlYrRkRm?=
 =?utf-8?B?K01lOUhEeXhkQnhkZGJHTzBRdHJLMGwvZFV6bjlRdVJPVVZTQ3IrMWVRSnht?=
 =?utf-8?B?QldpeThncVNFN1FaYjN2RTlFWEJoSjBFUXhNbjF3QXFiTWNoaEl5bjA2KzV2?=
 =?utf-8?B?SXJmRFpMZkNiTzcrWHBJVCs3bDRzVjNJaXkzcVNtVmZTU0lYdzU2WkIzcU0w?=
 =?utf-8?B?M1lqMUlsMC81S3ByUGVEeDREdkY2WE5RRFZwdUdEaStVOVFQUlhGRFdPUEZk?=
 =?utf-8?Q?rq2ton/OcDmSTCOAoc4oJeHGF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e896dfd3-e63c-4335-95bb-08db70237cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2023 17:43:12.5691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iEZypDPYST1O5UMaNG1xbqg4JJ9V+Ngm3OYdDC0o/UxAljCicyNR9gexSX3ba1e6eyXDVPbPA6nq61SO/If0yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6518
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmF2aSBCYW5nb3JpYSA8
cmF2aS5iYW5nb3JpYUBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEp1bmUgMTYsIDIwMjMgMTI6
MDMgQU0NCj4gVG86IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiBDYzog
S2FuIExpYW5nIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRoYQ0KPiA8
c2FtYW50aGEuYWx0QGludGVsLmNvbT47IFRheWxvciwgUGVycnkgPHBlcnJ5LnRheWxvckBpbnRl
bC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRlbC5jb20+OyBQZXRl
ciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdvDQo+IE1vbG5hciA8bWluZ29A
cmVkaGF0LmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyA8YWNtZUBrZXJuZWwub3JnPjsN
Cj4gSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPjsgTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0Br
ZXJuZWwub3JnPjsgSHVudGVyLA0KPiBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsg
SWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPjsgbGludXgtDQo+IHBlcmYtdXNlcnNAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBSYXZpIEJhbmdvcmlh
DQo+IDxyYXZpLmJhbmdvcmlhQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8z
XSBwZXJmIHRlc3Q6IEFkZCBtZXRyaWMgdmFsdWUgdmFsaWRhdGlvbiB0ZXN0DQo+IA0KPiBIaSwN
Cj4gDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvc3RhdF9tZXRyaWNz
X3ZhbHVlcy5zaA0KPiBiL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvc3RhdF9tZXRyaWNzX3ZhbHVl
cy5zaA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi42
NWExNWM2NWVlYTcNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvdG9vbHMvcGVyZi90ZXN0
cy9zaGVsbC9zdGF0X21ldHJpY3NfdmFsdWVzLnNoDQo+ID4gQEAgLTAsMCArMSwzMCBAQA0KPiA+
ICsjIS9iaW4vYmFzaA0KPiA+ICsjIHBlcmYgbWV0cmljcyB2YWx1ZSB2YWxpZGF0aW9uDQo+ID4g
KyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiAraWYgWyAieCRQWVRIT04i
ID09ICJ4IiBdDQo+ID4gK3RoZW4NCj4gPiArCWlmIHdoaWNoIHB5dGhvbjMgPiAvZGV2L251bGwN
Cj4gPiArCXRoZW4NCj4gPiArCQlQWVRIT049cHl0aG9uMw0KPiA+ICsJZWxzZQ0KPiA+ICsJCWVj
aG8gU2tpcHBpbmcgdGVzdCwgcHl0aG9uMyBub3QgZGV0ZWN0ZWQgcGxlYXNlIHNldA0KPiBlbnZp
cm9ubWVudCB2YXJpYWJsZSBQWVRIT04uDQo+ID4gKwkJZXhpdCAyDQo+ID4gKwlmaQ0KPiA+ICtm
aQ0KPiA+ICsNCj4gPiArZ3JlcCAtcSBJbnRlbCAvcHJvYy9jcHVpbmZvIHx8IChlY2hvIFNraXBw
aW5nIG5vbi1JbnRlbDsgZXhpdCAyKQ0KPiANCj4gVGhpcyBjaGVjayBkb2Vzbid0IHNlZW0gdG8g
YmUgd29ya2luZy4gT24gbXkgWmVuMyBBTUQgbWFjaGluZToNCg0KVGhhbmtzIGZvciByZXBvcnRp
bmcgdGhpcyEgSSd2ZSB1cGRhdGUgdGhpcyBzZWFyY2ggdG8gIkdlbnVpbmVJbnRlbCIgaW4gdjQg
dG8gaGVscCBzb2x2ZSB0aGlzIGlzc3VlLiANClBsZWFzZSBjaGVjayBpdCBvdXQuIA0KDQo+IA0K
PiAgICQgc3VkbyAuL3BlcmYgdGVzdCAtdnZ2IDEwNQ0KPiAgIDEwNTogcGVyZiBtZXRyaWNzIHZh
bHVlIHZhbGlkYXRpb24gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDoNCj4gICAt
LS0gc3RhcnQgLS0tDQo+ICAgdGVzdCBjaGlsZCBmb3JrZWQsIHBpZCA1MTgwMzUNCj4gICBTa2lw
cGluZyBub24tSW50ZWwNCj4gICBMYXVuY2ggcHl0aG9uIHZhbGlkYXRpb24gc2NyaXB0IC4vdGVz
dHMvc2hlbGwvbGliL3BlcmZfbWV0cmljX3ZhbGlkYXRpb24ucHkNCj4gICBPdXRwdXQgd2lsbCBi
ZSBzdG9yZWQgaW46IC90bXAvX19wZXJmX3Rlc3QucHJvZ3JhbS50blBvVw0KPiAgIFN0YXJ0aW5n
IHBlcmYgY29sbGVjdGlvbg0KPiAgIC4uLg0KPiANCj4gSW50ZXJlc3RpbmdseSwgaXQgcGFzc2Vz
IDopDQo+IA0KPiAgIC4uLg0KPiAgIFRlc3QgdmFsaWRhdGlvbiBmaW5pc2hlZC4gRmluYWwgcmVw
b3J0Og0KPiAgIFsNCj4gICAgICAgew0KPiAgICAgICAgICAgIldvcmtsb2FkIjogInBlcmYgYmVu
Y2ggZnV0ZXggaGFzaCAtciAyIC1zIiwNCj4gICAgICAgICAgICJSZXBvcnQiOiB7DQo+ICAgICAg
ICAgICAgICAgIk1ldHJpYyBWYWxpZGF0aW9uIFN0YXRpc3RpY3MiOiB7DQo+ICAgICAgICAgICAg
ICAgICAgICJUb3RhbCBSdWxlIENvdW50IjogMiwNCj4gICAgICAgICAgICAgICAgICAgIlBhc3Nl
ZCBSdWxlIENvdW50IjogMg0KPiAgICAgICAgICAgICAgIH0sDQo+ICAgICAgICAgICAgICAgIlRl
c3RzIGluIENhdGVnb3J5Ijogew0KPiAgICAgICAgICAgICAgICAgICAiUG9zaXRpdmVWYWx1ZVRl
c3QiOiB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAiVG90YWwgVGVzdHMiOiAxMiwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICJQYXNzZWQgVGVzdHMiOiAxMiwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICJGYWlsZWQgVGVzdHMiOiBbXQ0KPiAgICAgICAgICAgICAgICAgICB9LA0KPiAgICAg
ICAgICAgICAgICAgICAiUmVsYXRpb25zaGlwVGVzdCI6IHsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICJUb3RhbCBUZXN0cyI6IDAsDQo+ICAgICAgICAgICAgICAgICAgICAgICAiUGFzc2VkIFRl
c3RzIjogMCwNCj4gICAgICAgICAgICAgICAgICAgICAgICJGYWlsZWQgVGVzdHMiOiBbXQ0KPiAg
ICAgICAgICAgICAgICAgICB9LA0KPiAgICAgICAgICAgICAgICAgICAiU2luZ2xlTWV0cmljVGVz
dCI6IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICJUb3RhbCBUZXN0cyI6IDIsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAiUGFzc2VkIFRlc3RzIjogMiwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICJGYWlsZWQgVGVzdHMiOiBbXQ0KPiAgICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAg
ICAgICAgfSwNCj4gICAgICAgICAgICAgICAiRXJyb3JzIjogW10NCj4gICAgICAgICAgIH0NCj4g
ICAgICAgfQ0KPiAgIF0NCj4gICB0ZXN0IGNoaWxkIGZpbmlzaGVkIHdpdGggMA0KPiAgIC0tLS0g
ZW5kIC0tLS0NCj4gICBwZXJmIG1ldHJpY3MgdmFsdWUgdmFsaWRhdGlvbjogT2sNCj4gDQo+IEkg
aGF2ZW4ndCB5ZXQgaW52ZXN0aWdhdGVkIHdoZXRoZXIgaXQncyBnZW51aW5lIG9yIGZhbHNlIHBv
c2l0aXZlLg0KPiANCkJhc2Ugb24gdGhpcyBmaW5hbCByZXBvcnQsIGl0IHZhbGlkYXRlZCBzb21l
IGJhc2ljIHJ1bGVzIGxpa2UgdGhlIDEyIG1ldHJpY3MgZm9yIHBvc2l0aXZlIHZhbHVlIHRlc3Qg
YW5kIDIgbWV0cmljcyBmb3Igc2luZ2xlIG1ldHJpYyB2YWx1ZSBjaGVja3MuIA0KVGhlIHRlc3Qg
c2NyaXB0IGdyYWJzIG1ldHJpY3Mgc3VwcG9ydGVkIG9uIHRoZSBwbGF0Zm9ybSBhbmQgZ2VuZXJh
dGVzIHZhbGlkYXRpb24gcnVsZXMgdGhhdCBvbmx5IGluY2x1ZGUgbWV0cmljcyBpbiB0aGUgc3Vw
cG9ydGVkIGxpc3QuIA0KVGhlcmVmb3JlLCBpdCBpcyBub3Qgc3VycHJpc2luZyB0aGF0IHRoZSBj
aGVjayBwYXNzZXMgb24geW91ciBzeXN0ZW0uIA0KDQpUaGFua3MsDQpXZWlsaW4NCg0KPiBUaGFu
a3MsDQo+IFJhdmkNCg==
