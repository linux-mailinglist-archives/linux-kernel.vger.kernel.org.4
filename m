Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB2C604F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiJSRpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiJSRpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:45:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030B7153822
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666201515; x=1697737515;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Md2fveWVvi+UzQaI/QPBCdl3j6qBLQUp8sOsjOcWMk=;
  b=bsIvEe4MbeVO4ENtpSt0Y1nIIX4lEYirjoXEMpQ77F13oYeY9PFJM+g9
   4vzsdraklo1jzOC3faWf9ms9kKv3LbITtCeR0Gubo4CSl1QvUFq1/sD9h
   XVHMIrMicfGs04OlspvnPMuX4SiZfJgwBJXNXhHbJJ4UJciubm3LKo8c2
   LXHMsjFLxYxCHQfZfD0KHZzBYQj8+kTJuO6h9qYp1vmfcDwILN0Kr0XOc
   rP2pUvcVYBrDhx9grnRJZKi7dOO7rQ7eLL61peSijZMr5WeaSHbQLi6W5
   Y0jbIWD2rvAjs2xGO1qTZi5A/wNS6zS3eJb4ybu3lRsijSWWnb/I8rAAR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="289799868"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="289799868"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607208826"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607208826"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2022 10:45:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 10:45:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 10:45:12 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 10:45:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahc7OHZFx4pJ/8KE0Ns4PHJbzeEMTPUvB2U+LZVw4A+dkrVWFYcfCW9NjepKt2axhSxElb4UD+IJO4xnDxF7kx+sXXqnaOzVCjBTdn3h+aElPR59ASWt6zQt12l9lX3BqIUOZUc5s47wtQ6UfFvdjXPMOTR/xZx+WTF/HO+VjEol3Ba5F2s3p6AP657bcCEc5qWD/dA3WeQlf1jMwF8+ckA5vRP0CAGuNt//OdrGd41ijSbR3F2zbZW51LKpuJmBbSVL2dv3/My60z5mgL4eqP5GPBPjqPgPXbAmQuUKmSaH17ZaS6wTrgc5lRR0jmc9YMZIYUT9Qk+X4TISMB1m6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Md2fveWVvi+UzQaI/QPBCdl3j6qBLQUp8sOsjOcWMk=;
 b=kgNKEHUSNmEiF+uMs1voaMvphwy/xKPmFMW4m9qTKy24WpnyqP2+fKIDFA7Uxt6bEKs+ObcgdSPL9EtzOKhV4hjBhOWo2zjy6nYiIg1veF9GXPit2USHDf2JhnRVkqz1eXxWojBfo6aDVt+auIjyQjGUyxuRst9ngei5rZI7AVOpMuUPtCX5/epXEyve07sNq84lw8tfMerahBIoC9smC66IEDt/ni6Ovrz4ycypocH+7NX7ZgQJW20s7UBVE/bcJfu3RDZeayoqp5Y6YQFs3yNtae9Zk76S7JK89P4ZgdxKPFqCRx4gWqaHCBX3x2xOiH5e0XXRAkzitB5izLngcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by DM4PR11MB5994.namprd11.prod.outlook.com
 (2603:10b6:8:5d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 17:45:07 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5723.034; Wed, 19 Oct
 2022 17:45:07 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Gross, Jurgen" <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Subject: RE: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Thread-Topic: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Thread-Index: AQHY47Kv7yW3S865XEiTjYU/Nl/o964VodIAgABWNFA=
Date:   Wed, 19 Oct 2022 17:45:07 +0000
Message-ID: <BN6PR1101MB2161DD8F4F587C6FBFCA18EFA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221019095035.10823-1-xin3.li@intel.com>
 <20221019095035.10823-6-xin3.li@intel.com>
 <439a325f-6a00-845e-7850-43abfc60cd44@suse.com>
In-Reply-To: <439a325f-6a00-845e-7850-43abfc60cd44@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|DM4PR11MB5994:EE_
x-ms-office365-filtering-correlation-id: 89e9ad36-1eff-428b-ce8d-08dab1f9a97e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EAtLhunpfd3lb2MboTtPTg/343tQtBQU/zX0MlZT48StYZpyfUaVLwrtZZal4Pd547LzfTGsRJiNC1b1Yr0gogx0g3no1iyVHp3hh2Ut2n7h9/jUtP+wQBfaUm+Zh+fJIjlEwnqOb+7kb0Wm5Cd0VmihtdGWcSOUPK2IboQx6xU5+wCYWL/IirRP3NzlZsGRPR3dumyK/joAWr41e24oJJS82WEFadTVHOaaajuw+W0Iz+x9711Midz67e6xDAbDv1Ue7IOFs0tK8B0oihYVtM/k/EgHVQVEbqkn/3yRYpBQyArrR7i1AV5kyjHSmkuC3VT4lpTagdOMKs7uBay811TfFdE1+XI//BnYrL+mewz8xJT02xfOOY3mD5FWxK4NC5LjZuAzo5ezekvufps9rNCcsyIdqept5G8y+BkPwZwE02DkCjRP8KVgyY6XUXJIAbg53OgI+ZlHGFhOPDZwCFKiflc9W3H/o76LlREHZYgEJlIg80esF1iSxLLGTc1NVQuK1+jXNsNLEli1bDcsUHHiEycIm0hHN66lpepe4uU4yGKBO7ZEQvoRBRLTziE05dIssGDroLjOpp4Hc+7+qDpq4HYKi8dqChJkb8JSmqYk9iF4PDIvPC+nLsEBOTh6DwDbOmCzcdN0B/eW7F6CDQ0L9SalLfH/TBkOU785xJTrnzGW29zM2vOcI/Z3iy6BEc+6guLUcMN6qklqCl+mMbXqLZndUe4q0E8VJYtbhxVx7x+NH51kQxROXWKabc6P25PplqE4x96FcJjYo+MCMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199015)(55016003)(86362001)(71200400001)(110136005)(316002)(54906003)(38070700005)(33656002)(76116006)(2906002)(186003)(8676002)(7696005)(6506007)(4326008)(66556008)(7416002)(66476007)(5660300002)(38100700002)(82960400001)(41300700001)(4744005)(83380400001)(478600001)(64756008)(9686003)(66446008)(52536014)(66946007)(26005)(8936002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2xmODVjeE5RaWFNd1dCK3dqOU1VWnZpTTJyUVMyOWJaaGltSXhWY1lxbEhN?=
 =?utf-8?B?bDhSQTNuZ2hCcTdpRCtrSlQybnVmSXVjODVCVjY4YStRWk9jSHJ1alBDeXhZ?=
 =?utf-8?B?NVhNb2hGditpUlB0Q2dKMEhsRjAvTEp3dFp6WVZyQ1AxSVowYVB6b0hUVndL?=
 =?utf-8?B?QmVvTEdrQmFvN1JJTWZneFJjb0UwVGNVUGNVcU54b0tDV3owWEZlVUNkRDhV?=
 =?utf-8?B?N2tvaDI0Q1RuVGJzYSt2WTlwWnBucXFuWENYSkVoMThqUHFnaGZOZEhveEJn?=
 =?utf-8?B?bFJOTy9pdjdOd1ozL1ZuR29IR0dIcmw3eG1HY3RWVitMV0M5eU9BSkNWeXJV?=
 =?utf-8?B?U01LOUdIWEc4YUFoc1ROdVdTRlVIUklOamZYNnJXajN1dUxqZ3loeEgrd2g1?=
 =?utf-8?B?dWhEZTZMNjhVTmNGZDJxeWVTczZlOHBWT3c0d1lqQnZERVZPZU9YSXo0SW56?=
 =?utf-8?B?c1ZxMitVOUUyMkE2VWhQMEVuL09Hc2pmcjlOMk5CU2pWL3I3V0tsR01kMTdm?=
 =?utf-8?B?RFJiampmRzM0Rys2aVpBQzBHeXJZZWZIODdwNWQvVnREZjJFTVF5SVhCeHlE?=
 =?utf-8?B?azgwTU1IZ1dvb2hlanV3dWltRVdYNjhsSStTeG8yUDRsM296TDZrMGw0ekZ3?=
 =?utf-8?B?aFNETkQ4WksyRnVDSDNOdnI3QWE0M0I1K0Nua3ZFK0N6aXpiVnMxKzZQV1BE?=
 =?utf-8?B?S0cyMFdzRWZ1VmdmalZobE5YaCtBd0VSbXdGT04yMkl1L0d5WEROTk00K0RT?=
 =?utf-8?B?dzZUZzZBSkRuaUhEVkNDK0phVlVWMHFKbHBUZ3lGTFJIQm1MSUM2OWlJQ1Zq?=
 =?utf-8?B?M0Y0bjFXWE5lbkJwRzROWjJ4ZjJXRE1oaCttcW1aaEdDbUxwZkI4Tjk0TDZm?=
 =?utf-8?B?cTZFd0c5YWVQRmZrdDQwZHVmNmV6N29xdjJsYzJ2YWdjTEYzeDJ1M0xCL1RL?=
 =?utf-8?B?enJmWldZY1dRZHNwVzlDYlNVQUxUZVJTNFJiZFgxVmlsR01nWUhSdm1oaEhl?=
 =?utf-8?B?cXE2cVFhbWk1UDJwejArZFdia0s2T09jbnozOUM2MXg4bVJhUEdzdFE2Q05H?=
 =?utf-8?B?SHhkK1RKUVBTZTRneVVwczlkeEdnV3JsdlV6VDJSV3o3eHNpMUYzTC9vWWd0?=
 =?utf-8?B?Nmtxd084b3ZIU2gxWkJXc2o5YmkwSStJZW5rUEF6YUNRZkVwSW9yaFprVXgv?=
 =?utf-8?B?UG9oR25NMGtBbVhLNWxoL2ltSi8vRTZTUVFOSWZ6N1ZuaWdINTFVVjVLUW1n?=
 =?utf-8?B?RloxZElnekhSSzMxRHlWbmo5ZWZpUWcweVFuT3FWaHdTS3JibzRtOEY3RXBC?=
 =?utf-8?B?K0t6N1FpRDFJSHkxbEMxckhFWEhCMmZTMW5qVER0T3RWWlZpQXVaVnBBdHZk?=
 =?utf-8?B?K1R4d1lMMjJZKzdjV3VRa1A0VjlPU3kzaFdWaU53MXExbmxOS1RPQVYzTnha?=
 =?utf-8?B?TlpOZTFKcUdZckI0OUp0MDVGTzM3STkra09uYlNRN014OGprbVFnK3RYL1pD?=
 =?utf-8?B?TnlqRklyZmdodUtCWitGTU9sUlVjWVR4TVk0VGc5b0ZhN2EycnpQbDJFT0ph?=
 =?utf-8?B?VUN5dVlQOTIrSUN3bWRWV0xjTjBPNmZVV2REMzZkb21RQnk4SnJzWitPN2sv?=
 =?utf-8?B?NVpVNFM0bUQwOUd0UFlndVRpZDk4MmVickV1cGJJWDZiN0ZPMjZBR1lhelZD?=
 =?utf-8?B?UlVsa1I1ZzJpWGllclhsbktXWGkvaEUwRmxHTExuQ2p6SWFSUHN2b1FsSmRB?=
 =?utf-8?B?L1hXdHJqVFpJNDNBME1ZdFZ4T3B3RzAyMGdOMytBUEc4SHBZNWM4MjNpT2I0?=
 =?utf-8?B?SHdpckwrOG1xMHNjaDNobnhhRjNpM0s0bUdiKytqQ1ZTREdRY2d2eStHY08y?=
 =?utf-8?B?WkNuT25BR1AvSXFlTGhYeEdQNFA3dlQrVTJna3dYQUVtYXNTL1JDcmhQbGZG?=
 =?utf-8?B?N01XRm5ReG53L0xMVVd0YlFDVEM5ZlpPZDhURDNVanFtNkY5UkJaQ1NqK204?=
 =?utf-8?B?Q0syT2hCemUzZlBzRGhGcEc5eDBWSlRNUTgxUUZMbldEUXNvOVJSTmJEdGgv?=
 =?utf-8?B?TVZkdjlBZFZhdThTM09zcVAxWkZwTjhoZ0s4UHZPMnpSeUN4L0xyZ1I0Sy9U?=
 =?utf-8?Q?7c+s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e9ad36-1eff-428b-ce8d-08dab1f9a97e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 17:45:07.4354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ep707/vifLZ0r4/1gALeLbwjZksAcVszyytEWSUj7DUZnOuki0HEn32W2JLA3Xn2I3Bww/P4YJNyCKo2b7H2Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5994
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgX19pbml0IGxrZ3NfaW5pdCh2b2lkKSB7ICNpZmRlZg0K
PiA+ICtDT05GSUdfUEFSQVZJUlRfWFhMICNpZmRlZiBDT05GSUdfWDg2XzY0DQo+ID4gKwlpZiAo
Y3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9MS0dTKSkNCj4gPiArCQlwdl9vcHMuY3B1
LmxvYWRfZ3NfaW5kZXggPSBuYXRpdmVfbGtnczsNCj4gDQo+IEZvciB0aGlzIHRvIHdvcmsgY29y
cmVjdGx5IHdoZW4gcnVubmluZyBhcyBhIFhlbiBQViBndWVzdCwgeW91IG5lZWQgdG8gYWRkDQo+
IA0KPiAJc2V0dXBfY2xlYXJfY3B1X2NhcChYODZfRkVBVFVSRV9MS0dTKTsNCj4gDQo+IHRvIHhl
bl9pbml0X2NhcGFiaWxpdGllcygpIGluIGFyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYuYywgYXMg
b3RoZXJ3aXNlIHRoZSBYZW4NCj4gc3BlY2lmaWMgLmxvYWRfZ3NfaW5kZXggdmVjdG9yIHdpbGwg
YmUgb3ZlcndyaXR0ZW4uDQoNClllYWgsIHdlIGRlZmluaXRlbHkgc2hvdWxkIGFkZCBpdCB0byBk
aXNhYmxlIExLR1MgaW4gYSBYZW4gUFYgZ3Vlc3QuDQoNClNvIGRvZXMgaXQgbWVhbiB0aGF0IHRo
ZSBYZW4gUFYgdXNlcyBhIGJsYWNrIGxpc3QgZHVyaW5nIGZlYXR1cmUgZGV0ZWN0aW9uPw0KSWYg
eWVzIHRoZW4gbmV3IGZlYXR1cmVzIGFyZSBvZnRlbiByZXF1aXJlZCB0byBiZSBtYXNrZWQgd2l0
aCBhbiBleHBsaWNpdA0KY2FsbCB0byBzZXR1cF9jbGVhcl9jcHVfY2FwLg0KDQpXb3VsZG4ndCBh
IHdoaXRlIGxpc3QgYmUgYmV0dGVyPw0KVGhlbiB0aGUgam9iIGlzIG1vcmUganVzdCBvbiB0aGUg
WGVuIFBWIHNpZGUsIGFuZCBpdCBjYW4gc2VsZWN0aXZlbHkgZW5hYmxlDQphIG5ldyBmZWF0dXJl
LCBzb21ldGltZXMgd2l0aCBYZW4gUFYgc3BlY2lmaWMgaGFuZGxpbmcgY29kZSBhZGRlZC4NCg0K
WGluDQoNCj4gDQo+IA0KPiBKdWVyZ2VuDQo=
