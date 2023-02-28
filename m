Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A646A5E61
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjB1Roc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjB1Ro2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:44:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA6223C4C;
        Tue, 28 Feb 2023 09:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677606267; x=1709142267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R3H+Ip5kGhJWWZXsjnYOPSqNd9o31L4NZ8t8k00Wvis=;
  b=Tu0FU4JGGSf1dbb25VP7l+zK4RL6vBWqMi33/Qo2epyxSTLwvRjv6Mzm
   tYRUJSgbZqGauyjty4T1+OTBujr/fmxgfoQMcfPM4fLQnm2QUSf5Br9SO
   t/cRkR3teKHasX496m8ARFhLakijggbKNi9DKhbdm2666sJLf3bCo6PCH
   HN1aiallJ4Nv94KvNuTrEjcWxp+/wOlehTj5axyPBSdiaXLJRaEfc3BAK
   BzGt/LrfAk9M9au4U3LweVbWOa60+HJwNNpNo/5DwtjsR5zXEJPZHCPIZ
   N8RJDq0qQn/dgMXZToniuRtN81CcdCgwtQ/wanUEV/78iAP/snKMR08Lf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="335691922"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="335691922"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 09:44:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="919855277"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="919855277"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 28 Feb 2023 09:44:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 09:44:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Feb 2023 09:44:25 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 09:44:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdMdb5JZAiPmjmpOH7+Ns775hn0g5ES5H5DS1d1WHUc5GKl1WWQe9o306HVUD33v97syhNCaSbn7eecXKXSmUbCsg5XZdaFSK3OF4Gya6Tbnr51LkRdSFDj8VPwvDt+5+6tNmc+HF3Fm59ssig1dptSZW3gKjMqzQnOmudsIAUqjrkRXJT+1N2I40AqUmHv/IBl7XZT/W5M6Qvo5dpKSTxavXUyBLyu1nXBYq2BuU6ZTywwIgRh3ZNX/VggIP8oxS4qSYIVrMveVCM3rmKH7YB7GydfHLrwOyBOOXoQo4j6tnkW26JRMdP+jgWmG0CidsVs5/VOfcXGkMNY6NS0DVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3H+Ip5kGhJWWZXsjnYOPSqNd9o31L4NZ8t8k00Wvis=;
 b=KNec5EhXUWmlWGkQQ8aI99hN+Iit1fp9p+vce6wTP5KjcqCRDQDteQPdWJFjmxa78cOfI33xZH8Fa3vvAjkumsP3kuwSpB3O+OT8az9yB/an03Lfz4NS/S3NCxqJgOvuJY78Nun+Z8kjho97/4N5VrTn1rHJ51H5HcJVjTF3/t0EqAZCM79OjsuCfG2xBF83RY3RevpfC2Vd8RC+c7R99LEFTy+ol3pmTOsL44HfAAh3Myh9XPbTzs/g2xqJafiXFa2KEv5M0eGiwKPBi7uYX953+D6jvTuXel3GikdMo89MyEBmva6fNiHwTavEv9f9wuUYAaEkhAmRm1xw3UyFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 17:44:23 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6134.026; Tue, 28 Feb 2023
 17:44:23 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     James Morse <james.morse@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH 5/7] x86/resctrl: Add a new "snc_ways" file to the
 monitoring info directory.
Thread-Topic: [PATCH 5/7] x86/resctrl: Add a new "snc_ways" file to the
 monitoring info directory.
Thread-Index: AQHZMbXqvyw4Gquwq0Cl2irBA6p5sK7kzIsAgAAEZcA=
Date:   Tue, 28 Feb 2023 17:44:23 +0000
Message-ID: <SJ1PR11MB60837DC9C2E04AD3CBF3CA67FCAC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-6-tony.luck@intel.com>
 <a95d0200-da28-4fbe-2bfe-ff948b4c2801@arm.com>
