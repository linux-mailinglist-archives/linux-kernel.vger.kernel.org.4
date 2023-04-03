Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC336D4FDC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjDCSBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjDCSBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:01:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394AB1BF7;
        Mon,  3 Apr 2023 11:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680544889; x=1712080889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3Cnq/da5IW43rR706gHhIrbB6NqJfBoscfNi2eh/QKs=;
  b=FRSs9Kg8Vkc2IVWA8ANzmv0ayHxcNt/1pWZ8XeKZhjRktF7NlLN0ZQmu
   c7+IV7Ok8ELK10aJ8eAFThcgYGXXLpc/Jip0NfvoOua6c1JacJj6MU379
   YiYBmorTzn6lE/ezhNmo6ux4Dl1o4rj5JL6EylpWCLx9RdI5hCVQYSYba
   pNZdVkZo1PzGeG3fPr9mOoT9cx06KreCi13XFLhrSO5bm6GOhDqO36YDi
   ZKs7c8YgZ7yisQHdxA6Ha7AfMrs6wVflmesMxSGjZFqo7Dpq+dlQwHPk8
   zNJkfFDy+7UMcAZVmmKMO9tP/TgBduLn3dgkTkRSl2Y7112ULMKVX8pz5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="343670781"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="343670781"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 11:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="718620217"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="718620217"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 03 Apr 2023 11:00:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 11:00:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 11:00:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 11:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2t0s4g+Xu80u7hbuhtKo/sa5vsB/7ImNDreW0S/5fBQOrNpF6IZCvZU+IaV8PEmfs9aUDAdribPi7PkwRklTLra8QyT/LjC9LSfNLsFhIGfOwUKkkbnG8jofBsvbkzQxGqAAIL/+HUdmxid7Bnf5fX0Afj+qWAwWHxDk9fNp9MwPGlfHvgCkefClpIjDp/dyR53PCqmi+ik5T1lCS+Ltmxq07X6S3tpPZHiI5rEt9sooMY0OK5k96LqN3mNkMplJSPTf0s8+VdXz8h1SRyOjbGYKDifuEuBwp/wwsmWrTXL2CC/uLcFa3DZvP6XzfVAYJr9HLGyKh8pvpGFrcCKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Cnq/da5IW43rR706gHhIrbB6NqJfBoscfNi2eh/QKs=;
 b=SJBhw0Q4WezPJfP/mZVCW7uWvyk2+7BdHZYMlrE8GlVvopx69sB+1Xer+nVZoKgyC/PrzaQNufF6wNsuEIfpQNbSkCB0ItXd+rrak7UFGAF3d52ECst5LInaSDP3I0xpEl6kSjUzz4Aj/zXX6dftBq94JRzsSFTJ5jy9rI2eETN14pILtR8rwvMaGDBdCt27NqNMXrxokC2qjYF9a3YObHQRdUGlMRmIj2pmQM0ddmSYTmViz2fe5DfKLUhJ/t/tMZM1vvtzQpxz5Ijah6bIByepZtV21uSmiNRhIZP1kMTrPryDmsHsuef5NrZfijlzvH51goOhc8AXsZkoiONT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8)
 by CY5PR11MB6438.namprd11.prod.outlook.com (2603:10b6:930:35::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Mon, 3 Apr
 2023 18:00:44 +0000
Received: from MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::ed53:4f52:abd:bbe8]) by MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::ed53:4f52:abd:bbe8%7]) with mapi id 15.20.6254.028; Mon, 3 Apr 2023
 18:00:44 +0000
From:   "Box, David E" <david.e.box@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "mario.limonciello@amd.com" <mario.limonciello@amd.com>
CC:     "jstultz@google.com" <jstultz@google.com>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "Jain, Rajat" <rajatja@google.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "svenva@chromium.org" <svenva@chromium.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
Thread-Topic: [PATCH v5 4/4] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
Thread-Index: AQHZY0AoEqCepMK210Wp0vyLIbu+P68VMFAAgAS1moA=
Date:   Mon, 3 Apr 2023 18:00:44 +0000
Message-ID: <59127d2ac2e60d59b5711517eb049eee334a3cdd.camel@intel.com>
References: <20230330194439.14361-1-mario.limonciello@amd.com>
         <20230330194439.14361-5-mario.limonciello@amd.com>
         <CAJZ5v0jabz27wk-g=iZRSnpUCmWimfjSUZO+iuNeRbuzPxW=DA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jabz27wk-g=iZRSnpUCmWimfjSUZO+iuNeRbuzPxW=DA@mail.gmail.com>
