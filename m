Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582D16B18F2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCIByk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCIByh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:54:37 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E1D44AB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 17:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678326875; x=1709862875;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZSoULik5ooHpDAUser23SsXaLLFMK+P/rn+NqF5X5ao=;
  b=QBzNh21fnUIfzl9teuoOL/lBaq5+tFKBxIzWvaNKuKw193O1nwzm7Neh
   POV6pCrFs/WmvJQpGh/Hzey1QLaylnw3pEMAhNYgG1X5kePkQBHEwL7s/
   rKhrfylz/HMWEkLkP7ZlGh5TlmI9HqJxa9LsMvOvtKJPcKqUJ0LAgA3J8
   ICspHzoZAnJ4IGC2UlyWJhMgNaz0dURbP7em7GGWKGsCpkvWG7NZrTvcN
   tJ12yxqKG2RRrR0BWcR/eBO9of3HykHSneKOnkK5FpDuMtp1uUObb+D0M
   u2xdl3iA7ZazwenlrSxdsxpLvhlvE6FxlQoPM+pSY+x+II+RYwkZIWdYD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="333799559"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="333799559"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 17:54:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="707413772"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="707413772"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 08 Mar 2023 17:54:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 17:54:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 8 Mar 2023 17:54:34 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 8 Mar 2023 17:54:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsG7+aL7iaDnneyTXl3T2D/LoUDchYviKyi64Z8jeRN+owA9dZaGcy56SWqZTKl7088JhYJKbpy8JRhSL5SDg5wWsmZVN2LO5cwSltdP3+MPmJOjvvmk7xAf42RGzA8Rp6lZOsXBsG1WdSEn0EdTitlDh/FseojB0dxUuktCfBDzRlEBGCzxNCOGFfLEidUpTLZjRKtiRKUL/CRSlKJRwFSe0+vE0Hxrp58lPIC+KXQTfB6MKHUlsU/XGa9QBNF31NP4LQmdSD9zAG8Tait/3FlCoU+T7EkzPJ0wVwq0r/2PeOjyPHK9MNgHR4zApABIRX1c7+Io0aq1CctbDwwfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSoULik5ooHpDAUser23SsXaLLFMK+P/rn+NqF5X5ao=;
 b=Zf+7z7FDzFjZFUDGLSZupxiiJVA15THetrWGX9C0tBR9Rcw2boOwCyfuC0n4AR1G7IQb/hb1Zn5aQ94ik8GvJgLOX5JRgI5UUypsOJ/2z2VSaMAySENA0GXKwZJQGktAyMhm5/PSzmCaCXRnBX7CcTM/RzJS3eYMFUUAixI6HUvB6lmHfZRklpJJMhSEToUBxCruN1g+e7oNHWF3sTHLLRbLheOf+ixnLKz7YEx0LGlhQOp5t2cIdAfa17w90pddJhl4yAow2e4pmQKqMypYwF8/MhS42g8Xb4bPHzQfc6A2XyWmCgpFLbdCL2DocX6rEmGVHEQkdYEbYSsUE5kEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN0PR11MB5986.namprd11.prod.outlook.com (2603:10b6:208:371::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 01:54:31 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 01:54:30 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "rppt@kernel.org" <rppt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "song@kernel.org" <song@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 4/5] EXPERIMENTAL: x86: use __GFP_UNMAPPED for
 modele_alloc()
Thread-Topic: [RFC PATCH 4/5] EXPERIMENTAL: x86: use __GFP_UNMAPPED for
 modele_alloc()
Thread-Index: AQHZUaI4YFq45g88cUWZfoxE9+DFeq7xsOaA
Date:   Thu, 9 Mar 2023 01:54:30 +0000
Message-ID: <ba3e16e1e2d6b2f5eae54d41592f90c9e7827241.camel@intel.com>
References: <20230308094106.227365-1-rppt@kernel.org>
         <20230308094106.227365-5-rppt@kernel.org>
