Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3B86806A4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjA3HnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjA3HnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:43:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502A2D529
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 23:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675064584; x=1706600584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JTvqZsFG2Op8gUiBiq5855+csFauM1Ee/1jcGDEEPg4=;
  b=XyMjfBD+SG8BH0Wg7YynehQ2gfaAyueH0MqsZCTf57ZYbP0gLf+k2eAJ
   QvnjXuJaoVVv21RKbGPxrOxF5zFsTaBm8P0Y0Ad/4F/irVMZGXZoa6XnJ
   SgyW3ZbtMZWyQ+p6iEpNcLOi2Fp16ciPQDrtHmjsJYTQvnPRUcddK8DJE
   bYGx4RUhrZYuI5SHdOHul93NWItt/v2eqkZJpr+wC6S/jeJCQCTC9yylw
   lyxySq+IM5OGhPS5xr4tcBjWGTDq3XRdr5k6lvfZA9JPBu1f/8rGAiV3m
   ELox0JpK/0bI+8i0yKqBC9SC1Y+FDarEKbM9h2gsqzhLRoJIwe4tZYYoW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="315455697"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="315455697"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 23:42:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="665982439"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="665982439"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jan 2023 23:42:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 23:42:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 29 Jan 2023 23:42:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 29 Jan 2023 23:42:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpN+wnaP9Ysj7OtfqKxQNOYZlqQiTVI2IpU/TvFuN5joGlxzBnqGEGfKRVru9bEsu/f2MjP57vAeDEhvkXbVhp2qBIbi/rKhymyCRdrnAb0vFwWfQHvIhK13Jq21oQQseUQ9mkmVcLmHEeOyfwHGeZ6hQE6D6r9hdKZWGfVkROevj8K4S44DK8fA1iLKsipJVeMsj8eR2gg3RsauUXd/JStjsdHHmRYeqaqb0X2aXfATMDnIm2d/2jAi71AELsqLhPl4nlLo5vIN5d2fOX/sJ7tbbWs5cDKqR3dGhjHFxM7ZbVDav6fEjVhD+vlFa6Ibmmnq9uydINnBeJQVnwIfvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTvqZsFG2Op8gUiBiq5855+csFauM1Ee/1jcGDEEPg4=;
 b=Q1FBua1uZDgfC9ZDL/ZOZIkcGdyW2rnP74dTbd2X9nP5LE3y7PvcLD1x4BTrNHTfMxW/fC2qVDdQkjazK4ydpA3rxBXBwc0iShkfUP0Y+lEzp14Vf4zVNx6xAr/trVDCwUCpEI05m+3DNDSkf2snf0fhhkxC9wZIK8abjlOV8riQeunbDVtAZnFD7suQjleoFQ/XljXJHeBPLhH/VcpIY3DnNCOrH8HmKIf631dcaQ0S7IGHjhHxf3/H0dAY+1rN+OYvwAjuPRPkf4Fdc4KoKjVzDIQhl3ZV1sCxJ3knDLspDt+Y+Qnlceo+WgdO4SRns4zpXDGhpp/PZzonVRCEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 CY8PR11MB6938.namprd11.prod.outlook.com (2603:10b6:930:5a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Mon, 30 Jan 2023 07:42:30 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 07:42:30 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: RE: Linux guest kernel threat model for Confidential Computing
Thread-Topic: Linux guest kernel threat model for Confidential Computing
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwACTigAAAR067AAKubQgAAALAEwAAJJbIAAAYhDQAA/PSiAAH3FjMA=
Date:   Mon, 30 Jan 2023 07:42:30 +0000
Message-ID: <DM8PR11MB5750F939C0B70939AD3CBC37E7D39@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9EkCvAfNXnJ+ATo@kroah.com>
         <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9Jh2x9XJE1KEUg6@unreal>
         <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9JyW5bUqV7gWmU8@unreal>
         <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <702f22df28e628d41babcf670c909f1fa1bb3c0c.camel@linux.ibm.com>
In-Reply-To: <702f22df28e628d41babcf670c909f1fa1bb3c0c.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|CY8PR11MB6938:EE_
x-ms-office365-filtering-correlation-id: 9ac73411-d90f-4f08-5334-08db02958ac8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QStC0+/8bvInH6/PIFLIBsjDoFKRHSsQf2LeFeXd5Z5j0+5hsYw6yBjeTI/KNSmeT5vcgYRU5B/jwZXVl5V3eDWSqJFxfBsQVGP/M9dzAv9ngK2ZZXIkolKjg/r8UWUTVGxINLb7ivNgJpFqAxfhiPT6MhCFif97oYHj7DgWKh2WAZKzfF3ivB5fXxV4whMzD80t8oQ1tfvK5YXfPzVvzjfPDKmXmdsOINs6R7oDsoIGTH0Q0iMdQRqSTdUO0PfpAj7H7BnrUl2BobYywW/gnktEx067Z/9rLtll3jUm9hCeumbXSb5p7g17nu7g1vkQrFZxVtJIb/yQR+m4aXaDrfHlbG69Qu143eocasrMrM8qrvG+mq4lqN8RCrFBR38btaGd21X80WG57HHxSnydUtWu1Nm4fSExvfiCCz2FZ2FJFmICwnOUEZoa5QjPFJkSXXU03+KEYr5ttFFF4afVcfb2rGCq7fzirr1rz1kveQ4pgOIq3EZ42QF58FGI4/w9UAbQJibsPHtqflgZcjm7dcOMzv4JR/GeouxH+hwro9MWUcgO7L5wNUduKNVZ8FmCztIhbqlYfElQ4iuDSTmNVjiMq1/m8oRgYXxE7lF2K6JZvh2I3ioCOn/wLZDHTymao2aJRWPRtT2uib7gL+wqYSG8466OcLxzlbb3qru/sgp6aBlTUD5XRQaKPsfRh7hPwnWTB4rHMwmL46e1IgvkqhzdsoiOz5ayzjiqIigAci95AmdCI3LDH2xX/NT/0r8HbbUxpwugifufUllVMzSFxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199018)(7416002)(8936002)(5660300002)(52536014)(2906002)(55016003)(86362001)(83380400001)(41300700001)(6506007)(66556008)(76116006)(33656002)(8676002)(110136005)(54906003)(64756008)(66446008)(66946007)(4326008)(478600001)(66476007)(9686003)(26005)(966005)(186003)(71200400001)(7696005)(38100700002)(38070700005)(82960400001)(316002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TS9KSEFxRFp6Y2JRRmYrNGNvT2VrMmR3QkZmdmtReEJNc0pVV2Z2WVZSZmE3?=
 =?utf-8?B?L21OMDhqekZ3OTl0RitrbTVNMUE0c2RHL2p3aFNqTjZoYTdITHQ2SzlvVnNr?=
 =?utf-8?B?cE02L3UxTkNtdEIrZkptY0FMNkpoNlJHMXZNMkg0RFUxZVdIMUQvUWZFZklZ?=
 =?utf-8?B?cVF3cXBQZGdjT3gydDBJTFRlcysvd01NSHFlZnlxcmJBSU5uei95V2wxMUdV?=
 =?utf-8?B?K3Yxbkd3anIweHpybnFOM1AyRUo0ZG1oWGtzV3ZMVk9aenIybm5kSHRVSjZo?=
 =?utf-8?B?VjVCY0dzbWRaOHpVUlJLSEJUVjkwQ2U1eUJrNEhSTy9pS3JXWVNtRk9wc0xn?=
 =?utf-8?B?QVUxRUtLZjdrOG4zRkdHUmVpS2xPUVc0K3JMR0draWlzYllvQ2dnZldkNS9S?=
 =?utf-8?B?NEFDejFGTVY0UUZkMk5yYXVxMnRpOWRhK0xyTWQ2WWNTZitMVm8wUlU3L3ds?=
 =?utf-8?B?dGtLYldsNWxvZlRVc0tUNVRKNWdTT3RVMUJyQXNhYlA3dzQrZTRhVDdudHB0?=
 =?utf-8?B?Z1FLRGdWWUpxeFVVNklMNWJtdk5CVmVxb3AxVzl4OWVaS244SVZuUlUvS2Ra?=
 =?utf-8?B?VG40NXNMZ1hVcTNQTHo5eXZGV1ozSkRZcnF0aThvOUo3aGQzSkFXc2lKbUJv?=
 =?utf-8?B?UGFEOUlUM3dwL0gxekpCSC9YTnJYaEl0SWdmS2R5YzJydG9ZQmUxc3ZwWnFB?=
 =?utf-8?B?enVzSHNMQk9GZmh3ZHJVVUExbm1nQjB0M01lbTdxU1J4K2NQRE9RT2R5MHQ3?=
 =?utf-8?B?ZllNZEhzQ3cvb1BZbTJod3I0V1R0amt2S08wWUUvMlc4bW40SnVxSnVLTnlS?=
 =?utf-8?B?NTdReDM0enlITXZ1OE1MVytHakVzNFVxTGliUVVkZEsvNExmYUJ3VytzcEFr?=
 =?utf-8?B?WTRlNUl5SHJmM2dxV21kWU05RExXU2pQSllMbVdEaVcrM25EVVFCWWVjRFJG?=
 =?utf-8?B?UjVWNHl5bWFvTUR1VGkzSUpZWUFyYVE1OG5OVW1aTnNwTk9FRlFLM3dlbVVJ?=
 =?utf-8?B?K1hmV0FxYllkQzFzKzFSZnFtcWF6NjlReWZXaXBobkIxMlZIVERXQ1EwVVFj?=
 =?utf-8?B?Z3JibFg0elNKSUJlT25keFBSQUtpUlJNMFJEM0RROWFEZkc1U2h3Q1VnM3ln?=
 =?utf-8?B?QWNHb0E1MEgwRFZtTVBjRjNrVlVST2tKNC8vaUFVTGNQRDZ0eWF5UnpUTDM2?=
 =?utf-8?B?cDhPSmZPck45Vm1UaFc1THM5cS9ZUGtKOVJzRXFxZVk0R3VSdHlBelNxMFdt?=
 =?utf-8?B?OEYzeERaSXg5MWYzdDhIaENHOEc0enAzN2RKelQvQjZFdkFrN1B3ak8rTFN2?=
 =?utf-8?B?amxmcUpmaWtpNjFIRmJXamViUWZKMW9Fa0lyVDcvR3NjeEhJUVNvN1Y5Z24r?=
 =?utf-8?B?b09RWisyVjBsRFZYdmFTU05ERnoyWEEzL1pXQUZxTFZMZEMydElWTE95Y0Vl?=
 =?utf-8?B?K09GS1lKVWJoejliaTFYVVRRL2IxczNjcWFOZDQyMUpYUEtjSkF2dnRpdEFP?=
 =?utf-8?B?dTRrNjl6TmZIZG52YTBFYWhpV3NObGhIVzdodG9QOURFRG5ROXkrcFZLVW9K?=
 =?utf-8?B?NWtMY3Z4bUF3MDJFTUNnMVpxSEFwcEVGQVpIZTRKYnRldG4vMmoyVTR5aytG?=
 =?utf-8?B?K1JxOU0xRmxrTmFrZ0hkTE9OU09qSStCSWQrVzQ5UzFNajk1ZjBhYnZhRzQ1?=
 =?utf-8?B?RU82bVcrK0UvbElwYXQ1dmhLbWdmM01iQnA4R3YzWW9xUVBvcTZmTDVUdGNX?=
 =?utf-8?B?TG5ZQ0RzUmZCZGdNOVF5dHJoZndPVXZJdUoxT3duUXhSYlY4OXZsQXdOd2Jy?=
 =?utf-8?B?R25aNzdRaG04bjlyakZiOW1Xa0pFMERHbC9oN2F4UzNnaFQrWnFhS3QyK2Vy?=
 =?utf-8?B?eHI2YWV6Q1MreCtWQlRCZXFEd3pOUmtuUGNqcjBtRThGOHRqUEtjaEZlOGVX?=
 =?utf-8?B?WkhiUzNpSS9lVjNnOWVSMEN4eGpFT2xOMVZYWlJObG5jbFBlSm02UmpqN2ps?=
 =?utf-8?B?WEIxdEh4OCs2YXo0R0ZkU0toYzVXbzNiSE5nKzlWUmM1eEhVN1cyZ2hXYW1O?=
 =?utf-8?B?MjhldGNkZ3hzUldSTFdsVll4eGFlalZhbklPekkxZ0hBWnZUS01qRFE1N1Ey?=
 =?utf-8?Q?FMbjblgXuUvz1+UXNDfrJm3H1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac73411-d90f-4f08-5334-08db02958ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 07:42:30.4668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MEz92tvdV56+S7WmOK/sVWFV7D7RBBAQfNyWvGW2lFXa7snoNbKrDiRXOmRMTlebHIQ9aBfaMYasDE0bhFdUb1kQl/2ZqflvHXVk65tmBuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6938
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

IE9uIFRodSwgMjAyMy0wMS0yNiBhdCAxMzoyOCArMDAwMCwgUmVzaGV0b3ZhLCBFbGVuYSB3cm90
ZToNCj4gPiA+IE9uIFRodSwgSmFuIDI2LCAyMDIzIGF0IDExOjI5OjIwQU0gKzAwMDAsIFJlc2hl
dG92YSwgRWxlbmEgd3JvdGU6DQo+ID4gPiA+ID4gT24gV2VkLCBKYW4gMjUsIDIwMjMgYXQgMDM6
Mjk6MDdQTSArMDAwMCwgUmVzaGV0b3ZhLCBFbGVuYQ0KPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4g
PiA+ID4gUmVwbHlpbmcgb25seSB0byB0aGUgbm90LXNvLWZhciBhZGRyZXNzZWQgcG9pbnRzLg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gT24gV2VkLCBKYW4gMjUsIDIwMjMgYXQgMTI6Mjg6
MTNQTSArMDAwMCwgUmVzaGV0b3ZhLCBFbGVuYQ0KPiA+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+
ID4gPiA+ID4gPiBIaSBHcmVnLA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPC4uLj4NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gPiA+IDMpIEFsbCB0aGUgdG9vbHMgYXJlIG9wZW4tc291cmNlIGFuZCBl
dmVyeW9uZSBjYW4gc3RhcnQNCj4gPiA+ID4gPiA+ID4gPiB1c2luZyB0aGVtIHJpZ2h0IGF3YXkg
ZXZlbiB3aXRob3V0IGFueSBzcGVjaWFsIEhXIChyZWFkbWUNCj4gPiA+ID4gPiA+ID4gPiBoYXMg
ZGVzY3JpcHRpb24gb2Ygd2hhdCBpcyBuZWVkZWQpLg0KPiA+ID4gPiA+ID4gPiA+IFRvb2xzIGFu
ZCBkb2N1bWVudGF0aW9uIGlzIGhlcmU6DQo+ID4gPiA+ID4gPiA+ID4gaHR0cHM6Ly9naXRodWIu
Y29tL2ludGVsL2NjYy1saW51eC1ndWVzdC1oYXJkZW5pbmcNCj4gPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+ID4gQWdhaW4sIGFzIG91ciBkb2N1bWVudGF0aW9uIHN0YXRlcywgd2hlbiB5b3Ugc3Vi
bWl0IHBhdGNoZXMNCj4gPiA+ID4gPiA+ID4gYmFzZWQgb24gdGhlc2UgdG9vbHMsIHlvdSBIQVZF
IFRPIGRvY3VtZW50IHRoYXQuwqAgT3RoZXJ3aXNlDQo+ID4gPiA+ID4gPiA+IHdlIHRoaW5rIHlv
dSBhbGwgYXJlIGNyYXp5IGFuZCB3aWxsIGdldCB5b3VyIHBhdGNoZXMNCj4gPiA+ID4gPiA+ID4g
cmVqZWN0ZWQuwqAgWW91IGFsbCBrbm93IHRoaXMsIHdoeSBpZ25vcmUgaXQ/DQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gU29ycnksIEkgZGlkbuKAmXQga25vdyB0aGF0IGZvciBldmVyeSBidWcg
dGhhdCBpcyBmb3VuZCBpbg0KPiA+ID4gPiA+ID4gbGludXgga2VybmVsIHdoZW4gd2UgYXJlIHN1
Ym1pdHRpbmcgYSBmaXggdGhhdCB3ZSBoYXZlIHRvDQo+ID4gPiA+ID4gPiBsaXN0IHRoZSB3YXkg
aG93IGl0IGhhcyBiZWVuIGZvdW5kLiBXZSB3aWxsIGZpeCB0aGlzIGluIHRoZQ0KPiA+ID4gPiA+
ID4gZnV0dXJlIHN1Ym1pc3Npb25zLCBidXQgc29tZSBidWdzIHdlIGhhdmUgYXJlIGZvdW5kIGJ5
DQo+ID4gPiA+ID4gPiBwbGFpbiBjb2RlIGF1ZGl0LCBzbyAnaHVtYW4nIGlzIHRoZSB0b29sLg0K
PiA+ID4gPiA+IE15IHByb2JsZW0gd2l0aCB0aGF0IHN0YXRlbWVudCBpcyB0aGF0IGJ5IGFwcGx5
aW5nIGRpZmZlcmVudA0KPiA+ID4gPiA+IHRocmVhdCBtb2RlbCB5b3UgImludmVudCIgYnVncyB3
aGljaCBkaWRuJ3QgZXhpc3QgaW4gYSBmaXJzdA0KPiA+ID4gPiA+IHBsYWNlLg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gRm9yIGV4YW1wbGUsIGluIHRoaXMgWzFdIGxhdGVzdCBzdWJtaXNzaW9uLCBh
dXRob3JzIGxhYmVsZWQNCj4gPiA+ID4gPiBjb3JyZWN0IGJlaGF2aW91ciBhcyAiYnVnIi4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAx
MTkxNzA2MzMuNDA5NDQtMS0NCj4gPiA+ID4gPiBhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50
ZWwuY29tLw0KPiA+ID4gPg0KPiA+ID4gPiBIbS4uIERvZXMgZXZlcnlvbmUgdGhpbmsgdGhhdCB3
aGVuIGtlcm5lbCBkaWVzIHdpdGggdW5oYW5kbGVkDQo+ID4gPiA+IHBhZ2UgZmF1bHQgKHN1Y2gg
YXMgaW4gdGhhdCBjYXNlKSBvciBkZXRlY3Rpb24gb2YgYSBLQVNBTiBvdXQgb2YNCj4gPiA+ID4g
Ym91bmRzIHZpb2xhdGlvbiAoYXMgaXQgaXMgaW4gc29tZSBvdGhlciBjYXNlcyB3ZSBhbHJlYWR5
IGhhdmUNCj4gPiA+ID4gZml4ZXMgb3IgaW52ZXN0aWdhdGluZykgaXQgcmVwcmVzZW50cyBhIGNv
cnJlY3QgYmVoYXZpb3IgZXZlbiBpZg0KPiA+ID4gPiB5b3UgZXhwZWN0IHRoYXQgYWxsIHlvdXIg
cGNpIEhXIGRldmljZXMgYXJlIHRydXN0ZWQ/DQo+ID4gPg0KPiA+ID4gVGhpcyBpcyBleGFjdGx5
IHdoYXQgSSBzYWlkLiBZb3UgcHJlc2VudGVkIG1lIHRoZSBjYXNlcyB3aGljaCBleGlzdA0KPiA+
ID4gaW4geW91ciBpbnZlbnRlZCB3b3JsZC4gTWVudGlvbmVkIHVuaGFuZGxlZCBwYWdlIGZhdWx0
IGRvZXNuJ3QNCj4gPiA+IGV4aXN0IGluIHJlYWwgd29ybGQuIElmIFBDSSBkZXZpY2UgZG9lc24n
dCB3b3JrLCBpdCBuZWVkcyB0byBiZQ0KPiA+ID4gcmVwbGFjZWQvYmxvY2tlZCBhbmQgbm90IGxl
ZnQgdG8gYmUgb3BlcmFibGUgYW5kIGFjY2Vzc2libGUgZnJvbQ0KPiA+ID4gdGhlIGtlcm5lbC91
c2VyLg0KPiA+DQo+ID4gQ2FuIHdlIHJlYWxseSBhc3N1cmUgY29ycmVjdCBvcGVyYXRpb24gb2Yg
KmFsbCogcGNpIGRldmljZXMgb3V0DQo+ID4gdGhlcmU/IEhvdyB3b3VsZCBzdWNoIGFuIGF1ZGl0
IGJlIHBlcmZvcm1lZCBnaXZlbiBhIGh1Z2Ugc2V0IG9mIHRoZW0NCj4gPiBhdmFpbGFibGU/IElz
bnQgaXQgYmV0dGVyIGluc3RlYWQgdG8gbWFrZSBhIHNtYWxsIGZpeCBpbiB0aGUga2VybmVsDQo+
ID4gYmVoYXZpb3IgdGhhdCB3b3VsZCBndWFyZCB1cyBmcm9tIHN1Y2ggcG90ZW50aWFsbHkgbm90
IGNvcnJlY3RseQ0KPiA+IG9wZXJhdGluZyBkZXZpY2VzPw0KPiANCj4gSSB0aGluayB0aGlzIGlz
IHJlYWxseSB0aGUgd3JvbmcgcXVlc3Rpb24gZnJvbSB0aGUgY29uZmlkZW50aWFsDQo+IGNvbXB1
dGluZyAoQ0MpIHBvaW50IG9mIHZpZXcuICBUaGUgcXVlc3Rpb24gc2hvdWxkbid0IGJlIGFib3V0
IGFzc3VyaW5nDQo+IHRoYXQgdGhlIFBDSSBkZXZpY2UgaXMgb3BlcmF0aW5nIGNvbXBsZXRlbHkg
Y29ycmVjdGx5IGFsbCB0aGUgdGltZSAoZm9yDQo+IHNvbWUgdmFsdWUgb2YgY29ycmVjdCkuICBJ
dCdzIGlmIGl0IHdlcmUgcHJvZ3JhbW1lZCB0byBiZSBtYWxpY2lvdXMNCj4gd2hhdCBjb3VsZCBp
dCBkbyB0byB1cz8gIA0KDQpTdXJlLCBidXQgTGVvbiBkaWRu4oCZdCBhZ3JlZSB3aXRoIENDIHRo
cmVhdCBtb2RlbCB0byBiZWdpbiB3aXRoLCBzbyANCkkgd2FzIHRyeWluZyB0byBhcmd1ZSBoZXJl
IGhvdyB0aGlzIGZpeCBjYW4gYmUgdXNlZnVsIGZvciBub24tQ0MgdGhyZWF0IA0KbW9kZWwgY2Fz
ZS4gQnV0IG9idmlvdXNseSBteSBhcmd1bWVudCBmb3Igbm9uLUNDIGNhc2Ugd2Fzbid0IGdvb2Qg
KA0KZXNwZWNpYWxseSByZWFkaW5nIFRlZCdzIHJlcGx5IGhlcmUgDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvWTlMb253OUh6bG9zVVBuU0BtaXQuZWR1LyApLCBzbyBJIGJldHRlcg0Kc3Rp
Y2sgdG8gQ0MgdGhyZWF0IG1vZGVsIGNhc2UgaW5kZWVkLiANCg0KPklmIHdlIHRha2UgYWxsIERv
UyBhbmQgQ3Jhc2ggb3V0Y29tZXMgb2ZmIHRoZQ0KPiB0YWJsZSAoYW5ub3lpbmcgYnV0IGhhcm1s
ZXNzIGlmIHRoZXkgZG9uJ3QgcmV2ZWFsIHRoZSBjb25maWRlbnRpYWwNCj4gY29udGVudHMpLCB3
ZSdyZSBsZWZ0IHdpdGggaXQgdHJ5aW5nIHRvIGV4dHJhY3Qgc2VjcmV0cyBmcm9tIHRoZQ0KPiBj
b25maWRlbnRpYWwgZW52aXJvbm1lbnQuDQoNClllcywgdGhpcyBpcyB0aGUgdWx0aW1hdGUgZW5k
IGdvYWwuIA0KDQo+IA0KPiBUaGUgYmlnIHRocmVhdCBmcm9tIG1vc3QgZGV2aWNlcyAoaW5jbHVk
aW5nIHRoZSB0aHVuZGVyYm9sdCBjbGFzc2VzKSBpcw0KPiB0aGF0IHRoZXkgY2FuIERNQSBhbGwg
b3ZlciBtZW1vcnkuICBIb3dldmVyLCB0aGlzIGlzbid0IHJlYWxseSBhIHRocmVhdA0KPiBpbiBD
QyAod2VsbCB1bnRpbCBQQ0kgYmVjb21lcyBhYmxlIHRvIGRvIGVuY3J5cHRlZCBETUEpIGJlY2F1
c2UgdGhlDQo+IGRldmljZSBoYXMgc3BlY2lmaWMgdW5lbmNyeXB0ZWQgYnVmZmVycyBzZXQgYXNp
ZGUgZm9yIHRoZSBleHBlY3RlZCBETUEuDQo+IElmIGl0IHdyaXRlcyBvdXRzaWRlIHRoYXQgQ0Mg
aW50ZWdyaXR5IHdpbGwgZGV0ZWN0IGl0IGFuZCBpZiBpdCByZWFkcw0KPiBvdXRzaWRlIHRoYXQg
aXQgZ2V0cyB1bmludGVsbGlnaWJsZSBjaXBoZXJ0ZXh0LiAgU28gd2UncmUgbGVmdCB3aXRoIHRo
ZQ0KPiBkZXZpY2UgdHJ5aW5nIHRvIHRyaWNrIHNlY3JldHMgb3V0IG9mIHVzIGJ5IHJldHVybmlu
ZyB1bmV4cGVjdGVkIGRhdGEuDQoNClllcywgYnkgc3VwcGx5aW5nIHRoZSBpbnB1dCB0aGF0IGhh
c27igJl0IGJlZW4gZXhwZWN0ZWQuIFRoaXMgaXMgZXhhY3RseSANCnRoZSBjYXNlIHdlIHdlcmUg
dHJ5aW5nIHRvIGZpeCBoZXJlIGZvciBleGFtcGxlOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjMwMTE5MTcwNjMzLjQwOTQ0LTItYWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVs
LmNvbS8NCkkgZG8gYWdyZWUgdGhhdCB0aGlzIGNhc2UgaXMgbGVzcyBzZXZlcmUgd2hlbiBvdGhl
cnMgd2hlcmUgbWVtb3J5DQpjb3JydXB0aW9uL2J1ZmZlciBvdmVycnVuIGNhbiBoYXBwZW4sIGxp
a2UgaGVyZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDExOTEzNTcyMS44MzM0
NS02LWFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20vDQpCdXQgd2UgYXJlIHRyeWlu
ZyB0byBmaXggYWxsIGlzc3VlcyB3ZSBzZWUgbm93IChwcmlvcml0aXppbmcgdGhlIHNlY29uZCBv
bmVzDQp0aG91Z2gpLiANCg0KPiANCj4gSWYgSSBzZXQgdGhpcyBhcyB0aGUgcHJvYmxlbSwgdmVy
aWZ5aW5nIGRldmljZSBjb3JyZWN0IG9wZXJhdGlvbiBpcyBhDQo+IHBvc3NpYmxlIHNvbHV0aW9u
IChhbGJlaXQgaHVnZWx5IGV4cGVuc2l2ZSkgYnV0IHRoZXJlIGFyZSBsaWtlbHkgbWFueQ0KPiBv
dGhlciBjaGVhcGVyIHdheXMgdG8gZGVmZWF0IG9yIGRldGVjdCBhIGRldmljZSB0cnlpbmcgdG8g
dHJpY2sgdXMgaW50bw0KPiByZXZlYWxpbmcgc29tZXRoaW5nLg0KDQpXaGF0IGRvIHlvdSBoYXZl
IGluIG1pbmQgaGVyZSBmb3IgdGhlIGFjdHVhbCBkZXZpY2VzIHdlIG5lZWQgdG8gZW5hYmxlIGZv
ciBDQyBjYXNlcz8NCldlIGhhdmUgYmVlbiB1c2luZyBoZXJlIGEgY29tYmluYXRpb24gb2YgZXh0
ZW5zaXZlIGZ1enppbmcgYW5kIHN0YXRpYyBjb2RlIGFuYWx5c2lzLg0KDQpCZXN0IFJlZ2FyZHMs
DQpFbGVuYS4NCg0KDQo=