Reply-To: "Box, David E" <david.e.box@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4522:EE_|CY5PR11MB6438:EE_
x-ms-office365-filtering-correlation-id: 20764e4f-0c48-44c1-6ddf-08db346d58bd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMmxPjNooG+FjR5+ZNm2iRjLBGmilknYUJyTzP6tNuD+15Q1OANj6X/UVRgFvay1eDNZVkPgdWtXtxEZreNh11RxljD8+4nQChrq3yhXZmsakG9s4ierYN/mMo7CybMNBPCwwWVVSuf576CoSk/jiW9gixeBeA9fa/GCAtCr0H5DfRIfRRWYFnBbxNgIErMRVKIN8lDfzsJGImjtv39nfGwOQgwkWb7SbrulO0dlnaoEN4V+Zk6rEdQO2aWp0eNIfU117lKGEZ5wQDbrOiKZ6xjbvuebT7f+mQ6trgl+U/9hNee2X1WTkMbNj2khz9+fu2JIPRS74r0/GKY/Ur6HdCH/DBuM3iA+kZnX41Wl7i8UjOXDBplXfx+ZBBiWt0LV0JstXOyz+wQXC4TC04gL6p9rVHszHvBYWxzOaEez5+cPDUO4UTElnrSbVY5GBCLxMYFyGk+Oo6Q5Pxxyh9F8ZzpZlwCZElm+gk5NtxNKewHqRb6uhyEqVuxAIOgGdgkqaKp+hih2xQHNw/t+1dejkvivIhQMcjZyEq7OtL67P06QbwKf6TGfU5rsLTcSg46/PfB+dTneUrKJUUNULiwH8SzcF2+xONp/wPnW1Y1IHY0dq2zFiJZ7znSMXZStuhV1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199021)(91956017)(316002)(66556008)(6486002)(66446008)(71200400001)(86362001)(478600001)(8676002)(36756003)(7416002)(38070700005)(82960400001)(83380400001)(5660300002)(76116006)(3450700001)(6512007)(53546011)(110136005)(54906003)(2906002)(26005)(64756008)(41300700001)(8936002)(186003)(6506007)(38100700002)(2616005)(66946007)(122000001)(66476007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVllWkNCM2dBUzZBQ2duTjVGOEIweUhGQzJ3eERMdTVza1VnRTNBSXBNTHoy?=
 =?utf-8?B?ZlFtQ2h3VHRhaUJZTFdsTXd0b1UvckhacVZvcy9TazRDYVVRcUlHWVBZK3p2?=
 =?utf-8?B?bnhhUU5ZS2F1VFZyZDUvK05PN0RDcFo3U1ROdmpXMzJLbnBra21KNjVBazV4?=
 =?utf-8?B?VU13TzQ2eEF5aitzSTlPZUhHVEd6eVRlNWYzTmhZSkRCVTVNQlN3TUlZNWc4?=
 =?utf-8?B?dm9jbVhMOFhiT3k1RDdrcEdGTW16VGd3alI1K0grN3YraHg0Y2U5L01rSmcv?=
 =?utf-8?B?RnZUblc1NWRNNGhscE1ldlh4UDhySkR5cW80OVJ5eGhYODdIZHpvM3dMRjQy?=
 =?utf-8?B?a2x6STlneXBRR0g4WG1GNTJxUzhMdDdhakJOU1NIWTIyTFZtVXFlZE9iejFm?=
 =?utf-8?B?bm9BRUJJODF0MldCNFRDN3JTeTRMUmRvZytWSS9WeXJ4ZHUvL1RlNWcyVjNG?=
 =?utf-8?B?WE16emhweitlUUlFbnJDZFhIaHlwVTIzVStnSEJUWTd0TnQyK3YxbmhMVXgy?=
 =?utf-8?B?Z1Mwc0doNmovaWVVY2k1bG9LelFZM2NreEFpRUpubnBCZEYxNlIvNE0yV2RR?=
 =?utf-8?B?QzVVTzhJcE5SNThJWkZNWHVFbERYaHpRMUtCRFZjb0djT0FzT1dOTWNPMy91?=
 =?utf-8?B?eFVlKy9BN29QZXAvYlpLMC9ObGtaK2p0Tm05YlpmdzBlUVdYZlZKOU9qWTFS?=
 =?utf-8?B?RXl0YVArb241UXpYVmFWOVVBTDF0SDE5YndObCttY3JRVTBmTTVkd1E3cG5r?=
 =?utf-8?B?RXI1VVA3cTIzVCtiOUlYTGZuSWZ5ZGRvZVkvSENDUHR0ZmNpNnhZbHoyV29V?=
 =?utf-8?B?RlVFMVVVYjJKTFdMY0QwbXl0QVI0dGhldmJtbTdJUkh1djlHV1RYMExTZVkv?=
 =?utf-8?B?dUkrOW5lYmFSY3g1TWUwc3k1ZWJvbVQ5NXNBWGFUSExLc2RmNW5wVGJvS0RF?=
 =?utf-8?B?d0hubDhCUUxLRXdaRzAzRHhKaVo1M0tBSmV6WUFkTzA4bkErb1o0WWpUWnAz?=
 =?utf-8?B?NStYNGJvb3JGZzNQaitHSElHMElPOTNnTXlHWTJTWVlVWTdKWFJMVm1TVEF4?=
 =?utf-8?B?SzB4TEhJL0Fkd1NhYlZ2a0hjK3M2VDMxVE92ZXBDbVAwdm92VmlXNmFTbWNx?=
 =?utf-8?B?YkRldUhTQ3JPUE05SHI5YzZkVjh1aFdSMzNCWEdIWFo1TEF6a0kvSWV6azhS?=
 =?utf-8?B?RWlWdXA0dnBlVS9KSEZZVlRSb2NuVjM5WGw3d3d1SzlFT3RQYm9GNjdiWFd1?=
 =?utf-8?B?dkNxRTRsNG5HbmcvcS9URnYwZUR4TE94NituejlDRitvc2F6TUo0WkhOVE9Y?=
 =?utf-8?B?YW01ckVuWkk5MEpEUHRvK0R4dTV6SWp3S1RORXlRdTVPS0R2aitwbHNQMG13?=
 =?utf-8?B?eWxYOW15Z0NqUmpnVmplOWVRT3U3M2VNR1JxeXRGK1ByKzdoQWZkTE50Y2xh?=
 =?utf-8?B?Sm55K0lpaEhIZW1Ia0pHOEdncU9HVEpLbFgwbi9TbnpjTkhPZWQ3UmxBUHcy?=
 =?utf-8?B?UGx2dUVNYXdkMWVHa3hQTGZNeTNIUTByS3I3dG5oNFJFMWdKQjlkSUFuZVNZ?=
 =?utf-8?B?dUZVVHFKMmdtR0ZiUG4rSXRWR1lqM3N3a0tQMjArUXdTZkpEZ0k0UTVzNW5X?=
 =?utf-8?B?WXhwdm1vcmFkR3JQWFd4NjY1YWZacHBHQnhmZFdCSVdYazRVTm40QnFRL3BB?=
 =?utf-8?B?SmJPT0JqdkgwaFNVeXV3ZzhiZWtwQ0g0NXBYcUFDT2dON0t2TDU1VTg0SEhO?=
 =?utf-8?B?dm5iUUVGai9Vc2xzYWlZV25ycjJ5UlVGU2V4SGxmcms4VzZlVXMwWnp2ZERj?=
 =?utf-8?B?TWhMYjVTNGQ1V1FIUVNFNzBPakRjV1BLYzJrY1gyRHNpclN6VUloNHdYbDVJ?=
 =?utf-8?B?U0VVUXMzVUxDejlYOEpWQnYvWWJ6WDA1RGtUcmtSRWxjemM5WGViR0pSK0xR?=
 =?utf-8?B?NXozZUYrMUp3K2lPSnFwR0x2VkErVk1CTDdDVjBKTGxZUFZ6cDBINVBrcFZy?=
 =?utf-8?B?YktTWXZrZGRBOGpNbnZlOEF5WUZNRFRDTUMzdkhUcnlFaU85bVZDMkxaSlJP?=
 =?utf-8?B?dWQ0VjB5c0pSaTdZQU5CZzRMSGRxK0owd1NZTEZDNmJ4QlJnMnRoMWpHT1Fa?=
 =?utf-8?B?TFRGK3VWSHd2a0ZIMWsxWFpQV08yS0YwWGU5QUUweGpNMkhTUHNRUUx0OG1C?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <055C0BA0C701354CB1E6EF0C581C5470@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20764e4f-0c48-44c1-6ddf-08db346d58bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 18:00:44.7641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5E/foeMl0drUuFRKrNPOdvnS0OVtJpapZ7lzqF5QPxlkL+OjbU8UJJNp5bYUtvPOIs4L97I6h1X4+6yiPmh9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6438
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTMxIGF0IDIwOjA1ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1LCBNYXIgMzAsIDIwMjMgYXQgOTo0NeKAr1BNIE1hcmlvIExpbW9uY2llbGxv
DQo+IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gPiANCj4gPiBpbnRlbF9w
bWNfY29yZSBkaXNwbGF5cyBhIHdhcm5pbmcgd2hlbiB0aGUgbW9kdWxlIHBhcmFtZXRlcg0KPiA+
IGB3YXJuX29uX3MwaXhfZmFpbHVyZXNgIGlzIHNldCBhbmQgYSBzdXNwZW5kIGRpZG4ndCBnZXQg
dG8gYSBIVyBzbGVlcA0KPiA+IHN0YXRlLg0KPiA+IA0KPiA+IFJlcG9ydCB0aGlzIHRvIHRoZSBz
dGFuZGFyZCBrZXJuZWwgcmVwb3J0aW5nIGluZnJhc3RydWN0dXJlIHNvIHRoYXQNCj4gPiB1c2Vy
c3BhY2Ugc29mdHdhcmUgY2FuIHF1ZXJ5IGFmdGVyIHRoZSBzdXNwZW5kIGN5Y2xlIGlzIGRvbmUu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9u
Y2llbGxvQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gdjQtPnY1Og0KPiA+IMKgKiBSZXdvcmQgY29t
bWl0IG1lc3NhZ2UNCj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3Bt
Yy9jb3JlLmMgfCAyICsrDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3Jl
LmMNCj4gPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmMNCj4gPiBpbmRl
eCBlMmYxNzFmYWMwOTQuLjk4MGFmMzJkZDQ4YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Bs
YXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94
ODYvaW50ZWwvcG1jL2NvcmUuYw0KPiA+IEBAIC0xMjAzLDYgKzEyMDMsOCBAQCBzdGF0aWMgaW5s
aW5lIGJvb2wgcG1jX2NvcmVfaXNfczBpeF9mYWlsZWQoc3RydWN0DQo+ID4gcG1jX2RldiAqcG1j
ZGV2KQ0KPiA+IMKgwqDCoMKgwqDCoMKgIGlmIChwbWNfY29yZV9kZXZfc3RhdGVfZ2V0KHBtY2Rl
diwgJnMwaXhfY291bnRlcikpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiBmYWxzZTsNCj4gPiANCj4gPiArwqDCoMKgwqDCoMKgIHBtX3NldF9od19zbGVlcF90aW1l
KHMwaXhfY291bnRlciAtIHBtY2Rldi0+czBpeF9jb3VudGVyKTsNCj4gPiArDQo+IA0KPiBNYXli
ZSBjaGVjayBpZiB0aGlzIGlzIHJlYWxseSBhY2N1bXVsYXRpbmc/wqAgSW4gY2FzZSBvZiBhIGNv
dW50ZXINCj4gb3ZlcmZsb3csIGZvciBpbnN0YW5jZT8NCg0KT3ZlcmZsb3cgaXMgbGlrZWx5IG9u
IHNvbWUgc3lzdGVtcy4gVGhlIGNvdW50ZXIgaXMgb25seSAzMi1iaXQgYW5kIGF0IG91cg0Kc21h
bGxlc3QgZ3JhbnVsYXJpdHkgb2YgMzAuNXVzIHBlciB0aWNrIGl0IGNvdWxkIG92ZXJmbG93IGFm
dGVyIGEgZGF5IGFuZCBhIGhhbGYNCm9mIHMwaXggdGltZSwgdGhvdWdoIG1vc3Qgb2Ygb3VyIHN5
c3RlbXMgaGF2ZSBhIGhpZ2hlciBncmFudWxhcml0eSB0aGF0IHB1dHMNCnRoZW0gYXJvdW5kIDYg
ZGF5cy4NCg0KVGhpcyBicmluZ3MgdXAgYW4gaXNzdWUgdGhhdCB0aGUgYXR0cmlidXRlIGNhbm5v
dCBiZSB0cnVzdGVkIGlmIHRoZSBzeXN0ZW0gaXMNCnN1c3BlbmRlZCBmb3IgbG9uZ2VyIHRoYW4g
dGhlIG1heGltdW0gaGFyZHdhcmUgY291bnRlciB0aW1lLiBTaG91bGQgYmUgbm90ZWQgaW4NCnRo
ZSBEb2N1bWVudGF0aW9uLg0KDQpEYXZpZA0KDQo+IA0KPiA+IMKgwqDCoMKgwqDCoMKgIGlmIChz
MGl4X2NvdW50ZXIgPT0gcG1jZGV2LT5zMGl4X2NvdW50ZXIpDQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOw0KPiA+IA0KPiA+IC0tDQoNCg==
