Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E2C6F0606
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbjD0MnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243913AbjD0MnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:43:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6E130E8;
        Thu, 27 Apr 2023 05:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682599389; x=1714135389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sn7uNteRARM5j4ml5JOHSjx9EJJFt0ioUIb5mihuBRU=;
  b=B668w6Udj3d3BJ+y8Td3tt7v8HDjq1xzU18aYF91PTv0fpCeEfunB7sz
   DPmKqOY8cV0QRRyOwe67hbLfNSzc7gPsHPZAImu/dUc69Ysn1OBgkq23S
   bYfsq0NtXX/ZxKtR/erqHX1TWMJO4k0+F+PqceKtFjkEG5SZOsiSc9qns
   YP79tkSurSC4grRrsL8twgNHCqrfmJfq6I/vgd3eqHmLxpVOVdvpQLIZV
   b/2a0Vvo21tDUXj25G+r7jw2uNj+D9a4JGzfdTMQ/jo5BkVgR0DAm8+OR
   qaRyJZW6pQQ5mHctmybFHl7GSSZsb/tYrRROvGy90OwIeIaKIUzedEaVW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="344874251"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="344874251"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 05:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="644680957"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="644680957"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 27 Apr 2023 05:43:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 05:43:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 05:43:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 05:43:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjhKS8/O2sTeXHoeyyBh3aDL3mB+tKkBnN5cIHSTMWGw6eA8zCqqd+NUNYFQptdKgmcsmEQ8NCSUkyh94nt0GTZwFnt1xFEoMjukDAIcSr2suVnWKT7RIRtn3CHVge7vAg3mXIZORfSCh3CsndOKlcbv7J7uZ/l7pXZYt/rY/PV/CzXTM1bIS1R76iFQYjE8IAUxoqSoy7kTAGLbAf9boQAnlV40Lfg+yPE/urzaMWCSUcXDpUrg+t9+hMJlY97hptWdBsHFH/bWzWvRqACDR6jCM7YkwVNLIm8t3ESs4+gpd+ynSywg+uUClPojga6Crdkwk+vb9fyrEBdBNiJ9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sn7uNteRARM5j4ml5JOHSjx9EJJFt0ioUIb5mihuBRU=;
 b=kOB7vUasP7nAU1KhjF84s9XH6RWDn5n3GMnoGWKWpUQGKAhQLXU0U8pW1q4Jw5j1qDrjYttk93ysKSwDKtk/r3kkwsPnQ9paZVwepx4ow21CqPLko7H08+F33KIqruVAHYQhnQ+RaUytZ/wUIxrpFfjexRBd9bzZDS16zm6xI8z+bVbWUz9UoKmtZTzo6/HnX35jrP37I4ogUu632IjubjY+tO51W3LqpS1DQ4gyI0E7nyQkN9fyx94g16V1j577J9bYbhqOMXP9AjrwRwYmrCW7r7dJcX5FP21d7q+uVN5RN1dAO8T/UDfKHbwtYGI5fdregMwXIbOOoXlgDW61Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 BN9PR11MB5274.namprd11.prod.outlook.com (2603:10b6:408:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 12:43:05 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::65f0:6a4e:8aac:3e3e]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::65f0:6a4e:8aac:3e3e%2]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 12:43:05 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        James Bottomley <jejb@linux.ibm.com>
CC:     Carlos Bilbao <carlos.bilbao@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>
Subject: RE: [PATCH] docs: security: Confidential computing intro and threat
 model
Thread-Topic: [PATCH] docs: security: Confidential computing intro and threat
 model
Thread-Index: AQHZYLcIL5h5EiW/WUeIdC3dxCgzQa88TIUAgAFu+xCAACeogIAAEHyAgAFTKpA=
Date:   Thu, 27 Apr 2023 12:43:05 +0000
Message-ID: <DM8PR11MB57509EBCB1E2146C1768A6EEE76A9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com>
 <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
 <7502e1af0615c08167076ff452fc69ebf316c730.camel@linux.ibm.com>
 <ZElOfzn37kmesy7e@google.com>
