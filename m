Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594616C7665
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjCXDxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXDxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:53:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82C9166CB;
        Thu, 23 Mar 2023 20:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679629999; x=1711165999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o8ftdCdQeIlkE21kEiIPrqPD6L8PMLWqUWJs1rIS0QY=;
  b=XcFdmeDMtJs0UY1HrEyt+tWwMJAwXtHN/pZlBKFwhpwByxEOwsHo+ksx
   FnOMk3nqKGemU1axNIKglcE6aIsJScMh4iPpNbfSgaq4C80lnC/8kLe7V
   vHj7kcos/CKHU2QBwCKKBGHF6VpmzL4n5JoFW3EvtzZzoGbzBF0RzMOkH
   VY8lWI9YJ8DscTpR09NRySkHXulZp9n49CYCu05ky3kn1Yg7nYZRc4ibg
   Y7f/DLHSE2SJbx3KJIaXAd3lk+oVczAmeg1+qclc0KZ/Wb/10HGl/mb2+
   AVwHdFstR/go/dec1MfaOnv1JdGdKHcZVEiKAN3bve0JKZcXbOS0P26Ni
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="341253051"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="341253051"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 20:53:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="1012095625"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="1012095625"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 23 Mar 2023 20:53:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 20:53:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 20:53:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 20:53:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPszNDI4I5iNMSmJRslHJszTEke3yWwvS6M5TbB7fwtGk1geeFYETHa13PKFbnJwSrr10whwCSw36SRdL9wULkf0zkrhCvS5SYogWoJjYqsNQ2g0y/8C0Emnulk0aYqU0YHwpqbaG4zJA/e4m0V7BfbbvQvGsxBGOaeXRMcOFHwlvhay10CQKEaAqAymED99MHtcrTzYRnjS0jnwAgSUi9HkWr7AEOHZAjp8pnxKlIHwEUskygVEcwbjqRlEZIpBZSKWwJASfVjTy2LBiXBr3oCEUMKkLObNhVwhA2dep2QndtJjFZHBHq3lOJPLy2yMGhA94ujwKti9b3kepXhADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8ftdCdQeIlkE21kEiIPrqPD6L8PMLWqUWJs1rIS0QY=;
 b=VzhYLWv1CAJ3EweSJj6eVsvxLT4tTo3y4h2JoNbrhSCBxYE4qNKXsAD32GpR7zec3Bl3Q+Vm7xE2xu3FxZ9AHCaTFkjUL6Pv6Ne3NAtczZAPjxy4VPKJhLuNNwp5qm0f6rMAhW747Kfjrvfv2+xJPgVeIANjRF/J7WDjEKED+bAje7PCjLVGLi1QrRPBWA1IJLxBAiUu3eyGO8dtrDIS/rKsKSRDo3lkOH/X5E+JxaPAChcOUtKL8Ph6Sphc5sF+3h72UYZqtIjpbXyBp9+j9HPaT7sJL5ZHeBSPZNz7MyfmnQthI2Zq/QXQTjL4PgNjVCpQIppp4rcvE4vfFhbnsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA3PR11MB7534.namprd11.prod.outlook.com (2603:10b6:806:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 03:53:08 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 03:53:08 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>
Subject: RE: [PATCH v2] srcu: Fix flush srcu structure's->sup work warning in
 cleanup_srcu_struct()
Thread-Topic: [PATCH v2] srcu: Fix flush srcu structure's->sup work warning in
 cleanup_srcu_struct()
Thread-Index: AQHZXYxAg4SDOY9oU0i85jFtcpQGKq8IoP4AgACPfdCAABajgIAABZ2Q
Date:   Fri, 24 Mar 2023 03:53:08 +0000
Message-ID: <PH0PR11MB5880B77049F2BEBD40E41DABDA849@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230323134621.336832-1-qiang1.zhang@intel.com>
 <f18cad71-38f0-411d-9dc7-bda52d1d5a3a@paulmck-laptop>
 <PH0PR11MB58803F01B73914E1D7A052F5DA849@PH0PR11MB5880.namprd11.prod.outlook.com>
 <baf071c3-142c-4886-aea5-6b6ef2ff3ade@paulmck-laptop>
In-Reply-To: <baf071c3-142c-4886-aea5-6b6ef2ff3ade@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA3PR11MB7534:EE_
x-ms-office365-filtering-correlation-id: cdd136c6-b06d-4dc6-2373-08db2c1b47a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aaiFqH43xloGsgNGkNwnTYcp2mJFOn+FfArJoEAll9mw9GnUnXCxY3p4QZYyHuosr9GRk9ct4TMdygRg/UjdGWtclqblGa1Zlcic5rzYCLy0Cl1jo9OiDuAcKZ7d1Nw5MqN8RA1eodIJl53hs4gN06eiCOs0wNA/9A2uu+WJ3ikrthWUvpRoPDeU7UTxZfYq+L0hSCAQKHsw99DpOYJdGc1Q85MT1fmhniSuuXm6rJ/oOwPOEjt7zby4qpB7+ZccYLiEq+NEjWpeszZzbBN3naBerc6bahqJYEJSqe1aVJrcaBaJmQY+vgL4a+YUqvEWGWjhNgA6Zmre6UgX7yl6hiT4vODJufKzW7WNEtfCSFTMN9/z6RH9/cLJfAXh1cvf2LXcUtm/yqgecLfdswgUWlbjCP5MWYaLPoXXaEurvCIrug50RX/WxnPA9C1b+IK57EFedaSsNVQ12AWDz3zSDhXmO4eGDOCCgjqvupmxP1HrRCwUuWRkojWbbLcbc2PJA/HXEmaWI3ST0sys5ejLcw8vrJoTJ0zizvovXib+mUBg/nVBh1domPtNjE5igSUuSA3gtlSOax11HlHMbXFr6bsM2HXSZqRhsOCsYA7PX7bdO9CJVbL6DHXucW7/8DGTBjkeIhBtBQUF+OCDlbx2lU2rOtfSPBi3eq/DpAMkYTtpyYLF4rLn9UOy2S7vFGFxTrxqNYU/lggNnQhRu+a7xQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199018)(82960400001)(38100700002)(122000001)(76116006)(66476007)(66556008)(66946007)(64756008)(66446008)(316002)(54906003)(7696005)(478600001)(55016003)(45080400002)(38070700005)(71200400001)(86362001)(83380400001)(6506007)(26005)(9686003)(186003)(33656002)(8676002)(2906002)(5660300002)(8936002)(41300700001)(6916009)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0dTRXRjTDVFUWpyZnZPZDVhNDFpSEUrOUVJV010clM2QUU2RUtXTEVkSGc1?=
 =?utf-8?B?T0ZhZHRYZHRqdXhrdWh6UU55c0NGYy9FR0ZncFRWY3Z1MVlXNmo4MExRZlh2?=
 =?utf-8?B?QVNraDdSY1NYN1hLcmZXKzFEczZQZjBpTDErUDd2ZHVWeUNtZ25BMlpSa1Ar?=
 =?utf-8?B?bHh5eTBlOWNlZC9VZHZtVTloT0NxZW94VUxiZUZGV2lpUW1YL3BZWDl5YnNu?=
 =?utf-8?B?T0xjS2JxbjVRNHlmeVBEaE9VNGU1Q2srMURneW16aDlmZ2d5MUcvcS95VUxE?=
 =?utf-8?B?R0VEZGNoWmp4NnBTaVZaWXdYUzlmLzltTU91VWFyZDgvYWpBN1JZZUNiUU1I?=
 =?utf-8?B?NzRNS0pzNHptNEYxbnFmeTJmK1BpWW9ON0NkL2FLKzRzSGtJV3JCaENCVlM5?=
 =?utf-8?B?SzU0ZlVqZWF2aTZ5RnhWRG91eW4rZ20wM0kwQ2p1T0FneHNQY0o2YVVkWlRY?=
 =?utf-8?B?S2xHbjloZVJIS0pvdUpkMWc4R21jQkJOVHpVREUydE0yY2R6aVlQWEpyVHhM?=
 =?utf-8?B?R0tVa2ZVZjdmUEMyQnFnMHU3YzVLSXhMdU1EMmFHL0FXa29DY1ZjNlZ4ODli?=
 =?utf-8?B?cUI5L2EzT0dEMURKYUp5SERmYnpuNjRuVzB2aWE4eWJxVXFXenZKT29HY1Jl?=
 =?utf-8?B?cEVBSENMMklnZnVCYVF4QXU4ckxacmRDZzQ5SXdIZkU1ekQrOEIwOW8wYVpE?=
 =?utf-8?B?NllueHo1V0tYejlOdTZYYVJab0VrbnlqVGNiZ0ZQMzU3MGE5R2FQRWU4TzlE?=
 =?utf-8?B?d2swcEtUVzBFNVdJKzJvQ2wwTEo0elYybUMvTkhUdUVzZDBqVEhiOWRjam00?=
 =?utf-8?B?c3VZY1ZZNWR6RTFCSytWYjdWUWlkMTFoNC9RdG10OVBlc2gxVjJIM2ZYa1Ra?=
 =?utf-8?B?WmIvOVVScUFZMjNISGN1YXRlSTUyUGkrb0x3UkorYTRZYUVyU1grUTdLWWxk?=
 =?utf-8?B?T1JiT1pCdm0yRWc1Uytmd09vdXhlWU4wbUE2aGlMWWVYalRPdUhuUjlIOHB4?=
 =?utf-8?B?MWdLV1h0MkpQSWxXSmxWTGJaSTNuTjZCcnVtMHY3YTNDNElDMUdwQU9LN1hL?=
 =?utf-8?B?WHJqa1QrbmRpZXRkQWd1NEwzdlh4YUtITTRab3NDd0tQQkQraXZ0WUs4Znc2?=
 =?utf-8?B?UWZxRTVlTURuYkd3bVFzSzRwVWo4bXV5a1NocGxMRlhzSHBJUmxJcTlid01P?=
 =?utf-8?B?aDNBRXErSE5manJBR2FqTmkrdFFBSUFxZ2JHWUtXVzMyWDh1NThRWG1sQzBj?=
 =?utf-8?B?UFphM3NabG4wbk5DOTFCRWdYaFNNN3RiTUtKbXFmYlcxSE9uSU56Tmg2Ujh3?=
 =?utf-8?B?UTVIQmpqMEtsczlCT3lBbTQyZDJHWFh2TDFNSnN5SU9VZC82cTMzWWZBdUg1?=
 =?utf-8?B?S0c4L3FuZUdldG9jWWlMaWZlajlqTE9JOEMyTXBjYzhiUGtVL2RFenE3ZHkv?=
 =?utf-8?B?TXFGenJDL3BkeG85bGxpMXhLTHZ5eU5JcS9LTGFmT2ZYNUU3MHpReDBWS2F2?=
 =?utf-8?B?dHhDSm9XTG1BZkxZV3NiakVCTU1JSzRGVWFsK3ZSOUVINksweXN1RUlkTS9R?=
 =?utf-8?B?MTVxTHdDK0RmUlMrMEpOd09xZ2ZTcVZILzREL2NMNkEvVFJpQWlkVEFFelhG?=
 =?utf-8?B?R0d4dW81VENyQ2tQZU1XNld2MTV4YlRFTlNRb0ZiZzBvOUFIVWE5ekdKcW4x?=
 =?utf-8?B?UmJJallYS0J6bjZNTHRrWWduRUVEZncvQjRPdHZzd1BQc0RveDd2TXN3OTV0?=
 =?utf-8?B?Y3BhSnJhNnM4WGlhT1hVdnVmb3dqOUJ6dFBFQUZUUWpBNThjUStlbzl5ZGlv?=
 =?utf-8?B?Z1ZYdFhWL1hOMVdwQWoxeGNRMGl2QnYzUzNpWmFUSS9vMU1GY29iOERJb2Ru?=
 =?utf-8?B?ZytJR0o5UmErZGhGL2k4Q1BKS1h4aFlocFdKMVdTT3liZFZtVUJWZ0xyRERO?=
 =?utf-8?B?UmNPSDkxaWVKWlhpN0ZuaC9UWEtSYlR5bytVcFltOFh6UVlmSFNCSGNsbUxC?=
 =?utf-8?B?dHMrRDJEVlIvMTFMK2N3S2J1eU9XdmFnUGFWN1pkenUvVTZBYmQ3UHM1N3hB?=
 =?utf-8?B?dHlrcmwwMGxlNHkzNTNhZlJIYWRBNFFBNERyT1JBd2xzdEgvZHlJbEVUYm02?=
 =?utf-8?Q?oJ3+OsqCOx/jRi3zJmuWrqstD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd136c6-b06d-4dc6-2373-08db2c1b47a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 03:53:08.0644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kmJz7ApJ6boublR37K4CZX4MjRwAd3T+aoLi0tMadsDCL9GseOD56kor0jQOWMCY+AAqBnBz5svlQVQrVFQWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7534
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