In-Reply-To: <20230308094106.227365-5-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN0PR11MB5986:EE_
x-ms-office365-filtering-correlation-id: 8182ae8c-b056-428c-9be8-08db204138ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EKINgUcK7aayJaB5X40r2imxPj2zl/dOgC5EX5wseieAcRKwvMw832SnQTOllP0NaWA3LR97FjcNW/rBW6oGX8JOiJzFYOOw16/nBy41JCvLiV9e6mO+OMybTISCBocm9kpJy1MjjP0nqamVR/+kpPYo2rnRH9xzh1O4s8qHi/EKYBPPDqeMFyl/Zq/tzNDJjFFmgYGDiZGkLHWAg7wsxwG73xe85x3b51plnrPcqItyU9gdt63A7KpOL/zfAV3JCGW9bBQ4jY2YsUlj865ewU+c4iMdJlG1reIlPSg72TmJ+bXcYVUoh5W2fcTret379qsQHmq+yGmejOzMdhCYu98y4lVgZyheu372QS5U0c3cVaqd9+4qJxBwYtuwaKOPePTmTDTTUXcSxllFXAiTCI/OeIMSdsGZu+SBALwYmYimGToy/hQ32syrIQtnjKwmw4+Kqxdr2iiFi2ExC2wJyT0y/ynhbMzUKsdYhHZl8oyD2dXdiqorpNBLid44rrYsVoJ+y8FCtpKrHrWUIPKFkBXlnmKPDTa3tyP2oh5xwUOTIu4FSPHgSsyAZfTnuR2oqfrBOxMmWVAMfysTF5zVmJbVPqlFTKaFeztJGwZ/C851L8+yk0Vy/rpABUHkWEM1ry0PjI7GFB94havNE7knNcklIjyef0TVdgajkbijXfmE9w3Z4+ev0UfTWemuWlesQkufiSJWp2ll8Vu3iXdydkSZGRHeQP8N7e2LCk1Y7n4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199018)(36756003)(110136005)(54906003)(71200400001)(5660300002)(478600001)(6486002)(316002)(7416002)(41300700001)(66556008)(2906002)(91956017)(8676002)(4744005)(64756008)(66476007)(76116006)(66946007)(66446008)(4326008)(8936002)(122000001)(82960400001)(38100700002)(6512007)(38070700005)(86362001)(186003)(2616005)(26005)(6506007)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajU5M1JCZ3NSUVJ0WFBodEEyU09sRkRIWHZrQWV6SnArenlGTDc3YkxIa0hl?=
 =?utf-8?B?emg1UVMrNDhWRS9xRmdrd25XUlFuT2J2LzRDVkV4bEp1RThHTzVxMmF0cXMz?=
 =?utf-8?B?Y0NMQU9US201ZWV6WGs3bjAybkk3SzJYU2x6eXNzcGZ5Z3l2ZHNxV2lRUDly?=
 =?utf-8?B?WWNZVVQ3VXg3RzFQRGVFbGJ4SmdTUjZpV2xvcEYydnRSRFFJYnlML3FPVXJD?=
 =?utf-8?B?bXJldm40eEFPS3NmRVhSdkxFOC9WT3NKTEVDYUt6UkFhTjIzM3FxSWF5WVU0?=
 =?utf-8?B?TEJSeDZWSUY4N29uSkRFWDZ4SE5oL2NRZVJ1MExjUVl3a2k4eS8yYzZkbTc2?=
 =?utf-8?B?MGN5U1NONyt1NUNQMysybGtVWUs1bkNITmhoamJGV2pIemc5aFJkZlppd09N?=
 =?utf-8?B?U3RYbjBpQVdFRTBDQXpwcnJaVFA0cS9IaUxoOWk0dm1GSlp6MW1WRUgxNmNa?=
 =?utf-8?B?MmFlc3FGWFRnb2drbXF0b0d6TzdLaDNsMDR1NmZtcE8xcFZsT0crL3NKampn?=
 =?utf-8?B?emlPSVlYUkhuQ1lGQjFPTGVoMHlmU3BQaFkwZk9QMERTWktOc2RjWng5eWdF?=
 =?utf-8?B?Y0JFRi9LTXpMaEh3Zmh2U1lDQjRUR1JSMC9ZcWN0ekVKeFhHandjL25uNEVO?=
 =?utf-8?B?amRrMjhFNEFvS0RTZnc1Rm9SUkU1Q2lmeDhITkhCZHRTbC84NWZjQWUyZ1ND?=
 =?utf-8?B?NTJaSnliRUhvbWsyUWVDOWp2Nm9kczBrdFRRUUJkUmc3OVNlNEdVaHJyRnhq?=
 =?utf-8?B?QmhZU3FBYXdBZnJVYUwrQnI3UC9RRno4SkVvL0NqZ1NWTEFsY0lrS2hTcGJT?=
 =?utf-8?B?K2JSUFdwYmYvbUpya1U1SW9nNWVweDN3b285OGdNR3orREJLbmJVaVdFWEhL?=
 =?utf-8?B?K3RzMkR6K29yOURUZDgyNFZsalA2N0Z5SjZMSTdRYUVvUFB1ZXd0YXZEd0pK?=
 =?utf-8?B?cWQyc2dMM2Q1M1RaWWJTU0s5UmNXejg4V0VBM1B4RTNkVE5STEpyc1BXQ0RB?=
 =?utf-8?B?Wm5Dc2J0RG9zcThkL1J5NnEzeWltc3MrMFVITk9OOEFKeXRxQk96ZzZtdGdT?=
 =?utf-8?B?d3k2dWZVRDFiRnprM3Y2MUVaWXlwa2g2SnVGRGhYYkM5QzJOVjhyQzVyV0lj?=
 =?utf-8?B?a0UxQlQyYmdFM1pDWVhiVlhiR1d3REw3bmpoaUVLQnVscEUydDFRK2pBMDdY?=
 =?utf-8?B?NEdxd25jMlhEako1TTVHdHdZbWV1RFNseDVSWjhPck1EeDRkWDArbjNLNVVI?=
 =?utf-8?B?NDZ3SnpHMUtoejJRNnVFeStyTVROWHE3N0hObFI5b25wQVlvd1Y2My9DSVRs?=
 =?utf-8?B?Y0p3UWtvU0dGS0tHVlBFcWlETVRJdVQ5Nkxka3h4Sm0vWUc0cU1RN0FQWHRz?=
 =?utf-8?B?NW1CYi91dThzb0ZVSkpPSGlua0lkaGNidVVWcFQ1djR3S09vdVlxSTdMK05m?=
 =?utf-8?B?YVBCTURrZ2hhVCtVRUtPd2JXNnlmWVRKaEFrbENGa050VHFNVU96UlArL2Ir?=
 =?utf-8?B?S1NrcCtmWTdsQ2tWa2VhbE1tWVk1d0NuZUJiQ3lreG5tWGZ3VW9uUkQvV1Fm?=
 =?utf-8?B?U1NtNUs4aDRsVk1uNWhYZXAycEMxc2xIVzJPaUUwb1VQRDlBMXo2V0loNkZn?=
 =?utf-8?B?L0FBUC9heGtMb2lXdDhkb0xkSklxN3BpeitDSXhkNlNybEVuTFBOMkkxa283?=
 =?utf-8?B?NWFQZndUTW9BMldCNWRhUmpvNjdIMlg0NlY1enhnOGhOQ1ZMeURVU3NHczAr?=
 =?utf-8?B?Y3NWa1B3RHhqVXVhYkViSnhVRnh0ZUFMdy9qbW1tSU5ST3k4bnZvNlZrNVd0?=
 =?utf-8?B?czc1cktwVzZKcURVN3QvcmlyaU02a3lEdkMyczJUeXNRUFZybEk4ZWhvR2Vu?=
 =?utf-8?B?eHc4c0orZ2Q1MFdZOEJicFBtVU5EU1RBL3diR3BJWDJDYzZ3U1Q1Yk4rR1RC?=
 =?utf-8?B?UFVYR0ZkRzRuUTNaeWdveWNqZWp1eVRFbFZKTWtyMFJGVkw1M3IwblExY2ky?=
 =?utf-8?B?MVZlaGUrRmYrREo0ZllJNUVXVXUyL3dBTUlNblZ5dEo2QVUzRmtCSFNUS1h1?=
 =?utf-8?B?R3R0QXNtaGtZWE5FaWd5YWcxOW14TDF0NENGRnhlVy9yV2w5cFJjN0tJTnpG?=
 =?utf-8?B?TkF6ekIzNzdwdDUrMFBMWDd4NFVxMTVadVlsVit6eUFySEx2Z0wwMmhIblk1?=
 =?utf-8?Q?EE1wYa/EuhIpfIZPecYwqno=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <641094BB95F9F84A8B5C7C2C4F13AF3C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8182ae8c-b056-428c-9be8-08db204138ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 01:54:30.3091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1oTySLr6iJT71Wa3bludsBst7inDtMjPnCA/TzbcAymSgsnXpTfaGajLBaowFG6MOpuq/vVaK7SfblOnjrakxeZWhsLPPF36B0nr5c5u3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5986
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTA4IGF0IDExOjQxICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBkaWZmIC0tZ2l0IGEvbW0vdm1hbGxvYy5jIGIvbW0vdm1hbGxvYy5jDQo+IGluZGV4IGVmOTEw
YmYzNDllMS4uODQyMjBlYzQ1ZWMyIDEwMDY0NA0KPiAtLS0gYS9tbS92bWFsbG9jLmMNCj4gKysr
IGIvbW0vdm1hbGxvYy5jDQo+IEBAIC0yODkyLDcgKzI4OTIsNyBAQCB2bV9hcmVhX2FsbG9jX3Bh
Z2VzKGdmcF90IGdmcCwgaW50IG5pZCwNCj4gICAgICAgICAgKiB0byBmYWlscywgZmFsbGJhY2sg
dG8gYSBzaW5nbGUgcGFnZSBhbGxvY2F0b3IgdGhhdCBpcw0KPiAgICAgICAgICAqIG1vcmUgcGVy
bWlzc2l2ZS4NCj4gICAgICAgICAgKi8NCj4gLSAgICAgICBpZiAoIW9yZGVyKSB7DQo+ICsgICAg
ICAgaWYgKCFvcmRlciAmJiAhKGdmcCAmIF9fR0ZQX1VOTUFQUEVEKSkgew0KPiAgICAgICAgICAg
ICAgICAgZ2ZwX3QgYnVsa19nZnAgPSBnZnAgJiB+X19HRlBfTk9GQUlMOw0KPiAgDQo+ICAgICAg
ICAgICAgICAgICB3aGlsZSAobnJfYWxsb2NhdGVkIDwgbnJfcGFnZXMpIHsNCg0KVGhpcyBpcyBv
YnZpb3VzbHkgYSBxdWljayBQT0MgcGF0Y2gsIGJ1dCBJIGd1ZXNzIHdlIHNob3VsZCBza2lwIHRo
ZQ0Kd2hvbGUgdm1fcmVtb3ZlX21hcHBpbmdzKCkgdGhpbmcgc2luY2UgaXQgd291bGQgcmVzZXQg
dGhlIGRpcmVjdCBtYXAgdG8NClJXIGZvciB0aGVzZSB1bm1hcHBlZCBwYWdlcy4gT3IgcmF0aGVy
IG1vZHVsZXMgc2hvdWxkbid0IHNldA0KVk1fRkxVU0hfUkVTRVRfUEVSTVMgaWYgaXQgdXNlcyB0
aGlzLg0K