In-Reply-To: <a95d0200-da28-4fbe-2bfe-ff948b4c2801@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MN0PR11MB6088:EE_
x-ms-office365-filtering-correlation-id: ce84fc43-b71a-45ec-ef93-08db19b36d95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aCqYbuiIdztIPrNweE/fP9KKajTyk+pU1Xe83bn1nGCv2P5I1IwOwkfsqzvjhUCtMJYYcuFcxeWk9NVOLdCmehSw1NQEtq3eSHRvnzBatK9SePkA5I3M6DpP05hk6sH1z7SZrsRsvFBdAY3H/AcICQeIKKrViyh9d7+wj1AxkPzE8eTenzuro2/E2MdIzKDrJVYrbPu35tQ3zPEZp4+Lj29NeWB4QESUADygNQ7xMOEkLJhQwv8LIY1ACAdWsnlWSHxDl4jEk93TheipNq4kkNEHH2H/WPuVReOrFudIIhqqLbf+cD7dowGN2gwhGLBn3nw55W/HVgQVtSLlSTq+1Kp5511yUnEkKUK8XfiE1OQ64CTafZh46FOu/5SxDG3kxNkYOc0n9TtyO2kHWL7ll3otMqDEN121hVrtvGdBKlwa7jsZvxJRnBVO+b2Tv1tQH62XPflEjq7HKSt3/a0I03djlmWLzs8APjz/FsLGk6sXLBkEfrcfsS06hwm+s6C+MeKHO5gwLJE5N3JRw0WI/c/v8gJ8oF3ldWGtdevfEzzSqBiYQUnr4w182jJ2IVDX4enWXZbZtku1nrHMjnP1Rbk+sqyMmXgIwEdHyZDVXEgH1Y7EiqY0n0Zy4bkGU7ILQvnwaN+gC/mL1r6gjaMjMGc2asV4EGaQkWTuRfkgYej51jwZ6EG/rLrwzKEPdNMq9zqbS/SMENThKHDPXDrV7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199018)(38100700002)(122000001)(38070700005)(82960400001)(4326008)(86362001)(33656002)(2906002)(4744005)(66446008)(64756008)(7416002)(66946007)(66556008)(66476007)(55016003)(41300700001)(5660300002)(8936002)(8676002)(76116006)(6506007)(9686003)(186003)(110136005)(26005)(54906003)(52536014)(478600001)(316002)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2wyVFFSci81Q0RCWStpQk9TVFQyUk5Va3RpL3dNa1RBRldqMjBoVXQ5Vnow?=
 =?utf-8?B?QjJBbGFld1p2QTl1VmpRTFRJRUVmRG1qS01VQ2I4aWV5aWFqaWVic0QwVHBW?=
 =?utf-8?B?TVZKUUNSd3VQL3BVdUwxdE45ZVcxd1RzR0hjWE13UnIvNU9QbTYvZm14elc1?=
 =?utf-8?B?dFpVUTJpOXV4RURYL3hWM2lDalVNaVlPSFBCWkFkMWdNWWEwM2lpMW1oV000?=
 =?utf-8?B?SXBQNGlWUzI2SVF2WkhFaW0ydHFkQjNJUVZXZy9hdlgxdHNuWlZIenFsdzF5?=
 =?utf-8?B?U2hnKzdYamNkNzhleks1bUFkcjNuM3dBbERLOFJMRkRFdHFTT01oWkhwNGNP?=
 =?utf-8?B?Qndzb2xqK1EzaFhjTEVnbEYyV2djV2UrOGdMWm5kL0o3MjRrai9EWG00czlM?=
 =?utf-8?B?L1FYN1NlVzN0N0JUa3VEdnBRaG1KL2MzQzJPN1lQWFpmMDRnZDVhSXhUeG0w?=
 =?utf-8?B?U3lxeVRxV09vdG9VaklHYzVqRnNLRXdWa2NzcVdCL2JZamVobW5RZm1EQnpo?=
 =?utf-8?B?RmJ3WDRZcjhiMEI2V1ZSWWRXZ0o3QWZ3alhXT1F4Tkc1V1VsdHYrNXUvcmdj?=
 =?utf-8?B?c1BLTjFHalVRT3o3dUQ2eGlkV25lZm9qQVN5eThoa0kyVjczT3cyUXFTNGRE?=
 =?utf-8?B?VDFZTFJ2VUFJd20ycDBPS2JoWS9XcFpvK3ZyWWhXYkFEeVhxTU10V0VFc0V1?=
 =?utf-8?B?bjlJNG1KZnlBcWd0Q2RmOGE2NmRLSVdBVDVUTzhFa3dLVkRHSE12YktjNHR2?=
 =?utf-8?B?TllTc1JVaWVKdGRaYU1mRW1MUG5MUGY0NGhnYkVxSTAyU2pKTUlKUW14SUtP?=
 =?utf-8?B?RWlJUFUzcExmNDBVVVJJWEtCbnRUN2Fielhya0s4aG5seEhQN2luQnoxS2l3?=
 =?utf-8?B?RjY3NGZGR1RlUzA1d2JONUVwTDk2cEZmdlNnalVSM3dBazhjMDRtM0wwaFF0?=
 =?utf-8?B?a1ZjT2dMekZHTFJsTWlHK1hvNVJCK1lHRS80QjR1b0lOY1Z3eFRkM1cwd1hX?=
 =?utf-8?B?M1JYdURYMzR0Q1F6OStuOGdDNzZ4V05UenMvdi9RVXNxeE00S3lPV3RnQ1Jz?=
 =?utf-8?B?RDRBUkUyclJYNTRrbkJsNDdIYnVXc3l1aWp4S1BHa2lBeExVNnQ2eFhsdUdS?=
 =?utf-8?B?UDNReWF6Wm5vK25jbFNTVytvMFNoYVpySGl5a09LTjIvc1Y4QW5NVEFqWVQr?=
 =?utf-8?B?UlNIMkVmRmZNOHdDeDJHVlR5NnZSOVZsSFhIZWd0K3B6bEd3UHIwTDZ6QzJa?=
 =?utf-8?B?Y2dacDMwdlZFQXJIZzBnWXhtYk10bGZUYmdyRnlCQ2t2cjRiMW44TXhKUi9w?=
 =?utf-8?B?cEp2TzFEVzVoQURwYy9WcGoxZTNuNEM2N1JMeU1TczBKWUY4VExEWk52ZUs1?=
 =?utf-8?B?QWwwd2t0Y1NzSGo5MC9uTXA4dHNYYk9zcy8vUVpTTURoWGZyTG1kY1dnZCs4?=
 =?utf-8?B?TjdEVU5hdGZDRHhjejJBQzh1T2FXOThPVDNzYklCeHpBblJGLzhsUXNoOWVm?=
 =?utf-8?B?VlVmSWdTeHQ0YjhNckM2R2k1cmt2SnlNbmdEQk9ITWd3ajNJcGttSnFwRlBH?=
 =?utf-8?B?d0Ezd3R5S1BDTTdONUl2TjZOWEVkelFtYkJrK28zZTVpNU5zeUszS0UvR3lp?=
 =?utf-8?B?TlpJOHEwU3pRRXYxTnBLL2xCWmtXSVhYVXQ0RlRNV0dwYlFtbFhOR0J2SDV2?=
 =?utf-8?B?T3hsZEpkRHdvVXo0UHBIRlpQWTVyNTVJNHhTZklOWkorMFgvQm5CQ2s1Tmhj?=
 =?utf-8?B?b2VlaHdXc1B3S3RYSEN0MmNjNXpKT0htMHN6dVc4V2k4bEttdzNuVDdlcHBu?=
 =?utf-8?B?Ty9xUVRVSlIzdXQyRjA5UlRSVzl4S2RQK0cvZi9NQkVKYS93V01lSnIvNmF0?=
 =?utf-8?B?QkFIaHVadFAzRkJkbUp4azhQNDZoODBoUXdlUGh6TkI1T0o0c0VLZGhCT3lp?=
 =?utf-8?B?NmNMbFROZkVKdTVpQmVPVlBlbVVVVlNyTjBISlk4aDZiSktpY0NYbm55VWRx?=
 =?utf-8?B?RjhtdXFoeTVEMFJwdThQMHdUa3FGRjM4QUlKSXZ2VkpEaVhNMnBXOEJnL3d4?=
 =?utf-8?B?RHVOUllpanhKZmVkWSs4T0dzWmFuSGd6aitzeGsvVXJBMkl0ODRpcGFkendr?=
 =?utf-8?Q?JoZrzJNzR1bca4rGqOM3EWOw8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce84fc43-b71a-45ec-ef93-08db19b36d95
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 17:44:23.0971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3Hh59urgI0i4Q3FDxQ20LTOxWAFeJbeLgC6h7tPxUuoJHh0da9Rs/P7sOx3DzHCUdghfKV9CmoHbuJ0Q2TNDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
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