In-Reply-To: <ZElOfzn37kmesy7e@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|BN9PR11MB5274:EE_
x-ms-office365-filtering-correlation-id: 33d6f87e-e2a5-4770-ed8c-08db471cf25e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ioqmJTwVUn8jknJ8MR76fv5RnQId49JmX/3ANf6qwq2VrpC4zy6WaTA9elgR5wfOdyNc65nV5PYJDHcp9mOBpBdc34fn3oeP3mz7Ka1RivRcGHVnqJG1WwzED37Psl1zLRKaRt3mhKn9FktwY74/li6yfw0v60d0RYR0WPjHJNmYWt6XSyL3TcKbL5davk4laJqZfIQiuFUqqVK4OXqIo4AFHVOi+NlrDvsVKfGvurrXCvJcZRtL78QbwDVc4zzD2jNamnlb6E/AqI2PMZgddWvZhAOEOra4rS8fzw+/B+O1c4KgXfZFhIFang117j0fgPxS7nLG60tynuGgBl78JxIHpxizuXWD3M4V0wd33kBSvaWjrC3Z95sEv7G8ASqJjFnectpVxjdq1TtXqfUQ8o2x74kjplYG40r8k9d5Iv8ylB21WVYCF0ONv5BDEqB3i1iH4wzv01PBgPaQk1NDMjVeLPky0ORz8OlzYfRxEFqpj8oLRbpBfr7lRbYHV/5PAQwCBWnnAETANCQZlyF2MjZmeM+wRA69iPNSCJd66Xo9Ignmqh5LfOdBLFaGY8K1wvmLV5fSRGqBQE2GAIN2IZ32hVCZQn0393OMkd1fjgsr0VVVMa8tLSmbCtwuX6cN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(478600001)(186003)(110136005)(54906003)(26005)(71200400001)(6506007)(7696005)(15650500001)(9686003)(2906002)(66446008)(66476007)(8676002)(122000001)(66556008)(7406005)(66946007)(52536014)(76116006)(5660300002)(8936002)(4326008)(7416002)(38100700002)(55016003)(82960400001)(41300700001)(64756008)(316002)(86362001)(38070700005)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHl5ZENSQURFaURkdWdoYTlCK1hNMjRPU1VySzJGYlB3aXFjMEFwUDJzSWtH?=
 =?utf-8?B?MU5VYkdrVDc2MGUvbnEvVVNjOVdzbjlIa0J6YnJ3L0lLQ2J1amlMREkzOXlT?=
 =?utf-8?B?a2xDRitMWXNOVmpaWEpLdHd6V0pxTzAwbWVIdXg2VTN1RngyWm4xRm5QcHYx?=
 =?utf-8?B?SU9uTWNxQ09pcUlEeFZ2VGZqZFVmYi9meWxrdHBwVjVVTGxZTG9hUnNTUW1M?=
 =?utf-8?B?QnBYS25lWXpwbzZIM3Rva0VUc2czZVpSRHJJT1plVnp6TkM0WjA2MFowL1No?=
 =?utf-8?B?UFIybEhEY3lJY3dKazY4WmZ0NGZPUzlyQ2tnVjA1RHpXVnJWeCsvaG5ocWhT?=
 =?utf-8?B?cmhYNFQ1cTJKUTV6U3JrTGJ5bTFhK2VjQmVIMXl4eVpNOTVVbEk0RmwwNmFT?=
 =?utf-8?B?OVNFSGdWZ292dTUwVzMxanU1clFqZjJNYmZJQWZ2Sno4MncyUzhnRzRjVUZx?=
 =?utf-8?B?T0pDM1hYSExhWVNhYjJ0Wk00eVhIYkJ6R1hqV0ZNNytzb0hJem1vbzlibXJG?=
 =?utf-8?B?NlpjdmVzMndvamVYbGd2UTdEUmVDMjFhVTJnSUQ3RFBrNW5GdTVhRkE3OUtB?=
 =?utf-8?B?NWljVmxOaWtiS1pXRzlhSll2UUx0RlgwNnNVNTR6a3lFUFBVUUJteVloOTNk?=
 =?utf-8?B?L2l4Q2tTaGhjcWxhZTZRcm1Ta0JUN2FBR1BxQXpqWDcxSjVOS2ZINGZkako5?=
 =?utf-8?B?SE1TdU54WjJFWDZPYnVWN3pDb212QkxhYWQwZXFaUnFrcyt0eHZZRDZlRDNN?=
 =?utf-8?B?M29DZlIyakdyaVUySlRNbW1wMHQ0bFlhdS91U281aS9aQkU5MElpYnQ4UTR4?=
 =?utf-8?B?aHgxY09QWVJlYWpkY3RQWE80TkZlTVl3V2p1ZFhMb1BIOGhmTTZxZW5sM1dj?=
 =?utf-8?B?MExuWHBlRCt2MkFzUjIvMUhYT1VWSVhUM2FXakxHOE1CUnR0UE1jVVJrbCta?=
 =?utf-8?B?WkpERGdhem5HbjhiQjkvQUl1TklDMEVpZCtTd1JrVnVTdHpBR3VISmNQK3l5?=
 =?utf-8?B?VUtjRXI1Rk1ObGl2b0d3YVVzdTZQZU1zSHBCd1gwQ2sxS3JtaityUm9IZHJS?=
 =?utf-8?B?dGZVMlJYTlcxc0FCVG1PajM4Nk81M05DVW5zaDFMbXdHbVV1OEMwSnl4bU9y?=
 =?utf-8?B?Tit2NVRtSmFSTFRuQnlnOXJEVUlzMGRGMTB4VGJDVmlkMHJrcjR5b0NqVjZj?=
 =?utf-8?B?L0l2L2wrNUM2czhwVm9IYkZjZUJQU1pqSjFjekFzc2hMM0xJU3pwTzlXQzZJ?=
 =?utf-8?B?NXdobXJjNWNMMFVKR2E5N0IrM3ltV2NjWG9VZ3dpckxNVkQ4WFEwQ1ZVZmk3?=
 =?utf-8?B?OG13UGhYNDh0Ykpvc1l0SXZmN010dUxsRS80aElhQUUzQ0U5TGlzNlFiUzAy?=
 =?utf-8?B?bHRzZ2dTWGNJMEZkNExTcERkbkwzMzVvRjk3Yk9sbEo2K1JmZ2lHWnBJZUk3?=
 =?utf-8?B?dXE3TW1Ya0V4TlJud0R3OTBkU1d2UlpQQ3JZeXlOUG4zNWgvVXBubDVaOVFG?=
 =?utf-8?B?ODg3MXZZMkJJZUFVM1ZRMk5hNmxXMmZCMjZZL2xod3BKcFBhRllRT3l4ZXAx?=
 =?utf-8?B?Z29ibVhTRlNuSHNtV2lyUjNHZUhwaCtpMkNuRldGL2I5ZGZIYVBTbk1PRGpo?=
 =?utf-8?B?UXh1bGMwWlpOQXVVNnFqdU9Cd2VGa05jRGtzWlJWMU0yMCtvNTl3R2lldml5?=
 =?utf-8?B?dk13aHhTMWJ4MkZaZkxFa2hmV3J0WkZDV2tiTTlyNlJSZUFuNE1vK201aFBh?=
 =?utf-8?B?cVFPelozNXBUbHRxdFExUG14azFVM0x4MG1mcGhtL0Jya2VudlI4Ly9hZElt?=
 =?utf-8?B?NEtQNk9PUzZtZ2N4YU1RcVZ0VUk1NFZTZWMrc3lZbGxrMGlwMVQyQmxWNloz?=
 =?utf-8?B?QlVuYytTek9adHVNaWlEQlJTNUcwWE9OcjFHZVVYSzRPK3NSTHVvMVR2OU5Y?=
 =?utf-8?B?Q0lmK0ViYXgwRUNxRGE3blZ0RWdHbjBEM3FoNDhvME1uNkpWN0Njb2UvNERu?=
 =?utf-8?B?dXQzdUFlV29va0JHMGVhL1VnSy9MNmFzL1A5aTE5MEdmYXlCVXluS0k4NDlQ?=
 =?utf-8?B?dmNURVA3T1F5SkhSeHg2LzJUdkE4dnJkajFzNGNCajhISUdqRjRpSGZIeXV0?=
 =?utf-8?Q?r5AuYkvmYVfA03c6iCNCWuIAe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d6f87e-e2a5-4770-ed8c-08db471cf25e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 12:43:05.3404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6iHPQTVBwN00SGWkSt8qeQ/keU8zkx3GpUPZb9hhZTgGXLtI5jCNyLReEPYvruhTD7g13T3itvq6WYQi/PVtNhEzN0a4ZH/337C45EZrgec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5274
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIFdlZCwgQXByIDI2LCAyMDIzLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6DQo+ID4gT24g
V2VkLCAyMDIzLTA0LTI2IGF0IDEzOjMyICswMDAwLCBSZXNoZXRvdmEsIEVsZW5hIHdyb3RlOg0K
PiA+ID4gPiBPbiBNb24sIE1hciAyNywgMjAyMywgQ2FybG9zIEJpbGJhbyB3cm90ZToNCj4gPiBb
Li4uXQ0KPiA+ID4gPiA+ICtwcm92aWRlIHN0cm9uZ2VyIHNlY3VyaXR5IGd1YXJhbnRlZXMgdG8g
dGhlaXIgY2xpZW50cyAodXN1YWxseQ0KPiA+ID4gPiA+IHJlZmVycmVkIHRvICthcyB0ZW5hbnRz
KSBieSBleGNsdWRpbmcgYWxsIHRoZSBDU1Ancw0KPiA+ID4gPiA+IGluZnJhc3RydWN0dXJlIGFu
ZCBTVyBvdXQgb2YgdGhlICt0ZW5hbnQncyBUcnVzdGVkIENvbXB1dGluZyBCYXNlDQo+ID4gPiA+
ID4gKFRDQikuDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgaXMgaW5hY2N1cmF0ZSwgdGhlIHByb3Zp
ZGVyIG1heSBzdGlsbCBoYXZlIHNvZnR3YXJlIGFuZC9vcg0KPiA+ID4gPiBoYXJkd2FyZSBpbiB0
aGUgVENCLg0KPiA+ID4NCj4gPiA+IFdlbGwsIHRoaXMgaXMgdGhlIGVuZCBnb2FsIHdoZXJlIHdl
IHdhbnQgdG8gYmUsDQo+IA0KPiBJZiBieSAid2UiIHlvdSBtZWFuIEludGVsIGFuZCBBTUQsIHRo
ZW4geWVzLCB0aGF0IGlzIHByb2JhYmx5IGEgdHJ1ZSBzdGF0ZW1lbnQuDQo+IEJ1dCB0aG9zZSBn
b2FscyBoYXZlIG5vdGhpbmcgdG8gZG8gd2l0aCBzZWN1cml0eS4NCg0KSSBkaXNhZ3JlZSBmcm9t
IHB1cmUgc2VjdXJpdHkgcG9pbnQgb2Ygdmlldywgc2VlIGJlbG93LiANCg0KPiANCj4gPiA+IHRo
ZSBwcmFjdGljYWwgZGVwbG95bWVudCBjYW4gZGlmZmVyIG9mIGNvdXJzZS4gV2UgY2FuIHJlcGhy
YXNlIHRoYXQgaXQNCj4gPiA+ICJhbGxvd3MgdG8gZXhjbHVkZSBhbGwgdGhlIENTUCdzIGluZnJh
c3RydWN0dXJlIGFuZCBTVyBvdXQgb2YgdGVuYW50J3MNCj4gPiA+IFRDQi4iDQo+ID4NCj4gPiBU
aGF0J3MgZ2V0dGluZyBldmVuIG1vcmUgaW5hY2N1cmF0ZS4gIFRvIHJ1biAgaW4gYSBDbG91ZCB3
aXRoIENvQ28geW91DQo+ID4gdXN1YWxseSBoYXZlIHRvIGluc2VydCBzb21lIHByb3ZpZGVkIGNv
ZGUsIGxpa2UgT1ZNRiBhbmQsIGZvciBBTUQsIHRoZQ0KPiA+IFNWU00uICBUaGVzZSBhcmUgb2Z0
ZW4gY3VzdG9taXplZCBieSB0aGUgQ1NQIHRvIHN1aXQgdGhlIGNsb3VkDQo+ID4gaW5mcmFzdHJ1
Y3R1cmUsIHNvIHlvdSdyZSBydW5uaW5nIHRoZWlyIGNvZGUuICBUaGUgZ29hbCwgSSB0aGluaywg
aXMgdG8NCj4gPiBtYWtlIHN1cmUgeW91IG9ubHkgcnVuIGNvZGUgeW91IHRydXN0IChzb21lIG9m
IHdoaWNoIG1heSBjb21lIGZyb20gdGhlDQo+ID4gQ1NQKSBpbiB5b3VyIFRDQiwgd2hpY2ggaXMg
dmVyeSBkaWZmZXJlbnQgZnJvbSB0aGUgc3RhdGVtZW50IGFib3ZlLg0KPiANCj4gWWVzLiAgQW5k
IHRha2luZyB0aGluZ3MgYSBzdGVwIGZ1cnRoZXIsIGlmIHdlIHdlcmUgdG8gYXNrIHNlY3VyaXR5
IGNvbmNpb3VzIHVzZXJzDQo+IHdoYXQgdGhleSB3b3VsZCBjaG9vc2UgdG8gaGF2ZSBpbiB0aGVp
ciBUQ0I6IChhKSBjbG9zZWQtc291cmNlIGZpcm13YXJlIHdyaXR0ZW4NCj4gYnkNCj4gYSBoYXJk
d2FyZSB2ZW5kb3IsIG9yIChiKSBvcGVuLXNvdXJjZSBzb2Z0d2FyZSB0aGF0IGlzIHByb3ZpZGVk
IGJ5IENTUHMsIEkgYW0NCj4gYmV0dGluZyB0aGUgb3ZlcndoZWxtaW5nIG1ham9yaXR5IHdvdWxk
IGNob29zZSAoYikuDQoNCkFzIEkgYWxyZWFkeSByZXBsaWVkIGluIG15IGVhcmxpZXIgbWVzc2Fn
ZSBmcm9tIHllc3RlcmRheSwgeWVzLCB0aGlzIGlzIHRoZSBjaG9pY2UNCnRoYXQgYW55b25lIGhh
cyBhbmQgaXQgaXMgZnJlZSB0byBtYWtlIHRoaXMgY2hvaWNlLiBObyBxdWVzdGlvbnMgYXNrZWQu
IA0KKEJ0dywgcGxlYXNlIG5vdGUgdGhhdCB0aGUgYWJvdmUgc3RhdGVtZW50IGlzIG5vdCAxMDAl
IGFjY3VyYXRlIHNpbmNlIHRoZSBzb3VyY2UNCmNvZGUgZm9yIGludGVsIFREWCBtb2R1bGUgaXMg
YXQgbGVhc3QgcHVibGljKS4gDQpIb3dldmVyLCBpZiBhcyB5b3Ugc2FpZCB0aGUgbWFqb3JpdHkg
Y2hvb3NlIChiKSwgd2h5IGRvIHRoZXkgbmVlZCB0byBlbmFibGUgdGhlDQpDb25maWRlbnRpYWwg
Y2xvdWQgY29tcHV0aW5nIHRlY2hub2xvZ2llcyBsaWtlIFREWCBvciBTRVYtU05QPyANCklmIHRo
ZXkgY2hvb3NlIChiKSwgdGhlbiB0aGUgd2hvbGUgdGhyZWF0IG1vZGVsIGRlc2NyaWJlZCBpbiB0
aGlzIGRvY3VtZW50IGRvIG5vdA0Kc2ltcGx5IGFwcGx5IHRvIHRoZW0gYW5kIHRoZXkgY2FuIGZv
cmdldCBhYm91dCBhbnl0aGluZyB0aGF0IHdlIHRyeSB0byBkZXNjcmliZSANCmhlcmUuIA0KDQpO
b3cgZnJvbSB0aGUgcHVyZSBzZWN1cml0eSBwb2ludCBvZiB2aWV3IHRoZSBjaG9pY2UgYmV0d2Vl
biAoYSkgYW5kIChiKSBpcyBub3Qgc28gZWFzaWx5DQpkb25lIGltby4gVXN1YWxseSB3ZSB0YWtl
IGludG8gYWNjb3VudCBtYW55IGZhY3RvcnMgdGhhdCBhZmZlY3QgdGhlIHJpc2svY2hhbmNlcw0K
dGhhdCBjZXJ0YWluIHBpZWNlIG9mIFNXIGhhcyBhIGhpZ2hlciByaXNrIG9mIGhhdmluZyB2dWxu
ZXJhYmlsaXRpZXMuIFRoaXMgaW5jbHVkZXMgdGhlDQpzaXplIG9mIHRoZSBjb2RlYmFzZSwgaXRz
IGNvbXBsZXhpdHksIGl0cyBhdHRhY2sgc3VyZmFjZSBleHBvc3VyZSB0b3dhcmRzIGV4dGVybmFs
DQppbnRlcmZhY2VzLCBsZXZlbCBvZiB0ZXN0aW5nLCB3aGVuZXZlciB0aGUgY29kZSBpcyBwdWJs
aWMsIGNvZGUgZGVwZW5kZW5jeSBjaGFpbnMsIGV0Yy4NClNtYWxsZXIgY29kZWJhc2Ugd2l0aCBu
byBkZXBlbmRlbmNpZXMgYW5kIHNtYWxsIHNldCBvZiBleHBvc2VkIGludGVyZmFjZXMgaXMgdXN1
YWxseQ0KZWFzaWVyIHRvIHJldmlldyBmcm9tIHNlY3VyaXR5IHBvaW50IG9mIHZpZXcgZ2l2ZW4g
dGhhdCB0aGUgY29kZSBpcyBwdWJsaWMuIA0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVuYS4NCg==