PiBDYzogIG15IHBlcnNvbmFsIGVtYWlsIHFpYW5nLnpoYW5nMTIxMUBnbWFpbC5jb20NCj4gDQo+
ID4gV2hlbiB1bmxvYWRpbmcgcmN1dG9ydHVyZSBrbW9kIHdpbGwgdHJpZ2dlciB0aGUgZm9sbG93
aW5nIGNhbGxzdGFjazoNCj4gPiANCj4gPiBpbnNtb2QgcmN1dG9ydHVyZS5rbw0KPiA+IHJtbW9k
IHJjdXRvcnR1cmUua28NCj4gPiANCj4gPiBbICAyMDkuNDM3MzI3XSBXQVJOSU5HOiBDUFU6IDAg
UElEOiA1MDggYXQga2VybmVsL3dvcmtxdWV1ZS5jOjMxNjcgX19mbHVzaF93b3JrKzB4NTBhLzB4
NTQwDQo+ID4gWyAgMjA5LjQzNzM0Nl0gTW9kdWxlcyBsaW5rZWQgaW46IHJjdXRvcnR1cmUoLSkg
dG9ydHVyZSBbbGFzdCB1bmxvYWRlZDogcmN1dG9ydHVyZV0NCj4gPiBbICAyMDkuNDM3MzgyXSBD
UFU6IDAgUElEOiA1MDggQ29tbTogcm1tb2QgVGFpbnRlZDogRyAgVyAgNi4zLjAtcmMxLXlvY3Rv
LXN0YW5kYXJkKw0KPiA+IFsgIDIwOS40Mzc0MDZdIFJJUDogMDAxMDpfX2ZsdXNoX3dvcmsrMHg1
MGEvMHg1NDANCj4gPiAuLi4uLg0KPiA+IFsgIDIwOS40Mzc3NThdICBmbHVzaF9kZWxheWVkX3dv
cmsrMHgzNi8weDkwDQo+ID4gWyAgMjA5LjQzNzc3Nl0gIGNsZWFudXBfc3JjdV9zdHJ1Y3QrMHg2
OC8weDJlMA0KPiA+IFsgIDIwOS40Mzc4MTddICBzcmN1X21vZHVsZV9ub3RpZnkrMHg3MS8weDE0
MA0KPiA+IFsgIDIwOS40Mzc4NTRdICBibG9ja2luZ19ub3RpZmllcl9jYWxsX2NoYWluKzB4OWQv
MHhkMA0KPiA+IFsgIDIwOS40Mzc4ODBdICBfX3g2NF9zeXNfZGVsZXRlX21vZHVsZSsweDIyMy8w
eDJlMA0KPiA+IFsgIDIwOS40MzgwNDZdICBkb19zeXNjYWxsXzY0KzB4NDMvMHg5MA0KPiA+IFsg
IDIwOS40MzgwNjJdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Mi8weGRjDQo+
ID4gDQo+ID4gZmx1c2hfZGVsYXllZF93b3JrKCkNCj4gPiAtPl9fZmx1c2hfd29yaygpDQo+ID4g
ICAgLT5pZiAoV0FSTl9PTighd29yay0+ZnVuYykpDQo+ID4gICAgICAgICByZXR1cm4gZmFsc2U7
DQo+ID4gDQo+ID4gRm9yIHNyY3Ugb2JqZWN0cyBkZWZpbmVkIHdpdGggREVGSU5FX1NSQ1UoKSBv
ciBERUZJTkVfU1RBVElDX1NSQ1UoKSwNCj4gPiB3aGVuIGNvbXBpbGluZyBhbmQgbG9hZGluZyBh
cyBtb2R1bGVzLCB0aGUgc3JjdV9tb2R1bGVfY29taW5nKCkgaXMNCj4gPiBpbnZva2VkLCBhbGxv
Y2F0ZSBtZW1vcnkgZm9yIHNyY3Ugc3RydWN0dXJlJ3MtPnNkYSBhbmQgaW5pdGlhbGl6ZQ0KPiA+
IHNkYSBzdHJ1Y3R1cmUsIGR1ZSB0byBub3QgZnVsbHkgaW5pdGlhbGl6ZSBzcmN1IHN0cnVjdHVy
ZSdzLT5zdXAsDQo+ID4gc28gYXQgdGhpcyB0aW1lIHRoZSBzdXAgc3RydWN0dXJlJ3MtPndvcmsu
d29yay5mdW5jIGlzIG51bGwsIGlmIG5vdA0KPiA+IGludm9rZSBpbml0X3NyY3Vfc3RydWN0X2Zp
ZWxkcygpIGJlZm9yZSB1bmxvYWRpbmcgbW9kdWxlcywgdGhlDQo+ID4gX19mbHVzaF93b3JrKCkg
YmUgaW52b2tlZCBpbiBzcmN1X21vZHVsZV9nb2luZygpIGFuZCBmaW5kIHdvcmstPmZ1bmMNCj4g
PiBpcyBlbXB0eSwgd2lsbCByYWlzZSB0aGUgd2FybmluZyBhYm92ZS4NCj4gPiANCj4gPiBUaGlz
IGNvbW1pdCBhZGQgdGhlIGNoZWNrIG9mIHNyY3Vfc3VwIHN0cnVjdHVyZSdzLT5zcmN1X2dwX3Nl
cV9uZWVkZWQNCj4gPiB0byBkZXRlcm1pbmUgd2hldGhlciB0aGUgY2hlY2tfaW5pdF9zcmN1X3N0
cnVjdCgpIGhhcyBiZWVuIGludm9rZWQgdG8NCj4gPiBpbml0aWFsaXplIHNyY3Ugb2JqZWN0cyBp
biBzcmN1X21vZHVsZV9nb2luZygpLCBpZiBub3QgaW5pdGlhbGl6ZSwgdGhlcmUNCj4gPiBhcmUg
bm8gcGVuZGluZyBvciBydW5uaW5nIHdvcmtzLCBzbyB0aGVyZSBpcyBubyBuZWVkIHRvIGZsdXNo
LCBvbmx5IGludm9rZQ0KPiA+IGZyZWVfcGVyY3B1KCkgdG8gcmVsZWFzZSBzcmN1IHN0cnVjdHVy
ZSdzLT5zZGEuDQo+ID4gDQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBQYXVsIEUuIE1jS2VubmV5IDxw
YXVsbWNrQGtlcm5lbC5vcmc+DQo+ID4NCj4gPlRoYW5rIHlvdSBmb3IgdGhlIHRlc3RpbmcsIGJ1
Zy1maW5kaW5nLCBhbmQgcHJvYmxlbS1zb2x2aW5nIQ0KPiA+DQo+ID5JbiB0aGVvcnksIHlvdSB3
b3VsZCBuZWVkIGEgU2lnbmVkLW9mZi1ieSBoZXJlIGZyb20gbWUgYXMgd2VsbCwgYnV0DQo+ID5p
biBwcmFjdGljZSBiaXNlY3RhYmlsaXR5IG1lYW5zIHRoYXQgdGhpcyBtdXN0IGJlIGZvbGRlZCBp
bnRvIHRoaXM6DQo+ID4NCj4gPmU3Yzc3ODQ4OTA0MCAoInNyY3U6IFVzZSBzdGF0aWMgaW5pdCBm
b3Igc3RhdGljYWxseSBhbGxvY2F0ZWQgaW4tbW9kdWxlIHNyY3Vfc3RydWN0IikNCj4gPgkNCj4g
PlRoaXMgd2lsbCBvZiBjb3Vyc2UgYmUgd2l0aCBhdHRyaWJ1dGlvbi4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCj4gPg0KPiA+QnV0IHRo
aXMgaXMgc3RpbGwgYSBiaXQgbW9yZSBjb21wbGV4IHRoYW4gbmVlZGVkLiAgSG93IGFib3V0IHNv
bWV0aGluZw0KPiA+bGlrZSB0aGlzPw0KPiANCj4gQWdyZWUsICBmcm9tIGEgbG9naWNhbCBwb2lu
dCBvZiB2aWV3LCB0aGlzIGlzIG1vcmUgcmlnb3JvdXPwn5iKLg0KPg0KPkFuZCBJIGZpbmFsbHkg
Z290IGFyb3VuZCB0byBkb2luZyBzb21lIG1vZHByb2JlL3JtbW9kIHRlc3RpbmcgbXlzZWxmLA0K
PmFuZCBpdCBwYXNzZXMgZWxldmVuIGN5Y2xlcy4NCj4NCj5NYXkgSSBhZGQgeW91ciBUZXN0ZWQt
YnkgdG8gdGhlIHNlcmllcz8NCg0KT2YgY291cnNlIEkgYW0gZ2xhZCB0by4NCg0KVGhhbmtzDQpa
cWlhbmcNCg0KPg0KPgkJCQkJCQlUaGFueCwgUGF1bA0KPg0KPiBUaGFua3MNCj4gWnFpYW5nDQo+
IA0KPiA+DQo+ID4JCQkJCQkJVGhhbngsIFBhdWwNCj4gPg0KPiA+LS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4NCj4gPi8qIEluaXRpYWxpemUgYW55IGdsb2JhbC1zY29wZSBzcmN1X3N0cnVjdCBzdHJ1Y3R1
cmVzIHVzZWQgYnkgdGhpcyBtb2R1bGUuICovDQo+ID5zdGF0aWMgaW50IHNyY3VfbW9kdWxlX2Nv
bWluZyhzdHJ1Y3QgbW9kdWxlICptb2QpDQo+ID57DQo+ID4JaW50IGk7DQo+ID4Jc3RydWN0IHNy
Y3Vfc3RydWN0ICpzc3A7DQo+ID4Jc3RydWN0IHNyY3Vfc3RydWN0ICoqc3NwcCA9IG1vZC0+c3Jj
dV9zdHJ1Y3RfcHRyczsNCj4gPg0KPiA+CWZvciAoaSA9IDA7IGkgPCBtb2QtPm51bV9zcmN1X3N0
cnVjdHM7IGkrKykgew0KPiA+CQlzc3AgPSAqKHNzcHArKyk7DQo+ID4JCXNzcC0+c2RhID0gYWxs
b2NfcGVyY3B1KHN0cnVjdCBzcmN1X2RhdGEpOw0KPiA+CQlpZiAoV0FSTl9PTl9PTkNFKCFzc3At
PnNkYSkpDQo+ID4JCQlyZXR1cm4gLUVOT01FTTsNCj4gPgl9DQo+ID4JcmV0dXJuIDA7DQo+ID59
DQo+ID4NCj4gPi8qIENsZWFuIHVwIGFueSBnbG9iYWwtc2NvcGUgc3JjdV9zdHJ1Y3Qgc3RydWN0
dXJlcyB1c2VkIGJ5IHRoaXMgbW9kdWxlLiAqLw0KPiA+c3RhdGljIHZvaWQgc3JjdV9tb2R1bGVf
Z29pbmcoc3RydWN0IG1vZHVsZSAqbW9kKQ0KPiA+ew0KPiA+CWludCBpOw0KPiA+CXN0cnVjdCBz
cmN1X3N0cnVjdCAqc3NwOw0KPiA+CXN0cnVjdCBzcmN1X3N0cnVjdCAqKnNzcHAgPSBtb2QtPnNy
Y3Vfc3RydWN0X3B0cnM7DQo+ID4NCj4gPglmb3IgKGkgPSAwOyBpIDwgbW9kLT5udW1fc3JjdV9z
dHJ1Y3RzOyBpKyspIHsNCj4gPgkJc3NwID0gKihzc3BwKyspOw0KPiA+CQlpZiAoIXJjdV9zZXFf
c3RhdGUoc21wX2xvYWRfYWNxdWlyZSgmc3NwLT5zcmN1X3N1cC0+c3JjdV9ncF9zZXFfbmVlZGVk
KSkgJiYNCj4gPgkJICAgICFXQVJOX09OX09OQ0UoIXNzcC0+c3JjdV9zdXAtPnNkYV9pc19zdGF0
aWMpKQ0KPiA+CQkJCWNsZWFudXBfc3JjdV9zdHJ1Y3Qoc3NwKTsNCj4gPgkJZnJlZV9wZXJjcHUo
c3NwLT5zZGEpOw0KPiA+CX0NCj4gPn0NCg==