PiA+IE1ha2UgaXQgZWFzeSBmb3IgdGhlIHVzZXIgdG8gdGVsbCBpZiBTdWItTlVNQSBDbHVzdGVy
IGlzIGVuYWJsZWQgYnkNCj4gPiBwcm92aWRpbmcgYW4gaW5mby8gZmlsZS4NCj4NCj4gSSB0aGlu
ayB3aGF0IHRoaXMgaXMgY29udmV5aW5nIHRvIHVzZXItc3BhY2UgaXMgJ2RvbWFpbl9pZF9pc19u
dW1hX25vZGUnLg0KDQpUaGF0IHNlZW1zIG1vcmUgYXJjaGl0ZWN0dXJhbGx5IG5ldXRyYWwuIEkg
bGlrZSBpdC4NCg0KPiBEb2VzIHVzZXItc3BhY2UgbmVlZCB0byBrbm93IHRoZSBudW1iZXIgb2Yg
d2F5cz8NCg0KSSBkb24ndCBrbm93LiBNYXliZSBzb21lIG1pZ2h0LiBQZXJoYXBzIHRoZXJlIGlz
IHNvbWUgYmV0dGVyIG5hbWUgdGhhdA0KaXMgYXJjaGl0ZWN0dXJhbGx5IG5ldXRyYWwsIGJ1dCBz
dGlsbCBoYXMgYSBudW1lcmljYWwgcmF0aGVyIHRoYW4gYm9vbGVhbiB2YWx1ZT8NCg0KPiBXaWxs
IHRoaXMgYWx3YXlzIGJlIGEgc2luZ2xlIG51bWJlciwgb3Igd2lsbCBpdCBldmVyIGJlIHBvc3Np
YmxlIHRvIGhhdmUgYW4gU05DPTIgYW5kDQo+IFNOQz0xIHBhY2thZ2UgaW4gdGhlIHNhbWUgc3lz
dGVtPw0KDQpJIHNpbmNlcmVseSBob3BlIHRoYXQgaXQgaXMgdGhlIHNhbWUgdmFsdWUgYWNyb3Nz
IHRoZSBzeXN0ZW0uIEN1cnJlbnRseSB0aGUNCkJJT1Mgc2V0dXAgb3B0aW9uIHRvIGVuYWJsZSBT
TkMgZG9lc24ndCBoYXZlIHBlci1zb2NrZXQgY2hvaWNlcywgaXQgaXMNCmp1c3QgYW4gYWxsLW9y
LW5vdGhpbmcgY2hvaWNlLiAiMiIgaXNuJ3QgdGhlIG9ubHkgY2hvaWNlIGZvciBudW1iZXIgb2Yg
U05DDQpub2RlcyBvbiBhIHNvY2tldC4gIjQiIGlzIChvciB3aWxsIGJlKSBhIGNob2ljZS4NCg0K
LVRvbnkNCg==
